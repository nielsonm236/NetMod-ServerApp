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


#ifndef __I2C_H__
#define __I2C_H__


#define I2C_FAIL_NACK_CONTROL_BYTE	1
#define I2C_FAIL_NACK_BYTE_ADDRESS1	2
#define I2C_FAIL_NACK_BYTE_ADDRESS2	3
#define I2C_FAIL_NACK_WRITE_BYTE	4

#define I2C_EEPROM0_READ		0xa1   // 1010 0001
#define I2C_EEPROM0_WRITE		0xa0   // 1010 0000
#define I2C_EEPROM1_READ		0xa1   // 1010 0001
#define I2C_EEPROM1_WRITE		0xa0   // 1010 0000
#define I2C_EEPROM2_READ		0xa9   // 1010 1001
#define I2C_EEPROM2_WRITE		0xa8   // 1010 1000
#define I2C_EEPROM3_READ		0xa9   // 1010 1001
#define I2C_EEPROM3_WRITE		0xa8   // 1010 1000

#define I2C_EEPROM0_BASE		0x0000 // Base address of EEPROM0 region
#define I2C_EEPROM1_BASE		0x8000 // Base address of EEPROM1 region
#define I2C_EEPROM2_BASE		0x0000 // Base address of EEPROM2 region
#define I2C_EEPROM3_BASE		0x8000 // Base address of EEPROM3 region


#define I2C_COPY_EEPROM0_REQUEST	1
#define I2C_COPY_EEPROM0_WAIT		2
#define I2C_COPY_EEPROM1_REQUEST	3
#define I2C_COPY_EEPROM1_WAIT		4
#define I2C_COPY_EEPROM_IDLE		5

// Two sections of the code in the I2C.c file are wrapped in #pragma
// statements so that the code will be isolated in their own segments. This
// allows the code to be located in high Flash memory so that it will be
// protected from over-writing itself when Flash updates are performed.
//
// IMPORTANT: Writes to Flash are always done in blocks of 4 bytes, thus these
// defines must be on 4 byte boundaries. Also, since the uip_buf is being
// repurposed in these functions and is used for temporary storage in RAM of
// the flash_update segment, the flash_update segment must never exceed the
// size of the uip_buf. At this writing, the limit is about 500 bytes. For
// simplicity and easier debug I'm using 16 byte boundaries for these
// segments.
//
// These defines set a size of 448 bytes for the flash_update segment, and
// since the IO_NAMES and IO_TIMERS start at 0xfec0 these definces set a
// size of 80 bytes.
//
// IMPORTANT: The flash_update and memcpy_update segments barely fit in the
// space allocated. So any change in the code needs to be examined to
// determine if the segment size needs to change.
//
// Start of flash_update segment
// SEE MAIN.H FILE FOR THESE DEFINES
// #define FLASH_START_FLASH_UPDATE_SEGMENT	0xfcc0
//
// Start of memcpy_update segment
// #define FLASH_START_MEMCPY_UPDATE_SEGMENT	0xfe80
//
// The .lnk file requires these command lines to make this work:
//   +seg .flash_update -b 0xfcb0
//   +seg .memcpy_update -b 0xfe70



// void I2C_control(void);
void I2C_control(uint8_t control_byte);
// void I2C_byte_address(void);
void I2C_byte_address(uint16_t byte_address);
// void I2C_write_byte(void);
void I2C_write_byte(uint8_t I2C_write_data);
// uint8_t I2C_read_byte(void);
uint8_t I2C_read_byte(uint8_t I2C_last_flag);
void SCL_pulse(void);
void SCL_high(void);
void SCL_low(void);
void SDA_high(void);
void SDA_low(void);
// void I2C_transmit_byte(void);
void I2C_transmit_byte(uint8_t I2C_transmit_data);
// void Read_Slave_NACKACK(void);
uint8_t Read_Slave_NACKACK(void);
void I2C_stop(void);
void I2C_reset(void);
// void eeprom_copy_to_flash(void);
void eeprom_copy_to_flash(void);
void copy_ram_to_flash(void);

#endif /* __I2C_H__ */
