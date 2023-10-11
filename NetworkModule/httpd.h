/*
 * Important defines and function prototypes for the HTTP Daemon Implementation
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


#include <stdint.h>



#ifndef HTTPD_H_
#define HTTPD_H_

#define SEEK_CONTENT_INFO	0
#define SEEK_FIRST_RNRN		1
#define SEEK_SECOND_RNRN	2
#define FOUND_CONTENT_INFO	4

#define UPGRADE_OK				0
#define UPGRADE_FAIL_FILE_READ_CHECKSUM		1
#define UPGRADE_FAIL_EEPROM_MISCOMPARE		2
#define STRING_EEPROM_MISCOMPARE		3
#define UPGRADE_FAIL_NOT_SREC			5
#define UPGRADE_FAIL_INVALID_FILETYPE		6
#define UPGRADE_FAIL_TRUNCATED_FILE		7

#define FILETYPE_SEARCH		0
#define FILETYPE_PROGRAM	1
#define FILETYPE_STRING		2

// These defines locate the webpage content and webpage sizes stored in the
// Strings region of the I2C EEPROM (EEPROM Region 2). In order to allow a
// String File to be read using the same code used for reading Program Files
// the code expects addresses starting at 0x8000, however in the I2C EEPROM
// itself the base address for Strings is 0x0000.

#define MQTT_WEBPAGE_IOCONTROL_ADDRESS_LOCATION				0x0040
#define MQTT_WEBPAGE_CONFIGURATION_ADDRESS_LOCATION			0x0042
#define MQTT_DOMO_WEBPAGE_IOCONTROL_ADDRESS_LOCATION			0x0044
#define MQTT_DOMO_WEBPAGE_CONFIGURATION_ADDRESS_LOCATION		0x0046
#define BROWSER_ONLY_WEBPAGE_IOCONTROL_ADDRESS_LOCATION			0x0048
#define BROWSER_ONLY_WEBPAGE_CONFIGURATION_ADDRESS_LOCATION		0x004a
#define MQTT_WEBPAGE_PCF8574_IOCONTROL_ADDRESS_LOCATION			0x004c
#define MQTT_WEBPAGE_PCF8574_CONFIGURATION_ADDRESS_LOCATION		0x004e
#define BROWSER_ONLY_WEBPAGE_PCF8574_IOCONTROL_ADDRESS_LOCATION		0x0050
#define BROWSER_ONLY_WEBPAGE_PCF8574_CONFIGURATION_ADDRESS_LOCATION	0x0052
#define WEBPAGE_LOADUPLOADER_ADDRESS_LOCATION				0x0054

#define MQTT_WEBPAGE_IOCONTROL_SIZE_LOCATION				0x0080
#define MQTT_WEBPAGE_CONFIGURATION_SIZE_LOCATION			0x0082
#define MQTT_DOMO_WEBPAGE_IOCONTROL_SIZE_LOCATION			0x0084
#define MQTT_DOMO_WEBPAGE_CONFIGURATION_SIZE_LOCATION			0x0086
#define BROWSER_ONLY_WEBPAGE_IOCONTROL_SIZE_LOCATION			0x0088
#define BROWSER_ONLY_WEBPAGE_CONFIGURATION_SIZE_LOCATION		0x008a
#define MQTT_WEBPAGE_PCF8574_IOCONTROL_SIZE_LOCATION			0x008c
#define MQTT_WEBPAGE_PCF8574_CONFIGURATION_SIZE_LOCATION		0x008e
#define BROWSER_ONLY_WEBPAGE_PCF8574_IOCONTROL_SIZE_LOCATION		0x0090
#define BROWSER_ONLY_WEBPAGE_PCF8574_CONFIGURATION_SIZE_LOCATION	0x0092
#define WEBPAGE_LOADUPLOADER_SIZE_LOCATION				0x0094

// The MQTT_WEBPAGE_IOCONTROL webpage is the first webpage string stored in
// I2C EEPROM (EEPROM Region 2) and starts at 0x0100. The .sx file that
// provides the strings to be stored in EEPROM Region 2 has the strings
// start with SREC address 0x8100 rather than 0x0100. This is so that the
// code in httpd.c that uploads Firmware .sx files can be the same code that
// uploads String .sx files. As each string is stored the next string starts
// at the next 128 byte address in EEPROM 2. The current map allows ADDRESS
// and SIZE pointers for 32 strings (32 webpages).
// Note: In addition to the "webpage strings" stored in I2C EEPROM Region 2
// some other variables associated implementation of the PCF8574 IO pin
// expander are also stored in I2C EEPROM Region 2. Those variables define
// the IO Names, IO Timers, and pin_control valies for the PCF8574 IO pins.
// See the main.h file for more information.


struct tHttpD
{
  uint8_t nState;
  const uint8_t* pData;
  uint16_t nDataLeft;
  uint8_t nNewlines;
  uint16_t nParseLeft;
  uint8_t ParseCmd;
  uint8_t ParseNum;
  uint8_t ParseState;
  uint16_t nPrevBytes;
  uint8_t current_webpage;
  uint8_t insertion_index;
  int structID;
  
// nState		Tracks the parsing state of a POST and subsequent
//			response to the Browser
// pData		Pointer to the webpage data to be transmitted
// nDataLeft		Tracks the data remaining to be transmitted from a
//			page pointed to by pData
// nNewlines		Tracks discovery of the \r\n\r\n sequence in a
//			received POST
// nParseLeft		Tracks parsing of POST data
// ParseCmd		Contains the Cmd part of a variable sequence when
//			parsing a POST, and used to store the Mode part of
//			a transmit sequence when bridging a packet sequence
//			when transmitting a webpage.
// ParseNum		Contains the Num parter of a variable sequence when
//			parsing a POST, and used to store the Num part of
//			a transmit sequence when bridging a packet sequence
//			when transmitting a webpage.
// ParseState		Tracks the state of a POST parsing process to allow
//			bridging of TCP Fragmentation.
// nPrevBytes		Used in the case of uip_rexmit to determine if the
//			header needs to be retransmitted.
// current_webpage	Tracks the current webpage being displayed in the GUI.
// insertion_index	Tracks the position in a "long string" being trans-
//			mitted in a webpage to allow bridging of TCP Frag-
//			mentation.
// structID		This was meant to be a temporary debug value to help
//                      sort out when connections were being used. It will be
//                      left in the code for now as it proved to be very
//                      useful.
};


void httpd_diagnostic(void);

void HttpDStringInit(void);
void init_off_board_string_pointers(struct tHttpD* pSocket);
uint16_t read_two_bytes(void);
void read_httpd_diagnostic_bytes(void);
uint16_t adjust_template_size(struct tHttpD* pSocket);

static uint16_t CopyHttpHeader(uint8_t* pBuffer, uint16_t nDataLen, uint8_t header_type);
static uint16_t CopyHttpData(uint8_t* pBuffer,
                             const char** ppData,
			     uint16_t* pDataLeft,
			     uint16_t nMaxBytes,
			     struct tHttpD* pSocket);
void create_sensor_ID(int8_t sensor);
char *show_temperature_string(char * pBuffer, uint8_t nParsedNum);
char *show_BME280_PTH_string(char *pBuffer);
char *show_INA226_CVW_string(char *pBuffer);
void FloatToString(float fVal);
char *show_space_or_minus(int32_t value, char *pBuffer);

void emb_itoa(uint32_t num, char* str, uint8_t base, uint8_t pad);
int hex2int(char ch);
uint8_t two_hex2int(char chmsb, char chlsb);
uint8_t int2nibble(uint8_t j);
void int2hex(uint8_t i);
void int16to4hex(uint16_t i);

void HttpDInit(void);
void init_tHttpD_struct(struct tHttpD* pSocket, int i);
void HttpDCall(uint8_t* pBuffer, uint16_t nBytes, struct tHttpD* pSocket);

char *read_two_characters(char *pBuffer);
void parsepost(struct tHttpD* pSocket, char *pBuffer, uint16_t nBytes);
void parse_local_buf(struct tHttpD* pSocket, char* local_buf, uint16_t lbi_max);
void update_ON_OFF(uint8_t i, uint8_t j);
void parseget(struct tHttpD* pSocket, char *pBuffer);
void parse_command_abort(struct tHttpD* pSocket);

#endif /*HTTPD_H_*/
