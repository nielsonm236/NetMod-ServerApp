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
  uint8_t ParseCmd;
  uint8_t ParseNum;
  uint8_t ParseState;
  uint16_t nPrevBytes;
};


static uint16_t CopyStringP(uint8_t** ppBuffer, const char* pString);
static uint16_t CopyValue(uint8_t** ppBuffer, uint32_t nValue);
static uint16_t CopyHttpHeader(uint8_t* pBuffer, uint32_t nDataLen);
static uint16_t CopyHttpData(uint8_t* pBuffer, const char** ppData, uint16_t* pDataLeft, uint16_t nMaxBytes);

uint8_t three_alpha_to_uint(uint8_t alpha1, uint8_t alpha2, uint8_t alpha3);
uint8_t two_alpha_to_uint(uint8_t alpha1, uint8_t alpha2);
char* emb_itoa(uint32_t num, char* str, uint8_t base, uint8_t pad);
void reverse(char str[], uint8_t length);

void HttpDInit(void);
void HttpDCall(	uint8_t* pBuffer, uint16_t nBytes, struct tHttpD* pSocket);

int8_t intercept_code(void);
int8_t extract_octets(void);
int8_t extract_mac_digits(void);

uint8_t GpioGetPin(uint8_t nGpio);
void GpioSetPin(uint8_t nGpio, uint8_t nState);

void SetAddresses(uint8_t itemnum, uint8_t alpha1, uint8_t alpha2, uint8_t alpha3);
void SetPort(uint8_t itemnum, uint8_t alpha1, uint8_t alpha2, uint8_t alpha3, uint8_t alpha4, uint8_t alpha5);
void SetMAC(uint8_t nGpio, uint8_t nState1, uint8_t nState2);

#endif /*HTTPD_H_*/
