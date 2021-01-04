/**
 * Header file for the uIP TCP/IP stack.
 * \author Adam Dunkels <adam@dunkels.com>
 *
 * The uIP TCP/IP stack header file contains definitions for a number
 * of C macros that are used by uIP programs as well as internal uIP
 * structures, TCP/IP header structures and function declarations.
 *
 */


/*
 * Copyright (c) 2001-2003, Adam Dunkels.
 * All rights reserved.
 *
 * Redistribution and use in source and binary forms, with or without
 * modification, are permitted provided that the following conditions
 * are met:
 * 1. Redistributions of source code must retain the above copyright
 *    notice, this list of conditions and the following disclaimer.
 * 2. Redistributions in binary form must reproduce the above copyright
 *    notice, this list of conditions and the following disclaimer in the
 *    documentation and/or other materials provided with the distribution.
 * 3. The name of the author may not be used to endorse or promote
 *    products derived from this software without specific prior
 *    written permission.
 *
 * THIS SOFTWARE IS PROVIDED BY THE AUTHOR ``AS IS'' AND ANY EXPRESS
 * OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
 * WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
 * ARE DISCLAIMED.  IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR ANY
 * DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
 * DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE
 * GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS
 * INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY,
 * WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING
 * NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
 * SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 *
 * This file is part of the uIP TCP/IP stack.
 *
 * $Id: uip.h,v 1.40 2006/06/08 07:12:07 adam Exp $
 *
 */
 
/* Modifications 2020 Michael Nielson
 * Adapted for STM8S005 processor, ENC28J60 Ethernet Controller,
 * Web_Relay_Con V2.0 HW-584, and compilation with Cosmic tool set.
 * Author: Michael Nielson
 * Email: nielsonm.projects@gmail.com
 *
 * This declaration applies to modifications made by Michael Nielson
 * and in no way changes the Adam Dunkels declaration above.
 
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



#ifndef __UIP_H__
#define __UIP_H__

#include "uipopt.h"


/**
 * Repressentation of an IP address.
 */
typedef uint16_t uip_ip4addr_t[2];
typedef uint16_t uip_ip6addr_t[8];
typedef uip_ip4addr_t uip_ipaddr_t;


/*---------------------------------------------------------------------------*/
/**
 * The uIP configuration functions are used for setting run-time parameters
 * in uIP such as IP addresses.
 */

/**
 * Set the IP address of this host. The IP address is represented as a 4-byte
 * array where the first octet of the IP address is put in the first member
 * of the 4-byte array.
 *
 * Example:
 \code

 uip_ipaddr_t addr;

 uip_ipaddr(&addr, 192,168,1,2);
 uip_sethostaddr(&addr);
 
 \endcode
 
 * addr - A pointer to an IP address of type uip_ipaddr_t;
 */
#define uip_sethostaddr(addr) uip_ipaddr_copy(uip_hostaddr, (addr))

/**
 * Get the IP address of this host.
 * The IP address is represented as a 4-byte array where the first octet of
 * the IP address is put in the first member of the 4-byte array.
 *
 * Example:
 \code
 uip_ipaddr_t hostaddr;

 uip_gethostaddr(&hostaddr);
 \endcode
 
 * addr - A pointer to a uip_ipaddr_t variable that will be
 * filled in with the currently configured IP address.
 */
#define uip_gethostaddr(addr) uip_ipaddr_copy((addr), uip_hostaddr)

/**
 * Set the default router's IP address.
 * addr - A pointer to a uip_ipaddr_t variable containing the IP address of
 * the default router.
 */
#define uip_setdraddr(addr) uip_ipaddr_copy(uip_draddr, (addr))

/**
 * Set the netmask.
 * addr - A pointer to a uip_ipaddr_t variable containing the IP address of
 * the netmask.
 */
#define uip_setnetmask(addr) uip_ipaddr_copy(uip_netmask, (addr))

/**
 * Get the default router's IP address.
 * addr - A pointer to a uip_ipaddr_t variable that will be filled in with
 * the IP address of the default router.
 */
#define uip_getdraddr(addr) uip_ipaddr_copy((addr), uip_draddr)

/**
 * Get the netmask.
 * addr - A pointer to a uip_ipaddr_t variable that will be filled in with
 * the value of the netmask.
 */
#define uip_getnetmask(addr) uip_ipaddr_copy((addr), uip_netmask)

/**
 * Set the MQTT Server IP Address.
 * addr - A pointer to a uip_ipaddr_t variable containing the IP address of
 * the MQTT Server.
 */
#define uip_setmqttserveraddr(addr) uip_ipaddr_copy(uip_mqttserveraddr, (addr))


/*---------------------------------------------------------------------------*/
/**
 * uIP initialization functions
 * The uIP initialization functions are used for booting uIP.
 */

/**
 * uIP initialization function.
 * This function should be called at boot up to initilize the uIP TCP/IP stack.
 */
void uip_init(void);

/**
 * uIP init statistics function.
 */
void uip_init_stats(void);

/**
 * uIP initialization function.
 * This function may be used at boot time to set the initial ip_id.
 */
void uip_setipid(uint16_t id);


/*---------------------------------------------------------------------------*/
/**
 * uIP device driver functions
 * These functions are used by a network device driver for interacting with uIP.
 */

/**
 * Process an incoming packet.
 * This function should be called when the device driver has received a packet
 * from the network. The packet from the device driver must be present in the
 * uip_buf buffer, and the length of the packet should be placed in the
 * uip_len variable.
 *
 * When the function returns, there may be an outbound packet placed in the
 * uip_buf packet buffer. If so, the uip_len variable is set to the length of
 * the packet. If no packet is to be sent out, the uip_len variable is set to
 * 0.
 *
 * The usual way of calling the function is presented by the source code
 * below.
 \code
  uip_len = devicedriver_poll();
  if(uip_len > 0) {
    uip_input();
    if(uip_len > 0) {
      devicedriver_send();
    }
  }
 \endcode
 *
 * If you are writing a uIP device driver that needs ARP (Address Resolution
 * Protocol), e.g., when running uIP over Ethernet, you will need to call the
 * uIP ARP code before calling this function:
 \code
  #define BUF ((struct uip_eth_hdr *)&uip_buf[0])
  uip_len = ethernet_devicedrver_poll();
  if(uip_len > 0) {
    if(BUF->type == HTONS(UIP_ETHTYPE_IP)) {
      uip_arp_ipin();
      uip_input();
      if(uip_len > 0) {
        uip_arp_out();
	ethernet_devicedriver_send();
      }
    } else if(BUF->type == HTONS(UIP_ETHTYPE_ARP)) {
      uip_arp_arpin();
      if(uip_len > 0) {
	ethernet_devicedriver_send();
      }
    }
 \endcode
 *
 */
#define uip_input()        uip_process(UIP_DATA)

/**
 * Periodic processing for a connection identified by its number.
 * This function does the necessary periodic processing (timers, polling) for
 * a uIP TCP connection, and should be called when the periodic uIP timer goes
 * off. It should be called for every connection, regardless of whether they
 * are open or closed.
 *
 * When the function returns, it may have an outbound packet waiting for
 * service in the uIP packet buffer, and if so the uip_len variable is set to
 * a value larger than zero. The device driver should be called to send out
 * the packet.
 *
 * The ususal way of calling the function is through a for() loop like this:
 \code
  for(i = 0; i < UIP_CONNS; ++i) {
    uip_periodic(i);
    if(uip_len > 0) {
      devicedriver_send();
    }
  }
 \endcode
 *
 * If you are writing a uIP device driver that needs ARP (Address Resolution
 * Protocol), e.g., when running uIP over Ethernet, you will need to call the
 * uip_arp_out() function before calling the device driver:
 \code
  for(i = 0; i < UIP_CONNS; ++i) {
    uip_periodic(i);
    if(uip_len > 0) {
      uip_arp_out();
      ethernet_devicedriver_send();
    }
  }
 \endcode
 *
 * conn - The number of the connection which is to be periodically polled.
 *
 */
#define uip_periodic(conn) do { uip_conn = &uip_conns[conn]; \
                                uip_process(UIP_TIMER); } while (0)

/**
 *
 *
 */
#define uip_conn_active(conn) (uip_conns[conn].tcpstateflags != UIP_CLOSED)

/**
 * Perform periodic processing for a connection identified by a pointer to its
 * structure.
 *
 * Same as uip_periodic() but takes a pointer to the actual uip_conn struct
 * instead of an integer as its argument. This function can be used to force
 * periodic processing of a specific connection.
 *
 * conn - A pointer to the uip_conn struct for the connection to be processed.
 *
 */
#define uip_periodic_conn(conn) do { uip_conn = conn; \
                                     uip_process(UIP_TIMER); } while (0)

/**
 * Reuqest that a particular connection should be polled.
 * Similar to uip_periodic_conn() but does not perform any timer processing.
 * The application is polled for new data.
 *
 * conn - The number of the connection which is to be polled.
 *
 */
#define uip_poll_one(conn) do { uip_conn = &uip_conns[conn]; \
                                 uip_process(UIP_POLL_REQUEST); } while (0)

/**
 * Reuqest that a particular connection should be polled.
 * Similar to uip_periodic_conn() but does not perform any timer processing.
 * The application is polled for new data.
 *
 * conn - A pointer to the uip_conn struct for the connection to be processed.
 *
 */
#define uip_poll_conn(conn) do { uip_conn = conn; \
                                 uip_process(UIP_POLL_REQUEST); } while (0)

/**
 * The uIP packet buffer.
 * The uip_buf array is used to hold incoming and outgoing packets. The device
 * driver should place incoming data into this buffer. When sending data, the
 * device driver should read the link level headers and the TCP/IP headers
 * from this buffer. The size of the link level headers is configured by the
 * UIP_LLH_LEN define.
 *
 * The application data need not be placed in this buffer, so the device driver
 * must read it from the place pointed to by the uip_appdata pointer as
 * illustrated by the following example:
 \code
 void
 devicedriver_send(void)
 {
    hwsend(&uip_buf[0], UIP_LLH_LEN);
    if(uip_len <= UIP_LLH_LEN + UIP_TCPIP_HLEN) {
      hwsend(&uip_buf[UIP_LLH_LEN], uip_len - UIP_LLH_LEN);
    } else {
      hwsend(&uip_buf[UIP_LLH_LEN], UIP_TCPIP_HLEN);
      hwsend(uip_appdata, uip_len - UIP_TCPIP_HLEN - UIP_LLH_LEN);
    }
 }
 \endcode
 */
extern uint8_t uip_buf[UIP_BUFSIZE+2];


/*---------------------------------------------------------------------------*/
/* Functions that are used by the uIP application program. Opening and closing
 * connections, sending and receiving data, etc. are all handled by the
 * functions below.
*/

/**
 * uIP application functions
 * Functions used by an application running of top of uIP.
 */

/**
 * Start listening to the specified port.
 * Since this function expects the port number in network byte order, a
 * conversion using HTONS() or htons() is necessary.
 *
 \code
 uip_listen(HTONS(80));
 \endcode
 *
 * port - A 16-bit port number in network byte order.
 */
void uip_listen(uint16_t port);


/**
 * Stop listening to the specified port.
 * Since this function expects the port number in network byte order, a
 * conversion using HTONS() or htons() is necessary.
 *
 \code
 uip_unlisten(HTONS(80));
 \endcode
 *
 * port - A 16-bit port number in network byte order.
 */
void uip_unlisten(uint16_t port);


/**
 * Connect to a remote host using TCP.
 *
 * This function is used to start a new connection to the specified
 * port on the specied host. It allocates a new connection identifier,
 * sets the connection to the SYN_SENT state and sets the
 * retransmission timer to 0. This will cause a TCP SYN segment to be
 * sent out the next time this connection is periodically processed,
 * which usually is done within 0.5 seconds after the call to
 * uip_connect().
 *
 * \note This function is avaliable only if support for active open
 * has been configured by defining UIP_ACTIVE_OPEN to 1 in uipopt.h.
 * CHANGED THIS TO MAKE THIS FUNCTION AVAILABLE ONLY FOR MQTT SUPPORT
 *
 * \note Since this function requires the port number to be in network
 * byte order, a conversion using HTONS() or htons() is necessary.
 *
 \code
 uip_ipaddr_t ipaddr;

 uip_ipaddr(&ipaddr, 192,168,1,2);
 uip_connect(&ipaddr, HTONS(80));
 \endcode
 *
 * \param ripaddr The IP address of the remote host
 * \param rport 16-bit port number of the remote host
 * \param rport 16-bit port number of the local host
 *
 * \return A pointer to the uIP connection identifier for the new connection,
 * or NULL if no connection could be allocated.
 *
 */
struct uip_conn *uip_connect(uip_ipaddr_t *ripaddr, uint16_t rport, uint16_t lport);


/**
 * Check if a connection has outstanding (i.e., unacknowledged) data.
 * conn - A pointer to the uip_conn structure for the connection.
 *
 */
#define uip_outstanding(conn) ((conn)->len)


/**
 * Send data on the current connection.
 * This function is used to send out a single segment of TCP data. Only
 * applications that have been invoked by uIP for event processing can send
 * data.
 *
 * The amount of data that actually is sent out after a call to this funcion
 * is determined by the maximum amount of data TCP allows. uIP will
 * automatically crop the data so that only the appropriate amount of data is
 * sent. The function uip_mss() can be used to query uIP for the amount of
 * data that actually will be sent.
 *
 * This function does not guarantee that the sent data will arrive at the
 * destination. If the data is lost in the network, the application will be
 * invoked with the uip_rexmit() event being set. The application will then
 * have to resend the data using this function.
 *
 * data - A pointer to the data which is to be sent.
 * len - The maximum amount of data bytes to be sent.
 */
void uip_send(const char *data, int len);


/**
 * The length of any incoming data that is currently avaliable (if avaliable)
 * in the uip_appdata buffer.
 *
 * The test function uip_data() must first be used to check if there is any
 * data available at all.
 */
#define uip_datalen()       uip_len


/**
 * Close the current connection.
 * This function will close the current connection in a nice way.
 */
#define uip_close()         (uip_flags = UIP_CLOSE)


/**
 * Abort the current connection.
 * This function will abort (reset) the current connection, and is usually
 * used when an error has occured that prevents using the uip_close() function.
 */
#define uip_abort()         (uip_flags = UIP_ABORT)


/**
 * Tell the sending host to stop sending data.
 * This function will close our receiver's window so that we stop receiving
 * data for the current connection.
 */
#define uip_stop()          (uip_conn->tcpstateflags |= UIP_STOPPED)


/**
 * Find out if the current connection has been previously stopped with
 * uip_stop().
 */
#define uip_stopped(conn)   ((conn)->tcpstateflags & UIP_STOPPED)


/**
 * Restart the current connection, if is has previously been stopped with
 * uip_stop().
 * This function will open the receiver's window again so that we start
 * receiving data for the current connection.
 */
#define uip_restart()         do { uip_flags |= UIP_NEWDATA; \
                                   uip_conn->tcpstateflags &= ~UIP_STOPPED; \
                              } while(0)


/*---------------------------------------------------------------------------*/
/* uIP tests that can be made to determine in what state the current
 * connection is, and what the application function should do.
 */

/**
 * Is new incoming data available?
 * Will reduce to non-zero if there is new data for the application present at
 * the uip_appdata pointer. The size of the data is avaliable through the
 * uip_len variable.
 */
#define uip_newdata()   (uip_flags & UIP_NEWDATA)


/**
 * Has previously sent data been acknowledged?
 * Will reduce to non-zero if the previously sent data has been acknowledged
 * by the remote host. This means that the application can send new data.
 */
#define uip_acked()   (uip_flags & UIP_ACKDATA)


/**
 * Has the connection just been connected?
 * Reduces to non-zero if the current connection has been connected to a
 * remote host. This will happen both if the connection has been actively
 * opened (with uip_connect()) or passively opened (with * uip_listen()).
 */
#define uip_connected() (uip_flags & UIP_CONNECTED)


/**
 * Has the connection been closed by the other end?
 * Is non-zero if the connection has been closed by the remote host. The
 * application may then do the necessary clean-ups.
 */
#define uip_closed()    (uip_flags & UIP_CLOSE)


/**
 * Has the connection been aborted by the other end?
 * Non-zero if the current connection has been aborted (reset) by the remote
 * host.
 */
#define uip_aborted()    (uip_flags & UIP_ABORT)


/**
 * Has the connection timed out?
 * Non-zero if the current connection has been aborted due to too many
 * retransmissions.
 */
#define uip_timedout()    (uip_flags & UIP_TIMEDOUT)


/**
 * Do we need to retransmit previously data?
 * Reduces to non-zero if the previously sent data has been lost in the
 * network, and the application should retransmit it. The application should
 * send the exact same data as it did the last time, using the uip_send()
 * function.
 */
#define uip_rexmit()     (uip_flags & UIP_REXMIT)


/**
 * Is the connection being polled by uIP?
 * Is non-zero if the reason the application is invoked is that the current
 * connection has been idle for a while and should be polled.
 * The polling event can be used for sending data without having to wait for
 * the remote host to send data.
 */
#define uip_poll()       (uip_flags & UIP_POLL)


/**
 * Get the initial maxium segment size (MSS) of the current connection.
 */
#define uip_initialmss()             (uip_conn->initialmss)


/**
 * Get the current maxium segment size that can be sent on the current
 * connection.
 * The current maxiumum segment size that can be sent on the connection is
 * computed from the receiver's window and the MSS of the connection (which
 * also is available by calling uip_initialmss()).
 */
#define uip_mss()             (uip_conn->mss)


/*---------------------------------------------------------------------------*/
/* uIP convenience and converting functions. */

/**
 * uIP conversion functions
 * These functions can be used for converting between different data formats
 * used by uIP.
 */


/**
 * Construct an IP address from four bytes.
 * This function constructs an IP address of the type that uIP handles
 * internally from four bytes. The function is handy for specifying IP
 * addresses to use with e.g. the uip_connect() function.
 *
 * Example:
 \code
 uip_ipaddr_t ipaddr;
 struct uip_conn *c;
 
 uip_ipaddr(&ipaddr, 192,168,1,2);
 c = uip_connect(&ipaddr, HTONS(80));
 \endcode
 *
 * addr - A pointer to a uip_ipaddr_t variable that will be
 * filled in with the IP address.
 *
 * addr0 - The first octet of the IP address.
 * addr1 - The second octet of the IP address.
 * addr2 - The third octet of the IP address.
 * addr3 - The forth octet of the IP address.
 */
#define uip_ipaddr(addr, addr0,addr1,addr2,addr3) do { \
                     ((uint16_t *)(addr))[0] = (uint16_t)(HTONS(((addr0) << 8) | (addr1))); \
                     ((uint16_t *)(addr))[1] = (uint16_t)(HTONS(((addr2) << 8) | (addr3))); \
                  } while(0)


/**
 * Copy an IP address to another IP address.
 * Copies an IP address from one place to another.
 *
 * Example:
 \code
 uip_ipaddr_t ipaddr1, ipaddr2;

 uip_ipaddr(&ipaddr1, 192,16,1,2);
 uip_ipaddr_copy(&ipaddr2, &ipaddr1);
 \endcode
 *
 * dest - The destination for the copy.
 * src - The source from where to copy.
 */
#define uip_ipaddr_copy(dest, src) do { \
                     ((uint16_t *)dest)[0] = ((uint16_t *)src)[0]; \
                     ((uint16_t *)dest)[1] = ((uint16_t *)src)[1]; \
                  } while(0)


/**
 * Compare two IP addresses
 * Example:
 \code
 uip_ipaddr_t ipaddr1, ipaddr2;

 uip_ipaddr(&ipaddr1, 192,16,1,2);
 if(uip_ipaddr_cmp(&ipaddr2, &ipaddr1)) {
    printf("They are the same");
 }
 \endcode
 *
 * addr1 - The first IP address.
 * addr2 - The second IP address.
 *
 */
#define uip_ipaddr_cmp(addr1, addr2) (((uint16_t *)addr1)[0] == ((uint16_t *)addr2)[0] && \
				      ((uint16_t *)addr1)[1] == ((uint16_t *)addr2)[1])


/**
 * Compare two IP addresses with netmasks
 * Compares two IP addresses with netmasks. The masks are used to mask out the
 * bits that are to be compared.
 *
 * Example:
 \code
 uip_ipaddr_t ipaddr1, ipaddr2, mask;

 uip_ipaddr(&mask, 255,255,255,0);
 uip_ipaddr(&ipaddr1, 192,16,1,2);
 uip_ipaddr(&ipaddr2, 192,16,1,3);
 if(uip_ipaddr_maskcmp(&ipaddr1, &ipaddr2, &mask)) {
    printf("They are the same");
 }
 \endcode
 *
 * addr1 - The first IP address.
 * addr2 - The second IP address.
 * mask - The netmask.
 *
 */
#define uip_ipaddr_maskcmp(addr1, addr2, mask) \
                          (((((uint16_t *)addr1)[0] & ((uint16_t *)mask)[0]) == \
                            (((uint16_t *)addr2)[0] & ((uint16_t *)mask)[0])) && \
                           ((((uint16_t *)addr1)[1] & ((uint16_t *)mask)[1]) == \
                            (((uint16_t *)addr2)[1] & ((uint16_t *)mask)[1])))


/**
 * Mask out the network part of an IP address, given the address and the
 * netmask.
 * Example:
 \code
 uip_ipaddr_t ipaddr1, ipaddr2, netmask;

 uip_ipaddr(&ipaddr1, 192,16,1,2);
 uip_ipaddr(&netmask, 255,255,255,0);
 uip_ipaddr_mask(&ipaddr2, &ipaddr1, &netmask);
 \endcode
 *
 * In the example above, the variable "ipaddr2" will contain the IP
 * address 192.168.1.0.
 *
 * dest - Where the result is to be placed.
 * src - The IP address.
 * mask - The netmask.
 */
#define uip_ipaddr_mask(dest, src, mask) do { \
                     ((uint16_t *)dest)[0] = ((uint16_t *)src)[0] & ((uint16_t *)mask)[0]; \
                     ((uint16_t *)dest)[1] = ((uint16_t *)src)[1] & ((uint16_t *)mask)[1]; \
                  } while(0)


/**
 * Pick the first octet of an IP address.
 * Example:
 \code
 uip_ipaddr_t ipaddr;
 uint8_t octet;

 uip_ipaddr(&ipaddr, 1,2,3,4);
 octet = uip_ipaddr1(&ipaddr);
 \endcode
 *
 * In the example above, the variable "octet" will contain the value 1.
 */
#define uip_ipaddr1(addr) (htons(((uint16_t *)(addr))[0]) >> 8)


/**
 * Pick the second octet of an IP address.
 * Example:
 \code
 uip_ipaddr_t ipaddr;
 uint8_t octet;

 uip_ipaddr(&ipaddr, 1,2,3,4);
 octet = uip_ipaddr2(&ipaddr);
 \endcode
 *
 * In the example above, the variable "octet" will contain the value 2.
 */
#define uip_ipaddr2(addr) (htons(((uint16_t *)(addr))[0]) & 0xff)


/**
 * Pick the third octet of an IP address.
 * Example:
 \code
 uip_ipaddr_t ipaddr;
 uint8_t octet;

 uip_ipaddr(&ipaddr, 1,2,3,4);
 octet = uip_ipaddr3(&ipaddr);
 \endcode
 *
 * In the example above, the variable "octet" will contain the value 3.
 */
#define uip_ipaddr3(addr) (htons(((uint16_t *)(addr))[1]) >> 8)


/**
 * Pick the fourth octet of an IP address.
 * Example:
 \code
 uip_ipaddr_t ipaddr;
 uint8_t octet;

 uip_ipaddr(&ipaddr, 1,2,3,4);
 octet = uip_ipaddr4(&ipaddr);
 \endcode
 *
 * In the example above, the variable "octet" will contain the value 4.
 */
#define uip_ipaddr4(addr) (htons(((uint16_t *)(addr))[1]) & 0xff)


/**
 * Convert 16-bit quantity from host byte order to network byte order.
 * This macro is primarily used for converting constants from host byte order
 * to network byte order. For converting >variables< to network byte order,
 * use the htons() function instead.
 */
#ifndef HTONS
#   if UIP_BYTE_ORDER == UIP_BIG_ENDIAN
#      define HTONS(n) (n)
#   else /* UIP_BYTE_ORDER == UIP_BIG_ENDIAN */
#      define HTONS(n) (uint16_t)((((uint16_t) (n)) << 8) | (((uint16_t) (n)) >> 8))
#   endif /* UIP_BYTE_ORDER == UIP_BIG_ENDIAN */
#else
#error "HTONS already defined!"
#endif /* HTONS */


/**
 * Convert 16-bit quantity from host byte order to network byte order.
 * This function is primarily used for converting variables from host byte
 * order to network byte order. For converting >constants< to network byte
 * order, use the HTONS() macro instead.
 */
#ifndef htons
uint16_t htons(uint16_t val);
#endif /* htons */
#ifndef ntohs
#define ntohs htons
#endif


/**
 * Pointer to the application data in the packet buffer.
 * This pointer points to the application data when the application is called.
 * If the application wishes to send data, the application may use this space
 * to write the data into before calling uip_send().
 */
extern char *uip_appdata;


/*---------------------------------------------------------------------------*/
/**
 * Variables used in uIP device drivers
 * uIP has a few global variables that are used in device drivers for uIP.
 */


/**
 * The length of the packet in the uip_buf buffer.
 * The global variable uip_len holds the length of the packet in the uip_buf
 * buffer.
 *
 * When the network device driver calls the uIP input function, uip_len
 * should be set to the length of the packet in the uip_buf buffer.
 *
 * When sending packets, the device driver should use the contents of the
 * uip_len variable to determine the length of the outgoing packet.
 */
extern uint16_t uip_len;


/**
 * Representation of a uIP TCP connection.
 * The uip_conn structure is used for identifying a connection. All but one
 * field in the structure are to be considered read-only by an application.
 * The only exception is the appstate field whos purpose is to let the
 * application store application-specific state (e.g., file pointers) for the
 * connection. The type of this field is configured in the "uipopt.h" header
 * file.
 */
struct uip_conn {
  uip_ipaddr_t ripaddr;  // The IP address of the remote host.
  uint16_t lport;        // The local TCP port, in network byte order.
  uint16_t rport;        // The local remote TCP port, in network byte order.
  uint8_t rcv_nxt[4];    // The sequence number that we expect to receive next.
  uint8_t snd_nxt[4];    // The sequence number that was last sent by us.
  uint16_t len;          // Length of the data that was previously sent.
  uint16_t mss;          // Current maximum segment size for the connection.
  uint16_t initialmss;   // Initial maximum segment size for the connection.
  uint8_t sa;            // Retransmission time-out calculation state variable.
  uint8_t sv;            // Retransmission time-out calculation state variable.
  uint8_t rto;           // Retransmission time-out.
  uint8_t tcpstateflags; // TCP state and flags.
  uint8_t timer;         // The retransmission timer.
  uint8_t nrtx;          // The number of retransmissions for the last segment sent.

  /** The application state. */
  uip_tcp_appstate_t appstate;
};


/**
 * Pointer to the current TCP connection.
 * The uip_conn pointer can be used to access the current TCP connection.
 */
extern struct uip_conn *uip_conn;
/* The array containing all uIP connections. */
extern struct uip_conn uip_conns[UIP_CONNS];


/**
 * 4-byte array used for the 32-bit sequence number calculations.
 */
extern uint8_t uip_acc32[4];


/**
 * The structure holding the TCP/IP statistics that are gathered if
 * UIP_STATISTICS is set to 1.
 */
struct uip_stats {
  struct {
    uip_stats_t drop;     // Number of dropped packets at the IP layer.
    uip_stats_t recv;     // Number of received packets at the IP layer.
    uip_stats_t sent;     // Number of sent packets at the IP layer.
    uip_stats_t vhlerr;   // Number of packets dropped due to wrong IP version or header length.
    uip_stats_t hblenerr; // Number of packets dropped due to wrong IP length, high byte.
    uip_stats_t lblenerr; // Number of packets dropped due to wrong IP length, low byte.
    uip_stats_t fragerr;  // Number of packets dropped since they were IP fragments.
    uip_stats_t chkerr;   // Number of packets dropped due to IP checksum errors.
    uip_stats_t protoerr; // Number of packets dropped since they were neither ICMP, UDP nor TCP.
  } ip;                   // IP statistics.
  struct {
    uip_stats_t drop;     // Number of dropped ICMP packets.
    uip_stats_t recv;     // Number of received ICMP packets.
    uip_stats_t sent;     // Number of sent ICMP packets.
    uip_stats_t typeerr;  // Number of ICMP packets with a wrong type.
  } icmp;                 // ICMP statistics.
  struct {
    uip_stats_t drop;     // Number of dropped TCP segments.
    uip_stats_t recv;     // Number of recived TCP segments.
    uip_stats_t sent;     // Number of sent TCP segments.
    uip_stats_t chkerr;   // Number of TCP segments with a bad checksum.
    uip_stats_t ackerr;   // Number of TCP segments with a bad ACK number.
    uip_stats_t rst;      // Number of recevied TCP RST (reset) segments.
    uip_stats_t rexmit;   // Number of retransmitted TCP segments.
    uip_stats_t syndrop;  // Number of dropped SYNs due to too few connections avaliable.
    uip_stats_t synrst;   // Number of SYNs for closed ports, triggering a RST.
  } tcp;                  // TCP statistics.
};


/**
 * The uIP TCP/IP statistics.
 * This is the variable in which the uIP TCP/IP statistics are gathered.
 */
extern struct uip_stats uip_stat;


/*---------------------------------------------------------------------------*/
/* All the stuff below this point is internal to uIP and should not be used
 *directly by an application or by a device driver.
 */

/* uip_flags:
 * When the application is called, uip_flags will contain the flags that are
 * defined in this file. Please read below for more infomation.
 */
extern uint8_t uip_flags;

/* The following flags may be set in the global variable uip_flags before
   calling the application callback. The UIP_ACKDATA, UIP_NEWDATA, and
   UIP_CLOSE flags may both be set at the same time, whereas the others are
   mutualy exclusive. Note that these flags should *NOT* be accessed directly,
   but only through the uIP functions/macros.
*/

#define UIP_ACKDATA   1
/* Signifies that the outstanding data was acked and the application should
   send out new data instead of retransmitting the last data. */

#define UIP_NEWDATA   2
/* Flags the fact that the peer has sent us new data. */

#define UIP_REXMIT    4
/* Tells the application to retransmit the data that was last sent. */

#define UIP_POLL      8
/* Used for polling the application, to check if the application has data
   that it wants to send. */

#define UIP_CLOSE     16
/* The remote host has closed the connection, thus the connection has gone
   away. Or the application signals that it wants to close the connection. */

#define UIP_ABORT     32
/* The remote host has aborted the connection, thus the connection has gone
   away. Or the application signals that it wants to abort the connection. */

#define UIP_CONNECTED 64
/* We have got a connection from a remote host and have set up a new
   connection for it, or an active connection has been successfully
   established. */

#define UIP_TIMEDOUT  128
/* The connection has been aborted due to too many retransmissions. */

/* uip_process(flag):
 *
 * The actual uIP function which does all the work.
 */
void uip_process(uint8_t flag);

/* The following flags are passed as an argument to the uip_process() function.
   They are used to distinguish between the two cases where uip_process() is
   called. It can be called either because we have incoming data that should
   be processed, or because the periodic timer has fired. These values are
   never used directly, but only in the macrose defined in this file. */
 
#define UIP_DATA          1
/* Tells uIP that there is incoming data in the uip_buf buffer. The length of
   the data is stored in the global variable uip_len. */

#define UIP_TIMER         2
/* Tells uIP that the periodic timer has fired. */

#define UIP_POLL_REQUEST  3
/* Tells uIP that a connection should be polled. */

/* The TCP states used in the uip_conn->tcpstateflags. */
#define UIP_CLOSED      0
#define UIP_SYN_RCVD    1
#define UIP_SYN_SENT    2
#define UIP_ESTABLISHED 3
#define UIP_FIN_WAIT_1  4
#define UIP_FIN_WAIT_2  5
#define UIP_CLOSING     6
#define UIP_TIME_WAIT   7
#define UIP_LAST_ACK    8
#define UIP_TS_MASK     15
  
#define UIP_STOPPED      16

/* The TCP and IP headers. */
struct uip_tcpip_hdr {
  /* IPv4 header. */
  uint8_t vhl,
    tos,
    len[2],
    ipid[2],
    ipoffset[2],
    ttl,
    proto;
  uint16_t ipchksum;
  uint16_t srcipaddr[2],
    destipaddr[2];
  
  /* TCP header. */
  uint16_t srcport,
    destport;
  uint8_t seqno[4],
    ackno[4],
    tcpoffset,
    flags,
    wnd[2];
  uint16_t tcpchksum;
  uint8_t urgp[2];
  uint8_t optdata[4];
};

/* The ICMP and IP headers. */
struct uip_icmpip_hdr {
  /* IPv4 header. */
  uint8_t vhl,
    tos,
    len[2],
    ipid[2],
    ipoffset[2],
    ttl,
    proto;
  uint16_t ipchksum;
  uint16_t srcipaddr[2],
    destipaddr[2];
  
  /* ICMP (echo) header. */
  uint8_t type, icode;
  uint16_t icmpchksum;
  uint16_t id, seqno;
};


/**
 * The buffer size available for user data in the uip_buf buffer.
 * This macro holds the available size for user data in the uip_buf buffer.
 * The macro is intended to be used for checking the bounds of available user
 * data.
 * Example:
 \code
 snprintf(uip_appdata, UIP_APPDATA_SIZE, "%u\n", i);
 \endcode
 */
#define UIP_APPDATA_SIZE (UIP_BUFSIZE - UIP_LLH_LEN - UIP_TCPIP_HLEN)


#define UIP_PROTO_ICMP  1
#define UIP_PROTO_TCP   6
#define UIP_PROTO_UDP   17
#define UIP_PROTO_ICMP6 58

/* Header sizes. */
#define UIP_IPH_LEN    20  /* Size of IP header */
#define UIP_TCPH_LEN   20  /* Size of TCP header */
#define UIP_IPTCPH_LEN (UIP_TCPH_LEN + UIP_IPH_LEN)  /* Size of IP + TCP header */
#define UIP_TCPIP_HLEN UIP_IPTCPH_LEN


extern uip_ipaddr_t uip_hostaddr, uip_netmask, uip_draddr;
extern uip_ipaddr_t uip_mqttserveraddr;


/**
 * Representation of a 48-bit Ethernet address.
 */
struct uip_eth_addr {
  uint8_t addr[6];
};

/**
 * Calculate the Internet checksum over a buffer.
 * The Internet checksum is the one's complement of the one's complement sum
 * of all 16-bit words in the buffer.
 * See RFC1071.
 * buf - A pointer to the buffer over which the checksum is to be computed.
 * len - The length of the buffer over which the checksum is to be computed.
 * return - The Internet checksum of the buffer.
 */
uint16_t uip_chksum(uint16_t *buf, uint16_t len);

/**
 * Calculate the IP header checksum of the packet header in uip_buf.
 * The IP header checksum is the Internet checksum of the 20 bytes of the IP
 * header.
 * return - The IP header checksum of the IP header in the uip_buf buffer.
 */
uint16_t uip_ipchksum(void);

/**
 * Calculate the TCP checksum of the packet in uip_buf and uip_appdata.
 * The TCP checksum is the Internet checksum of data contents of the TCP
 * segment, and a pseudo-header as defined in RFC793.
 * return - The TCP checksum of the TCP segment in uip_buf and pointed to by
 * uip_appdata.
 */
uint16_t uip_tcpchksum(void);


#endif /* __UIP_H__ */
