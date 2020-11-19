   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Parser V4.11.14 - 18 Nov 2019
   3                     ; Generator (Limited) V4.4.11 - 19 Nov 2019
   4                     ; Optimizer V4.4.11 - 19 Nov 2019
  18                     	switch	.data
  19  0000               _uip_ethaddr:
  20  0000 01            	dc.b	1
  21  0001 02            	dc.b	2
  22  0002 03            	dc.b	3
  23  0003 04            	dc.b	4
  24  0004 05            	dc.b	5
  25  0005 06            	dc.b	6
  64                     ; 176 void uip_setipid(uint16_t id)
  64                     ; 177 {
  66                     .text:	section	.text,new
  67  0000               _uip_setipid:
  71                     ; 178   ipid = id;
  73  0000 cf0008        	ldw	L11_ipid,x
  74                     ; 179 }
  77  0003 81            	ret	
 120                     ; 230 void uip_add32(uint8_t *op32, uint16_t op16)
 120                     ; 231 {
 121                     .text:	section	.text,new
 122  0000               _uip_add32:
 124  0000 89            	pushw	x
 125  0001 89            	pushw	x
 126       00000002      OFST:	set	2
 129                     ; 232   uip_acc32[3] = (uint8_t)(op32[3] + (op16 & 0xff));
 131  0002 7b08          	ld	a,(OFST+6,sp)
 132  0004 eb03          	add	a,(3,x)
 133  0006 c70026        	ld	_uip_acc32+3,a
 134                     ; 233   uip_acc32[2] = (uint8_t)(op32[2] + (op16 >> 8));
 136  0009 e602          	ld	a,(2,x)
 137  000b 1b07          	add	a,(OFST+5,sp)
 138  000d c70025        	ld	_uip_acc32+2,a
 139                     ; 234   uip_acc32[1] = op32[1];
 141  0010 e601          	ld	a,(1,x)
 142  0012 c70024        	ld	_uip_acc32+1,a
 143                     ; 235   uip_acc32[0] = op32[0];
 145  0015 f6            	ld	a,(x)
 146  0016 c70023        	ld	_uip_acc32,a
 147                     ; 237   if (uip_acc32[2] < (op16 >> 8)) {
 149  0019 4f            	clr	a
 150  001a 1e07          	ldw	x,(OFST+5,sp)
 151  001c 01            	rrwa	x,a
 152  001d c60025        	ld	a,_uip_acc32+2
 153  0020 905f          	clrw	y
 154  0022 9097          	ld	yl,a
 155  0024 90bf00        	ldw	c_y,y
 156  0027 b300          	cpw	x,c_y
 157  0029 230a          	jrule	L56
 158                     ; 238     ++uip_acc32[1];
 160  002b 725c0024      	inc	_uip_acc32+1
 161                     ; 239     if (uip_acc32[1] == 0) {
 163  002f 2604          	jrne	L56
 164                     ; 240       ++uip_acc32[0];
 166  0031 725c0023      	inc	_uip_acc32
 167  0035               L56:
 168                     ; 244   if (uip_acc32[3] < (op16 & 0xff)) {
 170  0035 c60026        	ld	a,_uip_acc32+3
 171  0038 5f            	clrw	x
 172  0039 97            	ld	xl,a
 173  003a 1f01          	ldw	(OFST-1,sp),x
 175  003c 5f            	clrw	x
 176  003d 7b08          	ld	a,(OFST+6,sp)
 177  003f 02            	rlwa	x,a
 178  0040 1301          	cpw	x,(OFST-1,sp)
 179  0042 2310          	jrule	L17
 180                     ; 245     ++uip_acc32[2];
 182  0044 725c0025      	inc	_uip_acc32+2
 183                     ; 246     if (uip_acc32[2] == 0) {
 185  0048 260a          	jrne	L17
 186                     ; 247       ++uip_acc32[1];
 188  004a 725c0024      	inc	_uip_acc32+1
 189                     ; 248       if (uip_acc32[1] == 0) {
 191  004e 2604          	jrne	L17
 192                     ; 249         ++uip_acc32[0];
 194  0050 725c0023      	inc	_uip_acc32
 195  0054               L17:
 196                     ; 253 }
 199  0054 5b04          	addw	sp,#4
 200  0056 81            	ret	
 276                     ; 260 static uint16_t chksum(uint16_t sum, const uint8_t *data, uint16_t len)
 276                     ; 261 {
 277                     .text:	section	.text,new
 278  0000               L77_chksum:
 280  0000 89            	pushw	x
 281  0001 5206          	subw	sp,#6
 282       00000006      OFST:	set	6
 285                     ; 266   dataptr = data;
 287  0003 1e0b          	ldw	x,(OFST+5,sp)
 288  0005 1f05          	ldw	(OFST-1,sp),x
 290                     ; 267   last_byte = data + len - 1;
 292  0007 72fb0d        	addw	x,(OFST+7,sp)
 293  000a 5a            	decw	x
 294  000b 1f01          	ldw	(OFST-5,sp),x
 297  000d 1e05          	ldw	x,(OFST-1,sp)
 298  000f 2020          	jra	L141
 299  0011               L531:
 300                     ; 270     t = (dataptr[0] << 8) + dataptr[1];
 302  0011 f6            	ld	a,(x)
 303  0012 5f            	clrw	x
 304  0013 97            	ld	xl,a
 305  0014 1605          	ldw	y,(OFST-1,sp)
 306  0016 4f            	clr	a
 307  0017 90eb01        	add	a,(1,y)
 308  001a 2401          	jrnc	L21
 309  001c 5c            	incw	x
 310  001d               L21:
 311  001d 02            	rlwa	x,a
 312  001e 1f03          	ldw	(OFST-3,sp),x
 314                     ; 271     sum += t;
 316  0020 72fb07        	addw	x,(OFST+1,sp)
 317                     ; 272     if (sum < t) sum++; /* carry */
 319  0023 1303          	cpw	x,(OFST-3,sp)
 320  0025 2401          	jruge	L541
 323  0027 5c            	incw	x
 324  0028               L541:
 325  0028 1f07          	ldw	(OFST+1,sp),x
 326                     ; 273     dataptr += 2;
 328  002a 1e05          	ldw	x,(OFST-1,sp)
 329  002c 1c0002        	addw	x,#2
 330  002f 1f05          	ldw	(OFST-1,sp),x
 332  0031               L141:
 333                     ; 269   while (dataptr < last_byte) { /* At least two more bytes */
 335  0031 1301          	cpw	x,(OFST-5,sp)
 336  0033 25dc          	jrult	L531
 337                     ; 276   if (dataptr == last_byte) {
 339  0035 2612          	jrne	L741
 340                     ; 277     t = (dataptr[0] << 8) + 0;
 342  0037 f6            	ld	a,(x)
 343  0038 97            	ld	xl,a
 344  0039 4f            	clr	a
 345  003a 02            	rlwa	x,a
 346  003b 1f03          	ldw	(OFST-3,sp),x
 348                     ; 278     sum += t;
 350  003d 72fb07        	addw	x,(OFST+1,sp)
 351  0040 1f07          	ldw	(OFST+1,sp),x
 352                     ; 279     if (sum < t) sum++; /* carry */
 354  0042 1303          	cpw	x,(OFST-3,sp)
 355  0044 2403          	jruge	L741
 358  0046 5c            	incw	x
 359  0047 1f07          	ldw	(OFST+1,sp),x
 360  0049               L741:
 361                     ; 282   return sum;
 363  0049 1e07          	ldw	x,(OFST+1,sp)
 366  004b 5b08          	addw	sp,#8
 367  004d 81            	ret	
 411                     ; 287 uint16_t uip_chksum(uint16_t *data, uint16_t len)
 411                     ; 288 {
 412                     .text:	section	.text,new
 413  0000               _uip_chksum:
 415  0000 89            	pushw	x
 416       00000000      OFST:	set	0
 419                     ; 289   return htons(chksum(0, (uint8_t *)data, len));
 421  0001 1e05          	ldw	x,(OFST+5,sp)
 422  0003 89            	pushw	x
 423  0004 1e03          	ldw	x,(OFST+3,sp)
 424  0006 89            	pushw	x
 425  0007 5f            	clrw	x
 426  0008 cd0000        	call	L77_chksum
 428  000b 5b04          	addw	sp,#4
 429  000d cd0000        	call	_htons
 433  0010 5b02          	addw	sp,#2
 434  0012 81            	ret	
 469                     ; 295 uint16_t uip_ipchksum(void)
 469                     ; 296 {
 470                     .text:	section	.text,new
 471  0000               _uip_ipchksum:
 473  0000 89            	pushw	x
 474       00000002      OFST:	set	2
 477                     ; 299   sum = chksum(0, &uip_buf[UIP_LLH_LEN], UIP_IPH_LEN);
 479  0001 ae0014        	ldw	x,#20
 480  0004 89            	pushw	x
 481  0005 ae00df        	ldw	x,#_uip_buf+14
 482  0008 89            	pushw	x
 483  0009 5f            	clrw	x
 484  000a cd0000        	call	L77_chksum
 486  000d 5b04          	addw	sp,#4
 487  000f 1f01          	ldw	(OFST-1,sp),x
 489                     ; 301   return (sum == 0) ? 0xffff : htons(sum);
 491  0011 2603          	jrne	L62
 492  0013 5a            	decw	x
 493  0014 2003          	jra	L03
 494  0016               L62:
 495  0016 cd0000        	call	_htons
 497  0019               L03:
 500  0019 5b02          	addw	sp,#2
 501  001b 81            	ret	
 550                     ; 307 static uint16_t upper_layer_chksum(uint8_t proto)
 550                     ; 308 {
 551                     .text:	section	.text,new
 552  0000               L702_upper_layer_chksum:
 554  0000 88            	push	a
 555  0001 5204          	subw	sp,#4
 556       00000004      OFST:	set	4
 559                     ; 312   upper_layer_len = (((uint16_t)(BUF->len[0]) << 8) + BUF->len[1]) - UIP_IPH_LEN;
 561  0003 c600e1        	ld	a,_uip_buf+16
 562  0006 5f            	clrw	x
 563  0007 97            	ld	xl,a
 564  0008 4f            	clr	a
 565  0009 cb00e2        	add	a,_uip_buf+17
 566  000c 2401          	jrnc	L63
 567  000e 5c            	incw	x
 568  000f               L63:
 569  000f 02            	rlwa	x,a
 570  0010 1d0014        	subw	x,#20
 571  0013 1f01          	ldw	(OFST-3,sp),x
 573                     ; 317   sum = upper_layer_len + proto;
 575  0015 5f            	clrw	x
 576  0016 7b05          	ld	a,(OFST+1,sp)
 577  0018 97            	ld	xl,a
 578  0019 72fb01        	addw	x,(OFST-3,sp)
 579  001c 1f03          	ldw	(OFST-1,sp),x
 581                     ; 319   sum = chksum(sum, (uint8_t *)&BUF->srcipaddr[0], 2 * sizeof(uip_ipaddr_t));
 583  001e ae0008        	ldw	x,#8
 584  0021 89            	pushw	x
 585  0022 ae00eb        	ldw	x,#_uip_buf+26
 586  0025 89            	pushw	x
 587  0026 1e07          	ldw	x,(OFST+3,sp)
 588  0028 cd0000        	call	L77_chksum
 590  002b 5b04          	addw	sp,#4
 591  002d 1f03          	ldw	(OFST-1,sp),x
 593                     ; 322   sum = chksum(sum, &uip_buf[UIP_IPH_LEN + UIP_LLH_LEN], upper_layer_len);
 595  002f 1e01          	ldw	x,(OFST-3,sp)
 596  0031 89            	pushw	x
 597  0032 ae00f3        	ldw	x,#_uip_buf+34
 598  0035 89            	pushw	x
 599  0036 1e07          	ldw	x,(OFST+3,sp)
 600  0038 cd0000        	call	L77_chksum
 602  003b 5b04          	addw	sp,#4
 603  003d 1f03          	ldw	(OFST-1,sp),x
 605                     ; 324   return (sum == 0) ? 0xffff : htons(sum);
 607  003f 2603          	jrne	L44
 608  0041 5a            	decw	x
 609  0042 2003          	jra	L64
 610  0044               L44:
 611  0044 cd0000        	call	_htons
 613  0047               L64:
 616  0047 5b05          	addw	sp,#5
 617  0049 81            	ret	
 641                     ; 329 uint16_t uip_tcpchksum(void)
 641                     ; 330 {
 642                     .text:	section	.text,new
 643  0000               _uip_tcpchksum:
 647                     ; 331   return upper_layer_chksum(UIP_PROTO_TCP);
 649  0000 a606          	ld	a,#6
 653  0002 cc0000        	jp	L702_upper_layer_chksum
 679                     ; 337 void uip_init(void)
 679                     ; 338 {
 680                     .text:	section	.text,new
 681  0000               _uip_init:
 685                     ; 339   for (c = 0; c < UIP_LISTENPORTS; ++c) uip_listenports[c] = 0;
 687  0000 4f            	clr	a
 688  0001 c70003        	ld	L73_c,a
 689  0004               L152:
 692  0004 5f            	clrw	x
 693  0005 97            	ld	xl,a
 694  0006 58            	sllw	x
 695  0007 905f          	clrw	y
 696  0009 df000a        	ldw	(_uip_listenports,x),y
 699  000c 725c0003      	inc	L73_c
 702  0010 c60003        	ld	a,L73_c
 703  0013 a102          	cp	a,#2
 704  0015 25ed          	jrult	L152
 705                     ; 340   for (c = 0; c < UIP_CONNS; ++c) uip_conns[c].tcpstateflags = UIP_CLOSED;
 707  0017 4f            	clr	a
 708  0018 c70003        	ld	L73_c,a
 709  001b               L752:
 712  001b 97            	ld	xl,a
 713  001c a629          	ld	a,#41
 714  001e 42            	mul	x,a
 715  001f 724f0040      	clr	(_uip_conns+25,x)
 718  0023 725c0003      	inc	L73_c
 721  0027 c60003        	ld	a,L73_c
 722  002a a104          	cp	a,#4
 723  002c 25ed          	jrult	L752
 724                     ; 347 }
 727  002e 81            	ret	
1028                     ; 357 struct uip_conn *
1028                     ; 358 uip_connect(uip_ipaddr_t *ripaddr, uint16_t rport, uint16_t lport)
1028                     ; 359 {
1029                     .text:	section	.text,new
1030  0000               _uip_connect:
1032  0000 89            	pushw	x
1033  0001 5204          	subw	sp,#4
1034       00000004      OFST:	set	4
1037                     ; 363   conn = 0;
1039  0003 5f            	clrw	x
1040  0004 1f03          	ldw	(OFST-1,sp),x
1042                     ; 364   for(c = 0; c < UIP_CONNS; ++c) {
1044  0006 4f            	clr	a
1045  0007 c70003        	ld	L73_c,a
1046  000a               L144:
1047                     ; 365     cconn = &uip_conns[c];
1049  000a 97            	ld	xl,a
1050  000b a629          	ld	a,#41
1051  000d 42            	mul	x,a
1052  000e 1c0027        	addw	x,#_uip_conns
1053  0011 1f01          	ldw	(OFST-3,sp),x
1055                     ; 366     if(cconn->tcpstateflags == UIP_CLOSED) {
1057  0013 e619          	ld	a,(25,x)
1058  0015 2604          	jrne	L744
1059                     ; 367       conn = cconn;
1061  0017 1f03          	ldw	(OFST-1,sp),x
1063                     ; 368       break;
1065  0019 2021          	jra	L544
1066  001b               L744:
1067                     ; 370     if(cconn->tcpstateflags == UIP_TIME_WAIT) {
1069  001b a107          	cp	a,#7
1070  001d 2612          	jrne	L154
1071                     ; 371       if(conn == 0 ||
1071                     ; 372 	 cconn->timer > conn->timer) {
1073  001f 1e03          	ldw	x,(OFST-1,sp)
1074  0021 270a          	jreq	L554
1076  0023 1e01          	ldw	x,(OFST-3,sp)
1077  0025 e61a          	ld	a,(26,x)
1078  0027 1e03          	ldw	x,(OFST-1,sp)
1079  0029 e11a          	cp	a,(26,x)
1080  002b 2304          	jrule	L154
1081  002d               L554:
1082                     ; 373 	conn = cconn;
1084  002d 1e01          	ldw	x,(OFST-3,sp)
1085  002f 1f03          	ldw	(OFST-1,sp),x
1087  0031               L154:
1088                     ; 364   for(c = 0; c < UIP_CONNS; ++c) {
1090  0031 725c0003      	inc	L73_c
1093  0035 c60003        	ld	a,L73_c
1094  0038 a104          	cp	a,#4
1095  003a 25ce          	jrult	L144
1096  003c               L544:
1097                     ; 378   if(conn == 0) return 0;
1099  003c 1e03          	ldw	x,(OFST-1,sp)
1100  003e 2603          	jrne	L754
1103  0040 5f            	clrw	x
1105  0041 2053          	jra	L26
1106  0043               L754:
1107                     ; 380   conn->tcpstateflags = UIP_SYN_SENT;
1109  0043 a602          	ld	a,#2
1110  0045 e719          	ld	(25,x),a
1111                     ; 382   conn->snd_nxt[0] = iss[0];
1113  0047 c60004        	ld	a,L53_iss
1114  004a e70c          	ld	(12,x),a
1115                     ; 383   conn->snd_nxt[1] = iss[1];
1117  004c c60005        	ld	a,L53_iss+1
1118  004f e70d          	ld	(13,x),a
1119                     ; 384   conn->snd_nxt[2] = iss[2];
1121  0051 c60006        	ld	a,L53_iss+2
1122  0054 e70e          	ld	(14,x),a
1123                     ; 385   conn->snd_nxt[3] = iss[3];
1125  0056 c60007        	ld	a,L53_iss+3
1126  0059 e70f          	ld	(15,x),a
1127                     ; 387   conn->initialmss = conn->mss = UIP_TCP_MSS;
1129  005b 90ae01b8      	ldw	y,#440
1130  005f ef12          	ldw	(18,x),y
1131  0061 1603          	ldw	y,(OFST-1,sp)
1132  0063 ee12          	ldw	x,(18,x)
1133  0065 90ef14        	ldw	(20,y),x
1134                     ; 389   conn->len = 1;   /* TCP length of the SYN is one. */
1136  0068 93            	ldw	x,y
1137  0069 90ae0001      	ldw	y,#1
1138  006d ef10          	ldw	(16,x),y
1139                     ; 390   conn->nrtx = 0;
1141  006f 6f1b          	clr	(27,x)
1142                     ; 391   conn->timer = 1; /* Send the SYN next time around. */
1144  0071 a601          	ld	a,#1
1145  0073 e71a          	ld	(26,x),a
1146                     ; 392   conn->rto = UIP_RTO;
1148  0075 a603          	ld	a,#3
1149  0077 e718          	ld	(24,x),a
1150                     ; 393   conn->sa = 0;
1152  0079 6f16          	clr	(22,x)
1153                     ; 394   conn->sv = 16;   /* Initial value of the RTT variance. */
1155  007b a610          	ld	a,#16
1156  007d e717          	ld	(23,x),a
1157                     ; 395   conn->lport = lport;
1159  007f 160b          	ldw	y,(OFST+7,sp)
1160  0081 ef04          	ldw	(4,x),y
1161                     ; 396   conn->rport = rport;
1163  0083 1609          	ldw	y,(OFST+5,sp)
1164  0085 ef06          	ldw	(6,x),y
1165                     ; 397   uip_ipaddr_copy(&conn->ripaddr, ripaddr);
1167  0087 1e05          	ldw	x,(OFST+1,sp)
1168  0089 1603          	ldw	y,(OFST-1,sp)
1169  008b fe            	ldw	x,(x)
1170  008c 90ff          	ldw	(y),x
1173  008e 1e05          	ldw	x,(OFST+1,sp)
1174  0090 ee02          	ldw	x,(2,x)
1175  0092 90ef02        	ldw	(2,y),x
1176                     ; 398   return conn;
1178  0095 93            	ldw	x,y
1180  0096               L26:
1182  0096 5b06          	addw	sp,#6
1183  0098 81            	ret	
1206                     ; 404 void uip_init_stats(void)
1206                     ; 405 {
1207                     .text:	section	.text,new
1208  0000               _uip_init_stats:
1212                     ; 431 }
1215  0000 81            	ret	
1249                     ; 435 void uip_unlisten(uint16_t port)
1249                     ; 436 {
1250                     .text:	section	.text,new
1251  0000               _uip_unlisten:
1253  0000 89            	pushw	x
1254       00000000      OFST:	set	0
1257                     ; 437   for (c = 0; c < UIP_LISTENPORTS; ++c) {
1259  0001 4f            	clr	a
1260  0002 c70003        	ld	L73_c,a
1261  0005               L115:
1262                     ; 438     if (uip_listenports[c] == port) {
1264  0005 5f            	clrw	x
1265  0006 97            	ld	xl,a
1266  0007 58            	sllw	x
1267  0008 de000a        	ldw	x,(_uip_listenports,x)
1268  000b 1301          	cpw	x,(OFST+1,sp)
1269  000d 260a          	jrne	L715
1270                     ; 439       uip_listenports[c] = 0;
1272  000f 5f            	clrw	x
1273  0010 97            	ld	xl,a
1274  0011 58            	sllw	x
1275  0012 905f          	clrw	y
1276  0014 df000a        	ldw	(_uip_listenports,x),y
1277                     ; 440       return;
1279  0017 200b          	jra	L07
1280  0019               L715:
1281                     ; 437   for (c = 0; c < UIP_LISTENPORTS; ++c) {
1283  0019 725c0003      	inc	L73_c
1286  001d c60003        	ld	a,L73_c
1287  0020 a102          	cp	a,#2
1288  0022 25e1          	jrult	L115
1289                     ; 443 }
1290  0024               L07:
1293  0024 85            	popw	x
1294  0025 81            	ret	
1328                     ; 447 void uip_listen(uint16_t port)
1328                     ; 448 {
1329                     .text:	section	.text,new
1330  0000               _uip_listen:
1332  0000 89            	pushw	x
1333       00000000      OFST:	set	0
1336                     ; 449   for (c = 0; c < UIP_LISTENPORTS; ++c) {
1338  0001 4f            	clr	a
1339  0002 c70003        	ld	L73_c,a
1340  0005               L535:
1341                     ; 450     if (uip_listenports[c] == 0) {
1343  0005 5f            	clrw	x
1344  0006 97            	ld	xl,a
1345  0007 58            	sllw	x
1346  0008 d6000b        	ld	a,(_uip_listenports+1,x)
1347  000b da000a        	or	a,(_uip_listenports,x)
1348  000e 2607          	jrne	L345
1349                     ; 451       uip_listenports[c] = port;
1351  0010 1601          	ldw	y,(OFST+1,sp)
1352  0012 df000a        	ldw	(_uip_listenports,x),y
1353                     ; 452       return;
1355  0015 200b          	jra	L47
1356  0017               L345:
1357                     ; 449   for (c = 0; c < UIP_LISTENPORTS; ++c) {
1359  0017 725c0003      	inc	L73_c
1362  001b c60003        	ld	a,L73_c
1363  001e a102          	cp	a,#2
1364  0020 25e3          	jrult	L535
1365                     ; 455 }
1366  0022               L47:
1369  0022 85            	popw	x
1370  0023 81            	ret	
1405                     ; 459 static void uip_add_rcv_nxt(uint16_t n)
1405                     ; 460 {
1406                     .text:	section	.text,new
1407  0000               L545_uip_add_rcv_nxt:
1411                     ; 461   uip_add32(uip_conn->rcv_nxt, n);
1413  0000 89            	pushw	x
1414  0001 ce00cb        	ldw	x,_uip_conn
1415  0004 1c0008        	addw	x,#8
1416  0007 cd0000        	call	_uip_add32
1418  000a 85            	popw	x
1419                     ; 462   uip_conn->rcv_nxt[0] = uip_acc32[0];
1421  000b ce00cb        	ldw	x,_uip_conn
1422  000e c60023        	ld	a,_uip_acc32
1423  0011 e708          	ld	(8,x),a
1424                     ; 463   uip_conn->rcv_nxt[1] = uip_acc32[1];
1426  0013 c60024        	ld	a,_uip_acc32+1
1427  0016 e709          	ld	(9,x),a
1428                     ; 464   uip_conn->rcv_nxt[2] = uip_acc32[2];
1430  0018 c60025        	ld	a,_uip_acc32+2
1431  001b e70a          	ld	(10,x),a
1432                     ; 465   uip_conn->rcv_nxt[3] = uip_acc32[3];
1434  001d c60026        	ld	a,_uip_acc32+3
1435  0020 e70b          	ld	(11,x),a
1436                     ; 466 }
1439  0022 81            	ret	
1511                     ; 470 void uip_process(uint8_t flag)
1511                     ; 471 {
1512                     .text:	section	.text,new
1513  0000               _uip_process:
1515  0000 88            	push	a
1516  0001 5205          	subw	sp,#5
1517       00000005      OFST:	set	5
1520                     ; 472   register struct uip_conn *uip_connr = uip_conn;
1522  0003 ce00cb        	ldw	x,_uip_conn
1523  0006 1f04          	ldw	(OFST-1,sp),x
1525                     ; 486   uip_sappdata = uip_appdata = &uip_buf[UIP_IPTCPH_LEN + UIP_LLH_LEN];
1527  0008 ae0107        	ldw	x,#_uip_buf+54
1528  000b cf00cf        	ldw	_uip_appdata,x
1529  000e cf0010        	ldw	_uip_sappdata,x
1530                     ; 491   if (flag == UIP_POLL_REQUEST) {
1532  0011 a103          	cp	a,#3
1533  0013 2614          	jrne	L107
1534                     ; 492     if ((uip_connr->tcpstateflags & UIP_TS_MASK) == UIP_ESTABLISHED && !uip_outstanding(uip_connr)) {
1536  0015 1e04          	ldw	x,(OFST-1,sp)
1537  0017 e619          	ld	a,(25,x)
1538  0019 a40f          	and	a,#15
1539  001b a103          	cp	a,#3
1540  001d 2703cc0923    	jrne	L356
1542  0022 e611          	ld	a,(17,x)
1543  0024 ea10          	or	a,(16,x)
1544                     ; 493       uip_flags = UIP_POLL;
1545                     ; 494       UIP_APPCALL(); // Check for any data to be sent
1547                     ; 495       goto appsend;
1549  0026 cc00f2        	jp	LC001
1550  0029               L107:
1551                     ; 503   else if (flag == UIP_TIMER) {
1553  0029 7b06          	ld	a,(OFST+1,sp)
1554  002b a102          	cp	a,#2
1555  002d 2703cc0112    	jrne	L507
1556                     ; 505     if (++iss[3] == 0) {
1558  0032 725c0007      	inc	L53_iss+3
1559  0036 2610          	jrne	L117
1560                     ; 506       if (++iss[2] == 0) {
1562  0038 725c0006      	inc	L53_iss+2
1563  003c 260a          	jrne	L117
1564                     ; 507         if (++iss[1] == 0) {
1566  003e 725c0005      	inc	L53_iss+1
1567  0042 2604          	jrne	L117
1568                     ; 508           ++iss[0];
1570  0044 725c0004      	inc	L53_iss
1571  0048               L117:
1572                     ; 514     uip_len = 0;
1574  0048 5f            	clrw	x
1575  0049 cf00cd        	ldw	_uip_len,x
1576                     ; 515     uip_slen = 0;
1578  004c cf000e        	ldw	_uip_slen,x
1579                     ; 520     if (uip_connr->tcpstateflags == UIP_TIME_WAIT || uip_connr->tcpstateflags == UIP_FIN_WAIT_2) {
1581  004f 1e04          	ldw	x,(OFST-1,sp)
1582  0051 e619          	ld	a,(25,x)
1583  0053 a107          	cp	a,#7
1584  0055 2704          	jreq	L127
1586  0057 a105          	cp	a,#5
1587  0059 260d          	jrne	L717
1588  005b               L127:
1589                     ; 521       ++(uip_connr->timer);
1591  005b 6c1a          	inc	(26,x)
1592                     ; 522       if (uip_connr->timer == UIP_TIME_WAIT_TIMEOUT) {
1594  005d e61a          	ld	a,(26,x)
1595  005f a178          	cp	a,#120
1596  0061 26bc          	jrne	L356
1597                     ; 523         uip_connr->tcpstateflags = UIP_CLOSED;
1599  0063 6f19          	clr	(25,x)
1600  0065 cc0923        	jra	L356
1601  0068               L717:
1602                     ; 526     else if (uip_connr->tcpstateflags != UIP_CLOSED) {
1604  0068 e619          	ld	a,(25,x)
1605  006a 27f9          	jreq	L356
1606                     ; 530       if (uip_outstanding(uip_connr)) {
1608  006c e611          	ld	a,(17,x)
1609  006e ea10          	or	a,(16,x)
1610  0070 277a          	jreq	L137
1611                     ; 531         if (uip_connr->timer-- == 0) {
1613  0072 e61a          	ld	a,(26,x)
1614  0074 6a1a          	dec	(26,x)
1615  0076 4d            	tnz	a
1616  0077 26ec          	jrne	L356
1617                     ; 532           if (uip_connr->nrtx == UIP_MAXRTX
1617                     ; 533 	    || ((uip_connr->tcpstateflags == UIP_SYN_SENT
1617                     ; 534             || uip_connr->tcpstateflags == UIP_SYN_RCVD)
1617                     ; 535             && uip_connr->nrtx == UIP_MAXSYNRTX)) {
1619  0079 e61b          	ld	a,(27,x)
1620  007b a108          	cp	a,#8
1621  007d 270f          	jreq	L737
1623  007f e619          	ld	a,(25,x)
1624  0081 a102          	cp	a,#2
1625  0083 2703          	jreq	L147
1627  0085 4a            	dec	a
1628  0086 2616          	jrne	L537
1629  0088               L147:
1631  0088 e61b          	ld	a,(27,x)
1632  008a a105          	cp	a,#5
1633  008c 2610          	jrne	L537
1634  008e               L737:
1635                     ; 536             uip_connr->tcpstateflags = UIP_CLOSED;
1637  008e 6f19          	clr	(25,x)
1638                     ; 539             uip_flags = UIP_TIMEDOUT;
1640  0090 35800022      	mov	_uip_flags,#128
1641                     ; 540             UIP_APPCALL(); // Timeout call. uip_len was cleared above.
1643  0094 cd0000        	call	_uip_TcpAppHubCall
1645                     ; 543             BUF->flags = TCP_RST | TCP_ACK;
1647  0097 35140100      	mov	_uip_buf+47,#20
1648                     ; 544             goto tcp_send_nodata;
1650  009b cc075a        	jra	L736
1651  009e               L537:
1652                     ; 548 	  if (uip_connr->nrtx > 4) uip_connr->nrtx = 4;
1654  009e 1e04          	ldw	x,(OFST-1,sp)
1655  00a0 e61b          	ld	a,(27,x)
1656  00a2 a105          	cp	a,#5
1657  00a4 2504          	jrult	L347
1660  00a6 a604          	ld	a,#4
1661  00a8 e71b          	ld	(27,x),a
1662  00aa               L347:
1663                     ; 549 	  uip_connr->timer = (uint8_t)(UIP_RTO << uip_connr->nrtx);
1665  00aa 5f            	clrw	x
1666  00ab 97            	ld	xl,a
1667  00ac a603          	ld	a,#3
1668  00ae 5d            	tnzw	x
1669  00af 2704          	jreq	L011
1670  00b1               L211:
1671  00b1 48            	sll	a
1672  00b2 5a            	decw	x
1673  00b3 26fc          	jrne	L211
1674  00b5               L011:
1675  00b5 1e04          	ldw	x,(OFST-1,sp)
1676  00b7 e71a          	ld	(26,x),a
1677                     ; 550 	  ++(uip_connr->nrtx);
1679  00b9 6c1b          	inc	(27,x)
1680                     ; 559           switch (uip_connr->tcpstateflags & UIP_TS_MASK) {
1683  00bb e619          	ld	a,(25,x)
1684  00bd a40f          	and	a,#15
1686                     ; 580             case UIP_FIN_WAIT_1:
1686                     ; 581             case UIP_CLOSING:
1686                     ; 582             case UIP_LAST_ACK:
1686                     ; 583               // In all these states we should retransmit a FINACK.
1686                     ; 584               goto tcp_send_finack;
1687  00bf 4a            	dec	a
1688  00c0 2603cc0416    	jreq	L106
1689  00c5 4a            	dec	a
1690  00c6 2714          	jreq	L565
1691  00c8 4a            	dec	a
1692  00c9 2717          	jreq	L765
1693  00cb 4a            	dec	a
1694  00cc 2603cc0756    	jreq	LC004
1695  00d1 a002          	sub	a,#2
1696  00d3 27f9          	jreq	LC004
1697  00d5 a002          	sub	a,#2
1698  00d7 27f5          	jreq	LC004
1699  00d9 cc0923        	jra	L356
1700  00dc               L565:
1701                     ; 565 	    case UIP_SYN_SENT:
1701                     ; 566 	      // In the SYN_SENT state, we retransmit the SYN.
1701                     ; 567 	      BUF->flags = 0;
1703  00dc c70100        	ld	_uip_buf+47,a
1704                     ; 568 	      goto tcp_send_syn;
1706  00df cc041a        	jra	L306
1707  00e2               L765:
1708                     ; 571             case UIP_ESTABLISHED:
1708                     ; 572               // In the ESTABLISHED state, we call upon the application to do
1708                     ; 573 	      // the actual retransmit after which we jump into the code for
1708                     ; 574 	      // sending out the packet (the apprexmit label).
1708                     ; 575               uip_flags = UIP_REXMIT;
1710  00e2 35040022      	mov	_uip_flags,#4
1711                     ; 576               UIP_APPCALL(); // Call to get old data for retransmit.  uip_len
1713  00e6 cd0000        	call	_uip_TcpAppHubCall
1715                     ; 578               goto apprexmit;
1717  00e9 cc079d        	jra	L126
1718                     ; 580             case UIP_FIN_WAIT_1:
1718                     ; 581             case UIP_CLOSING:
1718                     ; 582             case UIP_LAST_ACK:
1718                     ; 583               // In all these states we should retransmit a FINACK.
1718                     ; 584               goto tcp_send_finack;
1720  00ec               L137:
1721                     ; 589       else if ((uip_connr->tcpstateflags & UIP_TS_MASK) == UIP_ESTABLISHED) {
1723  00ec e619          	ld	a,(25,x)
1724  00ee a40f          	and	a,#15
1725  00f0 a103          	cp	a,#3
1726                     ; 592         uip_flags = UIP_POLL;
1728  00f2               LC001:
1729  00f2 26e5          	jrne	L356
1731  00f4 35080022      	mov	_uip_flags,#8
1732                     ; 593         UIP_APPCALL(); // Check for new data to transmit. uip_len was cleared
1735                     ; 595         goto appsend;
1736  00f8               L716:
1741  00f8 cd0000        	call	_uip_TcpAppHubCall
1742                     ; 1178         appsend:
1742                     ; 1179 
1742                     ; 1180         if (uip_flags & UIP_ABORT) {
1744  00fb 720a002203cc  	btjf	_uip_flags,#5,L3521
1745                     ; 1181           uip_slen = 0;
1747  0103 5f            	clrw	x
1748  0104 cf000e        	ldw	_uip_slen,x
1749                     ; 1182           uip_connr->tcpstateflags = UIP_CLOSED;
1751  0107 1e04          	ldw	x,(OFST-1,sp)
1752                     ; 1183           BUF->flags = TCP_RST | TCP_ACK;
1754  0109 35140100      	mov	_uip_buf+47,#20
1755  010d 6f19          	clr	(25,x)
1756                     ; 1184           goto tcp_send_nodata;
1758  010f cc075a        	jra	L736
1759  0112               L507:
1760                     ; 609   if (BUF->vhl != 0x45) { // IP version and header length.
1763  0112 c600df        	ld	a,_uip_buf+14
1764  0115 a145          	cp	a,#69
1765  0117 26c0          	jrne	L356
1766                     ; 612     goto drop;
1770                     ; 622   if ((BUF->len[0] << 8) + BUF->len[1] <= uip_len) {
1772  0119 c600e1        	ld	a,_uip_buf+16
1773  011c 5f            	clrw	x
1774  011d 97            	ld	xl,a
1775  011e 4f            	clr	a
1776  011f cb00e2        	add	a,_uip_buf+17
1777  0122 2401          	jrnc	L021
1778  0124 5c            	incw	x
1779  0125               L021:
1780  0125 02            	rlwa	x,a
1781  0126 c300cd        	cpw	x,_uip_len
1782  0129 22ae          	jrugt	L356
1783                     ; 623     uip_len = (BUF->len[0] << 8) + BUF->len[1];
1785  012b c600e1        	ld	a,_uip_buf+16
1786  012e 5f            	clrw	x
1787  012f 97            	ld	xl,a
1788  0130 4f            	clr	a
1789  0131 cb00e2        	add	a,_uip_buf+17
1790  0134 2401          	jrnc	L221
1791  0136 5c            	incw	x
1792  0137               L221:
1793  0137 c700ce        	ld	_uip_len+1,a
1794  013a 9f            	ld	a,xl
1795  013b c700cd        	ld	_uip_len,a
1797                     ; 628   if ((BUF->ipoffset[0] & 0x3f) != 0 || BUF->ipoffset[1] != 0) {
1799  013e c600e5        	ld	a,_uip_buf+20
1800  0141 a53f          	bcp	a,#63
1801  0143 2694          	jrne	L356
1803  0145 c600e6        	ld	a,_uip_buf+21
1804  0148 268f          	jrne	L356
1805                     ; 635   if (!uip_ipaddr_cmp(BUF->destipaddr, uip_hostaddr)) {
1807  014a ce00ef        	ldw	x,_uip_buf+30
1808  014d c3001e        	cpw	x,_uip_hostaddr
1809  0150 2687          	jrne	L356
1811  0152 ce00f1        	ldw	x,_uip_buf+32
1812  0155 c30020        	cpw	x,_uip_hostaddr+2
1813  0158 2703cc0923    	jrne	L356
1814                     ; 640   if (uip_ipchksum() != 0xffff) { /* Compute and check the IP header checksum. */
1816  015d cd0000        	call	_uip_ipchksum
1818  0160 5c            	incw	x
1819  0161 26f7          	jrne	L356
1820                     ; 643     goto drop;
1824                     ; 646   if (BUF->proto == UIP_PROTO_TCP) {
1826  0163 c600e8        	ld	a,_uip_buf+23
1827  0166 a106          	cp	a,#6
1828  0168 2609          	jrne	L577
1829                     ; 649     goto tcp_input;
1830                     ; 697   if (uip_tcpchksum() != 0xffff) { /* Compute and check the TCP checksum. */
1833  016a cd0000        	call	_uip_tcpchksum
1835  016d 5c            	incw	x
1836  016e 273f          	jreq	L7101
1837                     ; 700     goto drop;
1841  0170 cc0923        	jra	L356
1842  0173               L577:
1843                     ; 654   if (BUF->proto != UIP_PROTO_ICMP) { // We only allow ICMP packets from here.
1845  0173 4a            	dec	a
1846  0174 26fa          	jrne	L356
1847                     ; 657     goto drop;
1851                     ; 665   if (ICMPBUF->type != ICMP_ECHO) {
1854  0176 c600f3        	ld	a,_uip_buf+34
1855  0179 a108          	cp	a,#8
1856  017b 26f3          	jrne	L356
1857                     ; 668     goto drop;
1861                     ; 671   ICMPBUF->type = ICMP_ECHO_REPLY;
1863  017d 725f00f3      	clr	_uip_buf+34
1864                     ; 673   if (ICMPBUF->icmpchksum >= HTONS(0xffff - (ICMP_ECHO << 8))) {
1866  0181 ce00f5        	ldw	x,_uip_buf+36
1867  0184 a3f7ff        	cpw	x,#63487
1868  0187 2505          	jrult	L3001
1869                     ; 674     ICMPBUF->icmpchksum += HTONS(ICMP_ECHO << 8) + 1;
1871  0189 1c0801        	addw	x,#2049
1873  018c 2003          	jra	L7001
1874  018e               L3001:
1875                     ; 677     ICMPBUF->icmpchksum += HTONS(ICMP_ECHO << 8);
1877  018e 1c0800        	addw	x,#2048
1878  0191               L7001:
1879  0191 cf00f5        	ldw	_uip_buf+36,x
1880                     ; 681   uip_ipaddr_copy(BUF->destipaddr, BUF->srcipaddr);
1882  0194 ce00eb        	ldw	x,_uip_buf+26
1883  0197 cf00ef        	ldw	_uip_buf+30,x
1886  019a ce00ed        	ldw	x,_uip_buf+28
1887  019d cf00f1        	ldw	_uip_buf+32,x
1888                     ; 682   uip_ipaddr_copy(BUF->srcipaddr, uip_hostaddr);
1890  01a0 ce001e        	ldw	x,_uip_hostaddr
1891  01a3 cf00eb        	ldw	_uip_buf+26,x
1894  01a6 ce0020        	ldw	x,_uip_hostaddr+2
1895  01a9 cf00ed        	ldw	_uip_buf+28,x
1896                     ; 685   goto send;
1897                     ; 1424   uip_flags = 0;
1899                     ; 1426   return;
1901  01ac cc0927        	jra	L222
1902  01af               L7101:
1903                     ; 705   for (uip_connr = &uip_conns[0]; uip_connr <= &uip_conns[UIP_CONNS - 1]; ++uip_connr) {
1905  01af ae0027        	ldw	x,#_uip_conns
1907  01b2 204d          	jra	L5201
1908  01b4               L1201:
1909                     ; 706     if (uip_connr->tcpstateflags != UIP_CLOSED
1909                     ; 707       && BUF->destport == uip_connr->lport
1909                     ; 708       && BUF->srcport == uip_connr->rport
1909                     ; 709       && uip_ipaddr_cmp(BUF->srcipaddr, uip_connr->ripaddr)) {
1911  01b4 e619          	ld	a,(25,x)
1912  01b6 2746          	jreq	L1301
1914  01b8 9093          	ldw	y,x
1915  01ba 90ee04        	ldw	y,(4,y)
1916  01bd 90c300f5      	cpw	y,_uip_buf+36
1917  01c1 263b          	jrne	L1301
1919  01c3 9093          	ldw	y,x
1920  01c5 90ee06        	ldw	y,(6,y)
1921  01c8 90c300f3      	cpw	y,_uip_buf+34
1922  01cc 2630          	jrne	L1301
1924  01ce 9093          	ldw	y,x
1925  01d0 90fe          	ldw	y,(y)
1926  01d2 90c300eb      	cpw	y,_uip_buf+26
1927  01d6 2626          	jrne	L1301
1929  01d8 9093          	ldw	y,x
1930  01da 90ee02        	ldw	y,(2,y)
1931  01dd 90c300ed      	cpw	y,_uip_buf+28
1932  01e1 261b          	jrne	L1301
1933                     ; 710       goto found;
1934                     ; 903   found:
1934                     ; 904 
1934                     ; 905   // found will be jumped to if we found an active connection.
1934                     ; 906   uip_conn = uip_connr;
1936  01e3 cf00cb        	ldw	_uip_conn,x
1937                     ; 907   uip_flags = 0;
1939  01e6 725f0022      	clr	_uip_flags
1940                     ; 911   if (BUF->flags & TCP_RST) {
1942  01ea 7204010003cc  	btjf	_uip_buf+47,#2,L1411
1943                     ; 912     uip_connr->tcpstateflags = UIP_CLOSED;
1945  01f2 6f19          	clr	(25,x)
1946                     ; 913     uip_flags = UIP_ABORT;
1948  01f4 35200022      	mov	_uip_flags,#32
1949                     ; 919     UIP_APPCALL(); // ????
1951  01f8 cd0000        	call	_uip_TcpAppHubCall
1953                     ; 920     goto drop;
1955  01fb cc0923        	jra	L356
1956  01fe               L1301:
1957                     ; 705   for (uip_connr = &uip_conns[0]; uip_connr <= &uip_conns[UIP_CONNS - 1]; ++uip_connr) {
1959  01fe 1c0029        	addw	x,#41
1960  0201               L5201:
1961  0201 1f04          	ldw	(OFST-1,sp),x
1965  0203 a300a2        	cpw	x,#_uip_conns+123
1966  0206 23ac          	jrule	L1201
1967                     ; 718   if ((BUF->flags & TCP_CTL) != TCP_SYN) {
1969  0208 c60100        	ld	a,_uip_buf+47
1970  020b a43f          	and	a,#63
1971  020d a102          	cp	a,#2
1972  020f 2703cc0685    	jrne	L575
1973                     ; 719     goto reset;
1975                     ; 722   tmp16 = BUF->destport;
1977  0214 ce00f5        	ldw	x,_uip_buf+36
1978  0217 cf0000        	ldw	L34_tmp16,x
1979                     ; 724   for (c = 0; c < UIP_LISTENPORTS; ++c) {
1981  021a 4f            	clr	a
1982  021b c70003        	ld	L73_c,a
1983  021e               L5301:
1984                     ; 725     if (tmp16 == uip_listenports[c]) goto found_listen;
1986  021e 5f            	clrw	x
1987  021f 97            	ld	xl,a
1988  0220 58            	sllw	x
1989  0221 9093          	ldw	y,x
1990  0223 90de000a      	ldw	y,(_uip_listenports,y)
1991  0227 90c30000      	cpw	y,L34_tmp16
1992  022b 261b          	jrne	L3401
1994                     ; 787   found_listen:
1994                     ; 788   // found_listen will be jumped to if we matched the incoming packet with a
1994                     ; 789   // connection in LISTEN. In that case we should create a new connection and
1994                     ; 790   // send a SYNACK in return.
1994                     ; 791   // First we check if there are any connections avaliable. Unused connections
1994                     ; 792   // are kept in the same table as used connections, but unused ones have the
1994                     ; 793   // tcpstate set to CLOSED. Also, connections in TIME_WAIT are kept track of
1994                     ; 794   // and we'll use the oldest one if no CLOSED connections are found. Thanks
1994                     ; 795   // to Eddie C. Dost for a very nice algorithm for the TIME_WAIT search.
1994                     ; 796   uip_connr = 0;
1996  022d 5f            	clrw	x
1997  022e 1f04          	ldw	(OFST-1,sp),x
1999                     ; 797   for (c = 0; c < UIP_CONNS; ++c) {
2001  0230 4f            	clr	a
2002  0231 c70003        	ld	L73_c,a
2003  0234               L5601:
2004                     ; 798     if (uip_conns[c].tcpstateflags == UIP_CLOSED) {
2006  0234 97            	ld	xl,a
2007  0235 a629          	ld	a,#41
2008  0237 42            	mul	x,a
2009  0238 d60040        	ld	a,(_uip_conns+25,x)
2010  023b 2703cc02e3    	jrne	L3701
2011                     ; 799       uip_connr = &uip_conns[c];
2013  0240 1c0027        	addw	x,#_uip_conns
2014  0243 1f04          	ldw	(OFST-1,sp),x
2016                     ; 800       break;
2018  0245 cc0315        	jra	L1701
2019  0248               L3401:
2020                     ; 724   for (c = 0; c < UIP_LISTENPORTS; ++c) {
2022  0248 725c0003      	inc	L73_c
2025  024c c60003        	ld	a,L73_c
2026  024f a102          	cp	a,#2
2027  0251 25cb          	jrult	L5301
2029  0253 cc0685        	jra	L575
2030  0256               L5401:
2031                     ; 740   BUF->flags = TCP_RST | TCP_ACK;
2034  0256 35140100      	mov	_uip_buf+47,#20
2035                     ; 741   uip_len = UIP_IPTCPH_LEN;
2037  025a ae0028        	ldw	x,#40
2038  025d cf00cd        	ldw	_uip_len,x
2039                     ; 742   BUF->tcpoffset = 5 << 4;
2041  0260 355000ff      	mov	_uip_buf+46,#80
2042                     ; 745   c = BUF->seqno[3];
2044  0264 5500fa0003    	mov	L73_c,_uip_buf+41
2045                     ; 746   BUF->seqno[3] = BUF->ackno[3];
2047  0269 5500fe00fa    	mov	_uip_buf+41,_uip_buf+45
2048                     ; 747   BUF->ackno[3] = c;
2050  026e 55000300fe    	mov	_uip_buf+45,L73_c
2051                     ; 749   c = BUF->seqno[2];
2053  0273 5500f90003    	mov	L73_c,_uip_buf+40
2054                     ; 750   BUF->seqno[2] = BUF->ackno[2];
2056  0278 5500fd00f9    	mov	_uip_buf+40,_uip_buf+44
2057                     ; 751   BUF->ackno[2] = c;
2059  027d 55000300fd    	mov	_uip_buf+44,L73_c
2060                     ; 753   c = BUF->seqno[1];
2062  0282 5500f80003    	mov	L73_c,_uip_buf+39
2063                     ; 754   BUF->seqno[1] = BUF->ackno[1];
2065  0287 5500fc00f8    	mov	_uip_buf+39,_uip_buf+43
2066                     ; 755   BUF->ackno[1] = c;
2068  028c 55000300fc    	mov	_uip_buf+43,L73_c
2069                     ; 757   c = BUF->seqno[0];
2071  0291 5500f70003    	mov	L73_c,_uip_buf+38
2072                     ; 758   BUF->seqno[0] = BUF->ackno[0];
2074  0296 5500fb00f7    	mov	_uip_buf+38,_uip_buf+42
2075                     ; 759   BUF->ackno[0] = c;
2077  029b 55000300fb    	mov	_uip_buf+42,L73_c
2078                     ; 764   if (++BUF->ackno[3] == 0) {
2080  02a0 725c00fe      	inc	_uip_buf+45
2081  02a4 2610          	jrne	L7401
2082                     ; 765     if (++BUF->ackno[2] == 0) {
2084  02a6 725c00fd      	inc	_uip_buf+44
2085  02aa 260a          	jrne	L7401
2086                     ; 766       if (++BUF->ackno[1] == 0) {
2088  02ac 725c00fc      	inc	_uip_buf+43
2089  02b0 2604          	jrne	L7401
2090                     ; 767         ++BUF->ackno[0];
2092  02b2 725c00fb      	inc	_uip_buf+42
2093  02b6               L7401:
2094                     ; 773   tmp16 = BUF->srcport;
2096  02b6 ce00f3        	ldw	x,_uip_buf+34
2097  02b9 cf0000        	ldw	L34_tmp16,x
2098                     ; 774   BUF->srcport = BUF->destport;
2100  02bc ce00f5        	ldw	x,_uip_buf+36
2101  02bf cf00f3        	ldw	_uip_buf+34,x
2102                     ; 775   BUF->destport = tmp16;
2104  02c2 ce0000        	ldw	x,L34_tmp16
2105  02c5 cf00f5        	ldw	_uip_buf+36,x
2106                     ; 778   uip_ipaddr_copy(BUF->destipaddr, BUF->srcipaddr);
2108  02c8 ce00eb        	ldw	x,_uip_buf+26
2109  02cb cf00ef        	ldw	_uip_buf+30,x
2112  02ce ce00ed        	ldw	x,_uip_buf+28
2113  02d1 cf00f1        	ldw	_uip_buf+32,x
2114                     ; 779   uip_ipaddr_copy(BUF->srcipaddr, uip_hostaddr);
2116  02d4 ce001e        	ldw	x,_uip_hostaddr
2117  02d7 cf00eb        	ldw	_uip_buf+26,x
2120  02da ce0020        	ldw	x,_uip_hostaddr+2
2121  02dd cf00ed        	ldw	_uip_buf+28,x
2122                     ; 782   goto tcp_send_noconn;
2124  02e0 cc08d4        	jra	L546
2125  02e3               L3701:
2126                     ; 802     if (uip_conns[c].tcpstateflags == UIP_TIME_WAIT) {
2128  02e3 a107          	cp	a,#7
2129  02e5 2620          	jrne	L5701
2130                     ; 803       if (uip_connr == 0 || uip_conns[c].timer > uip_connr->timer) {
2132  02e7 1e04          	ldw	x,(OFST-1,sp)
2133  02e9 2710          	jreq	L1011
2135  02eb c60003        	ld	a,L73_c
2136  02ee 97            	ld	xl,a
2137  02ef a629          	ld	a,#41
2138  02f1 42            	mul	x,a
2139  02f2 d60041        	ld	a,(_uip_conns+26,x)
2140  02f5 1e04          	ldw	x,(OFST-1,sp)
2141  02f7 e11a          	cp	a,(26,x)
2142  02f9 230c          	jrule	L5701
2143  02fb               L1011:
2144                     ; 804         uip_connr = &uip_conns[c];
2146  02fb c60003        	ld	a,L73_c
2147  02fe 97            	ld	xl,a
2148  02ff a629          	ld	a,#41
2149  0301 42            	mul	x,a
2150  0302 1c0027        	addw	x,#_uip_conns
2151  0305 1f04          	ldw	(OFST-1,sp),x
2153  0307               L5701:
2154                     ; 797   for (c = 0; c < UIP_CONNS; ++c) {
2156  0307 725c0003      	inc	L73_c
2159  030b c60003        	ld	a,L73_c
2160  030e a104          	cp	a,#4
2161  0310 2403cc0234    	jrult	L5601
2162  0315               L1701:
2163                     ; 809   if (uip_connr == 0) {
2165  0315 1e04          	ldw	x,(OFST-1,sp)
2166  0317 2603cc0923    	jreq	L356
2167                     ; 814     goto drop;
2170                     ; 816   uip_conn = uip_connr;
2172  031c cf00cb        	ldw	_uip_conn,x
2173                     ; 819   uip_connr->rto = uip_connr->timer = UIP_RTO;
2175  031f a603          	ld	a,#3
2176  0321 e71a          	ld	(26,x),a
2177  0323 e718          	ld	(24,x),a
2178                     ; 820   uip_connr->sa = 0;
2180  0325 6f16          	clr	(22,x)
2181                     ; 821   uip_connr->sv = 4;
2183  0327 4c            	inc	a
2184  0328 e717          	ld	(23,x),a
2185                     ; 822   uip_connr->nrtx = 0;
2187  032a 6f1b          	clr	(27,x)
2188                     ; 823   uip_connr->lport = BUF->destport;
2190  032c 90ce00f5      	ldw	y,_uip_buf+36
2191  0330 ef04          	ldw	(4,x),y
2192                     ; 824   uip_connr->rport = BUF->srcport;
2194  0332 90ce00f3      	ldw	y,_uip_buf+34
2195  0336 ef06          	ldw	(6,x),y
2196                     ; 825   uip_ipaddr_copy(uip_connr->ripaddr, BUF->srcipaddr);
2198  0338 90ce00eb      	ldw	y,_uip_buf+26
2199  033c ff            	ldw	(x),y
2202  033d 90ce00ed      	ldw	y,_uip_buf+28
2203  0341 ef02          	ldw	(2,x),y
2204                     ; 826   uip_connr->tcpstateflags = UIP_SYN_RCVD;
2206  0343 a601          	ld	a,#1
2207  0345 e719          	ld	(25,x),a
2208                     ; 828   uip_connr->snd_nxt[0] = iss[0];
2210  0347 c60004        	ld	a,L53_iss
2211  034a e70c          	ld	(12,x),a
2212                     ; 829   uip_connr->snd_nxt[1] = iss[1];
2214  034c c60005        	ld	a,L53_iss+1
2215  034f e70d          	ld	(13,x),a
2216                     ; 830   uip_connr->snd_nxt[2] = iss[2];
2218  0351 c60006        	ld	a,L53_iss+2
2219  0354 e70e          	ld	(14,x),a
2220                     ; 831   uip_connr->snd_nxt[3] = iss[3];
2222  0356 c60007        	ld	a,L53_iss+3
2223  0359 e70f          	ld	(15,x),a
2224                     ; 832   uip_connr->len = 1;
2226  035b 90ae0001      	ldw	y,#1
2227  035f ef10          	ldw	(16,x),y
2228                     ; 835   uip_connr->rcv_nxt[3] = BUF->seqno[3];
2230  0361 c600fa        	ld	a,_uip_buf+41
2231  0364 e70b          	ld	(11,x),a
2232                     ; 836   uip_connr->rcv_nxt[2] = BUF->seqno[2];
2234  0366 c600f9        	ld	a,_uip_buf+40
2235  0369 e70a          	ld	(10,x),a
2236                     ; 837   uip_connr->rcv_nxt[1] = BUF->seqno[1];
2238  036b c600f8        	ld	a,_uip_buf+39
2239  036e e709          	ld	(9,x),a
2240                     ; 838   uip_connr->rcv_nxt[0] = BUF->seqno[0];
2242  0370 c600f7        	ld	a,_uip_buf+38
2243  0373 e708          	ld	(8,x),a
2244                     ; 839   uip_add_rcv_nxt(1);
2246  0375 ae0001        	ldw	x,#1
2247  0378 cd0000        	call	L545_uip_add_rcv_nxt
2249                     ; 842   if ((BUF->tcpoffset & 0xf0) > 0x50) {
2251  037b c600ff        	ld	a,_uip_buf+46
2252  037e a4f0          	and	a,#240
2253  0380 a151          	cp	a,#81
2254  0382 2403cc0416    	jrult	L106
2255                     ; 843     for (c = 0; c < ((BUF->tcpoffset >> 4) - 5) << 2;) {
2257  0387 725f0003      	clr	L73_c
2259  038b 206b          	jra	L7111
2260  038d               L3111:
2261                     ; 844       opt = uip_buf[UIP_TCPIP_HLEN + UIP_LLH_LEN + c];
2263  038d 5f            	clrw	x
2264  038e 97            	ld	xl,a
2265  038f d60107        	ld	a,(_uip_buf+54,x)
2266  0392 c70002        	ld	L14_opt,a
2267                     ; 845       if (opt == TCP_OPT_END) {
2269  0395 277f          	jreq	L106
2270                     ; 847         break;
2272                     ; 849       else if (opt == TCP_OPT_NOOP) {
2274  0397 a101          	cp	a,#1
2275  0399 2606          	jrne	L7211
2276                     ; 850         ++c;
2278  039b 725c0003      	inc	L73_c
2280  039f 2057          	jra	L7111
2281  03a1               L7211:
2282                     ; 853       else if (opt == TCP_OPT_MSS
2282                     ; 854         && uip_buf[UIP_TCPIP_HLEN + UIP_LLH_LEN + 1 + c] == TCP_OPT_MSS_LEN) {
2284  03a1 a102          	cp	a,#2
2285  03a3 2640          	jrne	L3311
2287  03a5 c60003        	ld	a,L73_c
2288  03a8 5f            	clrw	x
2289  03a9 97            	ld	xl,a
2290  03aa d60108        	ld	a,(_uip_buf+55,x)
2291  03ad a104          	cp	a,#4
2292  03af 2634          	jrne	L3311
2293                     ; 856         tmp16 = ((uint16_t)uip_buf[UIP_TCPIP_HLEN + UIP_LLH_LEN + 2 + c] << 8)
2293                     ; 857 	        | (uint16_t)uip_buf[UIP_IPTCPH_LEN + UIP_LLH_LEN + 3 + c];
2295  03b1 c60003        	ld	a,L73_c
2296  03b4 5f            	clrw	x
2297  03b5 97            	ld	xl,a
2298  03b6 d6010a        	ld	a,(_uip_buf+57,x)
2299  03b9 5f            	clrw	x
2300  03ba 97            	ld	xl,a
2301  03bb 1f01          	ldw	(OFST-4,sp),x
2303  03bd 5f            	clrw	x
2304  03be c60003        	ld	a,L73_c
2305  03c1 97            	ld	xl,a
2306  03c2 d60109        	ld	a,(_uip_buf+56,x)
2307  03c5 5f            	clrw	x
2308  03c6 97            	ld	xl,a
2309  03c7 7b02          	ld	a,(OFST-3,sp)
2310  03c9 01            	rrwa	x,a
2311  03ca 1a01          	or	a,(OFST-4,sp)
2312  03cc 01            	rrwa	x,a
2313  03cd cf0000        	ldw	L34_tmp16,x
2314                     ; 858         uip_connr->initialmss = uip_connr->mss = tmp16 > UIP_TCP_MSS ? UIP_TCP_MSS : tmp16;
2316  03d0 a301b9        	cpw	x,#441
2317  03d3 2503          	jrult	L231
2318  03d5 ae01b8        	ldw	x,#440
2319  03d8               L231:
2320  03d8 1604          	ldw	y,(OFST-1,sp)
2321  03da 90ef12        	ldw	(18,y),x
2322  03dd 93            	ldw	x,y
2323  03de 90ee12        	ldw	y,(18,y)
2324  03e1 ef14          	ldw	(20,x),y
2325                     ; 861         break;
2327  03e3 2031          	jra	L106
2328  03e5               L3311:
2329                     ; 866         if (uip_buf[UIP_TCPIP_HLEN + UIP_LLH_LEN + 1 + c] == 0) {
2331  03e5 c60003        	ld	a,L73_c
2332  03e8 5f            	clrw	x
2333  03e9 97            	ld	xl,a
2334  03ea 724d0108      	tnz	(_uip_buf+55,x)
2335  03ee 2726          	jreq	L106
2336                     ; 869           break;
2338                     ; 871         c += uip_buf[UIP_TCPIP_HLEN + UIP_LLH_LEN + 1 + c];
2340  03f0 5f            	clrw	x
2341  03f1 97            	ld	xl,a
2342  03f2 db0108        	add	a,(_uip_buf+55,x)
2343  03f5 c70003        	ld	L73_c,a
2344  03f8               L7111:
2345                     ; 843     for (c = 0; c < ((BUF->tcpoffset >> 4) - 5) << 2;) {
2347  03f8 c600ff        	ld	a,_uip_buf+46
2348  03fb 4e            	swap	a
2349  03fc a40f          	and	a,#15
2350  03fe 5f            	clrw	x
2351  03ff 97            	ld	xl,a
2352  0400 58            	sllw	x
2353  0401 58            	sllw	x
2354  0402 1d0014        	subw	x,#20
2355  0405 c60003        	ld	a,L73_c
2356  0408 905f          	clrw	y
2357  040a 9097          	ld	yl,a
2358  040c 90bf00        	ldw	c_y,y
2359  040f b300          	cpw	x,c_y
2360  0411 2d03cc038d    	jrsgt	L3111
2361  0416               L106:
2362                     ; 879   tcp_send_synack:
2362                     ; 880   BUF->flags = TCP_ACK;
2364  0416 35100100      	mov	_uip_buf+47,#16
2365  041a               L306:
2366                     ; 882   tcp_send_syn:
2366                     ; 883   BUF->flags |= TCP_SYN;
2368  041a 72120100      	bset	_uip_buf+47,#1
2369                     ; 892   BUF->optdata[0] = TCP_OPT_MSS;
2371  041e 35020107      	mov	_uip_buf+54,#2
2372                     ; 893   BUF->optdata[1] = TCP_OPT_MSS_LEN;
2374  0422 35040108      	mov	_uip_buf+55,#4
2375                     ; 894   BUF->optdata[2] = (UIP_TCP_MSS) / 256;
2377  0426 35010109      	mov	_uip_buf+56,#1
2378                     ; 895   BUF->optdata[3] = (UIP_TCP_MSS) & 255;
2380  042a 35b8010a      	mov	_uip_buf+57,#184
2381                     ; 896   uip_len = UIP_IPTCPH_LEN + TCP_OPT_MSS_LEN;
2383  042e ae002c        	ldw	x,#44
2384  0431 cf00cd        	ldw	_uip_len,x
2385                     ; 897   BUF->tcpoffset = ((UIP_TCPH_LEN + TCP_OPT_MSS_LEN) / 4) << 4;
2387  0434 356000ff      	mov	_uip_buf+46,#96
2388                     ; 898   goto tcp_send;
2390  0438 cc07d4        	jra	L346
2391  043b               L1411:
2392                     ; 934   c = (uint8_t)((BUF->tcpoffset >> 4) << 2);
2394  043b c600ff        	ld	a,_uip_buf+46
2395  043e 4e            	swap	a
2396  043f a40f          	and	a,#15
2397  0441 48            	sll	a
2398  0442 48            	sll	a
2399  0443 c70003        	ld	L73_c,a
2400                     ; 938   uip_len = uip_len - c - UIP_IPH_LEN;
2402  0446 c600cd        	ld	a,_uip_len
2403  0449 97            	ld	xl,a
2404  044a c600ce        	ld	a,_uip_len+1
2405  044d c00003        	sub	a,L73_c
2406  0450 2401          	jrnc	L041
2407  0452 5a            	decw	x
2408  0453               L041:
2409  0453 02            	rlwa	x,a
2410  0454 1d0014        	subw	x,#20
2411  0457 cf00cd        	ldw	_uip_len,x
2412                     ; 942   if (!(((uip_connr->tcpstateflags & UIP_TS_MASK) == UIP_SYN_SENT)
2412                     ; 943     && ((BUF->flags & TCP_CTL) == (TCP_SYN | TCP_ACK)))) {
2414  045a 1e04          	ldw	x,(OFST-1,sp)
2415  045c e619          	ld	a,(25,x)
2416  045e a40f          	and	a,#15
2417  0460 a102          	cp	a,#2
2418  0462 2609          	jrne	L5411
2420  0464 c60100        	ld	a,_uip_buf+47
2421  0467 a43f          	and	a,#63
2422  0469 a112          	cp	a,#18
2423  046b 272d          	jreq	L3411
2424  046d               L5411:
2425                     ; 945     if ((uip_len > 0 || ((BUF->flags & (TCP_SYN | TCP_FIN)) != 0))
2425                     ; 946       && (BUF->seqno[0] != uip_connr->rcv_nxt[0]
2425                     ; 947       || BUF->seqno[1] != uip_connr->rcv_nxt[1]
2425                     ; 948       || BUF->seqno[2] != uip_connr->rcv_nxt[2]
2425                     ; 949       || BUF->seqno[3] != uip_connr->rcv_nxt[3])) {
2427  046d ce00cd        	ldw	x,_uip_len
2428  0470 2607          	jrne	L1511
2430  0472 c60100        	ld	a,_uip_buf+47
2431  0475 a503          	bcp	a,#3
2432  0477 2721          	jreq	L3411
2433  0479               L1511:
2435  0479 1e04          	ldw	x,(OFST-1,sp)
2436  047b e608          	ld	a,(8,x)
2437  047d c100f7        	cp	a,_uip_buf+38
2438  0480 2703cc08c5    	jrne	L536
2440  0485 e609          	ld	a,(9,x)
2441  0487 c100f8        	cp	a,_uip_buf+39
2442  048a 26f6          	jrne	L536
2444  048c e60a          	ld	a,(10,x)
2445  048e c100f9        	cp	a,_uip_buf+40
2446  0491 26ef          	jrne	L536
2448  0493 e60b          	ld	a,(11,x)
2449  0495 c100fa        	cp	a,_uip_buf+41
2450  0498 26e8          	jrne	L536
2451  049a               L3411:
2452                     ; 957   if ((BUF->flags & TCP_ACK) && uip_outstanding(uip_connr)) {
2454  049a 7208010003cc  	btjf	_uip_buf+47,#4,L1611
2456  04a2 1e04          	ldw	x,(OFST-1,sp)
2457  04a4 e611          	ld	a,(17,x)
2458  04a6 ea10          	or	a,(16,x)
2459  04a8 27f5          	jreq	L1611
2460                     ; 958     uip_add32(uip_connr->snd_nxt, uip_connr->len);
2462  04aa ee10          	ldw	x,(16,x)
2463  04ac 89            	pushw	x
2464  04ad 1e06          	ldw	x,(OFST+1,sp)
2465  04af 1c000c        	addw	x,#12
2466  04b2 cd0000        	call	_uip_add32
2468  04b5 c600fb        	ld	a,_uip_buf+42
2469  04b8 c10023        	cp	a,_uip_acc32
2470  04bb 85            	popw	x
2471                     ; 959     if (BUF->ackno[0] == uip_acc32[0]
2471                     ; 960       && BUF->ackno[1] == uip_acc32[1]
2471                     ; 961       && BUF->ackno[2] == uip_acc32[2]
2471                     ; 962       && BUF->ackno[3] == uip_acc32[3]) {
2473  04bc 26e1          	jrne	L1611
2475  04be c600fc        	ld	a,_uip_buf+43
2476  04c1 c10024        	cp	a,_uip_acc32+1
2477  04c4 26d9          	jrne	L1611
2479  04c6 c600fd        	ld	a,_uip_buf+44
2480  04c9 c10025        	cp	a,_uip_acc32+2
2481  04cc 26d1          	jrne	L1611
2483  04ce c600fe        	ld	a,_uip_buf+45
2484  04d1 c10026        	cp	a,_uip_acc32+3
2485  04d4 2679          	jrne	L1611
2486                     ; 964       uip_connr->snd_nxt[0] = uip_acc32[0];
2488  04d6 1e04          	ldw	x,(OFST-1,sp)
2489  04d8 c60023        	ld	a,_uip_acc32
2490  04db e70c          	ld	(12,x),a
2491                     ; 965       uip_connr->snd_nxt[1] = uip_acc32[1];
2493  04dd c60024        	ld	a,_uip_acc32+1
2494  04e0 e70d          	ld	(13,x),a
2495                     ; 966       uip_connr->snd_nxt[2] = uip_acc32[2];
2497  04e2 c60025        	ld	a,_uip_acc32+2
2498  04e5 e70e          	ld	(14,x),a
2499                     ; 967       uip_connr->snd_nxt[3] = uip_acc32[3];
2501  04e7 c60026        	ld	a,_uip_acc32+3
2502  04ea e70f          	ld	(15,x),a
2503                     ; 970       if (uip_connr->nrtx == 0) {
2505  04ec e61b          	ld	a,(27,x)
2506  04ee 2653          	jrne	L5611
2507                     ; 972         m = (int8_t)(uip_connr->rto - uip_connr->timer);
2509  04f0 e61a          	ld	a,(26,x)
2510  04f2 e018          	sub	a,(24,x)
2511  04f4 40            	neg	a
2512  04f5 6b03          	ld	(OFST-2,sp),a
2514                     ; 974         m = (int8_t)(m - (uip_connr->sa >> 3));
2516  04f7 e616          	ld	a,(22,x)
2517  04f9 44            	srl	a
2518  04fa 44            	srl	a
2519  04fb 44            	srl	a
2520  04fc 5f            	clrw	x
2521  04fd 97            	ld	xl,a
2522  04fe 1f01          	ldw	(OFST-4,sp),x
2524  0500 5f            	clrw	x
2525  0501 7b03          	ld	a,(OFST-2,sp)
2526  0503 4d            	tnz	a
2527  0504 2a01          	jrpl	L441
2528  0506 53            	cplw	x
2529  0507               L441:
2530  0507 97            	ld	xl,a
2531  0508 72f001        	subw	x,(OFST-4,sp)
2532  050b 01            	rrwa	x,a
2533  050c 6b03          	ld	(OFST-2,sp),a
2535                     ; 975         uip_connr->sa += m;
2537  050e 1e04          	ldw	x,(OFST-1,sp)
2538  0510 e616          	ld	a,(22,x)
2539  0512 1b03          	add	a,(OFST-2,sp)
2540  0514 e716          	ld	(22,x),a
2541                     ; 976         if (m < 0) m = (int8_t)(-m);
2543  0516 7b03          	ld	a,(OFST-2,sp)
2544  0518 2a02          	jrpl	L7611
2547  051a 0003          	neg	(OFST-2,sp)
2549  051c               L7611:
2550                     ; 977         m = (int8_t)(m - (uip_connr->sv >> 2));
2552  051c e617          	ld	a,(23,x)
2553  051e 44            	srl	a
2554  051f 44            	srl	a
2555  0520 5f            	clrw	x
2556  0521 97            	ld	xl,a
2557  0522 1f01          	ldw	(OFST-4,sp),x
2559  0524 5f            	clrw	x
2560  0525 7b03          	ld	a,(OFST-2,sp)
2561  0527 4d            	tnz	a
2562  0528 2a01          	jrpl	L641
2563  052a 53            	cplw	x
2564  052b               L641:
2565  052b 97            	ld	xl,a
2566  052c 72f001        	subw	x,(OFST-4,sp)
2567  052f 01            	rrwa	x,a
2568  0530 6b03          	ld	(OFST-2,sp),a
2570                     ; 978         uip_connr->sv += m;
2572  0532 1e04          	ldw	x,(OFST-1,sp)
2573  0534 e617          	ld	a,(23,x)
2574  0536 1b03          	add	a,(OFST-2,sp)
2575  0538 e717          	ld	(23,x),a
2576                     ; 979         uip_connr->rto = (uint8_t)((uip_connr->sa >> 3) + uip_connr->sv);
2578  053a e616          	ld	a,(22,x)
2579  053c 44            	srl	a
2580  053d 44            	srl	a
2581  053e 44            	srl	a
2582  053f eb17          	add	a,(23,x)
2583  0541 e718          	ld	(24,x),a
2584  0543               L5611:
2585                     ; 982       uip_flags = UIP_ACKDATA;
2587  0543 35010022      	mov	_uip_flags,#1
2588                     ; 984       uip_connr->timer = uip_connr->rto;
2590  0547 e618          	ld	a,(24,x)
2591  0549 e71a          	ld	(26,x),a
2592                     ; 987       uip_connr->len = 0;
2594  054b 905f          	clrw	y
2595  054d ef10          	ldw	(16,x),y
2596  054f               L1611:
2597                     ; 992   switch (uip_connr->tcpstateflags & UIP_TS_MASK) {
2599  054f 1e04          	ldw	x,(OFST-1,sp)
2600  0551 e619          	ld	a,(25,x)
2601  0553 a40f          	and	a,#15
2603                     ; 1328 	uip_connr->timer = 0;
2604  0555 4a            	dec	a
2605  0556 272a          	jreq	L706
2606  0558 4a            	dec	a
2607  0559 2748          	jreq	L116
2608  055b 4a            	dec	a
2609  055c 2603cc0690    	jreq	L316
2610  0561 4a            	dec	a
2611  0562 2603cc084e    	jreq	L526
2612  0567 4a            	dec	a
2613  0568 2603cc088d    	jreq	L726
2614  056d 4a            	dec	a
2615  056e 2603cc08b8    	jreq	L336
2616  0573 4a            	dec	a
2617  0574 2603cc08c5    	jreq	L536
2618  0579 4a            	dec	a
2619  057a 2603cc083d    	jreq	L326
2620  057f cc0923        	jra	L356
2621  0582               L706:
2622                     ; 996     case UIP_SYN_RCVD:
2622                     ; 997       // In SYN_RCVD we have sent out a SYNACK in response to a SYN, and we
2622                     ; 998       // are waiting for an ACK that acknowledges the data we sent out the
2622                     ; 999       // last time. Therefore, we want to have the UIP_ACKDATA flag set. If
2622                     ; 1000       // so, we enter the ESTABLISHED state.
2622                     ; 1001       if (uip_flags & UIP_ACKDATA) {
2624  0582 72010022f8    	btjf	_uip_flags,#0,L356
2625                     ; 1002         uip_connr->tcpstateflags = UIP_ESTABLISHED;
2627  0587 a603          	ld	a,#3
2628  0589 e719          	ld	(25,x),a
2629                     ; 1003         uip_flags = UIP_CONNECTED;
2631  058b 35400022      	mov	_uip_flags,#64
2632                     ; 1004         uip_connr->len = 0;
2634  058f 905f          	clrw	y
2635  0591 ef10          	ldw	(16,x),y
2636                     ; 1005         if (uip_len > 0) {
2638  0593 ce00cd        	ldw	x,_uip_len
2639  0596 2707          	jreq	L7711
2640                     ; 1006           uip_flags |= UIP_NEWDATA;
2642  0598 72120022      	bset	_uip_flags,#1
2643                     ; 1007           uip_add_rcv_nxt(uip_len);
2645  059c cd0000        	call	L545_uip_add_rcv_nxt
2647  059f               L7711:
2648                     ; 1009         uip_slen = 0;
2651  059f 5f            	clrw	x
2652                     ; 1010         UIP_APPCALL(); // We may have received data with the SYN
2654                     ; 1011         goto appsend;
2656  05a0 cc0673        	jp	LC002
2657  05a3               L116:
2658                     ; 1017     case UIP_SYN_SENT:
2658                     ; 1018       // In SYN_SENT, we wait for a SYNACK that is sent in response to our
2658                     ; 1019       // SYN. The rcv_nxt is set to sequence number in the SYNACK plus one,
2658                     ; 1020       // and we send an ACK. We move into the ESTABLISHED state.
2658                     ; 1021       if((uip_flags & UIP_ACKDATA) &&
2658                     ; 1022         (BUF->flags & TCP_CTL) == (TCP_SYN | TCP_ACK)) {
2660  05a3 7200002203cc  	btjf	_uip_flags,#0,L1021
2662  05ab c60100        	ld	a,_uip_buf+47
2663  05ae a43f          	and	a,#63
2664  05b0 a112          	cp	a,#18
2665  05b2 26f4          	jrne	L1021
2666                     ; 1024         if((BUF->tcpoffset & 0xf0) > 0x50) {
2668  05b4 c600ff        	ld	a,_uip_buf+46
2669  05b7 a4f0          	and	a,#240
2670  05b9 a151          	cp	a,#81
2671  05bb 2403cc0645    	jrult	L3021
2672                     ; 1025 	  for(c = 0; c < ((BUF->tcpoffset >> 4) - 5) << 2 ;) {
2674  05c0 725f0003      	clr	L73_c
2676  05c4 2064          	jra	L1121
2677  05c6               L5021:
2678                     ; 1026 	    opt = uip_buf[UIP_IPTCPH_LEN + UIP_LLH_LEN + c];
2680  05c6 5f            	clrw	x
2681  05c7 97            	ld	xl,a
2682  05c8 d60107        	ld	a,(_uip_buf+54,x)
2683  05cb c70002        	ld	L14_opt,a
2684                     ; 1027 	    if(opt == TCP_OPT_END) {
2686  05ce 2775          	jreq	L3021
2687                     ; 1029 	      break;
2689                     ; 1031 	    else if(opt == TCP_OPT_NOOP) {
2691  05d0 a101          	cp	a,#1
2692  05d2 2606          	jrne	L1221
2693                     ; 1032 	      ++c;
2695  05d4 725c0003      	inc	L73_c
2697  05d8 2050          	jra	L1121
2698  05da               L1221:
2699                     ; 1035 	    else if(opt == TCP_OPT_MSS &&
2699                     ; 1036 	      uip_buf[UIP_TCPIP_HLEN + UIP_LLH_LEN + 1 + c] == TCP_OPT_MSS_LEN) {
2701  05da a102          	cp	a,#2
2702  05dc 2639          	jrne	L5221
2704  05de c60003        	ld	a,L73_c
2705  05e1 5f            	clrw	x
2706  05e2 97            	ld	xl,a
2707  05e3 d60108        	ld	a,(_uip_buf+55,x)
2708  05e6 a104          	cp	a,#4
2709  05e8 262d          	jrne	L5221
2710                     ; 1038 	      tmp16 = (uip_buf[UIP_TCPIP_HLEN + UIP_LLH_LEN + 2 + c] << 8) |
2710                     ; 1039 	        uip_buf[UIP_TCPIP_HLEN + UIP_LLH_LEN + 3 + c];
2712  05ea c60003        	ld	a,L73_c
2713  05ed 5f            	clrw	x
2714  05ee 97            	ld	xl,a
2715  05ef d60109        	ld	a,(_uip_buf+56,x)
2716  05f2 97            	ld	xl,a
2717  05f3 c60003        	ld	a,L73_c
2718  05f6 905f          	clrw	y
2719  05f8 9097          	ld	yl,a
2720  05fa 90d6010a      	ld	a,(_uip_buf+57,y)
2721  05fe 02            	rlwa	x,a
2722  05ff cf0000        	ldw	L34_tmp16,x
2723                     ; 1040 	      uip_connr->initialmss =
2723                     ; 1041 	        uip_connr->mss = tmp16 > UIP_TCP_MSS? UIP_TCP_MSS: tmp16;
2725  0602 a301b9        	cpw	x,#441
2726  0605 2503          	jrult	L451
2727  0607 ae01b8        	ldw	x,#440
2728  060a               L451:
2729  060a 1604          	ldw	y,(OFST-1,sp)
2730  060c 90ef12        	ldw	(18,y),x
2731  060f 93            	ldw	x,y
2732  0610 90ee12        	ldw	y,(18,y)
2733  0613 ef14          	ldw	(20,x),y
2734                     ; 1044 	      break;
2736  0615 202e          	jra	L3021
2737  0617               L5221:
2738                     ; 1049 	      if(uip_buf[UIP_TCPIP_HLEN + UIP_LLH_LEN + 1 + c] == 0) {
2740  0617 c60003        	ld	a,L73_c
2741  061a 5f            	clrw	x
2742  061b 97            	ld	xl,a
2743  061c 724d0108      	tnz	(_uip_buf+55,x)
2744  0620 2723          	jreq	L3021
2745                     ; 1052 	        break;
2747                     ; 1054 	      c += uip_buf[UIP_TCPIP_HLEN + UIP_LLH_LEN + 1 + c];
2749  0622 5f            	clrw	x
2750  0623 97            	ld	xl,a
2751  0624 db0108        	add	a,(_uip_buf+55,x)
2752  0627 c70003        	ld	L73_c,a
2753  062a               L1121:
2754                     ; 1025 	  for(c = 0; c < ((BUF->tcpoffset >> 4) - 5) << 2 ;) {
2756  062a c600ff        	ld	a,_uip_buf+46
2757  062d 4e            	swap	a
2758  062e a40f          	and	a,#15
2759  0630 5f            	clrw	x
2760  0631 97            	ld	xl,a
2761  0632 58            	sllw	x
2762  0633 58            	sllw	x
2763  0634 1d0014        	subw	x,#20
2764  0637 c60003        	ld	a,L73_c
2765  063a 905f          	clrw	y
2766  063c 9097          	ld	yl,a
2767  063e 90bf00        	ldw	c_y,y
2768  0641 b300          	cpw	x,c_y
2769  0643 2c81          	jrsgt	L5021
2770  0645               L3021:
2771                     ; 1058         uip_connr->tcpstateflags = UIP_ESTABLISHED;
2773  0645 1e04          	ldw	x,(OFST-1,sp)
2774  0647 a603          	ld	a,#3
2775  0649 e719          	ld	(25,x),a
2776                     ; 1059         uip_connr->rcv_nxt[0] = BUF->seqno[0];
2778  064b c600f7        	ld	a,_uip_buf+38
2779  064e e708          	ld	(8,x),a
2780                     ; 1060         uip_connr->rcv_nxt[1] = BUF->seqno[1];
2782  0650 c600f8        	ld	a,_uip_buf+39
2783  0653 e709          	ld	(9,x),a
2784                     ; 1061         uip_connr->rcv_nxt[2] = BUF->seqno[2];
2786  0655 c600f9        	ld	a,_uip_buf+40
2787  0658 e70a          	ld	(10,x),a
2788                     ; 1062         uip_connr->rcv_nxt[3] = BUF->seqno[3];
2790  065a c600fa        	ld	a,_uip_buf+41
2791  065d e70b          	ld	(11,x),a
2792                     ; 1063         uip_add_rcv_nxt(1);
2794  065f ae0001        	ldw	x,#1
2795  0662 cd0000        	call	L545_uip_add_rcv_nxt
2797                     ; 1068         uip_flags = UIP_CONNECTED | UIP_NEWDATA;
2799  0665 35420022      	mov	_uip_flags,#66
2800                     ; 1069         uip_connr->len = 0;
2802  0669 1e04          	ldw	x,(OFST-1,sp)
2803  066b 905f          	clrw	y
2804  066d ef10          	ldw	(16,x),y
2805                     ; 1070         uip_len = 0;
2807  066f 5f            	clrw	x
2808  0670 cf00cd        	ldw	_uip_len,x
2809                     ; 1071         uip_slen = 0;
2811  0673               LC002:
2812  0673 cf000e        	ldw	_uip_slen,x
2813                     ; 1072         UIP_APPCALL(); // This checks to see if there is any data to send with
2815                     ; 1075         goto appsend;
2817  0676 cc00f8        	jra	L716
2818  0679               L1021:
2819                     ; 1078       uip_flags = UIP_ABORT;
2821  0679 35200022      	mov	_uip_flags,#32
2822                     ; 1082       UIP_APPCALL(); // ???
2824  067d cd0000        	call	_uip_TcpAppHubCall
2826                     ; 1084       uip_conn->tcpstateflags = UIP_CLOSED;
2828  0680 ce00cb        	ldw	x,_uip_conn
2829  0683 6f19          	clr	(25,x)
2830                     ; 1085       goto reset;
2831  0685               L575:
2832                     ; 734   reset:
2832                     ; 735   // We do not send resets in response to resets.
2832                     ; 736   if (BUF->flags & TCP_RST) goto drop;
2834  0685 7204010003cc  	btjf	_uip_buf+47,#2,L5401
2837  068d cc0923        	jra	L356
2838  0690               L316:
2839                     ; 1089     case UIP_ESTABLISHED:
2839                     ; 1090       // In the ESTABLISHED state, we call upon the application to feed data
2839                     ; 1091       // into the uip_buf. If the UIP_ACKDATA flag is set, the application
2839                     ; 1092       // should put new data into the buffer, otherwise we are retransmitting
2839                     ; 1093       // an old segment, and the application should put that data into the
2839                     ; 1094       // buffer.
2839                     ; 1095       //
2839                     ; 1096       // If the incoming packet is a FIN, we should close the connection on
2839                     ; 1097       // this side as well, and we send out a FIN and enter the LAST_ACK
2839                     ; 1098       // state. We require that there is no outstanding data; otherwise the
2839                     ; 1099       // sequence numbers will be screwed up.
2839                     ; 1100       if (BUF->flags & TCP_FIN && !(uip_connr->tcpstateflags & UIP_STOPPED)) {
2841  0690 7201010030    	btjf	_uip_buf+47,#0,L3321
2843  0695 e619          	ld	a,(25,x)
2844  0697 a510          	bcp	a,#16
2845  0699 262a          	jrne	L3321
2846                     ; 1101         if (uip_outstanding(uip_connr)) {
2848  069b e611          	ld	a,(17,x)
2849  069d ea10          	or	a,(16,x)
2850  069f 26ec          	jrne	L356
2851                     ; 1102           goto drop;
2853                     ; 1104         uip_add_rcv_nxt(1 + uip_len);
2855  06a1 ce00cd        	ldw	x,_uip_len
2856  06a4 5c            	incw	x
2857  06a5 cd0000        	call	L545_uip_add_rcv_nxt
2859                     ; 1105         uip_flags |= UIP_CLOSE;
2861  06a8 72180022      	bset	_uip_flags,#4
2862                     ; 1106         if (uip_len > 0) {
2864  06ac ce00cd        	ldw	x,_uip_len
2865  06af 2704          	jreq	L7321
2866                     ; 1107           uip_flags |= UIP_NEWDATA;
2868  06b1 72120022      	bset	_uip_flags,#1
2869  06b5               L7321:
2870                     ; 1109         UIP_APPCALL(); // This processes any receive data and sets up any
2872  06b5 cd0000        	call	_uip_TcpAppHubCall
2874                     ; 1111 	uip_connr->len = 1;
2876  06b8 1e04          	ldw	x,(OFST-1,sp)
2877  06ba 90ae0001      	ldw	y,#1
2878  06be ef10          	ldw	(16,x),y
2879                     ; 1112         uip_connr->tcpstateflags = UIP_LAST_ACK;
2881  06c0 a608          	ld	a,#8
2882                     ; 1113         uip_connr->nrtx = 0;
2883                     ; 1115         tcp_send_finack:
2883                     ; 1116 	BUF->flags = TCP_FIN | TCP_ACK;
2884                     ; 1117         goto tcp_send_nodata;
2886  06c2 cc0752        	jp	LC006
2887  06c5               L3321:
2888                     ; 1122       if ((BUF->flags & TCP_URG) != 0) {
2890  06c5 720b01001f    	btjf	_uip_buf+47,#5,L1421
2891                     ; 1123         uip_appdata = ((char *)uip_appdata) + ((BUF->urgp[0] << 8) | BUF->urgp[1]);
2893  06ca c60105        	ld	a,_uip_buf+52
2894  06cd 97            	ld	xl,a
2895  06ce c60106        	ld	a,_uip_buf+53
2896  06d1 02            	rlwa	x,a
2897  06d2 72bb00cf      	addw	x,_uip_appdata
2898  06d6 cf00cf        	ldw	_uip_appdata,x
2899                     ; 1124         uip_len -= (BUF->urgp[0] << 8) | BUF->urgp[1];
2901  06d9 c60105        	ld	a,_uip_buf+52
2902  06dc 97            	ld	xl,a
2903  06dd c60106        	ld	a,_uip_buf+53
2904  06e0 02            	rlwa	x,a
2905  06e1 72b000cd      	subw	x,_uip_len
2906  06e5 50            	negw	x
2907  06e6 cf00cd        	ldw	_uip_len,x
2908  06e9               L1421:
2909                     ; 1132       if (uip_len > 0 && !(uip_connr->tcpstateflags & UIP_STOPPED)) {
2911  06e9 ce00cd        	ldw	x,_uip_len
2912  06ec 2712          	jreq	L3421
2914  06ee 1e04          	ldw	x,(OFST-1,sp)
2915  06f0 e619          	ld	a,(25,x)
2916  06f2 a510          	bcp	a,#16
2917  06f4 260a          	jrne	L3421
2918                     ; 1133         uip_flags |= UIP_NEWDATA;
2920  06f6 72120022      	bset	_uip_flags,#1
2921                     ; 1134         uip_add_rcv_nxt(uip_len);
2923  06fa ce00cd        	ldw	x,_uip_len
2924  06fd cd0000        	call	L545_uip_add_rcv_nxt
2926  0700               L3421:
2927                     ; 1147       tmp16 = ((uint16_t)BUF->wnd[0] << 8) + (uint16_t)BUF->wnd[1];
2929  0700 c60102        	ld	a,_uip_buf+49
2930  0703 5f            	clrw	x
2931  0704 97            	ld	xl,a
2932  0705 1f01          	ldw	(OFST-4,sp),x
2934  0707 c60101        	ld	a,_uip_buf+48
2935  070a 97            	ld	xl,a
2936  070b 4f            	clr	a
2937  070c 02            	rlwa	x,a
2938  070d 72fb01        	addw	x,(OFST-4,sp)
2939  0710 cf0000        	ldw	L34_tmp16,x
2940                     ; 1148       if (tmp16 > uip_connr->initialmss || tmp16 == 0) {
2942  0713 1604          	ldw	y,(OFST-1,sp)
2943  0715 90ee14        	ldw	y,(20,y)
2944  0718 90c30000      	cpw	y,L34_tmp16
2945  071c 2505          	jrult	L7421
2947  071e ce0000        	ldw	x,L34_tmp16
2948  0721 2607          	jrne	L5421
2949  0723               L7421:
2950                     ; 1149         tmp16 = uip_connr->initialmss;
2952  0723 1e04          	ldw	x,(OFST-1,sp)
2953  0725 ee14          	ldw	x,(20,x)
2954  0727 cf0000        	ldw	L34_tmp16,x
2955  072a               L5421:
2956                     ; 1151       uip_connr->mss = tmp16;
2958  072a 1e04          	ldw	x,(OFST-1,sp)
2959  072c 90ce0000      	ldw	y,L34_tmp16
2960  0730 ef12          	ldw	(18,x),y
2961                     ; 1168       if (uip_flags & (UIP_NEWDATA | UIP_ACKDATA)) {
2963  0732 c60022        	ld	a,_uip_flags
2964  0735 a503          	bcp	a,#3
2965  0737 2603cc0923    	jreq	L356
2966                     ; 1169         uip_slen = 0;
2967                     ; 1170         UIP_APPCALL(); // Here is where the application will read data that
2969  073c cc059f        	jp	L7711
2970  073f               L3521:
2971                     ; 1187         if (uip_flags & UIP_CLOSE) {
2973  073f 720900221e    	btjf	_uip_flags,#4,L5521
2974                     ; 1188           uip_slen = 0;
2976  0744 5f            	clrw	x
2977  0745 cf000e        	ldw	_uip_slen,x
2978                     ; 1189 	  uip_connr->len = 1;
2980  0748 1e04          	ldw	x,(OFST-1,sp)
2981  074a 90ae0001      	ldw	y,#1
2982  074e ef10          	ldw	(16,x),y
2983                     ; 1190 	  uip_connr->tcpstateflags = UIP_FIN_WAIT_1;
2985  0750 a604          	ld	a,#4
2986                     ; 1191 	  uip_connr->nrtx = 0;
2988  0752               LC006:
2989  0752 e719          	ld	(25,x),a
2991  0754 6f1b          	clr	(27,x)
2992                     ; 1192 	  BUF->flags = TCP_FIN | TCP_ACK;
2994  0756               LC004:
2996  0756 35110100      	mov	_uip_buf+47,#17
2997                     ; 1193 	  goto tcp_send_nodata;
2998  075a               L736:
2999                     ; 1342   tcp_send_nodata:
2999                     ; 1343   uip_len = UIP_IPTCPH_LEN;
3001  075a ae0028        	ldw	x,#40
3002  075d cf00cd        	ldw	_uip_len,x
3003  0760 206e          	jra	L146
3004  0762               L5521:
3005                     ; 1197         if (uip_slen > 0) {
3007  0762 ce000e        	ldw	x,_uip_slen
3008  0765 2732          	jreq	L7521
3009                     ; 1200 	  if ((uip_flags & UIP_ACKDATA) != 0) {
3011  0767 7201002206    	btjf	_uip_flags,#0,L1621
3012                     ; 1201 	    uip_connr->len = 0;
3014  076c 1e04          	ldw	x,(OFST-1,sp)
3015  076e 905f          	clrw	y
3016  0770 ef10          	ldw	(16,x),y
3017  0772               L1621:
3018                     ; 1206 	  if (uip_connr->len == 0) {
3020  0772 1e04          	ldw	x,(OFST-1,sp)
3021  0774 e611          	ld	a,(17,x)
3022  0776 ea10          	or	a,(16,x)
3023  0778 261a          	jrne	L3621
3024                     ; 1209 	    if (uip_slen > uip_connr->mss) {
3026  077a 9093          	ldw	y,x
3027  077c 90ee12        	ldw	y,(18,y)
3028  077f 90c3000e      	cpw	y,_uip_slen
3029  0783 2407          	jruge	L5621
3030                     ; 1210 	      uip_slen = uip_connr->mss;
3032  0785 ee12          	ldw	x,(18,x)
3033  0787 cf000e        	ldw	_uip_slen,x
3034  078a 1e04          	ldw	x,(OFST-1,sp)
3035  078c               L5621:
3036                     ; 1215             uip_connr->len = uip_slen;
3038  078c 90ce000e      	ldw	y,_uip_slen
3039  0790 ef10          	ldw	(16,x),y
3041  0792 2005          	jra	L7521
3042  0794               L3621:
3043                     ; 1221 	    uip_slen = uip_connr->len;
3045  0794 ee10          	ldw	x,(16,x)
3046  0796 cf000e        	ldw	_uip_slen,x
3047  0799               L7521:
3048                     ; 1224 	uip_connr->nrtx = 0;
3050  0799 1e04          	ldw	x,(OFST-1,sp)
3051  079b 6f1b          	clr	(27,x)
3052  079d               L126:
3053                     ; 1229 	apprexmit:
3053                     ; 1230 	uip_appdata = uip_sappdata;
3055  079d ce0010        	ldw	x,_uip_sappdata
3056  07a0 cf00cf        	ldw	_uip_appdata,x
3057                     ; 1234 	if (uip_slen > 0 && uip_connr->len > 0) {
3059  07a3 ce000e        	ldw	x,_uip_slen
3060  07a6 2716          	jreq	L1721
3062  07a8 1e04          	ldw	x,(OFST-1,sp)
3063  07aa e611          	ld	a,(17,x)
3064  07ac ea10          	or	a,(16,x)
3065  07ae 270e          	jreq	L1721
3066                     ; 1236 	  uip_len = uip_connr->len + UIP_TCPIP_HLEN;
3068  07b0 ee10          	ldw	x,(16,x)
3069  07b2 1c0028        	addw	x,#40
3070  07b5 cf00cd        	ldw	_uip_len,x
3071                     ; 1238 	  BUF->flags = TCP_ACK | TCP_PSH;
3073  07b8 35180100      	mov	_uip_buf+47,#24
3074                     ; 1240 	  goto tcp_send_noopts;
3076  07bc 2012          	jra	L146
3077  07be               L1721:
3078                     ; 1244 	if (uip_flags & UIP_NEWDATA) {
3080  07be 7202002203cc  	btjf	_uip_flags,#1,L356
3081                     ; 1245 	  uip_len = UIP_TCPIP_HLEN;
3083  07c6 ae0028        	ldw	x,#40
3084  07c9 cf00cd        	ldw	_uip_len,x
3085                     ; 1246 	  BUF->flags = TCP_ACK;
3087  07cc 35100100      	mov	_uip_buf+47,#16
3088                     ; 1247 	  goto tcp_send_noopts;
3089  07d0               L146:
3090                     ; 1345   tcp_send_noopts:
3090                     ; 1346   BUF->tcpoffset = (UIP_TCPH_LEN / 4) << 4;
3092  07d0 355000ff      	mov	_uip_buf+46,#80
3093  07d4               L346:
3094                     ; 1351   tcp_send:
3094                     ; 1352   // We're done with the input processing. We are now ready to send a reply.
3094                     ; 1353   // Our job is to fill in all the fields of the TCP and IP headers before
3094                     ; 1354   // calculating the checksum and finally send the packet.
3094                     ; 1355   BUF->ackno[0] = uip_connr->rcv_nxt[0];
3096  07d4 1e04          	ldw	x,(OFST-1,sp)
3097  07d6 e608          	ld	a,(8,x)
3098  07d8 c700fb        	ld	_uip_buf+42,a
3099                     ; 1356   BUF->ackno[1] = uip_connr->rcv_nxt[1];
3101  07db e609          	ld	a,(9,x)
3102  07dd c700fc        	ld	_uip_buf+43,a
3103                     ; 1357   BUF->ackno[2] = uip_connr->rcv_nxt[2];
3105  07e0 e60a          	ld	a,(10,x)
3106  07e2 c700fd        	ld	_uip_buf+44,a
3107                     ; 1358   BUF->ackno[3] = uip_connr->rcv_nxt[3];
3109  07e5 e60b          	ld	a,(11,x)
3110  07e7 c700fe        	ld	_uip_buf+45,a
3111                     ; 1360   BUF->seqno[0] = uip_connr->snd_nxt[0];
3113  07ea e60c          	ld	a,(12,x)
3114  07ec c700f7        	ld	_uip_buf+38,a
3115                     ; 1361   BUF->seqno[1] = uip_connr->snd_nxt[1];
3117  07ef e60d          	ld	a,(13,x)
3118  07f1 c700f8        	ld	_uip_buf+39,a
3119                     ; 1362   BUF->seqno[2] = uip_connr->snd_nxt[2];
3121  07f4 e60e          	ld	a,(14,x)
3122  07f6 c700f9        	ld	_uip_buf+40,a
3123                     ; 1363   BUF->seqno[3] = uip_connr->snd_nxt[3];
3125  07f9 e60f          	ld	a,(15,x)
3126  07fb c700fa        	ld	_uip_buf+41,a
3127                     ; 1365   BUF->proto = UIP_PROTO_TCP;
3129  07fe 350600e8      	mov	_uip_buf+23,#6
3130                     ; 1367   BUF->srcport = uip_connr->lport;
3132  0802 ee04          	ldw	x,(4,x)
3133  0804 cf00f3        	ldw	_uip_buf+34,x
3134                     ; 1368   BUF->destport = uip_connr->rport;
3136  0807 1e04          	ldw	x,(OFST-1,sp)
3137  0809 ee06          	ldw	x,(6,x)
3138  080b cf00f5        	ldw	_uip_buf+36,x
3139                     ; 1370   uip_ipaddr_copy(BUF->srcipaddr, uip_hostaddr);
3141  080e ce001e        	ldw	x,_uip_hostaddr
3142  0811 cf00eb        	ldw	_uip_buf+26,x
3145  0814 ce0020        	ldw	x,_uip_hostaddr+2
3146  0817 cf00ed        	ldw	_uip_buf+28,x
3147                     ; 1371   uip_ipaddr_copy(BUF->destipaddr, uip_connr->ripaddr);
3149  081a 1e04          	ldw	x,(OFST-1,sp)
3150  081c fe            	ldw	x,(x)
3151  081d cf00ef        	ldw	_uip_buf+30,x
3154  0820 1e04          	ldw	x,(OFST-1,sp)
3155  0822 ee02          	ldw	x,(2,x)
3156  0824 cf00f1        	ldw	_uip_buf+32,x
3157                     ; 1373   if (uip_connr->tcpstateflags & UIP_STOPPED) {
3159  0827 1e04          	ldw	x,(OFST-1,sp)
3160  0829 e619          	ld	a,(25,x)
3161  082b a510          	bcp	a,#16
3162  082d 2603cc08cc    	jreq	L5331
3163                     ; 1376     BUF->wnd[0] = BUF->wnd[1] = 0;
3165  0832 725f0102      	clr	_uip_buf+49
3166  0836 725f0101      	clr	_uip_buf+48
3168  083a cc08d4        	jra	L546
3169  083d               L326:
3170                     ; 1252     case UIP_LAST_ACK:
3170                     ; 1253       // We can close this connection if the peer has acknowledged our FIN.
3170                     ; 1254       // This is indicated by the UIP_ACKDATA flag.
3170                     ; 1255       if (uip_flags & UIP_ACKDATA) {
3172  083d 7201002281    	btjf	_uip_flags,#0,L356
3173                     ; 1256         uip_connr->tcpstateflags = UIP_CLOSED;
3175  0842 e719          	ld	(25,x),a
3176                     ; 1257 	uip_flags = UIP_CLOSE;
3178  0844 35100022      	mov	_uip_flags,#16
3179                     ; 1262 	UIP_APPCALL(); // ???
3181  0848 cd0000        	call	_uip_TcpAppHubCall
3183  084b cc0923        	jra	L356
3184  084e               L526:
3185                     ; 1266     case UIP_FIN_WAIT_1:
3185                     ; 1267       // The application has closed the connection, but the remote host hasn't
3185                     ; 1268       // closed its end yet. Thus we do nothing but wait for a FIN from the
3185                     ; 1269       // other side.
3185                     ; 1270       if (uip_len > 0) {
3187  084e ce00cd        	ldw	x,_uip_len
3188  0851 2703          	jreq	L7721
3189                     ; 1271         uip_add_rcv_nxt(uip_len);
3191  0853 cd0000        	call	L545_uip_add_rcv_nxt
3193  0856               L7721:
3194                     ; 1273       if (BUF->flags & TCP_FIN) {
3196  0856 7201010019    	btjf	_uip_buf+47,#0,L1031
3197                     ; 1274         if (uip_flags & UIP_ACKDATA) {
3199  085b 1e04          	ldw	x,(OFST-1,sp)
3200  085d 720100220c    	btjf	_uip_flags,#0,L3031
3201                     ; 1275 	  uip_connr->tcpstateflags = UIP_TIME_WAIT;
3203  0862 a607          	ld	a,#7
3204  0864 e719          	ld	(25,x),a
3205                     ; 1276 	  uip_connr->timer = 0;
3207  0866 6f1a          	clr	(26,x)
3208                     ; 1277 	  uip_connr->len = 0;
3210  0868 905f          	clrw	y
3211  086a ef10          	ldw	(16,x),y
3213  086c 2034          	jra	LC005
3214  086e               L3031:
3215                     ; 1280           uip_connr->tcpstateflags = UIP_CLOSING;
3217  086e a606          	ld	a,#6
3218  0870 e719          	ld	(25,x),a
3219                     ; 1282         uip_add_rcv_nxt(1);
3221                     ; 1283         uip_flags = UIP_CLOSE;
3222                     ; 1288         UIP_APPCALL(); // ???
3224                     ; 1289         goto tcp_send_ack;
3226  0872 202e          	jp	LC005
3227  0874               L1031:
3228                     ; 1291       else if (uip_flags & UIP_ACKDATA) {
3230  0874 720100220d    	btjf	_uip_flags,#0,L7031
3231                     ; 1292         uip_connr->tcpstateflags = UIP_FIN_WAIT_2;
3233  0879 1e04          	ldw	x,(OFST-1,sp)
3234  087b a605          	ld	a,#5
3235  087d e719          	ld	(25,x),a
3236                     ; 1293         uip_connr->len = 0;
3238  087f 905f          	clrw	y
3239  0881 ef10          	ldw	(16,x),y
3240                     ; 1294         goto drop;
3242  0883 cc0923        	jra	L356
3243  0886               L7031:
3244                     ; 1296       if (uip_len > 0) {
3246  0886 ce00cd        	ldw	x,_uip_len
3247  0889 27f8          	jreq	L356
3248                     ; 1297         goto tcp_send_ack;
3250  088b 2038          	jra	L536
3251  088d               L726:
3252                     ; 1301     case UIP_FIN_WAIT_2:
3252                     ; 1302       if (uip_len > 0) {
3254  088d ce00cd        	ldw	x,_uip_len
3255  0890 2703          	jreq	L5131
3256                     ; 1303 	uip_add_rcv_nxt(uip_len);
3258  0892 cd0000        	call	L545_uip_add_rcv_nxt
3260  0895               L5131:
3261                     ; 1305       if (BUF->flags & TCP_FIN) {
3263  0895 7201010017    	btjf	_uip_buf+47,#0,L7131
3264                     ; 1306 	uip_connr->tcpstateflags = UIP_TIME_WAIT;
3266  089a 1e04          	ldw	x,(OFST-1,sp)
3267  089c a607          	ld	a,#7
3268  089e e719          	ld	(25,x),a
3269                     ; 1307 	uip_connr->timer = 0;
3271  08a0 6f1a          	clr	(26,x)
3272                     ; 1308 	uip_add_rcv_nxt(1);
3275                     ; 1309 	uip_flags = UIP_CLOSE;
3277                     ; 1314 	UIP_APPCALL(); // ???
3279  08a2               LC005:
3281  08a2 ae0001        	ldw	x,#1
3282  08a5 cd0000        	call	L545_uip_add_rcv_nxt
3284  08a8 35100022      	mov	_uip_flags,#16
3286  08ac cd0000        	call	_uip_TcpAppHubCall
3288                     ; 1315 	goto tcp_send_ack;
3290  08af 2014          	jra	L536
3291  08b1               L7131:
3292                     ; 1317       if (uip_len > 0) {
3294  08b1 ce00cd        	ldw	x,_uip_len
3295  08b4 276d          	jreq	L356
3296                     ; 1318 	goto tcp_send_ack;
3298  08b6 200d          	jra	L536
3299  08b8               L336:
3300                     ; 1325     case UIP_CLOSING:
3300                     ; 1326       if (uip_flags & UIP_ACKDATA) {
3302  08b8 7201002266    	btjf	_uip_flags,#0,L356
3303                     ; 1327 	uip_connr->tcpstateflags = UIP_TIME_WAIT;
3305  08bd a607          	ld	a,#7
3306  08bf e719          	ld	(25,x),a
3307                     ; 1328 	uip_connr->timer = 0;
3309  08c1 6f1a          	clr	(26,x)
3310  08c3 205e          	jra	L356
3311                     ; 1331   goto drop;
3313  08c5               L536:
3314                     ; 1337   tcp_send_ack:
3314                     ; 1338   // We jump here when we are ready to send the packet, and just want to set
3314                     ; 1339   // the appropriate TCP sequence numbers in the TCP header.
3314                     ; 1340   BUF->flags = TCP_ACK;
3316  08c5 35100100      	mov	_uip_buf+47,#16
3317  08c9 cc075a        	jra	L736
3318  08cc               L5331:
3319                     ; 1381     BUF->wnd[0] = ((UIP_RECEIVE_WINDOW) >> 8);
3321  08cc 35010101      	mov	_uip_buf+48,#1
3322                     ; 1382     BUF->wnd[1] = ((UIP_RECEIVE_WINDOW) & 0xff);
3324  08d0 35b80102      	mov	_uip_buf+49,#184
3325  08d4               L546:
3326                     ; 1389   tcp_send_noconn:
3326                     ; 1390   BUF->ttl = UIP_TTL;
3328  08d4 354000e7      	mov	_uip_buf+22,#64
3329                     ; 1391   BUF->len[0] = (uint8_t)(uip_len >> 8);
3331  08d8 5500cd00e1    	mov	_uip_buf+16,_uip_len
3332                     ; 1392   BUF->len[1] = (uint8_t)(uip_len & 0xff);
3334  08dd 5500ce00e2    	mov	_uip_buf+17,_uip_len+1
3335                     ; 1394   BUF->urgp[0] = BUF->urgp[1] = 0;
3337  08e2 725f0106      	clr	_uip_buf+53
3338  08e6 725f0105      	clr	_uip_buf+52
3339                     ; 1397   BUF->tcpchksum = 0;
3341  08ea 5f            	clrw	x
3342  08eb cf0103        	ldw	_uip_buf+50,x
3343                     ; 1398   BUF->tcpchksum = ~(uip_tcpchksum());
3345  08ee cd0000        	call	_uip_tcpchksum
3347  08f1 53            	cplw	x
3348  08f2 cf0103        	ldw	_uip_buf+50,x
3349                     ; 1403   ip_send_nolen:
3349                     ; 1404 
3349                     ; 1405   BUF->vhl = 0x45;
3351  08f5 354500df      	mov	_uip_buf+14,#69
3352                     ; 1406   BUF->tos = 0;
3354  08f9 725f00e0      	clr	_uip_buf+15
3355                     ; 1407   BUF->ipoffset[0] = BUF->ipoffset[1] = 0;
3357  08fd 725f00e6      	clr	_uip_buf+21
3358  0901 725f00e5      	clr	_uip_buf+20
3359                     ; 1408   ++ipid;
3361  0905 ce0008        	ldw	x,L11_ipid
3362  0908 5c            	incw	x
3363  0909 cf0008        	ldw	L11_ipid,x
3364                     ; 1409   BUF->ipid[0] = (uint8_t)(ipid >> 8);
3366  090c 55000800e3    	mov	_uip_buf+18,L11_ipid
3367                     ; 1410   BUF->ipid[1] = (uint8_t)(ipid & 0xff);
3369  0911 55000900e4    	mov	_uip_buf+19,L11_ipid+1
3370                     ; 1412   BUF->ipchksum = 0;
3372  0916 5f            	clrw	x
3373  0917 cf00e9        	ldw	_uip_buf+24,x
3374                     ; 1413   BUF->ipchksum = ~(uip_ipchksum());
3376  091a cd0000        	call	_uip_ipchksum
3378  091d 53            	cplw	x
3379  091e cf00e9        	ldw	_uip_buf+24,x
3381  0921 2004          	jra	L222
3382  0923               L356:
3383                     ; 1430   drop:
3383                     ; 1431   uip_len = 0;
3385  0923 5f            	clrw	x
3386  0924 cf00cd        	ldw	_uip_len,x
3387                     ; 1432   uip_flags = 0;
3389                     ; 1433   return;
3390  0927               L222:
3392  0927 725f0022      	clr	_uip_flags
3395  092b 5b06          	addw	sp,#6
3396  092d 81            	ret	
3428                     ; 1438 uint16_t htons(uint16_t val)
3428                     ; 1439 {
3429                     .text:	section	.text,new
3430  0000               _htons:
3434                     ; 1440   return HTONS(val);
3438  0000 81            	ret	
3483                     ; 1446 void uip_send(const char *data, int len)
3483                     ; 1447 {
3484                     .text:	section	.text,new
3485  0000               _uip_send:
3487  0000 89            	pushw	x
3488       00000000      OFST:	set	0
3491                     ; 1448   if (len > 0) {
3493  0001 9c            	rvf	
3494  0002 1e05          	ldw	x,(OFST+5,sp)
3495  0004 2d1c          	jrsle	L032
3496                     ; 1449     uip_slen = len;
3498  0006 cf000e        	ldw	_uip_slen,x
3499                     ; 1450     if (data != uip_sappdata) {
3501  0009 1e01          	ldw	x,(OFST+1,sp)
3502  000b c30010        	cpw	x,_uip_sappdata
3503  000e 2712          	jreq	L032
3504                     ; 1451       memcpy(uip_sappdata, (data), uip_slen);
3506  0010 bf00          	ldw	c_x,x
3507  0012 ce000e        	ldw	x,_uip_slen
3508  0015 270b          	jreq	L032
3509  0017               L232:
3510  0017 5a            	decw	x
3511  0018 92d600        	ld	a,([c_x.w],x)
3512  001b 72d70010      	ld	([_uip_sappdata.w],x),a
3513  001f 5d            	tnzw	x
3514  0020 26f5          	jrne	L232
3515  0022               L032:
3516                     ; 1454 }
3519  0022 85            	popw	x
3520  0023 81            	ret	
3735                     	switch	.bss
3736  0000               L34_tmp16:
3737  0000 0000          	ds.b	2
3738  0002               L14_opt:
3739  0002 00            	ds.b	1
3740  0003               L73_c:
3741  0003 00            	ds.b	1
3742  0004               L53_iss:
3743  0004 00000000      	ds.b	4
3744  0008               L11_ipid:
3745  0008 0000          	ds.b	2
3746  000a               _uip_listenports:
3747  000a 00000000      	ds.b	4
3748                     	xdef	_uip_listenports
3749  000e               _uip_slen:
3750  000e 0000          	ds.b	2
3751                     	xdef	_uip_slen
3752  0010               _uip_sappdata:
3753  0010 0000          	ds.b	2
3754                     	xdef	_uip_sappdata
3755                     	xdef	_uip_ethaddr
3756                     	xdef	_uip_add32
3757                     	xdef	_uip_tcpchksum
3758                     	xdef	_uip_ipchksum
3759                     	xdef	_uip_chksum
3760  0012               _uip_mqttserveraddr:
3761  0012 00000000      	ds.b	4
3762                     	xdef	_uip_mqttserveraddr
3763  0016               _uip_draddr:
3764  0016 00000000      	ds.b	4
3765                     	xdef	_uip_draddr
3766  001a               _uip_netmask:
3767  001a 00000000      	ds.b	4
3768                     	xdef	_uip_netmask
3769  001e               _uip_hostaddr:
3770  001e 00000000      	ds.b	4
3771                     	xdef	_uip_hostaddr
3772                     	xdef	_uip_process
3773  0022               _uip_flags:
3774  0022 00            	ds.b	1
3775                     	xdef	_uip_flags
3776  0023               _uip_acc32:
3777  0023 00000000      	ds.b	4
3778                     	xdef	_uip_acc32
3779  0027               _uip_conns:
3780  0027 000000000000  	ds.b	164
3781                     	xdef	_uip_conns
3782  00cb               _uip_conn:
3783  00cb 0000          	ds.b	2
3784                     	xdef	_uip_conn
3785  00cd               _uip_len:
3786  00cd 0000          	ds.b	2
3787                     	xdef	_uip_len
3788  00cf               _uip_appdata:
3789  00cf 0000          	ds.b	2
3790                     	xdef	_uip_appdata
3791                     	xdef	_htons
3792                     	xdef	_uip_send
3793                     	xdef	_uip_connect
3794                     	xdef	_uip_unlisten
3795                     	xdef	_uip_listen
3796  00d1               _uip_buf:
3797  00d1 000000000000  	ds.b	502
3798                     	xdef	_uip_buf
3799                     	xdef	_uip_setipid
3800                     	xdef	_uip_init_stats
3801                     	xdef	_uip_init
3802                     	xref	_uip_TcpAppHubCall
3803                     	xref.b	c_x
3804                     	xref.b	c_y
3824                     	end
