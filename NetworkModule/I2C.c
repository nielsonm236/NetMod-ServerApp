/*
 * I2C source file
 */
 
/* 2021 Michael Nielson
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
 
 Copyright 2021 Michael Nielson
*/


#include <stdint.h>
#include <stdlib.h>
#include <string.h>

#include "iostm8s005.h"
#include "stm8s-005.h"
#include "I2C.h"
#include "main.h"
#include "uip.h"
#include "timer.h"
#include "uart.h"
#include "httpd.h"
#include "uipopt.h"

extern uint8_t OctetArray[11];

uint8_t I2C_failcode;

// These variables are used only by the eeprom_copy_to_flash() function.
// The variables are located at the end of the Stack space. This is done so
// that the various builds that use the eeprom_copy_to_flash() function will
// have identical code in the #pragma segment. This allocation method prevents
// the various builds from locating the variables in RAM at locations of their
// own choosing - which will be different for each build using normal
// variable declarations.
char * flash_ptr @0x600;          // 4 bytes; Placed at even address
char * ram_ptr @0x604;            // 4 bytes; Placed at even address
uint16_t copy_ram_index @0x608;   // 2 bytes
uint8_t eeprom_num_write @0x610;  // 1 byte
uint8_t eeprom_num_read @0x611;   // 1 byte
uint16_t eeprom_base @0x612;      // 2 bytes




#pragma section (flash_update)

#if I2C_SUPPORT == 1

//---------------------------------------------------------------------------//
// This code uses:
//   IO 14 as the I2C CLK signal (SCL)
//   IO 15 as the I2C DATA signal (SDA)
//
// IO 14 is Port E bit 3 (of 0-7), thus mask is 0x08
//   PE_DDR 1 is output, 0 is input
//   PE_ODR
//   PE_IDR
// IO 15 is Port G bit 0 (of 0-7), thus mask is 0x01
//   PG_DDR 1 is output, 0 is input
//   PG_ODR
//   PG_IDR
//
// If the I2C Feature is enabled in the Configuration page IO 14 and 15 are
// kept "disabled" from the perspective of normal input/output operation.
// This leaves the IO pin free to be manipulated by this code for I2C IO.
//
// In main.c, the write_output_pins() function will not write IO 14 and 15.
// Instead in main.c, the check_runtime_changes() function will set IO 14 and
// 15 to disabled if the Feature "I2C" is enabled. This removes the IO pins
// from the IOControl page, and the IO pin will be kept disabled even if the
// user attempts to enable them in the Configuration page.
//
// Hardware requirements:
// a) You must add a 4.7Kohm pull up to 3V or to 5V on pins IO 14 and IO 15.
// b) The I2C devices attached have a local 3V or 5V power supply.
//---------------------------------------------------------------------------//

// Typical use sequence:
//  I2C_control(write ...)
//  I2C_byte_address(...)
//  I2C_write_byte(...) 1 byte or 64 bytes
//  I2C_stop()
// or
//  I2C_control(write ...)
//  I2C_byte_address(...)
//  I2C_control(read...)
//  I2C_read_byte(...) 1 byte or 64 bytes
//  I2C_stop()

void I2C_control(uint8_t control_byte)
{
  // The Control Byte addresses a device and provides the Read/Write bit to
  // the device
  
  // Since the SDA and SCL pins are pulled high with a resistor to create a
  // "1" on the bus, the Output Data Register for the SDA and SCL pins is
  // written to 0, then a "1" on the pin is created by making the pin an input
  // (effectively tri-stating the pin), and a "0" is created on the pin by
  // making the pin an output. When read or write calls are made after
  // addressing a device these ODR settings carry through to those functions.
  
  // Initialize pins. DDR is already 0 so these pins are floating.
  PG_ODR &= (uint8_t)~0x01; // Write SDA ODR to 0
  PE_ODR &= (uint8_t)~0x08; // Write SCL ODR to 0
  
  // Start condition:
  SDA_high(); // Make sure SDA is high
  SCL_high(); // Make sure SCL is high
  SDA_low(); // Drive SDA low, then wait 5us
  SCL_low(); // Drive SCL low, then no wait

  // Output Device Control Byte. Bits 7 to 1 are address information, bit 0 is
  // the Read/Write bit
  I2C_transmit_byte(control_byte);
  
  // Read NACK/ACK from slave
  if (Read_Slave_NACKACK()) I2C_failcode = I2C_FAIL_NACK_CONTROL_BYTE;
}


void I2C_byte_address(uint16_t byte_address)
{
  // Send address to the Off-Board EEPROM where a byte read or write is to
  // occur, or a sequential read/write stream is to occur.
  
  // Output Byte Address bit 15 to 8
  I2C_transmit_byte((uint8_t)(byte_address >> 8));
  
  // Read NACK/ACK from slave
  if (Read_Slave_NACKACK()) I2C_failcode = I2C_FAIL_NACK_BYTE_ADDRESS1;
  
  // Output Byte Address bit 7 to 0
  I2C_transmit_byte((uint8_t)(byte_address & 0x00ff));
  
  // Read NACK/ACK from slave
  if (Read_Slave_NACKACK()) I2C_failcode = I2C_FAIL_NACK_BYTE_ADDRESS2;
}


uint8_t I2C_read_byte(uint8_t I2C_last_flag)
{
  // In this application we only do sequential reads. NACK/ACK require
  // special handling for this case. Each byte read is followed by an ACK
  // except for the last byte, which is followed by NACK then a STOP
  // condition.
  uint8_t data_mask;
  uint8_t I2C_data_field;
  int nop_cnt;
  
  // Read Data bit 7 to 0
  data_mask = 0x80;
  I2C_data_field = 0;
  while(1) {
    // Input Data bit 7 to 0
    SCL_high(); // Float SCL high, then wait 5us
    if ((uint8_t)(PG_IDR & 0x01)) {
      // Read data bit
      I2C_data_field |= data_mask;
    }
    SCL_low();  // Drive SCL low, then no wait
    for (nop_cnt=0; nop_cnt<10; nop_cnt++) nop(); // Wait 5us
    data_mask = (uint8_t)(data_mask >> 1);
    if (data_mask == 0) break;
  }
  
  //   Output NACK/ACK
  if (I2C_last_flag == 0) {
    SDA_low();  // Drive SDA low, then wait 5us. ACK for sequential reads.
    SCL_pulse();
    SDA_high(); // Release SDA (float).
  }
  else {
    SDA_high(); // Float SDA high, then wait 5us. NACK for last byte.
    SCL_pulse();
    I2C_stop();
  }
  return I2C_data_field;
}


void SCL_pulse(void)
{
  SCL_high(); // Float SCL high, then wait 5us.
  SCL_low();  // Drive SCL low, then no wait.
}


void SCL_high(void)
{
  int nop_cnt;
  
  PE_DDR &= (uint8_t)~0x08;; // write SCL DDR to 0 to float SCL high
  for (nop_cnt=0; nop_cnt<10; nop_cnt++) nop(); // Wait 5us
}


void SCL_low(void)
{
  PE_DDR |= (uint8_t)0x08; // write SCL DDR to 1 to pull SCL low
  // No wait after SCL_low
}


void SDA_high(void)
{
  int nop_cnt;
  
  PG_DDR &= (uint8_t)~0x01; // write SDA DDR to 0 to float SDA high
  for (nop_cnt=0; nop_cnt<10; nop_cnt++) nop(); // Wait 5us
}


void SDA_low(void)
{
  int nop_cnt;
  
  PG_DDR |= (uint8_t)0x01; // write SDA DDR to 1 to pull SDA low
  for (nop_cnt=0; nop_cnt<10; nop_cnt++) nop(); // Wait 5us
}


void I2C_transmit_byte(uint8_t I2C_transmit_data)
{
  // This function will transmit up to 8 bits of data depending on the mask.
  // For a normal data byte the mask starts with 0x80 and 8 bits are
  // transmitted. For a device address byte the mask starts with 0x40 and
  // 7 address bits are transmitted.
  uint8_t data_mask;
  data_mask = 0x80;
  while(1) {
    if ((I2C_transmit_data & data_mask) == data_mask) SDA_high(); // Float SDA high, wait 5us
    else SDA_low();                        // or Drive SDA low, wait 5us
    SCL_pulse();
    data_mask = (uint8_t)(data_mask >> 1);
    if (data_mask==0) break;
  }
}
  
  
uint8_t Read_Slave_NACKACK(void)
{
  uint8_t rtn;

  rtn = 0;
  
  // Read NACK/ACK from slave
  SDA_high(); // Float SDA high, wait 5us. This tristates the pin so slave
              // can send NACK/ACK. ACK indicates slave received the address 
              // properly.
  SCL_high(); // Float SCL high, then wait 5us
  
  if (PG_IDR & 0x01) rtn = 1; // Read pin. 1 = NACK.
  
  SCL_low();  // Drive SCL low, then no wait
  
  return rtn;
}

  
void I2C_stop(void)
{
  // Stop Condition
  SDA_low();  // Drive SDA low, then wait 5us
  SCL_high(); // Float SCL high, then wait 5us
  SDA_high(); // Fload SDA high, then wait 5us
}

#endif // I2C_SUPPORT == 1


#if OB_EEPROM_SUPPORT == 1
void eeprom_copy_to_flash(void)
{
  uint16_t eeprom_index;
  uint8_t eeprom_temp[4];

  // This function will copy a Flash image from the Off-Board EEPROM to the
  // STM8 Flash. In this application there are two image locations in the
  // Off-Board EEPROM:
  //   1) The lower 32KB of the Off-Board EEPROM contains an image of new
  //      Runtime code.
  //   2) The upper 32KB of the Off-Board EEPROM contans an image of the
  //      Code Updater. The Code Updater is used to allow the user to specify
  //      the file location of a new Runtime image.
  //
  // Copying data from the Off-Board EEPROM to Flash needs to be done 4 bytes
  // at a time. I'm not implementing "block programming" of the Flash at this
  // time due to the need to execute code from RAM.
  //
  // If we were to copy the entire Off-Board EEPROM to Flash the copy would be
  // 32768 bytes. 4 at a time would be 8192 cycles. The time to complete this
  // copy is about 8192 x 6ms = 50 sec.
  //
  // I have to assume that the Stack is still functional when this code runs,
  // as it needs to call the I2C functions contained in this segment. Initial
  // testing shows that the Stack must be working, as the Flash is updated
  // with new Base code.
  //
  // IMPORTANT IMPORTANT IMPORTANT IMPORTANT IMPORTANT IMPORTANT IMPORTANT
  // Changes to the eeprom_copy_to_flash() and copy_ram_to_flash() code must
  // be made VERY carefully. These two functions have been packed into as few
  // bytes as possible and they barely fit in their respective memory segment
  // allocations. So, if any changes are made the resultant binary needs to
  // be checked to make sure they do not go outside their segment boundaries.
  
  eeprom_index = eeprom_base; // Set index to base address
			      
  // The Flash must be unlocked to allow any writes to it. The unlock occurs
  // by the routine that calls this function. Note that when Flash is written
  // the STM8 hardware will stall code execution until the write completes.
  // This typically takes 6ms per write.

  
  while(eeprom_index < eeprom_base + PROGRAM_SEGMENT_LENGTH) {
    // Copying program data up to but not including the flash_update segment
    // Read 4 bytes from the Off-Board EEPROM.
    // Read addressing sequence: Send Write Control byte, send Byte address,
    // send Read Control Byte
    I2C_control(eeprom_num_write);  // Write control byte to establish address
    I2C_byte_address(eeprom_index); // Byte address of first byte
    I2C_control(eeprom_num_read);   // Read control byte

    eeprom_temp[0] = I2C_read_byte(0);
    eeprom_temp[1] = I2C_read_byte(0);
    eeprom_temp[2] = I2C_read_byte(0);
    eeprom_temp[3] = I2C_read_byte(1); // I2C_last_flag set

    // The fastest (and least wear) method for writing Flash is to perform the
    // write with a 4 byte word. To do this the WPRG bit of the FLASH_CR2
    // register must be set before the 4 bytes are written. This requires a
    // complementary write to the FLASH_NCR2 register. This will allow four
    // bytes to be written in 6ms, rather than 6ms per single byte write. Note
    // that the STM8 hardware design will stall program execution while the
    // Flash write completes, so there is no need for the code to have a wait
    // function or to poll for completion of the write.
    // Enable Word Write Once
    FLASH_CR2 |= FLASH_CR2_WPRG;
    FLASH_NCR2 &= (uint8_t)(~FLASH_NCR2_NWPRG);
    memcpy(flash_ptr, &eeprom_temp, 4);

    eeprom_index += 4;
    flash_ptr += 4;

    // Prevent the IWDG hardware watchdog from firing.
    IWDG_KR = 0xaa;
  }

  // Copy the (flash_update) segment from Off-Board EEPROM to RAM
  // Read addressing sequence: Send Write Control byte, send Byte address,
  // send Read Control Byte
  // Since we are writing to RAM all bytes can be copied without a pause.
  
  // IMPORTANT NOTE FOR FUTURE CODE CHANGES:
  //   The uip_buf is re-purposed as temporary storage for the (flash_update)
  //   segment. This is safe to do because once the eeprom_copy_to_flash()
  //   function begins running no furhter Ethernet traffic can occur, thus
  //   the uip_buf is no longer used for normal runtime functions.
  //
  //   The size of the copy from the (flash_update) segment to RAM must never
  //   exceed the size of the uip_buf. At this writing the (flash_update)
  //   segment is allocated 512 bytes, but the code inside the segment is
  //   about 440 bytes. The size of the uip_buf is about 500 bytes. Size of
  //   the uip_buf is set in the uip.c file using UIP_BUFSIZE defined in
  //   uipopt.h, which in turn is based on ENC28J60_MAXFRAME defined in
  //   enc28j60.h.
  
  eeprom_index = eeprom_base + PROGRAM_SEGMENT_LENGTH;
  ram_ptr = &uip_buf[0];
  
  I2C_control(eeprom_num_write); // Write control byte to establish address
  I2C_byte_address(eeprom_index);
  I2C_control(eeprom_num_read);  // Read control byte
  
  while(eeprom_index < eeprom_base + PROGRAM_SEGMENT_LENGTH + UPDATE_SEGMENT_LENGTH - 1) {
    // Note: The copy size must not exceed the size of uip_buf.
    *ram_ptr = I2C_read_byte(0);
    ram_ptr++;
    eeprom_index++;    
  }
  // One more read to terminate sequential read
  *ram_ptr = I2C_read_byte(1);
  
  // Set pointers for copy_ram_to_flash. Note: initializing these pointers
  // was moved here from the copy_ram_to_flash functions to reduce the size of
  // the copy_ram_to_flash function to get it to fit in 64 bytes (thus taking
  // only 1 block for that function).
  flash_ptr = (char *)FLASH_START_FLASH_UPDATE_SEGMENT;
  ram_ptr = &uip_buf[0];
  copy_ram_to_flash();
}
#endif // OB_EEPROM_SUPPORT == 1

#pragma section ()





#pragma section (memcpy_update)

#if OB_EEPROM_SUPPORT == 1
void copy_ram_to_flash(void)
{
  // This function copies the (flash_update) segment from RAM to Flash. This
  // is done so that the entry and exit points and the RAM usage in the
  // functions match the main runtime code associated with the segment. Later
  // the (memory_update) segment must be copied to Flash. That will happen
  // when the new code boots.
  
  copy_ram_index = 0;
  while (copy_ram_index < (FLASH_START_MEMCPY_UPDATE_SEGMENT - FLASH_START_FLASH_UPDATE_SEGMENT)) {
    // Enable Word Write Once
    FLASH_CR2 |= FLASH_CR2_WPRG;
    FLASH_NCR2 &= (uint8_t)(~FLASH_NCR2_NWPRG);
    memcpy(flash_ptr, ram_ptr, 4);
    ram_ptr += 4;
    flash_ptr += 4;
    copy_ram_index += 4;
  }
  
  // Flash was unlocked before this function was entered. It will re-lock as
  // a result of the reboot that will occur.
  while(1); // Wait here for IDWG to reset the module.
}
#endif // OB_EEPROM_SUPPORT == 1

#pragma section ()




#if I2C_SUPPORT == 1
void I2C_write_byte(uint8_t I2C_write_data)
{
  // Write a single data byte on the I2C bus.  This function is not included
  // in the (flash_update) segment because it is never called again once the
  // eeprom_copy_to_flash() function is called.
  
  // Write Data bit 7 to 0
  I2C_transmit_byte(I2C_write_data);
  
  // Read NACK/ACK from slave
  if (Read_Slave_NACKACK()) I2C_failcode = I2C_FAIL_NACK_WRITE_BYTE;
}


void I2C_reset(void)
{
  // Reset the I2C bus to place it in a known state.
  
  // This function generates an I2C bus reset. This function is not included
  // in the flash_update segment because it is never called again once the
  // eeprom_copy_to_flash function is called.
  
  // The function:
  // Floats SDA high
  // Floats SCL high
  // Generates 10 SCL clocks ending with SCL high
  // Drive SDA low (a start condition)
  // Drive SCL low
  // Float SDA high
  // Float SCL high
  // Drive SCL low
  // Drive SDA low
  // Float SCL high
  // FLoat SDA high (a stop condition)
  // At this point the bus should be reset and operations can continue.
  // The reset can be run at firmware start to make sure prior bus
  // interruptions are cleared.
  
  int i;
  int nop_cnt;

  SDA_high(); // Make sure SDA is high (float)
  SCL_high(); // Make sure SCL is high (float)
  for (i=0; i<10; i++) {
    SCL_low();
    for (nop_cnt=0; nop_cnt<10; nop_cnt++) nop(); // Wait 5us
    SCL_high();
  }
  SDA_low(); // Start condition
  SCL_low();
  SDA_high(); // Single 1 data bit clocked out
  SCL_pulse();
  SDA_low();  // "
  SCL_high();
  SDA_high(); // Stop condition
}

#endif // I2C_SUPPORT == 1

