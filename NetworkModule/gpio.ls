   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Parser V4.11.14 - 18 Nov 2019
   3                     ; Generator (Limited) V4.4.11 - 19 Nov 2019
   4                     ; Optimizer V4.4.11 - 19 Nov 2019
2562                     ; 315 void gpio_init(void)
2562                     ; 316 {
2564                     	switch	.text
2565  0000               _gpio_init:
2569                     ; 341   PA_DDR = (uint8_t)0x04; // 0b00000100
2571  0000 35045002      	mov	_PA_DDR,#4
2572                     ; 343   PA_CR1 = (uint8_t)0xff; // 0b11111111
2574  0004 35ff5003      	mov	_PA_CR1,#255
2575                     ; 346   PA_CR2 = (uint8_t)0x00; // 0b00000000
2577  0008 725f5004      	clr	_PA_CR2
2578                     ; 361   PB_DDR = (uint8_t)0x00; // 0b00000000
2580  000c 725f5007      	clr	_PB_DDR
2581                     ; 363   PB_CR1 = (uint8_t)0xff; // 0b11111111
2583  0010 35ff5008      	mov	_PB_CR1,#255
2584                     ; 365   PB_CR2 = (uint8_t)0x00; // 0b00000000
2586  0014 725f5009      	clr	_PB_CR2
2587                     ; 379   PC_DDR = (uint8_t)0x0e; // 0b00001110
2589  0018 350e500c      	mov	_PC_DDR,#14
2590                     ; 381   PC_CR1 = (uint8_t)0xff; // 0b11111111
2592  001c 35ff500d      	mov	_PC_CR1,#255
2593                     ; 384   PC_CR2 = (uint8_t)0x0e; // 0b00001110
2595  0020 350e500e      	mov	_PC_CR2,#14
2596                     ; 399   PD_DDR = (uint8_t)0x00; // 0b00000000
2598  0024 725f5011      	clr	_PD_DDR
2599                     ; 402   PD_CR1 = (uint8_t)0xff; // 0b11111111
2601  0028 35ff5012      	mov	_PD_CR1,#255
2602                     ; 404   PD_CR2 = (uint8_t)0x00; // 0b00000000
2604  002c 725f5013      	clr	_PD_CR2
2605                     ; 418   PE_DDR = (uint8_t)0x20; // 0b00100000
2607  0030 35205016      	mov	_PE_DDR,#32
2608                     ; 420   PE_CR1 = (uint8_t)0xff; // 0b11111111
2610  0034 35ff5017      	mov	_PE_CR1,#255
2611                     ; 423   PE_CR2 = (uint8_t)0x20; // 0b00100000
2613  0038 35205018      	mov	_PE_CR2,#32
2614                     ; 440   PG_DDR = (uint8_t)0x00; // 0b00000000
2616  003c 725f5020      	clr	_PG_DDR
2617                     ; 442   PG_CR1 = (uint8_t)0xff; // 0b11111111
2619  0040 35ff5021      	mov	_PG_CR1,#255
2620                     ; 444   PG_CR2 = (uint8_t)0x00; // 0b00000000
2622  0044 725f5022      	clr	_PG_CR2
2623                     ; 446 }
2626  0048 81            	ret	
2659                     ; 450 void LEDcontrol(uint8_t state)
2659                     ; 451 {
2660                     	switch	.text
2661  0049               _LEDcontrol:
2665                     ; 453   if (state == 1) PA_ODR |= (uint8_t)0x04;
2667  0049 4a            	dec	a
2668  004a 2605          	jrne	L1661
2671  004c 72145000      	bset	_PA_ODR,#2
2674  0050 81            	ret	
2675  0051               L1661:
2676                     ; 455   else PA_ODR &= (uint8_t)(~0x04);
2678  0051 72155000      	bres	_PA_ODR,#2
2679                     ; 456 }
2682  0055 81            	ret	
2695                     	xdef	_LEDcontrol
2696                     	xdef	_gpio_init
2715                     	end
