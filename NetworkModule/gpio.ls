   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Parser V4.11.14 - 18 Nov 2019
   3                     ; Generator (Limited) V4.4.11 - 19 Nov 2019
   4                     ; Optimizer V4.4.11 - 19 Nov 2019
2569                     ; 205 void gpio_init(void)
2569                     ; 206 {
2571                     .text:	section	.text,new
2572  0000               _gpio_init:
2576                     ; 230   if ((magic4 == 0x55) && 
2576                     ; 231       (magic3 == 0xee) && 
2576                     ; 232       (magic2 == 0x0f) && 
2576                     ; 233       (magic1 == 0xf0)) {
2578  0000 c60000        	ld	a,_magic4
2579  0003 a155          	cp	a,#85
2580  0005 261b          	jrne	L3461
2582  0007 c60000        	ld	a,_magic3
2583  000a a1ee          	cp	a,#238
2584  000c 2614          	jrne	L3461
2586  000e c60000        	ld	a,_magic2
2587  0011 a10f          	cp	a,#15
2588  0013 260d          	jrne	L3461
2590  0015 c60000        	ld	a,_magic1
2591  0018 a1f0          	cp	a,#240
2592  001a 2606          	jrne	L3461
2593                     ; 238     check_eeprom_IOpin_settings();
2595  001c cd0000        	call	_check_eeprom_IOpin_settings
2597                     ; 241     write_output_registers();
2599  001f cd0000        	call	_write_output_registers
2601  0022               L3461:
2602                     ; 257   PA_DDR = (uint8_t)0x2c; // 0b0010 1100
2604  0022 352c5002      	mov	_PA_DDR,#44
2605                     ; 259   PA_CR1 = (uint8_t)0xff; // 0b1111 1111
2607  0026 35ff5003      	mov	_PA_CR1,#255
2608                     ; 262   PA_CR2 = (uint8_t)0x00; // 0b0000 0000
2610  002a 725f5004      	clr	_PA_CR2
2611                     ; 278   PB_DDR = (uint8_t)0x00; // 0b0000 0000
2613  002e 725f5007      	clr	_PB_DDR
2614                     ; 280   PB_CR1 = (uint8_t)0xff; // 0b1111 1111
2616  0032 35ff5008      	mov	_PB_CR1,#255
2617                     ; 282   PB_CR2 = (uint8_t)0x00; // 0b0000 0000
2619  0036 725f5009      	clr	_PB_CR2
2620                     ; 297   PC_DDR = (uint8_t)0x8e; // 0b1000 1110
2622  003a 358e500c      	mov	_PC_DDR,#142
2623                     ; 299   PC_CR1 = (uint8_t)0xff; // 0b1111 1111
2625  003e 35ff500d      	mov	_PC_CR1,#255
2626                     ; 302   PC_CR2 = (uint8_t)0x0e; // 0b0000 1110
2628  0042 350e500e      	mov	_PC_CR2,#14
2629                     ; 319   PD_DDR = (uint8_t)0x54; // 0b0101 0100
2631  0046 35545011      	mov	_PD_DDR,#84
2632                     ; 322   PD_CR1 = (uint8_t)0xff; // 0b1111 1111
2634  004a 35ff5012      	mov	_PD_CR1,#255
2635                     ; 325   PD_CR2 = (uint8_t)0x00; // 0b0000 0000
2637  004e 725f5013      	clr	_PD_CR2
2638                     ; 341   PE_DDR = (uint8_t)0x21; // 0b0010 0001
2640  0052 35215016      	mov	_PE_DDR,#33
2641                     ; 343   PE_CR1 = (uint8_t)0xff; // 0b1111 1111
2643  0056 35ff5017      	mov	_PE_CR1,#255
2644                     ; 346   PE_CR2 = (uint8_t)0x20; // 0b0010 0000
2646  005a 35205018      	mov	_PE_CR2,#32
2647                     ; 365   PG_DDR = (uint8_t)0x02; // 0b0000 0010
2649  005e 35025020      	mov	_PG_DDR,#2
2650                     ; 367   PG_CR1 = (uint8_t)0xff; // 0b1111 1111
2652  0062 35ff5021      	mov	_PG_CR1,#255
2653                     ; 369   PG_CR2 = (uint8_t)0x00; // 0b0000 0000
2655  0066 725f5022      	clr	_PG_CR2
2656                     ; 372 }
2659  006a 81            	ret	
2692                     ; 512 void LEDcontrol(uint8_t state)
2692                     ; 513 {
2693                     .text:	section	.text,new
2694  0000               _LEDcontrol:
2698                     ; 515   if (state == 1) PA_ODR |= (uint8_t)0x04;
2700  0000 4a            	dec	a
2701  0001 2605          	jrne	L1661
2704  0003 72145000      	bset	_PA_ODR,#2
2707  0007 81            	ret	
2708  0008               L1661:
2709                     ; 517   else PA_ODR &= (uint8_t)(~0x04);
2711  0008 72155000      	bres	_PA_ODR,#2
2712                     ; 518 }
2715  000c 81            	ret	
2728                     	xref	_magic1
2729                     	xref	_magic2
2730                     	xref	_magic3
2731                     	xref	_magic4
2732                     	xref	_write_output_registers
2733                     	xref	_check_eeprom_IOpin_settings
2734                     	xdef	_LEDcontrol
2735                     	xdef	_gpio_init
2754                     	end
