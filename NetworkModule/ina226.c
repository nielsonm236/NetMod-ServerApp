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

// #include <math.h>


float voltage;       // Voltage value reported by the INA226
float current;       // Current value reported by the INA226
float power;         // Power value reported by the INA226
float shunt_voltage; // Shunt Voltage value reported by the INA226

float current_lsb;




// Operation of the INA226
// At power on:
//   Call ina226_init()
//   Call ina226_calibrate(r_shunt, max_current)
//     r_shunt is a float and will be either 0.1 or 0.002
//     max_current is a float and will be 20 for the 0.002 r_shunt
//     max_current is a float and will be 0.4 for the 0.1 r_shunt
//   Call ina226_configure(uint8_t period, uint8_t average)
//     period is typically set to 4
//     average is typically set to 0
//
// During runtime:
//   Call ina226_conversion_ready() to determine if a conversion is available
//   to be read.
//   Call ina226_read_measurements(*voltage, *current, *power, *shunt_voltage)
//     voltage, current, power, and shunt_voltage are floats that must exist
//     as globals.


void ina226_init_all()
{
    // Reset all five INA226 chips
    ina226_write_reg(INA226_1_write, INA226_REG_CONFIGURATION, INA226_CONFIGURATION__RST);
    ina226_write_reg(INA226_2_write, INA226_REG_CONFIGURATION, INA226_CONFIGURATION__RST);
    ina226_write_reg(INA226_3_write, INA226_REG_CONFIGURATION, INA226_CONFIGURATION__RST);
    ina226_write_reg(INA226_4_write, INA226_REG_CONFIGURATION, INA226_CONFIGURATION__RST);
    ina226_write_reg(INA226_5_write, INA226_REG_CONFIGURATION, INA226_CONFIGURATION__RST);
}


/*
void ina226_disable()
{
  // Clear the MODE bits of the configuration register
  uint16_t reg;
  reg = ina226_read_reg(INA226_REG_CONFIGURATION);
  reg &= ~INA226_CONFIGURATION__MODE_MASK;

  // Write the configuration value
  ina226_write_reg(INA226_REG_CONFIGURATION, reg);
}
*/


void ina226_calibrate_all()
{
  // Calibrate all INA226 devices
  ina226_calibrate(INA226_1_write, 0.002, 20);
  ina226_calibrate(INA226_2_write, 0.002, 20);
  ina226_calibrate(INA226_3_write, 0.002, 20);
  ina226_calibrate(INA226_4_write, 0.002, 20);
  ina226_calibrate(INA226_5_write, 0.002, 20);
}


void ina226_calibrate(uint8_t write_command, float r_shunt, float max_current)
{
  //     r_shunt is a float and will be either 0.1 or 0.002
  //     max_current is a float and will be 20 for the 0.002 r_shunt
  //     max_current is a float and will be 0.4 for the 0.1 r_shunt
  
  float calib;
  uint16_t calib_reg;
  
  // Compute the current LSB as max_expected_current/2**15
  current_lsb = max_current / (1 << 15);

  // Compute calibration register as 0.00512 / (current_lsb * r_shunt)
  calib = 0.00512 / (current_lsb * r_shunt);

  // XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
  // XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
  // XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
  // Register is a 16bit unsigned integer, thus convert and round above
//  calib_reg = (uint16_t) floorf(calib);
  // This simple recast can't be right even though I see it recommended in
  // in StackOverflow as long as the float is positive. To get a better
  // rounding there is the suggestion of adding 0.5 before recast. For example
  // adding 0.5 would cause anything up to 1.4999... to be truncated to 1 but
  // anything 1.5 and above will get truncated to 2.
  calib_reg = (uint16_t)(calib);
  // XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
  // XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
  // XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX

  // Re-compute and store real current LSB
  current_lsb = 0.00512 / (r_shunt * calib_reg);

  // Write calibration
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
  reg = (average << INA226_CONFIGURATION__AVG_SHIFT)
          & INA226_CONFIGURATION__AVG_MASK;
  
  // INA226_CONFIGURATION__BUS_CONV_TIME_MASK		0x01C0
  // INA226_CONFIGURATION__BUS_CONV_TIME_SHIFT		6
  // Value set to 100 = Conversion time of 1.1ms. This is the default setting.
  reg |= (period << INA226_CONFIGURATION__BUS_CONV_TIME_SHIFT)
          & INA226_CONFIGURATION__BUS_CONV_TIME_MASK;
  
  // INA226_CONFIGURATION__SHUNT_CONV_TIME_MASK		0x0038
  // INA226_CONFIGURATION__SHUNT_CONV_TIME_SHIFT	3
  // Value set to 100 = Conversion time of 1.1ms. This is the default setting.
  reg |= (period << INA226_CONFIGURATION__SHUNT_CONV_TIME_SHIFT)
          & INA226_CONFIGURATION__SHUNT_CONV_TIME_MASK;
  
  // INA226_CONFIGURATION__MODE_MASK			0x0007
  // INA226_CONFIGURATION__MODE_SHIFT			0
  // Convert Bus and Shunt Voltage continuously. This is the default setting.
  reg |= INA226_CONFIGURATION__MODE_MASK;
  
  // Write the configuration value
  ina226_write_reg(write_command, INA226_REG_CONFIGURATION, reg);
}


int ina226_conversion_ready(uint8_t write_command, uint8_t read_command)
{
  // Read the MASK ENABLE register and check for the ConversionReady flag.
  // Returns 0 if not ready, and non-zero if ready.
  return (ina226_read_reg(write_command, read_command, INA226_REG_MASK_ENABLE) & INA226_MASK_ENABLE__CVRF) != 0;
}


void ina226_read_measurements(uint8_t write_command, uint8_t read_command, float *voltage, float *current, float *power, float *shunt_voltage)
{
  uint16_t voltage_reg;
  int16_t current_reg;
  int16_t power_reg;
  int16_t shunt_voltage_reg;

  // Read BUS voltage register
  voltage_reg = ina226_read_reg(write_command, read_command, INA226_REG_BUS_VOLTAGE);

  // Read current register
  current_reg = (int16_t) ina226_read_reg(write_command, read_command, INA226_REG_CURRENT);

  // Read POWER register
  power_reg = (int16_t) ina226_read_reg(write_command, read_command, INA226_REG_POWER);

  // Read POWER register
  shunt_voltage_reg = (int16_t) ina226_read_reg(write_command, read_command, INA226_REG_SHUNT_VOLTAGE);

  // Read the mask/enable register to clear it
  (void) ina226_read_reg(write_command, read_command, INA226_REG_MASK_ENABLE);

  // Check for the requested measures and compute their values
  if (voltage) {
    // Convert to Volts
    *voltage = (float) voltage_reg * 1.25e-3;
  }

  if (current) {
    // Convert to Amperes
    *current = (float) current_reg * current_lsb;
  }

  if (power) {
    // Convert to Watts
    *power = (float) power_reg * 25 * current_lsb;
  }

  if (shunt_voltage) {
    // Convert to Volts
    *shunt_voltage = (float) shunt_voltage_reg * 2.5e-6;
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
  I2C_control(write_command);              // Write I2C address with Write mode
  I2C_write_byte(register_address);        // Write register_address
  I2C_write_byte((uint8_t)(value >> 8));   // Write upper byte of the register
  I2C_write_byte((uint8_t)(value & 0xFF)); // Write lower byte of the register
  I2C_stop();

#if DEBUG_SUPPORT == 15
// UARTPrintf("Write INA226 register_address = ");
// emb_itoa(register_address, OctetArray, 16, 2);
// UARTPrintf(OctetArray);
// UARTPrintf("   value = ");
// emb_itoa(value, OctetArray, 16, 4);
// UARTPrintf(OctetArray);
// UARTPrintf("\r\n");
#endif // DEBUG_SUPPORT == 15

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

  I2C_control(write_command);       // Write I2C address with Write mode
  I2C_write_byte(register_address); // Write register_address
  I2C_stop();
  I2C_control(read_command);        // Write I2C address with Read mode
  buf[1] = I2C_read_byte(0);        // Read upper byte of register
  buf[0] = I2C_read_byte(1);        // Read lower byte of register followed by
                                    // STOP.
  
  return (buf[0] << 8) + buf[1];
}

#endif // INA226_SUPPORT == 1
