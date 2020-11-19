   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Parser V4.11.14 - 18 Nov 2019
   3                     ; Generator (Limited) V4.4.11 - 19 Nov 2019
   4                     ; Optimizer V4.4.11 - 19 Nov 2019
  58                     ; 69 void uip_TcpAppHubCall(void)
  58                     ; 70 // We get here via UIP_APPCALL in the uip.c code
  58                     ; 71 {
  60                     .text:	section	.text,new
  61  0000               _uip_TcpAppHubCall:
  65                     ; 72   if(uip_conn->lport == htons(Port_Httpd)) {
  67  0000 ce0000        	ldw	x,_Port_Httpd
  68  0003 cd0000        	call	_htons
  70  0006 90ce0000      	ldw	y,_uip_conn
  71  000a bf00          	ldw	c_x,x
  72  000c 93            	ldw	x,y
  73  000d ee04          	ldw	x,(4,x)
  74  000f b300          	cpw	x,c_x
  75  0011 2612          	jrne	L72
  76                     ; 80     HttpDCall(uip_appdata, uip_datalen(), &uip_conn->appstate.HttpDSocket);
  78  0013 93            	ldw	x,y
  79  0014 1c001c        	addw	x,#28
  80  0017 89            	pushw	x
  81  0018 ce0000        	ldw	x,_uip_len
  82  001b 89            	pushw	x
  83  001c ce0000        	ldw	x,_uip_appdata
  84  001f cd0000        	call	_HttpDCall
  86  0022 5b04          	addw	sp,#4
  89  0024 81            	ret	
  90  0025               L72:
  91                     ; 84   else if(uip_conn->lport == htons(Port_Mqttd)) {
  93  0025 ce0000        	ldw	x,_Port_Mqttd
  94  0028 cd0000        	call	_htons
  96  002b 90ce0000      	ldw	y,_uip_conn
  97  002f bf00          	ldw	c_x,x
  98  0031 93            	ldw	x,y
  99  0032 ee04          	ldw	x,(4,x)
 100  0034 b300          	cpw	x,c_x
 101  0036 2617          	jrne	L13
 102                     ; 91     if (mqtt_start > MQTT_START_QUEUE_CONNECT) {
 104  0038 c60000        	ld	a,_mqtt_start
 105  003b a105          	cp	a,#5
 106  003d 2510          	jrult	L13
 107                     ; 93       mqtt_sync(&mqttclient);
 109  003f ae0000        	ldw	x,#_mqttclient
 110  0042 cd0000        	call	_mqtt_sync
 112                     ; 98       if (mqtt_close_tcp == 1) uip_close();
 114  0045 c60000        	ld	a,_mqtt_close_tcp
 115  0048 4a            	dec	a
 116  0049 2604          	jrne	L13
 119  004b 35100000      	mov	_uip_flags,#16
 120  004f               L13:
 121                     ; 103 }
 124  004f 81            	ret	
 137                     	xref	_mqtt_close_tcp
 138                     	xref	_mqtt_start
 139                     	xref	_mqttclient
 140                     	xref	_Port_Mqttd
 141                     	xref	_Port_Httpd
 142                     	xref	_mqtt_sync
 143                     	xref	_uip_flags
 144                     	xref	_uip_conn
 145                     	xref	_uip_len
 146                     	xref	_uip_appdata
 147                     	xref	_htons
 148                     	xdef	_uip_TcpAppHubCall
 149                     	xref	_HttpDCall
 150                     	xref.b	c_x
 169                     	end
