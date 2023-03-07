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



// Application must "manually" check if its timers have expired; this
// is not done automatically.

#ifndef __TIMER_H__
#define __TIMER_H__

void clock_init(void);
void timer_update(void);
uint8_t periodic_timer_expired(void);
uint8_t arp_timer_expired(void);
uint8_t mqtt_timer_expired(void);
uint8_t t100ms_timer_expired(void);
void wait_timer(uint16_t wait);

#endif /* __TIMER_H__ */

