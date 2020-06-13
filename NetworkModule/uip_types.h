/* Modifications 2020 Michael Nielson
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
 
 Copyright 2020 Michael Nielson
*/



/* uip configuration */

#ifndef __UIP_TYPES_H__
#define __UIP_TYPES_H__

#include <stdint.h>

/**
 * 8 bit datatype
 * This typedef defines the 8-bit type used throughout uIP.
 */
typedef uint8_t u8_t;

/**
 * 16 bit datatype
 * This typedef defines the 16-bit type used throughout uIP.
 */
typedef uint16_t u16_t;

/**
 * Statistics datatype
 * This typedef defines the dataype used for keeping statistics in uIP.
 */
typedef uint32_t uip_stats_t;

#endif /* __UIP_TYPES_H__ */
