   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Parser V4.11.14 - 18 Nov 2019
   3                     ; Generator (Limited) V4.4.11 - 19 Nov 2019
   4                     ; Optimizer V4.4.11 - 19 Nov 2019
2547                     ; 268 void select(void)
2547                     ; 269 {
2549                     .text:	section	.text,new
2550  0000               _select:
2554                     ; 271   PC_ODR &= (uint8_t)(~0x02);
2556  0000 7213500a      	bres	_PC_ODR,#1
2557                     ; 272   nop();
2560  0004 9d            	nop	
2562                     ; 273 }
2566  0005 81            	ret	
2591                     ; 276 void deselect(void)
2591                     ; 277 {
2592                     .text:	section	.text,new
2593  0000               _deselect:
2597                     ; 279   PC_ODR |= (uint8_t)0x02;
2599  0000 7212500a      	bset	_PC_ODR,#1
2600                     ; 280   nop();
2603  0004 9d            	nop	
2605                     ; 281 }
2609  0005 81            	ret	
2652                     ; 286 uint8_t Enc28j60ReadReg(uint8_t nRegister)
2652                     ; 287 {
2653                     .text:	section	.text,new
2654  0000               _Enc28j60ReadReg:
2656  0000 88            	push	a
2657  0001 88            	push	a
2658       00000001      OFST:	set	1
2661                     ; 290   select();
2663  0002 cd0000        	call	_select
2665                     ; 292   SpiWriteByte((uint8_t)(OPCODE_RCR | (nRegister & REGISTER_MASK)));
2667  0005 7b02          	ld	a,(OFST+1,sp)
2668  0007 a41f          	and	a,#31
2669  0009 cd0000        	call	_SpiWriteByte
2671                     ; 293   if (nRegister & REGISTER_NEEDDUMMY) SpiWriteByte(0);
2673  000c 7b02          	ld	a,(OFST+1,sp)
2674  000e 2a04          	jrpl	L1761
2677  0010 4f            	clr	a
2678  0011 cd0000        	call	_SpiWriteByte
2680  0014               L1761:
2681                     ; 294   nByte = SpiReadByte();
2683  0014 cd0000        	call	_SpiReadByte
2685  0017 6b01          	ld	(OFST+0,sp),a
2687                     ; 296   deselect();
2689  0019 cd0000        	call	_deselect
2691                     ; 298   return nByte;
2693  001c 7b01          	ld	a,(OFST+0,sp)
2696  001e 85            	popw	x
2697  001f 81            	ret	
2739                     ; 304 void Enc28j60WriteReg( uint8_t nRegister, uint8_t nData)
2739                     ; 305 {
2740                     .text:	section	.text,new
2741  0000               _Enc28j60WriteReg:
2743  0000 89            	pushw	x
2744       00000000      OFST:	set	0
2747                     ; 306   select();
2749  0001 cd0000        	call	_select
2751                     ; 308   SpiWriteByte((uint8_t)(OPCODE_WCR | (nRegister & REGISTER_MASK)));
2753  0004 7b01          	ld	a,(OFST+1,sp)
2754  0006 a41f          	and	a,#31
2755  0008 aa40          	or	a,#64
2756  000a cd0000        	call	_SpiWriteByte
2758                     ; 309   SpiWriteByte(nData);
2760  000d 7b02          	ld	a,(OFST+2,sp)
2761  000f cd0000        	call	_SpiWriteByte
2763                     ; 311   deselect();
2765  0012 cd0000        	call	_deselect
2767                     ; 312 }
2770  0015 85            	popw	x
2771  0016 81            	ret	
2813                     ; 317 void Enc28j60SetMaskReg(uint8_t nRegister, uint8_t nMask)
2813                     ; 318 {
2814                     .text:	section	.text,new
2815  0000               _Enc28j60SetMaskReg:
2817  0000 89            	pushw	x
2818       00000000      OFST:	set	0
2821                     ; 319   select();
2823  0001 cd0000        	call	_select
2825                     ; 321   SpiWriteByte((uint8_t)(OPCODE_BFS | (nRegister & REGISTER_MASK)));
2827  0004 7b01          	ld	a,(OFST+1,sp)
2828  0006 a41f          	and	a,#31
2829  0008 aa80          	or	a,#128
2830  000a cd0000        	call	_SpiWriteByte
2832                     ; 322   SpiWriteByte(nMask);
2834  000d 7b02          	ld	a,(OFST+2,sp)
2835  000f cd0000        	call	_SpiWriteByte
2837                     ; 324   deselect();
2839  0012 cd0000        	call	_deselect
2841                     ; 325 }
2844  0015 85            	popw	x
2845  0016 81            	ret	
2888                     ; 330 void Enc28j60ClearMaskReg( uint8_t nRegister, uint8_t nMask)
2888                     ; 331 {
2889                     .text:	section	.text,new
2890  0000               _Enc28j60ClearMaskReg:
2892  0000 89            	pushw	x
2893       00000000      OFST:	set	0
2896                     ; 332   select();
2898  0001 cd0000        	call	_select
2900                     ; 334   SpiWriteByte((uint8_t)(OPCODE_BFC | (nRegister & REGISTER_MASK)));
2902  0004 7b01          	ld	a,(OFST+1,sp)
2903  0006 a41f          	and	a,#31
2904  0008 aaa0          	or	a,#160
2905  000a cd0000        	call	_SpiWriteByte
2907                     ; 335   SpiWriteByte(nMask);
2909  000d 7b02          	ld	a,(OFST+2,sp)
2910  000f cd0000        	call	_SpiWriteByte
2912                     ; 337   deselect();
2914  0012 cd0000        	call	_deselect
2916                     ; 338 }
2919  0015 85            	popw	x
2920  0016 81            	ret	
2954                     ; 343 void Enc28j60SwitchBank(uint8_t nBank)
2954                     ; 344 {
2955                     .text:	section	.text,new
2956  0000               _Enc28j60SwitchBank:
2958  0000 88            	push	a
2959       00000000      OFST:	set	0
2962                     ; 348   Enc28j60ClearMaskReg(BANKX_ECON1, (3<<BANKX_ECON1_BSEL0));
2964  0001 ae1f03        	ldw	x,#7939
2965  0004 cd0000        	call	_Enc28j60ClearMaskReg
2967                     ; 349   Enc28j60SetMaskReg(BANKX_ECON1, (uint8_t)(nBank << BANKX_ECON1_BSEL0));
2969  0007 7b01          	ld	a,(OFST+1,sp)
2970  0009 ae1f00        	ldw	x,#7936
2971  000c 97            	ld	xl,a
2972  000d cd0000        	call	_Enc28j60SetMaskReg
2974                     ; 350 }
2977  0010 84            	pop	a
2978  0011 81            	ret	
3016                     ; 356 uint16_t Enc28j60ReadPhy(uint8_t nRegister)
3016                     ; 357 {
3017                     .text:	section	.text,new
3018  0000               _Enc28j60ReadPhy:
3020  0000 88            	push	a
3021  0001 89            	pushw	x
3022       00000002      OFST:	set	2
3025                     ; 358   Enc28j60SwitchBank(BANK2);
3027  0002 a602          	ld	a,#2
3028  0004 cd0000        	call	_Enc28j60SwitchBank
3030                     ; 359   Enc28j60WriteReg(BANK2_MIREGADR, nRegister);
3032  0007 7b03          	ld	a,(OFST+1,sp)
3033  0009 ae9400        	ldw	x,#37888
3034  000c 97            	ld	xl,a
3035  000d cd0000        	call	_Enc28j60WriteReg
3037                     ; 360   Enc28j60SetMaskReg(BANK2_MICMD, (1<<BANK2_MICMD_MIIRD));
3039  0010 ae9201        	ldw	x,#37377
3040  0013 cd0000        	call	_Enc28j60SetMaskReg
3042                     ; 361   Enc28j60SwitchBank(BANK3);
3044  0016 a603          	ld	a,#3
3045  0018 cd0000        	call	_Enc28j60SwitchBank
3048  001b 2001          	jra	L7771
3049  001d               L5771:
3050                     ; 362   while (Enc28j60ReadReg(BANK3_MISTAT) & (1 <<BANK3_MISTAT_BUSY)) nop();
3053  001d 9d            	nop	
3055  001e               L7771:
3058  001e a68a          	ld	a,#138
3059  0020 cd0000        	call	_Enc28j60ReadReg
3061  0023 a501          	bcp	a,#1
3062  0025 26f6          	jrne	L5771
3063                     ; 363   Enc28j60SwitchBank(BANK2);
3066  0027 a602          	ld	a,#2
3067  0029 cd0000        	call	_Enc28j60SwitchBank
3069                     ; 364   Enc28j60ClearMaskReg(BANK2_MICMD, (1<<BANK2_MICMD_MIIRD));
3071  002c ae9201        	ldw	x,#37377
3072  002f cd0000        	call	_Enc28j60ClearMaskReg
3074                     ; 366   return ((uint16_t) Enc28j60ReadReg(BANK2_MIRDL) << 0)
3074                     ; 367        | ((uint16_t) Enc28j60ReadReg(BANK2_MIRDH) << 8);
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
3140                     ; 374 void Enc28j60WritePhy( uint8_t nRegister, uint16_t nData)
3140                     ; 375 {
3141                     .text:	section	.text,new
3142  0000               _Enc28j60WritePhy:
3144  0000 88            	push	a
3145       00000000      OFST:	set	0
3148                     ; 376   Enc28j60SwitchBank(BANK2);
3150  0001 a602          	ld	a,#2
3151  0003 cd0000        	call	_Enc28j60SwitchBank
3153                     ; 377   Enc28j60WriteReg(BANK2_MIREGADR, nRegister);
3155  0006 7b01          	ld	a,(OFST+1,sp)
3156  0008 ae9400        	ldw	x,#37888
3157  000b 97            	ld	xl,a
3158  000c cd0000        	call	_Enc28j60WriteReg
3160                     ; 378   Enc28j60WriteReg(BANK2_MIWRL, (uint8_t)(nData >> 0));
3162  000f 7b05          	ld	a,(OFST+5,sp)
3163  0011 ae9600        	ldw	x,#38400
3164  0014 97            	ld	xl,a
3165  0015 cd0000        	call	_Enc28j60WriteReg
3167                     ; 379   Enc28j60WriteReg(BANK2_MIWRH, (uint8_t)(nData >> 8));
3169  0018 7b04          	ld	a,(OFST+4,sp)
3170  001a ae9700        	ldw	x,#38656
3171  001d 97            	ld	xl,a
3172  001e cd0000        	call	_Enc28j60WriteReg
3174                     ; 380   Enc28j60SwitchBank(BANK3);
3176  0021 a603          	ld	a,#3
3177  0023 cd0000        	call	_Enc28j60SwitchBank
3180  0026 2001          	jra	L3202
3181  0028               L1202:
3182                     ; 381   while (Enc28j60ReadReg(BANK3_MISTAT) & (1 <<BANK3_MISTAT_BUSY)) nop();
3185  0028 9d            	nop	
3187  0029               L3202:
3190  0029 a68a          	ld	a,#138
3191  002b cd0000        	call	_Enc28j60ReadReg
3193  002e a501          	bcp	a,#1
3194  0030 26f6          	jrne	L1202
3195                     ; 382 }
3199  0032 84            	pop	a
3200  0033 81            	ret	
3237                     ; 385 void Enc28j60Init(void)
3237                     ; 386 {
3238                     .text:	section	.text,new
3239  0000               _Enc28j60Init:
3243                     ; 390   deselect(); // Just makes sure the -CS is not selected
3245  0000 cd0000        	call	_deselect
3248  0003 2001          	jra	L1402
3249  0005               L7302:
3250                     ; 404   while (!(Enc28j60ReadReg(BANKX_ESTAT) & (1<<BANKX_ESTAT_CLKRDY))) nop();
3253  0005 9d            	nop	
3255  0006               L1402:
3258  0006 a61d          	ld	a,#29
3259  0008 cd0000        	call	_Enc28j60ReadReg
3261  000b a501          	bcp	a,#1
3262  000d 27f6          	jreq	L7302
3263                     ; 407   select();
3266  000f cd0000        	call	_select
3268                     ; 408   SpiWriteByte(OPCODE_SRC); // Reset command
3270  0012 a6ff          	ld	a,#255
3271  0014 cd0000        	call	_SpiWriteByte
3273                     ; 409   deselect();
3275  0017 cd0000        	call	_deselect
3277                     ; 417   wait_timer((uint16_t)10000); // delay 10 ms
3279  001a ae2710        	ldw	x,#10000
3280  001d cd0000        	call	_wait_timer
3282                     ; 420   Enc28j60WritePhy(PHY_PHCON1, (uint16_t)(1<<PHY_PHCON1_PRST)); // Reset command
3284  0020 ae8000        	ldw	x,#32768
3285  0023 89            	pushw	x
3286  0024 4f            	clr	a
3287  0025 cd0000        	call	_Enc28j60WritePhy
3289  0028 85            	popw	x
3291  0029 2001          	jra	L7402
3292  002b               L5402:
3293                     ; 422   while (Enc28j60ReadPhy(PHY_PHCON1) & (uint16_t)(1<<PHY_PHCON1_PRST)) nop();
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
3312                     ; 426   if (stored_config_settings[3] == '1') {
3315  003a c60003        	ld	a,_stored_config_settings+3
3316  003d a131          	cp	a,#49
3317  003f 2609          	jrne	L3502
3318                     ; 429     Enc28j60WritePhy(PHY_PHCON1, (uint16_t)(1<<PHY_PHCON1_PDPXMD));
3320  0041 ae0100        	ldw	x,#256
3321  0044 89            	pushw	x
3322  0045 4f            	clr	a
3323  0046 cd0000        	call	_Enc28j60WritePhy
3325  0049 85            	popw	x
3326  004a               L3502:
3327                     ; 434   Enc28j60SwitchBank(BANK0);
3329  004a 4f            	clr	a
3330  004b cd0000        	call	_Enc28j60SwitchBank
3332                     ; 438   Enc28j60WriteReg(BANK0_ERXSTL, (uint8_t) (ENC28J60_RXSTART >> 0));
3334  004e ae0800        	ldw	x,#2048
3335  0051 cd0000        	call	_Enc28j60WriteReg
3337                     ; 439   Enc28j60WriteReg(BANK0_ERXSTH, (uint8_t) (ENC28J60_RXSTART >> 8));
3339  0054 ae0900        	ldw	x,#2304
3340  0057 cd0000        	call	_Enc28j60WriteReg
3342                     ; 440   Enc28j60WriteReg(BANK0_ERXNDL, (uint8_t) (ENC28J60_RXEND >> 0));
3344  005a ae0aff        	ldw	x,#2815
3345  005d cd0000        	call	_Enc28j60WriteReg
3347                     ; 441   Enc28j60WriteReg(BANK0_ERXNDH, (uint8_t) (ENC28J60_RXEND >> 8));
3349  0060 ae0b17        	ldw	x,#2839
3350  0063 cd0000        	call	_Enc28j60WriteReg
3352                     ; 443   Enc28j60WriteReg(BANK0_ERDPTL, (uint8_t) (ENC28J60_RXSTART >> 0));
3354  0066 5f            	clrw	x
3355  0067 cd0000        	call	_Enc28j60WriteReg
3357                     ; 444   Enc28j60WriteReg(BANK0_ERDPTH, (uint8_t) (ENC28J60_RXSTART >> 8));
3359  006a ae0100        	ldw	x,#256
3360  006d cd0000        	call	_Enc28j60WriteReg
3362                     ; 447   Enc28j60WriteReg(BANK0_ERXRDPTL, (uint8_t) (ENC28J60_RXEND >> 0));
3364  0070 ae0cff        	ldw	x,#3327
3365  0073 cd0000        	call	_Enc28j60WriteReg
3367                     ; 448   Enc28j60WriteReg(BANK0_ERXRDPTH, (uint8_t) (ENC28J60_RXEND >> 8));
3369  0076 ae0d17        	ldw	x,#3351
3370  0079 cd0000        	call	_Enc28j60WriteReg
3372                     ; 450   Enc28j60WriteReg(BANK0_ETXSTL, (uint8_t) (ENC28J60_TXSTART >> 0));
3374  007c ae0400        	ldw	x,#1024
3375  007f cd0000        	call	_Enc28j60WriteReg
3377                     ; 451   Enc28j60WriteReg(BANK0_ETXSTH, (uint8_t) (ENC28J60_TXSTART >> 8));
3379  0082 ae0518        	ldw	x,#1304
3380  0085 cd0000        	call	_Enc28j60WriteReg
3382                     ; 456   Enc28j60SwitchBank(BANK1);
3384  0088 a601          	ld	a,#1
3385  008a cd0000        	call	_Enc28j60SwitchBank
3387                     ; 503   Enc28j60WriteReg(BANK1_ERXFCON, (uint8_t)0xa1);    // Allows packets if MAC matches
3389  008d ae18a1        	ldw	x,#6305
3390  0090 cd0000        	call	_Enc28j60WriteReg
3392                     ; 522   Enc28j60SwitchBank(BANK2);
3394  0093 a602          	ld	a,#2
3395  0095 cd0000        	call	_Enc28j60SwitchBank
3397                     ; 525   Enc28j60WriteReg(BANK2_MACON1, (1<<BANK2_MACON1_MARXEN));
3399  0098 ae8001        	ldw	x,#32769
3400  009b cd0000        	call	_Enc28j60WriteReg
3402                     ; 548   if (stored_config_settings[3] == '0') {
3404  009e c60003        	ld	a,_stored_config_settings+3
3405  00a1 a130          	cp	a,#48
3406  00a3 2609          	jrne	L5502
3407                     ; 550     Enc28j60SetMaskReg(BANK2_MACON3, (1<<BANK2_MACON3_TXCRCEN)|(1<<BANK2_MACON3_PADCFG0)|(1<<BANK2_MACON3_FRMLNEN));
3409  00a5 ae8232        	ldw	x,#33330
3410  00a8 cd0000        	call	_Enc28j60SetMaskReg
3412  00ab c60003        	ld	a,_stored_config_settings+3
3413  00ae               L5502:
3414                     ; 552   if (stored_config_settings[3] == '1') {
3416  00ae a131          	cp	a,#49
3417  00b0 2606          	jrne	L7502
3418                     ; 555     Enc28j60SetMaskReg(BANK2_MACON3, (1<<BANK2_MACON3_TXCRCEN) | (1<<BANK2_MACON3_PADCFG0) | (1<<BANK2_MACON3_FRMLNEN) | (1<<BANK2_MACON3_FULDPX));
3420  00b2 ae8233        	ldw	x,#33331
3421  00b5 cd0000        	call	_Enc28j60SetMaskReg
3423  00b8               L7502:
3424                     ; 559   Enc28j60SetMaskReg(BANK2_MACON4, (1<<BANK2_MACON4_DEFER));
3426  00b8 ae8340        	ldw	x,#33600
3427  00bb cd0000        	call	_Enc28j60SetMaskReg
3429                     ; 563   Enc28j60WriteReg(BANK2_MAMXFLL, (uint8_t) ((ENC28J60_MAXFRAME + 4) >> 0));
3431  00be ae8af8        	ldw	x,#35576
3432  00c1 cd0000        	call	_Enc28j60WriteReg
3434                     ; 564   Enc28j60WriteReg(BANK2_MAMXFLH, (uint8_t) ((ENC28J60_MAXFRAME + 4) >> 8));
3436  00c4 ae9001        	ldw	x,#36865
3437  00c7 cd0000        	call	_Enc28j60WriteReg
3439                     ; 567   Enc28j60WriteReg(BANK2_MAIPGL, 0x12);
3441  00ca ae8612        	ldw	x,#34322
3442  00cd cd0000        	call	_Enc28j60WriteReg
3444                     ; 569   if (stored_config_settings[3] == '0') {
3446  00d0 c60003        	ld	a,_stored_config_settings+3
3447  00d3 a130          	cp	a,#48
3448  00d5 2609          	jrne	L1602
3449                     ; 571     Enc28j60WriteReg(BANK2_MAIPGH, 0x0C);
3451  00d7 ae870c        	ldw	x,#34572
3452  00da cd0000        	call	_Enc28j60WriteReg
3454  00dd c60003        	ld	a,_stored_config_settings+3
3455  00e0               L1602:
3456                     ; 578   if (stored_config_settings[3] == '0') {
3458  00e0 a130          	cp	a,#48
3459  00e2 2609          	jrne	L3602
3460                     ; 580     Enc28j60WriteReg(BANK2_MABBIPG, 0x12);
3462  00e4 ae8412        	ldw	x,#33810
3463  00e7 cd0000        	call	_Enc28j60WriteReg
3465  00ea c60003        	ld	a,_stored_config_settings+3
3466  00ed               L3602:
3467                     ; 582   if (stored_config_settings[3] == '1') {
3469  00ed a131          	cp	a,#49
3470  00ef 2606          	jrne	L5602
3471                     ; 584     Enc28j60WriteReg(BANK2_MABBIPG, 0x15);
3473  00f1 ae8415        	ldw	x,#33813
3474  00f4 cd0000        	call	_Enc28j60WriteReg
3476  00f7               L5602:
3477                     ; 589   Enc28j60SwitchBank(BANK3);
3479  00f7 a603          	ld	a,#3
3480  00f9 cd0000        	call	_Enc28j60SwitchBank
3482                     ; 592   Enc28j60WriteReg(BANK3_MAADR5, stored_uip_ethaddr_oct[5]);  // MAC MSB
3484  00fc c60005        	ld	a,_stored_uip_ethaddr_oct+5
3485  00ff ae8400        	ldw	x,#33792
3486  0102 97            	ld	xl,a
3487  0103 cd0000        	call	_Enc28j60WriteReg
3489                     ; 593   Enc28j60WriteReg(BANK3_MAADR4, stored_uip_ethaddr_oct[4]);
3491  0106 c60004        	ld	a,_stored_uip_ethaddr_oct+4
3492  0109 ae8500        	ldw	x,#34048
3493  010c 97            	ld	xl,a
3494  010d cd0000        	call	_Enc28j60WriteReg
3496                     ; 594   Enc28j60WriteReg(BANK3_MAADR3, stored_uip_ethaddr_oct[3]);
3498  0110 c60003        	ld	a,_stored_uip_ethaddr_oct+3
3499  0113 ae8200        	ldw	x,#33280
3500  0116 97            	ld	xl,a
3501  0117 cd0000        	call	_Enc28j60WriteReg
3503                     ; 595   Enc28j60WriteReg(BANK3_MAADR2, stored_uip_ethaddr_oct[2]);
3505  011a c60002        	ld	a,_stored_uip_ethaddr_oct+2
3506  011d ae8300        	ldw	x,#33536
3507  0120 97            	ld	xl,a
3508  0121 cd0000        	call	_Enc28j60WriteReg
3510                     ; 596   Enc28j60WriteReg(BANK3_MAADR1, stored_uip_ethaddr_oct[1]);
3512  0124 c60001        	ld	a,_stored_uip_ethaddr_oct+1
3513  0127 ae8000        	ldw	x,#32768
3514  012a 97            	ld	xl,a
3515  012b cd0000        	call	_Enc28j60WriteReg
3517                     ; 597   Enc28j60WriteReg(BANK3_MAADR0, stored_uip_ethaddr_oct[0]);  // MAC LSB
3519  012e c60000        	ld	a,_stored_uip_ethaddr_oct
3520  0131 ae8100        	ldw	x,#33024
3521  0134 97            	ld	xl,a
3522  0135 cd0000        	call	_Enc28j60WriteReg
3524                     ; 600   Enc28j60WritePhy(PHY_PHCON2, (1<<PHY_PHCON2_HDLDIS));
3526  0138 ae0100        	ldw	x,#256
3527  013b 89            	pushw	x
3528  013c a610          	ld	a,#16
3529  013e cd0000        	call	_Enc28j60WritePhy
3531  0141 85            	popw	x
3532                     ; 604   Enc28j60WritePhy(PHY_PHLCON,
3532                     ; 605     (ENC28J60_LEDB<<PHY_PHLCON_LBCFG0)|
3532                     ; 606     (ENC28J60_LEDA<<PHY_PHLCON_LACFG0)|
3532                     ; 607     (1<<PHY_PHLCON_STRCH)|0x3000);
3534  0142 ae31c2        	ldw	x,#12738
3535  0145 89            	pushw	x
3536  0146 a614          	ld	a,#20
3537  0148 cd0000        	call	_Enc28j60WritePhy
3539  014b c60003        	ld	a,_stored_config_settings+3
3540  014e a130          	cp	a,#48
3541  0150 85            	popw	x
3542                     ; 609   if (stored_config_settings[3] == '0') {
3544  0151 2607          	jrne	L7602
3545                     ; 614     Enc28j60WritePhy(PHY_PHCON1, 0x0000);
3547  0153 5f            	clrw	x
3548  0154 89            	pushw	x
3549  0155 4f            	clr	a
3550  0156 cd0000        	call	_Enc28j60WritePhy
3552  0159 85            	popw	x
3553  015a               L7602:
3554                     ; 618   Enc28j60SetMaskReg(BANKX_ECON1, (1<<BANKX_ECON1_RXEN));
3556  015a ae1f04        	ldw	x,#7940
3558                     ; 619 }
3561  015d cc0000        	jp	_Enc28j60SetMaskReg
3620                     ; 622 uint16_t Enc28j60Receive(uint8_t* pBuffer)
3620                     ; 623 {
3621                     .text:	section	.text,new
3622  0000               _Enc28j60Receive:
3624  0000 89            	pushw	x
3625  0001 5204          	subw	sp,#4
3626       00000004      OFST:	set	4
3629                     ; 630   if (Enc28j60ReadReg(BANKX_EIR) & 0x01) {
3631  0003 a61c          	ld	a,#28
3632  0005 cd0000        	call	_Enc28j60ReadReg
3634  0008 a501          	bcp	a,#1
3635  000a 2708          	jreq	L3112
3636                     ; 631     RXERIF_counter++;
3638  000c ae0000        	ldw	x,#_RXERIF_counter
3639  000f a601          	ld	a,#1
3640  0011 cd0000        	call	c_lgadc
3642  0014               L3112:
3643                     ; 636   Enc28j60SwitchBank(BANK1);
3645  0014 a601          	ld	a,#1
3646  0016 cd0000        	call	_Enc28j60SwitchBank
3648                     ; 637   if (Enc28j60ReadReg(BANK1_EPKTCNT) == 0) return 0;
3650  0019 a619          	ld	a,#25
3651  001b cd0000        	call	_Enc28j60ReadReg
3653  001e 4d            	tnz	a
3654  001f 2604          	jrne	L5112
3657  0021 5f            	clrw	x
3659  0022 cc00aa        	jra	L433
3660  0025               L5112:
3661                     ; 639   select();
3663  0025 cd0000        	call	_select
3665                     ; 641   SpiWriteByte(OPCODE_RBM);	 // Set ENC28J60 to send receive data on SPI
3667  0028 a63a          	ld	a,#58
3668  002a cd0000        	call	_SpiWriteByte
3670                     ; 644   nNextPacket = ((uint16_t) SpiReadByte() << 0);
3672  002d cd0000        	call	_SpiReadByte
3674  0030 5f            	clrw	x
3675  0031 97            	ld	xl,a
3676  0032 1f03          	ldw	(OFST-1,sp),x
3678                     ; 645   nNextPacket |= ((uint16_t) SpiReadByte() << 8);
3680  0034 cd0000        	call	_SpiReadByte
3682  0037 5f            	clrw	x
3683  0038 97            	ld	xl,a
3684  0039 7b04          	ld	a,(OFST+0,sp)
3685  003b 01            	rrwa	x,a
3686  003c 1a03          	or	a,(OFST-1,sp)
3687  003e 01            	rrwa	x,a
3688  003f 1f03          	ldw	(OFST-1,sp),x
3690                     ; 648   nBytes = ((uint16_t) SpiReadByte() << 0);
3692  0041 cd0000        	call	_SpiReadByte
3694  0044 5f            	clrw	x
3695  0045 97            	ld	xl,a
3696  0046 1f01          	ldw	(OFST-3,sp),x
3698                     ; 649   nBytes |= ((uint16_t) SpiReadByte() << 8);
3700  0048 cd0000        	call	_SpiReadByte
3702  004b 5f            	clrw	x
3703  004c 97            	ld	xl,a
3704  004d 7b02          	ld	a,(OFST-2,sp)
3705  004f 01            	rrwa	x,a
3706  0050 1a01          	or	a,(OFST-3,sp)
3707  0052 01            	rrwa	x,a
3709                     ; 650   nBytes -= 4;
3711  0053 1d0004        	subw	x,#4
3712  0056 1f01          	ldw	(OFST-3,sp),x
3714                     ; 653   SpiReadByte();
3716  0058 cd0000        	call	_SpiReadByte
3718                     ; 654   SpiReadByte();
3720  005b cd0000        	call	_SpiReadByte
3722                     ; 661   if (nBytes <= ENC28J60_MAXFRAME) SpiReadChunk(pBuffer, nBytes);
3724  005e 1e01          	ldw	x,(OFST-3,sp)
3725  0060 a301f5        	cpw	x,#501
3726  0063 2407          	jruge	L7112
3729  0065 89            	pushw	x
3730  0066 1e07          	ldw	x,(OFST+3,sp)
3731  0068 cd0000        	call	_SpiReadChunk
3733  006b 85            	popw	x
3734  006c               L7112:
3735                     ; 663   deselect();
3737  006c cd0000        	call	_deselect
3739                     ; 665   Enc28j60SwitchBank(BANK0);
3741  006f 4f            	clr	a
3742  0070 cd0000        	call	_Enc28j60SwitchBank
3744                     ; 667   Enc28j60WriteReg(BANK0_ERDPTL , (uint8_t) (nNextPacket >> 0));
3746  0073 7b04          	ld	a,(OFST+0,sp)
3747  0075 5f            	clrw	x
3748  0076 97            	ld	xl,a
3749  0077 cd0000        	call	_Enc28j60WriteReg
3751                     ; 668   Enc28j60WriteReg(BANK0_ERDPTH , (uint8_t) (nNextPacket >> 8));
3753  007a 7b03          	ld	a,(OFST-1,sp)
3754  007c ae0100        	ldw	x,#256
3755  007f 97            	ld	xl,a
3756  0080 cd0000        	call	_Enc28j60WriteReg
3758                     ; 672   nNextPacket -= 1;
3760  0083 1e03          	ldw	x,(OFST-1,sp)
3761  0085 5a            	decw	x
3763                     ; 673   if (nNextPacket == ( ((uint16_t)ENC28J60_RXSTART) - 1 )) {
3765  0086 a3ffff        	cpw	x,#65535
3766  0089 2603          	jrne	L1212
3767                     ; 676     nNextPacket = ENC28J60_RXEND;
3769  008b ae17ff        	ldw	x,#6143
3771  008e               L1212:
3772  008e 1f03          	ldw	(OFST-1,sp),x
3773                     ; 679   Enc28j60WriteReg(BANK0_ERXRDPTL, (uint8_t)(nNextPacket >> 0));
3775  0090 ae0c00        	ldw	x,#3072
3776  0093 7b04          	ld	a,(OFST+0,sp)
3777  0095 97            	ld	xl,a
3778  0096 cd0000        	call	_Enc28j60WriteReg
3780                     ; 680   Enc28j60WriteReg(BANK0_ERXRDPTH, (uint8_t)(nNextPacket >> 8));
3782  0099 7b03          	ld	a,(OFST-1,sp)
3783  009b ae0d00        	ldw	x,#3328
3784  009e 97            	ld	xl,a
3785  009f cd0000        	call	_Enc28j60WriteReg
3787                     ; 683   Enc28j60SetMaskReg(BANKX_ECON2 , (1<<BANKX_ECON2_PKTDEC));
3789  00a2 ae1e40        	ldw	x,#7744
3790  00a5 cd0000        	call	_Enc28j60SetMaskReg
3792                     ; 685   return nBytes;
3794  00a8 1e01          	ldw	x,(OFST-3,sp)
3796  00aa               L433:
3798  00aa 5b06          	addw	sp,#6
3799  00ac 81            	ret	
3883                     ; 689 void Enc28j60Send(uint8_t* pBuffer, uint16_t nBytes)
3883                     ; 690 {
3884                     .text:	section	.text,new
3885  0000               _Enc28j60Send:
3887  0000 89            	pushw	x
3888  0001 5205          	subw	sp,#5
3889       00000005      OFST:	set	5
3892                     ; 691   uint16_t TxEnd = ENC28J60_TXSTART + nBytes;
3894  0003 1e0a          	ldw	x,(OFST+5,sp)
3895  0005 1c1800        	addw	x,#6144
3896  0008 1f02          	ldw	(OFST-3,sp),x
3898                     ; 692   uint8_t i = 200;
3900  000a a6c8          	ld	a,#200
3901  000c 6b04          	ld	(OFST-1,sp),a
3903                     ; 695   txerif_temp = 0;
3905  000e 0f05          	clr	(OFST+0,sp)
3908  0010 2072          	jra	L7512
3909  0012               L3512:
3910                     ; 703     if (!(Enc28j60ReadReg(BANKX_ECON1) & (1<<BANKX_ECON1_TXRTS))) break;
3912  0012 a61f          	ld	a,#31
3913  0014 cd0000        	call	_Enc28j60ReadReg
3915  0017 a508          	bcp	a,#8
3916  0019 2663          	jrne	L3612
3918  001b               L1612:
3919                     ; 707   Enc28j60SwitchBank(BANK0);
3921  001b 4f            	clr	a
3922  001c cd0000        	call	_Enc28j60SwitchBank
3924                     ; 708   Enc28j60WriteReg(BANK0_EWRPTL, (uint8_t) (ENC28J60_TXSTART >> 0));
3926  001f ae0200        	ldw	x,#512
3927  0022 cd0000        	call	_Enc28j60WriteReg
3929                     ; 709   Enc28j60WriteReg(BANK0_EWRPTH, (uint8_t) (ENC28J60_TXSTART >> 8));
3931  0025 ae0318        	ldw	x,#792
3932  0028 cd0000        	call	_Enc28j60WriteReg
3934                     ; 710   Enc28j60WriteReg(BANK0_ETXNDL, (uint8_t) (TxEnd >> 0));
3936  002b 7b03          	ld	a,(OFST-2,sp)
3937  002d ae0600        	ldw	x,#1536
3938  0030 97            	ld	xl,a
3939  0031 cd0000        	call	_Enc28j60WriteReg
3941                     ; 711   Enc28j60WriteReg(BANK0_ETXNDH, (uint8_t) (TxEnd >> 8));	
3943  0034 7b02          	ld	a,(OFST-3,sp)
3944  0036 ae0700        	ldw	x,#1792
3945  0039 97            	ld	xl,a
3946  003a cd0000        	call	_Enc28j60WriteReg
3948                     ; 713   select();
3950  003d cd0000        	call	_select
3952                     ; 715   SpiWriteByte(OPCODE_WBM);	 // Set ENC28J60 to receive transmit data on SPI
3954  0040 a67a          	ld	a,#122
3955  0042 cd0000        	call	_SpiWriteByte
3957                     ; 717   SpiWriteByte(0);		 // Per-packet-control-byte
3959  0045 4f            	clr	a
3960  0046 cd0000        	call	_SpiWriteByte
3962                     ; 729   SpiWriteChunk(pBuffer, nBytes); // Copy data to the ENC28J60 transmit buffer
3964  0049 1e0a          	ldw	x,(OFST+5,sp)
3965  004b 89            	pushw	x
3966  004c 1e08          	ldw	x,(OFST+3,sp)
3967  004e cd0000        	call	_SpiWriteChunk
3969  0051 85            	popw	x
3970                     ; 731   deselect();
3972  0052 cd0000        	call	_deselect
3974                     ; 800     if (Enc28j60ReadReg(BANKX_EIR) & (1<<BANKX_EIR_TXERIF)) {
3976  0055 a61c          	ld	a,#28
3977  0057 cd0000        	call	_Enc28j60ReadReg
3979  005a a502          	bcp	a,#2
3980  005c 272f          	jreq	L5612
3981                     ; 806 wait_timer(10);  // Wait 10 uS
3983  005e ae000a        	ldw	x,#10
3984  0061 cd0000        	call	_wait_timer
3986                     ; 809       Enc28j60SetMaskReg(BANKX_ECON1, (1<<BANKX_ECON1_TXRST));
3988  0064 ae1f80        	ldw	x,#8064
3989  0067 cd0000        	call	_Enc28j60SetMaskReg
3991                     ; 811       Enc28j60ClearMaskReg(BANKX_ECON1, (1<<BANKX_ECON1_TXRST));
3993  006a ae1f80        	ldw	x,#8064
3994  006d cd0000        	call	_Enc28j60ClearMaskReg
3996                     ; 813       Enc28j60ClearMaskReg(BANKX_EIR, (1<<BANKX_EIR_TXERIF));
3998  0070 ae1c02        	ldw	x,#7170
3999  0073 cd0000        	call	_Enc28j60ClearMaskReg
4001                     ; 815       Enc28j60ClearMaskReg(BANKX_EIR, (1<<BANKX_EIR_TXIF));
4003  0076 ae1c08        	ldw	x,#7176
4004  0079 cd0000        	call	_Enc28j60ClearMaskReg
4006  007c 200f          	jra	L5612
4007  007e               L3612:
4008                     ; 704     wait_timer(500);  // Wait 500 uS
4010  007e ae01f4        	ldw	x,#500
4011  0081 cd0000        	call	_wait_timer
4013  0084               L7512:
4014                     ; 702   while (i--) {
4016  0084 7b04          	ld	a,(OFST-1,sp)
4017  0086 0a04          	dec	(OFST-1,sp)
4019  0088 4d            	tnz	a
4020  0089 2687          	jrne	L3512
4021  008b 208e          	jra	L1612
4022  008d               L5612:
4023                     ; 826     Enc28j60SetMaskReg(BANKX_ECON1, (1<<BANKX_ECON1_TXRTS));
4025  008d ae1f08        	ldw	x,#7944
4026  0090 cd0000        	call	_Enc28j60SetMaskReg
4029  0093 2001          	jra	L1712
4030  0095               L7612:
4031                     ; 831         && !(Enc28j60ReadReg(BANKX_EIR) & (1<<BANKX_EIR_TXERIF))) nop();
4034  0095 9d            	nop	
4036  0096               L1712:
4037                     ; 830     while (!(Enc28j60ReadReg(BANKX_EIR) & (1<<BANKX_EIR_TXIF))
4037                     ; 831         && !(Enc28j60ReadReg(BANKX_EIR) & (1<<BANKX_EIR_TXERIF))) nop();
4039  0096 a61c          	ld	a,#28
4040  0098 cd0000        	call	_Enc28j60ReadReg
4042  009b a508          	bcp	a,#8
4043  009d 2609          	jrne	L5712
4045  009f a61c          	ld	a,#28
4046  00a1 cd0000        	call	_Enc28j60ReadReg
4048  00a4 a502          	bcp	a,#2
4049  00a6 27ed          	jreq	L7612
4050  00a8               L5712:
4051                     ; 834     if (Enc28j60ReadReg(BANKX_EIR) & (1<<BANKX_EIR_TXERIF)) txerif_temp = 1;
4054  00a8 a61c          	ld	a,#28
4055  00aa cd0000        	call	_Enc28j60ReadReg
4057  00ad a502          	bcp	a,#2
4058  00af 2704          	jreq	L7712
4061  00b1 a601          	ld	a,#1
4062  00b3 6b05          	ld	(OFST+0,sp),a
4064  00b5               L7712:
4065                     ; 837     if (!(Enc28j60ReadReg(BANKX_EIR) & (1<<BANKX_EIR_TXIF))) {
4067  00b5 a61c          	ld	a,#28
4068  00b7 cd0000        	call	_Enc28j60ReadReg
4070  00ba a508          	bcp	a,#8
4071  00bc 2606          	jrne	L1022
4072                     ; 838       Enc28j60ClearMaskReg(BANKX_ECON1, (1<<BANKX_ECON1_TXRTS));
4074  00be ae1f08        	ldw	x,#7944
4075  00c1 cd0000        	call	_Enc28j60ClearMaskReg
4077  00c4               L1022:
4078                     ; 842     if (txerif_temp) {
4080  00c4 7b05          	ld	a,(OFST+0,sp)
4081  00c6 2603cc014c    	jreq	L3022
4082                     ; 848 wait_timer(10);  // Wait 10 uS
4084  00cb ae000a        	ldw	x,#10
4085  00ce cd0000        	call	_wait_timer
4087                     ; 851       for (i = 0; i < 16; i++) {
4089  00d1 0f04          	clr	(OFST-1,sp)
4091  00d3               L5022:
4092                     ; 853 	read_TSV();
4094  00d3 cd0000        	call	_read_TSV
4096                     ; 855 wait_timer(10);  // Wait 10 uS
4098  00d6 ae000a        	ldw	x,#10
4099  00d9 cd0000        	call	_wait_timer
4101                     ; 860         late_collision = 0;
4103                     ; 861         if (tsv_byte[3] & 0x20) late_collision = 1;
4105  00dc 720b00036b    	btjf	_tsv_byte+3,#5,L3022
4108  00e1 a601          	ld	a,#1
4109  00e3 6b01          	ld	(OFST-4,sp),a
4112                     ; 865         if (txerif_temp && (late_collision)) {
4114  00e5 7b05          	ld	a,(OFST+0,sp)
4115  00e7 275b          	jreq	L7122
4117  00e9 7b01          	ld	a,(OFST-4,sp)
4118  00eb 2757          	jreq	L7122
4119                     ; 866 	  txerif_temp = 0;
4121  00ed 0f05          	clr	(OFST+0,sp)
4123                     ; 873 wait_timer(10);  // Wait 10 uS
4125  00ef ae000a        	ldw	x,#10
4126  00f2 cd0000        	call	_wait_timer
4128                     ; 877           Enc28j60SetMaskReg(BANKX_ECON1, (1<<BANKX_ECON1_TXRST));
4130  00f5 ae1f80        	ldw	x,#8064
4131  00f8 cd0000        	call	_Enc28j60SetMaskReg
4133                     ; 879           Enc28j60ClearMaskReg(BANKX_ECON1, (1<<BANKX_ECON1_TXRST));
4135  00fb ae1f80        	ldw	x,#8064
4136  00fe cd0000        	call	_Enc28j60ClearMaskReg
4138                     ; 881           Enc28j60ClearMaskReg(BANKX_EIR, (1<<BANKX_EIR_TXERIF));
4140  0101 ae1c02        	ldw	x,#7170
4141  0104 cd0000        	call	_Enc28j60ClearMaskReg
4143                     ; 883           Enc28j60ClearMaskReg(BANKX_EIR, (1<<BANKX_EIR_TXIF));
4145  0107 ae1c08        	ldw	x,#7176
4146  010a cd0000        	call	_Enc28j60ClearMaskReg
4148                     ; 885           Enc28j60SetMaskReg(BANKX_ECON1, (1<<BANKX_ECON1_TXRTS));
4150  010d ae1f08        	ldw	x,#7944
4151  0110 cd0000        	call	_Enc28j60SetMaskReg
4154  0113 2001          	jra	L3222
4155  0115               L1222:
4156                     ; 889               && !(Enc28j60ReadReg(BANKX_EIR) & (1<<BANKX_EIR_TXERIF))) nop();
4159  0115 9d            	nop	
4161  0116               L3222:
4162                     ; 888           while (!(Enc28j60ReadReg(BANKX_EIR) & (1<<BANKX_EIR_TXIF))
4162                     ; 889               && !(Enc28j60ReadReg(BANKX_EIR) & (1<<BANKX_EIR_TXERIF))) nop();
4164  0116 a61c          	ld	a,#28
4165  0118 cd0000        	call	_Enc28j60ReadReg
4167  011b a508          	bcp	a,#8
4168  011d 2609          	jrne	L7222
4170  011f a61c          	ld	a,#28
4171  0121 cd0000        	call	_Enc28j60ReadReg
4173  0124 a502          	bcp	a,#2
4174  0126 27ed          	jreq	L1222
4175  0128               L7222:
4176                     ; 891           if (Enc28j60ReadReg(BANKX_EIR) & (1<<BANKX_EIR_TXERIF)) txerif_temp = 1;
4179  0128 a61c          	ld	a,#28
4180  012a cd0000        	call	_Enc28j60ReadReg
4182  012d a502          	bcp	a,#2
4183  012f 2704          	jreq	L1322
4186  0131 a601          	ld	a,#1
4187  0133 6b05          	ld	(OFST+0,sp),a
4189  0135               L1322:
4190                     ; 893           if (!(Enc28j60ReadReg(BANKX_EIR) & (1<<BANKX_EIR_TXIF))) {
4192  0135 a61c          	ld	a,#28
4193  0137 cd0000        	call	_Enc28j60ReadReg
4195  013a a508          	bcp	a,#8
4196  013c 2606          	jrne	L7122
4197                     ; 894 	    Enc28j60ClearMaskReg(BANKX_ECON1, (1<<BANKX_ECON1_TXRTS));
4199  013e ae1f08        	ldw	x,#7944
4200  0141 cd0000        	call	_Enc28j60ClearMaskReg
4202  0144               L7122:
4203                     ; 851       for (i = 0; i < 16; i++) {
4205  0144 0c04          	inc	(OFST-1,sp)
4209  0146 7b04          	ld	a,(OFST-1,sp)
4210  0148 a110          	cp	a,#16
4211  014a 2587          	jrult	L5022
4212  014c               L3022:
4213                     ; 901 }
4216  014c 5b07          	addw	sp,#7
4217  014e 81            	ret	
4278                     ; 904 void read_TSV(void)
4278                     ; 905 {
4279                     .text:	section	.text,new
4280  0000               _read_TSV:
4282  0000 5205          	subw	sp,#5
4283       00000005      OFST:	set	5
4286                     ; 913   wait_timer((uint16_t)10);
4288  0002 ae000a        	ldw	x,#10
4289  0005 cd0000        	call	_wait_timer
4291                     ; 917   saved_ERDPTL = Enc28j60ReadReg(BANK0_ERDPTL);
4293  0008 4f            	clr	a
4294  0009 cd0000        	call	_Enc28j60ReadReg
4296  000c 6b02          	ld	(OFST-3,sp),a
4298                     ; 918   saved_ERDPTH = Enc28j60ReadReg(BANK0_ERDPTH);
4300  000e a601          	ld	a,#1
4301  0010 cd0000        	call	_Enc28j60ReadReg
4303  0013 6b03          	ld	(OFST-2,sp),a
4305                     ; 921   tsv_start = ((Enc28j60ReadReg(BANK0_ETXNDH)) << 8);
4307  0015 a607          	ld	a,#7
4308  0017 cd0000        	call	_Enc28j60ReadReg
4310  001a 97            	ld	xl,a
4311  001b 4f            	clr	a
4312  001c 02            	rlwa	x,a
4313  001d 1f04          	ldw	(OFST-1,sp),x
4315                     ; 922   tsv_start += Enc28j60ReadReg(BANK0_ETXNDL);
4317  001f a606          	ld	a,#6
4318  0021 cd0000        	call	_Enc28j60ReadReg
4320  0024 1b05          	add	a,(OFST+0,sp)
4321  0026 6b05          	ld	(OFST+0,sp),a
4322  0028 2402          	jrnc	L074
4323  002a 0c04          	inc	(OFST-1,sp)
4324  002c               L074:
4326                     ; 923   tsv_start++;
4328  002c 1e04          	ldw	x,(OFST-1,sp)
4329  002e 5c            	incw	x
4330  002f 1f04          	ldw	(OFST-1,sp),x
4332                     ; 926   Enc28j60WriteReg(BANK0_ERDPTL, (uint8_t)(tsv_start & 0x00ff));
4334  0031 5f            	clrw	x
4335  0032 7b05          	ld	a,(OFST+0,sp)
4336  0034 97            	ld	xl,a
4337  0035 cd0000        	call	_Enc28j60WriteReg
4339                     ; 927   Enc28j60WriteReg(BANK0_ERDPTH, (uint8_t)(tsv_start >> 8));
4341  0038 7b04          	ld	a,(OFST-1,sp)
4342  003a ae0100        	ldw	x,#256
4343  003d 97            	ld	xl,a
4344  003e cd0000        	call	_Enc28j60WriteReg
4346                     ; 930   select();
4348  0041 cd0000        	call	_select
4350                     ; 931   SpiWriteByte(OPCODE_RBM);
4352  0044 a63a          	ld	a,#58
4353  0046 cd0000        	call	_SpiWriteByte
4355                     ; 936     for (i=0; i<7; i++) {
4357  0049 4f            	clr	a
4358  004a 6b01          	ld	(OFST-4,sp),a
4360  004c               L7522:
4361                     ; 937       tsv_byte[i] = SpiReadByte(); // Bits 7-0
4363  004c 5f            	clrw	x
4364  004d 97            	ld	xl,a
4365  004e 89            	pushw	x
4366  004f cd0000        	call	_SpiReadByte
4368  0052 85            	popw	x
4369  0053 d70000        	ld	(_tsv_byte,x),a
4370                     ; 936     for (i=0; i<7; i++) {
4372  0056 0c01          	inc	(OFST-4,sp)
4376  0058 7b01          	ld	a,(OFST-4,sp)
4377  005a a107          	cp	a,#7
4378  005c 25ee          	jrult	L7522
4379                     ; 941   deselect();
4381  005e cd0000        	call	_deselect
4383                     ; 944 wait_timer(10);  // Wait 10 uS
4385  0061 ae000a        	ldw	x,#10
4386  0064 cd0000        	call	_wait_timer
4388                     ; 948   Enc28j60WriteReg(BANK0_ERDPTL, saved_ERDPTL);
4390  0067 7b02          	ld	a,(OFST-3,sp)
4391  0069 5f            	clrw	x
4392  006a 97            	ld	xl,a
4393  006b cd0000        	call	_Enc28j60WriteReg
4395                     ; 949   Enc28j60WriteReg(BANK0_ERDPTH, saved_ERDPTH);
4397  006e 7b03          	ld	a,(OFST-2,sp)
4398  0070 ae0100        	ldw	x,#256
4399  0073 97            	ld	xl,a
4400  0074 cd0000        	call	_Enc28j60WriteReg
4402                     ; 950 }
4405  0077 5b05          	addw	sp,#5
4406  0079 81            	ret	
4431                     	xdef	_Enc28j60WritePhy
4432                     	xdef	_Enc28j60ReadPhy
4433                     	xdef	_Enc28j60SwitchBank
4434                     	xdef	_Enc28j60ClearMaskReg
4435                     	xdef	_Enc28j60SetMaskReg
4436                     	xdef	_Enc28j60WriteReg
4437                     	xdef	_Enc28j60ReadReg
4438                     	xdef	_deselect
4439                     	xdef	_select
4440                     	switch	.bss
4441  0000               _tsv_byte:
4442  0000 000000000000  	ds.b	7
4443                     	xdef	_tsv_byte
4444                     	xref	_stored_uip_ethaddr_oct
4445                     	xref	_stored_config_settings
4446                     	xref	_RXERIF_counter
4447                     	xref	_wait_timer
4448                     	xdef	_read_TSV
4449                     	xdef	_Enc28j60Send
4450                     	xdef	_Enc28j60Receive
4451                     	xdef	_Enc28j60Init
4452                     	xref	_SpiReadChunk
4453                     	xref	_SpiReadByte
4454                     	xref	_SpiWriteChunk
4455                     	xref	_SpiWriteByte
4475                     	xref	c_lgadc
4476                     	end
