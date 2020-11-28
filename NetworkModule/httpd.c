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
#include "uipopt.h"

// #include "stdlib.h"
#include "string.h"

#define STATE_CONNECTED		0	// Client has just connected
#define STATE_GET_G		1	// G
#define STATE_GET_GE		2	// GE
#define STATE_GET_GET		3	// GET
#define STATE_POST_P		4	// P
#define STATE_POST_PO		5	// PO
#define STATE_POST_POS		6	// POS
#define STATE_POST_POST		7	// POST
#define STATE_GOTGET		8	// Client just sent a GET request
#define STATE_GOTPOST		9	// Client just sent a POST request
#define STATE_PARSEPOST		10	// We are currently parsing the
                                        // client's POST-data
#define STATE_SENDHEADER	11	// Next we send the HTTP header
#define STATE_SENDDATA		12	// ... followed by data
#define STATE_PARSEGET		13	// We are currently parsing the
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
#endif // DEBUG_SUPPORT != 0

extern uint16_t Port_Httpd;               // Port number in use

extern uint8_t IO_16to9;                  // State of upper 8 IO
extern uint8_t IO_8to1;                   // State of lower 8 IO
extern uint8_t invert_output;             // Relay output inversion control
extern uint8_t invert_input;              // Relay input inversion control

extern uint8_t Pending_hostaddr[4];       // Temp storage for new IP address
extern uint8_t Pending_draddr[4];         // Temp storage for new Gateway address
extern uint8_t Pending_netmask[4];        // Temp storage for new Netmask

extern uint16_t Pending_port;             // Temp storage for new Port number

extern uint8_t Pending_devicename[20];    // Temp storage for new Device Name

extern uint8_t Pending_config_settings[6]; // Temp storage for new Config
                                          // settings

extern uint8_t Pending_uip_ethaddr_oct[6]; // Temp storage for new MAC address

extern uint8_t stored_hostaddr[4];	  // hostaddr stored in EEPROM
extern uint8_t stored_draddr[4];	  // draddr stored in EEPROM
extern uint8_t stored_netmask[4];	  // netmask stored in EEPROM

extern uint16_t stored_port;		  // Port number stored in EEPROM

extern uint8_t stored_devicename[20];     // Device name stored in EEPROM

extern uint8_t stored_config_settings[6]; // Config settings stored in EEPROM

extern char mac_string[13];		  // MAC Address in string format

extern uint8_t parse_complete;            // Used to signal that all user inputs have
                                          // POSTed and are ready to be used

extern uint8_t user_reboot_request;       // Communicates the need to reboot back to the
                                          // main.c functions
extern uint8_t restart_reboot_step;       // Indicates whether restart or reboot are
                                          // underway.
       
uint8_t OctetArray[11];		          // Used in conversion of integer values to
					  // character values

uint8_t saved_nstate;         // Saved nState used during TCP Fragment
                              // recovery. If saved_nstate != STATE_NULL
			      // saved_nstate will contain one of the
			      // following to indicate the nState we were in
			      // when a TCP fragmentation boundary occurred:
			      //   STATE_NULL       - indicates not
			      //                      processing fragment
			      //   STATE_GET_G
			      //   STATE_GET_GE
			      //   STATE_GET_GET
			      //   STATE_POST_P
			      //   STATE_POST_PO
			      //   STATE_POST_POS
			      //   STATE_POST_POST
			      //   STATE_GOTGET
			      //   STATE_GOTPOST
                              //   STATE_PARSEPOST  - parsing POST data
uint8_t saved_parsestate;     // Saved ParseState used during TCP Fragment
                              // recovery. If not STATE_NULL saved_parsestate
			      // will contain one of the following to
			      // indicate the ParseState we were in when a
			      // TCP fragmentation boundary occurred:
                              //   PARSE_CMD    - STATE_PARSEPOST, seeking command character (a, b, c etc)
                              //   PARSE_NUM10  - STATE_PARSEPOST, seeking tens digit of command
                              //   PARSE_NUM1   - STATE_PARSEPOST, seeking ones digit of command
                              //   PARSE_EQUAL  - STATE_PARSEPOST, seeking equal sign delimiter
                              //   PARSE_VAL    - STATE_PARSEPOST, seeking data value following equal sign
                              //   PARSE_DELIM  - STATE_PARSEPOST, seeking '&' delimiter
uint8_t saved_nparseleft;     // Saved nParseLeft during TCP Fragment recovery
uint8_t saved_postpartial[24]; // If POST packet TCP fragmentation occurs saved_postpartial will
                              // contain the that part of a POST value that was parsed in
                              // the previous TCP Fragment as follows:
                              // saved_postpartial[0] - the parsed ParseCmd
                              // saved_postpartial[1] - the tens digit of the ParseNum
                              // saved_postpartial[2] - the ones digit of the ParseNum
                              // saved_postpartial[3] - the equal sign
                              // saved_postpartial[4] - the first character of data
                              // saved_postpartial[5] - the second character of data
                              // saved_postpartial[x] - more characters of data
uint8_t saved_postpartial_previous[24]; // When TCP Fragments are processed after the first
                              // packet the saved_postpartial values are copied into the
			      // saved_postpartial_previous values so that the new parsing
			      // can use the saved_postpartial space for new data that might
			      // get interrupted. The saved_postpartial_previous values are
			      // used to restore the state of parsing from the previous 
			      // TCP Fragment.
uint8_t saved_newlines;       // Saved nNewlines value in case TCP fragmentation occurs during
                              // the /r/n/r/n search.
uint8_t z_diag;               // The last value in a POST (hidden), used for diagnostics

uint8_t* tmp_pBuffer;         // Used to return the pBuffer value from parsing sub-functions 
uint16_t tmp_nBytes;          // Used to return the nBytes value from parsing sub-functions
uint8_t tmp_nParseLeft;       // Used to pass the nParseLeft value to parsing sub-functions
uint8_t break_while;          // Used to indicate that a parsing "while loop" break is required
uint8_t alpha[6];             // Used in parsing of multi-digit values

uint8_t current_webpage;      // Tracks the web page that is currently displayed

#if MQTT_SUPPORT == 1
extern uint8_t stored_mqttserveraddr[4];  // mqttserveraddr stored in EEPROM
extern uint16_t stored_mqttport;	  // MQTT Port number  stored in EEPROM
extern char stored_mqtt_username[11];     // MQTT Username  stored in EEPROM
extern char stored_mqtt_password[11];     // MQTT Password  stored in EEPROM

extern uint8_t Pending_mqttserveraddr[4]; // Temp storage for new MQTT IP Address
extern uint16_t Pending_mqttport;	  // Temp storage for new MQTT Port
extern char Pending_mqtt_username[11];    // Temp storage for new MQTT Username
extern char Pending_mqtt_password[11];    // Temp storage for new MQTT Password

extern uint8_t mqtt_start_status;         // Contains error status from the MQTT start process
extern uint8_t MQTT_error_status;         // For MQTT error status display in GUI

extern uint32_t RXERIF_counter;           // Counts RXERIF errors
extern uint32_t TXERIF_counter;           // Counts TXERIF errors
extern uint32_t TRANSMIT_counter;         // Counts any transmit
extern uint32_t second_counter;           // Counts seconds since boot
#endif // MQTT_SUPPORT == 1


/*---------------------------------------------------------------------------*/
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
// - An example marker is %i01, wherein the CopyHttpData() function in the
//   application code will replace the "%i01" characters with a single "0" or
//   "1" character to signal the browser to paint a red or green box
//   indicating pin status.
//
// - Additional markers are inserted to help with compression of the web page
//   templates to reduce the amount of flash memory required. In these cases
//   the markers tell the application code to insert strings that are repeated
//   many times in the web page HTML text, rather than have them repeatedly
//   appear in flash memory. For instance %y00 is used to signal the
//   application code to insert the string
//   "pattern='[0-9]{3}' title='Enter 000 to 255' maxlength='3'>"
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
//   needs to account for GPIO_SUPPORT, UIP_STATISTICS, and HELP_SUPPORT
//   ifdef's as these will also cause variation in the length of the actual
//   data transmitted.
//
// - IMPORTANT: Be sure to carefully update the adjust_template_size function
//   if any changes are made to the amount of text being replaced in the
//   templates.
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
//   were changed on the form (with the exception of the devicename field
//   which can be variable in length).
//


/*---------------------------------------------------------------------------*/


#if GPIO_SUPPORT == 1 // Build control for 16 outputs
// IO Control Template
//
// PARSE_BYTES calculation:
// The form contained in this webpage will generate several data update
// replies. These replies need to be parsed to extract the data from them. We
// need to stop parsing the reply POST data after all update bytes are parsed.
// The formula for determining the stop value is as follows:
//   For 16 of the replies (relay items):
//   POST consists of a ParseCmd (an "o" in this case) in 1 byte
//     Followed by the ParseNum in 2 bytes
//     Followed by an equal sign in 1 byte
//     Followed by a state value in 1 byte
//     Followed by a parse delimiter in 1 byte
//   PLUS
//   For 1 of the replies (hidden):
//   POST consists of a ParseCmd (a "z" in this case) in 1 byte
//     Followed by the ParseNum in 2 bytes
//     Followed by an equal sign in 1 byte
//     Followed by a state value in 1 byte
//     Followed by a parse delimiter in 1 byte
// The formula is
// PARSEBYTES = (#data items x 6)
//	      + (#hidden x 6) - 1
// In this case: (16 x 6)
//             + (1 x 6) - 1 = 101 bytes
// Note: PARSEBYTES_X and PARSEBYTES_X_ADDL must each be less than 255 and
// the sum of the two must not exceed 482.
#define WEBPAGE_IOCONTROL		0
#define PARSEBYTES_IOCONTROL		101
#define PARSEBYTES_IOCONTROL_ADDL	0
static const unsigned char checked[] = "checked";
static const char g_HtmlPageIOControl[] =
  "%y04%y05%y06"
  "<title>IO Control</title>"
  "</head>"
  "<body>"
  "<h1>IO Control</h1>"
  "<form method='POST' action='/'>"
  "<table>"
  "<tr><td class='t1'>Name:</td><td class='t2'>%a00</td></tr>"
  "</table>"
  "<table>"
  "<tr><td class='t1'></td><td class='t3'></td><td class='t1'>SET</td></tr>"
  "<tr><td class='t1'>Relay01</td><td class='s%i00'></td><td class='t1'><input type='radio' id='01on' name='o00' value='1' %o00><label for='01on'>ON</label><input type='radio' id='01off' name='o00' value='0' %p00><label for='01off'>OFF</label></td></tr>"
  "<tr><td class='t1'>Relay02</td><td class='s%i01'></td><td class='t1'><input type='radio' id='02on' name='o01' value='1' %o01><label for='02on'>ON</label><input type='radio' id='02off' name='o01' value='0' %p01><label for='02off'>OFF</label></td></tr>"
  "<tr><td class='t1'>Relay03</td><td class='s%i02'></td><td class='t1'><input type='radio' id='03on' name='o02' value='1' %o02><label for='03on'>ON</label><input type='radio' id='03off' name='o02' value='0' %p02><label for='03off'>OFF</label></td></tr>"
  "<tr><td class='t1'>Relay04</td><td class='s%i03'></td><td class='t1'><input type='radio' id='04on' name='o03' value='1' %o03><label for='04on'>ON</label><input type='radio' id='04off' name='o03' value='0' %p03><label for='04off'>OFF</label></td></tr>"
  "<tr><td class='t1'>Relay05</td><td class='s%i04'></td><td class='t1'><input type='radio' id='05on' name='o04' value='1' %o04><label for='05on'>ON</label><input type='radio' id='05off' name='o04' value='0' %p04><label for='05off'>OFF</label></td></tr>"
  "<tr><td class='t1'>Relay06</td><td class='s%i05'></td><td class='t1'><input type='radio' id='06on' name='o05' value='1' %o05><label for='06on'>ON</label><input type='radio' id='06off' name='o05' value='0' %p05><label for='06off'>OFF</label></td></tr>"
  "<tr><td class='t1'>Relay07</td><td class='s%i06'></td><td class='t1'><input type='radio' id='07on' name='o06' value='1' %o06><label for='07on'>ON</label><input type='radio' id='07off' name='o06' value='0' %p06><label for='07off'>OFF</label></td></tr>"
  "<tr><td class='t1'>Relay08</td><td class='s%i07'></td><td class='t1'><input type='radio' id='08on' name='o07' value='1' %o07><label for='08on'>ON</label><input type='radio' id='08off' name='o07' value='0' %p07><label for='08off'>OFF</label></td></tr>"
  "<tr><td class='t1'>Relay09</td><td class='s%i08'></td><td class='t1'><input type='radio' id='09on' name='o08' value='1' %o08><label for='09on'>ON</label><input type='radio' id='09off' name='o08' value='0' %p08><label for='09off'>OFF</label></td></tr>"
  "<tr><td class='t1'>Relay10</td><td class='s%i09'></td><td class='t1'><input type='radio' id='10on' name='o09' value='1' %o09><label for='10on'>ON</label><input type='radio' id='10off' name='o09' value='0' %p09><label for='10off'>OFF</label></td></tr>"
  "<tr><td class='t1'>Relay11</td><td class='s%i10'></td><td class='t1'><input type='radio' id='11on' name='o10' value='1' %o10><label for='11on'>ON</label><input type='radio' id='11off' name='o10' value='0' %p10><label for='11off'>OFF</label></td></tr>"
  "<tr><td class='t1'>Relay12</td><td class='s%i11'></td><td class='t1'><input type='radio' id='12on' name='o11' value='1' %o11><label for='12on'>ON</label><input type='radio' id='12off' name='o11' value='0' %p11><label for='12off'>OFF</label></td></tr>"
  "<tr><td class='t1'>Relay13</td><td class='s%i12'></td><td class='t1'><input type='radio' id='13on' name='o12' value='1' %o12><label for='13on'>ON</label><input type='radio' id='13off' name='o12' value='0' %p12><label for='13off'>OFF</label></td></tr>"
  "<tr><td class='t1'>Relay14</td><td class='s%i13'></td><td class='t1'><input type='radio' id='14on' name='o13' value='1' %o13><label for='14on'>ON</label><input type='radio' id='14off' name='o13' value='0' %p13><label for='14off'>OFF</label></td></tr>"
  "<tr><td class='t1'>Relay15</td><td class='s%i14'></td><td class='t1'><input type='radio' id='15on' name='o14' value='1' %o14><label for='15on'>ON</label><input type='radio' id='15off' name='o14' value='0' %p14><label for='15off'>OFF</label></td></tr>"
  "<tr><td class='t1'>Relay16</td><td class='s%i15'></td><td class='t1'><input type='radio' id='16on' name='o15' value='1' %o15><label for='16on'>ON</label><input type='radio' id='16off' name='o15' value='0' %p15><label for='16off'>OFF</label></td></tr>"
  "</table>"
  "<input type='hidden' name='z00' value='0'>"
  "<button type='submit' title='Saves your changes then restarts the Network Module'>Save</button>"
  "<button type='reset' title='Un-does any changes that have not been saved'>Undo All</button>"
  "</form>"
  "%y03/60%y02Refresh</button></form>"
  "%y03/61%y02Configuration</button></form>"
#if UIP_STATISTICS == 1
  "%y03/66%y02Network Statistics</button></form>"
#endif // UIP_STATISTICS == 1
#if HELP_SUPPORT == 1
  "%y03/63%y02Help</button></form>"
#endif // HELP_SUPPORT == 1
  "</body>"
  "</html>";
#endif // GPIO_SUPPORT == 1


#if GPIO_SUPPORT == 2 // Build control for 8 outputs / 8 inputs
// IO Control Template
//
// PARSE_BYTES calculation:
// The form contained in this webpage will generate several data update
// replies. These replies need to be parsed to extract the data from them. We
// need to stop parsing the reply POST data after all update bytes are parsed.
// The formula for determining the stop value is as follows:
//   For 8 of the replies (relay items):
//   POST consists of a ParseCmd (an "o" in this case) in 1 byte
//     Followed by the ParseNum in 2 bytes
//     Followed by an equal sign in 1 byte
//     Followed by a state value in 1 byte
//     Followed by a parse delimiter in 1 byte
//   PLUS
//   For 1 of the replies (hidden):
//   POST consists of a ParseCmd (a "z" in this case) in 1 byte
//     Followed by the ParseNum in 2 bytes
//     Followed by an equal sign in 1 byte
//     Followed by a state value in 1 byte
//     Followed by a parse delimiter in 1 byte
// The formula is
// PARSEBYTES = (#data items x 6)
//            + (#hidden x 6) - 1
// In this case: (8 x 6)
//	       + (1 x 6) - 1 = 53 bytes
// Note: PARSEBYTES_X and PARSEBYTES_X_ADDL must each be less than 255 and
// the sum of the two must not exceed 482.
#define WEBPAGE_IOCONTROL		0
#define PARSEBYTES_IOCONTROL		53
#define PARSEBYTES_IOCONTROL_ADDL	0
static const unsigned char checked[] = "checked";
static const char g_HtmlPageIOControl[] =
  "%y04%y05%y06"
  "<title>IO Control</title>"
  "</head>"
  "<body>"
  "<h1>IO Control</h1>"
  "<form method='POST' action='/'>"
  "<table>"
  "<tr><td class='t1'>Name:</td><td class='t2'>%a00</td></tr>"
  "</table>"
  "<table>"
  "<tr><td class='t1'></td><td class='t3'></td><td class='t1'>SET</td></tr>"
  "<tr><td class='t1'>Output01</td><td class='s%i00'></td><td class='t1'><input type='radio' id='01on' name='o00' value='1' %o00><label for='01on'>ON</label><input type='radio' id='01off' name='o00' value='0' %p00><label for='01off'>OFF</label></td></tr>"
  "<tr><td class='t1'>Output02</td><td class='s%i01'></td><td class='t1'><input type='radio' id='02on' name='o01' value='1' %o01><label for='02on'>ON</label><input type='radio' id='02off' name='o01' value='0' %p01><label for='02off'>OFF</label></td></tr>"
  "<tr><td class='t1'>Output03</td><td class='s%i02'></td><td class='t1'><input type='radio' id='03on' name='o02' value='1' %o02><label for='03on'>ON</label><input type='radio' id='03off' name='o02' value='0' %p02><label for='03off'>OFF</label></td></tr>"
  "<tr><td class='t1'>Output04</td><td class='s%i03'></td><td class='t1'><input type='radio' id='04on' name='o03' value='1' %o03><label for='04on'>ON</label><input type='radio' id='04off' name='o03' value='0' %p03><label for='04off'>OFF</label></td></tr>"
  "<tr><td class='t1'>Output05</td><td class='s%i04'></td><td class='t1'><input type='radio' id='05on' name='o04' value='1' %o04><label for='05on'>ON</label><input type='radio' id='05off' name='o04' value='0' %p04><label for='05off'>OFF</label></td></tr>"
  "<tr><td class='t1'>Output06</td><td class='s%i05'></td><td class='t1'><input type='radio' id='06on' name='o05' value='1' %o05><label for='06on'>ON</label><input type='radio' id='06off' name='o05' value='0' %p05><label for='06off'>OFF</label></td></tr>"
  "<tr><td class='t1'>Output07</td><td class='s%i06'></td><td class='t1'><input type='radio' id='07on' name='o06' value='1' %o06><label for='07on'>ON</label><input type='radio' id='07off' name='o06' value='0' %p06><label for='07off'>OFF</label></td></tr>"
  "<tr><td class='t1'>Output08</td><td class='s%i07'></td><td class='t1'><input type='radio' id='08on' name='o07' value='1' %o07><label for='08on'>ON</label><input type='radio' id='08off' name='o07' value='0' %p07><label for='08off'>OFF</label></td></tr>"
  "</table>"
  "<table>"
  "<tr><td class='t1'>Input01</td><td class='s%i08'></td></tr>"
  "<tr><td class='t1'>Input02</td><td class='s%i09'></td></tr>"
  "<tr><td class='t1'>Input03</td><td class='s%i10'></td></tr>"
  "<tr><td class='t1'>Input04</td><td class='s%i11'></td></tr>"
  "<tr><td class='t1'>Input05</td><td class='s%i12'></td></tr>"
  "<tr><td class='t1'>Input06</td><td class='s%i13'></td></tr>"
  "<tr><td class='t1'>Input07</td><td class='s%i14'></td></tr>"
  "<tr><td class='t1'>Input08</td><td class='s%i15'></td></tr>"
  "</table>"
  "<input type='hidden' name='z00' value='0'>"
  "<button type='submit' title='Saves your changes then restarts the Network Module'>Save</button>"
  "<button type='reset' title='Un-does any changes that have not been saved'>Undo All</button>"
  "</form>"
  "%y03/60%y02Refresh</button></form>"
  "%y03/61%y02Configuration</button></form>"
#if UIP_STATISTICS == 1
  "%y03/66%y02Network Statistics</button></form>"
#endif // UIP_STATISTICS == 1
#if HELP_SUPPORT == 1
  "%y03/63%y02Help</button></form>"
#endif // HELP_SUPPORT == 1
  "</body>"
  "</html>";

#endif // GPIO_SUPPORT == 2


#if GPIO_SUPPORT == 3 // Build control for 16 inputs
// IO Control Template
//
// PARSE_BYTES calculation:
// The form contained in this webpage will generate several data update
// replies. These replies need to be parsed to extract the data from them. We
// need to stop parsing the reply POST data after all update bytes are parsed.
// The formula for determining the stop value is as follows:
//   For 1 of the replies (hidden):
//   POST consists of a ParseCmd (a "z" in this case) in 1 byte
//     Followed by the ParseNum in 2 bytes
//     Followed by an equal sign in 1 byte
//     Followed by a state value in 1 byte
//     Followed by a parse delimiter in 1 byte
// The formula is
// PARSEBYTES = (#hidden x 6) - 1
// In this case:(1 x 6) - 1 = 5 bytes
// Note: PARSEBYTES_X and PARSEBYTES_X_ADDL must each be less than 255 and
// the sum of the two must not exceed 482.
#define WEBPAGE_IOCONTROL		0
#define PARSEBYTES_IOCONTROL		5
#define PARSEBYTES_IOCONTROL_ADDL	0
static const unsigned char checked[] = "checked";
static const char g_HtmlPageIOControl[] =
  "%y04%y05%y06"
  "<title>IO Control</title>"
  "</head>"
  "<body>"
  "<h1>IO Control</h1>"
  "<form method='POST' action='/'>"
  "<table>"
  "<tr><td class='t1'>Name:</td><td class='t2'>%a00</td></tr>"
  "</table>"
  "<table>"
  "<tr><td class='t1'>Input01</td><td class='s%i00'></td></tr>"
  "<tr><td class='t1'>Input02</td><td class='s%i01'></td></tr>"
  "<tr><td class='t1'>Input03</td><td class='s%i02'></td></tr>"
  "<tr><td class='t1'>Input04</td><td class='s%i03'></td></tr>"
  "<tr><td class='t1'>Input05</td><td class='s%i04'></td></tr>"
  "<tr><td class='t1'>Input06</td><td class='s%i05'></td></tr>"
  "<tr><td class='t1'>Input07</td><td class='s%i06'></td></tr>"
  "<tr><td class='t1'>Input08</td><td class='s%i07'></td></tr>"
  "<tr><td class='t1'>Input09</td><td class='s%i08'></td></tr>"
  "<tr><td class='t1'>Input10</td><td class='s%i09'></td></tr>"
  "<tr><td class='t1'>Input11</td><td class='s%i10'></td></tr>"
  "<tr><td class='t1'>Input12</td><td class='s%i11'></td></tr>"
  "<tr><td class='t1'>Input13</td><td class='s%i12'></td></tr>"
  "<tr><td class='t1'>Input14</td><td class='s%i13'></td></tr>"
  "<tr><td class='t1'>Input15</td><td class='s%i14'></td></tr>"
  "<tr><td class='t1'>Input16</td><td class='s%i15'></td></tr>"
  "</table>"
  "<input type='hidden' name='z00' value='0'>"
  "<button type='submit' title='Saves your changes then restarts the Network Module'>Save</button>"
  "<button type='reset' title='Un-does any changes that have not been saved'>Undo All</button>"
  "</form>"
  "%y03/60%y02Refresh</button></form>"
  "%y03/61%y02Configuration</button></form>"
#if UIP_STATISTICS == 1
  "%y03/66%y02Network Statistics</button></form>"
#endif // UIP_STATISTICS == 1
#if HELP_SUPPORT == 1
  "%y03/63%y02Help</button></form>"
#endif // HELP_SUPPORT == 1
  "</body>"
  "</html>";
#endif // GPIO_SUPPORT == 3


#if MQTT_SUPPORT == 0
// Configuration webpage Template
//
// PARSE_BYTES calculation:
// The form contained in this webpage will generate several data update
// replies. These replies need to be parsed to extract the data from them. We
// need to stop parsing the reply POST data after all update bytes are parsed.
// The formula for determining the stop value is as follows:
//   For 1 of the replies (device name):
//   POST consists of a ParseCmd (an "a" in this case) in 1 byte
//     Followed by the ParseNum in 2 bytes
//     Followed by an equal sign in 1 byte
//     Followed by a device name in 1 to 19 bytes
//     Followed by a parse delimiter in 1 byte
//   PLUS
//   For 12 of the replies (IP, Gateway, and Netmask fields):
//   POST consists of a ParseCmd (a "b" in this case) in 1 byte
//     Followed by the ParseNum in 2 bytes
//     Followed by an equal sign in 1 byte
//     Followed by a state value in 3 bytes (for 16 of the replies)
//     Followed by a parse delimiter in 1 byte
//   PLUS
//   For 1 of the replies (Port number):
//   POST consists of a ParseCmd (a "c" in this case) in 1 byte
//     Followed by the ParseNum in 2 bytes
//     Followed by an equal sign in 1 byte
//     Followed by a port value in 5 bytes (for 1 of the replies)
//     Followed by a parse delimiter in 1 byte
//   PLUS
//   For 6 of the replies (MAC fields):
//   POST consists of a ParseCmd (a "d" in this case) in 1 byte
//     Followed by the ParseNum in 2 bytes
//     Followed by an equal sign in 1 byte
//     Followed by a state value in 2 bytes (for 6 of the replies)
//     Followed by a parse delimiter in 1 byte
//   PLUS
//   For 1 of the replies (config):
//   POST consists of a ParseCmd (a "g" in this case) in 1 byte
//     Followed by the ParseNum in 2 bytes
//     Followed by an equal sign in 1 byte
//     Followed by a string value in 6 bytes
//     Followed by a parse delimiter in 1 byte
//   PLUS
//   For 1 of the replies (hidden):
//   POST consists of a ParseCmd (a "z" in this case) in 1 byte
//     Followed by the ParseNum in 2 bytes
//     Followed by an equal sign in 1 byte
//     Followed by a state value in 1 byte
//     Followed by a parse delimiter in 1 byte
// THUS
// For 1 of the replies there are 24 bytes in the reply
// For 12 of the replies there are 8 bytes per reply
// For 1 of the replies there are 10 bytes in the reply
// For 6 of the replies there are 7 bytes per reply
// For 1 of the replies there are 11 bytes in the reply
// For 1 of the replies there are 6 bytes per reply
// The formula in this case is PARSEBYTES = (24 x 1)
//                                        + (12 x 8)
//                                        + (1 x 10)
//                                        + (6 x 7)
//                                        + (1 x 11)
//                                        + (1 x 6) - 1
//                             PARSEBYTES =  24
//                                        +  96
//                                        +  10
//                                        +  42
//                                        +  11
//                                        + 6   - 1 = 188
// Note: PARSEBYTES_X and PARSEBYTES_X_ADDL must each be less than 255 and
// the sum of the two must not exceed 482.
#define WEBPAGE_CONFIGURATION		1
#define PARSEBYTES_CONFIGURATION	188
#define PARSEBYTES_CONFIGURATION_ADDL	0
static const char g_HtmlPageConfiguration[] =
  "%y04%y05%y06"
  "<title>Configuration</title>"
  "</head>"
  "<body>"
  "<h1>Configuration</h1>"
  "<form method='POST' action='/'>"
  "<table>"
  "<tr><td class='t1'>Name:</td><td><input name='a00' class='t2' value='%a00' pattern='[0-9a-zA-Z-_*.]{1,19}' title='1 to 19 letters, numbers, and -_*. no spaces' maxlength='19'></td></tr>"
  "</table>"
  "<table>"
  "<tr><td class='t1'>Config</td><td><input name='g00' class='t5' value='%g00' pattern='[0-9a-zA-Z]{6}' title='6 characters required. See Documentation' maxlength='6'></td></tr>"
  "</table>"
  "<p></p>"
  "<table>"
  "<tr><td class='t1'>IP Addr</td><td><input name='b00' class='t6' value='%b00' %y00"
                                 "<td><input name='b01' class='t6' value='%b01' %y00"
                                 "<td><input name='b02' class='t6' value='%b02' %y00"
	                         "<td><input name='b03' class='t6' value='%b03' %y00</tr>"
  "<tr><td class='t1'>Gateway</td><td><input name='b04' class='t6' value='%b04' %y00"
                                 "<td><input name='b05' class='t6' value='%b05' %y00"
                                 "<td><input name='b06' class='t6' value='%b06' %y00"
                                 "<td><input name='b07' class='t6' value='%b07' %y00</tr>"
  "<tr><td class='t1'>Netmask</td><td><input name='b08' class='t6' value='%b08' %y00"
                                 "<td><input name='b09' class='t6' value='%b09' %y00"
                                 "<td><input name='b10' class='t6' value='%b10' %y00"
                                 "<td><input name='b11' class='t6' value='%b11' %y00</tr>"
  "</table>"
  "<table>"
  "<tr><td class='t1'>Port</td><td><input name='c00' class='t8' value='%c00' pattern='[0-9]{5}' title='Enter 00010 to 65535' maxlength='5'></td></tr>"
  "</table>"
  "<table>"
  "<tr><td class='t1'>MAC Address</td><td><input name='d00' class='t7' value='%d00' %y01"
                                     "<td><input name='d01' class='t7' value='%d01' %y01"
                                     "<td><input name='d02' class='t7' value='%d02' %y01"
                                     "<td><input name='d03' class='t7' value='%d03' %y01"
                                     "<td><input name='d04' class='t7' value='%d04' %y01"
                                     "<td><input name='d05' class='t7' value='%d05' %y01</tr>"
  "</table>"
  "<p></p>"
  "<input type='hidden' name='z00' value='0'>"
  "<button type='submit' title='Saves your changes then restarts the Network Module'>Save</button>"
  "<button type='reset' title='Un-does any changes that have not been saved'>Undo All</button>"
  "</form>"
  "<p>"
  "Use caution when changing the above. If you make a mistake you may have to<br>"
  "restore factory defaults by holding down the reset button for 10 seconds.<br><br>"
  "Make sure the MAC you assign is unique to your local network. Recommended<br>"
  "is that you just increment the lowest octet and then label your devices for<br>"
  "future reference.<br><br>"
  "If you change the highest octet of the MAC you MUST use an even number to<br>"
  "form a unicast address. 00, 02, ... fc, fe etc work fine. 01, 03 ... fd, ff are for<br>"
  "multicast and will not work.<br>"
  "Code Revision 20201128 1733</p>"
  "%y03/91%y02Reboot</button></form>"
  "&nbsp&nbspNOTE: Reboot may cause the relays to cycle.<br><br>"
  "%y03/61%y02Refresh</button></form>"
  "%y03/60%y02IO Control</button></form>"
#if UIP_STATISTICS == 1
  "%y03/66%y02Network Statistics</button></form>"
#endif // UIP_STATISTICS == 1
#if HELP_SUPPORT == 1
  "%y03/63%y02Help</button></form>"
#endif // HELP_SUPPORT == 1
  "</body>"
  "</html>";
#endif // MQTT_SUPPORT == 0



#if MQTT_SUPPORT == 1
// Configuration webpage Template
//
// PARSE_BYTES calculation:
// The form contained in this webpage will generate several data update
// replies. These replies need to be parsed to extract the data from them. We
// need to stop parsing the reply POST data after all update bytes are parsed.
// The formula for determining the stop value is as follows:
//   For 1 of the replies (device name):
//   POST consists of a ParseCmd (an "a" in this case) in 1 byte
//     Followed by the ParseNum in 2 bytes
//     Followed by an equal sign in 1 byte
//     Followed by a device name in 1 to 19 bytes
//     Followed by a parse delimiter in 1 byte
//   PLUS
//   For 12 of the replies (IP, Gateway, and Netmask fields):
//   POST consists of a ParseCmd/ParseNum (a "b" in this case) in 1 byte
//     Followed by the ParseNum ("00" to "11") in 2 bytes
//     Followed by an equal sign in 1 byte
//     Followed by a state value in 3 bytes
//     Followed by a parse delimiter in 1 byte
//   PLUS
//   For 1 of the replies (Port number):
//   POST consists of a ParseCmd/ParseNum (a "c" in this case) in 1 byte
//     Followed by the ParseNum (a "00" in this case) in 2 bytes
//     Followed by an equal sign in 1 byte
//     Followed by a port value in 5 bytes
//     Followed by a parse delimiter in 1 byte
//   PLUS
//   For 6 of the replies (MAC fields):
//   POST consists of a ParseCmd (a "d" in this case) in 1 byte
//     Followed by the ParseNum in 2 bytes
//     Followed by an equal sign in 1 byte
//     Followed by a state value in 2 bytes
//     Followed by a parse delimiter in 1 byte
//   PLUS
//   For 1 of the replies (config):
//   POST consists of a ParseCmd (a "g" in this case) in 1 byte
//     Followed by the ParseNum in 2 bytes
//     Followed by an equal sign in 1 byte
//     Followed by a string value in 6 bytes
//     Followed by a parse delimiter in 1 byte
//   PLUS
//   For 4 of the replies (MQTT IP fields):
//   POST consists of a ParseCmd/ParseNum (a "b" in this case) in 1 byte
//     Followed by the ParseNum (a "12" to "15" in this case) in 2 bytes
//     Followed by an equal sign in 1 byte
//     Followed by a state value in 3 bytes
//     Followed by a parse delimiter in 1 byte
//   PLUS
//   For 1 of the replies (MQTT Port field):
//   POST consists of a ParseCmd/ParseNum (a "c" in this case) in 1 byte
//     Followed by the ParseNum (a "01" in this case) in 2 bytes
//     Followed by an equal sign in 1 byte
//     Followed by a port value in 5 bytes
//     Followed by a parse delimiter in 1 byte
//   PLUS
//   For 2 of the replies (MQTT Username and Password):
//   POST consists of a ParseCmd (a "l" or "m" in this case) in 1 byte
//     Followed by the ParseNum in 2 bytes
//     Followed by an equal sign in 1 byte
//     Followed by a name in 10 bytes
//     Followed by a parse delimiter in 1 byte
//   PLUS
//   For 1 of the replies (hidden):
//   POST consists of a ParseCmd (a "z" in this case) in 1 byte
//     Followed by the ParseNum in 2 bytes
//     Followed by an equal sign in 1 byte
//     Followed by a state value in 1 byte
//     Followed by a parse delimiter in 1 byte
// THUS
// For 1 of the replies there are 24 bytes in the reply
// For 12 of the replies there are 8 bytes per reply
// For 1 of the replies there are 10 bytes in the reply
// For 6 of the replies there are 7 bytes per reply
// For 1 of the replies there are 11 bytes in the reply
// For 4 of the replies there are 8 bytes per reply
// For 1 of the replies there are 10 bytes per reply
// For 1 of the replies there are 6 bytes per reply
// The formula in this case is
//     PARSEBYTES = (24 x 1)
//                + (12 x 8) 
//                + (1 x 10) 
//                + (6 x 7) 
//                + (1 x 11) 
//                + (4 x 8) 
//                + (1 x 10)
//                + (2 x 15)
//                + (1 x 6) - 1
//     PARSEBYTES = 24
//                + 96
//                + 10
//                + 42
//                + 11
//                + 32
//                + 10
//                + 30
//                + 6 - 1 = 236
// Note: PARSEBYTES_X and PARSEBYTES_X_ADDL must each be less than 255 and
// the sum of the two must not exceed 482.
#define WEBPAGE_CONFIGURATION		1
#define PARSEBYTES_CONFIGURATION	236
#define PARSEBYTES_CONFIGURATION_ADDL	24
static const char g_HtmlPageConfiguration[] =
  "%y04%y05%y06"
  "<title>Configuration</title>"
  "</head>"
  "<body>"
  "<h1>Configuration</h1>"
  "<form method='POST' action='/'>"
  "<table>"
  "<tr><td class='t1'>Name:</td><td><input name='a00' class='t2' value='%a00' pattern='[0-9a-zA-Z-_*.]{1,19}' required title='1 to 19 letters, numbers, and -_*. no spaces' maxlength='19'></td></tr>"
  "</table>"
  "<table>"
  "<tr><td class='t1'>Config</td><td><input name='g00' class='t5' value='%g00' pattern='[0-9a-zA-Z]{6}' title='6 characters required. See Documentation' maxlength='6'></td></tr>"
  "</table>"
  "<p></p>"
  "<table>"
  "<tr><td class='t1'>IP Address</td><td><input name='b00' class='t6' value='%b00' %y00"
                                 "<td><input name='b01' class='t6' value='%b01' %y00"
                                 "<td><input name='b02' class='t6' value='%b02' %y00"
	                         "<td><input name='b03' class='t6' value='%b03' %y00</tr>"
  "<tr><td class='t1'>Gateway</td><td><input name='b04' class='t6' value='%b04' %y00"
                                 "<td><input name='b05' class='t6' value='%b05' %y00"
                                 "<td><input name='b06' class='t6' value='%b06' %y00"
                                 "<td><input name='b07' class='t6' value='%b07' %y00</tr>"
  "<tr><td class='t1'>Netmask</td><td><input name='b08' class='t6' value='%b08' %y00"
                                 "<td><input name='b09' class='t6' value='%b09' %y00"
                                 "<td><input name='b10' class='t6' value='%b10' %y00"
                                 "<td><input name='b11' class='t6' value='%b11' %y00</tr>"
  "</table>"
  "<table>"
  "<tr><td class='t1'>Port</td><td><input name='c00' class='t8' value='%c00' pattern='[0-9]{5}' title='Enter 00010 to 65535' maxlength='5'></td></tr>"
  "</table>"
  "<table>"
  "<tr><td class='t1'>MAC Address</td><td><input name='d00' class='t7' value='%d00' %y01"
                                     "<td><input name='d01' class='t7' value='%d01' %y01"
                                     "<td><input name='d02' class='t7' value='%d02' %y01"
                                     "<td><input name='d03' class='t7' value='%d03' %y01"
                                     "<td><input name='d04' class='t7' value='%d04' %y01"
                                     "<td><input name='d05' class='t7' value='%d05' %y01</tr>"
  "</table>"
  "<p></p>"
  "<table>"
  "<tr><td class='t1'>MQTT Server</td><td><input name='b12' class='t6' value='%b12' %y00"
                                     "<td><input name='b13' class='t6' value='%b13' %y00"
                                     "<td><input name='b14' class='t6' value='%b14' %y00"
	                             "<td><input name='b15' class='t6' value='%b15' %y00</tr>"
  "</table>"
  "<table>"
  "<tr><td class='t1'>MQTT Port</td><td><input name='c01' class='t8' value='%c01' pattern='[0-9]{5}' title='Enter 00010 to 65535' maxlength='5'></td></tr>"
  "</table>"
  "<table>"
  "<tr><td class='t1'>MQTT Username</td><td><input name='l00' class='t1' value='%l00' pattern='[0-9a-zA-Z-_*.]{0,10}' title='0 to 10 letters, numbers, and -_*. no spaces. Use none for no entry.' maxlength='10'></td></tr>"
  "<tr><td class='t1'>MQTT Password</td><td><input name='m00' class='t1' value='%m00' pattern='[0-9a-zA-Z-_*.]{0,10}' title='0 to 10 letters, numbers, and -_*. no spaces. Use none for no entry.' maxlength='10'></td></tr>"
  "</table>"
  "<table>"
  "<tr><td class='t1'>MQTT Status  </td><td class='s%n00'></td><td class='s%n01'></td><td class='s%n02'></td><td class='s%n03'></td><td class='s%n04'></td></tr>"
  "</table>"
  "<p></p>"
  "<input type='hidden' name='z00' value='0'>"
  "<button type='submit'>Save</button>"
  "<button type='reset'>Undo All</button>"
  "</form>"
  "<p>"
  "See Documentation for help<br>"
  "Code Revision 20201128 1733</p>"
  "%y03/91%y02Reboot</button></form>"
  "<br><br>"
  "%y03/61%y02Refresh</button></form>"
  "%y03/60%y02IO Control</button></form>"
#if UIP_STATISTICS == 1
  "%y03/66%y02Network Statistics</button></form>"
#endif // UIP_STATISTICS == 1
#if UIP_STATISTICS == 2
  "%y03/66%y02Error Statistics</button></form>"
#endif // UIP_STATISTICS == 2
#if HELP_SUPPORT == 1
  "%y03/63%y02Help</button></form>"
#endif // HELP_SUPPORT == 1
  "</body>"
  "</html>";
#endif // MQTT_SUPPORT == 1



#if HELP_SUPPORT == 1

#if GPIO_SUPPORT == 1 // Build control for 16 outputs
// Help page Template
#define WEBPAGE_HELP		3
#define PARSEBYTES_HELP		0
static const char g_HtmlPageHelp[] =
  "<!DOCTYPE html>"
  "<html lang='en-US'>"
  "<head>"
  "<title>Help Page</title>"
  "<link rel='icon' href='data:,'>"
  "<style>"
  "td { width: 140px; padding: 0px; }"
  "</style>"
  "</head>"
  "<body>"
  "<h1>Help Page 1</h1>"
  "<p>"
  "An alternative to using the web interface for changing relay states is to send relay<br>"
  "specific html commands. Enter http://IP:Port/xx where<br>"
  "- IP = the device IP Address, for example 192.168.1.4<br>"
  "- Port = the device Port number, for example 8080<br>"
  "- xx = one of the codes below:<br>"
  "<table>"
  "<tr><td>00 = Relay-01 OFF</td><td>09 = Relay-05 OFF</td><td>17 = Relay-09 OFF</td><td>25 = Relay-13 OFF<br></td></tr>"
  "<tr><td>01 = Relay-01  ON</td><td>10 = Relay-05  ON</td><td>18 = Relay-09  ON</td><td>26 = Relay-13  ON<br></td></tr>"
  "<tr><td>02 = Relay-02 OFF</td><td>11 = Relay-06 OFF</td><td>19 = Relay-10 OFF</td><td>27 = Relay-14 OFF<br></td></tr>"
  "<tr><td>03 = Relay-02  ON</td><td>12 = Relay-06  ON</td><td>20 = Relay-10  ON</td><td>28 = Relay-14  ON<br></td></tr>"
  "<tr><td>04 = Relay-03 OFF</td><td>13 = Relay-07 OFF</td><td>21 = Relay-11 OFF</td><td>29 = Relay-15 OFF<br></td></tr>"
  "<tr><td>05 = Relay-03  ON</td><td>14 = Relay-07  ON</td><td>22 = Relay-11  ON</td><td>30 = Relay-15  ON<br></td></tr>"
  "<tr><td>07 = Relay-04 OFF</td><td>15 = Relay-08 OFF</td><td>23 = Relay-12 OFF</td><td>31 = Relay-16 OFF<br></td></tr>"
  "<tr><td>08 = Relay-04  ON</td><td>16 = Relay-08  ON</td><td>24 = Relay-12  ON</td><td>32 = Relay-16  ON<br></td></tr>"
  "</table>"
  "55 = All Relays ON<br>"
  "56 = All Relays OFF<br><br>"
  "The following are also available:<br>"
  "60 = Show IO Control page<br>"
  "61 = Show Configuration page<br>"
  "63 = Show Help Page 1<br>"
  "64 = Show Help Page 2<br>"
  "65 = Flash LED<br>"
  "66 = Show Statistics<br>"
  "67 = Clear Statistics<br>"
  "91 = Reboot<br>"
  "99 = Show Short Form IO Settings<br>"
  "</p>"
  "%y03/64' method='GET'><button title='Go to next Help page'>Next Help Page</button></form>"
  "</body>"
  "</html>";
#endif // GPIO_SUPPORT == 1


#if GPIO_SUPPORT == 2 // Build control for 8 outputs / 8 inputs
// Help page Template
#define WEBPAGE_HELP		3
#define PARSEBYTES_HELP		0
static const char g_HtmlPageHelp[] =
  "<!DOCTYPE html>"
  "<html lang='en-US'>"
  "<head>"
  "<title>Help Page</title>"
  "<link rel='icon' href='data:,'>"
  "<style>"
  "td { width: 140px; padding: 0px; }"
  "</style>"
  "</head>"
  "<body>"
  "<h1>Help Page 1</h1>"
  "<p>"
  "An alternative to using the web interface for changing relay states is to send relay<br>"
  "specific html commands. Enter http://IP:Port/xx where<br>"
  "- IP = the device IP Address, for example 192.168.1.4<br>"
  "- Port = the device Port number, for example 8080<br>"
  "- xx = one of the codes below:<br>"
  "<table>"
  "<tr><td>00 = Relay-01 OFF</td><td>09 = Relay-05 OFF<br></td></tr>"
  "<tr><td>01 = Relay-01  ON</td><td>10 = Relay-05  ON<br></td></tr>"
  "<tr><td>02 = Relay-02 OFF</td><td>11 = Relay-06 OFF<br></td></tr>"
  "<tr><td>03 = Relay-02  ON</td><td>12 = Relay-06  ON<br></td></tr>"
  "<tr><td>04 = Relay-03 OFF</td><td>13 = Relay-07 OFF<br></td></tr>"
  "<tr><td>05 = Relay-03  ON</td><td>14 = Relay-07  ON<br></td></tr>"
  "<tr><td>07 = Relay-04 OFF</td><td>15 = Relay-08 OFF<br></td></tr>"
  "<tr><td>08 = Relay-04  ON</td><td>16 = Relay-08  ON<br></td></tr>"
  "</table>"
  "55 = All Relays ON<br>"
  "56 = All Relays OFF<br><br>"
  "The following are also available:<br>"
  "60 = Show IO Control page<br>"
  "61 = Show Configuration page<br>"
  "63 = Show Help Page 1<br>"
  "64 = Show Help Page 2<br>"
  "65 = Flash LED<br>"
  "66 = Show Statistics<br>"
  "67 = Clear Statistics<br>"
  "91 = Reboot<br>"
  "99 = Show Short Form IO Status<br>"
  "</p>"
  "%y03/64' method='GET'><button title='Go to next Help page'>Next Help Page</button></form>"
  "</body>"
  "</html>";
#endif // GPIO_SUPPORT == 2


#if GPIO_SUPPORT == 3 // Build control for 16 inputs
// Help page Template
#define WEBPAGE_HELP		3
#define PARSEBYTES_HELP		0
static const char g_HtmlPageHelp[] =
  "<!DOCTYPE html>"
  "<html lang='en-US'>"
  "<head>"
  "<title>Help Page</title>"
  "<link rel='icon' href='data:,'>"
  "<style>"
  "td { width: 140px; padding: 0px; }"
  "</style>"
  "</head>"
  "<body>"
  "<h1>Help Page 1</h1>"
  "<p>"
  "REST commands<br>"
  "Enter http://IP:Port/xx where<br>"
  "- IP = the device IP Address, for example 192.168.1.4<br>"
  "- Port = the device Port number, for example 8080<br>"
  "- xx = one of the codes below:<br>"
  "60 = Show IO Control page<br>"
  "61 = Show Configuration page<br>"
  "63 = Show Help Page 1<br>"
  "64 = Show Help Page 2<br>"
  "65 = Flash LED<br>"
  "66 = Show Statistics<br>"
  "67 = Clear Statistics<br>"
  "91 = Reboot<br>"
  "99 = Show Short Form IO Status<br>"
  "</p>"
  "%y03/64' method='GET'><button title='Go to next Help page'>Next Help Page</button></form>"
  "</body>"
  "</html>";
#endif // GPIO_SUPPORT == 3
  
#endif // HELP_SUPPORT == 1



#if HELP_SUPPORT == 1
// Help page 2 Template
#define WEBPAGE_HELP2		4
#define PARSEBYTES_HELP2	0
static const char g_HtmlPageHelp2[] =
  "<!DOCTYPE html>"
  "<html lang='en-US'>"
  "<head>"
  "<link rel='icon' href='data:,'>"
  "<title>Help Page 2</title>"
  "</head>"
  "<body>"
  "<h1>Help Page 2</h1>"
  "<p>"
  "IP Address, Gateway Address, Netmask, Port, and MAC Address can only be<br>"
  "changed via the web interface. If the device becomes inaccessible you can<br>"
  "reset to factory defaults by holding the reset button down for 10 seconds.<br>"
  "Defaults:<br>"
  " IP 192.168.1.4<br>"
  " Gateway 192.168.1.1<br>"
  " Netmask 255.255.255.0<br>"
  " Port 08080<br>"
  " MAC c2-4d-69-6b-65-00<br><br>"
  " Config Field:<br>"
  " - 1st character: Output Invert  0 = off, 1 = on<br>"
  " - 2nd character: Input Invert 0 = off, 1 = on<br>"
  " - 3rd character: Output Retain Control:<br>"
  " --- 0 = Turn OFF all outputs on power cycle<br>"
  " --- 1 = Turn ON all outputs on power cycle<br>"
  " --- 2 = Retain previous state of all outputs on power cycle (default)<br>"
  " - 4th character: Full/Half Duplex Ethernet Control:<br>"
  " --- 0 = Half duplex (default)<br>"
  " --- 1 = Full duplex</p>"
  "%y03/60' method='GET'><button title='Go to IO Control Page'>IO Control</button></form>"
  "</body>"
  "</html>";
#endif // HELP_SUPPORT == 1



#if UIP_STATISTICS == 1
// Statistics page Template
#define WEBPAGE_STATS		5
static const char g_HtmlPageStats[] =
  "<!DOCTYPE html>"
  "<html lang='en-US'>"
  "<head>"
  "<title>Network Statistics</title>"
  "<link rel='icon' href='data:,'>"
  "<style>"
  ".t1 { width: 100px; }"
  ".t2 { width: 450px; }"
  "td { border: 1px black solid; }"
  "</style>"
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
  "%y03/60' method='GET'><button title='Go to IO Control Page'>IO Control</button></form>"
  "%y03/67' method='GET'><button title='Clear Statistics'>Clear Statistics</button></form>"
  "</body>"
  "</html>";
#endif /* UIP_STATISTICS == 1 */



#if UIP_STATISTICS == 2
// Statistics page Template
#define WEBPAGE_STATS		5
static const char g_HtmlPageStats[] =
  "<!DOCTYPE html>"
  "<html lang='en-US'>"
  "<head>"
  "<link rel='icon' href='data:,'>"
  "</head>"
  "<body>"
  "<table>"
  "<tr><td>Seconds since boot %e26</td></tr>"
  "<tr><td>RXERIF count %e27</td></tr>"
  "<tr><td>TXERIF count %e28</td></tr>"
  "<tr><td>TRANSMIT count %e29</td></tr>"
  "</table>"
  "%y03/61' method='GET'><button>Configuration</button></form>"
  "%y03/66' method='GET'><button>Refresh</button></form>"
  "</body>"
  "</html>";
#endif // UIP_STATISTICS == 2


// Shortened IO state page Template
// Mimics original Network Module relay state report
// 135 bytes; sizeof reports 136
#define WEBPAGE_RSTATE		6
static const char g_HtmlPageRstate[] =
  "<!DOCTYPE html>"
  "<html lang='en-US'>"
  "<head>"
  "<title>Help Page 2</title>"
  "<link rel='icon' href='data:,'>"
  "</head>"
  "<body>"
  "<p>%f00</p>"
  "</body>"
  "</html>";



// Commonly used strings in the HTML pages. These strings are inserted in
// the HTML page during copy of the HTML page template to the transmit
// buffer when the associated "%yxx" placeholder is encountered in the
// template. The length of each string is manually counted and put in the
// _len value. When the _len value is needed it often has 4 subtracted
// (as the strings are replacing the 4 character placeholder), so that
// subtraction is done once here.

// String for %y00 replacement in web page templates
static const char page_string00[] =
  "pattern='[0-9]{3}' title='Enter 000 to 255' maxlength='3'></td>";
static const uint8_t page_string00_len = 63;
static const uint8_t page_string00_len_less4 = 59;
  
// String for %y01 replacement in web page templates
static const char page_string01[] =
  "pattern='[0-9a-f]{2}' title='Enter 00 to ff' maxlength='2'></td>";
static const uint8_t page_string01_len = 64;
static const uint8_t page_string01_len_less4 = 60;
  
// String for %y02 replacement in web page templates
static const char page_string02[] =
  "' method='GET'><button title='Save first! This button will not save your changes'>";
static const uint8_t page_string02_len = 82;
static const uint8_t page_string02_len_less4 = 78;

// String for %y03 replacement in web page templates.
static const char page_string03[] =
  "<form style='display: inline' action='";
static const uint8_t page_string03_len = 38;
static const uint8_t page_string03_len_less4 = 34;

// String for %y04 replacement in web page templates. When used this
// string is always followed by the %y05 and %y06 strings
static const char page_string04[] =
  "<!DOCTYPE html>"
  "<html lang='en-US'>"
  "<head>"
  "<link rel='icon' href='data:,'>";
static const uint8_t page_string04_len = 71;
static const uint8_t page_string04_len_less4 = 67;

// String for %y05 replacement in web page templates. When used this
// string is always follows the %y04 string, and is always followed
// by the %y06 string.
static const char page_string05[] =
  "<style>"
  ".s0 { background-color: red; width: 30px; }"
  ".s1 { background-color: green; width: 30px; }"
  ".t1 { width: 120px; }"
  ".t2 { width: 148px; }"
  ".t3 { width: 30px; }"
  ".t5 { width: 60px; }"
  ".t6 { width: 25px; }"
  ".t7 { width: 18px; }"
  ".t8 { width: 40px; }";
static const uint8_t page_string05_len = 237;
static const uint8_t page_string05_len_less4 = 233;

// String for %y06 replacement in web page templates. When used this
// string always follows the %y04 and %y05 strings.
static const char page_string06[] =
  "td { text-align: center; border: 1px black solid; }"
  "</style>";
static const uint8_t page_string06_len = 59;
static const uint8_t page_string06_len_less4 = 55;

// .........1.........2.........3.........4.........5.........6.........7.........8.........9.........0.........1.........2.........3.........4.........5.........6.........7.........8.........9.........0.........1.........2.........3.........4.........5.........6


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

    // Account for header replacement strings %y04 %y05 %y06
    size = size + page_string04_len_less4
                + page_string05_len_less4
		+ page_string06_len_less4;

    // Account for Device Name field %a00
    // This can be variable in size during run time so we have to calculate it
    // each time we display the web page.
    size = size + strlen(stored_devicename) - 4 ;

    // Account for red/green state boxes %i00
    // There are always 16 boxes, one for each input/output
    // size = size + (#instances x (value_size - marker_field_size));
    // size = size + (#instances x (1 - 4));
    // size = size + (16 x (-3));
    size = size - 48;

    // Account for Relay on/off radio buttons %o00 and %p00
    // The number of instances depends on the GPIO_SUPPORT value (16 outputs,
    // 8 outputs, or 0 outputs). There is a %o00 and a %p00 for each output,
    // but only one of those two fields will be replaced with a value (the
    // value being the 7 byte string "checked").
    // size = size + (#instances x (value_size - marker_field_size));
    // size = size + (#instances x (7 - (2 x 4)));
    // size = size + (#instances x (-1));
#if GPIO_SUPPORT == 1
    // size = size + (16 x (-1));
    size = size - 16;
#endif // GPIO_SUPPORT == 1
#if GPIO_SUPPORT == 2
    // size = size + (8 x (-1));
    size = size - 8;
#endif // GPIO_SUPPORT == 2
#if GPIO_SUPPORT == 3
    // size = size + (0 x (-1));
    // size = size - 0;
#endif // GPIO_SUPPORT == 3

    // Account for IP Address insertion %y03 - Refresh Button
    // size = size + (strlen(page_string03) - marker_field_size);
    // size = size + (strlen(page_string03) - 4);
    // AND
    // Account for IP Address insertion %y03 - Configuration Button
    // size = size + (strlen(page_string03) - marker_field_size);
    // size = size + (strlen(page_string03) - 4);
    size = size + (2 * page_string03_len_less4);

#if UIP_STATISTICS == 1
    // Account for IP Address insertion %y03 - Network Statistics Button
    // size = size + (strlen(page_string03) - marker_field_size);
    // size = size + (strlen(page_string03) - 4);
    size = size + page_string03_len_less4;
#endif // UIP_STATISTICS == 1

#if HELP_SUPPORT == 1
    // Account for IP Address insertion %y03 - Help Button
    // size = size + (strlen(page_string03) - marker_field_size);
    // size = size + (strlen(page_string03) - 4);
    size = size + page_string03_len_less4;
#endif // HELP_SUPPORT == 1

    // Account for Text Replacement insertion
    // Some strings appear frequently in the templates - things like the
    // button titles which appear when hovering over a button. These strings
    // are inserted on the fly when the web page is sent to the browser, so
    // they have to be accounted for in the size of the web page.
    
    // String for %y02 in web page template
    // There are 2 instances (Refresh and Configuration buttons)
    // page_string02[] = "<button title='Save first! This button will not save your changes'>"; 67 bytes
    // size = size + (#instances) x ((strlen(page_string02) - marker_field_size);
    // size = size + (2) x ((strlen(page_string02) - 4);
    // size = size + (2) x (67 - 4);
    // size = size + (2) x (63);
    size = size + (2 * (page_string02_len_less4));
    
#if UIP_STATISTICS == 1
    // There is 1 more %y02 instance (Statistics button)
    // size = size + (1) x (63);
    size = size + page_string02_len_less4;
#endif // UIP_STATISTICS == 1

#if HELP_SUPPORT == 1
    // There is 1 more %y02 instance (Help button)
    // size = size + (1) x (63);
    size = size + page_string02_len_less4;
#endif // HELP_SUPPORT == 1
  }


  /*---------------------------------------------------------------------------*/
  // Adjust the size reported by the WEBPAGE_CONFIGURATION template
  //
  else if (current_webpage == WEBPAGE_CONFIGURATION) {
    size = (uint16_t)(sizeof(g_HtmlPageConfiguration) - 1);

    // Account for header replacement strings %y04 %y05 %y06
    size = size + page_string04_len_less4
                + page_string05_len_less4
		+ page_string06_len_less4;

    // Account for Device Name field %a00
    // This can be variable in size during run time so we have to calculate it
    // each time we display the web page.
    size = size + strlen(stored_devicename) - 4 ;

    // Account for IP Address, Gateway Address, and Netmask fields %b00 to %b11
    // There are 12 instances of these fields
    // size = size + (#instances x (value_size - marker_field_size));
    // size = size + (12 x (3 - 4));
    // size = size + (12 x (-1));
    size = size - 12;

    // Account for Port field %c00
    // There is 1 instance of this field
    // size = size + (#instances x (value_size - marker_field_size));
    // size = size + (1 x (5 - 4));
    // size = size + (1 x (1));
    size = size + 1;

    // Account for MAC fields %d00 to %d05
    // There are 6 instances of these fields
    // size = size + (#instances x (value_size - marker_field_size));
    // size = size + (6 x (2 - 4));
    // size = size + (6 x (- 2));
    size = size - 12;

    // Account for Config string %g00
    // There is 1 instance
    // value_size is 6 (6 characters)
    // size = size + (#instances x (value_size - marker_field_size));
    // size = size + (#instances x (6 - 4));
    // size = size + (1 x (2));
    size = size + 2;

#if MQTT_SUPPORT == 1
    // Account for MQTT Server IP Address fields %b12 to %b15
    // There are 4 instances of these fields
    // size = size + (#instances x (value_size - marker_field_size));
    // size = size + (4 x (3 - 4));
    // size = size + (4 x (-1));
    size = size - 4;

    // Account for MQTT Port field %k00
    // There is 1 instance of this field
    // size = size + (#instances x (value_size - marker_field_size));
    // size = size + (1 x (5 - 4));
    // size = size + (1 x (1));
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
#endif // MQTT_SUPPORT == 1

    // Account for IP Address insertion %y03 - Reboot Button
    // size = size + (strlen(page_string03) - marker_field_size);
    // size = size + (strlen(page_string03) - 4);
    // AND
    // Account for IP Address insertion %y03 - Refresh Button
    // size = size + (strlen(page_string03) - marker_field_size);
    // size = size + (strlen(page_string03) - 4);
    // AND
    // Account for IP Address insertion %y03 - I/O Control Button
    // size = size + (strlen(page_string03) - marker_field_size);
    // size = size + (strlen(page_string03) - 4);
    size = size + (3 * page_string03_len_less4);

#if UIP_STATISTICS == 1 || UIP_STATISTICS == 2
    // Account for IP Address insertion %y03 - Network Statistics Button
    // size = size + (strlen(page_string03) - marker_field_size);
    // size = size + (strlen(page_string03) - 4);
    size = size + page_string03_len_less4;
#endif // UIP_STATISTICS == 1 || UIP_STATISTICS == 2

#if HELP_SUPPORT == 1
    // Account for IP Address insertion %y03 - Help Button
    // size = size + (strlen(page_string03) - marker_field_size);
    // size = size + (strlen(page_string03) - 4);
    size = size + page_string03_len_less4;
#endif // HELP_SUPPORT == 1

    // Account for Text Replacement insertion
    // Some strings appear frequently in the templates - things like the
    // button titles which appear when hovering over a button. These strings
    // are inserted on the fly when the web page is sent to the browser, so
    // they have to be accounted for in the size of the web page.
    
    // String for %y00 in web page templates
    // There are 12 instances (one for each 3 character field)
    // page_string00[] = "pattern='[0-9]{3}' title='Enter 000 to 255' maxlength='3'"; 57 bytes
    // size = size + (#instances x (value_size - marker_field_size));
    // size = size + (#instances) x ((strlen(page_string00) - 4);
    // size = size + (12) x (57 - 4);
    // size = size + (12) x (53);
    size = size + (12 * (page_string00_len_less4));
#if MQTT_SUPPORT == 1
    // String for %y00 in web page templates
    // There are 4 more instances (one for each 3 character field)
    // page_string00[] = "pattern='[0-9]{3}' title='Enter 000 to 255' maxlength='3'"; 57 bytes
    // size = size + (#instances x (value_size - marker_field_size));
    // size = size + (#instances) x ((strlen(page_string00) - 4);
    // size = size + (4) x (57 - 4);
    // size = size + (4) x (53);
    size = size + (4 * (page_string00_len_less4));
#endif // MQTT_SUPPORT == 1

    // String for %y01 in web page templates
    // There are 6 instances (one for each 2 character field)
    // page_string01[] = "pattern='[0-9a-f]{2}' title='Enter 00 to ff' maxlength='2'"; 58 bytes
    // size = size + (#instances) x ((strlen(page_string01) - marker_field_size);
    // size = size + (6) x ((strlen(page_string01) - 4);
    // size = size + (6) x (58 - 4);
    // size = size + (6) x (54);
    size = size + (6 * (page_string01_len_less4));
        
    // String for %y02 in web page templates
    // There are 3 instances (Reboot, Refresh, and IO Control buttons)
    // page_string02[] = "<button title='Save first! This button will not save your changes'>"; 67 bytes
    // size = size + (#instances x (value_size - marker_field_size));
    // size = size + (#instances) x ((strlen(page_string00) - 4);
    // size = size + (3) x (67 - 4);
    // size = size + (3) x (63);
    size = size + (3 * (page_string02_len_less4));
    
#if UIP_STATISTICS == 1
    // There is 1 more %y02 instance (Statistics button)
    // size = size + (#instances x (value_size - marker_field_size));
    // size = size + (1) x (67 - 4);
    // size = size + (1) x (63);
    size = size + page_string02_len_less4;
#endif // UIP_STATISTICS == 1

#if UIP_STATISTICS == 2
    // There is 1 more %y02 instance (Statistics button)
    // size = size + (#instances x (value_size - marker_field_size));
    // size = size + (1) x (67 - 4);
    // size = size + (1) x (63);
    size = size + page_string02_len_less4;
#endif // UIP_STATISTICS == 2

#if HELP_SUPPORT == 1
    // There is 1 more %y02 instance (Help button)
    // size = size + (#instances x (value_size - marker_field_size));
    // size = size + (1) x (67 - 4);
    // size = size + (1) x (63);
    size = size + page_string02_len_less4;
#endif // HELP_SUPPORT == 1
  }


#if HELP_SUPPORT == 1
  /*---------------------------------------------------------------------------*/
  // Adjust the size reported by the WEBPAGE_HELP template
  //
  else if (current_webpage == WEBPAGE_HELP) {
    size = (uint16_t)(sizeof(g_HtmlPageHelp) - 1);

    // Account for IP Address insertion - Next Help Page Button
    // size = size + (strlen(page_string03) - marker_field_size);
    // size = size + (strlen(page_string03) - 4);
    size = size + page_string03_len_less4;
    }

  /*---------------------------------------------------------------------------*/
  // Adjust the size reported by the WEBPAGE_HELP2 template
  //
  else if (current_webpage == WEBPAGE_HELP2) {
    size = (uint16_t)(sizeof(g_HtmlPageHelp2) - 1);

    // Account for IP Address insertion - IO Control Button
    // size = size + (strlen(page_string03) - marker_field_size);
    // size = size + (strlen(page_string03) - 4);
    size = size + page_string03_len_less4;
    }
#endif // HELP_SUPPORT == 1


#if UIP_STATISTICS == 1
  /*---------------------------------------------------------------------------*/
  // Adjust the size reported by the WEBPAGE_STATS template
  //
  else if (current_webpage == WEBPAGE_STATS) {
    size = (uint16_t)(sizeof(g_HtmlPageStats) - 1);

    // Account for Statistics fields %e00 to %e21
    // There are 22 instances of these fields
    // size = size + (#instances x (value_size - marker_field_size));
    // size = size + (22 x (10 - 4));
    // size = size + (22 x (6));
    size = size + 132;

    // Account for IP Address insertion - Configuration Button
    // size = size + (strlen(page_string03) - marker_field_size);
    // size = size + (strlen(page_string03) - 4);
    // AND
    // Account for IP Address insertion - Refresh Button
    // size = size + (strlen(page_string03) - marker_field_size);
    // size = size + (strlen(page_string03) - 4);
    // AND
    // Account for IP Address insertion - Clear Statistics Button
    // size = size + (strlen(page_string03) - marker_field_size);
    // size = size + (strlen(page_string03) - 4);
    size = size + (3 * page_string03_len_less4);
  }
#endif // UIP_STATISTICS == 1


#if UIP_STATISTICS == 2
  /*---------------------------------------------------------------------------*/
  // Adjust the size reported by the WEBPAGE_STATS template
  //
  else if (current_webpage == WEBPAGE_STATS) {
    size = (uint16_t)(sizeof(g_HtmlPageStats) - 1);

    // Account for Statistics fields %e26 to %e29
    // There are 4 instances of these fields
    // size = size + (#instances x (value_size - marker_field_size));
    // size = size + (4 x (10 - 4));
    // size = size + (4 x (6));
    size = size + 24;

    // Account for IP Address insertion - Configuration Button
    // size = size + (strlen(page_string03) - marker_field_size);
    // size = size + (strlen(page_string03) - 4);
    // AND
    // Account for IP Address insertion - Refresh Button
    // size = size + (strlen(page_string03) - marker_field_size);
    // size = size + (strlen(page_string03) - 4);
    size = size + (2 * page_string03_len_less4);
  }
#endif // UIP_STATISTICS == 2


  /*---------------------------------------------------------------------------*/
  // Adjust the size reported by the WEBPAGE_RSTATE template
  //
  else if (current_webpage == WEBPAGE_RSTATE) {
    size = (uint16_t)(sizeof(g_HtmlPageRstate) - 1);
    
    // Account for Short Form Relay Settings field (%f00)
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
  // Positive numbers ONLY,
  //   Up to 10 digits (32 bits),
  //   Includes leading 0 pad,
  //   Converts base 2 (binary), 8 (nibbles), 10 (decimal), 16 (hex)

  uint8_t i;
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


static uint16_t CopyHttpHeader(uint8_t* pBuffer, uint16_t nDataLen)
{
  uint16_t nBytes;
  uint8_t i;

  nBytes = 0;

  nBytes += CopyStringP(&pBuffer, (const char *)("HTTP/1.1 200 OK"));
  nBytes += CopyStringP(&pBuffer, (const char *)("\r\n"));

  nBytes += CopyStringP(&pBuffer, (const char *)("Content-Length:"));
  
//  nBytes += CopyValue(&pBuffer, nDataLen);
  // This creates a 5 character "Content-Length:xxxxx" field in the pBuffer.
  emb_itoa(nDataLen, OctetArray, 10, 5);
  for (i=0; i<5; i++) {
    *pBuffer = (uint8_t)OctetArray[i];
    pBuffer = pBuffer + 1;
  }
  nBytes += 5;

  nBytes += CopyStringP(&pBuffer, (const char *)("\r\n"));

//  nBytes += CopyStringP(&pBuffer, (const char *)("Cache-Control: no-cache, no-store, must-revalidate\r\n"));
  nBytes += CopyStringP(&pBuffer, (const char *)("Cache-Control: no-cache, no-store\r\n"));

  nBytes += CopyStringP(&pBuffer, (const char *)("Content-Type: text/html; charset=utf-8\r\n"));
//  nBytes += CopyStringP(&pBuffer, (const char *)("Content-Type:text/html\r\n"));
  nBytes += CopyStringP(&pBuffer, (const char *)("Connection:close\r\n"));
  nBytes += CopyStringP(&pBuffer, (const char *)("\r\n"));

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
    
  uint16_t nBytes;
  uint8_t nByte;
  uint8_t nParsedNum;
  uint8_t nParsedMode;
  uint8_t temp;
  uint8_t i;
  uint8_t j;
  uint8_t no_err;
  unsigned char temp_octet[3];

  nBytes = 0;
  nParsedNum = 0;
  nParsedMode = 0;

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
  // nMaxbytes must be 21 bytes smaller than UIP_TCP_MSS due to the need to
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
  nMaxBytes = UIP_TCP_MSS - 25;
  // XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX

  while (nBytes < nMaxBytes) {
    // This is the main loop for processing the page templates stored in
    // flash and inserting variable data as the webpage is copied to the
    // transmission buffer.
    //
    // The variable nBytes tracks the amount of data written to the
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
    // 1) If nBytes exceeds nMaxBytes.
    // 2) If *pDataLeft reaches a count of zero.
    // If the loop terminates and there is still data left to transmit (as
    // indicated by pDataLeft > 0) the calling routine will call the function
    // again.
    //
    // Normally one pass of this loop copies one character from the webpage
    // template to the transmission buffer. However, up to ~75 bytes can be
    // copied to the transmission buffer (for instance when one of the
    // "replacement strings" (like %y00) is processed. For this reason nBytes
    // might exceed nMaxBytes by up to 75 bytes if the code does not pre
    // compensate for it. This is why nMaxBytes is set well below MAXFRAME.
    //
    
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
      
        memcpy(&nByte, *ppData, 1);

        // Search for '%' symbol in the data stream. The symbol indicates the
	// start of one of these special fields:
        // %i - Pin state - shows the current state of the GPIO pins. Output
	//      only.
        // %o - "ON" radio button to control the state of a GPIO pin. In this
        //      application the GPIO pins are used to control relays. Input
	//      and output.
        // %p - "OFF" radio button to control the state of a GPIO pin. In this
        //      application the GPIO pins are used to control relays. Input
	//      and output.
        // %a - A user entered text field with a device name. Used for GUI
	//      display so the user can easily tell what device they are
	//      connected to. Also used as part of the MQTT Topic name. Input
	//      and output. Max 19 chars.
        // %b - Address values - in the GUI the user will change these values
	//      if they want to change the IP Address, Gateway Address,
	//      Netmask or MQTT Server IP Address. Input and output.
        // %c - HTTP Port Number or MQTT Server Port Number - in the GUI the
	//      user will change this value if they want to change the Port
	//      number. Input and output.
        // %d - MAC values - in the GUI the user will change these values if
	//      they want to change the MAC address. Input and output.
        // %e - Statistics display information. Output only.
        // %f - Relays states displayed in simplified form. Output only.
        // %g - "Config" string to control the Output Invert, Input Invert,
	//      and Retain functions.
        // %l - MQTT Username - This is a user entered text field with a
	//      Username. Used in MQTT communication. Input and output.
        // %m - MQTT Password - This is a user entered text field with a
	//      Password. Used in MQTT communication. Input and output.
        // %n - MQTT Status - Displays red or green boxes to indicate startup
	//      status for MQTT (Connection Available, ARP OK, TCP OK, Connect
	//      OK, MQTT_OK). Output only.
        // %y - Indicates the need to insert one of several commonly occuring
	//      HTML strings. This is to aid in compressing the web page
	//      templates stored in flash memory.
        // %z - A bogus variable inserted at the end of the form data to make
	//      sure that all real data is followed by an & character. This
	//      helps to find the end of variable length values in the POST
	//      form. The z value itself is never used.
      
        if (nByte == '%') {
          *ppData = *ppData + 1;
          *pDataLeft = *pDataLeft - 1;
          
          // Collect the "nParsedMode" value (the i, o, a, b, c, etc part of
	  // the field). This, along with the "nParsedNum" digits that follow,
	  // will determine what data is put in the output stream.
          memcpy(&nParsedMode, *ppData, 1);
          *ppData = *ppData + 1;
          *pDataLeft = *pDataLeft - 1;
          
          // Collect the first digit of the "nParsedNum" which follows the
	  // "nParseMode". This is the "tens" digit of the two character
	  // nParsedNum.
          memcpy(&temp, *ppData, 1);
          nParsedNum = (uint8_t)((temp - '0') * 10);
          *ppData = *ppData + 1;
          *pDataLeft = *pDataLeft - 1;
          
          // Collect the second digit of the "nParsedNum". This is the "ones"
	  // digit. Add it to the "tens" digit to complete the number in
	  // integer form.
          memcpy(&temp, *ppData, 1);
          nParsedNum = (uint8_t)(nParsedNum + temp - '0');
          *ppData = *ppData + 1;
          *pDataLeft = *pDataLeft - 1;
	}
      }

      if ((nByte == '%') || (insertion_flag[0] != 0)) {
        // NOW insert information in the transmit stream based on the nParsedMode
	// and nParsedNum just collected. Anything inserted in the transmit stream
	// is in ascii / UTF-8 form.
	// Note that the data is displayed in two forms. When we parse for 'i' we
	// are displaying the pin state as a green or red square. When we parse for
	// 'o' or 'p' we are displaying radio buttons that indicate the ON/OFF
	// state of the pin. So in all cases GpioGetPin is called to determine the
	// current pin state.
	
        if (nParsedMode == 'i') {
	  // This is pin state information.
	  // For output pins display what is returned by GpioGetPin()
	  // For input pins if invert_input != 0 the GPIO pin state needs to be
	  // inverted before displaying.
	  // If the result is 0 output a "0" for a red square
	  // If the result is 1 output a "1" for a green square
#if GPIO_SUPPORT == 1
          // Display Output Pin state
	  *pBuffer = (uint8_t)(GpioGetPin(nParsedNum) + '0');
          pBuffer++;
          nBytes++;
#endif // GPIO_SUPPORT == 1
#if GPIO_SUPPORT == 2
          if (nParsedNum > 7) {
            // Display Input Pin state
	    i = GpioGetPin(nParsedNum);
	    if (invert_input == 0x00) *pBuffer = (uint8_t)(i + '0');
	    else {
	      if (i == 0) *pBuffer = (uint8_t)('1');
	      else *pBuffer = (uint8_t)('0');
	    }
            pBuffer++;
            nBytes++;
	  }
	  else {
	    // Display Output Pin State
	    *pBuffer = (uint8_t)(GpioGetPin(nParsedNum) + '0');
            pBuffer++;
            nBytes++;
	  }
#endif // GPIO_SUPPORT == 2
#if GPIO_SUPPORT == 3
          // Display Input Pin State
	  i = GpioGetPin(nParsedNum);
	  if (invert_input == 0x00) {
	    *pBuffer = (uint8_t)(i + '0');
	  }
	  else {
	    if (i == 0) *pBuffer = (uint8_t)('1');
	    else *pBuffer = (uint8_t)('0');
	  }
          pBuffer++;
          nBytes++;
#endif // GPIO_SUPPORT == 3
	}

        else if ((nParsedMode == 'o' && ((uint8_t)(GpioGetPin(nParsedNum) == 1)))
	      || (nParsedMode == 'p' && ((uint8_t)(GpioGetPin(nParsedNum) == 0)))) { 
	  // 'o' An "ON" radio buttion is displayed and is shown in the checked
	  // state if the pin state is 1.
	  // 'p' An "OFF" radio buttion is displayed and is shown in the checked
	  // state if the pin state is 0.
          for(i=0; i<7; i++) {
            *pBuffer = checked[i];
            pBuffer++;
          }
	  nBytes += 7;
        }

        else if (nParsedMode == 'a') {
	  // This is device name information ( up to 19 characters)
	  for(i=0; i<19; i++) {
	    if (stored_devicename[i] != '\0') {
              *pBuffer = (uint8_t)(stored_devicename[i]);
              pBuffer++;
              nBytes++;
	    }
	    else break;
	  }
	}
	
        else if (nParsedMode == 'b') {
	  // This data is the IP Address, Gateway Address, and Netmask information
	  // (3 characters per octet). We need to get a single 8 bit integer from
	  // storage but put it in the transmission buffer as three alpha characters.
	  
          switch (nParsedNum)
	  {
	    // Convert the value to 3 digit Decimal
	    case 0:  emb_itoa(stored_hostaddr[3], OctetArray, 10, 3); break;
	    case 1:  emb_itoa(stored_hostaddr[2], OctetArray, 10, 3); break;
	    case 2:  emb_itoa(stored_hostaddr[1], OctetArray, 10, 3); break;
	    case 3:  emb_itoa(stored_hostaddr[0], OctetArray, 10, 3); break;
	    case 4:  emb_itoa(stored_draddr[3],   OctetArray, 10, 3); break;
	    case 5:  emb_itoa(stored_draddr[2],   OctetArray, 10, 3); break;
	    case 6:  emb_itoa(stored_draddr[1],   OctetArray, 10, 3); break;
	    case 7:  emb_itoa(stored_draddr[0],   OctetArray, 10, 3); break;
	    case 8:  emb_itoa(stored_netmask[3],  OctetArray, 10, 3); break;
	    case 9:  emb_itoa(stored_netmask[2],  OctetArray, 10, 3); break;
	    case 10: emb_itoa(stored_netmask[1],  OctetArray, 10, 3); break;
	    case 11: emb_itoa(stored_netmask[0],  OctetArray, 10, 3); break;
#if MQTT_SUPPORT == 1
	    case 12: emb_itoa(stored_mqttserveraddr[3], OctetArray, 10, 3); break;
	    case 13: emb_itoa(stored_mqttserveraddr[2], OctetArray, 10, 3); break;
	    case 14: emb_itoa(stored_mqttserveraddr[1], OctetArray, 10, 3); break;
	    case 15: emb_itoa(stored_mqttserveraddr[0], OctetArray, 10, 3); break;
#endif // MQTT_SUPPORT == 1
	    default: break;
	  }
	  
	  // Copy OctetArray characters to output. Advance pointers.
	  for(i=0; i<3; i++) {
	    *pBuffer = (uint8_t)OctetArray[i];
            pBuffer++;
	  }
	  nBytes += 3;
	}
	
        else if (nParsedMode == 'c') {
	  // If nParsedNum == 0 this is the Port number (5 characters) for the
	  // Network Module.
	  // If nParsedNum == 1 this is the Port number (5 characters) for the
	  // MQTT Server.
	  // In both cases we need to get a single 16 bit integer from storage
	  // but put it in the transmission buffer as five alpha characters.

	  // Write the 5 digit Port value
	  if (nParsedNum == 0) emb_itoa(stored_port, OctetArray, 10, 5);
#if MQTT_SUPPORT == 1
	  else emb_itoa(stored_mqttport, OctetArray, 10, 5);
#endif // MQTT_SUPPORT == 1
	    
	  // Copy OctetArray characters to output. Advance pointers.
	  for(i=0; i<5; i++) {
            *pBuffer = (uint8_t)OctetArray[i];
            pBuffer++;
	  }
	  nBytes += 5;
        }
	
        else if (nParsedMode == 'd') {
	  // This is the MAC adddress information (2 characters per octet). We copy
	  // from the mac_string (rather than from the uip_ethaddr bytes) as the
	  // mac_string is already in alphanumeric format.

	  if (nParsedNum == 0) { OctetArray[0] = mac_string[0]; OctetArray[1] = mac_string[1]; }
	  if (nParsedNum == 1) { OctetArray[0] = mac_string[2]; OctetArray[1] = mac_string[3]; }
	  if (nParsedNum == 2) { OctetArray[0] = mac_string[4]; OctetArray[1] = mac_string[5]; }
	  if (nParsedNum == 3) { OctetArray[0] = mac_string[6]; OctetArray[1] = mac_string[7]; }
	  if (nParsedNum == 4) { OctetArray[0] = mac_string[8]; OctetArray[1] = mac_string[9]; }
	  if (nParsedNum == 5) { OctetArray[0] = mac_string[10]; OctetArray[1] = mac_string[11]; }

          *pBuffer = OctetArray[0];
          pBuffer++;
          nBytes++;
	    
          *pBuffer = OctetArray[1];
          pBuffer++;
          nBytes++;
	}

#if UIP_STATISTICS == 1
        else if (nParsedMode == 'e') {
	  // This is the statistics information (10 characters per data item). We need to get
	  // a single uint32_t from storage but put it in the output stream as a character
	  // representation of the data.
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

	  for (i=0; i<10; i++) {
            *pBuffer = OctetArray[i];
            pBuffer++;
	  }
	  nBytes += 10;
	}
#endif // UIP_STATISTICS == 1


#if UIP_STATISTICS == 2
        else if (nParsedMode == 'e') {
          switch (nParsedNum)
	  {
	    // Output the second counter and error counters. First convert to 10
	    // digit Decimal.
	    case 26:  emb_itoa(second_counter, OctetArray, 10, 10); break;
	    case 27:  emb_itoa(RXERIF_counter, OctetArray, 10, 10); break;
	    case 28:  emb_itoa(TXERIF_counter, OctetArray, 10, 10); break;
	    case 29:  emb_itoa(TRANSMIT_counter, OctetArray, 10, 10); break;
	  }
	  for (i=0; i<10; i++) {
            *pBuffer = OctetArray[i];
            pBuffer++;
	  }
	  nBytes += 10;
	}
#endif // UIP_STATISTICS == 2

        else if (nParsedMode == 'f') {
	  // Output the pin state information in the format used by the "99" command
	  // of the original Network Module.
	  // For output pins display what is returned by GpioGetPin()
	  // For input pins if invert_input != 0 the GPIO pin state needs to be
	  // inverted before displaying.
#if GPIO_SUPPORT == 1
          // Display Output Pin state
	  for(i=0; i<16; i++) {
	    *pBuffer = (uint8_t)(GpioGetPin(i) + '0');
            pBuffer++;
          }
	  nBytes += 16;
#endif // GPIO_SUPPORT == 1
#if GPIO_SUPPORT == 2
	  for(i=0; i<16; i++) {
            if (i > 7) {
              // Display Input Pin state
              j = GpioGetPin(i);
              if (invert_input == 0x00) *pBuffer = (uint8_t)(j + '0');
              else {
                if (j == 0) *pBuffer = (uint8_t)('1'); 
                else *pBuffer = (uint8_t)('0');
              }
              pBuffer++;
            }
            else {
              // Display Output Pin State
              *pBuffer = (uint8_t)(GpioGetPin(i) + '0');
              pBuffer++;
            }
          }
	  nBytes += 16;
#endif // GPIO_SUPPORT == 2
#if GPIO_SUPPORT == 3
          for(i=0; i<16; i++) {
            // Display Input Pin State
            j = GpioGetPin(i);
            if (invert_input == 0x00) {
              *pBuffer = (uint8_t)(j + '0');
            }
            else {
              if (j == 0) *pBuffer = (uint8_t)('1');
              else *pBuffer = (uint8_t)('0');
            }
            pBuffer++;
          }
	  nBytes += 16;
#endif // GPIO_SUPPORT == 3
	}

else if (nParsedMode == 'g') {
	  // This is the Config string, currently defined as follows:
	  // 6 characters
	  // Character 1: Output Invert, can be 0 or 1
	  // Character 2: Input Invert, can be 0 or 1
	  // Character 3: Retain, can be 0, 1, or 2
	  // Character 4: Full/Half Duplex, can be 0 or 1
	  // Character 5: Undefined, 0 only
	  // Character 6: Undefined, 0 only
	  // The config_settings string is NOT null terminated
	  // There is only 1 'g' ID so we don't need to check the nParsedNum.
	  
	  // Insert config_settings
	  for(i = 0; i < 6; i++) {
            *pBuffer = stored_config_settings[i];
            pBuffer++;
          }
          nBytes += 6;
	}
	
#if MQTT_SUPPORT == 1
        else if (nParsedMode == 'l') {
	  // This is Username information (0 to 10 characters)
	  // Display Username
          for(i=0; i<10; i++) {
	    if (stored_mqtt_username[i] != '\0') {
              *pBuffer = (uint8_t)(stored_mqtt_username[i]);
              pBuffer++;
              nBytes++;
	    }
	    else break;
	  }
	}
	
        else if (nParsedMode == 'm') {
	  // This is Password information (0 to 10 characters)
	  // Display Password
          for(i=0; i<10; i++) {
	    if (stored_mqtt_password[i] != '\0') {
              *pBuffer = (uint8_t)(stored_mqtt_password[i]);
              pBuffer++;
              nBytes++;
	    }
	    else break;
	  }
	}
	
        else if (nParsedMode == 'n') {
	  // Outputs the MQTT Start Status information as four red/green
	  // boxes showing Connections available, ARP status, TCP status,
	  // MQTT Connect status, and MQTT Error status.
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
	  if (no_err == 1) *pBuffer = '1'; // Paint a green square
	  else *pBuffer = '0'; // Paint a red square
          pBuffer++;
          nBytes++;
	}
#endif // MQTT_SUPPORT == 1

        else if (nParsedMode == 'y') {
          // Indicates the need to insert one of several commonly occuring HTML
          // strings. These strings were created to aid in compressing the web
	  // page templates stored in flash memory.
	  //
	  // Processing of a long string insertion is a special case and may
	  // bridge over more than one call to the CopyHttpData() function. This
	  // is to better utilize the transmit buffer. Without the "bridging" the
	  // function would have to always make sure there is enough buffer space
	  // to hold the longest string, whether a string is being sent or not.
	  // This usually wastes buffer space and causes many more packets to be
	  // required to send an HTML page.
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
	  // insertion_flag[0] = insertion byte count
	  // insertion_flag[1] = nParsedMode
	  // insertion_flag[2] = nParsedNum
          
	  // insertion_flag[0] will be 0 if we are just starting insertion of a
	  //   string.
	  // insertion_flag[0] will be non-0 if a string insertion was started and
	  //   is not yet complete. In this case insertion_flag[0] is an index to
	  //   the next character in the source string that is to be inserted into
	  //   the transmit buffer.

	  i = insertion_flag[0];
	  insertion_flag[1] = nParsedMode;
	  insertion_flag[2] = nParsedNum;
	  
          switch (nParsedNum)
	  {
	    case 0:
	      // %y00 replaced with string 
	      // page_string00[] = "pattern='[0-9]{3}' title='Enter 000 to 255' maxlength='3'";
              *pBuffer = (uint8_t)page_string00[i];
	      insertion_flag[0]++;
	      if (insertion_flag[0] == page_string00_len) insertion_flag[0] = 0;
	      break;
	    case 1:
	      // %y01 replaced with string 
              // page_string01[] = "pattern='[0-9a-f]{2}' title='Enter 00 to ff' maxlength='2'";
              *pBuffer = (uint8_t)page_string01[i];
	      insertion_flag[0]++;
	      if (insertion_flag[0] == page_string01_len) insertion_flag[0] = 0;
	      break;
	    case 2:
	      // %y02 replaced with string 
              // page_string02[] = "<button title='Save first! This button will not save your changes'>";
              *pBuffer = (uint8_t)page_string02[i];
	      insertion_flag[0]++;
	      if (insertion_flag[0] == page_string02_len) insertion_flag[0] = 0;
	      break;
	    case 3:
	      // %y03 replaced with string 
              // page_string03[] = "<form style='display: inline' action='http://";
              *pBuffer = (uint8_t)page_string03[i];
	      insertion_flag[0]++;
	      if (insertion_flag[0] == page_string03_len) insertion_flag[0] = 0;
	      break;
	    case 4:
	      // %y04 replaced with first header string 
              *pBuffer = (uint8_t)page_string04[i];
	      insertion_flag[0]++;
	      if (insertion_flag[0] == page_string04_len) insertion_flag[0] = 0;
	      break;
	    case 5:
	      // %y05 replaced with second header string 
              *pBuffer = (uint8_t)page_string05[i];
	      insertion_flag[0]++;
	      if (insertion_flag[0] == page_string05_len) insertion_flag[0] = 0;
	      break;
	    case 6:
	      // %y06 replaced with third header string 
              *pBuffer = (uint8_t)page_string06[i];
	      insertion_flag[0]++;
	      if (insertion_flag[0] == page_string06_len) insertion_flag[0] = 0;
	      break;
	    default: break;
	  }
          pBuffer++;
          nBytes++;
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
        nBytes++;
      }
    }
    else break;
  }
  return nBytes;
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
  saved_parsestate = PARSE_CMD;
  saved_nparseleft = 0;
  clear_saved_postpartial_all();
}


void HttpDCall(uint8_t* pBuffer, uint16_t nBytes, struct tHttpD* pSocket)
{
  uint16_t nBufSize;
  uint8_t i;
  
  i = 0;
  
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

#if HELP_SUPPORT == 1
    else if (current_webpage == WEBPAGE_HELP) {
      pSocket->pData = g_HtmlPageHelp;
      pSocket->nDataLeft = (uint16_t)(sizeof(g_HtmlPageHelp) - 1);
    }
    else if (current_webpage == WEBPAGE_HELP2) {
      pSocket->pData = g_HtmlPageHelp2;
      pSocket->nDataLeft = (uint16_t)(sizeof(g_HtmlPageHelp2) - 1);
    }
#endif /* HELP_SUPPORT == 1 */

#if UIP_STATISTICS == 1 || UIP_STATISTICS == 2
    else if (current_webpage == WEBPAGE_STATS) {
      pSocket->pData = g_HtmlPageStats;
      pSocket->nDataLeft = (uint16_t)(sizeof(g_HtmlPageStats) - 1);
    }
#endif // UIP_STATISTICS == 1 || UIP_STATISTICS == 2

    else if (current_webpage == WEBPAGE_RSTATE) {
      pSocket->pData = g_HtmlPageRstate;
      pSocket->nDataLeft = (uint16_t)(sizeof(g_HtmlPageRstate) - 1);
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
      // only need to run the "senddata" part of this routine.
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
      // Fragment after the first packet in a POST. While processing a prior
      // packet the parse was interrupted by the end of the packet. This code
      // will restore where we were in the parsing loop. This process relies
      // on no "out of order" packets.
      pSocket->nState = saved_nstate;
        // saved_nstate can be one of these: STATE_GOTPOST, STATE_PARSEPOST,
	// STATE_NULL. A TCP Fragment break can occur in any of these states.
	// A TCP Fragment cannot occur in pSocket->nState states
	// STATE_CONNECTED, STATE_GET_G, STATE_GET_GE, STATE_GET_GET,
	// STATE_POST_P, STATE_POST_PO, STATE_POST_POS, STATE_POST_POST,
	// STATE_GOTGET, STATE_SENDHEADER, STATE_SENDDATA, STATE_PARSEGET.
      pSocket->ParseState = saved_parsestate;
        // saved_parsestate can be one of these: PARSE_CMD, PARSE_NUM10,
	// PARSE_NUM1, PARSE_EQUAL, PARSE_VAL, PARSE_DELIM, PARSE_SLASH1,
	// PARSE_FAIL
      pSocket->nParseLeft = saved_nparseleft;
        // The number of bytes left to parse in the POST
      pSocket->nNewlines = saved_newlines;
      // Next we'll capture the previous fragment's ParseCmd state data for
      // use in fragment reassembly. We need to do this because the
      // saved_postpartial[0] value will be reused below to capture any new
      // fragmentation state data.
      // In the following values:
      // [0] = ParseCmd
      // [1] = ParseNum ten's
      // [2] = ParseNum one's
      // [3] = Equal sign
      // [4] = 1st byte of value
      // [5] and up = More bytes of value
      for (i=0; i<24; i++) saved_postpartial_previous[i] = saved_postpartial[i];
      
      // If we had previously saved any partial input data we need to restore
      // it so the routines below can finish filling it in. What we saved will
      // vary depending on which command we were parsing.
      if (saved_nstate == STATE_PARSEPOST) {
        if (saved_parsestate == PARSE_CMD) {
          // No further restore needed
        }
        else if (saved_parsestate == PARSE_NUM10) {
	  // Restore the ParseCmd
	  pSocket->ParseCmd = saved_postpartial_previous[0];
        }
        else if (saved_parsestate == PARSE_NUM1) {
	  // Restore the ParseCmd and tens digit of the ParseNum
	  pSocket->ParseCmd = saved_postpartial_previous[0];
          pSocket->ParseNum = (uint8_t)((saved_postpartial_previous[1] - '0') * 10);
        }
        else if (saved_parsestate == PARSE_EQUAL || saved_parsestate == PARSE_VAL) {
	  // Restore the ParseCmd and the entire ParseNum
	  pSocket->ParseCmd = saved_postpartial_previous[0];
          pSocket->ParseNum = (uint8_t)((saved_postpartial_previous[1] - '0') * 10);
          pSocket->ParseNum += (uint8_t)(saved_postpartial_previous[2] - '0');
        }
	else if (saved_parsestate == PARSE_DELIM) {
	  // No further restore needed
	}
      }
      // Note for TCP Fragmentation: No restore like that shown above is
      // required for saved_nstate == STATE_PARSEGET because the data searched
      // in the PARSE_GET parsing cannot be fragmented (it is all contained
      // within the first 100 bytes of the first packet).
    }
      
    // In the code below we are parsing for the "POST" or "GET " phrase. We do
    // not need to worry about TCP fragmentation because the phrase will appear
    // very early in the first packet (easily within the first 100 bytes).
    // However, once we receive "POST" we go into a loop looking for the
    // "\r\n\r\n" sequence, and we need to be able to handle TCP fragmentation
    // during that search.
    //
    // If we are parsing a fragment then pSocket->nState may have been restored
    // to a state further down in the process.

    if (pSocket->nState == STATE_CONNECTED) {
      if (nBytes == 0) return;
      if (*pBuffer == 'G') {
        pSocket->nState = STATE_GET_G;
      }
      else if (*pBuffer == 'P') {
        pSocket->nState = STATE_POST_P;
      }
      nBytes--;
      pBuffer++;
    }

    if (pSocket->nState == STATE_GET_G) {
      if (nBytes == 0) return;
      if (*pBuffer == 'E') pSocket->nState = STATE_GET_GE;
      nBytes--;
      pBuffer++;
    }

    if (pSocket->nState == STATE_GET_GE) {
      if (nBytes == 0) return;
      if (*pBuffer == 'T') pSocket->nState = STATE_GET_GET;
      nBytes--;
      pBuffer++;
    }

    if (pSocket->nState == STATE_GET_GET) {
      if (nBytes == 0) return;
      if (*pBuffer == ' ') pSocket->nState = STATE_GOTGET;
      nBytes--;
      pBuffer++;
    }

    if (pSocket->nState == STATE_POST_P) {
      if (nBytes == 0) return;
      if (*pBuffer == 'O') pSocket->nState = STATE_POST_PO;
      nBytes--;
      pBuffer++;
    }

    if (pSocket->nState == STATE_POST_PO) {
      if (nBytes == 0) return;
      if (*pBuffer == 'S') pSocket->nState = STATE_POST_POS;
      nBytes--;
      pBuffer++;
    }

    if (pSocket->nState == STATE_POST_POS) {
      if (nBytes == 0) return;
      if (*pBuffer == 'T') pSocket->nState = STATE_POST_POST;
      nBytes--;
      pBuffer++;
    }

    if (pSocket->nState == STATE_POST_POST) {
      if (nBytes == 0) return;
      if (*pBuffer == ' ') pSocket->nState = STATE_GOTPOST;
      nBytes--;
      pBuffer++;
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
	// XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX

        if (pSocket->nNewlines == 2) {
          // Beginning found.
          // Initialize Parsing variables
          if (current_webpage == WEBPAGE_IOCONTROL) {
	    pSocket->nParseLeft = PARSEBYTES_IOCONTROL;
	    pSocket->nParseLeftAddl = PARSEBYTES_IOCONTROL_ADDL;
	  }
          if (current_webpage == WEBPAGE_CONFIGURATION) {
	    pSocket->nParseLeft = PARSEBYTES_CONFIGURATION;
	    pSocket->nParseLeftAddl = PARSEBYTES_CONFIGURATION_ADDL;
	  }
          pSocket->ParseState = saved_parsestate = PARSE_CMD;
	  saved_nparseleft = pSocket->nParseLeft;
          // Start parsing
          pSocket->nState = STATE_PARSEPOST;
	  saved_nstate = STATE_PARSEPOST;
	  if (nBytes == 0) {
	    // If we are at end of fragment here we exit and will return in
	    // STATE_PARSEPOST / PARSE_CMD
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
      // This section will parse a POST sent by the user (usually when they
      // click on the "submit" button on a webpage). POST data will consist
      // of:
      //  One digit with a ParseCmd
      //  Two digits with a ParseNum indicating the item to be changed
      //  One digit with an equal sign
      //  A variable number of characters with a ParseState indicating the
      //    new value of the item
      //  One digit with a Parse Delimiter (an '&')
      //
      while (1) {
        // When appropriate conditions are met a break will occur to leave
	// the while loop.
        if (pSocket->ParseState == PARSE_CMD) {
          pSocket->ParseCmd = *pBuffer;
	  saved_postpartial[0] = *pBuffer;
          pSocket->ParseState = saved_parsestate = PARSE_NUM10;
	  if (pSocket->nParseLeft > 0) { // Prevent underflow
	    pSocket->nParseLeft--;
          }
	  else {
	    // Something out of sync - escape
	    pSocket->ParseState = PARSE_DELIM;
	  }
	  saved_nparseleft = pSocket->nParseLeft;
          pBuffer++;
	  nBytes --;
	  // Check ParseCmd for errors
	  if (pSocket->ParseCmd == 'o' ||
	      pSocket->ParseCmd == 'a' ||
	      pSocket->ParseCmd == 'b' ||
	      pSocket->ParseCmd == 'c' ||
	      pSocket->ParseCmd == 'd' ||
	      pSocket->ParseCmd == 'g' ||
	      pSocket->ParseCmd == 'l' ||
	      pSocket->ParseCmd == 'm' ||
	      pSocket->ParseCmd == 'z') { }
	  else {
	    // Something out of sync - escape
	    pSocket->ParseState = PARSE_DELIM;
	  }
	  if (nBytes == 0) { // Hit end of fragment. Break out of while()
	                     // loop.
	    break;
	  }
        }
	
        else if (pSocket->ParseState == PARSE_NUM10) {
          pSocket->ParseNum = (uint8_t)((*pBuffer - '0') * 10);
	  saved_postpartial[1] = *pBuffer;
          pSocket->ParseState = saved_parsestate = PARSE_NUM1;
	  if (pSocket->nParseLeft > 0) { // Prevent underflow
	    pSocket->nParseLeft--;
	  }
	  else {
	    // Something out of sync - escape
	    pSocket->ParseState = PARSE_DELIM;
	  }
	  saved_nparseleft = pSocket->nParseLeft;
          pBuffer++;
	  nBytes--;
	  if (nBytes == 0) {
	    // Hit end of TCP Fragment. Break out of while() loop.
	    break;
	  }
        }
	
        else if (pSocket->ParseState == PARSE_NUM1) {
          pSocket->ParseNum += (uint8_t)(*pBuffer - '0');
	  saved_postpartial[2] = *pBuffer;
          pSocket->ParseState = saved_parsestate = PARSE_EQUAL;
	  if (pSocket->nParseLeft > 0) { // Prevent underflow
	    pSocket->nParseLeft--;
	  }
	  else {
	    // Something out of sync - escape
	    pSocket->ParseState = PARSE_DELIM;
	  }
	  saved_nparseleft = pSocket->nParseLeft;
          pBuffer++;
	  nBytes--;
	  if (nBytes == 0) {
	    // Hit end of TCP Fragment. Break out of while() loop.
	    break;
	  }
        }
	
        else if (pSocket->ParseState == PARSE_EQUAL) {
          pSocket->ParseState = saved_parsestate = PARSE_VAL;
	  saved_postpartial[3] = *pBuffer;
	  if (pSocket->nParseLeft > 0) { // Prevent underflow
	    pSocket->nParseLeft--;
	  }
	  else {
	    // Something out of sync - escape
	    pSocket->ParseState = PARSE_DELIM;
	  }
	  saved_nparseleft = pSocket->nParseLeft;
          pBuffer++;
	  nBytes--;
	  if (nBytes == 0) {
	    // Hit end of TCP Fragment. Break out of while() loop.
	    break;
	  }
        }

        else if (pSocket->ParseState == PARSE_VAL) {
	  // 'o' is submit data for the Relay Controls
	  // 'a' is submit data for the Device Name
	  // 'b' is submit data for the IP/Gateway/Netmask
	  // 'c' is submit data for the Port number
	  // 'd' is submit data for the MAC
	  // 'g' is submit data for the Config settings string
	  // 'l' is submit data for the MQTT Username
	  // 'm' is submit data for the MQTT Password
	  // 'z' is submit data for a hidden input used for a diagnostic
	  //     indicator that all POST processing completed
	  
	  // Parse 'o' ------------------------------------------------------//
          if (pSocket->ParseCmd == 'o') {
            // This code sets the new Pin state on a pin when user commanded
	    // via a radio button in the GUI. It also updates the Set pin
	    // field for display.
	    
	    // Note on fragment reassembly: If we only collected the "o" in
	    // the last fragment but not the pin value then we will end up
	    // here and will collect the pin value. If we already collected
	    // the pin value in the last fragment it will have already been
	    // processed and we won't come here - we will instead be in the
	    // PARSE_DELIM state.
	    
	    {
              uint8_t pin_value;
              if ((uint8_t)(*pBuffer) == '1') pin_value = 1;
	      else pin_value = 0;
	      GpioSetPin(pSocket->ParseNum, (uint8_t)pin_value);
	    }
	    if (pSocket->nParseLeft > 0) pSocket->nParseLeft--; // Prevent
	                                                        // underflow
            saved_nparseleft = pSocket->nParseLeft;
            pBuffer++;
	    nBytes--;
	    if (nBytes == 0) {
	      // Hit end of TCP Fragment. Break out of while() loop. The
	      // first character in the next packet will be an & delimiter.
	      pSocket->ParseState = saved_parsestate = PARSE_DELIM;
	      break;
	    }
	    // Else we didn't hit the end of a TCP Fragment so we fall through
	    // to the PARSE_DELIM state
          }

	  // Parse 'a' 'l' 'm' ----------------------------------------------//
          else if (pSocket->ParseCmd == 'a'
                || pSocket->ParseCmd == 'l'
                || pSocket->ParseCmd == 'm' ) {
            // a = Update the Device Name field
            // l = Update the MQTT Username field
            // m = Update the MQTT Password field
	    break_while = 0; // Clear the break switch in case a TCP Fragment
	                     // occurs.
            tmp_pBuffer = pBuffer;
            tmp_nBytes = nBytes;
	    tmp_nParseLeft = pSocket->nParseLeft;
            switch (pSocket->ParseCmd) {
              case 'a': i = 19; break;
              case 'l':
              case 'm': i = 10; break;
            }
            parse_POST_string(pSocket->ParseCmd, i);
            pBuffer = tmp_pBuffer;
            nBytes = tmp_nBytes;
	    pSocket->nParseLeft = tmp_nParseLeft;
            if (break_while == 1) {
	      // Hit end of TCP Fragment. Break out of while() loop.
	      // The parse_POST_string() routine will have loaded the
	      // saved_parsestate value with the next pSocket->ParseState.
	      pSocket->ParseState = saved_parsestate;
	      break;
	    }
	    // Else we didn't hit the end of a TCP Fragment so we fall through
	    // to the PARSE_DELIM state
          }
	  
	  // Parse 'b' ------------------------------------------------------//
          else if (pSocket->ParseCmd == 'b') {
            // This code updates the "pending" IP address, Gateway address,
	    // Netmask, and MQTT Host IP address which will then cause the
	    // main.c functions to restart the software.
            // The value following the 'bxx=' ParseCmd and ParseNum consists
            // of three alpha digits. The function call collects the alpha
	    // digits, validates them, and converts them to the numeric value
	    // used by the other firmware functions.
	    break_while = 0; // Clear the break switch in case a TCP Fragment
	                     // occurs.
            tmp_pBuffer = pBuffer;
            tmp_nBytes = nBytes;
	    tmp_nParseLeft = pSocket->nParseLeft;
            parse_POST_address(pSocket->ParseCmd, pSocket->ParseNum);
            pBuffer = tmp_pBuffer;
            nBytes = tmp_nBytes;
	    pSocket->nParseLeft = tmp_nParseLeft;
            if (break_while == 1) {
	      // Hit end of TCP Fragment but still have characters to collect.
	      // Break out of while() loop.
// The next line shouldn't be needed because the values shouldn't have changed
              pSocket->ParseState = saved_parsestate = PARSE_VAL;
	      break;
	    }
            if (break_while == 2) {
	      // Hit end of TCP Fragment just before &. Break out of while()
	      // loop.
              pSocket->ParseState = saved_parsestate = PARSE_DELIM;
	      break;
	    }
	    // Else we didn't hit the end of a TCP Fragment so we fall through
	    // to the PARSE_DELIM state
          }
	  
	  // Parse 'c' ------------------------------------------------------//
          else if (pSocket->ParseCmd == 'c') {
            // This code updates the "pending" HTTP Port number or MQTT Port
	    // number which will then cause the main.c functions to restart
	    // the software.
            // ParseNum == 0 indicates the HTTP Port number.
	    // ParseNum == 1 indicates the MQTT Port number.
	    // The value following the 'cxx=' ParseCmd & ParseNum consists
            // of five alpha digits. The function call collects the digits,
	    // validates them, and passes the value to the SetPort function.
	    break_while = 0; // Clear the break switch in case a TCP Fragment
	                     // occurs.
            tmp_pBuffer = pBuffer;
            tmp_nBytes = nBytes;
	    tmp_nParseLeft = pSocket->nParseLeft;
            parse_POST_port(pSocket->ParseCmd, pSocket->ParseNum);
            pBuffer = tmp_pBuffer;
            nBytes = tmp_nBytes;
	    pSocket->nParseLeft = tmp_nParseLeft;
            if (break_while == 1) {
	      // Hit end of TCP Fragment but still have characters to collect.
	      // Break out of while() loop.
              pSocket->ParseState = saved_parsestate = PARSE_VAL;
	      break;
	    }
            if (break_while == 2) {
	      // Hit end of TCP Fragment just before &. Break out of while()
	      // loop.
              pSocket->ParseState = saved_parsestate = PARSE_DELIM;
	      break;
	    }
	    // Else we didn't hit the end of a TCP Fragment so we fall through
	    // to the PARSE_DELIM state
          }
	  
	  // Parse 'd' ------------------------------------------------------//
          else if (pSocket->ParseCmd == 'd') {
            // This code updates the MAC address which will then cause the
	    // main.c functions to restart the software.
	    // The value following the 'dxx=' ParseCmd and ParseNum consists
	    // of two alpha digits in hex form ('0' to '9' and 'a' to 'f').
	    // This code passes the digits to the SetMAC function.
	    alpha[0] = '-';
	    alpha[1] = '-';
	    
	    if (saved_postpartial_previous[0] == 'd') {
	      // Clear the saved_postpartial_prevous[0] byte (the ParseCmd
	      // byte) as it should only get used once on processing a given
	      // TCP Fragment.
	      saved_postpartial_previous[0] = '\0';
	      // We are re-assembling a fragment that occurred during this
	      // command. The ParseCmd and ParseNum values are already
	      // restored. We need to determine where in this command the
	      // fragmentation break occurred and continue from there.
	      // Check alphas
	      if (saved_postpartial_previous[4] != '\0') alpha[0] = saved_postpartial_previous[4];
	      if (saved_postpartial_previous[5] != '\0') alpha[1] = saved_postpartial_previous[5];
	    }
	    
	    else {
	      // We are not doing a reassembly. Clear the data part of the
	      // saved_postpartial values in case a fragment break occurs
	      // during this parse
              clear_saved_postpartial_data(); // Clear [4] and higher
	    }
	    
            if (alpha[0] == '-') {
	      alpha[0] = (uint8_t)(*pBuffer);
              saved_postpartial[4] = *pBuffer;
              pSocket->nParseLeft--;
              saved_nparseleft = pSocket->nParseLeft;
              pBuffer++;
	      nBytes--;
              if (nBytes == 0) break; // Hit end of fragment. Break out of
	                              // while() loop.
	    }
	      
            if (alpha[1] == '-') {
	      alpha[1] = (uint8_t)(*pBuffer);
              saved_postpartial[5] = *pBuffer;
              pSocket->nParseLeft--;
              saved_nparseleft = pSocket->nParseLeft;
              pBuffer++;
	      nBytes--;
	    }

	    // If we get this far we no longer need the saved_postpartial
	    // values and must clear them to prevent interference with
	    // subsequent restores.
            clear_saved_postpartial_all();

            SetMAC(pSocket->ParseNum, alpha[0], alpha[1]);

            if (nBytes == 0) {
	      // Hit end of TCP Fragment. Break out of while() loop. The
	      // first character in the next packet will be an & delimiter.
	      pSocket->ParseState = saved_parsestate = PARSE_DELIM;
	      break;
	    }
	    // Else we didn't hit the end of a TCP Fragment so we fall through
	    // to the PARSE_DELIM state
	  }
	  
	  // Parse 'g' ------------------------------------------------------//
	  else if (pSocket->ParseCmd == 'g') {
            // This code sets the Config Settings string which defined the
	    // Invert Output, Invert Input, and Retain functionality.
	    //
	    // There are always 6 characters in the string. Each is collected
	    // and saved for later processing.
	    //
	    // For now the last three characters of the string are always 0,
	    // so to reduce code size the below code does not examine them and
	    // forces them to zero (just in case). But they still must be read
	    // from the POST data sent by the browser.
            for (i=0; i<6; i++) alpha[i] = '-';
	    
	    break_while = 0; // Clear the break switch in case a TCP Fragment
	                     // occurs.
	    
	    if (saved_postpartial_previous[0] == 'g') {
	      // Clear the saved_postpartial_prevous[0] byte (the ParseCmd
	      // byte) as it should only get used once on processing a given
	      // TCP Fragment.
	      saved_postpartial_previous[0] = '\0';
	      // We are re-assembling a fragment that occurred during this
	      // command. The ParseCmd and ParseNum values are already
	      // restored. We need to determine where in this command the
	      // fragmentation break occurred and continue from there.
	      // Check alphas
              for (i=0; i<6; i++) {
                if (saved_postpartial_previous[i+4] != '\0') alpha[i] = saved_postpartial_previous[i+4];
	      }
	    }
	    
	    else {
	      // We are not doing a reassembly. Clear the data part of the
	      // saved_postpartial values in case a fragment break occurs
	      // during this parse
              clear_saved_postpartial_data(); // Clear [4] and higher
            }
	    
            for (i=0; i<6; i++) {
	      // Examine each 'alpha' character to see if it was already found
	      // in a prior TCP Fragment. If not collect it now.
	      // If collecting characters from the POST break the while() loop
	      // if a TCP Fragment boundary is found unless the character
	      // collected is the last 'alpha'.
              if (alpha[i] == '-') {
	        alpha[i] = (uint8_t)(*pBuffer);
                saved_postpartial[i+4] = *pBuffer;
                pSocket->nParseLeft--;
                saved_nparseleft = pSocket->nParseLeft;
                pBuffer++;
	        nBytes--;
                if (i != 5 && nBytes == 0) {
		  break_while = 1; // Hit end of fragment. Break out of
		                   // while() loop.
		  break; // Break out of for() loop
		}
	      }
	    }
	    if (break_while == 1) {
	      // Hit end of TCP Fragment. Break out of while() loop.
	      break;
	    }
	    
	    // If we get this far we no longer need the saved_postpartial
	    // values and must clear them to prevent interference with
	    // subsequent restores.
            clear_saved_postpartial_all();
	    
	    // Validate entries
	    if (alpha[0] != '0' && alpha[0] != '1') alpha[0] = '0';
	    if (alpha[1] != '0' && alpha[1] != '1') alpha[1] = '0';
	    if (alpha[2] != '0' && alpha[2] != '1' && alpha[2] != '2') alpha[2] = '2';
	    if (alpha[3] != '0' && alpha[3] != '1') alpha[3] = '0';
	    
	    Pending_config_settings[0] = (uint8_t)alpha[0];
            Pending_config_settings[1] = (uint8_t)alpha[1];
            Pending_config_settings[2] = (uint8_t)alpha[2];
            Pending_config_settings[3] = (uint8_t)alpha[3];
            Pending_config_settings[4] = '0';
            Pending_config_settings[5] = '0';
	    
            if (nBytes == 0) {
	      // Hit end of fragment. Break out of while() loop. The next
	      // character will be '&' so we need to set PARSE_DELIM.
	      pSocket->ParseState = saved_parsestate = PARSE_DELIM;
	      break;
	    }
	    // Else we didn't hit the end of a TCP Fragment so we fall through
	    // to the PARSE_DELIM state
          }

	  // Parse 'z' ------------------------------------------------------//
	  else if (pSocket->ParseCmd == 'z') {
            // This code signals that a "hidden" post was received. This is a
	    // diagnostic POST reply only, indicating that all data was
	    // posted.
	    //
	    // Note on TCP Fragment reassembly: Once this value is collected
	    // we no longer need to track anything for fragment reassembly as
	    // we've already collected all useful information. nBytes may
	    // still be > 0, but it won't be checked. nParseLeft will be zero,
	    // causing us to enter STATE_SENDHEADER.
	    //
	    // If for some reason there is another fragment coming it will be
	    // processed without any action being taken (maybe another
	    // STATE_SENDHEADER will occur, but that will only repaint the
	    // browser with what it already has).
	    // There is no '&' delimiter after this POST value.
	    //
            // The next two lines aren't needed because we are going to zero
	    // out the values.
	    // if (pSocket->nParseLeft > 0) pSocket->nParseLeft--;
            // pBuffer++;
	    // nBytes--;
	    // Even if there was some error prior to this point we know we
	    // just read the last allowable byte in a parsing. So:
	    // Zero out the byte counters
	    nBytes = 0;
	    pSocket->nParseLeft = 0;
            break; // Break out of the while loop. We're done with POST.
          }
	  
	  // If we got to this point one of the "if/else if" above should have
	  // executed leaving the pointers pointing at the "&" delimiter in
	  // the POST data as the next character to be processed. So we set
	  // the ParseState to PARSE_DELM and let the while() do its next pass.
	  //
	  // Note on TCP Fragment reassembly: We could check for
	  // saved_parsestate == PARSE_DELIM, but that is its only remaining
	  // possible value if we got here.
          pSocket->ParseState = saved_parsestate = PARSE_DELIM;
	  
          if (pSocket->nParseLeft < 30) {
	    // This snippet of code was necessary to enable a POST greater than
	    // 255 bytes yet keep all math to 8 bits. As the nParseLeft value
	    // counts down during POST processing it is checked when it goes
	    // below a count of 30, and at that point the nParseLeftAddl value
	    // is added ONCE to enable a longer down count. Using this scheme
	    // the total POST can be up to 512 - 30 =  482 bytes. Makes the code
	    // harder to follow, but eliminates the need for 16 bit values (and
	    // math) which requires much more code space in flash. FYI, the
	    // check point at "30" was arbitrary. With some thought about how
	    // the content of the POST values it could probably be smaller.
	    //
	    // We've got got to make sure we don't add the 'additional' amount
	    // on while we're procerssing a TCP Fragment. The way to be sure is
	    // to only add to nParseLeft while processing a PARSE_DELIM.
	    if (pSocket->nParseLeftAddl > 0) {
	      pSocket->nParseLeft += pSocket->nParseLeftAddl;
	      pSocket->nParseLeftAddl = 0;
	      saved_nparseleft = pSocket->nParseLeft;
	    }
	  }
        }
	
        else if (pSocket->ParseState == PARSE_DELIM) {
          if (pSocket->nParseLeft > 0) {
	    // Parse the next character, which must be a '&' delimiter. From
	    // here we go parse the next command byte.
            pSocket->ParseState = saved_parsestate = PARSE_CMD;
            pSocket->nParseLeft--;
            saved_nparseleft = pSocket->nParseLeft;
            pBuffer++;
	    nBytes--;
	    // Since we just parsed a '&' clear the saved_postpartial bytes
	    clear_saved_postpartial_all();
	    // If the '&' delimiter was the last POST byte in this packet we
	    // will exit the while loop and fall through to an exit without
	    // going to STATE_SENDHEADER
            if (nBytes == 0) {
	      break; // Hit end of fragment but still have more to parse in
	             // the next TCP Fragment. The next TCP Fragment will
		     // start with a command byte.
	    }
          }
	  else {
	    // If we came to PARSE_DELIM and there was nothing left to parse
	    // in this or any subsequent packet (the normal exit state for
	    // POST data) then we just make sure nParseLeft is zero (not
	    // negative), nBytes is zero, and go on to exit.
            pSocket->nParseLeft = 0; // End the parsing
	    nBytes = 0;
	    break; // Exit parsing
	  }
        }
      }  // end of "while(nBytes != 0)" loop
      
      // If nParseLeft == 0 we should enter STATE_SENDHEADER, but we clean up
      // the fragment tracking pointers first.
      //
      // If nParseLeft is > 0 we haven't received the whole POST yet. In that
      // case we should not enter STATE_SENDHEADER until we finish receiving
      // and parsing the whole POST.
      //
      // We also do not want the main.c loop to do any processing of the
      // Pending values collected so far until we've completed collecting ALL
      // POST data. We can tell we still have processing to do because:
      //   saved_nstate != STATE_NULL
      //   saved_nparseleft != 0.
      // I will use a global "parse_complete" variable to pass the state to
      // the main.c functions.
      //
      // What if we still have a fragment outstanding, some dangling part of 
      // the TCP datagram that follows the POST data? That shouldn't happen
      // as the POST data is the last thing in the datagram. But even if it
      // did it should get dropped by the UIP processes and won't cause any
      // action to be taken.
      //

      if (pSocket->nParseLeft == 0) {
        // Finished parsing ... even if nBytes is not zero
        // Clear the saved states
	saved_nstate = STATE_NULL;
	saved_parsestate = PARSE_CMD;
        saved_nparseleft = 0;
        saved_newlines = 0;
	for (i=0; i<24; i++) saved_postpartial_previous[i] = saved_postpartial[i] = '\0';
	
	// We appear to have completed POST processing. Use z_diag to verify
	// that all values were received. If not, throw away the Pending data
	// by NOT setting parse_complete.
	// Signal the main.c processes that parsing is complete
	parse_complete = 1;
	pSocket->nState = STATE_SENDHEADER;
	
	// Patch: When a 'Submit' is executed after changing pages with one of the
	// "IO Control" or "Congiguration" buttons for some reason we are not
	// pointing at the correct page to refresh the browser. The next steps
	// make sure the pointers are correct. I am not sure why this happens as
	// the 'if (uip_connected()' steps at the start of this function call
	// should have already done this - unless that step is skipped when 'Save'
	// is clicked. Note that if the page change is done, then the 'Refresh'
	// button is clicked, then the 'Save' button is clicked this problem does
	// not appear. AND this problem was only seen with Chrome, but not with
	// FireFox, Edge, or IE.
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
	// STATE_SENDHEADER and STATE_SENDDATA processes.
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

    if (pSocket->nState == STATE_PARSEGET) {
      // This section will parse a GET request sent by the user. Normally in a
      // general purpose web server a GET request would be used to obtain
      // files or other items from the server. In that general case the data
      // that follows "GET " is a "/path/filename" (path optional). In this
      // application we'll use "filename" to command the web server to perform
      // internal operations. For instance, performing a GET for filename "42"
      // (with a "/42") might turn a relay on, or might command transmission
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
//            pSocket->nState = STATE_SENDHEADER;
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
//            pSocket->nState = STATE_SENDHEADER;
            pSocket->nState = STATE_CONNECTED;
            pSocket->nPrevBytes = 0xFFFF;
	  }
	  // Parse first ParseNum digit. Looks like the user did input a
	  // filename digit, so collect it here.
	  else if (*pBuffer >= '0' && *pBuffer <= '9') { // Check for user entry error
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
	  if (*pBuffer >= '0' && *pBuffer <= '9') { // Check for user entry error
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
	  // For 00-31, 55, and 56 you won’t see any screen updates unless you
	  // are already on the IO Control page or the Short Form IO States
	  // page of the webserver.
	  //
	  // Note: Only those Relay ON/OFF commands that are specific to a
	  // build type will work. For GPIO_SUPPORT = 1 the on/off commands
	  // for all 16 relays work. For  GPIO_SUPPORT = 2 the on/off commands
	  // for Relays 1 to 8 work. For GPIO_SUPPORT = 3 no on/off commands
	  // work.
	  //
	  // http://IP/00  Relay-01OFF
	  // http://IP/01  Relay-01ON
	  // http://IP/02  Relay-02OFF
	  // http://IP/03  Relay-02ON
	  // http://IP/04  Relay-03OFF
	  // http://IP/05  Relay-03ON
	  // http://IP/06  Relay-04OFF
	  // http://IP/07  Relay-04ON
	  // http://IP/08  Relay-05OFF
	  // http://IP/09  Relay-05ON
	  // http://IP/10  Relay-06OFF
	  // http://IP/11  Relay-06ON
	  // http://IP/12  Relay-07OFF
	  // http://IP/13  Relay-07ON
	  // http://IP/14  Relay-08OFF
	  // http://IP/15  Relay-08ON
	  // http://IP/16  Relay-09OFF
	  // http://IP/17  Relay-09ON
	  // http://IP/18  Relay-10OFF
	  // http://IP/19  Relay-10ON
	  // http://IP/20  Relay-11OFF
	  // http://IP/21  Relay-11ON
	  // http://IP/22  Relay-12OFF
	  // http://IP/23  Relay-12ON
	  // http://IP/24  Relay-13OFF
	  // http://IP/25  Relay-13ON
	  // http://IP/26  Relay-14OFF
	  // http://IP/27  Relay-14ON
	  // http://IP/28  Relay-15OFF
	  // http://IP/29  Relay-15ON
	  // http://IP/30  Relay-16OFF
	  // http://IP/31  Relay-16ON
	  // http://IP/55  All Relays ON
	  // http://IP/56  All Relays OFF
	  //
	  // http://IP/60  Show IO Control page
	  // http://IP/61  Show Configuration page
	  // http://IP/63  Show Help page
	  // http://IP/64  Show Help2 page
	  // http://IP/65  Flash LED 3 times
	  // http://IP/66  Show Statistics page
	  // http://IP/67  Clear Statistics
	  // http://IP/91  Reboot
	  // http://IP/99  Show Short Form IO States page
	  //
          switch(pSocket->ParseNum)
	  {
#if GPIO_SUPPORT == 1 // Build control for 16 outputs
	    case 0:  IO_8to1 &= (uint8_t)(~0x01);  parse_complete = 1; break; // Relay-01 OFF
	    case 1:  IO_8to1 |= (uint8_t)0x01;     parse_complete = 1; break; // Relay-01 ON
	    case 2:  IO_8to1 &= (uint8_t)(~0x02);  parse_complete = 1; break; // Relay-02 OFF
	    case 3:  IO_8to1 |= (uint8_t)0x02;     parse_complete = 1; break; // Relay-02 ON
	    case 4:  IO_8to1 &= (uint8_t)(~0x04);  parse_complete = 1; break; // Relay-03 OFF
	    case 5:  IO_8to1 |= (uint8_t)0x04;     parse_complete = 1; break; // Relay-03 ON
	    case 6:  IO_8to1 &= (uint8_t)(~0x08);  parse_complete = 1; break; // Relay-04 OFF
	    case 7:  IO_8to1 |= (uint8_t)0x08;     parse_complete = 1; break; // Relay-04 ON
	    case 8:  IO_8to1 &= (uint8_t)(~0x10);  parse_complete = 1; break; // Relay-05 OFF
	    case 9:  IO_8to1 |= (uint8_t)0x10;     parse_complete = 1; break; // Relay-05 ON
	    case 10: IO_8to1 &= (uint8_t)(~0x20);  parse_complete = 1; break; // Relay-06 OFF
	    case 11: IO_8to1 |= (uint8_t)0x20;     parse_complete = 1; break; // Relay-06 ON
	    case 12: IO_8to1 &= (uint8_t)(~0x40);  parse_complete = 1; break; // Relay-07 OFF
	    case 13: IO_8to1 |= (uint8_t)0x40;     parse_complete = 1; break; // Relay-07 ON
	    case 14: IO_8to1 &= (uint8_t)(~0x80);  parse_complete = 1; break; // Relay-08 OFF
	    case 15: IO_8to1 |= (uint8_t)0x80;     parse_complete = 1; break; // Relay-08 ON
	    case 16: IO_16to9 &= (uint8_t)(~0x01); parse_complete = 1; break; // Relay-09 OFF
	    case 17: IO_16to9 |= (uint8_t)0x01;    parse_complete = 1; break; // Relay-09 ON
	    case 18: IO_16to9 &= (uint8_t)(~0x02); parse_complete = 1; break; // Relay-10 OFF
	    case 19: IO_16to9 |= (uint8_t)0x02;    parse_complete = 1; break; // Relay-10 ON
	    case 20: IO_16to9 &= (uint8_t)(~0x04); parse_complete = 1; break; // Relay-11 OFF
	    case 21: IO_16to9 |= (uint8_t)0x04;    parse_complete = 1; break; // Relay-11 ON
	    case 22: IO_16to9 &= (uint8_t)(~0x08); parse_complete = 1; break; // Relay-12 OFF
	    case 23: IO_16to9 |= (uint8_t)0x08;    parse_complete = 1; break; // Relay-12 ON
	    case 24: IO_16to9 &= (uint8_t)(~0x10); parse_complete = 1; break; // Relay-13 OFF
	    case 25: IO_16to9 |= (uint8_t)0x10;    parse_complete = 1; break; // Relay-13 ON
	    case 26: IO_16to9 &= (uint8_t)(~0x20); parse_complete = 1; break; // Relay-14 OFF
	    case 27: IO_16to9 |= (uint8_t)0x20;    parse_complete = 1; break; // Relay-14 ON
	    case 28: IO_16to9 &= (uint8_t)(~0x40); parse_complete = 1; break; // Relay-15 OFF
	    case 29: IO_16to9 |= (uint8_t)0x40;    parse_complete = 1; break; // Relay-15 ON
	    case 30: IO_16to9 &= (uint8_t)(~0x80); parse_complete = 1; break; // Relay-16 OFF
	    case 31: IO_16to9 |= (uint8_t)0x80;    parse_complete = 1; break; // Relay-16 ON
	    
	    case 55:
  	      IO_8to1 = (uint8_t)0xff;  // Relays 1-8 ON
  	      IO_16to9 = (uint8_t)0xff; // Relays 9-16 ON
	      parse_complete = 1; 
	      break;
	      
	    case 56:
              IO_8to1 = (uint8_t)0x00;  // Relays 1-8 OFF
              IO_16to9 = (uint8_t)0x00; // Relays 9-16 OFF
	      parse_complete = 1; 
	      break;
#endif // GPIO_SUPPORT == 1

#if GPIO_SUPPORT == 2 // Build control for 8 outputs / 8 inputs
	    case 0:  IO_8to1 &= (uint8_t)(~0x01);  parse_complete = 1; break; // Relay-01 OFF
	    case 1:  IO_8to1 |= (uint8_t)0x01;     parse_complete = 1; break; // Relay-01 ON
	    case 2:  IO_8to1 &= (uint8_t)(~0x02);  parse_complete = 1; break; // Relay-02 OFF
	    case 3:  IO_8to1 |= (uint8_t)0x02;     parse_complete = 1; break; // Relay-02 ON
	    case 4:  IO_8to1 &= (uint8_t)(~0x04);  parse_complete = 1; break; // Relay-03 OFF
	    case 5:  IO_8to1 |= (uint8_t)0x04;     parse_complete = 1; break; // Relay-03 ON
	    case 6:  IO_8to1 &= (uint8_t)(~0x08);  parse_complete = 1; break; // Relay-04 OFF
	    case 7:  IO_8to1 |= (uint8_t)0x08;     parse_complete = 1; break; // Relay-04 ON
	    case 8:  IO_8to1 &= (uint8_t)(~0x10);  parse_complete = 1; break; // Relay-05 OFF
	    case 9:  IO_8to1 |= (uint8_t)0x10;     parse_complete = 1; break; // Relay-05 ON
	    case 10: IO_8to1 &= (uint8_t)(~0x20);  parse_complete = 1; break; // Relay-06 OFF
	    case 11: IO_8to1 |= (uint8_t)0x20;     parse_complete = 1; break; // Relay-06 ON
	    case 12: IO_8to1 &= (uint8_t)(~0x40);  parse_complete = 1; break; // Relay-07 OFF
	    case 13: IO_8to1 |= (uint8_t)0x40;     parse_complete = 1; break; // Relay-07 ON
	    case 14: IO_8to1 &= (uint8_t)(~0x80);  parse_complete = 1; break; // Relay-08 OFF
	    case 15: IO_8to1 |= (uint8_t)0x80;     parse_complete = 1; break; // Relay-08 ON
	    
	    case 55:
  	      IO_8to1 = (uint8_t)0xff; // Relays 1-8 ON
	      parse_complete = 1; 
	      break;
	      
	    case 56:
              IO_8to1 = (uint8_t)0x00; // Relays 1-8 OFF
	      parse_complete = 1; 
	      break;
#endif // GPIO_SUPPORT == 2

#if GPIO_SUPPORT == 3 // Build control for 16 inputs
        // No Relay on/off commands supported (all pins are inputs)
#endif // GPIO_SUPPORT == 3

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

#if HELP_SUPPORT == 1
	    case 63: // Show help page 1
	      current_webpage = WEBPAGE_HELP;
              pSocket->pData = g_HtmlPageHelp;
              pSocket->nDataLeft = (uint16_t)(sizeof(g_HtmlPageHelp) - 1);
              pSocket->nState = STATE_CONNECTED;
              pSocket->nPrevBytes = 0xFFFF;
	      break;
	      
	    case 64: // Show help page 2
	      current_webpage = WEBPAGE_HELP2;
              pSocket->pData = g_HtmlPageHelp2;
              pSocket->nDataLeft = (uint16_t)(sizeof(g_HtmlPageHelp2) - 1);
              pSocket->nState = STATE_CONNECTED;
              pSocket->nPrevBytes = 0xFFFF;
	      break;
#endif /* HELP_SUPPORT == 1 */

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

#if UIP_STATISTICS == 1 || UIP_STATISTICS == 2
            case 66: // Show statistics page
	      current_webpage = WEBPAGE_STATS;
              pSocket->pData = g_HtmlPageStats;
              pSocket->nDataLeft = (uint16_t)(sizeof(g_HtmlPageStats) - 1);
              pSocket->nState = STATE_CONNECTED;
              pSocket->nPrevBytes = 0xFFFF;
	      break;
	      
            case 67: // Clear statistics
	      uip_init_stats();
	      
#if DEBUG_SUPPORT == 2
	      // Clear the "reset" counters
	      for (i = 41; i < 46; i++) debug[i] = 0;
	      update_debug_storage1();
#endif // DEBUG_SUPPORT == 2

#if DEBUG_SUPPORT == 3
	      // Clear the "reset" counters, the "additional" debug bytes,
	      // and the TSV debug bytes
	      for (i = 26; i < 46; i++) debug[i] = 0;
	      update_debug_storage1();
#endif // DEBUG_SUPPORT == 3

	      current_webpage = WEBPAGE_STATS;
              pSocket->pData = g_HtmlPageStats;
              pSocket->nDataLeft = (uint16_t)(sizeof(g_HtmlPageStats) - 1);
              pSocket->nState = STATE_CONNECTED;
              pSocket->nPrevBytes = 0xFFFF;
	      break;
#endif // UIP_STATISTICS == 1 || UIP_STATISTICS == 2

	    case 91: // Reboot
	      user_reboot_request = 1;
	      break;
	      
            case 99: // Show simplified IO state page
	      current_webpage = WEBPAGE_RSTATE;
              pSocket->pData = g_HtmlPageRstate;
              pSocket->nDataLeft = (uint16_t)(sizeof(g_HtmlPageRstate) - 1);
              pSocket->nState = STATE_CONNECTED;
              pSocket->nPrevBytes = 0xFFFF;
	      break;
	      
	    default: // Show IO Control page
	      current_webpage = WEBPAGE_IOCONTROL;
              pSocket->pData = g_HtmlPageIOControl;
              pSocket->nDataLeft = (uint16_t)(sizeof(g_HtmlPageIOControl) - 1);
              pSocket->nState = STATE_CONNECTED;
              pSocket->nPrevBytes = 0xFFFF;
	      break;
	  }
          pSocket->nParseLeft = 0;
        }

        if (pSocket->ParseState == PARSE_FAIL) {
          // Parsing failed above. By going to STATE_SENDHEADER we will
	  // repaint the page already sent. While inefficient this will
	  // satisfy the browser's need for a reply when it requests
	  // favicon.ico or whatever else it requests that we don't have.
          pSocket->nState = STATE_SENDHEADER;
	  break;
	}

        if (pSocket->nParseLeft == 0) {
          // Finished parsing ... even if nBytes is not zero
	  // Send the response
          pSocket->nState = STATE_SENDHEADER;
          break;
        }
      }
    }
    
    if (pSocket->nState == STATE_SENDHEADER) {
      // Normally we send one of the web pages, so we provide the
      // CopyHttpHeader function with the length of that data. In some cases
      // (where we are not ready to send the web page and just want to go on
      // to the next incoming packet) we will send no data. In that case
      // pSocket->nDataLeft will be zero when we call CopyHttpHeader.
      uip_send(uip_appdata, CopyHttpHeader(uip_appdata, adjust_template_size()));
      pSocket->nState = STATE_SENDDATA;
      return;
    }
    
    senddata:
    if (pSocket->nState == STATE_SENDDATA) {
      // We have sent the HTML Header or HTML Data previously. Now we send Data.
      // Data is always sent at the end of a "uip_newdata()" response. There may
      // be more data than will fit in one packet, so that additional data (if
      // any) will be sent in response to "uip_acked()" process. If there is no
      // data to send, or if all data has been sent, we close the connection.
      
      if (pSocket->nDataLeft == 0) {
        // There is no data to send. Close connection
        nBufSize = 0;
      }
      else {
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
      /* Send header again */
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


void clear_saved_postpartial_all(void)
{
uint8_t i;
  for (i=0; i<24; i++) saved_postpartial[i] = '\0';
}


void clear_saved_postpartial_data(void)
{
uint8_t i;
  for (i=4; i<24; i++) saved_postpartial[i] = '\0';
}


void clear_saved_postpartial_previous(void)
{
uint8_t i;
  for (i=0; i<24; i++) saved_postpartial_previous[i] = '\0';
}


void parse_POST_string(uint8_t curr_ParseCmd, uint8_t num_chars)
{
uint8_t i;
uint8_t amp_found;
uint8_t frag_flag;
uint8_t resume;
char tmp_Pending[20];
  // This function processes POST data for one of several string fields:
  //   Device Name field
  //   MQTT Username field
  //   MQTT Password field
  //
  // The POST data for the string field is saved in Pending_tmp, and the
  // calling function must copy tmp_Pending to Pending_devicename,
  // Pending_mqtt_username, or Pending_mqtt_password as appropriate.
  //
  // ParseNum isn't used in the processing of this ParseCmd as a string field
  // is the only item assigned to the ParseCmd (for example there will be an
  // 'a00' but no 'a01').
  //
  // POST data for strings are a special case case in that the resulting
  // string can consist of anything from 0 to X number of characters. So, we
  // have to parse until the POST delimiter '&' is found.
  //
  amp_found = 0;
  for (i=0; i<20; i++) tmp_Pending[i] = '\0';
  
  if (saved_postpartial_previous[0] == curr_ParseCmd) {
    // Clear the saved_postpartial_prevous[0] byte (the ParseCmd byte) as it
    // should only get used once on processing a given TCP Fragment.
    saved_postpartial_previous[0] = '\0';
    // Since the ParseCmd matched the saved_postpartial_previous value we are
    // re-assembling a TCP Fragment that occurred during this command. The
    // ParseCmd and ParseNum values are already restored. We need to
    // determine where in this command the TCP Fragmentation break occurred
    // and continue from there.
    frag_flag = 1; // frag_flag is used to manage the TCP Fragment restore
                   // process within this specific ParseCmd process.
  }
  else {
    frag_flag = 0;
    // We are not doing a TCP Fragment reassembly. Clear the data part of the
    // saved_postpartial values in case a TCP Fragment break occurs in this
    // parse.
    clear_saved_postpartial_data(); // Clear [4] and higher
  }

  // Notes on TCP Fragmentation
  // If we are recovering from fragmentation then the frag_flag will be 1.
  // If the string has zero length then we will enter this code with
  //   saved_postpartial_previous[4] equal to '\0' and the next character
  //   in the POST will be an &.
  // If the string has non-zero length but we didn't collect any characters
  //   in the prior TCP Fragment then saved_postpartial_previous[4] will be
  //   equal to '\0' but the next character in the POST will not be an &.
  // If the fragmentation occurred before the last character in the string
  //   there will be at least one character in the saved_postpartial_previous[]
  //   array and the next character in the POST will not be an &. We should
  //   collect that/those character(s) then go to reading the POST. Note that
  //   it is not possible to hit another fragment while finishing the
  //   collection of a previously fragmented field.
  // If the last character in the string was collected in the previous TCP
  //   Fragment but the & was not yet encountered then the & will be the first
  //   character in the current packet.

  resume = 0;
  if (frag_flag == 1) {
    // Handle restoration of previously collected data, if any
    for (i = 0; i < num_chars; i++) {
      // First restore any data that was saved from the previous TCP
      // Fragment.
      // If the TCP Fragmentation occurred between the = and start of the
      // string data there won't be any stored data and we'll break out
      // of the for() loop with resume still equal zero.
      // If the TCP Fragmentation occurred between the = and & of a zero
      // length string there won't be any stored data and we'll break out
      // of the for() loop with resume still equal zero.
      if (saved_postpartial_previous[4+i] != '\0') {
        tmp_Pending[i] = saved_postpartial_previous[4+i];
      }
      else {
        resume = i;
        break;
      }
    }
    if (*tmp_pBuffer == '&') {
      // Handle the case where all characters were collected in the last TCP
      // Fragment but the & was not seen. In this case the & is the first
      // character of this packet.
      amp_found = 1;
    }
  }

  // If amp_found == 0 then there are characters to be collected from the
  // packet. The 'resume' variable will indicate where to resume inserting
  // these characters in tmp_Pending.
  // If no TCP Fragment occurred 'amp_found' and 'resume' will both equal zero
  // at this point.
  // If a TCP Fragment occurred between the = sign and the string data
  // 'amp_found' and 'resume' will both equal zero at this point.
  
  if (amp_found == 0) {
    for (i = resume; i < num_chars; i++) {
      // Collect characters until num_chars are collected or '&' is found in
      // uip_buf.
      if (amp_found == 0) {
        // Collect a byte of the devicename from the uip_buf until the '&' is
        // found.
        if (*tmp_pBuffer == '&') {
          // Set the amp_found flag and do not store this character in
          // devicename.
          amp_found = 1;
        }
        else {
          tmp_Pending[i] = *tmp_pBuffer;
          saved_postpartial[4+i] = *tmp_pBuffer;
          tmp_nParseLeft--;
          saved_nparseleft = tmp_nParseLeft;
          tmp_pBuffer++;
          tmp_nBytes--;
          if (tmp_nBytes == 0) {
            // If nBytes == 0 we just read the last byte of POST data in the
            // uip_buf. The POST data will continue in the next TCP Fragment,
            // but we need to exit the for() and while() loops now.
            if (i == (num_chars - 1)) {
              // If i == (num_chars - 1) then we collected the maximum number of
              // characters without hitting '&' ... but we know '&' is next when
              // we return to process the next TCP Fragment, so we need to set
              // the saved parsestate accordingly.
              saved_parsestate = PARSE_DELIM;
            }
            break_while = 1;
            break; // This will break the for() loop. But we need to break the
                   // while() loop on return from this function. So break_while
                   // is set to 1.
          }
        }
      }
      if (amp_found == 1) {
        // We need to null any remaining characters in the tmp_Pending string
	// up to num_chars in case we are shortening the string.
        tmp_Pending[i] = '\0';
        // We must reduce nParseLeft here because it is based on the PARESEBYTES_
        // value which assumes num_chars bytes for the string field. If the
        // POSTed string field is less than num_chars bytes then nParseLeft is
        // too big by the number of characters omitted and must be corrected
        // here. Note that nBytes is not decremented and the pBuffer pointer is
        // not advanced because nothing is read from the buffer. When we exit the
        // loop the buffer pointer is left pointing at the '&' which starts the
        // next field.
        tmp_nParseLeft--;
      }
    }
  }

  // Always execute the following code before returning from the function.
  //
  // When the function was called the tmp_Pending value was filled with '\0'
  // so we know the new string is terminated with '\0'.
  //
  // If we read the entire string field we departed the for() loop with the 
  // pointers still pointing at the '&', which is what all the other steps
  // in the POST read do.
  // 
  // If we didn't find the '&' due to TCP fragmentation our saved pointers
  // will bring us back to this function to finish collecting the string
  // with the next TCP Fragment.
  
  // If break_while is not set we did not hit a TCP Fragement point and we
  // no longer need the saved_postpartial values. Clear them to prevent
  // interference with subsequent restores.
  if (break_while == 0) clear_saved_postpartial_all();
  
  // Update the Device Name field
  if (curr_ParseCmd == 'a') {
    for (i=0; i<num_chars; i++) Pending_devicename[i] = tmp_Pending[i];
  }

#if MQTT_SUPPORT == 1
  // Update the MQTT Username field
  else if (curr_ParseCmd == 'l') {
    for (i=0; i<num_chars; i++) Pending_mqtt_username[i] = tmp_Pending[i];
  }

  // Update the MQTT Password field
  else if (curr_ParseCmd == 'm') {
    for (i=0; i<num_chars; i++) Pending_mqtt_password[i] = tmp_Pending[i];
  }
#endif // MQTT_SUPPORT == 1
}


void parse_POST_address(uint8_t curr_ParseCmd, uint8_t curr_ParseNum)
{
  uint8_t i;
  
  alpha[0] = '-';
  alpha[1] = '-';
  alpha[2] = '-';


  if (saved_postpartial_previous[0] == curr_ParseCmd) {
    // Clear the saved_postpartial_prevous[0] byte (the ParseCmd byte) as it
    // should only get used once on processing a given TCP Fragment.
    saved_postpartial_previous[0] = '\0';
    // We are re-assembling a fragment that occurred during this command. The
    // ParseCmd and ParseNum values are already restored. We need to determine
    // where in this command the fragmentation break occurred and continue
    // from there.
    //
    // Check for alphas found in prior TCP Fragment
    if (saved_postpartial_previous[4] != '\0') alpha[0] = saved_postpartial_previous[4];
    if (saved_postpartial_previous[5] != '\0') alpha[1] = saved_postpartial_previous[5];
    if (saved_postpartial_previous[6] != '\0') alpha[2] = saved_postpartial_previous[6];
  }
  else {
    // We are not doing a reassembly. Clear the data part of the
    // saved_postpartial values in case a fragment break occurs during this
    // parse.
    clear_saved_postpartial_data(); // Clear [4] and higher
  }

  for (i=0; i<3; i++) {
    // Examine each 'alpha' character to see if it was already found
    // in a prior TCP Fragment. If not collect it now.
    // If collecting characters from the POST break the while() loop
    // if a TCP Fragment boundary is found unless the character
    // collected is the last 'alpha'.
    if (alpha[i] == '-') {
      alpha[i] = (uint8_t)(*tmp_pBuffer);
      saved_postpartial[i+4] = (uint8_t)(*tmp_pBuffer);
      tmp_nParseLeft--;
      saved_nparseleft = tmp_nParseLeft;
      tmp_pBuffer++;
      tmp_nBytes--;
      if (i != 2 && tmp_nBytes == 0) {
        break_while = 1; // Hit end of fragment but still have characters to
                         // collect in the next packet. Set break_while to 1
                         // so that we'll break out of the while() loop on
                         // return from this function.
        break; // Break out of for() loop.
      }
    }
  }
  if (break_while == 1) return; // Hit end of fragment. Break out of while() loop.

  // If we get this far we no longer need the saved_postpartial values and
  // must clear them to prevent interference with subsequent restores.
  clear_saved_postpartial_all();

  {
    // The following updates the IP address, Gateway address, NetMask, and MQTT
    // IP Address based on GUI input.
    // This code converts the three alpha fields captured above with decimal
    // alphas ('0' to '9') into a single uint8_t numeric representation of the
    // new setting. The code must validate that the alpha characters passed to
    // it are within valid ranges.

    // Create a uint8_t from the three alpha characters.
    uint8_t temp;
    uint8_t invalid;
    invalid = 0;
    // Validate user entry max 255
    temp = (uint8_t)(       (alpha[2] - '0'));
    temp = (uint8_t)(temp + (alpha[1] - '0') * 10);
    if (temp > 55 && alpha[0] > '1') invalid = 1;
    else temp = (uint8_t)(temp + (alpha[0] - '0') * 100);
    if (invalid == 0) { // Make change only if valid entry
      switch(curr_ParseNum)
      {
        case 0:  Pending_hostaddr[3] = (uint8_t)temp; break;
        case 1:  Pending_hostaddr[2] = (uint8_t)temp; break;
        case 2:  Pending_hostaddr[1] = (uint8_t)temp; break;
        case 3:  Pending_hostaddr[0] = (uint8_t)temp; break;
        case 4:  Pending_draddr[3] = (uint8_t)temp; break;
        case 5:  Pending_draddr[2] = (uint8_t)temp; break;
        case 6:  Pending_draddr[1] = (uint8_t)temp; break;
        case 7:  Pending_draddr[0] = (uint8_t)temp; break;
        case 8:  Pending_netmask[3] = (uint8_t)temp; break;
        case 9:  Pending_netmask[2] = (uint8_t)temp; break;
        case 10: Pending_netmask[1] = (uint8_t)temp; break;
        case 11: Pending_netmask[0] = (uint8_t)temp; break;
#if MQTT_SUPPORT == 1
        case 12: {
	  Pending_mqttserveraddr[3] = (uint8_t)temp;
	  break;
	}
        case 13: Pending_mqttserveraddr[2] = (uint8_t)temp; break;
        case 14: Pending_mqttserveraddr[1] = (uint8_t)temp; break;
        case 15: Pending_mqttserveraddr[0] = (uint8_t)temp; break;
#endif // MQTT_SUPPORT == 1
        default: break;
      }
    }
  }

  if (tmp_nBytes == 0) {
    // Hit end of fragment. Break out of while() loop. The first character
    // of the next packet will be '&' so we need to set PARSE_DELIM.
    break_while = 2; // Hit end of fragment. Set break_while to 2 so that
                     // we'll break out of the while() loop on return from
                     // this function AND go to the PARSE_DELIM state.
    return;
  }
}


void parse_POST_port(uint8_t curr_ParseCmd, uint8_t curr_ParseNum)
{
  uint8_t i;

  for (i=0; i<5; i++) alpha[i] = '-';

  if (saved_postpartial_previous[0] == curr_ParseCmd) {
    // Clear the saved_postpartial_prevous[0] byte (the ParseCmd byte) as it
    // should only get used once on processing a given TCP Fragment.
    saved_postpartial_previous[0] = '\0';
    // We are re-assembling a fragment that occurred during this command. The
    // ParseCmd and ParseNum values are already restored. We need to determine
    // where in this command the fragmentation break occurred and continue
    // from there.
    //
    // Check for alphas found in prior TCP Fragment
    for (i=0; i<5; i++) {
      if (saved_postpartial_previous[i+4] != '\0') alpha[i] = saved_postpartial_previous[i+4];
    }
  }
  else {
    // We are not doing a reassembly. Clear the data part of the
    // saved_postpartial values in case a fragment break occurs during this
    // parse.
    clear_saved_postpartial_data(); // Clear [4] and higher
  }

  {
    uint8_t i;
    for (i=0; i<5; i++) {
      // Examine each 'alpha' character to see if it was already found
      // in a prior TCP Fragment. If not collect it now.
      // If collecting characters from the POST break the while() loop
      // if a TCP Fragment boundary is found unless the character
      // collected is the last 'alpha'.
      if (alpha[i] == '-') {
        alpha[i] = (uint8_t)(*tmp_pBuffer);
        saved_postpartial[i+4] = *tmp_pBuffer;
        tmp_nParseLeft--;
        saved_nparseleft = tmp_nParseLeft;
        tmp_pBuffer++;
        tmp_nBytes--;
        if (i != 4 && tmp_nBytes == 0) {
          break_while = 1; // Hit end of fragment but still have characters to
	                   // collect in the next packet. Set break_while to 1
			   // so that we'll break out of the while() loop on
			   // return from this function.
   	break; // Break out of for() loop.
        }
      }
    }
    if (break_while == 1) return; // Hit end of fragment. Break out of while() loop.
  }

  // If we get this far we no longer need the saved_postpartial values and
  // must clear them to prevent interference with subsequent restores.
  clear_saved_postpartial_all();

  {
    // Code to update the Port number based on GUI input.
    // The code converts five alpha fields with decimal alphas ('0' to '9')
    // into a single uint16_t numeric representation of the new setting. The
    // code also validates that the setting is within a valid range.
    uint16_t temp;
    uint8_t invalid;
    invalid = 0;
    // Validate user entry min 10 max 65535
    temp = (uint16_t)(       (alpha[4] - '0'));
    temp = (uint16_t)(temp + (alpha[3] - '0') * 10);
    temp = (uint16_t)(temp + (alpha[2] - '0') * 100);
    temp = (uint16_t)(temp + (alpha[1] - '0') * 1000);
    if (temp > 5535 && alpha[0] > '5') invalid = 1;
    else temp = (uint16_t)(temp + (alpha[0] - '0') * 10000);
    if (temp < 10) invalid = 1;
    if (invalid == 0) {
      if (curr_ParseNum == 0) Pending_port = (uint16_t)temp;
#if MQTT_SUPPORT == 1
      else Pending_mqttport = (uint16_t)temp;
#endif // MQTT_SUPPORT == 1
    }
  }

  if (tmp_nBytes == 0) {
    // Hit end of fragment. Break out of while() loop. The first character
    // of the next packet will be '&' so we need to set PARSE_DELIM.
    break_while = 2; // Hit end of fragment. Set break_while to 2 so that
                     // we'll break out of the while() loop on return from
                     // this function AND go to the PARSE_DELIM state.
    return;
  }
}


uint8_t GpioGetPin(uint8_t nGpio)
{
  // This function returns a 1 or 0 indicating the state of the requested IO
  // pin (either input or output) as stored in the IO_8to1 and IO_16to9
  // variables.
  
  switch (nGpio) {
    case 0:  if (IO_8to1  & (uint8_t)(0x01)) return 1; break;
    case 1:  if (IO_8to1  & (uint8_t)(0x02)) return 1; break;
    case 2:  if (IO_8to1  & (uint8_t)(0x04)) return 1; break;
    case 3:  if (IO_8to1  & (uint8_t)(0x08)) return 1; break;
    case 4:  if (IO_8to1  & (uint8_t)(0x10)) return 1; break;
    case 5:  if (IO_8to1  & (uint8_t)(0x20)) return 1; break;
    case 6:  if (IO_8to1  & (uint8_t)(0x40)) return 1; break;
    case 7:  if (IO_8to1  & (uint8_t)(0x80)) return 1; break;
    case 8:  if (IO_16to9 & (uint8_t)(0x01)) return 1; break;
    case 9:  if (IO_16to9 & (uint8_t)(0x02)) return 1; break;
    case 10: if (IO_16to9 & (uint8_t)(0x04)) return 1; break;
    case 11: if (IO_16to9 & (uint8_t)(0x08)) return 1; break;
    case 12: if (IO_16to9 & (uint8_t)(0x10)) return 1; break;
    case 13: if (IO_16to9 & (uint8_t)(0x20)) return 1; break;
    case 14: if (IO_16to9 & (uint8_t)(0x40)) return 1; break;
    case 15: if (IO_16to9 & (uint8_t)(0x80)) return 1; break;
  }
  return 0;

}


#if GPIO_SUPPORT == 1 // Build control for 16 outputs
void GpioSetPin(uint8_t nGpio, uint8_t nState)
{
  // Function will set or clear Relays based on GUI input.
  //
  // nState is a digit, not a character.
  
  uint8_t mask;

  mask = 0;
  
  switch(nGpio) {
    case 0:  mask = 0x01; break;
    case 1:  mask = 0x02; break;
    case 2:  mask = 0x04; break;
    case 3:  mask = 0x08; break;
    case 4:  mask = 0x10; break;
    case 5:  mask = 0x20; break;
    case 6:  mask = 0x40; break;
    case 7:  mask = 0x80; break;
    case 8:  mask = 0x01; break;
    case 9:  mask = 0x02; break;
    case 10: mask = 0x04; break;
    case 11: mask = 0x08; break;
    case 12: mask = 0x10; break;
    case 13: mask = 0x20; break;
    case 14: mask = 0x40; break;
    case 15: mask = 0x80; break;
    default: break;
  }
  
  if (nGpio < 8) {
    if (nState) IO_8to1 |= mask;
    else IO_8to1 &= (uint8_t)~mask;
  }
  else {
    if (nState) IO_16to9 |= mask;
    else IO_16to9 &= (uint8_t)~mask;
  }  
}
#endif // GPIO_SUPPORT == 1


#if GPIO_SUPPORT == 2 // Build control for 8 outputs / 8 inputs
void GpioSetPin(uint8_t nGpio, uint8_t nState)
{
  // Function will set or clear Relays based on GUI input.
  //
  // nState is a digit, not a character.
  
  uint8_t mask;
  
  mask = 0;

  switch(nGpio) {
    case 0: mask = 0x01; break;
    case 1: mask = 0x02; break;
    case 2: mask = 0x04; break;
    case 3: mask = 0x08; break;
    case 4: mask = 0x10; break;
    case 5: mask = 0x20; break;
    case 6: mask = 0x40; break;
    case 7: mask = 0x80; break;
    default: break;
  }
  
  if (nState) IO_8to1 |= mask;
  else IO_8to1 &= (uint8_t)~mask;
  
}
#endif // GPIO_SUPPORT == 2


#if GPIO_SUPPORT == 3 // Build control for 16 inputs
void GpioSetPin(uint8_t nGpio, uint8_t nState)
{
  // No SetPin support - all pins are inputs
}
#endif // GPIO_SUPPORT == 3


void SetMAC(uint8_t itemnum, uint8_t alpha1, uint8_t alpha2)
{
  // This function updates the MAC based on GUI input.
  //
  // The function is called and is passed two alpha fields in hex form ('0' to
  // '9' and 'a' to 'f') that represent the new setting. This function has to
  // construct a single uint8_t numeric representation of the two alpha fields.
  // The function must validate that the alpha characters passed to it are
  // within valid ranges.
  //
  // alpha1 and alpha2 are characters, not a digits

  uint16_t temp;
  uint8_t invalid;
  
  temp = 0;
  invalid = 0;

  // Create a single digit from the two alpha characters. Check validity.
  if (alpha1 >= '0' && alpha1 <= '9') alpha1 = (uint8_t)(alpha1 - '0');
  else if (alpha1 >= 'a' && alpha1 <= 'f') alpha1 = (uint8_t)(alpha1 - 87);
  else invalid = 1; // If an invalid entry set indicator
  
  if (alpha2 >= '0' && alpha2 <= '9') alpha2 = (uint8_t)(alpha2 - '0');
  else if (alpha2 >= 'a' && alpha2 <= 'f') alpha2 = (uint8_t)(alpha2 - 87);
  else invalid = 1; // If an invalid entry set indicator
    
  if (invalid == 0) { // Change value only if valid entry
    temp = (uint8_t)((alpha1<<4) + alpha2); // Convert to single digit
    switch(itemnum)
    {
    case 0: Pending_uip_ethaddr_oct[5] = (uint8_t)temp; break;
    case 1: Pending_uip_ethaddr_oct[4] = (uint8_t)temp; break;
    case 2: Pending_uip_ethaddr_oct[3] = (uint8_t)temp; break;
    case 3: Pending_uip_ethaddr_oct[2] = (uint8_t)temp; break;
    case 4: Pending_uip_ethaddr_oct[1] = (uint8_t)temp; break;
    case 5: Pending_uip_ethaddr_oct[0] = (uint8_t)temp; break;
    default: break;
    }
  }
}
