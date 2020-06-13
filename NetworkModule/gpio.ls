   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Parser V4.11.14 - 18 Nov 2019
   3                     ; Generator (Limited) V4.4.11 - 19 Nov 2019
   4                     ; Optimizer V4.4.11 - 19 Nov 2019
2561                     ; 32 void gpio_init(void)
2561                     ; 33 {
2563                     	switch	.text
2564  0000               _gpio_init:
2568                     ; 56   PA_DDR = (uint8_t)0x3c; // 0b00111100 Pins 3, 9, 10, 11 are outputs
2570  0000 353c5002      	mov	_PA_DDR,#60
2571                     ; 57   PA_CR1 = (uint8_t)0xff; // 0b11111111 Output pins 3, 9, 10, 11 are Push-Pull
2573  0004 35ff5003      	mov	_PA_CR1,#255
2574                     ; 59   PA_CR2 = (uint8_t)0x00; // 0b00000000 Outputs are 2MHz, Inputs are Interrupt Disabled
2576  0008 725f5004      	clr	_PA_CR2
2577                     ; 72   PB_DDR = (uint8_t)0x00; // 0b00000000 All pins are inputs
2579  000c 725f5007      	clr	_PB_DDR
2580                     ; 73   PB_CR1 = (uint8_t)0xff; // 0b11111111 Inputs are Pull-Up
2582  0010 35ff5008      	mov	_PB_CR1,#255
2583                     ; 86   PC_DDR = (uint8_t)0xce; // 0b11001110 Pins 26, 27, 28, 33, 34 are outputs
2585  0014 35ce500c      	mov	_PC_DDR,#206
2586                     ; 87   PC_CR1 = (uint8_t)0xff; // 0b11111111
2588  0018 35ff500d      	mov	_PC_CR1,#255
2589                     ; 90   PC_CR2 = (uint8_t)0x0e; // 0b00001110
2591  001c 350e500e      	mov	_PC_CR2,#14
2592                     ; 106   PD_DDR = (uint8_t)0xfd; // 0b11111101 Pins 41, 43, 44, 45, 46, 47, 48 are outputs
2594  0020 35fd5011      	mov	_PD_DDR,#253
2595                     ; 108   PD_CR1 = (uint8_t)0xff; // 0b11111111 Output Pins 41, 43, 44, 45, 46, 47, 48 are Push Pull
2597  0024 35ff5012      	mov	_PD_CR1,#255
2598                     ; 109   PD_CR2 = (uint8_t)0x00; // 0b00000000 Outputs are 2MHz
2600  0028 725f5013      	clr	_PD_CR2
2601                     ; 122   PE_DDR = (uint8_t)0x29; // 0b00101001 Pins 25, 37, 40 are outputs
2603  002c 35295016      	mov	_PE_DDR,#41
2604                     ; 123   PE_CR1 = (uint8_t)0xff; // 0b11111111
2606  0030 35ff5017      	mov	_PE_CR1,#255
2607                     ; 126   PE_CR2 = (uint8_t)0x20; // 0b00100000
2609  0034 35205018      	mov	_PE_CR2,#32
2610                     ; 144   PG_DDR = (uint8_t)0x03; // 0b00000011 Pins 35, 36 are outputs
2612  0038 35035020      	mov	_PG_DDR,#3
2613                     ; 145   PG_CR1 = (uint8_t)0xff; // 0b11111111 Outputs are Push Pull
2615  003c 35ff5021      	mov	_PG_CR1,#255
2616                     ; 146   PG_CR2 = (uint8_t)0x00; // 0b00000000 Outputs are 2MHz
2618  0040 725f5022      	clr	_PG_CR2
2619                     ; 147 }
2622  0044 81            	ret	
2655                     ; 150 void LEDcontrol(uint8_t state)
2655                     ; 151 {
2656                     	switch	.text
2657  0045               _LEDcontrol:
2661                     ; 153   if (state == 1) PA_ODR |= (uint8_t)0x04;
2663  0045 4a            	dec	a
2664  0046 2605          	jrne	L1561
2667  0048 72145000      	bset	_PA_ODR,#2
2670  004c 81            	ret	
2671  004d               L1561:
2672                     ; 155   else PA_ODR &= (uint8_t)(~0x04);
2674  004d 72155000      	bres	_PA_ODR,#2
2675                     ; 156 }
2678  0051 81            	ret	
2691                     	xdef	_LEDcontrol
2692                     	xdef	_gpio_init
2711                     	end
