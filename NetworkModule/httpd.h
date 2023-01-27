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
void read_eight_bytes(void);
uint16_t adjust_template_size(struct tHttpD* pSocket);

static uint16_t CopyHttpHeader(uint8_t* pBuffer, uint16_t nDataLen);
static uint16_t CopyHttpData(uint8_t* pBuffer,
                             const char** ppData,
			     uint16_t* pDataLeft,
			     uint16_t nMaxBytes,
			     struct tHttpD* pSocket);
void create_sensor_ID(int8_t sensor);
char *show_temperature_string(char * pBuffer, uint8_t nParsedNum);
char *show_BME280_PTH_string(char *pBuffer);
char *show_space_or_minus(int32_t value, char *pBuffer);

void emb_itoa(uint32_t num, char* str, uint8_t base, uint8_t pad);
int hex2int(char ch);
uint8_t two_hex2int(char chmsb, char chlsb);
uint8_t int2nibble(uint8_t j);
void int2hex(uint8_t i);
void int16to4hex(uint16_t i);

void HttpDInit(void);
// void init_tHttpD_struct(struct tHttpD* pSocket);
void init_tHttpD_struct(struct tHttpD* pSocket, int i);
void HttpDCall(uint8_t* pBuffer, uint16_t nBytes, struct tHttpD* pSocket);
// char *read_two_characters(struct tHttpD* pSocket, char *pBuffer);
char *read_two_characters(char *pBuffer);
uint16_t parsepost(struct tHttpD* pSocket, char *pBuffer, uint16_t nBytes);
void parse_local_buf(struct tHttpD* pSocket, char* local_buf, uint16_t lbi_max);
void update_ON_OFF(uint8_t i, uint8_t j);

#endif /*HTTPD_H_*/
