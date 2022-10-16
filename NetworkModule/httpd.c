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



#include <stdlib.h>

#include "httpd.h"
#include "uip.h"
#include "uip_arch.h"
#include "gpio.h"
#include "main.h"
#include "timer.h"
#include "mqtt_pal.h"
#include "uipopt.h"
#include "uart.h"
#include "ds18b20.h"
#include "i2c.h"
#include "iostm8s005.h"
#include "stm8s-005.h"

#include "string.h"
#include <ctype.h>


#define STATE_CONNECTED		0	// Client has just connected
#define STATE_GOTGET		1	// Client just sent a GET request
#define STATE_GOTPOST		2	// Client just sent a POST request
#define STATE_PARSEPOST		10	// We are currently parsing the
                                        // client's POST-data
#define STATE_PARSEFILE		11	// We are currently parsing the
                                        // client's POSTed file data
#define STATE_SENDHEADER200	12	// Next we send the HTTP 200 header
#define STATE_SENDHEADER204	13	// Or we send the HTTP 204 header
#define STATE_SENDDATA		14	// ... followed by data
#define STATE_PARSEGET		15	// We are currently parsing the
                                        // client's GET-request
#define STATE_NULL		127     // Inactive state

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


#define PARSE_FILE_SEEK_START	30	// Parse a new SREC record
#define PARSE_FILE_SEEK_SX	31	// Parse a new SREC record
#define PARSE_FILE_SEQUENTIAL	32	// Read data in the SREC record
#define PARSE_FILE_NONSEQ	33	// Read non-sequential SREC record
#define PARSE_FILE_COMPLETE	34	// Termination of good file read
#define PARSE_FILE_FAIL		35	// Termination of failed file read
#define PARSE_FILE_FAIL_EXIT	36	// Display of fail code

#define PARSE_NULL		127	// Default init state for the parser


#if DEBUG_SUPPORT != 0
// Variables used to store debug information
extern uint8_t debug[10];
extern uint8_t stored_debug[10];
#endif // DEBUG_SUPPORT

extern uint16_t Port_Httpd;               // Port number in use

extern uint8_t pin_control[16];           // Per pin configuration byte
extern uint16_t ON_OFF_word;              // ON/OFF states of pins in single
                                          // 16 bit word
extern uint16_t Invert_word;              // Invert state of pins in single 16
                                          // bit word

extern uint8_t Pending_hostaddr[4];       // Temp storage for new IP address
extern uint8_t Pending_draddr[4];         // Temp storage for new Gateway
                                          // address
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

extern uint8_t parse_complete;            // Used to signal that all user
                                          // inputs have POSTed and are ready
					  // to be used

extern uint8_t user_reboot_request;       // Communicates the need to reboot
                                          // back to the main.c functions
extern uint8_t restart_reboot_step;       // Indicates whether restart or
                                          // reboot are underway.

extern const char code_revision[];        // Code Revision
       
uint8_t OctetArray[11];		          // Used in emb_itoa conversions but
                                          // also repurposed as a temporary
					  // buffer for transferring data
				          // between functions.


#if BUILD_SUPPORT == CODE_UPLOADER_BUILD
uint8_t find_content_info;    // Used to manage steps in determining whether
                              // a file is "Content-Type: m" and in finding
			      // a files "Content-Length".
char byte_tail[3];            // Character pairs captured from the data
                              // file. May also contain a single character
			      // if a packet boundary is encountered while
			      // reading the data file.
uint16_t file_nBytes;         // Used in the data file functions to track the
                              // number of bytes remaining in a packet.
uint8_t byte_index;           // Used as an index to point to the bytes in an
                              // incoming file data line.
uint8_t parse_index;          // Used as an index for writing file data into
                              // the parse_tail array
uint16_t eeprom_address_index; // Address index into the Off-Board EEPROM for
                              // use in writing uploaded files
uint16_t new_address;         // New data address found while parsing SREC
                              // file
uint16_t temp_address;        // Temporary storage of a new data address found
                              // while parsing SREC file
uint16_t temp_address_low;    // Temporary storage of low byte of a new data
                              // address found while parsing SREC file
uint16_t address;             // Current address of data being parsed from an
                              // SREC file
uint8_t data_count;           // Data count found while parsing SREC file
uint8_t data_value;           // Data byte read while parsing SREC file
uint16_t line_count;          // Counts the number of data lines processed.
uint8_t checksum;             // Used in validating file data
uint8_t upgrade_failcode;     // Failure codes for Flash upgrade process.
uint8_t file_type;            // Used to store the file type as Program data
                              // or String data
uint8_t non_sequential_detect; // Flag to inidcate an out of sequence SREC
                              // address was detected.
uint8_t SREC_start;           // Used to determine if a file upload is an SREC
                              // file.
uint8_t search_limit;         // Used to limit the time spent searching for
                              // the start of the SREC data
#endif // BUILD_SUPPORT == CODE_UPLOADER_BUILD

#if OB_EEPROM_SUPPORT == 1
// These defines locate the webpage content and webpage sizes stored in the
// Srings region of the Off-Board EEPROM. In order to allow a String File to
// be read using the same code used for reading Program Files the code expects
// addresses starting at 0x8000, however in the EEPROM itself the base address
// for Strings is 0x0000.
#define MQTT_WEBPAGE_IOCONTROL_ADDRESS_LOCATION			0x0040
#define MQTT_WEBPAGE_CONFIGURATION_ADDRESS_LOCATION		0x0042
#define BROWSER_ONLY_WEBPAGE_IOCONTROL_ADDRESS_LOCATION		0x0044
#define BROWSER_ONLY_WEBPAGE_CONFIGURATION_ADDRESS_LOCATION	0x0046
#define MQTT_WEBPAGE_IOCONTROL_SIZE_LOCATION			0x0080
#define MQTT_WEBPAGE_CONFIGURATION_SIZE_LOCATION		0x0082
#define BROWSER_ONLY_WEBPAGE_IOCONTROL_SIZE_LOCATION		0x0084
#define BROWSER_ONLY_WEBPAGE_CONFIGURATION_SIZE_LOCATION	0x0086


uint8_t eeprom_copy_to_flash_request;
                               // Flag to cause the main.c loop to call the
                               // copy to flash function.
uint16_t off_board_eeprom_index; // Used as an index into the Off-Board EEPROM
                               // when reading webpage templates
extern uint8_t eeprom_detect;  // Used in code update routines

#endif // OB_EEPROM_SUPPORT == 1


#if I2C_SUPPORT == 1
extern uint8_t I2C_failcode;         // Used in monitoring I2C transactions
#endif // I2C_SUPPORT == 1


#if BUILD_SUPPORT == BROWSER_ONLY_BUILD || BUILD_SUPPORT == MQTT_BUILD
uint8_t parse_tail[40];       // Used to collect each component of a POST
			      // sequence. If TCP fragmentation occurs
                              // parse_tail will contain a part of the POST
			      // component that was at the end of the packet.
			      // The size of this array is determined by the
			      // longest POST component. In normal POST
			      // processing the longest component is the &h00
			      // POST reply of 37 bytes.
#endif // BUILD_SUPPORT == BROWSER_ONLY_BUILD || BUILD_SUPPORT == MQTT_BUILD


#if  BUILD_SUPPORT == CODE_UPLOADER_BUILD
uint8_t parse_tail[66];       // In the Code Uploader build the parse_tail is
                              // used as described above, but it is also 
			      // enlarged and repurposed for buffering data
			      // received in a program update file. That data
			      // is received one line of data at a time. The
			      // maximum size required for this storage is 65
			      // bytes.
uint32_t file_length;         // Length of the body (the file data) in a
                              // firmware update POST.
#endif // BUILD_SUPPORT == CODE_UPLOADER_BUILD


uint8_t z_diag;               // The last value in a POST (hidden), used for
                              // diagnostics
uint16_t HtmlPageIOControl_size;     // Size of the IOControl template
uint16_t HtmlPageConfiguration_size; // Size of the Configuration template


// These MQTT variables must always be compiled in the MQTT_BUILD and
// BROWSER_ONLY_BUILD to maintain a common user interface between the MQTT
// and Browser Only versions.
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



#if BUILD_SUPPORT == BROWSER_ONLY_BUILD
// Variables stored in Flash
// Define Flash addresses for IO Names and IO Timers
extern uint16_t IO_TIMER[16] @FLASH_START_IO_TIMERS;
extern char IO_NAME[16][16] @FLASH_START_IO_NAMES;
extern uint16_t Pending_IO_TIMER[16];
#endif // BUILD_SUPPORT == BROWSER_ONLY_BUILD






//---------------------------------------------------------------------------//
// Notes on web pages:
// - Web pages are formed by placing the HTML for the pages in static
//   constants in flash memory.
//   OR
//   Web pages are formed by placing the HTML for the pages in Off-Baord
//   EEPROM (as controlled by #define OB_EEPROM_SUPPORT)
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




//-------------------------------------------------------------------------//
// WEBPAGE_NULL define is needed to allow a default when webpage size
// adjustments are needed in the adjust_template_size() function but the
// IO_Control and Configuration pages are not included. This happens in
// the case of a Code Uploader build.
//-------------------------------------------------------------------------//
#define WEBPAGE_NULL			0




//-------------------------------------------------------------------------//
// The next defines are included only in the case of a Code Uploader build
// because the normal IO_Control and Configuration webpages are omitted in
// that build.
//-------------------------------------------------------------------------//
#if BUILD_SUPPORT == CODE_UPLOADER_BUILD
#define WEBPAGE_IOCONTROL		1
#define WEBPAGE_CONFIGURATION		2
#endif // BUILD_SUPPORT == CODE_UPLOADER_BUILD


//---------------------------------------------------------------------------//
#if BUILD_SUPPORT == MQTT_BUILD
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
//
#define WEBPAGE_IOCONTROL		1
#define PARSEBYTES_IOCONTROL		42
// Next line is a dummy define used only by the strings pre-processor.
#define MQTT_WEBPAGE_IOCONTROL_BEGIN    90
#if OB_EEPROM_SUPPORT == 0
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
"const m=(t=>{let e=document,r=e.querySelector.bind(e),$=r('form'),n=(Object.entries,par"
"seInt),h=t=>e.write(t),a=(t,e)=>n(t).toString(16).padStart(e,'0'),s=t=>t.map(t=>a(t,2))"
".join(''),l=t=>t.match(/.{2}/g).map(t=>n(t,16)),d=t=>encodeURIComponent(t),o=[],p=[],c="
"(t,e,r)=>{var $;return`<label><input type=radio name=o${e} value=${t} ${r==t?'checked':"
"''}/>${(t?'on':'off').toUpperCase()}</label>`},u=()=>{let e=new FormData($);return e.se"
"t('h00',s(l(t.h00).map((t,r)=>{let $='o'+r,n=e.get($)<<7;return e.delete($),n}))),e},i="
"l(t.g00)[0];return cfg_page=16&i?()=>location.href='/60':()=>location.href='/61',reload"
"_page=()=>location.href='/60',submit_form=t=>{t.preventDefault();let e=new XMLHttpReque"
"st,r=Array.from(u().entries(),([t,e])=>`${d(t)}=${d(e)}`).join('&');e.open('POST','/',!"
"1),e.send(r+'&z00=0'),reload_page()},l(t.h00).forEach((t,e)=>{(3&t)==3?p.push(`<tr><td>"
"Output #${e+1}</td><td class='s${t>>7} t3'></td><td class=c>${c(1,e,t>>7)}${c(0,e,t>>7)"
"}</td></tr>`):(3&t)==1&&o.push(`<tr><td>Input #${e+1}</td><td class='s${t>>7} t3'></td>"
"<td/></tr>`)}),h(o.join('')),h(`<tr><th></th><th></th>${p.length>0?'<th class=c>SET</th"
">':''}</tr>`),h(p.join('')),{s:submit_form,l:reload_page,c:cfg_page}})({h00:'%h00',g00:"
"'%g00'});"
      "%y01"
      "<p/>"
      "%y02'm.l()'>Refresh</button> "
      "%y02'm.c()'>Configuration</button>"
      "<pre>%t00%t01%t02%t03%t04</pre>"
   "</body>"
"</html>";
#endif // OB_EEPROM_SUPPORT == 0

#if OB_EEPROM_SUPPORT == 1
// Declared short static const here so that common code can be used for Flash
// and Off-Board webpage sources.
static const char g_HtmlPageIOControl[] = " ";
#endif // OB_EEPROM_SUPPORT == 1

// Important: Don't mess with the order of the variable definitions that look
// somethings like this:
// ({
//   h00: '00010305070b0f131781018303000000',
//   g00: "14",
// });
// It is important that the "h00" definition be first in the sequence for
// IOControl pages as that is how the POST interpreter determines that the
// POST is from an IOControl page. The order doesn't matter so much in a
// Configuration page as the HTML code inserts a "a00" definition first in
// the POST, and that is used to determine that the POST came from a
// Configuration page.

/*
// Credit to Jevgeni Kiski for the javascript work and html improvements.
// Below is the raw script used above before minify.
// 1) Copy raw script to minify website, for example https://javascript-minifier.com/
// 2) Replace the variable definition test placeholders with "replaceable fields", for
//    example:
//    The line
//      h00: '00010305070b0f131781018303000000',
//    Should be replaced with
//      h00: '%h00',
// 3) Copy the resulting minified script to an editor and replace all double quotes with
//    single quotes. THIS STEP IS VERY IMPORTANT.
// 4) Copy the result to the above between the <script> and </script> lines.
// 5) Add double quotes at the start and end of the minfied script to make it part of the
//    constant string.
// 6) It is OK to break up the minified script into lines enclosed by double quotes (just
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
            return `<label><input type=radio name=o${id} value=${type} ${checked_type == type ? 'checked' : ''}/>${type_str.toUpperCase()}</label>`;
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
        features_data = convert_from_hex(data.g00)[0],
        common_attributes = {required: true};
        
        if (features_data & 0x10) {
          cfg_page = () => location.href = '/60';
        } else {
          cfg_page = () => location.href = '/61';        
        }

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
    
    return {s: submit_form, l:reload_page, c:cfg_page}
})
({
  h00: '00010305070b0f131781018303000000',
  g00: '14',
});


*/
#endif // BUILD_SUPPORT == MQTT_BUILD



#if BUILD_SUPPORT == MQTT_BUILD
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
//
#define WEBPAGE_CONFIGURATION		2
#define PARSEBYTES_CONFIGURATION	194
// Next line is dummy define used only by the strings pre-processor.
#define MQTT_WEBPAGE_CONFIGURATION_BEGIN	91
#if OB_EEPROM_SUPPORT == 0
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
"const m=(e=>{let t=['b00','b04','b08','b12'],$=['c00','c01'],r={'Full Duplex':1,'HA Aut"
"o':6,MQTT:4,DS18B20:8,'Disable Cfg Button':16},n={disabled:0,input:1,output:3},o={retai"
"n:8,on:16,off:0},a=document,l=location,p=a.querySelector.bind(a),c=p('form'),d=Object.e"
"ntries,i=parseInt,_=e=>a.write(e),s=(e,t)=>i(e).toString(16).padStart(t,'0'),u=e=>e.map"
"(e=>s(e,2)).join(''),b=e=>e.match(/.{2}/g).map(e=>i(e,16)),f=e=>encodeURIComponent(e),h"
"=e=>p(`input[name=${e}]`),g=(e,t)=>h(e).value=t,x=(e,t)=>{for(let $ of a.querySelectorA"
"ll(e))t($)},y=(e,t)=>{for(let[$,r]of d(t))e.setAttribute($,r)},A=(e,t)=>d(e).map(e=>`<o"
"ption value=${e[1]} ${e[1]==t?'selected':''}>${e[0]}</option>`).join(''),E=(e,t,$,r='')"
"=>`<input type='checkbox' name='${e}' value=${t} ${($&t)==t?'checked':''}>${r}`,S=()=>{"
"let r=new FormData(c),n=e=>r.getAll(e).map(e=>i(e)).reduce((e,t)=>e|t,0);return t.forEa"
"ch(e=>r.set(e,u(r.get(e).split('.')))),$.forEach(e=>r.set(e,s(r.get(e),4))),r.set('d00'"
",r.get('d00').toLowerCase().replace(/[:-]/g,'')),r.set('h00',u(b(e.h00).map((e,t)=>{let"
" $='p'+t,o=n($);return r.delete($),o}))),r.set('g00',u([n('g00')])),r},T=(e,t,$)=>{let "
"r=new XMLHttpRequest;r.open(e,t,!1),r.send($)},j=()=>location.href='/60',v=()=>l.href='"
"/61',w=()=>{a.body.innerText='Wait 5s...',setTimeout(v,5e3)},D=()=>{T('GET','/91'),w()}"
",k=e=>{e.preventDefault();let t=Array.from(S().entries(),([e,t])=>`${f(e)}=${f(t)}`).jo"
"in('&');T('POST','/',t+'&z00=0'),w()},q=b(e.g00)[0],z={required:!0};return x('.ip',e=>{"
"y(e,{...z,title:'x.x.x.x format',pattern:'((25[0-5]|(2[0-4]|1[0-9]|[1-9]|)[0-9])([.](?!"
"$)|$)){4}'})}),x('.port',e=>{y(e,{...z,type:'number',min:10,max:65535})}),x('.up input'"
",e=>{y(e,{title:'0 to 10 letters, numbers, and -_*. no spaces. Blank for no entry.',max"
"length:10,pattern:'[0-9a-zA-Z-_*.]{0,10}$'})}),t.forEach(t=>g(t,b(e[t]).join('.'))),$.f"
"orEach(t=>g(t,i(e[t],16))),g('d00',e.d00.replace(/[0-9a-z]{2}(?!$)/g,'$&:')),b(e.h00).f"
"orEach((e,t)=>{let $=1&e?E('p'+t,4,e):'',r=(3&e)==3?`<select name='p${t}'>${A(o,24&e)}<"
"/select>`:'',a='#d'==l.hash?`<td>${e}</td>`:'';_(`<tr><td>#${t+1}</td><td><select name="
"'p${t}'>${A(n,3&e)}</select></td><td>${$}</td><td>${r}</td>${a}</tr>`)}),p('.f').innerH"
"TML=Array.from(d(r),([e,t])=>E('g00',t,q,e)).join('</br>'),{r:D,s:k,l:v,c:j}})({b00:'%b"
"00',b04:'%b04',b08:'%b08',c00:'%c00',d00:'%d00',b12:'%b12',c01:'%c01',h00:'%h00',g00:'%"
"g00'});"
      "%y01"
      "<p>Code Revision %w00<br/>"
      "<a href='https://github.com/nielsonm236/NetMod-ServerApp/wiki'>Help Wiki</a>"
      "</p>"
      "%y02'm.r()'>Reboot</button>"
      "<br><br>"
      "%y02'm.l()'>Refresh</button> "
      "%y02'm.c()'>IO Control</button>"
   "</body>"
"</html>";
#endif // OB_EEPROM_SUPPORT == 0

#if OB_EEPROM_SUPPORT == 1
// Declared short static const here so that common code can be used for Flash
// and Off-Board webpage sources.
static const char g_HtmlPageConfiguration[] = " ";
#endif // OB_EEPROM_SUPPORT == 1


// Important: Don't mess with the order of the variable definitions that look
// somethings like this:
// ({
//   h00: '00010305070b0f131781018303000000',
//   g00: "14",
// });
// It is important that the "h00" definition be first in the sequence for
// IOControl pages as that is how the POST interpreter determines that the
// POST is from an IOControl page. The order doesn't matter so much in a
// Configuration page as the HTML code inserts a "a00" definition first in
// the POST, and that is used to determine that the POST came from a
// Configuration page.

/*
// Credit to Jevgeni Kiski for the javascript work and html improvements.
// Below is the raw script used above before minify.
// 1) Copy raw script to minify website, for example https://javascript-minifier.com/
// 2) Replace the variable definition test placeholders with "replaceable fields", for
//    example:
//    The line
//      h00: '00010305070b0f131781018303000000',
//    Should be replaced with
//      h00: '%h00',
// 3) Copy the resulting minified script to an editor and replace all double quotes with
//    single quotes. THIS STEP IS VERY IMPORTANT.
// 4) Copy the result to the above between the <script> and </script> lines.
// 5) Add double quotes at the start and end of the minfied script to make it part of the
//    constant string.
// 6) It is OK to break up the minified script into lines enclosed by double quotes (just
//    to make it all visible in the code editors). But make sure no spaces are inadvertantly
//    removed from the minified script.

const m = (data => {
    const ip_input_names = ['b00', 'b04', 'b08', 'b12'],
        port_input_names = ['c00', 'c01'],
        features = { "Full Duplex": 1, "HA Auto": 6, "MQTT": 4, "DS18B20": 8, "Disable Cfg Button": 16 },
        pin_types = { "disabled": 0, "input": 1, "output": 3 },
        boot_state = { "retain": 8, "on": 16, "off": 0 },
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
        make_checkbox = (name, bit, value, title='') => `<input type="checkbox" name='${name}' value=${bit} ${(value & bit) == bit ? 'checked' : ''}>${title}`,
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
        iocontrol_page = () => location.href = '/60',
        reload_page = () => loc.href = '/61',
        wait_reboot = () => {
          doc.body.innerText = "Wait 5s...";
          setTimeout(reload_page, 5000);
        },
        reboot = () => {
          send_request("GET", "/91");
          wait_reboot();
        },
        submitForm = (event) => {
        	event.preventDefault();
          const string_data = Array.from(get_form_data().entries(), ([k, v]) => `${encode(k)}=${encode(v)}`).join("&");
          send_request("POST", "/", string_data + '&z00=0');
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
    
    selector(".f").innerHTML = Array.from(
    	get_entries(features),
      ([name, bit]) => make_checkbox('g00', bit, features_data, name)).join("</br>"
    );
    
    
    return {r:reboot, s: submitForm, l:reload_page, c:iocontrol_page};
})
({
    b00: "c0a80004",
    b04: "c0a80101",
    b08: "ffffff00",
    c00: "0050",
    d00: "aabbccddeeff",
    b12: "c0a80005",
    c01: "075b",
    h00: "00010305070b0f131700000000000000",
    g00: "04",
});

*/
#endif // BUILD_SUPPORT == MQTT_BUILD




//---------------------------------------------------------------------------//

#if BUILD_SUPPORT == BROWSER_ONLY_BUILD
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
//
#define WEBPAGE_IOCONTROL		1
#define PARSEBYTES_IOCONTROL		42
// Next line is dummy define used only by the strings pre-processor.
#define BROWSER_ONLY_WEBPAGE_IOCONTROL_BEGIN	92
#if OB_EEPROM_SUPPORT == 0
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
"const m=(t=>{let $=document,e=$.querySelector.bind($),j=e('form'),r=(Object.entries,par"
"seInt),_=t=>$.write(t),a=(t,$)=>r(t).toString(16).padStart($,'0'),n=t=>t.map(t=>a(t,2))"
".join(''),h=t=>t.match(/.{2}/g).map(t=>r(t,16)),s=t=>encodeURIComponent(t),d=[],l=[],o="
"(t,$,e)=>{var j;return`<label><input type=radio name=o${$} value=${t} ${e==t?'checked':"
"''}/>${(t?'on':'off').toUpperCase()}</label>`},c=()=>{let $=new FormData(j);return $.se"
"t('h00',n(h(t.h00).map((t,e)=>{let j='o'+e,r=$.get(j)<<7;return $.delete(j),r}))),$},p="
"h(t.g00)[0];return cfg_page=16&p?()=>location.href='/60':()=>location.href='/61',reload"
"_page=()=>location.href='/60',submit_form=t=>{t.preventDefault();let $=new XMLHttpReque"
"st,e=Array.from(c().entries(),([t,$])=>`${s(t)}=${s($)}`).join('&');$.open('POST','/',!"
"1),$.send(e+'&z00=0'),reload_page()},h(t.h00).forEach(($,e)=>{var j=t['j'+(e+'').padSta"
"rt(2,'0')];(3&$)==3?l.push(`<tr><td>${j}</td><td class='s${$>>7} t3'></td><td class=c>$"
"{o(1,e,$>>7)}${o(0,e,$>>7)}</td></tr>`):(3&$)==1&&d.push(`<tr><td>${j}</td><td class='s"
"${$>>7} t3'></td><td/></tr>`)}),_(d.join('')),_(`<tr><th></th><th></th>${l.length>0?'<t"
"h class=c>SET</th>':''}</tr>`),_(l.join('')),{s:submit_form,l:reload_page,c:cfg_page}})"
"({h00:'%h00',g00:'%g00',j00:'%j00',j01:'%j01',j02:'%j02',j03:'%j03',j04:'%j04',j05:'%j0"
"5',j06:'%j06',j07:'%j07',j08:'%j08',j09:'%j09',j10:'%j10',j11:'%j11',j12:'%j12',j13:'%j"
"13',j14:'%j14',j15:'%j15'});"
      "%y01"
      "<p/>"
      "%y02'm.l()'>Refresh</button> "
      "%y02'm.c()'>Configuration</button>"
      "<pre>%t00%t01%t02%t03%t04</pre>"
   "</body>"
"</html>";
#endif // OB_EEPROM_SUPPORT == 0

#if OB_EEPROM_SUPPORT == 1
// Declared short static const here so that common code can be used for Flash
// and Off-Board webpage sources.
static const char g_HtmlPageIOControl[] = " ";
#endif // OB_EEPROM_SUPPORT == 1

// Important: Don't mess with the order of the variable definitions that look
// somethings like this:
// ({
//   h00: '00010305070b0f131781018303000000',
//   g00: "14",
// });
// It is important that the "h00" definition be first in the sequence for
// IOControl pages as that is how the POST interpreter determines that the
// POST is from an IOControl page. The order doesn't matter so much in a
// Configuration page as the HTML code inserts a "a00" definition first in
// the POST, and that is used to determine that the POST came from a
// Configuration page.

/*
// Credit to Jevgeni Kiski for the javascript work and html improvements.
// Below is the raw script used above before minify.
// 1) Copy raw script to minify website, for example https://javascript-minifier.com/
// 2) Replace the variable definition test placeholders with "replaceable fields", for
//    example:
//    The line
//      h00: '00010305070b0f131781018303000000',
//    Should be replaced with
//      h00: '%h00',
// 3) Copy the resulting minified script to an editor and replace all double quotes with
//    single quotes. THIS STEP IS VERY IMPORTANT.
// 4) Copy the result to the above between the <script> and </script> lines.
// 5) Add double quotes at the start and end of the minfied script to make it part of the
//    constant string.
// 6) It is OK to break up the minified script into lines enclosed by double quotes (just
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
            return `<label><input type=radio name=o${id} value=${type} ${checked_type == type ? 'checked' : ''}/>${type_str.toUpperCase()}</label>`;
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
        features_data = convert_from_hex(data.g00)[0],
        common_attributes = {required: true};
        
        if (features_data & 0x10) {
          cfg_page = () => location.href = '/60';
        } else {
          cfg_page = () => location.href = '/61';        
        }

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
    
    return {s: submit_form, l:reload_page, c:cfg_page}
})
({
  h00: '01010305070b0f131781018303000000',
  g00: '14',
  j00: 'LivingRoom12345',
  j01: 'LivingRoom67890',
  j02: 'IO_3',
  j03: 'IO_4',
  j04: 'IO_5',
  j05: 'IO_6',
  j06: 'IO_7',
  j07: 'IO_8',
  j08: 'IO_9',
  j09: 'IO_10',
  j10: 'IO_11',
  j11: 'IO_12',
  j12: 'IO_13',
  j13: 'IO_14',
  j14: 'Driveway_01',
  j15: 'Garden-01',
});

*/
#endif // BUILD_SUPPORT == BROWSER_ONLY_BUILD



#if BUILD_SUPPORT == BROWSER_ONLY_BUILD
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
//
#define WEBPAGE_CONFIGURATION		2
#define PARSEBYTES_CONFIGURATION	602
// Next line is dummy define used only by the strings pre-processor.
#define BROWSER_ONLY_WEBPAGE_CONFIGURATION_BEGIN	93
#if OB_EEPROM_SUPPORT == 0
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
"const m=($=>{let e=['b00','b04','b08'],t=['c00'],i={'Full Duplex':1,DS18B20:8,'Disable "
"Cfg Button':16},_={disabled:0,input:1,output:3},r={retain:8,on:16,off:0},a={'0.1s':0,'1"
"s':16384,'1m':32768,'1h':49152},n=document,l=location,j=n.querySelector.bind(n),o=j('fo"
"rm'),d=Object.entries,p=parseInt,s=$=>n.write($),c=($,e)=>p($).toString(16).padStart(e,"
"'0'),u=$=>$.map($=>c($,2)).join(''),f=$=>$.match(/.{2}/g).map($=>p($,16)),b=$=>encodeUR"
"IComponent($),h=$=>j(`input[name=${$}]`),g=($,e)=>h($).value=e,x=($,e)=>{for(let t of n"
".querySelectorAll($))e(t)},S=($,e)=>{for(let[t,i]of d(e))$.setAttribute(t,i)},v=($,e)=>"
"d($).map($=>`<option value=${$[1]} ${$[1]==e?'selected':''}>${$[0]}</option>`).join('')"
",y=($,e,t,i='')=>`<input type='checkbox' name='${$}' value=${e} ${(t&e)==e?'checked':''"
"}>${i}`,E=()=>{let i=new FormData(o),_=$=>i.getAll($).map($=>p($)).reduce(($,e)=>$|e,0)"
";e.forEach($=>i.set($,u(i.get($).split('.')))),t.forEach($=>i.set($,c(i.get($),4))),i.s"
"et('d00',i.get('d00').toLowerCase().replace(/[:-]/g,'')),i.set('h00',u(f($.h00).map(($,"
"e)=>{let t='p'+e,r=_(t);return i.delete(t),r})));for(let r=0;r<16;r++){let a=(''+r).pad"
"Start(2,'0');i.set('i'+a,c(65535&_('i'+a),4))}return i.set('g00',u([_('g00')])),i},q=($"
",e,t)=>{let i=new XMLHttpRequest;i.open($,e,!1),i.send(t)},w=()=>location.href='/60',A="
"()=>l.href='/61',D=()=>{n.body.innerText='Wait 5s...',setTimeout(A,5e3)},T=()=>{q('GET'"
",'/91'),D()},z=$=>{$.preventDefault();let e=Array.from(E().entries(),([$,e])=>`${b($)}="
"${b(e)}`).join('&');q('POST','/',e+'&z00=0'),D()},k=f($.g00)[0],B={required:!0};return "
"x('.ip',$=>{S($,{...B,title:'x.x.x.x format',pattern:'((25[0-5]|(2[0-4]|1[0-9]|[1-9]|)["
"0-9])([.](?!$)|$)){4}'})}),x('.port',$=>{S($,{...B,type:'number',min:10,max:65535})}),e"
".forEach(e=>g(e,f($[e]).join('.'))),t.forEach(e=>g(e,p($[e],16))),g('d00',$.d00.replace"
"(/[0-9a-z]{2}(?!$)/g,'$&:')),f($.h00).forEach((e,t)=>{let i=1&e?y('p'+t,4,e):'',n=($,t)"
"=>(3&e)==3?$:t,j=(''+t).padStart(2,'0'),o=n(f($['i'+j]).reduce(($,e)=>($<<8)+e),0),d=n("
"`<select name='p${t}'>${v(r,24&e)}</select>`,''),p='#d'==l.hash?`<td>${e}</td>`:'',c=n("
"`<input type=number class=t8 name='i${j}' value='${16383&o}' min=0 max=16383><select na"
"me='i${j}'>${v(a,49152&o)}</select>`,'');s(`<tr><td>#${t+1}</td><td><select name='p${t}"
"'>${v(_,3&e)}</select></td><td><input name='j${j}' value='${$['j'+j]}' pattern='[0-9a-z"
"A-Z_*.-]{1,15}' required title='1 to 15 letters, numbers, and -*_. no spaces' maxlength"
"=15/></td><td>${i}</td><td>${d}</td><td>${c}</td>${p}</tr>`)}),j('.f').innerHTML=Array."
"from(d(i),([$,e])=>y('g00',e,k,$)).join('</br>'),{r:T,s:z,l:A,c:w}})({b00:'%b00',b04:'%"
"b04',b08:'%b08',c00:'%c00',d00:'%d00',h00:'%h00',g00:'%g00',j00:'%j00',j01:'%j01',j02:'"
"%j02',j03:'%j03',j04:'%j04',j05:'%j05',j06:'%j06',j07:'%j07',j08:'%j08',j09:'%j09',j10:"
"'%j10',j11:'%j11',j12:'%j12',j13:'%j13',j14:'%j14',j15:'%j15',i00:'%i00',i01:'%i01',i02"
":'%i02',i03:'%i03',i04:'%i04',i05:'%i05',i06:'%i06',i07:'%i07',i08:'%i08',i09:'%i09',i1"
"0:'%i10',i11:'%i11',i12:'%i12',i13:'%i13',i14:'%i14',i15:'%i15'});"
      "%y01"
      "<p>Code Revision %w00<br/>"
      "<a href='https://github.com/nielsonm236/NetMod-ServerApp/wiki'>Help Wiki</a>"
      "</p>"
      "%y02'm.r()'>Reboot</button>"
      "<br><br>"
      "%y02'm.l()'>Refresh</button> "
      "%y02'm.c()'>IO Control</button>"
   "</body>"
"</html>";
#endif // OB_EEPROM_SUPPORT == 0

#if OB_EEPROM_SUPPORT == 1
// Declared short static const here so that common code can be used for Flash
// and Off-Board webpage sources.
static const char g_HtmlPageConfiguration[] = " ";
#endif // OB_EEPROM_SUPPORT == 1


// Important: Don't mess with the order of the variable definitions that look
// somethings like this:
// ({
//   h00: '00010305070b0f131781018303000000',
//   g00: "14",
// });
// It is important that the "h00" definition be first in the sequence for
// IOControl pages as that is how the POST interpreter determines that the
// POST is from an IOControl page. The order doesn't matter so much in a
// Configuration page as the HTML code inserts a "a00" definition first in
// the POST, and that is used to determine that the POST came from a
// Configuration page.

/*
// Credit to Jevgeni Kiski for the javascript work and html improvements.
// Below is the raw script used above before minify.
// 1) Copy raw script to minify website, for example https://javascript-minifier.com/
// 2) Replace the variable definition test placeholders with "replaceable fields", for
//    example:
//    The line
//      h00: '00010305070b0f131781018303000000',
//    Should be replaced with
//      h00: '%h00',
// 3) Copy the resulting minified script to an editor and replace all double quotes with
//    single quotes. THIS STEP IS VERY IMPORTANT.
// 4) Copy the result to the above between the <script> and </script> lines.
// 5) Add double quotes at the start and end of the minfied script to make it part of the
//    constant string.
// 6) It is OK to break up the minified script into lines enclosed by double quotes (just
//    to make it all visible in the code editors). But make sure no spaces are inadvertantly
//    removed from the minified script.

const m = (data => {
    const ip_input_names = ['b00', 'b04', 'b08'],
        port_input_names = ['c00'],
        features = { "Full Duplex": 1, "DS18B20": 8, "Disable Cfg Button": 16 },
        pin_types = { "disabled": 0, "input": 1, "output": 3 },
        boot_state = { "retain": 8, "on": 16, "off": 0 },
        timer_unit = { "0.1s": 0, "1s": 0x4000, "1m": 0x8000, "1h": 0xc000 },
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
        make_checkbox = (name, bit, value, title='') => `<input type="checkbox" name='${name}' value=${bit} ${(value & bit) == bit ? 'checked' : ''}>${title}`,
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
        iocontrol_page = () => location.href = '/60',
        reload_page = () => loc.href='/61',
        wait_reboot = () => {
          doc.body.innerText = "Wait 5s...";
          setTimeout(reload_page, 5000);
        },
        reboot = () => {
          send_request("GET", "/91");
          wait_reboot();
        },
        submitForm = (event) => {
        	event.preventDefault();
          const string_data = Array.from(get_form_data().entries(), ([k, v]) => `${encode(k)}=${encode(v)}`).join("&");
          send_request("POST", "/", string_data + '&z00=0');
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
    
    selector(".f").innerHTML = Array.from(get_entries(features),([name, bit]) => make_checkbox('g00', bit, features_data, name)).join("</br>");
    
    return {r:reboot, s: submitForm, l:reload_page, c:iocontrol_page};
})
({
    b00: "c0a80004",
    b04: "c0a80101",
    b08: "ffffff00",
    c00: "0050",
    d00: "aabbccddeeff",
    h00: "00010305070b0f131700000000000000",
    g00: "04",
    j00: "LivingRoom12345",
    j01: "LivingRoom67890",
    j02: "IO_3",
    j03: "IO_4",
    j04: "IO_5",
    j05: "IO_6",
    j06: "IO_7",
    j07: "IO_8",
    j08: "IO_9",
    j09: "IO_10",
    j10: "IO_11",
    j11: "IO_12",
    j12: "IO_13",
    j13: "IO_14",
    j14: "Driveway_01",
    j15: "Garden-01",
    i00: "0000",
    i01: "0000",
    i02: "0000",
    i03: "0000",
    i04: "30ff",
    i05: "7f0f",
    i06: "bff0",
    i07: "ffff",
    i08: "0001",
    i09: "0000",
    i10: "0000",
    i11: "0000",
    i12: "0000",
    i13: "0000",
    i14: "0000",
    i15: "0000",
});

*/
#endif // BUILD_SUPPORT == BROWSER_ONLY_BUILD





#if UIP_STATISTICS == 1 && BUILD_SUPPORT == BROWSER_ONLY_BUILD
// Statistics page Template
#define WEBPAGE_STATS1		6
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
#endif // UIP_STATISTICS == 1 && BUILD_SUPPORT == BROWSER_ONLY_BUILD



#if DEBUG_SUPPORT == 11 || DEBUG_SUPPORT == 15
// Link Error Statistics page Template
#define WEBPAGE_STATS2		7
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
#define WEBPAGE_SENSOR_SERIAL	8
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
#define WEBPAGE_SSTATE		9
static const char g_HtmlPageSstate[] =
  "%f00";


#if BUILD_SUPPORT == CODE_UPLOADER_BUILD
// Code Uploader Support page Template
// This is the main web page shown by the Code Uploader.
#define WEBPAGE_UPLOADER		10
static const char g_HtmlPageUploader[] =
  "%y04%y05"
  "<title>Code Uploader</title>"
  "</head>"
  "<body>"
  "<h1>Code Uploader</h1>"
  "<form action='' method='post' enctype='multipart/form-data'>"
  
  "<script>"
    "function startTimer(){"
      "var timeleft = 20;"
      "var downloadTimer = setInterval(function(){"
        "if(timeleft <= 0){"
          "clearInterval(downloadTimer);"
        "}"
        "document.getElementById('progressBar').value = 20 - timeleft;"
        "timeleft -= 1;"
      "}, 1000);"
    "}"
    "function start(){"
      "document.getElementById('progressBar');"
      "startTimer();"
    "};"
  "</script>"

  "<p>"
  "Use CHOOSE FILE to select a .sx file then click SUBMIT. The 30 second<br>"
  "Upload and Flash programming process will start.<br>"
  "</p>"
  
  "<p><input input type='file' name='file1' accept='.sx' required /></p>"
  "<p><button type='submit' onclick='start()'>Submit</button></p>"

  "<p>"
  "Once you click Submit do not access via your browser until Flash programming<br>"
  "completes.<br>"
  "</p>"
  
  "<p>"
  "<progress id='progressBar' value='0' max='20'></progress>"
  "<br><br><br>"

  "</form>"
  
  "<p>"
  "RESTORE: If you arrived here unintentionally DO NOT CLICK SUBMIT. Instead<br>"
  "use the Restore button to reinstall your previous firmware version.<br>"
  "</p>"
  "<button onclick='location=`/73`'>Restore</button>"
  "<p>"
  "<br>"
  "</p>"
  "</body>"
  "</html>";
#endif // BUILD_SUPPORT == CODE_UPLOADER_BUILD


#if OB_EEPROM_SUPPORT == 1
#if BUILD_SUPPORT == BROWSER_ONLY_BUILD || BUILD_SUPPORT == MQTT_BUILD
// Load Uploader page Template
// This web page is shown when the user requests the Code Uploader with the
// /72 command.
#define WEBPAGE_LOADUPLOADER		12
static const char g_HtmlPageLoadUploader[] =
  "%y04%y05"
  "<title>Loading Code Uploader</title>"
  "</head>"
  "<body>"
  "<h1>Loading Code Uploader</h1>"
  "<p>"
  "DO NOT ACCESS BROWSER FOR 15 SECONDS.<br><br>"
  "Wait until the progress bar completes, then click Continue.<br><br>"
  
  "<progress value='0' max='15' id='progressBar'></progress>"
  "<script>"
  "var timeleft = 15;"
  "var downloadTimer = setInterval(function(){"
    "if(timeleft <= 0){"
      "clearInterval(downloadTimer);"
    "}"
    "document.getElementById('progressBar').value = 15 - timeleft;"
    "timeleft -= 1;"
  "}, 1000);"
  "</script>"
  
  "<br>"
  "<br>"
  
  "</p>"
  "<button onclick='location=`/`'>Continue</button>"
  "</body>"
  "</html>";
#endif // BUILD_SUPPORT == BROWSER_ONLY_BUILD || BUILD_SUPPORT == MQTT_BUILD
#endif // OB_EEPROM_SUPPORT == 1


#if BUILD_SUPPORT == CODE_UPLOADER_BUILD
// Existing Image page Template
// This web page is shown when the user requests that the existing firmware
// image be reinstalled
#define WEBPAGE_EXISTING_IMAGE	13
static const char g_HtmlPageExistingImage[] =
  "%y04%y05"
  "<title>Restoring Existing Image</title>"
  "</head>"
  "<body>"
  "<h1>Restoring Existing Image</h1>"
  "<p>"
  "It takes about 15 SECONDS to restore the existing firmware image.<br><br>"
  "DO NOT ATTEMPT BROWSER ACCESS DURING THIS 15 SECOND PERIOD.<br><br>"
  "Wait until the progress bar completes, then click Continue.<br><br>"
  
  "<progress value='0' max='15' id='progressBar'></progress>"
  "<script>"
  "var timeleft = 15;"
  "var downloadTimer = setInterval(function(){"
    "if(timeleft <= 0){"
      "clearInterval(downloadTimer);"
    "}"
    "document.getElementById('progressBar').value = 15 - timeleft;"
    "timeleft -= 1;"
  "}, 1000);"
  "</script>"
  "<br>"
  "<br>"
  
  "</p>"
  "<button onclick='location=`/`'>Continue</button>"
  "</body>"
  "</html>";
#endif // BUILD_SUPPORT == CODE_UPLOADER_BUILD


#if BUILD_SUPPORT == CODE_UPLOADER_BUILD
// Timer page Template
// This web page is shown when uploaded code is being written to the Flash.
// The page displays a wait timer to help prevent the user from taking
// actions while the Flash is finishing.
#define WEBPAGE_TIMER	14
static const char g_HtmlPageTimer[] =
  "%y04%y05"
  "<title>Writing Flash</title>"
  "</head>"
  "<body>"
  "<h1>Writing and Verifying Flash</h1>"
  "<p>"
  "Wait until the progress bar completes, then click Continue.<br><br>"
  
  "<progress value='0' max='15' id='progressBar'></progress>"
  "<script>"
  "var timeleft = 15;"
  "var downloadTimer = setInterval(function(){"
    "if(timeleft <= 0){"
      "clearInterval(downloadTimer);"
    "}"
    "document.getElementById('progressBar').value = 15 - timeleft;"
    "timeleft -= 1;"
  "}, 1000);"
  "</script>"
  "<br>"
  "<br>"
  
  "</p>"
  "<button onclick='location=`/`'>Continue</button>"
  "</body>"
  "</html>";
#endif // BUILD_SUPPORT == CODE_UPLOADER_BUILD


#if BUILD_SUPPORT == CODE_UPLOADER_BUILD
// Upload Complete page Template
// This web page is shown when the uploaded strings file completes success-
// fully.
#define WEBPAGE_UPLOAD_COMPLETE	15
static const char g_HtmlPageUploadComplete[] =
  "%y04%y05"
  "<title>Upload Complete</title>"
  "</head>"
  "<body>"
  "<h1>Upload Complete</h1>"
  "<p>"
  "Click Continue.<br><br>"
  "</p>"
  "<button onclick='location=`/`'>Continue</button>"
  "</body>"
  "</html>";
#endif // BUILD_SUPPORT == CODE_UPLOADER_BUILD


#if BUILD_SUPPORT == CODE_UPLOADER_BUILD
// Parse Fail page Template
// This web page is shown when uploaded code had a parsing failure.
#define WEBPAGE_PARSEFAIL	16
static const char g_HtmlPageParseFail[] =
  "%y04%y05"
  "<title>Upload Parse Fail</title>"
  "</head>"
  "<body>"
  "<h1>Upload Parse Fail</h1>"
  "<p>"
  "Parsing of the uploaded file failed.<br>"
  "Retry the upload. Make sure you selected the correct file.<br>"
  "Fault reason code:<br>"
  "%s02"
  "</p>"
  "<button onclick='location=`/`'>Continue</button>"
  "</body>"
  "</html>";
#endif // BUILD_SUPPORT == CODE_UPLOADER_BUILD


#if OB_EEPROM_SUPPORT == 1
// EEPROM Missing webpage
// This web page is shown when the EEPROM has gone missing unexpectedly.
// This should never happen, but may occur is there is a faulty connection.
#define WEBPAGE_EEPROM_MISSING	17
static const char g_HtmlPageEEPROMMissing[] =
  "%y04%y05"
  "<title>EEPROM Missing</title>"
  "</head>"
  "<body>"
  "<h1>EEPROM Missing</h1>"
  "<p>"
  "EEPROM device may be defective or wiring may be loose.<br>"
  "</p>"
  "<button onclick='location=`/`'>Continue</button>"
  "</body>"
  "</html>";
#endif // OB_EEPROM_SUPPORT == 1




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
  "<button title='Save first!' onclick="

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


void HttpDStringInit() {
  // Initialize HttpD string sizes
  
#if OB_EEPROM_SUPPORT == 0
  HtmlPageIOControl_size = (uint16_t)(sizeof(g_HtmlPageIOControl) - 1);
  HtmlPageConfiguration_size = (uint16_t)(sizeof(g_HtmlPageConfiguration) - 1);
#endif // OB_EEPROM_SUPPORT == 0

#if OB_EEPROM_SUPPORT == 1
#if BUILD_SUPPORT == MQTT_BUILD
  // Prepare to read 2 bytes from Off-Board EEPROM and convert to uint16_t.
  prep_read(I2C_EEPROM2_WRITE, I2C_EEPROM2_READ, MQTT_WEBPAGE_IOCONTROL_SIZE_LOCATION);
#endif // BUILD_SUPPORT == MQTT_BUILD

#if BUILD_SUPPORT == BROWSER_ONLY_BUILD
  // Prepare to read 2 bytes from Off-Board EEPROM and convert to uint16_t.
  prep_read(I2C_EEPROM2_WRITE, I2C_EEPROM2_READ, BROWSER_ONLY_WEBPAGE_IOCONTROL_SIZE_LOCATION);
#endif // BUILD_SUPPORT == BROWSER_ONLY_BUILD

  // Read 2 bytes from Off-Board EEPROM and convert to uint16_t.
  {
    uint16_t temp;
    OctetArray[0] = I2C_read_byte(0);
    OctetArray[1] = I2C_read_byte(1);
    temp = (uint16_t)(OctetArray[0] << 8);
    temp |= OctetArray[1];
    HtmlPageIOControl_size = temp;
  }
  
#if BUILD_SUPPORT == MQTT_BUILD
  // Prepare to read 2 bytes from Off-Board EEPROM and convert to uint16_t.
  prep_read(I2C_EEPROM2_WRITE, I2C_EEPROM2_READ, MQTT_WEBPAGE_CONFIGURATION_SIZE_LOCATION);
#endif // BUILD_SUPPORT == MQTT_BUILD

#if BUILD_SUPPORT == BROWSER_ONLY_BUILD
  // Prepare to read 2 bytes from Off-Board EEPROM and convert to uint16_t.
  prep_read(I2C_EEPROM2_WRITE, I2C_EEPROM2_READ, BROWSER_ONLY_WEBPAGE_CONFIGURATION_SIZE_LOCATION);
#endif // BUILD_SUPPORT == BROWSER_ONLY_BUILD

  // Read 2 bytes from Off-Board EEPROM and convert to uint16_t.
  {
    uint16_t temp;
    OctetArray[0] = I2C_read_byte(0);
    OctetArray[1] = I2C_read_byte(1);
    temp = (uint16_t)(OctetArray[0] << 8);
    temp |= OctetArray[1];
    HtmlPageConfiguration_size = temp;
  }
#endif // OB_EEPROM_SUPPORT == 1
}


void init_off_board_string_pointers(struct tHttpD* pSocket) {
  // Initialize the index into the Off-Board EEPROM Strings region.
  //
  // In order to allow a String File to be read using the same code used for
  // reading Program Files the code expects the Strings file to have SREC
  // addresses starting at 0x8000, however in the EEPROM itself the base
  // address for Strings is 0x0000. This initialization will compensate for
  // that disparity.

#if OB_EEPROM_SUPPORT == 1

  if (pSocket->current_webpage == WEBPAGE_IOCONTROL) {

#if BUILD_SUPPORT == MQTT_BUILD
    // Prepare to read the two byte string address from Off-Board EEPROM and
    // convert to uint16_t.
    prep_read(I2C_EEPROM2_WRITE, I2C_EEPROM2_READ, MQTT_WEBPAGE_IOCONTROL_ADDRESS_LOCATION);
#endif // BUILD_SUPPORT == MQTT_BUILD

#if BUILD_SUPPORT == BROWSER_ONLY_BUILD
    // Prepare to read the two byte string address from Off-Board EEPROM and
    // convert to uint16_t.
    prep_read(I2C_EEPROM2_WRITE, I2C_EEPROM2_READ, BROWSER_ONLY_WEBPAGE_IOCONTROL_ADDRESS_LOCATION);
#endif // BUILD_SUPPORT == BROWSER_ONLY_BUILD

    // Read 2 bytes
    {
      uint16_t temp;
      OctetArray[0] = I2C_read_byte(0);
      OctetArray[1] = I2C_read_byte(1);
      temp = (uint16_t)(OctetArray[0] << 8);
      temp |= OctetArray[1];
      off_board_eeprom_index = temp - 0x8000;
    }
  }
      
  if (pSocket->current_webpage == WEBPAGE_CONFIGURATION) {

#if BUILD_SUPPORT == MQTT_BUILD
    // Prepare to read the two byte string address from Off-Board EEPROM and
    // convert to uint16_t.
    prep_read(I2C_EEPROM2_WRITE, I2C_EEPROM2_READ, MQTT_WEBPAGE_CONFIGURATION_ADDRESS_LOCATION);
#endif // BUILD_SUPPORT == MQTT_BUILD

#if BUILD_SUPPORT == BROWSER_ONLY_BUILD
    // Prepare to read the two byte string address from Off-Board EEPROM and
    // convert to uint16_t.
    prep_read(I2C_EEPROM2_WRITE, I2C_EEPROM2_READ, BROWSER_ONLY_WEBPAGE_CONFIGURATION_ADDRESS_LOCATION);
#endif // BUILD_SUPPORT == BROWSER_ONLY_BUILD

    // Read 2 bytes
    {
      uint16_t temp;
      OctetArray[0] = I2C_read_byte(0);
      OctetArray[1] = I2C_read_byte(1);
      temp = (uint16_t)(OctetArray[0] << 8);
      temp |= OctetArray[1];
      off_board_eeprom_index = temp - 0x8000;
    }

  }
#endif // OB_EEPROM_SUPPORT == 1
}


void httpd_diagnostic(void) {
#if DEBUG_SUPPORT == 7 || DEBUG_SUPPORT == 15
#if OB_EEPROM_SUPPORT == 1
  // Read and display the 8 bytes with address info for the web pages
  prep_read(I2C_EEPROM2_WRITE, I2C_EEPROM2_READ, MQTT_WEBPAGE_IOCONTROL_ADDRESS_LOCATION);
  {
    int i;
    uint8_t temp[8];
    UARTPrintf("Webpage Address Bytes: ");
    temp[0] = I2C_read_byte(0);
    temp[1] = I2C_read_byte(0);
    temp[2] = I2C_read_byte(0);
    temp[3] = I2C_read_byte(0);
    temp[4] = I2C_read_byte(0);
    temp[5] = I2C_read_byte(0);
    temp[6] = I2C_read_byte(0);
    temp[7] = I2C_read_byte(1);
    for (i = 0; i < 8; i++) {
      emb_itoa(temp[i], OctetArray, 16, 2);
      UARTPrintf(OctetArray);
      UARTPrintf(" ");
    }
  UARTPrintf("\r\n");
  }
  
  // Read and display the 8 bytes with size info for the web pages
  prep_read(I2C_EEPROM2_WRITE, I2C_EEPROM2_READ, MQTT_WEBPAGE_IOCONTROL_SIZE_LOCATION);
  {
    int i;
    uint8_t temp[8];
    UARTPrintf("Webpage Size Bytes: ");
    temp[0] = I2C_read_byte(0);
    temp[1] = I2C_read_byte(0);
    temp[2] = I2C_read_byte(0);
    temp[3] = I2C_read_byte(0);
    temp[4] = I2C_read_byte(0);
    temp[5] = I2C_read_byte(0);
    temp[6] = I2C_read_byte(0);
    temp[7] = I2C_read_byte(1);
    for (i = 0; i < 8; i++) {
      emb_itoa(temp[i], OctetArray, 16, 2);
      UARTPrintf(OctetArray);
      UARTPrintf(" ");
    }
  UARTPrintf("\r\n");
  }

  UARTPrintf("IOControl Page Size: ");
  emb_itoa(HtmlPageIOControl_size, OctetArray, 16, 4);
  UARTPrintf(OctetArray);
  UARTPrintf("\r\n");


  UARTPrintf("Configuration Page Size: ");
  emb_itoa(HtmlPageConfiguration_size, OctetArray, 16, 4);
  UARTPrintf(OctetArray);
  UARTPrintf("\r\n");
#endif // OB_EEPROM_SUPPORT == 1
#endif // DEBUG_SUPPORT == 7 || DEBUG_SUPPORT == 15
}


uint16_t adjust_template_size(struct tHttpD* pSocket)
{
  uint16_t size;
  // declare and pre-calculate repeatedly used values
  int strlen_devicename_adjusted = (strlen(stored_devicename) - 4);
  
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


  //-------------------------------------------------------------------------//
  // A no-function check for current_webpage that allows the various options
  // to compile as "else if" statements.
  //-------------------------------------------------------------------------//
  if (pSocket->current_webpage == WEBPAGE_NULL) { }



  //-------------------------------------------------------------------------//
  // Adjust the size reported by the WEBPAGE_IOCONTROL template
  //-------------------------------------------------------------------------//
#if BUILD_SUPPORT == BROWSER_ONLY_BUILD || BUILD_SUPPORT == MQTT_BUILD
  else if (pSocket->current_webpage == WEBPAGE_IOCONTROL) {
    size = HtmlPageIOControl_size;

    // Account for header replacement strings %y04 %y05
    size = size + ps[4].size_less4
                + ps[5].size_less4;

    // Account for Device Name field %a00 in <title> and in body
    // This can be variable in size during run time so we have to calculate it
    // each time we display the web page.
    size = size + (2 * strlen_devicename_adjusted);

    // Account for Config string %g00
    // There is 1 instance
    // value_size is 2 (2 characters)
    // size = size + (#instances x (value_size - marker_field_size));
    // size = size + (#instances x (2 - 4));
    // size = size + (1 x (-2));
    size = size - 2;

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

#if BUILD_SUPPORT == BROWSER_ONLY_BUILD
    // Account for IO Name fields %j00 to %j15
    // Each can be variable in size during run time so we have to calculate
    // them  each time we display the web page.
    {
      int i;
      for (i=0; i<15; i++) {
        size = size + (strlen(IO_NAME[i]) - 4);
      }
    }
#endif // BUILD_SUPPORT == BROWSER_ONLY_BUILD
  }
#endif // BUILD_SUPPORT == BROWSER_ONLY_BUILD || BUILD_SUPPORT == MQTT_BUILD


  //-------------------------------------------------------------------------//
  // Adjust the size reported by the WEBPAGE_CONFIGURATION template
  //-------------------------------------------------------------------------//
#if BUILD_SUPPORT == BROWSER_ONLY_BUILD || BUILD_SUPPORT == MQTT_BUILD
  else if (pSocket->current_webpage == WEBPAGE_CONFIGURATION) {
    size = HtmlPageConfiguration_size;

    // Account for header replacement strings %y04 %y05
    size = size + ps[4].size_less4
                + ps[5].size_less4;

    // Account for Device Name field %a00 in <title> and in body
    // This can be variable in size during run time so we have to calculate it
    // each time we display the /web page.
    size = size + (2 * strlen_devicename_adjusted);

    // Account for HTML IP Address, Gateway Address, and
    // Netmask fields %b00, %b04, %b08
    // There are 3 instances of these fields
    // size = size + (#instances x (value_size - marker_field_size));
    // size = size + (3 x (8 - 4));
    // size = size + (3 x (4));
    size = size + 12;

    // Account for HTML Port field %c00
    // There is 1 instance
    // size = size + (#instances x (value_size - marker_field_size));
    // size = size + (1 x (5 - 4));
    // size = size + (1 x (1));
    // size = size + 1;
    size = size + 1;

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

    // Account for Code Revision + Code Type insertion %w00
    // size = size + (#instances x (value_size - marker_field_size));
    // size = size + (#instances x (26 - 4));
    // size = size + (1 x 22);
    size = size + 22;

    // Account for pin control field %h00
    // size = size + (#instances x (value_size - marker_field_size));
    // size = size + (#instances x (32 - 4));
    // size = size + (1 x 28);
    size = size + 28;

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
    // There are 3 instances (Reboot, Refresh and IO Control buttons)
    // size = size + (#instances x (value_size - marker_field_size));
    // size = size + (#instances) x (ps[2].size - 4);
    // size = size + (3) x ps[2].size_less4;
    size = size + (3 * ps[2].size_less4);
    
#if BUILD_SUPPORT == BROWSER_ONLY_BUILD
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
#endif // BUILD_SUPPORT == BROWSER_ONLY_BUILD
 
#if BUILD_SUPPORT == MQTT_BUILD
    // Account for MQTT IP Address field %b12
    // There is 1 instance
    // size = size + (#instances x (value_size - marker_field_size));
    // size = size + (1 x (8 - 4));
    // size = size + (1 x (4));
    size = size + 4;
    
    // Account for MQTT Port field %c01
    // There is 1 instance
    // size = size + (#instances x (value_size - marker_field_size));
    // size = size + (1 x (5 - 4));
    // size = size + (1 x (1));
    // size = size + 1;
    size = size + 1;

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
#endif // BUILD_SUPPORT == MQTT_BUILD
  }
#endif // BUILD_SUPPORT == BROWSER_ONLY_BUILD || BUILD_SUPPORT == MQTT_BUILD


  //-------------------------------------------------------------------------//
  // Adjust the size reported by the WEBPAGE_STATS1 template
  //-------------------------------------------------------------------------//
#if UIP_STATISTICS == 1 && BUILD_SUPPORT == BROWSER_ONLY_BUILD
  else if (pSocket->current_webpage == WEBPAGE_STATS1) {
    size = (uint16_t)(sizeof(g_HtmlPageStats1) - 1);

    // Account for header replacement strings %y04 %y05
    size = size + ps[4].size_less4
                + ps[5].size_less4;

    // Account for Device Name field %a00 in <title>
    // This can be variable in size during run time so we have to calculate it
    // each time we display the web page.
    size = size + strlen_devicename_adjusted;
    
    // Account for Statistics fields %e00 to %e21
    // There are 22 instances of these fields
    // size = size + (#instances x (value_size - marker_field_size));
    // size = size + (22 x (10 - 4));
    // size = size + (22 x (6));
    size = size + 132;
  }
#endif // UIP_STATISTICS == 1 && BUILD_SUPPORT == BROWSER_ONLY_BUILD


  //-------------------------------------------------------------------------//
  // Adjust the size reported by the WEBPAGE_STATS2 template
  //-------------------------------------------------------------------------//
#if DEBUG_SUPPORT == 11 || DEBUG_SUPPORT == 15
  else if (pSocket->current_webpage == WEBPAGE_STATS2) {
    size = (uint16_t)(sizeof(g_HtmlPageStats2) - 1);

    // Account for header replacement strings %y04 %y05
    size = size + ps[4].size_less4
                + ps[5].size_less4;

    // Account for Device Name field %a00 in <title>
    // This can be variable in size during run time so we have to calculate it
    // each time we display the web page.
    size = size + strlen_devicename_adjusted;

    // Account for Statistics fields %e31, %e32, %e33, %e35
    // There are 4 instances of these fields
    // size = size + (#instances x (value_size - marker_field_size));
    // size = size + (4 x (10 - 4));
    // size = size + (4 x (6));
    size = size + 24;
  }
#endif // DEBUG_SUPPORT


  //-------------------------------------------------------------------------//
  // Adjust the size reported by the DEBUG_SENSOR_SERIAL template
  //-------------------------------------------------------------------------//
#if DEBUG_SENSOR_SERIAL == 1
  else if (pSocket->current_webpage == WEBPAGE_SENSOR_SERIAL) {
    size = (uint16_t)(sizeof(g_HtmlPageTmpSerialNum) - 1);

    // Account for header replacement strings %y04 %y05
    size = size + ps[4].size_less4
                + ps[5].size_less4;

    // Account for Device Name field %a00 in <title>
    // This can be variable in size during run time so we have to calculate it
    // each time we display the web page.
    size = size + strlen_devicename_adjusted;
  }
#endif // DEBUG_SENSOR_SERIAL


  //-------------------------------------------------------------------------//
  // Adjust the size reported by the WEBPAGE_SSTATE template
  //-------------------------------------------------------------------------//
#if BUILD_SUPPORT == BROWSER_ONLY_BUILD || BUILD_SUPPORT == MQTT_BUILD
  else if (pSocket->current_webpage == WEBPAGE_SSTATE) {
    size = (uint16_t)(sizeof(g_HtmlPageSstate) - 1);
    
    // Account for header replacement strings %y04 %y05
//    size = size + ps[4].size_less4
//                + ps[5].size_less4;

    // Account for Device Name field %a00 in <title>
    // This can be variable in size during run time so we have to calculate it
    // each time we display the web page.
//    size = size + strlen_devicename_adjusted;

    // Account for Short Form IO Settings field (%f00)
    // size = size + (value size - marker_field_size)
    // size = size + (16 - 4);
    size = size + 12;
  }
#endif // BUILD_SUPPORT == BROWSER_ONLY_BUILD || BUILD_SUPPORT == MQTT_BUILD


#if OB_EEPROM_SUPPORT == 1
#if BUILD_SUPPORT == BROWSER_ONLY_BUILD || BUILD_SUPPORT == MQTT_BUILD
  //-------------------------------------------------------------------------//
  // Adjust the size reported by the WEBPAGE_LOADUPLOADER template
  //-------------------------------------------------------------------------//
  else if (pSocket->current_webpage == WEBPAGE_LOADUPLOADER) {
    size = (uint16_t)(sizeof(g_HtmlPageLoadUploader) - 1);
    
    // Account for header replacement strings %y04 %y05
    size = size + ps[4].size_less4
                + ps[5].size_less4;
  }
#endif // BUILD_SUPPORT == BROWSER_ONLY_BUILD || BUILD_SUPPORT == MQTT_BUILD
#endif // OB_EEPROM_SUPPORT == 1


#if BUILD_SUPPORT == CODE_UPLOADER_BUILD
  //-------------------------------------------------------------------------//
  // Adjust the size reported by the WEBPAGE_UPLOADER template
  //-------------------------------------------------------------------------//
  else if (pSocket->current_webpage == WEBPAGE_UPLOADER) {
    size = (uint16_t)(sizeof(g_HtmlPageUploader) - 1);

    // Account for header replacement strings %y04 %y05
    size = size + ps[4].size_less4
                + ps[5].size_less4;
  }


  //-------------------------------------------------------------------------//
  // Adjust the size reported by the WEBPAGE_EXISTING_IMAGE template
  //-------------------------------------------------------------------------//
  else if (pSocket->current_webpage == WEBPAGE_EXISTING_IMAGE) {
    size = (uint16_t)(sizeof(g_HtmlPageExistingImage) - 1);
    
    // Account for header replacement strings %y04 %y05
    size = size + ps[4].size_less4
                + ps[5].size_less4;
  }


  //-------------------------------------------------------------------------//
  // Adjust the size reported by the WEBPAGE_TIMER template
  //-------------------------------------------------------------------------//
  else if (pSocket->current_webpage == WEBPAGE_TIMER) {
    size = (uint16_t)(sizeof(g_HtmlPageTimer) - 1);
    
    // Account for header replacement strings %y04 %y05
    size = size + ps[4].size_less4
                + ps[5].size_less4;
  }


  //-------------------------------------------------------------------------//
  // Adjust the size reported by the WEBPAGE_UPLOAD_COMPLETE template
  //-------------------------------------------------------------------------//
  else if (pSocket->current_webpage == WEBPAGE_UPLOAD_COMPLETE) {
    size = (uint16_t)(sizeof(g_HtmlPageUploadComplete) - 1);
    
    // Account for header replacement strings %y04 %y05
    size = size + ps[4].size_less4
                + ps[5].size_less4;
  }


  //-------------------------------------------------------------------------//
  // Adjust the size reported by the WEBPAGE_PARSEFAIL template
  //-------------------------------------------------------------------------//
  else if (pSocket->current_webpage == WEBPAGE_PARSEFAIL) {
    size = (uint16_t)(sizeof(g_HtmlPageParseFail) - 1);
    
    // Account for header replacement strings %y04 %y05
    size = size + ps[4].size_less4
                + ps[5].size_less4;
    
    // Account for EEPROM status string %s02
    // size = size + (value size - marker_field_size)
    // size = size + (40 - 4);
    size = size + 36;
  }

#endif // BUILD_SUPPORT == CODE_UPLOADER_BUILD


#if OB_EEPROM_SUPPORT == 1
  //-------------------------------------------------------------------------//
  // Adjust the size reported by the WEBPAGE_EEPROM_MISSING template
  //-------------------------------------------------------------------------//
  else if (pSocket->current_webpage == WEBPAGE_EEPROM_MISSING) {
    size = (uint16_t)(sizeof(g_HtmlPageEEPROMMissing) - 1);
    
    // Account for header replacement strings %y04 %y05
    size = size + ps[4].size_less4
                + ps[5].size_less4;    
  }
#endif // OB_EEPROM_SUPPORT == 1
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
  // The resulting string in str will be NULL terminated on completion.
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
  if (ch >= 'A' && ch <= 'F') return ch - 'A' + 10;
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
  OctetArray[0] = int2nibble(j);
  
  j = (uint8_t)(i & 0x0f);
  OctetArray[1] = int2nibble(j);
  
  OctetArray[2] = '\0';
}


uint8_t int2nibble(uint8_t j)
{
  // Convert a 4 bit integer to a character (a single nibble).
  if(j<=9) return (uint8_t)(j + '0');
  else return (uint8_t)(j - 10 + 'a');
}


static uint16_t CopyHttpHeader(uint8_t* pBuffer, uint16_t nDataLen)
{
  uint16_t nBytes;
  int i;
  
  static const char http_string1[] = 
    "HTTP/1.1 200 OK\r\n"
    "Content-Length:";
  static const char http_string2[] = 
    "\r\n"
    "Cache-Control: no-cache, no-store\r\n"
    "Content-Type: text/html; charset=utf-8\r\n"
    "Connection:close\r\n\r\n";

  nBytes = 0;

  pBuffer = stpcpy(pBuffer, http_string1);
  nBytes += strlen(http_string1);

  // This creates the "xxxxx" part of a 5 character "Content-Length:xxxxx" field in the pBuffer.
  emb_itoa(nDataLen, OctetArray, 10, 5);
  pBuffer = stpcpy(pBuffer, OctetArray);
  nBytes += 5;

  pBuffer = stpcpy(pBuffer, http_string2);
  nBytes += strlen(http_string2);
  
  return nBytes;
}


static uint16_t CopyHttpData(uint8_t* pBuffer,
                             const char** ppData,
			     uint16_t* pDataLeft,
			     uint16_t nMaxBytes,
			     struct tHttpD* pSocket)
{
  // This function copies the selected webpage from flash storage to the
  // output buffer.
  // pBuffer - the output buffer
  // ppData - the Flash storage for the Webpage template
  // pDataLeft - remaining size of the template to be processed
  // nMaxBytes - size of the output buffer
  // While performing the copy the stream of characters in the webpage
  // template is searched for special markers that indicate where template
  // text should be replaced with variable length text.
    
  uint8_t nByte;
  uint8_t nParsedNum;
  uint8_t nParsedMode;
  uint8_t temp;
  int i;
  int no_err;
  unsigned char temp_octet[3];
  uint8_t* pBuffer_start;
  
  // For use only in upgradeable builds:
  #define PRE_BUF_SIZE	230
  char pre_buf[PRE_BUF_SIZE];
  uint16_t pre_buf_ptr = 0;

  
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
  //-------------------------------------------------------------------------//
  // See the uipopt.h file for the UIP_TCP_MSS definition. It must be smaller
  // than the UIP_BUF less the headers that are also inserted in the UIP_BUF
  // by the UIP code. The UIP_BUF size is determined by the ENC28J60_MAXFRAME
  // value set in the enc28j60.h file.
  // 
  // Note: The ENC28J60 value was on the order of 900 bytes in the original
  // code. However, due to limited RAM size, a smaller value was selected for
  // this application. The primary limitation is when building MQTT code
  // ENC28J60_MAXFRAME ends up being further limited to allow room for the
  // MQTT variables and data buffer.
  //
  // Note: Complete transmission of the typical webpage in this application is
  // about 4000 bytes.
  //
  //-------------------------------------------------------------------------//
  // nMaxbytes must be smaller than UIP_TCP_MSS due to the need to allow for
  // the largest string insertion that is NOT a %yxx replacement (as %y00
  // replacements can be interrupted if the buffer fills and can be continued
  // at the next call of this routine).
  //
  // nMaxBytes should not cause a TCP datagram formation larger than 536
  // bytes.
  //
  // The following statement over-rides the nMaxBytes value passed to the
  // function to account for extra bytes that might be sent in a single pass
  // of the loop below. This causes most packet transmissions to be smaller,
  // but accomodates those that have the extra bytes inserted.
  nMaxBytes = UIP_TCP_MSS - 40;
  //-------------------------------------------------------------------------//



  //-------------------------------------------------------------------------//
#if OB_EEPROM_SUPPORT == 1
  if (pSocket->current_webpage == WEBPAGE_IOCONTROL || pSocket->current_webpage == WEBPAGE_CONFIGURATION) {
    // This code is applicable only when the Off-Board EERPOM is used to store
    // the IOControl and Configuration webpage templates.
    // Reading templates from the Off-Board EEPROM is very slow relative to
    // reading the templates from STM8 Flash. So the "pre_buf[]" array is used
    // to bulk read template data from the Off-Board EEPROM to improve code
    // speed. pre_buf is then used to provide data to the webpage transmission
    // code.
    // Optimization:
    //  - Packet transmission size will never about 440 bytes
    //  - There isn't enough RAM to have a 440 byte buffer so later in the
    //    process the pre_buf gets re-loaded
    //  - Thus the pre_buf only needs to be about 230 bytes (to minimize the
    //    amount of data read from the EEPROM per packet, thus minimizing
    //    time spent reading the data).
    //  - I say "about 230 bytes" because there is some variability in how
    //    much needs to be read due to the need to compensate for aliasing of
    //    the read-from-EEPROM vs the collection of "%-nParsedMode-nParsedNum"
    //    values. To account for this aliasing the buffer will get refilled
    //    a few bytes before it is completely empty (see the refill code
    //    further below).
    
    {
      uint16_t i;
      
      prep_read(I2C_EEPROM2_WRITE, I2C_EEPROM2_READ, off_board_eeprom_index);
      for (i = 0; i < (PRE_BUF_SIZE - 1); i++) {
        pre_buf[i] = I2C_read_byte(0);
      }
      pre_buf[PRE_BUF_SIZE - 1] = I2C_read_byte(1);
      pre_buf_ptr = 0;
    }
  }
#endif // OB_EEPROM_SUPPORT == 1
  //-------------------------------------------------------------------------//


  while ((uint16_t)(pBuffer - pBuffer_start) < nMaxBytes) {
    // This is the main loop for processing the page templates stored in
    // flash and inserting variable data as the webpage is copied to the
    // transmission buffer.
    //
    // The variable *pDataLeft counts down the amount of data not yet
    // "consumed" from the source web page template.
    //
    // There are a large number of "markers" in the template (example: %a01)
    // that get replaced by other text when the template is read and copied
    // to the transmit buffer. Thus, the amount of data actually sent for a
    // given page can greatly exceed the original size of the template.
    //
    // There are two ways this loop terminates:
    // 1) If (pBuffer - pBuffer_start) exceeds nMaxBytes.
    // 2) If *pDataLeft reaches a count of zero.
    // If the loop terminates and there is still data left to transmit (as
    // indicated by pDataLeft > 0) the calling routine will call the function
    // again.
    
    if (*pDataLeft > 0) {
      // If pDataLeft > 0 then we are (or are still) processing a page
      // template.
    
      if (pSocket->insertion_index != 0) {
        // If we previously interrupted an insertion string transfer to the
	// transmit buffer then we don't want to read a character from the
	// template, and instead we want to continue with the insertion string
	// process. In this case use the retained nParsedMode and nParsedNum
	// values so that we return to the %yxx part of the function. Note
	// that if we are in the process of copying an insertion string to the
	// transmit buffer the insertion_index will be non-zero.
        // insertion_index = %yxx insertion byte index (1 byte)
        // nParsedMode ('y' in this case)
        // nParsedNum  (0, 1, 2, etc)
	// Note: Since pSocket->ParseCmd and pSocket->ParseNum are not being
	// used while this code is running I repurposed them as temporary
	// storage for the nParsedMode and nParsedNum values until the next
	// packet generation is started.
        nParsedMode = pSocket->ParseCmd;
        nParsedNum = pSocket->ParseNum;
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
        
#if OB_EEPROM_SUPPORT == 0
	nByte = **ppData;
#endif // OB_EEPROM_SUPPORT == 0

#if OB_EEPROM_SUPPORT == 1
        if (pSocket->current_webpage == WEBPAGE_IOCONTROL || pSocket->current_webpage == WEBPAGE_CONFIGURATION) {
          {
            uint16_t i;
            // This code is applicable only when the Off-Board EERPOM is used
	    // to store the IOControl and Configuration webpage templates.
            //
            // If we arrive here and find that the pre_buf is almost empty then
	    // refill it starting with the current location in the
	    // off_board_eeprom_index. Since the pre_buf_ptr can get incre-
	    // mented up to 4 times before we check it again we need to reload
	    // the buffer brefore we reach the end of the buffer. Since we are
	    // reloading from the current point in the EEPROM no data is lost.
            if (pre_buf_ptr > (PRE_BUF_SIZE - 6)) {
              prep_read(I2C_EEPROM2_WRITE, I2C_EEPROM2_READ, off_board_eeprom_index);
              for (i = 0; i < (PRE_BUF_SIZE - 1); i++) {
                pre_buf[i] = I2C_read_byte(0);
              }
              pre_buf[PRE_BUF_SIZE - 1] = I2C_read_byte(1);
              pre_buf_ptr = 0;
            }
          }
	  
          // Read 1 byte from the pre_buf
	  nByte = pre_buf[pre_buf_ptr];
	}
	else nByte = **ppData;
#endif // OB_EEPROM_SUPPORT == 1


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
	// %s - EEPROM presence status. Output only.
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
#if OB_EEPROM_SUPPORT == 1
          if (pSocket->current_webpage == WEBPAGE_IOCONTROL || pSocket->current_webpage == WEBPAGE_CONFIGURATION) {
	    off_board_eeprom_index++;
            pre_buf_ptr++;
	  }
#endif // OB_EEPROM_SUPPORT == 1
          
          // Collect the "nParsedMode" value (the i, o, a, b, c, etc part of
	  // the field). This, along with the "nParsedNum" digits that follow,
	  // will determine what data is put in the output stream.
#if OB_EEPROM_SUPPORT == 0
	  nParsedMode = **ppData;
#endif // OB_EEPROM_SUPPORT == 0
#if OB_EEPROM_SUPPORT == 1
          if (pSocket->current_webpage == WEBPAGE_IOCONTROL || pSocket->current_webpage == WEBPAGE_CONFIGURATION) {
	    // Read 1 byte from pre_buf
	    nParsedMode = pre_buf[pre_buf_ptr];
	    off_board_eeprom_index++;
            pre_buf_ptr++;
	  }
	  else nParsedMode = **ppData;
#endif // OB_EEPROM_SUPPORT == 1
          (*ppData)++;
          (*pDataLeft)--;
          
          // Collect the first digit of the "nParsedNum" which follows the
	  // "nParsedMode". This is the "tens" digit of the two character
	  // nParsedNum.
#if OB_EEPROM_SUPPORT == 0
	  temp = **ppData;
#endif // OB_EEPROM_SUPPORT == 0
#if OB_EEPROM_SUPPORT == 1
          if (pSocket->current_webpage == WEBPAGE_IOCONTROL || pSocket->current_webpage == WEBPAGE_CONFIGURATION) {
	    // Read 1 byte from pre_buf
	    temp = pre_buf[pre_buf_ptr];
	    off_board_eeprom_index++;
            pre_buf_ptr++;
	  }
  	  else temp = **ppData;
#endif // OB_EEPROM_SUPPORT == 1
          nParsedNum = (uint8_t)((temp - '0') * 10);
          (*ppData)++;
          (*pDataLeft)--;

          // Collect the second digit of the "nParsedNum". This is the "ones"
	  // digit. Add it to the "tens" digit to complete the number in
	  // integer form.
#if OB_EEPROM_SUPPORT == 0
	  temp = **ppData;
#endif // OB_EEPROM_SUPPORT == 0
#if OB_EEPROM_SUPPORT == 1
          if (pSocket->current_webpage == WEBPAGE_IOCONTROL || pSocket->current_webpage == WEBPAGE_CONFIGURATION) {
	    // Read 1 byte from pre_buf
	    temp = pre_buf[pre_buf_ptr];
	    off_board_eeprom_index++;
	    pre_buf_ptr++;
	  }
	  else temp = **ppData;
#endif // OB_EEPROM_SUPPORT == 1
          nParsedNum = (uint8_t)(nParsedNum + temp - '0');
          (*ppData)++;
          (*pDataLeft)--;
	}
      }

      if ((nByte == '%') || (pSocket->insertion_index != 0)) {
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
	

#if UIP_STATISTICS == 1 && BUILD_SUPPORT == BROWSER_ONLY_BUILD
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
#endif // UIP_STATISTICS == 1 && BUILD_SUPPORT == BROWSER_ONLY_BUILD


#if DEBUG_SUPPORT == 11 || DEBUG_SUPPORT == 15
        else if ((nParsedMode == 'e') && (nParsedNum >= 30) && (nParsedNum < 40)) {
          if (nParsedNum == 31) {
	    emb_itoa(second_counter, OctetArray, 10, 10);
            pBuffer = stpcpy(pBuffer, OctetArray);
	  }
          else if (nParsedNum == 32) {
	    emb_itoa(TRANSMIT_counter, OctetArray, 10, 10);
            pBuffer = stpcpy(pBuffer, OctetArray);
	  }
          else if (nParsedNum == 33) {
	    for (i=0; i<5; i++) {
              int2hex(stored_debug[i]);
              pBuffer = stpcpy(pBuffer, OctetArray);
	    }
	  }
          else if (nParsedNum == 35) {
            *pBuffer++ = '0';
            *pBuffer++ = '0';
            *pBuffer++ = '0';
            *pBuffer++ = '0';
            int2hex(MQTT_resp_tout_counter);
            pBuffer = stpcpy(pBuffer, OctetArray);
            int2hex(MQTT_not_OK_counter);
            pBuffer = stpcpy(pBuffer, OctetArray);
            int2hex(MQTT_broker_dis_counter);
            pBuffer = stpcpy(pBuffer, OctetArray);
	  }
	}
#endif // DEBUG_SUPPORT


#if DEBUG_SENSOR_SERIAL == 1
        else if ((nParsedMode == 'e') && (nParsedNum >= 40)) {
	  // This is for diagnostic use only and is NOT normally enabled
	  // in the compile options. This displays the Temperature Sensor
	  // Serial Numbers and was made necessary due to some suppliers
	  // providing DS18B20 devices with identical serial numbers.
          if ((nParsedNum - 40) <= numROMs) {
	    {
              int n;
              for (n=6; n>0; n--) {
                int2hex(FoundROM[nParsedNum - 40][n]);
	        pBuffer = stpcpy(pBuffer, OctetArray);
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
          // Bit 7: Undefined, 0 only
          // Bit 6: Undefined, 0 only
          // Bit 5: Undefined, 0 only
          // Bit 4: Disable Cfg Button
          //        1 = Disable, 0 = Enable
          // Bit 3: DS18B20
          //        1 = Enable, 0 = Disable
          // Bit 2: MQTT
          //        1 = Enable, 0 = Disable
          // Bit 1: Home Assistant Auto Discovery
          //        1 = Enable, 0 = Disable
          // Bit 0: Duplex
          //        1 = Full, 0 = Half
	  // There is only 1 'g' ID so we don't need to check the nParsedNum.
	  
	  // Convert Config settngs byte into two hex characters
          int2hex(stored_config_settings);
	  pBuffer = stpcpy(pBuffer, OctetArray);
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
	      pBuffer = stpcpy(pBuffer, OctetArray);
            }
	  }
	}


#if BUILD_SUPPORT == BROWSER_ONLY_BUILD
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
            pBuffer = stpcpy(pBuffer, OctetArray);
	    j = (uint8_t)(IO_TIMER[nParsedNum] & 0x00ff);
	    int2hex(j);
            pBuffer = stpcpy(pBuffer, OctetArray);
          }
	}
	
	
        else if (nParsedMode == 'j') {
	  // This displays IO Names in user friendly format (1 to 15 characters)
          pBuffer = stpcpy(pBuffer, IO_NAME[nParsedNum]);
	}
#endif // BUILD_SUPPORT == BROWSER_ONLY_BUILD


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


#if OB_EEPROM_SUPPORT == 1
        else if (nParsedMode == 's') {
#if BUILD_SUPPORT == CODE_UPLOADER_BUILD
	  if (nParsedNum == 2) {
	    // This sends the Parse Fail reason code. %s02
	    // Note: String copied to the pBuffer must be 40 characters
	    if (upgrade_failcode == UPGRADE_FAIL_FILE_READ_CHECKSUM)
	      pBuffer = stpcpy(pBuffer, "Checksum error receiving file...........");
	    else if (upgrade_failcode == UPGRADE_FAIL_EEPROM_MISCOMPARE)
	      pBuffer = stpcpy(pBuffer, "EEPROM content miscompare...............");
	    else if (upgrade_failcode == STRING_EEPROM_MISCOMPARE)
	      pBuffer = stpcpy(pBuffer, "EEPROM content miscompare...............");
	    else if (upgrade_failcode == UPGRADE_FAIL_NOT_SREC)
	      pBuffer = stpcpy(pBuffer, "SREC file format incorrect..............");
	    else
	      pBuffer = stpcpy(pBuffer, "Unknown Error...........................");
	  }
#endif // BUILD_SUPPORT == CODE_UPLOADER_BUILD
	}
#endif // OB_EEPROM_SUPPORT == 1


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
	  // This displays Code Revision information (13 characters) plus Code
	  // Type (13 characters, '.' characters are added to make sure the
	  // length is always 13)
          pBuffer = stpcpy(pBuffer, code_revision);
	  
#if BUILD_SUPPORT == BROWSER_ONLY_BUILD	&& I2C_SUPPORT == 0 && OB_EEPROM_SUPPORT == 0
          pBuffer = stpcpy(pBuffer, " Browser Only");
#endif

#if BUILD_SUPPORT == MQTT_BUILD	&& I2C_SUPPORT == 0 && OB_EEPROM_SUPPORT == 0
          pBuffer = stpcpy(pBuffer, " MQTT .......");
#endif

#if BUILD_SUPPORT == BROWSER_ONLY_BUILD	&& I2C_SUPPORT == 1 && OB_EEPROM_SUPPORT == 1
          pBuffer = stpcpy(pBuffer, " Browser UPG ");
#endif

#if BUILD_SUPPORT == MQTT_BUILD	&& I2C_SUPPORT == 1 && OB_EEPROM_SUPPORT == 1
          pBuffer = stpcpy(pBuffer, " MQTT UPG ...");
#endif
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
	  // a) If a %yxx placeholder is detected in the template as much of
	  //    the replacement string is inserted in the send buffer as
	  //    possible.
	  // b) An "insertion_index" is filled to contain the index into the
	  //    string being inserted into the transmit buffer. If this index
	  //    is zero we know we are just starting to insert a %y00 string.
	  //    If this index is non-zero on entry to this code we know we are
	  //    already in the process of inserting a %yxx string and will
	  //    continue that insertion here.
	  // c) If the CopyHttpData() function hits the maximum character
	  //    insertion limit for the packet it does a normal return to the
	  //    calling function, and the insertion_index is retained in the
	  //    socket struct. nParsedMode and nParsedNum are also retained
	  //    in the socket struct in the pSocket->ParseCmd and
	  //    pSocket->ParseNum variables. This stores the information
	  //    needed to continue the string insertion on the next call to
	  //    CopyHttpData().
	  // d) If the entire string is inserted successfully the
	  //    insertion_index is cleared to 0.
	  // d) When CopyHttpData() is called again it will check the
	  //    insertion_index to determine if a string insertion was prev-
	  //    iously underway. If so the function will jump to this point
	  //    in the routine and will continue the string insertion.
          
	  // insertion_index will be 0 if we are just starting insertion of a
	  //   string.
	  // insertion_index will be non-0 if a string insertion was started
	  //   and is not yet complete. In this case insertion_index is an
	  //   index to the next character in the source string that is to be
	  //   inserted into the transmit buffer.

          // pSocket->ParseCmd and pSocket->ParseNum are used to temporarily
          // store the nParsedMode and nParsedNum values until the start of
	  // the next transmit packet generation. These struct are repurposed
	  // for this storage because they are not being used while this code
	  // is running.

	  i = pSocket->insertion_index;
	  pSocket->ParseCmd = nParsedMode;
	  pSocket->ParseNum = nParsedNum;
	  
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
	  pSocket->insertion_index++;
	  if (pSocket->insertion_index == ps[nParsedNum].size) pSocket->insertion_index = 0;
          pBuffer++;
	}
      }


      else {
        // If the above code did not process a "%" nParsedMode code and we were
	// not continuing a string insertion then whatever character we read from
	// the page template is copied as-is to the uip_buf for transmission.
        *pBuffer = nByte;
        *ppData = *ppData + 1;
        *pDataLeft = *pDataLeft - 1;
        pBuffer++;
#if OB_EEPROM_SUPPORT == 1
        if (pSocket->current_webpage == WEBPAGE_IOCONTROL || pSocket->current_webpage == WEBPAGE_CONFIGURATION) {
          off_board_eeprom_index++;
	  pre_buf_ptr++;
	}
#endif // OB_EEPROM_SUPPORT == 1
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


void HttpDInit(void)
{
  // Initialize the structures that manage each connection in the form of a
  // protosocket
  int i;
  register struct uip_conn *uip_connr = uip_conn;
  
  // Initialize the struct tHttpD values
  for (i = 0; i < UIP_CONNS; i++) {
    uip_connr = &uip_conns[i];
//    init_tHttpD_struct(&uip_connr->appstate.HttpDSocket);
    init_tHttpD_struct(&uip_connr->appstate.HttpDSocket, i);
  }

  // Start listening on our port
  uip_listen(htons(Port_Httpd));
}


// void init_tHttpD_struct(struct tHttpD* pSocket) {
void init_tHttpD_struct(struct tHttpD* pSocket, int i) {
  // Initialize the contents of the struct tHttpD
  // This function is called UIP_CONNS times by the HttpDinit function. It is
  // called once for each possible connection. The function sets the initial
  // values within the pSocket structure to give a new connection a "starting
  // place", such as which page to initially display when a connection is made
  // that does not call out a specific page.

#if BUILD_SUPPORT == BROWSER_ONLY_BUILD || BUILD_SUPPORT == MQTT_BUILD
//  pSocket->current_webpage = WEBPAGE_IOCONTROL;
  pSocket->current_webpage = WEBPAGE_NULL;
//  pSocket->structID = i; // TEMPORARY DEBUG MARKER
#endif // BUILD_SUPPORT == BROWSER_ONLY_BUILD || BUILD_SUPPORT == MQTT_BUILD
  
#if BUILD_SUPPORT == CODE_UPLOADER_BUILD
  pSocket->current_webpage = WEBPAGE_UPLOADER;
#endif // BUILD_SUPPORT == CODE_UPLOADER_BUILD

// UARTPrintf("init_tHttpd_struct\r\n");

  pSocket->nState = STATE_NULL;
  pSocket->ParseState = PARSE_NULL;
  pSocket->nNewlines = 0;
  pSocket->insertion_index = 0;
  init_off_board_string_pointers(pSocket);
}


void HttpDCall(uint8_t* pBuffer, uint16_t nBytes, struct tHttpD* pSocket)
{
  uint16_t nBufSize;
  int i;
  uint8_t j;
  char compare_buf[32];
  uint8_t GET_response_type = 200;

  // HttpDCall() is used to:
  // a) Receive a request or data from the Browser:
  //    In the form of a GET if the Browser is requesting a web page or other
  //    other action.
  //    In the form of a POST if the Broswer is sending data to the
  //    application.
  // b) Send a requsted web page to the Browser:
  //    This uses the "if (uip_connected())" part of the code below to start a
  //    new page transmission and the "if (uip_acked())" part of the code
  //    below if continuing a page transmission.

  i = 0;
  j = 0;

// UARTPrintf("HttpDCall: current_webpage = ");
// emb_itoa(pSocket->current_webpage, OctetArray, 10, 5);
// UARTPrintf(OctetArray);
// UARTPrintf("  listening port = ");
// emb_itoa(uip_conn->lport, OctetArray, 10, 5);
// UARTPrintf(OctetArray);
// UARTPrintf("   structID = ");
// emb_itoa(pSocket->structID, OctetArray, 10, 5);
// UARTPrintf(OctetArray);
// UARTPrintf("\r\n");


  if (uip_connected()) {
    //Initialize this connection
    
// UARTPrintf("HttpDCall: uip_connected\r\n");

// UARTPrintf("HttpDCall: uip_connected  current_webpage = ");
// emb_itoa(pSocket->current_webpage, OctetArray, 10, 5);
// UARTPrintf(OctetArray);
// UARTPrintf("   structID = ");
// emb_itoa(pSocket->structID, OctetArray, 10, 5);
// UARTPrintf(OctetArray);
// UARTPrintf("\r\n");

#if BUILD_SUPPORT == BROWSER_ONLY_BUILD || BUILD_SUPPORT == MQTT_BUILD
    if (pSocket->current_webpage == WEBPAGE_IOCONTROL) {
      pSocket->pData = g_HtmlPageIOControl;
      pSocket->nDataLeft = HtmlPageIOControl_size;
      // nDataLeft above is used when we get around to calling CopyHttpData
      // in state STATE_SENDDATA
    }
    
    if (pSocket->current_webpage == WEBPAGE_CONFIGURATION) {
      pSocket->pData = g_HtmlPageConfiguration;
      pSocket->nDataLeft = HtmlPageConfiguration_size;
    }
    
    if (pSocket->current_webpage == WEBPAGE_SSTATE) {
      pSocket->pData = g_HtmlPageSstate;
      pSocket->nDataLeft = (uint16_t)(sizeof(g_HtmlPageSstate) - 1);
    }

#if OB_EEPROM_SUPPORT == 1
    if (pSocket->current_webpage == WEBPAGE_LOADUPLOADER) {
      pSocket->pData = g_HtmlPageLoadUploader;
      pSocket->nDataLeft = (uint16_t)(sizeof(g_HtmlPageLoadUploader) - 1);
    }
#endif // OB_EEPROM_SUPPORT == 1
#endif // BUILD_SUPPORT == BROWSER_ONLY_BUILD || BUILD_SUPPORT == MQTT_BUILD

#if UIP_STATISTICS == 1 && BUILD_SUPPORT == BROWSER_ONLY_BUILD
    if (pSocket->current_webpage == WEBPAGE_STATS1) {
      pSocket->pData = g_HtmlPageStats1;
      pSocket->nDataLeft = (uint16_t)(sizeof(g_HtmlPageStats1) - 1);
    }
#endif // UIP_STATISTICS == 1 && BUILD_SUPPORT == BROWSER_ONLY_BUILD

#if DEBUG_SUPPORT == 11 || DEBUG_SUPPORT == 15
    if (pSocket->current_webpage == WEBPAGE_STATS2) {
      pSocket->pData = g_HtmlPageStats2;
      pSocket->nDataLeft = (uint16_t)(sizeof(g_HtmlPageStats2) - 1);
    }
#endif // DEBUG_SUPPORT

#if DEBUG_SENSOR_SERIAL == 1
    if (pSocket->current_webpage == WEBPAGE_SENSOR_SERIAL) {
      pSocket->pData = g_HtmlPageTmpSerialNum;
      pSocket->nDataLeft = (uint16_t)(sizeof(g_HtmlPageTmpSerialNum) - 1);
    }
#endif // DEBUG_SENSOR_SERIAL

#if BUILD_SUPPORT == CODE_UPLOADER_BUILD
    if (pSocket->current_webpage == WEBPAGE_UPLOADER) {
      pSocket->pData = g_HtmlPageUploader;
      pSocket->nDataLeft = (uint16_t)(sizeof(g_HtmlPageUploader) - 1);
    }

    if (pSocket->current_webpage == WEBPAGE_EXISTING_IMAGE) {
      pSocket->pData = g_HtmlPageExistingImage;
      pSocket->nDataLeft = (uint16_t)(sizeof(g_HtmlPageExistingImage) - 1);
    }

    if (pSocket->current_webpage == WEBPAGE_TIMER) {
      pSocket->pData = g_HtmlPageTimer;
      pSocket->nDataLeft = (uint16_t)(sizeof(g_HtmlPageTimer) - 1);
    }

    if (pSocket->current_webpage == WEBPAGE_UPLOAD_COMPLETE) {
      pSocket->pData = g_HtmlPageUploadComplete;
      pSocket->nDataLeft = (uint16_t)(sizeof(g_HtmlPageUploadComplete) - 1);
    }

    if (pSocket->current_webpage == WEBPAGE_PARSEFAIL) {
      pSocket->pData = g_HtmlPageParseFail;
      pSocket->nDataLeft = (uint16_t)(sizeof(g_HtmlPageParseFail) - 1);
    }
#endif // BUILD_SUPPORT == CODE_UPLOADER_BUILD


#if OB_EEPROM_SUPPORT == 1
    if (pSocket->current_webpage == WEBPAGE_EEPROM_MISSING) {
      pSocket->pData = g_HtmlPageEEPROMMissing;
      pSocket->nDataLeft = (uint16_t)(sizeof(g_HtmlPageEEPROMMissing) - 1);
    }
#endif // OB_EEPROM_SUPPORT == 1

    pSocket->nState = STATE_CONNECTED;
    pSocket->nPrevBytes = 0xFFFF;

    // Note on TCP Fragment reassembly: The uip_connected() steps ABOVE are
    // run for every TCP packet and fragment. That being the case we need to
    // be sure that TCP Fragment reassembly values are not changed in these
    // steps.
  }

  else if (uip_acked()) {

// UARTPrintf("HttpDCall: uip_acked\r\n");

// UARTPrintf("HttpDCall: uip_acked  current_webpage = ");
// emb_itoa(pSocket->current_webpage, OctetArray, 10, 5);
// UARTPrintf(OctetArray);
// UARTPrintf("   structID = ");
// emb_itoa(pSocket->structID, OctetArray, 10, 5);
// UARTPrintf(OctetArray);
// UARTPrintf("\r\n");

    // if uip_acked() is true we will be in the STATE_SENDDATA state and
    // only need to run the "senddata" part of this routine. This typically
    // happens when there are multiple packets to send to the Broswer in
    // response to a POST or GET, so we may repeat this loop in
    // STATE_SENDDATA several times.
    goto senddata;
  }
  
  else if (uip_newdata()) {

// UARTPrintf("HttpDCall: uip_newdata\r\n");

// UARTPrintf("HttpDCall: uip_newdata  current_webpage = ");
// emb_itoa(pSocket->current_webpage, OctetArray, 10, 5);
// UARTPrintf(OctetArray);
// UARTPrintf("   structID = ");
// emb_itoa(pSocket->structID, OctetArray, 10, 5);
// UARTPrintf(OctetArray);
// UARTPrintf("\r\n");

    // This is the start of a new Browser session, or it is additional packets
    // sent to complete a transmission from the Browser.
    //
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
    //      as the first four characters in the datagram. This comes right
    //      after the LLH, IP, and TCP Headers, so it will start at byte 55 of
    //      the uip_buf. We won't count on that exact byte number, but it is
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
    //   3c) With the addition of Off-Board EEPROMs and the ability to upload
    //      replacement code via Ethernet the POST pre-amble is parsed for the
    //      "Content-Type" phrase. The phrase is used to determine if the POST
    //      data contains a new firmware file, or if the POST data contains
    //      user entered responses to GUI fields.
    //   3d) Otherwise this code by-passes all the preamble/post-amble stuff
    //      but saves the parsing state so it knows we are either looking for
    //      data or disposing of extraneous fragments.
    //
      
    // In the code below we are parsing for the "POST" or "GET " phrase. We do
    // not need to worry about TCP fragmentation because the phrase will appear
    // very early in the first packet (easily within the first 100 bytes).
    // However, once we receive "POST" we go into a loop looking for the
    // "\r\n\r\n" sequence, and we need to be able to handle TCP fragmentation
    // during that search.
    //
    // If we are parsing a TCP fragment then pSocket->nState may have been
    // restored to STATE_PARSEPOST or STATE_PARSEGET. If so the parse code
    // will run but won't do anything.
    
    // If we are in STATE_CONNECTED (meaning we are reading the first and
    // perhaps only packet in a series) check the first five characters of the
    // uip_buf to see if this is a POST or GET request.
    if (pSocket->nState == STATE_CONNECTED) {
      if (memcmp("POST", &pBuffer[0], 4) == 0) pSocket->nState = STATE_GOTPOST;
      if (memcmp("GET", &pBuffer[0], 3) == 0)  pSocket->nState = STATE_GOTGET;
      pBuffer += 4;
      nBytes -= 4;
      // We are collecting the first packet. Clear parse_tail so it will be
      // ready if there is a TCP Fragment.
      parse_tail[0] = '\0';

// UARTPrintf("\r\n");
// UARTPrintf("pSocket->nState == STATE_CONNECTED, parse_tail set to NULL");
// UARTPrintf("\r\n");


#if BUILD_SUPPORT == CODE_UPLOADER_BUILD
      // Initialize the find_content_info state. It is used to manage the
      // search for the Content-Type and Content-Length phrases.
      find_content_info = SEEK_CONTENT_INFO;

// UARTPrintf("\r\n");
// UARTPrintf("find_content_info = SEEK_CONTENT_INFO initialize");
// UARTPrintf("\r\n");

#endif // BUILD_SUPPORT == CODE_UPLOADER_BUILD


    }
    

    if (pSocket->nState == STATE_GOTPOST) {
      // If this is a BROWSER_ONLY_BUILD or a MQTT_BUILD then the only kind of
      // POST we can receive is a "normal" POST consisting of values the user
      // entered in the GUI. If that is the case the data we want follows the
      // first \r\n\r\n sequence in the html body.
      // If this is a CODE_UPLOADER_BUILD then the only kind of POST we can
      // receive is a "file" POST wherein the POST consists of a new firmware
      // file. If that is the case the data we want follows the second
      // \r\n\r\n sequence in the html body. Note that we need to search the
      // html pre-amble for the "Content-Length" when running a Code Uploader
      // build.

// UARTPrintf("\r\n");
// UARTPrintf("pSocket->nState == STATE_GOTPOST Search for rnrn");
// UARTPrintf("\r\n");

      if (nBytes == 0) {
        // If we enter the search at end of fragment we exit and will come
	// back to this point with the next fragment.
        return;
      }


#if BUILD_SUPPORT == BROWSER_ONLY_BUILD || BUILD_SUPPORT == MQTT_BUILD
      while (nBytes != 0) {
	// The following searches for the \r\n\r\n sequence
	if (pSocket->nNewlines == 2) {
	  // This handles the case where a TCP Fragmentation occured in the
	  // previous packet just as we collected the second \n. In that case
	  // the search does not continue.
	}
	else {
          // We're processing packets but haven't found the \r\n\r\n sequence
          // yet. The sequence detector really just looks for two \n in a row,
          // ignoring the first \r. If any character other than \r appears
	  // between the \n and \n the Newlines counter is zero'd.
          if (*pBuffer == '\n') pSocket->nNewlines++;
          else if (*pBuffer == '\r') { }
          else pSocket->nNewlines = 0;
          pBuffer++;
          nBytes--;
          if (nBytes == 0) {
            // If we hit end of fragment we exit and will come back to the loop
            // with the next fragment.
            return;
          }
        }

        if (pSocket->nNewlines == 2) {
          // Beginning of non-file POST found.
	  
	  // Clear nNewlines for future POSTs
	  pSocket->nNewlines = 0;
	  
          // Set current_webpage to NULL. This will be used later to aid in
	  // determining if the POST is coming from an IOControl POST or from
	  // a Configuration POST.
	  pSocket->current_webpage = WEBPAGE_NULL;
	  
	  // Initialize parse_tail for first pass of parsing
	  parse_tail[0] = '\0';

// UARTPrintf("\r\n");
// UARTPrintf("Beginning of POST found. parse_tail set to NULL. nBytes = ");
// emb_itoa(nBytes, OctetArray, 10, 3);
// UARTPrintf(OctetArray);
// UARTPrintf("\r\n");


          // Start parsing
          pSocket->nState = STATE_PARSEPOST;
	  if (nBytes == 0) {
	    // If we are at end of fragment here we exit and will return in
	    // STATE_PARSEPOST
	    return;
	  }
          break;
        }
      }
#endif // BUILD_SUPPORT == BROWSER_ONLY_BUILD || BUILD_SUPPORT == MQTT_BUILD
	

#if BUILD_SUPPORT == CODE_UPLOADER_BUILD
      while (nBytes != 0) {
	// Search for the "Content-Length: " phrase. We're processing the first
	// packet but haven't found the phrase yet.
        if ((*pBuffer == 'C') && (find_content_info == SEEK_CONTENT_INFO)) {
          // Might have first character of the phrase. Copy 16 characters from
	  // pBuffer into a temporary buffer and check for a match to the
	  // phrase.
          {
            int i;
            
	    for (i=0; i<16; i++) {
              compare_buf[i] = *pBuffer;
              pBuffer++;
              nBytes--;
            }
            // At this point we have captured enough characters to check for
            // the "Content-Length: " phrase.
            if (strncmp(compare_buf, "Content-Length: ", 16) == 0) {
              // Found "Content-Length: "
	      i = 0;
	      while (1) {
                // Extract the content length value. The value starts with the
	        // first character following the phrase, and continues until a
	        // ';' or '\r' or '\n' is found.
	        if (*pBuffer == ';' || *pBuffer == '\r' || *pBuffer == '\n') {
		  OctetArray[i] = '\0';
		  break;
		}
		else {
		  OctetArray[i++] = *pBuffer;
		  pBuffer++;
                  nBytes--;
		}
	      }
	      // Convert OctetArray to an integer. This needs to be a 32 bit
	      // integer as the file content could exceed 65536 characters but
	      // will not exceed 99999
	      //
	      // See this URL for an explanation of the use of (uint16_t) and
	      // "U" in the equations below:
	      // https://www.microchip.com/forums/m1126560.aspx
	      // Note: Simple addition and subtraction doesn't see to have this
	      // problem ... appears to be division and multiplication only.
	      // Note: Can't use atoi() ... it seems to have the same problem.

	      file_length =  ((uint16_t)(OctetArray[0] - '0') * 10000U);
	      file_length += ((uint16_t)(OctetArray[1] - '0') * 1000U);
	      file_length += ((uint16_t)(OctetArray[2] - '0') * 100U);
	      file_length += ((uint16_t)(OctetArray[3] - '0') * 10U);
	      file_length += ((uint16_t)(OctetArray[4] - '0') * 1U);
              find_content_info = SEEK_FIRST_RNRN;

// UARTPrintf("\r\n");
// UARTPrintf("Found Content-Length: ");
// UARTPrintf(OctetArray);
// UARTPrintf("  file_length: ");
// emb_itoa(file_length, OctetArray, 10, 5);
// UARTPrintf(OctetArray);
// UARTPrintf("\r\n");

	    }
	  }
        }	

	// The following searches for the \r\n\r\n sequence
	if (pSocket->nNewlines == 2) {
	  // This handles the case where a TCP Fragmentation occured in the
	  // previous packet just as we collected the second \n. In that case
	  // the search does not continue.
	}
	else {
          // We're processing packets but haven't found the \r\n\r\n sequence
          // yet. The sequence detector really just looks for two \n in a row,
          // ignoring the first \r. If any character other than \r appears
	  // between the \n and \n the Newlines counter is zero'd.
          if (*pBuffer == '\n') pSocket->nNewlines++;
          else if (*pBuffer == '\r') { }
          else pSocket->nNewlines = 0;
          pBuffer++;
          nBytes--;
          if (nBytes == 0) {
            // If we hit end of fragment we exit and will come back to the loop
            // with the next fragment.
            return;
          }
        }

        if ((pSocket->nNewlines == 2) && (find_content_info == SEEK_FIRST_RNRN)) {
	  // Need to search for next \r\n\r\n
          pSocket->nNewlines = 0;
	  find_content_info = SEEK_SECOND_RNRN;

// UARTPrintf("\r\n");
// UARTPrintf("find_content_info = SEEK_SECOND_RNRN");
// UARTPrintf("\r\n");

	}
        else if ((pSocket->nNewlines == 2) && (find_content_info == SEEK_SECOND_RNRN)) {
	  // Found second set of \r\n\r\n
	  // Clear nNewlines for future searches
	  pSocket->nNewlines = 0;
	  
	  // We are parsing a data file
	  // The next character in the POST should be the first character of
	  // the payload (in this case, the new program file).
          find_content_info = FOUND_CONTENT_INFO;

// UARTPrintf("\r\n");
// UARTPrintf("find_content_info = FOUND_CONTENT_TYPE FINAL");
// UARTPrintf("\r\n");

	  // Beginning of a data file found.
	  // Initialize parsing variables.
          byte_index = 0;
          parse_index = 0;
          eeprom_address_index = I2C_EEPROM0_BASE;
          parse_tail[0] = '\0';
          byte_tail[0] = '\0';
          byte_tail[1] = '\0';
          line_count = 0;
          checksum = 0;
          upgrade_failcode = UPGRADE_OK;
	  non_sequential_detect = 0;
	  SREC_start = 1;
          search_limit = 0;
	  for (i=0; i<30; i++) {
	    // Initialize the search compare buffer
	    compare_buf[i] = 'z';
	  }
          // Start parsing
          pSocket->nState = STATE_PARSEFILE;
	  pSocket->ParseState = PARSE_FILE_SEEK_START;
          
          // nParseLeft is normally set to the size of the POST data when
	  // parsing user entered values from a Browser GUI. In this case the
	  // data file is much larger than the nParseLeft variable can contain
	  // so nParseLeft is just set to 1 and used as a flag to indicate
	  // receipt of all file data (at which time it is set to 0). This
	  // allows the normal POST processing termination processes to
	  // complete as they do with user POST entries.
	  pSocket->nParseLeft = 1;

// UARTPrintf("\r\n");
// UARTPrintf("Starting STATE_PARSEFILE");
// UARTPrintf("\r\n");

	  if (nBytes == 0) {
	    // If we are at end of fragment here we exit and will return in
	    // STATE_PARSEFILE
	    return;
	  }
          break;
	}
      }
#endif // BUILD_SUPPORT == CODE_UPLOADER_BUILD

    }


    if (pSocket->nState == STATE_GOTGET) {

// UARTPrintf("\r\n");
// UARTPrintf("pSocket->nState == STATE_GOTGET Going to PARSEGET");
// UARTPrintf("\r\n");

      // Don't search for \r\n\r\n ... instead parse what we've got
      // Initialize Parsing variables
      // nParseLeft is used as a flag in GET parsing. nParseLeft == 1 will
      // cause parsing to continue. nParseLeft == 0 will cause parsing to
      // end.
      pSocket->nParseLeft = 1;
      pSocket->ParseState = PARSE_SLASH1;
      // Start parsing
      pSocket->nState = STATE_PARSEGET;
    }


#if BUILD_SUPPORT == BROWSER_ONLY_BUILD || BUILD_SUPPORT == MQTT_BUILD
    if (pSocket->nState == STATE_PARSEPOST) {
      // This code parses data the user entered in the GUI.
      parsepost(pSocket, pBuffer, nBytes);
    }
#endif // BUILD_SUPPORT == BROWSER_ONLY_BUILD || BUILD_SUPPORT == MQTT_BUILD
    

    if (pSocket->nState == STATE_PARSEGET) {

// UARTPrintf("\r\n");
// UARTPrintf("pSocket->nState == STATE_PARSEGET Parsing");
// UARTPrintf("\r\n");

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
      // then I will send the default web page.

      while (nBytes != 0) {
        if (pSocket->ParseState == PARSE_SLASH1) {
	  // When we entered the loop *pBuffer should already be pointing at
	  // the "/". If there isn't one we should display the IOControl page.
          pSocket->ParseCmd = *pBuffer;
          pBuffer++;
	  if (pSocket->ParseCmd == (uint8_t)0x2f) { // Compare to '/'
	    pSocket->ParseState = PARSE_NUM10;
	  }
          else {
            // Didn't find '/' - send default page
#if BUILD_SUPPORT == BROWSER_ONLY_BUILD || BUILD_SUPPORT == MQTT_BUILD

// UARTPrintf("Get slash search1\r\n");

	    pSocket->current_webpage = WEBPAGE_IOCONTROL;
            pSocket->pData = g_HtmlPageIOControl;
            pSocket->nDataLeft = HtmlPageIOControl_size;
            init_off_board_string_pointers(pSocket);
#endif // BUILD_SUPPORT == BROWSER_ONLY_BUILD || BUILD_SUPPORT == MQTT_BUILD
#if BUILD_SUPPORT == CODE_UPLOADER_BUILD
	    pSocket->current_webpage = WEBPAGE_UPLOADER;
            pSocket->pData = g_HtmlPageUploader;
            pSocket->nDataLeft = (uint16_t)(sizeof(g_HtmlPageUploader) - 1);
#endif // BUILD_SUPPORT == CODE_UPLOADER_BUILD
            pSocket->nParseLeft = 0; // Set to 0 so we will go on to STATE_
	                             // SENDHEADER
	  }
        }

        else if (pSocket->ParseState == PARSE_NUM10) {
	  // It's possible we got here because the user did not request a
	  // filename (ie, the user entered "192.168.1.4:8080/". In this case
	  // there will be a space here instead of a digit, and we should just
	  // exit the while() loop and send the default page.
	  if (*pBuffer == ' ') {
#if BUILD_SUPPORT == BROWSER_ONLY_BUILD || BUILD_SUPPORT == MQTT_BUILD

// UARTPrintf("Get slash search2\r\n");

	    pSocket->current_webpage = WEBPAGE_IOCONTROL;
            pSocket->pData = g_HtmlPageIOControl;
            pSocket->nDataLeft = HtmlPageIOControl_size;
            init_off_board_string_pointers(pSocket);
#endif // BUILD_SUPPORT == BROWSER_ONLY_BUILD || BUILD_SUPPORT == MQTT_BUILD
#if BUILD_SUPPORT == CODE_UPLOADER_BUILD
	    pSocket->current_webpage = WEBPAGE_UPLOADER;
            pSocket->pData = g_HtmlPageUploader;
            pSocket->nDataLeft = (uint16_t)(sizeof(g_HtmlPageUploader) - 1);
#endif // BUILD_SUPPORT == CODE_UPLOADER_BUILD
            pSocket->nParseLeft = 0; // Set to 0 so we will go on to STATE_
	                             // SENDHEADER
	  }
	  // Parse first ParseNum digit. Looks like the user did input a
	  // filename digit, so collect it here.
	  else if (isdigit(*pBuffer)) { // Check for user entry error
            // Still good - parse number
            pSocket->ParseNum = (uint8_t)((*pBuffer - '0') * 10);
	    pSocket->ParseState = PARSE_NUM1;
            pSocket->nParseLeft = 1; // Set to 1 so PARSE_NUM1 will be called
            pBuffer++;
	  }
	  else {
	    // Something out of sync or invalid filename - exit while() loop
	    // but do not change the current_webpage
            pSocket->nParseLeft = 0; // Set to 0 so we will go on to STATE_
	                             // SENDHEADER
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
	  }
	  else {
	    // Something out of sync or invalid filename - exit while() loop
	    // but do not change the current_webpage
            pSocket->nParseLeft = 0; // Set to 0 so we will go on to STATE_
	                             // SENDHEADER
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
	  // Note: Only those Output ON/OFF commands that correspond to a pin
	  // configured as an Output will work.
	  //
	  // For 00-31, 55, and 56 you wont see any screen refresh.
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
	  // http://IP/65  Flash LED 3 times (no screen refresh)
	  // http://IP/66  Show Link Error Statistics page
	  // http://IP/67  Clear Link Error Statistics and refresh page
	  // http://IP/68  Show Network Statistics page
	  // http://IP/69  Clear Network Statistics and refresh page
          // http://IP/70  Clear the "Reset Status Register" counters
          // http://IP/71  Display the Temperature Sensor Serial Numbers
          // http://IP/72  Load the Code Uploader (works only in runtime
	  //               builds)
          // http://IP/73  Restore (works only in the Code Uploader build)
          // http://IP/74  Erase EEPROM (works only in the Code Uploader
	  //               build)
          // http://IP/75  Show Code Uploader Timer (works only in the Code
	  //               Uploader build)
	  // http://IP/91  Reboot
	  // http://IP/98  Show Very Short Form IO States page
	  // http://IP/99  Show Short Form IO States page
	  //
          GET_response_type = 200; // Default response type
          switch(pSocket->ParseNum)
	  {
#if BUILD_SUPPORT == BROWSER_ONLY_BUILD || BUILD_SUPPORT == MQTT_BUILD
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
	      GET_response_type = 204; // No return webpage
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
	      GET_response_type = 204; // No return webpage
	      break;

	    case 60: // Show IO Control page

// UARTPrintf("case 60\r\n");

	      pSocket->current_webpage = WEBPAGE_IOCONTROL;
              pSocket->pData = g_HtmlPageIOControl;
              pSocket->nDataLeft = HtmlPageIOControl_size;
              init_off_board_string_pointers(pSocket);
	      break;
	      
	    case 61: // Show Configuration page

// UARTPrintf("case 61\r\n");

	      pSocket->current_webpage = WEBPAGE_CONFIGURATION;
              pSocket->pData = g_HtmlPageConfiguration;
              pSocket->nDataLeft = HtmlPageConfiguration_size;
              init_off_board_string_pointers(pSocket);
	      break;
#endif // BUILD_SUPPORT == BROWSER_ONLY_BUILD || BUILD_SUPPORT == MQTT_BUILD

	    case 65: // Flash LED for diagnostics
	      debugflash();
	      debugflash();
	      debugflash();
	      GET_response_type = 204; // No return webpage
	      break;

#if DEBUG_SUPPORT == 11 || DEBUG_SUPPORT == 15
            case 66: // Show Link Error Statistics page
	      pSocket->current_webpage = WEBPAGE_STATS2;
              pSocket->pData = g_HtmlPageStats2;
              pSocket->nDataLeft = (uint16_t)(sizeof(g_HtmlPageStats2) - 1);
	      break;
	      
            case 67: // Clear Link Error Statistics
	      // Clear the the Link Error Statistics bytes and Stack Overflow
	      debug[2] = (uint8_t)(debug[2] & 0x7f); // Clear the Stack Overflow bit
	      debug[3] = 0; // Clear TXERIF counter
	      debug[4] = 0; // Clear RXERIF counter
	      update_debug_storage1();
	      TRANSMIT_counter = 0;
	      MQTT_resp_tout_counter = 0;
	      MQTT_not_OK_counter = 0;
	      MQTT_broker_dis_counter = 0;
	      
	      pSocket->current_webpage = WEBPAGE_STATS2;
              pSocket->pData = g_HtmlPageStats2;
              pSocket->nDataLeft = (uint16_t)(sizeof(g_HtmlPageStats2) - 1);
	      break;
#endif // DEBUG_SUPPORT

#if UIP_STATISTICS == 1 && BUILD_SUPPORT == BROWSER_ONLY_BUILD
            case 68: // Show Network Statistics page
	      pSocket->current_webpage = WEBPAGE_STATS1;
              pSocket->pData = g_HtmlPageStats1;
              pSocket->nDataLeft = (uint16_t)(sizeof(g_HtmlPageStats1) - 1);
	      break;
	      
            case 69: // Clear Network Statistics and refresh page
	      uip_init_stats();
	      pSocket->current_webpage = WEBPAGE_STATS1;
              pSocket->pData = g_HtmlPageStats1;
              pSocket->nDataLeft = (uint16_t)(sizeof(g_HtmlPageStats1) - 1);
	      break;
#endif // UIP_STATISTICS == 1 && BUILD_SUPPORT == BROWSER_ONLY_BUILD

            case 70: // Clear the "Reset Status Register" counters
	      // Clear the counts for EMCF, SWIMF, ILLOPF, IWDGF, WWDGF
	      // These only display via the UART
	      for (i = 5; i < 10; i++) debug[i] = 0;
	      update_debug_storage1();
	      break;

#if DEBUG_SENSOR_SERIAL == 1
            case 71: // Display the Temperature Sensor Serial Numbers
	      pSocket->current_webpage = WEBPAGE_SENSOR_SERIAL;
              pSocket->pData = g_HtmlPageTmpSerialNum;
              pSocket->nDataLeft = (uint16_t)(sizeof(g_HtmlPageTmpSerialNum) - 1);
	      break;
#endif // DEBUG_SENSOR_SERIAL

#if OB_EEPROM_SUPPORT == 1
#if BUILD_SUPPORT == BROWSER_ONLY_BUILD || BUILD_SUPPORT == MQTT_BUILD
            case 72: // Load Code Uploader
	      // Re-Check that the EEPROM exists, and if it does then load the
	      // Code Uploader from Off-Board EEPROM1, display the Loading
	      // Code Uploader webpage, then reboot.
	      // If the EEPROM does not exist dieplay an error webpage.
	      // Verify that Off-Board EEPROM(s) exist.
              eeprom_detect = off_board_EEPROM_detect();
	      if (eeprom_detect == 0) {
	        pSocket->current_webpage = WEBPAGE_EEPROM_MISSING;
                pSocket->pData = g_HtmlPageEEPROMMissing;
                pSocket->nDataLeft = (uint16_t)(sizeof(g_HtmlPageEEPROMMissing) - 1);
	      }
	      else {
	        pSocket->current_webpage = WEBPAGE_LOADUPLOADER;
                pSocket->pData = g_HtmlPageLoadUploader;
                pSocket->nDataLeft = (uint16_t)(sizeof(g_HtmlPageLoadUploader) - 1);
                eeprom_copy_to_flash_request = I2C_COPY_EEPROM1_REQUEST;
	      }
	      break;
#endif // BUILD_SUPPORT == BROWSER_ONLY_BUILD || BUILD_SUPPORT == MQTT_BUILD
	      
#if BUILD_SUPPORT == CODE_UPLOADER_BUILD
            case 73: // Reload firmware existing image
	      // Load the existing firmware image from Off-Board EEPROM0,
	      // display the Loading Existing Image webpage, then reboot.
	      pSocket->current_webpage = WEBPAGE_EXISTING_IMAGE;
              pSocket->pData = g_HtmlPageExistingImage;
              pSocket->nDataLeft = (uint16_t)(sizeof(g_HtmlPageExistingImage) - 1);
              eeprom_copy_to_flash_request = I2C_COPY_EEPROM0_REQUEST;
	      upgrade_failcode = UPGRADE_OK;
	      break;
	      
            case 74: // Erase entire Off-Board EEPROM
              // Erase EEPROM regions 0, 1, 2, and 3 to provide a clean slate.
	      // Useful mostly during development for code debug.
	      {
	        uint16_t i;
	        uint8_t j;
	        int k;
	        uint16_t temp_eeprom_address_index;
	        for (k=0; k<4; k++) {
	          for (i=0; i<256; i++) {
	            // Write 256 blocks of 128 bytes each with zero
		    if (k == 0) I2C_control(I2C_EEPROM0_WRITE);
		    if (k == 1) I2C_control(I2C_EEPROM1_WRITE);
		    if (k == 2) I2C_control(I2C_EEPROM2_WRITE);
		    if (k == 3) I2C_control(I2C_EEPROM3_WRITE);
	            temp_eeprom_address_index = i * 128;
                    I2C_byte_address(temp_eeprom_address_index);
	            for (j=0; j<128; j++) {
	              // Write a zero byte
	              I2C_write_byte(0);
	            }
                    I2C_stop(); // Start the EEPROM internal write cycle
                    IWDG_KR = 0xaa; // Prevent the IWDG from firing.
                    wait_timer(5000); // Wait 5ms
	          }
                }
	      }
              break;
#endif // BUILD_SUPPORT == CODE_UPLOADER_BUILD
#endif // OB_EEPROM_SUPPORT == 1

	    case 91: // Reboot
	      user_reboot_request = 1;
	      break;

#if BUILD_SUPPORT == BROWSER_ONLY_BUILD || BUILD_SUPPORT == MQTT_BUILD
            case 98: // Show Very Short Form IO state page
            case 99: // Show Short Form IO state page
	      // Normally when a page is transmitted the "current_webpage" is
	      // updated to reflect the page just transmitted. This is not
	      // done for this case as the page is very short (only requires
	      // one packet to send) and not changing the current_webpage
	      // pointer prevents "page interference" between normal browser
	      // activity and the automated functions that normally use this
	      // page.
	      pSocket->current_webpage = WEBPAGE_SSTATE;
              pSocket->pData = g_HtmlPageSstate;
              pSocket->nDataLeft = (uint16_t)(sizeof(g_HtmlPageSstate) - 1);
	      break;
#endif // BUILD_SUPPORT == BROWSER_ONLY_BUILD || BUILD_SUPPORT == MQTT_BUILD

	    default:
	      if (pSocket->ParseNum < 32) {
                // Output-01..16 OFF/ON
#if BUILD_SUPPORT == BROWSER_ONLY_BUILD || BUILD_SUPPORT == MQTT_BUILD
                update_ON_OFF((uint8_t)(pSocket->ParseNum/2), (uint8_t)(pSocket->ParseNum%2));
	        GET_response_type = 204; // No return webpage
#endif // BUILD_SUPPORT == BROWSER_ONLY_BUILD || BUILD_SUPPORT == MQTT_BUILD
              }
              else {
	        // Show default page
#if BUILD_SUPPORT == BROWSER_ONLY_BUILD || BUILD_SUPPORT == MQTT_BUILD
	        pSocket->current_webpage = WEBPAGE_IOCONTROL;
                pSocket->pData = g_HtmlPageIOControl;
                pSocket->nDataLeft = HtmlPageIOControl_size;
                init_off_board_string_pointers(pSocket);
#endif // BUILD_SUPPORT == BROWSER_ONLY_BUILD || BUILD_SUPPORT == MQTT_BUILD
#if BUILD_SUPPORT == CODE_UPLOADER_BUILD
	        pSocket->current_webpage = WEBPAGE_UPLOADER;
                pSocket->pData = g_HtmlPageUploader;
                pSocket->nDataLeft = (uint16_t)(sizeof(g_HtmlPageUploader) - 1);
#endif // BUILD_SUPPORT == CODE_UPLOADER_BUILD
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
          pSocket->nPrevBytes = 0xFFFF;
          pSocket->nState = STATE_SENDHEADER200;
	  break;
	}

        if (pSocket->nParseLeft == 0) {
          // Finished parsing ... even if nBytes is not zero
	  // Send the response
          pSocket->nPrevBytes = 0xFFFF;
          if (GET_response_type == 200) {
	    // Update GUI with appropriate webpage
            pSocket->nState = STATE_SENDHEADER200;
	  }
          if (GET_response_type == 204) {
	    // No return webpage - send header with Content-Length: 0
            pSocket->nState = STATE_SENDHEADER204;
	  }
          break;
        }
      } // end of while loop
    }



    
#if BUILD_SUPPORT == CODE_UPLOADER_BUILD
    if (pSocket->nState == STATE_PARSEFILE) {

// UARTPrintf("\r\n");
// UARTPrintf("pSocket->nState == STATE_PARSEFILE Parsing");
// UARTPrintf("\r\n");

      // This step is entered if a POST containing a firmware file was
      // detected. The file contents will be copied to the Off-Board EEPROM,
      // then the Off-B0ard EEPROM will be copied to the internal Flash, then
      // the device will reboot.
      //
      // Some notes:
      // - This application normally parses POST files providing user data
      //   entries in a Browser session. As such, the size of the data is
      //   easily less than 65536 characters, thus the nParseLeft variable
      //   used in normal parsing is a uint16_t type.
      // - When a SREC file is attached to a POST the datagram can be 1024
      //   lines x 78 bytes = 79872 characters PLUS some other overhead like
      //   S0 and S7 records, and some miscellaneous records (partial data,
      //   0x4000 addresses, etc).
      //   So nParseLeft cannot be used in receiving the SREC
      //   file other than as a flag to indicate that parsing is complete.
      //   Instead the SREC file parser searches for a SREC S7 record to find
      //   the end of the data then sets nParseLeft to signal that the end of
      //   data was reached.
      // - If an invalid file is supplied (ie, not an SREC file) it is detect-
      //   ed by not finding an "S0" as the first two characters of the file.
      //   In that case a loop is entered to allow the entire file to be sent
      //   by the browser, but an upgrade_failcode is set to notify the user
      //   of the error.
      // - If an invalid SREC file is provided ... well, can't help the user
      //   with every possible fart. The invalid SREC file will likely be
      //   loaded into Flash and reprogramming via the SWIM interface may be
      //   necessary.

// UARTPrintf("\r\n");
// UARTPrintf("Parsing data file\r\n");

// UARTPrintf(" byte_index = ");
// emb_itoa(byte_index, OctetArray, 10, 3);
// UARTPrintf(OctetArray);
// UARTPrintf("\r\n");

// UARTPrintf(" parse_index = ");
// emb_itoa(parse_index, OctetArray, 10, 3);
// UARTPrintf(OctetArray);
// UARTPrintf("\r\n");

// UARTPrintf(" eeprom_address_index = ");
// emb_itoa(eeprom_address_index, OctetArray, 16, 4);
// UARTPrintf(OctetArray);
// UARTPrintf("\r\n");

// UARTPrintf(" ParseState = ");
// emb_itoa(pSocket->ParseState, OctetArray, 10, 3);
// UARTPrintf(OctetArray);
// UARTPrintf("\r\n");

// UARTPrintf("***NEWPACKET***");


      // nBytes is tracked in this function using the global file_nBytes to
      // enable shared use of the nBytes value in this function and the
      // read_two_characters function.
      file_nBytes = nBytes;

      // This function uses a step by step state machine to read the data file

      // When first starting the data file read keep in mind that even though
      // the data part of the packet is just starting, a packet boundary can
      // occur anywhere. However, we know that there will be at least one byte
      // left in the current packet when we start.


      if (pSocket->ParseState == PARSE_FILE_SEEK_START) {

        // The first thing we need to do is find the start of the actual SREC
        // file. In order to do this we need to find the end of the "multi-
	// part boundary".
        // Since only one SREC file is included in an update file the multi-
	// part boundary immediately follows the second \r\n\r\n sequence.
	// This is an example of the boundary text that will precede the first
	// characters of the SREC data:
        //
        // -----------------------------168888385127375703662499690451
        // Content-Disposition: form-data; name="file1"; filename="NetworkModule.sx"
        // Content-Type: application/octet-stream
        //
        // So, we need to find the start of the SREC data by finding the end
	// of the phrase "Type: application/octet-stream".
        // Since a user might provide an invalid file we should also determine
        // a reasonable point to give up looking for the phrase. Counting up
	// the above and adding a little buffer for file name differences, we
	// should find the end of the phrase within 200 characters of starting
	// the search. If we don't it can be assumed this is not an SREC file.

        while (1) {
	  // Search for the "Type: application/octet-stream" phrase.
	  // Since we can hit a packet boundary at any time we must check for
	  // file_nBytes == 0 and break away to allow the next packet to be
	  // read.
	  // This search works by reading one character at a time from the
	  // pBuffer and placing it in a left shift register. The register
	  // shifts left one character each time a new character would exceed
	  // the length of the register. The register is then compared with
	  // the search phrase.
	  
	  for (i=0; i<29; i++) {
	    // Shift the register contents left
	    compare_buf[i] = compare_buf[i+1];
	  }
// UARTPrintf("compare_buf: ");
// UARTPrintf(compare_buf);
// UARTPrintf("\r\n");
	  // Add a new character to the end of the register
	  compare_buf[29] = *pBuffer;
	  pBuffer++;
	  file_nBytes--;
	  file_length--;
	  search_limit++;
	  
          if (strncmp(compare_buf, "Type: application/octet-stream", 30) == 0) {
            // Found "Type: application/octet-stream"
	    // The next character starts the SREC content
            pSocket->ParseState = PARSE_FILE_SEEK_SX;
// UARTPrintf("Found octet-stream\r\n");


// Diagnostic - Print the characters that follow "octet-stream"
// UARTPrintf("Characters following octet-stream: ");
// for (i=0; i<30; i++) {
// compare_buf[0] = *pBuffer;
// pBuffer++;
// compare_buf[1] = '\0';
// UARTPrintf(compare_buf);
// }
// UARTPrintf("\r\n");


	    break; // Break out of the local while loop
	  }
	      
          if (search_limit >= 200) {
            // Should have found the phrase by now. Assume this is not a valid
	    // SREC file. Break out of the loop and go to PARSE_FILE_FAIL
	    // The next character starts the SREC content
// UARTPrintf("Exceeded search limit\r\n");
            pSocket->ParseState = PARSE_FILE_FAIL;
	    break; // Break out of the local while loop
	  }
	  
          if (file_nBytes == 0) {
            // We just read the last character in this packet. Break out
            // of the local while loop so the next packet will be read.
            break; // Break out of the local while loop
          }
        } // End of local while loop
      }

      if (pSocket->ParseState != PARSE_FILE_SEEK_START) {
        while (1) {
          // This while() loop is a state machine with three main
	  // "pSocket->ParseState" states:
	  // PARSE_FILE_SEEK_SX
	  //   Parses the leading characters of each SREC looking for the SREC
	  //   type.
	  //     If the SREC type is S0 we are starting receipt of an SREC file
	  //     so the 32K EEPROM0 space is erased to make it available to
	  //     store the parsed SREC content. This SREC must be read to deter-
	  //     mine the "file_type", ie, is it a PROGRAM file or a STRING
	  //     file.
	  //     If the SREC type is S3 we are starting receipt of an SREC data
	  //     line. The "address" contained within the data line is parsed
	  //     then the state machine goes to state PARSE_FILE_SEQUENTIAL or
	  //     state PARSE_FILE_NONSEQ as needed.
	  //     If the SREC type is S7 we are at the last record in the SREC
	  //     file.
	  // PARSE_FILE_SEQUENTIAL
	  //   Parses "sequential" SREC date, ie, the first data record and any
	  //   subsequent data record that has an address that is sequential
	  //   with the previous data record.
	  // PARSE_FILE_NONSEQ
	  //   Parses "non-sequential" SREC data, ie, any data record that has
	  //   an address that is not seqeuntial relative to the previous data
	  //   record.
	  // Exit at end of packet (file_nBytes == 0). This can occur at any
	  // point while reading data. The exit allows the uip functions to
	  // receive the next ethernet packet, then the STATE_PARSEFILE code
	  // will be re-entered to continue this state machine where we left
	  // off. Re-entry is made possible because "pSocket->nState" and
	  // "pSocket->ParseState" are both saved so that we know where we
	  // were when a packet ended (a TCP Fragmentation).
          
          if (pSocket->ParseState == PARSE_FILE_SEEK_SX) {

// UARTPrintf(" ParseState = PARSE_FILE_SEEK_SX\r\n");

	    // This parse looks for the start of record and will parse the
	    // address value for the record.
	    while (1) {
              // Try to read two characters from the SREC
              pBuffer = read_two_characters(pBuffer);
              if (byte_tail[0] == '\0') {
	        // No characters were found. This can occur when an end of
	        // packet occurs during a CRLF sequence. The read attempt will
	        // have set file_nBytes to zero. Break out of the local while
	        // loop so that the next packet will be read.
	        break;
	      }
              if (byte_tail[1] == '\0') {
                // We only found 1 character so we just read the last character
	        // in this packet. The read_two_characters() function will have
	        // set file_nBytes to zero. Break out of the local while loop so
	        // the next packet will be read.
                break;
              }

// {
// uint8_t temp[3];
// temp[0] = byte_tail[0];
// temp[1] = byte_tail[1];
// temp[2] = '\0';
// UARTPrintf(temp);
// }
            
	      // If we didn't break out then we successfully read two charac-
	      // ters.
	      
	      // If this is the start of the SREC parsing the file MUST begin
	      // with "S0" ... otherwise we must assume this is not an SREC file
	      // and we will abort the parsing.
	      if (SREC_start == 1) {
	        if (strncmp(byte_tail, "S0", 2) != 0) {
	          // This does not appear to be an SREC file. Abort.
                  upgrade_failcode = UPGRADE_FAIL_NOT_SREC;
	      
// UARTPrintf("UPGRADE_FAILCODE = UPGRADE_FAIL_NOT_SREC\r\n");

                  pSocket->ParseState = PARSE_FILE_FAIL;
		  break;
	        }
	        else SREC_start = 0;
	      }
	      
	      // "byte_index" is used to track progress in dissecting the
	      // incoming SREC.
	      
	      if (byte_index == 0) {
	        if (strncmp(byte_tail, "S0", 2) == 0) {
                  // Check if the two characters are "S0", indicating the start
		  // of a SREC file.

// UARTPrintf("Found S0\r\n");

                  // Erase EEPROM0 to provide a clean space to store the incom-
		  // ing SREC data.
		  
		  {
		    uint16_t i;
		    uint8_t j;
		    uint16_t temp_eeprom_address_index;
// UARTPrintf("\r\nEEPROM0 erase at temp_eeprom_address_index ");
		    for (i=0; i<256; i++) {
		      // Write 256 blocks of 128 bytes each with zero
                      I2C_control(I2C_EEPROM0_WRITE); // Send Write Control Byte
		      temp_eeprom_address_index = i * 128;
                      I2C_byte_address(temp_eeprom_address_index);
		      for (j=0; j<128; j++) {
		        // Write a zero byte
		        I2C_write_byte(0);
		      }
                      I2C_stop(); // Start the EEPROM internal write cycle
                      IWDG_KR = 0xaa; // Prevent the IWDG from firing.
// emb_itoa(temp_eeprom_address_index, OctetArray, 16, 4);
// UARTPrintf(OctetArray);
// UARTPrintf(" ");
                      // Wait for completion of write.
		      // For simplicity I'm waiting 5ms (the max time required).
		      // This loop could be sped up by using "acknowledge
		      // polling" (see the 24AA1025 EEPROM spec).
                      wait_timer(5000); // Wait 5ms
                    }
// UARTPrintf("\r\n");
		  }
		  // Now go on to determining what kind of file was sent
		  file_type = FILETYPE_SEARCH;
	          byte_index = 2;
                  // Clear byte_tail for subsequent reads
                  byte_tail[0] = '\0';
                  byte_tail[1] = '\0';
	          // Continue to read the address value in this SREC
	          continue;
	        }
	        else if (strncmp(byte_tail, "S3", 2) == 0) {
                  // Check if the two characters are "S3", indicating the start
		  // of a new SREC data line.

// UARTPrintf("Found S3\r\n");

	          byte_index = 2;
                  // Clear byte_tail for subsequent reads
                  byte_tail[0] = '\0';
                  byte_tail[1] = '\0';
	          // Continue to read the address value in this SREC
	          continue;
	        }
	        else if (strncmp(byte_tail, "S7", 2) == 0) {
// UARTPrintf("Found S7\r\n");
                  // Check if the two characters are "S7", indicating the end of
		  // data.
		 
		  if (parse_index != 0) {
		    // If any data remains in parse_tail write it to the EEPROM.
                    {
                      int i;
                      uint8_t I2C_last_flag;
                      uint8_t temp_byte;
                      
		      // Send Write Control Byte
	              if (file_type == FILETYPE_PROGRAM) {
                        I2C_control(I2C_EEPROM0_WRITE);
		      }
	              if (file_type == FILETYPE_STRING) {
                        I2C_control(I2C_EEPROM2_WRITE);
// UARTPrintf("\r\nEEPROM2 write at eeprom_address_index ");
		      }
                      I2C_byte_address(eeprom_address_index);
// UARTPrintf("\r\nEEPROM write at eeprom_address_index ");
// emb_itoa(eeprom_address_index, OctetArray, 16, 4);
// UARTPrintf(OctetArray);
// UARTPrintf(": \r\n");
                      for (i=0; i<64; i++) {
		        I2C_write_byte(parse_tail[i]);
// emb_itoa(parse_tail[i], OctetArray, 16, 2);
// UARTPrintf(" ");
// UARTPrintf(OctetArray);
		      }
                      I2C_stop();
                      wait_timer(5000); // Wait 5ms
                      IWDG_KR = 0xaa; // Prevent the IWDG from firing.
                      // Validate data in Off-Board EEPROM
	              if (file_type == FILETYPE_PROGRAM) {
                        prep_read(I2C_EEPROM0_WRITE, I2C_EEPROM0_READ, eeprom_address_index);
                      }
	              if (file_type == FILETYPE_STRING) {
                        prep_read(I2C_EEPROM2_WRITE, I2C_EEPROM2_READ, eeprom_address_index);
                      }
	              I2C_last_flag = 0;
                      for (i=0; i<64; i++) {
                        if (i == 63) I2C_last_flag = 1;
                        temp_byte = I2C_read_byte(I2C_last_flag);
                        if (temp_byte != parse_tail[i]) {
                          upgrade_failcode = UPGRADE_FAIL_EEPROM_MISCOMPARE;
// UARTPrintf("UPGRADE_FAILCODE = UPGRADE_FAIL_EEPROM_MISCOMPARE\r\n");
                          pSocket->ParseState = PARSE_FILE_FAIL;
                        }
                      }
                    }
		  }
		  
		  // At this point all data is processed. Go on to the
		  // PARSE_FILE_COMPLETE code.
 
	          pSocket->ParseState = PARSE_FILE_COMPLETE;
		  
		  continue; // Continue reading characters until end of file
	        }
	        else {
	          // Throw away characters and continue search
                  // Clear byte_tail for subsequent reads
                  byte_tail[0] = '\0';
                  byte_tail[1] = '\0';
		  continue;
                } 
	      }
	    
	      if (byte_index == 2) {
	        // Read the data count value

// UARTPrintf("byte_index == 2  ");

                data_count = two_hex2int(byte_tail[0], byte_tail[1]);
	        // Start checksum
	        checksum = data_count;
	        byte_index = 4;
                // Clear byte_tail for subsequent reads
                byte_tail[0] = '\0';
                byte_tail[1] = '\0';
	        continue;
	      }
	    
	      if (byte_index == 4) {
	        // Ignore first byte of address value

// UARTPrintf("byte_index == 4  ");

	        data_count--;
	        // Add to checksum. Value is always 00
	        checksum += 0;
	        byte_index = 6;
                // Clear byte_tail for subsequent reads
                byte_tail[0] = '\0';
                byte_tail[1] = '\0';
	        continue;
	      }
	    
	      if (byte_index == 6) {
	        // Ignore the second byte of address value

// UARTPrintf("byte_index == 6  ");

	        data_count--;
	        // Add to checksum. Value is always 00
	        checksum += 0;
	        byte_index = 8;
                // Clear byte_tail for subsequent reads
                byte_tail[0] = '\0';
                byte_tail[1] = '\0';
	        continue;
	      }
	    
	      if (byte_index == 8 && file_type != FILETYPE_SEARCH) {
	        // Capture the high order byte of the address value

// UARTPrintf("byte_index == 8  ");

                temp_address = two_hex2int(byte_tail[0], byte_tail[1]);
	        data_count--;
	        checksum += (uint8_t)temp_address;
	        temp_address = temp_address << 8;
	        byte_index = 10;
                // Clear byte_tail for subsequent reads
                byte_tail[0] = '\0';
                byte_tail[1] = '\0';
	        continue;
	      }
	    
	      if (byte_index == 8 && file_type == FILETYPE_SEARCH) {
	        // Determine file_type

// UARTPrintf("byte_index == 8\r\n");

	        data_count--;
	        // Capture the first byte of the file type
	        // 'N' (0x4E) is a NetworkModule program file
	        // 'S' (0x53) is a String File
                if (two_hex2int(byte_tail[0], byte_tail[1]) == 0x4E) {
	          file_type = FILETYPE_PROGRAM;

// UARTPrintf("file_type = FILETYPE_PROGRAM\r\n");
	      
	        }
	        else {
	          file_type = FILETYPE_STRING;

// UARTPrintf("file_type = FILETYPE_STRING\r\n");
	      
                }
	        // Reset byte_index and byte_tail
	        byte_index = 0;
                byte_tail[0] = '\0';
                byte_tail[1] = '\0';
	        // Break out of while loop so that next SREC will be read
                break;
	      }
	    
	      if (byte_index == 10) {
	        // Capture the low order byte of the address value

// UARTPrintf("byte_index == 10\r\n");

                temp_address_low = two_hex2int(byte_tail[0], byte_tail[1]);
	        data_count--;
	        checksum += (uint8_t)temp_address_low;
	        temp_address |= temp_address_low;
	      
	        if ((temp_address < 0x8000) || (temp_address > (FLASH_START_USER_RESERVE - 1))) {
// UARTPrintf("\r\nDiscard ");
// UARTPrintf("temp_address = ");
// emb_itoa(temp_address, OctetArray, 16, 4);
// UARTPrintf(OctetArray);
// UARTPrintf("\r\n");
	          // If the address is not in the range 0x8000 to
	          // FLASH_START_USER_DATA_RESERVE we ignore the SREC and
		  // stay in ParseState PARSE_FILE_SEEK_SX to search for the
 		  // next SREC.
	          byte_index = 0;
                  // Clear byte_tail for subsequent reads
                  byte_tail[0] = '\0';
                  byte_tail[1] = '\0';
	          break;
	        }
	        else {
	          // Else we start processing the SREC
                  new_address = temp_address;
// UARTPrintf("\r\nnew_address = ");
// emb_itoa(new_address, OctetArray, 16, 4);
// UARTPrintf(OctetArray);
// UARTPrintf("\r\n");
	        }
	      
	        if (new_address == 0x8000) {
	          // If this is the start of the firmware image set address and
	          // parse the first SREC in the image
	          address = 0x8000;
                  pSocket->ParseState = PARSE_FILE_SEQUENTIAL;
                  // Clear byte_tail for subsequent reads
                  byte_tail[0] = '\0';
                  byte_tail[1] = '\0';
                  break;
	        }
	      
	        if (new_address > 0x8000) {
	          // Handle valid addresses beyond the starting address
	          if (new_address == address) {
	            // While reading the SREC "address" should have incremented
		    // up to equal the "new_address". If so then continue read-
		    // ing data
                    pSocket->ParseState = PARSE_FILE_SEQUENTIAL;
                    // Clear byte_tail for subsequent reads
                    byte_tail[0] = '\0';
                    byte_tail[1] = '\0';
	            break;
	          }
		  
		  else {
		    // This is a case where the "new_address" is not sequential
		    // with the prevous data read.
		    // In this case we need to finish writing data we were col-
		    // lecting, then we need to use the PARSE_FILE_NONSEQ code
		    // to begin collection of data at the new_address.
		    //   If the new_address is in space already written to the
		    //   EEPROM an over-write of the EEPROM content will occur.
		    //   If the new_address is in space futher out in the EEPROM
		    //   the EEPROM writes will begin at that new_address.
		    // 


// UARTPrintf("\r\nFound data line with non-sequential address: parse_index = ");
// emb_itoa(parse_index, OctetArray, 16, 2);
// UARTPrintf(OctetArray);

		    if (parse_index != 0) {
		      // If we were in the middle of writing a 64 byte block to
		      // EEPROM we need to finish that. Write the 64 bytes of
		      // data that are in the parse_tail array into the Off-
		      // Board EEPROM.
                      {
                        int i;
                        uint8_t I2C_last_flag;
                        uint8_t temp_byte;
			
                        // Send Write Control Byte
	                if (file_type == FILETYPE_PROGRAM) {
                          I2C_control(I2C_EEPROM0_WRITE);
			}
	                if (file_type == FILETYPE_STRING) {
                          I2C_control(I2C_EEPROM2_WRITE);
// UARTPrintf("\r\nEEPROM2 write at eeprom_address_index ");
			}
			
		        // At this point the eeprom_address_index will be point-
		        // ing at the start of the 64 byte EEPROM block that was
		        // being processed when the out-of-sequence address was
		        // encountereed.
                        I2C_byte_address(eeprom_address_index);
// UARTPrintf("\r\nEEPROM write at eeprom_address_index ");
// emb_itoa(eeprom_address_index, OctetArray, 16, 4);
// UARTPrintf(OctetArray);
// UARTPrintf(": \r\n");
                        for (i=0; i<64; i++) {
		          I2C_write_byte(parse_tail[i]);
// emb_itoa(parse_tail[i], OctetArray, 16, 2);
// UARTPrintf(" ");
// UARTPrintf(OctetArray);
		        }
                        I2C_stop();
                        wait_timer(5000); // Wait 5ms
                        IWDG_KR = 0xaa; // Prevent the IWDG from firing.
			
                        // Validate data in Off-Board EEPROM
	                if (file_type == FILETYPE_PROGRAM) {
                          prep_read(I2C_EEPROM0_WRITE, I2C_EEPROM0_READ, eeprom_address_index);
			}
	                if (file_type == FILETYPE_STRING) {
                          prep_read(I2C_EEPROM2_WRITE, I2C_EEPROM2_READ, eeprom_address_index);
			}
			
	                I2C_last_flag = 0;
                        for (i=0; i<64; i++) {
                          if (i == 63) I2C_last_flag = 1;
                          temp_byte = I2C_read_byte(I2C_last_flag);
                           if (temp_byte != parse_tail[i]) {
                             upgrade_failcode = UPGRADE_FAIL_EEPROM_MISCOMPARE;
// UARTPrintf("UPGRADE_FAILCODE = UPGRADE_FAIL_EEPROM_MISCOMPARE\r\n");
                             pSocket->ParseState = PARSE_FILE_FAIL;
                          }
                        }
                      }
		    }
		  
		    // Go to the non-sequential data processing
                    pSocket->ParseState = PARSE_FILE_NONSEQ;
                    // Clear byte_tail for subsequent reads
                    byte_tail[0] = '\0';
                    byte_tail[1] = '\0';
		    
		    // Set "address" to be equal to "new_address"
		    address = new_address;
		    
		    // Indicate initial detection of the non-sequential data.
		    // This is used to allow the processing to be re-entrant
		    // should TCP Fragmentation occur.
		    non_sequential_detect = 1;
		    
	            break;
		  }
	        }
	      }
	    
              if (file_nBytes == 0) {
                // We just read the last character in this packet. Break out
                // of the local while loop so the next packet will be read.
                break;
              }
	    } // End of local while() loop
	  }


          if (pSocket->ParseState == PARSE_FILE_SEQUENTIAL) {
// UARTPrintf(" ParseState = PARSE_FILE_SEQUENTIAL\r\n");
	    // This parse is entered knowing that the next two characters are a
	    // data byte.
	    while (1) {
              // Read two characters from the SREC
              pBuffer = read_two_characters(pBuffer);
              if (byte_tail[0] == '\0') {
	        // No characters were found. This can occur when an end of
	        // packet occurs during a CRLF sequence. The read attempt will
	        // have set file_nBytes to zero. Break out of the local while
	        // loop so that the next packet will be read.
	        break;
	      }
              if (byte_tail[1] == '\0') {
                // We only found 1 character so we just read the last character
	        // in this packet. The read_two_characters() function will have
	        // set file_nBytes to zero. Break out of the local while loop so
	        // the next packet will be read.
                break;
              }

// {
// uint8_t temp[3];
// temp[0] = byte_tail[0];
// temp[1] = byte_tail[1];
// temp[2] = '\0';
// UARTPrintf(temp);
// }
	    
	      // If we didn't break out then we successfully read two characters
              data_value = two_hex2int(byte_tail[0], byte_tail[1]);
              checksum += data_value;
              data_count--;
              // Clear byte_tail for subsequent reads
              byte_tail[0] = '\0';
              byte_tail[1] = '\0';
	      
	      if (data_count > 0) {
	        // Copy data to parse_tail
	        parse_tail[parse_index++] = data_value;
	        address++; // Increment the incoming address counter
	      }
	      
	      if (data_count == 0) {
// UARTPrintf("data_count 0\r\n");
	        // We just read the last byte in this SREC. The byte just read
	        // was the checksum. Check for validity.
	        if (checksum != 0xff) {
	          // Handle Checksum Error
                  upgrade_failcode = UPGRADE_FAIL_FILE_READ_CHECKSUM;

// UARTPrintf("checksum = ");
// emb_itoa(checksum, OctetArray, 16, 4);
// UARTPrintf(OctetArray);
// UARTPrintf("\r\n");
	      
// UARTPrintf("UPGRADE_FAILCODE = UPGRADE_FAIL_FILE_READ_CHECKSUM\r\n");
                  pSocket->ParseState = PARSE_FILE_FAIL;
		  break;
	        }
	      }
	    
	      if (parse_index == 64 && file_type == FILETYPE_PROGRAM) {
// UARTPrintf("parse_index 64\r\n");
	        // Copy parse_tail to Off-Board EEPROM0
	        
                // Write the 64 bytes of data that are in the parse_tail array
                // into the Off-Board EEPROM.
                {
                  int i;
                  uint8_t I2C_last_flag;
                  uint8_t temp_byte;
                  
                  I2C_control(I2C_EEPROM0_WRITE); // Send Write Control Byte
                  I2C_byte_address(eeprom_address_index);
// UARTPrintf("\r\nEEPROM0 write at eeprom_address_index ");
// emb_itoa(eeprom_address_index, OctetArray, 16, 4);
// UARTPrintf(OctetArray);
// UARTPrintf(": \r\n");
                  for (i=0; i<64; i++) {
                    I2C_write_byte(parse_tail[i]);
// emb_itoa(parse_tail[i], OctetArray, 16, 2);
// UARTPrintf(" ");
// UARTPrintf(OctetArray);
                  }
                  I2C_stop();
                  wait_timer(5000); // Wait 5ms
                  IWDG_KR = 0xaa; // Prevent the IWDG from firing.
                  // Validate data in Off-Board EEPROM
                  prep_read(I2C_EEPROM0_WRITE, I2C_EEPROM0_READ, eeprom_address_index);
	          I2C_last_flag = 0;
// UARTPrintf("\r\nEEPROM contents: \r\n");
                  for (i=0; i<64; i++) {
                    if (i == 63) I2C_last_flag = 1;
                    temp_byte = I2C_read_byte(I2C_last_flag);
// emb_itoa(temp_byte, OctetArray, 16, 2);
// UARTPrintf(" ");
// UARTPrintf(OctetArray);
                    if (temp_byte != parse_tail[i]) {
                      upgrade_failcode = UPGRADE_FAIL_EEPROM_MISCOMPARE;
// UARTPrintf("UPGRADE_FAILCODE = UPGRADE_FAIL_EEPROM_MISCOMPARE\r\n");
                      pSocket->ParseState = PARSE_FILE_FAIL;
                    }
                  }
                  eeprom_address_index += 64;
                }
              }
	    
	      if (parse_index == 64 && file_type == FILETYPE_STRING) {
	        // Copy parse_tail to Off-Board EEPROM2
	        
                // Write the 64 bytes of data that are in the parse_tail array
                // into the Off-Board EEPROM.
                {
                  int i;
                  uint8_t I2C_last_flag;
                  uint8_t temp_byte;
                  
                  I2C_control(I2C_EEPROM2_WRITE); // Send Write Control Byte
                  I2C_byte_address(eeprom_address_index);
// UARTPrintf("\r\nEEPROM2 write at eeprom_address_index ");
// emb_itoa(eeprom_address_index, OctetArray, 16, 4);
// UARTPrintf(OctetArray);
// UARTPrintf(": \r\n");
                  for (i=0; i<64; i++) {
                    I2C_write_byte(parse_tail[i]);
// emb_itoa(parse_tail[i], OctetArray, 16, 2);
// UARTPrintf(" ");
// UARTPrintf(OctetArray);
                  }
                  I2C_stop();
                  wait_timer(5000); // Wait 5ms
                  IWDG_KR = 0xaa; // Prevent the IWDG from firing.
                  // Validate data in Off-Board EEPROM
                  prep_read(I2C_EEPROM2_WRITE, I2C_EEPROM2_READ, eeprom_address_index);
	          I2C_last_flag = 0;
// UARTPrintf("\r\nEEPROM contents: \r\n");
                  for (i=0; i<64; i++) {
                    if (i == 63) I2C_last_flag = 1;
                    temp_byte = I2C_read_byte(I2C_last_flag);
// emb_itoa(temp_byte, OctetArray, 16, 2);
// UARTPrintf(" ");
// UARTPrintf(OctetArray);
                    if (temp_byte != parse_tail[i]) {
                      upgrade_failcode = STRING_EEPROM_MISCOMPARE;
// UARTPrintf("UPGRADE_FAILCODE = STRING_EEPROM_MISCOMPARE\r\n");
                      pSocket->ParseState = PARSE_FILE_FAIL;
                    }
                  }
                  eeprom_address_index += 64;
                }
	      }

	      if (parse_index == 64) {
// UARTPrintf("parse_index64 clear for next data\r\n");
	        // This is just a cleanup routine to make debug easier. This
	        // will zero out the parse_tail array so that subsequent writes
	        // to parse tail that end before filling it will be followed by
	        // zeroes.
	        for (i=0; i<64; i++) parse_tail[i] = 0;
	        parse_index = 0; // Clear for next data
	      }
	      
	      if (data_count == 0) {
                // Go on to read next SREC
                byte_index = 0;
                pSocket->ParseState = PARSE_FILE_SEEK_SX;
                break;
	      }
	    
              if (file_nBytes == 0) {
                // We just read the last character in this packet. Break out
                // of the local while loop so the next packet will be read.
                break;
              }
	    } // End of local while() loop
	  }


          if (pSocket->ParseState == PARSE_FILE_NONSEQ) {
// UARTPrintf(" ParseState = PARSE_FILE_NONSEQ\r\n");
            // This is a case where the new_address is not sequential with the
	    // previous adddress.
	    //
	    // If this occurs then only the data in the SREC is copied to the
	    // EEPROM, but it requires reading the existing data from the EEPROM
	    // then inserting the new SREC data into the existing EEPROM data.
	    //
            // The "address" and "eeprom_address_index" values will be updated
	    // according to the addressing values needed by this special case,
	    // causing all new SREC addresses to be treated as non-sequential
	    // until they start becoming sequential again.
	    //
	    // WHAT IF THE NON-SEQUENTIAL DATA OCCUPIES MORE THAN ONE SREC?
	    // If the additional SRECs are sequential relative to the first non-
	    // sequential address encountered they will be handled by the seq-
	    // uential data processing routine. If the next SREC is non-sequen-
	    // tial this routine will run again.
	    //
	    // WHAT IF THE NON-SEQUENTIAL SREC STARTS AT A POINT OTHER THAN 0
	    // RELATIVE TO THE 64 BYTE WRITES TO EEPROM?
	    // This is actually the typical case, so the code needs to read the
	    // existing data from the EEPROM to preserve previously written
	    // data, then an offset is calculated to determine the point that
	    // new SREC data needs to start within the existing EEPROM data.
	    // a) The data to read from the EEPROM is the 64 bytes starting at
	    //    ((new_address - 0x8000) & 0xFFC0).
	    // b) The offset into this data for writing the new data is
	    //    (new_address & 0x003F).
	    // NOTE: (a) and (b) are performed only once at the initial detect-
	    // ion of a non-sequential SREC case. The "non_sequential_detect"
	    // flag is used to manage this. This is necessary as TCP Fragmenta-
	    // tion may cause the process to be re-entered.
	    // c) Read the incoming SREC and write the contents to parse_tail.
	    //    If the end of parse_tail is reached or the end of the SREC is
	    //    reached write the parse_tail to the EEPROM.
	    // d) If the end of the parse_tail is reached but there is still
	    //    data in the incoming SREC then read the next 64 bytes from the
	    //    EEPROM into parse_tail, and continue writing the incoming SREC
	    //    data into the parse_tail starting at byte [0].
	    //    When the end of the SREC is reached write the parse_tail to
	    //    the EEPROM.
	    // e) Exit comments: "address" and "eeprom_address_index" never get
	    //    changed in this process so when this parsing completes we will
	    //    go on to reading the next SREC. If that next SREC has a
	    //    new_address lower than the current address the non-sequential
	    //    process repeats. Otherwise the regular read SREC process runs.
	    
            // Why not use the above technique for every SREC?
	    // Because it would result in twice as many writes to the EEPROM
	    // taking a lot longer to do the programming. Twice as many writes
	    // will occur because it is typical for the incoming data to be
	    // skewed relative to the 64 byte writes to the EEPROM, and the
	    // incoming SREC data is in 32 byte blocks as opposed to the 64 byte
	    // blocks being written to the EEPROM.
	  
	    if (non_sequential_detect == 1) {
// UARTPrintf("\r\nnon_sequential_detect == 1 ");
	      // Calculate the starting index of the EEPROM block
	      eeprom_address_index = (new_address - 0x8000) & 0xFFC0;
	      
	      // Read the existing EEPROM data into parse_tail
	      if (file_type == FILETYPE_PROGRAM) {
                prep_read(I2C_EEPROM0_WRITE, I2C_EEPROM0_READ, eeprom_address_index);
              }
	      if (file_type == FILETYPE_STRING) {
                prep_read(I2C_EEPROM2_WRITE, I2C_EEPROM2_READ, eeprom_address_index);
              }
	      
	      for (i=0; i<63; i++) {
                parse_tail[i] = I2C_read_byte(0);
              }
              parse_tail[63] = I2C_read_byte(1);
	      
	      // Set the offset into parse_tail for the new data.
              parse_index = (uint8_t)(new_address & 0x003F);
	      
	      // Clear initial detect flag so this "if" section will be bypassed
	      // if the code is re-entered due to handle TCP Fragmentation.
	      non_sequential_detect = 0;
// UARTPrintf("\r\nnon_sequential_detect EEPROM read completed");
	    }
	    
	    // This parse is entered knowing that the next two characters are a
	    // data byte, and that all the data of interest is contained in a
	    // single incoming SREC.
	    
	    while (1) {
              // Read two characters from the data line
              pBuffer = read_two_characters(pBuffer);
              if (byte_tail[0] == '\0') {
	        // No characters were found. This can occur when an end of
	        // packet occurs during a CRLF sequence. The read attempt will
	        // have set file_nBytes to zero. Break out of the local while
	        // loop so that the next packet will be read.
	        break;
	      }
              if (byte_tail[1] == '\0') {
                // We only found 1 character so we just read the last character
	        // in this packet. The read_two_characters() function will have
	        // set file_nBytes to zero. Break out of the local while loop so
	        // the next packet will be read.
                break;
              }

// {
// uint8_t temp[3];
// temp[0] = byte_tail[0];
// temp[1] = byte_tail[1];
// temp[2] = '\0';
// UARTPrintf(temp);
// }
	    
	      // If we didn't break out then we successfully read two characters
              data_value = two_hex2int(byte_tail[0], byte_tail[1]);
              checksum += data_value;
	      data_count--;
              // Clear byte_tail for subsequent reads
              byte_tail[0] = '\0';
              byte_tail[1] = '\0';
	      
	      if (data_count > 0) {
	        // Copy data to parse_tail
	        parse_tail[parse_index++] = data_value;
	        address++; // Increment the incoming address counter
	      }
	      
	      if (data_count == 0) {
	        // We just read the last byte in this SREC. The byte just read
	        // was the checksum. Check for validity.
	        if (checksum != 0xff) {
	          // Handle Checksum Error
                  upgrade_failcode = UPGRADE_FAIL_FILE_READ_CHECKSUM;

// UARTPrintf("checksum = ");
// emb_itoa(checksum, OctetArray, 16, 4);
// UARTPrintf(OctetArray);
// UARTPrintf("\r\n");
	      
// UARTPrintf("UPGRADE_FAILCODE = UPGRADE_FAIL_FILE_READ_CHECKSUM\r\n");
                  pSocket->ParseState = PARSE_FILE_FAIL;
		  break;
	        }
	        else {
// UARTPrintf("\r\nnon_sequential_detect checksum completed");
	        }
	      }
	      
	      if (data_count == 0 || parse_index == 64) {
                // Copy parse_tail to Off-Board EEPROM0
	        
                // Write the data in the parse_tail array into the Off-Board
	        // EEPROM.
                {
                  int i;
                  uint8_t I2C_last_flag;
                  uint8_t temp_byte;
		  
	          if (file_type == FILETYPE_PROGRAM) {
                    I2C_control(I2C_EEPROM0_WRITE); // Send Write Control Byte
		  }
	          if (file_type == FILETYPE_STRING) {
                    I2C_control(I2C_EEPROM2_WRITE); // Send Write Control Byte
// UARTPrintf("\r\nEEPROM2 write at eeprom_address_index ");
		  }
		  
                  I2C_byte_address(eeprom_address_index);
// UARTPrintf("\r\nEEPROM0 write at eeprom_address_index ");
// emb_itoa(eeprom_address_index, OctetArray, 16, 4);
// UARTPrintf(OctetArray);
// UARTPrintf(": \r\n");
                  for (i=0; i<64; i++) {
                    I2C_write_byte(parse_tail[i]);
// emb_itoa(parse_tail[i], OctetArray, 16, 2);
// UARTPrintf(" ");
// UARTPrintf(OctetArray);
                  }
                  I2C_stop();
                  wait_timer(5000); // Wait 5ms
                  IWDG_KR = 0xaa; // Prevent the IWDG from firing.
		  
                  // Validate data in Off-Board EEPROM
	          if (file_type == FILETYPE_PROGRAM) {
                    prep_read(I2C_EEPROM0_WRITE, I2C_EEPROM0_READ, eeprom_address_index);
		  }
	          if (file_type == FILETYPE_STRING) {
                    prep_read(I2C_EEPROM2_WRITE, I2C_EEPROM2_READ, eeprom_address_index);
		  }
		  
	          I2C_last_flag = 0;
// UARTPrintf("\r\nEEPROM contents: \r\n");
                  for (i=0; i<64; i++) {
                    if (i == 63) I2C_last_flag = 1;
                    temp_byte = I2C_read_byte(I2C_last_flag);
// emb_itoa(temp_byte, OctetArray, 16, 2);
// UARTPrintf(" ");
// UARTPrintf(OctetArray);
                    if (temp_byte != parse_tail[i]) {
                      upgrade_failcode = UPGRADE_FAIL_EEPROM_MISCOMPARE;
// UARTPrintf("UPGRADE_FAILCODE = UPGRADE_FAIL_EEPROM_MISCOMPARE\r\n");
                      pSocket->ParseState = PARSE_FILE_FAIL;
                    }
                  }
                }
	      }
	      
	      if (parse_index == 64 && data_count != 0) {
	        // Hit end of parse_tail but still have data to read from this
	        // SREC. Read the next 64 bytes from the EEPROM into parse_tail,
	        // and continue writing the incoming SREC data into the
	        // parse_tail starting at byte [0]. When the end of the SREC
	        // data is reached write the parse_tail to the EEPROM.
	        
	        // Point to next block in EEPROM
	        eeprom_address_index += 64;
		
                // Read the next existing EEPROM data into parse_tail
	        if (file_type == FILETYPE_PROGRAM) {
                  prep_read(I2C_EEPROM0_WRITE, I2C_EEPROM0_READ, eeprom_address_index);
		}
	        if (file_type == FILETYPE_STRING) {
                  prep_read(I2C_EEPROM2_WRITE, I2C_EEPROM2_READ, eeprom_address_index);
		}
		
	        for (i=0; i<63; i++) {
	          parse_tail[i] = I2C_read_byte(0);
	        }
	        parse_tail[63] = I2C_read_byte(1);
	    
	        // The local while loop continues to finish reading the incoming
	        // SREC.
	      }
	      
	      if (parse_index == 64) {
	        parse_index = 0; // Clear for next data
	      }
	      
	      if (data_count == 0) {
                // Go on to read next SREC
                byte_index = 0;
                pSocket->ParseState = PARSE_FILE_SEEK_SX;
                break;
	      }
	      
              if (file_nBytes == 0) {
// UARTPrintf("\r\nnon_sequential_detect file_nBytes == 0");
                // We just read the last character in this packet. Break out
                // of the local while loop so the next packet will be read.
                break;
              }
	    } // End of local while loop
	  }
	

          if (pSocket->ParseState == PARSE_FILE_FAIL) {
            // Abort parsing.
	    // Enter a loop that will allow the Browser to finish sending
	    // whatever it was sending.
	    while (file_length > 0) {
	      // Use the read_two_characters() function to deplete the incoming
	      // packets. Once file_length reaches zero we've received all
	      // packets.
	      // Note that if we "break" it allows the program to fetch another
	      // packet and then we return to this routine to read and deplete
	      // that packet.
	      // Also note that when file_length reaches zero file_nBytes should
	      // also be zero if all is working correctly.
	      
              // Read two characters from the data line
              pBuffer = read_two_characters(pBuffer);
              IWDG_KR = 0xaa; // Prevent the IWDG from firing.
	      if (file_length == 0) {
	        // All packets read. Go on to the PARSE_FILE_FAIL_EXIT routine.
	        pSocket->ParseState = PARSE_FILE_FAIL_EXIT;
// UARTPrintf("\r\nSet ParseState to PARSE_FILE_FAIL_EXIT, break local loop\r\n");
		break;
              }
              if (file_nBytes == 0) {
                // The read_two_characters() function will set file_nBytes to
	        // zero if an end of packet occurred. If so break out of the
	        // local while loop so the next packet will be read.
	        break;
	      }
	    } // End of local while loop
	  }

	  if (file_length == 0) {
	    // All packets read.
// UARTPrintf("\r\nAll packets read, break main loop\r\n");
	    break; // Break out of mail while loop
          }
	  
          if (file_nBytes == 0) {
            // We just read the last character in this packet. Break out
            // of the main while loop so the next packet will be read.

// Diagnostic only
// UARTPrintf("\r\nfile_length: ");
// emb_itoa(file_length, OctetArray, 10, 5);
// UARTPrintf(OctetArray);
// UARTPrintf("  file_nBytes: ");
// emb_itoa(file_nBytes, OctetArray, 10, 3);
// UARTPrintf(OctetArray);
// UARTPrintf("\r\n");

// UARTPrintf("XXXXXX-EOP-XXXXXX");
            break; // Break out of main while loop
          }
        } // End of main while loop
      }

// UARTPrintf("\r\nExcuting code after main loop\r\n");
// if (pSocket->ParseState == PARSE_FILE_FAIL_EXIT) {
// UARTPrintf("\r\nParseState == PARSE_FILE_FAIL_EXIT\r\n");
// }
    
      if (pSocket->ParseState == PARSE_FILE_COMPLETE && file_type == FILETYPE_PROGRAM) {

// UARTPrintf("\r\n");
// UARTPrintf("File Upload Complete - entering 500ms pause");
// UARTPrintf("\r\n");

        // All data is now in Off-Board EEPROM0. Signal the main.c loop to
	// copy the data to Flash and display a Timer window to have the
	// user wait until Flash programming completes and the module reboots.
	eeprom_copy_to_flash_request = I2C_COPY_EEPROM0_REQUEST;
        pSocket->nParseLeft = 0;
	
	pSocket->current_webpage = WEBPAGE_TIMER;
        pSocket->pData = g_HtmlPageTimer;
        pSocket->nDataLeft = (uint16_t)(sizeof(g_HtmlPageTimer) - 1);
	
	// Send the response
        pSocket->nPrevBytes = 0xFFFF;
        pSocket->nState = STATE_SENDHEADER200;
      }


      if (pSocket->ParseState == PARSE_FILE_COMPLETE && file_type == FILETYPE_STRING) {

// UARTPrintf("\r\n");
// UARTPrintf("File Upload Complete - entering 500ms pause");
// UARTPrintf("\r\n");

        // All data is now in Off-Board EEPROM2.
	// Display the Upload Complete GUI.
        pSocket->nDataLeft = 0;
        pSocket->nParseLeft = 0;
	
	pSocket->current_webpage = WEBPAGE_UPLOAD_COMPLETE;
        pSocket->pData = g_HtmlPageUploadComplete;
        pSocket->nDataLeft = (uint16_t)(sizeof(g_HtmlPageUploadComplete) - 1);
	
        // Send the response
        pSocket->nPrevBytes = 0xFFFF;
        pSocket->nState = STATE_SENDHEADER200;
      }


      if (pSocket->ParseState == PARSE_FILE_FAIL_EXIT) {
        // Parsing aborted. Display a GUI with the fail reason code.

// UARTPrintf("\r\n");
// UARTPrintf("Parse FAIL XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX");
// UARTPrintf("\r\n");

	// Display the fail reason and tell the user to try again.
        pSocket->nParseLeft = 0;
	pSocket->current_webpage = WEBPAGE_PARSEFAIL;
        pSocket->pData = g_HtmlPageParseFail;
        pSocket->nDataLeft = (uint16_t)(sizeof(g_HtmlPageParseFail) - 1);
	// Send the response
        pSocket->nPrevBytes = 0xFFFF;
        pSocket->nState = STATE_SENDHEADER200;
      }
    }
#endif // BUILD_SUPPORT == CODE_UPLOADER_BUILD


    if (pSocket->nState == STATE_SENDHEADER200) {

// UARTPrintf("HttpDCall: SENDHEADER200\r\n");

      // This step is usually entered after GET processing is complete in
      // order to send an appropriate web page in response to the GET request.
      // In the uip_send() call we provide the CopyHttpHeader function with
      // the length of the web page.
      // Some GET requests do not send a webpage response (just a header with
      // 0 data). In those cases STATE_SENDHEADER204 will have been entered
      // from GET processing.
      uip_send(uip_appdata, CopyHttpHeader(uip_appdata, adjust_template_size(pSocket)));
      pSocket->nState = STATE_SENDDATA;
      return;
    }
      
    if (pSocket->nState == STATE_SENDHEADER204) {

// UARTPrintf("HttpDCall: SENDHEADER204\r\n");

      // This step is entered after POST is complete.
      // This step is also entered after GET processing is complete if no
      // webpage reply is required.
      // In both of these cases we only send a header with Content Length: 0
      // and no data is sent.
      // Note: After POST of an IOControl or Configuration page no webpage is
      // automatically sent. The javascript in those pages will generate a GET
      // request to update the Browser after the POST is sent.
      // Note: It is not clear if some browsers require a "204 No Content"
      // header. This appears to work just returning a "200 OK" with Content
      // Length: 0.
      uip_send(uip_appdata, CopyHttpHeader(uip_appdata, 0));
      // Clear nDataLeft and go to STATE_SENDDATA, but only to close
      // connection.
      pSocket->nDataLeft = 0;
      pSocket->nState = STATE_SENDDATA;
      return;
    }

    senddata:
    if (pSocket->nState == STATE_SENDDATA) {
      // We have sent the HTML Header or HTML Data previously. Now we send
      // data using the CopyHttpData() function as a pre-processor, and the
      // uip_send() function to actually copy data from the internal buffer
      // to the ENC28J60 hardware.
      // Data is always sent at the end of a "uip_newdata()" as a response to
      // a Browser request.
      // When transmitting data to the Browser there may be more data than
      // will fit in one packet. For instance transmitting one of the Webpage
      // templates can easily take 10 or more transmit packets. So, additional
      // data (if any) will be sent on return to this function in response to
      // "uip_acked()". Whether or not there is additional data to send in a
      // series of packets is tracked in the nDataLeft variable.
      // If there is no data to send, or if all data has been sent, we close
      // the connection.

// UARTPrintf("Send Data, off_board_eeprom_index: ");
// emb_itoa(off_board_eeprom_index, OctetArray, 16, 4);
// UARTPrintf(OctetArray);
// UARTPrintf("\r\n");

      if (pSocket->nDataLeft == 0) {
        // There is no data to send. Close connection
        nBufSize = 0;
      }
      else {
        // Copy data to buffer
        pSocket->nPrevBytes = pSocket->nDataLeft;
        nBufSize = CopyHttpData(uip_appdata, &pSocket->pData, &pSocket->nDataLeft, uip_mss(), pSocket);
        pSocket->nPrevBytes -= pSocket->nDataLeft;
      }

      if (nBufSize == 0) {
        //No Data has been copied (or there was none to send). Close connection
// UARTPrintf("nBufSize == 0, Closing Connection\r\n");
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

// UARTPrintf("HttpDCall: uip_rexmit\r\n");

    if (pSocket->nPrevBytes == 0xFFFF) {
      // Send header again
      uip_send(uip_appdata, CopyHttpHeader(uip_appdata, adjust_template_size(pSocket)));
    }
    else {

// UARTPrintf("XXXX RETRANSMIT XXXX\r\n");

      // The pData pointer needs to be moved back by the number of bytes
      // consumed from the webpage template.
      pSocket->pData -= pSocket->nPrevBytes;
      
#if OB_EEPROM_SUPPORT == 1
      // A similar adjustment is required for off_board_eeprom_index when
      // the webpage is sourced from Off-Board EEPROM.
      off_board_eeprom_index -= pSocket->nPrevBytes;
#endif // OB_EEPROM_SUPPORT == 1
      
      pSocket->nDataLeft += pSocket->nPrevBytes;
      pSocket->nPrevBytes = pSocket->nDataLeft;
      nBufSize = CopyHttpData(uip_appdata, &pSocket->pData, &pSocket->nDataLeft, uip_mss(), pSocket);
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



#if BUILD_SUPPORT == CODE_UPLOADER_BUILD
char *read_two_characters(char *pBuffer)
{
  // This function attempts to read two bytes from the SREC file.
  // - Normal function is that two bytes are read.
  // - The function must also handle the case where we only need to read one
  //   byte because a byte was already read at the tail of a previous packet.
  // - The function must also handle the case where we can only read one byte
  //   because it is the last remaining byte in a packet.
  // - The function discards any CR or LF character
  //
  // The function updates and returns the pBuffer pointer as bytes are consum-
  // ed from the incoming data buffer.
  //
  // The function updates the byte_tail string with the bytes read from the
  // incoming data buffer.
  //
  // The function updates the nParseLeft and file_nBytes counters.

  if ((byte_tail[0] != '\0') && (byte_tail[1] == '\0')) {
    // This is a check for TCP Fragmentation during a prior packet. byte_tail
    // will have length 0 if no prior fragmentation occurred. If TCP Fragment-
    // ation DID occur then byte_tail[0] will contain the last byte read from the
    // SREC file and byte_tail[1] will contain NULL.
    // Note that the SREC file is read one byte at a time, but a two byte pair
    // is needed for any processing to occur. So, if only one byte of the two
    // byte pair is captured when a packet boundary is encountered that byte
    // must be saved in byte_tail so that the two bye pair can be completed
    // and processed when the next packet is received.
    // We have to account for the case where the single byte read in the
    // previous packet is followed by CR or LF. In that case we discard the
    // CR and LF and go on to read the next valid character.
    
    while (1) {
      if (*pBuffer != '\r' && *pBuffer != '\n') {
        byte_tail[1] = *pBuffer;
        pBuffer++;
        file_nBytes--;
	file_length--; // Decrement the file_length for every character read
	break;
      }
      else {
        // Ignore the CR or LF
        pBuffer++;
        file_nBytes--;
	file_length--; // Decrement the file_length for every character read
	if (file_nBytes == 0) break;
      }
    }
    byte_tail[2] = '\0';
    return pBuffer;
  }

  else {
    // We are starting with an empty byte_tail. Fill with any remaining bytes
    // in the packet, but ignore CR and LF.
    if (file_nBytes != 0) {
      while (1) {
        if (*pBuffer != '\r' && *pBuffer != '\n') {
          byte_tail[0] = *pBuffer;
          pBuffer++;
          file_nBytes--;
          file_length--; // Decrement the file_length for every character read
          break;
        }
        else {
          // Ignore the CR or LF
          pBuffer++;
          file_nBytes--;
          file_length--; // Decrement the file_length for every character read
  	  if (file_nBytes == 0) break;
        }
      }
    }
    
    if (file_nBytes != 0) {
      while (1) {
        if (*pBuffer != '\r' && *pBuffer != '\n') {
          byte_tail[1] = *pBuffer;
          pBuffer++;
          file_nBytes--;
          file_length--; // Decrement the file_length for every character read
          break;
        }
        else {
          // Ignore the CR or LF
          pBuffer++;
          file_nBytes--;
          file_length--; // Decrement the file_length for every character read
  	  if (file_nBytes == 0) break;
        }
      }
    }
    byte_tail[2] = '\0';
    return pBuffer;
  }
}
#endif // BUILD_SUPPORT == CODE_UPLOADER_BUILD



#if BUILD_SUPPORT == BROWSER_ONLY_BUILD || BUILD_SUPPORT == MQTT_BUILD
uint16_t parsepost(struct tHttpD* pSocket, char *pBuffer, uint16_t nBytes) {
  // This function parses data the user entered in the GUI.
  
  // Parse pre-process
  // A "local_buf" is created on the stack to hold the incoming POST data for
  // parsing.
  // The POST data is copied from the uip_buf to the local_buf until one of
  // two things happen:
  // a) The local_buf is full
  // b) The end of the uip_buf is reached (end of the packet)
  //
  // Each POST component is copied to the parse_tail as they are found. As
  // each POST component is found it will replace the prior POST component.
  // The objective is to let the parse_tail contain any partial POST that
  // appears at the tail of the current packet (ie, when a TCP Fragment
  // occurs). The parse_tail is global so that it will retain the partial
  // POST data when leaving the function to collect additional packets.
  //
  // Note: local_buf is used only within this function. It is important that
  // the stack used by the local_buf is freed up so that the CopyHttpData()
  // called later can use the stack memory for a different buffer.

  uint16_t i;
  uint16_t j;
  char local_buf[300];
  uint16_t local_buf_index_max;

// UARTPrintf("parse_post: current_webpage = ");
// emb_itoa(pSocket->current_webpage, OctetArray, 10, 5);
// UARTPrintf(OctetArray);
// UARTPrintf("\r\n");

  local_buf_index_max = 290;

// UARTPrintf("\r\n");
// UARTPrintf("pSocket->nState == STATE_PARSEPOST Parsing");
// UARTPrintf("\r\n");
// UARTPrintf("Parsing normal POST");
// UARTPrintf("\r\n");

  // If we are continuing data collection due to a TCP Fragment parse_tail
  // will have any fragment of the previous POST in it. Otherwise
  // parse_tail is NULL. We need to restore the parse_tail to the start of
  // the local_buf so that additional data will be added to it.
  strcpy(local_buf, parse_tail);
  i = strlen(parse_tail);
  j = 0;
  
  while (1) {
    // Here we start copying data from the uip_buf to the local_buf. Remember
    // that before this routine was called we already detected the \r\n\r\n
    // sequence in the packet, so we're only copying data starting at the
    // point that POST data begins.
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

// UARTPrintf("parse_tail chk1: \r\n");
// UARTPrintf(parse_tail);
// UARTPrintf("\r\n");
// UARTPrintf("End of POST: \r\n");
// UARTPrintf(local_buf);
// UARTPrintf("\r\n");

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

// UARTPrintf("parse_tail chk2: \r\n");
// UARTPrintf(parse_tail);
// UARTPrintf("\r\n");
// UARTPrintf("local_buf: \r\n");
// UARTPrintf(local_buf);
// UARTPrintf("\r\n");

          parse_local_buf(pSocket, local_buf, strlen(local_buf));
          
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

// UARTPrintf("parse_tail chk3: \r\n");
// UARTPrintf(parse_tail);
// UARTPrintf("\r\n");
// UARTPrintf("local_buf: \r\n");
// UARTPrintf(local_buf);
// UARTPrintf("\r\n");

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
  return nBytes;
}
#endif // BUILD_SUPPORT == BROWSER_ONLY_BUILD || BUILD_SUPPORT == MQTT_BUILD



#if BUILD_SUPPORT == BROWSER_ONLY_BUILD || BUILD_SUPPORT == MQTT_BUILD
void parse_local_buf(struct tHttpD* pSocket, char* local_buf, uint16_t lbi_max)
{
  uint16_t lbi; // Local buffer index
  
// UARTPrintf("parse_local_buf: current_webpage = ");
// emb_itoa(pSocket->current_webpage, OctetArray, 10, 5);
// UARTPrintf(OctetArray);
// UARTPrintf("\r\n");

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
        
	// Notes on the "current_webpage" logic.
	// When parsing a POST we need to know if the POST came from a
	// IOControl page or from a Configuation page. The IOControl page
	// starts with a 'h' value, while the Configuration page starts
	// with a 'a' value. If we have not encountered a 'a' value yet
	// the current_webpage will be NULL. Now that we see a 'a' value
	// we now know we are receiving a POST from a Configuration page.
	// Setting current_webpage here is important to subsequent POST
	// processing decisions.
        pSocket->current_webpage = WEBPAGE_CONFIGURATION;
        pSocket->nParseLeft = PARSEBYTES_CONFIGURATION;

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
// UARTPrintf("Pending_devicename: \r\n");
// UARTPrintf(Pending_devicename);
// UARTPrintf("\r\n");
	      break;
	    case 'l':
	      memcpy(Pending_mqtt_username, tmp_Pending, num_chars);
// UARTPrintf("Pending_mqtt_username: \r\n");
// UARTPrintf(Pending_mqtt_username);
// UARTPrintf("\r\n");
	      break;
	    case 'm':
	      memcpy(Pending_mqtt_password, tmp_Pending, num_chars);
// UARTPrintf("Pending_mqtt_password: \r\n");
// UARTPrintf(Pending_mqtt_password);
// UARTPrintf("\r\n");
	      break;
#if BUILD_SUPPORT == BROWSER_ONLY_BUILD
	    case 'j':
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
	      break;
#endif // BUILD_SUPPORT == BROWSER_ONLY_BUILD
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
	    
	    // Notes on the "current_webpage" logic.
	    // When parsing a POST we need to know if the POST came from a
	    // IOControl page or from a Configuation page. The IOControl page
	    // starts with a 'h' value, while the Configuration page starts
	    // with a 'a' value. If we have not encountered a 'a' value yet
	    // the current_webpage will be NULL, so we now know we are
	    // receiving a POST from an IOControl page.
	    if (pSocket->current_webpage == WEBPAGE_NULL) {
              pSocket->current_webpage = WEBPAGE_IOCONTROL;
	      pSocket->nParseLeft = PARSEBYTES_IOCONTROL;
	    }
	    
            if (pSocket->current_webpage == WEBPAGE_CONFIGURATION) {
// UARTPrintf("Received Config Data\r\n");
              // Keep the ON/OFF bit as-is
              Pending_pin_control[j] = (uint8_t)(Pending_pin_control[j] & 0x80);
              // Mask out the ON/OFF bit in the temp variable
              k = (uint8_t)(k & 0x7f);
            }
            else {
// UARTPrintf("Received IOControl Data\r\n");
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


#if BUILD_SUPPORT == BROWSER_ONLY_BUILD
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
#endif // BUILD_SUPPORT == BROWSER_ONLY_BUILD


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
  //   pSocket->nParseLeft != 0.
  // I will use a global "parse_complete" variable to pass the state to
  // the main.c functions.
  //

  if (pSocket->nParseLeft == 0) {
    // Finished parsing
	
    // Signal the main.c processes that parsing is complete
    parse_complete = 1;
    // Set nState to close the connection
    pSocket->nState = STATE_SENDHEADER204;
// UARTPrintf("Pending_devicename = ");
// UARTPrintf(Pending_devicename);
// UARTPrintf("\r\n");
// UARTPrintf("nParseLeft == 0. nState = STATE_SENDHEADER204.\r\n");
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
// UARTPrintf("Pending_devicename = ");
// UARTPrintf(Pending_devicename);
// UARTPrintf("\r\n");
// UARTPrintf("nParseLeft > 0. Continue parsing.\r\n");
  }
}
#endif // BUILD_SUPPORT == BROWSER_ONLY_BUILD || BUILD_SUPPORT == MQTT_BUILD


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
