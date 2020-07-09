   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Parser V4.11.14 - 18 Nov 2019
   3                     ; Generator (Limited) V4.4.11 - 19 Nov 2019
   4                     ; Optimizer V4.4.11 - 19 Nov 2019
  17                     .const:	section	.text
  18  0000               L31_broadcast_ethaddr:
  19  0000 ff            	dc.b	255
  20  0001 ff            	dc.b	255
  21  0002 ff            	dc.b	255
  22  0003 ff            	dc.b	255
  23  0004 ff            	dc.b	255
  24  0005 ff            	dc.b	255
  25  0006               L51_broadcast_ipaddr:
  26  0006 ffff          	dc.w	-1
  27  0008 ffff          	dc.w	-1
  59                     ; 145 uip_arp_init(void)
  59                     ; 146 {
  61                     	switch	.text
  62  0000               _uip_arp_init:
  66                     ; 147   for(i = 0; i < UIP_ARPTAB_SIZE; ++i) {
  68  0000 4f            	clr	a
  69  0001 c70003        	ld	L32_i,a
  70  0004               L15:
  71                     ; 148     memset(arp_table[i].ipaddr, 0, 4);
  73  0004 97            	ld	xl,a
  74  0005 a60b          	ld	a,#11
  75  0007 42            	mul	x,a
  76  0008 1c0008        	addw	x,#L71_arp_table
  77  000b bf00          	ldw	c_x,x
  78  000d ae0004        	ldw	x,#4
  79  0010               L6:
  80  0010 5a            	decw	x
  81  0011 926f00        	clr	([c_x.w],x)
  82  0014 5d            	tnzw	x
  83  0015 26f9          	jrne	L6
  84                     ; 147   for(i = 0; i < UIP_ARPTAB_SIZE; ++i) {
  86  0017 725c0003      	inc	L32_i
  89  001b c60003        	ld	a,L32_i
  90  001e a108          	cp	a,#8
  91  0020 25e2          	jrult	L15
  92                     ; 150 }
  95  0022 81            	ret	
 187                     ; 164 uip_arp_timer(void)
 187                     ; 165 {
 188                     	switch	.text
 189  0023               _uip_arp_timer:
 191  0023 89            	pushw	x
 192       00000002      OFST:	set	2
 195                     ; 168   ++arptime;
 197  0024 725c0001      	inc	L72_arptime
 198                     ; 169   for(i = 0; i < UIP_ARPTAB_SIZE; ++i) {
 200  0028 4f            	clr	a
 201  0029 c70003        	ld	L32_i,a
 202  002c               L521:
 203                     ; 170     tabptr = &arp_table[i];
 205  002c 97            	ld	xl,a
 206  002d a60b          	ld	a,#11
 207  002f 42            	mul	x,a
 208  0030 1c0008        	addw	x,#L71_arp_table
 209  0033 1f01          	ldw	(OFST-1,sp),x
 211                     ; 171     if((tabptr->ipaddr[0] | tabptr->ipaddr[1]) != 0 &&
 211                     ; 172        arptime - tabptr->time >= UIP_ARP_MAXAGE) {
 213  0035 1601          	ldw	y,(OFST-1,sp)
 214  0037 ee02          	ldw	x,(2,x)
 215  0039 01            	rrwa	x,a
 216  003a 90ea01        	or	a,(1,y)
 217  003d 01            	rrwa	x,a
 218  003e 90fa          	or	a,(y)
 219  0040 01            	rrwa	x,a
 220  0041 5d            	tnzw	x
 221  0042 271e          	jreq	L331
 223  0044 c60001        	ld	a,L72_arptime
 224  0047 5f            	clrw	x
 225  0048 90e00a        	sub	a,(10,y)
 226  004b 2401          	jrnc	L21
 227  004d 5a            	decw	x
 228  004e               L21:
 229  004e 02            	rlwa	x,a
 230  004f a30078        	cpw	x,#120
 231  0052 2f0e          	jrslt	L331
 232                     ; 173       memset(tabptr->ipaddr, 0, 4);
 234  0054 1e01          	ldw	x,(OFST-1,sp)
 235  0056 bf00          	ldw	c_x,x
 236  0058 ae0004        	ldw	x,#4
 237  005b               L41:
 238  005b 5a            	decw	x
 239  005c 926f00        	clr	([c_x.w],x)
 240  005f 5d            	tnzw	x
 241  0060 26f9          	jrne	L41
 242  0062               L331:
 243                     ; 169   for(i = 0; i < UIP_ARPTAB_SIZE; ++i) {
 245  0062 725c0003      	inc	L32_i
 248  0066 c60003        	ld	a,L32_i
 249  0069 a108          	cp	a,#8
 250  006b 25bf          	jrult	L521
 251                     ; 177 }
 254  006d 85            	popw	x
 255  006e 81            	ret	
 320                     ; 182 uip_arp_update(uint16_t *ipaddr, struct uip_eth_addr *ethaddr)
 320                     ; 183 {
 321                     	switch	.text
 322  006f               L531_uip_arp_update:
 324  006f 89            	pushw	x
 325  0070 5204          	subw	sp,#4
 326       00000004      OFST:	set	4
 329                     ; 188   for(i = 0; i < UIP_ARPTAB_SIZE; ++i) {
 331  0072 4f            	clr	a
 332  0073 c70003        	ld	L32_i,a
 333  0076               L171:
 334                     ; 190     tabptr = &arp_table[i];
 336  0076 97            	ld	xl,a
 337  0077 a60b          	ld	a,#11
 338  0079 42            	mul	x,a
 339  007a 1c0008        	addw	x,#L71_arp_table
 340  007d 1f03          	ldw	(OFST-1,sp),x
 342                     ; 192     if(tabptr->ipaddr[0] != 0 &&
 342                     ; 193        tabptr->ipaddr[1] != 0) {
 344  007f e601          	ld	a,(1,x)
 345  0081 fa            	or	a,(x)
 346  0082 2733          	jreq	L771
 348  0084 e603          	ld	a,(3,x)
 349  0086 ea02          	or	a,(2,x)
 350  0088 272d          	jreq	L771
 351                     ; 197       if(ipaddr[0] == tabptr->ipaddr[0] &&
 351                     ; 198 	 ipaddr[1] == tabptr->ipaddr[1]) {
 353  008a 1e05          	ldw	x,(OFST+1,sp)
 354  008c 1603          	ldw	y,(OFST-1,sp)
 355  008e fe            	ldw	x,(x)
 356  008f 90f3          	cpw	x,(y)
 357  0091 2624          	jrne	L771
 359  0093 1e05          	ldw	x,(OFST+1,sp)
 360  0095 ee02          	ldw	x,(2,x)
 361  0097 90e302        	cpw	x,(2,y)
 362  009a 261b          	jrne	L771
 363                     ; 201 	memcpy(tabptr->ethaddr.addr, ethaddr->addr, 6);
 365  009c 93            	ldw	x,y
 366  009d 1c0004        	addw	x,#4
 367  00a0 bf00          	ldw	c_x,x
 368  00a2 1609          	ldw	y,(OFST+5,sp)
 369  00a4 90bf00        	ldw	c_y,y
 370  00a7 ae0006        	ldw	x,#6
 371  00aa               L02:
 372  00aa 5a            	decw	x
 373  00ab 92d600        	ld	a,([c_y.w],x)
 374  00ae 92d700        	ld	([c_x.w],x),a
 375  00b1 5d            	tnzw	x
 376  00b2 26f6          	jrne	L02
 377                     ; 202 	tabptr->time = arptime;
 378                     ; 204 	return;
 380  00b4 cc0170        	jra	L03
 381  00b7               L771:
 382                     ; 188   for(i = 0; i < UIP_ARPTAB_SIZE; ++i) {
 384  00b7 725c0003      	inc	L32_i
 387  00bb c60003        	ld	a,L32_i
 388  00be a108          	cp	a,#8
 389  00c0 25b4          	jrult	L171
 390                     ; 213   for(i = 0; i < UIP_ARPTAB_SIZE; ++i) {
 392  00c2 4f            	clr	a
 393  00c3 c70003        	ld	L32_i,a
 394  00c6               L302:
 395                     ; 214     tabptr = &arp_table[i];
 397  00c6 97            	ld	xl,a
 398  00c7 a60b          	ld	a,#11
 399  00c9 42            	mul	x,a
 400  00ca 1c0008        	addw	x,#L71_arp_table
 401  00cd 1f03          	ldw	(OFST-1,sp),x
 403                     ; 215     if(tabptr->ipaddr[0] == 0 &&
 403                     ; 216        tabptr->ipaddr[1] == 0) {
 405  00cf e601          	ld	a,(1,x)
 406  00d1 fa            	or	a,(x)
 407  00d2 2606          	jrne	L112
 409  00d4 e603          	ld	a,(3,x)
 410  00d6 ea02          	or	a,(2,x)
 411  00d8 270b          	jreq	L702
 412                     ; 217       break;
 414  00da               L112:
 415                     ; 213   for(i = 0; i < UIP_ARPTAB_SIZE; ++i) {
 417  00da 725c0003      	inc	L32_i
 420  00de c60003        	ld	a,L32_i
 421  00e1 a108          	cp	a,#8
 422  00e3 25e1          	jrult	L302
 423  00e5               L702:
 424                     ; 223   if(i == UIP_ARPTAB_SIZE) {
 426  00e5 c60003        	ld	a,L32_i
 427  00e8 a108          	cp	a,#8
 428  00ea 2657          	jrne	L312
 429                     ; 224     tmpage = 0;
 431  00ec 725f0000      	clr	L13_tmpage
 432                     ; 225     c = 0;
 434  00f0 725f0002      	clr	L52_c
 435                     ; 226     for(i = 0; i < UIP_ARPTAB_SIZE; ++i) {
 437  00f4 4f            	clr	a
 438  00f5 c70003        	ld	L32_i,a
 439  00f8               L512:
 440                     ; 227       tabptr = &arp_table[i];
 442  00f8 97            	ld	xl,a
 443  00f9 a60b          	ld	a,#11
 444  00fb 42            	mul	x,a
 445  00fc 1c0008        	addw	x,#L71_arp_table
 446  00ff 1f03          	ldw	(OFST-1,sp),x
 448                     ; 228       if(arptime - tabptr->time > tmpage) {
 450  0101 5f            	clrw	x
 451  0102 c60000        	ld	a,L13_tmpage
 452  0105 97            	ld	xl,a
 453  0106 1f01          	ldw	(OFST-3,sp),x
 455  0108 5f            	clrw	x
 456  0109 1603          	ldw	y,(OFST-1,sp)
 457  010b c60001        	ld	a,L72_arptime
 458  010e 90e00a        	sub	a,(10,y)
 459  0111 2401          	jrnc	L22
 460  0113 5a            	decw	x
 461  0114               L22:
 462  0114 02            	rlwa	x,a
 463  0115 1301          	cpw	x,(OFST-3,sp)
 464  0117 2d10          	jrsle	L322
 465                     ; 229 	tmpage = (uint8_t)(arptime - tabptr->time);
 467  0119 1e03          	ldw	x,(OFST-1,sp)
 468  011b e60a          	ld	a,(10,x)
 469  011d c00001        	sub	a,L72_arptime
 470  0120 40            	neg	a
 471  0121 c70000        	ld	L13_tmpage,a
 472                     ; 230 	c = i;
 474  0124 5500030002    	mov	L52_c,L32_i
 475  0129               L322:
 476                     ; 226     for(i = 0; i < UIP_ARPTAB_SIZE; ++i) {
 478  0129 725c0003      	inc	L32_i
 481  012d c60003        	ld	a,L32_i
 482  0130 a108          	cp	a,#8
 483  0132 25c4          	jrult	L512
 484                     ; 233     i = c;
 486  0134 c60002        	ld	a,L52_c
 487  0137 c70003        	ld	L32_i,a
 488                     ; 234     tabptr = &arp_table[i];
 490  013a 97            	ld	xl,a
 491  013b a60b          	ld	a,#11
 492  013d 42            	mul	x,a
 493  013e 1c0008        	addw	x,#L71_arp_table
 494  0141 1f03          	ldw	(OFST-1,sp),x
 496  0143               L312:
 497                     ; 239   memcpy(tabptr->ipaddr, ipaddr, 4);
 499  0143 bf00          	ldw	c_x,x
 500  0145 1605          	ldw	y,(OFST+1,sp)
 501  0147 90bf00        	ldw	c_y,y
 502  014a ae0004        	ldw	x,#4
 503  014d               L42:
 504  014d 5a            	decw	x
 505  014e 92d600        	ld	a,([c_y.w],x)
 506  0151 92d700        	ld	([c_x.w],x),a
 507  0154 5d            	tnzw	x
 508  0155 26f6          	jrne	L42
 509                     ; 240   memcpy(tabptr->ethaddr.addr, ethaddr->addr, 6);
 511  0157 1e03          	ldw	x,(OFST-1,sp)
 512  0159 1c0004        	addw	x,#4
 513  015c bf00          	ldw	c_x,x
 514  015e 1609          	ldw	y,(OFST+5,sp)
 515  0160 90bf00        	ldw	c_y,y
 516  0163 ae0006        	ldw	x,#6
 517  0166               L62:
 518  0166 5a            	decw	x
 519  0167 92d600        	ld	a,([c_y.w],x)
 520  016a 92d700        	ld	([c_x.w],x),a
 521  016d 5d            	tnzw	x
 522  016e 26f6          	jrne	L62
 523                     ; 241   tabptr->time = arptime;
 525                     ; 242 }
 526  0170               L03:
 528  0170 1e03          	ldw	x,(OFST-1,sp)
 529  0172 c60001        	ld	a,L72_arptime
 530  0175 e70a          	ld	(10,x),a
 533  0177 5b06          	addw	sp,#6
 534  0179 81            	ret	
 563                     ; 269 uip_arp_arpin(void)
 563                     ; 270 {
 564                     	switch	.text
 565  017a               _uip_arp_arpin:
 569                     ; 271   if(uip_len < sizeof(struct arp_hdr)) {
 571  017a ce0000        	ldw	x,_uip_len
 572  017d a3002a        	cpw	x,#42
 573  0180 5f            	clrw	x
 574  0181 2404          	jruge	L142
 575                     ; 272     uip_len = 0;
 577  0183 cf0000        	ldw	_uip_len,x
 578                     ; 273     return;
 581  0186 81            	ret	
 582  0187               L142:
 583                     ; 275   uip_len = 0;
 585  0187 cf0000        	ldw	_uip_len,x
 586                     ; 277   switch(BUF->opcode) {
 588  018a ce0014        	ldw	x,_uip_buf+20
 590                     ; 310     break;
 591  018d 5a            	decw	x
 592  018e 2704          	jreq	L522
 593  0190 5a            	decw	x
 594  0191 277a          	jreq	L722
 596  0193 81            	ret	
 597  0194               L522:
 598                     ; 278   case HTONS(ARP_REQUEST):
 598                     ; 279     /* ARP request. If it asked for our address, we send out a
 598                     ; 280        reply. */
 598                     ; 281     if(uip_ipaddr_cmp(BUF->dipaddr, uip_hostaddr)) {
 600  0194 ce0026        	ldw	x,_uip_buf+38
 601  0197 c30000        	cpw	x,_uip_hostaddr
 602  019a 2703cc0228    	jrne	L542
 604  019f ce0028        	ldw	x,_uip_buf+40
 605  01a2 c30002        	cpw	x,_uip_hostaddr+2
 606  01a5 26f5          	jrne	L542
 607                     ; 285       uip_arp_update(BUF->sipaddr, &BUF->shwaddr);
 609  01a7 ae0016        	ldw	x,#_uip_buf+22
 610  01aa 89            	pushw	x
 611  01ab ae001c        	ldw	x,#_uip_buf+28
 612  01ae cd006f        	call	L531_uip_arp_update
 614  01b1 85            	popw	x
 615                     ; 288       BUF->opcode = HTONS(2);
 617  01b2 ae0002        	ldw	x,#2
 618  01b5 cf0014        	ldw	_uip_buf+20,x
 619                     ; 290       memcpy(BUF->dhwaddr.addr, BUF->shwaddr.addr, 6);
 621  01b8 ae0006        	ldw	x,#6
 622  01bb               L63:
 623  01bb d60015        	ld	a,(_uip_buf+21,x)
 624  01be d7001f        	ld	(_uip_buf+31,x),a
 625  01c1 5a            	decw	x
 626  01c2 26f7          	jrne	L63
 627                     ; 291       memcpy(BUF->shwaddr.addr, uip_ethaddr.addr, 6);
 629  01c4 ae0006        	ldw	x,#6
 630  01c7               L04:
 631  01c7 d6ffff        	ld	a,(_uip_ethaddr-1,x)
 632  01ca d70015        	ld	(_uip_buf+21,x),a
 633  01cd 5a            	decw	x
 634  01ce 26f7          	jrne	L04
 635                     ; 292       memcpy(BUF->ethhdr.src.addr, uip_ethaddr.addr, 6);
 637  01d0 ae0006        	ldw	x,#6
 638  01d3               L24:
 639  01d3 d6ffff        	ld	a,(_uip_ethaddr-1,x)
 640  01d6 d70005        	ld	(_uip_buf+5,x),a
 641  01d9 5a            	decw	x
 642  01da 26f7          	jrne	L24
 643                     ; 293       memcpy(BUF->ethhdr.dest.addr, BUF->dhwaddr.addr, 6);
 645  01dc ae0006        	ldw	x,#6
 646  01df               L44:
 647  01df d6001f        	ld	a,(_uip_buf+31,x)
 648  01e2 d7ffff        	ld	(_uip_buf-1,x),a
 649  01e5 5a            	decw	x
 650  01e6 26f7          	jrne	L44
 651                     ; 295       BUF->dipaddr[0] = BUF->sipaddr[0];
 653  01e8 ce001c        	ldw	x,_uip_buf+28
 654  01eb cf0026        	ldw	_uip_buf+38,x
 655                     ; 296       BUF->dipaddr[1] = BUF->sipaddr[1];
 657  01ee ce001e        	ldw	x,_uip_buf+30
 658  01f1 cf0028        	ldw	_uip_buf+40,x
 659                     ; 297       BUF->sipaddr[0] = uip_hostaddr[0];
 661  01f4 ce0000        	ldw	x,_uip_hostaddr
 662  01f7 cf001c        	ldw	_uip_buf+28,x
 663                     ; 298       BUF->sipaddr[1] = uip_hostaddr[1];
 665  01fa ce0002        	ldw	x,_uip_hostaddr+2
 666  01fd cf001e        	ldw	_uip_buf+30,x
 667                     ; 300       BUF->ethhdr.type = HTONS(UIP_ETHTYPE_ARP);
 669  0200 ae0806        	ldw	x,#2054
 670  0203 cf000c        	ldw	_uip_buf+12,x
 671                     ; 301       uip_len = sizeof(struct arp_hdr);
 673  0206 ae002a        	ldw	x,#42
 674  0209 cf0000        	ldw	_uip_len,x
 676  020c 81            	ret	
 677  020d               L722:
 678                     ; 304   case HTONS(ARP_REPLY):
 678                     ; 305     /* ARP reply. We insert or update the ARP table if it was meant
 678                     ; 306        for us. */
 678                     ; 307     if(uip_ipaddr_cmp(BUF->dipaddr, uip_hostaddr)) {
 680  020d ce0026        	ldw	x,_uip_buf+38
 681  0210 c30000        	cpw	x,_uip_hostaddr
 682  0213 2613          	jrne	L542
 684  0215 ce0028        	ldw	x,_uip_buf+40
 685  0218 c30002        	cpw	x,_uip_hostaddr+2
 686  021b 260b          	jrne	L542
 687                     ; 308       uip_arp_update(BUF->sipaddr, &BUF->shwaddr);
 689  021d ae0016        	ldw	x,#_uip_buf+22
 690  0220 89            	pushw	x
 691  0221 ae001c        	ldw	x,#_uip_buf+28
 692  0224 cd006f        	call	L531_uip_arp_update
 694  0227 85            	popw	x
 695  0228               L542:
 696                     ; 313   return;
 699  0228 81            	ret	
 750                     ; 346 uip_arp_out(void)
 750                     ; 347 {
 751                     	switch	.text
 752  0229               _uip_arp_out:
 754       00000002      OFST:	set	2
 757                     ; 358   if(uip_ipaddr_cmp(IPBUF->destipaddr, broadcast_ipaddr)) {
 759  0229 ce001e        	ldw	x,_uip_buf+30
 760  022c c30006        	cpw	x,L51_broadcast_ipaddr
 761  022f 2617          	jrne	L372
 763  0231 ce0020        	ldw	x,_uip_buf+32
 764  0234 c30008        	cpw	x,L51_broadcast_ipaddr+2
 765  0237 260f          	jrne	L372
 766                     ; 359     memcpy(IPBUF->ethhdr.dest.addr, broadcast_ethaddr.addr, 6);
 768  0239 ae0006        	ldw	x,#6
 769  023c               L25:
 770  023c d6ffff        	ld	a,(L31_broadcast_ethaddr-1,x)
 771  023f d7ffff        	ld	(_uip_buf-1,x),a
 772  0242 5a            	decw	x
 773  0243 26f7          	jrne	L25
 775  0245 cc0358        	jra	L572
 776  0248               L372:
 777                     ; 363     if(!uip_ipaddr_maskcmp(IPBUF->destipaddr, uip_hostaddr, uip_netmask)) {
 779  0248 ce001e        	ldw	x,_uip_buf+30
 780  024b 01            	rrwa	x,a
 781  024c c40001        	and	a,_uip_netmask+1
 782  024f 01            	rrwa	x,a
 783  0250 c40000        	and	a,_uip_netmask
 784  0253 01            	rrwa	x,a
 785  0254 90ce0000      	ldw	y,_uip_hostaddr
 786  0258 9001          	rrwa	y,a
 787  025a c40001        	and	a,_uip_netmask+1
 788  025d 9001          	rrwa	y,a
 789  025f c40000        	and	a,_uip_netmask
 790  0262 9001          	rrwa	y,a
 791  0264 90bf00        	ldw	c_y,y
 792  0267 b300          	cpw	x,c_y
 793  0269 2623          	jrne	L303
 795  026b ce0020        	ldw	x,_uip_buf+32
 796  026e 01            	rrwa	x,a
 797  026f c40003        	and	a,_uip_netmask+3
 798  0272 01            	rrwa	x,a
 799  0273 c40002        	and	a,_uip_netmask+2
 800  0276 01            	rrwa	x,a
 801  0277 90ce0002      	ldw	y,_uip_hostaddr+2
 802  027b 9001          	rrwa	y,a
 803  027d c40003        	and	a,_uip_netmask+3
 804  0280 9001          	rrwa	y,a
 805  0282 c40002        	and	a,_uip_netmask+2
 806  0285 9001          	rrwa	y,a
 807  0287 90bf00        	ldw	c_y,y
 808  028a b300          	cpw	x,c_y
 809  028c 2731          	jreq	L113
 810  028e               L303:
 811                     ; 367       uip_ipaddr_copy(ipaddr, uip_draddr);
 813  028e ce0000        	ldw	x,_uip_draddr
 814  0291 cf0004        	ldw	L12_ipaddr,x
 817  0294 ce0002        	ldw	x,_uip_draddr+2
 819  0297               L703:
 820  0297 cf0006        	ldw	L12_ipaddr+2,x
 821                     ; 374     for(i = 0; i < UIP_ARPTAB_SIZE; ++i) {
 823  029a 4f            	clr	a
 824  029b c70003        	ld	L32_i,a
 825  029e               L513:
 826                     ; 375       tabptr = &arp_table[i];
 828  029e 97            	ld	xl,a
 829  029f a60b          	ld	a,#11
 830  02a1 42            	mul	x,a
 831  02a2 1c0008        	addw	x,#L71_arp_table
 833                     ; 376       if(uip_ipaddr_cmp(ipaddr, tabptr->ipaddr)) {
 835  02a5 9093          	ldw	y,x
 836  02a7 90fe          	ldw	y,(y)
 837  02a9 90c30004      	cpw	y,L12_ipaddr
 838  02ad 261b          	jrne	L323
 840  02af 9093          	ldw	y,x
 841  02b1 90ee02        	ldw	y,(2,y)
 842  02b4 90c30006      	cpw	y,L12_ipaddr+2
 843  02b8 2610          	jrne	L323
 844                     ; 377 	break;
 846  02ba c60003        	ld	a,L32_i
 847  02bd 2016          	jra	L123
 848  02bf               L113:
 849                     ; 371       uip_ipaddr_copy(ipaddr, IPBUF->destipaddr);
 851  02bf ce001e        	ldw	x,_uip_buf+30
 852  02c2 cf0004        	ldw	L12_ipaddr,x
 855  02c5 ce0020        	ldw	x,_uip_buf+32
 856  02c8 20cd          	jra	L703
 857  02ca               L323:
 858                     ; 374     for(i = 0; i < UIP_ARPTAB_SIZE; ++i) {
 860  02ca 725c0003      	inc	L32_i
 863  02ce c60003        	ld	a,L32_i
 864  02d1 a108          	cp	a,#8
 865  02d3 25c9          	jrult	L513
 866  02d5               L123:
 867                     ; 381     if(i == UIP_ARPTAB_SIZE) {
 869  02d5 a108          	cp	a,#8
 870  02d7 266d          	jrne	L523
 871                     ; 385       memset(BUF->ethhdr.dest.addr, 0xff, 6);
 873  02d9 a6ff          	ld	a,#255
 874  02db ae0006        	ldw	x,#6
 875  02de               L45:
 876  02de d7ffff        	ld	(_uip_buf-1,x),a
 877  02e1 5a            	decw	x
 878  02e2 26fa          	jrne	L45
 879                     ; 386       memset(BUF->dhwaddr.addr, 0x00, 6);
 881  02e4 ae0006        	ldw	x,#6
 882  02e7               L65:
 883  02e7 724f001f      	clr	(_uip_buf+31,x)
 884  02eb 5a            	decw	x
 885  02ec 26f9          	jrne	L65
 886                     ; 387       memcpy(BUF->ethhdr.src.addr, uip_ethaddr.addr, 6);
 888  02ee ae0006        	ldw	x,#6
 889  02f1               L06:
 890  02f1 d6ffff        	ld	a,(_uip_ethaddr-1,x)
 891  02f4 d70005        	ld	(_uip_buf+5,x),a
 892  02f7 5a            	decw	x
 893  02f8 26f7          	jrne	L06
 894                     ; 388       memcpy(BUF->shwaddr.addr, uip_ethaddr.addr, 6);
 896  02fa ae0006        	ldw	x,#6
 897  02fd               L26:
 898  02fd d6ffff        	ld	a,(_uip_ethaddr-1,x)
 899  0300 d70015        	ld	(_uip_buf+21,x),a
 900  0303 5a            	decw	x
 901  0304 26f7          	jrne	L26
 902                     ; 390       uip_ipaddr_copy(BUF->dipaddr, ipaddr);
 904  0306 ce0004        	ldw	x,L12_ipaddr
 905  0309 cf0026        	ldw	_uip_buf+38,x
 908  030c ce0006        	ldw	x,L12_ipaddr+2
 909  030f cf0028        	ldw	_uip_buf+40,x
 910                     ; 391       uip_ipaddr_copy(BUF->sipaddr, uip_hostaddr);
 912  0312 ce0000        	ldw	x,_uip_hostaddr
 913  0315 cf001c        	ldw	_uip_buf+28,x
 916  0318 ce0002        	ldw	x,_uip_hostaddr+2
 917  031b cf001e        	ldw	_uip_buf+30,x
 918                     ; 392       BUF->opcode = HTONS(ARP_REQUEST); /* ARP request. */
 920  031e ae0001        	ldw	x,#1
 921  0321 cf0014        	ldw	_uip_buf+20,x
 922                     ; 393       BUF->hwtype = HTONS(ARP_HWTYPE_ETH);
 924  0324 cf000e        	ldw	_uip_buf+14,x
 925                     ; 394       BUF->protocol = HTONS(UIP_ETHTYPE_IP);
 927  0327 ae0800        	ldw	x,#2048
 928  032a cf0010        	ldw	_uip_buf+16,x
 929                     ; 395       BUF->hwlen = 6;
 931  032d 35060012      	mov	_uip_buf+18,#6
 932                     ; 396       BUF->protolen = 4;
 934  0331 35040013      	mov	_uip_buf+19,#4
 935                     ; 397       BUF->ethhdr.type = HTONS(UIP_ETHTYPE_ARP);
 937  0335 ae0806        	ldw	x,#2054
 938  0338 cf000c        	ldw	_uip_buf+12,x
 939                     ; 399       uip_appdata = &uip_buf[UIP_TCPIP_HLEN + UIP_LLH_LEN];
 941  033b ae0036        	ldw	x,#_uip_buf+54
 942  033e cf0000        	ldw	_uip_appdata,x
 943                     ; 401       uip_len = sizeof(struct arp_hdr);
 945  0341 ae002a        	ldw	x,#42
 946                     ; 402       return;
 948  0344 202a          	jra	L07
 949  0346               L523:
 950                     ; 406     memcpy(IPBUF->ethhdr.dest.addr, tabptr->ethaddr.addr, 6);
 952  0346 1c0004        	addw	x,#4
 953  0349 bf00          	ldw	c_x,x
 954  034b ae0006        	ldw	x,#6
 955  034e               L46:
 956  034e 5a            	decw	x
 957  034f 92d600        	ld	a,([c_x.w],x)
 958  0352 d70000        	ld	(_uip_buf,x),a
 959  0355 5d            	tnzw	x
 960  0356 26f6          	jrne	L46
 961  0358               L572:
 962                     ; 408   memcpy(IPBUF->ethhdr.src.addr, uip_ethaddr.addr, 6);
 964  0358 ae0006        	ldw	x,#6
 965  035b               L66:
 966  035b d6ffff        	ld	a,(_uip_ethaddr-1,x)
 967  035e d70005        	ld	(_uip_buf+5,x),a
 968  0361 5a            	decw	x
 969  0362 26f7          	jrne	L66
 970                     ; 410   IPBUF->ethhdr.type = HTONS(UIP_ETHTYPE_IP);
 972  0364 ae0800        	ldw	x,#2048
 973  0367 cf000c        	ldw	_uip_buf+12,x
 974                     ; 412   uip_len += sizeof(struct uip_eth_hdr);
 976  036a ce0000        	ldw	x,_uip_len
 977  036d 1c000e        	addw	x,#14
 978                     ; 413 }
 979  0370               L07:
 980  0370 cf0000        	ldw	_uip_len,x
 983  0373 81            	ret	
1068                     	switch	.bss
1069  0000               L13_tmpage:
1070  0000 00            	ds.b	1
1071  0001               L72_arptime:
1072  0001 00            	ds.b	1
1073  0002               L52_c:
1074  0002 00            	ds.b	1
1075  0003               L32_i:
1076  0003 00            	ds.b	1
1077  0004               L12_ipaddr:
1078  0004 00000000      	ds.b	4
1079  0008               L71_arp_table:
1080  0008 000000000000  	ds.b	88
1081                     	xdef	_uip_arp_timer
1082                     	xdef	_uip_arp_out
1083                     	xdef	_uip_arp_arpin
1084                     	xdef	_uip_arp_init
1085                     	xref	_uip_ethaddr
1086                     	xref	_uip_draddr
1087                     	xref	_uip_netmask
1088                     	xref	_uip_hostaddr
1089                     	xref	_uip_len
1090                     	xref	_uip_appdata
1091                     	xref	_uip_buf
1092                     	xref.b	c_x
1093                     	xref.b	c_y
1113                     	end
