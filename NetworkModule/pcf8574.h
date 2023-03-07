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

#ifndef __PCF8574_H__
#define __PCF8574_H__


void PCF8574_init(void);
void PCF8574_write(uint8_t byte);
uint8_t PCF8574_read(void);
uint8_t PCF8574_response_check(void);

#endif /* __PCF8574_H__ */
