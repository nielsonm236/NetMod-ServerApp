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
* @file       bme280.h
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


// filename bme280.h
// Sensor driver for BME280 sensor


// BME280
// see https://www.bosch-sensortec.com/bst/products/all_products/bme280
// and https://github.com/BoschSensortec/BME280_driver

#ifndef BME280_H_
#define BME280_H_

#include "bme280_defs.h"


// This internal API puts the device to sleep mode.
void put_device_to_sleep(void);


// This internal API writes the power mode in the sensor.
// sensor_mode : Variable which contains the power mode to be set.
void write_power_mode(uint8_t sensor_mode);


// This internal API reads the calibration data from the sensor, parse it and
// store in the device structure.
// dev : Structure instance of bme280_dev.
void get_calib_data(struct bme280_dev *dev);


// This internal API is used to parse the temperature and pressure calibration
// data and store it in the device structure.
// dev      : Structure instance of bme280_dev to store the calib data.
// reg_data : Contains the calibration data to be parsed.
void parse_temp_press_calib_data(const uint8_t *reg_data, struct bme280_dev *dev);


// This internal API is used to parse the humidity calibration data and store
// it in device structure.
// dev      : Structure instance of bme280_dev to store the calib data.
// reg_data : Contains calibration data to be parsed.
void parse_humidity_calib_data(const uint8_t *reg_data, struct bme280_dev *dev);


// This internal API is used to compensate the raw temperature data and return
// the compensated temperature data in integer data type.
// uncomp_data : Contains the uncompensated temperature data.
// calib_data  : Pointer to calibration data structure.
//
// return Compensated temperature data in integer.
int32_t compensate_temperature(const struct bme280_uncomp_data *uncomp_data,
                               struct bme280_calib_data *calib_data);


// This internal API is used to compensate the raw pressure data and return
// the compensated pressure data in integer data type.
// uncomp_data : Contains the uncompensated pressure data.
// calib_data  : Pointer to the calibration data structure.
//
// return Compensated pressure data in integer.
uint32_t compensate_pressure(const struct bme280_uncomp_data *uncomp_data,
                             const struct bme280_calib_data *calib_data);


// This internal API is used to compensate the raw humidity data and return
// the compensated humidity data in integer data type.
// uncomp_data : Contains the uncompensated humidity data.
// calib_data  : Pointer to the calibration data structure.
//
// return Compensated humidity data in integer.
uint32_t compensate_humidity(const struct bme280_uncomp_data *uncomp_data,
                                    const struct bme280_calib_data *calib_data);


// This API sets the humidity over sampling settings of the sensor.
// settings : Pointer variable which contains the settings to be set in the
//            sensor.
void set_osr_humidity_settings(const struct bme280_settings *settings);


// This internal API sets the oversampling settings for pressure, temperature
// and humidity in the sensor.
// desired_settings : Variable used to select the settings which are to be
//                    set.
// settings         : Pointer variable which contains the settings to be set
//                    in the sensor.
void set_osr_settings(uint8_t desired_settings, const struct bme280_settings *settings);


// This API sets the pressure and/or temperature oversampling settings in the
// sensor according to the settings selected by the user.
// desired_settings : Variable to select the pressure and/or temperature
//                    oversampling settings.
// settings         : Pointer variable which contains the settings to be set
//                    in the sensor.
void set_osr_press_temp_settings(uint8_t desired_settings,
                                 const struct bme280_settings *settings);


// This internal API fills the pressure oversampling settings provided by the
// user in the data buffer so as to write in the sensor.
// settings : Pointer variable which contains the settings to be set in the
//            sensor.
// reg_data : Variable which is filled according to the pressure oversampling
//            data provided by the user.
static void fill_osr_press_settings(uint8_t *reg_data, const struct bme280_settings *settings);


// This internal API fills the temperature oversampling settings provided by
// the user in the data buffer so as to write in the sensor.
// settings : Pointer variable which contains the settings to be set in the
//            sensor.
// reg_data : Variable which is filled according to the temperature
//            oversampling data provided by the user.
static void fill_osr_temp_settings(uint8_t *reg_data, const struct bme280_settings *settings);


// This internal API sets the filter settings in the sensor according to the
// settings selected by the user.
// settings : Pointer variable which contains the settings to be set in the
//            sensor.
// settings : Structure instance of bme280_settings.
void set_filter_standby_settings(uint8_t desired_settings,
                                 const struct bme280_settings *settings);


// This internal API fills the filter settings provided by the user in the
// data buffer so as to write in the sensor.
// settings : Pointer variable which contains the settings to be set in the
//            sensor.
// reg_data : Variable which is filled according to the filter settings data
//            provided by the user.
void fill_filter_settings(uint8_t *reg_data, const struct bme280_settings *settings);


// This internal API parse the oversampling(pressure, temperature and
// humidity) and filter settings and stores them in the device structure.
// settings : Pointer variable which contains the settings to be get in the
//            sensor.
// reg_data : Register data to be parsed.
void parse_device_settings(const uint8_t *reg_data, struct bme280_settings *settings);


// This API reads the chip-id of the sensor and if successful will calibrate
// the sensor. As this API is the entry point, call this API before using other APIs.
// dev : Structure instance of bme280_dev
//
// return Result of API execution status.
// retval   0 -> Success.
// retval > 0 -> Warning.
// retval < 0 -> Fail.
int8_t bme280_init(struct bme280_dev *dev);


// This API writes the given data to the register address of the sensor
// reg_addr : Register addresses to where the data is to be written
// reg_data : Pointer to data buffer which is to be written in the reg_addr of
// sensor.
void bme280_set_regs(uint8_t *reg_addr, const uint8_t *reg_data);


// This API reads the data from the given register address of sensor.
// reg_addr : Register address from where the data to be read
// reg_data : Pointer to data buffer to store the read data.
// len      : No of bytes of data to be read.
void bme280_get_regs(uint8_t reg_addr, uint8_t *reg_data, uint16_t len);


// This API sets the oversampling and filter settings in the sensor.
// dev              : Structure instance of bme280_dev.
// desired_settings : Variable used to select the settings which are to be set
//                    in the sensor.
//
// Note : Below are the macros to be used by the user for selecting the
// desired settings. User can do OR operation of these macros for configuring
// multiple settings.
//
// Macros                 |   Functionality
// -----------------------|----------------------------------------------
// BME280_OSR_PRESS_SEL   |   To set pressure oversampling.
// BME280_OSR_TEMP_SEL    |   To set temperature oversampling.
// BME280_OSR_HUM_SEL     |   To set humidity oversampling.
// BME280_FILTER_SEL      |   To set filter setting.
// BME280_STANDBY_SEL     |   To set standby duration setting.
void bme280_set_sensor_settings(uint8_t desired_settings, struct bme280_dev *dev);


// This API gets the oversampling, filter and standby duration (normal mode)
// settings from the sensor.
// dev : Structure instance of bme280_dev.
void bme280_get_sensor_settings(struct bme280_dev *dev);


// This API sets the power mode of the sensor.
// dev         : Structure instance of bme280_dev.
// sensor_mode : Variable which contains the power mode to be set.
//
//    sensor_mode       |   Macros
// ---------------------|-------------------
//     0                | BME280_SLEEP_MODE
//     1                | BME280_FORCED_MODE
//     3                | BME280_NORMAL_MODE
void bme280_set_sensor_mode(uint8_t sensor_mode, struct bme280_dev *dev);


// This API gets the power mode of the sensor.
// sensor_mode : Pointer variable to store the power mode.
//
//   sensor_mode        |   Macros
// ---------------------|-------------------
//     0                | BME280_SLEEP_MODE
//     1                | BME280_FORCED_MODE
//     3                | BME280_NORMAL_MODE
void bme280_get_sensor_mode(uint8_t *sensor_mode);


// This API soft-resets the sensor.
void bme280_soft_reset(void);


// This API reads the pressure, temperature and humidity data from the sensor,
// compensates the data and store it in the bme280_data structure instance
// passed by the user.
// comp_data   : Structure instance of bme280_data.
// dev         : Structure instance of bme280_dev.
void bme280_get_sensor_data(struct bme280_data *comp_data, struct bme280_dev *dev);


// This API is used to parse the pressure, temperature and humidity data and
// store it in the bme280_uncomp_data structure instance.
// reg_data    : Contains register data which needs to be parsed
// uncomp_data : Contains the uncompensated pressure, temperature and humidity
//               data.
void bme280_parse_sensor_data(const uint8_t *reg_data, struct bme280_uncomp_data *uncomp_data);


// This API is used to compensate the pressure and/or temperature and/or
// humidity data according to the component selected by the user.
// uncomp_data : Contains the uncompensated pressure, temperature and humidity
//               data.
// comp_data   : Contains the compensated pressure and/or temperature and/or
//               humidity data.
// calib_data  : Pointer to the calibration data structure.
void bme280_compensate_data(const struct bme280_uncomp_data *uncomp_data,
                            struct bme280_data *comp_data,
                            struct bme280_calib_data *calib_data);


// Function to print the temperature, humidity and pressure data.
// comp_data   : Contains the compensated pressure and/or temperature and/or
//               humidity data.
void print_sensor_data(struct bme280_data *comp_data);


// Function to read the sensor's registers through I2C bus.
// reg_addr : Register address.
// data     : Pointer to the data buffer to store the read data.
// len      : No of bytes to read.
void user_i2c_read(uint8_t reg_addr, uint8_t *data, uint32_t len);


// Function for writing the sensor's registers through I2C bus.
// reg_addr       : Register address.
// data           : Pointer to the data buffer whose value is to be written.
// len            : No of bytes to write.
void user_i2c_write(uint8_t reg_addr, const uint8_t *data, uint32_t len);


// Function to read temperature, humidity and pressure data in forced mode.
// dev       : Structure instance of bme280_dev.
// comp_data : Contains the compensated pressure and/or temperature and/or
//             humidity data.
void stream_sensor_data_forced_mode(struct bme280_dev *dev, struct bme280_data *comp_data);


// Function to combine altitude with the BME280 pressure measurment to arrive
// at barometric pressure.
// return Barometric Pressure
int32_t altitude_adjustment(void);


// Function used to copy calib_data to I2C EEPROM for later transfer to RAM
// RAM in Runtime code.
void copy_calib_data_to_I2C(struct bme280_calib_data *calib_data);


// Function used to transfer the BME280_found value and the calib_data from
// I2C EEPROM to RAM for use by the Runtime code.
void copy_I2C_calib_data_to_RAM(struct bme280_dev *dev);


void BME280_temperature_string_C(void);
void BME280_pressure_string(void);
void BME280_humidity_string(void);


#endif // BME280_H_
