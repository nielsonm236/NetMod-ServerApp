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


#define I2C_FAIL_NULL			0
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

void I2C_control(uint8_t control_byte);
void I2C_byte_address(uint16_t byte_address);
void I2C_write_byte(uint8_t I2C_write_data);
uint8_t I2C_read_byte(uint8_t I2C_last_flag);
void SCL_pulse(void);
void SCL_high(void);
void SCL_low(void);
void SDA_high(void);
void SDA_low(void);
void I2C_transmit_byte(uint8_t I2C_transmit_data);
uint8_t Read_Slave_NACKACK(void);
void I2C_stop(void);
void I2C_reset(void);
void eeprom_copy_to_flash(void);
void copy_ram_to_flash(void);

#endif /* __I2C_H__ */
