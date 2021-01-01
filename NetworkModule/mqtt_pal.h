#ifndef __MQTT_PAL_H__
#define __MQTT_PAL_H__

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


/**
 * Includes/supports the types/calls required by the MQTT-C client.
 * 
 * This is the only file included in mqtt.h, and mqtt.c. It is therefore 
 * responsible for including/supporting all the required types and calls. 
 * 
 * Platform abstraction layer
 * Documentation of the types and calls required to port MQTT-C to a new platform.
 * 
 * mqtt_pal.h is the only header file included in mqtt.c. Therefore, to port MQTT-C to a 
 * new platform the following types, functions, constants, and macros must be defined in 
 * mqtt_pal.h:
 *  - Types:
 *      - int8_t, int16_t, int32_t
 *      - uint8_t, uint16_t, uint32_t
 *  - Functions:
 *      - memcpy, strlen
 *  - Constants:
 *      - INT_MIN
 * 
 * Additionally, these macro's are required:
 *  - HTONS(s) : host-to-network endian conversion for uint16_t.
 * 
 * Lastly, mqtt_pal_sendall and mqtt_pal_recvall, must be implemented in mqtt_pal.c 
 * for sending and receiving data.
 */


#include <limits.h>
#include <string.h>
#include <stdint.h>

// Sends all the bytes in a buffer.
// buf - A pointer to the first byte in the buffer to send.
// len - The number of bytes to send (starting at buf).
// returns - The number of bytes sent if successful, an MQTTErrors otherwise.
int16_t mqtt_pal_sendall(const void* buf, uint16_t len);


// Non-blocking receive all the byte available.
// buf - A pointer to the receive buffer.
// bufsz - The max number of bytes that can be put into buf.
// returns - The number of bytes received if successful, an MQTTErrors otherwise.
int16_t mqtt_pal_recvall(void* buf, uint16_t bufsz);

#endif // define __MQTT_PAL_H__

