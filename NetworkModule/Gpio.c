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
 
extern uint8_t stored_pin_control[16];  // STM8 per pin control settings
                                        // stored in EEPROM
extern uint8_t stored_options1;         // Additional options stored in EEPROM


// The following structs are used to direct the read_input_pins() and
// write_output_pins() functions to the correct registers and bits for each
// physical pin that is being read or written. This significantly reduces
// the code size for these functions. Credit to Carlos Ladeira for this
// clever implementation. Credit to "peoyli" for the ideas on expanding to
// user selectable alternative pinouts.

// Create a variable with the structure of the port registers and define
// its position on the memory location of the port registers (starting at
// 0x5000). This way this data can be manipulated as an array of ports.
// Make room for PA .. PG starting at 0x5000
volatile struct io_registers io_reg[ NUM_PORTS ] @0x5000;


// Define the pair PORT:BIT for each of the 16 I/Os. This is the default
// pairing.
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


void gpio_init(void)
{
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

  // Set Pinout Option
  // If an alternate Pinout Option is selected it must be selected before any
  // GPIO settings are applied.
  //
  // (stored_options1 & 0x07) = 1 for Pinout Option 1
  // (stored_options1 & 0x07) = 2 for Pinout Option 2
  // (stored_options1 & 0x07) = 3 for Pinout Option 3
  // (stored_options1 & 0x07) = 4 for Pinout Option 4
  // See the manual for explanation
  // Note: Configuration checks in check_runtime_changes() may over-ride this
  // setting.
  {
    uint8_t i;
    uint8_t j;
    i = 0;
#if I2C_SUPPORT == 1
    // If I2C_SUPPORT is enabled then Option 1 must be used. Set a flag.
    i = 1;
#endif // I2C_SUPPORT == 1
    j = (uint8_t)(stored_options1 & 0x07);
    if (j > 0 && j < 5 && i == 0) {
      // If stored_options1 is valid do nothing
    }
    else {
      // Else force Option 1
      j = (uint8_t)(stored_options1 & 0xf8);
      j |= 0x01;
      update_settings_options(UPDATE_OPTIONS1, j);
    }
  }

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

  // Create register versions of the pin control information.
  encode_bit_registers(1);
  
  // Update the output pins
  // The write_output_pins() function uses the io_map table, which is the
  // reason that the io_map_offset had to be determined before reaching this
  // point in the code.
  write_output_pins(); // Initializes the ODR bits

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
  // Bit 7 - Pin 34 - IO 8 control
  // Bit 6 - Pin 33 - IO 16 control
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
  // Bit 3 - Pin 37 - IO 14 control
  // Bit 2 - Pin 38 - Input  PU - Not used?
  // Bit 1 - Pin 39 - Input  PU - Not used?
  // Bit 0 - Pin 40 - IO 6 control
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
  // Bit 1 - Pin 36 - IO 7 control
  // Bit 0 - Pin 35 - IO 15 control
  // PG_ODR for IO output pins has been pre-set by code above. PG_ODR for
  // all other output pins is assumed to be zero from power on or reset

  // Set the registers CR1 and CR2 of all ports. This loop will set CR1 and
  // CR2 even for ports and pins that are not used, but that will not harm
  // operation in this application.
  // All pins are set as follows:
  // - If an Output the pin is PP (Push Pull) and Low Speed (2MHz).
  // - If an Input the pin is Input with Pull-up and Interrupt Disabled.
  // - Or may be set differently by the "special config settings" below.
  {
    int i;
    for (i=PA; i<NUM_PORTS; i++) {
      io_reg[ i ].cr1 = 0xff;
      io_reg[ i ].cr2 = 0x00;
    }
  }

  // Some of the registers need special config settings
  // PA Bit 2 - Pin 03 - Output PP - LED
//  PA_DDR = 0x04;
  PA_DDR |= 0x04;
  
  // PC Bit 3 - Pin 28 - Output PP - ENC28J60 SI (SPI SO)
  // PC Bit 2 - Pin 27 - Output PP - ENC28J60 SCK
  // PC Bit 1 - Pin 26 - Output PP - ENC28J60 -CS
//  PC_DDR = 0x0e;
//  PC_CR2 = 0x0e;
  PC_DDR |= 0x0e;
  PC_CR2 |= 0x0e;
  
  // PE Bit 5 - Pin 25 - Output PP - ENC28J60 -RESET
//  PE_DDR = 0x20;
//  PE_CR2 = 0x20;
  PE_DDR |= 0x20;
  PE_CR2 |= 0x20;
  

  // All i/o pins defaulted to Inputs. Loop across all i/o's and set the
  // respective bit of the corresponding DDR register to 1 if that i/o is an
  // output.
  {
    uint8_t i;
    uint8_t j;
    for (i=0; i<16; i++) {
      // Determine setting from stored_pin_control byte

#if LINKED_SUPPORT == 0
      {
        if ((stored_pin_control[i] & 0x03) == 0x03)
        {
          // Pin is an Output
          // Set the DDR bit for this i/o in the port DDR register
#if PINOUT_OPTION_SUPPORT == 0
          {
          io_reg[ io_map[i].port ].ddr |= io_map[i].bit;
          }
#endif // PINOUT_OPTION_SUPPORT == 0

#if PINOUT_OPTION_SUPPORT == 1
          {
          j = calc_PORT_BIT_index(i);
          io_reg[ io_map[j].port ].ddr |= io_map[j].bit;
          }
#endif // PINOUT_OPTION_SUPPORT == 1
        }
      }
#endif // LINKED_SUPPORT == 0

#if LINKED_SUPPORT == 1
      {
        if (chk_iotype(stored_pin_control[i], i, 0x03) == 0x03)
        {
          // Pin is an Output
          // Set the DDR bit for this i/o in the port DDR register
#if PINOUT_OPTION_SUPPORT == 0
          {
            io_reg[ io_map[i].port ].ddr |= io_map[i].bit;
          }
#endif // PINOUT_OPTION_SUPPORT == 0

#if PINOUT_OPTION_SUPPORT == 1
          {
            j = calc_PORT_BIT_index(i);
            io_reg[ io_map[j].port ].ddr |= io_map[j].bit;
          }
#endif // PINOUT_OPTION_SUPPORT == 1
        }
      }
#endif // LINKED_SUPPORT == 1
    }
  }
}


#if PINOUT_OPTION_SUPPORT == 1
uint8_t calc_PORT_BIT_index(uint8_t IO_index)
{
  // Function to determine the index into the array of PORT:BIT pairs for the
  // various pinout options. The function returns the index value.
  //
  // This function only gets called by code included in builds when
  // PINOUT_OPTION_SUPPORT == 1, so the compiler will only include thie
  // function in builds if PINOUT_OPTION_SUPPORT == 1.
  //
  // Explanation:
  // Originally the design had a single array that paired each GUI IO number
  // (1 to 16) to a PORT:BIT pair in hardware. After that a scheme was created
  // to have multiple arrays each with a different pairing of GUI IO numbers
  // to the PORT:BIT pairs in hardware. Multiple arrays were used to allow
  // compatibility with alternative pinouts on relay boards (for instance,
  // Relay 1 on a given relay board design might not match up with IO 1 on the
  // HW-584 board). Each array of PORT:BIT pairs consumed 32 bytes of Flash.
  //
  // This iteration of the design: As more requirements for more arrays of
  // PORT:BIT pairs developed a new scheme was developed. So far, each
  // PORT:BIT pairing follows a pattern that can be described by equations.
  // The equations can reinterpret the PORT:BIT pairing in the original
  // PORT:BIT array so that the correct hardware pin is activated depending on
  // the Pinout Option selected by the user. This is accomplished in this
  // function by running the appropriate set of equations to return an index
  // into the PORT:BIT array based on the Pinout Option and IO number.
  //
  // The resulting index truth table is as follows:
  //
  // GUI IO Numbers
  //  |    IO_index
  //  |    |     Option 1 PORT_BIT_index
  //  |    |     |  Pin
  //  |    |     |  |      Option 2 PORT_BIT_index
  //  |    |     |  |      |  Pin
  //  |    |     |  |      |  |      Option 3 PORT_BIT_index
  //  |    |     |  |      |  |      |  Pin
  //  |    |     |  |      |  |      |  |      Option 4 PORT_BIT_index
  //  |    |     |  |      |  |      |  |      |  Pin
  //  |    |     |  |      |  |      |  |      |  |
  // IO1   0     0  1      7  8      8  9      15 16
  // IO2   1     1  2      15 16     9  10     7  8
  // IO3   2     2  3      6  7      10 11     14 15
  // IO4   3     3  4      14 15     11 12     6  7
  // IO5   4     4  5      5  6      12 13     13 14
  // IO6   5     5  6      13 14     13 14     5  6
  // IO7   6     6  7      4  5      14 15     12 13
  // IO8   7     7  8      12 13     15 16     4  5
  // 
  // IO9   8     8  9      3  4      0  1      11 12
  // IO10  9     9  10     11 12     1  2      3  4
  // IO11  10    10 11     2  3      2  3      10 11
  // IO12  11    11 12     10 11     3  4      2  3
  // IO13  12    12 13     1  2      4  5      9  10
  // IO14  13    13 14     9  10     5  6      1  2
  // IO15  14    14 15     0  1      6  7      8  9
  // IO16  15    15 16     8  9      7  8      0  1

  // Pinout Option 1
  // HW-584 silkscreen
  // HW Silkscreen 5V 16 15 14 13 12 11 10 09 G     5V 08 07 06 05 04 03 02 01 G
  // GUI IO Number    16 15 14 13 12 11 10 09          08 07 06 05 04 03 02 01

  // Pinout Option 2
  // HW Silkscreen 5V 16 15 14 13 12 11 10 09 G     5V 08 07 06 05 04 03 02 01 G
  // GUI IO Number    02 04 06 08 10 12 14 16          01 03 05 07 09 11 13 15

  // Pinout Option 3
  // HW Silkscreen 5V 16 15 14 13 12 11 10 09 G     5V 08 07 06 05 04 03 02 01 G
  // GUI IO Number    08 07 06 05 04 03 02 01          16 15 14 13 12 11 10 09

  // Pinout Option 4
  // HW Silkscreen 5V 16 15 14 13 12 11 10 09 G     5V 08 07 06 05 04 03 02 01 G
  // GUI IO Number    01 03 05 07 09 11 13 15          02 04 06 08 10 12 14 16

  uint8_t PORT_BIT_index;
  uint8_t partial_index1;
  uint8_t pinout_option;
  
  // When calc_PORT_BIT_index() is called IO_index is in the form 0 to 15 (not 1 to 16)
  
  PORT_BIT_index = 0;
  pinout_option = (uint8_t)(stored_options1 & 0x07);

  // The next equations are not used in all Pinout Options but are calculated
  // here for code reduction.
  partial_index1 = (uint8_t)( (uint8_t)~(IO_index) & 0x0f);

  // Pinout Option 4
  if (pinout_option == 4) {
    if ((partial_index1 & 0x01) == 0) PORT_BIT_index = (uint8_t)(partial_index1 >> 1);
    if ((partial_index1 & 0x01) == 1) PORT_BIT_index = (uint8_t)(partial_index1 + ((IO_index + 1) >> 1));
  }

  // Pinout Option 3
  else if (pinout_option == 3) {
    if (IO_index < 8) PORT_BIT_index = (uint8_t)(IO_index + 8);
    if (IO_index > 7) PORT_BIT_index = (uint8_t)(IO_index - 8);
  }

  // Pinout Option 2
  else if (pinout_option == 2) {
    if ((partial_index1 & 0x01) == 0) PORT_BIT_index = (uint8_t)(partial_index1 + ((IO_index + 1) >> 1));
    if ((partial_index1 & 0x01) == 1) PORT_BIT_index = (uint8_t)(partial_index1 >> 1);
  }

  // Else assume Pinout Option 1
  else PORT_BIT_index = (uint8_t)(IO_index);

  return PORT_BIT_index;
}
#endif // PINOUT_OPTION_SUPPORT == 1


void LEDcontrol(uint8_t state)
{
  // Function to turn the LED on or off
  // state = 1 turns LED on (output high)
  if (state) PA_ODR |= (uint8_t)0x04;
  else PA_ODR &= (uint8_t)(~0x04);
}
