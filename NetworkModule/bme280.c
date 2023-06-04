/**
* Copyright (c) 2020 Bosch Sensortec GmbH. All rights reserved.
*
* BSD-3-Clause
*
* Redistribution and use in source and binary forms, with or without
* modification, are permitted provided that the following conditions are met:
*
* 1. Redistributions of source code must retain the above copyright
*    notice, this list of conditions and the following disclaimer.
*
* 2. Redistributions in binary form must reproduce the above copyright
*    notice, this list of conditions and the following disclaimer in the
*    documentation and/or other materials provided with the distribution.
*
* 3. Neither the name of the copyright holder nor the names of its
*    contributors may be used to endorse or promote products derived from
*    this software without specific prior written permission.
*
* THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
* "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
* LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS
* FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE
* COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT,
* INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
* (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR
* SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION)
* HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT,
* STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING
* IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE
* POSSIBILITY OF SUCH DAMAGE.
*
* @file       bme280.c
* @date       2020-03-28
* @version    v3.5.0
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

// Filename bme280.c
// Sensor driver for BME280 sensor

// High level modification notes;
// - This application only uses Forced Mode - never Normal Mode. Thus all
//   Standby code is removed.
// - Checks for whether Settings are changed is removed. Registers are always
//   updated even if not changed.
// - Most pointer NULL checks are removed. Those were mostly needed for
//   portability and only add bulk to the code in this application.
// - Most return checks for errors are removed. Just won't fit in the limited
//   Flash space in this application.

// All includes are in main.h
#include "main.h"

#if BME280_SUPPORT == 1

extern int16_t stored_altitude; // User entered altitude used for BME280
				// pressure calibration stored in EEPROM

extern uint8_t OctetArray[14];  // Used in emb_itoa conversions and to
                                // transfer short strings globally

// Create globals for use of these values in the httpd.c code
int32_t comp_data_temperature;
int32_t comp_data_pressure;
int32_t comp_data_humidity;


// Internal macros
// To identify osr settings selected by user
#define OVERSAMPLING_SETTINGS    UINT8_C(0x07)

// To identify filter and standby settings selected by user
#define FILTER_STANDBY_SETTINGS  UINT8_C(0x18)


/****************** Global Function Definitions *******************************/

int8_t bme280_init(struct bme280_dev *dev)
{
  // This API is the entry point.
  // It reads the chip-id and calibration data from the sensor.
  int8_t rslt;

  // Chip id read try count. Will try to read the chip id 5 times at 1ms
  // intervals.
  int8_t try_count = 5;
  uint8_t chip_id = 0;

  rslt = BME280_OK;

  while (try_count)
  {
    // Read the chip-id of bme280 sensor
    bme280_get_regs(BME280_CHIP_ID_ADDR, &chip_id, 1);
    
    // Check for chip id validity
    if (chip_id == BME280_CHIP_ID) {
      // Reset the sensor
      bme280_soft_reset();
      // Read the calibration data
      get_calib_data(dev);
      break;
    }

    // Wait for 1 ms
    wait_timer(1000);
    --try_count;
  }

  // Chip id check failed
  if (!try_count) rslt = BME280_E_DEV_NOT_FOUND;
  
  return rslt;
}


void bme280_get_regs(uint8_t reg_addr, uint8_t *reg_data, uint16_t len)
{
  // This API reads the data from the given register address of the sensor.

  // Read the data
  user_i2c_read(reg_addr, reg_data, len);
}


void bme280_set_regs(uint8_t *reg_addr, const uint8_t *reg_data)
{
  // This API writes the given data to the register address of the sensor.
  // In this application only 1 register is written with each call.

  user_i2c_write(reg_addr[0], &reg_data[0], 1);
}


void bme280_set_sensor_settings(uint8_t desired_settings, struct bme280_dev *dev)
{
  // This API sets the oversampling, filter and standby duration
  // (normal mode) settings in the sensor.
  uint8_t sensor_mode;

  bme280_get_sensor_mode(&sensor_mode);

  if (sensor_mode != BME280_SLEEP_MODE) put_device_to_sleep();

  // Write oversampling settings
  set_osr_settings(desired_settings, &dev->settings);

  // Write filter settings
  set_filter_standby_settings(desired_settings, &dev->settings);
}


void bme280_get_sensor_settings(struct bme280_dev *dev)
{
  // This API gets the oversampling, filter and standby duration (normal mode)
  // settings from the sensor.
  uint8_t reg_data[4];

  bme280_get_regs(BME280_CTRL_HUM_ADDR, reg_data, 4);

  parse_device_settings(reg_data, &dev->settings);
}


void bme280_set_sensor_mode(uint8_t sensor_mode, struct bme280_dev *dev)
{
  // This API sets the power mode of the sensor.
  int8_t rslt;
  uint8_t last_set_mode;

  bme280_get_sensor_mode(&last_set_mode);

  // If the sensor is not in sleep mode put the device to sleep mode
  if (last_set_mode != BME280_SLEEP_MODE) put_device_to_sleep();

  // Set the power mode
  write_power_mode(sensor_mode);
}


void bme280_get_sensor_mode(uint8_t *sensor_mode)
{
  // This API gets the power mode of the sensor.

  // Read the power mode register
  bme280_get_regs(BME280_PWR_CTRL_ADDR, sensor_mode, 1);

  // Assign the power mode in the device structure
  *sensor_mode = (uint8_t)(BME280_GET_BITS_POS_0(*sensor_mode, BME280_SENSOR_MODE));
}


void bme280_soft_reset(void)
{
  // This API performs the soft reset of the sensor.
  uint8_t reg_addr = BME280_RESET_ADDR;
  uint8_t status_reg = 0;
  uint8_t try_run = 5;
  uint8_t soft_rst_cmd = BME280_SOFT_RESET_COMMAND;

  // Perform Soft Reset
  bme280_set_regs(&reg_addr, &soft_rst_cmd);
  
  // A Soft Reset will cause the BME280 to start a copy of the internal NVM
  // (Non-Volatile Memory) calibration data to the Calibration registers. The
  // "do" loop will wait for the copy to complete. The NVM was factory set at
  // time of manufacture.
  do
  {
    // As per data sheet - Table 1, startup time is 2 ms.
    wait_timer(2000); // wait 2000 us
    bme280_get_regs(BME280_STATUS_REG_ADDR, &status_reg, 1);

  } while ((try_run--) && (status_reg & BME280_STATUS_IM_UPDATE));
}


void bme280_get_sensor_data(struct bme280_data *comp_data, struct bme280_dev *dev)
{
  // This API reads the pressure, temperature and humidity data from the
  // sensor, compensates the data and stores it in the bme280_data structure
  // instance passed by the user.

  // Array to store the pressure, temperature and humidity data read from the
  // sensor
  uint8_t reg_data[BME280_P_T_H_DATA_LEN] = { 0 };
  struct bme280_uncomp_data uncomp_data = { 0 };

  // Read the pressure, temperature, and humidity data from the sensor
  bme280_get_regs(BME280_DATA_ADDR, reg_data, BME280_P_T_H_DATA_LEN);
    
  // Parse the data from the sensor
  bme280_parse_sensor_data(reg_data, &uncomp_data);

  // Compensate the data from the sensor
  bme280_compensate_data(&uncomp_data, comp_data, &dev->calib_data);
}


void bme280_parse_sensor_data(const uint8_t *reg_data, struct bme280_uncomp_data *uncomp_data)
{
  // This API is used to parse the pressure, temperature and humidity data
  // and store it in the bme280_uncomp_data structure instance.
    
  // Variables to store the sensor data
  uint32_t data_xlsb;
  uint32_t data_lsb;
  uint32_t data_msb;

  // Store the parsed register values for pressure data
  data_msb = (uint32_t)reg_data[0] << 12;
  data_lsb = (uint32_t)reg_data[1] << 4;
  data_xlsb = (uint32_t)reg_data[2] >> 4;
  uncomp_data->pressure = data_msb | data_lsb | data_xlsb;

  // Store the parsed register values for temperature data
  data_msb = (uint32_t)reg_data[3] << 12;
  data_lsb = (uint32_t)reg_data[4] << 4;
  data_xlsb = (uint32_t)reg_data[5] >> 4;
  uncomp_data->temperature = data_msb | data_lsb | data_xlsb;

  // Store the parsed register values for humidity data
  data_msb = (uint32_t)reg_data[6] << 8;
  data_lsb = (uint32_t)reg_data[7];
  uncomp_data->humidity = data_msb | data_lsb;
}


void bme280_compensate_data(const struct bme280_uncomp_data *uncomp_data,
                              struct bme280_data *comp_data,
                              struct bme280_calib_data *calib_data)
{
  // This API is used to compensate the pressure, temperature and humidity
  // data according to the component selected by the user.

  // Initialize to zero
  comp_data->temperature = 0;
  comp_data->pressure = 0;
  comp_data->humidity = 0;

  // Compensate the temperature data
  comp_data->temperature = compensate_temperature(uncomp_data, calib_data);

  // Compensate the pressure data
  comp_data->pressure = compensate_pressure(uncomp_data, calib_data);

  // Compensate the humidity data
  comp_data->humidity = compensate_humidity(uncomp_data, calib_data);
  
  // Create globals for use of these values in the httpd.c code
  comp_data_temperature = comp_data->temperature;
  comp_data_pressure = comp_data->pressure;
  comp_data_humidity = comp_data->humidity;
}


void set_osr_settings(uint8_t desired_settings, const struct bme280_settings *settings)
{
  // This internal API sets the oversampling settings for pressure,
  // temperature and humidity in the sensor.

  set_osr_humidity_settings(settings);
  set_osr_press_temp_settings(desired_settings, settings);
}


void set_osr_humidity_settings(const struct bme280_settings *settings)
{
  // This API sets the humidity oversampling settings of the sensor.
  uint8_t ctrl_hum;
  uint8_t ctrl_meas;
  uint8_t reg_addr = BME280_CTRL_HUM_ADDR;

  ctrl_hum = (uint8_t)(settings->osr_h & BME280_CTRL_HUM_MSK);

  // Write the humidity control value in the register
  bme280_set_regs(&reg_addr, &ctrl_hum);

  // Humidity related changes will be only effective after a
  // write operation to ctrl_meas register
  reg_addr = BME280_CTRL_MEAS_ADDR;
  bme280_get_regs(reg_addr, &ctrl_meas, 1);
  bme280_set_regs(&reg_addr, &ctrl_meas);
}


void set_osr_press_temp_settings(uint8_t desired_settings,
                                          const struct bme280_settings *settings)
{
  // This API sets the pressure and/or temperature oversampling settings
  // in the sensor according to the settings selected by the user.
  uint8_t reg_addr = BME280_CTRL_MEAS_ADDR;
  uint8_t reg_data;

  bme280_get_regs(reg_addr, &reg_data, 1);

  fill_osr_press_settings(&reg_data, settings);

  fill_osr_temp_settings(&reg_data, settings);

  // Write the oversampling settings in the register
  bme280_set_regs(&reg_addr, &reg_data);
}


void set_filter_standby_settings(uint8_t desired_settings,
                                 const struct bme280_settings *settings)
{
  // This internal API sets the filter settings in the sensor according to the
  // settings selected by the user.
  uint8_t reg_addr = BME280_CONFIG_ADDR;
  uint8_t reg_data;

  bme280_get_regs(reg_addr, &reg_data, 1);

  fill_filter_settings(&reg_data, settings);

  // Write the oversampling settings in the register
  bme280_set_regs(&reg_addr, &reg_data);
}


void fill_filter_settings(uint8_t *reg_data, const struct bme280_settings *settings)
{
  // This internal API fills the filter settings provided by the user
  // in the data buffer so as to write in the sensor.
  *reg_data = (uint8_t)(BME280_SET_BITS(*reg_data, BME280_FILTER, settings->filter));
}


void fill_osr_press_settings(uint8_t *reg_data, const struct bme280_settings *settings)
{
  // This internal API fills the pressure oversampling settings provided by
  // the user in the data buffer so as to write in the sensor.
  *reg_data = (uint8_t)(BME280_SET_BITS(*reg_data, BME280_CTRL_PRESS, settings->osr_p));
}


void fill_osr_temp_settings(uint8_t *reg_data, const struct bme280_settings *settings)
{
  // This internal API fills the temperature oversampling settings
  // provided by the user in the data buffer so as to write in the sensor.
  *reg_data = (uint8_t)(BME280_SET_BITS(*reg_data, BME280_CTRL_TEMP, settings->osr_t));
}


void parse_device_settings(const uint8_t *reg_data, struct bme280_settings *settings)
{
  // This internal API parse the oversampling (pressure, temperature
  // and humidity), filter and standby duration settings and stores them in
  // the device structure.
  settings->osr_h = (uint8_t)(BME280_GET_BITS_POS_0(reg_data[0], BME280_CTRL_HUM));
  settings->osr_p = (uint8_t)(BME280_GET_BITS(reg_data[2], BME280_CTRL_PRESS));
  settings->osr_t = (uint8_t)(BME280_GET_BITS(reg_data[2], BME280_CTRL_TEMP));
  settings->filter = (uint8_t)(BME280_GET_BITS(reg_data[3], BME280_FILTER));
}


void write_power_mode(uint8_t sensor_mode)
{
  // This internal API writes the power mode in the sensor.
  uint8_t reg_addr = BME280_PWR_CTRL_ADDR;

  // Variable to store the value read from power mode register
  uint8_t sensor_mode_reg_val;

  // Read the power mode register
  bme280_get_regs(reg_addr, &sensor_mode_reg_val, 1);

  // Set the power mode
  sensor_mode_reg_val = (uint8_t)(BME280_SET_BITS_POS_0(sensor_mode_reg_val, BME280_SENSOR_MODE, sensor_mode));

  // Write the power mode in the register
  bme280_set_regs(&reg_addr, &sensor_mode_reg_val);
}


void put_device_to_sleep(void)
{
  // This internal API puts the device to sleep mode.
  uint8_t reg_data[4];
  struct bme280_settings settings;

  // Get existing device settings
  bme280_get_regs(BME280_CTRL_HUM_ADDR, reg_data, 4);
  parse_device_settings(reg_data, &settings);
    
  // Perform soft reset
  bme280_soft_reset();

  // Reload device settings into sensor
  set_osr_settings(BME280_ALL_SETTINGS_SEL, &settings);
  set_filter_standby_settings(BME280_ALL_SETTINGS_SEL, &settings);
}


int32_t compensate_temperature(const struct bme280_uncomp_data *uncomp_data,
                               struct bme280_calib_data *calib_data)
{
  // This internal API is used to compensate the raw temperature data and return
  // the compensated temperature data in integer data type. Temperature is in
  // DegC, resolution is 0.01 DegC. Example: Output value of “5123” equals 51.23
  // DegC.
  // See "BME280 – Data sheet Revision 1.6 September 2018" section 8.2
  int32_t var1;
  int32_t var2;
  int32_t temperature;
  int32_t temperature_min = -4000;
  int32_t temperature_max = 8500;

  var1 = (int32_t)((uncomp_data->temperature / 8) - ((int32_t)calib_data->dig_t1 * 2));
  var1 = (var1 * ((int32_t)calib_data->dig_t2)) / 2048;
  var2 = (int32_t)((uncomp_data->temperature / 16) - ((int32_t)calib_data->dig_t1));
  var2 = (((var2 * var2) / 4096) * ((int32_t)calib_data->dig_t3)) / 16384;
  calib_data->t_fine = var1 + var2;
  temperature = (calib_data->t_fine * 5 + 128) / 256;

  if (temperature < temperature_min) temperature = temperature_min;
  else if (temperature > temperature_max) temperature = temperature_max;

  return temperature;
}


uint32_t compensate_pressure(const struct bme280_uncomp_data *uncomp_data,
                             const struct bme280_calib_data *calib_data)
{
  // This internal API is used to compensate the raw pressure data and return
  // the compensated pressure data in integer data type. Uses 32-bit integer
  // arithmatic.
  // Returns pressure in Pa as unsigned 32 bit integer. Example: An output
  // value of “96386” equals 96386 Pa = 963.86 hPa
  int32_t var1;
  int32_t var2;
  int32_t var3;
  int32_t var4;
  uint32_t var5;
  uint32_t pressure;
  uint32_t pressure_min = 30000;
  uint32_t pressure_max = 110000;

  // 32-bit compensation
  var1 = (((int32_t)calib_data->t_fine) / 2) - (int32_t)64000;
  var2 = (((var1 / 4) * (var1 / 4)) / 2048) * ((int32_t)calib_data->dig_p6);
  var2 = (var2 + ((var1 * ((int32_t)calib_data->dig_p5)) * 2));
  var2 = (var2 / 4) + (((int32_t)calib_data->dig_p4) * 65536);
  var3 = (calib_data->dig_p3 * (((var1 / 4) * (var1 / 4)) / 8192)) / 8;
  var4 = (((int32_t)calib_data->dig_p2) * var1) / 2;
  var1 = (var3 + var4) / 262144;
  var1 = (((32768 + var1)) * ((int32_t)calib_data->dig_p1)) / 32768;

  // Avoid exception caused by division by zero
  if (var1)
  {
    var5 = (uint32_t)((uint32_t)1048576) - uncomp_data->pressure;
    pressure = ((uint32_t)(var5 - (uint32_t)(var2 / 4096))) * 3125;
	
    if (pressure < 0x80000000) pressure = (pressure << 1) / ((uint32_t)var1);
    else pressure = (pressure / (uint32_t)var1) * 2;

    var1 = (((int32_t)calib_data->dig_p9) * ((int32_t)(((pressure / 8) * (pressure / 8)) / 8192))) / 4096;
    var2 = (((int32_t)(pressure / 4)) * ((int32_t)calib_data->dig_p8)) / 8192;
    pressure = (uint32_t)((int32_t)pressure + ((var1 + var2 + calib_data->dig_p7) / 16));

    if (pressure < pressure_min) pressure = pressure_min;
    else if (pressure > pressure_max) pressure = pressure_max;
  }
  else pressure = pressure_min;

  return pressure;
}


uint32_t compensate_humidity(const struct bme280_uncomp_data *uncomp_data,
                             const struct bme280_calib_data *calib_data)
{
  // This internal API is used to compensate the raw humidity data and
  // return the compensated humidity data in integer data type.
  int32_t var1;
  int32_t var2;
  int32_t var3;
  int32_t var4;
  int32_t var5;
  uint32_t humidity;
  uint32_t humidity_max = 102400;

  var1 = calib_data->t_fine - ((int32_t)76800);
  var2 = (int32_t)(uncomp_data->humidity * 16384);
  var3 = (int32_t)(((int32_t)calib_data->dig_h4) * 1048576);
  var4 = ((int32_t)calib_data->dig_h5) * var1;
  var5 = (((var2 - var3) - var4) + (int32_t)16384) / 32768;
  var2 = (var1 * ((int32_t)calib_data->dig_h6)) / 1024;
  var3 = (var1 * ((int32_t)calib_data->dig_h3)) / 2048;
  var4 = ((var2 * (var3 + (int32_t)32768)) / 1024) + (int32_t)2097152;
  var2 = ((var4 * ((int32_t)calib_data->dig_h2)) + 8192) / 16384;
  var3 = var5 * var2;
  var4 = ((var3 / 32768) * (var3 / 32768)) / 128;
  var5 = var3 - ((var4 * ((int32_t)calib_data->dig_h1)) / 16);
  var5 = (var5 < 0 ? 0 : var5);
  var5 = (var5 > 419430400 ? 419430400 : var5);
  humidity = (uint32_t)(var5 / 4096);

  if (humidity > humidity_max) humidity = humidity_max;

  return humidity;
}


void get_calib_data(struct bme280_dev *dev)
{
  // This internal API reads the calibration data from the sensor, parse
  // it and store in the device structure.
  uint8_t reg_addr;
  // Array to store calibration data
  uint8_t calib_data[BME280_TEMP_PRESS_CALIB_DATA_LEN] = { 0 };

  // Read the calibration data from the sensor
  reg_addr = BME280_TEMP_PRESS_CALIB_DATA_ADDR;
  bme280_get_regs(reg_addr, calib_data, BME280_TEMP_PRESS_CALIB_DATA_LEN);

  // Parse temperature and pressure calibration data and store
  // it in device structure
  parse_temp_press_calib_data(calib_data, dev);
    
  // Read the humidity calibration data from the sensor
  reg_addr = BME280_HUMIDITY_CALIB_DATA_ADDR;
  bme280_get_regs(reg_addr, calib_data, BME280_HUMIDITY_CALIB_DATA_LEN);

  // Parse humidity calibration data and store it in
  // device structure
  parse_humidity_calib_data(calib_data, dev);
}


void parse_temp_press_calib_data(const uint8_t *reg_data, struct bme280_dev *dev)
{
  // This internal API is used to parse the temperature and
  //  pressure calibration data and store it in device structure.
    
  struct bme280_calib_data *calib_data = &dev->calib_data;

  calib_data->dig_t1 = BME280_CONCAT_BYTES(reg_data[1], reg_data[0]);
  calib_data->dig_t2 = (int16_t)BME280_CONCAT_BYTES(reg_data[3], reg_data[2]);
  calib_data->dig_t3 = (int16_t)BME280_CONCAT_BYTES(reg_data[5], reg_data[4]);
  calib_data->dig_p1 = BME280_CONCAT_BYTES(reg_data[7], reg_data[6]);
  calib_data->dig_p2 = (int16_t)BME280_CONCAT_BYTES(reg_data[9], reg_data[8]);
  calib_data->dig_p3 = (int16_t)BME280_CONCAT_BYTES(reg_data[11], reg_data[10]);
  calib_data->dig_p4 = (int16_t)BME280_CONCAT_BYTES(reg_data[13], reg_data[12]);
  calib_data->dig_p5 = (int16_t)BME280_CONCAT_BYTES(reg_data[15], reg_data[14]);
  calib_data->dig_p6 = (int16_t)BME280_CONCAT_BYTES(reg_data[17], reg_data[16]);
  calib_data->dig_p7 = (int16_t)BME280_CONCAT_BYTES(reg_data[19], reg_data[18]);
  calib_data->dig_p8 = (int16_t)BME280_CONCAT_BYTES(reg_data[21], reg_data[20]);
  calib_data->dig_p9 = (int16_t)BME280_CONCAT_BYTES(reg_data[23], reg_data[22]);
  calib_data->dig_h1 = reg_data[25];
}


void parse_humidity_calib_data(const uint8_t *reg_data, struct bme280_dev *dev)
{
  // This internal API is used to parse the humidity calibration data
  // and store it in device structure.
    
  struct bme280_calib_data *calib_data = &dev->calib_data;
  int16_t dig_h4_lsb;
  int16_t dig_h4_msb;
  int16_t dig_h5_lsb;
  int16_t dig_h5_msb;

  calib_data->dig_h2 = (int16_t)BME280_CONCAT_BYTES(reg_data[1], reg_data[0]);
  calib_data->dig_h3 = reg_data[2];
  dig_h4_msb = (int16_t)(int8_t)reg_data[3] * 16;
  dig_h4_lsb = (int16_t)(reg_data[4] & 0x0F);
  calib_data->dig_h4 = dig_h4_msb | dig_h4_lsb;
  dig_h5_msb = (int16_t)(int8_t)reg_data[5] * 16;
  dig_h5_lsb = (int16_t)(reg_data[4] >> 4);
  calib_data->dig_h5 = dig_h5_msb | dig_h5_lsb;
  calib_data->dig_h6 = (int8_t)reg_data[6];
}


void user_i2c_read(uint8_t reg_addr, uint8_t *data, uint32_t len)
{
  // This function reads the sensor's registers through I2C bus.
  
  int i;
  i = 0;

  // Send Control Bytes
  prep_read(BME280_I2C_ADDR_PRIM_WR, BME280_I2C_ADDR_PRIM_RD, reg_addr, 1);

  // Read Data
  if (len > 1) {
    for (i = 0; i < (len - 1); i++) {
      data[i] = I2C_read_byte(0);
    }
  }
  data[i] = I2C_read_byte(1);
}


void user_i2c_write(uint8_t reg_addr, const uint8_t *data, uint32_t len)
{
  // This function for writing the sensor's registers through I2C bus.
  int i;
    
  // The BME280 does not auto increment write addresses. Registers are
  // one byte wide. If multiple registers are written (as indicated by the
  // len variable) then each must be preceded on the I2C bus by its
  // address.
    
  // Send Write Control Byte
  I2C_control(BME280_I2C_ADDR_PRIM_WR);

  // Send Data
  for (i = 0; i < len; i++) {
    I2C_byte_address(reg_addr++, 1);
    I2C_write_byte(*data);
    data++;
  }
  I2C_stop();
}


/*
#if DEBUG_SUPPORT == 7 || DEBUG_SUPPORT == 15
void print_sensor_data(struct bme280_data *comp_data)
{
  // KEEP THIS CODE FOR FUTURE DEVELOPMENT
  // This API is used to print the sensor temperature, pressure and humidity
  // data on the debug UART.
  
  int32_t temp_whole;
  int32_t temp_dec;
  int32_t press_whole;
  int32_t hum_whole;
  
  // Temperature range is -40 to +85C
  // Temperature value in the comp_data will be a fixed point signed
  // integer.
  // Examples:
  //   A value of 5632 (0x00001600) is DegC 56.32.
  //   A value of -5632 (0xffffea00) is DegC -56.32.
  //   Always 2 decimal digits.
  //
  // Over-rides for test
  // comp_data->temperature = 0x00001600;
  // comp_data->temperature = comp_data->temperature * -1;
  temp_whole = (comp_data->temperature / 100);
  // Calculate decimal part of number
  temp_dec = comp_data->temperature - (temp_whole * 100);
  // Handle negative temperatures
  if (comp_data->temperature < 0) {
    temp_whole = temp_whole * -1;
    temp_dec = temp_dec * -1;
  }
  UARTPrintf("T ");
  if (comp_data->temperature < 0)
    UARTPrintf("-");
  emb_itoa(temp_whole, OctetArray, 10, 3);
  UARTPrintf(OctetArray);
  UARTPrintf(".");
  emb_itoa(temp_dec, OctetArray, 10, 2);
  UARTPrintf(OctetArray);
    
  // Pressure range is 300 to 1100 hPa.
//  press_whole = altitude_adjustment(comp_data);
  press_whole = altitude_adjustment();
  UARTPrintf(" P ");
  emb_itoa(press_whole, OctetArray, 10, 5);
  UARTPrintf(OctetArray);
  
  // Humidity range is 0 to 100 percent.
  hum_whole = comp_data->humidity / 1024;
  UARTPrintf(" H ");
  emb_itoa(hum_whole, OctetArray, 10, 3);
  UARTPrintf(OctetArray);
  
  // Altitude entered by user.
  UARTPrintf(" A ");
  // Handle negative temperatures
  temp_whole = stored_altitude;
  if (stored_altitude < 0) {
    temp_whole = stored_altitude * -1;
    UARTPrintf("-");
  }
  emb_itoa(stored_altitude, OctetArray, 10, 5);
  UARTPrintf(OctetArray);
  UARTPrintf("\r\n");    
}
#endif // DEBUG_SUPPORT == 7 || DEBUG_SUPPORT == 15
*/


int32_t altitude_adjustment(void)
{
  // This function combines altitude with the BME280 pressure measurement to
  // arrive at barometric pressure.
  //
  // Barometric Pressure range is 300 to 1100 hPa.
  // The BME280 pressure output reading must be corrected for altitude to give
  // a good local reading for barometric pressure. Air pressure drops
  // exponentially as altitude increases. To calculate the air pressure drop
  // due to altitude using only integers (no floats), an approximation of the
  // correction to barometric pressure due to altitude is performed by using a
  // table of standard pressure value (in hPa) at 1000 foot intervals starting
  // at -1000 feet.
  //
  // The bar_table[] used below contains data for standard pressure from -1000
  // feet to 20000 feet. The calculations create a reasonable approximation of
  // the barometric pressure at any altitude within the -1000 to 20000 foot
  // range.
  //
  // Altitudes below -1000 feet or above 20000 feet will have an exponentially
  // increasing error in the barometric pressure displayed.
  //
  // The standard air pressure at each altitude was obtained using this
  // webiste:
  // https://www.mide.com/air-pressure-at-altitude-calculator
  // An example calculation:
  //   Standard air pressure at 1000 feet is found to be 977 hPa
  //   Standard air pressure at 2000 feet is found to be 942 hPa
  //   The difference is 977 - 942 = 35 hPa
  //   The pressure change per foot between 1000 and 2000 feet is estimated
  //   as 35 / 1000 = 0.035 hPa
  //   This value allows the standard air pressure at any given altitude
  //   between 1000 and 2000 feet to be calculated. That pressure is then
  //   subtracted from the standard air pressure at sea level (1013 hPa),
  //   creating an offset that is added to the air pressure reported by the
  //   BME280, resulting in a close approximation of the barometric pressure
  //   at the altitude that the user specified as the altitude of the BME280.

  int32_t Bpressure;

  // Altitude =          -1k   0     1k   2k   3k   4k   5k   6k   7k   8k   9k   10k  11k  12k  13k  14k
  int16_t bar_table[] = {1050, 1013, 977, 942, 908, 875, 843, 812, 782, 753, 724, 697, 670, 644, 619, 595, 572, 549, 527, 506, 485, 466};
  int16_t offset;
  int i;
  int j;
  int k;

  offset = 0;
    
  for (i = 19; i > -2; i--) {
    j = i * 1000;
    k = bar_table[i+1] - bar_table[i+2];
    if (i == -1) k = k * -1;
    if (stored_altitude > j) {
      offset = 1013 - (bar_table[i+1] - (((stored_altitude - j) * k) / 1000));
      break;
    }
  }
  
  Bpressure = (comp_data_pressure / 100) + (offset);
  
  return Bpressure;
}


void stream_sensor_data_forced_mode(struct bme280_dev *dev, struct bme280_data *comp_data)
{
  // This API reads the sensor temperature, pressure and humidity data in forced mode.
    
  uint8_t status_reg;       // Variable to contain status_reg
  uint32_t status_reg_TO;   // Variable to contain status_reg timeout
  uint8_t settings_sel;     // Variable to define the selecting sensors


  // Recommended mode of operation: Indoor navigation
  dev->settings.osr_h = BME280_OVERSAMPLING_1X;
  dev->settings.osr_p = BME280_OVERSAMPLING_16X;
  dev->settings.osr_t = BME280_OVERSAMPLING_2X;
  dev->settings.filter = BME280_FILTER_COEFF_16;

  // Set the sensor settings
  settings_sel = BME280_FMODE_SETTINGS_SEL;
  bme280_set_sensor_settings(settings_sel, dev);

  // Collect one set of data
  while (1)
  {
    // Set the sensor to forced mode. This starts a measurement.
    bme280_set_sensor_mode(BME280_FORCED_MODE, dev);

    // Wait for the measurement to complete then collect data.
    status_reg_TO = 0;
    while (1) {
      // Comment: The time spent waiting for the measurement to complete is
      // about 30ms (determined experimentally). The Bosch spec section 9.1
      // "Measurement Time" has a formula that indicates the maximum measure-
      // ment time is 46.1ms with these over-sampling settings:
      //   dev->settings.osr_h = BME280_OVERSAMPLING_1X;
      //   dev->settings.osr_p = BME280_OVERSAMPLING_16X;
      //   dev->settings.osr_t = BME280_OVERSAMPLING_2X;
      wait_timer(2000); // Cause read every 2 ms
      IWDG_KR = 0xaa;   // Prevent the IWDG hardware watchdog from firing.
      status_reg_TO += 2000; // Keep track of wait time
      // Read the status_reg to determine if measurement is complete.
      bme280_get_regs(BME280_STATUS_REG_ADDR, &status_reg, 1);
      if ((status_reg & 0x08) == 0) {
        // Conversion complete
        break;
      }
      if (status_reg_TO > 200000) {
        // Wait a maximum of 200ms then break to prevent getting stuck here
        break;
      }
    }

    bme280_get_sensor_data(comp_data, dev);
    break;
  } // end of while loop
}

#endif // BME280_SUPPORT == 1
