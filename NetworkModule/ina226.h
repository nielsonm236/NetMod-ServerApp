/**
 * INA226 implementation
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

#ifndef __INA226_H__
#define __INA226_H__


// Define Read/Write control words for each of 5 INA226 devices.
#define INA226_1_read		0x81	// 1000 0001 0x40
#define INA226_1_write		0x80	// 1000 0000
#define INA226_2_read		0x83	// 1000 0011 0x41
#define INA226_2_write		0x82	// 1000 0010
#define INA226_3_read		0x85	// 1000 0101 0x42
#define INA226_3_write		0x84	// 1000 0100
#define INA226_4_read		0x89	// 1000 1001 0x44
#define INA226_4_write		0x88	// 1000 1000
#define INA226_5_read		0x8b	// 1000 1011 0x45
#define INA226_5_write		0x8a	// 1000 1010


// The following defines the register_address for each register within the
// INA226
#define INA226_REG_CONFIGURATION	0x00
#define INA226_REG_SHUNT_VOLTAGE	0x01
#define INA226_REG_BUS_VOLTAGE		0x02
#define INA226_REG_POWER		0x03
#define INA226_REG_CURRENT		0x04
#define INA226_REG_CALIBRATION		0x05
#define INA226_REG_MASK_ENABLE		0x06
#define INA226_REG_ALERT_LIMIT		0x07
#define INA226_REG_MFG_ID		0xfe
#define INA226_REG_DIE_ID		0xff

// The following defines the default register values for the INA226
#define INA226_CONFIGURATION__RST			0x8000

#define INA226_CONFIGURATION__AVG_MASK			0x0E00
#define INA226_CONFIGURATION__AVG_SHIFT			9

#define INA226_CONFIGURATION__BUS_CONV_TIME_MASK	0x01C0
#define INA226_CONFIGURATION__BUS_CONV_TIME_SHIFT	6

#define INA226_CONFIGURATION__SHUNT_CONV_TIME_MASK	0x0038
#define INA226_CONFIGURATION__SHUNT_CONV_TIME_SHIFT	3

#define INA226_CONFIGURATION__MODE_MASK			0x0007
#define INA226_CONFIGURATION__MODE_SHIFT		0

#define INA226_MASK_ENABLE__CVRF			0x0008

#define INA226_MFG_ID					0x5449



void ina226_init_all(void);
void ina226_calibrate_all(void);
// void ina226_calibrate(uint8_t write_command, float r_shunt, float max_current);
void ina226_calibrate(uint8_t write_command, int32_t r_shunt, int32_t max_current);
void ina226_configure_all(void);
void ina226_configure(uint8_t write_command, uint8_t period, uint8_t average);
int ina226_conversion_ready(uint8_t write_command, uint8_t read_command);
void ina226_read_measurements(uint8_t write_command, uint8_t read_command);
void ina226_write_reg(uint8_t write_command, uint8_t register_address, uint16_t value);
uint16_t ina226_read_reg(uint8_t write_command, uint8_t read_command, uint8_t register_address);


#endif /* __INA226_H__ */
