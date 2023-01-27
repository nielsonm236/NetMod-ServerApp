/*
 * File containing functions and defines needed by the Enc28j60
 * code-module to function properly
 * 
 * Author: Simon Kueppers
 * Email: simon.kueppers@web.de
 * Homepage: http://klinkerstein.m-faq.de
 * 
 This program is free software: you can redistribute it and/or modify
 it under the terms of the GNU General Public License as published by
 the Free Software Foundation, either version 3 of the License, or
 (at your option) any later version.

 This program is distributed in the hope that it will be useful,
 but WITHOUT ANY WARRANTY; without even the implied warranty of
 MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 GNU General Public License for more details.

 You should have received a copy of the GNU General Public License
 along with this program.  If not, see <http://www.gnu.org/licenses/>.
 
 Copyright 2008 Simon Kueppers
 *
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
#include "main.h"
// #include "Enc28j60.h"
// #include "iostm8s005.h"
// #include "stm8s-005.h"
// #include "uipopt.h"
// #include "timer.h"
// #include "uart.h"

#if DEBUG_SUPPORT != 0
// Variables used to store debug information
extern uint8_t debug[10];
#endif // DEBUG_SUPPORT

extern uint8_t RXERIF_counter;         // Counts RXERIF errors
extern uint8_t TXERIF_counter;         // Counts TXERIF errors
extern uint32_t TRANSMIT_counter;      // Counts any transmit
extern uint8_t stored_config_settings; // Config settings stored in EEPROM
extern uint8_t OctetArray[14];         // Used in emb_itoa conversions and to
                                       // transfer short strings globally


// SPI Opcodes
#define OPCODE_RCR			0x00	// Read Control Register
#define OPCODE_RBM			0x3A	// Read Buffer Memory
#define OPCODE_WCR			0x40	// Write Control Register
#define OPCODE_WBM			0x7A	// Write Buffer Memory
#define OPCODE_BFS			0x80	// Bit Field Set
#define OPCODE_BFC			0xA0	// Bit Field Clear
#define OPCODE_SRC			0xFF	// System Reset Command (Soft Reset)

// Banks
#define BANK0				0
#define BANK1				1
#define BANK2				2
#define BANK3				3

// Register Adresses
// Bits 0-4 are the register address (REGISTER_MASK)
// Bit 7 identifies whether the register is a MAC/MII register or
// an ETH register because MAC and MII registers need a dummy byte
// while reading them (REGISTER_NEEDDUMMY)
#define REGISTER_MASK			0x1F
#define REGISTER_NEEDDUMMY		0x80

// Registers in BankX: (means: available in each bank)
#define BANKX_EIE			0x1B
#define BANKX_EIR			0x1C
#define BANKX_EIR_RXERIF		0
#define BANKX_EIR_TXERIF		1
#define BANKX_EIR_TXIF			3
#define BANKX_ESTAT			0x1D
#define BANKX_ESTAT_CLKRDY		0
#define BANKX_ESTAT_TXABRT		1
#define BANKX_ESTAT_RXBUSY		2
#define BANKX_ESTAT_LATECOL		4
#define BANKX_ESTAT_BUFER		6
#define BANKX_ESTAT_INT			7
#define BANKX_ECON2			0x1E
#define BANKX_ECON2_VRPS		3
#define BANKX_ECON2_PWRSV		5
#define BANKX_ECON2_PKTDEC		6
#define BANKX_ECON2_AUTOINC		7
#define BANKX_ECON1			0x1F
#define BANKX_ECON1_BSEL0		0
#define BANKX_ECON1_BSEL1		1
#define BANKX_ECON1_RXEN		2
#define BANKX_ECON1_TXRTS		3
#define BANKX_ECON1_CSUMEN		4
#define BANKX_ECON1_DMAST		5
#define BANKX_ECON1_RXRST		6
#define BANKX_ECON1_TXRST		7

// Registers in Bank0:
#define BANK0_ERDPTL			(0x00)
#define BANK0_ERDPTH			(0x01)
#define BANK0_EWRPTL			(0x02)
#define BANK0_EWRPTH			(0x03)
#define BANK0_ETXSTL			(0x04)
#define BANK0_ETXSTH			(0x05)
#define BANK0_ETXNDL			(0x06)
#define BANK0_ETXNDH			(0x07)
#define BANK0_ERXSTL			(0x08)
#define BANK0_ERXSTH			(0x09)
#define BANK0_ERXNDL			(0x0A)
#define BANK0_ERXNDH			(0x0B)
#define BANK0_ERXRDPTL			(0x0C)
#define BANK0_ERXRDPTH			(0x0D)
#define BANK0_ERXWRPTL			(0x0E)
#define BANK0_ERXWRPTH			(0x0F)
#define BANK0_EDMASTL			(0x10)
#define BANK0_EDMASTH			(0x11)
#define BANK0_EDMANDL			(0x12)
#define BANK0_EDMANDH			(0x13)
#define BANK0_EDMADSTL			(0x14)
#define BANK0_EDMADSTH			(0x15)
#define BANK0_EDMACSL			(0x16)
#define BANK0_EDMACSH			(0x17)

// Registers in Bank1:
#define BANK1_EHT0			(0x00)
#define BANK1_EHT1			(0x01)
#define BANK1_EHT2			(0x02)
#define BANK1_EHT3			(0x03)
#define BANK1_EHT4			(0x04)
#define BANK1_EHT5			(0x05)
#define BANK1_EHT6			(0x06)
#define BANK1_EHT7			(0x07)
#define BANK1_EPMM0			(0x08)
#define BANK1_EPMM1			(0x09)
#define BANK1_EPMM2			(0x0A)
#define BANK1_EPMM3			(0x0B)
#define BANK1_EPMM4			(0x0C)
#define BANK1_EPMM5			(0x0D)
#define BANK1_EPMM6			(0x0E)
#define BANK1_EPMM7			(0x0F)
#define BANK1_EPMCSL			(0x10)
#define BANK1_EPMCSH			(0x11)
#define BANK1_EPMOL			(0x14)
#define BANK1_EPMOH			(0x15)
#define BANK1_ERXFCON			(0x18)
#define BANK1_EPKTCNT			(0x19)

// Registers in Bank2:
#define BANK2_MACON1			(0x00|REGISTER_NEEDDUMMY)
#define BANK2_MACON1_MARXEN		0
#define BANK2_MACON1_PASSALL		1
#define BANK2_MACON1_RXPAUS		2
#define BANK2_MACON1_TXPAUS		3

#define BANK2_MACON3			(0x02|REGISTER_NEEDDUMMY)
#define BANK2_MACON3_FULDPX		0
#define BANK2_MACON3_FRMLNEN		1
#define BANK2_MACON3_HFRMEN		2
#define BANK2_MACON3_PHDREN		3
#define BANK2_MACON3_TXCRCEN		4
#define BANK2_MACON3_PADCFG0		5
#define BANK2_MACON3_PADCFG1		6
#define BANK2_MACON3_PADCFG2		7

#define BANK2_MACON4			(0x03|REGISTER_NEEDDUMMY)
#define BANK2_MACON4_NOBKOFF		4
#define BANK2_MACON4_BPEN		5
#define BANK2_MACON4_DEFER		6
#define BANK2_MABBIPG			(0x04|REGISTER_NEEDDUMMY)
#define BANK2_MAIPGL			(0x06|REGISTER_NEEDDUMMY)
#define BANK2_MAIPGH			(0x07|REGISTER_NEEDDUMMY)
#define BANK2_MACLCON1			(0x08|REGISTER_NEEDDUMMY)
#define BANK2_MACLCON2			(0x09|REGISTER_NEEDDUMMY)
#define BANK2_MAMXFLL			(0x0A|REGISTER_NEEDDUMMY)
#define BANK2_MAMXFLH			(0x10|REGISTER_NEEDDUMMY)
#define BANK2_MICMD			(0x12|REGISTER_NEEDDUMMY)
#define BANK2_MICMD_MIIRD		0
#define BANK2_MICMD_MIISCAN		1
#define BANK2_MIREGADR			(0x14|REGISTER_NEEDDUMMY)
#define BANK2_MIWRL			(0x16|REGISTER_NEEDDUMMY)
#define BANK2_MIWRH			(0x17|REGISTER_NEEDDUMMY)
#define BANK2_MIRDL			(0x18|REGISTER_NEEDDUMMY)
#define BANK2_MIRDH			(0x19|REGISTER_NEEDDUMMY)

// Registers in Bank3:
#define BANK3_MAADR1			(0x00|REGISTER_NEEDDUMMY)
#define BANK3_MAADR0			(0x01|REGISTER_NEEDDUMMY) // MAC LSB
#define BANK3_MAADR3			(0x02|REGISTER_NEEDDUMMY)
#define BANK3_MAADR2			(0x03|REGISTER_NEEDDUMMY)
#define BANK3_MAADR5			(0x04|REGISTER_NEEDDUMMY) // MAC MSB
#define BANK3_MAADR4			(0x05|REGISTER_NEEDDUMMY)
#define BANK3_EBSTSD			(0x06)
#define BANK3_EBSTCON			(0x07)
#define BANK3_EBSTCSL			(0x08)
#define BANK3_EBSTCSH			(0x09)
#define BANK3_MISTAT			(0x0A|REGISTER_NEEDDUMMY)
#define BANK3_MISTAT_BUSY		0
#define BANK3_MISTAT_SCAN		1
#define BANK3_MISTAT_NVALID		2
#define BANK3_EREVID			(0x12)
#define BANK3_ECOCON			(0x15)
#define BANK3_EFLOCON			(0x17)
#define BANK3_EPAUSL			(0x18)
#define BANK3_EPAUSH			(0x19)

// PHY Registers
#define PHY_PHCON1			0x00
#define PHY_PHCON1_PDPXMD		8
#define PHY_PHCON1_PPWRSV		11
#define PHY_PHCON1_PLOOPBK		14
#define PHY_PHCON1_PRST			15
#define PHY_PHSTAT1			0x01
#define PHY_PHID1			0x02
#define PHY_PHID2			0x03
#define PHY_PHCON2			0x10
#define PHY_PHCON2_HDLDIS		8
#define PHY_PHCON2_JABBER		10
#define PHY_PHCON2_TXDIS		13
#define PHY_PHCON2_FRCLINK		14
#define PHY_PHSTAT2			0x11
#define PHY_PHIE			0x12
#define PHY_PHIR			0x13
#define PHY_PHLCON			0x14
#define PHY_PHLCON_STRCH		1
#define PHY_PHLCON_LFRQ0		2
#define PHY_PHLCON_LFRQ1		3
#define PHY_PHLCON_LBCFG0		4
#define PHY_PHLCON_LBCFG1		5
#define PHY_PHLCON_LBCFG2		6
#define PHY_PHLCON_LBCFG3		7
#define PHY_PHLCON_LACFG0		8
#define PHY_PHLCON_LACFG1		9
#define PHY_PHLCON_LACFG2		10
#define PHY_PHLCON_LACFG3		11

// Useful macros
// #define NOP()			asm volatile ("nop")
// #define SELECT()		do { PC_ODR &= (uint8_t)(~0x02); nop(); } while(0) // -CS low
// #define DESELECT()		do { PC_ODR |= (uint8_t)0x02; nop(); } while(0) // -CS high

// MAC address ordered as defined in UIP modules ([0] is LSB, [5] is MSB)
extern uint8_t stored_uip_ethaddr_oct[6];

// Transmit Status Vector storage
// uint8_t tsv_byte[7];


void select(void)
{
  // -CS low
  PC_ODR &= (uint8_t)(~0x02);
  nop();
}


void deselect(void)
{
  // -CS high
  PC_ODR |= (uint8_t)0x02;
  nop();
}


// Reads the content of an Enc28j60 register
// ENC28J60_INLINE
uint8_t Enc28j60ReadReg(uint8_t nRegister)
{
  uint8_t nByte;

  select();
	
  SpiWriteByte((uint8_t)(OPCODE_RCR | (nRegister & REGISTER_MASK)));
  if (nRegister & REGISTER_NEEDDUMMY) SpiWriteByte(0);
  nByte = SpiReadByte();

  deselect();

  return nByte;
}


// Writes to an Enc28j60 register
// ENC28J60_INLINE
void Enc28j60WriteReg( uint8_t nRegister, uint8_t nData)
{
  select();

  SpiWriteByte((uint8_t)(OPCODE_WCR | (nRegister & REGISTER_MASK)));
  SpiWriteByte(nData);

  deselect();
}


// Sets bits within an Enc28j60 register
// ENC28J60_INLINE
void Enc28j60SetMaskReg(uint8_t nRegister, uint8_t nMask)
{
  select();

  SpiWriteByte((uint8_t)(OPCODE_BFS | (nRegister & REGISTER_MASK)));
  SpiWriteByte(nMask);

  deselect();
}


// Clears bits within an Enc28j60 register
// ENC28J60_INLINE
void Enc28j60ClearMaskReg( uint8_t nRegister, uint8_t nMask)
{
  select();

  SpiWriteByte((uint8_t)(OPCODE_BFC | (nRegister & REGISTER_MASK)));
  SpiWriteByte(nMask);

  deselect();
}


// Switches the currently selected bank
// ENC28J60_INLINE
void Enc28j60SwitchBank(uint8_t nBank)
{
  // Use built-in Bit-Set/Bit-Clear functions only while switching bank!
  // This is important since a read-modify-write cycle could alter unwanted
  // bits that got set or reset between read and write
  Enc28j60ClearMaskReg(BANKX_ECON1, (3<<BANKX_ECON1_BSEL0));
  Enc28j60SetMaskReg(BANKX_ECON1, (uint8_t)(nBank << BANKX_ECON1_BSEL0));
}


// Reads a PHY register
// NOTE: This function changes the currently selected bank
// ENC28J60_INLINE
uint16_t Enc28j60ReadPhy(uint8_t nRegister)
{
  Enc28j60SwitchBank(BANK2);
  Enc28j60WriteReg(BANK2_MIREGADR, nRegister);
  Enc28j60SetMaskReg(BANK2_MICMD, (1<<BANK2_MICMD_MIIRD));
  Enc28j60SwitchBank(BANK3);
  while (Enc28j60ReadReg(BANK3_MISTAT) & (1 <<BANK3_MISTAT_BUSY)) nop();
  Enc28j60SwitchBank(BANK2);
  Enc28j60ClearMaskReg(BANK2_MICMD, (1<<BANK2_MICMD_MIIRD));

  return ((uint16_t) Enc28j60ReadReg(BANK2_MIRDL) << 0)
       | ((uint16_t) Enc28j60ReadReg(BANK2_MIRDH) << 8);
}


// Writes a PHY register
// NOTE: This function changes the currently selected bank
// ENC28J60_INLINE
void Enc28j60WritePhy( uint8_t nRegister, uint16_t nData)
{
  Enc28j60SwitchBank(BANK2);
  Enc28j60WriteReg(BANK2_MIREGADR, nRegister);
  Enc28j60WriteReg(BANK2_MIWRL, (uint8_t)(nData >> 0));
  Enc28j60WriteReg(BANK2_MIWRH, (uint8_t)(nData >> 8));
  Enc28j60SwitchBank(BANK3);
  while (Enc28j60ReadReg(BANK3_MISTAT) & (1 <<BANK3_MISTAT_BUSY)) nop();
}


void Enc28j60Init(void)
{
  // It is assumed that the gpio_init set up the pins used for SPI bit
  // bang and that the spi_init released the Reset- pin.

  deselect(); // Just makes sure the -CS is not selected

  // Wait for the Oscillation Startup Timer. From the spec sheet:
  // The ENC28J60 contains an Oscillator Start-up Timer (OST) to ensure that
  // the oscillator and integrated PHY have stabilized before use. The OST 
  // does not expire until 7500 OSC1 clock cycles (300 µs) pass after 
  // Power-on Reset or wake-up from Power-Down mode occurs. During the delay,
  // all Ethernet registers and buffer memory may still be read and written 
  // via the SPI bus. However, software should not attempt to transmit
  // any packets (set ECON1.TXRTS), enable reception of packets 
  // (set ECON1.RXEN) or access any MAC, MII or PHY registers during this
  // period. When the OST expires, the CLKRDY bit in the ESTAT register will 
  // be set. The application software should poll this bit as necessary to 
  // determine when normal device operation can begin.
  while (!(Enc28j60ReadReg(BANKX_ESTAT) & (1<<BANKX_ESTAT_CLKRDY))) nop();

  // Reset ENC28J60 system
  select();
  SpiWriteByte(OPCODE_SRC); // Reset command
  deselect();
  
  // Errata: After sending an SPI Reset command, the PHY clock is stopped
  // but the ESTAT.CLKRDY bit is not cleared. Therefore, polling the CLKRDY
  // bit will not work to detect if the PHY is ready. Additionally, the
  // hardware start-up time of 300us may expire before the device is ready
  // to operate. Work around: After issuing the Reset command, wait at
  // least 1 ms in firmware for the device to be ready.
  wait_timer((uint16_t)10000); // delay 10 ms

  // Reset ENC28J60 PHY
  Enc28j60WritePhy(PHY_PHCON1, (uint16_t)(1<<PHY_PHCON1_PRST)); // Reset command
  // Wait for PHY reset completion
  while (Enc28j60ReadPhy(PHY_PHCON1) & (uint16_t)(1<<PHY_PHCON1_PRST)) nop();
  
  //---------------------------------------------------------------------------//
  // Do PHY initializations
  if (stored_config_settings & 0x01) {
    // Full duplex
    // Set the PHCON1.PDPXMD bit to 1 to over-ride any LED driven configuration.
    Enc28j60WritePhy(PHY_PHCON1, (uint16_t)(1<<PHY_PHCON1_PDPXMD));
  }  
    
  //---------------------------------------------------------------------------//
  // Do bank 0 initializations
  Enc28j60SwitchBank(BANK0);

  // Initialize Receive Buffer
  // Errata: See .h file for errata applied
  Enc28j60WriteReg(BANK0_ERXSTL, (uint8_t) (ENC28J60_RXSTART >> 0));
  Enc28j60WriteReg(BANK0_ERXSTH, (uint8_t) (ENC28J60_RXSTART >> 8));
  Enc28j60WriteReg(BANK0_ERXNDL, (uint8_t) (ENC28J60_RXEND >> 0));
  Enc28j60WriteReg(BANK0_ERXNDH, (uint8_t) (ENC28J60_RXEND >> 8));
  // Receiver Pointer
  Enc28j60WriteReg(BANK0_ERDPTL, (uint8_t) (ENC28J60_RXSTART >> 0));
  Enc28j60WriteReg(BANK0_ERDPTH, (uint8_t) (ENC28J60_RXSTART >> 8));
  // Errata Workaround: ERXRDPT should not be programmed with an even address
  // so we choose RXSTART-1 which is equal to RXEND 
  Enc28j60WriteReg(BANK0_ERXRDPTL, (uint8_t) (ENC28J60_RXEND >> 0));
  Enc28j60WriteReg(BANK0_ERXRDPTH, (uint8_t) (ENC28J60_RXEND >> 8));
  // and Transmit Pointer
  Enc28j60WriteReg(BANK0_ETXSTL, (uint8_t) (ENC28J60_TXSTART >> 0));
  Enc28j60WriteReg(BANK0_ETXSTH, (uint8_t) (ENC28J60_TXSTART >> 8));


  //---------------------------------------------------------------------------//
  // Bank 1 initializations
  Enc28j60SwitchBank(BANK1);

  // Packet Filter
  // From the spec:
  // Filter default = 0xa1 0b10100001
  //   bit 7 UCEN: Unicast Filter Enable bit
  //     When ANDOR = 1:
  //       1 = Packets not having a destination address matching
  //           the local MAC address will be discarded
  //       0 = Filter disabled
  //     When ANDOR = 0:
  // >>    1 = Packets with a destination address matching the
  //           local MAC address will be accepted
  //       0 = Filter disabled
  //
  //   bit 6 ANDOR: AND/OR Filter Select bit
  //       1 = AND: Packets will be rejected unless all enabled
  //         filters accept the packet
  // >>    0 = OR: Packets will be accepted unless all enabled
  //         filters reject the packet
  //
  //   bit 5 CRCEN: Post-Filter CRC Check Enable bit
  // >>    1 = All packets with an invalid CRC will be discarded
  //       0 = The CRC validity will be ignored
  //
  //   bit 4 PMEN: Pattern Match Filter Enable bit
  // >>  0 = Filter disabled
  //
  //   bit 3 MPEN: Magic Packet Filter Enable bit
  // >>  0 = Filter disabled
  //
  //   bit 2 HTEN: Hash Table Filter Enable bit
  // >>  0 = Filter disabled
  //
  //   bit 1 MCEN: Multicast Filter Enable bit
  // >>  0 = Filter disabled
  //
  //   bit 0 BCEN: Broadcast Filter Enable bit
  //     When ANDOR = 1:
  //       1 = Packets must have a destination address of 
  //           FF-FF-FF-FF-FF-FF or they will be discarded
  //       0 = Filter disabled
  //     When ANDOR = 0:
  // >>    1 = Packets which have a destination address of
  //           FF-FF-FF-FF-FF-FF will be accepted
  //       0 = Filter disabled
  //
  Enc28j60WriteReg(BANK1_ERXFCON, (uint8_t)0xa1);    // Allows packets if MAC matches
						     // CRC check ON
						     // FF-FF Packets accepted
  // Enc28j60WriteReg(BANK1_ERXFCON, (uint8_t)0xa0);   // Allows packets if MAC matches
						     // CRC check ON
						     // FF-FF Packets rejected
  // Enc28j60WriteReg(BANK1_ERXFCON, (uint8_t)0x21);    // Allows packets even if MAC doesn't match
						     // CRC check ON
						     // FF-FF Packets accepted
  // Enc28j60WriteReg(BANK1_ERXFCON, (uint8_t)0x20);    // Allows packets even if MAC doesn't match
						     // CRC check ON
						     // FF-FF Packets rejected
  // Enc28j60WriteReg(BANK1_ERXFCON, (uint8_t)0x00);    // Allows packets even if MAC doesn't match
						     // CRC check OFF
						     // FF-FF Packets rejected


  //---------------------------------------------------------------------------//
  // Bank 2 initializations
  Enc28j60SwitchBank(BANK2);

  // MAC RX Enable
  Enc28j60WriteReg(BANK2_MACON1, (1<<BANK2_MACON1_MARXEN));
  
  // if (stored_config_settings & 0x01) {
  //   Full duplex: Set MACON1.TXPAUS and MACON1.RXPAUS to allow flow control.
  //   Note: This does not appear to be needed, at least with Cisco switches. More
  //   code would be needed to handle receive over-runs.
  //   Enc28j60WriteReg(BANK2_MACON1, (1<<BANK2_MACON1_TXPAUS) | (1<<BANK2_MACON1_RXPAUS));
  // }

  // Append CRC, Padding bytes and check length-consistency of frames
  // From the spec:
  // PADCFG2-0 = 001 = All short frames will be zero padded to 60 bytes and a valid
  //   CRC will then be appended
  // TXCRCEN = 1 = MAC will apend a valid CRC to all frames transmitted regardless
  //   of PADCFG.
  // FRMLNEN = 1 = The type/length field of transmitted and received frames will be
  //   checked. If it represents a length, the frame size will be compared and
  //   mismatches will be reported in the transmit/receive status vector.
  // PHDRLEN = 0 = No proprietary header is present. The CRC will cover all data
  //   (normal operation).
  // HFRMEN = 0 = Frames bigger than MAMXFL will be aborted when transmitted or
  //   received
  // FULDPX = 0 = MAC will operate in half-duplex. PHCON1.PDPXMD must also be clear.
  if (stored_config_settings & 0x01) {
    // Full duplex
    // Set BANK2 MACON3.PADCFG, MACON3.TXCRCEN, MACON3.FRMLNEN and MACON3.FULDPX
    Enc28j60SetMaskReg(BANK2_MACON3, (1<<BANK2_MACON3_TXCRCEN) | (1<<BANK2_MACON3_PADCFG0) | (1<<BANK2_MACON3_FRMLNEN) | (1<<BANK2_MACON3_FULDPX));
  }
  else {
    // Half duplex
    Enc28j60SetMaskReg(BANK2_MACON3, (1<<BANK2_MACON3_TXCRCEN)|(1<<BANK2_MACON3_PADCFG0)|(1<<BANK2_MACON3_FRMLNEN));
  }

  // "For IEEE802.3 compliance"
  Enc28j60SetMaskReg(BANK2_MACON4, (1<<BANK2_MACON4_DEFER));

  // Set the maximum frame-length to prevent host-controller from buffer overflows
  // frame-length + CRC (CRC will not occupy any host buffer-space)
  Enc28j60WriteReg(BANK2_MAMXFLL, (uint8_t) ((ENC28J60_MAXFRAME + 4) >> 0));
  Enc28j60WriteReg(BANK2_MAMXFLH, (uint8_t) ((ENC28J60_MAXFRAME + 4) >> 8));

  // Non-back to back-Inter-Packet-Delay-Gap. (datasheet recommendation)
  Enc28j60WriteReg(BANK2_MAIPGL, 0x12);

  if (!(stored_config_settings & 0x01)) {
    // Datasheet recommendation for half-duplex
    Enc28j60WriteReg(BANK2_MAIPGH, 0x0C);
    // Spec says: If half-duplex program the BANK2 MAIPGH with 0Ch. What about
    // full duplex? The spec doesn't say, so I assume it should be left in the
    // reset state.
  }

  // Back to back-Inter-Packet-Delay-Gap. (datasheet recommendation)
  if (stored_config_settings & 0x01) {
    // Full duplex: Program the BANK2 MABBIPG with 15h
    Enc28j60WriteReg(BANK2_MABBIPG, 0x15);
  }
  else {
    // Half duplex: Program the BANK2 MABBIPG with 12h
    Enc28j60WriteReg(BANK2_MABBIPG, 0x12);
  }

  //---------------------------------------------------------------------------//
  // Bank 3 initializations
  Enc28j60SwitchBank(BANK3);

  // Initialize MAC-adress
  Enc28j60WriteReg(BANK3_MAADR5, stored_uip_ethaddr_oct[5]);  // MAC MSB
  Enc28j60WriteReg(BANK3_MAADR4, stored_uip_ethaddr_oct[4]);
  Enc28j60WriteReg(BANK3_MAADR3, stored_uip_ethaddr_oct[3]);
  Enc28j60WriteReg(BANK3_MAADR2, stored_uip_ethaddr_oct[2]);
  Enc28j60WriteReg(BANK3_MAADR1, stored_uip_ethaddr_oct[1]);
  Enc28j60WriteReg(BANK3_MAADR0, stored_uip_ethaddr_oct[0]);  // MAC LSB
  
  // local loopback disable
  Enc28j60WritePhy(PHY_PHCON2, (1<<PHY_PHCON2_HDLDIS));

  // Set LED Configuration:
  // Errata Workaround: Highest nibble should be '0011'
  Enc28j60WritePhy(PHY_PHLCON,
    (ENC28J60_LEDB<<PHY_PHLCON_LBCFG0)|
    (ENC28J60_LEDA<<PHY_PHLCON_LACFG0)|
    (1<<PHY_PHLCON_STRCH)|0x3000);

  if (!(stored_config_settings & 0x01)) {
    // Half duplex
    // Errata Workaround: Because the LED-Polarity detection circuit does not
    // function properly we clear the FullDuplex Bit ourself. MACON3.FULDPX is
    // cleared anyway.
    Enc28j60WritePhy(PHY_PHCON1, 0x0000);
  }
  
#if DEBUG_SUPPORT != 0
  // Read the ENC28J60 revision level and store for output to the UART and
  // EEPROM. Note: debug[2] also contains the stack overflow bit in the MSB
  // of the byte which must not be over-written here, so the existing bit is
  // read and duplicated here.
  debug[2] = (uint8_t)(debug[2] & 0xf0);
  debug[2] = (uint8_t)(debug[2] | ((Enc28j60ReadReg(BANK3_EREVID)) & 0x07));
  update_debug_storage1(); // Only write the EEPROM if the byte changed.
#endif // DEBUG_SUPPORT

  // Enable Packet Reception
  Enc28j60SetMaskReg(BANKX_ECON1, (1<<BANKX_ECON1_RXEN));
}


uint16_t Enc28j60Receive(uint8_t* pBuffer)
{
  uint16_t nBytes;
  uint16_t nNextPacket;

  // Check for buffer overflow - RXERIF (bit 0) of EIR register
  // If overflow increment the error counter
  if (Enc28j60ReadReg(BANKX_EIR) & 0x01) {
  
#if DEBUG_SUPPORT != 11
// UARTPrintf("Enc28j60Receive OVERFLOW detected\r\n");
#endif // DEBUG_SUPPORT != 11

    RXERIF_counter++;
    // Clear RXERIF
    Enc28j60ClearMaskReg(BANKX_EIR, (1<<BANKX_EIR_RXERIF));
  }

  // Check for at least 1 waiting packet in the buffer
  Enc28j60SwitchBank(BANK1);
  if (Enc28j60ReadReg(BANK1_EPKTCNT) == 0) {
    return 0;
  }
  else {
// #if DEBUG_SUPPORT != 11
// UARTPrintf("Enc28j60Receive NO PACKETS detected\r\n");
// #endif // DEBUG_SUPPORT != 11
  }

  select();

  SpiWriteByte(OPCODE_RBM);	 // Set ENC28J60 to send receive data on SPI

  // Read Next Packet Pointer
  nNextPacket = ((uint16_t) SpiReadByte() << 0);
  nNextPacket |= ((uint16_t) SpiReadByte() << 8);

  // Read Received Bytecount (minus 4 to remove CRC)
  nBytes = ((uint16_t) SpiReadByte() << 0);
  nBytes |= ((uint16_t) SpiReadByte() << 8);
  nBytes -= 4;

  // 2 Bytes Status bits (unused)
  SpiReadByte();
  SpiReadByte();

  // Frame-Data
  //   Comment: MAXFRAME is set larger than the MSS value we communicate to any
  //   host or client we connect to. For this reason we know we can throw away
  //   any packet that exceeds MAXFRAME.
  //
  if (nBytes <= ENC28J60_MAXFRAME) {
    SpiReadChunk(pBuffer, nBytes);
  }
  else {
#if DEBUG_SUPPORT != 11
// UARTPrintf("Enc28j60Receive MAXFRAME exceeded\r\n");
#endif // DEBUG_SUPPORT != 11
  }

  deselect();

  Enc28j60SwitchBank(BANK0);
  // Set RX Read-Pointer and SPI Read-Pointer to next-frame-address
  Enc28j60WriteReg(BANK0_ERDPTL , (uint8_t) (nNextPacket >> 0));
  Enc28j60WriteReg(BANK0_ERDPTH , (uint8_t) (nNextPacket >> 8));

  // Errata Workaround: ERXRDPT should never be programmed with an even value
  // Because the NextPacket will always point to an even value, we can subtract 1 from it
  nNextPacket -= 1;
  if (nNextPacket == ( ((uint16_t)ENC28J60_RXSTART) - 1 )) {
    // Underflow occured while subtracting 1? Use RXEND then. The ENC28J60 logic will
    // set the pointer to the next even address, which is RXSTART.
    nNextPacket = ENC28J60_RXEND;
  }

  Enc28j60WriteReg(BANK0_ERXRDPTL, (uint8_t)(nNextPacket >> 0));
  Enc28j60WriteReg(BANK0_ERXRDPTH, (uint8_t)(nNextPacket >> 8));

  // And decrement PacketCounter
  Enc28j60SetMaskReg(BANKX_ECON2 , (1<<BANKX_ECON2_PKTDEC));
  
#if DEBUG_SUPPORT != 11
// if (nBytes > (ENC28J60_MAXFRAME - 20)) {
// UARTPrintf("Enc28j60Received nBytes = ");
// emb_itoa(nBytes, OctetArray, 10, 3);
// UARTPrintf(OctetArray);
// UARTPrintf("\r\n");
// }
#endif // DEBUG_SUPPORT != 11

  return nBytes;
}


void Enc28j60Send(uint8_t* pBuffer, uint16_t nBytes)
{
  uint16_t TxEnd = ENC28J60_TXSTART + nBytes;
  uint8_t i = 200;
  uint8_t txerif_temp;

  txerif_temp = 0;
  
  // Wait for a previously buffered frame to be sent out completely
  // 
  // This workaround will wait for TXRTS to be cleared within a maximum of 100ms
  // The errata may cause it to never be cleared even though the data finished
  // transmission - so we'll timeout if that is the case.
  while (i--) {
    if (!(Enc28j60ReadReg(BANKX_ECON1) & (1<<BANKX_ECON1_TXRTS))) break;
    wait_timer(500);  // Wait 500 uS
  }

  Enc28j60SwitchBank(BANK0);
  Enc28j60WriteReg(BANK0_EWRPTL, (uint8_t) (ENC28J60_TXSTART >> 0));
  Enc28j60WriteReg(BANK0_EWRPTH, (uint8_t) (ENC28J60_TXSTART >> 8));
  Enc28j60WriteReg(BANK0_ETXNDL, (uint8_t) (TxEnd >> 0));
  Enc28j60WriteReg(BANK0_ETXNDH, (uint8_t) (TxEnd >> 8));	

  select();

  SpiWriteByte(OPCODE_WBM);	 // Set ENC28J60 to receive transmit data on SPI

  SpiWriteByte(0);		 // Per-packet-control-byte
    // For info search for "per packet control byte" in the ENC28J60 data sheet
    // bit 3 PHUGEEN: Per Packet Huge Frame Enable bit
    // 	When POVERRIDE = 0: This bit is ignored.
    // bit 2 PPADEN: Per Packet Padding Enable bit
    // 	When POVERRIDE = 0: This bit is ignored.
    // bit 1 PCRCEN: Per Packet CRC Enable bit
    // 	When POVERRIDE = 0: This bit is ignored.
    // bit 0 POVERRIDE: Per Packet Override bit
    // 	0 = The values in MACON3 will be used to determine how the packet
    //	will be transmitted

  SpiWriteChunk(pBuffer, nBytes); // Copy data to the ENC28J60 transmit buffer

  deselect();
  
  // Errata: In Half-Duplex mode, a hardware transmission abort caused by
  // excessive collisions, a late collision or excessive deferrals, may stall
  // the internal transmit logic. The next packet transmit initiated by the
  // host controller may never succeed (ECON1.TXRTS will remain set
  // indefinitely).
  // Work around: Before attempting to transmit a packet (setting ECON1.TXRTS),
  // reset the internal transmit logic by setting ECON1.TXRST and then
  // clearing ECON1.TXRST. The host controller may wish to issue this Reset
  // before any packet is transmitted (for simplicity), or it may wish to
  // conditionally reset the internal transmit logic based on the Transmit
  // Error Interrupt Flag (EIR.TXERIF), which will become set whenever a
  // transmit abort occurs. Clearing ECON1.TXRST may cause a new transmit
  // error interrupt event (EIR.TXERIF will become set). Therefore, the
  // interrupt flag should be cleared after the Reset is completed.
  //
  // Errata: When transmitting in Half-Duplex mode with some link partners, the
  // PHY will sometimes incorrectly interpret a received link pulse as a
  // collision event.
  //   If less than, or equal to, MACLCON2 bytes have been transmitted when the
  //   false collision occurs, the MAC will abort the current transmission,
  //   wait a random back-off delay and then automatically attempt to retransmit
  //   the packet from the beginning – as it would for a genuine collision.
  //   HOWEVER if greater than MACLCON2 bytes have been transmitted when the
  //   false collision occurs, the event will be considered a late collision by
  //   the MAC and the packet will be aborted without retrying. This causes the
  //   packet to not be delivered to the remote node. In some cases the abort
  //   will fail to reset the transmit state machine.
  // Work around: Implement a software retransmit mechanism whenever a late
  // collision occurs.
  //   When a late collision occurs, the associated bit in the transmit status
  //   vector will be set. Also, the EIR.TXERIF bit will become set, and if
  //   enabled, the transmit error interrupt will occur. If the transmit state
  //   machine does not get reset, the ECON1.TXRTS bit will remain set and no
  //   transmit interrupt will occur (the EIR.TXIF bit will remain clear).
  // As a result, software should detect the completion of a transmit attempt
  // by checking both TXIF and TXERIF. If the Transmit Interrupt (TXIF) did not
  // occur, software must clear the ECON1.TXRTS bit to force the transmit state
  // machine into the correct state.
  //
  // One more concern: In one part of the spec it talks about clearing the
  // TXERIF and LATECOL bits when an abort occurs, but makes no mention of the
  // TXABRT bit. In another part of the spec it talks about clearing the TXERIF
  // and TXABRT bits as necessary when an abort occurs. Below I will also clear
  // the TXABRT bit whenever the TXERIF bit is cleared just to be sure, but the
  // spec is not clear on the order in which these events must happen, other
  // than the errata indicating that TXERIF should be cleared after the TXRTS
  // reset is complete.
  //
  // The above errata are handled together in this code. There will be
  // 16 attempts to work around collisions
  {
    uint8_t late_collision;
    
    // Before starting transmision check for a pre-existing transmit error
    // condition - TXERIF of EIR register.
    //   From the spec:
    //   The Transmit Error Interrupt Flag (TXERIF) is used to indicate that a
    //   transmit abort has occurred. An abort can occur because of any of the
    //   following:
    //     1. Excessive collisions occurred as defined by the Retransmission
    //        Maximum (RETMAX) bits in the MACLCON1 register.
    //     2. A late collision occurred as defined by the Collision Window
    //        (COLWIN) bits in the MACLCON2 register.
    //     3. A collision after transmitting 64 bytes occurred (ESTAT.LATECOL
    //        set).
    //     4. The transmission was unable to gain an opportunity to transmit
    //        the packet because the medium was constantly occupied for too
    //        long. The deferral limit (2.4287 ms) was reached and the
    //        MACON4.DEFER bit was clear.
    //     5. An attempt to transmit a packet larger than the maximum frame
    //        length defined by the MAMXFL registers was made without setting
    //        the MACON3.HFRMEN bit or per packet POVERRIDE and PHUGEEN bits.
    //
    // If there is a TXERIF error already present reset the transmit logic.
    // This should never happen as any error should have been handled the last
    // time a transmit occurred. If no error just start the transmission.
    if (Enc28j60ReadReg(BANKX_EIR) & (1<<BANKX_EIR_TXERIF)) {
      // Count TXERIF error
      TXERIF_counter++;
// XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
wait_timer(10);  // Wait 10 uS
// XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
      // Set TXRST
      Enc28j60SetMaskReg(BANKX_ECON1, (1<<BANKX_ECON1_TXRST));
      // Clear TXRST
      Enc28j60ClearMaskReg(BANKX_ECON1, (1<<BANKX_ECON1_TXRST));
      // Clear TXABRT
      Enc28j60ClearMaskReg(BANKX_EIR, (1<<BANKX_ESTAT_TXABRT));
      // Clear TXERIF
      Enc28j60ClearMaskReg(BANKX_EIR, (1<<BANKX_EIR_TXERIF));
      // Clear TXIF
      Enc28j60ClearMaskReg(BANKX_EIR, (1<<BANKX_EIR_TXIF));
    }

    // Count any transmit
    TRANSMIT_counter++;
    
    // Start transmission
    Enc28j60SetMaskReg(BANKX_ECON1, (1<<BANKX_ECON1_TXRTS));

    // Wait for transmission complete ... or collision error
    // while(TXIF == 0 and TXERIF == 0) NOP
    while (!(Enc28j60ReadReg(BANKX_EIR) & (1<<BANKX_EIR_TXIF))
        && !(Enc28j60ReadReg(BANKX_EIR) & (1<<BANKX_EIR_TXERIF))) nop();
	
    // Save the TXERIF state just in case clearing TXRTS interferes with it
    if (Enc28j60ReadReg(BANKX_EIR) & (1<<BANKX_EIR_TXERIF)) txerif_temp = 1;
    
    // If TXIF is zero Clear TXRTS
    if (!(Enc28j60ReadReg(BANKX_EIR) & (1<<BANKX_EIR_TXIF))) {
      Enc28j60ClearMaskReg(BANKX_ECON1, (1<<BANKX_ECON1_TXRTS));
    }
    
    // If a TXERIF error is present we need to enter a loop to retry
    if (txerif_temp) {
      // Count TXERIF error
      TXERIF_counter++;
// XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
wait_timer(10);  // Wait 10 uS
// XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
      
      for (i = 0; i < 16; i++) {
// XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
// XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
// XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
// We only need to check for a late collision. This is available as the
// ESTAT.LATECOL bit so reading the TSV is way too much code and complication.
// XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
// XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
// XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
        // Read Transmit Status Vector (TSV)
//	read_TSV();
// XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
wait_timer(10);  // Wait 10 uS
// XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
 
        // Bit 29 of the TSV is the Late Collision bit
        // This corresponds to bit 5 of tsv_byte[3]
        late_collision = 0;
//        if (tsv_byte[3] & 0x20) late_collision = 1;
        // ESTAT.LATECOL is the Late Collision bit
        if (Enc28j60ReadReg(BANKX_EIR) & (1<<BANKX_ESTAT_LATECOL)) late_collision = 1;
        else break; // If no Late Collision error leave the for loop
	
	// If error was a late collision retry the transmission
        if (txerif_temp && late_collision) {
	  txerif_temp = 0;

          // Count TXERIF error
          TXERIF_counter++;
// XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
wait_timer(10);  // Wait 10 uS
// XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
      
          // Set TXRST
          Enc28j60SetMaskReg(BANKX_ECON1, (1<<BANKX_ECON1_TXRST));
          // Clear TXRST
          Enc28j60ClearMaskReg(BANKX_ECON1, (1<<BANKX_ECON1_TXRST));
          // Clear TXABRT
          Enc28j60ClearMaskReg(BANKX_EIR, (1<<BANKX_ESTAT_TXABRT));
          // Clear TXERIF
          Enc28j60ClearMaskReg(BANKX_EIR, (1<<BANKX_EIR_TXERIF));
          // Clear TXIF
          Enc28j60ClearMaskReg(BANKX_EIR, (1<<BANKX_EIR_TXIF));
          // Start transmission
          Enc28j60SetMaskReg(BANKX_ECON1, (1<<BANKX_ECON1_TXRTS));
          // Wait for transmission complete ... or collision error
          // while(TXIF == 0 and TXERIF == 0) NOP
          while (!(Enc28j60ReadReg(BANKX_EIR) & (1<<BANKX_EIR_TXIF))
              && !(Enc28j60ReadReg(BANKX_EIR) & (1<<BANKX_EIR_TXERIF))) nop();
          // Save the TXERIF state just in case clearing TXRTS interferes with it
          if (Enc28j60ReadReg(BANKX_EIR) & (1<<BANKX_EIR_TXERIF)) txerif_temp = 1;
          // If TXIF is zero Clear TXRTS
          if (!(Enc28j60ReadReg(BANKX_EIR) & (1<<BANKX_EIR_TXIF))) {
	    Enc28j60ClearMaskReg(BANKX_ECON1, (1<<BANKX_ECON1_TXRTS));
	  }
          // Go back to the start of the for() loop to check error status.
        }
      }
    }
  }
}


/*
void read_TSV(void)
{
  uint8_t saved_ERDPTL;
  uint8_t saved_ERDPTH;
  uint16_t tsv_start;
  
  // KEEP THIS CODE AROUND in case reading the TSV bytes is ever
  // needed again. It came in handy for debugging the Ethernet
  // interface, but now that it all seems to be working this code
  // is sideline.

  // I don't find this in the spec, but from experimentation it seems a
  // few microseconds are needed for the TSV values to be stable
  // wait_timer(10);
  wait_timer(20);
  
  // Read the Transmit Status Vector
  // Save the current read pointer for restoration later
  saved_ERDPTL = Enc28j60ReadReg(BANK0_ERDPTL);
  saved_ERDPTH = Enc28j60ReadReg(BANK0_ERDPTH);
  
  // Get the location of the transmit status vector
  tsv_start = ((Enc28j60ReadReg(BANK0_ETXNDH)) << 8);
  tsv_start += Enc28j60ReadReg(BANK0_ETXNDL);
  tsv_start++;
  
  // Read the transmit status vector
  Enc28j60WriteReg(BANK0_ERDPTL, (uint8_t)(tsv_start & 0x00ff));
  Enc28j60WriteReg(BANK0_ERDPTH, (uint8_t)(tsv_start >> 8));
  
  // Set ENC28J60 to read buffer memory mode
  select();
  SpiWriteByte(OPCODE_RBM);
  
  // Read 7 bytes of TSV
  {
    uint8_t i;
    for (i=0; i<7; i++) {
      tsv_byte[i] = SpiReadByte(); // Bits 7-0
    }
  }
        
  deselect();

wait_timer(10);  // Wait 10 uS

  // Restore the current read pointer
  Enc28j60WriteReg(BANK0_ERDPTL, saved_ERDPTL);
  Enc28j60WriteReg(BANK0_ERDPTH, saved_ERDPTH);
}
*/
