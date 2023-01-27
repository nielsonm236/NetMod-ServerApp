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
* @file       bme280_defs.h
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


#ifndef BME280_DEFS_H_
#define BME280_DEFS_H_

// header includes
// #include <stdint.h>
// #include <stddef.h>


/********************************************************/
/*                     Common macros                    */
/********************************************************/

// #if !defined(UINT8_C) && !defined(INT8_C)
// #define INT8_C(x)    S8_C(x)
// #define UINT8_C(x)   U8_C(x)
// #endif

// #if !defined(UINT16_C) && !defined(INT16_C)
// #define INT16_C(x)   S16_C(x)
// #define UINT16_C(x)  U16_C(x)
// #endif

// #if !defined(INT32_C) && !defined(UINT32_C)
// #define INT32_C(x)   S32_C(x)
// #define UINT32_C(x)  U32_C(x)
// #endif

// #if !defined(INT64_C) && !defined(UINT64_C)
// #define INT64_C(x)   S64_C(x)
// #define UINT64_C(x)  U64_C(x)
// #endif

// C standard macros
// #ifndef NULL
// #define NULL   ((void *) 0)
// #endif


// #ifndef TRUE
// #define TRUE    UINT8_C(1)
// #endif
// #ifndef FALSE
// #define FALSE   UINT8_C(0)
// #endif


// I2C addresses
#define BME280_I2C_ADDR_PRIM                      0x76

// I2C PRIM write and read bytes
#define BME280_I2C_ADDR_PRIM_WR                   0xec
#define BME280_I2C_ADDR_PRIM_RD                   0xed

// BME280 chip identifier
#define BME280_CHIP_ID                            0x60

// Register Address
#define BME280_CHIP_ID_ADDR                       0xD0
#define BME280_RESET_ADDR                         0xE0
#define BME280_TEMP_PRESS_CALIB_DATA_ADDR         0x88
#define BME280_HUMIDITY_CALIB_DATA_ADDR           0xE1
#define BME280_PWR_CTRL_ADDR                      0xF4
#define BME280_CTRL_HUM_ADDR                      0xF2
#define BME280_CTRL_MEAS_ADDR                     0xF4
#define BME280_CONFIG_ADDR                        0xF5
#define BME280_DATA_ADDR                          0xF7

// API success code
#define BME280_OK                                 INT8_C(0)

// API error codes
// #define BME280_E_NULL_PTR                      INT8_C(-1)
#define BME280_E_DEV_NOT_FOUND                    INT8_C(-2)
// #define BME280_E_INVALID_LEN                   INT8_C(-3)
// #define BME280_E_COMM_FAIL                     INT8_C(-4)
// #define BME280_E_SLEEP_MODE_FAIL               INT8_C(-5)
// #define BME280_E_NVM_COPY_FAILED               INT8_C(-6)

// API warning codes
// #define BME280_W_INVALID_OSR_MACRO             INT8_C(1)

// Macros related to size
#define BME280_TEMP_PRESS_CALIB_DATA_LEN          UINT8_C(26)
#define BME280_HUMIDITY_CALIB_DATA_LEN            UINT8_C(7)
#define BME280_ALL_CALIB_DATA_LEN                 UINT8_C(33)
#define BME280_P_T_H_DATA_LEN                     UINT8_C(8)

// Sensor power modes
#define BME280_SLEEP_MODE                         UINT8_C(0x00)
#define BME280_FORCED_MODE                        UINT8_C(0x01)
// #define BME280_NORMAL_MODE                        UINT8_C(0x03)

// Macro to combine two 8 bit data's to form a 16 bit data
#define BME280_CONCAT_BYTES(msb, lsb)             (((uint16_t)msb << 8) | (uint16_t)lsb)



// Example usage of the BME280_SET_BITS macro:
// If the macro is called with bitname = BME280_CTRL_PRESS the macro will
// a) mask "reg_data" with the inverse of BME280_CTRL_PRESS_MSK (masking off
//    the location of the osr bits)
// b) shift the "data" value left by the BME280_CTRL_PRESS_POS and mask the
//    result in data with BME280_CTRL_PRESS_MSK
// c) returns a | b in "reg_data"
#define BME280_SET_BITS(reg_data, bitname, data)	((reg_data & ~(bitname##_MSK)) | \
							((data << bitname##_POS) & bitname##_MSK))

// BME280_SET_BITS_POS_0 does the same thing as BME280_SET_BITS except it is
// designed to work only with the two least significant bits of a byte, thus
// it is called only with bitname = BME280_SENSOR_MODE
#define BME280_SET_BITS_POS_0(reg_data, bitname, data)	((reg_data & ~(bitname##_MSK)) | \
							(data & bitname##_MSK))

// BME280_GET_BITS uses mask values similar to BME280_SET_BITS except the
// purpose is to return sensor mode, osr, filter, and standby_time values at
// the location spcified by reg_data
#define BME280_GET_BITS(reg_data, bitname)		((reg_data & (bitname##_MSK)) >> \
							(bitname##_POS))
							
// BME280_GET_BITS_POS_0 works the same way as BME280_GET_BITS except it is
// specific to working with the two least significant bits of a byte.
#define BME280_GET_BITS_POS_0(reg_data, bitname)	(reg_data & (bitname##_MSK))

// Defines for bit masking
#define BME280_SENSOR_MODE_MSK                    UINT8_C(0x03)
#define BME280_SENSOR_MODE_POS                    UINT8_C(0x00)

#define BME280_CTRL_HUM_MSK                       UINT8_C(0x07)
#define BME280_CTRL_HUM_POS                       UINT8_C(0x00)

#define BME280_CTRL_PRESS_MSK                     UINT8_C(0x1C)
#define BME280_CTRL_PRESS_POS                     UINT8_C(0x02)

#define BME280_CTRL_TEMP_MSK                      UINT8_C(0xE0)
#define BME280_CTRL_TEMP_POS                      UINT8_C(0x05)

#define BME280_FILTER_MSK                         UINT8_C(0x1C)
#define BME280_FILTER_POS                         UINT8_C(0x02)

// #define BME280_STANDBY_MSK                        UINT8_C(0xE0)
// #define BME280_STANDBY_POS                        UINT8_C(0x05)

// Sensor component selection macros
// These values are internal for API implementation. Don't relate this to
// data sheet.
#define BME280_PRESS                              UINT8_C(1)
#define BME280_TEMP                               UINT8_C(1 << 1)
#define BME280_HUM                                UINT8_C(1 << 2)
#define BME280_ALL                                UINT8_C(0x07)

// Settings selection macros
#define BME280_OSR_PRESS_SEL                      UINT8_C(1)
#define BME280_OSR_TEMP_SEL                       UINT8_C(1 << 1)
#define BME280_OSR_HUM_SEL                        UINT8_C(1 << 2)
#define BME280_FILTER_SEL                         UINT8_C(1 << 3)
// #define BME280_STANDBY_SEL                        UINT8_C(1 << 4)
#define BME280_ALL_SETTINGS_SEL                   UINT8_C(0x1F)
#define BME280_FMODE_SETTINGS_SEL                 UINT8_C(0x0F)

// Oversampling macros
// #define BME280_NO_OVERSAMPLING                    UINT8_C(0x00)
#define BME280_OVERSAMPLING_1X                    UINT8_C(0x01)
#define BME280_OVERSAMPLING_2X                    UINT8_C(0x02)
// #define BME280_OVERSAMPLING_4X                    UINT8_C(0x03)
// #define BME280_OVERSAMPLING_8X                    UINT8_C(0x04)
#define BME280_OVERSAMPLING_16X                   UINT8_C(0x05)

// Measurement delay calculation macros
// These aren't used in this application
// #define BME280_MEAS_OFFSET                        UINT16_C(1250)
// #define BME280_MEAS_DUR                           UINT16_C(2300)
// #define BME280_PRES_HUM_MEAS_OFFSET               UINT16_C(575)
// #define BME280_MEAS_SCALING_FACTOR                UINT16_C(1000)

// Standby duration selection macros
// These aren't used in this application
// #define BME280_STANDBY_TIME_0_5_MS                (0x00)
// #define BME280_STANDBY_TIME_62_5_MS               (0x01)
// #define BME280_STANDBY_TIME_125_MS                (0x02)
// #define BME280_STANDBY_TIME_250_MS                (0x03)
// #define BME280_STANDBY_TIME_500_MS                (0x04)
// #define BME280_STANDBY_TIME_1000_MS               (0x05)
// #define BME280_STANDBY_TIME_10_MS                 (0x06)
// #define BME280_STANDBY_TIME_20_MS                 (0x07)

// Filter coefficient selection macros
// I ONLY SEE BME280_FILTER_COEFF_16 USED
// #define BME280_FILTER_COEFF_OFF                   (0x00)
// #define BME280_FILTER_COEFF_2                     (0x01)
// #define BME280_FILTER_COEFF_4                     (0x02)
// #define BME280_FILTER_COEFF_8                     (0x03)
#define BME280_FILTER_COEFF_16                    (0x04)

#define BME280_STATUS_REG_ADDR                    (0xF3)
#define BME280_SOFT_RESET_COMMAND                 (0xB6)
#define BME280_STATUS_IM_UPDATE                   (0x01)


// Calibration data
// 37 bytes
struct bme280_calib_data
{
    // Calibration coefficients for the temperature sensor
    uint16_t dig_t1;
    int16_t dig_t2;
    int16_t dig_t3;

    // Calibration coefficients for the pressure sensor
    uint16_t dig_p1;
    int16_t dig_p2;
    int16_t dig_p3;
    int16_t dig_p4;
    int16_t dig_p5;
    int16_t dig_p6;
    int16_t dig_p7;
    int16_t dig_p8;
    int16_t dig_p9;

    // Calibration coefficients for the humidity sensor
    uint8_t dig_h1;
    int16_t dig_h2;
    uint8_t dig_h3;
    int16_t dig_h4;
    int16_t dig_h5;
    int8_t dig_h6;

    // Variable to store the intermediate temperature coefficient
    int32_t t_fine;
};

// bme280 sensor structure which comprises of temperature, pressure and
// humidity data
// 12 bytes
struct bme280_data
{
    uint32_t pressure;   // Compensated pressure
    int32_t temperature; // Compensated temperature
    uint32_t humidity;   // Compensated humidity
};


// bme280 sensor structure which comprises of uncompensated temperature,
// pressure and humidity data
// 12 bytes
struct bme280_uncomp_data
{
    uint32_t pressure;    // un-compensated pressure
    uint32_t temperature; // un-compensated temperature
    uint32_t humidity;    // un-compensated humidity
};


// bme280 sensor settings structure which comprises of mode, oversampling
// and filter settings.
// 5 bytes
struct bme280_settings
{
    uint8_t osr_p;        // pressure oversampling
    uint8_t osr_t;        // temperature oversampling
    uint8_t osr_h;        // humidity oversampling
    uint8_t filter;       // filter coefficient
//    uint8_t standby_time; // standby time
};


// bme280 device structure
// 0 bytes?
struct bme280_dev
{
    struct bme280_calib_data calib_data; // Trim data
    struct bme280_settings settings;     // Sensor settings
};

#endif // BME280_DEFS_H_
