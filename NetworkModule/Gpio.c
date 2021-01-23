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
#include "main.h"
#include "uipopt.h"

extern uint8_t magic4;			// MSB Magic Number stored in EEPROM
extern uint8_t magic3;			// 
extern uint8_t magic2;			// 
extern uint8_t magic1;			// LSB Magic Number
extern uint8_t stored_pin_control[16];  // Per pin control settings stored in
                                        // EEPROM


void gpio_init(void)
{
  uint8_t temp;

  // GPIO Definitions for 16 outputs
  //
  // Assumption is that power-on reset has set all GPIO to the 
  // default states of the chip hardware (see STM8 manuals).
  //
  // This function will set the GPIO registers to states for this
  // specific application (Network Module). Only the GPIO bits that
  // are attached to pins are manipulated here.
  //
  // The STM8S is mostly used as a GPIO driver device. Most outputs
  // drive devices such as relays. The SPI interface to the ENC28J60
  // chip is GPIO "bit bang" driven.
  //
  // Any pins that are "not used" are set as pulled up inputs.

  // To reduce the incidence of output pin "chatter" during a reboor
  // (no power loss) the ODR (Output Data Register) for each output
  // pin is pre-written to the ON/OFFvstate stored in EEPROM if the
  // Magic Number indicates there is data stored in the EEPROM. When
  // the device is rebooted the output pins briefly become floating
  // input pins (effectively tri-state), but when their configurations
  // are asserted as outputs this code will make sure the ODR is
  // already set to the previous state of the output. Doing this in
  // the gpio.c module reduces the time that the pins are in a
  // tri-state condition.
  if ((magic4 == 0x55) && 
      (magic3 == 0xee) && 
      (magic2 == 0x0f) && 
      (magic1 == 0xf0)) {

    // Create 16bit versions of the pin control information
    encode_16bit_registers();
    
    // Update the output pins
    write_output_pins(); // Initializes the ODR bits
  }

  // Any IO pin can be an input or output as defined in the
  // stored_pin_control bytes (and the associated 16 bit registers).
  // As each IO pin is encountered in the initialization below
  // the stored_pin_control bytes are checked to determine how to
  // set up that pin.

  // Port A
  // Pinout map:
  // Bit 7 - Not attached to pin
  // Bit 6 - Pin 12 - Input  PU - Not used?
  // Bit 5 - Pin 11 - IO 2 control
  // Bit 4 - Pin 10 - IO 9 control
  // Bit 3 - Pin 09 - IO 1 control
  // Bit 2 - Pin 03 - Output PP - LED
  // Bit 1 - Pin 02 - Input  PU - -RstButton
  // Bit 0 - Not attached to pin
  // PA_ODR for output pins has been pre-set by code above. PA_ODR for
  // all other output pins is assumed to be zero from power on or reset
  
  // Determine PA_DDR settings
  temp = 0;
  // PA_DDR = 0; // Initialize to 0 in case this is a restart (not power on)
  // Bit 7 - no change (unused)
  // Bit 6 - no change (defaults to Input)
  // Bit 5 - IO 2 - Determine setting from stored_pin_control byte
  if (stored_pin_control[1] & 0x02) temp |= 0x20; // Set as output, else remains as input
  // Bit 4 - IO 9 - Determine setting from stored_pin_control byte
  if (stored_pin_control[8] & 0x02) temp |= 0x10; // Set as output, else remains as input
  // Bit 3 - IO 1 - Determine setting from stored_pin_control byte
  if (stored_pin_control[0] & 0x02) temp |= 0x08; // Set as output, else remains as input
  // Bit 2 - LED - Set as output
  temp |= 0x04; // Set as output
  // Bit 1 - -RstButton - no change (defaults to Input)
  // Bit 0 - no change (unused)
  PA_DDR = (uint8_t)temp;
  
  // Determine PA_CR1 settings
  // All bits are set to 1 so that:
  //   All output pins are Push-Pull
  //   All input pins are Pull-Up
  PA_CR1 = (uint8_t)0xff;
  
  // Determine PA_CR2 settings
  // All bits are set to 0 so that:
  //   All outputs are 2MHz
  //   All inputs are Interrupt Disabled
  PA_CR2 = (uint8_t)0x00;


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
  // PB_ODR for IO output pins has been pre-set by code above. PB_ODR for
  // all other output pins is assumed to be zero from power on or reset

  // Determine PB_DDR settings
  // All bits are set to 0 so that:
  //   All pins are inputs
  PB_DDR = (uint8_t)0x00;
  
  // Determine PB_CR1 settings
  // All bits are set to 1 so that:
  //   All output pins are Push-Pull
  //   All input pins are Pull-Up
  PB_CR1 = (uint8_t)0xff;
  
  // Determine PB_CR2 settings
  // All bits are set to 0 so that:
  //   All outputs are 2MHz
  //   All inputs are Interrupt Disabled
  PB_CR2 = (uint8_t)0x00;


  // Port C
  // Pinout map:
  // Bit 7 - Pin 34 - Output PP - IO 8 control
  // Bit 6 - Pin 33 - Output PP - IO 16 control
  // Bit 5 - Pin 30 - Input  PU - ENC28J60 -INT
  // Bit 4 - Pin 29 - Input  PU - ENC28J60 SO (SPI SI)
  // Bit 3 - Pin 28 - Output PP - ENC28J60 SI (SPI SO)
  // Bit 2 - Pin 27 - Output PP - ENC28J60 SCK
  // Bit 1 - Pin 26 - Output PP - ENC28J60 -CS
  // Bit 0 - Not attached to pin
  // PC_ODR for IO output pins has been pre-set by code above. PC_ODR for
  // all other output pins is assumed to be zero from power on or reset
  
  // Determine PC_DDR settings
  temp = 0;
  // PC_DDR = 0; // Initialize to 0 in case this is a restart (not power on)
  // Bit 7 - IO 8 - Determine setting from stored_pin_control byte
  if (stored_pin_control[7] & 0x02) temp |= 0x80; // Set as output, else remains as input
  // Bit 6 - IO 16 - Determine setting from stored_pin_control byte
  if (stored_pin_control[15] & 0x02) temp |= 0x40; // Set as output, else remains as input
  // Bit 5 - ENC28J60 -INT - no change, leave as input
  // Bit 4 - ENC28J60 SO (SPI SI) - no change, leave as input
  // Bit 3 - ENC28J60 SI (SPI SO) - set as output
  temp |= 0x08;
  // Bit 2 - ENC28J60 SCK - set as output
  temp |= 0x04;
  // Bit 1 - ENC28J60 -CS - set as output
  temp |= 0x02;
  // Bit 0 - no change (unused)
  PC_DDR = (uint8_t)temp;
			  
  // Determine PB_CR1 settings
  // All bits are set to 1 so that:
  //   All output pins are Push-Pull
  //   All input pins are Pull-Up
  PC_CR1 = (uint8_t)0xff;
			  
  // Determine PC_CR2 settings
  // All bits are set to 0 so that:
  //   Output Pins 33, 34 are 2MHz
  //   All inputs are Interrupt Disabled
  //   Output Pins 26, 27, 28 are 10MHz/Fast Mode
  PC_CR2 = (uint8_t)0x0e;


  // Port D
  // Pinout map:
  // Bit 7 - Pin 48 - IO 10 control
  // Bit 6 - Pin 47 - IO 3 control
  // Bit 5 - Pin 46 - IO 11 control
  // Bit 4 - Pin 45 - IO 4 control
  // Bit 3 - Pin 44 - IO 12 control
  // Bit 2 - Pin 43 - IO 5 control
  // Bit 1 - Pin 42 - Alternate - SWIM
  // Bit 0 - Pin 41 - IO 13 control
  // PD_ODR for IO output pins has been pre-set by code above. PD_ODR for
  // all other output pins is assumed to be zero from power on or reset
  
  // Determine PD_DDR settings
  temp = 0;
  // PD_DDR = 0; // Initialize to 0 in case this is a restart (not power on)
  // Bit 7 - IO 10 - Determine setting from stored_pin_control byte
  if (stored_pin_control[9] & 0x02) temp |= 0x80; // Set as output, else remains as input
  // Bit 6 - IO 3 - Determine setting from stored_pin_control byte
  if (stored_pin_control[2] & 0x02) temp |= 0x40; // Set as output, else remains as input
  // Bit 5 - IO 11 - Determine setting from stored_pin_control byte
  if (stored_pin_control[10] & 0x02) temp |= 0x20; // Set as output, else remains as input
  // Bit 4 - IO 4 - Determine setting from stored_pin_control byte
  if (stored_pin_control[3] & 0x02) temp |= 0x10; // Set as output, else remains as input
  // Bit 3 - IO 12 - Determine setting from stored_pin_control byte
  if (stored_pin_control[11] & 0x02) temp |= 0x08; // Set as output, else remains as input
  // Bit 2 - IO 5 - Determine setting from stored_pin_control byte
  if (stored_pin_control[4] & 0x02) temp |= 0x04; // Set as output, else remains as input
  // Bit 1 - SWIM - no change (not affected by settings)
  // Bit 0 - IO 13 - Determine setting from stored_pin_control byte
  if (stored_pin_control[12] & 0x02) temp |= 0x01; // Set as output, else remains as input
  PD_DDR = (uint8_t)temp;
  
  // Determine PD_CR1 settings
  // All bits are set to 1 so that:
  //   All output pins are Push-Pull
  //   All input pins are Pull-Up
  PD_CR1 = (uint8_t)0xff;
  
  // Determine PD_CR2 settings
  // All bits are set to 0 so that:
  //   All outputs are 2MHz
  //   All inputs are Interrupt Disabled
  PD_CR2 = (uint8_t)0x00;


  // Port E
  // Pinout map:
  // Bit 7 - Pin 23 - Input  PU - Not used?
  // Bit 6 - Pin 24 - Input  PU - Not used?
  // Bit 5 - Pin 25 - Output PP - ENC28J60 -RESET
  // Bit 4 - Not attached to pin
  // Bit 3 - Pin 37 - Output OD - IO 14 control
  // Bit 2 - Pin 38 - Input  PU - Not used?
  // Bit 1 - Pin 39 - Input  PU - Not used?
  // Bit 0 - Pin 40 - Output PP - IO 6 control
  // PE_ODR for IO output pins has been pre-set by code above. PE_ODR for
  // all other output pins is assumed to be zero from power on or reset
  
  // Determine PE_DDR settings
  temp = 0;
  // PE_DDR = 0; // Initialize to 0 in case this is a restart (not power on)
  // Bit 7 - no change (not used)
  // Bit 6 - no change (not used)
  // Bit 5 - ENC28J60 -RESET
  temp |= 0x20; // Set as output
  // Bit 4 - no change (not used)
  // Bit 3 - IO 14 - Determine setting from stored_pin_control byte
  if (stored_pin_control[13] & 0x02) temp |= 0x08; // Set as output, else remains as input
  // Bit 2 - no change (not used)
  // Bit 1 - no change (not used)
  // Bit 0 - IO 6 - Determine setting from stored_pin_control byte
  if (stored_pin_control[5] & 0x02) temp |= 0x01; // Set as output, else remains as input
  PE_DDR = (uint8_t)temp;
			  
  // Determine PE_CR1 settings
  // All bits are set to 1 so that:
  //   All output pins are Push-Pull
  //   All input pins are Pull-Up
  PE_CR1 = (uint8_t)0xff;
  
  // Determine PE_CR2 settings
  // Bits are set so that:
  //   Output Pins 37, 40 are 2MHz
  //   All inputs are Interrupt Disabled
  //   Output Pin 25 is 10MHz/Fast Mode
  PE_CR2 = (uint8_t)0x20;


  // Port F: Not attached to pins


  // Port G:
  // Pinout map:
  // Bit 7 - Not attached to pin
  // Bit 6 - Not attached to pin
  // Bit 5 - Not attached to pin
  // Bit 4 - Not attached to pin
  // Bit 3 - Not attached to pin
  // Bit 2 - Not attached to pin
  // Bit 1 - Pin 36 - Output PP - IO 7 control
  // Bit 0 - Pin 35 - Output PP - IO 15 control
  // PG_ODR for IO output pins has been pre-set by code above. PG_ODR for
  // all other output pins is assumed to be zero from power on or reset
  
  // Determine PG_DDR settings
  temp = 0;
  // PG_DDR = 0; // Initialize to 0 in case this is a restart (not power on)
  // Bit 7 - no change (not used)
  // Bit 6 - no change (not used)
  // Bit 5 - no change (not used)
  // Bit 4 - no change (not used)
  // Bit 3 - no change (not used)
  // Bit 2 - no change (not used)
  // Bit 1 - IO 7 - Determine setting from stored_pin_control byte
  if (stored_pin_control[6] & 0x02) temp |= 0x02; // Set as output, else remains as input
  // Bit 0 - IO 15 - Determine setting from stored_pin_control byte
  if (stored_pin_control[14] & 0x02) temp |= 0x01; // Set as output, else remains as input
  PG_DDR = (uint8_t)temp;
  
  // Determine PG_CR1 settings
  // All bits are set to 1 so that:
  //   All output pins are Push-Pull
  //   All input pins are Pull-Up
  PG_CR1 = (uint8_t)0xff;
			  
  // Determine PG_CR2 settings
  // All bits are set to 0 so that:
  //   All output pins are 2MHz
  //   All inputs are Interrupt Disabled
  PG_CR2 = (uint8_t)0x00;
}


void LEDcontrol(uint8_t state)
{

// XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
// XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
// XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
// XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
// XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
// XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
// temp code until initialization is figured out
//  // Bit 2 - LED - Set as output
 PA_DDR |= 0x04;
 PA_CR1 = (uint8_t)0xff;
 PA_CR2 = (uint8_t)0x00;
// XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
// XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
// XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
// XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
// XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
// XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX

  // state = 1 turns LED on (output high)
  if (state == 1) PA_ODR |= (uint8_t)0x04;
  // state = 0 turns LED off (output low)
  else PA_ODR &= (uint8_t)(~0x04);
}


