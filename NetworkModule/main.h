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


#ifndef __MAIN_H__
#define __MAIN_H__

#include <stdint.h>
#include <stdlib.h>
#include <string.h>
#include <stdio.h>
#include <ctype.h>

#include <iostm8s005.h>	// Address definitions for all registers
			// See C:\Program Files (x86)\COSMIC\FSE_Compilers\CXSTM8\Hstm8 directory
#include <stm8s-005.h>	// Bit location definitions in registers
			// See C:\Users\Mike\Desktop\STM8S Peripheral Library\en.stsw-stm8069\STM8S_StdPeriph_Lib\Libraries\STM8S_StdPeriph_Driver\inc directory

#include "uipopt.h"

#include "bme280.h"
#include "DS18B20.h"
#include "Enc28j60.h"
#include "gpio.h"
#include "httpd.h"
#include "i2c.h"
#include "mqtt.h"
#include "mqtt_pal.h"
#include "Spi.h"
#include "timer.h"
#include "UART.h"
#include "uip.h"
#include "uip_arch.h"
#include "uip_arp.h"
#include "pcf8574.h"
#include "uip_TcpAppHub.h"


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


// Defines to identify the locations in I2C EEPROM Region 2 for IO_NAMES and
// IO_TIMERS associated with the PCF8574 IO pins.
#define PCF8574_I2C_EEPROM_START_IO_TIMERS	0x7ec0
#define PCF8574_I2C_EEPROM_START_IO_NAMES	0x7f00
// The PCF8574 IO TIMER and IO NAME values for the PCF8574 IO pins are stored
// in the I2C EEPROM because there is no room left in Flash. The I2C EEPROM is
// always present if the PCF8574 is present.
//
// IO_TIMERS: Each pin requires 2 bytes. There are 8 pins so this is 16 bytes.
// A 32 byte block is allocated in anticipation of adding more pins. So,
// addresses 0x7ec0 to 0x7edf are considered allocated.

// To write a PCF8574_IO_TIMER value:
//   I2C_control(I2C_EEPROM2_WRITE);
//   I2C_byte_address(PCF8574_I2C_EEPROM_START_IO_TIMERS + (index * 2), 2);
//   I2C_write_byte(msbyte);
//   I2C_write_byte(lsbyte);
//   I2C_stop(); // Start the EEPROM internal write cycle
//   wait_timer(5000); // Wait 5ms
// To read a PCF8574_IO_TIMER value:
//   prep_read(I2C_EEPROM2_WRITE, I2C_EEPROM2_READ, PCF8574_I2C_EEPROM_START_IO_TIMERS + (index * 2), 2);
//   IO_timer_value = read_two_bytes();
//
// IO_NAMES: Each pin requires 16 bytes. There are 8 pins so this is 128
// bytes. A 256 byte block is allocated in anticipation of adding more pins.
// So, addresses 0x7f00 to 0x7fff are considered allocated.
// To write a PCF8574_IO_NAME value:
//   I2C_control(I2C_EEPROM2_WRITE);
//   I2C_byte_address(PCF8574_I2C_EEPROM_START_IO_NAMES + (index * 16), 2);
//   for (i=0; i<16; i++) {
//     I2C_write_byte(Pending_IO_Name[i]);
//   }
//   I2C_stop(); // Start the EEPROM internal write cycle
//   wait_timer(5000); // Wait 5ms
// To read a PCF8574_IO_NAMES value:
//   prep_read(I2C_EEPROM2_WRITE, I2C_EEPROM2_READ, PCF8574_I2C_EEPROM_START_IO_NAMES + (index * 16), 2);
//   for (i=0; i<15; i++) {
//     temp_byte[i] = I2C_read_byte(0);
//   }
//   temp_byte[15] = I2C_read_byte(1);

// Defines to identify the location in I2C EEPROM Region 2 for non-volatile
// storage of PCF8574 IO pin_control values. There are 8 pins, thus 8 bytes
// are required. 16 bytes are allocated in anticipation of adding more pins
// in the future, thus addresses 0x7ee0 to 0x7eef are considered allocated.
#define PCF8574_I2C_EEPROM_PIN_CONTROL_STORAGE	 0x7ee0



// MQTT Start States
#define MQTT_START_TCP_CONNECT		1
#define MQTT_START_VERIFY_ARP		2
#define MQTT_START_VERIFY_TCP		3
#define MQTT_START_MQTT_INIT		4
#define MQTT_START_UIP_CONNECT_CLEANUP1 5
#define MQTT_START_UIP_CONNECT_CLEANUP2 6
#define MQTT_START_QUEUE_CONNECT	10
#define MQTT_START_VERIFY_CONNACK	11
#define MQTT_START_QUEUE_SUBSCRIBE1	20
#define MQTT_START_VERIFY_SUBSCRIBE1    21
#define MQTT_START_QUEUE_SUBSCRIBE2	22
#define MQTT_START_VERIFY_SUBSCRIBE2    23
#define MQTT_START_QUEUE_SUBSCRIBE3	24
#define MQTT_START_VERIFY_SUBSCRIBE3    25
// #define MQTT_START_QUEUE_SUBSCRIBE4	26
// #define MQTT_START_VERIFY_SUBSCRIBE4    27
 #define MQTT_START_QUEUE_PUBLISH_ON	30
#define MQTT_START_QUEUE_PUBLISH_AUTO   31
#define MQTT_START_QUEUE_PUBLISH_PINS	32
#define MQTT_START_COMPLETE		40

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

// MQTT Input Output Temp Sensor define/delete controls
#define DEFINE_IOT			0
#define DELETE_IOT			1

// MQTT Input Output Temp Sensor message controls
#define INPUTMSG			0
#define OUTPUTMSG			1
#define TMPRMSG				2
#define PRESMSG				3
#define HUMMSG				4

// MQTT State message control
#define STATE_REQUEST_IDLE		0
#define STATE_REQUEST_RCVD		1
#define STATE_REQUEST_RCVD24		2

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
void periodic_service(void);
void init_IWDG(void);
void unlock_eeprom(void);
void lock_eeprom(void);
void unlock_flash(void);
void lock_flash(void);
void upgrade_EEPROM(void);
void check_eeprom_settings(void);
void apply_PCF8574_pin_settings(void);
uint8_t is_allowed_char(uint8_t character);
void update_mac_string(void);
void check_runtime_changes(void);
uint8_t chk_iotype(uint8_t pin_byte, int pin_index, uint8_t chk_mask);
void read_input_pins(uint8_t init_flag);
void encode_16bit_registers(uint8_t sort_init);
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
void prep_read(uint8_t control_write, uint8_t control_read,
               uint16_t start_address, uint8_t addr_size);
uint8_t compare_flash_to_EEPROM0(void);
void copy_flash_to_EEPROM0(void);
uint8_t compare_flash_to_EEPROM1(void);
void copy_code_uploader_to_EEPROM1(void);

uint32_t calculate_timer(uint16_t timer_value);
void decrement_pin_timers(void);

void mqtt_startup(void);
void define_temp_sensors(void);
void define_BME280_sensors(void);
void send_IOT_msg(uint8_t IOT_ptr, uint8_t IOT, uint8_t DefOrDel);
void mqtt_sanity_check(struct mqtt_client *client);
void publish_callback(void** unused, struct mqtt_response_publish *published);
void publish_outbound(void);

#if PCF8574_SUPPORT == 0
void publish_pinstate(uint8_t direction, uint8_t pin, uint16_t value, uint16_t mask);
#endif // PCF8574_SUPPORT == 0
#if PCF8574_SUPPORT == 1
void publish_pinstate(uint8_t direction, uint8_t pin, uint32_t value, uint32_t mask);
#endif // PCF8574_SUPPORT == 1

void publish_pinstate_all(uint8_t type);
void publish_temperature(uint8_t sensor);
void publish_BME280(int8_t sensor);

int8_t reverse_bit_order(uint8_t k);

void PCF8574_display_pin_control(void);
void STM8_display_pin_control(void);

#endif /* __MAIN_H__ */
