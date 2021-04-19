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


#ifndef __DS18B20_H__
#define __DS18B20_H__

void get_temperature(void);
void convert_temperature(uint8_t device_num, uint8_t degCorF);
int reset_pulse(void);
uint8_t check_CRC(void);
void transmit_byte(uint8_t transmit_value);
int read_bit(void);
void write_bit(uint8_t transmit_bit);
void check_temperature_sensor_changes(void);


void FindDevices(void);
uint8_t First(void);
uint8_t Next(void);
uint8_t dallas_crc8(uint8_t *data, uint8_t size);




#endif /* __DS18B20_H__ */
