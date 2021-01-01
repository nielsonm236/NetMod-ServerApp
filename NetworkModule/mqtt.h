#ifndef __MQTT_H__
#define __MQTT_H__

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



#include <mqtt_pal.h>

/**
 * Declares all the MQTT-C functions and datastructures.
 * 
 * API
 * Documentation of everything you need to know to use the MQTT-C client.
 * 
 * This module contains everything you need to know to use MQTT-C in your
 * application.
 * For usage examples see:
 *     - simple_publisher.c
 *     - simple_subscriber.c
 *     - reconnect_subscriber.c
 *     - bio_publisher.c
 *     - openssl_publisher.c
 * 
 * MQTT-C can be used in both single-threaded and multi-threaded applications.
 * All the functions in api are thread-safe.
 * 
 * packers Control Packet Serialization
 * Developer documentation of the functions and datastructures used for
 * serializing MQTT control packets.
 * 
 * unpackers Control Packet Deserialization
 * Developer documentation of the functions and datastructures used for
 * deserializing MQTT control packets.
 * 
 * details Utilities
 * Developer documentation for the utilities used to implement the MQTT-C
 * client.
 *
 * To deserialize a packet from a buffer use mqtt_unpack_response (it's the
 * only function you need).
 */


// An enumeration of the MQTT control packet types. 
// see <a href="http://docs.oasis-open.org/mqtt/mqtt/v3.1.1/os/mqtt-v3.1.1-os.html#_Toc398718021">
// MQTT v3.1.1: MQTT Control Packet Types
  enum MQTTControlPacketType {
    MQTT_CONTROL_CONNECT=1u,
    MQTT_CONTROL_CONNACK=2u,
    MQTT_CONTROL_PUBLISH=3u,
    MQTT_CONTROL_SUBSCRIBE=8u,
    MQTT_CONTROL_SUBACK=9u,
    MQTT_CONTROL_PINGREQ=12u,
    MQTT_CONTROL_PINGRESP=13u,
    MQTT_CONTROL_DISCONNECT=14u
};


// The fixed header of an MQTT control packet.
// see <a href="http://docs.oasis-open.org/mqtt/mqtt/v3.1.1/os/mqtt-v3.1.1-os.html#_Toc398718020">
// MQTT v3.1.1: Fixed Header
struct mqtt_fixed_header {
    // The type of packet
    enum MQTTControlPacketType control_type;

    // The packets control flags
    uint32_t  control_flags: 4;

    // The remaining size of the packet in bytes (i.e. the size of variable
    // header and payload)
    uint32_t remaining_length;
};


// The protocol identifier for MQTT v3.1.1.
// see <a href="http://docs.oasis-open.org/mqtt/mqtt/v3.1.1/os/mqtt-v3.1.1-os.html#_Toc398718030">
// MQTT v3.1.1: CONNECT Variable Header.
#define MQTT_PROTOCOL_LEVEL 0x04



// MQTTErrors defines
// This needs to be kept at int16_t. The functions that utilize these codes as
// return values also return int16_t values for 'bytes sent', so the int size
// needs to match. The negative values need to remain negative - that is how
// MQTT ERRORs vs MQTT OK are differentiated in runtime code.
#define MQTT_ERROR_UNKNOWN                         (int16_t)0x8000
#define MQTT_ERROR_NULLPTR                         (int16_t)0x8001
#define MQTT_ERROR_CONTROL_FORBIDDEN_TYPE          (int16_t)0x8002
#define MQTT_ERROR_CONTROL_INVALID_FLAGS           (int16_t)0x8003
#define MQTT_ERROR_CONTROL_WRONG_TYPE              (int16_t)0x8004
#define MQTT_ERROR_CONNECT_CLIENT_ID_REFUSED       (int16_t)0x8005
#define MQTT_ERROR_CONNECT_NULL_WILL_MESSAGE       (int16_t)0x8006
#define MQTT_ERROR_CONNECT_FORBIDDEN_WILL_QOS      (int16_t)0x8007
#define MQTT_ERROR_CONNACK_FORBIDDEN_FLAGS         (int16_t)0x8008
#define MQTT_ERROR_CONNACK_FORBIDDEN_CODE          (int16_t)0x8009
#define MQTT_ERROR_PUBLISH_FORBIDDEN_QOS           (int16_t)0x800A
#define MQTT_ERROR_SUBSCRIBE_TOO_MANY_TOPICS       (int16_t)0x800B
#define MQTT_ERROR_MALFORMED_RESPONSE              (int16_t)0x800C
#define MQTT_ERROR_UNSUBSCRIBE_TOO_MANY_TOPICS     (int16_t)0x800D
#define MQTT_ERROR_RESPONSE_INVALID_CONTROL_TYPE   (int16_t)0x800E
#define MQTT_ERROR_CONNECT_NOT_CALLED              (int16_t)0x800F
#define MQTT_ERROR_SEND_BUFFER_IS_FULL             (int16_t)0x8010
#define MQTT_ERROR_SOCKET_ERROR                    (int16_t)0x8011
#define MQTT_ERROR_MALFORMED_REQUEST               (int16_t)0x8012
#define MQTT_ERROR_RECV_BUFFER_TOO_SMALL           (int16_t)0x8013
#define MQTT_ERROR_ACK_OF_UNKNOWN                  (int16_t)0x8014
#define MQTT_ERROR_NOT_IMPLEMENTED                 (int16_t)0x8015
#define MQTT_ERROR_CONNECTION_REFUSED              (int16_t)0x8016
#define MQTT_ERROR_SUBSCRIBE_FAILED                (int16_t)0x8017
#define MQTT_ERROR_CONNECTION_CLOSED               (int16_t)0x8018
#define MQTT_ERROR_INITIAL_RECONNECT               (int16_t)0x8019
#define MQTT_ERROR_INVALID_REMAINING_LENGTH        (int16_t)0x801A
#define MQTT_ERROR_CLEAN_SESSION_IS_REQUIRED       (int16_t)0x801B
#define MQTT_ERROR_RECONNECTING                    (int16_t)0x801C
#define MQTT_OK                                    (int16_t)1


// Pack a MQTT 16 bit integer, given a native 16 bit integer
// buf - the buffer that the MQTT integer will be written to
// integer - the native integer to be written to buf
// This function provides no error checking
// returns 2
int16_t __mqtt_pack_uint16(uint8_t *buf, uint16_t integer);


// Unpack a MQTT 16 bit integer to a native 16 bit integer.
// buf - the buffer that the MQTT integer will be read from.
// This function provides no error checking and does not modify buf.
// returns The native integer
uint16_t __mqtt_unpack_uint16(const uint8_t *buf);


// Pack a MQTT string, given a c-string str.
// buf - the buffer that the MQTT string will be written to.
// str - the c-string to be written to buf.
// This function provides no error checking.
// returns strlen(str) + 2
int16_t __mqtt_pack_str(uint8_t *buf, const char* str);


// A macro to get the MQTT string length from a c-string
#define __mqtt_packed_cstrlen(x) (2 + strlen(x))


/* RESPONSES */

// An enumeration of the return codes returned in a CONNACK packet.
// see <a href="http://docs.oasis-open.org/mqtt/mqtt/v3.1.1/os/mqtt-v3.1.1-os.html#_Table_3.1_-">
// MQTT v3.1.1: CONNACK return codes.
enum MQTTConnackReturnCode {
    MQTT_CONNACK_ACCEPTED = 0u,
    MQTT_CONNACK_REFUSED_PROTOCOL_VERSION = 1u,
    MQTT_CONNACK_REFUSED_IDENTIFIER_REJECTED = 2u,
    MQTT_CONNACK_REFUSED_SERVER_UNAVAILABLE = 3u,
    MQTT_CONNACK_REFUSED_BAD_USER_NAME_OR_PASSWORD = 4u,
    MQTT_CONNACK_REFUSED_NOT_AUTHORIZED = 5u
};


// A connection response datastructure.
// see <a href="http://docs.oasis-open.org/mqtt/mqtt/v3.1.1/os/mqtt-v3.1.1-os.html#_Toc398718033">
// MQTT v3.1.1: CONNACK - Acknowledgement connection response.
struct mqtt_response_connack {
    // Allows client and broker to check if they have a consistent view about
    // whether there is already a stored session state.
    uint8_t session_present_flag;

    // The return code of the connection request. 
    // see MQTTConnackReturnCode
    enum MQTTConnackReturnCode return_code;
};


// A publish packet received from the broker.
// A publish packet is received from the broker when a client publishes to a
// topic that the {local client} is subscribed to.
// see <a href="http://docs.oasis-open.org/mqtt/mqtt/v3.1.1/os/mqtt-v3.1.1-os.html#_Toc398718037"> 
// MQTT v3.1.1: PUBLISH - Publish Message.
struct mqtt_response_publish {
    // The DUP flag. DUP flag is 0 if its the first attempt to send this
    // publish packet. A DUP flag of 1 means that this might be a re-delivery
    // of the packet.
    uint8_t dup_flag;

    // The quality of service level.
    // see <a href="http://docs.oasis-open.org/mqtt/mqtt/v3.1.1/os/mqtt-v3.1.1-os.html#_Table_3.11_-">
    // MQTT v3.1.1: QoS Definitions
    uint8_t qos_level;

    // The retain flag of this publish message
    uint8_t retain_flag;

    // Size of the topic name (number of characters)
    uint16_t topic_name_size;

    // The topic name. 
    // topic_name is not null terminated. Therefore topic_name_size must be
    // used to get the string length.
    const void* topic_name;

    // The publish message's packet ID
    uint16_t packet_id;

    // The publish message's application message
    const void* application_message;

    // The size of the application message in bytes
    uint16_t application_message_size;
};


// An enumeration of subscription acknowledgement return codes.
// see <a href="http://docs.oasis-open.org/mqtt/mqtt/v3.1.1/os/mqtt-v3.1.1-os.html#_Figure_3.26_-">
// MQTT v3.1.1: SUBACK Return Codes.
enum MQTTSubackReturnCodes {
    MQTT_SUBACK_SUCCESS_MAX_QOS_0 = 0u,
    MQTT_SUBACK_FAILURE           = 128u
};


// The response to a subscription request.
// see <a href="http://docs.oasis-open.org/mqtt/mqtt/v3.1.1/os/mqtt-v3.1.1-os.html#_Toc398718068">
// MQTT v3.1.1: SUBACK - Subscription Acknowledgement.
struct mqtt_response_suback {
    // The published messages packet ID
    uint16_t packet_id;

    // Array of return codes corresponding to the requested subscribe topics.
    // see MQTTSubackReturnCodes
    const uint8_t *return_codes;

    // The number of return codes
    uint16_t num_return_codes;
};


// The response to a ping request.
// This response contains no members.
// see <a href="http://docs.oasis-open.org/mqtt/mqtt/v3.1.1/os/mqtt-v3.1.1-os.html#_Toc398718086">
// MQTT v3.1.1: PINGRESP - Ping Response.
struct mqtt_response_pingresp {
  int16_t dummy;
};


// A struct used to deserialize/interpret an incoming packet from the broker.
struct mqtt_response {
    // The mqtt_fixed_header of the deserialized packet
    struct mqtt_fixed_header fixed_header;

    // A union of the possible responses from the broker.
    // The fixed_header contains the control type. This control type
    // corresponds to the member of this union that should be accessed. For
    // example if fixed_header#control_type == MQTT_CONTROL_PUBLISH then 
    // decoded#publish should be accessed.
    union {
        struct mqtt_response_connack  connack;
        struct mqtt_response_publish  publish;
        struct mqtt_response_suback   suback;
        struct mqtt_response_pingresp pingresp;
    } decoded;
};


// Deserialize the contents of buf into an mqtt_fixed_header object.
// This function performs complete error checking and a positive return value
// means the entire mqtt_response can be deserialized from buf.
// response - the response who's mqtt_response.fixed_header will be
// initialized.
// buf - the buffer.
// bufsz - the total number of bytes in the buffer.
// returns - The number of bytes that were consumed, or 0 if the buffer does
//     not contain enough bytes to parse the packet, or a negative value if
//     there was a protocol violation.
int16_t mqtt_unpack_fixed_header(struct mqtt_response *response, const uint8_t *buf, uint16_t bufsz);


// Deserialize a CONNACK response from buf.
// prerequisite: mqtt_unpack_fixed_header must have returned a positive value
//     and the control packet type must be MQTT_CONTROL_CONNACK.
//  
// mqtt_response - the mqtt_response that will be initialized.
// buf - the buffer that contains the variable header and payload of the
//     packet. The first byte of buf should be the first byte of the variable
//     header.
// returns - The number of bytes that were consumed, or 0 if the buffer does
//     not contain enough bytes to parse the packet, or a negative value if
//     there was a protocol violation.
//  
// see mqtt_response_connack 
int16_t mqtt_unpack_connack_response (struct mqtt_response *mqtt_response, const uint8_t *buf);


// Deserialize a publish response from buf.
// prerequisite: mqtt_unpack_fixed_header must have returned a positive value
// and the mqtt_response must have a control type of MQTT_CONTROL_PUBLISH.
//  
// mqtt_response - the response that is initialized from the contents of buf.
// buf - the buffer with the incoming data.
// returns - The number of bytes that were consumed, or 0 if the buffer does
//     not contain enough bytes to parse the packet, or a negative value if
//     there was a protocol violation.
//  
// see mqtt_response_publish 
int16_t mqtt_unpack_publish_response (struct mqtt_response *mqtt_response, const uint8_t *buf);


// Deserialize a SUBACK packet from buf.
// pre - mqtt_unpack_fixed_header must have returned a positive value and the
// mqtt_response must have a control type of MQTT_CONTROL_SUBACK.
//  
// mqtt_response - the response that is initialized from the contents of buf.
// buf - the buffer with the incoming data.
// returns - The number of bytes that were consumed, or 0 if the buffer does
// not contain enough bytes to parse the packet, or a negative value if there
// was a protocol violation.
// 
// see mqtt_response_suback
int16_t mqtt_unpack_suback_response(struct mqtt_response *mqtt_response, const uint8_t *buf);


// Deserialize a packet from the broker.
// response - the mqtt_response that will be initialize from buf.
// buf - the incoming data buffer.
// bufsz - the number of bytes available in the buffer.
// returns - The number of bytes consumed on success, zero if buf does not
// contain enough bytes to deserialize the packet, a negative value if a 
// protocol violation was encountered.  
//  
// see mqtt_response
int16_t mqtt_unpack_response(struct mqtt_response* response, const uint8_t *buf, uint16_t bufsz);



/* REQUESTS */

// Serialize an mqtt_fixed_header and write it to buf.
// This function performs complete error checking and a positive return value
// guarantees the entire packet will fit into the given buffer.
//  
// buf - the buffer to write to.
// bufsz - the maximum number of bytes that can be put in to buf.
// fixed_header - the fixed header that will be serialized.
// returns - The number of bytes written to buf, or 0 if buf is too small, or a 
// negative value if there was a protocol violation.
int16_t mqtt_pack_fixed_header(uint8_t *buf, uint16_t bufsz, const struct mqtt_fixed_header *fixed_header);


// An enumeration of CONNECT packet flags.
// see <a href="http://docs.oasis-open.org/mqtt/mqtt/v3.1.1/os/mqtt-v3.1.1-os.html#_Toc398718030">
// MQTT v3.1.1: CONNECT Variable Header.
enum MQTTConnectFlags {
    MQTT_CONNECT_RESERVED = 1u,
    MQTT_CONNECT_CLEAN_SESSION = 2u,
    MQTT_CONNECT_WILL_FLAG = 4u,
    MQTT_CONNECT_WILL_QOS_0 = (0u & 0x03) << 3,
    MQTT_CONNECT_WILL_QOS_1 = (1u & 0x03) << 3,
    MQTT_CONNECT_WILL_QOS_2 = (2u & 0x03) << 3,
    MQTT_CONNECT_WILL_RETAIN = 32u,
    MQTT_CONNECT_PASSWORD = 64u,
    MQTT_CONNECT_USER_NAME = 128u
};


// Serialize a connection request into a buffer. 
// buf - the buffer to pack the connection request packet into.
// bufsz - the number of bytes left in buf.
// client_id - the ID that identifies the local client. client_id can be NULL
//     or an empty string for Anonymous clients.
// will_topic - the topic under which the local client's will message will be
//     published. Set to NULL for no will message. If will_topic is not NULL
//     a will_message must also be provided.
// will_message - the will message to be published upon a unsuccessful
//     disconnection of the local client. Set to NULL if will_topic is NULL.
//     Will_message must not be NULL if will_topic is not NULL.
// will_message_size - The size of will_message in bytes.
// user_name - the username to be used to connect to the broker with. Set to
//     NULL if no username is required.
// password - the password to be used to connect to the broker with. Set to
//     NULL if no password is required.
// connect_flags - additional MQTTConnectFlags to be set. The only flags that
//     need to be set manually are MQTT_CONNECT_CLEAN_SESSION, 
//     MQTT_CONNECT_WILL_QOS_X (for X &isin; {0, 1, 2}), and
//     MQTT_CONNECT_WILL_RETAIN. Set to 0 if no additional flags are required.
// keep_alive - the keep alive time in seconds. It is the responsibility of
//     the clinet to ensure packets are sent to the server {at least} this
//     frequently.
// returns - The number of bytes put into buf, 0 if buf is too small to fit
//     the CONNECT packet, a negative value if there was a protocol violation.
// 
// If there is a will_topic and no additional connect_flags are given, then
// by default will_message will be published at QoS level 0.
//  
// see <a href="http://docs.oasis-open.org/mqtt/mqtt/v3.1.1/os/mqtt-v3.1.1-os.html#_Toc398718028">
// MQTT v3.1.1: CONNECT - Client Requests a Connection to a Server.
int16_t mqtt_pack_connection_request(uint8_t* buf, uint16_t bufsz, 
                                     const char* client_id,
                                     const char* will_topic,
                                     const void* will_message,
                                     uint16_t will_message_size,
                                     const char* user_name,
                                     const char* password,
                                     uint8_t connect_flags,
                                     uint16_t keep_alive);


// An enumeration of the PUBLISH flags.
// see <a href="http://docs.oasis-open.org/mqtt/mqtt/v3.1.1/os/mqtt-v3.1.1-os.html#_Toc398718037">
// MQTT v3.1.1: PUBLISH - Publish Message.
enum MQTTPublishFlags {
    MQTT_PUBLISH_DUP = 8u,
    MQTT_PUBLISH_QOS_0 = ((0u << 1) & 0x06),
    MQTT_PUBLISH_QOS_1 = ((1u << 1) & 0x06),
    MQTT_PUBLISH_QOS_2 = ((2u << 1) & 0x06),
    MQTT_PUBLISH_QOS_MASK = ((3u << 1) & 0x06),
    MQTT_PUBLISH_RETAIN = 0x01
};


// Serialize a PUBLISH request and put it in buf.
// buf - the buffer to put the PUBLISH packet in.
// bufsz - the maximum number of bytes that can be put into buf.
// topic_name - the topic to publish application_message under.
// packet_id - this packets packet ID.
// application_message - the application message to be published.
// application_message_size - the size of application_message in bytes.
// publish_flags - The flags to publish application_message with. These
//     include the MQTT_PUBLISH_DUP flag, MQTT_PUBLISH_QOS_X (X &isin;
//     {0, 1, 2}), and MQTT_PUBLISH_RETAIN flag.
// returns - The number of bytes put into buf, 0 if buf is too small to fit
//     the PUBLISH packet, a negative value if there was a protocol violation.
//  
// The default QoS is level 0.
//  
// see <a href="http://docs.oasis-open.org/mqtt/mqtt/v3.1.1/os/mqtt-v3.1.1-os.html#_Toc398718037">
// MQTT v3.1.1: PUBLISH - Publish Message.
int16_t mqtt_pack_publish_request(uint8_t *buf, uint16_t bufsz,
                                  const char* topic_name,
                                  uint16_t packet_id,
                                  const void* application_message,
                                  uint16_t application_message_size,
                                  uint8_t publish_flags);


// Serialize a SUBSCRIBE packet and put it in buf.
// buf - the buffer to put the SUBSCRIBE packet in.
// bufsz - the maximum number of bytes that can be put into buf.
// packet_id - the packet ID to be used.
// topic_name - the topic name to subscribe to
// returns - The number of bytes put into buf, 0 if buf is too small to fit
//     the SUBSCRIBE packet, a negative value if there was a protocol
//     violation.
//  
// see <a href="http://docs.oasis-open.org/mqtt/mqtt/v3.1.1/os/mqtt-v3.1.1-os.html#_Toc398718063">
// MQTT v3.1.1: SUBSCRIBE - Subscribe to Topics.
int16_t mqtt_pack_subscribe_request(uint8_t *buf, uint16_t bufsz, 
                                    uint16_t packet_id, char *topic);


// Serialize a PINGREQ and put it into buf.
// buf - the buffer to put the PINGREQ packet in.
// bufsz - the maximum number of bytes that can be put into buf.
// returns - The number of bytes put into buf, 0 if buf is too small to fit
//     the PINGREQ packet, a negative value if there was a protocol violation.
//  
// see <a href="http://docs.oasis-open.org/mqtt/mqtt/v3.1.1/os/mqtt-v3.1.1-os.html#_Toc398718081">
// MQTT v3.1.1: PINGREQ - Ping Request.
int16_t mqtt_pack_ping_request(uint8_t *buf, uint16_t bufsz);


// Serialize a DISCONNECT and put it into buf.
// buf - the buffer to put the DISCONNECT packet in.
// bufsz - the maximum number of bytes that can be put into buf.
// returns - The number of bytes put into buf, 0 if buf is too small to fit
//     the DISCONNECT packet, a negative value if there was a protocol
//     violation.
//  
// see <a href="http://docs.oasis-open.org/mqtt/mqtt/v3.1.1/os/mqtt-v3.1.1-os.html#_Toc398718090">
// MQTT v3.1.1: DISCONNECT - Disconnect Notification.
int16_t mqtt_pack_disconnect(uint8_t *buf, uint16_t bufsz);


// An enumeration of queued message states. 
enum MQTTQueuedMessageState {
    MQTT_QUEUED_UNSENT,
    MQTT_QUEUED_AWAITING_ACK,
    MQTT_QUEUED_COMPLETE
};


// A message in a mqtt_message_queue.
struct mqtt_queued_message {
    // A pointer to the start of the message
    uint8_t *start;

    // The number of bytes in the message
    uint16_t size;

    // The state of the message
    enum MQTTQueuedMessageState state;

    // The time at which the message was sent..
    // A timeout will only occur if the message is in
    // the MQTT_QUEUED_AWAITING_ACK state.
    uint32_t time_sent;

    // The control type of the message.
    enum MQTTControlPacketType control_type;

    // The packet id of the message.
    // This field is only used if the associate control_type has a 
    // packet_id field.
    uint16_t packet_id;
};


// A message queue.
// This struct is used internally to manage sending messages.
// The only members the user should use are curr and curr_sz. 
struct mqtt_message_queue {
    // The start of the message queue's memory block. 
    // This member should not be manually changed.
    void *mem_start;

    // The end of the message queue's memory block
    void *mem_end;

    // A pointer to the position in the buffer you can pack bytes at.
    // Immediately after packing bytes at curr you must call mqtt_mq_register.
    uint8_t *curr;

    // The number of bytes that can be written to curr.
    // curr_sz will decrease by more than the number of bytes you write to 
    // curr. This is because the mqtt_queued_message structs share the 
    // same memory (and thus, a mqtt_queued_message must be allocated in 
    // the message queue's memory whenever a new message is registered).  
    uint16_t curr_sz;
    
    // The tail of the array of mqtt_queued_messages's.
    // This member should not be used manually.
    struct mqtt_queued_message *queue_tail;
};


// Initialize a message queue.
// mq - The message queue to initialize.
// buf - The buffer for this message queue.
// bufsz - The number of bytes in the buffer. 
//  
// see mqtt_message_queue
void mqtt_mq_init(struct mqtt_message_queue *mq, void *buf, uint16_t bufsz);


// Clear as many messages from the front of the queue as possible.
// Calls to this function are the only way to remove messages from the queue.
// mq - The message queue.
//
// see mqtt_message_queue
void mqtt_mq_clean(struct mqtt_message_queue *mq);


// Register a message that was just added to the buffer.
// This function should be called immediately following a call to a packer
// function that returned a positive value. The positive value (number of
// bytes packed) should be passed to this function.
// mq - The message queue.
// nbytes - The number of bytes that were just packed.
// returns - The newly added struct mqtt_queued_message.
//  
// This function will step mqtt_message_queue::curr and update
// mqtt_message_queue::curr_sz.
//
// see mqtt_message_queue
struct mqtt_queued_message* mqtt_mq_register(struct mqtt_message_queue *mq, uint16_t nbytes);


// Find a message in the message queue.
// mq - The message queue.
// control_type - The control type of the message you want to find.
// packet_id - The packet ID of the message you want to find. Set to NULL if
//     you don't want to specify a packet ID.
// returns - The found message. NULL if the message was not found.
//  
// see mqtt_message_queue
struct mqtt_queued_message* mqtt_mq_find(struct mqtt_message_queue *mq, enum MQTTControlPacketType control_type, uint16_t *packet_id);


// Returns the mqtt_queued_message at index.
// mq_ptr - A pointer to the message queue.
// index - The index of the message. 
// returns - The mqtt_queued_message at index.
#define mqtt_mq_get(mq_ptr, index) (((struct mqtt_queued_message*) ((mq_ptr)->mem_end)) - 1 - index)


// Returns the number of messages in the message queue, mq_ptr.
#define mqtt_mq_length(mq_ptr) (((struct mqtt_queued_message*) ((mq_ptr)->mem_end)) - (mq_ptr)->queue_tail)


// Used internally to recalculate the curr_sz.
#define mqtt_mq_currsz(mq_ptr) (mq_ptr->curr >= (uint8_t*) ((mq_ptr)->queue_tail - 1)) ? 0 : ((uint8_t*) ((mq_ptr)->queue_tail - 1)) - (mq_ptr)->curr






/* CLIENT */

// An MQTT client
// All members can be manipulated via the related functions.
struct mqtt_client {
    // The LFSR state used to generate packet ID's.
    uint16_t pid_lfsr;

    // The keep-alive time in seconds
    uint16_t keep_alive;

    // The current sent offset.
    // This is used to allow partial send commands.
    uint16_t send_offset;

    // The timestamp of the last message sent to the buffer.
    // This is used to detect the need for keep-alive pings.
    // see keep_alive
    uint32_t time_of_last_send;

    // The error state of the client. 
    // error should be MQTT_OK for the entirety of the connection.
    // The error state will be MQTT_ERROR_CONNECT_NOT_CALLED until you call
    // mqtt_connect.
    int16_t error;

    // The timeout period in seconds.
    // If the broker doesn't return an ACK within response_timeout seconds a
    // timeout will occur and the message will be retransmitted. 
    // The default value is 30 [seconds] but you can change it at any time.
    int16_t response_timeout;

    // A counter counting the number of timeouts that have occurred
    int16_t number_of_timeouts;

    // The callback that is called whenever a publish is received from the
    // broker. Any topics that you have subscribed to will be returned from
    // the broker as mqtt_response_publish messages. All the publishes
    // received from the broker will be passed to this function.
    // A pointer to publish_response_callback_state is always passed to the
    // callback. Use publish_response_callback_state to keep track of any
    // state information you need.
    void (*publish_response_callback)(void** state, struct mqtt_response_publish *publish);

    // A pointer to any publish_response_callback state information you need.
    // A pointer to this pointer will always be publish_response_callback
    // upon receiving a publish message from the broker.
    void* publish_response_callback_state;

    // The buffer where ingress data is temporarily stored.
    struct {
        // The start of the receive buffer's memory
        uint8_t *mem_start;

        // The size of the receive buffer's memory
        uint16_t mem_size;

        // A pointer to the next writtable location in the receive buffer
        uint8_t *curr;

        // The number of bytes that are still writable at curr
        uint16_t curr_sz;
    } recv_buffer;

    // The sending message queue
    struct mqtt_message_queue mq;
};




// Generate a new next packet ID.
// Packet ID's are generated using a max-length LFSR.
// client - The MQTT client.
// returns - The new packet ID that should be used.
uint16_t __mqtt_next_pid(struct mqtt_client *client);


// Handles egress client traffic.
// client - The MQTT client.
// returns - MQTT_OK upon success, an MQTTErrors otherwise. 
int16_t __mqtt_send(struct mqtt_client *client);


// Handles ingress client traffic.
// client - The MQTT client.
// returns - MQTT_OK upon success, an MQTTErrors otherwise. 
int16_t __mqtt_recv(struct mqtt_client *client);


// Function that does the actual sending and receiving of traffic from the
// network.
//  
// All the other functions in the @ref api simply stage messages for being
// sent to the broker. This function does the actual sending of those
// messages. Additionally this function receives traffic (responses and 
// acknowledgements) from the broker and responds to that traffic accordingly.
// Lastly this function also calls the publish_response_callback when any
// MQTT_CONTROL_PUBLISH messages are received.
//  
// prerequisite: mqtt_init must have been called.
//  
// client - The MQTT client.
// returns - MQTT_OK upon success, an MQTTErrors otherwise. 
//  
// It is the responsibility of the application programmer to call this
// function periodically. All functions in the @ref api are thread-safe so it
// is perfectly reasonable to have a thread dedicated to calling this function
// every 200 ms or so. MQTT-C can be used in single threaded application
// though by simply calling this functino periodically inside your main
// thread. See @ref simple_publisher.c and @ref simple_subscriber.c for
// examples (specifically the client_refresher functions).
int16_t mqtt_sync(struct mqtt_client *client);


// Initializes an MQTT client.
// This function must be called before any other API function calls.
//  
// prerequisite: None.
//  
// client - The MQTT client.
// sendbuf - A buffer that will be used for sending messages to the broker.
// sendbufsz - The size of sendbuf in bytes.
// recvbuf - A buffer that will be used for receiving messages from the
//     broker.
// recvbufsz - The size of recvbuf in bytes.
// publish_response_callback - The callback to call whenever application
//     messages are received from the broker. 
// returns - MQTT_OK upon success, an MQTTErrors otherwise.
//  
// post mqtt_connect must be called.
//  
// If sendbuf fills up completely during runtime a 
// MQTT_ERROR_SEND_BUFFER_IS_FULL error will be set. Similarly if recvbuf is
// ever too small to receive a message from the broker an
// MQTT_ERROR_RECV_BUFFER_TOO_SMALL error will be set.
//
// A pointer to mqtt_client.publish_response_callback_state is always passed
// as the state argument to publish_response_callback. Note that the second
// argument is the mqtt_response_publish that was received from the broker.
//  
// Only initialize an MQTT client once (i.e. don't call mqtt_init or 
// mqtt_init_reconnect more than once per client).
int16_t mqtt_init(struct mqtt_client *client,
                          uint8_t *sendbuf, uint16_t sendbufsz,
                          uint8_t *recvbuf, uint16_t recvbufsz,
                          void (*publish_response_callback)(void** state, struct mqtt_response_publish *publish));


// Establishes a session with the MQTT broker.
// prerequisite: mqtt_init must have been called.
//  
// client - The MQTT client.
// client_id - The unique name identifying the client. (or NULL)
// will_topic - The topic name of client's will_message. If no will message
//     is desired set to NULL.
// will_message - The application message (data) to be published in the event
//     the client ungracefully disconnects. Set to NULL if will_topic is NULL.
// will_message_size - The size of will_message in bytes.
// user_name - The username to use when establishing the session with the MQTT
//     broker. Set to NULL if a username is not required.
// password - The password to use when establishing the session with the MQTT
//     broker. Set to NULL if a password is not required.
// connect_flags - Additional MQTTConnectFlags to use when establishing the
//     connection. These flags are for forcing the session to start clean, 
//     MQTT_CONNECT_CLEAN_SESSION, the QOS level to publish the will_message
//     with (provided will_message != NULL), MQTT_CONNECT_WILL_QOS_[0,1,2],
//     and whether or not the broker should retain the will_message,
//     MQTT_CONNECT_WILL_RETAIN.
// keep_alive - The keep-alive time in seconds. A reasonable value for this
//     is 400 [seconds]. 
// returns - MQTT_OK upon success, an MQTTErrors otherwise.
int16_t mqtt_connect(struct mqtt_client *client,
                             const char* client_id,
                             const char* will_topic,
                             const void* will_message,
                             uint16_t will_message_size,
                             const char* user_name,
                             const char* password,
                             uint8_t connect_flags,
                             uint16_t keep_alive);


// Publish an application message.
// Publishes an application message to the MQTT broker.
//  
// prerequisite: mqtt_connect must have been called.
//  
// client - The MQTT client.
// topic_name - The name of the topic.
// application_message - The data to be published.
// application_message_size - The size of application_message in bytes.
// publish_flags - MQTTPublishFlags to be used, namely the QOS level to 
//     publish at (MQTT_PUBLISH_QOS_[0,1,2]) or whether or not the broker
//     should retain the publish (MQTT_PUBLISH_RETAIN).
// returns - MQTT_OK upon success, an MQTTErrors otherwise.
int16_t mqtt_publish(struct mqtt_client *client,
                             const char* topic_name,
                             const void* application_message,
                             uint16_t application_message_size,
                             uint8_t publish_flags);


// Subscribe to a topic.
//
// prerequisite: mqtt_connect must have been called.
//  
// client - The MQTT client.
// topic_name - The name of the topic to subscribe to.
// max_qos_level - The maximum QOS level with which the broker can send
//     application messages for this topic.
// returns - MQTT_OK upon success, an MQTTErrors otherwise. 
int16_t mqtt_subscribe(struct mqtt_client *client,
                               const char* topic_name);


// Ping the broker. 
// prerequisite: mqtt_connect must have been called.
// client - The MQTT client.
// returns - MQTT_OK upon success, an MQTTErrors otherwise.
int16_t mqtt_ping(struct mqtt_client *client);


// Ping the broker.
// see mqtt_ping
int16_t __mqtt_ping(struct mqtt_client *client);


// Terminate the session with the MQTT broker. 
//
// prerequisite: mqtt_connect must have been called.
//  
// client - The MQTT client.
// returns - MQTT_OK upon success, an MQTTErrors otherwise.
//  
// To re-establish the session, mqtt_connect must be called.
int16_t mqtt_disconnect(struct mqtt_client *client);

#endif // define __MQTT_H__
