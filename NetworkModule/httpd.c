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
#include "gpio.h"
#include "main.h"

#include "stdlib.h"
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
#define STATE_PARSEPOST		10	// We are currently parsing the client's POST-data
#define STATE_SENDHEADER	11	// Next we send him the HTTP header
#define STATE_SENDDATA		12	// ... followed by data
#define STATE_PARSEGET		13	// We are currently parsing the client's GET-request

#define PARSE_CMD		0       // Parsing the command byte in a POST
#define PARSE_NUM10		1       // Parsing the most sig digit of POST cmd
#define PARSE_NUM1		2       // Parsing the least sig digit of a POST cmd
#define PARSE_EQUAL		3       // Parsing the equal sign of a POST cmd
#define PARSE_VAL		4       // Parsing the data value of a POST cmd
#define PARSE_DELIM		5       // Parsing the delimiter of a POST cmd
#define PARSE_SLASH1		6       // Parsing the slash of a GET cmd

uint8_t current_webpage;                // Tracks the web page that is currently displayed

extern uint16_t Port_Httpd;             // Port number in use

extern uint8_t Relays_16to9;            // State of upper 8 relays
extern uint8_t Relays_8to1;             // State of lower 8 relays
extern uint8_t invert_output;           // Relay output inversion control

extern uint8_t Pending_hostaddr4;       // Temp storage for new IP address
extern uint8_t Pending_hostaddr3;       //
extern uint8_t Pending_hostaddr2;       //
extern uint8_t Pending_hostaddr1;       //

extern uint8_t Pending_draddr4;         // Temp storage for new Gateway address
extern uint8_t Pending_draddr3;         //
extern uint8_t Pending_draddr2;         //
extern uint8_t Pending_draddr1;         //

extern uint8_t Pending_netmask4;        // Temp storage for new Netmask
extern uint8_t Pending_netmask3;        //
extern uint8_t Pending_netmask2;        //
extern uint8_t Pending_netmask1;        //

extern uint16_t Pending_port;           // Temp storage for new Port number

extern uint8_t Pending_uip_ethaddr1;    // Temp storage for new MAC address
extern uint8_t Pending_uip_ethaddr2;    //
extern uint8_t Pending_uip_ethaddr3;    //
extern uint8_t Pending_uip_ethaddr4;    //
extern uint8_t Pending_uip_ethaddr5;    //
extern uint8_t Pending_uip_ethaddr6;    //

// The variables stored in EEPROM can only be accessed within the
// file in which they are declared. But I need to display them from
// within the httpd.c file. So additional variables are needed to
// allow.
extern uint8_t ex_stored_hostaddr4;	  // MSB hostaddr stored in EEPROM
extern uint8_t ex_stored_hostaddr3;	  //
extern uint8_t ex_stored_hostaddr2;	  //
extern uint8_t ex_stored_hostaddr1;	  // LSB hostaddr

extern uint8_t ex_stored_draddr4;	  // MSB draddr stored in EEPROM
extern uint8_t ex_stored_draddr3;	  //
extern uint8_t ex_stored_draddr2;	  //
extern uint8_t ex_stored_draddr1;	  // LSB draddr

extern uint8_t ex_stored_netmask4;	  // MSB netmask stored in EEPROM
extern uint8_t ex_stored_netmask3;	  //
extern uint8_t ex_stored_netmask2;	  //
extern uint8_t ex_stored_netmask1;	  // LSB netmask

extern uint16_t ex_stored_port;		  // Port number stored in EEPROM

extern uint8_t uip_ethaddr1;		  // MAC MSB
extern uint8_t uip_ethaddr2;		  //
extern uint8_t uip_ethaddr3;		  //
extern uint8_t uip_ethaddr4;		  //
extern uint8_t uip_ethaddr5;		  //
extern uint8_t uip_ethaddr6;		  // MAC LSB

extern uint8_t ex_stored_devicename[20];  // Device name

extern uint8_t submit_changes;            // Communicates the need to restart
                                          // software or reboot

uint8_t OctetArray[11];		          // Used in conversion of integer values to
					  // character values


// Relay Control Webpage (Default)
// Below is the parse bytes limit for POST data sent by the form below. This value MUST
// be calculated based on the amount of data expected to be returned by the form. Note
// that a form submittal always returns the exact same amount of information even if
// no fields were changed on the form (with the exception of the devicename field).
//
// The form contained in the g_HtmlPageDefault webpage will generate 18 data update
// replies. These replies need to be parsed to extract the data from them. We need to
// stop parsing the reply POST data after all update bytes are parsed. The formula for
// determining the stop value is as follows:
//   For 1 of the replies (device name):
//   POST consists of a ParseCmd (an "a" in this case) in 1 byte
//   Followed by the ParseNum in 2 bytes
//   Followed by an equal sign in 1 byte
//   Followed by a device name in 1 to 20 bytes
//   Followed by a parse delimiter in 1 byte
//     PLUS
//   For 16 of the replies (relay items):
//   POST consists of a ParseCmd (an "o" in this case) in 1 byte
//   Followed by the ParseNum in 2 bytes
//   Followed by an equal sign in 1 byte
//   Followed by a state value in 1 byte
//   Followed by a parse delimiter in 1 byte
//     PLUS
//   For 1 of the replies (invert):
//   POST consists of a ParseCmd (a "g" in this case) in 1 byte
//   Followed by the ParseNum in 2 bytes
//   Followed by an equal sign in 1 byte
//   Followed by a state value in 1 byte
//   Followed by a parse delimiter in 1 byte
// The formula is
// PARSEBYTES = (#device name bytes x 1) + (#data items x 6) + (#invert x 6) - 1
// In this case: (25 x 1) + (16 x 6) + (1 x 6) - 1 = 126 bytes
#define WEBPAGE_DEFAULT		0
#define PARSEBYTES_DEFAULT	126
static const unsigned char checked[] = "checked";
static const char g_HtmlPageDefault[] =
  "<!DOCTYPE HTML PUBLIC \"-//W3C//DTD HTML 4.01 Transitional//EN\">"
  "<html><head>"
  "<title>Relay Control</title>"
  "<style type='text/css'>"
  ".s0 { background-color: red; }"
  ".s1 { background-color: green; }"
  "td { text-align: center; }"
  ".tclass { width: 145px; }"
  "</style>"
  "</head><body>"
  "<h1>Relay Control</h1>"
  "<form method='POST' action='/'>"
  "<table border='1px'><colgroup><col width='100px'><col width='152px'></colgroup>"
  "<tr><td>Name:</td><td><input type='text' name='a00' class='tclass' value='%a00xxxxxxxxxxxxxxxxxxxx' pattern='[0-9a-zA-Z-_*.]{1,20}' title='1 to 20 letters, numbers, and -_*. no spaces' maxlength='20' size='20'></td></tr>"
  "</table>"
  "<table border='1px'><colgroup><col width='100px'><col width='30px'><col width='120px'></colgroup>"
  "<tr><td></td><td></td><td>SET</td></tr>"
  "<tr><td>Relay01</td><td class='s%i00'></td><td><input type='radio' id='relay01on' name='o00' value='1' %o00><label for='relay01on'>ON</label><input type='radio' id='relay01off' name='o00' value='0' %p00><label for='relay01off'>OFF</label></td></tr>"
  "<tr><td>Relay02</td><td class='s%i01'></td><td><input type='radio' id='relay02on' name='o01' value='1' %o01><label for='relay02on'>ON</label><input type='radio' id='relay02off' name='o01' value='0' %p01><label for='relay02off'>OFF</label></td></tr>"
  "<tr><td>Relay03</td><td class='s%i02'></td><td><input type='radio' id='relay03on' name='o02' value='1' %o02><label for='relay03on'>ON</label><input type='radio' id='relay03off' name='o02' value='0' %p02><label for='relay03off'>OFF</label></td></tr>"
  "<tr><td>Relay04</td><td class='s%i03'></td><td><input type='radio' id='relay04on' name='o03' value='1' %o03><label for='relay04on'>ON</label><input type='radio' id='relay04off' name='o03' value='0' %p03><label for='relay04off'>OFF</label></td></tr>"
  "<tr><td>Relay05</td><td class='s%i04'></td><td><input type='radio' id='relay05on' name='o04' value='1' %o04><label for='relay05on'>ON</label><input type='radio' id='relay05off' name='o04' value='0' %p04><label for='relay05off'>OFF</label></td></tr>"
  "<tr><td>Relay06</td><td class='s%i05'></td><td><input type='radio' id='relay06on' name='o05' value='1' %o05><label for='relay06on'>ON</label><input type='radio' id='relay06off' name='o05' value='0' %p05><label for='relay06off'>OFF</label></td></tr>"
  "<tr><td>Relay07</td><td class='s%i06'></td><td><input type='radio' id='relay07on' name='o06' value='1' %o06><label for='relay07on'>ON</label><input type='radio' id='relay07off' name='o06' value='0' %p06><label for='relay07off'>OFF</label></td></tr>"
  "<tr><td>Relay08</td><td class='s%i07'></td><td><input type='radio' id='relay08on' name='o07' value='1' %o07><label for='relay08on'>ON</label><input type='radio' id='relay08off' name='o07' value='0' %p07><label for='relay08off'>OFF</label></td></tr>"
  "<tr><td>Relay09</td><td class='s%i08'></td><td><input type='radio' id='relay09on' name='o08' value='1' %o08><label for='relay09on'>ON</label><input type='radio' id='relay09off' name='o08' value='0' %p08><label for='relay09off'>OFF</label></td></tr>"
  "<tr><td>Relay10</td><td class='s%i09'></td><td><input type='radio' id='relay10on' name='o09' value='1' %o09><label for='relay10on'>ON</label><input type='radio' id='relay10off' name='o09' value='0' %p09><label for='relay10off'>OFF</label></td></tr>"
  "<tr><td>Relay11</td><td class='s%i10'></td><td><input type='radio' id='relay11on' name='o10' value='1' %o10><label for='relay11on'>ON</label><input type='radio' id='relay11off' name='o10' value='0' %p10><label for='relay11off'>OFF</label></td></tr>"
  "<tr><td>Relay12</td><td class='s%i11'></td><td><input type='radio' id='relay12on' name='o11' value='1' %o11><label for='relay12on'>ON</label><input type='radio' id='relay12off' name='o11' value='0' %p11><label for='relay12off'>OFF</label></td></tr>"
  "<tr><td>Relay13</td><td class='s%i12'></td><td><input type='radio' id='relay13on' name='o12' value='1' %o12><label for='relay13on'>ON</label><input type='radio' id='relay13off' name='o12' value='0' %p12><label for='relay13off'>OFF</label></td></tr>"
  "<tr><td>Relay14</td><td class='s%i13'></td><td><input type='radio' id='relay14on' name='o13' value='1' %o13><label for='relay14on'>ON</label><input type='radio' id='relay14off' name='o13' value='0' %p13><label for='relay14off'>OFF</label></td></tr>"
  "<tr><td>Relay15</td><td class='s%i14'></td><td><input type='radio' id='relay15on' name='o14' value='1' %o14><label for='relay15on'>ON</label><input type='radio' id='relay15off' name='o14' value='0' %p14><label for='relay15off'>OFF</label></td></tr>"
  "<tr><td>Relay16</td><td class='s%i15'></td><td><input type='radio' id='relay16on' name='o15' value='1' %o15><label for='relay16on'>ON</label><input type='radio' id='relay16off' name='o15' value='0' %p15><label for='relay16off'>OFF</label></td></tr>"
  "<tr><td>Invert</td><td></td><td><input type='radio' id='invertOn' name='g00' value='1' %g00><label for='invertOn'>ON</label><input type='radio' id='invertOff' name='g00' value='0' %h00><label for='invertOff'>OFF</label></td></tr>"
  "</table>"
  "<button type='submit' title='Saves your changes - does not restart the Network Module'>Save</button>"
  "<button type='reset' title='Un-does any changes that have not been saved'>Undo All</button>"
  "</form>"
  "<a href='%x00http://192.168.001.004:08080/61'><button title='Save first! This button will not save your changes'>Address Settings</button></a>"
#if UIP_STATISTICS == 1
  "<a href='%x00http://192.168.001.004:08080/66'><button title='Save first! This button will not save your changes'>Network Statistics</button></a>"
#endif /* UIP_STATISTICS == 1 */
#if HELP_SUPPORT == 1
  "<a href='%x00http://192.168.001.004:08080/63'><button title='Save first! This button will not save your changes'>Help</button></a>"
#endif /* HELP_SUPPORT == 1 */
  "</body></html>";


// Address Settings webpage
// Below is the parse bytes limit for POST data sent by the form below. This value MUST
// be calculated based on the amount of data expected to be returned by the form. Note
// that a form submittal always returns the exact same amount of information even if
// no fields were changed on the form.
//
// The form contained in the g_HtmlPageAddress webpage will generate 19 data replies.
// BUT NOTE THAT 12 OF THE REPLIES HAVE 3 BYTES EACH, ONE OF THE REPLIES HAS 5 BYTES,
// AND 6 OF THE REPLIES HAVE 2 BYTES. These replies need to be parsed to extract the
// data from them. We need to stop parsing the reply POST data after all update bytes
// are parsed. The formula for determining the stop value is as follows:
//
//   POST consists of:
//     A ParseCmd (a "b" in this case) in 1 byte
//     Followed by the ParseNum in 2 bytes
//     Followed by an equal sign in 1 byte
//     Followed by a state value in 3 bytes (for 16 of the replies)
//     Followed by a parse delimiter in 1 byte
//   PLUS
//     A ParseCmd (a "c" in this case) in 1 byte
//     Followed by the ParseNum in 2 bytes
//     Followed by an equal sign in 1 byte
//     Followed by a port value in 5 bytes (for 1 of the replies)
//     Followed by a parse delimiter in 1 byte
//   PLUS
//     A ParseCmd (a "d" in this case) in 1 byte
//     Followed by the ParseNum in 2 bytes
//     Followed by an equal sign in 1 byte
//     Followed by a state value in 2 bytes (for 6 of the replies)
//     Followed by a parse delimiter in 1 byte
// THUS for 12 of the replies there are 8 bytes per reply
// For 1 of the replies there are 10 bytes in the reply
// For 6 of the replies there are 7 bytes per replye
// The formula in this case is PARSEBYTES = (12 x 8) + (1 x 10) + (6 x 7) - 1
//                             PARSEBYTES =  96      +  10      +  42     - 1 = 147
#define WEBPAGE_ADDRESS		1
#define PARSEBYTES_ADDRESS	147
static const char g_HtmlPageAddress[] =
  "<!DOCTYPE HTML PUBLIC \"-//W3C//DTD HTML 4.01 Transitional//EN\">"
  "<html><head>"
  "<title>Address Settings</title>"
  "<style type='text/css'>"
  "td { text-align: center; }"
  ".tclass { width: 25px; }"
  ".tclass1 { width: 30px; }"
  ".tclass2 { width: 46px; }"
  "</style>"
  "</head><body>"
  "<h1>Address Settings</h1>"
  "<form method='POST' action='/'>"
  "<table border='1px'><colgroup><col width='100px'><col width='45px'><col width='45px'><col width='45px'><col width='44px'></colgroup>"
  "<tr><td>IP Addr</td><td><input type='text' name='b00' class='tclass1' value='%b00' pattern='[0-9]{3}' title='Three digits from 000 to 255' maxlength='3' size='3'></td>"
                      "<td><input type='text' name='b01' class='tclass1' value='%b01' pattern='[0-9]{3}' title='Three digits from 000 to 255' maxlength='3' size='3'></td>"
		      "<td><input type='text' name='b02' class='tclass1' value='%b02' pattern='[0-9]{3}' title='Three digits from 000 to 255' maxlength='3' size='3'></td>"
		      "<td><input type='text' name='b03' class='tclass1' value='%b03' pattern='[0-9]{3}' title='Three digits from 000 to 255' maxlength='3' size='3'></td></tr>"
  "<tr><td>Gateway</td><td><input type='text' name='b04' class='tclass1' value='%b04' pattern='[0-9]{3}' title='Three digits from 000 to 255' maxlength='3' size='3'></td>"
                      "<td><input type='text' name='b05' class='tclass1' value='%b05' pattern='[0-9]{3}' title='Three digits from 000 to 255' maxlength='3' size='3'></td>"
		      "<td><input type='text' name='b06' class='tclass1' value='%b06' pattern='[0-9]{3}' title='Three digits from 000 to 255' maxlength='3' size='3'></td>"
		      "<td><input type='text' name='b07' class='tclass1' value='%b07' pattern='[0-9]{3}' title='Three digits from 000 to 255' maxlength='3' size='3'></td></tr>"
  "<tr><td>Netmask</td><td><input type='text' name='b08' class='tclass1' value='%b08' pattern='[0-9]{3}' title='Three digits from 000 to 255' maxlength='3' size='3'></td>"
                      "<td><input type='text' name='b09' class='tclass1' value='%b09' pattern='[0-9]{3}' title='Three digits from 000 to 255' maxlength='3' size='3'></td>"
		      "<td><input type='text' name='b10' class='tclass1' value='%b10' pattern='[0-9]{3}' title='Three digits from 000 to 255' maxlength='3' size='3'></td>"
		      "<td><input type='text' name='b11' class='tclass1' value='%b11' pattern='[0-9]{3}' title='Three digits from 000 to 255' maxlength='3' size='3'></td></tr>"
  "<tr><td>Port   </td><td><input type='text' name='c00' class='tclass2' value='%c00' pattern='[0-9]{5}' title='Five digits from 00000 to 65536' maxlength='5' size='5'></td></tr>"
  "</table>"
  "<table border='1px'><colgroup><col width='100px'><col width='30px'><col width='30px'><col width='30px'><col width='30px'><col width='30px'><col width='30px'></colgroup>"
  "<tr><td>MAC Address</td><td><input type='text' name='d00' class='tclass' value='%d00' pattern='[0-9a-f]{2}' title='Two hex digits from 00 to ff' maxlength='2' size='2'></td>"
                          "<td><input type='text' name='d01' class='tclass' value='%d01' pattern='[0-9a-f]{2}' title='Two hex digits from 00 to ff' maxlength='2' size='2'></td>"
                          "<td><input type='text' name='d02' class='tclass' value='%d02' pattern='[0-9a-f]{2}' title='Two hex digits from 00 to ff' maxlength='2' size='2'></td>"
                          "<td><input type='text' name='d03' class='tclass' value='%d03' pattern='[0-9a-f]{2}' title='Two hex digits from 00 to ff' maxlength='2' size='2'></td>"
                          "<td><input type='text' name='d04' class='tclass' value='%d04' pattern='[0-9a-f]{2}' title='Two hex digits from 00 to ff' maxlength='2' size='2'></td>"
                          "<td><input type='text' name='d05' class='tclass' value='%d05' pattern='[0-9a-f]{2}' title='Two hex digits from 00 to ff' maxlength='2' size='2'></td></tr>"
  "</table>"
  "<button type='submit' title='Saves your changes then restarts the Network Module'>Save</button>"
  "<button type='reset' title='Un-does any changes that have not been saved'>Undo All</button>"
  "</form>"
  "<p line-height 20px>"
  "Use caution when changing the above. If you make a mistake you may have to<br>"
  "restore factory defaults by holding down the reset button for 10 seconds.<br><br>"
  "Make sure the MAC you assign is unique to your local network. Recommended<br>"
  "is that you just increment the lowest octet and then label your devices for<br>"
  "future reference.<br><br>"
  "If you change the highest octet of the MAC you MUST use an even number to<br>"
  "form a unicast address. 00, 02, ... fc, fe etc work fine. 01, 03 ... fd, ff are for<br>"
  "multicast and will not work.</p>"
  "<a href='%x00http://192.168.001.004:08080/91'><button title='Save first! This button will not save your changes'>Reboot</button></a>"
  "&nbsp&nbspNOTE: Reboot may cause the relays to cycle.<br><br>"
  "<a href='%x00http://192.168.001.004:08080/60'><button title='Save first! This button will not save your changes'>Relay Controls</button></a>"
#if UIP_STATISTICS == 1
  "<a href='%x00http://192.168.001.004:08080/66'><button title='Save first! This button will not save your changes'>Network Statistics</button></a>"
#endif /* UIP_STATISTICS == 1 */
#if HELP_SUPPORT == 1
  "<a href='%x00http://192.168.001.004:08080/63'><button title='Save first! This button will not save your changes'>Help</button></a>"
#endif /* HELP_SUPPORT == 1 */
  "</body></html>";


#if HELP_SUPPORT == 1
// Help page
#define WEBPAGE_HELP		3
#define PARSEBYTES_HELP		0
static const char g_HtmlPageHelp[] =
  "<!DOCTYPE HTML PUBLIC \"-//W3C//DTD HTML 4.01 Transitional//EN\">"
  "<html><head>"
  "<title>Help Page</title>"
  "<style type='text/css'>"
  "td { width: 140px; padding: 0px; }"
  "</style>"
  "</head><body>"
  "<h1>Help Page 1</h1>"
  "<p line-height 20px>"
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
  "60 = Show Relay Control page<br>"
  "61 = Show Address Settings page<br>"
  "63 = Show Help Page 1<br>"
  "64 = Show Help Page 2<br>"
  "65 = Flash LED<br>"
  "66 = Show Statistics<br>"
  "91 = Reboot<br>"
  "99 = Show Short Form Relay Settings<br>"
  "</p>"
  "<a href='%x00http://192.168.001.004:08080/64'><button title='Go to next Help page'>Next Help Page</button></a>"
  "</body></html>";


// Help page 2
#define WEBPAGE_HELP2		4
#define PARSEBYTES_HELP2	0
static const char g_HtmlPageHelp2[] =
  "<!DOCTYPE HTML PUBLIC \"-//W3C//DTD HTML 4.01 Transitional//EN\">"
  "<html><head>"
  "<title>Help Page</title>"
  "<style type='text/css'>"
  "</style>"
  "</head><body>"
  "<h1>Help Page 2</h1>"
  "<p line-height 20px>"
  "IP Address, Gateway Address, Netmask, Port, and MAC Address can only be<br>"
  "changed via the web interface. If the device becomes inaccessible you can<br>"
  "reset to factory defaults by holding the reset button down for 10 seconds.<br>"
  "Defaults:<br>"
  " IP 192.168.1.4<br>"
  " Gateway 192.168.1.1<br>"
  " Netmask 255.255.255.0<br>"
  " Port 08080<br>"
  " MAC c2-4d-69-6b-65-00<br><br>"
  "Code Revision 20200617 1113</p>"
  "<a href='%x00http://192.168.001.004:08080/60'><button title='Go to Relay Control Page'>Relay Controls</button></a>"
  "</body></html>";

#endif /* HELP_SUPPORT == 1 */


#if UIP_STATISTICS == 1
// Statistics page
#define WEBPAGE_STATS		5
static const char g_HtmlPageStats[] =
  "<!DOCTYPE HTML PUBLIC \"-//W3C//DTD HTML 4.01 Transitional//EN\">"
  "<html><head>"
  "<title>Statistics</title>"
  "<style type='text/css'>"
  ".tclass { width: 450px; }"
  "</style>"
  "</head><body>"
  "<h1>Network Statistics</h1>"
  "<p>Values shown are since last power on or reset</p>"
  "<table border='1px'><colgroup><col width='100px'><col width='450px'></colgroup>"
  "<tr><td>%e00xxxxxxxxxx</td><td class='tclass'>Dropped packets at the IP layer</td></tr>"
  "<tr><td>%e01xxxxxxxxxx</td><td class='tclass'>Received packets at the IP layer</td></tr>"
  "<tr><td>%e02xxxxxxxxxx</td><td class='tclass'>Sent packets at the IP layer</td></tr>"
  "<tr><td>%e03xxxxxxxxxx</td><td class='tclass'>Packets dropped due to wrong IP version or header length</td></tr>"
  "<tr><td>%e04xxxxxxxxxx</td><td class='tclass'>Packets dropped due to wrong IP length, high byte</td></tr>"
  "<tr><td>%e05xxxxxxxxxx</td><td class='tclass'>Packets dropped due to wrong IP length, low byte</td></tr>"
  "<tr><td>%e06xxxxxxxxxx</td><td class='tclass'>Packets dropped since they were IP fragments</td></tr>"
  "<tr><td>%e07xxxxxxxxxx</td><td class='tclass'>Packets dropped due to IP checksum errors</td></tr>"
  "<tr><td>%e08xxxxxxxxxx</td><td class='tclass'>Packets dropped since they were not ICMP or TCP</td></tr>"
  "<tr><td>%e09xxxxxxxxxx</td><td class='tclass'>Dropped ICMP packets</td></tr>"
  "<tr><td>%e10xxxxxxxxxx</td><td class='tclass'>Received ICMP packets</td></tr>"
  "<tr><td>%e11xxxxxxxxxx</td><td class='tclass'>Sent ICMP packets</td></tr>"
  "<tr><td>%e12xxxxxxxxxx</td><td class='tclass'>ICMP packets with a wrong type</td></tr>"
  "<tr><td>%e13xxxxxxxxxx</td><td class='tclass'>Dropped TCP segments</td></tr>"
  "<tr><td>%e14xxxxxxxxxx</td><td class='tclass'>Received TCP segments</td></tr>"
  "<tr><td>%e15xxxxxxxxxx</td><td class='tclass'>Sent TCP segments</td></tr>"
  "<tr><td>%e16xxxxxxxxxx</td><td class='tclass'>TCP segments with a bad checksum</td></tr>"
  "<tr><td>%e17xxxxxxxxxx</td><td class='tclass'>TCP segments with a bad ACK number</td></tr>"
  "<tr><td>%e18xxxxxxxxxx</td><td class='tclass'>Received TCP RST (reset) segments</td></tr>"
  "<tr><td>%e19xxxxxxxxxx</td><td class='tclass'>Retransmitted TCP segments</td></tr>"
  "<tr><td>%e20xxxxxxxxxx</td><td class='tclass'>Dropped SYNs due to too few connections avaliable</td></tr>"
  "<tr><td>%e21xxxxxxxxxx</td><td class='tclass'>SYNs for closed ports, triggering a RST</td></tr>"
  "</table>"
  "<a href='%x00http://192.168.001.004:08080/60'><button title='Go to Relay Control Page'>Relay Controls</button></a>"
  "</body></html>";
  
#endif /* UIP_STATISTICS == 1 */


// Shortened relay state page
// Mimics original Network Module relay state report
#define WEBPAGE_RSTATE		6
static const char g_HtmlPageRstate[] =
  "<!DOCTYPE HTML PUBLIC \"-//W3C//DTD HTML 4.01 Transitional//EN\">"
  "<html><head>"
  "<style type='text/css'>"
  "</style>"
  "</head><body>"
  "<p>%f00xxxxxxxxxxxxxxxx</p>"
  "</body></html>";


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


static uint16_t CopyValue(uint8_t** ppBuffer, uint32_t nValue)
{
// This creates a 5 character "Content-Length:xxxxx" field in the
// pBuffer, and returns a byte count of 5.
//
// The original code created a 10 digit value allowing a transmission
// of up to 999,999,999 bytes. That seems like overkill for this
// application, so this simpler routine allows up to 65536 bytes.

  emb_itoa(nValue, OctetArray, 10, 5);
  
  **ppBuffer = OctetArray[0];
  *ppBuffer = *ppBuffer + 1;
  
  **ppBuffer = OctetArray[1];
  *ppBuffer = *ppBuffer + 1;
  
  **ppBuffer = OctetArray[2];
  *ppBuffer = *ppBuffer + 1;
  
  **ppBuffer = OctetArray[3];
  *ppBuffer = *ppBuffer + 1;
  
  **ppBuffer = OctetArray[4];
  *ppBuffer = *ppBuffer + 1;
  
  return 5;
}


char* emb_itoa(uint32_t num, char* str, uint8_t base, uint8_t pad)
{
  // Implementation of itoa() specific to this application
  // Positive numbers ONLY,
  //   Up to 10 digits (32 bits),
  //   Includes leading 0 pad,
  //   Converts base 2 (binary), 8 (nibbles), 10 (decimal), 16 (hex)

  uint8_t i;
  uint8_t rem;

  // Fill the string with zeroes. This handles the case where the
  // num provided to the routine is zero, and it handles padding
  // as the routine will fill in anything up to the pad length.
  // The value "pad" is effectively the length of the desired
  // output. If number = 0 no further processing needed.
  for (i=0; i < 10; i++) str[i] = '0';
  str[pad] = '\0';
  if (num == 0) return str;
  
  // Process individual digits
  i = 0;
  while (num != 0) {
    rem = (uint8_t)(num % base);
    if(rem > 9) str[i++] = (uint8_t)(rem - 10 + 'a');
    else str[i++] = (uint8_t)(rem + '0');
    num = num/base;
  }

  // Reverse the string
  reverse(str, pad);
  
  return str;
}


// Function to reverse a string
void reverse(char str[], uint8_t length)
{
  uint8_t start;
  uint8_t end;
  uint8_t temp;
  
  start = 0;
  end = (uint8_t)(length - 1);
  
  while (start < end) {
    temp = str[start];
    str[start] = str[end];
    str[end] = temp;
    start++;
    end--;
  }
}


uint8_t three_alpha_to_uint(uint8_t alpha1, uint8_t alpha2, uint8_t alpha3)
{
  // Converts an input comprised of three alpha characters into an output
  // comprised of one uint8_t. Used for converting Decimal Octets (in character
  // form) into an unsigned integer value.

  uint8_t value;
  uint8_t digit;

  value = (uint8_t)((alpha1 - '0') *100);
  digit = (uint8_t)((alpha2 - '0') * 10);
  value = (uint8_t)(value + digit);
  digit = (uint8_t)(alpha3 - '0');
  value = (uint8_t)(value + digit);
  
  if(value >= 255) value = 0;
  
  return value;
}


uint8_t two_alpha_to_uint(uint8_t alpha1, uint8_t alpha2)
{
  // Converts an input comprised of two hex alpha characters into an output
  // comprised of one uint8_t. Used for converting Hex values (in character
  // form) into an unsigned integer value.

  uint8_t value;

  if (alpha1 >= '0' && alpha1 <= '9') value = (uint8_t)((alpha1 - '0') << 4);
  else if(alpha1 == 'a') value = 0xa0;
  else if(alpha1 == 'b') value = 0xb0;
  else if(alpha1 == 'c') value = 0xc0;
  else if(alpha1 == 'd') value = 0xd0;
  else if(alpha1 == 'e') value = 0xe0;
  else if(alpha1 == 'f') value = 0xf0;
  else value = 0; // If an invalid entry is made convert it to 0

  if (alpha2 >= '0' && alpha2 <= '9') value = (uint8_t)(value + alpha2 - '0');
  else if(alpha2 == 'a') value = (uint8_t)(value + 0x0a);
  else if(alpha2 == 'b') value = (uint8_t)(value + 0x0b);
  else if(alpha2 == 'c') value = (uint8_t)(value + 0x0c);
  else if(alpha2 == 'd') value = (uint8_t)(value + 0x0d);
  else if(alpha2 == 'e') value = (uint8_t)(value + 0x0e);
  else if(alpha2 == 'f') value = (uint8_t)(value + 0x0f);
  else value = 0; // If an invalid entry is made convert it to 0

  return value;
}


static uint16_t CopyHttpHeader(uint8_t* pBuffer, uint32_t nDataLen)
{
  uint16_t nBytes;

  nBytes = 0;

  nBytes += CopyStringP(&pBuffer, (const char *)("HTTP/1.1 200 OK"));
  nBytes += CopyStringP(&pBuffer, (const char *)("\r\n"));

  nBytes += CopyStringP(&pBuffer, (const char *)("Content-Length:"));
  nBytes += CopyValue(&pBuffer, nDataLen);
  nBytes += CopyStringP(&pBuffer, (const char *)("\r\n"));

  nBytes += CopyStringP(&pBuffer, (const char *)("Content-Type:text/html\r\n"));
  nBytes += CopyStringP(&pBuffer, (const char *)("Connection:close\r\n"));
  nBytes += CopyStringP(&pBuffer, (const char *)("\r\n"));

  return nBytes;
}


static uint16_t CopyHttpData(uint8_t* pBuffer, const char** ppData, uint16_t* pDataLeft, uint16_t nMaxBytes)
{
  // This routine copies the selected webpage from flash storage to the output buffer.
  // While doing the copy the stream of characters in the webpage source is searched
  // for special markers that indicate where variable data representing pin states or
  // address information should appear in the webpage, and it searches for the input
  // fields that a user would change in webpage forms. When those special characters
  // are found the program inserts the required variables.
    
  uint16_t nBytes;
  uint8_t nByte;
  uint8_t nParsedNum;
  uint8_t nParsedMode;
  uint8_t temp;
  uint8_t i;
  uint8_t advanceptrs;

  nBytes = 0;

  // The input value "nMaxBytes" provided by the calling routine is based on the
  // MSS (Maximum Segment Size). MSS indicates the maximum number of bytes that the
  // receiving browser will accept in a "TCP segment". An initial value is created
  // in the uipopt.h file and is based on the buffer size (why I am not sure but I
  // suppose you have to start with something). Later the MSS is updated with a
  // value obtained from the browser that is accessing the web server during setup
  // of a connection. While specs indicate that in IPV4 the maximum MSS for a
  // connection is 536 bytes, experimentation with the original code shows an MSS
  // of over 900 bytes was being provided in the call to this routine, and that
  // seems to have contributed to istability of the code. Just to be safe, I'm
  // limiting the nMaxBytes to make sure I don't over-run the browser.
  // 
  // I also think the "uip_split" code was interacting with the code below also
  // creating instability, perhaps because a lot of short packets were generated
  // as trasnmissions were carved up. Making the nMaxBytes limit smaller than the
  // uip_split threshold effectively prevented the uip_split from operating, and
  // the code became stable. I subsequently decided to remove the uip_split code
  // from this application.
  //
  // So, the following settings seem to work:
  //   a) #define ENC28J60_MAXFRAME	600 (in enc28j60.h)
  //   b) removed uip_split code
  //   c) if(nMaxBytes > 400) nMaxBytes = 400; (in this file)
  // The exact numbers don't seem to matter so much, but a > c seems required. I
  // beleive the MAXFRAME could be smaller, or the nMaxBytes larger, but
  //   a) nMaxbytes MUST be smaller than MAXFRAME, and I suggest it be at least
  //      50 bytes smaller due to the need to sometimes exceed nMaxBytes in the
  //      code below.
  //   b) nMaxBytes must not cause a packet formation larger than 536 bytes,
  //      including consideration for packet header. I suggest nMaxBytes never
  //      be larger than 450 bytes.
  //
  // Note that complete transmission of the typical webpage in this application
  // is about 2000 bytes.
  if(nMaxBytes > 400) nMaxBytes = 400; // limit just in case

  while (nBytes < nMaxBytes) {
    // This is the main loop for processing the webpages stored in flash and
    // inserting variable data as the webpage is copied to the transmission buffer.
    //
    // The variable nBytes tracks the amount of data written to the transmission
    // buffer.
    // The variable *pDataLeft counts down the amount of data not yet transferred
    // from the source web page to the transmission buffer.
    //
    // There are two ways this loop terminates:
    // 1) If nBytes exceeds nMaxBytes.
    // 2) If *pDataLeft reaches a count of zero.
    // If the loop terminates and there is still data left to transmit (as indicated
    // by pDataLeft > 0) the calling routine will call the routine again.
    //
    // Normally one pass of this loop copies one character from the webpage source
    // to the transmission buffer. However, up to 28 bytes can be copied to the
    // transmission buffer (for instance when the "Next Page" link is processed
    // - see nParseMode "x"). For this reason nBytes might exceed nMaxBytes by up to
    // 28. This is why nMaxBytes is set well below MAXFRAME.
    //
    if (*pDataLeft > 0) {
      // Collect a byte from the source webpage. It will either be written to the
      // transmission buffer as-is, or it (and perhaps characters that follow it)
      // will be processed for replacement in the transmission buffer.
      memcpy(&nByte, *ppData, 1);

      // Search for '%' symbol in data stream. The symbol indicates the start of
      // one of these special fields:
      // %i - Pin state - shows the current state of the GPIO pins. Output only.
      // %o - "ON" radio button to control the state of a GPIO pin. In this
      //      application the GPIO pins are used to control relays. Input and output.
      // %p - "OFF" radio button to control the state of a GPIO pin. In this
      //      application the GPIO pins are used to control relays. Input and output.
      // %a - A user entered text field with a device name. Only used for GUI display
      //      so the user can easily tell what device they are connected to. Input
      //      and output.
      // %b - Address values - in the GUI the user will change these values if they
      //      want to change the IP Address, Gateway Address, or Netmask. Input and
      //      output.
      // %c - Port Number - in the GUI the user will change this value if they want
      //      to change the Port number. Input and output.
      // %d - MAC values - in the GUI the user will change these values if they
      //      want to change the MAC address. Input and output.
      // %e - Statistics display information. Output only.
      // %f - Relays states displayed in simplified form. Output only.
      // %g - "ON" radio button to control the Invert function for GPIO pins
      // %h - "OFF" radio button to control the Invert function for GPIO pins
      // %x - Indicates the start of the http field that identifies the IP Address
      //      and Port Number for the "Next Page". Output only.
      
      if (nByte == '%') {
        *ppData = *ppData + 1;
        *pDataLeft = *pDataLeft - 1;

        // Collect the "nParsedMode" value (the i, o, a, b, c, or d part of the field).
	// This, along with the "nParsedNum" digits that follow, will determine what
	// data is put in the output stream.
        memcpy(&nParsedMode, *ppData, 1);
        *ppData = *ppData + 1;
        *pDataLeft = *pDataLeft - 1;

        // Collect the first digit of the "nParsedNum" which follows the "nParseMode".
	// This is the "tens" digit of the two character nParsedNum.
        memcpy(&temp, *ppData, 1);
	nParsedNum = (uint8_t)((temp - '0') * 10);
        *ppData = *ppData + 1;
        *pDataLeft = *pDataLeft - 1;
	
        // Collect the second digit of the "nParsedNum". This is the "ones" digit.
	// Add it to the "tens" digit to complete the number in integer form.
        memcpy(&temp, *ppData, 1);
	nParsedNum = (uint8_t)(nParsedNum + temp - '0');
        *ppData = *ppData + 1;
        *pDataLeft = *pDataLeft - 1;

        // NOW insert information in the transmit stream based on the nParsedMode
	// and nParsedNum just collected. Anything inserted in the transmit stream
	// is in ascii / UTF-8 form.
	// Note that the data is displayed in two forms. When we parse for 'i' we
	// are displaying the pin state as a green or red square. When we parse for
	// 'o' or 'p' we are displaying radio buttons that indicate the ON/OFF
	// state of the pin. So in all cases GpioGetPin is called to determine the
	// current pin state.
        if (nParsedMode == 'i') {
	  // This is pin state information (1 character)
	  *pBuffer = (uint8_t)(GpioGetPin(nParsedNum) + '0');
          pBuffer++;
          nBytes++;
	}

        else if (nParsedMode == 'o') {
	  // An "ON" radio buttion is displayed and is shown in the checked
	  // state if the pin state is 1.
          if((uint8_t)(GpioGetPin(nParsedNum) == 1)) { // Insert 'checked'
            for(i=0; i<7; i++) {
              *pBuffer = checked[i];
              pBuffer++;
              nBytes++;
            }
          }
          else { // else nothing is inserted
          }
	}
	
        else if (nParsedMode == 'p') {
	  // An "OFF" radio buttion is displayed and is shown in the checked
	  // state if the pin state is 0.
          if((uint8_t)(GpioGetPin(nParsedNum) == 0)) { // Insert 'checked'
            for(i=0; i<7; i++) {
              *pBuffer = checked[i];
              pBuffer++;
              nBytes++;
            }
          }
          else { // else nothing is inserted
          }
	}

        if (nParsedMode == 'a') {
	  // This is device name information (20 character)
	  for(i=0; i<20; i++) {
	    if(ex_stored_devicename[i] != ' ') { // Don't write spaces out - confuses the
	                                         // browser processing of input
              *pBuffer = (uint8_t)(ex_stored_devicename[i]);
              pBuffer++;
              nBytes++;
	    }
	  }
	  // Advance the source pointers past the placeholder in the source data
	  // I'M NOT SURE WHY THIS HELPED. I COULD NOT GET THE WEB PAGES WITH DATA IN THEM
	  // TO WORK UNLESS I HAD PLACEHOLDER POSITIONS IN THE SOURCE. THE POINTERS AND
	  // COUNTERS FOR READING THE SOURCE ARE SEPARATE FROM THE POINTERS AND COUNTERS
	  // FOR WRITING THE OUTPUT STREAM, SO IT SEEMS I SHOULD BE ABLE TO REMOVE ANY
	  // AMOUNT OF CHARACTERS FROM THE SOURCE (AND COUNT THEM), AND WRITE ANY AMOUNT
	  // OF CHARACTERS TO THE OUTPUT STREAM (AND COUNT THEM). BUT FOR SOME REASON
	  // THIS WAS FAILING IF I TOOK SAY 4 CHARACTERS OUT OF THE SOURCE, AND PUT SAY
	  // 10 CHARACTERS IN THE OUTPUT. FOR SOME REASON THE CODE STOPPED PARSING THE
	  // SOURCE EARLY ... OR PERHAPS ALL THE CHARACTERS IN THE OUTPUT STREAM WERE
	  // NOT COUNTED. EVERYTHING SEEMS TO WORK FINE IF I PUT FEWER CHARACTERS IN THE
	  // OUTPUT STREAM THAN I HAD READ FROM THE SOURCE. NEED TO LOOK AT THIS FURTHER.
          *ppData = *ppData + 20;
          *pDataLeft = *pDataLeft - 20;
	}
	
        else if (nParsedMode == 'b') {
	  // This data is the IP Address, Gateway Address, and Netmask information
	  // (3 characters per octet). We need to get a single 8 bit integer from
	  // storage but put it in the transmission buffer as three alpha characters.
	  
	  advanceptrs = 0;
	  
          switch (nParsedNum)
	  {
	    // Convert the value to 3 digit Decimal
	    case 0:  emb_itoa(ex_stored_hostaddr4, OctetArray, 10, 3); advanceptrs = 1; break;
	    case 1:  emb_itoa(ex_stored_hostaddr3, OctetArray, 10, 3); advanceptrs = 1; break;
	    case 2:  emb_itoa(ex_stored_hostaddr2, OctetArray, 10, 3); advanceptrs = 1; break;
	    case 3:  emb_itoa(ex_stored_hostaddr1, OctetArray, 10, 3); advanceptrs = 1; break;
	    case 4:  emb_itoa(ex_stored_draddr4,   OctetArray, 10, 3); advanceptrs = 1; break;
	    case 5:  emb_itoa(ex_stored_draddr3,   OctetArray, 10, 3); advanceptrs = 1; break;
	    case 6:  emb_itoa(ex_stored_draddr2,   OctetArray, 10, 3); advanceptrs = 1; break;
	    case 7:  emb_itoa(ex_stored_draddr1,   OctetArray, 10, 3); advanceptrs = 1; break;
	    case 8:  emb_itoa(ex_stored_netmask4,  OctetArray, 10, 3); advanceptrs = 1; break;
	    case 9:  emb_itoa(ex_stored_netmask3,  OctetArray, 10, 3); advanceptrs = 1; break;
	    case 10: emb_itoa(ex_stored_netmask2,  OctetArray, 10, 3); advanceptrs = 1; break;
	    case 11: emb_itoa(ex_stored_netmask1,  OctetArray, 10, 3); advanceptrs = 1; break;
	    default: emb_itoa(0,                   OctetArray, 10, 3); advanceptrs = 1; break;
	  }
	  
	  if(advanceptrs == 1) { // Copy OctetArray and advance pointers if one of the above
	                         // occurred
            *pBuffer = (uint8_t)OctetArray[0];
            pBuffer++;
            nBytes++;

            *pBuffer = (uint8_t)OctetArray[1];
            pBuffer++;
            nBytes++;
	    
            *pBuffer = (uint8_t)OctetArray[2];
            pBuffer++;
            nBytes++;
	  }
	}

        else if (nParsedMode == 'c') {
	  // This is the Port number (5 characters). We need to get a single 16 bit
	  // integer from storage but put it in the transmission buffer as five alpha
	  // characters.
	    
	  // Write the 5 digit Port value
          emb_itoa(ex_stored_port, OctetArray, 10, 5);
	    
	  for(i=0; i<5; i++) {
            *pBuffer = (uint8_t)OctetArray[i];
            pBuffer++;
            nBytes++;
	  }
        }

        else if (nParsedMode == 'd') {
	  // This is the new MAC adddress information (2 characters). We need to get
	  // a single integer from storage but put it in the output stream as a character
	  // representation of the data. For instance, the integer 0xfe needs to be sent
	  // to the user display as characters "f" and "e".
	  if(nParsedNum == 0)      emb_itoa(uip_ethaddr1, OctetArray, 16, 2);
	  else if(nParsedNum == 1) emb_itoa(uip_ethaddr2, OctetArray, 16, 2);
	  else if(nParsedNum == 2) emb_itoa(uip_ethaddr3, OctetArray, 16, 2);
	  else if(nParsedNum == 3) emb_itoa(uip_ethaddr4, OctetArray, 16, 2);
	  else if(nParsedNum == 4) emb_itoa(uip_ethaddr5, OctetArray, 16, 2);
	  else if(nParsedNum == 5) emb_itoa(uip_ethaddr6, OctetArray, 16, 2);
	  
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
	  // uip_stat.ip.drop;      // Number of dropped packets at the IP layer.
	  // uip_stat.ip.recv;      // Number of received packets at the IP layer.
	  // uip_stat.ip.sent;      // Number of sent packets at the IP layer.
	  // uip_stat.ip.vhlerr;    // Number of packets dropped due to wrong IP version or header length.
	  // uip_stat.ip.hblenerr;  // Number of packets dropped due to wrong IP length, high byte.
	  // uip_stat.ip.lblenerr;  // Number of packets dropped due to wrong IP length, low byte.
	  // uip_stat.ip.fragerr;   // Number of packets dropped since they were IP fragments.
	  // uip_stat.ip.chkerr;    // Number of packets dropped due to IP checksum errors.
	  // uip_stat.ip.protoerr;  // Number of packets dropped since they were neither ICMP, UDP nor TCP.
	  // uip_stat.icmp.drop;    // Number of dropped ICMP packets.
	  // uip_stat.icmp.recv;    // Number of received ICMP packets.
	  // uip_stat.icmp.sent;    // Number of sent ICMP packets.
	  // uip_stat.icmp.typeerr; // Number of ICMP packets with a wrong type.
	  // uip_stat.tcp.drop;     // Number of dropped TCP segments.
	  // uip_stat.tcp.recv;     // Number of received TCP segments.
	  // uip_stat.tcp.sent;     // Number of sent TCP segments.
	  // uip_stat.tcp.chkerr;   // Number of TCP segments with a bad checksum.
	  // uip_stat.tcp.ackerr;   // Number of TCP segments with a bad ACK number.
	  // uip_stat.tcp.rst;      // Number of received TCP RST (reset) segments.
	  // uip_stat.tcp.rexmit;   // Number of retransmitted TCP segments.
	  // uip_stat.tcp.syndrop;  // Number of dropped SYNs due to too few connections avaliable.
	  // uip_stat.tcp.synrst;   // Number of SYNs for closed ports, triggering a RST.
	  
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
	    default: emb_itoa(0,                     OctetArray, 10, 10); break;
	  }

	  for (i=0; i<10; i++) {
            *pBuffer = OctetArray[i];
            pBuffer++;
            nBytes++;
	  }
	  
	  // Advance the source pointers past the placeholder in the source data
	  // SEE NOTE ABOVE WITH SIMILAR ADVANCE SOURCE POINTERS CODE
          *ppData = *ppData + 10;
          *pDataLeft = *pDataLeft - 10;
	}
	
#endif /* UIP_STATISTICS == 1 */

        else if (nParsedMode == 'f') {
	  // Outputs the pin state information in the format used by the "99" command
	  // of the original Network Module.
	  for(i=0; i<16; i++) {
	    *pBuffer = (uint8_t)(GpioGetPin(i) + '0');
            pBuffer++;
            nBytes++;
          }
	  // Advance the source pointers past the placeholder in the source data
	  // SEE NOTE ABOVE WITH SIMILAR ADVANCE SOURCE POINTERS CODE
          *ppData = *ppData + 16;
          *pDataLeft = *pDataLeft - 16;
	}

        else if (nParsedMode == 'g') {
	  // An "ON" radio buttion is displayed and is shown in the checked
	  // state if the GPIO Invert state is 1. There is only 1 'g' ID so
	  // we don't need to check the nParsedNum.
	  if (invert_output == 1) {  // Insert 'checked'
            for(i=0; i<7; i++) {
              *pBuffer = checked[i];
              pBuffer++;
              nBytes++;
            }
	  }
	}
	
        else if (nParsedMode == 'h') {
	  // An "OFF" radio buttion is displayed and is shown in the checked
	  // state if the GPIO Invert state is 0. There is only 1 'g' ID so
	  // we don't need to check the nParsedNum.
          // Insert 'checked'
	  if (invert_output == 0) {  // Insert 'checked'
            for(i=0; i<7; i++) {
              *pBuffer = checked[i];
              pBuffer++;
              nBytes++;
            }
	  }
	}

        else if (nParsedMode == 'x') {
	  // This is the http field containing the "Next Page" link. It is always in the
	  // form "http://192.168.001.004:08080/60". This routine will output the
	  // "192.168.001.004:08080" text with the appropriate IP Address and Port text
	  // stored in the ex_stored_hostaddr1 to ex_stored_hostaddr4 variables and in
	  // the ex_stored_port variable
	  // The data stored in the variables is in numeric form. The data needs to be
	  // converted to text for to write it out with the webpage.
	  
	  // First output the "http://" part of the data
          *pBuffer = 'h'; pBuffer++; nBytes++;
          *pBuffer = 't'; pBuffer++; nBytes++;
          *pBuffer = 't'; pBuffer++; nBytes++;
          *pBuffer = 'p'; pBuffer++; nBytes++;
          *pBuffer = ':'; pBuffer++; nBytes++;
          *pBuffer = '/'; pBuffer++; nBytes++;
          *pBuffer = '/'; pBuffer++; nBytes++;
	    
	  // Now output the IP Address octets. Each is first converted to 3 digit Decimal
          // First IP Address Octet
          emb_itoa(ex_stored_hostaddr4,  OctetArray, 10, 3);
	  // Don't send leading zeros
	  if (OctetArray[0] != '0') {
	    *pBuffer = OctetArray[0]; pBuffer++; nBytes++;
	  }
	  if (OctetArray[0] != '0') {
            *pBuffer = OctetArray[1]; pBuffer++; nBytes++;
	  }
	  else if (OctetArray[1] != '0') {
            *pBuffer = OctetArray[1]; pBuffer++; nBytes++;
	  }
          *pBuffer = OctetArray[2]; pBuffer++; nBytes++;
	  
          *pBuffer = '.'; pBuffer++; nBytes++; // Output '.'
	  
          // Second IP Address Octet
          emb_itoa(ex_stored_hostaddr3,  OctetArray, 10, 3);
	  // Don't send leading zeros
	  if (OctetArray[0] != '0') {
	    *pBuffer = OctetArray[0]; pBuffer++; nBytes++;
	  }
	  if (OctetArray[0] != '0') {
            *pBuffer = OctetArray[1]; pBuffer++; nBytes++;
	  }
	  else if (OctetArray[1] != '0') {
            *pBuffer = OctetArray[1]; pBuffer++; nBytes++;
	  }
          *pBuffer = OctetArray[2]; pBuffer++; nBytes++;
	  
          *pBuffer = '.'; pBuffer++; nBytes++; // Output '.'
	  
          // Third IP Address Octet
          emb_itoa(ex_stored_hostaddr2,  OctetArray, 10, 3);
	  // Don't send leading zeros
	  if (OctetArray[0] != '0') {
	    *pBuffer = OctetArray[0]; pBuffer++; nBytes++;
	  }
	  if (OctetArray[0] != '0') {
            *pBuffer = OctetArray[1]; pBuffer++; nBytes++;
	  }
	  else if (OctetArray[1] != '0') {
            *pBuffer = OctetArray[1]; pBuffer++; nBytes++;
	  }
          *pBuffer = OctetArray[2]; pBuffer++; nBytes++;
	  
          *pBuffer = '.'; pBuffer++; nBytes++; // Output '.'
	  
          // Fourth IP Address Octet
          emb_itoa(ex_stored_hostaddr1,  OctetArray, 10, 3);
	  // Don't send leading zeros
	  if (OctetArray[0] != '0') {
	    *pBuffer = OctetArray[0]; pBuffer++; nBytes++;
	  }
	  if (OctetArray[0] != '0') {
            *pBuffer = OctetArray[1]; pBuffer++; nBytes++;
	  }
	  else if (OctetArray[1] != '0') {
            *pBuffer = OctetArray[1]; pBuffer++; nBytes++;
	  }
          *pBuffer = OctetArray[2]; pBuffer++; nBytes++;
	  
          *pBuffer = ':'; pBuffer++; nBytes++; // Output ':'
  
	  emb_itoa(ex_stored_port, OctetArray, 10, 5); // Now output the Port number
	  for(i=0; i<5; i++) { *pBuffer = OctetArray[i]; pBuffer++; nBytes++; }
	  
	  // Advance the source pointers past the placeholder in the source data
	  // SEE NOTE ABOVE WITH SIMILAR ADVANCE SOURCE POINTERS CODE
          *ppData = *ppData + 28;
          *pDataLeft = *pDataLeft - 28;
	}
      }
      else {
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
  current_webpage = WEBPAGE_DEFAULT;
}


void HttpDCall(	uint8_t* pBuffer, uint16_t nBytes, struct tHttpD* pSocket)
{
  uint16_t nBufSize;
  uint8_t alpha_1;
  uint8_t alpha_2;
  uint8_t alpha_3;
  uint8_t alpha_4;
  uint8_t alpha_5;
  uint8_t i;
  uint8_t amp_found;

  alpha_1 = '0';
  alpha_2 = '0';
  alpha_3 = '0';
  alpha_4 = '0';
  alpha_5 = '0';

  if(uip_connected()) {
    //Initialize this connection
    if(current_webpage == WEBPAGE_DEFAULT) {
      pSocket->pData = g_HtmlPageDefault;
      pSocket->nDataLeft = sizeof(g_HtmlPageDefault)-1;
      // nDataLeft extracted above is used when we get around to calling CopyHttpData
      // in state STATE_SENDDATA
    }
    else if(current_webpage == WEBPAGE_ADDRESS) {
      pSocket->pData = g_HtmlPageAddress;
      pSocket->nDataLeft = sizeof(g_HtmlPageAddress)-1;
    }

#if HELP_SUPPORT == 1
    else if(current_webpage == WEBPAGE_HELP) {
      pSocket->pData = g_HtmlPageHelp;
      pSocket->nDataLeft = sizeof(g_HtmlPageHelp)-1;
    }
    else if(current_webpage == WEBPAGE_HELP2) {
      pSocket->pData = g_HtmlPageHelp2;
      pSocket->nDataLeft = sizeof(g_HtmlPageHelp2)-1;
    }
#endif /* HELP_SUPPORT == 1 */

#if UIP_STATISTICS == 1
    else if(current_webpage == WEBPAGE_STATS) {
      pSocket->pData = g_HtmlPageStats;
      pSocket->nDataLeft = sizeof(g_HtmlPageStats)-1;
    }
#endif /* UIP_STATISTICS == 1 */
    else if(current_webpage == WEBPAGE_RSTATE) {
      pSocket->pData = g_HtmlPageRstate;
      pSocket->nDataLeft = sizeof(g_HtmlPageRstate)-1;
    }
    pSocket->nNewlines = 0;
    pSocket->nState = STATE_CONNECTED;
    pSocket->nPrevBytes = 0xFFFF;
  }
  else if (uip_newdata() || uip_acked()) {
    if (pSocket->nState == STATE_CONNECTED) {
      if (nBytes == 0) return;
      if (*pBuffer == 'G') pSocket->nState = STATE_GET_G;
      else if (*pBuffer == 'P') pSocket->nState = STATE_POST_P;
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
      while (nBytes != 0) {
        if (*pBuffer == '\n') {
          pSocket->nNewlines++;
        }
        else if (*pBuffer == '\r') {
        }
        else {
          pSocket->nNewlines = 0;
        }
        pBuffer++;
        nBytes--;
        if (pSocket->nNewlines == 2) {
          //beginning found.
          if (pSocket->nState == STATE_GOTPOST) {
            //Initialize Parsing variables
            if(current_webpage == WEBPAGE_DEFAULT) pSocket->nParseLeft = PARSEBYTES_DEFAULT;
            if(current_webpage == WEBPAGE_ADDRESS) pSocket->nParseLeft = PARSEBYTES_ADDRESS;
            pSocket->ParseState = PARSE_CMD;
            //start parsing
            pSocket->nState = STATE_PARSEPOST;
          }
          break;
        }
      }
    }

    if (pSocket->nState == STATE_GOTGET) {
      //Don't search for \r\n\r\n ... instead parse what we've got
      //Initialize Parsing variables
      pSocket->nParseLeft = 6; // Small parse number since we should have short
                               // filenames
      pSocket->ParseState = PARSE_SLASH1;
      //start parsing
      pSocket->nState = STATE_PARSEGET;
    }
    
    if (pSocket->nState == STATE_PARSEPOST) {
      // This section will parse a POST sent by the user (usually when they
      // click on the "submit" button on a webpage). POST data will consist of
      //  One digit with a ParseCmd
      //  Two digits with a ParseNum indicating the item to be changed
      //  One digit with an equal sign
      //  A variable number of characters with a ParseState indicating the new
      //    value of the item
      //  One digit with a Parse Delimiter (an '&')
      while (nBytes--) {
        if (pSocket->ParseState == PARSE_CMD) {
          pSocket->ParseCmd = *pBuffer;
          pSocket->ParseState = PARSE_NUM10;
	  if (pSocket->nParseLeft > 0) pSocket->nParseLeft--; // Prevent underflow
	  else { pSocket->ParseState = PARSE_DELIM; } // Something out of sync - escape
          pBuffer++;
	  // Check ParseCmd for errors
	  if (pSocket->ParseCmd == 'o' ||
	      pSocket->ParseCmd == 'a' ||
	      pSocket->ParseCmd == 'b' ||
	      pSocket->ParseCmd == 'c' ||
	      pSocket->ParseCmd == 'd' ||
	      pSocket->ParseCmd == 'g') { }
	  else { pSocket->ParseState = PARSE_DELIM; } // Something out of sync - escape
        }
        else if (pSocket->ParseState == PARSE_NUM10) {
          pSocket->ParseNum = (uint8_t)((*pBuffer - '0') * 10);
          pSocket->ParseState = PARSE_NUM1;
	  if (pSocket->nParseLeft > 0) pSocket->nParseLeft--; // Prevent underflow
	  else { pSocket->ParseState = PARSE_DELIM; } // Something out of sync - escape
          pBuffer++;
        }
        else if (pSocket->ParseState == PARSE_NUM1) {
          pSocket->ParseNum += (uint8_t)(*pBuffer - '0');
          pSocket->ParseState = PARSE_EQUAL;
	  if (pSocket->nParseLeft > 0) pSocket->nParseLeft--; // Prevent underflow
	  else { pSocket->ParseState = PARSE_DELIM; } // Something out of sync - escape
          pBuffer++;
        }
        else if (pSocket->ParseState == PARSE_EQUAL) {
          pSocket->ParseState = PARSE_VAL;
	  if (pSocket->nParseLeft > 0) pSocket->nParseLeft--; // Prevent underflow
	  else { pSocket->ParseState = PARSE_DELIM; } // Something out of sync - escape
          pBuffer++;
        }
        else if (pSocket->ParseState == PARSE_VAL) {
	  // 'o' is submit data for the Relay Controls
	  // 'a' is submit data for the Device Name
	  // 'b' is submit data for the IP/Gateway/Netmask
	  // 'c' is submit data for the Port number
	  // 'd' is submit data for the MAC
	  // 'g' is submit data for the Invert Relay Control
	  
          if (pSocket->ParseCmd == 'o') {
            // This code sets the new Pin state on a pin when user commanded via
            // a radio button in the GUI. It also updates the Set pin field for display.
            if ((uint8_t)(*pBuffer) == '1') GpioSetPin(pSocket->ParseNum, (uint8_t)1);
            else GpioSetPin(pSocket->ParseNum, (uint8_t)0);
	    if (pSocket->nParseLeft > 0) pSocket->nParseLeft--; // Prevent underflow
            pBuffer++;
          }
	  
          else if (pSocket->ParseCmd == 'a') {
            // This code updates the Device Name field. ParseNum isn't used as
	    // this is the only 'a' value. However, this is a special case in
	    // that the return values can consist of anything from 1 to 20
	    // characters. So, we will have to parse until the delimiter '&'
	    // is found.
	    // We don't call a routine to do the Device Name update - we simply
	    // update the ex_stored_devicename variable.
            
            // We know the first byte is always present. Collect it.
            ex_stored_devicename[0] = (uint8_t)(*pBuffer);
            pSocket->nParseLeft--;
            pBuffer++; // nBytes already decremented for first char
	    
	    // Now collect characters until 20 are found or until '&' is found.
	    // Once the '&' is found fill with spaces.
	    amp_found = 0;
	    for(i=1; i<20; i++) {
	      if((uint8_t)(*pBuffer) == 38) amp_found = 1;
	      if(amp_found == 0) {
	        // Collect a character of the Device Name
                ex_stored_devicename[i] = (uint8_t)(*pBuffer);
                pSocket->nParseLeft--;
                pBuffer++;
                nBytes--; // Must subtract 1 from nBytes for extra byte read
	      }
	      else {
	        // Fill remainder of the Device Name with spaces.
	        ex_stored_devicename[i] = ' ';
                // We have to reduce nParseLeft here because it is based on
		// PARESEBYTES_DEFAULT which assumes 20 bytes for the devicename.
		// If the submitted devicename is less than 20 bytes then nParseLeft
		// is too big by the number of characters left out of the devicename
		// and must be corrected here. Note that nBytes is not decremented
		// and the pBuffer pointer is not advanced because nothing is read
		// from the buffer. When we exit the loop the buffer pointer is left
		// pointing at the '&' which starts the next field.
                pSocket->nParseLeft--;
	      }
	    }
	  }
	  
          else if (pSocket->ParseCmd == 'b') {
            // This code updates the "pending" IP address, Gateway address, and
	    // Netmask which will then cause the main.c routines to force a
	    // device reset.
	    // The value following the 'bxx=' ParseCmd and ParseNum consists of three
	    // alpha digits for the IP, Gateway, and Netmask values. This code passes
	    // the digits to the SetAddress routine.
	    alpha_1 = '-';
	    alpha_2 = '-';
	    alpha_3 = '-';
	    
            alpha_1 = (uint8_t)(*pBuffer);
            pSocket->nParseLeft--;
            pBuffer++; // nBytes already decremented for first char
	    
	    alpha_2 = (uint8_t)(*pBuffer);
            pSocket->nParseLeft--;
            pBuffer++;
	    nBytes--; // Must subtract 1 from nBytes for extra byte read
	    
	    alpha_3 = (uint8_t)(*pBuffer);
            pSocket->nParseLeft--;
            pBuffer++;
	    nBytes--; // Must subtract 1 from nBytes for extra byte read
	    
	    SetAddresses(pSocket->ParseNum, (uint8_t)alpha_1, (uint8_t)alpha_2, (uint8_t)alpha_3);
	  }
	  
          else if (pSocket->ParseCmd == 'c') {
            // This code updates the "pending" Port number which will then cause
	    // the main.c routines to force a device reset. ParseNum isn't used
	    // as this is the only 'c' values.
	    // The value following the 'cxx=' ParseCmd & ParseNum consists of five alpha
	    // digits. This code passes the digits to the SetPort routine.
	    alpha_1 = '-';
	    alpha_2 = '-';
	    alpha_3 = '-';
	    alpha_4 = '-';
	    alpha_5 = '-';
	  
	    // Parsing the Port value
  	    alpha_1 = (uint8_t)(*pBuffer);
            pSocket->nParseLeft--;
            pBuffer++; // nBytes already decremented for first char
	      
	    alpha_2 = (uint8_t)(*pBuffer);
            pSocket->nParseLeft--;
            pBuffer++;
	    nBytes--; // Must subtract 1 from nBytes for extra byte read
	      
	    alpha_3 = (uint8_t)(*pBuffer);
            pSocket->nParseLeft--;
            pBuffer++;
	    nBytes--; // Must subtract 1 from nBytes for extra byte read
	      
	    alpha_4 = (uint8_t)(*pBuffer);
            pSocket->nParseLeft--;
            pBuffer++;
	    nBytes--; // Must subtract 1 from nBytes for extra byte read

            alpha_5 = (uint8_t)(*pBuffer);
            pSocket->nParseLeft--;
            pBuffer++;
	    nBytes--; // Must subtract 1 from nBytes for extra byte read
	    
	    SetPort(pSocket->ParseNum,
	            (uint8_t)alpha_1,
		    (uint8_t)alpha_2,
		    (uint8_t)alpha_3,
		    (uint8_t)alpha_4,
		    (uint8_t)alpha_5);
	  }
	  
          else if (pSocket->ParseCmd == 'd') {
            // This code updates the MAC address which will then cause the main.c
	    // routines to force a device reset.
	    // The value following the 'dxx=' ParseCmd and ParseNum consists of two
	    // alpha digits in hex form ('0' to '9' and 'a' to 'f'). This code passes
	    // the digits to the SetMAC routine.
	    alpha_1 = (uint8_t)(*pBuffer);
            pSocket->nParseLeft--;
            pBuffer++; // nBytes already decremented for first char
	      
	    alpha_2 = (uint8_t)(*pBuffer);
            pSocket->nParseLeft--;
            pBuffer++;
	    nBytes--; // Must subtract 1 from nBytes for extra byte read
	    
	    SetMAC(pSocket->ParseNum, alpha_1, alpha_2);
	  }
	  
	  else if (pSocket->ParseCmd == 'g') {
            // This code sets the GPIO Invert state when user commanded via a radio
	    // button in the GUI. ParseNum is not used.
            if ((uint8_t)(*pBuffer) == '1') invert_output = 1;
            else invert_output = 0;
	    if (pSocket->nParseLeft > 0) pSocket->nParseLeft--;
	    else { }
            pBuffer++;
          }
	  
          pSocket->ParseState = PARSE_DELIM;
        }
	
        else if (pSocket->ParseState == PARSE_DELIM) {
          if(pSocket->nParseLeft > 0) {
            pSocket->ParseState = PARSE_CMD;
            pSocket->nParseLeft--;
            pBuffer++;
	  }
	  else {
            pSocket->nParseLeft = 0; // Something out of sync - end the parsing
	  }
        }

        if (pSocket->nParseLeft == 0) {
          //finished parsing
          pSocket->nState = STATE_SENDHEADER;
          break;
        }
      }
      // Default exit (say if nBytes == 0) is to enter STATE_SENDHEADER
      pSocket->nState = STATE_SENDHEADER;
    }

    if (pSocket->nState == STATE_PARSEGET) {
      // This section will parse a GET request sent by the user. Normally in a general
      // purpose web server a GET request would be used to obtain files or other items
      // from the server. In that general case the data that follows "GET " is a
      // "/path/filename" (path optional). In this application we'll use "filename" to
      // command the web server to perform internal operations. For instance, performing
      // a GET for "file 42" with a "/42" might turn a relay on, or might command
      // transmission of a new web page.
      //
      // At this point the "GET " (GET plus space) part of the request has been parsed.
      // The "GET " should be followed by "/filename". So we look for the "/" and collect
      // the next two characters as the fake "filename".

      while (nBytes--) {
        if (pSocket->ParseState == PARSE_SLASH1) {
	  // When we entered the loop *pBuffer should already be pointing at the "/". If
	  // there isn't one we should display the default page.
          pSocket->ParseCmd = *pBuffer;
          pSocket->nParseLeft--;
          pBuffer++;
	  if (pSocket->ParseCmd == (uint8_t)0x2f) { // Compare to '/'
	    pSocket->ParseState = PARSE_NUM10;
	  }
	  if (pSocket->nParseLeft == 0) {
            // Didn't find '/' - break and send default page
	    current_webpage = WEBPAGE_DEFAULT;
            pSocket->pData = g_HtmlPageDefault;
            pSocket->nDataLeft = sizeof(g_HtmlPageDefault)-1;
            pSocket->nNewlines = 0;
            pSocket->nState = STATE_SENDHEADER;
            pSocket->nPrevBytes = 0xFFFF;
            break;
	  }
        }
        else if (pSocket->ParseState == PARSE_NUM10) {
	  // It's possible we got here because the user did not request a filename (ie, the user
	  // entered "192.168.1.4:8080" or "192.168.1.4:8080/". In this case there will be a
	  // space here instead of a digit, and we should just break out of the loop and send
	  // the default page.
	  if(*pBuffer == ' ') {
	    current_webpage = WEBPAGE_DEFAULT;
            pSocket->pData = g_HtmlPageDefault;
            pSocket->nDataLeft = sizeof(g_HtmlPageDefault)-1;
            pSocket->nNewlines = 0;
            pSocket->nState = STATE_SENDHEADER;
            pSocket->nPrevBytes = 0xFFFF;
	    break;
	  }
	  // Parse first ParseNum digit
	  if (*pBuffer >= '0' && *pBuffer <= '9') { }    // Check for errors - if a digit we're good
	  else { pSocket->ParseState = PARSE_DELIM; }    // Something out of sync - escape
          if (pSocket->ParseState == PARSE_NUM10) {      // Still good - parse number
            pSocket->ParseNum = (uint8_t)((*pBuffer - '0') * 10);
	    pSocket->ParseState = PARSE_NUM1;
            pSocket->nParseLeft--;
            pBuffer++;
	  }
        }
	// Parse second ParseNum digit
        else if (pSocket->ParseState == PARSE_NUM1) {
	  if (*pBuffer >= '0' && *pBuffer <= '9') { }    // Check for errors - if a digit we're good
	  else { pSocket->ParseState = PARSE_DELIM; }    // Something out of sync - escape
          if (pSocket->ParseState == PARSE_NUM1) {       // Still good - parse number
            pSocket->ParseNum += (uint8_t)(*pBuffer - '0');
            pSocket->ParseState = PARSE_VAL;
            pSocket->nParseLeft--;
            pBuffer++;
	  }
	}
        else if (pSocket->ParseState == PARSE_VAL) {
	  // ParseNum should now contain a two digit "filename". The filename is used to
	  // command specific action by the webserver. Following are the commands for the
	  // Network Module.
	  //
	  // For 00-31, 55, and 56 you won’t see any screen updates unless you are already
	  // on the Relay Control page or the Short Form Relay States page of the webserver.
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
	  // http://IP/60  Show Relay Control page
	  // http://IP/61  Show Address Settings page
	  // http://IP/63  Show Help page
	  // http://IP/64  Show Help2 page
	  // http://IP/65  Flash LED 3 times
	  // http://IP/66  Show Statistics page
	  // http://IP/91  Reboot
	  // http://IP/99  Show Short Form Relay States page
	  //
          switch(pSocket->ParseNum)
	  {
	    case 0:  Relays_8to1 &= (uint8_t)(~0x01);  break; // Relay-01 OFF
	    case 1:  Relays_8to1 |= (uint8_t)0x01;     break; // Relay-01 ON
	    case 2:  Relays_8to1 &= (uint8_t)(~0x02);  break; // Relay-02 OFF
	    case 3:  Relays_8to1 |= (uint8_t)0x02;     break; // Relay-02 ON
	    case 4:  Relays_8to1 &= (uint8_t)(~0x04);  break; // Relay-03 OFF
	    case 5:  Relays_8to1 |= (uint8_t)0x04;     break; // Relay-03 ON
	    case 6:  Relays_8to1 &= (uint8_t)(~0x08);  break; // Relay-04 OFF
	    case 7:  Relays_8to1 |= (uint8_t)0x08;     break; // Relay-04 ON
	    case 8:  Relays_8to1 &= (uint8_t)(~0x10);  break; // Relay-05 OFF
	    case 9:  Relays_8to1 |= (uint8_t)0x10;     break; // Relay-05 ON
	    case 10: Relays_8to1 &= (uint8_t)(~0x20);  break; // Relay-06 OFF
	    case 11: Relays_8to1 |= (uint8_t)0x20;     break; // Relay-06 ON
	    case 12: Relays_8to1 &= (uint8_t)(~0x40);  break; // Relay-07 OFF
	    case 13: Relays_8to1 |= (uint8_t)0x40;     break; // Relay-07 ON
	    case 14: Relays_8to1 &= (uint8_t)(~0x80);  break; // Relay-08 OFF
	    case 15: Relays_8to1 |= (uint8_t)0x80;     break; // Relay-08 ON
	    case 16: Relays_16to9 &= (uint8_t)(~0x01); break; // Relay-09 OFF
	    case 17: Relays_16to9 |= (uint8_t)0x01;    break; // Relay-09 ON
	    case 18: Relays_16to9 &= (uint8_t)(~0x02); break; // Relay-10 OFF
	    case 19: Relays_16to9 |= (uint8_t)0x02;    break; // Relay-10 ON
	    case 20: Relays_16to9 &= (uint8_t)(~0x04); break; // Relay-11 OFF
	    case 21: Relays_16to9 |= (uint8_t)0x04;    break; // Relay-11 ON
	    case 22: Relays_16to9 &= (uint8_t)(~0x08); break; // Relay-12 OFF
	    case 23: Relays_16to9 |= (uint8_t)0x08;    break; // Relay-12 ON
	    case 24: Relays_16to9 &= (uint8_t)(~0x10); break; // Relay-13 OFF
	    case 25: Relays_16to9 |= (uint8_t)0x10;    break; // Relay-13 ON
	    case 26: Relays_16to9 &= (uint8_t)(~0x20); break; // Relay-14 OFF
	    case 27: Relays_16to9 |= (uint8_t)0x20;    break; // Relay-14 ON
	    case 28: Relays_16to9 &= (uint8_t)(~0x40); break; // Relay-15 OFF
	    case 29: Relays_16to9 |= (uint8_t)0x40;    break; // Relay-15 ON
	    case 30: Relays_16to9 &= (uint8_t)(~0x80); break; // Relay-16 OFF
	    case 31: Relays_16to9 |= (uint8_t)0x80;    break; // Relay-16 ON
	    case 55:
  	      Relays_8to1 = (uint8_t)0xff; // Relays 1-8 ON
  	      Relays_16to9 = (uint8_t)0xff; // Relays 9-16 ON
	      break;
	    case 56:
              Relays_8to1 = (uint8_t)0x00; // Relays 1-8 OFF
              Relays_16to9 = (uint8_t)0x00; // Relays 9-16 OFF
	      break;
	      
	    case 60: // Show relay states page
	      current_webpage = WEBPAGE_DEFAULT;
              pSocket->pData = g_HtmlPageDefault;
              pSocket->nDataLeft = sizeof(g_HtmlPageDefault)-1;
              pSocket->nNewlines = 0;
              pSocket->nState = STATE_CONNECTED;
              pSocket->nPrevBytes = 0xFFFF;
	      break;
	      
	    case 61: // Show address settings page
	      current_webpage = WEBPAGE_ADDRESS;
              pSocket->pData = g_HtmlPageAddress;
              pSocket->nDataLeft = sizeof(g_HtmlPageAddress)-1;
              pSocket->nNewlines = 0;
              pSocket->nState = STATE_CONNECTED;
              pSocket->nPrevBytes = 0xFFFF;
	      break;

#if HELP_SUPPORT == 1
	    case 63: // Show help page 1
	      current_webpage = WEBPAGE_HELP;
              pSocket->pData = g_HtmlPageHelp;
              pSocket->nDataLeft = sizeof(g_HtmlPageHelp)-1;
              pSocket->nNewlines = 0;
              pSocket->nState = STATE_CONNECTED;
              pSocket->nPrevBytes = 0xFFFF;
	      break;
	      
	    case 64: // Show help page 2
	      current_webpage = WEBPAGE_HELP2;
              pSocket->pData = g_HtmlPageHelp2;
              pSocket->nDataLeft = sizeof(g_HtmlPageHelp2)-1;
              pSocket->nNewlines = 0;
              pSocket->nState = STATE_CONNECTED;
              pSocket->nPrevBytes = 0xFFFF;
	      break;
#endif /* HELP_SUPPORT == 1 */

	    case 65: // Flash LED for diagnostics
	      // XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
	      // XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
	      // XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
	      debugflash();
	      debugflash();
	      debugflash();
	      // XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
	      // XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
	      // XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
	      break;

#if UIP_STATISTICS == 1
            case 66: // Show statistics page
	      current_webpage = WEBPAGE_STATS;
              pSocket->pData = g_HtmlPageStats;
              pSocket->nDataLeft = sizeof(g_HtmlPageStats)-1;
              pSocket->nNewlines = 0;
              pSocket->nState = STATE_CONNECTED;
              pSocket->nPrevBytes = 0xFFFF;
	      break;
#endif /* UIP_STATISTICS == 1 */

	    case 91: // Reboot
	      submit_changes = 2;
	      break;
	      
            case 99: // Show simplified relay state page
	      current_webpage = WEBPAGE_RSTATE;
              pSocket->pData = g_HtmlPageRstate;
              pSocket->nDataLeft = sizeof(g_HtmlPageRstate)-1;
              pSocket->nNewlines = 0;
              pSocket->nState = STATE_CONNECTED;
              pSocket->nPrevBytes = 0xFFFF;
	      break;
	      
	    default: // Show relay state page
	      current_webpage = WEBPAGE_DEFAULT;
              pSocket->pData = g_HtmlPageDefault;
              pSocket->nDataLeft = sizeof(g_HtmlPageDefault)-1;
              pSocket->nNewlines = 0;
              pSocket->nState = STATE_CONNECTED;
              pSocket->nPrevBytes = 0xFFFF;
	      break;
	  }
          pSocket->ParseState = PARSE_DELIM;
        }

        else if (pSocket->ParseState == PARSE_DELIM) {
	  // Keep parsing until buffer empty
          pSocket->ParseState = PARSE_DELIM;
          pSocket->nParseLeft--;
          pBuffer++;
	  if (pSocket->nParseLeft == 0) {
            //finished parsing
            pSocket->nState = STATE_SENDHEADER;
            break;
          }
        }
        if (pSocket->nParseLeft == 0) {
          //finished parsing
          pSocket->nState = STATE_SENDHEADER;
          break;
        }
      }
    }

    if (pSocket->nState == STATE_SENDHEADER) {
      uip_send(uip_appdata, CopyHttpHeader(uip_appdata, pSocket->nDataLeft));
      pSocket->nState = STATE_SENDDATA;
      return;
    }

    if (pSocket->nState == STATE_SENDDATA) {
      //We have sent the HTML Header or HTML Data previously.
      //Now we send (further) Data depending on the Socket's pData pointer
      //If all data has been sent, we close the connection
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
      return;
    }
  }
  
  else if (uip_rexmit()) {
    if (pSocket->nPrevBytes == 0xFFFF) {
      /* Send header again */
      uip_send(uip_appdata, CopyHttpHeader(uip_appdata, pSocket->nDataLeft));
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


uint8_t GpioGetPin(uint8_t nGpio)
{
  // Pin value (0 or 1)
  if(nGpio == 0       && (Relays_8to1  & (uint8_t)(0x01))) return 1; // Relay-01 is ON
  else if(nGpio == 1  && (Relays_8to1  & (uint8_t)(0x02))) return 1; // Relay-02 is ON
  else if(nGpio == 2  && (Relays_8to1  & (uint8_t)(0x04))) return 1; // Relay-03 is ON
  else if(nGpio == 3  && (Relays_8to1  & (uint8_t)(0x08))) return 1; // Relay-04 is ON
  else if(nGpio == 4  && (Relays_8to1  & (uint8_t)(0x10))) return 1; // Relay-05 is ON
  else if(nGpio == 5  && (Relays_8to1  & (uint8_t)(0x20))) return 1; // Relay-06 is ON
  else if(nGpio == 6  && (Relays_8to1  & (uint8_t)(0x40))) return 1; // Relay-07 is ON
  else if(nGpio == 7  && (Relays_8to1  & (uint8_t)(0x80))) return 1; // Relay-08 is ON
  else if(nGpio == 8  && (Relays_16to9 & (uint8_t)(0x01))) return 1; // Relay-09 is ON
  else if(nGpio == 9  && (Relays_16to9 & (uint8_t)(0x02))) return 1; // Relay-10 is ON
  else if(nGpio == 10 && (Relays_16to9 & (uint8_t)(0x04))) return 1; // Relay-11 is ON
  else if(nGpio == 11 && (Relays_16to9 & (uint8_t)(0x08))) return 1; // Relay-12 is ON
  else if(nGpio == 12 && (Relays_16to9 & (uint8_t)(0x10))) return 1; // Relay-13 is ON
  else if(nGpio == 13 && (Relays_16to9 & (uint8_t)(0x20))) return 1; // Relay-14 is ON
  else if(nGpio == 14 && (Relays_16to9 & (uint8_t)(0x40))) return 1; // Relay-15 is ON
  else if(nGpio == 15 && (Relays_16to9 & (uint8_t)(0x80))) return 1; // Relay-16 is ON
  return 0;
}


void GpioSetPin(uint8_t nGpio, uint8_t nState)
{
  // Routine will set or clear Relays based on GUI input
  // nState is a digit, not a character

  if(nState != 0 && nState != 1) nState = 1;

  switch(nGpio)
  {
  case 0:
    if(nState == 0) Relays_8to1 &= (uint8_t)(~0x01); // Relay-01 OFF
    else Relays_8to1 |= (uint8_t)0x01; // Relay-01 ON
    break;
  case 1:
    if(nState == 0) Relays_8to1 &= (uint8_t)(~0x02); // Relay-02 OFF
    else Relays_8to1 |= (uint8_t)0x02; // Relay-02 ON
    break;
  case 2:
    if(nState == 0) Relays_8to1 &= (uint8_t)(~0x04); // Relay-03 OFF
    else Relays_8to1 |= (uint8_t)0x04; // Relay-03 ON
    break;
  case 3:
    if(nState == 0) Relays_8to1 &= (uint8_t)(~0x08); // Relay-04 OFF
    else Relays_8to1 |= (uint8_t)0x08; // Relay-04 ON
    break;
  case 4:
    if(nState == 0) Relays_8to1 &= (uint8_t)(~0x10); // Relay-05 OFF
    else Relays_8to1 |= (uint8_t)0x10; // Relay-05 ON
    break;
  case 5:
    if(nState == 0) Relays_8to1 &= (uint8_t)(~0x20); // Relay-06 OFF
    else Relays_8to1 |= (uint8_t)0x20; // Relay-06 ON
    break;
  case 6:
    if(nState == 0) Relays_8to1 &= (uint8_t)(~0x40); // Relay-07 OFF
    else Relays_8to1 |= (uint8_t)0x40; // Relay-07 ON
    break;
  case 7:
    if(nState == 0) Relays_8to1 &= (uint8_t)(~0x80); // Relay-08 OFF
    else Relays_8to1 |= (uint8_t)0x80; // Relay-08 ON
    break;
  case 8:
    if(nState == 0) Relays_16to9 &= (uint8_t)(~0x01); // Relay-09 OFF
    else Relays_16to9 |= (uint8_t)0x01; // Relay-09 ON
    break;
  case 9:
    if(nState == 0) Relays_16to9 &= (uint8_t)(~0x02); // Relay-10 OFF
    else Relays_16to9 |= (uint8_t)0x02; // Relay-10 ON
    break;
  case 10:
    if(nState == 0) Relays_16to9 &= (uint8_t)(~0x04); // Relay-11 OFF
    else Relays_16to9 |= (uint8_t)0x04; // Relay-11 ON
    break;
  case 11:
    if(nState == 0) Relays_16to9 &= (uint8_t)(~0x08); // Relay-12 OFF
    else Relays_16to9 |= (uint8_t)0x08; // Relay-12 ON
    break;
  case 12:
    if(nState == 0) Relays_16to9 &= (uint8_t)(~0x10); // Relay-13 OFF
    else Relays_16to9 |= (uint8_t)0x10; // Relay-13 ON
    break;
  case 13:
    if(nState == 0) Relays_16to9 &= (uint8_t)(~0x20); // Relay-14 OFF
    else Relays_16to9 |= (uint8_t)0x20; // Relay-14 ON
    break;
  case 14:
    if(nState == 0) Relays_16to9 &= (uint8_t)(~0x40); // Relay-15 OFF
    else Relays_16to9 |= (uint8_t)0x40; // Relay-15 ON
    break;
  case 15:
    if(nState == 0) Relays_16to9 &= (uint8_t)(~0x80); // Relay-16 OFF
    else Relays_16to9 |= (uint8_t)0x80; // Relay-16 ON
    break;
  default: break;
  }
}


void SetAddresses(uint8_t itemnum, uint8_t alpha1, uint8_t alpha2, uint8_t alpha3)
{
  // Routine to update the IP address, Gateway address, and NetMask based on
  // GUI input. The routine is called and is passed three alpha fields with
  // decimal alphas ('0' to '9') that represent the new setting.
  // This routine has to construct a single uint8_t numeric representation of
  // the three alpha fields. The routine must validate that the alpha characters
  // passed to it are within valid ranges.
  // alpha1-3 are characters, not a digits

  uint16_t temp;
  unsigned char str[4];
  uint8_t invalid;
  
  temp = 0;
  invalid = 0;
  
  // Create a uint8_t from the three alpha characters. Check validity.
  str[0] = (uint8_t)alpha1;
  str[1] = (uint8_t)alpha2;
  str[2] = (uint8_t)alpha3;
  str[3] = 0;
  temp = atoi(str);
  if (temp > 255) invalid = 1; // If an invalid entry set indicator

  if(invalid == 0) { // Make change only if valid entry
    switch(itemnum)
    {
    case 0:  Pending_hostaddr4 = (uint8_t)temp; break;
    case 1:  Pending_hostaddr3 = (uint8_t)temp; break;
    case 2:  Pending_hostaddr2 = (uint8_t)temp; break;
    case 3:  Pending_hostaddr1 = (uint8_t)temp; break;
    case 4:  Pending_draddr4 = (uint8_t)temp; break;
    case 5:  Pending_draddr3 = (uint8_t)temp; break;
    case 6:  Pending_draddr2 = (uint8_t)temp; break;
    case 7:  Pending_draddr1 = (uint8_t)temp; break;
    case 8:  Pending_netmask4 = (uint8_t)temp; break;
    case 9:  Pending_netmask3 = (uint8_t)temp; break;
    case 10: Pending_netmask2 = (uint8_t)temp; break;
    case 11: Pending_netmask1 = (uint8_t)temp; break;
    default: break;
    }
  }
}


void SetPort(uint8_t itemnum, uint8_t alpha1, uint8_t alpha2, uint8_t alpha3, uint8_t alpha4, uint8_t alpha5)
{
  // Routine to update the Port number based on GUI input.
  // The routine is called and is passed five alpha fields with decimal alphas
  // ('0' to '9') that represent the new setting.
  // This routine has to construct a single uint16_t numeric representation of
  // the five alpha fieldsand must validate that the alpha characters passed
  // to it are within valid ranges.
  // alpha1-5 are characters, not a digits

  uint16_t temp;
  unsigned char str[6];
  uint8_t invalid;
  
  temp = 0;
  invalid = 0;
  
  // Create a uint16_t from alpha1-5. Check validity.
  if(alpha1 > '6') invalid = 1;
  else {
    str[0] = (uint8_t)alpha1;
    str[1] = (uint8_t)alpha2;
    str[2] = (uint8_t)alpha3;
    str[3] = (uint8_t)alpha4;
    str[4] = (uint8_t)alpha5;
    str[5] = 0;
    temp = atoi(str);
  }

  if(invalid == 0) { // Make change only if valid entry
    Pending_port = (uint16_t)temp;
  }
}


void SetMAC(uint8_t itemnum, uint8_t alpha1, uint8_t alpha2)
{
  // This routine updates the MAC based on GUI input.
  // The routine is called and is passed two alpha fields in hex form ('0' to '9'
  // and 'a' to 'f') that represent the new setting. This routine has to construct
  // a single uint8_t numeric representation of the two alpha fields. The routine
  // must validate that the alpha characters passed to it are within valid ranges.
  // alpha1 and alpha2 are characters, not a digits

  uint16_t temp;
  unsigned char str[3];
  uint8_t invalid;
  
  temp = 0;
  invalid = 0;

  // Create a single digit from the two alpha characters. Check validity.
  if (alpha1 >= '0' && alpha1 <= '9') alpha1 = (uint8_t)(alpha1 - '0');
  else if(alpha1 >= 'a' && alpha1 <= 'f') alpha1 = (uint8_t)(alpha1 - 87);
  else invalid = 1; // If an invalid entry set indicator
  
  if (alpha2 >= '0' && alpha2 <= '9') alpha2 = (uint8_t)(alpha2 - '0');
  else if(alpha2 >= 'a' && alpha2 <= 'f') alpha2 = (uint8_t)(alpha2 - 87);
  else invalid = 1; // If an invalid entry set indicator
    
  if (invalid == 0) { // Change value only if valid entry
    temp = (uint8_t)((alpha1<<4) + alpha2); // Convert to single digit
    switch(itemnum)
    {
    case 0: Pending_uip_ethaddr1 = (uint8_t)temp; break;
    case 1: Pending_uip_ethaddr2 = (uint8_t)temp; break;
    case 2: Pending_uip_ethaddr3 = (uint8_t)temp; break;
    case 3: Pending_uip_ethaddr4 = (uint8_t)temp; break;
    case 4: Pending_uip_ethaddr5 = (uint8_t)temp; break;
    case 5: Pending_uip_ethaddr6 = (uint8_t)temp; break;
    default: break;
    }
  }
}
