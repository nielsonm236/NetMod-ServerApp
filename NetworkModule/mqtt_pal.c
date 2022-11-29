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
#include "uart.h"

extern uint16_t uip_slen;                 // Send Length for packets
extern const char code_revision[];        // Code Revision
extern uint8_t stored_devicename[20];     // Device name stored in EEPROM
extern char mac_string[13];               // MAC formatted as string
extern uint8_t OctetArray[11];            // Used in emb_itoa conversions

char *stpcpy(char * dest, char * src)
{
  // stpcpy - copy a string from src to dest returning a pointer to the new
  //          end of dest, including src's %NUL-terminator. May overrun dest.
  // * @dest: pointer to end of string being copied into. Must be large
  //          enough to receive copy.
  // * @src:  pointer to the beginning of string being copied from. Must not
  //          overlap dest. @src must be NULL terminated.
  //
  // stpcpy differs from strcpy in a key way: the return value is a pointer
  // to the new %NUL-terminating character in @dest. (For strcpy, the return
  // value is a pointer to the start of @dest). This function does not
  // perform bounds checking of the inputs.
  while ((*dest++ = *src++) != '\0')
    /* nothing */;
  return --dest;
}


// Implements mqtt_pal_sendall

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
  uint8_t template_buf[4];
  uint8_t payload_buf[16];
  uint16_t payload_size;
  uint8_t new_remaining[2];
  int auto_found;
  int i;
  
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
  // Two types of MQTT transmissions are handled here. One is the normal MQTT
  // packet. The other is a Home Assistant Auto Discovery packet. The variable
  // "auto_found" determines which path is used (auto_found == 0 if a normal
  // MQTT packet).
  // Because the MQTT packet buffer is very small in this application it cannot
  // hold an entire Auto Discovery packet. So this function checks if the
  // application is trying to send an Auto Discovery packet. If yes, the
  // function will generate the Auto Discovery packet here. If no, it is
  // assummed that the packet was generated external to this function and
  // is already present in the MQTT transmit buffer (a normal MQTT packet).
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
  //
  // This message triggers an Input discovery message. "xx" is the input
  // number.
  //    mqtt_publish(&mqttclient,
  //                 topic_base,
  //                 "%Ixx",
  //                 4,
  //                 MQTT_PUBLISH_QOS_0 | MQTT_PUBLISH_RETAIN);
  //
  // This message triggers a Temperature Sensor discovery message.
  // "xxxxxxxxxxxx" is the sensor number.
  //    mqtt_publish(&mqttclient,
  //                 topic_base,
  //                 "%Txxxxxxxxxxxx",
  //                 14,
  //                 MQTT_PUBLISH_QOS_0 | MQTT_PUBLISH_RETAIN);
  //
  // Seeking the placeholder in the current message in the transmit buffer:
  // 1) First check if this is a Publish message.
  // 2) If yes, find the existing "remaining length" bytes as this will point
  //    to the start of the payload. Note that if this is an Auto Discovery
  //    Publish message it will have only 1 remaining length byte.
  // 3) Once the start of the payload is found copy the first 4 characters of
  //    the payload to the template_buf.
  // 4) If the first character in the payload is '%' then this is an Auto
  //    Discovery payload that needs to be replaced.

  // Copy the first 4 characters of the MQTT buf to template_buf
  // After copy (if this is an Auto Discovery message)
  //   template_buf[0] = Control byte
  //   template_buf[1] = Remaining length. If MSBit is 1 then there are
  //                     additional remaining length bytes and this cannot
  //                     be an Auto Discovery message.
  //   template_buf[2] = MSByte of variable header length (always 0 for an
  //                     Auto Discovery message ... and the MSBit of
  //                     template_buf[1] will be 1 if this byte is not 0.
  //   template_buf[3] = LSByte of variable header length
  mBuffer = buf;
  *((uint32_t*)&template_buf[0]) = *((uint32_t*)mBuffer); // copy 4 bytes
  
  // Check if Publish message with a payload.
  // See https://bytesofgigabytes.com/mqtt/mqtt-protocol-packet-structure/
  // for description of the packet structure examined here.
  if ((template_buf[0] & 0xf0) == 0x30) {
    // This is a Publish message
    // Examine remaining length
    if (((template_buf[1] & 0x80) != 0x80)
      && (template_buf[1] > (template_buf[3] + 2))) {
      // (template_buf[1] & 0x80) != 0x80) indicates a short packet
      // (template_buf[1] > (template_buf[3] + 2)) indicates there is a
      //   payload
      // We will now check if this is an autodiscovery packet by looking
      // at the first characters of the paylosd.
      
      // Move the mBuffer pointer to the start of the payload
      // mBuffer is pointing at the start of the buf, so the start of the
      // payload will be mBuffer + variable header length + 1 byte for the
      // control byte + 1 byte for the remaining length byte + 2 bytes for
      // the variable header length bytes
      mBuffer = mBuffer + template_buf[3] + 4;

      // Copy the first 14 characters of the MQTT payload to payload_buf
      //
      // Note: This may copy more characters from the "payload" than are
      // actually there, but we search them from the start of the payload
      // area so it won't matter if we copied beyond the actual payload.
      //
      // After copy (if this is an Auto Discovery message) the following
      // will be in payload_buf if payload_buf[1] == I or O
      //   payload_buf[0] = %
      //   payload_buf[1] = I or O
      //   payload_buf[2] = MSB IO number
      //   payload_buf[3] = LSB IO number
      //   payload_buf[4] = don't care
      //     to
      //   payload_buf[13] = don't care
      //
      // After copy (if this is an Auto Discovery message) the following will
      // be in payload_buf if payload_buf[1] == T
      //   payload_buf[0] = %
      //   payload_buf[1] = T
      //   payload_buf[2] = MSB temperature sensor number
      //   payload_buf[3] = next byte temparature sensor number
      //   payload_buf[4] = next byte temperature sensor number
      //   payload_buf[5] = next byte temparature sensor number
      //   payload_buf[6] = next byte temperature sensor number
      //   payload_buf[7] = next byte temparature sensor number
      //   payload_buf[8] = next byte temperature sensor number
      //   payload_buf[9] = next byte temparature sensor number
      //   payload_buf[10] = next byte temperature sensor number
      //   payload_buf[11] = next byte temparature sensor number
      //   payload_buf[12] = next byte temperature sensor number
      //   payload_buf[13] = LSB temperature sensor number
      //
      // Copy 14 characters from mBuffer to payload_buf. This is more than
      // needed if an IO pin, but all are needed if a Temperature Sensor. This
      // data will be sorted out below.
      memcpy(&payload_buf[0], mBuffer, 14);
      
      // Place a NULL terminator in payload_buf to creat the Pin Number /
      // Temperature Sensor ID string.
      // If a Temperature Sensor ID, terminate at payload_buf[14]
      if (payload_buf[1] == 'T') payload_buf[14] = '\0';
      // If an Output or Input pin number, terminate at payload_buf[4]
      else payload_buf[4] = '\0';

      if (payload_buf[0] == '%') {
        // Found a marker - replace the existing payload with an auto
	// discovery message.
	auto_found = 1;
        // Set pointer to uip_appdata
        pBuffer = uip_appdata;
        // Copy the Fixed Header Byte 1 to the uip_buf
        *pBuffer++ = template_buf[0];
	
        // Determine the payload size. To save code space this value is
	// manually calculated in the comments below where the prototype
	// of the application message is shown.
        if (payload_buf[1] == 'O') {
          // This is an Output auto discovery message
          payload_size = 264; // Manually calculated payload size without
	                      // devicename
        }
        if (payload_buf[1] == 'I') {
          // This is an Input auto discovery message
          payload_size = 235; // Manually calculated payload size without
	                      // devicename
        }
	
        if (payload_buf[1] == 'T') {
          // This is a Temperature Sensor auto discovery message
          payload_size = 332; // Manually calculated payload size without
	                      // devicename
        }
	
	// Add device name size to payload size
        payload_size += (3 * (uint8_t)strlen(stored_devicename));
    
	// The "remaining length" value in the MQTT message was 1 byte when we
	// started, and will be 2 bytes as a result of the payload replacement.
	// This means we have to move the Variable Header one byte further out
	// as it is copied to the uip_buf. Here the Variable header is copied
	// to the uip_buf, and later we'll come back and write the new
	// "remaining length" to the uip_buf in uip_buf Bytes 2 and 3 (the two
	// bytes following Fixed Header Byte 1.
	//
	// Point pBuffer at the location in the uip_buf where we want the
	// Variable Header to start.
	pBuffer += 2;
	// Point mBuffer at the location in the buf where the Variable Header
	// starts
	mBuffer = buf;
	mBuffer += 2;
	// Copy the Variable Header including the 2 variable header length
	// bytes to the uip_buf.
	for (i=0; i < (template_buf[3] + 2); i++) {
	  *pBuffer++ = *mBuffer++;
	}
	
        // Calculate the new "remaining length" bytes and save them for later
	// storage in the uip_buf.
	// For payload_buf[1] == I or O the new remaining length is:
	//   the payload_size
	//   plus the old remaining length (in template_buf[1])
	//   less four to account for removal of the 4 byte temporary payload
	// For payload_buf[1] == T the new remaining length is:
	//   the payload_size
	//   plus the old remaining length
	//   less fourteen to account for removal of the 14 byte temporary
	//   payload
	// We'll use the payload_size variable to store this value even though
	// it is now the remaining length.
	// Note that the old remaining length will be about 55 bytes due to
	// the size of the Variable Header and gets added to the payload size
	// variable.
        payload_size = payload_size + template_buf[1] - 4;
	if (payload_buf[1] == 'T') payload_size -= 10;
	
	// Note: The value "len" remains unchanged. It is the length of the
	// "app_message" provided to this function, even if we are creating a
	// new payload for trasnmission.

	// Now encode the new remaining length. The scheme here is simplified
	// since we always have more than 127 and less than 512 bytes to send.
	// A more general case would be more complex.
	/*
        if (payload_size < 256) {
          new_remaining[0] = (uint8_t)((payload_size - 128) | 0x80);
          new_remaining[1] = 1;
        }
	else if (payload_size < 384) {
          new_remaining[0] = (uint8_t)((payload_size - 256) | 0x80);
          new_remaining[1] = 2;
        }
	else {
          new_remaining[0] = (uint8_t)((payload_size - 384) | 0x80);
          new_remaining[1] = 3;
	}
	*/
	// Since we know we actually always have more than 256 and less than
	// 512 bytes to send a more abbreviated calculation is done.

// UARTPrintf("payload_size: ");
// emb_itoa(payload_size, OctetArray, 10, 3);
// UARTPrintf(OctetArray);
// UARTPrintf("\r\n");

	if (payload_size < 384) {
          new_remaining[0] = (uint8_t)((payload_size - 256) | 0x80);
          new_remaining[1] = 2;
        }
	else {
          new_remaining[0] = (uint8_t)((payload_size - 384) | 0x80);
          new_remaining[1] = 3;
	}
	
        // Insert the new remaining length value in the uip_buf.
        mBuffer = uip_appdata + 1;
	*((uint16_t*)mBuffer) = *((uint16_t*)&new_remaining[0]); // copy 2 bytes
	
	// Calculate uip_slen (it will be used later). It is the new remaining 
	// length plus 3 (for the control byte and the two remaining length
	// bytes). Remember that payload_size is currently equal to the new
	// remaining length value.
	uip_slen = payload_size + 3;
    
        // Build the Auto Discovery payload and copy it to the uip_buf. The
	// pBuffer pointer is already pointing to the the uip_buf location
	// where the new Payload should start.
        // We build the payload by copying template fields where they are
	// constant, and replacing template fields as needed. While building
	// the payload it is copied to the uip_buf.
        //
        // output payload
        // {                                                // 1
        // "uniq_id":"aabbccddeeff_output_01",              // 35
        // "name":"devicename123456789 output 01",          // 20 (without devicename)
        // "~":"NetworkModule/devicename123456789",         // 21 (without devicename)
        // "avty_t":"~/availability",                       // 26
        // "stat_t":"~/output/01",                          // 23
        // "cmd_t":"~/output/01/set",                       // 26
        // "dev":{                                          // 7
        // "ids":["NetworkModule_aabbccddeeff"],            // 37
        // "mdl":"HW-584",                                  // 15
        // "mf":"NetworkModule",                            // 21
        // "name":"devicename123456789",                    // 10 (without devicename)
        // "sw":"20201220 1322"                             // 20
        // }                                                // 1
        // }                                                // 1
        //                                                  // Total: 264 plus 3 x devicename
        //
        // input payload
        // {                                                // 1
        // "uniq_id":"aabbccddeeff_input_01",               // 34
        // "name":"devicename123456789 input 01",           // 19 (without devicename)
        // "~":"NetworkModule/devicename123456789",         // 21 (without devicename)
        // "avty_t":"~/availability",                       // 26
        // "stat_t":"~/input/01",                           // 22
        // "dev":{                                          // 7
        // "ids":["NetworkModule_aabbccddeeff"],            // 37
        // "mdl":"HW-584",                                  // 15
        // "mf":"NetworkModule",                            // 21
        // "name":"devicename123456789",                    // 10 (without devicename)
        // "sw":"20201220 1322"                             // 20
        // }                                                // 1
        // }                                                // 1
        //                                                  // Total: 235 plus 3 x devicename
        //
	// temperature sensor payload
	// {                                                // 1
	// "uniq_id":"aabbccddeeff_temp_xxxxxxxxxxxx",      // 43
	// 00000000011111111112222222222333333333344444444445
	// 12345678901234567890123456789012345678901234567890
	// "name":"devicename123456789 temp xxxxxxxxxxxx",  // 28 (without devicename)
	// "~":"NetworkModule/devicename123456789",         // 21 (without devicename)
	// "avty_t":"~/availability",                       // 26
	// "stat_t":"~/temp/xxxxxxxxxxxx",                  // 31
        // "unit_of_meas":"\xc2\xb0\x43",                   // 21
	// "dev_cla":"temperature",                         // 24
	// "stat_cla":"measurement",                        // 25
	// "dev":{                                          // 7
	// "ids":["NetworkModule_aabbccddeeff"],            // 37
	// "mdl":"HW-584",                                  // 15
	// "mf":"NetworkModule",                            // 21
	// "name":"devicename123456789",                    // 10 (without devicename)
	// "sw":"20210204 0311"                             // 20
	// }                                                // 1
	// }                                                // 1
        //                                                  // Total: 332 plus 3 x devicename



        // "stpcpy()" is used to efficiently copy data to the uip_buf
	// utilizing the pBuffer pointer.
        pBuffer = stpcpy(pBuffer, "{\"uniq_id\":\"");

        pBuffer = stpcpy(pBuffer, mac_string);
   
	switch(payload_buf[1]) {
	  case 'O': pBuffer = stpcpy(pBuffer, "_output_"); break;
	  case 'I': pBuffer = stpcpy(pBuffer, "_input_"); break;
	  case 'T': pBuffer = stpcpy(pBuffer, "_temp_"); break;
	}
	
        // Copy the IO pin number or Temperature Sensor ID to the pBuffer.
	pBuffer = stpcpy(pBuffer, &payload_buf[2]);
	
        pBuffer = stpcpy(pBuffer, "\",\"name\":\"");

        pBuffer = stpcpy(pBuffer, stored_devicename);
    
	switch(payload_buf[1]) {
	  case 'O': pBuffer = stpcpy(pBuffer, " output "); break;
	  case 'I': pBuffer = stpcpy(pBuffer, " input "); break;
	  case 'T': pBuffer = stpcpy(pBuffer, " temp "); break;
	}

        // Copy the IO pin number or Temperature Sensor ID to the pBuffer.
	pBuffer = stpcpy(pBuffer, &payload_buf[2]);
    
        pBuffer = stpcpy(pBuffer, "\",\"~\":\"NetworkModule/");

        pBuffer = stpcpy(pBuffer, stored_devicename);
        
        pBuffer = stpcpy(pBuffer, "\",\"avty_t\":\"~/availability\",\"stat_t\":\"~/");

	switch(payload_buf[1]) {
	  case 'O': pBuffer = stpcpy(pBuffer, "output/"); break;
	  case 'I': pBuffer = stpcpy(pBuffer, "input/"); break;
	  case 'T': pBuffer = stpcpy(pBuffer, "temp/"); break;
	}
	
        // Copy the IO pin number or Temperature Sensor ID to the pBuffer.
	pBuffer = stpcpy(pBuffer, &payload_buf[2]);
	
        pBuffer = stpcpy(pBuffer, "\",");

        // Special case for output pin
        if (payload_buf[1] == 'O') {
          pBuffer = stpcpy(pBuffer, "\"cmd_t\":\"~/output/");
	  
 	  // Input or Output number in payload_buf[2] and [3]
	  *((uint16_t*)pBuffer) = *((uint16_t*)&payload_buf[2]); // copy 2 bytes
	  pBuffer += 2;
    
          pBuffer = stpcpy(pBuffer, "/set\",");
        }

        // Special case for temperature pin
        if (payload_buf[1] == 'T') {
          pBuffer = stpcpy(pBuffer, "\"unit_of_meas\":\"\xc2\xb0\x43\",");
	  pBuffer = stpcpy(pBuffer, "\"dev_cla\":\"temperature\",");
	  pBuffer = stpcpy(pBuffer, "\"stat_cla\":\"measurement\",");
	}
	
        pBuffer = stpcpy(pBuffer, "\"dev\":{\"ids\":[\"NetworkModule_");
        
        pBuffer = stpcpy(pBuffer, mac_string);

        pBuffer = stpcpy(pBuffer, "\"],\"mdl\":\"HW-584\",\"mf\":\"NetworkModule\",\"name\":\"");
        
        pBuffer = stpcpy(pBuffer, stored_devicename);
        
        pBuffer = stpcpy(pBuffer, "\",\"sw\":\"");
        
        pBuffer = stpcpy(pBuffer, code_revision);
        
        pBuffer = stpcpy(pBuffer, "\"}}");
      }
    }
  }
  
  if (auto_found != 1) {
    // The payload did not require the replacement procedure, so simply copy
    // the payload data into the uip_buf and set the uip_slen value.
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

