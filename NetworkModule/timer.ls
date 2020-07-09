   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Parser V4.11.14 - 18 Nov 2019
   3                     ; Generator (Limited) V4.4.11 - 19 Nov 2019
   4                     ; Optimizer V4.4.11 - 19 Nov 2019
2562                     ; 40 void clock_init(void)
2562                     ; 41 {
2564                     	switch	.text
2565  0000               _clock_init:
2569                     ; 84   CLK_ICKR = ((uint8_t)0x01);
2571  0000 350150c0      	mov	_CLK_ICKR,#1
2572                     ; 85   CLK_ECKR = ((uint8_t)0x00);
2574  0004 725f50c1      	clr	_CLK_ECKR
2575                     ; 86   CLK_SWR  = ((uint8_t)0xE1);
2577  0008 35e150c4      	mov	_CLK_SWR,#225
2578                     ; 87   CLK_SWCR = ((uint8_t)0x00);
2580  000c 725f50c5      	clr	_CLK_SWCR
2581                     ; 88   CLK_CKDIVR = ((uint8_t)0x18);
2583  0010 351850c6      	mov	_CLK_CKDIVR,#24
2584                     ; 89   CLK_PCKENR1 = ((uint8_t)0xFF);
2586  0014 35ff50c7      	mov	_CLK_PCKENR1,#255
2587                     ; 90   CLK_PCKENR2 = ((uint8_t)0xFF);
2589  0018 35ff50ca      	mov	_CLK_PCKENR2,#255
2590                     ; 91   CLK_CSSR = ((uint8_t)0x00);
2592  001c 725f50c8      	clr	_CLK_CSSR
2593                     ; 92   CLK_CCOR = ((uint8_t)0x00);
2595  0020 725f50c9      	clr	_CLK_CCOR
2597  0024               L1461:
2598                     ; 93   while ((CLK_CCOR & CLK_CCOR_CCOEN)!= 0) {}
2600  0024 720050c9fb    	btjt	_CLK_CCOR,#0,L1461
2601                     ; 94   CLK_CCOR = ((uint8_t)0x00);
2603  0029 725f50c9      	clr	_CLK_CCOR
2604                     ; 95   CLK_HSITRIMR = ((uint8_t)0x00);
2606  002d 725f50cc      	clr	_CLK_HSITRIMR
2607                     ; 96   CLK_SWIMCCR = ((uint8_t)0x00);
2609  0031 725f50cd      	clr	_CLK_SWIMCCR
2610                     ; 99   CLK_ICKR |= ((uint8_t)0x01); // Enable HSI oscillator (MAY NOT BE NECESSARY AFTER RESET)
2612  0035 721050c0      	bset	_CLK_ICKR,#0
2614  0039               L7461:
2615                     ; 102   while ((CLK_ICKR & CLK_ICKR_HSIRDY)== 0) {}
2617  0039 720350c0fb    	btjf	_CLK_ICKR,#1,L7461
2618                     ; 105   CLK_SWCR |= CLK_SWCR_SWEN;
2620  003e 721250c5      	bset	_CLK_SWCR,#1
2621                     ; 111   CLK_CKDIVR = (uint8_t)0x00;
2623  0042 725f50c6      	clr	_CLK_CKDIVR
2624                     ; 124   CLK_PCKENR1 |= (uint8_t)0x80;		// Enable clock to TIM1
2626  0046 721e50c7      	bset	_CLK_PCKENR1,#7
2627                     ; 125   CLK_PCKENR1 |= (uint8_t)0x20;		// Enable clock to TIM2
2629  004a 721a50c7      	bset	_CLK_PCKENR1,#5
2630                     ; 126   CLK_PCKENR1 |= (uint8_t)0x40;		// Enable clock to TIM3
2632  004e 721c50c7      	bset	_CLK_PCKENR1,#6
2633                     ; 127   CLK_PCKENR1 &= (uint8_t)(~0x10);	// Disable clock to TIM4
2635  0052 721950c7      	bres	_CLK_PCKENR1,#4
2636                     ; 128   CLK_PCKENR1 &= (uint8_t)(~0x08);	// Disable clock to UART
2638  0056 721750c7      	bres	_CLK_PCKENR1,#3
2639                     ; 129   CLK_PCKENR1 &= (uint8_t)(~0x02);	// Disable clock to SPI
2641  005a 721350c7      	bres	_CLK_PCKENR1,#1
2642                     ; 130   CLK_PCKENR1 &= (uint8_t)(~0x01);	// Disable clock to I2C
2644  005e 721150c7      	bres	_CLK_PCKENR1,#0
2645                     ; 131   CLK_PCKENR2 &= (uint8_t)(~0x08);	// Disable clock to ADC
2647  0062 721750ca      	bres	_CLK_PCKENR2,#3
2648                     ; 132   CLK_PCKENR2 &= (uint8_t)(~0x04);	// Disable clock to AWU
2650  0066 721550ca      	bres	_CLK_PCKENR2,#2
2651                     ; 150   TIM2_PSCR = (uint8_t)0x0e;
2653  006a 350e530c      	mov	_TIM2_PSCR,#14
2654                     ; 152   TIM2_CR1 = (uint8_t)0x01;
2656  006e 35015300      	mov	_TIM2_CR1,#1
2657                     ; 154   TIM2_EGR = (uint8_t)0x01;
2659  0072 35015304      	mov	_TIM2_EGR,#1
2660                     ; 162   TIM3_PSCR = (uint8_t)0x04;
2662  0076 3504532a      	mov	_TIM3_PSCR,#4
2663                     ; 164   TIM3_CR1 = (uint8_t)0x01;
2665  007a 35015320      	mov	_TIM3_CR1,#1
2666                     ; 166   TIM3_EGR = (uint8_t)0x01;
2668  007e 35015324      	mov	_TIM3_EGR,#1
2669                     ; 168   arp_timer = 0x00; // Initialize arp timer
2671  0082 725f0000      	clr	_arp_timer
2672                     ; 169 }
2675  0086 81            	ret	
2703                     ; 173 periodic_timer_expired(void)
2703                     ; 174 {
2704                     	switch	.text
2705  0087               _periodic_timer_expired:
2709                     ; 182   if ((uint8_t)TIM2_CNTRH > 1) {        // For simplification evaluate at 512ms
2711  0087 c6530a        	ld	a,_TIM2_CNTRH
2712  008a a102          	cp	a,#2
2713  008c 2517          	jrult	L3661
2714                     ; 183     TIM2_CR1 &= (uint8_t)(~0x01);	// Disable counter
2716  008e 72115300      	bres	_TIM2_CR1,#0
2717                     ; 184     TIM2_CNTRH = (uint8_t)0x00;		// Clear counter High
2719  0092 725f530a      	clr	_TIM2_CNTRH
2720                     ; 185     TIM2_CNTRL = (uint8_t)0x00;		// Clear counter Low
2722  0096 725f530b      	clr	_TIM2_CNTRL
2723                     ; 186     TIM2_CR1 |= (uint8_t)0x01;		// Enable counter
2725  009a 72105300      	bset	_TIM2_CR1,#0
2726                     ; 187     arp_timer++;			// Increment arp_timer
2728  009e 725c0000      	inc	_arp_timer
2729                     ; 188     return(1);
2731  00a2 a601          	ld	a,#1
2734  00a4 81            	ret	
2735  00a5               L3661:
2736                     ; 190   else return(0);
2738  00a5 4f            	clr	a
2741  00a6 81            	ret	
2765                     ; 195 arp_timer_expired(void)
2765                     ; 196 {
2766                     	switch	.text
2767  00a7               _arp_timer_expired:
2771                     ; 200   if (arp_timer > 19) {
2773  00a7 c60000        	ld	a,_arp_timer
2774  00aa a114          	cp	a,#20
2775  00ac 2507          	jrult	L7761
2776                     ; 201     arp_timer = 0;       // Reset arp_timer
2778  00ae 725f0000      	clr	_arp_timer
2779                     ; 202     return(1);
2781  00b2 a601          	ld	a,#1
2784  00b4 81            	ret	
2785  00b5               L7761:
2786                     ; 204   else return(0);
2788  00b5 4f            	clr	a
2791  00b6 81            	ret	
2833                     ; 209 wait_timer(uint16_t wait)
2833                     ; 210 {
2834                     	switch	.text
2835  00b7               _wait_timer:
2837  00b7 89            	pushw	x
2838  00b8 89            	pushw	x
2839       00000002      OFST:	set	2
2842                     ; 221   TIM3_CR1 &= (uint8_t)(~0x01);		// Disable counter
2844  00b9 72115320      	bres	_TIM3_CR1,#0
2845                     ; 222   TIM3_CNTRH = (uint8_t)0x00;		// Clear counter High
2847  00bd 725f5328      	clr	_TIM3_CNTRH
2848                     ; 223   TIM3_CNTRL = (uint8_t)0x00;		// Clear counter Low
2850  00c1 725f5329      	clr	_TIM3_CNTRL
2851                     ; 224   TIM3_CR1 |= (uint8_t)0x01;		// Enable counter
2853  00c5 72105320      	bset	_TIM3_CR1,#0
2854  00c9               L1271:
2855                     ; 227     counter = ((uint16_t)TIM3_CNTRH << 8) | (uint8_t)TIM3_CNTRL;
2857  00c9 c65328        	ld	a,_TIM3_CNTRH
2858  00cc 97            	ld	xl,a
2859  00cd c65329        	ld	a,_TIM3_CNTRL
2860  00d0 02            	rlwa	x,a
2861  00d1 1f01          	ldw	(OFST-1,sp),x
2863                     ; 228   } while(counter <= wait);
2865  00d3 1303          	cpw	x,(OFST+1,sp)
2866  00d5 23f2          	jrule	L1271
2867                     ; 230   return;
2870  00d7 5b04          	addw	sp,#4
2871  00d9 81            	ret	
2893                     	xdef	_wait_timer
2894                     	xdef	_arp_timer_expired
2895                     	xdef	_periodic_timer_expired
2896                     	xdef	_clock_init
2897                     	switch	.bss
2898  0000               _arp_timer:
2899  0000 00            	ds.b	1
2900                     	xdef	_arp_timer
2920                     	end
