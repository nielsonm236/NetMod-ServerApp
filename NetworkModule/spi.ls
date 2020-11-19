   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Parser V4.11.14 - 18 Nov 2019
   3                     ; Generator (Limited) V4.4.11 - 19 Nov 2019
   4                     ; Optimizer V4.4.11 - 19 Nov 2019
2557                     ; 56 void spi_init(void)
2557                     ; 57 {
2559                     .text:	section	.text,new
2560  0000               _spi_init:
2562  0000 88            	push	a
2563       00000001      OFST:	set	1
2566                     ; 76   PC_ODR |= (uint8_t)0x02;    // 0b00000010 SI=0, SCK=0, -CS=1
2568  0001 7212500a      	bset	_PC_ODR,#1
2569                     ; 77   PE_ODR &= (uint8_t)(~0x20); // 0b00100000 -RESET=0
2571  0005 721b5014      	bres	_PE_ODR,#5
2572                     ; 80   for(i=0; i<5; i++) wait_timer((uint16_t)50000); // wait 250ms
2574  0009 0f01          	clr	(OFST+0,sp)
2576  000b               L7461:
2579  000b aec350        	ldw	x,#50000
2580  000e cd0000        	call	_wait_timer
2584  0011 0c01          	inc	(OFST+0,sp)
2588  0013 7b01          	ld	a,(OFST+0,sp)
2589  0015 a105          	cp	a,#5
2590  0017 25f2          	jrult	L7461
2591                     ; 83   PE_ODR |= (uint8_t)0x20; // 0b00100000 -RESET=1
2593  0019 721a5014      	bset	_PE_ODR,#5
2594                     ; 86   wait_timer((uint16_t)50000); // Wait 50ms
2596  001d aec350        	ldw	x,#50000
2597  0020 cd0000        	call	_wait_timer
2599                     ; 101 }
2602  0023 84            	pop	a
2603  0024 81            	ret	
2645                     ; 104 void SpiWriteByte(uint8_t nByte)
2645                     ; 105 {
2646                     .text:	section	.text,new
2647  0000               _SpiWriteByte:
2649  0000 88            	push	a
2650  0001 88            	push	a
2651       00000001      OFST:	set	1
2654                     ; 108   uint8_t bitnum = (uint8_t)0x80;                // Point at MSB
2656  0002 a680          	ld	a,#128
2657  0004 6b01          	ld	(OFST+0,sp),a
2659  0006               L3761:
2660                     ; 110     if (nByte & bitnum) PC_ODR |= (uint8_t)0x08; // If bit is 1 then 
2662  0006 7b02          	ld	a,(OFST+1,sp)
2663  0008 1501          	bcp	a,(OFST+0,sp)
2664  000a 2706          	jreq	L1071
2667  000c 7216500a      	bset	_PC_ODR,#3
2669  0010 2004          	jra	L3071
2670  0012               L1071:
2671                     ; 112     else PC_ODR &= (uint8_t)(~0x08);             // else SPI SO low
2673  0012 7217500a      	bres	_PC_ODR,#3
2674  0016               L3071:
2675                     ; 114     nop();
2678  0016 9d            	nop	
2680                     ; 115     PC_ODR |= (uint8_t)0x04;                     // SCK high
2683  0017 7214500a      	bset	_PC_ODR,#2
2684                     ; 116     nop();
2687  001b 9d            	nop	
2689                     ; 117     PC_ODR &= (uint8_t)(~0x04);                  // SCK low
2692  001c 7215500a      	bres	_PC_ODR,#2
2693                     ; 119     bitnum = (uint8_t)(bitnum >> 1);             // Shift bitnum right one place
2695  0020 0401          	srl	(OFST+0,sp)
2697                     ; 109   while(bitnum != 0) {
2699  0022 26e2          	jrne	L3761
2700                     ; 123   PC_ODR &= (uint8_t)(~0x08);                    // SPI SO low on exit
2702  0024 7217500a      	bres	_PC_ODR,#3
2703                     ; 124 }
2706  0028 85            	popw	x
2707  0029 81            	ret	
2766                     ; 127 void SpiWriteChunk(const uint8_t* pChunk, uint16_t nBytes)
2766                     ; 128 {
2767                     .text:	section	.text,new
2768  0000               _SpiWriteChunk:
2770  0000 89            	pushw	x
2771  0001 89            	pushw	x
2772       00000002      OFST:	set	2
2775  0002 202c          	jra	L3371
2776  0004               L1371:
2777                     ; 133     bitnum = (uint8_t)0x80;                          // Point at MSB
2779  0004 a680          	ld	a,#128
2780  0006 6b02          	ld	(OFST+0,sp),a
2782                     ; 134     OutByte = *pChunk++;
2784  0008 1e03          	ldw	x,(OFST+1,sp)
2785  000a f6            	ld	a,(x)
2786  000b 5c            	incw	x
2787  000c 1f03          	ldw	(OFST+1,sp),x
2788  000e 6b01          	ld	(OFST-1,sp),a
2791  0010 201a          	jra	L3471
2792  0012               L7371:
2793                     ; 137       if (OutByte & bitnum) PC_ODR |= (uint8_t)0x08; // If bit is 1 then
2795  0012 1502          	bcp	a,(OFST+0,sp)
2796  0014 2706          	jreq	L7471
2799  0016 7216500a      	bset	_PC_ODR,#3
2801  001a 2004          	jra	L1571
2802  001c               L7471:
2803                     ; 139       else PC_ODR &= (uint8_t)(~0x08);               // else SPI SO low
2805  001c 7217500a      	bres	_PC_ODR,#3
2806  0020               L1571:
2807                     ; 141       nop();
2810  0020 9d            	nop	
2812                     ; 142       PC_ODR |= (uint8_t)0x04;                       // SCK high
2815  0021 7214500a      	bset	_PC_ODR,#2
2816                     ; 143       nop();
2819  0025 9d            	nop	
2821                     ; 144       PC_ODR &= (uint8_t)(~0x04);                    // SCK low
2824  0026 7215500a      	bres	_PC_ODR,#2
2825                     ; 146       bitnum = (uint8_t)(bitnum >> 1);               // Shift bitnum right one place
2827  002a 0402          	srl	(OFST+0,sp)
2829  002c               L3471:
2830                     ; 136     while(bitnum != 0) {
2832  002c 0d02          	tnz	(OFST+0,sp)
2833  002e 26e2          	jrne	L7371
2834  0030               L3371:
2835                     ; 132   while (nBytes--) {
2837  0030 1e07          	ldw	x,(OFST+5,sp)
2838  0032 5a            	decw	x
2839  0033 1f07          	ldw	(OFST+5,sp),x
2840  0035 5c            	incw	x
2841  0036 26cc          	jrne	L1371
2842                     ; 151   PC_ODR &= (uint8_t)(~0x08);                        // SPI SO low on exit
2844  0038 7217500a      	bres	_PC_ODR,#3
2845                     ; 152 }
2848  003c 5b04          	addw	sp,#4
2849  003e 81            	ret	
2891                     ; 155 uint8_t SpiReadByte(void)
2891                     ; 156 {
2892                     .text:	section	.text,new
2893  0000               _SpiReadByte:
2895  0000 89            	pushw	x
2896       00000002      OFST:	set	2
2899                     ; 161   uint8_t bitnum = (uint8_t)0x80;                 // Point at MSB
2901  0001 a680          	ld	a,#128
2902  0003 6b02          	ld	(OFST+0,sp),a
2904                     ; 162   uint8_t InByte = 0;
2906  0005 0f01          	clr	(OFST-1,sp)
2909  0007 2019          	jra	L5771
2910  0009               L1771:
2911                     ; 166     if (PC_IDR & (uint8_t)0x10) InByte |= bitnum; // SPI incoming bit = 1
2913  0009 7209500b04    	btjf	_PC_IDR,#4,L1002
2916  000e 1a01          	or	a,(OFST-1,sp)
2918  0010 2003          	jra	L3002
2919  0012               L1002:
2920                     ; 167     else InByte &= (uint8_t)(~bitnum);            // SPI incoming bit = 0
2922  0012 43            	cpl	a
2923  0013 1401          	and	a,(OFST-1,sp)
2924  0015               L3002:
2925  0015 6b01          	ld	(OFST-1,sp),a
2927                     ; 169     PC_ODR |= (uint8_t)0x04;                      // SCK high
2929  0017 7214500a      	bset	_PC_ODR,#2
2930                     ; 170     nop();
2933  001b 9d            	nop	
2935                     ; 171     PC_ODR &= (uint8_t)(~0x04);                   // SCK low
2938  001c 7215500a      	bres	_PC_ODR,#2
2939                     ; 173     bitnum = (uint8_t)(bitnum >> 1);              // Shift bitnum right one place
2941  0020 0402          	srl	(OFST+0,sp)
2943  0022               L5771:
2944                     ; 163   while(bitnum != 0) {
2946  0022 7b02          	ld	a,(OFST+0,sp)
2947  0024 26e3          	jrne	L1771
2948                     ; 177   return InByte;
2950  0026 7b01          	ld	a,(OFST-1,sp)
2953  0028 85            	popw	x
2954  0029 81            	ret	
3013                     ; 181 void SpiReadChunk(uint8_t* pChunk, uint16_t nBytes)
3013                     ; 182 {
3014                     .text:	section	.text,new
3015  0000               _SpiReadChunk:
3017  0000 89            	pushw	x
3018  0001 89            	pushw	x
3019       00000002      OFST:	set	2
3022                     ; 190   PC_ODR &= (uint8_t)(~0x08);                        // SO low
3024  0002 7217500a      	bres	_PC_ODR,#3
3026  0006 202d          	jra	L3302
3027  0008               L1302:
3028                     ; 193     bitnum = (uint8_t)0x80;                          // Point at MSBif
3030  0008 a680          	ld	a,#128
3031  000a 6b02          	ld	(OFST+0,sp),a
3033                     ; 194     InByte = 0;
3035  000c 0f01          	clr	(OFST-1,sp)
3038  000e 2019          	jra	L3402
3039  0010               L7302:
3040                     ; 199       if (PC_IDR & (uint8_t)0x10) InByte |= bitnum;  // SPI incoming bit = 1
3042  0010 7209500b04    	btjf	_PC_IDR,#4,L7402
3045  0015 1a01          	or	a,(OFST-1,sp)
3047  0017 2003          	jra	L1502
3048  0019               L7402:
3049                     ; 200       else InByte &= (uint8_t)(~bitnum);             // SPI incoming bit = 0
3051  0019 43            	cpl	a
3052  001a 1401          	and	a,(OFST-1,sp)
3053  001c               L1502:
3054  001c 6b01          	ld	(OFST-1,sp),a
3056                     ; 202       PC_ODR |= (uint8_t)0x04;                       // SCK high
3058  001e 7214500a      	bset	_PC_ODR,#2
3059                     ; 203       nop();
3062  0022 9d            	nop	
3064                     ; 204       PC_ODR &= (uint8_t)(~0x04);                    // SCK low
3067  0023 7215500a      	bres	_PC_ODR,#2
3068                     ; 206       bitnum = (uint8_t)(bitnum >> 1);               // Shift bitnum right one place
3070  0027 0402          	srl	(OFST+0,sp)
3072  0029               L3402:
3073                     ; 195     while(bitnum != 0) {
3075  0029 7b02          	ld	a,(OFST+0,sp)
3076  002b 26e3          	jrne	L7302
3077                     ; 210   *pChunk++ = InByte;                                // Save byte in the buffer
3079  002d 1e03          	ldw	x,(OFST+1,sp)
3080  002f 7b01          	ld	a,(OFST-1,sp)
3081  0031 f7            	ld	(x),a
3082  0032 5c            	incw	x
3083  0033 1f03          	ldw	(OFST+1,sp),x
3084  0035               L3302:
3085                     ; 192   while (nBytes--) {
3087  0035 1e07          	ldw	x,(OFST+5,sp)
3088  0037 5a            	decw	x
3089  0038 1f07          	ldw	(OFST+5,sp),x
3090  003a 5c            	incw	x
3091  003b 26cb          	jrne	L1302
3092                     ; 212 }
3095  003d 5b04          	addw	sp,#4
3096  003f 81            	ret	
3109                     	xref	_wait_timer
3110                     	xdef	_SpiReadChunk
3111                     	xdef	_SpiReadByte
3112                     	xdef	_SpiWriteChunk
3113                     	xdef	_SpiWriteByte
3114                     	xdef	_spi_init
3133                     	end
