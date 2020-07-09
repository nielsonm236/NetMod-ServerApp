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
#include "uip_TcpAppHub.h"

// EEPROM variable declarations
// IT SEEMS ALL @eeprom DECLARATIONS AND USAGE MUST BE IN ONE FILE (like
// main.c). Not sure about this - will need more experimentation.
// EEPROM operation
// When using the Cosmic compiler all variables stored in EEPROM must
// be declared with the @eeprom identifier. This signals the Cosmic
// compiler and linker to treat the variables as special and located in
// the EEPROM. Code must unlock the EEPROM before using the variables.
// NOTE1: The linker places the @eeprom variables in memory in reverse
// order from the declarations below. SO - if any debug variables are
// added it is recommended that they be declared ABOVE the Operating
// Code variables to keep the Operating Code variables from being
// relocated in the memory.
// NOTE2: The order of the Operating Code variables should not be changed
// if you want code updates to work without losing stored values.
// NOTE3: Similar to NOTE1, if you add any new Operating Code variables
// they should be added above the "magic" numbers in the list below.
// That will keep all existing variables in the same place in EEPROM
// which will allow new code updates to discover the magic number and
// existing settings.
// EEPROM Operating Code Variables:
// >>> Add new variables HERE <<<
@eeprom uint8_t magic4;			// MSB Magic Number stored in EEPROM
@eeprom uint8_t magic3;			//
@eeprom uint8_t magic2;			//
@eeprom uint8_t magic1;			// LSB Magic Number
@eeprom uint8_t stored_hostaddr4;	// MSB hostaddr stored in EEPROM
@eeprom uint8_t stored_hostaddr3;	//
@eeprom uint8_t stored_hostaddr2;	//
@eeprom uint8_t stored_hostaddr1;	// LSB hostaddr
@eeprom uint8_t stored_draddr4;		// MSB draddr stored in EEPROM
@eeprom uint8_t stored_draddr3;		//
@eeprom uint8_t stored_draddr2;		//
@eeprom uint8_t stored_draddr1;		// LSB draddr
@eeprom uint8_t stored_netmask4;	// MSB netmask stored in EEPROM
@eeprom uint8_t stored_netmask3;	//
@eeprom uint8_t stored_netmask2;	//
@eeprom uint8_t stored_netmask1;	// LSB netmask
@eeprom uint16_t stored_port;		// Port stored in EEPROM
@eeprom uint8_t stored_uip_ethaddr1;	// MAC MSB
@eeprom uint8_t stored_uip_ethaddr2;	//
@eeprom uint8_t stored_uip_ethaddr3;	//
@eeprom uint8_t stored_uip_ethaddr4;	//
@eeprom uint8_t stored_uip_ethaddr5;	//
@eeprom uint8_t stored_uip_ethaddr6;	// MAC LSB stored in EEPROM
@eeprom uint8_t stored_Relays_16to9;    // Relay states for relays 16 to 9
@eeprom uint8_t stored_Relays_8to1;     // Relay states for relays 8 to 1
@eeprom uint8_t stored_invert_output;   // Relay state inversion control
@eeprom uint8_t stored_devicename[20];  // Device name

uint16_t Port_Httpd;

uint8_t Relays_16to9;
uint8_t Relays_8to1;
uint8_t invert_output;

uip_ipaddr_t IpAddr;

// The variables stored in EEPROM can only be accessed within the
// file in which they are declared. But I need to display them from
// within the httpd.c file. So additional variables are needed to
// allow this to work.
uint8_t ex_stored_hostaddr4;	   // MSB hostaddr stored in EEPROM
uint8_t ex_stored_hostaddr3;	   //
uint8_t ex_stored_hostaddr2;	   //
uint8_t ex_stored_hostaddr1;	   // LSB hostaddr
uint8_t ex_stored_draddr4;	   // MSB draddr stored in EEPROM
uint8_t ex_stored_draddr3;	   //
uint8_t ex_stored_draddr2;	   //
uint8_t ex_stored_draddr1;	   // LSB draddr
uint8_t ex_stored_netmask4;	   // MSB netmask stored in EEPROM
uint8_t ex_stored_netmask3;	   //
uint8_t ex_stored_netmask2;	   //
uint8_t ex_stored_netmask1;	   // LSB netmask
uint16_t ex_stored_port;	   // Port stored in EEPROM
uint8_t ex_stored_devicename[20];  // Device name

uint8_t Pending_hostaddr4;
uint8_t Pending_hostaddr3;
uint8_t Pending_hostaddr2;
uint8_t Pending_hostaddr1;

uint8_t Pending_draddr4;
uint8_t Pending_draddr3;
uint8_t Pending_draddr2;
uint8_t Pending_draddr1;

uint8_t Pending_netmask4;
uint8_t Pending_netmask3;
uint8_t Pending_netmask2;
uint8_t Pending_netmask1;

uint16_t Pending_port;

uint8_t Pending_uip_ethaddr6;
uint8_t Pending_uip_ethaddr5;
uint8_t Pending_uip_ethaddr4;
uint8_t Pending_uip_ethaddr3;
uint8_t Pending_uip_ethaddr2;
uint8_t Pending_uip_ethaddr1;

uint8_t uip_ethaddr6;
uint8_t uip_ethaddr5;
uint8_t uip_ethaddr4;
uint8_t uip_ethaddr3;
uint8_t uip_ethaddr2;
uint8_t uip_ethaddr1;

uint8_t submit_changes;
uint8_t devicename_changed;

/*---------------------------------------------------------------------------*/
int
main(void)
{
  int i;
  uip_ipaddr_t IpAddr;
  
  devicename_changed = 0;
  submit_changes = 0;
  
  clock_init();            // Initialize and enable clocks and timers
  
  gpio_init();             // Initialize and enable gpio pins
  
  spi_init();              // Initialize the SPI bit bang interface to the
                           // ENC28J60 and perform hardware reset on ENC28J60

  LEDcontrol(1);           // turn LED on
  
  unlock_eeprom();         // unlock the EEPROM so writes can be performed

  check_eeprom_settings(); // Check the EEPROM for previously stored Address
                           // and Relay settings. Use defaults (if nothing
			   // stored) or restore previously stored settings.
  
  Enc28j60Init();          // Initialize the ENC28J60 ethernet interface

  uip_arp_init();          // Initialize the ARP module
  
  uip_init();              // Initialize uIP

  HttpDInit();             // Initialize httpd; sets up listening ports

  while (1) {
    uip_len = Enc28j60Receive(uip_buf);

    if (uip_len> 0) {
      if (((struct uip_eth_hdr *) & uip_buf[0])->type == htons(UIP_ETHTYPE_IP)) {
	// uip_arp_ipin();
	uip_input(); // calls uip_process(UIP_DATA)
	// If the above function invocation resulted in data that
	// should be sent out on the network, the global variable
	// uip_len is set to a value > 0.
        if (uip_len> 0) {
          uip_arp_out();
	  // The original uip code has a uip_split_output function. It is not
	  // needed for this application due to small packet sizes, so the
	  // Enc28j60 transmit functions are called directly.
          Enc28j60CopyPacket(uip_buf, uip_len);
          Enc28j60Send();
        }
      }
      else if (((struct uip_eth_hdr *) & uip_buf[0])->type == htons(UIP_ETHTYPE_ARP)) {
        uip_arp_arpin();
	// If the above function invocation resulted in data that
	// should be sent out on the network, the global variable
	// uip_len is set to a value > 0.
        if (uip_len> 0) {
	  // The original uip code has a uip_split_output function. It is not
	  // needed for this application due to small packet sizes, so the
	  // Enc28j60 transmit functions are called directly.
          Enc28j60CopyPacket(uip_buf, uip_len);
          Enc28j60Send();
        }
      }
    }

    if (periodic_timer_expired()) {
      for(i = 0; i < UIP_CONNS; i++) {
	uip_periodic(i);
	// If the above function invocation resulted in data that
	// should be sent out on the network, the global variable
	// uip_len is set to a value > 0.
	if (uip_len > 0) {
	  uip_arp_out();
	  // The original uip code has a uip_split_output function. It is not
	  // needed for this application due to small packet sizes, so the
	  // Enc28j60 transmit functions are called directly.
          Enc28j60CopyPacket(uip_buf, uip_len);
          Enc28j60Send();
	}
      }
    }

    // Call the ARP timer function every 10 seconds.
    if (arp_timer_expired()) {
      uip_arp_timer();
    }
        
    // Check for changes in Relay control states, IP address,
    // IP gateway address, and Netmask
    check_runtime_changes();
    
    // Check for the Reset button
    check_reset_button();
  }
  return 0;
}


// IP Address and MAC Address notes:
// The ENC28J60 device does not use the IP Address. The ENC28J60 communicates with
// the Ethernet using only the MAC address (known in the uIP as "ethernet address").
// The IP Address is used only within the IP packets.
//
// Note that the ENC28J60 must be told what the MAC address is. But the ENC28J60
// only uses the MAC address for receive filtering. The application (not the
// ENC28J60) must insert the MAC address in any transmissions. This occurs in the
// uip.c and uip_arp.c routines.
//
// The application has hardcoded "factory defaults" for the IP Address, Gateway
// Address, Netmask, Port number, and MAC Address. The user is able to change any
// of these and the changes are stored in EEPROM. Thereafter the software uses the 
// addresses from the EEPROM at power on so that user inputs are retained through
// power cycles.
//
// The user can press the Reset Button for 10 seconds to restore "factory defaults".
  

void unlock_eeprom(void)
{
  // Unlock the EEPROM
  // It appears that there is an errata in the STM8S device in that the specified
  // "unlock" keys need to be written in reverse order from the instructions in the
  // documentation. Another user suggests the following code to unlock the EEPROM -
  // it in effect writes the unlock at least twice, resulting in at least one correct
  // combo of KEY1/KEY2 and KEY2/KEY1.
  while (!(FLASH_IAPSR & 0x08)) {  // Check DUL bit, 0=Protected
    FLASH_DUKR = 0xAE; // MASS key 1
    FLASH_DUKR = 0x56; // MASS key 2
  }
}


void check_eeprom_settings(void)
{
  uint8_t i;
  
  // Check magic number in EEPROM. If no magic number it is assumed that the
  // EEPROM has never been written, in which case the default IP Address,
  // Gateway Address, and Netmask will be used. If the magic number IS
  // present then it is assumed that the EEPROM contains valid copies of
  // the IP Address, Gateway Address, and Netmask.
  // The magic number sequence is MSB 0x55 0xee 0x0f 0xf0 LSB
  
  if ((magic4 == 0x55) && 
      (magic3 == 0xee) && 
      (magic2 == 0x0f) && 
      (magic1 == 0xf0) == 1) {
    // Magic number is present. Use the values in the EEPROM for the IP,
    // Gateway, Netmask and MAC.
    // Read and use the IP Address from EEPROM
    uip_ipaddr(IpAddr, stored_hostaddr4, stored_hostaddr3, stored_hostaddr2, stored_hostaddr1);
    uip_sethostaddr(IpAddr);
    // Read and use the Gateway Address from EEPROM
    uip_ipaddr(IpAddr, stored_draddr4, stored_draddr3, stored_draddr2, stored_draddr1);
    uip_setdraddr(IpAddr);
    // Read and use the Netmask from EEPROM
    uip_ipaddr(IpAddr, stored_netmask4, stored_netmask3, stored_netmask2, stored_netmask1);
    uip_setnetmask(IpAddr);
    // Read and use the Port from EEPROM
    Port_Httpd = stored_port;
    // Read and use the MAC from EEPROM
    uip_ethaddr6 = stored_uip_ethaddr6;
    uip_ethaddr5 = stored_uip_ethaddr5;
    uip_ethaddr4 = stored_uip_ethaddr4;
    uip_ethaddr3 = stored_uip_ethaddr3;
    uip_ethaddr2 = stored_uip_ethaddr2;
    uip_ethaddr1 = stored_uip_ethaddr1;
    // Set the values used by the ARP code
    uip_ethaddr.addr[0] = uip_ethaddr1;
    uip_ethaddr.addr[1] = uip_ethaddr2;
    uip_ethaddr.addr[2] = uip_ethaddr3;
    uip_ethaddr.addr[3] = uip_ethaddr4;
    uip_ethaddr.addr[4] = uip_ethaddr5;
    uip_ethaddr.addr[5] = uip_ethaddr6;
    // Set the device name
    for(i=0; i<20; i++) { ex_stored_devicename[i] = stored_devicename[i]; }
    
    // Now check the EEPROM to collect and use the relay states.
    // Read the Relay states from EEPROM
    invert_output = stored_invert_output;
    Relays_16to9 = stored_Relays_16to9;
    Relays_8to1 = stored_Relays_8to1;
    // Update the relay control registers
    update_relay_control_registers();
  }
  
  else {
    // The magic number didn't match. Use the default IP, Gateway, Netmask,
    // Port, and MAC values and store them in the EEPROM. Turn off all relays
    // and store the off state in EEPROM. Write the magic number.
    
    // Initial IP Address
    uip_ipaddr(IpAddr, 192,168,1,4);
    uip_sethostaddr(IpAddr);
    // Write the IP Address to EEPROM
    stored_hostaddr4 = 192;	// MSB
    stored_hostaddr3 = 168;	//
    stored_hostaddr2 = 1;	//
    stored_hostaddr1 = 4;	// LSB
    
    // Initial Gateway Address
    uip_ipaddr(IpAddr, 192,168,1,1);
    uip_setdraddr(IpAddr);
    // Write the Gateway Address to EEPROM
    stored_draddr4 = 192;	// MSB
    stored_draddr3 = 168;	//
    stored_draddr2 = 1;		//
    stored_draddr1 = 1;		// LSB
    
    // Initial Netmask
    uip_ipaddr(IpAddr, 255,255,255,0);
    uip_setnetmask(IpAddr);
    // Write the Netmask to EEPROM
    stored_netmask4 = 255;	// MSB
    stored_netmask3 = 255;	//
    stored_netmask2 = 255;	//
    stored_netmask1 = 0;	// LSB
    
    // Write the default Port number to EEPROM
    stored_port = 8080;		// Port
    // Set the "in use" port number to the default
    Port_Httpd = 8080;

    // Update the MAC values
    // With a bogus Magic Number we have to assume that the Network Module
    // has never been used before. Therefore we need to program a default
    // MAC Address. After this the Magic Number should always be present
    // in which case a user programmed MAC is used.
    // Note there is nothing special about the default MAC used below. It
    // appeared in sample code and doesn't appear to be registered, so I
    // used it here. I assume the user will pick MACs that do not conflict
    // within their networks.
    // Update the MAC values stored in EEPROM
    stored_uip_ethaddr1 = 0xc2;	//MAC MSB
    stored_uip_ethaddr2 = 0x4d;
    stored_uip_ethaddr3 = 0x69;
    stored_uip_ethaddr4 = 0x6b;
    stored_uip_ethaddr5 = 0x65;
    stored_uip_ethaddr6 = 0x00;	//MAC LSB
    // Update the MAC values used by the uIP code
    uip_ethaddr1 = stored_uip_ethaddr1;	//MAC MSB
    uip_ethaddr2 = stored_uip_ethaddr2;
    uip_ethaddr3 = stored_uip_ethaddr3;
    uip_ethaddr4 = stored_uip_ethaddr4;
    uip_ethaddr5 = stored_uip_ethaddr5;
    uip_ethaddr6 = stored_uip_ethaddr6;	//MAC LSB
    // Set the MAC values used by the ARP code
    uip_ethaddr.addr[0] = uip_ethaddr1;
    uip_ethaddr.addr[1] = uip_ethaddr2;
    uip_ethaddr.addr[2] = uip_ethaddr3;
    uip_ethaddr.addr[3] = uip_ethaddr4;
    uip_ethaddr.addr[4] = uip_ethaddr5;
    uip_ethaddr.addr[5] = uip_ethaddr6;

    stored_devicename[0] = 'N' ; // Device name first character
    stored_devicename[1] = 'e' ; //
    stored_devicename[2] = 'w' ; //
    stored_devicename[3] = 'D' ; //
    stored_devicename[4] = 'e' ; //
    stored_devicename[5] = 'v' ; //
    stored_devicename[6] = 'i' ; //
    stored_devicename[7] = 'c' ; //
    stored_devicename[8] = 'e' ; //
    stored_devicename[9] = '0' ; //
    stored_devicename[10] = '0' ; //
    stored_devicename[11] = '0' ; //
    stored_devicename[12] = ' ' ; //
    stored_devicename[13] = ' ' ; //
    stored_devicename[14] = ' ' ; //
    stored_devicename[15] = ' ' ; //
    stored_devicename[16] = ' ' ; //
    stored_devicename[17] = ' ' ; //
    stored_devicename[18] = ' ' ; //
    stored_devicename[19] = ' ' ; // Device name last character

    // Turn all Relays controls to 0 and store the state in EEPROM.
    invert_output = 0;                  // Turn off output invert bit
    stored_invert_output = 0;           // Store in EEPROM
    Relays_16to9 = (uint8_t)0x00;       // Turn off Relays 16 to 9
    Relays_8to1  = (uint8_t)0x00;       // Turn off Relays 8 to 1
    stored_Relays_16to9 = Relays_16to9; // Store in EEPROM
    stored_Relays_8to1 = Relays_8to1;   // Store in EEPROM
    update_relay_control_registers();   // Set Relay Control outputs

    // Write the magic number to the EEPROM MSB 0x55 0xee 0x0f 0xf0 LSB
    magic4 = 0x55;		// MSB
    magic3 = 0xee;		//
    magic2 = 0x0f;		//
    magic1 = 0xf0;		// LSB
  }
  
  // Since this code is run one time at boot, set the Pending values to
  // the current values so they aren't bogus.
  Pending_hostaddr4 = stored_hostaddr4;
  Pending_hostaddr3 = stored_hostaddr3;
  Pending_hostaddr2 = stored_hostaddr2;
  Pending_hostaddr1 = stored_hostaddr1;

  Pending_draddr4 = stored_draddr4;
  Pending_draddr3 = stored_draddr3;
  Pending_draddr2 = stored_draddr2;
  Pending_draddr1 = stored_draddr1;

  Pending_netmask4 = stored_netmask4;
  Pending_netmask3 = stored_netmask3;
  Pending_netmask2 = stored_netmask2;
  Pending_netmask1 = stored_netmask1;
  
  Pending_port = stored_port;

  Pending_uip_ethaddr6 = stored_uip_ethaddr6;
  Pending_uip_ethaddr5 = stored_uip_ethaddr5;
  Pending_uip_ethaddr4 = stored_uip_ethaddr4;
  Pending_uip_ethaddr3 = stored_uip_ethaddr3;
  Pending_uip_ethaddr2 = stored_uip_ethaddr2;
  Pending_uip_ethaddr1 = stored_uip_ethaddr1;

  // Set the ex_stored values for use in the GUI display
  ex_stored_hostaddr4 = stored_hostaddr4;
  ex_stored_hostaddr3 = stored_hostaddr3;
  ex_stored_hostaddr2 = stored_hostaddr2;
  ex_stored_hostaddr1 = stored_hostaddr1;

  ex_stored_draddr4 = stored_draddr4;
  ex_stored_draddr3 = stored_draddr3;
  ex_stored_draddr2 = stored_draddr2;
  ex_stored_draddr1 = stored_draddr1;

  ex_stored_netmask4 = stored_netmask4;
  ex_stored_netmask3 = stored_netmask3;
  ex_stored_netmask2 = stored_netmask2;
  ex_stored_netmask1 = stored_netmask1;

  ex_stored_port = stored_port;
  
  for(i=0; i<20; i++) { ex_stored_devicename[i] = stored_devicename[i]; }
  
}


void check_runtime_changes(void)
{
  // Check if the user requested changes to Relay state, IP Address,
  // Gateway Address, Netmask, or MAC. If a change occurred update the
  // appropriate variables and relay controls, and store the new values
  // in EEPROM.
  
  uint8_t i;

  if ((invert_output != stored_invert_output)
   || (stored_Relays_16to9 != Relays_16to9)
   || (stored_Relays_8to1 != Relays_8to1)) {
    // Write the Invert state value to the EEPROM
    stored_invert_output = invert_output;
    // Write the relay state values to the EEPROM
    stored_Relays_16to9 = Relays_16to9;
    stored_Relays_8to1 = Relays_8to1;
    // Update the relay control registers
    update_relay_control_registers();
  }
  
  // Check for changes in the IP Address
  if (stored_hostaddr4 != Pending_hostaddr4 ||
      stored_hostaddr3 != Pending_hostaddr3 ||
      stored_hostaddr2 != Pending_hostaddr2 ||
      stored_hostaddr1 != Pending_hostaddr1) {
    // Write the new IP address octets to the EEPROM
    stored_hostaddr4 = Pending_hostaddr4;
    stored_hostaddr3 = Pending_hostaddr3;
    stored_hostaddr2 = Pending_hostaddr2;
    stored_hostaddr1 = Pending_hostaddr1;
    // A system reset will occur to cause this change to take effect
    submit_changes = 1;
  }

  // Check for changes in the Gateway Address
  if (stored_draddr4 != Pending_draddr4 ||
      stored_draddr3 != Pending_draddr3 ||
      stored_draddr2 != Pending_draddr2 ||
      stored_draddr1 != Pending_draddr1) {
    // Write the new Gateway address octets to the EEPROM
    stored_draddr4 = Pending_draddr4;
    stored_draddr3 = Pending_draddr3;
    stored_draddr2 = Pending_draddr2;
    stored_draddr1 = Pending_draddr1;
    // A system reset will occur to cause this change to take effect
    submit_changes = 1;
  }

  // Check for changes in the Netmask
  if (stored_netmask4 != Pending_netmask4 ||
      stored_netmask3 != Pending_netmask3 ||
      stored_netmask2 != Pending_netmask2 ||
      stored_netmask1 != Pending_netmask1) {
    // Write the new Netmask octets to the EEPROM
    stored_netmask4 = Pending_netmask4;
    stored_netmask3 = Pending_netmask3;
    stored_netmask2 = Pending_netmask2;
    stored_netmask1 = Pending_netmask1;
    // A system reset will occur to cause this change to take effect
    submit_changes = 1;
  }
    
  // Check for changes in the Port number
  if (stored_port != Pending_port) {
    // Write the new Port number to the EEPROM
    stored_port = Pending_port;
    // A system reset will occur to cause this change to take effect
    submit_changes = 1;
  }
  
  // Check for changes in the Device Name
  devicename_changed = 0;
  for(i=0; i<20; i++) {
    if (stored_devicename[i] != ex_stored_devicename[i]) devicename_changed = 1;
  }
  if (devicename_changed == 1) {
    // Write the new Device Name to the EEPROM
    for(i=0; i<20; i++) { stored_devicename[i] = ex_stored_devicename[i]; }
  }
    
  // Check for changes in the MAC
  if (stored_uip_ethaddr6 != Pending_uip_ethaddr6 ||
      stored_uip_ethaddr5 != Pending_uip_ethaddr5 ||
      stored_uip_ethaddr4 != Pending_uip_ethaddr4 ||
      stored_uip_ethaddr3 != Pending_uip_ethaddr3 ||
      stored_uip_ethaddr2 != Pending_uip_ethaddr2 ||
      stored_uip_ethaddr1 != Pending_uip_ethaddr1) {
    // Write the new MAC to the EEPROM
    stored_uip_ethaddr6 = Pending_uip_ethaddr6;
    stored_uip_ethaddr5 = Pending_uip_ethaddr5;
    stored_uip_ethaddr4 = Pending_uip_ethaddr4;
    stored_uip_ethaddr3 = Pending_uip_ethaddr3;
    stored_uip_ethaddr2 = Pending_uip_ethaddr2;
    stored_uip_ethaddr1 = Pending_uip_ethaddr1;
    // A system reset will occur to cause this change to take effect
    submit_changes = 1;
  }

  if (submit_changes == 1) {
    // submit_changes = 1 indicates we need run through the processes to apply
    // IP Address, Gateway Address, Netmask, Port number, and/or MAC. This is
    // similar to a hardware reset except the GPIO pins which control the
    // relays are not reset thus preventing relay "chatter" that a hardware
    // reset would cause.
  
    check_eeprom_settings(); // Verify EEPROM up to date
    Enc28j60Init();          // Initialize the ENC28J60 ethernet interface
    uip_arp_init();          // Initialize the ARP module
    uip_init();              // Initialize uIP
    HttpDInit();             // Initialize httpd; sets up listening ports
    submit_changes = 0;
  }

  if (submit_changes == 2) {
    // submit_changes = 2 indicates we need to do a hardware reset
    // Turn off the LED, do NOT clear the magic number, and reset the device
    LEDcontrol(0);  // turn LED off
    
    WWDG_WR = (uint8_t)0x7f;     // Window register reset
    WWDG_CR = (uint8_t)0xff;     // Set watchdog to timeout in 49ms
    WWDG_WR = (uint8_t)0x60;     // Window register value - doesn't matter
                                 // much as we plan to reset
				 
    wait_timer((uint16_t)50000); // Wait for watchdog to generate reset
    wait_timer((uint16_t)50000);
    wait_timer((uint16_t)50000);
  }
}


void update_relay_control_registers(void)
{
  // Update the relay control registers to match the state control value.
  // for relays 16 to 9.
  // Note that the invert_output setting flips the state.
  // If invert_output = 0, then a 0 in the Relays_xxx variable sets the relay control to 0
  // If invert_output = 1, then a 0 in the Relays_xxx variable sets the relay control to 1
  if (invert_output == 0) {
    if (Relays_16to9 & 0x80) PC_ODR |= (uint8_t)0x40; // Relay 16 on, PC bit 6 = 1
    else PC_ODR &= (uint8_t)(~0x40);
    if (Relays_16to9 & 0x40) PG_ODR |= (uint8_t)0x01; // Relay 15 on, PG bit 0 = 1
    else PG_ODR &= (uint8_t)(~0x01);
    if (Relays_16to9 & 0x20) PE_ODR |= (uint8_t)0x08; // Relay 14 on, PE bit 3 = 1
    else PE_ODR &= (uint8_t)(~0x08);
    if (Relays_16to9 & 0x10) PD_ODR |= (uint8_t)0x01; // Relay 13 on, PD bit 0 = 1
    else PD_ODR &= (uint8_t)(~0x01);
    if (Relays_16to9 & 0x08) PD_ODR |= (uint8_t)0x08; // Relay 12 on, PD bit 3 = 1
    else PD_ODR &= (uint8_t)(~0x08);
    if (Relays_16to9 & 0x04) PD_ODR |= (uint8_t)0x20; // Relay 11 on, PD bit 5 = 1
    else PD_ODR &= (uint8_t)(~0x20);
    if (Relays_16to9 & 0x02) PD_ODR |= (uint8_t)0x80; // Relay 10 on, PD bit 7 = 1
    else PD_ODR &= (uint8_t)(~0x80);
    if (Relays_16to9 & 0x01) PA_ODR |= (uint8_t)0x10; // Relay  9 on, PA bit 4 = 1
    else PA_ODR &= (uint8_t)(~0x10);

    // Update the relay control registers to match the state control value
    // for relays 8 to 1
    if (Relays_8to1 & 0x80) PC_ODR |= (uint8_t)0x80; // Relay  8 on, PC bit 7 = 1
    else PC_ODR &= (uint8_t)(~0x80);
    if (Relays_8to1 & 0x40) PG_ODR |= (uint8_t)0x02; // Relay  7 on, PG bit 1 = 1
    else PG_ODR &= (uint8_t)(~0x02);
    if (Relays_8to1 & 0x20) PE_ODR |= (uint8_t)0x01; // Relay  6 on, PE bit 0 = 1
    else PE_ODR &= (uint8_t)(~0x01);
    if (Relays_8to1 & 0x10) PD_ODR |= (uint8_t)0x04; // Relay  5 on, PD bit 2 = 1
    else PD_ODR &= (uint8_t)(~0x04);
    if (Relays_8to1 & 0x08) PD_ODR |= (uint8_t)0x10; // Relay  4 on, PD bit 4 = 1
    else PD_ODR &= (uint8_t)(~0x10);
    if (Relays_8to1 & 0x04) PD_ODR |= (uint8_t)0x40; // Relay  3 on, PD bit 6 = 1
    else PD_ODR &= (uint8_t)(~0x40);
    if (Relays_8to1 & 0x02) PA_ODR |= (uint8_t)0x20; // Relay  2 on, PA bit 5 = 1
    else PA_ODR &= (uint8_t)(~0x20);
    if (Relays_8to1 & 0x01) PA_ODR |= (uint8_t)0x08; // Relay  1 on, PA bit 3 = 1
    else PA_ODR &= (uint8_t)(~0x08);
  }
  
  else if (invert_output == 1) {
    if (Relays_16to9 & 0x80) PC_ODR &= (uint8_t)(~0x40); // Relay 16 off, PC bit 6 = 0
    else PC_ODR |= (uint8_t)0x40;
    if (Relays_16to9 & 0x40) PG_ODR &= (uint8_t)(~0x01); // Relay 15 off, PG bit 0 = 0
    else PG_ODR |= (uint8_t)0x01;
    if (Relays_16to9 & 0x20) PE_ODR &= (uint8_t)(~0x08); // Relay 14 off, PE bit 3 = 0
    else PE_ODR |= (uint8_t)0x08;
    if (Relays_16to9 & 0x10) PD_ODR &= (uint8_t)(~0x01); // Relay 13 off, PD bit 0 = 0
    else PD_ODR |= (uint8_t)0x01;
    if (Relays_16to9 & 0x08) PD_ODR &= (uint8_t)(~0x08); // Relay 12 off, PD bit 3 = 0
    else PD_ODR |= (uint8_t)0x08;
    if (Relays_16to9 & 0x04) PD_ODR &= (uint8_t)(~0x20); // Relay 11 off, PD bit 5 = 0
    else PD_ODR |= (uint8_t)0x20;
    if (Relays_16to9 & 0x02) PD_ODR &= (uint8_t)(~0x80); // Relay 10 off, PD bit 7 = 0
    else PD_ODR |= (uint8_t)0x80;
    if (Relays_16to9 & 0x01) PA_ODR &= (uint8_t)(~0x10); // Relay  9 off, PA bit 4 = 0
    else PA_ODR |= (uint8_t)0x10;

    // Update the relay control registers to match the state control value
    // for relays 8 to 1
    if (Relays_8to1 & 0x80) PC_ODR &= (uint8_t)(~0x80); // Relay  8 off, PC bit 7 = 0
    else PC_ODR |= (uint8_t)0x80;
    if (Relays_8to1 & 0x40) PG_ODR &= (uint8_t)(~0x02); // Relay  7 off, PG bit 1 = 0
    else PG_ODR |= (uint8_t)0x02;
    if (Relays_8to1 & 0x20) PE_ODR &= (uint8_t)(~0x01); // Relay  6 off, PE bit 0 = 0
    else PE_ODR |= (uint8_t)0x01;
    if (Relays_8to1 & 0x10) PD_ODR &= (uint8_t)(~0x04); // Relay  5 off, PD bit 2 = 0
    else PD_ODR |= (uint8_t)0x04;
    if (Relays_8to1 & 0x08) PD_ODR &= (uint8_t)(~0x10); // Relay  4 off, PD bit 4 = 0
    else PD_ODR |= (uint8_t)0x10;
    if (Relays_8to1 & 0x04) PD_ODR &= (uint8_t)(~0x40); // Relay  3 off, PD bit 6 = 0
    else PD_ODR |= (uint8_t)0x40;
    if (Relays_8to1 & 0x02) PA_ODR &= (uint8_t)(~0x20); // Relay  2 off, PA bit 5 = 0
    else PA_ODR |= (uint8_t)0x20;
    if (Relays_8to1 & 0x01) PA_ODR &= (uint8_t)(~0x08); // Relay  1 off, PA bit 3 = 0
    else PA_ODR |= (uint8_t)0x08;
  }
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
      if ((PA_IDR & 0x02) == 1) {  // check Reset Button again. If released
                                  // exit.
        return;
      }
    }
    // If we got here the button remained pressed for 5 seconds
    // Turn off the LED, clear the magic number, and reset the device
    LEDcontrol(0);  // turn LED off
    while((PA_IDR & 0x02) == 0) {  // Wait for button release
    }
    // Zero out the EEPROM
    magic4 = 0x00;		   // MSB Magic Number stored in EEPROM
    magic3 = 0x00;		   //
    magic2 = 0x00;		   //
    magic1 = 0x00;		   // LSB Magic Number
    stored_hostaddr4 = 0x00;	   // MSB hostaddr stored in EEPROM
    stored_hostaddr3 = 0x00;	   //
    stored_hostaddr2 = 0x00;	   //
    stored_hostaddr1 = 0x00;	   // LSB hostaddr
    stored_draddr4 = 0x00;	   // MSB draddr stored in EEPROM
    stored_draddr3 = 0x00;	   //
    stored_draddr2 = 0x00;	   //
    stored_draddr1 = 0x00;	   // LSB draddr
    stored_netmask4 = 0x00;	   // MSB netmask stored in EEPROM
    stored_netmask3 = 0x00;	   //
    stored_netmask2 = 0x00;	   //
    stored_netmask1 = 0x00;	   // LSB netmask
    stored_port = 0x0000;	   // Port stored in EEPROM
    stored_uip_ethaddr1 = 0x00;	   // MAC MSB
    stored_uip_ethaddr2 = 0x00;	   //
    stored_uip_ethaddr3 = 0x00;	   //
    stored_uip_ethaddr4 = 0x00;	   //
    stored_uip_ethaddr5 = 0x00;	   //
    stored_uip_ethaddr6 = 0x00;	   // MAC LSB stored in EEPROM
    stored_Relays_16to9 = 0x00;    // Relay states for relays 16 to 9
    stored_Relays_8to1 = 0x00;     // Relay states for relays 8 to 1
    stored_invert_output = 0x00;   // Relay state inversion control
    stored_devicename[0] = 0x00;   // Device name
    stored_devicename[1] = 0x00;   // Device name
    stored_devicename[2] = 0x00;   // Device name
    stored_devicename[3] = 0x00;   // Device name
    stored_devicename[4] = 0x00;   // Device name
    stored_devicename[5] = 0x00;   // Device name
    stored_devicename[6] = 0x00;   // Device name
    stored_devicename[7] = 0x00;   // Device name
    stored_devicename[8] = 0x00;   // Device name
    stored_devicename[9] = 0x00;   // Device name
    stored_devicename[10] = 0x00;  // Device name
    stored_devicename[11] = 0x00;  // Device name
    stored_devicename[12] = 0x00;  // Device name
    stored_devicename[13] = 0x00;  // Device name
    stored_devicename[14] = 0x00;  // Device name
    stored_devicename[15] = 0x00;  // Device name
    stored_devicename[16] = 0x00;  // Device name
    stored_devicename[17] = 0x00;  // Device name
    stored_devicename[18] = 0x00;  // Device name
    stored_devicename[19] = 0x00;  // Device name
    
    WWDG_WR = (uint8_t)0x7f;     // Window register reset
    WWDG_CR = (uint8_t)0xff;     // Set watchdog to timeout in 49ms
    WWDG_WR = (uint8_t)0x60;     // Window register value - doesn't matter
                                 // much as we plan to reset
				 
    wait_timer((uint16_t)50000); // Wait for watchdog to generate reset
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

