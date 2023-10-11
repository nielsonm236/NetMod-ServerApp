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

// All includes are in main.h
#include "main.h"


extern uint8_t OctetArray[14];  // Used in emb_itoa conversions and to
                                // transfer short strings globally

uint8_t I2C_failcode;
char * flash_ptr;
char * ram_ptr;
// uint16_t copy_ram_index;
uint8_t eeprom_num_write;
uint8_t eeprom_num_read;
uint16_t eeprom_base;



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

uint8_t I2C_control(uint8_t control_byte)
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
  SDA_high(); // Make sure SDA is high, then wait 5us
  SCL_high(); // Make sure SCL is high, then wait 5us
  SDA_low(); // Drive SDA low, then wait 5us
  SCL_low(); // Drive SCL low, SCL_low() has no wait

  // Output Device Control Byte. Bits 7 to 1 are address information, bit 0 is
  // the Read/Write bit
  I2C_transmit_byte(control_byte);
  
  // Read NACK/ACK from slave
  I2C_failcode = 0;
  if (Read_Slave_NACKACK()) I2C_failcode = I2C_FAIL_NACK_CONTROL_BYTE;
  
  return I2C_failcode;
}


void I2C_byte_address(uint16_t byte_address, uint8_t addr_size)
{
  // Send address to the I2C device where a byte read or write is to occur.
  // The address can be 1 or 2 bytes as defined by addr_size.
  //
  // I2C EEPROM:
  // Send address to the I2C EEPROM where a byte read or write is to
  // occur, or a sequential read/write stream is to occur. For the I2C
  // EEPROM addr_size is always 2.
  //
  // BME280:
  // addr_size is always 1.

  if (addr_size == 2) {
    // Output Byte Address bit 15 to 8
    I2C_transmit_byte((uint8_t)(byte_address >> 8));
  
    // Read NACK/ACK from slave
    if (Read_Slave_NACKACK()) I2C_failcode = I2C_FAIL_NACK_BYTE_ADDRESS1;
  }
  
  // Output Byte Address bit 7 to 0
  I2C_transmit_byte((uint8_t)(byte_address));
  
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
    SDA_high(); // Float SDA high, then wait 5us.
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
  // NOTE: AT THE END OF THE LAST SCL_PULSE (WHEN SCL GOES LOW) THE SLAVE
  // MAY START TRANSMITTING ITS NACK/ACK. BUT THE MASTER MIGHT STILL BE
  // DRIVING THE SDA LINE ... SHOULD SDA BE RELEASED IN THIS ROUTINE
  // IMMEDIATELY AT THE END OF SCL_PULSE? NOT SURE IT MATTERS, AS
  // IMMEDIATELY AFTER I2C_TRANSMIT_BYTE WE CALL READ_SLAVE_NACKACK WHICH
  // IMMEDIATELY RELEASES SDA. BUT TIMING COULD BE IMPROVED BY RELEASING
  // SDA IN THIS ROUTINE WHEN DATA_MASK == 0.
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
  SDA_low();  // Drive SDA low, then wait 5usdfu
  SCL_high(); // Float SCL high, then wait 5us
  SDA_high(); // Fload SDA high, then wait 5us
}

#endif // I2C_SUPPORT == 1



#if OB_EEPROM_SUPPORT == 1
void eeprom_copy_to_flash(void)
{
  uint16_t eeprom_index;
  uint16_t blocks;

#if DEBUG_SUPPORT == 15
// UARTPrintf("eeprom_copy_to_flash\r\n");
#endif // DEBUG_SUPPORT == 15

  // This function will copy a Flash image from the I2C EEPROM to the
  // STM8 Flash.
  //
  // The following variables must be global and must be set prior to calling
  // this function:
  //   *flash_ptr
  //   eeprom_base
  //
  // In this application there are four image locations in the I2C
  // EEPROM:
  //   1) I2C EEPROM Region 0 (EEPROM0) of the I2C EEPROM contains an image
  //      of new Runtime code.
  //   2) I2C EEPROM Region 1 (EEPROM1) of the I2C EEPROM contans an image
  //      of the Code Uploader. The Code Uploader provides a GUI to allow the
  //      user to specify the file location of a new Runtime image.
  //   3) I2C EEPROM Region 2 (EEPROM2) of the I2C EEPROM contains an image
  //      of the large strings used for html population of the GUI.
  //   4) I2C EEPROM Region 3 (EEPROM3) - not currently used.
  //
  // Copying data from the I2C EEPROM to Flash needs to be done using 128
  // byte block programming.
  //
  // If we were to copy the entire I2C EEPROM to Flash the copy would be
  // 32768 bytes. 128 at a time would be 256 cycles. Each cycle takes about
  // 12ms for the I2C writes to the Flash plus a 6ms wait cycle for the
  // Flash internal program cycle. The time to complete the entire copy is
  // about 256 x (12ms + 6ms) = 4.6 sec.
  //
  // I have to assume that the Stack is still functional when this code runs,
  // as it needs to call the I2C functions contained in this segment and the
  // functions need to utilize locally declared variables. Initial testing
  // shows this to be true.
  //
  // IMPORTANT IMPORTANT IMPORTANT IMPORTANT IMPORTANT IMPORTANT IMPORTANT
  // Changes to the functions contained in the flash_update segment need to be
  // made VERY carfully. The functions have been packed into as few bytes as
  // possible, and must fit into Flash on 128 byte boundaries (start and end).
  // In this application a maximum of 512 bytes can be used for the
  // flash_update segment.
  // Changes to the memcpy_update segment also need to be made very carefully
  // as that segment gets copied to RAM - a resource that is always in short
  // supply. The memcpy_update segment is currently about 40 bytes.
  //
  // In these functions the uip_buf is repurposed as the buffer to enable
  // copies from I2C EEPROM to Flash. Because the I2C IO functions are
  // needed to perform reads from I2C EEPROM the I2C EEPROM content is first
  // copied to RAM then copied to Flash. And because we can't overwrite the
  // I2C functions in Flash until we are done using them, the final copy from
  // I2C EEPROM to RAM to Flash must contain the entire flash_update
  // segment and must fit safely in RAM. Since we must always copy 128 byte
  // blocks the flash_update segment copy requires 4 blocks, or 512 bytes,
  // which may be larger than the size of the uip_buf. So, the data may
  // over-run the end of the uip_buf RAM space. This will still work because
  // of the following:
  // a) The .lkf file is set up to place the memcpy_update code at the start
  //    of RAM. This is required for the next item to work. See the main.h
  //    file for proper settings in the .lkf file.
  // b) The Cosmic compiler/linker always places the largest RAM item at the
  //    end of RAM ... and that turns out to be the uip_buf. This is why step
  //    (a) is critical: the memcpy_update code must not be placed in RAM
  //    after the uip_buf. Likewise, no other variables used in the copy
  //    processes can appear in RAM after uip_buf as they may be over-written
  //    when the copy processes run.
  // So, with (a) and (b) established, writes to the uip_buf can over-run the
  // end of RAM and can encroach on the Stack space without causing harm to
  // operation of the copy routines. And since the copy routines are the last
  // thing to run before a reboot occurs we don't have to worry about inter-
  // ferring with operation of other runtime code.
  //
  // If RAM allocated to the uip_buf is larger than 512 bytes the above issues
  // are not a concern.
  
  ram_ptr = &uip_buf[0]; // Set ram_ptr to the start of the uip_buf
  eeprom_index = eeprom_base;
			      
  // The Flash must be unlocked to allow any writes to it. The unlock occurs
  // by the routine that calls this function. Note that when Flash is written
  // the STM8 hardware will stall code execution until the write completes.
  // This typically takes 6ms per write.
  
  // Memory map in 128 byte blocks:
  //  Blocks 0 to 248 (249 blocks) are the main program memory.
  //  Blocks 249 to 252 (4 blocks) are "pragma section (flash_update)".
  //  Blocks 253-255 (3 blocks) are reserved for user data storage and are
  //    only written when the user makes GUI input changes.
  
  blocks = 0;
  while (blocks < 249 ) {
    // In this application the main code area is always 249 blocks of 128
    // bytes per block. Copy that first.
    // Note: This routine is only run to replace the code in Flash.
    
    ram_ptr = &uip_buf[0]; // Set ram_ptr to the start of the uip_buf
    // Enable sequential read from the I2C  EEPROM.
    // Read addressing sequence: Send Write Control byte, send Byte address,
    // send Read Control Byte
    I2C_control(eeprom_num_write);     // Write control byte to establish address
    I2C_byte_address(eeprom_index, 2); // Byte address of first byte
    I2C_control(eeprom_num_read);      // Read control byte
    
    // Copy 128 bytes from I2C EEPROM to RAM
    {
      uint8_t i;
      for (i=0; i<127; i++) {
        *ram_ptr = I2C_read_byte(0);
	ram_ptr++;
      }
    }
    *ram_ptr = I2C_read_byte(1); // Final read with I2C_last_flag set

    // Copy data from RAM to Flash
    ram_ptr = &uip_buf[0]; // Reset the ram_ptr to the start of the uip_buf
    copy_ram_to_flash(); // As part of the copy the flash_ptr will be
                         // incremented to the start of the next 64 byte
                         // block.
    eeprom_index += 128; // Increment the eeprom_index to the start of the
                         // next block.
    blocks++;
    
    // Prevent the IWDG hardware watchdog from firing.
    IWDG_KR = 0xaa;
  }
  
  // We are copying contiguous 128 byte blocks. There are no gaps between the
  // blocks. So, the eeprom_index should already be correct, the flash_ptr
  // should already be correct, and eeprom_num_write and eeprom_num_read
  // remain the same.  So we just need to copy 4 blocks to RAM then copy those
  // to Flash. A note is that this will cause a small overwrite into the Stack
  // area ... which shouldn't hurt anything since this is the last step before
  // reboot.
  
  // Copy the flash_update segment to Flash.
  // This copy is performed separately from the main code copy because the I2C
  // functions are contained in the flash_update segment, and we need to stop
  // using those functions at the time they are over-written in Flash. So, in
  // this final step we use the I2C functions to copy the entire flash_update
  // segment to RAM, then the memcpy_update function runs in RAM to write the
  // segment from RAM to Flash. Then, we just wait for an IDWG to reboot the
  // STM8.
  ram_ptr = &uip_buf[0]; // Set ram_ptr to the start of the uip_buf
  
  // Enable sequential read from the I2C EEPROM.
  // Read addressing sequence: Send Write Control byte, send Byte address,
  // send Read Control Byte
  I2C_control(eeprom_num_write);     // Write control byte to establish address
  I2C_byte_address(eeprom_index, 2); // Byte address of first byte
  I2C_control(eeprom_num_read);      // Read control byte
  
  {
    uint16_t j;
    // In this application the flash_update segment is always 4 blocks (512
    // bytes).
    //
    // First the segment is copied to RAM. This will occupy four 128 byte
    // blocks. The blocks are copied to RAM, then copy_ram_to_flash() is
    // called to copy the data from RAM to Flash. Note that the copy to RAM
    // may exceed the size allocated to the uip_buf. This is OK as the uip_buf
    // RAM area (and beyond) is no longer being used by regular runtime code
    // ... and it is also OK if the RAM usage extends into the Stack area as
    // very little Stack is being used when this code is running.
      
    for (j = 0; j < 511; j++) {
      *ram_ptr = I2C_read_byte(0);
      ram_ptr++;
      eeprom_index++;
    }
    *ram_ptr = I2C_read_byte(1); // Final read with I2C_last_flag set
  }


  // Prevent the IWDG hardware watchdog from firing.
  IWDG_KR = 0xaa;
  
  // Copy 512 bytes of data from RAM to Flash
  ram_ptr = &uip_buf[0]; // Set ram_ptr to the start of the uip_buf
  copy_ram_to_flash(); // Each call to copy_ram_to_flash updates the pointers
  copy_ram_to_flash(); // so the next call writes the next contiguous 128 byte
  copy_ram_to_flash(); // block.
  copy_ram_to_flash(); //
  
  // Lock the Flash
  FLASH_IAPSR &= (uint8_t)(~0x02);

#if DEBUG_SUPPORT == 15
// UARTPrintf("Reboot after Copy RAM to Flash\r\n");
#endif // DEBUG_SUPPORT == 15

  // Set the Window Watchdog to reboot the module
  // WWDG is used here instead of the IWDG so that the cause of a reset can be
  // differentiated. WWDG is used for a deliberate reset. IWDG is used to
  // protect agains unintentional code or processor upsets.
  WWDG_WR = (uint8_t)0x7f;     // Window register reset
  WWDG_CR = (uint8_t)0xff;     // Set watchdog to timeout in 49ms
  WWDG_WR = (uint8_t)0x60;     // Window register value - doesn't matter
                               // much as we plan to reset
  // Wait here for WWDG to reset the module.
  while(1);

}
#endif // OB_EEPROM_SUPPORT == 1

#pragma section ()



#pragma section (memcpy_update)

#if OB_EEPROM_SUPPORT == 1
void copy_ram_to_flash(void)
{
  // This function copies 128 byte blocks of data from RAM to Flash as part of
  // the Flash update process.

  uint8_t i;
  
  // Note: This function is only run to copy code to Flash in 128 byte blocks.
  // The segment is relocatable and must be run from RAM as a requirement of
  // the STM8 hardware. The _fctcpy function is used to copy this segment to
  // RAM in a way that allows the function to be called from code running in
  // Flash. So, when updating Flash the first thing that happens is this
  // is copied to RAM, then Flash code updates start.
    
  // The following must be defined in global memory before calling the
  // function:
  //  char *flash_ptr
  //  char *ram_ptr

  // Enable Flash Block Programming
  // The fastest (and least wear) method for writing Flash is to perform
  // 128 byte block writes. To do this the PRG bit of the FLASH_CR2 register
  // must be set before the 128 bytes are written. This requires a complement-
  // ary write to the FLASH_NCR2 register. This will allow 128 bytes to be
  // written in 6ms. Note that the STM8 hardware design will stall program
  // execution while the Flash write completes, so there is no need for the
  // code to have a wait function or to poll for completion of the write.
  FLASH_CR2 |= FLASH_CR2_PRG;
  FLASH_NCR2 &= (uint8_t)(~FLASH_NCR2_NPRG);

  // Copy 128 bytes from RAM to Flash
  for (i=0; i<128; i++) {
    *flash_ptr = *ram_ptr;
    flash_ptr++;
    ram_ptr++;
  }
}
#endif // OB_EEPROM_SUPPORT == 1

#pragma section ()




#if I2C_SUPPORT == 1
void I2C_write_byte(uint8_t I2C_write_data)
{
  // Write a single data byte on the I2C bus.  This function is not included
  // in the flash_update segment because it is never called again once the
  // eeprom_copy_to_flash() function is called. This helps make the flash
  // update segment smaller.
  
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

