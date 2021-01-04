/**
 * The uIP TCP/IP stack
 *
 * uIP is an implementation of the TCP/IP protocol stack intended for
 * small 8-bit and 16-bit microcontrollers.
 *
 * uIP provides the necessary protocols for Internet communication,
 * with a very small code footprint and RAM requirements - the uIP
 * code size is on the order of a few kilobytes and RAM usage is on
 * the order of a few hundred bytes.
 */

/**
 * \file
 * The uIP TCP/IP stack code.
 * \author Adam Dunkels <adam@dunkels.com>
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
 * $Id: uip.c,v 1.65 2006/06/11 21:46:39 adam Exp $
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


/*
 * uIP is a small implementation of the IP, UDP and TCP protocols (as
 * well as some basic ICMP stuff). The implementation couples the IP,
 * UDP, TCP and the application layers very tightly. To keep the size
 * of the compiled code down, this code frequently uses the goto
 * statement. While it would be possible to break the uip_process()
 * function into many smaller functions, this would increase the code
 * size because of the overhead of parameter passing and the fact that
 * the optimier would not be as efficient.
 *
 * The principle is that we have a small buffer, called the uip_buf,
 * in which the device driver puts an incoming packet. The TCP/IP
 * stack parses the headers in the packet, and calls the
 * application. If the remote host has sent data to the application,
 * this data is present in the uip_buf and the application reads the
 * data from there. It is up to the application to put this data into
 * a byte stream if needed. The application will not be fed with data
 * that is out of sequence.
 *
 * If the application wishes to send data to the peer, it should put
 * its data into the uip_buf. The uip_appdata pointer points to the
 * first available byte. The TCP/IP stack will calculate the
 * checksums, and fill in the necessary header fields and finally send
 * the packet back to the peer.
 */
 

#include "uip.h"
#include "uipopt.h"
#include "uip_arch.h"
#include "main.h"

#include <string.h>

/*---------------------------------------------------------------------------*/
/* Variable definitions. */

#if DEBUG_SUPPORT != 0
// Variables used to store debug information
extern uint8_t *pBuffer2;
extern uint8_t debug[NUM_DEBUG_BYTES];
#endif // DEBUG_SUPPORT != 0


/* The IP address of this host */
uip_ipaddr_t uip_hostaddr;
/* The IP address of the default router (aka gateway) */
uip_ipaddr_t uip_draddr;
/* The Netmask */
uip_ipaddr_t uip_netmask;
/* The IP address of the MQTT Server. */
uip_ipaddr_t uip_mqttserveraddr;


// This structure defines the MAC (aka ethaddr) in the struct format the ARP
// code wants.
// Note: Original was a const struct, but I want to modify the uip_ethaddr
// values during runtime. The main.c loop updates the value in this structure
// if a changes is made to the MAC.
struct uip_eth_addr uip_ethaddr = {0x01,   // MAC MSB
				   0x02,
				   0x03,
				   0x04,
				   0x05,
				   0x06};  // MAC LSB
				   

uint8_t uip_buf[UIP_BUFSIZE + 2];     /* The packet buffer that contains
                                         incoming packets. */

char *uip_appdata;                    /* The uip_appdata pointer points to
                                         application data. */
 
char *uip_sappdata;                   /* The uip_appdata pointer points to the
                                         application data which is to be sent. */

uint16_t uip_len, uip_slen;           /* The uip_len is 16 bits. */

uint8_t uip_flags;                    /* The uip_flags variable is used for
                                         communication between the TCP/IP
					 stack and the application program. */
				      
struct uip_conn *uip_conn;            /* uip_conn always points to the current
                                         connection. */

struct uip_conn uip_conns[UIP_CONNS]; /* The uip_conns array holds all TCP
                                         connections. */

uint16_t uip_listenports[UIP_LISTENPORTS]; /* The uip_listenports list all
                                              currently listening ports. */

static uint16_t ipid;                 /* Ths ipid variable is an increasing
                                         number that is used for the IP ID
					 field. */

void uip_setipid(uint16_t id)
{
  ipid = id;
}

static uint8_t iss[4];                /* The iss variable is used for the TCP
                                         initial sequence number. */

/* Temporary variables. */
uint8_t uip_acc32[4];
static uint8_t c, opt;
static uint16_t tmp16;

/* Structures and definitions. */
#define TCP_FIN 0x01
#define TCP_SYN 0x02
#define TCP_RST 0x04
#define TCP_PSH 0x08
#define TCP_ACK 0x10
#define TCP_URG 0x20
#define TCP_CTL 0x3f

#define TCP_OPT_END     0   /* End of TCP options list */
#define TCP_OPT_NOOP    1   /* "No-operation" TCP option */
#define TCP_OPT_MSS     2   /* Maximum segment size TCP option */

#define TCP_OPT_MSS_LEN 4   /* Length of TCP MSS option. */

#define ICMP_ECHO_REPLY 0
#define ICMP_ECHO       8

#define ICMP6_ECHO_REPLY             129
#define ICMP6_ECHO                   128
#define ICMP6_NEIGHBOR_SOLICITATION  135
#define ICMP6_NEIGHBOR_ADVERTISEMENT 136

#define ICMP6_FLAG_S (1 << 6)

#define ICMP6_OPTION_SOURCE_LINK_ADDRESS 1
#define ICMP6_OPTION_TARGET_LINK_ADDRESS 2

/* Macros. */
#define BUF ((struct uip_tcpip_hdr *)&uip_buf[UIP_LLH_LEN])
#define FBUF ((struct uip_tcpip_hdr *)&uip_reassbuf[0])
#define ICMPBUF ((struct uip_icmpip_hdr *)&uip_buf[UIP_LLH_LEN])

#if UIP_STATISTICS == 1
struct uip_stats uip_stat;
#define UIP_STAT(s) s
#else
#define UIP_STAT(s)
#endif // UIP_STATISTICS == 1

#if ! UIP_ARCH_ADD32
void uip_add32(uint8_t *op32, uint16_t op16)
{
  uip_acc32[3] = (uint8_t)(op32[3] + (op16 & 0xff));
  uip_acc32[2] = (uint8_t)(op32[2] + (op16 >> 8));
  uip_acc32[1] = op32[1];
  uip_acc32[0] = op32[0];

  if (uip_acc32[2] < (op16 >> 8)) {
    ++uip_acc32[1];
    if (uip_acc32[1] == 0) {
      ++uip_acc32[0];
    }
  }

  if (uip_acc32[3] < (op16 & 0xff)) {
    ++uip_acc32[2];
    if (uip_acc32[2] == 0) {
      ++uip_acc32[1];
      if (uip_acc32[1] == 0) {
        ++uip_acc32[0];
      }
    }
  }
}

#endif /* UIP_ARCH_ADD32 */


#if ! UIP_ARCH_CHKSUM
/*---------------------------------------------------------------------------*/
static uint16_t chksum(uint16_t sum, const uint8_t *data, uint16_t len)
{
  uint16_t t;
  const uint8_t *dataptr;
  const uint8_t *last_byte;

  dataptr = data;
  last_byte = data + len - 1;

  while (dataptr < last_byte) { /* At least two more bytes */
    t = (dataptr[0] << 8) + dataptr[1];
    sum += t;
    if (sum < t) sum++; /* carry */
    dataptr += 2;
  }

  if (dataptr == last_byte) {
    t = (dataptr[0] << 8) + 0;
    sum += t;
    if (sum < t) sum++; /* carry */
  }
  /* Return sum in host byte order. */
  return sum;
}


/*---------------------------------------------------------------------------*/
uint16_t uip_chksum(uint16_t *data, uint16_t len)
{
  return htons(chksum(0, (uint8_t *)data, len));
}


/*---------------------------------------------------------------------------*/
#ifndef UIP_ARCH_IPCHKSUM
uint16_t uip_ipchksum(void)
{
  uint16_t sum;

  sum = chksum(0, &uip_buf[UIP_LLH_LEN], UIP_IPH_LEN);
  // DEBUG_PRINTF("uip_ipchksum: sum 0x%04x\n", sum);
  return (sum == 0) ? 0xffff : htons(sum);
}
#endif


/*---------------------------------------------------------------------------*/
static uint16_t upper_layer_chksum(uint8_t proto)
{
  uint16_t upper_layer_len;
  uint16_t sum;

  upper_layer_len = (((uint16_t)(BUF->len[0]) << 8) + BUF->len[1]) - UIP_IPH_LEN;

  /* First sum pseudoheader. */

  /* IP protocol and length fields. This addition cannot carry. */
  sum = upper_layer_len + proto;
  /* Sum IP source and destination addresses. */
  sum = chksum(sum, (uint8_t *)&BUF->srcipaddr[0], 2 * sizeof(uip_ipaddr_t));

  /* Sum TCP header and data. */
  sum = chksum(sum, &uip_buf[UIP_IPH_LEN + UIP_LLH_LEN], upper_layer_len);

  return (sum == 0) ? 0xffff : htons(sum);
}


/*---------------------------------------------------------------------------*/
uint16_t uip_tcpchksum(void)
{
  return upper_layer_chksum(UIP_PROTO_TCP);
}
#endif /* UIP_ARCH_CHKSUM */


/*---------------------------------------------------------------------------*/
void uip_init(void)
{
  for (c = 0; c < UIP_LISTENPORTS; ++c) uip_listenports[c] = 0;
  for (c = 0; c < UIP_CONNS; ++c) uip_conns[c].tcpstateflags = UIP_CLOSED;
  /* IPv4 initialization. */

#if UIP_STATISTICS == 1
  // Initialize statistics
  uip_init_stats();
#endif // UIP_STATISTICS == 1
}


/*---------------------------------------------------------------------------*/
// uip_connect added to allow the MQTT client to make TCP connection requests
// to a remote host (aka the MQTT Broker). In the original UIP code this was
// included if UIP_ACTIVE_OPEN == 1. In this application uip_connect is only
// used when including MQTT functionality.

struct uip_conn *
uip_connect(uip_ipaddr_t *ripaddr, uint16_t rport, uint16_t lport)
{
  register struct uip_conn *conn, *cconn;
  
  // Find an empty connection table entry to use
  conn = 0;
  for(c = 0; c < UIP_CONNS; ++c) {
    cconn = &uip_conns[c];
    if(cconn->tcpstateflags == UIP_CLOSED) {
      conn = cconn;
      break;
    }
    if(cconn->tcpstateflags == UIP_TIME_WAIT) {
      if(conn == 0 ||
	 cconn->timer > conn->timer) {
	conn = cconn;
      }
    }
  }

  if(conn == 0) return 0;
  
  conn->tcpstateflags = UIP_SYN_SENT;

  conn->snd_nxt[0] = iss[0];
  conn->snd_nxt[1] = iss[1];
  conn->snd_nxt[2] = iss[2];
  conn->snd_nxt[3] = iss[3];

  conn->initialmss = conn->mss = UIP_TCP_MSS;
  
  conn->len = 1;   /* TCP length of the SYN is one. */
  conn->nrtx = 0;
  conn->timer = 1; /* Send the SYN next time around. */
  conn->rto = UIP_RTO;
  conn->sa = 0;
  conn->sv = 16;   /* Initial value of the RTT variance. */
  conn->lport = lport;
  conn->rport = rport;
  uip_ipaddr_copy(&conn->ripaddr, ripaddr);
  return conn;
}


/*---------------------------------------------------------------------------*/
void uip_init_stats(void)
{
#if UIP_STATISTICS == 1
  // Initialize statistics
  uip_stat.ip.drop = 0;
  uip_stat.ip.recv = 0;
  uip_stat.ip.sent = 0;
  uip_stat.ip.vhlerr = 0;
  uip_stat.ip.hblenerr = 0;
  uip_stat.ip.lblenerr = 0;
  uip_stat.ip.fragerr = 0;
  uip_stat.ip.chkerr = 0;
  uip_stat.ip.protoerr = 0;
  uip_stat.icmp.drop = 0;
  uip_stat.icmp.recv = 0;
  uip_stat.icmp.sent = 0;
  uip_stat.icmp.typeerr = 0;
  uip_stat.tcp.drop = 0;
  uip_stat.tcp.recv = 0;
  uip_stat.tcp.sent = 0;
  uip_stat.tcp.chkerr = 0;
  uip_stat.tcp.ackerr = 0;
  uip_stat.tcp.rst = 0;
  uip_stat.tcp.rexmit = 0;
  uip_stat.tcp.syndrop = 0;
  uip_stat.tcp.synrst = 0;
#endif // UIP_STATISTICS == 1
}


/*---------------------------------------------------------------------------*/
void uip_unlisten(uint16_t port)
{
  for (c = 0; c < UIP_LISTENPORTS; ++c) {
    if (uip_listenports[c] == port) {
      uip_listenports[c] = 0;
      return;
    }
  }
}


/*---------------------------------------------------------------------------*/
void uip_listen(uint16_t port)
{
  for (c = 0; c < UIP_LISTENPORTS; ++c) {
    if (uip_listenports[c] == 0) {
      uip_listenports[c] = port;
      return;
    }
  }
}


/*---------------------------------------------------------------------------*/
static void uip_add_rcv_nxt(uint16_t n)
{
  uip_add32(uip_conn->rcv_nxt, n);
  uip_conn->rcv_nxt[0] = uip_acc32[0];
  uip_conn->rcv_nxt[1] = uip_acc32[1];
  uip_conn->rcv_nxt[2] = uip_acc32[2];
  uip_conn->rcv_nxt[3] = uip_acc32[3];
}


/*---------------------------------------------------------------------------*/
void uip_process(uint8_t flag)
{
  register struct uip_conn *uip_connr = uip_conn;

  // uip_appdata (and uip_sappdata) point at the start of application data
  // which follows the IP/TCP headers. IP header length is stored in
  // UIP_IPTCPH_LEN and TCP header length is stored in UIP_LLH_LEN (aka the
  // Link Level Header). When a UIP_APPCALL is made the application will use
  // the uip_appdata value as the pointer to the start of the application data
  // in the data buffer, and it will use the uip_len value as the length of
  // that application data.
  //
  // Note: When a UIP_APPCALL is made to receive data the uip_len value will
  // be set to the TCP data length. When a UIP_APPCALL is made to transmit
  // data the appcall will set the uip_len value.
  
  uip_sappdata = uip_appdata = &uip_buf[UIP_IPTCPH_LEN + UIP_LLH_LEN];

  // Check if we were invoked because of a poll request for a particular
  // connection. A UIP_POLL_REQUEST will occur without any receive data
  // present, so uip_len should be zero when it occurs.
  if (flag == UIP_POLL_REQUEST) {
    if ((uip_connr->tcpstateflags & UIP_TS_MASK) == UIP_ESTABLISHED && !uip_outstanding(uip_connr)) {
      uip_flags = UIP_POLL;
      UIP_APPCALL(); // Check for any data to be sent
      goto appsend;
    }
    goto drop;
  }
  
  // Check if we were invoked because of the perodic timer firing.  A
  // UIP_TIMER will occur without any receive data present, so uip_len
  // should be zero when it occurs.
  else if (flag == UIP_TIMER) {
    // Increase the initial sequence number.
    if (++iss[3] == 0) {
      if (++iss[2] == 0) {
        if (++iss[1] == 0) {
          ++iss[0];
        }
      }
    }
    
    // Reset the length variables.
    uip_len = 0;
    uip_slen = 0;

    // Check if the connection is in a state in which we simply wait for the
    // connection to time out. If so, we increase the connection's timer and
    // remove the connection if it times out.
    if (uip_connr->tcpstateflags == UIP_TIME_WAIT || uip_connr->tcpstateflags == UIP_FIN_WAIT_2) {
      ++(uip_connr->timer);
      if (uip_connr->timer == UIP_TIME_WAIT_TIMEOUT) {
        uip_connr->tcpstateflags = UIP_CLOSED;
      }
    }
    else if (uip_connr->tcpstateflags != UIP_CLOSED) {
      // If the connection has outstanding data, we increase the connection's
      // timer and see if it has reached the RTO value in which case we
      // retransmit.
      if (uip_outstanding(uip_connr)) {
        if (uip_connr->timer-- == 0) {
          if (uip_connr->nrtx == UIP_MAXRTX
	    || ((uip_connr->tcpstateflags == UIP_SYN_SENT
            || uip_connr->tcpstateflags == UIP_SYN_RCVD)
            && uip_connr->nrtx == UIP_MAXSYNRTX)) {
            uip_connr->tcpstateflags = UIP_CLOSED;
            // We call UIP_APPCALL() with uip_flags set to UIP_TIMEDOUT to
	    // inform the application that the connection has timed out.
            uip_flags = UIP_TIMEDOUT;
            UIP_APPCALL(); // Timeout call. uip_len was cleared above.

            // We also send a reset packet to the remote host.
            BUF->flags = TCP_RST | TCP_ACK;
            goto tcp_send_nodata;
          }

          // Exponential backoff.
	  if (uip_connr->nrtx > 4) uip_connr->nrtx = 4;
	  uip_connr->timer = (uint8_t)(UIP_RTO << uip_connr->nrtx);
	  ++(uip_connr->nrtx);

          // Ok, so we need to retransmit. We do this differently depending on
	  // which state we are in.
	  // In ESTABLISHED, we call upon the application so that it may
	  // prepare the data for the retransmit.
	  // In SYN_RCVD, we resend the SYNACK that we sent earlier.
	  // In LAST_ACK we have to retransmit our FINACK.
          UIP_STAT(++uip_stat.tcp.rexmit);
          switch (uip_connr->tcpstateflags & UIP_TS_MASK) {
            case UIP_SYN_RCVD:
              // In the SYN_RCVD state, we should retransmit our SYNACK.
              goto tcp_send_synack;

	    case UIP_SYN_SENT:
	      // In the SYN_SENT state, we retransmit the SYN. Required for
	      // MQTT.
	      BUF->flags = 0;
	      goto tcp_send_syn;

            case UIP_ESTABLISHED:
              // In the ESTABLISHED state, we call upon the application to do
	      // the actual retransmit after which we jump into the code for
	      // sending out the packet (the apprexmit label).
              uip_flags = UIP_REXMIT;
              UIP_APPCALL(); // Call to get old data for retransmit.  uip_len
	                     // was cleared above.
              goto apprexmit;

            case UIP_FIN_WAIT_1:
            case UIP_CLOSING:
            case UIP_LAST_ACK:
              // In all these states we should retransmit a FINACK.
              goto tcp_send_finack;

          }
        }
      }
      else if ((uip_connr->tcpstateflags & UIP_TS_MASK) == UIP_ESTABLISHED) {
        // If there was no need for a retransmission, we poll the application
	// for new data.
        uip_flags = UIP_POLL;
        UIP_APPCALL(); // Check for new data to transmit. uip_len was cleared
	               // above.
        goto appsend;
      }
    }
    goto drop;
  }


  // ----------------------------------------------------------------------- //
  // This is where the input processing starts. We fall through to this point
  // if the call was uip_process(UIP_DATA)
  UIP_STAT(++uip_stat.ip.recv);
  
  // Start of IP input header processing code.
  // Check validity of the IP header.
  if (BUF->vhl != 0x45) { // IP version and header length.
    UIP_STAT(++uip_stat.ip.drop);
    UIP_STAT(++uip_stat.ip.vhlerr);
    goto drop;
  }
  
  // Check the size of the packet. If the size reported to us in uip_len is
  // smaller than the size reported in the IP header we assume that the packet
  // has been corrupted in transit. If the size of uip_len is larger than the
  // size reported in the IP packet header the packet has been padded and we
  // set uip_len to the correct value.
  // Note: We are only IPv4, and in IPv4 padding can only occur in the options
  // field.
  if ((BUF->len[0] << 8) + BUF->len[1] <= uip_len) {
    uip_len = (BUF->len[0] << 8) + BUF->len[1];
  }
  else goto drop;

  // Check the fragment flag.
  if ((BUF->ipoffset[0] & 0x3f) != 0 || BUF->ipoffset[1] != 0) {
    UIP_STAT(++uip_stat.ip.drop);
    UIP_STAT(++uip_stat.ip.fragerr);
    goto drop;
  }

  // If the packet is not destined for our IP address drop it.
  // What typically gets dropped here is an IP Broadcast packet (IP
  // address FF:FF:FF:FF)
  if (!uip_ipaddr_cmp(BUF->destipaddr, uip_hostaddr)) {
    UIP_STAT(++uip_stat.ip.drop);
    goto drop;
  }

  if (uip_ipchksum() != 0xffff) { /* Compute and check the IP header checksum. */
    UIP_STAT(++uip_stat.ip.drop);
    UIP_STAT(++uip_stat.ip.chkerr);
    goto drop;
  }

  if (BUF->proto == UIP_PROTO_TCP) {
    // Check for TCP packet. If so, proceed with TCP input processing.
    goto tcp_input;
  }


  // ICMPv4 processing code follows.
  if (BUF->proto != UIP_PROTO_ICMP) { // We only allow ICMP packets from here.
    UIP_STAT(++uip_stat.ip.drop);
    UIP_STAT(++uip_stat.ip.protoerr);
    goto drop;
  }

  UIP_STAT(++uip_stat.icmp.recv);

  // ICMP echo (i.e., ping) processing. This is simple, we only change the
  // ICMP type from ECHO to ECHO_REPLY and adjust the ICMP checksum before we
  // return the packet.
  if (ICMPBUF->type != ICMP_ECHO) {
    UIP_STAT(++uip_stat.icmp.drop);
    UIP_STAT(++uip_stat.icmp.typeerr);
    goto drop;
  }

  ICMPBUF->type = ICMP_ECHO_REPLY;

  if (ICMPBUF->icmpchksum >= HTONS(0xffff - (ICMP_ECHO << 8))) {
    ICMPBUF->icmpchksum += HTONS(ICMP_ECHO << 8) + 1;
  }
  else {
    ICMPBUF->icmpchksum += HTONS(ICMP_ECHO << 8);
  }

  // Swap IP addresses.
  uip_ipaddr_copy(BUF->destipaddr, BUF->srcipaddr);
  uip_ipaddr_copy(BUF->srcipaddr, uip_hostaddr);

  UIP_STAT(++uip_stat.icmp.sent);
  goto send;

  // End of IPv4 input header processing code.


  // ----------------------------------------------------------------------- //
  // TCP input processing.
  tcp_input:

  UIP_STAT(++uip_stat.tcp.recv);

  // Start of TCP input header processing code.
  if (uip_tcpchksum() != 0xffff) { /* Compute and check the TCP checksum. */
    UIP_STAT(++uip_stat.tcp.drop);
    UIP_STAT(++uip_stat.tcp.chkerr);
    goto drop;
  }

  // Demultiplex this segment.
  // First check any active connections.
  for (uip_connr = &uip_conns[0]; uip_connr <= &uip_conns[UIP_CONNS - 1]; ++uip_connr) {
    if (uip_connr->tcpstateflags != UIP_CLOSED
      && BUF->destport == uip_connr->lport
      && BUF->srcport == uip_connr->rport
      && uip_ipaddr_cmp(BUF->srcipaddr, uip_connr->ripaddr)) {
      goto found;
    }
  }

  // If we didn't find an active connection that expected the packet either
  // this packet is an old duplicate, or this is a SYN packet destined for a
  // connection in LISTEN. If the SYN flag isn't set it is an old packet and
  // we send a RST.
  if ((BUF->flags & TCP_CTL) != TCP_SYN) {
    goto reset;
  }

  tmp16 = BUF->destport;
  // Next, check listening connections.
  for (c = 0; c < UIP_LISTENPORTS; ++c) {
    if (tmp16 == uip_listenports[c]) goto found_listen;
  }

  // No matching connection found, so we send a RST packet.
  UIP_STAT(++uip_stat.tcp.synrst);
  
  


  reset:
  // We do not send resets in response to resets.
  if (BUF->flags & TCP_RST) goto drop;

  UIP_STAT(++uip_stat.tcp.rst);
  
  BUF->flags = TCP_RST | TCP_ACK;
  uip_len = UIP_IPTCPH_LEN;
  BUF->tcpoffset = 5 << 4;

  // Flip the seqno and ackno fields in the TCP header.
  c = BUF->seqno[3];
  BUF->seqno[3] = BUF->ackno[3];
  BUF->ackno[3] = c;

  c = BUF->seqno[2];
  BUF->seqno[2] = BUF->ackno[2];
  BUF->ackno[2] = c;

  c = BUF->seqno[1];
  BUF->seqno[1] = BUF->ackno[1];
  BUF->ackno[1] = c;

  c = BUF->seqno[0];
  BUF->seqno[0] = BUF->ackno[0];
  BUF->ackno[0] = c;

  // We also have to increase the sequence number we are acknowledging. If the
  // least significant byte overflowed we need to propagate the carry to the
  // other bytes as well.
  if (++BUF->ackno[3] == 0) {
    if (++BUF->ackno[2] == 0) {
      if (++BUF->ackno[1] == 0) {
        ++BUF->ackno[0];
      }
    }
  }

  // Swap port numbers.
  tmp16 = BUF->srcport;
  BUF->srcport = BUF->destport;
  BUF->destport = tmp16;

  // Swap IP addresses.
  uip_ipaddr_copy(BUF->destipaddr, BUF->srcipaddr);
  uip_ipaddr_copy(BUF->srcipaddr, uip_hostaddr);

  // And send out the RST packet!
  goto tcp_send_noconn;




  found_listen:
  // found_listen will be jumped to if we matched the incoming packet with a
  // connection in LISTEN. In that case we should create a new connection and
  // send a SYNACK in return.
  // First we check if there are any connections avaliable. Unused connections
  // are kept in the same table as used connections, but unused ones have the
  // tcpstate set to CLOSED. Also, connections in TIME_WAIT are kept track of
  // and we'll use the oldest one if no CLOSED connections are found. Thanks
  // to Eddie C. Dost for a very nice algorithm for the TIME_WAIT search.
  uip_connr = 0;
  for (c = 0; c < UIP_CONNS; ++c) {
    if (uip_conns[c].tcpstateflags == UIP_CLOSED) {
      uip_connr = &uip_conns[c];
      break;
    }
    if (uip_conns[c].tcpstateflags == UIP_TIME_WAIT) {
      if (uip_connr == 0 || uip_conns[c].timer > uip_connr->timer) {
        uip_connr = &uip_conns[c];
      }
    }
  }

  if (uip_connr == 0) {
    // All connections are used already, we drop packet and hope that the
    // remote end will retransmit the packet at a time when we have more spare
    // connections.
    UIP_STAT(++uip_stat.tcp.syndrop);
    goto drop;
  }
  uip_conn = uip_connr;

  // Fill in the necessary fields for the new connection.
  uip_connr->rto = uip_connr->timer = UIP_RTO;
  uip_connr->sa = 0;
  uip_connr->sv = 4;
  uip_connr->nrtx = 0;
  uip_connr->lport = BUF->destport;
  uip_connr->rport = BUF->srcport;
  uip_ipaddr_copy(uip_connr->ripaddr, BUF->srcipaddr);
  uip_connr->tcpstateflags = UIP_SYN_RCVD;

  uip_connr->snd_nxt[0] = iss[0];
  uip_connr->snd_nxt[1] = iss[1];
  uip_connr->snd_nxt[2] = iss[2];
  uip_connr->snd_nxt[3] = iss[3];
  uip_connr->len = 1;

  // rcv_nxt should be the seqno from the incoming packet + 1.
  uip_connr->rcv_nxt[3] = BUF->seqno[3];
  uip_connr->rcv_nxt[2] = BUF->seqno[2];
  uip_connr->rcv_nxt[1] = BUF->seqno[1];
  uip_connr->rcv_nxt[0] = BUF->seqno[0];
  uip_add_rcv_nxt(1);
  
  // Parse the TCP MSS option, if present.
  if ((BUF->tcpoffset & 0xf0) > 0x50) {
    for (c = 0; c < ((BUF->tcpoffset >> 4) - 5) << 2;) {
      opt = uip_buf[UIP_TCPIP_HLEN + UIP_LLH_LEN + c];
      if (opt == TCP_OPT_END) {
        // End of options.
        break;
      }
      else if (opt == TCP_OPT_NOOP) {
        ++c;
        // NOP option.
      }
      else if (opt == TCP_OPT_MSS
        && uip_buf[UIP_TCPIP_HLEN + UIP_LLH_LEN + 1 + c] == TCP_OPT_MSS_LEN) {
        // An MSS option with the right option length.
        tmp16 = ((uint16_t)uip_buf[UIP_TCPIP_HLEN + UIP_LLH_LEN + 2 + c] << 8)
	        | (uint16_t)uip_buf[UIP_IPTCPH_LEN + UIP_LLH_LEN + 3 + c];
        uip_connr->initialmss = uip_connr->mss = tmp16 > UIP_TCP_MSS ? UIP_TCP_MSS : tmp16;

        // And we are done processing options.
        break;
      }
      else {
        // All other options have a length field, so that we easily can skip
	// past them.
        if (uip_buf[UIP_TCPIP_HLEN + UIP_LLH_LEN + 1 + c] == 0) {
          // If the length field is zero, the options are malformed and we
	  // don't process them further.
          break;
        }
        c += uip_buf[UIP_TCPIP_HLEN + UIP_LLH_LEN + 1 + c];
      }
    }
  }

  
  // Our response will be a SYNACK. Required for MQTT.
  tcp_send_synack:
  BUF->flags = TCP_ACK;
  
  tcp_send_syn:
  BUF->flags |= TCP_SYN;
  
//  tcp_send_synack:
//  BUF->flags = TCP_SYN | TCP_ACK;


  // We send out the TCP Maximum Segment Size option with our SYNACK.
  BUF->optdata[0] = TCP_OPT_MSS;
  BUF->optdata[1] = TCP_OPT_MSS_LEN;
  BUF->optdata[2] = (UIP_TCP_MSS) / 256;
  BUF->optdata[3] = (UIP_TCP_MSS) & 255;
  uip_len = UIP_IPTCPH_LEN + TCP_OPT_MSS_LEN;
  BUF->tcpoffset = ((UIP_TCPH_LEN + TCP_OPT_MSS_LEN) / 4) << 4;
  goto tcp_send;




  found:

  // found will be jumped to if we found an active connection.
  uip_conn = uip_connr;
  uip_flags = 0;
  // We do a very naive form of TCP reset processing; we just accept any RST
  // and kill our connection. We should in fact check if the sequence number
  // of this reset is wihtin our advertised window before we accept the reset.
  if (BUF->flags & TCP_RST) {
    uip_connr->tcpstateflags = UIP_CLOSED;
    uip_flags = UIP_ABORT;
    // XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
    // We are doing a reset here. Why would we do a UIP_APPCALL? The
    // apps do not check for UIP_CLOSED or UIP_ABORT.
    // If this call is left here it seems we should force uip_len = 0
    // XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
    UIP_APPCALL(); // ????
    goto drop;
  }
  
  // Calculate the length of the data, if the application has sent any data
  // to us.
  //
  // The BUF->tcpoffset value comes from the TCP header and in a normal TCP
  // receive case the "c =" equation below will evaluate to a value of 20.
  // This is also the known TCP header size per the "#define UIP_TCPH_LEN 20"
  // in uip.h. The equation compensates for the cases where option bytes are
  // added to the TCP header, the most common addition being for communication
  // of the MSS value. In any event, uip_len is reduced to just the length
  // of the application data in the below.
  //
  c = (uint8_t)((BUF->tcpoffset >> 4) << 2);
  // uip_len will contain the length of the actual TCP data. This is
  // calculated by subtracting the length of the TCP header (in c) and the
  // length of the IP header (20 bytes).
  uip_len = uip_len - c - UIP_IPH_LEN;
  
  // First, check if the sequence number of the incoming packet is what we're
  // expecting next. If not, we send out an ACK with the correct numbers in.
  if (!(((uip_connr->tcpstateflags & UIP_TS_MASK) == UIP_SYN_SENT)
    && ((BUF->flags & TCP_CTL) == (TCP_SYN | TCP_ACK)))) {

    if ((uip_len > 0 || ((BUF->flags & (TCP_SYN | TCP_FIN)) != 0))
      && (BUF->seqno[0] != uip_connr->rcv_nxt[0]
      || BUF->seqno[1] != uip_connr->rcv_nxt[1]
      || BUF->seqno[2] != uip_connr->rcv_nxt[2]
      || BUF->seqno[3] != uip_connr->rcv_nxt[3])) {
      goto tcp_send_ack;
    }
  }

  // Next, check if the incoming segment acknowledges any outstanding data. If
  // so, we update the sequence number, reset the length of the outstanding
  // data, calculate RTT estimations, and reset the retransmission timer.
  if ((BUF->flags & TCP_ACK) && uip_outstanding(uip_connr)) {
    uip_add32(uip_connr->snd_nxt, uip_connr->len);
    if (BUF->ackno[0] == uip_acc32[0]
      && BUF->ackno[1] == uip_acc32[1]
      && BUF->ackno[2] == uip_acc32[2]
      && BUF->ackno[3] == uip_acc32[3]) {
      /* Update sequence number. */
      uip_connr->snd_nxt[0] = uip_acc32[0];
      uip_connr->snd_nxt[1] = uip_acc32[1];
      uip_connr->snd_nxt[2] = uip_acc32[2];
      uip_connr->snd_nxt[3] = uip_acc32[3];

      // Do RTT estimation, unless we have done retransmissions.
      if (uip_connr->nrtx == 0) {
        int8_t m;
        m = (int8_t)(uip_connr->rto - uip_connr->timer);
        // This is taken directly from VJs original code in his paper
        m = (int8_t)(m - (uip_connr->sa >> 3));
        uip_connr->sa += m;
        if (m < 0) m = (int8_t)(-m);
        m = (int8_t)(m - (uip_connr->sv >> 2));
        uip_connr->sv += m;
        uip_connr->rto = (uint8_t)((uip_connr->sa >> 3) + uip_connr->sv);
      }
      // Set the acknowledged flag.
      uip_flags = UIP_ACKDATA;
      // Reset the retransmission timer.
      uip_connr->timer = uip_connr->rto;

      // Reset length of outstanding data.
      uip_connr->len = 0;
    }
  }
  
  // Do different things depending on in what state the connection is.
  switch (uip_connr->tcpstateflags & UIP_TS_MASK) {
    // CLOSED and LISTEN are not handled here. CLOSE_WAIT is not implemented,
    // since we force the application to close when the peer sends a FIN
    // (hence the application goes directly from ESTABLISHED to LAST_ACK).
    case UIP_SYN_RCVD:
      // In SYN_RCVD we have sent out a SYNACK in response to a SYN, and we
      // are waiting for an ACK that acknowledges the data we sent out the
      // last time. Therefore, we want to have the UIP_ACKDATA flag set. If
      // so, we enter the ESTABLISHED state.
      if (uip_flags & UIP_ACKDATA) {
        uip_connr->tcpstateflags = UIP_ESTABLISHED;
        uip_flags = UIP_CONNECTED;
        uip_connr->len = 0;
        if (uip_len > 0) {
          uip_flags |= UIP_NEWDATA;
          uip_add_rcv_nxt(uip_len);
        }
        uip_slen = 0;
        UIP_APPCALL(); // We may have received data with the SYN
        goto appsend;
      }
      goto drop;


    case UIP_SYN_SENT:
      // In SYN_SENT, we wait for a SYNACK that is sent in response to our
      // SYN. The rcv_nxt is set to sequence number in the SYNACK plus one,
      // and we send an ACK. We move into the ESTABLISHED state.
      if((uip_flags & UIP_ACKDATA) &&
        (BUF->flags & TCP_CTL) == (TCP_SYN | TCP_ACK)) {
        // Parse the TCP MSS option, if present
        if((BUF->tcpoffset & 0xf0) > 0x50) {
	  for(c = 0; c < ((BUF->tcpoffset >> 4) - 5) << 2 ;) {
	    opt = uip_buf[UIP_IPTCPH_LEN + UIP_LLH_LEN + c];
	    if(opt == TCP_OPT_END) {
	      // End of options
	      break;
	    }
	    else if(opt == TCP_OPT_NOOP) {
	      ++c;
	      // NOP option
	    }
	    else if(opt == TCP_OPT_MSS &&
	      uip_buf[UIP_TCPIP_HLEN + UIP_LLH_LEN + 1 + c] == TCP_OPT_MSS_LEN) {
	      // An MSS option with the right option length
	      tmp16 = (uip_buf[UIP_TCPIP_HLEN + UIP_LLH_LEN + 2 + c] << 8) |
	        uip_buf[UIP_TCPIP_HLEN + UIP_LLH_LEN + 3 + c];
	      uip_connr->initialmss =
	        uip_connr->mss = tmp16 > UIP_TCP_MSS? UIP_TCP_MSS: tmp16;

	      // And we are done processing options
	      break;
	    }
	    else {
	      // All other options have a length field, so that we easily can
	      // skip past them
	      if(uip_buf[UIP_TCPIP_HLEN + UIP_LLH_LEN + 1 + c] == 0) {
	        // If the length field is zero, the options are malformed and
	        // we don't process them further
	        break;
	      }
	      c += uip_buf[UIP_TCPIP_HLEN + UIP_LLH_LEN + 1 + c];
	    }
	  }
        }
        uip_connr->tcpstateflags = UIP_ESTABLISHED;
        uip_connr->rcv_nxt[0] = BUF->seqno[0];
        uip_connr->rcv_nxt[1] = BUF->seqno[1];
        uip_connr->rcv_nxt[2] = BUF->seqno[2];
        uip_connr->rcv_nxt[3] = BUF->seqno[3];
        uip_add_rcv_nxt(1);
	// XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
	// It is odd that the UIP_NEWDATA flag is set, but then uip_len
	// is set to zero right after that.
	// XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
        uip_flags = UIP_CONNECTED | UIP_NEWDATA;
        uip_connr->len = 0;
        uip_len = 0;
        uip_slen = 0;
        UIP_APPCALL(); // This checks to see if there is any data to send with
	               // the ACK. Don't call it if you want to send a pure ACK.
		       // Note that uip_len is set to zero before the call.
        goto appsend;
      }
      // Inform the application that the connection failed
      uip_flags = UIP_ABORT;
      // XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
      // In this case the applications don't do anything with this information.
      // XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
      UIP_APPCALL(); // ???
      // The connection is closed after we send the RST
      uip_conn->tcpstateflags = UIP_CLOSED;
      goto reset;


    case UIP_ESTABLISHED:
      // In the ESTABLISHED state, we call upon the application to feed data
      // into the uip_buf. If the UIP_ACKDATA flag is set, the application
      // should put new data into the buffer, otherwise we are retransmitting
      // an old segment, and the application should put that data into the
      // buffer.
      //
      // If the incoming packet is a FIN, we should close the connection on
      // this side as well, and we send out a FIN and enter the LAST_ACK
      // state. We require that there is no outstanding data; otherwise the
      // sequence numbers will be screwed up.
      if (BUF->flags & TCP_FIN && !(uip_connr->tcpstateflags & UIP_STOPPED)) {
        if (uip_outstanding(uip_connr)) {
          goto drop;
        }
        uip_add_rcv_nxt(1 + uip_len);
        uip_flags |= UIP_CLOSE;
        if (uip_len > 0) {
          uip_flags |= UIP_NEWDATA;
        }
        UIP_APPCALL(); // This processes any receive data and sets up any
	               // transmit data to send with the the ACK.
	uip_connr->len = 1;
        uip_connr->tcpstateflags = UIP_LAST_ACK;
        uip_connr->nrtx = 0;
	
        tcp_send_finack:
	BUF->flags = TCP_FIN | TCP_ACK;
        goto tcp_send_nodata;
      }

      // Check the URG flag. If this is set, the segment carries urgent data
      // that we must pass to the application.
      if ((BUF->flags & TCP_URG) != 0) {
        uip_appdata = ((char *)uip_appdata) + ((BUF->urgp[0] << 8) | BUF->urgp[1]);
        uip_len -= (BUF->urgp[0] << 8) | BUF->urgp[1];
      }

      // If uip_len > 0 we have TCP data in the packet, and we flag this by
      // setting the UIP_NEWDATA flag and update the sequence number we
      // acknowledge. If the application has stopped the dataflow using
      // uip_stop(), we must not accept any data packets from the remote
      // host.
      if (uip_len > 0 && !(uip_connr->tcpstateflags & UIP_STOPPED)) {
        uip_flags |= UIP_NEWDATA;
        uip_add_rcv_nxt(uip_len);
      }

      // Check if the available buffer space advertised by the other end is
      // smaller than the initial MSS for this connection. If so, we set the
      // current MSS to the window size to ensure that the application does
      // not send more data than the other end can handle.
      //
      // If the remote host advertises a zero window, we set the MSS to the
      // initial MSS so that the application will send an entire MSS of data.
      // This data will not be acknowledged by the receiver, and the
      // application will retransmit it. This is called the "persistent timer"
      // and uses the retransmission mechanim.
      tmp16 = ((uint16_t)BUF->wnd[0] << 8) + (uint16_t)BUF->wnd[1];
      if (tmp16 > uip_connr->initialmss || tmp16 == 0) {
        tmp16 = uip_connr->initialmss;
      }
      uip_connr->mss = tmp16;
      
      // If this packet constitutes an ACK for outstanding data (flagged by
      // the UIP_ACKDATA flag), we should call the application since it might
      // want to send more data. If the incoming packet had data from the peer
      // (as flagged by the UIP_NEWDATA flag), the application must also be
      // notified.
      //
      // When the application is called, the global variable uip_len contains
      // the length of the incoming data. The application can access the
      // incoming data through the global pointer uip_appdata, which usually
      // points UIP_IPTCPH_LEN + UIP_LLH_LEN bytes into the uip_buf array.
      //
      // If the application wishes to send any data, this data should be put
      // into the uip_buf at uip_appdata and the length of the data should be
      // put into uip_len. If the application doesn't have any data to send
      // uip_len must be set to 0.
      if (uip_flags & (UIP_NEWDATA | UIP_ACKDATA)) {
        uip_slen = 0;
        UIP_APPCALL(); // Here is where the application will read data that
	               // arrived from the client/browser and then the
		       // application will fill the uip_buf with new data to
		       // send out (if any)




        appsend:

        if (uip_flags & UIP_ABORT) {
          uip_slen = 0;
          uip_connr->tcpstateflags = UIP_CLOSED;
          BUF->flags = TCP_RST | TCP_ACK;
          goto tcp_send_nodata;
        }

        if (uip_flags & UIP_CLOSE) {
          uip_slen = 0;
	  uip_connr->len = 1;
	  uip_connr->tcpstateflags = UIP_FIN_WAIT_1;
	  uip_connr->nrtx = 0;
	  BUF->flags = TCP_FIN | TCP_ACK;
	  goto tcp_send_nodata;
        }

        // If uip_slen > 0, the application has data to be sent.
        if (uip_slen > 0) {
          // If the connection has acknowledged data, the contents of the
	  // ->len variable should be discarded.
	  if ((uip_flags & UIP_ACKDATA) != 0) {
	    uip_connr->len = 0;
	  }
	  
	  // If the ->len variable is non-zero the connection has already
	  // data in transit and cannot send anymore right now.
	  if (uip_connr->len == 0) {
	    // The application cannot send more than what is allowed by the
	    // mss (the minumum of the MSS and the available window).
	    if (uip_slen > uip_connr->mss) {
	      uip_slen = uip_connr->mss;
	    }

            // Remember how much data we send out now so that we know when
	    // everything has been acknowledged.
            uip_connr->len = uip_slen;
	  }
	  else {
	    // If the application already had unacknowledged data, we make
	    // sure that the application does not send (i.e., retransmit) out
	    // more than it previously sent out.
	    uip_slen = uip_connr->len;
	  }
        }
	uip_connr->nrtx = 0;



	
	apprexmit:
	uip_appdata = uip_sappdata;

	// If the application has data to be sent, or if the incoming packet
	// had new data in it, we must send out a packet.
	if (uip_slen > 0 && uip_connr->len > 0) {
	  // Add the length of the IP and TCP headers.
	  uip_len = uip_connr->len + UIP_TCPIP_HLEN;
	  // We always set the ACK flag in response packets.
	  BUF->flags = TCP_ACK | TCP_PSH;
	  // Send the packet.
	  goto tcp_send_noopts;
	}
	// If there is no data to send, just send out a pure ACK if there is
	// newdata.
	if (uip_flags & UIP_NEWDATA) {
	  uip_len = UIP_TCPIP_HLEN;
	  BUF->flags = TCP_ACK;
	  goto tcp_send_noopts;
	}
      }
      goto drop;
      
    case UIP_LAST_ACK:
      // We can close this connection if the peer has acknowledged our FIN.
      // This is indicated by the UIP_ACKDATA flag.
      if (uip_flags & UIP_ACKDATA) {
        uip_connr->tcpstateflags = UIP_CLOSED;
	uip_flags = UIP_CLOSE;
	// XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
        // Not sure why there is an APPCALL here as we are closing the
	// connection.
	// XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
	UIP_APPCALL(); // ???
      }
      break;
      
    case UIP_FIN_WAIT_1:
      // The application has closed the connection, but the remote host hasn't
      // closed its end yet. Thus we do nothing but wait for a FIN from the
      // other side.
      if (uip_len > 0) {
        uip_add_rcv_nxt(uip_len);
      }
      if (BUF->flags & TCP_FIN) {
        if (uip_flags & UIP_ACKDATA) {
	  uip_connr->tcpstateflags = UIP_TIME_WAIT;
	  uip_connr->timer = 0;
	  uip_connr->len = 0;
	}
        else {
          uip_connr->tcpstateflags = UIP_CLOSING;
        }
        uip_add_rcv_nxt(1);
        uip_flags = UIP_CLOSE;
	// XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
        // Not sure why there is an APPCALL here as we are closing the
	// connection.
	// XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
        UIP_APPCALL(); // ???
        goto tcp_send_ack;
      }
      else if (uip_flags & UIP_ACKDATA) {
        uip_connr->tcpstateflags = UIP_FIN_WAIT_2;
        uip_connr->len = 0;
        goto drop;
      }
      if (uip_len > 0) {
        goto tcp_send_ack;
      }
      goto drop;

    case UIP_FIN_WAIT_2:
      if (uip_len > 0) {
	uip_add_rcv_nxt(uip_len);
      }
      if (BUF->flags & TCP_FIN) {
	uip_connr->tcpstateflags = UIP_TIME_WAIT;
	uip_connr->timer = 0;
	uip_add_rcv_nxt(1);
	uip_flags = UIP_CLOSE;
	// XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
        // Not sure why there is an APPCALL here as we are closing the
	// connection.
	// XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
	UIP_APPCALL(); // ???
	goto tcp_send_ack;
      }
      if (uip_len > 0) {
	goto tcp_send_ack;
      }
      goto drop;

    case UIP_TIME_WAIT:
      goto tcp_send_ack;

    case UIP_CLOSING:
      if (uip_flags & UIP_ACKDATA) {
	uip_connr->tcpstateflags = UIP_TIME_WAIT;
	uip_connr->timer = 0;
    }
  }
  goto drop;





  tcp_send_ack:
  // We jump here when we are ready to send the packet, and just want to set
  // the appropriate TCP sequence numbers in the TCP header.
  BUF->flags = TCP_ACK;
  
  tcp_send_nodata:
  uip_len = UIP_IPTCPH_LEN;
  
  tcp_send_noopts:
  BUF->tcpoffset = (UIP_TCPH_LEN / 4) << 4;




  tcp_send:
  // We're done with the input processing. We are now ready to send a reply.
  // Our job is to fill in all the fields of the TCP and IP headers before
  // calculating the checksum and finally send the packet.
  BUF->ackno[0] = uip_connr->rcv_nxt[0];
  BUF->ackno[1] = uip_connr->rcv_nxt[1];
  BUF->ackno[2] = uip_connr->rcv_nxt[2];
  BUF->ackno[3] = uip_connr->rcv_nxt[3];

  BUF->seqno[0] = uip_connr->snd_nxt[0];
  BUF->seqno[1] = uip_connr->snd_nxt[1];
  BUF->seqno[2] = uip_connr->snd_nxt[2];
  BUF->seqno[3] = uip_connr->snd_nxt[3];

  BUF->proto = UIP_PROTO_TCP;
  
  BUF->srcport = uip_connr->lport;
  BUF->destport = uip_connr->rport;

  uip_ipaddr_copy(BUF->srcipaddr, uip_hostaddr);
  uip_ipaddr_copy(BUF->destipaddr, uip_connr->ripaddr);

  if (uip_connr->tcpstateflags & UIP_STOPPED) {
    // If the connection has issued uip_stop(), we advertise a zero window so
    // that the remote host will stop sending data.
    BUF->wnd[0] = BUF->wnd[1] = 0;
  }
  else {
    // Send the MSS value. This SHOULD limit the size of packets from the
    // remote host.
    BUF->wnd[0] = ((UIP_RECEIVE_WINDOW) >> 8);
    BUF->wnd[1] = ((UIP_RECEIVE_WINDOW) & 0xff);
  }





  tcp_send_noconn:
  BUF->ttl = UIP_TTL;
  BUF->len[0] = (uint8_t)(uip_len >> 8);
  BUF->len[1] = (uint8_t)(uip_len & 0xff);

  BUF->urgp[0] = BUF->urgp[1] = 0;

  // Calculate TCP checksum.
  BUF->tcpchksum = 0;
  BUF->tcpchksum = ~(uip_tcpchksum());




  ip_send_nolen:

  BUF->vhl = 0x45;
  BUF->tos = 0;
  BUF->ipoffset[0] = BUF->ipoffset[1] = 0;
  ++ipid;
  BUF->ipid[0] = (uint8_t)(ipid >> 8);
  BUF->ipid[1] = (uint8_t)(ipid & 0xff);
  // Calculate IP checksum.
  BUF->ipchksum = 0;
  BUF->ipchksum = ~(uip_ipchksum());

  UIP_STAT(++uip_stat.tcp.sent);




  send:

  UIP_STAT(++uip_stat.ip.sent);
  // Return and let the caller do the actual transmission.
  uip_flags = 0;

  return;



  drop:
  uip_len = 0;
  uip_flags = 0;
  return;
}


/*---------------------------------------------------------------------------*/
uint16_t htons(uint16_t val)
{
  return HTONS(val);
}


/*---------------------------------------------------------------------------*/
//void uip_send(const void *data, int len)
void uip_send(const char *data, int len)
{
  if (len > 0) {
    uip_slen = len;
    if (data != uip_sappdata) {
      memcpy(uip_sappdata, (data), uip_slen);
    }
  }
}
