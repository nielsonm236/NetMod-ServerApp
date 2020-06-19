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
 316                     ; 254     if (sum < t) {
 318  007e 1303          	cpw	x,(OFST-3,sp)
 319  0080 2401          	jruge	L741
 320                     ; 255       sum++; /* carry */
 322  0082 5c            	incw	x
 323  0083               L741:
 324  0083 1f07          	ldw	(OFST+1,sp),x
 325                     ; 257     dataptr += 2;
 327  0085 1e05          	ldw	x,(OFST-1,sp)
 328  0087 1c0002        	addw	x,#2
 329  008a 1f05          	ldw	(OFST-1,sp),x
 331  008c               L341:
 332                     ; 251   while (dataptr < last_byte) { /* At least two more bytes */
 334  008c 1301          	cpw	x,(OFST-5,sp)
 335  008e 25dc          	jrult	L731
 336                     ; 260   if (dataptr == last_byte) {
 338  0090 2612          	jrne	L151
 339                     ; 261     t = (dataptr[0] << 8) + 0;
 341  0092 f6            	ld	a,(x)
 342  0093 97            	ld	xl,a
 343  0094 4f            	clr	a
 344  0095 02            	rlwa	x,a
 345  0096 1f03          	ldw	(OFST-3,sp),x
 347                     ; 262     sum += t;
 349  0098 72fb07        	addw	x,(OFST+1,sp)
 350  009b 1f07          	ldw	(OFST+1,sp),x
 351                     ; 263     if (sum < t) {
 353  009d 1303          	cpw	x,(OFST-3,sp)
 354  009f 2403          	jruge	L151
 355                     ; 264       sum++; /* carry */
 357  00a1 5c            	incw	x
 358  00a2 1f07          	ldw	(OFST+1,sp),x
 359  00a4               L151:
 360                     ; 268   return sum;
 362  00a4 1e07          	ldw	x,(OFST+1,sp)
 365  00a6 5b08          	addw	sp,#8
 366  00a8 81            	ret	
 410                     ; 273 uint16_t uip_chksum(uint16_t *data, uint16_t len)
 410                     ; 274 {
 411                     	switch	.text
 412  00a9               _uip_chksum:
 414  00a9 89            	pushw	x
 415       00000000      OFST:	set	0
 418                     ; 275   return htons(chksum(0, (uint8_t *)data, len));
 420  00aa 1e05          	ldw	x,(OFST+5,sp)
 421  00ac 89            	pushw	x
 422  00ad 1e03          	ldw	x,(OFST+3,sp)
 423  00af 89            	pushw	x
 424  00b0 5f            	clrw	x
 425  00b1 ada8          	call	L101_chksum
 427  00b3 5b04          	addw	sp,#4
 428  00b5 cd0b3e        	call	_htons
 432  00b8 5b02          	addw	sp,#2
 433  00ba 81            	ret	
 468                     ; 281 uint16_t uip_ipchksum(void)
 468                     ; 282 {
 469                     	switch	.text
 470  00bb               _uip_ipchksum:
 472  00bb 89            	pushw	x
 473       00000002      OFST:	set	2
 476                     ; 285   sum = chksum(0, &uip_buf[UIP_LLH_LEN], UIP_IPH_LEN);
 478  00bc ae0014        	ldw	x,#20
 479  00bf 89            	pushw	x
 480  00c0 ae0185        	ldw	x,#_uip_buf+14
 481  00c3 89            	pushw	x
 482  00c4 5f            	clrw	x
 483  00c5 ad94          	call	L101_chksum
 485  00c7 5b04          	addw	sp,#4
 486  00c9 1f01          	ldw	(OFST-1,sp),x
 488                     ; 287   return (sum == 0) ? 0xffff : htons(sum);
 490  00cb 2603          	jrne	L62
 491  00cd 5a            	decw	x
 492  00ce 2003          	jra	L03
 493  00d0               L62:
 494  00d0 cd0b3e        	call	_htons
 496  00d3               L03:
 499  00d3 5b02          	addw	sp,#2
 500  00d5 81            	ret	
 549                     ; 293 static uint16_t upper_layer_chksum(uint8_t proto)
 549                     ; 294 {
 550                     	switch	.text
 551  00d6               L112_upper_layer_chksum:
 553  00d6 88            	push	a
 554  00d7 5204          	subw	sp,#4
 555       00000004      OFST:	set	4
 558                     ; 298   upper_layer_len = (((uint16_t)(BUF->len[0]) << 8) + BUF->len[1]) - UIP_IPH_LEN;
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
 572                     ; 303   sum = upper_layer_len + proto;
 574  00eb 5f            	clrw	x
 575  00ec 7b05          	ld	a,(OFST+1,sp)
 576  00ee 97            	ld	xl,a
 577  00ef 72fb01        	addw	x,(OFST-3,sp)
 578  00f2 1f03          	ldw	(OFST-1,sp),x
 580                     ; 305   sum = chksum(sum, (uint8_t *)&BUF->srcipaddr[0], 2 * sizeof(uip_ipaddr_t));
 582  00f4 ae0008        	ldw	x,#8
 583  00f7 89            	pushw	x
 584  00f8 ae0191        	ldw	x,#_uip_buf+26
 585  00fb 89            	pushw	x
 586  00fc 1e07          	ldw	x,(OFST+3,sp)
 587  00fe cd005b        	call	L101_chksum
 589  0101 5b04          	addw	sp,#4
 590  0103 1f03          	ldw	(OFST-1,sp),x
 592                     ; 308   sum = chksum(sum, &uip_buf[UIP_IPH_LEN + UIP_LLH_LEN], upper_layer_len);
 594  0105 1e01          	ldw	x,(OFST-3,sp)
 595  0107 89            	pushw	x
 596  0108 ae0199        	ldw	x,#_uip_buf+34
 597  010b 89            	pushw	x
 598  010c 1e07          	ldw	x,(OFST+3,sp)
 599  010e cd005b        	call	L101_chksum
 601  0111 5b04          	addw	sp,#4
 602  0113 1f03          	ldw	(OFST-1,sp),x
 604                     ; 310   return (sum == 0) ? 0xffff : htons(sum);
 606  0115 2603          	jrne	L44
 607  0117 5a            	decw	x
 608  0118 2003          	jra	L64
 609  011a               L44:
 610  011a cd0b3e        	call	_htons
 612  011d               L64:
 615  011d 5b05          	addw	sp,#5
 616  011f 81            	ret	
 640                     ; 315 uint16_t uip_tcpchksum(void)
 640                     ; 316 {
 641                     	switch	.text
 642  0120               _uip_tcpchksum:
 646                     ; 317   return upper_layer_chksum(UIP_PROTO_TCP);
 648  0120 a606          	ld	a,#6
 652  0122 20b2          	jp	L112_upper_layer_chksum
 679                     ; 323 void uip_init(void)
 679                     ; 324 {
 680                     	switch	.text
 681  0124               _uip_init:
 685                     ; 325   for (c = 0; c < UIP_LISTENPORTS; ++c) {
 687  0124 4f            	clr	a
 688  0125 c70003        	ld	L14_c,a
 689  0128               L352:
 690                     ; 326     uip_listenports[c] = 0;
 692  0128 5f            	clrw	x
 693  0129 97            	ld	xl,a
 694  012a 58            	sllw	x
 695  012b 905f          	clrw	y
 696  012d df000a        	ldw	(_uip_listenports,x),y
 697                     ; 325   for (c = 0; c < UIP_LISTENPORTS; ++c) {
 699  0130 725c0003      	inc	L14_c
 702  0134 c60003        	ld	a,L14_c
 703  0137 a105          	cp	a,#5
 704  0139 25ed          	jrult	L352
 705                     ; 328   for (c = 0; c < UIP_CONNS; ++c) {
 707  013b 4f            	clr	a
 708  013c c70003        	ld	L14_c,a
 709  013f               L162:
 710                     ; 329     uip_conns[c].tcpstateflags = UIP_CLOSED;
 712  013f 97            	ld	xl,a
 713  0140 a628          	ld	a,#40
 714  0142 42            	mul	x,a
 715  0143 724f009a      	clr	(_uip_conns+25,x)
 716                     ; 328   for (c = 0; c < UIP_CONNS; ++c) {
 718  0147 725c0003      	inc	L14_c
 721  014b c60003        	ld	a,L14_c
 722  014e a106          	cp	a,#6
 723  0150 25ed          	jrult	L162
 724                     ; 335   uip_stat.ip.drop = 0;
 726  0152 5f            	clrw	x
 727  0153 cf0027        	ldw	_uip_stat+2,x
 728  0156 cf0025        	ldw	_uip_stat,x
 729                     ; 336   uip_stat.ip.recv = 0;
 731  0159 cf002b        	ldw	_uip_stat+6,x
 732  015c cf0029        	ldw	_uip_stat+4,x
 733                     ; 337   uip_stat.ip.sent = 0;
 735  015f cf002f        	ldw	_uip_stat+10,x
 736  0162 cf002d        	ldw	_uip_stat+8,x
 737                     ; 338   uip_stat.ip.vhlerr = 0;
 739  0165 cf0033        	ldw	_uip_stat+14,x
 740  0168 cf0031        	ldw	_uip_stat+12,x
 741                     ; 339   uip_stat.ip.hblenerr = 0;
 743  016b cf0037        	ldw	_uip_stat+18,x
 744  016e cf0035        	ldw	_uip_stat+16,x
 745                     ; 340   uip_stat.ip.lblenerr = 0;
 747  0171 cf003b        	ldw	_uip_stat+22,x
 748  0174 cf0039        	ldw	_uip_stat+20,x
 749                     ; 341   uip_stat.ip.fragerr = 0;
 751  0177 cf003f        	ldw	_uip_stat+26,x
 752  017a cf003d        	ldw	_uip_stat+24,x
 753                     ; 342   uip_stat.ip.chkerr = 0;
 755  017d cf0043        	ldw	_uip_stat+30,x
 756  0180 cf0041        	ldw	_uip_stat+28,x
 757                     ; 343   uip_stat.ip.protoerr = 0;
 759  0183 cf0047        	ldw	_uip_stat+34,x
 760  0186 cf0045        	ldw	_uip_stat+32,x
 761                     ; 344   uip_stat.icmp.drop = 0;
 763  0189 cf004b        	ldw	_uip_stat+38,x
 764  018c cf0049        	ldw	_uip_stat+36,x
 765                     ; 345   uip_stat.icmp.recv = 0;
 767  018f cf004f        	ldw	_uip_stat+42,x
 768  0192 cf004d        	ldw	_uip_stat+40,x
 769                     ; 346   uip_stat.icmp.sent = 0;
 771  0195 cf0053        	ldw	_uip_stat+46,x
 772  0198 cf0051        	ldw	_uip_stat+44,x
 773                     ; 347   uip_stat.icmp.typeerr = 0;
 775  019b cf0057        	ldw	_uip_stat+50,x
 776  019e cf0055        	ldw	_uip_stat+48,x
 777                     ; 348   uip_stat.tcp.drop = 0;
 779  01a1 cf005b        	ldw	_uip_stat+54,x
 780  01a4 cf0059        	ldw	_uip_stat+52,x
 781                     ; 349   uip_stat.tcp.recv = 0;
 783  01a7 cf005f        	ldw	_uip_stat+58,x
 784  01aa cf005d        	ldw	_uip_stat+56,x
 785                     ; 350   uip_stat.tcp.sent = 0;
 787  01ad cf0063        	ldw	_uip_stat+62,x
 788  01b0 cf0061        	ldw	_uip_stat+60,x
 789                     ; 351   uip_stat.tcp.chkerr = 0;
 791  01b3 cf0067        	ldw	_uip_stat+66,x
 792  01b6 cf0065        	ldw	_uip_stat+64,x
 793                     ; 352   uip_stat.tcp.ackerr = 0;
 795  01b9 cf006b        	ldw	_uip_stat+70,x
 796  01bc cf0069        	ldw	_uip_stat+68,x
 797                     ; 353   uip_stat.tcp.rst = 0;
 799  01bf cf006f        	ldw	_uip_stat+74,x
 800  01c2 cf006d        	ldw	_uip_stat+72,x
 801                     ; 354   uip_stat.tcp.rexmit = 0;
 803  01c5 cf0073        	ldw	_uip_stat+78,x
 804  01c8 cf0071        	ldw	_uip_stat+76,x
 805                     ; 355   uip_stat.tcp.syndrop = 0;
 807  01cb cf0077        	ldw	_uip_stat+82,x
 808  01ce cf0075        	ldw	_uip_stat+80,x
 809                     ; 356   uip_stat.tcp.synrst = 0;
 811  01d1 cf007b        	ldw	_uip_stat+86,x
 812  01d4 cf0079        	ldw	_uip_stat+84,x
 813                     ; 358 }
 816  01d7 81            	ret	
 850                     ; 362 void uip_unlisten(uint16_t port)
 850                     ; 363 {
 851                     	switch	.text
 852  01d8               _uip_unlisten:
 854  01d8 89            	pushw	x
 855       00000000      OFST:	set	0
 858                     ; 364   for (c = 0; c < UIP_LISTENPORTS; ++c) {
 860  01d9 4f            	clr	a
 861  01da c70003        	ld	L14_c,a
 862  01dd               L303:
 863                     ; 365     if (uip_listenports[c] == port) {
 865  01dd 5f            	clrw	x
 866  01de 97            	ld	xl,a
 867  01df 58            	sllw	x
 868  01e0 de000a        	ldw	x,(_uip_listenports,x)
 869  01e3 1301          	cpw	x,(OFST+1,sp)
 870  01e5 260a          	jrne	L113
 871                     ; 366       uip_listenports[c] = 0;
 873  01e7 5f            	clrw	x
 874  01e8 97            	ld	xl,a
 875  01e9 58            	sllw	x
 876  01ea 905f          	clrw	y
 877  01ec df000a        	ldw	(_uip_listenports,x),y
 878                     ; 367       return;
 880  01ef 200b          	jra	L26
 881  01f1               L113:
 882                     ; 364   for (c = 0; c < UIP_LISTENPORTS; ++c) {
 884  01f1 725c0003      	inc	L14_c
 887  01f5 c60003        	ld	a,L14_c
 888  01f8 a105          	cp	a,#5
 889  01fa 25e1          	jrult	L303
 890                     ; 370 }
 891  01fc               L26:
 894  01fc 85            	popw	x
 895  01fd 81            	ret	
 929                     ; 374 void uip_listen(uint16_t port)
 929                     ; 375 {
 930                     	switch	.text
 931  01fe               _uip_listen:
 933  01fe 89            	pushw	x
 934       00000000      OFST:	set	0
 937                     ; 376   for (c = 0; c < UIP_LISTENPORTS; ++c) {
 939  01ff 4f            	clr	a
 940  0200 c70003        	ld	L14_c,a
 941  0203               L723:
 942                     ; 377     if (uip_listenports[c] == 0) {
 944  0203 5f            	clrw	x
 945  0204 97            	ld	xl,a
 946  0205 58            	sllw	x
 947  0206 d6000b        	ld	a,(_uip_listenports+1,x)
 948  0209 da000a        	or	a,(_uip_listenports,x)
 949  020c 2607          	jrne	L533
 950                     ; 378       uip_listenports[c] = port;
 952  020e 1601          	ldw	y,(OFST+1,sp)
 953  0210 df000a        	ldw	(_uip_listenports,x),y
 954                     ; 379       return;
 956  0213 200b          	jra	L66
 957  0215               L533:
 958                     ; 376   for (c = 0; c < UIP_LISTENPORTS; ++c) {
 960  0215 725c0003      	inc	L14_c
 963  0219 c60003        	ld	a,L14_c
 964  021c a105          	cp	a,#5
 965  021e 25e3          	jrult	L723
 966                     ; 382 }
 967  0220               L66:
 970  0220 85            	popw	x
 971  0221 81            	ret	
1006                     ; 386 static void uip_add_rcv_nxt(uint16_t n)
1006                     ; 387 {
1007                     	switch	.text
1008  0222               L733_uip_add_rcv_nxt:
1012                     ; 388   uip_add32(uip_conn->rcv_nxt, n);
1014  0222 89            	pushw	x
1015  0223 ce0171        	ldw	x,_uip_conn
1016  0226 1c0008        	addw	x,#8
1017  0229 cd0004        	call	_uip_add32
1019  022c 85            	popw	x
1020                     ; 389   uip_conn->rcv_nxt[0] = uip_acc32[0];
1022  022d ce0171        	ldw	x,_uip_conn
1023  0230 c6007d        	ld	a,_uip_acc32
1024  0233 e708          	ld	(8,x),a
1025                     ; 390   uip_conn->rcv_nxt[1] = uip_acc32[1];
1027  0235 c6007e        	ld	a,_uip_acc32+1
1028  0238 e709          	ld	(9,x),a
1029                     ; 391   uip_conn->rcv_nxt[2] = uip_acc32[2];
1031  023a c6007f        	ld	a,_uip_acc32+2
1032  023d e70a          	ld	(10,x),a
1033                     ; 392   uip_conn->rcv_nxt[3] = uip_acc32[3];
1035  023f c60080        	ld	a,_uip_acc32+3
1036  0242 e70b          	ld	(11,x),a
1037                     ; 393 }
1040  0244 81            	ret	
1327                     ; 397 void uip_process(uint8_t flag)
1327                     ; 398 {
1328                     	switch	.text
1329  0245               _uip_process:
1331  0245 88            	push	a
1332  0246 5205          	subw	sp,#5
1333       00000005      OFST:	set	5
1336                     ; 399   register struct uip_conn *uip_connr = uip_conn;
1338  0248 ce0171        	ldw	x,_uip_conn
1339  024b 1f04          	ldw	(OFST-1,sp),x
1341                     ; 401   uip_sappdata = uip_appdata = &uip_buf[UIP_IPTCPH_LEN + UIP_LLH_LEN];
1343  024d ae01ad        	ldw	x,#_uip_buf+54
1344  0250 cf0175        	ldw	_uip_appdata,x
1345  0253 cf0016        	ldw	_uip_sappdata,x
1346                     ; 405   if (flag == UIP_POLL_REQUEST) {
1348  0256 a103          	cp	a,#3
1349  0258 2614          	jrne	L775
1350                     ; 406     if ((uip_connr->tcpstateflags & UIP_TS_MASK) == UIP_ESTABLISHED && !uip_outstanding(uip_connr)) {
1352  025a 1e04          	ldw	x,(OFST-1,sp)
1353  025c e619          	ld	a,(25,x)
1354  025e a40f          	and	a,#15
1355  0260 a103          	cp	a,#3
1356  0262 2703cc0b33    	jrne	L734
1358  0267 e611          	ld	a,(17,x)
1359  0269 ea10          	or	a,(16,x)
1360                     ; 407       uip_flags = UIP_POLL;
1361                     ; 408       UIP_APPCALL();
1363                     ; 409       goto appsend;
1365  026b cc0339        	jp	LC001
1366  026e               L775:
1367                     ; 415   else if (flag == UIP_TIMER) {
1369  026e 7b06          	ld	a,(OFST+1,sp)
1370  0270 a102          	cp	a,#2
1371  0272 2703cc0359    	jrne	L306
1372                     ; 417     if (++iss[3] == 0) {
1374  0277 725c0007      	inc	L73_iss+3
1375  027b 2610          	jrne	L706
1376                     ; 418       if (++iss[2] == 0) {
1378  027d 725c0006      	inc	L73_iss+2
1379  0281 260a          	jrne	L706
1380                     ; 419         if (++iss[1] == 0) {
1382  0283 725c0005      	inc	L73_iss+1
1383  0287 2604          	jrne	L706
1384                     ; 420           ++iss[0];
1386  0289 725c0004      	inc	L73_iss
1387  028d               L706:
1388                     ; 426     uip_len = 0;
1390  028d 5f            	clrw	x
1391  028e cf0173        	ldw	_uip_len,x
1392                     ; 427     uip_slen = 0;
1394  0291 cf0014        	ldw	_uip_slen,x
1395                     ; 433     if (uip_connr->tcpstateflags == UIP_TIME_WAIT || uip_connr->tcpstateflags == UIP_FIN_WAIT_2) {
1397  0294 1e04          	ldw	x,(OFST-1,sp)
1398  0296 e619          	ld	a,(25,x)
1399  0298 a107          	cp	a,#7
1400  029a 2704          	jreq	L716
1402  029c a105          	cp	a,#5
1403  029e 260d          	jrne	L516
1404  02a0               L716:
1405                     ; 434       ++(uip_connr->timer);
1407  02a0 6c1a          	inc	(26,x)
1408                     ; 435       if (uip_connr->timer == UIP_TIME_WAIT_TIMEOUT) {
1410  02a2 e61a          	ld	a,(26,x)
1411  02a4 a178          	cp	a,#120
1412  02a6 26bc          	jrne	L734
1413                     ; 436         uip_connr->tcpstateflags = UIP_CLOSED;
1415  02a8 6f19          	clr	(25,x)
1416  02aa cc0b33        	jra	L734
1417  02ad               L516:
1418                     ; 439     else if (uip_connr->tcpstateflags != UIP_CLOSED) {
1420  02ad e619          	ld	a,(25,x)
1421  02af 27f9          	jreq	L734
1422                     ; 443       if (uip_outstanding(uip_connr)) {
1424  02b1 e611          	ld	a,(17,x)
1425  02b3 ea10          	or	a,(16,x)
1426  02b5 277c          	jreq	L726
1427                     ; 444         if (uip_connr->timer-- == 0) {
1429  02b7 e61a          	ld	a,(26,x)
1430  02b9 6a1a          	dec	(26,x)
1431  02bb 4d            	tnz	a
1432  02bc 26ec          	jrne	L734
1433                     ; 445           if (uip_connr->nrtx == UIP_MAXRTX
1433                     ; 446 	    || ((uip_connr->tcpstateflags == UIP_SYN_SENT
1433                     ; 447             || uip_connr->tcpstateflags == UIP_SYN_RCVD)
1433                     ; 448             && uip_connr->nrtx == UIP_MAXSYNRTX)) {
1435  02be e61b          	ld	a,(27,x)
1436  02c0 a108          	cp	a,#8
1437  02c2 270f          	jreq	L536
1439  02c4 e619          	ld	a,(25,x)
1440  02c6 a102          	cp	a,#2
1441  02c8 2703          	jreq	L736
1443  02ca 4a            	dec	a
1444  02cb 2616          	jrne	L336
1445  02cd               L736:
1447  02cd e61b          	ld	a,(27,x)
1448  02cf a105          	cp	a,#5
1449  02d1 2610          	jrne	L336
1450  02d3               L536:
1451                     ; 449             uip_connr->tcpstateflags = UIP_CLOSED;
1453  02d3 6f19          	clr	(25,x)
1454                     ; 454             uip_flags = UIP_TIMEDOUT;
1456  02d5 35800024      	mov	_uip_flags,#128
1457                     ; 455             UIP_APPCALL();
1459  02d9 cd0000        	call	_uip_TcpAppHubCall
1461                     ; 458             BUF->flags = TCP_RST | TCP_ACK;
1463  02dc 351401a6      	mov	_uip_buf+47,#20
1464                     ; 459             goto tcp_send_nodata;
1466  02e0 cc0966        	jra	L324
1467  02e3               L336:
1468                     ; 463 	  if(uip_connr->nrtx > 4) uip_connr->nrtx = 4;
1470  02e3 1e04          	ldw	x,(OFST-1,sp)
1471  02e5 e61b          	ld	a,(27,x)
1472  02e7 a105          	cp	a,#5
1473  02e9 2504          	jrult	L146
1476  02eb a604          	ld	a,#4
1477  02ed e71b          	ld	(27,x),a
1478  02ef               L146:
1479                     ; 464 	  uip_connr->timer = (uint8_t)(UIP_RTO << uip_connr->nrtx);
1481  02ef 5f            	clrw	x
1482  02f0 97            	ld	xl,a
1483  02f1 a603          	ld	a,#3
1484  02f3 5d            	tnzw	x
1485  02f4 2704          	jreq	L201
1486  02f6               L401:
1487  02f6 48            	sll	a
1488  02f7 5a            	decw	x
1489  02f8 26fc          	jrne	L401
1490  02fa               L201:
1491  02fa 1e04          	ldw	x,(OFST-1,sp)
1492  02fc e71a          	ld	(26,x),a
1493                     ; 465 	  ++(uip_connr->nrtx);
1495  02fe 6c1b          	inc	(27,x)
1496                     ; 473           UIP_STAT(++uip_stat.tcp.rexmit);
1498  0300 ae0071        	ldw	x,#_uip_stat+76
1499  0303 a601          	ld	a,#1
1500  0305 cd0000        	call	c_lgadc
1502                     ; 474           switch (uip_connr->tcpstateflags & UIP_TS_MASK) {
1504  0308 1e04          	ldw	x,(OFST-1,sp)
1505  030a e619          	ld	a,(25,x)
1506  030c a40f          	and	a,#15
1508                     ; 488             case UIP_FIN_WAIT_1:
1508                     ; 489             case UIP_CLOSING:
1508                     ; 490             case UIP_LAST_ACK:
1508                     ; 491               /* In all these states we should retransmit a FINACK. */
1508                     ; 492               goto tcp_send_finack;
1509  030e 4a            	dec	a
1510  030f 2603cc0715    	jreq	L173
1511  0314 a002          	sub	a,#2
1512  0316 2711          	jreq	L753
1513  0318 4a            	dec	a
1514  0319 2603cc0962    	jreq	LC003
1515  031e a002          	sub	a,#2
1516  0320 27f9          	jreq	LC003
1517  0322 a002          	sub	a,#2
1518  0324 27f5          	jreq	LC003
1519  0326 cc0b33        	jra	L734
1520  0329               L753:
1521                     ; 479             case UIP_ESTABLISHED:
1521                     ; 480               /* In the ESTABLISHED state, we call upon the application
1521                     ; 481                  to do the actual retransmit after which we jump into
1521                     ; 482                  the code for sending out the packet (the apprexmit
1521                     ; 483                  label). */
1521                     ; 484               uip_flags = UIP_REXMIT;
1523  0329 35040024      	mov	_uip_flags,#4
1524                     ; 485               UIP_APPCALL();
1526  032d cd0000        	call	_uip_TcpAppHubCall
1528                     ; 486               goto apprexmit;
1530  0330 cc09a9        	jra	L504
1531                     ; 488             case UIP_FIN_WAIT_1:
1531                     ; 489             case UIP_CLOSING:
1531                     ; 490             case UIP_LAST_ACK:
1531                     ; 491               /* In all these states we should retransmit a FINACK. */
1531                     ; 492               goto tcp_send_finack;
1533  0333               L726:
1534                     ; 497       else if ((uip_connr->tcpstateflags & UIP_TS_MASK) == UIP_ESTABLISHED) {
1536  0333 e619          	ld	a,(25,x)
1537  0335 a40f          	and	a,#15
1538  0337 a103          	cp	a,#3
1539                     ; 499         uip_flags = UIP_POLL;
1541  0339               LC001:
1542  0339 26eb          	jrne	L734
1544  033b 35080024      	mov	_uip_flags,#8
1545                     ; 500         UIP_APPCALL();
1548                     ; 501         goto appsend;
1549  033f               L304:
1553  033f cd0000        	call	_uip_TcpAppHubCall
1554                     ; 970         appsend:
1554                     ; 971 
1554                     ; 972         if (uip_flags & UIP_ABORT) {
1556  0342 720a002403cc  	btjf	_uip_flags,#5,L7111
1557                     ; 973           uip_slen = 0;
1559  034a 5f            	clrw	x
1560  034b cf0014        	ldw	_uip_slen,x
1561                     ; 974           uip_connr->tcpstateflags = UIP_CLOSED;
1563  034e 1e04          	ldw	x,(OFST-1,sp)
1564                     ; 975           BUF->flags = TCP_RST | TCP_ACK;
1566  0350 351401a6      	mov	_uip_buf+47,#20
1567  0354 6f19          	clr	(25,x)
1568                     ; 976           goto tcp_send_nodata;
1570  0356 cc0966        	jra	L324
1571  0359               L306:
1572                     ; 508   UIP_STAT(++uip_stat.ip.recv);
1574  0359 ae0029        	ldw	x,#_uip_stat+4
1575  035c a601          	ld	a,#1
1576  035e cd0000        	call	c_lgadc
1578                     ; 513   if (BUF->vhl != 0x45) { /* IP version and header length. */
1580  0361 c60185        	ld	a,_uip_buf+14
1581  0364 a145          	cp	a,#69
1582  0366 2713          	jreq	L356
1583                     ; 514     UIP_STAT(++uip_stat.ip.drop);
1585  0368 ae0025        	ldw	x,#_uip_stat
1586  036b a601          	ld	a,#1
1587  036d cd0000        	call	c_lgadc
1589                     ; 515     UIP_STAT(++uip_stat.ip.vhlerr);
1591  0370 ae0031        	ldw	x,#_uip_stat+12
1592  0373 a601          	ld	a,#1
1593  0375 cd0000        	call	c_lgadc
1595                     ; 516     goto drop;
1597  0378 cc0b33        	jra	L734
1598  037b               L356:
1599                     ; 526   if ((BUF->len[0] << 8) + BUF->len[1] <= uip_len) {
1601  037b c60187        	ld	a,_uip_buf+16
1602  037e 5f            	clrw	x
1603  037f 97            	ld	xl,a
1604  0380 4f            	clr	a
1605  0381 cb0188        	add	a,_uip_buf+17
1606  0384 2401          	jrnc	L211
1607  0386 5c            	incw	x
1608  0387               L211:
1609  0387 02            	rlwa	x,a
1610  0388 c30173        	cpw	x,_uip_len
1611  038b 22eb          	jrugt	L734
1612                     ; 527     uip_len = (BUF->len[0] << 8) + BUF->len[1];
1614  038d c60187        	ld	a,_uip_buf+16
1615  0390 5f            	clrw	x
1616  0391 97            	ld	xl,a
1617  0392 4f            	clr	a
1618  0393 cb0188        	add	a,_uip_buf+17
1619  0396 2401          	jrnc	L411
1620  0398 5c            	incw	x
1621  0399               L411:
1622  0399 c70174        	ld	_uip_len+1,a
1623  039c 9f            	ld	a,xl
1624  039d c70173        	ld	_uip_len,a
1626                     ; 534   if ((BUF->ipoffset[0] & 0x3f) != 0 || BUF->ipoffset[1] != 0) {
1628  03a0 c6018b        	ld	a,_uip_buf+20
1629  03a3 a53f          	bcp	a,#63
1630  03a5 2605          	jrne	L366
1632  03a7 c6018c        	ld	a,_uip_buf+21
1633  03aa 2713          	jreq	L166
1634  03ac               L366:
1635                     ; 535     UIP_STAT(++uip_stat.ip.drop);
1637  03ac ae0025        	ldw	x,#_uip_stat
1638  03af a601          	ld	a,#1
1639  03b1 cd0000        	call	c_lgadc
1641                     ; 536     UIP_STAT(++uip_stat.ip.fragerr);
1643  03b4 ae003d        	ldw	x,#_uip_stat+24
1644  03b7 a601          	ld	a,#1
1645  03b9 cd0000        	call	c_lgadc
1647                     ; 537     goto drop;
1649  03bc cc0b33        	jra	L734
1650  03bf               L166:
1651                     ; 541     if (!uip_ipaddr_cmp(BUF->destipaddr, uip_hostaddr)) {
1653  03bf ce0195        	ldw	x,_uip_buf+30
1654  03c2 c30020        	cpw	x,_uip_hostaddr
1655  03c5 2608          	jrne	L766
1657  03c7 ce0197        	ldw	x,_uip_buf+32
1658  03ca c30022        	cpw	x,_uip_hostaddr+2
1659  03cd 270b          	jreq	L566
1660  03cf               L766:
1661                     ; 542       UIP_STAT(++uip_stat.ip.drop);
1663  03cf ae0025        	ldw	x,#_uip_stat
1664  03d2 a601          	ld	a,#1
1665  03d4 cd0000        	call	c_lgadc
1667                     ; 543       goto drop;
1669  03d7 cc0b33        	jra	L734
1670  03da               L566:
1671                     ; 546   if (uip_ipchksum() != 0xffff) { /* Compute and check the IP header checksum. */
1673  03da cd00bb        	call	_uip_ipchksum
1675  03dd 5c            	incw	x
1676  03de 2713          	jreq	L176
1677                     ; 547     UIP_STAT(++uip_stat.ip.drop);
1679  03e0 ae0025        	ldw	x,#_uip_stat
1680  03e3 a601          	ld	a,#1
1681  03e5 cd0000        	call	c_lgadc
1683                     ; 548     UIP_STAT(++uip_stat.ip.chkerr);
1685  03e8 ae0041        	ldw	x,#_uip_stat+28
1686  03eb a601          	ld	a,#1
1687  03ed cd0000        	call	c_lgadc
1689                     ; 549     goto drop;
1691  03f0 cc0b33        	jra	L734
1692  03f3               L176:
1693                     ; 552   if (BUF->proto == UIP_PROTO_TCP) {
1695  03f3 c6018e        	ld	a,_uip_buf+23
1696  03f6 a106          	cp	a,#6
1697  03f8 2624          	jrne	L376
1698                     ; 554     goto tcp_input;
1699                     ; 601   tcp_input:
1699                     ; 602   UIP_STAT(++uip_stat.tcp.recv);
1701  03fa ae005d        	ldw	x,#_uip_stat+56
1702  03fd a601          	ld	a,#1
1703  03ff cd0000        	call	c_lgadc
1705                     ; 606   if (uip_tcpchksum() != 0xffff) { /* Compute and check the TCP checksum. */
1707  0402 cd0120        	call	_uip_tcpchksum
1709  0405 5c            	incw	x
1710  0406 2603cc0497    	jreq	L517
1711                     ; 607     UIP_STAT(++uip_stat.tcp.drop);
1713  040b ae0059        	ldw	x,#_uip_stat+52
1714  040e a601          	ld	a,#1
1715  0410 cd0000        	call	c_lgadc
1717                     ; 608     UIP_STAT(++uip_stat.tcp.chkerr);
1719  0413 ae0065        	ldw	x,#_uip_stat+64
1720  0416 a601          	ld	a,#1
1721  0418 cd0000        	call	c_lgadc
1723                     ; 609     goto drop;
1725  041b cc0b33        	jra	L734
1726  041e               L376:
1727                     ; 563   if (BUF->proto != UIP_PROTO_ICMP) { /* We only allow ICMP packets from here. */
1729  041e 4a            	dec	a
1730  041f 2713          	jreq	L576
1731                     ; 564     UIP_STAT(++uip_stat.ip.drop);
1733  0421 ae0025        	ldw	x,#_uip_stat
1734  0424 a601          	ld	a,#1
1735  0426 cd0000        	call	c_lgadc
1737                     ; 565     UIP_STAT(++uip_stat.ip.protoerr);
1739  0429 ae0045        	ldw	x,#_uip_stat+32
1740  042c a601          	ld	a,#1
1741  042e cd0000        	call	c_lgadc
1743                     ; 566     goto drop;
1745  0431 cc0b33        	jra	L734
1746  0434               L576:
1747                     ; 569   UIP_STAT(++uip_stat.icmp.recv);
1749  0434 ae004d        	ldw	x,#_uip_stat+40
1750  0437 4c            	inc	a
1751  0438 cd0000        	call	c_lgadc
1753                     ; 574   if (ICMPBUF->type != ICMP_ECHO) {
1755  043b c60199        	ld	a,_uip_buf+34
1756  043e a108          	cp	a,#8
1757  0440 2713          	jreq	L776
1758                     ; 575     UIP_STAT(++uip_stat.icmp.drop);
1760  0442 ae0049        	ldw	x,#_uip_stat+36
1761  0445 a601          	ld	a,#1
1762  0447 cd0000        	call	c_lgadc
1764                     ; 576     UIP_STAT(++uip_stat.icmp.typeerr);
1766  044a ae0055        	ldw	x,#_uip_stat+48
1767  044d a601          	ld	a,#1
1768  044f cd0000        	call	c_lgadc
1770                     ; 577     goto drop;
1772  0452 cc0b33        	jra	L734
1773  0455               L776:
1774                     ; 580   ICMPBUF->type = ICMP_ECHO_REPLY;
1776  0455 725f0199      	clr	_uip_buf+34
1777                     ; 582   if (ICMPBUF->icmpchksum >= HTONS(0xffff - (ICMP_ECHO << 8))) {
1779  0459 ce019b        	ldw	x,_uip_buf+36
1780  045c a3f7ff        	cpw	x,#63487
1781  045f 2505          	jrult	L107
1782                     ; 583     ICMPBUF->icmpchksum += HTONS(ICMP_ECHO << 8) + 1;
1784  0461 1c0801        	addw	x,#2049
1786  0464 2003          	jra	L507
1787  0466               L107:
1788                     ; 586     ICMPBUF->icmpchksum += HTONS(ICMP_ECHO << 8);
1790  0466 1c0800        	addw	x,#2048
1791  0469               L507:
1792  0469 cf019b        	ldw	_uip_buf+36,x
1793                     ; 590   uip_ipaddr_copy(BUF->destipaddr, BUF->srcipaddr);
1795  046c ce0191        	ldw	x,_uip_buf+26
1796  046f cf0195        	ldw	_uip_buf+30,x
1799  0472 ce0193        	ldw	x,_uip_buf+28
1800  0475 cf0197        	ldw	_uip_buf+32,x
1801                     ; 591   uip_ipaddr_copy(BUF->srcipaddr, uip_hostaddr);
1803  0478 ce0020        	ldw	x,_uip_hostaddr
1804  047b cf0191        	ldw	_uip_buf+26,x
1807  047e ce0022        	ldw	x,_uip_hostaddr+2
1808  0481 cf0193        	ldw	_uip_buf+28,x
1809                     ; 593   UIP_STAT(++uip_stat.icmp.sent);
1811  0484 ae0051        	ldw	x,#_uip_stat+44
1813                     ; 594   goto send;
1814  0487               L534:
1815  0487 a601          	ld	a,#1
1816  0489 cd0000        	call	c_lgadc
1817                     ; 1175   send:
1817                     ; 1176 
1817                     ; 1177   UIP_STAT(++uip_stat.ip.sent);
1819  048c ae002d        	ldw	x,#_uip_stat+8
1820  048f a601          	ld	a,#1
1821  0491 cd0000        	call	c_lgadc
1823                     ; 1179   uip_flags = 0;
1824                     ; 1181   return;
1826  0494 cc0b37        	jra	L202
1827  0497               L517:
1828                     ; 614   for (uip_connr = &uip_conns[0]; uip_connr <= &uip_conns[UIP_CONNS - 1]; ++uip_connr) {
1830  0497 ae0081        	ldw	x,#_uip_conns
1832  049a 204d          	jra	L327
1833  049c               L717:
1834                     ; 615     if (uip_connr->tcpstateflags != UIP_CLOSED
1834                     ; 616       && BUF->destport == uip_connr->lport
1834                     ; 617       && BUF->srcport == uip_connr->rport
1834                     ; 618       && uip_ipaddr_cmp(BUF->srcipaddr, uip_connr->ripaddr)) {
1836  049c e619          	ld	a,(25,x)
1837  049e 2746          	jreq	L727
1839  04a0 9093          	ldw	y,x
1840  04a2 90ee04        	ldw	y,(4,y)
1841  04a5 90c3019b      	cpw	y,_uip_buf+36
1842  04a9 263b          	jrne	L727
1844  04ab 9093          	ldw	y,x
1845  04ad 90ee06        	ldw	y,(6,y)
1846  04b0 90c30199      	cpw	y,_uip_buf+34
1847  04b4 2630          	jrne	L727
1849  04b6 9093          	ldw	y,x
1850  04b8 90fe          	ldw	y,(y)
1851  04ba 90c30191      	cpw	y,_uip_buf+26
1852  04be 2626          	jrne	L727
1854  04c0 9093          	ldw	y,x
1855  04c2 90ee02        	ldw	y,(2,y)
1856  04c5 90c30193      	cpw	y,_uip_buf+28
1857  04c9 261b          	jrne	L727
1858                     ; 619       goto found;
1859                     ; 799   found:
1859                     ; 800   uip_conn = uip_connr;
1861  04cb cf0171        	ldw	_uip_conn,x
1862                     ; 801   uip_flags = 0;
1864  04ce 725f0024      	clr	_uip_flags
1865                     ; 806   if (BUF->flags & TCP_RST) {
1867  04d2 720401a603cc  	btjf	_uip_buf+47,#2,L7301
1868                     ; 807     uip_connr->tcpstateflags = UIP_CLOSED;
1870  04da 6f19          	clr	(25,x)
1871                     ; 808     uip_flags = UIP_ABORT;
1873  04dc 35200024      	mov	_uip_flags,#32
1874                     ; 809     UIP_APPCALL();
1876  04e0 cd0000        	call	_uip_TcpAppHubCall
1878                     ; 810     goto drop;
1880  04e3 cc0b33        	jra	L734
1881  04e6               L727:
1882                     ; 614   for (uip_connr = &uip_conns[0]; uip_connr <= &uip_conns[UIP_CONNS - 1]; ++uip_connr) {
1884  04e6 1c0028        	addw	x,#40
1885  04e9               L327:
1886  04e9 1f04          	ldw	(OFST-1,sp),x
1890  04eb a30149        	cpw	x,#_uip_conns+200
1891  04ee 23ac          	jrule	L717
1892                     ; 627   if ((BUF->flags & TCP_CTL) != TCP_SYN) {
1894  04f0 c601a6        	ld	a,_uip_buf+47
1895  04f3 a43f          	and	a,#63
1896  04f5 a102          	cp	a,#2
1897  04f7 2647          	jrne	L563
1898                     ; 628     goto reset;
1900                     ; 631   tmp16 = BUF->destport;
1902  04f9 ce019b        	ldw	x,_uip_buf+36
1903  04fc cf0000        	ldw	L54_tmp16,x
1904                     ; 633   for (c = 0; c < UIP_LISTENPORTS; ++c) {
1906  04ff 4f            	clr	a
1907  0500 c70003        	ld	L14_c,a
1908  0503               L337:
1909                     ; 634     if (tmp16 == uip_listenports[c]) goto found_listen;
1911  0503 5f            	clrw	x
1912  0504 97            	ld	xl,a
1913  0505 58            	sllw	x
1914  0506 9093          	ldw	y,x
1915  0508 90de000a      	ldw	y,(_uip_listenports,y)
1916  050c 90c30000      	cpw	y,L54_tmp16
1917  0510 261b          	jrne	L147
1919                     ; 699   found_listen:
1919                     ; 700   /* First we check if there are any connections avaliable. Unused
1919                     ; 701      connections are kept in the same table as used connections, but
1919                     ; 702      unused ones have the tcpstate set to CLOSED. Also, connections in
1919                     ; 703      TIME_WAIT are kept track of and we'll use the oldest one if no
1919                     ; 704      CLOSED connections are found. Thanks to Eddie C. Dost for a very
1919                     ; 705      nice algorithm for the TIME_WAIT search. */
1919                     ; 706   uip_connr = 0;
1921  0512 5f            	clrw	x
1922  0513 1f04          	ldw	(OFST-1,sp),x
1924                     ; 707   for (c = 0; c < UIP_CONNS; ++c) {
1926  0515 4f            	clr	a
1927  0516 c70003        	ld	L14_c,a
1928  0519               L367:
1929                     ; 708     if (uip_conns[c].tcpstateflags == UIP_CLOSED) {
1931  0519 97            	ld	xl,a
1932  051a a628          	ld	a,#40
1933  051c 42            	mul	x,a
1934  051d d6009a        	ld	a,(_uip_conns+25,x)
1935  0520 2703cc05da    	jrne	L177
1936                     ; 709       uip_connr = &uip_conns[c];
1938  0525 1c0081        	addw	x,#_uip_conns
1939  0528 1f04          	ldw	(OFST-1,sp),x
1941                     ; 710       break;
1943  052a cc060c        	jra	L767
1944  052d               L147:
1945                     ; 633   for (c = 0; c < UIP_LISTENPORTS; ++c) {
1947  052d 725c0003      	inc	L14_c
1950  0531 c60003        	ld	a,L14_c
1951  0534 a105          	cp	a,#5
1952  0536 25cb          	jrult	L337
1953                     ; 638   UIP_STAT(++uip_stat.tcp.synrst);
1955  0538 ae0079        	ldw	x,#_uip_stat+84
1956  053b a601          	ld	a,#1
1957  053d cd0000        	call	c_lgadc
1959  0540               L563:
1960                     ; 639   reset:
1960                     ; 640 
1960                     ; 641   /* We do not send resets in response to resets. */
1960                     ; 642   if (BUF->flags & TCP_RST) {
1962  0540 720401a69e    	btjt	_uip_buf+47,#2,L734
1963                     ; 643     goto drop;
1965                     ; 646   UIP_STAT(++uip_stat.tcp.rst);
1967  0545 ae006d        	ldw	x,#_uip_stat+72
1968  0548 a601          	ld	a,#1
1969  054a cd0000        	call	c_lgadc
1971                     ; 648   BUF->flags = TCP_RST | TCP_ACK;
1973  054d 351401a6      	mov	_uip_buf+47,#20
1974                     ; 649   uip_len = UIP_IPTCPH_LEN;
1976  0551 ae0028        	ldw	x,#40
1977  0554 cf0173        	ldw	_uip_len,x
1978                     ; 650   BUF->tcpoffset = 5 << 4;
1980  0557 355001a5      	mov	_uip_buf+46,#80
1981                     ; 653   c = BUF->seqno[3];
1983  055b 5501a00003    	mov	L14_c,_uip_buf+41
1984                     ; 654   BUF->seqno[3] = BUF->ackno[3];
1986  0560 5501a401a0    	mov	_uip_buf+41,_uip_buf+45
1987                     ; 655   BUF->ackno[3] = c;
1989  0565 55000301a4    	mov	_uip_buf+45,L14_c
1990                     ; 657   c = BUF->seqno[2];
1992  056a 55019f0003    	mov	L14_c,_uip_buf+40
1993                     ; 658   BUF->seqno[2] = BUF->ackno[2];
1995  056f 5501a3019f    	mov	_uip_buf+40,_uip_buf+44
1996                     ; 659   BUF->ackno[2] = c;
1998  0574 55000301a3    	mov	_uip_buf+44,L14_c
1999                     ; 661   c = BUF->seqno[1];
2001  0579 55019e0003    	mov	L14_c,_uip_buf+39
2002                     ; 662   BUF->seqno[1] = BUF->ackno[1];
2004  057e 5501a2019e    	mov	_uip_buf+39,_uip_buf+43
2005                     ; 663   BUF->ackno[1] = c;
2007  0583 55000301a2    	mov	_uip_buf+43,L14_c
2008                     ; 665   c = BUF->seqno[0];
2010  0588 55019d0003    	mov	L14_c,_uip_buf+38
2011                     ; 666   BUF->seqno[0] = BUF->ackno[0];
2013  058d 5501a1019d    	mov	_uip_buf+38,_uip_buf+42
2014                     ; 667   BUF->ackno[0] = c;
2016  0592 55000301a1    	mov	_uip_buf+42,L14_c
2017                     ; 672   if (++BUF->ackno[3] == 0) {
2019  0597 725c01a4      	inc	_uip_buf+45
2020  059b 2610          	jrne	L547
2021                     ; 673     if (++BUF->ackno[2] == 0) {
2023  059d 725c01a3      	inc	_uip_buf+44
2024  05a1 260a          	jrne	L547
2025                     ; 674       if (++BUF->ackno[1] == 0) {
2027  05a3 725c01a2      	inc	_uip_buf+43
2028  05a7 2604          	jrne	L547
2029                     ; 675         ++BUF->ackno[0];
2031  05a9 725c01a1      	inc	_uip_buf+42
2032  05ad               L547:
2033                     ; 681   tmp16 = BUF->srcport;
2035  05ad ce0199        	ldw	x,_uip_buf+34
2036  05b0 cf0000        	ldw	L54_tmp16,x
2037                     ; 682   BUF->srcport = BUF->destport;
2039  05b3 ce019b        	ldw	x,_uip_buf+36
2040  05b6 cf0199        	ldw	_uip_buf+34,x
2041                     ; 683   BUF->destport = tmp16;
2043  05b9 ce0000        	ldw	x,L54_tmp16
2044  05bc cf019b        	ldw	_uip_buf+36,x
2045                     ; 686   uip_ipaddr_copy(BUF->destipaddr, BUF->srcipaddr);
2047  05bf ce0191        	ldw	x,_uip_buf+26
2048  05c2 cf0195        	ldw	_uip_buf+30,x
2051  05c5 ce0193        	ldw	x,_uip_buf+28
2052  05c8 cf0197        	ldw	_uip_buf+32,x
2053                     ; 687   uip_ipaddr_copy(BUF->srcipaddr, uip_hostaddr);
2055  05cb ce0020        	ldw	x,_uip_hostaddr
2056  05ce cf0191        	ldw	_uip_buf+26,x
2059  05d1 ce0022        	ldw	x,_uip_hostaddr+2
2060  05d4 cf0193        	ldw	_uip_buf+28,x
2061                     ; 690   goto tcp_send_noconn;
2063  05d7 cc0ae0        	jra	L134
2064  05da               L177:
2065                     ; 712     if (uip_conns[c].tcpstateflags == UIP_TIME_WAIT) {
2067  05da a107          	cp	a,#7
2068  05dc 2620          	jrne	L377
2069                     ; 713       if (uip_connr == 0 || uip_conns[c].timer > uip_connr->timer) {
2071  05de 1e04          	ldw	x,(OFST-1,sp)
2072  05e0 2710          	jreq	L777
2074  05e2 c60003        	ld	a,L14_c
2075  05e5 97            	ld	xl,a
2076  05e6 a628          	ld	a,#40
2077  05e8 42            	mul	x,a
2078  05e9 d6009b        	ld	a,(_uip_conns+26,x)
2079  05ec 1e04          	ldw	x,(OFST-1,sp)
2080  05ee e11a          	cp	a,(26,x)
2081  05f0 230c          	jrule	L377
2082  05f2               L777:
2083                     ; 714         uip_connr = &uip_conns[c];
2085  05f2 c60003        	ld	a,L14_c
2086  05f5 97            	ld	xl,a
2087  05f6 a628          	ld	a,#40
2088  05f8 42            	mul	x,a
2089  05f9 1c0081        	addw	x,#_uip_conns
2090  05fc 1f04          	ldw	(OFST-1,sp),x
2092  05fe               L377:
2093                     ; 707   for (c = 0; c < UIP_CONNS; ++c) {
2095  05fe 725c0003      	inc	L14_c
2098  0602 c60003        	ld	a,L14_c
2099  0605 a106          	cp	a,#6
2100  0607 2403cc0519    	jrult	L367
2101  060c               L767:
2102                     ; 719   if (uip_connr == 0) {
2104  060c 1e04          	ldw	x,(OFST-1,sp)
2105  060e 260b          	jrne	L1001
2106                     ; 723     UIP_STAT(++uip_stat.tcp.syndrop);
2108  0610 ae0075        	ldw	x,#_uip_stat+80
2109  0613 a601          	ld	a,#1
2110  0615 cd0000        	call	c_lgadc
2112                     ; 724     goto drop;
2114  0618 cc0b33        	jra	L734
2115  061b               L1001:
2116                     ; 726   uip_conn = uip_connr;
2118  061b cf0171        	ldw	_uip_conn,x
2119                     ; 729   uip_connr->rto = uip_connr->timer = UIP_RTO;
2121  061e a603          	ld	a,#3
2122  0620 e71a          	ld	(26,x),a
2123  0622 e718          	ld	(24,x),a
2124                     ; 730   uip_connr->sa = 0;
2126  0624 6f16          	clr	(22,x)
2127                     ; 731   uip_connr->sv = 4;
2129  0626 4c            	inc	a
2130  0627 e717          	ld	(23,x),a
2131                     ; 732   uip_connr->nrtx = 0;
2133  0629 6f1b          	clr	(27,x)
2134                     ; 733   uip_connr->lport = BUF->destport;
2136  062b 90ce019b      	ldw	y,_uip_buf+36
2137  062f ef04          	ldw	(4,x),y
2138                     ; 734   uip_connr->rport = BUF->srcport;
2140  0631 90ce0199      	ldw	y,_uip_buf+34
2141  0635 ef06          	ldw	(6,x),y
2142                     ; 735   uip_ipaddr_copy(uip_connr->ripaddr, BUF->srcipaddr);
2144  0637 90ce0191      	ldw	y,_uip_buf+26
2145  063b ff            	ldw	(x),y
2148  063c 90ce0193      	ldw	y,_uip_buf+28
2149  0640 ef02          	ldw	(2,x),y
2150                     ; 736   uip_connr->tcpstateflags = UIP_SYN_RCVD;
2152  0642 a601          	ld	a,#1
2153  0644 e719          	ld	(25,x),a
2154                     ; 738   uip_connr->snd_nxt[0] = iss[0];
2156  0646 c60004        	ld	a,L73_iss
2157  0649 e70c          	ld	(12,x),a
2158                     ; 739   uip_connr->snd_nxt[1] = iss[1];
2160  064b c60005        	ld	a,L73_iss+1
2161  064e e70d          	ld	(13,x),a
2162                     ; 740   uip_connr->snd_nxt[2] = iss[2];
2164  0650 c60006        	ld	a,L73_iss+2
2165  0653 e70e          	ld	(14,x),a
2166                     ; 741   uip_connr->snd_nxt[3] = iss[3];
2168  0655 c60007        	ld	a,L73_iss+3
2169  0658 e70f          	ld	(15,x),a
2170                     ; 742   uip_connr->len = 1;
2172  065a 90ae0001      	ldw	y,#1
2173  065e ef10          	ldw	(16,x),y
2174                     ; 745   uip_connr->rcv_nxt[3] = BUF->seqno[3];
2176  0660 c601a0        	ld	a,_uip_buf+41
2177  0663 e70b          	ld	(11,x),a
2178                     ; 746   uip_connr->rcv_nxt[2] = BUF->seqno[2];
2180  0665 c6019f        	ld	a,_uip_buf+40
2181  0668 e70a          	ld	(10,x),a
2182                     ; 747   uip_connr->rcv_nxt[1] = BUF->seqno[1];
2184  066a c6019e        	ld	a,_uip_buf+39
2185  066d e709          	ld	(9,x),a
2186                     ; 748   uip_connr->rcv_nxt[0] = BUF->seqno[0];
2188  066f c6019d        	ld	a,_uip_buf+38
2189  0672 e708          	ld	(8,x),a
2190                     ; 749   uip_add_rcv_nxt(1);
2192  0674 ae0001        	ldw	x,#1
2193  0677 cd0222        	call	L733_uip_add_rcv_nxt
2195                     ; 752   if ((BUF->tcpoffset & 0xf0) > 0x50) {
2197  067a c601a5        	ld	a,_uip_buf+46
2198  067d a4f0          	and	a,#240
2199  067f a151          	cp	a,#81
2200  0681 2403cc0715    	jrult	L173
2201                     ; 753     for (c = 0; c < ((BUF->tcpoffset >> 4) - 5) << 2;) {
2203  0686 725f0003      	clr	L14_c
2205  068a 206b          	jra	L5101
2206  068c               L1101:
2207                     ; 754       opt = uip_buf[UIP_TCPIP_HLEN + UIP_LLH_LEN + c];
2209  068c 5f            	clrw	x
2210  068d 97            	ld	xl,a
2211  068e d601ad        	ld	a,(_uip_buf+54,x)
2212  0691 c70002        	ld	L34_opt,a
2213                     ; 755       if (opt == TCP_OPT_END) {
2215  0694 277f          	jreq	L173
2216                     ; 757         break;
2218                     ; 759       else if (opt == TCP_OPT_NOOP) {
2220  0696 a101          	cp	a,#1
2221  0698 2606          	jrne	L5201
2222                     ; 760         ++c;
2224  069a 725c0003      	inc	L14_c
2226  069e 2057          	jra	L5101
2227  06a0               L5201:
2228                     ; 763       else if (opt == TCP_OPT_MSS
2228                     ; 764         && uip_buf[UIP_TCPIP_HLEN + UIP_LLH_LEN + 1 + c] == TCP_OPT_MSS_LEN) {
2230  06a0 a102          	cp	a,#2
2231  06a2 2640          	jrne	L1301
2233  06a4 c60003        	ld	a,L14_c
2234  06a7 5f            	clrw	x
2235  06a8 97            	ld	xl,a
2236  06a9 d601ae        	ld	a,(_uip_buf+55,x)
2237  06ac a104          	cp	a,#4
2238  06ae 2634          	jrne	L1301
2239                     ; 766         tmp16 = ((uint16_t)uip_buf[UIP_TCPIP_HLEN + UIP_LLH_LEN + 2 + c] << 8)
2239                     ; 767 	        | (uint16_t)uip_buf[UIP_IPTCPH_LEN + UIP_LLH_LEN + 3 + c];
2241  06b0 c60003        	ld	a,L14_c
2242  06b3 5f            	clrw	x
2243  06b4 97            	ld	xl,a
2244  06b5 d601b0        	ld	a,(_uip_buf+57,x)
2245  06b8 5f            	clrw	x
2246  06b9 97            	ld	xl,a
2247  06ba 1f01          	ldw	(OFST-4,sp),x
2249  06bc 5f            	clrw	x
2250  06bd c60003        	ld	a,L14_c
2251  06c0 97            	ld	xl,a
2252  06c1 d601af        	ld	a,(_uip_buf+56,x)
2253  06c4 5f            	clrw	x
2254  06c5 97            	ld	xl,a
2255  06c6 7b02          	ld	a,(OFST-3,sp)
2256  06c8 01            	rrwa	x,a
2257  06c9 1a01          	or	a,(OFST-4,sp)
2258  06cb 01            	rrwa	x,a
2259  06cc cf0000        	ldw	L54_tmp16,x
2260                     ; 768         uip_connr->initialmss = uip_connr->mss = tmp16 > UIP_TCP_MSS ? UIP_TCP_MSS : tmp16;
2262  06cf a3034f        	cpw	x,#847
2263  06d2 2503          	jrult	L421
2264  06d4 ae034e        	ldw	x,#846
2265  06d7               L421:
2266  06d7 1604          	ldw	y,(OFST-1,sp)
2267  06d9 90ef12        	ldw	(18,y),x
2268  06dc 93            	ldw	x,y
2269  06dd 90ee12        	ldw	y,(18,y)
2270  06e0 ef14          	ldw	(20,x),y
2271                     ; 771         break;
2273  06e2 2031          	jra	L173
2274  06e4               L1301:
2275                     ; 775         if (uip_buf[UIP_TCPIP_HLEN + UIP_LLH_LEN + 1 + c] == 0) {
2277  06e4 c60003        	ld	a,L14_c
2278  06e7 5f            	clrw	x
2279  06e8 97            	ld	xl,a
2280  06e9 724d01ae      	tnz	(_uip_buf+55,x)
2281  06ed 2726          	jreq	L173
2282                     ; 778           break;
2284                     ; 780         c += uip_buf[UIP_TCPIP_HLEN + UIP_LLH_LEN + 1 + c];
2286  06ef 5f            	clrw	x
2287  06f0 97            	ld	xl,a
2288  06f1 db01ae        	add	a,(_uip_buf+55,x)
2289  06f4 c70003        	ld	L14_c,a
2290  06f7               L5101:
2291                     ; 753     for (c = 0; c < ((BUF->tcpoffset >> 4) - 5) << 2;) {
2293  06f7 c601a5        	ld	a,_uip_buf+46
2294  06fa 4e            	swap	a
2295  06fb a40f          	and	a,#15
2296  06fd 5f            	clrw	x
2297  06fe 97            	ld	xl,a
2298  06ff 58            	sllw	x
2299  0700 58            	sllw	x
2300  0701 1d0014        	subw	x,#20
2301  0704 c60003        	ld	a,L14_c
2302  0707 905f          	clrw	y
2303  0709 9097          	ld	yl,a
2304  070b 90bf00        	ldw	c_y,y
2305  070e b300          	cpw	x,c_y
2306  0710 2d03cc068c    	jrsgt	L1101
2307  0715               L173:
2308                     ; 786   tcp_send_synack:
2308                     ; 787   BUF->flags = TCP_SYN | TCP_ACK;
2310  0715 351201a6      	mov	_uip_buf+47,#18
2311                     ; 790   BUF->optdata[0] = TCP_OPT_MSS;
2313  0719 350201ad      	mov	_uip_buf+54,#2
2314                     ; 791   BUF->optdata[1] = TCP_OPT_MSS_LEN;
2316  071d 350401ae      	mov	_uip_buf+55,#4
2317                     ; 792   BUF->optdata[2] = (UIP_TCP_MSS) / 256;
2319  0721 350301af      	mov	_uip_buf+56,#3
2320                     ; 793   BUF->optdata[3] = (UIP_TCP_MSS) & 255;
2322  0725 354e01b0      	mov	_uip_buf+57,#78
2323                     ; 794   uip_len = UIP_IPTCPH_LEN + TCP_OPT_MSS_LEN;
2325  0729 ae002c        	ldw	x,#44
2326  072c cf0173        	ldw	_uip_len,x
2327                     ; 795   BUF->tcpoffset = ((UIP_TCPH_LEN + TCP_OPT_MSS_LEN) / 4) << 4;
2329  072f 356001a5      	mov	_uip_buf+46,#96
2330                     ; 796   goto tcp_send;
2332  0733 cc09e0        	jra	L724
2333  0736               L7301:
2334                     ; 813   c = (uint8_t)((BUF->tcpoffset >> 4) << 2);
2336  0736 c601a5        	ld	a,_uip_buf+46
2337  0739 4e            	swap	a
2338  073a a40f          	and	a,#15
2339  073c 48            	sll	a
2340  073d 48            	sll	a
2341  073e c70003        	ld	L14_c,a
2342                     ; 817   uip_len = uip_len - c - UIP_IPH_LEN;
2344  0741 c60173        	ld	a,_uip_len
2345  0744 97            	ld	xl,a
2346  0745 c60174        	ld	a,_uip_len+1
2347  0748 c00003        	sub	a,L14_c
2348  074b 2401          	jrnc	L231
2349  074d 5a            	decw	x
2350  074e               L231:
2351  074e 02            	rlwa	x,a
2352  074f 1d0014        	subw	x,#20
2353  0752 cf0173        	ldw	_uip_len,x
2354                     ; 822   if (!(((uip_connr->tcpstateflags & UIP_TS_MASK) == UIP_SYN_SENT)
2354                     ; 823     && ((BUF->flags & TCP_CTL) == (TCP_SYN | TCP_ACK)))) {
2356  0755 1e04          	ldw	x,(OFST-1,sp)
2357  0757 e619          	ld	a,(25,x)
2358  0759 a40f          	and	a,#15
2359  075b a102          	cp	a,#2
2360  075d 2609          	jrne	L3401
2362  075f c601a6        	ld	a,_uip_buf+47
2363  0762 a43f          	and	a,#63
2364  0764 a112          	cp	a,#18
2365  0766 272d          	jreq	L1401
2366  0768               L3401:
2367                     ; 824     if ((uip_len > 0 || ((BUF->flags & (TCP_SYN | TCP_FIN)) != 0))
2367                     ; 825       && (BUF->seqno[0] != uip_connr->rcv_nxt[0]
2367                     ; 826       || BUF->seqno[1] != uip_connr->rcv_nxt[1]
2367                     ; 827       || BUF->seqno[2] != uip_connr->rcv_nxt[2]
2367                     ; 828       || BUF->seqno[3] != uip_connr->rcv_nxt[3])) {
2369  0768 ce0173        	ldw	x,_uip_len
2370  076b 2607          	jrne	L7401
2372  076d c601a6        	ld	a,_uip_buf+47
2373  0770 a503          	bcp	a,#3
2374  0772 2721          	jreq	L1401
2375  0774               L7401:
2377  0774 1e04          	ldw	x,(OFST-1,sp)
2378  0776 e608          	ld	a,(8,x)
2379  0778 c1019d        	cp	a,_uip_buf+38
2380  077b 2703cc0ad1    	jrne	L124
2382  0780 e609          	ld	a,(9,x)
2383  0782 c1019e        	cp	a,_uip_buf+39
2384  0785 26f6          	jrne	L124
2386  0787 e60a          	ld	a,(10,x)
2387  0789 c1019f        	cp	a,_uip_buf+40
2388  078c 26ef          	jrne	L124
2390  078e e60b          	ld	a,(11,x)
2391  0790 c101a0        	cp	a,_uip_buf+41
2392  0793 26e8          	jrne	L124
2393  0795               L1401:
2394                     ; 837   if ((BUF->flags & TCP_ACK) && uip_outstanding(uip_connr)) {
2396  0795 720801a603cc  	btjf	_uip_buf+47,#4,L7501
2398  079d 1e04          	ldw	x,(OFST-1,sp)
2399  079f e611          	ld	a,(17,x)
2400  07a1 ea10          	or	a,(16,x)
2401  07a3 27f5          	jreq	L7501
2402                     ; 838     uip_add32(uip_connr->snd_nxt, uip_connr->len);
2404  07a5 ee10          	ldw	x,(16,x)
2405  07a7 89            	pushw	x
2406  07a8 1e06          	ldw	x,(OFST+1,sp)
2407  07aa 1c000c        	addw	x,#12
2408  07ad cd0004        	call	_uip_add32
2410  07b0 c601a1        	ld	a,_uip_buf+42
2411  07b3 c1007d        	cp	a,_uip_acc32
2412  07b6 85            	popw	x
2413                     ; 840     if (BUF->ackno[0] == uip_acc32[0]
2413                     ; 841       && BUF->ackno[1] == uip_acc32[1]
2413                     ; 842       && BUF->ackno[2] == uip_acc32[2]
2413                     ; 843       && BUF->ackno[3] == uip_acc32[3]) {
2415  07b7 26e1          	jrne	L7501
2417  07b9 c601a2        	ld	a,_uip_buf+43
2418  07bc c1007e        	cp	a,_uip_acc32+1
2419  07bf 26d9          	jrne	L7501
2421  07c1 c601a3        	ld	a,_uip_buf+44
2422  07c4 c1007f        	cp	a,_uip_acc32+2
2423  07c7 26d1          	jrne	L7501
2425  07c9 c601a4        	ld	a,_uip_buf+45
2426  07cc c10080        	cp	a,_uip_acc32+3
2427  07cf 2679          	jrne	L7501
2428                     ; 845       uip_connr->snd_nxt[0] = uip_acc32[0];
2430  07d1 1e04          	ldw	x,(OFST-1,sp)
2431  07d3 c6007d        	ld	a,_uip_acc32
2432  07d6 e70c          	ld	(12,x),a
2433                     ; 846       uip_connr->snd_nxt[1] = uip_acc32[1];
2435  07d8 c6007e        	ld	a,_uip_acc32+1
2436  07db e70d          	ld	(13,x),a
2437                     ; 847       uip_connr->snd_nxt[2] = uip_acc32[2];
2439  07dd c6007f        	ld	a,_uip_acc32+2
2440  07e0 e70e          	ld	(14,x),a
2441                     ; 848       uip_connr->snd_nxt[3] = uip_acc32[3];
2443  07e2 c60080        	ld	a,_uip_acc32+3
2444  07e5 e70f          	ld	(15,x),a
2445                     ; 851       if (uip_connr->nrtx == 0) {
2447  07e7 e61b          	ld	a,(27,x)
2448  07e9 2653          	jrne	L3601
2449                     ; 853         m = (int8_t)(uip_connr->rto - uip_connr->timer);
2451  07eb e61a          	ld	a,(26,x)
2452  07ed e018          	sub	a,(24,x)
2453  07ef 40            	neg	a
2454  07f0 6b03          	ld	(OFST-2,sp),a
2456                     ; 855         m = (int8_t)(m - (uip_connr->sa >> 3));
2458  07f2 e616          	ld	a,(22,x)
2459  07f4 44            	srl	a
2460  07f5 44            	srl	a
2461  07f6 44            	srl	a
2462  07f7 5f            	clrw	x
2463  07f8 97            	ld	xl,a
2464  07f9 1f01          	ldw	(OFST-4,sp),x
2466  07fb 5f            	clrw	x
2467  07fc 7b03          	ld	a,(OFST-2,sp)
2468  07fe 4d            	tnz	a
2469  07ff 2a01          	jrpl	L631
2470  0801 53            	cplw	x
2471  0802               L631:
2472  0802 97            	ld	xl,a
2473  0803 72f001        	subw	x,(OFST-4,sp)
2474  0806 01            	rrwa	x,a
2475  0807 6b03          	ld	(OFST-2,sp),a
2477                     ; 856         uip_connr->sa += m;
2479  0809 1e04          	ldw	x,(OFST-1,sp)
2480  080b e616          	ld	a,(22,x)
2481  080d 1b03          	add	a,(OFST-2,sp)
2482  080f e716          	ld	(22,x),a
2483                     ; 857         if (m < 0) m = (int8_t)(-m);
2485  0811 7b03          	ld	a,(OFST-2,sp)
2486  0813 2a02          	jrpl	L5601
2489  0815 0003          	neg	(OFST-2,sp)
2491  0817               L5601:
2492                     ; 858         m = (int8_t)(m - (uip_connr->sv >> 2));
2494  0817 e617          	ld	a,(23,x)
2495  0819 44            	srl	a
2496  081a 44            	srl	a
2497  081b 5f            	clrw	x
2498  081c 97            	ld	xl,a
2499  081d 1f01          	ldw	(OFST-4,sp),x
2501  081f 5f            	clrw	x
2502  0820 7b03          	ld	a,(OFST-2,sp)
2503  0822 4d            	tnz	a
2504  0823 2a01          	jrpl	L041
2505  0825 53            	cplw	x
2506  0826               L041:
2507  0826 97            	ld	xl,a
2508  0827 72f001        	subw	x,(OFST-4,sp)
2509  082a 01            	rrwa	x,a
2510  082b 6b03          	ld	(OFST-2,sp),a
2512                     ; 859         uip_connr->sv += m;
2514  082d 1e04          	ldw	x,(OFST-1,sp)
2515  082f e617          	ld	a,(23,x)
2516  0831 1b03          	add	a,(OFST-2,sp)
2517  0833 e717          	ld	(23,x),a
2518                     ; 860         uip_connr->rto = (uint8_t)((uip_connr->sa >> 3) + uip_connr->sv);
2520  0835 e616          	ld	a,(22,x)
2521  0837 44            	srl	a
2522  0838 44            	srl	a
2523  0839 44            	srl	a
2524  083a eb17          	add	a,(23,x)
2525  083c e718          	ld	(24,x),a
2526  083e               L3601:
2527                     ; 863       uip_flags = UIP_ACKDATA;
2529  083e 35010024      	mov	_uip_flags,#1
2530                     ; 865       uip_connr->timer = uip_connr->rto;
2532  0842 e618          	ld	a,(24,x)
2533  0844 e71a          	ld	(26,x),a
2534                     ; 868       uip_connr->len = 0;
2536  0846 905f          	clrw	y
2537  0848 ef10          	ldw	(16,x),y
2538  084a               L7501:
2539                     ; 873   switch (uip_connr->tcpstateflags & UIP_TS_MASK) {
2541  084a 1e04          	ldw	x,(OFST-1,sp)
2542  084c e619          	ld	a,(25,x)
2543  084e a40f          	and	a,#15
2545                     ; 1101 	uip_connr->timer = 0;
2546  0850 4a            	dec	a
2547  0851 2725          	jreq	L573
2548  0853 a002          	sub	a,#2
2549  0855 2745          	jreq	L773
2550  0857 4a            	dec	a
2551  0858 2603cc0a5a    	jreq	L114
2552  085d 4a            	dec	a
2553  085e 2603cc0a99    	jreq	L314
2554  0863 4a            	dec	a
2555  0864 2603cc0ac4    	jreq	L714
2556  0869 4a            	dec	a
2557  086a 2603cc0ad1    	jreq	L124
2558  086f 4a            	dec	a
2559  0870 2603cc0a49    	jreq	L704
2560  0875 cc0b33        	jra	L734
2561  0878               L573:
2562                     ; 877     case UIP_SYN_RCVD:
2562                     ; 878       /* In SYN_RCVD we have sent out a SYNACK in response to a SYN, and we are waiting
2562                     ; 879          for an ACK that acknowledges the data we sent out the last time. Therefore, we
2562                     ; 880 	 want to have the UIP_ACKDATA flag set. If so, we enter the ESTABLISHED state. */
2562                     ; 881       if (uip_flags & UIP_ACKDATA) {
2564  0878 72010024f8    	btjf	_uip_flags,#0,L734
2565                     ; 882         uip_connr->tcpstateflags = UIP_ESTABLISHED;
2567  087d a603          	ld	a,#3
2568  087f e719          	ld	(25,x),a
2569                     ; 883         uip_flags = UIP_CONNECTED;
2571  0881 35400024      	mov	_uip_flags,#64
2572                     ; 884         uip_connr->len = 0;
2574  0885 905f          	clrw	y
2575  0887 ef10          	ldw	(16,x),y
2576                     ; 885         if (uip_len > 0) {
2578  0889 ce0173        	ldw	x,_uip_len
2579  088c 2707          	jreq	L5701
2580                     ; 886           uip_flags |= UIP_NEWDATA;
2582  088e 72120024      	bset	_uip_flags,#1
2583                     ; 887           uip_add_rcv_nxt(uip_len);
2585  0892 cd0222        	call	L733_uip_add_rcv_nxt
2587  0895               L5701:
2588                     ; 889         uip_slen = 0;
2591  0895 5f            	clrw	x
2592  0896 cf0014        	ldw	_uip_slen,x
2593                     ; 890         UIP_APPCALL();
2595                     ; 891         goto appsend;
2597  0899 cc033f        	jra	L304
2598  089c               L773:
2599                     ; 895     case UIP_ESTABLISHED:
2599                     ; 896       /* In the ESTABLISHED state, we call upon the application to feed data into the
2599                     ; 897          uip_buf. If the UIP_ACKDATA flag is set, the application should put new data
2599                     ; 898 	 into the buffer, otherwise we are retransmitting an old segment, and the
2599                     ; 899 	 application should put that data into the buffer.
2599                     ; 900 	 
2599                     ; 901 	 If the incoming packet is a FIN, we should close the connection on this side
2599                     ; 902 	 as well, and we send out a FIN and enter the LAST_ACK state. We require that
2599                     ; 903 	 there is no outstanding data; otherwise the sequence numbers will be screwed
2599                     ; 904 	 up. */
2599                     ; 905       if (BUF->flags & TCP_FIN && !(uip_connr->tcpstateflags & UIP_STOPPED)) {
2601  089c 720101a630    	btjf	_uip_buf+47,#0,L7701
2603  08a1 e619          	ld	a,(25,x)
2604  08a3 a510          	bcp	a,#16
2605  08a5 262a          	jrne	L7701
2606                     ; 906         if (uip_outstanding(uip_connr)) {
2608  08a7 e611          	ld	a,(17,x)
2609  08a9 ea10          	or	a,(16,x)
2610  08ab 26c8          	jrne	L734
2611                     ; 907           goto drop;
2613                     ; 909         uip_add_rcv_nxt(1 + uip_len);
2615  08ad ce0173        	ldw	x,_uip_len
2616  08b0 5c            	incw	x
2617  08b1 cd0222        	call	L733_uip_add_rcv_nxt
2619                     ; 910         uip_flags |= UIP_CLOSE;
2621  08b4 72180024      	bset	_uip_flags,#4
2622                     ; 911         if (uip_len > 0) {
2624  08b8 ce0173        	ldw	x,_uip_len
2625  08bb 2704          	jreq	L3011
2626                     ; 912           uip_flags |= UIP_NEWDATA;
2628  08bd 72120024      	bset	_uip_flags,#1
2629  08c1               L3011:
2630                     ; 914         UIP_APPCALL();
2632  08c1 cd0000        	call	_uip_TcpAppHubCall
2634                     ; 915         uip_connr->len = 1;
2636  08c4 1e04          	ldw	x,(OFST-1,sp)
2637  08c6 90ae0001      	ldw	y,#1
2638  08ca ef10          	ldw	(16,x),y
2639                     ; 916         uip_connr->tcpstateflags = UIP_LAST_ACK;
2641  08cc a608          	ld	a,#8
2642                     ; 917         uip_connr->nrtx = 0;
2643                     ; 918         tcp_send_finack: BUF->flags = TCP_FIN | TCP_ACK;
2644                     ; 919         goto tcp_send_nodata;
2646  08ce cc095e        	jp	LC005
2647  08d1               L7701:
2648                     ; 924       if ((BUF->flags & TCP_URG) != 0) {
2650  08d1 720b01a61f    	btjf	_uip_buf+47,#5,L5011
2651                     ; 925         uip_appdata = ((char *)uip_appdata) + ((BUF->urgp[0] << 8) | BUF->urgp[1]);
2653  08d6 c601ab        	ld	a,_uip_buf+52
2654  08d9 97            	ld	xl,a
2655  08da c601ac        	ld	a,_uip_buf+53
2656  08dd 02            	rlwa	x,a
2657  08de 72bb0175      	addw	x,_uip_appdata
2658  08e2 cf0175        	ldw	_uip_appdata,x
2659                     ; 926         uip_len -= (BUF->urgp[0] << 8) | BUF->urgp[1];
2661  08e5 c601ab        	ld	a,_uip_buf+52
2662  08e8 97            	ld	xl,a
2663  08e9 c601ac        	ld	a,_uip_buf+53
2664  08ec 02            	rlwa	x,a
2665  08ed 72b00173      	subw	x,_uip_len
2666  08f1 50            	negw	x
2667  08f2 cf0173        	ldw	_uip_len,x
2668  08f5               L5011:
2669                     ; 933       if (uip_len > 0 && !(uip_connr->tcpstateflags & UIP_STOPPED)) {
2671  08f5 ce0173        	ldw	x,_uip_len
2672  08f8 2712          	jreq	L7011
2674  08fa 1e04          	ldw	x,(OFST-1,sp)
2675  08fc e619          	ld	a,(25,x)
2676  08fe a510          	bcp	a,#16
2677  0900 260a          	jrne	L7011
2678                     ; 934         uip_flags |= UIP_NEWDATA;
2680  0902 72120024      	bset	_uip_flags,#1
2681                     ; 935         uip_add_rcv_nxt(uip_len);
2683  0906 ce0173        	ldw	x,_uip_len
2684  0909 cd0222        	call	L733_uip_add_rcv_nxt
2686  090c               L7011:
2687                     ; 947       tmp16 = ((uint16_t)BUF->wnd[0] << 8) + (uint16_t)BUF->wnd[1];
2689  090c c601a8        	ld	a,_uip_buf+49
2690  090f 5f            	clrw	x
2691  0910 97            	ld	xl,a
2692  0911 1f01          	ldw	(OFST-4,sp),x
2694  0913 c601a7        	ld	a,_uip_buf+48
2695  0916 97            	ld	xl,a
2696  0917 4f            	clr	a
2697  0918 02            	rlwa	x,a
2698  0919 72fb01        	addw	x,(OFST-4,sp)
2699  091c cf0000        	ldw	L54_tmp16,x
2700                     ; 948       if (tmp16 > uip_connr->initialmss || tmp16 == 0) {
2702  091f 1604          	ldw	y,(OFST-1,sp)
2703  0921 90ee14        	ldw	y,(20,y)
2704  0924 90c30000      	cpw	y,L54_tmp16
2705  0928 2505          	jrult	L3111
2707  092a ce0000        	ldw	x,L54_tmp16
2708  092d 2607          	jrne	L1111
2709  092f               L3111:
2710                     ; 949         tmp16 = uip_connr->initialmss;
2712  092f 1e04          	ldw	x,(OFST-1,sp)
2713  0931 ee14          	ldw	x,(20,x)
2714  0933 cf0000        	ldw	L54_tmp16,x
2715  0936               L1111:
2716                     ; 951       uip_connr->mss = tmp16;
2718  0936 1e04          	ldw	x,(OFST-1,sp)
2719  0938 90ce0000      	ldw	y,L54_tmp16
2720  093c ef12          	ldw	(18,x),y
2721                     ; 966       if (uip_flags & (UIP_NEWDATA | UIP_ACKDATA)) {
2723  093e c60024        	ld	a,_uip_flags
2724  0941 a503          	bcp	a,#3
2725  0943 2603cc0b33    	jreq	L734
2726                     ; 967         uip_slen = 0;
2727                     ; 968         UIP_APPCALL();
2729  0948 cc0895        	jp	L5701
2730  094b               L7111:
2731                     ; 979         if (uip_flags & UIP_CLOSE) {
2733  094b 720900241e    	btjf	_uip_flags,#4,L1211
2734                     ; 980           uip_slen = 0;
2736  0950 5f            	clrw	x
2737  0951 cf0014        	ldw	_uip_slen,x
2738                     ; 981 	  uip_connr->len = 1;
2740  0954 1e04          	ldw	x,(OFST-1,sp)
2741  0956 90ae0001      	ldw	y,#1
2742  095a ef10          	ldw	(16,x),y
2743                     ; 982 	  uip_connr->tcpstateflags = UIP_FIN_WAIT_1;
2745  095c a604          	ld	a,#4
2746                     ; 983 	  uip_connr->nrtx = 0;
2748  095e               LC005:
2749  095e e719          	ld	(25,x),a
2751  0960 6f1b          	clr	(27,x)
2752                     ; 984 	  BUF->flags = TCP_FIN | TCP_ACK;
2754  0962               LC003:
2756  0962 351101a6      	mov	_uip_buf+47,#17
2757                     ; 985 	  goto tcp_send_nodata;
2758  0966               L324:
2759                     ; 1111   tcp_send_nodata: uip_len = UIP_IPTCPH_LEN;
2761  0966 ae0028        	ldw	x,#40
2762  0969 cf0173        	ldw	_uip_len,x
2763  096c 206e          	jra	L524
2764  096e               L1211:
2765                     ; 989         if (uip_slen > 0) {
2767  096e ce0014        	ldw	x,_uip_slen
2768  0971 2732          	jreq	L3211
2769                     ; 992 	  if ((uip_flags & UIP_ACKDATA) != 0) {
2771  0973 7201002406    	btjf	_uip_flags,#0,L5211
2772                     ; 993 	    uip_connr->len = 0;
2774  0978 1e04          	ldw	x,(OFST-1,sp)
2775  097a 905f          	clrw	y
2776  097c ef10          	ldw	(16,x),y
2777  097e               L5211:
2778                     ; 998 	  if (uip_connr->len == 0) {
2780  097e 1e04          	ldw	x,(OFST-1,sp)
2781  0980 e611          	ld	a,(17,x)
2782  0982 ea10          	or	a,(16,x)
2783  0984 261a          	jrne	L7211
2784                     ; 1001 	    if (uip_slen > uip_connr->mss) {
2786  0986 9093          	ldw	y,x
2787  0988 90ee12        	ldw	y,(18,y)
2788  098b 90c30014      	cpw	y,_uip_slen
2789  098f 2407          	jruge	L1311
2790                     ; 1002 	      uip_slen = uip_connr->mss;
2792  0991 ee12          	ldw	x,(18,x)
2793  0993 cf0014        	ldw	_uip_slen,x
2794  0996 1e04          	ldw	x,(OFST-1,sp)
2795  0998               L1311:
2796                     ; 1007             uip_connr->len = uip_slen;
2798  0998 90ce0014      	ldw	y,_uip_slen
2799  099c ef10          	ldw	(16,x),y
2801  099e 2005          	jra	L3211
2802  09a0               L7211:
2803                     ; 1013 	    uip_slen = uip_connr->len;
2805  09a0 ee10          	ldw	x,(16,x)
2806  09a2 cf0014        	ldw	_uip_slen,x
2807  09a5               L3211:
2808                     ; 1016 	uip_connr->nrtx = 0;
2810  09a5 1e04          	ldw	x,(OFST-1,sp)
2811  09a7 6f1b          	clr	(27,x)
2812  09a9               L504:
2813                     ; 1017 	apprexmit: uip_appdata = uip_sappdata;
2815  09a9 ce0016        	ldw	x,_uip_sappdata
2816  09ac cf0175        	ldw	_uip_appdata,x
2817                     ; 1021 	if (uip_slen > 0 && uip_connr->len > 0) {
2819  09af ce0014        	ldw	x,_uip_slen
2820  09b2 2716          	jreq	L5311
2822  09b4 1e04          	ldw	x,(OFST-1,sp)
2823  09b6 e611          	ld	a,(17,x)
2824  09b8 ea10          	or	a,(16,x)
2825  09ba 270e          	jreq	L5311
2826                     ; 1023 	  uip_len = uip_connr->len + UIP_TCPIP_HLEN;
2828  09bc ee10          	ldw	x,(16,x)
2829  09be 1c0028        	addw	x,#40
2830  09c1 cf0173        	ldw	_uip_len,x
2831                     ; 1025 	  BUF->flags = TCP_ACK | TCP_PSH;
2833  09c4 351801a6      	mov	_uip_buf+47,#24
2834                     ; 1027 	  goto tcp_send_noopts;
2836  09c8 2012          	jra	L524
2837  09ca               L5311:
2838                     ; 1030 	if (uip_flags & UIP_NEWDATA) {
2840  09ca 7202002403cc  	btjf	_uip_flags,#1,L734
2841                     ; 1031 	  uip_len = UIP_TCPIP_HLEN;
2843  09d2 ae0028        	ldw	x,#40
2844  09d5 cf0173        	ldw	_uip_len,x
2845                     ; 1032 	  BUF->flags = TCP_ACK;
2847  09d8 351001a6      	mov	_uip_buf+47,#16
2848                     ; 1033 	  goto tcp_send_noopts;
2849  09dc               L524:
2850                     ; 1112   tcp_send_noopts: BUF->tcpoffset = (UIP_TCPH_LEN / 4) << 4;
2852  09dc 355001a5      	mov	_uip_buf+46,#80
2853  09e0               L724:
2854                     ; 1115   tcp_send:
2854                     ; 1116   /* We're done with the input processing. We are now ready to send a reply. Our job is to
2854                     ; 1117      fill in all the fields of the TCP and IP headers before calculating the checksum and
2854                     ; 1118      finally send the packet. */
2854                     ; 1119   BUF->ackno[0] = uip_connr->rcv_nxt[0];
2856  09e0 1e04          	ldw	x,(OFST-1,sp)
2857  09e2 e608          	ld	a,(8,x)
2858  09e4 c701a1        	ld	_uip_buf+42,a
2859                     ; 1120   BUF->ackno[1] = uip_connr->rcv_nxt[1];
2861  09e7 e609          	ld	a,(9,x)
2862  09e9 c701a2        	ld	_uip_buf+43,a
2863                     ; 1121   BUF->ackno[2] = uip_connr->rcv_nxt[2];
2865  09ec e60a          	ld	a,(10,x)
2866  09ee c701a3        	ld	_uip_buf+44,a
2867                     ; 1122   BUF->ackno[3] = uip_connr->rcv_nxt[3];
2869  09f1 e60b          	ld	a,(11,x)
2870  09f3 c701a4        	ld	_uip_buf+45,a
2871                     ; 1124   BUF->seqno[0] = uip_connr->snd_nxt[0];
2873  09f6 e60c          	ld	a,(12,x)
2874  09f8 c7019d        	ld	_uip_buf+38,a
2875                     ; 1125   BUF->seqno[1] = uip_connr->snd_nxt[1];
2877  09fb e60d          	ld	a,(13,x)
2878  09fd c7019e        	ld	_uip_buf+39,a
2879                     ; 1126   BUF->seqno[2] = uip_connr->snd_nxt[2];
2881  0a00 e60e          	ld	a,(14,x)
2882  0a02 c7019f        	ld	_uip_buf+40,a
2883                     ; 1127   BUF->seqno[3] = uip_connr->snd_nxt[3];
2885  0a05 e60f          	ld	a,(15,x)
2886  0a07 c701a0        	ld	_uip_buf+41,a
2887                     ; 1129   BUF->proto = UIP_PROTO_TCP;
2889  0a0a 3506018e      	mov	_uip_buf+23,#6
2890                     ; 1131   BUF->srcport = uip_connr->lport;
2892  0a0e ee04          	ldw	x,(4,x)
2893  0a10 cf0199        	ldw	_uip_buf+34,x
2894                     ; 1132   BUF->destport = uip_connr->rport;
2896  0a13 1e04          	ldw	x,(OFST-1,sp)
2897  0a15 ee06          	ldw	x,(6,x)
2898  0a17 cf019b        	ldw	_uip_buf+36,x
2899                     ; 1134   uip_ipaddr_copy(BUF->srcipaddr, uip_hostaddr);
2901  0a1a ce0020        	ldw	x,_uip_hostaddr
2902  0a1d cf0191        	ldw	_uip_buf+26,x
2905  0a20 ce0022        	ldw	x,_uip_hostaddr+2
2906  0a23 cf0193        	ldw	_uip_buf+28,x
2907                     ; 1135   uip_ipaddr_copy(BUF->destipaddr, uip_connr->ripaddr);
2909  0a26 1e04          	ldw	x,(OFST-1,sp)
2910  0a28 fe            	ldw	x,(x)
2911  0a29 cf0195        	ldw	_uip_buf+30,x
2914  0a2c 1e04          	ldw	x,(OFST-1,sp)
2915  0a2e ee02          	ldw	x,(2,x)
2916  0a30 cf0197        	ldw	_uip_buf+32,x
2917                     ; 1137   if (uip_connr->tcpstateflags & UIP_STOPPED) {
2919  0a33 1e04          	ldw	x,(OFST-1,sp)
2920  0a35 e619          	ld	a,(25,x)
2921  0a37 a510          	bcp	a,#16
2922  0a39 2603cc0ad8    	jreq	L1021
2923                     ; 1140     BUF->wnd[0] = BUF->wnd[1] = 0;
2925  0a3e 725f01a8      	clr	_uip_buf+49
2926  0a42 725f01a7      	clr	_uip_buf+48
2928  0a46 cc0ae0        	jra	L134
2929  0a49               L704:
2930                     ; 1038     case UIP_LAST_ACK:
2930                     ; 1039       /* We can close this connection if the peer has acknowledged our FIN. This is
2930                     ; 1040          indicated by the UIP_ACKDATA flag. */
2930                     ; 1041       if (uip_flags & UIP_ACKDATA) {
2932  0a49 7201002481    	btjf	_uip_flags,#0,L734
2933                     ; 1042         uip_connr->tcpstateflags = UIP_CLOSED;
2935  0a4e e719          	ld	(25,x),a
2936                     ; 1043 	uip_flags = UIP_CLOSE;
2938  0a50 35100024      	mov	_uip_flags,#16
2939                     ; 1044 	UIP_APPCALL();
2941  0a54 cd0000        	call	_uip_TcpAppHubCall
2943  0a57 cc0b33        	jra	L734
2944  0a5a               L114:
2945                     ; 1048     case UIP_FIN_WAIT_1:
2945                     ; 1049       /* The application has closed the connection, but the remote host hasn't closed
2945                     ; 1050          its end yet. Thus we do nothing but wait for a FIN from the other side. */
2945                     ; 1051       if (uip_len > 0) {
2947  0a5a ce0173        	ldw	x,_uip_len
2948  0a5d 2703          	jreq	L3411
2949                     ; 1052         uip_add_rcv_nxt(uip_len);
2951  0a5f cd0222        	call	L733_uip_add_rcv_nxt
2953  0a62               L3411:
2954                     ; 1054       if (BUF->flags & TCP_FIN) {
2956  0a62 720101a619    	btjf	_uip_buf+47,#0,L5411
2957                     ; 1055         if (uip_flags & UIP_ACKDATA) {
2959  0a67 1e04          	ldw	x,(OFST-1,sp)
2960  0a69 720100240c    	btjf	_uip_flags,#0,L7411
2961                     ; 1056 	  uip_connr->tcpstateflags = UIP_TIME_WAIT;
2963  0a6e a607          	ld	a,#7
2964  0a70 e719          	ld	(25,x),a
2965                     ; 1057 	  uip_connr->timer = 0;
2967  0a72 6f1a          	clr	(26,x)
2968                     ; 1058 	  uip_connr->len = 0;
2970  0a74 905f          	clrw	y
2971  0a76 ef10          	ldw	(16,x),y
2973  0a78 2034          	jra	LC004
2974  0a7a               L7411:
2975                     ; 1061           uip_connr->tcpstateflags = UIP_CLOSING;
2977  0a7a a606          	ld	a,#6
2978  0a7c e719          	ld	(25,x),a
2979                     ; 1063         uip_add_rcv_nxt(1);
2981                     ; 1064         uip_flags = UIP_CLOSE;
2982                     ; 1065         UIP_APPCALL();
2984                     ; 1066         goto tcp_send_ack;
2986  0a7e 202e          	jp	LC004
2987  0a80               L5411:
2988                     ; 1068       else if (uip_flags & UIP_ACKDATA) {
2990  0a80 720100240d    	btjf	_uip_flags,#0,L3511
2991                     ; 1069         uip_connr->tcpstateflags = UIP_FIN_WAIT_2;
2993  0a85 1e04          	ldw	x,(OFST-1,sp)
2994  0a87 a605          	ld	a,#5
2995  0a89 e719          	ld	(25,x),a
2996                     ; 1070         uip_connr->len = 0;
2998  0a8b 905f          	clrw	y
2999  0a8d ef10          	ldw	(16,x),y
3000                     ; 1071         goto drop;
3002  0a8f cc0b33        	jra	L734
3003  0a92               L3511:
3004                     ; 1073       if (uip_len > 0) {
3006  0a92 ce0173        	ldw	x,_uip_len
3007  0a95 27f8          	jreq	L734
3008                     ; 1074         goto tcp_send_ack;
3010  0a97 2038          	jra	L124
3011  0a99               L314:
3012                     ; 1078     case UIP_FIN_WAIT_2:
3012                     ; 1079       if (uip_len > 0) {
3014  0a99 ce0173        	ldw	x,_uip_len
3015  0a9c 2703          	jreq	L1611
3016                     ; 1080 	uip_add_rcv_nxt(uip_len);
3018  0a9e cd0222        	call	L733_uip_add_rcv_nxt
3020  0aa1               L1611:
3021                     ; 1082       if (BUF->flags & TCP_FIN) {
3023  0aa1 720101a617    	btjf	_uip_buf+47,#0,L3611
3024                     ; 1083 	uip_connr->tcpstateflags = UIP_TIME_WAIT;
3026  0aa6 1e04          	ldw	x,(OFST-1,sp)
3027  0aa8 a607          	ld	a,#7
3028  0aaa e719          	ld	(25,x),a
3029                     ; 1084 	uip_connr->timer = 0;
3031  0aac 6f1a          	clr	(26,x)
3032                     ; 1085 	uip_add_rcv_nxt(1);
3035                     ; 1086 	uip_flags = UIP_CLOSE;
3037                     ; 1087 	UIP_APPCALL();
3039  0aae               LC004:
3041  0aae ae0001        	ldw	x,#1
3042  0ab1 cd0222        	call	L733_uip_add_rcv_nxt
3044  0ab4 35100024      	mov	_uip_flags,#16
3046  0ab8 cd0000        	call	_uip_TcpAppHubCall
3048                     ; 1088 	goto tcp_send_ack;
3050  0abb 2014          	jra	L124
3051  0abd               L3611:
3052                     ; 1090       if (uip_len > 0) {
3054  0abd ce0173        	ldw	x,_uip_len
3055  0ac0 2771          	jreq	L734
3056                     ; 1091 	goto tcp_send_ack;
3058  0ac2 200d          	jra	L124
3059  0ac4               L714:
3060                     ; 1098     case UIP_CLOSING:
3060                     ; 1099       if (uip_flags & UIP_ACKDATA) {
3062  0ac4 720100246a    	btjf	_uip_flags,#0,L734
3063                     ; 1100 	uip_connr->tcpstateflags = UIP_TIME_WAIT;
3065  0ac9 a607          	ld	a,#7
3066  0acb e719          	ld	(25,x),a
3067                     ; 1101 	uip_connr->timer = 0;
3069  0acd 6f1a          	clr	(26,x)
3070  0acf 2062          	jra	L734
3071                     ; 1104   goto drop;
3073  0ad1               L124:
3074                     ; 1109   tcp_send_ack:
3074                     ; 1110   BUF->flags = TCP_ACK;
3076  0ad1 351001a6      	mov	_uip_buf+47,#16
3077  0ad5 cc0966        	jra	L324
3078  0ad8               L1021:
3079                     ; 1143     BUF->wnd[0] = ((UIP_RECEIVE_WINDOW) >> 8);
3081  0ad8 350301a7      	mov	_uip_buf+48,#3
3082                     ; 1144     BUF->wnd[1] = ((UIP_RECEIVE_WINDOW) & 0xff);
3084  0adc 354e01a8      	mov	_uip_buf+49,#78
3085  0ae0               L134:
3086                     ; 1148   tcp_send_noconn:
3086                     ; 1149   BUF->ttl = UIP_TTL;
3088  0ae0 3540018d      	mov	_uip_buf+22,#64
3089                     ; 1150   BUF->len[0] = (uint8_t)(uip_len >> 8);
3091  0ae4 5501730187    	mov	_uip_buf+16,_uip_len
3092                     ; 1151   BUF->len[1] = (uint8_t)(uip_len & 0xff);
3094  0ae9 5501740188    	mov	_uip_buf+17,_uip_len+1
3095                     ; 1153   BUF->urgp[0] = BUF->urgp[1] = 0;
3097  0aee 725f01ac      	clr	_uip_buf+53
3098  0af2 725f01ab      	clr	_uip_buf+52
3099                     ; 1156   BUF->tcpchksum = 0;
3101  0af6 5f            	clrw	x
3102  0af7 cf01a9        	ldw	_uip_buf+50,x
3103                     ; 1157   BUF->tcpchksum = ~(uip_tcpchksum());
3105  0afa cd0120        	call	_uip_tcpchksum
3107  0afd 53            	cplw	x
3108  0afe cf01a9        	ldw	_uip_buf+50,x
3109                     ; 1160   ip_send_nolen:
3109                     ; 1161 
3109                     ; 1162   BUF->vhl = 0x45;
3111  0b01 35450185      	mov	_uip_buf+14,#69
3112                     ; 1163   BUF->tos = 0;
3114  0b05 725f0186      	clr	_uip_buf+15
3115                     ; 1164   BUF->ipoffset[0] = BUF->ipoffset[1] = 0;
3117  0b09 725f018c      	clr	_uip_buf+21
3118  0b0d 725f018b      	clr	_uip_buf+20
3119                     ; 1165   ++ipid;
3121  0b11 ce0008        	ldw	x,L31_ipid
3122  0b14 5c            	incw	x
3123  0b15 cf0008        	ldw	L31_ipid,x
3124                     ; 1166   BUF->ipid[0] = (uint8_t)(ipid >> 8);
3126  0b18 5500080189    	mov	_uip_buf+18,L31_ipid
3127                     ; 1167   BUF->ipid[1] = (uint8_t)(ipid & 0xff);
3129  0b1d 550009018a    	mov	_uip_buf+19,L31_ipid+1
3130                     ; 1169   BUF->ipchksum = 0;
3132  0b22 5f            	clrw	x
3133  0b23 cf018f        	ldw	_uip_buf+24,x
3134                     ; 1170   BUF->ipchksum = ~(uip_ipchksum());
3136  0b26 cd00bb        	call	_uip_ipchksum
3138  0b29 53            	cplw	x
3139  0b2a cf018f        	ldw	_uip_buf+24,x
3140                     ; 1172   UIP_STAT(++uip_stat.tcp.sent);
3142  0b2d ae0061        	ldw	x,#_uip_stat+60
3144  0b30 cc0487        	jra	L534
3145  0b33               L734:
3146                     ; 1183   drop:
3146                     ; 1184   uip_len = 0;
3148  0b33 5f            	clrw	x
3149  0b34 cf0173        	ldw	_uip_len,x
3150                     ; 1185   uip_flags = 0;
3152                     ; 1186   return;
3153  0b37               L202:
3155  0b37 725f0024      	clr	_uip_flags
3158  0b3b 5b06          	addw	sp,#6
3159  0b3d 81            	ret	
3191                     ; 1191 uint16_t htons(uint16_t val)
3191                     ; 1192 {
3192                     	switch	.text
3193  0b3e               _htons:
3197                     ; 1193   return HTONS(val);
3201  0b3e 81            	ret	
3246                     ; 1199 void uip_send(const char *data, int len)
3246                     ; 1200 {
3247                     	switch	.text
3248  0b3f               _uip_send:
3250  0b3f 89            	pushw	x
3251       00000000      OFST:	set	0
3254                     ; 1201   if (len > 0) {
3256  0b40 9c            	rvf	
3257  0b41 1e05          	ldw	x,(OFST+5,sp)
3258  0b43 2d1c          	jrsle	L012
3259                     ; 1202     uip_slen = len;
3261  0b45 cf0014        	ldw	_uip_slen,x
3262                     ; 1203     if (data != uip_sappdata) {
3264  0b48 1e01          	ldw	x,(OFST+1,sp)
3265  0b4a c30016        	cpw	x,_uip_sappdata
3266  0b4d 2712          	jreq	L012
3267                     ; 1204       memcpy(uip_sappdata, (data), uip_slen);
3269  0b4f bf00          	ldw	c_x,x
3270  0b51 ce0014        	ldw	x,_uip_slen
3271  0b54 270b          	jreq	L012
3272  0b56               L212:
3273  0b56 5a            	decw	x
3274  0b57 92d600        	ld	a,([c_x.w],x)
3275  0b5a 72d70016      	ld	([_uip_sappdata.w],x),a
3276  0b5e 5d            	tnzw	x
3277  0b5f 26f5          	jrne	L212
3278  0b61               L012:
3279                     ; 1207 }
3282  0b61 85            	popw	x
3283  0b62 81            	ret	
3710                     	switch	.bss
3711  0000               L54_tmp16:
3712  0000 0000          	ds.b	2
3713  0002               L34_opt:
3714  0002 00            	ds.b	1
3715  0003               L14_c:
3716  0003 00            	ds.b	1
3717  0004               L73_iss:
3718  0004 00000000      	ds.b	4
3719  0008               L31_ipid:
3720  0008 0000          	ds.b	2
3721  000a               _uip_listenports:
3722  000a 000000000000  	ds.b	10
3723                     	xdef	_uip_listenports
3724  0014               _uip_slen:
3725  0014 0000          	ds.b	2
3726                     	xdef	_uip_slen
3727  0016               _uip_sappdata:
3728  0016 0000          	ds.b	2
3729                     	xdef	_uip_sappdata
3730                     	xdef	_uip_ethaddr
3731                     	xdef	_uip_add32
3732                     	xdef	_uip_tcpchksum
3733                     	xdef	_uip_ipchksum
3734                     	xdef	_uip_chksum
3735  0018               _uip_draddr:
3736  0018 00000000      	ds.b	4
3737                     	xdef	_uip_draddr
3738  001c               _uip_netmask:
3739  001c 00000000      	ds.b	4
3740                     	xdef	_uip_netmask
3741  0020               _uip_hostaddr:
3742  0020 00000000      	ds.b	4
3743                     	xdef	_uip_hostaddr
3744                     	xdef	_uip_process
3745  0024               _uip_flags:
3746  0024 00            	ds.b	1
3747                     	xdef	_uip_flags
3748  0025               _uip_stat:
3749  0025 000000000000  	ds.b	88
3750                     	xdef	_uip_stat
3751  007d               _uip_acc32:
3752  007d 00000000      	ds.b	4
3753                     	xdef	_uip_acc32
3754  0081               _uip_conns:
3755  0081 000000000000  	ds.b	240
3756                     	xdef	_uip_conns
3757  0171               _uip_conn:
3758  0171 0000          	ds.b	2
3759                     	xdef	_uip_conn
3760  0173               _uip_len:
3761  0173 0000          	ds.b	2
3762                     	xdef	_uip_len
3763  0175               _uip_appdata:
3764  0175 0000          	ds.b	2
3765                     	xdef	_uip_appdata
3766                     	xdef	_htons
3767                     	xdef	_uip_send
3768                     	xdef	_uip_unlisten
3769                     	xdef	_uip_listen
3770  0177               _uip_buf:
3771  0177 000000000000  	ds.b	902
3772                     	xdef	_uip_buf
3773                     	xdef	_uip_setipid
3774                     	xdef	_uip_init
3775                     	xref	_uip_TcpAppHubCall
3776                     	xref.b	c_x
3777                     	xref.b	c_y
3797                     	xref	c_lgadc
3798                     	end
