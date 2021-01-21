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

extern uint16_t uip_slen;                 // Send Length for packets
extern const char code_revision[];        // Code Revision
extern uint8_t stored_devicename[20];     // Device name stored in EEPROM
extern char mac_string[13];               // MAC formatted as string

#if DEBUG_SUPPORT != 0
// Variables used to store debug information
extern uint8_t debug[NUM_DEBUG_BYTES];
extern uint8_t stored_debug[NUM_DEBUG_BYTES];
#endif // DEBUG_SUPPORT != 0

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
// broker can send traffic to the application asynchronously (perhaps an output
// state change command). The broker might send a whole series of asynchronous
// output state change commands while the application is trying to send a whole
// series of sense input changes.
//
// The web server application uses a single receive/transmit buffer since it
// does not expect to receive numerous incoming browser requests while trying
// to send numerous outgoing responses. Although I suppose it can handle that,
// I haven't tested it that way because the application is a simple output
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
  
  char* pBuffer;
  char* mBuffer;
  char temp_buf[6];
  char temp[35];
  uint16_t payload_size;
  uint8_t devicename_size;
  uint8_t mac_string_size;
  uint8_t auto_found;
  uint8_t i;
  
  payload_size = 0;
  auto_found = 0;
  
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
  // and will perform another mqtt_sync to transmit anything that is pending.
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

  //---------------------------------------------------------------------------//
  // Two types of MQTT transmissions are handled here. One is the normal
  // MQTT packet. The other is a Home Assistant Auto Discovery packet. Because
  // the MQTT packet buffer is very small in this application it cannot hold
  // an entire Auto Discovery packet. So this function checks if the
  // application is trying to send an Auto Discovery packet. If yes, the
  // function will generate the Auto Discovery packet here. If no, it is
  // assummed that the packet was generated external to this function and
  // is already present in the MQTT transmit buffer.
  //
  // For Auto Discovery Publish messages main.c needs to create a publish
  // message like the following. It includes a message placeholder and the
  // length of that placeholder.
  // 
  // This message triggers an Output discovery message. "xx" is the output
  // number.
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
  //
  // Seek the placeholder in the current message in the transmit buffer.
  // 1) First check if this is a Publish message.
  // 2) If yes, find the existing "remaining length" bytes as this will point
  //    to the start of the payload. Note that if this is an Auto Discovery
  //    Publish message it will have only 1 remaining length byte.
  // 3) Once the start of the payload is found copy the first 4 characters of
  //    the payload to the temp_buf.
  // 4) If the first character in the payload is '%' then this is an Auto
  //    Discovery payload that needs to be replaced.
  //
  // Copy the first 2 characters of the MQTT buf to temp_buf
  // After copy (if this is an Auto Discovery message)
  //   temp_buf[0] = Control byte
  //   temp_buf[1] = Remaining length. If MSBit is 1 then there are
  //                 additional remaining length bytes and this cannot be
  //                 an Auto Discovery message.
  mBuffer = buf;
  temp_buf[0] = *mBuffer;
  mBuffer++;
  temp_buf[1] = *mBuffer;
  mBuffer++;

  // Check if Publish message
  if ((temp_buf[0] & 0xf0) == 0x30) {
    // This is a Publish message
    // Extract remaining length
    if ((temp_buf[1] & 0x80) != 0x80) {
      // The packet is short enough that it might be an Auto Discovery
      // message
      // Move the mBuffer pointer to the start of the payload
      mBuffer = mBuffer + temp_buf[1] - 4;
      // Copy the first 4 characters of the MQTT payload to temp_buf
      // After copy (if this is an Auto Discovery message)
      //   temp_buf[2] = %
      //   temp_buf[3] = I or O
      //   temp_buf[4] = MSB input or output number
      //   temp_buf[5] = LSB input or output number
      temp_buf[2] = *mBuffer;
      mBuffer++;
      temp_buf[3] = *mBuffer;
      mBuffer++;
      temp_buf[4] = *mBuffer;
      mBuffer++;
      temp_buf[5] = *mBuffer;
      mBuffer++;        

      if (temp_buf[2] == '%') {
        // Found a marker - replace the existing payload with an auto
	// discovery message.
	auto_found = 1;
        // Set pointer to uip_appdata
        pBuffer = uip_appdata;
        // Copy the Fixed Header Byte 1 to the uip_buf
        *pBuffer = temp_buf[0];
        pBuffer++;
        // Initialize string length values used in later code
        devicename_size = (uint8_t)strlen(stored_devicename);
        mac_string_size = (uint8_t)strlen(mac_string);
       
        // Calculate the payload size
        if (temp_buf[3] == 'O') {
          // This is an Output auto discovery message
          payload_size = 264; // Payload without devicename
        }
        if (temp_buf[3] == 'I') {
          // This is an Input auto discovery message
          payload_size = 235; // Payload without devicename
        }
        payload_size += (3 * devicename_size);
    
	// Remaining length was 1 byte when we started, and will be 2 bytes as a 
	// result of the payload replacement. This means we have to move the
	// Variable Header one byte further out in as it is copied to the uip_buf.
	// Here the Variable header is copied to the uip_buf, and later we'll
	// come back and write the new "remaining length" to the uip_buf.
	//
	// Point pBuffer at the location in the uip_buf where we want the Variable
	// Header to start.
	pBuffer += 2;
	// Point mBuffer at the location in the buf where the Variable Header starts
	mBuffer = buf;
	mBuffer += 2;
	// Copy the Variable Header to the uip_buf (but not the temporary payload).
	for (i=0; i < (temp_buf[1] - 4); i++) {
	  *pBuffer = *mBuffer;
	  pBuffer++;
	  mBuffer++;
	}
	
        // Calculate the new "remaining length" bytes and save them for later
	// storage in the uip_buf.
	// The new remaining length is the payload_size, plus the old remaining
	// length, less four to account for removal of the 4 byte temporary payload.
	// We'll use the payload_size variable to store this value.
	payload_size = payload_size + temp_buf[1] - 4;
	// Calculate uip_slen (it will be used later). It is the new reamining 
	// length plus 3 (for the control byte and the two remaining length bytes).
	// Remember that payload_size variable is currently equal to the new
	// remaining length value.
	uip_slen = payload_size + 3;
	// Calculate len (it will be used later). It is the old remaining length
	// value plus 2 (for the control byte and the remaining length byte).
	// THIS IS NOT NECESSARY. len IS ALWAYS THE len PROVIDED IN THE CALL TO
	// THIS FUNCTION.
//	len = temp_buf[1] + 2;
	// Now encode the new remaining length and store in the first two bytes
	// of temp_buf for now. The scheme here is simplified since we always
	// have more than 127 and less than 512 bytes to send. A more general
	// case would be more complicated.
        if (payload_size < 256) {
          temp_buf[0] = (uint8_t)((payload_size - 128) | 0x80);
          temp_buf[1] = 1;
        }
	else if (payload_size < 384) {
          temp_buf[0] = (uint8_t)((payload_size - 256) | 0x80);
          temp_buf[1] = 2;
        }
	else {
          temp_buf[0] = (uint8_t)((payload_size - 384) | 0x80);
          temp_buf[1] = 3;
	}
	// Calculate uip_slen (it will be used later). It is the new reamining 
	// length plus 3 (for the control byte and the two remaining length bytes).
	// Remember that payload_size is currently equal to the new remaining
	// length value.
	uip_slen = payload_size + 3;
    
        // Build the discovery payload and copy it to the uip_buf. pBuffer is
        // already pointing to the the uip_buf location where the new Payload
        // should start.
        // We build the payload by copying template fields where they are constant,
        // and replacing template fields as needed. While building the payload it is
        // copied to the uip_buf.
        //
        // output payload
        // {                                        // 1
        // "uniq_id":"aabbccddeeff_output_01",      // 35
        // "name":"devicename123456789 output 01",  // 21-39
        // "~":"NetworkModule/devicename123456789", // 22-40
        // "avty_t":"~/availability",               // 26
        // "stat_t":"~/output/01",                  // 23
        // "cmd_t":"~/output/01/set",               // 26
        // "dev":{                                  // 7
        // "ids":["NetworkModule_aabbccddeeff"],    // 37
        // "mdl":"HW-584",                          // 15
        // "mf":"NetworkModule",                    // 21
        // "name":"devicename123456789",            // 11-29
        // "sw":"20201220 1322"                     // 20
        // }                                        // 1
        // }                                        // 1
        //                                          // 267 - 321
        //                                          // or 264 plus 3 x devicename
        //
        // input payload
        // {                                        // 1
        // "uniq_id":"aabbccddeeff_input_01",       // 34
        // "name":"devicename123456789 input 01",   // 20-38
        // "~":"NetworkModule/devicename123456789", // 22-40
        // "avty_t":"~/availability",               // 26
        // "stat_t":"~/input/01",                   // 22
        // "dev":{                                  // 7
        // "ids":["NetworkModule_aabbccddeeff"],    // 37
        // "mdl":"HW-584",                          // 15
        // "mf":"NetworkModule",                    // 21
        // "name":"devicename123456789",            // 11-29
        // "sw":"20201220 1322"                     // 20
        // }                                        // 1
        // }                                        // 1
        //                                          // 238 - 292
        //                                          // or 235 plus 3 x devicename
        //
        // .........1.........2.........3.........4

        // The string "temp" is used to construct pieces of the payload then
        // those pieces are copied to the uip_buf using the pBuffer pointer.
        // "temp" is a maximum of 35 characters.
        strcpy(temp, "{\"uniq_id\":\"");
        for (i=0; i<strlen(temp); i++) { *pBuffer = temp[i]; pBuffer++; }
    
        for (i=0; i<mac_string_size; i++) { *pBuffer = mac_string[i]; pBuffer++; }
   
        if (temp_buf[3] == 'O') strcpy(temp, "_output_");
        if (temp_buf[3] == 'I') strcpy(temp, "_input_");
        for (i=0; i<strlen(temp); i++) { *pBuffer = temp[i]; pBuffer++; }
        
        *pBuffer = temp_buf[4];  // Input or Output number
        pBuffer++;
        *pBuffer = temp_buf[5];
        pBuffer++; 
    
        if (temp_buf[3] == 'O') strcpy(temp, "\",\"name\":\"");
        if (temp_buf[3] == 'I') strcpy(temp, "\",\"name\":\"");
        for (i=0; i<strlen(temp); i++) { *pBuffer = temp[i]; pBuffer++; }
     
        for (i=0; i<devicename_size; i++) { *pBuffer = stored_devicename[i]; pBuffer++; }
    
        if (temp_buf[3] == 'O') strcpy(temp, " output ");
        if (temp_buf[3] == 'I') strcpy(temp, " input ");
        for (i=0; i<strlen(temp); i++) { *pBuffer = temp[i]; pBuffer++; }
        
        *pBuffer = temp_buf[4];  // Input or Output number
        pBuffer++;
        *pBuffer = temp_buf[5];
        pBuffer++; 
    
        if (temp_buf[3] == 'O') strcpy(temp, "\",\"~\":\"NetworkModule/");
        if (temp_buf[3] == 'I') strcpy(temp, "\",\"~\":\"NetworkModule/");
        for (i=0; i<strlen(temp); i++) { *pBuffer = temp[i]; pBuffer++; }
        
        for (i=0; i<devicename_size; i++) { *pBuffer = stored_devicename[i]; pBuffer++; }
        
        strcpy(temp, "\",\"avty_t\":\"~/availability\",");
        for (i=0; i<strlen(temp); i++) { *pBuffer = temp[i]; pBuffer++; }
        
        if (temp_buf[3] == 'O') strcpy(temp, "\"stat_t\":\"~/output/");
        if (temp_buf[3] == 'I') strcpy(temp, "\"stat_t\":\"~/input/");
        for (i=0; i<strlen(temp); i++) { *pBuffer = temp[i]; pBuffer++; }
        
        *pBuffer = temp_buf[4];  // Input or Output number
        pBuffer++;
        *pBuffer = temp_buf[5];
        pBuffer++; 
    
        strcpy(temp, "\",");
        for (i=0; i<strlen(temp); i++) { *pBuffer = temp[i]; pBuffer++; }

        if (temp_buf[3] == 'O') {
          strcpy(temp, "\"cmd_t\":\"~/output/");
          for (i=0; i<strlen(temp); i++) { *pBuffer = temp[i]; pBuffer++; }
        
          *pBuffer = temp_buf[4];  // Input or Output number
          pBuffer++;
          *pBuffer = temp_buf[5];
          pBuffer++;
    
          strcpy(temp, "/set\",");
          for (i=0; i<strlen(temp); i++) { *pBuffer = temp[i]; pBuffer++; }
        }

        strcpy(temp, "\"dev\":{\"ids\":[\"NetworkModule_");
        for (i=0; i<strlen(temp); i++) { *pBuffer = temp[i]; pBuffer++; }
        
        for (i=0; i<mac_string_size; i++) { *pBuffer = mac_string[i]; pBuffer++; }
        
        strcpy(temp, "\"],\"mdl\":\"HW-584\",");
        for (i=0; i<strlen(temp); i++) { *pBuffer = temp[i]; pBuffer++; }
        
        strcpy(temp, "\"mf\":\"NetworkModule\",\"name\":\"");
        for (i=0; i<strlen(temp); i++) { *pBuffer = temp[i]; pBuffer++; }
        
        for (i=0; i<devicename_size; i++) { *pBuffer = stored_devicename[i]; pBuffer++; }
        
        strcpy(temp, "\",\"sw\":\"");
        for (i=0; i<strlen(temp); i++) { *pBuffer = temp[i]; pBuffer++; }
        
        for (i=0; i<strlen(code_revision); i++) { *pBuffer = code_revision[i]; pBuffer++; }
        
        strcpy(temp, "\"}}");
        for (i=0; i<strlen(temp); i++) { *pBuffer = temp[i]; pBuffer++; }

        // Now insert the new remaining length value in the uip_buf. It
	// was stored in temp_buf[0] and temp_buf[1] earlier.
        pBuffer = uip_appdata + 1;
	*pBuffer = temp_buf[0];
	pBuffer++;
	*pBuffer = temp_buf[1];
      }
    }
  }
  
  if (auto_found != 1) {
    // The payload wasn't an Auto Discovery payload, so copy the payload data
    // into the uip_buf and set the uip_slen value.
    memcpy(uip_appdata, buf, len);
    uip_slen = len;
  }

  // Regardless of whether this was an Auto Discovery packet or not the MQTT
  // code needs to be told that the entire packet it provided to this function
  // was "consumed". This function always returns the len value that was
  // provided to it in the function call.
  
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

