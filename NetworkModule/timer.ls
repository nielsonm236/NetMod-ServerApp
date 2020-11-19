   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Parser V4.11.14 - 18 Nov 2019
   3                     ; Generator (Limited) V4.4.11 - 19 Nov 2019
   4                     ; Optimizer V4.4.11 - 19 Nov 2019
2565                     ; 42 void clock_init(void)
2565                     ; 43 {
2567                     .text:	section	.text,new
2568  0000               _clock_init:
2572                     ; 86   CLK_ICKR = ((uint8_t)0x01);
2574  0000 350150c0      	mov	_CLK_ICKR,#1
2575                     ; 87   CLK_ECKR = ((uint8_t)0x00);
2577  0004 725f50c1      	clr	_CLK_ECKR
2578                     ; 88   CLK_SWR  = ((uint8_t)0xE1);
2580  0008 35e150c4      	mov	_CLK_SWR,#225
2581                     ; 89   CLK_SWCR = ((uint8_t)0x00);
2583  000c 725f50c5      	clr	_CLK_SWCR
2584                     ; 90   CLK_CKDIVR = ((uint8_t)0x18);
2586  0010 351850c6      	mov	_CLK_CKDIVR,#24
2587                     ; 91   CLK_PCKENR1 = ((uint8_t)0xFF);
2589  0014 35ff50c7      	mov	_CLK_PCKENR1,#255
2590                     ; 92   CLK_PCKENR2 = ((uint8_t)0xFF);
2592  0018 35ff50ca      	mov	_CLK_PCKENR2,#255
2593                     ; 93   CLK_CSSR = ((uint8_t)0x00);
2595  001c 725f50c8      	clr	_CLK_CSSR
2596                     ; 94   CLK_CCOR = ((uint8_t)0x00);
2598  0020 725f50c9      	clr	_CLK_CCOR
2600  0024               L1461:
2601                     ; 95   while ((CLK_CCOR & CLK_CCOR_CCOEN)!= 0) {}
2603  0024 720050c9fb    	btjt	_CLK_CCOR,#0,L1461
2604                     ; 96   CLK_CCOR = ((uint8_t)0x00);
2606  0029 725f50c9      	clr	_CLK_CCOR
2607                     ; 97   CLK_HSITRIMR = ((uint8_t)0x00);
2609  002d 725f50cc      	clr	_CLK_HSITRIMR
2610                     ; 98   CLK_SWIMCCR = ((uint8_t)0x00);
2612  0031 725f50cd      	clr	_CLK_SWIMCCR
2613                     ; 101   CLK_ICKR |= ((uint8_t)0x01); // Enable HSI oscillator (MAY NOT BE NECESSARY AFTER RESET)
2615  0035 721050c0      	bset	_CLK_ICKR,#0
2617  0039               L7461:
2618                     ; 104   while ((CLK_ICKR & CLK_ICKR_HSIRDY)== 0) {}
2620  0039 720350c0fb    	btjf	_CLK_ICKR,#1,L7461
2621                     ; 107   CLK_SWCR |= CLK_SWCR_SWEN;
2623  003e 721250c5      	bset	_CLK_SWCR,#1
2624                     ; 113   CLK_CKDIVR = (uint8_t)0x00;
2626  0042 725f50c6      	clr	_CLK_CKDIVR
2627                     ; 126   CLK_PCKENR1 |= (uint8_t)0x80;		// Enable clock to TIM1
2629  0046 721e50c7      	bset	_CLK_PCKENR1,#7
2630                     ; 127   CLK_PCKENR1 |= (uint8_t)0x20;		// Enable clock to TIM2
2632  004a 721a50c7      	bset	_CLK_PCKENR1,#5
2633                     ; 128   CLK_PCKENR1 |= (uint8_t)0x40;		// Enable clock to TIM3
2635  004e 721c50c7      	bset	_CLK_PCKENR1,#6
2636                     ; 129   CLK_PCKENR1 &= (uint8_t)(~0x10);	// Disable clock to TIM4
2638  0052 721950c7      	bres	_CLK_PCKENR1,#4
2639                     ; 130   CLK_PCKENR1 &= (uint8_t)(~0x08);	// Disable clock to UART
2641  0056 721750c7      	bres	_CLK_PCKENR1,#3
2642                     ; 131   CLK_PCKENR1 &= (uint8_t)(~0x02);	// Disable clock to SPI
2644  005a 721350c7      	bres	_CLK_PCKENR1,#1
2645                     ; 132   CLK_PCKENR1 &= (uint8_t)(~0x01);	// Disable clock to I2C
2647  005e 721150c7      	bres	_CLK_PCKENR1,#0
2648                     ; 133   CLK_PCKENR2 &= (uint8_t)(~0x08);	// Disable clock to ADC
2650  0062 721750ca      	bres	_CLK_PCKENR2,#3
2651                     ; 134   CLK_PCKENR2 &= (uint8_t)(~0x04);	// Disable clock to AWU
2653  0066 721550ca      	bres	_CLK_PCKENR2,#2
2654                     ; 152   TIM2_PSCR = (uint8_t)0x0e;
2656  006a 350e530c      	mov	_TIM2_PSCR,#14
2657                     ; 154   TIM2_CR1 = (uint8_t)0x01;
2659  006e 35015300      	mov	_TIM2_CR1,#1
2660                     ; 156   TIM2_EGR = (uint8_t)0x01;
2662  0072 35015304      	mov	_TIM2_EGR,#1
2663                     ; 164   TIM3_PSCR = (uint8_t)0x04;
2665  0076 3504532a      	mov	_TIM3_PSCR,#4
2666                     ; 166   TIM3_CR1 = (uint8_t)0x01;
2668  007a 35015320      	mov	_TIM3_CR1,#1
2669                     ; 168   TIM3_EGR = (uint8_t)0x01;
2671  007e 35015324      	mov	_TIM3_EGR,#1
2672                     ; 170   arp_timer = 0x00;   // Initialize arp timer
2674  0082 725f0005      	clr	_arp_timer
2675                     ; 171   second_toggle = 0;  // Initialize toggle for seconds counter
2677  0086 725f0004      	clr	_second_toggle
2678                     ; 172   second_counter = 0; // Initialize seconds counter
2680  008a 5f            	clrw	x
2681  008b cf0002        	ldw	_second_counter+2,x
2682  008e cf0000        	ldw	_second_counter,x
2683                     ; 173 }
2686  0091 81            	ret	
2716                     ; 177 periodic_timer_expired(void)
2716                     ; 178 {
2717                     .text:	section	.text,new
2718  0000               _periodic_timer_expired:
2722                     ; 194   if ((uint8_t)TIM2_CNTRL > 0x62) {     // Evaluate at 100ms
2724  0000 c6530b        	ld	a,_TIM2_CNTRL
2725  0003 a163          	cp	a,#99
2726  0005 2530          	jrult	L3661
2727                     ; 195     TIM2_CR1 &= (uint8_t)(~0x01);	// Disable counter
2729  0007 72115300      	bres	_TIM2_CR1,#0
2730                     ; 196     TIM2_CNTRH = (uint8_t)0x00;		// Clear counter High
2732  000b 725f530a      	clr	_TIM2_CNTRH
2733                     ; 197     TIM2_CNTRL = (uint8_t)0x00;		// Clear counter Low
2735  000f 725f530b      	clr	_TIM2_CNTRL
2736                     ; 198     TIM2_CR1 |= (uint8_t)0x01;		// Enable counter
2738  0013 72105300      	bset	_TIM2_CR1,#0
2739                     ; 200     arp_timer++;			// Increment arp_timer every ~100 ms
2741  0017 725c0005      	inc	_arp_timer
2742                     ; 202     if (second_toggle < 10) {
2744  001b c60004        	ld	a,_second_toggle
2745  001e a10a          	cp	a,#10
2746  0020 2406          	jruge	L5661
2747                     ; 203       second_toggle++;			// Increment second_toggle every ~100 ms
2749  0022 725c0004      	inc	_second_toggle
2751  0026 200c          	jra	L7661
2752  0028               L5661:
2753                     ; 206       second_toggle = 0;
2755  0028 725f0004      	clr	_second_toggle
2756                     ; 207       second_counter++;			// Increment second_counter every ~1000 ms
2758  002c ae0000        	ldw	x,#_second_counter
2759  002f a601          	ld	a,#1
2760  0031 cd0000        	call	c_lgadc
2762  0034               L7661:
2763                     ; 210     return(1);
2765  0034 a601          	ld	a,#1
2768  0036 81            	ret	
2769  0037               L3661:
2770                     ; 212   else return(0);
2772  0037 4f            	clr	a
2775  0038 81            	ret	
2799                     ; 217 arp_timer_expired(void)
2799                     ; 218 {
2800                     .text:	section	.text,new
2801  0000               _arp_timer_expired:
2805                     ; 222   if (arp_timer > 99) {
2807  0000 c60005        	ld	a,_arp_timer
2808  0003 a164          	cp	a,#100
2809  0005 2507          	jrult	L3071
2810                     ; 223     arp_timer = 0;       // Reset arp_timer
2812  0007 725f0005      	clr	_arp_timer
2813                     ; 224     return(1);
2815  000b a601          	ld	a,#1
2818  000d 81            	ret	
2819  000e               L3071:
2820                     ; 226   else return(0);
2822  000e 4f            	clr	a
2825  000f 81            	ret	
2867                     ; 231 wait_timer(uint16_t wait)
2867                     ; 232 {
2868                     .text:	section	.text,new
2869  0000               _wait_timer:
2871  0000 89            	pushw	x
2872  0001 89            	pushw	x
2873       00000002      OFST:	set	2
2876                     ; 243   TIM3_CR1 &= (uint8_t)(~0x01);		// Disable counter
2878  0002 72115320      	bres	_TIM3_CR1,#0
2879                     ; 244   TIM3_CNTRH = (uint8_t)0x00;		// Clear counter High
2881  0006 725f5328      	clr	_TIM3_CNTRH
2882                     ; 245   TIM3_CNTRL = (uint8_t)0x00;		// Clear counter Low
2884  000a 725f5329      	clr	_TIM3_CNTRL
2885                     ; 246   TIM3_CR1 |= (uint8_t)0x01;		// Enable counter
2887  000e 72105320      	bset	_TIM3_CR1,#0
2888  0012               L5271:
2889                     ; 249     counter = ((uint16_t)TIM3_CNTRH << 8) | (uint8_t)TIM3_CNTRL;
2891  0012 c65328        	ld	a,_TIM3_CNTRH
2892  0015 97            	ld	xl,a
2893  0016 c65329        	ld	a,_TIM3_CNTRL
2894  0019 02            	rlwa	x,a
2895  001a 1f01          	ldw	(OFST-1,sp),x
2897                     ; 250   } while(counter <= wait);
2899  001c 1303          	cpw	x,(OFST+1,sp)
2900  001e 23f2          	jrule	L5271
2901                     ; 252   return;
2904  0020 5b04          	addw	sp,#4
2905  0022 81            	ret	
2941                     	xdef	_wait_timer
2942                     	xdef	_arp_timer_expired
2943                     	xdef	_periodic_timer_expired
2944                     	xdef	_clock_init
2945                     	switch	.bss
2946  0000               _second_counter:
2947  0000 00000000      	ds.b	4
2948                     	xdef	_second_counter
2949  0004               _second_toggle:
2950  0004 00            	ds.b	1
2951                     	xdef	_second_toggle
2952  0005               _arp_timer:
2953  0005 00            	ds.b	1
2954                     	xdef	_arp_timer
2974                     	xref	c_lgadc
2975                     	end
