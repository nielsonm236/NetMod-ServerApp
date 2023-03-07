/**
 * Timer implementation
 * For STM8S005 2020/04/22 06:55
 */
 
/* Modifications 2020-2022 Michael Nielson
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
 
 Copyright 2022 Michael Nielson
*/


// All includes are in main.h
#include <main.h>


uint8_t periodic_timer;       // Peroidic_timer counter
uint8_t mqtt_timer;           // MQTT_timer counter
uint16_t arp_timer;           // arp_timer counter
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

  CLK_ICKR = CLK_ICKR_RESET_VALUE;           // 0x01
  CLK_ECKR = CLK_ECKR_RESET_VALUE;           // 0x00
  CLK_SWR  = CLK_SWR_RESET_VALUE;            // 0xE1
  CLK_SWCR = CLK_SWCR_RESET_VALUE;           // 0x00
  CLK_CKDIVR = CLK_CKDIVR_RESET_VALUE;       // 0x18
  CLK_PCKENR1 = CLK_PCKENR1_RESET_VALUE;     // 0xFF
  CLK_PCKENR2 = CLK_PCKENR2_RESET_VALUE;     // 0xFF
  CLK_CSSR = CLK_CSSR_RESET_VALUE;           // 0x00
  
  CLK_CCOR = CLK_CCOR_RESET_VALUE;           // 0x00, reset CCOEN
  while ((CLK_CCOR & CLK_CCOR_CCOEN)!= 0) {} // wait until CCOEN clears
  CLK_CCOR = CLK_CCOR_RESET_VALUE;           // 0x00, reset CCOSEL
  
  CLK_HSITRIMR = CLK_HSITRIMR_RESET_VALUE;   // 0x00
  CLK_SWIMCCR = CLK_SWIMCCR_RESET_VALUE;     // 0x00
  
  // Set up main clock for operation 
  CLK_ICKR |= CLK_ICKR_RESET_VALUE;          // 0x01, Enable HSI oscillator
                                             // (MAY NOT BE NECESSARY AFTER RESET)

  // Wait until HSI clock is stable
  while ((CLK_ICKR & CLK_ICKR_HSIRDY)== 0) {}

  // Enable the Clock Switch
  CLK_SWCR |= CLK_SWCR_SWEN; // 0x02


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
  // Since the CLK_PCKENR1 and CLK_PCKENR2 registers were just set to
  // their default values (0xff) above, the following code only needs
  // to disable peripheral clocks that are not needed.
  //   CLK_PCKENR1 |= (uint8_t)0x80;	// TIM1 clock left enabled
  //   CLK_PCKENR1 |= (uint8_t)0x40;	// TIM3 clock left enabled
  //   CLK_PCKENR1 &= (uint8_t)(~0x20);	// TIM2 clock left enabled
  CLK_PCKENR1 &= (uint8_t)(~0x10);	// TIM4 clock disabled

#if DEBUG_SUPPORT == 11
  CLK_PCKENR1 &= (uint8_t)(~0x08);	// UART clock disabled unless we
                                        // are using the UART for debug
					// support (then we just leave
					// it enabled)
#endif // DEBUG_SUPPORT

  //   CLK_PCKENR1 bit 0x04             // Bit location 0x04 is reserved
  CLK_PCKENR1 &= (uint8_t)(~0x02);	// SPI clock disabled
  CLK_PCKENR1 &= (uint8_t)(~0x01);	// I2C clock disabled
  
  // CLK_PCKENR2 bit 0x80               // Bit location 0x80 is reserved
  // CLK_PCKENR2 bit 0x40               // Bit location 0x40 is reserved
  // CLK_PCKENR2 bit 0x20               // Bit location 0x20 is reserved
  // CLK_PCKENR2 bit 0x10               // Bit location 0x10 is reserved
  CLK_PCKENR2 &= (uint8_t)(~0x08);	// ADC I2C clock disabled
  CLK_PCKENR2 &= (uint8_t)(~0x04);	// AWU I2C clock disabled
  // CLK_PCKENR2 bit 0x02               // Bit location 0x02 is reserved
  // CLK_PCKENR2 bit 0x01               // Bit location 0x01 is reserved

  // Notes on timers
  //
  // The TIM1 counter can have a pre-scale value of any integer from 1
  // to 65535, meaning the counter can be set to increment at any rate
  // of 16MHz divided by the pre-scale value. See the TIM1_PSCRH and
  // TIM1_PSCRL registers.
  //
  // The TIM2 and TIM3 counters can have a pre-scale value of 2 to the
  // X power, where X is 0 to 15. If 0 the divisor is 1. If 15 the divisor
  // is 32768. See the TIM2_PSCR and TIM3_PSCR registers.
  //
  // The TIM4 counter can have a pre-scale value of 2 to the X power,
  // where X is 0 to 7.

  // Configure TIM1
  // TIM1 is being used as a simple counter, so most of its registers
  // are not used. This will configure TIM1 to increment at ~1MHz and
  // the counter will repeat every 1000 ticks, yielding a period of
  // ~1ms.
  //  TIM1_CR1 = 0x00;                      // Make sure TIM1 is disabled
  //  TIM1_RCR = 0x00;                      // Make sure Repeat counter value is zero
  //  TIM1_IER = 0x00;                      // Make sure interupts are disabled
  //  TIM1_CNTRH=0;                         // Make sure timer is zero
  //  TIM1_CNTRL=0;                         // Make sure timer is zero
  
//  TIM1_ARRH = (uint8_t)(0x03);  // Timing 1ms; Count to decimal
//  TIM1_ARRL = (uint8_t)(0xE8);  //   1000 (0x03E8)
//  TIM1_ARRH = (uint8_t)(0xFA);  // Timing 64ms; Count to decimal
//  TIM1_ARRL = (uint8_t)(0x00);  //   64000 (0xFA00)
  TIM1_ARRH = (uint8_t)(0xFA);  // Timing 640ms; Count to decimal
  TIM1_ARRL = (uint8_t)(0x00);  //   64000 (0xFA00)
//  TIM1_PSCRH = (uint8_t)(0x00); // 16MHz / (1+15) = 1MHz
//  TIM1_PSCRL = (uint8_t)(0x0F); //   1us period
  TIM1_PSCRH = (uint8_t)(0x00); // 16MHz / (1+159) = 100KHz
  TIM1_PSCRL = (uint8_t)(0x9F); //   10us period
  TIM1_EGR = (uint8_t)0x01;     // Set UG bit to load the PSCR. The
                                // bit is auto-cleared by hardware.
  TIM1_SR1 = (uint8_t)(~0x01);  // Clear the UIF (update interrupt flag)
  TIM1_CR1 |= 0x01;             // Enable the counter

  // Configure TIM2
  // Configure TIM2 to increment at 16MHz / 16384, yielding a 1.024 KHz
  // clock with a period of 976us. The timer is used in debug routines as
  // an approximate 1ms count. The TIM2_CNTRH and TIM2_CNTRL bytes can be
  // directly read to determine time differences. The counter will roll over
  // about every 64 seconds, so the firmware using the counter may have to
  // account for that roll over.  
  TIM2_PSCR = (uint8_t)0x0e;	// Pre-scale divider is 2^14 = divide by 16384
                                //   to provide an approximately 1ms period
  // TIM2_PSCR = (uint8_t)0x04;	// Pre-scale divider is 2^4 = divide by 16 to
                                //   provide an approximately 1us period
  
  TIM2_CNTRH = (uint8_t)0x00;	// Clear counter High
  TIM2_CNTRL = (uint8_t)0x00;	// Clear counter Low
  // Enable TIM2
  TIM2_CR1 = (uint8_t)0x01;
  // Set UG bit to load the PSCR. The bit is auto-cleared by hardware.
  TIM2_EGR = (uint8_t)0x01;
  // To stop and restart the counter:
  //   TIM2_CR1 &= (uint8_t)(~0x01);		// Disable counter
  //   TIM2_CNTRH = (uint8_t)0x00;		// Clear counter High
  //   TIM2_CNTRL = (uint8_t)0x00;		// Clear counter Low
  //   TIM2_CR1 |= (uint8_t)0x01;		// Enable counter
  // To read the counter value:
  //   counter = ((uint16_t)TIM2_CNTRH << 8) | (uint8_t)TIM2_CNTRL;


  // Configure TIM3
  // Configure TIM3 to increment at close to 1,000,000 ticks per second
  // (1us per tick). The below will divide 16MHz by 16, yielding a 1MHz
  // clock with a period of 1 us. See the wait_timer function.
  TIM3_PSCR = (uint8_t)0x04; // Pre-scale divider is 2^4 = divide by 16
  // Enable TIM3
  TIM3_CR1 = (uint8_t)0x01;
  // Set UG bit to load the PSCR. The bit is auto-cleared by hardware.
  TIM3_EGR = (uint8_t)0x01;

  periodic_timer = 0;      // Initialize periodic timer
  mqtt_timer = 0;          // Initialize mqtt timer
  t100ms_timer = 0;        // Initialize 100ms timer
  arp_timer = 0;           // Initialize arp timer
  second_toggle = 0;       // Initialize toggle for seconds counter
  second_counter = 0;      // Initialize seconds counter
}


/*
void timer_update(void)
{
  // This function is called by the main loop to maintain timers. This
  // function increments timer counters as follows:
  //   periodic_timer        increments once per 1ms
  //   mqtt_timer            increments once per 1ms
  //   arp_timer             increments once per 1ms
  //   second_counter        increments once per second
  // Functions using these timers will call the following functions to
  // determine if the designated timeout has occurred:
  //   periodic_timer_expired
  //   mqtt_timer_expired
  //   arp_timer_expired
  // If an expiration has occurred the called function will reset the
  // appropriate timer counter to start the next cycle. The second_timer runs
  // 'forever' and tracking elapsed time is the responsibility of the external
  // function using the counter.
  //
  // The timers use TIM1 to track time. TIM1 increments at 1MHz, and is
  // configured to provide a UIF flag every 1ms.
  
  if (TIM1_SR1 & 0x01) {                // Signals the passage of 1 ms
    TIM1_SR1 = (uint8_t)(~0x01);        // Clear the UIF (update interrupt flag)
    
    // Increment the timers every 1ms. Their respective "_expired"
    // function calls will determine their timeout points.
    periodic_timer++;
    mqtt_timer++;
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
*/
void timer_update(void)
{
  // This function is called by the main loop to maintain timers. This
  // function increments timer counters as follows:
  //   periodic_timer        Time in ms
  //   mqtt_timer            Time in ms
  //   arp_timer             Time in ms
  //   100ms_timer           Time in ms
  //   second_counter        Time in seconds
  // Functions using these timers will call the following functions to
  // determine if the designated timeout has occurred:
  //   periodic_timer_expired
  //   mqtt_timer_expired
  //   arp_timer_expired
  //   100ms_timer_expired
  // If an expiration has occurred the called function will reset the
  // appropriate timer counter to start the next cycle. The second_timer runs
  // 'forever' and tracking elapsed time is the responsibility of the external
  // function using the counter.
  //
  // The timers use TIM1 to track time. TIM1 increments at 100KHz (10us
  // period).
  //
  // TIM1 is configured to count to 64000 (640ms) before it resets. It is
  // assumed we NEVER take longer than 640ms before getting around to running
  // timer_update().
  // 
  // If the counter does over-flow the time collected will be incorrect in
  // 640ms increments. The external design needs to make sure this never
  // happens.
  // 
  // timer_update() is called with every pass through the main.c loop, so it
  // is typically called about once per millisecond. However, there are some
  // functions which may delay the main.c loop for several milliseconds. The
  // webpage servicing function may cause delays of 65ms or longer. To
  // account for these delays the timer_update() function determines how many
  // milliseconds have passed since the last call and adds that to all of the
  // dependent time counters. The timer_update() function also forwards the
  // time remainder to the next up-count so that fractions of a millisecond
  // are not lost.
  //
  // Note: Calls to the function can be spread out by up to 640ms. Measure-
  // ments show the current gap in calls to timer_update() to be from less
  // than 1ms, typically 1 to 2ms, and rare gaps of up to 65ms. The function
  // will now add the correct number of milliseconds to the periodic_timer,
  // mqtt_timer, arp_timer, 100ms_timer, and second_counter. TIM1 is used as
  // the time base for the counters. TIM1 is configured to clock at 100KHz and
  // the counter will count to 64000 (640ms) before it resets. It is assumed
  // the main.c loop NEVER takes longer than 640ms before getting around to
  // calling timer_update(). If the counter does over-flow the time collected
  // can be in error in 640ms increments. The overall main loop design must
  // guarantee that this does not happen.

  
  uint16_t counter;
  uint16_t time_ms;
  uint16_t remainder;
  
  // Read the counter
  counter = (uint16_t)(TIM1_CNTRH << 8);
  counter = counter | TIM1_CNTRL;

  // Check for how many milliseconds have passed since the counter was last
  // read. The counter runs with a 10us period, so the number of milliseconds
  // is counter / 100.
  time_ms = counter / 100;
  // Load the counter with the remainder of the count. This keeps the timer
  // from being over-run, and prevents the loss of fractions of a millisecond
  // that may remain each time the counter exceeds 1ms.
  remainder = counter - (time_ms * 100);
  TIM1_CR1 &= (uint8_t)(~0x01);		// Disable counter
  TIM1_CNTRH = (uint8_t)(remainder >> 8);
  TIM1_CNTRL = (uint8_t)(remainder & 0x00ff);
  TIM1_CR1 |= (uint8_t)0x01;		// Enable counter

  // Increment the timers per the number of ms collected above. The timer's
  // respective "_expired" function calls will determine their timeout points.
  periodic_timer = (uint8_t)(periodic_timer + time_ms);
  mqtt_timer = (uint8_t)(mqtt_timer + time_ms);
  arp_timer = (uint16_t)(arp_timer + time_ms);
  t100ms_timer = (uint8_t)(t100ms_timer + time_ms);
    
  // Update the second_counter. The second_counter is a 32 bit unsigned
  // integer, so its lifetime is about 136 years if never power cycled - 
  // essentially forever in this application.
  if (second_toggle < 1000) {
    second_toggle += time_ms;			// Increment second_toggle every 1ms
  }
  else {
    second_toggle = second_toggle - 1000;
    second_counter ++;			// Increment second_counter every 1 sec
  }
}


uint8_t periodic_timer_expired(void)
{
  // This function indicates expiration of the periodic timer at a count
  // indicating that 20ms have passed. If expired the function resets the
  // periodic_timer counter to zero so that it can repeat its uptick.
//  if (periodic_timer > 19) { // Produces HTML re-xmit errors and webpage
                               // corruption.
//  if (periodic_timer > 39) { // Produces fewer HTML re-xmit errors
//  if (periodic_timer > 59) { // Produces fewer HTML re-xmit errors
  if (periodic_timer > 79) { // Produces almost no HTML re-xmit errors
    periodic_timer = 0;
    return(1);
  }
  else return(0);
}


uint8_t mqtt_timer_expired(void)
{
  // This function indicates experation of the mqtt timer at a count
  // indicating that 50ms have passed. If expired the function resets the
  // mqtt_timer counter to zero so that it can repeat its uptick.
  if (mqtt_timer > 49) {
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
  // that 10 seconds have passed. The arp_timer increments once per milli-
  // second. If expired the function resets the arp_timer counter to zero so
  // that it can repeat its uptick.
  if (arp_timer > 9999) {
    arp_timer = 0;       // Reset arp_timer
    return(1);
  }
  else return(0);
}


void wait_timer(uint16_t wait)
{
  // This function waits for expiration of TIM3 and will not return until the
  // timer expires. Basically a "wait" or "delay" function. No code execution
  // occurs during the wait.
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
