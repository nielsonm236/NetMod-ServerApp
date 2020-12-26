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

/*---------------------------------------------------------------------------*/
/*---------------------------------------------------------------------------*/
/*---------------------------------------------------------------------------*/
const char code_revision[] = "20201226 1220";
/*---------------------------------------------------------------------------*/
/*---------------------------------------------------------------------------*/
/*---------------------------------------------------------------------------*/


#if MQTT_SUPPORT == 1
#include "mqtt.h"
#endif // MQTT_SUPPORT == 1

/*---------------------------------------------------------------------------*/
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
// following directive needs to be placed in the linker file before the object
// file where the variables are declared. This directive will place the two
// stack limit variables at 0x5fe and 0x5ff.
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
// edit the .prjsm8 file. Make sure the following line is in the .prjsm8 file:
//   LinkFileAutomatic=NO
// When you first install IdeaSTM8 the default is for the program to auto
// generate the .lkf file each time a build is done. This is useful because
// it creates all the linker commands you typically need. However, when you
// reach the point that you need to make your own changes to the .lkf file
// edit access is disabled until the LinkFileAutomatic line is modified.
/*---------------------------------------------------------------------------*/



/*---------------------------------------------------------------------------*/
// EEPROM variable declarations
// When using the Cosmic compiler all variables stored in EEPROM must be
// declared with the @eeprom identifier. This signals the Cosmic compiler and
// linker to treat the variables as special and located in the EEPROM. Code
// must unlock the EEPROM before using the variables.
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
// should be added above the "magic" numbers in the list below. That will keep
// all existing variables in the same place in EEPROM which will allow new
// code updates to discover the magic number and existing settings.
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
                                        // 46 debug bytes
					// Byte 128 stored_debug[45]
                                        // Byte 83 stored_debug[0]
#endif // DEBUG_SUPPORT != 0

// 82 bytes used below
// >>> Add new variables HERE <<<
// Reduce the size of the stored_debug[] array by the number of bytes added
@eeprom uint8_t stored_config_settings[6]; // Byte 77-82 Config settings for
                                           //   Invert, Retain, Full/Half
					   //   Duplex
@eeprom uint8_t stored_IO_16to9;           // Byte 76 States for IO 16 to 9
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
@eeprom uint8_t stored_unused2;            // Byte 23 Old stored_IO_16to9
                                           //   location - DO NOT USE
@eeprom uint8_t stored_unused1;            // Byte 22 Old stored_IO_8to1
                                           //   location - DO NOT USE
@eeprom uint8_t stored_IO_8to1;            // Byte 21 States for IO 8 to 1
@eeprom uint8_t stored_devicename[20];     // Byte 01 Device name @4000
/*---------------------------------------------------------------------------*/


#if DEBUG_SUPPORT != 0
/*---------------------------------------------------------------------------*/
// Note: Make sure there is enough RAM for the debug[] values. These bytes are
// used to pass debug information from the code in other .c files to this one,
// and to help control the number of writes done to the EEPROM (to reduce
// write wear). When needed the debug[] data is stored in EEPROM in the
// corresponding stored_debug[] values so they can be read by the developer
// via the STVP programmer.
uint8_t *pBuffer2;
uint8_t debug[NUM_DEBUG_BYTES];
/*---------------------------------------------------------------------------*/
#endif // DEBUG_SUPPORT != 0


uint8_t IO_16to9;			// Stores the IO states
uint8_t IO_8to1;			// Stores the IO states
uint8_t IO_16to9_new1;			// Stores the IO states for debounce
uint8_t IO_8to1_new1;			// Stores the IO states for debounce
uint8_t IO_16to9_new2;			// Stores the IO states for debounce
uint8_t IO_8to1_new2;			// Stores the IO states for debounce
uint8_t IO_16to9_sent;                  // Stores prior IO states for creating
                                        // Publish msgs
uint8_t IO_8to1_sent;                   // Stores prior IO states for creating
                                        // Publish msgs
uint8_t invert_output;			// Stores the relay pin invert
uint8_t invert_input;			// Stores the input pin invert
uint8_t state_request;			// Indicates that a PUBLISH state
                                        // request was received

uint8_t stack_error;			// Stack error flag storage

/*---------------------------------------------------------------------------*/
// Pending values are used to pass change requests from the user to the main.c
// functions. Code in the main.c file will compare the values in use to the
// "pending" values to determine if any changes occurred, and if so code will
// update the "in use" values and will restart the firmware if needed.

#if MQTT_SUPPORT == 1
uint8_t Pending_mqttserveraddr[4];
uint16_t Pending_mqttport;
char Pending_mqtt_username[11];
char Pending_mqtt_password[11];
#endif // MQTT_SUPPORT == 1

uint8_t Pending_hostaddr[4];
uint8_t Pending_draddr[4];
uint8_t Pending_netmask[4];

uint16_t Pending_port;

uint8_t Pending_devicename[20];

uint8_t Pending_config_settings[6];

uint8_t Pending_uip_ethaddr_oct[6];

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

uint32_t time_mark1;            // Time capture used in reboot
extern uint32_t second_counter; // Time in seconds

extern uint8_t OctetArray[11];  // Used in emb_itoa conversions

uint32_t RXERIF_counter;              // Counts RXERIF errors detected by the
                                      // ENC28J60
uint32_t TXERIF_counter;              // Counts TXERIF errors detected by the
                                      // ENC28J60
uint32_t TRANSMIT_counter;            // Counts any transmit by the ENC28J60


#if MQTT_SUPPORT == 1
// XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
// It may be more appropriate for some of these values to be defined in a
// different area of this module or in a different module. They are here
// until that is determined.
uint8_t connect_flags;                // Used in MQTT setup
uint16_t mqttport;             	      // MQTT port number
uint16_t Port_Mqttd;                  // In use MQTT port number
unsigned char application_message[4]; // Stores the application message. In
                                      // In this application the message is
				      // always ON or OFF, or is a two byte
				      // binary value used in response to the
				      // state-req message.
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
// uint8_t mqtt_restart_backoff;         // Used to increase the time between
                                      // restart attempts when a communication
				      // loss is long term.

static const unsigned char devicetype[] = "NetworkModule/"; // Used in
                                      // building topic and client id names
unsigned char topic_base[51];         // Used for building connect, subscribe,
                                      // and publish topic strings.
				      // Longest string content:
				      // NetworkModule/DeviceName123456789/availability
				      // NetworkModule/DeviceName123456789/output/+/set
				      // homeassistant/binary_sensor/macaddressxx/01/config
uint32_t MQTT_resp_tout_counter;      // Counts response timeout events in the
                                      // mqtt_sanity_check() function
uint32_t MQTT_not_OK_counter;         // Counts MQTT != OK events in the
                                      // mqtt_sanity_check() function
uint32_t MQTT_broker_dis_counter;     // Counts broker disconnect events in
                                      // the mqtt_sanity_check() function
uint8_t out_num = 1;                  // Initialize output number counter
                                      // for Home Assistant Auto Discovery
uint8_t in_num = 1;                   // Initialize input number counter
                                      // for Home Assistant Auto Discovery

#endif // MQTT_SUPPORT == 1


/*---------------------------------------------------------------------------*/
int main(void)
{
  uint8_t i;
  uip_ipaddr_t IpAddr;
  
  parse_complete = 0;
  mqtt_parse_complete = 0;
  reboot_request = 0;
  user_reboot_request = 0;
  restart_request = 0;
  time_mark1 = 0;           // Time capture used in reboot
  restart_reboot_step = RESTART_REBOOT_IDLE;
  mqtt_close_tcp = 0;
  stack_error = 0;
  
  init_IWDG(); // Initialize the hardware watchdog
  
#if MQTT_SUPPORT == 1
  mqtt_start = MQTT_START_TCP_CONNECT;	 // Tracks the MQTT startup steps
  mqtt_start_status = MQTT_START_NOT_STARTED; // Tracks error states during
                                         // startup
  mqtt_keep_alive = 60;                  // Ping interval in seconds
//  mqtt_keep_alive = 10;                  // Ping interval in seconds
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
  out_num = 1;                           // Initialize output number counter
                                         // for Home Assistant Auto Discovery
  in_num = 1;                            // Initialize input number counter
                                         // for Home Assistant Auto Discovery

#endif // MQTT_SUPPORT == 1



  clock_init();            // Initialize and enable clocks and timers

  gpio_init();             // Initialize and enable gpio pins
  
  spi_init();              // Initialize the SPI bit bang interface to the
                           // ENC28J60 and perform hardware reset on ENC28J60

  LEDcontrol(1);           // turn LED on
  
  check_eeprom_settings(); // Check the EEPROM for previously stored Address
                           // and Relay settings. Use defaults (if nothing
			   // stored) or restore previously stored settings.

  Enc28j60Init();          // Initialize the ENC28J60 ethernet interface

  uip_arp_init();          // Initialize the ARP module
  
  uip_init();              // Initialize uIP Web Server
  
  HttpDInit();             // Initialize listening ports

  // The following initializes the stack over-run guardband variables. These
  // variables are monitored periodically and should never change unless there
  // is a stack overflow (wherein the stack will over write this preset
  // content).
  stack_limit1 = 0xaa;
  stack_limit2 = 0x55;


#if MQTT_SUPPORT == 1
  // Initialize mqtt client
  mqtt_init(&mqttclient,
            mqtt_sendbuf,
	    sizeof(mqtt_sendbuf),
	    &uip_buf[UIP_IPTCPH_LEN + UIP_LLH_LEN],
	    UIP_APPDATA_SIZE,
	    publish_callback);
#endif // MQTT_SUPPORT == 1


#if DEBUG_SUPPORT == 2 || DEBUG_SUPPORT == 3
// Check RST_SR (Reset Status Register)
/*
  // Uncomment this for one build, one run to zero the counters. Note that
  // during debug it is normal for the RST_SR to have the SWIMF flag set at
  // startup as you typically release the board from a SWIM reset to start
  // it.
  unlock_eeprom();
  stored_debug[41] = 0;
  stored_debug[42] = 0;
  stored_debug[43] = 0;
  stored_debug[44] = 0;
  stored_debug[45] = 0;
  lock_eeprom();
*/
  if (RST_SR & 0x1f) {
    // Bit 4 EMCF: EMC reset flag
    // Bit 3 SWIMF: SWIM reset flag
    // Bit 2 ILLOPF: Illegal opcode reset flag
    // Bit 1 IWDGF: Independent Watchdog reset flag
    // Bit 0 WWDGF: Window Watchdog reset flag
    if (RST_SR & 0x10) debug[41] = (uint8_t)(debug[41] + 1);
    if (RST_SR & 0x08) debug[42] = (uint8_t)(debug[42] + 1);
    if (RST_SR & 0x04) debug[43] = (uint8_t)(debug[43] + 1);
    if (RST_SR & 0x02) debug[44] = (uint8_t)(debug[44] + 1);
    if (RST_SR & 0x01) debug[45] = (uint8_t)(debug[45] + 1);
    update_debug_storage1();
    if (RST_SR & 0x17) {
      // Trigger reboot LED signal on any except SWIMF
      fastflash();
      debugflash();
      fastflash();
      debugflash();
      fastflash();
      debugflash();
      fastflash();
    }
    RST_SR = (uint8_t)(RST_SR | 0x1f); // Clear the flags
  }
#endif // DEBUG_SUPPORT == 2 || DEBUG_SUPPORT == 3


  while (1) {
    // Overview of the main loop:
    // - The ENC28J60 does the hardware level work of receiving ethernet
    //   packets. It receives ethernet traffic and, based on the MAC address
    //   in the incoming traffic, the ENC28J60 filters out all traffic except
    //   that traffic directed at the Network Module.
    //   - Enc28j60Receive(uip_buf) is called to receive a single packet from
    //     the ENC28J60 and copy it to the uip_buf. Additional packets may be
    //     queued in the ENC28J60 hardware, but packets are read and processed
    //     one at a time. When a packet is copied to the uip_buf the value
    //     uip_len is set to the size of the received data (total of LLH, IP
    //     and TCP headers plus the application data).
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
    //   HTTP or MQTT data that may be pending (only one packet per
    //   pass of the main loop). Typically only MQTT generates asynchronous
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

#if MQTT_SUPPORT == 1
    // Perform MQTT startup if 
    // a) Not already at start complete
    // b) Not currently performing the restart steps
    // c) Not currently performing restart_reboot
    if (mqtt_start != MQTT_START_COMPLETE
     && mqtt_restart_step == MQTT_RESTART_IDLE
     && restart_reboot_step == RESTART_REBOOT_IDLE) {
       mqtt_startup();
    }
    
    // Perform MQTT sanity check if
    // a) Not currently performing MQTT startup
    // b) Not currently performing restart_reboot
    if (mqtt_start == MQTT_START_COMPLETE
     && restart_reboot_step == RESTART_REBOOT_IDLE) {
      mqtt_sanity_check();
    }
#endif // MQTT_SUPPORT == 1

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


#if MQTT_SUPPORT == 1
    // If MQTT is connected check for pin state changes and publish a message
    // at 50ms intervals. publish_outbound only places the message in the
    // queue. uip_periodic() will cause the actual transmission.
    if (mqtt_outbound_timer_expired()) {
      if (mqtt_start == MQTT_START_COMPLETE) {
        publish_outbound();
      }
    }
    
    // Increment the MQTT timers every 100ms
    if (mqtt_timer_expired()) {
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
#endif // MQTT_SUPPORT == 1


    // Call the ARP timer function every 10 seconds.
    if (arp_timer_expired()) {
      uip_arp_timer(); // Clean out old ARP Table entries. Any entry that has
                       // exceeded the UIP_ARP_MAXAGE without being accessed
		       // is cleared. UIP_ARP_MAXAGE is typically 20 minutes.
    }
        
    // Check for changes in Relay control states, IP address, IP gateway
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
// Note that the ENC28J60 must be told what the MAC Network Module address is.
// But the ENC28J60 only uses the MAC address for receive filtering. The
// application (not the ENC28J60) must insert the MAC address as needed in any
// packets for transmission. This occurs in the uip.c and uip_arp.c functions.
//
// The application has hardcoded "factory defaults" for the IP Address,
// Gateway Address, Netmask, Port number, and MAC Address. The user is able to
// change any of these and the changes are stored in EEPROM. Thereafter the
// software uses the addresses from the EEPROM at power on so that user inputs
// are retained through power cycles.
//
// The user can press the Reset Button for 10 seconds to restore "factory
// defaults".


#if MQTT_SUPPORT == 1
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
  //     also perform an ARP request with the MQTT server. Both requests occur
  //     via the uip_connect() function, and are executed via the
  //     uip_periodic function.
  //   - Verifies that the ARP request succeeded.
  //   - Verifies that the TCP connection request suceeded.
  //   - Initializes communication with the MQTT Broker.
  
  if (mqtt_start == MQTT_START_TCP_CONNECT) {
    if (stored_mqttserveraddr[3] != 0) {
      // When first powering up or on a reboot we need to initialize the
      // MQTT processes.
      //
      // A brand new device won't have a MQTT Server IP Address defined
      // (as indicated by an all zeroes address). So these steps won't be
      // executed unless a non-zero MQTT Server address is found. The user
      // can input a MQTT Server IP Address and Port number via the GUI. A
      // restart will automatically take place when the values are submitted
      // in the GUI.
      //
      // The first step is to create a TCP Connection Request to the MQTT
      // Server. This is done with uip_connect(). uip_connect() doesn't
      // actually send anything - it just queues the SYN to be sent. The
      // connection request will actually be sent when uip_periodic is
      // called. uip_periodic will determine that the connection request is
      // queued, will perform an ARP request to determine the MAC of the MQTT
      // server, and will then send the SYN to start the connection process.

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
    }
  }
      
  else if (mqtt_start == MQTT_START_VERIFY_ARP
        && mqtt_start_ctr2 > 2) {
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

  else if (mqtt_start == MQTT_START_VERIFY_TCP
        && mqtt_start_ctr2 > 2) {
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
      
  else if (mqtt_start == MQTT_START_QUEUE_CONNECT
        && mqtt_start_ctr2 > 2) {
    // ARP Reply received from the MQTT Server and TCP Connection established.
    // We should now be able to message the MQTT Broker, but will wait 300ms
    // to give some start time.

    // Queue the mqtt_connect message for transmission to the MQTT Broker. The
    // mqtt_connect function will create the message and put it in the
    // mqtt_sendbuf queue.
    // uip_periodic() will start the process that will call mqtt_sync to copy
    // the message from the mqtt_sendbuf to the uip_buf.
  
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
    
    // When a CONNECT is sent to the broker it should respond with a CONNACK.
    connack_received = 0;
    mqtt_start_ctr1 = 0; // Clear 100ms counter
    mqtt_start = MQTT_START_VERIFY_CONNACK;
  }

  else if (mqtt_start == MQTT_START_VERIFY_CONNACK) {
    // Verify that the CONNECT CONNACK was received.
    // When a CONNECT is sent to the broker it should respond with a CONNACK.
    // Since the Broker won't send us anything else until this CONNACK occurs
    // this step waits for the CONNACK, but will timeout after X seconds. A
    // workaround is implemented with the global variable connack_received so
    // that the mqtt.c code can tell the main.c code that the CONNECT CONNACK
    // was received.

    if (mqtt_start_ctr1 < 30) {
      // Allow up to 15 seconds for CONNACK
//      if (connack_received == 1 && mqttclient.error == MQTT_OK) {
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
  }

  else if (mqtt_start == MQTT_START_QUEUE_SUBSCRIBE1
        && mqtt_start_ctr2 > 2) {
    // Subscribe to the output control messages
    //
    // Queue the mqtt_subscribe messages for transmission to the MQTT
    // Broker. Wait 300ms before queueing first Subscribe msg.
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
    mqtt_subscribe(&mqttclient, topic_base, 0);
    mqtt_start_ctr2 = 0; // Clear 100ms counter
    mqtt_start = MQTT_START_QUEUE_SUBSCRIBE2;
  }
    
  else if (mqtt_start == MQTT_START_QUEUE_SUBSCRIBE2
        && mqtt_start_ctr2 > 2) {
    // Subscribe to the state-req message
    //
    // Wait 300ms before queuing the Subscribe message 
    strcpy(topic_base, devicetype);
    strcat(topic_base, stored_devicename);
    strcat(topic_base, "/state-req");
    mqtt_subscribe(&mqttclient, topic_base, 0);
    mqtt_start_ctr2 = 0; // Clear 100ms counter
#if HOME_ASSISTANT_SUPPORT == 1
    mqtt_start = MQTT_START_QUEUE_PUBLISH_AUTO;
    out_num = 1;
    in_num = 1;
    mqtt_start_ctr2 = 0;
#else
    mqtt_start = MQTT_START_QUEUE_PUBLISH_ON;
#endif // HOME_ASSISTANT_SUPPORT == 1
  }


#if HOME_ASSISTANT_SUPPORT == 1
  else if (mqtt_start == MQTT_START_QUEUE_PUBLISH_AUTO
        && mqtt_start_ctr2 > 2) {
    // Publish Auto Discovery messages
    // This code will create a placeholder publish message. The code
    // in the mqtt_pal.c file will convert the placeholder into the
    // actual Auto Discovery Publish message when it detects the
    // application_message inserted below. This complication is
    // necessary because the MQTT transmit buffer is not large enough
    // to contain an entire Auto Discovery message, so it is
    // constructed on-the-fly into the uip_buf transmit buffer by the
    // mqtt_pal.c code.
    //    mqtt_publish(&mqttclient,
    //                 topic_base,
    //                 "%Oxx",
    //                 4,
    //                 MQTT_PUBLISH_QOS_0 | MQTT_PUBLISH_RETAIN);
    // This message triggers an Input discovery message. "xx" is the input
    // number.
    //    mqtt_publish(&mqttclient,
    //                 topic_base,
    //                 "%Ixx",
    //                 4,
    //                 MQTT_PUBLISH_QOS_0 | MQTT_PUBLISH_RETAIN);

    if (out_num < 9) {
      // Queue publish message
      // Topic: homeassistant/switch/macaddressxx/01/config
      //
      // Convert out_num to alphanumeric char
      emb_itoa(out_num, OctetArray, 10, 2);

      strcpy(topic_base, "homeassistant/switch/");
      strcat(topic_base, mac_string);
      strcat(topic_base, "/");
      strcat(topic_base, OctetArray);
      strcat(topic_base, "/config");
      
      // Convert out_num to the $Oxx string format
      application_message[0] = '%';
      application_message[1] = 'O';
      application_message[2] = OctetArray[0];
      application_message[3] = OctetArray[1];
      application_message[4] = '\0';

      mqtt_publish(&mqttclient,
                   topic_base,
	           application_message,
	           4,
	           MQTT_PUBLISH_QOS_0 | MQTT_PUBLISH_RETAIN);

      out_num++;
      mqtt_start_ctr2 = 0;
    }
    
    else if (in_num < 9) {
      // Queue publish message
      // Topic: homeassistant/binary_sensor/aabbccddeeff/01/config
      //
      // Convert in_num to alphanumeric char
      emb_itoa(in_num, OctetArray, 10, 2);

      strcpy(topic_base, "homeassistant/binary-sensor/");
      strcat(topic_base, mac_string);
      strcat(topic_base, "/");
      strcat(topic_base, OctetArray);
      strcat(topic_base, "/config");
      
      // Convert in_num to the $Ixx string format
      application_message[0] = '%';
      application_message[1] = 'I';
      application_message[2] = OctetArray[0];
      application_message[3] = OctetArray[1];
      application_message[4] = '\0';

      mqtt_publish(&mqttclient,
                   topic_base,
	           application_message,
	           4,
	           MQTT_PUBLISH_QOS_0 | MQTT_PUBLISH_RETAIN);

      in_num++;
      mqtt_start_ctr2 = 0;
      if (in_num == 9) {
        out_num = 1;
        in_num = 1;
        mqtt_start = MQTT_START_QUEUE_PUBLISH_ON;
      }
    }
  }
#endif // HOME_ASSISTANT_SUPPORT == 1


  else if (mqtt_start == MQTT_START_QUEUE_PUBLISH_ON
        && mqtt_start_ctr2 > 2) {
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
    mqtt_start = MQTT_START_QUEUE_PUBLISH_PINS;
  }
  
  else if (mqtt_start == MQTT_START_QUEUE_PUBLISH_PINS
        && mqtt_start_ctr2 > 0) {
    // Wait 100ms before starting
    // Publish the state of all pins one at a time. This is accomplished
    // by setting IO_16to9_sent and IO_8to1_sent to the inverse of whatever
    // is currently in IO_16to9 and IO_8to1. This will cause the normal
    // checks for pin state changes to trigger a transmit for every pin.
    IO_16to9_sent = (uint8_t)(~IO_16to9);
    IO_8to1_sent  = (uint8_t)(~IO_8to1);
    // Indicate succesful completion
    mqtt_start = MQTT_START_COMPLETE;
  }  
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

  if (mqtt_restart_step == MQTT_RESTART_IDLE) {
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
    // != MQTT_OK needs to be qualified with MQTT_START_COMPLETE because a not
    // OK condition can be present prior to mqtt_connect() running.
    if (mqtt_start == MQTT_START_COMPLETE
     && mqttclient.error != MQTT_OK) {
      MQTT_not_OK_counter++;
      mqtt_restart_step = MQTT_RESTART_BEGIN;
    }
  }

  else if (mqtt_restart_step == MQTT_RESTART_BEGIN) {
    // MQTT restart process triggered. The process:
    // 1) Sends an mqtt disconnect just in case there is a connection.
    // 2) Closes the TCP connection.
    // 3) Return to the main loop so that the MQTT start process can run.
    // This process sets up the first two events, but the main.c loop must run
    // so that the uip_periodic() and uip_input() functions will carry out
    // execution of the transmit and receive steps needed.
    mqtt_restart_step = MQTT_RESTART_DISCONNECT_START;
    // Clear the start error indicator flags so the GUI will reflect
    // that we are no longer in a connected state
    mqtt_start_status = MQTT_START_NOT_STARTED;
  }
      
  else if (mqtt_restart_step == MQTT_RESTART_DISCONNECT_START) {
    mqtt_restart_step = MQTT_RESTART_DISCONNECT_WAIT;
    // Disconnect the MQTT client
    mqtt_disconnect(&mqttclient);
    mqtt_sanity_ctr = 0; // Clear 100ms counter
  }
  
  else if (mqtt_restart_step == MQTT_RESTART_DISCONNECT_WAIT) {
    if (mqtt_sanity_ctr > 10) {
      // The mqtt_disconnect() is given 1 second to be communicated
      // before we move on to TCP close
      mqtt_restart_step = MQTT_RESTART_TCPCLOSE;
    }
  }

  else if (mqtt_restart_step == MQTT_RESTART_TCPCLOSE) {
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
    // So, it looks like all I need to do is make sure the APPCALL
    // performs a uip_close() before returning to the UIP code. Then the
    // regular uip_periodic() process should get the job done.
    //
    // Signal uip_TcpAppHubCall() to close the TCP connection
    mqtt_close_tcp = 1;
    // Capture time to delay the next step
    mqtt_sanity_ctr = 0; // Clear 100ms counter
    mqtt_restart_step = MQTT_RESTART_TCPCLOSE_WAIT;
  }
  
  else if (mqtt_restart_step == MQTT_RESTART_TCPCLOSE_WAIT) {
    // Verify closed ... how?
    // For the moment I'm not sure how to do this, so I will just allow
    // enough time for it to happen. That is probably very fast, but I
    // will allow 2 seconds.
    if (mqtt_sanity_ctr > 20) {
      mqtt_close_tcp = 0;
      mqtt_restart_step = MQTT_RESTART_SIGNAL_STARTUP;
    }
  }
    
  else if (mqtt_restart_step == MQTT_RESTART_SIGNAL_STARTUP) {
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
  }
}


/*---------------------------------------------------------------------------*/
  // Note that the original LiamBindle MQTT-C code relied on Linux or
  // Microsoft OS processes to provide Link Level, IP, and TCP processing of
  // received and transmitted packets (via a Socket). In this bare metal
  // application the UIP code provides that processing.
  //
  // Before making an mqtt connection we need the equivalent of an OS "open a
  // socket" to the MQTT Server. This is essentially an ARP request
  // associating the MQTT Server IP Address (which we got from GUI input) with
  // the MQTT Server MAC Address, followed by creating a TCP Connection (via
  // uip_connect()).
  //
  // For reference: In the HTTP IO process "opening a socket" occurs in the
  // uip_input and uip_arpin functions. HTTP has the notion that a browser
  // makes a request, and the web server replies to that request, always in a
  // one-to-one relationship. When a browser on a remote host makes a request
  // to our IP address the remote host performs an ARP request (which we
  // process via the uip_arp_arpin() function). Net result is that this
  // establishes the equivalent of a "socket" with the web server on our
  // device. Subsequent browser requests cause the uip_input() function to
  // extract the IP Addresses and Port Numbers for the HTTP transaction source
  // and destination and uses those to form the needed IP and TCP headers for
  // any transmission that needs to occur. Next the uip_arp_out function is
  // called to form a LLH header (containing the source and destination MAC
  // addresses) for the packet to be transmitted.
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
  // Relay PUBLISH Msg (in the mqtt_sendbuf)
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
/*---------------------------------------------------------------------------*/


void publish_callback(void** unused, struct mqtt_response_publish *published)
{
  char* pBuffer;
  uint8_t pin_value;
  uint8_t ParseNum;
  uint8_t i;
  
  pin_value = 0;
  ParseNum = 0;
  
  // This function will be called if a "publish" is received from the Broker.
  // The publish message will contain a payload that, in this application,
  // will be the relay control bits.
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
  // - Call the httpd.c function GpioSetPin(relay_num, (int8_t)pin_value);
  //   OR
  // - Loop to set or clear "all" pins
  //   OR
  // - Set the state_request variable
  pBuffer = uip_appdata;
  // Skip the Fixed Header Control Byte
  pBuffer = pBuffer + 1;
  // Skip the Fixed Header Remaining Length Byte
  pBuffer = pBuffer + 1;
  // Skip the Topic name length bytes
  pBuffer = pBuffer + 2;
  // Skip the NetworkModule/ text
  pBuffer = pBuffer + 14;
  // Skip the Devicename/ text
  pBuffer = pBuffer + strlen(stored_devicename) + 1;
  
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
    
    // Check if output field is "all"
    if (*pBuffer == 'a') {
      // Determine if payload is ON or OFF
      pBuffer+=8;
      if (*pBuffer == 'N') {
        // Turn all outputs ON
	for (i=0; i<8; i++) GpioSetPin(i, 1);
      }
      if (*pBuffer == 'F') {
       // Turn all outputs OFF
	for (i=0; i<8; i++) GpioSetPin(i, 0);
      }
    }
    
    else if (*pBuffer == '0' || *pBuffer == '1') {
      // Output field is a digit
      // Collect the relay number
      // Parse ten's digit
      ParseNum = (uint8_t)((*pBuffer - '0') * 10);
      pBuffer++;
      // Parse one's digit
      ParseNum += (uint8_t)(*pBuffer - '0');
      // Verify ParseNum is in the correct range
      if (ParseNum > 0 && ParseNum < 9) {
        // Adjust Parsenum to match 0 to 7 numbering (instead of 1to8)
        ParseNum--;
	// Determine if payload is ON or OFF
	pBuffer+=6;
	if (*pBuffer == 'N') {
	  // Turn output ON
          GpioSetPin(ParseNum, 1);
	}
	if (*pBuffer == 'F') {
	  // Turn output OFF
          GpioSetPin(ParseNum, 0);
	}
      }
    }
    // The above code effectively did for MQTT what the POST parsing does for
    // HTML. So we need to set the mqtt_parse_complete value so that the
    // check_runtime_changes() function will perform the necessary IO actions.
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
  // This function checks for a change on any pin (Relay Output or Sense
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
  // yet sent) is to xor the IO_XtoX values with what was previously sent.
  // This provides a pin by pin indication of what has changed since the last
  // publish.
  //
  // Note that if the high order bits were to keep changing very quickly the
  // code might not get to the low order bits as often. This is a flaw but
  // may not matter much in this application. The code only checks and sends
  // a message at the periodic_timer_expired(), thus it takes 16 expirations
  // to get all bits sent, and frequent changes in higher order bits will
  // supersede the processing of lower order bits.
  
  // Note: This code is only for the MQTT implementation thus the IO_16to9
  // bits are inputs, and the IO_8to1 bits are outputs.
  
  
  uint8_t xor_tmp;

  if (state_request == STATE_REQUEST_IDLE) {
    // XOR the current and old input bits for IO_16to9. This gives a result
    // that has a 1 for any bit that changed.
    xor_tmp = (uint8_t)(IO_16to9 ^ IO_16to9_sent);
    // Publish Sense Input pin state changes
    if      (xor_tmp & 0x80) publish_pinstate('I', '8', IO_16to9, 0x80); // Input 8
    else if (xor_tmp & 0x40) publish_pinstate('I', '7', IO_16to9, 0x40); // Input 7
    else if (xor_tmp & 0x20) publish_pinstate('I', '6', IO_16to9, 0x20); // Input 6
    else if (xor_tmp & 0x10) publish_pinstate('I', '5', IO_16to9, 0x10); // Input 5
    else if (xor_tmp & 0x08) publish_pinstate('I', '4', IO_16to9, 0x08); // Input 4
    else if (xor_tmp & 0x04) publish_pinstate('I', '3', IO_16to9, 0x04); // Input 3
    else if (xor_tmp & 0x02) publish_pinstate('I', '2', IO_16to9, 0x02); // Input 2
    else if (xor_tmp & 0x01) publish_pinstate('I', '1', IO_16to9, 0x01); // Input 1

    // XOR the current and old output bits for IO_8to1. This gives a result
    // that has a 1 for any bit that changed.
    xor_tmp = (uint8_t)(IO_8to1 ^ IO_8to1_sent);
    // Publish Relay Output pin state changes
    if      (xor_tmp & 0x80) publish_pinstate('O', '8', IO_8to1, 0x80); // Output 8
    else if (xor_tmp & 0x40) publish_pinstate('O', '7', IO_8to1, 0x40); // Output 7
    else if (xor_tmp & 0x20) publish_pinstate('O', '6', IO_8to1, 0x20); // Output 6
    else if (xor_tmp & 0x10) publish_pinstate('O', '5', IO_8to1, 0x10); // Output 5
    else if (xor_tmp & 0x08) publish_pinstate('O', '4', IO_8to1, 0x08); // Output 4
    else if (xor_tmp & 0x04) publish_pinstate('O', '3', IO_8to1, 0x04); // Output 3
    else if (xor_tmp & 0x02) publish_pinstate('O', '2', IO_8to1, 0x02); // Output 2
    else if (xor_tmp & 0x01) publish_pinstate('O', '1', IO_8to1, 0x01); // Output 1
  }
  
  // Check for a state_request
  if (state_request == STATE_REQUEST_RCVD) {
    // Publish all pin states
    state_request = STATE_REQUEST_IDLE;
    publish_pinstate_all();
  }
}


void publish_pinstate(uint8_t direction, uint8_t pin, uint8_t value, uint8_t mask)
{
  // This function transmits a change in pin state and updates the "sent"
  // value.
  
  uint8_t size;
  
  application_message[0] = '\0';
  
  strcpy(topic_base, devicetype);
  strcat(topic_base, stored_devicename);

  // If we are sending an Input message invert the value
  // if invert_input == 0xff
  if (direction == 'I') {
    if (invert_input == 0xff) value = (uint8_t)(~value);
    // Build first part of the topic message
    strcat(topic_base, "/input/0");
  }
  // Else this is an Output message. Build the first part
  // of the topic message
  else {
    strcat(topic_base, "/output/0");
  }
    
  // Add pin number to the topic message
  topic_base[strlen(topic_base)+1] = '\0';
  topic_base[strlen(topic_base)] = pin;
  // Build the application message
  if (value & mask) {
    strcpy(application_message, "ON");
    size = 2;
  }
  else {
    strcpy(application_message, "OFF");
    size = 3;
  }
    
  // Queue publish message
  mqtt_publish(&mqttclient,
               topic_base,
	       application_message,
	       size,
	       MQTT_PUBLISH_QOS_0 | MQTT_PUBLISH_RETAIN);
  
  if (direction == 'I') {
    // Update the "sent" pin state information
    if (IO_16to9 & mask) IO_16to9_sent |= mask;
    else IO_16to9_sent &= (uint8_t)~mask;
  }
  else {
    // Update the "sent" pin state information
    if (IO_8to1 & mask) IO_8to1_sent |= mask;
    else IO_8to1_sent &= (uint8_t)~mask;
  }
}


void publish_pinstate_all(void)
{
  // This function transmits the state of all pins (relay outputs and
  // sense inputs) in a single message response.
  uint8_t j;
  uint8_t k;
  
  j = IO_16to9;
  k = IO_8to1;

  // Invert Input values if invert_input == 0xff
  if (invert_input == 0xff) j = (uint8_t)(~j);
  
  application_message[0] = j;
  application_message[1] = k;
  application_message[2] = '\0';

  strcpy(topic_base, devicetype);
  strcat(topic_base, stored_devicename);
  strcat(topic_base, "/state");

  // Queue publish message
  mqtt_publish(&mqttclient,
               topic_base,
	       application_message,
	       2,
	       MQTT_PUBLISH_QOS_0 | MQTT_PUBLISH_RETAIN);
}

#endif // MQTT_SUPPORT == 1


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
  // Lock the EEPROM
  // Lock the EEPROM so that it cannot be written. This clears the DUL bit.
  FLASH_IAPSR &= (uint8_t)(~0x08);
}


void check_eeprom_settings(void)
{
  uint8_t i;
  
  // Check magic number in EEPROM.
  // If no magic number is found it is assumed that the EEPROM has never been
  // written, in which case the default Relay States, IP Address, Gateway
  // Address, Netmask, MAC and Port number will be used.
  // If the magic number IS found then it is assumed that the EEPROM contains
  // valid copies of the Relay States, IP Address, Gateway Address, Netmask,
  // MAC and Port number.
  // The magic number sequence is MSB 0x55 0xee 0x0f 0xf0 LSB
  
  if ((magic4 == 0x55) && 
      (magic3 == 0xee) && 
      (magic2 == 0x0f) && 
      (magic1 == 0xf0)) {
    // Magic number is present. Use the values in the EEPROM for the Relays
    // States, IP, Gateway, Netmask, MAC and Port Number.
    
    // Read and use the IP Address from EEPROM
    uip_ipaddr(IpAddr, stored_hostaddr[3], stored_hostaddr[2], stored_hostaddr[1], stored_hostaddr[0]);
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

#if MQTT_SUPPORT == 1
    // Read and use the MQTT Server IP Address from EEPROM
    uip_ipaddr(IpAddr,
               stored_mqttserveraddr[3],
	       stored_mqttserveraddr[2],
	       stored_mqttserveraddr[1],
	       stored_mqttserveraddr[0]);
    uip_setmqttserveraddr(IpAddr);
    // Read and use the MQTT Port from EEPROM
    Port_Mqttd = stored_mqttport;
#endif // MQTT_SUPPORT == 1

    // Read and use the Port from EEPROM
    Port_Httpd = stored_port;
    
    // Read and use the MAC from EEPROM
    // Set the MAC values used by the ARP code. Note the ARP code uses
    // the values in reverse order from all the other code.
    uip_ethaddr.addr[0] = stored_uip_ethaddr_oct[5]; // MSB
    uip_ethaddr.addr[1] = stored_uip_ethaddr_oct[4];
    uip_ethaddr.addr[2] = stored_uip_ethaddr_oct[3];
    uip_ethaddr.addr[3] = stored_uip_ethaddr_oct[2];
    uip_ethaddr.addr[4] = stored_uip_ethaddr_oct[1];
    uip_ethaddr.addr[5] = stored_uip_ethaddr_oct[0]; // LSB

    // ----------------------------------------------------------------------//
    // THIS IS ONLY REQUIRED FOR UPGRADING FROM OLD VERSION
    // Check the stored_config_settings bytes and convert them to the
    // "config_settings" method.
    unlock_eeprom();
    if (stored_config_settings[0] != '0' && stored_config_settings[0] != '1') {
      stored_config_settings[0] = '0';
    }
    if (stored_config_settings[1] != '0' && stored_config_settings[1] != '1') {
      stored_config_settings[1] = '0';
    }
    if (stored_config_settings[2] != '0' && stored_config_settings[2] != '1' && stored_config_settings[2] != '2') {
      stored_config_settings[2] = '2';
    }
    if (stored_config_settings[3] != '0' && stored_config_settings[3] != '1') {
      stored_config_settings[3] = '0';
    }
    if (stored_config_settings[4] != '0') {
      stored_config_settings[4] = '0';
    }
    if (stored_config_settings[5] != '0') {
      stored_config_settings[5] = '0';
    }
    lock_eeprom();
    // ----------------------------------------------------------------------//

    // Read and use the Config Setting for Output inversion control.
    // Read and use the Config Setting for Input inversion control.
    // Read and use the Relay states from EEPROM.
    check_eeprom_IOpin_settings();
    
    // Update the relay control registers
    write_output_registers();
  }
  
  else {
    // The magic number didn't match. Use the default IP, Gateway, Netmask,
    // Port, and MAC values and store them in the EEPROM. Turn off all relays
    // and store the off state in EEPROM. Write the magic number.

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

#if MQTT_SUPPORT == 1
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
    
#endif // MQTT_SUPPORT == 1

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
    stored_devicename[0] =  'N';
    stored_devicename[1] =  'e';
    stored_devicename[2] =  'w';
    stored_devicename[3] =  'D';
    stored_devicename[4] =  'e';
    stored_devicename[5] =  'v';
    stored_devicename[6] =  'i';
    stored_devicename[7] =  'c';
    stored_devicename[8] =  'e';
    stored_devicename[9] =  '0';
    stored_devicename[10] = '0';
    stored_devicename[11] = '0';
    for (i=12; i<20; i++) stored_devicename[i] = '\0';

    // Turn all Relays controls to 0, initialize inputs to 0, and store the
    // state in EEPROM. This works for all IO models (16 outputs, 8out/8in,
    // 16 inputs)
    stored_config_settings[0] = '0'; // Set to Invert Output OFF
    stored_config_settings[1] = '0'; // Set to Invert Input Off
    stored_config_settings[2] = '2'; // Set to Retain pin states
    stored_config_settings[3] = '0'; // Set to Half Duplex
    stored_config_settings[4] = '0'; // undefined
    stored_config_settings[5] = '0'; // undefined
    invert_output = 0x00;			// Turn off output invert bit
    invert_input = 0x00;			// Turn off output invert bit
    IO_16to9 = IO_16to9_new1 = IO_16to9_new2 = IO_16to9_sent = stored_IO_16to9 = 0x00;
    IO_8to1  = IO_8to1_new1  = IO_8to1_new2  = IO_8to1_sent  = stored_IO_8to1  = 0x00;
    write_output_registers();          // Set Relay Control outputs

    // Write the magic number to the EEPROM MSB 0x55 0xee 0x0f 0xf0 LSB
    magic4 = 0x55;		// MSB
    magic3 = 0xee;		//
    magic2 = 0x0f;		//
    magic1 = 0xf0;		// LSB
    
    lock_eeprom();
  }
  
  // Since this code is run one time at boot, set the Pending values to the
  // current stored values so they aren't bogus.
  for (i=0; i<4; i++) {
    Pending_hostaddr[i] = stored_hostaddr[i];
    Pending_draddr[i] = stored_draddr[i];
    Pending_netmask[i] = stored_netmask[i];
  }
  
  Pending_port = stored_port;
  
  for (i=0; i<20; i++) {
    Pending_devicename[i] = stored_devicename[i];
  }

  for (i=0; i<6; i++) {
    Pending_config_settings[i] = stored_config_settings[i];
    Pending_uip_ethaddr_oct[i] = stored_uip_ethaddr_oct[i];
  }

#if MQTT_SUPPORT == 1
  for (i=0; i<4; i++) {
    Pending_mqttserveraddr[i] = stored_mqttserveraddr[i];
  }
  Pending_mqttport = stored_mqttport;
  for (i=0; i<11; i++) {
    Pending_mqtt_username[i] = stored_mqtt_username[i];
    Pending_mqtt_password[i] = stored_mqtt_password[i];
  }
#endif // MQTT_SUPPORT == 1 
  
  // Update the MAC string
  update_mac_string();
  
}


void check_eeprom_IOpin_settings(void)
{
  // This routine will check the EEPROM settings for the config register
  // and IO pin states
  
  // Read and use the Config Setting for Output inversion control.
  if (stored_config_settings[0] == '0') invert_output = 0x00;
  else invert_output = 0xff;
  
  // Read and use the Config Setting for Input inversion control.
  if (stored_config_settings[1] == '0') invert_input = 0x00;
  else invert_input = 0xff;

  // Read and use the Relay states from EEPROM. This also initializes the
  // bits that store input pin information. The intialization works
  // regardless of the IO model (16 outputs, 8out/8in, or 16 inputs).
  if (stored_config_settings[2] == '0') {
    // Turn all IO states OFF
    IO_16to9 = 0x00;
    IO_8to1 = 0x00;
  }
  else if (stored_config_settings[2] == '1') {
    // Turn all IO states ON
    IO_16to9 = 0xff;
    IO_8to1 = 0xff;
  }
  else {
    // Use retained IO states.
    IO_16to9 = IO_16to9_new1 = IO_16to9_new2 = IO_16to9_sent = stored_IO_16to9;
    IO_8to1  = IO_8to1_new1  = IO_8to1_new2  = IO_8to1_sent  = stored_IO_8to1;
  }
}  


void update_mac_string(void)
{
  // Function to turn the uip_ethaddr values into a single string containing
  // the MAC address
  uint8_t i;
  uint8_t j;

  i = 5;
  j = 0;
  while (j<12) {
    emb_itoa(stored_uip_ethaddr_oct[i], OctetArray, 16, 2);
    mac_string[j++] = OctetArray[0];
    mac_string[j++] = OctetArray[1];
    i--;
  }
  mac_string[12] = '\0';
}


void check_runtime_changes(void)
{
  // Step 1: Read the input registers and update the IO_16to9 and IO8to1
  // values as appropriate.
  // 
  // Step 2: Check if the user requested changes to Device Name, Relay States,
  // IP Address, Gateway Address, Netmask, Port, or MAC. If a change occurred
  // update the appropriate variables and relay controls, and store the new
  // values in EEPROM. Note that the value parse_complete is used to make sure
  // that a complete POST entry has been received before attempting to process
  // the changes made by the user.

  uint8_t i;

  unlock_eeprom();

  read_input_registers();

  if (parse_complete == 1 || mqtt_parse_complete == 1) {
    // Check for changes from the user via the GUI, MQTT, or REST commands.
    // If parse_complete == 1 all TCP Fragments have been received during HTML
    // POST processing, OR a REST command was processed.
    // If mqtt_parse_complete == 1 an MQTT relay state change has been received.
    
#if GPIO_SUPPORT == 1 // Build control for 16 outputs
    // Check for Relay Output change
    if ((stored_IO_16to9 != IO_16to9)
     || (stored_IO_8to1 != IO_8to1)) {

      // Write the relay state values to the EEPROM only if the 'Retain' bit is
      // set.
      if (stored_config_settings[2] == '2') {
        stored_IO_16to9 = IO_16to9;
        stored_IO_8to1 = IO_8to1;
      }
    }
    // Update the relay control registers
    write_output_registers();
#endif // GPIO_SUPPORT == 1

#if GPIO_SUPPORT == 2 // Build control for 8 outputs / 8 inputs
    // Check for Relay Output change
    if (stored_IO_8to1 != IO_8to1) {
   
      // Write the relay state values to the EEPROM only if the 'Retain' bit is
      // set.
      if (stored_config_settings[2] == '2') {
        stored_IO_8to1 = IO_8to1;
      }
    }
    // Update the relay control registers
    write_output_registers();
#endif // GPIO_SUPPORT == 2

#if GPIO_SUPPORT == 3 // Build control for 16 inputs
#endif // GPIO_SUPPORT == 3

    if (mqtt_parse_complete == 1) {
      // If we ran this because mqtt_parse_complete == 1 clear it
      mqtt_parse_complete = 0;
    }
  }


  if (parse_complete == 1) {
    // Only perform the next checks if parse_complete indicates that all
    // HTML POST processing is complete.

#if GPIO_SUPPORT == 1 // Build control for 16 outputs
    // Check for Invert Output change
    if ((Pending_config_settings[0] != stored_config_settings[0])
     || (stored_IO_16to9 != IO_16to9)
     || (stored_IO_8to1 != IO_8to1)) {

      // Write the config_settings Invert Output value to the EEPROM
      stored_config_settings[0] = Pending_config_settings[0];
      
      // Update the invert_output value
      if (stored_config_settings[0] == '0') invert_output = 0x00;
      else invert_output = 0xff;

      // Write the relay state values to the EEPROM only if the 'Retain' bit is
      // set.
      if (stored_config_settings[2] == '2') {
        stored_IO_16to9 = IO_16to9;
        stored_IO_8to1 = IO_8to1;
      }
    
      // Update the relay control registers
      write_output_registers();
    }
    
    // Check for Invert Input change but it has no effect on operation.
    if (Pending_config_settings[1] != stored_config_settings[1]) {
      // Write the config_settings Invert Input value to the EEPROM
      stored_config_settings[1] = Pending_config_settings[1];
      
      // Update the invert_input value
      if (stored_config_settings[1] == '0') invert_input = 0x00;
      else invert_input = 0xff;
    }
#endif // GPIO_SUPPORT == 1

#if GPIO_SUPPORT == 2 // Build control for 8 outputs / 8 inputs
    // Check for Invert Output change
    if ((Pending_config_settings[0] != stored_config_settings[0])
     || (stored_IO_8to1 != IO_8to1)) {
   
      // Write the config_settings Invert Output value to the EEPROM
      stored_config_settings[0] = Pending_config_settings[0];

      // Update the invert_output value
      if (stored_config_settings[0] == '0') invert_output = 0x00;
      else invert_output = 0xff;

      // Write the relay state values to the EEPROM only if the 'Retain' bit is
      // set.
      if (stored_config_settings[2] == '2') {
        stored_IO_8to1 = IO_8to1;
      }
    
      // Update the relay control registers
      write_output_registers();
    }

    // Check for Invert Input change
    if (Pending_config_settings[1] != stored_config_settings[1]) {
      // Write the config_settings Invert Input value to the EEPROM
      stored_config_settings[1] = Pending_config_settings[1];
      
      // Update the invert_input value
      if (stored_config_settings[1] == '0') invert_input = 0x00;
      else invert_input = 0xff;
      
#if MQTT_SUPPORT == 1
      // Restart so input inversion is reported to MQTT
      restart_request = 1;
#endif // MQTT_SUPPORT == 1

    }
#endif // GPIO_SUPPORT == 2

#if GPIO_SUPPORT == 3 // Build control for 16 inputs

    // Check for Invert Output change but it has no effect on operation.
    if (Pending_config_settings[0] != stored_config_settings[0]) {
   
      // Write the config_settings Invert Output value to the EEPROM
      stored_config_settings[0] = Pending_config_settings[0];
    }
    
    // Check for Invert Input change
    if (Pending_config_settings[1] != stored_config_settings[1]) {
      // Write the config_settings Invert Input value to the EEPROM
      stored_config_settings[1] = Pending_config_settings[1];
      
      // Update the invert_input value
      if (stored_config_settings[1] == '0') invert_input = 0x00;
      else invert_input = 0xff;
      
#if MQTT_SUPPORT == 1
      // Restart so input inversion is reported to MQTT
      restart_request = 1;
#endif // MQTT_SUPPORT == 1

    }
#endif // GPIO_SUPPORT == 3


    // Check for changes in the Retain byte of the Config setting
    if (Pending_config_settings[2] != stored_config_settings[2]) {
      // Write the config_settings Retain value to the EEPROM
      stored_config_settings[2] = Pending_config_settings[2];
    }
    // Check for changes in the Full/Half Duplex byte of the Config
    // setting
    if (Pending_config_settings[3] != stored_config_settings[3]) {
      // Write the config_settings Full/Half Duplex value to the
      // EEPROM
      stored_config_settings[3] = Pending_config_settings[3];
      // If this setting changes a reboot is required
      user_reboot_request = 1;
    }
    // Write the undefined config settings to the EEPROM
    stored_config_settings[4] = Pending_config_settings[4];
    stored_config_settings[5] = Pending_config_settings[5];

    // Check for changes in the IP Address
    if (stored_hostaddr[3] != Pending_hostaddr[3] ||
        stored_hostaddr[2] != Pending_hostaddr[2] ||
        stored_hostaddr[1] != Pending_hostaddr[1] ||
        stored_hostaddr[0] != Pending_hostaddr[0]) {
      // Write the new IP address octets to the EEPROM
      for (i=0; i<4; i++) stored_hostaddr[i] = Pending_hostaddr[i];
    }
  
    // Check for changes in the Gateway Address
    if (stored_draddr[3] != Pending_draddr[3] ||
        stored_draddr[2] != Pending_draddr[2] ||
        stored_draddr[1] != Pending_draddr[1] ||
        stored_draddr[0] != Pending_draddr[0]) {
      // Write the new Gateway address octets to the EEPROM
      for (i=0; i<4; i++) stored_draddr[i] = Pending_draddr[i];
      restart_request = 1;
    }
  
    // Check for changes in the Netmask
    if (stored_netmask[3] != Pending_netmask[3] ||
        stored_netmask[2] != Pending_netmask[2] ||
        stored_netmask[1] != Pending_netmask[1] ||
        stored_netmask[0] != Pending_netmask[0]) {
      // Write the new Netmask octets to the EEPROM
      for (i=0; i<4; i++) stored_netmask[i] = Pending_netmask[i];
      restart_request = 1;
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
#if MQTT_SUPPORT == 1 
        // Restart is required in MQTT applications as this affects the MQTT
	// topic name.
        restart_request = 1;
#endif // MQTT_SUPPORT == 1
      }
    }

#if MQTT_SUPPORT == 1 
    // Check for changes in the MQTT Server IP Address
    if (stored_mqttserveraddr[3] != Pending_mqttserveraddr[3] ||
        stored_mqttserveraddr[2] != Pending_mqttserveraddr[2] ||
        stored_mqttserveraddr[1] != Pending_mqttserveraddr[1] ||
        stored_mqttserveraddr[0] != Pending_mqttserveraddr[0]) {
      // Write the new MQTT Server address octets to the EEPROM
      for (i=0; i<4; i++) stored_mqttserveraddr[i] = Pending_mqttserveraddr[i];
      // A firmware restart will occur to cause this change to take effect
      restart_request = 1;
    }
    
    // Check for changes in the MQTT Port number
    if (stored_mqttport != Pending_mqttport) {
      // Write the new MQTT Port number to the EEPROM
      stored_mqttport = Pending_mqttport;
      // A firmware restart will occur to cause this change to take effect
      restart_request = 1;
    }
    
    // Check for changes in the Username
    for(i=0; i<11; i++) {
      if (stored_mqtt_username[i] != Pending_mqtt_username[i]) {
        stored_mqtt_username[i] = Pending_mqtt_username[i];
        // A firmware restart will occur to cause this change to take effect
        restart_request = 1;
      }
    }
    
    // Check for changes in the Password
    for(i=0; i<11; i++) {
      if (stored_mqtt_password[i] != Pending_mqtt_password[i]) {
        stored_mqtt_password[i] = Pending_mqtt_password[i];
        // A firmware restart will occur to cause this change to take effect
        restart_request = 1;
      }
    }
#endif // MQTT_SUPPORT == 1

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
  
  if (restart_request == 1) {
    // Arm the restart function but first make sure we aren't already
    // performing a restart or reboot so we don't get stuck in a loop.
    if (restart_reboot_step == RESTART_REBOOT_IDLE) {
      restart_reboot_step = RESTART_REBOOT_ARM;
    }
  }
  
  if (user_reboot_request == 1) {
    // Arm the reboot function but first make sure we aren't already
    // performing a restart or reboot so we don't get stuck in a loop.
    if (restart_reboot_step == RESTART_REBOOT_IDLE) {
      restart_reboot_step = RESTART_REBOOT_ARM;
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
#if DEBUG_SUPPORT == 3
  // Report the stack overflow bit
  unlock_eeprom();
  if (stack_error == 1) {
    debug[38] |= 0x80;
    update_debug_storage1();
  }
  lock_eeprom();
#endif // DEBUG_SUPPORT == 3
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
    // A restart or reboot has been requested. The restart and reboot requests
    // are set in the check_runtime_changes() function if a restart or reboot
    // is needed.
    // The following needs to occur:
    // 1) If MQTT is enabled run the mqtt_disconnect() function.
    // 1a) Verify that mqtt disconnect was sent to the MQTT server.
    // 1b) Call uip_close() for the MQTT TCP connection.
    // 2) Verify that the close requests completed.
    // Then run either the restart() function or the reboot() function.

    if (restart_reboot_step == RESTART_REBOOT_ARM) {
      // Wait X seconds for anything in the process of being transmitted to
      // fully transmit. Refresh of a page after POST can take a few seconds.
      //
      // Capture time to delay the next step
      time_mark1 = second_counter;
      restart_reboot_step = RESTART_REBOOT_ARM2;
    }

    else if (restart_reboot_step == RESTART_REBOOT_ARM2) {
      // Wait 1 second
      if (second_counter > time_mark1 + 1) {
        restart_reboot_step = RESTART_REBOOT_SENDOFFLINE;
      }
    }

#if MQTT_SUPPORT == 1
    else if (restart_reboot_step == RESTART_REBOOT_SENDOFFLINE) {
      restart_reboot_step = RESTART_REBOOT_OFFLINEWAIT;
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
        // Capture time to delay the next step
        time_mark1 = second_counter;
      }
    }
    
    else if (restart_reboot_step == RESTART_REBOOT_OFFLINEWAIT) {
      if (second_counter > time_mark1 + 1 ) {
        // The offline publich is given 1 second to be communicated
        // before we move on to disconnect
        restart_reboot_step = RESTART_REBOOT_DISCONNECT;
      }
    }

    else if (restart_reboot_step == RESTART_REBOOT_DISCONNECT) {
      restart_reboot_step = RESTART_REBOOT_DISCONNECTWAIT;
      if (mqtt_start == MQTT_START_COMPLETE) {
        // Disconnect the MQTT client
        mqtt_disconnect(&mqttclient);
      }
      // Capture time to delay the next step
      time_mark1 = second_counter;
    }
    
    else if (restart_reboot_step == RESTART_REBOOT_DISCONNECTWAIT) {
      if (second_counter > time_mark1 + 1 ) {
        // The mqtt_disconnect() is given 1 second to be communicated
        // before we move on to TCP close
        restart_reboot_step = RESTART_REBOOT_TCPCLOSE;
      }
    }

    else if (restart_reboot_step == RESTART_REBOOT_TCPCLOSE) {
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
      // So, it looks like all I need to do is make sure the APPCALL
      // performs a uip_close() before returning to the UIP code. Then the
      // regular uip_periodic() process should get the job done.
      //
      // Signal uip_TcpAppHubCall() to close the MQTT TCP connection
      mqtt_close_tcp = 1;
      // Capture time to delay the next step
      time_mark1 = second_counter;
      restart_reboot_step = RESTART_REBOOT_TCPWAIT;
    }
    else if (restart_reboot_step == RESTART_REBOOT_TCPWAIT) {
      // Verify closed ... how?
      // For the moment I'm not sure how to do this, so I will just allow
      // enough time for it to happen. That is probably much faster, but
      // I will allow 1 second.
      if (second_counter > time_mark1 + 1 ) {
	mqtt_close_tcp = 0;
        restart_reboot_step = RESTART_REBOOT_FINISH;
      }
    }
    
#else
    else if (restart_reboot_step == RESTART_REBOOT_SENDOFFLINE) {
      restart_reboot_step = RESTART_REBOOT_FINISH;
    }
#endif // MQTT_SUPPORT == 1
    
    else if (restart_reboot_step == RESTART_REBOOT_FINISH) {
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
    }
  }
}


void restart(void)
{
  // This function restarts the firmware without affecting relay states.
  // We run through the processes to apply IP Address, Gateway Address,
  // Netmask, Port number, MAC, etc, but we don't run the GPIO initialization
  // that would affect the GPIO pin states. This prevents relay "chatter"
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
  time_mark1 = 0;           // Time capture used in reboot
  mqtt_close_tcp = 0;
#if MQTT_SUPPORT == 1
  mqtt_start = MQTT_START_TCP_CONNECT;
  mqtt_start_status = MQTT_START_NOT_STARTED;
  mqtt_start_ctr1 = 0;
  mqtt_sanity_ctr = 0;
  MQTT_error_status = 0;
  mqtt_restart_step = MQTT_RESTART_IDLE;
  state_request = STATE_REQUEST_IDLE;
#endif // MQTT_SUPPORT == 1
  
  spi_init();              // Initialize the SPI bit bang interface to the
                           // ENC28J60 and perform hardware reset on ENC28J60
  check_eeprom_settings(); // Verify EEPROM up to date
  Enc28j60Init();          // Initialize the ENC28J60 ethernet interface
  uip_arp_init();          // Initialize the ARP module
  uip_init();              // Initialize uIP
  HttpDInit();             // Initialize httpd; sets up listening ports

#if MQTT_SUPPORT == 1
  // Initialize mqtt client
  mqtt_init(&mqttclient,
            mqtt_sendbuf,
	    sizeof(mqtt_sendbuf),
	    &uip_buf[UIP_IPTCPH_LEN + UIP_LLH_LEN],
	    UIP_APPDATA_SIZE,
	    publish_callback);
#endif // MQTT_SUPPORT == 1

  LEDcontrol(1); // Turn LED on
  // From here we return to the main loop and should start running with
  // new settings.
}


void reboot(void)
{
  // We need to do a hardware reset (reboot).
  
  fastflash(); // A useful signal that a deliberate reboot is occurring.
  
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
  // serviced with a write to the IWDG_KR register - the main loop needs
  // to perform the servicing writes.
  
  IWDG_KR  = 0xcc;  // Enable the IWDG
  IWDG_KR  = 0x55;  // Unlock the configuration registers
  IWDG_PR  = 0x06;  // Divide clock by 256
  IWDG_RLR = 0xff;  // Countdown reload value. The /2 prescaler plus the
                    // Divisor pluss the Countdown value create the 1
		    // second timeout interval
  IWDG_KR  = 0xaa;  // Start the IWDG. The main loop must write this
                    // this value before the 1 second timeout occurs
		    // to prevent the watchdog from performing a
		    // hardware reset
  }


void read_input_registers(void)
{
  // This function reads the Input GPIO pins and stores the values in the
  // state variables. This is done in a two step process to debounce the
  // input pins.
  // - Pins are read into the _new1 variable
  // - _new1 is compared to the prior value stored in _new2 using xor
  // - If a bit in _new1 is the same as in _new2 then the state variable is
  //   updated.
  // - _new1 is transferred to _new2 for the next round
  //
uint8_t xor_tmp;

#if GPIO_SUPPORT == 1 // Build control for 16 outputs
  // No action needed - all pins are outputs
#endif // GPIO_SUPPORT == 1

#if GPIO_SUPPORT == 2 // Build control for 8 outputs / 8 inputs
  if (PC_IDR & (uint8_t)0x40) IO_16to9_new1 |= 0x80; // PC bit 6 = 1, Input 8 = 1
  else IO_16to9_new1 &= (uint8_t)(~0x80);
  if (PG_IDR & (uint8_t)0x01) IO_16to9_new1 |= 0x40; // PG bit 0 = 1, Input 7 = 1
  else IO_16to9_new1 &= (uint8_t)(~0x40);
  if (PE_IDR & (uint8_t)0x08) IO_16to9_new1 |= 0x20; // PE bit 3 = 1, Input 6 = 1
  else IO_16to9_new1 &= (uint8_t)(~0x20);
  if (PD_IDR & (uint8_t)0x01) IO_16to9_new1 |= 0x10; // PD bit 0 = 1, Input 5 = 1
  else IO_16to9_new1 &= (uint8_t)(~0x10);
  if (PD_IDR & (uint8_t)0x08) IO_16to9_new1 |= 0x08; // PD bit 3 = 1, Input 4 = 1
  else IO_16to9_new1 &= (uint8_t)(~0x08);
  if (PD_IDR & (uint8_t)0x20) IO_16to9_new1 |= 0x04; // PD bit 5 = 1, Input 3 = 1
  else IO_16to9_new1 &= (uint8_t)(~0x04);
  if (PD_IDR & (uint8_t)0x80) IO_16to9_new1 |= 0x02; // PD bit 7 = 1, Input 2 = 1
  else IO_16to9_new1 &= (uint8_t)(~0x02);
  if (PA_IDR & (uint8_t)0x10) IO_16to9_new1 |= 0x01; // PA bit 4 = 1, Input 1 = 1
  else IO_16to9_new1 &= (uint8_t)(~0x01);

  // The following compares the _new1 and _new2 samples and only updates the
  // bits in the IO_16to9 byte where the corresponding bits match in _new1
  // and _new2 (ie, a debounced change occurred).
  xor_tmp = (uint8_t)((IO_16to9 ^ IO_16to9_new1) & (IO_16to9 ^ IO_16to9_new2));
  IO_16to9 = (uint8_t)(IO_16to9 ^ xor_tmp);
  // Copy _new1 to _new2 for the next round
  IO_16to9_new2 = IO_16to9_new1;
#endif // GPIO_SUPPORT == 2

#if GPIO_SUPPORT == 3 // Build control for 16 inputs
  if (PC_IDR & (uint8_t)0x40) IO_16to9_new1 |= 0x80; // PC bit 6 = 1, Input 16 = 1
  else IO_16to9_new1 &= (uint8_t)(~0x80);
  if (PG_IDR & (uint8_t)0x01) IO_16to9_new1 |= 0x40; // PG bit 0 = 1, Input 15 = 1
  else IO_16to9_new1 &= (uint8_t)(~0x40);
  if (PE_IDR & (uint8_t)0x08) IO_16to9_new1 |= 0x20; // PE bit 3 = 1, Input 14 = 1
  else IO_16to9_new1 &= (uint8_t)(~0x20);
  if (PD_IDR & (uint8_t)0x01) IO_16to9_new1 |= 0x10; // PD bit 0 = 1, Input 13 = 1
  else IO_16to9_new1 &= (uint8_t)(~0x10);
  if (PD_IDR & (uint8_t)0x08) IO_16to9_new1 |= 0x08; // PD bit 3 = 1, Input 12 = 1
  else IO_16to9_new1 &= (uint8_t)(~0x08);
  if (PD_IDR & (uint8_t)0x20) IO_16to9_new1 |= 0x04; // PD bit 5 = 1, Input 11 = 1
  else IO_16to9_new1 &= (uint8_t)(~0x04);
  if (PD_IDR & (uint8_t)0x80) IO_16to9_new1 |= 0x02; // PD bit 7 = 1, Input 10 = 1
  else IO_16to9_new1 &= (uint8_t)(~0x02);
  if (PA_IDR & (uint8_t)0x10) IO_16to9_new1 |= 0x01; // PA bit 4 = 1, Input 9 = 1
  else IO_16to9_new1 &= (uint8_t)(~0x01);
  
  if (PC_IDR & (uint8_t)0x80) IO_8to1 |= 0x80;  // PC bit 7 = 1, Input 8 = 1
  else IO_8to1 &= (uint8_t)(~0x80);
  if (PG_IDR & (uint8_t)0x02) IO_8to1 |= 0x40;  // PG bit 1 = 1, Input 7 = 1
  else IO_8to1 &= (uint8_t)(~0x40);
  if (PE_IDR & (uint8_t)0x01) IO_8to1 |= 0x20;  // PE bit 0 = 1, Input 6 = 1
  else IO_8to1 &= (uint8_t)(~0x20);
  if (PD_IDR & (uint8_t)0x04) IO_8to1 |= 0x10;  // PD bit 2 = 1, Input 5 = 1
  else IO_8to1 &= (uint8_t)(~0x10);
  if (PD_IDR & (uint8_t)0x10) IO_8to1 |= 0x08;  // PD bit 4 = 1, Input 4 = 1
  else IO_8to1 &= (uint8_t)(~0x08);
  if (PD_IDR & (uint8_t)0x40) IO_8to1 |= 0x04;  // PD bit 6 = 1, Input 3 = 1
  else IO_8to1 &= (uint8_t)(~0x04);
  if (PA_IDR & (uint8_t)0x20) IO_8to1 |= 0x02;  // PA bit 5 = 1, Input 2 = 1
  else IO_8to1 &= (uint8_t)(~0x02);
  if (PA_IDR & (uint8_t)0x08) IO_8to1 |= 0x01;  // PA bit 3 = 1, Input 1 = 1
  else IO_8to1 &= (uint8_t)(~0x01);
  
  // The following compares the _new1 and _new2 samples and only updates the
  // bits in the IO_16to9 byte where the corresponding bits match in _new1
  // and _new2 (ie, a debounced change occurred).
  xor_tmp = (uint8_t)((IO_16to9 ^ IO_16to9_new1) & (IO_16to9 ^ IO_16to9_new2));
  IO_16to9 = (uint8_t)(IO_16to9 ^ xor_tmp);
  // Copy _new1 to _new2 for the next round
  IO_16to9_new2 = IO_16to9_new1;

  // The following compares the _new1 and _new2 samples and only updates the
  // bits in the IO_8to1 byte where the corresponding bits match in _new1
  // and _new2 (ie, a debounced change occurred).
  xor_tmp = (uint8_t)((IO_8to1 ^ IO_8to1_new1) & (IO_8to1 ^ IO_8to1_new2));
  IO_8to1 = (uint8_t)(IO_8to1 ^ xor_tmp);
  // Copy _new1 to _new2 for the next round
  IO_8to1_new2 = IO_8to1_new1;
#endif // GPIO_SUPPORT == 3
}


void write_output_registers(void)
{
  // This function updates the Output GPIO pins to match the relay control
  // states. Note that the invert_output setting flips the state of the Output
  // GPIO pins.
  // If invert_output = 0, then a 0 in the Relays_xxx variable sets the relay
  //   pin to 0
  // If invert_output = 0xff, then a 0 in the Relays_xxx variable sets the
  //   relay pin to 1
  uint8_t xor_tmp;
  
#if GPIO_SUPPORT == 1 // Build control for 16 outputs
  // Update the relay control registers to match the state control value
  // for relays 16 to 9
  xor_tmp = (uint8_t)(invert_output ^ IO_16to9);
  if (xor_tmp & 0x80) PC_ODR |= (uint8_t)0x40; // Relay 16 off
  else PC_ODR &= (uint8_t)~0x40; // Relay 16 on
  if (xor_tmp & 0x40) PG_ODR |= (uint8_t)0x01; // Relay 15 off
  else PG_ODR &= (uint8_t)~0x01; // Relay 15 on
  if (xor_tmp & 0x20) PE_ODR |= (uint8_t)0x08; // Relay 14 off
  else PE_ODR &= (uint8_t)~0x08; // Relay 14 on
  if (xor_tmp & 0x10) PD_ODR |= (uint8_t)0x01; // Relay 13 off
  else PD_ODR &= (uint8_t)~0x01; // Relay 13 on
  if (xor_tmp & 0x08) PD_ODR |= (uint8_t)0x08; // Relay 12 off
  else PD_ODR &= (uint8_t)~0x08; // Relay 12 on
  if (xor_tmp & 0x04) PD_ODR |= (uint8_t)0x20; // Relay 11 off
  else PD_ODR &= (uint8_t)~0x20; // Relay 11 on
  if (xor_tmp & 0x02) PD_ODR |= (uint8_t)0x80; // Relay 10 off
  else PD_ODR &= (uint8_t)~0x80; // Relay 10 on
  if (xor_tmp & 0x01) PA_ODR |= (uint8_t)0x10; // Relay 9 off
  else PA_ODR &= (uint8_t)~0x10; // Relay 9 on

  // Update the relay control registers to match the state control value
  // for relays 8 to 1
  xor_tmp = (uint8_t)(invert_output ^ IO_8to1);
  if (xor_tmp & 0x80) PC_ODR |= (uint8_t)0x80; // Relay 8 off
  else PC_ODR &= (uint8_t)~0x80; // Relay 8 on
  if (xor_tmp & 0x40) PG_ODR |= (uint8_t)0x02; // Relay 7 off
  else PG_ODR &= (uint8_t)~0x02; // Relay 7 on
  if (xor_tmp & 0x20) PE_ODR |= (uint8_t)0x01; // Relay 6 off
  else PE_ODR &= (uint8_t)~0x01; // Relay 6 on
  if (xor_tmp & 0x10) PD_ODR |= (uint8_t)0x04; // Relay 5 off
  else PD_ODR &= (uint8_t)~0x04; // Relay 5 on
  if (xor_tmp & 0x08) PD_ODR |= (uint8_t)0x10; // Relay 4 off
  else PD_ODR &= (uint8_t)~0x10; // Relay 4 on
  if (xor_tmp & 0x04) PD_ODR |= (uint8_t)0x40; // Relay 3 off
  else PD_ODR &= (uint8_t)~0x40; // Relay 3 on
  if (xor_tmp & 0x02) PA_ODR |= (uint8_t)0x20; // Relay 2 off
  else PA_ODR &= (uint8_t)~0x20; // Relay 2 on
  if (xor_tmp & 0x01) PA_ODR |= (uint8_t)0x08; // Relay 1 off
  else PA_ODR &= (uint8_t)~0x08; // Relay 1 on

#endif // GPIO_SUPPORT == 1

#if GPIO_SUPPORT == 2 // Build control for 8 outputs / 8 inputs
  xor_tmp = (uint8_t)(invert_output ^ IO_8to1);
  if (xor_tmp & 0x80) PC_ODR |= (uint8_t)0x80; // Relay 8 off
  else PC_ODR &= (uint8_t)~0x80; // Relay 8 on
  if (xor_tmp & 0x40) PG_ODR |= (uint8_t)0x02; // Relay 7 off
  else PG_ODR &= (uint8_t)~0x02; // Relay 7 on
  if (xor_tmp & 0x20) PE_ODR |= (uint8_t)0x01; // Relay 6 off
  else PE_ODR &= (uint8_t)~0x01; // Relay 6 on
  if (xor_tmp & 0x10) PD_ODR |= (uint8_t)0x04; // Relay 5 off
  else PD_ODR &= (uint8_t)~0x04; // Relay 5 on
  if (xor_tmp & 0x08) PD_ODR |= (uint8_t)0x10; // Relay 4 off
  else PD_ODR &= (uint8_t)~0x10; // Relay 4 on
  if (xor_tmp & 0x04) PD_ODR |= (uint8_t)0x40; // Relay 3 off
  else PD_ODR &= (uint8_t)~0x40; // Relay 3 on
  if (xor_tmp & 0x02) PA_ODR |= (uint8_t)0x20; // Relay 2 off
  else PA_ODR &= (uint8_t)~0x20; // Relay 2 on
  if (xor_tmp & 0x01) PA_ODR |= (uint8_t)0x08; // Relay 1 off
  else PA_ODR &= (uint8_t)~0x08; // Relay 1 on
#endif // GPIO_SUPPORT == 2

#if GPIO_SUPPORT == 3 // Build control for 16 inputs
  // No action needed - all pins are inputs
#endif // GPIO_SUPPORT == 3
}


void check_reset_button(void)
{
  // Check to see if the button is pressed. Check the button every 50ms
  // for 5 seconds. If the button remains pressed that entire time then
  // clear the magic number and reset the code.
  uint8_t i;
  if ((PA_IDR & 0x02) == 0) {
    // Reset Button pressed
    for (i=0; i<100; i++) {
      wait_timer(50000); // wait 50ms
      if ((PA_IDR & 0x02) == 1) { // check Reset Button again. If released
                                  // exit.
        return;
      }
    }
    // If we got here the button remained pressed for 5 seconds
    // Turn off the LED, clear the magic number, and reset the device
    LEDcontrol(0);  // turn LED off
    while((PA_IDR & 0x02) == 0) {  // Wait for button release
    }

    magic4 = 0x00;
    magic3 = 0x00;
    magic2 = 0x00;
    magic1 = 0x00;

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
  
  LEDcontrol(1);     // turn LED on
  for(i=0; i<10; i++) wait_timer((uint16_t)50000); // wait 500ms
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
  for (i = 0; i < NUM_DEBUG_BYTES - 5; i++) debug[i] = 0x00;
  // Recover the "reset" counters
  for (i = 41; i < 46; i++) debug[i] = stored_debug[i];
  // Update EEPROM bytes that changed
  update_debug_storage1();
#endif // DEBUG_SUPPORT == 2

#if DEBUG_SUPPORT == 3
  // Clear the general debug bytes
  for (i = 0; i < NUM_DEBUG_BYTES - 20; i++) debug[i] = 0x00;
  // Recover the "reset" counters and the "additional" debug bytes
  for (i = 26; i < 46; i++) debug[i] = stored_debug[i];
  // Update EEPROM bytes that changed
  update_debug_storage1();
#endif // DEBUG_SUPPORT == 3
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
#if MQTT_SUPPORT == 1
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
#endif // MQTT_SUPPORT == 1
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



