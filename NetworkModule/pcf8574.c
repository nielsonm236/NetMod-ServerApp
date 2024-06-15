/**
 * PCF8574 implementation
 */

/* Modifications 2023 Michael Nielson
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
 
 Copyright 2023 Michael Nielson
*/

// All includes are in main.h
#include "main.h"


// PCF8574 Control Bytes
#define I2C_PCF8574_READ		0x71   // 0111 0001
#define I2C_PCF8574_WRITE		0x70   // 0111 0000

#if PCF8574_SUPPORT == 1

extern uint8_t stored_options1;  // Additional options stored in EEPROM

extern uint8_t OctetArray[14];

uint8_t I2C_PCF8574_1_WRITE_CMD; // Used to store the write command for the
                                 // first PCF8574 device found. This value
				 // is initialized to zero, so if it is non-
				 // zero this also serves as a "found"
				 // indicator. If it remains at zero this
				 // indicates no PCF devices were discovered.

void PCF8574_init()
{
  // Search for PCF8574 and PCF8574A devices. Either device type may be on the
  // I2C bus. The following table shows the address maps for both types of
  // devices. The value shown includes the R/W bit, thus the value is actually
  // the Command Byte used to access the device in either the Write mode or
  // the Read mode.
  // PCF8574                     PCF8574A
  // Write Cmd   Read Cmd        Write Cmd   Read Cmd
  // 0x40        0x41            0x70        0x71
  // 0x42        0x43            0x72        0x73
  // 0x44        0x45            0x74        0x75
  // 0x46        0x47            0x76        0x77
  // 0x48        0x49            0x78        0x79
  // 0x4a        0x4b            0x7a        0x7b
  // 0x4c        0x4d            0x7c        0x7d
  // 0x4e        0x4f            0x7e        0x7f
  //
  // The search is performed by attempting a Read from each address starting
  // at 0x41 and ending at 0x7f. As soon as 1 device responds the search will
  // terminate, and the Write Cmd value for that address will be saved in
  // variable I2C_PCF8574_1_WRITE_CMD.
  
  uint8_t found;
  found = 0;
  
  I2C_PCF8574_1_WRITE_CMD = 0x40; // Start search with PCF8574 devices
  while (1) {
    // In this loop the I2C_PCF8574_1_WRITE_CMD is used as the loop control
    // index. The called routines will modify I2C_PCF8574_1_WRITE_CMD into a
    // read command as needed.
    if (PCF8574_response_check() == 0) {
      // Found a device. Terminate the search.
      found = 1;

#if DEBUG_SUPPORT == 15
// UARTPrintf("Found PCF8574 at ");
// emb_itoa(I2C_PCF8574_1_WRITE_CMD, OctetArray, 16, 2);
// UARTPrintf(OctetArray);
// UARTPrintf("\r\n");
#endif // DEBUG_SUPPORT == 15

      break;
    }
    else if (I2C_PCF8574_1_WRITE_CMD == 0x4e) {
      I2C_PCF8574_1_WRITE_CMD = 0x70; // Search for PCF8574A devices
    }
    else if (I2C_PCF8574_1_WRITE_CMD == 0x7e) break;
    else I2C_PCF8574_1_WRITE_CMD += 2;
  }
  if (found == 0) I2C_PCF8574_1_WRITE_CMD = 0x00;


  // Now update the stored_options1 byte if needed.
  {
    uint8_t j;
    j = stored_options1;
    
    if (I2C_PCF8574_1_WRITE_CMD) {
      // A PCF8574 or PCF8574A was found as indicated by a non-zero value in
      // variable I2C_PCF8574_1_WRITE_CMD.
      j |= 0x08; // Enable PCF8574
    }
    else {
      j &= 0xf7; // Disable PCF8574
    }
    
    // Update the stored_options1 byte in EEPROM. Only perform the eeprom
    // write if the value changed.
    update_settings_options(UPDATE_OPTIONS1, j);

#if DEBUG_SUPPORT == 15
    if ((stored_options1 & 0x08) == 0x08) {
      UARTPrintf("\r\n");
      UARTPrintf("PCF8574 found\r\n");
    }
    else {
      UARTPrintf("\r\n");
      UARTPrintf("PCF8574 not found\r\n");
    }
#endif // DEBUG_SUPPORT == 15

  }
}


void PCF8574_write(uint8_t byte)
{
  // Function to write single byte to PCF8574
  I2C_control(I2C_PCF8574_1_WRITE_CMD);
  I2C_write_byte(byte);
  I2C_stop();

#if DEBUG_SUPPORT == 15
// UARTPrintf("Write PCF8574 byte ");
// emb_itoa(byte, OctetArray, 16, 2);
// UARTPrintf(OctetArray);
// UARTPrintf("\r\n");
#endif // DEBUG_SUPPORT == 15

}


uint8_t PCF8574_read()
{
  // Function to read single byte from PCF8574.
  // Note: The PCF8574 spec is a little confusing with regard to data read,
  // in particular the TI spec seems to imply that a double read is required.
  // Other specs to not indicate this. A single byte read appears to work in
  // testing performed. I note this here just in case there are any reports
  // of functional issues.
  uint8_t byte;
  uint8_t read_cmd;
  
  read_cmd = (uint8_t)(I2C_PCF8574_1_WRITE_CMD | 0x01);
  I2C_control(read_cmd);
  byte = I2C_read_byte(1);
//  I2C_stop();
  
  return byte;
}


uint8_t PCF8574_response_check()
{
  // Function to check for presence of PCF8574
  // The function will attempt a read sequence but will return any error code
  // produced by the I2C_control() function call.
  uint8_t error;
  uint8_t read_cmd;

#if DEBUG_SUPPORT == 15
// UARTPrintf("Checking for PCF8574 at ");
// emb_itoa(I2C_PCF8574_1_WRITE_CMD, OctetArray, 16, 2);
// UARTPrintf(OctetArray);
// UARTPrintf("\r\n");
#endif // DEBUG_SUPPORT == 15
  
  read_cmd = (uint8_t)(I2C_PCF8574_1_WRITE_CMD | 0x01);
  error = I2C_control(read_cmd);
  I2C_read_byte(1);
//  I2C_stop();
  
  return error;
}

#endif // PCF8574_SUPPORT == 1
