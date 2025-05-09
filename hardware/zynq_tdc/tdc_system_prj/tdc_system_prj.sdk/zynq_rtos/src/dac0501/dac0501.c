/*
 * dac0501.c
 *
 *  Created on: 2024年6月10日
 *      Author: alvinPC
 */

#include "dac0501.h"
      #include <math.h>

XGpio iic_gpio;
// axiGpio1_ch2_data = XGpio_DiscreteRead(&axiGpio1, AXIGPIO_CHANNEL_2); // 读取axiGpio1的通道2的值，输出引脚也可读
volatile char dac_init_flag = 0;

void iic_init(void)
{
	XGpio_Initialize(&iic_gpio, SCL_GPIO_DEVICE_ID);
	XGpio_SetDataDirection(&iic_gpio, GPIO_CHANNEL_SCL, 0x0); // 设置axiGpio0的通道1为全输出
	SDA_OUT;
	SCL_H;
	SDA_H;
}

void iic_write_char(uint8_t dat)
{
	uint8_t i;
	for (i = 0; i < 8; i++)
	{
		if ((dat << i) & 0x80)
		{
			SDA_H;
		}
		else
			SDA_L;
		SCL_L;
		SCL_H;
	}
}

// 产生IIC起始信号
void IIC_Start(void)
{
	SDA_OUT; // sda线输出
	SDA_H;
	SCL_H;
	vTaskDelay(0.004 / portTICK_RATE_MS); // 1ms(4);
	SDA_L;								  // START:when CLK is high,DATA change form high to low
	vTaskDelay(0.004 / portTICK_RATE_MS);
	SCL_H; // 钳住I2C总线，准备发送或接收数据
}
// 产生IIC停止信号
void IIC_Stop(void)
{
	SDA_OUT; // sda线输出
	SCL_H;
	SDA_L;								  // STOP:when CLK is high DATA change form low to high
	vTaskDelay(0.004 / portTICK_RATE_MS); // 1ms(4);
	SDA_H;								  // 发送I2C总线结束信号
	vTaskDelay(0.004 / portTICK_RATE_MS); // 1ms(4);
}

// 发送数据后，等待应答信号到来
// 返回值：1，接收应答失败，IIC直接退出
//         0，接收应答成功，什么都不做
u8 IIC_Wait_Ack(void)
{
	u8 ucErrTime = 0;
	SDA_H;
	SDA_IN; // SDA设置为输入
	//	SDA=1;delay_us(1);
	SCL_H;
	vTaskDelay(0.001 / portTICK_RATE_MS); // 1ms(4);
	while (READ_SDA)
	{
		ucErrTime++;
		if (ucErrTime > 250)
		{
			IIC_Stop();
			return 1;
		}
	}
	SCL_L; // 时钟输出0
	return 0;
}
// 产生ACK应答
void IIC_Ack(void)
{
	SCL_L;
	SDA_OUT;
	SDA_L;
	vTaskDelay(0.002 / portTICK_RATE_MS); // 1ms(4);
	SCL_H;
	vTaskDelay(0.002 / portTICK_RATE_MS); // 1ms(4);
	SCL_L;
}
////不产生ACK应答
void IIC_NAck(void)
{
	SCL_L;
	SDA_OUT;
	SDA_H;
	vTaskDelay(0.002 / portTICK_RATE_MS); // 1ms(4);
	SCL_H;
	vTaskDelay(0.002 / portTICK_RATE_MS); // 1ms(4);
	SCL_L;
}

// IIC发送一个字节
// 返回从机有无应答
// 1，有应答
// 0，无应答
void IIC_Send_Byte(u8 txd)
{
	u8 t;
	SDA_OUT;
	SCL_L; // 拉低时钟开始数据传输
	for (t = 0; t < 8; t++)
	{
		if ((txd & 0x80) >> 7)
			SDA_H;
		else
			SDA_L;
		txd <<= 1;
		vTaskDelay(0.002 / portTICK_RATE_MS); // 1ms(4);
		SCL_H;
		vTaskDelay(0.002 / portTICK_RATE_MS); // 1ms(4);
		SCL_L;
		vTaskDelay(0.002 / portTICK_RATE_MS); // 1ms(4);
	}
}

////读1个字节，ack=1时，发送ACK，ack=0，发送nACK
u8 IIC_Read_Byte(unsigned char ack)
{
	unsigned char i, receive = 0;
	SDA_IN; // SDA设置为输入
	for (i = 0; i < 8; i++)
	{
		SCL_L;
		vTaskDelay(0.002 / portTICK_RATE_MS); // 1ms(4);
		SCL_H;
		receive <<= 1;
		if (READ_SDA)
			receive++;
		vTaskDelay(0.002 / portTICK_RATE_MS); // 1ms(4);
	}
	if (!ack)
		IIC_NAck(); // 发送nACK
	else
		IIC_Ack(); // 发送ACK
	return receive;
}

uint8_t DAC80501_Write(uint8_t * data, uint16_t size)
{
	//	  HAL_StatusTypeDef status;
//	uint8_t DAC80501_Tx_Buf[3] = {0};
	uint8_t i = 0;
//	DAC80501_Tx_Buf[0] = wire_reg;
//	DAC80501_Tx_Buf[1] = (dac_data >> 8) & 0xFF;
//	DAC80501_Tx_Buf[2] = dac_data & 0xFF;

	IIC_Start();

	IIC_Send_Byte(DEV_ADDR);
	IIC_Wait_Ack();
	for (i = 0; i < size; i++)
	{
		IIC_Send_Byte(data[i]);
		if (IIC_Wait_Ack() == 1)
			return 0;
	}
	IIC_Stop();
	return 1;
}

void DAC80501_Read(uint8_t wire_reg,uint8_t *recv)
{
//	uint8_t recv[2];
	IIC_Start();
	IIC_Send_Byte(DEV_ADDR);
	IIC_Wait_Ack();
	IIC_Send_Byte(wire_reg);
	IIC_Wait_Ack();
	IIC_Stop();

	IIC_Start();
	IIC_Send_Byte(DEV_ADDR|0x01);
	IIC_Wait_Ack();
	recv[0] = IIC_Read_Byte(1);
	recv[1] = IIC_Read_Byte(0);
	IIC_Stop();

//	return recv;
}

#define EPSILON 0.000001

uint8_t SetVoltage(float vol)
{

	static  float cur_volt = 0.0;
	if(!dac_init_flag)
		return 0;
	if (fabs( vol - cur_volt) < EPSILON )
	{
		xil_printf("current volt is equal to set\r\n");
		return 1;
	}

	cur_volt = vol;
	uint8_t DAC80501_Tx_Buf[3]={0};
	uint16_t ADC_VOL = vol/1.25*65535;
//	uint16_t ADC_VOL = vol/2.5*65535;
	DAC80501_Tx_Buf[0] = DAC80501_DAC_DATA;
    DAC80501_Tx_Buf[1] = (ADC_VOL >> 8) & 0xFF;
    DAC80501_Tx_Buf[2] = ADC_VOL & 0xFF;


//	status = HAL_I2C_Master_Transmit(&hi2c1, DEV_ADDR, DAC80501_Tx_Buf, 3, HAL_MAX_DELAY);
	return  DAC80501_Write(DAC80501_Tx_Buf,3);

}

uint8_t ReadDevID(void)
{
   uint8_t rx_data[2];
//   printf("ReadDevID",rx_data[0],rx_data[1]);
	 uint8_t reg_addr = DAC80501_DEVID;
	 DAC80501_Read(reg_addr,rx_data);
	 xil_printf("DAC80501_DEVID is %x,%x\r\n",rx_data[0],rx_data[1]);
	 if(rx_data[0]!=0x01||rx_data[1]!=0x15)
	 {
		 return 0;
	 }

	  return 1;
}


uint8_t DAC80501_INIT(void)
{
	 uint8_t ret=0;
	 uint8_t DAC80501_Tx_Buf[3]={0};
	 ret = ReadDevID();

	if(!ret)
		{
		xil_printf("read ID failed \r\n");
		return 0;
		}

	DAC80501_Tx_Buf[0] =DAC80501_GAIN;
	DAC80501_Tx_Buf[1] =0x01; //0x01
	DAC80501_Tx_Buf[2] =0x00;
	ret=DAC80501_Write(DAC80501_Tx_Buf,3);   //设置分压1/2，增益为1

	if(!ret) return 0;
	dac_init_flag = 1;
	return 1;

}

