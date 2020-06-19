/*
 * File including all necessary settings regarding the Enc28j60
 * Ethernet Chip.
 * PS: You shouldn't care about Enc28j60's memory settings unless
 * you really know what you are doing.
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



#ifndef ENC28J60_H_
#define ENC28J60_H_

#include <stdint.h>
#include "Spi.h"

/* Physical connection */
#define ENC28J60_DDR		DDRB
#define ENC28J60_PORT		PORTB
#define ENC28J60_INT		PB1
#define ENC28J60_CS		PB2
#define ENC28J60_MOSI		PB3
#define ENC28J60_MISO		PB4
#define ENC28J60_SCK		PB5

/* OnChip Buffer locations
 * Errata Workaround: RX Buffer should start at 0x0000
 * Errata Workaround: RXEND should not be even! */
#define ENC28J60_RXSTART	0x0000	//6kb
#define ENC28J60_RXEND		0x17FF
#define ENC28J60_TXSTART	0x1800	//2kb
#define ENC28J60_TXEND		0x1FFF

/* LED configuration bits:
 * LEDA: Transmit
 * LEDB: Link & receive */
#define ENC28J60_LEDA		1
#define ENC28J60_LEDB		12

/* Maximum frame length in bytes to prevent possible buffer overflows */
// Note for future reference: In the Network Module application user
// inputs on the web pages are reported back to the application via
// POST submittal. The application is fairly naive in processing that
// data in that it expects the entire POST to be available for
// processing at one time. A problem noted during development is that
// some browsers (Firefox in particular) may have larger headers,
// causing the POST to be larger than MAXFRAME. For that reason
// MAXFRAME was increased below to allow the entire POST to be and
// header to be received in the buffer. This may need to be looked at
// more closely in the future as the code shouldn't be dependent on
// having a large MAXFRAME.
#define ENC28J60_MAXFRAME	900

/* Use this for function inlining within the ENC28J60 module */
#define ENC28J60_INLINE		static inline __attribute__ ((always_inline))

/* Initialize Chip (Initialize used SPI module before!) */
void Enc28j60Init(void);

/* Receives an Ethernet-frame. If non available it returns zero
 * This function will never receive more than ENC28J60_MAXFRAME bytes */
uint16_t Enc28j60Receive(uint8_t* pBuffer);

/* Copies a packet into ENC28J60's buffer */
void Enc28j60CopyPacket(uint8_t* pBuffer, uint16_t nBytes);

/* Sends a previously copied ethernet frame */
void Enc28j60Send(void);

/* Use this function to control onchip clock-prescaling
 * provided by the ENC28J60 for using as the host processor's main clock
 * Startup default is ENC28J60's clock divided by 4 (6.25MHz)
 * Valid Prescalers are 1, 2, 3, 4, 8 */
void Enc28j60SetClockPrescaler(uint8_t nPrescaler);

/* Generates a checksum over a given range in ENC28J60's TX buffer
 * using ENC28J60's own checksum generation function. */
uint16_t Enc28j60ChecksumTx(uint16_t Offset, uint16_t Length);

/* Copies data into ENC28J60's TX buffer at Offset */
void Enc28j60CopyChecksum(uint16_t Offset, uint16_t Checksum);

#endif /*ENC28J60_H_*/
