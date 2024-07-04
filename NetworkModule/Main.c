/*
 * Main File including the main-routine with initializations-
 * and stack-routines.
 *
 * Author: Simon Kueppers
 * Email: simon.kueppers@web.de
 * Homepage: http://klinkerstein.m-faq.de
 * */
 
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


// All includes are in main.h
#include "main.h"


//---------------------------------------------------------------------------//
//---------------------------------------------------------------------------//
//---------------------------------------------------------------------------//
// IMPORTANT: The code_revision must be exactly 13 characters. A Space
// character is allowed, but there cannot be two or more consecutive spaces.
const char code_revision[] = "20240701 TEST"; // Normal Release Revision
//---------------------------------------------------------------------------//
//---------------------------------------------------------------------------//
//---------------------------------------------------------------------------//

//---------------------------------------------------------------------------//
// Stack overflow detection
// The following is used to declare two constants at the top of the RAM area.
// Regular variable assignments start at memory address 0x0000 and grow
// upwards to 0x5ff. Stack starts at 0x7ff and grows downward to 0x0600. Two
// constants are placed at 0x5fe and 0x5ff and are monitored to make sure
// they never change. If they do change it implies that the Stack has grown
// into the variable storage RAM, or that a "wild pointer" may have caused
// writes to RAM to exceed the space allocated to RAM.
//
// The following creates the two variables in a special section named
// ".iconst". The linker needs to be told where to place this section in
// memory. See the main.h file for the required directives in the .lkf file
// (the linker file).
#pragma section @near [iconst]
uint8_t stack_limit1;
uint8_t stack_limit2;
#pragma section @near []
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
// from the declarations below. SO - if any EEPROM variables are added it is
// recommended that they be declared ABOVE the existing EEPROM variables to
// keep the EEPROM variables from being relocated in the memory. This will
// keep all existing variables in the same place in EEPROM which will allow
// new code updates to discover the magic number and existing settings.
//
// NOTE2: The order of the EEPROM variables should not be changed if you want
// code updates to work without losing stored values.
//
// NOTE3: The values stored for MQTT are allocated in EEPROM whether they are
// included in the code build or not. This is to maintain the location of all
// EEPROM variables so that future builds wont require users to re-enter their
// settings when they reprogram their devices.
// 
// EEPROM Variables:
// >>> Add new variables HERE <<<
// 110 bytes used below
@eeprom int16_t stored_altitude;           // Byte 109-110
					   // User entered altitude used for
					   // BME280 pressure calibration
// 108 bytes used below
@eeprom uint8_t stored_debug_bytes[10];    // 10 debug bytes
					   // Byte 108 stored_debug_bytes[9]
                                           // Byte 99 stored_debug_bytes[0]

// 98 bytes used below
@eeprom uint8_t stored_pin_control[16];    // Byte 83-98 Config settings for
                                           // each STM8 IO pin
@eeprom uint8_t stored_config_settings;    // Byte 82
                                           // Bit 7: Undefined, 0 only
                                           // Bit 6: Undefined, 0 only
                                           // Bit 5: BME280
					   //        1 = Enable, 0 = Disable
                                           // Bit 4: Disable Cfg Button
					   //        1 = Disable, 0 = Enable
                                           // Bit 3: DS18B20
					   //        1 = Enable, 0 = Disable
                                           // Bit 2: MQTT
					   //        1 = Enable, 0 = Disable
                                           // Bit 1: Home Assistant Auto Discovery
					   //        1 = Enable, 0 = Disable
                                           // Bit 0: Duplex
					   //        1 = Full, 0 = Half
@eeprom uint8_t stored_prior_config;       // Copy of stored_config_settings
                                           // prior to reboot
@eeprom uint8_t unused80;                  // Byte 80 unused
@eeprom uint8_t unused79;                  // Byte 79 unused
@eeprom uint8_t stored_shunt_res;          // Byte 78 INA226 Shunt Resistor
                                           //   Value:
					   //   001 to 255 for resistors from
					   //   0.001 to 0.255 ohms
					   //   See Manual
@eeprom uint8_t stored_latching_relay_state; // Byte 77 latching_relay_state
                                           // is used to store the last known
					   // state that latching relays were
					   // set to in the Software Defined
					   // Radio builds.
					   // Bit 7: Relay 7 state
					   //   0 = off
					   //   1 = on
					   // Bit 6: Relay 6 state
					   // Bit 5: Relay 5 state
					   // Bit 4: Relay 4 state
					   // Bit 3: Relay 3 state
					   // Bit 2: Relay 2 state
					   // Bit 1: Relay 1 state
					   // Bit 0: Relay 0 state
@eeprom uint8_t stored_options2;           // Byte 76
                                           // Bit 7: Undefined, 0 only
                                           // Bit 6: Login Enable
					   //        0 = Disabled
					   //        1 = Enabled
                                           // Bit 5: Undefined, 0 only
                                           // Bit 4: Undefined, 0 only
                                           // Bit 3: Undefined, 0 only
                                           // Bit 0-2: Rotation Pointer used
					   // to select an alternate local
					   // MQTT port number on each
					   // successive boot.
                                           //   See Manual
					   //   000 ALTERNATE_PORT00
					   //   001 ALTERNATE_PORT01
					   //   010 ALTERNATE_PORT02
					   //   011 ALTERNATE_PORT03
					   //   100 ALTERNATE_PORT04
@eeprom char stored_mqtt_password[11];     // Byte 65-75 MQTT Password
@eeprom char stored_mqtt_username[11];     // Byte 54-64 MQTT Username
@eeprom uint8_t stored_mqttserveraddr[4];  // Bytes 50-53 mqttserveraddr
@eeprom uint16_t stored_mqttport;	   // Bytes 48-49 MQTT Host Port number
@eeprom uint8_t stored_magic4;	           // Byte 47 MSB Magic Number
@eeprom uint8_t stored_magic3;             // Byte 46
@eeprom uint8_t stored_magic2;             // Byte 45
@eeprom uint8_t stored_magic1;             // Byte 44 LSB Magic Number
@eeprom uint8_t stored_hostaddr[4];	   // Bytes 40-43 hostaddr
@eeprom uint8_t stored_draddr[4];	   // Bytes 36-39 draddr
@eeprom uint8_t stored_netmask[4];	   // Bytes 32-35 netmask
@eeprom uint16_t stored_port;		   // Bytes 30-31 Port
@eeprom uint8_t stored_uip_ethaddr_oct[6]; // Bytes 24-29 MAC MSB
@eeprom uint8_t stored_EEPROM_revision2;   // Byte 23 EEPROM revision
@eeprom uint8_t stored_EEPROM_revision1;   // Byte 22 EEPROM revision
@eeprom uint8_t stored_options1;           // Byte 21 Additional Options
                                           // Bit 7: Latching Relay Mode
					   //   Software Defined Radio only
					   //   0 = Off
					   //   1 = On
                                           // Bit 6: Response Lock
					   //   0 = IP responses allowed
					   //   1 = IP responses not allowed
                                           // Bit 5: Force PCF8574 pin
					   //   delete messages
					   //   0 = No action
					   //   1 = Delete Pins
                                           // Bit 4: Short Form Option
					   //   0 = Original format all '0'
					   //       and '1'
					   //   1 = Show '-' for Disabled
					   //       pins
                                           // Bit 3: PCF8574 present
					   //   0 = No PCF8574 detected or
					   //       PCF8574 not supported
					   //   1 = PCF8574 detected and
					   //       supported
                                           // Bit 0-2: Pinout
					   //   See Manual
					   //   000 Pinout Option 1
					   //   001 Pinout Option 1 (default)
					   //   010 Pinout Option 2
					   //   011 Pinout Option 3
					   //   100 Pinout Option 4
@eeprom uint8_t stored_devicename[20];     // Bytes 1 - 20 Device name @4000
//---------------------------------------------------------------------------//


//---------------------------------------------------------------------------//
// The "debug_bytes" EEPROM storage is used to retain specific debug information
// across reboots and to make that information available for user viewing.
// The RAM debug values provide temporary storage of the values as an aid in
// reducing the number of EEPROM writes.
uint8_t debug_bytes[10];
//---------------------------------------------------------------------------//


// Define Flash addresses for IDX values
// Note: While IDX values are not used in all builds they are still defined
// for all builds.
uint8_t Sensor_IDX[6][8] @FLASH_START_SENSOR_IDX;


// Define Flash addresses for STM8 pin IO Names and IO Timers
// Note: While IO_NAME and IO_TIMER Flash space is not used in all builds it
// is still defined for all builds.
uint16_t IO_TIMER[16] @FLASH_START_IO_TIMERS;
char IO_NAME[16][16] @FLASH_START_IO_NAMES;

#if BUILD_SUPPORT == BROWSER_ONLY_BUILD
// Define RAM for IO Timers
#if PCF8574_SUPPORT == 0
uint16_t Pending_IO_TIMER[16];
#endif // PCF8574_SUPPORT == 0
#if PCF8574_SUPPORT == 1
uint16_t Pending_IO_TIMER[24];
#endif // PCF8574_SUPPORT == 1
uint8_t timer_flags; // Flags to aid in timer decrementing

// Define pin_timers
#if PCF8574_SUPPORT == 0
uint16_t pin_timer[16]; // The pin_timers are 14 bit timers with the 2 most
                        // significant bits defining the resolution as:
			//   00 = 0.1 second
			//   01 = 1 second
			//   10 = 1 minute
			//   11 = 1 hour
#endif // PCF8574_SUPPORT == 0
#if PCF8574_SUPPORT == 1
uint16_t pin_timer[24]; // The pin_timers are 14 bit timers with the 2 most
                        // significant bits of the 16 bit word defining the
			// resolution as:
			//   00 = 0.1 second
			//   01 = 1 second
			//   10 = 1 minute
			//   11 = 1 hour
#endif // PCF8574_SUPPORT == 1
#endif // BUILD_SUPPORT == BROWSER_ONLY_BUILD


// Declaring variables for processing pin_control bytes.
// Builds that do not have PCF8574 support can utilize smaller variables
// (which take less RAM) and 16 bit operations (which take less Flash space).
#if PCF8574_SUPPORT == 0 && DOMOTICZ_SUPPORT == 0
uint8_t pin_control[16];                // Array of per pin configuration
                                        // bytes
uint8_t Pending_pin_control[16];        // Temporary storage of pending
                                        // pin_control bytes.
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
#endif // PCF8574_SUPPORT == 0 && DOMOTICZ_SUPPORT == 0

#if PCF8574_SUPPORT == 1 || DOMOTICZ_SUPPORT == 1
uint8_t pin_control[24];                // Array of per pin configuration
                                        // bytes when PCF8574 is included in
					// the hardware configuration
uint8_t Pending_pin_control[24];        // Temporary storage of pending
                                        // pin_control bytes.
uint32_t ON_OFF_word;                   // ON/OFF states of pins in single 32
                                        // bit word
uint32_t ON_OFF_word_new1;              // ON/OFF states of pins stored for
                                        // debounce of input pins
uint32_t ON_OFF_word_new2;              // ON/OFF states of pins stored for
                                        // debounce of input pins
uint32_t ON_OFF_word_sent;              // Used to indicate pin states that
                                        // need to be sent in MQTT Publish msgs
uint32_t Invert_word;                   // Invert state of pins in single 32 bit
                                        // word
#endif // PCF8574_SUPPORT == 1 || DOMOTICZ_SUPPORT == 1




// Flag bytes
uint8_t state_request;			// Indicates that a PUBLISH state
                                        // request was received

uint8_t stack_error;			// Stack error flag storage
uint8_t magic_number_missing_flag;      // Indicates a missing Magic Number
                                        // during boot processes.
uint8_t reboot_request;                 // Signals the need for a reboot
uint8_t user_reboot_request;            // Signals a user request for a reboot
uint8_t restart_request;                // Signals the need for a restart
uint8_t user_restart_request;           // Signals a user request for a restart
uint8_t mqtt_close_tcp;                 // Signals the need to close the MQTT
                                        // TCP connection
uint8_t parse_complete;                 // Signals completion of POST parsing
uint8_t mqtt_parse_complete;            // Signals completion of MQTT parsing
uint8_t uart_init_complete;		// Signals completion of UART initial-
                                        // izaion. This is primarily used to
					// allow use of debug statements in
					// functions that may run before UART
					// initialization is complete (where
					// you can't use the UART) but you want
					// to have UART printouts in that
					// function AFTER initializaion is
					// complete.


//---------------------------------------------------------------------------//
// Pending values are used to pass change requests from the user to the main.c
// functions. Code in the main.c file will compare the values in use to the
// "pending" values to determine if any changes occurred, and if so code will
// update the "in use" values and will restart the firmware if needed.

//uint8_t Pending_hostaddr[4];
//uint8_t Pending_draddr[4];
//uint8_t Pending_netmask[4];

//uint16_t Pending_port;

//uint8_t Pending_devicename[20];

uint8_t Pending_config_settings;

//uint8_t Pending_uip_ethaddr_oct[6];







char mac_string[13];

uint8_t restart_reboot_step;    // Tracks steps used in restart and reboot
                                // functions

uint16_t Port_Httpd;            // HTTP port number
uip_ipaddr_t IpAddr;

uint32_t t100ms_ctr1;           // Timer used in restart/reboot function

// Initialize timer counters used in timer.c
extern uint8_t periodic_timer;       // Peroidic_timer counter
extern uint8_t mqtt_timer;           // MQTT_timer counter
extern uint16_t arp_timer;           // arp_timer counter
extern uint8_t t100ms_timer;         // 100ms timer counter
extern uint16_t second_toggle;       // Used in developing a 1 second counter
extern uint32_t second_counter;      // Counts seconds since boot
extern uint16_t ms_counter;          // Free running ms counter


extern uint8_t OctetArray[14];  // Used in emb_itoa conversions and to
                                // transfer short strings globally


#if LINKED_SUPPORT == 1
#if PCF8574_SUPPORT == 0 && DOMOTICZ_SUPPORT == 0
uint8_t linked_edge;		// Used for indicating Input pin edge
				// detection when using Linked pins
#endif // PCF8574_SUPPORT == 0 && DOMOTICZ_SUPPORT == 0
#if PCF8574_SUPPORT == 1 || DOMOTICZ_SUPPORT == 1
uint16_t linked_edge;		// Used for indicating Input pin edge
				// detection when using Linked pins.
				// If a bit is set to 1 it means the
				// following:
				// bit 0  = edge on STM8 pin 1
				// bit 1  = edge on STM8 pin 2
				// bit 2  = edge on STM8 pin 3
				// bit 3  = edge on STM8 pin 4
				// bit 4  = edge on STM8 pin 5
				// bit 5  = edge on STM8 pin 6
				// bit 6  = edge on STM8 pin 7
				// bit 7  = edge on STM8 pin 8
				// bit 8  = edge on PCF8574 pin 17
				// bit 9  = edge on PCF8574 pin 18
				// bit 10 = edge on PCF8574 pin 19
				// bit 11 = edge on PCF8574 pin 20
				// bit 12 = N/A
				// bit 13 = N/A
				// bit 14 = N/A
				// bit 15 = N/A
#endif // PCF8574_SUPPORT == 1 || DOMOTICZ_SUPPORT == 1
#endif // LINKED_SUPPORT == 1




#if BUILD_SUPPORT == MQTT_BUILD
// MQTT variables
// Flag bytes
uint8_t mqtt_enabled;                 // Used to signal use of MQTT functions
                                      // Initialized to 'disabled'. This can
				      // only get set to 1 if the MQTT Enable
				      // bit is set in the Config settings AND
				      // at least one IO pin is enabled.
extern uint8_t connack_received;      // Used to communicate CONNECT CONNACK
                                      // received from mqtt.c to main.c
extern uint8_t suback_received;       // Used to communicate SUBSCRIBE SUBACK
                                      // received from mqtt.c to main.c
				      
uint8_t connect_flags;                // Used in MQTT setup
uint16_t mqtt_keep_alive;             // Ping interval
struct mqtt_client mqttclient;        // Declare pointer to the MQTT client
                                      // structure
const char* client_id;                // MQTT Client ID
uint8_t mqtt_start;                   // Tracks the MQTT startup steps
uint8_t mqtt_start_ctr1;              // Tracks time for the MQTT startup
                                      // steps
uint8_t verify_count;                 // Used to limit the number of ARP and
                                      // TCP verify attempts
uint8_t mqtt_sanity_ctr;              // Tracks time for the MQTT sanity steps

extern uint8_t mqtt_sendbuf[MQTT_SENDBUF_SIZE]; // Buffer to contain MQTT
                                      // transmit queue and data.

struct uip_conn *mqtt_conn;           // mqtt_conn points to the connection
                                      // being used with the MQTT server. This
				      // structure is created here so we don't
				      // have to keep looking it up in the
				      // structure table while setting up MQTT
				      // operations.
uint8_t mqtt_restart_step;            // Step tracker for restarting MQTT

static const unsigned char devicetype[] = "NetworkModule/"; // Used in
                                      // building topic and client id names
uint8_t auto_discovery;               // Used in the Auto Discovery state machine
uint8_t auto_discovery_step;          // Used in the Auto Discovery state machine
uint8_t pin_ptr;                      // Used in the Auto Discovery state machine
uint8_t sensor_number;                // Used in the Auto Discovery state machine

#if PCF8574_SUPPORT == 0 && DOMOTICZ_SUPPORT == 0
uint16_t MQTT_transmit;               // Used to force a publish_pinstate
#endif // PCF8574_SUPPORT == 0 && DOMOTICZ_SUPPORT == 0
#if PCF8574_SUPPORT == 1 || DOMOTICZ_SUPPORT == 1
uint32_t MQTT_transmit;               // Used to force a publish_pinstate
#endif // PCF8574_SUPPORT == 1 || DOMOTICZ_SUPPORT == 1


// Define globals to communicate the idx and nvalue values from the
// mqtt_sync() function to the publish_callback() function.
#if DOMOTICZ_SUPPORT == 1
extern char idx_string[7];
extern char nvalue_string[2];
#endif // DOMOTICZ_SUPPORT == 1
#endif // BUILD_SUPPORT == MQTT_BUILD


// These MQTT variables must always be compiled for both the MQTT_BUILD and
// the BROWSER_ONLY_BUILD to maintain a common user interface between the MQTT
// and Browser Only versions.
uint8_t mqtt_start_status;            // Error (or success) status for startup
                                      // steps
uint8_t MQTT_error_status;            // For MQTT error status display in GUI
//uint8_t Pending_mqttserveraddr[4];    // Holds a new user entered MQTT Server
//                                      // IP address
//uint16_t Pending_mqttport;            // Holds a new user entered MQTT Host Port
//                                      // number
//char Pending_mqtt_username[11];       // Holds a new user entered MQTT username
//char Pending_mqtt_password[11];       // Holds a new user entered MQTT password
uint16_t mqttport;             	      // MQTT host port number
uint16_t mqtt_local_port;             // MQTT local port number
uint16_t Port_Mqttd;                  // In use MQTT host port number

uint32_t TRANSMIT_counter;       // Counts any transmit by the ENC28J60
uint8_t MQTT_resp_tout_counter;  // Counts response timeout events in the
                                 // mqtt_sanity_check() function
uint8_t MQTT_not_OK_counter;     // Counts MQTT != OK events in the
                                 // mqtt_sanity_check() function
uint8_t MQTT_broker_dis_counter; // Counts broker disconnect events in
                                 // the mqtt_sanity_check() function

#if DS18B20_SUPPORT == 1
// DS18B20 variables
uint32_t check_DS18B20_ctr;      // Counter used to trigger temperature
                                 // measurements
int8_t send_mqtt_temperature;    // Indicates if a new temperature measurement
                                 // is pending transmit on MQTT. In this
				 // application there are 5 sensors, so setting
				 // to 4 will cause all 5 to transmit (4,3,2,1,0).
				 // -1 indicates nothing to transmit.
int numROMs;                     // Count of DS18B20 devices found.
#if OB_EEPROM_SUPPORT == 0
// FoundROM is located in a global RAM location if there is no I2C EEPROM
extern uint8_t FoundROM[5][8];   // Table of found ROM codes
                                 // [x][0] = Family Code
                                 // [x][1] = LSByte serial number
                                 // [x][2] = byte 2 serial number
                                 // [x][3] = byte 3 serial number
                                 // [x][4] = byte 4 serial number
                                 // [x][5] = byte 5 serial number
                                 // [x][6] = MSByte serial number
                                 // [x][7] = CRC
#endif // OB_EEPROM_SUPPORT == 0
#endif // DS18B20_SUPPORT == 1


#if BME280_SUPPORT == 1
// BME280 variables
struct bme280_dev dev;        // Structure to store the device calibration
                              // data and device settings.
// int8_t rslt;		      // Variable to report BME280 function results.
uint32_t check_BME280_ctr;    // Time counter to determine when to collect the
                              // BME280 measurements.
struct bme280_data comp_data; // Structure to collect the compensated
                              // pressure, temperature and humidity data.
uint8_t BME280_found;         // Used to indicate that that a BME280 device
                              // was found on the I2C bus.
int8_t send_mqtt_BME280;      // Indicates if new BME280 sensor measurements
                              // are pending transmit on MQTT.
			      //
			      // In thee Home Assistant environment the BME280
			      // is treated as 3 separate sensors (Temperature,
			      // Humidity, Pressure) so setting send_mqtt_BME280
			      // to 2 will cause all 3 to transmit (2,1,0).
			      //
			      // In the Domoticz environment the BME280 sensors
			      // are sent as a single message, so setting to
			      // 0 will cause the sensor values to transmit.
			      //
			      // In both environments -1 indicates "nothing to
			      // transmit".
extern int32_t comp_data_temperature; // Compensated temperature
extern int32_t comp_data_humidity;    // Compensated humidity
#endif // BME280_SUPPORT == 1


#if INA226_SUPPORT == 1;
// INA226 variables
extern int32_t voltage;       // Voltage value (x1000) reported by the INA226
extern int32_t current;       // Current value (x1000) reported by the INA226
extern int32_t power;         // Power value (x1000) reported by the INA226
#endif // INA226_SUPPORT == 1;


#if BUILD_SUPPORT == CODE_UPLOADER_BUILD
extern uint8_t upgrade_failcode;     // Failure codes for Flash upgrade
                                     // process
#endif // BUILD_SUPPORT == CODE_UPLOADER_BUILD


#if OB_EEPROM_SUPPORT == 1
// I2C EEPROM variables
extern uint8_t eeprom_copy_to_flash_request; // Flag to cause the main.c loop
                                     // to call the copy to flash function.
uint32_t check_I2C_EEPROM_ctr;       // Counter to time an I2C EEPROM
                                     // to Flash copy request
extern char * flash_ptr;             // Used in code update routines to copy
                                     // data into Flash
extern uint8_t eeprom_num_write;     // Used in code update routines
extern uint8_t eeprom_num_read;      // Used in code update routines
extern uint16_t eeprom_base;         // Used in code update routines
uint8_t eeprom_detect;               // Used in code update routines

#endif // OB_EEPROM_SUPPORT == 1


#if LOGIN_SUPPORT == 1
extern uint8_t Login_Tracker[4];              // Login Indicators and Attempt
extern uint8_t Auto_Log_Out_Timer[4];         // Auto Log Out Timers for 4 Browsers
extern uint8_t Response_Lockout_Cancel_Timer; // Response Lockout Cancel Timer
extern uint32_t ripaddr_table[4];             // ripaddr table (4 bytes per Browser)
uint32_t login_update_timer;                  // Timer to update Login timers
#endif // LOGIN_SUPPORT == 1





//---------------------------------------------------------------------------//
int main(void)
{
  uip_ipaddr_t IpAddr;
  extern uint16_t uip_slen;

  // Initialize and enable clocks and timers. This must be done first to let
  // the processor clock stabilize.
  clock_init();
  // A mystery: When the ST-LINK V2 is used to program the code it appears to
  // start running for a brief number of milliseconds (2 or 3 times!) before
  // reset is released. I placed a wait timer here to absorb that activity so
  // that no other code runs until the device is actually released from reset.
  wait_timer(50000); // Wait 50ms
  wait_timer(50000); // Wait 50ms

  parse_complete = 1; // parse_complete is set to 1 so that the first time
                      // check_runtime_changes is called it will sync the
		      // runtime variables with the EEPROM.
  reboot_request = 0;
  user_reboot_request = 0;
  restart_request = 0;
  user_restart_request = 0;
  t100ms_ctr1 = 0;
  restart_reboot_step = RESTART_REBOOT_IDLE;
  stack_error = 0;
  uart_init_complete = 0;


#if IWDG_ENABLE == 1
  init_IWDG();      // Initialize the Independant Watchdog
#endif // IWDG_ENABLE
  

#if BUILD_SUPPORT == MQTT_BUILD
  // Initialize MQTT variables
  mqtt_parse_complete = 0;
  mqtt_close_tcp = 0;
  mqtt_enabled = 0;                      // Initialized to 'disabled'
  mqtt_start = MQTT_START_TCP_CONNECT;	 // Tracks the MQTT startup steps
  mqtt_keep_alive = 60;                  // Ping interval in seconds
  mqtt_start_ctr1 = 0;			 // Tracks time for the MQTT startup
                                         // steps
  mqtt_sanity_ctr = 0;			 // Tracks time for the MQTT sanity
                                         // steps
  mqtt_restart_step = MQTT_RESTART_IDLE; // Step counter for MQTT restart
  state_request = STATE_REQUEST_IDLE;    // Set the state request received to
                                         // idle
  // If the MQTT Enable bit is set in the Config settings set the mqtt_enabled
  // bit so that the MQTT feature is enabled. This is needed even if no pins
  // are enabled so that the temperature sensor reporting will work.
  if (stored_config_settings & 0x04) mqtt_enabled = 1;
  
  // Increment the Rotation Pointer to be sure that we won't encounter the
  // TCP connection TIME_WAIT issue in the MQTT server when reboot occurs.
  // Note: This is only needed for MQTT builds but is included in all builds
  // to simplify code.
  {
    uint8_t i;
    unlock_eeprom();
    i = (uint8_t)(stored_options2 & 0x07);
    if (i < 4) i++;
    else i = 0;
    stored_options2 = (uint8_t)((stored_options2 & 0xf8) | i);
    lock_eeprom();
  }
#endif // BUILD_SUPPORT == MQTT_BUILD

  
  // The following variables are only used for tracking MQTT startup status,
  // but they must always be compiled for both the MQTT_BUILD and the
  // BROWSER_ONLY_BUILD to maintain a common user interface between the MQTT
  // and Browser Only versions.
  mqtt_start_status = MQTT_START_NOT_STARTED; // Tracks error states during
                                         // startup
  MQTT_error_status = 0;                 // For MQTT error status display in
                                         // GUI
  MQTT_resp_tout_counter = 0;            // Initialize the MQTT response
                                         // timeout event counter
  MQTT_not_OK_counter = 0;               // Initialize the MQTT != OK event
                                         // counter
  MQTT_broker_dis_counter = 0;           // Initialize the MQTT broker
                                         // disconnect event counter


#if BUILD_SUPPORT == BROWSER_ONLY_BUILD
  timer_flags = 0x07; // Set all timer_flags to 1 to support IO_TIMER decrementing
#endif // BUILD_SUPPORT == BROWSER_ONLY_BUILD


#if OB_EEPROM_SUPPORT == 1
  // Intialize the Update Support variables
  eeprom_copy_to_flash_request = I2C_COPY_EEPROM_IDLE;
  check_I2C_EEPROM_ctr = 0;
#endif // OB_EEPROM_SUPPORT == 1


  // Check for down revision EEPROM and upgrade if needed.
  upgrade_EEPROM();

  // Apply settings stored in EEPROM such as IP Address, Gateway Address,
  // Netmask, Port number, etc. If there are no previously stored settings
  // in the EEPROM then use defaults. This must occur before gpio_init()
  // because gpio_init() uses settings in the EEPROM and we need to make
  // sure it is up to date.
  check_eeprom_settings();
			   
  // Apply the EEPROM settings to runtime variables
  apply_EEPROM_settings();
			   
  // Initialize and enable STM8 gpio pins. This must be done before attempting
  // access to the PCF8574.
  gpio_init();

  // Initialize the PCF8574 settings and pins stored in I2C EEPROM. This must
  // occur after gpio_init() because the PCF8574 settings are stored in I2C
  // EEPROM which uses IO pins 14 and 15 to implement the I2C bus.
  apply_PCF8574_pin_settings();

  // Initialize pins and IO trackers for the first time after validation of
  // EEPROM contents. This operates on STM8 and PCF8574 pins.
  initialize_pins();
  
#if BME280_SUPPORT == 1
  // Initialize the BME280
  BME280_found = 0;
//  rslt = bme280_init(&dev);
//  if (rslt == BME280_OK) {
  if (bme280_init(&dev) == BME280_OK) {
    BME280_found = 1;
  }
#endif // BME280_SUPPORT == 1


  // Initialize the TRANSMIT counter
  TRANSMIT_counter = 0;
  
  // Restore the saved debug statistics
  restore_eeprom_debug_bytes();



    
#if DEBUG_SUPPORT == 15
  // Initialize the UART for debug output
  // Note: gpio_init() must be called prior to this call
  InitializeUART();
  uart_init_complete = 1;
  UARTPrintf("\r\n\n\n\n\nBooting Rev ");
  UARTPrintf(code_revision);
  
#if BUILD_SUPPORT == MQTT_BUILD || BUILD_SUPPORT == BROWSER_ONLY_BUILD
  UARTPrintf("   MQTT or BROWSER\r\n");
#endif // BUILD_SUPPORT == MQTT_BUILD || BUILD_SUPPORT == BROWSER_ONLY_BUILD

#if BUILD_SUPPORT == CODE_UPLOADER_BUILD
  UARTPrintf("   Code Uploader\r\n");
#endif // BUILD_TYPE_CODE_UPLOADER == 1
#endif // DEBUG_SUPPORT == 15


#if BUILD_TYPE_CODE_UPLOADER == 1
#if RESPONSE_LOCK_SUPPORT == 1
  // If starting the Code Uploader make sure the Response Lock is turned OFF.
  // This is not necessary if the Code Uploader was started from running code
  // as that could only happen if the Response Lock was already off. Howerver,
  // if started by downloading the Code Uploader over the SWIM interface it is
  // possible that the Response Lock was ON from previous activity and this
  // will interfere with operation of the Code Uploader.
  {
    uint8_t j;
    j = (uint8_t)(stored_options1 & 0xbf); // Clear response locked bit
    update_settings_options(UPDATE_OPTIONS1, j);
  }
#endif // RESPONSE_LOCK_SUPPORT == 1
#endif // BUILD_TYPE_CODE_UPLOADER == 1


  spi_init();              // Initialize the SPI bit bang interface to the
                           // ENC28J60 and perform hardware reset on ENC28J60

  LEDcontrol(1);           // turn LED on
  
  Enc28j60Init();          // Initialize the ENC28J60 ethernet interface
                           // Note: Run restore_eeprom_debug_bytes() before
			   // this init so that the Stack Overflow bit is
			   // properly handled.

  uip_arp_init();          // Initialize the ARP module
  
  uip_init();              // Initialize uIP Web Server
  
  HttpDInit();             // Initialize listening ports
  
  HttpDStringInit();       // Initialize HttpD string sizes


#if LINKED_SUPPORT == 1
  linked_edge = 0;	   // Used for indicating Input pin edge detection
			   // when using Linked pins. Must be cleared when
			   // booting.
  // Read input pins, but signal that the read is during initialization so
  // that only the ON_OFF_words will be updated and the the linked_edge byte
  // will not be updated. The read needs to be performed twice so that
  // ON_OFF_word_new1, ON_OFF_word_new2, and ON_OFF_word will be equalized.
  read_input_pins(1);
  read_input_pins(1);
#endif // LINKED_SUPPORT == 1



#if DS18B20_SUPPORT == 1
  init_DS18B20();          // Initialize DS18B20 sensors
  // Initialize DS18B20 control variables used in main.c 
  if (stored_config_settings & 0x08) {
    // Find all devices
    FindDevices();
    // Iniialize DS18B20 timer
    check_DS18B20_ctr = second_counter;
    // Initialize DS18B20 sensor add/delete check counter
    // Collect initial temperature
    get_temperature();
    // Iniialize DS18B20 transmit control variable
    send_mqtt_temperature = -1; // Indicates nothing to send on MQTT yet.
  }
#endif // DS18B20_SUPPORT == 1


//#if BME280_SUPPORT == 1
//  // Initialize the BME280
//  BME280_found = 0;
// //  rslt = bme280_init(&dev);
// //  if (rslt == BME280_OK) {
//  if (bme280_init(&dev) == BME280_OK) {
//    BME280_found = 1;
//    if (stored_config_settings & 0x20) {
//      // If a BME280 sensor was found and the config_settings show the sensor
//      // is enabled then collect the sensor data. This measurement at startup
//      // is needed so that sensor data is available for display when the
//      // IOControl page is shown at boot time.
//      stream_sensor_data_forced_mode(&dev, &comp_data);
//      send_mqtt_BME280 = 2; // Indicates we should send BME280 data as part of
//                        // boot. Even though only 1 BME280 is supported
//			// send_MQTT_BME280 is set to "2" so that all three
//			// sensors (Temp, Humidity, Pressure) within the
//			// BME280 are sent (2, 1, 0).
//      check_BME280_ctr = second_counter;
//    }
//  }
//#endif // BME280_SUPPORT == 1


#if BME280_SUPPORT == 1
  if (BME280_found == 1) {
    if (stored_config_settings & 0x20) {
      // If a BME280 sensor was found and the config_settings show the sensor
      // is enabled then collect the sensor data. This measurement at startup
      // is needed so that sensor data is available for display when the
      // IOControl page is shown at boot time.
      stream_sensor_data_forced_mode(&dev, &comp_data);
      send_mqtt_BME280 = 2; // Indicates we should send BME280 data as part of
                        // boot. Even though only 1 BME280 is supported
			// send_MQTT_BME280 is set to "2" so that all three
			// sensors (Temp, Humidity, Pressure) within the
			// BME280 are sent (2, 1, 0).
      check_BME280_ctr = second_counter;
    }
  }
  if (BME280_found == 0) {
    // If BME280 sensor was not found then then force the BME280 Enable bit off.
    // This will help reduce confusion on the part of the user that may think
    // they can enable BME280 support on the Config Page but they have not
    // connected a BME280 sensor.
    Pending_config_settings &= (uint8_t)(~0x20);
    // Note: parse_complete was set to 1 duriing main variable initialization.
    // This will cause any change to the Pending_config_settings to update the
    // EEPROM if needed.
  }
#endif // BME280_SUPPORT == 1


#if PCF8574_SUPPORT == 1
  // Initialize the PCF8574 and update the stored_options1 byte to reflect the
  // presence or absence of the PCF8574
  PCF8574_init();
  
  // XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
  // XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
  // XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
  // A problem that becomes apparent in the Domoticz builds occurs when
  // PCF8574_SUPPORT == 1 but there is no PCF8574. Old contents in the I2C
  // EEPROM can show up as PCF8574 settings. The user can simply delete those
  // settings in the GUI, but it may be reasonable to set the pin_control
  // bytes to "disabled" at this point in the code instead. The only problem
  // with doing this in an automated way is the case where the PCF8574 was
  // accidentally removed, then reattached. Automated code will have set all
  // pins to disabled, but if automated code is not used the user settings
  // will remain in the I2C EEPROM.
  // XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
  // XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
  // XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
#endif // PCF8574_SUPPORT == 1


#if INA226_SUPPORT == 1
  // Initialize all INA226 devices
  ina226_init_all();
  //   Calibrate all INA226 devices
  ina226_calibrate_all();
  //   Configure all INA226 devices
  ina226_configure_all();
#endif // INA226_SUPPORT == 1


#if LOGIN_SUPPORT == 1
  // Initialize Login function variables. If the Login function is enabled
  // this has the effect of logging out all browsers.
  // Zero out the ripaddr table (four 32 bit values)
  memset(ripaddr_table, 0, 16);
  // Set Auto Log Out Timers to 0.
  memset(Auto_Log_Out_Timer, 0, 4);
  // Clear the Login Indicators and Login Attempt Counters.
  memset(Login_Tracker, 0, 4);
  // Set Response_Lockout_Cancel_Timer to 0.
  Response_Lockout_Cancel_Timer = 0;
  
  // Initialize the login update timer.
  login_update_timer = second_counter;
#endif // LOGIN_SUPPORT == 1


  // The following initializes the stack over-run guardband variables. These
  // variables are monitored periodically and should never change unless
  // there is a stack overflow (wherein the stack will over write this preset
  // content).
  stack_limit1 = 0xaa;
  stack_limit2 = 0x55;
  // Initialize debug[2] to reflect the stack overflow condition stored in
  // EEPROM.


#if DEBUG_SUPPORT == 15
  // Check RST_SR (Reset Status Register). This call will update the debug
  // bytes associated with the RST_SR if any changes have occurred.
  check_rst_sr();

#if TEMP_DEBUG_EXCLUDE == 0
  UARTPrintf("ENC28J60 Rev Code ");
  emb_itoa((debug_bytes[2] & 0x07), OctetArray, 16, 2);
  UARTPrintf(OctetArray);
  UARTPrintf("\r\n");

  UARTPrintf("EMCF: ");
  emb_itoa(debug_bytes[5], OctetArray, 10, 3);
  UARTPrintf(OctetArray);
  UARTPrintf("  SWIMF: ");
  emb_itoa(debug_bytes[6], OctetArray, 10, 3);
  UARTPrintf(OctetArray);
  UARTPrintf("  ILLOPF: ");
  emb_itoa(debug_bytes[7], OctetArray, 10, 3);
  UARTPrintf(OctetArray);
  UARTPrintf("  IWDGF: ");
  emb_itoa(debug_bytes[8], OctetArray, 10, 3);
  UARTPrintf(OctetArray);
  UARTPrintf("  WWDGF: ");
  emb_itoa(debug_bytes[9], OctetArray, 10, 3);
  UARTPrintf(OctetArray);
  UARTPrintf("\r\n");
  
  if (debug_bytes[2] & 0x80) UARTPrintf("Stack Overflow ERROR!\r\n");
  else UARTPrintf("Stack Overflow - none detected\r\n");
  
  if (stored_options2 & 0x40) UARTPrintf("Login function enabled\r\n");
  else UARTPrintf("Login function disabled\r\n");
  
  UARTPrintf("\r\n");
#endif // TEMP_DEBUG_EXCLUDE == 0
#endif // DEBUG_SUPPORT == 15


#if DEBUG_SUPPORT == 15
// UARTPrintf("stored_options1 at boot = ");
// emb_itoa(stored_options1, OctetArray, 16, 2);
// UARTPrintf(OctetArray);
// UARTPrintf("\r\n");
#endif // DEBUG_SUPPORT == 15



#if OB_EEPROM_SUPPORT == 1
  // Verify that I2C EEPROM(s) exist.
  eeprom_detect = off_board_EEPROM_detect();
#endif // OB_EEPROM_SUPPORT == 1


#if BUILD_SUPPORT == CODE_UPLOADER_BUILD
  // If a Code Uploader Build copy Flash to EEPROM Region 1. While this runs
  // with any Code Uploader boot, it is really only necessary if the Code
  // Uploader was placed in Flash via the SWIM interface. This copy then makes
  // sure that the Code Uploader version stored in I2C EEPROM matches what the
  // user programmed into Flash (presumably the latest revision of the Code
  // Uploader).
  if (eeprom_detect == 1) {
    copy_code_uploader_to_EEPROM_R1();
    // Flicker LED for 1 second to indicate I2C EEPROM write completion
    fastflash();
  }
#endif // BUILD_SUPPORT == CODE_UPLOADER_BUILD


#if BUILD_SUPPORT == BROWSER_ONLY_BUILD || BUILD_SUPPORT == MQTT_BUILD
#if OB_EEPROM_SUPPORT == 1
  // This code protects the user from a scenario where they:
  // a) Have the Uploader installed in I2C EEPROM
  // b) Use SWIM to load a new runtime firmware
  // c) When they start the Uploader they select "reinstall".
  // The above scenario fails without the check coded here because SWIM
  // installed the runtime firmware rather than the Uploader. If the Uploader
  // had been used to install the runtime firmware a copy of the firmware
  // image would be in I2C EEPROM.
  //
  // Copy Flash to I2C EEPROM Region 0.
  if (eeprom_detect == 1) {
    copy_flash_to_EEPROM_R0();
    // Flicker LED for 1 second to indicate I2C EEPROM write completion
    fastflash();
  }
#endif // OB_EEPROM_SUPPORT == 1
#endif // BUILD_SUPPORT == BROWSER_ONLY_BUILD || BUILD_SUPPORT == MQTT_BUILD    


#if HTTPD_DIAGNOSTIC_SUPPORT == 1
  // Call the httpd_diagnotic() to verify that the content of the String file
  // is correct. The UART must be enabled for this to work.
  httpd_diagnostic();
#endif // HTTPD_DIAGNOSTIC_SUPPORT == 1


  //-------------------------------------------------------------------------//
  // MAIN LOOP
  //-------------------------------------------------------------------------//
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

    // The ENC28J60 is set up for a receive buffer of 6KB (see ENC28J60.h).
    // The ENC28J60 buffer size should be more than enough to hold all
    // messages that are received in a burst (say from a Home Assistant
    // "Toggle" operation) until they can be processed, assuming the burst
    // isn't repeated at a rapid rate. A PUBLISH message in a Home Assistant
    // Header Toggle burst will be about 88 bytes, consisting of 54 bytes
    // LLH/TCPIP headers and about 34 bytes MQTT PUBLISH message. A burst of
    // 16 PUBLISH messages from HA thus requires about 1400 bytes in the
    // ENC28J60 receive buffer.
    //
    // IMPORTANT: Analysis of all messages being received by the Network
    // Module shows that there is a lot of traffic on a typical Ethernet
    // cable that makes it through the ENC28J60 filters and needs to be
    // dispositioned by the uip.c code. For example:
    // - ARP pings
    // - ICMP traffic
    // - Messages that match the MAC address, but not the IP address
    // - Messages that match MAC and IP, but are not a valid Port
    // - Other miscellaneous traffic that is discarded
    // I have no idea where most of the above traffic originates, but it all
    // occupies processing and buffer memory in addition to the genuine
    // application traffic of interest.

    uip_len = Enc28j60Receive(uip_buf); // Check for incoming packets

    if (uip_len > 0) {
      // Removed "htons" code to reduce Flash usage. This can be done as the
      // SMT8 is "Big Endian". Keep the commented code in case the application
      // is ported to a "Little Endian" architecture.
      // if (((struct uip_eth_hdr *) & uip_buf[0])->type == htons(UIP_ETHTYPE_IP)) {
      if (((struct uip_eth_hdr *) & uip_buf[0])->type == UIP_ETHTYPE_IP) {
        // This code is executed if incoming traffic is HTTP or MQTT (not ARP).
        // uip_len includes the headers, so it will be > 0 even if no TCP
        // payload.
        uip_input(); // Calls uip_process(UIP_DATA) to process a received
	// packet.
        // If the above process resulted in data that should be sent out on
	// the network the global variable uip_len will have been set to a
	// value > 0.
        if (uip_len > 0) {
          uip_arp_out(); // Verifies arp entry in the ARP table and builds
	                 // the LLH
          // The original uip code has a uip_split_output function. It is not
          // needed for this application due to small packet sizes, so the
          // Enc28j60 transmit functions are called directly.
          Enc28j60Send(uip_buf, uip_len);
        }
      }
      // Removed "htons" code to reduce Flash usage. This can be done as the
      // SMT8 is "Big Endian". Keep the commented code in case the application
      // is ported to a "Little Endian" architecture.
      // else if (((struct uip_eth_hdr *) & uip_buf[0])->type == htons(UIP_ETHTYPE_ARP)) {
      else if (((struct uip_eth_hdr *) & uip_buf[0])->type == UIP_ETHTYPE_ARP) {
        // This code is executed if incoming traffic is an ARP request.
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

#if BUILD_SUPPORT == MQTT_BUILD
    // Perform MQTT startup if 
    // a) MQTT is enabled
    // b) Not already at start complete
    // c) Not currently performing the restart steps
    // d) Not currently performing restart_reboot
    // e) A user requested reboot is not pending
    // f) A user requested restart is not pending
    if (mqtt_enabled == 1
     && mqtt_start != MQTT_START_COMPLETE
     && mqtt_restart_step == MQTT_RESTART_IDLE
     && restart_reboot_step == RESTART_REBOOT_IDLE
     && user_reboot_request == 0
     && user_restart_request == 0) {
      mqtt_startup();
    }
    
    // Perform MQTT sanity check if
    // a) MQTT is enabled
    // b) Not currently performing MQTT startup
    // c) Not currently performing restart_reboot
    // d) A user requested reboot is not pending
    if (mqtt_enabled == 1
     && mqtt_start == MQTT_START_COMPLETE
     && restart_reboot_step == RESTART_REBOOT_IDLE
     && user_reboot_request == 0) {
      mqtt_sanity_check(&mqttclient);
    }
#endif // BUILD_SUPPORT == MQTT_BUILD

    // Update the time keeping function
    timer_update();

#if BUILD_SUPPORT == MQTT_BUILD
    // If the MQTT timer expires (50ms)
    //   And MQTT is enabled
    //   And MQTT startup is complete
    //     Then check for pin state change messages that need to be
    //     published
    // Also
    //   Increment the MQTT timers every 50ms
    if (mqtt_timer_expired()) {
      if (mqtt_enabled) {
        if (mqtt_start == MQTT_START_COMPLETE) {
	  // publish_outbound() is called to check for any pending pin or
	  // temperature state changes that need to be PUBLISHed via MQTT.
	  // publish_outbound will place PUBLISH messages in the MQTT sendbuf
	  // one per call, and only if the sendbuf is empty.
	  publish_outbound();
	  // Call the periodic_service() function to clear out the MQTT
	  // traffic just now placed in the uip_buf. Even though there is
	  // a periodic_service() call in the main loop we don't want to
	  // wait for its timer to expire for MQTT service. Experience has
	  // shown that failing to do the periodic_serivce() call here
	  // causes loss of MQTT messages and in some cases MQTT errors
	  // and TCP resets.
	  periodic_service();
	}
        mqtt_start_ctr1++; // Increment the MQTT start loop timer 1. This is
                           // used to:
			   //   - Timeout the MQTT Server ARP request or the
                           //     MQTT Server TCP connection request if the
			   //     server is not responding.
			   //   - Limit the rate at which timeouts occur in
			   //     the MQTT Broker connection requests.
			   //   - Govern the rate at which subscription and
			   //     HA Auto Discovery messaging is placed in
			   //     the transmit queue.
			   // Note that uip_periodic() drives actual message
			   // transmission at X ms intervals - see timer.c.
        mqtt_sanity_ctr++; // Increment the MQTT sanity loop timer. This is
                           // used to provide timing for the MQTT Sanity
                           // Check function.			   
      }
    }
#endif // BUILD_SUPPORT == MQTT_BUILD

    if (periodic_timer_expired()) {
      // The periodic timer expires every X ms (see timer.c).
      // Call the periodic_service() function
      periodic_service();
    }

    // 100ms timer
    if (t100ms_timer_expired()) {
      t100ms_ctr1++;     // Increment the 100ms counter. ctr1 is used in the
                         // restart/reboot process. Normally the counter is
			 // not used and will just roll over every 2^32
			 // counts. Any code that uses ctr1 should reset it to
			 // zero then compare to a value needed for a timeout.
#if BUILD_SUPPORT == BROWSER_ONLY_BUILD
      decrement_pin_timers(); // Call the pin_timers function every 100ms
#endif // BUILD_SUPPORT == BROWSER_ONLY_BUILD
    }

#if BUILD_SUPPORT == CODE_UPLOADER_BUILD
    // Check for a request to copy the I2C EEPROM Region 0 to Flash.
    // The request is automatically generated by the process that uploads the
    // user specified file after the file is copied to the I2C EEPROM.
    // The request is also generated if the user presses the Restore button
    // (generating a /73 command) while in the Uploader GUI.
    if (eeprom_copy_to_flash_request == I2C_COPY_EEPROM_R0_REQUEST) {
      eeprom_copy_to_flash_request = I2C_COPY_EEPROM_R0_WAIT;
      check_I2C_EEPROM_ctr = t100ms_ctr1;
    }
    // Give main loop 1000ms for browser update
    if ((eeprom_copy_to_flash_request == I2C_COPY_EEPROM_R0_WAIT) &&
        (t100ms_ctr1 > (check_I2C_EEPROM_ctr + 10))) {
      unlock_flash();
      // copy_I2C_EEPROM_to_Flash() will cause a reboot on completion of the
      // function.
      // Set values needed by copy_I2C_EEPROM_to_Flash()
      eeprom_num_write = I2C_EEPROM_R0_WRITE;
      eeprom_num_read = I2C_EEPROM_R0_READ;
      eeprom_base = I2C_EEPROM_R0_BASE;
      flash_ptr = (char *)FLASH_START_PROGRAM_MEMORY;
      
      // The _fctcpy function will copy the memcpy_update segment to RAM, then
      // the copy_I2C_EEPROM_to_Flash() function will call the copy_RAM_to_Flash()
      // function in the memcpy_update segment from RAM.
      _fctcpy('m');

      if (eeprom_detect == 1 && upgrade_failcode == UPGRADE_OK) {
        // copy_I2C_EEPROM_to_Flash() will reprogram the Flash with the I2C EEPROM
	// contents. On completion of the copy the module will reboot.

#if DEBUG_SUPPORT == 15
UARTPrintf("Copying EEPROM Region 0 to Flash\r\n");
#endif // DEBUG_SUPPORT == 15

        copy_I2C_EEPROM_to_Flash(249);
      }
      else if (eeprom_detect == 0) {

#if DEBUG_SUPPORT == 15
UARTPrintf("EEPROM Region 0 copy to Flash failed because eeprom_detect == 0\r\n");
#endif // DEBUG_SUPPORT == 15

      }
      else if (upgrade_failcode != UPGRADE_OK) {

#if DEBUG_SUPPORT == 15
UARTPrintf("EEPROM Region 0 copy to Flash failed because upgrade_failcode != UPGRADE_OK\r\n");
#endif // DEBUG_SUPPORT == 15

      }
      lock_flash();
    }
#endif // BUILD_SUPPORT == CODE_UPLOADER_BUILD

#if OB_EEPROM_SUPPORT == 1
    // Check for a request to copy the I2C EEPROM Region 1 to Flash. The
    // request is generated when the user inputs a /72 command to start the
    // Code Uploader.
    if (eeprom_copy_to_flash_request == I2C_COPY_EEPROM_R1_REQUEST) {
      eeprom_copy_to_flash_request = I2C_COPY_EEPROM_R1_WAIT;
      check_I2C_EEPROM_ctr = t100ms_ctr1;
    }
    // Give main loop 1000ms for browser update
    if ((eeprom_copy_to_flash_request == I2C_COPY_EEPROM_R1_WAIT) &&
        (t100ms_ctr1 > (check_I2C_EEPROM_ctr + 10))) {
      unlock_flash();
      // copy_I2C_EEPROM_to_Flash() will cause a reboot on completion of the
      // function.
      // Set values needed by copy_I2C_EEPROM_to_Flash()
      eeprom_num_write = I2C_EEPROM_R1_WRITE;
      eeprom_num_read = I2C_EEPROM_R1_READ;
      eeprom_base = I2C_EEPROM_R1_BASE;
      flash_ptr = (char *)FLASH_START_PROGRAM_MEMORY;
      
      // The _fctcpy function will copy the memcpy_update segment to RAM, then
      // the copy_I2C_EEPROM_to_Flash() function will call the copy_RAM_to_Flash()
      // function in the memcpy_update segment from RAM.
      _fctcpy('m');
      
      if (eeprom_detect) {
        // copy_I2C_EEPROM_to_Flash() will reprogram the Flash with the I2C EEPROM
	// contents. On completion of the copy the module will reboot.
        copy_I2C_EEPROM_to_Flash(249);
      }
      lock_flash();
    }
#endif // OB_EEPROM_SUPPORT == 1

    // Call the ARP timer function every 10 seconds.
    if (arp_timer_expired()) {
      uip_arp_timer(); // Clean out old ARP Table entries. Any entry that has
                       // exceeded the UIP_ARP_MAXAGE without being accessed
		       // is cleared. UIP_ARP_MAXAGE is typically 20 minutes.

#if DEBUG_SUPPORT == 15
// UARTPrintf("\r\n");
// UARTPrintf("Stack Overflow Status = ");
// if ((debug_bytes[2] & 0x80) == 0) UARTPrintf("GOOD\r\n");
// if (debug_bytes[2] & 0x80) {
// UARTPrintf("Stack Overflow ERROR!\r\n");
// debug_bytes[2] = (uint8_t)(debug_bytes[2] & 0x7f); // clear stack overflow error
// }
#endif // DEBUG_SUPPORT == 15
    }

#if DS18B20_SUPPORT == 1
    // Update temperature data
    // If a DS18B20 sensor was found and the config_settings show the sensor
    // is enabled then collect the sensor data every 30 seconds.
    if ((stored_config_settings & 0x08) && (second_counter > (check_DS18B20_ctr + 30))) {
      check_DS18B20_ctr = second_counter;
      get_temperature();
#if BUILD_SUPPORT == MQTT_BUILD
      send_mqtt_temperature = 4; // Indicates that all 5 temperature sensors
                                 // need to be transmitted via MQTT.
#endif // BUILD_SUPPORT == MQTT_BUILD
    }
#endif // DS18B20_SUPPORT == 1

#if BME280_SUPPORT == 1
    // If a BME280 sensor was found and the config_settings show the sensor
    // is enabled then collect the sensor data every 300 seconds. Not sure of
    // the best interval so 300 seconds (5 min) is used since the BME280 is
    // best suited to weather monitoring.
    if ((BME280_found == 1) && (stored_config_settings & 0x20)) {
      if (second_counter > (check_BME280_ctr + 300)) {
        check_BME280_ctr = second_counter;
        stream_sensor_data_forced_mode(&dev, &comp_data);
#if BUILD_SUPPORT == MQTT_BUILD
        send_mqtt_BME280 = 2; // Indicates that the BME280 sensors need to be
                              // transmitted via MQTT.
			      // The value is set to 2 because the Home
			      // Assistant implementation sends the
			      // Temperature, Humidity, and Pressure valuse as
			      // three separate sensors (so the
			      // send_mqtt_BME280 index counts down 2, 1, 0 to
			      // send all three sensors).
			      // The Domoticz implementation sends the three
			      // sensor values as a single message, so that
			      // code will see the "2" as a "send now", and
			      // will adjust the send_mqtt_BME280 count down
			      // accordingly.
#endif // BUILD_SUPPORT == MQTT_BUILD
#if DEBUG_SUPPORT == 15
        // Print sensor data on UART
//        print_sensor_data(&comp_data);
#endif // DEBUG_SUPPORT == 15
      }
    }
#endif // BME280_SUPPORT == 1
    
    
#if LOGIN_SUPPORT == 1
//    if ((second_counter > (login_update_timer + 60))) {
    // XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
    // XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
    // XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
    // For development only the timer is reduced to 10 seconds to allow
    // faster countdowns.
    if ((second_counter > (login_update_timer + 10))) {
    // XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
    // XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
    // XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
      login_update_timer = second_counter;
      // Call function to update login timers and manage timeouts.
      login_timer_management();
    }
#endif // LOGIN_SUPPORT == 1
    
    
#if BUILD_SUPPORT == BROWSER_ONLY_BUILD || BUILD_SUPPORT == MQTT_BUILD
    // Check for changes in Output control states, IP address, IP gateway
    // address, Netmask, MAC, and Port number.
    // This functionality is not needed for the CODE_UPLOADER build.
    check_runtime_changes();
#endif // BUILD_SUPPORT == BROWSER_ONLY_BUILD || BUILD_SUPPORT == MQTT_BUILD

    // Check for the Reset button
    check_reset_button();

    // Check for Restart or Reboot request generated by the user pressing the
    // reset button or generated by the user making changes in the GUI that
    // require a restart or reboot.
    check_restart_reboot();
  }
  return 0;
}


void periodic_service(void)
{
  int i;
  for(i = 0; i < UIP_CONNS; i++) {
    uip_periodic(i);
    // uip_periodic() calls uip_process(UIP_TIMER) for each connection.
    // Every connection is checked in this loop one time. With each pass
    // only one connection (one HTTP or one MQTT) will transmit unserviced
    // outbound traffic one packet at a time.
    //
    //   HTTP connections (the webbrowser) will generate and place its
    //   data in the uip_buf via a call to HttpDCall(). HTTP connections
    //   can have pending transmissions which are continuations of a
    //   series of packets because the web pages can be broken into
    //   several packets.
    //
    //   MQTT will always use this function to transmit packets. MQTT
    //   will have placed its outbound packets in the mqtt_sendbuf. MQTT
    //   connections will consist of a complete message in one packet.
    //
    //   Additionally, there will be TCP handshake transactions such as SYN,
    //   SYNACK, ACK and FIN that are processed as a result of a
    //   uip_process(UIP_TIMER).
    //
    // If uip_periodic() resulted in data that should be sent out on
    // the network the global variable uip_len will have been set to a
    // value > 0 so that Enc28j60Send() will be called.
    //
    // Note that when the device first powers up and MQTT is enabled the
    // MQTT processes will attempt to send a SYN to create a TCP
    // connection. The uip_periodic() function discovers the SYN is
    // pending to be sent, causing uip_len to be > 0. Below you'll see
    // that uip_arp_out() is called first, and on the first pass it will
    // find that an ARP request is needed. The SYN will be replaced with
    // an ARP request, and on a future cycle through this routine the
    // SYN will be sent IF the ARP request was successful.
    
    if (uip_len > 0) {
      uip_arp_out(); // Verifies arp entry in the ARP table and builds
                     // the LLH
      Enc28j60Send(uip_buf, uip_len);
    }
  }
}


#if OB_EEPROM_SUPPORT == 1
uint8_t off_board_EEPROM_detect(void)
{
  // Verify that an I2C EEPROM exists. This routine is directed at
  // detecting a 256KB I2C EEPROM.
  //
  // Presence verification is performed by:
  //   Reading the first byte of the I2C EEPROM, inverting the byte,
  //   writing the inverted byte to the I2C EEPROM, and verifying that
  //   the inversion occurred. If the inversion occurred then eeprom_detect is
  //   set to 1 and the original byte is restored.
  //
  // If detection fails I2C EEPROM support is turned off.
  
  uint8_t eeprom_detect;
  uint8_t byte;
  
  eeprom_detect = 0;
    
  // Make sure the I2C bus is in a sane condition.
  I2C_reset();
  wait_timer(1000); // Wait 1 ms
  
  // Read 1 byte from I2C EEPROM.
  prep_read(I2C_EEPROM_R0_WRITE, I2C_EEPROM_R0_READ, I2C_EEPROM_R0_BASE, 2);
  byte = I2C_read_byte(1);


  // Write inverted byte to I2C EEPROM.
//  write_one((uint8_t)~byte);
  {
    uint8_t i;
    i = (uint8_t)~byte;
    // Write one byte to EEPROM Region 0 address 0x0000
    copy_STM8_bytes_to_I2C_EEPROM(&i, 1, I2C_EEPROM_R0_WRITE, 0, 2);
  }


  // Read and validate 1 byte from I2C EEPROM.
  prep_read(I2C_EEPROM_R0_WRITE, I2C_EEPROM_R0_READ, I2C_EEPROM_R0_BASE, 2);
   
  if ((uint8_t)~byte == I2C_read_byte(1)) {
    eeprom_detect = 1;
  }
  else {
  }
    
  // Restore the original 1 byte to I2C EEPROM.
//  write_one(byte);
  {
    // Write one byte to EEPROM Region 0 address 0x0000
    copy_STM8_bytes_to_I2C_EEPROM(&byte, 1, I2C_EEPROM_R0_WRITE, 0, 2);
  }

  return eeprom_detect;
}
#endif // OB_EEPROM_SUPPORT == 1


#if I2C_SUPPORT == 1
void prep_read(uint8_t control_write, uint8_t control_read, uint16_t start_address, uint8_t addr_size)
{
  // Function to set up a read from I2C devices.
  //
  // a) control_write / control_read are the Control Bytes needed to address
  //    the I2C device.
  // b) start_address identifies the address starting point in the I2C device.
  // c) address_size indicates if the address is one byte or two bytes.
  //    1 = single byte address (BME280 is always single byte)
  //    2 = two byte address (I2C EEPROM is always two byte)
  //
  // I2C EEPROM:
  // When setting up a sequential read from the I2C EEPROMs the following
  // applies:
  //   start_address identifies the address starting point in the I2C 
  //   EEPROM and is typically the first (base) address of the region in the
  //   I2C EEPROM, although it can also be a specific address offset
  //   into the I2C EEPROM region. For example:
  //     I2C EEPROM Region 0 base address: 0x0000 using I2C EEPROM_R0 Control Bytes
  //     I2C EEPROM Region 1 base address: 0x8000 using I2C EEPROM_R1 Control Bytes
  //     I2C EEPROM Region 2 base address: 0x0000 using I2C EEPROM_R2 Control Bytes
  //     I2C EEPROM Region 3 base address: 0x8000 using I2C EEPROM_R3 Control Bytes
  //

  // Initial write control byte to establish sequential read address
  I2C_control(control_write);
  I2C_byte_address(start_address, addr_size);
  I2C_control(control_read);
}
#endif // I2C_SUPPORT == 1


/*
#if OB_EEPROM_SUPPORT == 1
void write_one(uint8_t byte)
{
  // Function to write one byte to the I2C EEPROM
  // This is only used for the I2C EEPROM detection routine, thus only
  // uses I2C EEPROM address 0x0000
  I2C_control(I2C_EEPROM_R0_WRITE);
  I2C_byte_address(0x0000, 2);
  I2C_write_byte(byte);
  I2C_stop();
  wait_timer(5000); // Wait 5ms
}
#endif // OB_EEPROM_SUPPORT == 1
*/


#if BUILD_SUPPORT == CODE_UPLOADER_BUILD
void copy_code_uploader_to_EEPROM_R1(void)
{
  // This function copies a Code Uploader build from Flash to I2C EEPROM
  // Region 1. The Region 1 adddress range matches that of Flash (0x8000
  // to 0xFFFF).
  uint8_t i;
  uint16_t address_index;
  uint8_t I2C_last_flag;
  uint8_t temp_byte;

  flash_ptr = (char *)FLASH_START_PROGRAM_MEMORY; // Start = 0x8000
  address_index = I2C_EEPROM_R1_BASE; // Base = 0x8000
  
  I2C_reset();
  wait_timer(1000); // Wait 1 ms
  
//  while (address_index < FLASH_START_USER_RESERVE) {
  while (address_index < I2C_EEPROM_R1_START_VARIABLE_RESERVE) {
    // Note for "while" statement: address_index will be incremented by 128
    // with each loop. This matches the 128 byte block size of the I2C EEPROM.
    I2C_control(I2C_EEPROM_R1_WRITE); // Send Write Control Byte for upper
                                    // I2C EEPROM area
    I2C_byte_address(address_index, 2);
    for (i=0; i<128; i++) {
      I2C_write_byte(*flash_ptr);
      flash_ptr++;
    }
    I2C_stop();
    wait_timer(5000); // Wait 5ms
    address_index += 128;
    IWDG_KR = 0xaa; // Prevent the IWDG hardware watchdog from firing.
  }
}
#endif // BUILD_SUPPORT == CODE_UPLOADER_BUILD


#if BUILD_SUPPORT == BROWSER_ONLY_BUILD || BUILD_SUPPORT == MQTT_BUILD
#if OB_EEPROM_SUPPORT == 1
void copy_flash_to_EEPROM_R0(void)
{
  // This function copies a Browser Only or MQTT build to I2C EEPROM Region 0.
  // The entire Flash is copied up to but not including the IO_TIMERS and
  // IO_NAMES area of memory.
  // The function should only be called to cover the case where the user has
  // the I2C EEPROM installed but has updated the Runtime firmware via
  // the SWIM interface.
  uint8_t i;
  uint16_t address_index;
  uint8_t I2C_last_flag;
  uint8_t temp_byte;

  flash_ptr = (char *)FLASH_START_PROGRAM_MEMORY;
  address_index = I2C_EEPROM_R0_BASE;
  I2C_reset();
  wait_timer(1000); // Wait 1 ms
  
  while (address_index < OFFSET_TO_FLASH_START_USER_RESERVE) {
    copy_STM8_bytes_to_I2C_EEPROM(flash_ptr, 128, I2C_EEPROM_R0_WRITE, address_index, 2);
    flash_ptr += 128;
    address_index += 128;
    IWDG_KR = 0xaa; // Prevent the IWDG hardware watchdog from firing.
  }
}
#endif // OB_EEPROM_SUPPORT == 1
#endif // BUILD_SUPPORT == BROWSER_ONLY_BUILD || BUILD_SUPPORT == MQTT_BUILD


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
// The user can press the Reset Button for 5 seconds to restore "factory
// defaults".


#if BUILD_SUPPORT == MQTT_BUILD
void mqtt_startup(void)
{
  uint8_t i;
  char client_id_text[26]; // Client ID comprised of text
                           // "NetworkModule" (13 bytes) and
			   // MAC (12 bytes) and
			   // terminator (1 byte)
			   // for a total of 26 bytes.
  unsigned char topic_base[55]; // Used for building connect, subscribe,
                                // and publish topic strings.
				// Publish string content:
                                //  NetworkModule/DeviceName123456789/input/xx
                                //  NetworkModule/DeviceName123456789/output/xx
                                //  NetworkModule/DeviceName123456789/temp/xxxxxxxxxxxx
                                //  NetworkModule/DeviceName123456789/temp/BME280-0xxxx
                                //  NetworkModule/DeviceName123456789/state
                                //  NetworkModule/DeviceName123456789/state24
				//  NetworkModule/DeviceName123456789/state-req
				//  NetworkModule/DeviceName123456789/state-req24
				// Subscribe string content:
                                //  NetworkModule/DeviceName123456789/output/+/set
				//  NetworkModule/DeviceName123456789/state-req
				//  NetworkModule/DeviceName123456789/state-req24
				// Last Will string content:
				//  NetworkModule/DeviceName123456789/availability
				// Home Assistant config string content:
				//  homeassistant/switch/macaddressxx/xx/config
				//  homeassistant/binary_sensor/macaddressxx/xx/config
				//  homeassistant/sensor/macaddressxx/yyyyyyyyyyyy/config
				//  homeassistant/sensor/macaddressxx/BME280-0xxxx/config
				//  homeassistant/sensor/macaddressxx/BME280-1xxxx/config
				//  homeassistant/sensor/macaddressxx/BME280-2xxxx/config

  i = 0;
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
  // - Once the above is completed the Home Assistant Auto Discovery messages
  //   are published (if Home Assistnat Auto Discovery is enabled).

  switch(mqtt_start)
  {
  case MQTT_START_TCP_CONNECT:
    // When first powering up or on a reboot we need to initialize the MQTT
    // processes.
    //
    // The first step is to create a TCP Connection Request to the MQTT
    // Server. This is done with uip_connect(). uip_connect() doesn't
    // actually send anything - it just queues the SYN to be sent. The
    // connection request will actually be sent when uip_periodic is called.
    // uip_periodic will determine that the connection request is queued,
    // will perform an ARP request to determine the MAC of the MQTT server,
    // and will then send the SYN to start the connection process.
    //
    // This is the uip_connect() call when the code used the same MQTT port
    // number for the host port and the local port. This appeared to be
    // causing problems when reboots occurred, particularly if multiple
    // Reboot or Save calls were needed for MQTT settings.
    //    mqtt_conn = uip_connect(&uip_mqttserveraddr, Port_Mqttd, Port_Mqttd);
    
    // Following is a fix applied to perform a rotation through multiple
    // port numbers for the MQTT local port:
    // This is the only place that uip_connect() is called.
    // uip_connect(uip_ipaddr_t *ripaddr, uint16_t rport, uint16_t lport)
    // Here the local port is rotated with each boot to avoid the TIME_WAIT
    // process in the MQTT server that can delay a TCP reconnect by up to
    // 4 minutes (typically 2 minutes in Windows and 1 minute in Linux). This
    // rotation is transparent to users but important for Developers to be
    // aware of. The local MQTT port numbers are all from the IANA unreserved
    // range of ports. There could still be in a conflict in the network with
    // some other application using a selected port number. If that happens
    // an MQTT error should result (detected in mqtt_sanity_check()), which in
    // turn should cause a restart of the MQTT functions and selection of a
    // new alternate port.
    // The IANA non-reserved (aka Dynamic or Private) port rande is 49152 -
    // 65535. Any port in this range should be useable for this application,
    // but it may make some sense to select ports that have some distance
    // between them to avoid encountering some other application that utilizes
    // a cluster of ports. The selections made here are arbitraty and can be
    // changed in the future as needed.
    // Use the Rotation Pointer to select a local MQTT port.
    {
//      mqtt_local_port = 49193;
      switch (stored_options2 & 0x07)
      {
	case 0: mqtt_local_port = ALTERNATE_PORT00; break;
	case 1: mqtt_local_port = ALTERNATE_PORT01; break;
	case 2: mqtt_local_port = ALTERNATE_PORT02; break;
	case 3: mqtt_local_port = ALTERNATE_PORT03; break;
	case 4: mqtt_local_port = ALTERNATE_PORT04; break;
      }
      mqtt_conn = uip_connect(&uip_mqttserveraddr, Port_Mqttd, mqtt_local_port);
#if DEBUG_SUPPORT == 15
// UARTPrintf("mqtt_local_port = ");
// emb_itoa(mqtt_local_port, OctetArray, 10, 5);
// UARTPrintf(OctetArray);
// UARTPrintf("\r\n");
#endif // DEBUG_SUPPORT == 15
    }

    if (mqtt_conn != NULL) {
#if DEBUG_SUPPORT == 15
// UARTPrintf("Good mqtt_conn status\r\n");
#endif // DEBUG_SUPPORT == 15
      mqtt_start_ctr1 = 0; // Clear 50ms counter
      verify_count = 0; // Clear the ARP verify count
      mqtt_start_status = MQTT_START_CONNECTIONS_GOOD;
      mqtt_start = MQTT_START_VERIFY_ARP;
    }
    else {
      mqtt_start_status |= MQTT_START_CONNECTIONS_ERROR;
    }
    break;
      
  case MQTT_START_VERIFY_ARP:
    if (mqtt_start_ctr1 > 6) {
      // mqtt_start_ctr1 causes us to wait 300ms before checking to see if the
      // ARP request completed.
      mqtt_start_ctr1 = 0; // Clear 50ms counter
      verify_count++; // Increment the ARP verify count

      // ARP Request and TCP Connection request were sent to the MQTT Server
      // as a result of the uip_connect() in the prior step. Now we loop and
      // check that the ARP request was successful.
      if (check_mqtt_server_arp_entry()) {
        // ARP Reply received
        mqtt_start_ctr1 = 0; // Clear 50ms counter
	verify_count = 0;
        mqtt_start_status |= MQTT_START_ARP_REQUEST_GOOD;
        mqtt_start = MQTT_START_VERIFY_TCP;
#if DEBUG_SUPPORT == 15
// UARTPrintf("MQTT ARP Verified\r\n");
#endif // DEBUG_SUPPORT == 15
      }
      if (verify_count > 50) {
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
    if (mqtt_start_ctr1 > 6) {
      mqtt_start_ctr1 = 0; // Clear 50ms counter
      verify_count++; // Increment the TCP verify count every 300ms

      // Loop to make sure the TCP connection request was successful. We're
      // waiting for the SYNACK/ACK process to complete (checking each 300ms).
      // uip_periodic() runs frequently (each time the periodic_timer expires).
      // When uip_periodic() runs it calls the uip_process() to receive the
      // SYNACK and then send the ACK. We will know the ACK was sent when we
      // see the UIP_ESTABLISHED state for the mqtt connection.
      
      if ((mqtt_conn->tcpstateflags & UIP_TS_MASK) == UIP_ESTABLISHED) {
        mqtt_start_ctr1 = 0; // Clear 50ms counter
        mqtt_start_status |= MQTT_START_TCP_CONNECT_GOOD;
        mqtt_start = MQTT_START_MQTT_INIT;
#if DEBUG_SUPPORT == 15
// UARTPrintf("MQTT TCP Verified\r\n");
#endif // DEBUG_SUPPORT == 15
      }
      if (verify_count > 166) { // 50 seconds.
        // This needs to be longer than the RTO timeout in the uip.c code
	// which is initially 3 seconds but can gradually increase to 48
	// seconds before a connection abort occurs.
        // If the connection does not complete we probably have a network
	// problem.  Try again with a new uip_connect().
        mqtt_start = MQTT_START_TCP_CONNECT;
        // Clear the error indicator flags
        mqtt_start_status = MQTT_START_NOT_STARTED;
      }
    }
    break;


#if HOME_ASSISTANT_SUPPORT == 1
  case MQTT_START_MQTT_INIT:
    if (mqtt_start_ctr1 > 4) {
      // Initialize mqtt client
      mqtt_init(&mqttclient,
                mqtt_sendbuf,
                sizeof(mqtt_sendbuf),
                &uip_buf[MQTT_PBUF],
		MQTT_PBUF_SIZE,
                publish_callback);
      mqtt_start_ctr1 = 0; // Clear 50ms counter
      mqtt_start = MQTT_START_QUEUE_CONNECT;
    }
    break;
#endif // HOME_ASSISTANT_SUPPORT == 1


#if DOMOTICZ_SUPPORT == 1
  case MQTT_START_MQTT_INIT:
    if (mqtt_start_ctr1 > 4) {
      // Initialize mqtt client
      mqtt_init(&mqttclient,
                mqtt_sendbuf,
                sizeof(mqtt_sendbuf),
                &uip_buf[UIP_IPTCPH_LEN + UIP_LLH_LEN],
                UIP_APPDATA_SIZE,
                publish_callback);
      mqtt_start_ctr1 = 0; // Clear 50ms counter
      mqtt_start = MQTT_START_QUEUE_CONNECT;
#if DEBUG_SUPPORT == 15
// UARTPrintf("\r\n");
// UARTPrintf("Sent mqtt_init\r\n");
#endif // DEBUG_SUPPORT == 15
    }
    break;
#endif // DOMOTICZ_SUPPORT == 1


  case MQTT_START_QUEUE_CONNECT:
    if (mqtt_start_ctr1 > 4) {
      // ARP Reply received from the MQTT Server and TCP Connection
      // established.
      // We should now be able to message the MQTT Broker, but will wait
      // 200ms to give some start time.

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

      // When a CONNECT is sent to the broker it should respond with a
      // CONNACK.
      connack_received = 0;
      
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
     
      mqtt_start_ctr1 = 0; // Clear 50ms counter
      mqtt_start = MQTT_START_VERIFY_CONNACK;
#if DEBUG_SUPPORT == 15
// UARTPrintf("\r\n");
// UARTPrintf("Sent mqtt_connect\r\n");
#endif // DEBUG_SUPPORT == 15
    }
    break;

  case MQTT_START_VERIFY_CONNACK:
    // Verify that the CONNECT CONNACK was received.
    // When a CONNECT is sent to the broker it should respond with a CONNACK.
    // The CONNACK will occur very quickly but we will allow up to 10 seconds
    // before assuming an error has occurred.
    // A workaround is implemented with the global variable connack_received so
    // that the mqtt.c code can tell the main.c code that the CONNECT CONNACK
    // was received.

    if (mqtt_start_ctr1 < 200) {
      // Allow up to 10 seconds for CONNACK
      if (connack_received) {
        mqtt_start_ctr1 = 0; // Clear 50ms counter
        mqtt_start_status |= MQTT_START_MQTT_CONNECT_GOOD;
        mqtt_start = MQTT_START_QUEUE_SUBSCRIBE1;
#if DEBUG_SUPPORT == 15
// UARTPrintf("\r\n");
// UARTPrintf("connack_received\r\n");
#endif // DEBUG_SUPPORT == 15
      }
    }
    else {
      mqtt_start = MQTT_START_TCP_CONNECT;
      // Clear the error indicator flags
      mqtt_start_status = MQTT_START_NOT_STARTED;
    }
    break;


#if HOME_ASSISTANT_SUPPORT == 1
  case MQTT_START_QUEUE_SUBSCRIBE1:
  case MQTT_START_QUEUE_SUBSCRIBE2:
  case MQTT_START_QUEUE_SUBSCRIBE3:
    if (mqtt_start_ctr1 > 4) {
      // Queue the mqtt_subscribe messages for transmission to the MQTT
      // Broker.
      // Wait 200ms before queueing first Subscribe msg.
      //
      // The mqtt_subscribe function will create the message and put it in
      // the mqtt_sendbuf queue. uip_periodic() will start the process that
      // will call mqtt_sync to transfer the message from the mqtt_sendbuf
      // to the uip_buf.
      //
      // Note: Timing is managed here to prevent placing multiple SUBSCRIBE
      // messages in the mqtt_sendbuf as that buffer is very small.
      //
      // SUBSCRIBE is run three times:
      //   case MQTT_START_QUEUE_SUBSCRIBE1:
      //   Subscribe to the output control messages
      //
      //   case MQTT_START_QUEUE_SUBSCRIBE2:
      //   Subscribe to the state-req messages
      //
      //   case MQTT_START_QUEUE_SUBSCRIBE3:
      //   Subscribe to the state-req24 messages
      //
	
      suback_received = 0;
      strcpy(topic_base, devicetype);
      strcat(topic_base, stored_devicename);
      
      if (mqtt_start == MQTT_START_QUEUE_SUBSCRIBE1) strcat(topic_base, "/output/+/set");
      if (mqtt_start == MQTT_START_QUEUE_SUBSCRIBE2) strcat(topic_base, "/state-req");
      if (mqtt_start == MQTT_START_QUEUE_SUBSCRIBE3) strcat(topic_base, "/state-req24");
      
      // In the mqtt_subscribe call the maximum QOS level spedified (0 in this
      // case) is the max QOS level supported for the topic messages being
      // subcribed to. The SUBSCRIBE itself has no QOS level as a special
      // SUBACK message must be returned to verify the SUBSCRIBE transaction.
      mqtt_subscribe(&mqttclient, topic_base, 0);
      mqtt_start_ctr1 = 0; // Clear 50ms counter
      
      if (mqtt_start == MQTT_START_QUEUE_SUBSCRIBE1) mqtt_start = MQTT_START_VERIFY_SUBSCRIBE1;
      if (mqtt_start == MQTT_START_QUEUE_SUBSCRIBE2) mqtt_start = MQTT_START_VERIFY_SUBSCRIBE2;
      if (mqtt_start == MQTT_START_QUEUE_SUBSCRIBE3) mqtt_start = MQTT_START_VERIFY_SUBSCRIBE3;
    }
    break;


  case MQTT_START_VERIFY_SUBSCRIBE1:
  case MQTT_START_VERIFY_SUBSCRIBE2:
  case MQTT_START_VERIFY_SUBSCRIBE3:
    // Verify that the SUBSCRIBE SUBACK was received.
    // When a SUBSCRIBE is sent to the broker it should respond with a SUBACK.
    // The SUBACK will occur very quickly but we will allow up to 10 seconds
    // before assuming an error has occurred.
    // A workaround is implemented with the global variable suback_received so
    // that the mqtt.c code can tell the main.c code that the SUBSCRIBE SUBACK
    // was received.
    //
    // VERIFY_SUBSCRIBE is run three times

    if (mqtt_start_ctr1 < 200) {
      // Allow up to 10 seconds for SUBACK
      if (suback_received == 1) {
        mqtt_start_ctr1 = 0; // Clear 50ms counter
        if (mqtt_start == MQTT_START_VERIFY_SUBSCRIBE1) mqtt_start = MQTT_START_QUEUE_SUBSCRIBE2;
        if (mqtt_start == MQTT_START_VERIFY_SUBSCRIBE2) mqtt_start = MQTT_START_QUEUE_SUBSCRIBE3;
        if (mqtt_start == MQTT_START_VERIFY_SUBSCRIBE3) {
          if (stored_config_settings & 0x02) {
            // Home Assistant Auto Discovery enabled
            mqtt_start = MQTT_START_QUEUE_PUBLISH_AUTO;
            auto_discovery = DEFINE_INPUTS;
            auto_discovery_step = SEND_OUTPUT_DELETE;
            pin_ptr = 1;
            sensor_number = 0;
          }
          else {
            mqtt_start_ctr1 = 0; // Clear 50ms counter
            mqtt_start = MQTT_START_QUEUE_PUBLISH_ON;
          }
	}
      }
    }
    else {
      mqtt_start = MQTT_START_TCP_CONNECT;
      // Clear the error indicator flags
      mqtt_start_status = MQTT_START_NOT_STARTED; 
    }
    break;
#endif // HOME_ASSISTANT_SUPPORT == 1


#if DOMOTICZ_SUPPORT == 1
  case MQTT_START_QUEUE_SUBSCRIBE1:
    if (mqtt_start_ctr1 > 4) {
      // Queue the mqtt_subscribe messages for transmission to the MQTT
      // Broker.
      // Wait 200ms before queueing first Subscribe msg.
      //
      // The mqtt_subscribe function will create the message and put it in
      // the mqtt_sendbuf queue. uip_periodic() will start the process that
      // will call mqtt_sync to transfer the message from the mqtt_sendbuf
      // to the uip_buf.
      //
      // Note: Timing is managed here to prevent placing multiple SUBSCRIBE
      // messages in the mqtt_sendbuf as that buffer is very small.
      //
      // SUBSCRIBE is run two times:
      //   case MQTT_START_QUEUE_SUBSCRIBE1:
      //   Subscribe to the domoticz/in topic
      //
      //   case MQTT_START_QUEUE_SUBSCRIBE2:
      //   Subscribe to the domoticz/out topic
      //
	
      suback_received = 0;
      
      if (mqtt_start == MQTT_START_QUEUE_SUBSCRIBE1) {
        strcpy(topic_base, "domoticz/out");
#if DEBUG_SUPPORT == 15
// UARTPrintf("\r\n");
// UARTPrintf("MQTT_START_QUEUE_SUBSCRIBE1\r\n");
#endif // DEBUG_SUPPORT == 15
      }
#if DEBUG_SUPPORT == 15
// UARTPrintf("\r\n");
// UARTPrintf("MQTT_START_QUEUE_SUBSCRIBE2\r\n");
#endif // DEBUG_SUPPORT == 15
      
      // In the mqtt_subscribe call the maximum QOS level spedified (0 in this
      // case) is the max QOS level supported for the topic messages being
      // subcribed to. The SUBSCRIBE itself has no QOS level as a special
      // SUBACK message must be returned to verify the SUBSCRIBE transaction.
      mqtt_subscribe(&mqttclient, topic_base, 0);
      mqtt_start_ctr1 = 0; // Clear 50ms counter
      
      if (mqtt_start == MQTT_START_QUEUE_SUBSCRIBE1) mqtt_start = MQTT_START_VERIFY_SUBSCRIBE1;
    }
    break;


  case MQTT_START_VERIFY_SUBSCRIBE1:
    // Verify that the SUBSCRIBE SUBACK was received.
    // When a SUBSCRIBE is sent to the broker it should respond with a SUBACK.
    // The SUBACK will occur very quickly but we will allow up to 10 seconds
    // before assuming an error has occurred.
    // A workaround is implemented with the global variable suback_received so
    // that the mqtt.c code can tell the main.c code that the SUBSCRIBE SUBACK
    // was received.
    //
    // VERIFY_SUBSCRIBE is run two times

    if (mqtt_start_ctr1 < 200) {
      // Allow up to 10 seconds for SUBACK
      if (suback_received == 1) {
        mqtt_start_ctr1 = 0; // Clear 50ms counter
        if (mqtt_start == MQTT_START_VERIFY_SUBSCRIBE1) {
#if DEBUG_SUPPORT == 15
// UARTPrintf("\r\n");
// UARTPrintf("SUBSCRIBE1 suback received\r\n");
#endif // DEBUG_SUPPORT == 15
          mqtt_start = MQTT_START_QUEUE_PUBLISH_ON;
	}
#if DEBUG_SUPPORT == 15
// UARTPrintf("\r\n");
// UARTPrintf("SUBSCRIBE2 suback received\r\n");
#endif // DEBUG_SUPPORT == 15
      }
    }
    else {
      mqtt_start = MQTT_START_TCP_CONNECT;
      // Clear the error indicator flags
      mqtt_start_status = MQTT_START_NOT_STARTED; 
    }
    break;
#endif // DOMOTICZ_SUPPORT == 1


#if HOME_ASSISTANT_SUPPORT == 1
  case MQTT_START_QUEUE_PUBLISH_AUTO:
    if (mqtt_start_ctr1 > 2) {
      // Publish Home Assistant Auto Discovery messages
      // This part of the state machine runs only if Home Assistant Auto
      // Discovery is enabled.
      // This step of the state machine is executed every 100 to 200 ms and is
      // entered multiple times until all Home Assistant Auto Discovery
      // Config PUBLISH messages are sent.
      //
      //---------------------------------------------------------------------//
      // This function will create a "placeholder" PUBLISH message. The
      // required PUBLISH messages are too large to fit in the mqtt_sendbuf
      // so a placeholder message is created instead. The placeholder message
      // contains special markers that need to be replaced later with more
      // extensive text fields that are required in the actual Publish
      // message. The mqtt_pal.c function will detect the placeholder Publish
      // message during the "copy to uip_buf" process and will replace the
      // special markers "on the fly" to create the actual PUBLISH message
      // required by Home Assistant.
      //
      // These messages are always PUBLISHed with QOS 0
      //
      // The following placeholder Publish message will create an Output Auto
      // Discovery message. "xx" is the output IO number.
      //    mqtt_publish(&mqttclient,
      //                 topic_base,
      //                 "%Oxx",
      //                 4,
      //                 MQTT_PUBLISH_QOS_0 | MQTT_PUBLISH_RETAIN);
      //
      // The following placeholder Publish message will create an Input Auto
      // Discovery message. "xx" is the input IO number.
      //    mqtt_publish(&mqttclient,
      //                 topic_base,
      //                 "%Ixx",
      //                 4,
      //                 MQTT_PUBLISH_QOS_0 | MQTT_PUBLISH_RETAIN);
      //
      // The following placeholder Publish message will create a DS18B20
      // Temperature Sensor Auto Discovery message. "xx" is the sensor number
      // 0 to 4.
      //    mqtt_publish(&mqttclient,
      //                 topic_base,
      //                 "%Txx",
      //                 4,
      //                 MQTT_PUBLISH_QOS_0 | MQTT_PUBLISH_RETAIN);
      //
      // The following placeholder Publish message will create a BME280
      // Temperature Sensor Auto Discovery message.
      //    mqtt_publish(&mqttclient,
      //                 topic_base,
      //                 "%T00",
      //                 4,
      //                 MQTT_PUBLISH_QOS_0 | MQTT_PUBLISH_RETAIN);
      //
      // The following placeholder Publish message will create a BME280
      // Pressure Sensor Auto Discovery message.
      //    mqtt_publish(&mqttclient,
      //                 topic_base,
      //                 "%T01",
      //                 4,
      //                 MQTT_PUBLISH_QOS_0 | MQTT_PUBLISH_RETAIN);
      //
      // The following placeholder Publish message will create a BME280
      // Humidity Sensor Auto Discovery message.
      //    mqtt_publish(&mqttclient,
      //                 topic_base,
      //                 "%T02",
      //                 4,
      //                 MQTT_PUBLISH_QOS_0 | MQTT_PUBLISH_RETAIN);
      //---------------------------------------------------------------------//

      // This part of the state machine will walk through the pin_control
      // bytes and send an Auto Discovery Publish message for every pin as
      // follows:
      //
      //   Each pin, indexed by variable "pin_ptr", is examined 3 times (once
      //   per call of this function).
      //
      //   For every pin that is an Enabled Input:
      //     - An Output Config message is sent with an empty payload (to make
      //       sure any prior Output definition is deleted in Home Assistant).
      //     - An Input Config message is sent with a definition payload.
      //
      //   For every pin that is an Enabled Output:
      //     - An Input Config message is sent with an empty payload (to make
      //       sure any prior Input definition is deleted in Home Assistant).
      //     - An Output Config message is sent with a defining payload.
      //
      //   For every pin that is Disabled:
      //     - An Input Config message is sent with an empty payload (to make
      //       sure any prior Input definition is deleted in Home Assistant).
      //     - An Output Config message is sent with an empty payload (to make
      //       sure any prior Output definition is deleted in Home Assistant).
      //
      //   If DS18B20 is enabled:
      //     - A Temperature Sensor Config message is sent for every sensor
      //       that is discovered.
      //
      //   If BME280 is enabled:
      //     - A Temperature Sensor Config message is sent if the sensor is
      //       present.
      //     - A Pressure Sensor Config message is sent if the sensor is
      //       present.
      //     - A Humidity Sensor Config message is sent if the sensor is
      //       present.

      if (auto_discovery == DEFINE_INPUTS) {
        i = (uint8_t)(pin_ptr - 1);
#if LINKED_SUPPORT == 0
        if ((pin_control[i] & 0x03) == 0x01) {
#endif // LINKED_SUPPORT == 0
#if LINKED_SUPPORT == 1
        if (chk_iotype(pin_control[i], i, 0x03) == 0x01) {
#endif // LINKED_SUPPORT == 1
	  // Pin is an Enabled Input pin
	  if (auto_discovery_step == SEND_OUTPUT_DELETE) {
            // Create Output pin delete msg.
            send_IOT_msg(pin_ptr, OUTPUTMSG, DELETE_IOT);
	    auto_discovery_step = SEND_INPUT_DEFINE;
	  }
	  
	  else if (auto_discovery_step == SEND_INPUT_DEFINE) {
            // Create Input pin define msg.
            send_IOT_msg(pin_ptr, INPUTMSG, DEFINE_IOT);
	    
#if PCF8574_SUPPORT == 0
	    if (pin_ptr == 16) {
#endif // PCF8574_SUPPORT == 0
#if PCF8574_SUPPORT == 1
            // if no PCF8574 exit the loop when pin_ptr == 16
	    // if PCF8574 is present exit the loop when pin_ptr ==24
	    if ((((stored_options1 & 0x08) == 0x00) && (pin_ptr == 16))
	     || (((stored_options1 & 0x08) == 0x08) && (pin_ptr == 24))) {
#endif // PCF8574_SUPPORT == 1
	      pin_ptr = 1;
              auto_discovery = DEFINE_OUTPUTS;
              auto_discovery_step = SEND_INPUT_DELETE;
	    }
	    else {
	      pin_ptr++;
	      auto_discovery_step = SEND_OUTPUT_DELETE;
	    }
	  }
	}
        else {
#if PCF8574_SUPPORT == 0
	  if (pin_ptr == 16) {
#endif // PCF8574_SUPPORT == 0
#if PCF8574_SUPPORT == 1
          // if no PCF8574 exit the loop when pin_ptr == 16
	  // if PCF8574 is present exit the loop when pin_ptr ==24
	  if ((((stored_options1 & 0x08) == 0x00) && (pin_ptr == 16))
	   || (((stored_options1 & 0x08) == 0x08) && (pin_ptr == 24))) {
#endif // PCF8574_SUPPORT == 1
	    pin_ptr = 1;
            auto_discovery = DEFINE_OUTPUTS;
            auto_discovery_step = SEND_INPUT_DELETE;
	  }
	  else pin_ptr++;
	}
      }
	
      else if (auto_discovery == DEFINE_OUTPUTS) {
        i = (uint8_t)(pin_ptr - 1);
#if LINKED_SUPPORT == 0
        if ((pin_control[i] & 0x03) == 0x03) {
#endif // LINKED_SUPPORT == 0
#if LINKED_SUPPORT == 1
        if (chk_iotype(pin_control[i], i, 0x03) == 0x03) {
#endif // LINKED_SUPPORT == 1
	  // Pin is an Enabled Output pin
	  if (auto_discovery_step == SEND_INPUT_DELETE) {
            // Create Input pin delete msg.
            send_IOT_msg(pin_ptr, INPUTMSG, DELETE_IOT);
	    auto_discovery_step = SEND_OUTPUT_DEFINE;
	  }
	  
	  else if (auto_discovery_step == SEND_OUTPUT_DEFINE) {
            // Create Output pin define msg.
            send_IOT_msg(pin_ptr, OUTPUTMSG, DEFINE_IOT);
	    
#if PCF8574_SUPPORT == 0
	    if (pin_ptr == 16) {
#endif // PCF8574_SUPPORT == 0
#if PCF8574_SUPPORT == 1
            // if no PCF8574 exit the loop when pin_ptr == 16
	    // if PCF8574 is present exit the loop when pin_ptr == 24
	    if ((((stored_options1 & 0x08) == 0x00) && (pin_ptr == 16))
	     || (((stored_options1 & 0x08) == 0x08) && (pin_ptr == 24))) {
#endif // PCF8574_SUPPORT == 1
	      pin_ptr = 1;
              auto_discovery = DEFINE_DISABLED;
              auto_discovery_step = SEND_INPUT_DELETE;
	    }
	    else pin_ptr++;
            auto_discovery_step = SEND_INPUT_DELETE;
	  }
	}
        else {
#if PCF8574_SUPPORT == 0
	  if (pin_ptr == 16) {
#endif // PCF8574_SUPPORT == 0
#if PCF8574_SUPPORT == 1
          // if no PCF8574 exit the loop when pin_ptr == 16
	  // if PCF8574 is present exit the loop when pin_ptr ==24
	  if ((((stored_options1 & 0x08) == 0x00) && (pin_ptr == 16))
	   || (((stored_options1 & 0x08) == 0x08) && (pin_ptr == 24))) {
#endif // PCF8574_SUPPORT == 1
	    pin_ptr = 1;
            auto_discovery = DEFINE_DISABLED;
            auto_discovery_step = SEND_INPUT_DELETE;
	  }
	  else pin_ptr++;
	}
      }
 
      else if (auto_discovery == DEFINE_DISABLED) {
        if ((pin_control[pin_ptr - 1] & 0x03) == 0x00) {
	  // Pin is Disabled
#if DEBUG_SUPPORT == 15
// UARTPrintf("DEFINE_DISABLED - pin is disabled - pin = ");
// emb_itoa(pin_ptr, OctetArray, 10, 2);
// UARTPrintf(OctetArray);
// UARTPrintf("   stored_options1 = ");
// emb_itoa(stored_options1, OctetArray, 16, 2);
// UARTPrintf(OctetArray);
// UARTPrintf("\r\n");
#endif // DEBUG_SUPPORT == 15
	  if (auto_discovery_step == SEND_INPUT_DELETE) {
            // Create Input pin delete msg.
            send_IOT_msg(pin_ptr, INPUTMSG, DELETE_IOT);
	    auto_discovery_step = SEND_OUTPUT_DELETE;
	  }
	  
	  else if (auto_discovery_step == SEND_OUTPUT_DELETE) {
            // Create Output pin delete msg.
            send_IOT_msg(pin_ptr, OUTPUTMSG, DELETE_IOT);

#if PCF8574_SUPPORT == 0
	    if (pin_ptr == 16) {
#endif // PCF8574_SUPPORT == 0
#if PCF8574_SUPPORT == 1
            // A special case is needed here when the user requests that
	    // PCF8574 pins be deleted during Home Assistant Auto
	    // Discovery. If PCF8574 hardware was being used but then is
	    // removed the code will think it is a 16 pin system, and since
	    // the firmware has no memory that a PCF8547 ever existed it
	    // does not send pin delete messages for the now missing PCF8574.
	    // The user may want it to work that way because the user might
	    // be planning to reconnect the PCF8574. Howerver, if the user
	    // does not plan to reconnect the PCF8574 they can use the URL
	    // /85 command to force the code to send pin delete messages to
	    // Home Assistant to clean up the HA GUI. If the user uses the
	    // URL /85 command bit 0x20 in stored_options1 will be set and a
	    // reboot is executed. If the code below finds the bit set it will
	    // cause the delete messages to be generated, then the bit is
	    // cleared.
	    
            // if no PCF8574 exit the loop when pin_ptr == 16
	    // if PCF8574 is present exit the loop when pin_ptr ==24
	    // if the "force PCF8574 pin disable" bit is set exit the loop
	    //   when pin_ptr == 24
	    if ((((stored_options1 & 0x28) == 0x00) && (pin_ptr == 16))
	     || (((stored_options1 & 0x08) == 0x08) && (pin_ptr == 24))
	     || (((stored_options1 & 0x20) == 0x20) && (pin_ptr == 24))) {
#endif // PCF8574_SUPPORT == 1
              auto_discovery = DEFINE_TEMP_SENSORS;
	    }
	    else {
	      pin_ptr++;
	      auto_discovery_step = SEND_INPUT_DELETE;
	    }
	  }
	}
        else {
#if PCF8574_SUPPORT == 0
	  if (pin_ptr == 16) {
#endif // PCF8574_SUPPORT == 0
#if PCF8574_SUPPORT == 1
          // if no PCF8574 exit the loop when pin_ptr == 16
	  // if PCF8574 is present exit the loop when pin_ptr ==24
	  // if the "force PCF8574 pin disable" bit is set exit the loop when
	  //   pin_ptr == 24
	  if ((((stored_options1 & 0x28) == 0x00) && (pin_ptr == 16))
	   || (((stored_options1 & 0x08) == 0x08) && (pin_ptr == 24))
	   || (((stored_options1 & 0x20) == 0x20) && (pin_ptr == 24))) {
#endif // PCF8574_SUPPORT == 1
	    auto_discovery = DEFINE_TEMP_SENSORS;
	  }
	  else pin_ptr++;
	}
      }

      else if (auto_discovery == DEFINE_TEMP_SENSORS) {
#if DS18B20_SUPPORT == 1
        define_temp_sensors();    // define_temp_sensors will be called
	                          // repeatedly until all temp sensors are
				  // defined. define_temp_sensors will set
				  // auto_discovery = AUTO_COMPLETE when
	                          // all temp sensors are defined.
#endif // DS18B20_SUPPORT == 1
#if BME280_SUPPORT == 1
        define_BME280_sensors();  // define_BME280_sensors will be called
	                          // repeatedly until all BME260 sensors
				  // (Temp, Humidity, Pressure) are defined.
				  // define_BME280_sensors will set
				  // auto_discovery = AUTO_COMPLETE when
	                          // all BME280 sensors are defined.
#endif // BME280_SUPPORT == 1
      }

      mqtt_start_ctr1 = 0; // Clear the 50ms counter
      if (auto_discovery == AUTO_COMPLETE) {
        uint8_t j;
        auto_discovery_step = STEP_NULL;
        mqtt_start = MQTT_START_QUEUE_PUBLISH_ON;
	// Clear the PCF8574 "force pin delete" indicator if it is set
	if ((stored_options1 & 0x20) == 0x20) {
	  j = stored_options1;
	  j &= 0xdf; // 11011111
          update_settings_options(UPDATE_OPTIONS1, j);
	}
      }
    }
    break;
#endif // HOME_ASSISTANT_SUPPORT == 1


#if HOME_ASSISTANT_SUPPORT == 1
  case MQTT_START_QUEUE_PUBLISH_ON:
    if (mqtt_start_ctr1 > 4) {
      // Wait 200ms before queuing the "availability online" PUBLISH message.
      // This message is always published with QOS 0.
      strcpy(topic_base, devicetype);
      strcat(topic_base, stored_devicename);
      strcat(topic_base, "/availability");
      mqtt_publish(&mqttclient,
                   topic_base,
                   "online",
                   6,
                   MQTT_PUBLISH_QOS_0 | MQTT_PUBLISH_RETAIN);
      // Indicate succesful completion
      mqtt_start_ctr1 = 0; // Clear the 50ms counter
      mqtt_start = MQTT_START_QUEUE_PUBLISH_PINS;
    }
    break;
#endif // HOME_ASSISTANT_SUPPORT == 1


#if DOMOTICZ_SUPPORT == 1
  case MQTT_START_QUEUE_PUBLISH_ON:
    // Domoticz environments do not use the "availability" function, so bypass
    // that step - just go on to MQTT_START_QUEUE_PUBLISH_PINS
    mqtt_start_ctr1 = 0; // Clear the 50ms counter
    mqtt_start = MQTT_START_QUEUE_PUBLISH_PINS;
    break;
#endif // DOMOTICZ_SUPPORT == 1


  case MQTT_START_QUEUE_PUBLISH_PINS:
    if (mqtt_start_ctr1 > 4) {
      // Wait 200ms before starting
      // Publish the state of all pins one at a time.
      // This is accomplished by setting ON_OFF_word_sent to the inverse of
      // whatever is currently in ON_OFF_word. This will cause the normal
      // checks for pin state changes to trigger a transmit for every pin.
#if PCF8574_SUPPORT == 0 && DOMOTICZ_SUPPORT == 0
      ON_OFF_word_sent = (uint16_t)(~ON_OFF_word);
#endif // PCF8574_SUPPORT == 0 && DOMOTICZ_SUPPORT == 0
#if PCF8574_SUPPORT == 1 || DOMOTICZ_SUPPORT == 1
      ON_OFF_word_sent = (uint32_t)(~ON_OFF_word);
#endif // PCF8574_SUPPORT == 1 || DOMOTICZ_SUPPORT == 1
      // Indicate succesful completion
#if DEBUG_SUPPORT == 15
// UARTPrintf("MQTT Startup Complete\r\n");
#endif // DEBUG_SUPPORT == 15
      mqtt_start = MQTT_START_COMPLETE;
    }
    break;
  } // end switch
}
#endif // BUILD_SUPPORT == MQTT_BUILD


#if BUILD_SUPPORT == MQTT_BUILD && HOME_ASSISTANT_SUPPORT == 1
#if DS18B20_SUPPORT == 1
void define_temp_sensors(void)
{
  // This function is called from the mqtt_startup function when
  //   auto_discovery == DEFINE_TEMP_SENSORS
  // This function is applicable only to Home Assistant Auto Discovery.
  // This function is part of the state machine contained within the
  // mqtt_startup and will manipulate the following state machine controls:
  //   auto_discovery_step = SEND_TEMP_SENSOR_DEFINE  
  // When complete this function will set
  //   auto_discovery = AUTO_COMPLETE
  //
  // Pin 16 will be disabled already if it is being used for temperature
  // sensors.
  //
  // If temp sensors are enabled, this routine will send a define msg for
  // every sensor appearing in the FoundROM table.  Note that the
  // send_IOT_msg() routine which is called from this routine will abort
  // sending a msg if the Temperature Sensor ID is 000000000000 (which
  // indicates no sensor is present at that numROMs pointer).
  
  // Create temperature sensor define msg.
  // If temp sensors are not enabled we will not create a Config message.
  // If no sensors were detected numROMs will be -1 and we will not create
  // a Config message).
  // If there is at least one sensor detetected numROMs will be zero or
  // greater. In that case send the sensor definition as a Config message.

  if (stored_config_settings & 0x08) {
    if (sensor_number <= (numROMs)) {
      // If the test is true Temperature Sensors are enabled and a sensor is
      // defined.
      // Send Temp Sensor define messages.
      send_IOT_msg(sensor_number, TMPRMSG, DEFINE_IOT);
    }
  }
  else sensor_number = 4;
      
  if (sensor_number == 4) {
    auto_discovery = AUTO_COMPLETE;
  }
  else sensor_number++;
}
#endif // DS18B20_SUPPORT == 1
#endif // BUILD_SUPPORT == MQTT_BUILD && HOME_ASSISTANT_SUPPORT == 1


#if BUILD_SUPPORT == MQTT_BUILD && HOME_ASSISTANT_SUPPORT == 1
#if BME280_SUPPORT == 1
void define_BME280_sensors(void)
{
  // This function is called from the mqtt_startup function when
  //   auto_discovery == DEFINE_BME280_SENSORS
  // This function is applicable only to Home Assistant Auto Discovery.
  // This function is part of the state machine contained within mqtt_startup
  // and will manipulate the following state machine controls:
  //   auto_discovery_step = SEND_TEMP_SENSOR_DEFINE  
  // When complete this function will set
  //   auto_discovery = AUTO_COMPLETE
  //
  // Unlike the DS18B20 sensors (which are connected to IO Pin 16), the BME280
  // sensors are connected via I2C. The BME280 sensor provides a temperature,
  // pressure, and humidity value.
  //
  // If BME280 sensors are enabled, this routine will send a separate define
  // msg for the temperature, pressure, and humidity sensor in the BME280.
  // Note that the send_IOT_msg() routine which is called from this routine
  // will abort sending a msg if the Sensor ID is 000000 (which indicates no
  // sensor is present).
  
  // Create temperature sensor define msg.
  // If temp sensors are not enabled we will not create a Config message.
  // If no sensors were detected numROMs will be -1 and we will not create
  // a Config message).
  // If there is at least one sensor detetected numROMs will be zero or
  // greater. In that case send the sensor definition as a Config message.

  if ((stored_config_settings & 0x20) == 0x20) {
    if (BME280_found == 1) {
      // If the test is true BME280 Sensors are enabled and a sensor is present.
      if (sensor_number == 0) {
        // Send BME280 Temp Sensor define message.
        send_IOT_msg(sensor_number, TMPRMSG, DEFINE_IOT);
      }
      if (sensor_number == 1) {
        // Send BME280 Pressure Sensor define message.
        send_IOT_msg(sensor_number, PRESMSG, DEFINE_IOT);
      }
      if (sensor_number == 2) {
        // Send BME280 Humidity Sensor define message.
        send_IOT_msg(sensor_number, HUMMSG, DEFINE_IOT);
      }
    }
    else sensor_number = 2;
  }
  if (sensor_number == 2) {
    auto_discovery = AUTO_COMPLETE;
  }
  else sensor_number++;
}
#endif // BME280_SUPPORT == 1
#endif // BUILD_SUPPORT == MQTT_BUILD && HOME_ASSISTANT_SUPPORT == 1


#if BUILD_SUPPORT == MQTT_BUILD && HOME_ASSISTANT_SUPPORT == 1
void send_IOT_msg(uint8_t IOT_ptr, uint8_t IOT, uint8_t DefOrDel)
{
  // Format and send IO delete/define messages and sensor delete/define
  // messages.
  // This function is applicable only to Home Assistant Auto Discovery.
  // For IOT == INPUTMSG or OUTPUTMSG the IOT_ptr indicates the pin number
  //   (1 to 16) that is being messaged.
  // For IOT == TMPRMSG the IOT_PTR indicates the sensor number (0 to 4) that
  //   is being messaged.
  unsigned char app_message[16]; // Stores the application message (the
                                 // payload) that will be sent in an MQTT
				 // message.
				 // For Input or Output IO messages
				 //   app_message[2] to [5] contains the pin
				 //   number allowing app_message to be used
				 //   in creating the topic part of the
				 //   message
				 // For Temperature Sensor messages
				 //   app_message[2] to [14] contains the
				 //   sensor ID allowing app_message to be
				 //   used in creating the topic part of the
				 //   message.
  unsigned char topic_base[55]; // Used for building connect, subscribe,
                                // and publish topic strings.
				// Publish string content:
                                //  NetworkModule/DeviceName123456789/input/xx
                                //  NetworkModule/DeviceName123456789/output/xx
                                //  NetworkModule/DeviceName123456789/temp/xxxxxxxxxxxx
                                //  NetworkModule/DeviceName123456789/temp/BME280-0xxxx
                                //  NetworkModule/DeviceName123456789/state
                                //  NetworkModule/DeviceName123456789/state24
				//  NetworkModule/DeviceName123456789/state-req
				//  NetworkModule/DeviceName123456789/state-req24
				// Subscribe string content:
                                //  NetworkModule/DeviceName123456789/output/+/set
				//  NetworkModule/DeviceName123456789/state-req
				//  NetworkModule/DeviceName123456789/state-req24
				// Last Will string content:
				//  NetworkModule/DeviceName123456789/availability
				// Home Assistant config string content:
				//  homeassistant/switch/macaddressxx/xx/config
				//  homeassistant/binary_sensor/macaddressxx/xx/config
				//  homeassistant/sensor/macaddressxx/yyyyyyyyyyyy/config
				//  homeassistant/sensor/macaddressxx/BME280-0xxxx/config
				//  homeassistant/sensor/macaddressxx/BME280-1xxxx/config
				//  homeassistant/sensor/macaddressxx/BME280-2xxxx/config


#if OB_EEPROM_SUPPORT == 1 && DS18B20_SUPPORT == 1
  // If I2C EEPROM is supported the FoundROM[][] table is located in I2C
  // EEPROM. In this case a stack based FoundROM[][] array is created and the
  // data is copied to that array.
  uint8_t FoundROM[5][8];           // Table of ROM codes
                                    // [x][0] = Family Code
                                    // [x][1] = LSByte serial number
                                    // [x][2] = byte 2 serial number
                                    // [x][3] = byte 3 serial number
                                    // [x][4] = byte 4 serial number
                                    // [x][5] = byte 5 serial number
                                    // [x][6] = MSByte serial number
                                    // [x][7] = CRC
#endif // OB_EEPROM_SUPPORT == 1 && DS18B20_SUPPORT == 1

      
#if OB_EEPROM_SUPPORT == 1 && DS18B20_SUPPORT == 1
  // If I2C EEPROM is supported the FoundROM[][] array is stored in the I2C
  // EEPROM and must be copied to a stack based FoundROM[][] array for use
  // here. The I2C EEPROM copy of the FoundROM table starts at
  // I2C_EEPROM_R1_FOUNDROM. There are 5 entries, each 8 bytes long, for a
  // total of 40 bytes.
  copy_I2C_EEPROM_bytes_to_RAM(&FoundROM[0][0], 40, I2C_EEPROM_R1_WRITE, I2C_EEPROM_R1_READ, I2C_EEPROM_R1_FOUNDROM, 2);
#endif // OB_EEPROM_SUPPORT == 1 && DS18B20_SUPPORT == 1

  // Create the % marker in the payload template
  app_message[0] = '%';

  // Create first part of topic and identification part of app_message
  strcpy(topic_base, "homeassistant/");
  if (IOT == INPUTMSG) {
    strcat(topic_base, "binary_sensor/");
    app_message[1] = 'I';
  }
  if (IOT == OUTPUTMSG) {
    strcat(topic_base, "switch/");
    app_message[1] = 'O';
  }
  if (IOT == TMPRMSG) {
    strcat(topic_base, "sensor/");
    app_message[1] = 'T';
  }
  
#if BME280_SUPPORT == 1
  if (IOT == PRESMSG) {
    strcat(topic_base, "sensor/");
    app_message[1] = 'P';
  }
#endif // BME280_SUPPORT == 1

#if BME280_SUPPORT == 1
  if (IOT == HUMMSG) {
    strcat(topic_base, "sensor/");
    app_message[1] = 'H';
  }
#endif // BME280_SUPPORT == 1

  if ((IOT == INPUTMSG) || (IOT == OUTPUTMSG)) {
    // Create the pin number for the app_message and topic.
    emb_itoa(IOT_ptr, OctetArray, 10, 2);
    // Add pin number to payload template
    app_message[2] = OctetArray[0];
    app_message[3] = OctetArray[1];
    app_message[4] = '\0';
  }

#if DS18B20_SUPPORT == 1
  if (IOT == TMPRMSG) {
    // Create the sensor number for the app_message and topic.
    // Add first part of sensor ID to payload template. For the DS18B20 the ID
    // is the DS18B20 MAC address.
    {
      int i;
      int j;
      j = 2;
      for (i=6; i>0; i--) {
        int2hex(FoundROM[IOT_ptr][i]);
        app_message[j++] = OctetArray[0];
        app_message[j++] = OctetArray[1];
      }
      app_message[14] = '\0';
    }
  }
#endif // DS18B20_SUPPORT == 1

#if BME280_SUPPORT == 1
  if (IOT == TMPRMSG || IOT == PRESMSG || IOT == HUMMSG) {
    // Create the sensor ID for the app_message and topic.
    // Add first part of sensor ID to payload template. For the BME280 the ID
    // is "BME280" plus a one digit number:
    //   0 = Temperature
    //   1 = Pressure
    //   2 = Humidity 
    create_sensor_ID(IOT_ptr);
    strcpy(&app_message[2], OctetArray);
  }
#endif // BME280_SUPPORT == 1

  // Create the rest of the topic
  strcat(topic_base, mac_string);
  strcat(topic_base, "/");
  strcat(topic_base, &app_message[2]);
  strcat(topic_base, "/config");
      
  // If deleting the pin replace the app_message with NULL (never delete
  // temperature, pressure, or humidity sensors ... let the user do that in
  // Home Assistant).
  if (DefOrDel == DELETE_IOT) app_message[0] = '\0';

  // Send the message
  // Note: This message will be intercepted in the mqtt_pal.c 
  //  mqtt_pal_sendall() routine and additional payload content will
  //  be added.
  // This message is always published with QOS 0
  mqtt_publish(&mqttclient,
               topic_base,
               app_message,
               strlen(app_message),
               MQTT_PUBLISH_QOS_0 | MQTT_PUBLISH_RETAIN);
}
#endif // BUILD_SUPPORT == MQTT_BUILD && HOME_ASSISTANT_SUPPORT == 1


#if BUILD_SUPPORT == MQTT_BUILD
void mqtt_sanity_check(struct mqtt_client *client)
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
    if (client->number_of_timeouts > 1) {
      // Reset the timeout counter
      client->number_of_timeouts = 0;
      MQTT_resp_tout_counter++;

#if DEBUG_SUPPORT == 15
// UARTPrintf("mqtt_sanity_check Response Timeout\r\n");
#endif // DEBUG_SUPPORT == 15

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

#if DEBUG_SUPPORT == 15
// UARTPrintf("mqtt_sanity_check Broker Disconnect\r\n");
#endif // DEBUG_SUPPORT == 15

      mqtt_restart_step = MQTT_RESTART_BEGIN;
    }
  
    // Check for an MQTT error
    // != MQTT_OK needs to be qualified with MQTT_START_COMPLETE because a
    // not OK condition can be present prior to mqtt_connect() running.
    if (mqtt_start == MQTT_START_COMPLETE
     && client->error != MQTT_OK) {
      MQTT_not_OK_counter++;


#if DEBUG_SUPPORT == 15
// MQTT not OK values are all negative numbers from 0x8000 to 0x801c.
// For debug display strip the first 4 bits, convert the remaining bits
// using emb_itoa (as it can only handle positive numbers), then rebuild
// the error code for display.
// {
// int16_t temp1;
// UARTPrintf("mqtt_sanity_check MQTT_not_OK - Error code: 0x");
// temp1 = client->error & 0x00ff;
// emb_itoa(temp1, OctetArray, 16, 4);
// OctetArray[0] = '8';
// UARTPrintf(OctetArray);
// UARTPrintf("\r\n");
// }
#endif // DEBUG_SUPPORT == 15

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
    mqtt_sanity_ctr = 0; // Clear 50ms counter
    break;
  
  case MQTT_RESTART_DISCONNECT_WAIT:
    if (mqtt_sanity_ctr > 20) {
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
    mqtt_sanity_ctr = 0; // Clear 50ms counter
    mqtt_restart_step = MQTT_RESTART_TCPCLOSE_WAIT;
    break;
  
  case MQTT_RESTART_TCPCLOSE_WAIT:
    // Verify closed ... how?
    // For the moment I'm not sure how to do this, so I will just allow
    // enough time for it to happen. That is probably very fast, but I will
    // allow 2 seconds.
    if (mqtt_sanity_ctr > 40) {
      mqtt_close_tcp = 0;
      mqtt_sanity_ctr = 0; // Clear 50ms counter
      mqtt_restart_step = MQTT_RESTART_SIGNAL_STARTUP;
    }
    break;
    
  case MQTT_RESTART_SIGNAL_STARTUP:
    // Set mqtt_restart_step and mqtt_start to re-run the MQTT connection
    // steps in the main loop
    mqtt_restart_step = MQTT_RESTART_IDLE;
    mqtt_start = MQTT_START_TCP_CONNECT;
    break;
    
  } // end switch
}
#endif // BUILD_SUPPORT == MQTT_BUILD


//--------------------------------------------------------------------------//
// Note that the original LiamBindle MQTT-C code relied on Linux or Microsoft
// OS processes to provide Link Level, IP, and TCP processing of received and
// transmitted packets (via a Socket). In this bare metal application the UIP
// code provides that processing.
//
// Before making an mqtt connection we need the equivalent of an OS "open a
// socket" to the MQTT Server. This is essentially an ARP request associating
// the MQTT Server IP Address (which we got from GUI input) with the MQTT
// Server MAC Address, followed by creating a TCP Connection via
// uip_connect().
//
// For reference: In the HTTP IO process "opening a socket" occurs in the
// uip_input and uip_arpin functions. HTTP has the notion that a browser makes
// a request, and the web server replies to that request, always in a
// one-to-one relationship. When a browser on a remote host makes a request to
// our IP address the remote host performs an ARP request (which we process
// via the uip_arp_arpin() function). Net result is that this establishes the
// equivalent of a "socket" with the web server on our device. Subsequent
// browser requests cause the uip_input() function to extract the IP Addresses
// and Port Numbers for the HTTP transaction source and destination and uses
// those to form the needed IP and TCP headers for any transmission that needs
// to occur. Next the uip_arp_out function is called to form a LLH header
// (containing the source and destination MAC addresses) for the packet to be
// transmitted.
// 
// The bare metal UIP application uses the same buffer for receive and
// transmit data (the uip_buf). But the original LiamBindle MQTT-C application
// expects an independent transmit buffer where it maintains transmit queueing
// information AND its transmit data. The MQTT transmit buffer (mqtt_sendbuf)
// retains transmitted messages (queue info + data) for a short time in case
// error recovery needs to re-transmit it. When it is time to actually
// transmit data from the mqtt_sendbuf the data is copied to the uip_buf,
// uip_len is set > 0, and the UIP code will perform the transmission as part
// of the uip_periodic function.
//
// The only messages that must be retained in the mqtt_sendbuf are the
// CONNECT, SUBSCRIBE, and PINGREQ messages. Since the CONNECT and SUBSCRIBE
// messages are only sent by the mqtt_startup state machine we can carefully
// manage that state machine to make sure the ACK for each of those messages
// is received before continuing the state machine. This means that the only
// messages that will be retained in the mqtt_sendbuf during normal operation
// are the PINGREQ messages. PINGREQ messages are only two bytes long. So, we
// can minimize the size of the mqtt_sendbuf to the point that only a 2 byte
// message and the longest of any other MQTT transmit message will fit.
//
// The mqtt_sendbuf always starts with a 12 byte Message Queue structure.
// 
// PINGREQ Msg (in the mqtt_sendbuf)
//   Fixed Header 2 bytes
//   Queued Message Header 11 bytes
//   Total: 13 bytes
//
// Output PUBLISH Msg (in the mqtt_sendbuf)
//   Fixed Header 2 bytes
//   Variable Header 47 bytes
//     Topic NetworkModule/DeviceName012345678/output/xx 43 bytes
//     Topic Length 2 bytes
//     Packet ID 2 bytes
//   Queued Message Header 11 bytes
//   Total: 60 bytes
//
// Temperature PUBLISH Msg (in the mqtt_sendbuf)
//   Fixed Header 2 bytes
//   Variable Header 51 bytes
//     Topic NetworkModule/DeviceName012345678/temp/xx-000.0 47 bytes
//     Topic Length 2 bytes
//     Packet ID 2 bytes
//   Queued Message Header 11 bytes
//   Total: 64 bytes
//
// Status PUBLISH Msg (in the mqtt_sendbuf)
//   Fixed Header 2 bytes
//   Variable Header 57 bytes
//     Topic NetworkModule/DeviceName123456789/availabilityoffline 53 bytes
//     Topic Length 2 bytes
//     Packet ID 2 bytes
//   Queued Message Header 11 bytes
//   Total: 70 bytes
//   
// The implication of the above is that in normal operation the mqtt_sendbuf
// needs to be as large as the Message Queue (12 bytes) plus one PINGREQ
// message (13 bytes) plus the longest Publish message (70 bytes), or 108
// bytes.
//
// However, during MQTT startup the CONNECT message is even larger as follows:
// CONNECT Msg (in the mqtt_sendbuf)
//   Fixed Header 2 bytes
//   Variable Header 10 bytes
//     Length of protocol name 2 bytes
//     Protocol name 4 bytes
//     Protocol level 1 byte
//     Connect flags 1 byte
//     Keep Alive 2 bytes
//   Payload
//     Client ID Length 2 bytes
//     Client ID 25 bytes
//     Will Topic Length 2 bytes
//     Will Topic 14+19+13 46 bytes
//     Will Message Length 2 bytes
//     Will Message 7 bytes
//     Username Length 2 bytes
//     Username 10 bytes
//     Passwoard Length 2 bytes
//     Password 10 bytes
//   Queued Message Header 11 bytes
// Total 131 bytes
// Thus the CONNECT message can be up to up to 131 bytes in length. Add the
// Message Queue (12 bytes) and the mqtt_sendbuf needs to be a minimum of 143
// bytes. Note that no PINGREQ can occur during the MQTT Startup process, so
// the CONNECT message will occupy the mqtt_sendbuf alone. This sets the
// required size of the mqtt_sendbuf at 143 bytes ... will make it 150 to
// provide a little extra.
//--------------------------------------------------------------------------//






#if BUILD_SUPPORT == MQTT_BUILD && HOME_ASSISTANT_SUPPORT == 1
void publish_callback(void** unused, struct mqtt_response_publish *published)
{
  char* pBuffer;
  uint8_t pin_value;
  uint8_t ParseNum;
  int i;
  int k;
#if PCF8574_SUPPORT == 0
  uint16_t j;
#endif // PCF8574_SUPPORT == 0
#if PCF8574_SUPPORT == 1
  uint32_t j;
#endif // PCF8574_SUPPORT == 1

  pin_value = 0;
  ParseNum = 0;
  i = 0;
  
  // This function will be called if a "Publish" is received from the Broker.
  // The publish message will contain a payload that, in this application,
  // will be the output control bits.
  //
  // This function is applicable to Home Assistant environments.
  //
  // This function is called from within the mqtt_recv() function. The data
  // left in the uip_buf will remain there until this function completes.
  //
  // Dissecting the Publish message:
  // - We know that the MQTT Headers + Payload starts at pointer uip_appdata
  // - We know that the Fixed Header is 2 bytes
  // - Next comes the Variable Header topic name. It is one of the following:
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
  // - We are QOS 0 so no Packet ID
  // - Next comes the Payload
  //   - If "Output/xx/set" we expect a payload of "ON" or "OFF"
  //   - if "Output/all/set" we expect a payload of "ON" or "OFF"
  //   - If "state-req" we expect no payload
  //
  // Once we collect the above information:
  // - Set or clear an individual pin
  //   OR
  // - Loop to set or clear "all" pins
  //   OR
  // - Set the state_request variable
  
  // Set the pBuffer pointer to the start of the MQTT packet
  
  pBuffer = &uip_buf[MQTT_PBUF];

  // Skip the Fixed Header Control Byte (1 byte)
  // Skip the Fixed Header Remaining Length Byte (1 byte)
  // Skip the Topic name length bytes (2 bytes)
  // Skip the NetworkModule/ text (14 bytes)
  pBuffer += 18;
  // Skip the Devicename/ text
  pBuffer += strlen(stored_devicename) + 1;
  
  // Determine if the sub-topic is "output" or "state-req"
  if (*pBuffer == 'o') {
    // "output" detected
    // Format can be any of these:
    //  If QOS 0:
    //   output/01/setON
    //   output/01/setOFF
    //   output/all/setON
    //   output/all/setOFF
    // In the above "ON" or "OFF" are in the payload.

    // Skip past the "output/" characters
    pBuffer+= 7;

    // Check if output field is "all". If so, update all output 
    // pin_control bytes to ON or OFF 
    if (*pBuffer == 'a') {
      // Skip past the "all/setO" part of the message.
      // Note that an "all" message is always sent with QOS == 0.
      pBuffer+=8;
      // Determine if payload is ON or OFF
      if (*pBuffer == 'N') {
        // Turn all outputs ON
#if PCF8574_SUPPORT == 0
	for (i=0; i<16; i++) {
#endif // PCF8574_SUPPORT == 0
#if PCF8574_SUPPORT == 1
	if ((stored_options1 & 0x08)) k = 24;
	else k = 16;
        for (i=0; i<k; i++) {
#endif // PCF8574_SUPPORT == 1
#if LINKED_SUPPORT == 0
	  if ((pin_control[i] & 0x03) == 0x03) {
#endif // LINKED_SUPPORT == 0
#if LINKED_SUPPORT == 1
          if (chk_iotype(pin_control[i], i, 0x03) == 0x03) {
#endif // LINKED_SUPPORT == 1
            // This is an Output
	    Pending_pin_control[i] = (uint8_t)(pin_control[i] | 0x80);
	  }
	}
      }
      else {
        // Turn all outputs OFF
#if PCF8574_SUPPORT == 0
	for (i=0; i<16; i++) {
#endif // PCF8574_SUPPORT == 0
#if PCF8574_SUPPORT == 1
	if ((stored_options1 & 0x08)) k = 24;
	else k = 16;
        for (i=0; i<k; i++) {
#endif // PCF8574_SUPPORT == 1
#if LINKED_SUPPORT == 0
	  if ((pin_control[i] & 0x03) == 0x03) {
#endif // LINKED_SUPPORT == 0
#if LINKED_SUPPORT == 1
          if (chk_iotype(pin_control[i], i, 0x03) == 0x03) {
#endif // LINKED_SUPPORT == 1
            // This is an Output
	    Pending_pin_control[i] = (uint8_t)(pin_control[i] & ~0x80);
	  }
	}
      }
    }
    
#if PCF8574_SUPPORT == 0
    else if (*pBuffer == '0' || *pBuffer == '1') {
#endif // PCF8574_SUPPORT == 0
#if PCF8574_SUPPORT == 1
    else if (*pBuffer == '0' || *pBuffer == '1' || *pBuffer == '2') {
#endif // PCF8574_SUPPORT == 1
      // Output field is a digit
      // Note that Output messages can are received with QOS == 0.
      // Collect the IO number
      // Parse ten's digit
      ParseNum = (uint8_t)((*pBuffer - '0') * 10);
      pBuffer++;
      // Parse one's digit
      ParseNum += (uint8_t)(*pBuffer - '0');

      // Verify ParseNum is in the correct range
#if PCF8574_SUPPORT == 0
      if (ParseNum > 0 && ParseNum < 17) {
#endif // PCF8574_SUPPORT == 0
#if PCF8574_SUPPORT == 1
      if (ParseNum > 0 && ParseNum < 25) {
#endif // PCF8574_SUPPORT == 1
        // Adjust Parsenum to match 0 to 15 numbering (instead of 1 to 16)
        ParseNum--;
        // Skip past the "1/setO" part of the message. If QOS == 0 there is
        // no Packet Identifier.
        pBuffer+=6;
	// Determine if payload is ON or OFF
	if (*pBuffer == 'N') {
	  // Turn output ON (and make sure it is an output)
#if LINKED_SUPPORT == 0
	  if ((pin_control[ParseNum] & 0x03) == 0x03) {
#endif // LINKED_SUPPORT == 0
#if LINKED_SUPPORT == 1
          if (chk_iotype(pin_control[ParseNum], ParseNum, 0x03) == 0x03) {
#endif // LINKED_SUPPORT == 1
            // This is an Output
	    Pending_pin_control[ParseNum] |= (uint8_t)0x80;
          }
	}
	if (*pBuffer == 'F') {
	  // Turn output OFF (and make sure it is an output)
#if LINKED_SUPPORT == 0
	  if ((pin_control[ParseNum] & 0x03) == 0x03) {
#endif // LINKED_SUPPORT == 0
#if LINKED_SUPPORT == 1
          if (chk_iotype(pin_control[ParseNum], ParseNum, 0x03) == 0x03) {
#endif // LINKED_SUPPORT == 1
            // This is an Output
	    Pending_pin_control[ParseNum] &= (uint8_t)~0x80;
          }
	}
	// Set the appropriate bit in MQTT_transmit to force a 
	// publish_pinstate for this pin.
	j = 1;
	j = (j << ParseNum);
	MQTT_transmit = (MQTT_transmit | j);
      }
    }
    
    // The above code effectively did for MQTT what the POST parsing does for
    // HTML, ie, changed the pin_control byte. So we need to set the 
    // mqtt_parse_complete value so that the check_runtime_changes() function
    // will perform the necessary IO actions.
    mqtt_parse_complete = 1;
  }
  
  // Determine if the sub-topic is "state-req" or "state_req24".
  // This Topic should always be received at QOS 0.
  else if (*pBuffer == 's') {
    // "state-req" or "state-req24" detected
    // Format is:
    //   state-req
    //   state-req24
    // -------------------------------------------------------------------- //
    // WARNING: To save flash space I don't check every sub-topic character.
    // But I also don't clear the uip_buf. So, I could pick up on stuff left
    // by a prevous message if not careful. In this limited application I can
    // get away with it, but this can trip me up in the future if more
    // messages are added.
    // -------------------------------------------------------------------- //

    // Capture the state-req command in OctetArray.
    for (i=0; i<11; i++) {
      OctetArray[i] = *pBuffer;
      pBuffer++;
    }
    OctetArray[11] = 0;
    
    if (OctetArray[8] == 'q') {
      // Confirmed this is a state-req command
      // Now figure out if the state-req is requesting a 16 pin output or a
      // 24 pin output. "state-req" is for 16 pins. "state-req24" is for 24
      // pins.
      // Assume this is for 16 pins for the moment.
      state_request = STATE_REQUEST_RCVD;
      // Move the pBuffer pointer back to the end of the state-req command
      pBuffer -= 2;
      // Destroy 'q' in buffer so subsequent "state" messages won't be
      // misinterpreted
      *pBuffer = '0';
      if ((OctetArray[9] == '2') && (OctetArray[10] == '4')) {
        // This is a state-req24 command
        state_request = STATE_REQUEST_RCVD24;
        // Destroy '2' and '4' in buffer so subsequent "state" messages won't
	// be misinterpreted
	pBuffer++;
        *pBuffer = '0';
	pBuffer++;
        *pBuffer = '0';
      }
    }
  }
  // Note: if none of the above matched the parsing we just exit without
  // executing any functionality (the message is effectively ignored).
}
#endif // BUILD_SUPPORT == MQTT_BUILD && HOME_ASSISTANT_SUPPORT == 1


#if BUILD_SUPPORT == MQTT_BUILD && DOMOTICZ_SUPPORT == 1
void publish_callback(void** unused, struct mqtt_response_publish *published)
{
  uint8_t ParseNum;
  uint8_t error;
  uint8_t match_found;
  int i;

  ParseNum = 0;
  match_found = 0;

#if DEBUG_SUPPORT == 15
// UARTPrintf("\r\n");
// UARTPrintf("Running publish_callback\r\n");
#endif // DEBUG_SUPPORT == 15

  // This function is applicable to Domoticz environments.
  //
  // This function will be called if a "Publish" is received from the Broker.
  // Domoticz operates differently that Home Assistant in that the Publish
  // message will have been completely received and analyzed in the
  // mqtt_sync() process of the mqtt.c code. This is necessary because
  // domoticz/out messages can be huge and may cross packet boundaries, which
  // can only be accounted for if the message is processed within the
  // mqtt_sync() function.
  //
  // The only values that need to be extracted from a Domoticz "domoticz/out"
  // message are the idx and nvalue values. Those are captured in the
  // mqtt_sync() function and stored in global values idx_string and
  // nvalue_string.
  //
  // In the following code we set or clear an individual pin associated with
  // the idx value. This requires searching the idx table to determine which
  // IOn pin is being referenced.
  
  // Set the pBuffer pointer to the start of the MQTT packet

  i = 0;
  error = 0;

#if DEBUG_SUPPORT == 15
// UARTPrintf("idx_string = ");
// UARTPrintf(idx_string);
// UARTPrintf("\r\n");
// UARTPrintf("nvalue_string = ");
// UARTPrintf(nvalue_string);
// UARTPrintf("\r\n");
#endif // DEBUG_SUPPORT == 15

  if (idx_string[0] == '\0') error = 1;
  if (nvalue_string[0] == '\0') error = 1;

  if (error == 0) {
#if DEBUG_SUPPORT == 15
// UARTPrintf("Starting IO_NAME search\r\n");
#endif // DEBUG_SUPPORT == 15
    // If no error was found then the idx and nvalue were captured.
    // Search the idx table to determine which pin has been set or cleared.
    // The idx table is stored in the same space normally used to store
    // pin names.
    
    // Assumption is that the idx value is never greater than 6 digits and
    // there are no leading zeroes.
    match_found = 0;
    for (i=0; i<16; i++) {
#if DEBUG_SUPPORT == 15
// UARTPrintf("IO_NAME = ");
// UARTPrintf(IO_NAME[i]);
// UARTPrintf("\r\n");
#endif // DEBUG_SUPPORT == 15
      if (strcmp(idx_string, IO_NAME[i]) == 0) {
        // Found a match
	match_found = 1;
	ParseNum = (uint8_t)i;
	break;
      }
    }
    
#if PCF8574_SUPPORT == 1
    {
      int j;
      char temp_byte[16];
      for (i=16; i<24; i++) {
        // Read a PCF8574_IO_NAME value from I2C EEPROM
        copy_I2C_EEPROM_bytes_to_RAM(&temp_byte[0], 16, I2C_EEPROM_R2_WRITE, I2C_EEPROM_R2_READ, PCF8574_I2C_EEPROM_R2_START_IO_NAMES + ((i - 16) * 16), 2);

#if DEBUG_SUPPORT == 15
// UARTPrintf("IO_NAME = ");
// UARTPrintf(temp_byte);
// UARTPrintf("\r\n");
#endif // DEBUG_SUPPORT == 15
        if (strcmp(idx_string, temp_byte) == 0) {
          // Found a match
	  match_found = 1;
	  ParseNum = (uint8_t)i;
	  break;
        }
      }
    }
#endif // PCF8574_SUPPORT == 1
    
    if (match_found == 0) {
      // Do nothing. The idx value is bogus.
    
#if DEBUG_SUPPORT == 15
// UARTPrintf("\r\n");
// UARTPrintf("No idx match found\r\n");
#endif // DEBUG_SUPPORT == 15

    }
  }

  if (match_found == 1) {
    // Verify ParseNum is in the correct range
    ParseNum++; // Add 1 to Parsenum for the following check
#if PCF8574_SUPPORT == 0
    if (ParseNum > 0 && ParseNum < 17) {
#endif // PCF8574_SUPPORT == 0
#if PCF8574_SUPPORT == 1
    if (ParseNum > 0 && ParseNum < 25) {
#endif // PCF8574_SUPPORT == 1
      ParseNum--; // Subtract one from ParseNum to use it as an array index
      // Determine if payload is ON or OFF
      if (nvalue_string[0] == '0') {
        // Turn output OFF (and make sure it is an output)
#if LINKED_SUPPORT == 0
        if ((pin_control[ParseNum] & 0x03) == 0x03) {
#endif // LINKED_SUPPORT == 0
#if LINKED_SUPPORT == 1
        if (chk_iotype(pin_control[ParseNum], ParseNum, 0x03) == 0x03) {
#endif // LINKED_SUPPORT == 1
          // This is an Output
	  Pending_pin_control[ParseNum] &= (uint8_t)~0x80;
        }
      }
      else {
        // Turn output ON (and make sure it is an output)
#if LINKED_SUPPORT == 0
	if ((pin_control[ParseNum] & 0x03) == 0x03) {
#endif // LINKED_SUPPORT == 0
#if LINKED_SUPPORT == 1
        if (chk_iotype(pin_control[ParseNum], ParseNum, 0x03) == 0x03) {
#endif // LINKED_SUPPORT == 1
          // This is an Output
	  Pending_pin_control[ParseNum] |= (uint8_t)0x80;
        }
      }
      // XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
      // XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
      // XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
      // The below doesn't look right. I set the MQTT_transmit which will
      // force a transmit. But I also changed the Pending_pin_control which
      // when processed will also cause a transmit. If timing doesn't work
      // out well we will have a double transmit?
      // XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
      // XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
      // XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
      // Set the appropriate bit in MQTT_transmit to force a 
      // publish_pinstate for this pin.
      {
        uint32_t pin_index;
        pin_index = 1;
        pin_index = (pin_index << ParseNum);
        MQTT_transmit = (MQTT_transmit | pin_index);
      }
    }
  }
    
  // The above code effectively did for MQTT what the POST parsing does for
  // HTML, ie, changed the pin_control byte. So we need to set the 
  // mqtt_parse_complete value so that the check_runtime_changes() function
  // will perform the necessary IO actions.
  mqtt_parse_complete = 1;
  // Note: if none of the above matched the parsing we just exit without
  // executing any functionality (the message is effectively ignored).
}
#endif // BUILD_SUPPORT == MQTT_BUILD && DOMOTICZ_SUPPORT == 1


#if BUILD_SUPPORT == MQTT_BUILD
void publish_outbound(void)
{
  // This function checks for a change on any pin (Output or Sense Input) and
  // PUBLISHes state messages to the Broker if a pin state changed. The
  // function also checks for a state_request and sends the 2 byte "all pin
  // states" message as a response.
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
  // Note that if the high order pins were to keep changing very quickly the
  // code might not get to the low order pins as often. This is a flaw but
  // may not matter much in this application. The code only checks and sends
  // a message at the periodic_timer_expired(), thus it takes at least 16
  // expirations to get all bits sent, and frequent changes in higher order
  // bits will supersede the processing of lower order bits.

#if PCF8574_SUPPORT == 0 && DOMOTICZ_SUPPORT == 0
  uint16_t xor_tmp;
  uint16_t j;
#endif // PCF8574_SUPPORT == 0 && DOMOTICZ_SUPPORT == 0
#if PCF8574_SUPPORT == 1 || DOMOTICZ_SUPPORT == 1
  uint32_t xor_tmp;
  uint32_t j;
#endif // PCF8574_SUPPORT == 1 || DOMOTICZ_SUPPORT == 1

  int i;
  int signal_break;

  signal_break = 0;

  // Check the mqtt_sendbuf to make sure it is emptied before PUBLISHing a
  // pin_state message. This is to prevent overflow of the mqtt_sendbuf when
  // Home Assistant pushes a large number of PUBLISH request messages.
  // This check effectively acts aa a throttle on the publish_outbound
  // process.
  if (!(mqtt_check_sendbuf(&mqttclient) > (MQTT_SENDBUF_SIZE - 15))) {
    // mqtt_check_sendbuf() returns the amount of space left in the
    // mqtt_sendbuf. We want to make sure it is empty except for the
    // 12 byte Message Queue, so we check that only 15 bytes are used.
    // If mqtt_sendbuf is not empty we exit but wlll come back later and
    // check again. It should empty quickly as the main loop will be
    // calling the MQTT routines to transmit whatever is there.
    return;
  }

  if (state_request == STATE_REQUEST_IDLE) {
    // STATE_REQUEST_IDLE is the normal state indicating that a state-req
    // message has not been received thus pin states can be transmitted if
    // needed.
    // XOR the current ON_OFF_word with the ON_OFF_word_sent (_sent being the
    // pin states we already transmitted via MQTT). This gives a result that
    // has a 1 for any pin state that still needs to be transmitted.
    
#if PCF8574_SUPPORT == 0 && DOMOTICZ_SUPPORT == 0
    xor_tmp = (uint16_t)(ON_OFF_word ^ ON_OFF_word_sent);
#endif // PCF8574_SUPPORT == 0 && DOMOTICZ_SUPPORT == 0
#if PCF8574_SUPPORT == 1 || DOMOTICZ_SUPPORT == 1
    xor_tmp = (uint32_t)(ON_OFF_word ^ ON_OFF_word_sent);
#endif // PCF8574_SUPPORT == 1 || DOMOTICZ_SUPPORT == 1

#if PCF8574_SUPPORT == 0 && DOMOTICZ_SUPPORT == 0
    i = 15;
    j = 0x8000;
#endif // PCF8574_SUPPORT == 0 && DOMOTICZ_SUPPORT == 0
#if PCF8574_SUPPORT == 1 || DOMOTICZ_SUPPORT == 1
    if (stored_options1 & 0x08) {
      i = 23;
      j = 0x00800000;
    }
    else {
      i = 15;
      j = 0x8000;
    }
#endif // PCF8574_SUPPORT == 1 || DOMOTICZ_SUPPORT == 1

    while ( 1 ) {

#if DS18B20_SUPPORT == 1
      // Check if DS18B20 is enabled, and if yes check if a Temperature
      // Publish needs to occur.
      if (stored_config_settings & 0x08) { // DS18B20 enabled?
        if (j == 0x8000) { // Servicing IO 16?
	  if (send_mqtt_temperature >= 0) {
	    publish_temperature(send_mqtt_temperature);
	    send_mqtt_temperature--;
	    break;
	  }
	}
      }
#endif // DS18B20_SUPPORT == 1

#if BME280_SUPPORT == 1 && HOME_ASSISTANT_SUPPORT == 1
      // Check if BME280 is enabled, and if yes check if a Sensor
      // Publish needs to occur.
      if (stored_config_settings & 0x20) { // BME280 enabled?
	if (send_mqtt_BME280 >= 0) {
	  publish_BME280(send_mqtt_BME280);
	  send_mqtt_BME280--;
	  break;
	}
      }
#endif // BME280_SUPPORT == 1 && HOME_ASSISTANT_SUPPORT == 1

#if BME280_SUPPORT == 1 && DOMOTICZ_SUPPORT == 1
      // Check if BME280 is enabled, and if yes check if a Sensor
      // Publish needs to occur.
      if (stored_config_settings & 0x20) { // BME280 enabled?
	if (send_mqtt_BME280 >= 0) {
	  publish_BME280(5);     // In the Domoticz environment the BME280
	                         // sensor always occupies IDX index 5. IDX
				 // indices 0, 1, 2, 3, 4 are for DS18B20.
	  send_mqtt_BME280 = -1; // In the Domoticz environment all BME280
	                         // sensors are sent in one call to
				 // publish_BME280, so setting to -1 after
				 // that call prevents further calls.
	  break;
	}
      }
#endif // BME280_SUPPORT == 1 && DOMOTICZ_SUPPORT == 1

      // Perform a publish_pinstate for each pin that has changed OR if an
      // MQTT PUBLISH attempts to change a pin state.
      // xor_temp is used to detect pin changes generated by the IOControl
      // GUI.
      // MQTT_transmit is used to detect pin changes requested via a received
      // MQTT PUBLISH command.
      // Further explanation: Originally I was simply using the xor_temp
      // method for changes pushed by the IOControl GUI >and< for changes
      // pushed by receipt of a MQTT PUBLISH State Change. However, it's been
      // found that sometimes a Client (like Home Assistant) can get out of
      // sync with the actual state of a pin, so it is safer to always
      // generate a pin state PUBLISH Response even if the MQTT Client
      // requests that a pin be changed to a state that it is already in, for
      // instance if the Client PUBLISH State Change says to turn a pin OFF
      // when it is already OFF. That is a case where the Client is out of
      // sync, so the Network Module will generate a PUBLISH Response to get
      // the Client back into sync.
//      if ((xor_tmp & j) || (MQTT_transmit & j)) {
      if ((xor_tmp & j) || (MQTT_transmit & j && mqtt_parse_complete == 0)) {
	// A publish_pinstate needs to occur if:
	//   A pin is Enabled (either Input or Output) and its ON/OFF state
	//   changed as indicated by xor_temp
	//   OR
        //   A MQTT PUBLISH was received for a pin as indicated by the
	//   MQTT_transmit word. Only use the MQTT_tranmit word as a trigger
	//   if mqtt_parse_complete == 0, indicating that any pin_control
	//   changes have been processed.
	// Send a PUBLISH Response containing the pin state
#if LINKED_SUPPORT == 0
        if ((pin_control[i] & 0x03) == 0x03) { // Enabled Output
#endif // LINKED_SUPPORT == 0
#if LINKED_SUPPORT == 1
        if (chk_iotype(pin_control[i], i, 0x03) == 0x03) {
	  // Enabled Output or Linked Output
#endif // LINKED_SUPPORT == 1
	  publish_pinstate('O', (uint8_t)(i+1), ON_OFF_word, j);
	  signal_break = 1; // Break out of the while loop, as we can only
	                    // send one Publish message per pass.
	}
#if LINKED_SUPPORT == 0
        if ((pin_control[i] & 0x03) == 0x01) { // Enabled Input
#endif // LINKED_SUPPORT == 0
#if LINKED_SUPPORT == 1
        if (chk_iotype(pin_control[i], i, 0x03) == 0x01) {
	  // Enabled input or Linked Input
#endif // LINKED_SUPPORT == 1
          publish_pinstate('I', (uint8_t)(i+1), ON_OFF_word, j);
	  signal_break = 1; // Break out of the while loop, as we can only
	                    // send one Publish message per pass.
	}
	// else Pin is not enabled so no Publish was required.
	
        // Update the "sent" pin state information so that the bit in
        // ON_OFF_word_sent matches the bit in ON_OFF_word for the pin
        // just examined. This will inidcate it was processed.
        if (ON_OFF_word & j) ON_OFF_word_sent |= j;
#if PCF8574_SUPPORT == 0 && DOMOTICZ_SUPPORT == 0
        else ON_OFF_word_sent &= (uint16_t)~j;
#endif // PCF8574_SUPPORT == 0 && DOMOTICZ_SUPPORT == 0
#if PCF8574_SUPPORT == 1 || DOMOTICZ_SUPPORT == 1
        else ON_OFF_word_sent &= (uint32_t)~j;
#endif // PCF8574_SUPPORT == 1 || DOMOTICZ_SUPPORT == 1
	// Clear the bit in the MQTT_transmit word to indicate that the
	// transmit was satisfied.
	MQTT_transmit &= ~j;

	// Break out of the while() loop only if a PUBLISH Response was sent.
	if (signal_break == 1) break;
      }
      
      // If no Publish was sent check the next one. Note: If any Publish
      // WAS sent we would have broken out of the while() loop.
      if (i == 0) break;
      j = j >> 1;
      i--;
    }
  }

#if HOME_ASSISTANT_SUPPORT == 1 // state_request not supported in Domoticz
  // Check for a state_request for 16 pins
  if (state_request == STATE_REQUEST_RCVD) {
    // Publish all pin states
    state_request = STATE_REQUEST_IDLE;
    publish_pinstate_all(STATE_REQUEST_RCVD);
  }
  // Check for a state_request for 24 pins
  if (state_request == STATE_REQUEST_RCVD24) {
    // Publish all pin states
    state_request = STATE_REQUEST_IDLE;
    publish_pinstate_all(STATE_REQUEST_RCVD24);
  }
#endif // HOME_ASSISTANT_SUPPORT == 1
}
#endif // BUILD_SUPPORT == MQTT_BUILD


#if BUILD_SUPPORT == MQTT_BUILD && HOME_ASSISTANT_SUPPORT == 1
#if PCF8574_SUPPORT == 0
void publish_pinstate(uint8_t direction, uint8_t pin, uint16_t value, uint16_t mask)
#endif // PCF8574_SUPPORT == 0
#if PCF8574_SUPPORT == 1
void publish_pinstate(uint8_t direction, uint8_t pin, uint32_t value, uint32_t mask)
#endif // PCF8574_SUPPORT == 1
{
  // This function transmits a change in pin state for a single pin.
  
  int size;
  int i;
  unsigned char app_message[4];       // Stores the application message (the
                                      // payload) that will be sent in an
				      // MQTT message.
  unsigned char topic_base[55]; // Used for building connect, subscribe,
                                // and publish topic strings.
				// Publish string content:
                                //  NetworkModule/DeviceName123456789/input/xx
                                //  NetworkModule/DeviceName123456789/output/xx
                                //  NetworkModule/DeviceName123456789/temp/xxxxxxxxxxxx
                                //  NetworkModule/DeviceName123456789/temp/BME280-0xxxx
                                //  NetworkModule/DeviceName123456789/state
                                //  NetworkModule/DeviceName123456789/state24
				//  NetworkModule/DeviceName123456789/state-req
				//  NetworkModule/DeviceName123456789/state-req24
				// Subscribe string content:
                                //  NetworkModule/DeviceName123456789/output/+/set
				//  NetworkModule/DeviceName123456789/state-req
				//  NetworkModule/DeviceName123456789/state-req24
				// Last Will string content:
				//  NetworkModule/DeviceName123456789/availability
				// Home Assistant config string content:
				//  homeassistant/switch/macaddressxx/xx/config
				//  homeassistant/binary_sensor/macaddressxx/xx/config
				//  homeassistant/sensor/macaddressxx/yyyyyyyyyyyy/config
				//  homeassistant/sensor/macaddressxx/BME280-0xxxx/config
				//  homeassistant/sensor/macaddressxx/BME280-1xxxx/config
				//  homeassistant/sensor/macaddressxx/BME280-2xxxx/config
  
  app_message[0] = '\0';
  
  strcpy(topic_base, devicetype);
  strcat(topic_base, stored_devicename);

  // If we are sending an Input message invert the value if the Invert_word
  // bit associated with the pin is 1
  if (direction == 'I') {
#if PCF8574_SUPPORT == 0
    if ((Invert_word & mask)) value = (uint16_t)(~value);
#endif // PCF8574_SUPPORT == 0
#if PCF8574_SUPPORT == 1
    if ((Invert_word & mask)) value = (uint32_t)(~value);
#endif // PCF8574_SUPPORT == 1
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
  // This message is always published with QOS 0
  mqtt_publish(&mqttclient,
               topic_base,
	       app_message,
	       size,
	       MQTT_PUBLISH_QOS_0 | MQTT_PUBLISH_RETAIN);
}
#endif // BUILD_SUPPORT == MQTT_BUILD && HOME_ASSISTANT_SUPPORT == 1


#if BUILD_SUPPORT == MQTT_BUILD && DOMOTICZ_SUPPORT == 1
// #if PCF8574_SUPPORT == 0
// void publish_pinstate(uint8_t direction, uint8_t pin, uint16_t value, uint16_t mask)
// #endif // PCF8574_SUPPORT == 0
// #if PCF8574_SUPPORT == 1
void publish_pinstate(uint8_t direction, uint8_t pin, uint32_t value, uint32_t mask)
// #endif // PCF8574_SUPPORT == 1
{
  // This function transmits a change in pin state for a single pin.
  
  int size;
  int i;
  int j;
  unsigned char app_message[60]; // app_message (payload) is always of the form
                                 // {"command":"switchlight","idx":xxxx,"switchcmd":"on"}
				 // or
                                 // {"command":"switchlight", "idx": xxxx, "switchcmd":"off"}
  unsigned char topic_base[12];  // topic_base for Domoticz is always
                                 //   domoticz/in
  unsigned char temp_idx[8];     // temp storage for idx value when read from I2C EEPROM
  
  
  strcpy(topic_base, "domoticz/in");

  // If we are sending an Input message invert the value if the Invert_word
  // bit associated with the pin is 1
  if (direction == 'I') {
// #if PCF8574_SUPPORT == 0
//     if ((Invert_word & mask)) value = (uint16_t)(~value);
// #endif // PCF8574_SUPPORT == 0
// #if PCF8574_SUPPORT == 1
    if ((Invert_word & mask)) value = (uint32_t)(~value);
// #endif // PCF8574_SUPPORT == 1
  }
  
  // Determine idx from table
  pin--; // Subtract 1 from the pin number to use it as an index
  app_message[0] = '\0';
  // Place command and idx in the payload
  strcat(app_message, "{\"command\":\"switchlight\",\"idx\":");
  
  if (pin < 16) {
    // Collect idx for pin numbers from 0 to 15
    strcat(app_message, IO_NAME[pin]);
  }
  
#if PCF8574_SUPPORT == 1
  else {
    // Collect idx for pin numbers from 16 to 24
    // Read a PCF8574_idx value from I2C EEPROM
    copy_I2C_EEPROM_bytes_to_RAM(&temp_idx[0], 8, I2C_EEPROM_R2_WRITE, I2C_EEPROM_R2_READ, PCF8574_I2C_EEPROM_R2_START_IO_NAMES + ((pin - 16) * 16), 2);
    strcat(app_message, temp_idx);
  }
#endif // PCF8574_SUPPORT == 1
  
  // Place the on/off state in the payload
  strcat(app_message, ",\"switchcmd\":\"");
  if (value & mask) {
    strcat(app_message, "On\"}");
  }
  else {
    strcat(app_message, "Off\"}");
  }
  size = strlen(app_message);

  // Queue publish message
  // This message is always published with QOS 0
  mqtt_publish(&mqttclient,
               topic_base,
	       app_message,
	       size,
	       MQTT_PUBLISH_QOS_0 | MQTT_PUBLISH_RETAIN);
}
#endif // BUILD_SUPPORT == MQTT_BUILD && DOMOTICZ_SUPPORT == 1




#if BUILD_SUPPORT == MQTT_BUILD && HOME_ASSISTANT_SUPPORT == 1
void publish_pinstate_all(uint8_t type)
{
  // This function transmits the state of all pins (outputs and sense inputs)
  // in response to a state-req PUBLISH from the Client. The pin states are
  // sent in a single message response regardless of the enabled/disabled
  // state.
  // Input pins need to be inverted per the Invert_word.
  // Output pins were already inverted elsewhere so they stay unchanged in
  // this function.
  // Disable pins will be sent with the last know state of the pin.
  // If publishing for 16 pins:
  //   The first byte of the Payload contains the ON/OFF state for IO 16 in
  //   the msb of the byte. The ON/OFF state for IO 9 is in the lsb.
  //   The second byte of the Payload contains the ON/OFF state for IO 8 in
  //   the msb of the byte. The ON/OFF state for IO 1 is in the lsb.
  // If publishing for 24 pins (when a PCF8574 is present:
  //   The first byte of the Payload contains the ON/OFF state for IO 24 in
  //   the msb of the byte. The ON/OFF state for IO 17 is in the lsb.
  //   The second byte of the Payload contains the ON/OFF state for IO 16 in
  //   the msb of the byte. The ON/OFF state for IO 9 is in the lsb.
  //   The third byte of the Payload contains the ON/OFF state for IO 8 in
  //   the msb of the byte. The ON/OFF state for IO 1 is in the lsb.
  
  uint32_t k;
  uint8_t k2;
  uint8_t k1;
  uint8_t k0;
  uint16_t msg_size;
  unsigned char app_message[4];       // Stores the application message (the
                                      // payload) that will be sent in an
				      // MQTT message.
  unsigned char topic_base[55]; // Used for building connect, subscribe,
                                // and publish topic strings.
				// Publish string content:
                                //  NetworkModule/DeviceName123456789/input/xx
                                //  NetworkModule/DeviceName123456789/output/xx
                                //  NetworkModule/DeviceName123456789/temp/xxxxxxxxxxxx
                                //  NetworkModule/DeviceName123456789/temp/BME280-0xxxx
                                //  NetworkModule/DeviceName123456789/state
                                //  NetworkModule/DeviceName123456789/state24
				//  NetworkModule/DeviceName123456789/state-req
				//  NetworkModule/DeviceName123456789/state-req24
				// Subscribe string content:
                                //  NetworkModule/DeviceName123456789/output/+/set
				//  NetworkModule/DeviceName123456789/state-req
				//  NetworkModule/DeviceName123456789/state-req24
				// Last Will string content:
				//  NetworkModule/DeviceName123456789/availability
				// Home Assistant config string content:
				//  homeassistant/switch/macaddressxx/xx/config
				//  homeassistant/binary_sensor/macaddressxx/xx/config
				//  homeassistant/sensor/macaddressxx/yyyyyyyyyyyy/config
				//  homeassistant/sensor/macaddressxx/BME280-0xxxx/config
				//  homeassistant/sensor/macaddressxx/BME280-1xxxx/config
				//  homeassistant/sensor/macaddressxx/BME280-2xxxx/config
  
  // Copy mthe ON_OFF_word into variable k so it will contain all the pin
  // states.
  k = ON_OFF_word;
  // If sending 16 bits need to split it into two bytes for transmission.
  // If sending 24 bits need to split it into three bytes for transmission.
  k0 = (uint8_t)k;
  k1 = (uint8_t)(k >> 8);
  k2 = (uint8_t)(k >> 16);

  msg_size = 2;
  if (type == STATE_REQUEST_RCVD) {
    app_message[0] = (uint8_t)k1;
    app_message[1] = (uint8_t)k0;
    app_message[2] = '\0';
  }
#if PCF8574_SUPPORT == 1
  if (type == STATE_REQUEST_RCVD24) {
    app_message[0] = (uint8_t)k2;
    app_message[1] = (uint8_t)k1;
    app_message[2] = (uint8_t)k0;
    app_message[3] = '\0';
    msg_size = 3;
  }
#endif // PCF8574_SUPPORT == 1

  strcpy(topic_base, devicetype);
  strcat(topic_base, stored_devicename);
  
  if (type == STATE_REQUEST_RCVD) {
    strcat(topic_base, "/state");
  }
#if PCF8574_SUPPORT == 1
  if (type == STATE_REQUEST_RCVD24) {
    strcat(topic_base, "/state24");
  }
#endif // PCF8574_SUPPORT == 1

  // Queue publish message
  // This message is always published with QOS 0
  mqtt_publish(&mqttclient,
               topic_base,
	       app_message,
	       msg_size,
	       MQTT_PUBLISH_QOS_0 | MQTT_PUBLISH_RETAIN);
}
#endif // BUILD_SUPPORT == MQTT_BUILD && HOME_ASSISTANT_SUPPORT == 1


#if BUILD_SUPPORT == MQTT_BUILD && HOME_ASSISTANT_SUPPORT == 1
#if DS18B20_SUPPORT == 1
void publish_temperature(uint8_t sensor)
{
  // This function is called to Publish a temperature value collected from
  // a DS18B20 connected to IO 16.
  
  unsigned char topic_base[55]; // Used for building connect, subscribe,
                                // and publish topic strings.
				// Publish string content:
                                //  NetworkModule/DeviceName123456789/input/xx
                                //  NetworkModule/DeviceName123456789/output/xx
                                //  NetworkModule/DeviceName123456789/temp/xxxxxxxxxxxx
                                //  NetworkModule/DeviceName123456789/temp/BME280-0xxxx
                                //  NetworkModule/DeviceName123456789/state
                                //  NetworkModule/DeviceName123456789/state24
				//  NetworkModule/DeviceName123456789/state-req
				//  NetworkModule/DeviceName123456789/state-req24
				// Subscribe string content:
                                //  NetworkModule/DeviceName123456789/output/+/set
				//  NetworkModule/DeviceName123456789/state-req
				//  NetworkModule/DeviceName123456789/state-req24
				// Last Will string content:
				//  NetworkModule/DeviceName123456789/availability
				// Home Assistant config string content:
				//  homeassistant/switch/macaddressxx/xx/config
				//  homeassistant/binary_sensor/macaddressxx/xx/config
				//  homeassistant/sensor/macaddressxx/yyyyyyyyyyyy/config
				//  homeassistant/sensor/macaddressxx/BME280-0xxxx/config
				//  homeassistant/sensor/macaddressxx/BME280-1xxxx/config
				//  homeassistant/sensor/macaddressxx/BME280-2xxxx/config




#if OB_EEPROM_SUPPORT == 1 && DS18B20_SUPPORT == 1
  // The FoundROM[][] array is located in I2C EEPROM if I2C EEPROM is
  // supported. So it is copied to a local stack based FoundROM[][] array
  // for use in this case.
  uint8_t FoundROM[5][8];           // Table of ROM codes
                                    // [x][0] = Family Code
                                    // [x][1] = LSByte serial number
                                    // [x][2] = byte 2 serial number
                                    // [x][3] = byte 3 serial number
                                    // [x][4] = byte 4 serial number
                                    // [x][5] = byte 5 serial number
                                    // [x][6] = MSByte serial number
                                    // [x][7] = CRC
#endif // OB_EEPROM_SUPPORT == 1 && DS18B20_SUPPORT == 1

      
#if OB_EEPROM_SUPPORT == 1 && DS18B20_SUPPORT == 1
  // If I2C EEPROM is supported then the FoundROM table is stored in the
  // I2C EEPROM and must be copied to a stack based RAM location for use
  // here. The I2C EEPROM copy of the FoundROM table starts at
  // I2C_EEPROM_R1_FOUNDROM. There are 5 entries, each 8 bytes long, for
  // a total of 40 bytes.
  copy_I2C_EEPROM_bytes_to_RAM(&FoundROM[0][0], 40, I2C_EEPROM_R1_WRITE, I2C_EEPROM_R1_READ, I2C_EEPROM_R1_FOUNDROM, 2);
#endif // OB_EEPROM_SUPPORT == 1 && DS18B20_SUPPORT == 1

  if (sensor <= numROMs) {
    // Only Publish if the sensor number is one of the sensors found by
    // FindDevices as indicated by numROMs.
    //
    // The "sensor" value delivered to this function identifies the sensor
    // as a value from 0 to 4 (for the five sensors).
    //
    // The "numROMs" value is also a value from 0 to 4 (for the five sensors).
    
    // Build the topic string
    strcpy(topic_base, devicetype);
    strcat(topic_base, stored_devicename);
    strcat(topic_base, "/temp/");
    
    // Add sensor number to the topic message.
    {
      int i;
      int j;
      j = (uint8_t)strlen(topic_base);
      for (i=6; i>0; i--) {
        int2hex(FoundROM[sensor][i]);
        topic_base[j++] = OctetArray[0];
        topic_base[j++] = OctetArray[1];
      }
      topic_base[j] = '\0';
    }
    
    // Build the application message
    convert_temperature(sensor, 0, 0); // Convert to degress C in OctetArray
    
    // Queue publish message
    // This message is always published with QOS 0
    mqtt_publish(&mqttclient,
                 topic_base,
                 OctetArray,   // app_message
                 strlen(OctetArray),
                 MQTT_PUBLISH_QOS_0 | MQTT_PUBLISH_RETAIN);
  }
}
#endif // DS18B20_SUPPORT == 1
#endif // BUILD_SUPPORT == MQTT_BUILD && HOME_ASSISTANT_SUPPORT == 1


#if BUILD_SUPPORT == MQTT_BUILD && DOMOTICZ_SUPPORT == 1
#if DS18B20_SUPPORT == 1
void publish_temperature(uint8_t sensor)
{
  // This function is called to Publish a temperature value collected from
  // a DS18B20 connected to IO 16.
  
  unsigned char topic_base[12]; // Used for building connect, subscribe,
                                // and publish topic strings.
  unsigned char app_message[90]; // app_message (payload) is always of the form
    // {"command": "udevice", "idx": 321, "nvalue": 0, "svalue": "22.7", "parse": true}
  
  if (sensor <= numROMs && (Sensor_IDX[sensor][0] != '0')) {
    // Only Publish if the sensor number is one of the sensors found by
    // FindDevices as indicated by numROMs AND the sensor has been given an
    // IDX number.
    //
    // The "sensor" value delivered to this function identifies the sensor
    // as a value from 0 to 4 (for the five sensors).
    //
    // The "numROMs" value is also a value from 0 to 4 (for the five sensors).
    
    // Build the topic string
    strcpy(topic_base, "domoticz/in");
    
    // Build the Payload message
    // {"command":"udevice","idx":321,"nvalue":0,"svalue":"22.77","parse":true}
    strcpy(app_message, "{\"command\":\"udevice\",\"idx\":");
    
    // Add idx value
    strcat(app_message, Sensor_IDX[sensor]);
    
    strcat(app_message, ",\"nvalue\":0,\"svalue\":\"");
    
    // Add sensor temperature value
    convert_temperature(sensor, 0, 0); // Convert to degress C in OctetArray
    if (OctetArray[0] == ' ') OctetArray[0] = '0';
    strcat(app_message, OctetArray);
    strcat(app_message, "\",\"parse\":true}");
    
    // Queue publish message
    // This message is always published with QOS 0
    mqtt_publish(&mqttclient,
                 topic_base,
                 app_message,
                 strlen(app_message),
                 MQTT_PUBLISH_QOS_0 | MQTT_PUBLISH_RETAIN);
  }
}
#endif // DS18B20_SUPPORT == 1
#endif // BUILD_SUPPORT == MQTT_BUILD && DOMOTICZ_SUPPORT == 1


#if BUILD_SUPPORT == MQTT_BUILD && HOME_ASSISTANT_SUPPORT == 1
#if BME280_SUPPORT == 1
void publish_BME280(int8_t sensor)
{
  // This function is called to Publish the sensor values collected from
  // a BME280 temperature, pressure, humidity sensor.
  
  unsigned char topic_base[55]; // Used for building connect, subscribe,
                                // and publish topic strings.
				// Publish string content:
                                //  NetworkModule/DeviceName123456789/input/xx
                                //  NetworkModule/DeviceName123456789/output/xx
                                //  NetworkModule/DeviceName123456789/temp/xxxxxxxxxxxx
                                //  NetworkModule/DeviceName123456789/temp/BME280-0xxxx
                                //  NetworkModule/DeviceName123456789/state
                                //  NetworkModule/DeviceName123456789/state24
				//  NetworkModule/DeviceName123456789/state-req
				//  NetworkModule/DeviceName123456789/state-req24
				// Subscribe string content:
                                //  NetworkModule/DeviceName123456789/output/+/set
				//  NetworkModule/DeviceName123456789/state-req
				//  NetworkModule/DeviceName123456789/state-req24
				// Last Will string content:
				//  NetworkModule/DeviceName123456789/availability
				// Home Assistant config string content:
				//  homeassistant/switch/macaddressxx/xx/config
				//  homeassistant/binary_sensor/macaddressxx/xx/config
				//  homeassistant/sensor/macaddressxx/yyyyyyyyyyyy/config
				//  homeassistant/sensor/macaddressxx/BME280-0xxxx/config
				//  homeassistant/sensor/macaddressxx/BME280-1xxxx/config
				//  homeassistant/sensor/macaddressxx/BME280-2xxxx/config
  
  
//  if (BME280_found == 1) {
  if (stored_config_settings & 0x20) { // BME280 enabled?
    // Build the topic string
    strcpy(topic_base, devicetype);
    strcat(topic_base, stored_devicename);
    
    if (sensor == 0) strcat(topic_base, "/temp/");
    if (sensor == 1) strcat(topic_base, "/pres/");
    if (sensor == 2) strcat(topic_base, "/hum/");


    // Isolate the two least significant octets of the uip_hostaddr (the module
    // IP address). Convert these two octets into a 4 character hexidecimal and use
    // that to create a unique ID for the BME280 sensor.
    create_sensor_ID(sensor); // This builds the sensor ID in OctetArray in
                              // the format "BME280-yxxxx" where "y" is the
			      // sensor number (0, 1 2) and xxxx is the two
			      // least significant octets of the hostaddr.
    strcat(topic_base, OctetArray);
    
    // Build the application message
    if (sensor == 0) {
      // Convert temperature to degrees C in OctetArry
      BME280_temperature_string_C();
    }
    if (sensor == 1) {
      // Convert pressure to hPa in OctetArry
      BME280_pressure_string();
    }
    if (sensor == 2) {
      // Convert humidity to % in OctetArry
      BME280_humidity_string();
    }

    // Queue publish message
    // This message is always published with QOS 0
    mqtt_publish(&mqttclient,
                 topic_base,
                 OctetArray,   // app_message
                 strlen(OctetArray),
                 MQTT_PUBLISH_QOS_0 | MQTT_PUBLISH_RETAIN);
  }
}
#endif // BME280_SUPPORT == 1
#endif // BUILD_SUPPORT == MQTT_BUILD && HOME_ASSISTANT_SUPPORT == 1


#if BUILD_SUPPORT == MQTT_BUILD && DOMOTICZ_SUPPORT == 1
#if BME280_SUPPORT == 1
void publish_BME280(int8_t sensor)
{
  // This function is called to Publish the sensor values collected from
  // a BME280 temperature, pressure, humidity sensor.
  
  int8_t i;
  unsigned char topic_base[12]; // Used for building connect, subscribe,
                                // and publish topic strings.
  unsigned char app_message[90]; // app_message (payload) is always of the form
  // {"command":"udevice","idx":321,"svalue":"8.8;91;3;1029;0"}
  // The svalue consists of fields in this order;
  //   Temperature in C
  //   Relative Humidity in %
  //   Humidity Status
  //   Barometric Pressure in HPa
  //   Weather Prediction
  
  // Humidity Status can be one of 
  //  HUM_NORMAL	value 0
  //  HUM_COMFORTABLE	value 1
  //  HUM_DRY		value 2
  //  HUM_WET		value 3
  // A suggested calculation from the Domoticz Forum:
  //  if humidity <= 30 then HUM_DRY
  //  else if humidity >= 70 then return HUM_WET
  //  else if humidity >= 35 and
  //    humidity <= 65 and
  //    temperature >= 22 and
  //    temperature <= 26 then HUM_COMFORTABLE
  //  else HUM_NORMAL
 
  // Weather Prediction values:
  // From the Domoticz Forum https://www.domoticz.com/forum/viewtopic.php?t=36921
  // For dummy devices the list is
  // 0 { bmpbaroforecast_stable, "Stable" },
  // 1 { bmpbaroforecast_sunny, "Sunny" },
  // 2 { bmpbaroforecast_cloudy, "Cloudy" },
  // 3 { bmpbaroforecast_unstable, "Unstable" },
  // 4 { bmpbaroforecast_thunderstorm, "Thunderstorm" },
  // 5 { bmpbaroforecast_unknown, "Unknown" },
  // 6 { bmpbaroforecast_rain, "Cloudy/Rain" },
  // 
  // For other baro devices in native integrations, like in buienradar the list is different....
  // 0 { wsbaroforecast_heavy_snow, "Heavy Snow" },
  // 1 { wsbaroforecast_snow, "Snow" },
  // 2 { wsbaroforecast_heavy_rain, "Heavy Rain" },
  // 3 { wsbaroforecast_rain, "Rain" },
  // 4 { wsbaroforecast_cloudy, "Cloudy" },
  // 5 { wsbaroforecast_some_clouds, "Some Clouds" },
  // 6 { wsbaroforecast_sunny, "Sunny" },
  // 7 { wsbaroforecast_unknown, "Unknown" },
  // 8 { wsbaroforecast_unstable, "Unstable" },
  // 9 { wsbaroforecast_stable, "Stable" },
  //
  // From the Domoticz Forum https://www.domoticz.com/forum/viewtopic.php?t=39655
  // For "Barometer" and "Temperature + Barometer", the following "Prediction"
  // is given (this matches the "dummy" list above):
  // 0: Stable
  // 1: Sunny
  // 2: Cloudy
  // 3: Unstable
  // 4: Thunderstorm
  // 5: Unknown
  // 6: Cloudy/Rain
  //
  // For "Temperature + Humidity + Barometer", the following "Prediction" is
  // given (this seems to match what is happening in this application, or at
  // least "0" matches):
  // 0: No Info
  // 1: Sunny
  // 2: Partly Cloudy
  // 3: Cloudy
  // 4: Rain
  //
  // Calculating a weather predition is discussed in this link:
  // https://wiki.seeedstudio.com/Wio-Terminal-TinyML-TFLM-2/
  // Since calculating a prediction requires retaiing several hours of data
  // from the BME280 it seems beyond the scope of this application to do
  // the calcuation, so 0 is always returned (No Info).
  
  // Note: In the Home Assistant environment the Temperature, Humidity, and
  // Pressure values are sent as 3 separate MQTT messages. In the Domoticz
  // environment the Temperature, Humidity, and Pressure values are sent as
  // a single MQTT message.

//  if (BME280_found == 1) {
  if (stored_config_settings & 0x20) { // BME280 enabled?

    // Build the topic string
    strcpy(topic_base, "domoticz/in");

    // Build the Payload message
    // {"command":"udevice","idx":321,"svalue":"8.8;91;3;1029;0"}
    
    strcpy(app_message, "{\"command\":\"udevice\",\"idx\":");
    
    // Add idx value
    strcat(app_message, Sensor_IDX[sensor]);
    strcat(app_message, ",\"svalue\":\"");
    
    // Add sensor temperature value
    // Convert temperature to degrees C in OctetArry
    BME280_temperature_string_C();
    // Remove leading spaces. Replace with '0'.
    for (i = 0; i < strlen (OctetArray); i++) {
      if (OctetArray[i] == ' ') OctetArray[i] = '0';
    }
    strcat(app_message, OctetArray);
    strcat(app_message, ";");

    // Add sensor humidity value
    // Convert pressure to hPa in OctetArry
    BME280_humidity_string();
    strcat(app_message, OctetArray);
    strcat(app_message, ";");

    // Calculate and add HUM_STAT value
    {
      int32_t hum_whole;
      char hum_stat[2];
      
      hum_whole = (int32_t)(comp_data_humidity / 1024);
      hum_stat[1] = '\0';
      
      if (hum_whole <= 30) hum_stat[0] = '2'; // HUM_DRY
      else if (hum_whole >= 70) hum_stat[0] = '3'; // HUM_WET
      else if (hum_whole >= 35 && hum_whole <= 65
            && comp_data_temperature >= 22 && comp_data_temperature <= 26)
        hum_stat[0] = '1'; // HUM_COMFORTABLE
      else hum_stat[0] = '0'; // HUM_NORMAL
      strcat(app_message, hum_stat);
      strcat(app_message, ";");
    }

    // Add sensor pressure value
    // Convert pressure to hPa in OctetArry
    BME280_pressure_string();
    strcat(app_message, OctetArray);
    strcat(app_message, ";");

    // Add sensor pressure prediciton value. Use Default of 0 and add payload
    // termination.
    strcat(app_message, "0\"}");

    // Queue publish message
    // This message is always published with QOS 0
    mqtt_publish(&mqttclient,
                 topic_base,
                 app_message,
                 strlen(app_message),
                 MQTT_PUBLISH_QOS_0 | MQTT_PUBLISH_RETAIN);
  }
}
#endif // BME280_SUPPORT == 1
#endif // BUILD_SUPPORT == MQTT_BUILD && DOMOTICZ_SUPPORT == 1


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


void update_settings_options(uint8_t select, uint8_t value)
{
  // Unlock the EEPROM, update the stored_config_settings or stored_options1
  // or stored_options2, then Lock the EEPROM.
  unlock_eeprom();
  switch (select)
  {
    case UPDATE_CONFIG_SETTINGS: // Update stored_config_settings
      if (value != stored_config_settings) {
        stored_config_settings = value;
      }
      break;
    case UPDATE_OPTIONS1: // Update stored_options1
      if (value != stored_options1) {
        stored_options1 = value;
      }
      break;
    case UPDATE_OPTIONS2: // Update stored_options2
      if (value != stored_options2) {
        stored_options2 = value;
      }
      break;
  }
  lock_eeprom();
}


void unlock_flash(void)
{
  // Unlock the Flash
  // The Flash must be unlocked to allow any writes to it.
  // Note that when Flash is written the hardware will stall code execution
  // until the write completes. This typically takes 6ms per write.
  FLASH_PUKR = 0x56; // MASS key 1
  FLASH_PUKR = 0xAE; // MASS key 2
}


void lock_flash(void)
{
  // Lock the Flash so that it cannot be written. This clears the PUL bit.
  FLASH_IAPSR &= (uint8_t)(~0x02);
}


void upgrade_EEPROM(void)
{
  // This functions upgrades prior revisions of the EEPROM to the current
  // revision.
  int i;
  
  //-------------------------------------------------------------------------//
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
  //-------------------------------------------------------------------------//
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
    
//    // Placeholder for future EEPROM revision level. Put in the values
//    // that should be checked. Recommended next level to be 0x02.
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
    for (i=0; i<16; i++) {
      stored_pin_control[i] = 0;
    }
    
    // Set to the EEPROM revision for this code
    stored_EEPROM_revision1 = 0x01;
    stored_EEPROM_revision2 = 0xf5;
    
    break;
  }
  lock_eeprom();
}    


void check_eeprom_settings(void)
{
  // Check magic number in EEPROM.
  //
  // If the magic number IS NOT found it is assumed that the EEPROM has never
  // been written. In this case the default Output States, IP Address, Gateway
  // Address, Netmask, MAC and Port number will be used.
  //
  // If the magic number IS found then it is assumed that the EEPROM contains
  // valid copies of the Output States, IP Address, Gateway Address, Netmask,
  // MAC and Port number, and those are used to start the device.
  //
  // The magic number sequence is MSB 0x55 0xee 0x0f 0xf0 LSB
  
  magic_number_missing_flag = 0; // Track whether Magic Number is found
  
  if ((stored_magic4 != 0x55) || 
      (stored_magic3 != 0xee) || 
      (stored_magic2 != 0x0f) || 
      (stored_magic1 != 0xf0)) {

    // MAGIC NUMBER IS NOT PRESENT. Initialize EEPROM with the default Device
    // Name, IP, Gateway, Netmask, Port, and MAC values. Also initialize
    // EEPROM to turn off all Outputs and write the magic number.
    
    magic_number_missing_flag = 1; // Indicate Magic Number was missing at
                                   // boot time.

    unlock_eeprom(); // Make EEPROM writeable
    
    // Write default valuse to the EEPROM. These notes are the long form
    // version of what the code below does. The code to implement this is
    // less "readable", but more space efficient, thus the need for these
    // notes:
    //
    // Write the default Device Name to EEPROM.
    //    strcpy(stored_devicename, "NewDevice000");
    //    for (i=12; i<20; i++) stored_devicename[i] = '\0';
    //
    // Write the default MAC address to EEPROM.
    //    stored_uip_ethaddr_oct[5] = 0xc2;	//MAC MSB
    //    stored_uip_ethaddr_oct[4] = 0x4d;
    //    stored_uip_ethaddr_oct[3] = 0x69;
    //    stored_uip_ethaddr_oct[2] = 0x6b;
    //    stored_uip_ethaddr_oct[1] = 0x65;
    //    stored_uip_ethaddr_oct[0] = 0x00;	//MAC LSB
    //
    // Write the default Port number to EEPROM
    //    stored_port = 8080;
    //
    // Write the Default Netmask to EEPROM
    //    stored_netmask[3] = 255;	// MSB
    //    stored_netmask[2] = 255;	//
    //    stored_netmask[1] = 255;	//
    //    stored_netmask[0] = 0;	// LSB
    //
    // Write the Default Gateway Address to EEPROM
    //    stored_draddr[3] = 192;	// MSB
    //    stored_draddr[2] = 168;	//
    //    stored_draddr[1] = 1;	//
    //    stored_draddr[0] = 1;	// LSB
    //
    // Write the Default IP Address to EEPROM
    //    stored_hostaddr[3] = 192;	// MSB
    //    stored_hostaddr[2] = 168;	//
    //    stored_hostaddr[1] = 1;	//
    //    stored_hostaddr[0] = 4;	// LSB
    //    
    // Write the magic number to the EEPROM MSB 0x55 0xee 0x0f 0xf0 LSB
    //    stored_magic4 = 0x55; // MSB
    //    stored_magic3 = 0xee; //
    //    stored_magic2 = 0x0f; //
    //    stored_magic1 = 0xf0; // LSB
    //    
    // Write the default MQTT Port number to EEPROM
    //    stored_mqttport = 1883;		// Port
    //    
    // Write the Default MQTT Server IP Address to EEPROM
    //    stored_mqttserveraddr[3] = 0;	// MSB
    //    stored_mqttserveraddr[2] = 0;	//
    //    stored_mqttserveraddr[1] = 0;	//
    //    stored_mqttserveraddr[0] = 0;	// LSB
    //
    // Using 0 as the first byte number in EEPROM:
    //  Bytes 0 to 19:    DeviceName
    //  Bytes 20, 21, 22: Don't write these bytes
    //  Bytes 23 to 68:   Load from pre-determined content
    //  Bytes 69 to 113:  Fill with zero
    //
    // Write a NULL Usernams and Password to the EEPROM
    //    for(i=0; i<11; i++) { stored_mqtt_username[i] = '\0'; }
    //    for(i=0; i<11; i++) { stored_mqtt_password[i] = '\0'; }
    //
    // 5 unused bytes - fill with NULL
    // 1 prior config byte currently unused - fill with NULL
    //
    // Clear the Config settings in EEPROM
    //    stored_config_settings = 0;
    //
    // -------------------------------------------------------------------- //
    // All pins need to default to "input" and "disable" to prevent any
    // conflict with external hardware drivers.
    // pin_control_bytes are set to defaults
    //   Each pin should be set to 00000000
    //   0 ON/OFF
    //   0 reserved
    //   0 reserved
    //   0 On/Off after power cycle set to Off
    //   0 Retain set to Off
    //   0 Invert set to Off
    //   0 | The two least significant bits define the pin type:
    //   0 | 00: Disabled  01: Input  10: Linked  11: Output
    // THEN bit registers are initialized
    //   encode_bit_registers()
    // -------------------------------------------------------------------- //
    //
    // Write the default pin_control bytes to EEPROM
    //    for (i=0; i<16; i++) stored_pin_control[i] = 0x00;


    // Using 0 as the first byte number in EEPROM:
    //  Bytes 0 to 19:    DeviceName
    //  Bytes 20, 21, 22: Don't write these bytes
    //  Bytes 23 to 68:   Load from pre-determined content
    //  Bytes 69 to 113:  Fill with zero

    {
      // First 20 bytes - device name
      static const uint8_t EEPROM_default_devicename[] = {
      'N', 'e', 'w', 'D', 'e', 'v', 'i', 'c', 'e', '0', '0', '0', 0x00, 0x00, 0x00, 0x00,
      0x00, 0x00, 0x00, 0x00 };
      memcpy(&stored_devicename[0], EEPROM_default_devicename, 20);
    } // 20 bytes
    
    // 1 byte stored hardware options
    stored_options1 = 0;
    
    // Skip 2 bytes (the EEPROM revision bytes)

    {
      // Next 30 bytes
      static const uint8_t EEPROM_default_general[] = {
      // 6 bytes MAC address (aka ethaddr)
      0x00, 0x65, 0x6b, 0x69, 0x4d, 0xc2,
      // 2 bytes HTML Port (8080)
      0x1f, 0x90,
      // 4 bytes Default Netmask (255.255.255.0)
      0x00, 0xff, 0xff, 0xff,
      // 4 bytes Default Gateway (192.168.1.1)
      0x01, 0x01, 0xa8, 0xc0,
      // 4 bytes Default IP Address (192.168.1.4)
      0x04, 0x01, 0xa8, 0xc0,
      // 4 bytes Magic Number
      0xf0, 0x0f, 0xee, 0x55,
      // 2 bytes MQTT Port (1883)
      0x07, 0x5b,
      // 4 bytes MQTT Server Address (0.0.0.0)
      0x00, 0x00, 0x00, 0x00};
      memcpy(&stored_uip_ethaddr_oct[0], EEPROM_default_general, 30);
    } // 30 bytes
    
    // Next 45 bytes are all 0
    //   MQTT username 11 bytes
    //   MQTT password 11 bytes
    //   Unused 5 bytes
    //   Copy of Config settings 1 byte
    //   Config settings 1 byte
    //   STM8 pin_controls 16 bytes
    memset(stored_mqtt_username, 0, 45); // 45 bytes
    
    // Skip 10 bytes (the debug_bytes)
    
    // Altitude 2 bytes
    stored_altitude = 0;

    lock_eeprom();
  }


  // ********************************************************************** //
  // ********************************************************************** //
  // ********************************************************************** //
  //
  // The code above was run if the Magic Number did not match.
  //
  // The next code is run regardless of matching Magic Number.
  //
  // In the next code EEPROM content is copied to RAM variables.
  //
  // ********************************************************************** //
  // ********************************************************************** //
  // ********************************************************************** //

  // Read the values in the EEPROM to initialize the code variables.

  // THE FOLLOWING IS NOW HANDLED IN apply_EEPROM_settings()
//  // Read and use the IP Address from EEPROM
//  uip_ipaddr(IpAddr,
//             stored_hostaddr[3],
//             stored_hostaddr[2],
//             stored_hostaddr[1],
//             stored_hostaddr[0]);
//  uip_sethostaddr(IpAddr);
//    
//  // Read and use the Gateway Address from EEPROM
//  uip_ipaddr(IpAddr,
//             stored_draddr[3],
//             stored_draddr[2],
//             stored_draddr[1],
//             stored_draddr[0]);
//  uip_setdraddr(IpAddr);
//    
//  // Read and use the Netmask from EEPROM
//  uip_ipaddr(IpAddr,
//             stored_netmask[3],
//             stored_netmask[2],
//             stored_netmask[1],
//             stored_netmask[0]);
//  uip_setnetmask(IpAddr);
//
//  // Read and use the MQTT Server IP Address from EEPROM
//  uip_ipaddr(IpAddr,
//             stored_mqttserveraddr[3],
//             stored_mqttserveraddr[2],
//             stored_mqttserveraddr[1],
//             stored_mqttserveraddr[0]);
//  uip_setmqttserveraddr(IpAddr);
//
//
//  // Read and use the MQTT Host Port from EEPROM
//  Port_Mqttd = stored_mqttport;
//
//  // Read and use the HTTP Port from EEPROM
//  Port_Httpd = stored_port;
//    
//  // Read and use the MAC from EEPROM
//  // Set the MAC values used by the ARP code. Note the ARP code uses the
//  // values in reverse order from all the other code.
//  uip_ethaddr.addr[0] = stored_uip_ethaddr_oct[5]; // MSB
//  uip_ethaddr.addr[1] = stored_uip_ethaddr_oct[4];
//  uip_ethaddr.addr[2] = stored_uip_ethaddr_oct[3];
//  uip_ethaddr.addr[3] = stored_uip_ethaddr_oct[2];
//  uip_ethaddr.addr[4] = stored_uip_ethaddr_oct[1];
//  uip_ethaddr.addr[5] = stored_uip_ethaddr_oct[0]; // LSB



#if BUILD_SUPPORT == BROWSER_ONLY_BUILD
  {
    // Check the IO Names in Flash to make sure they are not corrupted. The
    // names must contain only * - . _ 0-9 A-Z a-z
    // If any name is corrupted it is replaced with a name of format "IOxx"
    // where xx is the pin number.  
    //   IO Names might be corrupted if the device is programmed using
    //   "Program/Current Tab" instead of "Program/Address Range".
    //   "Program/Current Tab" will zero out the Flash area where these
    //   variables are stored but will leave a valid magic number in
    //   the EEPROM. If there is already an IO Name stored this code will
    //   not change it. The IO Names might also be corrupted if MQTT code
    //   is replaced with Browser Code, leaving a Magic Number in place but
    //   failing to initialize the IO Names storage area.
    // There are 16 names, 16 bytes each.
    unlock_flash();
    {
      int i;
      int j;
      int fail;
      char temp[16];
      for (i=0; i<16; i++) {
        // Build replacement name in case it is needed
        memset(temp, 0, 16); // Fill temp with null
        strcpy(temp, "IO");
        emb_itoa(i+1, OctetArray, 10, 2);
        strcat(temp, OctetArray);
      
        // Check name for corruption
        fail = 0;
        if (IO_NAME[i][0] == 0) fail = 1; // Name empty - not allowed
        if (magic_number_missing_flag == 1) fail = 1; // New module - must init value.
        for (j = 0; j < 16; j++) {
          if (is_allowed_char(IO_NAME[i][j]) == 0) fail = 1;
        }
        if (fail == 1) {
          // Write the default NAME to Flash
          // Enable Word programming
          FLASH_CR2 |= FLASH_CR2_WPRG;
          FLASH_NCR2 &= (uint8_t)(~FLASH_NCR2_NWPRG);
	  // Write word to Flash
          memcpy(&IO_NAME[i][0], &temp[0], 4); // Write default name
          // No "wait_timer" is needed. The spec says the CPU stalls
          // while the word programming operates (takes about 6ms).
	  
	  // Fill the rest of the field with NULL
          // Enable Word programming
	  {
	    int w;
	    w = 4;
	    while(w<16) {
              FLASH_CR2 |= FLASH_CR2_WPRG;
              FLASH_NCR2 &= (uint8_t)(~FLASH_NCR2_NWPRG);
	      // Write word to Flash
              memset(&IO_NAME[i][w], 0, 4); // Add NULL
              // No "wait_timer" is needed. The spec says the CPU stalls
              // while the word programming operates (takes about 6ms).
	      w += 4;
	    }
	  }
        }
      }
    }
    
    // Initialize Flash memory that is used to store IO Timers for STM8 output
    // pins.
    // If the magic number didn't match all timers are set to zero.
    // IO_TIMER bytes are written 4 bytes at a time to reduce Flash wear
    if (magic_number_missing_flag == 1) {
      int i;
      i = 0;
      while(i<16) {
        // Enable Word programming
        FLASH_CR2 |= FLASH_CR2_WPRG;
        FLASH_NCR2 &= (uint8_t)(~FLASH_NCR2_NWPRG);
	// Write word to Flash
        memset(&IO_TIMER[i], 0, 4); // Fill with null
        // No "wait_timer" is needed. The spec says the CPU stalls
        // while the word programming operates (takes about 6ms).
        i += 4;
      }
    }
    else {
      // If the magic number is present: Any 16 bit value is legitimate in the
      // IO_TIMER values so it is not possible to check for corruption.
    }
    lock_flash();
  
  // THE FOLLOWING IS NOW HANDLED IN apply_EEPROM_settings()
//  // Copy Flash IO_TIMER values to the Pending IO_TIMER variables for STM8
//  // pins
//  memcpy(&Pending_IO_TIMER[0], &IO_TIMER[0], 32);
//
//  // Zero out the pin_timer down counters. Leave the counter unit bits as-is.
//  {
//    int i;
//    for (i=0; i<16; i++) {
//      pin_timer[i] = pin_timer[i] & 0xc000;
//    }
//  }
  }
#endif // BUILD_SUPPORT == BROWSER_ONLY_BUILD


#if DOMOTICZ_SUPPORT == 1
  {
    // Domoticz code uses the IO NAME space in Flash to store Domoticz IDX
    // values for the IO pins attached to the STM8 processor.
    // Domoticz code also uses a separate Flash space to store the IDX values
    // for the DS18B20 and BME280 Sensors.
    // Domoticz code also uses the IO_NAME space in I2C EEPROM to store
    // Domoticz IDX values for the IO pins attached to the PCF8574.
    //
    // The IO_NAME space allocates 16 bytes per pin for IO_NAME storage, or in
    // this case for storage of the IDX values. Even though 16 bytes per pin is
    // allocated, the IDX value is only allowed to be 6 bytes long.
    //
    // The Sensor_IDX space alloacated for the Sensors is 8 bytes per device,
    // but again the IDX values are only allowed to be 6 bytes.
    //
    // The purpose of the code here is to make sure the IDX values stored in the
    // IO_NAME space or in the Sensor_IDX sape are not corrupted. The names must
    // contain only characters 0-9 and must be no longer than 6 bytes. If an IDX
    // value does not meet this requirement it is replaced with a "0".
    //
    // Additionally, if it was determined that the magic number was missing at
    // boot then it is assumed this is a new module and the IDX values will be
    // initialized to "0".
    //
    // IDX values might be corrupted if the device is programmed using "Program/
    // Current Tab" instead of "Program/Address Range 8000-FEBF". "Program/
    // Current Tab" will zero out the Flash area where these variables are
    // stored but will leave a valid magic number in the EEPROM.
    //
    // The IDX values might also be corrupted if Browser code is replaced with
    // Domoticz MQTT Code, leaving a Magic Number in place but failing to
    // initialize the IDX values storage area.
    //
    // If there is already an IDX value stored that meets the spec for an
    // allowed name it will not be changed.
    //
    // Location of IDX storage space from main.h
    // #define FLASH_START_IO_NAMES	0xff00 16x16 = 256 bytes
    // #define FLASH_START_SENSOR_IDX	0xfe80 6x8 = 48 bytes
 
 
    unlock_flash();
    {
      int i;
      int j;
      int fail;
      char temp1[16];
      char temp2[16];
      
      // Build replacement name in case it is needed
      memset(temp1, 0, 16); // Fill temp1 with null
      temp1[0] = '0';       // Set temp1 to string 0
      
      for (i=0; i<22; i++) {
        // Check IDX storage for corruption.
	// There are 16 IO_NAME fields associated with the STM8 IO pins.
	// There are 6 Sensor_IDX fields associated with the Temperature
	// sensors.
	// The 16 IO_NAME fields are repurposed to contain IDX values and are
	// each 16 bytes long, even thought the IDX value stored in the field
	// is a maximum of 6 bytes.
	// The 6 Sensor_IDX fields are dedicated for use as temperature sensor
	// IDX values. The Sensor_IDX fiels are each 8 bytes long even though
	// the IDX value stored in the field is a maximum of 6 bytes.
	
        memset(temp2, 0, 16); // Fill temp2 with null

        if (i < 16) {
	  // Retrieve STM8 IO pin IDX value contained in IO_NAME in Flash.
	  memcpy(temp2, &IO_NAME[i][0], 16);
//	  for (j=0; j<16; j++) {
//	    temp2[j] = IO_NAME[i][j];
//	  }
	}
        else {
	  // Retrieve temperature Sensor IDX value contained in Sensor_ID in
	  // Flash.
          memcpy(temp2, &Sensor_IDX[i - 16][0], 8);
//	  for (j=0; j<8; j++) {
//	    temp2[j] = Sensor_IDX[i-16][j];
//	  }
	}

        // Validate the retreived values.
        fail = 0;
        if (temp2[0] == 0) fail = 1; // Name is empty - not allowed.
        if (temp2[6] != 0) fail = 1; // Name is too long - not allowed.
        if (magic_number_missing_flag == 1) fail = 1; // New module - must init value.
        for (j = 0; j < 16; j++) {
          // Check for digits or NULL only
          if (is_digit(temp2[j]) == 0) fail = 1;
        }

        if (fail == 1) {
          int w;
          // Write the default IDX value to Flash. 8 bytes are written even
          // though we've already assured that the default value is a single
          // character ("0") followed by a terminator.
          // IDX bytes are written 4 bytes at a time to reduce Flash wear.
          // Only 8 bytes need to be written regardless of whether they are
          // stored in the repurposed IO_NAME space or in the Sensor_IDX space.
          w = 0;
	  
	  if (i < 16) {
	    // For IDX values stored in IO_NAME fields write 16 bytes to the
	    // IO_NAME field.
	    while(w < 16) {
              // Enable Word programming
              FLASH_CR2 |= FLASH_CR2_WPRG;
              FLASH_NCR2 &= (uint8_t)(~FLASH_NCR2_NWPRG);
	      // Write word to Flash
	      memcpy(&IO_NAME[i][w], &temp1[w], 4);
              // No "wait_timer" is needed. The spec says the CPU stalls
              // while the word programming operates (takes about 6ms).
              w += 4; // Loop runs twice
	    }
	  }
	  
	  else {
	    // For IDX values stored in Sensor_IDX fields write 8 bytes to the
	    // Sensor_IDX field.
	    while (w < 8) {
              // Enable Word programming
              FLASH_CR2 |= FLASH_CR2_WPRG;
              FLASH_NCR2 &= (uint8_t)(~FLASH_NCR2_NWPRG);
	      // Write word to Flash
	      memcpy(&Sensor_IDX[i - 16][w], &temp1[w], 4);
              // No "wait_timer" is needed. The spec says the CPU stalls
              // while the word programming operates (takes about 6ms).
              w += 4; // Loop runs twice
	    }
	  }
        }
        else {
          // Value already in the IDX Flash storage is valid and we don't need
          // to do anything. Just go on to check the next value.
        }
      }
    }
    lock_flash();
  }
#endif // DOMOTICZ_SUPPORT == 1


/*
#if DOMOTICZ_SUPPORT == 1 && PCF8574_SUPPORT == 1
  {
    {
      int i;
      int j;
      int w;
      char temp1[8];
      char temp2[8];
      int fail;
      
      // Build replacement name in case it is needed
      memset(temp1, 0, 8); // Fill temp with null
      temp1[0] = '0');
      
      for (i=16; i<24; i++) {
        // Read a PCF8574_IO_NAME value from I2C EEPROM. These are repurposed
        // to contain IDX values.
        // Checking the 8 IDX fields associated with the PCF8574 IO pins.
        // Note: If PCF8574 is not supported (as in the MQTT Domoticz Standard
        // build) then later code that attempts access to IO_NAME 16 to 23 will
        // substitute "0" for the field.
        copy_I2C_EEPROM_bytes_to_RAM(&temp2[0], 8, I2C_EEPROM_R2_WRITE, I2C_EEPROM_R2_READ, PCF8574_I2C_EEPROM_R2_START_IO_NAMES + ((i - 16) * 16), 2);
        
        // Check name for corruption
        fail = 0;
        if (temp2[0] == 0) fail = 1; // Name is empty - not allowed.
        if (temp2[6] != 0) fail = 1; // Name is too long - not allowed.
        if (magic_number_missing_flag == 1) fail = 1; // New module - must init value.
        for (j = 0; j < 8; j++) {
          // Check for digits or NULL only
	  if (temp2[j] != 0) {
            if (is_digit(temp2[j]) == 0) fail = 1;
	  }
        }
      
        if (fail == 1) {
          // Write the default NAME to I2C EEPROM
          copy_STM8_bytes_to_I2C_EEPROM(&temp1[0], 8, I2C_EEPROM_R2_WRITE, PCF8574_I2C_EEPROM_R2_START_IO_NAMES + ((i - 16) * 16), 2);
        }
      }
    }
  }
#endif // DOMOTICZ_SUPPORT == 1 && PCF8574_SUPPORT == 1
*/


#if LINKED_SUPPORT == 1
  {
    // Linked pin check:
    //    Verify that there is no corruption in the EEPROM in the form of
    //    Linked pins that do not have a partner (for example, pin 1 is
    //    defined as Linked, but the partner pin 9 is not defined as Linked).
    //    In such a case the EEPROM should have both pins set to Disabled.
    //    Note: I think this could only happen if a user made manual edits to
    //    the EEPROM, or if the GUI update process was interrupted by a power
    //    fail.
    int i;
    for (i=0; i<8; i++) {
      if (((stored_pin_control[i] & 0x03) == 0x02) || ((stored_pin_control[i+8] & 0x03) == 0x02)) {
        // At least one pin is defined as Linked
        if ((stored_pin_control[i] & 0x03) != (stored_pin_control[i+8] & 0x03)) {
	  // One of the pins is not defined as Linked. Set both pins to Disabled.
	  unlock_eeprom();
	  stored_pin_control[i] = 0x00;
	  stored_pin_control[i+8] = 0x00;
	  lock_eeprom();
	}
        // else do nothing - the settings are OK.
      }
      // else do nothing - the settings are OK.
    }
  }
#endif // LINKED_SUPPORT == 1


  // Read the pin_control bytes from EEEPROM for STM8 pins
  {
    int i;
    for (i=0; i<16; i++) pin_control[i] = stored_pin_control[i];
  }


#if LINKED_SUPPORT == 0
  {
    // Check the "Retain/On/Off at Boot" settings and force the ON/OFF state
    // accordingly. Do this on Outputs only.
    int i;
    for (i=0; i<16; i++) {
      if (((pin_control[i] & 0x08) == 0x00) && ((pin_control[i] & 0x03) == 0x03)) {
        // Retain is not set and this is an output
        if ((pin_control[i] & 0x10) == 0x00) {
          // Force ON/OFF to zero
          pin_control[i] &= 0x7f;
        }
        else if ((pin_control[i] & 0x10) == 0x10) {
          // Force ON/OFF to one
          pin_control[i] |= 0x80;
        }
        // else Retain the ON/OFF bit
      }
    }
  }
#endif // LINKED_SUPPORT == 0


#if LINKED_SUPPORT == 1
  {
    // Check the "Retain/On/Off at Boot" settings and force the ON/OFF state
    // accordingly. Do this on Outputs only.
    int i;
    for (i=0; i<16; i++) {
      if (chk_iotype(pin_control[i], i, 0x0b) == 0x03) {
        // Pin is an Output and Retain is not set
        if ((pin_control[i] & 0x18) == 0x00) {
          // Retain is not set, and Force Zero is indicated
          pin_control[i] &= 0x7f;
        }
        else if ((pin_control[i] & 0x18) == 0x10) {
          // Retain is not set, and Force One is indicated
          pin_control[i] |= 0x80;
        }
      }
      // else do nothing so that the ON/OFF bit is retained
    }
  }
#endif // LINKED_SUPPORT == 1

  // THE FOLLOWING IS NOW HANDLED IN apply_EEPROM_settings()
//  // Update Pending_pin_control bytes
//  // Do NOT update the stored_pin_control at this point as we've only
//  // manipulated the output state and we don't want to update the output
//  // state in the stored_pin_control if Retain is turned on. That will be
//  // handled later in the check_runtime_changes() function.
//  for (i=0; i<16; i++) Pending_pin_control[i] = pin_control[i];
//
//
//  for (i=0; i<4; i++) {
//    Pending_hostaddr[i] = stored_hostaddr[i];
//    Pending_draddr[i] = stored_draddr[i];
//    Pending_netmask[i] = stored_netmask[i];
//    Pending_mqttserveraddr[i] = stored_mqttserveraddr[i];
//  }
//  
//  Pending_port = stored_port;
//  Pending_mqttport = stored_mqttport;
//  
//  memcpy(&Pending_devicename[0], &stored_devicename[0], 20);

  // ---------------------------------------------------------------------- //
  // Verify that the stored_config_settings and stored_options are
  // compatible with the build selected. The reason for this is that a new
  // code load can be applied and the previous code load may have used
  // config_settings or options that are incompatible with the new code load.
  // For instance, suppose that a standard MQTT build is used and Pinout
  // Option 2 is selected. Then an upgradeable MQTT build is applied. Pinout
  // Option 1 is the only Pinout Option allowed with an upgradeable MQTT
  // build.
  // ---------------------------------------------------------------------- //
  
#if BUILD_TYPE_MQTT_HOME_STANDARD == 1
  {
    uint8_t i;
    // Validate stored_config_settings
    i = stored_config_settings;
    i &= 0xdf; // Turn off BME280
    update_settings_options(UPDATE_CONFIG_SETTINGS, i);
    // Validate stored_options
    i = stored_options1;
    i &= 0xd7; // Turn off PCF8574
    update_settings_options(UPDATE_OPTIONS1, i);
  }
#endif // BUILD_TYPE_MQTT_HOME_STANDARD == 1

#if BUILD_TYPE_MQTT_DOMO_STANDARD == 1
  {
    uint8_t i;
    // Validate stored_config_settings
    i = stored_config_settings;
    i &= 0xdd; // Turn off BME280, turn off Home Assistant Auto Discovery
    // stored_config_settings
    // Bit 7: Undefined, 0 only
    // Bit 6: Undefined, 0 only
    // Bit 5: BME280
    // Bit 4: Disable Cfg Button
    // Bit 3: DS18B20
    // Bit 2: MQTT
    // Bit 1: Home Assistant Auto Discovery
    // Bit 0: Duplex
    update_settings_options(UPDATE_CONFIG_SETTINGS, i);
    // Validate stored_options
    i = stored_options1;
    i &= 0xd7; // Turn off PCF8574
    update_settings_options(UPDATE_OPTIONS1, i);
  }
#endif // BUILD_TYPE_MQTT_DOMO_STANDARD == 1

#if BUILD_TYPE_BROWSER_STANDARD == 1
  {
    uint8_t i;
    // Validate stored_config_settings
    i = stored_config_settings;
    i &= 0xd9; // Turn off BME280, Turn off MQTT, Turn off HA
    update_settings_options(UPDATE_CONFIG_SETTINGS, i);
    // Validate stored_options
    i = stored_options1;
    i &= 0xf7; // Turn off PCF8574
    update_settings_options(UPDATE_OPTIONS1, i);
  }
#endif // BUILD_TYPE_BROWSER_STANDARD == 1

#if BUILD_TYPE_MQTT_HOME_UPGRADEABLE == 1
  {
    uint8_t i;
    // Validate stored_config_settings
    i = stored_config_settings;
    i &= 0xdf; // Turn off BME280
    update_settings_options(UPDATE_CONFIG_SETTINGS, i);
    // Validate stored_options
    i = stored_options1;
    i &= 0xf9; // Force to Pinout Option 1
               // Note: Don't touch the PCF8574 enable bit. If already
	       // enabled it can be left enabled. If not enabled, the
	       // PCF8574_init() function in startup code will check if it
	       // should be enabled or disabled.
    update_settings_options(UPDATE_OPTIONS1, i);
  }
#endif // BUILD_TYPE_MQTT_HOME_UPGRADEABLE == 1

#if BUILD_TYPE_MQTT_DOMO_UPGRADEABLE == 1
  {
    uint8_t i;
    // Validate stored_config_settings
    i = stored_config_settings;
    i &= 0xdd; // Turn off BME280, Turn off Home Assistant Auto Discovery
    update_settings_options(UPDATE_CONFIG_SETTINGS, i);
    // Validate stored_options
    i = stored_options1;
    i &= 0xf9; // Force to Pinout Option 1
               // Note: Don't touch the PCF8574 enable bit. If already
	       // enabled it can be left enabled. If not enabled, the
	       // PCF8574_init() function in startup code will check if it
	       // should be enabled or disabled.
    update_settings_options(UPDATE_OPTIONS1, i);
  }
#endif // BUILD_TYPE_MQTT_DOMO_UPGRADEABLE == 1

#if BUILD_TYPE_BROWSER_UPGRADEABLE == 1
  {
    uint8_t i;
    // Validate stored_config_settings
    i = stored_config_settings;
    i &= 0xd9; // Turn off BME280, Turn off MQTT, Turn off HA
    update_settings_options(UPDATE_CONFIG_SETTINGS, i);
    // Validate stored_options
    i = stored_options1;
    i &= 0xf9; // Force to Pinout Option 1
               // Note: Don't touch the PCF8574 enable bit. If already
	       // enabled it can be left enabled. If not enabled, the
	       // PCF8574_init() function in startup code will check if it
	       // should be enabled or disabled.
    update_settings_options(UPDATE_OPTIONS1, i);
  }
#endif // BUILD_TYPE_BROWSER_UPGRADEABLE == 1

#if BUILD_TYPE_MQTT_HOME_BME280_UPGRADEABLE == 1
  {
    uint8_t i;
    // Validate stored_config_settings
    i = stored_config_settings;
    i &= 0xf7; // Turn off DS18B20
    update_settings_options(UPDATE_CONFIG_SETTINGS, i);
    // Validate stored_options
    i = stored_options1;
    i &= 0xf1; // Turn off PCF8574, Force to Pinout Option 1
    update_settings_options(UPDATE_OPTIONS1, i);
  }
#endif // BUILD_TYPE_MQTT_HOME_BME280_UPGRADEABLE == 1

#if BUILD_TYPE_MQTT_DOMO_BME280_UPGRADEABLE == 1
  {
    uint8_t i;
    // Validate stored_config_settings
    i = stored_config_settings;
    i &= 0xf7; // Turn off DS18B20
    update_settings_options(UPDATE_CONFIG_SETTINGS, i);
    // Validate stored_options
    i = stored_options1;
    i &= 0xf1; // Turn off PCF8574, Force to Pinout Option 1
    update_settings_options(UPDATE_OPTIONS1, i);
  }
#endif // BUILD_TYPE_MQTT_DOMO_BME280_UPGRADEABLE == 1

#if BUILD_TYPE_CODE_UPLOADER == 1
// XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
// XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
// XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
// XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
// XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
// XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
//  {
//    uint8_t i;
//    // Validate stored_options2
//    // If new code is loaded the Login function must be disabled to prevent
//    // inadvertant lockout.
//    i = stored_options2;
//    i &= 0xbf; // Turn off the Login function
//    update_settings_options(UPDATE_OPTIONS2, i);
//  }
#endif // BUILD_TYPE_MQTT_DOMO_BME280_UPGRADEABLE == 1

  // THE FOLLOWING IS NOW HANDLED IN apply_EEPROM_settings()
//  Pending_config_settings = stored_config_settings;
//
//  memcpy(&Pending_uip_ethaddr_oct[0], &stored_uip_ethaddr_oct[0], 6);
//
//  for (i=0; i<11; i++) {
//    Pending_mqtt_username[i] = stored_mqtt_username[i];
//    Pending_mqtt_password[i] = stored_mqtt_password[i];
//  }
//  
//  // Update the MAC string. This updates a global.
//  update_mac_string();
//  
//#if BUILD_SUPPORT == MQTT_BUILD
//  // If the MQTT Enable bit is set in the Config settings set the mqtt_enabled
//  // bit so that the MQTT feature is enabled. This is needed even if no pins
//  // are enabled so that the temperature sensor reporting will work.
//  if (stored_config_settings & 0x04) mqtt_enabled = 1;
//#endif // BUILD_SUPPORT == MQTT_BUILD

}







void apply_EEPROM_settings(void)
{
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


  // Read and use the MQTT Host Port from EEPROM
  Port_Mqttd = stored_mqttport;

  // Read and use the HTTP Port from EEPROM
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
  
  
#if BUILD_SUPPORT == BROWSER_ONLY_BUILD
  {
    // Copy Flash IO_TIMER values to the Pending IO_TIMER variables for STM8
    // pins
    memcpy(&Pending_IO_TIMER[0], &IO_TIMER[0], 32);
    
    // Zero out the pin_timer down counters. Leave the counter unit bits as-is.
    {
      int i;
      for (i=0; i<16; i++) {
        pin_timer[i] = pin_timer[i] & 0xc000;
      }
    }
  }
#endif BUILD_SUPPORT == BROWSER_ONLY_BUILD

  // Update Pending_pin_control bytes
  // Do NOT update the stored_pin_control at this point as we've only
  // manipulated the output state and we don't want to update the output
  // state in the stored_pin_control if Retain is turned on. That will be
  // handled later in the check_runtime_changes() function.
  {
    int i;
    for (i=0; i<16; i++) Pending_pin_control[i] = pin_control[i];
  }


//  {
//    int i;
//    for (i=0; i<4; i++) {
//      Pending_hostaddr[i] = stored_hostaddr[i];
//      Pending_draddr[i] = stored_draddr[i];
//      Pending_netmask[i] = stored_netmask[i];
//      Pending_mqttserveraddr[i] = stored_mqttserveraddr[i];
//    }
//  }
//  
//  Pending_port = stored_port;
//  Pending_mqttport = stored_mqttport;
//  
//  memcpy(&Pending_devicename[0], &stored_devicename[0], 20);




  Pending_config_settings = stored_config_settings;

//  memcpy(&Pending_uip_ethaddr_oct[0], &stored_uip_ethaddr_oct[0], 6);

//  {
//    int i;
//    for (i=0; i<11; i++) {
//      Pending_mqtt_username[i] = stored_mqtt_username[i];
//      Pending_mqtt_password[i] = stored_mqtt_password[i];
//    }
//  }
  
  // Update the MAC string. This updates a global.
  update_mac_string();
}






void apply_PCF8574_pin_settings(void)
{
// #if PCF8574_SUPPORT == 0
//   // If PCF8574 support is not in the build this function will set the
//   // pin_control bytes for the PCF8574 pins to the default (00). This
//   // covers the case where the Network Module previously had code on it
//   // that had PCF8574 support, but now is loaded with code that does not
//   // have PCF8574 support.
//   {
//     int i;
//     for (i=16; i<24; i++) {
//       pin_control[i] = 0;
//     }
//   }
// #endif // PCF8574_SUPPORT == 0

#if PCF8574_SUPPORT == 1
  {
    // If PCF8574 support is in the build this function updates the PCF8574 pin
    // settings in I2C EEPROM. The check_runtime_chages() function will be
    // called from the main.c loop to actually write the Output pins on the STM8
    // and PCF8574.
    
    // With the exception of a few lines of code at the very end of this
    // function this code is ONLY used when PCF8574_SUPPORT is compiled.
    
    // PCF8574 pin settings are:
    //   pin_control bits
    //   IO_NAMES
    //   IO_TIMERS
    // This cannot run until after gpio_init() is run because the PCF8574
    // function needs to access the I2C EEPROM via the I2C bus on pins 14
    // and 15.
    
    // Some functionality needs to run first if check_eeprom_settings() found
    // that there was no Magic Number in the EEPROM.
    
#if BUILD_SUPPORT == BROWSER_ONLY_BUILD
    {
      if (magic_number_missing_flag == 1) {
        // check_eeprom_settings() did not find a Magic Number at boot time. The
        // check_eeprom_settings() function will have established the Magic
        // Number, but this function still needs to provide initialization of
        // the PCF8574 settings and variables.
        
        // Initialize I2C EEPROM memory that is used to store pin_control
        // values for PCF8574 pins.
        // Since the magic number didn't match all pins are set to zero.
        {
          uint8_t i = 0;
          copy_STM8_bytes_to_I2C_EEPROM(&i, 8, I2C_EEPROM_R2_WRITE, PCF8574_I2C_EEPROM_R2_PIN_CONTROL_STORAGE, 2);
        }
      
      
        // Initialize I2C EEPROM memory that is used to store IO Timers for
        // PCF8574 output pins.
        // Since the magic number didn't match all timers are set to zero.
        // There are 8 timers, 4 bytes each. Write 0 to 32 bytes.
        {
          uint8_t i = 0;
          copy_STM8_bytes_to_I2C_EEPROM(&i, 32, I2C_EEPROM_R2_WRITE, PCF8574_I2C_EEPROM_R2_START_IO_TIMERS, 2);
        }
      
      
        // Initialize I2C EEPROM memory that is used to store IO Names for
        // PCF8574 output pins.
        // Since the magic number didn't match all names are set to default.
        // There are 8 names, 16 bytes each. Write 128 bytes.
        I2C_control(I2C_EEPROM_R2_WRITE);
        I2C_byte_address(PCF8574_I2C_EEPROM_R2_START_IO_NAMES, 2);
        {
          char temp[16];
          int i;
          int j;
          for (i=16; i<24; i++) {
            memset(temp, 0, 16); // Fill temp with null
            strcpy(temp, "IO");
            emb_itoa(i+1, OctetArray, 10, 2);
            strcat(temp, OctetArray);
            for (j=0; j<16; j++) {
              I2C_write_byte(temp[j]);
            }
          }
        }
        I2C_stop(); // Start the EEPROM internal write cycle
        wait_timer(5000); // Wait 5ms
      }
    }
#endif // BUILD_SUPPORT == BROWSER_ONLY_BUILD
  
  
    // With the exception of a few items the following code runs regardless of
    // whether a Magic Number was present at boot.
  
#if BUILD_SUPPORT == BROWSER_ONLY_BUILD
    {
      // Check the IO Names in I2C EEPROM to make sure they are not corrupted. The
      // names must contain only * - . _ 0-9 A-Z a-z
      // If any name is corrupted it is replaced with a name of format "IOxx"
      // where xx is the pin number.
      //   The IO Names might be corrupted if MQTT code is replaced with Browser
      //   Code, leaving a Magic Number in place but failing to initialize the
      //   IO Names storage area.
      //   If there is already a valid IO Name stored this code will not change
      //   it.
      // There are 8 names, 16 bytes each.
      {
        int i;
        int j;
        int fail;
        char temp[16];
        for (i=0; i<8; i++) {
          // Read IO_NAME
          fail = 0;
          prep_read(I2C_EEPROM_R2_WRITE, I2C_EEPROM_R2_READ, PCF8574_I2C_EEPROM_R2_START_IO_NAMES + (i * 16), 2);
          for (j=0; j<15; j++) {
            temp[j] = I2C_read_byte(0);
          }
          temp[15] = I2C_read_byte(1);
	  
	  // Validate the IO_NAME
          if (temp[0] == 0) fail = 1; // Empty name, not allowed.
          if (temp[15] != 0) fail = 1; // Name too long, not allowed.
	  for (j = 0; j < 16; j++) {
	    // All fields must be allowed characters or null
            if (is_allowed_char(temp[i]) == 0) fail = 1; // Disallowed character
          }
          
          if (fail) {
            // Build the default NAME
            memset(temp, 0, 16); // Fill temp with null
            strcpy(temp, "IO");
            emb_itoa(i+17, OctetArray, 10, 2);
            strcat(temp, OctetArray);
            // Write the default NAME to I2C EEPROM      
            copy_STM8_bytes_to_I2C_EEPROM(&temp[0], 16, I2C_EEPROM_R2_WRITE, PCF8574_I2C_EEPROM_R2_START_IO_NAMES + (i * 16), 2);
          }
        }
      }
  
      // IO_TIMER check: Any 16 bit value is legitimate in the IO_TIMER values so
      // it is not possible to check for corruption.
      
      // Copy I2C EEPROM IO_TIMER values to the Pending IO_TIMER variables for
      // PCF8574 pins
      {
        int i;
        uint8_t j;
        uint16_t temp;
        
        j = 0;
        prep_read(I2C_EEPROM_R2_WRITE, I2C_EEPROM_R2_READ, PCF8574_I2C_EEPROM_R2_START_IO_TIMERS, 2);
        for (i=0; i<8; i++) {
          temp = I2C_read_byte(j);       // Read upper byte
          temp = temp << 8;
          if (i == 7) j = 1;             // Signal read of last byte
          temp |= I2C_read_byte(j);      // Read lower byte
          Pending_IO_TIMER[i+16] = temp;
        }
      }
    
      // Zero out the pin_timer down counters. Leave the counter unit bits as-is.
      {
        int i;
        for (i=16; i<24; i++) {
          pin_timer[i] = pin_timer[i] & 0xc000;
        }
      }
    }
#endif // BUILD_SUPPORT == BROWSER_ONLY_BUILD


#if DOMOTICZ_SUPPORT == 1
    {
      // Validate the PCF8574 IO Names (used in Domoticz as IDX values) that
      // are stored in I2C EEPROM. The IDX values must contain only digits 0-9
      // and must not be longer than 6 digits. If any value is invalid it is
      // replaced with "0".
      //   The IO Names might be corrupted if Browser code is replaced with
      //   MQTT code, leaving a Magic Number in place but failing to
      //   initialize the IO Names storage area.
      //   If there is already a valid IO Name stored this code will not
      //   change it.
      // There are 8 IDX values, each 6 bytes long, stored in IO_NAME fields
      // that have 16 bytes allocated to each. All 16 bytes are checked to
      // assure the fields are properly cleared out.
      {
        int i;
        int j;
        int fail;
        char temp1[16];
        char temp2[16];
	
        // Build the default IDX value
        memset(temp1, 0, 16); // Fill temp with null
        temp1[0] = '0';
	
        for (i=0; i<8; i++) {
          fail = 0;
          // Read existing IO_NAME fields from I2C EEPROM.
          prep_read(I2C_EEPROM_R2_WRITE, I2C_EEPROM_R2_READ, PCF8574_I2C_EEPROM_R2_START_IO_NAMES + (i * 16), 2);
          for (j=0; j<15; j++) {
            temp2[j] = I2C_read_byte(0);
          }
          temp2[15] = I2C_read_byte(1);
          // Validate entire field
          for (j=0; j<16; j++) {
            if (temp2[0] == 0) fail = 1; // Empty name, not allowed
            if (temp2[6] != 0) fail = 1; // Name too long, not allowed
	    if (j < 7) {
	      // First 7 bytes must all be digits or null
              if (is_digit(temp2[j]) == 0) fail = 1;
	    }
	    if (j > 6) {
	      // All remaining bytes must be mull
              if (temp2[j] != 0) fail = 1;
	    }
          }
          
          if (fail == 1) {
            // Write the default IDX value to I2C EEPROM      
            copy_STM8_bytes_to_I2C_EEPROM(&temp1[0], 16, I2C_EEPROM_R2_WRITE, PCF8574_I2C_EEPROM_R2_START_IO_NAMES + (i * 16), 2);
          }
        }
      }
    }
#endif // DOMOTICZ_SUPPORT == 1
    
  
    // Read the pin_control bytes from I2C EEPROM for the PCF8574 pins
    {
      int i;
      prep_read(I2C_EEPROM_R2_WRITE, I2C_EEPROM_R2_READ, PCF8574_I2C_EEPROM_R2_PIN_CONTROL_STORAGE, 2);
      for (i=16; i<23; i++) {
        pin_control[i] = I2C_read_byte(0);
      }
      pin_control[23] = I2C_read_byte(1);
    }
    
  
#if LINKED_SUPPORT == 1
    {
      // Linked pin check:
      //    Verify that there is no corruption in the EEPROM in the form of
      //    Linked pins that do not have a partner (for example, pin 1 is
      //    defined as Linked, but the partner pin 9 is not defined as Linked).
      //    In such a case the EEPROM should have both pins set to Disabled.
      //    Note: I think this could only happen if a user made manual edits to
      //    the EEPROM, or if the GUI update process was interrupted by a power
      //    fail.
      int i;
      uint8_t j;
      uint16_t byte_address_1;
      uint16_t byte_address_2;
      uint8_t byte_1;
      uint8_t byte_2;
        
      for (i=0; i<4; i++) {
        // Read stored_pin_control from I2C EEPROM for the partner input and
        // output pins.
        byte_address_1 = (uint16_t)(PCF8574_I2C_EEPROM_R2_PIN_CONTROL_STORAGE + i);
        prep_read(I2C_EEPROM_R2_WRITE, I2C_EEPROM_R2_READ, byte_address_1, 2);
        byte_1 = I2C_read_byte(1);
        byte_address_2 = (uint16_t)(PCF8574_I2C_EEPROM_R2_PIN_CONTROL_STORAGE + i + 4);
        prep_read(I2C_EEPROM_R2_WRITE, I2C_EEPROM_R2_READ, byte_address_2, 2);
        byte_2 = I2C_read_byte(1);
  
        if (((byte_1 & 0x03) == 0x02) || ((byte_2 & 0x03) == 0x02)) {
          // At least one pin is defined as Linked
          if ((byte_1 & 0x03) != (byte_2 & 0x03)) {
            // One of the pins is not defined as Linked. Set both pins to Disabled.
            // Pin is linked. Change it to Disabled.
	    j = 0;
            copy_STM8_bytes_to_I2C_EEPROM(&j, 1, I2C_EEPROM_R2_WRITE, byte_address_1, 2);
            copy_STM8_bytes_to_I2C_EEPROM(&j, 1, I2C_EEPROM_R2_WRITE, byte_address_2, 2);
         }
          // else do nothing - the settings are OK.
        }
        // else do nothing - the settings are OK.
      }
    }
#endif // LINKED_SUPPORT == 1
  
  
#if LINKED_SUPPORT == 0
    {
      // Check the "Retain/On/Off at Boot" settings and force the ON/OFF state
      // accordingly. Do this on Outputs only.
      int i;
      for (i=16; i<24; i++) {
        if (((pin_control[i] & 0x08) == 0x00) && ((pin_control[i] & 0x03) == 0x03)) {
          // Retain is not set and this is an output
          if ((pin_control[i] & 0x10) == 0x00) {
            // Force ON/OFF to zero
            pin_control[i] &= 0x7f;
          }
          else if ((pin_control[i] & 0x10) == 0x10) {
            // Force ON/OFF to one
            pin_control[i] |= 0x80;
          }
          // else Retain the ON/OFF bit
        }
      }
    }
#endif // LINKED_SUPPORT == 0
  
#if LINKED_SUPPORT == 1
    // Check the "Retain/On/Off at Boot" settings and force the ON/OFF state
    // accordingly. Do this on Outputs only.
    {
      int i;
      for (i=16; i<24; i++) {
        if (chk_iotype(pin_control[i], i, 0x0b) == 0x03) {
          // Pin is an Output and Retain is not set
          if ((pin_control[i] & 0x18) == 0x00) {
            // Retain is not set, and Force Zero is indicated
            pin_control[i] &= 0x7f;
          }
          else if ((pin_control[i] & 0x18) == 0x10) {
            // Retain is not set, and Force One is indicated
            pin_control[i] |= 0x80;
          }
        }
        // else do nothing so that the ON/OFF bit is retained
      }
    }
#endif // LINKED_SUPPORT == 1
  
    // Update PCF8574 Pending_pin_control bytes
    // Do NOT update the stored_pin_control at this point as we've only
    // manipulated the output state and we don't want to update the output
    // state in the stored_pin_control if Retain is turned on. That will be
    // handled later in the check_runtime_changes() function.
    {
      int i;
      for (i=16; i<24; i++) {
        Pending_pin_control[i] = pin_control[i];
      }
    }
  }
#endif // PCF8574_SUPPORT == 1
}


void initialize_pins(void) {
  // Initialize pins and IO state trackers for the first time after
  // validation of EEPROM and I2C EEPROM contents. This operates on
  // STM8 and PCF8574 pins.
  
  // Initialize bit register versions of the ON/OFF and Invert pin control
  // information
  encode_bit_registers(1);
    
  // Initialize IO ON/OFF state tracking. ON_OFF_WORD was initialized in
  // encode_bit_registers().
  ON_OFF_word_new1 = ON_OFF_word_new2 = ON_OFF_word_sent = ON_OFF_word;
    
  // Set Output pins
  write_output_pins();
}


uint8_t is_allowed_char(uint8_t character)
{
  // Checks that a character is permissible in a specific string.
  if ((character >= 48 && character <=57)   // 0 to 9
   || (character >= 65 && character <=90)   // A to Z
   || (character >= 97 && character <=122)  // a to z
   || (character == 42)                     // * (asterisk)
   || (character == 45)                     // - (dash)
   || (character == 46)                     // . (period)
   || (character == 95)                     // _ (underbar)
   || (character == 0)) {                   // NULL
    return (1);
  }
  else return(0);
}


uint8_t is_digit(uint8_t character)
{
  // Checks that a character is permissible in a specific string.
  // Return 1 if all digits or null
  // Return 0 if test is not met
  if ((character >= 48 && character <= 57)   // 0 to 9
   || (character == 0)) {                   // NULL
    return (1);
   }
  else return(0);
}


void update_mac_string(void)
{
  // Function to turn the uip_ethaddr values into a single string containing
  // the MAC address
  int i;
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
  //-------------------------------------------------------------------------//
  // Step 1:
  // Read the input registers and update the input state in the pin_control
  // values as needed.
  // 
  // Step 2:
  // Validate the user selected IO pinout. If DS18B20, BME280, any I2C
  // functionality, or the UART are being used then the only valid pinout is
  // Option 1.
  //   Note: Since this check occurs after the "read input registers" step
  //   there may be a problem if the pin option is forced to change due to
  //   the user deciding to use a reserved pin. Since the user is making
  //   concious decisions about reserved pins I don't think this will be
  //   very confusing.
  //
  // Step 3:
  // Check if the DS18B20 feature is enabled. If yes over-ride the
  // pin_control byte settings for IO 16 to force them to all zero. This
  // forces the disabled state so the DS18B20 code can utilize the pin for
  // temperature sensor communication.
  //
  // Step 4:
  // If BME280 is not supported but the user has requested BME280 support on
  // the Configuration page then deselect the BME280 support request in the
  // Configuration byte.
  //
  // Step 4:
  // Check if I2C functionality is enabled. If yes over-ride the pin_control
  // byte settings for pins 14 and 15 to force them to all zero. This forces
  // the disabled state so that the I2C code can utilize the pin for I2C
  // communication.
  //
  // Step 5:
  // Check if the UART is enabled. If yes over-ride the pin_control byte
  // settings for IO 11 to force them to all zero. This forces the disabled
  // state so the UART code can utilize the pin for UART communication.
  //
  // Step 6:
  // Validate the Linked Pins configuration. If pins are not properly linked
  // set them back to their prior pin_control value (invalidates the incorrect
  // changes made by the user).
  //
  // Step 7:
  // If Linked Pins are enabled check for any edges that may have occurred on
  // linked input pins. This is done at this step to allow a valid input
  // to be treated as a pending output change by the rest of the runtime
  // changes code.
  //
  // Step 8:
  // Manage Output pin Timers. Change Output pin states and Timers as
  // appropriate.
  //
  // Step 9:
  // Check if the user requested changes to Device Name, Output States, IP
  // Address, Gateway Address, Netmask, Port, or MAC. If a change occurred
  // update the appropriate variables and output controls, and store the new
  // values in EEPROM.

  uint8_t update_EEPROM;

  read_input_pins(0);


#if PINOUT_OPTION_SUPPORT == 1
  // Only pinout Option 1 is allowed if any reserved pins are in use. There
  // can be a bit of a chicken-and-egg problem here as the user might already
  // have reserved pins in use and then selects an alternative pinout, OR the
  // user might select a reserved pin function while an alternative pinout is
  // already in place. Either case will invalidate use of an alternative
  // pinout.
  
  // Note: The build map in uipopt.h does not allow a build that has both
  // PINOUT_OPTION_SUPPORT and I2C_SUPPORT, so we don't need to check that.
  // And code in the httpd.c file will force the use of Pinout Option 1 if
  // the UART is enabled. So here we only need to check if the user tried to
  // enable DS18B20 or BME280 on pin 16.
  
  // If a pinout other than Option 1 is in use then don't allow the user to
  // enable DS18B20. If DS18B20 was already enabled and the user then selected
  // a pinout other than Option 1 then disable DS18B20.
  if ((Pending_config_settings & 0x08) || (stored_config_settings & 0x08)) {
    // User has requested that DS18B20 functionality be enabled, or DS18B20
    // was already enabled in the config settings. DS18B20 is only allowed if
    // pinout Option 1 is being used.
    if ((stored_options1 & 0x07) > 1) {
      Pending_config_settings &= (uint8_t)~0x08;
      // If DS18B20 is enabled in the stored_config_settings it will be
      // disabled in code further below.
    }
  }
  if ((Pending_config_settings & 0x20) || (stored_config_settings & 0x20)) {
    // User has requested that BME280 functionality be enabled, or BME280
    // was already enabled in the config settings. BME280 is only allowed if
    // pinout Option 1 is being used.
    if ((stored_options1 & 0x07) > 1) {
      Pending_config_settings &= (uint8_t)~0x20;
      // If BME280 is enabled in the stored_config_settings it will be
      // disabled in code further below.
    }
  }
#endif // PINOUT_OPTION_SUPPORT == 1


#if DS18B20_SUPPORT == 1
  // Check the DS18B20 Enable bit. If enabled over-ride the pin_control byte
  // bits for IO 16 to force them to all zero. This forces the disabled
  // state for IO 16 and makes sure all other bits are in a neutral condition
  // should the DS18B20 function be Disabled at some future time.
  if (Pending_config_settings & 0x08) {
    pin_control[15] = Pending_pin_control[15] = (uint8_t)0x00;
    // Update the stored_pin_control[] variables
    unlock_eeprom();
    if (stored_pin_control[15] != pin_control[15]) {
      stored_pin_control[15] = pin_control[15];
    }
    lock_eeprom();
  }
#endif // DS18B20_SUPPORT == 1


#if BME280_SUPPORT == 0
  // If BME280 is not supported do not allow a user request to enable BME280
  // in the Pending_config_settings.
  Pending_config_settings &= (uint8_t)(~0x20);
#endif // BME280_SUPPORT == 0


#if I2C_SUPPORT == 1
  // If I2C functionality is enabled disable pins 14 and 15 so that they can
  // be used by the I2C function.
  // This check is run here in case the user tried to change the pin state
  // from Disabled in the GUI. This will force the state back to Disabled.
  pin_control[13] = Pending_pin_control[13] = (uint8_t)0x00;
  pin_control[14] = Pending_pin_control[14] = (uint8_t)0x00;
  // Update the stored_pin_control[] variables
  unlock_eeprom();
  if (stored_pin_control[13] != pin_control[13]) {
    stored_pin_control[13] = pin_control[13];
  }
  if (stored_pin_control[14] != pin_control[14]) {
    stored_pin_control[14] = pin_control[14];
  }
  lock_eeprom();
#endif // I2C_SUPPORT == 1


#if DEBUG_SUPPORT == 15
  // If UART functionality is enabled disable pin 11 so that it can be used
  // for the UART transmit pin.
  // This check is run here in case the user tried to change the pin state
  // from Disabled in the GUI. This will force the state back to Disabled.
  pin_control[10] = Pending_pin_control[10] = (uint8_t)0x00;
  // Update the stored_pin_control[] variables
  unlock_eeprom();
  if (stored_pin_control[10] != pin_control[10]) {
    stored_pin_control[10] = pin_control[10];
  }
  lock_eeprom();
#endif // DEBUG_SUPPORT == 15


#if LINKED_SUPPORT == 1
  {
    int i;
    // Check the Pending_pin_controls for Linked pins to make sure that
    // Linking is applied to appropriate partner pins.
    // First check the STM8 pins
    for (i=0; i<8; i++) {
      if (((Pending_pin_control[i] & 0x03) == 0x02) || ((Pending_pin_control[i+8] & 0x03) == 0x02)) {
        // At least one pin is in the process of being defined as Linked
        if ((Pending_pin_control[i] & 0x03) != (Pending_pin_control[i+8] & 0x03)) {
	  // One of the pins is not defined as Linked. Set both pins to the
	  // pin type value stored in EEPROM. This should just have the effect
	  // of invalidating the Pending request.
	  Pending_pin_control[i] = stored_pin_control[i];
	  Pending_pin_control[i+8] = stored_pin_control[i+8];
	}
        // else do nothing - the settings are OK.
      }
      // else do nothing - the settings are OK.
    }
#if PCF8574_SUPPORT == 1
    {
      // Check the PCF8574 pins
      int i;
//      uint16_t byte_address_1;
//      uint16_t byte_address_2;
//      uint8_t byte_1;
//      uint8_t byte_2;
      for (i=16; i<20; i++) {
        if (((Pending_pin_control[i] & 0x03) == 0x02) || ((Pending_pin_control[i+4] & 0x03) == 0x02)) {
          // At least one pin is in the process of being defined as Linked
          if ((Pending_pin_control[i] & 0x03) != (Pending_pin_control[i+4] & 0x03)) {
            // One of the pins is not defined as Linked. Revert the 
	    // Pending_pin_control back to the value in the existing pin_control.
	    // This should just have the effect of invalidating the Pending request.
	    Pending_pin_control[i] = pin_control[i];
	    Pending_pin_control[i+4] = pin_control[i+4];
	  }
          // else do nothing - the settings are OK.
        }
        // else do nothing - the settings are OK.
      }
    }
#endif // PCF8574_SUPPORT == 1
  }
#endif // LINKED_SUPPORT == 1


#if LINKED_SUPPORT == 1
  {
    int i;
    uint16_t mask;
    // Check the linked_edge byte for any indication of an Input pin edge on
    // a Linked input pin. It doesn't matter if the edge is positive or
    // negative, only that an edge occurred.
    //
    // STM8 pins: The Linked pin function only allows Inputs on pins 1 to 8,
    // and corresponding Outputs on pin 9 to 16. If an Input edge is detected
    // then the corresponding Output state is to be toggled.
    //
    // PCF8574 pins: The Linked pin function only allows Inputs on pins 17 to
    // 20, and corresponding Outputs on pin 21 to 24. If an Input edge is
    // detected then the corresponding Output state is to be toggled.
    //
    // This check must be performed before the Pending_pin_control check in
    // this function. This is to allow all the other processes of this
    // function to act on a change in the Output pin that occurs as a result
    // of the Linked pin functionality.
    //
    // The way the Linked pin functionality will toggle the Output pin is to
    // toggle the state of the Pending_pin_control for the Output pin. The
    // thinking here:
    //  - Normally this function will be entered with pin_control equal
    //    to Pending_pin_control for the Output, assuming no GUI, REST,
    //    or MQTT action is changing the Output pin at this same
    //    instant.
    //  - If some other function is attempting to change the Output pin
    //    at the same instant as an incoming edge it is not clear which
    //    one will win. And it probably doesn't matter. So I won't put
    //    any effort into resolving such a case.
    
    if (linked_edge & 0x0fff) {
      // There is an edge on at least one pin
      // Check the STM8 pins
      for (i=0, mask=1; i<8; i++, mask<<=1) {
        // Sweep through the first 8 pins
        if (mask & linked_edge) {
	  // Found an edge
	  linked_edge &= (uint8_t)(~mask); // Clear the linked_edge bit
          if ((Pending_pin_control[i] & 0x03) == 0x02) {
	    // Verify that the pin is a Linked pin. The Pending_pin_control
	    // is used because: a) If the pin was previously set to Linked
	    // the Pending_pin_control will equal the pin_control value, and
	    // b) If the user just changed the pin to Linked we can go ahead
	    // and act on that change.
	    // Note that the Linked pins have already been validated as
	    // Linked.
	    if (Pending_pin_control[i+8] & 0x80) {
	      Pending_pin_control[i+8] &= 0x7f; // Toggle to zero
	    }
	    else {
	      Pending_pin_control[i+8] |= 0x80; // Toggle to one
	    }
	    parse_complete = 1; // Set parse_complete so that the
	                        // Pending_pin_control changes will be
				// processed, just as if a GUI, REST,
				// or MQTT action had changed the
				// Output pin.
	  }
	}
      }
#if PCF8574_SUPPORT == 1
      // Check the PCF8574 pins
      for (i=16, mask=0x0100; i<20; i++, mask<<=1) {
        // Sweep through the first 4 pins
        if (mask & linked_edge) {
	  // Found an edge
	  linked_edge &= (uint8_t)(~mask); // Clear the linked_edge bit
          if ((Pending_pin_control[i] & 0x03) == 0x02) {
	    // Verify that the pin is a Linked pin. The Pending_pin_control
	    // is used because: a) If the pin was previously set to Linked
	    // the Pending_pin_control will equal the pin_control value, and
	    // b) If the user just changed the pin to Linked we can go ahead
	    // and act on that change.
	    // Note that the Linked pins have already been validated as
	    // Linked.
	    if (Pending_pin_control[i+4] & 0x80) {
	      Pending_pin_control[i+4] &= 0x7f; // Toggle to zero
	    }
	    else {
	      Pending_pin_control[i+4] |= 0x80; // Toggle to one
	    }
	    parse_complete = 1; // Set parse_complete so that the
	                        // Pending_pin_control changes will be
				// processed, just as if a GUI, REST,
				// or MQTT action had changed the
				// Output pin.
	  }
	}
      }
#endif // PCF8574_SUPPORT == 1
    }
  }
#endif // LINKED_SUPPORT == 1


#if BUILD_SUPPORT == BROWSER_ONLY_BUILD
  // Manage Output pin Timers. Change Output pin states and Timers as
  // appropriate.
  //
  // Note that Timers are ignored for any pin that is not defined as an
  // Output pin.
  //
  // Check if the user changed the IO_TIMER value:
  //   If an Output pin IO_TIMER value is changed by the user
  //     then set the pin_timer for that pin to the Pending_IO_TIMER value
  //
  // Check for Timer expiration:
  //   If an Output pin and Retain is NOT set
  //     and pin has a non-zero IO_TIMER
  //     and the Output pin is in its active state
  //     and the pin_timer for that pin is zero
  //       then set the Output pin to its idle state
  //
  //   Collect the Pending IO_TIMER values and write them to Flash
  //
  // Check for Output pin Timer activate:
  //   If an Output pin and Retain is NOT set
  //     and pin has a non-zero IO_TIMER
  //     and the user changed the pin from its idle state to its active state
  //       then set the pin_timer for that pin to the IO_TIMER
  //
  // Note:
  //   If the user changes the Output pin from ACTIVE to IDLE while a
  //   pin_timer is running nothing needs to be done with regard to the
  //   pin_timer. One of two things happens:
  //   a) The pin_timer will eventually expire and no pin state change will
  //       occur (because the pin is already IDLE).
  //   b) The user changes the Output pin from IDLE to ACTIVE which reloads
  //      the pin_timer, replacing whatever countdown value was present.
  //-------------------------------------------------------------------------//

  if (parse_complete) {
    // Check if the user changed the IO_TIMER value and update the pin_timer
    // to the Pending_IO_TIMER value. Typically the user is just changing the
    // IO_TIMER value to zero, but they may also be correcting a user entry
    // mistake - for example the user may have entered 100 minutes when they
    // meant to enter 10 minutes, so they fix it in Configuration. The code
    // here is intended  to allow the user to change the value to any new
    // value, and the timer should then continue with that new value. It is
    // important that this check occur at this point in the code because IF
    // the user changed the value to zero the Timer Expiration code needs to
    // set the pin to its IDLE state, and it needs to do this before the
    // IO_TIMER value is updated to the Pending_IO_TIMER value.
    //
    // If an Output pin IO_TIMER value is changed by the user
    //   then set the pin_timer for that pin to the Pending_IO_TIMER value
    // Note this also applies to Linked pins that are pins 9 to 16 (as those
    //   are also Outputs).
    
#if LINKED_SUPPORT == 0
    {
      int i;
      for (i=0; i<16; i++) {
        if ((pin_control[i] & 0x0b) == 0x03) {
          // Pin is an Output AND Retain is not set
          if (IO_TIMER[i] != Pending_IO_TIMER[i]) {
            pin_timer[i] = Pending_IO_TIMER[i];
          }
        }
      }
    }
#if PCF8574_SUPPORT == 1
    {
      int i;
      uint16_t IO_timer_value;
      for (i=16; i<24; i++) {
        if ((pin_control[i] & 0x0b) == 0x03) {
          // Pin is an Output AND Retain is not set
	  // Read the PCF8574 IO_TIMER value from I2C EEPROM
	  // -------------------------------------------------------------- //
	  // This is a potential timing problem as reading from the I2C EEPROM
	  // takes so long. I think the problem is mitigated in that this code
	  // is only applicable to the Browser version of code and will only
	  // run if parse_complete == 1.
	  // -------------------------------------------------------------- //
          prep_read(I2C_EEPROM_R2_WRITE, I2C_EEPROM_R2_READ, PCF8574_I2C_EEPROM_R2_START_IO_TIMERS + ((i - 16) * 2), 2);
          IO_timer_value = read_two_bytes();
          if (IO_timer_value != Pending_IO_TIMER[i]) {
            pin_timer[i] = Pending_IO_TIMER[i];
          }
        }
      }
    }
#endif // PCF8574_SUPPORT == 1
#endif // LINKED_SUPPORT == 0

#if LINKED_SUPPORT == 1
    {
      int i;
      for (i=0; i<16; i++) {
        if (chk_iotype(pin_control[i], i, 0x0b) == 0x03) {
	  // Pin is an Output and Retain is not set
          if (IO_TIMER[i] != Pending_IO_TIMER[i]) {
            pin_timer[i] = Pending_IO_TIMER[i];
	  }
        }
      }
    }
#if PCF8574_SUPPORT == 1
    {
      int i;
      uint16_t IO_timer_value;
      for (i=16; i<24; i++) {
        if (chk_iotype(pin_control[i], i, 0x0b) == 0x03) {
	  // Pin is an Output and Retain is not set
	  // Read the PCF8574 IO_TIMER value from I2C EEPROM
	  // -------------------------------------------------------------- //
	  // This is a potential timing problem as reading from the I2C EEPROM
	  // takes so long. I think the problem is mitigated in that this code
	  // is only applicable to the Browser version of code and will only
	  // run if parse_complete == 1.
	  // -------------------------------------------------------------- //
          prep_read(I2C_EEPROM_R2_WRITE, I2C_EEPROM_R2_READ, PCF8574_I2C_EEPROM_R2_START_IO_TIMERS + ((i - 16) * 2), 2);
          IO_timer_value = read_two_bytes();
          if (IO_timer_value != Pending_IO_TIMER[i]) {
            pin_timer[i] = Pending_IO_TIMER[i];
          }
        }
      }
    }
#endif // PCF8574_SUPPORT == 1
#endif // LINKED_SUPPORT == 1
  }
  
  // Check for Timer expiration:
  // If an Output pin and Retain is NOT set
  //   and pin has a non-zero IO_TIMER
  //   and the pin_timer for that pin is zero
  //   and the Output pin is in its active state
  //     then set the Output pin to its idle state
  // Pin control byte definition
  // b7 (MSbit) Pin control    1 = ON 0 = OFF
  // b6         not used
  // b5         not used
  // b4         Boot control   0 = OFF, 1 = ON
  // b3         Boot control   1 = Retain (ignore b4), 0 = use b4
  // b2         Invert control 0 = No Invert, 1 = Invert
  // b1         | b1 and b0 define the pin Type as follows:
  // b0         | 00: Disabled  01: Input  10: Linked  11: Output
  // Note this also applies to Linked pins that are pins 9 to 16 (as those
  //   are also Outputs).
  
#if LINKED_SUPPORT == 0
  {
    int i;
    for (i=0; i<16; i++) {
      if ((pin_control[i] & 0x0b) == 0x03) {
        // Pin is an Output and Retain is not set
        if (((IO_TIMER[i] & 0x3fff) != 0) && ((pin_timer[i] & 0x3fff) == 0)) {
          // Pin has a non-zero TIMER value AND the timer countdown is zero
	  if ((pin_control[i] & 0x90) == 0x80) {
	    // Pin is ON and the idle state is OFF
	    // Turn the pin OFF
	    Pending_pin_control[i] &= 0x7f;
	    pin_control[i] &= 0x7f;
	  }
	  if ((pin_control[i] & 0x90) == 0x10) {
	    // Pin is OFF and the idle state is ON
	    // Turn the pin ON
	    Pending_pin_control[i] |= 0x80;
	    pin_control[i] |= 0x80;
	  }
          // Update the bit registers with the changed Output pin states
          encode_bit_registers(0);
          // Update the Output pins

#if DEBUG_SUPPORT == 15
// UARTPrintf("pin_control for IO16 = ");
// emb_itoa(pin_control[15], OctetArray, 16, 2);
// UARTPrintf(OctetArray);
// UARTPrintf("   Invert_word = ");
// emb_itoa(Invert_word, OctetArray, 16, 8);
// UARTPrintf(OctetArray);
// UARTPrintf("   ON_OFF_word = ");
// emb_itoa(ON_OFF_word, OctetArray, 16, 8);
// UARTPrintf(OctetArray);
// UARTPrintf("   stored_config_settings = ");
// emb_itoa(stored_config_settings, OctetArray, 16, 2);
// UARTPrintf(OctetArray);
// UARTPrintf("\r\n");
#endif // DEBUG_SUPPORT == 15


          write_output_pins();
        }
      }
    }
  }
#if PCF8574_SUPPORT == 1
  {
    int i;
    uint16_t IO_timer_value;
    for (i=16; i<24; i++) {
      if ((pin_control[i] & 0x0b) == 0x03) {
        // Pin is an Output and Retain is not set
        // Read the PCF8574 IO_TIMER value from I2C EEPROM
	// ---------------------------------------------------------------- //
	// This is a potential timing problem as reading from the I2C EEPROM
	// takes so long. This code runs on every pass of
	// check_runtime_changes.
	// The I2C EEPROM read is only to check if the user entered timer
	// value is non-zero. Maybe this could be faster if a byte containing
	// "non-zero" flags could be used for the PCF8574 timers.
	// ---------------------------------------------------------------- //
        prep_read(I2C_EEPROM_R2_WRITE, I2C_EEPROM_R2_READ, PCF8574_I2C_EEPROM_R2_START_IO_TIMERS + ((i - 16) * 2), 2);
        IO_timer_value = read_two_bytes();
        if (((IO_timer_value & 0x3fff) != 0) && ((pin_timer[i] & 0x3fff) == 0)) {
          // Pin has a non-zero TIMER value AND the timer countdown is zero
	  if ((pin_control[i] & 0x90) == 0x80) {
	    // Pin is ON and the idle state is OFF
	    // Turn the pin OFF
	    Pending_pin_control[i] &= 0x7f;
	    pin_control[i] &= 0x7f;
	  }
	  if ((pin_control[i] & 0x90) == 0x10) {
	    // Pin is OFF and the idle state is ON
	    // Turn the pin ON
	    Pending_pin_control[i] |= 0x80;
	    pin_control[i] |= 0x80;
	  }
          // Update the 16 bit registers with the changed Output pin states
          encode_bit_registers(0);
          // Update the Output pins

#if DEBUG_SUPPORT == 15
// UARTPrintf("pin_control for IO16 = ");
// emb_itoa(pin_control[15], OctetArray, 16, 2);
// UARTPrintf(OctetArray);
// UARTPrintf("   Invert_word = ");
// emb_itoa(Invert_word, OctetArray, 16, 8);
// UARTPrintf(OctetArray);
// UARTPrintf("   ON_OFF_word = ");
// emb_itoa(ON_OFF_word, OctetArray, 16, 8);
// UARTPrintf(OctetArray);
// UARTPrintf("   stored_config_settings = ");
// emb_itoa(stored_config_settings, OctetArray, 16, 2);
// UARTPrintf(OctetArray);
// UARTPrintf("\r\n");
#endif // DEBUG_SUPPORT == 15


          write_output_pins();
        }
      }
    }
  }
#endif // PCF8574_SUPPORT == 1
#endif // LINKED_SUPPORT == 0

#if LINKED_SUPPORT == 1
  {
    int i;
    for (i=0; i<16; i++) {
      if (chk_iotype(pin_control[i], i, 0x0b) == 0x03) {
        // Pin is an Output and Retain is not set
        if (((IO_TIMER[i] & 0x3fff) != 0) && ((pin_timer[i] & 0x3fff) == 0)) {
          // Pin has a non-zero TIMER value AND the timer countdown is zero
	  if ((pin_control[i] & 0x90) == 0x80) {
	    // The above: If the pin is ON and the idle state is OFF
	    // Turn the pin OFF
	    Pending_pin_control[i] &= 0x7f;
	    pin_control[i] &= 0x7f;
	  }
	  if ((pin_control[i] & 0x90) == 0x10) {
	    // Pin is OFF and the idle state is ON
	    // Turn the pin ON
	    Pending_pin_control[i] |= 0x80;
	    pin_control[i] |= 0x80;
	  }
          // Update the 16 bit registers with the changed Output pin states
          encode_bit_registers(0);
          // Update the Output pins

#if DEBUG_SUPPORT == 15
// UARTPrintf("pin_control for IO16 = ");
// emb_itoa(pin_control[15], OctetArray, 16, 2);
// UARTPrintf(OctetArray);
// UARTPrintf("   Invert_word = ");
// emb_itoa(Invert_word, OctetArray, 16, 8);
// UARTPrintf(OctetArray);
// UARTPrintf("   ON_OFF_word = ");
// emb_itoa(ON_OFF_word, OctetArray, 16, 8);
// UARTPrintf(OctetArray);
// UARTPrintf("   stored_config_settings = ");
// emb_itoa(stored_config_settings, OctetArray, 16, 2);
// UARTPrintf(OctetArray);
// UARTPrintf("\r\n");
#endif // DEBUG_SUPPORT == 15


          write_output_pins();
	}
      }
    }
  }
#if PCF8574_SUPPORT == 1
  {
    int i;
    uint16_t IO_timer_value;
    for (i=16; i<23; i++) {
      if (chk_iotype(pin_control[i], i, 0x0b) == 0x03) {
        // Pin is an Output and Retain is not set
        // Read the PCF8574 IO_TIMER value from I2C EEPROM
	// ---------------------------------------------------------------- //
	// This is a potential timing problem as reading from the I2C EEPROM
	// takes so long. This code runs on every pass of
	// check_runtime_changes.
	// The I2C EEPROM read is only to check if the user entered timer
	// value is non-zero. Maybe this could be faster if a byte containing
	// "non-zero" flags could be used for the PCF8574 timers.
	// ---------------------------------------------------------------- //
        prep_read(I2C_EEPROM_R2_WRITE, I2C_EEPROM_R2_READ, PCF8574_I2C_EEPROM_R2_START_IO_TIMERS + ((i - 16) * 2), 2);
        IO_timer_value = read_two_bytes();

        if (((IO_timer_value & 0x3fff) != 0) && ((pin_timer[i] & 0x3fff) == 0)) {
          // Pin has a non-zero TIMER value AND the timer countdown is zero
	  if ((pin_control[i] & 0x90) == 0x80) {
	    // The above: If the pin is ON and the idle state is OFF
	    // Turn the pin OFF
	    Pending_pin_control[i] &= 0x7f;
	    pin_control[i] &= 0x7f;
	  }
	  if ((pin_control[i] & 0x90) == 0x10) {
	    // Pin is OFF and the idle state is ON
	    // Turn the pin ON
	    Pending_pin_control[i] |= 0x80;
	    pin_control[i] |= 0x80;
	  }
          // Update the 16 bit registers with the changed Output pin states
          encode_bit_registers(0);
          // Update the Output pins

#if DEBUG_SUPPORT == 15
// UARTPrintf("pin_control for IO16 = ");
// emb_itoa(pin_control[15], OctetArray, 16, 2);
// UARTPrintf(OctetArray);
// UARTPrintf("   Invert_word = ");
// emb_itoa(Invert_word, OctetArray, 16, 8);
// UARTPrintf(OctetArray);
// UARTPrintf("   ON_OFF_word = ");
// emb_itoa(ON_OFF_word, OctetArray, 16, 8);
// UARTPrintf(OctetArray);
// UARTPrintf("   stored_config_settings = ");
// emb_itoa(stored_config_settings, OctetArray, 16, 2);
// UARTPrintf(OctetArray);
// UARTPrintf("\r\n");
#endif // DEBUG_SUPPORT == 15


          write_output_pins();
	}
      }
    }
  }
#endif // PCF8574_SUPPORT == 1
#endif // LINKED_SUPPORT == 1
  
  if (parse_complete) {
  
    // For STM8 pins update the IO_TIMER array in Flash to match the
    // Pending_IO_TIMER array.
    unlock_flash();
    {
      int i;
      for (i=0; i<16; i+=2) {
        // Check for differences between the existing and pending TIMER
	// values. Each of the 16 TIMER values is a uint16_t (two bytes), but
	// to reduce Flash wear we need to write 4 bytes at a time. So,
	// compare 4 bytes at a time and if any miscompare write to Flash 4
	// bytes at a time.
        if (IO_TIMER[i] != Pending_IO_TIMER[i] || IO_TIMER[i+1] != Pending_IO_TIMER[i+1]) {
          // Enable Word programming
          FLASH_CR2 |= FLASH_CR2_WPRG;
          FLASH_NCR2 &= (uint8_t)(~FLASH_NCR2_NWPRG);
	  // Write word to Flash
          memcpy(&IO_TIMER[i], &Pending_IO_TIMER[i], 4);
          // No "wait_timer" is needed. The spec says the CPU stalls
          // while the word programming operates (takes about 6ms).
        }
      }
    }
    lock_flash();

#if PCF8574_SUPPORT == 1
    // For PCF8574 pins update the IO_TIMER array in the I2C EEPROM to match
    // the Pending_IO_TIMER array. Each TIMER value is a uint16_t (two bytes).
    // Each TIMER value can be written to I2C EEPROM one at a time.
    {
      int i;
      uint16_t IO_timer_value;
      for (i=16; i<24; i++) {
        // Check for differences between the existing and pending TIMER
	// values. Compare 2 bytes at a time. If any miscompare write the
	// Pending value to I2C EEPROM.
        // Read the PCF8574 IO_TIMER value from I2C EEPROM
	// ---------------------------------------------------------------- //
	// This is a potential timing problem as reading from the I2C EEPROM
	// takes so long. I think the problem is mitigated in that this code
	// is only applicable to the Browser version of code and will only
	// run if parse_complete == 1.
	// ---------------------------------------------------------------- //
        prep_read(I2C_EEPROM_R2_WRITE, I2C_EEPROM_R2_READ, PCF8574_I2C_EEPROM_R2_START_IO_TIMERS + ((i - 16) * 2), 2);
        IO_timer_value = read_two_bytes();
        if (IO_timer_value != Pending_IO_TIMER[i]) {
          // Write the Pending value to the I2C EEPROM
          I2C_control(I2C_EEPROM_R2_WRITE);
          I2C_byte_address(PCF8574_I2C_EEPROM_R2_START_IO_TIMERS + ((i - 16) * 2), 2);
	  IO_timer_value = (Pending_IO_TIMER[i] >> 8);
          I2C_write_byte((uint8_t)IO_timer_value);
	  IO_timer_value = (Pending_IO_TIMER[i] & 0x00ff);
          I2C_write_byte((uint8_t)IO_timer_value);
          I2C_stop(); // Start the EEPROM internal write cycle
          wait_timer(5000); // Wait 5ms
        }
      }
    }
#endif // PCF8574_SUPPORT == 1
  
    // Check for Output pin Timer activate:
    // If an Enabled Output pin and Retain is NOT set
    //   and pin has a non-zero IO_TIMER
    //   and the user changed the pin from its idle state to its active state
    //     then set the pin_timer for that pin to the IO_TIMER value
    // Note this also applies to Linked pins that are pins 9 to 16 (as those
    //   are also Outputs).
    //
#if LINKED_SUPPORT == 0
    {
      int i;
      for (i=0; i<16; i++) {
        if ((pin_control[i] & 0x0b) == 0x03) {
          // Pin is an Enabled Output AND Retain is not set
          if ((IO_TIMER[i] & 0x3fff) != 0) {
            if ((Pending_pin_control[i] & 0x80) != (pin_control[i] & 0x80)) {
              // The user changed the pin ON/OFF state
              if (((Pending_pin_control[i] & 0x80) == 0x80) && ((pin_control[i] & 0x10) == 0x00)) {
                // The user turned the pin ON and the idle state is OFF
                // Set the pin timer
                pin_timer[i] = IO_TIMER[i];
              }
              if (((Pending_pin_control[i] & 0x80) == 0x00) && ((pin_control[i] & 0x10) == 0x10)) {
                // The user turned the pin OFF and the idle state is ON
                // Set the pin timer
                pin_timer[i] = IO_TIMER[i];
              }
            }
          }
        }
      }
    }
#if PCF8574_SUPPORT == 1
    {
      int i;
      uint16_t IO_timer_value;
      for (i=16; i<24; i++) {
        if ((pin_control[i] & 0x0b) == 0x03) {
          // Pin is an Enabled Output AND Retain is not set
          // Read the PCF8574 IO_TIMER value from I2C EEPROM
	  // -------------------------------------------------------------- //
	  // This is a potential timing problem as reading from the I2C
	  // EEPROM takes so long. I think the problem is mitigated in that
	  // this code is only applicable to the Browser version of code and
	  // will only run if parse_complete == 1.
	  // -------------------------------------------------------------- //
          prep_read(I2C_EEPROM_R2_WRITE, I2C_EEPROM_R2_READ, PCF8574_I2C_EEPROM_R2_START_IO_TIMERS + ((i - 16) * 2), 2);
          IO_timer_value = read_two_bytes();
          if ((IO_timer_value & 0x3fff) != 0) {
            if ((Pending_pin_control[i] & 0x80) != (pin_control[i] & 0x80)) {
              // The user changed the pin ON/OFF state
              if (((Pending_pin_control[i] & 0x80) == 0x80) && ((pin_control[i] & 0x10) == 0x00)) {
                // The user turned the pin ON and the idle state is OFF
                // Set the pin timer
                pin_timer[i] = IO_timer_value;
              }
              if (((Pending_pin_control[i] & 0x80) == 0x00) && ((pin_control[i] & 0x10) == 0x10)) {
                // The user turned the pin OFF and the idle state is ON
                // Set the pin timer
                pin_timer[i] = IO_timer_value;
              }
            }
          }
        }
      }
    }
#endif // PCF8574_SUPPORT == 1
#endif // LINKED_SUPPORT == 0

#if LINKED_SUPPORT == 1
    {
      int i;
      for (i=0; i<16; i++) {
        if (chk_iotype(pin_control[i], i, 0x0b) == 0x03) {
	  // Pin is an Output and Retain is not set
          if ((IO_TIMER[i] & 0x3fff) != 0) {
            if ((Pending_pin_control[i] & 0x80) != (pin_control[i] & 0x80)) {
              // The user changed the pin ON/OFF state
              if (((Pending_pin_control[i] & 0x80) == 0x80) && ((pin_control[i] & 0x10) == 0x00)) {
                // The user turned the pin ON and the idle state is OFF
                // Set the pin timer
                pin_timer[i] = IO_TIMER[i];
              }
              if (((Pending_pin_control[i] & 0x80) == 0x00) && ((pin_control[i] & 0x10) == 0x10)) {
                // The user turned the pin OFF and the idle state is ON
                // Set the pin timer
                pin_timer[i] = IO_TIMER[i];
	      }
            }
          }
        }
      }
    }
#if PCF8574_SUPPORT == 1
    {
      int i;
      uint16_t IO_timer_value;
      for (i=16; i<24; i++) {
        if (chk_iotype(pin_control[i], i, 0x0b) == 0x03) {
	  // Pin is an Output and Retain is not set
          // Read the PCF8574 IO_TIMER value from I2C EEPROM
	  // -------------------------------------------------------------- //
	  // This is a potential timing problem as reading from the I2C
	  // EEPROM takes so long. I think the problem is mitigated in that
	  // this code is only applicable to the Browser version of code and
	  // will only run if parse_complete == 1.
	  // -------------------------------------------------------------- //
          prep_read(I2C_EEPROM_R2_WRITE, I2C_EEPROM_R2_READ, PCF8574_I2C_EEPROM_R2_START_IO_TIMERS + ((i - 16) * 2), 2);
          IO_timer_value = read_two_bytes();
          if ((IO_timer_value & 0x3fff) != 0) {
            if ((Pending_pin_control[i] & 0x80) != (pin_control[i] & 0x80)) {
              // The user changed the pin ON/OFF state
              if (((Pending_pin_control[i] & 0x80) == 0x80) && ((pin_control[i] & 0x10) == 0x00)) {
                // The user turned the pin ON and the idle state is OFF
                // Set the pin timer
                pin_timer[i] = IO_timer_value;
              }
              if (((Pending_pin_control[i] & 0x80) == 0x00) && ((pin_control[i] & 0x10) == 0x10)) {
                // The user turned the pin OFF and the idle state is ON
                // Set the pin timer
                pin_timer[i] = IO_timer_value;
	      }
            }
          }
        }
      }
    }
#endif // PCF8574_SUPPORT == 1
#endif // LINKED_SUPPORT == 1
  }
#endif // BUILD_SUPPORT == BROWSER_ONLY_BUILD




  if (parse_complete || mqtt_parse_complete) {
  
 
    // Check for changes from the user via the GUI, MQTT, or REST commands.
    // If parse_complete == 1 all TCP Fragments have been received during
    // HTML POST processing, OR a REST command was processed.
    // If mqtt_parse_complete == 1 an MQTT Output pin state change has been
    // received.

    // Check all pin_control bytes for changes.
    // ON/OFF state: If an Output pin's ON/OFF state changes the EEPROM is
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
    {
      int i;
#if PCF8574_SUPPORT == 0
      for (i=0; i<16; i++) {
#endif // PCF8574_SUPPORT == 0
#if PCF8574_SUPPORT == 1
      for (i=0; i<24; i++) {
#endif // PCF8574_SUPPORT == 1
        if (pin_control[i] != Pending_pin_control[i]) {
          // Something changed - sort it out


#if LINKED_SUPPORT == 0
          // Check for change in ON/OFF bit. This function will save the ON/OFF
	  // bit in the EEPROM if the IO is an Output and Retain is enabled (or
	  // in the process of being enabled).
	  if ((Pending_pin_control[i] & 0x0b) == 0x0b) { // Output AND Retain set?
            if ((pin_control[i] & 0x80) != (Pending_pin_control[i] & 0x80)) {
	      // ON/OFF changed
              update_EEPROM = 1;
            }
	  }
#endif // LINKED_SUPPORT == 0

#if LINKED_SUPPORT == 1
          // Check for change in ON/OFF bit. This function will save the ON/OFF
	  // bit in the EEPROM if the IO is an Output and Retain is enabled (or
	  // in the process of being enabled).
          if (chk_iotype(Pending_pin_control[i], i, 0x0b) == 0x0b) {
          // If an Enabled Output AND Retain is set OR a Linked pin (with
	  // Retain set) on pins 9 to 16.
            if ((pin_control[i] & 0x80) != (Pending_pin_control[i] & 0x80)) {
	      // ON/OFF changed
              update_EEPROM = 1;
            }
	  }
#endif // LINKED_SUPPORT == 1


          // Check for change in Input/Output and Enabled/Disabled definition
          if ((pin_control[i] & 0x03) != (Pending_pin_control[i] & 0x03)) {
            // There is a change:
	    //   Signal an EEPROM update
	    //   Signal a "reboot needed"
            update_EEPROM = 1;
	    // Changing pin definitions with regard to Input/Output definition
	    // requires a hardware reboot as the IO hardware needs to be
	    // reconfigured.
            user_reboot_request = 1;
	  }

          // Check for change in Invert
          if ((pin_control[i] & 0x04) != (Pending_pin_control[i] & 0x04)) {
            // There is a change.
	    //   Signal an EEPROM update.
	    //   Signal a "restart needed". Note that a restart is really only
	    //   needed if MQTT is enabled, but it will be done even if MQTT is
	    //   not enabled to simplify code.
            update_EEPROM = 1;
            restart_request = 1;
          }
	
          // Check for change in Retain/On/Off bits
          if ((pin_control[i] & 0x18) != (Pending_pin_control[i] & 0x18)) {
            // There is a change. Signal an EEPROM update. No restart or
	    // reboot is required as these bits are only used when a reboot
	    // occurs as a result of a power cycle or button reboot.
            update_EEPROM = 1;
          }
	
	  // Always update the pin_control byte even if the EEPROM was not
	  // updated. Don't let the ON/OFF bit change if this pin_control is
	  // for an input.
#if LINKED_SUPPORT == 0
	  if ((Pending_pin_control[i] & 0x03) == 0x03) { // Output
	    // Update all bits
	    pin_control[i] = Pending_pin_control[i];
	  }
#endif // LINKED_SUPPORT == 0

#if LINKED_SUPPORT == 1
          if (chk_iotype(Pending_pin_control[i], i, 0x03) == 0x03) {
	    // Update all Output bits including Linked pins 9 to 16.
	    pin_control[i] = Pending_pin_control[i];
	  }
#endif // LINKED_SUPPORT == 1

#if LINKED_SUPPORT == 0
	  if ((Pending_pin_control[i] & 0x03) == 0x01) {
#endif // LINKED_SUPPORT == 0
#if LINKED_SUPPORT == 1
          if (chk_iotype(Pending_pin_control[i], i, 0x03) == 0x01) {
#endif // LINKED_SUPPORT == 1
	    // Input pin
	    // Update all bits except the ON/OFF bit
	    // The ON/OFF bit setting for inputs is handled in the
	    // read_input_pins() function.
            pin_control[i] &= 0x80;
	    pin_control[i] |= (uint8_t)(Pending_pin_control[i] & 0x7f);
	  }
	  if ((Pending_pin_control[i] & 0x03) == 0x00) {
	    // Disabled pin
	    // Update all bits
	    pin_control[i] = Pending_pin_control[i];
	  }
	  
          if (update_EEPROM) {
            // Update the stored_pin_control[] variables
	    
	    if (i < 16) {
	      unlock_eeprom();
              if (stored_pin_control[i] != pin_control[i]) {
	        stored_pin_control[i] = pin_control[i];
	      }
	      lock_eeprom();
	    }
	    
#if PCF8574_SUPPORT == 1
	    else {
	      {
	        uint16_t byte_address;
	        // Read stored_pin_control from I2C EEPROM
                byte_address = (uint16_t)(PCF8574_I2C_EEPROM_R2_PIN_CONTROL_STORAGE + i - 16);
		// -------------------------------------------------------- //
	        // This is a potential timing problem as reading from the I2C
		// EEPROM takes so long. I think the problem is mitigated in
		// that this code will only run if parse_complete == 1.
		// -------------------------------------------------------- //
                prep_read(I2C_EEPROM_R2_WRITE, I2C_EEPROM_R2_READ, byte_address, 2);
                if (I2C_read_byte(1) != pin_control[i]) {
                  // Update stored_pin_control in I2C EEPROM.
                  copy_STM8_bytes_to_I2C_EEPROM(&pin_control[i], 1, I2C_EEPROM_R2_WRITE, byte_address, 2);
	        }
	      }
	    }
#endif // PCF8574_SUPPORT == 1
            update_EEPROM = 0;
          }
        }
      }
    }

    // Update the bit registers with the changed Output pin states
    encode_bit_registers(0);
    
    // Update the Output pins

#if DEBUG_SUPPORT == 15
// UARTPrintf("pin_control for IO16 = ");
// emb_itoa(pin_control[15], OctetArray, 16, 2);
// UARTPrintf(OctetArray);
// UARTPrintf("   Invert_word = ");
// emb_itoa(Invert_word, OctetArray, 16, 8);
// UARTPrintf(OctetArray);
// UARTPrintf("   ON_OFF_word = ");
// emb_itoa(ON_OFF_word, OctetArray, 16, 8);
// UARTPrintf(OctetArray);
// UARTPrintf("   stored_config_settings = ");
// emb_itoa(stored_config_settings, OctetArray, 16, 2);
// UARTPrintf(OctetArray);
// UARTPrintf("\r\n");
#endif // DEBUG_SUPPORT == 15


    write_output_pins();
  }
  
  
  

  if (parse_complete) {
    // Only perform the next checks if parse_complete indicates that all
    // HTML POST processing is complete.

    unlock_eeprom();
    
    if (stored_config_settings != Pending_config_settings) {
      // Save the "prior" config (Features) setting in case it is needed
      // after boot.
      stored_prior_config = stored_config_settings;
      
      // At present any Feature bit change (config_settings) requires a
      // reboot so to simplify code the bits are not individually checked.
      // The Feature bits include:
      //   Disable Config Button
      //   BME280
      //   DS18B20
      //   MQTT
      //   Home Assistant Auto Discovery
      //   Full Duplex

      user_reboot_request = 1;
      // If any bit of the config_settings changed write to EEPROM
      stored_config_settings = Pending_config_settings;
    }

//    // Check for changes in the IP Address, Gateway Address,
//    // Netmask, and MQTT Server IP Address. Combined into one
//    // loop for code size reduction.
//    {
//      int i;
//      for (i=0; i<4; i++) {
//        if (stored_hostaddr[i] != Pending_hostaddr[i]) {
//          // Write the new octet to the EEPROM and signal a restart
//          stored_hostaddr[i] = Pending_hostaddr[i];
//          restart_request = 1;
//        }
//        if (stored_draddr[i] != Pending_draddr[i]) {
//          // Write the new octet to the EEPROM and signal a restart
//          stored_draddr[i] = Pending_draddr[i];
//          restart_request = 1;
//        }
//        if (stored_netmask[i] != Pending_netmask[i]) {
//          // Write the new octet to the EEPROM and signal a restart
//          stored_netmask[i] = Pending_netmask[i];
//          restart_request = 1;
//        }
//        if (stored_mqttserveraddr[i] != Pending_mqttserveraddr[i]) {
//          // Write the new octet to the EEPROM and signal a restart
//          stored_mqttserveraddr[i] = Pending_mqttserveraddr[i];
//          restart_request = 1;
//        }
//      }
//    }
//      
//    // Check for changes in the Port number
//    if (stored_port != Pending_port) {
//      // Write the new Port number to the EEPROM
//      stored_port = Pending_port;
//      // A firmware restart will occur to cause this change to take effect.
//      // The restart process will call uip_init() which will zero out all
//      // entries in the uip_listenports table, and will then put the new
//      // listenport number in the table.
//      restart_request = 1;
//    }
//  
//    // Check for changes in the Device Name
//    {
//      int i;
//      for(i=0; i<20; i++) {
//        if (stored_devicename[i] != Pending_devicename[i]) {
//          stored_devicename[i] = Pending_devicename[i];
//          // No restart is required in non-MQTT applications as this does not 
//	  // affect Ethernet operation.
//#if BUILD_SUPPORT == MQTT_BUILD
//          if (mqtt_enabled) {
//            // If MQTT is enabled a restart is required as this affects the
//	    // MQTT topic name.
//            restart_request = 1;
//	  }
//#endif // BUILD_SUPPORT == MQTT_BUILD
//        }
//      }
//    }
//
//    // Check for changes in the MQTT Host Port number
//    if (stored_mqttport != Pending_mqttport) {
//      // Write the new MQTT Host Port number to the EEPROM
//      stored_mqttport = Pending_mqttport;
//      // A firmware restart will occur to cause this change to take effect
//      restart_request = 1;
//    }
//    
//    // Check for changes in the MQTT Username or Password
//    // The storage fields are the same length so to condense code
//    // they will be checked in the same loop
//    {
//      int i;
//      for(i=0; i<11; i++) {
//        if (stored_mqtt_username[i] != Pending_mqtt_username[i]) {
//          stored_mqtt_username[i] = Pending_mqtt_username[i];
//          // A firmware restart will occur to cause this change to take effect
//          restart_request = 1;
//        }
//        if (stored_mqtt_password[i] != Pending_mqtt_password[i]) {
//          stored_mqtt_password[i] = Pending_mqtt_password[i];
//          // A firmware restart will occur to cause this change to take effect
//          restart_request = 1;
//        }
//      }
//    }
//    
//    // Check for changes in the MAC
//    if (memcmp(&stored_uip_ethaddr_oct[0], &Pending_uip_ethaddr_oct[0], 6) != 0) {
//      // Write the new MAC to the EEPROM
//      {
//        int i;
//        for (i=0; i<6; i++) stored_uip_ethaddr_oct[i] = Pending_uip_ethaddr_oct[i];
//      }
//      // Update the MAC string
//      update_mac_string();
//      // A reboot will occur to cause this change to take effect
//      user_reboot_request = 1;
//    }
  }
  
  lock_eeprom(); // Make sure eeprom is locked
  
  
  // Decide if a restart or reboot is needed. If both are set the reboot
  // request will take precedence in the check_restart_reboot() function.
  //
  // Explanation of "user_reboot_request": This variable is used to commun-
  // icate that the user pressed a button in the GUI, or briefly pressed the
  // hardware Reset Button, that signals the need to reboot. We can't just set
  // "reboot_request" when a button click is detected because we need to make
  // sure a restart or reboot isn't already occurring.
  // Note: To simplify code user_reboot_request is also set when user changes
  // are detected in the check_runtime_changes() function. This eliminates an
  // additional check below.
  if (restart_request || user_reboot_request || user_restart_request) {
    // Arm the restart function but first make sure we aren't already
    // performing a restart or reboot so we don't get stuck in a loop.
    if (restart_reboot_step == RESTART_REBOOT_IDLE) {
      restart_reboot_step = RESTART_REBOOT_ARM;
    }
    if (user_restart_request) { // Did user request Restart?
      user_restart_request = 0;
      restart_request = 1;
    }
    if (user_reboot_request) { // Did user request Reboot?
      user_reboot_request = 0;
      reboot_request = 1;
    }
  }
  
  
  // We've set the restart_request or reboot_request bytes (if needed) and
  // will now return to the main loop where the restart or reboot routines
  // will be called. This is done this way because we need to let
  // uip_periodic() handle the closing of connections.

  // Reset parse_complete for future changes
  parse_complete = 0;
  mqtt_parse_complete = 0;

  // Periodic check of the stack overflow guardband
  if (stack_limit1 != 0xaa || stack_limit2 != 0x55) {
    stack_error = 1;
    fastflash();
    fastflash();
    
    // Report the stack overflow bit. The stack overflow indicator will remain
    // set (even through reboots) until cleared with the Clear Link Error
    // Statistics button or URL command.
    if (stack_error) {
      debug_bytes[2] |= 0x80;
      update_debug_storage1();
    }
  }
}

#if LINKED_SUPPORT == 1
uint8_t chk_iotype(uint8_t pin_byte, int pin_index, uint8_t chk_mask)
{
  // Determine if pin_byte (usually a pin_control byte) defines an input
  // or an output pin. Also apply a mask to check for other conditions.
  // Mask definition:
  //   0x03 = Only check the Pin Type (Disaabled, Input, Output, Linked)
  //   0x0b = Also check the Retain bit
  // Return values:
  //   If mask = 0x03:
  //     0x00 = Disabled
  //     0x01 = Input pin
  //     0x03 = Output pin
  //   If mask = 0x0b:
  //     0x00 = Disabled pin, Retain Not Applicable
  //     0x01 = Input pin, Retain Not Applicable
  //     0x03 = Output pin, Retain Not Set
  //     0x0b = Output pin, Retain Set
  //     
  // STM8 pins: This function will also check Linked pins to determine if they
  // are Inputs (pins 1 to 8) or Outputs (pins 9 to 16).
  // PCF8574 pins: This function will also check Linked pins to determine if
  // the are Inputs (pins 17 to 20) or Outputs (pins 21 to 24).
  //
  // 
  // STM8 pins: pin_index is 0 to 15 corresponding to pins 1 to 16
  // If Linked pin_index 0 to 7 must be inputs
  if (((pin_byte & 0x03) == 0x01)
  || (((pin_byte & 0x03) == 0x02) && (pin_index<8))) {
    // This is an Input or a Linked pin 1 to 8.
    return 0x01;
  }
  
#if PCF8574_SUPPORT == 1
  {
    // PCF8574 pins: pin_index is 16 to 23 corresponding to pins 17 to 24
    // If Linked pin_index 16 to 19 must be inputs
    if (((pin_byte & 0x03) == 0x01)
    || (((pin_byte & 0x03) == 0x02) && (pin_index>15) && (pin_index<20))) {
      // This is an Input or a Linked pin 17 to 20.
      return 0x01;
    }
  }
#endif // PCF8574_SUPPORT == 1
  
    
  // STM8 pins: pin_index is 0 to 15 corresponding to pins 1 to 16
  // If Linked pin_index 8 to 15 must be outputs
  if (((pin_byte & 0x03) == 0x03)
  || (((pin_byte & 0x03) == 0x02) && (pin_index>7) && (pin_index<16))) {
    // This is an output, or an output created by linking
    if (chk_mask == 0x03) return 0x03;
    if (chk_mask == 0x0b) {
      if (pin_byte & 0x08) return 0x0b; // Return with Retain set
      else return 0x03;
    }
  }
  
#if PCF8574_SUPPORT == 1
  {
    // PCF8574 pins: pin_index is 16 to 23 corresponding to pins 17 to 24
    // If Linked pin_index 20 to 23 must be outputs
    if (((pin_byte & 0x03) == 0x03)
    || (((pin_byte & 0x03) == 0x02) && (pin_index>19) && (pin_index<24))) {
      // This is an output, or an output created by linking
      if (chk_mask == 0x03) return 0x03;
      if (chk_mask == 0x0b) {
        if (pin_byte & 0x08) return 0x0b; // Return with Retain set
        else return 0x03;
      }
    }
  }
#endif // PCF8574_SUPPORT == 1
  
  // Else pin is Disabled so return 0
  return 0;
}
#endif // LINKED_SUPPORT == 1


void check_restart_reboot(void)
{
  // Function provides the sequence and timing required to shut down
  // connections and trigger a restart or reboot. This function is called
  // from the main loop and returns to the main loop so that the periodic()
  // function can run.
  
  unsigned char topic_base[55]; // Used for building connect, subscribe,
                                // and publish topic strings.
				// Publish string content:
                                //  NetworkModule/DeviceName123456789/input/xx
                                //  NetworkModule/DeviceName123456789/output/xx
                                //  NetworkModule/DeviceName123456789/temp/xxxxxxxxxxxx
                                //  NetworkModule/DeviceName123456789/temp/BME280-0xxxx
                                //  NetworkModule/DeviceName123456789/state
                                //  NetworkModule/DeviceName123456789/state24
				//  NetworkModule/DeviceName123456789/state-req
				//  NetworkModule/DeviceName123456789/state-req24
				// Subscribe string content:
                                //  NetworkModule/DeviceName123456789/output/+/set
				//  NetworkModule/DeviceName123456789/state-req
				//  NetworkModule/DeviceName123456789/state-req24
				// Last Will string content:
				//  NetworkModule/DeviceName123456789/availability
				// Home Assistant config string content:
				//  homeassistant/switch/macaddressxx/xx/config
				//  homeassistant/binary_sensor/macaddressxx/xx/config
				//  homeassistant/sensor/macaddressxx/yyyyyyyyyyyy/config
				//  homeassistant/sensor/macaddressxx/BME280-0xxxx/config
				//  homeassistant/sensor/macaddressxx/BME280-1xxxx/config
				//  homeassistant/sensor/macaddressxx/BME280-2xxxx/config

  if (restart_request || reboot_request) {
    // A restart or reboot has been requested. The restart and reboot
    // requests are set in the check_runtime_changes() function if a restart
    // or reboot is needed.
    // The following needs to occur:
    // 1) If MQTT is enabled run the mqtt_disconnect() function.
    // 1a) Verify that mqtt disconnect was sent to the MQTT server.
    // 1b) Call uip_close() for the MQTT TCP connection.
    // 2) Verify that the close requests completed.
    // 3) Run either the restart() function or the reboot() function.
    //    Reboot takes precedence over restart.

    switch(restart_reboot_step)
    {
    case RESTART_REBOOT_ARM:
      // Clear 100ms timer to delay the next step
      t100ms_ctr1 = 0;
      restart_reboot_step = RESTART_REBOOT_ARM2;
      break;

#if BUILD_SUPPORT == BROWSER_ONLY_BUILD
    case RESTART_REBOOT_ARM2:
      // Wait 1 second for anything in the process of being transmitted
      // to fully buffer. Refresh of a page after POST can take a few
      // seconds.
      if (t100ms_ctr1 > 9) restart_reboot_step = RESTART_REBOOT_FINISH;
      break;
#endif // BUILD_SUPPORT == BROWSER_ONLY_BUILD

#if BUILD_SUPPORT == MQTT_BUILD
    case RESTART_REBOOT_ARM2:
      // Wait 1 second for anything in the process of being transmitted to
      // complete, including all handshakes. Refresh of a page after POST can
      // take a few seconds.
      if (t100ms_ctr1 > 9) {
        if (mqtt_enabled) restart_reboot_step = RESTART_REBOOT_SENDOFFLINE;
	else restart_reboot_step = RESTART_REBOOT_FINISH;
        // Clear 100ms timer to delay the next step
        t100ms_ctr1 = 0;
      }
      break;

    case RESTART_REBOOT_SENDOFFLINE:
      if (t100ms_ctr1 > 2) {
       // We can only get here if mqtt_enabled == 1
       // Wait at least 100 ms before publishing availability message
       // This message is always published with QOS 0
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
      if (t100ms_ctr1 > 3) {
        // We can only get here if mqtt_enabled == 1
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
      if (t100ms_ctr1 > 3) {
        // We can only get here if mqtt_enabled == 1
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
      // We can only get here if mqtt_enabled == 1
      // Verify closed ... how?
      // For the moment I'm not sure how to do this, so I will just allow
      // enough time for it to happen. That is probably much faster, but I
      // will allow 500ms.
      if (t100ms_ctr1 > 6) {
	mqtt_close_tcp = 0;
        restart_reboot_step = RESTART_REBOOT_FINISH;
      }
      break;
#endif // BUILD_SUPPORT == MQTT_BUILD
    
    case RESTART_REBOOT_FINISH:
      if (reboot_request) {
        restart_reboot_step = RESTART_REBOOT_IDLE;
        // Hardware reboot
        reboot();
      }
      if (restart_request) {
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
  // Once restart() is complete code returns to the main while() loop.
  // Note: A reboot() is run (instead of restart() ) if any pin type changed
  // (input/output/disabled/etc). reboot() is needed in such a case so that
  // gpio_init() will run to reconfigure the GPIO hardware.

  LEDcontrol(0); // Turn LED off

  parse_complete = 0;
  reboot_request = 0;
  restart_request = 0;
  mqtt_close_tcp = 0;
  
#if BUILD_SUPPORT == MQTT_BUILD
  mqtt_start = MQTT_START_TCP_CONNECT;
  mqtt_start_status = MQTT_START_NOT_STARTED;
  mqtt_start_ctr1 = 0;
  mqtt_sanity_ctr = 0;
  MQTT_error_status = 0;
  mqtt_restart_step = MQTT_RESTART_IDLE;
  state_request = STATE_REQUEST_IDLE;
#endif // BUILD_SUPPORT == MQTT_BUILD
  
  apply_EEPROM_settings(); // Applies the EEPROM settings to runtime variables
                           // such as IP Address, Gateway Address, Netmask,
			   // Port number, etc. Needed in a restart to make
			   // sure all changes made on the Configuration page
			   // are applied.
			   
  initialize_pins();       // Initialize pins and IO state trackers for the
                           // STM8 and PCF8574 pins. This is done here because
			   // restart() was called after check_runtime_changes()
			   // where pin states may have changed due to a Save
			   // from the IOControl page. This step will make sure
			   // any pin state changes are properly recorded.
			   
  uip_arp_init();          // Initialize the ARP module. The only thing this
                           // does is clear the IP addresses in the ARP table.
			   
  uip_init();              // Initialize uIP. This function call sets all
                           // connections to "CLOSED" and clears out the
			   // uip_listenports table.
			   
  HttpDInit();             // Initialize httpd and set up listening port

  LEDcontrol(1); // Turn LED on
  // From here we return to the main loop and should start running with new
  // settings.
}


void reboot(void)
{
  // We need to do a hardware reset (reboot).
  // Caution: You would think this is just like a power-off / power-on. But
  // since power is not actually lost there could be variables in memory that
  // retain their values and get used in code at runtime if not properly set
  // by startup initialization.
  
  // Flicker LED for 1 second to indicate deliberate reboot
  fastflash();
  LEDcontrol(0);  // turn LED off

#if DEBUG_SUPPORT == 15
// UARTPrintf("Hardware reboot in reboot()\r\n");
#endif // DEBUG_SUPPORT == 15

  // Set the Window Watchdog to reboot the module
  // WWDG is used here instead of the IWDG so that the cause of a reset can be
  // differentiated. WWDG is used for a deliberate reset. IWDG is used to
  // protect agains unintentional code or processor upsets.
  WWDG_WR = (uint8_t)0x7f;     // Window register reset
  WWDG_CR = (uint8_t)0xff;     // Set watchdog to timeout in 49ms
  WWDG_WR = (uint8_t)0x60;     // Window register value - doesn't matter
                               // much as we plan to reset
				 
  while(1);                    // Wait for watchdog to generate reset
}


void init_IWDG(void)
{
  // Function to initialize the IWDG (Independent Watchdog).
  // The IWDG will perform a hardware reset after 1 second if it is not
  // serviced with a write to the IWDG_KR register - the main loop needs to
  // perform the servicing writes.
  //
  // The IWDG runs off the 128KHz LSI clock. That clock goes through a divide
  // by 2 element before entering a pre-scaler. The pre-scaler is set with a
  // divisor defined by IWDG_PR. In this case a value of 0x06 divides by 256
  // (see document RM0016). Setting IWDG_RLR to 0xff then results in a timeout
  // of about 1 second.
  
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



#if LINKED_SUPPORT == 0
#if PCF8574_SUPPORT == 0 && DOMOTICZ_SUPPORT == 0
void read_input_pins(uint8_t init_flag)
{
  // This function reads and debounces the Input pins. It is called from the
  // check_runtime_changes() function, which is in turn called from the main
  // loop. Thus this function runs about once per millisecond.
  //
  // The function works as follows:
  // - Pins are read and stored in the ON_OFF_word_new1 word.
  // - ON_OFF_word_new1 is compared to the prior value stored in
  //   ON_OFF_word_new2
  // - If a bit in ON_OFF_word_new1 is the same as in ON_OFF_word_new2 then
  //   ON_OFF_word is updated.
  // - ON_OFF_word_new1 is transferred to ON_OFF_word_new2 for the next round.
  //
  // Note: init_flag is not used when LINKED_SUPPORT == 0
  uint16_t mask;
  int i;
  int j;
  
  // Loop across all i/o's and read input port register:bit state
  // and 
  // Compare the _new1 and _new2 samples then, for Input pins only, update
  // the bits in the ON_OFF_word where the corresponding bits match in _new1
  // and _new2 (ie, a debounced change occurred).

  for (i=0, mask=1; i<16; i++, mask<<=1) {
    // Is the corresponding bit of the input port register set?
#if PINOUT_OPTION_SUPPORT == 0
    if ( io_reg[ io_map[i].port ].idr & io_map[i].bit)
#endif // PINOUT_OPTION_SUPPORT == 0
#if PINOUT_OPTION_SUPPORT == 1
    j = calc_PORT_BIT_index((uint8_t)i);
    if ( io_reg[ io_map[j].port ].idr & io_map[j].bit)
#endif // PINOUT_OPTION_SUPPORT == 1
      ON_OFF_word_new1 |= (uint16_t)mask;
    else
      ON_OFF_word_new1 &= (uint16_t)(~mask);
    
    if ((ON_OFF_word_new1 & mask) == (ON_OFF_word_new2 & mask)) {
      // If the old and new bits match, and the bit is for an Input
      // pin, set or clear the corresponding bit in ON_OFF_word.
      if ((pin_control[i] & 0x03) == 0x01) { // input?
        if (ON_OFF_word_new2 & mask) ON_OFF_word |= mask; // set
        else                         ON_OFF_word &= ~mask; // clear
      }
    }
  }

  // Copy _new1 to _new2 for the next round
  ON_OFF_word_new2 = ON_OFF_word_new1;
  
  // Update the pin_control bytes to match the debounced ON_OFF_word.
  // Only input pin_control bytes are updated.
  for (i=0, mask=1; i<16; i++, mask<<=1) {
    if ((pin_control[i] & 0x03) == 0x01) { // input?
      if (ON_OFF_word & mask) pin_control[i] |= 0x80;
      else                    pin_control[i] &= 0x7f;
    }
  }
}
#endif // PCF8574_SUPPORT == 0 && DOMOTICZ_SUPPORT == 0
#endif // LINKED_SUPPORT == 0


#if LINKED_SUPPORT == 0
#if PCF8574_SUPPORT == 1 || DOMOTICZ_SUPPORT == 1
// When the PCH8574 is present the ON_OFF words need to be 32 bit to
// accommodate 24 pins of IO. But pins 1 to 16 need to be mapped to hardware
// using the io.map, whereas pins 17 to 24 are directly read via the I2C bus.
//
// Domoticz creates a special case in that 32 bit words need to be used, so
// this code is compiled. However, if PCF8574_SUPPORT == 0 the PCF8574 pins
// will not be read.
void read_input_pins(uint8_t init_flag)
{
  // This function reads and debounces the Input pins. It is called from the
  // check_runtime_changes() function, which is in turn called from the main
  // loop. Thus this function runs about once per millisecond.
  //
  // The function works as follows:
  // - Pins are read and stored in the ON_OFF_word_new1 word.
  // - ON_OFF_word_new1 is compared to the prior value stored in
  //   ON_OFF_word_new2
  // - If a bit in ON_OFF_word_new1 is the same as in ON_OFF_word_new2 then
  //   ON_OFF_word is updated.
  // - ON_OFF_word_new1 is transferred to ON_OFF_word_new2 for the next round.
  //
  // Note: init_flag is not used when LINKED_SUPPORT == 0
  uint32_t mask;
  uint8_t byte;
  uint8_t byte_mask;
  int i;
  int j;
  
  
  // Loop across all i/o's on the STM8 and read input port register:bit state
  // and 
  // Compare the _new1 and _new2 samples then, for Input pins only, update
  // the bits in the ON_OFF_word where the corresponding bits match in _new1
  // and _new2 (ie, a debounced change occurred).

  for (i=0, mask=1; i<16; i++, mask<<=1) {
    // Is the corresponding bit of the input port register set?
#if PINOUT_OPTION_SUPPORT == 0
    if ( io_reg[ io_map[i].port ].idr & io_map[i].bit)
#endif // PINOUT_OPTION_SUPPORT == 0
#if PINOUT_OPTION_SUPPORT == 1
    j = calc_PORT_BIT_index((uint8_t)i);
    if ( io_reg[ io_map[j].port ].idr & io_map[j].bit)
#endif // PINOUT_OPTION_SUPPORT == 1
      ON_OFF_word_new1 |= (uint32_t)mask;
    else
      ON_OFF_word_new1 &= (uint32_t)(~mask);
    
    if ((ON_OFF_word_new1 & mask) == (ON_OFF_word_new2 & mask)) {
      // If the old and new bits match, and the bit is for an Input
      // pin, set or clear the corresponding bit in ON_OFF_word.
      if ((pin_control[i] & 0x03) == 0x01) { // input?
        if (ON_OFF_word_new2 & mask) ON_OFF_word |= mask; // set
        else                         ON_OFF_word &= ~mask; // clear
      }
    }
  }


#if PCF8574_SUPPORT == 1
  // Read the pin states on the PCF8574
  // Note: the non-upgradeable Domoticz build uses this code section, but the
  // non-upgradeable build does not support the PCF8574.
  byte = PCF8574_read();
  for (i=16, mask = 0x00010000, byte_mask=1; i<24; i++, mask<<=1, byte_mask<<=1) {
    // Is the corresponding bit of the PCF8574 pin set?
    if (byte & byte_mask)
      ON_OFF_word_new1 |= (uint32_t)mask;
    else
      ON_OFF_word_new1 &= (uint32_t)(~mask);
    
    if ((ON_OFF_word_new1 & mask) == (ON_OFF_word_new2 & mask)) {
      // If the old and new bits match, and the bit is for an Input
      // pin, set or clear the corresponding bit in ON_OFF_word.
      if ((pin_control[i] & 0x03) == 0x01) { // input?
        if (ON_OFF_word_new2 & mask) ON_OFF_word |= mask; // set
        else                         ON_OFF_word &= ~mask; // clear
      }
    }
  }
#endif // PCF8574_SUPPORT == 1


  // Copy _new1 to _new2 for the next round
  ON_OFF_word_new2 = ON_OFF_word_new1;


  // Update the pin_control bytes to match the debounced ON_OFF_word.
  // Only input pin_control bytes are updated.
  for (i=0, mask=1; i<24; i++, mask<<=1) {
    if ((pin_control[i] & 0x03) == 0x01) { // input?
      if (ON_OFF_word & mask) pin_control[i] |= 0x80;
      else                    pin_control[i] &= 0x7f;
    }
  }
}
#endif // PCF8574_SUPPORT == 1 || DOMOTICZ_SUPPORT == 1
#endif // LINKED_SUPPORT == 0


#if LINKED_SUPPORT == 1
#if PCF8574_SUPPORT == 0 && DOMOTICZ_SUPPORT == 0
void read_input_pins(uint8_t init_flag)
{
  // This function reads and debounces the Input pins. It is called from the
  // check_runtime_changes() function, which is in turn called from the main
  // loop. Thus this function runs about once per millisecond.
  //
  // The function works as follows:
  // - Pins are read and stored in the ON_OFF_word_new1 word.
  // - ON_OFF_word_new1 is compared to the prior value stored in
  //   ON_OFF_word_new2
  // - If a bit in ON_OFF_word_new1 is the same as in ON_OFF_word_new2 then
  //   ON_OFF_word is updated.
  // - ON_OFF_word_new1 is transferred to ON_OFF_word_new2 for the next round.
  uint16_t mask;
  int i;
  int j;
  
  // Loop across all i/o's and read input port register:bit state
  // and 
  // Compare the _new1 and _new2 samples then, for Input pins only, update
  // the bits in the ON_OFF_word where the corresponding bits match in _new1
  // and _new2 (ie, a debounced change occurred).
  for (i=0, mask=1; i<16; i++, mask<<=1) {
    // Is the corresponding bit of the input port register set?
#if PINOUT_OPTION_SUPPORT == 0
    if ( io_reg[ io_map[i].port ].idr & io_map[i].bit) {
#endif // PINOUT_OPTION_SUPPORT == 0
#if PINOUT_OPTION_SUPPORT == 1
    j = calc_PORT_BIT_index((uint8_t)i);
    if ( io_reg[ io_map[j].port ].idr & io_map[j].bit) {
#endif // PINOUT_OPTION_SUPPORT == 1
      ON_OFF_word_new1 |= (uint16_t)mask;
    }
    else {
      ON_OFF_word_new1 &= (uint16_t)(~mask);
    }
    
    if ((ON_OFF_word_new1 & mask) == (ON_OFF_word_new2 & mask)) {
      // Check for a debounced edge on pins 1 to 8
      if ((ON_OFF_word & mask) != (ON_OFF_word_new2 & mask)) {
        // If true this indicates that the _new1 and _new2 are equal but are
	// different than the existing ON_OFF_word. This means a debounced
	// edge just occured on the pin indicated by the mask. This is only
	// important for the Linked function, so record the event in the
	// linked_edge detection byte. For STM8 pins we only need to keep the
	// bits associated with pins 1 to 8.
	// Special Case: If init_flag is set DO NOT set change the linked_edge
	// byte. This is to allow input pins to be read and the ON_OFF_words
	// to be updated to the "time of boot" states without triggering
	// edge detection.
	if (((pin_control[i] & 0x03) == 0x02) && (i<8) && (init_flag == 0)) {
          linked_edge |= (uint8_t)(mask);
	}
      }
      
      // If the old and new bits match, and the bit is for an Input pin, set
      // or clear the corresponding bit in the ON_OFF_word.
      // Note this also applies to Linked pins 1 to 8 (which are also inputs).
      if (chk_iotype(pin_control[i], i, 0x03) == 0x01) {
        if (ON_OFF_word_new2 & mask) ON_OFF_word |= mask; // set
        else                         ON_OFF_word &= ~mask; // clear
      }
    }
  }

  // Copy _new1 to _new2 for the next round
  ON_OFF_word_new2 = ON_OFF_word_new1;
  
  // Update the pin_control bytes to match the debounced ON_OFF_word.
  // Only input pin_control bytes are updated.
  for (i=0, mask=1; i<16; i++, mask<<=1) {
    if (chk_iotype(pin_control[i], i, 0x03) == 0x01) {
      if (ON_OFF_word & mask) pin_control[i] |= 0x80;
      else                    pin_control[i] &= 0x7f;
    }
  }
}
#endif // PCF8574_SUPPORT == 0 && DOMOTICZ_SUPPORT == 0
#endif // LINKED_SUPPORT == 1


#if LINKED_SUPPORT == 1
#if PCF8574_SUPPORT == 1 || DOMOTICZ_SUPPORT == 1
void read_input_pins(uint8_t init_flag)
{
  // This function reads and debounces the Input pins. It is called from the
  // check_runtime_changes() function, which is in turn called from the main
  // loop. Thus this function runs about once per millisecond.
  //
  // Domoticz creates a special case in that 32 bit words need to be used, so
  // this code is compiled.
  //
  // The function works as follows:
  // - Pins are read and stored in the ON_OFF_word_new1 word.
  // - ON_OFF_word_new1 is compared to the prior value stored in
  //   ON_OFF_word_new2
  // - If a bit in ON_OFF_word_new1 is the same as in ON_OFF_word_new2 then
  //   ON_OFF_word is updated.
  // - ON_OFF_word_new1 is transferred to ON_OFF_word_new2 for the next round.
  uint32_t mask;
  uint8_t byte;
  uint8_t byte_mask;
  uint16_t linked_mask;
  int i;
  int j;
  
  // Loop across all STM8 i/o's and read input port register:bit state
  // and 
  // Compare the _new1 and _new2 samples then, for Input pins only, update
  // the bits in the ON_OFF_word where the corresponding bits match in _new1
  // and _new2 (ie, a debounced change occurred).
  for (i=0, mask=1; i<16; i++, mask<<=1) {
    // Is the corresponding bit of the input port register set?
#if PINOUT_OPTION_SUPPORT == 0
    if ( io_reg[ io_map[i].port ].idr & io_map[i].bit) {
#endif // PINOUT_OPTION_SUPPORT == 0
#if PINOUT_OPTION_SUPPORT == 1
    j = calc_PORT_BIT_index((uint8_t)i);
    if ( io_reg[ io_map[j].port ].idr & io_map[j].bit) {
#endif // PINOUT_OPTION_SUPPORT == 1
      ON_OFF_word_new1 |= (uint32_t)mask;
    }
    else {
      ON_OFF_word_new1 &= (uint32_t)(~mask);
    }
    
    if ((ON_OFF_word_new1 & mask) == (ON_OFF_word_new2 & mask)) {
      // Check for a debounced edge on pins 1 to 8
      if ((ON_OFF_word & mask) != (ON_OFF_word_new2 & mask)) {
        // If true this indicates that the _new1 and _new2 are equal but are
	// different than the existing ON_OFF_word. This means a debounced
	// edge just occured on the pin indicated by the mask. This is only
	// important for the Linked function, so record the event in the
	// linked_edge detection word.
	// For STM8 pins we only keep the linked_edge indicator for pins 1 to
	// 8.
	// For PCF8574 pins we only keep the bits associated with pins 17 to
	// 20.
	// Special Case: If init_flag is set DO NOT set the linked_edge
	// byte. This is to allow input pins to be read and the ON_OFF_words
	// to be updated to the "time of boot" states without triggering
	// edge detection.
	if (((pin_control[i] & 0x03) == 0x02) && (i<8) && (init_flag == 0)) {
	  // Update linked_edge for the 8 least significant bits.
          linked_edge |= (uint8_t)(mask);
	}
      }
    }
  }


#if PCF8574_SUPPORT == 1
  // Read the pin states on the PCF8574
  // Note: the non-upgradeable Domoticz build uses this code section, but the
  // non-upgradeable build does not support the PCF8574.
  byte = PCF8574_read();
  for (i=16, mask = 0x00010000, byte_mask=1, linked_mask=0x0100; i<24; i++, mask<<=1, byte_mask<<=1, linked_mask<<=1) {
    // Is the corresponding bit of the PCF8574 pin set?
    if (byte & byte_mask)
      ON_OFF_word_new1 |= (uint32_t)mask;
    else
      ON_OFF_word_new1 &= (uint32_t)(~mask);
    
    if ((ON_OFF_word_new1 & mask) == (ON_OFF_word_new2 & mask)) {
      // Check for a debounced edge on pins 17 to 20
      if ((ON_OFF_word & mask) != (ON_OFF_word_new2 & mask)) {
        // If true this indicates that the _new1 and _new2 are equal but are
	// different than the existing ON_OFF_word. This means a debounced
	// edge just occured on the pin indicated by the mask. This is only
	// important for the Linked function, so record the event in the
	// linked_edge detection word.
	// For STM8 pins we only keep the linked_edge indicator for pins 1 to
	// 8.
	// For PCF8574 pins we only keep the bits associated with pins 17 to
	// 20.
	// Special Case: If init_flag is set DO NOT set change the linked_edge
	// byte. This is to allow input pins to be read and the ON_OFF_words
	// to be updated to the "time of boot" states without triggering
	// edge detection.
	if (((pin_control[i] & 0x03) == 0x02) && i>15 && i<20 && (init_flag == 0)) {
          linked_edge |= linked_mask;
	}
      }
    }
  }
#endif // PCF8574_SUPPORT == 1
      
  for (i=0, mask=1; i<24; i++, mask<<=1) {
    if ((ON_OFF_word_new1 & mask) == (ON_OFF_word_new2 & mask)) {
      // If the old and new bits match, and the bit is for an Input
      // pin, set or clear the corresponding bit in ON_OFF_word.
      if (chk_iotype(pin_control[i], i, 0x03) == 0x01) { // input?
        if (ON_OFF_word_new2 & mask) ON_OFF_word |= mask; // set
        else                         ON_OFF_word &= ~mask; // clear
        // Update the pin_control bytes to match the debounced ON_OFF_word.
        // Only input pin_control bytes are updated.
        if (ON_OFF_word & mask) pin_control[i] |= 0x80;
        else                    pin_control[i] &= 0x7f;
      }
    }
  }

  // Copy _new1 to _new2 for the next round
  ON_OFF_word_new2 = ON_OFF_word_new1;  
}
#endif // PCF8574_SUPPORT == 1 || DOMOTICZ_SUPPORT == 1
#endif // LINKED_SUPPORT == 1



void encode_bit_registers(uint8_t sort_init)
{
  // Function to sort the pin control bytes into the bit registers.
  // sort_init == 1 indicates the function was called during initialization.
  //
  // When the PCF8574 and Domoticz are not supported the variables that store
  // IO bit activity (ON_OFF_word, ON_OFF_word_new1, ON_OFF_word_new2, 
  // ON_OFF_word_sent, and Invert_word) are all 16 bit entities, thus all
  // manipulation of those variables must be performed at a 16 bit level. When
  // the PCF8574 or Domoticz ARE supported then the variables are all 32 bit
  // entities and all manipulation of those variables must be performed at a
  // 32 bit level.
  
#if PCF8574_SUPPORT == 0 && DOMOTICZ_SUPPORT == 0
  {
    int i;
    uint16_t j;
    i = 0;
    j = 0x0001;
    while( i<16 ) {
      // Update the Invert_word
      if (pin_control[i] & 0x04) Invert_word = Invert_word |  j;
      else                       Invert_word = Invert_word & ~j;
      
      // Update the ON_OFF_word. This function can be called during boot
      // initialization at which time both Input pins and Output pins should
      // be sorted into the ON_OFF word. All other calls to this function
      // should only sort the Output pins into the ON_OFF word, as the
      // read_input_pins() function will handle this for Input pins.
      if (sort_init == 1) {
        // All pin states are sorted into the ON_OFF_word.
        if (pin_control[i] & 0x80) ON_OFF_word = ON_OFF_word |  j;
        else                       ON_OFF_word = ON_OFF_word & ~j;
      }
      else {
        // sort_init indicates the function was called during runtime. During
        // runtime only the Output pins and Linked pins 9 to 16 are sorted
        // into the ON_OFF_word. Input pins are handled by the read_input_pins()
        // function.
	
#if LINKED_SUPPORT == 0
        {
          if ((pin_control[i] & 0x03) == 0x03) {
            // Only the Output pins are sorted into the ON_OFF_word.
            if (pin_control[i] & 0x80) ON_OFF_word = ON_OFF_word |  j;
            else                       ON_OFF_word = ON_OFF_word & ~j;
	  }
        }
#endif // LINKED_SUPPORT == 0

#if LINKED_SUPPORT == 1
        {
          if (chk_iotype(pin_control[i], i, 0x03) == 0x03) {
            // Pin is an Output. Only the Output pins are sorted into the
            // ON_OFF_word.
            if (pin_control[i] & 0x80) ON_OFF_word = ON_OFF_word |  j;
            else                       ON_OFF_word = ON_OFF_word & ~j;
	  }
	}
#endif // LINKED_SUPPORT == 1
      }
      i++;
      j = j << 1;
    }
  }
#endif // PCF8574_SUPPORT == 0 && DOMOTICZ_SUPPORT == 0


#if PCF8574_SUPPORT == 1 || DOMOTICZ_SUPPORT == 1
  {
    int i;
    uint32_t j;
    i = 0;
    j = 0x00000001;
    while( i<24 ) {
      // Update the Invert_word
      if (pin_control[i] & 0x04) Invert_word = Invert_word |  j;
      else                       Invert_word = Invert_word & ~j;
      
      // Update the ON_OFF_word. This function can be called during boot
      // initialization at which time both Input pins and Output pins should
      // be sorted into the ON_OFF word. All other calls to this function
      // should only sort the Output pins into the ON_OFF word, as the
      // read_input_pins() function will handle this for Input pins.
      if (sort_init == 1) {
        // sort_init indicates the function was called during initialization.
        // All pin states are sorted into the ON_OFF_word.
        if (pin_control[i] & 0x80) ON_OFF_word = ON_OFF_word |  j;
        else                       ON_OFF_word = ON_OFF_word & ~j;
      }
      else {
        // sort_init indicates the function was called during runtime. During
        // runtime only the Output pins and STM8 Linked pins 9 to 16 and PCF8574
        // Linked pins 21 to 24 are sorted into the ON_OFF_word. Input pins are
        // handled by the read_input_pins() function.
	
#if LINKED_SUPPORT == 0
        {
          if ((pin_control[i] & 0x03) == 0x03) {
            // Only the Output pins are sorted into the ON_OFF_word.
            if (pin_control[i] & 0x80) ON_OFF_word = ON_OFF_word |  j;
            else                       ON_OFF_word = ON_OFF_word & ~j;
          }
	}
#endif // LINKED_SUPPORT == 0

#if LINKED_SUPPORT == 1
        {
          if (chk_iotype(pin_control[i], i, 0x03) == 0x03) {
            // Pin is an Output. Only the Output pins are sorted into the
            // ON_OFF_word.
            if (pin_control[i] & 0x80) ON_OFF_word = ON_OFF_word |  j;
            else                       ON_OFF_word = ON_OFF_word & ~j;
          }
	}
#endif // LINKED_SUPPORT == 1
      }
      i++;
      j = j << 1;
    }
  }
#endif // PCF8574_SUPPORT == 1 || DOMOTICZ_SUPPORT == 1
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
  //
  // When the PCF8574 and Domoticz are not supported the variables that store
  // IO bit activity (ON_OFF_word, ON_OFF_word_new1, ON_OFF_word_new2, 
  // ON_OFF_word_sent, and Invert_word) are all 16 bit entities, thus all
  // manipulation of those variables must be performed at a 16 bit level. When
  // the PCF8574 or Domoticz ARE supported then the variables are all 32 bit
  // entities and all manipulation of those variables must be performed at a
  // 32 bit level.
  
#if PCF8574_SUPPORT == 0 && DOMOTICZ_SUPPORT == 0
  {
    uint16_t xor_tmp;
    uint16_t xor_tmp_mask;
    // it's cheaper in terms of code space using int, instead of uint8_t !
    int i;
    int j;

    // Update the output pins to match the bits in the ON_OFF_word.
    // To simplify code this function writes all pins. Note that if the pin is
    // configured as an Input writing the ODR will have no effect, thus the
    // routine does not need to check if the pin is an input or output.

    // Invert the output if the Invert_word has the corresponding bit set.
    xor_tmp = (uint16_t)(Invert_word ^ ON_OFF_word);

    // Loop across all IO and set or clear them according to the mask
    // Skip IO pins that are being used for UART, I2C or DS18B20  
//    for (i=0; i<16; i++) {
    for (i=0, xor_tmp_mask=1; i<16; i++, xor_tmp_mask<<=1) {
#if DEBUG_SUPPORT == 15
      {
        // If UART support is enabled do not write Output 11
        if (i == 10) continue; // Output 11
      }
#endif // DEBUG_SUPPORT == 15

#if I2C_SUPPORT == 1
      {
        // If I2C support is enabled do not write Output 14 and 15
        if (i == 13) continue; // Output 14
        if (i == 14) continue; // Output 15
      }
#endif // I2C_SUPPORT == 1

#if DS18B20_SUPPORT == 1
      {
        // If DS18B20 mode is enabled do not write Output 16
        if (i == 15 && (stored_config_settings & 0x08))
          break;
      }
#endif // DS18B20_SUPPORT == 1

#if PINOUT_OPTION_SUPPORT == 0
      {
//        if (xor_tmp & (1 << i)) {
        if (xor_tmp & xor_tmp_mask) {
          io_reg[ io_map[i].port ].odr |= io_map[i].bit;
        }
        else {
          io_reg[ io_map[i].port ].odr &= (uint8_t)(~io_map[i].bit);
        }
      }
#endif // PINOUT_OPTION_SUPPORT == 0

#if PINOUT_OPTION_SUPPORT == 1
      {
        j = calc_PORT_BIT_index((uint8_t)i);
//        if (xor_tmp & (1 << i)) {
        if (xor_tmp & xor_tmp_mask) {
          io_reg[ io_map[j].port ].odr |= io_map[j].bit;
        }
        else {
          io_reg[ io_map[j].port ].odr &= (uint8_t)(~io_map[j].bit);
        }
      }
#endif // PINOUT_OPTION_SUPPORT == 1
    }
  }
#endif // PCF8574_SUPPORT == 0 && DOMOTICZ_SUPPORT == 0


#if PCF8574_SUPPORT == 1 || DOMOTICZ_SUPPORT == 1
  {
    // This function updates the Output GPIO pins to match the output pin
    // states.
    //
    // xor_temp combines the ON_OFF_word with the Invert_word as follows:
    //   If the Invert_word bit associated with a given pin is = 0, then a 0 in
    //   the associated bit of the ON_OFF_word sets the output pin to 0.
    //   If the Invert_word bit associated with a given pin is = 1, then a 0 in
    //   the associated bit of the ON_OFF_word sets the output pin to 1.

    uint32_t xor_tmp;
    uint32_t xor_tmp_mask;
    uint8_t byte;
    uint8_t mask;
    int i;
    int j;

    // Update the output pins to match the bits in the ON_OFF_word.
    //
    // STM8 pins: To simplify code this function writes all STM8 pins. Note that
    // if the STM8 pin is configured as an Input writing the ODR will have no
    // effect, thus the routine does not need to check if the STM8 pin is an
    // input or output.
    //
    // PCF8574 pins: Pins defined as inputs by their respective pin_control[]
    // byte must NEVER be written with 0. The typical way a PCF8574 IO pin is
    // handled as an input is to write it to "1" when it is initially defined as
    // an input, then never write it again. In this application that is a bit
    // problematic, so this function will write the PCF8574 input pins to "1"
    // any time the PCF8574 pins are updated. This works because even if the
    // external driver connected to the input is at a zero state the "1" write
    // performed here will produce a brief "glitch" on the PCF8574 pin before
    // the external driver drives the input pin back to the correct input state.
    // In the manual it is recommended that the signal driving the input pin do
    // so through a resistor to reduce the current flow during the brief
    // conflict period when a "1" is written.
  
    // Invert the output if the Invert_word has the corresponding bit set.
    xor_tmp = (uint32_t)(Invert_word ^ ON_OFF_word);

    // Loop across all IO and set or clear them according to the mask.
    // Skip IO pins that are being used for UART, I2C or DS18B20.
//    for (i=0; i<16; i++) {
    for (i=0, xor_tmp_mask=1; i<16; i++, xor_tmp_mask<<=1) {
#if DEBUG_SUPPORT == 15
      {
        // If UART support is enabled do not write Output 11
        if (i == 10) continue; // Output 11
      }
#endif // DEBUG_SUPPORT == 15

#if I2C_SUPPORT == 1
      {
        // If I2C support is enabled do not write Output 14 and 15
        if (i == 13) continue; // Output 14
        if (i == 14) continue; // Output 15
      }
#endif // I2C_SUPPORT == 1

#if DS18B20_SUPPORT == 1
      {
        // If DS18B20 mode is enabled do not write Output 16
        if ((i == 15) && (stored_config_settings & 0x08)) {
          break;
        }
      }
#endif // DS18B20_SUPPORT == 1

#if PINOUT_OPTION_SUPPORT == 0
      {
//        if (xor_tmp & (1 << i)) {
        if (xor_tmp & xor_tmp_mask) {
          io_reg[ io_map[i].port ].odr |= io_map[i].bit;
#if DEBUG_SUPPORT == 15
// if (uart_init_complete == 1) {
//   if (i == 15) {
//     UARTPrintf("Write 1 to IO16\r\n");
//   }
// }
#endif // DEBUG_SUPPORT == 15
        }
        else {
          io_reg[ io_map[i].port ].odr &= (uint8_t)(~io_map[i].bit);
#if DEBUG_SUPPORT == 15
// if (uart_init_complete == 1) {
//   if (i == 15) {
//     UARTPrintf("Write 0 to IO16\r\n");
//   }
// }
#endif // DEBUG_SUPPORT == 15
        }
      }
#endif // PINOUT_OPTION_SUPPORT == 0

#if PINOUT_OPTION_SUPPORT == 1
      {
        j = calc_PORT_BIT_index((uint8_t)i);
//        if (xor_tmp & (1 << i)) {
        if (xor_tmp & xor_tmp_mask) {
          io_reg[ io_map[j].port ].odr |= io_map[j].bit;
        }
        else {
          io_reg[ io_map[j].port ].odr &= (uint8_t)(~io_map[j].bit);
        }
      }
#endif // PINOUT_OPTION_SUPPORT == 1
    }


#if DEBUG_SUPPORT == 15
// if (uart_init_complete == 1) {
//   if (i == 15) {
//     UARTPrintf("pin_control IO16 = ");
//     emb_itoa(pin_control[15], OctetArray, 16, 2);
//     UARTPrintf(OctetArray);
//     UARTPrintf("   xor_tmp = ");
//     emb_itoa(xor_tmp, OctetArray, 16, 8);
//     UARTPrintf(OctetArray);
//     UARTPrintf("   PC_DDR = ");
//     emb_itoa(PC_DDR, OctetArray, 16, 2);
//     UARTPrintf(OctetArray);
//     UARTPrintf("   PC_ODR = ");
//     emb_itoa(PC_ODR, OctetArray, 16, 2);
//     UARTPrintf(OctetArray);
//     if (PC_ODR == 0x42) {
//       UARTPrintf("   X");
//     }
//     if (PC_ODR == 0x02) {
//       UARTPrintf("   XXXXXXXXXXXXXXXX");
//     }
//     UARTPrintf("\r\n");
//   }
// }
#endif // DEBUG_SUPPORT == 15


#if PCF8574_SUPPORT == 1
    {
      // Write the PCF8574 pins
      // Domoticz creates a special case in that the Domoticz non-upgradeable
      // build will have DOMOTICZ_SUPPORT set to 1, but will have PCF8574_SUPPORT
      // set to 0. So the PCF8574 pin writes are ommitted in that case.
      byte = (uint8_t)(xor_tmp >> 16);
      for (i=16, mask=1; i<24; i++, mask<<=1) {
  
#if LINKED_SUPPORT == 0
        {
          if ((pin_control[i] & 0x03) == 0x01) {
            // Pin is an input. Always set PCF8574 Input pins to "1" so that they
            // can be driven to the proper state by external hardware logic.
            if ((byte & mask) == 0) byte |= mask;
	    // XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
	    // The above could just be byte |= mask, no need for an if statement
	    // XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
          }
        }
#endif // LINKED_SUPPORT == 0

#if LINKED_SUPPORT == 1
        {
          if (chk_iotype(pin_control[i], i, 0x03) == 0x01) {
            // Pin is an input. Always set PCF8574 Input pins to "1" so that they
            // can be driven to the proper state by external hardware logic.
            if ((byte & mask) == 0) byte |= mask;
	    // XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
	    // The above could just be byte |= mask, no need for an if statement
	    // XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
          }
        }
#endif // LINKED_SUPPORT == 1

      }
      // Write the resulting byte to the PCF8574. Output pins will be written as
      // defined in xor_temp. Input pins will always be written to "1".
      PCF8574_write(byte);
    }

#if DEBUG_SUPPORT == 15
/*
if (uart_init_complete == 1) {
  UARTPrintf("pin_control for IO16 = ");
  emb_itoa(pin_control[15], OctetArray, 16, 2);
  UARTPrintf(OctetArray);
  UARTPrintf("   Invert_word = ");
  emb_itoa(Invert_word, OctetArray, 16, 8);
  UARTPrintf(OctetArray);
  UARTPrintf("   ON_OFF_word = ");
  emb_itoa(ON_OFF_word, OctetArray, 16, 8);
  UARTPrintf(OctetArray);
  UARTPrintf("   stored_config_settings = ");
  emb_itoa(stored_config_settings, OctetArray, 16, 2);
  UARTPrintf(OctetArray);
  UARTPrintf("\r\n");
}
*/
#endif // DEBUG_SUPPORT == 15

#endif // PCF8574_SUPPORT == 1
  }
#endif // PCF8574_SUPPORT == 1 || DOMOTICZ_SUPPORT == 1
}



/*
#if BUILD_SUPPORT == BROWSER_ONLY_BUILD
uint32_t calculate_timer(uint16_t timer_value)
{
  // Calculate the pin_timer value from the IO_TIMER value
  // as follows:
  //   If units = 0.1s pin_timer = IO_TIMER Value + 1
  //   If units = 1s   pin_timer = IO_TIMER Value * 10 + 1
  //   If units = 1m   pin_timer = IO_TIMER Value * 10 * 60
  //   If units = 1h   pin_timer = IO_TIMER Value * 10 * 60 * 60
  //   (note for manual: Any setting selected may be up to 100ms
  //    longer than the selected value)
  if ((timer_value & 0xc000) == 0x0000) return (uint32_t)(           (timer_value & 0x3fff)          );
  if ((timer_value & 0xc000) == 0x4000) return (uint32_t)(((uint32_t)(timer_value & 0x3fff) * 10U)   );
  if ((timer_value & 0xc000) == 0x8000) return (uint32_t)(((uint32_t)(timer_value & 0x3fff) * 600U)  );
  if ((timer_value & 0xc000) == 0xc000) return (uint32_t)(((uint32_t)(timer_value & 0x3fff) * 36000U));
  return 0;
}
#endif // BUILD_SUPPORT == BROWSER_ONLY_BUILD
*/


#if BUILD_SUPPORT == BROWSER_ONLY_BUILD
void decrement_pin_timers(void)
{
  int i;
  // This function decrements the pin_timers as needed.
  // This function is called once per 100ms, however pin_timers are
  // decremented at 0.1 second, 1 second, 1 minute, or 1 hour intervals
  // depending on the settings for that counter.
#if PCF8574_SUPPORT == 0
  for(i=0; i<16; i++) {
#endif // PCF8574_SUPPORT == 0
#if PCF8574_SUPPORT == 1
  for(i=0; i<23; i++) {
#endif // PCF8574_SUPPORT == 1
    if ((pin_timer[i] & 0x3fff) > 0) { // Do not decrement if already zero
      if ((pin_timer[i] & 0xc000) == 0x0000) {
        // 0.1 second resolution. Decrement timer.
        pin_timer[i]--;
      }
      if ((pin_timer[i] & 0xc000) == 0x4000) {
        // 1 second resolution
	if ((second_counter & 0x01) == (timer_flags & 0x01)) {
	  // Second_counter matches second_flag. Decrement timer.
          pin_timer[i]--;
	  // Invert second_flag to enable a repeat of this process.
	  if (timer_flags & 0x01) {
	    timer_flags &= (uint8_t)(~0x01);
	  }
	  else timer_flags |= 0x01;
	}
      }
      if ((pin_timer[i] & 0xc000) == 0x8000) {
        // 1 minute resolution
	if (((second_counter & 0x3c) == 0x3c) && (timer_flags & 0x02)) {
	  // Second_counter at 60 second interval and minute_flag is set.
	  // Decrement timer.
          pin_timer[i]--;
	  // Invert the minute_flag to disable this compare.
	  timer_flags &= (uint8_t)(~0x02);
	}
	if ((second_counter & 0x3d) == 0x3d) {
	  // At next second_counter interval set the minute_flag to enable a
	  // repeat of this process.
	  timer_flags |= 0x02;
	}
      }
      if ((pin_timer[i] & 0xc000) == 0xc000) {
        // 1 hour resolution
	if (((second_counter & 0xe10) == 0xe10) && (timer_flags & 0x04)) {
	  // Second_counter at 3600 second interval and hour_flag is set.
	  // Decrement timer.
          pin_timer[i]--;
	  // Invert the minute_flag to disable this compare.
	  timer_flags &= (uint8_t)(~0x04);
	}
	if ((second_counter & 0xe11) == 0xe11) {
	  // At next second_counter interval set the hour_flag to enable a
	  // repeat of this process.
	  timer_flags |= 0x04;
	}
      }
    }
  }
}
#endif // BUILD_SUPPORT == BROWSER_ONLY_BUILD


void check_reset_button(void)
{
  // Check to see if the button is pressed.
  int i;
  
  if ((PA_IDR & 0x02) == 0x00) {
    // Reset Button pressed
    for (i=0; i<100; i++) {
      wait_timer(50000); // wait 50ms
      IWDG_KR = 0xaa; // Prevent the IWDG hardware watchdog from firing.
      if ((PA_IDR & 0x02) == 0x02) {
        // Reset Button released.
	//
	// If the button is released in less than 1 second it is assumed the
	// button press was unintentional and the function returns with no
	// effect on operation (other than the module being held here for that
	// time).
	//
	// If pressed for 1 second (but less than 5 seconds) a
	// user_reboot_request is signaled to cause a reboot() via the main
	// loop. This will restart the module without losing settings.
	if (i > 20) {
	  user_reboot_request = 1;
#if LOGIN_SUPPORT == 1
	  // An added requirement is to Disable the Login function. This is
	  // the only method of fixing a "forgot my Passphrase" situation.
	  {
	    uint8_t value;
	    value = stored_config_settings;
	    value &= (uint8_t)~0x40;
	    // Update the stored_config_settings value in EEPROM.
            update_settings_options(UPDATE_CONFIG_SETTINGS, value);
	  }
#endif // LOGIN_SUPPORT == 1
	}
	return;
      }
    }
    
    // If we got here the button remained pressed for 5 seconds causing the
    // for() loop above to time out.
    // Turn off the LED, clear the magic number, and reset the device.
    // Clearing the magic number will cause the module to return to default
    // settings.
    LEDcontrol(0);  // turn LED off
    unlock_eeprom();
    stored_magic4 = 0x00;
    stored_magic3 = 0x00;
    stored_magic2 = 0x00;
    stored_magic1 = 0x00;
    lock_eeprom();

    while((PA_IDR & 0x02) == 0x00) {  // Wait for button release
    }

#if DEBUG_SUPPORT == 15
// UARTPrintf("Reboot in check_reset_button() function\r\n");
#endif // DEBUG_SUPPORT == 15

    // Set the Window Watchdog to reboot the module
    // WWDG is used here instead of the IWDG so that the cause of a reset can be
    // differentiated. WWDG is used for a deliberate reset. IWDG is used to
    // protect agains unintentional code or processor upsets.
    WWDG_WR = (uint8_t)0x7f;       // Window register reset
    WWDG_CR = (uint8_t)0xff;       // Set watchdog to timeout in 49ms
    WWDG_WR = (uint8_t)0x60;       // Window register value - doesn't matter
                                   // much as we plan to reset
				 
    while(1);                      // Wait for watchdog to generate reset

  }
}


void debugflash(void)
{
  // DEBUG - BLINK LED ON/OFF
  // Turns LED off for 1/2 second, then on and waits 1/2 second
  
  int i;
  
  LEDcontrol(0);     // turn LED off
  for(i=0; i<10; i++) wait_timer((uint16_t)50000); // wait 500ms
  
  IWDG_KR = 0xaa; // Prevent the IWDG hardware watchdog from firing.
  
  LEDcontrol(1);     // turn LED on
  for(i=0; i<10; i++) wait_timer((uint16_t)50000); // wait 500ms
  
  IWDG_KR = 0xaa; // Prevent the IWDG hardware watchdog from firing.
}


void fastflash(void)
{
  // DEBUG - BLINK LED ON/OFF
  // Makes LED flicker for 1 second then leaves LED ON
  
  int i;

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
  // Turns LED off for 25ms then back on

  LEDcontrol(0);     // turn LED off
  wait_timer((uint16_t)25000); // wait 25ms
  
  LEDcontrol(1);     // turn LED on
}


void restore_eeprom_debug_bytes(void)
{
  // Restore debug_bytes from EEPROM to RAM
  
  debug_bytes[0] = stored_debug_bytes[0]; // debug[0]: Not currently used
  debug_bytes[1] = stored_debug_bytes[1]; // debug[1]: Not currently used
  
  // debug[2]: The ENC28J60 revision part of debug[2] is restored in the
  // Enc28j60Init() function. Only restore the stack_overflow bit.
//  if ((stored_debug_bytes[2] & 0x80) == 0x80) debug_bytes[2] |= 0x80;
  debug_bytes[2] = (uint8_t)(stored_debug_bytes[2] & 0x80);
  
  // While the following diagnostic counters are mostly useful for checking
  // for the need for Full Duplex in an MQTT setting, they may still be useful
  // in other scenarios, so they remain functional even if MQTT is not
  // enabled.
  debug_bytes[3] = stored_debug_bytes[3];      // Restore the TXERIF error counter
  debug_bytes[4] = stored_debug_bytes[4];      // Restore the RXERIF error counter
  
  // Restore the counts for EMCF, SWIMF, ILLOPF, IWDGF, WWDGF
  memcpy(&debug_bytes[5], &stored_debug_bytes[5], 5);
}


void update_debug_storage1() {
  int i;
  
  // This function writes the debug[] values to EEPROM. The write occurs only
  // if the debug[] value differs from what is in EEPROM to prevent excessive
  // EEPROM writes.
  unlock_eeprom();
  for (i = 0; i < 10; i++) {
    if (stored_debug_bytes[i] != debug_bytes[i]) {
      stored_debug_bytes[i] = debug_bytes[i];
    }
  }
  lock_eeprom();  
}


#if DEBUG_SUPPORT == 15
void check_rst_sr(void)
{
  // Check RST_SR (Reset Status Register)
  if (RST_SR & 0x1f) {
    // Bit 4 EMCF: EMC reset flag
    if (RST_SR & 0x10) debug_bytes[5] = (uint8_t)(debug_bytes[5] + 1);
    // Bit 3 SWIMF: SWIM reset flag
    if (RST_SR & 0x08) debug_bytes[6] = (uint8_t)(debug_bytes[6] + 1);
    // Bit 2 ILLOPF: Illegal opcode reset flag
    if (RST_SR & 0x04) debug_bytes[7] = (uint8_t)(debug_bytes[7] + 1);
    // Bit 1 IWDGF: Independent Watchdog reset flag
    if (RST_SR & 0x02) debug_bytes[8] = (uint8_t)(debug_bytes[8] + 1);
    // Bit 0 WWDGF: Window Watchdog reset flag
    if (RST_SR & 0x01) debug_bytes[9] = (uint8_t)(debug_bytes[9] + 1);
    update_debug_storage1();
    RST_SR = (uint8_t)(RST_SR | 0x1f); // Clear the flags
  }
}
#endif // DEBUG_SUPPORT == 15


/*
#if DEBUG_SUPPORT == 15
#if PCF8574_SUPPORT == 1
void PCF8574_display_pin_control(void)
{
// Diagnostic routine to read the PCF8574 pin_control bytes from the I2C
// EEPROM and display them via the UART.
  int i;
  uint8_t byte[8];
  
//  UARTPrintf("Called PCF8574_display_pin_control\r\n");
  // Read the pin_control bytes from I2C EEPROM for the PCF8574 pins
  prep_read(I2C_EEPROM_R2_WRITE, I2C_EEPROM_R2_READ, PCF8574_I2C_EEPROM_R2_PIN_CONTROL_STORAGE, 2);
  for (i=0; i<7; i++) {
    byte[i] = I2C_read_byte(0);
  }
  byte[7] = I2C_read_byte(1);
  
  // Display the non-volatile pin_control bytes
  UARTPrintf("PCF8574 pin_control bytes from EEPROM:       ");
  for (i=0; i<8; i++) {
    emb_itoa(byte[i], OctetArray, 16, 2);
    UARTPrintf(OctetArray);
    UARTPrintf(" ");
  }
  UARTPrintf("\r\n");
  
  // Display the RAM pin_control bytes
  UARTPrintf("PCF8574 pin_control bytes from RAM:          ");
  for (i=16; i<24; i++) {
    emb_itoa(pin_control[i], OctetArray, 16, 2);
    UARTPrintf(OctetArray);
    UARTPrintf(" ");
  }
  UARTPrintf("\r\n");
  
  // Display the RAM Pending_pin_control bytes
  UARTPrintf("PCF8574 Pending_pin_control bytes from RAM:  ");
  for (i=16; i<24; i++) {
    emb_itoa(Pending_pin_control[i], OctetArray, 16, 2);
    UARTPrintf(OctetArray);
    UARTPrintf(" ");
  }
  UARTPrintf("\r\n");
}
#endif // PCF8574_SUPPORT == 1
#endif // DEBUG_SUPPORT == 15
*/

/*
#if DEBUG_SUPPORT == 15
void STM8_display_pin_control(void)
{
// Diagnostic routine to display the STM8 pin_control bytes via the UART.
  int i;
  uint8_t byte[8];
  
//  UARTPrintf("Called PCF8574_display_pin_control\r\n");
  
  // Display the non-volatile pin_control bytes
  UARTPrintf("STM8 pin_control bytes from EEPROM:       ");
  for (i=0; i<16; i++) {
    emb_itoa(stored_pin_control[i], OctetArray, 16, 2);
    UARTPrintf(OctetArray);
    UARTPrintf(" ");
  }
  UARTPrintf("\r\n");
  
  // Display the RAM pin_control bytes
  UARTPrintf("STM8 pin_control bytes from RAM:          ");
  for (i=0; i<16; i++) {
    emb_itoa(pin_control[i], OctetArray, 16, 2);
    UARTPrintf(OctetArray);
    UARTPrintf(" ");
  }
  UARTPrintf("\r\n");
  
  // Display the RAM Pending_pin_control bytes
  UARTPrintf("STM8 Pending_pin_control bytes from RAM:  ");
  for (i=0; i<16; i++) {
    emb_itoa(Pending_pin_control[i], OctetArray, 16, 2);
    UARTPrintf(OctetArray);
    UARTPrintf(" ");
  }
  UARTPrintf("\r\n");
}
#endif // DEBUG_SUPPORT == 15
*/
