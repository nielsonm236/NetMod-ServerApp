/**
 * Timer implementation
 * For STM8S005 2020/04/22 06:55
 */
 
/* Modifications 2020 Michael Nielson
 * Adapted for STM8S005 processor, ENC28J60 Ethernet Controller,
 * Web_Relay_Con V2.0 HW-584, and compilation with Cosmic tool set.
 * Author: Michael Nielson
 * Email: nielsonm.projects@gmail.com
 This program is free software: you can redistribute it and/or modify
 it under the terms of the GNU General Public License as published by
 the Free Software Foundation, either version 3 of the License, or
 (at your option) any later version.

 This program is distributed in the hope that it will be useful, but
 WITHOUT ANY WARRANTY; without even the implied warranty of
 MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
 General Public License for more details.

 See GNU General Public License at <http://www.gnu.org/licenses/>.
 
 Copyright 2020 Michael Nielson
*/



#include <stdint.h>
#include <iostm8s005.h>	// Address definitions for all registers
			// See C:\Program Files (x86)\COSMIC\FSE_Compilers\CXSTM8\Hstm8 directory
#include <stm8s-005.h>	// Bit location definitions in registers
			// See C:\Users\Mike\Desktop\STM8S Peripheral Library\en.stsw-stm8069\STM8S_StdPeriph_Lib\Libraries\STM8S_StdPeriph_Driver\inc directory


/**
 * Create an arp_timer counter.
 * This counter is incremented by 1 each time the 500ms counter expires. It
 * is checked in the arp_timer_expired function until a count of 20 is reached
 * (10 seconds) and cleared at that time.
 */
unsigned char arp_timer;


void clock_init(void)
{
/**
 * Initialize clock speeds and timers
 * Must be called from the initializiation part of main.c
 *
 * Notes on CLK_DIVR
 *	Reset value = 0x18
 *
 * Notes on CLK_PCKEN1 and CLK_PCKEN2
 *	Reset value in both registers = 0xFF
 *
 *	Gating the clock to unused peripherals helps reduce power consumption.
 *	Peripheral Clock Gating (PCG) mode allows you to selectively enable or
 *	disable the fMASTER clock connection to the following peripherals at
 *	any time in Run mode:
 *	 ADC
 *	 I2C
 *	 AWU (register clock, not counter clock)
 *	 SPI
 *	 TIM[4:1]
 *	 UART
 *	 CAN (register clock, not CAN clock)
 *
 *	After a device reset all peripheral clocks are enabled. You can disable
 *	the clock to any peripheral by clearing the corresponding PCKEN bit in
 *	the Peripheral Clock Gating Register 1 (CLK_PCKENR1) and in the Peripheral
 *	Clock Gating Register 2 (CLK_PCKENR2). BUT FIRST you have to properly
 *	disable the peripheral using the appropriate bit before stopping the
 *	corresponding clock.
 *
 *	To enable a peripheral you must first enable the corresponding PCKEN bit
 *	in the CLK_PCKENR registers and THEN set the peripheral enable bit in the
 *	peripheral’s control registers.
 *
 *	The AWU counter is driven by an internal or external clock (LSI or HSE)
 *	independent from fMASTER so that it continues to run even if the register
 *	clock to this peripheral is switched off.
 */

	// Deinitialize clocks (MAY NOT BE NECESSARY AFTER RESET)
	// Sets the CLK peripheral registers to their default reset values.
	// Note: Resetting the CCOR register:
	//   When the CCOEN bit is set the reset of the CCOR register requires
	//   two consecutive write instructions in order to reset first the CCOEN
	//   bit and the second one is to reset the CCOSEL bits.
	CLK_ICKR = ((uint8_t)0x01);
	CLK_ECKR = ((uint8_t)0x00);
	CLK_SWR  = ((uint8_t)0xE1);
	CLK_SWCR = ((uint8_t)0x00);
	CLK_CKDIVR = ((uint8_t)0x18);
	CLK_PCKENR1 = ((uint8_t)0xFF);
	CLK_PCKENR2 = ((uint8_t)0xFF);
	CLK_CSSR = ((uint8_t)0x00);
	CLK_CCOR = ((uint8_t)0x00);
	while ((CLK_CCOR & CLK_CCOR_CCOEN)!= 0) {}
	CLK_CCOR = ((uint8_t)0x00);
	CLK_HSITRIMR = ((uint8_t)0x00);
	CLK_SWIMCCR = ((uint8_t)0x00);
	
	// Set up main clock for operation 
	CLK_ICKR |= ((uint8_t)0x01); // Enable HSI oscillator (MAY NOT BE NECESSARY AFTER RESET)

	// Wait until HSI clock is stable
	while ((CLK_ICKR & CLK_ICKR_HSIRDY)== 0) {}
	
	// Enable the Clock Switch (MAY NOT BE NECESSARY)
	CLK_SWCR |= CLK_SWCR_SWEN;
	
	// Set up clock divider
	// Sets CPU to 16 MHz using HSI internal oscilator
	// Note the CLK_SWR defaults to selecting the HSI
	// as the clock source after reset
	CLK_CKDIVR = (uint8_t)0x00;
	
	// Set up individual clocks
	// Note: Before turning clocks on or off to individual peripherals it is recommended
	// that the peripheral be disabled. Note the following:
	//   ADC is defaulted to disabled after reset per ADC_CR1 register
	//   I2C is defaulted to disabled after reset per I2C_CR1 register
	//   AWU is defaulted to disabled after reset per AWU_CSR register
	//   SPI is defaulted to disabled after reset per SPI_CR1 register
	//   TIM[4:1] are defaulted to disabled after reset per TIMx_CR1 registers
	//   UART is defaulted to disabled after reset per UART_CR1 register
	//   CAN - it is not clear how to disable CAN but I assume it must be
	//     disabled after reset
	CLK_PCKENR1 |= (uint8_t)0x80;		// Enable clock to TIM1
	CLK_PCKENR1 |= (uint8_t)0x20;		// Enable clock to TIM2
	CLK_PCKENR1 |= (uint8_t)0x40;		// Enable clock to TIM3
	CLK_PCKENR1 &= (uint8_t)(~0x10);	// Disable clock to TIM4
	CLK_PCKENR1 &= (uint8_t)(~0x08);	// Disable clock to UART
	CLK_PCKENR1 &= (uint8_t)(~0x02);	// Disable clock to SPI
	CLK_PCKENR1 &= (uint8_t)(~0x01);	// Disable clock to I2C
	CLK_PCKENR2 &= (uint8_t)(~0x08);	// Disable clock to ADC
	CLK_PCKENR2 &= (uint8_t)(~0x04);	// Disable clock to AWU
	
	// Notes on timers
	// The TIM1 counter can have a pre-scale value of any integer from 1
	// to 65536, meaning the counter can be set to increment at any rate
	// of 16MHz divided by the pre-scale value. See the TIM1_PSCRH and
	// TIM1_PSCRL registers.
	// The TIM2 and TIM3 counters can have a pre-scale value of 2 to the
	// X power, where X is 0 to 15. See the TIM2_PSCR and TIM3_PSCR 
	// registers.
	// The TIM4 counter can have a pre-scale value of 2 to the X power,
	// where X is 0 to 7.
	
	// Configure TIM2
	// Configure TIM2 to increment at close to 1000 ticks per second. The
	// below will divide 16MHz by 16384, yielding a 976Hz clock with a
	// period of 1.024ms. Close enough since the timer will mostly be used
	// to find 1/2 second and 10 second periods.
	TIM2_PSCR = (uint8_t)0x0e;
	// Enable TIM2
	TIM2_CR1 = (uint8_t)0x01;
	// Set UG bit to load the PSCR. The bit is auto-cleared by hardware.
	TIM2_EGR = (uint8_t)0x01;
	
	
	// Configure TIM3
	// Configure TIM3 to increment at close to 1,000,000 ticks per second
	// (1us per tick). The below will divide 16MHz by 16, yielding a 1MHz
	// clock with a period of 1us. The timer is used in the ENC28J60
	// functions when short delays are needed. See the wait_timer function.
	TIM3_PSCR = (uint8_t)0x04;
	// Enable TIM3
	TIM3_CR1 = (uint8_t)0x01;
	// Set UG bit to load the PSCR. The bit is auto-cleared by hardware.
	TIM3_EGR = (uint8_t)0x01;
	
	arp_timer = 0x00; // Initialize arp timer

}


/*---------------------------------------------------------------------------*/
/**
 * This function checks for expiration of the periodic timer (TIM2) and
 * if expired resets the timer to a count of zero so that it can repeat its
 * 1ms uptick to 500ms.
 *
 * Each time the periodic timer is reset the arp_timer value is incremented
 * to create a 10 second count. The arp_timer_expired function will clear
 * the incremented value.
 */
uint8_t
periodic_timer_expired(void)
{
  if ((uint8_t)TIM2_CNTRH > 1) { // For simplification evaluate at 512ms
    TIM2_CR1 &= (uint8_t)(~0x01);	// Disable counter
    TIM2_CNTRH = (uint8_t)0x00;		// Clear counter High
    TIM2_CNTRL = (uint8_t)0x00;		// Clear counter Low
    TIM2_CR1 |= (uint8_t)0x01;		// Enable counter
    arp_timer++;			// Increment arp_timer
    return(1);
  }
  else return(0);
}


/*---------------------------------------------------------------------------*/
/**
 * This function checks for expiration of the arp timer and if expired
 * resets the timer to a count of zero so that it can repeat its uptick to
 * 10 seconds.
 */
uint8_t
arp_timer_expired(void)
{
  if (arp_timer > 19) {
    arp_timer = 0;       // Reset arp_timer
    return(1);
  }
  else return(0);
}


/*---------------------------------------------------------------------------*/
/**
 * This function waits for expiration of TIM3 and will not return until the
 * timer expires. Basically a "wait" or "delay" function.
 *
 * Call the function by supplying a wait value in micro-seconds. A 16 bit
 * unsigned value may be provided for a maximum of 50000 micro-seconds wait
 * time. While the counter can count to 65536 it is recommended that a max
 * wait of 50000 be used so that the code has time to evaluate. Call the
 * delay multiple times if more than 50000uS is needed.
 */
void
wait_timer(uint16_t wait)
{
  uint16_t counter;

  TIM3_CR1 &= (uint8_t)(~0x01);		// Disable counter
  TIM3_CNTRH = (uint8_t)0x00;		// Clear counter High
  TIM3_CNTRL = (uint8_t)0x00;		// Clear counter Low
  TIM3_CR1 |= (uint8_t)0x01;		// Enable counter
  
  do {
    counter = ((uint16_t)TIM3_CNTRH << 8) | (uint8_t)TIM3_CNTRL;
  } while(counter <= wait);
  
  return;
}

