   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Parser V4.11.14 - 18 Nov 2019
   3                     ; Generator (Limited) V4.4.11 - 19 Nov 2019
   4                     ; Optimizer V4.4.11 - 19 Nov 2019
2546                     ; 251 void select(void)
2546                     ; 252 {
2548                     	switch	.text
2549  0000               _select:
2553                     ; 254   PC_ODR &= (uint8_t)(~0x02);
2555  0000 7213500a      	bres	_PC_ODR,#1
2556                     ; 255   nop();
2559  0004 9d            	nop	
2561                     ; 256 }
2565  0005 81            	ret	
2590                     ; 259 void deselect(void)
2590                     ; 260 {
2591                     	switch	.text
2592  0006               _deselect:
2596                     ; 262   PC_ODR |= (uint8_t)0x02;
2598  0006 7212500a      	bset	_PC_ODR,#1
2599                     ; 263   nop();
2602  000a 9d            	nop	
2604                     ; 264 }
2608  000b 81            	ret	
2651                     ; 269 uint8_t Enc28j60ReadReg(uint8_t nRegister)
2651                     ; 270 {
2652                     	switch	.text
2653  000c               _Enc28j60ReadReg:
2655  000c 88            	push	a
2656  000d 88            	push	a
2657       00000001      OFST:	set	1
2660                     ; 273 	select();
2662  000e adf0          	call	_select
2664                     ; 275 	SpiWriteByte((uint8_t)(OPCODE_RCR | (nRegister & REGISTER_MASK)));
2666  0010 7b02          	ld	a,(OFST+1,sp)
2667  0012 a41f          	and	a,#31
2668  0014 cd0000        	call	_SpiWriteByte
2670                     ; 276 	if (nRegister & REGISTER_NEEDDUMMY) SpiWriteByte(0);
2672  0017 7b02          	ld	a,(OFST+1,sp)
2673  0019 2a04          	jrpl	L3661
2676  001b 4f            	clr	a
2677  001c cd0000        	call	_SpiWriteByte
2679  001f               L3661:
2680                     ; 277 	nByte = SpiReadByte();
2682  001f cd0000        	call	_SpiReadByte
2684  0022 6b01          	ld	(OFST+0,sp),a
2686                     ; 279 	deselect();
2688  0024 ade0          	call	_deselect
2690                     ; 281 	return nByte;
2692  0026 7b01          	ld	a,(OFST+0,sp)
2695  0028 85            	popw	x
2696  0029 81            	ret	
2738                     ; 287 void Enc28j60WriteReg( uint8_t nRegister, uint8_t nData)
2738                     ; 288 {
2739                     	switch	.text
2740  002a               _Enc28j60WriteReg:
2742  002a 89            	pushw	x
2743       00000000      OFST:	set	0
2746                     ; 289 	select();
2748  002b add3          	call	_select
2750                     ; 291 	SpiWriteByte((uint8_t)(OPCODE_WCR | (nRegister & REGISTER_MASK)));
2752  002d 7b01          	ld	a,(OFST+1,sp)
2753  002f a41f          	and	a,#31
2754  0031 aa40          	or	a,#64
2755  0033 cd0000        	call	_SpiWriteByte
2757                     ; 292 	SpiWriteByte(nData);
2759  0036 7b02          	ld	a,(OFST+2,sp)
2760  0038 cd0000        	call	_SpiWriteByte
2762                     ; 294 	deselect();
2764  003b adc9          	call	_deselect
2766                     ; 295 }
2769  003d 85            	popw	x
2770  003e 81            	ret	
2812                     ; 300 void Enc28j60SetMaskReg(uint8_t nRegister, uint8_t nMask)
2812                     ; 301 {
2813                     	switch	.text
2814  003f               _Enc28j60SetMaskReg:
2816  003f 89            	pushw	x
2817       00000000      OFST:	set	0
2820                     ; 302 	select();
2822  0040 adbe          	call	_select
2824                     ; 304 	SpiWriteByte((uint8_t)(OPCODE_BFS | (nRegister & REGISTER_MASK)));
2826  0042 7b01          	ld	a,(OFST+1,sp)
2827  0044 a41f          	and	a,#31
2828  0046 aa80          	or	a,#128
2829  0048 cd0000        	call	_SpiWriteByte
2831                     ; 305 	SpiWriteByte(nMask);
2833  004b 7b02          	ld	a,(OFST+2,sp)
2834  004d cd0000        	call	_SpiWriteByte
2836                     ; 307 	deselect();
2838  0050 adb4          	call	_deselect
2840                     ; 308 }
2843  0052 85            	popw	x
2844  0053 81            	ret	
2887                     ; 313 void Enc28j60ClearMaskReg( uint8_t nRegister, uint8_t nMask)
2887                     ; 314 {
2888                     	switch	.text
2889  0054               _Enc28j60ClearMaskReg:
2891  0054 89            	pushw	x
2892       00000000      OFST:	set	0
2895                     ; 315 	select();
2897  0055 ada9          	call	_select
2899                     ; 317 	SpiWriteByte((uint8_t)(OPCODE_BFC | (nRegister & REGISTER_MASK)));
2901  0057 7b01          	ld	a,(OFST+1,sp)
2902  0059 a41f          	and	a,#31
2903  005b aaa0          	or	a,#160
2904  005d cd0000        	call	_SpiWriteByte
2906                     ; 318 	SpiWriteByte(nMask);
2908  0060 7b02          	ld	a,(OFST+2,sp)
2909  0062 cd0000        	call	_SpiWriteByte
2911                     ; 320 	deselect();
2913  0065 ad9f          	call	_deselect
2915                     ; 321 }
2918  0067 85            	popw	x
2919  0068 81            	ret	
2953                     ; 326 void Enc28j60SwitchBank(uint8_t nBank)
2953                     ; 327 {
2954                     	switch	.text
2955  0069               _Enc28j60SwitchBank:
2957  0069 88            	push	a
2958       00000000      OFST:	set	0
2961                     ; 331 	Enc28j60ClearMaskReg(BANKX_ECON1, (3<<BANKX_ECON1_BSEL0));
2963  006a ae1f03        	ldw	x,#7939
2964  006d ade5          	call	_Enc28j60ClearMaskReg
2966                     ; 332 	Enc28j60SetMaskReg(BANKX_ECON1, (uint8_t)(nBank << BANKX_ECON1_BSEL0));
2968  006f 7b01          	ld	a,(OFST+1,sp)
2969  0071 ae1f00        	ldw	x,#7936
2970  0074 97            	ld	xl,a
2971  0075 adc8          	call	_Enc28j60SetMaskReg
2973                     ; 333 }
2976  0077 84            	pop	a
2977  0078 81            	ret	
3015                     ; 339 uint16_t Enc28j60ReadPhy(uint8_t nRegister)
3015                     ; 340 {
3016                     	switch	.text
3017  0079               _Enc28j60ReadPhy:
3019  0079 88            	push	a
3020  007a 89            	pushw	x
3021       00000002      OFST:	set	2
3024                     ; 341 	Enc28j60SwitchBank(BANK2);
3026  007b a602          	ld	a,#2
3027  007d adea          	call	_Enc28j60SwitchBank
3029                     ; 342 	Enc28j60WriteReg(BANK2_MIREGADR, nRegister);
3031  007f 7b03          	ld	a,(OFST+1,sp)
3032  0081 ae9400        	ldw	x,#37888
3033  0084 97            	ld	xl,a
3034  0085 ada3          	call	_Enc28j60WriteReg
3036                     ; 343 	Enc28j60SetMaskReg(BANK2_MICMD, (1<<BANK2_MICMD_MIIRD));
3038  0087 ae9201        	ldw	x,#37377
3039  008a adb3          	call	_Enc28j60SetMaskReg
3041                     ; 344 	Enc28j60SwitchBank(BANK3);
3043  008c a603          	ld	a,#3
3044  008e add9          	call	_Enc28j60SwitchBank
3047  0090 2001          	jra	L1771
3048  0092               L7671:
3049                     ; 345 	while (Enc28j60ReadReg(BANK3_MISTAT) & (1 <<BANK3_MISTAT_BUSY)) nop();
3052  0092 9d            	nop	
3054  0093               L1771:
3057  0093 a68a          	ld	a,#138
3058  0095 cd000c        	call	_Enc28j60ReadReg
3060  0098 a501          	bcp	a,#1
3061  009a 26f6          	jrne	L7671
3062                     ; 346 	Enc28j60SwitchBank(BANK2);
3065  009c a602          	ld	a,#2
3066  009e adc9          	call	_Enc28j60SwitchBank
3068                     ; 347 	Enc28j60ClearMaskReg(BANK2_MICMD, (1<<BANK2_MICMD_MIIRD));
3070  00a0 ae9201        	ldw	x,#37377
3071  00a3 adaf          	call	_Enc28j60ClearMaskReg
3073                     ; 349 	return ((uint16_t) Enc28j60ReadReg(BANK2_MIRDL) << 0)
3073                     ; 350 	| ((uint16_t) Enc28j60ReadReg(BANK2_MIRDH) << 8);
3075  00a5 a699          	ld	a,#153
3076  00a7 cd000c        	call	_Enc28j60ReadReg
3078  00aa 97            	ld	xl,a
3079  00ab 4f            	clr	a
3080  00ac 02            	rlwa	x,a
3081  00ad 1f01          	ldw	(OFST-1,sp),x
3083  00af a698          	ld	a,#152
3084  00b1 cd000c        	call	_Enc28j60ReadReg
3086  00b4 5f            	clrw	x
3087  00b5 97            	ld	xl,a
3088  00b6 01            	rrwa	x,a
3089  00b7 1a02          	or	a,(OFST+0,sp)
3090  00b9 01            	rrwa	x,a
3091  00ba 1a01          	or	a,(OFST-1,sp)
3092  00bc 01            	rrwa	x,a
3095  00bd 5b03          	addw	sp,#3
3096  00bf 81            	ret	
3139                     ; 357 void Enc28j60WritePhy( uint8_t nRegister, uint16_t nData)
3139                     ; 358 {
3140                     	switch	.text
3141  00c0               _Enc28j60WritePhy:
3143  00c0 88            	push	a
3144       00000000      OFST:	set	0
3147                     ; 359 	Enc28j60SwitchBank(BANK2);
3149  00c1 a602          	ld	a,#2
3150  00c3 ada4          	call	_Enc28j60SwitchBank
3152                     ; 360 	Enc28j60WriteReg(BANK2_MIREGADR, nRegister);
3154  00c5 7b01          	ld	a,(OFST+1,sp)
3155  00c7 ae9400        	ldw	x,#37888
3156  00ca 97            	ld	xl,a
3157  00cb cd002a        	call	_Enc28j60WriteReg
3159                     ; 361 	Enc28j60WriteReg(BANK2_MIWRL, (uint8_t)(nData >> 0));
3161  00ce 7b05          	ld	a,(OFST+5,sp)
3162  00d0 ae9600        	ldw	x,#38400
3163  00d3 97            	ld	xl,a
3164  00d4 cd002a        	call	_Enc28j60WriteReg
3166                     ; 362 	Enc28j60WriteReg(BANK2_MIWRH, (uint8_t)(nData >> 8));
3168  00d7 7b04          	ld	a,(OFST+4,sp)
3169  00d9 ae9700        	ldw	x,#38656
3170  00dc 97            	ld	xl,a
3171  00dd cd002a        	call	_Enc28j60WriteReg
3173                     ; 363 	Enc28j60SwitchBank(BANK3);
3175  00e0 a603          	ld	a,#3
3176  00e2 ad85          	call	_Enc28j60SwitchBank
3179  00e4 2001          	jra	L5102
3180  00e6               L3102:
3181                     ; 364 	while (Enc28j60ReadReg(BANK3_MISTAT) & (1 <<BANK3_MISTAT_BUSY)) nop();
3184  00e6 9d            	nop	
3186  00e7               L5102:
3189  00e7 a68a          	ld	a,#138
3190  00e9 cd000c        	call	_Enc28j60ReadReg
3192  00ec a501          	bcp	a,#1
3193  00ee 26f6          	jrne	L3102
3194                     ; 365 }
3198  00f0 84            	pop	a
3199  00f1 81            	ret	
3240                     ; 368 void Enc28j60Init(void)
3240                     ; 369 {
3241                     	switch	.text
3242  00f2               _Enc28j60Init:
3246                     ; 373 	deselect(); // Just makes sure the -CS is not selected
3248  00f2 cd0006        	call	_deselect
3251  00f5 2001          	jra	L3302
3252  00f7               L1302:
3253                     ; 387 	while (!(Enc28j60ReadReg(BANKX_ESTAT) & (1<<BANKX_ESTAT_CLKRDY))) nop();
3256  00f7 9d            	nop	
3258  00f8               L3302:
3261  00f8 a61d          	ld	a,#29
3262  00fa cd000c        	call	_Enc28j60ReadReg
3264  00fd a501          	bcp	a,#1
3265  00ff 27f6          	jreq	L1302
3266                     ; 390 	select();
3269  0101 cd0000        	call	_select
3271                     ; 391 	SpiWriteByte(OPCODE_SRC); // Reset command
3273  0104 a6ff          	ld	a,#255
3274  0106 cd0000        	call	_SpiWriteByte
3276                     ; 392 	deselect();
3278  0109 cd0006        	call	_deselect
3280                     ; 393 	wait_timer((uint16_t)10000); // delay 10 ms
3282  010c ae2710        	ldw	x,#10000
3283  010f cd0000        	call	_wait_timer
3285                     ; 396 	Enc28j60WritePhy(PHY_PHCON1, (uint16_t)(1<<PHY_PHCON1_PRST)); // Reset command
3287  0112 ae8000        	ldw	x,#32768
3288  0115 89            	pushw	x
3289  0116 4f            	clr	a
3290  0117 ada7          	call	_Enc28j60WritePhy
3292  0119 85            	popw	x
3294  011a 2001          	jra	L1402
3295  011c               L7302:
3296                     ; 397 	while (Enc28j60ReadPhy(PHY_PHCON1) & (uint16_t)(1<<PHY_PHCON1_PRST)) nop(); // Wait for PHY reset completion
3299  011c 9d            	nop	
3301  011d               L1402:
3304  011d 4f            	clr	a
3305  011e cd0079        	call	_Enc28j60ReadPhy
3307  0121 01            	rrwa	x,a
3308  0122 9f            	ld	a,xl
3309  0123 a480          	and	a,#128
3310  0125 97            	ld	xl,a
3311  0126 4f            	clr	a
3312  0127 02            	rlwa	x,a
3313  0128 5d            	tnzw	x
3314  0129 26f1          	jrne	L7302
3315                     ; 400 	Enc28j60SwitchBank(BANK0);
3318  012b 4f            	clr	a
3319  012c cd0069        	call	_Enc28j60SwitchBank
3321                     ; 403 	Enc28j60WriteReg(BANK0_ERXSTL, (uint8_t) (ENC28J60_RXSTART >> 0));
3323  012f ae0800        	ldw	x,#2048
3324  0132 cd002a        	call	_Enc28j60WriteReg
3326                     ; 404 	Enc28j60WriteReg(BANK0_ERXSTH, (uint8_t) (ENC28J60_RXSTART >> 8));
3328  0135 ae0900        	ldw	x,#2304
3329  0138 cd002a        	call	_Enc28j60WriteReg
3331                     ; 405 	Enc28j60WriteReg(BANK0_ERXNDL, (uint8_t) (ENC28J60_RXEND >> 0));
3333  013b ae0aff        	ldw	x,#2815
3334  013e cd002a        	call	_Enc28j60WriteReg
3336                     ; 406 	Enc28j60WriteReg(BANK0_ERXNDH, (uint8_t) (ENC28J60_RXEND >> 8));
3338  0141 ae0b17        	ldw	x,#2839
3339  0144 cd002a        	call	_Enc28j60WriteReg
3341                     ; 408 	Enc28j60WriteReg(BANK0_ERDPTL, (uint8_t) (ENC28J60_RXSTART >> 0));
3343  0147 5f            	clrw	x
3344  0148 cd002a        	call	_Enc28j60WriteReg
3346                     ; 409 	Enc28j60WriteReg(BANK0_ERDPTH, (uint8_t) (ENC28J60_RXSTART >> 8));
3348  014b ae0100        	ldw	x,#256
3349  014e cd002a        	call	_Enc28j60WriteReg
3351                     ; 412 	Enc28j60WriteReg(BANK0_ERXRDPTL, (uint8_t) (ENC28J60_RXEND >> 0));
3353  0151 ae0cff        	ldw	x,#3327
3354  0154 cd002a        	call	_Enc28j60WriteReg
3356                     ; 413 	Enc28j60WriteReg(BANK0_ERXRDPTH, (uint8_t) (ENC28J60_RXEND >> 8));
3358  0157 ae0d17        	ldw	x,#3351
3359  015a cd002a        	call	_Enc28j60WriteReg
3361                     ; 415 	Enc28j60WriteReg(BANK0_ETXSTL, (uint8_t) (ENC28J60_TXSTART >> 0));
3363  015d ae0400        	ldw	x,#1024
3364  0160 cd002a        	call	_Enc28j60WriteReg
3366                     ; 416 	Enc28j60WriteReg(BANK0_ETXSTH, (uint8_t) (ENC28J60_TXSTART >> 8));
3368  0163 ae0518        	ldw	x,#1304
3369  0166 cd002a        	call	_Enc28j60WriteReg
3371                     ; 419 	Enc28j60SwitchBank(BANK1);
3373  0169 a601          	ld	a,#1
3374  016b cd0069        	call	_Enc28j60SwitchBank
3376                     ; 466 	Enc28j60WriteReg(BANK1_ERXFCON, (uint8_t)0xa1);    // Allows packets if MAC matches
3378  016e ae18a1        	ldw	x,#6305
3379  0171 cd002a        	call	_Enc28j60WriteReg
3381                     ; 483 	Enc28j60SwitchBank(BANK2);
3383  0174 a602          	ld	a,#2
3384  0176 cd0069        	call	_Enc28j60SwitchBank
3386                     ; 486 	Enc28j60WriteReg(BANK2_MACON1, (1<<BANK2_MACON1_MARXEN));
3388  0179 ae8001        	ldw	x,#32769
3389  017c cd002a        	call	_Enc28j60WriteReg
3391                     ; 502 	Enc28j60SetMaskReg(BANK2_MACON3, (1<<BANK2_MACON3_TXCRCEN)|(1<<BANK2_MACON3_PADCFG0)|(1<<BANK2_MACON3_FRMLNEN));
3393  017f ae8232        	ldw	x,#33330
3394  0182 cd003f        	call	_Enc28j60SetMaskReg
3396                     ; 505 	Enc28j60SetMaskReg(BANK2_MACON4, (1<<BANK2_MACON4_DEFER));
3398  0185 ae8340        	ldw	x,#33600
3399  0188 cd003f        	call	_Enc28j60SetMaskReg
3401                     ; 509 	Enc28j60WriteReg(BANK2_MAMXFLL, (uint8_t) ((ENC28J60_MAXFRAME + 4) >> 0));
3403  018b ae8a5c        	ldw	x,#35420
3404  018e cd002a        	call	_Enc28j60WriteReg
3406                     ; 510 	Enc28j60WriteReg(BANK2_MAMXFLH, (uint8_t) ((ENC28J60_MAXFRAME + 4) >> 8));
3408  0191 ae9002        	ldw	x,#36866
3409  0194 cd002a        	call	_Enc28j60WriteReg
3411                     ; 513 	Enc28j60WriteReg(BANK2_MAIPGL, 0x12);
3413  0197 ae8612        	ldw	x,#34322
3414  019a cd002a        	call	_Enc28j60WriteReg
3416                     ; 516 	Enc28j60WriteReg(BANK2_MAIPGH, 0x0C);
3418  019d ae870c        	ldw	x,#34572
3419  01a0 cd002a        	call	_Enc28j60WriteReg
3421                     ; 519 	Enc28j60WriteReg(BANK2_MABBIPG, 0x12);
3423  01a3 ae8412        	ldw	x,#33810
3424  01a6 cd002a        	call	_Enc28j60WriteReg
3426                     ; 522 	Enc28j60SwitchBank(BANK3);
3428  01a9 a603          	ld	a,#3
3429  01ab cd0069        	call	_Enc28j60SwitchBank
3431                     ; 525 	Enc28j60WriteReg(BANK3_MAADR5, uip_ethaddr1);  // MAC MSB
3433  01ae c60000        	ld	a,_uip_ethaddr1
3434  01b1 ae8400        	ldw	x,#33792
3435  01b4 97            	ld	xl,a
3436  01b5 cd002a        	call	_Enc28j60WriteReg
3438                     ; 526 	Enc28j60WriteReg(BANK3_MAADR4, uip_ethaddr2);
3440  01b8 c60000        	ld	a,_uip_ethaddr2
3441  01bb ae8500        	ldw	x,#34048
3442  01be 97            	ld	xl,a
3443  01bf cd002a        	call	_Enc28j60WriteReg
3445                     ; 527 	Enc28j60WriteReg(BANK3_MAADR3, uip_ethaddr3);
3447  01c2 c60000        	ld	a,_uip_ethaddr3
3448  01c5 ae8200        	ldw	x,#33280
3449  01c8 97            	ld	xl,a
3450  01c9 cd002a        	call	_Enc28j60WriteReg
3452                     ; 528 	Enc28j60WriteReg(BANK3_MAADR2, uip_ethaddr4);
3454  01cc c60000        	ld	a,_uip_ethaddr4
3455  01cf ae8300        	ldw	x,#33536
3456  01d2 97            	ld	xl,a
3457  01d3 cd002a        	call	_Enc28j60WriteReg
3459                     ; 529 	Enc28j60WriteReg(BANK3_MAADR1, uip_ethaddr5);
3461  01d6 c60000        	ld	a,_uip_ethaddr5
3462  01d9 ae8000        	ldw	x,#32768
3463  01dc 97            	ld	xl,a
3464  01dd cd002a        	call	_Enc28j60WriteReg
3466                     ; 530 	Enc28j60WriteReg(BANK3_MAADR0, uip_ethaddr6);  // MAC LSB
3468  01e0 c60000        	ld	a,_uip_ethaddr6
3469  01e3 ae8100        	ldw	x,#33024
3470  01e6 97            	ld	xl,a
3471  01e7 cd002a        	call	_Enc28j60WriteReg
3473                     ; 533 	Enc28j60WritePhy(PHY_PHCON2, (1<<PHY_PHCON2_HDLDIS));
3475  01ea ae0100        	ldw	x,#256
3476  01ed 89            	pushw	x
3477  01ee a610          	ld	a,#16
3478  01f0 cd00c0        	call	_Enc28j60WritePhy
3480  01f3 85            	popw	x
3481                     ; 537 	Enc28j60WritePhy(PHY_PHLCON, (ENC28J60_LEDB<<PHY_PHLCON_LBCFG0)|(ENC28J60_LEDA<<PHY_PHLCON_LACFG0)|(1<<PHY_PHLCON_STRCH)|0x3000);
3483  01f4 ae31c2        	ldw	x,#12738
3484  01f7 89            	pushw	x
3485  01f8 a614          	ld	a,#20
3486  01fa cd00c0        	call	_Enc28j60WritePhy
3488  01fd 85            	popw	x
3489                     ; 541 	Enc28j60WritePhy(PHY_PHCON1, 0x0000);
3491  01fe 5f            	clrw	x
3492  01ff 89            	pushw	x
3493  0200 4f            	clr	a
3494  0201 cd00c0        	call	_Enc28j60WritePhy
3496  0204 85            	popw	x
3497                     ; 544 	Enc28j60SetMaskReg(BANKX_ECON1, (1<<BANKX_ECON1_RXEN));
3499  0205 ae1f04        	ldw	x,#7940
3501                     ; 545 }
3504  0208 cc003f        	jp	_Enc28j60SetMaskReg
3562                     ; 548 uint16_t Enc28j60Receive(uint8_t* pBuffer)
3562                     ; 549 {
3563                     	switch	.text
3564  020b               _Enc28j60Receive:
3566  020b 89            	pushw	x
3567  020c 5204          	subw	sp,#4
3568       00000004      OFST:	set	4
3571                     ; 554 	Enc28j60SwitchBank(BANK1);
3573  020e a601          	ld	a,#1
3574  0210 cd0069        	call	_Enc28j60SwitchBank
3576                     ; 555 	if (Enc28j60ReadReg(BANK1_EPKTCNT) == 0) return 0;
3578  0213 a619          	ld	a,#25
3579  0215 cd000c        	call	_Enc28j60ReadReg
3581  0218 4d            	tnz	a
3582  0219 2604          	jrne	L7602
3585  021b 5f            	clrw	x
3587  021c cc02a4        	jra	L423
3588  021f               L7602:
3589                     ; 557 	select();
3591  021f cd0000        	call	_select
3593                     ; 559 	SpiWriteByte(OPCODE_RBM);
3595  0222 a63a          	ld	a,#58
3596  0224 cd0000        	call	_SpiWriteByte
3598                     ; 562 	nNextPacket = ((uint16_t) SpiReadByte() << 0);
3600  0227 cd0000        	call	_SpiReadByte
3602  022a 5f            	clrw	x
3603  022b 97            	ld	xl,a
3604  022c 1f03          	ldw	(OFST-1,sp),x
3606                     ; 563 	nNextPacket |= ((uint16_t) SpiReadByte() << 8);
3608  022e cd0000        	call	_SpiReadByte
3610  0231 5f            	clrw	x
3611  0232 97            	ld	xl,a
3612  0233 7b04          	ld	a,(OFST+0,sp)
3613  0235 01            	rrwa	x,a
3614  0236 1a03          	or	a,(OFST-1,sp)
3615  0238 01            	rrwa	x,a
3616  0239 1f03          	ldw	(OFST-1,sp),x
3618                     ; 566 	nBytes = ((uint16_t) SpiReadByte() << 0);
3620  023b cd0000        	call	_SpiReadByte
3622  023e 5f            	clrw	x
3623  023f 97            	ld	xl,a
3624  0240 1f01          	ldw	(OFST-3,sp),x
3626                     ; 567 	nBytes |= ((uint16_t) SpiReadByte() << 8);
3628  0242 cd0000        	call	_SpiReadByte
3630  0245 5f            	clrw	x
3631  0246 97            	ld	xl,a
3632  0247 7b02          	ld	a,(OFST-2,sp)
3633  0249 01            	rrwa	x,a
3634  024a 1a01          	or	a,(OFST-3,sp)
3635  024c 01            	rrwa	x,a
3637                     ; 568 	nBytes -= 4;
3639  024d 1d0004        	subw	x,#4
3640  0250 1f01          	ldw	(OFST-3,sp),x
3642                     ; 571 	SpiReadByte();
3644  0252 cd0000        	call	_SpiReadByte
3646                     ; 572 	SpiReadByte();
3648  0255 cd0000        	call	_SpiReadByte
3650                     ; 575 	if (nBytes <= ENC28J60_MAXFRAME) SpiReadChunk(pBuffer, nBytes);
3652  0258 1e01          	ldw	x,(OFST-3,sp)
3653  025a a30259        	cpw	x,#601
3654  025d 2407          	jruge	L1702
3657  025f 89            	pushw	x
3658  0260 1e07          	ldw	x,(OFST+3,sp)
3659  0262 cd0000        	call	_SpiReadChunk
3661  0265 85            	popw	x
3662  0266               L1702:
3663                     ; 577 	deselect();
3665  0266 cd0006        	call	_deselect
3667                     ; 579 	Enc28j60SwitchBank(BANK0);
3669  0269 4f            	clr	a
3670  026a cd0069        	call	_Enc28j60SwitchBank
3672                     ; 581 	Enc28j60WriteReg(BANK0_ERDPTL , (uint8_t) (nNextPacket >> 0));
3674  026d 7b04          	ld	a,(OFST+0,sp)
3675  026f 5f            	clrw	x
3676  0270 97            	ld	xl,a
3677  0271 cd002a        	call	_Enc28j60WriteReg
3679                     ; 582 	Enc28j60WriteReg(BANK0_ERDPTH , (uint8_t) (nNextPacket >> 8));
3681  0274 7b03          	ld	a,(OFST-1,sp)
3682  0276 ae0100        	ldw	x,#256
3683  0279 97            	ld	xl,a
3684  027a cd002a        	call	_Enc28j60WriteReg
3686                     ; 586 	nNextPacket -= 1;
3688  027d 1e03          	ldw	x,(OFST-1,sp)
3689  027f 5a            	decw	x
3691                     ; 587 	if (nNextPacket == ( ((uint16_t)ENC28J60_RXSTART) - 1 ))
3693  0280 a3ffff        	cpw	x,#65535
3694  0283 2603          	jrne	L3702
3695                     ; 591 		nNextPacket = ENC28J60_RXEND;
3697  0285 ae17ff        	ldw	x,#6143
3699  0288               L3702:
3700  0288 1f03          	ldw	(OFST-1,sp),x
3701                     ; 594 	Enc28j60WriteReg(BANK0_ERXRDPTL, (uint8_t)(nNextPacket >> 0));
3703  028a ae0c00        	ldw	x,#3072
3704  028d 7b04          	ld	a,(OFST+0,sp)
3705  028f 97            	ld	xl,a
3706  0290 cd002a        	call	_Enc28j60WriteReg
3708                     ; 595 	Enc28j60WriteReg(BANK0_ERXRDPTH, (uint8_t)(nNextPacket >> 8));
3710  0293 7b03          	ld	a,(OFST-1,sp)
3711  0295 ae0d00        	ldw	x,#3328
3712  0298 97            	ld	xl,a
3713  0299 cd002a        	call	_Enc28j60WriteReg
3715                     ; 598 	Enc28j60SetMaskReg(BANKX_ECON2 , (1<<BANKX_ECON2_PKTDEC));
3717  029c ae1e40        	ldw	x,#7744
3718  029f cd003f        	call	_Enc28j60SetMaskReg
3720                     ; 600 	return nBytes;
3722  02a2 1e01          	ldw	x,(OFST-3,sp)
3724  02a4               L423:
3726  02a4 5b06          	addw	sp,#6
3727  02a6 81            	ret	
3791                     ; 604 void Enc28j60CopyPacket(uint8_t* pBuffer, uint16_t nBytes)
3791                     ; 605 {
3792                     	switch	.text
3793  02a7               _Enc28j60CopyPacket:
3795  02a7 89            	pushw	x
3796  02a8 5203          	subw	sp,#3
3797       00000003      OFST:	set	3
3800                     ; 606 	uint16_t TxEnd = ENC28J60_TXSTART + nBytes;
3802  02aa 1e08          	ldw	x,(OFST+5,sp)
3803  02ac 1c1800        	addw	x,#6144
3804  02af 1f01          	ldw	(OFST-2,sp),x
3806                     ; 607 	uint8_t i = 200;
3808  02b1 a6c8          	ld	a,#200
3809  02b3 6b03          	ld	(OFST+0,sp),a
3812  02b5 204e          	jra	L5212
3813  02b7               L1212:
3814                     ; 614 		if (!(Enc28j60ReadReg(BANKX_ECON1) & (1<<BANKX_ECON1_TXRTS))) break;
3816  02b7 a61f          	ld	a,#31
3817  02b9 cd000c        	call	_Enc28j60ReadReg
3819  02bc a508          	bcp	a,#8
3820  02be 263d          	jrne	L1312
3822  02c0               L7212:
3823                     ; 619 	Enc28j60SwitchBank(BANK0);
3825  02c0 4f            	clr	a
3826  02c1 cd0069        	call	_Enc28j60SwitchBank
3828                     ; 621 	Enc28j60WriteReg(BANK0_EWRPTL, (uint8_t) (ENC28J60_TXSTART >> 0));
3830  02c4 ae0200        	ldw	x,#512
3831  02c7 cd002a        	call	_Enc28j60WriteReg
3833                     ; 622 	Enc28j60WriteReg(BANK0_EWRPTH, (uint8_t) (ENC28J60_TXSTART >> 8));
3835  02ca ae0318        	ldw	x,#792
3836  02cd cd002a        	call	_Enc28j60WriteReg
3838                     ; 623 	Enc28j60WriteReg(BANK0_ETXNDL, (uint8_t) (TxEnd >> 0));
3840  02d0 7b02          	ld	a,(OFST-1,sp)
3841  02d2 ae0600        	ldw	x,#1536
3842  02d5 97            	ld	xl,a
3843  02d6 cd002a        	call	_Enc28j60WriteReg
3845                     ; 624 	Enc28j60WriteReg(BANK0_ETXNDH, (uint8_t) (TxEnd >> 8));	
3847  02d9 7b01          	ld	a,(OFST-2,sp)
3848  02db ae0700        	ldw	x,#1792
3849  02de 97            	ld	xl,a
3850  02df cd002a        	call	_Enc28j60WriteReg
3852                     ; 626 	select();
3854  02e2 cd0000        	call	_select
3856                     ; 628 	SpiWriteByte(OPCODE_WBM);	 // Set ENC28J60 to receive transmit data
3858  02e5 a67a          	ld	a,#122
3859  02e7 cd0000        	call	_SpiWriteByte
3861                     ; 630 	SpiWriteByte(0);		 // Per-packet-control-byte
3863  02ea 4f            	clr	a
3864  02eb cd0000        	call	_SpiWriteByte
3866                     ; 642 	SpiWriteChunk(pBuffer, nBytes); // Copy data to the ENC28J60 transmit buffer
3868  02ee 1e08          	ldw	x,(OFST+5,sp)
3869  02f0 89            	pushw	x
3870  02f1 1e06          	ldw	x,(OFST+3,sp)
3871  02f3 cd0000        	call	_SpiWriteChunk
3873  02f6 85            	popw	x
3874                     ; 644 	deselect();
3876  02f7 cd0006        	call	_deselect
3878                     ; 645 }
3881  02fa 5b05          	addw	sp,#5
3882  02fc 81            	ret	
3883  02fd               L1312:
3884                     ; 616 		wait_timer(500);
3886  02fd ae01f4        	ldw	x,#500
3887  0300 cd0000        	call	_wait_timer
3889  0303 7b03          	ld	a,(OFST+0,sp)
3890  0305               L5212:
3891                     ; 612 	while (i--)
3893  0305 0a03          	dec	(OFST+0,sp)
3895  0307 4d            	tnz	a
3896  0308 26ad          	jrne	L1212
3897  030a 20b4          	jra	L7212
3922                     ; 648 void Enc28j60Send(void)
3922                     ; 649 {
3923                     	switch	.text
3924  030c               _Enc28j60Send:
3928                     ; 651 	Enc28j60SetMaskReg(BANKX_ECON1, (1<<BANKX_ECON1_TXRST));
3930  030c ae1f80        	ldw	x,#8064
3931  030f cd003f        	call	_Enc28j60SetMaskReg
3933                     ; 652 	Enc28j60ClearMaskReg(BANKX_ECON1, (1<<BANKX_ECON1_TXRST));
3935  0312 ae1f80        	ldw	x,#8064
3936  0315 cd0054        	call	_Enc28j60ClearMaskReg
3938                     ; 655 	Enc28j60SetMaskReg(BANKX_ECON1, (1<<BANKX_ECON1_TXRTS));
3940  0318 ae1f08        	ldw	x,#7944
3942                     ; 656 }
3945  031b cc003f        	jp	_Enc28j60SetMaskReg
3980                     ; 659 void Enc28j60SetClockPrescaler(uint8_t nPrescaler)
3980                     ; 660 {
3981                     	switch	.text
3982  031e               _Enc28j60SetClockPrescaler:
3984  031e 88            	push	a
3985       00000000      OFST:	set	0
3988                     ; 669 	Enc28j60SwitchBank(BANK3);
3990  031f a603          	ld	a,#3
3991  0321 cd0069        	call	_Enc28j60SwitchBank
3993                     ; 671 	if (nPrescaler == 0)
3995  0324 7b01          	ld	a,(OFST+1,sp)
3996  0326 2605          	jrne	L7512
3997                     ; 672 		Enc28j60WriteReg(BANK3_ECOCON, 0x00); // Disable CLKOUT
3999  0328 ae1500        	ldw	x,#5376
4002  032b 202b          	jp	LC001
4003  032d               L7512:
4004                     ; 673 	else if (nPrescaler == 1)
4006  032d a101          	cp	a,#1
4007  032f 2605          	jrne	L3612
4008                     ; 674 		Enc28j60WriteReg(BANK3_ECOCON, 0x01); // CLKOUT = 25 MHz
4010  0331 ae1501        	ldw	x,#5377
4013  0334 2022          	jp	LC001
4014  0336               L3612:
4015                     ; 675 	else if (nPrescaler == 2)
4017  0336 a102          	cp	a,#2
4018  0338 2605          	jrne	L7612
4019                     ; 676 		Enc28j60WriteReg(BANK3_ECOCON, 0x02); // CLKOUT = 12.5 MHz
4021  033a ae1502        	ldw	x,#5378
4024  033d 2019          	jp	LC001
4025  033f               L7612:
4026                     ; 677 	else if (nPrescaler == 3)
4028  033f a103          	cp	a,#3
4029  0341 2605          	jrne	L3712
4030                     ; 678 		Enc28j60WriteReg(BANK3_ECOCON, 0x03); // CLKOUT = 8.333333 MHz
4032  0343 ae1503        	ldw	x,#5379
4035  0346 2010          	jp	LC001
4036  0348               L3712:
4037                     ; 679 	else if (nPrescaler == 4)
4039  0348 a104          	cp	a,#4
4040  034a 2605          	jrne	L7712
4041                     ; 680 		Enc28j60WriteReg(BANK3_ECOCON, 0x04); // CLKOUT = 6.25 MHz
4043  034c ae1504        	ldw	x,#5380
4046  034f 2007          	jp	LC001
4047  0351               L7712:
4048                     ; 681 	else if (nPrescaler == 8)
4050  0351 a108          	cp	a,#8
4051  0353 2606          	jrne	L1612
4052                     ; 682 		Enc28j60WriteReg(BANK3_ECOCON, 0x05); // CLKOUT = 3.125 MHz
4054  0355 ae1505        	ldw	x,#5381
4055  0358               LC001:
4056  0358 cd002a        	call	_Enc28j60WriteReg
4058  035b               L1612:
4059                     ; 683 }
4062  035b 84            	pop	a
4063  035c 81            	ret	
4121                     ; 686 uint16_t Enc28j60ChecksumTx(uint16_t Offset, uint16_t Length)
4121                     ; 687 {
4122                     	switch	.text
4123  035d               _Enc28j60ChecksumTx:
4125  035d 89            	pushw	x
4126  035e 5206          	subw	sp,#6
4127       00000006      OFST:	set	6
4130                     ; 691 	uint16_t Start = ENC28J60_TXSTART + Offset + 1;
4132  0360 1c1801        	addw	x,#6145
4133  0363 1f05          	ldw	(OFST-1,sp),x
4135                     ; 692 	uint16_t End = Start + Length - 1;
4137  0365 72fb0b        	addw	x,(OFST+5,sp)
4138  0368 5a            	decw	x
4139  0369 1f03          	ldw	(OFST-3,sp),x
4141                     ; 694 	Enc28j60SwitchBank(BANK0);
4143  036b 4f            	clr	a
4144  036c cd0069        	call	_Enc28j60SwitchBank
4146                     ; 695 	Enc28j60WriteReg(BANK0_EDMASTL, (uint8_t) (Start >> 0));
4148  036f 7b06          	ld	a,(OFST+0,sp)
4149  0371 ae1000        	ldw	x,#4096
4150  0374 97            	ld	xl,a
4151  0375 cd002a        	call	_Enc28j60WriteReg
4153                     ; 696 	Enc28j60WriteReg(BANK0_EDMASTH, (uint8_t) (Start >> 8));
4155  0378 7b05          	ld	a,(OFST-1,sp)
4156  037a ae1100        	ldw	x,#4352
4157  037d 97            	ld	xl,a
4158  037e cd002a        	call	_Enc28j60WriteReg
4160                     ; 697 	Enc28j60WriteReg(BANK0_EDMANDL, (uint8_t) (End >> 0));
4162  0381 7b04          	ld	a,(OFST-2,sp)
4163  0383 ae1200        	ldw	x,#4608
4164  0386 97            	ld	xl,a
4165  0387 cd002a        	call	_Enc28j60WriteReg
4167                     ; 698 	Enc28j60WriteReg(BANK0_EDMANDH, (uint8_t) (End >> 8));
4169  038a 7b03          	ld	a,(OFST-3,sp)
4170  038c ae1300        	ldw	x,#4864
4171  038f 97            	ld	xl,a
4172  0390 cd002a        	call	_Enc28j60WriteReg
4174                     ; 699 	Enc28j60SetMaskReg(BANKX_ECON1, (1<<BANKX_ECON1_CSUMEN) | (1<<BANKX_ECON1_DMAST));
4176  0393 ae1f30        	ldw	x,#7984
4177  0396 cd003f        	call	_Enc28j60SetMaskReg
4180  0399 2001          	jra	L1322
4181  039b               L7222:
4182                     ; 701 	while(Enc28j60ReadReg(BANKX_ECON1) & (1<<BANKX_ECON1_DMAST)) nop();
4185  039b 9d            	nop	
4187  039c               L1322:
4190  039c a61f          	ld	a,#31
4191  039e cd000c        	call	_Enc28j60ReadReg
4193  03a1 a520          	bcp	a,#32
4194  03a3 26f6          	jrne	L7222
4195                     ; 703 	return ((uint16_t) Enc28j60ReadReg(BANK0_EDMACSH) << 8) | ((uint16_t) Enc28j60ReadReg(BANK0_EDMACSL) << 0);
4198  03a5 a616          	ld	a,#22
4199  03a7 cd000c        	call	_Enc28j60ReadReg
4201  03aa 5f            	clrw	x
4202  03ab 97            	ld	xl,a
4203  03ac 1f01          	ldw	(OFST-5,sp),x
4205  03ae a617          	ld	a,#23
4206  03b0 cd000c        	call	_Enc28j60ReadReg
4208  03b3 5f            	clrw	x
4209  03b4 97            	ld	xl,a
4210  03b5 7b02          	ld	a,(OFST-4,sp)
4211  03b7 01            	rrwa	x,a
4212  03b8 1a01          	or	a,(OFST-5,sp)
4213  03ba 01            	rrwa	x,a
4216  03bb 5b08          	addw	sp,#8
4217  03bd 81            	ret	
4270                     ; 707 void Enc28j60CopyChecksum(uint16_t Offset, uint16_t Checksum)
4270                     ; 708 {
4271                     	switch	.text
4272  03be               _Enc28j60CopyChecksum:
4274  03be 89            	pushw	x
4275  03bf 89            	pushw	x
4276       00000002      OFST:	set	2
4279                     ; 710 	uint16_t WrPtr = ENC28J60_TXSTART + Offset + 1;
4281  03c0 1c1801        	addw	x,#6145
4282  03c3 1f01          	ldw	(OFST-1,sp),x
4284                     ; 712 	Enc28j60SwitchBank(BANK0);
4286  03c5 4f            	clr	a
4287  03c6 cd0069        	call	_Enc28j60SwitchBank
4289                     ; 714 	Enc28j60WriteReg(BANK0_EWRPTL, (uint8_t) (WrPtr >> 0));
4291  03c9 7b02          	ld	a,(OFST+0,sp)
4292  03cb ae0200        	ldw	x,#512
4293  03ce 97            	ld	xl,a
4294  03cf cd002a        	call	_Enc28j60WriteReg
4296                     ; 715 	Enc28j60WriteReg(BANK0_EWRPTH, (uint8_t) (WrPtr >> 8));
4298  03d2 7b01          	ld	a,(OFST-1,sp)
4299  03d4 ae0300        	ldw	x,#768
4300  03d7 97            	ld	xl,a
4301  03d8 cd002a        	call	_Enc28j60WriteReg
4303                     ; 717 	select();
4305  03db cd0000        	call	_select
4307                     ; 719 	SpiWriteByte(OPCODE_WBM);
4309  03de a67a          	ld	a,#122
4310  03e0 cd0000        	call	_SpiWriteByte
4312                     ; 720 	SpiWriteChunk((uint8_t*) &Checksum, sizeof(Checksum));
4314  03e3 ae0002        	ldw	x,#2
4315  03e6 89            	pushw	x
4316  03e7 96            	ldw	x,sp
4317  03e8 1c0009        	addw	x,#OFST+7
4318  03eb cd0000        	call	_SpiWriteChunk
4320  03ee 85            	popw	x
4321                     ; 722 	deselect();
4323  03ef cd0006        	call	_deselect
4325                     ; 723 }
4328  03f2 5b04          	addw	sp,#4
4329  03f4 81            	ret	
4342                     	xdef	_Enc28j60WritePhy
4343                     	xdef	_Enc28j60ReadPhy
4344                     	xdef	_Enc28j60SwitchBank
4345                     	xdef	_Enc28j60ClearMaskReg
4346                     	xdef	_Enc28j60SetMaskReg
4347                     	xdef	_Enc28j60WriteReg
4348                     	xdef	_Enc28j60ReadReg
4349                     	xdef	_deselect
4350                     	xdef	_select
4351                     	xref	_uip_ethaddr6
4352                     	xref	_uip_ethaddr5
4353                     	xref	_uip_ethaddr4
4354                     	xref	_uip_ethaddr3
4355                     	xref	_uip_ethaddr2
4356                     	xref	_uip_ethaddr1
4357                     	xref	_wait_timer
4358                     	xdef	_Enc28j60CopyChecksum
4359                     	xdef	_Enc28j60ChecksumTx
4360                     	xdef	_Enc28j60SetClockPrescaler
4361                     	xdef	_Enc28j60Send
4362                     	xdef	_Enc28j60CopyPacket
4363                     	xdef	_Enc28j60Receive
4364                     	xdef	_Enc28j60Init
4365                     	xref	_SpiReadChunk
4366                     	xref	_SpiReadByte
4367                     	xref	_SpiWriteChunk
4368                     	xref	_SpiWriteByte
4387                     	end
