   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Parser V4.11.14 - 18 Nov 2019
   3                     ; Generator (Limited) V4.4.11 - 19 Nov 2019
   4                     ; Optimizer V4.4.11 - 19 Nov 2019
  17                     	switch	.data
  18  0000               _uip_ethaddr:
  19  0000 01            	dc.b	1
  20  0001 02            	dc.b	2
  21  0002 03            	dc.b	3
  22  0003 04            	dc.b	4
  23  0004 05            	dc.b	5
  24  0005 06            	dc.b	6
  63                     ; 158 void uip_setipid(uint16_t id)
  63                     ; 159 {
  65                     	switch	.text
  66  0000               _uip_setipid:
  70                     ; 160   ipid = id;
  72  0000 cf0008        	ldw	L31_ipid,x
  73                     ; 161 }
  76  0003 81            	ret	
 119                     ; 212 void uip_add32(uint8_t *op32, uint16_t op16)
 119                     ; 213 {
 120                     	switch	.text
 121  0004               _uip_add32:
 123  0004 89            	pushw	x
 124  0005 89            	pushw	x
 125       00000002      OFST:	set	2
 128                     ; 214   uip_acc32[3] = (uint8_t)(op32[3] + (op16 & 0xff));
 130  0006 7b08          	ld	a,(OFST+6,sp)
 131  0008 eb03          	add	a,(3,x)
 132  000a c70080        	ld	_uip_acc32+3,a
 133                     ; 215   uip_acc32[2] = (uint8_t)(op32[2] + (op16 >> 8));
 135  000d e602          	ld	a,(2,x)
 136  000f 1b07          	add	a,(OFST+5,sp)
 137  0011 c7007f        	ld	_uip_acc32+2,a
 138                     ; 216   uip_acc32[1] = op32[1];
 140  0014 e601          	ld	a,(1,x)
 141  0016 c7007e        	ld	_uip_acc32+1,a
 142                     ; 217   uip_acc32[0] = op32[0];
 144  0019 f6            	ld	a,(x)
 145  001a c7007d        	ld	_uip_acc32,a
 146                     ; 219   if (uip_acc32[2] < (op16 >> 8)) {
 148  001d 4f            	clr	a
 149  001e 1e07          	ldw	x,(OFST+5,sp)
 150  0020 01            	rrwa	x,a
 151  0021 c6007f        	ld	a,_uip_acc32+2
 152  0024 905f          	clrw	y
 153  0026 9097          	ld	yl,a
 154  0028 90bf00        	ldw	c_y,y
 155  002b b300          	cpw	x,c_y
 156  002d 230a          	jrule	L76
 157                     ; 220     ++uip_acc32[1];
 159  002f 725c007e      	inc	_uip_acc32+1
 160                     ; 221     if (uip_acc32[1] == 0) {
 162  0033 2604          	jrne	L76
 163                     ; 222       ++uip_acc32[0];
 165  0035 725c007d      	inc	_uip_acc32
 166  0039               L76:
 167                     ; 226   if (uip_acc32[3] < (op16 & 0xff)) {
 169  0039 c60080        	ld	a,_uip_acc32+3
 170  003c 5f            	clrw	x
 171  003d 97            	ld	xl,a
 172  003e 1f01          	ldw	(OFST-1,sp),x
 174  0040 5f            	clrw	x
 175  0041 7b08          	ld	a,(OFST+6,sp)
 176  0043 02            	rlwa	x,a
 177  0044 1301          	cpw	x,(OFST-1,sp)
 178  0046 2310          	jrule	L37
 179                     ; 227     ++uip_acc32[2];
 181  0048 725c007f      	inc	_uip_acc32+2
 182                     ; 228     if (uip_acc32[2] == 0) {
 184  004c 260a          	jrne	L37
 185                     ; 229       ++uip_acc32[1];
 187  004e 725c007e      	inc	_uip_acc32+1
 188                     ; 230       if (uip_acc32[1] == 0) {
 190  0052 2604          	jrne	L37
 191                     ; 231         ++uip_acc32[0];
 193  0054 725c007d      	inc	_uip_acc32
 194  0058               L37:
 195                     ; 235 }
 198  0058 5b04          	addw	sp,#4
 199  005a 81            	ret	
 275                     ; 242 static uint16_t chksum(uint16_t sum, const uint8_t *data, uint16_t len)
 275                     ; 243 {
 276                     	switch	.text
 277  005b               L101_chksum:
 279  005b 89            	pushw	x
 280  005c 5206          	subw	sp,#6
 281       00000006      OFST:	set	6
 284                     ; 248   dataptr = data;
 286  005e 1e0b          	ldw	x,(OFST+5,sp)
 287  0060 1f05          	ldw	(OFST-1,sp),x
 289                     ; 249   last_byte = data + len - 1;
 291  0062 72fb0d        	addw	x,(OFST+7,sp)
 292  0065 5a            	decw	x
 293  0066 1f01          	ldw	(OFST-5,sp),x
 296  0068 1e05          	ldw	x,(OFST-1,sp)
 297  006a 2020          	jra	L341
 298  006c               L731:
 299                     ; 252     t = (dataptr[0] << 8) + dataptr[1];
 301  006c f6            	ld	a,(x)
 302  006d 5f            	clrw	x
 303  006e 97            	ld	xl,a
 304  006f 1605          	ldw	y,(OFST-1,sp)
 305  0071 4f            	clr	a
 306  0072 90eb01        	add	a,(1,y)
 307  0075 2401          	jrnc	L21
 308  0077 5c            	incw	x
 309  0078               L21:
 310  0078 02            	rlwa	x,a
 311  0079 1f03          	ldw	(OFST-3,sp),x
 313                     ; 253     sum += t;
 315  007b 72fb07        	addw	x,(OFST+1,sp)
 316                     ; 254     if (sum < t) sum++; /* carry */
 318  007e 1303          	cpw	x,(OFST-3,sp)
 319  0080 2401          	jruge	L741
 322  0082 5c            	incw	x
 323  0083               L741:
 324  0083 1f07          	ldw	(OFST+1,sp),x
 325                     ; 255     dataptr += 2;
 327  0085 1e05          	ldw	x,(OFST-1,sp)
 328  0087 1c0002        	addw	x,#2
 329  008a 1f05          	ldw	(OFST-1,sp),x
 331  008c               L341:
 332                     ; 251   while (dataptr < last_byte) { /* At least two more bytes */
 334  008c 1301          	cpw	x,(OFST-5,sp)
 335  008e 25dc          	jrult	L731
 336                     ; 258   if (dataptr == last_byte) {
 338  0090 2612          	jrne	L151
 339                     ; 259     t = (dataptr[0] << 8) + 0;
 341  0092 f6            	ld	a,(x)
 342  0093 97            	ld	xl,a
 343  0094 4f            	clr	a
 344  0095 02            	rlwa	x,a
 345  0096 1f03          	ldw	(OFST-3,sp),x
 347                     ; 260     sum += t;
 349  0098 72fb07        	addw	x,(OFST+1,sp)
 350  009b 1f07          	ldw	(OFST+1,sp),x
 351                     ; 261     if (sum < t) sum++; /* carry */
 353  009d 1303          	cpw	x,(OFST-3,sp)
 354  009f 2403          	jruge	L151
 357  00a1 5c            	incw	x
 358  00a2 1f07          	ldw	(OFST+1,sp),x
 359  00a4               L151:
 360                     ; 264   return sum;
 362  00a4 1e07          	ldw	x,(OFST+1,sp)
 365  00a6 5b08          	addw	sp,#8
 366  00a8 81            	ret	
 410                     ; 269 uint16_t uip_chksum(uint16_t *data, uint16_t len)
 410                     ; 270 {
 411                     	switch	.text
 412  00a9               _uip_chksum:
 414  00a9 89            	pushw	x
 415       00000000      OFST:	set	0
 418                     ; 271   return htons(chksum(0, (uint8_t *)data, len));
 420  00aa 1e05          	ldw	x,(OFST+5,sp)
 421  00ac 89            	pushw	x
 422  00ad 1e03          	ldw	x,(OFST+3,sp)
 423  00af 89            	pushw	x
 424  00b0 5f            	clrw	x
 425  00b1 ada8          	call	L101_chksum
 427  00b3 5b04          	addw	sp,#4
 428  00b5 cd0b40        	call	_htons
 432  00b8 5b02          	addw	sp,#2
 433  00ba 81            	ret	
 468                     ; 277 uint16_t uip_ipchksum(void)
 468                     ; 278 {
 469                     	switch	.text
 470  00bb               _uip_ipchksum:
 472  00bb 89            	pushw	x
 473       00000002      OFST:	set	2
 476                     ; 281   sum = chksum(0, &uip_buf[UIP_LLH_LEN], UIP_IPH_LEN);
 478  00bc ae0014        	ldw	x,#20
 479  00bf 89            	pushw	x
 480  00c0 ae0185        	ldw	x,#_uip_buf+14
 481  00c3 89            	pushw	x
 482  00c4 5f            	clrw	x
 483  00c5 ad94          	call	L101_chksum
 485  00c7 5b04          	addw	sp,#4
 486  00c9 1f01          	ldw	(OFST-1,sp),x
 488                     ; 283   return (sum == 0) ? 0xffff : htons(sum);
 490  00cb 2603          	jrne	L62
 491  00cd 5a            	decw	x
 492  00ce 2003          	jra	L03
 493  00d0               L62:
 494  00d0 cd0b40        	call	_htons
 496  00d3               L03:
 499  00d3 5b02          	addw	sp,#2
 500  00d5 81            	ret	
 549                     ; 289 static uint16_t upper_layer_chksum(uint8_t proto)
 549                     ; 290 {
 550                     	switch	.text
 551  00d6               L112_upper_layer_chksum:
 553  00d6 88            	push	a
 554  00d7 5204          	subw	sp,#4
 555       00000004      OFST:	set	4
 558                     ; 294   upper_layer_len = (((uint16_t)(BUF->len[0]) << 8) + BUF->len[1]) - UIP_IPH_LEN;
 560  00d9 c60187        	ld	a,_uip_buf+16
 561  00dc 5f            	clrw	x
 562  00dd 97            	ld	xl,a
 563  00de 4f            	clr	a
 564  00df cb0188        	add	a,_uip_buf+17
 565  00e2 2401          	jrnc	L63
 566  00e4 5c            	incw	x
 567  00e5               L63:
 568  00e5 02            	rlwa	x,a
 569  00e6 1d0014        	subw	x,#20
 570  00e9 1f01          	ldw	(OFST-3,sp),x
 572                     ; 299   sum = upper_layer_len + proto;
 574  00eb 5f            	clrw	x
 575  00ec 7b05          	ld	a,(OFST+1,sp)
 576  00ee 97            	ld	xl,a
 577  00ef 72fb01        	addw	x,(OFST-3,sp)
 578  00f2 1f03          	ldw	(OFST-1,sp),x
 580                     ; 301   sum = chksum(sum, (uint8_t *)&BUF->srcipaddr[0], 2 * sizeof(uip_ipaddr_t));
 582  00f4 ae0008        	ldw	x,#8
 583  00f7 89            	pushw	x
 584  00f8 ae0191        	ldw	x,#_uip_buf+26
 585  00fb 89            	pushw	x
 586  00fc 1e07          	ldw	x,(OFST+3,sp)
 587  00fe cd005b        	call	L101_chksum
 589  0101 5b04          	addw	sp,#4
 590  0103 1f03          	ldw	(OFST-1,sp),x
 592                     ; 304   sum = chksum(sum, &uip_buf[UIP_IPH_LEN + UIP_LLH_LEN], upper_layer_len);
 594  0105 1e01          	ldw	x,(OFST-3,sp)
 595  0107 89            	pushw	x
 596  0108 ae0199        	ldw	x,#_uip_buf+34
 597  010b 89            	pushw	x
 598  010c 1e07          	ldw	x,(OFST+3,sp)
 599  010e cd005b        	call	L101_chksum
 601  0111 5b04          	addw	sp,#4
 602  0113 1f03          	ldw	(OFST-1,sp),x
 604                     ; 306   return (sum == 0) ? 0xffff : htons(sum);
 606  0115 2603          	jrne	L44
 607  0117 5a            	decw	x
 608  0118 2003          	jra	L64
 609  011a               L44:
 610  011a cd0b40        	call	_htons
 612  011d               L64:
 615  011d 5b05          	addw	sp,#5
 616  011f 81            	ret	
 640                     ; 311 uint16_t uip_tcpchksum(void)
 640                     ; 312 {
 641                     	switch	.text
 642  0120               _uip_tcpchksum:
 646                     ; 313   return upper_layer_chksum(UIP_PROTO_TCP);
 648  0120 a606          	ld	a,#6
 652  0122 20b2          	jp	L112_upper_layer_chksum
 679                     ; 319 void uip_init(void)
 679                     ; 320 {
 680                     	switch	.text
 681  0124               _uip_init:
 685                     ; 321   for (c = 0; c < UIP_LISTENPORTS; ++c) uip_listenports[c] = 0;
 687  0124 4f            	clr	a
 688  0125 c70003        	ld	L14_c,a
 689  0128               L352:
 692  0128 5f            	clrw	x
 693  0129 97            	ld	xl,a
 694  012a 58            	sllw	x
 695  012b 905f          	clrw	y
 696  012d df000a        	ldw	(_uip_listenports,x),y
 699  0130 725c0003      	inc	L14_c
 702  0134 c60003        	ld	a,L14_c
 703  0137 a105          	cp	a,#5
 704  0139 25ed          	jrult	L352
 705                     ; 322   for (c = 0; c < UIP_CONNS; ++c) uip_conns[c].tcpstateflags = UIP_CLOSED;
 707  013b 4f            	clr	a
 708  013c c70003        	ld	L14_c,a
 709  013f               L162:
 712  013f 97            	ld	xl,a
 713  0140 a628          	ld	a,#40
 714  0142 42            	mul	x,a
 715  0143 724f009a      	clr	(_uip_conns+25,x)
 718  0147 725c0003      	inc	L14_c
 721  014b c60003        	ld	a,L14_c
 722  014e a106          	cp	a,#6
 723  0150 25ed          	jrult	L162
 724                     ; 327   uip_init_stats();
 727                     ; 329 }
 730  0152 2000          	jp	_uip_init_stats
 754                     ; 333 void uip_init_stats(void)
 754                     ; 334 {
 755                     	switch	.text
 756  0154               _uip_init_stats:
 760                     ; 337   uip_stat.ip.drop = 0;
 762  0154 5f            	clrw	x
 763  0155 cf0027        	ldw	_uip_stat+2,x
 764  0158 cf0025        	ldw	_uip_stat,x
 765                     ; 338   uip_stat.ip.recv = 0;
 767  015b cf002b        	ldw	_uip_stat+6,x
 768  015e cf0029        	ldw	_uip_stat+4,x
 769                     ; 339   uip_stat.ip.sent = 0;
 771  0161 cf002f        	ldw	_uip_stat+10,x
 772  0164 cf002d        	ldw	_uip_stat+8,x
 773                     ; 340   uip_stat.ip.vhlerr = 0;
 775  0167 cf0033        	ldw	_uip_stat+14,x
 776  016a cf0031        	ldw	_uip_stat+12,x
 777                     ; 341   uip_stat.ip.hblenerr = 0;
 779  016d cf0037        	ldw	_uip_stat+18,x
 780  0170 cf0035        	ldw	_uip_stat+16,x
 781                     ; 342   uip_stat.ip.lblenerr = 0;
 783  0173 cf003b        	ldw	_uip_stat+22,x
 784  0176 cf0039        	ldw	_uip_stat+20,x
 785                     ; 343   uip_stat.ip.fragerr = 0;
 787  0179 cf003f        	ldw	_uip_stat+26,x
 788  017c cf003d        	ldw	_uip_stat+24,x
 789                     ; 344   uip_stat.ip.chkerr = 0;
 791  017f cf0043        	ldw	_uip_stat+30,x
 792  0182 cf0041        	ldw	_uip_stat+28,x
 793                     ; 345   uip_stat.ip.protoerr = 0;
 795  0185 cf0047        	ldw	_uip_stat+34,x
 796  0188 cf0045        	ldw	_uip_stat+32,x
 797                     ; 346   uip_stat.icmp.drop = 0;
 799  018b cf004b        	ldw	_uip_stat+38,x
 800  018e cf0049        	ldw	_uip_stat+36,x
 801                     ; 347   uip_stat.icmp.recv = 0;
 803  0191 cf004f        	ldw	_uip_stat+42,x
 804  0194 cf004d        	ldw	_uip_stat+40,x
 805                     ; 348   uip_stat.icmp.sent = 0;
 807  0197 cf0053        	ldw	_uip_stat+46,x
 808  019a cf0051        	ldw	_uip_stat+44,x
 809                     ; 349   uip_stat.icmp.typeerr = 0;
 811  019d cf0057        	ldw	_uip_stat+50,x
 812  01a0 cf0055        	ldw	_uip_stat+48,x
 813                     ; 350   uip_stat.tcp.drop = 0;
 815  01a3 cf005b        	ldw	_uip_stat+54,x
 816  01a6 cf0059        	ldw	_uip_stat+52,x
 817                     ; 351   uip_stat.tcp.recv = 0;
 819  01a9 cf005f        	ldw	_uip_stat+58,x
 820  01ac cf005d        	ldw	_uip_stat+56,x
 821                     ; 352   uip_stat.tcp.sent = 0;
 823  01af cf0063        	ldw	_uip_stat+62,x
 824  01b2 cf0061        	ldw	_uip_stat+60,x
 825                     ; 353   uip_stat.tcp.chkerr = 0;
 827  01b5 cf0067        	ldw	_uip_stat+66,x
 828  01b8 cf0065        	ldw	_uip_stat+64,x
 829                     ; 354   uip_stat.tcp.ackerr = 0;
 831  01bb cf006b        	ldw	_uip_stat+70,x
 832  01be cf0069        	ldw	_uip_stat+68,x
 833                     ; 355   uip_stat.tcp.rst = 0;
 835  01c1 cf006f        	ldw	_uip_stat+74,x
 836  01c4 cf006d        	ldw	_uip_stat+72,x
 837                     ; 356   uip_stat.tcp.rexmit = 0;
 839  01c7 cf0073        	ldw	_uip_stat+78,x
 840  01ca cf0071        	ldw	_uip_stat+76,x
 841                     ; 357   uip_stat.tcp.syndrop = 0;
 843  01cd cf0077        	ldw	_uip_stat+82,x
 844  01d0 cf0075        	ldw	_uip_stat+80,x
 845                     ; 358   uip_stat.tcp.synrst = 0;
 847  01d3 cf007b        	ldw	_uip_stat+86,x
 848  01d6 cf0079        	ldw	_uip_stat+84,x
 849                     ; 360 }
 852  01d9 81            	ret	
 886                     ; 364 void uip_unlisten(uint16_t port)
 886                     ; 365 {
 887                     	switch	.text
 888  01da               _uip_unlisten:
 890  01da 89            	pushw	x
 891       00000000      OFST:	set	0
 894                     ; 366   for (c = 0; c < UIP_LISTENPORTS; ++c) {
 896  01db 4f            	clr	a
 897  01dc c70003        	ld	L14_c,a
 898  01df               L313:
 899                     ; 367     if (uip_listenports[c] == port) {
 901  01df 5f            	clrw	x
 902  01e0 97            	ld	xl,a
 903  01e1 58            	sllw	x
 904  01e2 de000a        	ldw	x,(_uip_listenports,x)
 905  01e5 1301          	cpw	x,(OFST+1,sp)
 906  01e7 260a          	jrne	L123
 907                     ; 368       uip_listenports[c] = 0;
 909  01e9 5f            	clrw	x
 910  01ea 97            	ld	xl,a
 911  01eb 58            	sllw	x
 912  01ec 905f          	clrw	y
 913  01ee df000a        	ldw	(_uip_listenports,x),y
 914                     ; 369       return;
 916  01f1 200b          	jra	L66
 917  01f3               L123:
 918                     ; 366   for (c = 0; c < UIP_LISTENPORTS; ++c) {
 920  01f3 725c0003      	inc	L14_c
 923  01f7 c60003        	ld	a,L14_c
 924  01fa a105          	cp	a,#5
 925  01fc 25e1          	jrult	L313
 926                     ; 372 }
 927  01fe               L66:
 930  01fe 85            	popw	x
 931  01ff 81            	ret	
 965                     ; 376 void uip_listen(uint16_t port)
 965                     ; 377 {
 966                     	switch	.text
 967  0200               _uip_listen:
 969  0200 89            	pushw	x
 970       00000000      OFST:	set	0
 973                     ; 378   for (c = 0; c < UIP_LISTENPORTS; ++c) {
 975  0201 4f            	clr	a
 976  0202 c70003        	ld	L14_c,a
 977  0205               L733:
 978                     ; 379     if (uip_listenports[c] == 0) {
 980  0205 5f            	clrw	x
 981  0206 97            	ld	xl,a
 982  0207 58            	sllw	x
 983  0208 d6000b        	ld	a,(_uip_listenports+1,x)
 984  020b da000a        	or	a,(_uip_listenports,x)
 985  020e 2607          	jrne	L543
 986                     ; 380       uip_listenports[c] = port;
 988  0210 1601          	ldw	y,(OFST+1,sp)
 989  0212 df000a        	ldw	(_uip_listenports,x),y
 990                     ; 381       return;
 992  0215 200b          	jra	L27
 993  0217               L543:
 994                     ; 378   for (c = 0; c < UIP_LISTENPORTS; ++c) {
 996  0217 725c0003      	inc	L14_c
 999  021b c60003        	ld	a,L14_c
1000  021e a105          	cp	a,#5
1001  0220 25e3          	jrult	L733
1002                     ; 384 }
1003  0222               L27:
1006  0222 85            	popw	x
1007  0223 81            	ret	
1042                     ; 388 static void uip_add_rcv_nxt(uint16_t n)
1042                     ; 389 {
1043                     	switch	.text
1044  0224               L743_uip_add_rcv_nxt:
1048                     ; 390   uip_add32(uip_conn->rcv_nxt, n);
1050  0224 89            	pushw	x
1051  0225 ce0171        	ldw	x,_uip_conn
1052  0228 1c0008        	addw	x,#8
1053  022b cd0004        	call	_uip_add32
1055  022e 85            	popw	x
1056                     ; 391   uip_conn->rcv_nxt[0] = uip_acc32[0];
1058  022f ce0171        	ldw	x,_uip_conn
1059  0232 c6007d        	ld	a,_uip_acc32
1060  0235 e708          	ld	(8,x),a
1061                     ; 392   uip_conn->rcv_nxt[1] = uip_acc32[1];
1063  0237 c6007e        	ld	a,_uip_acc32+1
1064  023a e709          	ld	(9,x),a
1065                     ; 393   uip_conn->rcv_nxt[2] = uip_acc32[2];
1067  023c c6007f        	ld	a,_uip_acc32+2
1068  023f e70a          	ld	(10,x),a
1069                     ; 394   uip_conn->rcv_nxt[3] = uip_acc32[3];
1071  0241 c60080        	ld	a,_uip_acc32+3
1072  0244 e70b          	ld	(11,x),a
1073                     ; 395 }
1076  0246 81            	ret	
1363                     ; 399 void uip_process(uint8_t flag)
1363                     ; 400 {
1364                     	switch	.text
1365  0247               _uip_process:
1367  0247 88            	push	a
1368  0248 5205          	subw	sp,#5
1369       00000005      OFST:	set	5
1372                     ; 401   register struct uip_conn *uip_connr = uip_conn;
1374  024a ce0171        	ldw	x,_uip_conn
1375  024d 1f04          	ldw	(OFST-1,sp),x
1377                     ; 403   uip_sappdata = uip_appdata = &uip_buf[UIP_IPTCPH_LEN + UIP_LLH_LEN];
1379  024f ae01ad        	ldw	x,#_uip_buf+54
1380  0252 cf0175        	ldw	_uip_appdata,x
1381  0255 cf0016        	ldw	_uip_sappdata,x
1382                     ; 406   if (flag == UIP_POLL_REQUEST) {
1384  0258 a103          	cp	a,#3
1385  025a 2614          	jrne	L706
1386                     ; 407     if ((uip_connr->tcpstateflags & UIP_TS_MASK) == UIP_ESTABLISHED && !uip_outstanding(uip_connr)) {
1388  025c 1e04          	ldw	x,(OFST-1,sp)
1389  025e e619          	ld	a,(25,x)
1390  0260 a40f          	and	a,#15
1391  0262 a103          	cp	a,#3
1392  0264 2703cc0b35    	jrne	L744
1394  0269 e611          	ld	a,(17,x)
1395  026b ea10          	or	a,(16,x)
1396                     ; 408       uip_flags = UIP_POLL;
1397                     ; 409       UIP_APPCALL();
1399                     ; 410       goto appsend;
1401  026d cc033b        	jp	LC001
1402  0270               L706:
1403                     ; 416   else if (flag == UIP_TIMER) {
1405  0270 7b06          	ld	a,(OFST+1,sp)
1406  0272 a102          	cp	a,#2
1407  0274 2703cc035b    	jrne	L316
1408                     ; 418     if (++iss[3] == 0) {
1410  0279 725c0007      	inc	L73_iss+3
1411  027d 2610          	jrne	L716
1412                     ; 419       if (++iss[2] == 0) {
1414  027f 725c0006      	inc	L73_iss+2
1415  0283 260a          	jrne	L716
1416                     ; 420         if (++iss[1] == 0) {
1418  0285 725c0005      	inc	L73_iss+1
1419  0289 2604          	jrne	L716
1420                     ; 421           ++iss[0];
1422  028b 725c0004      	inc	L73_iss
1423  028f               L716:
1424                     ; 427     uip_len = 0;
1426  028f 5f            	clrw	x
1427  0290 cf0173        	ldw	_uip_len,x
1428                     ; 428     uip_slen = 0;
1430  0293 cf0014        	ldw	_uip_slen,x
1431                     ; 434     if (uip_connr->tcpstateflags == UIP_TIME_WAIT || uip_connr->tcpstateflags == UIP_FIN_WAIT_2) {
1433  0296 1e04          	ldw	x,(OFST-1,sp)
1434  0298 e619          	ld	a,(25,x)
1435  029a a107          	cp	a,#7
1436  029c 2704          	jreq	L726
1438  029e a105          	cp	a,#5
1439  02a0 260d          	jrne	L526
1440  02a2               L726:
1441                     ; 435       ++(uip_connr->timer);
1443  02a2 6c1a          	inc	(26,x)
1444                     ; 436       if (uip_connr->timer == UIP_TIME_WAIT_TIMEOUT) {
1446  02a4 e61a          	ld	a,(26,x)
1447  02a6 a178          	cp	a,#120
1448  02a8 26bc          	jrne	L744
1449                     ; 437         uip_connr->tcpstateflags = UIP_CLOSED;
1451  02aa 6f19          	clr	(25,x)
1452  02ac cc0b35        	jra	L744
1453  02af               L526:
1454                     ; 440     else if (uip_connr->tcpstateflags != UIP_CLOSED) {
1456  02af e619          	ld	a,(25,x)
1457  02b1 27f9          	jreq	L744
1458                     ; 444       if (uip_outstanding(uip_connr)) {
1460  02b3 e611          	ld	a,(17,x)
1461  02b5 ea10          	or	a,(16,x)
1462  02b7 277c          	jreq	L736
1463                     ; 445         if (uip_connr->timer-- == 0) {
1465  02b9 e61a          	ld	a,(26,x)
1466  02bb 6a1a          	dec	(26,x)
1467  02bd 4d            	tnz	a
1468  02be 26ec          	jrne	L744
1469                     ; 446           if (uip_connr->nrtx == UIP_MAXRTX
1469                     ; 447 	    || ((uip_connr->tcpstateflags == UIP_SYN_SENT
1469                     ; 448             || uip_connr->tcpstateflags == UIP_SYN_RCVD)
1469                     ; 449             && uip_connr->nrtx == UIP_MAXSYNRTX)) {
1471  02c0 e61b          	ld	a,(27,x)
1472  02c2 a108          	cp	a,#8
1473  02c4 270f          	jreq	L546
1475  02c6 e619          	ld	a,(25,x)
1476  02c8 a102          	cp	a,#2
1477  02ca 2703          	jreq	L746
1479  02cc 4a            	dec	a
1480  02cd 2616          	jrne	L346
1481  02cf               L746:
1483  02cf e61b          	ld	a,(27,x)
1484  02d1 a105          	cp	a,#5
1485  02d3 2610          	jrne	L346
1486  02d5               L546:
1487                     ; 450             uip_connr->tcpstateflags = UIP_CLOSED;
1489  02d5 6f19          	clr	(25,x)
1490                     ; 455             uip_flags = UIP_TIMEDOUT;
1492  02d7 35800024      	mov	_uip_flags,#128
1493                     ; 456             UIP_APPCALL();
1495  02db cd0000        	call	_uip_TcpAppHubCall
1497                     ; 459             BUF->flags = TCP_RST | TCP_ACK;
1499  02de 351401a6      	mov	_uip_buf+47,#20
1500                     ; 460             goto tcp_send_nodata;
1502  02e2 cc0968        	jra	L334
1503  02e5               L346:
1504                     ; 464 	  if (uip_connr->nrtx > 4) uip_connr->nrtx = 4;
1506  02e5 1e04          	ldw	x,(OFST-1,sp)
1507  02e7 e61b          	ld	a,(27,x)
1508  02e9 a105          	cp	a,#5
1509  02eb 2504          	jrult	L156
1512  02ed a604          	ld	a,#4
1513  02ef e71b          	ld	(27,x),a
1514  02f1               L156:
1515                     ; 465 	  uip_connr->timer = (uint8_t)(UIP_RTO << uip_connr->nrtx);
1517  02f1 5f            	clrw	x
1518  02f2 97            	ld	xl,a
1519  02f3 a603          	ld	a,#3
1520  02f5 5d            	tnzw	x
1521  02f6 2704          	jreq	L601
1522  02f8               L011:
1523  02f8 48            	sll	a
1524  02f9 5a            	decw	x
1525  02fa 26fc          	jrne	L011
1526  02fc               L601:
1527  02fc 1e04          	ldw	x,(OFST-1,sp)
1528  02fe e71a          	ld	(26,x),a
1529                     ; 466 	  ++(uip_connr->nrtx);
1531  0300 6c1b          	inc	(27,x)
1532                     ; 474           UIP_STAT(++uip_stat.tcp.rexmit);
1534  0302 ae0071        	ldw	x,#_uip_stat+76
1535  0305 a601          	ld	a,#1
1536  0307 cd0000        	call	c_lgadc
1538                     ; 475           switch (uip_connr->tcpstateflags & UIP_TS_MASK) {
1540  030a 1e04          	ldw	x,(OFST-1,sp)
1541  030c e619          	ld	a,(25,x)
1542  030e a40f          	and	a,#15
1544                     ; 489             case UIP_FIN_WAIT_1:
1544                     ; 490             case UIP_CLOSING:
1544                     ; 491             case UIP_LAST_ACK:
1544                     ; 492               /* In all these states we should retransmit a FINACK. */
1544                     ; 493               goto tcp_send_finack;
1545  0310 4a            	dec	a
1546  0311 2603cc0717    	jreq	L104
1547  0316 a002          	sub	a,#2
1548  0318 2711          	jreq	L763
1549  031a 4a            	dec	a
1550  031b 2603cc0964    	jreq	LC003
1551  0320 a002          	sub	a,#2
1552  0322 27f9          	jreq	LC003
1553  0324 a002          	sub	a,#2
1554  0326 27f5          	jreq	LC003
1555  0328 cc0b35        	jra	L744
1556  032b               L763:
1557                     ; 480             case UIP_ESTABLISHED:
1557                     ; 481               /* In the ESTABLISHED state, we call upon the application
1557                     ; 482                  to do the actual retransmit after which we jump into
1557                     ; 483                  the code for sending out the packet (the apprexmit
1557                     ; 484                  label). */
1557                     ; 485               uip_flags = UIP_REXMIT;
1559  032b 35040024      	mov	_uip_flags,#4
1560                     ; 486               UIP_APPCALL();
1562  032f cd0000        	call	_uip_TcpAppHubCall
1564                     ; 487               goto apprexmit;
1566  0332 cc09ab        	jra	L514
1567                     ; 489             case UIP_FIN_WAIT_1:
1567                     ; 490             case UIP_CLOSING:
1567                     ; 491             case UIP_LAST_ACK:
1567                     ; 492               /* In all these states we should retransmit a FINACK. */
1567                     ; 493               goto tcp_send_finack;
1569  0335               L736:
1570                     ; 498       else if ((uip_connr->tcpstateflags & UIP_TS_MASK) == UIP_ESTABLISHED) {
1572  0335 e619          	ld	a,(25,x)
1573  0337 a40f          	and	a,#15
1574  0339 a103          	cp	a,#3
1575                     ; 500         uip_flags = UIP_POLL;
1577  033b               LC001:
1578  033b 26eb          	jrne	L744
1580  033d 35080024      	mov	_uip_flags,#8
1581                     ; 501         UIP_APPCALL();
1584                     ; 502         goto appsend;
1585  0341               L314:
1589  0341 cd0000        	call	_uip_TcpAppHubCall
1590                     ; 972         appsend:
1590                     ; 973 
1590                     ; 974         if (uip_flags & UIP_ABORT) {
1592  0344 720a002403cc  	btjf	_uip_flags,#5,L7211
1593                     ; 975           uip_slen = 0;
1595  034c 5f            	clrw	x
1596  034d cf0014        	ldw	_uip_slen,x
1597                     ; 976           uip_connr->tcpstateflags = UIP_CLOSED;
1599  0350 1e04          	ldw	x,(OFST-1,sp)
1600                     ; 977           BUF->flags = TCP_RST | TCP_ACK;
1602  0352 351401a6      	mov	_uip_buf+47,#20
1603  0356 6f19          	clr	(25,x)
1604                     ; 978           goto tcp_send_nodata;
1606  0358 cc0968        	jra	L334
1607  035b               L316:
1608                     ; 512   UIP_STAT(++uip_stat.ip.recv);
1610  035b ae0029        	ldw	x,#_uip_stat+4
1611  035e a601          	ld	a,#1
1612  0360 cd0000        	call	c_lgadc
1614                     ; 517   if (BUF->vhl != 0x45) { /* IP version and header length. */
1616  0363 c60185        	ld	a,_uip_buf+14
1617  0366 a145          	cp	a,#69
1618  0368 2713          	jreq	L366
1619                     ; 518     UIP_STAT(++uip_stat.ip.drop);
1621  036a ae0025        	ldw	x,#_uip_stat
1622  036d a601          	ld	a,#1
1623  036f cd0000        	call	c_lgadc
1625                     ; 519     UIP_STAT(++uip_stat.ip.vhlerr);
1627  0372 ae0031        	ldw	x,#_uip_stat+12
1628  0375 a601          	ld	a,#1
1629  0377 cd0000        	call	c_lgadc
1631                     ; 520     goto drop;
1633  037a cc0b35        	jra	L744
1634  037d               L366:
1635                     ; 529   if ((BUF->len[0] << 8) + BUF->len[1] <= uip_len) {
1637  037d c60187        	ld	a,_uip_buf+16
1638  0380 5f            	clrw	x
1639  0381 97            	ld	xl,a
1640  0382 4f            	clr	a
1641  0383 cb0188        	add	a,_uip_buf+17
1642  0386 2401          	jrnc	L611
1643  0388 5c            	incw	x
1644  0389               L611:
1645  0389 02            	rlwa	x,a
1646  038a c30173        	cpw	x,_uip_len
1647  038d 22eb          	jrugt	L744
1648                     ; 530     uip_len = (BUF->len[0] << 8) + BUF->len[1];
1650  038f c60187        	ld	a,_uip_buf+16
1651  0392 5f            	clrw	x
1652  0393 97            	ld	xl,a
1653  0394 4f            	clr	a
1654  0395 cb0188        	add	a,_uip_buf+17
1655  0398 2401          	jrnc	L021
1656  039a 5c            	incw	x
1657  039b               L021:
1658  039b c70174        	ld	_uip_len+1,a
1659  039e 9f            	ld	a,xl
1660  039f c70173        	ld	_uip_len,a
1662                     ; 535   if ((BUF->ipoffset[0] & 0x3f) != 0 || BUF->ipoffset[1] != 0) {
1664  03a2 c6018b        	ld	a,_uip_buf+20
1665  03a5 a53f          	bcp	a,#63
1666  03a7 2605          	jrne	L376
1668  03a9 c6018c        	ld	a,_uip_buf+21
1669  03ac 2713          	jreq	L176
1670  03ae               L376:
1671                     ; 536     UIP_STAT(++uip_stat.ip.drop);
1673  03ae ae0025        	ldw	x,#_uip_stat
1674  03b1 a601          	ld	a,#1
1675  03b3 cd0000        	call	c_lgadc
1677                     ; 537     UIP_STAT(++uip_stat.ip.fragerr);
1679  03b6 ae003d        	ldw	x,#_uip_stat+24
1680  03b9 a601          	ld	a,#1
1681  03bb cd0000        	call	c_lgadc
1683                     ; 538     goto drop;
1685  03be cc0b35        	jra	L744
1686  03c1               L176:
1687                     ; 542   if (!uip_ipaddr_cmp(BUF->destipaddr, uip_hostaddr)) {
1689  03c1 ce0195        	ldw	x,_uip_buf+30
1690  03c4 c30020        	cpw	x,_uip_hostaddr
1691  03c7 2608          	jrne	L776
1693  03c9 ce0197        	ldw	x,_uip_buf+32
1694  03cc c30022        	cpw	x,_uip_hostaddr+2
1695  03cf 270b          	jreq	L576
1696  03d1               L776:
1697                     ; 543     UIP_STAT(++uip_stat.ip.drop);
1699  03d1 ae0025        	ldw	x,#_uip_stat
1700  03d4 a601          	ld	a,#1
1701  03d6 cd0000        	call	c_lgadc
1703                     ; 544     goto drop;
1705  03d9 cc0b35        	jra	L744
1706  03dc               L576:
1707                     ; 547   if (uip_ipchksum() != 0xffff) { /* Compute and check the IP header checksum. */
1709  03dc cd00bb        	call	_uip_ipchksum
1711  03df 5c            	incw	x
1712  03e0 2713          	jreq	L107
1713                     ; 548     UIP_STAT(++uip_stat.ip.drop);
1715  03e2 ae0025        	ldw	x,#_uip_stat
1716  03e5 a601          	ld	a,#1
1717  03e7 cd0000        	call	c_lgadc
1719                     ; 549     UIP_STAT(++uip_stat.ip.chkerr);
1721  03ea ae0041        	ldw	x,#_uip_stat+28
1722  03ed a601          	ld	a,#1
1723  03ef cd0000        	call	c_lgadc
1725                     ; 550     goto drop;
1727  03f2 cc0b35        	jra	L744
1728  03f5               L107:
1729                     ; 553   if (BUF->proto == UIP_PROTO_TCP) {
1731  03f5 c6018e        	ld	a,_uip_buf+23
1732  03f8 a106          	cp	a,#6
1733  03fa 2624          	jrne	L307
1734                     ; 555     goto tcp_input;
1735                     ; 600   tcp_input:
1735                     ; 601   UIP_STAT(++uip_stat.tcp.recv);
1737  03fc ae005d        	ldw	x,#_uip_stat+56
1738  03ff a601          	ld	a,#1
1739  0401 cd0000        	call	c_lgadc
1741                     ; 605   if (uip_tcpchksum() != 0xffff) { /* Compute and check the TCP checksum. */
1743  0404 cd0120        	call	_uip_tcpchksum
1745  0407 5c            	incw	x
1746  0408 2603cc0499    	jreq	L527
1747                     ; 606     UIP_STAT(++uip_stat.tcp.drop);
1749  040d ae0059        	ldw	x,#_uip_stat+52
1750  0410 a601          	ld	a,#1
1751  0412 cd0000        	call	c_lgadc
1753                     ; 607     UIP_STAT(++uip_stat.tcp.chkerr);
1755  0415 ae0065        	ldw	x,#_uip_stat+64
1756  0418 a601          	ld	a,#1
1757  041a cd0000        	call	c_lgadc
1759                     ; 608     goto drop;
1761  041d cc0b35        	jra	L744
1762  0420               L307:
1763                     ; 562   if (BUF->proto != UIP_PROTO_ICMP) { /* We only allow ICMP packets from here. */
1765  0420 4a            	dec	a
1766  0421 2713          	jreq	L507
1767                     ; 563     UIP_STAT(++uip_stat.ip.drop);
1769  0423 ae0025        	ldw	x,#_uip_stat
1770  0426 a601          	ld	a,#1
1771  0428 cd0000        	call	c_lgadc
1773                     ; 564     UIP_STAT(++uip_stat.ip.protoerr);
1775  042b ae0045        	ldw	x,#_uip_stat+32
1776  042e a601          	ld	a,#1
1777  0430 cd0000        	call	c_lgadc
1779                     ; 565     goto drop;
1781  0433 cc0b35        	jra	L744
1782  0436               L507:
1783                     ; 568   UIP_STAT(++uip_stat.icmp.recv);
1785  0436 ae004d        	ldw	x,#_uip_stat+40
1786  0439 4c            	inc	a
1787  043a cd0000        	call	c_lgadc
1789                     ; 573   if (ICMPBUF->type != ICMP_ECHO) {
1791  043d c60199        	ld	a,_uip_buf+34
1792  0440 a108          	cp	a,#8
1793  0442 2713          	jreq	L707
1794                     ; 574     UIP_STAT(++uip_stat.icmp.drop);
1796  0444 ae0049        	ldw	x,#_uip_stat+36
1797  0447 a601          	ld	a,#1
1798  0449 cd0000        	call	c_lgadc
1800                     ; 575     UIP_STAT(++uip_stat.icmp.typeerr);
1802  044c ae0055        	ldw	x,#_uip_stat+48
1803  044f a601          	ld	a,#1
1804  0451 cd0000        	call	c_lgadc
1806                     ; 576     goto drop;
1808  0454 cc0b35        	jra	L744
1809  0457               L707:
1810                     ; 579   ICMPBUF->type = ICMP_ECHO_REPLY;
1812  0457 725f0199      	clr	_uip_buf+34
1813                     ; 581   if (ICMPBUF->icmpchksum >= HTONS(0xffff - (ICMP_ECHO << 8))) {
1815  045b ce019b        	ldw	x,_uip_buf+36
1816  045e a3f7ff        	cpw	x,#63487
1817  0461 2505          	jrult	L117
1818                     ; 582     ICMPBUF->icmpchksum += HTONS(ICMP_ECHO << 8) + 1;
1820  0463 1c0801        	addw	x,#2049
1822  0466 2003          	jra	L517
1823  0468               L117:
1824                     ; 585     ICMPBUF->icmpchksum += HTONS(ICMP_ECHO << 8);
1826  0468 1c0800        	addw	x,#2048
1827  046b               L517:
1828  046b cf019b        	ldw	_uip_buf+36,x
1829                     ; 589   uip_ipaddr_copy(BUF->destipaddr, BUF->srcipaddr);
1831  046e ce0191        	ldw	x,_uip_buf+26
1832  0471 cf0195        	ldw	_uip_buf+30,x
1835  0474 ce0193        	ldw	x,_uip_buf+28
1836  0477 cf0197        	ldw	_uip_buf+32,x
1837                     ; 590   uip_ipaddr_copy(BUF->srcipaddr, uip_hostaddr);
1839  047a ce0020        	ldw	x,_uip_hostaddr
1840  047d cf0191        	ldw	_uip_buf+26,x
1843  0480 ce0022        	ldw	x,_uip_hostaddr+2
1844  0483 cf0193        	ldw	_uip_buf+28,x
1845                     ; 592   UIP_STAT(++uip_stat.icmp.sent);
1847  0486 ae0051        	ldw	x,#_uip_stat+44
1849                     ; 593   goto send;
1850  0489               L544:
1851  0489 a601          	ld	a,#1
1852  048b cd0000        	call	c_lgadc
1853                     ; 1189   send:
1853                     ; 1190 
1853                     ; 1191   UIP_STAT(++uip_stat.ip.sent);
1855  048e ae002d        	ldw	x,#_uip_stat+8
1856  0491 a601          	ld	a,#1
1857  0493 cd0000        	call	c_lgadc
1859                     ; 1193   uip_flags = 0;
1860                     ; 1195   return;
1862  0496 cc0b39        	jra	L602
1863  0499               L527:
1864                     ; 613   for (uip_connr = &uip_conns[0]; uip_connr <= &uip_conns[UIP_CONNS - 1]; ++uip_connr) {
1866  0499 ae0081        	ldw	x,#_uip_conns
1868  049c 204d          	jra	L337
1869  049e               L727:
1870                     ; 614     if (uip_connr->tcpstateflags != UIP_CLOSED
1870                     ; 615       && BUF->destport == uip_connr->lport
1870                     ; 616       && BUF->srcport == uip_connr->rport
1870                     ; 617       && uip_ipaddr_cmp(BUF->srcipaddr, uip_connr->ripaddr)) {
1872  049e e619          	ld	a,(25,x)
1873  04a0 2746          	jreq	L737
1875  04a2 9093          	ldw	y,x
1876  04a4 90ee04        	ldw	y,(4,y)
1877  04a7 90c3019b      	cpw	y,_uip_buf+36
1878  04ab 263b          	jrne	L737
1880  04ad 9093          	ldw	y,x
1881  04af 90ee06        	ldw	y,(6,y)
1882  04b2 90c30199      	cpw	y,_uip_buf+34
1883  04b6 2630          	jrne	L737
1885  04b8 9093          	ldw	y,x
1886  04ba 90fe          	ldw	y,(y)
1887  04bc 90c30191      	cpw	y,_uip_buf+26
1888  04c0 2626          	jrne	L737
1890  04c2 9093          	ldw	y,x
1891  04c4 90ee02        	ldw	y,(2,y)
1892  04c7 90c30193      	cpw	y,_uip_buf+28
1893  04cb 261b          	jrne	L737
1894                     ; 618       goto found;
1895                     ; 800   found:
1895                     ; 801   /* found will be jumped to if we found an active connection. */
1895                     ; 802   uip_conn = uip_connr;
1897  04cd cf0171        	ldw	_uip_conn,x
1898                     ; 803   uip_flags = 0;
1900  04d0 725f0024      	clr	_uip_flags
1901                     ; 808   if (BUF->flags & TCP_RST) {
1903  04d4 720401a603cc  	btjf	_uip_buf+47,#2,L7401
1904                     ; 809     uip_connr->tcpstateflags = UIP_CLOSED;
1906  04dc 6f19          	clr	(25,x)
1907                     ; 810     uip_flags = UIP_ABORT;
1909  04de 35200024      	mov	_uip_flags,#32
1910                     ; 811     UIP_APPCALL();
1912  04e2 cd0000        	call	_uip_TcpAppHubCall
1914                     ; 812     goto drop;
1916  04e5 cc0b35        	jra	L744
1917  04e8               L737:
1918                     ; 613   for (uip_connr = &uip_conns[0]; uip_connr <= &uip_conns[UIP_CONNS - 1]; ++uip_connr) {
1920  04e8 1c0028        	addw	x,#40
1921  04eb               L337:
1922  04eb 1f04          	ldw	(OFST-1,sp),x
1926  04ed a30149        	cpw	x,#_uip_conns+200
1927  04f0 23ac          	jrule	L727
1928                     ; 626   if ((BUF->flags & TCP_CTL) != TCP_SYN) {
1930  04f2 c601a6        	ld	a,_uip_buf+47
1931  04f5 a43f          	and	a,#63
1932  04f7 a102          	cp	a,#2
1933  04f9 2647          	jrne	L573
1934                     ; 627     goto reset;
1936                     ; 630   tmp16 = BUF->destport;
1938  04fb ce019b        	ldw	x,_uip_buf+36
1939  04fe cf0000        	ldw	L54_tmp16,x
1940                     ; 632   for (c = 0; c < UIP_LISTENPORTS; ++c) {
1942  0501 4f            	clr	a
1943  0502 c70003        	ld	L14_c,a
1944  0505               L347:
1945                     ; 633     if (tmp16 == uip_listenports[c]) goto found_listen;
1947  0505 5f            	clrw	x
1948  0506 97            	ld	xl,a
1949  0507 58            	sllw	x
1950  0508 9093          	ldw	y,x
1951  050a 90de000a      	ldw	y,(_uip_listenports,y)
1952  050e 90c30000      	cpw	y,L54_tmp16
1953  0512 261b          	jrne	L157
1955                     ; 695   found_listen:
1955                     ; 696   /* found_listen will be jumped to if we matched the incoming packet
1955                     ; 697      with a connection in LISTEN. In that case, we should create a new
1955                     ; 698      connection and send a SYNACK in return. */
1955                     ; 699   /* First we check if there are any connections avaliable. Unused
1955                     ; 700      connections are kept in the same table as used connections, but
1955                     ; 701      unused ones have the tcpstate set to CLOSED. Also, connections in
1955                     ; 702      TIME_WAIT are kept track of and we'll use the oldest one if no
1955                     ; 703      CLOSED connections are found. Thanks to Eddie C. Dost for a very
1955                     ; 704      nice algorithm for the TIME_WAIT search. */
1955                     ; 705   uip_connr = 0;
1957  0514 5f            	clrw	x
1958  0515 1f04          	ldw	(OFST-1,sp),x
1960                     ; 706   for (c = 0; c < UIP_CONNS; ++c) {
1962  0517 4f            	clr	a
1963  0518 c70003        	ld	L14_c,a
1964  051b               L377:
1965                     ; 707     if (uip_conns[c].tcpstateflags == UIP_CLOSED) {
1967  051b 97            	ld	xl,a
1968  051c a628          	ld	a,#40
1969  051e 42            	mul	x,a
1970  051f d6009a        	ld	a,(_uip_conns+25,x)
1971  0522 2703cc05dc    	jrne	L1001
1972                     ; 708       uip_connr = &uip_conns[c];
1974  0527 1c0081        	addw	x,#_uip_conns
1975  052a 1f04          	ldw	(OFST-1,sp),x
1977                     ; 709       break;
1979  052c cc060e        	jra	L777
1980  052f               L157:
1981                     ; 632   for (c = 0; c < UIP_LISTENPORTS; ++c) {
1983  052f 725c0003      	inc	L14_c
1986  0533 c60003        	ld	a,L14_c
1987  0536 a105          	cp	a,#5
1988  0538 25cb          	jrult	L347
1989                     ; 637   UIP_STAT(++uip_stat.tcp.synrst);
1991  053a ae0079        	ldw	x,#_uip_stat+84
1992  053d a601          	ld	a,#1
1993  053f cd0000        	call	c_lgadc
1995  0542               L573:
1996                     ; 642   reset:
1996                     ; 643   /* We do not send resets in response to resets. */
1996                     ; 644   if (BUF->flags & TCP_RST) goto drop;
1998  0542 720401a69e    	btjt	_uip_buf+47,#2,L744
2001                     ; 646   UIP_STAT(++uip_stat.tcp.rst);
2003  0547 ae006d        	ldw	x,#_uip_stat+72
2004  054a a601          	ld	a,#1
2005  054c cd0000        	call	c_lgadc
2007                     ; 648   BUF->flags = TCP_RST | TCP_ACK;
2009  054f 351401a6      	mov	_uip_buf+47,#20
2010                     ; 649   uip_len = UIP_IPTCPH_LEN;
2012  0553 ae0028        	ldw	x,#40
2013  0556 cf0173        	ldw	_uip_len,x
2014                     ; 650   BUF->tcpoffset = 5 << 4;
2016  0559 355001a5      	mov	_uip_buf+46,#80
2017                     ; 653   c = BUF->seqno[3];
2019  055d 5501a00003    	mov	L14_c,_uip_buf+41
2020                     ; 654   BUF->seqno[3] = BUF->ackno[3];
2022  0562 5501a401a0    	mov	_uip_buf+41,_uip_buf+45
2023                     ; 655   BUF->ackno[3] = c;
2025  0567 55000301a4    	mov	_uip_buf+45,L14_c
2026                     ; 657   c = BUF->seqno[2];
2028  056c 55019f0003    	mov	L14_c,_uip_buf+40
2029                     ; 658   BUF->seqno[2] = BUF->ackno[2];
2031  0571 5501a3019f    	mov	_uip_buf+40,_uip_buf+44
2032                     ; 659   BUF->ackno[2] = c;
2034  0576 55000301a3    	mov	_uip_buf+44,L14_c
2035                     ; 661   c = BUF->seqno[1];
2037  057b 55019e0003    	mov	L14_c,_uip_buf+39
2038                     ; 662   BUF->seqno[1] = BUF->ackno[1];
2040  0580 5501a2019e    	mov	_uip_buf+39,_uip_buf+43
2041                     ; 663   BUF->ackno[1] = c;
2043  0585 55000301a2    	mov	_uip_buf+43,L14_c
2044                     ; 665   c = BUF->seqno[0];
2046  058a 55019d0003    	mov	L14_c,_uip_buf+38
2047                     ; 666   BUF->seqno[0] = BUF->ackno[0];
2049  058f 5501a1019d    	mov	_uip_buf+38,_uip_buf+42
2050                     ; 667   BUF->ackno[0] = c;
2052  0594 55000301a1    	mov	_uip_buf+42,L14_c
2053                     ; 672   if (++BUF->ackno[3] == 0) {
2055  0599 725c01a4      	inc	_uip_buf+45
2056  059d 2610          	jrne	L557
2057                     ; 673     if (++BUF->ackno[2] == 0) {
2059  059f 725c01a3      	inc	_uip_buf+44
2060  05a3 260a          	jrne	L557
2061                     ; 674       if (++BUF->ackno[1] == 0) {
2063  05a5 725c01a2      	inc	_uip_buf+43
2064  05a9 2604          	jrne	L557
2065                     ; 675         ++BUF->ackno[0];
2067  05ab 725c01a1      	inc	_uip_buf+42
2068  05af               L557:
2069                     ; 681   tmp16 = BUF->srcport;
2071  05af ce0199        	ldw	x,_uip_buf+34
2072  05b2 cf0000        	ldw	L54_tmp16,x
2073                     ; 682   BUF->srcport = BUF->destport;
2075  05b5 ce019b        	ldw	x,_uip_buf+36
2076  05b8 cf0199        	ldw	_uip_buf+34,x
2077                     ; 683   BUF->destport = tmp16;
2079  05bb ce0000        	ldw	x,L54_tmp16
2080  05be cf019b        	ldw	_uip_buf+36,x
2081                     ; 686   uip_ipaddr_copy(BUF->destipaddr, BUF->srcipaddr);
2083  05c1 ce0191        	ldw	x,_uip_buf+26
2084  05c4 cf0195        	ldw	_uip_buf+30,x
2087  05c7 ce0193        	ldw	x,_uip_buf+28
2088  05ca cf0197        	ldw	_uip_buf+32,x
2089                     ; 687   uip_ipaddr_copy(BUF->srcipaddr, uip_hostaddr);
2091  05cd ce0020        	ldw	x,_uip_hostaddr
2092  05d0 cf0191        	ldw	_uip_buf+26,x
2095  05d3 ce0022        	ldw	x,_uip_hostaddr+2
2096  05d6 cf0193        	ldw	_uip_buf+28,x
2097                     ; 690   goto tcp_send_noconn;
2099  05d9 cc0ae2        	jra	L144
2100  05dc               L1001:
2101                     ; 711     if (uip_conns[c].tcpstateflags == UIP_TIME_WAIT) {
2103  05dc a107          	cp	a,#7
2104  05de 2620          	jrne	L3001
2105                     ; 712       if (uip_connr == 0 || uip_conns[c].timer > uip_connr->timer) {
2107  05e0 1e04          	ldw	x,(OFST-1,sp)
2108  05e2 2710          	jreq	L7001
2110  05e4 c60003        	ld	a,L14_c
2111  05e7 97            	ld	xl,a
2112  05e8 a628          	ld	a,#40
2113  05ea 42            	mul	x,a
2114  05eb d6009b        	ld	a,(_uip_conns+26,x)
2115  05ee 1e04          	ldw	x,(OFST-1,sp)
2116  05f0 e11a          	cp	a,(26,x)
2117  05f2 230c          	jrule	L3001
2118  05f4               L7001:
2119                     ; 713         uip_connr = &uip_conns[c];
2121  05f4 c60003        	ld	a,L14_c
2122  05f7 97            	ld	xl,a
2123  05f8 a628          	ld	a,#40
2124  05fa 42            	mul	x,a
2125  05fb 1c0081        	addw	x,#_uip_conns
2126  05fe 1f04          	ldw	(OFST-1,sp),x
2128  0600               L3001:
2129                     ; 706   for (c = 0; c < UIP_CONNS; ++c) {
2131  0600 725c0003      	inc	L14_c
2134  0604 c60003        	ld	a,L14_c
2135  0607 a106          	cp	a,#6
2136  0609 2403cc051b    	jrult	L377
2137  060e               L777:
2138                     ; 718   if (uip_connr == 0) {
2140  060e 1e04          	ldw	x,(OFST-1,sp)
2141  0610 260b          	jrne	L1101
2142                     ; 722     UIP_STAT(++uip_stat.tcp.syndrop);
2144  0612 ae0075        	ldw	x,#_uip_stat+80
2145  0615 a601          	ld	a,#1
2146  0617 cd0000        	call	c_lgadc
2148                     ; 723     goto drop;
2150  061a cc0b35        	jra	L744
2151  061d               L1101:
2152                     ; 725   uip_conn = uip_connr;
2154  061d cf0171        	ldw	_uip_conn,x
2155                     ; 728   uip_connr->rto = uip_connr->timer = UIP_RTO;
2157  0620 a603          	ld	a,#3
2158  0622 e71a          	ld	(26,x),a
2159  0624 e718          	ld	(24,x),a
2160                     ; 729   uip_connr->sa = 0;
2162  0626 6f16          	clr	(22,x)
2163                     ; 730   uip_connr->sv = 4;
2165  0628 4c            	inc	a
2166  0629 e717          	ld	(23,x),a
2167                     ; 731   uip_connr->nrtx = 0;
2169  062b 6f1b          	clr	(27,x)
2170                     ; 732   uip_connr->lport = BUF->destport;
2172  062d 90ce019b      	ldw	y,_uip_buf+36
2173  0631 ef04          	ldw	(4,x),y
2174                     ; 733   uip_connr->rport = BUF->srcport;
2176  0633 90ce0199      	ldw	y,_uip_buf+34
2177  0637 ef06          	ldw	(6,x),y
2178                     ; 734   uip_ipaddr_copy(uip_connr->ripaddr, BUF->srcipaddr);
2180  0639 90ce0191      	ldw	y,_uip_buf+26
2181  063d ff            	ldw	(x),y
2184  063e 90ce0193      	ldw	y,_uip_buf+28
2185  0642 ef02          	ldw	(2,x),y
2186                     ; 735   uip_connr->tcpstateflags = UIP_SYN_RCVD;
2188  0644 a601          	ld	a,#1
2189  0646 e719          	ld	(25,x),a
2190                     ; 737   uip_connr->snd_nxt[0] = iss[0];
2192  0648 c60004        	ld	a,L73_iss
2193  064b e70c          	ld	(12,x),a
2194                     ; 738   uip_connr->snd_nxt[1] = iss[1];
2196  064d c60005        	ld	a,L73_iss+1
2197  0650 e70d          	ld	(13,x),a
2198                     ; 739   uip_connr->snd_nxt[2] = iss[2];
2200  0652 c60006        	ld	a,L73_iss+2
2201  0655 e70e          	ld	(14,x),a
2202                     ; 740   uip_connr->snd_nxt[3] = iss[3];
2204  0657 c60007        	ld	a,L73_iss+3
2205  065a e70f          	ld	(15,x),a
2206                     ; 741   uip_connr->len = 1;
2208  065c 90ae0001      	ldw	y,#1
2209  0660 ef10          	ldw	(16,x),y
2210                     ; 744   uip_connr->rcv_nxt[3] = BUF->seqno[3];
2212  0662 c601a0        	ld	a,_uip_buf+41
2213  0665 e70b          	ld	(11,x),a
2214                     ; 745   uip_connr->rcv_nxt[2] = BUF->seqno[2];
2216  0667 c6019f        	ld	a,_uip_buf+40
2217  066a e70a          	ld	(10,x),a
2218                     ; 746   uip_connr->rcv_nxt[1] = BUF->seqno[1];
2220  066c c6019e        	ld	a,_uip_buf+39
2221  066f e709          	ld	(9,x),a
2222                     ; 747   uip_connr->rcv_nxt[0] = BUF->seqno[0];
2224  0671 c6019d        	ld	a,_uip_buf+38
2225  0674 e708          	ld	(8,x),a
2226                     ; 748   uip_add_rcv_nxt(1);
2228  0676 ae0001        	ldw	x,#1
2229  0679 cd0224        	call	L743_uip_add_rcv_nxt
2231                     ; 751   if ((BUF->tcpoffset & 0xf0) > 0x50) {
2233  067c c601a5        	ld	a,_uip_buf+46
2234  067f a4f0          	and	a,#240
2235  0681 a151          	cp	a,#81
2236  0683 2403cc0717    	jrult	L104
2237                     ; 752     for (c = 0; c < ((BUF->tcpoffset >> 4) - 5) << 2;) {
2239  0688 725f0003      	clr	L14_c
2241  068c 206b          	jra	L5201
2242  068e               L1201:
2243                     ; 753       opt = uip_buf[UIP_TCPIP_HLEN + UIP_LLH_LEN + c];
2245  068e 5f            	clrw	x
2246  068f 97            	ld	xl,a
2247  0690 d601ad        	ld	a,(_uip_buf+54,x)
2248  0693 c70002        	ld	L34_opt,a
2249                     ; 754       if (opt == TCP_OPT_END) {
2251  0696 277f          	jreq	L104
2252                     ; 756         break;
2254                     ; 758       else if (opt == TCP_OPT_NOOP) {
2256  0698 a101          	cp	a,#1
2257  069a 2606          	jrne	L5301
2258                     ; 759         ++c;
2260  069c 725c0003      	inc	L14_c
2262  06a0 2057          	jra	L5201
2263  06a2               L5301:
2264                     ; 762       else if (opt == TCP_OPT_MSS
2264                     ; 763         && uip_buf[UIP_TCPIP_HLEN + UIP_LLH_LEN + 1 + c] == TCP_OPT_MSS_LEN) {
2266  06a2 a102          	cp	a,#2
2267  06a4 2640          	jrne	L1401
2269  06a6 c60003        	ld	a,L14_c
2270  06a9 5f            	clrw	x
2271  06aa 97            	ld	xl,a
2272  06ab d601ae        	ld	a,(_uip_buf+55,x)
2273  06ae a104          	cp	a,#4
2274  06b0 2634          	jrne	L1401
2275                     ; 765         tmp16 = ((uint16_t)uip_buf[UIP_TCPIP_HLEN + UIP_LLH_LEN + 2 + c] << 8)
2275                     ; 766 	        | (uint16_t)uip_buf[UIP_IPTCPH_LEN + UIP_LLH_LEN + 3 + c];
2277  06b2 c60003        	ld	a,L14_c
2278  06b5 5f            	clrw	x
2279  06b6 97            	ld	xl,a
2280  06b7 d601b0        	ld	a,(_uip_buf+57,x)
2281  06ba 5f            	clrw	x
2282  06bb 97            	ld	xl,a
2283  06bc 1f01          	ldw	(OFST-4,sp),x
2285  06be 5f            	clrw	x
2286  06bf c60003        	ld	a,L14_c
2287  06c2 97            	ld	xl,a
2288  06c3 d601af        	ld	a,(_uip_buf+56,x)
2289  06c6 5f            	clrw	x
2290  06c7 97            	ld	xl,a
2291  06c8 7b02          	ld	a,(OFST-3,sp)
2292  06ca 01            	rrwa	x,a
2293  06cb 1a01          	or	a,(OFST-4,sp)
2294  06cd 01            	rrwa	x,a
2295  06ce cf0000        	ldw	L54_tmp16,x
2296                     ; 767         uip_connr->initialmss = uip_connr->mss = tmp16 > UIP_TCP_MSS ? UIP_TCP_MSS : tmp16;
2298  06d1 a3034f        	cpw	x,#847
2299  06d4 2503          	jrult	L031
2300  06d6 ae034e        	ldw	x,#846
2301  06d9               L031:
2302  06d9 1604          	ldw	y,(OFST-1,sp)
2303  06db 90ef12        	ldw	(18,y),x
2304  06de 93            	ldw	x,y
2305  06df 90ee12        	ldw	y,(18,y)
2306  06e2 ef14          	ldw	(20,x),y
2307                     ; 770         break;
2309  06e4 2031          	jra	L104
2310  06e6               L1401:
2311                     ; 774         if (uip_buf[UIP_TCPIP_HLEN + UIP_LLH_LEN + 1 + c] == 0) {
2313  06e6 c60003        	ld	a,L14_c
2314  06e9 5f            	clrw	x
2315  06ea 97            	ld	xl,a
2316  06eb 724d01ae      	tnz	(_uip_buf+55,x)
2317  06ef 2726          	jreq	L104
2318                     ; 777           break;
2320                     ; 779         c += uip_buf[UIP_TCPIP_HLEN + UIP_LLH_LEN + 1 + c];
2322  06f1 5f            	clrw	x
2323  06f2 97            	ld	xl,a
2324  06f3 db01ae        	add	a,(_uip_buf+55,x)
2325  06f6 c70003        	ld	L14_c,a
2326  06f9               L5201:
2327                     ; 752     for (c = 0; c < ((BUF->tcpoffset >> 4) - 5) << 2;) {
2329  06f9 c601a5        	ld	a,_uip_buf+46
2330  06fc 4e            	swap	a
2331  06fd a40f          	and	a,#15
2332  06ff 5f            	clrw	x
2333  0700 97            	ld	xl,a
2334  0701 58            	sllw	x
2335  0702 58            	sllw	x
2336  0703 1d0014        	subw	x,#20
2337  0706 c60003        	ld	a,L14_c
2338  0709 905f          	clrw	y
2339  070b 9097          	ld	yl,a
2340  070d 90bf00        	ldw	c_y,y
2341  0710 b300          	cpw	x,c_y
2342  0712 2d03cc068e    	jrsgt	L1201
2343  0717               L104:
2344                     ; 785   tcp_send_synack:
2344                     ; 786   BUF->flags = TCP_SYN | TCP_ACK;
2346  0717 351201a6      	mov	_uip_buf+47,#18
2347                     ; 789   BUF->optdata[0] = TCP_OPT_MSS;
2349  071b 350201ad      	mov	_uip_buf+54,#2
2350                     ; 790   BUF->optdata[1] = TCP_OPT_MSS_LEN;
2352  071f 350401ae      	mov	_uip_buf+55,#4
2353                     ; 791   BUF->optdata[2] = (UIP_TCP_MSS) / 256;
2355  0723 350301af      	mov	_uip_buf+56,#3
2356                     ; 792   BUF->optdata[3] = (UIP_TCP_MSS) & 255;
2358  0727 354e01b0      	mov	_uip_buf+57,#78
2359                     ; 793   uip_len = UIP_IPTCPH_LEN + TCP_OPT_MSS_LEN;
2361  072b ae002c        	ldw	x,#44
2362  072e cf0173        	ldw	_uip_len,x
2363                     ; 794   BUF->tcpoffset = ((UIP_TCPH_LEN + TCP_OPT_MSS_LEN) / 4) << 4;
2365  0731 356001a5      	mov	_uip_buf+46,#96
2366                     ; 795   goto tcp_send;
2368  0735 cc09e2        	jra	L734
2369  0738               L7401:
2370                     ; 815   c = (uint8_t)((BUF->tcpoffset >> 4) << 2);
2372  0738 c601a5        	ld	a,_uip_buf+46
2373  073b 4e            	swap	a
2374  073c a40f          	and	a,#15
2375  073e 48            	sll	a
2376  073f 48            	sll	a
2377  0740 c70003        	ld	L14_c,a
2378                     ; 819   uip_len = uip_len - c - UIP_IPH_LEN;
2380  0743 c60173        	ld	a,_uip_len
2381  0746 97            	ld	xl,a
2382  0747 c60174        	ld	a,_uip_len+1
2383  074a c00003        	sub	a,L14_c
2384  074d 2401          	jrnc	L631
2385  074f 5a            	decw	x
2386  0750               L631:
2387  0750 02            	rlwa	x,a
2388  0751 1d0014        	subw	x,#20
2389  0754 cf0173        	ldw	_uip_len,x
2390                     ; 824   if (!(((uip_connr->tcpstateflags & UIP_TS_MASK) == UIP_SYN_SENT)
2390                     ; 825     && ((BUF->flags & TCP_CTL) == (TCP_SYN | TCP_ACK)))) {
2392  0757 1e04          	ldw	x,(OFST-1,sp)
2393  0759 e619          	ld	a,(25,x)
2394  075b a40f          	and	a,#15
2395  075d a102          	cp	a,#2
2396  075f 2609          	jrne	L3501
2398  0761 c601a6        	ld	a,_uip_buf+47
2399  0764 a43f          	and	a,#63
2400  0766 a112          	cp	a,#18
2401  0768 272d          	jreq	L1501
2402  076a               L3501:
2403                     ; 826     if ((uip_len > 0 || ((BUF->flags & (TCP_SYN | TCP_FIN)) != 0))
2403                     ; 827       && (BUF->seqno[0] != uip_connr->rcv_nxt[0]
2403                     ; 828       || BUF->seqno[1] != uip_connr->rcv_nxt[1]
2403                     ; 829       || BUF->seqno[2] != uip_connr->rcv_nxt[2]
2403                     ; 830       || BUF->seqno[3] != uip_connr->rcv_nxt[3])) {
2405  076a ce0173        	ldw	x,_uip_len
2406  076d 2607          	jrne	L7501
2408  076f c601a6        	ld	a,_uip_buf+47
2409  0772 a503          	bcp	a,#3
2410  0774 2721          	jreq	L1501
2411  0776               L7501:
2413  0776 1e04          	ldw	x,(OFST-1,sp)
2414  0778 e608          	ld	a,(8,x)
2415  077a c1019d        	cp	a,_uip_buf+38
2416  077d 2703cc0ad3    	jrne	L134
2418  0782 e609          	ld	a,(9,x)
2419  0784 c1019e        	cp	a,_uip_buf+39
2420  0787 26f6          	jrne	L134
2422  0789 e60a          	ld	a,(10,x)
2423  078b c1019f        	cp	a,_uip_buf+40
2424  078e 26ef          	jrne	L134
2426  0790 e60b          	ld	a,(11,x)
2427  0792 c101a0        	cp	a,_uip_buf+41
2428  0795 26e8          	jrne	L134
2429  0797               L1501:
2430                     ; 839   if ((BUF->flags & TCP_ACK) && uip_outstanding(uip_connr)) {
2432  0797 720801a603cc  	btjf	_uip_buf+47,#4,L7601
2434  079f 1e04          	ldw	x,(OFST-1,sp)
2435  07a1 e611          	ld	a,(17,x)
2436  07a3 ea10          	or	a,(16,x)
2437  07a5 27f5          	jreq	L7601
2438                     ; 840     uip_add32(uip_connr->snd_nxt, uip_connr->len);
2440  07a7 ee10          	ldw	x,(16,x)
2441  07a9 89            	pushw	x
2442  07aa 1e06          	ldw	x,(OFST+1,sp)
2443  07ac 1c000c        	addw	x,#12
2444  07af cd0004        	call	_uip_add32
2446  07b2 c601a1        	ld	a,_uip_buf+42
2447  07b5 c1007d        	cp	a,_uip_acc32
2448  07b8 85            	popw	x
2449                     ; 842     if (BUF->ackno[0] == uip_acc32[0]
2449                     ; 843       && BUF->ackno[1] == uip_acc32[1]
2449                     ; 844       && BUF->ackno[2] == uip_acc32[2]
2449                     ; 845       && BUF->ackno[3] == uip_acc32[3]) {
2451  07b9 26e1          	jrne	L7601
2453  07bb c601a2        	ld	a,_uip_buf+43
2454  07be c1007e        	cp	a,_uip_acc32+1
2455  07c1 26d9          	jrne	L7601
2457  07c3 c601a3        	ld	a,_uip_buf+44
2458  07c6 c1007f        	cp	a,_uip_acc32+2
2459  07c9 26d1          	jrne	L7601
2461  07cb c601a4        	ld	a,_uip_buf+45
2462  07ce c10080        	cp	a,_uip_acc32+3
2463  07d1 2679          	jrne	L7601
2464                     ; 847       uip_connr->snd_nxt[0] = uip_acc32[0];
2466  07d3 1e04          	ldw	x,(OFST-1,sp)
2467  07d5 c6007d        	ld	a,_uip_acc32
2468  07d8 e70c          	ld	(12,x),a
2469                     ; 848       uip_connr->snd_nxt[1] = uip_acc32[1];
2471  07da c6007e        	ld	a,_uip_acc32+1
2472  07dd e70d          	ld	(13,x),a
2473                     ; 849       uip_connr->snd_nxt[2] = uip_acc32[2];
2475  07df c6007f        	ld	a,_uip_acc32+2
2476  07e2 e70e          	ld	(14,x),a
2477                     ; 850       uip_connr->snd_nxt[3] = uip_acc32[3];
2479  07e4 c60080        	ld	a,_uip_acc32+3
2480  07e7 e70f          	ld	(15,x),a
2481                     ; 853       if (uip_connr->nrtx == 0) {
2483  07e9 e61b          	ld	a,(27,x)
2484  07eb 2653          	jrne	L3701
2485                     ; 855         m = (int8_t)(uip_connr->rto - uip_connr->timer);
2487  07ed e61a          	ld	a,(26,x)
2488  07ef e018          	sub	a,(24,x)
2489  07f1 40            	neg	a
2490  07f2 6b03          	ld	(OFST-2,sp),a
2492                     ; 857         m = (int8_t)(m - (uip_connr->sa >> 3));
2494  07f4 e616          	ld	a,(22,x)
2495  07f6 44            	srl	a
2496  07f7 44            	srl	a
2497  07f8 44            	srl	a
2498  07f9 5f            	clrw	x
2499  07fa 97            	ld	xl,a
2500  07fb 1f01          	ldw	(OFST-4,sp),x
2502  07fd 5f            	clrw	x
2503  07fe 7b03          	ld	a,(OFST-2,sp)
2504  0800 4d            	tnz	a
2505  0801 2a01          	jrpl	L241
2506  0803 53            	cplw	x
2507  0804               L241:
2508  0804 97            	ld	xl,a
2509  0805 72f001        	subw	x,(OFST-4,sp)
2510  0808 01            	rrwa	x,a
2511  0809 6b03          	ld	(OFST-2,sp),a
2513                     ; 858         uip_connr->sa += m;
2515  080b 1e04          	ldw	x,(OFST-1,sp)
2516  080d e616          	ld	a,(22,x)
2517  080f 1b03          	add	a,(OFST-2,sp)
2518  0811 e716          	ld	(22,x),a
2519                     ; 859         if (m < 0) m = (int8_t)(-m);
2521  0813 7b03          	ld	a,(OFST-2,sp)
2522  0815 2a02          	jrpl	L5701
2525  0817 0003          	neg	(OFST-2,sp)
2527  0819               L5701:
2528                     ; 860         m = (int8_t)(m - (uip_connr->sv >> 2));
2530  0819 e617          	ld	a,(23,x)
2531  081b 44            	srl	a
2532  081c 44            	srl	a
2533  081d 5f            	clrw	x
2534  081e 97            	ld	xl,a
2535  081f 1f01          	ldw	(OFST-4,sp),x
2537  0821 5f            	clrw	x
2538  0822 7b03          	ld	a,(OFST-2,sp)
2539  0824 4d            	tnz	a
2540  0825 2a01          	jrpl	L441
2541  0827 53            	cplw	x
2542  0828               L441:
2543  0828 97            	ld	xl,a
2544  0829 72f001        	subw	x,(OFST-4,sp)
2545  082c 01            	rrwa	x,a
2546  082d 6b03          	ld	(OFST-2,sp),a
2548                     ; 861         uip_connr->sv += m;
2550  082f 1e04          	ldw	x,(OFST-1,sp)
2551  0831 e617          	ld	a,(23,x)
2552  0833 1b03          	add	a,(OFST-2,sp)
2553  0835 e717          	ld	(23,x),a
2554                     ; 862         uip_connr->rto = (uint8_t)((uip_connr->sa >> 3) + uip_connr->sv);
2556  0837 e616          	ld	a,(22,x)
2557  0839 44            	srl	a
2558  083a 44            	srl	a
2559  083b 44            	srl	a
2560  083c eb17          	add	a,(23,x)
2561  083e e718          	ld	(24,x),a
2562  0840               L3701:
2563                     ; 865       uip_flags = UIP_ACKDATA;
2565  0840 35010024      	mov	_uip_flags,#1
2566                     ; 867       uip_connr->timer = uip_connr->rto;
2568  0844 e618          	ld	a,(24,x)
2569  0846 e71a          	ld	(26,x),a
2570                     ; 870       uip_connr->len = 0;
2572  0848 905f          	clrw	y
2573  084a ef10          	ldw	(16,x),y
2574  084c               L7601:
2575                     ; 875   switch (uip_connr->tcpstateflags & UIP_TS_MASK) {
2577  084c 1e04          	ldw	x,(OFST-1,sp)
2578  084e e619          	ld	a,(25,x)
2579  0850 a40f          	and	a,#15
2581                     ; 1103 	uip_connr->timer = 0;
2582  0852 4a            	dec	a
2583  0853 2725          	jreq	L504
2584  0855 a002          	sub	a,#2
2585  0857 2745          	jreq	L704
2586  0859 4a            	dec	a
2587  085a 2603cc0a5c    	jreq	L124
2588  085f 4a            	dec	a
2589  0860 2603cc0a9b    	jreq	L324
2590  0865 4a            	dec	a
2591  0866 2603cc0ac6    	jreq	L724
2592  086b 4a            	dec	a
2593  086c 2603cc0ad3    	jreq	L134
2594  0871 4a            	dec	a
2595  0872 2603cc0a4b    	jreq	L714
2596  0877 cc0b35        	jra	L744
2597  087a               L504:
2598                     ; 879     case UIP_SYN_RCVD:
2598                     ; 880       /* In SYN_RCVD we have sent out a SYNACK in response to a SYN, and we are waiting
2598                     ; 881          for an ACK that acknowledges the data we sent out the last time. Therefore, we
2598                     ; 882 	 want to have the UIP_ACKDATA flag set. If so, we enter the ESTABLISHED state. */
2598                     ; 883       if (uip_flags & UIP_ACKDATA) {
2600  087a 72010024f8    	btjf	_uip_flags,#0,L744
2601                     ; 884         uip_connr->tcpstateflags = UIP_ESTABLISHED;
2603  087f a603          	ld	a,#3
2604  0881 e719          	ld	(25,x),a
2605                     ; 885         uip_flags = UIP_CONNECTED;
2607  0883 35400024      	mov	_uip_flags,#64
2608                     ; 886         uip_connr->len = 0;
2610  0887 905f          	clrw	y
2611  0889 ef10          	ldw	(16,x),y
2612                     ; 887         if (uip_len > 0) {
2614  088b ce0173        	ldw	x,_uip_len
2615  088e 2707          	jreq	L5011
2616                     ; 888           uip_flags |= UIP_NEWDATA;
2618  0890 72120024      	bset	_uip_flags,#1
2619                     ; 889           uip_add_rcv_nxt(uip_len);
2621  0894 cd0224        	call	L743_uip_add_rcv_nxt
2623  0897               L5011:
2624                     ; 891         uip_slen = 0;
2627  0897 5f            	clrw	x
2628  0898 cf0014        	ldw	_uip_slen,x
2629                     ; 892         UIP_APPCALL();
2631                     ; 893         goto appsend;
2633  089b cc0341        	jra	L314
2634  089e               L704:
2635                     ; 897     case UIP_ESTABLISHED:
2635                     ; 898       /* In the ESTABLISHED state, we call upon the application to feed data into the
2635                     ; 899          uip_buf. If the UIP_ACKDATA flag is set, the application should put new data
2635                     ; 900 	 into the buffer, otherwise we are retransmitting an old segment, and the
2635                     ; 901 	 application should put that data into the buffer.
2635                     ; 902 	 
2635                     ; 903 	 If the incoming packet is a FIN, we should close the connection on this side
2635                     ; 904 	 as well, and we send out a FIN and enter the LAST_ACK state. We require that
2635                     ; 905 	 there is no outstanding data; otherwise the sequence numbers will be screwed
2635                     ; 906 	 up. */
2635                     ; 907       if (BUF->flags & TCP_FIN && !(uip_connr->tcpstateflags & UIP_STOPPED)) {
2637  089e 720101a630    	btjf	_uip_buf+47,#0,L7011
2639  08a3 e619          	ld	a,(25,x)
2640  08a5 a510          	bcp	a,#16
2641  08a7 262a          	jrne	L7011
2642                     ; 908         if (uip_outstanding(uip_connr)) {
2644  08a9 e611          	ld	a,(17,x)
2645  08ab ea10          	or	a,(16,x)
2646  08ad 26c8          	jrne	L744
2647                     ; 909           goto drop;
2649                     ; 911         uip_add_rcv_nxt(1 + uip_len);
2651  08af ce0173        	ldw	x,_uip_len
2652  08b2 5c            	incw	x
2653  08b3 cd0224        	call	L743_uip_add_rcv_nxt
2655                     ; 912         uip_flags |= UIP_CLOSE;
2657  08b6 72180024      	bset	_uip_flags,#4
2658                     ; 913         if (uip_len > 0) {
2660  08ba ce0173        	ldw	x,_uip_len
2661  08bd 2704          	jreq	L3111
2662                     ; 914           uip_flags |= UIP_NEWDATA;
2664  08bf 72120024      	bset	_uip_flags,#1
2665  08c3               L3111:
2666                     ; 916         UIP_APPCALL();
2668  08c3 cd0000        	call	_uip_TcpAppHubCall
2670                     ; 917         uip_connr->len = 1;
2672  08c6 1e04          	ldw	x,(OFST-1,sp)
2673  08c8 90ae0001      	ldw	y,#1
2674  08cc ef10          	ldw	(16,x),y
2675                     ; 918         uip_connr->tcpstateflags = UIP_LAST_ACK;
2677  08ce a608          	ld	a,#8
2678                     ; 919         uip_connr->nrtx = 0;
2679                     ; 920         tcp_send_finack: BUF->flags = TCP_FIN | TCP_ACK;
2680                     ; 921         goto tcp_send_nodata;
2682  08d0 cc0960        	jp	LC005
2683  08d3               L7011:
2684                     ; 926       if ((BUF->flags & TCP_URG) != 0) {
2686  08d3 720b01a61f    	btjf	_uip_buf+47,#5,L5111
2687                     ; 927         uip_appdata = ((char *)uip_appdata) + ((BUF->urgp[0] << 8) | BUF->urgp[1]);
2689  08d8 c601ab        	ld	a,_uip_buf+52
2690  08db 97            	ld	xl,a
2691  08dc c601ac        	ld	a,_uip_buf+53
2692  08df 02            	rlwa	x,a
2693  08e0 72bb0175      	addw	x,_uip_appdata
2694  08e4 cf0175        	ldw	_uip_appdata,x
2695                     ; 928         uip_len -= (BUF->urgp[0] << 8) | BUF->urgp[1];
2697  08e7 c601ab        	ld	a,_uip_buf+52
2698  08ea 97            	ld	xl,a
2699  08eb c601ac        	ld	a,_uip_buf+53
2700  08ee 02            	rlwa	x,a
2701  08ef 72b00173      	subw	x,_uip_len
2702  08f3 50            	negw	x
2703  08f4 cf0173        	ldw	_uip_len,x
2704  08f7               L5111:
2705                     ; 935       if (uip_len > 0 && !(uip_connr->tcpstateflags & UIP_STOPPED)) {
2707  08f7 ce0173        	ldw	x,_uip_len
2708  08fa 2712          	jreq	L7111
2710  08fc 1e04          	ldw	x,(OFST-1,sp)
2711  08fe e619          	ld	a,(25,x)
2712  0900 a510          	bcp	a,#16
2713  0902 260a          	jrne	L7111
2714                     ; 936         uip_flags |= UIP_NEWDATA;
2716  0904 72120024      	bset	_uip_flags,#1
2717                     ; 937         uip_add_rcv_nxt(uip_len);
2719  0908 ce0173        	ldw	x,_uip_len
2720  090b cd0224        	call	L743_uip_add_rcv_nxt
2722  090e               L7111:
2723                     ; 949       tmp16 = ((uint16_t)BUF->wnd[0] << 8) + (uint16_t)BUF->wnd[1];
2725  090e c601a8        	ld	a,_uip_buf+49
2726  0911 5f            	clrw	x
2727  0912 97            	ld	xl,a
2728  0913 1f01          	ldw	(OFST-4,sp),x
2730  0915 c601a7        	ld	a,_uip_buf+48
2731  0918 97            	ld	xl,a
2732  0919 4f            	clr	a
2733  091a 02            	rlwa	x,a
2734  091b 72fb01        	addw	x,(OFST-4,sp)
2735  091e cf0000        	ldw	L54_tmp16,x
2736                     ; 950       if (tmp16 > uip_connr->initialmss || tmp16 == 0) {
2738  0921 1604          	ldw	y,(OFST-1,sp)
2739  0923 90ee14        	ldw	y,(20,y)
2740  0926 90c30000      	cpw	y,L54_tmp16
2741  092a 2505          	jrult	L3211
2743  092c ce0000        	ldw	x,L54_tmp16
2744  092f 2607          	jrne	L1211
2745  0931               L3211:
2746                     ; 951         tmp16 = uip_connr->initialmss;
2748  0931 1e04          	ldw	x,(OFST-1,sp)
2749  0933 ee14          	ldw	x,(20,x)
2750  0935 cf0000        	ldw	L54_tmp16,x
2751  0938               L1211:
2752                     ; 953       uip_connr->mss = tmp16;
2754  0938 1e04          	ldw	x,(OFST-1,sp)
2755  093a 90ce0000      	ldw	y,L54_tmp16
2756  093e ef12          	ldw	(18,x),y
2757                     ; 968       if (uip_flags & (UIP_NEWDATA | UIP_ACKDATA)) {
2759  0940 c60024        	ld	a,_uip_flags
2760  0943 a503          	bcp	a,#3
2761  0945 2603cc0b35    	jreq	L744
2762                     ; 969         uip_slen = 0;
2763                     ; 970         UIP_APPCALL();
2765  094a cc0897        	jp	L5011
2766  094d               L7211:
2767                     ; 981         if (uip_flags & UIP_CLOSE) {
2769  094d 720900241e    	btjf	_uip_flags,#4,L1311
2770                     ; 982           uip_slen = 0;
2772  0952 5f            	clrw	x
2773  0953 cf0014        	ldw	_uip_slen,x
2774                     ; 983 	  uip_connr->len = 1;
2776  0956 1e04          	ldw	x,(OFST-1,sp)
2777  0958 90ae0001      	ldw	y,#1
2778  095c ef10          	ldw	(16,x),y
2779                     ; 984 	  uip_connr->tcpstateflags = UIP_FIN_WAIT_1;
2781  095e a604          	ld	a,#4
2782                     ; 985 	  uip_connr->nrtx = 0;
2784  0960               LC005:
2785  0960 e719          	ld	(25,x),a
2787  0962 6f1b          	clr	(27,x)
2788                     ; 986 	  BUF->flags = TCP_FIN | TCP_ACK;
2790  0964               LC003:
2792  0964 351101a6      	mov	_uip_buf+47,#17
2793                     ; 987 	  goto tcp_send_nodata;
2794  0968               L334:
2795                     ; 1116   tcp_send_nodata: uip_len = UIP_IPTCPH_LEN;
2797  0968 ae0028        	ldw	x,#40
2798  096b cf0173        	ldw	_uip_len,x
2799  096e 206e          	jra	L534
2800  0970               L1311:
2801                     ; 991         if (uip_slen > 0) {
2803  0970 ce0014        	ldw	x,_uip_slen
2804  0973 2732          	jreq	L3311
2805                     ; 994 	  if ((uip_flags & UIP_ACKDATA) != 0) {
2807  0975 7201002406    	btjf	_uip_flags,#0,L5311
2808                     ; 995 	    uip_connr->len = 0;
2810  097a 1e04          	ldw	x,(OFST-1,sp)
2811  097c 905f          	clrw	y
2812  097e ef10          	ldw	(16,x),y
2813  0980               L5311:
2814                     ; 1000 	  if (uip_connr->len == 0) {
2816  0980 1e04          	ldw	x,(OFST-1,sp)
2817  0982 e611          	ld	a,(17,x)
2818  0984 ea10          	or	a,(16,x)
2819  0986 261a          	jrne	L7311
2820                     ; 1003 	    if (uip_slen > uip_connr->mss) {
2822  0988 9093          	ldw	y,x
2823  098a 90ee12        	ldw	y,(18,y)
2824  098d 90c30014      	cpw	y,_uip_slen
2825  0991 2407          	jruge	L1411
2826                     ; 1004 	      uip_slen = uip_connr->mss;
2828  0993 ee12          	ldw	x,(18,x)
2829  0995 cf0014        	ldw	_uip_slen,x
2830  0998 1e04          	ldw	x,(OFST-1,sp)
2831  099a               L1411:
2832                     ; 1009             uip_connr->len = uip_slen;
2834  099a 90ce0014      	ldw	y,_uip_slen
2835  099e ef10          	ldw	(16,x),y
2837  09a0 2005          	jra	L3311
2838  09a2               L7311:
2839                     ; 1015 	    uip_slen = uip_connr->len;
2841  09a2 ee10          	ldw	x,(16,x)
2842  09a4 cf0014        	ldw	_uip_slen,x
2843  09a7               L3311:
2844                     ; 1018 	uip_connr->nrtx = 0;
2846  09a7 1e04          	ldw	x,(OFST-1,sp)
2847  09a9 6f1b          	clr	(27,x)
2848  09ab               L514:
2849                     ; 1019 	apprexmit: uip_appdata = uip_sappdata;
2851  09ab ce0016        	ldw	x,_uip_sappdata
2852  09ae cf0175        	ldw	_uip_appdata,x
2853                     ; 1023 	if (uip_slen > 0 && uip_connr->len > 0) {
2855  09b1 ce0014        	ldw	x,_uip_slen
2856  09b4 2716          	jreq	L5411
2858  09b6 1e04          	ldw	x,(OFST-1,sp)
2859  09b8 e611          	ld	a,(17,x)
2860  09ba ea10          	or	a,(16,x)
2861  09bc 270e          	jreq	L5411
2862                     ; 1025 	  uip_len = uip_connr->len + UIP_TCPIP_HLEN;
2864  09be ee10          	ldw	x,(16,x)
2865  09c0 1c0028        	addw	x,#40
2866  09c3 cf0173        	ldw	_uip_len,x
2867                     ; 1027 	  BUF->flags = TCP_ACK | TCP_PSH;
2869  09c6 351801a6      	mov	_uip_buf+47,#24
2870                     ; 1029 	  goto tcp_send_noopts;
2872  09ca 2012          	jra	L534
2873  09cc               L5411:
2874                     ; 1032 	if (uip_flags & UIP_NEWDATA) {
2876  09cc 7202002403cc  	btjf	_uip_flags,#1,L744
2877                     ; 1033 	  uip_len = UIP_TCPIP_HLEN;
2879  09d4 ae0028        	ldw	x,#40
2880  09d7 cf0173        	ldw	_uip_len,x
2881                     ; 1034 	  BUF->flags = TCP_ACK;
2883  09da 351001a6      	mov	_uip_buf+47,#16
2884                     ; 1035 	  goto tcp_send_noopts;
2885  09de               L534:
2886                     ; 1117   tcp_send_noopts: BUF->tcpoffset = (UIP_TCPH_LEN / 4) << 4;
2888  09de 355001a5      	mov	_uip_buf+46,#80
2889  09e2               L734:
2890                     ; 1123   tcp_send:
2890                     ; 1124   /* We're done with the input processing. We are now ready to send a reply. Our job is to
2890                     ; 1125      fill in all the fields of the TCP and IP headers before calculating the checksum and
2890                     ; 1126      finally send the packet. */
2890                     ; 1127   BUF->ackno[0] = uip_connr->rcv_nxt[0];
2892  09e2 1e04          	ldw	x,(OFST-1,sp)
2893  09e4 e608          	ld	a,(8,x)
2894  09e6 c701a1        	ld	_uip_buf+42,a
2895                     ; 1128   BUF->ackno[1] = uip_connr->rcv_nxt[1];
2897  09e9 e609          	ld	a,(9,x)
2898  09eb c701a2        	ld	_uip_buf+43,a
2899                     ; 1129   BUF->ackno[2] = uip_connr->rcv_nxt[2];
2901  09ee e60a          	ld	a,(10,x)
2902  09f0 c701a3        	ld	_uip_buf+44,a
2903                     ; 1130   BUF->ackno[3] = uip_connr->rcv_nxt[3];
2905  09f3 e60b          	ld	a,(11,x)
2906  09f5 c701a4        	ld	_uip_buf+45,a
2907                     ; 1132   BUF->seqno[0] = uip_connr->snd_nxt[0];
2909  09f8 e60c          	ld	a,(12,x)
2910  09fa c7019d        	ld	_uip_buf+38,a
2911                     ; 1133   BUF->seqno[1] = uip_connr->snd_nxt[1];
2913  09fd e60d          	ld	a,(13,x)
2914  09ff c7019e        	ld	_uip_buf+39,a
2915                     ; 1134   BUF->seqno[2] = uip_connr->snd_nxt[2];
2917  0a02 e60e          	ld	a,(14,x)
2918  0a04 c7019f        	ld	_uip_buf+40,a
2919                     ; 1135   BUF->seqno[3] = uip_connr->snd_nxt[3];
2921  0a07 e60f          	ld	a,(15,x)
2922  0a09 c701a0        	ld	_uip_buf+41,a
2923                     ; 1137   BUF->proto = UIP_PROTO_TCP;
2925  0a0c 3506018e      	mov	_uip_buf+23,#6
2926                     ; 1139   BUF->srcport = uip_connr->lport;
2928  0a10 ee04          	ldw	x,(4,x)
2929  0a12 cf0199        	ldw	_uip_buf+34,x
2930                     ; 1140   BUF->destport = uip_connr->rport;
2932  0a15 1e04          	ldw	x,(OFST-1,sp)
2933  0a17 ee06          	ldw	x,(6,x)
2934  0a19 cf019b        	ldw	_uip_buf+36,x
2935                     ; 1142   uip_ipaddr_copy(BUF->srcipaddr, uip_hostaddr);
2937  0a1c ce0020        	ldw	x,_uip_hostaddr
2938  0a1f cf0191        	ldw	_uip_buf+26,x
2941  0a22 ce0022        	ldw	x,_uip_hostaddr+2
2942  0a25 cf0193        	ldw	_uip_buf+28,x
2943                     ; 1143   uip_ipaddr_copy(BUF->destipaddr, uip_connr->ripaddr);
2945  0a28 1e04          	ldw	x,(OFST-1,sp)
2946  0a2a fe            	ldw	x,(x)
2947  0a2b cf0195        	ldw	_uip_buf+30,x
2950  0a2e 1e04          	ldw	x,(OFST-1,sp)
2951  0a30 ee02          	ldw	x,(2,x)
2952  0a32 cf0197        	ldw	_uip_buf+32,x
2953                     ; 1145   if (uip_connr->tcpstateflags & UIP_STOPPED) {
2955  0a35 1e04          	ldw	x,(OFST-1,sp)
2956  0a37 e619          	ld	a,(25,x)
2957  0a39 a510          	bcp	a,#16
2958  0a3b 2603cc0ada    	jreq	L1121
2959                     ; 1148     BUF->wnd[0] = BUF->wnd[1] = 0;
2961  0a40 725f01a8      	clr	_uip_buf+49
2962  0a44 725f01a7      	clr	_uip_buf+48
2964  0a48 cc0ae2        	jra	L144
2965  0a4b               L714:
2966                     ; 1040     case UIP_LAST_ACK:
2966                     ; 1041       /* We can close this connection if the peer has acknowledged our FIN. This is
2966                     ; 1042          indicated by the UIP_ACKDATA flag. */
2966                     ; 1043       if (uip_flags & UIP_ACKDATA) {
2968  0a4b 7201002481    	btjf	_uip_flags,#0,L744
2969                     ; 1044         uip_connr->tcpstateflags = UIP_CLOSED;
2971  0a50 e719          	ld	(25,x),a
2972                     ; 1045 	uip_flags = UIP_CLOSE;
2974  0a52 35100024      	mov	_uip_flags,#16
2975                     ; 1046 	UIP_APPCALL();
2977  0a56 cd0000        	call	_uip_TcpAppHubCall
2979  0a59 cc0b35        	jra	L744
2980  0a5c               L124:
2981                     ; 1050     case UIP_FIN_WAIT_1:
2981                     ; 1051       /* The application has closed the connection, but the remote host hasn't closed
2981                     ; 1052          its end yet. Thus we do nothing but wait for a FIN from the other side. */
2981                     ; 1053       if (uip_len > 0) {
2983  0a5c ce0173        	ldw	x,_uip_len
2984  0a5f 2703          	jreq	L3511
2985                     ; 1054         uip_add_rcv_nxt(uip_len);
2987  0a61 cd0224        	call	L743_uip_add_rcv_nxt
2989  0a64               L3511:
2990                     ; 1056       if (BUF->flags & TCP_FIN) {
2992  0a64 720101a619    	btjf	_uip_buf+47,#0,L5511
2993                     ; 1057         if (uip_flags & UIP_ACKDATA) {
2995  0a69 1e04          	ldw	x,(OFST-1,sp)
2996  0a6b 720100240c    	btjf	_uip_flags,#0,L7511
2997                     ; 1058 	  uip_connr->tcpstateflags = UIP_TIME_WAIT;
2999  0a70 a607          	ld	a,#7
3000  0a72 e719          	ld	(25,x),a
3001                     ; 1059 	  uip_connr->timer = 0;
3003  0a74 6f1a          	clr	(26,x)
3004                     ; 1060 	  uip_connr->len = 0;
3006  0a76 905f          	clrw	y
3007  0a78 ef10          	ldw	(16,x),y
3009  0a7a 2034          	jra	LC004
3010  0a7c               L7511:
3011                     ; 1063           uip_connr->tcpstateflags = UIP_CLOSING;
3013  0a7c a606          	ld	a,#6
3014  0a7e e719          	ld	(25,x),a
3015                     ; 1065         uip_add_rcv_nxt(1);
3017                     ; 1066         uip_flags = UIP_CLOSE;
3018                     ; 1067         UIP_APPCALL();
3020                     ; 1068         goto tcp_send_ack;
3022  0a80 202e          	jp	LC004
3023  0a82               L5511:
3024                     ; 1070       else if (uip_flags & UIP_ACKDATA) {
3026  0a82 720100240d    	btjf	_uip_flags,#0,L3611
3027                     ; 1071         uip_connr->tcpstateflags = UIP_FIN_WAIT_2;
3029  0a87 1e04          	ldw	x,(OFST-1,sp)
3030  0a89 a605          	ld	a,#5
3031  0a8b e719          	ld	(25,x),a
3032                     ; 1072         uip_connr->len = 0;
3034  0a8d 905f          	clrw	y
3035  0a8f ef10          	ldw	(16,x),y
3036                     ; 1073         goto drop;
3038  0a91 cc0b35        	jra	L744
3039  0a94               L3611:
3040                     ; 1075       if (uip_len > 0) {
3042  0a94 ce0173        	ldw	x,_uip_len
3043  0a97 27f8          	jreq	L744
3044                     ; 1076         goto tcp_send_ack;
3046  0a99 2038          	jra	L134
3047  0a9b               L324:
3048                     ; 1080     case UIP_FIN_WAIT_2:
3048                     ; 1081       if (uip_len > 0) {
3050  0a9b ce0173        	ldw	x,_uip_len
3051  0a9e 2703          	jreq	L1711
3052                     ; 1082 	uip_add_rcv_nxt(uip_len);
3054  0aa0 cd0224        	call	L743_uip_add_rcv_nxt
3056  0aa3               L1711:
3057                     ; 1084       if (BUF->flags & TCP_FIN) {
3059  0aa3 720101a617    	btjf	_uip_buf+47,#0,L3711
3060                     ; 1085 	uip_connr->tcpstateflags = UIP_TIME_WAIT;
3062  0aa8 1e04          	ldw	x,(OFST-1,sp)
3063  0aaa a607          	ld	a,#7
3064  0aac e719          	ld	(25,x),a
3065                     ; 1086 	uip_connr->timer = 0;
3067  0aae 6f1a          	clr	(26,x)
3068                     ; 1087 	uip_add_rcv_nxt(1);
3071                     ; 1088 	uip_flags = UIP_CLOSE;
3073                     ; 1089 	UIP_APPCALL();
3075  0ab0               LC004:
3077  0ab0 ae0001        	ldw	x,#1
3078  0ab3 cd0224        	call	L743_uip_add_rcv_nxt
3080  0ab6 35100024      	mov	_uip_flags,#16
3082  0aba cd0000        	call	_uip_TcpAppHubCall
3084                     ; 1090 	goto tcp_send_ack;
3086  0abd 2014          	jra	L134
3087  0abf               L3711:
3088                     ; 1092       if (uip_len > 0) {
3090  0abf ce0173        	ldw	x,_uip_len
3091  0ac2 2771          	jreq	L744
3092                     ; 1093 	goto tcp_send_ack;
3094  0ac4 200d          	jra	L134
3095  0ac6               L724:
3096                     ; 1100     case UIP_CLOSING:
3096                     ; 1101       if (uip_flags & UIP_ACKDATA) {
3098  0ac6 720100246a    	btjf	_uip_flags,#0,L744
3099                     ; 1102 	uip_connr->tcpstateflags = UIP_TIME_WAIT;
3101  0acb a607          	ld	a,#7
3102  0acd e719          	ld	(25,x),a
3103                     ; 1103 	uip_connr->timer = 0;
3105  0acf 6f1a          	clr	(26,x)
3106  0ad1 2062          	jra	L744
3107                     ; 1106   goto drop;
3109  0ad3               L134:
3110                     ; 1112   tcp_send_ack:
3110                     ; 1113   /* We jump here when we are ready to send the packet, and just want to set the
3110                     ; 1114      appropriate TCP sequence numbers in the TCP header. */
3110                     ; 1115   BUF->flags = TCP_ACK;
3112  0ad3 351001a6      	mov	_uip_buf+47,#16
3113  0ad7 cc0968        	jra	L334
3114  0ada               L1121:
3115                     ; 1151     BUF->wnd[0] = ((UIP_RECEIVE_WINDOW) >> 8);
3117  0ada 350301a7      	mov	_uip_buf+48,#3
3118                     ; 1152     BUF->wnd[1] = ((UIP_RECEIVE_WINDOW) & 0xff);
3120  0ade 354e01a8      	mov	_uip_buf+49,#78
3121  0ae2               L144:
3122                     ; 1158   tcp_send_noconn:
3122                     ; 1159   BUF->ttl = UIP_TTL;
3124  0ae2 3540018d      	mov	_uip_buf+22,#64
3125                     ; 1160   BUF->len[0] = (uint8_t)(uip_len >> 8);
3127  0ae6 5501730187    	mov	_uip_buf+16,_uip_len
3128                     ; 1161   BUF->len[1] = (uint8_t)(uip_len & 0xff);
3130  0aeb 5501740188    	mov	_uip_buf+17,_uip_len+1
3131                     ; 1163   BUF->urgp[0] = BUF->urgp[1] = 0;
3133  0af0 725f01ac      	clr	_uip_buf+53
3134  0af4 725f01ab      	clr	_uip_buf+52
3135                     ; 1166   BUF->tcpchksum = 0;
3137  0af8 5f            	clrw	x
3138  0af9 cf01a9        	ldw	_uip_buf+50,x
3139                     ; 1167   BUF->tcpchksum = ~(uip_tcpchksum());
3141  0afc cd0120        	call	_uip_tcpchksum
3143  0aff 53            	cplw	x
3144  0b00 cf01a9        	ldw	_uip_buf+50,x
3145                     ; 1172   ip_send_nolen:
3145                     ; 1173 
3145                     ; 1174   BUF->vhl = 0x45;
3147  0b03 35450185      	mov	_uip_buf+14,#69
3148                     ; 1175   BUF->tos = 0;
3150  0b07 725f0186      	clr	_uip_buf+15
3151                     ; 1176   BUF->ipoffset[0] = BUF->ipoffset[1] = 0;
3153  0b0b 725f018c      	clr	_uip_buf+21
3154  0b0f 725f018b      	clr	_uip_buf+20
3155                     ; 1177   ++ipid;
3157  0b13 ce0008        	ldw	x,L31_ipid
3158  0b16 5c            	incw	x
3159  0b17 cf0008        	ldw	L31_ipid,x
3160                     ; 1178   BUF->ipid[0] = (uint8_t)(ipid >> 8);
3162  0b1a 5500080189    	mov	_uip_buf+18,L31_ipid
3163                     ; 1179   BUF->ipid[1] = (uint8_t)(ipid & 0xff);
3165  0b1f 550009018a    	mov	_uip_buf+19,L31_ipid+1
3166                     ; 1181   BUF->ipchksum = 0;
3168  0b24 5f            	clrw	x
3169  0b25 cf018f        	ldw	_uip_buf+24,x
3170                     ; 1182   BUF->ipchksum = ~(uip_ipchksum());
3172  0b28 cd00bb        	call	_uip_ipchksum
3174  0b2b 53            	cplw	x
3175  0b2c cf018f        	ldw	_uip_buf+24,x
3176                     ; 1184   UIP_STAT(++uip_stat.tcp.sent);
3178  0b2f ae0061        	ldw	x,#_uip_stat+60
3180  0b32 cc0489        	jra	L544
3181  0b35               L744:
3182                     ; 1199   drop:
3182                     ; 1200   uip_len = 0;
3184  0b35 5f            	clrw	x
3185  0b36 cf0173        	ldw	_uip_len,x
3186                     ; 1201   uip_flags = 0;
3188                     ; 1202   return;
3189  0b39               L602:
3191  0b39 725f0024      	clr	_uip_flags
3194  0b3d 5b06          	addw	sp,#6
3195  0b3f 81            	ret	
3227                     ; 1207 uint16_t htons(uint16_t val)
3227                     ; 1208 {
3228                     	switch	.text
3229  0b40               _htons:
3233                     ; 1209   return HTONS(val);
3237  0b40 81            	ret	
3282                     ; 1215 void uip_send(const char *data, int len)
3282                     ; 1216 {
3283                     	switch	.text
3284  0b41               _uip_send:
3286  0b41 89            	pushw	x
3287       00000000      OFST:	set	0
3290                     ; 1217   if (len > 0) {
3292  0b42 9c            	rvf	
3293  0b43 1e05          	ldw	x,(OFST+5,sp)
3294  0b45 2d1c          	jrsle	L412
3295                     ; 1218     uip_slen = len;
3297  0b47 cf0014        	ldw	_uip_slen,x
3298                     ; 1219     if (data != uip_sappdata) {
3300  0b4a 1e01          	ldw	x,(OFST+1,sp)
3301  0b4c c30016        	cpw	x,_uip_sappdata
3302  0b4f 2712          	jreq	L412
3303                     ; 1220       memcpy(uip_sappdata, (data), uip_slen);
3305  0b51 bf00          	ldw	c_x,x
3306  0b53 ce0014        	ldw	x,_uip_slen
3307  0b56 270b          	jreq	L412
3308  0b58               L612:
3309  0b58 5a            	decw	x
3310  0b59 92d600        	ld	a,([c_x.w],x)
3311  0b5c 72d70016      	ld	([_uip_sappdata.w],x),a
3312  0b60 5d            	tnzw	x
3313  0b61 26f5          	jrne	L612
3314  0b63               L412:
3315                     ; 1223 }
3318  0b63 85            	popw	x
3319  0b64 81            	ret	
3746                     	switch	.bss
3747  0000               L54_tmp16:
3748  0000 0000          	ds.b	2
3749  0002               L34_opt:
3750  0002 00            	ds.b	1
3751  0003               L14_c:
3752  0003 00            	ds.b	1
3753  0004               L73_iss:
3754  0004 00000000      	ds.b	4
3755  0008               L31_ipid:
3756  0008 0000          	ds.b	2
3757  000a               _uip_listenports:
3758  000a 000000000000  	ds.b	10
3759                     	xdef	_uip_listenports
3760  0014               _uip_slen:
3761  0014 0000          	ds.b	2
3762                     	xdef	_uip_slen
3763  0016               _uip_sappdata:
3764  0016 0000          	ds.b	2
3765                     	xdef	_uip_sappdata
3766                     	xdef	_uip_ethaddr
3767                     	xdef	_uip_add32
3768                     	xdef	_uip_tcpchksum
3769                     	xdef	_uip_ipchksum
3770                     	xdef	_uip_chksum
3771  0018               _uip_draddr:
3772  0018 00000000      	ds.b	4
3773                     	xdef	_uip_draddr
3774  001c               _uip_netmask:
3775  001c 00000000      	ds.b	4
3776                     	xdef	_uip_netmask
3777  0020               _uip_hostaddr:
3778  0020 00000000      	ds.b	4
3779                     	xdef	_uip_hostaddr
3780                     	xdef	_uip_process
3781  0024               _uip_flags:
3782  0024 00            	ds.b	1
3783                     	xdef	_uip_flags
3784  0025               _uip_stat:
3785  0025 000000000000  	ds.b	88
3786                     	xdef	_uip_stat
3787  007d               _uip_acc32:
3788  007d 00000000      	ds.b	4
3789                     	xdef	_uip_acc32
3790  0081               _uip_conns:
3791  0081 000000000000  	ds.b	240
3792                     	xdef	_uip_conns
3793  0171               _uip_conn:
3794  0171 0000          	ds.b	2
3795                     	xdef	_uip_conn
3796  0173               _uip_len:
3797  0173 0000          	ds.b	2
3798                     	xdef	_uip_len
3799  0175               _uip_appdata:
3800  0175 0000          	ds.b	2
3801                     	xdef	_uip_appdata
3802                     	xdef	_htons
3803                     	xdef	_uip_send
3804                     	xdef	_uip_unlisten
3805                     	xdef	_uip_listen
3806  0177               _uip_buf:
3807  0177 000000000000  	ds.b	902
3808                     	xdef	_uip_buf
3809                     	xdef	_uip_setipid
3810                     	xdef	_uip_init_stats
3811                     	xdef	_uip_init
3812                     	xref	_uip_TcpAppHubCall
3813                     	xref.b	c_x
3814                     	xref.b	c_y
3834                     	xref	c_lgadc
3835                     	end
