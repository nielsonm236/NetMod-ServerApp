/*
 * Build options for Network module firmware
 *
 * Author: P-O Yliniemi
 * Email: peo@yliniemi.se
 *
 This program is free software: you can redistribute it and/or modify
 it under the terms of the GNU General Public License as published by
 the Free Software Foundation, either version 3 of the License, or
 (at your option) any later version.

 This program is distributed in the hope that it will be useful,
 but WITHOUT ANY WARRANTY; without even the implied warranty of
 MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 GNU General Public License for more details.

 You should have received a copy of the GNU General Public License
 along with this program.  If not, see <http://www.gnu.org/licenses/>.
 */
#ifndef __BUILD_OPTIONS_H__
#define __BUILD_OPTIONS_H__

// IO pin order, used in gpio.c to set up the io_mapping structure
//
// HW-584 silkscreen pin order
//
// 5V 16 15 14 13 12 11 10 09 G
// 5V 08 07 06 05 04 03 02 01 G
// #define IO_PIN_ORDER	1

//
// Typical 16 channel board pin order
//
// 5V 02 04 06 08 10 12 14 16 G
// 5V 01 03 05 07 09 11 13 15 G
//
#define IO_PIN_ORDER	2

//
// Pin order for 8 channel relay board when using inner row for relays
// (use the default pin order if using the outer row)
// 
// 5V 08 07 06 05 04 03 02 01 G
// -- -- -- -- -- -- -- -- -- -
//
// #define IO_PIN_ORDER	3

#endif