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
  
/* Modifications 2020-2022 Michael Nielson
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
 
 Copyright 2022 Michael Nielson
*/


// All includes are in main.h
#include "main.h"


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
#define PARSE_NUMMSD		1       // Parsing the most sig digit of POST
                                        // cmd
#define PARSE_NUMLSD		2       // Parsing the least sig digit of a
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


// Variables used to store debug information
extern uint8_t debug[10];
extern uint8_t stored_debug[10];

#if DEBUG_SUPPORT == 7 || DEBUG_SUPPORT == 15
uint16_t rexmit_count; // Used only for sending the rexmit count via UART
#endif // DEBUG_SUPPORT == 7 || DEBUG_SUPPORT == 15

extern uint16_t Port_Httpd;               // Port number in use

#if PCF8574_SUPPORT == 0
extern uint8_t pin_control[16];           // Per pin configuration byte
#endif // PCF8574_SUPPORT == 0
#if PCF8574_SUPPORT == 1
extern uint8_t pin_control[24];           // Per pin configuration byte when
                                          // PCF8574 is included in the
					  // hardware configuration
#endif // PCF8574_SUPPORT == 1

#if PCF8574_SUPPORT == 0
extern uint16_t ON_OFF_word;              // ON/OFF states of pins in single
                                          // 16 bit word
extern uint16_t Invert_word;              // Invert state of pins in single 16
                                          // bit word
#endif // PCF8574_SUPPORT == 0
#if PCF8574_SUPPORT == 1
extern uint32_t ON_OFF_word;              // ON/OFF states of pins in single
                                          // 32 bit word
extern uint32_t Invert_word;              // Invert state of pins in single 32
                                          // bit word
#endif // PCF8574_SUPPORT == 1

extern uint8_t Pending_hostaddr[4];       // Temp storage for new IP address
extern uint8_t Pending_draddr[4];         // Temp storage for new Gateway
                                          // address
extern uint8_t Pending_netmask[4];        // Temp storage for new Netmask

extern uint16_t Pending_port;             // Temp storage for new Port number

extern uint8_t Pending_devicename[20];    // Temp storage for new Device Name

extern uint8_t Pending_config_settings;   // Temp storage for new Config
                                          // settings
					  
#if PCF8574_SUPPORT == 0
extern uint8_t Pending_pin_control[16];   // Temp storage for new pin_control
                                          // received from GUI
#endif // PCF8574_SUPPORT == 0
#if PCF8574_SUPPORT == 1
extern uint8_t Pending_pin_control[24];   // Temp storage for new pin_control
                                          // received from the GUI when
                                          // PCF8574 is included in the
					  // hardware configuration
#endif // PCF8574_SUPPORT == 1

extern uint8_t Pending_uip_ethaddr_oct[6]; // Temp storage for new MAC address

extern uint8_t stored_hostaddr[4];	  // hostaddr stored in EEPROM
extern uint8_t stored_draddr[4];	  // draddr stored in EEPROM
extern uint8_t stored_netmask[4];	  // netmask stored in EEPROM

extern uint16_t stored_port;		  // Port number stored in EEPROM

extern uint8_t stored_devicename[20];     // Device name stored in EEPROM

extern uint8_t stored_config_settings;    // Config settings stored in EEPROM

extern uint8_t stored_options1;           // Additional options stored in
                                          // EEPROM

extern char mac_string[13];		  // MAC Address in string format

extern uint8_t parse_complete;            // Used to signal that all user
                                          // inputs have POSTed and are ready
					  // to be used

extern uint8_t user_reboot_request;       // Communicates the need to reboot
                                          // back to the main.c functions
extern uint8_t restart_reboot_step;       // Indicates whether restart or
                                          // reboot are underway.

extern const char code_revision[];        // Code Revision
       
uint8_t OctetArray[14];		          // Used in emb_itoa conversions and
                                          // to transfer short strings globally


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
uint16_t eeprom_address_index; // Address index into the I2C EEPROM for
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
uint8_t eeprom_copy_to_flash_request;
                               // Flag to cause the main.c loop to call the
                               // copy to flash function.
uint16_t off_board_eeprom_index; // Used as an index into the I2C EEPROM
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


// uint8_t z_diag;               // The last value in a POST (hidden), used for
                              // diagnostics
uint16_t HtmlPageIOControl_size;     // Size of the IOControl template
uint16_t HtmlPageConfiguration_size; // Size of the Configuration template
uint16_t HtmlPageLoadUploader_size;  // Size of the Load Uploader template

#if PCF8574_SUPPORT == 1
uint16_t HtmlPagePCFIOControl_size;     // Size of the PCF8574 IOControl template
uint16_t HtmlPagePCFConfiguration_size; // Size of the PCF8574 Configuration template
#endif // PCF8574_SUPPORT == 1


// These MQTT variables must always be compiled in the MQTT_BUILD and
// BROWSER_ONLY_BUILD to maintain a common user interface between the MQTT
// and Browser Only versions.
extern uint8_t mqtt_enabled;              // Signals if MQTT has been enabled
extern uint8_t stored_mqttserveraddr[4];  // mqttserveraddr stored in EEPROM
extern uint16_t stored_mqttport;	  // MQTT Host Port number stored in
                                          // EEPROM
extern char stored_mqtt_username[11];     // MQTT Username  stored in EEPROM
extern char stored_mqtt_password[11];     // MQTT Password  stored in EEPROM

extern uint8_t Pending_mqttserveraddr[4]; // Temp storage for new MQTT IP
                                          // Address
extern uint16_t Pending_mqttport;	  // Temp storage for new MQTT Host
                                          // Port
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


#if DS18B20_SUPPORT == 1
// DS18B20 variables
// extern uint8_t DS18B20_scratch[5][2];     // Stores the temperature measurement
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
#endif // DS18B20_SUPPORT == 1


#if BME280_SUPPORT == 1
extern int16_t stored_altitude; // User entered altitude used for BME280
				// pressure calibration stored in EEPROM

extern int32_t comp_data_temperature; // Compensated temperature
extern int32_t comp_data_pressure;    // Compensated pressure
extern int32_t comp_data_humidity;    // Compensated humidity
#endif // BME280_SUPPORT == 1


#if BUILD_SUPPORT == BROWSER_ONLY_BUILD
// Define Flash addresses for IO Names and IO Timers
extern uint16_t IO_TIMER[16] @FLASH_START_IO_TIMERS;
extern char IO_NAME[16][16] @FLASH_START_IO_NAMES;
// Define RAM addresses for Pending timers
#if PCF8574_SUPPORT == 0
extern uint16_t Pending_IO_TIMER[16];
#endif // PCF8574_SUPPORT == 0
#if PCF8574_SUPPORT == 1
extern uint16_t Pending_IO_TIMER[24];
#endif // PCF8574_SUPPORT == 1
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
#define WEBPAGE_PCF8574_IOCONTROL	21
#define WEBPAGE_PCF8574_CONFIGURATION	22
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
//     Note: No trailing parse delimiter
// THUS
// For 1 of the replies there are 37 bytes in the reply
// For 1 of the replies there are 6 bytes per reply
// The formula in this case is
//     PARSEBYTES = (1 x 37)
//                + (1 x 6)
//     PARSEBYTES = 37
//                + 5 = 42
//
#define WEBPAGE_IOCONTROL		1
#define PARSEBYTES_IOCONTROL		42
#define MQTT_WEBPAGE_IOCONTROL_BEGIN    90
// The MQTT_WEBPAGE_IOCONTROL_BEGIN define is used only by the "prepsx"
// strings pre-processor program. The define is used by the prepsx program as
// a keyword for locating the webpage text contained in the static const
// below. The prepsx program extracts the HTML "string" and places it in an
// SREC (.sx) file. The HTML strings in the .sx file are uploaded into the I2C
// EEPROM for subsequent use in generating webpages from the I2C EEPROM
// instead of generating them from Flash.
// Next #if: Only place the HTML in Flash if the I2C EEPROM is not supported.
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
"const m=(t=>{let e=document,r=location,$=e.querySelector.bind(e),h=$('form'),n=(Object."
"entries,parseInt),a=t=>e.write(t),s=(t,e)=>n(t).toString(16).padStart(e,'0'),l=t=>t.map"
"(t=>s(t,2)).join(''),d=t=>t.match(/.{2}/g).map(t=>n(t,16)),o=t=>encodeURIComponent(t),p"
"=[],c=[],u=(t,e,r)=>{var $;return`<label><input type=radio name=o${e} value=${t} ${r==t"
"?'checked':''}/>${(t?'on':'off').toUpperCase()}</label>`},f=()=>{let e=new FormData(h);"
"return e.set('h00',l(d(t.h00).map((t,r)=>{let $='o'+r,h=e.get($)<<7;return e.delete($),"
"h}))),e},i=d(t.g00)[0];return 16&i?(cfg_page=()=>r.href='/60',cfg_page_pcf=()=>r.href='"
"/60'):(cfg_page=()=>r.href='/61',cfg_page_pcf=()=>r.href='/63'),ioc_page_pcf=()=>r.href"
"='/62',reload_page=()=>r.href='/60',submit_form=t=>{t.preventDefault();let e=new XMLHtt"
"pRequest,r=Array.from(f().entries(),([t,e])=>`${o(t)}=${o(e)}`).join('&');e.open('POST'"
",'/',!1),e.send(r+'&z00=0'),reload_page()},d(t.h00).forEach((t,e)=>{(3&t)==3?c.push(`<t"
"r><td>Output #${e+1}</td><td class='s${t>>7} t3'></td><td class=c>${u(1,e,t>>7)}${u(0,e"
",t>>7)}</td></tr>`):(3&t)==1&&p.push(`<tr><td>Input #${e+1}</td><td class='s${t>>7} t3'"
"></td><td/></tr>`)}),a(p.join('')),a(`<tr><th></th><th></th>${c.length>0?'<th class=c>S"
"ET</th>':''}</tr>`),a(c.join('')),{s:submit_form,l:reload_page,c:cfg_page,j:ioc_page_pc"
"f}})({h00:'%h00',g00:'%g00'});"
      "%y01"
      "%y02'm.l()'>Refresh</button>"
      "<br><br>"
      "%y02'm.c()'>Configuration</button> "
      "%y02'm.j()'>PCF8574 IOControl</button>"
      "<pre>%t00%t01%t02%t03%t04%t05</pre>"
   "</body>"
"</html>";
#endif // OB_EEPROM_SUPPORT == 0

#if OB_EEPROM_SUPPORT == 1
// Declared short static const here so that common code can be used for Flash
// and I2C EEPROM webpage sources.
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
        loc = location,
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
          cfg_page = () => loc.href = '/60';
          cfg_page_pcf = () => loc.href = '/60';
        } else {
          cfg_page = () => loc.href = '/61';        
          cfg_page_pcf = () => loc.href = '/63';        
        }

        ioc_page_pcf = () => loc.href = '/62',
        reload_page = () => loc.href = '/60',
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
    
    return {s: submit_form, l:reload_page, c:cfg_page, j:ioc_page_pcf}
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
//     example: z00=x (note no &)
//     where x is 1 byte
// The formula in this case is
//     PARSEBYTES = (1 x 24)
//                + (4 x 13)
//                + (2 x 9)
//                + (1 x 17) 
//                + (1 x 11) 
//                + (2 x 15)
//                + (1 x 37)
//                + (1 x 5)
//     PARSEBYTES = 24
//                + 52
//                + 18
//                + 17
//                + 11
//                + 30
//                + 37
//                + 5 = 194
//
#define WEBPAGE_CONFIGURATION			2
#define PARSEBYTES_CONFIGURATION		194
#define MQTT_WEBPAGE_CONFIGURATION_BEGIN	91
// The MQTT_WEBPAGE_CONFIGURATION_BEGIN define is used only by the "prepsx"
// strings pre-processor program. The define is used by the prepsx program as
// a keyword for locating the webpage text contained in the static const
// below. The prepsx program extracts the HTML "string" and places it in an
// SREC (.sx) file. The HTML strings in the .sx file are uploaded into the I2C
// EEPROM for subsequent use in generating webpages from the I2C EEPROM
// instead of generating them from Flash.
// Next #if: Only place the HTML in Flash if the I2C EEPROM is not supported.
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
"o':6,MQTT:4,DS18B20:8,BME280:32,'Disable Cfg Button':16},n={disabled:0,input:1,output:3"
",linked:2},o={retain:8,on:16,off:0},a=document,l=location,p=a.querySelector.bind(a),i=p"
"('form'),d=Object.entries,c=parseInt,s=e=>a.write(e),_=(e,t)=>c(e).toString(16).padStar"
"t(t,'0'),u=e=>e.map(e=>_(e,2)).join(''),f=e=>e.match(/.{2}/g).map(e=>c(e,16)),b=e=>enco"
"deURIComponent(e),h=e=>p(`input[name=${e}]`),g=(e,t)=>h(e).value=t,x=(e,t)=>{for(let $ "
"of a.querySelectorAll(e))t($)},E=(e,t)=>{for(let[$,r]of d(t))e.setAttribute($,r)},y=(e,"
"t)=>d(e).map(e=>`<option value=${e[1]} ${e[1]==t?'selected':''}>${e[0]}</option>`).join"
"(''),A=(e,t,$,r='')=>`<input type='checkbox' name='${e}' value=${t} ${($&t)==t?'checked"
"':''}>${r}`,S=()=>{let r=new FormData(i),n=e=>r.getAll(e).map(e=>c(e)).reduce((e,t)=>e|"
"t,0);return t.forEach(e=>r.set(e,u(r.get(e).split('.')))),$.forEach(e=>r.set(e,_(r.get("
"e),4))),r.set('d00',r.get('d00').toLowerCase().replace(/[:-]/g,'')),r.set('h00',u(f(e.h"
"00).map((e,t)=>{let $='p'+t,o=n($);return r.delete($),o}))),r.set('g00',u([n('g00')])),"
"r},T=(e,t,$)=>{let r=new XMLHttpRequest;r.open(e,t,!1),r.send($)},j=()=>l.href='/60',k="
"()=>l.href='/63',v=()=>l.href='/61',w=()=>{a.body.innerText='Wait 5s...',setTimeout(v,5"
"e3)},B=()=>{T('GET','/91'),w()},D=e=>{e.preventDefault();let t=Array.from(S().entries()"
",([e,t])=>`${b(e)}=${b(t)}`).join('&');T('POST','/',t+'&z00=0'),w()},q=f(e.g00)[0],z={r"
"equired:!0};return x('.ip',e=>{E(e,{...z,title:'x.x.x.x format',pattern:'((25[0-5]|(2[0"
"-4]|1[0-9]|[1-9]|)[0-9])([.](?!$)|$)){4}'})}),x('.port',e=>{E(e,{...z,type:'number',min"
":10,max:65535})}),x('.up input',e=>{E(e,{title:'0 to 10 letters, numbers, and -_*. no s"
"paces. Blank for no entry.',maxlength:10,pattern:'[0-9a-zA-Z-_*.]{0,10}$'})}),t.forEach"
"(t=>g(t,f(e[t]).join('.'))),$.forEach(t=>g(t,c(e[t],16))),g('d00',e.d00.replace(/[0-9a-"
"z]{2}(?!$)/g,'$&:')),f(e.h00).forEach((e,t)=>{let $=(3&e)!=0?A('p'+t,4,e):'',r=(3&e)==3"
"||(3&e)==2&&t>7?`<select name='p${t}'>${y(o,24&e)}</select>`:'',a='#d'==l.hash?`<td>${e"
"}</td>`:'';s(`<tr><td>#${t+1}</td><td><select name='p${t}'>${y(n,3&e)}</select></td><td"
">${$}</td><td>${r}</td>${a}</tr>`)}),p('.f').innerHTML=Array.from(d(r),([e,t])=>A('g00'"
",t,q,e)).join('</br>'),{r:B,s:D,l:v,i:j,p:k}})({b00:'%b00',b04:'%b04',b08:'%b08',c00:'%"
"c00',d00:'%d00',b12:'%b12',c01:'%c01',h00:'%h00',g00:'%g00'});"
      "%y01"
      "<p>"
      "Pinout Option %w01<br/>"
      "Code Revision %w00<br/>"
      "<a href='https://github.com/nielsonm236/NetMod-ServerApp/wiki'>Help Wiki</a>"
      "</p>"
      "%y02'm.r()'>Reboot</button>"
      "<br><br>"
      "%y02'm.l()'>Refresh</button>"
      "<br><br>"
      "%y02'm.i()'>IO Control</button> "
      "%y02'm.p()'>PCF8574 Configuration</button>"
   "</body>"
"</html>";
#endif // OB_EEPROM_SUPPORT == 0

#if OB_EEPROM_SUPPORT == 1
// Declared short static const here so that common code can be used for Flash
// and I2C EEPROM webpage sources.
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
        features = { "Full Duplex": 1, "HA Auto": 6, "MQTT": 4, "DS18B20": 8, "BME280": 32, "Disable Cfg Button": 16 },
        pin_types = { "disabled": 0, "input": 1, "output": 3, "linked": 2 },
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
        ioc_page = () => loc.href = '/60',
        cfg_page_pcf = () => loc.href = '/63',
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
        const
            invert_checkbox = (n & 3) != 0 ? make_checkbox('p'+i, 4, n) : '',
            make_select = (n & 3) == 3 || ((n & 3) == 2 && i > 7) ? `<select name='p${i}'>${make_options(boot_state, n & 24)}</select>` : '',
            debug_column = (loc.hash == '#d'?`<td>${n}</td>`:'');
        document_write(`<tr><td>#${i + 1}</td><td><select name='p${i}'>${make_options(pin_types, n & 3)}</select></td><td>${invert_checkbox}</td><td>${make_select}</td>${debug_column}</tr>`);
    });
    
    selector(".f").innerHTML = Array.from(
    	get_entries(features),
      ([name, bit]) => make_checkbox('g00', bit, features_data, name)).join("</br>"
    );
        
    return {r:reboot, s: submitForm, l:reload_page, i:ioc_page, p:cfg_page_pcf};
})
({
    b00: "c0a80004",
    b04: "c0a80101",
    b08: "ffffff00",
    c00: "0050",
    d00: "aabbccddeeff",
    b12: "c0a80005",
    c01: "075b",
    h00: "00020305070b0f131617000000000000",
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
#define WEBPAGE_IOCONTROL			1
#define PARSEBYTES_IOCONTROL			42
#define BROWSER_ONLY_WEBPAGE_IOCONTROL_BEGIN	92
// The BROWSER_ONLY_WEBPAGE_IOCONTROL_BEGIN define is used only by the "prepsx"
// strings pre-processor program. The define is used by the prepsx program as
// a keyword for locating the webpage text contained in the static const
// below. The prepsx program extracts the HTML "string" and places it in an
// SREC (.sx) file. The HTML strings in the .sx file are uploaded into the I2C
// EEPROM for subsequent use in generating webpages from the I2C EEPROM
// instead of generating them from Flash.
// Next #if: Only place the HTML in Flash if the I2C EEPROM is not supported.
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
"const m=(t=>{let $=document,e=location,j=$.querySelector.bind($),r=j('form'),h=(Object."
"entries,parseInt),_=t=>$.write(t),a=(t,$)=>h(t).toString(16).padStart($,'0'),n=t=>t.map"
"(t=>a(t,2)).join(''),s=t=>t.match(/.{2}/g).map(t=>h(t,16)),d=t=>encodeURIComponent(t),l"
"=[],o=[],c=(t,$,e)=>{var j;return`<label><input type=radio name=o${$} value=${t} ${e==t"
"?'checked':''}/>${(t?'on':'off').toUpperCase()}</label>`},p=()=>{let $=new FormData(r);"
"return $.set('h00',n(s(t.h00).map((t,e)=>{let j='o'+e,r=$.get(j)<<7;return $.delete(j),"
"r}))),$},f=s(t.g00)[0];return 16&f?(cfg_page=()=>e.href='/60',cfg_page_pcf=()=>e.href='"
"/60'):(cfg_page=()=>e.href='/61',cfg_page_pcf=()=>e.href='/63'),ioc_page_pcf=()=>e.href"
"='/62',reload_page=()=>e.href='/60',submit_form=t=>{t.preventDefault();let $=new XMLHtt"
"pRequest,e=Array.from(p().entries(),([t,$])=>`${d(t)}=${d($)}`).join('&');$.open('POST'"
",'/',!1),$.send(e+'&z00=0'),reload_page()},s(t.h00).forEach(($,e)=>{var j=t['j'+(e+'')."
"padStart(2,'0')];(3&$)==3?o.push(`<tr><td>${j}</td><td class='s${$>>7} t3'></td><td cla"
"ss=c>${c(1,e,$>>7)}${c(0,e,$>>7)}</td></tr>`):(3&$)==1&&l.push(`<tr><td>${j}</td><td cl"
"ass='s${$>>7} t3'></td><td/></tr>`)}),_(l.join('')),_(`<tr><th></th><th></th>${o.length"
">0?'<th class=c>SET</th>':''}</tr>`),_(o.join('')),{s:submit_form,l:reload_page,c:cfg_p"
"age,j:ioc_page_pcf}})({h00:'%h00',g00:'%g00',j00:'%j00',j01:'%j01',j02:'%j02',j03:'%j03"
"',j04:'%j04',j05:'%j05',j06:'%j06',j07:'%j07',j08:'%j08',j09:'%j09',j10:'%j10',j11:'%j1"
"1',j12:'%j12',j13:'%j13',j14:'%j14',j15:'%j15'});"
      "%y01"
      "%y02'm.l()'>Refresh</button> "
      "<br><br>"
      "%y02'm.c()'>Configuration</button> "
      "%y02'm.j()'>PCF8574 IO Control</button> "
      "<pre>%t00%t01%t02%t03%t04%t05</pre>"
   "</body>"
"</html>";
#endif // OB_EEPROM_SUPPORT == 0

#if OB_EEPROM_SUPPORT == 1
// Declared short static const here so that common code can be used for Flash
// and I2C EEPROM webpage sources.
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
        loc = location,
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
          cfg_page = () => loc.href = '/60';
          cfg_page_pcf = () => loc.href = '/60';
        } else {
          cfg_page = () => loc.href = '/61';        
          cfg_page_pcf = () => loc.href = '/63';        
        }

        ioc_page_pcf = () => loc.href = '/62',
        reload_page = () => loc.href = '/60',
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
    
    return {s: submit_form, l:reload_page, c:cfg_page, j:ioc_page_pcf}
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
#define WEBPAGE_CONFIGURATION				2
#define PARSEBYTES_CONFIGURATION			602
#define BROWSER_ONLY_WEBPAGE_CONFIGURATION_BEGIN	93
// The BROWSER_ONLY_WEBPAGE_CONFIGURATION_BEGIN define is used only by the
// "prepsx" strings pre-processor program. The define is used by the prepsx
// program as a keyword for locating the webpage text contained in the static
// const below. The prepsx program extracts the HTML "string" and places it in
// an SREC (.sx) file. The HTML strings in the .sx file are uploaded into the
// I2C EEPROM for subsequent use in generating webpages from the I2C EEPROM
// instead of generating them from Flash.
// Next #if: Only place the HTML in Flash if the I2C EEPROM is not supported.
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
"const m=($=>{let e=['b00','b04','b08'],t=['c00'],i={'Full Duplex':1,DS18B20:8,BME280:32"
",'Disable Cfg Button':16},_={disabled:0,input:1,output:3,linked:2},r={retain:8,on:16,of"
"f:0},n={'0.1s':0,'1s':16384,'1m':32768,'1h':49152},a=document,l=location,j=a.querySelec"
"tor.bind(a),o=j('form'),d=Object.entries,p=parseInt,s=$=>a.write($),c=($,e)=>p($).toStr"
"ing(16).padStart(e,'0'),f=$=>$.map($=>c($,2)).join(''),u=$=>$.match(/.{2}/g).map($=>p($"
",16)),h=$=>encodeURIComponent($),b=$=>j(`input[name=${$}]`),g=($,e)=>b($).value=e,x=($,"
"e)=>{for(let t of a.querySelectorAll($))e(t)},S=($,e)=>{for(let[t,i]of d(e))$.setAttrib"
"ute(t,i)},E=($,e)=>d($).map($=>`<option value=${$[1]} ${$[1]==e?'selected':''}>${$[0]}<"
"/option>`).join(''),v=($,e,t,i='')=>`<input type='checkbox' name='${$}' value=${e} ${(t"
"&e)==e?'checked':''}>${i}`,y=()=>{let i=new FormData(o),_=$=>i.getAll($).map($=>p($)).r"
"educe(($,e)=>$|e,0);e.forEach($=>i.set($,f(i.get($).split('.')))),t.forEach($=>i.set($,"
"c(i.get($),4))),i.set('d00',i.get('d00').toLowerCase().replace(/[:-]/g,'')),i.set('h00'"
",f(u($.h00).map(($,e)=>{let t='p'+e,r=_(t);return i.delete(t),r})));for(let r=0;r<16;r+"
"+){let n=(''+r).padStart(2,'0');i.set('i'+n,c(65535&_('i'+n),4))}return i.set('g00',f(["
"_('g00')])),i},q=($,e,t)=>{let i=new XMLHttpRequest;i.open($,e,!1),i.send(t)},w=()=>loc"
"ation.href='/60',A=()=>l.href='/63',D=()=>l.href='/61',T=()=>{a.body.innerText='Wait 5s"
"...',setTimeout(D,5e3)},k=()=>{q('GET','/91'),T()},z=$=>{$.preventDefault();let e=Array"
".from(y().entries(),([$,e])=>`${h($)}=${h(e)}`).join('&');q('POST','/',e+'&z00=0'),T()}"
",B=u($.g00)[0],C={required:!0};return x('.ip',$=>{S($,{...C,title:'x.x.x.x format',patt"
"ern:'((25[0-5]|(2[0-4]|1[0-9]|[1-9]|)[0-9])([.](?!$)|$)){4}'})}),x('.port',$=>{S($,{..."
"C,type:'number',min:10,max:65535})}),e.forEach(e=>g(e,u($[e]).join('.'))),t.forEach(e=>"
"g(e,p($[e],16))),g('d00',$.d00.replace(/[0-9a-z]{2}(?!$)/g,'$&:')),u($.h00).forEach((e,"
"t)=>{let i=(3&e)!=0?v('p'+t,4,e):'',a=($,i)=>(3&e)==3||(3&e)==2&&t>7?$:i,j=(''+t).padSt"
"art(2,'0'),o=a(u($['i'+j]).reduce(($,e)=>($<<8)+e),0),d=a(`<select name='p${t}'>${E(r,2"
"4&e)}</select>`,''),p='#d'==l.hash?`<td>${e}</td>`:'',c=a(`<input type=number class=t8 "
"name='i${j}' value='${16383&o}' min=0 max=16383><select name='i${j}'>${E(n,49152&o)}</s"
"elect>`,'');s(`<tr><td>#${t+1}</td><td><select name='p${t}'>${E(_,3&e)}</select></td><t"
"d><input name='j${j}' value='${$['j'+j]}' pattern='[0-9a-zA-Z_*.-]{1,15}' required titl"
"e='1 to 15 letters, numbers, and -*_. no spaces' maxlength=15/></td><td>${i}</td><td>${"
"d}</td><td>${c}</td>${p}</tr>`)}),j('.f').innerHTML=Array.from(d(i),([$,e])=>v('g00',e,"
"B,$)).join('</br>'),{r:k,s:z,l:D,i:w,p:A}})({b00:'%b00',b04:'%b04',b08:'%b08',c00:'%c00"
"',d00:'%d00',h00:'%h00',g00:'%g00',j00:'%j00',j01:'%j01',j02:'%j02',j03:'%j03',j04:'%j0"
"4',j05:'%j05',j06:'%j06',j07:'%j07',j08:'%j08',j09:'%j09',j10:'%j10',j11:'%j11',j12:'%j"
"12',j13:'%j13',j14:'%j14',j15:'%j15',i00:'%i00',i01:'%i01',i02:'%i02',i03:'%i03',i04:'%"
"i04',i05:'%i05',i06:'%i06',i07:'%i07',i08:'%i08',i09:'%i09',i10:'%i10',i11:'%i11',i12:'"
"%i12',i13:'%i13',i14:'%i14',i15:'%i15'});"
      "%y01"
      "<p>"
      "Pinout Option %w01<br/>"
      "Code Revision %w00<br/>"
      "<a href='https://github.com/nielsonm236/NetMod-ServerApp/wiki'>Help Wiki</a>"
      "</p>"
      "%y02'm.r()'>Reboot</button>"
      "<br><br>"
      "%y02'm.l()'>Refresh</button>"
      "<br><br>"
      "%y02'm.i()'>IO Control</button> "
      "%y02'm.p()'>PCF8574 Configuration</button>"
   "</body>"
"</html>";
#endif // OB_EEPROM_SUPPORT == 0

#if OB_EEPROM_SUPPORT == 1
// Declared short static const here so that common code can be used for Flash
// and I2C EEPROM webpage sources.
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
        features = { "Full Duplex": 1, "DS18B20": 8, "BME280": 32, "Disable Cfg Button": 16 },
        pin_types = { "disabled": 0, "input": 1, "output": 3, "linked": 2 },
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
        ioc_page = () => location.href = '/60',
        cfg_page_pcf = () => loc.href = '/63',
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
        const
            invert_checkbox = (n & 3) != 0 ? make_checkbox('p'+i, 4, n) : '',
            if_output = (a,b) => (n & 3) == 3 || ((n & 3) == 2 && i > 7) ? a: b,
        		input_nr = (''+i).padStart(2, '0'),
            timer_int_value = if_output(convert_from_hex(data['i'+input_nr]).reduce((prev, cur)=>(prev<<8)+cur), 0),
            boot_state_select = if_output(`<select name='p${i}'>${make_options(boot_state, n & 24)}</select>`,''),
            debug_column = (loc.hash == '#d'?`<td>${n}</td>`:''),
            timer_column = if_output(`<input type=number class=t8 name='i${input_nr}' value='${timer_int_value & 0x3fff}' min=0 max=16383><select name='i${input_nr}'>${make_options(timer_unit, timer_int_value & 0xc000)}</select>`,'');
        document_write(`<tr><td>#${i + 1}</td><td><select name='p${i}'>${make_options(pin_types, n & 3)}</select></td><td><input name='j${input_nr}' value='${data['j'+input_nr]}' pattern='[0-9a-zA-Z_*.-]{1,15}' required title='1 to 15 letters, numbers, and -*_. no spaces' maxlength=15/></td><td>${invert_checkbox}</td><td>${boot_state_select}</td><td>${timer_column}</td>${debug_column}</tr>`);
    });
    
    selector(".f").innerHTML = Array.from(get_entries(features),([name, bit]) => make_checkbox('g00', bit, features_data, name)).join("</br>");
    
    return {r:reboot, s: submitForm, l:reload_page, i:ioc_page,  p:cfg_page_pcf};
})
({
    b00: "c0a80004",
    b04: "c0a80101",
    b08: "ffffff00",
    c00: "0050",
    d00: "aabbccddeeff",
    h00: "00020305070b0f131617010000000000",
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



//---------------------------------------------------------------------------//
//---------------------------------------------------------------------------//
//---------------------------------------------------------------------------//
// Following are the webpages for the PCF8574 Configuration and IOControl
//---------------------------------------------------------------------------//
//---------------------------------------------------------------------------//
//---------------------------------------------------------------------------//



//---------------------------------------------------------------------------//
#if BUILD_SUPPORT == MQTT_BUILD
// IO Control Template for PCF8574
// This template is only used when an I2C EEPROM is included in the hardware
// configuration.
//
// PARSE_BYTES calculation:
// The form contained in this webpage will generate several data update
// replies. These replies need to be parsed to extract the data from them. We
// need to stop parsing the reply POST data after all update bytes are parsed.
// The formula for determining the stop value is as follows:
//   For 1 of the replies (Pin Control):
//   POST consists of a ParseCmd (a "H" in this case) in 1 byte
//     Followed by the ParseNum in 2 bytes
//     Followed by an equal sign in 1 byte
//     Followed by a state value in 16 bytea
//     Followed by a parse delimiter in 1 byte
//   PLUS
//   For 1 of the replies (hidden):
//   POST consists of a ParseCmd (a "z" in this case) in 1 byte
//     Followed by the ParseNum in 2 bytes
//     Followed by an equal sign in 1 byte
//     Followed by a state value in 1 byte
//     Note; No trailing parse delimiter
// THUS
// For 1 of the replies there are 37 bytes in the reply
// For 1 of the replies there are 6 bytes per reply
// The formula in this case is
//     PARSEBYTES = (1 x 21)
//                + (1 x 5)
//     PARSEBYTES = 21
//                + 5 = 26
//
#define WEBPAGE_PCF8574_IOCONTROL		21
#define PARSEBYTES_PCF8574_IOCONTROL		26
#define MQTT_WEBPAGE_PCF8574_IOCONTROL_BEGIN    95
// The MQTT_WEBPAGE_PCF8574_IOCONTROL_BEGIN define is used only by the
// "prepsx" strings pre-processor program. The define is used by the prepsx
// program as a keyword for locating the webpage text contained in the static
// const below. The prepsx program extracts the HTML "string" and places it in
// an SREC (.sx) file. The HTML strings in the .sx file are uploaded into the
// I2C EEPROM for subsequent use in generating webpages from the I2C EEPROM
// instead of generating them from Flash.
// Next #if: Only place the HTML in Flash if the I2C EEPROM is not supported.
// Comment: This HTML is NEVER placed in Flash, as the PCF8574 is supported
// only when the I2C EEPROM is present. Thus the build configuration will
// have OB_EEPROM_SUPPORT = 1 when PCF8574_SUPPORT = 1.
#if OB_EEPROM_SUPPORT == 0
#if PCF8574_SUPPORT == 1
static const char g_HtmlPagePCFIOControl[] =
"%y04%y05"
      "<title>%A00: PCF8574 IO Control</title>"
   "</head>"
   "<body>"
      "<h1>PCF8574 IO Control</h1>"
      "<form onsubmit='return m.s(event);return false'>"
         "<table>"
            "<tr>"
               "<th>Name:</th>"
               "<td colspan=2 style='text-align: left'>%A00</td>"
            "</tr>"
            "<script>"
"const m=(t=>{let e=document,r=location,$=e.querySelector.bind(e),n=$('form'),a=(Object."
"entries,parseInt),s=t=>e.write(t),h=(t,e)=>a(t).toString(16).padStart(e,'0'),l=t=>t.map"
"(t=>h(t,2)).join(''),d=t=>t.match(/.{2}/g).map(t=>a(t,16)),o=t=>encodeURIComponent(t),p"
"=[],c=[],u=(t,e,r)=>{var $;return`<label><input type=radio name=o${e} value=${t} ${r==t"
"?'checked':''}/>${(t?'on':'off').toUpperCase()}</label>`},f=()=>{let e=new FormData(n);"
"return e.set('H00',l(d(t.H00).map((t,r)=>{let $='o'+r,n=e.get($)<<7;return e.delete($),"
"n}))),e},i=d(t.g00)[0];return 16&i?(cfg_page=()=>r.href='/62',cfg_page_pcf=()=>r.href='"
"/62'):(cfg_page=()=>r.href='/61',cfg_page_pcf=()=>r.href='/63'),ioc_page=()=>r.href='/6"
"0',reload_page=()=>r.href='/62',submit_form=t=>{t.preventDefault();let e=new XMLHttpReq"
"uest,r=Array.from(f().entries(),([t,e])=>`${o(t)}=${o(e)}`).join('&');e.open('POST','/'"
",!1),e.send(r+'&z00=0'),reload_page()},d(t.H00).forEach((t,e)=>{(3&t)==3?c.push(`<tr><t"
"d>Output #${e+17}</td><td class='s${t>>7} t3'></td><td class=c>${u(1,e,t>>7)}${u(0,e,t>"
">7)}</td></tr>`):(3&t)==1&&p.push(`<tr><td>Input #${e+17}</td><td class='s${t>>7} t3'><"
"/td><td/></tr>`)}),s(p.join('')),s(`<tr><th></th><th></th>${c.length>0?'<th class=c>SET"
"</th>':''}</tr>`),s(c.join('')),{s:submit_form,l:reload_page,c:cfg_page,p:cfg_page_pcf,"
"i:ioc_page}})({H00:'%H00',g00:'%g00'});"
      "%y01"
      "<p>"
      "%y02'm.l()'>Refresh</button>"
      "<br><br>"
      "%y02'm.i()'>IO Control</button>"
      "<br><br>"
      "%y02'm.p()'>PCF8574 Configuration</button> "
      "%y02'm.c()'>Configuration</button>"
      "</p>"
   "</body>"
"</html>";
#endif // PCF8574_SUPPORT == 1
#endif // OB_EEPROM_SUPPORT == 0

#if OB_EEPROM_SUPPORT == 1
#if PCF8574_SUPPORT == 1
// Declared short static const here so that common code can be used for Flash
// and I2C EEPROM webpage sources.
static const char g_HtmlPagePCFIOControl[] = " ";
#endif // PCF8574_SUPPORT == 1
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
        loc = location,
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
            form_data.set('H00', convert_to_hex(convert_from_hex(data.H00).map((_, i) => {
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
          cfg_page = () => loc.href = '/62';
          cfg_page_pcf = () => loc.href = '/62';
        } else {
          cfg_page = () => loc.href = '/61';        
          cfg_page_pcf = () => loc.href = '/63';        
        }

        ioc_page = () => loc.href = '/60',

        reload_page = () => loc.href = '/62',
        submit_form = (event) => {
        	event.preventDefault();

          const request = new XMLHttpRequest(),
              string_data = Array.from(get_form_data().entries(), ([k, v]) => `${encode(k)}=${encode(v)}`).join('&');
          request.open('POST', '/', false);
          request.send(string_data + '&z00=0');
          reload_page();
        };
        

    convert_from_hex(data.H00).forEach((cfg, i) => {
        if ((cfg & 3) == 3) { //output
            outputs.push(`<tr><td>Output #${i + 17}</td><td class='s${cfg >> 7} t3'></td><td class=c>${make_radio_input(1, i, cfg >> 7)}${make_radio_input(0, i, cfg >> 7)}</td></tr>`);
        } else if ((cfg & 3) == 1) { // input
            inputs.push(`<tr><td>Input #${i + 17}</td><td class='s${cfg >> 7} t3'></td><td/></tr>`);
        }
    });

    document_write(inputs.join(''));
    document_write(`<tr><th></th><th></th>${outputs.length > 0 ? '<th class=c>SET</th>' : ''}</tr>`);
    document_write(outputs.join(''));
    
    return {s: submit_form, l:reload_page, c:cfg_page, p:cfg_page_pcf, i:ioc_page}
})
({
  H00: '01010305070b0f13',
  g00: '14',
});

*/
#endif // BUILD_SUPPORT == MQTT_BUILD


#if BUILD_SUPPORT == MQTT_BUILD
// Configuration webpage Template for PCF8574
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
//   For 1 of the replies (Pin Control):
//     example: h00=xxxxxxxxxxxxxxxx&
//     where xxxxxxxxxxxxxxxx is 16 bytes
//   PLUS
//   For 1 of the replies (hidden):
//   POST consists of a ParseCmd (a "z" in this case) in 1 byte
//     example: z00=x (note no &)
//     where x is 1 byte
// The formula in this case is
//     PARSEBYTES = (1 x 24)
//                + (1 x 21)
//                + (1 x 5)
//     PARSEBYTES = 24
//                + 21
//                + 5 = 50
//
#define WEBPAGE_PCF8574_CONFIGURATION			22
#define PARSEBYTES_PCF8574_CONFIGURATION		50
#define MQTT_WEBPAGE_PCF8574_CONFIGURATION_BEGIN	96
// The MQTT_WEBPAGE_PCF8574_CONFIGURATION_BEGIN define is used only by the
// "prepsx" strings pre-processor program. The define is used by the prepsx
// program as a keyword for locating the webpage text contained in the static
// const below. The prepsx program extracts the HTML "string" and places it in
// an SREC (.sx) file. The HTML strings in the .sx file are uploaded into the
// I2C EEPROM for subsequent use in generating webpages from the I2C EEPROM
// instead of generating them from Flash.
// Next #if: Only place the HTML in Flash if the I2C EEPROM is not supported.
// Comment: This HTML is NEVER placed in Flash, as the PCF8574 is supported
// only when the I2C EEPROM is present. Thus the build configuration will
// have OB_EEPROM_SUPPORT = 1 when PCF8574_SUPPORT = 1.
#if OB_EEPROM_SUPPORT == 0
#if PCF8574_SUPPORT == 1
static const char g_HtmlPagePCFConfiguration[] =
"%y04%y05"
      "<title>%A00: PCF8574 Configuration</title>"
   "</head>"
   "<body>"
      "<h1>PCF8574 Configuration</h1>"
      "<form onsubmit='return m.s(event);return false'>"
         "<table>"
            "<tr>"
               "<td>Name</td>"
               "<td><input name='A00' value='%A00' pattern='[0-9a-zA-Z-_*.]{1,19}' required title='1 to 19 letters, numbers, and -_*. no spaces' maxlength='19'/></td>"
            "</tr>"
         "</table>"
         "<table>"
            "<tr>"
              "<th>IO</th>"
              "<th>Type</th>"
              "<th>Invert</th>"
              "<th>Boot state</th>"
            "</tr>"
         "<script>"
"const m=(e=>{let t={disabled:0,input:1,output:3,linked:2},n={retain:8,on:16,off:0},r=do"
"cument,$=location,d=r.querySelector.bind(r),l=d('form'),a=Object.entries,o=parseInt,i=e"
"=>r.write(e),p=(e,t)=>o(e).toString(16).padStart(t,'0'),c=e=>e.map(e=>p(e,2)).join(''),"
"s=e=>e.match(/.{2}/g).map(e=>o(e,16)),u=e=>encodeURIComponent(e),f=(e,t)=>a(e).map(e=>`"
"<option value=${e[1]} ${e[1]==t?'selected':''}>${e[0]}</option>`).join(''),h=(e,t,n,r='"
"')=>`<input type='checkbox' name='${e}' value=${t} ${(n&t)==t?'checked':''}>${r}`,_=()="
">{let t=new FormData(l),n=e=>t.getAll(e).map(e=>o(e)).reduce((e,t)=>e|t,0);return t.set"
"('H00',c(s(e.H00).map((e,r)=>{let $='p'+r,d=n($);return t.delete($),d}))),t},H=(e,t,n)="
">{let r=new XMLHttpRequest;r.open(e,t,!1),r.send(n)},b=()=>$.href='/60',j=()=>$.href='/"
"61',S=()=>$.href='/62',g=()=>$.href='/63',k=()=>{r.body.innerText='Wait 5s...',setTimeo"
"ut(g,5e3)},v=()=>{H('GET','/91'),k()},w=e=>{e.preventDefault();let t=Array.from(_().ent"
"ries(),([e,t])=>`${u(e)}=${u(t)}`).join('&');H('POST','/',t+'&z00=0'),k()};return s(e.H"
"00).forEach((e,r)=>{let d=(3&e)!=0?h('p'+r,4,e):'',l=(3&e)==3||(3&e)==2&&r>3?`<select n"
"ame='p${r}'>${f(n,24&e)}</select>`:'',a='#d'==$.hash?`<td>${e}</td>`:'';i(`<tr><td>#${r"
"+17}</td><td><select name='p${r}'>${f(t,3&e)}</select></td><td>${d}</td><td>${l}</td>${"
"a}</tr>`)}),{r:v,s:w,l:g,c:j,i:b,j:S}})({H00:'%H00'});"
      "%y01"
      "<p>"
      "%y02'm.r()'>Reboot</button>"
      "<br><br>"
      "%y02'm.l()'>Refresh</button>"
      "<br><br>"
      "%y02'm.c()'>Configuration</button>"
      "<br><br>"
      "%y02'm.j()'>PCF8574 IO Control</button> "
      "%y02'm.i()'>IO Control</button> "
      "</p>"
    "</body>"
"</html>";
#endif // PCF8574_SUPPORT == 1
#endif // OB_EEPROM_SUPPORT == 0

#if OB_EEPROM_SUPPORT == 1
#if PCF8574_SUPPORT == 1
// Declared short static const here so that common code can be used for Flash
// and I2C EEPROM webpage sources.
static const char g_HtmlPagePCFConfiguration[] = " ";
#endif // PCF8574_SUPPORT == 1
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
    const
        pin_types = { "disabled": 0, "input": 1, "output": 3, "linked": 2 },
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
        make_options = (o, v) => get_entries(o).map((o) => `<option value=${o[1]} ${o[1] == v ? 'selected' : ''}>${o[0]}</option>`).join(''),
        make_checkbox = (name, bit, value, title='') => `<input type="checkbox" name='${name}' value=${bit} ${(value & bit) == bit ? 'checked' : ''}>${title}`,
        get_form_data = () => {
            const form_data = new FormData(form),
            	collect_bits = (name) => form_data.getAll(name).map(v => parse_int(v)).reduce((a, b) => a | b, 0);
              
            form_data.set('H00', convert_to_hex(convert_from_hex(data.H00).map((_, i) => {
                const name = 'p' + i,
                    result = collect_bits(name);
                form_data.delete(name);
                return result;
            })));
            
            return form_data;
        },
        send_request = (method, url, data) => {
        	const request = new XMLHttpRequest();
          request.open(method, url, false);
          request.send(data);
        },
        
        ioc_page = () => loc.href = '/60',
        cfg_page = () => loc.href = '/61',
        ioc_page_pcf = () => loc.href = '/62',
        reload_page = () => loc.href = '/63',
        
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
        
        common_attributes = {required: true};

    convert_from_hex(data.H00).forEach((n, i) => {
        const
            invert_checkbox = (n & 3) != 0 ? make_checkbox('p'+i, 4, n) : '',
            make_select = (n & 3) == 3 || ((n & 3) == 2 && i > 3) ? `<select name='p${i}'>${make_options(boot_state, n & 24)}</select>` : '',
            debug_column = (loc.hash == '#d'?`<td>${n}</td>`:'');
        document_write(`<tr><td>#${i + 17}</td><td><select name='p${i}'>${make_options(pin_types, n & 3)}</select></td><td>${invert_checkbox}</td><td>${make_select}</td>${debug_column}</tr>`);
    });
    
    return {r:reboot, s: submitForm, l:reload_page, c:cfg_page, i:ioc_page, j:ioc_page_pcf};
})
({
    H00: "00020305070b0f13",
});

*/
#endif // BUILD_SUPPORT == MQTT_BUILD



//---------------------------------------------------------------------------//

#if BUILD_SUPPORT == BROWSER_ONLY_BUILD
// IO Control Template for PCF8574
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
//     POST consists of 16 bytes data plus 5 byte wrapper (21 bytes)
//   PLUS
//     For 1 of the replies (hidden):
//     example: z00=x where x is 1 byte (note no &)
//     POST consists of a 1 byte data plus 4 byte wrapper (5 bytes)
// THUS
// The formula in this case is
//     PARSEBYTES = (1 x 21)
//                + (1 x 5)
//     PARSEBYTES = 21
//                + 5 = 26
//
#define WEBPAGE_PCF8574_IOCONTROL			21
#define PARSEBYTES_PCF8574_IOCONTROL			26
#define BROWSER_ONLY_WEBPAGE_PCF8574_IOCONTROL_BEGIN	97
// The BROWSER_ONLY_WEBPAGE_PCF8574_IOCONTROL_BEGIN define is used only by the
// "prepsx" strings pre-processor program. The define is used by the prepsx
// program as a keyword for locating the webpage text contained in the static
// const below. The prepsx program extracts the HTML "string" and places it in
// an SREC (.sx) file. The HTML strings in the .sx file are uploaded into the
// I2C EEPROM for subsequent use in generating webpages from the I2C EEPROM
// instead of generating them from Flash.
// Next #if: Only place the HTML in Flash if the I2C EEPROM is not supported.
// Comment: This HTML is NEVER placed in Flash, as the PCF8574 is supported
// only when the I2C EEPROM is present. Thus the build configuration will
// have OB_EEPROM_SUPPORT = 1 when PCF8574_SUPPORT = 1.
#if OB_EEPROM_SUPPORT == 0
#if PCF8574_SUPPORT == 1
static const char g_HtmlPagePCFIOControl[] =
"%y04%y05"
      "<title>%A00: PCF8574 IO Control</title>"
   "</head>"
   "<body>"
      "<h1>PCF8574 IO Control</h1>"
      "<form onsubmit='return m.s(event);return false'>"
         "<table>"
            "<tr>"
               "<th>Name:</th>"
               "<td colspan=2 style='text-align: left'>%A00</td>"
            "</tr>"
            "<script>"
"const m=(t=>{let e=document,r=location,$=e.querySelector.bind(e),a=$('form'),n=(Object."
"entries,parseInt),s=t=>e.write(t),d=(t,e)=>n(t).toString(16).padStart(e,'0'),h=t=>t.map"
"(t=>d(t,2)).join(''),l=t=>t.match(/.{2}/g).map(t=>n(t,16)),_=t=>encodeURIComponent(t),o"
"=[],J=[],p=(t,e,r)=>{var $;return`<label><input type=radio name=o${e} value=${t} ${r==t"
"?'checked':''}/>${(t?'on':'off').toUpperCase()}</label>`},c=()=>{let e=new FormData(a);"
"return e.set('H00',h(l(t.H00).map((t,r)=>{let $='o'+r,a=e.get($)<<7;return e.delete($),"
"a}))),e},f=l(t.g00)[0];return 16&f?(cfg_page=()=>r.href='/62',cfg_page_pcf=()=>r.href='"
"/62'):(cfg_page=()=>r.href='/61',cfg_page_pcf=()=>r.href='/63'),ioc_page=()=>r.href='/6"
"0',reload_page=()=>r.href='/62',submit_form=t=>{t.preventDefault();let e=new XMLHttpReq"
"uest,r=Array.from(c().entries(),([t,e])=>`${_(t)}=${_(e)}`).join('&');e.open('POST','/'"
",!1),e.send(r+'&z00=0'),reload_page()},l(t.H00).forEach((e,r)=>{var $=t['J'+(16+r+'').p"
"adStart(2,'0')];(3&e)==3?J.push(`<tr><td>${$}</td><td class='s${e>>7} t3'></td><td clas"
"s=c>${p(1,r,e>>7)}${p(0,r,e>>7)}</td></tr>`):(3&e)==1&&o.push(`<tr><td>${$}</td><td cla"
"ss='s${e>>7} t3'></td><td/></tr>`)}),s(o.join('')),s(`<tr><th></th><th></th>${J.length>"
"0?'<th class=c>SET</th>':''}</tr>`),s(J.join('')),{s:submit_form,l:reload_page,c:cfg_pa"
"ge,p:cfg_page_pcf,i:ioc_page}})({H00:'%H00',g00:'%g00',J16:'%J16',J17:'%J17',J18:'%J18'"
",J19:'%J19',J20:'%J20',J21:'%J21',J22:'%J22',J23:'%J23'});"
      "%y01"
      "%y02'm.l()'>Refresh</button> "
      "<br><br>"
      "%y02'm.i()'>IO Control</button>"
      "<br><br>"
      "%y02'm.p()'>PCF8574 Configuration</button> "
      "%y02'm.c()'>Configuration</button> "
   "</body>"
"</html>";
#endif // PCF8574_SUPPORT == 1
#endif // OB_EEPROM_SUPPORT == 0

#if OB_EEPROM_SUPPORT == 1
#if PCF8574_SUPPORT == 1
// Declared short static const here so that common code can be used for Flash
// and I2C EEPROM webpage sources.
static const char g_HtmlPagePCFIOControl[] = " ";
#endif // PCF8574_SUPPORT == 1
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
        loc = location,
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
            form_data.set('H00', convert_to_hex(convert_from_hex(data.H00).map((_, i) => {
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
          cfg_page = () => loc.href = '/62';
          cfg_page_pcf = () => loc.href = '/62';
        } else {
          cfg_page = () => loc.href = '/61';        
          cfg_page_pcf = () => loc.href = '/63';        
        }

        ioc_page = () => loc.href = '/60',

        reload_page = () => loc.href = '/62',
        submit_form = (event) => {
        	event.preventDefault();

          const request = new XMLHttpRequest(),
              string_data = Array.from(get_form_data().entries(), ([k, v]) => `${encode(k)}=${encode(v)}`).join('&');
          request.open('POST', '/', false);
          request.send(string_data + '&z00=0');
          reload_page();
        };
        

    convert_from_hex(data.H00).forEach((cfg, i) => {
    		var name = data['J'+(16+i+'').padStart(2, '0')];
        if ((cfg & 3) == 3) { //output
            outputs.push(`<tr><td>${name}</td><td class='s${cfg >> 7} t3'></td><td class=c>${make_radio_input(1, i, cfg >> 7)}${make_radio_input(0, i, cfg >> 7)}</td></tr>`);
        } else if ((cfg & 3) == 1) { // input
            inputs.push(`<tr><td>${name}</td><td class='s${cfg >> 7} t3'></td><td/></tr>`);
        }
    });

    document_write(inputs.join(''));
    document_write(`<tr><th></th><th></th>${outputs.length > 0 ? '<th class=c>SET</th>' : ''}</tr>`);
    document_write(outputs.join(''));
    
    return {s: submit_form, l:reload_page, c:cfg_page, p:cfg_page_pcf, i:ioc_page}
})
({
  H00: '01010305070b0f13',
  g00: '14',
  J16: 'LivingRoom12345',
  J17: 'LivingRoom67890',
  J18: 'IO_19',
  J19: 'IO_20',
  J20: 'IO_21',
  J21: 'IO_22',
  J22: 'IO_23',
  J23: 'IO_24',
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
//     For 1 of the replies (Pin Control):
//     example: h00=xxxxxxxxxxxxxxxx&
//     where xxxxxxxxxxxxxxxx is 16 bytes
//     POST consists of 16 bytes data plus 5 byte wrapper (21 bytes)
//   PLUS
//     For 8 of the replies (IO Name):
//     example: j00=xxxxxxxxxxxxxxx& where xxxxxxxxxxxxxxx is 15 bytes
//     POST consists of 15 bytes data plus 5 byte wrapper (20 bytes)
//   PLUS
//     For 8 of the replies (IO Timer):
//     example: i00=xxxx& where xxxx is 4 bytes
//     POST consists of 4 bytes data plus 5 byte wrapper (9 bytes)
//   PLUS
//     For 1 of the replies (hidden):
//     example: z00=x where x is 1 byte (note no &)
//     POST consists of 1 byte data plus 4 byte wrapper (5 bytes)
// The formula in this case is
//     PARSEBYTES = (1 x 24)
//                + (1 x 21)
//                + (8 x 20)
//                + (8 x 9)
//                + (1 x 5)
//     PARSEBYTES = 24
//                + 21
//                + 160
//                + 72
//                + 5 = 282
//
#define WEBPAGE_PCF8574_CONFIGURATION				22
#define PARSEBYTES_PCF8574_CONFIGURATION			282
#define BROWSER_ONLY_WEBPAGE_PCF8574_CONFIGURATION_BEGIN	98
// The BROWSER_ONLY_WEBPAGE_PCF8574_CONFIGURATION_BEGIN define is used only by the
// "prepsx" strings pre-processor program. The define is used by the prepsx
// program as a keyword for locating the webpage text contained in the static
// const below. The prepsx program extracts the HTML "string" and places it in
// an SREC (.sx) file. The HTML strings in the .sx file are uploaded into the
// I2C EEPROM for subsequent use in generating webpages from the I2C EEPROM
// instead of generating them from Flash.
// Next #if: Only place the HTML in Flash if the I2C EEPROM is not supported.
// Comment: This HTML is NEVER placed in Flash, as the PCF8574 is supported
// only when the I2C EEPROM is present. Thus the build configuration will
// have OB_EEPROM_SUPPORT = 1 when PCF8574_SUPPORT = 1.
#if OB_EEPROM_SUPPORT == 0
#if PCF8574_SUPPORT == 1
static const char g_HtmlPagePCFConfiguration[] =
"%y04%y05"
      "<title>%A00: PCF8574 Configuration</title>"
   "</head>"
   "<body>"
      "<h1>PCF8574 Configuration</h1>"
      "<form onsubmit='return m.s(event);return false'>"
         "<table>"
            "<tr>"
               "<td>Name</td>"
               "<td><input name='A00' value='%A00' pattern='[0-9a-zA-Z-_*.]{1,19}' required title='1 to 19 letters, numbers, and -_*. no spaces' maxlength='19'/></td>"
            "</tr>"
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
"const m=(e=>{let t={disabled:0,input:1,output:3,linked:2},$={retain:8,on:16,off:0},_={'"
"0.1s':0,'1s':16384,'1m':32768,'1h':49152},n=document,r=location,a=n.querySelector.bind("
"n),d=a('form'),l=Object.entries,p=parseInt,s=e=>n.write(e),i=(e,t)=>p(e).toString(16).p"
"adStart(t,'0'),c=e=>e.map(e=>i(e,2)).join(''),o=e=>e.match(/.{2}/g).map(e=>p(e,16)),I=e"
"=>encodeURIComponent(e),u=(e,t)=>l(e).map(e=>`<option value=${e[1]} ${e[1]==t?'selected"
"':''}>${e[0]}</option>`).join(''),f=(e,t,$,_='')=>`<input type='checkbox' name='${e}' v"
"alue=${t} ${($&t)==t?'checked':''}>${_}`,J=()=>{let t=new FormData(d),$=e=>t.getAll(e)."
"map(e=>p(e)).reduce((e,t)=>e|t,0);t.set('H00',c(o(e.H00).map((e,_)=>{let n='p'+_,r=$(n)"
";return t.delete(n),r})));for(let _=16;_<24;_++){let n=(''+_).padStart(2,'0');t.set('I'"
"+n,i(65535&$('I'+n),4))}return t},h=(e,t,$)=>{let _=new XMLHttpRequest;_.open(e,t,!1),_"
".send($)},x=()=>r.href='/60',b=()=>r.href='/61',S=()=>r.href='/62',v=()=>r.href='/63',H"
"=()=>{n.body.innerText='Wait 5s...',setTimeout(v,5e3)},g=()=>{h('GET','/91'),H()},j=e=>"
"{e.preventDefault();let t=Array.from(J().entries(),([e,t])=>`${I(e)}=${I(t)}`).join('&'"
");h('POST','/',t+'&z00=0'),H()};return o(e.H00).forEach((n,a)=>{let d=a+16,l=(3&n)!=0?f"
"('p'+a,4,n):'',p=(e,t)=>(3&n)==3||(3&n)==2&&a>3?e:t,i=(''+d).padStart(2,'0'),c=p(o(e['I"
"'+i]).reduce((e,t)=>(e<<8)+t),0),I=p(`<select name='p${a}'>${u($,24&n)}</select>`,''),J"
"='#d'==r.hash?`<td>${n}</td>`:'',h=p(`<input type=number class=t8 name='I${i}' value='$"
"{16383&c}' min=0 max=16383><select name='I${i}'>${u(_,49152&c)}</select>`,'');s(`<tr><t"
"d>#${d+1}</td><td><select name='p${a}'>${u(t,3&n)}</select></td><td><input name='J${i}'"
" value='${e['J'+i]}' pattern='[0-9a-zA-Z_*.-]{1,15}' required title='1 to 15 letters, n"
"umbers, and -*_. no spaces' maxlength=15/></td><td>${l}</td><td>${I}</td><td>${h}</td>$"
"{J}</tr>`)}),{r:g,s:j,l:v,c:b,i:x,j:S}})({H00:'%H00',J16:'%J16',J17:'%J17',J18:'%J18',J"
"19:'%J19',J20:'%J20',J21:'%J21',J22:'%J22',J23:'%J23',I16:'%I16',I17:'%I17',I18:'%I18',"
"I19:'%I19',I20:'%I20',I21:'%I21',I22:'%I22',I23:'%I23'});"
      "%y01"
      "%y02'm.r()'>Reboot</button>"
      "<br><br>"
      "%y02'm.l()'>Refresh</button> "
      "<br><br>"
      "%y02'm.c()'>Configuration</button> "
      "<br><br>"
      "%y02'm.j()'>PCF8574 IO Control</button> "
      "%y02'm.i()'>IO Control</button> "
   "</body>"
"</html>";
#endif // PCF8574_SUPPORT == 1
#endif // OB_EEPROM_SUPPORT == 0

#if OB_EEPROM_SUPPORT == 1
#if PCF8574_SUPPORT == 1
// Declared short static const here so that common code can be used for Flash
// and I2C EEPROM webpage sources.
static const char g_HtmlPagePCFConfiguration[] = " ";
#endif // PCF8574_SUPPORT == 1
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
    const
        pin_types = { "disabled": 0, "input": 1, "output": 3, "linked": 2 },
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
        make_options = (o, v) => get_entries(o).map((o) => `<option value=${o[1]} ${o[1] == v ? 'selected' : ''}>${o[0]}</option>`).join(''),
        make_checkbox = (name, bit, value, title='') => `<input type="checkbox" name='${name}' value=${bit} ${(value & bit) == bit ? 'checked' : ''}>${title}`,
        get_form_data = () => {
            const form_data = new FormData(form),
            	collect_bits = (name) => form_data.getAll(name).map(v => parse_int(v)).reduce((a, b) => a | b, 0);
              
            form_data.set('H00', convert_to_hex(convert_from_hex(data.H00).map((_, i) => {
                const name = 'p' + i,
                    result = collect_bits(name);
                form_data.delete(name);
                return result;
            })));
            for (let i=16;i<24;i++) {
              let input_nr = (''+i).padStart(2, '0');
            	form_data.set('I'+input_nr, pad_hex(collect_bits('I'+input_nr) & 0xffff, 4));
            }
            
            return form_data;
        },
        send_request = (method, url, data) => {
        	const request = new XMLHttpRequest();
          request.open(method, url, false);
          request.send(data);
        },
        ioc_page = () => loc.href = '/60',
        cfg_page = () => loc.href = '/61',
        ioc_page_pcf = () => loc.href = '/62',
        reload_page = () => loc.href = '/63',
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
        common_attributes = {required: true};

    convert_from_hex(data.H00).forEach((n, i) => {
        const
            j = i + 16,
            invert_checkbox = (n & 3) != 0 ? make_checkbox('p'+i, 4, n) : '',
            if_output = (a,b) => (n & 3) == 3 || ((n & 3) == 2 && i > 3) ? a: b,
        		input_nr = (''+j).padStart(2, '0'),
            timer_int_value = if_output(convert_from_hex(data['I'+input_nr]).reduce((prev, cur)=>(prev<<8)+cur), 0),
            boot_state_select = if_output(`<select name='p${i}'>${make_options(boot_state, n & 24)}</select>`,''),
            debug_column = (loc.hash == '#d'?`<td>${n}</td>`:''),
            timer_column = if_output(`<input type=number class=t8 name='I${input_nr}' value='${timer_int_value & 0x3fff}' min=0 max=16383><select name='I${input_nr}'>${make_options(timer_unit, timer_int_value & 0xc000)}</select>`,'');
        document_write(`<tr><td>#${j+1}</td><td><select name='p${i}'>${make_options(pin_types, n & 3)}</select></td><td><input name='J${input_nr}' value='${data['J'+input_nr]}' pattern='[0-9a-zA-Z_*.-]{1,15}' required title='1 to 15 letters, numbers, and -*_. no spaces' maxlength=15/></td><td>${invert_checkbox}</td><td>${boot_state_select}</td><td>${timer_column}</td>${debug_column}</tr>`);
    });
    
    return {r:reboot, s: submitForm, l:reload_page, c:cfg_page, i:ioc_page, j:ioc_page_pcf};
})
({
    H00: "00020305070b0f13",
    J16: "LivingRoom12345",
    J17: "LivingRoom67890",
    J18: "IO_19",
    J19: "IO_20",
    J20: "IO_21",
    J21: "IO_22",
    J22: "IO_23",
    J23: "IO_24",
    I16: "0000",
    I17: "0000",
    I18: "0000",
    I19: "0000",
    I20: "30ff",
    I21: "7f0f",
    I22: "bff0",
    I23: "ffff",
});

*/
#endif // BUILD_SUPPORT == BROWSER_ONLY_BUILD


#if UIP_STATISTICS == 1
// Network Statistics page Template
// Browser Only builds
// URL /68
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
#endif // UIP_STATISTICS == 1


/*
#if DEBUG_SUPPORT == 11 || DEBUG_SUPPORT == 15
// Link Error Statistics page Template
// URL /66
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
  "<tr><td>34 %e34</td></tr>"
  "<tr><td>35 %e35</td></tr>"
  "</table>"
  "<br>"
  "<button onclick='location=`/61`'>Configuration</button>"
  "<button onclick='location=`/66`'>Refresh</button>"
  "<button onclick='location=`/67`'>Clear</button>"
  "</body>"
  "</html>";
#endif // DEBUG_SUPPORT
*/
#if DEBUG_SUPPORT == 11 || DEBUG_SUPPORT == 15
// Link Error Statistics page Template
// URL /66
#define WEBPAGE_STATS2		7
static const char g_HtmlPageStats2[] =
  "Link Error Statistics"
  "<br>"
  "31 %e31"
  "<br>"
  "32 %e32"
  "<br>"
  "33 %e33"
  "<br>"
  "34 %e34"
  "<br>"
  "35 %e35";
#endif // DEBUG_SUPPORT



#if DEBUG_SENSOR_SERIAL == 1
// Temperature Sensor Serial Number page Template
// URL /71
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


#if PCF8574_SUPPORT == 0
// Very Short IO state page Template
// Only responds with a TCP payload that contains the 16 alphanumeric
// characters representing the IO pins states. The response may not be
// browser compatible.
// URL /98 and /99
#define WEBPAGE_SSTATE		9
static const char g_HtmlPageSstate[] =
  "%f00";
#endif // PCF8574_SUPPORT == 0


#if PCF8574_SUPPORT == 1
// Very Short IO state page Template
// Only responds with a TCP payload that contains the 24 alphanumeric
// characters representing the IO pins states. The response may not be
// browser compatible.
// URL /98 and /99
#define WEBPAGE_SSTATE		9
static const char g_HtmlPageSstate[] =
  "%f00";
#endif // PCF8574_SUPPORT == 1


// Load Uploader page Template
// This web page is shown when the user requests the Code Uploader with the
// /72 command. It is stored in the I2C EEPROM and used only in upgradeable
// builds, so it should never be compiled for storage in Flash.
#define WEBPAGE_LOADUPLOADER		12
#define WEBPAGE_LOADUPLOADER_BEGIN	94
// The WEBPAGE_LOADUPLOADER_BEGIN define is used only by the
// "prepsx" strings pre-processor program. The define is used by the prepsx
// program as a keyword for locating the webpage text contained in the static
// const below. The prepsx program extracts the HTML "string" and places it in
// an SREC (.sx) file. The HTML strings in the .sx file are uploaded into the
// I2C EEPROM for subsequent use in generating webpages from the I2C EEPROM
// instead of generating them from Flash.
// Next #if: This HTML is NEVER placed in Flash, so OB_EEPROM_SUPPORT = 2
// (which can never occur) is used to prevent a compiler include for the HTML
// in Flash.
#if OB_EEPROM_SUPPORT == 2
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
#endif // OB_EEPROM_SUPPORT == 2


#if OB_EEPROM_SUPPORT == 1
// Declared short static const here so that common code can be used for Flash
// and I2C EEPROM webpage sources.
static const char g_HtmlPageLoadUploader[] = " ";
#endif // OB_EEPROM_SUPPORT == 1


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
  "Uploader Code Revision %w00<br/>"

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
  "Once you click Submit do not access via your browser until the Code Upload AND<br>"
  "Flash Programming completes.<br>"
  "Code Upload progress:<br>"
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

/*
#if OB_EEPROM_SUPPORT == 1
// EEPROM Missing webpage
// This web page is shown when the I2C EEPROM has gone missing unexpectedly.
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
*/
#if OB_EEPROM_SUPPORT == 1
// EEPROM Missing webpage
// This web page is shown when the I2C EEPROM has gone missing unexpectedly.
// This should never happen, but may occur is there is a faulty connection.
#define WEBPAGE_EEPROM_MISSING	17
static const char g_HtmlPageEEPROMMissing[] =
  "I2C EEPROM Missing";
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
  "<p>" \
  "<button type=submit>Save</button> <button type=reset onclick='m.l()'>Undo All</button>" \
  "</form>" \
  "</p>"

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
  // If a non-upgradeable build the IOControl and Configuration webpage sizes
  // are based on the HTML strings in the httpd.c file that are compiled into
  // Flash.
  // If an upgradeable build the IOControl and Configuration webpage sizes are
  // obtained from the I2C EEPROM where the webpage strings are stored.
  
  // ---------------------------------------------------------------------- //
  // Initialize size for Flash based IOControl and Configuration pages
  // ---------------------------------------------------------------------- //
#if OB_EEPROM_SUPPORT == 0
  // Webpage sizes for non-upgradeable builds
  HtmlPageIOControl_size = (uint16_t)(sizeof(g_HtmlPageIOControl) - 1);
  HtmlPageConfiguration_size = (uint16_t)(sizeof(g_HtmlPageConfiguration) - 1);
#endif // OB_EEPROM_SUPPORT == 0


  // ---------------------------------------------------------------------- //
  // Initialize size for I2C EEPROM based IOControl and Configuration pages
  // ---------------------------------------------------------------------- //
#if OB_EEPROM_SUPPORT == 1
#if BUILD_SUPPORT == MQTT_BUILD
  // Prepare to read 2 bytes from I2C EEPROM and convert to uint16_t.
  prep_read(I2C_EEPROM2_WRITE, I2C_EEPROM2_READ, MQTT_WEBPAGE_IOCONTROL_SIZE_LOCATION, 2);
#endif // BUILD_SUPPORT == MQTT_BUILD

#if BUILD_SUPPORT == BROWSER_ONLY_BUILD
  // Prepare to read 2 bytes from I2C EEPROM and convert to uint16_t.
  prep_read(I2C_EEPROM2_WRITE, I2C_EEPROM2_READ, BROWSER_ONLY_WEBPAGE_IOCONTROL_SIZE_LOCATION, 2);
#endif // BUILD_SUPPORT == BROWSER_ONLY_BUILD

  // Read 2 bytes from I2C EEPROM and save in the _size word.
  HtmlPageIOControl_size = read_two_bytes();
  
#if BUILD_SUPPORT == MQTT_BUILD
  // Prepare to read 2 bytes from I2C EEPROM and convert to uint16_t.
  prep_read(I2C_EEPROM2_WRITE, I2C_EEPROM2_READ, MQTT_WEBPAGE_CONFIGURATION_SIZE_LOCATION, 2);
#endif // BUILD_SUPPORT == MQTT_BUILD

#if BUILD_SUPPORT == BROWSER_ONLY_BUILD
  // Prepare to read 2 bytes from I2C EEPROM and convert to uint16_t.
  prep_read(I2C_EEPROM2_WRITE, I2C_EEPROM2_READ, BROWSER_ONLY_WEBPAGE_CONFIGURATION_SIZE_LOCATION, 2);
#endif // BUILD_SUPPORT == BROWSER_ONLY_BUILD

  // Read 2 bytes from I2C EEPROM and save in the _size word.
  HtmlPageConfiguration_size = read_two_bytes();
#endif // OB_EEPROM_SUPPORT == 1


  // ---------------------------------------------------------------------- //
  // Initialize size for I2C EEPROM based PCF8574 IOControl and
  // Configuration pages
  // ---------------------------------------------------------------------- //
#if OB_EEPROM_SUPPORT == 1
#if PCF8574_SUPPORT == 1
#if BUILD_SUPPORT == MQTT_BUILD
  // Prepare to read 2 bytes from I2C EEPROM and convert to uint16_t.
  prep_read(I2C_EEPROM2_WRITE, I2C_EEPROM2_READ, MQTT_WEBPAGE_PCF8574_IOCONTROL_SIZE_LOCATION, 2);
#endif // BUILD_SUPPORT == MQTT_BUILD

#if BUILD_SUPPORT == BROWSER_ONLY_BUILD
  // Prepare to read 2 bytes from I2C EEPROM and convert to uint16_t.
  prep_read(I2C_EEPROM2_WRITE, I2C_EEPROM2_READ, BROWSER_ONLY_WEBPAGE_PCF8574_IOCONTROL_SIZE_LOCATION, 2);
#endif // BUILD_SUPPORT == BROWSER_ONLY_BUILD

  // Read 2 bytes from I2C EEPROM and save in the _size word.
  HtmlPagePCFIOControl_size = read_two_bytes();
  
#if BUILD_SUPPORT == MQTT_BUILD
  // Prepare to read 2 bytes from I2C EEPROM and convert to uint16_t.
  prep_read(I2C_EEPROM2_WRITE, I2C_EEPROM2_READ, MQTT_WEBPAGE_PCF8574_CONFIGURATION_SIZE_LOCATION, 2);
#endif // BUILD_SUPPORT == MQTT_BUILD

#if BUILD_SUPPORT == BROWSER_ONLY_BUILD
  // Prepare to read 2 bytes from I2C EEPROM and convert to uint16_t.
  prep_read(I2C_EEPROM2_WRITE, I2C_EEPROM2_READ, BROWSER_ONLY_WEBPAGE_PCF8574_CONFIGURATION_SIZE_LOCATION, 2);
#endif // BUILD_SUPPORT == BROWSER_ONLY_BUILD

  // Read 2 bytes from I2C EEPROM and save in the _size word.
  HtmlPagePCFConfiguration_size = read_two_bytes();
#endif // PCF8574_SUPPORT == 1
#endif // OB_EEPROM_SUPPORT == 1


  // ---------------------------------------------------------------------- //
  // Initialize size for I2C EEPROM based LoadUploader page
  // ---------------------------------------------------------------------- //
#if OB_EEPROM_SUPPORT == 1
  // This is always performed if an upgradeable build
  // Prepare to read 2 bytes from I2C EEPROM and convert to uint16_t.
  prep_read(I2C_EEPROM2_WRITE, I2C_EEPROM2_READ, WEBPAGE_LOADUPLOADER_SIZE_LOCATION, 2);

  // Read 2 bytes from I2C EEPROM and save in the _size word.
  HtmlPageLoadUploader_size = read_two_bytes();
#endif // OB_EEPROM_SUPPORT == 1
}


#if OB_EEPROM_SUPPORT == 1
void init_off_board_string_pointers(struct tHttpD* pSocket) {
  // Initialize the index into the I2C EEPROM Strings region.
  //
  // In order to allow a String File to be read using the same code used for
  // reading Program Files the code expects the Strings file to have SREC
  // addresses starting at 0x8000, however in the I2C EEPROM itself the base
  // address for Strings is 0x0000. This initialization will compensate for
  // that disparity.
  
  // ********************************************************************** //
  if (pSocket->current_webpage == WEBPAGE_IOCONTROL) {

#if BUILD_SUPPORT == MQTT_BUILD
    // Prepare to read the two byte string address from I2C EEPROM and
    // convert to uint16_t.
    prep_read(I2C_EEPROM2_WRITE, I2C_EEPROM2_READ, MQTT_WEBPAGE_IOCONTROL_ADDRESS_LOCATION, 2);
#endif // BUILD_SUPPORT == MQTT_BUILD

#if BUILD_SUPPORT == BROWSER_ONLY_BUILD
    // Prepare to read the two byte string address from I2C EEPROM and
    // convert to uint16_t.
    prep_read(I2C_EEPROM2_WRITE, I2C_EEPROM2_READ, BROWSER_ONLY_WEBPAGE_IOCONTROL_ADDRESS_LOCATION, 2);
#endif // BUILD_SUPPORT == BROWSER_ONLY_BUILD

    // Read 2 bytes
    off_board_eeprom_index = read_two_bytes() - 0x8000;
  }
  
  // ********************************************************************** //
  if (pSocket->current_webpage == WEBPAGE_CONFIGURATION) {
  
#if BUILD_SUPPORT == MQTT_BUILD
    // Prepare to read the two byte string address from I2C EEPROM and
    // convert to uint16_t.
    prep_read(I2C_EEPROM2_WRITE, I2C_EEPROM2_READ, MQTT_WEBPAGE_CONFIGURATION_ADDRESS_LOCATION, 2);
#endif // BUILD_SUPPORT == MQTT_BUILD

#if BUILD_SUPPORT == BROWSER_ONLY_BUILD
    // Prepare to read the two byte string address from I2C EEPROM and
    // convert to uint16_t.
    prep_read(I2C_EEPROM2_WRITE, I2C_EEPROM2_READ, BROWSER_ONLY_WEBPAGE_CONFIGURATION_ADDRESS_LOCATION, 2);
#endif // BUILD_SUPPORT == BROWSER_ONLY_BUILD

    // Read 2 bytes
    off_board_eeprom_index = read_two_bytes() - 0x8000;
  }

#if PCF8574_SUPPORT == 1
  // ********************************************************************** //
  if (pSocket->current_webpage == WEBPAGE_PCF8574_IOCONTROL) {

#if BUILD_SUPPORT == MQTT_BUILD
    // Prepare to read the two byte string address from I2C EEPROM and
    // convert to uint16_t.
    prep_read(I2C_EEPROM2_WRITE, I2C_EEPROM2_READ, MQTT_WEBPAGE_PCF8574_IOCONTROL_ADDRESS_LOCATION, 2);
#endif // BUILD_SUPPORT == MQTT_BUILD

#if BUILD_SUPPORT == BROWSER_ONLY_BUILD
    // Prepare to read the two byte string address from I2C EEPROM and
    // convert to uint16_t.
    prep_read(I2C_EEPROM2_WRITE, I2C_EEPROM2_READ, BROWSER_ONLY_WEBPAGE_PCF8574_IOCONTROL_ADDRESS_LOCATION, 2);
#endif // BUILD_SUPPORT == BROWSER_ONLY_BUILD

    // Read 2 bytes
    off_board_eeprom_index = read_two_bytes() - 0x8000;
  }
  
  // ********************************************************************** //
  if (pSocket->current_webpage == WEBPAGE_PCF8574_CONFIGURATION) {
  
#if BUILD_SUPPORT == MQTT_BUILD
    // Prepare to read the two byte string address from I2C EEPROM and
    // convert to uint16_t.
    prep_read(I2C_EEPROM2_WRITE, I2C_EEPROM2_READ, MQTT_WEBPAGE_PCF8574_CONFIGURATION_ADDRESS_LOCATION, 2);
#endif // BUILD_SUPPORT == MQTT_BUILD

#if BUILD_SUPPORT == BROWSER_ONLY_BUILD
    // Prepare to read the two byte string address from I2C EEPROM and
    // convert to uint16_t.
    prep_read(I2C_EEPROM2_WRITE, I2C_EEPROM2_READ, BROWSER_ONLY_WEBPAGE_PCF8574_CONFIGURATION_ADDRESS_LOCATION, 2);
#endif // BUILD_SUPPORT == BROWSER_ONLY_BUILD

    // Read 2 bytes
    off_board_eeprom_index = read_two_bytes() - 0x8000;
  }
#endif // PCF8574_SUPPORT == 1

#if BUILD_SUPPORT == BROWSER_ONLY_BUILD || BUILD_SUPPORT == MQTT_BUILD
  if (pSocket->current_webpage == WEBPAGE_LOADUPLOADER) {
    // Prepare to read the two byte string address from I2C EEPROM and
    // convert to uint16_t.
    prep_read(I2C_EEPROM2_WRITE, I2C_EEPROM2_READ, WEBPAGE_LOADUPLOADER_ADDRESS_LOCATION, 2);
    // Read 2 bytes
    off_board_eeprom_index = read_two_bytes() - 0x8000;
  }
#endif // BUILD_SUPPORT == BROWSER_ONLY_BUILD || BUILD_SUPPORT == MQTT_BUILD
}
#endif // OB_EEPROM_SUPPORT == 1


#if OB_EEPROM_SUPPORT == 1
uint16_t read_two_bytes(void)
{
  // This function reads two bytes from the I2C EEPROM and returns the result.
  // It is assumed tha the prep_read() function was called prior to this
  // function to set up the read.
  uint16_t temp;
  OctetArray[0] = I2C_read_byte(0);
  OctetArray[1] = I2C_read_byte(1);
  temp = (uint16_t)(OctetArray[0] << 8);
  temp |= OctetArray[1];
  
  return temp;
}
#endif // OB_EEPROM_SUPPORT == 1


#if DEBUG_SUPPORT == 7 || DEBUG_SUPPORT == 15
#if OB_EEPROM_SUPPORT == 1
#if HTTPD_DIAGNOSTIC_SUPPORT == 1
void httpd_diagnostic(void)
{
  // Read and display the 18 bytes in the I2C EEPROM that contain the address
  // info for the web pages. This routine is called from main.c. The output is
  // on the UART only.
  // Within the I2C EEPROM the order of the addresses is
  //   MQTT IOControl
  //   MQTT Configuration
  //   Browser Only IOControl
  //   Browser Only Configuration
  //   MQTT PCF8574 IOControl
  //   MQTT PCF8574 Configuration
  //   Browser Only PCF8574 IOControl
  //   Browser Only PCF8574 Configuration
  //   LoadUploader
 
  prep_read(I2C_EEPROM2_WRITE, I2C_EEPROM2_READ, MQTT_WEBPAGE_IOCONTROL_ADDRESS_LOCATION, 2);
  UARTPrintf("Webpage Address Bytes: ");
  read_httpd_diagnostic_bytes();
  
  // Read and display the 18 bytes in the I2C EEPROM that contain the size
  // info for the web pages
  prep_read(I2C_EEPROM2_WRITE, I2C_EEPROM2_READ, MQTT_WEBPAGE_IOCONTROL_SIZE_LOCATION, 2);
  UARTPrintf("Webpage Size Bytes:    ");
  read_httpd_diagnostic_bytes();

  // The following displays the page sizes for the various templates for the
  // specific build type currently running (ie, Browser Only or MQTT).
  UARTPrintf("IOControl Page Size: ");
  emb_itoa(HtmlPageIOControl_size, OctetArray, 16, 4);
  UARTPrintf(OctetArray);
  UARTPrintf("\r\n");


  UARTPrintf("Configuration Page Size: ");
  emb_itoa(HtmlPageConfiguration_size, OctetArray, 16, 4);
  UARTPrintf(OctetArray);
  UARTPrintf("\r\n");


#if PCF8574_SUPPORT == 1
  UARTPrintf("PCF8574 IOControl Page Size: ");
  emb_itoa(HtmlPagePCFIOControl_size, OctetArray, 16, 4);
  UARTPrintf(OctetArray);
  UARTPrintf("\r\n");


  UARTPrintf("PCF8574 Configuration Page Size: ");
  emb_itoa(HtmlPagePCFConfiguration_size, OctetArray, 16, 4);
  UARTPrintf(OctetArray);
  UARTPrintf("\r\n");
#endif // PCF8574_SUPPORT == 1


  UARTPrintf("Load Uploader Page Size: ");
  emb_itoa(HtmlPageLoadUploader_size, OctetArray, 16, 4);
  UARTPrintf(OctetArray);
  UARTPrintf("\r\n");

}
#endif // HTTPD_DIAGNOSTIC_SUPPORT == 1
#endif // OB_EEPROM_SUPPORT == 1
#endif // DEBUG_SUPPORT == 7 || DEBUG_SUPPORT == 15


#if DEBUG_SUPPORT == 7 || DEBUG_SUPPORT == 15
#if OB_EEPROM_SUPPORT == 1
#if HTTPD_DIAGNOSTIC_SUPPORT == 1
void read_httpd_diagnostic_bytes(void)
{
  // This function reads eighteen bytes from the I2C EEPROM and displays them
  // via the UART. This is used only for debug for purposes of displaying the
  // size and address information for the webpages stored in I2C EEPROM. It is
  // assumed that the prep_read() function was called prior to this function
  // to set up the read.
  int i;
  uint8_t temp[10];
  temp[0] = I2C_read_byte(0);
  temp[1] = I2C_read_byte(0);
  temp[2] = I2C_read_byte(0);
  temp[3] = I2C_read_byte(0);
  temp[4] = I2C_read_byte(0);
  temp[5] = I2C_read_byte(0);
  temp[6] = I2C_read_byte(0);
  temp[7] = I2C_read_byte(0);
  temp[8] = I2C_read_byte(0);
  temp[9] = I2C_read_byte(0);
  for (i = 0; i < 10; i++) {
    emb_itoa(temp[i], OctetArray, 16, 2);
    UARTPrintf(OctetArray);
    if ((i == 1) || (i == 3) || (i == 5) || (i == 7) || (i == 9))
      UARTPrintf(" ");
  }
  UARTPrintf(" ");
  
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
    if ((i == 1) || (i == 3) || (i == 5) || (i == 7))
      UARTPrintf(" ");
  }
  UARTPrintf("\r\n");
}
#endif // HTTPD_DIAGNOSTIC_SUPPORT == 1
#endif // OB_EEPROM_SUPPORT == 1
#endif // DEBUG_SUPPORT == 7 || DEBUG_SUPPORT == 15


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
  //-------------------------------------------------------------------------//
  //-------------------------------------------------------------------------//
  //-------------------------------------------------------------------------//
  // Adjust the size reported by the WEBPAGE_IOCONTROL template
  //-------------------------------------------------------------------------//
  //-------------------------------------------------------------------------//
  //-------------------------------------------------------------------------//
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
      //    40 bytes of text plus 27 bytes of data = 67
      //    size = size + 67 - 4
      size = size + 63;
      //
      //  %t01 "<br> xxxxxxxxxxxx " 
      //      plus 13 bytes of data and degC characters (-000.0&#8451;)
      //      plus 14 bytes of data and degF characters ( -000.0&#8457;)
      //    18 bytes of text plus 27 bytes of data = 45
      //    size = size + 45 - 4
      size = size + 41;
      //
      //  %t02 "<br> xxxxxxxxxxxx "
      //      plus 13 bytes of data and degC characters (-000.0&#8451;)
      //      plus 14 bytes of data and degF characters ( -000.0&#8457;)
      //    18 bytes of text plus 27 bytes of data = 45
      //    size = size + 45 - 4
      size = size + 41;
      //
      //  %t03 "<br> xxxxxxxxxxxx "
      //      plus 13 bytes of data and degC characters (-000.0&#8451;)
      //      plus 14 bytes of data and degF characters ( -000.0&#8457;)
      //    18 bytes of text plus 27 bytes of data = 45
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
    
    // Account for BME280 Sensor insertion %t05
    // If BME280 is NOT enabled we only need to subtract the size of the
    // placeholder.
    //
    if (stored_config_settings & 0x20) {
      // Output string looks like:
      // <p>BME280 Sensor<br>BME280-0xxxx Temp -000.00C -000.00F<br>BME280-1xxxx Pressure 0000 hPa<br>BME280-2xxxx Humidity 000%<br>Altitude -00000 meters -00000 feet<p>
      // 0        1         2         3         4         5         6         7         8         9         0         1         2         3         4         5         6         7
      // 12345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890
      // 160 characters      
      // plus
      //   degC character (&#8451;) adds 6 characters over the above
      //   degF character (&#8457;) adds 6 characters over the above
      // 160 + 12 = 172
      // size = size + 172 - 4
      size = size + 168;
    }
    else {
      // Subtract the size of the placeholder as it won't be used
      // size = size - (1 x 4)
      size = size - 4;
    }
    
    // Account for Text Replacement insertion
    // Some strings appear frequently in the templates - things like the
    // button titles which appear when hovering over a button. These strings
    // are inserted on the fly when the web page is sent to the browser, so
    // they have to be accounted for in the size of the web page.
    
    // String for %y01 in web page template
    // There is 1 instance for the Save and Undo All buttons
    // size = size + (#instances) x (ps[1].size - marker_field_size);
    // size = size + ps[1].size_less4;
    size = size + ps[1].size_less4;

    // String for %y02 in web page template
    // There 3 instances:
    //   Refresh button
    //   Configuration button
    //   PCF8574 IOControl button
    // size = size + (#instances) x (ps[2].size - marker_field_size);
    // size = size + (3 x ps[2].size_less4);
    size = size + (3 * ps[2].size_less4);

#if BUILD_SUPPORT == BROWSER_ONLY_BUILD
    // Account for IO Name fields %j00 to %j15
    // Each can be variable in size during run time so we have to calculate
    // them  each time we display the web page.
    {
      int i;
//      for (i=0; i<15; i++) {
      for (i=0; i<16; i++) {
        size = size + (strlen(IO_NAME[i]) - 4);
      }
    }
    // The TIMER fields have no size change impact
#endif // BUILD_SUPPORT == BROWSER_ONLY_BUILD
  }
#endif // BUILD_SUPPORT == BROWSER_ONLY_BUILD || BUILD_SUPPORT == MQTT_BUILD


  //-------------------------------------------------------------------------//
  //-------------------------------------------------------------------------//
  //-------------------------------------------------------------------------//
  //-------------------------------------------------------------------------//
  // Adjust the size reported by the WEBPAGE_PCF8574_IOCONTROL template
  //-------------------------------------------------------------------------//
  //-------------------------------------------------------------------------//
  //-------------------------------------------------------------------------//
  //-------------------------------------------------------------------------//
#if BUILD_SUPPORT == BROWSER_ONLY_BUILD || BUILD_SUPPORT == MQTT_BUILD
#if PCF8574_SUPPORT == 1
  else if (pSocket->current_webpage == WEBPAGE_PCF8574_IOCONTROL) {
    size = HtmlPagePCFIOControl_size;

    // Account for header replacement strings %y04 %y05
    size = size + ps[4].size_less4
                + ps[5].size_less4;

    // Account for Device Name field %A00 in <title> and in body
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

    // Account for pin control field %H00
    // size = size + (#instances x (value_size - marker_field_size));
    // size = size + (#instances x (16 - 4));
    // size = size + (1 x 12);
    size = size + 12;
 
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
    // There 4 instances
    //   Refresh button
    //   Configuration PCF8574 button
    //   Configuration button
    //   IO Control button
    // size = size + (#instances) x (ps[2].size - marker_field_size);
    // size = size + (4 x ps[2].size_less4);
    size = size + (4 * ps[2].size_less4);

#if BUILD_SUPPORT == BROWSER_ONLY_BUILD
    // Account for IO Name fields %J16 to %J23
    // Each can be variable in size during run time so we have to calculate
    // them  each time we display the web page.
    // For the PCF8574 these names are stored in I2C EEPROM and must be read
    // from there to determine their size.
    {
      int i;
      int j;
      char temp_byte[16];
      for (i=16; i<24; i++) {
        // Read a PCF8574_IO_NAMES value from I2C EEPROM
        prep_read(I2C_EEPROM2_WRITE, I2C_EEPROM2_READ, PCF8574_I2C_EEPROM_START_IO_NAMES + ((i - 16) * 16), 2);
        for (j=0; j<15; j++) {
          temp_byte[j] = I2C_read_byte(0);
        }
        temp_byte[15] = I2C_read_byte(1);
        size = size + (strlen(temp_byte) - 4);
      }
    }
    // Account for IO Timer field %I16 to %I23
    // size = size + (#instances x (value_size - marker_field_size));
    // size = size + (#instances x (4 - 4));
    // size = size + (8 x 0);
    // size = size + 0;
    // The Timer fields have no size change impact    
#endif // BUILD_SUPPORT == BROWSER_ONLY_BUILD
  }
#endif // PCF8574_SUPPORT == 1
#endif // BUILD_SUPPORT == BROWSER_ONLY_BUILD || BUILD_SUPPORT == MQTT_BUILD


  //-------------------------------------------------------------------------//
  //-------------------------------------------------------------------------//
  //-------------------------------------------------------------------------//
  //-------------------------------------------------------------------------//
  // Adjust the size reported by the WEBPAGE_CONFIGURATION template
  //-------------------------------------------------------------------------//
  //-------------------------------------------------------------------------//
  //-------------------------------------------------------------------------//
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
    // There is 1 instance for the Save and Undo All buttons
    // size = size + (#instances) x (ps[1].size - marker_field_size);
    // size = size + ps[1].size_less4;
    size = size + ps[1].size_less4;

    // String for %y02 in web page templates
    // There are 4 instances:
    //   Reboot button
    //   Refresh button
    //   IOControl button
    //   PCF8574 Configuration button
    // size = size + (#instances x (value_size - marker_field_size));
    // size = size + (#instances) x (ps[2].size - 4);
    // size = size + (4) x ps[2].size_less4;
    size = size + (4 * ps[2].size_less4);
    
    // Account for Pinout Option field %w01
    // Looks like "Pinout Option 1"
    // size = size + (#instances x (value_size - marker_field_size));
    // size = size + (#instances x (1 - 4));
    // size = size + (1 x -3);
    size = size - 3;
    
#if BUILD_SUPPORT == BROWSER_ONLY_BUILD
    // Account for IO Name fields %j00 to %j15
    // Each can be variable in size during run time so we have to calculate
    // them  each time we display the web page.
    {
      int i;
      for (i=0; i<16; i++) {
        size = size + (strlen(IO_NAME[i]) - 4);
      }
    }

    // Account for IO Timer field %i00 to %i15
    // size = size + (#instances x (value_size - marker_field_size));
    // size = size + (#instances x (4 - 4));
    // size = size + (16 x 0);
    // size = size + 0;
    // The Timer fields have no size change impact
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
  //-------------------------------------------------------------------------//
  //-------------------------------------------------------------------------//
  //-------------------------------------------------------------------------//
  // Adjust the size reported by the WEBPAGE_PCF8574_CONFIGURATION template
  //-------------------------------------------------------------------------//
  //-------------------------------------------------------------------------//
  //-------------------------------------------------------------------------//
  //-------------------------------------------------------------------------//
#if BUILD_SUPPORT == BROWSER_ONLY_BUILD || BUILD_SUPPORT == MQTT_BUILD
#if PCF8574_SUPPORT == 1
  else if (pSocket->current_webpage == WEBPAGE_PCF8574_CONFIGURATION) {
    size = HtmlPagePCFConfiguration_size;

    // Account for header replacement strings %y04 %y05
    size = size + ps[4].size_less4
                + ps[5].size_less4;

    // Account for Device Name field %A00 in <title> and in body
    // This can be variable in size during run time so we have to calculate it
    // each time we display the /web page.
    size = size + (2 * strlen_devicename_adjusted);

    // Account for Config string %g00
    // There is 1 instance
    // value_size is 2 (2 characters)
    // size = size + (#instances x (value_size - marker_field_size));
    // size = size + (#instances x (2 - 4));
    // size = size + (1 x (-2));
    size = size - 2;

    // Account for pin control field %H00
    // size = size + (#instances x (value_size - marker_field_size));
    // size = size + (#instances x (16 - 4));
    // size = size + (1 x 12);
    size = size + 12;

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
    // There are 5 instances:
    //   Reboot button
    //   Refresh button
    //   PCF8574 IO Control button
    //   Configuration button
    //   IO Control button
    // size = size + (#instances x (value_size - marker_field_size));
    // size = size + (#instances) x (ps[2].size - 4);
    // size = size + (5) x ps[2].size_less4;
    size = size + (5 * ps[2].size_less4);
    
#if BUILD_SUPPORT == BROWSER_ONLY_BUILD
    // Account for IO Name fields %J16 to %J23
    // Each can be variable in size during run time so we have to calculate
    // them  each time we display the web page.
    // For the PCF8574 these names are stored in I2C EEPROM and must be read
    // from there to determine their size.
    {
      int i;
      int j;
      char temp_byte[16];
      for (i=16; i<24; i++) {
        // Read a PCF8574_IO_NAMES value from I2C EEPROM
        prep_read(I2C_EEPROM2_WRITE, I2C_EEPROM2_READ, PCF8574_I2C_EEPROM_START_IO_NAMES + ((i - 16) * 16), 2);
        for (j=0; j<15; j++) {
          temp_byte[j] = I2C_read_byte(0);
        }
        temp_byte[15] = I2C_read_byte(1);
        size = size + (strlen(temp_byte) - 4);
      }
    }
    // Account for IO Timer field %I16 to %I23
    // size = size + (#instances x (value_size - marker_field_size));
    // size = size + (#instances x (4 - 4));
    // size = size + (8 x 0);
    // size = size + 0;
    // The Timer fields have no size change impact
#endif // BUILD_SUPPORT == BROWSER_ONLY_BUILD
 
  }
#endif // PCF8574_SUPPORT == 1
#endif // BUILD_SUPPORT == BROWSER_ONLY_BUILD || BUILD_SUPPORT == MQTT_BUILD


  //-------------------------------------------------------------------------//
  //-------------------------------------------------------------------------//
  //-------------------------------------------------------------------------//
  //-------------------------------------------------------------------------//
  // Adjust the size reported by the WEBPAGE_STATS1 template (Network
  // Statistics)
  //-------------------------------------------------------------------------//
  //-------------------------------------------------------------------------//
  //-------------------------------------------------------------------------//
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
  //-------------------------------------------------------------------------//
  //-------------------------------------------------------------------------//
  //-------------------------------------------------------------------------//
  // Adjust the size reported by the WEBPAGE_STATS2 template (Link Error
  // Statistics)
  //-------------------------------------------------------------------------//
  //-------------------------------------------------------------------------//
  //-------------------------------------------------------------------------//
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

    // Account for Statistics fields %e31, %e32, %e33, %e34, %e35
    // There are 5 instances of these fields
    // size = size + (#instances x (value_size - marker_field_size));
    // size = size + (5 x (10 - 4));
    // size = size + (5 x (6));
    size = size + 30;
  }
#endif // DEBUG_SUPPORT


  //-------------------------------------------------------------------------//
  //-------------------------------------------------------------------------//
  //-------------------------------------------------------------------------//
  //-------------------------------------------------------------------------//
  // Adjust the size reported by the DEBUG_SENSOR_SERIAL template
  //-------------------------------------------------------------------------//
  //-------------------------------------------------------------------------//
  //-------------------------------------------------------------------------//
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
  //-------------------------------------------------------------------------//
  //-------------------------------------------------------------------------//
  //-------------------------------------------------------------------------//
  // Adjust the size reported by the WEBPAGE_SSTATE template
  //-------------------------------------------------------------------------//
  //-------------------------------------------------------------------------//
  //-------------------------------------------------------------------------//
  //-------------------------------------------------------------------------//
#if BUILD_SUPPORT == BROWSER_ONLY_BUILD || BUILD_SUPPORT == MQTT_BUILD
  else if (pSocket->current_webpage == WEBPAGE_SSTATE) {
    size = (uint16_t)(sizeof(g_HtmlPageSstate) - 1);

#if PCF8574_SUPPORT == 0
    // Account for Short Form IO Settings field (%f00)
    // size = size + (value size - marker_field_size)
    // size = size + (16 - 4);
    size = size + 12;
#endif // PCF8574_SUPPORT == 0

#if PCF8574_SUPPORT == 1
    // Account for Short Form IO Settings field (%f00)
    // Even though PCF8574 support may be enabled there may not be a device
    // physically present. Return 16 pins if no PCF8574, otherwise return
    // 24 pins.
    // If PCF8574 is present
    // size = size + (value size - marker_field_size)
    // size = size + (24 - 4);
    // If PCF8574 is NOT present
    // size = size + (value size - marker_field_size)
    // size = size + (16 - 4);
    if (stored_options1 & 0x08) {
      size = size + 20;
    }
    else {
      size = size + 12;
    }
#endif // PCF8574_SUPPORT == 1
  }
#endif // BUILD_SUPPORT == BROWSER_ONLY_BUILD || BUILD_SUPPORT == MQTT_BUILD


#if OB_EEPROM_SUPPORT == 1
#if BUILD_SUPPORT == BROWSER_ONLY_BUILD || BUILD_SUPPORT == MQTT_BUILD
  //-------------------------------------------------------------------------//
  //-------------------------------------------------------------------------//
  //-------------------------------------------------------------------------//
  //-------------------------------------------------------------------------//
  // Adjust the size reported by the WEBPAGE_LOADUPLOADER template
  // This template is always stored in I2C EEPROM
  //-------------------------------------------------------------------------//
  //-------------------------------------------------------------------------//
  //-------------------------------------------------------------------------//
  //-------------------------------------------------------------------------//
  else if (pSocket->current_webpage == WEBPAGE_LOADUPLOADER) {
    size = HtmlPageLoadUploader_size;
    
    // Account for header replacement strings %y04 %y05
    size = size + ps[4].size_less4
                + ps[5].size_less4;
  }
#endif // BUILD_SUPPORT == BROWSER_ONLY_BUILD || BUILD_SUPPORT == MQTT_BUILD
#endif // OB_EEPROM_SUPPORT == 1


#if BUILD_SUPPORT == CODE_UPLOADER_BUILD
  //-------------------------------------------------------------------------//
  //-------------------------------------------------------------------------//
  //-------------------------------------------------------------------------//
  //-------------------------------------------------------------------------//
  // Adjust the size reported by the WEBPAGE_UPLOADER template
  //-------------------------------------------------------------------------//
  //-------------------------------------------------------------------------//
  //-------------------------------------------------------------------------//
  //-------------------------------------------------------------------------//
  else if (pSocket->current_webpage == WEBPAGE_UPLOADER) {
    size = (uint16_t)(sizeof(g_HtmlPageUploader) - 1);
    
    // Account for header replacement strings %y04 %y05
    size = size + ps[4].size_less4
                + ps[5].size_less4;
    
    // Account for Code Revision + Code Type insertion %w00
    // size = size + (#instances x (value_size - marker_field_size));
    // size = size + (#instances x (26 - 4));
    // size = size + (1 x 22);
    size = size + 22;
  }


  //-------------------------------------------------------------------------//
  //-------------------------------------------------------------------------//
  //-------------------------------------------------------------------------//
  //-------------------------------------------------------------------------//
  // Adjust the size reported by the WEBPAGE_EXISTING_IMAGE template
  //-------------------------------------------------------------------------//
  //-------------------------------------------------------------------------//
  //-------------------------------------------------------------------------//
  //-------------------------------------------------------------------------//
  else if (pSocket->current_webpage == WEBPAGE_EXISTING_IMAGE) {
    size = (uint16_t)(sizeof(g_HtmlPageExistingImage) - 1);
    
    // Account for header replacement strings %y04 %y05
    size = size + ps[4].size_less4
                + ps[5].size_less4;
  }


  //-------------------------------------------------------------------------//
  //-------------------------------------------------------------------------//
  //-------------------------------------------------------------------------//
  //-------------------------------------------------------------------------//
  // Adjust the size reported by the WEBPAGE_TIMER template
  //-------------------------------------------------------------------------//
  //-------------------------------------------------------------------------//
  //-------------------------------------------------------------------------//
  //-------------------------------------------------------------------------//
  else if (pSocket->current_webpage == WEBPAGE_TIMER) {
    size = (uint16_t)(sizeof(g_HtmlPageTimer) - 1);
    
    // Account for header replacement strings %y04 %y05
    size = size + ps[4].size_less4
                + ps[5].size_less4;
  }


  //-------------------------------------------------------------------------//
  //-------------------------------------------------------------------------//
  //-------------------------------------------------------------------------//
  //-------------------------------------------------------------------------//
  // Adjust the size reported by the WEBPAGE_UPLOAD_COMPLETE template
  //-------------------------------------------------------------------------//
  //-------------------------------------------------------------------------//
  //-------------------------------------------------------------------------//
  //-------------------------------------------------------------------------//
  else if (pSocket->current_webpage == WEBPAGE_UPLOAD_COMPLETE) {
    size = (uint16_t)(sizeof(g_HtmlPageUploadComplete) - 1);
    
    // Account for header replacement strings %y04 %y05
    size = size + ps[4].size_less4
                + ps[5].size_less4;
  }


  //-------------------------------------------------------------------------//
  //-------------------------------------------------------------------------//
  //-------------------------------------------------------------------------//
  //-------------------------------------------------------------------------//
  // Adjust the size reported by the WEBPAGE_PARSEFAIL template
  //-------------------------------------------------------------------------//
  //-------------------------------------------------------------------------//
  //-------------------------------------------------------------------------//
  //-------------------------------------------------------------------------//
  else if (pSocket->current_webpage == WEBPAGE_PARSEFAIL) {
    size = (uint16_t)(sizeof(g_HtmlPageParseFail) - 1);
    
    // Account for header replacement strings %y04 %y05
    size = size + ps[4].size_less4
                + ps[5].size_less4;
    
    // Account for I2C EEPROM status string %s02
    // size = size + (value size - marker_field_size)
    // size = size + (40 - 4);
    size = size + 36;
  }

#endif // BUILD_SUPPORT == CODE_UPLOADER_BUILD


/*
#if OB_EEPROM_SUPPORT == 1
  //-------------------------------------------------------------------------//
  //-------------------------------------------------------------------------//
  //-------------------------------------------------------------------------//
  //-------------------------------------------------------------------------//
  // Adjust the size reported by the WEBPAGE_EEPROM_MISSING template
  //-------------------------------------------------------------------------//
  //-------------------------------------------------------------------------//
  //-------------------------------------------------------------------------//
  //-------------------------------------------------------------------------//
  else if (pSocket->current_webpage == WEBPAGE_EEPROM_MISSING) {
    size = (uint16_t)(sizeof(g_HtmlPageEEPROMMissing) - 1);
    
    // Account for header replacement strings %y04 %y05
    size = size + ps[4].size_less4
                + ps[5].size_less4;    
  }
#endif // OB_EEPROM_SUPPORT == 1
*/
#if OB_EEPROM_SUPPORT == 1
  //-------------------------------------------------------------------------//
  //-------------------------------------------------------------------------//
  //-------------------------------------------------------------------------//
  //-------------------------------------------------------------------------//
  // Adjust the size reported by the WEBPAGE_EEPROM_MISSING template
  //-------------------------------------------------------------------------//
  //-------------------------------------------------------------------------//
  //-------------------------------------------------------------------------//
  //-------------------------------------------------------------------------//
  else if (pSocket->current_webpage == WEBPAGE_EEPROM_MISSING) {
    size = (uint16_t)(sizeof(g_HtmlPageEEPROMMissing) - 1);
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
  //
  // The calling routine is responsible for making sure the pad value does not
  // exceed the length of str - 1 (-1 to account for the terminator that must
  // also be stored in str).
  //
  // The conversion will end once the pad value is reached even if the num
  // value has not been fully consumed. This is an error of course - but it
  // should not occur if the calling routine has done adequate checks of the
  // num value vs the pad value.
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
    if (i == pad) {
      // Don't exceed the length identified by "pad" even if there are more
      // digits. Note this may produce an erroneous output.
      break;
    }    
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
  // Convert a single hex character to an integer (a nibble) with a value
  // of 0x00 to 0x0f (0 to 15 decimal).
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


void int16to4hex(uint16_t i)
{
  uint8_t j;
  // Convert a 16-bit integer into four hex characters (four nibbles).
  // Put the result in global variable OctetArray.
  j = (uint8_t)(i>>12);
  OctetArray[0] = int2nibble(j);
  
  j = (uint8_t)(i>>8);
  j &= 0x000f;
  OctetArray[1] = int2nibble(j);
  
  j = (uint8_t)(i>>4);
  j &= 0x000f;
  OctetArray[2] = int2nibble(j);
  
  j = (uint8_t)(i & 0x000f);
  OctetArray[3] = int2nibble(j);
  
  OctetArray[4] = '\0';
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
  // output buffer. This function is called from the HttpDCall() function
  // (see the "senddata:" part of that function).
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
  if (pSocket->current_webpage == WEBPAGE_IOCONTROL
   || pSocket->current_webpage == WEBPAGE_CONFIGURATION
#if PCF8574_SUPPORT == 1
   || pSocket->current_webpage == WEBPAGE_PCF8574_IOCONTROL
   || pSocket->current_webpage == WEBPAGE_PCF8574_CONFIGURATION
#endif // PCF8574_SUPPORT == 1
   || pSocket->current_webpage == WEBPAGE_LOADUPLOADER) {
    // This code is applicable only when the I2C EERPOM is used to store
    // a webpage template.
    // Reading templates from the I2C EEPROM is very slow relative to reading
    // the templates from STM8 Flash. So the "pre_buf[]" array is used to bulk
    // read template data from the I2C EEPROM to improve code speed. The
    // pre_buf is then used to provide data to the webpage transmission code.
    // Optimization:
    //  - Packet transmission size will never exceed 440 bytes
    //  - There isn't enough RAM to have a 440 byte buffer so later in the
    //    process the pre_buf gets re-loaded
    //  - Thus the pre_buf only needs to be about 230 bytes (to minimize the
    //    amount of data read from the I2C EEPROM per packet, thus minimizing
    //    time spent reading the data).
    //  - I say "about 230 bytes" because there is some variability in how
    //    much needs to be read due to the need to compensate for aliasing of
    //    the read-from-EEPROM vs the collection of "%-nParsedMode-nParsedNum"
    //    values. To account for this aliasing the buffer will get refilled
    //    a few bytes before it is completely empty (see the refill code
    //    further below).
    
    {
      uint16_t i;
      
      prep_read(I2C_EEPROM2_WRITE, I2C_EEPROM2_READ, off_board_eeprom_index, 2);
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
    // Flash and inserting variable data as the webpage is copied to the
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
        if (pSocket->current_webpage == WEBPAGE_IOCONTROL
	 || pSocket->current_webpage == WEBPAGE_CONFIGURATION
#if PCF8574_SUPPORT == 1
         || pSocket->current_webpage == WEBPAGE_PCF8574_IOCONTROL
	 || pSocket->current_webpage == WEBPAGE_PCF8574_CONFIGURATION
#endif // PCF8574_SUPPORT == 1
	 || pSocket->current_webpage == WEBPAGE_LOADUPLOADER) {
          {
            uint16_t i;
            // This code is applicable only when the I2C EERPOM is used
	    // to store a webpage template.
            //
            // If we arrive here and find that the pre_buf is almost empty then
	    // refill it starting with the current location in the
	    // off_board_eeprom_index. Since the pre_buf_ptr can get incre-
	    // mented up to 4 times before we check it again we need to reload
	    // the buffer brefore we reach the end of the buffer. Since we are
	    // reloading from the current point in the I2C EEPROM (pointed to by
	    // off_board_eeprom_index) no remaining data in the pre_buf is lost.
            if (pre_buf_ptr > (PRE_BUF_SIZE - 6)) {
              prep_read(I2C_EEPROM2_WRITE, I2C_EEPROM2_READ, off_board_eeprom_index, 2);
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
	// %A - Device name displayed in the PCF8574 Configuration page.
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
        // %g - "Config" string to control BME280 Enable, Disable Cfg Button,
	//      DS18B20 Enable, MQTT Enable, Full/Half Duplex, and Home
	//      Assistant Auto Discovery Enable. Input and Output.
	// %h - Pin Control string - The pin control string is defined as 32
	//      characters representing 16 hex bytes of information in text
	//      format. Each byte is the pin_control character for each IO
	//      pin. Input and Output.
	// %H - Pin Control string for PCF8574 - The pin control string is
	//      defined as 16 characters representing 16 hex bytes of
	//      information in text format. Each byte is the pin_control
	//      character for each PCF8574 IO pin. Input and Output.
	// %i - IO Timer values
	// %j - IO Names
	// %I - IO Timer values for PCF8574 device
	// %J - IO Names for PCF8574 device
        // %l - MQTT Username - This is a user entered text field with a
	//      Username. Used in MQTT communication. Input and output.
        // %m - MQTT Password - This is a user entered text field with a
	//      Password. Used in MQTT communication. Input and output.
        // %n - MQTT Status - Displays red or green boxes to indicate startup
	//      status for MQTT (Connection Available, ARP OK, TCP OK, Connect
	//      OK, MQTT_OK). Output only.
	// %s - I2C EEPROM presence status. Output only.
	// %t - Temperature Sensor data or BME280 data. Output only.
	// %w - General purpose output strings:
	//        00 - Code Revision
	//        01 - Pinout Option
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
          if (pSocket->current_webpage == WEBPAGE_IOCONTROL
	   || pSocket->current_webpage == WEBPAGE_CONFIGURATION
#if PCF8574_SUPPORT == 1
           || pSocket->current_webpage == WEBPAGE_PCF8574_IOCONTROL
           || pSocket->current_webpage == WEBPAGE_PCF8574_CONFIGURATION
#endif // PCF8574_SUPPORT == 1
	   || pSocket->current_webpage == WEBPAGE_LOADUPLOADER) {
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
          if (pSocket->current_webpage == WEBPAGE_IOCONTROL
	   || pSocket->current_webpage == WEBPAGE_CONFIGURATION
#if PCF8574_SUPPORT == 1
           || pSocket->current_webpage == WEBPAGE_PCF8574_IOCONTROL
	   || pSocket->current_webpage == WEBPAGE_PCF8574_CONFIGURATION
#endif // PCF8574_SUPPORT == 1
	   || pSocket->current_webpage == WEBPAGE_LOADUPLOADER) {
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
          if (pSocket->current_webpage == WEBPAGE_IOCONTROL
	   || pSocket->current_webpage == WEBPAGE_CONFIGURATION
#if PCF8574_SUPPORT == 1
           || pSocket->current_webpage == WEBPAGE_PCF8574_IOCONTROL
	   || pSocket->current_webpage == WEBPAGE_PCF8574_CONFIGURATION
#endif // PCF8574_SUPPORT == 1
	   || pSocket->current_webpage == WEBPAGE_LOADUPLOADER) {
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
          if (pSocket->current_webpage == WEBPAGE_IOCONTROL
	   || pSocket->current_webpage == WEBPAGE_CONFIGURATION
#if PCF8574_SUPPORT == 1
           || pSocket->current_webpage == WEBPAGE_PCF8574_IOCONTROL
	   || pSocket->current_webpage == WEBPAGE_PCF8574_CONFIGURATION
#endif // PCF8574_SUPPORT == 1
	   || pSocket->current_webpage == WEBPAGE_LOADUPLOADER) {
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

#if PCF8574_SUPPORT == 0
        if (nParsedMode == 'a') {
#endif // PCF8574_SUPPORT == 0
#if PCF8574_SUPPORT == 1
        if ((nParsedMode == 'a') || (nParsedMode == 'A')) {
#endif // PCF8574_SUPPORT == 1
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
	  // If nParsedNum == 1 this is the MQTT Host Port number (5 characters)
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
	  // This displays the Link Error Statistics
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
          else if (nParsedNum == 34) {
	    for (i=5; i<10; i++) {
              int2hex(stored_debug[i]);
              pBuffer = stpcpy(pBuffer, OctetArray);
	    }
	  }
          else if (nParsedNum == 35) {
            pBuffer = stpcpy(pBuffer, "0000");
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
	  // Display the pin state information in the format used by the "98"
	  // and "99" command. "99" is the command used in the original
	  // Network Module.
	  // For output pins display the state in the pin_control byte.
	  // For input pins if the Invert bit is set the ON_OFF state needs to
	  // be inverted before displaying.
	  // Bits are output for Pin 16 first and Pin 1 last
	  // If PCF8574 is implemented bits are output for Pin 24 first and
	  // Pin 1 last.
	  // If stored_options1 bit 0x10 is set then any Disabled pin must be
	  // shown as '-'. Otherwise the last known pin state is displayed.

#if PCF8574_SUPPORT == 0
	  i = 15;
#endif // PCF8574_SUPPORT == 0
#if PCF8574_SUPPORT == 1
          if (stored_options1 & 0x08) i = 23;
          else i = 15;
#endif // PCF8574_SUPPORT == 1

          while( 1 ) {
	    if (((pin_control[i] & 0x03) == 0x00) && ((stored_options1 & 0x10) == 0x10)) {
	      // This is a Disabled pin and Option is set to display a '-'
	      *pBuffer++ = '-';
	    }
#if LINKED_SUPPORT == 0
	    else if (pin_control[i] & 0x02) {
#endif // LINKED_SUPPORT == 0
#if LINKED_SUPPORT == 1
            else if (chk_iotype(pin_control[i], i, 0x03) == 0x03) {
#endif // LINKED_SUPPORT == 1
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
          // Bit 5: BME280
	  //        1 = Enable, 0 = Disable
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
	
	
#if LINKED_SUPPORT == 0
        else if (nParsedMode == 'h') {
	  // This sends the Pin Control String, defined as follows:
	  // 32 characters
	  // The 32 characters represent 16 hex bytes of information in text
	  // format. Each byte is the pin_control character for each IO pin
	  // starting with pin 01 on the left.
	  // Just a reminder: The code calls the first pin "00", but the GUI
	  // shows it as Pin 1.
	  // Note: Input pins need to have the ON/OFF bit inverted if the
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
#if PCF8574_SUPPORT == 1
        else if (nParsedMode == 'H') {
	  // This sends the Pin Control String to the PCF8574 Configuration
	  // and IOControl pages, defined as follows:
	  // 16 characters
	  // The 16 characters represent 8 hex bytes of information in text
	  // format. Each byte is the pin_control character for each IO
	  // starting with IO 17 on the left.
	  // Note: Input pins need to have the ON/OFF bit inverted if the
	  //   Invert bit is set.
	  	  
	  // Insert pin_control bytes
	  {
	    int i;
	    uint8_t j;
	    for (i = 16; i <24; i++) {
	      j = pin_control[i];
	      if ((j & 0x02) == 0x00) {
	        // This is an input pin - check the invert bit
	        if (j & 0x04) { // Invert is set - flip the ON/OFF bit
		  if (j & 0x80) j &= 0x7f;
		  else j |= 0x80;
		}
	      }
	      // IO 16 to 23 are sent to the GUI
	      int2hex(j);
	      pBuffer = stpcpy(pBuffer, OctetArray);
            }
	  }
	}
#endif // PCF8574_SUPPORT == 1
#endif // LINKED_SUPPORT == 0

#if LINKED_SUPPORT == 1
        else if (nParsedMode == 'h') {
	  // This sends the Pin Control String, defined as follows:
	  // 32 characters
	  // The 32 characters represent 16 hex bytes of information in text
	  // format. Each byte is the pin_control character for each IO pin
	  // starting with pin 01 on the left.
	  // Note1: Input pins need to have the ON/OFF bit inverted if the
	  //   Invert bit is set.
	  // Note2: A special case applies to the IOCONTROL webpages. For pins
	  //   to display properly when Linked pins are being used the linked
	  //   pins must be translated into Input or Output pin types for
	  //   display in the IOControl GUI.
	  // Note 3: The IOCONTROL page returns the hxx values but the code
	  //   only looks at the ON/OFF bit of the returned hxx values. So the
	  //   fact that the Linked pin types have been altered to look like
	  //   Input or Output pin types for the GUI display will not upset
	  //   the rest of the code.
          	  	  
	  // Insert pin_control bytes
	  {
	    int i;
	    uint8_t j;
	    for (i = 0; i <16; i++) {
	      j = pin_control[i];
	      if (pSocket->current_webpage == WEBPAGE_IOCONTROL) {
	        if (chk_iotype(j, i, 0x03) == 0x03) {
                  // This is an Output. Make sure the Pin Type bits are set to
		  // Output (in case they were set to Linked.
		  j |= 0x03;
		}
	        if (chk_iotype(j, i, 0x03) == 0x01) {
                  // This is an Input. Make sure the Pin Type bits are set to
		  // Input (in case they were set to Linked.
		  j = (uint8_t)(j & 0xfc);
		  j |= 0x01;
		}
	      }

              if (chk_iotype(j, i, 0x03) == 0x01) {
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
#if PCF8574_SUPPORT == 1
        else if (nParsedMode == 'H') {
	  // This sends the Pin Control String to the PCF8574 Configuration
	  // and IOControl pages, defined as follows:
	  // 16 characters
	  // The 16 characters represent 8 hex bytes of information in text
	  // format. Each byte is the pin_control character for each IO pin
	  // starting with pin 17 on the left.
	  // Note1: Input pins need to have the ON/OFF bit inverted if the
	  //   Invert bit is set.
	  // Note2: A special case applies to the IOCONTROL webpages. For pins
	  //   to display properly when Linked pins are being used the linked
	  //   pins must be translated into Input or Output pin types for
	  //   display in the IOControl GUI.
	  // Note 3: The IOCONTROL page returns the Hxx values but the code
	  //   only looks at the ON/OFF bit of the returned Hxx values. So the
	  //   fact that the Linked pin types have been altered to look like
	  //   Input or Output pin types for the GUI display will not upset
	  //   the rest of the code.
          	  	  
	  // Insert pin_control bytes
	  {
	    int i;
	    uint8_t j;
	    for (i = 16; i <24; i++) {
	      j = pin_control[i];
	      if (pSocket->current_webpage == WEBPAGE_PCF8574_IOCONTROL) {
	        if (chk_iotype(j, i, 0x03) == 0x03) {
                  // This is an Output. Make sure the Pin Type bits are set to
		  // Output (in case they were set to Linked.
		  j |= 0x03;
		}
	        if (chk_iotype(j, i, 0x03) == 0x01) {
                  // This is an Input. Make sure the Pin Type bits are set to
		  // Input (in case they were set to Linked.
		  j = (uint8_t)(j & 0xfc);
		  j |= 0x01;
		}
	      }

              if (chk_iotype(j, i, 0x03) == 0x01) {
	        // This is an input pin - check the invert bit
	        if (j & 0x04) { // Invert is set - flip the ON/OFF bit
		  if (j & 0x80) j &= 0x7f;
		  else j |= 0x80;
		}
	      }
	      // IO 16 to 23 are sent to the GUI
	      int2hex(j);
	      pBuffer = stpcpy(pBuffer, OctetArray);
            }
	  }
	}
#endif // PCF8574_SUPPORT == 1
#endif // LINKED_SUPPORT == 1


#if BUILD_SUPPORT == BROWSER_ONLY_BUILD
        else if (nParsedMode == 'i') {
	  // This sends the IO 1 to 16 IO Timer units and IO Timer values to
	  // the Browser Configuration page.
	  // Defined as follows:
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
#if PCF8574_SUPPORT == 1
        else if (nParsedMode == 'I') {
	  // This sends the PCF8574 IO Timer units and IO Timer values to the
	  // PCF8574 Browser Configuration page.
	  // Defined as follows:
	  // 2 bytes represented as hex encoded strings (4 nibbles)
	  // Upper 2 bits are units
	  // Lower 14 bits are value
	  {
	    uint8_t j;
            uint16_t IO_timer_value;
	    // Read the PCF8574 IO_TIMER value from I2C EEPROM
            prep_read(I2C_EEPROM2_WRITE, I2C_EEPROM2_READ, PCF8574_I2C_EEPROM_START_IO_TIMERS + ((nParsedNum - 16) * 2), 2);
            IO_timer_value = read_two_bytes();
	    j = (uint8_t)((IO_timer_value & 0xff00) >> 8);
	    int2hex(j);
            pBuffer = stpcpy(pBuffer, OctetArray);
	    j = (uint8_t)(IO_timer_value & 0x00ff);
	    int2hex(j);
            pBuffer = stpcpy(pBuffer, OctetArray);
          }
	}
#endif // PCF8574_SUPPORT == 1
	
	
        else if (nParsedMode == 'j') {
	  // This displays IO Names in user friendly format (1 to 15
	  // characters)
          pBuffer = stpcpy(pBuffer, IO_NAME[nParsedNum]);
	}
#if PCF8574_SUPPORT == 1
        else if (nParsedMode == 'J') {
          // This displays PCF8574 IO Names in user friendly format (1 to 15
          // characters)
          // These names are for IO 17 to 24 (nParsedNum 17 to 24)
	  {
	    int i;
	    char temp_byte[16];
            // Read a PCF8574_IO_NAMES value from I2C EEPROM
            prep_read(I2C_EEPROM2_WRITE, I2C_EEPROM2_READ, PCF8574_I2C_EEPROM_START_IO_NAMES + ((nParsedNum - 16) * 16), 2);
            for (i=0; i<15; i++) {
              temp_byte[i] = I2C_read_byte(0);
            }
            temp_byte[15] = I2C_read_byte(1);
            pBuffer = stpcpy(pBuffer, temp_byte);
          }
	}
#endif // PCF8574_SUPPORT == 1
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
	    else if (upgrade_failcode == UPGRADE_FAIL_INVALID_FILETYPE)
	      pBuffer = stpcpy(pBuffer, "Invalid File Type.......................");
	    else if (upgrade_failcode == UPGRADE_FAIL_TRUNCATED_FILE)
	      pBuffer = stpcpy(pBuffer, "Truncated File..........................");
	    else
	      pBuffer = stpcpy(pBuffer, "Unknown Error...........................");
	  }
#endif // BUILD_SUPPORT == CODE_UPLOADER_BUILD
	}
#endif // OB_EEPROM_SUPPORT == 1


#if DS18B20_SUPPORT == 1
        else if ((nParsedMode == 't') && (stored_config_settings & 0x08)) {
	  // This displays temperature sensor data for 5 sensors and the
	  // text fields around that data IF DS18B20 mode is enabled. The
	  // possible nParsedNum values for DS18B20 sensors are 0, 1, 2, 3, 4.
	  
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
	  else if (nParsedNum <= 4) {
	    pBuffer = stpcpy(pBuffer, " ------------ ");
	  }
	  if (nParsedNum <= 4) {
	    // Output temperature data
            pBuffer = show_temperature_string(pBuffer, nParsedNum);
	    if (nParsedNum == 4) {
	      #define TEMPTEXT "</p>"
	      pBuffer = stpcpy(pBuffer, TEMPTEXT);
	      #undef TEMPTEXT
	    }
	  }
	}
#endif // DS18B20_SUPPORT == 1


#if BME280_SUPPORT == 1
        else if ((nParsedMode == 't') && (stored_config_settings & 0x20)) {
	  // This displays temperature, pressure, and humidity data from the
	  // BME280 sensor and the text fields around that data IF BME280
	  // mode is enabled. It also shows the user entered altitude.
	  if (nParsedNum == 5) {
            // Output Temperature, Pressure, Humidity, and Altitude data
            pBuffer = show_BME280_PTH_string(pBuffer);
	  }
	}
#endif // BME280_SUPPORT == 1


        else if (nParsedMode == 'w') {
	  // This displays Code Revision information (13 characters) plus Code
	  // Type (13 characters, '.' characters are added to make sure the
	  // length is always 13)
	  if (nParsedNum == 0) {
            pBuffer = stpcpy(pBuffer, code_revision);
	  
// #if BUILD_SUPPORT == BROWSER_ONLY_BUILD && I2C_SUPPORT == 0 && OB_EEPROM_SUPPORT == 0
#if BUILD_TYPE_BROWSER_STANDARD == 1
            pBuffer = stpcpy(pBuffer, " Browser Only");
#endif

// #if BUILD_SUPPORT == MQTT_BUILD && I2C_SUPPORT == 0 && OB_EEPROM_SUPPORT == 0
#if BUILD_TYPE_MQTT_STANDARD == 1
            pBuffer = stpcpy(pBuffer, " MQTT .......");
#endif

// #if BUILD_SUPPORT == BROWSER_ONLY_BUILD && I2C_SUPPORT == 1 && OB_EEPROM_SUPPORT == 1
#if BUILD_TYPE_BROWSER_UPGRADEABLE == 1
            pBuffer = stpcpy(pBuffer, " Browser UPG ");
#endif

// #if BUILD_SUPPORT == MQTT_BUILD && I2C_SUPPORT == 1 && OB_EEPROM_SUPPORT == 1
#if BUILD_TYPE_MQTT_UPGRADEABLE == 1
            pBuffer = stpcpy(pBuffer, " MQTT UPG ...");
#endif

// #if BUILD_SUPPORT == MQTT_BUILD && I2C_SUPPORT == 1 && OB_EEPROM_SUPPORT == 1 && BME280_SUPPORT == 1
#if BUILD_TYPE_MQTT_UPGRADEABLE_BME280 == 1
            pBuffer = stpcpy(pBuffer, " MQTT UPG BME");
#endif
          }
	  
	  if (nParsedNum == 1) {
	    // Show the Pinout Option (1, 2, or 3 as stored in the EEPROM)
	    *pBuffer = (uint8_t)((stored_options1 & 0x07) + 0x30);
	    pBuffer++;
	  }
	  
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
        if (pSocket->current_webpage == WEBPAGE_IOCONTROL
	 || pSocket->current_webpage == WEBPAGE_CONFIGURATION
#if PCF8574_SUPPORT == 1
         || pSocket->current_webpage == WEBPAGE_PCF8574_IOCONTROL
	 || pSocket->current_webpage == WEBPAGE_PCF8574_CONFIGURATION
#endif // PCF8574_SUPPORT == 1
	 || pSocket->current_webpage == WEBPAGE_LOADUPLOADER) {
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


#if DS18B20_SUPPORT == 1
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
#endif // DS18B20_SUPPORT == 1


#if BME280_SUPPORT == 1
char *show_BME280_PTH_string(char *pBuffer)
{
  int32_t temp_whole;
  int32_t temp_dec;
  int32_t temp_F;
  
  pBuffer = stpcpy(pBuffer, "<p>BME280 Sensor<br>");
  
  // Display temperature in degrees C and degrees F
  // Note: &#8451; inserts a degree symbol followed by C.
  // Note: &#8457; inserts a degree symbol followed by F.
  // Temperature range is -40 to +85C
  // Temperature value in the comp_data is a fixed point signed integer.
  // Examples:
  //   A value of 5632 (0x00001600) is DegC 56.32.
  //   A value of -5632 (0xffffea00) is DegC -56.32.
  //   Always 2 decimal digits.
  
  create_sensor_ID(0);                     // Create Temp sensor ID
  pBuffer = stpcpy(pBuffer, OctetArray);   // Display ID
  pBuffer = stpcpy(pBuffer, " Temp ");     // Display "Temp " text
  
  // Display temperature in degrees C (native output of sensor)
  // Convert BME280 temperature to string in OctetArray
  BME280_temperature_string_C();
  pBuffer = stpcpy(pBuffer, OctetArray);   // Copy temperature string to Browser
  #define TEMPTEXT "&#8451; "
  pBuffer = stpcpy(pBuffer, TEMPTEXT);     // Display degress C symbol plus space
  #undef TEMPTEXT

  // Convert C to F
  // Note: Value directly out of the sensor is temperature in Degree C times
  // 100.
  temp_F = (int32_t)((comp_data_temperature * 9) / 5) + 3200;
  // Calculate the whole number part of number
  temp_whole = (temp_F / 100);
  // Calculate decimal part of number
  temp_dec = temp_F - (temp_whole * 100);
  
  if (temp_F < 0) {
    pBuffer = stpcpy(pBuffer, "-");        // Insert minus sign
  }
  else {
    pBuffer = stpcpy(pBuffer, " ");        // Insert space
  }

  emb_itoa((uint32_t)temp_whole, OctetArray, 10, 3);
  pBuffer = stpcpy(pBuffer, OctetArray);   // Display sensor value
  pBuffer = stpcpy(pBuffer, ".");          // Insert decimal dot
  emb_itoa((uint32_t)temp_dec, OctetArray, 10, 2);
  pBuffer = stpcpy(pBuffer, OctetArray);   // Display sensor value
  #define TEMPTEXT "&#8457;<br>"
  pBuffer = stpcpy(pBuffer, TEMPTEXT);     // Display degress F symbol plus newline
  #undef TEMPTEXT



  // Pressure range is 300 to 1100 hPa.
  create_sensor_ID(1);                     // Create Pressure sensor ID
  pBuffer = stpcpy(pBuffer, OctetArray);   // Display ID
  pBuffer = stpcpy(pBuffer, " Pressure "); // Display "Pressure " text
  BME280_pressure_string();                // Convert pressure to string
  pBuffer = stpcpy(pBuffer, OctetArray);   // Display sensor value
  pBuffer = stpcpy(pBuffer, " hPa<br>");   // Insert newline


  // Humidity range is 0 to 100 percent.
  create_sensor_ID(2);                     // Create Humidity sensor ID
  pBuffer = stpcpy(pBuffer, OctetArray);   // Display ID
  pBuffer = stpcpy(pBuffer, " Humidity "); // Display "Humidity " text
  BME280_humidity_string();                // Convert humidity to string
  pBuffer = stpcpy(pBuffer, OctetArray);   // Display sensor value
  pBuffer = stpcpy(pBuffer, "%<br>");      // Display % sign plus newline


  // Altitude entered by user.
  pBuffer = stpcpy(pBuffer, "Altitude ");  // Display "Altitude " text
  // Convert altitude to meters
  temp_whole = stored_altitude;
  temp_whole = ((temp_whole * 3048) / 10000);
  // Handle negative altitudes
  if (stored_altitude < 0) {
    temp_whole = (uint32_t)(temp_whole * -1);
    pBuffer = stpcpy(pBuffer, "-");        // Insert minus sign
  }
  else {
    pBuffer = stpcpy(pBuffer, " ");        // Insert space
  }
  
  emb_itoa((uint32_t)temp_whole, OctetArray, 10, 5);
  pBuffer = stpcpy(pBuffer, OctetArray);   // Display value in meters
  pBuffer = stpcpy(pBuffer, " meters ");

  // Show altitude in feet
  if (stored_altitude < 0) {
    pBuffer = stpcpy(pBuffer, "-");        // Insert minus sign
  }
  else {
    pBuffer = stpcpy(pBuffer, " ");        // Insert space
  }
  
  emb_itoa((uint16_t)stored_altitude, OctetArray, 10, 5);
  pBuffer = stpcpy(pBuffer, OctetArray);   // Display value in feet
  pBuffer = stpcpy(pBuffer, " feet</p>");

  return pBuffer;
}
#endif // BME280_SUPPORT == 1


#if BME280_SUPPORT == 1
void create_sensor_ID(int8_t sensor)
{
  // Create the sensor ID and store it in OctetArray
  
  char temp_string[13];

  // Create the sensor number for the app_message and topic.
  // Add first part of sensor ID to temp_string. For the BME280 the ID
  // is "BME280" plus a one digit number contained in sensor:
  //   0 = Temperature
  //   1 = Pressure
  //   2 = Humidity 
  temp_string[0] = 'B';
  temp_string[1] = 'M';
  temp_string[2] = 'E';
  temp_string[3] = '2';
  temp_string[4] = '8';
  temp_string[5] = '0';
  temp_string[6] = '-';
  if (sensor == 0) temp_string[7] = '0';
  if (sensor == 1) temp_string[7] = '1';
  if (sensor == 2) temp_string[7] = '2';
  // Isolate the two least significant octets of the uip_hostaddr (the module
  // IP address). Convert these two octets into a 4 character hexidecimal and use
  // that to create a unique ID for the BME280 sensor.
  int2hex(stored_hostaddr[1]);
  temp_string[8] = OctetArray[0];
  temp_string[9] = OctetArray[1];
  int2hex(stored_hostaddr[0]);
  temp_string[10] = OctetArray[0];
  temp_string[11] = OctetArray[1];
  temp_string[12] = '\0';

  strcpy(OctetArray, temp_string);
}
#endif // BME280_SUPPORT == 1


#if BME280_SUPPORT == 1
void BME280_temperature_string_C(void)
{
  // Convert the BME280 temperature into a string in OctetArray.
  // Degrees C is the native output of the sensor.
  
  int32_t temp_whole;
  int32_t temp_dec;
  char temp_string[11];
  
  // Calculate the whole number part of number
  temp_whole = (comp_data_temperature / 100);
  // Calculate decimal part of number
  temp_dec = comp_data_temperature - (temp_whole * 100);
  
  // Handle negative temperatures
  if (comp_data_temperature < 0) {
    temp_whole = (uint32_t)(temp_whole * -1);
    temp_dec = (uint32_t)(temp_dec * -1);
    temp_string[0] = '-';
  }
  else {
    temp_string[0] = ' ';
  }

  emb_itoa((uint32_t)temp_whole, OctetArray, 10, 3);
  temp_string[1] = OctetArray[0];
  temp_string[2] = OctetArray[1];
  temp_string[3] = OctetArray[2];
  temp_string[4] = '.';
  
  emb_itoa((uint32_t)temp_dec, OctetArray, 10, 2);
  temp_string[5] = OctetArray[0];
  temp_string[6] = OctetArray[1];
  temp_string[7] = '\0';
  
  strcpy(OctetArray, temp_string);
}
#endif // BME280_SUPPORT == 1


#if BME280_SUPPORT == 1
void BME280_pressure_string(void)
{
  // Convert the BME280 pressure into a string in OctetArray.
  
  int32_t press_whole;
  
  // Pressure range is 300 to 1100 hPa.
  press_whole = altitude_adjustment();
  emb_itoa((uint32_t)press_whole, OctetArray, 10, 4);
}
#endif // BME280_SUPPORT == 1


#if BME280_SUPPORT == 1
void BME280_humidity_string(void)
{
  // Convert the BME280 humidity into a string in OctetArray.
  
  int32_t hum_whole;
  
  // Pressure range is 300 to 1100 hPa.
  hum_whole = (int32_t)(comp_data_humidity / 1024);
  emb_itoa((uint32_t)hum_whole, OctetArray, 10, 3);
}
#endif // BME280_SUPPORT == 1


#if BME280_SUPPORT == 1
char *show_space_or_minus(int32_t value, char *pBuffer)
{
  if (value < 0) pBuffer = stpcpy(pBuffer, "-"); // Insert minus sign
  else pBuffer = stpcpy(pBuffer, " ");           // Insert space
  return pBuffer;
}
#endif // BME280_SUPPORT == 1


void HttpDInit(void)
{
  // Initialize the structures that manage each connection in the form of a
  // protosocket
  int i;
  register struct uip_conn *uip_connr = uip_conn;
  
  // Initialize the struct tHttpD values
  for (i = 0; i < UIP_CONNS; i++) {
    uip_connr = &uip_conns[i];
    init_tHttpD_struct(&uip_connr->appstate.HttpDSocket, i);
  }

  // Start listening on our port
  uip_listen(htons(Port_Httpd));
}


void init_tHttpD_struct(struct tHttpD* pSocket, int i) {
  // Initialize the contents of the struct tHttpD
  // This function is called UIP_CONNS times by the HttpDinit function. It is
  // called once for each possible connection. The function sets the initial
  // values within the pSocket structure to give a new connection a "starting
  // place", such as which page to initially display when a connection is made
  // that does not call out a specific page.

#if BUILD_SUPPORT == BROWSER_ONLY_BUILD || BUILD_SUPPORT == MQTT_BUILD
  pSocket->current_webpage = WEBPAGE_NULL;
#endif // BUILD_SUPPORT == BROWSER_ONLY_BUILD || BUILD_SUPPORT == MQTT_BUILD
  
#if BUILD_SUPPORT == CODE_UPLOADER_BUILD
  pSocket->current_webpage = WEBPAGE_UPLOADER;
  // If the SWIM interface is used to install a Code Uploader, but no EEPROM
  // is present, switch to the EEPROM missing page.
  if (eeprom_detect == 0) {
    pSocket->current_webpage = WEBPAGE_EEPROM_MISSING;
  }
#endif // BUILD_SUPPORT == CODE_UPLOADER_BUILD

  pSocket->nState = STATE_NULL;
  pSocket->ParseState = PARSE_NULL;
  pSocket->nNewlines = 0;
  pSocket->insertion_index = 0;
#if OB_EEPROM_SUPPORT == 1
  init_off_board_string_pointers(pSocket);
#endif // OB_EEPROM_SUPPORT == 1
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

  if (uip_connected()) {
    //Initialize this connection

#if DEBUG_SUPPORT == 7 || DEBUG_SUPPORT == 15
rexmit_count = 0; // Used only for sending the rexmit count via UART
#endif // DEBUG_SUPPORT == 7 || DEBUG_SUPPORT == 15


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

#if PCF8574_SUPPORT == 1
    if (pSocket->current_webpage == WEBPAGE_PCF8574_IOCONTROL) {
      pSocket->pData = g_HtmlPagePCFIOControl;
      pSocket->nDataLeft = HtmlPagePCFIOControl_size;
      // nDataLeft above is used when we get around to calling CopyHttpData
      // in state STATE_SENDDATA
    }
    
    if (pSocket->current_webpage == WEBPAGE_PCF8574_CONFIGURATION) {
      pSocket->pData = g_HtmlPagePCFConfiguration;
      pSocket->nDataLeft = HtmlPagePCFConfiguration_size;
    }
#endif PCF8574_SUPPORT == 1
    
    if (pSocket->current_webpage == WEBPAGE_SSTATE) {
      pSocket->pData = g_HtmlPageSstate;
      pSocket->nDataLeft = (uint16_t)(sizeof(g_HtmlPageSstate) - 1);
    }

#if OB_EEPROM_SUPPORT == 1
    if (pSocket->current_webpage == WEBPAGE_LOADUPLOADER) {
      pSocket->pData = g_HtmlPageLoadUploader;
      pSocket->nDataLeft = HtmlPageLoadUploader_size;
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
    // if uip_acked() is true we will be in the STATE_SENDDATA state and
    // only need to run the "senddata" part of this routine. This typically
    // happens when there are multiple packets to send to the Broswer in
    // response to a POST or GET, so we may repeat this loop in
    // STATE_SENDDATA several times.
    goto senddata;
  }
  
  else if (uip_newdata()) {
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
    //   3c) With the addition of I2C EEPROMs and the ability to upload
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

#if BUILD_SUPPORT == CODE_UPLOADER_BUILD
      // Initialize the find_content_info state. It is used to manage the
      // search for the Content-Type and Content-Length phrases.
      find_content_info = SEEK_CONTENT_INFO;
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
	      // Note: "i" now contains the str_len of OctetArray
	      
	      // Convert OctetArray to an integer. This needs to be a 32 bit
	      // integer as the file content could exceed 65536 characters but
	      // will not exceed 99999
	      //
	      // See this URL for an explanation of the use of (uint16_t) and
	      // "U" in the equations below:
	      // https://www.microchip.com/forums/m1126560.aspx
	      // Note: Simple addition and subtraction doesn't seem to have this
	      // problem ... appears to be division and multiplication only.
	      // Note: Can't use atoi() ... it seems to have the same problem.
              
	      {
	      uint8_t j;
	      j = 0;
	      file_length = 0;
	      if (i > 4) file_length += ((uint32_t)(OctetArray[j++] - '0') * 10000U);
	      if (i > 3) file_length += ((uint32_t)(OctetArray[j++] - '0') * 1000U);
	      if (i > 2) file_length += ((uint32_t)(OctetArray[j++] - '0') * 100U);
	      if (i > 1) file_length += ((uint32_t)(OctetArray[j++] - '0') * 10U);
	      file_length +=            ((uint32_t)(OctetArray[j++] - '0') * 1U);
	      }
	      
              find_content_info = SEEK_FIRST_RNRN;
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
	}
        else if ((pSocket->nNewlines == 2) && (find_content_info == SEEK_SECOND_RNRN)) {
	  // Found second set of \r\n\r\n
	  // Clear nNewlines for future searches
	  pSocket->nNewlines = 0;
	  
	  // We are parsing a data file
	  // The next character in the POST should be the first character of
	  // the payload (in this case, the new program file).
          find_content_info = FOUND_CONTENT_INFO;

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
      //
      // Digit Parsing note: All digits that make up the two digit URL Command
      // (ex: /55) are interpreted as hex digits. Thus, commands can be /00 to
      // /ff.

      while (nBytes != 0) {
        if (pSocket->ParseState == PARSE_SLASH1) {
	  // When we entered the loop *pBuffer should already be pointing at
	  // the "/". If there isn't one we should display the IOControl page.
          pSocket->ParseCmd = *pBuffer;
          pBuffer++;
	  if (pSocket->ParseCmd == (uint8_t)0x2f) { // Compare to '/'
	    pSocket->ParseState = PARSE_NUMMSD;
	  }
          else {
            // Didn't find '/' - send default page
	    // While this is not a PARSE_FAIL, going through the PARSE_FAIL
	    // logic will accomplish what we want (paint the default page).
            pSocket->ParseState = PARSE_FAIL;
	  }
        }


	// ---------------------------------------------------------------- //
        // Converted the code to allow two hex digits for URL commands instead
	// of two decimal digits.
	// - Collect the "PARSE_NUMMSD" and "PARSE_NUMLSD" characters as a
	//   string.
	// - Validate that the two character string consists of hex digits.
	// - Use two_hex2int() to convert the characters to a uint8_t byte.
	//
	// Previously the URL commands used decimal values in the case
	// statements and that can continue. But the user entries will
	// actually be in hex, even if the user doesn't know they are in hex.
	// This means that a number of potential URL entries have been skipped
	// and should probably continue to be skipped to keep things simple
	// for the user. For instance, don't use the folloing for now:
	//     0a to 0f
	//     1a to 1f
	//     2a to 2f
	//     3a to 3f
	// The above only skips 6 x 4 = 24 possible commands. But in the range
	// above these values we can go ahead and create commands with the
	// full hex values.
	// ---------------------------------------------------------------- //

        else if (pSocket->ParseState == PARSE_NUMMSD) {
	  {
	    int i;
	    // Parse and validate first ParseNum digit.
	    i = hex2int(*pBuffer);
	    if (i >= 0) { // Hex nibble?
              // Still good - parse number
              pSocket->ParseNum = (uint8_t)(i << 4);
	      pSocket->ParseState = PARSE_NUMLSD;
              pSocket->nParseLeft = 1; // Set to 1 so we don't exit the parsing
	                               // while() loop yet. PARSE_NUMLSD will be
                                       // called.
              pBuffer++;
	    }
	    else {
	      // Something out of sync or invalid - exit while() loop but do
	      // not change the current_webpage
              pSocket->nParseLeft = 0; // Set to 0 so we will go on to STATE_
	                               // SENDHEADER
              pSocket->ParseState = PARSE_FAIL;
            }
	  }
        }
	
	// Parse second ParseNum digit
        if (pSocket->ParseState == PARSE_NUMLSD) {
	  i = hex2int(*pBuffer);
	  if (i >= 0) { // Hex nibble?
            // Still good - parse number
            pSocket->ParseNum |= (uint8_t)(i);
            pSocket->ParseState = PARSE_VAL;
            pSocket->nParseLeft = 1; // Set to 1 so we don't exit the parsing
	                             // while() loop yet. PARSE_VAL will be
	                             // called.
            pBuffer++;
	  }
	  else {
	    // Something out of sync or invalid - exit while() via the
	    // PARSE_FAIL logic.
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
	  // Only those Output ON/OFF commands that correspond to a pin
	  // configured as an Output will work.
	  //
	  // At this point pBuffer will be pointing at the character in the
	  // input stream that follows the "two digit" ParseNum.
	  //   Since hex digits are allowed the character following a two
	  //   digit ParseNum may need to be validated as a space for that
	  //   ParseNum to be valid. This check is needed in case the Browser
	  //   sent a request like "favicon.ico" where the first two
	  //   characters of the filename look like a pair of hex digits (ie,
	  //   "fa").
	  //   Keep in mind that some commands are allowed to have trailing
	  //   information in the command (for example /80 will have 8
	  //   additional hex digits after the /80).
	  //   Not all incoming commands are checked for a trailing space
	  //   character to reduce code size. This is a potential exposure to
	  //   filenames being received with characters that look like a
	  //   command (say a filename "01File" ... which would be interpreted
	  //   as a "01" command). I'm only aware of one typical conflict at
	  //   this time (the favicon.ico problem), so the code will only
	  //   add the filter for the "fa" digits if that command is ever
	  //   implemented.
	  //   Example code to add the filter if needed:
	  //   case 0xfa:
	  //     if (*pBuffer == ' ') {
	  //       // Validate that the command is followed by a space. If
	  //       // not then just ignore this command.
          //       ... do stuff ...
	  //     }
          //     else {
	  //       // Invalid syntax. Show default page.
	  //       pSocket->ParseState = PARSE_FAIL;
          //     }
	  //     break;
	  //   For now I suggest that the hex digits "fa" simply not be used
	  //   to save code space. But if they ARE used the above filter is
	  //   needed.
	  //
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
	  // PCF8574 Outputs:
	  // http://IP/32  Output-17OFF
	  // http://IP/33  Output-17ON
	  // http://IP/34  Output-18OFF
	  // http://IP/35  Output-18ON
	  // http://IP/36  Output-19OFF
	  // http://IP/37  Output-19ON
	  // http://IP/38  Output-20OFF
	  // http://IP/39  Output-20ON
	  // http://IP/40  Output-21OFF
	  // http://IP/41  Output-21ON
	  // http://IP/42  Output-22OFF
	  // http://IP/43  Output-22ON
	  // http://IP/44  Output-23OFF
	  // http://IP/45  Output-23ON
	  // http://IP/46  Output-24OFF
	  // http://IP/47  Output-24ON	  
	  //
          // http://IP/50  Mask and Output Pin settings
          // http://IP/51  Mask and Output Pin settings plus returns Very
	  //               Short Form IO States page
	  //
	  // http://IP/55  All Outputs ON
	  // http://IP/56  All Outputs OFF
	  //
	  // http://IP/60  Show IO Control page
	  // http://IP/61  Show Configuration page
	  // http://IP/62  Show PCF8574 IO Control page
	  // http://IP/63  Show PCF8574 Configuration page
	  //
	  // http://IP/65  Flash LED 3 times
	  // http://IP/66  Show Link Error Statistics page
	  // http://IP/67  Clear Link Error Statistics and refresh page
	  // http://IP/68  Show Network Statistics page
	  // http://IP/69  Clear Network Statistics and refresh page
          // http://IP/70  Clear the "Reset Status Register" counters
          // http://IP/71  Display the Temperature Sensor Serial Numbers
          // http://IP/72  Load the Code Uploader (works only in runtime
	  //               builds)
          // http://IP/73  Restore (works only in the Code Uploader build)
          // http://IP/74  Erase I2C EEPROM (works only in the Code Uploader
	  //               build)
	  //
          // http://IP/80  Mask and Output Pin settings (deprecated)
	  // http://IP/81  Altitude entry
	  // http://IP/82  User entered Pinout Option
	  // http://IP/83  User entered PCF8574 output byte (deprecated)
	  // http://IP/84  Short Form Option
	  // http://IP/85  Force HA Delete Msgs for PCF8574 pins
	  // http://IP/91  Reboot
	  // http://IP/98  Show Very Short Form IO States page
	  // http://IP/99  Show Short Form IO States page
	  //
	      
          GET_response_type = 200; // Default response type
          switch(pSocket->ParseNum)
	  {
#if BUILD_SUPPORT == BROWSER_ONLY_BUILD || BUILD_SUPPORT == MQTT_BUILD
	    case 0x55:
	      // Turn all outputs ON. Verify that each pin is an output
	      // and that it is enabled.
#if PCF8574_SUPPORT == 0
	      for (i=0; i<16; i++) {
#endif // PCF8574_SUPPORT == 0
#if PCF8574_SUPPORT == 1
	      for (i=0; i<24; i++) {
#endif // PCF8574_SUPPORT == 1
 		Pending_pin_control[i] = pin_control[i];
#if LINKED_SUPPORT == 0
                if ((pin_control[i] & 0x03) == 0x03) {
#endif // LINKED_SUPPORT == 0
#if LINKED_SUPPORT == 1
                if (chk_iotype(pin_control[i], i, 0x03) == 0x03) {
#endif // LINKED_SUPPORT == 1
                  // The above: If an Enabled Output, then turn on the pin
                  Pending_pin_control[i] |= 0x80;
	        }
              }
	      // Set parse_complete for the check_runtime_changes() process
              parse_complete = 1;
	      GET_response_type = 204; // No return webpage
	      break;
	      
	    case 0x56:
	      // Turn all outputs OFF. Verify that each pin is an output
	      // and that it is enabled.
#if PCF8574_SUPPORT == 0
	      for (i=0; i<16; i++) {
#endif // PCF8574_SUPPORT == 0
#if PCF8574_SUPPORT == 1
	      for (i=0; i<24; i++) {
#endif // PCF8574_SUPPORT == 1
		Pending_pin_control[i] = pin_control[i];
#if LINKED_SUPPORT == 0
                if ((pin_control[i] & 0x03) == 0x03) {
#endif // LINKED_SUPPORT == 0
#if LINKED_SUPPORT == 1
                if (chk_iotype(pin_control[i], i, 0x03) == 0x03) {
#endif // LINKED_SUPPORT == 1
                    // The above: If an Enabled Output, then turn off the pin
                    Pending_pin_control[i] &= 0x7f;
	        }
              }
	      // Set parse_complete for the check_runtime_changes() process
              parse_complete = 1;
	      GET_response_type = 204; // No return webpage
	      break;
#endif // BUILD_SUPPORT == BROWSER_ONLY_BUILD || BUILD_SUPPORT == MQTT_BUILD


#if BUILD_SUPPORT == BROWSER_ONLY_BUILD || BUILD_SUPPORT == MQTT_BUILD
            case 0x50: // Mask and Output Pin settings, returns no webpage
//            case 0x80: // Mask and Output Pin settings, returns no webpage
	    case 0x51: // Mask and Output Pin settings plus returns Very Short
	             // Form IO States page
              // This is similar to case 55 and case 56, except a 4 hex char
	      // Mask and a 4 hex char Pin State value hould also be in the
	      // buffer. Capture the characters, check validity, parse into
	      // binary values, and set the pending control bytes.
              //
              // Example URL command
              //   192.168.1.182/50ff00c300
	      //     or
              //   192.168.1.182/80ff00c300
	      //     or
              //   192.168.1.182/51ff00c300
              // The above example will affect only the upper 8 output pins
              // and will set output pins as follows:
              // Output 16 >> 11000011 << Output 9
              // Output 8 to 1 are not affected
	      // The /50... version returns no webpage
	      // The /80... version returns no webpage
	      // The /51... version returns the Very Short Form IO states page
	      //
              {
                uint16_t word;
                uint16_t mmmm;
                uint16_t pppp;
                uint16_t nibble;
                uint16_t bit_ptr;
                int i;
                int k;

                word = 0;
		mmmm = 0;
                pppp = 0;
                k = 0;
		
                while (k < 2) {
                  i = 4;
                  while (i > 0) {
                    if (hex2int(*pBuffer) != -1) {
                      nibble = (uint16_t)hex2int(*pBuffer);
                      word |= (nibble << ((i-1)*4));
                      pBuffer++;
                      i--;
                    }
                    else {
                      // Something out of sync or invalid filename. Indicate
                      // parse failure and break out of while(i) loop.
                      pSocket->ParseState = PARSE_FAIL;
                      break;
                    }
                  } // end of while(i) loop
                  if (k == 0) mmmm = word;
                  else pppp = word;
                  k++;
		  word = 0;
                  if (pSocket->ParseState == PARSE_FAIL) {
                    // If fail detected break out of while(k) loop.
                    break;
                  }
                } // end of while(k) loop
                if (pSocket->ParseState == PARSE_FAIL) {
                  // If fail detected break out of the switch, but do not
                  // change the current_webpage. This will cause the URL
                  // command to be ignored and the current webpage to be
                  // refreshed.
		  break;
		}

//                COMMENTED THIS OUT. WHILE A GOOD ADDITIONAL SYNTAX CHECK
//                IT IS OMITTED TO SAVE FLASH SPACE
//                // Now check that the URL termination is valid
//                if (*pBuffer != ' ') {
//		  pSocket->ParseState = PARSE_FAIL;
//		}
//                pBuffer++;
//                if (*pBuffer != 'H') {
//		  pSocket->ParseState = PARSE_FAIL;
//                }
		
                if (pSocket->ParseState == PARSE_FAIL) {
                  // If fail detected break out of the switch, but do not
                  // change the current_webpage. This will cause the URL
                  // command to be ignored and the current webpage to be
                  // refreshed.
                  break;
                }


                // If we didn't break out of the switch yet we should have
                // valid Mask (mmmm) and Pin State (pppp) values. Now we
		// modify the Pending_pin_control bytes accordingly.
              
                bit_ptr = 1;
                for (i=0; i<16; i++) {
                  if ((mmmm & bit_ptr) != 0) {
                    // If the Mask for this pin is non-zero check if the pin
		    // is an enabled output. If yes, uptate the pin state.
                    Pending_pin_control[i] = pin_control[i];
#if LINKED_SUPPORT == 0
                    if ((pin_control[i] & 0x03) == 0x03) {
#endif // LINKED_SUPPORT == 0
#if LINKED_SUPPORT == 1
                    if (chk_iotype(pin_control[i], i, 0x03) == 0x03) {
#endif // LINKED_SUPPORT == 1
                    // Enabled output
                      if ((pppp & bit_ptr) == 0) {
                        Pending_pin_control[i] &= 0x7f; // Output OFF
		      }
                      else {
                        Pending_pin_control[i] |= 0x80; // Output ON
		      }
                    }
                  }
		  // Shift the bit pointer and check the next pin
 		  bit_ptr = bit_ptr << 1;
                }
              }
	      // Set parse_complete for the check_runtime_changes() process
              parse_complete = 1;
	      if (pSocket->ParseNum == 0x51) {
                // Return IOPin status page
                pSocket->current_webpage = WEBPAGE_SSTATE;
                pSocket->pData = g_HtmlPageSstate;
                pSocket->nDataLeft = (uint16_t)(sizeof(g_HtmlPageSstate) - 1);
              } else {
                GET_response_type = 204; // No return webpage
	      }
              break;
#endif // BUILD_SUPPORT == BROWSER_ONLY_BUILD || BUILD_SUPPORT == MQTT_BUILD


#if BUILD_SUPPORT == BROWSER_ONLY_BUILD || BUILD_SUPPORT == MQTT_BUILD
	    case 0x60: // Show IO Control page
	      // While NOT a PARSE_FAIL, going through the PARSE_FAIL logic
	      // will accomplish what we want which is to display the
	      // IO_Control page.
	      pSocket->ParseState = PARSE_FAIL;
	      break;
	      
	    case 0x61: // Show Configuration page
	      pSocket->current_webpage = WEBPAGE_CONFIGURATION;
              pSocket->pData = g_HtmlPageConfiguration;
              pSocket->nDataLeft = HtmlPageConfiguration_size;
#if OB_EEPROM_SUPPORT == 1
              init_off_board_string_pointers(pSocket);
#endif // OB_EEPROM_SUPPORT == 1
	      break;


#if PCF8574_SUPPORT == 1
	    case 0x62: // Show PCF8574 IO Control page
	      if (stored_options1 & 0x08) {
	        pSocket->current_webpage = WEBPAGE_PCF8574_IOCONTROL;
                pSocket->pData = g_HtmlPagePCFIOControl;
                pSocket->nDataLeft = HtmlPagePCFIOControl_size;
                init_off_board_string_pointers(pSocket);
	      }
	      else pSocket->ParseState = PARSE_FAIL;
	      break;
	      
	    case 0x63: // Show PCF8574 Configuration page
	      if (stored_options1 & 0x08) {
	        pSocket->current_webpage = WEBPAGE_PCF8574_CONFIGURATION;
                pSocket->pData = g_HtmlPagePCFConfiguration;
                pSocket->nDataLeft = HtmlPagePCFConfiguration_size;
                init_off_board_string_pointers(pSocket);
	      }
	      else pSocket->ParseState = PARSE_FAIL;
	      break;
#endif // PCF8574_SUPPORT == 1
#endif // BUILD_SUPPORT == BROWSER_ONLY_BUILD || BUILD_SUPPORT == MQTT_BUILD

	    case 0x65: // Flash LED for diagnostics
	      debugflash();
	      debugflash();
	      debugflash();
	      // Show default page
	      // Show default page
	      // While NOT a PARSE_FAIL, going through the PARSE_FAIL logic
	      // will accomplish what we want which is to display the
	      // IO_Control page.
	      pSocket->ParseState = PARSE_FAIL;
	      break;

#if DEBUG_SUPPORT == 11 || DEBUG_SUPPORT == 15
            case 0x66: // Show Link Error Statistics page
	      pSocket->current_webpage = WEBPAGE_STATS2;
              pSocket->pData = g_HtmlPageStats2;
              pSocket->nDataLeft = (uint16_t)(sizeof(g_HtmlPageStats2) - 1);
	      break;
	      
            case 0x67: // Clear Link Error Statistics
	      // Clear the the Link Error Statistics bytes and Stack Overflow
	      debug[2] = (uint8_t)(debug[2] & 0x7f); // Clear the Stack Overflow bit
	      debug[3] = 0; // Clear TXERIF counter
	      debug[4] = 0; // Clear RXERIF counter
	      debug[5] = 0; // Clear EMCF counter
	      debug[6] = 0; // Clear SWIMF counter
	      debug[7] = 0; // Clear ILLOPF counter
	      debug[8] = 0; // Clear IWDGF counter
	      debug[9] = 0; // Clear WWDGF counter
	      update_debug_storage1();
	      TRANSMIT_counter = 0;
	      MQTT_resp_tout_counter = 0;
	      MQTT_not_OK_counter = 0;
	      MQTT_broker_dis_counter = 0;
	      
	      pSocket->current_webpage = WEBPAGE_STATS2;
              pSocket->pData = g_HtmlPageStats2;
              pSocket->nDataLeft = (uint16_t)(sizeof(g_HtmlPageStats2) - 1);
	      break;
#endif // DEBUG_SUPPORT == 11 || DEBUG_SUPPORT == 15

#if UIP_STATISTICS == 1 && BUILD_SUPPORT == BROWSER_ONLY_BUILD
            case 0x68: // Show Network Statistics page
	      pSocket->current_webpage = WEBPAGE_STATS1;
              pSocket->pData = g_HtmlPageStats1;
              pSocket->nDataLeft = (uint16_t)(sizeof(g_HtmlPageStats1) - 1);
	      break;
	      
            case 0x69: // Clear Network Statistics and refresh page
	      uip_init_stats();
	      pSocket->current_webpage = WEBPAGE_STATS1;
              pSocket->pData = g_HtmlPageStats1;
              pSocket->nDataLeft = (uint16_t)(sizeof(g_HtmlPageStats1) - 1);
	      break;
#endif // UIP_STATISTICS == 1 && BUILD_SUPPORT == BROWSER_ONLY_BUILD

            case 0x70: // Clear the "Reset Status Register" counters
	      // Clear the counts for EMCF, SWIMF, ILLOPF, IWDGF, WWDGF
	      // These only display via the UART
	      debug[5] = 0; // Clear EMCF counter
	      debug[6] = 0; // Clear SWIMF counter
	      debug[7] = 0; // Clear ILLOPF counter
	      debug[8] = 0; // Clear IWDGF counter
	      debug[9] = 0; // Clear WWDGF counter
	      update_debug_storage1();
	      // Show default page
	      // While NOT a PARSE_FAIL, going through the PARSE_FAIL logic
	      // will accomplish what we want which is to display the
	      // IO_Control page.
	      pSocket->ParseState = PARSE_FAIL;
	      break;

#if DEBUG_SENSOR_SERIAL == 1
            case 0x71: // Display the Temperature Sensor Serial Numbers
	      pSocket->current_webpage = WEBPAGE_SENSOR_SERIAL;
              pSocket->pData = g_HtmlPageTmpSerialNum;
              pSocket->nDataLeft = (uint16_t)(sizeof(g_HtmlPageTmpSerialNum) - 1);
	      break;
#endif // DEBUG_SENSOR_SERIAL

#if OB_EEPROM_SUPPORT == 1
#if BUILD_SUPPORT == BROWSER_ONLY_BUILD || BUILD_SUPPORT == MQTT_BUILD
            case 0x72: // Load Code Uploader
	      // Re-Check that the I2C EEPROM exists, and if it does then load
	      // the Code Uploader from I2C EEPROM1, display the Loading Code
	      // Uploader webpage, then reboot.
	      // If the I2C EEPROM does not exist dieplay an error webpage.
	      // Verify that I2C EEPROM(s) exist.
              eeprom_detect = off_board_EEPROM_detect();
	      if (eeprom_detect == 0) {
	        pSocket->current_webpage = WEBPAGE_EEPROM_MISSING;
                pSocket->pData = g_HtmlPageEEPROMMissing;
                pSocket->nDataLeft = (uint16_t)(sizeof(g_HtmlPageEEPROMMissing) - 1);
	      }
	      else {
	        pSocket->current_webpage = WEBPAGE_LOADUPLOADER;
                pSocket->pData = g_HtmlPageLoadUploader;
                pSocket->nDataLeft = HtmlPageLoadUploader_size;
                eeprom_copy_to_flash_request = I2C_COPY_EEPROM1_REQUEST;
                init_off_board_string_pointers(pSocket);
	      }
	      break;
#endif // BUILD_SUPPORT == BROWSER_ONLY_BUILD || BUILD_SUPPORT == MQTT_BUILD
	      
#if BUILD_SUPPORT == CODE_UPLOADER_BUILD
            case 0x73: // Reload firmware existing image
	      // Load the existing firmware image from I2C EEPROM0,
	      // display the Loading Existing Image webpage, then reboot.
	      pSocket->current_webpage = WEBPAGE_EXISTING_IMAGE;
              pSocket->pData = g_HtmlPageExistingImage;
              pSocket->nDataLeft = (uint16_t)(sizeof(g_HtmlPageExistingImage) - 1);
              eeprom_copy_to_flash_request = I2C_COPY_EEPROM0_REQUEST;
	      upgrade_failcode = UPGRADE_OK;
	      break;

            // case 74 commented out since it is only useful during
	    // development and could be very disruptive to a regular
	    // user.
            case 0x74: // Erase entire I2C EEPROM
              // Erase I2C EEPROM regions 0, 1, 2, and 3 to provide a clean
	      // slate. Useful mostly during development for code debug.
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
                    I2C_byte_address(temp_eeprom_address_index, 2);
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
              GET_response_type = 204; // No return webpage
              break;
#endif // BUILD_SUPPORT == CODE_UPLOADER_BUILD
#endif // OB_EEPROM_SUPPORT == 1


#if BME280_SUPPORT == 1
            case 0x81:
	      // Altitude setting for the BME280 Temperature / Pressure / 
	      // Humidity sensor.
              // This command allows the user to input the altitude of the
	      // device so that the BME280 pressure sensor can be calibrated
	      // to provide barometric pressure measurements. The altitude
	      // can be provided in Feet or Meters in Decimal with no
	      // fractional part (no decimal point).
	      // 
              // Example URL command
              //   192.168.1.182/815432F
              //   The above example provides an altitude of 5432 feet.
              //   192.168.1.182/81280M
              //   The above example provides an altitude of 280 meters.
              //   192.168.1.182/81-432F
              //   The above example provides an altitude of -432 feet.
	      // Limits for best accuracy:
	      //   Minimum altitude is -1000 feet / -304 meters
	      //   Maximum altitude is 15000 feet / 4572 meters
	      // An entry error will result in an altitude of 0.
              //
              {
                uint32_t altitude_local;
                uint8_t error;
                char digit_string[6];
                uint8_t digit_count;
                uint8_t altitude_scale;
                uint32_t multiplier;
		
		// There must be at least one digit, and up to 5 digits,
		// followed by an F (for feet) or M (for meters). Internally
		// the code uses feet for all calculations, so all "meter"
		// entries are converted to feet.
		error = 0;
		altitude_local = 0;
		
		// First character must be a digit or a minus.
		if ((*pBuffer == '-') || (isdigit(*pBuffer))) {
		  digit_string[0] = *pBuffer;
		  pBuffer++;
		}
		else error = 1;
		digit_count = 1;
		altitude_scale = 0;
		while (error == 0) {
		  // Check additional characters (up to 4 more digits, then F or
		  // M terminator.
		  // Second character position:
		  if (isdigit(*pBuffer)) {
		    // Character is a digit
		    digit_string[digit_count++] = *pBuffer;
		    pBuffer++;
		  }
		  else if (*pBuffer == 'F' || *pBuffer == 'M') {
		    // F = 0x46, M = 0x4d
		    altitude_scale = *pBuffer;
		    pBuffer++;
		    digit_string[digit_count] = '\0';
		    break;
		  }
		  else {
		    error = 1;
		    break;
		  }
		  if (digit_count == 6) {
		    // Too many digits - error
		    error = 1;
		    break;
		  }
		} // end of while
		
		if (error == 0) {
		  // No error so far
		  // If F or M terminator not found yet the next character
		  // MUST be an F or M
		  if (altitude_scale == 0) {
		    if (*pBuffer == 'F' || *pBuffer == 'M') {
		      altitude_scale = *pBuffer;
		      pBuffer++;
		    }
		    else {
		      error = 1;
		    }
		  }
		}

                if (error == 0) {
		  // No error so far
		  // Convert digit_string to altitude value
		  multiplier = 1;
		  for (i = strlen(digit_string); i > 0; i--) {
		    if (digit_string[i-1] == '-') continue;
		    altitude_local = altitude_local + ((digit_string[i-1] - '0') * multiplier);
		    multiplier = (uint32_t)(multiplier * 10);
		  }
		  if (altitude_scale == 'M') {
		    // 1 meter = 3.28084 feet
		    altitude_local = (altitude_local * 328084) / 100000;
		  }
		  if (digit_string[0] == '-') {
		    altitude_local = altitude_local * -1;
		  }
		}
		    
		if (error == 1) {
		  altitude_local = 0;
                  // Something out of sync or invalid user entry. Indicate
                  // parse failure.
		  pSocket->ParseState = PARSE_FAIL;
		}

//                COMMENTED THIS OUT. WHILE A GOOD ADDITIONAL SYNTAX CHECK
//                IT IS OMITTED TO SAVE FLASH SPACE
//                // Now check that the URL termination is valid
//                if (*pBuffer != ' ') {
//		  pSocket->ParseState = PARSE_FAIL;
//		}
//                pBuffer++;
//                if (*pBuffer != 'H') {
//		  pSocket->ParseState = PARSE_FAIL;
//               }

                if (pSocket->ParseState == PARSE_FAIL) {
                  // If fail detected break out of the switch, but do not
                  // change the current_webpage. This will cause the URL
                  // command to be ignored and the current webpage to be
                  // refreshed.
                  break;
                }
	        unlock_eeprom();	
	        stored_altitude = (int16_t)altitude_local;
		lock_eeprom();
              }
	      // Didn't break so far so parse was successful
	      // Set parse_complete for the check_runtime_changes() process
              parse_complete = 1;
              GET_response_type = 204; // No return webpage
              break;
#endif // BME280_SUPPORT == 1


#if PINOUT_OPTION_SUPPORT == 1
            case 0x82:
	      // User entered Pinout Option.
	      // Allowed to enter one digit (0 to 9) to select the pinout map
	      // for the IO pins.
	      // 
              // Example URL command
              //   192.168.1.182/821
              //   The above example selects Pinout Option 1.
	      //
	      // Note: Only Pinout Option 1 is allowed if any special pin
	      // usage is compiled (for example: UART, I2C, Temperature
	      // sensors). I2C and Temperature sensors are handled via build
	      // settings where Pinout Options are "not allowed". However, the
	      // UART can be enabled during development, over-riding the
	      // build setting. A check is done here to make sure that only
	      // Pinout Option 1 is allowed if the UART is enabled. This check
	      // is mostly a "developer helper" as the end user doesn't have
	      // access to enabling the UART.
              {
                uint8_t pinout_select;
		uint8_t j;
		
		// Accept the first character as the Pinout selection
		if (isdigit(*pBuffer)) {
		  pinout_select = (uint8_t)(*pBuffer & 0x07);
#if DEBUG_SUPPORT == 7 || DEBUG_SUPPORT == 15
                  // Force Pinout Option 1 if UART enabled
		  pinout_select = 1;
#endif // DEBUG_SUPPORT == 7 || DEBUG_SUPPORT == 15
		  if ((pinout_select > 0) && (pinout_select < 4)){
		    j = (uint8_t)(stored_options1 & 0xf8);
		    j |= pinout_select;
		    unlock_eeprom();
		    stored_options1 = j;
		    lock_eeprom();
	            user_reboot_request = 1;
		  }
	          // Set parse_complete for the check_runtime_changes() process
                  parse_complete = 1;
		}
                // Always display the IOControl page even if there is no parse
		// fail. The PARSE_FAIL state will cause this to happen.
		pSocket->ParseState = PARSE_FAIL;
              }
              break;
#endif // PINOUT_OPTION_SUPPORT == 1


            case 0x84:
	      // User entered Short Form Option.
	      // User may enter '+' or '-' to select how Disabled pins are
	      // displayed in the Short Form Status page.
	      // - The Default is for all pins to display 0 or 1 depending
	      //   on the last state of the pin.
	      // - If the user enters URL command /84- then Disabled pins will
	      //   display with a '-' character.
	      // - If the user enters URL command /84+ then Disabled pins will
	      //   display a 0 or 1 depending on the last state of the pin.
	      // - If a syntax error the command is ignored.
	      // Note: The '+' command is only supplied so that the user can
	      // reverse a '-' selection.
	      //
	      // Example URL command
              //   192.168.1.182/84-
              //   The above example selects the Short Form option which will
	      //   display a '-' for Disabled pin.

	      {
	        uint8_t i;
		uint8_t j;
		j = 0xff;
		// Accept the first character as the Short Form option
		if (*pBuffer == '-') j = 0x10;
		if (*pBuffer == '+') j = 0x00;
		if (j != 0xff) {
		  i = stored_options1;
		  // mask out current Short Form setting
		  i &= 0xef;
		  // add new Short Form setting
		  i |= j;
		  unlock_eeprom();
		  stored_options1 = i;
		  lock_eeprom();
		}
              }

              // Show Short Form IO state page
	      pSocket->current_webpage = WEBPAGE_SSTATE;
              pSocket->pData = g_HtmlPageSstate;
              pSocket->nDataLeft = (uint16_t)(sizeof(g_HtmlPageSstate) - 1);
              break;
              
              
#if PCF8574_SUPPORT == 1
	    case 0x85: // Force PCF8574 Pin Delete Msgs. Causes a reboot so
	               // that the Home Assistant Auto Discovery processes
		       // will run to generate the appropriate delete
		       // messages over MQTT to Home Assistant.
	      {
	        uint8_t j;
		int i;
	        j = stored_options1;
	        j |= 0x20;
	        unlock_eeprom();
	        stored_options1 = j;
	        lock_eeprom();
		
                // Set all PCF8574 pins to Disabled
		// XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
		// XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
		// XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
		// Note for future testing: I don't think it is necessary to
		// set the Pending_pin_control and pin_control bytes here -
		// it is only necessary to set the I2C_EEPROM bytes. Why?
		// Because this command should only be run by the user when
		// the PCF8574 has been removed. Code in main.c will not
		// process the Pending_pin_control and pin_control bytes if
		// the PCF8574 is absent. But a user_reboot_request is made
		// here, and when the reboot is performed the code in main.c
		// will update the Pending_pin_control and pin_control bytes
		// with the content of the I2C_EEPROM.
		// XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
		// XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
		// XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
                for (i = 16; i < 24; i++) {
                  Pending_pin_control[i] &= 0xfc;
                  pin_control[i] = Pending_pin_control[i];
                }
                I2C_control(I2C_EEPROM2_WRITE);
                I2C_byte_address(PCF8574_I2C_EEPROM_PIN_CONTROL_STORAGE, 2);
                for (i=16; i<24; i++) {
                  I2C_write_byte(pin_control[i]);
                }
                I2C_stop(); // Start the EEPROM internal write cycle
                wait_timer(5000); // Wait 5ms
	        user_reboot_request = 1;
                GET_response_type = 204; // No return webpage
	        break;
	      }
#endif // PCF8574_SUPPORT == 1
              
              
	    case 0x91: // Reboot
	      user_reboot_request = 1;
              GET_response_type = 204; // No return webpage
	      break;


#if BUILD_SUPPORT == BROWSER_ONLY_BUILD || BUILD_SUPPORT == MQTT_BUILD
            case 0x98: // Show Very Short Form IO state page
            case 0x99: // Show Short Form IO state page
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
#if BUILD_SUPPORT == BROWSER_ONLY_BUILD || BUILD_SUPPORT == MQTT_BUILD
#if PCF8574_SUPPORT == 0
	      if (pSocket->ParseNum < 0x32) {
                 // Output-01..16 OFF/ON
                {
                  // The logic here converts hex values to the original decimal
                  // values for IO pins. It is assumed the following cmds are
                  // not used:
                  // 0x0a to 0x0f
                  // 0x1a to 0x1f
                  // 0x2a to 0x2f
                  // 0x3a to 0x3f
                  uint8_t cmd_num;
		  cmd_num = 0;
                  if ((pSocket->ParseNum & 0x0f) < 0x0a) {
		    // The above "if" eliminates invalid hex values
		    // Covert the remaining values to decimal
                    if (pSocket->ParseNum < 0x0a) cmd_num = (uint8_t)(pSocket->ParseNum);
                    else if (pSocket->ParseNum < 0x1a) cmd_num = (uint8_t)(pSocket->ParseNum - 6);
                    else if (pSocket->ParseNum < 0x2a) cmd_num = (uint8_t)(pSocket->ParseNum - 12);
                    else if (pSocket->ParseNum < 0x32) cmd_num = (uint8_t)(pSocket->ParseNum - 18);
		    
                    update_ON_OFF((uint8_t)(cmd_num/2), (uint8_t)(cmd_num%2));
	            GET_response_type = 204; // No return webpage
                  }
                }
	      }
#endif // PCF8574_SUPPORT == 0
#if PCF8574_SUPPORT == 1
	      if (pSocket->ParseNum < 0x48) {
                 // Output-01..24 OFF/ON
                {
                  // The logic here converts hex values to the original decimal
                  // values for IO pins. It is assumed the following cmds are
                  // not used:
                  // 0x0a to 0x0f
                  // 0x1a to 0x1f
                  // 0x2a to 0x2f
                  // 0x3a to 0x3f
                  uint8_t cmd_num;
		  cmd_num = 0;
                  if ((pSocket->ParseNum & 0x0f) < 0x0a) {
                    if (pSocket->ParseNum < 0x0a) cmd_num = (uint8_t)(pSocket->ParseNum);
                    else if (pSocket->ParseNum < 0x1a) cmd_num = (uint8_t)(pSocket->ParseNum - 6);
                    else if (pSocket->ParseNum < 0x2a) cmd_num = (uint8_t)(pSocket->ParseNum - 12);
                    else if (pSocket->ParseNum < 0x3a) cmd_num = (uint8_t)(pSocket->ParseNum - 18);
                    else if (pSocket->ParseNum < 0x48) cmd_num = (uint8_t)(pSocket->ParseNum - 24);
		    
                    update_ON_OFF((uint8_t)(cmd_num/2), (uint8_t)(cmd_num%2));
	            GET_response_type = 204; // No return webpage
                  }
                }
	      }
#endif // PCF8574_SUPPORT == 1
              else
#endif // BUILD_SUPPORT == BROWSER_ONLY_BUILD || BUILD_SUPPORT == MQTT_BUILD
              {
	        // Show default page
		// While NOT a PARSE_FAIL, going through the PARSE_FAIL logic
		// will accomplish what we want.
		pSocket->ParseState = PARSE_FAIL;
              }
              break;

	  } // end switch
          pSocket->nParseLeft = 0;
        }

        if (pSocket->ParseState == PARSE_FAIL) {
          // Parsing failed above OR there was a decision to display the
	  // default webpage.

#if BUILD_SUPPORT == BROWSER_ONLY_BUILD || BUILD_SUPPORT == MQTT_BUILD
          pSocket->current_webpage = WEBPAGE_IOCONTROL;
          pSocket->pData = g_HtmlPageIOControl;
          pSocket->nDataLeft = HtmlPageIOControl_size;
#if OB_EEPROM_SUPPORT == 1
          init_off_board_string_pointers(pSocket);
#endif // OB_EEPROM_SUPPORT == 1
#endif // BUILD_SUPPORT == BROWSER_ONLY_BUILD || BUILD_SUPPORT == MQTT_BUILD

#if BUILD_SUPPORT == CODE_UPLOADER_BUILD
	  pSocket->current_webpage = WEBPAGE_UPLOADER;
          pSocket->pData = g_HtmlPageUploader;
          pSocket->nDataLeft = (uint16_t)(sizeof(g_HtmlPageUploader) - 1);
#endif // BUILD_SUPPORT == CODE_UPLOADER_BUILD

          pSocket->nParseLeft = 0; // Set to 0 so we will go on to STATE_
	                           // SENDHEADER
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
          break; // Break out of while loop
        }
      } // end of while loop
    }

    
#if BUILD_SUPPORT == CODE_UPLOADER_BUILD
    if (pSocket->nState == STATE_PARSEFILE) {
      // This step is entered if a POST containing a firmware file was
      // detected. The file contents will be copied to the I2C EEPROM,
      // then the I2C EEPROM will be copied to the internal Flash, then
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
	    break; // Break out of the local while loop
	  }
	      
          if ((search_limit > 200) || (file_length == 0)) {
            // Should have found the phrase by now. Assume this is not a valid
	    // SREC file. Break out of the loop and go to PARSE_FILE_FAIL
	    // The next character starts the SREC content
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

      if ((pSocket->ParseState != PARSE_FILE_SEEK_START) || (pSocket->ParseState == PARSE_FILE_FAIL)) {
        // If the PARSE_FILE_SEEK_START was successful this loop will process
	// the content of the file.
	// OR
	// If there was a PARSE_FILE_FAIL while seeking the start of the file
	// this loop will finish reading the file (without processing content)
	// and then exit to the user fail notification.
        while (1) {
          // This while() loop is a state machine with four main
	  // "pSocket->ParseState" states:
	  // PARSE_FILE_SEEK_SX
	  //   Parses the leading characters of each SREC looking for the SREC
	  //   type.
	  //     If the SREC type is S0 we are starting receipt of an SREC file
	  //     so the 32K I2C EEPROM0 space is erased to make it available to
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
	  // PARSE_FILE_FAIL
	  //   A parsing failure has occurred. The loop will finish reading the
	  //   file (without processing content) and then exit so the user fail
	  //   notification can occur.
	  // Normal exit: The loop will exit at end of each packet (file_nBytes
	  // == 0). This can occur at any point while reading data. The exit
	  // allows the uip functions to receive the next ethernet packet, then
	  // the STATE_PARSEFILE code will be re-entered to continue this state
	  // machine where we left off. Re-entry is made possible because
	  // "pSocket->nState" and "pSocket->ParseState" are both saved so that
	  // we know where we were when a packet ended (a TCP Fragmentation).
          
          if (pSocket->ParseState == PARSE_FILE_SEEK_SX) {
	    // This parse looks S0, S3, and S7 SREC records and will parse them
	    // based on expected content. There are error checks in the loop
	    // looking for incorrect format or unexpected end-of-file.
	    while (1) {
	      // Each time the loop starts we expect to be able to read two
	      // characters UNLESS we are at the end of a packet (which is OK)
	      // OR if we find there is only 1 character left in the file
	      // (which is not OK). Check for the end-of-file problem.
	      if (file_length < 2) {
	        // If we got here and find there are not at least 2 characters
		// left in the overall file then something has gone wrong.
                  upgrade_failcode = UPGRADE_FAIL_TRUNCATED_FILE;
	      
// UARTPrintf("UPGRADE_FAILCODE = UPGRADE_FAIL_TRUNCATED_FILE\r\n");

                  pSocket->ParseState = PARSE_FILE_FAIL;
	          break; // Break out of the local while loop
	      }
	      
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
	          break; // Break out of the local while loop
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

                  // Erase I2C EEPROM0 to provide a clean space to store the
		  // incoming SREC data.
		  
		  {
		    uint16_t i;
		    uint8_t j;
		    uint16_t temp_eeprom_address_index;
		    for (i=0; i<256; i++) {
		      // Write 256 blocks of 128 bytes each with zero
                      I2C_control(I2C_EEPROM0_WRITE); // Send Write Control Byte
		      temp_eeprom_address_index = i * 128;
                      I2C_byte_address(temp_eeprom_address_index, 2);
		      for (j=0; j<128; j++) {
		        // Write a zero byte
		        I2C_write_byte(0);
		      }
                      I2C_stop(); // Start the EEPROM internal write cycle
                      IWDG_KR = 0xaa; // Prevent the IWDG from firing.
                      // Wait for completion of write.
		      // For simplicity I'm waiting 5ms (the max time required).
		      // This loop could be sped up by using "acknowledge
		      // polling" (see the 24AA1025 EEPROM spec).
                      wait_timer(5000); // Wait 5ms
                    }
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
		    // If any data remains in parse_tail write it to the I2C EEPROM.
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
		      }
                      I2C_byte_address(eeprom_address_index, 2);
                      for (i=0; i<64; i++) {
		        I2C_write_byte(parse_tail[i]);
		      }
                      I2C_stop();
                      wait_timer(5000); // Wait 5ms
                      IWDG_KR = 0xaa; // Prevent the IWDG from firing.
                      // Validate data in I2C EEPROM
	              if (file_type == FILETYPE_PROGRAM) {
                        prep_read(I2C_EEPROM0_WRITE, I2C_EEPROM0_READ, eeprom_address_index, 2);
                      }
	              if (file_type == FILETYPE_STRING) {
                        prep_read(I2C_EEPROM2_WRITE, I2C_EEPROM2_READ, eeprom_address_index, 2);
                      }
	              I2C_last_flag = 0;
                      for (i=0; i<64; i++) {
                        if (i == 63) I2C_last_flag = 1;
                        temp_byte = I2C_read_byte(I2C_last_flag);
                        if (temp_byte != parse_tail[i]) {
                          upgrade_failcode = UPGRADE_FAIL_EEPROM_MISCOMPARE;
// UARTPrintf("UPGRADE_FAILCODE = UPGRADE_FAIL_EEPROM_MISCOMPARE\r\n");
                          pSocket->ParseState = PARSE_FILE_FAIL;
	                  break; // Break out of the local while loop
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
	        data_count--;
	        // Capture the first byte of the file type
	        // 'N' (0x4E) is a NetworkModule program file
	        // 'S' (0x53) is a String File
                if (two_hex2int(byte_tail[0], byte_tail[1]) == 0x4E) {
	          file_type = FILETYPE_PROGRAM;

// UARTPrintf("file_type = FILETYPE_PROGRAM\r\n");
	      
	        }
	        else if (two_hex2int(byte_tail[0], byte_tail[1]) == 0x53) {
	          file_type = FILETYPE_STRING;

// UARTPrintf("file_type = FILETYPE_STRING\r\n");
	      
                }
		else {
                  upgrade_failcode = UPGRADE_FAIL_INVALID_FILETYPE;
// UARTPrintf("UPGRADE_FAILCODE = UPGRADE_FAIL_INVALID_FILETYPE\r\n");
                  pSocket->ParseState = PARSE_FILE_FAIL;
                  break; // Break out of the local while loop
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
                temp_address_low = two_hex2int(byte_tail[0], byte_tail[1]);
	        data_count--;
	        checksum += (uint8_t)temp_address_low;
	        temp_address |= temp_address_low;
	      
	        if ((temp_address < 0x8000) || (temp_address > (FLASH_START_USER_RESERVE - 1))) {
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
		    //   I2C EEPROM an over-write of the I2C EEPROM content will
		    //   occur.
		    //   If the new_address is in space futher out in the I2C
		    //   EEPROM the I2C EEPROM writes will begin at that new_address.
		    // 
		    if (parse_index != 0) {
		      // If we were in the middle of writing a 64 byte block to
		      // I2C EEPROM we need to finish that. Write the 64 bytes of
		      // data that are in the parse_tail array into the I2C EEPROM.
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
			}
			
		        // At this point the eeprom_address_index will be point-
		        // ing at the start of the 64 byte I2C EEPROM block that was
		        // being processed when the out-of-sequence address was
		        // encountereed.
                        I2C_byte_address(eeprom_address_index, 2);
                        for (i=0; i<64; i++) {
		          I2C_write_byte(parse_tail[i]);
		        }
                        I2C_stop();
                        wait_timer(5000); // Wait 5ms
                        IWDG_KR = 0xaa; // Prevent the IWDG from firing.
			
                        // Validate data in I2C EEPROM
	                if (file_type == FILETYPE_PROGRAM) {
                          prep_read(I2C_EEPROM0_WRITE, I2C_EEPROM0_READ, eeprom_address_index, 2);
			}
	                if (file_type == FILETYPE_STRING) {
                          prep_read(I2C_EEPROM2_WRITE, I2C_EEPROM2_READ, eeprom_address_index, 2);
			}
			
	                I2C_last_flag = 0;
                        for (i=0; i<64; i++) {
                          if (i == 63) I2C_last_flag = 1;
                          temp_byte = I2C_read_byte(I2C_last_flag);
                           if (temp_byte != parse_tail[i]) {
                             upgrade_failcode = UPGRADE_FAIL_EEPROM_MISCOMPARE;
// UARTPrintf("UPGRADE_FAILCODE = UPGRADE_FAIL_EEPROM_MISCOMPARE\r\n");
                             pSocket->ParseState = PARSE_FILE_FAIL;
                             break; // Break out of the local while loop
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
// UARTPrintf("UPGRADE_FAILCODE = UPGRADE_FAIL_FILE_READ_CHECKSUM\r\n");
                  pSocket->ParseState = PARSE_FILE_FAIL;
                  break; // Break out of the local while loop
	        }
	      }
	    
	      if (parse_index == 64 && file_type == FILETYPE_PROGRAM) {
	        // Copy parse_tail to I2C EEPROM0
	        
                // Write the 64 bytes of data that are in the parse_tail array
                // into the I2C EEPROM.
                {
                  int i;
                  uint8_t I2C_last_flag;
                  uint8_t temp_byte;
                  
                  I2C_control(I2C_EEPROM0_WRITE); // Send Write Control Byte
                  I2C_byte_address(eeprom_address_index, 2);
                  for (i=0; i<64; i++) {
                    I2C_write_byte(parse_tail[i]);
                  }
                  I2C_stop();
                  wait_timer(5000); // Wait 5ms
                  IWDG_KR = 0xaa; // Prevent the IWDG from firing.
                  // Validate data in I2C EEPROM
                  prep_read(I2C_EEPROM0_WRITE, I2C_EEPROM0_READ, eeprom_address_index, 2);
	          I2C_last_flag = 0;
                  for (i=0; i<64; i++) {
                    if (i == 63) I2C_last_flag = 1;
                    temp_byte = I2C_read_byte(I2C_last_flag);
                    if (temp_byte != parse_tail[i]) {
                      upgrade_failcode = UPGRADE_FAIL_EEPROM_MISCOMPARE;
// UARTPrintf("UPGRADE_FAILCODE = UPGRADE_FAIL_EEPROM_MISCOMPARE\r\n");
                      pSocket->ParseState = PARSE_FILE_FAIL;
                      break; // Break out of the local while loop
                    }
                  }
                  eeprom_address_index += 64;
                }
              }
	    
	      if (parse_index == 64 && file_type == FILETYPE_STRING) {
	        // Copy parse_tail to I2C EEPROM2
	        
                // Write the 64 bytes of data that are in the parse_tail array
                // into the I2C EEPROM.
                {
                  int i;
                  uint8_t I2C_last_flag;
                  uint8_t temp_byte;
                  
                  I2C_control(I2C_EEPROM2_WRITE); // Send Write Control Byte
                  I2C_byte_address(eeprom_address_index, 2);
                  for (i=0; i<64; i++) {
                    I2C_write_byte(parse_tail[i]);
                  }
                  I2C_stop();
                  wait_timer(5000); // Wait 5ms
                  IWDG_KR = 0xaa; // Prevent the IWDG from firing.
                  // Validate data in I2C EEPROM
                  prep_read(I2C_EEPROM2_WRITE, I2C_EEPROM2_READ, eeprom_address_index, 2);
	          I2C_last_flag = 0;
                  for (i=0; i<64; i++) {
                    if (i == 63) I2C_last_flag = 1;
                    temp_byte = I2C_read_byte(I2C_last_flag);
                    if (temp_byte != parse_tail[i]) {
                      upgrade_failcode = STRING_EEPROM_MISCOMPARE;
// UARTPrintf("UPGRADE_FAILCODE = STRING_EEPROM_MISCOMPARE\r\n");
                      pSocket->ParseState = PARSE_FILE_FAIL;
                      break; // Break out of the local while loop
                    }
                  }
                  eeprom_address_index += 64;
                }
	      }

	      if (parse_index == 64) {
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
            // This is a case where the new_address is not sequential with the
	    // previous adddress.
	    //
	    // If this occurs then only the data in the SREC is copied to the I2C
	    // EEPROM, but it requires reading the existing data from the I2C EEPROM
	    // then inserting the new SREC data into the existing I2C EEPROM data.
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
	    // RELATIVE TO THE 64 BYTE WRITES TO I@C EEPROM?
	    // This is actually the typical case, so the code needs to read the
	    // existing data from the I2C EEPROM to preserve previously written
	    // data, then an offset is calculated to determine the point that
	    // new SREC data needs to start within the existing EEPROM data.
	    // a) The data to read from the I2C EEPROM is the 64 bytes starting at
	    //    ((new_address - 0x8000) & 0xFFC0).
	    // b) The offset into this data for writing the new data is
	    //    (new_address & 0x003F).
	    // NOTE: (a) and (b) are performed only once at the initial detect-
	    // ion of a non-sequential SREC case. The "non_sequential_detect"
	    // flag is used to manage this. This is necessary as TCP Fragmenta-
	    // tion may cause the process to be re-entered.
	    // c) Read the incoming SREC and write the contents to parse_tail.
	    //    If the end of parse_tail is reached or the end of the SREC is
	    //    reached write the parse_tail to the I2C EEPROM.
	    // d) If the end of the parse_tail is reached but there is still
	    //    data in the incoming SREC then read the next 64 bytes from the
	    //    I2C EEPROM into parse_tail, and continue writing the incoming SREC
	    //    data into the parse_tail starting at byte [0].
	    //    When the end of the SREC is reached write the parse_tail to
	    //    the I2C EEPROM.
	    // e) Exit comments: "address" and "eeprom_address_index" never get
	    //    changed in this process so when this parsing completes we will
	    //    go on to reading the next SREC. If that next SREC has a
	    //    new_address lower than the current address the non-sequential
	    //    process repeats. Otherwise the regular read SREC process runs.
	    
            // Why not use the above technique for every SREC?
	    // Because it would result in twice as many writes to the I2C EEPROM
	    // taking a lot longer to do the programming. Twice as many writes
	    // will occur because it is typical for the incoming data to be
	    // skewed relative to the 64 byte writes to the I2C EEPROM, and the
	    // incoming SREC data is in 32 byte blocks as opposed to the 64 byte
	    // blocks being written to the I2C EEPROM.
	  
	    if (non_sequential_detect == 1) {
	      // Calculate the starting index of the I2C EEPROM block
	      eeprom_address_index = (new_address - 0x8000) & 0xFFC0;
	      
	      // Read the existing I2C EEPROM data into parse_tail
	      if (file_type == FILETYPE_PROGRAM) {
                prep_read(I2C_EEPROM0_WRITE, I2C_EEPROM0_READ, eeprom_address_index, 2);
              }
	      if (file_type == FILETYPE_STRING) {
                prep_read(I2C_EEPROM2_WRITE, I2C_EEPROM2_READ, eeprom_address_index, 2);
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
// UARTPrintf("UPGRADE_FAILCODE = UPGRADE_FAIL_FILE_READ_CHECKSUM\r\n");
                  pSocket->ParseState = PARSE_FILE_FAIL;
                  break; // Break out of the local while loop
	        }
	        else {
	        }
	      }
	      
	      if (data_count == 0 || parse_index == 64) {
                // Copy parse_tail to I2C EEPROM0
	        
                // Write the data in the parse_tail array into the I2C
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
		  }
		  
                  I2C_byte_address(eeprom_address_index, 2);
                  for (i=0; i<64; i++) {
                    I2C_write_byte(parse_tail[i]);
                  }
                  I2C_stop();
                  wait_timer(5000); // Wait 5ms
                  IWDG_KR = 0xaa; // Prevent the IWDG from firing.
		  
                  // Validate data in I2C EEPROM
	          if (file_type == FILETYPE_PROGRAM) {
                    prep_read(I2C_EEPROM0_WRITE, I2C_EEPROM0_READ, eeprom_address_index, 2);
		  }
	          if (file_type == FILETYPE_STRING) {
                    prep_read(I2C_EEPROM2_WRITE, I2C_EEPROM2_READ, eeprom_address_index, 2);
		  }
		  
	          I2C_last_flag = 0;
                  for (i=0; i<64; i++) {
                    if (i == 63) I2C_last_flag = 1;
                    temp_byte = I2C_read_byte(I2C_last_flag);
                    if (temp_byte != parse_tail[i]) {
                      upgrade_failcode = UPGRADE_FAIL_EEPROM_MISCOMPARE;
// UARTPrintf("UPGRADE_FAILCODE = UPGRADE_FAIL_EEPROM_MISCOMPARE\r\n");
                      pSocket->ParseState = PARSE_FILE_FAIL;
                      break; // Break out of the local while loop
                    }
                  }
                }
	      }
	      
	      if (parse_index == 64 && data_count != 0) {
	        // Hit end of parse_tail but still have data to read from this
	        // SREC. Read the next 64 bytes from the I2C EEPROM into parse_tail,
	        // and continue writing the incoming SREC data into the
	        // parse_tail starting at byte [0]. When the end of the SREC
	        // data is reached write the parse_tail to the I2C EEPROM.
	        
	        // Point to next block in I2C EEPROM
	        eeprom_address_index += 64;
		
                // Read the next existing I2C EEPROM data into parse_tail
	        if (file_type == FILETYPE_PROGRAM) {
                  prep_read(I2C_EEPROM0_WRITE, I2C_EEPROM0_READ, eeprom_address_index, 2);
		}
	        if (file_type == FILETYPE_STRING) {
                  prep_read(I2C_EEPROM2_WRITE, I2C_EEPROM2_READ, eeprom_address_index, 2);
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

// UARTPrintf("Entered PARSE_FILE_FAIL file_length = ");
// emb_itoa(file_length, OctetArray, 10, 6);
// UARTPrintf(OctetArray);
// UARTPrintf("\r\n");

#if DEBUG_SUPPORT == 7 || DEBUG_SUPPORT == 15
// UARTPrintf("PARSE_FILE_FAIL\r\n");
#endif // DEBUG_SUPPORT == 7 || DEBUG_SUPPORT == 15

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
	        // All packets read.
                break; // Break out of the local while loop
              }
              if (file_nBytes == 0) {
                // The read_two_characters() function will set file_nBytes to
	        // zero if an end of packet occurred. If so break out of the
	        // local while loop so the next packet will be read.
                break; // Break out of the local while loop
	      }
	    } // End of local while loop
	    if (file_length == 0) {
	      // All packets read. Go on to the PARSE_FILE_FAIL_EXIT routine.
	      pSocket->ParseState = PARSE_FILE_FAIL_EXIT;
            }
	  }

	  if (file_length == 0) {
	    // All packets read.
	    break; // Break out of main while loop
          }
	  
          if (file_nBytes == 0) {
            // We just read the last character in this packet. Break out
            // of the main while loop so the next packet will be read.
            break; // Break out of main while loop
          }
        } // End of main while loop
      }
    
      if (pSocket->ParseState == PARSE_FILE_COMPLETE && file_type == FILETYPE_PROGRAM) {
        // All data is now in I2C EEPROM0. Signal the main.c loop to
	// copy the data to Flash and display a Timer window to have the
	// user wait until Flash programming completes and the module reboots.

#if DEBUG_SUPPORT == 7 || DEBUG_SUPPORT == 15
// UARTPrintf("Sending Copy EEPROM to Flash request\r\n");
#endif // DEBUG_SUPPORT == 7 || DEBUG_SUPPORT == 15

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
        // All data is now in I2C EEPROM2.
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


      if ((file_length < 2)
       && (pSocket->ParseState != PARSE_FILE_COMPLETE)
       && (pSocket->ParseState != PARSE_FILE_FAIL_EXIT)) {
        // If we are at the end of the file
	// AND we have not hit PARSE_FILE_COMPLETE (which occurs when an S7
	//   record is processed)
	// AND we have not already encountered a PARSE_FILE_FAIL_EXIT
	// then something else has gone wrong.
        upgrade_failcode = UPGRADE_FAIL_TRUNCATED_FILE;
	      
// UARTPrintf("UPGRADE_FAILCODE = UPGRADE_FAIL_TRUNCATED_FILE\r\n");

        pSocket->ParseState = PARSE_FILE_FAIL_EXIT;
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

#if DEBUG_SUPPORT == 7 || DEBUG_SUPPORT == 15
if (rexmit_count == 0) UARTPrintf("\r\n");
rexmit_count++;
UARTPrintf("Re-xmit count = ");
emb_itoa(rexmit_count, OctetArray, 10, 5);
UARTPrintf(OctetArray);
UARTPrintf("\r\n");
#endif // DEBUG_SUPPORT == 7 || DEBUG_SUPPORT == 15

    if (pSocket->nPrevBytes == 0xFFFF) {
      // Send header again
      uip_send(uip_appdata, CopyHttpHeader(uip_appdata, adjust_template_size(pSocket)));
    }
    else {
      // The pData pointer needs to be moved back by the number of bytes
      // consumed from the webpage template.
      pSocket->pData -= pSocket->nPrevBytes;
      
#if OB_EEPROM_SUPPORT == 1
      // A similar adjustment is required for off_board_eeprom_index when
      // the webpage is sourced from I2C EEPROM.
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

  local_buf_index_max = 290;

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
      pSocket->ParseState = PARSE_NUMMSD;
      pSocket->nParseLeft--;
      lbi++;
    }
    
    else if (pSocket->ParseState == PARSE_NUMMSD) {
      pSocket->ParseNum = (uint8_t)((local_buf[lbi] - '0') * 10);
      pSocket->ParseState = PARSE_NUMLSD;
      pSocket->nParseLeft--;
      lbi++;
    }
    
    else if (pSocket->ParseState == PARSE_NUMLSD) {
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
      // 'a' and 'A' is POST data for the Device Name
      // 'b'         is POST data for the IP/Gateway/Netmask/MQTT Host IP address
      // 'c'         is POST data for the Port number
      // 'd'         is POST data for the MAC
      // 'g'         is POST data for the Config settings string
      // 'h' and 'H' is POST data for the Pin Control String
      // 'i' and 'I' is POST data for the IO Timers
      // 'j' and 'J' is POST data for the IO Names
      // 'l'         is POST data for the MQTT Username
      // 'm'         is POST data for the MQTT Password
      // 'z'         is POST data for used as an end-of-POST indicator
      
      // Parse 'a' 'A' 'l' 'm' 'j' 'J' --------------------------------------//
      if (pSocket->ParseCmd == 'a'
       || pSocket->ParseCmd == 'A'
       || pSocket->ParseCmd == 'l'
       || pSocket->ParseCmd == 'm'
       || pSocket->ParseCmd == 'j'
       || pSocket->ParseCmd == 'J' ) {
        // a = Update the Device Name field
        // A = Update the Device Name field (PCF8574)
        // l = Update the MQTT Username field
        // m = Update the MQTT Password field
        // j = Update the IO Name field
        // J = Update the IO Name field (PCF8574)
        
	// Notes on the "current_webpage" logic.
	// When parsing a POST we need to know if the POST came from a
	// IOControl page or from a Configuation page. The following
	// applies:
	// a) On entry to the process current_webpage is set to WEBPAGE_NULL.
	// b) The IOControl page always starts with a a 'h' value if a
	//    IOControl for the IO on the STM8 device, OR it starts with
	//    a "H" if a IOControl for the PCF8574. If current_webpage is
	//    WEBPAGE_NULL we set the current_webpage to WEBPAGE_IOCONTROL
	//    if a 'h' value, OR WEBPAGE_PCF8574_IOCONTROL if a 'H' value.
	// c) The Configuration page starts with a 'a' value if a top level
	//    Configuration page, OR it starts with a "A" value if a
	//    Configuration for the PCF8574. Since the IOControl pages never
	//    return a 'a' or 'A' value we are assured the we are at the start
	//    of receiving a POST from a Configuration page.
#if PCF8574_SUPPORT == 0
        pSocket->current_webpage = WEBPAGE_CONFIGURATION;
        pSocket->nParseLeft = PARSEBYTES_CONFIGURATION;
#endif // PCF8574_SUPPORT == 0

#if PCF8574_SUPPORT == 1
        if (pSocket->ParseCmd == 'a') {
          pSocket->current_webpage = WEBPAGE_CONFIGURATION;
          pSocket->nParseLeft = PARSEBYTES_CONFIGURATION;
	}
        if (pSocket->ParseCmd == 'A') {
          pSocket->current_webpage = WEBPAGE_PCF8574_CONFIGURATION;
          pSocket->nParseLeft = PARSEBYTES_PCF8574_CONFIGURATION;
	}
#endif // PCF8574_SUPPORT == 1

        {
          int i;
          uint8_t amp_found;
          char tmp_Pending[20];
          int num_chars;
	  
	  num_chars = 0;
          
          switch (pSocket->ParseCmd) {
            case 'a':
            case 'A':
	      num_chars = 19;
	      break;
            case 'l':
            case 'm':
	      num_chars = 10;
	      break;
            case 'j':
            case 'J':
	      num_chars = 15;
	      break;
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
              // We must reduce nParseLeft here because it is based on the
	      // PARESEBYTES_ value which assumes num_chars bytes for the
	      // string field. If the POSTed string field is less than
	      // num_chars bytes then nParseLeft is too big by the number of
	      // characters omitted and must be corrected here. When we exit
	      // the loop the buffer index is left pointing at the '&' which
	      // starts the next field.
              pSocket->nParseLeft--;
            }
          }
	  
	  // Increment num_chars once for the case where the full string
	  // length is used. This will assure a NULL character in the last
	  // byte of the Pending_ string.
	  num_chars++;
  
          switch (pSocket->ParseCmd)
	  {
	    case 'a':
	    case 'A':
	      memcpy(Pending_devicename, tmp_Pending, num_chars);
	      break;
	    case 'l':
	      memcpy(Pending_mqtt_username, tmp_Pending, num_chars);
	      break;
	    case 'm':
	      memcpy(Pending_mqtt_password, tmp_Pending, num_chars);
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
#if PCF8574_SUPPORT == 1
	    case 'J':
	      // 'J' indicates an IO_NAME for a PCF8574 pin. These are stored
	      // in I2C EEPROM.
              // Read the existing name from the I2C EEPROM
	      {
	        int i;
		int j;
		char temp_byte[16];
                prep_read(I2C_EEPROM2_WRITE, I2C_EEPROM2_READ, PCF8574_I2C_EEPROM_START_IO_NAMES + ((pSocket->ParseNum - 16) * 16), 2);
                for (i=0; i<15; i++) {
                  temp_byte[i] = I2C_read_byte(0);
                }
                temp_byte[15] = I2C_read_byte(1);
	        if (strcmp(temp_byte, tmp_Pending) != 0) {
	          // Name is not the same. Write the Pending name to the I2C
		  // EEPROM.
                  I2C_control(I2C_EEPROM2_WRITE);
                  I2C_byte_address(PCF8574_I2C_EEPROM_START_IO_NAMES + ((pSocket->ParseNum - 16) * 16), 2);
		  for (j=0; j<16; j++) {
                    I2C_write_byte(tmp_Pending[j]);
		  }
                  I2C_stop(); // Start the EEPROM internal write cycle
                  wait_timer(5000); // Wait 5ms
                }
	      }
	      break;
#endif // PCF8574_SUPPORT == 1
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
          // This code sets the Config Settings byte which defines the
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
	    // If we got to this point and current_webpage == WEBPAGE_NULL
	    // then we know we did not encounter a POST from a 
	    // Configuration page so this must be a POST from aIOControl page.
	    if (pSocket->current_webpage == WEBPAGE_NULL) {
              pSocket->current_webpage = WEBPAGE_IOCONTROL;
	      pSocket->nParseLeft = PARSEBYTES_IOCONTROL;
	    }
	    
            if (pSocket->current_webpage == WEBPAGE_CONFIGURATION) {
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


#if PCF8574_SUPPORT == 1
      // Parse 'H' ------------------------------------------------------//
      else if (pSocket->ParseCmd == 'H') {
        // This code sets the PCF8574 Pending_pin_control bytes based on the
        // information in the 16 character string POSTed in the H00 field.
        //
        // There are always 16 characters in the string in 16 pairs of
        // hex encoded nibbles, each pair representing a hex encoded pin
        // control byte. The character pairs are extracted one set at a
        // time, converted to a numeric byte, and stored in their
        // corresponding Pending_pin_control byte.
	//
	// This POST is for Pending_pin_control[16] to [23]
        {
          int i;
          int j;
          uint8_t k;

          // Sort the alpha characters into the pin control bytes
          i = 0; // Look counter to sort through the 16 hex nibbles
          j = 16; // Index to the 8 pending_pin_control bytes [16] to [23]
          while( i<16 ) {
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
	    // If we got to this point and current_webpage == WEBPAGE_NULL
	    // then we know we did not encounter a POST from a 
	    // Configuration page so this must be a POST from an IOControl
	    // page.
	    if (pSocket->current_webpage == WEBPAGE_NULL) {
              pSocket->current_webpage = WEBPAGE_PCF8574_IOCONTROL;
	      pSocket->nParseLeft = PARSEBYTES_PCF8574_IOCONTROL;
	    }
	    
            if (pSocket->current_webpage == WEBPAGE_PCF8574_CONFIGURATION) {
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
#endif // PCF8574_SUPPORT == 1


#if BUILD_SUPPORT == BROWSER_ONLY_BUILD
#if PCF8574_SUPPORT == 0
      // Parse 'i' ------------------------------------------------------//
      else if (pSocket->ParseCmd == 'i') {
#endif // PCF8574_SUPPORT == 0
#if PCF8574_SUPPORT == 1
      // Parse 'i' or "I" -----------------------------------------------//
      else if ((pSocket->ParseCmd == 'i') || (pSocket->ParseCmd == 'I')) {
#endif // PCF8574_SUPPORT == 1
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
  // A global "parse_complete" variable is used to pass the state to the
  // main.c functions.
  //

  if (pSocket->nParseLeft == 0) {
    // Finished parsing
	
    // Signal the main.c processes that parsing is complete
    parse_complete = 1;
    // Set nState to close the connection
    pSocket->nState = STATE_SENDHEADER204;
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
#endif // BUILD_SUPPORT == BROWSER_ONLY_BUILD || BUILD_SUPPORT == MQTT_BUILD


void update_ON_OFF(uint8_t i, uint8_t j)
{
  // Verify that pin is an output and it is enabled. If so
  // update the ON/OFF state. Otherwise the command is ignored.
#if LINKED_SUPPORT == 0
  if ((pin_control[i] & 0x01) && (pin_control[i] & 0x02)) {
#endif // LINKED_SUPPORT == 0
#if LINKED_SUPPORT == 1
  if (chk_iotype(pin_control[i], i, 0x03) == 0x03) {
#endif // LINKED_SUPPORT == 1
    Pending_pin_control[i] = pin_control[i];
    if (j==0) Pending_pin_control[i] &= (uint8_t)(~0x80);
    else Pending_pin_control[i] |= (uint8_t)0x80;
    parse_complete = 1;
  }
}
