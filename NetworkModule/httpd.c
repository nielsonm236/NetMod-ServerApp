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
#define STATE_GOTGET2		2	// Client just sent a GET request
#define STATE_GOTPOST		3	// Client just sent a POST request
#define STATE_PARSEPOST		10	// Code is currently parsing the
                                        //   client's POST-data
#define STATE_PARSEFILE		11	// Code is currently parsing the
                                        //   client's POSTed file data
#define STATE_SENDHEADER200	12	// Next code sends the HTTP 200 header
                                        //   with Content-Length > 0
#define STATE_SENDHEADER204	13	// Or code sends the HTTP 200 header
                                        //   with Content-Length = 0
#define STATE_SENDHEADER429	14	// Or code sends the HTTP 429 header
                                        //   with Content-Length = 0 and
					//   Retry-After of 10 seconds
#define STATE_SENDDATA		20	// ... followed by data
#define STATE_PARSEGET		21	// Code is currently parsing the
                                        //   client's GET-request
#define STATE_NULL		127     // Inactive state

#define HEADER200		1       // Generate HTTP/1.1 200 header
#define HEADER204		2       // Generate HTTP/1.1 200 header
#define HEADER429		3       // Generate HTTP/1.1 429 header


#define PARSE_CMD		0       // Parsing the command byte in a POST
#define PARSE_NUMMSD		1       // Parsing the most sig digit of POST
                                        //   cmd
#define PARSE_NUMLSD		2       // Parsing the least sig digit of a
                                        //   POST cmd
#define PARSE_EQUAL		3       // Parsing the equal sign of a POST
                                        //   cmd
#define PARSE_VAL		4       // Parsing the data value of a POST
                                        //   cmd
#define PARSE_DELIM		5       // Parsing the delimiter of a POST cmd
#define PARSE_SLASH1		6       // Parsing the slash of a GET cmd
#define PARSE_FAIL		7       // Indicates parse failure - no action
                                        //   taken

#define PARSE_FILE_SEEK_START	30	// Parse a new SREC record
#define PARSE_FILE_SEEK_SX	31	// Parse a new SREC record
#define PARSE_FILE_SEQUENTIAL	32	// Read data in the SREC record
#define PARSE_FILE_NONSEQ	33	// Read non-sequential SREC record
#define PARSE_FILE_COMPLETE	34	// Termination of good file read
#define PARSE_FILE_FAIL		35	// Termination of failed file read
#define PARSE_FILE_FAIL_EXIT	36	// Display of fail code

#define PARSE_NULL		127	// Default init state for the parser


// Variables used to store debug information
extern uint8_t debug_bytes[10];
extern uint8_t stored_debug_bytes[10];

#if DEBUG_SUPPORT == 15
uint16_t rexmit_count; // Used only for sending the rexmit count via UART
#endif // DEBUG_SUPPORT == 15

extern uint16_t Port_Httpd;               // Port number in use

#if PCF8574_SUPPORT == 0 && DOMOTICZ_SUPPORT == 0
extern uint8_t pin_control[16];           // Per pin configuration byte
#endif // PCF8574_SUPPORT == 0 && DOMOTICZ_SUPPORT == 0
#if PCF8574_SUPPORT == 1 || DOMOTICZ_SUPPORT == 1
extern uint8_t pin_control[24];           // Per pin configuration byte when
                                          // PCF8574 is included in the
					  // hardware configuration
#endif // PCF8574_SUPPORT == 1 || DOMOTICZ_SUPPORT == 1




#if PCF8574_SUPPORT == 0 && DOMOTICZ_SUPPORT == 0
extern uint16_t ON_OFF_word;              // ON/OFF states of pins in single
                                          // 16 bit word
extern uint16_t Invert_word;              // Invert state of pins in single 16
                                          // bit word
extern uint8_t Pending_pin_control[16];   // Temp storage for new pin_control
                                          // received from GUI
#endif // PCF8574_SUPPORT == 0 && DOMOTICZ_SUPPORT == 0
#if PCF8574_SUPPORT == 1 || DOMOTICZ_SUPPORT == 1
extern uint32_t ON_OFF_word;              // ON/OFF states of pins in single
                                          // 32 bit word
extern uint32_t Invert_word;              // Invert state of pins in single 32
                                          // bit word
extern uint8_t Pending_pin_control[24];   // Temp storage for new pin_control
                                          // received from the GUI when
                                          // PCF8574 is included in the
					  // hardware configuration
#endif // PCF8574_SUPPORT == 1 || DOMOTICZ_SUPPORT == 1

//extern uint8_t Pending_hostaddr[4];       // Temp storage for new IP address
//extern uint8_t Pending_draddr[4];         // Temp storage for new Gateway
//                                          // address
//extern uint8_t Pending_netmask[4];        // Temp storage for new Netmask
//
//extern uint16_t Pending_port;             // Temp storage for new Port number
//
//extern uint8_t Pending_devicename[20];    // Temp storage for new Device Name
//
extern uint8_t Pending_config_settings;   // Temp storage for new Config
                                          // settings
					  
extern uint8_t stored_magic4;	          // Byte 47 MSB Magic Number
extern uint8_t stored_magic3;             // Byte 46
extern uint8_t stored_magic2;             // Byte 45
extern uint8_t stored_magic1;             // Byte 44 LSB Magic Number





//extern uint8_t Pending_uip_ethaddr_oct[6]; // Temp storage for new MAC address

extern uint8_t stored_hostaddr[4];	  // hostaddr stored in EEPROM
extern uint8_t stored_draddr[4];	  // draddr stored in EEPROM
extern uint8_t stored_netmask[4];	  // netmask stored in EEPROM

extern uint16_t stored_port;		  // Port number stored in EEPROM

extern uint8_t stored_uip_ethaddr_oct[6]; // MAC address ordered as defined in
                                          // UIP modules ([0] is LSB, [5] is
					  // MSB)

extern uint8_t stored_devicename[20];     // Device name stored in EEPROM

extern uint8_t stored_config_settings;    // Config settings stored in EEPROM

extern uint8_t stored_options1;           // Additional options stored in
                                          // EEPROM
					  
extern uint8_t stored_options2;           // Additional options stored in
                                          // EEPROM
					  
extern uint8_t stored_shunt_res;          // INA226 Shunt Resistor value
                                          // stored in EEPROM

extern char mac_string[13];		  // MAC Address in string format

extern uint8_t parse_complete;            // Used to signal that all user
                                          // inputs have POSTed and are ready
					  // to be used

extern uint8_t user_reboot_request;       // Communicates the need to reboot
                                          // back to the main.c functions
extern uint8_t user_restart_request;      // Communicates the need to restart
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


// ************************************************************************ //
// The "parse_tail" variable is used to collect each component of a POST
// sequence. If TCP fragmentation occurs parse_tail will contain the part of
// the POST component that was at the end of the packet. The size of this
// array is determined by the longest POST component.
//
// In Browser Only builds and MQTT Home Assistant builds the longest POST
// component is the &h00 POST reply of 37 bytes.
#if BUILD_SUPPORT == BROWSER_ONLY_BUILD || HOME_ASSISTANT_SUPPORT == 1
uint8_t parse_tail[40];
#endif // BUILD_SUPPORT == BROWSER_ONLY_BUILD || HOME_ASSISTANT_SUPPORT == 1
//
// In Domoticz builds the longest POST component is the &h00 POST reply of 53
// bytes.
#if DOMOTICZ_SUPPORT == 1
uint8_t parse_tail[54];
#endif // DOMOTICZ_SUPPORT == 1
//
// IMPORTANT POST NOTES:
// Since parse_tail is a single global variable there is a high probablility
// of corruption of POST requests if multiple Browser attempt to Save their
// IOControl or Configuration changes at the same time. Also note that since
// IOControl and Configuration changes are managed via Javascript in each
// Broswer is it also possible for the changes to be in conflict when the
// user clicks "Save" in those Browsers. For this reason there is a
// restriction that specifies that ONLY ONE BROWSER USING A SINGLE BROWSER
// TAB is allowed to be used for creating and saving IOControl and
// Configuration changes. Other Browsers or Broswer tabs may be used for
// viewing / monitoring, but those other Browsers or tabs must never be used
// to apply changes.
// ************************************************************************ //


#if BUILD_SUPPORT == CODE_UPLOADER_BUILD
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


uint8_t parse_GETcmd[11];     // Holds the GET cmd until the entire GET
                              // request is received.
			      // This variable is a global as it is also used
			      // to prevent GET requests from multiple
			      // Browsers from interfering with each other,
			      // thus the variable content needs to be
			      // available across multiple incoming Browser
			      // requests. Due to RAM size limitations only 1
			      // GET request can be handled at a time, so if
			      // GET requests arrive from more than one
			      // Browser at a time only the first one received
			      // will be processed. The others will be
			      // rejected with a 429 response and a
			      // Retry-After setting of 10 seconds.
			      // The size of the variable is based on the
			      // maximum size of a GET command that can be
			      // received.

uint16_t HtmlPageIOControl_size;     // Size of the IOControl template
uint16_t HtmlPageConfiguration_size; // Size of the Configuration template
uint16_t HtmlPageLoadUploader_size;  // Size of the Load Uploader template

#if PCF8574_SUPPORT == 1
uint16_t HtmlPagePCFIOControl_size;     // Size of the PCF8574 IOControl template
uint16_t HtmlPagePCFConfiguration_size; // Size of the PCF8574 Configuration template
#endif // PCF8574_SUPPORT == 1


#if LOGIN_SUPPORT == 1
uint16_t HtmlPageLogin_size;           // Size of the Login template
uint16_t HtmlPageSetPassphrase_size;   // Size of the Set Passphrase template
uint8_t Login_Tracker[4];	       // Login Indicators and Attempt
                                       // Counters, 1 per Browser
                                       // Bit 7: Logged In Indicator
                                       // Bit 6: Not used
                                       // Bit 5: Not used
                                       // Bit 4: Not used
                                       // Bit 3: Not used
                                       // Bit 2: Login Attempt Counter
                                       // Bit 1: Login Attempt Counter
                                       // Bit 0: Login Attempt Counter
uint8_t Auto_Log_Out_Timer[4];         // Auto Log Out Timers for 4 Browsers
                                       // Auto_Log_Out_Timer[3]: Browser 4
                                       // Auto_Log_Out_Timer[2]: Browser 3
                                       // Auto_Log_Out_Timer[1]: Browser 2
                                       // Auto_Log_Out_Timer[0]: Browser 1
uint8_t Response_Lockout_Cancel_Timer; // Response Lockout Cancel Timer
                                       // (1 byte  applies to all Browsers)
uint32_t ripaddr_table[4];             // ripaddr table (4 bytes per Browser)
                                       // ripaddr_table[3]: Browser 4
                                       // ripaddr_table[2]: Browser 3
                                       // ripaddr_table[1]: Browser 2
                                       // ripaddr_table[0]: Browser 1
#endif // LOGIN_SUPPORT == 1


// These MQTT variables must always be compiled in the MQTT_BUILD and
// BROWSER_ONLY_BUILD to maintain a common user interface between the MQTT
// and Browser Only versions.
extern uint8_t mqtt_enabled;              // Signals if MQTT has been enabled
extern uint8_t stored_mqttserveraddr[4];  // mqttserveraddr stored in EEPROM
extern uint16_t stored_mqttport;	  // MQTT Host Port number stored in
                                          // EEPROM
extern char stored_mqtt_username[11];     // MQTT Username  stored in EEPROM
extern char stored_mqtt_password[11];     // MQTT Password  stored in EEPROM

//extern uint8_t Pending_mqttserveraddr[4]; // Temp storage for new MQTT IP
//                                          // Address
//extern uint16_t Pending_mqttport;	  // Temp storage for new MQTT Host
//                                          // Port
//extern char Pending_mqtt_username[11];    // Temp storage for new MQTT
//                                          // Username
//extern char Pending_mqtt_password[11];    // Temp storage for new MQTT
//                                          // Password

extern uint8_t mqtt_start_status;         // Contains error status from the
                                          // MQTT start process
extern uint8_t MQTT_error_status;         // For MQTT error status display in
                                          // GUI



extern uint32_t TRANSMIT_counter;         // Counts any transmit
extern uint8_t MQTT_resp_tout_counter;    // Counts response timeout events
extern uint8_t MQTT_not_OK_counter;       // Counts MQTT != OK events
extern uint8_t MQTT_broker_dis_counter;   // Counts broker disconnect events
extern uint32_t second_counter;           // Counts seconds since boot


#if DS18B20_SUPPORT == 1
// DS18B20 variables
#if OB_EEPROM_SUPPORT == 0
// FoundROM is located in a global RAM location if there is no I2C EEPROM
extern uint8_t FoundROM[5][8];            // Table of found ROM codes
                                          // [x][0] = Family Code
                                          // [x][1] = LSByte serial number
                                          // [x][2] = byte 2 serial number
                                          // [x][3] = byte 3 serial number
                                          // [x][4] = byte 4 serial number
                                          // [x][5] = byte 5 serial number
                                          // [x][6] = MSByte serial number
                                          // [x][7] = CRC
#endif // OB_EEPROM_SUPPORT == 0
extern int numROMs;                       // Count of DS18B20 devices found
#endif // DS18B20_SUPPORT == 1


#if BME280_SUPPORT == 1
extern int16_t stored_altitude; // User entered altitude used for BME280
				// pressure calibration stored in EEPROM

extern int32_t comp_data_temperature; // Compensated temperature
extern int32_t comp_data_pressure;    // Compensated pressure
extern int32_t comp_data_humidity;    // Compensated humidity
#endif // BME280_SUPPORT == 1


// Define Flash addresses for IDX values
// Note: While IDX values are not used in all builds they are still defined
// for all builds.
extern uint8_t Sensor_IDX[6][8] @FLASH_START_SENSOR_IDX;


// Define Flash addresses for IO Names and IO Timers
// Note: While IO_NAME and IO_TIMER Flash space is not used in all builds it
// is still defined for all builds.
extern uint16_t IO_TIMER[16] @FLASH_START_IO_TIMERS;
extern char IO_NAME[16][16] @FLASH_START_IO_NAMES;

// Define RAM addresses for Pending timers
#if PCF8574_SUPPORT == 0
extern uint16_t Pending_IO_TIMER[16];
#endif // PCF8574_SUPPORT == 0
#if PCF8574_SUPPORT == 1
extern uint16_t Pending_IO_TIMER[24];
#endif // PCF8574_SUPPORT == 1



#if INA226_SUPPORT == 1;
// INA226 variables. Special Software Defined Radio build only.
extern int32_t voltage;       // Voltage value x1000 reported by the INA226
extern int32_t current;       // Current value x1000 reported by the INA226 x1000
extern int32_t power;         // Power value x1000 reported by the INA226
#endif // INA226_SUPPORT == 1;

#if SDR_POWER_RELAY_SUPPORT == 1
// Latching (aka Keep) Relay variables. Special Software Defined Radio build
// only.
extern uint8_t stored_latching_relay_state;
                              // Indicates the last known ON/OFF state of the
                              // 8 Latching Relays. Value is stored in EEPROM.
#endif // SDR_POWER_RELAY_SUPPORT == 1






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
//   application code to insert the string "this is a test string". While this
//   makes the code harder to read, it makes the web page templates much
//   smaller.
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
//   needs to account for NETWORK_STATISTICS ifdef's as these will also cause
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
//   do this with annoying repetition slowing down the transmit/receive
//   process.
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
// The next defines are included only in the case of Code Uploader builds
// to allow use of common code across builds.
//-------------------------------------------------------------------------//
#if BUILD_SUPPORT == CODE_UPLOADER_BUILD
#define WEBPAGE_IOCONTROL		1
#define WEBPAGE_CONFIGURATION		2
#define WEBPAGE_PCF8574_IOCONTROL	21
#define WEBPAGE_PCF8574_CONFIGURATION	22
#endif // BUILD_SUPPORT == CODE_UPLOADER_BUILD



// #if BUILD_SUPPORT == MQTT_BUILD
#if BUILD_SUPPORT == MQTT_BUILD && HOME_ASSISTANT_SUPPORT == 1
// ************************************************************************* //
// ************************************************************************* //
// ************************************************************************* //
// ************************************************************************* //
// **                                                                      * //
// ** MQTT IO Control Template                                             * //
// **                                                                      * //
// ************************************************************************* //
// ************************************************************************* //
// ************************************************************************* //
// ************************************************************************* //
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
//                + (1 x 5)
//     PARSEBYTES = 37
//                + 5 = 42
//
#define WEBPAGE_IOCONTROL		1
#define PARSEBYTES_IOCONTROL		42
#define MQTT_WEBPAGE_IOCONTROL_BEGIN    1
// The _BEGIN define is used only by the "prepsx" strings pre-processor
// program. The value of "1" is not used as the prepsx program only searches
// for the _BEGIN phrase. The _BEGIN phrase is used by the prepsx program as
// a keyword for locating the webpage text contained in the static const
// below. The prepsx program extracts the HTML "string" and places it in a
// SREC (.sx) file. The HTML strings in the .sx file are uploaded into the
// I2C EEPROM for subsequent use in generating webpages from the I2C EEPROM
// instead of generating them from Flash.
//
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
// #endif // BUILD_SUPPORT == MQTT_BUILD
#endif // BUILD_SUPPORT == MQTT_BUILD && HOME_ASSISTANT_SUPPORT == 1






#if BUILD_SUPPORT == MQTT_BUILD && HOME_ASSISTANT_SUPPORT == 1
// ************************************************************************* //
// ************************************************************************* //
// ************************************************************************* //
// ************************************************************************* //
// **                                                                      * //
// ** MQTT Home Assistant Configuration Template                           * //
// **                                                                      * //
// ************************************************************************* //
// ************************************************************************* //
// ************************************************************************* //
// ************************************************************************* //
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
//     example: g00=xx&
//     where xx is 2 bytes
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
//                + (1 x 7) 
//                + (2 x 15)
//                + (1 x 37)
//                + (1 x 5)
//     PARSEBYTES = 24
//                + 52
//                + 18
//                + 17
//                + 7
//                + 30
//                + 37
//                + 5 = 190
//
#define WEBPAGE_CONFIGURATION			2
#define PARSEBYTES_CONFIGURATION		190
#define MQTT_WEBPAGE_CONFIGURATION_BEGIN	1
// The _BEGIN define is used only by the "prepsx" strings pre-processor
// program. The value of "1" is not used as the prepsx program only searches
// for the _BEGIN phrase. The _BEGIN phrase is used by the prepsx program as
// a keyword for locating the webpage text contained in the static const
// below. The prepsx program extracts the HTML "string" and places it in a
// SREC (.sx) file. The HTML strings in the .sx file are uploaded into the
// I2C EEPROM for subsequent use in generating webpages from the I2C EEPROM
// instead of generating them from Flash.
//
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
               "<td><input name='a00' value='%a00' pattern='[0-9a-zA-Z_*.-]{1,19}' required title='1 to 19 letters, numbers, and -_*. no spaces'/></td>"
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
                 "<input name='d00' required pattern='([0-9a-fA-F]{2}[:-]?){5}([0-9a-fA-F]{2})' title='aa:bb:cc:dd:ee:ff format'/>"
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
",linked:2},o={retain:8,on:16,off:0},l=document,a=location,p=l.querySelector.bind(l),i=p"
"('form'),c=Object.entries,d=parseInt,_=e=>l.write(e),s=(e,t)=>d(e).toString(16).padStar"
"t(t,'0'),u=e=>e.map(e=>s(e,2)).join(''),f=e=>e.match(/.{2}/g).map(e=>d(e,16)),b=e=>enco"
"deURIComponent(e),h=e=>p(`input[name=${e}]`),g=(e,t)=>h(e).value=t,x=(e,t)=>{for(let $ "
"of l.querySelectorAll(e))t($)},E=(e,t)=>{for(let[$,r]of c(t))e.setAttribute($,r)},y=(e,"
"t)=>c(e).map(e=>`<option value=${e[1]} ${e[1]==t?'selected':''}>${e[0]}</option>`).join"
"(''),S=(e,t,$,r='')=>`<input type='checkbox' name='${e}' value=${t} ${($&t)==t?'checked"
"':''}>${r}`,T=()=>{let r=new FormData(i),n=e=>r.getAll(e).map(e=>d(e)).reduce((e,t)=>e|"
"t,0);return t.forEach(e=>r.set(e,u(r.get(e).split('.')))),$.forEach(e=>r.set(e,s(r.get("
"e),4))),r.set('d00',r.get('d00').toLowerCase().replace(/[:-]/g,'')),r.set('h00',u(f(e.h"
"00).map((e,t)=>{let $='p'+t,o=n($);return r.delete($),o}))),r.set('g00',u([n('g00')])),"
"r},j=(e,t,$)=>{let r=new XMLHttpRequest;r.open(e,t,!1),r.send($)},w=()=>a.href='/60',A="
"()=>a.href='/63',k=()=>a.href='/61',v=()=>{l.body.innerText='Wait 5s...',setTimeout(k,5"
"e3)},B=()=>{j('GET','/91'),v()},D=e=>{e.preventDefault();let t=Array.from(T().entries()"
",([e,t])=>`${b(e)}=${b(t)}`).join('&');j('POST','/',t+'&z00=0'),v()},q=f(e.g00)[0],M={r"
"equired:!0};return x('.ip',e=>{E(e,{...M,title:'x.x.x.x format',pattern:'((25[0-5]|(2[0"
"-4]|1[0-9]|[1-9]|)[0-9])([.](?!$)|$)){4}'})}),x('.port',e=>{E(e,{...M,type:'number',min"
":10,max:65535})}),x('.up input',e=>{E(e,{title:'0 to 10 letters, numbers, and -_*. no s"
"paces. Blank for no entry.',maxlength:10,pattern:'[w*.-]{0,10}$'})}),t.forEach(t=>g(t,f"
"(e[t]).join('.'))),$.forEach(t=>g(t,d(e[t],16))),g('d00',e.d00.replace(/[0-9a-z]{2}(?!$"
")/g,'$&:')),f(e.h00).forEach((e,t)=>{let $=(3&e)!=0?S('p'+t,4,e):'',r=(3&e)==3||(3&e)=="
"2&&t>7?`<select name='p${t}'>${y(o,24&e)}</select>`:'';_(`<tr><td>#${t+1}</td><td><sele"
"ct name='p${t}'>${y(n,3&e)}</select></td><td>${$}</td><td>${r}</td></tr>`)}),p('.f').in"
"nerHTML=Array.from(c(r),([e,t])=>S('g00',t,q,e)).join('</br>'),{r:B,s:D,l:k,i:w,p:A}})("
"{b00:'%b00',b04:'%b04',b08:'%b08',c00:'%c00',d00:'%d00',b12:'%b12',c01:'%c01',h00:'%h00"
"',g00:'%g00'});"
      "%y01"
      "<p>"
      "Pinout Option %w01<br/>"
      "PCF8574 %w02<br/>"
      "Code Revision %w00<br/>"
      "<a href='https://github.com/nielsonm236/NetMod-ServerApp/wiki' target='_blank'>Help Wiki</a>"
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
    selector_apply_fn('.up input', (e) => { set_attributes(e, {title: '0 to 10 letters, numbers, and -_*. no spaces. Blank for no entry.', maxlength: 10, pattern: '[\w*.\-]{0,10}$' }); });

    ip_input_names.forEach((n) => set_input_value(n, convert_from_hex(data[n]).join('.')));
    port_input_names.forEach((n) => set_input_value(n, parse_int(data[n], 16)));
    set_input_value('d00', data.d00.replace(/[0-9a-z]{2}(?!$)/g, '$&:'));

    convert_from_hex(data.h00).forEach((n, i) => {
        const
            invert_checkbox = (n & 3) != 0 ? make_checkbox('p'+i, 4, n) : '',
            make_select = (n & 3) == 3 || ((n & 3) == 2 && i > 7) ? `<select name='p${i}'>${make_options(boot_state, n & 24)}</select>` : '';
        document_write(`<tr><td>#${i + 1}</td><td><select name='p${i}'>${make_options(pin_types, n & 3)}</select></td><td>${invert_checkbox}</td><td>${make_select}</td></tr>`);
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
#endif // BUILD_SUPPORT == MQTT_BUILD && HOME_ASSISTANT_SUPPORT == 1






#if BUILD_SUPPORT == MQTT_BUILD && DOMOTICZ_SUPPORT == 1
// ************************************************************************* //
// ************************************************************************* //
// ************************************************************************* //
// ************************************************************************* //
// **                                                                      * //
// ** MQTT Domoticz IO Control Template                                    * //
// **                                                                      * //
// ************************************************************************* //
// ************************************************************************* //
// ************************************************************************* //
// ************************************************************************* //
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
//     Note: No trailing parse delimiter
// THUS
// For 1 of the replies there are 37 bytes in the reply
// For 1 of the replies there are 6 bytes per reply
// The formula in this case is
//     PARSEBYTES = (1 x 37)
//                + (1 x 21)
//                + (1 x 5)
//     PARSEBYTES = 37
//                + 21
//                + 5 = 63
//
#define WEBPAGE_IOCONTROL			1
#define PARSEBYTES_IOCONTROL			63
#define MQTT_DOMO_WEBPAGE_IOCONTROL_BEGIN    	1
// The _BEGIN define is used only by the "prepsx" strings pre-processor
// program. The value of "1" is not used as the prepsx program only searches
// for the _BEGIN phrase. The _BEGIN phrase is used by the prepsx program as
// a keyword for locating the webpage text contained in the static const
// below. The prepsx program extracts the HTML "string" and places it in a
// SREC (.sx) file. The HTML strings in the .sx file are uploaded into the
// I2C EEPROM for subsequent use in generating webpages from the I2C EEPROM
// instead of generating them from Flash.
//
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
"const m=(t=>{let e=document,r=location,$=e.querySelector.bind(e),n=$('form'),a=(Object."
"entries,parseInt),h=t=>e.write(t),l=(t,e)=>a(t).toString(16).padStart(e,'0'),s=t=>t.map"
"(t=>l(t,2)).join(''),d=t=>t.match(/.{2}/g).map(t=>a(t,16)),o=t=>encodeURIComponent(t),p"
"=[],c=[],u=(t,e,r)=>{var $;return`<label><input type=radio name=o${e} value=${t} ${r==t"
"?'checked':''}/>${(t?'on':'off').toUpperCase()}</label>`},i=()=>{let e=new FormData(n);"
"return e.set('h00',s(d(t.h00).map((t,r)=>{let $='o'+r,n=e.get($)<<7;return e.delete($),"
"n}))),e},f=d(t.g00)[0];return cfg_page=16&f?()=>r.href='/60':()=>r.href='/61',reload_pa"
"ge=()=>r.href='/60',submit_form=t=>{t.preventDefault();let e=new XMLHttpRequest,r=Array"
".from(i().entries(),([t,e])=>`${o(t)}=${o(e)}`).join('&');e.open('POST','/',!1),e.send("
"r+'&z00=0'),reload_page()},d(t.h00).forEach((t,e)=>{(3&t)==3?c.push(`<tr><td>Output #${"
"e+1}</td><td class='s${t>>7} t3'></td><td class=c>${u(1,e,t>>7)}${u(0,e,t>>7)}</td></tr"
">`):(3&t)==1&&p.push(`<tr><td>Input #${e+1}</td><td class='s${t>>7} t3'></td><td/></tr>"
"`)}),h(p.join('')),h(`<tr><th></th><th></th>${c.length>0?'<th class=c>SET</th>':''}</tr"
">`),h(c.join('')),h('</table>'),{s:submit_form,l:reload_page,c:cfg_page}})({h00:'%h00',"
"g00:'%g00'});"
      "%y00"
      "%y02'm.l()'>Refresh</button>"
      "<br><br>"
      "%y02'm.c()'>Configuration</button> "
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
        stm_inputs = [],
        stm_outputs = [],
        pcf_inputs = [],
        pcf_outputs = [],
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
        
        if (features_data & 0x10) { // Disable Config Button
          cfg_page = () => loc.href = '/60';
        } else {
          cfg_page = () => loc.href = '/61';
        }

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
            stm_outputs.push(`<tr><td>Output #${i + 1}</td><td class='s${cfg >> 7} t3'></td><td class=c>${make_radio_input(1, i, cfg >> 7)}${make_radio_input(0, i, cfg >> 7)}</td></tr>`);
        } else if ((cfg & 3) == 1) { // input
            stm_inputs.push(`<tr><td>Input #${i + 1}</td><td class='s${cfg >> 7} t3'></td><td/></tr>`);
        }
    });

    document_write(stm_inputs.join(''));
    document_write(`<tr><th></th><th></th>${stm_outputs.length > 0 ? '<th class=c>SET</th>' : ''}</tr>`);
    document_write(stm_outputs.join(''));
    document_write(`</table>`);

    return {s: submit_form, l:reload_page, c:cfg_page}
})
({
  h00: '00010305070b0f13178101830300000081010305078b0f13',
  g00: '14',
});

*/
#endif // BUILD_SUPPORT == MQTT_BUILD && DOMOTICZ_SUPPORT == 1






#if BUILD_SUPPORT == MQTT_BUILD && DOMOTICZ_SUPPORT == 1
// ************************************************************************* //
// ************************************************************************* //
// ************************************************************************* //
// ************************************************************************* //
// **                                                                      * //
// ** MQTT Domoticz Configuration Template                                 * //
// **                                                                      * //
// ************************************************************************* //
// ************************************************************************* //
// ************************************************************************* //
// ************************************************************************* //
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
//     example: g00=xx&
//     where xx is 2 bytes
//   PLUS
//   For 2 of the replies (MQTT Username and Password):
//     example: m00=xxxxxxxxxx&
//     where xxxxxxxxxx is 1 to 10 bytes
//   PLUS
//   For 1 of the replies (Pin Control):
//     example: h00=xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx&
//     where xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx is 48 bytes
//   PLUS
//     For 24 of the replies (IO Name, repurposed for IDX):
//     example: j00=xxxxxx& where xxxxxx is 6 bytes
//     each POST reply consists of 6 bytes data plus 5 byte wrapper (11 bytes)
//   PLUS
//     For 6 of the replies (Sensor IDX value):
//     example: T20=xxxxxx& where xxxxxx is 6 bytes
//     each POST reply consists of 6 bytes data plus 5 byte wrapper (11 bytes)
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
//                + (1 x 7) 
//                + (2 x 15)
//                + (1 x 53)
//                + (24 x 11)
//                + (6 x 11)
//                + (1 x 5)
//     PARSEBYTES = 24
//                + 52
//                + 18
//                + 17
//                + 7
//                + 30
//                + 53
//                + 264
//                + 66
//                + 5 = 536
//
#define WEBPAGE_CONFIGURATION			2
#define PARSEBYTES_CONFIGURATION		536
#define MQTT_DOMO_WEBPAGE_CONFIGURATION_BEGIN	1
// The _BEGIN define is used only by the "prepsx" strings pre-processor
// program. The value of "1" is not used as the prepsx program only searches
// for the _BEGIN phrase. The _BEGIN phrase is used by the prepsx program as
// a keyword for locating the webpage text contained in the static const
// below. The prepsx program extracts the HTML "string" and places it in a
// SREC (.sx) file. The HTML strings in the .sx file are uploaded into the
// I2C EEPROM for subsequent use in generating webpages from the I2C EEPROM
// instead of generating them from Flash.
//
// Next #if: Only place the HTML in Flash if the I2C EEPROM is not supported.
#if OB_EEPROM_SUPPORT == 0
static const char g_HtmlPageConfiguration[] =
"%y04%y05"
      "<title>%a00: Configuration</title>"
   "</head>"
   "<body>"
      "<h1> Configuration</h1>"
      "<form onsubmit='return m.s(event);return false'>"
         "<table>"
            "<tr>"
               "<td>Name</td>"
               "<td><input name='a00' value='%a00' pattern='[0-9a-zA-Z_*.-]{1,19}' required title='1 to 19 letters, numbers, and -_*. no spaces'/></td>"
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
                 "<input name='d00' required pattern='([0-9a-fA-F]{2}[:-]?){5}([0-9a-fA-F]{2})' title='aa:bb:cc:dd:ee:ff format'/>"
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
         "<script>"
"const m=(t=>{let $=['b00','b04','b08','b12'],e=['c00','c01'],r={'Full Duplex':1,MQTT:4,"
"DS18B20:8,BME280:32,'Disable Cfg Button':16},_={disabled:0,input:1,output:3,linked:2},n"
"={retain:8,on:16,off:0},a=document,o=location,l=a.querySelector.bind(a),d=l('form'),i=O"
"bject.entries,p=parseInt,T=t=>a.write(t),h=(t,$)=>p(t).toString(16).padStart($,'0'),u=t"
"=>t.map(t=>h(t,2)).join(''),s=t=>t.match(/.{2}/g).map(t=>p(t,16)),b=t=>encodeURICompone"
"nt(t),c=t=>l(`input[name=${t}]`),f=(t,$)=>c(t).value=$,g=(t,$)=>{for(let e of a.querySe"
"lectorAll(t))$(e)},S=(t,$)=>{for(let[e,r]of i($))t.setAttribute(e,r)},v=(t,$)=>i(t).map"
"(t=>`<option value=${t[1]} ${t[1]==$?'selected':''}>${t[0]}</option>`).join(''),x=(t,$,"
"e,r='')=>`<input type='checkbox' name='${t}' value=${$} ${(e&$)==$?'checked':''}>${r}`,"
"y=()=>{let r=new FormData(d),_=t=>r.getAll(t).map(t=>p(t)).reduce((t,$)=>t|$,0);return "
"$.forEach(t=>r.set(t,u(r.get(t).split('.')))),e.forEach(t=>r.set(t,h(r.get(t),4))),r.se"
"t('d00',r.get('d00').toLowerCase().replace(/[:-]/g,'')),r.set('h00',u(s(t.h00).map((t,$"
")=>{let e='p'+$,n=_(e);return r.delete(e),n}))),r.set('g00',u([_('g00')])),r},D=(t,$,e)"
"=>{let r=new XMLHttpRequest;r.open(t,$,!1),r.send(e)},E=()=>o.href='/60',q=()=>o.href='"
"/61',w=()=>{a.body.innerText='Wait 5s...',setTimeout(q,5e3)},B=()=>{D('GET','/91'),w()}"
",I=t=>{t.preventDefault();let $=Array.from(y().entries(),([t,$])=>`${b(t)}=${b($)}`).jo"
"in('&');D('POST','/',$+'&z00=0'),w()},k=s(t.g00)[0],A={required:!0};g('.ip',t=>{S(t,{.."
".A,title:'x.x.x.x format',pattern:'((25[0-5]|(2[0-4]|1[0-9]|[1-9]|)[0-9])([.](?!$)|$)){"
"4}'})}),g('.port',t=>{S(t,{...A,type:'number',min:10,max:65535})}),g('.up input',t=>{S("
"t,{title:'0 to 10 letters, numbers, and -_*. no spaces. Blank for no entry.',pattern:'["
"w*.-]{0,10}$'})}),$.forEach($=>f($,s(t[$]).join('.'))),e.forEach($=>f($,p(t[$],16))),f("
"'d00',t.d00.replace(/[0-9a-z]{2}(?!$)/g,'$&:')),T('<table><tr><th>IO</th><th>Type</th><"
"th>IDX</th><th>Invert</th><th>Boot state</th></tr>'),s(t.h00).forEach(($,e)=>{let r=(3&"
"$)!=0?x('p'+e,4,$):'',a=(''+e).padStart(2,'0'),l=(3&$)==3||(3&$)==2&&e>7?`<select name="
"'p${e}'>${v(n,24&$)}</select>`:'',d='#d'==o.hash?`<td>${$}</td>`:'';T(`<tr><td>#${e+1}<"
"/td><td><select name='p${e}'>${v(_,3&$)}</select></td><td><input name='j${a}' value='${"
"t['j'+a]}' pattern='[0-9]{1,6}' required title='1 to 6 numbers'/></td><td>${r}</td><td>"
"${l}</td>${d}</tr>`)}),l('.f').innerHTML=Array.from(i(r),([t,$])=>x('g00',$,k,t)).join("
"'</br>'),T('</table>'),T('<br><h1>Sensor IDX Configuration</h1>'),T('<table><tr><th>Sen"
"sor Ser #</th><th>IDX</th></tr>');for(var C=0;C<6;C++){let M=(''+C).padStart(2,'0');inp"
"ut_nr=(''+(j=C+20)).padStart(2,'0'),T(`<tr><td>${t['T'+M]}</td><td><input name='T${inpu"
"t_nr}' value='${t['T'+input_nr]}' pattern='[0-9]{1,6}' required title='1 to 6 numbers'/"
"></td></tr>`)}return T('</table>'),{r:B,s:I,l:q,i:E}})({b00:'%b00',b04:'%b04',b08:'%b08"
"',c00:'%c00',d00:'%d00',b12:'%b12',c01:'%c01',h00:'%h00',g00:'%g00',j00:'%j00',j01:'%j0"
"1',j02:'%j02',j03:'%j03',j04:'%j04',j05:'%j05',j06:'%j06',j07:'%j07',j08:'%j08',j09:'%j"
"09',j10:'%j10',j11:'%j11',j12:'%j12',j13:'%j13',j14:'%j14',j15:'%j15',j16:'%j16',j17:'%"
"j17',j18:'%j18',j19:'%j19',j20:'%j20',j21:'%j21',j22:'%j22',j23:'%j23',T00:'%T00',T01:'"
"%T01',T02:'%T02',T03:'%T03',T04:'%T04',T05:'%T05',T20:'%T20',T21:'%T21',T22:'%T22',T23:"
"'%T23',T24:'%T24',T25:'%T25'});"
      "%y00"
      "<p>"
      "Pinout Option %w01<br/>"
      "PCF8574 %w02<br/>"
      "Code Revision %w00<br/>"
      "<a href='https://github.com/nielsonm236/NetMod-ServerApp/wiki' target='_blank'>Help Wiki</a>"
      "</p>"
      "%y02'm.r()'>Reboot</button>"
      "<br><br>"
      "%y02'm.l()'>Refresh</button>"
      "<br><br>"
      "%y02'm.i()'>IO Control</button> "
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
        features = { "Full Duplex": 1, "MQTT": 4, "DS18B20": 8, "BME280": 32, "Disable Cfg Button": 16 },
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
    selector_apply_fn('.up input', (e) => { set_attributes(e, {title: '0 to 10 letters, numbers, and -_*. no spaces. Blank for no entry.', pattern: '[\w*.\-]{0,10}$' }); });
    ip_input_names.forEach((n) => set_input_value(n, convert_from_hex(data[n]).join('.')));
    port_input_names.forEach((n) => set_input_value(n, parse_int(data[n], 16)));
    set_input_value('d00', data.d00.replace(/[0-9a-z]{2}(?!$)/g, '$&:'));
    document_write(`<table><tr><th>IO</th><th>Type</th><th>IDX</th><th>Invert</th><th>Boot state</th></tr>`);
    convert_from_hex(data.h00).forEach((n, i) => {
        const
            invert_checkbox = (n & 3) != 0 ? make_checkbox('p'+i, 4, n) : '',
            input_nr = (''+i).padStart(2, '0'),
            make_select = (n & 3) == 3 || ((n & 3) == 2 && i > 7) ? `<select name='p${i}'>${make_options(boot_state, n & 24)}</select>` : '',
            debug_column = (loc.hash == '#d'?`<td>${n}</td>`:'');
            document_write(`<tr><td>#${i + 1}</td><td><select name='p${i}'>${make_options(pin_types, n & 3)}</select></td><td><input name='j${input_nr}' value='${data['j'+input_nr]}' pattern='[0-9]{1,6}' required title='1 to 6 numbers'/></td><td>${invert_checkbox}</td><td>${make_select}</td>${debug_column}</tr>`);
    });
    selector(".f").innerHTML = Array.from(get_entries(features), ([name, bit]) => make_checkbox('g00', bit, features_data, name)).join("</br>");
    document_write(`</table>`);
    document_write(`<br><h1>Sensor IDX Configuration</h1>`);
    document_write(`<table><tr><th>Sensor Ser #</th><th>IDX</th></tr>`);
    for (var i=0; i<6; i++) {
        const
            ser_num = (''+i).padStart(2, '0');
            j = i + 20,
            input_nr = (''+j).padStart(2, '0');
            document_write(`<tr><td>${data['T'+ser_num]}</td><td><input name='T${input_nr}' value='${data['T'+input_nr]}' pattern='[0-9]{1,6}' required title='1 to 6 numbers'/></td></tr>`);
    };
    document_write(`</table>`);
    
    return {r:reboot, s: submitForm, l:reload_page, i:ioc_page};
})
({
    b00: "c0a80004",
    b04: "c0a80101",
    b08: "ffffff00",
    c00: "0050",
    d00: "aabbccddeeff",
    b12: "c0a80005",
    c01: "075b",
    h00: "00020305070b0f13161700000000000000020305070b0f13",
    g00: "04",
    j00: "0",
    j01: "1",
    j02: "2",
    j03: "3",
    j04: "4",
    j05: "5",
    j06: "6",
    j07: "7",
    j08: "8",
    j09: "9",
    j10: "10",
    j11: "11",
    j12: "12",
    j13: "13",
    j14: "14",
    j15: "15",
    j16: "20",
    j17: "21",
    j18: "22",
    j19: "23",
    j20: "24",
    j21: "25",
    j22: "26",
    j23: "27",
    T00: "3c01e076be0f",
    T01: "------------",
    T02: "------------",
    T03: "------------",
    T04: "------------",
    T05: "BME280------",
    T20: "30",
    T21: "31",
    T22: "32",
    T23: "33",
    T24: "34",
    T25: "35",
});

*/
#endif // BUILD_SUPPORT == MQTT_BUILD && DOMOTICZ_SUPPORT == 1









#if BUILD_SUPPORT == BROWSER_ONLY_BUILD
// ************************************************************************* //
// ************************************************************************* //
// ************************************************************************* //
// ************************************************************************* //
// **                                                                      * //
// ** Browser IO Control Template                                          * //
// **                                                                      * //
// ************************************************************************* //
// ************************************************************************* //
// ************************************************************************* //
// ************************************************************************* //
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
#define BROWSER_ONLY_WEBPAGE_IOCONTROL_BEGIN	1
// The _BEGIN define is used only by the "prepsx" strings pre-processor
// program. The value of "1" is not used as the prepsx program only searches
// for the _BEGIN phrase. The _BEGIN phrase is used by the prepsx program as
// a keyword for locating the webpage text contained in the static const
// below. The prepsx program extracts the HTML "string" and places it in a
// SREC (.sx) file. The HTML strings in the .sx file are uploaded into the
// I2C EEPROM for subsequent use in generating webpages from the I2C EEPROM
// instead of generating them from Flash.
//
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
// ************************************************************************* //
// ************************************************************************* //
// ************************************************************************* //
// ************************************************************************* //
// **                                                                      * //
// ** Browser Configuration Template                                       * //
// **                                                                      * //
// ************************************************************************* //
// ************************************************************************* //
// ************************************************************************* //
// ************************************************************************* //
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
#define BROWSER_ONLY_WEBPAGE_CONFIGURATION_BEGIN	1
// The _BEGIN define is used only by the "prepsx" strings pre-processor
// program. The value of "1" is not used as the prepsx program only searches
// for the _BEGIN phrase. The _BEGIN phrase is used by the prepsx program as
// a keyword for locating the webpage text contained in the static const
// below. The prepsx program extracts the HTML "string" and places it in a
// SREC (.sx) file. The HTML strings in the .sx file are uploaded into the
// I2C EEPROM for subsequent use in generating webpages from the I2C EEPROM
// instead of generating them from Flash.
//
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
               "<td><input name='a00' value='%a00' pattern='[0-9a-zA-Z_*.-]{1,19}' required title='1 to 19 letters, numbers, and -_*. no spaces'/></td>"
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
                 "<input name='d00' required pattern='([0-9a-fA-F]{2}[:-]?){5}([0-9a-fA-F]{2})' title='aa:bb:cc:dd:ee:ff format'/>"
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
"ation.href='/60',D=()=>l.href='/63',T=()=>l.href='/61',k=()=>l.href='/6b',A=()=>{a.body"
".innerText='Wait 5s...',setTimeout(T,5e3)},B=()=>{q('GET','/91'),A()},z=$=>{$.preventDe"
"fault();let e=Array.from(y().entries(),([$,e])=>`${h($)}=${h(e)}`).join('&');q('POST','"
"/',e+'&z00=0'),A()},C=u($.g00)[0],L={required:!0};return x('.ip',$=>{S($,{...L,title:'x"
".x.x.x format',pattern:'((25[0-5]|(2[0-4]|1[0-9]|[1-9]|)[0-9])([.](?!$)|$)){4}'})}),x('"
".port',$=>{S($,{...L,type:'number',min:10,max:65535})}),e.forEach(e=>g(e,u($[e]).join('"
".'))),t.forEach(e=>g(e,p($[e],16))),g('d00',$.d00.replace(/[0-9a-z]{2}(?!$)/g,'$&:')),u"
"($.h00).forEach((e,t)=>{let i=(3&e)!=0?v('p'+t,4,e):'',a=($,i)=>(3&e)==3||(3&e)==2&&t>7"
"?$:i,j=(''+t).padStart(2,'0'),o=a(u($['i'+j]).reduce(($,e)=>($<<8)+e),0),d=a(`<select n"
"ame='p${t}'>${E(r,24&e)}</select>`,''),p='#d'==l.hash?`<td>${e}</td>`:'',c=a(`<input ty"
"pe=number class=t8 name='i${j}' value='${16383&o}' min=0 max=16383><select name='i${j}'"
">${E(n,49152&o)}</select>`,'');s(`<tr><td>#${t+1}</td><td><select name='p${t}'>${E(_,3&"
"e)}</select></td><td><input name='j${j}' value='${$['j'+j]}' pattern='[w*.-]{1,15}' req"
"uired title='1 to 15 letters, numbers, and -*_. no spaces' maxlength=15/></td><td>${i}<"
"/td><td>${d}</td><td>${c}</td>${p}</tr>`)}),j('.f').innerHTML=Array.from(d(i),([$,e])=>"
"v('g00',e,C,$)).join('</br>'),{r:B,s:z,l:T,i:w,p:D,q:k}})({b00:'%b00',b04:'%b04',b08:'%"
"b08',c00:'%c00',d00:'%d00',h00:'%h00',g00:'%g00',j00:'%j00',j01:'%j01',j02:'%j02',j03:'"
"%j03',j04:'%j04',j05:'%j05',j06:'%j06',j07:'%j07',j08:'%j08',j09:'%j09',j10:'%j10',j11:"
"'%j11',j12:'%j12',j13:'%j13',j14:'%j14',j15:'%j15',i00:'%i00',i01:'%i01',i02:'%i02',i03"
":'%i03',i04:'%i04',i05:'%i05',i06:'%i06',i07:'%i07',i08:'%i08',i09:'%i09',i10:'%i10',i1"
"1:'%i11',i12:'%i12',i13:'%i13',i14:'%i14',i15:'%i15'});"
      "%y01"
      "<p>"
      "Pinout Option %w01<br/>"
      "PCF8574 %w02<br/>"
      "Code Revision %w00<br/>"
      "<a href='https://github.com/nielsonm236/NetMod-ServerApp/wiki' target='_blank'>Help Wiki</a>"
      "</p>"
      "%y02'm.r()'>Reboot</button>"
      "<br><br>"
      "%y02'm.l()'>Refresh</button>"
      "<br><br>"
      "%y02'm.i()'>IO Control</button> "
      "%y02'm.p()'>PCF8574 Configuration</button>"
      "<br><br>"
      "%y02'm.q()'>Login Configuration</button>"
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
        cfg_login_page = () => loc.href='/6b',
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
        document_write(`<tr><td>#${i + 1}</td><td><select name='p${i}'>${make_options(pin_types, n & 3)}</select></td><td><input name='j${input_nr}' value='${data['j'+input_nr]}' pattern='[\w*.\-]{1,15}' required title='1 to 15 letters, numbers, and -*_. no spaces' maxlength=15/></td><td>${invert_checkbox}</td><td>${boot_state_select}</td><td>${timer_column}</td>${debug_column}</tr>`);
    });
    
    selector(".f").innerHTML = Array.from(get_entries(features),([name, bit]) => make_checkbox('g00', bit, features_data, name)).join("</br>");
    
    return {r:reboot, s: submitForm, l:reload_page, i:ioc_page, p:cfg_page_pcf, q:cfg_login_page};
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






// #if BUILD_SUPPORT == MQTT_BUILD
#if BUILD_SUPPORT == MQTT_BUILD && HOME_ASSISTANT_SUPPORT == 1
// ************************************************************************* //
// ************************************************************************* //
// ************************************************************************* //
// ************************************************************************* //
// **                                                                      * //
// ** MQTT PCF8574 IO Control Template                                     * //
// **                                                                      * //
// ************************************************************************* //
// ************************************************************************* //
// ************************************************************************* //
// ************************************************************************* //
//
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
// For 1 of the replies there are 5 bytes per reply
// The formula in this case is
//     PARSEBYTES = (1 x 21)
//                + (1 x 5)
//     PARSEBYTES = 21
//                + 5 = 26
//
#define WEBPAGE_PCF8574_IOCONTROL		21
#define PARSEBYTES_PCF8574_IOCONTROL		26
#define MQTT_WEBPAGE_PCF8574_IOCONTROL_BEGIN    1
// The _BEGIN define is used only by the "prepsx" strings pre-processor
// program. The value of "1" is not used as the prepsx program only searches
// for the _BEGIN phrase. The _BEGIN phrase is used by the prepsx program as
// a keyword for locating the webpage text contained in the static const
// below. The prepsx program extracts the HTML "string" and places it in a
// SREC (.sx) file. The HTML strings in the .sx file are uploaded into the
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
// #endif // BUILD_SUPPORT == MQTT_BUILD
#endif // BUILD_SUPPORT == MQTT_BUILD && HOME_ASSISTANT_SUPPORT == 1






#if BUILD_SUPPORT == MQTT_BUILD && HOME_ASSISTANT_SUPPORT == 1
// ************************************************************************* //
// ************************************************************************* //
// ************************************************************************* //
// ************************************************************************* //
// **                                                                      * //
// ** MQTT Home Assistant PCF8574 Configuration Template                   * //
// **                                                                      * //
// ************************************************************************* //
// ************************************************************************* //
// ************************************************************************* //
// ************************************************************************* //
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
#define MQTT_WEBPAGE_PCF8574_CONFIGURATION_BEGIN	1
// The _BEGIN define is used only by the "prepsx" strings pre-processor
// program. The value of "1" is not used as the prepsx program only searches
// for the _BEGIN phrase. The _BEGIN phrase is used by the prepsx program as
// a keyword for locating the webpage text contained in the static const
// below. The prepsx program extracts the HTML "string" and places it in a
// SREC (.sx) file. The HTML strings in the .sx file are uploaded into the
// I2C EEPROM for subsequent use in generating webpages from the I2C EEPROM
// instead of generating them from Flash.
//
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
               "<td><input name='A00' value='%A00' pattern='[0-9a-zA-Z_*.-]{1,19}' required title='1 to 19 letters, numbers, and -_*. no spaces'/></td>"
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
#endif // BUILD_SUPPORT == MQTT_BUILD && HOME_ASSISTANT_SUPPORT == 1









#if BUILD_SUPPORT == BROWSER_ONLY_BUILD
// ************************************************************************* //
// ************************************************************************* //
// ************************************************************************* //
// ************************************************************************* //
// **                                                                      * //
// ** Browser PCF8574 IO Control Template                                  * //
// **                                                                      * //
// ************************************************************************* //
// ************************************************************************* //
// ************************************************************************* //
// ************************************************************************* //
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
#define BROWSER_ONLY_WEBPAGE_PCF8574_IOCONTROL_BEGIN	1
// The _BEGIN define is used only by the "prepsx" strings pre-processor
// program. The value of "1" is not used as the prepsx program only searches
// for the _BEGIN phrase. The _BEGIN phrase is used by the prepsx program as
// a keyword for locating the webpage text contained in the static const
// below. The prepsx program extracts the HTML "string" and places it in a
// SREC (.sx) file. The HTML strings in the .sx file are uploaded into the
// I2C EEPROM for subsequent use in generating webpages from the I2C EEPROM
// instead of generating them from Flash.
//
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
// ************************************************************************* //
// ************************************************************************* //
// ************************************************************************* //
// ************************************************************************* //
// **                                                                      * //
// ** Browser PCF8574 Configuration Template                               * //
// **                                                                      * //
// ************************************************************************* //
// ************************************************************************* //
// ************************************************************************* //
// ************************************************************************* //
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
#define BROWSER_ONLY_WEBPAGE_PCF8574_CONFIGURATION_BEGIN	1
// The _BEGIN define is used only by the "prepsx" strings pre-processor
// program. The value of "1" is not used as the prepsx program only searches
// for the _BEGIN phrase. The _BEGIN phrase is used by the prepsx program as
// a keyword for locating the webpage text contained in the static const
// below. The prepsx program extracts the HTML "string" and places it in a
// SREC (.sx) file. The HTML strings in the .sx file are uploaded into the
// I2C EEPROM for subsequent use in generating webpages from the I2C EEPROM
// instead of generating them from Flash.
//
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
               "<td><input name='A00' value='%A00' pattern='[0-9a-zA-Z_*.-]{1,19}' required title='1 to 19 letters, numbers, and -_*. no spaces'/></td>"
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
" value='${e['J'+i]}' pattern='[w*.-]{1,15}' required title='1 to 15 letters, numbers, a"
"nd -*_. no spaces' maxlength=15/></td><td>${l}</td><td>${I}</td><td>${h}</td>${J}</tr>`"
")}),{r:g,s:j,l:v,c:b,i:x,j:S}})({H00:'%H00',J16:'%J16',J17:'%J17',J18:'%J18',J19:'%J19'"
",J20:'%J20',J21:'%J21',J22:'%J22',J23:'%J23',I16:'%I16',I17:'%I17',I18:'%I18',I19:'%I19"
"',I20:'%I20',I21:'%I21',I22:'%I22',I23:'%I23'});"
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
        document_write(`<tr><td>#${j+1}</td><td><select name='p${i}'>${make_options(pin_types, n & 3)}</select></td><td><input name='J${input_nr}' value='${data['J'+input_nr]}' pattern='[\w*.\-]{1,15}' required title='1 to 15 letters, numbers, and -*_. no spaces' maxlength=15/></td><td>${invert_checkbox}</td><td>${boot_state_select}</td><td>${timer_column}</td>${debug_column}</tr>`);
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







#if BUILD_SUPPORT == BROWSER_ONLY_BUILD && SHORT_TEMPERATURE_SUPPORT == 1
// ************************************************************************* //
// ************************************************************************* //
// ************************************************************************* //
// ************************************************************************* //
// **                                                                      * //
// ** Short Temperature Response Template                                  * //
// **                                                                      * //
// ************************************************************************* //
// ************************************************************************* //
// ************************************************************************* //
// ************************************************************************* //
//
// This template provides a response containing only the DS18B20 temperature
// sensor data in a compact form.
// URL /97
//
#define WEBPAGE_SHORT_TEMPERATURE		23
static const char g_HtmlPageShortTemperature[] =
  "%t20%t21%t22%t23%t24";
#endif // BUILD_SUPPORT == BROWSER_ONLY_BUILD && SHORT_TEMPERATURE_SUPPORT == 1






#if LOGIN_SUPPORT == 1
// ************************************************************************* //
// ************************************************************************* //
// ************************************************************************* //
// ************************************************************************* //
// **                                                                      * //
// ** Login Template                                                       * //
// **                                                                      * //
// ************************************************************************* //
// ************************************************************************* //
// ************************************************************************* //
// ************************************************************************* //
//
// PARSE_BYTES calculation:
// The form contained in this webpage will generate two data update replies.
// These replies need to be parsed to extract the data from them. We need to
// stop parsing the reply POST data after all update bytes are parsed.
//   Note: The Login Passphrase is a maximum of 15 characters. Due to code
//   space limitations special characters taht require URL encoding are not
//   allowed.
// The formula for determining the stop value is as follows:
//     For 1 of the replies (Passphrase):
//     example: l02=xxxxxxxxxxxxxxx&
//     where xxxxxxxxxxxxxxx is 1 to 15 bytes
//   PLUS
//   For 1 of the replies (hidden):
//   POST consists of a ParseCmd (a "z" in this case) in 1 byte
//     example: z00=x (note no &)
//     where x is 1 byte
// The formula in this case is
//     PARSEBYTES = (1 x 20)
//                + (1 x 5)
//     PARSEBYTES = 20
//                + 5 = 25
//
#define WEBPAGE_LOGIN			4
#define PARSEBYTES_LOGIN		25
#define WEBPAGE_LOGIN_BEGIN		1
// The _BEGIN define is used only by the "prepsx" strings pre-processor
// program. The value of "1" is not used as the prepsx program only searches
// for the _BEGIN phrase. The _BEGIN phrase is used by the prepsx program as
// a keyword for locating the webpage text contained in the static const
// below. The prepsx program extracts the HTML "string" and places it in a
// SREC (.sx) file. The HTML strings in the .sx file are uploaded into the
// I2C EEPROM for subsequent use in generating webpages from the I2C EEPROM
// instead of generating them from Flash.
//
// Next #if: Only place the HTML in Flash if the I2C EEPROM is not supported.
// Comment: This HTML is NEVER placed in Flash, as the Login function is
// supported only when the I2C EEPROM is present. Thus the build configuration
// will have OB_EEPROM_SUPPORT = 1 when LOGIN_SUPPORT = 1.
#if OB_EEPROM_SUPPORT == 0
static const char g_HtmlPageLogin[] =
"%y04%y05"
   "<title>Login</title>"
   "</head>"
   "<body>"
      "<h1>Login</h1>"
      "<form method='post'>"
         "<table>"
            "<tr>"
               "<td>Passphrase</td>"
               "<td><input name='l02' value='%l02' pattern='[\w*.\-]{1,15}' required></td>"
            "</tr>"
         "</table>"
         "<input type='hidden' name='z00' value='0'>"
         "<br>"
         "<button type=submit>Submit</button>"
      "</form>"
   "</body>"
"</html>";
#endif // OB_EEPROM_SUPPORT == 0
#if OB_EEPROM_SUPPORT == 1
// Declared short static const here so that common code can be used for Flash
// and I2C EEPROM webpage sources.
static const char g_HtmlPageLogin[] = " ";
#endif // OB_EEPROM_SUPPORT == 1
#endif // LOGIN_SUPPORT == 1






#if LOGIN_SUPPORT == 1
// ************************************************************************* //
// ************************************************************************* //
// ************************************************************************* //
// ************************************************************************* //
// **                                                                      * //
// ** Set Passphrase Template                                              * //
// **                                                                      * //
// ************************************************************************* //
// ************************************************************************* //
// ************************************************************************* //
// ************************************************************************* //
//
// PARSE_BYTES calculation:
// The form contained in this webpage will generate two data update replies.
// These replies need to be parsed to extract the data from them. We need to
// stop parsing the reply POST data after all update bytes are parsed.
//   Note: The Login Passphrase is a maximum of 15 characters. Due to code
//   space limitations special characters taht require URL encoding are not
//   allowed.
// The formula for determining the stop value is as follows:
//     For 1 of the replies (Passphrase):
//     example: l01=xxxxxxxxxxxxxxx&
//     where xxxxxxxxxxxxxxx is 0 to 15 bytes
//   PLUS
//   For 1 of the replies (hidden):
//   POST consists of a ParseCmd (a "z" in this case) in 1 byte
//     example: z00=x (note no &)
//     where x is 1 byte
// The formula in this case is
//     PARSEBYTES = (1 x 20)
//                + (1 x 5)
//     PARSEBYTES = 20
//                + 5 = 25
//
#define WEBPAGE_SET_PASSPHRASE		5
#define PARSEBYTES_SET_PASSPHRASE	25
#define WEBPAGE_SET_PASSPHRASE_BEGIN	1
// The _BEGIN define is used only by the "prepsx" strings pre-processor
// program. The value of "1" is not used as the prepsx program only searches
// for the _BEGIN phrase. The _BEGIN phrase is used by the prepsx program as
// a keyword for locating the webpage text contained in the static const
// below. The prepsx program extracts the HTML "string" and places it in a
// SREC (.sx) file. The HTML strings in the .sx file are uploaded into the
// I2C EEPROM for subsequent use in generating webpages from the I2C EEPROM
// instead of generating them from Flash.
//
// Next #if: Only place the HTML in Flash if the I2C EEPROM is not supported.
// Comment: This HTML is NEVER placed in Flash, as the Login function is
// supported only when the I2C EEPROM is present. Thus the build configuration
// will have OB_EEPROM_SUPPORT = 1 when LOGIN_SUPPORT = 1.
#if OB_EEPROM_SUPPORT == 0
static const char g_HtmlPageSetPassphrase[] =
"%y04%y05"
   "<title>Set Passphrase</title>"
   "</head>"
   "<body>"
      "<h1>Set Passphrase</h1>"
      "<form method='post'>"
         "<table>"
            "<tr>"
               "<td><input name='l01' value='%l01' pattern='[\w*.\-]{0,15}'></td>"
            "</tr>"
         "</table>"
         "<p>To set a Passphrase enter 1 to 15 letters, numbers, and -_*. no spaces</p>"
         "<p>To Disable the Login function Submit a blank Passphrase</p>"
         "<input type='hidden' name='z00' value='0'>"
         "<br>"
         "<button type=submit>Submit</button>"
      "</form>"
   "</body>"
"</html>";
#endif // OB_EEPROM_SUPPORT == 0
#if OB_EEPROM_SUPPORT == 1
// Declared short static const here so that common code can be used for Flash
// and I2C EEPROM webpage sources.
static const char g_HtmlPageSetPassphrase[] = " ";
#endif // OB_EEPROM_SUPPORT == 1
#endif // LOGIN_SUPPORT == 1







#if NETWORK_STATISTICS == 1
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
#endif // NETWORK_STATISTICS == 1


#if RF_ATTEN_SUPPORT == 1
// SDR RF Attenuator page Template
// Part of the Software Defined Radio project
// Browser Only builds
// URL /75
#define WEBPAGE_RF_ATTEN		18
static const char g_HtmlPageRFAtten[] =
"%y04%y05"
  "<title>RF Attenuator</title>"
  "<style>"
    "h1 { margin: 0; }"
  "</style>"
  "</head>"
  "<body>"
  "<p>"
    "<h1>RF Attenuator</h1>"
    "Device: %a00<br>"
  "</p>"
  "Current Setting %f01db<br><br>"
  "Select Attenuation (db)<br><br>"
  "%y0600`'>00%y07"
  "%y0602`'>01%y07"
  "%y0604`'>02%y07"
  "%y0606`'>03%y07"
  "%y0608`'>04%y07<br><br>"
  "%y060a`'>05%y07"
  "%y060c`'>06%y07"
  "%y060e`'>07%y07"
  "%y0610`'>08%y07"
  "%y0612`'>09%y07<br><br>"
  "%y0614`'>10%y07"
  "%y0616`'>11%y07"
  "%y0618`'>12%y07"
  "%y061a`'>13%y07"
  "%y061c`'>14%y07<br><br>"
  "%y061e`'>15%y07"
  "%y0620`'>16%y07"
  "%y0622`'>17%y07"
  "%y0624`'>18%y07"
  "%y0626`'>19%y07<br><br>"
  "%y0628`'>20%y07"
  "%y062a`'>21%y07"
  "%y062c`'>22%y07"
  "%y062e`'>23%y07"
  "%y0630`'>24%y07<br><br>"
  "%y0632`'>25%y07"
  "%y0634`'>26%y07"
  "%y0636`'>27%y07"
  "%y0638`'>28%y07"
  "%y063a`'>29%y07<br><br>"
  "%y063c`'>30%y07"
  "%y063e`'>31%y07<br>"
  
  "<script>"
    "setTimeout( function() {"
      "location='/75';"
    "}, 30000);"
  "</script>"
  
  "</body>"
  "</html>";
  
// For reference the above string replacements are as follows:
//   String for %y06 replacement
//     <button onclick='location=`/52003f00
//   String for %y07 replacement
//     </button>&emsp;&ensp;
// The original button code was
//  "Select Attenuation (db)<br><br>"
//  "<button onclick='location=`/52003f0000`'>00</button>&emsp;&ensp;"
//  "<button onclick='location=`/52003f0002`'>01</button>&emsp;&ensp;"
//  "<button onclick='location=`/52003f0004`'>02</button>&emsp;&ensp;"
//  "<button onclick='location=`/52003f0006`'>03</button>&emsp;&ensp;"
//  "<button onclick='location=`/52003f0008`'>04</button>&emsp;&ensp;<br><br>"
//  "<button onclick='location=`/52003f000a`'>05</button>&emsp;&ensp;"
//  "<button onclick='location=`/52003f000c`'>06</button>&emsp;&ensp;"
//  "<button onclick='location=`/52003f000e`'>07</button>&emsp;&ensp;"
//  "<button onclick='location=`/52003f0010`'>08</button>&emsp;&ensp;"
//  "<button onclick='location=`/52003f0012`'>09</button>&emsp;&ensp;<br><br>"
//  "<button onclick='location=`/52003f0014`'>10</button>&emsp;&ensp;"
//  "<button onclick='location=`/52003f0016`'>11</button>&emsp;&ensp;"
//  "<button onclick='location=`/52003f0018`'>12</button>&emsp;&ensp;"
//  "<button onclick='location=`/52003f001a`'>13</button>&emsp;&ensp;"
//  "<button onclick='location=`/52003f001c`'>14</button>&emsp;&ensp;<br><br>"
//  "<button onclick='location=`/52003f001e`'>15</button>&emsp;&ensp;"
//  "<button onclick='location=`/52003f0020`'>16</button>&emsp;&ensp;"
//  "<button onclick='location=`/52003f0022`'>17</button>&emsp;&ensp;"
//  "<button onclick='location=`/52003f0024`'>18</button>&emsp;&ensp;"
//  "<button onclick='location=`/52003f0026`'>19</button>&emsp;&ensp;<br><br>"
//  "<button onclick='location=`/52003f0028`'>20</button>&emsp;&ensp;"
//  "<button onclick='location=`/52003f002a`'>21</button>&emsp;&ensp;"
//  "<button onclick='location=`/52003f002c`'>22</button>&emsp;&ensp;"
//  "<button onclick='location=`/52003f002e`'>23</button>&emsp;&ensp;"
//  "<button onclick='location=`/52003f0030`'>24</button>&emsp;&ensp;<br><br>"
//  "<button onclick='location=`/52003f0032`'>25</button>&emsp;&ensp;"
//  "<button onclick='location=`/52003f0034`'>26</button>&emsp;&ensp;"
//  "<button onclick='location=`/52003f0036`'>27</button>&emsp;&ensp;"
//  "<button onclick='location=`/52003f0038`'>28</button>&emsp;&ensp;"
//  "<button onclick='location=`/52003f003a`'>29</button>&emsp;&ensp;<br><br>"
//  "<button onclick='location=`/52003f003c`'>30</button>&emsp;&ensp;"
//  "<button onclick='location=`/52003f003e`'>31</button>&emsp;&ensp;<br>"
//
// I tried using an iframe to display the Current Attenuator value so that I
// wouldn't have to resend and repaint the entire page. Unfortunately I
// couldn't get that to work properly.
#endif // RF_ATTEN_SUPPORT == 1


#if INA226_SUPPORT == 1
// SDR INA226 page Template
// Part of the Software Defined Radio project
// Browser Only builds
// URL /76
// About 287 characters
#define WEBPAGE_INA226		19
static const char g_HtmlPageINA226[] =
"%y04%y05"
  "<title>Power</title>"
  "<style>"
    "h1 { margin: 0; }"
  "</style>"
  "</head>"
  "<body>"
  "<p>"
    "<h1>Power</h1>"
    "Device: %a00<br>"
  "</p>"
  "INA226-1<br>"
  "%t06"
  "<br>"
  "INA226-2<br>"
  "%t07"
  "<br>"
  "INA226-3<br>"
  "%t08"
  "<br>"
  "INA226-4<br>"
  "%t09"
  "<br>"
  "INA226-5<br>"
  "%t10"

  "<script>"
    "setTimeout( function() {"
      "location='/76';"
    "}, 30000);"
  "</script>"
  
  "</body>"
  "</html>";
#endif // INA226_SUPPORT == 1


#if SDR_POWER_RELAY_SUPPORT == 1
// SDR Power Relay page Template
// Part of the Software Defined Radio project
// Browser Only builds
// URL /77
// It is assumed that the Configuration for all IO's is set as follows:
// IO   Type     Name       Invert   Boot State   Timer
// #1   Output   Relay 1    No       Off          15  0.1s
// #2   Output   Relay 1    No       Off          15  0.1s
// #3   Output   Relay 2    No       Off          15  0.1s
// #4   Output   Relay 2    No       Off          15  0.1s
// #5   Output   Relay 3    No       Off          15  0.1s
// #6   Output   Relay 3    No       Off          15  0.1s
// #7   Output   Relay 4    No       Off          15  0.1s
// #8   Output   Relay 4    No       Off          15  0.1s
// #9   Output   Relay 5    No       Off          15  0.1s
// #10  Output   Relay 5    No       Off          15  0.1s
// #11  Output   Relay 6    No       Off          15  0.1s
// #12  Output   Relay 6    No       Off          15  0.1s
// #13  Output   Relay 7    No       Off          15  0.1s
// #14  Output   Relay 7    No       Off          15  0.1s
// #15  Output   Relay 8    No       Off          15  0.1s
// #16  Output   Relay 8    No       Off          15  0.1s
// Note: "Name" can be anything, but the above is illustrative of what the
// IO does.
#define WEBPAGE_SDR_POWER_RELAY	20
static const char g_HtmlPageSDRPowerRelay[] =
"%y04%y05"
  "<title>Keep Relays</title>"
  "<style>"
    "h1 {margin:0;}"
    ".box {float:left; height:20px; width:20px; margin-right:15px; border:1px solid black; clear:both;}"
    ".red {background-color:red;}"
    ".grn {background-color:green;}"
    ".kr-btn1 {position:absolute; left:35px;}"
    ".kr-btn2 {position:absolute; left:75px;}"
    ".kr-name {position:absolute; left:130px;}"
    "</style>"
  "</head>"
  "<body>"
  "<p>"
    "<h1>Keep Relays</h1>"
    "Device: %a00<br>"
  "</p>"
  "<div class='box %n10'></div><button class='kr-btn1' onclick='location=`/01`'>ON</button> <button class='kr-btn2' onclick='location=`/03`'>OFF</button><div class='kr-name'>%j00</div><br><br>"
  "<div class='box %n11'></div><button class='kr-btn1' onclick='location=`/05`'>ON</button> <button class='kr-btn2' onclick='location=`/07`'>OFF</button><div class='kr-name'>%j02</div><br><br>"
  "<div class='box %n12'></div><button class='kr-btn1' onclick='location=`/09`'>ON</button> <button class='kr-btn2' onclick='location=`/11`'>OFF</button><div class='kr-name'>%j04</div><br><br>"
  "<div class='box %n13'></div><button class='kr-btn1' onclick='location=`/13`'>ON</button> <button class='kr-btn2' onclick='location=`/15`'>OFF</button><div class='kr-name'>%j06</div><br><br>"
  "<div class='box %n14'></div><button class='kr-btn1' onclick='location=`/17`'>ON</button> <button class='kr-btn2' onclick='location=`/19`'>OFF</button><div class='kr-name'>%j08</div><br><br>"
  "<div class='box %n15'></div><button class='kr-btn1' onclick='location=`/21`'>ON</button> <button class='kr-btn2' onclick='location=`/23`'>OFF</button><div class='kr-name'>%j10</div><br><br>"
  "<div class='box %n16'></div><button class='kr-btn1' onclick='location=`/25`'>ON</button> <button class='kr-btn2' onclick='location=`/27`'>OFF</button><div class='kr-name'>%j12</div><br><br>"
  "<div class='box %n17'></div><button class='kr-btn1' onclick='location=`/29`'>ON</button> <button class='kr-btn2' onclick='location=`/31`'>OFF</button><div class='kr-name'>%j14</div><br><br>"

  "<script>"
    "setTimeout( function() {"
      "location='/77';"
    "}, 30000);"
  "</script>"
  
  "</body>"
  "</html>";
#endif // SDR_POWER_RELAY_SUPPORT == 1






/*
#if LINK_STATISTICS == 1
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
#endif // LINK_STATISTICS == 1
*/
#if LINK_STATISTICS == 1
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
#endif // LINK_STATISTICS == 1



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


// Very Short IO state page Template
// Only responds with a TCP payload that contains the 16 alphanumeric
// characters representing the IO pins states. The response may not be
// browser compatible.
// URL /98 and /99
#define WEBPAGE_SSTATE		9
static const char g_HtmlPageSstate[] =
  "%f00";


// Load Uploader page Template
// This web page is shown when the user requests the Code Uploader with the
// /72 command. It is stored in the I2C EEPROM and used only in upgradeable
// builds, so it should never be compiled for storage in Flash.
#define WEBPAGE_LOADUPLOADER		12
#define WEBPAGE_LOADUPLOADER_BEGIN	1
// The WEBPAGE_LOADUPLOADER_BEGIN define is used only by the "prepsx" strings
// pre-processor program. The value is not used as the "prepsx" program only
// searches for the _BEGIN phrase. The _BEGIN phrase is used by the prepsx
// program as a keyword for locating the webpage text contained in the static
// const below. The prepsx program extracts the HTML "string" and places it in
// an SREC (.sx) file. The HTML strings in the .sx file are uploaded into the
// I2C EEPROM for subsequent use in generating webpages from the I2C EEPROM
// instead of generating them from Flash.
//
// Next #if: This HTML is NEVER placed in Flash, it is always placed in I2C
// EEPROM. So OB_EEPROM_SUPPORT = 2 (which can never occur) is used to prevent
// a compiler include for the HTML in Flash.
#if OB_EEPROM_SUPPORT == 2
static const char g_HtmlPageLoadUploader[] =
  "%y04%y05"
  "<title>Loading Code Uploader</title>"
  "</head>"
  "<body>"
  "<h1>Loading Code Uploader</h1>"
  "<p>"
  
  "<progress value='0' max='15' id='progressBar'></progress>"
  "<script>"
  "var timeleft = 15;"
  "var downloadTimer = setInterval(function(){"
    "if(timeleft <= 0){"
      "clearInterval(downloadTimer);"
      "location.href = '/';"
    "}"
    "document.getElementById('progressBar').value = 15 - timeleft;"
    "timeleft -= 1;"
  "}, 1000);"
  "</script>"
  
  "<br>"
  "<br>"
  
  "</p>"
  "Click Continue only if code does not auto-start.<br><br>"
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
  "Use BROWSE to select a .sx file then click SUBMIT. The 30 second<br>"
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
  
  "<progress value='0' max='15' id='progressBar'></progress>"
  "<script>"
  "var timeleft = 15;"
  "var downloadTimer = setInterval(function(){"
    "if(timeleft <= 0){"
      "clearInterval(downloadTimer);"
      "location.href = '/';"
    "}"
    "document.getElementById('progressBar').value = 15 - timeleft;"
    "timeleft -= 1;"
  "}, 1000);"
  "</script>"
  "<br>"
  "<br>"
  
  "</p>"
  "Click Continue only if code does not auto-start.<br><br>"
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
  "Wait until the progress bar completes. Code should auto-start on Flash Write completion.<br><br>"
  
  "<progress value='0' max='15' id='progressBar'></progress>"
  "<script>"
  "var timeleft = 15;"
  "var downloadTimer = setInterval(function(){"
    "if(timeleft <= 0){"
      "clearInterval(downloadTimer);"
      "location.href = '/';"
      "}"
    "document.getElementById('progressBar').value = 15 - timeleft;"
    "timeleft -= 1;"
  "}, 1000);"
  "</script>"
  "<br>"
  "<br>"
  
  "</p>"
  "Click Continue only if code does not auto-start.<br><br>"
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
  "<title>Strings Upload Complete</title>"
  "</head>"
  "<body>"
  "<h1>Strings Upload Complete</h1>"
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
//---------------------------------------------------------------------------//
//---------------------------------------------------------------------------//
// The following creates an array of strings that are commonly used strings
// in the HTML pages. To reduce the size of the HTML pages these common
// strings are replaced with placeholders of the form "%yxx", then when the
// HTML page is copied to the trasnmit buffer the placeholders are replaced
// with one of the strings in this array. The length of each string is
// manually counted and put in the associated _len value. When the _len value 
// is needed it often has 4 subtracted (as the strings are replacing the 4
// character placeholder), so that subtraction is done once here.
// Notes for Flash optimization:
// 1) Strings must be at least 5 characters in length because the size of the
//    string (less 5) is stored as an integer in the string structure defined
//    below.
// 2) Strings must be < 256 characters.
// 3) If two strings are identical the compiler optimizer will creae a single
//    string and point to that string.
// 4) CAUTION: Strings defined here are placed in a structure even if they are
//    not used in a given build. Since it is important that the index to a
//    given string always be the same in all builds, the best mitigation to
//    prevent an unused string from occupying Flash space is to use a compiler
//    directive to replace that string with a shorter "not used" placeholder.

// The following creates an array of strings of variable lengths.

// String for %y00 replacement in web page templates.
// XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
// CLEAN THIS UP. Should be able to make y00 and y01 the same thing but requires
// that /table be in the MQTT and Browser javascript instead of the HTML ... OR requres that
// /table be taken out of the Domoticz Javascript.
// XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
#if DOMOTICZ_SUPPORT == 0
#define s0 "" \
  "not used"
#endif // DOMOTICZ_SUPPORT == 0
#if DOMOTICZ_SUPPORT == 1
#define s0 "" \
  "</script>" \
  "<p>" \
  "<button type=submit>Save</button> <button type=reset onclick='m.l()'>Undo All</button>" \
  "</p>" \
  "</form>"
#endif // DOMOTICZ_SUPPORT == 1

// String for %y01 replacement in web page templates
#if DOMOTICZ_SUPPORT == 0
#define s1 "" \
  "</script>" \
  "</table>" \
  "<p>" \
  "<button type=submit>Save</button> <button type=reset onclick='m.l()'>Undo All</button>" \
  "</p>" \
  "</form>"
#endif // DOMOTICZ_SUPPORT == 0
#if DOMOTICZ_SUPPORT == 1
#define s1 "" \
  "not used"
#endif // DOMOTICZ_SUPPORT == 1

// String for %y02 replacement in web page templates
#define s2 "" \
  "<button title='Save first!' onclick="

// String for %y03 replacement in web page templates.
#define s3 "" \
  "not used"

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
  ".s div{width:13px;height:13px;display:inline-block;}" \
  ".hs{height:9px;}" \
  "</style>"
//  ".mac input{width:14px;}" \




#if RF_ATTEN_SUPPORT == 1
// String for %y06 replacement in web page templates
#define s6 "" \
  "<button onclick='location=`/52003f00"
#else
#define s6 "" \
  "not used"
#endif // RF_ATTEN_SUPPORT == 1
  
#if RF_ATTEN_SUPPORT == 1
// String for %y07 replacement in web page templates
#define s7 "" \
  "</button>&emsp;&ensp;"
#else
#define s7 "" \
  "not used"
#endif // RF_ATTEN_SUPPORT == 1


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

const struct page_string ps[8] = {
    { s0, sizeof(s0)-1, sizeof(s0)-5 },
    { s1, sizeof(s1)-1, sizeof(s1)-5 },
    { s2, sizeof(s2)-1, sizeof(s2)-5 },
    { s3, sizeof(s3)-1, sizeof(s3)-5 },
    { s4, sizeof(s4)-1, sizeof(s4)-5 },
    { s5, sizeof(s5)-1, sizeof(s5)-5 },
    { s6, sizeof(s6)-1, sizeof(s6)-5 },
    { s7, sizeof(s7)-1, sizeof(s7)-5 }
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

#if (sizeof(s6) > 255)
  #error "string s6 is too big"
#endif

#if (sizeof(s7) > 255)
  #error "string s7 is too big"
#endif
//---------------------------------------------------------------------------//
//---------------------------------------------------------------------------//
//---------------------------------------------------------------------------//


void HttpDStringInit() {
  // Initialize HttpD string sizes
  // If a non-upgradeable build the IOControl and Configuration webpage sizes
  // are based on the HTML strings in the httpd.c file that are compiled into
  // Flash.
  // If an upgradeable build the IOControl and Configuration webpage sizes are
  // obtained from the I2C EEPROM where the webpage strings are stored.
  
#if OB_EEPROM_SUPPORT == 0
  // ---------------------------------------------------------------------- //
  // Initialize size for Flash based IOControl and Configuration pages
  // ---------------------------------------------------------------------- //
  // Webpage sizes for non-upgradeable builds
  HtmlPageIOControl_size = (uint16_t)(sizeof(g_HtmlPageIOControl) - 1);
  HtmlPageConfiguration_size = (uint16_t)(sizeof(g_HtmlPageConfiguration) - 1);
#endif // OB_EEPROM_SUPPORT == 0


#if OB_EEPROM_SUPPORT == 1
  // ---------------------------------------------------------------------- //
  // Initialize size for I2C EEPROM based IOControl and Configuration pages
  // ---------------------------------------------------------------------- //
// #if BUILD_SUPPORT == MQTT_BUILD
#if BUILD_SUPPORT == MQTT_BUILD && HOME_ASSISTANT_SUPPORT == 1
  // Read 2 bytes from I2C EEPROM and convert to uint16_t.
  prep_read(I2C_EEPROM_R2_WRITE, I2C_EEPROM_R2_READ, MQTT_WEBPAGE_IOCONTROL_SIZE_LOCATION, 2);
  HtmlPageIOControl_size = read_two_bytes();
// #endif // BUILD_SUPPORT == MQTT_BUILD
#endif // BUILD_SUPPORT == MQTT_BUILD && HOME_ASSISTANT_SUPPORT == 1

#if BUILD_SUPPORT == MQTT_BUILD && DOMOTICZ_SUPPORT == 1
  // Read 2 bytes from I2C EEPROM and convert to uint16_t.
  prep_read(I2C_EEPROM_R2_WRITE, I2C_EEPROM_R2_READ, MQTT_DOMO_WEBPAGE_IOCONTROL_SIZE_LOCATION, 2);
  HtmlPageIOControl_size = read_two_bytes();
#endif // BUILD_SUPPORT == MQTT_BUILD && DOMOTICZ_SUPPORT == 1

#if BUILD_SUPPORT == BROWSER_ONLY_BUILD
  // Read 2 bytes from I2C EEPROM and convert to uint16_t.
  prep_read(I2C_EEPROM_R2_WRITE, I2C_EEPROM_R2_READ, BROWSER_ONLY_WEBPAGE_IOCONTROL_SIZE_LOCATION, 2);
  HtmlPageIOControl_size = read_two_bytes();
#endif // BUILD_SUPPORT == BROWSER_ONLY_BUILD

  
#if BUILD_SUPPORT == MQTT_BUILD && HOME_ASSISTANT_SUPPORT == 1
  // Read 2 bytes from I2C EEPROM and convert to uint16_t.
  prep_read(I2C_EEPROM_R2_WRITE, I2C_EEPROM_R2_READ, MQTT_WEBPAGE_CONFIGURATION_SIZE_LOCATION, 2);
  HtmlPageConfiguration_size = read_two_bytes();
#endif // BUILD_SUPPORT == MQTT_BUILD && HOME_ASSISTANT_SUPPORT == 1

#if BUILD_SUPPORT == MQTT_BUILD && DOMOTICZ_SUPPORT == 1
  // Read 2 bytes from I2C EEPROM and convert to uint16_t.
  prep_read(I2C_EEPROM_R2_WRITE, I2C_EEPROM_R2_READ, MQTT_DOMO_WEBPAGE_CONFIGURATION_SIZE_LOCATION, 2);
  HtmlPageConfiguration_size = read_two_bytes();
#endif // BUILD_SUPPORT == MQTT_BUILD && DOMOTICZ_SUPPORT == 1

#if BUILD_SUPPORT == BROWSER_ONLY_BUILD
  // Read 2 bytes from I2C EEPROM and convert to uint16_t.
  prep_read(I2C_EEPROM_R2_WRITE, I2C_EEPROM_R2_READ, BROWSER_ONLY_WEBPAGE_CONFIGURATION_SIZE_LOCATION, 2);
  HtmlPageConfiguration_size = read_two_bytes();
#endif // BUILD_SUPPORT == BROWSER_ONLY_BUILD


  // ---------------------------------------------------------------------- //
  // Initialize size for I2C EEPROM based PCF8574 IOControl and
  // Configuration pages
  // ---------------------------------------------------------------------- //
#if PCF8574_SUPPORT == 1
// #if BUILD_SUPPORT == MQTT_BUILD
#if BUILD_SUPPORT == MQTT_BUILD && HOME_ASSISTANT_SUPPORT == 1
  // Read 2 bytes from I2C EEPROM and convert to uint16_t.
  prep_read(I2C_EEPROM_R2_WRITE, I2C_EEPROM_R2_READ, MQTT_WEBPAGE_PCF8574_IOCONTROL_SIZE_LOCATION, 2);
  HtmlPagePCFIOControl_size = read_two_bytes();
// #endif // BUILD_SUPPORT == MQTT_BUILD
#endif // BUILD_SUPPORT == MQTT_BUILD && HOME_ASSISTANT_SUPPORT == 1

#if BUILD_SUPPORT == BROWSER_ONLY_BUILD
  // Read 2 bytes from I2C EEPROM and convert to uint16_t.
  prep_read(I2C_EEPROM_R2_WRITE, I2C_EEPROM_R2_READ, BROWSER_ONLY_WEBPAGE_PCF8574_IOCONTROL_SIZE_LOCATION, 2);
  HtmlPagePCFIOControl_size = read_two_bytes();
#endif // BUILD_SUPPORT == BROWSER_ONLY_BUILD

  
#if BUILD_SUPPORT == MQTT_BUILD && HOME_ASSISTANT_SUPPORT == 1
  // Read 2 bytes from I2C EEPROM and convert to uint16_t.
  prep_read(I2C_EEPROM_R2_WRITE, I2C_EEPROM_R2_READ, MQTT_WEBPAGE_PCF8574_CONFIGURATION_SIZE_LOCATION, 2);
  HtmlPagePCFConfiguration_size = read_two_bytes();
#endif // BUILD_SUPPORT == MQTT_BUILD && HOME_ASSISTANT_SUPPORT == 1

#if BUILD_SUPPORT == BROWSER_ONLY_BUILD
  // Read 2 bytes from I2C EEPROM and convert to uint16_t.
  prep_read(I2C_EEPROM_R2_WRITE, I2C_EEPROM_R2_READ, BROWSER_ONLY_WEBPAGE_PCF8574_CONFIGURATION_SIZE_LOCATION, 2);
  HtmlPagePCFConfiguration_size = read_two_bytes();
#endif // BUILD_SUPPORT == BROWSER_ONLY_BUILD
#endif // PCF8574_SUPPORT == 1

  
  // ---------------------------------------------------------------------- //
  // Initialize size for Login and Set Passphrase pages
  // ---------------------------------------------------------------------- //
#if LOGIN_SUPPORT == 1
  // Read 2 bytes from I2C EEPROM and convert to uint16_t.
  prep_read(I2C_EEPROM_R2_WRITE, I2C_EEPROM_R2_READ, WEBPAGE_LOGIN_SIZE_LOCATION, 2);
  HtmlPageLogin_size = read_two_bytes();

  // Read 2 bytes from I2C EEPROM and convert to uint16_t.
  prep_read(I2C_EEPROM_R2_WRITE, I2C_EEPROM_R2_READ, WEBPAGE_SET_PASSPHRASE_SIZE_LOCATION, 2);
  HtmlPageSetPassphrase_size = read_two_bytes();
#endif // LOGIN_SUPPORT == 1


  // ---------------------------------------------------------------------- //
  // Initialize size for I2C EEPROM based LoadUploader page
  // ---------------------------------------------------------------------- //
  // This is always performed if an upgradeable build
  // Read 2 bytes from I2C EEPROM and convert to uint16_t.
  prep_read(I2C_EEPROM_R2_WRITE, I2C_EEPROM_R2_READ, WEBPAGE_LOADUPLOADER_SIZE_LOCATION, 2);
  HtmlPageLoadUploader_size = read_two_bytes();
#endif // OB_EEPROM_SUPPORT == 1
}


#if OB_EEPROM_SUPPORT == 1
void init_off_board_string_pointers(struct tHttpD* pSocket) {
  // Initialize the index into the I2C EEPROM Strings region.
  
  // First an error check is run to validate presence of the I2C EEPROM. This
  // check is needed to enable sending a "I2C EEPROM Missing" message to the
  // user should Upgradeable code be inadvertently loaded on a board that has
  // no I2C EEPROM, or if the I2C EEPROM has failed in some way.
  // If no EEPROM is present switch to the EEPROM missing page.
  eeprom_detect = off_board_EEPROM_detect();
  if (eeprom_detect == 0) {
    pSocket->current_webpage = WEBPAGE_EEPROM_MISSING;
    pSocket->pData = g_HtmlPageEEPROMMissing;
    pSocket->nDataLeft = (uint16_t)(sizeof(g_HtmlPageEEPROMMissing) - 1);
    return;
  }
  
  // In order to allow a String File to be read using the same code used for
  // reading Program Files the code expects the Strings file to have SREC
  // addresses starting at 0x8000, however in the I2C EEPROM itself the base
  // address for Strings is 0x0000. This initialization will compensate for
  // that disparity.
  
  // ********************************************************************** //
  if (pSocket->current_webpage == WEBPAGE_IOCONTROL) {

// #if BUILD_SUPPORT == MQTT_BUILD
#if BUILD_SUPPORT == MQTT_BUILD && HOME_ASSISTANT_SUPPORT == 1
    // Prepare to read the two byte string address from I2C EEPROM and
    // convert to uint16_t.
    prep_read(I2C_EEPROM_R2_WRITE, I2C_EEPROM_R2_READ, MQTT_WEBPAGE_IOCONTROL_ADDRESS_LOCATION, 2);
    off_board_eeprom_index = read_two_bytes() - 0x8000;
// #endif // BUILD_SUPPORT == MQTT_BUILD
#endif // BUILD_SUPPORT == MQTT_BUILD && HOME_ASSISTANT_SUPPORT == 1

#if BUILD_SUPPORT == MQTT_BUILD && DOMOTICZ_SUPPORT == 1
    // Prepare to read the two byte string address from I2C EEPROM and
    // convert to uint16_t.
    prep_read(I2C_EEPROM_R2_WRITE, I2C_EEPROM_R2_READ, MQTT_DOMO_WEBPAGE_IOCONTROL_ADDRESS_LOCATION, 2);
    off_board_eeprom_index = read_two_bytes() - 0x8000;
#endif // BUILD_SUPPORT == MQTT_BUILD && DOMOTICZ_SUPPORT == 1

#if BUILD_SUPPORT == BROWSER_ONLY_BUILD
    // Prepare to read the two byte string address from I2C EEPROM and
    // convert to uint16_t.
    prep_read(I2C_EEPROM_R2_WRITE, I2C_EEPROM_R2_READ, BROWSER_ONLY_WEBPAGE_IOCONTROL_ADDRESS_LOCATION, 2);
    off_board_eeprom_index = read_two_bytes() - 0x8000;
#endif // BUILD_SUPPORT == BROWSER_ONLY_BUILD
  }
  
  // ********************************************************************** //
  if (pSocket->current_webpage == WEBPAGE_CONFIGURATION) {
  
#if BUILD_SUPPORT == MQTT_BUILD && HOME_ASSISTANT_SUPPORT == 1
    // Read the two byte string address from I2C EEPROM and
    // convert to uint16_t.
    prep_read(I2C_EEPROM_R2_WRITE, I2C_EEPROM_R2_READ, MQTT_WEBPAGE_CONFIGURATION_ADDRESS_LOCATION, 2);
    off_board_eeprom_index = read_two_bytes() - 0x8000;
#endif // BUILD_SUPPORT == MQTT_BUILD && HOME_ASSISTANT_SUPPORT == 1

#if BUILD_SUPPORT == MQTT_BUILD && DOMOTICZ_SUPPORT == 1
    // Read the two byte string address from I2C EEPROM and
    // convert to uint16_t.
    prep_read(I2C_EEPROM_R2_WRITE, I2C_EEPROM_R2_READ, MQTT_DOMO_WEBPAGE_CONFIGURATION_ADDRESS_LOCATION, 2);
    off_board_eeprom_index = read_two_bytes() - 0x8000;
#endif // BUILD_SUPPORT == MQTT_BUILD && DOMOTICZ_SUPPORT == 1

#if BUILD_SUPPORT == BROWSER_ONLY_BUILD
    // Read the two byte string address from I2C EEPROM and
    // convert to uint16_t.
    prep_read(I2C_EEPROM_R2_WRITE, I2C_EEPROM_R2_READ, BROWSER_ONLY_WEBPAGE_CONFIGURATION_ADDRESS_LOCATION, 2);
    off_board_eeprom_index = read_two_bytes() - 0x8000;
#endif // BUILD_SUPPORT == BROWSER_ONLY_BUILD
  }


#if PCF8574_SUPPORT == 1
#if DOMOTICZ_SUPPORT == 0
  // ********************************************************************** //
  if (pSocket->current_webpage == WEBPAGE_PCF8574_IOCONTROL) {

#if BUILD_SUPPORT == MQTT_BUILD && HOME_ASSISTANT_SUPPORT == 1
    // Read the two byte string address from I2C EEPROM and
    // convert to uint16_t.
    prep_read(I2C_EEPROM_R2_WRITE, I2C_EEPROM_R2_READ, MQTT_WEBPAGE_PCF8574_IOCONTROL_ADDRESS_LOCATION, 2);
    off_board_eeprom_index = read_two_bytes() - 0x8000;
#endif // BUILD_SUPPORT == MQTT_BUILD && HOME_ASSISTANT_SUPPORT == 1

#if BUILD_SUPPORT == BROWSER_ONLY_BUILD
    // Read the two byte string address from I2C EEPROM and
    // convert to uint16_t.
    prep_read(I2C_EEPROM_R2_WRITE, I2C_EEPROM_R2_READ, BROWSER_ONLY_WEBPAGE_PCF8574_IOCONTROL_ADDRESS_LOCATION, 2);
    off_board_eeprom_index = read_two_bytes() - 0x8000;
#endif // BUILD_SUPPORT == BROWSER_ONLY_BUILD
  }
#endif // DOMOTICZ_SUPPORT == 0
#endif // PCF8574_SUPPORT == 1



#if PCF8574_SUPPORT == 1
#if DOMOTICZ_SUPPORT == 0
  // ********************************************************************** //
  if (pSocket->current_webpage == WEBPAGE_PCF8574_CONFIGURATION) {
  
#if BUILD_SUPPORT == MQTT_BUILD
    // Read the two byte string address from I2C EEPROM and
    // convert to uint16_t.
    prep_read(I2C_EEPROM_R2_WRITE, I2C_EEPROM_R2_READ, MQTT_WEBPAGE_PCF8574_CONFIGURATION_ADDRESS_LOCATION, 2);
    off_board_eeprom_index = read_two_bytes() - 0x8000;
#endif // BUILD_SUPPORT == MQTT_BUILD

#if BUILD_SUPPORT == BROWSER_ONLY_BUILD
    // Read the two byte string address from I2C EEPROM and
    // convert to uint16_t.
    prep_read(I2C_EEPROM_R2_WRITE, I2C_EEPROM_R2_READ, BROWSER_ONLY_WEBPAGE_PCF8574_CONFIGURATION_ADDRESS_LOCATION, 2);
    off_board_eeprom_index = read_two_bytes() - 0x8000;
#endif // BUILD_SUPPORT == BROWSER_ONLY_BUILD
  }
#endif // DOMOTICZ_SUPPORT == 0
#endif // PCF8574_SUPPORT == 1



#if LOGIN_SUPPORT == 1
  // ********************************************************************** //
  if (pSocket->current_webpage == WEBPAGE_LOGIN) {  
    // Read the two byte string address from I2C EEPROM and
    // convert to uint16_t.
    prep_read(I2C_EEPROM_R2_WRITE, I2C_EEPROM_R2_READ, WEBPAGE_LOGIN_ADDRESS_LOCATION, 2);
    off_board_eeprom_index = read_two_bytes() - 0x8000;
  }

  if (pSocket->current_webpage == WEBPAGE_SET_PASSPHRASE) {  
    // Read the two byte string address from I2C EEPROM and
    // convert to uint16_t.
    prep_read(I2C_EEPROM_R2_WRITE, I2C_EEPROM_R2_READ, WEBPAGE_SET_PASSPHRASE_ADDRESS_LOCATION, 2);
    off_board_eeprom_index = read_two_bytes() - 0x8000;
  }
#endif // LOGIN_SUPPORT == 1



#if BUILD_SUPPORT == BROWSER_ONLY_BUILD || BUILD_SUPPORT == MQTT_BUILD
  if (pSocket->current_webpage == WEBPAGE_LOADUPLOADER) {
    // Prepare to read the two byte string address from I2C EEPROM and
    // convert to uint16_t.
    prep_read(I2C_EEPROM_R2_WRITE, I2C_EEPROM_R2_READ, WEBPAGE_LOADUPLOADER_ADDRESS_LOCATION, 2);
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


#if DEBUG_SUPPORT == 15
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
  //   MQTT Domo IOControl
  //   MQTT Domo Configuration
  //   Browser Only IOControl
  //   Browser Only Configuration
  //   MQTT PCF8574 IOControl
  //   MQTT PCF8574 Configuration
  //   Browser Only PCF8574 IOControl
  //   Browser Only PCF8574 Configuration
  //   Login
  //   Set Passphrase
  //   LoadUploader

  prep_read(I2C_EEPROM_R2_WRITE, I2C_EEPROM_R2_READ, MQTT_WEBPAGE_IOCONTROL_ADDRESS_LOCATION, 2);
  UARTPrintf("Webpage Address Bytes: ");
  read_httpd_diagnostic_bytes();
  
  prep_read(I2C_EEPROM_R2_WRITE, I2C_EEPROM_R2_READ, MQTT_WEBPAGE_IOCONTROL_SIZE_LOCATION, 2);
  UARTPrintf("Webpage Size Bytes:    ");
  read_httpd_diagnostic_bytes();

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


#if LOGIN_SUPPORT == 1
  UARTPrintf("Login Page Size: ");
  emb_itoa(HtmlPageLogin_size, OctetArray, 16, 4);
  UARTPrintf(OctetArray);
  UARTPrintf("\r\n");


  UARTPrintf("Set Passphrase Page Size: ");
  emb_itoa(HtmlPageSetPassphrase_size, OctetArray, 16, 4);
  UARTPrintf(OctetArray);
  UARTPrintf("\r\n");
#endif // LOGIN_SUPPORT == 1


  UARTPrintf("Load Uploader Page Size: ");
  emb_itoa(HtmlPageLoadUploader_size, OctetArray, 16, 4);
  UARTPrintf(OctetArray);
  UARTPrintf("\r\n");

}
#endif // HTTPD_DIAGNOSTIC_SUPPORT == 1
#endif // OB_EEPROM_SUPPORT == 1
#endif // DEBUG_SUPPORT == 15


#if DEBUG_SUPPORT == 15
#if OB_EEPROM_SUPPORT == 1
#if HTTPD_DIAGNOSTIC_SUPPORT == 1
void read_httpd_diagnostic_bytes(void)
{
  // This function reads 26 bytes from the I2C EEPROM and displays them
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
  temp[8] = I2C_read_byte(1);
  temp[9] = I2C_read_byte(1);
  for (i = 0; i < 10; i++) {
    emb_itoa(temp[i], OctetArray, 16, 2);
    UARTPrintf(OctetArray);
    if ((i == 1) || (i == 3) || (i == 5) || (i == 7) || (i == 9))
      UARTPrintf(" ");
  }
  
  temp[0] = I2C_read_byte(0);
  temp[1] = I2C_read_byte(0);
  temp[2] = I2C_read_byte(0);
  temp[3] = I2C_read_byte(0);
  temp[4] = I2C_read_byte(0);
  temp[5] = I2C_read_byte(1);
  for (i = 0; i < 6; i++) {
    emb_itoa(temp[i], OctetArray, 16, 2);
    UARTPrintf(OctetArray);
    if ((i == 1) || (i == 3) || (i == 5))
      UARTPrintf(" ");
  }
  UARTPrintf("\r\n");
}
#endif // HTTPD_DIAGNOSTIC_SUPPORT == 1
#endif // OB_EEPROM_SUPPORT == 1
#endif // DEBUG_SUPPORT == 15


uint16_t adjust_template_size(struct tHttpD* pSocket)
{
  uint16_t size;
  // declare and pre-calculate repeatedly used values
  int strlen_devicename_adjusted = (strlen(stored_devicename) - 4);
  
  // This function calculates the size of the HTML page that will be
  // transmitted based on the size of the web page template plus adjustments
  // needed to account for text strings that replace markers in the web page
  // template. The purpose of this methodology is to reduce the amount of
  // Flash consumed by the webpages, and it works well for that purpose.
  // Unfortunately it also makes the HTML hard to read and maintain.
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

    // Account for Device Name field %a00 in <title> and in body.
    // This can be variable in size during run time so code has to calculate
    // it each time the webpage is displayed.
    size = size + (2 * strlen_devicename_adjusted);

    // Account for Config string %g00
    // There is 1 instance
    // value_size is 2 (2 characters)
    // size = size + (#instances x (value_size - marker_field_size));
    // size = size + (#instances x (2 - 4));
    // size = size + (1 x (-2));
    size = size - 2;

#if BUILD_SUPPORT == BROWSER_ONLY_BUILD || HOME_ASSISTANT_SUPPORT == 1
    // Account for pin control field %h00
    // size = size + (#instances x (value_size - marker_field_size));
    // size = size + (#instances x (32 - 4));
    // size = size + (1 x 28);
    size = size + 28;
#endif // BUILD_SUPPORT == BROWSER_ONLY_BUILD || HOME_ASSISTANT_SUPPORT == 1

#if DOMOTICZ_SUPPORT == 1
    // Account for pin control field %h00
    // size = size + (#instances x (value_size - marker_field_size));
    // size = size + (#instances x (48 - 4));
    // size = size + (1 x 44);
    size = size + 44;
#endif // DOMOTICZ_SUPPORT == 1

    // Account for Temperature Sensor insertion %t00 to %t04
    // Each of these insertions can have a different length due to the
    // text around them. If DS18B20 is NOT enabled code only needs to
    // subtract the size of the 5 placeholders.
    //
    if (stored_config_settings & 0x08) {
      //  %t00 "<p>Temperature Sensors<br> xxxxxxxxxxxx "
      //      plus 13 bytes of data and degC characters (-000.0&#8451;)
      //      plus 14 bytes of data and degF characters ( -000.0&#8457;)
      //    40 bytes of text plus 27 bytes of data = 67
      //    size = size + 67 - 4
      size = size + 63;

// TRYING TO FIGURE OUT HOW TO GIVE A "HEADER" LOOK TO THE TEMPERATURE SENSORS
// DISPLAY IN IOCONTROL
//      //  %t00 "<p style='{height:32px;}'>Temperature Sensors</p><p><br> xxxxxxxxxxxx "
//      //      plus 13 bytes of data and degC characters (-000.0&#8451;)
//      //      plus 14 bytes of data and degF characters ( -000.0&#8457;)
//      //    69 bytes of text plus 27 bytes of data = 96
//      //    size = size + 96 - 4
//      size = size + 92;
      
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
    // If BME280 is NOT enabled code only needs to subtract the size of the
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
    
#if BUILD_SUPPORT == BROWSER_ONLY_BUILD || HOME_ASSISTANT_SUPPORT == 1
    // String for %y01 in web page template
    // There is 1 instance for the Save and Undo All buttons
    // size = size + (#instances) x (ps[1].size - marker_field_size);
    // size = size + ps[1].size_less4;
    size = size + ps[1].size_less4;
#endif // BUILD_SUPPORT == BROWSER_ONLY_BUILD || HOME_ASSISTANT_SUPPORT == 1

#if DOMOTICZ_SUPPORT == 1
    // String for %y00 in web page template
    // There is 1 instance for the Save and Undo All buttons
    // size = size + (#instances) x (ps[1].size - marker_field_size);
    // size = size + ps[0].size_less4;
    size = size + ps[0].size_less4;
#endif // DOMOTICZ_SUPPORT == 1

#if BUILD_SUPPORT == BROWSER_ONLY_BUILD || HOME_ASSISTANT_SUPPORT == 1
    // String for %y02 in web page template
    // There 3 instances:
    //   Refresh button
    //   Configuration button
    //   PCF8574 IOControl button
    // size = size + (#instances) x (ps[2].size - marker_field_size);
    // size = size + (3 x ps[2].size_less4);
    size = size + (3 * ps[2].size_less4);
#endif // BUILD_SUPPORT == BROWSER_ONLY_BUILD || HOME_ASSISTANT_SUPPORT == 1

#if DOMOTICZ_SUPPORT == 1
    // String for %y02 in web page template
    // There 2 instances:
    //   Refresh button
    //   Configuration button
    // size = size + (#instances) x (ps[2].size - marker_field_size);
    // size = size + (3 x ps[2].size_less4);
    size = size + (2 * ps[2].size_less4);
#endif // DOMOTICZ_SUPPORT == 1

#if BUILD_SUPPORT == BROWSER_ONLY_BUILD
    // Account for IO Name fields %j00 to %j15
    // This can be variable in size during run time so code has to calculate
    // them each time a web page is displayed.
    {
      int i;
      for (i=0; i<16; i++) {
        size = size + (strlen(IO_NAME[i]) - 4);
      }
    }
#endif // BUILD_SUPPORT == BROWSER_ONLY_BUILD

    // The TIMER fields have no size change impact as the value displayed is
    // equal in size to the placeholder.
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
#if DOMOTICZ_SUPPORT == 0
#if PCF8574_SUPPORT == 1
  else if (pSocket->current_webpage == WEBPAGE_PCF8574_IOCONTROL) {
    size = HtmlPagePCFIOControl_size;

    // Account for header replacement strings %y04 %y05
    size = size + ps[4].size_less4
                + ps[5].size_less4;

    // Account for Device Name field %A00 in <title> and in body
    // This can be variable in size during run time so code has to calculate
    // it each time a web page is displayed.
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
    // This can be variable in size during run time so code has to calculate
    // them each time the web page is displayed.
    // For the PCF8574 these names are stored in I2C EEPROM and must be read
    // from there to determine their size.
    {
      int i;
      int j;
      char temp_string[16];
      for (i=16; i<24; i++) {
        // Read a PCF8574_IO_NAMES value from I2C EEPROM
        copy_I2C_EEPROM_bytes_to_RAM(&temp_string[0], 16, I2C_EEPROM_R2_WRITE, I2C_EEPROM_R2_READ, PCF8574_I2C_EEPROM_R2_START_IO_NAMES, 2);
        size = size + (strlen(temp_string) - 4);
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
#endif // DOMOTICZ_SUPPORT == 0
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
    // This can be variable in size during run time so code has to calculate
    // it each time the web page is displayed.
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

#if BUILD_SUPPORT == BROWSER_ONLY_BUILD || HOME_ASSISTANT_SUPPORT == 1
    // Account for pin control field %h00
    // size = size + (#instances x (value_size - marker_field_size));
    // size = size + (#instances x (32 - 4));
    // size = size + (1 x 28);
    size = size + 28;
#endif // BUILD_SUPPORT == BROWSER_ONLY_BUILD || HOME_ASSISTANT_SUPPORT == 1

#if DOMOTICZ_SUPPORT == 1
    // Account for pin control field %h00
    // size = size + (#instances x (value_size - marker_field_size));
    // size = size + (#instances x (48 - 4));
    // size = size + (1 x 44);
    size = size + 44;
#endif // DOMOTICZ_SUPPORT == 1

    // Account for Code Revision + Code Type insertion %w00
    // size = size + (#instances x (value_size - marker_field_size));
    // size = size + (#instances x (36 - 4));
    // size = size + (1 x 32);
    size = size + 32;
    
    // Account for Pinout Option field %w01
    // Looks like "Pinout Option 1" but only the digit is inserted
    // size = size + (#instances x (value_size - marker_field_size));
    // size = size + (#instances x (1 - 4));
    // size = size + (1 x -3);
    size = size - 3;

    // Account for PCF8574 Presence indicator %w02
    // Looks like "PCF8574 0" or "PCF8574 1" but only the digit is inserted
    // size = size + (#instances x (value_size - marker_field_size));
    // size = size + (#instances x (1 - 4));
    // size = size + (1 x -3);
    size = size - 3;

#if BUILD_SUPPORT == BROWSER_ONLY_BUILD || HOME_ASSISTANT_SUPPORT == 1
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
#endif // BUILD_SUPPORT == BROWSER_ONLY_BUILD || HOME_ASSISTANT_SUPPORT == 1

#if DOMOTICZ_SUPPORT == 1
    // Account for Text Replacement insertion
    // Some strings appear frequently in the templates - things like the
    // button titles which appear when hovering over a button. These strings
    // are inserted on the fly when the web page is sent to the browser, so
    // they have to be accounted for in the size of the web page.
    
    // String for %y00 in web page template
    // There is 1 instance for the Save and Undo All buttons
    // size = size + (#instances) x (ps[1].size - marker_field_size);
    // size = size + ps[1].size_less4;
    size = size + ps[0].size_less4;
#endif // DOMOTICZ_SUPPORT == 1

#if BUILD_SUPPORT == BROWSER_ONLY_BUILD
    // String for %y02 in web page templates
    // There are 4 instances:
    //   Reboot button
    //   Refresh button
    //   IOControl button
    //   PCF8574 Configuration button
    //   Login Configuration button
    // size = size + (#instances x (value_size - marker_field_size));
    // size = size + (#instances) x (ps[2].size - 4);
    // size = size + (5) x ps[2].size_less4;
    size = size + (5 * ps[2].size_less4);
#endif // BUILD_SUPPORT == BROWSER_ONLY_BUILD

#if HOME_ASSISTANT_SUPPORT == 1
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
#endif // HOME_ASSISTANT_SUPPORT == 1
    
#if DOMOTICZ_SUPPORT == 1
    // String for %y02 in web page templates
    // There are 3 instances:
    //   Reboot button
    //   Refresh button
    //   IOControl button
    // size = size + (#instances x (value_size - marker_field_size));
    // size = size + (#instances) x (ps[2].size - 4);
    // size = size + (4) x ps[2].size_less4;
    size = size + (3 * ps[2].size_less4);
#endif // DOMOTICZ_SUPPORT == 1

#if BUILD_SUPPORT == BROWSER_ONLY_BUILD
    // Account for IO Timer field %i00 to %i15
    // size = size + (#instances x (value_size - marker_field_size));
    // size = size + (#instances x (4 - 4));
    // size = size + (16 x 0);
    // size = size + 0;
    // The Timer fields have no size change impact
#endif // BUILD_SUPPORT == BROWSER_ONLY_BUILD

#if BUILD_SUPPORT == BROWSER_ONLY_BUILD
    // Account for IO Name fields %j00 to %j15
    // This can be variable in size during run time so code has to calculate
    // them  each time the web page is displayed.
    {
      int i;
      for (i=0; i<16; i++) {
        size = size + (strlen(IO_NAME[i]) - 4);
      }
    }
#endif // BUILD_SUPPORT == BROWSER_ONLY_BUILD

#if DOMOTICZ_SUPPORT == 1
    // Account for IO Name fields %j00 to %j15
    // This can be variable in size during run time so code has to calculate
    // them  each time the web page is displayed.
    {
      int i;
      for (i=0; i<16; i++) {
        size = size + (strlen(IO_NAME[i]) - 4);
      }
    }

#if PCF8574_SUPPORT == 1
    // Account for IO Name fields %j16 to %j23 (repurposed as IDX fields).
    // This can be variable in size during run time so code has to calculate
    // them  each time the web page is displayed.
    // For the PCF8574 these names are stored in I2C EEPROM and must be read
    // from there to determine their size.
    {
      int i;
      int j;
      char temp_string[16];
      for (i=16; i<24; i++) {
        // Read a PCF8574_IO_NAMES value from I2C EEPROM
        copy_I2C_EEPROM_bytes_to_RAM(&temp_string[0], 16, I2C_EEPROM_R2_WRITE, I2C_EEPROM_R2_READ, PCF8574_I2C_EEPROM_R2_START_IO_NAMES, 2);
        size = size + (strlen(temp_string) - 4);
      }
    }
#endif // PCF8574_SUPPORT == 1

#if PCF8574_SUPPORT == 0
    // Account for IO Name fields %j16 to %j23
    // If PCF8574 is not supported the Configuration page will still display
    // the IDX configuration fields, however they will all contain "0".
    // There are 8 instances
    // size = size + (#instances x (value_size - marker_field_size));
    // size = size + (8) x (1 - 4);
    // size = size + (8) x (-3);
    // size = size - 24
    size = size - 24;
#endif // PCF8574_SUPPORT == 0
#endif // DOMOTICZ_SUPPORT == 1

#if DOMOTICZ_SUPPORT == 1
    // Account for Sensor Name fields %T00 to %T05
    // These fields are displayed even if no sensors are present.
    // There are 6 instances, each 12 characters in size.
    // size = size + (#instances x (value_size - marker_field_size));
    // size = size + (6) x (12 - 4);
    // size = size + (6) x (8);
    // size = 48
    size += 48;
#endif // DOMOTICZ_SUPPORT == 1

#if DOMOTICZ_SUPPORT == 1
    // Account for Sensor IDX fields %T20 to %T25
    // These fields are displayed even if no sensors are present.
    // There are 6 instances.
    // This can be variable in size during run time so code has to calculate
    // them  each time the web page is displayed.
    {
      int i;
      for (i=0; i<6; i++) {
        size = size + (strlen(Sensor_IDX[i]) - 4);
      }
    }
#endif // DOMOTICZ_SUPPORT == 1
 
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
    // This can be variable in size during run time so code has to calculate
    // them  each time the web page is displayed.
    size = size + (strlen(stored_mqtt_username) - 4);

    // Account for Password field %m00
    // This can be variable in size during run time so code has to calculate
    // them  each time the web page is displayed.
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
#if BUILD_SUPPORT == BROWSER_ONLY_BUILD || HOME_ASSISTANT_SUPPORT == 1
#if PCF8574_SUPPORT == 1
  else if (pSocket->current_webpage == WEBPAGE_PCF8574_CONFIGURATION) {
    size = HtmlPagePCFConfiguration_size;

    // Account for header replacement strings %y04 %y05
    size = size + ps[4].size_less4
                + ps[5].size_less4;

    // Account for Device Name field %A00 in <title> and in body
    // This can be variable in size during run time so code has to calculate
    // them  each time the web page is displayed.
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
    // This can be variable in size during run time so code has to calculate
    // them  each time the web page is displayed.
    // For the PCF8574 these names are stored in I2C EEPROM and must be read
    // from there to determine their size.
    // Note: Domoticz support re-uses the "%Jxx" values to store IDX values
    // unique to Domoticz.
    {
      int i;
      char temp_string[16];
      for (i=16; i<24; i++) {
        // Read a PCF8574_IO_NAMES value from I2C EEPROM
        copy_I2C_EEPROM_bytes_to_RAM(&temp_string[0], 16, I2C_EEPROM_R2_WRITE, I2C_EEPROM_R2_READ, PCF8574_I2C_EEPROM_R2_START_IO_NAMES, 2);
        size = size + (strlen(temp_string) - 4);
      }
    }
#endif // BUILD_SUPPORT == BROWSER_ONLY_BUILD

#if BUILD_SUPPORT == BROWSER_ONLY_BUILD
    // Account for IO Timer field %I16 to %I23
    // size = size + (#instances x (value_size - marker_field_size));
    // size = size + (#instances x (4 - 4));
    // size = size + (8 x 0);
    // size = size + 0;
    // The Timer fields have no size change impact
#endif // BUILD_SUPPORT == BROWSER_ONLY_BUILD

#if DEBUG_SUPPORT == 15
// UARTPrintf("Adjusted size of WEBPAGE_PCF8574_CONFIGURATION = ");
// emb_itoa(size, OctetArray, 16, 4);
// UARTPrintf(OctetArray);
// UARTPrintf("\r\n");
#endif // DEBUG_SUPPORT == 15

  }
#endif // PCF8574_SUPPORT == 1
#endif // BUILD_SUPPORT == BROWSER_ONLY_BUILD || HOME_ASSISTANT_SUPPORT == 1






  //-------------------------------------------------------------------------//
  //-------------------------------------------------------------------------//
  //-------------------------------------------------------------------------//
  //-------------------------------------------------------------------------//
  // Adjust the size reported by the WEBPAGE_SHORT_TEMPERATURE template
  //-------------------------------------------------------------------------//
  //-------------------------------------------------------------------------//
  //-------------------------------------------------------------------------//
  //-------------------------------------------------------------------------//
#if BUILD_SUPPORT == BROWSER_ONLY_BUILD && SHORT_TEMPERATURE_SUPPORT == 1
  else if (pSocket->current_webpage == WEBPAGE_SHORT_TEMPERATURE) {
    size = (uint16_t)(sizeof(g_HtmlPageShortTemperature) -1);
    // Account for Temperature Sensor insertion %t00 to %t04
    // If DS18B20 is NOT enabled code only needs to subtract the size of the
    // 5 placeholders.
    //
    if (stored_config_settings & 0x08) {
      //  %t00 "xxxxxxxxxxxx"
      //      plus 7 bytes of data (,-000.0)
      //      plus 7 bytes of data (,-000.0)
      //    12 bytes of text plus 14 bytes of data = 26
      //    size = size + 26 - 4
      size = size + 22;
      //
      //  %t01 ",xxxxxxxxxxxx"
      //      plus 7 bytes of data (,-000.0)
      //      plus 7 bytes of data (,-000.0)
      //    13 bytes of text plus 14 bytes of data = 27
      //    size = size + 27 - 4
      size = size + 23;
      //
      //  %t02 ",xxxxxxxxxxxx"
      //      plus 7 bytes of data (,-000.0)
      //      plus 7 bytes of data (,-000.0)
      //    13 bytes of text plus 14 bytes of data = 27
      //    size = size + 27 - 4
      size = size + 23;
      //
      //  %t03 ",xxxxxxxxxxxx"
      //      plus 7 bytes of data (,-000.0)
      //      plus 7 bytes of data (,-000.0)
      //    13 bytes of text plus 14 bytes of data = 27
      //    size = size + 27 - 4
      size = size + 23;
      //
      //  %t04 ",xxxxxxxxxxxx"
      //      plus 7 bytes of data (,-000.0)
      //      plus 7 bytes of data (,-000.0)
      //    13 bytes of text plus 14 bytes of data = 27
      //    size = size + 27 - 4
      size = size + 23;
    }
    else {
      // Subtract the size of the placeholders as they won't be used
      // size = size - (5 x 4)
      size = size - 20;
    }
  }
#endif // BUILD_SUPPORT == BROWSER_ONLY_BUILD && SHORT_TEMPERATURE_SUPPORT == 1







  //-------------------------------------------------------------------------//
  //-------------------------------------------------------------------------//
  //-------------------------------------------------------------------------//
  //-------------------------------------------------------------------------//
  // Adjust the size reported by the WEBPAGE_LOGIN template
  //-------------------------------------------------------------------------//
  //-------------------------------------------------------------------------//
  //-------------------------------------------------------------------------//
  //-------------------------------------------------------------------------//
#if LOGIN_SUPPORT == 1
  else if (pSocket->current_webpage == WEBPAGE_LOGIN) {
//    size = (uint16_t)(sizeof(g_HtmlPageLogin) - 1);
    size = HtmlPageLogin_size;

    // Account for header replacement strings %y04 %y05
    size = size + ps[4].size_less4
                + ps[5].size_less4;

    // Account for Passphrase field %l02
    // This field is always empty when sent to the Browser so the placeholder
    // has no effect on size.
  }
#endif // LOGIN_SUPPORT == 1


  //-------------------------------------------------------------------------//
  //-------------------------------------------------------------------------//
  //-------------------------------------------------------------------------//
  //-------------------------------------------------------------------------//
  // Adjust the size reported by the WEBPAGE_SET_PASSPHRASE template
  //-------------------------------------------------------------------------//
  //-------------------------------------------------------------------------//
  //-------------------------------------------------------------------------//
  //-------------------------------------------------------------------------//
#if LOGIN_SUPPORT == 1
  else if (pSocket->current_webpage == WEBPAGE_SET_PASSPHRASE) {
//    size = (uint16_t)(sizeof(g_HtmlPageSetPassphrase) - 1);
    size = HtmlPageSetPassphrase_size;

    // Account for header replacement strings %y04 %y05
    size = size + ps[4].size_less4
                + ps[5].size_less4;

    // Account for Passphrase field %l01
    // This can be variable in size during run time so code has to calculate
    // them  each time the web page is displayed.
    // The Passphrase is stored in I2C EEPROM and must be read from there to
    // determine the size.
    {
      int i;
      char temp_string[16];
      // Read the Passphrase I2C EEPROM
      copy_I2C_EEPROM_bytes_to_RAM(&temp_string[0], 16, I2C_EEPROM_R1_WRITE, I2C_EEPROM_R1_READ, I2C_EEPROM_R1_LOGIN_PASSPHRASE, 2);
      size = size + (strlen(temp_string) - 4);
    }
  }
#endif // LOGIN_SUPPORT == 1


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
#if NETWORK_STATISTICS == 1 && BUILD_SUPPORT == BROWSER_ONLY_BUILD
  else if (pSocket->current_webpage == WEBPAGE_STATS1) {
    size = (uint16_t)(sizeof(g_HtmlPageStats1) - 1);

    // Account for header replacement strings %y04 %y05
    size = size + ps[4].size_less4
                + ps[5].size_less4;

    // Account for Device Name field %a00 in <title>
    // This can be variable in size during run time so code has to calculate
    // them  each time the web page is displayed.
    size = size + strlen_devicename_adjusted;
    
    // Account for Statistics fields %e00 to %e21
    // There are 22 instances of these fields
    // size = size + (#instances x (value_size - marker_field_size));
    // size = size + (22 x (10 - 4));
    // size = size + (22 x (6));
    size = size + 132;
  }
#endif // NETWORK_STATISTICS == 1 && BUILD_SUPPORT == BROWSER_ONLY_BUILD


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
#if LINK_STATISTICS == 1
  else if (pSocket->current_webpage == WEBPAGE_STATS2) {
    size = (uint16_t)(sizeof(g_HtmlPageStats2) - 1);
    // Account for Statistics fields %e31, %e32, %e33, %e34, %e35
    // There are 5 instances of these fields
    // size = size + (#instances x (value_size - marker_field_size));
    // size = size + (5 x (10 - 4));
    // size = size + (5 x (6));
    size = size + 30;
  }
#endif // LINK_STATISTICS == 1


  //-------------------------------------------------------------------------//
  //-------------------------------------------------------------------------//
  //-------------------------------------------------------------------------//
  //-------------------------------------------------------------------------//
  // Adjust the size reported by the WEBPAGE_RF_ATTEN template (special RF
  // Attenuator page)
  //-------------------------------------------------------------------------//
  //-------------------------------------------------------------------------//
  //-------------------------------------------------------------------------//
  //-------------------------------------------------------------------------//
#if RF_ATTEN_SUPPORT == 1
  else if (pSocket->current_webpage == WEBPAGE_RF_ATTEN) {
    size = (uint16_t)(sizeof(g_HtmlPageRFAtten) - 1);

    // Account for header replacement strings %y04 %y05
    size = size + ps[4].size_less4
                + ps[5].size_less4;

    // Account for Device Name field %a00
    // This can be variable in size during run time so code has to calculate
    // them  each time the web page is displayed.
    size = size + strlen_devicename_adjusted;

    // Account for Current Decibel setting string %f01
    // There is 1 instance of this field
    // size = size + (#instances x (value_size - marker_field_size));
    // size = size + (1 x (2 - 4));
    // size = size + (1 x -2);
    size = size - 2;

    // Account for button strings %y06
    // There are 32 instances of these fields
    // <button onclick='location=`/51003f00     (36 bytes)
    // size = size + (#instances x (value_size - marker_field_size));
    // size = size + (32 x (36 - 4));
    // size = size + (32 x (32));
    size = size + 1024;

    // Account for button strings %y07
    // There are 32 instances of these fields
    // </button>&emsp;&ensp;      (21 bytes)
    // size = size + (#instances x (value_size - marker_field_size));
    // size = size + (32 x (21 - 4));
    // size = size + (32 x (17));
    size = size + 544;
  }
#endif // RF_ATTEN_SUPPORT == 1


  //-------------------------------------------------------------------------//
  //-------------------------------------------------------------------------//
  //-------------------------------------------------------------------------//
  //-------------------------------------------------------------------------//
  // Adjust the size reported by the WEBPAGE_SDR_POWER_RELAY template (special
  // SDR Power Relay page)
  //-------------------------------------------------------------------------//
  //-------------------------------------------------------------------------//
  //-------------------------------------------------------------------------//
  //-------------------------------------------------------------------------//
#if SDR_POWER_RELAY_SUPPORT == 1
  else if (pSocket->current_webpage == WEBPAGE_SDR_POWER_RELAY) {
    size = (uint16_t)(sizeof(g_HtmlPageSDRPowerRelay) - 1);

    // Account for header replacement strings %y04 %y05
    size = size + ps[4].size_less4
                + ps[5].size_less4;

    // Account for Device Name field %a00
    // This can be variable in size during run time so code has to calculate
    // them  each time the web page is displayed.
    size = size + strlen_devicename_adjusted;

    // Account for Green / Red relay status field %n10 to %n17
    // There are 8 instances of this field
    // size = size + (#instances x (value_size - marker_field_size));
    // size = size + (8 x (3 - 4));
    // size = size + (8 x -1);
    size = size - 8;
    
    // Account for IO Name fields %j00, %j02, %j04, %j06, %j08, %j10, %j12, %j14
    // This can be variable in size during run time so code has to calculate
    // them  each time the web page is displayed.
    {
      int i;
      for (i=0; i<16; i += 2) {
        size = size + (strlen(IO_NAME[i]) - 4);
      }
    }
  }
#endif // SDR_POWER_RELAY_SUPPORT == 1


  //-------------------------------------------------------------------------//
  //-------------------------------------------------------------------------//
  //-------------------------------------------------------------------------//
  //-------------------------------------------------------------------------//
  // Adjust the size reported by the WEBPAGE_INA226 template (special Current,
  // Voltage, Wattage page)
  //-------------------------------------------------------------------------//
  //-------------------------------------------------------------------------//
  //-------------------------------------------------------------------------//
  //-------------------------------------------------------------------------//
#if INA226_SUPPORT == 1
  else if (pSocket->current_webpage == WEBPAGE_INA226) {
    size = (uint16_t)(sizeof(g_HtmlPageINA226) - 1);

    // Account for Device Name field %a00
    // This can be variable in size during run time so code has to calculate
    // them  each time the web page is displayed.
    size = size + strlen_devicename_adjusted;

    // Account for header replacement strings %y04 %y05
    size = size + ps[4].size_less4
                + ps[5].size_less4;

    // Account for Current, Voltage, Wattage string %t06
    // There are 5 instances of this field
    // size = size + (#instances x (value_size - marker_field_size));
    // size = size + (5 x (63 - 4));
    // size = size + (5 x 59);
    size = size + 295;
  }
#endif // INA226_SUPPORT == 1


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
    // This can be variable in size during run time so code has to calculate
    // them  each time the web page is displayed.
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
    // size = size + (#instances x (36 - 4));
    // size = size + (1 x 32);
    size = size + 32;
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


/*
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
*/


uint8_t int2nibble(uint8_t j)
{
  // Convert a 4 bit integer to a character (a single nibble).
  if(j<=9) return (uint8_t)(j + '0');
  else return (uint8_t)(j - 10 + 'a');
}


static uint16_t CopyHttpHeader(uint8_t* pBuffer, uint16_t nDataLen, uint8_t header_type)
{
  uint16_t nBytes;
  int i;
  
  static const char http_string1[] = 
    "\r\n"
    "Cache-Control: no-cache, no-store\r\n"
    "Content-Type: text/html; charset=utf-8\r\n";

  nBytes = 0;
  
  pBuffer = stpcpy(pBuffer, "HTTP/1.1 ");
  nBytes += 9;

  if (header_type == HEADER200) {
    pBuffer = stpcpy(pBuffer, "200 OK\r\n");
    nBytes += 8;
  }
//  if (header_type == HEADER204) {
//    pBuffer = stpcpy(pBuffer, "204 No Content\r\n");
//    nBytes += 16;
//  }
  if (header_type == HEADER429) {
    pBuffer = stpcpy(pBuffer, "429 Too Many Requests\r\n");
    nBytes += 23;
  }

  pBuffer = stpcpy(pBuffer, "Content-Length:");
  nBytes += 15;

  // This creates the "xxxxx" part of a 5 character "Content-Length:xxxxx"
  // field in the pBuffer.
  emb_itoa(nDataLen, OctetArray, 10, 5);
  pBuffer = stpcpy(pBuffer, OctetArray);
  nBytes += 5;

  pBuffer = stpcpy(pBuffer, http_string1);
  nBytes += strlen(http_string1);
  
  if (header_type == HEADER429) {
    pBuffer = stpcpy(pBuffer, "Retry-After: 10\r\n");
    nBytes += 17;
  }
  
  pBuffer = stpcpy(pBuffer, "Connection:close\r\n\r\n");
  nBytes += 20;
  
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

#if OB_EEPROM_SUPPORT == 1 && DS18B20_SUPPORT == 1
// FoundROM is located in I2C EEPROM if I2C EEPROM is supported. So it is
// copied to a local stack based FoundROM array for use in this case.
uint8_t FoundROM[5][8];             // Table of ROM codes
                                    // [x][0] = Family Code
                                    // [x][1] = LSByte serial number
                                    // [x][2] = byte 2 serial number
                                    // [x][3] = byte 3 serial number
                                    // [x][4] = byte 4 serial number
                                    // [x][5] = byte 5 serial number
                                    // [x][6] = MSByte serial number
                                    // [x][7] = CRC
#endif // OB_EEPROM_SUPPORT == 1 && DS18B20_SUPPORT == 1

      
#if OB_EEPROM_SUPPORT == 1 && DS18B20_SUPPORT == 1
      // If I2C EEPROM is supported then the FoundROM table is stored in the
      // I2C EEPROM and must be copied to a stack based RAM location for use
      // here. The I2C EEPROM copy of the FoundROM table starts at
      // I2C_EEPROM_R1_FOUNDROM. There are 5 entries, each 8 bytes long, for
      // a total of 40 bytes.
  copy_I2C_EEPROM_bytes_to_RAM(&FoundROM[0][0], 40, I2C_EEPROM_R1_WRITE, I2C_EEPROM_R1_READ, I2C_EEPROM_R1_FOUNDROM, 2);
#endif // OB_EEPROM_SUPPORT == 1 && DS18B20_SUPPORT == 1

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
  // is the critical direction because there is limited memory to store
  // incoming packets ... and it is OK to transmit less than the MSS that a
  // remote host tells us it can receive. The problem that this causes is that
  // as code reduces the value of MSS for receive, it also reduces the size of
  // MSS for transmit, and that causes the web page transmission to take a
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
  // the largest string insertion that is NOT a %yxx replacement (as %yxx
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
#if DOMOTICZ_SUPPORT == 0
   || pSocket->current_webpage == WEBPAGE_PCF8574_IOCONTROL
   || pSocket->current_webpage == WEBPAGE_PCF8574_CONFIGURATION
#endif // DOMOTICZ_SUPPORT == 0
#endif // PCF8574_SUPPORT == 1
#if LOGIN_SUPPORT == 1
   || pSocket->current_webpage == WEBPAGE_LOGIN
   || pSocket->current_webpage == WEBPAGE_SET_PASSPHRASE
#endif // LOGIN_SUPPORT == 1
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
    //  - "off_board_eeprom_index" is a global value that was filled in prior
    //    to the call to CopyHttpData() by the init_off_board_string_pointers()
    //    function (which was called when determining which page to display).
    
    copy_I2C_EEPROM_bytes_to_RAM(&pre_buf[0], PRE_BUF_SIZE, I2C_EEPROM_R2_WRITE, I2C_EEPROM_R2_READ, off_board_eeprom_index, 2);
    pre_buf_ptr = 0;
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
#if DOMOTICZ_SUPPORT == 0
         || pSocket->current_webpage == WEBPAGE_PCF8574_IOCONTROL
	 || pSocket->current_webpage == WEBPAGE_PCF8574_CONFIGURATION
#endif // DOMOTICZ_SUPPORT == 0
#endif // PCF8574_SUPPORT == 1
#if LOGIN_SUPPORT == 1
         || pSocket->current_webpage == WEBPAGE_LOGIN
         || pSocket->current_webpage == WEBPAGE_SET_PASSPHRASE
#endif // LOGIN_SUPPORT == 1
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
	    // the buffer before we reach the end of the buffer. Since we are
	    // reloading from the current point in the I2C EEPROM (pointed to by
	    // off_board_eeprom_index) no remaining data in the pre_buf is lost.
            if (pre_buf_ptr > (PRE_BUF_SIZE - 6)) {
              copy_I2C_EEPROM_bytes_to_RAM(&pre_buf[0], PRE_BUF_SIZE, I2C_EEPROM_R2_WRITE, I2C_EEPROM_R2_READ, off_board_eeprom_index, 2);
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
	//        00 - IO states of all 16 pins
	//        01 - IO6 to IO2 converted to a decimal value (for the
	//             RF Attenuator application).
        // %g - "Config" string to control BME280 Enable, Disable Cfg Button,
	//      DS18B20 Enable, MQTT Enable, Full/Half Duplex, and Home
	//      Assistant Auto Discovery Enable. Input and Output.
	// %h - Pin Control string - The pin control string is defined as 32
	//      characters representing 16 hex bytes of information in text
	//      format. Each byte is the pin_control byte for each IO pin.
	//      Input and Output.
	// %H - Pin Control string for PCF8574 - The pin control string is
	//      defined as 16 characters representing 16 hex bytes of
	//      information in text format. Each byte is the pin_control
	//      character for each PCF8574 IO pin. Input and Output.
	// %i - IO Timer values
	// %j - IO Names
	// %I - IO Timer values for PCF8574 device
	// %J - IO Names for PCF8574 device
        // %l - Username strings
	//        00 - MQTT Username - This is a user entered text field with
	//             a Username. Used in MQTT communication. Input and
	//             output.
	//        01 - Login Passphrase - This is a user entered text
	//             field with a Login Passphrase. Used to log into the
	//             Network Module. Input and output.
        // %m - Password strings
	//        00 - MQTT Password - This is a user entered text field with
	//             a Password. Used in MQTT communication. Input and
	//             output.
	//        01 - Login Password - This is a user entered text field with
	//             a Password. Used to log into the Network Module. Input
	//             and output.
        // %n - MQTT Status or Latching Relay Status
	//      00 to 04 - Displays red or green boxes to indicate MQTT
	//        startup status (Connection Available, ARP OK, TCP OK,
	//        Connect OK, MQTT_OK). Output only.
	//      10 to 17 - Displays red or green boxes to indicate the
	//        last known ON / OFF status of latching relays. Applies
	//        only to special Software Defined Radio builds.
	// %s - Code Uploader failure codes. Output only.
	// %t - I2C Sensor data
	//        00 - DS18B20 Temperature Sensor 1 data. Output only.
	//        01 - DS18B20 Temperature Sensor 2 data. Output only.
	//        02 - DS18B20 Temperature Sensor 3 data. Output only.
	//        03 - DS18B20 Temperature Sensor 4 data. Output only.
	//        04 - DS18B20 Temperature Sensor 5 data. Output only.
	//        05 - BME280 Temperature, Humidity, Pressure sensor data. Output only.
	//        06 - INA226 Sensor 1 Current, Voltage, Wattage sensor data. Output only.
	//        07 - INA226 Sensor 2 Current, Voltage, Wattage sensor data. Output only.
	//        08 - INA226 Sensor 3 Current, Voltage, Wattage sensor data. Output only.
	//        09 - INA226 Sensor 4 Current, Voltage, Wattage sensor data. Output only.
	//        10 - INA226 Sensor 5 Current, Voltage, Wattage sensor data. Output only.
	//        20 - DS18B20 Temperature Sensor 1 short form data. Output only.
	//        21 - DS18B20 Temperature Sensor 2 short form data. Output only.
	//        22 - DS18B20 Temperature Sensor 3 short form data. Output only.
	//        23 - DS18B20 Temperature Sensor 4 short form data. Output only.
	//        24 - DS18B20 Temperature Sensor 5 short form data. Output only.
	// %T - I2C Sensor Serial Number and IDX (IDX used in Domoticz builds only).
	//        00 - DS18B20 Sensor 1 Serial Number (MAC)
	//        01 - DS18B20 Sensor 2 Serial Number (MAC)
	//        02 - DS18B20 Sensor 3 Serial Number (MAC)
	//        03 - DS18B20 Sensor 4 Serial Number (MAC)
	//        04 - DS18B20 Sensor 5 Serial Number (MAC)
	//        05 - BME280 Sensor Serial Number (Just reports "BME280"))
	//        20 - DS18B20 Sensor 1 IDX value (user supplied)
	//        21 - DS18B20 Sensor 2 IDX value (user supplied)
	//        22 - DS18B20 Sensor 3 IDX value (user supplied)
	//        23 - DS18B20 Sensor 4 IDX value (user supplied)
	//        24 - DS18B20 Sensor 5 IDX value (user supplied)
	//        25 - BME280 Sensor IDX value (user supplied)
	// %w - General purpose output strings:
	//        00 - Code Revision
	//        01 - Pinout Option
	//        02 - PCF8574 Presence
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
#if DOMOTICZ_SUPPORT == 0
           || pSocket->current_webpage == WEBPAGE_PCF8574_IOCONTROL
	   || pSocket->current_webpage == WEBPAGE_PCF8574_CONFIGURATION
#endif // DOMOTICZ_SUPPORT == 0
#endif // PCF8574_SUPPORT == 1
#if LOGIN_SUPPORT == 1
           || pSocket->current_webpage == WEBPAGE_LOGIN
           || pSocket->current_webpage == WEBPAGE_SET_PASSPHRASE
#endif // LOGIN_SUPPORT == 1
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
#if DOMOTICZ_SUPPORT == 0
           || pSocket->current_webpage == WEBPAGE_PCF8574_IOCONTROL
	   || pSocket->current_webpage == WEBPAGE_PCF8574_CONFIGURATION
#endif // DOMOTICZ_SUPPORT == 0
#endif // PCF8574_SUPPORT == 1
#if LOGIN_SUPPORT == 1
           || pSocket->current_webpage == WEBPAGE_LOGIN
           || pSocket->current_webpage == WEBPAGE_SET_PASSPHRASE
#endif // LOGIN_SUPPORT == 1
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
#if DOMOTICZ_SUPPORT == 0
           || pSocket->current_webpage == WEBPAGE_PCF8574_IOCONTROL
	   || pSocket->current_webpage == WEBPAGE_PCF8574_CONFIGURATION
#endif // DOMOTICZ_SUPPORT == 0
#endif // PCF8574_SUPPORT == 1
#if LOGIN_SUPPORT == 1
           || pSocket->current_webpage == WEBPAGE_LOGIN
           || pSocket->current_webpage == WEBPAGE_SET_PASSPHRASE
#endif // LOGIN_SUPPORT == 1
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
#if DOMOTICZ_SUPPORT == 0
           || pSocket->current_webpage == WEBPAGE_PCF8574_IOCONTROL
	   || pSocket->current_webpage == WEBPAGE_PCF8574_CONFIGURATION
#endif // DOMOTICZ_SUPPORT == 0
#endif // PCF8574_SUPPORT == 1
#if LOGIN_SUPPORT == 1
           || pSocket->current_webpage == WEBPAGE_LOGIN
           || pSocket->current_webpage == WEBPAGE_SET_PASSPHRASE
#endif // LOGIN_SUPPORT == 1
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
	  // %axx %Axx
          pBuffer = stpcpy(pBuffer, stored_devicename);
	}

	
        else if (nParsedMode == 'b') {
	  // This displays the IP Address, Gateway Address, and Netmask information.
	  // We need to get the 32 bit values for IP Address, Gateway Address, and
	  // Netmask and send them as text strings of hex characters (8 characters
	  // for a 32 bit number, for example "c0a80004").
	  // %bxx
	  {
	    uint32_t temp32;
	    uip_ipaddr_t *uip_ptr = NULL;
	    
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
	  // %cxx

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
	  // %dxx
          pBuffer = stpcpy(pBuffer, mac_string);
	}
	

#if NETWORK_STATISTICS == 1 && BUILD_SUPPORT == BROWSER_ONLY_BUILD
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
	  // %exx
	  
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
#endif // NETWORK_STATISTICS == 1 && BUILD_SUPPORT == BROWSER_ONLY_BUILD


#if LINK_STATISTICS == 1
//        else if ((nParsedMode == 'e') && (nParsedNum >= 30) && (nParsedNum < 40)) {
        else if (nParsedMode == 'e') {
	  // This displays the Link Error Statistics
	  // %exx
	  // This code is surprisingly large (about 284 bytes)
	  //   One call to stpcpy is 7 bytes (8) = 56
          //   One call to emb_itoa is 15 bytes (2) = 30
          //   One call to int2hex is 6 bytes (5) = 30
          //   Each for loop cost 58 bytes (2) = 116
	  //   Plus another 50 bytes in the if / else if statements
	  // Not sure what can be applied here to reduce code size
	  {
	    int i;
	    i = 0;
            if (nParsedNum == 31) {
	      // Display Seconds Counter
	      emb_itoa(second_counter, OctetArray, 10, 10);
              pBuffer = stpcpy(pBuffer, OctetArray);
	    }
            else if (nParsedNum == 32) {
	      // Display Transmit Counter
	      emb_itoa(TRANSMIT_counter, OctetArray, 10, 10);
              pBuffer = stpcpy(pBuffer, OctetArray);
	    }
            else if (nParsedNum == 33) {
	      // Display Stack Overflow Error, ENC28J60 revision, TXERIF Error
	      // Count and RXERIF Error Count
	      for (i=0; i<5; i++) {
                int2hex(stored_debug_bytes[i]);
                pBuffer = stpcpy(pBuffer, OctetArray);
	      }
	    }
            else if (nParsedNum == 34) {
	      for (i=5; i<10; i++) {
	        // Display EMCF, SWIMF, ILLOPF,IWDGF and WWDGF Counters
                int2hex(stored_debug_bytes[i]);
                pBuffer = stpcpy(pBuffer, OctetArray);
	      }
	    }
            else if (nParsedNum == 35) {
	      // Display MQTT Response Timeout, MQTT Not OK Count, and MQTT
	      // Broker Disconnect Count
              pBuffer = stpcpy(pBuffer, "0000");
              int2hex(MQTT_resp_tout_counter);
              pBuffer = stpcpy(pBuffer, OctetArray);
              int2hex(MQTT_not_OK_counter);
              pBuffer = stpcpy(pBuffer, OctetArray);
              int2hex(MQTT_broker_dis_counter);
              pBuffer = stpcpy(pBuffer, OctetArray);
	    }
	  }
	}
#endif // LINK_STATISTICS == 1


#if DEBUG_SENSOR_SERIAL == 1
        else if ((nParsedMode == 'e') && (nParsedNum >= 40)) {
	  // This is for diagnostic use only and is NOT normally enabled
	  // in the compile options. This displays the Temperature Sensor
	  // Serial Numbers and was made necessary due to some suppliers
	  // providing DS18B20 devices with identical serial numbers.
	  // %exx
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


        else if ((nParsedMode == 'f') && (nParsedNum == 0)) {
	  // Display the pin state information in the format used by the "98"
	  // and "99" command. "99" is the command used in the original
	  // Network Module.
	  // For output pins display the state in the pin_control byte.
	  // For input pins if the Invert bit is set the ON_OFF state needs to
	  // be inverted before displaying.
	  // Bits are output for Pin 16 first and Pin 1 last
	  // If PCF8574 is implemented bits are output for Pin 24 first and
	  // Pin 1 last, UNLESS no PCF8574 device is present in which case Pin
	  // 16 first.
	  // If stored_options1 bit 0x10 is set then any Disabled pin must be
	  // shown as '-'. Otherwise the last known pin state is displayed.
	  // %fxx

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
	

#if RF_ATTEN_SUPPORT == 1
        else if ((nParsedMode == 'f') && (nParsedNum == 1)) {
	  // This is a special case utilized only for the RF Attenuator
	  // special build. This will display IO bits 6 to 2 (5 bits) as a
	  // decimal number.
	  // %fxx
	  {
	    uint16_t pinstates;
	    pinstates = (uint16_t)ON_OFF_word;
	    pinstates = pinstates & 0x003f;
	    pinstates = pinstates >> 1;
	    emb_itoa(pinstates, OctetArray, 10, 2);
	    pBuffer = stpcpy(pBuffer, OctetArray);
	  }
	}
#endif // RF_ATTEN_SUPPORT == 1
	

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
	  // %gxx
	  
	  // Convert Config settngs byte into two hex characters
          int2hex(stored_config_settings);
	  pBuffer = stpcpy(pBuffer, OctetArray);
	}
	
	
#if LINKED_SUPPORT == 0
#if BUILD_SUPPORT == BROWSER_ONLY_BUILD || HOME_ASSISTANT_SUPPORT == 1
        else if (nParsedMode == 'h') {
	  // This sends the Pin Control String for non-Domoticz builds,
	  // defined as follows:
	  // 32 characters
	  // The 32 characters represent 16 hex bytes of information in text
	  // format. Each byte is the pin_control byte for each IO pin 
	  // starting with pin 01 on the left.
	  // Just a reminder: The code calls the first pin "00", but the GUI
	  // shows it as Pin 1.
	  // Note: Input pins need to have the ON/OFF bit inverted if the
	  //   Invert bit is set.
	  // %hxx
	  
	  // Insert pin_control bytes
	  {
	    int i;
	    uint8_t j;
	    for (i = 0; i <16; i++) {
	      j = pin_control[i];
	      if ((j & 0x03) == 0x01) {
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
	  // and IOControl pages (note: these separate pages are not part of
	  // the Domoticz builds).
	  // String is defined as follows:
	  // 16 characters
	  // The 16 characters represent 8 hex bytes of information in text
	  // format. Each byte is the pin_control character for each IO
	  // starting with IO 17 on the left.
	  // Note: Input pins need to have the ON/OFF bit inverted if the
	  //   Invert bit is set.
	  // %Hxx
	  
	  // Insert pin_control bytes
	  {
	    int i;
	    uint8_t j;
	    for (i = 16; i <24; i++) {
	      j = pin_control[i];
	      if ((stored_options1 & 0x08) == 0x00) {
	        // Checking stored_options1 verifies that a PCF8574 is
	        // attached. If not attached show pin as disabled but
	        // leave other settings alone. Issue #177
	        j &= 0xfc; // Show pin as disabled
	      }
	      if ((j & 0x03) == 0x01) {
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
#endif // BUILD_SUPPORT == BROWSER_ONLY_BUILD || HOME_ASSISTANT_SUPPORT == 1

#if DOMOTICZ_SUPPORT == 1
        else if (nParsedMode == 'h') {
	  // This sends the Pin Control String for Domoticz builds, defined as
	  // follows:
	  // 48 characters
	  // The 48 characters represent 24 hex bytes of information in text
	  // format. Each byte is the pin_control character for each IO pin
	  // starting with pin 01 on the left.
	  // Just a reminder: The code calls the first pin "00", but the GUI
	  // shows it as Pin 1.
	  // Note: Input pins need to have the ON/OFF bit inverted if the
	  //   Invert bit is set.
	  // %hxx
	  
	  // Insert pin_control bytes
	  {
	    int i;
	    uint8_t j;

            j = 0;
	    
	    for (i = 0; i <24; i++) {
#if PCF8574_SUPPORT == 1
	      j = pin_control[i];
#endif // PCF8574_SUPPORT == 1
#if PCF8574_SUPPORT == 0
              if (i < 16) {
	        j = pin_control[i];
	      }
              if (i > 15) {
	        // No PCF8574
		j = 0;
	      }
#endif // PCF8574_SUPPORT == 0
              if (j != 0) {
	        if ((i > 15) && ((stored_options1 & 0x08) == 0x00)) {
	          // Checking stored_options1 verifies that a PCF8574 is
	          // attached. If not attached show pin as disabled but
	          // leave other settings alone. Issue #177
	          j &= 0xfc; // Show pin as disabled
	        }
	        if ((j & 0x03) == 0x01) {
	          // This is an input pin - check the invert bit
	          if (j & 0x04) { // Invert is set - flip the ON/OFF bit
		    if (j & 0x80) j &= 0x7f;
		    else j |= 0x80;
		  }
	        }
	      }
	      int2hex(j);
	      pBuffer = stpcpy(pBuffer, OctetArray);
            }
	  }
	}
#endif // DOMOTICZ_SUPPORT == 1
#endif // LINKED_SUPPORT == 0


#if LINKED_SUPPORT == 1
#if BUILD_SUPPORT == BROWSER_ONLY_BUILD || HOME_ASSISTANT_SUPPORT == 1
        else if (nParsedMode == 'h') {
	  // This sends the Pin Control String for non-Domoticz builds,
	  // defined as follows:
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
	  // %hxx
          
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
	  // and IOControl pages (note: these separate pages are not part of
	  // the Domoticz builds).
	  // The string is defined as follows:
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
	  // %Hxx
          
	  // Insert pin_control bytes
	  {
	    int i;
	    uint8_t j;
	    for (i = 16; i <24; i++) {
	      j = pin_control[i];
	      if ((stored_options1 & 0x08) == 0x00) {
	        // Checking stored_options1 verifies that a PCF8574 is
	        // attached. If not attached show pin as disabled but
	        // leave other settings alone. Issue #177
	        j &= 0xfc; // Show pin as disabled
	      }
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
#endif // BUILD_SUPPORT == BROWSER_ONLY_BUILD || HOME_ASSISTANT_SUPPORT == 1

#if DOMOTICZ_SUPPORT == 1
        else if (nParsedMode == 'h') {
	  // This sends the Pin Control String for Domoticz builds,
	  // defined as follows:
	  // 48 characters
	  // The 48 characters represent 24 hex bytes of information in text
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
	  // Note 4: If PCF8574 is not supported the hxx values for pins 16 to
	  //   24 need to be transmitted as 0x00 (disabled). This is to cover
	  //   the case where a build that does not include PCF8574 is
	  //   programmed into the device AFTER a build that did support
	  //   PCF8574.
	  // %hxx
          
	  // Insert pin_control bytes
	  {
	    int i;
	    uint8_t j;
	    j = 0;
	    
	    for (i = 0; i <24; i++) {
#if PCF8574_SUPPORT == 1
	      j = pin_control[i];
#endif // PCF8574_SUPPORT == 1
#if PCF8574_SUPPORT == 0
              if (i < 16) {
	        j = pin_control[i];
	      }
              if (i > 15) {
	        // No PCF8574
		j = 0;
	      }
#endif // PCF8574_SUPPORT == 0
              if (j != 0) {
	        // If pin is not disabled check it for input/output
	        if (pSocket->current_webpage == WEBPAGE_IOCONTROL) {
	          if ((i > 15) && ((stored_options1 & 0x08) == 0x00)) {
	            // Checking stored_options1 verifies that a PCF8574 is
	            // attached. If not attached show pin as disabled but
	            // leave other settings alone. Issue #177
	            j &= 0xfc; // Show pin as disabled
	          }
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
	      }
	      int2hex(j);
	      pBuffer = stpcpy(pBuffer, OctetArray);
            }
	  }
	}
#endif // DOMOTICZ_SUPPORT == 1

#endif // LINKED_SUPPORT == 1


#if BUILD_SUPPORT == BROWSER_ONLY_BUILD
        else if (nParsedMode == 'i') {
	  // This sends the IO 1 to 16 IO Timer units and IO Timer values to
	  // the Browser Configuration page.
	  // Defined as follows:
	  // 2 bytes represented as hex encoded strings (4 nibbles)
	  // Upper 2 bits are units
	  // Lower 14 bits are value
	  // %ixx
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
	  // %Ixx
	  {
	    uint8_t j;
            uint16_t IO_timer_value;
	    // Read the PCF8574 IO_TIMER value from I2C EEPROM
            prep_read(I2C_EEPROM_R2_WRITE, I2C_EEPROM_R2_READ, PCF8574_I2C_EEPROM_R2_START_IO_TIMERS + ((nParsedNum - 16) * 2), 2);
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
#endif // BUILD_SUPPORT == BROWSER_ONLY_BUILD






	
#if BUILD_SUPPORT == BROWSER_ONLY_BUILD
        else if (nParsedMode == 'j') {
	  // This displays IO Names in user friendly format (1 to 15
	  // characters)
          // These names are for IO 1 to 16 (nParsedNum 0 to 15)
	  // %jxx
          pBuffer = stpcpy(pBuffer, IO_NAME[nParsedNum]);
	}
#if PCF8574_SUPPORT == 1
        else if (nParsedMode == 'J') {
          // This displays PCF8574 IO Names in user friendly format (1 to 15
          // characters)
          // These names are for IO 17 to 24 (nParsedNum 16 to 23)
	  // %Jxx
	  {
	    char temp_string[16];
            // Read a PCF8574_IO_NAMES value from I2C EEPROM
            copy_I2C_EEPROM_bytes_to_RAM(&temp_string[0], 16, I2C_EEPROM_R2_WRITE, I2C_EEPROM_R2_READ, PCF8574_I2C_EEPROM_R2_START_IO_NAMES + ((nParsedNum - 16) * 16), 2);
            pBuffer = stpcpy(pBuffer, temp_string);
          }
	}
#endif // PCF8574_SUPPORT == 1
#endif // BUILD_SUPPORT == BROWSER_ONLY_BUILD


#if DOMOTICZ_SUPPORT == 1
        else if (nParsedMode == 'j' && nParsedNum < 16) {
	  // This displays IO Names in user friendly format (1 to 15
	  // characters). These fields have been repurposed to contain the
	  // IDX values for the IO pins.
          // These names are for IO 1 to 16 (nParsedNum 0 to 15)
	  // %jxx
          pBuffer = stpcpy(pBuffer, IO_NAME[nParsedNum]);
	}
#if PCF8574_SUPPORT == 1
        else if (nParsedMode == 'j' && nParsedNum > 15) {
          // This displays PCF8574 IO Names in user friendly format (1 to 15
	  // characters). These fields have been repurposed to contain the
	  // IDX values for the IO pins.
          // These names are for IO 17 to 24 (nParsedNum 16 to 23)
	  // %Jxx
	  {
	    char temp_byte[16];
            // Read a PCF8574_IO_NAMES value from I2C EEPROM
            copy_I2C_EEPROM_bytes_to_RAM(&temp_byte[0], 16, I2C_EEPROM_R2_WRITE, I2C_EEPROM_R2_READ, PCF8574_I2C_EEPROM_R2_START_IO_NAMES + ((nParsedNum - 16) * 16), 2);
            pBuffer = stpcpy(pBuffer, temp_byte);
          }
	}
#endif // PCF8574_SUPPORT == 1
#if PCF8574_SUPPORT == 0
        else if (nParsedMode == 'j' && nParsedNum > 15) {
          // This is a special case where Domoticz is supported but the
	  // PCF8574 is not. The Domoticz Configuration page still needs to
	  // receive and display 'j' values. In this special case the values
	  // will all be "0".
          // These names are for IO 17 to 24 (nParsedNum 17 to 24)
	  // %Jxx
	  {
            pBuffer = stpcpy(pBuffer, "0");
          }
	}
#endif // PCF8574_SUPPORT == 0
#endif // DOMOTICZ_SUPPORT == 1




#if LOGIN_SUPPORT == 0
        else if (nParsedMode == 'l') {
	  // %lxx
	  // This displays MQTT Username information (0 to 10 characters)
          pBuffer = stpcpy(pBuffer, stored_mqtt_username);
	}
#endif // LOGIN_SUPPORT == 0
#if LOGIN_SUPPORT == 1
        else if (nParsedMode == 'l') {
          if (nParsedNum == 00) {
	    // %l00
	    // This displays MQTT Username information (0 to 10 characters)
            pBuffer = stpcpy(pBuffer, stored_mqtt_username);
	  }
          if (nParsedNum == 01) {
	    // %l01
	    // This displays Login Passphrase information (0 to 15 characters)
            {
              char temp_string[17];
	      temp_string[16] = '\0';
              copy_I2C_EEPROM_bytes_to_RAM(&temp_string[0], 16, I2C_EEPROM_R1_WRITE, I2C_EEPROM_R1_READ, I2C_EEPROM_R1_LOGIN_PASSPHRASE, 2);
              pBuffer = stpcpy(pBuffer, temp_string);
            }
	  }
	}
#endif // LOGIN_SUPPORT == 1


        else if (nParsedMode == 'm') {
	  // %mxx
	  // This displays MQTT Password information (0 to 10 characters)
          pBuffer = stpcpy(pBuffer, stored_mqtt_password);
	}

        else if ((nParsedMode == 'n') && (nParsedNum < 10)) {
	  // This displays the MQTT Start Status information as five
	  // red/green boxes showing Connections available, ARP status,
	  // TCP status, MQTT Connect status, and MQTT Error status.
	  // %nxx
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


#if SDR_POWER_RELAY_SUPPORT == 1
        else if ((nParsedMode == 'n') && (nParsedNum > 9) && (nParsedNum < 20)) {
	  // This displays the last know state of the Latching Relays. Applies
	  // only to Software Defined Radio builds. If a relay is indicated as
	  // ON a green box is displaed. If a relay is indicated as OFF a red
	  // box is displayed.
	  // %nxx
          
          switch (nParsedNum)
	  {
	    case 10:
              // Relay 1 state
	      if ((stored_latching_relay_state & 0x01) == 0x01) pBuffer = stpcpy(pBuffer, "grn");
              else pBuffer = stpcpy(pBuffer, "red");
              break;
	    case 11:
              // Relay 2 state
	      if ((stored_latching_relay_state & 0x02) == 0x02) pBuffer = stpcpy(pBuffer, "grn");
              else pBuffer = stpcpy(pBuffer, "red");
              break;
	    case 12:
              // Relay 3 state
	      if ((stored_latching_relay_state & 0x04) == 0x04) pBuffer = stpcpy(pBuffer, "grn");
              else pBuffer = stpcpy(pBuffer, "red");
              break;
	    case 13:
              // Relay 4 state
	      if ((stored_latching_relay_state & 0x08) == 0x08) pBuffer = stpcpy(pBuffer, "grn");
              else pBuffer = stpcpy(pBuffer, "red");
              break;
	    case 14:
              // Relay 5 state
	      if ((stored_latching_relay_state & 0x10) == 0x10) pBuffer = stpcpy(pBuffer, "grn");
              else pBuffer = stpcpy(pBuffer, "red");
              break;
	    case 15:
              // Relay 6 state
	      if ((stored_latching_relay_state & 0x20) == 0x20) pBuffer = stpcpy(pBuffer, "grn");
              else pBuffer = stpcpy(pBuffer, "red");
              break;
	    case 16:
              // Relay 7 state
	      if ((stored_latching_relay_state & 0x40) == 0x40) pBuffer = stpcpy(pBuffer, "grn");
              else pBuffer = stpcpy(pBuffer, "red");
              break;
	    case 17:
              // Relay 8 state
	      if ((stored_latching_relay_state & 0x80) == 0x80) pBuffer = stpcpy(pBuffer, "grn");
              else pBuffer = stpcpy(pBuffer, "red");
              break;
	    default:
	      break;
	  }
	}
#endif // SDR_POWER_RELAY_SUPPORT == 1


#if OB_EEPROM_SUPPORT == 1
        else if (nParsedMode == 's') {
	  // %sxx
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
        else if ((nParsedMode == 't') && (nParsedNum < 5) && (stored_config_settings & 0x08)) {
	  // This displays temperature sensor data on the IOControl page for 5
	  // sensors and the text fields around that data if DS18B20 mode is
	  // enabled. The  possible nParsedNum values for DS18B20 sensors are
	  // 0, 1, 2, 3, 4.
	  // %txx
	  
	  if (nParsedNum == 0) {
	    #define TEMPTEXT "<p>Temperature Sensors<br>"
// THE NEXT DEFINES WERE PART OF AN ATTEMPT TO GIVE A "HEADER" LOOK TO THE
// TEMPERATURE SENSOR TEXT IN THE IOCONTROL PAGE.
//	    #define TEMPTEXT "<p style='hh'>Temperature Sensors</p><p><br>"
//	    #define TEMPTEXT "<p style='{height:32px;}'>Temperature Sensors</p><p><br>" 
            pBuffer = stpcpy(pBuffer, TEMPTEXT);
	    #undef TEMPTEXT
	  }
	  
	  // Output the sensor ID numbers in long format. This applies to %t00
	  // through %t04.
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
	  else if (nParsedNum < 5) {
	    pBuffer = stpcpy(pBuffer, " ------------ ");
	  }
	  if (nParsedNum < 5) {
	    // Output temperature data
            pBuffer = show_temperature_string(pBuffer, nParsedNum);
	    if (nParsedNum == 4) {
	      #define TEMPTEXT "</p>"
	      pBuffer = stpcpy(pBuffer, TEMPTEXT);
	      #undef TEMPTEXT
	    }
	  }
	}



#if SHORT_TEMPERATURE_SUPPORT == 1
        else if ((nParsedMode == 't') && (nParsedNum >= 20) && (nParsedNum < 25) && (stored_config_settings & 0x08)) {
	  // This displays temperature sensor data on the Short Form
	  // Temperature page for 5 sensors plus the comma delimiters for
	  // the if DS18B20 mode is enabled. The  possible nParsedNum values
	  // for DS18B20 sensors are 20, 21, 22, 23, 24 (for sensors 0, 1, 2,
	  // 3, 4).
	  // %txx
	  // Output the sensor ID numbers in short format for the Short Form
	  // Temperature page. This applies to %t20 through %t24.
	  // For display we output the MSByte first followed by remaining
	  // bytes. A total of 6 bytes are displayed in hex encoded format.
	  if (nParsedNum <= (numROMs + 20)) {
	    if (nParsedNum > 20) *pBuffer++ = ',';
	    {
	      int i;
	      int j;
	      j = (uint8_t)(nParsedNum - 20);
	      for (i=6; i>0; i--) {
	        int2hex(FoundROM[j][i]);
	        pBuffer = stpcpy(pBuffer, OctetArray);
	      }
	    }
	  }
	  // If the sensor does not exist ...
	  else if (nParsedNum < 25) {
	    if (nParsedNum > 20) pBuffer = stpcpy(pBuffer, ",");
	    pBuffer = stpcpy(pBuffer, "000000000000");
	  }
	  if (nParsedNum < 25) {
	    // Output temperature data
            pBuffer = show_temperature_string_short_form(pBuffer, nParsedNum);
	  }
	}
#endif // SHORT_TEMPERATURE_SUPPORT == 1
#endif // DS18B20_SUPPORT == 1


#if BME280_SUPPORT == 1
        else if ((nParsedMode == 't') && (nParsedNum == 5) && (stored_config_settings & 0x20)) {
	  // This displays temperature, pressure, and humidity data from the
	  // BME280 sensor and the text fields around that data IF BME280
	  // mode is enabled. It also shows the user entered altitude.
	  // %txx
	  if (nParsedNum == 5) {
            // Output Temperature, Pressure, Humidity, and Altitude data
            pBuffer = show_BME280_PTH_string(pBuffer);
	  }
	}
#endif // BME280_SUPPORT == 1


#if INA226_SUPPORT == 1
        else if ((nParsedMode == 't') && (nParsedNum > 5) && (nParsedNum < 11)) {
	  // This displays Current, Voltage, and Wattage data from the
	  // INA226-1 sensor. Also shows the text fields around that data.
	  // %txx
	  
	  // Collect data
          // Call ina226_read_measurements(write_command, read_command).
//	  voltage = 1;
//	  current = 1;
//	  power = 1;
	  if (nParsedNum == 6)  ina226_read_measurements(INA226_1_write, INA226_1_read);
	  if (nParsedNum == 7)  ina226_read_measurements(INA226_2_write, INA226_2_read);
	  if (nParsedNum == 8)  ina226_read_measurements(INA226_3_write, INA226_3_read);
	  if (nParsedNum == 9)  ina226_read_measurements(INA226_4_write, INA226_4_read);
	  if (nParsedNum == 10) ina226_read_measurements(INA226_5_write, INA226_5_read);
          pBuffer = show_INA226_CVW_string(pBuffer);
	}
#endif // INA226_SUPPORT == 1


#if DOMOTICZ_SUPPORT == 1
        else if (nParsedMode == 'T') {
	  // For DS18B20 this displays the Serial Number (MAC) of up to 5
	  // devices. If a device does not exist "------------" is displayed.
	  // For BME280 there is no serial number so this simply displays
	  // "BME280------". If a device does not exist "------------" is
	  // displayed.
	  // %Txx

#if DS18B20_SUPPORT == 1
	  // Output the sensor ID numbers for DS18B20 devices only if the
	  // DS18B20 feature is enabled.
	  // For display we output the MSByte first followed by remaining
	  // bytes. A total of 6 bytes are displayed in hex encoded format.
	  if (nParsedNum <= numROMs && (stored_config_settings & 0x08)) {
	    {
	      int i;
	      for (i=6; i>0; i--) {
	        int2hex(FoundROM[nParsedNum][i]);
	        pBuffer = stpcpy(pBuffer, OctetArray);
	      }
	    }
	  }
	  // If the sensor does not exist or DS18B20 feature is not enabled:
	  else if (nParsedNum <= 4) {
	    pBuffer = stpcpy(pBuffer, "------------");
	  }
#endif // DS18B20_SUPPORT == 1

#if DS18B20_SUPPORT == 0
	  if (nParsedNum <= 4) pBuffer = stpcpy(pBuffer, "------------");
#endif // DS18B20_SUPPORT == 0

#if BME280_SUPPORT == 1
	  // Instead of a serial numeber for BME280 output "BME280" instead
	  // only if the BME280 feature is enabled.
	  if (nParsedNum == 5 && (stored_config_settings & 0x20)) pBuffer = stpcpy(pBuffer, "BME280------");
#endif // BME280_SUPPORT == 1

#if BME280_SUPPORT == 0
	  if (nParsedNum == 5) pBuffer = stpcpy(pBuffer, "------------");
#endif // BME280_SUPPORT == 0
          
	  // Now output the IDX values stored in Flash
          if (nParsedNum >= 20 && nParsedNum <= 25) {
	    pBuffer = stpcpy(pBuffer, Sensor_IDX[nParsedNum - 20]);
	  }
        }
#endif // DOMOTICZ_SUPPORT == 1


        else if (nParsedMode == 'w') {
	  // This displays Code Revision information (13 characters) plus Code
	  // Type (23 characters, '.' characters are added to make sure the
	  // length is always 23)
	  // %wxx
	  if (nParsedNum == 0) {
            pBuffer = stpcpy(pBuffer, code_revision);
	  
#if BUILD_TYPE_MQTT_HOME_STANDARD == 1
            pBuffer = stpcpy(pBuffer, " MQTT Home ............");
#endif

#if BUILD_TYPE_MQTT_HOME_UPGRADEABLE == 1
            pBuffer = stpcpy(pBuffer, " MQTT Home UPG ........");
#endif

#if BUILD_TYPE_MQTT_HOME_BME280_UPGRADEABLE == 1
            pBuffer = stpcpy(pBuffer, " MQTT Home BME UPG ....");
#endif
	  
#if BUILD_TYPE_MQTT_DOMO_STANDARD == 1
            pBuffer = stpcpy(pBuffer, " MQTT Domo ............");
#endif

#if BUILD_TYPE_MQTT_DOMO_UPGRADEABLE == 1
            pBuffer = stpcpy(pBuffer, " MQTT Domo UPG ........");
#endif

#if BUILD_TYPE_MQTT_DOMO_BME280_UPGRADEABLE == 1
            pBuffer = stpcpy(pBuffer, " MQTT Domo BME UPG ....");
#endif
	  
#if BUILD_TYPE_BROWSER_STANDARD == 1
            pBuffer = stpcpy(pBuffer, " Browser ..............");
#endif

#if BUILD_TYPE_BROWSER_UPGRADEABLE == 1
            pBuffer = stpcpy(pBuffer, " Browser UPG ..........");
#endif

#if BUILD_TYPE_BROWSER_STANDARD_RFA == 1
            pBuffer = stpcpy(pBuffer, " Browser RFA ..........");
#endif
	  
#if BUILD_TYPE_BROWSER_UPGRADEABLE_RFA == 1
            pBuffer = stpcpy(pBuffer, " Browser RFA UPG.......");
#endif
	  
#if BUILD_TYPE_CODE_UPLOADER == 1
            pBuffer = stpcpy(pBuffer, " Uploader .............");
#endif
          }
	  
	  if (nParsedNum == 1) {
	    // Show the Pinout Option as stored in the EEPROM)
	    *pBuffer = (uint8_t)((stored_options1 & 0x07) + 0x30);
	    pBuffer++;
	  }
	  
	  if (nParsedNum == 2) {
	    // Show the PCF8594 Presence indicator
	    if ((stored_options1 & 0x08) == 0x08) {
              pBuffer = stpcpy(pBuffer, "1");
	    }
            else pBuffer = stpcpy(pBuffer, "0");
	  }
	}


        else if (nParsedMode == 'y') {
          // Indicates the need to insert one of several commonly occuring HTML
          // strings. These strings were created to aid in compressing the web
	  // page templates stored in flash memory by storing the strings once,
	  // then inserting them in the web page template as that template is
	  // sent to the browser for display.
	  // %yxx
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
	  //    is zero we know we are just starting to insert a %yxx string.
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
#if DOMOTICZ_SUPPORT == 0
          || pSocket->current_webpage == WEBPAGE_PCF8574_IOCONTROL
	  || pSocket->current_webpage == WEBPAGE_PCF8574_CONFIGURATION
#endif // DOMOTICZ_SUPPORT == 0
#endif // PCF8574_SUPPORT == 1
#if LOGIN_SUPPORT == 1
          || pSocket->current_webpage == WEBPAGE_LOGIN
          || pSocket->current_webpage == WEBPAGE_SET_PASSPHRASE
#endif // LOGIN_SUPPORT == 1
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
  
  convert_temperature(nParsedNum, 0, 0);	// Convert to degrees C in OctetArray
  pBuffer = stpcpy(pBuffer, OctetArray);	// Insert sensor value
  #define TEMPTEXT "&#8451; "			// Insert degress C symbol
  pBuffer = stpcpy(pBuffer, TEMPTEXT);
  #undef TEMPTEXT
  
  convert_temperature(nParsedNum, 1, 0);	// Convert to degrees F in OctetArray
  pBuffer = stpcpy(pBuffer, OctetArray);	// Insert sensor value
  #define TEMPTEXT "&#8457;<br>"		// Insert degress F symbol
  pBuffer = stpcpy(pBuffer, TEMPTEXT);
  #undef TEMPTEXT
  
  return pBuffer;
}
#endif // DS18B20_SUPPORT == 1


#if SHORT_TEMPERATURE_SUPPORT == 1
#if DS18B20_SUPPORT == 1
char *show_temperature_string_short_form(char *pBuffer, uint8_t nParsedNum)
{
  // Display temperature strings in degrees C and degrees F in the short form
  // format.
  uint8_t i;
 
  i = (uint8_t)(nParsedNum - 20);
  
  convert_temperature(i, 0, 1);			// Convert to degrees C in OctetArray
  pBuffer = stpcpy(pBuffer, ",");		// Insert comma delimiter
  pBuffer = stpcpy(pBuffer, OctetArray);	// Insert sensor value
  
  convert_temperature(i, 1, 1);			// Convert to degrees F in OctetArray
  pBuffer = stpcpy(pBuffer, ",");		// Insert comma delimiter
  pBuffer = stpcpy(pBuffer, OctetArray);	// Insert sensor value
  
  return pBuffer;
}
#endif // DS18B20_SUPPORT == 1
#endif // SHORT_TEMPERATURE_SUPPORT == 1


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
//  temp_whole = ((temp_whole * 3048) / 10000);
  temp_whole = (temp_whole * 3048) + 5000; // Adding 5000 handles truncation roundoff
  temp_whole = temp_whole / 10000;
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
  temp_whole = stored_altitude;
  if (stored_altitude < 0) {
    temp_whole = (uint32_t)(temp_whole * -1);
    pBuffer = stpcpy(pBuffer, "-");        // Insert minus sign
  }
  else {
    pBuffer = stpcpy(pBuffer, " ");        // Insert space
  }
  
  emb_itoa((uint16_t)temp_whole, OctetArray, 10, 5);
  pBuffer = stpcpy(pBuffer, OctetArray);   // Display value in feet
  pBuffer = stpcpy(pBuffer, " feet</p>");

  return pBuffer;
}
#endif // BME280_SUPPORT == 1


#if INA226_SUPPORT == 1
char *show_INA226_CVW_string(char *pBuffer)
{
  // Show the ina226 Current Voltage Wattage string

  // Display Current in 3.3 format
  // Example: A value of 1.2 amps is shown as 001.200 A  
  pBuffer = stpcpy(pBuffer, "Current "); // Copy name to webpage
  INAint32ToString(current);                // Convert to string in OctetArray
  pBuffer = stpcpy(pBuffer, OctetArray); // Copy to webpage
  pBuffer = stpcpy(pBuffer, " A<br>");   // Copy units to webpage

  // Display Voltage in 3.3 format
  // Example: A value of 1.2 volts is shown as 001.200 V  
  pBuffer = stpcpy(pBuffer, "Voltage "); // Copy name to webpage
  INAint32ToString(voltage);                // Convert to string in OctetArray
  pBuffer = stpcpy(pBuffer, OctetArray); // Copy to webpage
  pBuffer = stpcpy(pBuffer, " V<br>");   // Copy units to webpage

  // Display Wattage in 3.3 format
  // Example: A value of 12 V at 20 A or 240 Watts is shown as 240.000 W
  pBuffer = stpcpy(pBuffer, "Wattage "); // Copy name to webpage
  INAint32ToString(power);                  // Convert to string in OctetArray
  pBuffer = stpcpy(pBuffer, OctetArray); // Copy to webpage
  pBuffer = stpcpy(pBuffer, " W<br>");   // Copy units to webpage

  return pBuffer;
}


void INAint32ToString(int32_t fVal)
{
  // Converts a int32_t value to a string in global OctetArray.
  // The int32_t value is 1000 times the value that is to be displayed.
  // The string consists of a number with 3 digits followed by 3 digits after
  // the decimal point (xxx.yyy where xxx is max 999).
  // Creates the string backwards before copying it character-by-character
  // from the end to the start.
  // Always converts to absolute value (negative values are converted to
  // positive).
  char result[8];
  int16_t dVal;
  int16_t dec;
  int8_t i, j;

  if (fVal < 0) fVal = fVal * -1;
  dVal = (int16_t)(fVal / 1000); // This captures the "number" as an int.
  if (dVal > 999) dVal = 999; // Limit to three places.
  
  dec = (int16_t)(fVal % 1000); // Capture the decimal as three places.

  // Convert the decimal part of the value to string characters
  result[0] = (char)((dec % 10) + '0');
  dec /= 10;
  result[1] = (char)((dec % 10) + '0');
  dec /= 10;
  result[2] = (char)((dec % 10) + '0');
  
  // Insert decimal point
  result[3] = '.';

  // Convert the number part of the value to string characters.
  result[4] = (char)((dVal % 10) + '0');
  dVal /= 10;
  result[5] = (char)((dVal % 10) + '0');
  dVal /= 10;
  result[6] = (char)((dVal % 10) + '0');
  
  // Reverse the order of the characters in the string.
  j = 0;
  for (i = 6; i >= 0; ) OctetArray[j++] = result[i--];
  // Place null at end of string
  OctetArray[7] = '\0';
}
#endif // INA226_SUPPORT == 1


#if BME280_SUPPORT == 1
void create_sensor_ID(int8_t sensor)
{
  // Create the sensor ID and store it in OctetArray
  
  char temp_string[13];

  // Create the sensor number for the app_message and topic.
  // Add first part of sensor ID to temp_string. For the BME280 the ID
  // is "BME280" plus a one digit number contained in "int8_t sensor":
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
    init_tHttpD_struct(&uip_connr->appstate.HttpDSocket);
  }
  
  // Initialize storage for the GET command
  parse_GETcmd[0] = '\0';

  // Start listening on our port
  // Removed "htons" code to reduce Flash usage. This can be done as the SMT8
  // is "Big Endian". Keep the commented code in case the application is
  // ported to a "Little Endian" architecture.
  // uip_listen(htons(Port_Httpd));
  uip_listen(Port_Httpd);
}


// void init_tHttpD_struct(struct tHttpD* pSocket, int i) {
void init_tHttpD_struct(struct tHttpD* pSocket) {
  // Initialize the contents of the struct tHttpD
  // This function is called UIP_CONNS times by the HttpDinit function. It is
  // called once for each possible connection. The function sets the initial
  // values within the pSocket structure.
  pSocket->nState = STATE_NULL;
  pSocket->ParseState = PARSE_NULL;
  pSocket->nNewlines = 0;
  pSocket->insertion_index = 0;
}


void HttpDCall(uint8_t* pBuffer, uint16_t nBytes, struct tHttpD* pSocket)
{
  uint16_t nBufSize;
  int i;
  uint8_t j;
  char compare_buf[32];
  uint32_t parse_file_time_start;
  
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
  
  // HttpDCall() is called from uip_TcpAppHubCall(), which is in turn called
  // via UIP_APPCALL in the uip.c code. uip_periodic() assures that an
  // HttpDCall() occurs regularly to process any outstanding data pending for
  // receipt or transmission.

  i = 0;
  j = 0;

  if (uip_connected()) {
    // uip_connected() will occur when a connection is established after being
    // requested by a Browser.
    //
    // In this application passing through the uip_connected() code is really
    // only useful to receiving data from the Browser as uip_connected() will
    // set nState to STATE_CONNECTED, which then allows the uip_new_data()
    // code to sort out whether we are receiving a GET or POST from the
    // Browser.
    //
    // In the original code that this application is based on uip_connected()
    // had code like this:
    // \code
    // if (pSocket->current_webpage == WEBPAGE_IOCONTROL) {
    //   pSocket->pData = g_HtmlPageIOControl;
    //   pSocket->nDataLeft = HtmlPageIOControl_size;
    // }
    // pSocket->nState = STATE_CONNECTED;
    // pSocket->nPrevBytes = 0xFFFF;
    // \endcode
    // The "if" part of the above had to be present for every type of webpage.
    // I think the above would initialize a pSocket to transmit any of the
    // webpages to the Browser.
    // However, since this application is entriely based on GET requests from
    // the Browser, the pSocket initialization occurs within the GET
    // request processing, and uip_connected() only gets called to establish
    // the nState as STATE_CONNECTED at the start of receipt of the first
    // packet from the Browser. See the "else if (uip_newdata())" code below
    // where the first packet is interpreted as either a GET packet or as a
    // POST packet.
    
    // HttpDCall() is called repeatedly via uip_periodic() to allow
    // uip_connected() to run followed by allowing uip_newdata() to run.
    
#if DEBUG_SUPPORT == 15
rexmit_count = 0; // Used only for sending the rexmit count via UART
#endif // DEBUG_SUPPORT == 15

#if DEBUG_SUPPORT == 15
// UARTPrintf("Entering uip_connected()\r\n");
#endif // DEBUG_SUPPORT == 15

    pSocket->nState = STATE_CONNECTED;
  }

  else if (uip_acked()) {
    // This is a "transmit data to the Browser" function.
    
#if DEBUG_SUPPORT == 15
// UARTPrintf("Entering uip_acked()\r\n");
#endif // DEBUG_SUPPORT == 15

    // How a webpage is transmitted to the Browser: At the end of GET or POST
    // processing the webpage header is sent (see STATE_SENDHEADER200 and
    // STATE_SENDHEADER204). Sending the header will start the transmission
    // process which will result in a connection being established. After that
    // all data following the header is sent with uip_acked() which calls the
    // senddata: process.
    
    // If uip_acked() is true we will be in the STATE_SENDDATA state and
    // only need to run the "senddata" part of this function. This typically
    // happens when there are multiple packets to send to the Broswer in
    // response to a POST or GET, so we may repeat this loop in
    // STATE_SENDDATA several times. Note that GET or POST processing has
    // already sent the TCP HEADER, and uip_acked() indicates an acknowledge
    // from the Browser such that more data can be sent to the Browser.
    
    goto senddata;
  }
  
  else if (uip_newdata()) {
    // This is a "receive data from the Browser" function, including the
    // receipt of the very first connection request.

#if DEBUG_SUPPORT == 15
// if (uip_newdata()) {
//   UARTPrintf("Entering uip_newdata(). nBytes = ");
//   emb_itoa(nBytes, OctetArray, 10, 3);
//   UARTPrintf(OctetArray);
//   UARTPrintf("\r\n");
// }
#endif // DEBUG_SUPPORT == 15

    //
    // This is the start of a new Browser session, or it is additional packets
    // received to complete a transmission from the Browser.
    //
    // In this limited application the only "new data" packets a browser can
    // send to the web server are "POST" or "GET" packets. We're going to
    // parse the data portion of the packet.
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
    //      fragmentation of GET commands, although the code WILL handle
    //      fragmentation of the unused balance of the GET request.
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

#if DEBUG_SUPPORT == 15
// UARTPrintf("\r\n");
// UARTPrintf("Beginning of POST found. parse_tail set to NULL. nBytes = ");
// emb_itoa(nBytes, OctetArray, 10, 3);
// UARTPrintf(OctetArray);
// UARTPrintf("\r\n");
#endif // DEBUG_SUPPORT == 15


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
          eeprom_address_index = I2C_EEPROM_R0_BASE;
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



    if (pSocket->nState == STATE_GOTGET && parse_GETcmd[0] != '\0') {
      // If we are in state GOTGET but we are already processing a GET Request
      // we need to throw away the new request and return a 429 response.
      pSocket->nState = STATE_SENDHEADER429;
      pSocket->nDataLeft = 0;
    }


    if (pSocket->nState == STATE_GOTGET && parse_GETcmd[0] == '\0') {
      // The GET request is processed only if no GET request is already being
      // processed (as indicated by NULL in the first character of the
      // parse_GETcmd).
      // Save the 11 characters that follow "GET " in the first packet in
      // global parse_GETcmd[11]. These will be parsed later after the entire
      // GET request is read. This is only to allow the Browser to finish
      // sending the entire request.
      // Once all characters of the GET command are captured parse_GETcmd[]
      // should contain something like "/filename" where the longest command
      // is one of the /50 /51 /52 commands like "/51mmmmpppp". That command
      // type is 11 characters long and will completely fill parse_GETcmd[].
      for (i = 0; i < 11; i++) {
        parse_GETcmd[i] = *pBuffer;
        pBuffer++;
      }
      // Reset pBuffer back to the end of the "GET " indentifier so that the
      // search performed in STATE_GOTGET2 will work properly. nBytes is
      // already set properly for that location.
//      pBuffer -= 19;
      pBuffer -= 11;
      pSocket->nState = STATE_GOTGET2;
    }

    if (pSocket->nState == STATE_GOTGET2) {
#if DEBUG_SUPPORT == 15
// UARTPrintf("Entering STATE_GOTGET2\r\n");
#endif // DEBUG_SUPPORT == 15
      // Receive the entire GET request. We don't use any of the remaining
      // content in the GET request so just keep returning for more packets
      // until the end of the GET request is found.

      while (nBytes != 0) {
	// The following searches for a zero length line to indictate
	// the end of the GET request. Note: Since any text line that
	// precedes the zero length line must end with a \r\n, and the
	// zero length line consists only of a \r\n, this code uses the
	// same "nNewlines" search that the POST process uses to find a
	// "\r\n\r\n" sequence.
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

#if DEBUG_SUPPORT == 15
// if (*pBuffer != '\r' && *pBuffer != '\n') {
//   OctetArray[0] = *pBuffer;
//   OctetArray[1] = '\0';
//   UARTPrintf(OctetArray);
// }
// else if (*pBuffer == '\n') {
//   UARTPrintf("\r\n");
// }
#endif // DEBUG_SUPPORT == 15

          if (*pBuffer == '\n') {
            pSocket->nNewlines++;
	  }
          else if (*pBuffer == '\r') { }
          else pSocket->nNewlines = 0;
          pBuffer++;
          nBytes--;
          if (pSocket->nNewlines != 2 && nBytes == 0) {
            // Didn't find the "\r\n\r\n" yet but we hit end of fragment, so
	    // we exit and will come back to the loop with the next fragment.
#if DEBUG_SUPPORT == 15
// UARTPrintf("Reading GET header - hit end of fragment\r\n");
#endif // DEBUG_SUPPORT == 15
            return;
          }
        }

        if (pSocket->nNewlines == 2) {
	  // End of GET header found
	  // Clear nNewlines for future GETs
	  pSocket->nNewlines = 0;
	  
#if DEBUG_SUPPORT == 15
// UARTPrintf("End of GET header found. nBytes = ");
// emb_itoa(nBytes, OctetArray, 10, 3);
// UARTPrintf(OctetArray);
// UARTPrintf("\r\n");
#endif // DEBUG_SUPPORT == 15

	  
#if DEBUG_SUPPORT == 15
// Determine if uip_conn->ripaddr can be read at this location
//{
//uip_ipaddr_t *uip_ptr = NULL;
//uint32_t temp32;

//uip_ptr = &uip_conn->ripaddr;
// Convert the value to an 8 digit hex string and display
//  if (uip_ptr != NULL) {
//    temp32 = (*uip_ptr)[0];
//    temp32 <<= 16;
//    temp32 |= (*uip_ptr)[1];
//    emb_itoa(temp32, OctetArray, 16, 8);
//    UARTPrintf("ripaddr = ");
//    UARTPrintf(OctetArray);
//    UARTPrintf("\r\n");
//  }
//}
#endif // DEBUG_SUPPORT == 15

          // Start parsing the GET command
          // Initialize Parsing variables
          // nParseLeft is used as a flag in GET parsing. nParseLeft == 1 will
          // cause parsing to continue. nParseLeft == 0 will cause parsing to
          // end.
          pSocket->nParseLeft = 1;
          pSocket->ParseState = PARSE_SLASH1;
          // Start parsing
          pSocket->nState = STATE_PARSEGET;
          break;
        }
      }
    }


#if BUILD_SUPPORT == BROWSER_ONLY_BUILD || BUILD_SUPPORT == MQTT_BUILD
    if (pSocket->nState == STATE_PARSEPOST) {
      // Once STATE_PARSEPOST is entered we remain in that state until the
      // entire POST is received and processed. So this loop could be
      // repeated, repeating the call to parsepost(), until all packets are
      // received and parsed. Once all POST data is received the parsepost()
      // function will set pSocket->nState = STATE_SENDHEADER204 to end the
      // process.

#if DEBUG_SUPPORT == 15
// UARTPrintf("\r\n");
// UARTPrintf("Calling STATE_PARSEPOST. nBytes = ");
// emb_itoa(nBytes, OctetArray, 10, 3);
// UARTPrintf(OctetArray);
// UARTPrintf("\r\n");
#endif // DEBUG_SUPPORT == 15

      // Parse data the user entered in the GUI.
      parsepost(pSocket, pBuffer, nBytes);
    }
#endif // BUILD_SUPPORT == BROWSER_ONLY_BUILD || BUILD_SUPPORT == MQTT_BUILD








    if (pSocket->nState == STATE_PARSEGET) {
      // Parse the GET command and identify the webpage to be copied to the
      // body of the GET response.
      // Once STATE_PARSEGET is entered we remain in that state until the
      // entire GET is received and processed. So this loop could be
      // repeated, repeating the call to parseget(), until all packets are
      // received and parsed. Once all GET data is received the parseget()
      // function will set pSocket->nState = STATE_SENDHEADER200 (or 204) to
      // end the process.
      parseget(pSocket, pBuffer);
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
      // - It is possible that communications are so poor that the conditions
      //   of the various "while" loops below cannot be met. I've found this
      //   is particularly true on really bad WiFi connections. A timeout
      //   funcction is used to cause a "parse fail" exit if the file transfer
      //   is not completed in 60 seconds.
      // nBytes is tracked in this function using the global file_nBytes to
      // enable shared use of the nBytes value in this function and the
      // read_two_characters function.
      file_nBytes = nBytes;
      parse_file_time_start = second_counter;

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
	  
	  if (parse_file_time_start > (second_counter + 60)) {
	    // If a timeout occurs assume the connection is too poor to
	    // complete the file transfer and simply abort the connection.
            pSocket->ParseState = PARSE_FILE_FAIL_EXIT;
#if DEBUG_SUPPORT == 15
// UARTPrintf("Timeout: goto PARSE_FILE_FAIL_EXIT\r\n");
#endif // DEBUG_SUPPORT == 15
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
	  //     so the 32K I2C EEPROM Region 0 space is erased to make it
	  //     available to store the parsed SREC content. This SREC must be
	  //     read to determine the "file_type", ie, is it a PROGRAM file or
	  //     a STRING file.
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
	      
#if DEBUG_SUPPORT == 15
//UARTPrintf("UPGRADE_FAILCODE = UPGRADE_FAIL_TRUNCATED_FILE\r\n");
#endif // DEBUG_SUPPORT == 15

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
	      
#if DEBUG_SUPPORT == 15
//UARTPrintf("UPGRADE_FAILCODE = UPGRADE_FAIL_NOT_SREC\r\n");
#endif // DEBUG_SUPPORT == 15

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

                  // Erase I2C EEPROM Region 0 to provide a clean space to
		  // store the incoming SREC data.
		  
		  {
		    uint16_t i;
		    uint8_t j;
		    uint16_t temp_eeprom_address_index;
		    for (i=0; i<256; i++) {
		      // Write 256 blocks of 128 bytes each with zero
		      temp_eeprom_address_index = i * 128;
		      j = 0;
                      copy_STM8_bytes_to_I2C_EEPROM(&j, 128, I2C_EEPROM_R0_WRITE, temp_eeprom_address_index, 2);
                      IWDG_KR = 0xaa; // Prevent the IWDG from firing.
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
                        I2C_control(I2C_EEPROM_R0_WRITE);
		      }
	              if (file_type == FILETYPE_STRING) {
                        I2C_control(I2C_EEPROM_R2_WRITE);
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
                        prep_read(I2C_EEPROM_R0_WRITE, I2C_EEPROM_R0_READ, eeprom_address_index, 2);
                      }
	              if (file_type == FILETYPE_STRING) {
                        prep_read(I2C_EEPROM_R2_WRITE, I2C_EEPROM_R2_READ, eeprom_address_index, 2);
                      }
	              I2C_last_flag = 0;
                      for (i=0; i<64; i++) {
                        if (i == 63) I2C_last_flag = 1;
                        temp_byte = I2C_read_byte(I2C_last_flag);
                        if (temp_byte != parse_tail[i]) {
                          upgrade_failcode = UPGRADE_FAIL_EEPROM_MISCOMPARE;
#if DEBUG_SUPPORT == 15
//UARTPrintf("UPGRADE_FAILCODE = UPGRADE_FAIL_EEPROM_MISCOMPARE\r\n");
#endif // DEBUG_SUPPORT == 15
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
#if DEBUG_SUPPORT == 15
//UARTPrintf("UPGRADE_FAILCODE = UPGRADE_FAIL_INVALID_FILETYPE\r\n");
#endif // DEBUG_SUPPORT == 15
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
                          I2C_control(I2C_EEPROM_R0_WRITE);
			}
	                if (file_type == FILETYPE_STRING) {
                          I2C_control(I2C_EEPROM_R2_WRITE);
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
                          prep_read(I2C_EEPROM_R0_WRITE, I2C_EEPROM_R0_READ, eeprom_address_index, 2);
			}
	                if (file_type == FILETYPE_STRING) {
                          prep_read(I2C_EEPROM_R2_WRITE, I2C_EEPROM_R2_READ, eeprom_address_index, 2);
			}
			
	                I2C_last_flag = 0;
                        for (i=0; i<64; i++) {
                          if (i == 63) I2C_last_flag = 1;
                          temp_byte = I2C_read_byte(I2C_last_flag);
                           if (temp_byte != parse_tail[i]) {
                             upgrade_failcode = UPGRADE_FAIL_EEPROM_MISCOMPARE;
#if DEBUG_SUPPORT == 15
//UARTPrintf("UPGRADE_FAILCODE = UPGRADE_FAIL_EEPROM_MISCOMPARE\r\n");
#endif // DEBUG_SUPPORT == 15
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
	      
	      if (parse_file_time_start > (second_counter + 60)) {
	        // If a timeout occurs assume the connection is too poor to
	        // complete the file transfer and simply abort the connection.
                pSocket->ParseState = PARSE_FILE_FAIL_EXIT;
#if DEBUG_SUPPORT == 15
// UARTPrintf("Timeout: goto PARSE_FILE_FAIL_EXIT\r\n");
#endif // DEBUG_SUPPORT == 15
	        break; // Break out of the local while loop
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
#if DEBUG_SUPPORT == 15
//UARTPrintf("UPGRADE_FAILCODE = UPGRADE_FAIL_FILE_READ_CHECKSUM\r\n");
#endif // DEBUG_SUPPORT == 15
                  pSocket->ParseState = PARSE_FILE_FAIL;
                  break; // Break out of the local while loop
	        }
	      }
	    
	      if (parse_index == 64 && file_type == FILETYPE_PROGRAM) {
	        // Copy parse_tail to I2C EEPROM Region 0
	        
                // Write the 64 bytes of data that are in the parse_tail array
                // into the I2C EEPROM.
                {
                  int i;
                  uint8_t I2C_last_flag;
                  uint8_t temp_byte;
                  
                  I2C_control(I2C_EEPROM_R0_WRITE); // Send Write Control Byte
                  I2C_byte_address(eeprom_address_index, 2);
                  for (i=0; i<64; i++) {
                    I2C_write_byte(parse_tail[i]);
                  }
                  I2C_stop();
                  wait_timer(5000); // Wait 5ms
                  IWDG_KR = 0xaa; // Prevent the IWDG from firing.
                  // Validate data in I2C EEPROM
                  prep_read(I2C_EEPROM_R0_WRITE, I2C_EEPROM_R0_READ, eeprom_address_index, 2);
	          I2C_last_flag = 0;
                  for (i=0; i<64; i++) {
                    if (i == 63) I2C_last_flag = 1;
                    temp_byte = I2C_read_byte(I2C_last_flag);
                    if (temp_byte != parse_tail[i]) {
                      upgrade_failcode = UPGRADE_FAIL_EEPROM_MISCOMPARE;
#if DEBUG_SUPPORT == 15
//UARTPrintf("UPGRADE_FAILCODE = UPGRADE_FAIL_EEPROM_MISCOMPARE\r\n");
#endif // DEBUG_SUPPORT == 15
                      pSocket->ParseState = PARSE_FILE_FAIL;
                      break; // Break out of the local while loop
                    }
                  }
                  eeprom_address_index += 64;
                }
              }
	    
	      if (parse_index == 64 && file_type == FILETYPE_STRING) {
	        // Copy parse_tail to I2C EEPROM Region 2
	        
                // Write the 64 bytes of data that are in the parse_tail array
                // into the I2C EEPROM.
                {
                  int i;
                  uint8_t I2C_last_flag;
                  uint8_t temp_byte;
                  
                  I2C_control(I2C_EEPROM_R2_WRITE); // Send Write Control Byte
                  I2C_byte_address(eeprom_address_index, 2);
                  for (i=0; i<64; i++) {
                    I2C_write_byte(parse_tail[i]);
                  }
                  I2C_stop();
                  wait_timer(5000); // Wait 5ms
                  IWDG_KR = 0xaa; // Prevent the IWDG from firing.
                  // Validate data in I2C EEPROM
                  prep_read(I2C_EEPROM_R2_WRITE, I2C_EEPROM_R2_READ, eeprom_address_index, 2);
	          I2C_last_flag = 0;
                  for (i=0; i<64; i++) {
                    if (i == 63) I2C_last_flag = 1;
                    temp_byte = I2C_read_byte(I2C_last_flag);
                    if (temp_byte != parse_tail[i]) {
                      upgrade_failcode = STRING_EEPROM_MISCOMPARE;
#if DEBUG_SUPPORT == 15
//UARTPrintf("UPGRADE_FAILCODE = STRING_EEPROM_MISCOMPARE\r\n");
#endif // DEBUG_SUPPORT == 15
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
                memset(parse_tail, 0, 64);
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
	      
	      if (parse_file_time_start > (second_counter + 60)) {
	        // If a timeout occurs assume the connection is too poor to
	        // complete the file transfer and simply abort the connection.
                pSocket->ParseState = PARSE_FILE_FAIL_EXIT;
#if DEBUG_SUPPORT == 15
// UARTPrintf("Timeout: goto PARSE_FILE_FAIL_EXIT\r\n");
#endif // DEBUG_SUPPORT == 15
	        break; // Break out of the local while loop
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
              {
	        uint8_t write_control = I2C_EEPROM_R0_WRITE;
	        uint8_t read_control = I2C_EEPROM_R0_READ;
	        // On arrival here file_type can only be FILETYPE_STRING or
	        // FILETYPE_PROGRAM. Above initialization defaults to
	        // file_type == FILETYPE_PROGRAM
	        if (file_type == FILETYPE_STRING) {
                  write_control = I2C_EEPROM_R2_WRITE;
	          read_control = I2C_EEPROM_R2_READ;
                }
                copy_I2C_EEPROM_bytes_to_RAM(&parse_tail[0], 64, write_control, read_control, eeprom_address_index, 2);
	      }
	      
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
#if DEBUG_SUPPORT == 15
//UARTPrintf("UPGRADE_FAILCODE = UPGRADE_FAIL_FILE_READ_CHECKSUM\r\n");
#endif // DEBUG_SUPPORT == 15
                  pSocket->ParseState = PARSE_FILE_FAIL;
                  break; // Break out of the local while loop
	        }
	        else {
	        }
	      }
	      
	      if (data_count == 0 || parse_index == 64) {
                // Copy parse_tail to I2C EEPROM Region 0
	        
                // Write the data in the parse_tail array into the I2C
	        // EEPROM.
                {
                  int i;
                  uint8_t I2C_last_flag;
                  uint8_t temp_byte;
		  
	          if (file_type == FILETYPE_PROGRAM) {
                    I2C_control(I2C_EEPROM_R0_WRITE); // Send Write Control Byte
		  }
	          if (file_type == FILETYPE_STRING) {
                    I2C_control(I2C_EEPROM_R2_WRITE); // Send Write Control Byte
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
                    prep_read(I2C_EEPROM_R0_WRITE, I2C_EEPROM_R0_READ, eeprom_address_index, 2);
		  }
	          if (file_type == FILETYPE_STRING) {
                    prep_read(I2C_EEPROM_R2_WRITE, I2C_EEPROM_R2_READ, eeprom_address_index, 2);
		  }
		  
	          I2C_last_flag = 0;
                  for (i=0; i<64; i++) {
                    if (i == 63) I2C_last_flag = 1;
                    temp_byte = I2C_read_byte(I2C_last_flag);
                    if (temp_byte != parse_tail[i]) {
                      upgrade_failcode = UPGRADE_FAIL_EEPROM_MISCOMPARE;
#if DEBUG_SUPPORT == 15
//UARTPrintf("UPGRADE_FAILCODE = UPGRADE_FAIL_EEPROM_MISCOMPARE\r\n");
#endif // DEBUG_SUPPORT == 15
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
                {
	          uint8_t write_control = I2C_EEPROM_R0_WRITE;
	          uint8_t read_control = I2C_EEPROM_R0_READ;
		  // On arrival here file_type can only be FILETYPE_STRING or
		  // FILETYPE_PROGRAM. Above initialization defaults to
		  // file_type == FILETYPE_PROGRAM
	          if (file_type == FILETYPE_STRING) {
                    write_control = I2C_EEPROM_R2_WRITE;
	            read_control = I2C_EEPROM_R2_READ;
                  }
                  copy_I2C_EEPROM_bytes_to_RAM(&parse_tail[0], 64, write_control, read_control, eeprom_address_index, 2);
	        }
	    
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
	      
	      if (parse_file_time_start > (second_counter + 60)) {
	        // If a timeout occurs assume the connection is too poor to
	        // complete the file transfer and simply abort the connection.
                pSocket->ParseState = PARSE_FILE_FAIL_EXIT;
#if DEBUG_SUPPORT == 15
// UARTPrintf("Timeout: goto PARSE_FILE_FAIL_EXIT\r\n");
#endif // DEBUG_SUPPORT == 15
	        break; // Break out of the local while loop
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

#if DEBUG_SUPPORT == 15
// UARTPrintf("PARSE_FILE_FAIL\r\n");
#endif // DEBUG_SUPPORT == 15

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
	      
	      if (parse_file_time_start > (second_counter + 60)) {
	        // If a timeout occurs assume the connection is too poor to
	        // complete the file transfer and simply abort the connection.
                pSocket->ParseState = PARSE_FILE_FAIL_EXIT;
#if DEBUG_SUPPORT == 15
// UARTPrintf("Timeout: goto PARSE_FILE_FAIL_EXIT\r\n");
#endif // DEBUG_SUPPORT == 15
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
	  
	  if (parse_file_time_start > (second_counter + 60)) {
	    // If a timeout occurs assume the connection is too poor to
	    // complete the file transfer and simply abort the connection.
            pSocket->ParseState = PARSE_FILE_FAIL_EXIT;
#if DEBUG_SUPPORT == 15
// UARTPrintf("Timeout: goto PARSE_FILE_FAIL_EXIT\r\n");
#endif // DEBUG_SUPPORT == 15
	    break; // Break out of the main while loop
	  }
        } // End of main while loop
      }
    
      if (pSocket->ParseState == PARSE_FILE_COMPLETE && file_type == FILETYPE_PROGRAM) {
        // All data is now in I2C EEPROM Region 0. Signal the main.c loop to
	// copy the data to Flash and display a Timer window to have the
	// user wait until Flash programming completes and the module reboots.

#if DEBUG_SUPPORT == 15
// UARTPrintf("Sending Copy EEPROM to Flash request\r\n");
#endif // DEBUG_SUPPORT == 15

	eeprom_copy_to_flash_request = I2C_COPY_EEPROM_R0_REQUEST;
        pSocket->nParseLeft = 0;
	
	pSocket->current_webpage = WEBPAGE_TIMER;
        pSocket->pData = g_HtmlPageTimer;
        pSocket->nDataLeft = (uint16_t)(sizeof(g_HtmlPageTimer) - 1);
	
	// Send the response
        pSocket->nPrevBytes = 0xFFFF;
        pSocket->nState = STATE_SENDHEADER200;
      }


      if (pSocket->ParseState == PARSE_FILE_COMPLETE && file_type == FILETYPE_STRING) {
        // All data is now in I2C EEPROM Region 2.
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
	
#if DEBUG_SUPPORT == 15
//UARTPrintf("UPGRADE_FAILCODE = UPGRADE_FAIL_TRUNCATED_FILE\r\n");
#endif // DEBUG_SUPPORT == 15
        
        pSocket->ParseState = PARSE_FILE_FAIL_EXIT;
      }


      if (pSocket->ParseState == PARSE_FILE_FAIL_EXIT) {
        // Parsing aborted. Display a GUI with the fail reason code.

#if DEBUG_SUPPORT == 15
//UARTPrintf("Parse FAIL XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX\r\n");
#endif // DEBUG_SUPPORT == 15

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
      // This step is entered after HTTP request processing is complete in
      // order to copy an appropriate web page into the body of the reply
      // to the request.
      // This step is entered after:
      //   a) GET processing is complete and a webpage is to be displayed in
      //      response to the GET.
      //   or
      //
      //   b) POST processing is complete and a webpage different than the one
      //      that generated the POST is to be displayed.
      //
      //   or
      //
      //   c) The Code Uploader has completed processing a file upload. This
      //      is really just another verions of POST (a "file POST"). As a
      //      result of the Code Uploader running various webpages can be
      //      displayed depending on the error status of the file upload.
      //
      // In the uip_send() call we provide the CopyHttpHeader function with
      // the length of the web page.
      // Some GET requests do not send a webpage response (just a 200 header
      // with Content-Length = 0). In those cases STATE_SENDHEADER204 will
      // have been entered from GET processing (see below).
      uip_send(uip_appdata, CopyHttpHeader(uip_appdata, adjust_template_size(pSocket), HEADER200));
      pSocket->nState = STATE_SENDDATA;
      return;
    }
      
    if (pSocket->nState == STATE_SENDHEADER204) {
      // This step is entered after HTTP request processing is complete in
      // in order to copy an "empty" web page into the body of the reply to
      // the request.
      // This step is entered after:
      //   a) POST is complete.
      //      OR
      //   b) GET processing is complete and no webpage is to be displayed in
      //      response to the GET.
      // In both of these cases we only copy a header with Content_Length: 0
      // and no data into the body of the reply to the GET or POST.
      //
      // Note: In this application a POST is only generated by a IOControl or
      // Configuration page. STATE_SENDHEADER204 will copy the 200 header into
      // the body of the reply to the POST with Content-Length = 0. Also note
      // that the javascript in the IOControl and Configurationose pages will
      // generate a GET request to update the Browser after the POST is
      // complete.
      //
      // Note: It is not clear if some browsers require a "204 No Content"
      // header. This appears to work just returning a "200 OK" with Content
      // Length: 0, which is what actually happens in this application.

#if RESPONSE_LOCK_SUPPORT == 1
      // A special case when SENDHEADER_204 is requested is the case where the
      // Response Lock is turned on. In this case we don't want to send
      // anyting at all, not even the header. This makes it appear that the
      // webserver does not exist, helping to make the device a little more
      // secure.
      if ((stored_options1 & 0x40) == 0x40) {
        pSocket->nDataLeft = 0;
        pSocket->nState = STATE_NULL;
      }
#endif // RESPONSE_LOCK_SUPPORT == 1

#if RESPONSE_LOCK_SUPPORT == 1
      else {
#endif // RESPONSE_LOCK_SUPPORT == 1
      // Send a 200 response with length 0
      uip_send(uip_appdata, CopyHttpHeader(uip_appdata, 0, HEADER200));
      // Clear nDataLeft and go to STATE_SENDDATA, but only to close
      // connection.
      pSocket->nDataLeft = 0;
      pSocket->nState = STATE_SENDDATA;
#if RESPONSE_LOCK_SUPPORT == 1
      }
#endif // RESPONSE_LOCK_SUPPORT == 1
      return;
    }
    
    if (pSocket->nState == STATE_SENDHEADER429) {
      // This is a special case where two GET requests have arrived in
      // parallel from two different Browsers (or Tabs). We can only allow one
      // at a time, so the second arrival is rejected with a 429 response.
      // The 429 response has no webpage response (just a 429 header with
      // Content-Length = 0 and Retry-After set to 10 seconds).
      uip_send(uip_appdata, CopyHttpHeader(uip_appdata, 0, HEADER429));
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

#if DEBUG_SUPPORT == 15
// Debug notes:
// This debug needs to be kept for looking into problems with delays in
// browser updates and browser lockups.
if (rexmit_count == 0) UARTPrintf("\r\n");
rexmit_count++;
UARTPrintf("Re-xmit count = ");
emb_itoa(rexmit_count, OctetArray, 10, 5);
UARTPrintf(OctetArray);
UARTPrintf("\r\n");
#endif // DEBUG_SUPPORT == 15

    if (pSocket->nPrevBytes == 0xFFFF) {
      // Send header again
      uip_send(uip_appdata, CopyHttpHeader(uip_appdata, adjust_template_size(pSocket), HEADER200));
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



#if BUILD_SUPPORT == BROWSER_ONLY_BUILD || BUILD_SUPPORT == MQTT_BUILD
void parsepost(struct tHttpD* pSocket, char *pBuffer, uint16_t nBytes) {
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
  char temp_char;
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
    // Some operating notes:
    // a) The local_buf will only contain COMPLETE POST components. No
    //    partials or fragments.
    // b) Any time the local_buf is sent for parsing the first POST component
    //    in the local_buf will never have an & at the start of the component.
    //    All other components in the local_buf that follow the first one
    //    always start with an &.
    // c) When data is copied from the uip_buf to the parse_tail the & is
    //    also copied into the parse_tail so that we will know we've started
    //    copying a new POST component. But at the end of the loop the & is
    //    removed.
    local_buf[i] = *pBuffer;
    local_buf[i+1] = '\0';
    parse_tail[j] = *pBuffer;
    parse_tail[j+1] = '\0';
    temp_char = *pBuffer;
    pBuffer++;
    nBytes--;
    i++;
    j++;

#if DEBUG_SUPPORT == 15
// Debug notes:
// Turn on this debug to see the character by character parsing of the
// incoming packet into the local_buf and parse_tail.
// IWDG_KR = 0xaa;   // Prevent the IWDG hardware watchdog from firing.
// UARTPrintf("\r\n");
// UARTPrintf("local_buf = ");
// UARTPrintf(local_buf);
// UARTPrintf("   parse_tail = ");
// UARTPrintf(parse_tail);
// UARTPrintf("   nBytes = ");
// emb_itoa(nBytes, OctetArray, 10, 3);
// UARTPrintf(OctetArray);
// UARTPrintf("\r\n");
#endif // DEBUG_SUPPORT == 15
    
    if (nBytes == 0) {
      // We just added a character from the incoming stream to both parse_tail
      // and the local_buf, AND nBytes = zero indicating we hit end of packet.

#if DEBUG_SUPPORT == 15
// UARTPrintf("\r\n");
// UARTPrintf("Hit end of packet with nBytes zero\r\n");
#endif // DEBUG_SUPPORT == 15

      if (strcmp(parse_tail, "z00=0") == 0) {

#if DEBUG_SUPPORT == 15
// UARTPrintf("\r\n");
// UARTPrintf("This is also end of the POST z00 detected\r\n");
#endif // DEBUG_SUPPORT == 15

        // If this is the end of the POST (as indicated by parse_tail equal to
	// "z00=0") then send the entire local_buf to parsing.
	parse_local_buf(pSocket, local_buf, strlen(local_buf));
        break;
      }
      
      else {
        // We don't have all the POST data - it will be arriving in
        // subsequent packets
        //
        // There can be one of four cases at this point:
        //   1) Case 1: We encountered an end of packet after receiving only a
	//      part of the first POST component (didn't get the '&' at the
	//      end of the POST component yet). This can be detected by find-
	//      ing that the first character of local_buf is not a '&' AND
	//      the length of the local_buf and parse_tail are the same. In
	//      this case we simply break out of the while() loop without
	//      parsing the local_buf, as there is no complete POST component
	//      in the local_buf. Breaking out of the while() loop causes the
	//      partial POST component to be saved in parse_tail for restor-
	//      ation when more data is received.
	//   2) Case 2: We have at least one complete POST component stored in
	//      the local_buf, but encountered an end of packet part way
	//      through a subsequent POST component. In that case the partial
	//      POST component is saved in the parse_tail, the local_buf
	//      terminator is positioned at the end of the last complete POST
	//      component received, the completely received POST components in
	//      the local_buf are sent to parsing, and we break out of the
	//      while() loop so that more POST data can be received. Note that
	//      this process eliminates one '&' from parsing, so the
	//      nParseLeft value must be decremented by one to account for the
	//      eliminated '&'.
	//   3) Case 3: Similar to case 2, we have at least one complete POST
	//      component stored in the local_buf, but encountered an end of
	//      packet concurrent with the '&' that starts the next POST
	//      component. In that case the parse_tail will be set to zero
	//      length, the local_buf terminator is positioned at the end of
	//      the last complete POST component received, the completely
	//      received POST components in the local_buf sent to parsing, and
	//      we break out of the while() loop so that more POST data can be
	//      received. Note that this process eliminates one '&' from pars-
	//      ing, so the nParseLeft value must be decremented by one to
	//      account for the eliminated '&'. The same code processes case 2
	//      and 3.
	//   4) Case 4: An end of packet is encountered on the character that
	//      preceeds a '&'. The implication is that the next packet will
	//      begin with an '&' character. In this case the POST component
	//      being received will be treated as if it were incomplete just
	//      like Case 2. This is processed by the same code that handles
	//      Case 2 and 3.

        // Handle case 1
	if ((local_buf[0] != '&') && (strlen(local_buf) == strlen(parse_tail))) {

#if DEBUG_SUPPORT == 15
// UARTPrintf("\r\n");
// UARTPrintf("Handle case 1\r\n");
#endif // DEBUG_SUPPORT == 15

	  break;
	}
	
	// Handle case 2, 3, and 4
        else {

#if DEBUG_SUPPORT == 15
// UARTPrintf("\r\n");
// UARTPrintf("Handle case 2, 3, 4\r\n");
#endif // DEBUG_SUPPORT == 15

          // Back up the NULL terminator in the local_buf to the point where
          // the last POST component ended, leaving the '&' that starts the
	  // next POST component in the local_buf. This is necessary because
	  // POST parsing needs the '&' to find the end of a POST component.
	  // Also, if the parse_tail only contains a & the parse_tail length
	  // becomes zero.
          i = i - strlen(parse_tail);
          local_buf[i] = '\0';
          
#if DEBUG_SUPPORT == 15
// Debug notes:
// Turn on this debug to verify that the local_buf is terminated after a '&'
// delimiter, and that the parse_tail contains part of the next POST compon-
// ent.
// UARTPrintf("\r\n");
// UARTPrintf("End case 2, 3, 4. local_buf = ");
// UARTPrintf(local_buf);
// UARTPrintf("   Parse tail = ");
// UARTPrintf(parse_tail);
// UARTPrintf("\r\n");
#endif // DEBUG_SUPPORT == 15

          // Parse the local_buf
          parse_local_buf(pSocket, local_buf, strlen(local_buf));
          break;
        }
      }
    }
	
    if (i == local_buf_index_max) {
      // Hit end of local_buf
      // We don't yet have all the data from this packet but need to
      // parse what we have so far.
      // The local_buf only contains POST data, and we can't hit the
      // end of the local_buf unless multiple POST components have been
      // collected, so no need to handle special cases like receiving a
      // partial first POST component.
      //
      // Back up the NULL terminator in the local_buf to the point where
      // the last POST component ended, leaving the '&' that starts the
      // next POST component in the local_buf. This is necessary because
      // POST parsing needs the '&' to find the end of a POST component.
      // Also, if the parse_tail only contains a & the parse_tail length
      // becomes zero.

      i = i - strlen(parse_tail);
      local_buf[i] = '\0';
      
#if DEBUG_SUPPORT == 15
// Debug notes:
// Turn on this debug to verify that the local_buf is terminated after a '&'
// delimiter, and that the parse_tail contains part of the next POST compon-
// ent.
// UARTPrintf("\r\n");
// UARTPrintf("Hit local_buf_index_max. local_buf = ");
// UARTPrintf(local_buf);
// UARTPrintf("   Parse tail = ");
// UARTPrintf(parse_tail);
// UARTPrintf("\r\n");
#endif // DEBUG_SUPPORT == 15

      // Parse the local_buf
      parse_local_buf(pSocket, local_buf, strlen(local_buf));
      
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
    
    if (temp_char == '&') {
      // Starting a new POST component collection.
      // Reset j so the parse_tail will fill with the new POST component (less
      // the & ). The previous POST component (including the & if it had one)
      // is stored as received in the local_buf.
      j = 0;
      parse_tail[0] = '\0';
      continue;
    }
  }
  return;
}
#endif // BUILD_SUPPORT == BROWSER_ONLY_BUILD || BUILD_SUPPORT == MQTT_BUILD



#if BUILD_SUPPORT == BROWSER_ONLY_BUILD || BUILD_SUPPORT == MQTT_BUILD
void parse_local_buf(struct tHttpD* pSocket, char* local_buf, uint16_t lbi_max)
{
  uint16_t lbi;             // Local buffer index
  uint8_t parse_error;      // Parsing Error indicator
  uint8_t login_successful; // Indicates a successful Host login

  login_successful = 0;

#if DEBUG_SUPPORT == 15
// UARTPrintf("start parse_local_buf\r\n");
#endif // DEBUG_SUPPORT == 15

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
    
  // There is a chicken and egg problem with regard to knowing apriori what
  // value to set the pSocket->nParseLeft to in order to know how many 
  // characters in total are to be parsed in the incoming POST. nParseLeft
  // should be set to the one of these values:
  //   PARSEBYTES_CONFIGURATION
  //   PARSEBYTES_PCF8574_CONFIGURATION
  //   PARSEBYTES_IOCONTROL
  //   or PARSEBYTES_PCF8574_IOCONTROL
  // However, on first entering the POST parsing process it is not known what
  // webpage sent the POST that is being received. The code can determine the
  // source of the POST by examining the first four characters received which
  // consist of the first CMD, NUMMSD, NUMLSD, and EQUAL sign characters. By
  // design the POSTs start with known character sequences as follows:
  //   a00= inidcates we should use PARSEBYTES_CONFIGURATION to set nParseLeft
  //   A00= indicates we should use PARSEBYTES_PCF8574_CONFIGURATION
  //   h00= indicates we should use PARSEBYTES_IOCONTROL
  //   H00= indicates we should use PARSEBYTES_PCF8574_IOCONTROL
  // Parsing the first four characters before setting nParseLeft means we have
  // to subtract 4 from the PARSEBYTES_xxx value when nParseLeft is set.
  // All other CMD, NUMMSD, NUMLSD, EQUAL sequences arrive after nParseLeft
  // has been set so the appropriate number of characters will be subtracted
  // as are parsed. Just be aware that the nParseLeft value is deliberately
  // modified on receipt of a00=, A00=, h00=, or H00=.

  // When we parse the local_buf we always start in state PARSE_CMD
  pSocket->ParseState = PARSE_CMD;

  lbi = 0;         // local_buf index
  parse_error = 0; // Clear the Parsing Error indicator
  
  while(1) {
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
      

#if DEBUG_SUPPORT == 15
//UARTPrintf("ParseCmd = ");
//emb_itoa(pSocket->ParseNum, OctetArray, 16, 2);
//UARTPrintf(OctetArray);
//UARTPrintf("   Parsenum = ");
//emb_itoa(pSocket->ParseNum, OctetArray, 10, 2);
//UARTPrintf(OctetArray);
//UARTPrintf("\r\n");
#endif // DEBUG_SUPPORT == 15

      // 'a' and 'A' is POST data for the Device Name
      // 'b'         is POST data for the IP/Gateway/Netmask/MQTT Host IP address
      // 'c'         is POST data for the Port number
      // 'd'         is POST data for the MAC
      // 'g'         is POST data for the Config settings string
      // 'h' and 'H' is POST data for the Pin Control String
      // 'i' and 'I' is POST data for the IO Timers
      // 'j' and 'J' is POST data for the IO Names
      // 'l'         is POST data for the MQTT Username or Login ID
      // 'm'         is POST data for the MQTT Password or Login PW
      // 'T'         is POST data for the IDX values (Domoticz Sensor)
      // 'z'         is POST data for used as an end-of-POST indicator
      
      // Parse 'a' 'A' 'l' 'm' 'j' 'J' 'T' ---------------------------------//
      if (pSocket->ParseCmd == 'a'
       || pSocket->ParseCmd == 'A'
       || pSocket->ParseCmd == 'l'
       || pSocket->ParseCmd == 'm'
       || pSocket->ParseCmd == 'j'
       || pSocket->ParseCmd == 'J'
       || pSocket->ParseCmd == 'T' ) {
        // a = Update the Device Name field
        // A = Update the Device Name field (PCF8574)
        // l = Update the MQTT Username field or Login Passphrase
        // m = Update the MQTT Password field
        // j = Update the IO Name field
        // J = Update the IO Name field (PCF8574)
        // T = Update the IDX field (Domoticz Sensor)
        
	// Notes on the "current_webpage" logic.
	// When parsing a POST we need to know if the POST came from a
	// IOControl page or from a Configuation page. This can be determined
	// from the first POST variable returned. The following applies:
	// a) On entry to the process current_webpage is set to WEBPAGE_NULL.
	// b) The IOControl page always starts with a 'h' ParseCmd if a
	//    IOControl for the IO on the STM8 device, OR it starts with a "H"
	//    ParseCmd if a IOControl for the PCF8574. If current_webpage is
	//    WEBPAGE_NULL we set the current_webpage to WEBPAGE_IOCONTROL if
	//    a 'h' ParseCmd, OR WEBPAGE_PCF8574_IOCONTROL if a 'H' ParseCmd.
	// c) The Configuration page starts with a 
	//      'a' ParseCmd if a top level Configuration page
	//      'A' ParseCmd if a Configuration for the PCF8574
	//      'l' ParseCmd if a Login page
	// Since the IOControl pages never return a 'a', 'A', or 'l' ParseCmd
	// as the first POST returned we are assured the we are at the start
	// of receiving a POST from a Configuration or Login page.
        // XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
        // XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
        // XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
	// The above seems a bit clunky. Need a better way of determining
	// what page sent the POST. One part of the "clunky" is that I have
	// the DeviceName as an edit field in the PCF8574 Configuration page,
	// but only so that it is a POST value to allow me to detect the
	// PCF8574 Configuration page as the data source. Must be a better
	// way. I would like to find a way to return a POST value without
	// having it display on the page.
        // XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
        // XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
        // XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX

	// Notes on the "current_webpage" logic.
	// If we got to this point and current_webpage == WEBPAGE_NULL then we
	// know we have not yet determined the source page for the the POST.
	//   If the first element of the POST is 'a' the source page is a
	//   WEBPAGE_CONFIGURATION.
	//   If the first element of the POST is 'A' the source page is a
	//   WEBPAGE_PCF8574_CONFIGURATION.
	//   If the first element of the POST is 'l' the source page is a
	//   WEBPAGE_LOGIN.
	if (pSocket->current_webpage == WEBPAGE_NULL) {
          if (pSocket->ParseCmd == 'a') {
            pSocket->current_webpage = WEBPAGE_CONFIGURATION;
            pSocket->nParseLeft = PARSEBYTES_CONFIGURATION - 4;
	  }

#if PCF8574_SUPPORT == 1
#if BUILD_SUPPORT == BROWSER_ONLY_BUILD || HOME_ASSISTANT_SUPPORT == 1
          if (pSocket->ParseCmd == 'A') {
            pSocket->current_webpage = WEBPAGE_PCF8574_CONFIGURATION;
            pSocket->nParseLeft = PARSEBYTES_PCF8574_CONFIGURATION - 4;
	  }
#endif // BUILD_SUPPORT == BROWSER_ONLY_BUILD || HOME_ASSISTANT_SUPPORT == 1
#endif // PCF8574_SUPPORT == 1

#if BUILD_SUPPORT == BROWSER_ONLY_BUILD && LOGIN_SUPPORT == 1
          if (pSocket->ParseCmd == 'l') {
            pSocket->current_webpage = WEBPAGE_LOGIN;
            pSocket->nParseLeft = PARSEBYTES_LOGIN - 4;
	  }
#endif // BUILD_SUPPORT == BROWSER_ONLY_BUILD && LOGIN_SUPPORT == 1
        }

        {
          int i;
          uint8_t amp_found;
          char tmp_Pending[52];
          int num_chars;
	  
	  num_chars = 0; // Max number of characters in string
          
          switch (pSocket->ParseCmd) {
            case 'a':
            case 'A':
	      num_chars = 19;
	      break;
            case 'l':
            case 'm':
#if LOGIN_SUPPORT == 0
              num_chars = 10;
#endif // LOGIN_SUPPORT == 0
#if LOGIN_SUPPORT == 1
              if (pSocket->ParseNum == 0) num_chars = 10; // MQTT Username and Password
              if (pSocket->ParseNum == 1) num_chars = 15; // Stored Login Passphrase
              if (pSocket->ParseNum == 2) num_chars = 15; // Incoming Login Passphrase
#endif // LOGIN_SUPPORT == 1
	      break;
            case 'j':
#if DOMOTICZ_SUPPORT == 0
	      num_chars = 15;
#endif // DOMOTICZ_SUPPORT == 0
#if DOMOTICZ_SUPPORT == 1
	      num_chars = 6;
#endif // DOMOTICZ_SUPPORT == 1
	      break;
            case 'J':
	      num_chars = 15;
	      break;
            case 'T':
	      num_chars = 6;
	      break;
          }
          
          // This function processes POST data for one of several string fields:
          //   Device Name field
          //   MQTT Username field
          //   MQTT Password field
	  //   Login Passphrase field
          //   IO Name field
	  //   Sensor IDX field
          //
          // POST data for strings are a special case case in that the resulting
          // string can consist of anything from 0 to X number of characters. So, we
          // have to parse until the POST delimiter '&' is found.
          //
          amp_found = 0;
          memset(tmp_Pending, '\0', 20);

          for (i = 0; i < num_chars; i++) {
            // Collect characters until num_chars are collected or '&' is
	    // found.
            if (amp_found == 0) {
              // Collect a byte of the devicename from the local_buf until the
	      // '&' is found.
              if (local_buf[lbi] == '&') {
	        amp_found = 1;
		// Don't increment lbi within this "If" ... that will be done
		// within the PARSE_DELIM state.
	      }
              else {
                tmp_Pending[i] = local_buf[lbi];
                pSocket->nParseLeft--;
                lbi++;
              }
            }
            if (amp_found == 1) {
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

	  // Increment num_chars and terminate the received string with NULL.
	  // This will assure the memcmp comparisons of strings also check
	  // the terminator position.
	  num_chars++;
	  tmp_Pending[num_chars] = '\0';

/*
#if LOGIN_SUPPORT == 1
	  // Remove URL encoding from tmp_Pending. URL encoding is also called
	  // "percent encoding" because the '%' character is used to identify
	  // a three character representation of characters. As an example,
	  // %3F is the '?' character. The '%' character should not appear
	  // anywhere in a received tmp_Pending string except as part of a URL
	  // encoded character.
	  // These characters are encoded
	  // ! = %21
	  // # = %23
	  // $ = %24
	  // : = %25
	  // & = %26
	  // + = %2B
	  // ? = %3F
	  // @ = %40
	  // 
	  // These characters are not encoded
	  // - dash
	  // _ underbar
	  // * asterisk
	  // . period
	  {
	    int i;
	    uint8_t j;
	    char special_chars[] = "! #$:&    +                   ?@";
	    for (i = 0; i < strlen(tmp_Pending); i++) {
	      if (tmp_Pending[i] == '%') {
	        j = two_hex2int(tmp_Pending[i+1], tmp_Pending[i+2]);
		tmp_Pending[i] = special_chars[j - 0x21];

#if DEBUG_SUPPORT == 15
{
char temp[2];
UARTPrintf("Removing URL Encoding. j = ");
emb_itoa(j, OctetArray, 10, 2);
UARTPrintf(OctetArray);
temp[0] = tmp_Pending[i];
temp[1] = '\0';
UARTPrintf("   tmp_Pending = ");
UARTPrintf(temp);
UARTPrintf("\r\n");
}
#endif // DEBUG_SUPPORT == 15

		{
		  int k;
		  int m;
		  k = i+1;
		  m = i+3;
		  strcpy(&tmp_Pending[k], &tmp_Pending[m]);
		}
		i+=3;
//		num_chars -= 2;
	      }
	    }
	  }
#endif // LOGIN_SUPPORT == 1
*/

	  unlock_eeprom();
	  unlock_flash();
          switch (pSocket->ParseCmd)
	  {
	    case 'a':
	    case 'A':
	      // This is an update to the Devicename.
	      // The EEPROM is written and a restart request generated only
	      // if the value changed.
              if (memcmp(stored_devicename, tmp_Pending, num_chars) != 0) {
	        memcpy(stored_devicename, tmp_Pending, num_chars);
	        user_restart_request = 1;
	      }
	      break;
	      
	    case 'l':
	      // This is an update to the MQTT Username or Login Passphrase
#if LOGIN_SUPPORT == 0
	      // The EEPROM is written and a restart request generated only
	      // if the value changed.
              if (memcmp(stored_mqtt_username, tmp_Pending, num_chars) != 0) {
	        memcpy(stored_mqtt_username, tmp_Pending, num_chars);
	        user_restart_request = 1;
	      }
#endif // LOGIN_SUPPORT == 0
#if LOGIN_SUPPORT == 1
              if (pSocket->ParseNum == 0) {
	        // MQTT Username received
	        // The EEPROM is written and a restart request generated
		// only if the value changed.
                if (memcmp(stored_mqtt_username, tmp_Pending, num_chars) != 0) {
	          memcpy(stored_mqtt_username, tmp_Pending, num_chars);
	          user_restart_request = 1;
	        }
	      }

              if (pSocket->ParseNum == 1) {
	        // Required Login Passphrase received.
	        // This element is provided in a POST from the Set Passphrase
		// webpage to set the Login Passphrase.

	        char temp_string[16];
		uint8_t no_change;
		uint8_t value;
		
		no_change = 0;
		
		// First determine if the Passphrase changed.
                copy_I2C_EEPROM_bytes_to_RAM(&temp_string[0], 16, I2C_EEPROM_R1_WRITE, I2C_EEPROM_R1_READ, I2C_EEPROM_R1_LOGIN_PASSPHRASE, 2);
                if (memcmp(temp_string, tmp_Pending, num_chars) == 0) {
		  no_change = 1;
		}
	        // Since this function only occurs as a result of action from
		// the user the I2C EEPROM is now written regardless of a
		// change.
                copy_STM8_bytes_to_I2C_EEPROM(&tmp_Pending[0], 16, I2C_EEPROM_R1_WRITE, I2C_EEPROM_R1_LOGIN_PASSPHRASE, 2);
	        
#if DEBUG_SUPPORT == 15
UARTPrintf("Passphrase set >");
UARTPrintf(tmp_Pending);
UARTPrintf("<\r\n");
#endif // DEBUG_SUPPORT == 15

                if (no_change == 1) {
		  // If the Passphrase did not change display the
		  // Configuration page.
	          login_successful = 3;
		}
		else if (tmp_Pending[0] != 0) {
	          // If the Passphrase changed and it is not blank enable the
		  // Login function
	          value = stored_options2;
	          value |= 0x40;
	          // Update the stored_option2 value in EEPROM.
                  update_settings_options(UPDATE_OPTIONS2, value);
	          login_successful = 2; // Signal to display the Login page
		}
		else {
		  // The Passphrase is blank so disable the Login function.
	          value = stored_options2;
	          value &= (uint8_t)~0x40;
	          // Update the stored_options2 value in EEPROM.
                  update_settings_options(UPDATE_OPTIONS2, value);
	          login_successful = 3; // Signal to display the Configuration
		                        // page
		}
              }
        
              if ((pSocket->ParseNum == 2) && (stored_options2 & 0x40 == 0x40)) {
	        // Incoming Login Passphrase received
	        // This element is provided in a POST when a Browser is
		// attempting to log into the Network Module with a
		// Passphrase.
		// The following notes apply:
		// Note 1: If a Login POST is received then the host sending
		//   the POST is not currently logged in except in the case
		//   where a user is attempting Login from two different
		//   Browsers on the same host and one of the Browsers was
		//   already successfully logged in before the other sent it's
		//   POST.
		// Note 2: A host that is not logged in might be in the
		//   ripaddr_table for purposes of tracking failed login
		//   attempts.
		// Note 3: It is possible that a Browser has the Login page
		//   displayed but another Browser just now disabled the Login
		//   function. In that case this POST is ignored and the
		//   IOControl page is displayed.
		//
		// a) If a POST is received scan the table to see if the host is
		//    already in the table. If it is then:
		//    a1) If the passphrase failed then update the failed attempts
		//        counter for the host. If failed attempts > max set the
		//        lockout timer and remove the host from the table. This
		//        creates a Denial Of Service problem but not sure what can be done.
		//    a2) If the passphrase matches then refresh the ripaddr_table
		//        entry to mark the host as logged in and refresh the timeouts.
		// b) If not handled by (a):
		//    b1) If POST is received scan the table and add the host
		//        if there is an empty slot. This must be done even if
		//        the passphrase failed (in which case the login
		//        tracker starts counting failures).
		//    b2) If the passphrase matched the ripaddr_table is
		//        marked as logged in.
		//    b3) If there is no empty slot the host is ignored.

                {
                  char temp_string[16];
                  char required_passphrase[16];
		  uint8_t passphrase_match;
	          int ripaddr_index;
	          uint32_t temp32_ripaddr;
		  
                  // Convert uip_conn->ripaddr to unit32_t. This identifies
		  // the IP address of the host that sent the POST.
	          uip_ipaddr_t *uip_ptr;
	          uip_ptr = &uip_conn->ripaddr;
	          temp32_ripaddr = (*uip_ptr)[0];
	          temp32_ripaddr <<= 16;
	          temp32_ripaddr |= (*uip_ptr)[1];
		  
		  passphrase_match = 0;
		  
		  // Collect the stored Passphrase from I2C EEPROM
                  copy_I2C_EEPROM_bytes_to_RAM(&required_passphrase[0], 16, I2C_EEPROM_R1_WRITE, I2C_EEPROM_R1_READ, I2C_EEPROM_R1_LOGIN_PASSPHRASE, 2);

#if DEBUG_SUPPORT == 15
UARTPrintf("Received Login Attempt\r\n");
UARTPrintf("Required Passphrase = >");
UARTPrintf(required_passphrase);
UARTPrintf("<\r\n");
UARTPrintf("Received Passphrase = >");
UARTPrintf(tmp_Pending);
UARTPrintf("<\r\n");
#endif // DEBUG_SUPPORT == 15

		  // Validate the Passphrase
//		  if (memcmp(required_passphrase, tmp_Pending, num_chars) == 0) {
		  if (strcmp(required_passphrase, tmp_Pending) == 0) {
		    // The Passphrase matched.

#if DEBUG_SUPPORT == 15
// UARTPrintf("Passphrase Matched\r\n");
#endif // DEBUG_SUPPORT == 15

		    passphrase_match = 1;
		  }
		  else {
#if DEBUG_SUPPORT == 15
// UARTPrintf("Passphrase Failed\r\n");
#endif // DEBUG_SUPPORT == 15
                  }
		  
	          // Search ripaddr table to determine if this remote host is known
		  ripaddr_index = check_login_status();

	          if (ripaddr_index >= 0 && passphrase_match == 0) {
		    // Found an existing ripaddr_table entry for this host
		    // but an incorrect Passphrase was entered. This case
		    // can occur if a previous Host login attempt was made
		    // but failed. Now we're seeing another failed attempt.
		    // Update the ripaddr_table to count the invalid
		    // Passphase attempts.
		    // Make sure the "logged in" indicator is removed.
		    Login_Tracker[ripaddr_index] &= 0x7f;
		    // Increment the failed attempts counter.
		    Login_Tracker[ripaddr_index]++;
		    // Check if the invalid entry exceeds the number of
		    // attempts allowed.
		    if ((Login_Tracker[ripaddr_index] & 0x07) > 3) {
		      // Number of Login attempts exceeded. All connections
		      // are to be cancelled.
		      // Zero out the ripaddr table (four 32 bit values)
                      memset(ripaddr_table, 0, 16);
                      // Set Auto Log Out Timers to 0.
                      memset(Auto_Log_Out_Timer, 0, 4);
                      // Clear the Login Indicators and Login Attempt Counters.
                      memset(Login_Tracker, 0, 4);
                      // Set Response_Lockout_Cancel_Timer to 15 min.
                      Response_Lockout_Cancel_Timer = 15;
	              // Set Response Lockout bit in EEPROM.
                      update_settings_options(UPDATE_OPTIONS1, (uint8_t)(stored_options1 | 0x40));
		      login_successful = 0; // No page will be displayed.
		    }
		    else {
		      login_successful = 2; // Signal to repaint Login page
		    }
		  }
		
	          if (ripaddr_index >= 0 && passphrase_match == 1) {
	            // Found an existing ripaddr_table entry for this host
		    // and the Passphrase matched. This might happen if a
		    // second Browser on the same host logs in because it
		    // already had a Login screen without knowing that
		    // another Browser was also logging in.
		    // Update the ripaddr_table to keep the host logged in.
	            Auto_Log_Out_Timer[ripaddr_index] = 15;
		    Login_Tracker[ripaddr_index] = 0x80;
		    login_successful = 1; // Signal to paint IOControl page
		  }
		  
	          if (ripaddr_index == -1) {
		    // Host was not found in the ripaddr table. Regardless of
		    // whether the Passphrase matched code should look for an
		    // empty slot in the ripaddr_table and attempt to add this
		    // new host. The uip code should have already rejected a
		    // connection attempt if the max number of connections has
		    // already been made.
		    //
		    // The host will be added to the ripaddr_table even if
		    // the Passphrase did not match. This is to allow rejection
		    // of too many attempts from a given host.
		    //
	            // If a Browser Only build the ripaddr table can have up to 4
	            // entries.
                    // If a MQTT built the ripaddr table can only have 3 entries.
#if BUILD_SUPPORT == BROWSER_ONLY_BUILD
	            for (ripaddr_index = 0; ripaddr_index < 4; ripaddr_index++) {
#endif // BUILD_SUPPORT == BROWSER_ONLY_BUILD
#if BUILD_SUPPORT == MQTT_BUILD
	            for (ripaddr_index = 0; ripaddr_index < 3; ripaddr_index++) {
#endif // BUILD_SUPPORT == MQTT_BUILD
	              if (ripaddr_table[ripaddr_index] == 0) {

#if DEBUG_SUPPORT == 15
// UARTPrintf("Adding Host to ripaddr_table\r\n");
#endif // DEBUG_SUPPORT == 15

		        // Found an empty slot. Add the host.
	                ripaddr_table[ripaddr_index] = temp32_ripaddr;
		        // Initialize timers for new connection.
	                Auto_Log_Out_Timer[ripaddr_index] = 15;
		        if (passphrase_match == 1) {
			  // Mark the "host logged in" tracker.
		          Login_Tracker[ripaddr_index] = 0x80;
			  login_successful = 1; // Signal to paint IOControl page

#if DEBUG_SUPPORT == 15
// UARTPrintf("Adding Host   Login_Tracker = ");
// emb_itoa(Login_Tracker[ripaddr_index], OctetArray, 16, 2);
// UARTPrintf(OctetArray);
// UARTPrintf("\r\n");
#endif // DEBUG_SUPPORT == 15

	                }
		        else {

#if DEBUG_SUPPORT == 15
// UARTPrintf("Incrementing Login Tracker\r\n");
#endif // DEBUG_SUPPORT == 15

			  // Increment the "attempted login" counter.
		          Login_Tracker[ripaddr_index]++;
			  login_successful = 2; // Signal to repaint Login page
	                }
		        break; // Break out of for loop
		      }
		    }
		  }
		}
	        user_restart_request = 1;
	      }
              if ((pSocket->ParseNum == 2) && (stored_options2 & 0x40 == 0)) {
	        // If a Browser sent a Login request but the Login function is
		// disabled then it is likely that a different Browser
		// disabled the Login function. In this case the IOControl
		// page will be displayed.
		login_successful = 1; // Signal to paint IOControl page
	      }
#endif // LOGIN_SUPPORT == 1
	      break;
		  
	      
	    case 'm':
	      // This is an update to the MQTT Password
	      // The EEPROM is written and a restart request generated only
	      // if the value changed.
              if (memcmp(stored_mqtt_password, tmp_Pending, num_chars) != 0) {
	        memcpy(stored_mqtt_password, tmp_Pending, num_chars);
	        user_restart_request = 1;
	      }
	      break;
	      
#if BUILD_SUPPORT == BROWSER_ONLY_BUILD
	    case 'j':
	      if (strcmp(IO_NAME[pSocket->ParseNum], tmp_Pending) != 0) {
	        // IO_NAME in Flash is updated only if it changed.
	        // The write to Flash will occur 4 bytes at a time to
		// reduce Flash wear. All 16 bytes reserved in the Flash
		// for a given IO Name will be written at one time in a
		// sequence of 4 byte "word" writes.
	        i = 0;
	        while(i<16) {
                  // Enable Word programming
                  FLASH_CR2 |= FLASH_CR2_WPRG;
                  FLASH_NCR2 &= (uint8_t)(~FLASH_NCR2_NWPRG);
		  // Write word to Flash
	          memcpy(&IO_NAME[pSocket->ParseNum][i], &tmp_Pending[i], 4);
		  // No "wait_timer" is needed. The spec says the CPU stalls
		  // while the word programming operates (takes about 6ms).
	          i += 4;
	        }
              }
	      break;
	      
#if PCF8574_SUPPORT == 1
	    case 'J':
	      // 'J' indicates an IO_NAME for a PCF8574 pin. These are stored
	      // in I2C EEPROM.
              // There is not much concern for I2C EEPROM write wearout, so
	      // the name is written regardless of whether is it already the
	      // same. This saves code space in Flash.
              copy_STM8_bytes_to_I2C_EEPROM(&tmp_Pending[0], 16, I2C_EEPROM_R2_WRITE, PCF8574_I2C_EEPROM_R2_START_IO_NAMES + ((pSocket->ParseNum - 16) * 16), 2);
	      break;
#endif // PCF8574_SUPPORT == 1
#endif // BUILD_SUPPORT == BROWSER_ONLY_BUILD
	      



#if DOMOTICZ_SUPPORT == 1
	    case 'j':
	      // These are the IO_NAMEs repurposed for use as IDX values.
	      // For ParseNum 0 to 15 these are written to Flash but only if
	      // the value changed.
	      // For ParseNum 16 to 23 these are written to I2C Flash even
	      // if the value did not change.
	      // Note that even though an IDX value is only 6 bytes the full
	      // 16 bytes reserved for the IO_NAME is written.
	      if (pSocket->ParseNum < 16) {
	        if (strcmp(IO_NAME[pSocket->ParseNum], tmp_Pending) != 0) {
	          // The write to Flash will occur 4 bytes at a time to
		  // reduce Flash wear. All 16 bytes reserved in the Flash
		  // for a given IO Name will be written at one time in a
		  // sequence of 4 byte "word" writes.
	          i = 0;
	          while(i<16) {
                    // Enable Word programming
                    FLASH_CR2 |= FLASH_CR2_WPRG;
                    FLASH_NCR2 &= (uint8_t)(~FLASH_NCR2_NWPRG);
		    // Write word to Flash
	            memcpy(&IO_NAME[pSocket->ParseNum][i], &tmp_Pending[i], 4);
		    // No "wait_timer" is needed. The spec says the CPU stalls
		    // while the word programming operates (takes about 6ms).
	            i += 4;
	          }
                }
#if DEBUG_SUPPORT == 15
// UARTPrintf("\r\n");
// UARTPrintf("parse_post IO_NAME = ");
// UARTPrintf(IO_NAME[pSocket->ParseNum]);
// UARTPrintf("\r\n");
#endif // DEBUG_SUPPORT == 15
	      }

	      if (pSocket->ParseNum > 15) {
	        // If PCF8574 is supported it implies that the I2C EEPROM is
		// present. In that case the received values are written to
		// the I2C EEPROM. If PCF8574 is not supported nothing needs
		// to be done with the received value.
#if PCF8574_SUPPORT == 1
                // There is not much concern for I2C EEPROM write wearout, so
	        // the name is written regardless of whether is it already the
	        // same. This saves code space in Flash.
                copy_STM8_bytes_to_I2C_EEPROM(&tmp_Pending[0], 16, I2C_EEPROM_R2_WRITE, PCF8574_I2C_EEPROM_R2_START_IO_NAMES + ((pSocket->ParseNum - 16) * 16), 2);
#endif // PCF8574_SUPPORT == 1
	      }
              break;
#endif // DOMOTICZ_SUPPORT == 1



#if DOMOTICZ_SUPPORT == 1
	    case 'T':
	      // 'T' indicates an IDX value for a Sensor. These are stored in
	      // Flash. Flash is updated only if the value changed. Flash is
	      // written 4 bytes at a time. Note that even though the IDX
	      // value is limited to 6 bytes the full 8 bytes reserved for
	      // storing the value are written.
	      {
	        int i;
		int j;
	        i = 0;
		tmp_Pending[6] = 0; // Make sure the IDX value is a maximum
		                    // of 6 characters. This helps protect
				    // against stale values in memory when
				    // builds are replaced with different
				    // build types.
		if (pSocket->ParseNum > 19 && pSocket->ParseNum < 26) {
		  j = pSocket->ParseNum - 20;
		  if (strcmp(Sensor_IDX[j], tmp_Pending) != 0) {
	            while(i<8) {
                      // Enable Word programming
                      FLASH_CR2 |= FLASH_CR2_WPRG;
                      FLASH_NCR2 &= (uint8_t)(~FLASH_NCR2_NWPRG);
                      // Write word to Flash
	              memcpy(&Sensor_IDX[j][i], &tmp_Pending[i], 4);
		      // No "wait_timer" is needed. The spec says the CPU stalls
		      // while the word programming operates (takes about 6ms).
	              i += 4;
		    }
		  }
	        }
#if DEBUG_SUPPORT == 15
// UARTPrintf("\r\n");
// UARTPrintf("parse_post Sensor_IDX = ");
// UARTPrintf(Sensor_IDX[pSocket->ParseNum - 20]);
// UARTPrintf("\r\n");
#endif // DEBUG_SUPPORT == 15
	      }
	      break;
#endif // DOMOTICZ_SUPPORT == 1

	  } // end of switch
          lock_flash();
	  lock_eeprom();
        }
      }


      // Parse 'b' ------------------------------------------------------//
      else if (pSocket->ParseCmd == 'b') {
        // This code updates the IP address, Gateway address, Netmask, and
	// MQTT Host IP address stored in EEPROM and will request a restart
	// if the value changed.
        // The value following the 'bxx=' ParseCmd and ParseNum consists
        // of eight alpha nibbles representing the value in hex. The
        // function call collects the alpha nibbles and converts them to
	// the numeric value used by the other firmware functions.
        {
          int i;
          int j;
          uint8_t temp;
          
          // The following updates the IP address, Gateway address, NetMask,
	  // and MQTT IP Address based on GUI input.
          // The code converts eight alpha fields with hex alphas ('0' to 'f')
	  // into 4 octets representing the new setting.
            
          // Convert characters of the hex string to numbers two characters
          // at a time and store the result.
          temp = 0;
          i = 0;
          j = 0;
          unlock_eeprom();
          while (i < 8) {
            // Create a number from two hex characters
            temp = two_hex2int(local_buf[lbi], local_buf[lbi+1]);
	    lbi +=2;
            pSocket->nParseLeft -= 2;
	    i += 2;
	    
            j = (8 - i) / 2;
            
	    // The EEPROM is written and a restart is requested ONLY if the
	    // value changed.
            switch(pSocket->ParseNum)
            {
              case 0:
                if (stored_hostaddr[j] != temp) {
		  user_restart_request = 1;
	          stored_hostaddr[j] = temp;
		}
		break;
              case 4:
                if (stored_draddr[j] != temp) {
		  user_restart_request = 1;
	          stored_draddr[j] = temp;
		}
		break;
              case 8:
                if (stored_netmask[j] != temp) {
		  user_restart_request = 1;
	          stored_netmask[j] = temp;
		}
		break;
              case 12:
                if (stored_mqttserveraddr[j] != temp) {
		  user_restart_request = 1;
	          stored_mqttserveraddr[j] = temp;
		}
		break;
              default: break;
            }
          }
          lock_eeprom();
        }
      }


      // Parse 'c' ------------------------------------------------------//
      else if (pSocket->ParseCmd == 'c') {
        // This code updates the HTTP Port number or MQTT Port number stored
	// in EEPROM and will request a restart only if the value changed.
        // ParseNum == 0 indicates the HTTP Port number.
        // ParseNum == 1 indicates the MQTT Port number.
        // The value following the 'cxx=' ParseCmd & ParseNum consists
        // of four alpha nibbles with the port number in hex form. The
        // function call collects the nibbles, validates them, and updates
        // the port number.
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
            unlock_eeprom();
            if (pSocket->ParseNum == 0) {
              if (stored_port != temp) {
	        stored_port = (uint16_t)temp;
	        user_restart_request = 1;
              }
	    }
            else {
              if (stored_mqttport != temp) {
	        stored_mqttport = (uint16_t)temp;
	        user_restart_request = 1;
	      }
	    }
	    lock_eeprom();
          }
        }
      }


      // Parse 'd' ------------------------------------------------------//
      else if (pSocket->ParseCmd == 'd') {
        // This code updates the MAC address stored in EEPROM and will request
	// a reboot only if the value changed.
        // The value following the 'dxx=' ParseCmd and ParseNum consists
        // of twelve alpha nibbles in hex form ('0' to '9' and 'a' to 'f').
        // The function call collects the nibbles, validates them, and
        // updates the MAC number.
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
            // Store result in stored_uip_ethaddr_oct. Note that order is
            // reversed in this variable.
	    if (stored_uip_ethaddr_oct[ (12-i)/2 ] != temp) {
              unlock_eeprom();
	      stored_uip_ethaddr_oct[ (12-i)/2 ] = (uint8_t)temp;
	      lock_eeprom();
	      user_reboot_request = 1;
	      // Reboot will update the ENC28J60.
	    }
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
	  lbi += 2;
          pSocket->nParseLeft -= 2;
        }
      }


#if BUILD_SUPPORT == BROWSER_ONLY_BUILD || HOME_ASSISTANT_SUPPORT == 1
      // Parse 'h' ------------------------------------------------------//
      else if (pSocket->ParseCmd == 'h') {
        // This code sets the Pending_pin_control bytes based on the
        // information in the 32 character string sent in the h00 field.
        //
	// Notes on the "current_webpage" logic.
	// If we got to this point and current_webpage == WEBPAGE_NULL
	// then we know we did not encounter a POST from a 
	// Configuration page so this must be a POST from an IOControl page.
	if (pSocket->current_webpage == WEBPAGE_NULL) {
          pSocket->current_webpage = WEBPAGE_IOCONTROL;
	  pSocket->nParseLeft = PARSEBYTES_IOCONTROL - 4;
	}
	
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
	    lbi += 2;
            pSocket->nParseLeft -= 2;
	    i += 2;

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

#if DEBUG_SUPPORT == 15
// Debug notes:
// Turn on these debug statements to verify that the "h00=" POST component is
// being detected properly. This is an important check to verify that the
// nParseLeft variable is being set properly.
// UARTPrintf("\r\n");
// UARTPrintf("Parsed h command. nParseLeft = ");
// emb_itoa(pSocket->nParseLeft, OctetArray, 10, 3);
// UARTPrintf(OctetArray);
// UARTPrintf("\r\n");
#endif // DEBUG_SUPPORT == 15

      }


#if PCF8574_SUPPORT == 1
      // Parse 'H' ------------------------------------------------------//
      else if (pSocket->ParseCmd == 'H') {
        // This code sets the PCF8574 Pending_pin_control bytes based on the
        // information in the 16 character string POSTed in the H00 field.
        //
	// Notes on the "current_webpage" logic.
	// If we got to this point and current_webpage == WEBPAGE_NULL
	// then we know we did not encounter a POST from a 
	// Configuration page so this must be a POST from an IOControl
	// page.
	if (pSocket->current_webpage == WEBPAGE_NULL) {
          pSocket->current_webpage = WEBPAGE_PCF8574_IOCONTROL;
	  pSocket->nParseLeft = PARSEBYTES_PCF8574_IOCONTROL - 4;
	}
	
        // There are always 32 characters in the string in 16 pairs of
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

#if DEBUG_SUPPORT == 15
// UARTPrintf("Hxx = ");
#endif // DEBUG_SUPPORT == 15


          // Sort the alpha characters into the pin control bytes
          i = 0; // Counter to sort through the 16 hex nibbles
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

#if DEBUG_SUPPORT == 15
// emb_itoa(k, OctetArray, 16, 2);
// UARTPrintf(OctetArray);
// UARTPrintf(" ");
#endif // DEBUG_SUPPORT == 15

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

#if DEBUG_SUPPORT == 15
// UARTPrintf("\r\n");
#endif // DEBUG_SUPPORT == 15

        }

#if DEBUG_SUPPORT == 15
// Debug notes:
// Turn on these debug statements to verify that the "H00=" POST component is
// being detected properly. This is an important check to verify that the
// nParseLeft variable is being set properly.
// UARTPrintf("\r\n");
// UARTPrintf("Parsed H command. nParseLeft = ");
// emb_itoa(pSocket->nParseLeft, OctetArray, 10, 3);
// UARTPrintf(OctetArray);
// UARTPrintf("\r\n");
#endif // DEBUG_SUPPORT == 15

      }
#endif // PCF8574_SUPPORT == 1
#endif // BUILD_SUPPORT == BROWSER_ONLY_BUILD || HOME_ASSISTANT_SUPPORT == 1





#if DOMOTICZ_SUPPORT == 1
      // Parse 'h' ------------------------------------------------------//
      else if (pSocket->ParseCmd == 'h') {
        // This code sets the Pending_pin_control bytes based on the
        // information in the 48 character string sent in the h00 field.
        //
	// Notes on the "current_webpage" logic.
	// If we got to this point and current_webpage == WEBPAGE_NULL
	// then we know we did not encounter a POST from a 
	// Configuration page so this must be a POST from an IOControl page.
	if (pSocket->current_webpage == WEBPAGE_NULL) {
          pSocket->current_webpage = WEBPAGE_IOCONTROL;
	  pSocket->nParseLeft = PARSEBYTES_IOCONTROL - 4;
	}
	
        // There are always 48 characters in the string in 24 pairs of
        // hex encoded nibbles, each pair representing a hex encoded pin
        // control byte. The character pairs are extracted one set at a
        // time, converted to a numeric byte, and stored in their
        // corresponding Pending_pin_control byte.
	// If PCF8574 is included in the build all 24 pairs are extracted
	// and stored in the Pending_pin_control bytes.
	// If PCF8574 is NOT included in the build only the first 16 pairs
	// are extracted and stored in the Pending_pin_control bytes.
        {
          int i;
          int j;
          uint8_t k;

          // Sort the alpha characters into the pin control bytes
          i = 0;
          j = 0;
          while( i<48 ) {
            // The Configuration page updates all bits except the
            // ON/OFF bit
            // The IOControl page only updates the ON/OFF bit
            Pending_pin_control[j] = pin_control[j];
            // Convert the pin control string into numeric bytes
            // two characters at a time. "k" will contain the byte
            // after conversion.
            k = two_hex2int(local_buf[lbi], local_buf[lbi+1]);
	    lbi += 2;
            pSocket->nParseLeft -= 2;
	    i += 2;

#if PCF8574_SUPPORT == 0
            if (j < 16) {
	      // If PCF8574 IS NOT in the build update Pending_pin_control
	      // only for the STM8 pins. Leave the Pending_pin_control
	      // equal to the pin_control for the PCF8574 pins. They are
	      // unused but must be processed here.
#endif // PCF8574_SUPPORT == 0
#if PCF8574_SUPPORT == 1
            if (j < 24) {
	      // If PCF8574 IS in the build update Pending_pin_control for
	      // all 24 pins.
#endif // PCF8574_SUPPORT == 1
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
            }
            j++;
          }
        }

#if DEBUG_SUPPORT == 15
// Debug notes:
// Turn on these debug statements to verify that the "h00=" POST component is
// being detected properly. This is an important check to verify that the
// nParseLeft variable is being set properly.
// UARTPrintf("\r\n");
// UARTPrintf("Parsed h");
// UARTPrintf("-- nParseLeft = ");
// emb_itoa(pSocket->nParseLeft, OctetArray, 10, 3);
// UARTPrintf(OctetArray);
// UARTPrintf("\r\n");
#endif // DEBUG_SUPPORT == 15

      }
#endif // DOMOTICZ_SUPPORT == 1




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
	// 4 characters representing hex encoded strings (4 nibbles).
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
        // This POST value signals that the "hidden" post was received. This
        // is an indicator that the entire POST was received. There is no '&'
	// delimiter after this POST value.
        //
	// If all has executed properly pSocket->nParseLeft will be equal to
	// one as there is one byte of 'z' data left to parse. Since we
	// received a 'z' we know this is the last POST component, so we'll
	// just zero out nParseLeft and terminate the POST processing. Zero-
	// ing out nParseLeft also allows some backup protection in case there
	// is a math error somewhere, but enabling the debug statements here
	// has shown this is working properly. It is good idea to recheck if
	// any changes are made to the POST logic or content.

#if DEBUG_SUPPORT == 15
// Debug notes:
// If the UARTprintf statements below are enabled and POST parsing is working
// successfully the following should be seen in the UART output:
//   Parsing z command. nParseleft = 1   lbi = xxx   lbi_max = yyy
// where xxx is one less than yyy
// UARTPrintf("\r\n");
// UARTPrintf("Parsing z command.");
// UARTPrintf(" nParseLeft = ");
// emb_itoa(pSocket->nParseLeft, OctetArray, 10, 3);
// UARTPrintf(OctetArray);
// UARTPrintf("   lbi = ");
// emb_itoa(lbi, OctetArray, 10, 3);
// UARTPrintf(OctetArray);
// UARTPrintf("   lbi_max = ");
// emb_itoa(lbi_max, OctetArray, 10, 3);
// UARTPrintf(OctetArray);
// UARTPrintf("\r\n");
// if (pSocket->nParseLeft == 1 && (lbi_max - lbi) == 1) {
//   UARTPrintf("POST Parsing terminated normally\r\n");
// }
// else {
//   UARTPrintf("POST Parsing DID NOT TERMINATE NORMALLY\r\n");
// }
#endif // DEBUG_SUPPORT == 15

        pSocket->nParseLeft = 0;
        break; // Break out of the while loop. We're done with POST.
      }
	  
      // If we got to this point one of the "if/else if" above should have
      // executed leaving the pointers pointing at the "&" delimiter in
      // the POST data as the next character to be processed. So we set
      // the ParseState to PARSE_DELIM and let the while() do its next pass.
      //
      pSocket->ParseState = PARSE_DELIM;
    }
	
    else if (pSocket->ParseState == PARSE_DELIM) {
      if ((pSocket->nParseLeft > 0) && (lbi < lbi_max)) {
        // The "if ((pSocket->nParseLeft > 0) && (lbi < lbi_max)) {" is the
	// normal processing path for PARSE_DELIM. Between every POST compon-
	// ent a '&' delimiter marks the end of one POST component and the
	// start of the next POST component. The parsing logic knows how long
	// each POST component is, so when that logic reaches the end of a
	// POST component the PARSE_DELIM logic is run and the first test is
	// to assure that a '&' is in the right place. If it is, then we
	// simply move past the '&' delimeter and move on to parsing the next
	// POST component in the local_buf, unless of course we are at the end
	// of the local_buf, in which case we break out of the while() loop
	// and await the next data packet.
	// Note that the very last POST component (the "z00=0" component) does
	// not end with a '&' delimiter. But because of the way the parsing is
	// designed detection of "z00=" will end parsing and the PARSE_DELIM
	// logic is not called.
	
	if (local_buf[lbi] != '&') {
	  // Parse failed. Abort the POST.
	  parse_error = 1;
          pSocket->nParseLeft = 0;
	  break; // Break out of thw while() loop
	}

#if DEBUG_SUPPORT == 15
// Debug notes:
// This debug can be a little confusing in the UART display but it will show
// progress through the parsing of the local_buf.
// UARTPrintf("\r\n");
// UARTPrintf("PARSE_DELIM, lbi < lbi_max. nParseLeft = ");
// emb_itoa(pSocket->nParseLeft, OctetArray, 10, 3);
// UARTPrintf(OctetArray);
// UARTPrintf("   lbi = ");
// emb_itoa(lbi, OctetArray, 10, 3);
// UARTPrintf(OctetArray);
// UARTPrintf("   lbi_max = ");
// emb_itoa(lbi_max, OctetArray, 10, 3);
// UARTPrintf(OctetArray);
// UARTPrintf("\r\n");
#endif // DEBUG_SUPPORT == 15

	// Advance the pointers in case we are to go parse the next command
	// byte.
        pSocket->ParseState = PARSE_CMD;
        pSocket->nParseLeft--;
        lbi++;
	
        // Check if we've reached the end of the local_buf. If yes we should
	// break out of the while() loop.
	if (lbi == lbi_max) {
	  break;
	}
      }
      else if (lbi >= lbi_max) {
        // We somehow advanced past the end of the local_buf. This is a
	// parsing error and should abort the POST.

#if DEBUG_SUPPORT == 15
// UARTPrintf("Advanced past the endof the local_buf\r\n");
// UARTPrintf("PARSE_DELIM, Parse Error, lbi >= lbi_max. nParseLeft = ");
// emb_itoa(pSocket->nParseLeft, OctetArray, 10, 3);
// UARTPrintf(OctetArray);
// UARTPrintf("   lbi = ");
// emb_itoa(lbi, OctetArray, 10, 3);
// UARTPrintf(OctetArray);
// UARTPrintf("   lbi_max = ");
// emb_itoa(lbi_max, OctetArray, 10, 3);
// UARTPrintf(OctetArray);
// UARTPrintf("\r\n");
#endif // DEBUG_SUPPORT == 15

	parse_error = 1;
        pSocket->nParseLeft = 0;
	break; // Break out of thw while() loop
      }
      else {
        // If we came to PARSE_DELIM and there was nothing left to parse in
        // this or any subsequent packet (the normal exit state for POST data)
	// then we should just make sure nParseLeft is zero and go on to exit.
	// This logic should never get executed due to the way this applica-
	// tion has structured the POSTs with the use of the z00=0 POST
	// component to end parsing. Since this part of PARSE_DELIM should
	// never happen this will be considered a parsing error.

#if DEBUG_SUPPORT == 15
// UARTPrintf("\r\n");
// UARTPrintf("PARSE_DELIM, Parse Error, No z00=0. nParseLeft = ");
// emb_itoa(pSocket->nParseLeft, OctetArray, 10, 3);
// UARTPrintf(OctetArray);
// UARTPrintf("\r\n");
#endif // DEBUG_SUPPORT == 15

	parse_error = 1;
        pSocket->nParseLeft = 0;
	break; // Break out of thw while() loop
      }
    }
  }  // end of "while(1)" loop
      
  // If no parse_error and if nParseLeft == 0 we should enter
  // STATE_SENDHEADER204, but we clean up the fragment tracking pointers
  // first.
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
    if (parse_error == 0) {
      // Signal the main.c processes that parsing is complete
      parse_complete = 1;

#if DEBUG_SUPPORT == 15
// UARTPrintf("parse_complete\r\n");
#endif // DEBUG_SUPPORT == 15

    }
    else {
      // Else we don't set parse_complete so that Pending values won't be
      // processed in the main.c code. Effectively all the Pending changes are
      // ignored.
      // XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
      // XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
      // XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
      // Hmmm ... a subsequent Save of any kind could cause miscellaneous
      // Pending values to be used in main.c. I'm not sure that is a problem,
      // but it could be confusing to the user to see some of their changes
      // take effect, and some not take effect. It should be apparent in the
      // GUI, so maybe the user just has to update the changes in the GUI
      // again and perform another Save.
      // Maybe forcing a reset? But that would also zero the IOControl states
      // which is probably not a good idea.
      // Maybe call a function that returns all Pending values to their current
      // values? This is also done in the eeprom start up so it might not add
      // much code if it is a shared function.
      // XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
      // XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
      // XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
      parse_error = 0; // Clear parse_error for the next Save
    }
    // Set nState to copy a 200 header with Content-Length = 0 into the body
    // of the reply to the POST. This will also close the connection.
    pSocket->nPrevBytes = 0xFFFF;
    pSocket->nState = STATE_SENDHEADER204;
    
    
#if LOGIN_SUPPORT == 1
    // Normally when a POST completes the page that originated the POST is
    // repainted with the new values entered on that page. This happens as a
    // result of a "restart" or "reboot" after the POST completes. In some
    // cases it may be required that a different page be displayed after POST.
    // Here code can optionally change the page that will be displayed.
    if (login_successful == 1) {
      // login_successful == 1 indicates that a Login POST was processed and
      // the login was successful. In this case the IOControl page should be
      // displayed.
      pSocket->current_webpage = WEBPAGE_IOCONTROL;
      pSocket->pData = g_HtmlPageIOControl;
      pSocket->nDataLeft = HtmlPageIOControl_size;
      init_off_board_string_pointers(pSocket);
      pSocket->nPrevBytes = 0xFFFF;
      pSocket->nState = STATE_SENDHEADER200;
    }
    if (login_successful == 2) {
      // login_successful == 2 indicates that a Login POST was processed and
      // the login was unsuccessful
      // OR
      // login_successful == 2 indicates that the user just submitted a Set
      // Passphrase request.
      // In both cases the Login page should be displayed.
      pSocket->current_webpage = WEBPAGE_LOGIN;
      pSocket->pData = g_HtmlPageLogin;
      pSocket->nDataLeft = HtmlPageLogin_size;
      init_off_board_string_pointers(pSocket);
      pSocket->nPrevBytes = 0xFFFF;
      pSocket->nState = STATE_SENDHEADER200;
    }
    if (login_successful == 3) {
      // login_successful == 3 indicates that the user just submitted a Set
      // Passphrase request and the Passphrase was blank. That disabled the
      // Login function. The Configuration page should be displayed.
      pSocket->current_webpage = WEBPAGE_CONFIGURATION;
      pSocket->pData = g_HtmlPageConfiguration;
      pSocket->nDataLeft = HtmlPageConfiguration_size;
      init_off_board_string_pointers(pSocket);
      pSocket->nPrevBytes = 0xFFFF;
      pSocket->nState = STATE_SENDHEADER200;
    }
#endif // LOGIN_SUPPORT == 1
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







void parseget(struct tHttpD* pSocket, char *pBuffer)
{
  uint8_t GET_response_type;
  GET_response_type = 200; // Default response type
  
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
  // been parsed and the remainder of the GET request is stored in global
  // "parse_GETcmd". The "GET " should be followed by "/filename". So we look
  // for the "/" and collect the next characters as the fake "filename".
  //
  // Browser note: Looks like some browsers get creative and do things
  // like requesting "favicon.ico" from the server. This causes the code
  // below to execute - and in the original code it caused confusion as I
  // would send the IOControl web page if I didn't understand the inquiry.
  // Now I will just throw the request away if it doesn't exactly match an
  // expected request. The only exception will be if I get a "/" or "/ "
  // each followed by nothing, then I will send the default web page.
  //
  // Digit Parsing note: All digits that make up the two digit URL Command
  // (ex: /55) are interpreted as hex digits. Thus, commands can be /00 to
  // /ff.

  while (1) {
    // The GET command has been captured in parse_GETcmd[], so the while()
    // loop just spins until a parse decision is made.
    if (pSocket->ParseState == PARSE_SLASH1) {
      // When we entered the loop parse_GETcmd[0] should already be pointing at
      // the "/". If there isn't one we should display the IOControl page.
      pSocket->ParseCmd = parse_GETcmd[0];
      if (pSocket->ParseCmd == '/') { // Compare to '/'
        // The '/' is present. Go on to check for a command value
        pSocket->ParseState = PARSE_NUMMSD;
      }
      else parse_command_exception(pSocket);
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
	 
    if (pSocket->ParseState == PARSE_NUMMSD) {
      {
        int i;
        // Parse and validate first ParseNum digit.
        i = hex2int(parse_GETcmd[1]);
        if (i >= 0) { // Hex nibble?
          // Still good - parse number
          pSocket->ParseNum = (uint8_t)(i << 4);
          pSocket->ParseState = PARSE_NUMLSD;
          pSocket->nParseLeft = 1; // Set to 1 so we don't exit the
                                   // parsing while() loop yet.
        }
        else parse_command_exception(pSocket);
      }
    }
    
    
    // Parse second ParseNum digit
    if (pSocket->ParseState == PARSE_NUMLSD) {
      {
        int i;
        i = hex2int(parse_GETcmd[2]);
        if (i >= 0) { // Hex nibble?
          // Still good - parse number
          pSocket->ParseNum |= (uint8_t)(i);
          pSocket->ParseState = PARSE_VAL;
          pSocket->nParseLeft = 1; // Set to 1 so we don't exit the parsing
                                   // while() loop yet. PARSE_VAL will be
                                   // called.


#if DEBUG_SUPPORT == 15
#if LOGIN_SUPPORT == 1
UARTPrintf("Response_Lockout_Cancel_Timer = ");
emb_itoa(Response_Lockout_Cancel_Timer, OctetArray, 10, 1);
UARTPrintf(OctetArray);
UARTPrintf("   stored_options2 = ");
emb_itoa(stored_options2, OctetArray, 16, 2);
UARTPrintf(OctetArray);
UARTPrintf("   stored_options1 = ");
emb_itoa(stored_options1, OctetArray, 16, 2);
UARTPrintf(OctetArray);
UARTPrintf("\r\n");
#endif // LOGIN_SUPPORT == 1
#endif // DEBUG_SUPPORT == 15


#if DEVELOPMENT_TOOLS == 1
#if LOGIN_SUPPORT == 1
	  // Development bypass for Login hang. This completely resets the
	  // Login logic.
	  if (pSocket->ParseNum == 0x6c) {
            // Disable Login function
	    {
	      uint8_t value;
              value = stored_options2;
	      value &= (uint8_t)(~0x40); // Disable Login function
	      // The next code will update the stored_options2
	      // value in EEPROM.
              update_settings_options(UPDATE_OPTIONS2, value);
            }

	    // Clear all Login function variables
	    // Zero out the ripaddr table (four 32 bit values)
            memset(ripaddr_table, 0, 16);
            // Set Auto Log Out Timers to 0.
            memset(Auto_Log_Out_Timer, 0, 4);
            // Clear the Login Indicators and Login Attempt Counters.
            memset(Login_Tracker, 0, 4);
            // Set Response_Lockout_Cancel_Timer to 0.
            Response_Lockout_Cancel_Timer = 0;
	    // The 0x6c command will fall through to PARSE_VAL and cause
	    // the IOControl page to be shown.
	    user_reboot_request = 1;
	  }
	  // Development bypass for Reboot.
	  if (pSocket->ParseNum == 0x91) {
	    user_reboot_request = 1;
	  }
#endif // LOGIN_SUPPORT == 1
#endif // DEVELOPMENT_TOOLS == 1


#if LOGIN_SUPPORT == 1
          // Check if the Timed Response Lockout should be turned off.
          if (Response_Lockout_Cancel_Timer == 1) {
	    // Response Lockout just ended. Allow the command that was
	    // just received to be processed.
            Response_Lockout_Cancel_Timer = 0;
          }
	  else if (Response_Lockout_Cancel_Timer > 1) {
	    // Response Lockout is still in effect. Replace the command
	    // with 0xa1 so that no command is processed.
            pSocket->ParseNum = 0xa1;
	  }
#endif // LOGIN_SUPPORT == 1
          

#if RESPONSE_LOCK_SUPPORT == 1
          if ((stored_options1 & 0x40) == 0x40) {
            // Completed collecting the incoming command.
	    // If Response Lock is ON and the command is a "/a0unlock" command
	    // then the command is parsed normally, leading to Response Lock
	    // being turned OFF.
	    // If Response Lock is ON then the collected command is replaced
	    // with a "/a1" command which causes a "no reply" to the GET
	    // request.
            if (parse_GETcmd[3] != 'u') {
              pSocket->ParseNum = 0xa1;
            }
 	  }
#endif // RESPONSE_LOCK_SUPPORT == 1


#if LOGIN_SUPPORT == 1
          // If Login code is enabled this function will display the Login
	  // webpage if it is determined that the host that sent the GET
	  // command is not logged in. If the host IS logged in then the Login
	  // page is bypassed and the GET command is process normally.
	  //
	  // MQTT code allows up to 3 Browsers to be connected. Browser Only
	  // code allows up to 4 Browsers. For this reason the ripaddr_table
	  // allows up to 4 entries. HOWEVER, we don't really manage Browser
	  // logins ... instead we are really managing "host" logins, and we
	  // don't care how many Browsers are on a given host once any Browser
	  // on that host has logged in.
	  //
	  // So, as an example, if a given host has 4 Browsers logged in then
	  // only one entry in the ripaddr_table will be used. But if there
	  // are 4 hosts, each with a Browser logged in, then 4 entries in the
	  // ripaddr_table will be used.
	  
          // Check if Host is logged in
	  // Note: If any connection generates a Response Lockout then ALL
	  // connections are locked out.
	  {
	    int ripaddr_index;
	    int found;
	    
	    found = 0;
	  
            if (stored_options2 & 0x40) {  // Login function is enabled
	      ripaddr_index = check_login_status();
	      if (ripaddr_index >= 0) {
                found = 1;
	      }
	      
	      if (found == 1) {

#if DEBUG_SUPPORT == 15
 UARTPrintf("GET command process: rip_addr entry FOUND. Login Tracker = ");
 emb_itoa(Login_Tracker[ripaddr_index], OctetArray, 16, 2);
 UARTPrintf(OctetArray);
 UARTPrintf("\r\n");
#endif // DEBUG_SUPPORT == 15

	        // Found an existing ripaddr_table entry for this connection.
		if ((Login_Tracker[ripaddr_index] & 0x80) == 0x80) {

#if DEBUG_SUPPORT == 15
 UARTPrintf("GET command process: updating Auto_Log_Out_Timer\r\n");
#endif // DEBUG_SUPPORT == 15

		  // Tracker indicates that the host is logged in.
	          // Set the Auto Log Out Timer to 15 min to reflect that the
		  // host is still active. From here code will go on to
		  // parsing whatever command was received.
		  Auto_Log_Out_Timer[ripaddr_index] = 15;
		}
		else {
		  // Tracker indicates that the host is NOT logged in.
		  // Replace any GET command that was sent with 0x6a to
		  // respond with the Login page.
                  pSocket->ParseNum = 0x6a;
		}
              }
	      else {

#if DEBUG_SUPPORT == 15
 UARTPrintf("GET command process: rip_addr entry NOT FOUND\r\n");
#endif // DEBUG_SUPPORT == 15

	        // Host is not known. Replace any GET command that was sent
		// with 0x6a to respond with the Login page.
                pSocket->ParseNum = 0x6a;
	      }
	    }
	  }
#endif // LOGIN_SUPPORT == 1

        }
        else parse_command_exception(pSocket);
      }
    }
	 
    // Parse the captured ParseNum digits
    if (pSocket->ParseState == PARSE_VAL) {

#if DEBUG_SUPPORT == 15
 UARTPrintf("Command = 0x");
 emb_itoa(pSocket->ParseNum, OctetArray, 16, 2);
 UARTPrintf(OctetArray);
 UARTPrintf("\r\n");
#endif // DEBUG_SUPPORT == 15

      // ParseNum should now contain a two digit "filename". The filename is
      // used to command specific action by the webserver. Following are the
      // commands for the Network Module.
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
      // At this point parse_GETcmd[] contains the entire GET command.
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
      // http://IP/52  Mask and Output Pin settings plus returns RF
      //               Attenuator Settings page
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
      //
      // http://IP/6a  Show Login page
      // http://IP/6b  Show Set Passphrase page
      // http://IP/6c  Disable Login function (TEMPORARY FOR DEVELOPMENT)
      // http://IP/6d  Force Logout (TEMPORARY FOR DEVELOPMENT)
      //
      // http://IP/70  Clear the "Reset Status Register" counters
      // http://IP/71  Display the Temperature Sensor Serial Numbers
      // http://IP/72  Load the Code Uploader (works only in runtime
      //               builds)
      // http://IP/73  Restore (works only in the Code Uploader build)
      // http://IP/74  Erase I2C EEPROM (works only in the Code Uploader
      //               build)
      // http://IP/75  Show SDR RF Attenuator Settings page
      // http://IP/76  Show SDR INA226 Measurements page
      // http://IP/77  Show SDR Power Relay Control page
      // http://IP/78  Turn off Latching Relay Mode
      // http://IP/79  User entered INA226 Shunt Resistance option
      //
      // http://IP/80  Mask and Output Pin settings (deprecated)
      // http://IP/81  Altitude entry
      // http://IP/82  User entered Pinout Option
      // http://IP/83  Force all PCF8574 pins to NULL (default, disabled)
      // http://IP/84  Short Form Option
      // http://IP/85  Force HA Delete Msgs for PCF8574 pins
      //
      // http://IP/91  Reboot
      // http://IP/98  Show Very Short Form IO States page
      // http://IP/99  Show Short Form IO States page
      //
      // http://IP/a0  Turn Response Lock on or off
      // http://IP/a1  NULL command. Used when Response Lock is ON.
      //
      // http://IP/fa  Reserved to avoid "favicon.ico" issue


      switch(pSocket->ParseNum)
      {
#if BUILD_SUPPORT == BROWSER_ONLY_BUILD || BUILD_SUPPORT == MQTT_BUILD
	case 0x55:
	  {
	    int i;
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
	    GET_response_type = 204; // Send header but no webpage. No webpage
	                             // is returned in this case to prevent
				     // interference with REST scripts.
	  }
	  break;
	  
	case 0x56:
	  {
	    int i;
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
	    GET_response_type = 204; // Send header but no webpage. No webpage
	                             // is returned in this case to prevent
				     // interference with REST scripts.
	  }
	  break;
#endif // BUILD_SUPPORT == BROWSER_ONLY_BUILD || BUILD_SUPPORT == MQTT_BUILD


#if BUILD_SUPPORT == BROWSER_ONLY_BUILD || BUILD_SUPPORT == MQTT_BUILD
        case 0x50: // Mask and Output Pin settings, returns no webpage
	case 0x51: // Mask and Output Pin settings plus returns Very Short
	           // Form IO States page
	case 0x52: // Mask and Output Pin settings plus returns RF
	           // Attenuator Settings page
          // This is similar to case 55 and case 56, except a 4 hex char
	  // Mask and a 4 hex char Pin State value hould also be in the
	  // buffer. Capture the characters, check validity, parse into
	  // binary values, and set the pending control bytes.
          //
          // Example URL command
          //   192.168.1.182/50ff00c300
	  //     or
          //   192.168.1.182/51ff00c300
          // The above example will affect only the upper 8 output pins
          // and will set output pins as follows:
          // Output 16 >> 11000011 << Output 9
          // Output 8 to 1 are not affected
	  // The /50... version returns no webpage
	  // The /51... version returns the Very Short Form IO states page
	  // The /52... version returns the RF Attenuator settings page
	  //
          {
            uint16_t word;
            uint16_t mmmm;
            uint16_t pppp;
            uint16_t nibble;
            uint16_t bit_ptr;
            int i;
            int k;
            int m;
            
            word = 0;
	    mmmm = 0;
            pppp = 0;
            k = 0;
            m = 3;
	    
            while (k < 2) {
              i = 4;
              while (i > 0) {
                if (hex2int(parse_GETcmd[m]) != -1) {
                  nibble = (uint16_t)hex2int(parse_GETcmd[m]);
                  word |= (nibble << ((i-1)*4));
                  m++;
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
             
	    // An additional syntax check could be added here to make sure
	    // the command is followed by " H" (space followed by letter H).
	    // This was omitted to save Flash space.
	    
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
          }
#if RF_ATTEN_SUPPORT == 1
	  else if (pSocket->ParseNum == 0x52) {
            // Return RF Attenuator Settings page
            pSocket->current_webpage = WEBPAGE_RF_ATTEN;
            pSocket->pData = g_HtmlPageRFAtten;
            pSocket->nDataLeft = (uint16_t)(sizeof(g_HtmlPageRFAtten) - 1);
          }
#endif // RF_ATTEN_SUPPORT == 1
	  else {
	    GET_response_type = 204; // Send header but no webpage. No webpage
	                             // is returned in this case to prevent
				     // interference with REST scripts.
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
#if BUILD_TYPE_BROWSER_UPGRADEABLE == 1 || HOME_ASSISTANT_SUPPORT == 1
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
	  else {
	    pSocket->ParseState = PARSE_FAIL;
	  }
	  break;
#endif // BUILD_TYPE_BROWSER_UPGRADEABLE == 1 || HOME_ASSISTANT_SUPPORT == 1

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
	  // default page.
	  pSocket->ParseState = PARSE_FAIL;
	  break;

#if LINK_STATISTICS == 1
        case 0x66: // Show Link Error Statistics page
	  pSocket->current_webpage = WEBPAGE_STATS2;
          pSocket->pData = g_HtmlPageStats2;
          pSocket->nDataLeft = (uint16_t)(sizeof(g_HtmlPageStats2) - 1);
	  break;
	  
        case 0x67: // Clear Link Error Statistics
	  // Clear the the Link Error Statistics bytes and Stack Overflow
	  {
	    int i;
            memset(debug_bytes, 0, 10);
	    // Restore ENC28J60 revision to debug_bytes[2]
	    debug_bytes[2] = (uint8_t)(stored_debug_bytes[2] & 0x7f);
	    update_debug_storage1(); // Update EEPROM
	  }
	  TRANSMIT_counter = 0;
	  MQTT_resp_tout_counter = 0;
	  MQTT_not_OK_counter = 0;
	  MQTT_broker_dis_counter = 0;
	  
	  pSocket->current_webpage = WEBPAGE_STATS2;
          pSocket->pData = g_HtmlPageStats2;
          pSocket->nDataLeft = (uint16_t)(sizeof(g_HtmlPageStats2) - 1);
	  break;
#endif // LINK_STATISTICS == 1

#if NETWORK_STATISTICS == 1 && BUILD_SUPPORT == BROWSER_ONLY_BUILD
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
#endif // NETWORK_STATISTICS == 1 && BUILD_SUPPORT == BROWSER_ONLY_BUILD

#if LOGIN_SUPPORT == 1
        case 0x6a: // Show Login page
	  pSocket->current_webpage = WEBPAGE_LOGIN;
          pSocket->pData = g_HtmlPageLogin;
          pSocket->nDataLeft = HtmlPageLogin_size;
          init_off_board_string_pointers(pSocket);
	  break;


        case 0x6b: // Show Set Passphrase page
	  pSocket->current_webpage = WEBPAGE_SET_PASSPHRASE;
          pSocket->pData = g_HtmlPageSetPassphrase;
          pSocket->nDataLeft = HtmlPageSetPassphrase_size;
          init_off_board_string_pointers(pSocket);
	  break;


#if DEVELOPMENT_TOOLS == 1 && LOGIN_SUPPORT == 1
        case 0x6c:
          // Disable Login function /6c
	  {
            // Disable Login function
	    {
	      uint8_t value;
              value = stored_options2;
	      value &= (uint8_t)(~0x40); // Disable Login function
	      // The next code will update the stored_options2
	      // value in EEPROM.
              update_settings_options(UPDATE_OPTIONS2, value);
            }
	    
	    // Clear all Login function variables
	    // Zero out the ripaddr table (four 32 bit values)
            memset(ripaddr_table, 0, 16);
            // Set Auto Log Out Timers to 0.
            memset(Auto_Log_Out_Timer, 0, 4);
            // Clear the Login Indicators and Login Attempt Counters.
            memset(Login_Tracker, 0, 4);
            // Set Response_Lockout_Cancel_Timer to 0.
            Response_Lockout_Cancel_Timer = 0;
	      
	    // Request a reboot
	    user_reboot_request = 1;
	    // Set parse_complete for the check_runtime_changes() process
            parse_complete = 1;
            // Display the IOControl page. The PARSE_FAIL state will cause
	    // this to happen.
	    pSocket->ParseState = PARSE_FAIL;
	  }
	  break;
	  
	  
        case 0x6d:
          // Force Logout /6d
	  {
	    uint8_t temp;
	    
	    // Clear all Login function variables
	    // Zero out the ripaddr table (four 32 bit values)
            memset(ripaddr_table, 0, 16);
            // Set Auto Log Out Timers to 0.
            memset(Auto_Log_Out_Timer, 0, 4);
            // Clear the Login Indicators and Login Attempt Counters.
            memset(Login_Tracker, 0, 4);
            // Set Response_Lockout_Cancel_Timer to 0.
            Response_Lockout_Cancel_Timer = 0;
	      
            // Display the IOControl page. The PARSE_FAIL state will cause
	    // this to happen.
	    pSocket->ParseState = PARSE_FAIL;
	  }
	  break;
#endif // DEVELOPMENT_TOOLS == 1 && LOGIN_SUPPORT == 1
#endif // LOGIN_SUPPORT == 1

        case 0x70: // Clear the "Reset Status Register" counters
	  // Clear the counts for EMCF, SWIMF, ILLOPF, IWDGF, WWDGF
	  // These only display via the UART
          memset(&debug_bytes[5], 0, 5);
	  update_debug_storage1(); // Update EEPROM
	  // Show default page
	  // While NOT a PARSE_FAIL, going through the PARSE_FAIL logic
	  // will accomplish what we want which is to display the
	  // default webpage.
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
	  pSocket->current_webpage = WEBPAGE_LOADUPLOADER;
          pSocket->pData = g_HtmlPageLoadUploader;
          pSocket->nDataLeft = HtmlPageLoadUploader_size;
          init_off_board_string_pointers(pSocket);
          if (eeprom_detect == 1) {
	    // eeprom_detect was re-checked in init_off_board_string_pointers().
	    // If the eeprom is still OK signal a copy to flash request.
            eeprom_copy_to_flash_request = I2C_COPY_EEPROM_R1_REQUEST;
	  }
	  break;
#endif // BUILD_SUPPORT == BROWSER_ONLY_BUILD || BUILD_SUPPORT == MQTT_BUILD
#endif // OB_EEPROM_SUPPORT == 1
	  
#if OB_EEPROM_SUPPORT == 1
#if BUILD_SUPPORT == CODE_UPLOADER_BUILD
        case 0x73: // Reload firmware existing image
	  // Load the existing firmware image from I2C EEPROM Region 0,
	  // display the Loading Existing Image webpage, then reboot.
	  pSocket->current_webpage = WEBPAGE_EXISTING_IMAGE;
          pSocket->pData = g_HtmlPageExistingImage;
          pSocket->nDataLeft = (uint16_t)(sizeof(g_HtmlPageExistingImage) - 1);
          eeprom_copy_to_flash_request = I2C_COPY_EEPROM_R0_REQUEST;
	  upgrade_failcode = UPGRADE_OK;
	  break;
#endif // BUILD_SUPPORT == CODE_UPLOADER_BUILD
#endif // OB_EEPROM_SUPPORT == 1
          
#if OB_EEPROM_SUPPORT == 1
#if BUILD_SUPPORT == CODE_UPLOADER_BUILD
        case 0x74: // Erase entire I2C EEPROM
          // Erase I2C EEPROM regions 0, 1, 2, and 3 to provide a clean
	  // slate. Useful mostly during development for code debug.
	  {
	    uint16_t i;
	    int k;
	    uint16_t temp_eeprom_address_index;
	    uint8_t write_command = 0;
	    uint8_t value = 0;
	    for (k=0; k<4; k++) {
	      for (i=0; i<256; i++) {
	        // Write 256 blocks of 128 bytes each with zero
	        if (k == 0) write_command = I2C_EEPROM_R0_WRITE;
	        if (k == 1) write_command = I2C_EEPROM_R1_WRITE;
	        if (k == 2) write_command = I2C_EEPROM_R2_WRITE;
	        if (k == 3) write_command = I2C_EEPROM_R3_WRITE;
	        temp_eeprom_address_index = i * 128;
                copy_STM8_bytes_to_I2C_EEPROM(&value, 128, write_command, temp_eeprom_address_index, 2);
                IWDG_KR = 0xaa; // Prevent the IWDG from firing.
	      }
            }
	  }
#if LOGIN_SUPPORT == 1
	  // An added requirement is to Disable the Login function. This done
	  // to cover the case where the Login function was enabled and
	  // erasing the entire EEPROM also erased the Passphrase.
	  {
	    uint8_t value;
	    value = stored_options2;
	    value &= (uint8_t)~0x40;
	    // Update the stored_options2 value in EEPROM.
            update_settings_options(UPDATE_OPTIONS2, value);
	  }
#endif // LOGIN_SUPPORT == 1
          GET_response_type = 204; // Send header but no webpage. No webpage
	                           // is returned in this case as erasing the
				   // EEPROM results in loss of the webpage
				   // content until the strings file is
				   // uploaded.
          break;
#endif // BUILD_SUPPORT == CODE_UPLOADER_BUILD
#endif // OB_EEPROM_SUPPORT == 1
          
          
#if RF_ATTEN_SUPPORT == 1
	case 0x75: // Show RF Attenuator Settings page
	  pSocket->current_webpage = WEBPAGE_RF_ATTEN;
          pSocket->pData = g_HtmlPageRFAtten;
          pSocket->nDataLeft = (uint16_t)(sizeof(g_HtmlPageRFAtten) - 1);
	  break;
#endif // RF_ATTEN_SUPPORT == 1
          
          
#if INA226_SUPPORT == 1
	case 0x76: // Show INA226 measurements page
	  pSocket->current_webpage = WEBPAGE_INA226;
          pSocket->pData = g_HtmlPageINA226;
          pSocket->nDataLeft = (uint16_t)(sizeof(g_HtmlPageINA226) - 1);
	  break;
#endif // INA226_SUPPORT == 1
          
          
#if SDR_POWER_RELAY_SUPPORT == 1
	case 0x77: // Show SDR Power Relay page
	  pSocket->current_webpage = WEBPAGE_SDR_POWER_RELAY;
          pSocket->pData = g_HtmlPageSDRPowerRelay;
          pSocket->nDataLeft = (uint16_t)(sizeof(g_HtmlPageSDRPowerRelay) - 1);
	  // If 0x77 is ever called we go into "Latching Relay Mode"
	  // wherein any 0x00 to 0x31 command will be turned into a pulse
	  // to operate the set/reset functions of a latching relay. Once
	  // "Latching Relay Mode" has been enabled it can only be turned
	  // off with command 0x78. A bit is set in stored_options1 so
	  // that this setting is retained over power cycles.
	  unlock_eeprom();
	  stored_options1 |= 0x80;
	  lock_eeprom();
	  break;
	  
	case 0x78: // Turn off Latching Relay Mode
	  // If 0x77 is ever called we go into "Latching Relay Mode"
	  // wherein any 0x00 to 0x31 command will be turned into a pulse
	  // to operate the set/reset functions of a latching relay. This
	  // mode is saved in stored_options1. The 0x78 command is used to
	  // turn off Latching Relay Mode.
	  unlock_eeprom();
	  stored_options1 &= 0x7f;
	  lock_eeprom();
	  // Show default page
	  // While NOT a PARSE_FAIL, going through the PARSE_FAIL logic
	  // will accomplish what we want which is to display the
	  // IO_Control page.
	  pSocket->ParseState = PARSE_FAIL;
	  break;
#endif // SDR_POWER_RELAY_SUPPORT == 1
          
           
#if INA226_SUPPORT == 1
        case 0x79:
	  // User entered INA226 Shunt Resistance value.
	  // User enters three digits to specify the shunt resistance.
	  // For example, typical resistors are labled as follows:
	  // R100 = 0.100 ohms. User should enter 100
	  // R010 = 0.010 ohms. User should enter 010
	  // R002 = 0.002 ohms. User should enter 002
	  // 
          // Example URL command
          //   192.168.1.182/79100 to set shunt resistance to 0.100 ohm
          //   192.168.1.182/79010 to set shunt resistance to 0.010 ohm
          //   192.168.1.182/79002 to set shunt resistance to 0.002 ohm
	  //
	  // 000 will not be accepted.
          {
            uint8_t old_shunt_resistance_value;
            uint16_t new_shunt_resistance_value;
	    
	    old_shunt_resistance_value = stored_shunt_res;
	    new_shunt_resistance_value = old_shunt_resistance_value;
	    
	    // Accept the next three characters as the new shunt resistance
	    // value.
	    // The user can enter 001 for 0.001 ohm
	    //              up to 255 for 0.255 ohms
	    if (parse_GETcmd[3] == '0'
	     && parse_GETcmd[4] == '0'
	     && parse_GETcmd[5] == '0') {
	      new_shunt_resistance_value = old_shunt_resistance_value;
	    }
	    else if (isdigit(parse_GETcmd[3])
	          && isdigit(parse_GETcmd[4])
	          && isdigit(parse_GETcmd[5])) {
	      // Convert characters to a uint8_t
	      new_shunt_resistance_value =  (parse_GETcmd[3] - '0') * 100;
	      new_shunt_resistance_value += (parse_GETcmd[4] - '0') * 10;
	      new_shunt_resistance_value += (parse_GETcmd[5] - '0');
	      if (new_shunt_resistance_value > 255) {
	        new_shunt_resistance_value = old_shunt_resistance_value;
	      }
	    }
	    else {
	      // No change will occur if the user made an invalid entry.
	    }
	    
	    // Save to EEPROM.
	    if (stored_shunt_res != new_shunt_resistance_value) {
	      unlock_eeprom();
	      stored_shunt_res = (uint8_t)new_shunt_resistance_value;
	      lock_eeprom();
	    }
	    // Request a reboot to re-initialize the INA226 devices.
	    user_reboot_request = 1;
	    // Set parse_complete for the check_runtime_changes() process
            parse_complete = 1;
            // Always display the IOControl page even if there is no parse
	    // fail. The PARSE_FAIL state will cause this to happen.
	    pSocket->ParseState = PARSE_FAIL;
          }
          break;
#endif // INA226_SUPPORT == 1
           
           
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
            int32_t altitude_local;
            uint8_t error;
            char digit_string[6];
            uint8_t digit_count;
            uint8_t altitude_scale;
            uint32_t multiplier;
            int i;
            int m;
	    
	    // There must be at least one digit, and up to 5 digits,
	    // followed by an F (for feet) or M (for meters). Internally
	    // the code uses feet for all calculations, so all "meter"
	    // entries are converted to feet.
	    error = 0;
	    altitude_local = 0;
            m = 3;
	    
	    // First character must be a digit or a minus.
	    if ((parse_GETcmd[m] == '-') || (isdigit(parse_GETcmd[m]))) {
	      digit_string[0] = parse_GETcmd[m];
	      m++;
	    }
	    else error = 1;
	    digit_count = 1;
	    altitude_scale = 0;
	    while (error == 0) {
	      // Check additional characters (up to 4 more digits, then F or
	      // M terminator.
	      // Second character position:
	      if (isdigit(parse_GETcmd[m])) {
	        // Character is a digit
	        digit_string[digit_count++] = parse_GETcmd[m];
	        m++;
	      }
	      else if (parse_GETcmd[m] == 'F' || parse_GETcmd[m] == 'M') {
	        // F = 0x46, M = 0x4d
	        altitude_scale = parse_GETcmd[m];
	        m++;
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
	      // If F or M terminator not found yet then the next character
	      // MUST be an F or M
	      if (altitude_scale == 0) {
	        if (parse_GETcmd[m] == 'F' || parse_GETcmd[m] == 'M') {
	          altitude_scale = parse_GETcmd[m];
	          m++;
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
	        altitude_local = (altitude_local * 328084) + 50000; // Add 50000 to account
		                                                    // for turncation rounding
	        altitude_local = altitude_local / 100000;
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
	    
	    // An additional syntax check could be added here to make sure
	    // the command is followed by " H" (space followed by letter H).
	    // This was omitted to save Flash space.

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
           // While parsing was successful set PARSE_FAIL so the IOControl
	   // page will be displayed.
 	   pSocket->ParseState = PARSE_FAIL;
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
	    if (isdigit(parse_GETcmd[3])) {
	      pinout_select = (uint8_t)(parse_GETcmd[3] & 0x07);
#if DEBUG_SUPPORT == 15
              // Force Pinout Option 1 if UART enabled
	      pinout_select = 1;
#endif // DEBUG_SUPPORT == 15
	      if ((pinout_select > 0) && (pinout_select < 5)){
	        j = (uint8_t)(stored_options1 & 0xf8);
	        j |= pinout_select;
                update_settings_options(UPDATE_OPTIONS1, j);
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
          
           
#if PCF8574_SUPPORT == 1
        case 0x83:
	  // Force PCF8574 pin_control values to NULL.
	  // This is used to place the PCF8574 pins in a more benign state
	  // should the user need.
	  // Issue #177
	  {
	    int i;
	    // Disable all PCF8574 pins.
            memset(&Pending_pin_control[16], 0, 8);
	    // Set parse_complete for the check_runtime_changes() process
            parse_complete = 1;
            // Always display the IOControl page even if there is no parse
	    // fail. The PARSE_FAIL state will cause this to happen.
	    pSocket->ParseState = PARSE_FAIL;
          }
          break;
#endif // PCF8574_SUPPORT == 1
          
          
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
	    uint8_t j;
	    j = stored_options1;
	    // Accept the first character as the Short Form option
	    if (parse_GETcmd[3] == '-') j |= 0x10;
	    if (parse_GETcmd[3] == '+') j &= 0xef;
            update_settings_options(UPDATE_OPTIONS1, j);
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
            update_settings_options(UPDATE_OPTIONS1, j);
	    
            for (i = 16; i < 24; i++) pin_control[i] &= 0xfc;
            copy_STM8_bytes_to_I2C_EEPROM(&pin_control[16], 8, I2C_EEPROM_R2_WRITE, PCF8574_I2C_EEPROM_R2_PIN_CONTROL_STORAGE, 2);
	    user_reboot_request = 1;
            GET_response_type = 204; // Send header but no webpage
	    break;
	  }
#endif // PCF8574_SUPPORT == 1
          
          
	case 0x91: // Reboot
	  user_reboot_request = 1;
          GET_response_type = 204; // Send header but no webpage
	  break;
        
	
#if BUILD_SUPPORT == BROWSER_ONLY_BUILD && SHORT_TEMPERATURE_SUPPORT ==1
        case 0x97: // Show Short Form Temperature sensor page
	  pSocket->current_webpage = WEBPAGE_SHORT_TEMPERATURE;
          pSocket->pData = g_HtmlPageShortTemperature;
          pSocket->nDataLeft = (uint16_t)(sizeof(g_HtmlPageShortTemperature) - 1);
	  break;
#endif // BUILD_SUPPORT == BROWSER_ONLY_BUILD && SHORT_TEMPERATURE_SUPPORT ==1
        
	
#if BUILD_SUPPORT == BROWSER_ONLY_BUILD || BUILD_SUPPORT == MQTT_BUILD
        case 0x98: // Show Very Short Form IO state page
        case 0x99: // Show Short Form IO state page
	  pSocket->current_webpage = WEBPAGE_SSTATE;
          pSocket->pData = g_HtmlPageSstate;
          pSocket->nDataLeft = (uint16_t)(sizeof(g_HtmlPageSstate) - 1);
	  break;
#endif // BUILD_SUPPORT == BROWSER_ONLY_BUILD || BUILD_SUPPORT == MQTT_BUILD


#if RESPONSE_LOCK_SUPPORT == 1
        case 0xa0:
	  // Turn the Response Lock on or off.
          // Read the next 6 characters and compare to the lock and unlock
	  // codes.
          {
            char code[7];
            int k;
            int m;

            k = 0;
            m = 3;
            while (k < 6) {
	      // Copy that part of parse_GETcmd that should contain "L" or
	      // "unlock".
              code[k] = parse_GETcmd[m];
              m++;
              k++;
            }
            code[6] = '\0';

	    if (code[0] == 'L') {
	      // Lock code received. Update the stored_options1 byte in EEPROM.
              update_settings_options(UPDATE_OPTIONS1, (uint8_t)(stored_options1 | 0x40));
              GET_response_type = 204; // Send header but no webpage
	    }
	    
            else if (strcmp(code, "unlock") == 0) {
              // Unlock code received. Update the stored_options1 byte in EEPROM.
              update_settings_options(UPDATE_OPTIONS1, (uint8_t)(stored_options1 & 0xbf));
              // Even though this is not a parse fail call that routine
              // anyway to display the IOControl page
              pSocket->ParseState = PARSE_FAIL;
            }
	    
            else if ((stored_options1 & 0x40) == 0x40) {
              // Response Lock is ON and 0xa0 code was received but it is
	      // not followed by 'unlock'. There should be no
	      // response to the command.
              GET_response_type = 204; // Send header but no webpage
	    }
		
	    else {
	      // Response Lock is OFF and 0xa0 code was received but it is
	      // not followed by 'L' or 'unlock'. This is a parse fail and
	      // the IOControl page should be displayed.
              pSocket->ParseState = PARSE_FAIL;
	    }
	  }
          break;
#endif // RESPONSE_LOCK_SUPPORT == 1


#if RESPONSE_LOCK_SUPPORT == 1
        case 0xa1:
	  // This command is called when Response Lock is ON. The command will
	  // not return a response.
          GET_response_type = 204; // Send header but no webpage
          break;
#endif // RESPONSE_LOCK_SUPPORT == 1


#if DEVELOPMENT_TOOLS == 1
#if BUILD_SUPPORT == BROWSER_ONLY_BUILD
        case 0xd1:
	  // Fill IO_NAME fields with default values for Browser Builds
	  
	  // Fill IO_NAME fields for STM8S IO pins
          unlock_flash();
          {
            int i;
            int j;
            char temp[16];
            for (i=0; i<16; i++) {
              // Build default name
              memset(temp, 0, 16); // Fill temp with null
              strcpy(temp, "IO");
              emb_itoa(i+1, OctetArray, 10, 2);
              strcat(temp, OctetArray);
      
              // Write the default NAME to Flash
              // Enable Word programming
              FLASH_CR2 |= FLASH_CR2_WPRG;
              FLASH_NCR2 &= (uint8_t)(~FLASH_NCR2_NWPRG);
	      // Write word to Flash
              memcpy(&IO_NAME[i][0], &temp[0], 4); // Write default name
              // No "wait_timer" is needed. The spec says the CPU stalls
              // while the word programming operates (takes about 6ms).
	  
	      // Fill the rest of the field with NULL
	      {
	        int w;
	        w = 4;
	        while(w<16) {
                  // Enable Word programming
                  FLASH_CR2 |= FLASH_CR2_WPRG;
                  FLASH_NCR2 &= (uint8_t)(~FLASH_NCR2_NWPRG);
	          // Write word to Flash
                  memset(&IO_NAME[i][w], 0, 4); // Add NULL
                  // No "wait_timer" is needed. The spec says the CPU stalls
                  // while the word programming operates (takes about 6ms).
	          w += 4;
	        }
	      }
            }
          }
	  lock_flash();
	  
	  // Initialize I2C EEPROM memory that is used to store IO Names for
          // PCF8574 output pins. Set to default names.
          // There are 8 names, 16 bytes each. Write 128 bytes.
          I2C_control(I2C_EEPROM_R2_WRITE);
          I2C_byte_address(PCF8574_I2C_EEPROM_R2_START_IO_NAMES, 2);
          {
            char temp[16];
            int i;
            int j;
            for (i=16; i<24; i++) {
              memset(temp, 0, 16); // Fill temp with null
              strcpy(temp, "IO");
              emb_itoa(i+1, OctetArray, 10, 2);
              strcat(temp, OctetArray);
              for (j=0; j<16; j++) {
                I2C_write_byte(temp[j]);
              }
            }
          }
          I2C_stop(); // Start the EEPROM internal write cycle
          wait_timer(5000); // Wait 5ms
	  
	  user_reboot_request = 1;
          // Display the IOControl page. The PARSE_FAIL state will cause
	  // this to happen.
	  pSocket->ParseState = PARSE_FAIL;
	  break;
#endif // BUILD_SUPPORT == BROWSER_ONLY_BUILD
	  
#if DOMOTICZ_SUPPORT == 1
        case 0xd2:
	  // Fill IDX fields with default values for Domoticz Builds
	  
	  // Fill IDX fields for STM8 IO Pins and Sensor IDX fields
          unlock_flash();
          {
            int i;
            int j;
            char temp1[16];
            char temp2[16];
      
            // Build replacement name in case it is needed
            memset(temp1, 0, 16); // Fill temp1 with null
            temp1[0] = '0';       // Set temp1 to string 0
      
            for (i=0; i<22; i++) {
              int w;
              w = 0;
	  
	      if (i < 16) {
	        // For IDX values stored in IO_NAME fields write 16 bytes to the
	        // IO_NAME field.
	        while(w < 16) {
                  // Enable Word programming
                  FLASH_CR2 |= FLASH_CR2_WPRG;
                  FLASH_NCR2 &= (uint8_t)(~FLASH_NCR2_NWPRG);
	          // Write word to Flash
	          memcpy(&IO_NAME[i][w], &temp1[w], 4);
                  // No "wait_timer" is needed. The spec says the CPU stalls
                  // while the word programming operates (takes about 6ms).
                  w += 4; // Loop runs twice
	        }
	      }
	      else {
	        // For IDX values stored in Sensor_IDX fields write 8 bytes to the
	        // Sensor_IDX field.
	        while (w < 8) {
                  // Enable Word programming
                  FLASH_CR2 |= FLASH_CR2_WPRG;
                  FLASH_NCR2 &= (uint8_t)(~FLASH_NCR2_NWPRG);
	          // Write word to Flash
	          memcpy(&Sensor_IDX[i - 16][w], &temp1[w], 4);
                  // No "wait_timer" is needed. The spec says the CPU stalls
                  // while the word programming operates (takes about 6ms).
                  w += 4; // Loop runs twice
	        }
	      }
            }
          }
          lock_flash();
	  
          {
	    // Fill PCF8574 IDX fields with default values for Domoticz Builds
            int i;
            char temp1[16];
	
            // Build the default IDX value
            memset(temp1, 0, 16); // Fill temp with null
            temp1[0] = '0';
	
            for (i=0; i<8; i++) {
              // Write the default IDX value to I2C EEPROM      
              copy_STM8_bytes_to_I2C_EEPROM(&temp1[0], 16, I2C_EEPROM_R2_WRITE, PCF8574_I2C_EEPROM_R2_START_IO_NAMES + (i * 16), 2);
            }
          }
	  
	  user_reboot_request = 1;
          // Display the IOControl page. The PARSE_FAIL state will cause
	  // this to happen.
	  pSocket->ParseState = PARSE_FAIL;
	  break;
#endif // DOMOTICZ_SUPPORT == 1
	  
	case 0xd3:
	  // Delete Magic Number and reboot.
	  unlock_eeprom();
	  stored_magic1 = 0;
	  lock_eeprom();
	  user_reboot_request = 1;
          GET_response_type = 204; // Send header but no webpage
	  break;
#endif // DEVELOPMENT_TOOLS == 1


        case 0xfa:
	  // At present 0xfa is not used, however, Browsers will sometimes
	  // attempt to collect a "favicon.ico" file from the webserver. This
	  // looks like a 0xfa command, so this code will verify if it is
	  // really a favicon request and will provide a 200 Content-Length=0
	  // reply.
	  // Check the next character to see if it is a "v". If so assume this
	  // is a favicon.ico request. If it is a " " (a space), then this
	  // really was a 0xfa command. 0xfa is currently unsupported and must
	  // return the IOControl page.
	  // Developer note: If 0xfa ever really is used as a command then the
	  // command functionality should be placed in the "else" below. For
	  // now the response is a PARSE_FAIL if the user enters /fa, which
	  // will display the IOControl page.
	  if (parse_GETcmd[3] == 'v') {
	    GET_response_type = 204; // Send header but no webpage
	  }
	  else {
	    // Call PARSE_FAIL to display the IOControl page.
	    pSocket->ParseState = PARSE_FAIL;
	  }
          break;


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

#if SDR_POWER_RELAY_SUPPORT == 0
                // If no latching relays then simply turn IO pins ON or OFF
		// and do not send a response page.
                update_ON_OFF((uint8_t)(cmd_num/2), (uint8_t)(cmd_num%2));
	        GET_response_type = 204; // Send header but no webpage
#endif // SDR_POWER_RELAY_SUPPORT == 0

#if SDR_POWER_RELAY_SUPPORT == 1
                // If latching relays are supported then the "Latching Relay
		// Mode" bit in stored_options1 is checked to determine if the
		// relays should be treated as regular relays or as latching
		// relays.
		//
		// If regular relays (Latching Relay Mode is OFF), then the
		// Outputs are simply turned ON or OFF per the 0x00 to 0x31
		// command and there is no webpage returned to the Browser.
		//
		// If latching relays (Latching Relay Mode is ON), then a
		// check is run to make sure all outputs are set up as pulse
		// outputs. This is done to prevent overheating of the
		// latching relay coils. The check is accomplished by scanning
		// the IO_TIMER contents and the pin_control variables.
		//
		// For now it is assumed that the IO_TIMERs must be set to
		// units of 0.1s and a value of 15 (providing a 1.5 second
		// pulse interval).
		//
		// For reference:
		//   The IO_TIMERs are 14 bit timers with the 2 most
                //   significant bits defining the resolution as:
		//   00 = 0.1 second
		//   01 = 1 second
		//   10 = 1 minute
		//   11 = 1 hour
		//   The remaining lower 14 bits are the actual timer
		//   value from 0 to 16384.
		// So, the IO_TIMERS should all be set to 
		//   0000 0000 0000 000f
		// The pin_control bytes should all be set to
		//   xxx0 0011
		//   This assures the Boot State is OFF, Invert is OFF,
		//   and all pins are outputs.
		    
		if ((stored_options1 & 0x80) == 0) {
		  // Latching Relay Mode is off. Simply turn IO pins on or
		  // off and do not send a response page.
                  update_ON_OFF((uint8_t)(cmd_num/2), (uint8_t)(cmd_num%2));
	          GET_response_type = 204; // Send header but no webpage
		}
		else {
		  // Latching Relay Mode is on. Validate the pin settings
		  // and send the appropriate set/reset pulse to the relay.
		  {
		    int i;
		    uint8_t error;
		    uint8_t latching_relay_state;
		    
		    error = 0;
		    
#if OB_EEPROM_SUPPORT == 0
		    for (i=0; i<16; i++) {
		      if (IO_TIMER[i] != 0x000f) error = 1;
		    }
		    for (i=0; i<16; i++) {
		      if ((pin_control[i] & 0x1f) != 0x03) error = 1;
		    }
#endif // OB_EEPROM_SUPPORT == 0
#if OB_EEPROM_SUPPORT == 1
                    // This section is for development only. Latching Relays
		    // are only meant to be utilized in non-upgradeable code.
		    // However, development is easier in upgradeable code
		    // along with the UART. If OB_EEPROM_SUPPORT is enabled
		    // the implication is that this is an upgradeable build,
		    // thus the code below will limit the latching relay
		    // check to the first 10 pins (5 relays), allowing use of
		    // pin 11 for the UART and pins 14 and 15 for the I2C
		    // EEPROM.
		    for (i=0; i<10; i++) {
		      if (IO_TIMER[i] != 0x000f) error = 1;
		    }
		    for (i=0; i<10; i++) {
		      if ((pin_control[i] & 0x1f) != 0x03) error = 1;
		    }
#endif // OB_EEPROM_SUPPORT == 1
		    
		    if (error == 0) {
		      // All settings are good. Write the outupt pins.
                      update_ON_OFF((uint8_t)(cmd_num/2), (uint8_t)(cmd_num%2));
		    
                      // The ON/OFF commands are used to set or clear bits
		      // in the stored_latching_relay_state variable to
		      // record the "last known ON/OFF state" of the
		      // latching relays.
		      latching_relay_state = stored_latching_relay_state;
		      switch (pSocket->ParseNum) {
		        case 0x01: latching_relay_state |= 0x01; break; // Relay 1 ON
		        case 0x05: latching_relay_state |= 0x02; break; // Relay 2 ON
		        case 0x09: latching_relay_state |= 0x04; break; // Relay 3 ON
		        case 0x13: latching_relay_state |= 0x08; break; // Relay 4 ON
		        case 0x17: latching_relay_state |= 0x10; break; // Relay 5 ON
		        case 0x21: latching_relay_state |= 0x20; break; // Relay 6 ON
		        case 0x25: latching_relay_state |= 0x40; break; // Relay 7 ON
		        case 0x29: latching_relay_state |= 0x80; break; // Relay 8 ON
		            
		        case 0x03: latching_relay_state &= (uint8_t)~0x01; break; // Relay 1 OFF
		        case 0x07: latching_relay_state &= (uint8_t)~0x02; break; // Relay 2 OFF
		        case 0x11: latching_relay_state &= (uint8_t)~0x04; break; // Relay 3 OFF
		        case 0x15: latching_relay_state &= (uint8_t)~0x08; break; // Relay 4 OFF
		        case 0x19: latching_relay_state &= (uint8_t)~0x10; break; // Relay 5 OFF
		        case 0x23: latching_relay_state &= (uint8_t)~0x20; break; // Relay 6 OFF
		        case 0x27: latching_relay_state &= (uint8_t)~0x40; break; // Relay 7 OFF
		        case 0x31: latching_relay_state &= (uint8_t)~0x80; break; // Relay 8 OFF
		      } // end of switch
		      unlock_eeprom();
		      if (stored_latching_relay_state != latching_relay_state)
		        stored_latching_relay_state = latching_relay_state;
		      lock_eeprom();
		    }
		      
		    // Otherwise no output pin changes are made.
		  }
		    
		  // Prepare to show the SDR Power Relay page
		  pSocket->current_webpage = WEBPAGE_SDR_POWER_RELAY;
		  pSocket->pData = g_HtmlPageSDRPowerRelay;
		  pSocket->nDataLeft = (uint16_t)(sizeof(g_HtmlPageSDRPowerRelay) - 1);
		  GET_response_type = 200; // Signal to send return webpage
		}
#endif // SDR_POWER_RELAY_SUPPORT == 1
		    
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
	        GET_response_type = 204; // Send header but no webpage
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
      
      pSocket->nParseLeft = 0; // Clear nParseLeft to indicate parse complete.
      parse_GETcmd[0] = '\0'; // Clear parse_GETcmd to allow receipt of nest
                              // GET command.
    }

    if (pSocket->ParseState == PARSE_FAIL) {
      // Parsing failed above OR there was a decision to display the
      // default webpage.

#if DEBUG_SUPPORT == 15
// UARTPrintf("Executing PARSE_FAIL\r\n");
#endif // DEBUG_SUPPORT == 15

#if BUILD_SUPPORT == BROWSER_ONLY_BUILD || BUILD_SUPPORT == MQTT_BUILD
      // Default page for Browser and MQTT builds is the IOCONTROL page.
      pSocket->current_webpage = WEBPAGE_IOCONTROL;
      pSocket->pData = g_HtmlPageIOControl;
      pSocket->nDataLeft = HtmlPageIOControl_size;
#if OB_EEPROM_SUPPORT == 1
      init_off_board_string_pointers(pSocket);
#endif // OB_EEPROM_SUPPORT == 1
#endif // BUILD_SUPPORT == BROWSER_ONLY_BUILD || BUILD_SUPPORT == MQTT_BUILD

#if BUILD_SUPPORT == CODE_UPLOADER_BUILD
      // Default page for the Code Uploader build is the WEBPAGE_UPLOADER
      // page in Flash. However, we need to verify that the I2C EEPROM is
      // present and display the EEPROM_MISSING page if it is not present.
      // This is really just needed for the case where the SWIM interface
      // was used to load the Code Uploader and the I2C EEPROM was not
      // attached. If someone used the /72 command and for some reason the
      // I2C EEPROM went missing the problem would have been caught during
      // GET processing.
      eeprom_detect = off_board_EEPROM_detect();
      if (eeprom_detect == 1) {
        pSocket->current_webpage = WEBPAGE_UPLOADER;
        pSocket->pData = g_HtmlPageUploader;
        pSocket->nDataLeft = (uint16_t)(sizeof(g_HtmlPageUploader) - 1);
      }
      else {
        // Fix for Issue #195
        pSocket->current_webpage = WEBPAGE_EEPROM_MISSING;
        pSocket->pData = g_HtmlPageEEPROMMissing;
        pSocket->nDataLeft = (uint16_t)(sizeof(g_HtmlPageEEPROMMissing) - 1);
      }
#endif // BUILD_SUPPORT == CODE_UPLOADER_BUILD

      pSocket->nParseLeft = 0; // Set to 0 so we will go on to STATE_
	                       // SENDHEADER
    }

    if (pSocket->nParseLeft == 0) {
      // Finished parsing
      // Send the response
      pSocket->nPrevBytes = 0xFFFF;

      if (GET_response_type == 200) {
        // Update GUI with appropriate webpage

#if DEBUG_SUPPORT == 15
// UARTPrintf("STATE_SENDHEADER200\r\n");
#endif // DEBUG_SUPPORT == 15

        pSocket->nPrevBytes = 0xFFFF;
        pSocket->nState = STATE_SENDHEADER200;
      }
      if (GET_response_type == 204) {
        // No return webpage - send header 200 with Content-Length: 0

#if DEBUG_SUPPORT == 15
// UARTPrintf("STATE_SENDHEADER204\r\n");
#endif // DEBUG_SUPPORT == 15

        pSocket->nPrevBytes = 0xFFFF;
        pSocket->nState = STATE_SENDHEADER204;
      }
      break; // Break out of while loop
    }
  } // end of while loop
  return;
}


void parse_command_exception(struct tHttpD* pSocket)
{
  // This function is used to complete parsing of an incoming GET command when
  // a normal path exception occurs. These exceptions are typically a format
  // error, or simply need to respond with the IOControl webpage (0x60) or
  // Login webpage (0x6a).
  int ripaddr_index;
  
#if RESPONSE_LOCK_SUPPORT == 0
  // If Response Lock is not supported then by default Login is also not
  // supported. The exception result is to show the IOControl page.
  pSocket->ParseNum = 0x60;
#endif // RESPONSE_LOCK_SUPPORT == 0

#if RESPONSE_LOCK_SUPPORT == 1
  // If Response Lock is supported then the exception response is dependent
  // on whether a Response Lock is in effect and whether Login is supported.
  // The exception result can be one of:
  //   - The IOControl page (0x60)
  //   - No webpage (0xa1)
  //   - The Login page (0x6a)
#if LOGIN_SUPPORT == 0
  if ((stored_options1 & 0x40) == 0x00) {
    // Response Lock is OFF and Login is not supported. Respond with the
    // IOControl page.
    pSocket->ParseNum = 0x60;
  }
#endif // LOGIN_SUPPORT == 0
#if LOGIN_SUPPORT == 1
  if (((stored_options1 & 0x40) == 0x00) && (Response_Lockout_Cancel_Timer == 0)) {
    // Response Lock is OFF and Login is supported.
    if ((stored_options2 & 0x40) == 0) {
      // Login is supported but it is not enabled. Respond with the IOControl
      // page.
      pSocket->ParseNum = 0x60;
    }
    else {
      // Login is enabled. Check if the Host is logged in.
      ripaddr_index = check_login_status();
      if ((ripaddr_index >= 0) && (Login_Tracker[ripaddr_index] == 0x80)) {
        // Host is logged in. Respond with IOControl page.
        pSocket->ParseNum = 0x60;
      }
      else {
        // Host is not logged in. Respond with Login page.
        pSocket->ParseNum = 0x6a;
      }
    }
  }
#endif // LOGIN_SUPPORT == 1

#if LOGIN_SUPPORT == 0
  if ((stored_options1 & 0x40) == 0x40)  {
    // Response Lock is ON and Login is not supported.
    // Replace the command with a "/a1" command then go to PARSE_VAL.
    pSocket->ParseNum = 0xa1;
  }
#endif // LOGIN_SUPPORT == 0

#if LOGIN_SUPPORT == 1
  if (((stored_options1 & 0x40) == 0x40) || (Response_Lockout_Cancel_Timer > 1))
  {
    // Response Lock is ON.
    // Replace the command with a "/a1" command then go to PARSE_VAL.
    pSocket->ParseNum = 0xa1;
  }
#endif // LOGIN_SUPPORT == 1
#endif // RESPONSE_LOCK_SUPPORT == 1
  pSocket->ParseState = PARSE_VAL;
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


#if LOGIN_SUPPORT == 1
void login_timer_management(void)
{
  // Function to manage Login timeouts
  int ripaddr_index;
  int found;
  uint32_t temp32_ripaddr;

  // Update the Login management counters/timers. This function is called
  // once per minute.
  {
    int i;
    for (i = 0; i < 4; i++) {
      if (Auto_Log_Out_Timer[i] > 1) Auto_Log_Out_Timer[i]--;
    }
  }
  if (Response_Lockout_Cancel_Timer > 1) Response_Lockout_Cancel_Timer--;

#if DEBUG_SUPPORT == 15
{
  int i;
  UARTPrintf("login_timer_management function   Response_Lockout_Cancel_Timer = ");
  emb_itoa(Response_Lockout_Cancel_Timer, OctetArray, 10, 2);
  UARTPrintf(OctetArray);
  UARTPrintf("\r\n");
  for (i = 0; i < 4; i++) {
    UARTPrintf("login_timer_management function   Auto_Log_Out_Timer = ");
    emb_itoa(Auto_Log_Out_Timer[i], OctetArray, 10, 2);
    UARTPrintf(OctetArray);
    UARTPrintf("   Login_Tracker = ");
    emb_itoa(Login_Tracker[i], OctetArray, 16, 2);
    UARTPrintf(OctetArray);
    UARTPrintf("\r\n");
  }
}
#endif // DEBUG_SUPPORT == 15

  // If a Browser Only build the ripaddr table can have up to 4 entries.
  // If a MQTT built the ripaddr table can only have 3 entries.
#if BUILD_SUPPORT == BROWSER_ONLY_BUILD
  for (ripaddr_index = 0; ripaddr_index < 4; ripaddr_index++) {
#endif // BUILD_SUPPORT == BROWSER_ONLY_BUILD
#if BUILD_SUPPORT == MQTT_BUILD
  for (ripaddr_index = 0; ripaddr_index < 3; ripaddr_index++) {
#endif // BUILD_SUPPORT == MQTT_BUILD
    if (Auto_Log_Out_Timer[ripaddr_index] == 1) {
      // No host activity for 15 min. Remove the ripaddr_table entry.
      ripaddr_table[ripaddr_index] = 0;
      // Initialize timer the logout timer
      Auto_Log_Out_Timer[ripaddr_index] = 0;
      // Initialize the Login_Tracker
      Login_Tracker[ripaddr_index] = 0;
    }
  }
  
  // Check the Response Lockout timer. If active make sure all host
  // connections are removed.
  if (Response_Lockout_Cancel_Timer > 1) {
    // Remove all host connections.
    // Zero out the ripaddr table (four 32 bit values)
    memset(ripaddr_table, 0, 16);
    // Set Auto Log Out Timers to 0.
    memset(Auto_Log_Out_Timer, 0, 4);
    // Clear the Login Indicators and Login Attempt Counters.
    memset(Login_Tracker, 0, 4);
  }
  
  // Check the Response Lockout timer. If the timer just now counted down to
  // 1 set the timer to zero and clear the Response Lockout bit in EEPROM.
  if (Response_Lockout_Cancel_Timer == 1) {
    Response_Lockout_Cancel_Timer = 0;
    update_settings_options(UPDATE_OPTIONS1, (uint8_t)(stored_options1 & 0xbf));
  }
}
#endif // LOGIN_SUPPORT == 1


#if LOGIN_SUPPORT == 1
int8_t check_login_status(void)
{
  // Function to check if Host is logged in.
  // Return values:
  //   -1 if host is not logged.
  //   ripaddr_index (0, 1, 2, or 3) if host is logged in.
  int8_t ripaddr_index;
  uint32_t temp32_ripaddr;
  
  // Convert uip_conn->ripaddr to unit32_t. This identifies the IP
  // address of the host.
  uip_ipaddr_t *uip_ptr;
  uip_ptr = &uip_conn->ripaddr;
  temp32_ripaddr = (*uip_ptr)[0];
  temp32_ripaddr <<= 16;
  temp32_ripaddr |= (*uip_ptr)[1];
  
  // Search ripaddr table to determine if this remote host is known
  // If a Browser Only build the ripaddr table can have up to 4
  // entries.
  // If a MQTT built the ripaddr table can only have 3 entries.
#if BUILD_SUPPORT == BROWSER_ONLY_BUILD
  for (ripaddr_index = 0; ripaddr_index < 4; ripaddr_index++) {
#endif // BUILD_SUPPORT == BROWSER_ONLY_BUILD
#if BUILD_SUPPORT == MQTT_BUILD
  for (ripaddr_index = 0; ripaddr_index < 3; ripaddr_index++) {
#endif // BUILD_SUPPORT == MQTT_BUILD
    if (temp32_ripaddr == ripaddr_table[ripaddr_index]) {
      return(ripaddr_index);
    }
  }
  return(-1);
}
#endif // LOGIN_SUPPORT == 1
