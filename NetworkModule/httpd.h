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



#ifndef HTTPD_H_
#define HTTPD_H_

#include <stdint.h>

struct tHttpD
{
  uint8_t nState;
  const uint8_t* pData;
  uint16_t nDataLeft;
  uint8_t nNewlines;
  uint8_t nParseLeft;
  uint8_t nParseLeftAddl;
  uint8_t ParseCmd;
  uint8_t ParseNum;
  uint8_t ParseState;
  uint16_t nPrevBytes;
};


uint16_t adjust_template_size(void);

static uint16_t CopyStringP(uint8_t** ppBuffer, const char* pString);
// static uint16_t CopyHttpHeader(uint8_t* pBuffer, uint16_t nDataLen, uint8_t type);
static uint16_t CopyHttpHeader(uint8_t* pBuffer, uint16_t nDataLen);
static uint16_t CopyHttpData(uint8_t* pBuffer, const char** ppData, uint16_t* pDataLeft, uint16_t nMaxBytes);

void emb_itoa(uint32_t num, char* str, uint8_t base, uint8_t pad);
int hex2int(char ch);
void int2hex(uint8_t i);

void HttpDInit(void);
void HttpDCall(uint8_t* pBuffer, uint16_t nBytes, struct tHttpD* pSocket);
// void parse_POST_string(uint8_t curr_ParseCmd, int num_chars);
void parse_POST_string(uint8_t** pBuffer, uint16_t * nBytes, struct tHttpD* pSocket, uint8_t num_chars);
// void parse_POST_address(uint8_t curr_ParseCmd, uint8_t curr_ParseNum);
void parse_POST_address(uint8_t** pBuffer, uint16_t * nBytes, struct tHttpD* pSocket);
// void parse_POST_port(uint8_t curr_ParseCmd, uint8_t curr_ParseNum);
void parse_POST_port(uint8_t** pBuffer, uint16_t * nBytes, struct tHttpD* pSocket);
// void parse_POST_MAC(uint8_t curr_ParseCmd);
void parse_POST_MAC(uint8_t** pBuffer, uint16_t * nBytes, struct tHttpD* pSocket);

void encode_16bit_registers(void);
void update_pin_control_bytes(void);

uint8_t GpioGetPin(uint8_t nGpio);
void GpioSetPin(uint8_t nGpio, uint8_t nState);
void update_ON_OFF(uint8_t i, uint8_t j);

void clear_saved_postpartial_all(void);
void clear_saved_postpartial_data(void);
void clear_saved_postpartial_previous(void);
void preload_alphas(void);
void check_alphas(void);

#endif /*HTTPD_H_*/
