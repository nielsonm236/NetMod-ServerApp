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


//---------------------------------------------------------------------------//
// The .lkf file requires these command lines to make this work:
//
//   +seg .vector -b 0x8000 -m 0x8000 -n .vector	# vectors start address
//   -k
//   +seg .const -a .vector -n .const		# constants follow vectors
//   +seg .text -a .const -n .text			# code follow constants
//   +seg .eeprom -b 0x4000 -m 128			# internal eeprom
//   +seg .bsct -b 0 -m 0x100 -n .bsct		# internal ram
//   +seg .ubsct -a .bsct -n .ubsct
//   +seg .bit -a .ubsct -n .bit -id
//   +seg .data -a .bit -m 0x800 -n .data
//   +seg .memcpy_update -a .data -n memcpy_update -ic
//   +seg .bss -a memcpy_update -n .bss
//   +seg .flash_update -b 0xfc80
//   +seg .iconst -b 0x5fe -n .iconst
//
// NOTE: To enable editing the Linker .lkf file in IdeaSTM8 you must first
// edit the .prjsm8 file. Make sure the following line is in the .prjsm8 file:
//   LinkFileAutomatic=NO
// When you first install IdeaSTM8 the default is for the program to auto
// generate the .lkf file each time a build is done. This is useful because
// it creates all the linker commands you typically need. However, when you
// reach the point that you need to make your own changes to the .lkf file
// edit access is disabled until the LinkFileAutomatic line is modified.
//---------------------------------------------------------------------------//


// Start of flash program memory segment
#define FLASH_START_PROGRAM_MEMORY 		0x8000

// Start of flash_update segment
#define FLASH_START_FLASH_UPDATE_SEGMENT	0xfc80

// Start of user reserved area
#define FLASH_START_USER_RESERVE		0xfe80
#define OFFSET_TO_FLASH_START_USER_RESERVE	FLASH_START_USER_RESERVE - FLASH_START_PROGRAM_MEMORY

// Start of IO_TIMER storage in Flash
#define FLASH_START_IO_TIMERS	0xfec0

// Start of IO_NAME storage in Flash
#define FLASH_START_IO_NAMES	0xff00


// MQTT Start States
#define MQTT_START_TCP_CONNECT		1
#define MQTT_START_VERIFY_ARP		2
#define MQTT_START_VERIFY_TCP		3
#define MQTT_START_MQTT_INIT		4
#define MQTT_START_QUEUE_CONNECT	5
#define MQTT_START_VERIFY_CONNACK	6
#define MQTT_START_QUEUE_SUBSCRIBE1	7
#define MQTT_START_VERIFY_SUBSCRIBE1    8
#define MQTT_START_QUEUE_SUBSCRIBE2	9
#define MQTT_START_VERIFY_SUBSCRIBE2    10
#define MQTT_START_QUEUE_SUBSCRIBE3	11
#define MQTT_START_VERIFY_SUBSCRIBE3    12
#define MQTT_START_QUEUE_SUBSCRIBE4	13
#define MQTT_START_VERIFY_SUBSCRIBE4    14
#define MQTT_START_QUEUE_PUBLISH_ON	15
#define MQTT_START_QUEUE_PUBLISH_AUTO   16
#define MQTT_START_QUEUE_PUBLISH_PINS	17
#define MQTT_START_COMPLETE		20

// MQTT Start Status
#define MQTT_START_NOT_STARTED		0x00
#define MQTT_START_CONNECTIONS_ERROR	0x01
#define MQTT_START_ARP_REQUEST_ERROR	0x02
#define MQTT_START_TCP_CONNECT_ERROR	0x04
#define MQTT_START_MQTT_CONNECT_ERROR	0x08
#define MQTT_START_CONNECTIONS_GOOD	0x10
#define MQTT_START_ARP_REQUEST_GOOD	0x20
#define MQTT_START_TCP_CONNECT_GOOD	0x40
#define MQTT_START_MQTT_CONNECT_GOOD	0x80

// MQTT Restart States
#define MQTT_RESTART_IDLE		0
#define MQTT_RESTART_BEGIN		1
#define MQTT_RESTART_DISCONNECT_START	2
#define MQTT_RESTART_DISCONNECT_WAIT	3
#define MQTT_RESTART_TCPCLOSE		4
#define MQTT_RESTART_TCPCLOSE_WAIT	5
#define MQTT_RESTART_SIGNAL_STARTUP	6

// MQTT Auto Discovery States
#define DEFINE_INPUTS			0
#define DEFINE_OUTPUTS			1
#define DEFINE_DISABLED			2
#define DEFINE_TEMP_SENSORS		3
#define AUTO_COMPLETE			4

// MQTT Auto Discovery Sub-States
#define STEP_NULL			0
#define SEND_INPUT_DELETE		1
#define SEND_INPUT_DEFINE		2
#define SEND_OUTPUT_DELETE		3
#define SEND_OUTPUT_DEFINE		4
// #define SEND_TEMP_SENSOR_DELETE		5
// #define SEND_TEMP_SENSOR_DELETE2	6
// #define SEND_TEMP_SENSOR_DEFINE		7

// MQTT Input Output Temp Sensor define/delete controls
#define DEFINE_IOT			0
#define DELETE_IOT			1

// MQTT Input Output Temp Sensor message controls
#define INPUTMSG			0
#define OUTPUTMSG			1
#define TMPRMSG				2

// MQTT State message control
#define STATE_REQUEST_IDLE		0
#define STATE_REQUEST_RCVD		1

// Restart State Machine Controls
#define RESTART_REBOOT_IDLE		0
#define RESTART_REBOOT_ARM		1
#define RESTART_REBOOT_ARM2		2
#define RESTART_REBOOT_SENDOFFLINE	4
#define RESTART_REBOOT_DISCONNECT	5
#define RESTART_REBOOT_TCPCLOSE		6
#define RESTART_REBOOT_TCPWAIT		7
#define RESTART_REBOOT_FINISH		8


int main(void);
void init_IWDG(void);
void unlock_eeprom(void);
void lock_eeprom(void);
void unlock_flash(void);
void lock_flash(void);
void upgrade_EEPROM(void);
void check_eeprom_settings(void);
void check_eeprom_IOpin_settings(void);
void update_mac_string(void);
void check_runtime_changes(void);
void read_input_pins(void);
void write_output_pins(void);
void check_reset_button(void);
void check_restart_reboot(void);
void restart(void);
void reboot(void);
void oneflash(void);
void fastflash(void);
void debugflash(void);
void restore_eeprom_debug_bytes(void);
void update_debug_storage1(void);
uint8_t off_board_EEPROM_detect(void);
void write_one(uint8_t byte);
void prep_read(uint8_t eeprom_num_write, uint8_t eeprom_num_read, uint16_t byte_address);
uint8_t compare_flash_to_EEPROM0(void);
void copy_flash_to_EEPROM0(void);
uint8_t compare_flash_to_EEPROM1(void);
void copy_code_uploader_to_EEPROM1(void);

// void load_timer(uint8_t timer_num);
uint32_t calculate_timer(uint16_t timer_value);
void decrement_pin_timers(void);

void mqtt_startup(void);
void mqtt_redefine_temp_sensors(void);
void define_temp_sensors(void);
// void send_IOT_msg(uint8_t IOT_ptr, uint8_t IOT, uint8_t DefOrDel, uint8_t delete_flag);
void send_IOT_msg(uint8_t IOT_ptr, uint8_t IOT, uint8_t DefOrDel);
// void mqtt_sanity_check(void);
void mqtt_sanity_check(struct mqtt_client *client);
void publish_callback(void** unused, struct mqtt_response_publish *published);
void publish_outbound(void);
void publish_pinstate(uint8_t direction, uint8_t pin, uint16_t value, uint16_t mask);
void publish_pinstate_all(void);
void publish_temperature(uint8_t sensor);
int8_t reverse_bit_order(uint8_t k);

#endif /* __MAIN_H__ */
