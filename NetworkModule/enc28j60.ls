   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Parser V4.11.14 - 18 Nov 2019
   3                     ; Generator (Limited) V4.4.11 - 19 Nov 2019
   4                     ; Optimizer V4.4.11 - 19 Nov 2019
2547                     ; 261 void select(void)
2547                     ; 262 {
2549                     .text:	section	.text,new
2550  0000               _select:
2554                     ; 264   PC_ODR &= (uint8_t)(~0x02);
2556  0000 7213500a      	bres	_PC_ODR,#1
2557                     ; 265   nop();
2560  0004 9d            	nop	
2562                     ; 266 }
2566  0005 81            	ret	
2591                     ; 269 void deselect(void)
2591                     ; 270 {
2592                     .text:	section	.text,new
2593  0000               _deselect:
2597                     ; 272   PC_ODR |= (uint8_t)0x02;
2599  0000 7212500a      	bset	_PC_ODR,#1
2600                     ; 273   nop();
2603  0004 9d            	nop	
2605                     ; 274 }
2609  0005 81            	ret	
2652                     ; 279 uint8_t Enc28j60ReadReg(uint8_t nRegister)
2652                     ; 280 {
2653                     .text:	section	.text,new
2654  0000               _Enc28j60ReadReg:
2656  0000 88            	push	a
2657  0001 88            	push	a
2658       00000001      OFST:	set	1
2661                     ; 283   select();
2663  0002 cd0000        	call	_select
2665                     ; 285   SpiWriteByte((uint8_t)(OPCODE_RCR | (nRegister & REGISTER_MASK)));
2667  0005 7b02          	ld	a,(OFST+1,sp)
2668  0007 a41f          	and	a,#31
2669  0009 cd0000        	call	_SpiWriteByte
2671                     ; 286   if (nRegister & REGISTER_NEEDDUMMY) SpiWriteByte(0);
2673  000c 7b02          	ld	a,(OFST+1,sp)
2674  000e 2a04          	jrpl	L1761
2677  0010 4f            	clr	a
2678  0011 cd0000        	call	_SpiWriteByte
2680  0014               L1761:
2681                     ; 287   nByte = SpiReadByte();
2683  0014 cd0000        	call	_SpiReadByte
2685  0017 6b01          	ld	(OFST+0,sp),a
2687                     ; 289   deselect();
2689  0019 cd0000        	call	_deselect
2691                     ; 291   return nByte;
2693  001c 7b01          	ld	a,(OFST+0,sp)
2696  001e 85            	popw	x
2697  001f 81            	ret	
2739                     ; 297 void Enc28j60WriteReg( uint8_t nRegister, uint8_t nData)
2739                     ; 298 {
2740                     .text:	section	.text,new
2741  0000               _Enc28j60WriteReg:
2743  0000 89            	pushw	x
2744       00000000      OFST:	set	0
2747                     ; 299   select();
2749  0001 cd0000        	call	_select
2751                     ; 301   SpiWriteByte((uint8_t)(OPCODE_WCR | (nRegister & REGISTER_MASK)));
2753  0004 7b01          	ld	a,(OFST+1,sp)
2754  0006 a41f          	and	a,#31
2755  0008 aa40          	or	a,#64
2756  000a cd0000        	call	_SpiWriteByte
2758                     ; 302   SpiWriteByte(nData);
2760  000d 7b02          	ld	a,(OFST+2,sp)
2761  000f cd0000        	call	_SpiWriteByte
2763                     ; 304   deselect();
2765  0012 cd0000        	call	_deselect
2767                     ; 305 }
2770  0015 85            	popw	x
2771  0016 81            	ret	
2813                     ; 310 void Enc28j60SetMaskReg(uint8_t nRegister, uint8_t nMask)
2813                     ; 311 {
2814                     .text:	section	.text,new
2815  0000               _Enc28j60SetMaskReg:
2817  0000 89            	pushw	x
2818       00000000      OFST:	set	0
2821                     ; 312   select();
2823  0001 cd0000        	call	_select
2825                     ; 314   SpiWriteByte((uint8_t)(OPCODE_BFS | (nRegister & REGISTER_MASK)));
2827  0004 7b01          	ld	a,(OFST+1,sp)
2828  0006 a41f          	and	a,#31
2829  0008 aa80          	or	a,#128
2830  000a cd0000        	call	_SpiWriteByte
2832                     ; 315   SpiWriteByte(nMask);
2834  000d 7b02          	ld	a,(OFST+2,sp)
2835  000f cd0000        	call	_SpiWriteByte
2837                     ; 317   deselect();
2839  0012 cd0000        	call	_deselect
2841                     ; 318 }
2844  0015 85            	popw	x
2845  0016 81            	ret	
2888                     ; 323 void Enc28j60ClearMaskReg( uint8_t nRegister, uint8_t nMask)
2888                     ; 324 {
2889                     .text:	section	.text,new
2890  0000               _Enc28j60ClearMaskReg:
2892  0000 89            	pushw	x
2893       00000000      OFST:	set	0
2896                     ; 325   select();
2898  0001 cd0000        	call	_select
2900                     ; 327   SpiWriteByte((uint8_t)(OPCODE_BFC | (nRegister & REGISTER_MASK)));
2902  0004 7b01          	ld	a,(OFST+1,sp)
2903  0006 a41f          	and	a,#31
2904  0008 aaa0          	or	a,#160
2905  000a cd0000        	call	_SpiWriteByte
2907                     ; 328   SpiWriteByte(nMask);
2909  000d 7b02          	ld	a,(OFST+2,sp)
2910  000f cd0000        	call	_SpiWriteByte
2912                     ; 330   deselect();
2914  0012 cd0000        	call	_deselect
2916                     ; 331 }
2919  0015 85            	popw	x
2920  0016 81            	ret	
2954                     ; 336 void Enc28j60SwitchBank(uint8_t nBank)
2954                     ; 337 {
2955                     .text:	section	.text,new
2956  0000               _Enc28j60SwitchBank:
2958  0000 88            	push	a
2959       00000000      OFST:	set	0
2962                     ; 341   Enc28j60ClearMaskReg(BANKX_ECON1, (3<<BANKX_ECON1_BSEL0));
2964  0001 ae1f03        	ldw	x,#7939
2965  0004 cd0000        	call	_Enc28j60ClearMaskReg
2967                     ; 342   Enc28j60SetMaskReg(BANKX_ECON1, (uint8_t)(nBank << BANKX_ECON1_BSEL0));
2969  0007 7b01          	ld	a,(OFST+1,sp)
2970  0009 ae1f00        	ldw	x,#7936
2971  000c 97            	ld	xl,a
2972  000d cd0000        	call	_Enc28j60SetMaskReg
2974                     ; 343 }
2977  0010 84            	pop	a
2978  0011 81            	ret	
3016                     ; 349 uint16_t Enc28j60ReadPhy(uint8_t nRegister)
3016                     ; 350 {
3017                     .text:	section	.text,new
3018  0000               _Enc28j60ReadPhy:
3020  0000 88            	push	a
3021  0001 89            	pushw	x
3022       00000002      OFST:	set	2
3025                     ; 351   Enc28j60SwitchBank(BANK2);
3027  0002 a602          	ld	a,#2
3028  0004 cd0000        	call	_Enc28j60SwitchBank
3030                     ; 352   Enc28j60WriteReg(BANK2_MIREGADR, nRegister);
3032  0007 7b03          	ld	a,(OFST+1,sp)
3033  0009 ae9400        	ldw	x,#37888
3034  000c 97            	ld	xl,a
3035  000d cd0000        	call	_Enc28j60WriteReg
3037                     ; 353   Enc28j60SetMaskReg(BANK2_MICMD, (1<<BANK2_MICMD_MIIRD));
3039  0010 ae9201        	ldw	x,#37377
3040  0013 cd0000        	call	_Enc28j60SetMaskReg
3042                     ; 354   Enc28j60SwitchBank(BANK3);
3044  0016 a603          	ld	a,#3
3045  0018 cd0000        	call	_Enc28j60SwitchBank
3048  001b 2001          	jra	L7771
3049  001d               L5771:
3050                     ; 355   while (Enc28j60ReadReg(BANK3_MISTAT) & (1 <<BANK3_MISTAT_BUSY)) nop();
3053  001d 9d            	nop	
3055  001e               L7771:
3058  001e a68a          	ld	a,#138
3059  0020 cd0000        	call	_Enc28j60ReadReg
3061  0023 a501          	bcp	a,#1
3062  0025 26f6          	jrne	L5771
3063                     ; 356   Enc28j60SwitchBank(BANK2);
3066  0027 a602          	ld	a,#2
3067  0029 cd0000        	call	_Enc28j60SwitchBank
3069                     ; 357   Enc28j60ClearMaskReg(BANK2_MICMD, (1<<BANK2_MICMD_MIIRD));
3071  002c ae9201        	ldw	x,#37377
3072  002f cd0000        	call	_Enc28j60ClearMaskReg
3074                     ; 359   return ((uint16_t) Enc28j60ReadReg(BANK2_MIRDL) << 0)
3074                     ; 360        | ((uint16_t) Enc28j60ReadReg(BANK2_MIRDH) << 8);
3076  0032 a699          	ld	a,#153
3077  0034 cd0000        	call	_Enc28j60ReadReg
3079  0037 97            	ld	xl,a
3080  0038 4f            	clr	a
3081  0039 02            	rlwa	x,a
3082  003a 1f01          	ldw	(OFST-1,sp),x
3084  003c a698          	ld	a,#152
3085  003e cd0000        	call	_Enc28j60ReadReg
3087  0041 5f            	clrw	x
3088  0042 97            	ld	xl,a
3089  0043 01            	rrwa	x,a
3090  0044 1a02          	or	a,(OFST+0,sp)
3091  0046 01            	rrwa	x,a
3092  0047 1a01          	or	a,(OFST-1,sp)
3093  0049 01            	rrwa	x,a
3096  004a 5b03          	addw	sp,#3
3097  004c 81            	ret	
3140                     ; 367 void Enc28j60WritePhy( uint8_t nRegister, uint16_t nData)
3140                     ; 368 {
3141                     .text:	section	.text,new
3142  0000               _Enc28j60WritePhy:
3144  0000 88            	push	a
3145       00000000      OFST:	set	0
3148                     ; 369   Enc28j60SwitchBank(BANK2);
3150  0001 a602          	ld	a,#2
3151  0003 cd0000        	call	_Enc28j60SwitchBank
3153                     ; 370   Enc28j60WriteReg(BANK2_MIREGADR, nRegister);
3155  0006 7b01          	ld	a,(OFST+1,sp)
3156  0008 ae9400        	ldw	x,#37888
3157  000b 97            	ld	xl,a
3158  000c cd0000        	call	_Enc28j60WriteReg
3160                     ; 371   Enc28j60WriteReg(BANK2_MIWRL, (uint8_t)(nData >> 0));
3162  000f 7b05          	ld	a,(OFST+5,sp)
3163  0011 ae9600        	ldw	x,#38400
3164  0014 97            	ld	xl,a
3165  0015 cd0000        	call	_Enc28j60WriteReg
3167                     ; 372   Enc28j60WriteReg(BANK2_MIWRH, (uint8_t)(nData >> 8));
3169  0018 7b04          	ld	a,(OFST+4,sp)
3170  001a ae9700        	ldw	x,#38656
3171  001d 97            	ld	xl,a
3172  001e cd0000        	call	_Enc28j60WriteReg
3174                     ; 373   Enc28j60SwitchBank(BANK3);
3176  0021 a603          	ld	a,#3
3177  0023 cd0000        	call	_Enc28j60SwitchBank
3180  0026 2001          	jra	L3202
3181  0028               L1202:
3182                     ; 374   while (Enc28j60ReadReg(BANK3_MISTAT) & (1 <<BANK3_MISTAT_BUSY)) nop();
3185  0028 9d            	nop	
3187  0029               L3202:
3190  0029 a68a          	ld	a,#138
3191  002b cd0000        	call	_Enc28j60ReadReg
3193  002e a501          	bcp	a,#1
3194  0030 26f6          	jrne	L1202
3195                     ; 375 }
3199  0032 84            	pop	a
3200  0033 81            	ret	
3237                     ; 378 void Enc28j60Init(void)
3237                     ; 379 {
3238                     .text:	section	.text,new
3239  0000               _Enc28j60Init:
3243                     ; 383   deselect(); // Just makes sure the -CS is not selected
3245  0000 cd0000        	call	_deselect
3248  0003 2001          	jra	L1402
3249  0005               L7302:
3250                     ; 397   while (!(Enc28j60ReadReg(BANKX_ESTAT) & (1<<BANKX_ESTAT_CLKRDY))) nop();
3253  0005 9d            	nop	
3255  0006               L1402:
3258  0006 a61d          	ld	a,#29
3259  0008 cd0000        	call	_Enc28j60ReadReg
3261  000b a501          	bcp	a,#1
3262  000d 27f6          	jreq	L7302
3263                     ; 400   select();
3266  000f cd0000        	call	_select
3268                     ; 401   SpiWriteByte(OPCODE_SRC); // Reset command
3270  0012 a6ff          	ld	a,#255
3271  0014 cd0000        	call	_SpiWriteByte
3273                     ; 402   deselect();
3275  0017 cd0000        	call	_deselect
3277                     ; 410   wait_timer((uint16_t)10000); // delay 10 ms
3279  001a ae2710        	ldw	x,#10000
3280  001d cd0000        	call	_wait_timer
3282                     ; 413   Enc28j60WritePhy(PHY_PHCON1, (uint16_t)(1<<PHY_PHCON1_PRST)); // Reset command
3284  0020 ae8000        	ldw	x,#32768
3285  0023 89            	pushw	x
3286  0024 4f            	clr	a
3287  0025 cd0000        	call	_Enc28j60WritePhy
3289  0028 85            	popw	x
3291  0029 2001          	jra	L7402
3292  002b               L5402:
3293                     ; 415   while (Enc28j60ReadPhy(PHY_PHCON1) & (uint16_t)(1<<PHY_PHCON1_PRST)) nop();
3296  002b 9d            	nop	
3298  002c               L7402:
3301  002c 4f            	clr	a
3302  002d cd0000        	call	_Enc28j60ReadPhy
3304  0030 01            	rrwa	x,a
3305  0031 9f            	ld	a,xl
3306  0032 a480          	and	a,#128
3307  0034 97            	ld	xl,a
3308  0035 4f            	clr	a
3309  0036 02            	rlwa	x,a
3310  0037 5d            	tnzw	x
3311  0038 26f1          	jrne	L5402
3312                     ; 419   if (stored_config_settings[3] == '1') {
3315  003a c60003        	ld	a,_stored_config_settings+3
3316  003d a131          	cp	a,#49
3317  003f 2609          	jrne	L3502
3318                     ; 422     Enc28j60WritePhy(PHY_PHCON1, (uint16_t)(1<<PHY_PHCON1_PDPXMD));
3320  0041 ae0100        	ldw	x,#256
3321  0044 89            	pushw	x
3322  0045 4f            	clr	a
3323  0046 cd0000        	call	_Enc28j60WritePhy
3325  0049 85            	popw	x
3326  004a               L3502:
3327                     ; 427   Enc28j60SwitchBank(BANK0);
3329  004a 4f            	clr	a
3330  004b cd0000        	call	_Enc28j60SwitchBank
3332                     ; 431   Enc28j60WriteReg(BANK0_ERXSTL, (uint8_t) (ENC28J60_RXSTART >> 0));
3334  004e ae0800        	ldw	x,#2048
3335  0051 cd0000        	call	_Enc28j60WriteReg
3337                     ; 432   Enc28j60WriteReg(BANK0_ERXSTH, (uint8_t) (ENC28J60_RXSTART >> 8));
3339  0054 ae0900        	ldw	x,#2304
3340  0057 cd0000        	call	_Enc28j60WriteReg
3342                     ; 433   Enc28j60WriteReg(BANK0_ERXNDL, (uint8_t) (ENC28J60_RXEND >> 0));
3344  005a ae0aff        	ldw	x,#2815
3345  005d cd0000        	call	_Enc28j60WriteReg
3347                     ; 434   Enc28j60WriteReg(BANK0_ERXNDH, (uint8_t) (ENC28J60_RXEND >> 8));
3349  0060 ae0b17        	ldw	x,#2839
3350  0063 cd0000        	call	_Enc28j60WriteReg
3352                     ; 436   Enc28j60WriteReg(BANK0_ERDPTL, (uint8_t) (ENC28J60_RXSTART >> 0));
3354  0066 5f            	clrw	x
3355  0067 cd0000        	call	_Enc28j60WriteReg
3357                     ; 437   Enc28j60WriteReg(BANK0_ERDPTH, (uint8_t) (ENC28J60_RXSTART >> 8));
3359  006a ae0100        	ldw	x,#256
3360  006d cd0000        	call	_Enc28j60WriteReg
3362                     ; 440   Enc28j60WriteReg(BANK0_ERXRDPTL, (uint8_t) (ENC28J60_RXEND >> 0));
3364  0070 ae0cff        	ldw	x,#3327
3365  0073 cd0000        	call	_Enc28j60WriteReg
3367                     ; 441   Enc28j60WriteReg(BANK0_ERXRDPTH, (uint8_t) (ENC28J60_RXEND >> 8));
3369  0076 ae0d17        	ldw	x,#3351
3370  0079 cd0000        	call	_Enc28j60WriteReg
3372                     ; 443   Enc28j60WriteReg(BANK0_ETXSTL, (uint8_t) (ENC28J60_TXSTART >> 0));
3374  007c ae0400        	ldw	x,#1024
3375  007f cd0000        	call	_Enc28j60WriteReg
3377                     ; 444   Enc28j60WriteReg(BANK0_ETXSTH, (uint8_t) (ENC28J60_TXSTART >> 8));
3379  0082 ae0518        	ldw	x,#1304
3380  0085 cd0000        	call	_Enc28j60WriteReg
3382                     ; 449   Enc28j60SwitchBank(BANK1);
3384  0088 a601          	ld	a,#1
3385  008a cd0000        	call	_Enc28j60SwitchBank
3387                     ; 496   Enc28j60WriteReg(BANK1_ERXFCON, (uint8_t)0xa1);    // Allows packets if MAC matches
3389  008d ae18a1        	ldw	x,#6305
3390  0090 cd0000        	call	_Enc28j60WriteReg
3392                     ; 515   Enc28j60SwitchBank(BANK2);
3394  0093 a602          	ld	a,#2
3395  0095 cd0000        	call	_Enc28j60SwitchBank
3397                     ; 518   Enc28j60WriteReg(BANK2_MACON1, (1<<BANK2_MACON1_MARXEN));
3399  0098 ae8001        	ldw	x,#32769
3400  009b cd0000        	call	_Enc28j60WriteReg
3402                     ; 541   if (stored_config_settings[3] == '0') {
3404  009e c60003        	ld	a,_stored_config_settings+3
3405  00a1 a130          	cp	a,#48
3406  00a3 2609          	jrne	L5502
3407                     ; 543     Enc28j60SetMaskReg(BANK2_MACON3, (1<<BANK2_MACON3_TXCRCEN)|(1<<BANK2_MACON3_PADCFG0)|(1<<BANK2_MACON3_FRMLNEN));
3409  00a5 ae8232        	ldw	x,#33330
3410  00a8 cd0000        	call	_Enc28j60SetMaskReg
3412  00ab c60003        	ld	a,_stored_config_settings+3
3413  00ae               L5502:
3414                     ; 545   if (stored_config_settings[3] == '1') {
3416  00ae a131          	cp	a,#49
3417  00b0 2606          	jrne	L7502
3418                     ; 548     Enc28j60SetMaskReg(BANK2_MACON3, (1<<BANK2_MACON3_TXCRCEN) | (1<<BANK2_MACON3_PADCFG0) | (1<<BANK2_MACON3_FRMLNEN) | (1<<BANK2_MACON3_FULDPX));
3420  00b2 ae8233        	ldw	x,#33331
3421  00b5 cd0000        	call	_Enc28j60SetMaskReg
3423  00b8               L7502:
3424                     ; 552   Enc28j60SetMaskReg(BANK2_MACON4, (1<<BANK2_MACON4_DEFER));
3426  00b8 ae8340        	ldw	x,#33600
3427  00bb cd0000        	call	_Enc28j60SetMaskReg
3429                     ; 556   Enc28j60WriteReg(BANK2_MAMXFLL, (uint8_t) ((ENC28J60_MAXFRAME + 4) >> 0));
3431  00be ae8af8        	ldw	x,#35576
3432  00c1 cd0000        	call	_Enc28j60WriteReg
3434                     ; 557   Enc28j60WriteReg(BANK2_MAMXFLH, (uint8_t) ((ENC28J60_MAXFRAME + 4) >> 8));
3436  00c4 ae9001        	ldw	x,#36865
3437  00c7 cd0000        	call	_Enc28j60WriteReg
3439                     ; 560   Enc28j60WriteReg(BANK2_MAIPGL, 0x12);
3441  00ca ae8612        	ldw	x,#34322
3442  00cd cd0000        	call	_Enc28j60WriteReg
3444                     ; 562   if (stored_config_settings[3] == '0') {
3446  00d0 c60003        	ld	a,_stored_config_settings+3
3447  00d3 a130          	cp	a,#48
3448  00d5 2609          	jrne	L1602
3449                     ; 564     Enc28j60WriteReg(BANK2_MAIPGH, 0x0C);
3451  00d7 ae870c        	ldw	x,#34572
3452  00da cd0000        	call	_Enc28j60WriteReg
3454  00dd c60003        	ld	a,_stored_config_settings+3
3455  00e0               L1602:
3456                     ; 571   if (stored_config_settings[3] == '0') {
3458  00e0 a130          	cp	a,#48
3459  00e2 2609          	jrne	L3602
3460                     ; 573     Enc28j60WriteReg(BANK2_MABBIPG, 0x12);
3462  00e4 ae8412        	ldw	x,#33810
3463  00e7 cd0000        	call	_Enc28j60WriteReg
3465  00ea c60003        	ld	a,_stored_config_settings+3
3466  00ed               L3602:
3467                     ; 575   if (stored_config_settings[3] == '1') {
3469  00ed a131          	cp	a,#49
3470  00ef 2606          	jrne	L5602
3471                     ; 577     Enc28j60WriteReg(BANK2_MABBIPG, 0x15);
3473  00f1 ae8415        	ldw	x,#33813
3474  00f4 cd0000        	call	_Enc28j60WriteReg
3476  00f7               L5602:
3477                     ; 582   Enc28j60SwitchBank(BANK3);
3479  00f7 a603          	ld	a,#3
3480  00f9 cd0000        	call	_Enc28j60SwitchBank
3482                     ; 585   Enc28j60WriteReg(BANK3_MAADR5, stored_uip_ethaddr_oct[5]);  // MAC MSB
3484  00fc c60005        	ld	a,_stored_uip_ethaddr_oct+5
3485  00ff ae8400        	ldw	x,#33792
3486  0102 97            	ld	xl,a
3487  0103 cd0000        	call	_Enc28j60WriteReg
3489                     ; 586   Enc28j60WriteReg(BANK3_MAADR4, stored_uip_ethaddr_oct[4]);
3491  0106 c60004        	ld	a,_stored_uip_ethaddr_oct+4
3492  0109 ae8500        	ldw	x,#34048
3493  010c 97            	ld	xl,a
3494  010d cd0000        	call	_Enc28j60WriteReg
3496                     ; 587   Enc28j60WriteReg(BANK3_MAADR3, stored_uip_ethaddr_oct[3]);
3498  0110 c60003        	ld	a,_stored_uip_ethaddr_oct+3
3499  0113 ae8200        	ldw	x,#33280
3500  0116 97            	ld	xl,a
3501  0117 cd0000        	call	_Enc28j60WriteReg
3503                     ; 588   Enc28j60WriteReg(BANK3_MAADR2, stored_uip_ethaddr_oct[2]);
3505  011a c60002        	ld	a,_stored_uip_ethaddr_oct+2
3506  011d ae8300        	ldw	x,#33536
3507  0120 97            	ld	xl,a
3508  0121 cd0000        	call	_Enc28j60WriteReg
3510                     ; 589   Enc28j60WriteReg(BANK3_MAADR1, stored_uip_ethaddr_oct[1]);
3512  0124 c60001        	ld	a,_stored_uip_ethaddr_oct+1
3513  0127 ae8000        	ldw	x,#32768
3514  012a 97            	ld	xl,a
3515  012b cd0000        	call	_Enc28j60WriteReg
3517                     ; 590   Enc28j60WriteReg(BANK3_MAADR0, stored_uip_ethaddr_oct[0]);  // MAC LSB
3519  012e c60000        	ld	a,_stored_uip_ethaddr_oct
3520  0131 ae8100        	ldw	x,#33024
3521  0134 97            	ld	xl,a
3522  0135 cd0000        	call	_Enc28j60WriteReg
3524                     ; 593   Enc28j60WritePhy(PHY_PHCON2, (1<<PHY_PHCON2_HDLDIS));
3526  0138 ae0100        	ldw	x,#256
3527  013b 89            	pushw	x
3528  013c a610          	ld	a,#16
3529  013e cd0000        	call	_Enc28j60WritePhy
3531  0141 85            	popw	x
3532                     ; 597   Enc28j60WritePhy(PHY_PHLCON,
3532                     ; 598     (ENC28J60_LEDB<<PHY_PHLCON_LBCFG0)|
3532                     ; 599     (ENC28J60_LEDA<<PHY_PHLCON_LACFG0)|
3532                     ; 600     (1<<PHY_PHLCON_STRCH)|0x3000);
3534  0142 ae31c2        	ldw	x,#12738
3535  0145 89            	pushw	x
3536  0146 a614          	ld	a,#20
3537  0148 cd0000        	call	_Enc28j60WritePhy
3539  014b c60003        	ld	a,_stored_config_settings+3
3540  014e a130          	cp	a,#48
3541  0150 85            	popw	x
3542                     ; 602   if (stored_config_settings[3] == '0') {
3544  0151 2607          	jrne	L7602
3545                     ; 607     Enc28j60WritePhy(PHY_PHCON1, 0x0000);
3547  0153 5f            	clrw	x
3548  0154 89            	pushw	x
3549  0155 4f            	clr	a
3550  0156 cd0000        	call	_Enc28j60WritePhy
3552  0159 85            	popw	x
3553  015a               L7602:
3554                     ; 611   Enc28j60SetMaskReg(BANKX_ECON1, (1<<BANKX_ECON1_RXEN));
3556  015a ae1f04        	ldw	x,#7940
3558                     ; 612 }
3561  015d cc0000        	jp	_Enc28j60SetMaskReg
3619                     ; 615 uint16_t Enc28j60Receive(uint8_t* pBuffer)
3619                     ; 616 {
3620                     .text:	section	.text,new
3621  0000               _Enc28j60Receive:
3623  0000 89            	pushw	x
3624  0001 5204          	subw	sp,#4
3625       00000004      OFST:	set	4
3628                     ; 621   Enc28j60SwitchBank(BANK1);
3630  0003 a601          	ld	a,#1
3631  0005 cd0000        	call	_Enc28j60SwitchBank
3633                     ; 622   if (Enc28j60ReadReg(BANK1_EPKTCNT) == 0) return 0;
3635  0008 a619          	ld	a,#25
3636  000a cd0000        	call	_Enc28j60ReadReg
3638  000d 4d            	tnz	a
3639  000e 2604          	jrne	L3112
3642  0010 5f            	clrw	x
3644  0011 cc0099        	jra	L233
3645  0014               L3112:
3646                     ; 624   select();
3648  0014 cd0000        	call	_select
3650                     ; 626   SpiWriteByte(OPCODE_RBM);	 // Set ENC28J60 to send receive data on SPI
3652  0017 a63a          	ld	a,#58
3653  0019 cd0000        	call	_SpiWriteByte
3655                     ; 629   nNextPacket = ((uint16_t) SpiReadByte() << 0);
3657  001c cd0000        	call	_SpiReadByte
3659  001f 5f            	clrw	x
3660  0020 97            	ld	xl,a
3661  0021 1f03          	ldw	(OFST-1,sp),x
3663                     ; 630   nNextPacket |= ((uint16_t) SpiReadByte() << 8);
3665  0023 cd0000        	call	_SpiReadByte
3667  0026 5f            	clrw	x
3668  0027 97            	ld	xl,a
3669  0028 7b04          	ld	a,(OFST+0,sp)
3670  002a 01            	rrwa	x,a
3671  002b 1a03          	or	a,(OFST-1,sp)
3672  002d 01            	rrwa	x,a
3673  002e 1f03          	ldw	(OFST-1,sp),x
3675                     ; 633   nBytes = ((uint16_t) SpiReadByte() << 0);
3677  0030 cd0000        	call	_SpiReadByte
3679  0033 5f            	clrw	x
3680  0034 97            	ld	xl,a
3681  0035 1f01          	ldw	(OFST-3,sp),x
3683                     ; 634   nBytes |= ((uint16_t) SpiReadByte() << 8);
3685  0037 cd0000        	call	_SpiReadByte
3687  003a 5f            	clrw	x
3688  003b 97            	ld	xl,a
3689  003c 7b02          	ld	a,(OFST-2,sp)
3690  003e 01            	rrwa	x,a
3691  003f 1a01          	or	a,(OFST-3,sp)
3692  0041 01            	rrwa	x,a
3694                     ; 635   nBytes -= 4;
3696  0042 1d0004        	subw	x,#4
3697  0045 1f01          	ldw	(OFST-3,sp),x
3699                     ; 638   SpiReadByte();
3701  0047 cd0000        	call	_SpiReadByte
3703                     ; 639   SpiReadByte();
3705  004a cd0000        	call	_SpiReadByte
3707                     ; 646   if (nBytes <= ENC28J60_MAXFRAME) SpiReadChunk(pBuffer, nBytes);
3709  004d 1e01          	ldw	x,(OFST-3,sp)
3710  004f a301f5        	cpw	x,#501
3711  0052 2407          	jruge	L5112
3714  0054 89            	pushw	x
3715  0055 1e07          	ldw	x,(OFST+3,sp)
3716  0057 cd0000        	call	_SpiReadChunk
3718  005a 85            	popw	x
3719  005b               L5112:
3720                     ; 648   deselect();
3722  005b cd0000        	call	_deselect
3724                     ; 650   Enc28j60SwitchBank(BANK0);
3726  005e 4f            	clr	a
3727  005f cd0000        	call	_Enc28j60SwitchBank
3729                     ; 652   Enc28j60WriteReg(BANK0_ERDPTL , (uint8_t) (nNextPacket >> 0));
3731  0062 7b04          	ld	a,(OFST+0,sp)
3732  0064 5f            	clrw	x
3733  0065 97            	ld	xl,a
3734  0066 cd0000        	call	_Enc28j60WriteReg
3736                     ; 653   Enc28j60WriteReg(BANK0_ERDPTH , (uint8_t) (nNextPacket >> 8));
3738  0069 7b03          	ld	a,(OFST-1,sp)
3739  006b ae0100        	ldw	x,#256
3740  006e 97            	ld	xl,a
3741  006f cd0000        	call	_Enc28j60WriteReg
3743                     ; 657   nNextPacket -= 1;
3745  0072 1e03          	ldw	x,(OFST-1,sp)
3746  0074 5a            	decw	x
3748                     ; 658   if (nNextPacket == ( ((uint16_t)ENC28J60_RXSTART) - 1 )) {
3750  0075 a3ffff        	cpw	x,#65535
3751  0078 2603          	jrne	L7112
3752                     ; 661     nNextPacket = ENC28J60_RXEND;
3754  007a ae17ff        	ldw	x,#6143
3756  007d               L7112:
3757  007d 1f03          	ldw	(OFST-1,sp),x
3758                     ; 664   Enc28j60WriteReg(BANK0_ERXRDPTL, (uint8_t)(nNextPacket >> 0));
3760  007f ae0c00        	ldw	x,#3072
3761  0082 7b04          	ld	a,(OFST+0,sp)
3762  0084 97            	ld	xl,a
3763  0085 cd0000        	call	_Enc28j60WriteReg
3765                     ; 665   Enc28j60WriteReg(BANK0_ERXRDPTH, (uint8_t)(nNextPacket >> 8));
3767  0088 7b03          	ld	a,(OFST-1,sp)
3768  008a ae0d00        	ldw	x,#3328
3769  008d 97            	ld	xl,a
3770  008e cd0000        	call	_Enc28j60WriteReg
3772                     ; 668   Enc28j60SetMaskReg(BANKX_ECON2 , (1<<BANKX_ECON2_PKTDEC));
3774  0091 ae1e40        	ldw	x,#7744
3775  0094 cd0000        	call	_Enc28j60SetMaskReg
3777                     ; 670   return nBytes;
3779  0097 1e01          	ldw	x,(OFST-3,sp)
3781  0099               L233:
3783  0099 5b06          	addw	sp,#6
3784  009b 81            	ret	
3868                     ; 674 void Enc28j60Send(uint8_t* pBuffer, uint16_t nBytes)
3868                     ; 675 {
3869                     .text:	section	.text,new
3870  0000               _Enc28j60Send:
3872  0000 89            	pushw	x
3873  0001 5205          	subw	sp,#5
3874       00000005      OFST:	set	5
3877                     ; 676   uint16_t TxEnd = ENC28J60_TXSTART + nBytes;
3879  0003 1e0a          	ldw	x,(OFST+5,sp)
3880  0005 1c1800        	addw	x,#6144
3881  0008 1f02          	ldw	(OFST-3,sp),x
3883                     ; 677   uint8_t i = 200;
3885  000a a6c8          	ld	a,#200
3886  000c 6b04          	ld	(OFST-1,sp),a
3888                     ; 680   txerif_temp = 0;
3890  000e 0f05          	clr	(OFST+0,sp)
3893  0010 206c          	jra	L5512
3894  0012               L1512:
3895                     ; 688     if (!(Enc28j60ReadReg(BANKX_ECON1) & (1<<BANKX_ECON1_TXRTS))) break;
3897  0012 a61f          	ld	a,#31
3898  0014 cd0000        	call	_Enc28j60ReadReg
3900  0017 a508          	bcp	a,#8
3901  0019 265d          	jrne	L1612
3903  001b               L7512:
3904                     ; 692   Enc28j60SwitchBank(BANK0);
3906  001b 4f            	clr	a
3907  001c cd0000        	call	_Enc28j60SwitchBank
3909                     ; 693   Enc28j60WriteReg(BANK0_EWRPTL, (uint8_t) (ENC28J60_TXSTART >> 0));
3911  001f ae0200        	ldw	x,#512
3912  0022 cd0000        	call	_Enc28j60WriteReg
3914                     ; 694   Enc28j60WriteReg(BANK0_EWRPTH, (uint8_t) (ENC28J60_TXSTART >> 8));
3916  0025 ae0318        	ldw	x,#792
3917  0028 cd0000        	call	_Enc28j60WriteReg
3919                     ; 695   Enc28j60WriteReg(BANK0_ETXNDL, (uint8_t) (TxEnd >> 0));
3921  002b 7b03          	ld	a,(OFST-2,sp)
3922  002d ae0600        	ldw	x,#1536
3923  0030 97            	ld	xl,a
3924  0031 cd0000        	call	_Enc28j60WriteReg
3926                     ; 696   Enc28j60WriteReg(BANK0_ETXNDH, (uint8_t) (TxEnd >> 8));	
3928  0034 7b02          	ld	a,(OFST-3,sp)
3929  0036 ae0700        	ldw	x,#1792
3930  0039 97            	ld	xl,a
3931  003a cd0000        	call	_Enc28j60WriteReg
3933                     ; 698   select();
3935  003d cd0000        	call	_select
3937                     ; 700   SpiWriteByte(OPCODE_WBM);	 // Set ENC28J60 to receive transmit data on SPI
3939  0040 a67a          	ld	a,#122
3940  0042 cd0000        	call	_SpiWriteByte
3942                     ; 702   SpiWriteByte(0);		 // Per-packet-control-byte
3944  0045 4f            	clr	a
3945  0046 cd0000        	call	_SpiWriteByte
3947                     ; 714   SpiWriteChunk(pBuffer, nBytes); // Copy data to the ENC28J60 transmit buffer
3949  0049 1e0a          	ldw	x,(OFST+5,sp)
3950  004b 89            	pushw	x
3951  004c 1e08          	ldw	x,(OFST+3,sp)
3952  004e cd0000        	call	_SpiWriteChunk
3954  0051 85            	popw	x
3955                     ; 716   deselect();
3957  0052 cd0000        	call	_deselect
3959                     ; 785     if (Enc28j60ReadReg(BANKX_EIR) & (1<<BANKX_EIR_TXERIF)) {
3961  0055 a61c          	ld	a,#28
3962  0057 cd0000        	call	_Enc28j60ReadReg
3964  005a a502          	bcp	a,#2
3965  005c 2729          	jreq	L3612
3966                     ; 787       Enc28j60SetMaskReg(BANKX_ECON1, (1<<BANKX_ECON1_TXRST));
3968  005e ae1f80        	ldw	x,#8064
3969  0061 cd0000        	call	_Enc28j60SetMaskReg
3971                     ; 789       Enc28j60ClearMaskReg(BANKX_ECON1, (1<<BANKX_ECON1_TXRST));
3973  0064 ae1f80        	ldw	x,#8064
3974  0067 cd0000        	call	_Enc28j60ClearMaskReg
3976                     ; 791       Enc28j60ClearMaskReg(BANKX_EIR, (1<<BANKX_EIR_TXERIF));
3978  006a ae1c02        	ldw	x,#7170
3979  006d cd0000        	call	_Enc28j60ClearMaskReg
3981                     ; 793       Enc28j60ClearMaskReg(BANKX_EIR, (1<<BANKX_EIR_TXIF));
3983  0070 ae1c08        	ldw	x,#7176
3984  0073 cd0000        	call	_Enc28j60ClearMaskReg
3986  0076 200f          	jra	L3612
3987  0078               L1612:
3988                     ; 689     wait_timer(500);  // Wait 500 uS
3990  0078 ae01f4        	ldw	x,#500
3991  007b cd0000        	call	_wait_timer
3993  007e               L5512:
3994                     ; 687   while (i--) {
3996  007e 7b04          	ld	a,(OFST-1,sp)
3997  0080 0a04          	dec	(OFST-1,sp)
3999  0082 4d            	tnz	a
4000  0083 268d          	jrne	L1512
4001  0085 2094          	jra	L7512
4002  0087               L3612:
4003                     ; 797     Enc28j60SetMaskReg(BANKX_ECON1, (1<<BANKX_ECON1_TXRTS));
4005  0087 ae1f08        	ldw	x,#7944
4006  008a cd0000        	call	_Enc28j60SetMaskReg
4009  008d 2001          	jra	L7612
4010  008f               L5612:
4011                     ; 802         && !(Enc28j60ReadReg(BANKX_EIR) & (1<<BANKX_EIR_TXERIF))) nop();
4014  008f 9d            	nop	
4016  0090               L7612:
4017                     ; 801     while (!(Enc28j60ReadReg(BANKX_EIR) & (1<<BANKX_EIR_TXIF))
4017                     ; 802         && !(Enc28j60ReadReg(BANKX_EIR) & (1<<BANKX_EIR_TXERIF))) nop();
4019  0090 a61c          	ld	a,#28
4020  0092 cd0000        	call	_Enc28j60ReadReg
4022  0095 a508          	bcp	a,#8
4023  0097 2609          	jrne	L3712
4025  0099 a61c          	ld	a,#28
4026  009b cd0000        	call	_Enc28j60ReadReg
4028  009e a502          	bcp	a,#2
4029  00a0 27ed          	jreq	L5612
4030  00a2               L3712:
4031                     ; 805     if (Enc28j60ReadReg(BANKX_EIR) & (1<<BANKX_EIR_TXERIF)) txerif_temp = 1;
4034  00a2 a61c          	ld	a,#28
4035  00a4 cd0000        	call	_Enc28j60ReadReg
4037  00a7 a502          	bcp	a,#2
4038  00a9 2704          	jreq	L5712
4041  00ab a601          	ld	a,#1
4042  00ad 6b05          	ld	(OFST+0,sp),a
4044  00af               L5712:
4045                     ; 808     if (!(Enc28j60ReadReg(BANKX_EIR) & (1<<BANKX_EIR_TXIF))) {
4047  00af a61c          	ld	a,#28
4048  00b1 cd0000        	call	_Enc28j60ReadReg
4050  00b4 a508          	bcp	a,#8
4051  00b6 2606          	jrne	L7712
4052                     ; 809       Enc28j60ClearMaskReg(BANKX_ECON1, (1<<BANKX_ECON1_TXRTS));
4054  00b8 ae1f08        	ldw	x,#7944
4055  00bb cd0000        	call	_Enc28j60ClearMaskReg
4057  00be               L7712:
4058                     ; 813     if (txerif_temp) {
4060  00be 7b05          	ld	a,(OFST+0,sp)
4061  00c0 276f          	jreq	L1022
4062                     ; 815       for (i = 0; i < 16; i++) {
4064  00c2 0f04          	clr	(OFST-1,sp)
4066  00c4               L3022:
4067                     ; 817 	read_TSV();
4069  00c4 cd0000        	call	_read_TSV
4071                     ; 821         late_collision = 0;
4073                     ; 822         if (tsv_byte[3] & 0x20) late_collision = 1;
4075  00c7 720b000365    	btjf	_tsv_byte+3,#5,L1022
4078  00cc a601          	ld	a,#1
4079  00ce 6b01          	ld	(OFST-4,sp),a
4082                     ; 826         if (txerif_temp && (late_collision)) {
4084  00d0 7b05          	ld	a,(OFST+0,sp)
4085  00d2 2755          	jreq	L5122
4087  00d4 7b01          	ld	a,(OFST-4,sp)
4088  00d6 2751          	jreq	L5122
4089                     ; 827 	  txerif_temp = 0;
4091  00d8 0f05          	clr	(OFST+0,sp)
4093                     ; 830           Enc28j60SetMaskReg(BANKX_ECON1, (1<<BANKX_ECON1_TXRST));
4095  00da ae1f80        	ldw	x,#8064
4096  00dd cd0000        	call	_Enc28j60SetMaskReg
4098                     ; 832           Enc28j60ClearMaskReg(BANKX_ECON1, (1<<BANKX_ECON1_TXRST));
4100  00e0 ae1f80        	ldw	x,#8064
4101  00e3 cd0000        	call	_Enc28j60ClearMaskReg
4103                     ; 834           Enc28j60ClearMaskReg(BANKX_EIR, (1<<BANKX_EIR_TXERIF));
4105  00e6 ae1c02        	ldw	x,#7170
4106  00e9 cd0000        	call	_Enc28j60ClearMaskReg
4108                     ; 836           Enc28j60ClearMaskReg(BANKX_EIR, (1<<BANKX_EIR_TXIF));
4110  00ec ae1c08        	ldw	x,#7176
4111  00ef cd0000        	call	_Enc28j60ClearMaskReg
4113                     ; 838           Enc28j60SetMaskReg(BANKX_ECON1, (1<<BANKX_ECON1_TXRTS));
4115  00f2 ae1f08        	ldw	x,#7944
4116  00f5 cd0000        	call	_Enc28j60SetMaskReg
4119  00f8 2001          	jra	L1222
4120  00fa               L7122:
4121                     ; 842               && !(Enc28j60ReadReg(BANKX_EIR) & (1<<BANKX_EIR_TXERIF))) nop();
4124  00fa 9d            	nop	
4126  00fb               L1222:
4127                     ; 841           while (!(Enc28j60ReadReg(BANKX_EIR) & (1<<BANKX_EIR_TXIF))
4127                     ; 842               && !(Enc28j60ReadReg(BANKX_EIR) & (1<<BANKX_EIR_TXERIF))) nop();
4129  00fb a61c          	ld	a,#28
4130  00fd cd0000        	call	_Enc28j60ReadReg
4132  0100 a508          	bcp	a,#8
4133  0102 2609          	jrne	L5222
4135  0104 a61c          	ld	a,#28
4136  0106 cd0000        	call	_Enc28j60ReadReg
4138  0109 a502          	bcp	a,#2
4139  010b 27ed          	jreq	L7122
4140  010d               L5222:
4141                     ; 844             if (Enc28j60ReadReg(BANKX_EIR) & (1<<BANKX_EIR_TXERIF)) txerif_temp = 1;
4144  010d a61c          	ld	a,#28
4145  010f cd0000        	call	_Enc28j60ReadReg
4147  0112 a502          	bcp	a,#2
4148  0114 2704          	jreq	L7222
4151  0116 a601          	ld	a,#1
4152  0118 6b05          	ld	(OFST+0,sp),a
4154  011a               L7222:
4155                     ; 846           if (!(Enc28j60ReadReg(BANKX_EIR) & (1<<BANKX_EIR_TXIF))) {
4157  011a a61c          	ld	a,#28
4158  011c cd0000        	call	_Enc28j60ReadReg
4160  011f a508          	bcp	a,#8
4161  0121 2606          	jrne	L5122
4162                     ; 847 	    Enc28j60ClearMaskReg(BANKX_ECON1, (1<<BANKX_ECON1_TXRTS));
4164  0123 ae1f08        	ldw	x,#7944
4165  0126 cd0000        	call	_Enc28j60ClearMaskReg
4167  0129               L5122:
4168                     ; 815       for (i = 0; i < 16; i++) {
4170  0129 0c04          	inc	(OFST-1,sp)
4174  012b 7b04          	ld	a,(OFST-1,sp)
4175  012d a110          	cp	a,#16
4176  012f 2593          	jrult	L3022
4177  0131               L1022:
4178                     ; 854 }
4181  0131 5b07          	addw	sp,#7
4182  0133 81            	ret	
4243                     ; 857 void read_TSV(void)
4243                     ; 858 {
4244                     .text:	section	.text,new
4245  0000               _read_TSV:
4247  0000 5205          	subw	sp,#5
4248       00000005      OFST:	set	5
4251                     ; 866   wait_timer((uint16_t)10);
4253  0002 ae000a        	ldw	x,#10
4254  0005 cd0000        	call	_wait_timer
4256                     ; 870   saved_ERDPTL = Enc28j60ReadReg(BANK0_ERDPTL);
4258  0008 4f            	clr	a
4259  0009 cd0000        	call	_Enc28j60ReadReg
4261  000c 6b02          	ld	(OFST-3,sp),a
4263                     ; 871   saved_ERDPTH = Enc28j60ReadReg(BANK0_ERDPTH);
4265  000e a601          	ld	a,#1
4266  0010 cd0000        	call	_Enc28j60ReadReg
4268  0013 6b03          	ld	(OFST-2,sp),a
4270                     ; 874   tsv_start = ((Enc28j60ReadReg(BANK0_ETXNDH)) << 8);
4272  0015 a607          	ld	a,#7
4273  0017 cd0000        	call	_Enc28j60ReadReg
4275  001a 97            	ld	xl,a
4276  001b 4f            	clr	a
4277  001c 02            	rlwa	x,a
4278  001d 1f04          	ldw	(OFST-1,sp),x
4280                     ; 875   tsv_start += Enc28j60ReadReg(BANK0_ETXNDL);
4282  001f a606          	ld	a,#6
4283  0021 cd0000        	call	_Enc28j60ReadReg
4285  0024 1b05          	add	a,(OFST+0,sp)
4286  0026 6b05          	ld	(OFST+0,sp),a
4287  0028 2402          	jrnc	L654
4288  002a 0c04          	inc	(OFST-1,sp)
4289  002c               L654:
4291                     ; 876   tsv_start++;
4293  002c 1e04          	ldw	x,(OFST-1,sp)
4294  002e 5c            	incw	x
4295  002f 1f04          	ldw	(OFST-1,sp),x
4297                     ; 879   Enc28j60WriteReg(BANK0_ERDPTL, (uint8_t)(tsv_start & 0x00ff));
4299  0031 5f            	clrw	x
4300  0032 7b05          	ld	a,(OFST+0,sp)
4301  0034 97            	ld	xl,a
4302  0035 cd0000        	call	_Enc28j60WriteReg
4304                     ; 880   Enc28j60WriteReg(BANK0_ERDPTH, (uint8_t)(tsv_start >> 8));
4306  0038 7b04          	ld	a,(OFST-1,sp)
4307  003a ae0100        	ldw	x,#256
4308  003d 97            	ld	xl,a
4309  003e cd0000        	call	_Enc28j60WriteReg
4311                     ; 883   select();
4313  0041 cd0000        	call	_select
4315                     ; 884   SpiWriteByte(OPCODE_RBM);
4317  0044 a63a          	ld	a,#58
4318  0046 cd0000        	call	_SpiWriteByte
4320                     ; 889     for (i=0; i<7; i++) {
4322  0049 4f            	clr	a
4323  004a 6b01          	ld	(OFST-4,sp),a
4325  004c               L5522:
4326                     ; 890       tsv_byte[i] = SpiReadByte(); // Bits 7-0
4328  004c 5f            	clrw	x
4329  004d 97            	ld	xl,a
4330  004e 89            	pushw	x
4331  004f cd0000        	call	_SpiReadByte
4333  0052 85            	popw	x
4334  0053 d70000        	ld	(_tsv_byte,x),a
4335                     ; 889     for (i=0; i<7; i++) {
4337  0056 0c01          	inc	(OFST-4,sp)
4341  0058 7b01          	ld	a,(OFST-4,sp)
4342  005a a107          	cp	a,#7
4343  005c 25ee          	jrult	L5522
4344                     ; 894   deselect();
4346  005e cd0000        	call	_deselect
4348                     ; 897   Enc28j60WriteReg(BANK0_ERDPTL, saved_ERDPTL);
4350  0061 7b02          	ld	a,(OFST-3,sp)
4351  0063 5f            	clrw	x
4352  0064 97            	ld	xl,a
4353  0065 cd0000        	call	_Enc28j60WriteReg
4355                     ; 898   Enc28j60WriteReg(BANK0_ERDPTH, saved_ERDPTH);
4357  0068 7b03          	ld	a,(OFST-2,sp)
4358  006a ae0100        	ldw	x,#256
4359  006d 97            	ld	xl,a
4360  006e cd0000        	call	_Enc28j60WriteReg
4362                     ; 899 }
4365  0071 5b05          	addw	sp,#5
4366  0073 81            	ret	
4391                     	xdef	_Enc28j60WritePhy
4392                     	xdef	_Enc28j60ReadPhy
4393                     	xdef	_Enc28j60SwitchBank
4394                     	xdef	_Enc28j60ClearMaskReg
4395                     	xdef	_Enc28j60SetMaskReg
4396                     	xdef	_Enc28j60WriteReg
4397                     	xdef	_Enc28j60ReadReg
4398                     	xdef	_deselect
4399                     	xdef	_select
4400                     	switch	.bss
4401  0000               _tsv_byte:
4402  0000 000000000000  	ds.b	7
4403                     	xdef	_tsv_byte
4404                     	xref	_stored_uip_ethaddr_oct
4405                     	xref	_stored_config_settings
4406                     	xref	_wait_timer
4407                     	xdef	_read_TSV
4408                     	xdef	_Enc28j60Send
4409                     	xdef	_Enc28j60Receive
4410                     	xdef	_Enc28j60Init
4411                     	xref	_SpiReadChunk
4412                     	xref	_SpiReadByte
4413                     	xref	_SpiWriteChunk
4414                     	xref	_SpiWriteByte
4434                     	end
