/*
 * Source file containing functions and pre-compiler definitions
 * Note that this code module is not optimized on speed!
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



#include "Spi.h"
#include "timer.h"
#include "iostm8s005.h"
#include "stm8s-005.h"


void spi_init(void)
{
  uint8_t i;
  
  // Set specific GPIO pins to initial values for use as SPI bit
  // bang. Hold ENC28J60 in reset until SPI pins are set up.
  
  // The GPIO pins used for SPI bit bang are:
  // Port C
  //   Bit 5 - Pin 30 - Input  - ENC28J60 -INT (not used)
  //   Bit 4 - Pin 29 - Input  - ENC28J60 SO
  //   Bit 3 - Pin 28 - Output - ENC28J60 SI
  //   Bit 2 - Pin 27 - Output - ENC28J60 SCK
  //   Bit 1 - Pin 26 - Output - ENC28J60 -CS
  // Port E
  //   Bit 5 - Pin 25 - Output - ENC28J60 -RESET

  // At initialization time (just after reset) all output bits are 0.
  // Some need to be set to 1. The ENC28J60 should already be held in
  // reset but we will make sure here.
  PC_ODR |= (uint8_t)0x02;    // 0b00000010 SI=0, SCK=0, -CS=1
  PE_ODR &= (uint8_t)(~0x20); // 0b00100000 -RESET=0

  // wait 250ms
  for(i=0; i<5; i++) wait_timer((uint16_t)50000); // wait 250ms
  
  // Release ENC28J60 from reset
  PE_ODR |= (uint8_t)0x20; // 0b00100000 -RESET=1

  // wait 50ms
  wait_timer((uint16_t)50000); // Wait 50ms

  // From this point forward the -RESET output and -INT input should 
  // not be needed.
  // Use the following functions to work with the SPI output pins
  // PC_ODR |= (uint8_t)0x02;    // -CS high
  // PC_ODR &= (uint8_t)(~0x02); // -CS low
  // PC_ODR |= (uint8_t)0x04;    // SCK high
  // PC_ODR &= (uint8_t)(~0x04); // SCK low
  // PC_ODR |= (uint8_t)0x08;    // SPI SO high
  // PC_ODR &= (uint8_t)(~0x08); // SPI SO low
  // SPI Input pin
  // if (PC_IDR & (uint8_t)(~0x10))==1 databit = 1;
  // else databit = 0;
  //
}


void SpiWriteByte(uint8_t nByte)
{
  // nByte is the data to be sent
  // MSB is sent first
  uint8_t bitnum = (uint8_t)0x80;                // Point at MSB
  while(bitnum != 0)
  {
    if (nByte & bitnum) PC_ODR |= (uint8_t)0x08; // If bit is 1 then 
                                                 // SPI SO (ENC28J60 SI) high
    else PC_ODR &= (uint8_t)(~0x08);             // else SPI SO low
    
    nop();
    PC_ODR |= (uint8_t)0x04;                     // SCK high
    nop();
    PC_ODR &= (uint8_t)(~0x04);                  // SCK low

    bitnum = (uint8_t)(bitnum >> 1);             // Shift bitnum right one place
                                                 // Once bitnum has shifted to equal 0
						 // we know all 8 bits have been sent
  }
  PC_ODR &= (uint8_t)(~0x08);                    // SPI SO low on exit
}


void SpiWriteChunk(const uint8_t* pChunk, uint16_t nBytes)
{
  uint8_t bitnum;
  uint8_t OutByte;

  while (nBytes--)
  {
    bitnum = (uint8_t)0x80;                          // Point at MSB
    OutByte = *pChunk++;

    while(bitnum != 0)
    {
      if (OutByte & bitnum) PC_ODR |= (uint8_t)0x08; // If bit is 1 then
                                                     // SPI SO (ENC28J60 SI) high
      else PC_ODR &= (uint8_t)(~0x08);               // else SPI SO low
    
      nop();
      PC_ODR |= (uint8_t)0x04;                       // SCK high
      nop();
      PC_ODR &= (uint8_t)(~0x04);                    // SCK low

      bitnum = (uint8_t)(bitnum >> 1);               // Shift bitnum right one place
                                                     // Once bitnum has shifted to equal 0
                                                     // we know all 8 bits have been sent
    }
  }
  PC_ODR &= (uint8_t)(~0x08);                        // SPI SO low on exit
}


uint8_t SpiReadByte(void)
{
  // Reading a byte works by sending a dummy byte. The ENC28J60 will
  // ignore the dummy byte, and the clocks used to send the dummy byte
  // are used to transfer the read byte.
  // MSB is received first
  uint8_t bitnum = (uint8_t)0x80;                 // Point at MSB
  uint8_t InByte = 0;
  while(bitnum != 0)
  {
    // Read SI and set appropriate bit in InByte
    // Data is already there to be read due to previous command write
    if (PC_IDR & (uint8_t)0x10) InByte |= bitnum; // SPI incoming bit = 1
    else InByte &= (uint8_t)(~bitnum);            // SPI incoming bit = 0
    
    PC_ODR |= (uint8_t)0x04;                      // SCK high
    nop();
    PC_ODR &= (uint8_t)(~0x04);                   // SCK low

    bitnum = (uint8_t)(bitnum >> 1);              // Shift bitnum right one place
                                                  // Once bitnum has shifted to equal 0
						  // we know all 8 bits have been collected
  }
  return InByte;
}


void SpiReadChunk(uint8_t* pChunk, uint16_t nBytes)
{
  // Reading data works by sending dummy bytes. The ENC28J60 will
  // ignore the dummy bytes, and the clocks used to send the dummy bytes
  // are used to collect the read bytes.
  // MSB is received first
  uint8_t bitnum;
  uint8_t InByte;

  PC_ODR &= (uint8_t)(~0x08);                        // SO low

  while (nBytes--)
  {
    bitnum = (uint8_t)0x80;                          // Point at MSB
    InByte = 0;
    while(bitnum != 0)
    {
      // Read SI and set appropriate bit in InByte
      // Data is already there to be read due to previous command write
      // or byte read
      if (PC_IDR & (uint8_t)0x10) InByte |= bitnum;  // SPI incoming bit = 1
      else InByte &= (uint8_t)(~bitnum);             // SPI incoming bit = 0
    
      PC_ODR |= (uint8_t)0x04;                       // SCK high
      nop();
      PC_ODR &= (uint8_t)(~0x04);                    // SCK low

      bitnum = (uint8_t)(bitnum >> 1);               // Shift bitnum right one place
                                                     // Once bitnum has shifted to equal 0
						     // we know all 8 bits have been collected
    }
  *pChunk++ = InByte;                                // Save byte in the buffer
  }
}

