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
#include "main.h"
#include "uart.h"
#include "uipopt.h"

#if BUILD_SUPPORT == MQTT_BUILD

extern uint32_t second_counter;
extern uint16_t uip_slen;
extern uint8_t MQTT_error_status; // Global so GUI can show error status
                                  // indicator
uint8_t connack_received;         // Used to communicate CONNECT CONNACK
                                  // received from mqtt.c to main.c
uint8_t suback_received;          // Used to communicate SUBSCRIBE SUBACK
                                  // received from mqtt.c to main.c

uint8_t mqtt_sendbuf[MQTT_SENDBUF_SIZE]; // Buffer to contain MQTT transmit
                                         // queue and data.
extern uint8_t mqtt_start;        // Tracks the MQTT startup steps

extern uint8_t OctetArray[11];    // Used in UART debug sessions

#if NAGLE_SUPPORT == 1
uint8_t current_msg_length;		// Contains the length of the MQTT
					// message currently being extracted
					// from the uip_buf.
uint8_t mqtt_partial_buffer_length;	// Trackes the length of data in the
					// MQTT Partial Buffer so that we know
					// how much of a partially received
					// MQTT message was received.
uint8_t pbi;				// Partial Buffer Index - provides an
					// index for writing and reading the
					// MQTT partial buffer
#endif // NAGLE_SUPPORT == 1





// Implements the functionality of MQTT-C.


int16_t mqtt_sync(struct mqtt_client *client)
{
    // Check for incoming data (note there may not be any) and check
    // if there is something that needs to be transmitted.
    int16_t err;
    
#if NAGLE_SUPPORT == 1
    uint16_t total_msg_length;		// Contains the total length of the
					// MQTT message(s) in the uip_buf
    char *msgBuffer;			// A pointer used to read MQTT
					// messages from the uip_buf
    uint8_t outer_break;		// Used in breaking a double while()
					// loop.
#endif // NAGLE_SUPPORT == 1

#if NAGLE_SUPPORT == 0
    // Call receive
    if ((uip_newdata() || uip_acked()) && uip_len > 0) {
      // We got here because an incoming message was detected by the UIP
      // code for the MQTT Port. The way to be sure that receive processing
      // should occur is if uip_newdata() is true OR uip_acked() is true
      // AND uip_len > 0.
      err = __mqtt_recv(client);
      if (err != MQTT_OK) {
        return err;
      }
    }
#endif // NAGLE_SUPPORT == 0


#if NAGLE_SUPPORT == 1
    // Call receive
    if ((uip_newdata() || uip_acked()) && uip_len > 0) {
      // We got here because an incoming message was detected by the UIP
      // code for the MQTT Port. The way to be sure that receive processing
      // should occur is if uip_newdata() is true OR uip_acked() is true
      // AND uip_len > 0.
      //
      // When a TCP Packet is received with MQTT messages (the datagram) in
      // it the packet will be placed in the uip_buf startng at the location
      // indicated by pointer uip_appdata. The datagram might have one MQTT
      // messages, or it may have multiple MQTT messages, and any given MQTT
      // message might be divided between two sequential packets. And, if a
      // message is divided between sequential packets a new MQTT message
      // might follow the remnant that starts the new packet.
      //
      // The code here will pull MQTT messages one at a time from the TCP
      // packets and will call __mqtt_recv and __mqtt_send to interpret those
      // messages and send a response to the originator (if needed). A concern
      // is that there can be no actual transmission of of responses to
      // messages until the uip_buf is emptied. There is very limited space in
      // the mqtt_sendbuf, so responses need to accumulate there. Fortunately
      // the following analysis shows that there should be very little
      // response traffic filling the mqtt_sendbuf.
      //
      // The only MQTT messages that will be received AFTER boot initialization
      // completes are:
      // PUBLISH:
      //   msg->state is not updated until __mqtt_send() is called.
      // PINGRESP:
      //   No transmit activity occurs. The message queue is updated with
      //   msg->state = MQTT_QUEUED_COMPLETE. This allows the queue slot to be
      //   reused if needed.
      //
      // Next __mqtt_send() is called to clean up message states after
      // __mqtt_recv().
      // DISCONNECT:
      //   A transmit message can be placed in the mqtt_sendbuf by the
      //   mqtt_disconnect() function. When __mqtt_send is run the transmit
      //   queue is updated with msg->state = MQTT_QUEUED_COMPLETE. This
      //   allows the queue slot to be reused is needed (although that won't
      //   happen as Disconnect will be followed by a reboot).
      // PUBLISH:
      //   At QOS 0 no transmit activity occurs. Only publish_callback() is
      //   called, which updates tracking variables which will later result in
      //   generation of PUBLISH messages for transmit from the Network Module.
      //   Those transmits will occur, at earliest, after the processing of the
      //   current TCP packet is complete. The transmit queue is updated with
      //   msg->state = MQTT_QUEUED_COMPLETE. allows the queue slot to be
      //   reused is needed.
      // PINGREQ:
      //   At the end of __mqtt_send() at about a 30 second interval a PINGREQ
      //   message gets placed in the transmit queue and the queue is updated
      //   with msg->state = MQTT_QUEUED_AWAITING_ACK. Any subsequent call to
      //   __mqtt_send() will transmit the message, resulting in a PINGRESP from
      //   the host. A PINGREQ is a 2 byte message so it occupies very little
      //   space in the mqtt_sendbuf.
      
      // Initialize the pointer for the uip_buf data and determine the
      // total length of the data.
      msgBuffer = uip_appdata;
      total_msg_length = uip_len;
      outer_break = 0;



/*
KEEP THIS CODE FOR A SHORT TIME JUST IN CASE. THIS WAS THE FIRST WORKING
CODE FOR THE HA-HEADER-TOGGLE-BATCHED-MQTT-MESSAGES FIX. WORKED FINE.
COMPRESSED INTO A MORE EFFICIENT VERSION BELOW THIS SAVE.
      while (total_msg_length > 0) {
        // If total_msg_length is greater than zero then there is data in
	// the uip_buf that needs to be read.
	// This loop will move MQTT messages to the MQTT Partial Buffer one
	// message at a time. When a complete message is constructed in the
	// MQTT Partial Buffer the __mqtt_recv() function will be called to
	// interpret the message.
	// We start by collecting the Control byte and Remaining Lenght byte
	// that always start an MQTT message. We might be continuing the
	// capture of a message that started in a previous TCP packet so here
	// we sort that out.
        if (mqtt_partial_buffer_length == 0) {
	  // If mqtt_partial_buffer_length is zero we should be starting the
	  // capture of a new MQTT message.
          // Try to capture the Control Byte and Remaining Length. The data
	  // might end while doing this.
	  
          pbi = 0;
          uip_buf[MQTT_PBUF + pbi++] = *msgBuffer; // Control Byte
          mqtt_partial_buffer_length++;
          msgBuffer++;
          total_msg_length--;
          if (total_msg_length == 0) {
	    // Check if we just read the last byte of data in the uip_buf.
	    // If yes we just hit the end of a TCP packet and we need to exit
	    // __mqtt_sync to wait for the next packet.
	    // pbi and mqtt_partial_buffer_length are retained globally so
	    // they can be used to continue the extraction of MQTT messages
	    // on the next call to mqtt_sync().
	    return MQTT_OK;
	  }
	  
          uip_buf[MQTT_PBUF + pbi++] = *msgBuffer; // Remaining Length Byte
          current_msg_length = uip_buf[MQTT_PBUF + 1];
          mqtt_partial_buffer_length++;
          msgBuffer++;
          total_msg_length--;
        }
	
        else if (mqtt_partial_buffer_length == 1) {
          // If mqtt_partial_buffer_length is one then the MQTT Partial Buffer
	  // contains the Control byte of a MQTT message that started at the
	  // very end of a previous TCP packet. We assume new packets have
	  // at least 2 bytes of data in them, so we read the next byte which
	  // will be the Remaining Length.
          uip_buf[MQTT_PBUF + pbi++] = *msgBuffer;
          mqtt_partial_buffer_length++;
          current_msg_length = uip_buf[MQTT_PBUF + 1];
          msgBuffer++;
          total_msg_length--;
        }
	
        else if (mqtt_partial_buffer_length > 1) {
          // If mqtt_partial_buffer_length is greater than one then the MQTT
	  // Partial Buffer contains the Control byte AND the Remaining Length
	  // of a MQTT message that started at the very end of a previous TCP
	  // packet.
	  // Nothing needs to happen here as the current_msg_length was
	  // captured when readng the previous packet.
        }

        if (current_msg_length == 0) {
	  // The above code captured the Control byte and Remaining Length. If
	  // the Remaining Length is zero this must be a PINGRESP. Call
	  // __mqtt_recv() then clear the MQTT Partial Buffer handling
	  // variables in case there are more MQTT messages in the uip_buf 
	  // after this message.
          err = __mqtt_recv(client);
	  mqtt_partial_buffer_length = 0;
	  pbi = 0;
          if (err != MQTT_OK) {
            return err;
	  }
          // Call send
	  // If we run __mqtt_recv() we need to follow that with a call to
	  // __mqtt_send() so that each processed MQTT message finishes its
	  // recv/send process (mostly making sure the message state is
	  // updated correctly).
          // mqtt_send() shouldn't actually transmit anything via the uip_buf
	  // at this point. It should only update the msg->state of messages
	  // as needed.
          err = __mqtt_send(client);
          // Set global MQTT error flag so GUI can show status
          if (err == MQTT_OK) MQTT_error_status = 1;
          else MQTT_error_status = 0;
          if (err != MQTT_OK) {
            return err;
          }

          if (total_msg_length == 0) {
	    // If total_msg_length is zero then the MQTT message just
	    // processed was the end of the TCP packet. We need to break
	    // out of the while() loop so that another TCP packet can be
	    // collected.
	    break;
          }
	  else {
	    // If total_msg_length is greater than zero then there is another
	    // MQTT message in the uip_buf. Start the while() loop over again
	    // to read the data.
	    continue;
	  }
        }

        // Getting this far means we collected the Control byte and the
	// Remaining Length and there is more to the MQTT message in the
	// uip_buf. Continue reading the MQTT message from the uip_buf. We
	// could hit an end of packet at any byte.
        while(1) {
          uip_buf[MQTT_PBUF + pbi++] = *msgBuffer;
          mqtt_partial_buffer_length++;
          msgBuffer++;
          total_msg_length--;
          current_msg_length--;
          if (current_msg_length == 0) {
	    // If current_msg_length is zero we just copied the entire MQTT
	    // message into the MQTT Partial Buffer. Call __mqtt_recv() then
	    // clear the MQTT Partial Buffer handling variables in case there
	    // are more MQTT messages in the uip_buf after this message.
            err = __mqtt_recv(client);
	    mqtt_partial_buffer_length = 0;
	    pbi = 0;
            if (err != MQTT_OK) {
              return err;
	    }
	  
            // Call send
	    // If we run __mqtt_recv() we need to follow that with a call to
	    // __mqtt_send() so that each processed MQTT message finishes its
	    // recv/send process (mostly making sure the message state is
	    // updated correctly).
            // mqtt_send() shouldn't actually transmit anything via the uip_buf
	    // at this point. It should only update the msg->state of messages
	    // as needed.
            err = __mqtt_send(client);
            // Set global MQTT error flag so GUI can show status
            if (err == MQTT_OK) MQTT_error_status = 1;
            else MQTT_error_status = 0;
            if (err != MQTT_OK) {
              return err;
	    }
	  
            if (total_msg_length == 0) {
	      // If total_msg_length is zero then the MQTT message just
	      // extracted (or part thereof) was the end of the TCP packet.
	      // We need to break out of the inner and outer while() loops so
	      // that another TCP packet can be collected.
	      // Note: the current_msg_length, mqtt_partial_buffer_length, and
	      // pbi are all retained in global memory so that the next packet
	      // starts where this one left off.
	      outer_break = 1;
	      break;
            }
	    else {
	      // If total_msg_length is greater than zero then there is
	      // another MQTT message in the uip_buf that needs to be read.
	      // Break out of the inner while() loop to read the next MQTT
	      // message.
	      break;
	    }
          }
          if (total_msg_length == 0) {
	    // If total_msg_length is zero then the MQTT message just
	    // extracted (or part thereof) was the end of the TCP packet.
	    // We need to break out of the inner and outer while() loops so
	    // that another TCP packet can be collected.
	    // Note: the current_msg_length, mqtt_partial_buffer_length, and
	    // pbi are all retained in global memory so that the next packet
	    // starts where this one left off.
	    outer_break = 1;
	    break;
          }
        }
	if (outer_break == 1) break;
      } // end of outer while() loop
*/





      while (total_msg_length > 0) {
        // If total_msg_length is greater than zero then there is data in
	// the uip_buf that needs to be read.
	// This loop will move MQTT messages to the MQTT Partial Buffer one
	// message at a time. When a complete message is constructed in the
	// MQTT Partial Buffer the __mqtt_recv() function will be called to
	// interpret the message.
	
	// Capture a byte from the uip_buf
        uip_buf[MQTT_PBUF + pbi++] = *msgBuffer;
        mqtt_partial_buffer_length++;
        msgBuffer++;
        total_msg_length--;
		  
        if (mqtt_partial_buffer_length == 2) {
	  // If mqtt_partial_buffer_length == 2 a new current_msg_length
	  // (Remaining Lenght) is in the second byte.
	  current_msg_length = uip_buf[MQTT_PBUF + 1];
	}
	
        if (mqtt_partial_buffer_length > 2) {
	  // If mqtt_partial_buffer_length > 2 then the Control Byte and
	  // Remaining Lenght Byte have both been captured and we must 
	  // decrement the current_msg_length with each additional byte read.
	  current_msg_length--;
	}
	
	if (mqtt_partial_buffer_length == 1) {
	  if (total_msg_length == 0) {
	    // Hit end of packet at first byte of new message. Leave _mqtt_sync
	    // to collect another packet.
	    return MQTT_OK;
	  }
	  // If not at the end of the packet continue to loop to collect one
	  // byte (the Remaining Length) before further decisions.
	  continue;
	}
	
        if (current_msg_length == 0) {
	  // Captured a complete message. Call __mqtt_recv() then clear the
	  // MQTT Partial Buffer handling variables in case there are more
	  // MQTT messages in the uip_buf after this message.
          err = __mqtt_recv(client);
	  mqtt_partial_buffer_length = 0;
	  pbi = 0;
          if (err != MQTT_OK) {
            return err;
	  }
          // Call send
	  // If we run __mqtt_recv() we need to follow that with a call to
	  // __mqtt_send() so that each processed MQTT message finishes its
	  // recv/send process (mostly making sure the message state is updated
	  // correctly).
          // mqtt_send() shouldn't actually transmit anything via the uip_buf
	  // at this point. It should only update the msg->state of messages
	  // as needed.
          err = __mqtt_send(client);
          // Set global MQTT error flag so GUI can show status
          if (err == MQTT_OK) MQTT_error_status = 1;
          else MQTT_error_status = 0;
          if (err != MQTT_OK) {
            return err;
          }
	}
	
        // At this point if total_msg_length == 0 then the MQTT message just
	// extracted (or part thereof) was the end of the TCP packet. The
	// while() loop will terminate so that another TCP packet can be
	// collected.
	// Note: the current_msg_length, mqtt_partial_buffer_length, and pbi
	// are all retained in global memory so that the next packet starts
	// where this one left off.
      }






      
    }
#endif // NAGLE_SUPPORT == 1


    // Call send
    // mqtt_send() will check the send_buf to see if there are any queued
    // messages to transmit. Since the mqtt_recv() call above will have
    // cleared out any received messages the uip_buf is available for
    // transmit messages.
    err = __mqtt_send(client);
    
    // Set global MQTT error flag so GUI can show status
    if (err == MQTT_OK) MQTT_error_status = 1;
    else MQTT_error_status = 0;
    
    return err;
}


uint16_t mqtt_check_sendbuf(struct mqtt_client *client)
{
    // This function cleans the mqtt_sendbuf (if needed) then reports the
    // remaining size of the mqtt_sendbuf (the free space remaining in the
    // buffer).
    uint16_t rv;
    if (!(client->mq.curr_sz > (MQTT_SENDBUF_SIZE - 15))) mqtt_mq_clean(&client->mq); 
    rv = client->mq.curr_sz;
    return rv;
}



uint16_t __mqtt_next_pid(struct mqtt_client *client)
{
    // This function generates a psudo random packet id (pid)
    int16_t pid_exists = 0;
    if (client->pid_lfsr == 0) client->pid_lfsr = 163u;
    // LFSR taps taken from:
    //   https://en.wikipedia.org/wiki/Linear-feedback_shift_register
    
    do {
        struct mqtt_queued_message *curr;
        unsigned lsb = client->pid_lfsr & 1;
        (client->pid_lfsr) >>= 1;
        if (lsb) client->pid_lfsr ^= 0xB400u;

        // check that the PID is unique
        pid_exists = 0;
        for(curr = mqtt_mq_get(&(client->mq), 0); curr >= client->mq.queue_tail; --curr) {
            if (curr->packet_id == client->pid_lfsr) {
                pid_exists = 1;
                break;
            }
        }

    } while(pid_exists);
    
    return client->pid_lfsr;
}


int16_t mqtt_init(struct mqtt_client *client,
               uint8_t *sendbuf, uint16_t sendbufsz,
               uint8_t *recvbuf, uint16_t recvbufsz,
               void (*publish_response_callback)(void** state,struct mqtt_response_publish *publish))
{


#if NAGLE_SUPPORT == 1
    // Initialize variables used in extracting MQTT messages from batched /
    // fragmented TCP packets
    current_msg_length = 0;
    mqtt_partial_buffer_length = 0;
    pbi = 0;
#endif // NAGLE_SUPPORT == 1



    if (client == NULL || sendbuf == NULL || recvbuf == NULL) {
      return MQTT_ERROR_NULLPTR;
    }

    mqtt_mq_init(&client->mq, sendbuf, sendbufsz);

    client->recv_buffer.mem_start = recvbuf;
    client->recv_buffer.mem_size = recvbufsz;
    // The .curr variables are not needed since the receive buffer is fed
    // one message at a time.
    // client->recv_buffer.curr = client->recv_buffer.mem_start;
    // client->recv_buffer.curr_sz = client->recv_buffer.mem_size;

    client->error = MQTT_ERROR_CONNECT_NOT_CALLED;
    client->response_timeout = 30;
    client->number_of_timeouts = 0;
    client->publish_response_callback = publish_response_callback;
    client->pid_lfsr = 0;
    client->send_offset = 0;

    return MQTT_OK;
}


// A macro function that:
//      1) Checks that the client isn't already in an error state.
//      2) Attempts to pack to client's message queue.
//          a) handles errors
//          b) if mq buffer is too small (as indicated by tmp == 0),
//             cleans it and tries again
//      3) Upon successful pack, registers the new message.
#define MQTT_CLIENT_TRY_PACK(tmp, msg, client, pack_call, release)  \
    if (client->error < 0) {                                        \
        return client->error;                                       \
    }                                                               \
    tmp = pack_call;                                                \
    if (tmp < 0) {                                                  \
        client->error = tmp;                                        \
        return tmp;                                                 \
    }                                                               \
    else if (tmp == 0) {                                            \
        mqtt_mq_clean(&client->mq);                                 \
        tmp = pack_call;                                            \
        if (tmp < 0) {                                              \
            client->error = tmp;                                    \
            return tmp;                                             \
        } else if(tmp == 0) {                                       \
            client->error = MQTT_ERROR_SEND_BUFFER_IS_FULL;         \
            return MQTT_ERROR_SEND_BUFFER_IS_FULL;                  \
        }                                                           \
    }                                                               \
    msg = mqtt_mq_register(&client->mq, tmp);                       \


int16_t mqtt_connect(struct mqtt_client *client,
                     const char* client_id,
                     const char* will_topic,
                     const void* will_message,
                     uint16_t will_message_size,
                     const char* user_name,
                     const char* password,
                     uint8_t connect_flags,
                     uint16_t keep_alive)
{
    int16_t rv;
    struct mqtt_queued_message *msg;

    // update the client's state
    client->keep_alive = keep_alive;

    if (client->error == MQTT_ERROR_CONNECT_NOT_CALLED) {
        client->error = MQTT_OK;
    }

    // try to pack the message
    MQTT_CLIENT_TRY_PACK(rv, msg, client, 
        mqtt_pack_connection_request(
            client->mq.curr,
	    client->mq.curr_sz,
            client_id,
	    will_topic,
	    will_message, 
            will_message_size,
	    user_name,
	    password, 
            connect_flags,
	    keep_alive
        ), 
        1
    );
    
    // save the control type of the message
    msg->control_type = MQTT_CONTROL_CONNECT;
    
    return MQTT_OK;
}


int16_t mqtt_publish(struct mqtt_client *client,
                     const char* topic_name,
                     const void* application_message,
                     uint16_t application_message_size,
                     uint8_t publish_flags)
{
    struct mqtt_queued_message *msg;
    int16_t rv;
    uint16_t packet_id;
    packet_id = __mqtt_next_pid(client);

    // try to pack the message
    MQTT_CLIENT_TRY_PACK(
        rv, msg, client, 
        mqtt_pack_publish_request(
            client->mq.curr, client->mq.curr_sz,
            topic_name,
            packet_id,
            application_message,
            application_message_size,
            publish_flags
        ), 
        1
    );
    
    // save the control type and packet id of the message
    msg->control_type = MQTT_CONTROL_PUBLISH;
    msg->packet_id = packet_id;

    return MQTT_OK;
}


int16_t mqtt_subscribe(struct mqtt_client *client,
                       const char* topic_name,
		       int max_qos_level)
{
    int16_t rv;
    uint16_t packet_id;
    struct mqtt_queued_message *msg;
    packet_id = __mqtt_next_pid(client);

    // try to pack the message
    MQTT_CLIENT_TRY_PACK(
        rv, msg, client, 
        mqtt_pack_subscribe_request(
            client->mq.curr, client->mq.curr_sz,
            packet_id,
            topic_name,
            max_qos_level
        ), 
        1
    );
    
    // save the control type and packet id of the message
    msg->control_type = MQTT_CONTROL_SUBSCRIBE;
    msg->packet_id = packet_id;
    return MQTT_OK;
}


int16_t mqtt_ping(struct mqtt_client *client)
{
    int16_t rv;
    rv = __mqtt_ping(client);
    return rv;
}


int16_t __mqtt_ping(struct mqtt_client *client) 
{
    int16_t rv;
    struct mqtt_queued_message *msg;

    // try to pack the message
    MQTT_CLIENT_TRY_PACK(
        rv, msg, client, 
        mqtt_pack_ping_request(
            client->mq.curr, client->mq.curr_sz
        ),
        0
    );
    
    // save the control type and packet id of the message
    msg->control_type = MQTT_CONTROL_PINGREQ;
    
    return MQTT_OK;
}


int16_t mqtt_disconnect(struct mqtt_client *client) 
{
    int16_t rv;
    struct mqtt_queued_message *msg;

    // try to pack the message
    MQTT_CLIENT_TRY_PACK(
        rv, msg, client, 
        mqtt_pack_disconnect(
            client->mq.curr, client->mq.curr_sz
        ), 
        1
    );
    
    // save the control type and packet id of the message
    msg->control_type = MQTT_CONTROL_DISCONNECT;

    return MQTT_OK;
}


int16_t __mqtt_send(struct mqtt_client *client)
{
    // Function to manage transfer of messages from the mqtt_sendbuf to the
    // uip_buf so that they will be transmitted on the ethernet.
    // This application must use the uip_buf for all outbound traffic, and the
    // uip_buf is only serviced via calls in the main loop. Thus only one
    // message at a time can be serviced by calls to mqtt_pall_sendall().
    // As a result the loop below will terminate with a break if a message is
    // transferred from the mqtt_sendbuf to the uip_buf. The code will be
    // called again later to pick up the next message in the queue.
    
    int16_t len;
    int16_t i = 0;
    
    if (client->error < 0 && client->error != MQTT_ERROR_SEND_BUFFER_IS_FULL) {
      return client->error;
    }

    // Find the next unsent message in the queue. mqtt_mq_length returns the
    // number of messages in the message queue.
    len = mqtt_mq_length(&client->mq);

    for(; i < len; ++i) {
      // Even though only one message can be sent each time this function
      // is entered a for() loop is required in case a previously sent
      // message is in state MQTT_QUEUED_AWAITING_ACK. This allows other
      // messages in the queue to be sent even if one is still awaiting
      // an ACK. Due to application timing this should never happen. Also
      // note that a message could be resent if it times out in the queue.
      // This should also never happen.
      struct mqtt_queued_message *msg = mqtt_mq_get(&client->mq, i);
      int16_t resend = 0;
      if (msg->state == MQTT_QUEUED_UNSENT) {
        // message has not been sent so lets send it
        resend = 1;
      }
      else if (msg->state == MQTT_QUEUED_AWAITING_ACK) {
        // check for timeout
        if (second_counter > msg->time_sent + client->response_timeout) {
          resend = 1;
          client->number_of_timeouts += 1;
          client->send_offset = 0;
        }
      }

      // goto next message if we don't need to send
      if (!resend) continue;

      // we're sending the message
      {
	// Some notes about this part of the code. The original code was
	// designed to send larger messages, thus mqtt_pal_sendall might
	// return a tmp value that indicates there is more to send. In this
	// application we use a technique in the mqtt_pal_sendall routine
	// that can replace placeholders in the mqtt message that is to be
	// sent, resulting in an mqtt message that is larger than the
	// message template given to it to send. So the mqtt_pal_sendall
	// routine was redesigned to cause it to send the entire message
	// even if it required multiple packets. Thus the return value
	// always equals the size of the original template ... indicating
	// a complete send.
        int16_t tmp = mqtt_pal_sendall(msg->start + client->send_offset, msg->size - client->send_offset);
	// mqtt_pal_sendall returns a negative number if an error, or a positive
	// number with the number of bytes sent
        if (tmp < 0) {
          client->error = tmp;
          return tmp;
        }
	else {
          client->send_offset += tmp;
          if(client->send_offset < msg->size) {
            // partial sent. Await additional calls
	    // A PARTIAL SHOULD NEVER OCCUR AS ALL MQTT MESSAGES ARE SHORT
	    // ENOUGH IN THIS APPLICATION THAT THEY WILL BE SENT IN ONE PASS.
	    // THIS CODE COULD BE SIMPLIFIED.
            break;
          }
	  else {
            // Whole message has been sent - and by "sent" we mean copied
	    // to the uip_buf.
            client->send_offset = 0;
          }
        }
      }

      // update timeout watcher
      client->time_of_last_send = second_counter;
      msg->time_sent = client->time_of_last_send;

      // Determine the state to put the message in.
      // Control Types:
      // MQTT_CONTROL_CONNECT     -> awaiting
      // MQTT_CONTROL_CONNACK     -> n/a
      // MQTT_CONTROL_PUBLISH     -> qos == 0 ? complete : awaiting
      // MQTT_CONTROL_PUBACK      -> complete
      // MQTT_CONTROL_PUBREC      -> awaiting (Only for qos 2)
      // MQTT_CONTROL_PUBREL      -> awaiting (Only for qos 2)
      // MQTT_CONTROL_PUBCOMP     -> complete (Only for qos 2)
      // MQTT_CONTROL_SUBSCRIBE   -> awaiting
      // MQTT_CONTROL_SUBACK      -> n/a
      // MQTT_CONTROL_PINGREQ     -> awaiting
      // MQTT_CONTROL_PINGRESP    -> n/a
      // MQTT_CONTROL_DISCONNECT  -> complete
	
      switch (msg->control_type) {
      case MQTT_CONTROL_DISCONNECT:
        msg->state = MQTT_QUEUED_COMPLETE;
        break;
      case MQTT_CONTROL_PUBLISH:
	// This application only sends messages at QOS 0
	msg->state = MQTT_QUEUED_COMPLETE;
        break;
      case MQTT_CONTROL_CONNECT:
      case MQTT_CONTROL_SUBSCRIBE:
      case MQTT_CONTROL_PINGREQ:
        msg->state = MQTT_QUEUED_AWAITING_ACK;
        break;
      default:
          client->error = MQTT_ERROR_MALFORMED_REQUEST;
          return MQTT_ERROR_MALFORMED_REQUEST;
      }
      // Need to break here - we sent one message (we can only send one
      // message each time this function is called).
      break;
    }

    // check for keep-alive
    {
      // At about 3/4 of the timeout period perform a ping. This calculation
      // uses integer arithmetic so it is only an approximation. It is
      // assumed that timeouts are not a small number (for instance, the
      // timeout should be at least 15 seconds).
      // Note that a ping is required only when the module is idle, as
      // indicated by checking against the time that the last command was
      // sent (time_of_last_send).
      uint32_t keep_alive_timeout = client->time_of_last_send + (uint32_t)((client->keep_alive * 3) / 4);
      if ((second_counter > keep_alive_timeout) && (mqtt_start == MQTT_START_COMPLETE)) {
        int16_t rv = __mqtt_ping(client);
        if (rv != MQTT_OK) {
          client->error = rv;
          return rv;
        }
      }
    }

    return MQTT_OK;
}


int16_t __mqtt_recv(struct mqtt_client *client)
{
    struct mqtt_response response;
    int16_t mqtt_recv_ret = MQTT_OK;
    int16_t rv, consumed;
    struct mqtt_queued_message *msg = NULL;

    // Read the input buffer and check for errors

    // The original MQTT code used a mqtt_pal_recvall() function to move
    // data from an OS host buffer into an MQTT dedicated receive buffer.
    // In this application that process is not needed and we only need to
    // check if there is any receive data in the uip_buf. To do this we
    // only need to check if uip_len is > 0. If it is not we need to
    // generate an error by setting rv = -1.
    if (mqtt_partial_buffer_length > 0) rv = mqtt_partial_buffer_length;
    else rv = -1;

    client->recv_buffer.curr += rv;
    client->recv_buffer.curr_sz -= rv;

    // attempt to parse
//    consumed = mqtt_unpack_response(&response, client->recv_buffer.mem_start, client->recv_buffer.curr - client->recv_buffer.mem_start);
    consumed = mqtt_unpack_response(&response, &uip_buf[MQTT_PBUF], mqtt_partial_buffer_length);

    if (consumed < 0) {
        client->error = consumed;
        return consumed;
    }

    // response was unpacked successfully

    // The switch statement below manages how the client responds to messages
    // from the broker.

    // Control Types (that we expect to receive from the broker):
    // MQTT_CONTROL_CONNACK:
    //     -> release associated CONNECT
    //     -> handle response
    // MQTT_CONTROL_PUBLISH:
    //     -> stage response, none if qos==0, PUBACK if qos==1, PUBREC if qos==2
    //     -> call publish callback
    // MQTT_CONTROL_PUBACK: (not implemented as we always PUBLISH with qos==0 thus
    //                       never receive a PUBACK)
    //     -> release associated PUBLISH
    // MQTT_CONTROL_PUBREC: (Not implemented - Only for qos 2)
    //     -> release PUBLISH
    //     -> stage PUBREL
    // MQTT_CONTROL_PUBREL: (Not implemented - Only for qos 2)
    //     -> release associated PUBREC
    //     -> stage PUBCOMP
    // MQTT_CONTROL_PUBCOMP: (Not implemented - Only for qos 2)
    //     -> release PUBREL
    // MQTT_CONTROL_SUBACK:
    //     -> release SUBSCRIBE
    //     -> handle response
    // MQTT_CONTROL_UNSUBACK: (Not implemented)
    //     -> release UNSUBSCRIBE
    // MQTT_CONTROL_PINGRESP:
    //     -> release PINGREQ
    
    switch (response.fixed_header.control_type) {
    
        case MQTT_CONTROL_CONNACK:
            // release associated CONNECT
            msg = mqtt_mq_find(&client->mq, MQTT_CONTROL_CONNECT, NULL);
            connack_received = 1; // Communicate CONNACK received to main.c
            if (msg == NULL) {
                client->error = MQTT_ERROR_ACK_OF_UNKNOWN;
                mqtt_recv_ret = MQTT_ERROR_ACK_OF_UNKNOWN;
                break;
            }
            msg->state = MQTT_QUEUED_COMPLETE;
            // check that connection was successful
            if (response.decoded.connack.return_code != MQTT_CONNACK_ACCEPTED) {
                if (response.decoded.connack.return_code == MQTT_CONNACK_REFUSED_IDENTIFIER_REJECTED) {
                    client->error = MQTT_ERROR_CONNECT_CLIENT_ID_REFUSED;
                    mqtt_recv_ret = MQTT_ERROR_CONNECT_CLIENT_ID_REFUSED;
                }
	        else {
                    client->error = MQTT_ERROR_CONNECTION_REFUSED;
                    mqtt_recv_ret = MQTT_ERROR_CONNECTION_REFUSED;
                }
                break;
            }
            break;
	    
        case MQTT_CONTROL_PUBLISH:
	    // Stage response, none if qos==0, PUBACK if qos==1, PUBREC
	    // if qos==2
	    // The received PUBLISH being processed here (and via the
	    // publish_callback routine) is in the MQTT Partial Buffer
	    // uip_buf and will stay there until this processing completes.
	    
	    // QOS1 and QOS2 not supported - code eliminated
            // For QOS0 call Publish Callback.
	    // Note that publish_callback doesn't actually put anything in the
	    // mqtt_sendbuf, it only queues a process that will later place
	    // PUBLISH messages in the mqtt_sendbuf.
            client->publish_response_callback(&client->publish_response_callback_state, &response.decoded.publish);
            break;

        case MQTT_CONTROL_SUBACK:
            // release associated SUBSCRIBE
            msg = mqtt_mq_find(&client->mq, MQTT_CONTROL_SUBSCRIBE, &response.decoded.suback.packet_id);
	    suback_received = 1; // Communicate SUBACK received to main.c
            if (msg == NULL) {
                client->error = MQTT_ERROR_ACK_OF_UNKNOWN;
                mqtt_recv_ret = MQTT_ERROR_ACK_OF_UNKNOWN;
                break;
            }
            msg->state = MQTT_QUEUED_COMPLETE;
            // check that subscription was successful (not currently only one
            // subscribe at a time)
            if (response.decoded.suback.return_codes[0] == MQTT_SUBACK_FAILURE) {
                client->error = MQTT_ERROR_SUBSCRIBE_FAILED;
                mqtt_recv_ret = MQTT_ERROR_SUBSCRIBE_FAILED;
                break;
            }
            break;
	    
        case MQTT_CONTROL_PINGRESP:
            // release associated PINGREQ
            msg = mqtt_mq_find(&client->mq, MQTT_CONTROL_PINGREQ, NULL);
            if (msg == NULL) {
                client->error = MQTT_ERROR_ACK_OF_UNKNOWN;
                mqtt_recv_ret = MQTT_ERROR_ACK_OF_UNKNOWN;
                break;
            }
            msg->state = MQTT_QUEUED_COMPLETE;
            break;
	    
        default:
            client->error = MQTT_ERROR_MALFORMED_RESPONSE;
            mqtt_recv_ret = MQTT_ERROR_MALFORMED_RESPONSE;
            break;
    }
    
    {
        // Because we have the UIP code as the front end to MQTT there will
        // never be more than one receive msg in the uip_buf, so the
        // processing above will have "consumed" it. If a new receive message
	// comes in on the ethernet while this code is operating it will be
	// held in the enc28j60 hardware buffer until the application gets
	// back around to receiving it.
        //
        // The original code was set up to let several messages get queued in
        // the receive buffer, then those messages are read out. When a
        // message is read the original code "cleans the buffer" by moving any
        // remaining messages toward the beginning of the buffer, over-writing
        // the messages consumed. Or at least that's what I think it was doing.
        //
	// Reset receive pointers to start of buffer. NO LONGER NEEDED: Due to
	// lack of memory in this application the receive buffer is very small
	// and is fed one message at a time.
//	client->recv_buffer.curr = client->recv_buffer.mem_start;
//	client->recv_buffer.curr_sz = client->recv_buffer.mem_size;
    }

    // In case there was some error handling the (well formed) message, we end
    // up here
    return mqtt_recv_ret;
}



/* FIXED HEADER */
static const uint8_t control_type_is_valid[] = {
        // 0x01 if type is valid
        0x00,   // MQTT_CONTROL_RESERVED
        0x01,   // MQTT_CONTROL_CONNECT
        0x01,   // MQTT_CONTROL_CONNACK
        0x01,   // MQTT_CONTROL_PUBLISH
        0x01,   // MQTT_CONTROL_PUBACK
        0x01,   // MQTT_CONTROL_PUBREC
        0x01,   // MQTT_CONTROL_PUBREL
        0x01,   // MQTT_CONTROL_PUBCOMP
        0x01,   // MQTT_CONTROL_SUBSCRIBE
        0x01,   // MQTT_CONTROL_SUBACK
        0x01,   // MQTT_CONTROL_UNSUBSCRIBE
        0x01,   // MQTT_CONTROL_UNSUBACK
        0x01,   // MQTT_CONTROL_PINGREQ
        0x01,   // MQTT_CONTROL_PINGRESP
        0x01,   // MQTT_CONTROL_DISCONNECT
        0x00};  // MQTT_CONTROL_RESERVED
static const uint8_t required_flags[] = {
        // flags that must be set for the associated control type
        0x00,   // MQTT_CONTROL_RESERVED
        0x00,   // MQTT_CONTROL_CONNECT
        0x00,   // MQTT_CONTROL_CONNACK
        0x00,   // MQTT_CONTROL_PUBLISH
        0x00,   // MQTT_CONTROL_PUBACK
        0x00,   // MQTT_CONTROL_PUBREC
        0x02,   // MQTT_CONTROL_PUBREL
        0x00,   // MQTT_CONTROL_PUBCOMP
        0x02,   // MQTT_CONTROL_SUBSCRIBE
        0x00,   // MQTT_CONTROL_SUBACK
        0x02,   // MQTT_CONTROL_UNSUBSCRIBE
        0x00,   // MQTT_CONTROL_UNSUBACK
        0x00,   // MQTT_CONTROL_PINGREQ
        0x00,   // MQTT_CONTROL_PINGRESP
        0x00,   // MQTT_CONTROL_DISCONNECT
        0x00};  // MQTT_CONTROL_RESERVED
static const uint8_t mask_required_flags[] = {
        // mask of flags that must be specific values for the associated control type
        0x00,   // MQTT_CONTROL_RESERVED
        0x0F,   // MQTT_CONTROL_CONNECT
        0x0F,   // MQTT_CONTROL_CONNACK
        0x00,   // MQTT_CONTROL_PUBLISH
        0x0F,   // MQTT_CONTROL_PUBACK
        0x0F,   // MQTT_CONTROL_PUBREC
        0x0F,   // MQTT_CONTROL_PUBREL
        0x0F,   // MQTT_CONTROL_PUBCOMP
        0x0F,   // MQTT_CONTROL_SUBSCRIBE
        0x0F,   // MQTT_CONTROL_SUBACK
        0x0F,   // MQTT_CONTROL_UNSUBSCRIBE
        0x0F,   // MQTT_CONTROL_UNSUBACK
        0x0F,   // MQTT_CONTROL_PINGREQ
        0x0F,   // MQTT_CONTROL_PINGRESP
        0x0F,   // MQTT_CONTROL_DISCONNECT
        0x00};  // MQTT_CONTROL_RESERVED


static int16_t mqtt_fixed_header_rule_violation(const struct mqtt_fixed_header *fixed_header)
{
    uint8_t control_type;
    uint8_t control_flags;

    // get value and rules
    control_type = fixed_header->control_type;
    control_flags = fixed_header->control_flags;

    // check for valid type
    if (control_type_is_valid[control_type] != 0x01) {
        return MQTT_ERROR_CONTROL_FORBIDDEN_TYPE;
    }
    
    // check that flags are appropriate
    if(((control_flags ^ required_flags[control_type]) & mask_required_flags[control_type]) == 1) {
        return MQTT_ERROR_CONTROL_INVALID_FLAGS;
    }

    return 0;
}


int16_t mqtt_unpack_fixed_header(struct mqtt_response *response, const uint8_t *buf, uint16_t bufsz)
{
    struct mqtt_fixed_header *fixed_header;
    const uint8_t *start = buf;
    int16_t lshift;
    int16_t errcode;
    
    // check for null pointers or empty buffer
    if (response == NULL || buf == NULL) {
      return MQTT_ERROR_NULLPTR;
    }
    fixed_header = &(response->fixed_header);

    // check that bufsz is not zero
    if (bufsz == 0) return 0;

    // parse control type and flags
    fixed_header->control_type  = (uint8_t)(*buf >> 4);
    fixed_header->control_flags = (uint8_t)(*buf & 0x0F);

    // parse remaining size
    fixed_header->remaining_length = 0;

    lshift = 0;
    do {
        // MQTT spec (2.2.3) says the maximum length is 28 bits
        if(lshift == 28) {
            return MQTT_ERROR_INVALID_REMAINING_LENGTH;
	}

        // consume byte and assert at least 1 byte left
        --bufsz;
        ++buf;
        if (bufsz == 0) return 0;

        // parse next byte
        fixed_header->remaining_length += (*buf & 0x7F) << lshift;
        lshift += 7;
    } while(*buf & 0x80); // while continue bit is set 

    // consume last byte
    --bufsz;
    ++buf;

    // check that the fixed header is valid
    errcode = mqtt_fixed_header_rule_violation(fixed_header);
    if (errcode) return errcode;

    // check that the buffer size if GT remaining length
    if (bufsz < fixed_header->remaining_length) return 0;

    // return how many bytes were consumed
    return buf - start;
}


int16_t mqtt_pack_fixed_header(uint8_t *buf, uint16_t bufsz, const struct mqtt_fixed_header *fixed_header)
{
    const uint8_t *start = buf;
    int16_t errcode;
    uint32_t remaining_length;
    
    // check for null pointers or empty buffer
    if (fixed_header == NULL || buf == NULL) {
      return MQTT_ERROR_NULLPTR;
    }

    // check that the fixed header is valid
    errcode = mqtt_fixed_header_rule_violation(fixed_header);
    if (errcode) return errcode;

    // check that bufsz is not zero
    if (bufsz == 0) return 0;

    // pack control type and flags
    *buf =  (uint8_t)((fixed_header->control_type << 4) & 0xF0);
    *buf |= (uint8_t)(fixed_header->control_flags & 0x0F);

    remaining_length = fixed_header->remaining_length;

    do {
        // consume byte and assert at least 1 byte left
        --bufsz;
        ++buf;
        if (bufsz == 0) return 0;
        
        // pack next byte
        *buf  = (uint8_t)(remaining_length & 0x7F);
        if(remaining_length > 127) *buf |= 0x80;
        remaining_length = remaining_length >> 7;
    } while(*buf & 0x80);
    
    // consume last byte
    --bufsz;
    ++buf;

    // check that there's still enough space in buffer for packet
    if (bufsz < fixed_header->remaining_length) return 0;

    // return how many bytes were consumed
    return buf - start;
}


/* CONNECT */
int16_t mqtt_pack_connection_request(uint8_t* buf, uint16_t bufsz,
                                     const char* client_id,
                                     const char* will_topic,
                                     const void* will_message,
                                     uint16_t will_message_size,
                                     const char* user_name,
                                     const char* password,
                                     uint8_t connect_flags,
                                     uint16_t keep_alive)
{ 
    struct mqtt_fixed_header fixed_header;
    uint16_t remaining_length;
    const uint8_t *const start = buf;
    int16_t rv;

    // pack the fixed headr 
    fixed_header.control_type = MQTT_CONTROL_CONNECT;
    fixed_header.control_flags = 0x00;

    // Make sure MQTT_CONNECT_RESERVED is zero
    connect_flags = (uint8_t)(connect_flags & ~MQTT_CONNECT_RESERVED);
    
    // calculate remaining length and build connect_flags at the same time
    remaining_length = 10; // size of variable header

    // client_id is never NULL in this application
    // if (client_id == NULL) client_id = "";

    // For an empty client_id, a clean session is required
    // client_id is never NULL in this application
    // if (client_id[0] == '\0' && !(connect_flags & MQTT_CONNECT_CLEAN_SESSION)) {
    //     return MQTT_ERROR_CLEAN_SESSION_IS_REQUIRED;
    // }
    
    // mqtt_string length is strlen + 2
    remaining_length += __mqtt_packed_cstrlen(client_id);

    // This application always has a will_topic and will_message
    connect_flags |= MQTT_CONNECT_WILL_FLAG;
    connect_flags |= MQTT_CONNECT_WILL_RETAIN;
    remaining_length += __mqtt_packed_cstrlen(will_topic);
    remaining_length += 2 + will_message_size; // size of will_message

    if (user_name != NULL) {
        // a user name is present
        connect_flags |= MQTT_CONNECT_USER_NAME;
        remaining_length += __mqtt_packed_cstrlen(user_name);
    }
    else connect_flags &= (uint8_t)(~MQTT_CONNECT_USER_NAME);

    if (password != NULL) {
        // a password is present
        connect_flags |= MQTT_CONNECT_PASSWORD;
        remaining_length += __mqtt_packed_cstrlen(password);
    }
    else connect_flags &= (uint8_t)(~MQTT_CONNECT_PASSWORD);

    // fixed header length is now calculated
    fixed_header.remaining_length = remaining_length;

    // pack fixed header and perform error checks
    rv = mqtt_pack_fixed_header(buf, bufsz, &fixed_header);
    if (rv <= 0) {
      return rv; // something went wrong
    }

    buf += rv;
    bufsz -= rv;

    // check that the buffer has enough space to fit the remaining length
    if (bufsz < fixed_header.remaining_length) return 0;

    // pack the variable header
    *buf++ = 0x00;
    *buf++ = 0x04;
    *buf++ = (uint8_t) 'M';
    *buf++ = (uint8_t) 'Q';
    *buf++ = (uint8_t) 'T';
    *buf++ = (uint8_t) 'T';
    *buf++ = MQTT_PROTOCOL_LEVEL;
    *buf++ = connect_flags;
    buf += __mqtt_pack_uint16(buf, keep_alive);

    // pack the payload
    buf += __mqtt_pack_str(buf, client_id);
    if (connect_flags & MQTT_CONNECT_WILL_FLAG) {
        buf += __mqtt_pack_str(buf, will_topic);
        buf += __mqtt_pack_uint16(buf, (uint16_t)will_message_size);
        memcpy(buf, will_message, will_message_size);
        buf += will_message_size;
    }
    
    if (connect_flags & MQTT_CONNECT_USER_NAME) buf += __mqtt_pack_str(buf, user_name);

    if (connect_flags & MQTT_CONNECT_PASSWORD) buf += __mqtt_pack_str(buf, password);

    // return the number of bytes that were consumed
    return buf - start;
}


/* CONNACK */
int16_t mqtt_unpack_connack_response(struct mqtt_response *mqtt_response, const uint8_t *buf)
{
    const uint8_t *const start = buf;
    struct mqtt_response_connack *response;

    // check that remaining length is 2
    if (mqtt_response->fixed_header.remaining_length != 2) {
      return MQTT_ERROR_MALFORMED_RESPONSE;
    }
    
    response = &(mqtt_response->decoded.connack);
    // unpack
    if (*buf & 0xFE) {
      return MQTT_ERROR_CONNACK_FORBIDDEN_FLAGS; // only bit 1 can be set
    }
    else response->session_present_flag = *buf++;

    if (*buf > 5u) {
      return MQTT_ERROR_CONNACK_FORBIDDEN_CODE; // only bit 1 can be set
    }
    else response->return_code = (enum MQTTConnackReturnCode) *buf++;

    return buf - start;
}


/* DISCONNECT */
int16_t mqtt_pack_disconnect(uint8_t *buf, uint16_t bufsz)
{
    struct mqtt_fixed_header fixed_header;
    fixed_header.control_type = MQTT_CONTROL_DISCONNECT;
    fixed_header.control_flags = 0;
    fixed_header.remaining_length = 0;
    return mqtt_pack_fixed_header(buf, bufsz, &fixed_header);
}


/* PING */
int16_t mqtt_pack_ping_request(uint8_t *buf, uint16_t bufsz)
{
    struct mqtt_fixed_header fixed_header;
    fixed_header.control_type = MQTT_CONTROL_PINGREQ;
    fixed_header.control_flags = 0;
    fixed_header.remaining_length = 0;
    return mqtt_pack_fixed_header(buf, bufsz, &fixed_header);
}


/* PUBLISH */
int16_t mqtt_pack_publish_request(uint8_t *buf, uint16_t bufsz,
                                  const char* topic_name,
                                  uint16_t packet_id,
                                  const void* application_message,
                                  uint16_t application_message_size,
                                  uint8_t publish_flags)
{
    const uint8_t *const start = buf;
    int16_t rv;
    struct mqtt_fixed_header fixed_header;
    uint32_t remaining_length;
    
    // check for null pointers
    if(buf == NULL || topic_name == NULL) {
      return MQTT_ERROR_NULLPTR;
    }

    // build the fixed header
    fixed_header.control_type = MQTT_CONTROL_PUBLISH;
    
    // calculate remaining length
    remaining_length = (uint32_t)__mqtt_packed_cstrlen(topic_name);

    remaining_length += (uint32_t)application_message_size;
    fixed_header.remaining_length = remaining_length;

    // force dup to 0 if qos is 0 [Spec MQTT-3.3.1-2]
    publish_flags &= (uint8_t)(~MQTT_PUBLISH_DUP);
    
    fixed_header.control_flags = publish_flags;
    
    // pack fixed header
    rv = mqtt_pack_fixed_header(buf, bufsz, &fixed_header);
    if (rv <= 0) return rv; // something went wrong

    buf += rv;
    bufsz -= rv;

    // check that buffer is big enough
    if (bufsz < remaining_length) return 0;

    // pack variable header
    buf += __mqtt_pack_str(buf, topic_name);
    
    // pack payload
    memcpy(buf, application_message, application_message_size);
    buf += application_message_size;

    return buf - start;
}


int16_t mqtt_unpack_publish_response(struct mqtt_response *mqtt_response, const uint8_t *buf)
{    
    const uint8_t *const start = buf;
    struct mqtt_fixed_header *fixed_header;
    struct mqtt_response_publish *response;
    
    fixed_header = &(mqtt_response->fixed_header);
    response = &(mqtt_response->decoded.publish);

    // get flags
    response->dup_flag = (uint8_t)((fixed_header->control_flags & MQTT_PUBLISH_DUP) >> 3);
    response->qos_level = (uint8_t)((fixed_header->control_flags & MQTT_PUBLISH_QOS_MASK) >> 1);
    response->retain_flag = (uint8_t)(fixed_header->control_flags & MQTT_PUBLISH_RETAIN);

    // make sure that remaining length is valid
    if (mqtt_response->fixed_header.remaining_length < 4) {
        return MQTT_ERROR_MALFORMED_RESPONSE;
    }

    // parse variable header
    response->topic_name_size = __mqtt_unpack_uint16(buf);
    buf += 2;
    response->topic_name = buf;
    buf += response->topic_name_size;
    
    // get payload
    response->application_message = buf;
    
    response->application_message_size = (uint16_t)(fixed_header->remaining_length - response->topic_name_size - 2);
    buf += response->application_message_size;
        
    // return number of bytes consumed
    return buf - start;
}


/* SUBACK */
int16_t mqtt_unpack_suback_response (struct mqtt_response *mqtt_response, const uint8_t *buf)
{
    const uint8_t *const start = buf;
    uint32_t remaining_length = mqtt_response->fixed_header.remaining_length;
    
    // assert remaining length is at least 3 (for packet id and at least 1 topic)
    if (remaining_length < 3) {
      return MQTT_ERROR_MALFORMED_RESPONSE;
    }

    // unpack packet_id
    mqtt_response->decoded.suback.packet_id = __mqtt_unpack_uint16(buf);
    buf += 2;
    remaining_length -= 2;

    // unpack return codes
    mqtt_response->decoded.suback.num_return_codes = (uint16_t) remaining_length;
    mqtt_response->decoded.suback.return_codes = buf;
    buf += remaining_length;

    return buf - start;
}


/* SUBSCRIBE */
int16_t mqtt_pack_subscribe_request(uint8_t *buf, uint16_t bufsz, uint16_t packet_id, char *topic, int max_qos_level)
{
    int16_t rv;
    const uint8_t *const start = buf;
    struct mqtt_fixed_header fixed_header;

    // build the fixed header
    fixed_header.control_type = MQTT_CONTROL_SUBSCRIBE;
    fixed_header.control_flags = 2u;
    fixed_header.remaining_length = 2u; // size of variable header
    // payload is topic name + max qos (1 byte)
    fixed_header.remaining_length += __mqtt_packed_cstrlen(topic) + 1;

    // pack the fixed header
    rv = mqtt_pack_fixed_header(buf, bufsz, &fixed_header);
    if (rv <= 0) return rv;
    buf += rv;
    bufsz -= rv;

    // check that the buffer has enough space
    if (bufsz < fixed_header.remaining_length) return 0;
        
    // pack variable header
    buf += __mqtt_pack_uint16(buf, packet_id);

    // pack payload
    buf += __mqtt_pack_str(buf, topic);
    *buf++ = (uint8_t)max_qos_level; //max_qos

    return buf - start;
}


/* MESSAGE QUEUE */
void mqtt_mq_init(struct mqtt_message_queue *mq, void *buf, uint16_t bufsz) 
{  
    if(buf != NULL)
    {
        mq->mem_start = buf;
        mq->mem_end = (unsigned char*)buf + bufsz;
        mq->curr = buf;
        mq->queue_tail = mq->mem_end;
        mq->curr_sz = mqtt_mq_currsz(mq);
    }
}


struct mqtt_queued_message* mqtt_mq_register(struct mqtt_message_queue *mq, uint16_t nbytes)
{
    // make queued message header
    --(mq->queue_tail);
    mq->queue_tail->start = mq->curr;
    mq->queue_tail->size = nbytes;
    mq->queue_tail->state = MQTT_QUEUED_UNSENT;

    // move curr and recalculate curr_sz
    mq->curr += nbytes;
    mq->curr_sz = mqtt_mq_currsz(mq);

    return mq->queue_tail;
}


void mqtt_mq_clean(struct mqtt_message_queue *mq) {
    struct mqtt_queued_message *new_head;

    for(new_head = mqtt_mq_get(mq, 0); new_head >= mq->queue_tail; --new_head) {
        if (new_head->state != MQTT_QUEUED_COMPLETE) break;
    }
    
    // check if everything can be removed
    if (new_head < mq->queue_tail) {
        mq->curr = mq->mem_start;
        mq->queue_tail = mq->mem_end;
        mq->curr_sz = mqtt_mq_currsz(mq);
        return;
    }
    else if (new_head == mqtt_mq_get(mq, 0)) {
        // do nothing
        return;
    }

    // move buffered data
    {
        uint16_t n = mq->curr - new_head->start;
        uint16_t removing = new_head->start - (uint8_t*) mq->mem_start;
        memmove(mq->mem_start, new_head->start, n);
        mq->curr = (unsigned char*)mq->mem_start + n;

        // move queue
        {
            int16_t new_tail_idx = new_head - mq->queue_tail;
            memmove(mqtt_mq_get(mq, new_tail_idx), mq->queue_tail, sizeof(struct mqtt_queued_message) * (new_tail_idx + 1));
            mq->queue_tail = mqtt_mq_get(mq, new_tail_idx);
          
            {
                // bump back start's
                int16_t i = 0;
                for(; i < new_tail_idx + 1; ++i) mqtt_mq_get(mq, i)->start -= removing;
            }
        }
    }

    // get curr_sz
    mq->curr_sz = mqtt_mq_currsz(mq);
}


struct mqtt_queued_message* mqtt_mq_find(struct mqtt_message_queue *mq, enum MQTTControlPacketType control_type, uint16_t *packet_id)
{
    struct mqtt_queued_message *curr;
    for(curr = mqtt_mq_get(mq, 0); curr >= mq->queue_tail; --curr) {
        if (curr->control_type == control_type) {
            if ((packet_id == NULL && curr->state != MQTT_QUEUED_COMPLETE) ||
                (packet_id != NULL && *packet_id == curr->packet_id)) {
                return curr;
            }
        }
    }
    return NULL;
}


/* RESPONSE UNPACKING */
int16_t mqtt_unpack_response(struct mqtt_response* response, const uint8_t *buf, uint16_t bufsz)
{
    const uint8_t *const start = buf;
    int16_t rv = mqtt_unpack_fixed_header(response, buf, bufsz);
    
    if (rv <= 0) return rv;
    else buf += rv;
    
    switch(response->fixed_header.control_type) {
        case MQTT_CONTROL_CONNACK:
            rv = mqtt_unpack_connack_response(response, buf);
            break;
        case MQTT_CONTROL_PUBLISH:
            rv = mqtt_unpack_publish_response(response, buf);
            break;
        case MQTT_CONTROL_SUBACK:
            rv = mqtt_unpack_suback_response(response, buf);
            break;
        case MQTT_CONTROL_PINGRESP:
            return rv;
        default:
            return MQTT_ERROR_RESPONSE_INVALID_CONTROL_TYPE;
    }

    if (rv < 0) return rv;
    buf += rv;
    return buf - start;
}


/* EXTRA DETAILS */
// MN: The original code used the definitions in arpa/inet.h. The
// original code also used both htons() and ntohs(), which are really
// the same function (defined with a weak alias).
// Since I want to get rid of dependencies on these OS based .h files
// I replaced the calls here.
// htons() does nothing more than swap the high order and low order
// bytes of a 16 bit value based on whether or not the host endianess
// and network endianess match. The network is BIG ENDIAN, and a host
// can be either. In this application the host is also BIG ENDIAN, so
// no swap is required. Still, the code makes this choice based on
// a setting in the uipopt.h file (search for UIP_BYTE_ORDER).
//
int16_t __mqtt_pack_uint16(uint8_t *buf, uint16_t integer)
{
  uint16_t integer_htons = HTONS(integer);
  memcpy(buf, &integer_htons, 2);
  return 2;
}


uint16_t __mqtt_unpack_uint16(const uint8_t *buf)
{
  uint16_t integer_htons;
  memcpy(&integer_htons, buf, 2);
  return HTONS(integer_htons);
}


int16_t __mqtt_pack_str(uint8_t *buf, const char* str)
{
    uint16_t length = (uint16_t)strlen(str);
    int16_t i = 0;
     // pack string length
    buf += __mqtt_pack_uint16(buf, length);

    // pack string
    for(; i < length; ++i) *(buf++) = str[i];
    
    // return number of bytes consumed
    return length + 2;
}

#endif // BUILD_SUPPORT == MQTT_BUILD
