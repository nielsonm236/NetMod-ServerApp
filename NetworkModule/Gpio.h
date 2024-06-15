/* Modifications 2020-2022 Michael Nielson
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
 
 Copyright 2022 Michael Nielson
*/


#ifndef __GPIO_H__
#define __GPIO_H__

// The following enum PORTS, struct io_registers, struct io_mapping, and
// struct io_mapping io_map are used to direct the read_input_pins() and
// write_output_pins functions to the correct registers and bits for each
// physical pin that is being read or written. This significantly reduces
// the code size for these functions. Credit to Carlos Ladeira for this
// clever implementation.

enum PORTS { PA, PB, PC, PD, PE, PF, PG, NUM_PORTS };

struct io_registers {
	volatile uint8_t odr;	// Data Output Latch reg
	volatile uint8_t idr;	// Input Pin Value reg
	volatile uint8_t ddr;	// Data Direction
	volatile uint8_t cr1;	// Control register 1
	volatile uint8_t cr2;	// Control register 2
};

struct io_mapping {
	uint8_t port;		// port
	uint8_t bit;		// port bit
};

extern volatile struct io_registers io_reg[ NUM_PORTS ];
extern const struct io_mapping io_map[16];

void gpio_init(void);
uint8_t calc_PORT_BIT_index(uint8_t IO_index);

void LEDcontrol(uint8_t state);


#endif /* __GPIO_H__ */
