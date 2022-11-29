/*
 * UART source file
 */
 
/* 2021 Michael Nielson
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
 
 Copyright 2021 Michael Nielson
*/

#include <stdint.h>
#include <stdlib.h>
#include <string.h>

#include "iostm8s005.h"
#include "stm8s-005.h"
#include "UART.h"
#include "main.h"
#include "timer.h"
#include "uipopt.h"

extern uint8_t pin_control[16];
extern uint8_t stored_pin_control[16];
extern uint8_t Pending_pin_control[16];

//---------------------------------------------------------------------------//
// This function enables the use of the STM8S UART to output characters to a
// terminal.

// The UART operates in asynchronous mode as the synchronous clock pin is
// also the ENC28J60 chip select pin. This cannot be changed.
//
// The UART tx and rx pins require use of the following IO pins:
//   IO 11 (tx)
//   IO 3 (rx) (this is not implemented at this time)
// Because these pins are repurposed while the UART is used the UART function
// is only available as a debug build. When the debug build is generated the
// developer must be careful that these two IO pins do not have any circuitry
// connected that might cause damage to the IO pins. Further, because the
// pins operate at 3v a level converter is needed to connect the pins to
// external RS232 logic levels.
//---------------------------------------------------------------------------//


// Code allows the STM8S to send debug information to a terminal emulator
// running at 9600,n,8,1 or 115200,n,8,1 (see baud rate selection below).
//
// Perform the following tasks:
//   set the parity and number of data bits
//   set the parity
//   set the number of stop bits
//   setup the baud rate
//   set the clock polarity etc.

// The Registers
// It is important to remember that transmission and reception must both be
// disabled before we start to change these registers.
// UART_CR1 – Data Bits and Parity
//   The number of data bits is selected using the M bit of CR1. In this
//     application we will be using 8 data bits so UART_CR1_M is set to 0.
//   In this application parity is disabled so PCEN (Parity Control Enable)
//     is set to 0.
//
// UART_CR3 – Number of Stop Bits and Clock Settings
//   UART_CR3_STOP is set to a value of 00 for 1 stop bit.
//   UART_CR3_CPOL, UART_CR3_CPHA, and UART_CR3_LBCL affect the synchronous
//     clock output. This is not used in this application so these settings
//     do not matter.
//   UART_BRR1 & UART_BRR2 – Baud Rate Registers
//     The baud rate of the UART is controlled by dividing fmaster by the
//     baud rate divisor. The result gives the clock speed of the serial port.
//     In this application we have a 16 MHz clock speed for fmaster.
//
//     The formula for 115200 baud:
//     UART Divider = fmaster / baud rate
//                  = 16,000,000 / 115,200
//                  = 138
//                  = 0x008a
//     It is an odd implementation, but the BRR2 register must be set with
//     the Most Significant Nibble or the Divider and the Least Significant
//     nibble of the Devider. The BRR1 register must be set with the middle
//     two nibbles of the Divider.
//     Example:
//     Think of the Divider value as four nibbles represented by d3d2d1d0,
//     and the Divider value is 0x008a.
//     Set up the registers as follows:
//       BRR1 = d2d1
//            = 0x08
//       BRR2 = d3d0
//            = 0x0a
//       When writing these registers it is important to remember to set
//       BRR2 before setting BRR1.
//
// 
//     For 9600 baud
//     UART Divider = fmaster / baud rate
//                  = 16,000,000 / 9600
//                  = 1666
//                  = 0x0682
//     Set up the registers as follows:
//       BRR1 = d2d1
//            = 0x68
//       BRR2 = d3d0
//            = 0x02
//
//   UART_CR2 & UART_CR3 – Enabling the UART
//       UART_CR2_TEN    Enable/disable transmission
//       UART_CR2_REN    Enable/disable reception (disabled at this time)
//       UART_CR3_CKEN   Enable/disable the clock (always disabled in this
//                       application.
//
// Setup the UART to run at 115200 baud, no parity, one stop bit, 8 data bits.
// Important: This relies upon the system clock being set to run at 16 MHz.
//
#if DEBUG_SUPPORT == 7 || DEBUG_SUPPORT == 15
void InitializeUART(void)
{
  unsigned char tmp;

  // The following code forces IO 11 to a Disabled state so that the UART
  // code can operate the IO 11 pin for UART transmit to a terminal.
  pin_control[10] = Pending_pin_control[10] = (uint8_t)0x00; // Disable
  // Update the stored_pin_control[] variables
  unlock_eeprom();
  if (stored_pin_control[10] != pin_control[10]) stored_pin_control[10] = pin_control[10];
  lock_eeprom();
  // For UART mode Port D Bit 5 needs to be set to Output / Push-Pull /
  // 10MHz slope
  PD_ODR |= 0x20; // Set Output data to 1
  PD_DDR |= 0x20; // Set Output mode
  PD_CR1 |= 0x20; // Set Push-Pull
  PD_CR2 |= 0x20; // Set 10MHz

  // Clear the Idle Line Detected bit in the status register by a read to the
  // UART2_SR register followed by a Read to the UART2_DR register.
  tmp = UART2_SR;
  tmp = UART2_DR;
  
  //  Reset the UART registers to the reset values.
  UART2_BRR2 = UART2_BRR2_RESET_VALUE;
  UART2_BRR1 = UART2_BRR1_RESET_VALUE;
  UART2_CR1 = UART2_CR1_RESET_VALUE;
  UART2_CR2 = UART2_CR2_RESET_VALUE;
  UART2_CR4 = UART2_CR3_RESET_VALUE;
  UART2_CR3 = UART2_CR4_RESET_VALUE;
  UART2_CR5 = UART2_CR5_RESET_VALUE;

  // All bits for 8 bit data, No Parity, 1 Stop are in the correct state due
  // to the Reset values above. We only need to set the baud rate and enable
  // the Transmitter.

  // Set the baud rate registers to 9600
//  UART2_BRR2 = 0x02;
//  UART2_BRR1 = 0x68;
  // Set the baud rate registers to 115200
  UART2_BRR2 = 0x0a;
  UART2_BRR1 = 0x08;
  
  // Set the Transmitter Enable bit
  UART2_CR2 |= (uint8_t)UART2_CR2_TEN;
}

// A simple method of sending a string to the serial port.
//   Set a pointer to the start of the string.
//   If the character pointed to is not a null character then Transfer the
//   character into the UART data register.
//   Wait until the data register has been sent (Transmission Empty is true).
//   Move the pointer on one byte.
//
//  Send a message to the debug port (UART2).
//
void UARTPrintf(char *message)
{
  char *ch = message;

  while (*ch) {
    // Put the next character into the data transmission register.
    UART2_DR = (unsigned char) *ch;
    // Wait for transmission to complete.
    while ((UART2_SR & UART2_SR_TXE) == 0);
    ch++;
  }
}
#endif // DEBUG_SUPPORT == 7 || DEBUG_SUPPORT == 15


