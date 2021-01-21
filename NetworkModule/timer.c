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
#include <main.h>

uint8_t periodic_timer;       // Peroidic_timer counter
uint8_t mqtt_timer;           // MQTT_timer counter
uint16_t arp_timer;           // arp_timer counter
uint8_t mqtt_outbound_timer;  // mqtt_outbound_timer counter
uint8_t t100ms_timer;         // MQTT_timer counter

uint16_t second_toggle;       // MQTT timing: Used in developing a 1 second counter
uint32_t second_counter;      // MQTT timing: 1 second counter

void clock_init(void)
{
  // Initialize clock speeds and timers
  // Must be called from the initializiation part of main.c
  //
  // Notes on CLK_DIVR
  //	Reset value = 0x18
  //
  // Notes on CLK_PCKEN1 and CLK_PCKEN2
  //	Reset value in both registers = 0xFF
  //
  //	Gating the clock to unused peripherals helps reduce power consumption.
  //	Peripheral Clock Gating (PCG) mode allows you to selectively enable or
  //	disable the fMASTER clock connection to the following peripherals at
  //	any time in Run mode:
  //	 ADC
  //	 I2C
  //	 AWU (register clock, not counter clock)
  //	 SPI
  //	 TIM[4:1]
  //	 UART
  //	 CAN (register clock, not CAN clock)
  //
  //	After a device reset all peripheral clocks are enabled. You can disable
  //	the clock to any peripheral by clearing the corresponding PCKEN bit in
  //	the Peripheral Clock Gating Register 1 (CLK_PCKENR1) and in the Peripheral
  //	Clock Gating Register 2 (CLK_PCKENR2). BUT FIRST you have to properly
  //	disable the peripheral using the appropriate bit before stopping the
  //	corresponding clock.
  //
  //	To enable a peripheral you must first enable the corresponding PCKEN bit
  //	in the CLK_PCKENR registers and THEN set the peripheral enable bit in the
  //	peripheral’s control registers.
  //
  //	The AWU counter is driven by an internal or external clock (LSI or HSE)
  //	independent from fMASTER so that it continues to run even if the register
  //	clock to this peripheral is switched off.

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
  //
  // The TIM1 counter can have a pre-scale value of any integer from 1
  // to 65535, meaning the counter can be set to increment at any rate
  // of 16MHz divided by the pre-scale value. See the TIM1_PSCRH and
  // TIM1_PSCRL registers.
  //
  // The TIM2 and TIM3 counters can have a pre-scale value of 2 to the
  // X power, where X is 0 to 15. See the TIM2_PSCR and TIM3_PSCR 
  // registers.
  //
  // The TIM4 counter can have a pre-scale value of 2 to the X power,
  // where X is 0 to 7.

  // Configure TIM1
  // TIM1 is being used as a simple counter, so most of its registers
  // are not used. This will configure TIM1 to increment at ~1MHz and
  // the counter will repeat every 10000 ticks, yielding a period of
  // ~10ms.
  //  TIM1_CR1 = 0x00;                      // Make sure TIM1 is disabled
  //  TIM1_RCR = 0x00;                      // Make sure Repeat counter value is zero
  //  TIM1_IER = 0x00;                      // Make sure interupts are disabled
  //  TIM1_CNTRH=0;                         // Make sure timer is zero
  //  TIM1_CNTRL=0;                         // Make sure timer is zero
  
  TIM1_ARRH = (uint8_t)(0x03);  // Timing 1ms; Count to decimal
  TIM1_ARRL = (uint8_t)(0xE8);  // 1000 (0x03E8)
  TIM1_PSCRH = (uint8_t)(0x00); // 16MHz / (1+15) = 1MHz
  TIM1_PSCRL = (uint8_t)(0x0F);
  TIM1_EGR = (uint8_t)0x01;     // Set UG bit to load the PSCR. The
                                // bit is auto-cleared by hardware.
  TIM1_SR1 = (uint8_t)(~0x01);  // Clear the UIF (update interrupt flag)
  TIM1_CR1 |= 0x01;             // Enable the counter

/*
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
*/

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

  periodic_timer = 0;      // Initialize periodic timer
  mqtt_timer = 0;          // Initialize mqtt timer
  t100ms_timer = 0;         // Initialize 100ms timer
  arp_timer = 0;           // Initialize arp timer
  mqtt_outbound_timer = 0; // Initialize 50ms_timer counter
  second_toggle = 0;       // Initialize toggle for seconds counter
  second_counter = 0;      // Initialize seconds counter
}


void timer_update(void)
{
  // This function is called by the main loop to maintain timers. This
  // function returns a 0 value, however the function increments three
  // timer counters as follows:
  //   periodic_timer - increments once per 1ms
  //   mqtt_timer - increments once per 1ms
  //   mqtt_outbound_timer - increments once per 1ms
  //   arp_timer - increments once per 1ms
  //   second_counter - increments once per second
  // Functions using these timers will call the following functions to
  // determine if the designated timeout has occurred:
  //   periodic_timer_expired
  //   mqtt_timer_expired
  //   mqtt_outbound_timer_expired
  //   arp_timer_expired
  // If an expiration has occurred the called function will reset the
  // appropriate timer counter to start the next cycle. The
  // second_timer runs 'forever' and tracking elapsed time is the
  // responsibility of the external function using the counter.
  //
  // The timers use TIM1 to track time. TIM1 increments at 1MHz, and is
  // configured to provide a UIF flag every 1ms.
  
  if (TIM1_SR1 & 0x01) {                // Signals the passage of 1 ms
    TIM1_SR1 = (uint8_t)(~0x01);        // Clear the UIF (update interrupt flag)
    
    // Increment the timers every 1ms. Their respective "_expired"
    // function calls will determine their timeout points.
    periodic_timer++;
    mqtt_timer++;
    mqtt_outbound_timer++;
    arp_timer++;
    t100ms_timer++;
    
    // Update the second_counter. The second_counter is a 32 bit unsigned
    // integer, so its lifetime is about 136 years if never power cycled - 
    // essentially forever in this application.
    if (second_toggle < 1000) {
      second_toggle++;			// Increment second_toggle every 1ms
    }
    else {
      second_toggle = 0;
      second_counter++;			// Increment second_counter every 1 sec
    }
  }
}


uint8_t periodic_timer_expired(void)
{
  // This function indicates expiration of the periodic timer at a count
  // indicating that 20ms have passed. If expired the function resets the
  // periodic_timer counter to zero so that it can repeat its uptick.
  if (periodic_timer > 19) {
    periodic_timer = 0;
    return(1);
  }
  else return(0);
}



uint8_t mqtt_outbound_timer_expired(void)
{
  // This function indicates expiration of the mqtt outbound timer at a count
  // indicating 50ms have passed. If expired the function resets the timer
  // counter to zero so that it can repeat its uptick.
  // Performance note: At some point between a setting of 40ms and 50ms the
  // outbound messaging begins to loose messages, particularly when commands
  // to set all outputs on or off are used. I recommend this setting not be
  // made smaller than 50ms.
  if (mqtt_outbound_timer > 49) {
    mqtt_outbound_timer = 0;       // Reset timer
    return(1);
  }
  else return(0);
}



uint8_t mqtt_timer_expired(void)
{
  // This function indicates experation of the mqtt timer at a count
  // indicating that 100ms have passed. If expired the function resets the
  // mqtt_timer counter to zero so that it can repeat its uptick.
  if (mqtt_timer > 99) {
    mqtt_timer = 0;
    return(1);
  }
  else return(0);
}



uint8_t t100ms_timer_expired(void)
{
  // This function indicates experation of the 100ms timer at a count
  // indicating that 100ms have passed. If expired the function resets the
  // 100ms_timer counter to zero so that it can repeat its uptick.
  if (t100ms_timer > 99) {
    t100ms_timer = 0;
    return(1);
  }
  else return(0);
}



uint8_t arp_timer_expired(void)
{
  // This function indicates expiration of the arp timer at a count indicating
  // that 10 seconds have passed. If expired the function resets the arp_timer
  // counter to zero so that it can repeat its uptick.
  if (arp_timer > 9999) {
    arp_timer = 0;       // Reset arp_timer
    return(1);
  }
  else return(0);
}



void wait_timer(uint16_t wait)
{
  // This function waits for expiration of TIM3 and will not return until the
  // timer expires. Basically a "wait" or "delay" function.
  //
  // Call the function by supplying a wait value in micro-seconds. A 16 bit
  // unsigned value may be provided for a maximum of 50000 micro-seconds wait
  // time. While the counter can count to 65535 it is recommended that a max
  // wait of 50000 be used so that the code has time to evaluate. Call the
  // delay multiple times if more than 50000uS is needed.
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

