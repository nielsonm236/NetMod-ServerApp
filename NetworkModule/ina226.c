/*
 * This file is part of HiKoB Openlab.
 *
 * HiKoB Openlab is free software: you can redistribute it and/or
 * modify it under the terms of the GNU Lesser General Public License
 * as published by the Free Software Foundation, version 3.
 *
 * HiKoB Openlab is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
 * Lesser General Public License for more details.
 *
 * You should have received a copy of the GNU Lesser General Public
 * License along with HiKoB Openlab. If not, see
 * <http://www.gnu.org/licenses/>.
 *
 * Copyright (C) 2011,2012 HiKoB.
 */

/*
 * ina226.c
 *
 *  Created on: Jul 12, 2012
 *      Author: Clement Burin des Roziers <clement.burin-des-roziers.at.hikob.com>
 */

/* Modifications 2023 Michael Nielson
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
 
 Copyright 2023 Michael Nielson
*/



#include "main.h"


#if INA226_SUPPORT == 1

// voltage, current, power, and shunt_voltage are int32_t that must exist
// as globals.
int32_t voltage;       // Voltage value (x1,000) reported by the INA226
int32_t current;       // Current value (x1,000) reported by the INA226
int32_t power;         // Power value (x1,000) reported by the INA226
int32_t current_lsb;   // (x1,000,000)

extern uint8_t stored_shunt_res; // INA226 Shunt Resistance value stored in
                                 // EEPROM

extern uint8_t OctetArray[14];  // Used in emb_itoa conversions and to
                                // transfer short strings globally


// Operation of the INA226
// At power on:
//   Call ina226_init()
//   Call ina226_calibrate(r_shunt, max_current)
//     r_shunt is an int32_t and can be any value from 001 to 255 (1000
//       times the actual value of the shunt resistor).
//     max_current is an int32_t
//     max_current is an int32_t
//   Call ina226_configure(uint8_t period, uint8_t average)
//     period is typically set to 4
//     average is typically set to 0
//
// During runtime:
//   Call ina226_read_measurements(write_command, read_command)



void ina226_init_all()
{
  // Reset all five INA226 chips
  ina226_write_reg(INA226_1_write, INA226_REG_CONFIGURATION, INA226_CONFIGURATION__RST);
  ina226_write_reg(INA226_2_write, INA226_REG_CONFIGURATION, INA226_CONFIGURATION__RST);
  ina226_write_reg(INA226_3_write, INA226_REG_CONFIGURATION, INA226_CONFIGURATION__RST);
  ina226_write_reg(INA226_4_write, INA226_REG_CONFIGURATION, INA226_CONFIGURATION__RST);
  ina226_write_reg(INA226_5_write, INA226_REG_CONFIGURATION, INA226_CONFIGURATION__RST);
}


void ina226_calibrate_all()
{
  int32_t shunt_resistance;
  int32_t max_current;
  
  // if stored_shunt_res is zero set to default
  if (stored_shunt_res == 0) {
    unlock_eeprom();
    stored_shunt_res = 10; // 0.010 ohms
    lock_eeprom();
  }
  
  // Set values based on stored_shunt_res
  shunt_resistance = stored_shunt_res; // This is shunt_resistance x1,000
  max_current = 81920 / shunt_resistance; // This is max_current x1,000
  // example:
  // float version:
  //   stored_shunt_res = 10
  //   shunt_resistance = 0.01
  //   max_current = 0.08192f / shunt_resistance = 8.192
  // int32_t version:
  //   stored_shunt_res = 10
  //   shunt_resistance = 10
  //   max_current = 81920 / shunt_resistance = 8192 (x1000 of float value)
  

  // Calibrate all INA226 devices
  // Comments:
  //   Must limit voltage across shunt resistor to a max of 0.08192V. There
  //   isn't an automated way to do this. I have a spreadsheet that can be
  //   used as an aid ... the TI spec sheet is very difficult to understand,
  //   but it boils down to "Don't let the maximum current draw produce a
  //   voltage across the Shunt Resistor that exceeds 0.08192 V".

  ina226_calibrate(INA226_1_write, shunt_resistance, max_current);
  ina226_calibrate(INA226_2_write, shunt_resistance, max_current);
  ina226_calibrate(INA226_3_write, shunt_resistance, max_current);
  ina226_calibrate(INA226_4_write, shunt_resistance, max_current);
  ina226_calibrate(INA226_5_write, shunt_resistance, max_current);
}


// void ina226_calibrate(uint8_t write_command, float r_shunt, float max_current)
void ina226_calibrate(uint8_t write_command, int32_t r_shunt, int32_t max_current)
{
  int32_t calib; // calib x1000
  uint16_t calib_reg;
  
  // Compute the current LSB as:
  //   current_lsb = max_current/2**15
  //   current_lsb = max_current/32768
  // Original "float" version of equation:
  //   current_lsb = (int32_t)(max_current / 32768);
  // int32_t version of equation:
  current_lsb = (int32_t)((max_current * 1000) / 32768);
  // example:
  // float version:
  //   max_current = 8.192
  //   current_lsb = max_current / 32768 = 0.00025
  // int32_t version:
  //   max_current = 8192 (x1000 of float value)
  //   current_lsb = (max_current * 1000) / 32768 = 8192000 / 32768 = 250 (x1,000,000 of float value)

  // Compute calibration register as 0.00512 / (current_lsb * r_shunt)
  // Original "float" version of equation:
  //   calib = 0.00512 / (current_lsb * r_shunt);
  // int32_t version of equation:
  calib = (int32_t)(5120000 / (current_lsb * r_shunt));
  // example:
  // float version:
  //   current_lsb = 0.00025
  //   r_shunt = 0.010
  //   calib = 0.00512 / (current_lsb * r_shunt) = 0.00512 / (0.00025 * 0.01) = 0.00512 / 0.0000025 = 2,048
  // int32_t version:
  //   current_lsb = 250 (x1,000,000 of float version)
  //   r_shunt = 10 (x1000 of float version)
  //   calib = (5120000) / (current_lsb * r_shunt) = 5120000 / (250 * 10) = 5120000 / 2500 = 2,048
  
  // Convert calib to uint16_t for write to calib_reg
  calib_reg = (uint16_t)(calib);

  // Re-compute and store real current LSB
  // I'm not sure what benefit this recalculation provides. It basically
  // recalculates current_lsb based on the truncated calib_reg value rather
  // than the original float value.
  // float version:
  //   current_lsb = 0.00512 / (r_shunt * calib_reg);
  // int32_t version:
  current_lsb = (int32_t)(5120000 / (r_shunt * calib_reg));  
  // example:
  // float version:
  //   r_shunt = 0.010
  //   calib_reg = 2048
  //   current_lsb = 0.00512 / (r_shunt * calib_reg) = 0.00512 / (0.01 * 2048) = 0.00512 / 20.48 = 0.00025
  // int32_t version:
  //   r_shunt = 10 (x1000 of float version)
  //   calib_reg = 2048
  //   curent_lsb = 5120000 / (r_shunt * calib_reg) = 5120000 / (10 * 2048) = 5120000 / 20480 = 250 (x1,000,000 of float version)

  // Write calibration register
  ina226_write_reg(write_command, INA226_REG_CALIBRATION, calib_reg);
}


void ina226_configure_all()
{
  // Configure all five INA226 devices
  ina226_configure(INA226_1_write, 4, 0);
  ina226_configure(INA226_2_write, 4, 0);
  ina226_configure(INA226_3_write, 4, 0);
  ina226_configure(INA226_4_write, 4, 0);
  ina226_configure(INA226_5_write, 4, 0);
}


void ina226_configure(uint8_t write_command, uint8_t period, uint8_t average)
{
  // Prepare Configuration register value
  uint16_t reg;
  
  // INA226_CONFIGURATION__AVG_MASK			0x0E00
  // INA226_CONFIGURATION__AVG_SHIFT			9
  // Value set to 000 = 1 sample, no averaging. This is the default setting.
  reg = (uint16_t)((average << INA226_CONFIGURATION__AVG_SHIFT)
          & INA226_CONFIGURATION__AVG_MASK);

  // INA226_CONFIGURATION__BUS_CONV_TIME_MASK		0x01C0
  // INA226_CONFIGURATION__BUS_CONV_TIME_SHIFT		6
  // Value set to 100 = Conversion time of 1.1ms. This is the default setting.
  reg |= (uint16_t)((period << INA226_CONFIGURATION__BUS_CONV_TIME_SHIFT)
          & INA226_CONFIGURATION__BUS_CONV_TIME_MASK);
  
  // INA226_CONFIGURATION__SHUNT_CONV_TIME_MASK		0x0038
  // INA226_CONFIGURATION__SHUNT_CONV_TIME_SHIFT	3
  // Value set to 100 = Conversion time of 1.1ms. This is the default setting.
  reg |= (uint16_t)((period << INA226_CONFIGURATION__SHUNT_CONV_TIME_SHIFT)
          & INA226_CONFIGURATION__SHUNT_CONV_TIME_MASK);
  
  // INA226_CONFIGURATION__MODE_MASK			0x0007
  // INA226_CONFIGURATION__MODE_SHIFT			0
  // Convert Bus and Shunt Voltage continuously. This is the default setting.
  reg |= (uint16_t)(INA226_CONFIGURATION__MODE_MASK);
  
  // Write the configuration value
  ina226_write_reg(write_command, INA226_REG_CONFIGURATION, reg);
}


void ina226_read_measurements(uint8_t write_command, uint8_t read_command)
{
  // This function will read voltage, current, power, and shunt_voltage
  // measurements from the ina226 specified by the write_command and
  // read_command.
  //
  // Measurements are read only if the Mfg ID code is found. Otherwise all
  // values are set to 0.
  
  uint16_t voltage_reg;
  int16_t current_reg;
  int16_t power_reg;
  uint16_t mfg_id_reg;

  // Read the Mfg ID
  mfg_id_reg = (uint16_t)(ina226_read_reg(write_command, read_command, INA226_REG_MFG_ID));
  
  if (mfg_id_reg == INA226_MFG_ID) {
    
    // Read BUS voltage register
    voltage_reg = (uint16_t)(ina226_read_reg(write_command, read_command, INA226_REG_BUS_VOLTAGE));
    
    // Read current register
    current_reg = (int16_t)(ina226_read_reg(write_command, read_command, INA226_REG_CURRENT));

    // Read POWER register
    power_reg = (int16_t)(ina226_read_reg(write_command, read_command, INA226_REG_POWER));


    // Convert to Volts
    // Original "float" equation
    //   voltage = (float)(voltage_reg * 0.00125);
    // Integer version of equation
    //   Equation is arranged as follows because when all in one equation the
    //   result is incorrect. Not sure why. And I couldn't find any other
    //   arrangement that produced smaller code.
    voltage = (int32_t)(voltage_reg);              // x1000 of float version
    voltage = (int32_t)((voltage * 1250) / 1000);  // x1000 of float version


    // Convert to Amperes
    // Original "float" equation
    //   current = (float)(current_reg * current_lsb);
    // Integer version of equation
    //   Caution when rearranging the following equation. It is giving the
    //   correct result, but any other arrangement of the equation produces
    //   larger code.
    current = (int32_t)((current_reg * current_lsb) / 1000); // x1000 of float version


    // Convert to Watts
    // Original "float" equation
    //   power = (float)(power_reg * 25 * current_lsb);
    // Integer version of equation
    //   Caution when rearranging the following equation. It is giving the
    //   correct result, but any other arrangement of the equation produces
    //   larger code.
    power = (int32_t)((power_reg * 25 * current_lsb) / 1000); // x1000 of float version
  }
  
  else {
    voltage = 0;
    current = 0;
    power = 0;
  }
}


void ina226_write_reg(uint8_t write_command, uint8_t register_address, uint16_t value)
{
  // This function performs a register write to the INA226.
  // A register write requires the following sequence:
  //   Write the I2C address with the Read/Write bit set to 0 (write).
  //   Write the register_address for the register to be written.
  //   Write the register (2 bytes).
  //   Issue a STOP.
  uint8_t byte;
  
  I2C_control(write_command);       // Write I2C address with Write mode
  I2C_write_byte(register_address); // Write register_address
  byte = (uint8_t)(value >> 8);
  I2C_write_byte(byte);             // Write upper byte of the register
  byte = (uint8_t)(value & 0xff);
  I2C_write_byte(byte);             // Write lower byte of the register
  I2C_stop();
}


uint16_t ina226_read_reg(uint8_t write_command, uint8_t read_command, uint8_t register_address)
{
  // This function performs a register read from the INA226.
  // A register read requires the following sequence:
  //   Write the I2C address with the Read/Write bit set to 0 (write).
  //   Write the register_address for the register to be read.
  //   Issue a STOP.
  //   Write the I2C address with the Read/Write bit set to 1 (read).
  //   Read the register (2 bytes). The read function will issue a STOP after
  //     the second byte.
  uint8_t buf[2];
  uint16_t rtn;

  I2C_control(write_command);       // Write I2C address with Write mode
  I2C_write_byte(register_address); // Write register_address
  I2C_stop();
  I2C_control(read_command);        // Write I2C address with Read mode
  buf[0] = I2C_read_byte(0);        // Read upper byte of register
  buf[1] = I2C_read_byte(1);        // Read lower byte of register followed by
                                    // STOP.
  rtn = (uint16_t)((buf[0] << 8) + buf[1]);
  return rtn;
}

#endif // INA226_SUPPORT == 1
