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

#define I2C_EEPROM_R0_READ		0xa1   // 1010 0001
#define I2C_EEPROM_R0_WRITE		0xa0   // 1010 0000
#define I2C_EEPROM_R1_READ		0xa1   // 1010 0001
#define I2C_EEPROM_R1_WRITE		0xa0   // 1010 0000
#define I2C_EEPROM_R2_READ		0xa9   // 1010 1001
#define I2C_EEPROM_R2_WRITE		0xa8   // 1010 1000
#define I2C_EEPROM_R3_READ		0xa9   // 1010 1001
#define I2C_EEPROM_R3_WRITE		0xa8   // 1010 1000

#define I2C_EEPROM_R0_BASE		0x0000 // Base addr of I2C EEPROM Region 0
#define I2C_EEPROM_R1_BASE		0x8000 // Base addr of I2C EEPROM Region 1
#define I2C_EEPROM_R2_BASE		0x0000 // Base addr of I2C EEPROM Region 2
#define I2C_EEPROM_R3_BASE		0x8000 // Base addr of I2C EEPROM Region 3


#define I2C_COPY_EEPROM_R0_REQUEST	1
#define I2C_COPY_EEPROM_R0_WAIT		2
#define I2C_COPY_EEPROM_R1_REQUEST	3
#define I2C_COPY_EEPROM_R1_WAIT		4
#define I2C_COPY_EEPROM_IDLE		5

uint8_t I2C_control(uint8_t control_byte);
void I2C_byte_address(uint16_t byte_address, uint8_t addr_size);
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
void copy_I2C_EEPROM_to_Flash(uint8_t maxblocks);
void copy_RAM_to_Flash(void);
void copy_I2C_EEPROM_bytes_to_RAM(uint8_t *destination,
                           uint8_t num_bytes,
                           uint8_t control_write,
                           uint8_t control_read,
                           uint16_t start_address,
                           uint8_t addr_size);
//void copy_I2C_EEPROM_words_to_RAM(uint16_t *destination,
//                           uint8_t num_words,
//                           uint8_t control_write,
//                           uint8_t control_read,
//                           uint16_t start_address,
//                           uint8_t addr_size);
void copy_STM8_bytes_to_I2C_EEPROM(uint8_t *source,
                           uint8_t num_bytes,
                           uint8_t control_write,
                           uint16_t start_address,
                           uint8_t addr_size);
// void copy_RAM_words_to_I2C(uint16_t *source,
//                            uint8_t num_bytes,
//                            uint8_t control_write,
//                            uint16_t start_address,
//                            uint8_t addr_size);
#endif /* __I2C_H__ */
