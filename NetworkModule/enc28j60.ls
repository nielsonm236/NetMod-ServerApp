   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Parser V4.11.14 - 18 Nov 2019
   3                     ; Generator (Limited) V4.4.11 - 19 Nov 2019
   4                     ; Optimizer V4.4.11 - 19 Nov 2019
2547                     ; 267 void select(void)
2547                     ; 268 {
2549                     .text:	section	.text,new
2550  0000               _select:
2554                     ; 270   PC_ODR &= (uint8_t)(~0x02);
2556  0000 7213500a      	bres	_PC_ODR,#1
2557                     ; 271   nop();
2560  0004 9d            	nop	
2562                     ; 272 }
2566  0005 81            	ret	
2591                     ; 275 void deselect(void)
2591                     ; 276 {
2592                     .text:	section	.text,new
2593  0000               _deselect:
2597                     ; 278   PC_ODR |= (uint8_t)0x02;
2599  0000 7212500a      	bset	_PC_ODR,#1
2600                     ; 279   nop();
2603  0004 9d            	nop	
2605                     ; 280 }
2609  0005 81            	ret	
2652                     ; 285 uint8_t Enc28j60ReadReg(uint8_t nRegister)
2652                     ; 286 {
2653                     .text:	section	.text,new
2654  0000               _Enc28j60ReadReg:
2656  0000 88            	push	a
2657  0001 88            	push	a
2658       00000001      OFST:	set	1
2661                     ; 289   select();
2663  0002 cd0000        	call	_select
2665                     ; 291   SpiWriteByte((uint8_t)(OPCODE_RCR | (nRegister & REGISTER_MASK)));
2667  0005 7b02          	ld	a,(OFST+1,sp)
2668  0007 a41f          	and	a,#31
2669  0009 cd0000        	call	_SpiWriteByte
2671                     ; 292   if (nRegister & REGISTER_NEEDDUMMY) SpiWriteByte(0);
2673  000c 7b02          	ld	a,(OFST+1,sp)
2674  000e 2a04          	jrpl	L1761
2677  0010 4f            	clr	a
2678  0011 cd0000        	call	_SpiWriteByte
2680  0014               L1761:
2681                     ; 293   nByte = SpiReadByte();
2683  0014 cd0000        	call	_SpiReadByte
2685  0017 6b01          	ld	(OFST+0,sp),a
2687                     ; 295   deselect();
2689  0019 cd0000        	call	_deselect
2691                     ; 297   return nByte;
2693  001c 7b01          	ld	a,(OFST+0,sp)
2696  001e 85            	popw	x
2697  001f 81            	ret	
2739                     ; 303 void Enc28j60WriteReg( uint8_t nRegister, uint8_t nData)
2739                     ; 304 {
2740                     .text:	section	.text,new
2741  0000               _Enc28j60WriteReg:
2743  0000 89            	pushw	x
2744       00000000      OFST:	set	0
2747                     ; 305   select();
2749  0001 cd0000        	call	_select
2751                     ; 307   SpiWriteByte((uint8_t)(OPCODE_WCR | (nRegister & REGISTER_MASK)));
2753  0004 7b01          	ld	a,(OFST+1,sp)
2754  0006 a41f          	and	a,#31
2755  0008 aa40          	or	a,#64
2756  000a cd0000        	call	_SpiWriteByte
2758                     ; 308   SpiWriteByte(nData);
2760  000d 7b02          	ld	a,(OFST+2,sp)
2761  000f cd0000        	call	_SpiWriteByte
2763                     ; 310   deselect();
2765  0012 cd0000        	call	_deselect
2767                     ; 311 }
2770  0015 85            	popw	x
2771  0016 81            	ret	
2813                     ; 316 void Enc28j60SetMaskReg(uint8_t nRegister, uint8_t nMask)
2813                     ; 317 {
2814                     .text:	section	.text,new
2815  0000               _Enc28j60SetMaskReg:
2817  0000 89            	pushw	x
2818       00000000      OFST:	set	0
2821                     ; 318   select();
2823  0001 cd0000        	call	_select
2825                     ; 320   SpiWriteByte((uint8_t)(OPCODE_BFS | (nRegister & REGISTER_MASK)));
2827  0004 7b01          	ld	a,(OFST+1,sp)
2828  0006 a41f          	and	a,#31
2829  0008 aa80          	or	a,#128
2830  000a cd0000        	call	_SpiWriteByte
2832                     ; 321   SpiWriteByte(nMask);
2834  000d 7b02          	ld	a,(OFST+2,sp)
2835  000f cd0000        	call	_SpiWriteByte
2837                     ; 323   deselect();
2839  0012 cd0000        	call	_deselect
2841                     ; 324 }
2844  0015 85            	popw	x
2845  0016 81            	ret	
2888                     ; 329 void Enc28j60ClearMaskReg( uint8_t nRegister, uint8_t nMask)
2888                     ; 330 {
2889                     .text:	section	.text,new
2890  0000               _Enc28j60ClearMaskReg:
2892  0000 89            	pushw	x
2893       00000000      OFST:	set	0
2896                     ; 331   select();
2898  0001 cd0000        	call	_select
2900                     ; 333   SpiWriteByte((uint8_t)(OPCODE_BFC | (nRegister & REGISTER_MASK)));
2902  0004 7b01          	ld	a,(OFST+1,sp)
2903  0006 a41f          	and	a,#31
2904  0008 aaa0          	or	a,#160
2905  000a cd0000        	call	_SpiWriteByte
2907                     ; 334   SpiWriteByte(nMask);
2909  000d 7b02          	ld	a,(OFST+2,sp)
2910  000f cd0000        	call	_SpiWriteByte
2912                     ; 336   deselect();
2914  0012 cd0000        	call	_deselect
2916                     ; 337 }
2919  0015 85            	popw	x
2920  0016 81            	ret	
2954                     ; 342 void Enc28j60SwitchBank(uint8_t nBank)
2954                     ; 343 {
2955                     .text:	section	.text,new
2956  0000               _Enc28j60SwitchBank:
2958  0000 88            	push	a
2959       00000000      OFST:	set	0
2962                     ; 347   Enc28j60ClearMaskReg(BANKX_ECON1, (3<<BANKX_ECON1_BSEL0));
2964  0001 ae1f03        	ldw	x,#7939
2965  0004 cd0000        	call	_Enc28j60ClearMaskReg
2967                     ; 348   Enc28j60SetMaskReg(BANKX_ECON1, (uint8_t)(nBank << BANKX_ECON1_BSEL0));
2969  0007 7b01          	ld	a,(OFST+1,sp)
2970  0009 ae1f00        	ldw	x,#7936
2971  000c 97            	ld	xl,a
2972  000d cd0000        	call	_Enc28j60SetMaskReg
2974                     ; 349 }
2977  0010 84            	pop	a
2978  0011 81            	ret	
3016                     ; 355 uint16_t Enc28j60ReadPhy(uint8_t nRegister)
3016                     ; 356 {
3017                     .text:	section	.text,new
3018  0000               _Enc28j60ReadPhy:
3020  0000 88            	push	a
3021  0001 89            	pushw	x
3022       00000002      OFST:	set	2
3025                     ; 357   Enc28j60SwitchBank(BANK2);
3027  0002 a602          	ld	a,#2
3028  0004 cd0000        	call	_Enc28j60SwitchBank
3030                     ; 358   Enc28j60WriteReg(BANK2_MIREGADR, nRegister);
3032  0007 7b03          	ld	a,(OFST+1,sp)
3033  0009 ae9400        	ldw	x,#37888
3034  000c 97            	ld	xl,a
3035  000d cd0000        	call	_Enc28j60WriteReg
3037                     ; 359   Enc28j60SetMaskReg(BANK2_MICMD, (1<<BANK2_MICMD_MIIRD));
3039  0010 ae9201        	ldw	x,#37377
3040  0013 cd0000        	call	_Enc28j60SetMaskReg
3042                     ; 360   Enc28j60SwitchBank(BANK3);
3044  0016 a603          	ld	a,#3
3045  0018 cd0000        	call	_Enc28j60SwitchBank
3048  001b 2001          	jra	L7771
3049  001d               L5771:
3050                     ; 361   while (Enc28j60ReadReg(BANK3_MISTAT) & (1 <<BANK3_MISTAT_BUSY)) nop();
3053  001d 9d            	nop	
3055  001e               L7771:
3058  001e a68a          	ld	a,#138
3059  0020 cd0000        	call	_Enc28j60ReadReg
3061  0023 a501          	bcp	a,#1
3062  0025 26f6          	jrne	L5771
3063                     ; 362   Enc28j60SwitchBank(BANK2);
3066  0027 a602          	ld	a,#2
3067  0029 cd0000        	call	_Enc28j60SwitchBank
3069                     ; 363   Enc28j60ClearMaskReg(BANK2_MICMD, (1<<BANK2_MICMD_MIIRD));
3071  002c ae9201        	ldw	x,#37377
3072  002f cd0000        	call	_Enc28j60ClearMaskReg
3074                     ; 365   return ((uint16_t) Enc28j60ReadReg(BANK2_MIRDL) << 0)
3074                     ; 366        | ((uint16_t) Enc28j60ReadReg(BANK2_MIRDH) << 8);
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
3140                     ; 373 void Enc28j60WritePhy( uint8_t nRegister, uint16_t nData)
3140                     ; 374 {
3141                     .text:	section	.text,new
3142  0000               _Enc28j60WritePhy:
3144  0000 88            	push	a
3145       00000000      OFST:	set	0
3148                     ; 375   Enc28j60SwitchBank(BANK2);
3150  0001 a602          	ld	a,#2
3151  0003 cd0000        	call	_Enc28j60SwitchBank
3153                     ; 376   Enc28j60WriteReg(BANK2_MIREGADR, nRegister);
3155  0006 7b01          	ld	a,(OFST+1,sp)
3156  0008 ae9400        	ldw	x,#37888
3157  000b 97            	ld	xl,a
3158  000c cd0000        	call	_Enc28j60WriteReg
3160                     ; 377   Enc28j60WriteReg(BANK2_MIWRL, (uint8_t)(nData >> 0));
3162  000f 7b05          	ld	a,(OFST+5,sp)
3163  0011 ae9600        	ldw	x,#38400
3164  0014 97            	ld	xl,a
3165  0015 cd0000        	call	_Enc28j60WriteReg
3167                     ; 378   Enc28j60WriteReg(BANK2_MIWRH, (uint8_t)(nData >> 8));
3169  0018 7b04          	ld	a,(OFST+4,sp)
3170  001a ae9700        	ldw	x,#38656
3171  001d 97            	ld	xl,a
3172  001e cd0000        	call	_Enc28j60WriteReg
3174                     ; 379   Enc28j60SwitchBank(BANK3);
3176  0021 a603          	ld	a,#3
3177  0023 cd0000        	call	_Enc28j60SwitchBank
3180  0026 2001          	jra	L3202
3181  0028               L1202:
3182                     ; 380   while (Enc28j60ReadReg(BANK3_MISTAT) & (1 <<BANK3_MISTAT_BUSY)) nop();
3185  0028 9d            	nop	
3187  0029               L3202:
3190  0029 a68a          	ld	a,#138
3191  002b cd0000        	call	_Enc28j60ReadReg
3193  002e a501          	bcp	a,#1
3194  0030 26f6          	jrne	L1202
3195                     ; 381 }
3199  0032 84            	pop	a
3200  0033 81            	ret	
3237                     ; 384 void Enc28j60Init(void)
3237                     ; 385 {
3238                     .text:	section	.text,new
3239  0000               _Enc28j60Init:
3243                     ; 389   deselect(); // Just makes sure the -CS is not selected
3245  0000 cd0000        	call	_deselect
3248  0003 2001          	jra	L1402
3249  0005               L7302:
3250                     ; 403   while (!(Enc28j60ReadReg(BANKX_ESTAT) & (1<<BANKX_ESTAT_CLKRDY))) nop();
3253  0005 9d            	nop	
3255  0006               L1402:
3258  0006 a61d          	ld	a,#29
3259  0008 cd0000        	call	_Enc28j60ReadReg
3261  000b a501          	bcp	a,#1
3262  000d 27f6          	jreq	L7302
3263                     ; 406   select();
3266  000f cd0000        	call	_select
3268                     ; 407   SpiWriteByte(OPCODE_SRC); // Reset command
3270  0012 a6ff          	ld	a,#255
3271  0014 cd0000        	call	_SpiWriteByte
3273                     ; 408   deselect();
3275  0017 cd0000        	call	_deselect
3277                     ; 416   wait_timer((uint16_t)10000); // delay 10 ms
3279  001a ae2710        	ldw	x,#10000
3280  001d cd0000        	call	_wait_timer
3282                     ; 419   Enc28j60WritePhy(PHY_PHCON1, (uint16_t)(1<<PHY_PHCON1_PRST)); // Reset command
3284  0020 ae8000        	ldw	x,#32768
3285  0023 89            	pushw	x
3286  0024 4f            	clr	a
3287  0025 cd0000        	call	_Enc28j60WritePhy
3289  0028 85            	popw	x
3291  0029 2001          	jra	L7402
3292  002b               L5402:
3293                     ; 421   while (Enc28j60ReadPhy(PHY_PHCON1) & (uint16_t)(1<<PHY_PHCON1_PRST)) nop();
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
3312                     ; 425   if (stored_config_settings[3] == '1') {
3315  003a c60003        	ld	a,_stored_config_settings+3
3316  003d a131          	cp	a,#49
3317  003f 2609          	jrne	L3502
3318                     ; 428     Enc28j60WritePhy(PHY_PHCON1, (uint16_t)(1<<PHY_PHCON1_PDPXMD));
3320  0041 ae0100        	ldw	x,#256
3321  0044 89            	pushw	x
3322  0045 4f            	clr	a
3323  0046 cd0000        	call	_Enc28j60WritePhy
3325  0049 85            	popw	x
3326  004a               L3502:
3327                     ; 433   Enc28j60SwitchBank(BANK0);
3329  004a 4f            	clr	a
3330  004b cd0000        	call	_Enc28j60SwitchBank
3332                     ; 437   Enc28j60WriteReg(BANK0_ERXSTL, (uint8_t) (ENC28J60_RXSTART >> 0));
3334  004e ae0800        	ldw	x,#2048
3335  0051 cd0000        	call	_Enc28j60WriteReg
3337                     ; 438   Enc28j60WriteReg(BANK0_ERXSTH, (uint8_t) (ENC28J60_RXSTART >> 8));
3339  0054 ae0900        	ldw	x,#2304
3340  0057 cd0000        	call	_Enc28j60WriteReg
3342                     ; 439   Enc28j60WriteReg(BANK0_ERXNDL, (uint8_t) (ENC28J60_RXEND >> 0));
3344  005a ae0aff        	ldw	x,#2815
3345  005d cd0000        	call	_Enc28j60WriteReg
3347                     ; 440   Enc28j60WriteReg(BANK0_ERXNDH, (uint8_t) (ENC28J60_RXEND >> 8));
3349  0060 ae0b17        	ldw	x,#2839
3350  0063 cd0000        	call	_Enc28j60WriteReg
3352                     ; 442   Enc28j60WriteReg(BANK0_ERDPTL, (uint8_t) (ENC28J60_RXSTART >> 0));
3354  0066 5f            	clrw	x
3355  0067 cd0000        	call	_Enc28j60WriteReg
3357                     ; 443   Enc28j60WriteReg(BANK0_ERDPTH, (uint8_t) (ENC28J60_RXSTART >> 8));
3359  006a ae0100        	ldw	x,#256
3360  006d cd0000        	call	_Enc28j60WriteReg
3362                     ; 446   Enc28j60WriteReg(BANK0_ERXRDPTL, (uint8_t) (ENC28J60_RXEND >> 0));
3364  0070 ae0cff        	ldw	x,#3327
3365  0073 cd0000        	call	_Enc28j60WriteReg
3367                     ; 447   Enc28j60WriteReg(BANK0_ERXRDPTH, (uint8_t) (ENC28J60_RXEND >> 8));
3369  0076 ae0d17        	ldw	x,#3351
3370  0079 cd0000        	call	_Enc28j60WriteReg
3372                     ; 449   Enc28j60WriteReg(BANK0_ETXSTL, (uint8_t) (ENC28J60_TXSTART >> 0));
3374  007c ae0400        	ldw	x,#1024
3375  007f cd0000        	call	_Enc28j60WriteReg
3377                     ; 450   Enc28j60WriteReg(BANK0_ETXSTH, (uint8_t) (ENC28J60_TXSTART >> 8));
3379  0082 ae0518        	ldw	x,#1304
3380  0085 cd0000        	call	_Enc28j60WriteReg
3382                     ; 455   Enc28j60SwitchBank(BANK1);
3384  0088 a601          	ld	a,#1
3385  008a cd0000        	call	_Enc28j60SwitchBank
3387                     ; 502   Enc28j60WriteReg(BANK1_ERXFCON, (uint8_t)0xa1);    // Allows packets if MAC matches
3389  008d ae18a1        	ldw	x,#6305
3390  0090 cd0000        	call	_Enc28j60WriteReg
3392                     ; 521   Enc28j60SwitchBank(BANK2);
3394  0093 a602          	ld	a,#2
3395  0095 cd0000        	call	_Enc28j60SwitchBank
3397                     ; 524   Enc28j60WriteReg(BANK2_MACON1, (1<<BANK2_MACON1_MARXEN));
3399  0098 ae8001        	ldw	x,#32769
3400  009b cd0000        	call	_Enc28j60WriteReg
3402                     ; 547   if (stored_config_settings[3] == '0') {
3404  009e c60003        	ld	a,_stored_config_settings+3
3405  00a1 a130          	cp	a,#48
3406  00a3 2609          	jrne	L5502
3407                     ; 549     Enc28j60SetMaskReg(BANK2_MACON3, (1<<BANK2_MACON3_TXCRCEN)|(1<<BANK2_MACON3_PADCFG0)|(1<<BANK2_MACON3_FRMLNEN));
3409  00a5 ae8232        	ldw	x,#33330
3410  00a8 cd0000        	call	_Enc28j60SetMaskReg
3412  00ab c60003        	ld	a,_stored_config_settings+3
3413  00ae               L5502:
3414                     ; 551   if (stored_config_settings[3] == '1') {
3416  00ae a131          	cp	a,#49
3417  00b0 2606          	jrne	L7502
3418                     ; 554     Enc28j60SetMaskReg(BANK2_MACON3, (1<<BANK2_MACON3_TXCRCEN) | (1<<BANK2_MACON3_PADCFG0) | (1<<BANK2_MACON3_FRMLNEN) | (1<<BANK2_MACON3_FULDPX));
3420  00b2 ae8233        	ldw	x,#33331
3421  00b5 cd0000        	call	_Enc28j60SetMaskReg
3423  00b8               L7502:
3424                     ; 558   Enc28j60SetMaskReg(BANK2_MACON4, (1<<BANK2_MACON4_DEFER));
3426  00b8 ae8340        	ldw	x,#33600
3427  00bb cd0000        	call	_Enc28j60SetMaskReg
3429                     ; 562   Enc28j60WriteReg(BANK2_MAMXFLL, (uint8_t) ((ENC28J60_MAXFRAME + 4) >> 0));
3431  00be ae8af8        	ldw	x,#35576
3432  00c1 cd0000        	call	_Enc28j60WriteReg
3434                     ; 563   Enc28j60WriteReg(BANK2_MAMXFLH, (uint8_t) ((ENC28J60_MAXFRAME + 4) >> 8));
3436  00c4 ae9001        	ldw	x,#36865
3437  00c7 cd0000        	call	_Enc28j60WriteReg
3439                     ; 566   Enc28j60WriteReg(BANK2_MAIPGL, 0x12);
3441  00ca ae8612        	ldw	x,#34322
3442  00cd cd0000        	call	_Enc28j60WriteReg
3444                     ; 568   if (stored_config_settings[3] == '0') {
3446  00d0 c60003        	ld	a,_stored_config_settings+3
3447  00d3 a130          	cp	a,#48
3448  00d5 2609          	jrne	L1602
3449                     ; 570     Enc28j60WriteReg(BANK2_MAIPGH, 0x0C);
3451  00d7 ae870c        	ldw	x,#34572
3452  00da cd0000        	call	_Enc28j60WriteReg
3454  00dd c60003        	ld	a,_stored_config_settings+3
3455  00e0               L1602:
3456                     ; 577   if (stored_config_settings[3] == '0') {
3458  00e0 a130          	cp	a,#48
3459  00e2 2609          	jrne	L3602
3460                     ; 579     Enc28j60WriteReg(BANK2_MABBIPG, 0x12);
3462  00e4 ae8412        	ldw	x,#33810
3463  00e7 cd0000        	call	_Enc28j60WriteReg
3465  00ea c60003        	ld	a,_stored_config_settings+3
3466  00ed               L3602:
3467                     ; 581   if (stored_config_settings[3] == '1') {
3469  00ed a131          	cp	a,#49
3470  00ef 2606          	jrne	L5602
3471                     ; 583     Enc28j60WriteReg(BANK2_MABBIPG, 0x15);
3473  00f1 ae8415        	ldw	x,#33813
3474  00f4 cd0000        	call	_Enc28j60WriteReg
3476  00f7               L5602:
3477                     ; 588   Enc28j60SwitchBank(BANK3);
3479  00f7 a603          	ld	a,#3
3480  00f9 cd0000        	call	_Enc28j60SwitchBank
3482                     ; 591   Enc28j60WriteReg(BANK3_MAADR5, stored_uip_ethaddr_oct[5]);  // MAC MSB
3484  00fc c60005        	ld	a,_stored_uip_ethaddr_oct+5
3485  00ff ae8400        	ldw	x,#33792
3486  0102 97            	ld	xl,a
3487  0103 cd0000        	call	_Enc28j60WriteReg
3489                     ; 592   Enc28j60WriteReg(BANK3_MAADR4, stored_uip_ethaddr_oct[4]);
3491  0106 c60004        	ld	a,_stored_uip_ethaddr_oct+4
3492  0109 ae8500        	ldw	x,#34048
3493  010c 97            	ld	xl,a
3494  010d cd0000        	call	_Enc28j60WriteReg
3496                     ; 593   Enc28j60WriteReg(BANK3_MAADR3, stored_uip_ethaddr_oct[3]);
3498  0110 c60003        	ld	a,_stored_uip_ethaddr_oct+3
3499  0113 ae8200        	ldw	x,#33280
3500  0116 97            	ld	xl,a
3501  0117 cd0000        	call	_Enc28j60WriteReg
3503                     ; 594   Enc28j60WriteReg(BANK3_MAADR2, stored_uip_ethaddr_oct[2]);
3505  011a c60002        	ld	a,_stored_uip_ethaddr_oct+2
3506  011d ae8300        	ldw	x,#33536
3507  0120 97            	ld	xl,a
3508  0121 cd0000        	call	_Enc28j60WriteReg
3510                     ; 595   Enc28j60WriteReg(BANK3_MAADR1, stored_uip_ethaddr_oct[1]);
3512  0124 c60001        	ld	a,_stored_uip_ethaddr_oct+1
3513  0127 ae8000        	ldw	x,#32768
3514  012a 97            	ld	xl,a
3515  012b cd0000        	call	_Enc28j60WriteReg
3517                     ; 596   Enc28j60WriteReg(BANK3_MAADR0, stored_uip_ethaddr_oct[0]);  // MAC LSB
3519  012e c60000        	ld	a,_stored_uip_ethaddr_oct
3520  0131 ae8100        	ldw	x,#33024
3521  0134 97            	ld	xl,a
3522  0135 cd0000        	call	_Enc28j60WriteReg
3524                     ; 599   Enc28j60WritePhy(PHY_PHCON2, (1<<PHY_PHCON2_HDLDIS));
3526  0138 ae0100        	ldw	x,#256
3527  013b 89            	pushw	x
3528  013c a610          	ld	a,#16
3529  013e cd0000        	call	_Enc28j60WritePhy
3531  0141 85            	popw	x
3532                     ; 603   Enc28j60WritePhy(PHY_PHLCON,
3532                     ; 604     (ENC28J60_LEDB<<PHY_PHLCON_LBCFG0)|
3532                     ; 605     (ENC28J60_LEDA<<PHY_PHLCON_LACFG0)|
3532                     ; 606     (1<<PHY_PHLCON_STRCH)|0x3000);
3534  0142 ae31c2        	ldw	x,#12738
3535  0145 89            	pushw	x
3536  0146 a614          	ld	a,#20
3537  0148 cd0000        	call	_Enc28j60WritePhy
3539  014b c60003        	ld	a,_stored_config_settings+3
3540  014e a130          	cp	a,#48
3541  0150 85            	popw	x
3542                     ; 608   if (stored_config_settings[3] == '0') {
3544  0151 2607          	jrne	L7602
3545                     ; 613     Enc28j60WritePhy(PHY_PHCON1, 0x0000);
3547  0153 5f            	clrw	x
3548  0154 89            	pushw	x
3549  0155 4f            	clr	a
3550  0156 cd0000        	call	_Enc28j60WritePhy
3552  0159 85            	popw	x
3553  015a               L7602:
3554                     ; 617   Enc28j60SetMaskReg(BANKX_ECON1, (1<<BANKX_ECON1_RXEN));
3556  015a ae1f04        	ldw	x,#7940
3558                     ; 618 }
3561  015d cc0000        	jp	_Enc28j60SetMaskReg
3620                     ; 621 uint16_t Enc28j60Receive(uint8_t* pBuffer)
3620                     ; 622 {
3621                     .text:	section	.text,new
3622  0000               _Enc28j60Receive:
3624  0000 89            	pushw	x
3625  0001 5204          	subw	sp,#4
3626       00000004      OFST:	set	4
3629                     ; 629   if (Enc28j60ReadReg(BANKX_EIR) & 0x01) {
3631  0003 a61c          	ld	a,#28
3632  0005 cd0000        	call	_Enc28j60ReadReg
3634  0008 a501          	bcp	a,#1
3635  000a 2708          	jreq	L3112
3636                     ; 630     RXERIF_counter++;
3638  000c ae0000        	ldw	x,#_RXERIF_counter
3639  000f a601          	ld	a,#1
3640  0011 cd0000        	call	c_lgadc
3642  0014               L3112:
3643                     ; 635   Enc28j60SwitchBank(BANK1);
3645  0014 a601          	ld	a,#1
3646  0016 cd0000        	call	_Enc28j60SwitchBank
3648                     ; 636   if (Enc28j60ReadReg(BANK1_EPKTCNT) == 0) return 0;
3650  0019 a619          	ld	a,#25
3651  001b cd0000        	call	_Enc28j60ReadReg
3653  001e 4d            	tnz	a
3654  001f 2604          	jrne	L5112
3657  0021 5f            	clrw	x
3659  0022 cc00aa        	jra	L433
3660  0025               L5112:
3661                     ; 638   select();
3663  0025 cd0000        	call	_select
3665                     ; 640   SpiWriteByte(OPCODE_RBM);	 // Set ENC28J60 to send receive data on SPI
3667  0028 a63a          	ld	a,#58
3668  002a cd0000        	call	_SpiWriteByte
3670                     ; 643   nNextPacket = ((uint16_t) SpiReadByte() << 0);
3672  002d cd0000        	call	_SpiReadByte
3674  0030 5f            	clrw	x
3675  0031 97            	ld	xl,a
3676  0032 1f03          	ldw	(OFST-1,sp),x
3678                     ; 644   nNextPacket |= ((uint16_t) SpiReadByte() << 8);
3680  0034 cd0000        	call	_SpiReadByte
3682  0037 5f            	clrw	x
3683  0038 97            	ld	xl,a
3684  0039 7b04          	ld	a,(OFST+0,sp)
3685  003b 01            	rrwa	x,a
3686  003c 1a03          	or	a,(OFST-1,sp)
3687  003e 01            	rrwa	x,a
3688  003f 1f03          	ldw	(OFST-1,sp),x
3690                     ; 647   nBytes = ((uint16_t) SpiReadByte() << 0);
3692  0041 cd0000        	call	_SpiReadByte
3694  0044 5f            	clrw	x
3695  0045 97            	ld	xl,a
3696  0046 1f01          	ldw	(OFST-3,sp),x
3698                     ; 648   nBytes |= ((uint16_t) SpiReadByte() << 8);
3700  0048 cd0000        	call	_SpiReadByte
3702  004b 5f            	clrw	x
3703  004c 97            	ld	xl,a
3704  004d 7b02          	ld	a,(OFST-2,sp)
3705  004f 01            	rrwa	x,a
3706  0050 1a01          	or	a,(OFST-3,sp)
3707  0052 01            	rrwa	x,a
3709                     ; 649   nBytes -= 4;
3711  0053 1d0004        	subw	x,#4
3712  0056 1f01          	ldw	(OFST-3,sp),x
3714                     ; 652   SpiReadByte();
3716  0058 cd0000        	call	_SpiReadByte
3718                     ; 653   SpiReadByte();
3720  005b cd0000        	call	_SpiReadByte
3722                     ; 660   if (nBytes <= ENC28J60_MAXFRAME) SpiReadChunk(pBuffer, nBytes);
3724  005e 1e01          	ldw	x,(OFST-3,sp)
3725  0060 a301f5        	cpw	x,#501
3726  0063 2407          	jruge	L7112
3729  0065 89            	pushw	x
3730  0066 1e07          	ldw	x,(OFST+3,sp)
3731  0068 cd0000        	call	_SpiReadChunk
3733  006b 85            	popw	x
3734  006c               L7112:
3735                     ; 662   deselect();
3737  006c cd0000        	call	_deselect
3739                     ; 664   Enc28j60SwitchBank(BANK0);
3741  006f 4f            	clr	a
3742  0070 cd0000        	call	_Enc28j60SwitchBank
3744                     ; 666   Enc28j60WriteReg(BANK0_ERDPTL , (uint8_t) (nNextPacket >> 0));
3746  0073 7b04          	ld	a,(OFST+0,sp)
3747  0075 5f            	clrw	x
3748  0076 97            	ld	xl,a
3749  0077 cd0000        	call	_Enc28j60WriteReg
3751                     ; 667   Enc28j60WriteReg(BANK0_ERDPTH , (uint8_t) (nNextPacket >> 8));
3753  007a 7b03          	ld	a,(OFST-1,sp)
3754  007c ae0100        	ldw	x,#256
3755  007f 97            	ld	xl,a
3756  0080 cd0000        	call	_Enc28j60WriteReg
3758                     ; 671   nNextPacket -= 1;
3760  0083 1e03          	ldw	x,(OFST-1,sp)
3761  0085 5a            	decw	x
3763                     ; 672   if (nNextPacket == ( ((uint16_t)ENC28J60_RXSTART) - 1 )) {
3765  0086 a3ffff        	cpw	x,#65535
3766  0089 2603          	jrne	L1212
3767                     ; 675     nNextPacket = ENC28J60_RXEND;
3769  008b ae17ff        	ldw	x,#6143
3771  008e               L1212:
3772  008e 1f03          	ldw	(OFST-1,sp),x
3773                     ; 678   Enc28j60WriteReg(BANK0_ERXRDPTL, (uint8_t)(nNextPacket >> 0));
3775  0090 ae0c00        	ldw	x,#3072
3776  0093 7b04          	ld	a,(OFST+0,sp)
3777  0095 97            	ld	xl,a
3778  0096 cd0000        	call	_Enc28j60WriteReg
3780                     ; 679   Enc28j60WriteReg(BANK0_ERXRDPTH, (uint8_t)(nNextPacket >> 8));
3782  0099 7b03          	ld	a,(OFST-1,sp)
3783  009b ae0d00        	ldw	x,#3328
3784  009e 97            	ld	xl,a
3785  009f cd0000        	call	_Enc28j60WriteReg
3787                     ; 682   Enc28j60SetMaskReg(BANKX_ECON2 , (1<<BANKX_ECON2_PKTDEC));
3789  00a2 ae1e40        	ldw	x,#7744
3790  00a5 cd0000        	call	_Enc28j60SetMaskReg
3792                     ; 684   return nBytes;
3794  00a8 1e01          	ldw	x,(OFST-3,sp)
3796  00aa               L433:
3798  00aa 5b06          	addw	sp,#6
3799  00ac 81            	ret	
3884                     ; 688 void Enc28j60Send(uint8_t* pBuffer, uint16_t nBytes)
3884                     ; 689 {
3885                     .text:	section	.text,new
3886  0000               _Enc28j60Send:
3888  0000 89            	pushw	x
3889  0001 5205          	subw	sp,#5
3890       00000005      OFST:	set	5
3893                     ; 690   uint16_t TxEnd = ENC28J60_TXSTART + nBytes;
3895  0003 1e0a          	ldw	x,(OFST+5,sp)
3896  0005 1c1800        	addw	x,#6144
3897  0008 1f02          	ldw	(OFST-3,sp),x
3899                     ; 691   uint8_t i = 200;
3901  000a a6c8          	ld	a,#200
3902  000c 6b04          	ld	(OFST-1,sp),a
3904                     ; 694   txerif_temp = 0;
3906  000e 0f05          	clr	(OFST+0,sp)
3909  0010 2074          	jra	L7512
3910  0012               L3512:
3911                     ; 702     if (!(Enc28j60ReadReg(BANKX_ECON1) & (1<<BANKX_ECON1_TXRTS))) break;
3913  0012 a61f          	ld	a,#31
3914  0014 cd0000        	call	_Enc28j60ReadReg
3916  0017 a508          	bcp	a,#8
3917  0019 2665          	jrne	L3612
3919  001b               L1612:
3920                     ; 706   Enc28j60SwitchBank(BANK0);
3922  001b 4f            	clr	a
3923  001c cd0000        	call	_Enc28j60SwitchBank
3925                     ; 707   Enc28j60WriteReg(BANK0_EWRPTL, (uint8_t) (ENC28J60_TXSTART >> 0));
3927  001f ae0200        	ldw	x,#512
3928  0022 cd0000        	call	_Enc28j60WriteReg
3930                     ; 708   Enc28j60WriteReg(BANK0_EWRPTH, (uint8_t) (ENC28J60_TXSTART >> 8));
3932  0025 ae0318        	ldw	x,#792
3933  0028 cd0000        	call	_Enc28j60WriteReg
3935                     ; 709   Enc28j60WriteReg(BANK0_ETXNDL, (uint8_t) (TxEnd >> 0));
3937  002b 7b03          	ld	a,(OFST-2,sp)
3938  002d ae0600        	ldw	x,#1536
3939  0030 97            	ld	xl,a
3940  0031 cd0000        	call	_Enc28j60WriteReg
3942                     ; 710   Enc28j60WriteReg(BANK0_ETXNDH, (uint8_t) (TxEnd >> 8));	
3944  0034 7b02          	ld	a,(OFST-3,sp)
3945  0036 ae0700        	ldw	x,#1792
3946  0039 97            	ld	xl,a
3947  003a cd0000        	call	_Enc28j60WriteReg
3949                     ; 712   select();
3951  003d cd0000        	call	_select
3953                     ; 714   SpiWriteByte(OPCODE_WBM);	 // Set ENC28J60 to receive transmit data on SPI
3955  0040 a67a          	ld	a,#122
3956  0042 cd0000        	call	_SpiWriteByte
3958                     ; 716   SpiWriteByte(0);		 // Per-packet-control-byte
3960  0045 4f            	clr	a
3961  0046 cd0000        	call	_SpiWriteByte
3963                     ; 728   SpiWriteChunk(pBuffer, nBytes); // Copy data to the ENC28J60 transmit buffer
3965  0049 1e0a          	ldw	x,(OFST+5,sp)
3966  004b 89            	pushw	x
3967  004c 1e08          	ldw	x,(OFST+3,sp)
3968  004e cd0000        	call	_SpiWriteChunk
3970  0051 85            	popw	x
3971                     ; 730   deselect();
3973  0052 cd0000        	call	_deselect
3975                     ; 799     if (Enc28j60ReadReg(BANKX_EIR) & (1<<BANKX_EIR_TXERIF)) {
3977  0055 a61c          	ld	a,#28
3978  0057 cd0000        	call	_Enc28j60ReadReg
3980  005a a502          	bcp	a,#2
3981  005c 2731          	jreq	L5612
3982                     ; 801       TXERIF_counter++;
3984  005e ae0000        	ldw	x,#_TXERIF_counter
3985  0061 a601          	ld	a,#1
3986  0063 cd0000        	call	c_lgadc
3988                     ; 803       Enc28j60SetMaskReg(BANKX_ECON1, (1<<BANKX_ECON1_TXRST));
3990  0066 ae1f80        	ldw	x,#8064
3991  0069 cd0000        	call	_Enc28j60SetMaskReg
3993                     ; 805       Enc28j60ClearMaskReg(BANKX_ECON1, (1<<BANKX_ECON1_TXRST));
3995  006c ae1f80        	ldw	x,#8064
3996  006f cd0000        	call	_Enc28j60ClearMaskReg
3998                     ; 807       Enc28j60ClearMaskReg(BANKX_EIR, (1<<BANKX_EIR_TXERIF));
4000  0072 ae1c02        	ldw	x,#7170
4001  0075 cd0000        	call	_Enc28j60ClearMaskReg
4003                     ; 809       Enc28j60ClearMaskReg(BANKX_EIR, (1<<BANKX_EIR_TXIF));
4005  0078 ae1c08        	ldw	x,#7176
4006  007b cd0000        	call	_Enc28j60ClearMaskReg
4008  007e 200f          	jra	L5612
4009  0080               L3612:
4010                     ; 703     wait_timer(500);  // Wait 500 uS
4012  0080 ae01f4        	ldw	x,#500
4013  0083 cd0000        	call	_wait_timer
4015  0086               L7512:
4016                     ; 701   while (i--) {
4018  0086 7b04          	ld	a,(OFST-1,sp)
4019  0088 0a04          	dec	(OFST-1,sp)
4021  008a 4d            	tnz	a
4022  008b 2685          	jrne	L3512
4023  008d 208c          	jra	L1612
4024  008f               L5612:
4025                     ; 813     Enc28j60SetMaskReg(BANKX_ECON1, (1<<BANKX_ECON1_TXRTS));
4027  008f ae1f08        	ldw	x,#7944
4028  0092 cd0000        	call	_Enc28j60SetMaskReg
4031  0095 2001          	jra	L1712
4032  0097               L7612:
4033                     ; 818         && !(Enc28j60ReadReg(BANKX_EIR) & (1<<BANKX_EIR_TXERIF))) nop();
4036  0097 9d            	nop	
4038  0098               L1712:
4039                     ; 817     while (!(Enc28j60ReadReg(BANKX_EIR) & (1<<BANKX_EIR_TXIF))
4039                     ; 818         && !(Enc28j60ReadReg(BANKX_EIR) & (1<<BANKX_EIR_TXERIF))) nop();
4041  0098 a61c          	ld	a,#28
4042  009a cd0000        	call	_Enc28j60ReadReg
4044  009d a508          	bcp	a,#8
4045  009f 2609          	jrne	L5712
4047  00a1 a61c          	ld	a,#28
4048  00a3 cd0000        	call	_Enc28j60ReadReg
4050  00a6 a502          	bcp	a,#2
4051  00a8 27ed          	jreq	L7612
4052  00aa               L5712:
4053                     ; 821     if (Enc28j60ReadReg(BANKX_EIR) & (1<<BANKX_EIR_TXERIF)) txerif_temp = 1;
4056  00aa a61c          	ld	a,#28
4057  00ac cd0000        	call	_Enc28j60ReadReg
4059  00af a502          	bcp	a,#2
4060  00b1 2704          	jreq	L7712
4063  00b3 a601          	ld	a,#1
4064  00b5 6b05          	ld	(OFST+0,sp),a
4066  00b7               L7712:
4067                     ; 824     if (!(Enc28j60ReadReg(BANKX_EIR) & (1<<BANKX_EIR_TXIF))) {
4069  00b7 a61c          	ld	a,#28
4070  00b9 cd0000        	call	_Enc28j60ReadReg
4072  00bc a508          	bcp	a,#8
4073  00be 2606          	jrne	L1022
4074                     ; 825       Enc28j60ClearMaskReg(BANKX_ECON1, (1<<BANKX_ECON1_TXRTS));
4076  00c0 ae1f08        	ldw	x,#7944
4077  00c3 cd0000        	call	_Enc28j60ClearMaskReg
4079  00c6               L1022:
4080                     ; 829     if (txerif_temp) {
4082  00c6 7b05          	ld	a,(OFST+0,sp)
4083  00c8 2777          	jreq	L3022
4084                     ; 831       TXERIF_counter++;
4086  00ca ae0000        	ldw	x,#_TXERIF_counter
4087  00cd a601          	ld	a,#1
4088  00cf cd0000        	call	c_lgadc
4090                     ; 833       for (i = 0; i < 16; i++) {
4092  00d2 0f04          	clr	(OFST-1,sp)
4094  00d4               L5022:
4095                     ; 835 	read_TSV();
4097  00d4 cd0000        	call	_read_TSV
4099                     ; 839         late_collision = 0;
4101                     ; 840         if (tsv_byte[3] & 0x20) late_collision = 1;
4103  00d7 720b000365    	btjf	_tsv_byte+3,#5,L3022
4106  00dc a601          	ld	a,#1
4107  00de 6b01          	ld	(OFST-4,sp),a
4110                     ; 844         if (txerif_temp && (late_collision)) {
4112  00e0 7b05          	ld	a,(OFST+0,sp)
4113  00e2 2755          	jreq	L7122
4115  00e4 7b01          	ld	a,(OFST-4,sp)
4116  00e6 2751          	jreq	L7122
4117                     ; 845 	  txerif_temp = 0;
4119  00e8 0f05          	clr	(OFST+0,sp)
4121                     ; 848           Enc28j60SetMaskReg(BANKX_ECON1, (1<<BANKX_ECON1_TXRST));
4123  00ea ae1f80        	ldw	x,#8064
4124  00ed cd0000        	call	_Enc28j60SetMaskReg
4126                     ; 850           Enc28j60ClearMaskReg(BANKX_ECON1, (1<<BANKX_ECON1_TXRST));
4128  00f0 ae1f80        	ldw	x,#8064
4129  00f3 cd0000        	call	_Enc28j60ClearMaskReg
4131                     ; 852           Enc28j60ClearMaskReg(BANKX_EIR, (1<<BANKX_EIR_TXERIF));
4133  00f6 ae1c02        	ldw	x,#7170
4134  00f9 cd0000        	call	_Enc28j60ClearMaskReg
4136                     ; 854           Enc28j60ClearMaskReg(BANKX_EIR, (1<<BANKX_EIR_TXIF));
4138  00fc ae1c08        	ldw	x,#7176
4139  00ff cd0000        	call	_Enc28j60ClearMaskReg
4141                     ; 856           Enc28j60SetMaskReg(BANKX_ECON1, (1<<BANKX_ECON1_TXRTS));
4143  0102 ae1f08        	ldw	x,#7944
4144  0105 cd0000        	call	_Enc28j60SetMaskReg
4147  0108 2001          	jra	L3222
4148  010a               L1222:
4149                     ; 860               && !(Enc28j60ReadReg(BANKX_EIR) & (1<<BANKX_EIR_TXERIF))) nop();
4152  010a 9d            	nop	
4154  010b               L3222:
4155                     ; 859           while (!(Enc28j60ReadReg(BANKX_EIR) & (1<<BANKX_EIR_TXIF))
4155                     ; 860               && !(Enc28j60ReadReg(BANKX_EIR) & (1<<BANKX_EIR_TXERIF))) nop();
4157  010b a61c          	ld	a,#28
4158  010d cd0000        	call	_Enc28j60ReadReg
4160  0110 a508          	bcp	a,#8
4161  0112 2609          	jrne	L7222
4163  0114 a61c          	ld	a,#28
4164  0116 cd0000        	call	_Enc28j60ReadReg
4166  0119 a502          	bcp	a,#2
4167  011b 27ed          	jreq	L1222
4168  011d               L7222:
4169                     ; 862             if (Enc28j60ReadReg(BANKX_EIR) & (1<<BANKX_EIR_TXERIF)) txerif_temp = 1;
4172  011d a61c          	ld	a,#28
4173  011f cd0000        	call	_Enc28j60ReadReg
4175  0122 a502          	bcp	a,#2
4176  0124 2704          	jreq	L1322
4179  0126 a601          	ld	a,#1
4180  0128 6b05          	ld	(OFST+0,sp),a
4182  012a               L1322:
4183                     ; 864           if (!(Enc28j60ReadReg(BANKX_EIR) & (1<<BANKX_EIR_TXIF))) {
4185  012a a61c          	ld	a,#28
4186  012c cd0000        	call	_Enc28j60ReadReg
4188  012f a508          	bcp	a,#8
4189  0131 2606          	jrne	L7122
4190                     ; 865 	    Enc28j60ClearMaskReg(BANKX_ECON1, (1<<BANKX_ECON1_TXRTS));
4192  0133 ae1f08        	ldw	x,#7944
4193  0136 cd0000        	call	_Enc28j60ClearMaskReg
4195  0139               L7122:
4196                     ; 833       for (i = 0; i < 16; i++) {
4198  0139 0c04          	inc	(OFST-1,sp)
4202  013b 7b04          	ld	a,(OFST-1,sp)
4203  013d a110          	cp	a,#16
4204  013f 2593          	jrult	L5022
4205  0141               L3022:
4206                     ; 872 }
4209  0141 5b07          	addw	sp,#7
4210  0143 81            	ret	
4271                     ; 875 void read_TSV(void)
4271                     ; 876 {
4272                     .text:	section	.text,new
4273  0000               _read_TSV:
4275  0000 5205          	subw	sp,#5
4276       00000005      OFST:	set	5
4279                     ; 884   wait_timer((uint16_t)10);
4281  0002 ae000a        	ldw	x,#10
4282  0005 cd0000        	call	_wait_timer
4284                     ; 888   saved_ERDPTL = Enc28j60ReadReg(BANK0_ERDPTL);
4286  0008 4f            	clr	a
4287  0009 cd0000        	call	_Enc28j60ReadReg
4289  000c 6b02          	ld	(OFST-3,sp),a
4291                     ; 889   saved_ERDPTH = Enc28j60ReadReg(BANK0_ERDPTH);
4293  000e a601          	ld	a,#1
4294  0010 cd0000        	call	_Enc28j60ReadReg
4296  0013 6b03          	ld	(OFST-2,sp),a
4298                     ; 892   tsv_start = ((Enc28j60ReadReg(BANK0_ETXNDH)) << 8);
4300  0015 a607          	ld	a,#7
4301  0017 cd0000        	call	_Enc28j60ReadReg
4303  001a 97            	ld	xl,a
4304  001b 4f            	clr	a
4305  001c 02            	rlwa	x,a
4306  001d 1f04          	ldw	(OFST-1,sp),x
4308                     ; 893   tsv_start += Enc28j60ReadReg(BANK0_ETXNDL);
4310  001f a606          	ld	a,#6
4311  0021 cd0000        	call	_Enc28j60ReadReg
4313  0024 1b05          	add	a,(OFST+0,sp)
4314  0026 6b05          	ld	(OFST+0,sp),a
4315  0028 2402          	jrnc	L064
4316  002a 0c04          	inc	(OFST-1,sp)
4317  002c               L064:
4319                     ; 894   tsv_start++;
4321  002c 1e04          	ldw	x,(OFST-1,sp)
4322  002e 5c            	incw	x
4323  002f 1f04          	ldw	(OFST-1,sp),x
4325                     ; 897   Enc28j60WriteReg(BANK0_ERDPTL, (uint8_t)(tsv_start & 0x00ff));
4327  0031 5f            	clrw	x
4328  0032 7b05          	ld	a,(OFST+0,sp)
4329  0034 97            	ld	xl,a
4330  0035 cd0000        	call	_Enc28j60WriteReg
4332                     ; 898   Enc28j60WriteReg(BANK0_ERDPTH, (uint8_t)(tsv_start >> 8));
4334  0038 7b04          	ld	a,(OFST-1,sp)
4335  003a ae0100        	ldw	x,#256
4336  003d 97            	ld	xl,a
4337  003e cd0000        	call	_Enc28j60WriteReg
4339                     ; 901   select();
4341  0041 cd0000        	call	_select
4343                     ; 902   SpiWriteByte(OPCODE_RBM);
4345  0044 a63a          	ld	a,#58
4346  0046 cd0000        	call	_SpiWriteByte
4348                     ; 907     for (i=0; i<7; i++) {
4350  0049 4f            	clr	a
4351  004a 6b01          	ld	(OFST-4,sp),a
4353  004c               L7522:
4354                     ; 908       tsv_byte[i] = SpiReadByte(); // Bits 7-0
4356  004c 5f            	clrw	x
4357  004d 97            	ld	xl,a
4358  004e 89            	pushw	x
4359  004f cd0000        	call	_SpiReadByte
4361  0052 85            	popw	x
4362  0053 d70000        	ld	(_tsv_byte,x),a
4363                     ; 907     for (i=0; i<7; i++) {
4365  0056 0c01          	inc	(OFST-4,sp)
4369  0058 7b01          	ld	a,(OFST-4,sp)
4370  005a a107          	cp	a,#7
4371  005c 25ee          	jrult	L7522
4372                     ; 912   deselect();
4374  005e cd0000        	call	_deselect
4376                     ; 915   Enc28j60WriteReg(BANK0_ERDPTL, saved_ERDPTL);
4378  0061 7b02          	ld	a,(OFST-3,sp)
4379  0063 5f            	clrw	x
4380  0064 97            	ld	xl,a
4381  0065 cd0000        	call	_Enc28j60WriteReg
4383                     ; 916   Enc28j60WriteReg(BANK0_ERDPTH, saved_ERDPTH);
4385  0068 7b03          	ld	a,(OFST-2,sp)
4386  006a ae0100        	ldw	x,#256
4387  006d 97            	ld	xl,a
4388  006e cd0000        	call	_Enc28j60WriteReg
4390                     ; 917 }
4393  0071 5b05          	addw	sp,#5
4394  0073 81            	ret	
4419                     	xdef	_Enc28j60WritePhy
4420                     	xdef	_Enc28j60ReadPhy
4421                     	xdef	_Enc28j60SwitchBank
4422                     	xdef	_Enc28j60ClearMaskReg
4423                     	xdef	_Enc28j60SetMaskReg
4424                     	xdef	_Enc28j60WriteReg
4425                     	xdef	_Enc28j60ReadReg
4426                     	xdef	_deselect
4427                     	xdef	_select
4428                     	switch	.bss
4429  0000               _tsv_byte:
4430  0000 000000000000  	ds.b	7
4431                     	xdef	_tsv_byte
4432                     	xref	_stored_uip_ethaddr_oct
4433                     	xref	_stored_config_settings
4434                     	xref	_RXERIF_counter
4435                     	xref	_TXERIF_counter
4436                     	xref	_wait_timer
4437                     	xdef	_read_TSV
4438                     	xdef	_Enc28j60Send
4439                     	xdef	_Enc28j60Receive
4440                     	xdef	_Enc28j60Init
4441                     	xref	_SpiReadChunk
4442                     	xref	_SpiReadByte
4443                     	xref	_SpiWriteChunk
4444                     	xref	_SpiWriteByte
4464                     	xref	c_lgadc
4465                     	end
