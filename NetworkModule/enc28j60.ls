   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Parser V4.11.14 - 18 Nov 2019
   3                     ; Generator (Limited) V4.4.11 - 19 Nov 2019
   4                     ; Optimizer V4.4.11 - 19 Nov 2019
2546                     ; 252 void select(void)
2546                     ; 253 {
2548                     	switch	.text
2549  0000               _select:
2553                     ; 255   PC_ODR &= (uint8_t)(~0x02);
2555  0000 7213500a      	bres	_PC_ODR,#1
2556                     ; 256   nop();
2559  0004 9d            	nop	
2561                     ; 257 }
2565  0005 81            	ret	
2590                     ; 260 void deselect(void)
2590                     ; 261 {
2591                     	switch	.text
2592  0006               _deselect:
2596                     ; 263   PC_ODR |= (uint8_t)0x02;
2598  0006 7212500a      	bset	_PC_ODR,#1
2599                     ; 264   nop();
2602  000a 9d            	nop	
2604                     ; 265 }
2608  000b 81            	ret	
2651                     ; 270 uint8_t Enc28j60ReadReg(uint8_t nRegister)
2651                     ; 271 {
2652                     	switch	.text
2653  000c               _Enc28j60ReadReg:
2655  000c 88            	push	a
2656  000d 88            	push	a
2657       00000001      OFST:	set	1
2660                     ; 274   select();
2662  000e adf0          	call	_select
2664                     ; 276   SpiWriteByte((uint8_t)(OPCODE_RCR | (nRegister & REGISTER_MASK)));
2666  0010 7b02          	ld	a,(OFST+1,sp)
2667  0012 a41f          	and	a,#31
2668  0014 cd0000        	call	_SpiWriteByte
2670                     ; 277   if (nRegister & REGISTER_NEEDDUMMY) SpiWriteByte(0);
2672  0017 7b02          	ld	a,(OFST+1,sp)
2673  0019 2a04          	jrpl	L3661
2676  001b 4f            	clr	a
2677  001c cd0000        	call	_SpiWriteByte
2679  001f               L3661:
2680                     ; 278   nByte = SpiReadByte();
2682  001f cd0000        	call	_SpiReadByte
2684  0022 6b01          	ld	(OFST+0,sp),a
2686                     ; 280   deselect();
2688  0024 ade0          	call	_deselect
2690                     ; 282   return nByte;
2692  0026 7b01          	ld	a,(OFST+0,sp)
2695  0028 85            	popw	x
2696  0029 81            	ret	
2738                     ; 288 void Enc28j60WriteReg( uint8_t nRegister, uint8_t nData)
2738                     ; 289 {
2739                     	switch	.text
2740  002a               _Enc28j60WriteReg:
2742  002a 89            	pushw	x
2743       00000000      OFST:	set	0
2746                     ; 290   select();
2748  002b add3          	call	_select
2750                     ; 292   SpiWriteByte((uint8_t)(OPCODE_WCR | (nRegister & REGISTER_MASK)));
2752  002d 7b01          	ld	a,(OFST+1,sp)
2753  002f a41f          	and	a,#31
2754  0031 aa40          	or	a,#64
2755  0033 cd0000        	call	_SpiWriteByte
2757                     ; 293   SpiWriteByte(nData);
2759  0036 7b02          	ld	a,(OFST+2,sp)
2760  0038 cd0000        	call	_SpiWriteByte
2762                     ; 295   deselect();
2764  003b adc9          	call	_deselect
2766                     ; 296 }
2769  003d 85            	popw	x
2770  003e 81            	ret	
2812                     ; 301 void Enc28j60SetMaskReg(uint8_t nRegister, uint8_t nMask)
2812                     ; 302 {
2813                     	switch	.text
2814  003f               _Enc28j60SetMaskReg:
2816  003f 89            	pushw	x
2817       00000000      OFST:	set	0
2820                     ; 303   select();
2822  0040 adbe          	call	_select
2824                     ; 305   SpiWriteByte((uint8_t)(OPCODE_BFS | (nRegister & REGISTER_MASK)));
2826  0042 7b01          	ld	a,(OFST+1,sp)
2827  0044 a41f          	and	a,#31
2828  0046 aa80          	or	a,#128
2829  0048 cd0000        	call	_SpiWriteByte
2831                     ; 306   SpiWriteByte(nMask);
2833  004b 7b02          	ld	a,(OFST+2,sp)
2834  004d cd0000        	call	_SpiWriteByte
2836                     ; 308   deselect();
2838  0050 adb4          	call	_deselect
2840                     ; 309 }
2843  0052 85            	popw	x
2844  0053 81            	ret	
2887                     ; 314 void Enc28j60ClearMaskReg( uint8_t nRegister, uint8_t nMask)
2887                     ; 315 {
2888                     	switch	.text
2889  0054               _Enc28j60ClearMaskReg:
2891  0054 89            	pushw	x
2892       00000000      OFST:	set	0
2895                     ; 316   select();
2897  0055 ada9          	call	_select
2899                     ; 318   SpiWriteByte((uint8_t)(OPCODE_BFC | (nRegister & REGISTER_MASK)));
2901  0057 7b01          	ld	a,(OFST+1,sp)
2902  0059 a41f          	and	a,#31
2903  005b aaa0          	or	a,#160
2904  005d cd0000        	call	_SpiWriteByte
2906                     ; 319   SpiWriteByte(nMask);
2908  0060 7b02          	ld	a,(OFST+2,sp)
2909  0062 cd0000        	call	_SpiWriteByte
2911                     ; 321   deselect();
2913  0065 ad9f          	call	_deselect
2915                     ; 322 }
2918  0067 85            	popw	x
2919  0068 81            	ret	
2953                     ; 327 void Enc28j60SwitchBank(uint8_t nBank)
2953                     ; 328 {
2954                     	switch	.text
2955  0069               _Enc28j60SwitchBank:
2957  0069 88            	push	a
2958       00000000      OFST:	set	0
2961                     ; 332   Enc28j60ClearMaskReg(BANKX_ECON1, (3<<BANKX_ECON1_BSEL0));
2963  006a ae1f03        	ldw	x,#7939
2964  006d ade5          	call	_Enc28j60ClearMaskReg
2966                     ; 333   Enc28j60SetMaskReg(BANKX_ECON1, (uint8_t)(nBank << BANKX_ECON1_BSEL0));
2968  006f 7b01          	ld	a,(OFST+1,sp)
2969  0071 ae1f00        	ldw	x,#7936
2970  0074 97            	ld	xl,a
2971  0075 adc8          	call	_Enc28j60SetMaskReg
2973                     ; 334 }
2976  0077 84            	pop	a
2977  0078 81            	ret	
3015                     ; 340 uint16_t Enc28j60ReadPhy(uint8_t nRegister)
3015                     ; 341 {
3016                     	switch	.text
3017  0079               _Enc28j60ReadPhy:
3019  0079 88            	push	a
3020  007a 89            	pushw	x
3021       00000002      OFST:	set	2
3024                     ; 342   Enc28j60SwitchBank(BANK2);
3026  007b a602          	ld	a,#2
3027  007d adea          	call	_Enc28j60SwitchBank
3029                     ; 343   Enc28j60WriteReg(BANK2_MIREGADR, nRegister);
3031  007f 7b03          	ld	a,(OFST+1,sp)
3032  0081 ae9400        	ldw	x,#37888
3033  0084 97            	ld	xl,a
3034  0085 ada3          	call	_Enc28j60WriteReg
3036                     ; 344   Enc28j60SetMaskReg(BANK2_MICMD, (1<<BANK2_MICMD_MIIRD));
3038  0087 ae9201        	ldw	x,#37377
3039  008a adb3          	call	_Enc28j60SetMaskReg
3041                     ; 345   Enc28j60SwitchBank(BANK3);
3043  008c a603          	ld	a,#3
3044  008e add9          	call	_Enc28j60SwitchBank
3047  0090 2001          	jra	L1771
3048  0092               L7671:
3049                     ; 346   while (Enc28j60ReadReg(BANK3_MISTAT) & (1 <<BANK3_MISTAT_BUSY)) nop();
3052  0092 9d            	nop	
3054  0093               L1771:
3057  0093 a68a          	ld	a,#138
3058  0095 cd000c        	call	_Enc28j60ReadReg
3060  0098 a501          	bcp	a,#1
3061  009a 26f6          	jrne	L7671
3062                     ; 347   Enc28j60SwitchBank(BANK2);
3065  009c a602          	ld	a,#2
3066  009e adc9          	call	_Enc28j60SwitchBank
3068                     ; 348   Enc28j60ClearMaskReg(BANK2_MICMD, (1<<BANK2_MICMD_MIIRD));
3070  00a0 ae9201        	ldw	x,#37377
3071  00a3 adaf          	call	_Enc28j60ClearMaskReg
3073                     ; 350   return ((uint16_t) Enc28j60ReadReg(BANK2_MIRDL) << 0)
3073                     ; 351        | ((uint16_t) Enc28j60ReadReg(BANK2_MIRDH) << 8);
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
3139                     ; 358 void Enc28j60WritePhy( uint8_t nRegister, uint16_t nData)
3139                     ; 359 {
3140                     	switch	.text
3141  00c0               _Enc28j60WritePhy:
3143  00c0 88            	push	a
3144       00000000      OFST:	set	0
3147                     ; 360   Enc28j60SwitchBank(BANK2);
3149  00c1 a602          	ld	a,#2
3150  00c3 ada4          	call	_Enc28j60SwitchBank
3152                     ; 361   Enc28j60WriteReg(BANK2_MIREGADR, nRegister);
3154  00c5 7b01          	ld	a,(OFST+1,sp)
3155  00c7 ae9400        	ldw	x,#37888
3156  00ca 97            	ld	xl,a
3157  00cb cd002a        	call	_Enc28j60WriteReg
3159                     ; 362   Enc28j60WriteReg(BANK2_MIWRL, (uint8_t)(nData >> 0));
3161  00ce 7b05          	ld	a,(OFST+5,sp)
3162  00d0 ae9600        	ldw	x,#38400
3163  00d3 97            	ld	xl,a
3164  00d4 cd002a        	call	_Enc28j60WriteReg
3166                     ; 363   Enc28j60WriteReg(BANK2_MIWRH, (uint8_t)(nData >> 8));
3168  00d7 7b04          	ld	a,(OFST+4,sp)
3169  00d9 ae9700        	ldw	x,#38656
3170  00dc 97            	ld	xl,a
3171  00dd cd002a        	call	_Enc28j60WriteReg
3173                     ; 364   Enc28j60SwitchBank(BANK3);
3175  00e0 a603          	ld	a,#3
3176  00e2 ad85          	call	_Enc28j60SwitchBank
3179  00e4 2001          	jra	L5102
3180  00e6               L3102:
3181                     ; 365   while (Enc28j60ReadReg(BANK3_MISTAT) & (1 <<BANK3_MISTAT_BUSY)) nop();
3184  00e6 9d            	nop	
3186  00e7               L5102:
3189  00e7 a68a          	ld	a,#138
3190  00e9 cd000c        	call	_Enc28j60ReadReg
3192  00ec a501          	bcp	a,#1
3193  00ee 26f6          	jrne	L3102
3194                     ; 366 }
3198  00f0 84            	pop	a
3199  00f1 81            	ret	
3240                     ; 369 void Enc28j60Init(void)
3240                     ; 370 {
3241                     	switch	.text
3242  00f2               _Enc28j60Init:
3246                     ; 374   deselect(); // Just makes sure the -CS is not selected
3248  00f2 cd0006        	call	_deselect
3251  00f5 2001          	jra	L3302
3252  00f7               L1302:
3253                     ; 388   while (!(Enc28j60ReadReg(BANKX_ESTAT) & (1<<BANKX_ESTAT_CLKRDY))) nop();
3256  00f7 9d            	nop	
3258  00f8               L3302:
3261  00f8 a61d          	ld	a,#29
3262  00fa cd000c        	call	_Enc28j60ReadReg
3264  00fd a501          	bcp	a,#1
3265  00ff 27f6          	jreq	L1302
3266                     ; 391   select();
3269  0101 cd0000        	call	_select
3271                     ; 392   SpiWriteByte(OPCODE_SRC); // Reset command
3273  0104 a6ff          	ld	a,#255
3274  0106 cd0000        	call	_SpiWriteByte
3276                     ; 393   deselect();
3278  0109 cd0006        	call	_deselect
3280                     ; 394   wait_timer((uint16_t)10000); // delay 10 ms
3282  010c ae2710        	ldw	x,#10000
3283  010f cd0000        	call	_wait_timer
3285                     ; 397   Enc28j60WritePhy(PHY_PHCON1, (uint16_t)(1<<PHY_PHCON1_PRST)); // Reset command
3287  0112 ae8000        	ldw	x,#32768
3288  0115 89            	pushw	x
3289  0116 4f            	clr	a
3290  0117 ada7          	call	_Enc28j60WritePhy
3292  0119 85            	popw	x
3294  011a 2001          	jra	L1402
3295  011c               L7302:
3296                     ; 399   while (Enc28j60ReadPhy(PHY_PHCON1) & (uint16_t)(1<<PHY_PHCON1_PRST)) nop();
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
3315                     ; 402   Enc28j60SwitchBank(BANK0);
3318  012b 4f            	clr	a
3319  012c cd0069        	call	_Enc28j60SwitchBank
3321                     ; 405   Enc28j60WriteReg(BANK0_ERXSTL, (uint8_t) (ENC28J60_RXSTART >> 0));
3323  012f ae0800        	ldw	x,#2048
3324  0132 cd002a        	call	_Enc28j60WriteReg
3326                     ; 406   Enc28j60WriteReg(BANK0_ERXSTH, (uint8_t) (ENC28J60_RXSTART >> 8));
3328  0135 ae0900        	ldw	x,#2304
3329  0138 cd002a        	call	_Enc28j60WriteReg
3331                     ; 407   Enc28j60WriteReg(BANK0_ERXNDL, (uint8_t) (ENC28J60_RXEND >> 0));
3333  013b ae0aff        	ldw	x,#2815
3334  013e cd002a        	call	_Enc28j60WriteReg
3336                     ; 408   Enc28j60WriteReg(BANK0_ERXNDH, (uint8_t) (ENC28J60_RXEND >> 8));
3338  0141 ae0b17        	ldw	x,#2839
3339  0144 cd002a        	call	_Enc28j60WriteReg
3341                     ; 410   Enc28j60WriteReg(BANK0_ERDPTL, (uint8_t) (ENC28J60_RXSTART >> 0));
3343  0147 5f            	clrw	x
3344  0148 cd002a        	call	_Enc28j60WriteReg
3346                     ; 411   Enc28j60WriteReg(BANK0_ERDPTH, (uint8_t) (ENC28J60_RXSTART >> 8));
3348  014b ae0100        	ldw	x,#256
3349  014e cd002a        	call	_Enc28j60WriteReg
3351                     ; 414   Enc28j60WriteReg(BANK0_ERXRDPTL, (uint8_t) (ENC28J60_RXEND >> 0));
3353  0151 ae0cff        	ldw	x,#3327
3354  0154 cd002a        	call	_Enc28j60WriteReg
3356                     ; 415   Enc28j60WriteReg(BANK0_ERXRDPTH, (uint8_t) (ENC28J60_RXEND >> 8));
3358  0157 ae0d17        	ldw	x,#3351
3359  015a cd002a        	call	_Enc28j60WriteReg
3361                     ; 417   Enc28j60WriteReg(BANK0_ETXSTL, (uint8_t) (ENC28J60_TXSTART >> 0));
3363  015d ae0400        	ldw	x,#1024
3364  0160 cd002a        	call	_Enc28j60WriteReg
3366                     ; 418   Enc28j60WriteReg(BANK0_ETXSTH, (uint8_t) (ENC28J60_TXSTART >> 8));
3368  0163 ae0518        	ldw	x,#1304
3369  0166 cd002a        	call	_Enc28j60WriteReg
3371                     ; 421   Enc28j60SwitchBank(BANK1);
3373  0169 a601          	ld	a,#1
3374  016b cd0069        	call	_Enc28j60SwitchBank
3376                     ; 468   Enc28j60WriteReg(BANK1_ERXFCON, (uint8_t)0xa1);    // Allows packets if MAC matches
3378  016e ae18a1        	ldw	x,#6305
3379  0171 cd002a        	call	_Enc28j60WriteReg
3381                     ; 485   Enc28j60SwitchBank(BANK2);
3383  0174 a602          	ld	a,#2
3384  0176 cd0069        	call	_Enc28j60SwitchBank
3386                     ; 488   Enc28j60WriteReg(BANK2_MACON1, (1<<BANK2_MACON1_MARXEN));
3388  0179 ae8001        	ldw	x,#32769
3389  017c cd002a        	call	_Enc28j60WriteReg
3391                     ; 504   Enc28j60SetMaskReg(BANK2_MACON3, (1<<BANK2_MACON3_TXCRCEN)|(1<<BANK2_MACON3_PADCFG0)|(1<<BANK2_MACON3_FRMLNEN));
3393  017f ae8232        	ldw	x,#33330
3394  0182 cd003f        	call	_Enc28j60SetMaskReg
3396                     ; 507   Enc28j60SetMaskReg(BANK2_MACON4, (1<<BANK2_MACON4_DEFER));
3398  0185 ae8340        	ldw	x,#33600
3399  0188 cd003f        	call	_Enc28j60SetMaskReg
3401                     ; 511   Enc28j60WriteReg(BANK2_MAMXFLL, (uint8_t) ((ENC28J60_MAXFRAME + 4) >> 0));
3403  018b ae8a88        	ldw	x,#35464
3404  018e cd002a        	call	_Enc28j60WriteReg
3406                     ; 512   Enc28j60WriteReg(BANK2_MAMXFLH, (uint8_t) ((ENC28J60_MAXFRAME + 4) >> 8));
3408  0191 ae9003        	ldw	x,#36867
3409  0194 cd002a        	call	_Enc28j60WriteReg
3411                     ; 515   Enc28j60WriteReg(BANK2_MAIPGL, 0x12);
3413  0197 ae8612        	ldw	x,#34322
3414  019a cd002a        	call	_Enc28j60WriteReg
3416                     ; 518   Enc28j60WriteReg(BANK2_MAIPGH, 0x0C);
3418  019d ae870c        	ldw	x,#34572
3419  01a0 cd002a        	call	_Enc28j60WriteReg
3421                     ; 521   Enc28j60WriteReg(BANK2_MABBIPG, 0x12);
3423  01a3 ae8412        	ldw	x,#33810
3424  01a6 cd002a        	call	_Enc28j60WriteReg
3426                     ; 524   Enc28j60SwitchBank(BANK3);
3428  01a9 a603          	ld	a,#3
3429  01ab cd0069        	call	_Enc28j60SwitchBank
3431                     ; 527   Enc28j60WriteReg(BANK3_MAADR5, uip_ethaddr1);  // MAC MSB
3433  01ae c60000        	ld	a,_uip_ethaddr1
3434  01b1 ae8400        	ldw	x,#33792
3435  01b4 97            	ld	xl,a
3436  01b5 cd002a        	call	_Enc28j60WriteReg
3438                     ; 528   Enc28j60WriteReg(BANK3_MAADR4, uip_ethaddr2);
3440  01b8 c60000        	ld	a,_uip_ethaddr2
3441  01bb ae8500        	ldw	x,#34048
3442  01be 97            	ld	xl,a
3443  01bf cd002a        	call	_Enc28j60WriteReg
3445                     ; 529   Enc28j60WriteReg(BANK3_MAADR3, uip_ethaddr3);
3447  01c2 c60000        	ld	a,_uip_ethaddr3
3448  01c5 ae8200        	ldw	x,#33280
3449  01c8 97            	ld	xl,a
3450  01c9 cd002a        	call	_Enc28j60WriteReg
3452                     ; 530   Enc28j60WriteReg(BANK3_MAADR2, uip_ethaddr4);
3454  01cc c60000        	ld	a,_uip_ethaddr4
3455  01cf ae8300        	ldw	x,#33536
3456  01d2 97            	ld	xl,a
3457  01d3 cd002a        	call	_Enc28j60WriteReg
3459                     ; 531   Enc28j60WriteReg(BANK3_MAADR1, uip_ethaddr5);
3461  01d6 c60000        	ld	a,_uip_ethaddr5
3462  01d9 ae8000        	ldw	x,#32768
3463  01dc 97            	ld	xl,a
3464  01dd cd002a        	call	_Enc28j60WriteReg
3466                     ; 532   Enc28j60WriteReg(BANK3_MAADR0, uip_ethaddr6);  // MAC LSB
3468  01e0 c60000        	ld	a,_uip_ethaddr6
3469  01e3 ae8100        	ldw	x,#33024
3470  01e6 97            	ld	xl,a
3471  01e7 cd002a        	call	_Enc28j60WriteReg
3473                     ; 535   Enc28j60WritePhy(PHY_PHCON2, (1<<PHY_PHCON2_HDLDIS));
3475  01ea ae0100        	ldw	x,#256
3476  01ed 89            	pushw	x
3477  01ee a610          	ld	a,#16
3478  01f0 cd00c0        	call	_Enc28j60WritePhy
3480  01f3 85            	popw	x
3481                     ; 539   Enc28j60WritePhy(PHY_PHLCON,
3481                     ; 540     (ENC28J60_LEDB<<PHY_PHLCON_LBCFG0)|
3481                     ; 541     (ENC28J60_LEDA<<PHY_PHLCON_LACFG0)|
3481                     ; 542     (1<<PHY_PHLCON_STRCH)|0x3000);
3483  01f4 ae31c2        	ldw	x,#12738
3484  01f7 89            	pushw	x
3485  01f8 a614          	ld	a,#20
3486  01fa cd00c0        	call	_Enc28j60WritePhy
3488  01fd 85            	popw	x
3489                     ; 546   Enc28j60WritePhy(PHY_PHCON1, 0x0000);
3491  01fe 5f            	clrw	x
3492  01ff 89            	pushw	x
3493  0200 4f            	clr	a
3494  0201 cd00c0        	call	_Enc28j60WritePhy
3496  0204 85            	popw	x
3497                     ; 549   Enc28j60SetMaskReg(BANKX_ECON1, (1<<BANKX_ECON1_RXEN));
3499  0205 ae1f04        	ldw	x,#7940
3501                     ; 550 }
3504  0208 cc003f        	jp	_Enc28j60SetMaskReg
3562                     ; 553 uint16_t Enc28j60Receive(uint8_t* pBuffer)
3562                     ; 554 {
3563                     	switch	.text
3564  020b               _Enc28j60Receive:
3566  020b 89            	pushw	x
3567  020c 5204          	subw	sp,#4
3568       00000004      OFST:	set	4
3571                     ; 559   Enc28j60SwitchBank(BANK1);
3573  020e a601          	ld	a,#1
3574  0210 cd0069        	call	_Enc28j60SwitchBank
3576                     ; 560   if (Enc28j60ReadReg(BANK1_EPKTCNT) == 0) return 0;
3578  0213 a619          	ld	a,#25
3579  0215 cd000c        	call	_Enc28j60ReadReg
3581  0218 4d            	tnz	a
3582  0219 2604          	jrne	L7602
3585  021b 5f            	clrw	x
3587  021c cc02a4        	jra	L423
3588  021f               L7602:
3589                     ; 562   select();
3591  021f cd0000        	call	_select
3593                     ; 564   SpiWriteByte(OPCODE_RBM);
3595  0222 a63a          	ld	a,#58
3596  0224 cd0000        	call	_SpiWriteByte
3598                     ; 567   nNextPacket = ((uint16_t) SpiReadByte() << 0);
3600  0227 cd0000        	call	_SpiReadByte
3602  022a 5f            	clrw	x
3603  022b 97            	ld	xl,a
3604  022c 1f03          	ldw	(OFST-1,sp),x
3606                     ; 568   nNextPacket |= ((uint16_t) SpiReadByte() << 8);
3608  022e cd0000        	call	_SpiReadByte
3610  0231 5f            	clrw	x
3611  0232 97            	ld	xl,a
3612  0233 7b04          	ld	a,(OFST+0,sp)
3613  0235 01            	rrwa	x,a
3614  0236 1a03          	or	a,(OFST-1,sp)
3615  0238 01            	rrwa	x,a
3616  0239 1f03          	ldw	(OFST-1,sp),x
3618                     ; 571   nBytes = ((uint16_t) SpiReadByte() << 0);
3620  023b cd0000        	call	_SpiReadByte
3622  023e 5f            	clrw	x
3623  023f 97            	ld	xl,a
3624  0240 1f01          	ldw	(OFST-3,sp),x
3626                     ; 572   nBytes |= ((uint16_t) SpiReadByte() << 8);
3628  0242 cd0000        	call	_SpiReadByte
3630  0245 5f            	clrw	x
3631  0246 97            	ld	xl,a
3632  0247 7b02          	ld	a,(OFST-2,sp)
3633  0249 01            	rrwa	x,a
3634  024a 1a01          	or	a,(OFST-3,sp)
3635  024c 01            	rrwa	x,a
3637                     ; 573   nBytes -= 4;
3639  024d 1d0004        	subw	x,#4
3640  0250 1f01          	ldw	(OFST-3,sp),x
3642                     ; 576   SpiReadByte();
3644  0252 cd0000        	call	_SpiReadByte
3646                     ; 577   SpiReadByte();
3648  0255 cd0000        	call	_SpiReadByte
3650                     ; 600   if (nBytes <= ENC28J60_MAXFRAME) SpiReadChunk(pBuffer, nBytes);
3652  0258 1e01          	ldw	x,(OFST-3,sp)
3653  025a a30385        	cpw	x,#901
3654  025d 2407          	jruge	L1702
3657  025f 89            	pushw	x
3658  0260 1e07          	ldw	x,(OFST+3,sp)
3659  0262 cd0000        	call	_SpiReadChunk
3661  0265 85            	popw	x
3662  0266               L1702:
3663                     ; 602   deselect();
3665  0266 cd0006        	call	_deselect
3667                     ; 604   Enc28j60SwitchBank(BANK0);
3669  0269 4f            	clr	a
3670  026a cd0069        	call	_Enc28j60SwitchBank
3672                     ; 606   Enc28j60WriteReg(BANK0_ERDPTL , (uint8_t) (nNextPacket >> 0));
3674  026d 7b04          	ld	a,(OFST+0,sp)
3675  026f 5f            	clrw	x
3676  0270 97            	ld	xl,a
3677  0271 cd002a        	call	_Enc28j60WriteReg
3679                     ; 607   Enc28j60WriteReg(BANK0_ERDPTH , (uint8_t) (nNextPacket >> 8));
3681  0274 7b03          	ld	a,(OFST-1,sp)
3682  0276 ae0100        	ldw	x,#256
3683  0279 97            	ld	xl,a
3684  027a cd002a        	call	_Enc28j60WriteReg
3686                     ; 611   nNextPacket -= 1;
3688  027d 1e03          	ldw	x,(OFST-1,sp)
3689  027f 5a            	decw	x
3691                     ; 612   if (nNextPacket == ( ((uint16_t)ENC28J60_RXSTART) - 1 )) {
3693  0280 a3ffff        	cpw	x,#65535
3694  0283 2603          	jrne	L3702
3695                     ; 615     nNextPacket = ENC28J60_RXEND;
3697  0285 ae17ff        	ldw	x,#6143
3699  0288               L3702:
3700  0288 1f03          	ldw	(OFST-1,sp),x
3701                     ; 618   Enc28j60WriteReg(BANK0_ERXRDPTL, (uint8_t)(nNextPacket >> 0));
3703  028a ae0c00        	ldw	x,#3072
3704  028d 7b04          	ld	a,(OFST+0,sp)
3705  028f 97            	ld	xl,a
3706  0290 cd002a        	call	_Enc28j60WriteReg
3708                     ; 619   Enc28j60WriteReg(BANK0_ERXRDPTH, (uint8_t)(nNextPacket >> 8));
3710  0293 7b03          	ld	a,(OFST-1,sp)
3711  0295 ae0d00        	ldw	x,#3328
3712  0298 97            	ld	xl,a
3713  0299 cd002a        	call	_Enc28j60WriteReg
3715                     ; 622   Enc28j60SetMaskReg(BANKX_ECON2 , (1<<BANKX_ECON2_PKTDEC));
3717  029c ae1e40        	ldw	x,#7744
3718  029f cd003f        	call	_Enc28j60SetMaskReg
3720                     ; 624   return nBytes;
3722  02a2 1e01          	ldw	x,(OFST-3,sp)
3724  02a4               L423:
3726  02a4 5b06          	addw	sp,#6
3727  02a6 81            	ret	
3791                     ; 628 void Enc28j60CopyPacket(uint8_t* pBuffer, uint16_t nBytes)
3791                     ; 629 {
3792                     	switch	.text
3793  02a7               _Enc28j60CopyPacket:
3795  02a7 89            	pushw	x
3796  02a8 5203          	subw	sp,#3
3797       00000003      OFST:	set	3
3800                     ; 630   uint16_t TxEnd = ENC28J60_TXSTART + nBytes;
3802  02aa 1e08          	ldw	x,(OFST+5,sp)
3803  02ac 1c1800        	addw	x,#6144
3804  02af 1f01          	ldw	(OFST-2,sp),x
3806                     ; 631   uint8_t i = 200;
3808  02b1 a6c8          	ld	a,#200
3809  02b3 6b03          	ld	(OFST+0,sp),a
3812  02b5 204e          	jra	L5212
3813  02b7               L1212:
3814                     ; 637     if (!(Enc28j60ReadReg(BANKX_ECON1) & (1<<BANKX_ECON1_TXRTS))) break;
3816  02b7 a61f          	ld	a,#31
3817  02b9 cd000c        	call	_Enc28j60ReadReg
3819  02bc a508          	bcp	a,#8
3820  02be 263d          	jrne	L1312
3822  02c0               L7212:
3823                     ; 641   Enc28j60SwitchBank(BANK0);
3825  02c0 4f            	clr	a
3826  02c1 cd0069        	call	_Enc28j60SwitchBank
3828                     ; 643   Enc28j60WriteReg(BANK0_EWRPTL, (uint8_t) (ENC28J60_TXSTART >> 0));
3830  02c4 ae0200        	ldw	x,#512
3831  02c7 cd002a        	call	_Enc28j60WriteReg
3833                     ; 644   Enc28j60WriteReg(BANK0_EWRPTH, (uint8_t) (ENC28J60_TXSTART >> 8));
3835  02ca ae0318        	ldw	x,#792
3836  02cd cd002a        	call	_Enc28j60WriteReg
3838                     ; 645   Enc28j60WriteReg(BANK0_ETXNDL, (uint8_t) (TxEnd >> 0));
3840  02d0 7b02          	ld	a,(OFST-1,sp)
3841  02d2 ae0600        	ldw	x,#1536
3842  02d5 97            	ld	xl,a
3843  02d6 cd002a        	call	_Enc28j60WriteReg
3845                     ; 646   Enc28j60WriteReg(BANK0_ETXNDH, (uint8_t) (TxEnd >> 8));	
3847  02d9 7b01          	ld	a,(OFST-2,sp)
3848  02db ae0700        	ldw	x,#1792
3849  02de 97            	ld	xl,a
3850  02df cd002a        	call	_Enc28j60WriteReg
3852                     ; 648   select();
3854  02e2 cd0000        	call	_select
3856                     ; 650   SpiWriteByte(OPCODE_WBM);	 // Set ENC28J60 to receive transmit data
3858  02e5 a67a          	ld	a,#122
3859  02e7 cd0000        	call	_SpiWriteByte
3861                     ; 652   SpiWriteByte(0);		 // Per-packet-control-byte
3863  02ea 4f            	clr	a
3864  02eb cd0000        	call	_SpiWriteByte
3866                     ; 664   SpiWriteChunk(pBuffer, nBytes); // Copy data to the ENC28J60 transmit buffer
3868  02ee 1e08          	ldw	x,(OFST+5,sp)
3869  02f0 89            	pushw	x
3870  02f1 1e06          	ldw	x,(OFST+3,sp)
3871  02f3 cd0000        	call	_SpiWriteChunk
3873  02f6 85            	popw	x
3874                     ; 666   deselect();
3876  02f7 cd0006        	call	_deselect
3878                     ; 667 }
3881  02fa 5b05          	addw	sp,#5
3882  02fc 81            	ret	
3883  02fd               L1312:
3884                     ; 638     wait_timer(500);  // Wait 500 uS
3886  02fd ae01f4        	ldw	x,#500
3887  0300 cd0000        	call	_wait_timer
3889  0303 7b03          	ld	a,(OFST+0,sp)
3890  0305               L5212:
3891                     ; 636   while (i--) {
3893  0305 0a03          	dec	(OFST+0,sp)
3895  0307 4d            	tnz	a
3896  0308 26ad          	jrne	L1212
3897  030a 20b4          	jra	L7212
3922                     ; 670 void Enc28j60Send(void)
3922                     ; 671 {
3923                     	switch	.text
3924  030c               _Enc28j60Send:
3928                     ; 673   Enc28j60SetMaskReg(BANKX_ECON1, (1<<BANKX_ECON1_TXRST));
3930  030c ae1f80        	ldw	x,#8064
3931  030f cd003f        	call	_Enc28j60SetMaskReg
3933                     ; 674   Enc28j60ClearMaskReg(BANKX_ECON1, (1<<BANKX_ECON1_TXRST));
3935  0312 ae1f80        	ldw	x,#8064
3936  0315 cd0054        	call	_Enc28j60ClearMaskReg
3938                     ; 677   Enc28j60SetMaskReg(BANKX_ECON1, (1<<BANKX_ECON1_TXRTS));
3940  0318 ae1f08        	ldw	x,#7944
3942                     ; 678 }
3945  031b cc003f        	jp	_Enc28j60SetMaskReg
3958                     	xdef	_Enc28j60WritePhy
3959                     	xdef	_Enc28j60ReadPhy
3960                     	xdef	_Enc28j60SwitchBank
3961                     	xdef	_Enc28j60ClearMaskReg
3962                     	xdef	_Enc28j60SetMaskReg
3963                     	xdef	_Enc28j60WriteReg
3964                     	xdef	_Enc28j60ReadReg
3965                     	xdef	_deselect
3966                     	xdef	_select
3967                     	xref	_uip_ethaddr6
3968                     	xref	_uip_ethaddr5
3969                     	xref	_uip_ethaddr4
3970                     	xref	_uip_ethaddr3
3971                     	xref	_uip_ethaddr2
3972                     	xref	_uip_ethaddr1
3973                     	xref	_wait_timer
3974                     	xdef	_Enc28j60Send
3975                     	xdef	_Enc28j60CopyPacket
3976                     	xdef	_Enc28j60Receive
3977                     	xdef	_Enc28j60Init
3978                     	xref	_SpiReadChunk
3979                     	xref	_SpiReadByte
3980                     	xref	_SpiWriteChunk
3981                     	xref	_SpiWriteByte
4000                     	end
