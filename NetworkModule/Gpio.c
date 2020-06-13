/*
 * GPIO source file
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


 
#include <stdint.h>
#include "iostm8s005.h"
#include "gpio.h"


void gpio_init(void)
{
  // Assumption is that power-on reset has set all GPIO to default
  // states. This routine will set the GPIO registers to states for
  // the specific application (Network Module). Only the GPIO bits
  // that are attached to pins are manipulated here.
  //
  // The STM8S is mostly used as a GPIO driver device. Most outputs
  // drive Relay controls. The SPI interface to the ENC28J60 chip
  // is also GPIO "bit bang" driven.
  //
  // Any pins that are "not used" are set as pulled up inputs.
  
  // Port A
  // Pinout map:
  // Bit 7 - Not attached to pin
  // Bit 6 - Pin 12 - Input  PU - Not used?
  // Bit 5 - Pin 11 - Output OD - Relay 2 control
  // Bit 4 - Pin 10 - Output OD - Relay 9 control
  // Bit 3 - Pin 09 - Output OD - Relay 1 control
  // Bit 2 - Pin 03 - Output PP - LED
  // Bit 1 - Pin 02 - Input  PU - -RstButton
  // Bit 0 - Not attached to pin
  // PA_ODR is assumed to be all zero from power on reset
  PA_DDR = (uint8_t)0x3c; // 0b00111100 Pins 3, 9, 10, 11 are outputs
  PA_CR1 = (uint8_t)0xff; // 0b11111111 Output pins 3, 9, 10, 11 are Push-Pull
			  //            Inputs are Pull-Up
  PA_CR2 = (uint8_t)0x00; // 0b00000000 Outputs are 2MHz, Inputs are Interrupt Disabled
  
  // Port B
  // Pinout map:
  // Bit 7 - Pin 15 - Input  PU - Not used?
  // Bit 6 - Pin 16 - Input  PU - Not used?
  // Bit 5 - Pin 17 - Input  PU - Not used?
  // Bit 4 - Pin 18 - Input  PU - Not used?
  // Bit 3 - Pin 19 - Input  PU - Not used?
  // Bit 2 - Pin 20 - Input  PU - Not used?
  // Bit 1 - Pin 21 - Input  PU - Not used?
  // Bit 0 - Pin 22 - Input  PU - Not used?
  // PB_ODR is assumed to be all zero from power on reset
  PB_DDR = (uint8_t)0x00; // 0b00000000 All pins are inputs
  PB_CR1 = (uint8_t)0xff; // 0b11111111 Inputs are Pull-Up
  
  // Port C
  // Pinout map:
  // Bit 7 - Pin 34 - Output OD - Relay 8 control
  // Bit 6 - Pin 33 - Output OD - Relay 16 control
  // Bit 5 - Pin 30 - Input  PU - ENC28J60 -INT
  // Bit 4 - Pin 29 - Input  PU - ENC28J60 SO (SPI SI)
  // Bit 3 - Pin 28 - Output PP - ENC28J60 SI (SPI SO)
  // Bit 2 - Pin 27 - Output PP - ENC28J60 SCK
  // Bit 1 - Pin 26 - Output PP - ENC28J60 -CS
  // Bit 0 - Not attached to pin
  // PC_ODR is assumed to be all zero from power on reset
  PC_DDR = (uint8_t)0xce; // 0b11001110 Pins 26, 27, 28, 33, 34 are outputs
  PC_CR1 = (uint8_t)0xff; // 0b11111111
                          // Output Pins 26, 27, 28, 33, 34 are Push-Pull
			  // Inputs are Pull-up
  PC_CR2 = (uint8_t)0x0e; // 0b00001110
                          // Output Pins 34, 33 are 2MHz
                          // Output Pins 28, 27, 26 are 10MHz/Fast Mode
			  // Inputs are Interrupt Disabled

  // Port D
  // Pinout map:
  // Bit 7 - Pin 48 - Output OD - Relay 10 control
  // Bit 6 - Pin 47 - Output OD - Relay 3 control
  // Bit 5 - Pin 46 - Output OD - Relay 11 control
  // Bit 4 - Pin 45 - Output OD - Relay 4 control
  // Bit 3 - Pin 44 - Output OD - Relay 12 control
  // Bit 2 - Pin 43 - Output OD - Relay 5 control
  // Bit 1 - Pin 42 - Alternate - SWIM
  // Bit 0 - Pin 41 - Output OD - Relay 13 control
  // PD_ODR is assumed to be all zero from power on reset
  PD_DDR = (uint8_t)0xfd; // 0b11111101 Pins 41, 43, 44, 45, 46, 47, 48 are outputs
                          // Note that the SWIM pin is not affected by these settings
  PD_CR1 = (uint8_t)0xff; // 0b11111111 Output Pins 41, 43, 44, 45, 46, 47, 48 are Push Pull
  PD_CR2 = (uint8_t)0x00; // 0b00000000 Outputs are 2MHz
  
  // Port E
  // Pinout map:
  // Bit 7 - Pin 23 - Input  PU - Not used?
  // Bit 6 - Pin 24 - Input  PU - Not used?
  // Bit 5 - Pin 25 - Output PP - ENC28J60 -RESET
  // Bit 4 - Not attached to pin
  // Bit 3 - Pin 37 - Output OD - Relay 14 control
  // Bit 2 - Pin 38 - Input  PU - Not used?
  // Bit 1 - Pin 39 - Input  PU - Not used?
  // Bit 0 - Pin 40 - Output OD - Relay 6 control
  // PE_ODR is assumed to be all zero from power on reset
  PE_DDR = (uint8_t)0x29; // 0b00101001 Pins 25, 37, 40 are outputs
  PE_CR1 = (uint8_t)0xff; // 0b11111111
                          // Output Pins 25, 37, 40 are Push-Pull
			  // Inputs are Pull-Up
  PE_CR2 = (uint8_t)0x20; // 0b00100000
                          // Output Pin 25 is 10MHz/Fast Mode
			  // Output Pins 37, 40 are 2MHz
			  // Inputs are Interrupt Disabled
  
  // Port F: Not attached to pins

  // Port G:
  // Pinout map:
  // Bit 7 - Not attached to pin
  // Bit 6 - Not attached to pin
  // Bit 5 - Not attached to pin
  // Bit 4 - Not attached to pin
  // Bit 3 - Not attached to pin
  // Bit 2 - Not attached to pin
  // Bit 1 - Pin 36 - Output OD - Relay 7 control
  // Bit 0 - Pin 35 - Output OD - Relay 15 control
  // PG_ODR is assumed to be all zero from power on reset
  PG_DDR = (uint8_t)0x03; // 0b00000011 Pins 35, 36 are outputs
  PG_CR1 = (uint8_t)0xff; // 0b11111111 Outputs are Push Pull
  PG_CR2 = (uint8_t)0x00; // 0b00000000 Outputs are 2MHz
}


void LEDcontrol(uint8_t state)
{
  // state = 1 turns LED on (output high)
  if (state == 1) PA_ODR |= (uint8_t)0x04;
  // state = 0 turns LED off (output low)
  else PA_ODR &= (uint8_t)(~0x04);
}


