/*
 * Copyright (C) 2016 - 2018 Xilinx, Inc.
 * All rights reserved.
 *
 * Redistribution and use in source and binary forms, with or without modification,
 * are permitted provided that the following conditions are met:
 *
 * 1. Redistributions of source code must retain the above copyright notice,
 *    this list of conditions and the following disclaimer.
 * 2. Redistributions in binary form must reproduce the above copyright notice,
 *    this list of conditions and the following disclaimer in the documentation
 *    and/or other materials provided with the distribution.
 * 3. The name of the author may not be used to endorse or promote products
 *    derived from this software without specific prior written permission.
 *
 * THIS SOFTWARE IS PROVIDED BY THE AUTHOR ``AS IS'' AND ANY EXPRESS OR IMPLIED
 * WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF
 * MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT
 * SHALL THE AUTHOR BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL,
 * EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT
 * OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS
 * INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN
 * CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING
 * IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY
 * OF SUCH DAMAGE.
 *
 */

#include <stdio.h>
#include "xparameters.h"
#include "netif/xadapter.h"
#include "platform_config.h"
#include "xil_printf.h"
#include "config.h"
#include "./network/network_mannger.h"
#include "main.h"
// #include "port
int lwip_thread();
void print_echo_app_header();
void echo_application_thread(void *);
void lwip_init();

int tdc_dma_thread(void);
// XGpio_SetDataDirection XGpio_ReadReg
void sys_init(void);

// extern XScuGic xInterruptController;

int dac_thread()
{

	vTaskDelay(1000 / portTICK_RATE_MS); // 10us
	uint8_t ret = 0;
	iic_init();
	ret = DAC80501_INIT();
	if (!ret)
		xil_printf("DAC80501_INIT failed \r\n");
	//	SetVoltage(0.007);
	vTaskDelete(NULL);
	return 0;
}

int main()
{
	sys_thread_new("dac", (void (*)(void *))dac_thread, 0,
				   THREAD_STACKSIZE,
				   DEFAULT_THREAD_PRIO);
	sys_thread_new("lookuptab", (void (*)(void *))calib_proc_thread, 0,
				   THREAD_STACKSIZE,
				   DEFAULT_THREAD_PRIO);
	sys_thread_new("tdc_dma", (void (*)(void *))tdc_dma_thread, 0,
				   THREAD_STACKSIZE,
				   DEFAULT_THREAD_PRIO);
	sys_thread_new("lwip_thrd", (void (*)(void *))lwip_thread, 0,
				   THREAD_STACKSIZE,
				   DEFAULT_THREAD_PRIO);
	sys_thread_new("status_machine", (void (*)(void *))status_machine, 0,
				   THREAD_STACKSIZE,
				   DEFAULT_THREAD_PRIO);
	vTaskStartScheduler();
	return 0;
}
