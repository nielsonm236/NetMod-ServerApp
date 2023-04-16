/*
 * This file implements all necessary Callback functions for
 * the uip Stack to route data properly to the right application.
 * 
 * Author: Simon Kueppers
 * Email: simon.kueppers@web.de
 * Homepage: http://klinkerstein.m-faq.de
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
 
 Copyright 2008 Simon Kueppers
 *
 */
 
/* Modifications 2020-2022 Michael Nielson
 * Adapted for STM8S005 processor, ENC28J60 Ethernet Controller,
 * Web_Relay_Con V2.0 HW-584, and compilation with Cosmic tool set.
 * Author: Michael Nielson
 * Email: nielsonm.projects@gmail.com
 *
 * This declaration applies to modifications made by Michael Nielson
 * and in no way changes the Simon Kueppers declaration above.
 
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


extern uint16_t Port_Httpd;
extern uint16_t Port_Mqttd;
extern uint16_t mqtt_local_port;

#if BUILD_SUPPORT == MQTT_BUILD
extern struct mqtt_client mqttclient; // Pointer to MQTT client declared in main.c
extern uint8_t mqtt_start;
extern uint8_t mqtt_close_tcp;
#endif // BUILD_SUPPORT == MQTT_BUILD

void uip_TcpAppHubCall(void)
// We get here via UIP_APPCALL in the uip.c code
{
  if(uip_conn->lport == htons(Port_Httpd)) {
    // This code is called if incoming traffic is HTTP. HttpDCall will read
    // the incoming data from the uip_buf, then create any needed output
    // data and put it in the uip_buf.
    // This code is also called if the UIP functions are just checking to
    // see if there is anything pending to send - for instance in the case
    // where multiple packets must be sent to fulfill a browser request.

// UARTPrintf("uip_tcpapphub Browser call\r\n");

    HttpDCall(uip_appdata, uip_datalen(), &uip_conn->appstate.HttpDSocket);
  }

#if BUILD_SUPPORT == MQTT_BUILD
  else if(uip_conn->lport == htons(mqtt_local_port)) {
    // This code is called if incoming traffic is MQTT. mqtt_sync will read
    // the incoming data (if any) from the uip_buf, then create any needed
    // ouptut data and put it in the uip_buf.
    // This code is also called if the UIP functions are just checking to
    // see if there is anything pending to send. This can happen frequently
    // with MQTT.

// UARTPrintf("uip_tcpapphub MQTT call\r\n");

    if (mqtt_start > MQTT_START_QUEUE_CONNECT) {
      // Only call mqtt_sync if we know the client has been initialized
      mqtt_sync(&mqttclient);
      // If mqtt_close_tcp == 1 we are forcing a TCP connection close on return
      // to the UIP code. Note that the uip_TcpAppHubCall() function can only
      // be called if in the ESTABLISHED state - so a uip_close() is a valid
      // reply.
    }
    if (mqtt_close_tcp == 1) {
      mqtt_close_tcp = 0;
      uip_close();
    }
  }
#endif // BUILD_SUPPORT == MQTT_BUILD
}
