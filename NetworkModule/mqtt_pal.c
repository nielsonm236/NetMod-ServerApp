//#if MQTT_SUPPORT == 1

/*
MIT License

Copyright(c) 2018 Liam Bindle

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files(the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions :

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
*/

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


#include <mqtt.h>
#include <uip.h>
#include <uip_arp.h>
#include "main.h"

extern uint16_t uip_slen;


// Implements mqtt_pal_sendall and mqtt_pal_recvall and any platform-specific 
// helpers you'd like.

// The original LiamBindle code included socket based ethernet interfaces to
// a Linux-or-Apple like OS, OR to a Microsoft like OS. In this application
// we are bare metal (no OS) and the ethernet interface is a ENC28J60 device
// which communicates via a SPI interface.
//
// The ENC28J60 can receive and buffer data from the Ethernet. And the
// ENC28J60 can buffer transmit data that will go to the Ethernet. But without
// an OS this bare metal application is single threaded and can only be doing
// one thing at a time ... receiving or transmitting or other application
// tasks.
//
// The web server application I'm starting with has the notion of being the
// entity that responds to incoming traffic. For instance, a browser sends a
// request to the web server, and the web server replies to the request. This
// is a one-for-one exchange. While it is possible for the browser to send
// another request before the first response is sent from the web server this
// is unlikely to happen, but if it does the ENC28J60 will buffer the new
// requests until they can be processed.
//
// In a MQTT application traffic is more asynchronous. Rather than a browser
// sourcing incoming traffic there is a "broker". And the application can
// send traffic to a broker asynchronously based on some stimulus in the
// application (the stimulus perhaps being a sense input change). Likewise the
// broker can send traffic to the application asynchronously (perhaps a relay
// state change command). The broker might send a whole series of asynchronous
// relay state change commands while the application is trying to send a whole
// series of sense input changes.
//
// The web server application uses a single receive/transmit buffer since it
// does not expect to receive numerous incoming browser requests while trying
// to send numerous outgoing responses. Although I suppose it can handle that,
// I haven't tested it that way because the application is a simple relay
// controller / sense input reporter. And I believe the ENC28J60 will buffer
// incoming traffic until the application can come around to receiving it, as
// long as the application doesn't take too long to get to it (causing an
// ENC28J60 buffer over-run).
//
// I suppose the same Ethernet processing concepts can be applied to the MQTT
// application. We'll let the ENC28J60 buffer the asynchronous incoming
// commands until we can get around to individually reading and processing
// them. And we'll send trasnmit data via the ENC28J60 whenever we have any.
// There are a few additional decisions to make:
//
// - Processing received MQTT commands should probably have precedence over
//   transmitting sense data. So our "main loop" should check for incoming
//   data first and do what needs to be done. This is similar to the existing
//   main loop that processes browser data.
//
// - The existing "main loop" only expects to send a browser response if a
//   browser command was received. This will have to be altered so that any
//   asynchronous MQTT transmit request can be sent to the broker.
//
// - The existing web server uses a single buffer for all incoming and
//   outgoing HTTP traffic. The MQTT code wants to use separate incoming and
//   outgoing buffers. Part of the reason for this is that the MQTT code uses
//   its transmit buffer to store BOTH the transmit queue information as well
//   as the transmit data itself. It is in the form of |QUEUE_INFO1|DATA1|
//   QUEUE_INFO2|DATA2|etc. It looks like we can share the receive buffer with
//   browser traffic, but the transmit buffers must be separate ... until a
//   MQTT transmit has to happen. Then buffered MQTT transmit data needs to
//   be copied to the uip_buf and the UIP code needs to be signaled to do the
//   actual transmission.
//
// - How will the main loop determine the difference between browser HTML
//   traffic and MQTT traffic? It can be differentiated based on the Port
//   Number (one for HTTP and one for MQTT).
//
// - There might also be the need to only allow
//   browser traffic for initial setup of the application, THEN only allow
//   MQTT traffic after that, perhaps until the device is reset and returns
//   to a "setup" mode. This would be similar to the way Smart Home devices
//   work. But it might be better to allow browser based setup traffic at
//   any time, if for no other reason than to check on operation of the
//   application should MQTT seem to have stopped working. I will take the
//   "always allow the browser to work" approach first and see how that works
//   out.


int16_t mqtt_pal_sendall(const void* buf, uint16_t len) {
  // This function will copy MQTT data to the uip_buf for transmission to the
  // MQTT Server.
  // The return value is the number of bytes sent.
  // There is only one call to this function. It is in the mqtt.c file.
  //
  // We will use the UIP functions to actually transmit the data. To do this
  // we copy the transmit data from the mqtt_sendbuf to the uip_buf. From the
  // perspective of the MQTT code this copy action means "sent" even though
  // the UIP transmit code still needs to execute (remember we are single
  // threaded). After we return from this function the MQTT code will return to
  // the main.c loop, and that is where the UIP code will transmit the data
  // that we just put in the uip_buf.
  //
  // If the MQTT code queues up more than one message to send the uip_periodic
  // function (called during the main.c loop) will scan all the connections
  // every 100ms and will perform another mqtt_sync to transmit anything that
  // is pending.
  // 
  // A connection is initially established in the main.c loop with the
  // "mqtt_start" steps. Those steps cause the following to occur:
  //  a) If a non-zero MQTT Server IP Address is found an ARP request is sent
  //     to the MQTT Server to determine its MAC address.
  //  b) A TCP connection request is sent to the MQTT Server. This will add
  //     the connection to the connections table for subsequent use.
  //  After a) and b) are done the UIP code is able to build IP and TCP
  //  headers when a transmit is requested for a given connection.
  //
  // A transmit is requested when we leave this function because of how we got
  // here. We arrived in the MQTT code because of a UIP_APPCALL. When we
  // return from that UIP_APPCALL data will be transmitted if uip_slen is
  // greater than zero.
  //
  // So, copy the data into the uip_buf, set the uip_slen value, and return.
  memcpy(uip_appdata, buf, len);
  uip_slen = len;
  return len; // This return value is only for the MQTT buffer mgmt code. The
              // UIP code uses the uip_slen value.
}

int16_t mqtt_pal_recvall(void* buf, uint16_t bufsz) {
  // This function will check if there is any data in the receive buffer and
  // report the size of that data to the MQTT calling process.
  // The return value is the number of bytes received
  // There is only one call to this process. It is in the mqtt.c file.
  //
  // Receive data should already be in the uip_buf or we wouldn't have been
  // called. But probably a good idea to verify that something is there. We
  // only need to reply with the size of the data received. Start of the
  // application data is at the uip_appdata pointer, and the MQTT client
  // already knows this because it was given the "uip_appdata" pointer in the
  // init process.  The size of the application data is the value uip_len.
  
  int16_t rv;
  rv = -1; // Default to return an error if no data present
  if (uip_len > 0) {  // Indicates data is present
    rv = uip_len; // Return the size of the data. Data begins at pointer
                  // uip_appdata.
  }
  return rv;
}

//#endif // MQTT_SUPPORT == 1
