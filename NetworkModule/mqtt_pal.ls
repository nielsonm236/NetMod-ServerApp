   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Parser V4.11.14 - 18 Nov 2019
   3                     ; Generator (Limited) V4.4.11 - 19 Nov 2019
   4                     ; Optimizer V4.4.11 - 19 Nov 2019
  68                     ; 137 int16_t mqtt_pal_sendall(const void* buf, uint16_t len) {
  70                     .text:	section	.text,new
  71  0000               _mqtt_pal_sendall:
  73       fffffffe      OFST: set -2
  76                     ; 171   memcpy(uip_appdata, buf, len);
  78  0000 bf00          	ldw	c_x,x
  79  0002 1e03          	ldw	x,(OFST+5,sp)
  80  0004 270d          	jreq	L6
  81  0006               L01:
  82  0006 5a            	decw	x
  83  0007 92d600        	ld	a,([c_x.w],x)
  84  000a 72d70000      	ld	([_uip_appdata.w],x),a
  85  000e 5d            	tnzw	x
  86  000f 26f5          	jrne	L01
  87  0011 1e03          	ldw	x,(OFST+5,sp)
  88  0013               L6:
  89                     ; 172   uip_slen = len;
  91  0013 cf0000        	ldw	_uip_slen,x
  92                     ; 173   return len; // This return value is only for the MQTT buffer mgmt code. The
  96  0016 81            	ret	
 139                     ; 177 int16_t mqtt_pal_recvall(void* buf, uint16_t bufsz) {
 140                     .text:	section	.text,new
 141  0000               _mqtt_pal_recvall:
 143  0000 89            	pushw	x
 144       00000002      OFST:	set	2
 147                     ; 191   rv = -1; // Default to return an error if no data present
 149  0001 aeffff        	ldw	x,#65535
 150  0004 1f01          	ldw	(OFST-1,sp),x
 152                     ; 192   if (uip_len > 0) {  // Indicates data is present
 154  0006 ce0000        	ldw	x,_uip_len
 155  0009 2702          	jreq	L75
 156                     ; 193     rv = uip_len; // Return the size of the data. Data begins at pointer
 158  000b 1f01          	ldw	(OFST-1,sp),x
 160  000d               L75:
 161                     ; 196   return rv;
 163  000d 1e01          	ldw	x,(OFST-1,sp)
 166  000f 5b02          	addw	sp,#2
 167  0011 81            	ret	
 180                     	xref	_uip_slen
 181                     	xref	_uip_len
 182                     	xref	_uip_appdata
 183                     	xdef	_mqtt_pal_recvall
 184                     	xdef	_mqtt_pal_sendall
 185                     	xref.b	c_x
 204                     	end
