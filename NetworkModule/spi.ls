   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Parser V4.11.14 - 18 Nov 2019
   3                     ; Generator (Limited) V4.4.11 - 19 Nov 2019
   4                     ; Optimizer V4.4.11 - 19 Nov 2019
2556                     ; 54 void spi_init(void)
2556                     ; 55 {
2558                     	switch	.text
2559  0000               _spi_init:
2561  0000 88            	push	a
2562       00000001      OFST:	set	1
2565                     ; 74   PC_ODR |= (uint8_t)0x02;    // 0b00000010 SI=0, SCK=0, -CS=1
2567  0001 7212500a      	bset	_PC_ODR,#1
2568                     ; 75   PE_ODR &= (uint8_t)(~0x20); // 0b00100000 -RESET=0
2570  0005 721b5014      	bres	_PE_ODR,#5
2571                     ; 78   for(i=0; i<5; i++) wait_timer((uint16_t)50000); // wait 250ms
2573  0009 0f01          	clr	(OFST+0,sp)
2575  000b               L1461:
2578  000b aec350        	ldw	x,#50000
2579  000e cd0000        	call	_wait_timer
2583  0011 0c01          	inc	(OFST+0,sp)
2587  0013 7b01          	ld	a,(OFST+0,sp)
2588  0015 a105          	cp	a,#5
2589  0017 25f2          	jrult	L1461
2590                     ; 81   PE_ODR |= (uint8_t)0x20; // 0b00100000 -RESET=1
2592  0019 721a5014      	bset	_PE_ODR,#5
2593                     ; 84   wait_timer((uint16_t)50000); // Wait 50ms
2595  001d aec350        	ldw	x,#50000
2596  0020 cd0000        	call	_wait_timer
2598                     ; 99 }
2601  0023 84            	pop	a
2602  0024 81            	ret	
2644                     ; 102 void SpiWriteByte(uint8_t nByte)
2644                     ; 103 {
2645                     	switch	.text
2646  0025               _SpiWriteByte:
2648  0025 88            	push	a
2649  0026 88            	push	a
2650       00000001      OFST:	set	1
2653                     ; 106   uint8_t bitnum = (uint8_t)0x80;                // Point at MSB
2655  0027 a680          	ld	a,#128
2656  0029 6b01          	ld	(OFST+0,sp),a
2658  002b               L5661:
2659                     ; 109     if (nByte & bitnum) PC_ODR |= (uint8_t)0x08; // If bit is 1 then 
2661  002b 7b02          	ld	a,(OFST+1,sp)
2662  002d 1501          	bcp	a,(OFST+0,sp)
2663  002f 2706          	jreq	L3761
2666  0031 7216500a      	bset	_PC_ODR,#3
2668  0035 2004          	jra	L5761
2669  0037               L3761:
2670                     ; 111     else PC_ODR &= (uint8_t)(~0x08);             // else SPI SO low
2672  0037 7217500a      	bres	_PC_ODR,#3
2673  003b               L5761:
2674                     ; 113     nop();
2677  003b 9d            	nop	
2679                     ; 114     PC_ODR |= (uint8_t)0x04;                     // SCK high
2682  003c 7214500a      	bset	_PC_ODR,#2
2683                     ; 115     nop();
2686  0040 9d            	nop	
2688                     ; 116     PC_ODR &= (uint8_t)(~0x04);                  // SCK low
2691  0041 7215500a      	bres	_PC_ODR,#2
2692                     ; 118     bitnum = (uint8_t)(bitnum >> 1);             // Shift bitnum right one place
2694  0045 0401          	srl	(OFST+0,sp)
2696                     ; 107   while(bitnum != 0)
2698  0047 26e2          	jrne	L5661
2699                     ; 122   PC_ODR &= (uint8_t)(~0x08);                    // SPI SO low on exit
2701  0049 7217500a      	bres	_PC_ODR,#3
2702                     ; 123 }
2705  004d 85            	popw	x
2706  004e 81            	ret	
2765                     ; 126 void SpiWriteChunk(const uint8_t* pChunk, uint16_t nBytes)
2765                     ; 127 {
2766                     	switch	.text
2767  004f               _SpiWriteChunk:
2769  004f 89            	pushw	x
2770  0050 89            	pushw	x
2771       00000002      OFST:	set	2
2774  0051 202c          	jra	L5271
2775  0053               L3271:
2776                     ; 133     bitnum = (uint8_t)0x80;                          // Point at MSB
2778  0053 a680          	ld	a,#128
2779  0055 6b02          	ld	(OFST+0,sp),a
2781                     ; 134     OutByte = *pChunk++;
2783  0057 1e03          	ldw	x,(OFST+1,sp)
2784  0059 f6            	ld	a,(x)
2785  005a 5c            	incw	x
2786  005b 1f03          	ldw	(OFST+1,sp),x
2787  005d 6b01          	ld	(OFST-1,sp),a
2790  005f 201a          	jra	L5371
2791  0061               L1371:
2792                     ; 138       if (OutByte & bitnum) PC_ODR |= (uint8_t)0x08; // If bit is 1 then
2794  0061 1502          	bcp	a,(OFST+0,sp)
2795  0063 2706          	jreq	L1471
2798  0065 7216500a      	bset	_PC_ODR,#3
2800  0069 2004          	jra	L3471
2801  006b               L1471:
2802                     ; 140       else PC_ODR &= (uint8_t)(~0x08);               // else SPI SO low
2804  006b 7217500a      	bres	_PC_ODR,#3
2805  006f               L3471:
2806                     ; 142       nop();
2809  006f 9d            	nop	
2811                     ; 143       PC_ODR |= (uint8_t)0x04;                       // SCK high
2814  0070 7214500a      	bset	_PC_ODR,#2
2815                     ; 144       nop();
2818  0074 9d            	nop	
2820                     ; 145       PC_ODR &= (uint8_t)(~0x04);                    // SCK low
2823  0075 7215500a      	bres	_PC_ODR,#2
2824                     ; 147       bitnum = (uint8_t)(bitnum >> 1);               // Shift bitnum right one place
2826  0079 0402          	srl	(OFST+0,sp)
2828  007b               L5371:
2829                     ; 136     while(bitnum != 0)
2831  007b 0d02          	tnz	(OFST+0,sp)
2832  007d 26e2          	jrne	L1371
2833  007f               L5271:
2834                     ; 131   while (nBytes--)
2836  007f 1e07          	ldw	x,(OFST+5,sp)
2837  0081 5a            	decw	x
2838  0082 1f07          	ldw	(OFST+5,sp),x
2839  0084 5c            	incw	x
2840  0085 26cc          	jrne	L3271
2841                     ; 152   PC_ODR &= (uint8_t)(~0x08);                        // SPI SO low on exit
2843  0087 7217500a      	bres	_PC_ODR,#3
2844                     ; 153 }
2847  008b 5b04          	addw	sp,#4
2848  008d 81            	ret	
2890                     ; 156 uint8_t SpiReadByte(void)
2890                     ; 157 {
2891                     	switch	.text
2892  008e               _SpiReadByte:
2894  008e 89            	pushw	x
2895       00000002      OFST:	set	2
2898                     ; 162   uint8_t bitnum = (uint8_t)0x80;                 // Point at MSB
2900  008f a680          	ld	a,#128
2901  0091 6b02          	ld	(OFST+0,sp),a
2903                     ; 163   uint8_t InByte = 0;
2905  0093 0f01          	clr	(OFST-1,sp)
2908  0095 2019          	jra	L7671
2909  0097               L3671:
2910                     ; 168     if (PC_IDR & (uint8_t)0x10) InByte |= bitnum; // SPI incoming bit = 1
2912  0097 7209500b04    	btjf	_PC_IDR,#4,L3771
2915  009c 1a01          	or	a,(OFST-1,sp)
2917  009e 2003          	jra	L5771
2918  00a0               L3771:
2919                     ; 169     else InByte &= (uint8_t)(~bitnum);            // SPI incoming bit = 0
2921  00a0 43            	cpl	a
2922  00a1 1401          	and	a,(OFST-1,sp)
2923  00a3               L5771:
2924  00a3 6b01          	ld	(OFST-1,sp),a
2926                     ; 171     PC_ODR |= (uint8_t)0x04;                      // SCK high
2928  00a5 7214500a      	bset	_PC_ODR,#2
2929                     ; 172     nop();
2932  00a9 9d            	nop	
2934                     ; 173     PC_ODR &= (uint8_t)(~0x04);                   // SCK low
2937  00aa 7215500a      	bres	_PC_ODR,#2
2938                     ; 175     bitnum = (uint8_t)(bitnum >> 1);              // Shift bitnum right one place
2940  00ae 0402          	srl	(OFST+0,sp)
2942  00b0               L7671:
2943                     ; 164   while(bitnum != 0)
2945  00b0 7b02          	ld	a,(OFST+0,sp)
2946  00b2 26e3          	jrne	L3671
2947                     ; 179   return InByte;
2949  00b4 7b01          	ld	a,(OFST-1,sp)
2952  00b6 85            	popw	x
2953  00b7 81            	ret	
3012                     ; 183 void SpiReadChunk(uint8_t* pChunk, uint16_t nBytes)
3012                     ; 184 {
3013                     	switch	.text
3014  00b8               _SpiReadChunk:
3016  00b8 89            	pushw	x
3017  00b9 89            	pushw	x
3018       00000002      OFST:	set	2
3021                     ; 192   PC_ODR &= (uint8_t)(~0x08);                        // SO low
3023  00ba 7217500a      	bres	_PC_ODR,#3
3025  00be 202d          	jra	L5202
3026  00c0               L3202:
3027                     ; 196     bitnum = (uint8_t)0x80;                          // Point at MSB
3029  00c0 a680          	ld	a,#128
3030  00c2 6b02          	ld	(OFST+0,sp),a
3032                     ; 197     InByte = 0;
3034  00c4 0f01          	clr	(OFST-1,sp)
3037  00c6 2019          	jra	L5302
3038  00c8               L1302:
3039                     ; 203       if (PC_IDR & (uint8_t)0x10) InByte |= bitnum;  // SPI incoming bit = 1
3041  00c8 7209500b04    	btjf	_PC_IDR,#4,L1402
3044  00cd 1a01          	or	a,(OFST-1,sp)
3046  00cf 2003          	jra	L3402
3047  00d1               L1402:
3048                     ; 204       else InByte &= (uint8_t)(~bitnum);             // SPI incoming bit = 0
3050  00d1 43            	cpl	a
3051  00d2 1401          	and	a,(OFST-1,sp)
3052  00d4               L3402:
3053  00d4 6b01          	ld	(OFST-1,sp),a
3055                     ; 206       PC_ODR |= (uint8_t)0x04;                       // SCK high
3057  00d6 7214500a      	bset	_PC_ODR,#2
3058                     ; 207       nop();
3061  00da 9d            	nop	
3063                     ; 208       PC_ODR &= (uint8_t)(~0x04);                    // SCK low
3066  00db 7215500a      	bres	_PC_ODR,#2
3067                     ; 210       bitnum = (uint8_t)(bitnum >> 1);               // Shift bitnum right one place
3069  00df 0402          	srl	(OFST+0,sp)
3071  00e1               L5302:
3072                     ; 198     while(bitnum != 0)
3074  00e1 7b02          	ld	a,(OFST+0,sp)
3075  00e3 26e3          	jrne	L1302
3076                     ; 214   *pChunk++ = InByte;                                // Save byte in the buffer
3078  00e5 1e03          	ldw	x,(OFST+1,sp)
3079  00e7 7b01          	ld	a,(OFST-1,sp)
3080  00e9 f7            	ld	(x),a
3081  00ea 5c            	incw	x
3082  00eb 1f03          	ldw	(OFST+1,sp),x
3083  00ed               L5202:
3084                     ; 194   while (nBytes--)
3086  00ed 1e07          	ldw	x,(OFST+5,sp)
3087  00ef 5a            	decw	x
3088  00f0 1f07          	ldw	(OFST+5,sp),x
3089  00f2 5c            	incw	x
3090  00f3 26cb          	jrne	L3202
3091                     ; 216 }
3094  00f5 5b04          	addw	sp,#4
3095  00f7 81            	ret	
3108                     	xref	_wait_timer
3109                     	xdef	_SpiReadChunk
3110                     	xdef	_SpiReadByte
3111                     	xdef	_SpiWriteChunk
3112                     	xdef	_SpiWriteByte
3113                     	xdef	_spi_init
3132                     	end
