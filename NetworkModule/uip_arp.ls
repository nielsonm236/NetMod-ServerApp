   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Parser V4.11.14 - 18 Nov 2019
   3                     ; Generator (Limited) V4.4.11 - 19 Nov 2019
   4                     ; Optimizer V4.4.11 - 19 Nov 2019
  18                     .const:	section	.text
  19  0000               L11_broadcast_ethaddr:
  20  0000 ff            	dc.b	255
  21  0001 ff            	dc.b	255
  22  0002 ff            	dc.b	255
  23  0003 ff            	dc.b	255
  24  0004 ff            	dc.b	255
  25  0005 ff            	dc.b	255
  26  0006               L31_broadcast_ipaddr:
  27  0006 ffff          	dc.w	-1
  28  0008 ffff          	dc.w	-1
  60                     ; 144 uip_arp_init(void)
  60                     ; 145 {
  62                     .text:	section	.text,new
  63  0000               _uip_arp_init:
  67                     ; 148   for(i = 0; i < UIP_ARPTAB_SIZE; ++i) {
  69  0000 4f            	clr	a
  70  0001 c70003        	ld	L12_i,a
  71  0004               L74:
  72                     ; 149     memset(arp_table[i].ipaddr, 0, 4);
  74  0004 97            	ld	xl,a
  75  0005 a60b          	ld	a,#11
  76  0007 42            	mul	x,a
  77  0008 1c0008        	addw	x,#L51_arp_table
  78  000b bf00          	ldw	c_x,x
  79  000d ae0004        	ldw	x,#4
  80  0010               L6:
  81  0010 5a            	decw	x
  82  0011 926f00        	clr	([c_x.w],x)
  83  0014 5d            	tnzw	x
  84  0015 26f9          	jrne	L6
  85                     ; 148   for(i = 0; i < UIP_ARPTAB_SIZE; ++i) {
  87  0017 725c0003      	inc	L12_i
  90  001b c60003        	ld	a,L12_i
  91  001e a104          	cp	a,#4
  92  0020 25e2          	jrult	L74
  93                     ; 151 }
  96  0022 81            	ret	
 188                     ; 166 uip_arp_timer(void)
 188                     ; 167 {
 189                     .text:	section	.text,new
 190  0000               _uip_arp_timer:
 192  0000 89            	pushw	x
 193       00000002      OFST:	set	2
 196                     ; 170   ++arptime;
 198  0001 725c0001      	inc	L52_arptime
 199                     ; 171   for(i = 0; i < UIP_ARPTAB_SIZE; ++i) {
 201  0005 4f            	clr	a
 202  0006 c70003        	ld	L12_i,a
 203  0009               L321:
 204                     ; 172     tabptr = &arp_table[i];
 206  0009 97            	ld	xl,a
 207  000a a60b          	ld	a,#11
 208  000c 42            	mul	x,a
 209  000d 1c0008        	addw	x,#L51_arp_table
 210  0010 1f01          	ldw	(OFST-1,sp),x
 212                     ; 173     if((tabptr->ipaddr[0] | tabptr->ipaddr[1]) != 0 &&
 212                     ; 174        arptime - tabptr->time >= UIP_ARP_MAXAGE) {
 214  0012 1601          	ldw	y,(OFST-1,sp)
 215  0014 ee02          	ldw	x,(2,x)
 216  0016 01            	rrwa	x,a
 217  0017 90ea01        	or	a,(1,y)
 218  001a 01            	rrwa	x,a
 219  001b 90fa          	or	a,(y)
 220  001d 01            	rrwa	x,a
 221  001e 5d            	tnzw	x
 222  001f 271e          	jreq	L131
 224  0021 c60001        	ld	a,L52_arptime
 225  0024 5f            	clrw	x
 226  0025 90e00a        	sub	a,(10,y)
 227  0028 2401          	jrnc	L21
 228  002a 5a            	decw	x
 229  002b               L21:
 230  002b 02            	rlwa	x,a
 231  002c a30078        	cpw	x,#120
 232  002f 2f0e          	jrslt	L131
 233                     ; 175       memset(tabptr->ipaddr, 0, 4);
 235  0031 1e01          	ldw	x,(OFST-1,sp)
 236  0033 bf00          	ldw	c_x,x
 237  0035 ae0004        	ldw	x,#4
 238  0038               L41:
 239  0038 5a            	decw	x
 240  0039 926f00        	clr	([c_x.w],x)
 241  003c 5d            	tnzw	x
 242  003d 26f9          	jrne	L41
 243  003f               L131:
 244                     ; 171   for(i = 0; i < UIP_ARPTAB_SIZE; ++i) {
 246  003f 725c0003      	inc	L12_i
 249  0043 c60003        	ld	a,L12_i
 250  0046 a104          	cp	a,#4
 251  0048 25bf          	jrult	L321
 252                     ; 178 }
 255  004a 85            	popw	x
 256  004b 81            	ret	
 321                     ; 183 uip_arp_update(uint16_t *ipaddr, struct uip_eth_addr *ethaddr)
 321                     ; 184 {
 322                     .text:	section	.text,new
 323  0000               L331_uip_arp_update:
 325  0000 89            	pushw	x
 326  0001 5204          	subw	sp,#4
 327       00000004      OFST:	set	4
 330                     ; 189   for(i = 0; i < UIP_ARPTAB_SIZE; ++i) {
 332  0003 4f            	clr	a
 333  0004 c70003        	ld	L12_i,a
 334  0007               L761:
 335                     ; 191     tabptr = &arp_table[i];
 337  0007 97            	ld	xl,a
 338  0008 a60b          	ld	a,#11
 339  000a 42            	mul	x,a
 340  000b 1c0008        	addw	x,#L51_arp_table
 341  000e 1f03          	ldw	(OFST-1,sp),x
 343                     ; 193     if(tabptr->ipaddr[0] != 0 &&
 343                     ; 194        tabptr->ipaddr[1] != 0) {
 345  0010 e601          	ld	a,(1,x)
 346  0012 fa            	or	a,(x)
 347  0013 2733          	jreq	L571
 349  0015 e603          	ld	a,(3,x)
 350  0017 ea02          	or	a,(2,x)
 351  0019 272d          	jreq	L571
 352                     ; 198       if(ipaddr[0] == tabptr->ipaddr[0] &&
 352                     ; 199 	 ipaddr[1] == tabptr->ipaddr[1]) {
 354  001b 1e05          	ldw	x,(OFST+1,sp)
 355  001d 1603          	ldw	y,(OFST-1,sp)
 356  001f fe            	ldw	x,(x)
 357  0020 90f3          	cpw	x,(y)
 358  0022 2624          	jrne	L571
 360  0024 1e05          	ldw	x,(OFST+1,sp)
 361  0026 ee02          	ldw	x,(2,x)
 362  0028 90e302        	cpw	x,(2,y)
 363  002b 261b          	jrne	L571
 364                     ; 202 	memcpy(tabptr->ethaddr.addr, ethaddr->addr, 6);
 366  002d 93            	ldw	x,y
 367  002e 1c0004        	addw	x,#4
 368  0031 bf00          	ldw	c_x,x
 369  0033 1609          	ldw	y,(OFST+5,sp)
 370  0035 90bf00        	ldw	c_y,y
 371  0038 ae0006        	ldw	x,#6
 372  003b               L02:
 373  003b 5a            	decw	x
 374  003c 92d600        	ld	a,([c_y.w],x)
 375  003f 92d700        	ld	([c_x.w],x),a
 376  0042 5d            	tnzw	x
 377  0043 26f6          	jrne	L02
 378                     ; 203 	tabptr->time = arptime;
 379                     ; 205 	return;
 381  0045 cc0101        	jra	L03
 382  0048               L571:
 383                     ; 189   for(i = 0; i < UIP_ARPTAB_SIZE; ++i) {
 385  0048 725c0003      	inc	L12_i
 388  004c c60003        	ld	a,L12_i
 389  004f a104          	cp	a,#4
 390  0051 25b4          	jrult	L761
 391                     ; 214   for(i = 0; i < UIP_ARPTAB_SIZE; ++i) {
 393  0053 4f            	clr	a
 394  0054 c70003        	ld	L12_i,a
 395  0057               L102:
 396                     ; 215     tabptr = &arp_table[i];
 398  0057 97            	ld	xl,a
 399  0058 a60b          	ld	a,#11
 400  005a 42            	mul	x,a
 401  005b 1c0008        	addw	x,#L51_arp_table
 402  005e 1f03          	ldw	(OFST-1,sp),x
 404                     ; 216     if(tabptr->ipaddr[0] == 0 &&
 404                     ; 217        tabptr->ipaddr[1] == 0) {
 406  0060 e601          	ld	a,(1,x)
 407  0062 fa            	or	a,(x)
 408  0063 2606          	jrne	L702
 410  0065 e603          	ld	a,(3,x)
 411  0067 ea02          	or	a,(2,x)
 412  0069 270b          	jreq	L502
 413                     ; 218       break;
 415  006b               L702:
 416                     ; 214   for(i = 0; i < UIP_ARPTAB_SIZE; ++i) {
 418  006b 725c0003      	inc	L12_i
 421  006f c60003        	ld	a,L12_i
 422  0072 a104          	cp	a,#4
 423  0074 25e1          	jrult	L102
 424  0076               L502:
 425                     ; 224   if(i == UIP_ARPTAB_SIZE) {
 427  0076 c60003        	ld	a,L12_i
 428  0079 a104          	cp	a,#4
 429  007b 2657          	jrne	L112
 430                     ; 225     tmpage = 0;
 432  007d 725f0000      	clr	L72_tmpage
 433                     ; 226     c = 0;
 435  0081 725f0002      	clr	L32_c
 436                     ; 227     for(i = 0; i < UIP_ARPTAB_SIZE; ++i) {
 438  0085 4f            	clr	a
 439  0086 c70003        	ld	L12_i,a
 440  0089               L312:
 441                     ; 228       tabptr = &arp_table[i];
 443  0089 97            	ld	xl,a
 444  008a a60b          	ld	a,#11
 445  008c 42            	mul	x,a
 446  008d 1c0008        	addw	x,#L51_arp_table
 447  0090 1f03          	ldw	(OFST-1,sp),x
 449                     ; 229       if(arptime - tabptr->time > tmpage) {
 451  0092 5f            	clrw	x
 452  0093 c60000        	ld	a,L72_tmpage
 453  0096 97            	ld	xl,a
 454  0097 1f01          	ldw	(OFST-3,sp),x
 456  0099 5f            	clrw	x
 457  009a 1603          	ldw	y,(OFST-1,sp)
 458  009c c60001        	ld	a,L52_arptime
 459  009f 90e00a        	sub	a,(10,y)
 460  00a2 2401          	jrnc	L22
 461  00a4 5a            	decw	x
 462  00a5               L22:
 463  00a5 02            	rlwa	x,a
 464  00a6 1301          	cpw	x,(OFST-3,sp)
 465  00a8 2d10          	jrsle	L122
 466                     ; 230 	tmpage = (uint8_t)(arptime - tabptr->time);
 468  00aa 1e03          	ldw	x,(OFST-1,sp)
 469  00ac e60a          	ld	a,(10,x)
 470  00ae c00001        	sub	a,L52_arptime
 471  00b1 40            	neg	a
 472  00b2 c70000        	ld	L72_tmpage,a
 473                     ; 231 	c = i;
 475  00b5 5500030002    	mov	L32_c,L12_i
 476  00ba               L122:
 477                     ; 227     for(i = 0; i < UIP_ARPTAB_SIZE; ++i) {
 479  00ba 725c0003      	inc	L12_i
 482  00be c60003        	ld	a,L12_i
 483  00c1 a104          	cp	a,#4
 484  00c3 25c4          	jrult	L312
 485                     ; 234     i = c;
 487  00c5 c60002        	ld	a,L32_c
 488  00c8 c70003        	ld	L12_i,a
 489                     ; 235     tabptr = &arp_table[i];
 491  00cb 97            	ld	xl,a
 492  00cc a60b          	ld	a,#11
 493  00ce 42            	mul	x,a
 494  00cf 1c0008        	addw	x,#L51_arp_table
 495  00d2 1f03          	ldw	(OFST-1,sp),x
 497  00d4               L112:
 498                     ; 240   memcpy(tabptr->ipaddr, ipaddr, 4);
 500  00d4 bf00          	ldw	c_x,x
 501  00d6 1605          	ldw	y,(OFST+1,sp)
 502  00d8 90bf00        	ldw	c_y,y
 503  00db ae0004        	ldw	x,#4
 504  00de               L42:
 505  00de 5a            	decw	x
 506  00df 92d600        	ld	a,([c_y.w],x)
 507  00e2 92d700        	ld	([c_x.w],x),a
 508  00e5 5d            	tnzw	x
 509  00e6 26f6          	jrne	L42
 510                     ; 241   memcpy(tabptr->ethaddr.addr, ethaddr->addr, 6);
 512  00e8 1e03          	ldw	x,(OFST-1,sp)
 513  00ea 1c0004        	addw	x,#4
 514  00ed bf00          	ldw	c_x,x
 515  00ef 1609          	ldw	y,(OFST+5,sp)
 516  00f1 90bf00        	ldw	c_y,y
 517  00f4 ae0006        	ldw	x,#6
 518  00f7               L62:
 519  00f7 5a            	decw	x
 520  00f8 92d600        	ld	a,([c_y.w],x)
 521  00fb 92d700        	ld	([c_x.w],x),a
 522  00fe 5d            	tnzw	x
 523  00ff 26f6          	jrne	L62
 524                     ; 242   tabptr->time = arptime;
 526                     ; 243 }
 527  0101               L03:
 529  0101 1e03          	ldw	x,(OFST-1,sp)
 530  0103 c60001        	ld	a,L52_arptime
 531  0106 e70a          	ld	(10,x),a
 534  0108 5b06          	addw	sp,#6
 535  010a 81            	ret	
 564                     ; 270 uip_arp_arpin(void)
 564                     ; 271 {
 565                     .text:	section	.text,new
 566  0000               _uip_arp_arpin:
 570                     ; 272   if(uip_len < sizeof(struct arp_hdr)) {
 572  0000 ce0000        	ldw	x,_uip_len
 573  0003 a3002a        	cpw	x,#42
 574  0006 5f            	clrw	x
 575  0007 2404          	jruge	L732
 576                     ; 273     uip_len = 0;
 578  0009 cf0000        	ldw	_uip_len,x
 579                     ; 274     return;
 582  000c 81            	ret	
 583  000d               L732:
 584                     ; 276   uip_len = 0;
 586  000d cf0000        	ldw	_uip_len,x
 587                     ; 278   switch(BUF->opcode) {
 589  0010 ce0014        	ldw	x,_uip_buf+20
 591                     ; 310     break;
 592  0013 5a            	decw	x
 593  0014 2704          	jreq	L322
 594  0016 5a            	decw	x
 595  0017 277a          	jreq	L522
 597  0019 81            	ret	
 598  001a               L322:
 599                     ; 279   case HTONS(ARP_REQUEST):
 599                     ; 280     /* ARP request. If it asked for our address, we send out a reply. */
 599                     ; 281     if(uip_ipaddr_cmp(BUF->dipaddr, uip_hostaddr)) {
 601  001a ce0026        	ldw	x,_uip_buf+38
 602  001d c30000        	cpw	x,_uip_hostaddr
 603  0020 2703cc00ae    	jrne	L342
 605  0025 ce0028        	ldw	x,_uip_buf+40
 606  0028 c30002        	cpw	x,_uip_hostaddr+2
 607  002b 26f5          	jrne	L342
 608                     ; 285       uip_arp_update(BUF->sipaddr, &BUF->shwaddr);
 610  002d ae0016        	ldw	x,#_uip_buf+22
 611  0030 89            	pushw	x
 612  0031 ae001c        	ldw	x,#_uip_buf+28
 613  0034 cd0000        	call	L331_uip_arp_update
 615  0037 85            	popw	x
 616                     ; 288       BUF->opcode = HTONS(2);
 618  0038 ae0002        	ldw	x,#2
 619  003b cf0014        	ldw	_uip_buf+20,x
 620                     ; 290       memcpy(BUF->dhwaddr.addr, BUF->shwaddr.addr, 6);
 622  003e ae0006        	ldw	x,#6
 623  0041               L63:
 624  0041 d60015        	ld	a,(_uip_buf+21,x)
 625  0044 d7001f        	ld	(_uip_buf+31,x),a
 626  0047 5a            	decw	x
 627  0048 26f7          	jrne	L63
 628                     ; 291       memcpy(BUF->shwaddr.addr, uip_ethaddr.addr, 6);
 630  004a ae0006        	ldw	x,#6
 631  004d               L04:
 632  004d d6ffff        	ld	a,(_uip_ethaddr-1,x)
 633  0050 d70015        	ld	(_uip_buf+21,x),a
 634  0053 5a            	decw	x
 635  0054 26f7          	jrne	L04
 636                     ; 292       memcpy(BUF->ethhdr.src.addr, uip_ethaddr.addr, 6);
 638  0056 ae0006        	ldw	x,#6
 639  0059               L24:
 640  0059 d6ffff        	ld	a,(_uip_ethaddr-1,x)
 641  005c d70005        	ld	(_uip_buf+5,x),a
 642  005f 5a            	decw	x
 643  0060 26f7          	jrne	L24
 644                     ; 293       memcpy(BUF->ethhdr.dest.addr, BUF->dhwaddr.addr, 6);
 646  0062 ae0006        	ldw	x,#6
 647  0065               L44:
 648  0065 d6001f        	ld	a,(_uip_buf+31,x)
 649  0068 d7ffff        	ld	(_uip_buf-1,x),a
 650  006b 5a            	decw	x
 651  006c 26f7          	jrne	L44
 652                     ; 295       BUF->dipaddr[0] = BUF->sipaddr[0];
 654  006e ce001c        	ldw	x,_uip_buf+28
 655  0071 cf0026        	ldw	_uip_buf+38,x
 656                     ; 296       BUF->dipaddr[1] = BUF->sipaddr[1];
 658  0074 ce001e        	ldw	x,_uip_buf+30
 659  0077 cf0028        	ldw	_uip_buf+40,x
 660                     ; 297       BUF->sipaddr[0] = uip_hostaddr[0];
 662  007a ce0000        	ldw	x,_uip_hostaddr
 663  007d cf001c        	ldw	_uip_buf+28,x
 664                     ; 298       BUF->sipaddr[1] = uip_hostaddr[1];
 666  0080 ce0002        	ldw	x,_uip_hostaddr+2
 667  0083 cf001e        	ldw	_uip_buf+30,x
 668                     ; 300       BUF->ethhdr.type = HTONS(UIP_ETHTYPE_ARP);
 670  0086 ae0806        	ldw	x,#2054
 671  0089 cf000c        	ldw	_uip_buf+12,x
 672                     ; 301       uip_len = sizeof(struct arp_hdr);
 674  008c ae002a        	ldw	x,#42
 675  008f cf0000        	ldw	_uip_len,x
 677  0092 81            	ret	
 678  0093               L522:
 679                     ; 304   case HTONS(ARP_REPLY):
 679                     ; 305     /* ARP reply. We insert or update the ARP table if it was meant
 679                     ; 306        for us. */
 679                     ; 307     if(uip_ipaddr_cmp(BUF->dipaddr, uip_hostaddr)) {
 681  0093 ce0026        	ldw	x,_uip_buf+38
 682  0096 c30000        	cpw	x,_uip_hostaddr
 683  0099 2613          	jrne	L342
 685  009b ce0028        	ldw	x,_uip_buf+40
 686  009e c30002        	cpw	x,_uip_hostaddr+2
 687  00a1 260b          	jrne	L342
 688                     ; 308       uip_arp_update(BUF->sipaddr, &BUF->shwaddr);
 690  00a3 ae0016        	ldw	x,#_uip_buf+22
 691  00a6 89            	pushw	x
 692  00a7 ae001c        	ldw	x,#_uip_buf+28
 693  00aa cd0000        	call	L331_uip_arp_update
 695  00ad 85            	popw	x
 696  00ae               L342:
 697                     ; 313   return;
 700  00ae 81            	ret	
 751                     ; 342 uip_arp_out(void)
 751                     ; 343 {
 752                     .text:	section	.text,new
 753  0000               _uip_arp_out:
 755       00000002      OFST:	set	2
 758                     ; 354   if(uip_ipaddr_cmp(IPBUF->destipaddr, broadcast_ipaddr)) {
 760  0000 ce001e        	ldw	x,_uip_buf+30
 761  0003 c30006        	cpw	x,L31_broadcast_ipaddr
 762  0006 2617          	jrne	L172
 764  0008 ce0020        	ldw	x,_uip_buf+32
 765  000b c30008        	cpw	x,L31_broadcast_ipaddr+2
 766  000e 260f          	jrne	L172
 767                     ; 355     memcpy(IPBUF->ethhdr.dest.addr, broadcast_ethaddr.addr, 6);
 769  0010 ae0006        	ldw	x,#6
 770  0013               L25:
 771  0013 d6ffff        	ld	a,(L11_broadcast_ethaddr-1,x)
 772  0016 d7ffff        	ld	(_uip_buf-1,x),a
 773  0019 5a            	decw	x
 774  001a 26f7          	jrne	L25
 776  001c cc012f        	jra	L372
 777  001f               L172:
 778                     ; 359     if(!uip_ipaddr_maskcmp(IPBUF->destipaddr, uip_hostaddr, uip_netmask)) {
 780  001f ce001e        	ldw	x,_uip_buf+30
 781  0022 01            	rrwa	x,a
 782  0023 c40001        	and	a,_uip_netmask+1
 783  0026 01            	rrwa	x,a
 784  0027 c40000        	and	a,_uip_netmask
 785  002a 01            	rrwa	x,a
 786  002b 90ce0000      	ldw	y,_uip_hostaddr
 787  002f 9001          	rrwa	y,a
 788  0031 c40001        	and	a,_uip_netmask+1
 789  0034 9001          	rrwa	y,a
 790  0036 c40000        	and	a,_uip_netmask
 791  0039 9001          	rrwa	y,a
 792  003b 90bf00        	ldw	c_y,y
 793  003e b300          	cpw	x,c_y
 794  0040 2623          	jrne	L103
 796  0042 ce0020        	ldw	x,_uip_buf+32
 797  0045 01            	rrwa	x,a
 798  0046 c40003        	and	a,_uip_netmask+3
 799  0049 01            	rrwa	x,a
 800  004a c40002        	and	a,_uip_netmask+2
 801  004d 01            	rrwa	x,a
 802  004e 90ce0002      	ldw	y,_uip_hostaddr+2
 803  0052 9001          	rrwa	y,a
 804  0054 c40003        	and	a,_uip_netmask+3
 805  0057 9001          	rrwa	y,a
 806  0059 c40002        	and	a,_uip_netmask+2
 807  005c 9001          	rrwa	y,a
 808  005e 90bf00        	ldw	c_y,y
 809  0061 b300          	cpw	x,c_y
 810  0063 2731          	jreq	L703
 811  0065               L103:
 812                     ; 363       uip_ipaddr_copy(ipaddr, uip_draddr);
 814  0065 ce0000        	ldw	x,_uip_draddr
 815  0068 cf0004        	ldw	L71_ipaddr,x
 818  006b ce0002        	ldw	x,_uip_draddr+2
 820  006e               L503:
 821  006e cf0006        	ldw	L71_ipaddr+2,x
 822                     ; 370     for(i = 0; i < UIP_ARPTAB_SIZE; ++i) {
 824  0071 4f            	clr	a
 825  0072 c70003        	ld	L12_i,a
 826  0075               L313:
 827                     ; 372       tabptr = &arp_table[i];
 829  0075 97            	ld	xl,a
 830  0076 a60b          	ld	a,#11
 831  0078 42            	mul	x,a
 832  0079 1c0008        	addw	x,#L51_arp_table
 834                     ; 373       if(uip_ipaddr_cmp(ipaddr, tabptr->ipaddr)) {
 836  007c 9093          	ldw	y,x
 837  007e 90fe          	ldw	y,(y)
 838  0080 90c30004      	cpw	y,L71_ipaddr
 839  0084 261b          	jrne	L123
 841  0086 9093          	ldw	y,x
 842  0088 90ee02        	ldw	y,(2,y)
 843  008b 90c30006      	cpw	y,L71_ipaddr+2
 844  008f 2610          	jrne	L123
 845                     ; 375 	break;
 847  0091 c60003        	ld	a,L12_i
 848  0094 2016          	jra	L713
 849  0096               L703:
 850                     ; 367       uip_ipaddr_copy(ipaddr, IPBUF->destipaddr);
 852  0096 ce001e        	ldw	x,_uip_buf+30
 853  0099 cf0004        	ldw	L71_ipaddr,x
 856  009c ce0020        	ldw	x,_uip_buf+32
 857  009f 20cd          	jra	L503
 858  00a1               L123:
 859                     ; 370     for(i = 0; i < UIP_ARPTAB_SIZE; ++i) {
 861  00a1 725c0003      	inc	L12_i
 864  00a5 c60003        	ld	a,L12_i
 865  00a8 a104          	cp	a,#4
 866  00aa 25c9          	jrult	L313
 867  00ac               L713:
 868                     ; 379     if(i == UIP_ARPTAB_SIZE) {
 870  00ac a104          	cp	a,#4
 871  00ae 266d          	jrne	L323
 872                     ; 383       memset(BUF->ethhdr.dest.addr, 0xff, 6);
 874  00b0 a6ff          	ld	a,#255
 875  00b2 ae0006        	ldw	x,#6
 876  00b5               L45:
 877  00b5 d7ffff        	ld	(_uip_buf-1,x),a
 878  00b8 5a            	decw	x
 879  00b9 26fa          	jrne	L45
 880                     ; 384       memset(BUF->dhwaddr.addr, 0x00, 6);
 882  00bb ae0006        	ldw	x,#6
 883  00be               L65:
 884  00be 724f001f      	clr	(_uip_buf+31,x)
 885  00c2 5a            	decw	x
 886  00c3 26f9          	jrne	L65
 887                     ; 385       memcpy(BUF->ethhdr.src.addr, uip_ethaddr.addr, 6);
 889  00c5 ae0006        	ldw	x,#6
 890  00c8               L06:
 891  00c8 d6ffff        	ld	a,(_uip_ethaddr-1,x)
 892  00cb d70005        	ld	(_uip_buf+5,x),a
 893  00ce 5a            	decw	x
 894  00cf 26f7          	jrne	L06
 895                     ; 386       memcpy(BUF->shwaddr.addr, uip_ethaddr.addr, 6);
 897  00d1 ae0006        	ldw	x,#6
 898  00d4               L26:
 899  00d4 d6ffff        	ld	a,(_uip_ethaddr-1,x)
 900  00d7 d70015        	ld	(_uip_buf+21,x),a
 901  00da 5a            	decw	x
 902  00db 26f7          	jrne	L26
 903                     ; 388       uip_ipaddr_copy(BUF->dipaddr, ipaddr);
 905  00dd ce0004        	ldw	x,L71_ipaddr
 906  00e0 cf0026        	ldw	_uip_buf+38,x
 909  00e3 ce0006        	ldw	x,L71_ipaddr+2
 910  00e6 cf0028        	ldw	_uip_buf+40,x
 911                     ; 389       uip_ipaddr_copy(BUF->sipaddr, uip_hostaddr);
 913  00e9 ce0000        	ldw	x,_uip_hostaddr
 914  00ec cf001c        	ldw	_uip_buf+28,x
 917  00ef ce0002        	ldw	x,_uip_hostaddr+2
 918  00f2 cf001e        	ldw	_uip_buf+30,x
 919                     ; 390       BUF->opcode = HTONS(ARP_REQUEST); /* ARP request. */
 921  00f5 ae0001        	ldw	x,#1
 922  00f8 cf0014        	ldw	_uip_buf+20,x
 923                     ; 391       BUF->hwtype = HTONS(ARP_HWTYPE_ETH);
 925  00fb cf000e        	ldw	_uip_buf+14,x
 926                     ; 392       BUF->protocol = HTONS(UIP_ETHTYPE_IP);
 928  00fe ae0800        	ldw	x,#2048
 929  0101 cf0010        	ldw	_uip_buf+16,x
 930                     ; 393       BUF->hwlen = 6;
 932  0104 35060012      	mov	_uip_buf+18,#6
 933                     ; 394       BUF->protolen = 4;
 935  0108 35040013      	mov	_uip_buf+19,#4
 936                     ; 395       BUF->ethhdr.type = HTONS(UIP_ETHTYPE_ARP);
 938  010c ae0806        	ldw	x,#2054
 939  010f cf000c        	ldw	_uip_buf+12,x
 940                     ; 397       uip_appdata = &uip_buf[UIP_TCPIP_HLEN + UIP_LLH_LEN];
 942  0112 ae0036        	ldw	x,#_uip_buf+54
 943  0115 cf0000        	ldw	_uip_appdata,x
 944                     ; 399       uip_len = sizeof(struct arp_hdr);
 946  0118 ae002a        	ldw	x,#42
 947                     ; 400       return;
 949  011b 202a          	jra	L07
 950  011d               L323:
 951                     ; 404     memcpy(IPBUF->ethhdr.dest.addr, tabptr->ethaddr.addr, 6);
 953  011d 1c0004        	addw	x,#4
 954  0120 bf00          	ldw	c_x,x
 955  0122 ae0006        	ldw	x,#6
 956  0125               L46:
 957  0125 5a            	decw	x
 958  0126 92d600        	ld	a,([c_x.w],x)
 959  0129 d70000        	ld	(_uip_buf,x),a
 960  012c 5d            	tnzw	x
 961  012d 26f6          	jrne	L46
 962  012f               L372:
 963                     ; 406   memcpy(IPBUF->ethhdr.src.addr, uip_ethaddr.addr, 6);
 965  012f ae0006        	ldw	x,#6
 966  0132               L66:
 967  0132 d6ffff        	ld	a,(_uip_ethaddr-1,x)
 968  0135 d70005        	ld	(_uip_buf+5,x),a
 969  0138 5a            	decw	x
 970  0139 26f7          	jrne	L66
 971                     ; 408   IPBUF->ethhdr.type = HTONS(UIP_ETHTYPE_IP);
 973  013b ae0800        	ldw	x,#2048
 974  013e cf000c        	ldw	_uip_buf+12,x
 975                     ; 410   uip_len += sizeof(struct uip_eth_hdr);
 977  0141 ce0000        	ldw	x,_uip_len
 978  0144 1c000e        	addw	x,#14
 979                     ; 411 }
 980  0147               L07:
 981  0147 cf0000        	ldw	_uip_len,x
 984  014a 81            	ret	
1029                     ; 475 int check_mqtt_server_arp_entry(void)
1029                     ; 476 {
1030                     .text:	section	.text,new
1031  0000               _check_mqtt_server_arp_entry:
1033       00000002      OFST:	set	2
1036                     ; 481   if(!uip_ipaddr_maskcmp(uip_mqttserveraddr, uip_hostaddr, uip_netmask)) {
1038  0000 ce0000        	ldw	x,_uip_mqttserveraddr
1039  0003 01            	rrwa	x,a
1040  0004 c40001        	and	a,_uip_netmask+1
1041  0007 01            	rrwa	x,a
1042  0008 c40000        	and	a,_uip_netmask
1043  000b 01            	rrwa	x,a
1044  000c 90ce0000      	ldw	y,_uip_hostaddr
1045  0010 9001          	rrwa	y,a
1046  0012 c40001        	and	a,_uip_netmask+1
1047  0015 9001          	rrwa	y,a
1048  0017 c40000        	and	a,_uip_netmask
1049  001a 9001          	rrwa	y,a
1050  001c 90bf00        	ldw	c_y,y
1051  001f b300          	cpw	x,c_y
1052  0021 2623          	jrne	L163
1054  0023 ce0002        	ldw	x,_uip_mqttserveraddr+2
1055  0026 01            	rrwa	x,a
1056  0027 c40003        	and	a,_uip_netmask+3
1057  002a 01            	rrwa	x,a
1058  002b c40002        	and	a,_uip_netmask+2
1059  002e 01            	rrwa	x,a
1060  002f 90ce0002      	ldw	y,_uip_hostaddr+2
1061  0033 9001          	rrwa	y,a
1062  0035 c40003        	and	a,_uip_netmask+3
1063  0038 9001          	rrwa	y,a
1064  003a c40002        	and	a,_uip_netmask+2
1065  003d 9001          	rrwa	y,a
1066  003f 90bf00        	ldw	c_y,y
1067  0042 b300          	cpw	x,c_y
1068  0044 2730          	jreq	L763
1069  0046               L163:
1070                     ; 485     uip_ipaddr_copy(ipaddr, uip_draddr);
1072  0046 ce0000        	ldw	x,_uip_draddr
1073  0049 cf0004        	ldw	L71_ipaddr,x
1076  004c ce0002        	ldw	x,_uip_draddr+2
1078  004f               L563:
1079  004f cf0006        	ldw	L71_ipaddr+2,x
1080                     ; 492   for(i = 0; i < UIP_ARPTAB_SIZE; ++i) {
1082  0052 4f            	clr	a
1083  0053 c70003        	ld	L12_i,a
1084  0056               L373:
1085                     ; 494     tabptr = &arp_table[i];
1087  0056 97            	ld	xl,a
1088  0057 a60b          	ld	a,#11
1089  0059 42            	mul	x,a
1090  005a 1c0008        	addw	x,#L51_arp_table
1092                     ; 495     if(uip_ipaddr_cmp(ipaddr, tabptr->ipaddr)) {
1094  005d 9093          	ldw	y,x
1095  005f 90fe          	ldw	y,(y)
1096  0061 90c30004      	cpw	y,L71_ipaddr
1097  0065 261a          	jrne	L104
1099  0067 9093          	ldw	y,x
1100  0069 90ee02        	ldw	y,(2,y)
1101  006c 90c30006      	cpw	y,L71_ipaddr+2
1102  0070 260f          	jrne	L104
1103                     ; 497       return (uint8_t)1;
1105  0072 ae0001        	ldw	x,#1
1108  0075 81            	ret	
1109  0076               L763:
1110                     ; 489     uip_ipaddr_copy(ipaddr, uip_mqttserveraddr);
1112  0076 ce0000        	ldw	x,_uip_mqttserveraddr
1113  0079 cf0004        	ldw	L71_ipaddr,x
1116  007c ce0002        	ldw	x,_uip_mqttserveraddr+2
1117  007f 20ce          	jra	L563
1118  0081               L104:
1119                     ; 492   for(i = 0; i < UIP_ARPTAB_SIZE; ++i) {
1122  0081 725c0003      	inc	L12_i
1125  0085 c60003        	ld	a,L12_i
1126  0088 a104          	cp	a,#4
1127  008a 25ca          	jrult	L373
1128                     ; 501   return (uint8_t)0;
1130  008c 5f            	clrw	x
1133  008d 81            	ret	
1218                     	switch	.bss
1219  0000               L72_tmpage:
1220  0000 00            	ds.b	1
1221  0001               L52_arptime:
1222  0001 00            	ds.b	1
1223  0002               L32_c:
1224  0002 00            	ds.b	1
1225  0003               L12_i:
1226  0003 00            	ds.b	1
1227  0004               L71_ipaddr:
1228  0004 00000000      	ds.b	4
1229  0008               L51_arp_table:
1230  0008 000000000000  	ds.b	44
1231                     	xdef	_check_mqtt_server_arp_entry
1232                     	xdef	_uip_arp_timer
1233                     	xdef	_uip_arp_out
1234                     	xdef	_uip_arp_arpin
1235                     	xdef	_uip_arp_init
1236                     	xref	_uip_ethaddr
1237                     	xref	_uip_mqttserveraddr
1238                     	xref	_uip_draddr
1239                     	xref	_uip_netmask
1240                     	xref	_uip_hostaddr
1241                     	xref	_uip_len
1242                     	xref	_uip_appdata
1243                     	xref	_uip_buf
1244                     	xref.b	c_x
1245                     	xref.b	c_y
1265                     	end
