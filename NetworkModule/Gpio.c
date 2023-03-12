/*
 * GPIO source file
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


// All includes are in main.h
#include "main.h"
 
// extern uint8_t stored_magic4;		// MSB Magic Number stored in EEPROM
// extern uint8_t stored_magic3;		// 
// extern uint8_t stored_magic2;		// 
// extern uint8_t stored_magic1;		// LSB Magic Number
extern uint8_t stored_pin_control[16];  // STM8 per pin control settings
                                        // stored in EEPROM
extern uint8_t stored_options1;         // Additional options stored in EEPROM

// io_map_offset defines the user selected IO pinout map.
// io_map_offset = 0 for the first 16 io_map definitions
// io_map_offset = 16 for the second 16 io_map definitions
// io_map_offset = 32 for the third 16 io_map definitions
// See the manual for explanation
extern int8_t io_map_offset;


// The following enum PORTS, struct io_registers, struct io_mapping, and
// struct io_mapping io_map are used to direct the read_input_pins() and
// write_output_pins() functions to the correct registers and bits for each
// physical pin that is being read or written. This significantly reduces
// the code size for these functions. Credit to Carlos Ladeira for this
// clever implementation. Credit to "peoyli" for the ideas on expanding to
// user selectable alternative pinouts.

// Ccreate a variable with the structure of the port registers and define
// its position on the memory location of the port registers (starting at
// 0x5000). This way we can manipulate this data as an array of ports.
volatile struct io_registers io_reg[ NUM_PORTS ] @0x5000; // Make room for PA .. PG starting at 0x5000

#if PINOUT_OPTION_SUPPORT == 0
// Define the pair PORT:BIT for each of the 16 I/Os
const struct io_mapping io_map[16] = {
	{ PA, 0x08 },    // PA bit3, IO1
	{ PA, 0x20 },    // PA bit5, IO2
	{ PD, 0x40 },    // PD bit6, IO3
	{ PD, 0x10 },    // PD bit4, IO4
	{ PD, 0x04 },    // PD bit2, IO5
	{ PE, 0x01 },    // PE bit0, IO6
	{ PG, 0x02 },    // PG bit1, IO7
	{ PC, 0x80 },    // PC bit7, IO8
	{ PA, 0x10 },    // PA bit4, IO9
	{ PD, 0x80 },    // PD bit7, IO10
	{ PD, 0x20 },    // PD bit5, IO11
	{ PD, 0x08 },    // PD bit3, IO12
	{ PD, 0x01 },    // PD bit0, IO13
	{ PE, 0x08 },    // PE bit3, IO14
	{ PG, 0x01 },    // PG bit0, IO15
	{ PC, 0x40 }     // PC bit6, IO16
};
#endif // PINOUT_OPTION_SUPPORT == 0


#if PINOUT_OPTION_SUPPORT == 1
// Define the pair PORT:BIT for each of the 16 I/Os. Three sets of definition
// are placed in the table. Only one alternative set is used at any given time
// as selected by the user.
// IMPORTANT: The use of alternative pinouts is really only useful in hardware
// configurations that are "relay driver only". An alternative pinout can be
// selected to match the pin definitions of a relay module. This is typically
// needed to match pinouts on 16-relay boards. However, if there is any use of
// "reserved pins" like DS18B20 or the UART the alternative pinout selected by
// the user will be over-riden and the pinout returned to Option 1.
//
// Note: The build map in uipopt.h does not allow a build that has both
// PINOUT_OPTION_SUPPORT and I2C_SUPPORT.

const struct io_mapping io_map[48] = {
        // Pinout Option 1
        // The first 16 definitions are for IO locations that match the
	// silksreen marking on the HW-582 board
	// HW-584 silkscreen
	// 5V 16 15 14 13 12 11 10 09 G
	// 5V 08 07 06 05 04 03 02 01 G
	// IO numbering in the GUI
	// 5V 16 15 14 13 12 11 10 09 G
	// 5V 08 07 06 05 04 03 02 01 G	
	{ PA, 0x08 },    // PA bit3, IO1
	{ PA, 0x20 },    // PA bit5, IO2
	{ PD, 0x40 },    // PD bit6, IO3
	{ PD, 0x10 },    // PD bit4, IO4
	{ PD, 0x04 },    // PD bit2, IO5
	{ PE, 0x01 },    // PE bit0, IO6
	{ PG, 0x02 },    // PG bit1, IO7
	{ PC, 0x80 },    // PC bit7, IO8
	{ PA, 0x10 },    // PA bit4, IO9
	{ PD, 0x80 },    // PD bit7, IO10
	{ PD, 0x20 },    // PD bit5, IO11
	{ PD, 0x08 },    // PD bit3, IO12
	{ PD, 0x01 },    // PD bit0, IO13
	{ PE, 0x08 },    // PE bit3, IO14
	{ PG, 0x01 },    // PG bit0, IO15
	{ PC, 0x40 },    // PC bit6, IO16
        // Pinout Option 2
        // The second 16 definitions are for IO locations that match this
	// table
	// HW-584 silkscreen
	// 5V 16 15 14 13 12 11 10 09 G
	// 5V 08 07 06 05 04 03 02 01 G
	// IO numbering in the GUI
	// 5V 02 04 06 08 10 12 14 16 G
	// 5V 01 03 05 07 09 11 13 15 G
	{ PC, 0x80 },    // PC bit7, IO01
	{ PC, 0x40 },    // PC bit6, IO02
	{ PG, 0x02 },    // PG bit1, IO03
	{ PG, 0x01 },    // PG bit0, IO04
	{ PE, 0x01 },    // PE bit0, IO05
	{ PE, 0x08 },    // PE bit3, IO06
	{ PD, 0x04 },    // PD bit2, IO07
	{ PD, 0x01 },    // PD bit0, IO08
	{ PD, 0x10 },    // PD bit4, IO09
	{ PD, 0x08 },    // PD bit3, IO10
	{ PD, 0x40 },    // PD bit6, IO11
	{ PD, 0x20 },    // PD bit5, IO12
	{ PA, 0x20 },    // PA bit5, IO13
	{ PD, 0x80 },    // PD bit7, IO14
	{ PA, 0x08 },    // PA bit3, IO15
	{ PA, 0x10 },    // PA bit4, IO16
        // Pinout Option 3
        // The third 16 definitions are for IO locations that match this
	// table
	// HW-584 silkscreen
	// 5V 16 15 14 13 12 11 10 09 G
	// 5V 08 07 06 05 04 03 02 01 G
	// IO numbering in the GUI
	// 5V 08 07 06 05 04 03 02 01 G
	// 5V 16 15 14 13 12 11 10 09 G
	{ PA, 0x10 },    // PA bit4, IO01
	{ PD, 0x80 },    // PD bit7, IO02
	{ PD, 0x20 },    // PD bit5, IO03
	{ PD, 0x08 },    // PD bit3, IO04
	{ PD, 0x01 },    // PD bit0, IO05
	{ PE, 0x08 },    // PE bit3, IO06
	{ PG, 0x01 },    // PG bit0, IO07
	{ PC, 0x40 },    // PC bit6, IO08
	{ PA, 0x08 },    // PA bit3, IO09
	{ PA, 0x20 },    // PA bit5, IO10
	{ PD, 0x40 },    // PD bit6, IO11
	{ PD, 0x10 },    // PD bit4, IO12
	{ PD, 0x04 },    // PD bit2, IO13
	{ PE, 0x01 },    // PE bit0, IO14
	{ PG, 0x02 },    // PG bit1, IO15
	{ PC, 0x80 }     // PC bit7, IO16
};
#endif // PINOUT_OPTION_SUPPORT == 1


void gpio_init(void)
{
  uint8_t i;
  uint8_t j;

  // GPIO Definitions for 16 outputs
  //
  // Assumption is that power-on reset has set all GPIO to the default states
  // of the chip hardware (see STM8 manuals).
  //
  // This function will set the GPIO registers to states for this specific
  // application (Network Module).
  //
  // The STM8S is mostly used as a GPIO driver device. Most outputs drive
  // devices such as relays. The SPI interface to the ENC28J60 chip is GPIO
  // "bit bang" driven.
  //
  // Any pins that are "not used" are set as pulled up inputs.




// #if PINOUT_OPTION_SUPPORT == 1
  // Set Pinout Option
  // If an alternate Pinout Option is selected it must be selected before any
  // GPIO settings are applied.
  //
  // (stored_options1 & 0x07) = 1 for the first 16 io_map definitions
  // (stored_options1 & 0x07) = 2 for the second 16 io_map definitions
  // (stored_options1 & 0x07) = 3 for the third 16 io_map definitions
  // io_map_offset defines the user selected IO pinout map.
  // io_map_offset = 0 for the first 16 io_map definitions
  // io_map_offset = 16 for the second 16 io_map definitions
  // io_map_offset = 32 for the third 16 io_map definitions
  // See gpio.c and the manual for explanation
  // Note: Configuration checks in check_runtime_changes() may over-ride this
  // setting.
  {
    uint8_t i;
    uint8_t j;
    i = 0;
#if I2C_SUPPORT == 1
    // If ISC_SUPPORT is enabled then Option 1 must be used. Set a flag.
    i = 1;
#endif I2C_SUPPORT == 1
    j = (uint8_t)(stored_options1 & 0x07);
    if (j > 0 && j < 4 && i == 0) {
      // If stored_options1 is valid update io_map_offset
      io_map_offset = (uint8_t)(((stored_options1 & 0x07) - 1) * 16);
    }
    else {
      // Else use Option 1
      io_map_offset = 0;
      j = (uint8_t)(stored_options1 & 0xf8);
      j |= 0x01;
      unlock_eeprom();
      stored_options1 = j;
      lock_eeprom();
    }
  }
// #endif // PINOUT_OPTION_SUPPORT == 1


  // To reduce the incidence of output pin "chatter" during a reboor (no power
  // loss) the ODR (Output Data Register) for each output pin is pre-written
  // to the ON/OFF state stored in EEPROM. This is done so that the Output pin
  // state is pre-set to the appropriate logic level before the DDR is set up.
  // The reason: If the ODR is still at zero as a default of the reboot and
  // the DDR sets the pin to Output mode, then pin will be driven low. If the
  // ON/OFF state in EEPROM is "ON", then the Output pin will "glitch" low
  // until the proper ON/OFF state can be written in later code.
  //
  // Also note that when the device is rebooted the output pins briefly become
  // floating input pins (effectively tri-state), but when their configura-
  // tions are asserted as outputs this code will make sure the ODR is already
  // set to the previous state of the output. Doing this in the gpio.c func-
  // tion reduces the time that the pins are in a tri-state condition.
  //
  // I AM NOT SURE A MAGIC NUMBER CHECK IS NEEDED HERE. GPIO_INIT() IS RUN
  // AFTER THE CHECK_EEPROM_SETTINGS() FUNCTION, SO THE MAGIC NUMBER WILL
  // ALWAYS BE PRESENT BY THE TIME THE GPIO_INIT() FUNCTION RUNS.
//  if ((stored_magic4 == 0x55) && 
//      (stored_magic3 == 0xee) && 
//      (stored_magic2 == 0x0f) && 
//      (stored_magic1 == 0xf0)) {

    // Create 16bit versions of the pin control information.
    encode_16bit_registers(1);
    
    // Update the output pins
    // The write_output_pins() function uses the io_map table, which is part
    // of the reason that the io_map_offset had to be determine before reach-
    // ing this point in the code.
    write_output_pins(); // Initializes the ODR bits
//  }

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

  // Set the registers CR1 and CR2 of all ports. This loop will set CR1 and
  // CR2 even for ports and pins that are not used, but that will not harm
  // operation in this application.
  for (i=PA; i<NUM_PORTS; i++) {
    io_reg[ i ].cr1 = 0xff;
    io_reg[ i ].cr2 = 0x00;
  }

  // Some of the registers need special config settings
  // PA Bit 2 - Pin 03 - Output PP - LED
  PA_DDR = 0x04;
  
  // PC Bit 3 - Pin 28 - Output PP - ENC28J60 SI (SPI SO)
  // PC Bit 2 - Pin 27 - Output PP - ENC28J60 SCK
  // PC Bit 1 - Pin 26 - Output PP - ENC28J60 -CS
  PC_DDR = 0x0e;
  PC_CR2 = 0x0e;
  
  // PE Bit 5 - Pin 25 - Output PP - ENC28J60 -RESET
  PE_DDR = 0x20;
  PE_CR2 = 0x20;
  

  // All i/o pins defaulted to Inputs. Loop across all i/o's and set the
  // respective bit of the corresponding DDR register to 1 if that i/o is an
  // output.
  for (i=0; i<16; i++) {
    // Determine setting from stored_pin_control byte
#if LINKED_SUPPORT == 0
    if (stored_pin_control[i] & 0x03) {
#endif // LINKED_SUPPORT == 0
#if LINKED_SUPPORT == 1
    if (chk_iotype(stored_pin_control[i], i, 0x03) == 0x03) {
#endif // LINKED_SUPPORT == 1
      // Pin is an Output
      // Set the DDR bit for this i/o in the port DDR register
#if PINOUT_OPTION_SUPPORT == 0
      io_reg[ io_map[i].port ].ddr |= io_map[i].bit;
#endif // PINOUT_OPTION_SUPPORT == 0
#if PINOUT_OPTION_SUPPORT == 1
      j = (int8_t)(i + io_map_offset);
      io_reg[ io_map[j].port ].ddr |= io_map[j].bit;
#endif // PINOUT_OPTION_SUPPORT == 1
   }
  }
}

// *****************************************************
// the previous version is here commented just in case.
// *****************************************************
/*
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
  if ((stored_magic4 == 0x55) && 
      (stored_magic3 == 0xee) && 
      (stored_magic2 == 0x0f) && 
      (stored_magic1 == 0xf0)) {

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
*/

void LEDcontrol(uint8_t state)
{
  // Function to turn the LED on or off
  // state = 1 turns LED on (output high)
  if (state) PA_ODR |= (uint8_t)0x04;
  else PA_ODR &= (uint8_t)(~0x04);
}


