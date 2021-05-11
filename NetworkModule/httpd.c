/*
 * Code file containing the HTTP Daemon module.
 * It supports GET (not completely implemented) and POST Request methods
 * 
 * Author: Simon Kueppers
 * Email: simon.kueppers@web.de
 * Homepage: http://klinkerstein.m-faq.de
 * 
 This program is free software: you can redistribute it and/or modify
 it under the terms of the GNU General Public License as published by
 the Free Software Foundation, either version 3 of the License, or
 (at your option) any later version.

 This program is distributed in the hope that it will be useful,
 but WITHOUT ANY WARRANTY; without even the implied warranty of
 MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 GNU General Public License for more details.

 You should have received a copy of the GNU General Public License
 along with this program.  If not, see <http://www.gnu.org/licenses/>.
 
 Copyright 2008 Simon Kueppers
 *
 */
  
/* Modifications 2020 Michael Nielson
 * Adapted for STM8S005 processor, ENC28J60 Ethernet Controller,
 * Web_Relay_Con V2.0 HW-584, and compilation with Cosmic tool set.
 * Author: Michael Nielson
 * Email: nielsonm.projects@gmail.com
 This program is free software: you can redistribute it and/or modify
 it under the terms of the GNU General Public License as published by
 the Free Software Foundation, either version 3 of the License, or
 (at your option) any later version.

 This program is distributed in the hope that it will be useful, but
 WITHOUT ANY WARRANTY; without even the implied warranty of
 MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
 General Public License for more details.

 See GNU General Public License at <http://www.gnu.org/licenses/>.
 
 Copyright 2020 Michael Nielson
*/



#include "httpd.h"
#include "uip.h"
#include "uip_arch.h"
#include "gpio.h"
#include "main.h"
#include "mqtt_pal.h"
#include "uipopt.h"
#include "uart.h"
#include "ds18b20.h"
#include "iostm8s005.h"

// #include "stdlib.h"
#include "string.h"
#include <ctype.h>

#define STATE_CONNECTED		0	// Client has just connected
#define STATE_GOTGET		1	// Client just sent a GET request
#define STATE_GOTPOST		2	// Client just sent a POST request
#define STATE_PARSEPOST		10	// We are currently parsing the
                                        // client's POST-data
#define STATE_SENDHEADER200	11	// Next we send the HTTP 200 header
#define STATE_SENDHEADER204	12	// Or we send the HTTP 204 header
#define STATE_SENDDATA		13	// ... followed by data
#define STATE_PARSEGET		14	// We are currently parsing the
                                        // client's GET-request
#define STATE_NULL		127     // Signals no fragment reassembly info
                                        // present

#define PARSE_CMD		0       // Parsing the command byte in a POST
#define PARSE_NUM10		1       // Parsing the most sig digit of POST
                                        // cmd
#define PARSE_NUM1		2       // Parsing the least sig digit of a
                                        // POST cmd
#define PARSE_EQUAL		3       // Parsing the equal sign of a POST
                                        // cmd
#define PARSE_VAL		4       // Parsing the data value of a POST
                                        // cmd
#define PARSE_DELIM		5       // Parsing the delimiter of a POST cmd
#define PARSE_SLASH1		6       // Parsing the slash of a GET cmd
#define PARSE_FAIL		7       // Indicates parse failure - no action
                                        // taken


#if DEBUG_SUPPORT != 0
// Variables used to store debug information
extern uint8_t *pBuffer2;
extern uint8_t debug[NUM_DEBUG_BYTES];
extern uint8_t stored_debug[NUM_DEBUG_BYTES];
#endif // DEBUG_SUPPORT

extern uint16_t Port_Httpd;               // Port number in use

extern uint8_t pin_control[16];           // Per pin configuration byte
extern uint16_t ON_OFF_word;              // ON/OFF states of pins in single 16
                                          // bit word
extern uint16_t Invert_word;              // Invert state of pins in single 16 bit
                                          // word

extern uint8_t Pending_hostaddr[4];       // Temp storage for new IP address
extern uint8_t Pending_draddr[4];         // Temp storage for new Gateway address
extern uint8_t Pending_netmask[4];        // Temp storage for new Netmask

extern uint16_t Pending_port;             // Temp storage for new Port number

extern uint8_t Pending_devicename[20];    // Temp storage for new Device Name

extern uint8_t Pending_config_settings;   // Temp storage for new Config
                                          // settings
					  
extern uint8_t Pending_pin_control[16];   // Temp storage for new pin_control
                                          // received from GUI

extern uint8_t Pending_uip_ethaddr_oct[6]; // Temp storage for new MAC address

extern uint8_t stored_hostaddr[4];	  // hostaddr stored in EEPROM
extern uint8_t stored_draddr[4];	  // draddr stored in EEPROM
extern uint8_t stored_netmask[4];	  // netmask stored in EEPROM

extern uint16_t stored_port;		  // Port number stored in EEPROM

extern uint8_t stored_devicename[20];     // Device name stored in EEPROM

extern uint8_t stored_config_settings;    // Config settings stored in EEPROM

extern char mac_string[13];		  // MAC Address in string format

extern uint8_t parse_complete;            // Used to signal that all user inputs have
                                          // POSTed and are ready to be used

extern uint8_t user_reboot_request;       // Communicates the need to reboot back to the
                                          // main.c functions
extern uint8_t restart_reboot_step;       // Indicates whether restart or reboot are
                                          // underway.

extern uint8_t stack_error;               // Flag indicating stack overflow error

extern const char code_revision[];        // Code Revision
       
uint8_t OctetArray[11];		          // Used in conversion of integer values to
					  // character values

uint8_t saved_nstate;         // Saved nState used during TCP Fragment
                              // recovery. If saved_nstate != STATE_NULL
			      // saved_nstate will contain one of the
			      // following to indicate the nState we were in
			      // when a TCP fragmentation boundary occurred:
			      //   STATE_NULL       - indicates not
			      //                      processing fragment
			      //   STATE_GOTGET
			      //   STATE_GOTPOST
                              //   STATE_PARSEPOST  - parsing POST data
uint16_t saved_nparseleft;    // Saved nParseLeft during TCP Fragment
                              // recovery
uint8_t saved_newlines;       // Saved nNewlines value in case TCP
                              // fragmentation occurs during the /r/n/r/n
			      // search.
uint8_t parse_tail[38];       // If POST packet TCP fragmentation occurs
                              // parse_tail will contain partial POST value
			      // that was at the end of the packet. The
			      // size of this array is determined by the
			      // longest POST component. At this time that
			      // longest component is the &h00 POST reply.
uint8_t z_diag;               // The last value in a POST (hidden), used for
                              // diagnostics
uint8_t break_while;          // Used to indicate that a parsing "while loop"
                              // break is required
uint8_t current_webpage;      // Tracks the web page that is currently
                              // displayed

// MQTT variables
extern uint8_t mqtt_enabled;              // Signals if MQTT has been enabled
extern uint8_t stored_mqttserveraddr[4];  // mqttserveraddr stored in EEPROM
extern uint16_t stored_mqttport;	  // MQTT Port number  stored in
                                          // EEPROM
extern char stored_mqtt_username[11];     // MQTT Username  stored in EEPROM
extern char stored_mqtt_password[11];     // MQTT Password  stored in EEPROM

extern uint8_t Pending_mqttserveraddr[4]; // Temp storage for new MQTT IP
                                          // Address
extern uint16_t Pending_mqttport;	  // Temp storage for new MQTT Port
extern char Pending_mqtt_username[11];    // Temp storage for new MQTT
                                          // Username
extern char Pending_mqtt_password[11];    // Temp storage for new MQTT
                                          // Password

extern uint8_t mqtt_start_status;         // Contains error status from the
                                          // MQTT start process
extern uint8_t MQTT_error_status;         // For MQTT error status display in
                                          // GUI

extern uint8_t RXERIF_counter;            // Counts RXERIF errors
extern uint8_t TXERIF_counter;            // Counts TXERIF errors
extern uint32_t TRANSMIT_counter;         // Counts any transmit
extern uint8_t MQTT_resp_tout_counter;    // Counts response timeout events
extern uint8_t MQTT_not_OK_counter;       // Counts MQTT != OK events
extern uint8_t MQTT_broker_dis_counter;   // Counts broker disconnect events
extern uint32_t second_counter;           // Counts seconds since boot

// DS18B20 variables
extern uint8_t DS18B20_scratch[5][2];     // Stores the temperature measurement
                                          // for the DS18B20s
extern uint8_t FoundROM[5][8];            // Table of found ROM codes
                                          // [x][0] = Family Code
                                          // [x][1] = LSByte serial number
                                          // [x][2] = byte 2 serial number
                                          // [x][3] = byte 3 serial number
                                          // [x][4] = byte 4 serial number
                                          // [x][5] = byte 5 serial number
                                          // [x][6] = MSByte serial number
                                          // [x][7] = CRC
extern int numROMs;                       // Count of DS18B20 devices found


// Variables stored in Flash
#if MQTT_SUPPORT == 0
// Define Flash addresses for IO Names and IO Timers
extern char IO_NAME[16][16] @0xff00;
extern uint16_t IO_TIMER[16] @0xfec0;
extern uint16_t Pending_IO_TIMER[16];
#endif // MQTT_SUPPORT






//---------------------------------------------------------------------------//
// Notes on web pages:
// - Web pages are formed by placing the HTML for the pages in static
//   constants in flash memory.
//
// - Since most of the web pages contain variable data (for instance things
//   like the user changeable IP addresses, port numbers, device name, etc)
//   the web page "constants" contain markers indicating where the application
//   code should insert data as the web page constant is copied from flash
//   memory into the output data buffer.
//
// - An example marker is %n01, wherein the CopyHttpData() function in the
//   application code will replace the "%n01" characters with a single "0" or
//   "1" character to signal the browser to paint a red or green box
//   indicating mqtt status.
//
// - Additional markers are inserted to help with compression of the web page
//   templates to reduce the amount of flash memory required. In these cases
//   the markers tell the application code to insert strings that are repeated
//   many times in the web page HTML text, rather than have them repeatedly
//   appear in flash memory. For instance %y00 could be used to signal the
//   application code to insert the string
//   "this is a test string"
//   While this makes the code harder to read, it makes the web page templates
//   much smaller.
//
// - All of these insertion steps cause a complication: In the HttpDCall() the
//   function "sizeof" is called to determine the size of the webpage to be
//   copied to the uip_buf for transmission. The copy is performed in the
//   CopyHttpData() function, and the size of the web page is provided in the
//   pDataLeft variable. But this size is also used in the CopyHttpHeader()
//   function to create the Content-Length: for the HTTP header. It is
//   important that Content-Length be exactly the total amount of data that
//   will be sent to the browser. The original code simply did a "sizeof" for
//   the web page template. This is obviously wrong as the template gets a lot
//   of 4 character placeholders swapped out with replacement text of varying
//   lengths, not to mention the insertion of frequently repeated strings. So
//   an "adjust_template_size" function was written to get the size of the
//   template then adjust that size for all the replacement actions that will
//   occur. The function needs to know which template it is working on because
//   each has different amounts of replacement text. The size adjustment also
//   needs to account for UIP_STATISTICS ifdef's as these will also cause
//   variation in the length of the actual data transmitted.
//
// - IMPORTANT: Be sure to carefully update the adjust_template_size function
//   if any changes are made to the %xxx text replacement markers and strings
//   in the templates. Use CURL to verify that pages sizes are reported
//   correctly.
//
// - The templates include the line
//   "<link rel='icon' href='data:,'>".
//   This is needed to prevent browsers from sending "favicon" requests. They
//   seem to do this with annoying repetition greatly slowing down the
//   transmit/receive process.
//
// - The templates include the line
//   "<input type='hidden' name='z00' value='0'><br>"
//   This inserts a hidden variable in the webpage to help the application
//   determine that all POST data is received.
//
// - Each template that contains POST data includes an explanation of how the
//   PARSE_BYTES value is calculated for that template. The PARSE_BYTES value
//   tells the application exactly how much data will be returned in a POST
//   form submittal arriving from the remote host. Note that a form submittal
//   always returns the exact same amount of information even if no fields
//   were changed on the form (with the exception of the devicename, username,
//   and password fields which can be variable in length).
//


//---------------------------------------------------------------------------//
#if MQTT_SUPPORT == 1
// IO Control Template
//
// PARSE_BYTES calculation:
// The form contained in this webpage will generate several data update
// replies. These replies need to be parsed to extract the data from them. We
// need to stop parsing the reply POST data after all update bytes are parsed.
// The formula for determining the stop value is as follows:
//   For 1 of the replies (Pin Control):
//   POST consists of a ParseCmd (a "h" in this case) in 1 byte
//     Followed by the ParseNum in 2 bytes
//     Followed by an equal sign in 1 byte
//     Followed by a state value in 32 bytea
//     Followed by a parse delimiter in 1 byte
//   PLUS
//   For 1 of the replies (hidden):
//   POST consists of a ParseCmd (a "z" in this case) in 1 byte
//     Followed by the ParseNum in 2 bytes
//     Followed by an equal sign in 1 byte
//     Followed by a state value in 1 byte
//     Followed by a parse delimiter in 1 byte
// THUS
// For 1 of the replies there are 37 bytes in the reply
// For 1 of the replies there are 6 bytes per reply
// The formula in this case is
//     PARSEBYTES = (1 x 37)
//                + (1 x 6) - 1
//     PARSEBYTES = 37
//                + 6 - 1 = 42
#define WEBPAGE_IOCONTROL		0
#define PARSEBYTES_IOCONTROL		42
static const char g_HtmlPageIOControl[] =
"%y04%y05"
      "<title>%a00: IO Control</title>"
   "</head>"
   "<body>"
      "<h1>IO Control</h1>"
      "<form onsubmit='return m.s(event);return false'>"
         "<table>"
            "<tr>"
               "<th>Name:</th>"
               "<td colspan=2 style='text-align: left'>%a00</td>"
            "</tr>"
            "<script>"
"const m=(t=>{const e=document,n=e.querySelector.bind(e)('form'),r=(Object.entries,parseI"
"nt),o=t=>e.write(t),s=t=>t.map(t=>((t,e)=>r(t).toString(16).padStart(e,'0'))(t,2)).join("
"''),a=t=>t.match(/.{2}/g).map(t=>r(t,16)),c=t=>encodeURIComponent(t),d=[],h=[],p=(t,e,n)"
"=>{return`<input type=radio name=o${e} value=${t} ${n==t?'checked':''}/><label>${(t?'on'"
":'off').toUpperCase()}</label>`},l=()=>location.href='/60';return a(t.h00).forEach((t,e)"
"=>{3==(3&t)?h.push(`<tr><td>Output #${e+1}</td><td class='s${t>>7} t3'></td><td class=c>"
"${p(1,e,t>>7)}${p(0,e,t>>7)}</td></tr>`):1==(3&t)&&d.push(`<tr><td>Input #${e+1}</td><td"
" class='s${t>>7} t3'></td><td/></tr>`)}),o(d.join('')),o(`<tr><th></th><th></th>${h.leng"
"th>0?'<th class=c>SET</th>':''}</tr>`),o(h.join('')),{s:e=>{e.preventDefault();const r=n"
"ew XMLHttpRequest,o=Array.from((()=>{const e=new FormData(n);return e.set('h00',s(a(t.h0"
"0).map((t,n)=>{const r='o'+n,o=e.get(r)<<7;return e.delete(r),o}))),e})().entries(),([t,"
"e])=>`${c(t)}=${c(e)}`).join('&');r.open('POST','/',!1),r.send(o+'&z00=0'),l()},l:l}})({"
"h00:'%h00'});"
            "%y01"
      "<p/>"
      "%y02`/60`'>Refresh</button> "
      "%y02`/61`'>Configuration</button>"
      "<pre>%t00%t01%t02%t03%t04</pre>"
   "</body>"
"</html>";



/*
// Credit to Jevdeni Kiski for the javascript work and html improvements.
// Below is the raw script used above before minify.
// 1) Copy raw script to minify website, for example https://javascript-minifier.com/
// 2) Copy the resulting minified script to an editor and replace all double quotes with
//    single quotes. THIS STEP IS VERY IMPORTANT.
// 3) Copy the result to the above between the <script> and </script> lines.
// 4) Add double quotes at the start and end of the minfied script to make it part of the
//    constant string.
// 5) It is OK to break up the minified script into lines enclosed by double quotes (just
//    to make it all visible in the code editors). But make sure no spaces are inadvertantly
//    removed from the minified script.

const m = (data => {
    const doc = document,
        selector = doc.querySelector.bind(doc),
        form = selector('form'),
        get_entries = Object.entries,
        parse_int = parseInt,
        document_write = text => doc.write(text),
        pad_hex = (s, l) => parse_int(s).toString(16).padStart(l, '0'),
        convert_to_hex = v => v.map(p => pad_hex(p, 2)).join(''),
        convert_from_hex = v => v.match(/.{2}/g).map(p => parse_int(p, 16)),
        encode = v => encodeURIComponent(v),
        inputs = [],
        outputs = [],
        make_radio_input = (type, id, checked_type) => {
            var type_str = type ? 'on' : 'off';
            return `<input type=radio name=o${id} value=${type} ${checked_type == type ? 'checked' : ''}/><label>${type_str.toUpperCase()}</label>`;
        },
        get_form_data = () => {
            const form_data = new FormData(form);
            form_data.set('h00', convert_to_hex(convert_from_hex(data.h00).map((_, i) => {
                const name = 'o' + i,
                    result = form_data.get(name) << 7;
                form_data.delete(name);
                return result;
            })));
            return form_data;
        },
        reload_page = () => location.href = '/60',
        submit_form = (event) => {
        	event.preventDefault();

          const request = new XMLHttpRequest(),
              string_data = Array.from(get_form_data().entries(), ([k, v]) => `${encode(k)}=${encode(v)}`).join('&');
          request.open('POST', '/', false);
          request.send(string_data + '&z00=0');
          reload_page();
        };
        

    convert_from_hex(data.h00).forEach((cfg, i) => {
        if ((cfg & 3) == 3) { //output
            outputs.push(`<tr><td>Output #${i + 1}</td><td class='s${cfg >> 7} t3'></td><td class=c>${make_radio_input(1, i, cfg >> 7)}${make_radio_input(0, i, cfg >> 7)}</td></tr>`);
        } else if ((cfg & 3) == 1) { // input
            inputs.push(`<tr><td>Input #${i + 1}</td><td class='s${cfg >> 7} t3'></td><td/></tr>`);
        }
    });

    document_write(inputs.join(''));
    document_write(`<tr><th></th><th></th>${outputs.length > 0 ? '<th class=c>SET</th>' : ''}</tr>`);
    document_write(outputs.join(''));
    
    return {s: submit_form, l:reload_page}
})({ h00: '%h00' });


*/



// Configuration webpage Template
//
// PARSE_BYTES calculation:
// The form contained in this webpage will generate several data update
// replies. These replies need to be parsed to extract the data from them. We
// need to stop parsing the reply POST data after all update bytes are parsed.
// The formula for determining the stop value is as follows:
//     For 1 of the replies (device name):
//     example: a00=xxxxxxxxxxxxxxxxxxx&
//     where xxxxxxxxxxxxxxxxxxx is 1 to 19 bytes
//   PLUS
//     For 4 of the replies (HTML IP, MQTT IP, Gateway, and Netmask fields):
//     example: b00=xxxxxxxx&
//     where xxxxxxxx is 8 bytes
//   PLUS
//     For 2 of the replies (HTML and MQTT Port numbers):
//     example: c00=xxxx&
//     where xxxx is 4 bytes
//   PLUS
//     For 1 of the replies (MAC):
//     example: d00=xxxxxxxxxxxx&
//     where xxxxxxxxxxxx is 12 bytes
//   PLUS
//   For 1 of the replies (Config):
//     example: g00=xxxxxx&
//     where xxxxxx is 6 bytes
//   PLUS
//   For 2 of the replies (MQTT Username and Password):
//     example: m00=xxxxxxxxxx&
//     where xxxxxxxxxx is 1 to 10 bytes
//   PLUS
//   For 1 of the replies (Pin Control):
//     example: h00=xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx&
//     where xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx is 32 bytes
//   PLUS
//   For 1 of the replies (hidden):
//   POST consists of a ParseCmd (a "z" in this case) in 1 byte
//     example: z00=x&
//     where x is 1 byte
// The formula in this case is
//     PARSEBYTES = (1 x 24)
//                + (4 x 13)
//                + (2 x 9)
//                + (1 x 17) 
//                + (1 x 11) 
//                + (2 x 15)
//                + (1 x 37)
//                + (1 x 6) - 1
//     PARSEBYTES = 24
//                + 52
//                + 18
//                + 17
//                + 11
//                + 30
//                + 37
//                + 6 - 1 = 194
// Note: PARSEBYTES_X and PARSEBYTES_X_ADDL must each be less than 255 and
// the sum of the two must not exceed 482.
#define WEBPAGE_CONFIGURATION		1
#define PARSEBYTES_CONFIGURATION	194
static const char g_HtmlPageConfiguration[] =
"%y04%y05"
      "<title>%a00: Configuration</title>"
   "</head>"
   "<body>"
      "<h1>Configuration</h1>"
      "<form onsubmit='return m.s(event);return false'>"
         "<table>"
            "<tr>"
               "<td>Name</td>"
               "<td><input name='a00' value='%a00' pattern='[0-9a-zA-Z-_*.]{1,19}' required title='1 to 19 letters, numbers, and -_*. no spaces' maxlength='19'/></td>"
            "</tr>"
            "<tr class='hs'/>"
            "<tr>"
               "<td>IP Address</td>"
               "<td>"
                 "<input name='b00' class='ip'/>"
               "</td>"
            "</tr>"
            "<tr>"
               "<td>Gateway</td>"
               "<td>"
                 "<input name='b04' class='ip'/>"
               "</td>"
            "</tr>"
            "<tr>"
               "<td>Netmask</td>"
               "<td>"
                 "<input name='b08' class='ip'/>"
               "</td>"
            "</tr>"
            "<tr>"
               "<td>Port</td>"
               "<td><input name='c00' class='t8 port'></td>"
            "</tr>"
            "<tr>"
               "<td>MAC Address</td>"
               "<td>"
                 "<input name='d00' required pattern='([0-9a-fA-F]{2}[:-]?){5}([0-9a-fA-F]{2})' title='aa:bb:cc:dd:ee:ff format' maxlength=17/>"
               "</td>"
            "</tr>"
            "<tr>"
               "<td>Features</td>"
               "<td class='f'></td>"
            "</tr>"
            "<tr class='hs'/>"
            "<tr>"
               "<td>MQTT Server</td>"
               "<td>"
                 "<input name='b12' class='ip'/>"
               "</td>"
            "</tr>"
            "<tr>"
               "<td>MQTT Port</td>"
               "<td><input name='c01' class='t8 port'></td>"
            "</tr>"
            "<tr>"
               "<td>MQTT Username</td>"
               "<td class='up'><input name='l00' value='%l00'></td>"
            "</tr>"
            "<tr>"
               "<td>MQTT Password</td>"
               "<td class='up'><input name='m00' value='%m00'></td>"
            "</tr>"
            "<tr class='hs'/>"
            "<tr>"
               "<td>MQTT Status</td>"
               "<td class='s'>"
                 "<div class='s%n00'></div> <div class='s%n01'></div> <div class='s%n02'></div> <div class='s%n03'></div> <div class='s%n04'></div>"
               "</td>"
            "</tr>"
            "<tr class='hs'/>"
         "</table>"
         "<table>"
            "<tr>"
              "<th>IO</th>"
              "<th>Type</th>"
              "<th>Invert</th>"
              "<th>Boot state</th>"
            "</tr>"
         "<script>"
"const m=(e=>{const t=['b00','b04','b08','b12'],n=['c00','c01'],o={disabled:0,input:1,out"
"put:3},r={retain:8,on:16,off:0},a=document,c=location,s=a.querySelector.bind(a),p=s('for"
"m'),d=Object.entries,i=parseInt,l=(e,t)=>i(e).toString(16).padStart(t,'0'),u=e=>e.map(e="
">l(e,2)).join(''),m=e=>e.match(/.{2}/g).map(e=>i(e,16)),$=e=>encodeURIComponent(e),b=(e,"
"t)=>(e=>s(`input[name=${e}]`))(e).value=t,f=(e,t)=>{for(const n of a.querySelectorAll(e)"
")t(n)},h=(e,t)=>{for(const[n,o]of d(t))e.setAttribute(n,o)},g=(e,t)=>d(e).map(e=>`<optio"
"n value=${e[1]} ${e[1]==t?'selected':''}>${e[0]}</option>`).join(''),x=(e,t,n,o='')=>`<i"
"nput type='checkbox' name='${e}' value=${t} ${(n&t)==t?'checked':''}>${o}`,y=(e,t,n)=>{c"
"onst o=new XMLHttpRequest;o.open(e,t,!1),o.send(n)},A=()=>c.href='/61',T=()=>{a.body.inn"
"erText='Wait 5s...',setTimeout(A,5e3)},j=m(e.g00)[0],E={required:!0};return f('.ip',e=>{"
"h(e,{...E,title:'x.x.x.x format',pattern:'((25[0-5]|(2[0-4]|1[0-9]|[1-9]|)[0-9])([.](?!$"
")|$)){4}'})}),f('.port',e=>{h(e,{...E,type:'number',min:10,max:65535})}),f('.up input',e"
"=>{h(e,{title:'0 to 10 letters, numbers, and -_*. no spaces. Blank for no entry.',maxlen"
"gth:10,pattern:'[0-9a-zA-Z-_*.]{0,10}$'})}),t.forEach(t=>b(t,m(e[t]).join('.'))),n.forEa"
"ch(t=>b(t,i(e[t],16))),b('d00',e.d00.replace(/[0-9a-z]{2}(?!$)/g,'$&:')),m(e.h00).forEac"
"h((e,t)=>{const n=1&e?x('p'+t,4,e):'',s=3==(3&e)?`<select name='p${t}'>${g(r,24&e)}</sel"
"ect>`:'',p='#d'==c.hash?`<td>${e}</td>`:'';(e=>a.write(e))(`<tr><td>#${t+1}</td><td><sel"
"ect name='p${t}'>${g(o,3&e)}</select></td><td>${n}</td><td>${s}</td>${p}</tr>`)}),s('.f'"
").innerHTML=Array.from(d({'Full Duplex':1,'HA Auto':6,MQTT:4,DS18B20:8}),([e,t])=>x('g00"
"',t,j,e)).join('</br>'),{r:()=>{y('GET','/91'),T()},s:o=>{o.preventDefault();const r=Arr"
"ay.from((()=>{const o=new FormData(p),r=e=>o.getAll(e).map(e=>i(e)).reduce((e,t)=>e|t,0)"
";return t.forEach(e=>o.set(e,u(o.get(e).split('.')))),n.forEach(e=>o.set(e,l(o.get(e),4)"
")),o.set('d00',o.get('d00').toLowerCase().replace(/[:-]/g,'')),o.set('h00',u(m(e.h00).ma"
"p((e,t)=>{const n='p'+t,a=r(n);return o.delete(n),a}))),o.set('g00',u([r('g00')])),o})()"
".entries(),([e,t])=>`${$(e)}=${$(t)}`).join('&');y('POST','/',r+'&z00=0'),T()},l:A}})({b"
"00:'%b00',b04:'%b04',b08:'%b08',c00:'%c00',d00:'%d00',b12:'%b12',c01:'%c01',h00:'%h00',g"
"00:'%g00'});"
            "%y01"
      "<p>Code Revision %w00<br/>"
        "<a href='https://github.com/nielsonm236/NetMod-ServerApp/wiki'>Help Wiki</a>"
      "</p>"
      "<button title='Save first!' onclick='m.r()'>Reboot</button>"
      "<br><br>"
      "%y02`/61`'>Refresh</button> "
      "%y02`/60`'>IO Control</button>"
   "</body>"
"</html>";


/*
// Credit to Jevdeni Kiski for the javascript work and html improvements.
// Below is the raw script used above before minify.
// 1) Copy raw script to minify website, for example https://javascript-minifier.com/
// 2) Copy the resulting minified script to an editor and replace all double quotes with
//    single quotes. THIS STEP IS VERY IMPORTANT.
// 3) Copy the result to the above between the <script> and </script> lines.
// 4) Add double quotes at the start and end of the minfied script to make it part of the
//    constant string.
// 5) It is OK to break up the minified script into lines enclosed by double quotes (just
//    to make it all visible in the code editors). But make sure no spaces are inadvertantly
//    removed from the minified script.

const m = (data => {
    const ip_input_names = ['b00', 'b04', 'b08', 'b12'],
        port_input_names = ['c00', 'c01'],
        features = { 'Full Duplex': 1, 'HA Auto': 6, 'MQTT': 4, 'DS18B20': 8 },
        pin_types = { 'disabled': 0, 'input': 1, 'output': 3 },
        boot_state = { 'retain': 8, 'on': 16, 'off': 0 },
        doc=document,
        loc=location,
        selector=doc.querySelector.bind(doc),
        form=selector('form'),
        get_entries=Object.entries,
        parse_int = parseInt,
        document_write = text => doc.write(text),
        pad_hex = (s, l) => parse_int(s).toString(16).padStart(l, '0'),
        convert_to_hex = v => v.map(p => pad_hex(p, 2)).join(''),
        convert_from_hex = v => v.match(/.{2}/g).map(p => parse_int(p, 16)),
        encode = v => encodeURIComponent(v),
        query_input_by_name = n => selector(`input[name=${n}]`),
        set_input_value = (n, v) => query_input_by_name(n).value = v,
        selector_apply_fn = (query, fn) => { for (const e of doc.querySelectorAll(query)) { fn(e) } },
        set_attributes = (e, d) => { for (const [k, v] of get_entries(d)) { e.setAttribute(k, v); } },
        make_options = (o, v) => get_entries(o).map((o) => `<option value=${o[1]} ${o[1] == v ? 'selected' : ''}>${o[0]}</option>`).join(''),
        make_checkbox = (name, bit, value, title='') => `<input type='checkbox' name='${name}' value=${bit} ${(value & bit) == bit ? 'checked' : ''}>${title}`,
        get_form_data = () => {
            const form_data = new FormData(form),
            	collect_bits = (name) => form_data.getAll(name).map(v => parse_int(v)).reduce((a, b) => a | b, 0);
              
            ip_input_names.forEach((n) => form_data.set(n, convert_to_hex(form_data.get(n).split('.'))));
            port_input_names.forEach((n) => form_data.set(n, pad_hex(form_data.get(n), 4)));
            
            form_data.set('d00', form_data.get('d00').toLowerCase().replace(/[:-]/g, ''));
            form_data.set('h00', convert_to_hex(convert_from_hex(data.h00).map((_, i) => {
                const name = 'p' + i,
                    result = collect_bits(name);
                form_data.delete(name);
                return result;
            })));
            
            form_data.set('g00', convert_to_hex([collect_bits('g00')]));
            
            return form_data;
        },
        send_request = (method, url, data) => {
        	const request = new XMLHttpRequest();
          request.open(method, url, false);
          request.send(data);
        },
        reload_page = () => loc.href = '/61',
        wait_reboot = () => {
          doc.body.innerText = 'Wait 5s...';
          setTimeout(reload_page, 5000);
        },
        reboot = () => {
          send_request('GET', '/91');
          wait_reboot();
        },
        submitForm = (event) => {
        	event.preventDefault();
          const string_data = Array.from(get_form_data().entries(), ([k, v]) => `${encode(k)}=${encode(v)}`).join('&');
          send_request('POST', '/', string_data + '&z00=0');
          wait_reboot();
        },
        features_data = convert_from_hex(data.g00)[0],
        common_attributes = {required: true};

    selector_apply_fn('.ip', (e) => { set_attributes(e, {...common_attributes, title: 'x.x.x.x format', pattern: '((25[0-5]|(2[0-4]|1[0-9]|[1-9]|)[0-9])([.](?!$)|$)){4}' }); });
    selector_apply_fn('.port', (e) => { set_attributes(e, {...common_attributes, type: 'number', min: 10, max: 65535 }); });
    selector_apply_fn('.up input', (e) => { set_attributes(e, {title: '0 to 10 letters, numbers, and -_*. no spaces. Blank for no entry.', maxlength: 10, pattern: '[0-9a-zA-Z-_*.]{0,10}$' }); });

    ip_input_names.forEach((n) => set_input_value(n, convert_from_hex(data[n]).join('.')));
    port_input_names.forEach((n) => set_input_value(n, parse_int(data[n], 16)));
    set_input_value('d00', data.d00.replace(/[0-9a-z]{2}(?!$)/g, '$&:'));

    convert_from_hex(data.h00).forEach((n, i) => {
        const checkbox = n & 1 ? make_checkbox('p'+i, 4, n) : '',
            make_select = (n & 3) == 3 ? `<select name='p${i}'>${make_options(boot_state, n & 24)}</select>` : '',
            debug_column = (loc.hash == '#d'?`<td>${n}</td>`:'');
        document_write(`<tr><td>#${i + 1}</td><td><select name='p${i}'>${make_options(pin_types, n & 3)}</select></td><td>${checkbox}</td><td>${make_select}</td>${debug_column}</tr>`);
    });
    
    selector('.f').innerHTML = Array.from(
    	get_entries(features),
      ([name, bit]) => make_checkbox('g00', bit, features_data, name)).join('</br>'
    );
    
    
    return {r:reboot, s: submitForm, l:reload_page};
})({
    b00: '%b00',
    b04: '%b04',
    b08: '%b08',
    c00: '%c00',
    d00: '%d00',
    b12: '%b12',
    c01: '%c01',
    h00: '%h00',
    g00: '%g00'
});

*/
#endif // MQTT_SUPPORT




//---------------------------------------------------------------------------//

#if MQTT_SUPPORT == 0
// IO Control Template
//
// PARSE_BYTES calculation:
// The form contained in this webpage will generate several data update
// replies. These replies need to be parsed to extract the data from them. We
// need to stop parsing the reply POST data after all update bytes are parsed.
// The formula for determining the stop value is as follows:
//   Each POST has a "wrapper" consisting of
//     1 byte ParseCmd
//     2 byte ParseNum
//     1 byte egual sign
//     1 byte Delimiter
//     So, add 5 bytes to each POST as defined here:
//
//     For 1 of the replies (Pin Control):
//     POST consists of 32 bytes data plus 5 byte wrapper (37 bytes)
//   PLUS
//     For 1 of the replies (hidden):
//     example: z00=x where x is 1 byte (note no &)
//     POST consists of a 1 byte data plus 4 byte wrapper (5 bytes)
// THUS
// The formula in this case is
//     PARSEBYTES = (1 x 37)
//                + (1 x 5)
//     PARSEBYTES = 37
//                + 5 = 42
#define WEBPAGE_IOCONTROL		0
#define PARSEBYTES_IOCONTROL		42
static const char g_HtmlPageIOControl[] =
"%y04%y05"
      "<title>%a00: IO Control</title>"
   "</head>"
   "<body>"
      "<h1>IO Control</h1>"
      "<form onsubmit='return m.s(event);return false'>"
         "<table>"
            "<tr>"
               "<th>Name:</th>"
               "<td colspan=2 style='text-align: left'>%a00</td>"
            "</tr>"
            "<script>"
"const m=(t=>{const e=document,j=e.querySelector.bind(e)('form'),r=(Object.entries,parseInt)"
",n=t=>e.write(t),o=t=>t.map(t=>((t,e)=>r(t).toString(16).padStart(e,'0'))(t,2)).join(''),a="
"t=>t.match(/.{2}/g).map(t=>r(t,16)),s=t=>encodeURIComponent(t),c=[],d=[],h=(t,e,j)=>{return"
"`<input type=radio name=o${e} value=${t} ${j==t?'checked':''}/><label>${(t?'on':'off').toUp"
"perCase()}</label>`},p=()=>location.href='/60';return a(t.h00).forEach((e,j)=>{var r=t['j'+"
"(j+'').padStart(2,'0')];3==(3&e)?d.push(`<tr><td>${r}</td><td class='s${e>>7} t3'></td><td "
"class=c>${h(1,j,e>>7)}${h(0,j,e>>7)}</td></tr>`):1==(3&e)&&c.push(`<tr><td>${r}</td><td cla"
"ss='s${e>>7} t3'></td><td/></tr>`)}),n(c.join('')),n(`<tr><th></th><th></th>${d.length>0?'<"
"th class=c>SET</th>':''}</tr>`),n(d.join('')),{s:e=>{e.preventDefault();const r=new XMLHttp"
"Request,n=Array.from((()=>{const e=new FormData(j);return e.set('h00',o(a(t.h00).map((t,j)="
">{const r='o'+j,n=e.get(r)<<7;return e.delete(r),n}))),e})().entries(),([t,e])=>`${s(t)}=${"
"s(e)}`).join('&');r.open('POST','/',!1),r.send(n+'&z00=0'),p()},l:p}})({h00:'%h00',j00:'%j0"
"0',j01:'%j01',j02:'%j02',j03:'%j03',j04:'%j04',j05:'%j05',j06:'%j06',j07:'%j07',j08:'%j08',"
"j09:'%j09',j10:'%j10',j11:'%j11',j12:'%j12',j13:'%j13',j14:'%j14',j15:'%j15'});"
            "%y01"
      "<p/>"
      "%y02`/60`'>Refresh</button> "
      "%y02`/61`'>Configuration</button>"
      "<pre>%t00%t01%t02%t03%t04</pre>"
   "</body>"
"</html>";



/*
// Credit to Jevdeni Kiski for the javascript work and html improvements.
// Below is the raw script used above before minify.
// 1) Copy raw script to minify website, for example https://javascript-minifier.com/
// 2) Copy the resulting minified script to an editor and replace all double quotes with
//    single quotes. THIS STEP IS VERY IMPORTANT.
// 3) Copy the result to the above between the <script> and </script> lines.
// 4) Add double quotes at the start and end of the minfied script to make it part of the
//    constant string.
// 5) It is OK to break up the minified script into lines enclosed by double quotes (just
//    to make it all visible in the code editors). But make sure no spaces are inadvertantly
//    removed from the minified script.

const m = (data => {
    const doc = document,
        selector = doc.querySelector.bind(doc),
        form = selector('form'),
        get_entries = Object.entries,
        parse_int = parseInt,
        document_write = text => doc.write(text),
        pad_hex = (s, l) => parse_int(s).toString(16).padStart(l, '0'),
        convert_to_hex = v => v.map(p => pad_hex(p, 2)).join(''),
        convert_from_hex = v => v.match(/.{2}/g).map(p => parse_int(p, 16)),
        encode = v => encodeURIComponent(v),
        inputs = [],
        outputs = [],
        make_radio_input = (type, id, checked_type) => {
            var type_str = type ? 'on' : 'off';
            return `<input type=radio name=o${id} value=${type} ${checked_type == type ? 'checked' : ''}/><label>${type_str.toUpperCase()}</label>`;
        },
        get_form_data = () => {
            const form_data = new FormData(form);
            form_data.set('h00', convert_to_hex(convert_from_hex(data.h00).map((_, i) => {
                const name = 'o' + i,
                    result = form_data.get(name) << 7;
                form_data.delete(name);
                return result;
            })));
            return form_data;
        },
        reload_page = () => location.href = '/60',
        submit_form = (event) => {
        	event.preventDefault();

          const request = new XMLHttpRequest(),
              string_data = Array.from(get_form_data().entries(), ([k, v]) => `${encode(k)}=${encode(v)}`).join('&');
          request.open('POST', '/', false);
          request.send(string_data + '&z00=0');
          reload_page();
        };
        

    convert_from_hex(data.h00).forEach((cfg, i) => {
    		var name = data['j'+(i+'').padStart(2, '0')];
        if ((cfg & 3) == 3) { //output
            outputs.push(`<tr><td>${name}</td><td class='s${cfg >> 7} t3'></td><td class=c>${make_radio_input(1, i, cfg >> 7)}${make_radio_input(0, i, cfg >> 7)}</td></tr>`);
        } else if ((cfg & 3) == 1) { // input
            inputs.push(`<tr><td>${name}</td><td class='s${cfg >> 7} t3'></td><td/></tr>`);
        }
    });

    document_write(inputs.join(''));
    document_write(`<tr><th></th><th></th>${outputs.length > 0 ? '<th class=c>SET</th>' : ''}</tr>`);
    document_write(outputs.join(''));
    
    return {s: submit_form, l:reload_page}
})({
  h00: '%h00',
  j00: '%j00',
  j01: '%j01',
  j02: '%j02',
  j03: '%j03',
  j04: '%j04',
  j05: '%j05',
  j06: '%j06',
  j07: '%j07',
  j08: '%j08',
  j09: '%j09',
  j10: '%j10',
  j11: '%j11',
  j12: '%j12',
  j13: '%j13',
  j14: '%j14',
  j15: '%j15',
});

*/



// Configuration webpage Template
//
// PARSE_BYTES calculation:
// The form contained in this webpage will generate several data update
// replies. These replies need to be parsed to extract the data from them. We
// need to stop parsing the reply POST data after all update bytes are parsed.
// The formula for determining the stop value is as follows:
//   Each POST has a "wrapper" consisting of
//     1 byte ParseCmd
//     2 byte ParseNum
//     1 byte egual sign
//     1 byte Delimiter
//     So, add 5 bytes to each POST as defined here:
//
//     For 1 of the replies (device name):
//     example: a00=xxxxxxxxxxxxxxxxxxx& where xxxxxxxxxxxxxxxxxxx is 1 to 19 bytes
//     POST consists of 19 bytes data plus 5 byte wrapper (24 bytes)
//   PLUS
//     For 3 of the replies (HTML IP, Gateway, and Netmask fields):
//     example: b00=xxxxxxxx& where xxxxxxxx is 8 bytes
//     POST consists of 8 bytes data plus 5 byte wrapper (13 bytes)
//   PLUS
//     For 1 of the replies (HTML Port number):
//     example: c00=xxxx& where xxxx is 4 bytes
//     POST consists of 4 bytes data plus 5 byte wrapper (9 bytes)
//   PLUS
//     For 1 of the replies (MAC):
//     example: d00=xxxxxxxxxxxx& where xxxxxxxxxxxx is 12 bytes
//     POST consists of 12 bytes data plus 5 byte wrapper (17 bytes)
//   PLUS
//     For 1 of the replies (Config):
//     example: g00=xx& where xx is 2 bytes
//     POST consists of 2 bytes data plus 5 byte wrapper (7 bytes)
//   PLUS
//     For 1 of the replies (Pin Control):
//     example: h00=xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx&
//     where xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx is 32 bytes
//     POST consists of 32 bytes data plus 5 byte wrapper (37 bytes)
//   PLUS
//     For 16 of the replies (IO Name):
//     example: j00=xxxxxxxxxxxxxxx& where xxxxxxxxxxxxxxx is 15 bytes
//     POST consists of 15 bytes data plus 5 byte wrapper (20 bytes)
//   PLUS
//     For 16 of the replies (IO Timer):
//     example: i00=xxxx& where xxxx is 4 bytes
//     POST consists of 4 bytes data plus 5 byte wrapper (9 bytes)
//   PLUS
//     For 1 of the replies (hidden):
//     example: z00=x where x is 1 byte (note no &)
//     POST consists of 1 byte data plus 4 byte wrapper (5 bytes)
// The formula in this case is
//     PARSEBYTES = (1 x 24)
//                + (3 x 13)
//                + (1 x 9)
//                + (1 x 17)
//                + (1 x 7)
//                + (1 x 37)
//                + (16 x 20)
//                + (16 x 9)
//                + (1 x 5)
//     PARSEBYTES = 24
//                + 39
//                + 9
//                + 17
//                + 7
//                + 37
//                + 320
//                + 144
//                + 5 = 602
#define WEBPAGE_CONFIGURATION		1
#define PARSEBYTES_CONFIGURATION	602
static const char g_HtmlPageConfiguration[] =
"%y04%y05"
      "<title>%a00: Configuration</title>"
   "</head>"
   "<body>"
      "<h1>Configuration</h1>"
      "<form onsubmit='return m.s(event);return false'>"
         "<table>"
            "<tr>"
               "<td>Name</td>"
               "<td><input name='a00' value='%a00' pattern='[0-9a-zA-Z-_*.]{1,19}' required title='1 to 19 letters, numbers, and -_*. no spaces' maxlength='19'/></td>"
            "</tr>"
            "<tr class='hs'/>"
            "<tr>"
               "<td>IP Address</td>"
               "<td>"
                 "<input name='b00' class='ip'/>"
               "</td>"
            "</tr>"
            "<tr>"
               "<td>Gateway</td>"
               "<td>"
                 "<input name='b04' class='ip'/>"
               "</td>"
            "</tr>"
            "<tr>"
               "<td>Netmask</td>"
               "<td>"
                 "<input name='b08' class='ip'/>"
               "</td>"
            "</tr>"
            "<tr>"
               "<td>Port</td>"
               "<td><input name='c00' class='t8 port'></td>"
            "</tr>"
            "<tr>"
               "<td>MAC Address</td>"
               "<td>"
                 "<input name='d00' required pattern='([0-9a-fA-F]{2}[:-]?){5}([0-9a-fA-F]{2})' title='aa:bb:cc:dd:ee:ff format' maxlength=17/>"
               "</td>"
            "</tr>"
            "<tr>"
               "<td>Features</td>"
               "<td class='f'></td>"
            "</tr>"
            "<tr class='hs'/>"
         "</table>"
         "<table>"
            "<tr>"
              "<th>IO</th>"
              "<th>Type</th>"
              "<th>Name</th>"
              "<th>Invert</th>"
              "<th>Boot state</th>"
              "<th>Timer</th>"
            "</tr>"
         "<script>"
"const m=(e=>{const t=['b00','b04','b08'],i=['c00'],n={disabled:0,input:1,output:3},r={r"
"etain:8,on:16,off:0},a={'0.1s':0,'1s':16384,'1m':32768,'1h':49152},o=document,s=locatio"
"n,c=o.querySelector.bind(o),j=c('form'),d=Object.entries,p=parseInt,l=(e,t)=>p(e).toStr"
"ing(16).padStart(t,'0'),m=e=>e.map(e=>l(e,2)).join(''),u=e=>e.match(/.{2}/g).map(e=>p(e"
",16)),$=e=>encodeURIComponent(e),b=(e,t)=>(e=>c(`input[name=${e}]`))(e).value=t,f=(e,t)"
"=>{for(const i of o.querySelectorAll(e))t(i)},h=(e,t)=>{for(const[i,n]of d(t))e.setAttr"
"ibute(i,n)},g=(e,t)=>d(e).map(e=>`<option value=${e[1]} ${e[1]==t?'selected':''}>${e[0]"
"}</option>`).join(''),x=(e,t,i,n='')=>`<input type='checkbox' name='${e}' value=${t} ${"
"(i&t)==t?'checked':''}>${n}`,y=(e,t,i)=>{const n=new XMLHttpRequest;n.open(e,t,!1),n.se"
"nd(i)},S=()=>s.href='/61',v=()=>{o.body.innerText='Wait 5s...',setTimeout(S,5e3)},A=u(e"
".g00)[0],E={required:!0};return f('.ip',e=>{h(e,{...E,title:'x.x.x.x format',pattern:'("
"(25[0-5]|(2[0-4]|1[0-9]|[1-9]|)[0-9])([.](?!$)|$)){4}'})}),f('.port',e=>{h(e,{...E,type"
":'number',min:10,max:65535})}),t.forEach(t=>b(t,u(e[t]).join('.'))),i.forEach(t=>b(t,p("
"e[t],16))),b('d00',e.d00.replace(/[0-9a-z]{2}(?!$)/g,'$&:')),u(e.h00).forEach((t,i)=>{c"
"onst c=1&t?x('p'+i,4,t):'',j=(e,i)=>3==(3&t)?e:i,d=(''+i).padStart(2,'0'),p=j(u(e['i'+d"
"]).reduce((e,t)=>(e<<8)+t),0),l=j(`<select name='p${i}'>${g(r,24&t)}</select>`,''),m='#"
"d'==s.hash?`<td>${t}</td>`:'',$=j(`<input type=number class=t8 name='i${d}' value='${16"
"383&p}' min=0 max=16383><select name='i${d}'>${g(a,49152&p)}</select>`,'');(e=>o.write("
"e))(`<tr><td>#${i+1}</td><td><select name='p${i}'>${g(n,3&t)}</select></td><td><input n"
"ame='j${d}' value='${e['j'+d]}' pattern='[0-9a-zA-Z_*.-]{1,15}' required title='1 to 15"
" letters, numbers, and -*_. no spaces' maxlength=15/></td><td>${c}</td><td>${l}</td><td"
">${$}</td>${m}</tr>`)}),c('.f').innerHTML=Array.from(d({'Full Duplex':1,DS18B20:8}),([e"
",t])=>x('g00',t,A,e)).join('</br>'),{r:()=>{y('GET','/91'),v()},s:n=>{n.preventDefault("
");const r=Array.from((()=>{const n=new FormData(j),r=e=>n.getAll(e).map(e=>p(e)).reduce"
"((e,t)=>e|t,0);t.forEach(e=>n.set(e,m(n.get(e).split('.')))),i.forEach(e=>n.set(e,l(n.g"
"et(e),4))),n.set('d00',n.get('d00').toLowerCase().replace(/[:-]/g,'')),n.set('h00',m(u("
"e.h00).map((e,t)=>{const i='p'+t,a=r(i);return n.delete(i),a})));for(let e=0;e<16;e++){"
"let t=(''+e).padStart(2,'0');n.set('i'+t,l(65535&r('i'+t),4))}return n.set('g00',m([r('"
"g00')])),n})().entries(),([e,t])=>`${$(e)}=${$(t)}`).join('&');y('POST','/',r+'&z00=0')"
",v()},l:S}})({b00:'%b00',b04:'%b04',b08:'%b08',c00:'%c00',d00:'%d00',h00:'%h00',g00:'%g"
"00',j00:'%j00',j01:'%j01',j02:'%j02',j03:'%j03',j04:'%j04',j05:'%j05',j06:'%j06',j07:'%"
"j07',j08:'%j08',j09:'%j09',j10:'%j10',j11:'%j11',j12:'%j12',j13:'%j13',j14:'%j14',j15:'"
"%j15',i00:'%i00',i01:'%i01',i02:'%i02',i03:'%i03',i04:'%i04',i05:'%i05',i06:'%i06',i07:"
"'%i07',i08:'%i08',i09:'%i09',i10:'%i10',i11:'%i11',i12:'%i12',i13:'%i13',i14:'%i14',i15"
":'%i15'});"
            "%y01"
      "<p>Code Revision %w00<br/>"
        "<a href='https://github.com/nielsonm236/NetMod-ServerApp/wiki'>Help Wiki</a>"
      "</p>"
      "<button title='Save first!' onclick='m.r()'>Reboot</button>"
      "<br><br>"
      "%y02`/61`'>Refresh</button> "
      "%y02`/60`'>IO Control</button>"
   "</body>"
"</html>";


/*
// Credit to Jevdeni Kiski for the javascript work and html improvements.
// Below is the raw script used above before minify.
// 1) Copy raw script to minify website, for example https://javascript-minifier.com/
// 2) Copy the resulting minified script to an editor and replace all double quotes with
//    single quotes. THIS STEP IS VERY IMPORTANT.
// 3) Copy the result to the above between the <script> and </script> lines.
// 4) Add double quotes at the start and end of the minfied script to make it part of the
//    constant string.
// 5) It is OK to break up the minified script into lines enclosed by double quotes (just
//    to make it all visible in the code editors). But make sure no spaces are inadvertantly
//    removed from the minified script.

const m = (data => {
    const ip_input_names = ['b00', 'b04', 'b08'],
        port_input_names = ['c00'],
        features = { 'Full Duplex': 1, 'DS18B20': 8 },
        pin_types = { 'disabled': 0, 'input': 1, 'output': 3 },
        boot_state = { 'retain': 8, 'on': 16, 'off': 0 },
        timer_unit = { '0.1s': 0, '1s': 0x4000, '1m': 0x8000, '1h': 0xc000 },
        doc=document,
        loc=location,
        selector=doc.querySelector.bind(doc),
        form=selector('form'),
        get_entries=Object.entries,
        parse_int = parseInt,
        document_write = text => doc.write(text),
        pad_hex = (s, l) => parse_int(s).toString(16).padStart(l, '0'),
        convert_to_hex = v => v.map(p => pad_hex(p, 2)).join(''),
        convert_from_hex = v => v.match(/.{2}/g).map(p => parse_int(p, 16)),
        encode = v => encodeURIComponent(v),
        query_input_by_name = n => selector(`input[name=${n}]`),
        set_input_value = (n, v) => query_input_by_name(n).value = v,
        selector_apply_fn = (query, fn) => { for (const e of doc.querySelectorAll(query)) { fn(e) } },
        set_attributes = (e, d) => { for (const [k, v] of get_entries(d)) { e.setAttribute(k, v); } },
        make_options = (o, v) => get_entries(o).map((o) => `<option value=${o[1]} ${o[1] == v ? 'selected' : ''}>${o[0]}</option>`).join(''),
        make_checkbox = (name, bit, value, title='') => `<input type='checkbox' name='${name}' value=${bit} ${(value & bit) == bit ? 'checked' : ''}>${title}`,
        get_form_data = () => {
            const form_data = new FormData(form),
            	collect_bits = (name) => form_data.getAll(name).map(v => parse_int(v)).reduce((a, b) => a | b, 0);
              
            ip_input_names.forEach((n) => form_data.set(n, convert_to_hex(form_data.get(n).split('.'))));
            port_input_names.forEach((n) => form_data.set(n, pad_hex(form_data.get(n), 4)));
            
            form_data.set('d00', form_data.get('d00').toLowerCase().replace(/[:-]/g, ''));
            form_data.set('h00', convert_to_hex(convert_from_hex(data.h00).map((_, i) => {
                const name = 'p' + i,
                    result = collect_bits(name);
                form_data.delete(name);
                return result;
            })));
            for (let i=0;i<16;i++) {
              let input_nr = (''+i).padStart(2, '0');
            	form_data.set('i'+input_nr, pad_hex(collect_bits('i'+input_nr) & 0xffff, 4));
            }
            
            form_data.set('g00', convert_to_hex([collect_bits('g00')]));
            
            return form_data;
        },
        send_request = (method, url, data) => {
        	const request = new XMLHttpRequest();
          request.open(method, url, false);
          request.send(data);
        },
        reload_page = () => loc.href='/61',
        wait_reboot = () => {
          doc.body.innerText = 'Wait 5s...';
          setTimeout(reload_page, 5000);
        },
        reboot = () => {
          send_request('GET', '/91');
          wait_reboot();
        },
        submitForm = (event) => {
        	event.preventDefault();
          const string_data = Array.from(get_form_data().entries(), ([k, v]) => `${encode(k)}=${encode(v)}`).join('&');
          send_request('POST', '/', string_data + '&z00=0');
          wait_reboot();
        },
        features_data = convert_from_hex(data.g00)[0],
        common_attributes = {required: true};

    selector_apply_fn('.ip', (e) => { set_attributes(e, {...common_attributes, title: 'x.x.x.x format', pattern: '((25[0-5]|(2[0-4]|1[0-9]|[1-9]|)[0-9])([.](?!$)|$)){4}' }); });
    selector_apply_fn('.port', (e) => { set_attributes(e, {...common_attributes, type: 'number', min: 10, max: 65535 }); });

    ip_input_names.forEach((n) => set_input_value(n, convert_from_hex(data[n]).join('.')));
    port_input_names.forEach((n) => set_input_value(n, parse_int(data[n], 16)));
    set_input_value('d00', data.d00.replace(/[0-9a-z]{2}(?!$)/g, '$&:'));

    convert_from_hex(data.h00).forEach((n, i) => {
        const invert_checkbox = n & 1 ? make_checkbox('p'+i, 4, n) : '',
            if_output = (a,b) => (n & 3) == 3 ? a: b,
        		input_nr = (''+i).padStart(2, '0'),
            timer_int_value = if_output(convert_from_hex(data['i'+input_nr]).reduce((prev, cur)=>(prev<<8)+cur), 0),
            boot_state_select = if_output(`<select name='p${i}'>${make_options(boot_state, n & 24)}</select>`,''),
            debug_column = (loc.hash == '#d'?`<td>${n}</td>`:''),
            timer_column = if_output(`<input type=number class=t8 name='i${input_nr}' value='${timer_int_value & 0x3fff}' min=0 max=16383><select name='i${input_nr}'>${make_options(timer_unit, timer_int_value & 0xc000)}</select>`,'');
        document_write(`<tr><td>#${i + 1}</td><td><select name='p${i}'>${make_options(pin_types, n & 3)}</select></td><td><input name='j${input_nr}' value='${data['j'+input_nr]}' pattern='[0-9a-zA-Z_*.-]{1,15}' required title='1 to 15 letters, numbers, and -*_. no spaces' maxlength=15/></td><td>${invert_checkbox}</td><td>${boot_state_select}</td><td>${timer_column}</td>${debug_column}</tr>`);
    });
    
    selector('.f').innerHTML = Array.from(
    	get_entries(features),
      ([name, bit]) => make_checkbox('g00', bit, features_data, name)).join('</br>'
    );
    
    
    return {r:reboot, s: submitForm, l:reload_page};
})({
    b00: '%b00',
    b04: '%b04',
    b08: '%b08',
    c00: '%c00',
    d00: '%d00',
    h00: '%h00',
    g00: '%g00',
    j00: '%j00',
    j01: '%j01',
    j02: '%j02',
    j03: '%j03',
    j04: '%j04',
    j05: '%j05',
    j06: '%j06',
    j07: '%j07',
    j08: '%j08',
    j09: '%j09',
    j10: '%j10',
    j11: '%j11',
    j12: '%j12',
    j13: '%j13',
    j14: '%j14',
    j15: '%j15',
    i00: '%i00',
    i01: '%i01',
    i02: '%i02',
    i03: '%i03',
    i04: '%i04',
    i05: '%i05',
    i06: '%i06',
    i07: '%i07',
    i08: '%i08',
    i09: '%i09',
    i10: '%i10',
    i11: '%i11',
    i12: '%i12',
    i13: '%i13',
    i14: '%i14',
    i15: '%i15',
});

*/
#endif // MQTT_SUPPORT


#if UIP_STATISTICS == 1 && MQTT_SUPPORT == 0
// Statistics page Template
#define WEBPAGE_STATS1		5
static const char g_HtmlPageStats1[] =
"%y04%y05"
  "<title>%a00: Network Statistics</title>"
  "</head>"
  "<body>"
  "<h1>Network Statistics</h1>"
  "<p>Values shown are since last power on or reset</p>"
  "<table>"
  "<tr><td class='t1'>%e00</td><td class='t2'>Dropped packets at the IP layer</td></tr>"
  "<tr><td class='t1'>%e01</td><td class='t2'>Received packets at the IP layer</td></tr>"
  "<tr><td class='t1'>%e02</td><td class='t2'>Sent packets at the IP layer</td></tr>"
  "<tr><td class='t1'>%e03</td><td class='t2'>Packets dropped due to wrong IP version or header length</td></tr>"
  "<tr><td class='t1'>%e04</td><td class='t2'>Packets dropped due to wrong IP length, high byte</td></tr>"
  "<tr><td class='t1'>%e05</td><td class='t2'>Packets dropped due to wrong IP length, low byte</td></tr>"
  "<tr><td class='t1'>%e06</td><td class='t2'>Packets dropped since they were IP fragments</td></tr>"
  "<tr><td class='t1'>%e07</td><td class='t2'>Packets dropped due to IP checksum errors</td></tr>"
  "<tr><td class='t1'>%e08</td><td class='t2'>Packets dropped since they were not ICMP or TCP</td></tr>"
  "<tr><td class='t1'>%e09</td><td class='t2'>Dropped ICMP packets</td></tr>"
  "<tr><td class='t1'>%e10</td><td class='t2'>Received ICMP packets</td></tr>"
  "<tr><td class='t1'>%e11</td><td class='t2'>Sent ICMP packets</td></tr>"
  "<tr><td class='t1'>%e12</td><td class='t2'>ICMP packets with a wrong type</td></tr>"
  "<tr><td class='t1'>%e13</td><td class='t2'>Dropped TCP segments</td></tr>"
  "<tr><td class='t1'>%e14</td><td class='t2'>Received TCP segments</td></tr>"
  "<tr><td class='t1'>%e15</td><td class='t2'>Sent TCP segments</td></tr>"
  "<tr><td class='t1'>%e16</td><td class='t2'>TCP segments with a bad checksum</td></tr>"
  "<tr><td class='t1'>%e17</td><td class='t2'>TCP segments with a bad ACK number</td></tr>"
  "<tr><td class='t1'>%e18</td><td class='t2'>Received TCP RST (reset) segments</td></tr>"
  "<tr><td class='t1'>%e19</td><td class='t2'>Retransmitted TCP segments</td></tr>"
  "<tr><td class='t1'>%e20</td><td class='t2'>Dropped SYNs due to too few connections avaliable</td></tr>"
  "<tr><td class='t1'>%e21</td><td class='t2'>SYNs for closed ports, triggering a RST</td></tr>"
  "</table>"
  "<br>"
  "<button onclick='location=`/61`'>Configuration</button>"
  "<button onclick='location=`/68`'>Refresh</button>"
  "<button onclick='location=`/69`'>Clear</button>"
  "</body>"
  "</html>";
#endif // UIP_STATISTICS



#if DEBUG_SUPPORT == 11 || DEBUG_SUPPORT == 15
// Link Error Statistics page Template
#define WEBPAGE_STATS2		6
static const char g_HtmlPageStats2[] =
  "%y04%y05"
  "<title>%a00: Link Error Statistics</title>"
  "</head>"
  "<body>"
  "<h1>Link Error Statistics</h1>"
  "<table>"
  "<tr><td>31 %e31</td></tr>"
  "<tr><td>32 %e32</td></tr>"
  "<tr><td>33 %e33</td></tr>"
  "<tr><td>35 %e35</td></tr>"
  "</table>"
  "<br>"
  "<button onclick='location=`/61`'>Configuration</button>"
  "<button onclick='location=`/66`'>Refresh</button>"
  "<button onclick='location=`/67`'>Clear</button>"
  "</body>"
  "</html>";
#endif // DEBUG_SUPPORT



#if DEBUG_SENSOR_SERIAL == 1
// Temperature Sensor Serial Number page Template
#define WEBPAGE_SENSOR_SERIAL	7
static const char g_HtmlPageTmpSerialNum[] =
  "%y04%y05"
  "<title>%a00: Temperature Sensor Serial Numbers</title>"
  "</head>"
  "<body>"
  "<h1>Temperature Sensor Serial Numbers</h1>"
  "<table>"
  "<tr><td>%e40</td></tr>"
  "<tr><td>%e41</td></tr>"
  "<tr><td>%e42</td></tr>"
  "<tr><td>%e43</td></tr>"
  "<tr><td>%e44</td></tr>"
  "</table>"
  "<br>"
  "<button onclick='location=`/61`'>Configuration</button>"
  "</body>"
  "</html>";
#endif // DEBUG_SENSOR_SERIAL


// Very Short IO state page Template
// Only responds with a TCP payload that contains the 16 alphanumeric
// characters representing the IO pins states. The response is not
// browser compatible.
// 4 bytes; size of reports 5
#define WEBPAGE_SSTATE		8
static const char g_HtmlPageSstate[] =
  "%f00";


//---------------------------------------------------------------------------//
// The following creates an array of strings that are commonly used strings
// in the HTML pages. To reduce the size of the HTML pages these common
// strings are replaced with placeholders of the form "%yxx", then when the
// HTML page is copied to the trasnmit buffer the placeholders are replaced
// with one of the strings in this array. The length of each string is
// manually counted and put in the associated _len value. When the _len value 
// is needed it often has 4 subtracted (as the strings are replacing the 4
// character placeholder), so that subtraction is done once here.

// The following creates an array of 6 strings of variable length

// String for %y00 replacement in web page templates
#define s0 "" \
  "placeholder"

// String for %y01 replacement in web page templates
#define s1 "" \
  "</script>" \
  "</table>" \
  "<p/>" \
  "<button type=submit>Save</button> <button type=reset onclick='m.l()'>Undo All</button>" \
  "</form>"

// String for %y02 replacement in web page templates
#define s2 "" \
  "<button title='Save first!' onclick='location="

// String for %y03 replacement in web page templates
#define s3 "" \
"placeholder"

// String for %y04 replacement in web page templates
#define s4  "" \
  "<html>"\
  "<head>" \
  "<link rel='icon' href='data:,'>" \
  "<meta name='viewport' content='width=device-width'>" \
  "<style>" \
  ".s0{background:red;}" \
  ".s1{background:green;}"

// String for %y05 replacement in web page templates
#define s5 "" \
  "table{border-spacing:8px2px}" \
  ".t1{width:100px;}" \
  ".t2{width:450px;}" \
  ".t3{width:30px;}" \
  ".t8{width:60px;}" \
  ".c{text-align:center;}" \
  ".ip input{width:27px;}" \
  ".mac input{width:14px;}" \
  ".s div{width:13px;height:13px;display:inline-block;}" \
  ".hs{height:9px;}" \
  "</style>"

// The following creates an array of string lengths corresponding to
// the strings in the #define statements above
// AND
// Creates an array of string lengths (less 4) corresponding to the
// strings above
struct page_string {
    const char * str;
    uint8_t size;
    uint8_t size_less4;
};

const struct page_string ps[6] = {
    { s0, sizeof(s0)-1, sizeof(s0)-5 },
    { s1, sizeof(s1)-1, sizeof(s1)-5 },
    { s2, sizeof(s2)-1, sizeof(s2)-5 },
    { s3, sizeof(s3)-1, sizeof(s3)-5 },
    { s4, sizeof(s4)-1, sizeof(s4)-5 },
    { s5, sizeof(s5)-1, sizeof(s5)-5 }
};

// Access the above strings, string length, and (string length - 4) as
// follows:
// ps[i].str
// ps[i].size
// ps[i].size_less4


//---------------------------------------------------------------------------//
// The following compile time pre-processor statements test the string
// lengths to make sure they are within valid limits. All string lengths
// must be less than 256.
#if (sizeof(s0) > 255)
  #error "string s0 is too big"
#endif

#if (sizeof(s1) > 255)
  #error "string s1 is too big"
#endif

#if (sizeof(s2) > 255)
  #error "string s2 is too big"
#endif

#if (sizeof(s3) > 255)
  #error "string s3 is too big"
#endif

#if (sizeof(s4) > 255)
  #error "string s4 is too big"
#endif

#if (sizeof(s5) > 255)
  #error "string s5 is too big"
#endif


// insertion_flag is used in continuing transmission of a "%yxx" insertion
// string that was interrupted by a buffer full indication. The "flag" is
// three bytes as follows:
//   insertion_flag[0] - Index into the string that was being sent. This is
//                       0 if no insertion is underway
//   insertion_flag[1] - The nParsedMode value
//   insertion_flag[2] - The nParsedNum value
char insertion_flag[3];


uint16_t adjust_template_size()
{
  uint16_t size;
  
  // This function calculates the size of the HTML page that will be
  // transmitted based on the size of the web page template plus adjustments
  // needed to account for text strings that replace markers in the web page
  // template.
  // 
  // Note to self: This code is crap from the perspective of readability and
  // being error prone. Walking through the web page templates to verify that
  // this code properly adjusts the reported web page size is tedious,
  // particularly when it comes to the #if inclusions/exclusions. Need to
  // work on a better methodology.
  //
  // Most of the size calculations end up being constants, so a lot of this
  // function is comments explaining where the constants come from, then
  // simply adding the result to the template size.
  
  size = 0;

  // Adjust the size reported by the WEBPAGE_IOCONTROL template
  //
  
  if (current_webpage == WEBPAGE_IOCONTROL) {
    size = (uint16_t)(sizeof(g_HtmlPageIOControl) - 1);

    // Account for header replacement strings %y04 %y05
    size = size + ps[4].size_less4
                + ps[5].size_less4;

    // Account for Device Name field %a00 in <title> and in body
    // This can be variable in size during run time so we have to calculate it
    // each time we display the web page.
    size = size + (2 * (strlen(stored_devicename) - 4));
    
#if MQTT_SUPPORT == 0
    // Account for IO Name fields %j00 to %j15
    // Each can be variable in size during run time so we have to calculate
    // them  each time we display the web page.
    {
      int i;
      for (i=0; i<15; i++) {
        size = size + (strlen(IO_NAME[i]) - 4);
      }
    }
#endif MQTT_SUPPORT

    // Account for pin control field %h00
    // size = size + (#instances x (value_size - marker_field_size));
    // size = size + (#instances x (32 - 4));
    // size = size + (1 x 28);
    size = size + 28;
 
    // Account for Temperature Sensor insertion %t00 to %t04
    // Each of these insertions can have a different length due to the
    // text around them. If DS18B20 is NOT enabled we only need to
    // subtract the size of the 5 placeholders.
    //
    if (stored_config_settings & 0x08) {
      //  %t00 "<p>Temperature Sensors<br> xxxxxxxxxxxx "
      //      plus 13 bytes of data and degC characters (-000.0&#8451;)
      //      plus 14 bytes of data and degF characters ( -000.0&#8457;)
      //    40 bytes of text plus 27 bytes of data = 59
      //    size = size + 67 - 4
      size = size + 63;
      //
      //  %t01 "<br> xxxxxxxxxxxx " 
      //      plus 13 bytes of data and degC characters (-000.0&#8451;)
      //      plus 14 bytes of data and degF characters ( -000.0&#8457;)
      //    18 bytes of text plus 27 bytes of data = 37
      //    size = size + 45 - 4
      size = size + 41;
      //
      //  %t02 "<br> xxxxxxxxxxxx "
      //      plus 13 bytes of data and degC characters (-000.0&#8451;)
      //      plus 14 bytes of data and degF characters ( -000.0&#8457;)
      //    18 bytes of text plus 27 bytes of data = 37
      //    size = size + 45 - 4
      size = size + 41;
      //
      //  %t03 "<br> xxxxxxxxxxxx "
      //      plus 13 bytes of data and degC characters (-000.0&#8451;)
      //      plus 14 bytes of data and degF characters ( -000.0&#8457;)
      //    18 bytes of text plus 27 bytes of data = 37
      //    size = size + 45 - 4
      size = size + 41;
      //
      //  %t04 "<br> xxxxxxxxxxxx "
      //      plus 13 bytes of data and degC characters (-000.0&#8451;)
      //      plus 14 bytes of data and degF characters ( -000.0&#8457;)
      //      plus "<br></p>"
      //    18 bytes of text plus 27 bytes of data = 45
      //    plus 8 bytes of text = 53
      //    size = size + 53 - 4
      size = size + 49;
    }
    else {
      // Subtract the size of the placeholders as they won't be used
      // size = size - (5 x 4)
      size = size - 20;
    }
    
    // Account for Text Replacement insertion
    // Some strings appear frequently in the templates - things like the
    // button titles which appear when hovering over a button. These strings
    // are inserted on the fly when the web page is sent to the browser, so
    // they have to be accounted for in the size of the web page.
    
    // String for %y01 in web page template
    // There 1 instance (Save and Undo All buttons)
    // size = size + (#instances) x (ps[1].size - marker_field_size);
    // size = size + ps[1].size_less4;
    size = size + ps[1].size_less4;

    // String for %y02 in web page template
    // There 2 instances (Refresh and Configuration buttons)
    // size = size + (#instances) x (ps[2].size - marker_field_size);
    // size = size + (2 x ps[2].size_less4);
    size = size + (2 * ps[2].size_less4);
  }


  //---------------------------------------------------------------------------//
  // Adjust the size reported by the WEBPAGE_CONFIGURATION template
  //
  else if (current_webpage == WEBPAGE_CONFIGURATION) {
    size = (uint16_t)(sizeof(g_HtmlPageConfiguration) - 1);
    // Account for header replacement strings %y04 %y05
    size = size + ps[4].size_less4
                + ps[5].size_less4;

    // Account for Device Name field %a00 in <title> and in body
    // This can be variable in size during run time so we have to calculate it
    // each time we display the web page.
    size = size + (2 * (strlen(stored_devicename) - 4));

    // Account for HTML IP Address, Gateway Address, and
    // Netmask fields %b00, %b04, %b08
    // There are 3 instances of these fields
    // size = size + (#instances x (value_size - marker_field_size));
    // size = size + (3 x (8 - 4));
    // size = size + (3 x (4));
    size = size + 12;

#if MQTT_SUPPORT == 1
    // Account for MQTT IP Address field %b12
    // There is 1 instance
    // size = size + (#instances x (value_size - marker_field_size));
    // size = size + (1 x (8 - 4));
    // size = size + (1 x (4));
    size = size + 4;
#endif // MQTT_SUPPORT

    // Account for HTML Port field %c00
    // There is 1 instance
    // size = size + (#instances x (value_size - marker_field_size));
    // size = size + (1 x (5 - 4));
    // size = size + (1 x (1));
    // size = size + 1;
    size = size + 1;

#if MQTT_SUPPORT == 1
    // Account for MQTT Port field %c01
    // There is 1 instance
    // size = size + (#instances x (value_size - marker_field_size));
    // size = size + (1 x (5 - 4));
    // size = size + (1 x (1));
    // size = size + 1;
    size = size + 1;
#endif // MQTT_SUPPORT

    // Account for MAC field %d00
    // There is 1 instance of this field
    // size = size + (#instances x (value_size - marker_field_size));
    // size = size + (1 x (12 - 4));
    // size = size + (1 x (8));
    size = size + 8;

    // Account for Config string %g00
    // There is 1 instance
    // value_size is 2 (2 characters)
    // size = size + (#instances x (value_size - marker_field_size));
    // size = size + (#instances x (2 - 4));
    // size = size + (1 x (-2));
    size = size - 2;

#if MQTT_SUPPORT == 1
    // Account for Username field %l00
    // This can be variable in size during run time so we have to calculate it
    // each time we display the web page.
    size = size + (strlen(stored_mqtt_username) - 4);

    // Account for Password field %m00
    // This can be variable in size during run time so we have to calculate it
    // each time we display the web page.
    size = size + (strlen(stored_mqtt_password) - 4);

    // Account for red/green State Progress boxes %n00, %n01, %n02, %n03, %n04 
    // There are always 5 boxes, one for each State progress indicator
    // size = size + (#instances x (value_size - marker_field_size));
    // size = size + (#instances x (1 - 4));
    // size = size + (5 x (-3));
    size = size - 15;
#endif // MQTT_SUPPORT

    // Account for Code Revision insertion %w00
    // size = size + (#instances x (value_size - marker_field_size));
    // size = size + (#instances x (13 - 4));
    // size = size + (1 x 9);
    size = size + 9;

    // Account for pin control field %h00
    // size = size + (#instances x (value_size - marker_field_size));
    // size = size + (#instances x (32 - 4));
    // size = size + (1 x 28);
    size = size + 28;

#if MQTT_SUPPORT == 0
    // Account for IO Name fields %j00 to %j15
    // Each can be variable in size during run time so we have to calculate
    // them  each time we display the web page.
    {
      int i;
      for (i=0; i<15; i++) {
        size = size + (strlen(IO_NAME[i]) - 4);
      }
    }

    // Account for IO Timer field %i00 to %i15
    // size = size + (#instances x (value_size - marker_field_size));
    // size = size + (#instances x (4 - 4));
    // size = size + (16 x 0);
    // size = size + 0;
#endif MQTT_SUPPORT
 
    // Account for Text Replacement insertion
    // Some strings appear frequently in the templates - things like the
    // button titles which appear when hovering over a button. These strings
    // are inserted on the fly when the web page is sent to the browser, so
    // they have to be accounted for in the size of the web page.
    
    // String for %y01 in web page template
    // There 1 instance (Save and Undo All buttons)
    // size = size + (#instances) x (ps[1].size - marker_field_size);
    // size = size + ps[1].size_less4;
    size = size + ps[1].size_less4;

    // String for %y02 in web page templates
    // There are 2 instances (Refresh and IO Control buttons)
    // size = size + (#instances x (value_size - marker_field_size));
    // size = size + (#instances) x (ps[2].size - 4);
    // size = size + (2) x ps[2].size_less4;
    size = size + (2 * ps[2].size_less4);
  }


#if UIP_STATISTICS == 1 && MQTT_SUPPORT == 0
  //---------------------------------------------------------------------------//
  // Adjust the size reported by the WEBPAGE_STATS1 template
  //
  else if (current_webpage == WEBPAGE_STATS1) {
    size = (uint16_t)(sizeof(g_HtmlPageStats1) - 1);

    // Account for header replacement strings %y04 %y05
    size = size + ps[4].size_less4
                + ps[5].size_less4;

    // Account for Device Name field %a00 in <title>
    // This can be variable in size during run time so we have to calculate it
    // each time we display the web page.
    size = size + (strlen(stored_devicename) - 4);

    // Account for Statistics fields %e00 to %e21
    // There are 22 instances of these fields
    // size = size + (#instances x (value_size - marker_field_size));
    // size = size + (22 x (10 - 4));
    // size = size + (22 x (6));
    size = size + 132;
  }
#endif // UIP_STATISTICS


#if DEBUG_SUPPORT == 11 || DEBUG_SUPPORT == 15
  //---------------------------------------------------------------------------//
  // Adjust the size reported by the WEBPAGE_STATS template
  //
  else if (current_webpage == WEBPAGE_STATS2) {
    size = (uint16_t)(sizeof(g_HtmlPageStats2) - 1);

    // Account for header replacement strings %y04 %y05
    size = size + ps[4].size_less4
                + ps[5].size_less4;

    // Account for Device Name field %a00 in <title>
    // This can be variable in size during run time so we have to calculate it
    // each time we display the web page.
    size = size + (strlen(stored_devicename) - 4);

    // Account for Statistics fields %e31, %e32, %e33, %e35
    // There are 4 instances of these fields
    // size = size + (#instances x (value_size - marker_field_size));
    // size = size + (4 x (10 - 4));
    // size = size + (4 x (6));
    size = size + 24;
  }
#endif // DEBUG_SUPPORT


#if DEBUG_SENSOR_SERIAL == 1
  //---------------------------------------------------------------------------//
  // Adjust the size reported by the DEBUG_SENSOR_SERIAL template
  //
  else if (current_webpage == WEBPAGE_SENSOR_SERIAL) {
    size = (uint16_t)(sizeof(g_HtmlPageTmpSerialNum) - 1);

    // Account for header replacement strings %y04 %y05
    size = size + ps[4].size_less4
                + ps[5].size_less4;

    // Account for Device Name field %a00 in <title>
    // This can be variable in size during run time so we have to calculate it
    // each time we display the web page.
    size = size + (strlen(stored_devicename) - 4);

    // Account for Temperature Sensor Serial Number fields %e40, %e41, %e42,
    //   %e43, %e44
    // There are 5 instances of these fields
    // size = size + (#instances x (value_size - marker_field_size));
    // size = size + (5 x (12 - 4));
    // size = size + (5 x (8));
    size = size + 40;
  }
#endif // DEBUG_SENSOR_SERIAL


  //---------------------------------------------------------------------------//
  // Adjust the size reported by the WEBPAGE_SSTATE template
  //
  else if (current_webpage == WEBPAGE_SSTATE) {
    size = (uint16_t)(sizeof(g_HtmlPageSstate) - 1);
    
    // Account for Short Form IO Settings field (%f00)
    // size = size + (value size - marker_field_size)
    // size = size + (16 - 4);
    size = size + 12;
  }

  return size;
}


void emb_itoa(uint32_t num, char* str, uint8_t base, uint8_t pad)
{
  // Implementation of itoa() specific to this application
  // num  - The value to be converted
  // str  - Pointer to the storage location for the converted value
  // base - The base to be used in the output string
  // pad  - size of the string result, pre-pad with zeroes if needed
  //
  // The resulting string  in str will be NULL terminated on completion.
  // No checking is done so make sure str has enough room for the
  // converted value and the terminator.
  //
  // Positive numbers ONLY,
  //   Up to 10 digits (32 bits),
  //   Includes leading 0 pad,
  //   Converts base 2 (binary), 8 (nibbles), 10 (decimal), 16 (hex)
  //     base 2 example
  //       emb_itoa(number, OctetArray, 2, 8);
  //       where number is a uint8_t containing the value 0xac
  //       output string in OctetArray is 10101100
  //     base 8 example
  //       emb_itoa(number, OctetArray, 2, 4);
  //       where number is a uint8_t containing the value 0xac
  //       output string in OctetArray is 0254
  //     base 10 example
  //       emb_itoa(number, OctetArray, 2, 5);
  //       where number is a uint8_t containing the value 0xac
  //       output string in OctetArray is 00172
  //     base 16 example
  //       emb_itoa(number, OctetArray, 2, 8);
  //       where number is a uint32_t containing the value 0xc0a80004
  //       output string in OctetArray is c0a80004

  int i;
  uint8_t rem;

  // Fill the string with zeroes. This handles the case where the num provided
  // to the function is zero, and it handles padding as the function will fill
  // in anything up to the pad length. The value "pad" is effectively the
  // length of the desired output. If number = 0 no further processing needed.
  for (i=0; i < pad; i++) str[i] = '0';
  str[pad] = '\0';
  if (num == 0) return;
  
  // Process individual digits
  i = 0;
  while (num != 0) {
    rem = (uint8_t)(num % base);
    if (rem > 9) str[i++] = (uint8_t)(rem - 10 + 'a');
    else str[i++] = (uint8_t)(rem + '0');
    num = num/base;
  }

  // Reverse the string
  {
    uint8_t start;
    uint8_t end;
    uint8_t temp;
    
    start = 0;
    end = (uint8_t)(pad - 1);
    
    while (start < end) {
      temp = str[start];
      str[start] = str[end];
      str[end] = temp;
      start++;
      end--;
    }
  }
}


int hex2int(char ch)
{
  // Convert a single hex character to an integer (a nibble)
  // If the character is not hex -1 is returned
  if (ch >= '0' && ch <= '9') return ch - '0';
  if (ch >= 'a' && ch <= 'f') return ch - 'a' + 10;
  return -1;
}


uint8_t two_hex2int(char chmsb, char chlsb)
{
  uint8_t temp;
  // Convert two hex characters to an integer (an unsigned byte)
  temp = (uint8_t)hex2int(chmsb);
  temp = (uint8_t)(temp<<4);
  temp = (uint8_t)(temp | hex2int(chlsb));
  return temp;
}


void int2hex(uint8_t i)
{
  uint8_t j;
  // Convert a single integer into two hex characters (two nibbles).
  // Put the result in global variable OctetArray.
  j = (uint8_t)(i>>4);
  if(j<=9) OctetArray[0] = (uint8_t)(j + '0');
  else OctetArray[0] = (uint8_t)(j - 10 + 'a');
  j = (uint8_t)(i & 0x0f);
  if(j<=9) OctetArray[1] = (uint8_t)(j + '0');
  else OctetArray[1] = (uint8_t)(j - 10 + 'a');
  OctetArray[2] = '\0';
}


static uint16_t CopyStringP(uint8_t** ppBuffer, const char* pString)
{
  // Copies a string into the buffer for transmission
  uint16_t nBytes;
  char Character;

  nBytes = 0;
  while ((Character = pString[0]) != '\0') {
    **ppBuffer = Character;
    *ppBuffer = *ppBuffer + 1;
    pString = pString + 1;
    nBytes++;
  }
  return nBytes;
}


// static uint16_t CopyHttpHeader(uint8_t* pBuffer, uint16_t nDataLen, uint8_t type)
static uint16_t CopyHttpHeader(uint8_t* pBuffer, uint16_t nDataLen)
{
  uint16_t nBytes;
  int i;

  nBytes = 0;

  nBytes += CopyStringP(&pBuffer, (const char *)(
    "HTTP/1.1 200 OK\r\n"
    "Content-Length:"
    ));

  // This creates the "xxxxx" part of a 5 character "Content-Length:xxxxx" field in the pBuffer.
  emb_itoa(nDataLen, OctetArray, 10, 5);
  for (i=0; i<5; i++) {
    *pBuffer = (uint8_t)OctetArray[i];
    pBuffer = pBuffer + 1;
  }
  nBytes += 5;

  nBytes += CopyStringP(&pBuffer, (const char *)(
    "\r\n"
    "Cache-Control: no-cache, no-store\r\n"
    "Content-Type: text/html; charset=utf-8\r\n"
    "Connection:close\r\n\r\n"
    ));
    
  return nBytes;
}


static uint16_t CopyHttpData(uint8_t* pBuffer, const char** ppData, uint16_t* pDataLeft, uint16_t nMaxBytes)
{
  // This function copies the selected webpage from flash storage to the
  // output buffer. While doing the copy the stream of characters in the
  // webpage source is searched for special markers that indicate where
  // variable data representing pin states or address information should
  // appear in the webpage, and it searches for the input fields that a user
  // would change in webpage forms. When those special characters are found
  // the program inserts the required variables.
    
  uint8_t nByte;
  uint8_t nParsedNum;
  uint8_t nParsedMode;
  uint8_t temp;
  int i;
  int no_err;
  unsigned char temp_octet[3];
  uint8_t* pBuffer_start;
  
  nParsedNum = 0;
  nParsedMode = 0;
  pBuffer_start =  pBuffer;

  // The input value "nMaxBytes" provided by the calling routine is based on
  // the MSS (Maximum Segment Size) defined in UIP_TCP_MSS.
  //
  // In this "transmit" routine MSS indicates the maximum number of TCP
  // datagram bytes that the remote host will accept in a TCP segment (the
  // TCP datagram part of an IP frame). The MSS value is defined in the
  // uipopt.h file. Later the MSS should be updated with a value obtained from
  // the browser that is accessing the web server during setup of a connection.
  // However, I don't think this actually happens, and for simplification I
  // think UIP is using a single MSS value for transmit and receive. Receive
  // is the critical direction because we have limited memory to store
  // incoming packets ... and it is OK if we transmit less than the MSS that a
  // remote host tells us it can receive. The problem that this causes is that
  // as we reduce the value of MSS for receive, it also reduces the size of
  // MSS for transmit, and that causes our web page transmission to take a
  // very long time (I'm seeing 2 seconds for a simple web page). May have to
  // work on this some more.
  //
  // In the original UIP code there was a "uip_split" function that would
  // reduce the size of transmitted packets. I think that code was interacting
  // with the code below creating instability, perhaps because a lot of
  // short packets were generated. Making the nMaxBytes limit smaller than the
  // uip_split threshold effectively prevented the uip_split from operating,
  // and the overall code became stable. I subsequently decided to remove
  // uip_split from this application.
  //
  // XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
  //
  // See the uipopt.h file: UIP_TCP_MSS must be smaller than the UIP_BUF
  // (which is the same size as MAXFRAME) by the size of the headers (54
  // bytes). So, if MAXFRAME is 500 bytes UIP_TCP_MSS can be up to 446 bytes.
  // In this application UIP_TCP_MSS is set to 440.
  // 
  // We really only need to make sure that the loop below stays within the
  // MSS boundary and within the UIP_BUF buffer size, whichever is smaller.
  // XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
  //
  // #define ENC28J60_MAXFRAME	900 (in enc28j60.h)
  //   Note: When using MQTT, ENC28J60_MAXFRAME could only be a max of 500
  //   bytes to allow room for the MQTT variables and buffer.
  //
  // nMaxbytes must be 32 bytes smaller than UIP_TCP_MSS due to the need to
  // allow for the largest string insertion that is NOT a %yxx replacement.
  //
  // nMaxBytes should not cause a TCP datagram formation larger than 536
  // bytes.
  //
  // Note: Complete transmission of the typical webpage in this application is
  // about 4000 bytes.

  // XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
  // This over-rides the nMaxBytes value passed to the function to account
  // for extra bytes that might be sent in a single pass of the loop below.
  nMaxBytes = UIP_TCP_MSS - 40;
  // XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX

  while ((pBuffer - pBuffer_start) < nMaxBytes) {
    // This is the main loop for processing the page templates stored in
    // flash and inserting variable data as the webpage is copied to the
    // transmission buffer.
    //
    // The variable *pDataLeft counts down the amount of data not yet
    // "consumed" from the source web page template.
    //
    // There are a large number of "markers" in the template that get replaced
    // by other text when the template is read and "copied" to the transmit
    // buffer. Thus, the amount of data actually sent for a given page can
    // greatly exceed the original size of the template.
    //
    // There are two ways this loop terminates:
    // 1) If (pBuffer - pBuffer_start) exceeds nMaxBytes.
    // 2) If *pDataLeft reaches a count of zero.
    // If the loop terminates and there is still data left to transmit (as
    // indicated by pDataLeft > 0) the calling routine will call the function
    // again.
    
    if (*pDataLeft > 0) {
      // If pDataLeft > 0 then we are (or are still) processing a page
      // template. If we previously interrupted an insertion string transfer
      // to the transmit buffer then we don't want to read a character from
      // the template, and instead we want to continue with the insertion
      // string process.
    
      if (insertion_flag[0] != 0) {
        // We're continuing a string insertion. Use the retained nParsedMode
	// and nParsedNum values so that we return to the %yxx part of the
	// function. Note that if we are in the process of copying an
	// insertion string to the transmit buffer insertion_flag[0] will be
	// non-zero.
        // insertion_flag[0] = %yxx insertion byte index (1 byte)
        // insertion_flag[1] = nParsedMode (y)
        // insertion_flag[2] = nParsedNum  (0, 1, 2, etc)
        nParsedMode = insertion_flag[1];
        nParsedNum = insertion_flag[2];
	nByte = '0'; // Need to set nByte to something other than '%' so we
	             // can use the regular processing routine.
      }
      else {
        // Else we're not continuing a string insertion and instead we should
	// process the next character in the page template.
	//
        // Collect a byte from the source webpage. It will either be written
	// to the transmission buffer as-is, or it (and perhaps characters
	// that follow it) will be processed for replacement in the
	// transmission buffer. pDataLeft is decremented once for each
	// character read from the web page template.
      
	nByte = **ppData;

        // Search for '%' symbol in the data stream. The symbol indicates the
	// start of one of these special fields:
        // %a - A user entered text field with a device name. Used for GUI
	//      display so the user can easily tell what device they are
	//      connected to. Also used as part of the MQTT Topic name. Also
	//      displayed in the tab "title" field of a browser. Input and
	//      output. Max 19 chars.
        // %b - Address values - in the GUI the user will change these values
	//      if they want to change the IP Address, Gateway Address,
	//      Netmask or MQTT Server IP Address. Input and output.
        // %c - HTTP Port Number or MQTT Server Port Number - in the GUI the
	//      user will change this value if they want to change the Port
	//      number. Input and output.
        // %d - MAC values - in the GUI the user will change these values if
	//      they want to change the MAC address. Input and output.
        // %e - Statistics display information. Output only.
        // %f - IO states displayed in simplified form. Output only.
        // %g - "Config" string to control MQTT Enable, Full/Half Duplex, and
	//      Home Assistant Auto Discovery functions. Input and Output.
	// %h - Pin Control string - The pin control string is defined as 32
	//      characters representing 16 hex bytes of information in text
	//      format. Each byte is the pin_control character for each IO
	//      pin. Input and Output.
	// %i - IO Timer values
	// %j - IO Names
        // %l - MQTT Username - This is a user entered text field with a
	//      Username. Used in MQTT communication. Input and output.
        // %m - MQTT Password - This is a user entered text field with a
	//      Password. Used in MQTT communication. Input and output.
        // %n - MQTT Status - Displays red or green boxes to indicate startup
	//      status for MQTT (Connection Available, ARP OK, TCP OK, Connect
	//      OK, MQTT_OK). Output only.
	// %t - Temperature Sensor data. Output only.
	// %w - Code Revision. Output only.
        // %y - Indicates the need to insert one of several commonly occuring
	//      HTML strings. This is to aid in compressing the web page
	//      templates stored in flash memory.
        // %z - A bogus variable inserted at the end of the form data to make
	//      sure that all real data is followed by an & character. This
	//      helps to find the end of variable length values in the POST
	//      form. The z value itself is never used.
      
        if (nByte == '%') {
          (*ppData)++;
          (*pDataLeft)--;
          
          // Collect the "nParsedMode" value (the i, o, a, b, c, etc part of
	  // the field). This, along with the "nParsedNum" digits that follow,
	  // will determine what data is put in the output stream.
	  nParsedMode = **ppData;
          (*ppData)++;
          (*pDataLeft)--;
          
          // Collect the first digit of the "nParsedNum" which follows the
	  // "nParseMode". This is the "tens" digit of the two character
	  // nParsedNum.
	  temp = **ppData;
          nParsedNum = (uint8_t)((temp - '0') * 10);
          (*ppData)++;
          (*pDataLeft)--;

          // Collect the second digit of the "nParsedNum". This is the "ones"
	  // digit. Add it to the "tens" digit to complete the number in
	  // integer form.
	  temp = **ppData;
          nParsedNum = (uint8_t)(nParsedNum + temp - '0');
          (*ppData)++;
          (*pDataLeft)--;
	}
      }

      if ((nByte == '%') || (insertion_flag[0] != 0)) {
        // NOW insert information in the transmit stream based on the nParsedMode
	// and nParsedNum just collected. Anything inserted in the transmit stream
	// is in ascii / UTF-8 form.

        if (nParsedMode == 'a') {
	  // This displays the device name (up to 19 characters)
          pBuffer = stpcpy(pBuffer, stored_devicename);
	}

	
        else if (nParsedMode == 'b') {
	  // This displays the IP Address, Gateway Address, and Netmask information.
	  // We need to get the 32 bit values for IP Address, Gateway Address, and
	  // Netmask and send them as text strings of hex characters (8 characters
	  // for a 32 bit number, for example "c0a80004").
	  {
	    uint32_t temp32;
	    uip_ipaddr_t * uip_ptr = NULL;
	    
            switch (nParsedNum)
	    {
	      // Depending on nParsedNum, point the correspondent variable
	      case 0:
	        uip_ptr = &uip_hostaddr;
	        break;
	      case 4:
	        uip_ptr = &uip_draddr;
	        break;
	      case 8:
	        uip_ptr = &uip_netmask;
	        break;
	      case 12:
	        uip_ptr = &uip_mqttserveraddr;
	        break;
	      default: break;
            }
	  
	    // Convert the value to an 8 digit hex string
	    if (uip_ptr != NULL) {
	        temp32 = (*uip_ptr)[0];
		temp32 <<= 16;
		temp32 |= (*uip_ptr)[1];
	        emb_itoa(temp32, OctetArray, 16, 8);
	    }
	  
 	    // Copy OctetArray characters to output. Advance pointers.
            pBuffer = stpcpy(pBuffer, OctetArray);
	  }
	}
	
        else if (nParsedMode == 'c') {
	  // If nParsedNum == 0 this is the HTML Port number (5 characters)
	  // If nParsedNum == 1 this is the MQTT Port number (5 characters)
	  // In both cases we need to get a single 16 bit integer from storage
	  // but put it in the transmission buffer as 5 alpha characters in
	  // hex format.

	  // Write the 5 digit Port value in hex
	  if (nParsedNum == 0) emb_itoa(stored_port, OctetArray, 16, 5);
	  else emb_itoa(stored_mqttport, OctetArray, 16, 5);
	    
	  // Copy OctetArray characters to output. Advance pointers.
          pBuffer = stpcpy(pBuffer, OctetArray);
        }
	
        else if (nParsedMode == 'd') {
	  // This displays the MAC adddress information (2 characters per
	  // octet). We send the 12 characters in the mac_string (rather
	  // than from the uip_ethaddr bytes) as the mac_string is already
	  // in alphanumeric format.
          pBuffer = stpcpy(pBuffer, mac_string);
	}
	

#if UIP_STATISTICS == 1 && MQTT_SUPPORT == 0
        else if ((nParsedMode == 'e') && (nParsedNum < 22)) {
	  // This displays the statistics information (10 characters per
	  // data item). We need to get a single uint32_t from storage but
	  // put it in the output stream as a character representation of
	  // the data.
	  // uip_stat.ip.drop       Number of dropped packets at the IP layer.
	  // uip_stat.ip.recv       Number of received packets at the IP layer.
	  // uip_stat.ip.sent       Number of sent packets at the IP layer.
	  // uip_stat.ip.vhlerr     Number of packets dropped due to wrong IP version or header length.
	  // uip_stat.ip.hblenerr   Number of packets dropped due to wrong IP length, high byte.
	  // uip_stat.ip.lblenerr   Number of packets dropped due to wrong IP length, low byte.
	  // uip_stat.ip.fragerr    Number of packets dropped since they were IP fragments.
	  // uip_stat.ip.chkerr     Number of packets dropped due to IP checksum errors.
	  // uip_stat.ip.protoerr   Number of packets dropped since they were neither ICMP, UDP nor TCP.
	  // uip_stat.icmp.drop     Number of dropped ICMP packets.
	  // uip_stat.icmp.recv     Number of received ICMP packets.
	  // uip_stat.icmp.sent     Number of sent ICMP packets.
	  // uip_stat.icmp.typeerr  Number of ICMP packets with a wrong type.
	  // uip_stat.tcp.drop      Number of dropped TCP segments.
	  // uip_stat.tcp.recv      Number of received TCP segments.
	  // uip_stat.tcp.sent      Number of sent TCP segments.
	  // uip_stat.tcp.chkerr    Number of TCP segments with a bad checksum.
	  // uip_stat.tcp.ackerr    Number of TCP segments with a bad ACK number.
	  // uip_stat.tcp.rst       Number of received TCP RST (reset) segments.
	  // uip_stat.tcp.rexmit    Number of retransmitted TCP segments.
	  // uip_stat.tcp.syndrop   Number of dropped SYNs due to too few connections avaliable.
	  // uip_stat.tcp.synrst    Number of SYNs for closed ports, triggering a RST.
	  
          switch (nParsedNum)
	  {
	    // Output the statistics. First convert to 10 digit Decimal.
	    case 0:  emb_itoa(uip_stat.ip.drop,      OctetArray, 10, 10); break;
	    case 1:  emb_itoa(uip_stat.ip.recv,      OctetArray, 10, 10); break;
	    case 2:  emb_itoa(uip_stat.ip.sent,      OctetArray, 10, 10); break;
	    case 3:  emb_itoa(uip_stat.ip.vhlerr,    OctetArray, 10, 10); break;
	    case 4:  emb_itoa(uip_stat.ip.hblenerr,  OctetArray, 10, 10); break;
	    case 5:  emb_itoa(uip_stat.ip.lblenerr,  OctetArray, 10, 10); break;
	    case 6:  emb_itoa(uip_stat.ip.fragerr,   OctetArray, 10, 10); break;
	    case 7:  emb_itoa(uip_stat.ip.chkerr,    OctetArray, 10, 10); break;
	    case 8:  emb_itoa(uip_stat.ip.protoerr,  OctetArray, 10, 10); break;
	    case 9:  emb_itoa(uip_stat.icmp.drop,    OctetArray, 10, 10); break;
	    case 10: emb_itoa(uip_stat.icmp.recv,    OctetArray, 10, 10); break;
	    case 11: emb_itoa(uip_stat.icmp.sent,    OctetArray, 10, 10); break;
	    case 12: emb_itoa(uip_stat.icmp.typeerr, OctetArray, 10, 10); break;
	    case 13: emb_itoa(uip_stat.tcp.drop,     OctetArray, 10, 10); break;
	    case 14: emb_itoa(uip_stat.tcp.recv,     OctetArray, 10, 10); break;
	    case 15: emb_itoa(uip_stat.tcp.sent,     OctetArray, 10, 10); break;
	    case 16: emb_itoa(uip_stat.tcp.chkerr,   OctetArray, 10, 10); break;
	    case 17: emb_itoa(uip_stat.tcp.ackerr,   OctetArray, 10, 10); break;
	    case 18: emb_itoa(uip_stat.tcp.rst,      OctetArray, 10, 10); break;
	    case 19: emb_itoa(uip_stat.tcp.rexmit,   OctetArray, 10, 10); break;
	    case 20: emb_itoa(uip_stat.tcp.syndrop,  OctetArray, 10, 10); break;
	    case 21: emb_itoa(uip_stat.tcp.synrst,   OctetArray, 10, 10); break;
	  }
        pBuffer = stpcpy(pBuffer, OctetArray);
	}
#endif // UIP_STATISTICS


#if DEBUG_SUPPORT == 11 || DEBUG_SUPPORT == 15
        else if ((nParsedMode == 'e') && (nParsedNum >= 30) && (nParsedNum < 40)) {
          if (nParsedNum == 31) emb_itoa(second_counter, OctetArray, 10, 10);
	  if (nParsedNum == 32) emb_itoa(TRANSMIT_counter, OctetArray, 10, 10);
          if (nParsedNum == 31 || nParsedNum == 32) {
          pBuffer = stpcpy(pBuffer, OctetArray);
	  }
          else if (nParsedNum == 33) {
	    for (i=20; i<25; i++) {
              int2hex(stored_debug[i]);
              *pBuffer++ = OctetArray[0];
              *pBuffer++ = OctetArray[1];
	    }
	  }
          else if (nParsedNum == 35) {
            *pBuffer++ = '0';
            *pBuffer++ = '0';
            *pBuffer++ = '0';
            *pBuffer++ = '0';
            int2hex(MQTT_resp_tout_counter);
            *pBuffer++ = OctetArray[0];
            *pBuffer++ = OctetArray[1];
            int2hex(MQTT_not_OK_counter);
            *pBuffer++ = OctetArray[0];
            *pBuffer++ = OctetArray[1];
            int2hex(MQTT_broker_dis_counter);
            *pBuffer++ = OctetArray[0];
            *pBuffer++ = OctetArray[1];
	  }
	}
#endif // DEBUG_SUPPORT


#if DEBUG_SENSOR_SERIAL == 1
        else if ((nParsedMode == 'e') && (nParsedNum >= 40)) {
	  // This is for diagnostic use only and in NOT normally enabled
	  // in the compile options. This displays the Temperature Sensor
	  // Serial Numbers and was made necessary due to some suppliers
	  // providing DS18B20 devices with identical serial numbers.
          if ((nParsedNum - 40) <= numROMs) {
	    {
              int n;
              for (n=6; n>0; n--) {
                int2hex(FoundROM[nParsedNum - 40][n]);
                *pBuffer++ = (OctetArray[0]);
                *pBuffer++ = (OctetArray[1]);
              }
	    }
          }
	  // If the sensor does not exist ...
	  else {
	    pBuffer = stpcpy(pBuffer, "------------");
	  }
	}
#endif // DEBUG_SENSOR_SERIAL


        else if (nParsedMode == 'f') {
	  // Display the pin state information in the format used by the "98" and
	  // "99" command. "99" is the command used in the original Network Module.
	  // For output pins display the state in the pin_control byte.
	  // For input pins if the Invert bit is set the ON_OFF state needs to be
	  // inverted before displaying.
	  // Bits are output for Pin 16 first and Pin 1 last
	  i = 15;
	  while( 1 ) {
	    if (pin_control[i] & 0x02) {
	      // This is an output
	      if (pin_control[i] & 0x80) {
	        // Output is ON
		*pBuffer++ = '1';
	      }
	      else {
		// Output is OFF
		*pBuffer++ = '0';
	      }
            }
            else {
	      // This is an input
	      if (pin_control[i] & 0x80) {
	        // Input is ON, invert if needed
	        if (pin_control[i] & 0x04) *pBuffer = '0';
	        else *pBuffer = '1';
                pBuffer++;
	      }
	      else {
		// Input is OFF, invert if needed
		if (pin_control[i] & 0x04) *pBuffer = '1';
		else *pBuffer = '0';
                pBuffer++;
	      }
	    }
	    if (i == 0) break;
	    i--;
          }
	}
	

        else if (nParsedMode == 'g') {
	  // This displays the Config string, currently defined as follows:
	  // Communicated to and from the web pages as 2 characters making
	  // a hex encoded byte. Stored in memory as a single byte.
	  // Bit 8: Undefined, 0 only
	  // Bit 7: Undefined, 0 only
	  // Bit 6: Undefined, 0 only
	  // Bit 5: Undefined, 0 only
	  // Bit 4: DS18B20 1 = Enable, 0 = Disable
	  // Bit 3: MQTT 1 = Enable, 0 = Disable
	  // Bit 2: Home Assistant Auto Discovery 1 = Enable, 0 = Disable
	  // Bit 1: Duplex 1 = Full, 0 = Half
	  // There is only 1 'g' ID so we don't need to check the nParsedNum.
	  
	  // Convert Config settngs byte into two hex characters
          int2hex(stored_config_settings);
          *pBuffer++ = OctetArray[0];
          *pBuffer++ = OctetArray[1];
	}
	
	
        else if (nParsedMode == 'h') {
	  // This sends the Pin Control String, defined as follows:
	  // 32 characters
	  // The 32 characters represent 16 hex bytes of information in text
	  // format. Each byte is the pin_control character for each IO pin
	  // starting with pin 01 on the left.
	  // Note: Input pins needed to have the ON/OFF bit inverted if the
	  //   Invert bit is set.
	  	  
	  // Insert pin_control bytes
	  {
	    int i;
	    uint8_t j;
	    for (i = 0; i <16; i++) {
	      j = pin_control[i];
	      if ((j & 0x02) == 0x00) {
	        // This is an input pin - check the invert bit
	        if (j & 0x04) { // Invert is set - flip the ON/OFF bit
		  if (j & 0x80) j &= 0x7f;
		  else j |= 0x80;
		}
	      }
	      int2hex(j);
              *pBuffer++ = OctetArray[0];
              *pBuffer++ = OctetArray[1];
            }
	  }
	}


#if MQTT_SUPPORT == 0
        else if (nParsedMode == 'i') {
	  // This sends the IO Timer units and IO Timer values to the Browser
	  // defined as follows:
	  // 2 bytes represented as hex encoded strings (4 nibbles)
	  // Upper 2 bits are units
	  // Lower 14 bits are value
	  {
	    uint8_t j;
	    j = (uint8_t)((IO_TIMER[nParsedNum] & 0xff00) >> 8);
	    int2hex(j);
            *pBuffer++ = OctetArray[0];
            *pBuffer++ = OctetArray[1];
	    j = (uint8_t)(IO_TIMER[nParsedNum] & 0x00ff);
	    int2hex(j);
            *pBuffer++ = OctetArray[0];
            *pBuffer++ = OctetArray[1];
          }
	}
	
	
        else if (nParsedMode == 'j') {
	  // This displays IO Names in user friendly format (1 to 15 characters)
          pBuffer = stpcpy(pBuffer, IO_NAME[nParsedNum]); break;
	}
#endif // MQTT_SUPPORT


        else if (nParsedMode == 'l') {
	  // This displays MQTT Username information (0 to 10 characters)
          pBuffer = stpcpy(pBuffer, stored_mqtt_username);
	}


        else if (nParsedMode == 'm') {
	  // This displays MQTT Password information (0 to 10 characters)
          pBuffer = stpcpy(pBuffer, stored_mqtt_password);
	}


        else if (nParsedMode == 'n') {
	  // This displays the MQTT Start Status information as five
	  // red/green boxes showing Connections available, ARP status,
	  // TCP status, MQTT Connect status, and MQTT Error status.
	  no_err = 0;
          switch (nParsedNum)
	  {
	    case 0:
              // Connection request status
	      if (mqtt_start_status & MQTT_START_CONNECTIONS_GOOD) no_err = 1;
	      break;
	    case 1:
	      // ARP request status
	      if (mqtt_start_status & MQTT_START_ARP_REQUEST_GOOD) no_err = 1;
	      break;
	    case 2:
	      // TCP connection status
	      if (mqtt_start_status & MQTT_START_TCP_CONNECT_GOOD) no_err = 1;
	      break;
	    case 3:
	      // MQTT Connection status 1
	      if (mqtt_start_status & MQTT_START_MQTT_CONNECT_GOOD) no_err = 1;
              break;
	    case 4:
	      // MQTT start complete with no errors
	      if ((MQTT_error_status == 1) && ((mqtt_start_status & 0xf0) == 0xf0) ) no_err = 1;
              break;
	    default:
	      break;
	  }
	  if (no_err == 1) *pBuffer++ = '1'; // Paint a green square
	  else *pBuffer++ = '0'; // Paint a red square
	}


        else if ((nParsedMode == 't') && (stored_config_settings & 0x08)) {
	  // This displays temperature sensor data for 5 sensors and the
	  // text fields around that data IF DS18B20 mode is enabled.
	  
	  if (nParsedNum == 0) {
	    #define TEMPTEXT "<p>Temperature Sensors<br>"
	    pBuffer = stpcpy(pBuffer, TEMPTEXT);
	    #undef TEMPTEXT
	  }
	  
	  // Output the sensor ID numbers
	  // For display we output the MSByte first followed by remaining
	  // bytes. A total of 6 bytes are displayed in hex encoded format.
	  if (nParsedNum <= numROMs) {
	    *pBuffer++ = ' ';
	    {
	      int i;
	      for (i=6; i>0; i--) {
	        int2hex(FoundROM[nParsedNum][i]);
	        pBuffer = stpcpy(pBuffer, OctetArray);
	      }
              pBuffer = stpcpy(pBuffer, " ");
	    }
	  }
	  // If the sensor does not exist ...
	  else {
	    pBuffer = stpcpy(pBuffer, " ------------ ");
	  }
	  
	  // Output temperature data
          pBuffer = show_temperature_string(pBuffer, nParsedNum);
	  if (nParsedNum == 4) {
	    #define TEMPTEXT "</p>"
	    pBuffer = stpcpy(pBuffer, TEMPTEXT);
	    #undef TEMPTEXT
	  }
	}


        else if (nParsedMode == 'w') {
	  // This displays Code Revision information (13 characters)
          pBuffer = stpcpy(pBuffer, code_revision);
	}


        else if (nParsedMode == 'y') {
          // Indicates the need to insert one of several commonly occuring HTML
          // strings. These strings were created to aid in compressing the web
	  // page templates stored in flash memory by storing the strings once,
	  // then inserting them in the web page template as that template is
	  // sent to the browser for display.
	  //
	  // Processing of a long string insertion is a special case and may
	  // bridge over more than one call to the CopyHttpData() function. This
	  // is to better utilize the transmit buffer. Without the "bridging" the
	  // function would have to always make sure there is enough buffer space
	  // to hold the longest string, whether a string is being sent or not.
	  // This would waste buffer space and require many more packets to send
	  // an HTML page.
	  //
	  // Bridging of calls to the CopyHttpData() function is acomplished as
	  // follows:
	  // a) If a %yxx placeholder is detected in the template as much of the
	  //    replacement string is inserted in the send buffer as possible.
	  // b) A three byte "insertion_flag" array is filled to contain the index
	  //    into the string being inserted into the transmit buffer, the
	  //    nParsedMode, and the nParsedNum. If the index is non-zero we know
	  //    we are in the process of inserting a %yxx string. If the index is
	  //    zero we are NOT in the process of inserting a %yxx string.
	  // c) If the CopyHttpData() function hits the maximum character
	  //    insertion limit for the packet it does a normal return to the
	  //    calling function, and the insertion_flag array contains
	  //    the information needed to continue the string insertion on the
	  //    next call to CopyHttpData().
	  // d) If the entire string is inserted successfully byte 0 of the
	  //    insertion_flag array is cleared to 0.
	  // d) When CopyHttpData() is called again it will check insertion_flag[0]
	  //    to determine if a string insertion was previously underway. If so
	  //    the function will jump back to this point in the routine and will
	  //    continue the string insertion.
	  // insertion_flag array definition
	  //   insertion_flag[0] = insertion byte count
	  //   insertion_flag[1] = nParsedMode
	  //   insertion_flag[2] = nParsedNum
          
	  // insertion_flag[0] will be 0 if we are just starting insertion of a
	  //   string.
	  // insertion_flag[0] will be non-0 if a string insertion was started and
	  //   is not yet complete. In this case insertion_flag[0] is an index to
	  //   the next character in the source string that is to be inserted into
	  //   the transmit buffer.
	  
	  i = insertion_flag[0];
	  insertion_flag[1] = nParsedMode;
	  insertion_flag[2] = nParsedNum;
	  
	  // The insertion strings are stored as an array of strings. nParsedNum
	  // is used as an index to select the needed string, and i is used as
	  // an index to single characters in each string. Also, the string
	  // length for each string in the "array of strngs" is stored in an
	  // "array of string lengths" with nParsedNum again used as an index
	  // to select the correct value.
          // Access the strings and string lengths as follows:
          // ps[i].str
          // ps[i].size
          *pBuffer = (uint8_t)ps[nParsedNum].str[i];
	  insertion_flag[0]++;
	  if (insertion_flag[0] == ps[nParsedNum].size) insertion_flag[0] = 0;
          pBuffer++;
	}
      }


      else {
        // If the above code did not process a "%" nParsedMode code and we were
	// not continuing a string insertion then whatever character we read from
	// the page template is copied to the uip_buf for transmission.
        *pBuffer = nByte;
        *ppData = *ppData + 1;
        *pDataLeft = *pDataLeft - 1;
        pBuffer++;
      }
    }
    else break;
  }
  return (pBuffer - pBuffer_start);
}


char *show_temperature_string(char *pBuffer, uint8_t nParsedNum)
{
  // Display temperature strings in degrees C and degrees F
  // Note: &#8451; inserts a degree symbol followed by C.
  // Note: &#8457; inserts a degree symbol followed by F.
  convert_temperature(nParsedNum, 0);      // Convert to degrees C in OctetArray
  pBuffer = stpcpy(pBuffer, OctetArray);     // Display sensor value
  #define TEMPTEXT "&#8451; "              // Display degress C symbol
  pBuffer = stpcpy(pBuffer, TEMPTEXT);
  #undef TEMPTEXT
  
  convert_temperature(nParsedNum, 1);      // Convert to degrees F in OctetArray
  pBuffer = stpcpy(pBuffer, OctetArray);     // Display sensor value
  #define TEMPTEXT "&#8457;<br>"           // Display degress F symbol
  pBuffer = stpcpy(pBuffer, TEMPTEXT);
  #undef TEMPTEXT
  
  return pBuffer;
}


void HttpDInit()
{
  //Start listening on our port
  uip_listen(htons(Port_Httpd));
  current_webpage = WEBPAGE_IOCONTROL;
  
  // Initialize the insertion string flag
  
  insertion_flag[0] = 0;
  insertion_flag[1] = 0;
  insertion_flag[2] = 0;
  
  // Initialize fragment reassembly values
  saved_nstate = STATE_NULL;
  saved_nparseleft = 0;
}


void HttpDCall(uint8_t* pBuffer, uint16_t nBytes, struct tHttpD* pSocket)
{
  uint16_t nBufSize;
  int i;
  uint8_t j;
  char local_buf[300];
  uint16_t local_buf_index_max;
  
  i = 0;
  j = 0;
  local_buf_index_max = 290; // local_buf index maximum

  if (uip_connected()) {
    //Initialize this connection

    if (current_webpage == WEBPAGE_IOCONTROL) {
      pSocket->pData = g_HtmlPageIOControl;
      pSocket->nDataLeft = (uint16_t)(sizeof(g_HtmlPageIOControl) - 1);
      // nDataLeft above is used when we get around to calling CopyHttpData
      // in state STATE_SENDDATA
    }
    
    else if (current_webpage == WEBPAGE_CONFIGURATION) {
      pSocket->pData = g_HtmlPageConfiguration;
      pSocket->nDataLeft = (uint16_t)(sizeof(g_HtmlPageConfiguration) - 1);
    }

#if UIP_STATISTICS == 1 && MQTT_SUPPORT == 0
    else if (current_webpage == WEBPAGE_STATS1) {
      pSocket->pData = g_HtmlPageStats1;
      pSocket->nDataLeft = (uint16_t)(sizeof(g_HtmlPageStats1) - 1);
    }
#endif // UIP_STATISTICS

#if DEBUG_SUPPORT == 11 || DEBUG_SUPPORT == 15
    else if (current_webpage == WEBPAGE_STATS2) {
      pSocket->pData = g_HtmlPageStats2;
      pSocket->nDataLeft = (uint16_t)(sizeof(g_HtmlPageStats2) - 1);
    }
#endif // DEBUG_SUPPORT

#if DEBUG_SENSOR_SERIAL == 1
    else if (current_webpage == WEBPAGE_SENSOR_SERIAL) {
      pSocket->pData = g_HtmlPageTmpSerialNum;
      pSocket->nDataLeft = (uint16_t)(sizeof(g_HtmlPageTmpSerialNum) - 1);
    }
#endif // DEBUG_SENSOR_SERIAL

    else if (current_webpage == WEBPAGE_SSTATE) {
      pSocket->pData = g_HtmlPageSstate;
      pSocket->nDataLeft = (uint16_t)(sizeof(g_HtmlPageSstate) - 1);
    }

    pSocket->nState = STATE_CONNECTED;
    pSocket->nPrevBytes = 0xFFFF;

    // Note on TCP Fragment reassembly: The uip_connected() steps ABOVE are
    // run for every TCP packet and fragment. That being the case we need to
    // be sure that TCP Fragment reassembly values are not changed in these
    // steps.
  }


  else if (uip_newdata() || uip_acked()) {
    if (uip_acked()) {
      // if uip_acked() is true we will be in the STATE_SENDDATA state and
      // only need to run the "senddata" part of this routine. This typically
      // happens when there are multiple packets to send to the Broswer in
      // response to a POST, so we may repeat this loop in STATE_SENDDATA
      // several times.
      goto senddata;
    }
    // In this limited application the only "new data" packets a browser can
    // send to the web server are "POST" or "GET" packets, as the browser can
    // only reply to the pages the web server sent to it. We're going to parse
    // the data portion of the packet.
    //
    // This code will re-assemble POST/GET datagrams that arrive in
    // "fragmented" packets. Note that we are not really receiving "fragments"
    // in the traditional sense of an original packet being broken up by
    // router points in the network. In that case we could have used the MF
    // flag ("More Fragments") in the IP Header as each packet arrived to
    // determine if the final packet was received. But in this case we have
    // given the remote host a packet size limitation (via MSS settings), and
    // the remote host has broken up the TCP datagram into small packets. There
    // is nothing in the IP or TCP headers that shows a clear connection
    // between the packets except for the sequence and ack numbers. That being
    // the case this code relies on the nParseLeft value to determine when a
    // sequence of packets with the TCP datagram in it completes.
    //
    // While possibly a misnomer, I will call these "TCP Fragments" in the
    // comments in this code.
    //
    // The TCP Fragments are tracked and reassembled by saving the parse state
    // and values at each step in the parsing so that incomplete parse steps
    // can be continued when the next packet in a TCP Fragment series arrives.
    // Note that it is possible for one of the following to happen:
    //   1) POST/GET data can arrive complete in the first packet (no TCP
    //      Fragments).
    //   2) TCP Fragment packets can be anywhere from 2 to "many" packets, and
    //      the fragment break can be at any character in datagram - it can
    //      even occur at the last character of the POST/GET data where there
    //      is nothing useful left to parse, but there might still be a tiny
    //      fragment coming in to complete the TCP Fragment series. Note this
    //      should never happen if we parse the end of POST data.
    //   3) The first POST/GET packet will always start with "POST" or "GET "
    //      as the first characters in the datagram. This comes right after
    //      the LLH, IP, and TCP Headers, so it will start at byte 55 of the
    //      uip_buf. We won't count on that exact byte number, but it is
    //      reasonable to assume that the buffer is always 400 bytes or more,
    //      and that the "POST" or "GET " phrase will be completely contained
    //      within the first packet, thus the phrase itself will never be
    //      fragmented.
    //   3a) Once the "POST" phrase is found it can be followed in the
    //      datagram by a very long HTML preamble (the overhead stuff sent by
    //      browsers that precedes the POST data content ... hundreds of
    //      bytes). So it is very likely that TCP Fragments will occur within
    //      this preamble area before we find the actual POST data, or that
    //      the preamble will cause the POST data to get pushed onto a
    //      fragmentation boundary.
    //   3b) Likewise the GET request can be followed by a very long HTML
    //      preamble (I guess I should call it a post-amble in this case). The
    //      post-amble can also be hundreds of bytes. It is less problematic
    //      in the GET case because everything we want to parse from the GET
    //      message will occur prior to the post-amble and has zero chance of
    //      being fragmented. So the code is not written to handle any
    //      fragmentation of GET requests.
    //   3c) This code by-passes all the preamble/post-amble stuff but saves
    //      the parsing state so it knows we are either looking for data or
    //      disposing of extraneous fragments.
    //
    // The "saved_nstate" value starts out as STATE_NULL if this is the first
    // packet in a parse. If we already finished collecting all useful data in
    // a POST/GET parse (in the first fragment or a subsequent fragment, but
    // perhaps still had an outstanding "non-useful fragment") the saved_nstate
    // will also be STATE_NULL. Arriving here with saved_nstate != STATE_NULL
    // means we are processing a packet fragment and need to restore our
    // previous state information so that we continue parsing at the point
    // where we left off in the previous fragment.
    //
    if (saved_nstate != STATE_NULL) {
      // This point in the code will only be entered if we are parsing a TCP
      // Fragment (a "continuation" packet that comes after the first packet
      // in a POST). While processing a prior packet the parse was interrupted
      // by the end of the packet. This code will restore where we were in the
      // parsing loop. This process relies on no "out of order" packets.
      //
      // Note: This restoration is only needed if we hit a packet boundary
      // while searching for the \r\n\r\n sequence in a POST. All other packet
      // boundaries do not require any restoration as the boundary will be
      // handled in the STATE_PARSEPOST code.
      pSocket->nState = saved_nstate;
        // saved_nstate can be one of these:
	//   STATE_GOTPOST
	//   STATE_PARSEPOST
	//   STATE_NULL
	//   A TCP Fragment break can occur in any of these states.
	// A TCP Fragment cannot occur in these states:
	//   STATE_CONNECTED
	//   STATE_SENDHEADER204,
	//   STATE_SENDDATA
	//   STATE_PARSEGET
      pSocket->nParseLeft = saved_nparseleft;
        // nParseLeft is the number of bytes left to parse in the POST data
      pSocket->nNewlines = saved_newlines;
        // nNewlines tracks where we are in detecting the \r\n\r\n sequence
	// that indicates start of POST data
    }

      
    // In the code below we are parsing for the "POST" or "GET " phrase. We do
    // not need to worry about TCP fragmentation because the phrase will appear
    // very early in the first packet (easily within the first 100 bytes).
    // However, once we receive "POST" we go into a loop looking for the
    // "\r\n\r\n" sequence, and we need to be able to handle TCP fragmentation
    // during that search.
    //
    // If we are parsing a TCP fragment then pSocket->nState may have been
    // restored to STATE_PARSEPOST or STATE_PARSEGET. If so the parse code will
    // run but won't do anything.
    
    // If we are in STATE_CONNECTED (meaning we are reading the
    // first and perhaps only packet in a series) check the first
    // five characters of the uip_buf to see if this is a POST or
    // GET request.
    if (pSocket->nState == STATE_CONNECTED) {
      if (memcmp("POST", &pBuffer[0], 4) == 0) pSocket->nState = STATE_GOTPOST;
      if (memcmp("GET", &pBuffer[0], 3) == 0)  pSocket->nState = STATE_GOTGET;
      pBuffer += 4;
      nBytes -= 4;
      // We are in STATE_NULL, which means we are collecting the first packet.
      // Clear parse_tail so it will be ready if there is a TCP Fragment.
      parse_tail[0] = '\0';
    }
    

    if (pSocket->nState == STATE_GOTPOST) {
      //Search for \r\n\r\n
      saved_nstate = STATE_GOTPOST;
      if (nBytes == 0) {
        // If we enter the search at end of fragment we exit and will come
	// back to this point with the next fragment.
	saved_newlines = pSocket->nNewlines;
        return;
      }

      while (nBytes != 0) {
  	// We're processing packets but haven't found the \r\n\r\n sequence
	// yet. The sequence detector really just looks for two \n in a row,
	// ignoring the first \r. If any other character other than \r
	// appears between the \n and \n the counter is zero'd.
	if (saved_newlines == 2) {
	  // This handles the case where a TCP Fragment occcured just as we
	  // collected the second \n
	}
	else {
          if (*pBuffer == '\n') pSocket->nNewlines++;
          else if (*pBuffer == '\r') { }
          else pSocket->nNewlines = 0;
          pBuffer++;
          nBytes--;
          if (nBytes == 0) {
            // If we hit end of fragment we exit and will come back to the loop
            // with the next fragment.
            saved_newlines = pSocket->nNewlines;
            return;
          }
        }
	 
	// XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
	// What if we never find it?
	// The POST packet will be disregarded.
	// XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX

        if (pSocket->nNewlines == 2) {
          // Beginning found.
          // Initialize Parsing variables
          if (current_webpage == WEBPAGE_IOCONTROL) {
	    pSocket->nParseLeft = PARSEBYTES_IOCONTROL;
	  }
          if (current_webpage == WEBPAGE_CONFIGURATION) {
	    pSocket->nParseLeft = PARSEBYTES_CONFIGURATION;
	  }
	  saved_nparseleft = pSocket->nParseLeft;
          // Start parsing
          pSocket->nState = STATE_PARSEPOST;
	  saved_nstate = STATE_PARSEPOST;
	  if (nBytes == 0) {
	    // If we are at end of fragment here we exit and will return in
	    // STATE_PARSEPOST
	    return;
	  }
          break;
        }
      }
    }


    if (pSocket->nState == STATE_GOTGET) {
      // Don't search for \r\n\r\n ... instead parse what we've got
      // Initialize Parsing variables
      // Small parse number since we should have short filenames
      pSocket->nParseLeft = 6;
      pSocket->ParseState = PARSE_SLASH1;
      // Start parsing
      pSocket->nState = STATE_PARSEGET;
    }


    if (pSocket->nState == STATE_PARSEPOST) {
      // Parse pre-process
      // Copy the POST from the uip_buf to the local_buf until one of two
      // things happens:
      // a) The local_buf is full
      // b) The end of the uip_buf is reached (end of the packet)
      //
      // Copy each POST component to the parse_tail as they are found.
      // As each POST component is found it will replace the prior POST
      // component. The objective is to let the parse_tail contain any
      // partial POST that appears at the tail of the current packet.
      
      uint16_t i = 0;
      uint16_t j = 0;

      // If we are continuing data collection due to a TCP Fragment parse_tail
      // will have any fragment of the previous POST in it. Otherwise
      // parse_tail is NULL. We need to restore the parse_tail to the start of
      // the local_buf so that additional data will be added to it.
      strcpy(local_buf, parse_tail);
      i = strlen(parse_tail);
      
      while (1) {
        local_buf[i] = *pBuffer;
	local_buf[i+1] = '\0';
	parse_tail[j] = *pBuffer;
	parse_tail[j+1] = '\0';
	pBuffer++;
	nBytes--;
	i++;
	j++;
	
	if (nBytes == 0) {
	  // Hit end of packet
	  if (strcmp(parse_tail, "&z00=0") == 0) {
	    // If this is also the end of the POST (as indicated by parse_tail
	    // equal to "&z00=0") then send the entire local_buf to parsing.
	    // Parse the local_buf
//
// UARTPrintf("parse_tail: \r\n");
// UARTPrintf(parse_tail);
// UARTPrintf("\r\n");
// UARTPrintf("End of POST: \r\n");
// UARTPrintf(local_buf);
// UARTPrintf("\r\n");
//
//
//
	    parse_local_buf(pSocket, local_buf, strlen(local_buf));
	    break;
	  }
	  
	  else {
	    // We don't have all the POST data - it will be arriving in
	    // subsequent packets
	    //
	    // There can be two cases at this point:
	    //   1) We received a part of the first POST component, in which
	    //      case the partial POST component in the parse_tail will not
	    //      start with a & symbol, and there is no useful data in the
	    //      local_buf
	    //   2) We received a part of a POST component after the first
	    //      POST component, in which case the partial POST component
	    //      in the parse_tail will start with a & symbol, and there is
	    //      data in the local_buf that must be parsed
	    
	    // Handle the case where parse_tail does not start with &
	    if (parse_tail[0] != '&') break;
	    
	    // Handle the case where parse tail DOES start with &
	    else {
              // Back up the NULL terminator in the local_buf to the point where
              // the last POST component ended. Note that this will eliminate
              // one delimiter search in POST parsing so we need to decrement
              // the nParseLeft value by one for this case.
              i = i - strlen(parse_tail);
              local_buf[i] = '\0';
              pSocket->nParseLeft--;
              
              // Parse the local_buf
//
// UARTPrintf("parse_tail: \r\n");
// UARTPrintf(parse_tail);
// UARTPrintf("\r\n");
// UARTPrintf("local_buf: \r\n");
// UARTPrintf(local_buf);
// UARTPrintf("\r\n");
//
//
//
              parse_local_buf(pSocket, local_buf, strlen(local_buf));
              // Save the nParseLeft value for the next pass
              saved_nparseleft = pSocket->nParseLeft;
              
              // Shift the content of parse_tail to eliminate the '&'
              strcpy(parse_tail, &parse_tail[1]);
              break;
            }
          }
	}
	
	if (i == local_buf_index_max) {
	  // Hit end of local_buf
	  // We don't yet have all the data from this packet but need to
	  // parse what we have so far.
	  // The local_buf only contains POST data, and we can't hit the
	  // end of the local_buf unless multiple posts have been collected,
	  // so, no need to handle special cases like receiving a partial
	  // first POST component.
	  //
          // Back up the NULL terminator in the local_buf to the point where
          // the last POST component ended. Note that this will eliminate
          // one delimiter search in POST parsing so we need to decrement
          // the nParseLeft value by one for this case.
          i = i - strlen(parse_tail);
          local_buf[i] = '\0';
          pSocket->nParseLeft--;
	  
	  // Parse the local_buf
	  parse_local_buf(pSocket, local_buf, strlen(local_buf));
	  
	  // Shift the content of parse_tail to eliminate the '&'
          strcpy(parse_tail, &parse_tail[1]);
	  
	  // There is still more POST data in the uip_buf. Restore the
	  // partial POST component to the local_buf and reset the index
	  // values so the while() loop can continue data collection.
          strcpy(local_buf, parse_tail);
          i = strlen(parse_tail); // Note: parse_tail might be empty
	  // Note: the "j" index into parse_tail is not reset in this
	  // case as the packet might end before the parse_tail is
	  // completely collected.
	  continue;
	}
	
	if (*pBuffer == '&') {
	  // Starting a new POST component collection.
	  // Reset j so the parse_tail will fill with the new POST component.
	  j = 0;
	  parse_tail[0] = '\0';
	  continue;
	}
      }
    }
    

    if (pSocket->nState == STATE_PARSEGET) {
      // This section will parse a GET request sent by the user. Normally in a
      // general purpose web server a GET request would be used to obtain
      // files or other items from the server. In that general case the data
      // that follows "GET " is a "/path/filename" (path optional). In this
      // application we'll use "filename" to command the web server to perform
      // internal operations. For instance, performing a GET for filename "42"
      // (with a "/42") might turn an output on, or might command transmission
      // of a specific web page, rather than retrieve a file.
      //
      // At this point the "GET " (GET plus space) part of the request has
      // been parsed. The "GET " should be followed by "/filename". So we look
      // for the "/" and collect the next two characters as the fake
      // "filename".
      //
      // Fragmentation note: We don't need to collect any state information in
      // this parse process as anything we are collecting will easily fit in
      // the first 100 bytes of the first packet ... so no fragmentation will
      // occur.
      //
      // Browser note: Looks like some browsers get creative and do things
      // like requesting "favicon.ico" from the server. This causes the code
      // below to execute - and in the original code it caused confusion as I
      // would send the IOControl web page if I didn't understand the inquiry.
      // Now I will just throw the request away if it doesn't exactly match an
      // expected request. The only exception will be if I get a "/" or "/ "
      // then I will send the IOControl web page.

      while (nBytes != 0) {
        if (pSocket->ParseState == PARSE_SLASH1) {
	  // When we entered the loop *pBuffer should already be pointing at
	  // the "/". If there isn't one we should display the IOControl page.
          pSocket->ParseCmd = *pBuffer;
          pSocket->nParseLeft--;
          pBuffer++;
	  nBytes--;
	  if (pSocket->ParseCmd == (uint8_t)0x2f) { // Compare to '/'
	    pSocket->ParseState = PARSE_NUM10;
	  }
          else {
            // Didn't find '/' - send default page
	    current_webpage = WEBPAGE_IOCONTROL;
            pSocket->pData = g_HtmlPageIOControl;
            pSocket->nDataLeft = (uint16_t)(sizeof(g_HtmlPageIOControl) - 1);
            pSocket->nParseLeft = 0; // This will cause the while() to exit
            pSocket->nState = STATE_CONNECTED;
            pSocket->nPrevBytes = 0xFFFF;
	  }
        }

        else if (pSocket->ParseState == PARSE_NUM10) {
	  // It's possible we got here because the user did not request a
	  // filename (ie, the user entered "192.168.1.4:8080/". In this case
	  // there will be a space here instead of a digit, and we should just
	  // exit the while() loop and send the IOControl page.
	  if (*pBuffer == ' ') {
	    current_webpage = WEBPAGE_IOCONTROL;
            pSocket->pData = g_HtmlPageIOControl;
            pSocket->nDataLeft = (uint16_t)(sizeof(g_HtmlPageIOControl) - 1);
            pSocket->nParseLeft = 0;
            pSocket->nState = STATE_CONNECTED;
            pSocket->nPrevBytes = 0xFFFF;
	  }
	  // Parse first ParseNum digit. Looks like the user did input a
	  // filename digit, so collect it here.
	  else if (isdigit(*pBuffer)) { // Check for user entry error
            // Still good - parse number
            pSocket->ParseNum = (uint8_t)((*pBuffer - '0') * 10);
	    pSocket->ParseState = PARSE_NUM1;
            pSocket->nParseLeft--;
            pBuffer++;
	    nBytes--;
	  }
	  else {
	    // Something out of sync or invalid filename - exit while() loop
	    // but do not change the current_webpage
            pSocket->nParseLeft = 0;
            pSocket->ParseState = PARSE_FAIL;
	  }
        }
	
	// Parse second ParseNum digit
        else if (pSocket->ParseState == PARSE_NUM1) {
	  if (isdigit(*pBuffer)) { // Check for user entry error
            // Still good - parse number
            pSocket->ParseNum += (uint8_t)(*pBuffer - '0');
            pSocket->ParseState = PARSE_VAL;
            pSocket->nParseLeft = 1; // Set to 1 so PARSE_VAL will be called
            pBuffer++;
	    nBytes--;
	  }
	  else {
	    // Something out of sync or invalid filename - exit while() loop
	    // but do not change the current_webpage
            pSocket->nParseLeft = 0;
            pSocket->ParseState = PARSE_FAIL;
	  }
	}
	
        else if (pSocket->ParseState == PARSE_VAL) {
	  // ParseNum should now contain a two digit "filename". The filename
	  // is used to command specific action by the webserver. Following
	  // are the commands for the Network Module.
	  //
	  // From a fragment perspective we already received all the useful
	  // information, so we can clear the saved states and process what
	  // we've got. If another fragment still follows it won't have
	  // anything useful in it and processing of the fragment won't cause
	  // anything to happen.
	  //
	  // For 00-31, 55, and 56 you wonâ€™t see any screen updates unless you
	  // are already on the IO Control page or the Short Form IO States
	  // page of the webserver.
	  //
	  // Note: Only those Output ON/OFF commands that correspond to a pin
	  // configured as an Output will work.
	  //
	  // http://IP/00  Output-01OFF
	  // http://IP/01  Output-01ON
	  // http://IP/02  Output-02OFF
	  // http://IP/03  Output-02ON
	  // http://IP/04  Output-03OFF
	  // http://IP/05  Output-03ON
	  // http://IP/06  Output-04OFF
	  // http://IP/07  Output-04ON
	  // http://IP/08  Output-05OFF
	  // http://IP/09  Output-05ON
	  // http://IP/10  Output-06OFF
	  // http://IP/11  Output-06ON
	  // http://IP/12  Output-07OFF
	  // http://IP/13  Output-07ON
	  // http://IP/14  Output-08OFF
	  // http://IP/15  Output-08ON
	  // http://IP/16  Output-09OFF
	  // http://IP/17  Output-09ON
	  // http://IP/18  Output-10OFF
	  // http://IP/19  Output-10ON
	  // http://IP/20  Output-11OFF
	  // http://IP/21  Output-11ON
	  // http://IP/22  Output-12OFF
	  // http://IP/23  Output-12ON
	  // http://IP/24  Output-13OFF
	  // http://IP/25  Output-13ON
	  // http://IP/26  Output-14OFF
	  // http://IP/27  Output-14ON
	  // http://IP/28  Output-15OFF
	  // http://IP/29  Output-15ON
	  // http://IP/30  Output-16OFF
	  // http://IP/31  Output-16ON
	  // http://IP/55  All Outputs ON
	  // http://IP/56  All Outputs OFF
	  //
	  // http://IP/60  Show IO Control page
	  // http://IP/61  Show Configuration page
	  // http://IP/63  Show Help page (deprecated)
	  // http://IP/64  Show Help2 page (deprecated)
	  // http://IP/65  Flash LED 3 times
	  // http://IP/66  Show Link Error Statistics page
	  // http://IP/67  Clear Link Error Statistics and refresh page
	  // http://IP/68  Show Network Statistics page
	  // http://IP/69  Clear Network Statistics and refresh page
          // http://IP/70  Clear the "Reset Status Register" counters
	  // http://IP/91  Reboot
	  // http://IP/98  Show Very Short Form IO States page
	  // http://IP/99  Show Short Form IO States page
	  //
          switch(pSocket->ParseNum)
	  {
	    case 55:
	      // Turn all outputs ON. Verify that each pin is an output
	      // and that it is enabled.
	      for (i=0; i<16; i++) {
 		Pending_pin_control[i] = pin_control[i];
                if ((pin_control[i] & 0x03) == 0x03) {
                  // The above: If an Enabled Output, then turn on the pin
                  Pending_pin_control[i] |= 0x80;
	        }
              }
	      parse_complete = 1; 
	      break;
	      
	    case 56:
	      // Turn all outputs OFF. Verify that each pin is an output
	      // and that it is enabled.
	      for (i=0; i<16; i++) {
		Pending_pin_control[i] = pin_control[i];
                if ((pin_control[i] & 0x03) == 0x03) {
                  // The above: If an Enabled Output, then turn off the pin
                  Pending_pin_control[i] &= 0x7f;
	        }
              }
	      parse_complete = 1; 
	      break;

	    case 60: // Show IO Control page
	      current_webpage = WEBPAGE_IOCONTROL;
              pSocket->pData = g_HtmlPageIOControl;
              pSocket->nDataLeft = (uint16_t)(sizeof(g_HtmlPageIOControl) - 1);
              pSocket->nState = STATE_CONNECTED;
              pSocket->nPrevBytes = 0xFFFF;
	      break;
	      
	    case 61: // Show Configuration page
	      current_webpage = WEBPAGE_CONFIGURATION;
              pSocket->pData = g_HtmlPageConfiguration;
              pSocket->nDataLeft = (uint16_t)(sizeof(g_HtmlPageConfiguration) - 1);
              pSocket->nState = STATE_CONNECTED;
              pSocket->nPrevBytes = 0xFFFF;
	      break;

	    case 65: // Flash LED for diagnostics
	      // XXXXXXXXXXXXXXXXXXXXXX
	      // XXXXXXXXXXXXXXXXXXXXXX
	      // XXXXXXXXXXXXXXXXXXXXXX
	      debugflash();
	      debugflash();
	      debugflash();
	      // XXXXXXXXXXXXXXXXXXXXXX
	      // XXXXXXXXXXXXXXXXXXXXXX
	      // XXXXXXXXXXXXXXXXXXXXXX
	      break;

#if DEBUG_SUPPORT == 11 || DEBUG_SUPPORT == 15
            case 66: // Show Link Error Statistics page
	      current_webpage = WEBPAGE_STATS2;
              pSocket->pData = g_HtmlPageStats2;
              pSocket->nDataLeft = (uint16_t)(sizeof(g_HtmlPageStats2) - 1);
              pSocket->nState = STATE_CONNECTED;
              pSocket->nPrevBytes = 0xFFFF;
	      break;
	      
            case 67: // Clear Link Error Statistics
	      // Clear the the Link Error Statistics bytes.
	      // Important: 
	      // The debug[] byte indexes used may change if the
	      // number of debug bytes changes.
	      debug[23] = 0; // Clear TXERIF counter
	      debug[24] = 0; // Clear RXERIF counter
	      update_debug_storage1();
	      TRANSMIT_counter = 0;
	      MQTT_resp_tout_counter = 0;
	      MQTT_not_OK_counter = 0;
	      MQTT_broker_dis_counter = 0;
	      
	      current_webpage = WEBPAGE_STATS2;
              pSocket->pData = g_HtmlPageStats2;
              pSocket->nDataLeft = (uint16_t)(sizeof(g_HtmlPageStats2) - 1);
              pSocket->nState = STATE_CONNECTED;
              pSocket->nPrevBytes = 0xFFFF;
	      break;
#endif // DEBUG_SUPPORT

#if UIP_STATISTICS == 1 && MQTT_SUPPORT == 0
            case 68: // Show Network Statistics page
	      current_webpage = WEBPAGE_STATS1;
              pSocket->pData = g_HtmlPageStats1;
              pSocket->nDataLeft = (uint16_t)(sizeof(g_HtmlPageStats1) - 1);
              pSocket->nState = STATE_CONNECTED;
              pSocket->nPrevBytes = 0xFFFF;
	      break;
	      
            case 69: // Clear Network Statistics and refresh page
	      uip_init_stats();
	      current_webpage = WEBPAGE_STATS1;
              pSocket->pData = g_HtmlPageStats1;
              pSocket->nDataLeft = (uint16_t)(sizeof(g_HtmlPageStats1) - 1);
              pSocket->nState = STATE_CONNECTED;
              pSocket->nPrevBytes = 0xFFFF;
	      break;
#endif // UIP_STATISTICS

#if DEBUG_SUPPORT == 11 || DEBUG_SUPPORT == 15
            case 70: // Clear the "Reset Status Register" counters
	      // Clear the counts for EMCF, SWIMF, ILLOPF, IWDGF, WWDGF
	      // These only display via the UART
	      // Important: 
	      // The debug[] byte indexes used may change if the
	      // number of debug bytes changes.
	      for (i = 25; i < 30; i++) debug[i] = 0;
	      update_debug_storage1();
	      break;
#endif // DEBUG_SUPPORT

#if DEBUG_SENSOR_SERIAL == 1
            case 71: // Display the Temperature Sensor Serial Numbers
	      current_webpage = WEBPAGE_SENSOR_SERIAL;
              pSocket->pData = g_HtmlPageTmpSerialNum;
              pSocket->nDataLeft = (uint16_t)(sizeof(g_HtmlPageTmpSerialNum) - 1);
              pSocket->nState = STATE_CONNECTED;
              pSocket->nPrevBytes = 0xFFFF;
	      break;
#endif // DEBUG_SENSOR_SERIAL

	    case 91: // Reboot
	      user_reboot_request = 1;
	      break;

            case 98: // Show Very Short Form IO state page
            case 99: // Show Short Form IO state page
	      // Normally when a page is transmitted the "current_webpage" is
	      // updated to reflect the page just transmitted. This is not
	      // done for this case as the page is very short (only requires
	      // one packet to send) and not changing the current_webpage
	      // pointer prevents "page interference" between normal browser
	      // activity and the automated functions that normally use this
	      // page.
	      current_webpage = WEBPAGE_SSTATE;
              pSocket->pData = g_HtmlPageSstate;
              pSocket->nDataLeft = (uint16_t)(sizeof(g_HtmlPageSstate) - 1);
              pSocket->nState = STATE_CONNECTED;
              pSocket->nPrevBytes = 0xFFFF;
	      break;

	    default:
	      if (pSocket->ParseNum < 32) {
                // Output-01..16 OFF/ON
                update_ON_OFF((uint8_t)(pSocket->ParseNum/2), (uint8_t)(pSocket->ParseNum%2));
              }
              else {
	        // Show IO Control page
	        current_webpage = WEBPAGE_IOCONTROL;
                pSocket->pData = g_HtmlPageIOControl;
                pSocket->nDataLeft = (uint16_t)(sizeof(g_HtmlPageIOControl) - 1);
                pSocket->nState = STATE_CONNECTED;
                pSocket->nPrevBytes = 0xFFFF;
              }
              break;

	  } // end switch
          pSocket->nParseLeft = 0;
        }

        if (pSocket->ParseState == PARSE_FAIL) {
          // Parsing failed above. By going to STATE_SENDHEADER200 
	  // javascript should repaint the page already sent. While
	  // inefficient this will satisfy the browser's need for a
	  // reply when it requests favicon.ico or whatever else it
	  // requests that we don't have.
          pSocket->nState = STATE_SENDHEADER200;
	  break;
	}

        if (pSocket->nParseLeft == 0) {
          // Finished parsing ... even if nBytes is not zero
	  // Send the response
          pSocket->nState = STATE_SENDHEADER200;
          break;
        }
      }
    }

    if (pSocket->nState == STATE_SENDHEADER200) {
      // This step is entered after GET processing is complete in order to
      // send an appropriate web page. In the uip_send() call we provide the
      // CopyHttpHeader function with the length of the web page. If no page
      // is being returned a length of zero is provided to CopyHttpHeader().
      uip_send(uip_appdata, CopyHttpHeader(uip_appdata, adjust_template_size()));
      pSocket->nState = STATE_SENDDATA;
      return;
    }
      
    if (pSocket->nState == STATE_SENDHEADER204) {
      // This step is entered after POST is complete. Content Length: 0 must
      // be returned in this case and we must send no data. The javascript in
      // the IOControl and Configuration pages generates a GET request to
      // update the Browser page after the POST is sent.
      //
      // Note: It is not clear if some browsers require a "204 No Content"
      // header. This appears to work just returning a "200 OK" with Content
      // Length: 0.
      uip_send(uip_appdata, CopyHttpHeader(uip_appdata, 0));
      return;
    }

    senddata:
    if (pSocket->nState == STATE_SENDDATA) {
      // We have sent the HTML Header or HTML Data previously. Now we send
      // Data. Data is always sent at the end of a "uip_newdata()" response.
      // There may be more data than will fit in one packet, so that
      // additional data (if any) will be sent on return to this function in
      // response to "uip_acked()". If there is no data to send, or if all
      // data has been sent, we close the connection.
      
      if (pSocket->nDataLeft == 0) {
        // There is no data to send. Close connection
        nBufSize = 0;
      }
      else {
        // Copy data to buffer
        pSocket->nPrevBytes = pSocket->nDataLeft;
        nBufSize = CopyHttpData(uip_appdata, &pSocket->pData, &pSocket->nDataLeft, uip_mss());
        pSocket->nPrevBytes -= pSocket->nDataLeft;
      }

      if (nBufSize == 0) {
        //No Data has been copied (or there was none to send). Close connection
        uip_close();
      }
      else {
        //Else send copied data
        uip_send(uip_appdata, nBufSize);
      }
      
      return;
    }
  }
  
  else if (uip_rexmit()) {
    if (pSocket->nPrevBytes == 0xFFFF) {
      // Send header again
      uip_send(uip_appdata, CopyHttpHeader(uip_appdata, adjust_template_size()));
    }
    else {
      pSocket->pData -= pSocket->nPrevBytes;
      pSocket->nDataLeft += pSocket->nPrevBytes;
      pSocket->nPrevBytes = pSocket->nDataLeft;
      nBufSize = CopyHttpData(uip_appdata, &pSocket->pData, &pSocket->nDataLeft, uip_mss());
      pSocket->nPrevBytes -= pSocket->nDataLeft;
      
      if (nBufSize == 0) {
        //No Data has been copied. Close connection
        uip_close();
      }
      else {
        //Else send copied data
        uip_send(uip_appdata, nBufSize);
      }
    }
    return;
  }
}


void parse_local_buf(struct tHttpD* pSocket, char* local_buf, uint16_t lbi_max)
{
  uint16_t lbi; // Local buffer index
  
  // This function will parse a POST sent by the user (usually when they
  // click on the "submit" button on a webpage). POST data will consist
  // of:
  //  One digit with a ParseCmd
  //  Two digits with a ParseNum indicating the item to be changed
  //  One digit with an equal sign
  //  A variable number of characters with a ParseState indicating the
  //    new value of the item
  //  One digit with a Parse Delimiter (an '&')
  //
  // The parse pre-process has placed as much of the POST as possible
  // in the local_buf. This routine will parse that data and will seek
  // the end of the data as indicated by finding the &z00=0 POST
  // component.

  // When we parse the local_buf we always start in state PARSE_CMD
  pSocket->ParseState = PARSE_CMD;

  lbi = 0; // local buf index
  while (1) {
    // When appropriate conditions are met a break will occur to leave
    // the while loop.
    if (pSocket->ParseState == PARSE_CMD) {
      pSocket->ParseCmd = (uint8_t)(local_buf[lbi]);
      pSocket->ParseState = PARSE_NUM10;
      pSocket->nParseLeft--;
      lbi++;
    }
    
    else if (pSocket->ParseState == PARSE_NUM10) {
      pSocket->ParseNum = (uint8_t)((local_buf[lbi] - '0') * 10);
      pSocket->ParseState = PARSE_NUM1;
      pSocket->nParseLeft--;
      lbi++;
    }
    
    else if (pSocket->ParseState == PARSE_NUM1) {
      pSocket->ParseNum += (uint8_t)(local_buf[lbi] - '0');
      pSocket->ParseState = PARSE_EQUAL;
      pSocket->nParseLeft--;
      lbi++;
    }
    
    else if (pSocket->ParseState == PARSE_EQUAL) {
      pSocket->ParseState = PARSE_VAL;
      pSocket->nParseLeft--;
      lbi++;
    }
    
    else if (pSocket->ParseState == PARSE_VAL) {
      // 'a' is POST data for the Device Name
      // 'b' is POST data for the IP/Gateway/Netmask
      // 'c' is POST data for the Port number
      // 'd' is POST data for the MAC
      // 'g' is POST data for the Config settings string
      // 'h' is POST data for the Pin Control String
      // 'i' is POST data for the IO Timers
      // 'j' is POST data for the IO Names
      // 'l' is POST data for the MQTT Username
      // 'm' is POST data for the MQTT Password
      // 'z' is POST data for a hidden input used as an end-of-POST
      //     indicator
      
      // Parse 'a' 'l' 'm' 'j' ----------------------------------------------//
      if (pSocket->ParseCmd == 'a'
       || pSocket->ParseCmd == 'l'
       || pSocket->ParseCmd == 'm'
       || pSocket->ParseCmd == 'j' ) {
        // a = Update the Device Name field
        // l = Update the MQTT Username field
        // m = Update the MQTT Password field
        // j = Update the IO Name field
        
        // If parsing 'a' 'l' 'm' 'j' we know we are parsing a Configuration
        // page. Set current_webpage to WEBPAGE_CONFIGURATION so that the
        // browser will display this page after Save is clicked. This is a
        // workaround for the "multiple browser page interference" issue
        // where another browser might have changed the current_webpage
        // value.
        current_webpage = WEBPAGE_CONFIGURATION;

        {
          int i;
          uint8_t amp_found;
          char tmp_Pending[20];
          int num_chars;
	  
	  num_chars = 0;
          
          switch (pSocket->ParseCmd) {
            case 'a': num_chars = 19; break;
            case 'l':
            case 'm': num_chars = 10; break;
            case 'j': num_chars = 15; break;
          }
          
          // This function processes POST data for one of several string fields:
          //   Device Name field
          //   MQTT Username field
          //   MQTT Password field
          //   IO Name field
          //
          // POST data for strings are a special case case in that the resulting
          // string can consist of anything from 0 to X number of characters. So, we
          // have to parse until the POST delimiter '&' is found.
          //
          amp_found = 0;
          memset(tmp_Pending, '\0', 20);

          for (i = 0; i < num_chars; i++) {
            // Collect characters until num_chars are collected or '&' is found.
            if (amp_found == 0) {
              // Collect a byte of the devicename from the local_buf until the '&' is
              // found.
              if (local_buf[lbi] == '&') amp_found = 1;
              else {
                tmp_Pending[i] = local_buf[lbi];
                pSocket->nParseLeft--;
                lbi++;
              }
            }
            if (amp_found) {
              // We must reduce nParseLeft here because it is based on the PARESEBYTES_
              // value which assumes num_chars bytes for the string field. If the
              // POSTed string field is less than num_chars bytes then nParseLeft is
              // too big by the number of characters omitted and must be corrected
              // here. When we exit the loop the buffer index is left pointing at the
              // '&' which starts the next field.
              pSocket->nParseLeft--;
            }
          }
  
          switch (pSocket->ParseCmd)
	  {
	    case 'a':
	      memcpy(Pending_devicename, tmp_Pending, num_chars);
	      break;
	    case 'l':
	      memcpy(Pending_mqtt_username, tmp_Pending, num_chars);
	      break;
	    case 'm':
	      memcpy(Pending_mqtt_password, tmp_Pending, num_chars);
	      break;
	    case 'j':
#if MQTT_SUPPORT == 0
	      unlock_flash();
	      if (strcmp(IO_NAME[pSocket->ParseNum], tmp_Pending) != 0) {
	        // The write to Flash will occur 4 bytes at a time to
		// reduce Flash wear. All 16 bytes reserved in the Flash
		// for a given IO Name will be written at one time in a
		// sequence of 4 byte "word" writes.
	        i = 0;
	        while(i<16) {
	          FLASH_CR2 = 0x40;
	          FLASH_NCR2 = 0xBF;
	          memcpy(&IO_NAME[pSocket->ParseNum][i], &tmp_Pending[i], 4);
	          i += 4;
	        }
              }
	      lock_flash();
#endif // MQTT_SUPPORT
	      break;
	  }
        }
      }


      // Parse 'b' ------------------------------------------------------//
      else if (pSocket->ParseCmd == 'b') {
        // This code updates the "pending" IP address, Gateway address,
        // Netmask, and MQTT Host IP address which will then cause the
        // main.c functions to restart the software.
        // The value following the 'bxx=' ParseCmd and ParseNum consists
        // of eight alpha nibbles representing the value in hex. The
        // function call collects the alpha nibbles and converts them to
	// the numeric value used by the other firmware functions.
        {
          int i;
          int j;
          uint8_t temp;
          
          // The following updates the IP address, Gateway address, NetMask, and MQTT
          // IP Address based on GUI input.
          // The code converts eight alpha fields with hex alphas ('0' to 'f') into
          // 4 octets representing the new setting.
            
          // Convert characters of the hex string to numbers two characters
          // at a time and store the result.
          temp = 0;
          i = 0;
          j = 0;
          while (i < 8) {
            // Create a number from two hex characters
            temp = two_hex2int(local_buf[lbi], local_buf[lbi+1]);
	    lbi +=2;
            pSocket->nParseLeft -= 2;
	    i += 2;
	    
            j = (8 - i) / 2;
          	  
            switch(pSocket->ParseNum)
            {
              case 0:  Pending_hostaddr[j]       = (uint8_t)temp; break;
              case 4:  Pending_draddr[j]         = (uint8_t)temp; break;
              case 8:  Pending_netmask[j]        = (uint8_t)temp; break;
              case 12: Pending_mqttserveraddr[j] = (uint8_t)temp; break;
              default: break;
            }
          }
        }
      }


      // Parse 'c' ------------------------------------------------------//
      else if (pSocket->ParseCmd == 'c') {
        // This code updates the "pending" HTTP Port number or MQTT Port
        // number which will then cause the main.c functions to restart
        // the software.
        // ParseNum == 0 indicates the HTTP Port number.
        // ParseNum == 1 indicates the MQTT Port number.
        // The value following the 'cxx=' ParseCmd & ParseNum consists
        // of four alpha nibbles with the port number in hex form. The
        // function call collects the nibbles, validates them, and updates
        // the pending port number.
        {
          int i;
          uint16_t temp;
            
          // Code to update the Port number based on GUI input.
          // The code converts four alpha fields with hex alphas ('0' to 'f')
          // into a 16 bit number, and validates that the number is within the
          // valid range.
            
          // Convert string to 16 bit integer
          temp = 0;
          for (i=0; i<4; i++) {
            temp |= hex2int((uint8_t)local_buf[lbi]) << (12 - i*4);
	    lbi++;
            pSocket->nParseLeft--;
          }

          if (temp > 9) { // Make change only if valid entry
            if (pSocket->ParseNum == 0) Pending_port = (uint16_t)temp;
            else Pending_mqttport = (uint16_t)temp;
          }
        }
      }


      // Parse 'd' ------------------------------------------------------//
      else if (pSocket->ParseCmd == 'd') {
        // This code updates the "pending" MAC address which will then
        // cause the main.c functions to restart the software.
        // The value following the 'dxx=' ParseCmd and ParseNum consists
        // of twelve alpha nibbles in hex form ('0' to '9' and 'a' to 'f').
        // The function call collects the nibbles, validates them, and
        // updates the pending MAC number.
        {
          int i;
          uint16_t temp;
            
          // Code to update the MAC number based on GUI input.
          // The code converts twelve alpha fields with hex alphas ('0' to 'f')
          // into 6 octets representing the new setting.
	  
          // Convert characters of the hex string to numbers two
          // at a time and store the result.
          i = 0;
          while (i < 12) {
            temp = 0;
            // Create a number from two hex characters
            temp = two_hex2int(local_buf[lbi], local_buf[lbi+1]);
	    lbi +=2;
            pSocket->nParseLeft -= 2;
	    i += 2;
            // Store result in Pending_uip_ethaddr_oct. Note that order is
            // reversed in this variable.
            Pending_uip_ethaddr_oct[ (12-i)/2 ] = (uint8_t)temp;
          }
        }
      }


      // Parse 'g' ------------------------------------------------------//
      else if (pSocket->ParseCmd == 'g') {
        {
          // This code sets the Config Settings bytes which define the
          // DS18B20, MQTT, Full/Half Duplex, and Home Assistant Auto
          // Discovery functionality.
          //
          // There are always 2 characters in the string which represent a
          // hex encoded byte. Each is collected and saved for later
          // processing.
	  //
          // Convert hex nibbles to a byte and store in Config settings
	  Pending_config_settings = two_hex2int(local_buf[lbi], local_buf[lbi+1]);
	  lbi +=2;
          pSocket->nParseLeft -= 2;
        }
      }


      // Parse 'h' ------------------------------------------------------//
      else if (pSocket->ParseCmd == 'h') {
        // This code sets the Pending_pin_control bytes based on the
        // information in the 32 character string sent in the h00 field.
        //
        // There are always 32 characters in the string in 16 pairs of
        // hex encoded nibbles, each pair representing a hex encoded pin
        // control byte. The character pairs are extracted one set at a
        // time, converted to a numeric byte, and stored in their
        // corresponding Pending_pin_control byte.
        {
          int i;
          int j;
          uint8_t k;

          // Sort the alpha characters into the pin control bytes
          i = 0;
          j = 0;
          while( i<32 ) {
            // The Configuration page updates all bits except the
            // ON/OFF bit
            // The IOControl page only updates the ON/OFF bit
            Pending_pin_control[j] = pin_control[j];
            // Convert the pin control string into numeric bytes
            // two characters at a time. "k" will contain the byte
            // after conversion.
            k = two_hex2int(local_buf[lbi], local_buf[lbi+1]);
	    lbi +=2;
            pSocket->nParseLeft -= 2;
	    i += 2;
	    
            if (current_webpage == WEBPAGE_CONFIGURATION) {
              // Keep the ON/OFF bit as-is
              Pending_pin_control[j] = (uint8_t)(Pending_pin_control[j] & 0x80);
              // Mask out the ON/OFF bit in the temp variable
              k = (uint8_t)(k & 0x7f);
            }
            else {
              // current_webpage is WEBPAGE_IOCONTROL
              // Keep the configuration bits as-is
              Pending_pin_control[j] = (uint8_t)(Pending_pin_control[j] & 0x7f);
              // Mask out the configuration bits in the temp variable
              k = (uint8_t)(k & 0x80);
            }
            // "OR" in the changed bits
            Pending_pin_control[j] = (uint8_t)(Pending_pin_control[j] | k);
            j++;
          }
        }
      }


#if MQTT_SUPPORT == 0
      // Parse 'i' ------------------------------------------------------//
      else if (pSocket->ParseCmd == 'i') {
        // This code updates the IO Timer units and values in Pending
	// variables so that the mainc.c functions will write them to
	// Flash.
        // The value following the 'ixx=' ParseCmd & ParseNum consists of
	// 2 bytes represented as hex encoded strings (4 nibbles).
	// Upper 2 bits are units
	// Lower 14 bits are value
	// The bytes are converted from the hex encoded string to a 16
	// bit integer for storage in Flash.
        {
          uint16_t temp;

          // Sort the alpha characters into the Pending IO Timer bytes
	  
          // Collect upper byte
          // Convert two bytes of the string buffer into numeric bytes
          // two characters at a time.
          temp = (uint8_t)(two_hex2int(local_buf[lbi], local_buf[lbi+1]));
	  temp = (temp << 8);
	  lbi += 2;
          pSocket->nParseLeft -= 2;
          // Collect lower byte
          temp |= (uint8_t)(two_hex2int(local_buf[lbi], local_buf[lbi+1]));
	  lbi += 2;
          pSocket->nParseLeft -= 2;
	  // Store in Pending_IO_TIMER array
	  Pending_IO_TIMER[pSocket->ParseNum] = temp;
        }
      }
#endif // MQTT_SUPPORT


      // Parse 'z' ------------------------------------------------------//
      else if (pSocket->ParseCmd == 'z') {
        // This code signals that the "hidden" post was received. This
        // is an indicaor that the entire POST was received.
        //
        // There is no '&' delimiter after this POST value.
        //
        pSocket->nParseLeft = 0;
        break; // Break out of the while loop. We're done with POST.
      }
	  
      // If we got to this point one of the "if/else if" above should have
      // executed leaving the pointers pointing at the "&" delimiter in
      // the POST data as the next character to be processed. So we set
      // the ParseState to PARSE_DELM and let the while() do its next pass.
      //
      pSocket->ParseState = PARSE_DELIM;
    }
	
    else if (pSocket->ParseState == PARSE_DELIM) {
      if ((pSocket->nParseLeft > 0) && (lbi < lbi_max)) {
        // Parse the next character, which must be a '&' delimiter. From
        // here we go parse the next command byte.
        pSocket->ParseState = PARSE_CMD;
        pSocket->nParseLeft--;
        lbi++;
      }
      else if ((pSocket->nParseLeft > 0) && (lbi >= lbi_max)) {
        // We hit the end of the data in the local_buf but there is still
	// more POST data. Break out of the while(1) loop so we'll return
	// to collect more data from the uip_buf.
	break; // Exit parsing
      }
      else {
        // If we came to PARSE_DELIM and there was nothing left to parse
        // in this or any subsequent packet (the normal exit state for
        // POST data) then we just make sure nParseLeft is zero (not
        // negative) and go on to exit.
        pSocket->nParseLeft = 0; // End the parsing
        break; // Exit parsing
      }
    }
  }  // end of "while(1)" loop
      
  // If nParseLeft == 0 we should enter STATE_SENDHEADER204, but we
  // clean up the fragment tracking pointers first.
  //
  // If nParseLeft is > 0 we haven't received the whole POST yet. In that
  // case we should not enter STATE_SENDHEADER204 until we finish
  // receiving and parsing the whole POST.
  //
  // We also do not want the main.c loop to do any processing of the
  // Pending values collected so far until we've completed collecting ALL
  // POST data. We can tell we still have processing to do because:
  //   saved_nparseleft != 0.
  // I will use a global "parse_complete" variable to pass the state to
  // the main.c functions.
  //

  if (pSocket->nParseLeft == 0) {
    // Finished parsing
    // Clear the saved states
    saved_nstate = STATE_NULL;
    saved_nparseleft = 0;
    saved_newlines = 0;
	
    // Signal the main.c processes that parsing is complete
    parse_complete = 1;
    pSocket->nState = STATE_SENDHEADER204;
	
    // Patch: ON CHROME ONLY: When 'Save' is clicked after changing from
    // the IOControl page to the Configuration page for some reason no
    // Configuration page refresh occurs. At one time the wrong page
    // would display, but that does not seem to happen anymore. The next
    // steps are a workaround to get Chrome to behave better. I am not
    // sure why this happens as the 'if (uip_connected()' steps at the
    // start of this function call should have already done this. Note
    // that if the page change is done, then the 'Refresh' button is
    // clicked, then the 'Save' button is clicked this problem does not
    // appear. This problem was not seen with FireFox, Edge, or IE.

    if (current_webpage == WEBPAGE_IOCONTROL) {
      pSocket->pData = g_HtmlPageIOControl;
      pSocket->nDataLeft = (uint16_t)(sizeof(g_HtmlPageIOControl) - 1);
    }
    if (current_webpage == WEBPAGE_CONFIGURATION) {
      pSocket->pData = g_HtmlPageConfiguration;
      pSocket->nDataLeft = (uint16_t)(sizeof(g_HtmlPageConfiguration) - 1);
    }
  }

  else {
    // Else nParseLeft > 0 so we are still waiting on the remote host to
    // send more POST data. This should arrive in subsequent packets. The
    // remote host is not expecting a CLOSE connection until we are done
    // receiving all POST data. The CLOSE will happen as part of the
    // STATE_SENDHEADER204 process.
    //
    // Note on TCP Fragment reassembly: When the MSS is smaller than the
    // size of the packets that the remote host wants to send it will
    // simply send multiple packets of size MSS or smaller. We are
    // entirely dependent on nParseLeft to determine when to go to
    // STATE_SEND_HEADER, and we must assume that any additional fragments
    // that are sent after we get all the POST data are disposed of by the
    // UIP code. FYI, there shouldn't be any TCP Fragments after
    // nParseLeft = 0.
    //
    uip_len = 0;
  }
}


void update_ON_OFF(uint8_t i, uint8_t j)
{
  // Verify that pin is an output and it is enabled. If so
  // update the ON/OFF state. Otherwise the command is ignored.
  if ((pin_control[i] & 0x01) && (pin_control[i] & 0x02)) {
    Pending_pin_control[i] = pin_control[i];
    if (j==0) Pending_pin_control[i] &= (uint8_t)(~0x80);
    else Pending_pin_control[i] |= (uint8_t)0x80;
    parse_complete = 1;
  }
}


void encode_16bit_registers()
{
  // Function to sort the pin control bytes into the 16 bit registers.
  int i;
  uint16_t j;
  i = 0;
  j = 0x0001;
  while( i<16 ) {
    if (pin_control[i] & 0x04) Invert_word = Invert_word |  j;
    else                       Invert_word = Invert_word & ~j;
    if (pin_control[i] & 0x80) ON_OFF_word = ON_OFF_word |  j;
    else                       ON_OFF_word = ON_OFF_word & ~j;
    i++;
    j = j << 1;
  }
}
