   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Parser V4.11.14 - 18 Nov 2019
   3                     ; Generator (Limited) V4.4.11 - 19 Nov 2019
   4                     ; Optimizer V4.4.11 - 19 Nov 2019
  51                     ; 57 void uip_TcpAppHubCall(void)
  51                     ; 58 {
  53                     	switch	.text
  54  0000               _uip_TcpAppHubCall:
  58                     ; 59   if(uip_conn->lport == htons(Port_Httpd)) {
  60  0000 ce0000        	ldw	x,_Port_Httpd
  61  0003 cd0000        	call	_htons
  63  0006 90ce0000      	ldw	y,_uip_conn
  64  000a bf00          	ldw	c_x,x
  65  000c 93            	ldw	x,y
  66  000d ee04          	ldw	x,(4,x)
  67  000f b300          	cpw	x,c_x
  68  0011 2611          	jrne	L13
  69                     ; 60     HttpDCall(uip_appdata, uip_datalen(), &uip_conn->appstate.HttpDSocket);
  71  0013 93            	ldw	x,y
  72  0014 1c001c        	addw	x,#28
  73  0017 89            	pushw	x
  74  0018 ce0000        	ldw	x,_uip_len
  75  001b 89            	pushw	x
  76  001c ce0000        	ldw	x,_uip_appdata
  77  001f cd0000        	call	_HttpDCall
  79  0022 5b04          	addw	sp,#4
  80  0024               L13:
  81                     ; 62 }
  84  0024 81            	ret	
  97                     	xref	_Port_Httpd
  98                     	xref	_uip_conn
  99                     	xref	_uip_len
 100                     	xref	_uip_appdata
 101                     	xref	_htons
 102                     	xdef	_uip_TcpAppHubCall
 103                     	xref	_HttpDCall
 104                     	xref.b	c_x
 123                     	end
