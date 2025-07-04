/*
 * dac0501.h
 *
 *  Created on: 2024��6��10��
 *      Author: alvinPC
 */

#ifndef SRC_DAC0501_DAC0501_H_
#define SRC_DAC0501_DAC0501_H_
#include "xparameters.h"
#include "xgpio.h"
#include "FreeRTOS.h"
#include "task.h"
#define SCL_GPIO_DEVICE_ID XPAR_GPIO_0_DEVICE_ID
#define GPIO_CHANNEL_SCL    1U
#define GPIO_CHANNEL_SDA    2U

extern XGpio iic_gpio;



#define DEV_ADDR 0x92

#define DAC80501_NOOP   						0x00
#define DAC80501_DEVID  						0x01
#define DAC80501_SYNC   						0x02
#define DAC80501_CONFIG    				0x03
#define DAC80501_GAIN  						0x04
#define DAC80501_TRIGGER   				0x05
#define DAC80501_STATUS  					0x06
#define DAC80501_DAC_DATA   				0x08
//**********************************************************************************
//
// Register definitions
//
//**********************************************************************************


/* Register 0x00 (NOOP) definition
 * |---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
 * |      Bit 15      |      Bit 14      |      Bit 13      |      Bit 12      |      Bit 11      |      Bit 10      |       Bit 9      |       Bit 8      |       Bit 7      |       Bit 6      |       Bit 5      |       Bit 4      |       Bit 3      |       Bit 2      |       Bit 1      |       Bit 0      |
 * |---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
 * |                  |                  |                  |                  |                  |                  |                  |                  |                  |                  |                  |                  |                  |                  |                  |   NO OPERATION   |
 * |---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
 */

    /* NOOP register address */
    #define NOOP_ADDRESS													((uint8_t) 0x00)

    /* NOOP default (reset) value */
    #define NOOP_DEFAULT													((uint16_t) 0x0000)

    /* NOOP register field masks */
    #define NOOP_NO OPERATION_MASK											((uint16_t) 0x0001)



/* Register 0x01 (DEVID) definition
 * |---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
 * |      Bit 15      |      Bit 14      |      Bit 13      |      Bit 12      |      Bit 11      |      Bit 10      |       Bit 9      |       Bit 8      |       Bit 7      |       Bit 6      |       Bit 5      |       Bit 4      |       Bit 3      |       Bit 2      |       Bit 1      |       Bit 0      |
 * |---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
 * |         0        |                     RESOLUTION[2:0]                    |         0        |         0        |         0        |         0        |         0        |         0        |         0        |         0        |         0        |         0        |         0        |         0        |
 * |---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
 */

    /* DEVID register address */
    #define DEVID_ADDRESS													((uint8_t) 0x01)

    /* DEVID default (reset) value */
    #define DEVID_DEFAULT													((uint16_t) 0x0000)

    /* DEVID register field masks */
    #define DEVID_RESOLUTION_MASK											((uint16_t) 0x7000)



/* Register 0x02 (SYNC) definition
 * |---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
 * |      Bit 15      |      Bit 14      |      Bit 13      |      Bit 12      |      Bit 11      |      Bit 10      |       Bit 9      |       Bit 8      |       Bit 7      |       Bit 6      |       Bit 5      |       Bit 4      |       Bit 3      |       Bit 2      |       Bit 1      |       Bit 0      |
 * |---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
 * |         0        |         0        |         0        |         0        |         0        |         0        | DAC-B-BRDCAST-EN | DAC-A-BRDCAST-EN |         0        |         0        |         0        |         0        |         0        |         0        |   DAC-B-SYNC-EN  |   DAC-A-SYNC-EN  |
 * |---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
 */

    /* SYNC register address */
    #define SYNC_ADDRESS													((uint8_t) 0x02)

    /* SYNC default (reset) value */
    #define SYNC_DEFAULT													((uint16_t) 0x0300)

    /* SYNC register field masks */
    #define SYNC_DAC_B_BRDCAST_EN_MASK										((uint16_t) 0x0200)
    #define SYNC_DAC_A_BRDCAST_EN_MASK										((uint16_t) 0x0100)
    #define SYNC_DAC_B_SYNC_EN_MASK											((uint16_t) 0x0002)
    #define SYNC_DAC_A_SYNC_EN_MASK											((uint16_t) 0x0001)



/* Register 0x03 (CONFIG) definition
 * |---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
 * |      Bit 15      |      Bit 14      |      Bit 13      |      Bit 12      |      Bit 11      |      Bit 10      |       Bit 9      |       Bit 8      |       Bit 7      |       Bit 6      |       Bit 5      |       Bit 4      |       Bit 3      |       Bit 2      |       Bit 1      |       Bit 0      |
 * |---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
 * |         0        |         0        |         0        |         0        |         0        |         0        |         0        |     REF-PWDWN    |         0        |         0        |         0        |         0        |         0        |         0        |    DAC-B-PWDWN   |    DAC-A-PWDWN   |
 * |---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
 */

    /* CONFIG register address */
    #define CONFIG_ADDRESS													((uint8_t) 0x03)

    /* CONFIG default (reset) value */
    #define CONFIG_DEFAULT													((uint16_t) 0x0000)

    /* CONFIG register field masks */
    #define CONFIG_REF_PWDWN_MASK											((uint16_t) 0x0100)
    #define CONFIG_DAC_B_PWDWN_MASK											((uint16_t) 0x0002)
    #define CONFIG_DAC_A_PWDWN_MASK											((uint16_t) 0x0001)



/* Register 0x04 (GAIN) definition
 * |---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
 * |      Bit 15      |      Bit 14      |      Bit 13      |      Bit 12      |      Bit 11      |      Bit 10      |       Bit 9      |       Bit 8      |       Bit 7      |       Bit 6      |       Bit 5      |       Bit 4      |       Bit 3      |       Bit 2      |       Bit 1      |       Bit 0      |
 * |---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
 * |         0        |         0        |         0        |         0        |         0        |         0        |         0        |      REF-DIV     |         0        |         0        |         0        |         0        |         0        |         0        |   BUFF-B -GAIN   |   BUFF-A -GAIN   |
 * |---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
 */

    /* GAIN register address */
    #define GAIN_ADDRESS													((uint8_t) 0x04)

    /* GAIN default (reset) value */
    #define GAIN_DEFAULT													((uint16_t) 0x0003)

    /* GAIN register field masks */
    #define GAIN_REF_DIV_MASK												((uint16_t) 0x0100)
    #define GAIN_BUFF_B_GAIN_MASK											((uint16_t) 0x0002)
    #define GAIN_BUFF_A_GAIN_MASK											((uint16_t) 0x0001)



/* Register 0x05 (TRIGGER) definition
 * |---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
 * |      Bit 15      |      Bit 14      |      Bit 13      |      Bit 12      |      Bit 11      |      Bit 10      |       Bit 9      |       Bit 8      |       Bit 7      |       Bit 6      |       Bit 5      |       Bit 4      |       Bit 3      |       Bit 2      |       Bit 1      |       Bit 0      |
 * |---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
 * |         0        |         0        |         0        |         0        |         0        |         0        |         0        |         0        |         0        |         0        |         0        |       LDAC       |                            SOFT-RESET[3:0][3:0]                           |
 * |---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
 */

    /* TRIGGER register address */
    #define TRIGGER_ADDRESS													((uint8_t) 0x05)

    /* TRIGGER default (reset) value */
    #define TRIGGER_DEFAULT													((uint16_t) 0x0000)

    /* TRIGGER register field masks */
    #define TRIGGER_LDAC_MASK												((uint16_t) 0x0010)
    #define TRIGGER_SOFT_RESET_MASK									((uint16_t) 0x000F)
//# SCL IIC_tri_io[0]
//# SDA IIC_tri_io[1]


#define SCL_H XGpio_DiscreteWrite(&iic_gpio, GPIO_CHANNEL_SCL, 0x1)
#define SCL_L XGpio_DiscreteWrite(&iic_gpio, GPIO_CHANNEL_SCL, 0x0)
#define SDA_H XGpio_DiscreteWrite(&iic_gpio, GPIO_CHANNEL_SDA, 0x1)
#define SDA_L XGpio_DiscreteWrite(&iic_gpio, GPIO_CHANNEL_SDA, 0x0)
#define SDA_OUT  XGpio_SetDataDirection(&iic_gpio,GPIO_CHANNEL_SDA,0x0)
#define SDA_IN   XGpio_SetDataDirection(&iic_gpio,GPIO_CHANNEL_SDA,0x1)
#define READ_SDA XGpio_DiscreteRead(&iic_gpio, GPIO_CHANNEL_SDA) & 0x01
//XGpio_DiscreteWrite
void iic_init(void);
uint8_t DAC80501_INIT(void);
uint8_t ReadDevID(void);
uint8_t SetVoltage(float vol);
#endif /* SRC_DAC0501_DAC0501_H_ */
