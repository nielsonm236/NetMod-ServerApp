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


#ifndef __MAIN_H__
#define __MAIN_H__

#include <stdint.h>

// NUM_DEBUG_BYTES defines the number of debug bytes available.
// IMPORTANT: Be sure to update this define if the number of debug bytes
// available changes. A change is typically caused by adding variables
// to EEPROM storage, thus reducing what can be used for debug.
#define NUM_DEBUG_BYTES 46

int main(void);
void unlock_eeprom(void);
void check_eeprom_settings(void);
void update_mac_string(void);
void check_runtime_changes(void);
void read_input_registers(void);
void write_output_registers(void);
void check_reset_button(void);
void check_restart_reboot(void);
void restart(void);
void reboot(void);
void oneflash(void);
void fastflash(void);
void debugflash(void);
void update_debug_storage(void);
void update_debug_storage1(void);
void capture_uip_buf_transmit(void);
void capture_uip_buf_receive(void);
void capture_mqtt_sendbuf(void);


void mqtt_startup(void);
void mqtt_sanity_check(void);
void publish_callback(void** unused, struct mqtt_response_publish *published);
void publish_outbound(void);
void publish_pinstate(uint8_t direction, uint8_t pin, uint8_t value, uint8_t mask);
void publish_pinstate_all(void);
int8_t reverse_bit_order(uint8_t k);

#define MQTT_START_TCP_CONNECT		1
#define MQTT_START_VERIFY_ARP		2
#define MQTT_START_VERIFY_TCP		3
#define MQTT_START_QUEUE_CONNECT	4
#define MQTT_START_QUEUE_SUBSCRIBE1	5
#define MQTT_START_QUEUE_SUBSCRIBE2	6
#define MQTT_START_QUEUE_SUBSCRIBE3	7
#define MQTT_START_QUEUE_SUBSCRIBE4	8
#define MQTT_START_QUEUE_PUBLISH	9
#define MQTT_START_COMPLETE		20
  
#define MQTT_START_NOT_STARTED		0x00
#define MQTT_START_CONNECTIONS_ERROR	0x01
#define MQTT_START_ARP_REQUEST_ERROR	0x02
#define MQTT_START_TCP_CONNECT_ERROR	0x04
#define MQTT_START_MQTT_CONNECT_ERROR	0x08
#define MQTT_START_CONNECTIONS_GOOD	0x10
#define MQTT_START_ARP_REQUEST_GOOD	0x20
#define MQTT_START_TCP_CONNECT_GOOD	0x40
#define MQTT_START_MQTT_CONNECT_GOOD	0x80

#define MQTT_RESTART_IDLE		0
#define MQTT_RESTART_BEGIN		1
#define MQTT_RESTART_DISCONNECT_START	2
#define MQTT_RESTART_DISCONNECT_WAIT	3
#define MQTT_RESTART_TCPCLOSE		4
#define MQTT_RESTART_TCPCLOSE_WAIT	5
#define MQTT_RESTART_SIGNAL_STARTUP	6

#define RESTART_REBOOT_IDLE		0
#define RESTART_REBOOT_ARM		1
#define RESTART_REBOOT_ARM2		2
#define RESTART_REBOOT_DISCONNECT	3
#define RESTART_REBOOT_DISCONNECTWAIT	4
#define RESTART_REBOOT_TCPCLOSE		5
#define RESTART_REBOOT_TCPWAIT		6
#define RESTART_REBOOT_FINISH		7

#define STATE_REQUEST_IDLE		0
#define STATE_REQUEST_RCVD		1


#endif /* __MAIN_H__ */
