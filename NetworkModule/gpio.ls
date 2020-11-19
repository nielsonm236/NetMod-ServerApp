   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Parser V4.11.14 - 18 Nov 2019
   3                     ; Generator (Limited) V4.4.11 - 19 Nov 2019
   4                     ; Optimizer V4.4.11 - 19 Nov 2019
2563                     ; 172 void gpio_init(void)
2563                     ; 173 {
2565                     .text:	section	.text,new
2566  0000               _gpio_init:
2570                     ; 200   PA_DDR = (uint8_t)0x2c; // 0b00000100
2572  0000 352c5002      	mov	_PA_DDR,#44
2573                     ; 202   PA_CR1 = (uint8_t)0xff; // 0b11111111
2575  0004 35ff5003      	mov	_PA_CR1,#255
2576                     ; 205   PA_CR2 = (uint8_t)0x00; // 0b00000000
2578  0008 725f5004      	clr	_PA_CR2
2579                     ; 220   PB_DDR = (uint8_t)0x00; // 0b00000000
2581  000c 725f5007      	clr	_PB_DDR
2582                     ; 222   PB_CR1 = (uint8_t)0xff; // 0b11111111
2584  0010 35ff5008      	mov	_PB_CR1,#255
2585                     ; 224   PB_CR2 = (uint8_t)0x00; // 0b00000000
2587  0014 725f5009      	clr	_PB_CR2
2588                     ; 238   PC_DDR = (uint8_t)0x8e; // 0b10001110
2590  0018 358e500c      	mov	_PC_DDR,#142
2591                     ; 240   PC_CR1 = (uint8_t)0xff; // 0b11111111
2593  001c 35ff500d      	mov	_PC_CR1,#255
2594                     ; 243   PC_CR2 = (uint8_t)0x0e; // 0b00001110
2596  0020 350e500e      	mov	_PC_CR2,#14
2597                     ; 259   PD_DDR = (uint8_t)0x54; // 0b01010100
2599  0024 35545011      	mov	_PD_DDR,#84
2600                     ; 262   PD_CR1 = (uint8_t)0xff; // 0b11111111
2602  0028 35ff5012      	mov	_PD_CR1,#255
2603                     ; 265   PD_CR2 = (uint8_t)0x00; // 0b00000000
2605  002c 725f5013      	clr	_PD_CR2
2606                     ; 280   PE_DDR = (uint8_t)0x21; // 0b00100001
2608  0030 35215016      	mov	_PE_DDR,#33
2609                     ; 282   PE_CR1 = (uint8_t)0xff; // 0b11111111
2611  0034 35ff5017      	mov	_PE_CR1,#255
2612                     ; 285   PE_CR2 = (uint8_t)0x20; // 0b00100000
2614  0038 35205018      	mov	_PE_CR2,#32
2615                     ; 303   PG_DDR = (uint8_t)0x02; // 0b00000010
2617  003c 35025020      	mov	_PG_DDR,#2
2618                     ; 305   PG_CR1 = (uint8_t)0xff; // 0b11111111
2620  0040 35ff5021      	mov	_PG_CR1,#255
2621                     ; 307   PG_CR2 = (uint8_t)0x00; // 0b00000000
2623  0044 725f5022      	clr	_PG_CR2
2624                     ; 310 }
2627  0048 81            	ret	
2660                     ; 450 void LEDcontrol(uint8_t state)
2660                     ; 451 {
2661                     .text:	section	.text,new
2662  0000               _LEDcontrol:
2666                     ; 453   if (state == 1) PA_ODR |= (uint8_t)0x04;
2668  0000 4a            	dec	a
2669  0001 2605          	jrne	L7561
2672  0003 72145000      	bset	_PA_ODR,#2
2675  0007 81            	ret	
2676  0008               L7561:
2677                     ; 455   else PA_ODR &= (uint8_t)(~0x04);
2679  0008 72155000      	bres	_PA_ODR,#2
2680                     ; 456 }
2683  000c 81            	ret	
2696                     	xdef	_LEDcontrol
2697                     	xdef	_gpio_init
2716                     	end
