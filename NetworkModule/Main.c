/*
 * Main File including the main-routine with initializations-
 * and stack-routines.
 *
 * Author: Simon Kueppers
 * Email: simon.kueppers@web.de
 * Homepage: http://klinkerstein.m-faq.de
 * */
 
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

#include <stdlib.h>

#include "main.h"
#include "Enc28j60.h"
#include "Spi.h"
#include "uip.h"
#include "uip_arp.h"
#include "gpio.h"
#include "timer.h"
#include "httpd.h"
#include "iostm8s005.h"
#include "uip_arch.h"
#include "uip_TcpAppHub.h"
#include "uipopt.h"
#include "mqtt.h"
#include "DS18B20.h"


//---------------------------------------------------------------------------//
//---------------------------------------------------------------------------//
//---------------------------------------------------------------------------//
const char code_revision[] = "20210207 1543";
//---------------------------------------------------------------------------//
//---------------------------------------------------------------------------//
//---------------------------------------------------------------------------//

//---------------------------------------------------------------------------//
// Stack overflow detection
// The following is used to declare two constants at the top of the RAM area.
// Regular variable assignments start at memory address 0x0000 and grow upwards
// to 0x5ff. Stack starts at 0x7ff and grows downward to 0x0600. Two constants
// are placed at 0x5fe and 0x5ff and are monitored to make sure they never
// change. If they do change it implies that the Stack has grown into the
// variable storage RAM.
//
#pragma section @near [iconst]
uint8_t stack_limit1;
uint8_t stack_limit2;
#pragma section @near []
//
// The above creates the two variables in a special section named ".iconst".
// The linker needs to be told where to place this section in memory. The
// following directive needs to be placed in the linker file before the
// object file where the variables are declared. This directive will place
// the two stack limit variables at 0x5fe and 0x5ff.
//   +seg .iconst -b 0x5fe -n .iconst
//
// For reference the +seg part of the .lkf file for this project looks like
// this:
//
// +seg .vector -b 0x8000 -m 0x8000 -n .vector	# vectors start address
// -k
// +seg .const -a .vector -n .const		# constants follow vectors
// +seg .text -a .const -n .text		# code follow constants
// +seg .eeprom -b 0x4000 -m 128		# internal eeprom
// +seg .bsct -b 0 -m 0x100 -n .bsct		# internal ram
// +seg .ubsct -a .bsct -n .ubsct
// +seg .bit -a .ubsct -n .bit -id
// +seg .data -a .bit -m 0x800 -n .data
// +seg .bss -a .data -n .bss
// +seg .iconst -b 0x5fe -n .iconst
//
// NOTE: To enable editing the Linker .lkf file in IdeaSTM8 you must first
// edit the .prjsm8 file. Make sure the following line is in the .prjsm8
// file:
//   LinkFileAutomatic=NO
// When you first install IdeaSTM8 the default is for the program to auto
// generate the .lkf file each time a build is done. This is useful because
// it creates all the linker commands you typically need. However, when you
// reach the point that you need to make your own changes to the .lkf file
// edit access is disabled until the LinkFileAutomatic line is modified.
//---------------------------------------------------------------------------//



//---------------------------------------------------------------------------//
// EEPROM variable declarations
// When using the Cosmic compiler all variables stored in EEPROM must be
// declared with the @eeprom identifier. This signals the Cosmic compiler and
// linker to treat the variables as special and located in the EEPROM. Code
// must unlock the EEPROM before writing the variables, and can relock the
// EEPROM to protect it from errant writes.
//
// NOTE1: The linker places the @eeprom variables in memory in reverse order
// from the declarations below. SO - if any debug variables are added it is
// recommended that they be declared ABOVE the Operating Code variables to
// keep the Operating Code variables from being relocated in the memory.
//
// NOTE2: The order of the Operating Code variables should not be changed if
// you want code updates to work without losing stored values.
//
// NOTE3: Similar to NOTE1, if you add any new Operating Code variables they
// should be added above the "magic" numbers in the list below. That will
// keep all existing variables in the same place in EEPROM which will allow
// new code updates to discover the magic number and existing settings.
//
// NOTE4: The values stored for MQTT are allocated in EEPROM whether they are
// included in the code build or not. This is to maintain the location of all
// EEPROM variables so that future builds wont require users to re-enter their
// settings when they reprogram their devices.
// 
// EEPROM Operating Code Variables:

#if DEBUG_SUPPORT != 0
// Be sure to update the #define NUM_DEBUG_BYTES value in main.h
@eeprom uint8_t stored_debug[NUM_DEBUG_BYTES];
                                        // 30 debug bytes
					// Byte 128 stored_debug[29]
                                        // Byte 99 stored_debug[0]
#endif // DEBUG_SUPPORT != 0

// 98 bytes used below
// >>> Add new variables HERE <<<
// Reduce the size of the stored_debug[] array by the number of bytes added
@eeprom uint8_t stored_pin_control[16];    // Byte 83-98 Config settings for
                                           // each IO pin
@eeprom uint8_t stored_config_settings;    // Byte 82
                                           // Bit 8: Undefined, 0 only
                                           // Bit 7: Undefined, 0 only
                                           // Bit 6: Undefined, 0 only
                                           // Bit 5: Undefined, 0 only
                                           // Bit 4: Undefined, 0 only
                                           // Bit 3: MQTT 1 = Enable, 0 = Disable
                                           // Bit 2: Home Assistant Auto Discovery
                                           // Bit 1: Duplex 1 = Full, 0 = Half
					   //        1 = Enable, 0 = Disable
@eeprom uint8_t stored_prior_config;       // Copy of stored_config_settings
                                           // prior to reboot
@eeprom uint8_t stored_unused6;            // Byte 80 unused
@eeprom uint8_t stored_unused5;            // Byte 79 unused
@eeprom uint8_t stored_unused4;            // Byte 78 unused
@eeprom uint8_t stored_unused3;            // Byte 77 unused
@eeprom uint8_t stored_unused2;            // Byte 76 unused
@eeprom char stored_mqtt_password[11];     // Byte 65 MQTT Password
@eeprom char stored_mqtt_username[11];     // Byte 54 MQTT Username
@eeprom uint8_t stored_mqttserveraddr[4];  // Bytes 50-53 mqttserveraddr
@eeprom uint16_t stored_mqttport;	   // Bytes 48-49 MQTT Port number
@eeprom uint8_t magic4;			   // Byte 47 MSB Magic Number
@eeprom uint8_t magic3;			   // Byte 46
@eeprom uint8_t magic2;			   // Byte 45
@eeprom uint8_t magic1;			   // Byte 44 LSB Magic Number
@eeprom uint8_t stored_hostaddr[4];	   // Bytes 40-43 hostaddr
@eeprom uint8_t stored_draddr[4];	   // Bytes 36-39 draddr
@eeprom uint8_t stored_netmask[4];	   // Bytes 32-35 netmask
@eeprom uint16_t stored_port;		   // Bytes 30-31 Port
@eeprom uint8_t stored_uip_ethaddr_oct[6]; // Bytes 24-29 MAC MSB
@eeprom uint8_t stored_EEPROM_revision2;   // Byte 23 EEPROM revision
@eeprom uint8_t stored_EEPROM_revision1;   // Byte 22 EEPROM revision
@eeprom uint8_t stored_unused1;            // Byte 21 unused
@eeprom uint8_t stored_devicename[20];     // Byte 01 Device name @4000
//---------------------------------------------------------------------------//


#if DEBUG_SUPPORT != 0
//---------------------------------------------------------------------------//
// Note: Make sure there is enough RAM for the debug[] values. These bytes are
// used to pass debug information from the code in other .c files to this one,
// and to help control the number of writes done to the EEPROM (to reduce
// write wear). When needed the debug[] data is stored in EEPROM in the
// corresponding stored_debug[] values so they can be read by the developer
// via the STVP programmer.
uint8_t *pBuffer2;
uint8_t debug[NUM_DEBUG_BYTES];
//---------------------------------------------------------------------------//
#endif // DEBUG_SUPPORT != 0


uint8_t pin_control[16];                // Per pin configuration byte
uint16_t ON_OFF_word;                   // ON/OFF states of pins in single 16
                                        // bit word
uint16_t ON_OFF_word_new1;              // ON/OFF states of pins stored for
                                        // debounce of input pins
uint16_t ON_OFF_word_new2;              // ON/OFF states of pins stored for
                                        // debounce of input pins
uint16_t ON_OFF_word_sent;              // Used to indicate pin states that
                                        // need to be sent in MQTT Publish msgs
uint16_t Invert_word;                   // Invert state of pins in single 16 bit
                                        // word
uint8_t state_request;			// Indicates that a PUBLISH state
                                        // request was received

uint8_t stack_error;			// Stack error flag storage

//---------------------------------------------------------------------------//
// Pending values are used to pass change requests from the user to the main.c
// functions. Code in the main.c file will compare the values in use to the
// "pending" values to determine if any changes occurred, and if so code will
// update the "in use" values and will restart the firmware if needed.

uint8_t Pending_hostaddr[4];
uint8_t Pending_draddr[4];
uint8_t Pending_netmask[4];

uint16_t Pending_port;

uint8_t Pending_devicename[20];

uint8_t Pending_config_settings;

uint8_t Pending_uip_ethaddr_oct[6];

uint8_t Pending_pin_control[16];

char mac_string[13];

uint8_t reboot_request;         // Signals the need for a reboot
uint8_t user_reboot_request;    // Signals a user request for a reboot
uint8_t restart_request;        // Signals the need for a restart
uint8_t restart_reboot_step;    // Tracks steps used in restart and reboot
                                // functions
uint8_t mqtt_close_tcp;         // Signals the need to close the MQTT TCP
                                // connection
uint8_t parse_complete;         // Signals the completion of POST parsing
uint8_t mqtt_parse_complete;    // Signals the completion of MQTT parsing

uint16_t Port_Httpd;  // HTTP port number
uip_ipaddr_t IpAddr;

uint32_t t100ms_ctr1;           // Timer used in restart/reboot function
extern uint32_t second_counter; // Time in seconds

extern uint8_t OctetArray[11];  // Used in emb_itoa conversions

uint8_t RXERIF_counter;               // Counts RXERIF errors detected by the
                                      // ENC28J60
uint8_t TXERIF_counter;               // Counts TXERIF errors detected by the
                                      // ENC28J60
uint32_t TRANSMIT_counter;            // Counts any transmit by the ENC28J60


// MQTT variables
uint8_t mqtt_enabled;                 // Used to signal use of MQTT functions
                                      // Initialized to 'disabled', but any
				      // non-zero MQTT Server IP Adddress will
				      // cause it to be 'enabled'
uint8_t Pending_mqttserveraddr[4];    // Holds a new user entered MQTT Server
                                      // IP address
uint16_t Pending_mqttport;            // Holds a new user entered MQTT Port
                                      // number
char Pending_mqtt_username[11];       // Holds a new user entered MQTT username
char Pending_mqtt_password[11];       // Holds a new user entered MQTT password

uint8_t connect_flags;                // Used in MQTT setup
uint16_t mqttport;             	      // MQTT port number
uint16_t Port_Mqttd;                  // In use MQTT port number
uint16_t mqtt_keep_alive;             // Ping interval
struct mqtt_client mqttclient;        // Declare pointer to the MQTT client
                                      // structure
const char* client_id;                // MQTT Client ID
char client_id_text[26];              // Client ID comprised of text
                                      // "NetworkModule" (13 bytes) and MAC
				      // (12 bytes) and terminator (1 byte)
				      // for a total of 26 bytes.
uint8_t mqtt_start;                   // Tracks the MQTT startup steps
uint8_t mqtt_start_status;            // Error (or success) status for startup
                                      // steps
uint8_t mqtt_start_ctr1;              // Tracks time for the MQTT startup
                                      // steps
uint8_t mqtt_start_ctr2;              // Tracks time for the MQTT startup
                                      // steps
uint8_t mqtt_sanity_ctr;              // Tracks time for the MQTT sanity steps
extern uint8_t connack_received;      // Used to communicate CONNECT CONNACK
                                      // received from mqtt.c to main.c

extern uint8_t mqtt_sendbuf[200];     // Buffer to contain MQTT transmit queue
				      // and data.

struct uip_conn *mqtt_conn;           // mqtt_conn points to the connection
                                      // being used with the MQTT server. This
				      // structure is created here so we don't
				      // have to keep looking it up in the
				      // structure table while setting up MQTT
				      // operations.
extern uint8_t MQTT_error_status;     // For MQTT error status display in GUI
uint8_t mqtt_restart_step;            // Step tracker for restarting MQTT

static const unsigned char devicetype[] = "NetworkModule/"; // Used in
                                      // building topic and client id names
unsigned char topic_base[51];         // Used for building connect, subscribe,
                                      // and publish topic strings.
				      // Longest string content:
				      // NetworkModule/DeviceName123456789/availability
				      // NetworkModule/DeviceName123456789/output/+/set
				      // NetworkModule/DeviceName123456789/temp/15
				      // homeassistant/binary_sensor/macaddressxx/01/config
uint8_t MQTT_resp_tout_counter;       // Counts response timeout events in the
                                      // mqtt_sanity_check() function
uint8_t MQTT_not_OK_counter;          // Counts MQTT != OK events in the
                                      // mqtt_sanity_check() function
uint8_t MQTT_broker_dis_counter;      // Counts broker disconnect events in
                                      // the mqtt_sanity_check() function
uint8_t auto_pub_count;               // Tracks the Home Assistant Auto Discovery
                                      // publish msgs
uint8_t auto_pub_toggle;              // Tracks the dual message count required for
                                      // the Home Assistant Auto Discovery publish msgs


// DS18B20 variables
uint32_t check_DS18B20_ctr;           // Counter used to trigger temperature
                                      // measurements
uint8_t DS18B20_string[5][7];         // Stores the temperature measurement for the
                                      // DS18B20s
int8_t send_mqtt_temperature;         // Indicates if a new temperature measurement
                                      // is pending transmit on MQTT. In this
				      // application there are 5 sensors, so setting
				      // to 4 will cause all 5 to transmit (4,3,2,1,0).
				      // -1 indicates nothing to transmit.
extern int numROMs;                   // Count of DS18B20 devices found



//---------------------------------------------------------------------------//
int main(void)
{
  uint8_t i;
  
  uip_ipaddr_t IpAddr;
  
  parse_complete = 0;
  mqtt_parse_complete = 0;
  reboot_request = 0;
  user_reboot_request = 0;
  restart_request = 0;
  t100ms_ctr1 = 0;
  restart_reboot_step = RESTART_REBOOT_IDLE;
  mqtt_close_tcp = 0;
  stack_error = 0;
  
#if IWDG_ENABLE == 1
  init_IWDG(); // Initialize the hardware watchdog
#endif // IWDG_ENABLE == 1
  
// Initialize MQTT variables
  mqtt_enabled = 0;                      // Initialized to 'disabled', but any
				         // non-zero MQTT Server IP Adddress will
				         // cause it to be 'enabled'
  mqtt_start = MQTT_START_TCP_CONNECT;	 // Tracks the MQTT startup steps
  mqtt_start_status = MQTT_START_NOT_STARTED; // Tracks error states during
                                         // startup
  mqtt_keep_alive = 60;                  // Ping interval in seconds
  mqtt_start_ctr1 = 0;			 // Tracks time for the MQTT startup
                                         // steps
  mqtt_start_ctr2 = 0;			 // Tracks time for the MQTT startup
                                         // steps
  mqtt_sanity_ctr = 0;			 // Tracks time for the MQTT sanity
                                         // steps
  MQTT_error_status = 0;                 // For MQTT error status display in
                                         // GUI
  mqtt_restart_step = MQTT_RESTART_IDLE; // Step counter for MQTT restart
  state_request = STATE_REQUEST_IDLE;    // Set the state request received to
                                         // idle
  TXERIF_counter = 0;                    // Initialize the TXERIF error counter
  RXERIF_counter = 0;                    // Initialize the RXERIF error counter
  TRANSMIT_counter = 0;                  // Initialize the TRANSMIT counter
  MQTT_resp_tout_counter = 0;            // Initialize the MQTT response
                                         // timeout event counter
  MQTT_not_OK_counter = 0;               // Initialize the MQTT != OK event
                                         // counter
  MQTT_broker_dis_counter = 0;           // Initialize the MQTT broker
                                         // disconnect event counter
  auto_pub_count = 0;                    // Initialize Home Assistant Auto
                                         // Discovery message counter
  auto_pub_toggle = 0;                   // Initialize dual msg tracker for
                                         // Home Assistant Auto Discovery
					 // message counter


  clock_init();            // Initialize and enable clocks and timers

  upgrade_EEPROM();        // Check for down revision EEPROM and upgrade if
                           // needed.

  check_eeprom_settings(); // Check the EEPROM for previously stored Address
			   // and IO settings. Use defaults (if nothing
			   // stored) or restore previously stored settings.
			   // This must occur before gpio_init() because
			   // gpio_init() uses settings in the EEPROM and we
			   // need to make sure it is up to date.


#if DEBUG_SUPPORT == 2
  // Clear the general purpose debug bytes and restore the saved debug
  // statistics
  clear_eeprom_debug_bytes();
#endif // DEBUG_SUPPORT == 2

  gpio_init();             // Initialize and enable gpio pins
  
  spi_init();              // Initialize the SPI bit bang interface to the
                           // ENC28J60 and perform hardware reset on ENC28J60

  LEDcontrol(1);           // turn LED on
  
  Enc28j60Init();          // Initialize the ENC28J60 ethernet interface

  uip_arp_init();          // Initialize the ARP module
  
  uip_init();              // Initialize uIP Web Server
  
  HttpDInit();             // Initialize listening ports


  // Initialize DS18B20 temperature storage strings
  for (i=0; i<5; i++) strcpy(DS18B20_string[i], "------");
  // Initialize DS18B20 devices (if enabled) 
  if (stored_config_settings & 0x08) {
    // Find all devices
    FindDevices();
    // Iniialize DS18B20 timer
    check_DS18B20_ctr = second_counter;
    // Collect initial temperature
    get_temperature();
    // Iniialize DS18B20 transmit control variable
    send_mqtt_temperature = 0;
  }

  // The following initializes the stack over-run guardband variables. These
  // variables are monitored periodically and should never change unless
  // there is a stack overflow (wherein the stack will over write this preset
  // content).
  stack_limit1 = 0xaa;
  stack_limit2 = 0x55;

  // Initialize mqtt client
  mqtt_init(&mqttclient,
            mqtt_sendbuf,
            sizeof(mqtt_sendbuf),
            &uip_buf[UIP_IPTCPH_LEN + UIP_LLH_LEN],
            UIP_APPDATA_SIZE,
            publish_callback);


#if DEBUG_SUPPORT == 2
// Check RST_SR (Reset Status Register)
// Important: Check the number of debug bytes in the current code revision
// and update the debug[] locations used so that they are within the range
// of the debug bytes. Search for the display routine and match it to these
// locations.
  if (RST_SR & 0x1f) {
    // Bit 4 EMCF: EMC reset flag
    // Bit 3 SWIMF: SWIM reset flag
    // Bit 2 ILLOPF: Illegal opcode reset flag
    // Bit 1 IWDGF: Independent Watchdog reset flag
    // Bit 0 WWDGF: Window Watchdog reset flag
    if (RST_SR & 0x10) debug[25] = (uint8_t)(debug[25] + 1);
    if (RST_SR & 0x08) debug[26] = (uint8_t)(debug[26] + 1);
    if (RST_SR & 0x04) debug[27] = (uint8_t)(debug[27] + 1);
    if (RST_SR & 0x02) debug[28] = (uint8_t)(debug[28] + 1);
    if (RST_SR & 0x01) debug[29] = (uint8_t)(debug[29] + 1);
    update_debug_storage1();
//    if (RST_SR & 0x16) {
//      // Trigger reboot LED signal on any except SWIMF
//      fastflash();
//      debugflash();
//      fastflash();
//      debugflash();
//      fastflash();
//      debugflash();
//      fastflash();
//    }
    RST_SR = (uint8_t)(RST_SR | 0x1f); // Clear the flags
  }
#endif // DEBUG_SUPPORT == 2


  while (1) {
    // Overview of the main loop:
    // - The ENC28J60 does the hardware level work of receiving ethernet
    //   packets. It receives ethernet traffic and, based on the MAC address
    //   in the incoming traffic, the ENC28J60 filters out all traffic except
    //   that traffic directed at the Network Module.
    //   - Enc28j60Receive(uip_buf) is called to receive a single packet from
    //     the ENC28J60 and copy it to the uip_buf. Additional packets may be
    //     queued in the ENC28J60 hardware, but packets are read and
    //     processed one at a time. When a packet is copied to the uip_buf
    //     the value uip_len is set to the size of the received data (total
    //     of LLH, IP and TCP headers plus the application data).
    //
    // - If a packet was received (uip_len > 0) and it is of type
    //   UIP_ETHTYPE_IP the packet is processed via uip_input().
    //   - uip_input() calls uip_process() to run the UIP functions. The UIP
    //     functions examine the IP and TCP headers (included in the data in
    //     the uip_buf) to extract the IP Address and Port Number from the
    //     incoming packet. The UIP functions will verify that the packet is
    //     for the Network Module.
    //   - If the packet is verified the UIP functions will use a UIP_APPCALL
    //     to call the uip_TcpAppHubCall function which will in turn use the
    //     Port Number to determine if the HTTP or MQTT application processes
    //     should be called to process the incoming packet TCP data.
    //   - If processing of the received packet results in data that is
    //     to be transmitted (as indicated by uip_len still > 0 after input
    //     processing) a uip_arp_out is run (to build the LLH) and the
    //     resulting packet is transferred to the ENC28J60 to be transmitted.
    //   - Note that the Transmit Buffer must include the LLH, IP and TCP
    //     headers. The UIP functions create the IP and TCP headers, and the
    //     uip_arp_out() function creates the LLH. The respective functions
    //     insert the headers in the uip_buf in preparation for transmission.
    //
    // - If the received packet is of type UIP_ETHTYPE_ARP a uip_arp_arpin()
    //   is called to process the ARP request.
    //   - If the uip_arp_arpin() results in a response to the requester (as
    //     indicated by uip_len > 0) the resulting packet is transferred to
    //     the ENC28J60 to be transmitted.
    //
    // - The MQTT startup steps are run. These steps will create a TCP
    //   connection to the MQTT Server and will initialize communication with
    //   the MQTT Broker.
    //
    // - The uip_periodic() function is called to transmit any asynchronous
    //   HTTP or MQTT data that may be pending (only one packet per pass of
    //   the main loop). Typically only MQTT generates asynchronous
    //   transmissions. Note that there WILL NOT be any receive data in the
    //   uip_buf when uip_periodic is called because the only point at which
    //   receive data is copied into the uip_buf is at the beginning of the
    //   while loop.
    //   - There is an additional check at the periodic_timer_expired()
    //     interval to determine if GPIO input changes need to generate an
    //     MQTT publish transmission.
    //
    // - The GPIO pins are checked to determine if any MQTT state change
    //   messages need to be queued.
    //
    // - The arp_timer_expired() function is called every 10 seconds to check
    //   if any ARP table entries are stale and need to be removed.
    //
    // - The check_runtime_changes() function is called to determine if any
    //   GUI inputs have been made or if any GPIO pins have changed which
    //   would affect the GUI display.
    //
    // - The check_reset_button() function is run to determine if the user is
    //   requesting a device reset.
    //
    // - If debug is enabled the update_debug_storage() function is called to
    //   store any debug information collected.

    IWDG_KR = 0xaa; // Prevent the IWDG hardware watchdog from firing. If the
                    // processor hangs the IWDG will perform a hardware reset.

    uip_len = Enc28j60Receive(uip_buf); // Check for incoming packets

    if (uip_len > 0) {
      // This code executed if incoming traffic is HTTP or MQTT (not ARP).
      // uip_len includes the headers, so it will be > 0 even if no TCP
      // payload.
      if (((struct uip_eth_hdr *) & uip_buf[0])->type == htons(UIP_ETHTYPE_IP)) {
        uip_input(); // Calls uip_process(UIP_DATA) to process a received
	// packet.
        // If the above process resulted in data that should be sent out on
	// the network the global variable uip_len will have been set to a
	// value > 0.
        if (uip_len > 0) {
          uip_arp_out();
          // The original uip code has a uip_split_output function. It is not
          // needed for this application due to small packet sizes, so the
          // Enc28j60 transmit functions are called directly.
          Enc28j60Send(uip_buf, uip_len);
        }
      }
      else if (((struct uip_eth_hdr *) & uip_buf[0])->type == htons(UIP_ETHTYPE_ARP)) {
        uip_arp_arpin();
        // If the above process resulted in data that should be sent out on
	// the network the global variable uip_len will have been set to a
	// value > 0.
        if (uip_len > 0) {
          // The original uip code has a uip_split_output function. It is not
          // needed for this application due to small packet sizes, so the
          // Enc28j60 transmit functions are called directly.
          Enc28j60Send(uip_buf, uip_len);
        }
      }
    }

    // Perform MQTT startup if 
    // a) MQTT is enabled
    // b) Not already at start complete
    // c) Not currently performing the restart steps
    // d) Not currently performing restart_reboot
    if (mqtt_enabled == 1
     && mqtt_start != MQTT_START_COMPLETE
     && mqtt_restart_step == MQTT_RESTART_IDLE
     && restart_reboot_step == RESTART_REBOOT_IDLE) {
       mqtt_startup();
    }
    
    // Perform MQTT sanity check if
    // a) MQTT is enabled
    // b) Not currently performing MQTT startup
    // c) Not currently performing restart_reboot
    if (mqtt_enabled == 1
     && mqtt_start == MQTT_START_COMPLETE
     && restart_reboot_step == RESTART_REBOOT_IDLE) {
      mqtt_sanity_check();
    }

    // Update the time keeping function
    timer_update();

    if (periodic_timer_expired()) {
      // The periodic timer expires every 20ms.
      for(i = 0; i < UIP_CONNS; i++) {
	uip_periodic(i);
	// uip_periodic() calls uip_process(UIP_TIMER) for each connection.
	// uip_process(UIP_TIMER) will check the HTTP and MQTT connections
	// for any unserviced outbound traffic. HTTP can have pending
	// transmissions because the web pages can be broken into several
	// packets. MQTT will always use this function to transmit packets.
	//
	// If uip_periodic() resulted in data that should be sent out on
	// the network the global variable uip_len will have been set to a
	// value > 0.
	//
	// Note that when the device first powers up and MQTT is enabled the
	// MQTT processes will attempt to send a SYN to create a TCP
	// connection. The uip_periodic() function discovers the SYN is
	// pending to be sent, causing uip_len to be > 0. Below you'll see
	// that uip_arp_out() is called first, and on the first pass it will
	// find that an ARP request is needed. The SYN will be replaced with
	// an ARP request, and on a future cycle through this routine the
	// SYN will be sent IF the ARP request was successful.
	// 
	if (uip_len > 0) {
	  uip_arp_out(); // Verifies arp entry in the ARP table and builds
	                 // the LLH
          Enc28j60Send(uip_buf, uip_len);
	}
      }
    }


    // Increment 100ms counters every 100ms
    if (t100ms_timer_expired()) {
      t100ms_ctr1++;     // Increment the 100ms counter. ctr1 is used in the
                         // restart/reboot process. Normally the counter is
			 // not used and will just roll over every 256
			 // counts. Any code that uses crt1 must reset it to
			 // zero then compare to a value needed for a
			 // timeout.			   
    }


    // If MQTT is enabled and connected check for pin state changes and
    // publish a message at 50ms intervals. publish_outbound only places the
    // message in the queue. uip_periodic() will cause the actual
    // transmission.
    if (mqtt_enabled == 1 && mqtt_outbound_timer_expired()) {
      if (mqtt_start == MQTT_START_COMPLETE) {
        publish_outbound();
      }
    }
    
    // If MQTT is enabled increment the MQTT timers every 100ms
    if (mqtt_enabled == 1 && mqtt_timer_expired()) {
      mqtt_start_ctr1++; // Increment the MQTT start loop timer 1. This is
                         // used to timeout the MQTT Server ARP request or
		         // the MQTT Server TCP connection request if the
		         // server is not responding.
      mqtt_start_ctr2++; // Increment the MQTT start loop timer 2. This is
                         // used to limit the rate at which timeouts occur
		         // in the MQTT Server connection requests.
      mqtt_sanity_ctr++; // Increment the MQTT sanity loop timer. This is
                         // used to provide timing for the MQTT Sanity
		         // Check function.			   
    }


    // Call the ARP timer function every 10 seconds.
    if (arp_timer_expired()) {
      uip_arp_timer(); // Clean out old ARP Table entries. Any entry that has
                       // exceeded the UIP_ARP_MAXAGE without being accessed
		       // is cleared. UIP_ARP_MAXAGE is typically 20 minutes.
    }


    // Update temperature data
    if ((stored_config_settings & 0x08) && (second_counter > (check_DS18B20_ctr + 30))) {
      check_DS18B20_ctr = second_counter;
//      get_temperature(15);
//      get_temperature(16);
      get_temperature();
      send_mqtt_temperature = 4; // Indicates that all 5 temperature sensors
                                 // need to be transmitted.
    }


    // Check for changes in Output control states, IP address, IP gateway
    // address, Netmask, MAC, and Port number.
    check_runtime_changes();
    
    // Check for the Reset button
    check_reset_button();

    // Check for Restart or Reboot request generated by the user pressing the
    // reset button or generated by the user making changes in the GUI that
    // require a restart or reboot.
    check_restart_reboot();
  }
  return 0;
}


// IP Address and MAC Address notes:
// The ENC28J60 device does not use the Network Module IP Address. The
// ENC28J60 communicates with the Ethernet using only the MAC address (known
// in the uIP as "ethernet address"). The IP Address is used only within the
// IP packets.
//
// Note that the ENC28J60 must be told what the MAC Network Module address
// is. But the ENC28J60 only uses the MAC address for receive filtering. The
// application (not the ENC28J60) must insert the MAC address as needed in
// any packets for transmission. This occurs in the uip.c and uip_arp.c
// functions.
//
// The application has hardcoded "factory defaults" for the IP Address,
// Gateway Address, Netmask, Port number, and MAC Address. The user is able
// to change any of these and the changes are stored in EEPROM. Thereafter
// the software uses the addresses from the EEPROM at power on so that user
// inputs are retained through power cycles.
//
// The user can press the Reset Button for 10 seconds to restore "factory
// defaults".


void mqtt_startup(void)
{
  // This function walks through the steps needed to get MQTT initialized and
  // a connection made to the MQTT Server and Broker
  // - These steps are run only once at code start, or when restarting the
  //   client.
  // - These steps cannot be run until the user has entered the MQTT settings
  //   in the GUI. The MQTT steps do the following:
  //   - Verifies that the user has provided a MQTT Server IP Address
  //   - Requests a TCP Connection with the MQTT Server. This process will
  //     also perform an ARP request with the MQTT server. Both requests
  //     occur via the uip_connect() function, and are executed via the
  //     uip_periodic function.
  //   - Verifies that the ARP request succeeded.
  //   - Verifies that the TCP connection request suceeded.
  //   - Initializes communication with the MQTT Broker.
  int8_t skip_auto_msg;
  unsigned char app_message[5];       // Stores the application message (the
                                      // payload) that will be sent in an
				      // MQTT message.
  
  switch(mqtt_start)
  {
  case MQTT_START_TCP_CONNECT:
    // When first powering up or on a reboot we need to initialize the MQTT
    // processes.
    //
    // A brand new device won't have a MQTT Server IP Address defined (as
    // indicated by an all zeroes address). So these steps won't be executed
    // unless a non-zero MQTT Server address is found. The user can input a
    // MQTT Server IP Address and Port number via the GUI. A restart will
    // automatically take place when the values are submitted in the GUI.
    //
    // The first step is to create a TCP Connection Request to the MQTT
    // Server. This is done with uip_connect(). uip_connect() doesn't
    // actually send anything - it just queues the SYN to be sent. The
    // connection request will actually be sent when uip_periodic is called.
    // uip_periodic will determine that the connection request is queued,
    // will perform an ARP request to determine the MAC of the MQTT server,
    // and will then send the SYN to start the connection process.
    mqtt_conn = uip_connect(&uip_mqttserveraddr, Port_Mqttd, Port_Mqttd);
    
    if (mqtt_conn != NULL) {
      mqtt_start_ctr1 = 0; // Clear 100ms counter
      mqtt_start_ctr2 = 0; // Clear 100ms counter
      mqtt_start_status = MQTT_START_CONNECTIONS_GOOD;
      mqtt_start = MQTT_START_VERIFY_ARP;
    }
    else {
      mqtt_start_status |= MQTT_START_CONNECTIONS_ERROR;
    }
    break;
      
  case MQTT_START_VERIFY_ARP:
     if (mqtt_start_ctr2 > 2) {
      // mqtt_start_ctr2 causes us to wait 300ms before checking to see if the
      // ARP request completed.
      mqtt_start_ctr2 = 0; // Clear 100ms counter
      // ARP Request and TCP Connection request were sent to the MQTT Server
      // as a result of the uip_connect() in the prior step. Now we loop and
      // check that the ARP request was successful.
      if (check_mqtt_server_arp_entry() == 1) {
        // ARP Reply received
        mqtt_start_ctr1 = 0; // Clear 100ms counter
        mqtt_start_status |= MQTT_START_ARP_REQUEST_GOOD;
        mqtt_start = MQTT_START_VERIFY_TCP;
      }
      else if (mqtt_start_ctr1 > 150) {
        // mqtt_start_ctr1 allows us to wait up to 15 seconds for the ARP
        // Reply. If timeout occurs we probably have an error in the MQTT
        // Server IP Address or there is a network problem. If we timeout
        // we start over and retry the ARP request.
        mqtt_start = MQTT_START_TCP_CONNECT;
        // Clear the error indicator flags
        mqtt_start_status = MQTT_START_NOT_STARTED;
      }
    }
    break;

  case MQTT_START_VERIFY_TCP:
    if (mqtt_start_ctr2 > 2) {
      mqtt_start_ctr2 = 0; // Clear 100ms counter
      // Loop to make sure the TCP connection request was successful. We're
      // waiting for the SYNACK/ACK process to complete (checking each 300ms).
      // uip_periodic() runs frequently (each time the periodic_timer expires).
      // When uip_periodic() runs it calls the uip_process() to receive the
      // SYNACK and then send the ACK. We will know the ACK was sent when we
      // see the UIP_ESTABLISHED state for the mqtt connection.
      if ((mqtt_conn->tcpstateflags & UIP_TS_MASK) == UIP_ESTABLISHED) {
        mqtt_start_ctr1 = 0; // Clear 100ms counter
        mqtt_start_status |= MQTT_START_TCP_CONNECT_GOOD;
        mqtt_start = MQTT_START_QUEUE_CONNECT;
      }
      else if (mqtt_start_ctr1 > 150) {
        // Wait up to 15 seconds for the TCP connection to complete. If not
        // completed we probably have a network problem.  Try again with a
        // new uip_connect().
        mqtt_start = MQTT_START_TCP_CONNECT;
        // Clear the error indicator flags
        mqtt_start_status = MQTT_START_NOT_STARTED; 
      }
    }
    break;
      
  case MQTT_START_QUEUE_CONNECT:
    if (mqtt_start_ctr2 > 2) {
      // ARP Reply received from the MQTT Server and TCP Connection
      // established.
      // We should now be able to message the MQTT Broker, but will wait
      // 300ms to give some start time.

      // Queue the mqtt_connect message for transmission to the MQTT Broker. 
      // The mqtt_connect function will create the message and put it in the
      // mqtt_sendbuf queue.
      // uip_periodic() will start the process that will call mqtt_sync to
      // copy the message from the mqtt_sendbuf to the uip_buf.
  
      // Create client_id with devicetype and MAC address
      strcpy(client_id_text, devicetype);
      // Remove trailing / in devicetype
      client_id_text[strlen(client_id_text) - 1] = '\0';
      // Add MAC number
      strcat(client_id_text, mac_string);
      client_id = client_id_text;
  
      // Ensure we have a clean session
      connect_flags = MQTT_CONNECT_CLEAN_SESSION;
 
      // Create will_topic
      strcpy(topic_base, devicetype);
      strcat(topic_base, stored_devicename);
      strcat(topic_base, "/availability");

      // Queue the message
      mqtt_connect(&mqttclient,
                   client_id,              // Based on MAC address
                   topic_base,             // Will topic
                   "offline",              // Will message 
                   7,                      // Will message size
                   stored_mqtt_username,   // Username
                   stored_mqtt_password,   // Password
                   connect_flags,          // Connect flags
                   mqtt_keep_alive);       // Ping interval
     
      // When a CONNECT is sent to the broker it should respond with a
      // CONNACK.
      connack_received = 0;
      mqtt_start_ctr1 = 0; // Clear 100ms counter
      mqtt_start = MQTT_START_VERIFY_CONNACK;
    }
    break;

  case MQTT_START_VERIFY_CONNACK:
    // Verify that the CONNECT CONNACK was received.
    // When a CONNECT is sent to the broker it should respond with a CONNACK.
    // Since the Broker won't send us anything else until this CONNACK occurs
    // this step waits for the CONNACK, but will timeout after X seconds. A
    // workaround is implemented with the global variable connack_received so
    // that the mqtt.c code can tell the main.c code that the CONNECT CONNACK
    // was received.
    // XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
    // On reboot I frequently see that we get to this point, a Connack is
    // sent to us, but we don't get a connack_received from the mqtt code.
    // I suspect the problem is that I'm not shutting down the mqtt code
    // properly, and the process steps here are seen as an error of some
    // kind. When this happens a timeout occurs below, and the next pass is
    // always successful. There must be a better solution. NEED TO COME BACK
    // TO THIS. Maybe look more closely at the state of mqtt variables on
    // a clean start vs a reboot.
    // XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX

    if (mqtt_start_ctr1 < 30) {
      // Allow up to 3 seconds for CONNACK
      if (connack_received == 1) {
        mqtt_start_ctr2 = 0; // Clear 100ms counter
        mqtt_start_status |= MQTT_START_MQTT_CONNECT_GOOD;
        mqtt_start = MQTT_START_QUEUE_SUBSCRIBE1;
      }
    }
    else {
      mqtt_start = MQTT_START_TCP_CONNECT;
      // Clear the error indicator flags
      mqtt_start_status = MQTT_START_NOT_STARTED; 
    }
    break;

  case MQTT_START_QUEUE_SUBSCRIBE1:
    if (mqtt_start_ctr2 > 2) {
      // Subscribe to the output control messages
      //
      // Queue the mqtt_subscribe messages for transmission to the MQTT Broker.
      // Wait 300ms before queueing first Subscribe msg.
      //
      // The mqtt_subscribe function will create the message and put it in the
      // transmit queue. uip_periodic() will start the process that will call
      // mqtt_sync to put the message in the uip_buf.
      
      // XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
      // I find that I can't queue multiple subscribe messages without them
      // taking 10's of seconds to complete. Had this same problem with
      // publish messages. I think something is wrong with the LiamBindle
      // transmit queueing, or my interface to it. The quickest solution for
      // now is to queue a message, return to the main loop so it can
      // transmit, then queue another message.
      // XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
	
      strcpy(topic_base, devicetype);
      strcat(topic_base, stored_devicename);
      strcat(topic_base, "/output/+/set");
      mqtt_subscribe(&mqttclient, topic_base);
      mqtt_start_ctr2 = 0; // Clear 100ms counter
      mqtt_start = MQTT_START_QUEUE_SUBSCRIBE2;
    }
    break;
    
  case MQTT_START_QUEUE_SUBSCRIBE2:
    if (mqtt_start_ctr2 > 2) {
      // Subscribe to the state-req message
      //
      // Wait 100ms before queuing the Subscribe message 
      strcpy(topic_base, devicetype);
      strcat(topic_base, stored_devicename);
      strcat(topic_base, "/state-req");
      mqtt_subscribe(&mqttclient, topic_base);
      mqtt_start_ctr2 = 0; // Clear 100ms counter
      if (stored_config_settings & 0x02) {
        // Home Assistant Auto Discovery enabled
        mqtt_start = MQTT_START_QUEUE_PUBLISH_AUTO;
        auto_pub_count = 0;
      }
      else {
        mqtt_start = MQTT_START_QUEUE_PUBLISH_ON;
      }
    }
    break;

  case MQTT_START_QUEUE_PUBLISH_AUTO:
    if (mqtt_start_ctr2 > 0) {
// if (auto_pub_count == 0) fastflash();
      // Publish Home Assistant Auto Discovery messages
      // This step of the state machine is entered multiple times until all
      // Publish messages are sent. The variable auto_pub_count is used to
      // determine when all messages are sent.
      //
      //---------------------------------------------------------------------//
      // This function will create a "placeholder" Publish message. The
      // "placeholder" message contains special markers that need to be
      // replaced later with more extensive text fields required in the
      // actual Publish message. The mqtt_pal.c function will detect the
      // "placeholder" Publish message during the "copy to uip_buf" process
      // and will replace the special markers at that time to create the
      // actual Publish message required by Home Assistant. This complication
      // is necessary because the MQTT transmit buffer is not large enough to
      // contain an entire Auto Discovery Publish message, so it is
      // constructed on-the-fly as the app_message is written to the uip_buf
      // transmit buffer by the mqtt_pal.c function.
      //
      // This "placeholder" Publish message will create an Output Auto
      // Discovery message. "xx" is the output IO number.
      //    mqtt_publish(&mqttclient,
      //                 topic_base,
      //                 "%Oxx",
      //                 4,
      //                 MQTT_PUBLISH_QOS_0 | MQTT_PUBLISH_RETAIN);
      //
      // This "placeholder" Publish message will create an Input Auto
      // Discovery message. "xx" is the input IO number.
      //    mqtt_publish(&mqttclient,
      //                 topic_base,
      //                 "%Ixx",
      //                 4,
      //                 MQTT_PUBLISH_QOS_0 | MQTT_PUBLISH_RETAIN);
      //
      // This "placeholder" Publish message will create a Temperature
      // Sensor Auto Discovery message. "xx" is the input IO number.
      //    mqtt_publish(&mqttclient,
      //                 topic_base,
      //                 "%Txx",
      //                 4,
      //                 MQTT_PUBLISH_QOS_0 | MQTT_PUBLISH_RETAIN);
      //---------------------------------------------------------------------//

      // Walk through the pin_control bytes and send an Auto Discovery
      // Publish message for every pin as follows:
      //   For every pin that is an Enabled Output an Output Config message
      //     is sent with a defining payload.
      //   For every pin that is an Enabled Input an Input Config message
      //     is sent with a defining payload.
      //   For pin 16: If DS18B20 is enabled a Temperature Sensor Config
      //     message is sent with a defining payload.
      //
      //   For every pin that is an Input an Output Config message is sent
      //     with an empty payload (to make sure any prior Output definition
      //     for the pin is removed in Home Assistant).
      //   For pin 16: If the pin is an Input then a Temperature Sensor
      //     Config message is sent with an empty payload (to make sure any
      //     prior Temparuture Sensor definition for the pin is removed in
      //     Home Assistant).
      //
      //   For every pin that is an Output an Input Config message is sent
      //     with an empty payload (to make sure any prior Input definition
      //     for the pin is removed in Home Assistant).
      //   For pin 16: If the pin is an Output a Temperature Sensor Config
      //     message is sent with an empty payload (to make sure any prior
      //     Temparuture Sensor definition for the pin is removed in Home
      //     Assistant).
      //
      //   For pin 16: If DS18B20 is enabled, every pin that is a Temperature
      //     Sensor is sent an Output Config message with an empty payload
      //     (to make sure any prior Output definition for the pin is removed
      //     in Home Assistant).
      //   For pin 16: If DS18B20 is enabled, every pin that is a Temperature
      //     Sensor is sent an Input Config message with an empty payload (to
      //     make sure any prior Input definition for the pin is removed in
      //     Home Assistant).
      //

      skip_auto_msg = 0;

      if (auto_pub_count < 16) {
        // Pins 1 to 15 each require two Config messages. One to send the pin
        // definition, and another with a blank payload to make sure any
	// prior definition is deleted.
	//XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
	//XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
	//XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
	//XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
	// Pin 16 requires three Config messages. One to send the pin
	// definition, and two more to make sure any prior definition is
	// removed.
    
        // Create pin number for topic and payload in text format.
        emb_itoa((auto_pub_count + 1), OctetArray, 10, 2);
        // Create the payload template. Note the payload may be changed to
	// empty for some cases.
        // Create % part of payload template
        app_message[0] = '%';
        // Add pin number to payload template
        app_message[2] = OctetArray[0];
        app_message[3] = OctetArray[1];
        app_message[4] = '\0';
        
        //-------------------------------------------------------------------//
	// In the next code the variable auto_pub_toggle is used to allow
	// three passes through this part of the state machine for each
	// pin. This is necessary because each pin requires multiple Config
	// messages to perform all the Config define and Config delete
	// steps ... but we can only send one message per pass of the
	// state machine.
	//
	// If pin is disabled send both an "input delete" and "output delete"
	// message. Then send a Temperature Sensor definition message if
	// needed.
        if (!(pin_control[auto_pub_count] & 0x01)) {
          // Pin is disabled.
          if (auto_pub_toggle == 0) {
            // Send a Output pin delete msg.
            // Create first part of topic
            strcpy(topic_base, "homeassistant/switch/");
   	    // Payload is blank for delete pin msg
            app_message[0] = '\0';
          }
          else if (auto_pub_toggle == 1) {
 	    // Next send an Input pin delete msg.
 	    // Create first part of topic
            strcpy(topic_base, "homeassistant/binary_sensor/");
   	    // Payload is blank for delete pin msg
            app_message[0] = '\0';
	  }
          else if (auto_pub_toggle <= 6) {
	    // In this phase where auto_pub_toggle equals 2, 3, 4, 5, or 6
	    // If:
	    //   Pin number 16 is being serviced
	    //   AND
	    //   DS18B20 mode is Enabled
	    //   Then we will send a Temperature Sensor definition message
	    //   for each sensor 1, 2, 3, 4 and 5 if that sensor exists (as
	    //   indicated by the numROMs variable).
	    //   Note: The variable numROMs is actually the index into the
	    //   Found_ROM table. Thus the numROMs value starts at 0 (for
	    //   the first sensor), 1 for the second sensor, and so on.
	    // Else:
	    //   Set skip_auto_msg = 1 so no Publish is sent. Note that we
	    //   will still pass through this step 5 times even if we skip
	    //   the Publish each time.
            if ((stored_config_settings & 0x08)
             && (auto_pub_count == 15)
	     && ((auto_pub_toggle - 2) <= numROMs)) {
              // If the test is true this pin is being used for Temperature
	      // Sensors. If no sensors were detected numROMs will be -1 and
	      // we will go on to the "else" statement (and thus will not
	      // create a Config message).
	      // If there is at least one sensor detetected numROMs will be
	      // zero or greater. In that case send the sensor definition as
	      // a Config message.
	      // Note that if we are creating a Config message we need to
	      // replace the "pin" number with the "sensor number" in human
	      // readable format. This needs to occur both in the Config
	      // topic AND in the Config payload.
	      // Internal to code sensors are numbered 0 to 4, but they need
	      // to be displayed as 1 to 5. "auto_pub_toggle - 2" is the
	      // internal numbering, so "auto_pub_toggle - 1" is the human
	      // readable numbering. Also note that the human readable number
	      // is in the format 01, 02, etc ... so the first digit is
	      // always '0'.
	      
	      // Create the sensor number (to replace the pin number) for the
	      // topic.
              emb_itoa((auto_pub_toggle - 1), OctetArray, 10, 2);
	      
	      // Create the sensor number (to replace the pin number) for the
	      // payload.
              app_message[2] = '0';
              app_message[3] = (uint8_t)('0' + (auto_pub_toggle - 1));
	      
              // Create first part of topic
              strcpy(topic_base, "homeassistant/sensor/");
              // Create the T part of the payload
              app_message[1] = 'T';
            }
	    else {
	      skip_auto_msg = 1;
	      // Bump up the auto_pub_toggle counter so we don't repeat this
	      // loop unnecessarily.
	      auto_pub_toggle = 6;
	    }
	  }
          auto_pub_toggle++;
        }
      
	// If pin is an Enabled Output send an Output definition message AND
	// an "input delete" message AND if the pin number is 16 send 
	// "temperature sensor delete" messages.
        if ((pin_control[auto_pub_count] & 0x01)
         && (pin_control[auto_pub_count] & 0x02)) {
          if (auto_pub_toggle == 0) {
            // Pin is an Enabled Output. First send the pin definition.
            // Create first part of topic
            strcpy(topic_base, "homeassistant/switch/");
    	    // Create the O part of the payload
            app_message[1] = 'O';
          }
          else if (auto_pub_toggle == 1) {
  	    // Next send an Input pin delete msg.
  	    // Create first part of topic
            strcpy(topic_base, "homeassistant/binary_sensor/");
    	    // Payload is blank for delete pin msg
            app_message[0] = '\0';
  	  }
          else if (auto_pub_toggle <= 6) {
 	    // In this phase where auto_pub_toggle equals 2, 3, 4, 5, or 6
	    // If:
	    //   Pin number 16 is being serviced
	    //   Then we will send a Temperature Sensor delete message for
	    //   each sensor 1, 2, 3, 4 and 5 regardless of whether the
	    //   sensor exists.
	    // Else:
	    //   Set skip_auto_msg = 1 so no Publish is sent. Note that we
	    //   will still pass through this step 5 times even if we skip
	    //   the Publish each time.
            if (auto_pub_count == 15) {
	    // XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
	    // XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
	    // XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
	    // XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
	    // XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
	      // Note that we need to replace the "pin"
	      // number with the sensor number (which happens to equal
	      // (auto_pub_toggle - 2). Also note that the sensor number
	      // is always '0' plus the alpha digit for the sensor number.
              app_message[2] = '0';
              app_message[3] = (uint8_t)('0' + (auto_pub_toggle - 2));
  	      // Create first part of topic
              strcpy(topic_base, "homeassistant/sensor/");
    	      // Payload is blank for delete msg
              app_message[0] = '\0';
	    }
	    else {
	      skip_auto_msg = 1;
	      // Bump up the auto_pub_toggle counter so we don't repeat this
	      // loop unnecessarily.
	      auto_pub_toggle = 6;
	    }
  	  }
          auto_pub_toggle++;
        }
      
	// If pin is an Enabled Input send an Input definition message AND an
	// "output delete" message AND if the pin number is 16 send a
	// "temperature sensor delete" message.
        if ((pin_control[auto_pub_count] & 0x01)
         && (!(pin_control[auto_pub_count] & 0x02))) {
          if (auto_pub_toggle == 0) {
            // Pin is an Enabled Input. First send the pin definition.
	    // Create first part of topic
            strcpy(topic_base, "homeassistant/binary_sensor/");
  	    // Create the I part of the payload
            app_message[1] = 'I';
          }
          else if (auto_pub_toggle == 1) {
	    // Next send an Output pin delete msg.
	    // Create first part of topic
            strcpy(topic_base, "homeassistant/switch/");
  	    // Payload is blank for delete pin msg
            app_message[0] = '\0';
	  }
          else if (auto_pub_toggle <= 6) {
 	    // In this phase where auto_pub_toggle equals 2, 3, 4, 5, or 6
	    // If:
	    //   Pin number 16 is being serviced
	    //   Then we will send a Temperature Sensor delete message
	    //   for each sensor 1, 2, 3, 4 and 5 regardless of whether the
	    //   sensor exists.
	    // Else:
	    //   Set skip_auto_msg = 1 so no Publish is sent. Note that we
	    //   will still pass through this step 5 times even if we skip
	    //   the Publish each time.
            if (auto_pub_count == 15) {
	    // XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
	    // XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
	    // XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
	    // XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
	      // Note that we need to replace the "pin"
	      // number with the sensor number (which happens to equal
	      // (auto_pub_toggle - 2). Also note that the sensor number
	      // is always '0' plus the alpha digit for the sensor number.
              app_message[2] = '0';
              app_message[3] = (uint8_t)('0' + (auto_pub_toggle - 2));
  	      // Create first part of topic
              strcpy(topic_base, "homeassistant/sensor/");
    	      // Payload is blank for delete msg
              app_message[0] = '\0';
	    }
	    else {
	      skip_auto_msg = 1;
	      // Bump up the auto_pub_toggle counter so we don't repeat this
	      // loop unnecessarily.
	      auto_pub_toggle = 6;
	    }
  	  }
          auto_pub_toggle++;
        }
        //-------------------------------------------------------------------//
        
	if (!(skip_auto_msg)) {
          // Create the rest of the topic
          strcat(topic_base, mac_string);
          strcat(topic_base, "/");
          strcat(topic_base, OctetArray);
          strcat(topic_base, "/config");
          mqtt_publish(&mqttclient,
                      topic_base,
                      app_message,
                      strlen(app_message),
                      MQTT_PUBLISH_QOS_0 | MQTT_PUBLISH_RETAIN);
	}
		     
        if (auto_pub_toggle == 7) {
          auto_pub_toggle = 0;
	  auto_pub_count++;
	}
        mqtt_start_ctr2 = 0;
        if (auto_pub_count == 16) mqtt_start = MQTT_START_QUEUE_PUBLISH_ON;
      }
    }
    break;

  case MQTT_START_QUEUE_PUBLISH_ON:
    if (mqtt_start_ctr2 > 2) {
      // Wait 300ms before queuing Publish message 
      // Publish the availability "online" message
      strcpy(topic_base, devicetype);
      strcat(topic_base, stored_devicename);
      strcat(topic_base, "/availability");
      mqtt_publish(&mqttclient,
                   topic_base,
                   "online",
                   6,
                   MQTT_PUBLISH_QOS_0 | MQTT_PUBLISH_RETAIN);
      // Indicate succesful completion
      mqtt_start_ctr2 = 0;
      mqtt_start = MQTT_START_QUEUE_PUBLISH_PINS;
    }
    break;
  
  case MQTT_START_QUEUE_PUBLISH_PINS:
    if (mqtt_start_ctr2 > 2) {
      // Wait 300ms before starting
      // Publish the state of all pins one at a time.
      // This is accomplished by setting ON_OFF_word_sent to the inverse of
      // whatever is currently in ON_OFF_word. This will cause the normal
      // checks for pin state changes to trigger a transmit for every pin.
      ON_OFF_word_sent = (uint16_t)(~ON_OFF_word);
      // Indicate succesful completion
      mqtt_start = MQTT_START_COMPLETE;
    }
    break;
  } // end switch
}


void mqtt_sanity_check(void)
{
  // This is similar to a firmware restart except it is focused on restarting
  // only the MQTT components.  The process is triggered every XX seconds IF
  // we don't have an MQTT connection.
  //
  // Check the MQTT connection. This is limited to once every X seconds to
  // reduce the processing consumed by restart attempts.
  //
  // Once triggered the sanity_check() function will cause the mqtt_startup()
  // function to be called from the main loop which will reset the backoff if
  // successful.

  switch(mqtt_restart_step)
  {
  case MQTT_RESTART_IDLE:
    // Check for a response timeout.
    // response_timeout is typically 30 seconds, and for a sanity check we
    // are allowing X timeouts before taking action. See the mqtt.c code.
    // Note that the Broker ping timeout may be shorter than this response
    // timeout. If the Broker times out first it will disconnect from this
    // device. That should not cause a problem.
    if (mqttclient.number_of_timeouts > 1) {
      // Reset the timeout counter
      mqttclient.number_of_timeouts = 0;
      MQTT_resp_tout_counter++;
      mqtt_restart_step = MQTT_RESTART_BEGIN;
    }

    // Check for a graceful shutdown of the MQTT Broker, and/or a disconnect
    // commanded by the broker (possibly the result of response timeout
    // caused from this module). If this happens we'll be in the
    // MQTT_START_COMPLETE state and we'll see a UIP_CLOSED. If this
    // condition occurs it may persist for a long time.
    if (mqtt_start == MQTT_START_COMPLETE
     && mqtt_conn->tcpstateflags == UIP_CLOSED) {
      MQTT_broker_dis_counter++;
      mqtt_restart_step = MQTT_RESTART_BEGIN;
    }
  
    // Check for an MQTT error
    // != MQTT_OK needs to be qualified with MQTT_START_COMPLETE because a
    // not OK condition can be present prior to mqtt_connect() running.
    if (mqtt_start == MQTT_START_COMPLETE
     && mqttclient.error != MQTT_OK) {
      MQTT_not_OK_counter++;
      mqtt_restart_step = MQTT_RESTART_BEGIN;
    }
    break;

  case MQTT_RESTART_BEGIN:
    // MQTT restart process triggered. The process:
    // 1) Sends an mqtt disconnect just in case there is a connection.
    // 2) Closes the TCP connection.
    // 3) Return to the main loop so that the MQTT start process can run.
    // This process sets up the first two events, but the main.c loop must
    // run so that the uip_periodic() and uip_input() functions will carry
    // out execution of the transmit and receive steps needed.
    mqtt_restart_step = MQTT_RESTART_DISCONNECT_START;
    // Clear the start error indicator flags so the GUI will reflect
    // that we are no longer in a connected state
    mqtt_start_status = MQTT_START_NOT_STARTED;
    break;
      
  case MQTT_RESTART_DISCONNECT_START:
    mqtt_restart_step = MQTT_RESTART_DISCONNECT_WAIT;
    // Disconnect the MQTT client
    mqtt_disconnect(&mqttclient);
    mqtt_sanity_ctr = 0; // Clear 100ms counter
    break;
  
  case MQTT_RESTART_DISCONNECT_WAIT:
    if (mqtt_sanity_ctr > 10) {
      // The mqtt_disconnect() is given 1 second to be communicated before
      // we move on to TCP close
      mqtt_restart_step = MQTT_RESTART_TCPCLOSE;
    }
    break;

  case MQTT_RESTART_TCPCLOSE:
    // The way a TCP connection close SHOULD work:
    // 1) A uip_periodic() runs and uip_process(UIP_TIMER) is called
    // 2) If a connection is in the ESTABLISHED state (meaning a TCP
    //    connection is open) the uip_process() will make a UIP_APPCALL.
    // 3) UIP_APPCALL calls the MQTT or HTTP application via
    //    uip_TcpAppHubCall()
    // 4) Before the application returns, if it wants to close the
    //    connection, it should call uip_close()
    // 5) The UIP code will then go to appsend: and will know to start
    //    the TCP close process.
    // So, it looks like all I need to do is make sure the APPCALL performs
    // a uip_close() before returning to the UIP code. Then the regular
    // uip_periodic() process should get the job done.
    //
    // Signal uip_TcpAppHubCall() to close the TCP connection
    mqtt_close_tcp = 1;
    // Capture time to delay the next step
    mqtt_sanity_ctr = 0; // Clear 100ms counter
    mqtt_restart_step = MQTT_RESTART_TCPCLOSE_WAIT;
    break;
  
  case MQTT_RESTART_TCPCLOSE_WAIT:
    // Verify closed ... how?
    // For the moment I'm not sure how to do this, so I will just allow
    // enough time for it to happen. That is probably very fast, but I will
    // allow 2 seconds.
    if (mqtt_sanity_ctr > 20) {
      mqtt_close_tcp = 0;
      mqtt_restart_step = MQTT_RESTART_SIGNAL_STARTUP;
    }
    break;
    
  case MQTT_RESTART_SIGNAL_STARTUP:
    // Reinitialize the mqtt client
    mqtt_init(&mqttclient,
              mqtt_sendbuf,
	      sizeof(mqtt_sendbuf),
	      &uip_buf[UIP_IPTCPH_LEN + UIP_LLH_LEN],
	      UIP_APPDATA_SIZE,
	      publish_callback);
    // Set mqtt_restart_step and mqtt_start to re-run the MQTT connection
    // steps in the main loop
    mqtt_restart_step = MQTT_RESTART_IDLE;
    mqtt_start = MQTT_START_TCP_CONNECT;
    break;
    
  } // end switch
}


//---------------------------------------------------------------------------//
  // Note that the original LiamBindle MQTT-C code relied on Linux or
  // Microsoft OS processes to provide Link Level, IP, and TCP processing of
  // received and transmitted packets (via a Socket). In this bare metal
  // application the UIP code provides that processing.
  //
  // Before making an mqtt connection we need the equivalent of an OS "open a
  // socket" to the MQTT Server. This is essentially an ARP request
  // associating the MQTT Server IP Address (which we got from GUI input)
  // with the MQTT Server MAC Address, followed by creating a TCP Connection
  // (via uip_connect()).
  //
  // For reference: In the HTTP IO process "opening a socket" occurs in the
  // uip_input and uip_arpin functions. HTTP has the notion that a browser
  // makes a request, and the web server replies to that request, always in a
  // one-to-one relationship. When a browser on a remote host makes a request
  // to our IP address the remote host performs an ARP request (which we
  // process via the uip_arp_arpin() function). Net result is that this
  // establishes the equivalent of a "socket" with the web server on our
  // device. Subsequent browser requests cause the uip_input() function to
  // extract the IP Addresses and Port Numbers for the HTTP transaction
  // source and destination and uses those to form the needed IP and TCP
  // headers for any transmission that needs to occur. Next the uip_arp_out
  // function is called to form a LLH header (containing the source and
  // destination MAC addresses) for the packet to be transmitted.
  // 
  // The bare metal UIP application uses the same buffer for receive and
  // transmit data (the uip_buf). But the original LiamBindle MQTT-C
  // application expects an independent transmit buffer where it maintains
  // transmit queueing information AND its transmit data. The MQTT transmit
  // buffer (mqtt_sendbuf) retains transmitted messages (queue info + data)
  // for a short time in case error recovery needs to re-transmit it. When it
  // is time to actually transmit data from the mqtt_sendbuf the data is
  // copied to the uip_buf, uip_len is set > 0, and the UIP code will perform
  // the transmission as part of the uip_periodic function.
  //
  // Maximum size of an MQTT packet (what will appear in the uip_buf) is:
  //   LLH (14 bytes)
  //   IP Header (20 bytes)
  //   TCP Header (20 bytes)
  //   MQTT Publish Payload (max 52 bytes - see below)
  //   Total: 106 bytes
  //
  // Output PUBLISH Msg (in the mqtt_sendbuf)
  //   Fixed Header 2 bytes
  //   Variable Header 43 bytes
  //     Topic NetworkModule/DeviceName012345678/off01 39 bytes
  //     Topic Length 2 bytes
  //     Packet ID 2 bytes
  //   Total: 45 bytes
  //
  // Status PUBLISH Msg (in the mqtt_sendbuf)
  //   Fixed Header 2 bytes
  //   Variable Header 57 bytes
  //     Topic NetworkModule/DeviceName123456789/availabilityoffline 53 bytes
  //     Topic Length 2 bytes
  //     Packet ID 2 bytes
  //   Total: 57 bytes
  //   
  // All Subscribe Msg (in the mqtt_sendbuf)
  //   Fixed Header 2 bytes
  //   Variable Header 40 bytes
  //     Topic NetworkModule/DeviceName012345678/# 35 bytes
  //     Topic Length 2 bytes
  //     Packet ID 2 bytes
  //     QOS 1 byte
  //   Total: 42 bytes
  //
  // If 200 bytes are allocated for the mqtt_sendbuf it can hold 4 to 20
  // queued MQTT messages. We need to make sure we stay within the bounds
  // of the mqtt_sendbuf or messages will be lost.
  //
//---------------------------------------------------------------------------//


void publish_callback(void** unused, struct mqtt_response_publish *published)
{
  char* pBuffer;
  uint8_t pin_value;
  uint8_t ParseNum;
//  uint8_t i;
  int i;
  
  pin_value = 0;
  ParseNum = 0;
  
  // This function will be called if a "publish" is received from the Broker.
  // The publish message will contain a payload that, in this application,
  // will be the output control bits.
  //
  // This function is called from within the mqtt_recv() function. The data
  // left in the uip_buf will remain there until this function completes.
  //
  // Dissecting the Publish message:
  // - We know that the MQTT Headers + Payload starts at pointer uip_appdata
  // - We know that the Fixed Header is 2 bytes
  // - Next comes the Variable Header
  //   - First bytes contain the Topic Name. So we should expect:
  //     - "NetworkModule/"
  //     - "Devicename/"
  //     - "output/"
  //     - "xx/" (output number or 'all')
  //     - "set"
  //   OR
  //     - "NetworkModule/"
  //     - "Devicename/"
  //     - "state-req"
  // - Next comes the Payload
  //   - If "Output/xx/set" we expect a payload of "ON" or "OFF"
  //   - if "Output/all/set" we expect a payload of "ON" or "OFF"
  //   - If "state-req" we expect no payload
  // - We are QOS 0 so no Packet ID
  //
  // Once we collect the above information:
  // - Set or clear an individual pin
  //   OR
  // - Loop to set or clear "all" pins
  //   OR
  // - Set the state_request variable
  pBuffer = uip_appdata;
  // Skip the Fixed Header Control Byte (1 byte)
  // Skip the Fixed Header Remaining Length Byte (1 byte)
  // Skip the Topic name length bytes (2 bytes)
  // Skip the NetworkModule/ text (14 bytes)
//  pBuffer = pBuffer + 18;
  pBuffer += 18;
  // Skip the Devicename/ text
//  pBuffer = pBuffer + strlen(stored_devicename) + 1;
  pBuffer += strlen(stored_devicename) + 1;
  
  // Determine if the sub-topic is "output" or "state-req"
  if (*pBuffer == 'o') {
    // "output" detected
    // Format can be any of these:
    //   output/01/setON
    //   output/01/setOFF
    //   output/all/setON
    //   output/all/setOFF
    //
    // Skip past the "output/" characters
    pBuffer+= 7;
    
    // Check if output field is "all". If so, update all output 
    // pin_control bytes to ON or OFF 
    if (*pBuffer == 'a') {
      // Determine if payload is ON or OFF
      pBuffer+=8;
      if (*pBuffer == 'N') {
        // Turn all outputs ON
	for (i=0; i<16; i++) {
	  if (pin_control[i] & 0x02) { // Output pin?
	    Pending_pin_control[i] = (uint8_t)(pin_control[i] | 0x80);
	  }
	}
      }
      else {
        // Turn all outputs OFF
	for (i=0; i<16; i++) {
	  if (pin_control[i] & 0x02) { // Output pin?
	    Pending_pin_control[i] = (uint8_t)(pin_control[i] & ~0x80);
	  }
	}
      }
    }
    
    else if (*pBuffer == '0' || *pBuffer == '1') {
      // Output field is a digit
      // Collect the IO number
      // Parse ten's digit
      ParseNum = (uint8_t)((*pBuffer - '0') * 10);
      pBuffer++;
      // Parse one's digit
      ParseNum += (uint8_t)(*pBuffer - '0');
      // Verify ParseNum is in the correct range
      if (ParseNum > 0 && ParseNum < 17) {
        // Adjust Parsenum to match 0 to 15 numbering (instead of 1 to 16)
        ParseNum--;
	// Determine if payload is ON or OFF
	pBuffer+=6;
	if (*pBuffer == 'N') {
	  // Turn output ON (and make sure it is an output)
	  if (pin_control[ParseNum] & 0x02 == 0x02) // Output pin?
	    Pending_pin_control[ParseNum] |= (uint8_t)0x80;
	}
	if (*pBuffer == 'F') {
	  // Turn output OFF (and make sure it is an output)
	  if (pin_control[ParseNum] & 0x02 == 0x02) // Output pin?
	    Pending_pin_control[ParseNum] &= (uint8_t)~0x80;
	}
      }
    }
    // The above code effectively did for MQTT what the POST parsing does for
    // HTML (changed the pin_control byte). So we need to set the 
    // mqtt_parse_complete value so that the check_runtime_changes() function
    // will perform the necessary IO actions.
    mqtt_parse_complete = 1;
  }
  
  // Determine if the sub-topic is "state-req".
  else if (*pBuffer == 's') {
    // "state-req" detected
    // Format is:
    //   state-req
    pBuffer += 8;
    if (*pBuffer == 'q') {
      *pBuffer = '0'; // Destroy 'q' in buffer so subsequent "state"
                      // messages won't be misinterpreted
		      // XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
		      // WARNING: To save flash space I don't check every
		      // sub-topic character. But I also don't clear the
		      // uip_buf. So, I could pick up on stuff left by a
		      // prevous message if not careful. In this limited
		      // application I can get away with it, but this can
		      // trip me up in the future if more messages are
		      // added.
		      // XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
      state_request = STATE_REQUEST_RCVD;
    }
  }
  // Note: if none of the above matched the parsing we just exit without
  // executing any functionality (the message is effecftively ignored).
}


void publish_outbound(void)
{
  // This function checks for a change on any pin (Output or Sense
  // Input) and PUBLISHes state messages to the Broker if a pin state changed.
  // The function also checks for a state_request and sends the 2 byte "all
  // pin states" message as a response.
  //
  // Something I don't understand and have mentioned elsewhere: Queueing
  // multiple PUBLISH messages doesn't work. I have to get any PUBLISH
  // message placed in the queue completely transmitted before I can queue
  // another. On the other hand we are so constrained by lack of RAM that we
  // couldn't queue more than 3 or 4 publish messages anyway, so an
  // alternative is necessary.
  //
  // The workaround implemented is to queue one message, return to the main
  // loop to let it transmit, then come back here and queue the next message.
  // But this means we need to track the input pin changes differently. For
  // instance, if more than one pin changes at a time, but we can only send
  // the message for one pin at a time, we need to track what was sent.
  //
  // The way the implementation tracks the pin changes that were sent (or not
  // yet sent) is to xor the ON_OFF_word with what was previously sent
  // (contained in ON_OFF_word_sent). This provides a pin by pin indication
  // of what has changed since the last publish.
  //
  // Note that if the high order bits were to keep changing very quickly the
  // code might not get to the low order bits as often. This is a flaw but
  // may not matter much in this application. The code only checks and sends
  // a message at the periodic_timer_expired(), thus it takes 16 expirations
  // to get all bits sent, and frequent changes in higher order bits will
  // supersede the processing of lower order bits.
  
  uint16_t xor_tmp;
//  uint8_t i;
  int i;
  uint16_t j;

  if (state_request == STATE_REQUEST_IDLE) {
    // XOR the current ON_OFF_word with the ON_OFF_word_sent (_sent being the
    // pin states we already transmitted via MQTT). This gives a result that
    // has a 1 for any pin state that still needs to be transmitted.
    xor_tmp = (uint16_t)(ON_OFF_word ^ ON_OFF_word_sent);
    
    i = 15;
    j = 0x8000;
    while ( 1 ) {

      // Check if DS18B20 is enabled, and if yes check if a temperature
      // Publish needs to occur.
      if (stored_config_settings & 0x08) { // DS18B20 enabled?
        if (j == 0x8000) { // Servicing pin 16?
	  if (send_mqtt_temperature >= 0) {
	    publish_temperature(send_mqtt_temperature);
	    send_mqtt_temperature--;
	    break;
	  }
	}
      }

      // Scan xor_temp for IOs that have changed.
      if (xor_tmp & j) {
        // Note that any pin reassigned to a DS18B20 can be scanned
	// without harm - its pin_control ON/OFF will never change.
	//
	// If a pin is an Enabled Output and its ON/OFF state changed
	// a Publish needs to occur.
	
	if (pin_control[i] & 0x01) { // enabled
          if (pin_control[i] & 0x02) publish_pinstate('O', (uint8_t)(i+1), ON_OFF_word, j);
          else                       publish_pinstate('I', (uint8_t)(i+1), ON_OFF_word, j);
          // Update the "sent" pin state information so that the bit
          // in ON_OFF_word_sent matches the bit in ON_OFF_word for the
          // pin just transmitted. This will indicate it was already sent.
          if (ON_OFF_word & j) ON_OFF_word_sent |= j;
          else ON_OFF_word_sent &= (uint16_t)~j;
	  // Break out of the while loop, as we can only send one Publish
	  // message per pass.
	  break;
	}
	
	else {
	  // Pin is not enabled so no Publish was required.
          // Update the "sent" pin state information so that the bit in
          // ON_OFF_word_sent matches the bit in ON_OFF_word for the pin
          // just examined. This will inidcate it was already processed
	  // and will prevent hitting on the pin again.
          if (ON_OFF_word & j) ON_OFF_word_sent |= j;
          else ON_OFF_word_sent &= (uint16_t)~j;
//	  // Go on to the next pin
//          if (i == 0) break;
//          j = j >> 1;
//          i--;
	}
      }
      
      // If no Publish was sent check the next one. Note: If any Publish
      // WAS sent we would have broken out of the while() loop.
      if (i == 0) break;
      j = j >> 1;
      i--;
    }
  }

  // Check for a state_request
  if (state_request == STATE_REQUEST_RCVD) {
    // Publish all pin states
    state_request = STATE_REQUEST_IDLE;
    publish_pinstate_all();
  }
}


void publish_pinstate(uint8_t direction, uint8_t pin, uint16_t value, uint16_t mask)
{
  // This function transmits a change in pin state and updates the "sent"
  // value.
  
//  uint8_t size;
  int size;
//  uint8_t i;
  int i;
  unsigned char app_message[4];       // Stores the application message (the
                                      // payload) that will be sent in an
				      // MQTT message.
  
  app_message[0] = '\0';
  
  strcpy(topic_base, devicetype);
  strcat(topic_base, stored_devicename);

  // If we are sending an Input message invert the value if the Invert_word
  // bit associated with the pin is 1
  if (direction == 'I') {
    if ((Invert_word & mask)) value = (uint16_t)(~value);
    // Build first part of the topic message
    strcat(topic_base, "/input/");
  }
  // Else this is an Output message. Build the first part of the topic message
  else {
    strcat(topic_base, "/output/");
  }
    
  // Add pin number to the topic message
  emb_itoa(pin, OctetArray, 10, 2);
  i = (uint8_t)strlen(topic_base);
  topic_base[i] = OctetArray[0];
  i++;
  topic_base[i] = OctetArray[1];
  i++;
  topic_base[i] = '\0';
  
  // Build the application message
  if (value & mask) {
    strcpy(app_message, "ON");
    size = 2;
  }
  else {
    strcpy(app_message, "OFF");
    size = 3;
  }
    
  // Queue publish message
  mqtt_publish(&mqttclient,
               topic_base,
	       app_message,
	       size,
	       MQTT_PUBLISH_QOS_0 | MQTT_PUBLISH_RETAIN);  
}


void publish_pinstate_all(void)
{
  // This function transmits the state of all pins (outputs and sense inputs)
  // in a single message response regardless of the enabled/disabled state.
  // Input pins need to be inverted per the Invert_word.
  // Output pins were already inverted elsewhere so they stay unchanged in
  // this function.
  // The first byte of the Payload contains the ON/OFF state for IO 16 in the
  // msb of the byte. The ON/OFF state for IO 9 is in the lsb.
  // The second byte of the Payload contains the ON/OFF state for IO 8 in the
  // msb of the byte. The ON/OFF state for IO 1 is in the lsb.
  
//  uint8_t i;
  int i;
  uint16_t j;
  uint16_t k;
  unsigned char app_message[3];       // Stores the application message (the
                                      // payload) that will be sent in an
				      // MQTT message.
  
  j = 0x0001;
  k = 0x0000;
  
  for(i=0; i++; i<16) {
    // Check for input/output
    if ((pin_control[i] & 0x02) == 0x02) {
      // Pin is an output, transmit as-is
      if (pin_control[i] & 0x80) k |= j;
    }
    else {
      // Pin is an input, invert if needed
      if (pin_control[i] & 0x04) {
        // Invert required
	if (pin_control[i] & 0x80) k &= ~j;
	else k |= j;
      }
      else {
        // No invert
	if (pin_control[i] & 0x80) k |= j;
	else k &= ~j;
      }
    }
    j = j<<1;
  }

  // The above created a word with all the pin states
  // Need to split it into two bytes for transmission
  j = (uint8_t)(k & 0x00ff);
  k = (uint16_t)k >> 8;
  
  app_message[0] = (uint8_t)k;
  app_message[1] = (uint8_t)j;
  app_message[2] = '\0';

  strcpy(topic_base, devicetype);
  strcat(topic_base, stored_devicename);
  strcat(topic_base, "/state");

  // Queue publish message
  mqtt_publish(&mqttclient,
               topic_base,
	       app_message,
	       2,
	       MQTT_PUBLISH_QOS_0 | MQTT_PUBLISH_RETAIN);
}


void publish_temperature(uint8_t sensor)
{
  // This function is called to Publish a temperature value collected from
  // a DS18B20 connected to IO 16.
  
//  uint8_t i;
  int i;
  unsigned char app_message[10];      // Stores the application message (the
                                      // payload) that will be sent in an
				      // MQTT message.

  if (sensor <= numROMs) {
    // Only Publish if the sensor number is one of the sensors found by
    // FindDevices as indicated by numROMs.
    //
    // The "sensor" value delivered to this function identifies the sensor
    // as a value from 0 to 4 (for the five sensors).
    //
    // The "numROMs" value is also a value from 0 to 4 (for the five sensors).
    //
    // When the Publish message is sent the sensor value must be in human
    // readable form, ie, 1 to 5 (for the 5 sensors).

    app_message[0] = '\0';
    
    strcpy(topic_base, devicetype);
    strcat(topic_base, stored_devicename);
    strcat(topic_base, "/temp/");
    
    // Add sensor number to the topic message. Note the sensor number has 1
    // added to make it human readable form.
    emb_itoa((sensor + 1), OctetArray, 10, 2);
    i = (uint8_t)strlen(topic_base);
    topic_base[i] = OctetArray[0];
    i++;
    topic_base[i] = OctetArray[1];
    i++;
    
    topic_base[i] = '\0';
    
    // Build the application message
    strcpy(app_message, DS18B20_string[sensor]);
    // This sequence of characters will send a "degree" symbol
    // followed by 'C' for "degrees C" display in HA.
//    strcat(app_message, "\xc2\xb0\x43");
    
    // Queue publish message
    mqtt_publish(&mqttclient,
                 topic_base,
                 app_message,
                 strlen(app_message),
                 MQTT_PUBLISH_QOS_0 | MQTT_PUBLISH_RETAIN);
  }
}


void unlock_eeprom(void)
{
  // Unlock the EEPROM
  // The EEPROM must be unlocked to allow any writes to it.
  // It appears that there is an errata in the STM8S device in that the
  // specified "unlock" keys need to be written in reverse order from the
  // instructions in the documentation. Another user suggests the following
  // code to unlock the EEPROM:
  //   This code in effect writes the unlock at least twice, resulting in at
  //   least one correct combo of KEY1/KEY2 and KEY2/KEY1, thus making sure
  //   the EEPROM is unlocked regardless of the errata.
  while (!(FLASH_IAPSR & 0x08)) {  // Check DUL bit, 0=Protected
    FLASH_DUKR = 0xAE; // MASS key 1
    FLASH_DUKR = 0x56; // MASS key 2
  }
}


void lock_eeprom(void)
{
  // Lock the EEPROM so that it cannot be written. This clears the DUL bit.
  FLASH_IAPSR &= (uint8_t)(~0x08);
}


void upgrade_EEPROM(void)
{
  // This functions upgrades prior revisions of the EEPROM to the current
  // revision.
//  uint8_t i;
  int i;
  
  // ----------------------------------------------------------------------//
  // Starting with the January 2021 releases the EEPROM will contain a
  // stored_EEPROM_revision value.
  //
  // Any release prior to January 2021 cannot be seamlessly upgraded to
  // the later releases because there is no method to determine what model
  // was used (16 output, 8out/8in, or 16 input). For this reason if
  // upgrading from a very early release the following information is lost:
  // a) All pin states. All pins will be set to disabled/input. The user
  //    must re-enter this information.
  // b) The Full/Half Duplex setting. The state will be set to Half Duplex.
  //    The user must re-enter the Full Duplex setting if needed.
  // c) The Auto Discovery setting. The state will be set to disable Auto
  //    Discovery. The user must re-enable Auto Discovery if needed.
  //
  // If the code does not find a valid EEPROM revision level at boot time
  // it will assume the code is a very old revision and will set defaults
  // as shown above. All other settings (IP addresses, Port numbers, MAC
  // Address, etc) are retained even from the very early releases. Once an
  // upgrade to a January 2021 (or later) release occurs the EEPROM will
  // have a revision code that it uses to manage all subsequent upgrades.
  //
  unlock_eeprom();
  while ( 1 ) {
    // First check for stored_EEPROM_revision. A chance is taken here that
    // there might be a random value in the stored_EEPROM_revision location
    // that matches a valid EEPROM revision. If a false positive occurs at
    // at worst the user might have to reset the device to default
    // configuration settings and manually re-enter all settings.
    //
    // Table of EEPROM revision codes:
    // 0xf5 - January 2021 code
    if ((stored_EEPROM_revision1 == 0x01) && (stored_EEPROM_revision2 == 0xf5)) {
      break;
    }
    
//    // Placeholder for future revision level. Put in the values that should
//    // checked. Recommended next level to be 0x02.
//    if (stored_EEPROM_revision1 == 0x02 && stored_EEPROM_revision2 == 0xf5) {
//      break;
//    }

    // If the above checks didn't work this must be a very old revision
    // prior to creation of the EEPROM revision codes. The following actions
    // are taken:
    // 1) Clear the Config byte in the EEPROM
    // 2) Set all pin_control bytes to 0. This forces all pins to be disabled
    //    inputs.
    stored_config_settings = 0;
    
    // Create default pin_control bytes
    for (i=0; i<16; i++) stored_pin_control[i] = 0;
    
    // Set to the EEPROM revision for this code
    stored_EEPROM_revision1 = 0x01;
    stored_EEPROM_revision2 = 0xf5;
    
    break;
  }
  lock_eeprom();
}    


void check_eeprom_settings(void)
{
//  uint8_t i;
  int i;

  // Check magic number in EEPROM.
  // If no magic number is found it is assumed that the EEPROM has never been
  // written, in which case the default Output States, IP Address, Gateway
  // Address, Netmask, MAC and Port number will be used.
  // If the magic number IS found then it is assumed that the EEPROM contains
  // valid copies of the Output States, IP Address, Gateway Address, Netmask,
  // MAC and Port number.
  // The magic number sequence is MSB 0x55 0xee 0x0f 0xf0 LSB
  
  if ((magic4 == 0x55) && 
      (magic3 == 0xee) && 
      (magic2 == 0x0f) && 
      (magic1 == 0xf0)) {
      
    // MAGIC NUMBER IS PRESENT. Use the values in the EEPROM for the Output
    // States, IP, Gateway, Netmask, MAC and Port Number.
    
    // Read and use the IP Address from EEPROM
    uip_ipaddr(IpAddr,
               stored_hostaddr[3],
	       stored_hostaddr[2],
	       stored_hostaddr[1],
	       stored_hostaddr[0]);
    uip_sethostaddr(IpAddr);
    
    // Read and use the Gateway Address from EEPROM
    uip_ipaddr(IpAddr,
               stored_draddr[3],
	       stored_draddr[2],
	       stored_draddr[1],
	       stored_draddr[0]);
    uip_setdraddr(IpAddr);
    
    // Read and use the Netmask from EEPROM
    uip_ipaddr(IpAddr,
               stored_netmask[3],
	       stored_netmask[2],
	       stored_netmask[1],
	       stored_netmask[0]);
    uip_setnetmask(IpAddr);

    // Read and use the MQTT Server IP Address from EEPROM
    uip_ipaddr(IpAddr,
               stored_mqttserveraddr[3],
	       stored_mqttserveraddr[2],
	       stored_mqttserveraddr[1],
	       stored_mqttserveraddr[0]);
    uip_setmqttserveraddr(IpAddr);
    
    // Read and use the MQTT Port from EEPROM
    Port_Mqttd = stored_mqttport;

    // Read and use the Port from EEPROM
    Port_Httpd = stored_port;
    
    // Read and use the MAC from EEPROM
    // Set the MAC values used by the ARP code. Note the ARP code uses the
    // values in reverse order from all the other code.
    uip_ethaddr.addr[0] = stored_uip_ethaddr_oct[5]; // MSB
    uip_ethaddr.addr[1] = stored_uip_ethaddr_oct[4];
    uip_ethaddr.addr[2] = stored_uip_ethaddr_oct[3];
    uip_ethaddr.addr[3] = stored_uip_ethaddr_oct[2];
    uip_ethaddr.addr[4] = stored_uip_ethaddr_oct[1];
    uip_ethaddr.addr[5] = stored_uip_ethaddr_oct[0]; // LSB
  }
  
  else {
    // MAGIC NUMBER IS NOT PRESENT. Use the default IP, Gateway, Netmask,
    // Port, and MAC values and store them in the EEPROM. Turn off all
    // Outputs and store the off state in EEPROM. Write the magic number.

    unlock_eeprom(); // Make EEPROM writeable

    // Default IP Address
    uip_ipaddr(IpAddr, 192,168,1,4);
    uip_sethostaddr(IpAddr);
    // Write the IP Address to EEPROM
    stored_hostaddr[3] = 192;	// MSB
    stored_hostaddr[2] = 168;	//
    stored_hostaddr[1] = 1;	//
    stored_hostaddr[0] = 4;	// LSB
    
    // Default Gateway Address
    uip_ipaddr(IpAddr, 192,168,1,1);
    uip_setdraddr(IpAddr);
    // Write the Gateway Address to EEPROM
    stored_draddr[3] = 192;	// MSB
    stored_draddr[2] = 168;	//
    stored_draddr[1] = 1;		//
    stored_draddr[0] = 1;		// LSB
    
    // Default Netmask
    uip_ipaddr(IpAddr, 255,255,255,0);
    uip_setnetmask(IpAddr);
    // Write the Netmask to EEPROM
    stored_netmask[3] = 255;	// MSB
    stored_netmask[2] = 255;	//
    stored_netmask[1] = 255;	//
    stored_netmask[0] = 0;	// LSB

    // Initial MQTT Server IP Address
    uip_ipaddr(IpAddr, 0,0,0,0);
    uip_setmqttserveraddr(IpAddr);
    
    // Write the MQTT Server IP Address to EEPROM
    stored_mqttserveraddr[3] = 0;	// MSB
    stored_mqttserveraddr[2] = 0;	//
    stored_mqttserveraddr[1] = 0;	//
    stored_mqttserveraddr[0] = 0;	// LSB
    
    // Write the default MQTT Port number to EEPROM
    stored_mqttport = 1883;		// Port
    // Set the "in use" port number to the default
    Port_Mqttd = 1883;
    
    // Write a NULL Usernams and Password to the EEPROM
    for(i=0; i<11; i++) { stored_mqtt_username[i] = '\0'; }
    for(i=0; i<11; i++) { stored_mqtt_password[i] = '\0'; }
    
    // Write the default Port number to EEPROM
    stored_port = 8080;
    // Set the "in use" port number to the default
    Port_Httpd = 8080;

    // Write the default MAC address to EEPROM and to the ARP values.
    // With a bogus Magic Number we have to assume that the Network Module
    // has never been used before. Therefore we need to program a default
    // MAC Address. After this the Magic Number should always be present
    // in which case a user programmed MAC is used.
    // Note there is nothing special about the default MAC used below. It
    // must be a "Locally Administered" address and it must be a "Unicast"
    // address. Both of these conditions are met via the bit settings of
    // the most significant octet. Otherwise the default MAC is a random
    // selection. I assume the user will pick MACs that do not conflict
    // within their networks.
    //
    // Note that the MAC values used by the ARP code are in reverse order
    // from that used by all the other code.
    stored_uip_ethaddr_oct[5] = 0xc2;	//MAC MSB
    stored_uip_ethaddr_oct[4] = 0x4d;
    stored_uip_ethaddr_oct[3] = 0x69;
    stored_uip_ethaddr_oct[2] = 0x6b;
    stored_uip_ethaddr_oct[1] = 0x65;
    stored_uip_ethaddr_oct[0] = 0x00;	//MAC LSB
    // Set the MAC values used by the ARP code
    uip_ethaddr.addr[0] = stored_uip_ethaddr_oct[5]; // MSB
    uip_ethaddr.addr[1] = stored_uip_ethaddr_oct[4];
    uip_ethaddr.addr[2] = stored_uip_ethaddr_oct[3];
    uip_ethaddr.addr[3] = stored_uip_ethaddr_oct[2];
    uip_ethaddr.addr[4] = stored_uip_ethaddr_oct[1];
    uip_ethaddr.addr[5] = stored_uip_ethaddr_oct[0]; // LSB

    // Default Device Name
    strcpy(stored_devicename, "NewDevice000");
    for (i=12; i<20; i++) stored_devicename[i] = '\0';

    // Clear Config settings
    stored_config_settings = 0;
    
    // XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
    // All pins need to default to "input" and "disable" to prevent
    // conflicting with external drivers.
    // pin_control_bytes should be set to defaults
    //   Each pin should be set to 00001010
    //   0 ON/OFF
    //   0 reserved
    //   0 reserved
    //   0 On/Off after power cycle set to Off
    //   0 Retain set to Off
    //   0 Invert set to Off
    //   0 Input/Output set to Input
    //   0 Enable/Disable set to Disable
    // THEN 16 bit registers should be written
    //   encode_16bit_registers()
    // XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
    
    // Create default pin_control bytes
    for (i=0; i<16; i++) stored_pin_control[i] = 0x00;
    
    // Write the magic number to the EEPROM MSB 0x55 0xee 0x0f 0xf0 LSB
    magic4 = 0x55;		// MSB
    magic3 = 0xee;		//
    magic2 = 0x0f;		//
    magic1 = 0xf0;		// LSB
    
    lock_eeprom();
  }

  // Since this code is run one time at boot, initialize the variables that
  // are dependent on EEPROM content.
  
  // Read the pin_control bytes from EEEPROM
  for (i=0; i<16; i++) pin_control[i] = stored_pin_control[i];

  // Check the "Retain/On/Off at Boot" settings and force the ON/OFF state
  // accordingly. Do this on Outputs only.
  for (i=0; i<16; i++) {
    if (((pin_control[i] & 0x08) == 0x00) && (pin_control[i] & 0x02)) {
      // Retain is not set and this is an output
      if ((pin_control[i] & 0x10) == 0x00) {
        // Force ON/OFF to zero
        pin_control[i] &= 0x7f;
      }
      if ((pin_control[i] & 0x10) == 0x10) {
        // Force ON/OFF to one
        pin_control[i] |= 0x80;
      }
      // else Retain the ON/OFF bit
    }
  }

  // Update stored_pin_control bytes and Pending_pin_control bytes
  unlock_eeprom();
  for (i=0; i<16; i++) {
    if (stored_pin_control[i] != pin_control[i]) stored_pin_control[i] = pin_control[i];
  }
  lock_eeprom();

  // Create 16bit versions of the ON/OFF and Invert pin control information
  encode_16bit_registers();
    
  // Initialize IO ON/OFF state tracking
  ON_OFF_word_new1 = ON_OFF_word_new2 = ON_OFF_word_sent = ON_OFF_word;
    
  // Set Output pins
  write_output_pins();

  // Initialize Pending values to the current stored values
  for (i=0; i<16; i++) Pending_pin_control[i] = stored_pin_control[i];
  
  for (i=0; i<4; i++) {
    Pending_hostaddr[i] = stored_hostaddr[i];
    Pending_draddr[i] = stored_draddr[i];
    Pending_netmask[i] = stored_netmask[i];
    Pending_mqttserveraddr[i] = stored_mqttserveraddr[i];
  }
  
  Pending_port = stored_port;
  Pending_mqttport = stored_mqttport;
  
  for (i=0; i<20; i++) {
    Pending_devicename[i] = stored_devicename[i];
  }

  Pending_config_settings = stored_config_settings;

  for (i=0; i<6; i++) Pending_uip_ethaddr_oct[i] = stored_uip_ethaddr_oct[i];

  for (i=0; i<11; i++) {
    Pending_mqtt_username[i] = stored_mqtt_username[i];
    Pending_mqtt_password[i] = stored_mqtt_password[i];
  }
  
  // Update the MAC string
  update_mac_string();
  
  // If the MQTT Enable bit is set in the Config settings AND at least
  // one IO pin is enabled set the mqtt_enabled byte.
  if (stored_config_settings & 0x04) {
    for (i=0; i<16; i++) {
      if (pin_control[i] & 0x01) mqtt_enabled = 1;
    }
  }
}


void update_mac_string(void)
{
  // Function to turn the uip_ethaddr values into a single string containing
  // the MAC address
//  uint8_t i;
  int i;
//  uint8_t j;
  int j;

  i = 5;
  j = 0;
  while (j<12) {
    int2hex(stored_uip_ethaddr_oct[i]);
    mac_string[j++] = OctetArray[0];
    mac_string[j++] = OctetArray[1];
    i--;
  }
  mac_string[12] = '\0';
}


void check_runtime_changes(void)
{
  // Step 1: Read the input registers and update the pin_control values as
  // needed.
  // 
  // Step 2: Check if the user requested changes to Device Name, Output
  // States, IP Address, Gateway Address, Netmask, Port, or MAC. If a change
  // occurred update the appropriate variables and output controls, and store
  // the new values in EEPROM. Note that the value parse_complete is used to
  // make sure that a complete POST entry has been received before attempting
  // to process the changes made by the user.

//  uint8_t i;
  int i;
  uint8_t update_EEPROM;

  unlock_eeprom();

  read_input_pins();

  // XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
  // XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
  // XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
  // Check the DS18B20 Enable bit. If enabled over-ride the pin_control byte
  // bits for IO 16 to force them to all zero. This forces the disabled
  // state and makes sure all other bits are in a neutral condition should
  // the DS18B20 be Disabled at some future time.
  // XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
  // XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
  // XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
  if (Pending_config_settings & 0x08) {
//    pin_control[14] = Pending_pin_control[14] = (uint8_t)0x00;
    pin_control[15] = Pending_pin_control[15] = (uint8_t)0x00;
    // Update the stored_pin_control[] variables
//    if (stored_pin_control[14] != pin_control[14]) stored_pin_control[14] = pin_control[14];
    if (stored_pin_control[15] != pin_control[15]) stored_pin_control[15] = pin_control[15];
  }

  if (parse_complete == 1 || mqtt_parse_complete == 1) {
    // Check for changes from the user via the GUI, MQTT, or REST commands.
    // If parse_complete == 1 all TCP Fragments have been received during
    // HTML POST processing, OR a REST command was processed.
    // If mqtt_parse_complete == 1 an MQTT Output pin state change has been
    // received.

    // Check all pin_control bytes for changes.
    // ON/OFF state: If an Output pin’s ON/OFF state changes the EEPROM is
    //   updated only if Retain is set, but a restart must not occur.
    //   IMPORTANT: This routine must only change Output pin ON/OFF states.
    //   The read_input_pins() function is the only place where Input pin
    //   ON/OFF state is changed in the pin_control bytes.
    //
    //   Note that if an Output pin's ON/OFF setting changes the change came
    //   from the IOControl page or from MQTT. No other bits in the
    //   pin_control can change in this case. The inverse is true of the
    //   other pin_control bits. If any other pin_control bit changes it is
    //   because of user input on the Configuration page, and there will be
    //   no change in the state of the ON/OFF bit.
    //
    // Input/Output/Enabled/Disabled: If the user changes IO pin type (input
    //   / output / enabled / disabled) the EEPROM is updated and a reboot is
    //   required. Note that a reboot is always required if Input/Output is
    //   changed. If Enabled/Disabled is changed a reboot is really only
    //   required if MQTT is enabled, but it will be done regardless to
    //   simplify code.
    //
    // Invert: If user changes a pin's Invert setting the EEPROM is updated
    //   and a restart is required. Note that a restart is really only
    //   required if MQTT is enabled, but it will be done regardless to
    //   simplify code.
    //
    // Retain/On/Off; If a user changes a pins Retain/On/Off setting the
    //   EEPROM is updated but a restart is not needed. This is because the
    //   bits are only used if the device reboots due to an external event.
    
    update_EEPROM = 0;
    
    for (i=0; i<16; i++) {
    
      if (pin_control[i] != Pending_pin_control[i]) {
        // Something changed - sort it out
	
        // Check for change in ON/OFF bit. This function will save the ON/OFF
	// bit in the EEPROM if the IO is an Output and Retain is enabled (or
	// in the process of being enabled).
//	if (pin_control[i] & 0x02) { // Output?
//	if (Pending_pin_control[i] & 0x02) { // Output?
//          if ((pin_control[i] & 0x80) != (Pending_pin_control[i] & 0x80)) {
//	    // ON/OFF changed
//            if (Pending_pin_control[i] & 0x08) {
//	      // Retain is set, so need to update EEPROM
//              update_EEPROM = 1;
//            }
//          }
	if (Pending_pin_control[i] & 0x0a) { // Output AND Retain set?
          if ((pin_control[i] & 0x80) != (Pending_pin_control[i] & 0x80)) {
	    // ON/OFF changed
            update_EEPROM = 1;
          }
	}

        // Check for change in Input/Output definition
        if ((pin_control[i] & 0x02) != (Pending_pin_control[i] & 0x02)) {
          // There is a change:
	  //   Signal an EEPROM update
	  //   Signal a "reboot needed"
          update_EEPROM = 1;
	  // Changing pin definitions with regard to Input/Output definition
	  // requires a hardware reboot as the IO hardware needs to be
	  // reconfigured.
          user_reboot_request = 1;
	}
	
        // Check for change in Enabled/Disabled definition
        if ((pin_control[i] & 0x01) != (Pending_pin_control[i] & 0x01)) {
          // There is a change:
	  //   Signal an EEPROM update
	  //   Signal a "reboot needed". Note that a reboot is really only
	  //   needed if MQTT is enabled, but it will be done even if MQTT is
	  //   not enabled to simplify code.
          update_EEPROM = 1;
//	  if (stored_config_settings & 0x04) { // MQTT enabled?
//            // Changing pin definitions with regard to Enabled/Disabled
//	    // definition requires a hardware reboot if MQTT is enabled.
            user_reboot_request = 1;
//	  }
        }

        // Check for change in Invert
        if ((pin_control[i] & 0x04) != (Pending_pin_control[i] & 0x04)) {
          // There is a change.
	  //   Signal an EEPROM update.
	  //   Signal a "restart needed". Note that a restart is really only
	  //   needed if MQTT is enabled, but it will be done even if MQTT is
	  //   not enabled to simplify code.
          update_EEPROM = 1;
//          if (mqtt_enabled == 1) {
//            // If MQTT is enabled restart so input inversion is reported to
//            // the MQTT server
            restart_request = 1;
//          }
        }
	
        // Check for change in Retain/On/Off bits
//        if (((pin_control[i] & 0x10) != (Pending_pin_control[i] & 0x10))
//         || ((pin_control[i] & 0x08) != (Pending_pin_control[i] & 0x08))) {
        if ((pin_control[i] & 0x18) != (Pending_pin_control[i] & 0x18)) {
          // There is a change. Signal an EEPROM update. No restart or
	  // reboot is required as these bits are only used when a reboot
	  // occurs as a result of a power cycle or button reboot.
          update_EEPROM = 1;
        }
	
	// Always update the pin_control byte even if the EEPROM was not
	// updated. Don't let the ON/OFF bit change if this pin_control is
	// for an input.
//	if (pin_control[i] & 0x02) { // Output?
	if (Pending_pin_control[i] & 0x02) { // Output?
	  // Update all bits
	  pin_control[i] = Pending_pin_control[i];
	}
	else { // Input
	  // Update all bits except the ON/OFF bit
          pin_control[i] &= 0x80;
	  pin_control[i] |= (uint8_t)(Pending_pin_control[i] & 0x7f);
	}
	
        if (update_EEPROM == 1) {
          // Update the stored_pin_control[] variables
          if (stored_pin_control[i] != pin_control[i]) stored_pin_control[i] = pin_control[i];
          update_EEPROM = 0;
        }
      }
    }

    // Update the 16 bit registers with the changed pin states
    encode_16bit_registers();
    
    // Update the Output pins
    write_output_pins();
  }

  if (parse_complete == 1) {
    // Only perform the next checks if parse_complete indicates that all
    // HTML POST processing is complete.

    if (stored_config_settings != Pending_config_settings) {
      // Save the "prior" config (Features) setting in case it is needed
      // after boot.
      stored_prior_config = stored_config_settings;
      
      // At present any Feature bit change (config_settings) requires a
      // reboot so to simplify code the bits are not individually checked.
      // The Feature bits include:
      //   DS18B20
      //   MQTT
      //   Home Assistant Auto Discovery
      //   Full Duplex
      user_reboot_request = 1;
      
      // If any bit of the config_settings changed write to EEPROM
      stored_config_settings = Pending_config_settings;
    }

    // Check for changes in the IP Address, Gateway Address,
    // Netmask, and MQTT Server IP Address. Combined into one
    // loop for code size reduction.
    for (i=0; i<4; i++) {
      if (stored_hostaddr[i] != Pending_hostaddr[i]) {
        // Write the new octet to the EEPROM and singla a restart
        stored_hostaddr[i] = Pending_hostaddr[i];
        restart_request = 1;
      }
      if (stored_draddr[i] != Pending_draddr[i]) {
        // Write the new octet to the EEPROM and singla a restart
        stored_draddr[i] = Pending_draddr[i];
        restart_request = 1;
      }
      if (stored_netmask[i] != Pending_netmask[i]) {
        // Write the new octet to the EEPROM and singla a restart
        stored_netmask[i] = Pending_netmask[i];
        restart_request = 1;
      }
      if (stored_mqttserveraddr[i] != Pending_mqttserveraddr[i]) {
        // Write the new octet to the EEPROM and singla a restart
        stored_mqttserveraddr[i] = Pending_mqttserveraddr[i];
        restart_request = 1;
      }
    }
      
    // Check for changes in the Port number
    if (stored_port != Pending_port) {
      // Write the new Port number to the EEPROM
      stored_port = Pending_port;
      // A firmware restart will occur to cause this change to take effect
      restart_request = 1;
    }
  
    // Check for changes in the Device Name
    for(i=0; i<20; i++) {
      if (stored_devicename[i] != Pending_devicename[i]) {
        stored_devicename[i] = Pending_devicename[i];
        // No restart is required in non-MQTT applications as this does not
	// affect Ethernet operation.
        if (mqtt_enabled == 1) {
          // If MQTT is enabled a restart is required as this affects the
	  // MQTT topic name.
          restart_request = 1;
	}
      }
    }

    // Check for changes in the MQTT Port number
    if (stored_mqttport != Pending_mqttport) {
      // Write the new MQTT Port number to the EEPROM
      stored_mqttport = Pending_mqttport;
      // A firmware restart will occur to cause this change to take effect
      restart_request = 1;
    }

    // Check for changes in the Username or Password
    // The storage fields are the same length so to condense code
    // they will be checked in the same loop
    for(i=0; i<11; i++) {
      if (stored_mqtt_username[i] != Pending_mqtt_username[i]) {
        stored_mqtt_username[i] = Pending_mqtt_username[i];
        // A firmware restart will occur to cause this change to take effect
        restart_request = 1;
      }
      if (stored_mqtt_password[i] != Pending_mqtt_password[i]) {
        stored_mqtt_password[i] = Pending_mqtt_password[i];
        // A firmware restart will occur to cause this change to take effect
        restart_request = 1;
      }
    }
    
    // Check for changes in the MAC
    if (stored_uip_ethaddr_oct[0] != Pending_uip_ethaddr_oct[0] ||
      stored_uip_ethaddr_oct[1] != Pending_uip_ethaddr_oct[1] ||
      stored_uip_ethaddr_oct[2] != Pending_uip_ethaddr_oct[2] ||
      stored_uip_ethaddr_oct[3] != Pending_uip_ethaddr_oct[3] ||
      stored_uip_ethaddr_oct[4] != Pending_uip_ethaddr_oct[4] ||
      stored_uip_ethaddr_oct[5] != Pending_uip_ethaddr_oct[5]) {
      // Write the new MAC to the EEPROM
      for (i=0; i<6; i++) stored_uip_ethaddr_oct[i] = Pending_uip_ethaddr_oct[i];
      // Update the MAC string
      update_mac_string();
      // A firmware restart will occur to cause this change to take effect
      restart_request = 1;
    }
  }
  
  lock_eeprom();
  
  
  // Decide if a restart or reboot is needed. If both are set the
  // reboot request will take precedence in the check_restart_reboot()
  // function.
  // Explanation of "user_reboot_request": This variable is used to
  // communicate that the user pressed the Reboot button on the
  // Configuration page. We can't just set "reboot_request" when the
  // Reboot button click is detected in the httpd.c code because we
  // need to make sure a restart or reboot isn't already occurring, and
  // that check occurs here.
  // Note: To simplify code user_reboot_request is also set when user
  // changes are detected in the check_runtime_changes() function. This
  // eliminates an additional check below.
  if (restart_request == 1 || user_reboot_request == 1) {
    // Arm the restart function but first make sure we aren't already
    // performing a restart or reboot so we don't get stuck in a loop.
    if (restart_reboot_step == RESTART_REBOOT_IDLE) {
      restart_reboot_step = RESTART_REBOOT_ARM;
    }
    if (user_reboot_request == 1) { // Did user click on Reboot?
      user_reboot_request = 0;
      reboot_request = 1;
    }
  }
  
  
  // We've set the restart_request or reboot_request bytes (if needed) and
  // will now return to the main loop where the restart or reboot routines
  // will be called. This is done this way because we need to let
  // uip_periodic() handle the closing of connections.

  parse_complete = 0; // Reset parse_complete for future changes

  // Periodic check of the stack overflow guardband
  if (stack_limit1 != 0xaa || stack_limit2 != 0x55) {
    stack_error = 1;
    fastflash();
    fastflash();
    
// XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
#if DEBUG_SUPPORT == 2
  // Report the stack overflow bit
  // Important - Verify that the correct debug[] byte is selected as
  // these may have moved. Also check that this byte is reported in
  // httpd.c for display in the Browser.
  unlock_eeprom();
  if (stack_error == 1) {
    debug[22] |= 0x80;
    update_debug_storage1();
  }
  lock_eeprom();
#endif // DEBUG_SUPPORT == 2
// XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX

  }
}


void check_restart_reboot(void)
{
  // Function provides the sequence and timing required to shut down
  // connections and trigger a restart or reboot. This function is called
  // from the main loop and returns to the main loop so that the periodic()
  // function can run.

  if (restart_request == 1 || reboot_request == 1) {
    // A restart or reboot has been requested. The restart and reboot
    // requests are set in the check_runtime_changes() function if a restart
    // or reboot is needed.
    // The following needs to occur:
    // 1) If the pin_delete_register indicates there are pins that
    //    require an HA Auto Discovery "blank payload" message this
    //    state machine will be called multiple times to send those
    //    messages.
    // 2) If MQTT is enabled run the mqtt_disconnect() function.
    // 2a) Verify that mqtt disconnect was sent to the MQTT server.
    // 2b) Call uip_close() for the MQTT TCP connection.
    // 3) Verify that the close requests completed.
    // 4) Run either the restart() function or the reboot() function.
    //    Reboot takes precedence over restart.

    switch(restart_reboot_step)
    {
    case RESTART_REBOOT_ARM:
      // Clear 100ms timer to delay the next step
      t100ms_ctr1 = 0;
      restart_reboot_step = RESTART_REBOOT_ARM2;
      break;

    case RESTART_REBOOT_ARM2:
      // Wait 1 second for anything in the process of being transmitted
      // to fully buffer. Refresh of a page after POST can take a few
      // seconds.
      if (t100ms_ctr1 > 9) {
        if (mqtt_enabled) restart_reboot_step = RESTART_REBOOT_SENDOFFLINE;
	else restart_reboot_step = RESTART_REBOOT_FINISH;
        // Clear 100ms timer to delay the next step
        t100ms_ctr1 = 0;
      }
      break;

    case RESTART_REBOOT_SENDOFFLINE:
      if (t100ms_ctr1 > 1) {
       // We can only get here is mqtt_enabled == 1
       // Wait at least 100 ms before publishing availability message
       if (mqtt_start == MQTT_START_COMPLETE) {
          // Publish the availability "offline" message
          strcpy(topic_base, devicetype);
          strcat(topic_base, stored_devicename);
          strcat(topic_base, "/availability");
          mqtt_publish(&mqttclient,
                       topic_base,
                       "offline",
                       7,
                       MQTT_PUBLISH_QOS_0 | MQTT_PUBLISH_RETAIN);
        }
        restart_reboot_step = RESTART_REBOOT_DISCONNECT;
        // Clear time to delay the next step
        t100ms_ctr1 = 0;
      }
      break;
    
    case RESTART_REBOOT_DISCONNECT:
      if (t100ms_ctr1 > 2) {
        // We can only get here is mqtt_enabled == 1
        // The offline publish is given up to 200 ms to be communicated
        // before performing mqtt_disconnect
        if (mqtt_start == MQTT_START_COMPLETE) {
          // Disconnect the MQTT client
          mqtt_disconnect(&mqttclient);
        }
        restart_reboot_step = RESTART_REBOOT_TCPCLOSE;
        // Clear time to delay the next step
        t100ms_ctr1 = 0;
      }
      break;
    
    case RESTART_REBOOT_TCPCLOSE:
      if (t100ms_ctr1 > 2) {
        // We can only get here is mqtt_enabled == 1
        // The mqtt_disconnect() is given up to 200 ms to be communicated
        // before starting TCP close
        // 
        // The way a TCP connection close SHOULD work:
        // 1) A uip_periodic() runs and uip_process(UIP_TIMER) is called
        // 2) If a connection is in the ESTABLISHED state (meaning a TCP
        //    connection is open) the uip_process() will make a UIP_APPCALL.
        // 3) UIP_APPCALL calls the MQTT or HTTP application via
        //    uip_TcpAppHubCall()
        // 4) Before the application returns, if it wants to close the
        //    connection, it should call uip_close()
        // 5) The UIP code will then go to appsend: and will know to start the
        //    TCP close process.
        // So, it looks like all I need to do is make sure the APPCALL performs
        // a uip_close() before returning to the UIP code. Then the regular
        // uip_periodic() process should get the job done.
        //
        // Signal uip_TcpAppHubCall() to close the MQTT TCP connection
        mqtt_close_tcp = 1;
        // Clear time to delay the next step
        t100ms_ctr1 = 0;
        restart_reboot_step = RESTART_REBOOT_TCPWAIT;
      }
      break;
      
    case RESTART_REBOOT_TCPWAIT:
      // We can only get here is mqtt_enabled == 1
      // Verify closed ... how?
      // For the moment I'm not sure how to do this, so I will just allow
      // enough time for it to happen. That is probably much faster, but I
      // will allow 500 ms.
      if (t100ms_ctr1 > 5) {
	mqtt_close_tcp = 0;
        restart_reboot_step = RESTART_REBOOT_FINISH;
      }
      break;
    
    case RESTART_REBOOT_FINISH:
      if (reboot_request == 1) {
        restart_reboot_step = RESTART_REBOOT_IDLE;
        // Hardware reboot
        reboot();
      }
      if (restart_request == 1) {
	restart_request = 0;
        restart_reboot_step = RESTART_REBOOT_IDLE;
	// Firmware restart
	restart();
      }
      break;
    } // end switch
  }
}


void restart(void)
{
  // This function restarts the firmware without affecting output pin states.
  // We run through the processes to apply IP Address, Gateway Address,
  // Netmask, Port number, MAC, etc, but we don't run the GPIO initialization
  // that would affect the GPIO pin states. This prevents output "chatter"
  // that a complete hardware reset would cause.

// #if DEBUG_SUPPORT != 0
//  fastflash(); // A useful signal that a deliberate restart is occurring.
// oneflash();
// oneflash();
// #else
//  oneflash(); // Quick flash for normal operation
// #endif DEBUG_SUPPORT != 0

  LEDcontrol(0); // Turn LED off

  parse_complete = 0;
  reboot_request = 0;
  restart_request = 0;
  mqtt_close_tcp = 0;
  
  mqtt_start = MQTT_START_TCP_CONNECT;
  mqtt_start_status = MQTT_START_NOT_STARTED;
  mqtt_start_ctr1 = 0;
  mqtt_sanity_ctr = 0;
  MQTT_error_status = 0;
  mqtt_restart_step = MQTT_RESTART_IDLE;
  state_request = STATE_REQUEST_IDLE;
  
  spi_init();              // Initialize the SPI bit bang interface to the
                           // ENC28J60 and perform hardware reset on ENC28J60
  check_eeprom_settings(); // Verify EEPROM up to date
  Enc28j60Init();          // Initialize the ENC28J60 ethernet interface
  uip_arp_init();          // Initialize the ARP module
  uip_init();              // Initialize uIP
  HttpDInit();             // Initialize httpd; sets up listening ports

  // Initialize mqtt client
  mqtt_init(&mqttclient,
            mqtt_sendbuf,
            sizeof(mqtt_sendbuf),
            &uip_buf[UIP_IPTCPH_LEN + UIP_LLH_LEN],
            UIP_APPDATA_SIZE,
            publish_callback);

  LEDcontrol(1); // Turn LED on
  // From here we return to the main loop and should start running with new
  // settings.
}


void reboot(void)
{
  // We need to do a hardware reset (reboot).
  
  // Flicker LED to indicate deliverate reboot
  LEDcontrol(0);     // turn LED off
  wait_timer((uint16_t)50000); // wait 50ms
  LEDcontrol(1);     // turn LED on
  wait_timer((uint16_t)50000); // wait 50ms
  LEDcontrol(0);     // turn LED off
  LEDcontrol(1);     // turn LED on
  wait_timer((uint16_t)50000); // wait 50ms
  
  LEDcontrol(0);  // turn LED off
  
  WWDG_WR = (uint8_t)0x7f;     // Window register reset
  WWDG_CR = (uint8_t)0xff;     // Set watchdog to timeout in 49ms
  WWDG_WR = (uint8_t)0x60;     // Window register value - doesn't matter
                               // much as we plan to reset
				 
  wait_timer((uint16_t)50000); // Wait for watchdog to generate reset
  wait_timer((uint16_t)50000);
  wait_timer((uint16_t)50000);
}


void init_IWDG(void)
{
  // Function to initialize the IWDG (Independent Watchdog).
  // The IWDG will perform a hardware reset after 1 second if it is not
  // serviced with a write to the IWDG_KR register - the main loop needs to
  // perform the servicing writes.
  
  IWDG_KR  = 0xcc;  // Enable the IWDG
  IWDG_KR  = 0x55;  // Unlock the configuration registers
  IWDG_PR  = 0x06;  // Divide clock by 256
  IWDG_RLR = 0xff;  // Countdown reload value. The /2 prescaler plus the
                    // Divisor plus the Countdown value create the 1 second
		    // timeout interval
  IWDG_KR  = 0xaa;  // Start the IWDG. The main loop must write this value
                    // before the 1 second timeout occurs to prevent the
		    // watchdog from performing a hardware reset.
}


// The following enum PORTS, struct io_registers, struct io_mapping, and
// struct io_mapping io_map are used to direct the read_input_pins() and
// write_output_pins functions to the correct registers and bits for each
// physical pin that is being read or written. This significantly reduces
// the code size for these functions. Credit to Carlos Ladeira for this
// clever implementation.

enum PORTS { PA, PB, PC, PD, PE, PF, PG, NUM_PORTS };

struct io_registers {
	volatile char odr;	// Data Output Latch reg
	volatile char idr;	// Input Pin Value reg
	volatile char ddr;	// Data Direction
	volatile char cr1;	// Control register 1
	volatile char cr2;	// Control register 2
};

struct io_mapping {
	uint8_t port;		// port
	uint8_t bit;		// port bit
};

volatile struct io_registers io_reg[ NUM_PORTS ]	@0x5000;	// make room for PA .. PG starting at 0x5000

const struct io_mapping io_map[16] = {
	{ PA, 0x08 },    // PA bit3, IO1
	{ PA, 0x20 },    // PA bit5, IO2
	{ PD, 0x40 },    // PD bit6, IO3
	{ PD, 0x10 },    // PD bit4, IO4
	{ PD, 0x04 },    // PD bit2, IO5
	{ PE, 0x01 },    // PE bit0, IO6
	{ PG, 0x02 },    // PG bit1, IO7
	{ PC, 0x80 },    // PC bit7, IO8
	{ PA, 0x10 },    // PA bit4, IO9
	{ PD, 0x80 },    // PD bit7, IO10
	{ PD, 0x20 },    // PD bit5, IO11
	{ PD, 0x08 },    // PD bit3, IO12
	{ PD, 0x01 },    // PD bit0, IO13
	{ PE, 0x08 },    // PE bit3, IO14
	{ PG, 0x01 },    // PG bit0, IO15
	{ PC, 0x40 }     // PC bit6, IO16
};


void read_input_pins(void)
{
  // This function reads and debounces the IO pins. The purpose is to
  // debounce the Input pins, but both the Input and Output registers are
  // debounced as a matter of code simplicity.
  // The function works as follows:
  // - Pins are read and stored in the ON_OFF_word_new1 word.
  // - ON_OFF_word_new1 is compared to the prior value stored in
  //   ON_OFF_word_new2 using xor
  // - If a bit in ON_OFF_word_new1 is the same as in ON_OFF_word_new2 then
  //   ON_OFF_word is updated.
  // - ON_OFF_word_new1 is transferred to ON_OFF_word_new2 for the next round.
  // Note that any of the 16 IO pins could be an input or output. This
  // function will execute on all pins regardless of direction.
  uint16_t xor_tmp;
  uint16_t mask;
  // it's cheaper in terms of code space using int, instead of uint8_t !
  int i;

  // loop across all i/o's and read input port register:bit state
  // and 
  // The following compares the _new1 and _new2 samples and only updates the
  // bits in the ON_OFF_word where the corresponding bits match in _new1 and
  // _new2 (ie, a debounced change occurred).
  // if ((ON_OFF_word_new1 & mask) == (ON_OFF_word_new2 & mask)) { // match?
  
  for (i=0, mask=1; i<16; i++, mask<<=1) {
    // is it the corresponding bit of the input port register set?
    if ( io_reg[ io_map[i].port ].idr & io_map[i].bit)
      ON_OFF_word_new1 |= (uint16_t)mask;
    else
      ON_OFF_word_new1 &= (uint16_t)(~mask);
    // If the old and new bits match, and the bit is for an Input
    // pin, set or clear the corresponding bit in ON_OFF_word.
    if ((pin_control[i] & 0x02) == 0x00) { // input?
      if (ON_OFF_word_new2 & mask) ON_OFF_word |= mask; // set
      else                         ON_OFF_word &= ~mask; // clear
    }
  }

  // Copy _new1 to _new2 for the next round
  ON_OFF_word_new2 = ON_OFF_word_new1;
  
  // Update the pin_control bytes to match the debounced ON_OFF_word.
  // Only input pin_control bytes are updated.
  for (i=0, mask=1; i<16; i++, mask<<=1) {
    //uint16_t mask = 1 << i;
    if ((pin_control[i] & 0x02) == 0x00) { // input?
      if (ON_OFF_word & mask) pin_control[i] |= 0x80;
      else                    pin_control[i] &= 0x7f;
    }
  }
}


void write_output_pins(void)
{
  // This function updates the Output GPIO pins to match the output pin
  // states.
  //
  // The Invert_word is used to flip the state of of the Output pins.
  // If the Invert_word bit associated with a given pin is = 0, then a 0 in
  // the associated bit of the ON_OFF_word sets the output pin to 0.
  // If the Invert_word bit associated with a given pin is = 1, then a 0 in
  // the associated bit of the ON_OFF_word sets the output pin to 1.

  uint16_t xor_tmp;
  // it's cheaper in terms of code space using int, instead of uint8_t !
  int i;
  int j;

  // Update the output pins to match the bits in the ON_OFF_word.
  // To simplify code this function writes all pins. Note that if the pin is
  // configured as an Input writing the ODR will have no effect, thus the
  // routine does not need to check if the pin is an input or output.

  // Invert the output if the Invert_word has the corresponding bit set.
  xor_tmp = (uint16_t)(Invert_word ^ ON_OFF_word);

  // XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
  // When DS18B20 mode is enabled do not write Output 16
  // XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
//  if (stored_config_settings & 0x08) j = 14;
  if (stored_config_settings & 0x08) j = 15;
  else j = 16;

  // loop across all i/o and set or clear them according to the mask
  for (i=0; i<j; i++) {
    if (xor_tmp & (1 << i))
      io_reg[ io_map[i].port ].odr |= io_map[i].bit;
    else
      io_reg[ io_map[i].port ].odr &= (uint8_t)(~io_map[i].bit);
  }
}



void check_reset_button(void)
{
  // Check to see if the button is pressed. Check the button every 50ms
  // for 5 seconds. If the button remains pressed that entire time then
  // clear the magic number and reset the code.
  uint8_t i;
  
  if ((PA_IDR & 0x02) == 0x00) {
    // Reset Button pressed
    for (i=0; i<100; i++) {
      wait_timer(50000); // wait 50ms
      IWDG_KR = 0xaa; // Prevent the IWDG hardware watchdog from firing.
      if ((PA_IDR & 0x02) == 0x02) { // check Reset Button again. If released
                                  // exit.
        return;
      }
    }
    // If we got here the button remained pressed for 5 seconds
    // Turn off the LED, clear the magic number, and reset the device
    LEDcontrol(0);  // turn LED off
    unlock_eeprom();
    magic4 = 0x00;
    magic3 = 0x00;
    magic2 = 0x00;
    magic1 = 0x00;
    lock_eeprom();

    while((PA_IDR & 0x02) == 0x00) {  // Wait for button release
    }

    WWDG_WR = (uint8_t)0x7f;       // Window register reset
    WWDG_CR = (uint8_t)0xff;       // Set watchdog to timeout in 49ms
    WWDG_WR = (uint8_t)0x60;       // Window register value - doesn't matter
                                   // much as we plan to reset
				 
    wait_timer((uint16_t)50000);   // Wait for watchdog to generate reset
    wait_timer((uint16_t)50000);
    wait_timer((uint16_t)50000);
  }
}


void debugflash(void)
{
  uint8_t i;

  // XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
  // DEBUG - BLINK LED ON/OFF XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
  // XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
  // xxxxxxxxxx  // XXXX   X      X  X   X  X  X    XXXXXXXXXXXXXXXXXXXXXXX
  // xxxxxxxxxx  // X   X  X      X  XX  X  X X     XXXXXXXXXXXXXXXXXXXXXXX
  // xxxxxxxxxx  // XXXX   X      X  X X X  XX      XXXXXXXXXXXXXXXXXXXXXXX
  // xxxxxxxxxx  // X   X  X      X  X  XX  X X     XXXXXXXXXXXXXXXXXXXXXXX
  // xxxxxxxxxx  // XXXX   XXXXX  X  X   X  X  X    XXXXXXXXXXXXXXXXXXXXXXX
  // XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
  //
  // Turns LED off for 1/2 second, then on and waits 1/2 second
  
  LEDcontrol(0);     // turn LED off
  for(i=0; i<10; i++) wait_timer((uint16_t)50000); // wait 500ms
  
  IWDG_KR = 0xaa; // Prevent the IWDG hardware watchdog from firing.
  
  LEDcontrol(1);     // turn LED on
  for(i=0; i<10; i++) wait_timer((uint16_t)50000); // wait 500ms
  
  IWDG_KR = 0xaa; // Prevent the IWDG hardware watchdog from firing.
}


void fastflash(void)
{
  uint8_t i;

  // XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
  // DEBUG - BLINK LED ON/OFF XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
  // XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
  // xxxxxxxxxx  // XXXX   X      X  X   X  X  X    XXXXXXXXXXXXXXXXXXXXXXX
  // xxxxxxxxxx  // X   X  X      X  XX  X  X X     XXXXXXXXXXXXXXXXXXXXXXX
  // xxxxxxxxxx  // XXXX   X      X  X X X  XX      XXXXXXXXXXXXXXXXXXXXXXX
  // xxxxxxxxxx  // X   X  X      X  X  XX  X X     XXXXXXXXXXXXXXXXXXXXXXX
  // xxxxxxxxxx  // XXXX   XXXXX  X  X   X  X  X    XXXXXXXXXXXXXXXXXXXXXXX
  // XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
  //
  // Makes LED flicker for 1 second

  for (i=0; i<10; i++) {
    LEDcontrol(0);     // turn LED off
    wait_timer((uint16_t)50000); // wait 50ms
  
    LEDcontrol(1);     // turn LED on
    wait_timer((uint16_t)50000); // wait 50ms
    
    IWDG_KR = 0xaa; // Prevent the IWDG hardware watchdog from firing.
  }
}


void oneflash(void)
{
  uint8_t i;

  // XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
  // DEBUG - BLINK LED ON/OFF XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
  // XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
  // xxxxxxxxxx  // XXXX   X      X  X   X  X  X    XXXXXXXXXXXXXXXXXXXXXXX
  // xxxxxxxxxx  // X   X  X      X  XX  X  X X     XXXXXXXXXXXXXXXXXXXXXXX
  // xxxxxxxxxx  // XXXX   X      X  X X X  XX      XXXXXXXXXXXXXXXXXXXXXXX
  // xxxxxxxxxx  // X   X  X      X  X  XX  X X     XXXXXXXXXXXXXXXXXXXXXXX
  // xxxxxxxxxx  // XXXX   XXXXX  X  X   X  X  X    XXXXXXXXXXXXXXXXXXXXXXX
  // XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
  //
  // Turns LED off for 25ms then back on

  LEDcontrol(0);     // turn LED off
  wait_timer((uint16_t)25000); // wait 25ms
  
  LEDcontrol(1);     // turn LED on
}


void clear_eeprom_debug_bytes(void)
{
  // Clear debug bytes in the EEPROM
  uint8_t i;
  
#if DEBUG_SUPPORT == 1
  // Clear all debug bytes
  for (i = 0; i < NUM_DEBUG_BYTES; i++) debug[i] = 0x00;
  // Update EEPROM bytes that changed
  update_debug_storage1();
#endif // DEBUG_SUPPORT == 1

#if DEBUG_SUPPORT == 2
  // Clear the general debug bytes
  for (i = 0; i < (NUM_DEBUG_BYTES - 10); i++) debug[i] = 0x00;
  // Recover the debug bytes
  for (i = 20; i < 30; i++) debug[i] = stored_debug[i];
  // Update EEPROM bytes that changed
  update_debug_storage1();
#endif // DEBUG_SUPPORT == 2

}


#if DEBUG_SUPPORT != 0
// Note: Make sure there is enough RAM for the debug[] values.
void update_debug_storage() {
  uint8_t i;
  
  unlock_eeprom();
  
  // To use this function it is intended that you fill the debug[]
  // somewhere in inline code, then call this function to commit
  // them to EEPROM. debug[0] should be 0 until your are ready for
  // the snapshot to occur, then set debug[0] to one and call this
  // function. The function will set debug[0] to two after the
  // snapshot to help assure it only happens once. You can then
  // read the stored values from EEPROM with the STVP programmer.
  if (debug[0] == 0x01) {
    debug[0] = 0x02;
    for (i = 0; i < NUM_DEBUG_BYTES; i++) {
      if (stored_debug[i] != debug[i]) stored_debug[i] = debug[i];
    }
    fastflash();
  }
  
  lock_eeprom();
  
//
//  while(debug[0] == 0x02);
//    // This loop can be enabled if you want the program to
//    // hang after capturing data.
}
#endif // DEBUG_SUPPORT != 0


#if DEBUG_SUPPORT != 0
// Note: Make sure there is enough RAM for the debug[] values.
void update_debug_storage1() {
  uint8_t i;
  
  unlock_eeprom();
  
  // This function is nearly identical to update_debug_storage()
  // with the exception that it is intended to be called multiple
  // times as individual debug[] bytes are written in inline
  // code. This is helpful if it is not clear where a fault may
  // occur in a series of scattered debug[] byte writes. Note this
  // function does not use the debug[0] flag to prevent additional
  // calls.
  // Consider putting a while(something) in the code to stop
  // processing so you can look at the results.
  for (i = 0; i < NUM_DEBUG_BYTES; i++) {
    if (stored_debug[i] != debug[i]) stored_debug[i] = debug[i];
  }
//  fastflash();
  
  lock_eeprom();
  
}
#endif // DEBUG_SUPPORT != 0


#if DEBUG_SUPPORT != 0
void capture_uip_buf_transmit()
{
  uint8_t i;
  // This function was written specifically to capture the uip_buf
  // when it contains transmit data. There is a nearly identical
  // routine for capturing the uip_buf when it contains receive data,
  // the principal difference being the triggers used to examine the
  // debug[] bytes before committing to EEPROM. Note that an offset
  // can be added to uip_buf to capture bytes further out in the
  // buffer.
  // debug[0] is used to signal completion of a capture and to prevent
  //   overwriting an existing capture.
  // debug[1] can be used to set an easily recognizable "marker byte"
  //   in the EEPROM, and/or to act as a counter for capturing the
  //   second, third, fourth, etc calls of the function.
  if (debug[0] == 0x00) {
    pBuffer2 = uip_buf;
    for (i = 2; i < NUM_DEBUG_BYTES; i++) {
      debug[i] = *pBuffer2;
      pBuffer2++;
    }
//    if ((debug[1] == 0x00) && (debug[38] == 0x07) && (debug[39] == 0x5b) && ((debug[49] & 0x10) == 0x10)) {
      // Signal a capture on ACK transmission to the Broker Server.
//    if (debug[1] == 0x00 && debug[38] == 0x07 && debug[39] == 0x5b) {
      // Signal a capture on any transmission to the Broker Server.
      // Set debug[1] == xx to a higher number if you want to capture
      // subsequent transmissions.
    if (debug[1] == 0x00) {
      // Signal a capture on anything
      debug[0] = 0x01;
      debug[1] = 0x98; // Signal a transmit capture
    }
//    else if (debug[38] == 0x07 && debug[39] == 0x5b) {
//      // Else increment the capture trigger.
//      debug[1]++;
//    }
    update_debug_storage();
  }
}
#endif // DEBUG_SUPPORT != 0




#if DEBUG_SUPPORT != 0
void capture_mqtt_sendbuf()
{
  uint8_t i;
  // This function was written specifically to capture the mqtt_sendbuf.
  // debug[0] is used to make sure a single capture occurs.
  if (debug[0] == 0x00) {
    // debug[1] and debug[2] are used for capture tags
    pBuffer2 = mqtt_sendbuf;
    for (i = 3; i < NUM_DEBUG_BYTES; i++) {
      debug[i] = *pBuffer2;
      pBuffer2++;
    }
    debug[0] = 0x01; // Signal a capture
    update_debug_storage(); // Write to EEPROM
  }
}
#endif // DEBUG_SUPPORT != 0




#if DEBUG_SUPPORT != 0
void capture_uip_buf_receive()
{
  uint8_t i;
  // See the description for capture_uip_buf_transmit
  if (debug[0] == 0x00) {
    pBuffer2 = uip_buf;
    for (i = 2; i < NUM_DEBUG_BYTES; i++) {
      debug[i] = *pBuffer2;
      pBuffer2++;
    }
//    if (debug[1] == 0x00 && debug[38] == 0x07 && debug[39] == 0x5b && (debug[49] & 0x12) == 0x12) {
    // Signal a capture on SYN-ACK from Broker Server
//    if (debug[1] == 0x00 && debug[38] == 0x07 && debug[39] == 0x5b && (debug[49] & 0x10) == 0x10) {
    // Signal a capture on ACK from Broker Server
//    if (debug[1] == 0x00 && debug[38] == 0x07 && debug[39] == 0x5b) {
    // Signal a capture on anything from Broker Server
    if (debug[1] == 0x01) {
      // Signal a capture on anything from Ethernet
      // Set debug[1] == xx to a higher number if you want to capture
      // subsequent transmissions.
      debug[0] = 0x01;
      debug[1] = 0x99;  // Signal a receive capture
    }
    else if (debug[38] == 0x07 && debug[39] == 0x5b) {
      // Else increment the capture trigger.
      debug[1]++;
    }
    update_debug_storage();
  }
}
#endif // DEBUG_SUPPORT != 0      
