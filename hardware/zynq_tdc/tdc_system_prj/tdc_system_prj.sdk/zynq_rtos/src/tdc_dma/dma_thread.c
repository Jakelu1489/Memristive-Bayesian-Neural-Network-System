/******************************************************************************
 * Copyright (C) 2010 - 2022 Xilinx, Inc.  All rights reserved.
 * Copyright (C) 2022 - 2023 Advanced Micro Devices, Inc.  All rights reserved.
 * SPDX-License-Identifier: MIT
 ******************************************************************************/

/*****************************************************************************/
/**
 *
 * @file xaxidma_example_simple_poll.c
 *
 * This file demonstrates how to use the xaxidma driver on the Xilinx AXI
 * DMA core (AXIDMA) to transfer packets in polling mode when the AXI DMA core
 * is configured in simple mode.
 *
 * This code assumes a loopback hardware widget is connected to the AXI DMA
 * core for data packet loopback.
 *
 * To see the debug print, you need a Uart16550 or uartlite in your system,
 * and please set "-DDEBUG" in your compiler options. You need to rebuild your
 * software executable.
 *
 *
 * <pre>
 * MODIFICATION HISTORY:
 *
 * Ver   Who  Date     Changes
 * ----- ---- -------- -------------------------------------------------------
 * 4.00a rkv  02/22/11 New example created for simple DMA, this example is for
 *       	       simple DMA
 * 5.00a srt  03/06/12 Added Flushing and Invalidation of Caches to fix CRs
 *		       648103, 648701.
 *		       Added V7 DDR Base Address to fix CR 649405.
 * 6.00a srt  03/27/12 Changed API calls to support MCDMA driver.
 * 7.00a srt  06/18/12 API calls are reverted back for backward compatibility.
 * 7.01a srt  11/02/12 Buffer sizes (Tx and Rx) are modified to meet maximum
 *		       DDR memory limit of the h/w system built with Area mode
 * 7.02a srt  03/01/13 Updated DDR base address for IPI designs (CR 703656).
 * 9.1   adk  01/07/16 Updated DDR base address for Ultrascale (CR 799532) and
 *		       removed the defines for S6/V6.
 * 9.3   ms   01/23/17 Modified xil_printf statement in main function to
 *                     ensure that "Successfully ran" and "Failed" strings are
 *                     available in all examples. This is a fix for CR-965028.
 *       ms   04/05/17 Modified Comment lines in functions to
 *                     recognize it as documentation block for doxygen
 *                     generation of examples.
 * 9.9   rsp  01/21/19 Fix use of #elif check in deriving DDR_BASE_ADDR.
 * 9.10  rsp  09/17/19 Fix cache maintenance ops for source and dest buffer.
 * 9.14  sk   03/08/22 Delete DDR memory limits comments as they are not
 * 		       relevant to this driver version.
 * 9.15  sa   08/12/22 Updated the example to use latest MIG cannoical define
 * 		       i.e XPAR_MIG_0_C0_DDR4_MEMORY_MAP_BASEADDR.
 * 9.16  sa   09/29/22 Fix infinite loops in the example.
 * </pre>
 *
 * ***************************************************************************

 */
/***************************** Include Files *********************************/
#include "xaxidma.h"
#include "xparameters.h"
#include "xdebug.h"
#include "sleep.h"
#include "xil_testmem.h"
#include "mem_cache.h"
#include "../config.h"
#include "FreeRTOS.h"
#include "task.h"

#include "../platform_config.h"
#include "xil_printf.h"

#if defined(XPAR_UARTNS550_0_BASEADDR)
#include "xuartns550_l.h" /* to use uartns550 */
#endif
#include "xscugic.h"
#ifdef SDT
#include "xinterrupt_wrap.h"
#endif
#ifdef XPAR_UARTNS550_0_BASEADDR
#include "xuartns550_l.h" /* to use uartns550 */
#endif

#ifndef SDT
#ifdef XPAR_INTC_0_DEVICE_ID
#include "xintc.h"
#else
#include "xscugic.h"
#endif
#endif

/******************** Constant Definitions **********************************/

/*
 * Device hardware build related constants.
 */

#ifndef SDT
#define DMA_DEV_ID XPAR_AXIDMA_0_DEVICE_ID

#ifdef XPAR_AXI_7SDDR_0_S_AXI_BASEADDR
#define DDR_BASE_ADDR XPAR_AXI_7SDDR_0_S_AXI_BASEADDR
#elif defined(XPAR_MIG7SERIES_0_BASEADDR)
#define DDR_BASE_ADDR XPAR_MIG7SERIES_0_BASEADDR
#elif defined(XPAR_MIG_0_C0_DDR4_MEMORY_MAP_BASEADDR)
#define DDR_BASE_ADDR XPAR_MIG_0_C0_DDR4_MEMORY_MAP_BASEADDR
#elif defined(XPAR_PSU_DDR_0_S_AXI_BASEADDR)
#define DDR_BASE_ADDR XPAR_PSU_DDR_0_S_AXI_BASEADDR
#endif

#else

#ifdef XPAR_MEM0_BASEADDRESS
#define DDR_BASE_ADDR XPAR_MEM0_BASEADDRESS
#endif
#endif

// #define TX_BUFFER_BASE		(MEM_BASE_ADDR + 0x00100000)
#define RX_BUFFER_BASE MEM_BASE_ADDR
// #define RX_BUFFER_HIGH		(MEM_BASE_ADDR + 0x004FFFFF)

#define TEST_START_VALUE 0xC

#define NUMBER_OF_TRANSFERS 10
#define POLL_TIMEOUT_COUNTER 100000U

#ifndef SDT
#ifdef XPAR_INTC_0_DEVICE_ID
#define INTC_DEVICE_ID XPAR_INTC_0_DEVICE_ID
#else
#define INTC_DEVICE_ID XPAR_SCUGIC_SINGLE_DEVICE_ID
#endif

#ifdef XPAR_INTC_0_DEVICE_ID
#define INTC XIntc
#define INTC_HANDLER XIntc_InterruptHandler
#else
#define INTC XScuGic
#define INTC_HANDLER XScuGic_InterruptHandler
#endif
#endif

#ifndef SDT
// static INTC Intc; /* Instance of the Interrupt Controller */
extern XScuGic xInterruptController;
#endif
#ifndef SDT
static int SetupIntrSystem(INTC *IntcInstancePtr,
						   XAxiDma *AxiDmaPtr, u16 TxIntrId, u16 RxIntrId);
static void DisableIntrSystem(INTC *IntcInstancePtr,
							  u16 TxIntrId, u16 RxIntrId);

#endif

#ifndef SDT
#ifdef XPAR_INTC_0_DEVICE_ID
#define RX_INTR_ID XPAR_INTC_0_AXIDMA_0_S2MM_INTROUT_VEC_ID
#define TX_INTR_ID XPAR_INTC_0_AXIDMA_0_MM2S_INTROUT_VEC_ID
#else
#define RX_INTR_ID XPAR_FABRIC_AXIDMA_0_VEC_ID
// #define TX_INTR_ID		XPAR_FABRIC_AXIDMA_0_MM2S_INTROUT_VEC_ID
#endif
#endif

/**************************** Type Definitions *******************************/

int tdc_dma_thread(void);

// extern XScuGic xInterruptController;

/***************** Macros (Inline Functions) Definitions *********************/

/************************** Function Prototypes ******************************/

#if (!defined(DEBUG))
extern void xil_printf(const char *format, ...);
#endif

#ifndef SDT
int XAxiDma_SimplePollExample(u16 DeviceId);
#else
int XAxiDma_SimplePollExample(UINTPTR BaseAddress);
#endif
// static int CheckData(void);

/************************** Variable Definitions *****************************/
/*
 * Device instance definitions
 */
XAxiDma AxiDma;
volatile u32 TxDone;
volatile u32 RxDone;
volatile u32 Error;

volatile u32 send_pc;
volatile u32 send_pc_size;
volatile u32 send_pc_address;

// #define NUMBER_OF_TRANSFERS 10
#define POLL_TIMEOUT_COUNTER 100000U
#define NUMBER_OF_EVENTS 1

int tdc_dma_thread()
{
	int Status;
	XAxiDma_Config *CfgPtr;
//	int Index = 0;
	int TimeOut = POLL_TIMEOUT_COUNTER;
	int cnt = 0;
	int rx_size = 0;
	UINTPTR dma_rx_address;
	u32 total_size = 0;
	//	MemCache_T mem_queue;
	queue_init();
	//	RxBufferPtr = (u8 *)RX_BUFFER_BASE;
	//	start_measurement = 1;///////////////
	/* Initialize the XAxiDma device.*/
	CfgPtr = XAxiDma_LookupConfig(DMA_DEV_ID);
	if (!CfgPtr)
	{
		xil_printf("No config found for %d\r\n", DMA_DEV_ID);
		return XST_FAILURE;
	}

	Status = XAxiDma_CfgInitialize(&AxiDma, CfgPtr);
	if (Status != XST_SUCCESS)
	{
		xil_printf("Initialization failed %d\r\n", Status);
		return XST_FAILURE;
	}
	/* Set up Interrupt system   add */
	Status = SetupIntrSystem(&xInterruptController, &AxiDma, RX_INTR_ID, RX_INTR_ID);
	if (Status != XST_SUCCESS)
	{
		xil_printf("Failed intr setup\r\n");
		return XST_FAILURE;
	}
	/* Disable interrupts, we use polling mode add */
	XAxiDma_IntrDisable(&AxiDma, XAXIDMA_IRQ_ALL_MASK,
						XAXIDMA_DEVICE_TO_DMA);
	XAxiDma_IntrDisable(&AxiDma, XAXIDMA_IRQ_ALL_MASK,
						XAXIDMA_DMA_TO_DEVICE);
	/* Enable all interrupts */
	//	XAxiDma_IntrEnable(&AxiDma, XAXIDMA_IRQ_ALL_MASK,
	//			   XAXIDMA_DMA_TO_DEVICE);

	XAxiDma_IntrEnable(&AxiDma, XAXIDMA_IRQ_ALL_MASK,
					   XAXIDMA_DEVICE_TO_DMA);

	/* Initialize flags before start transfer test add   */
	RxDone = 0;
	Error = 0;
	sync_dma_tx_finished = 0;
	tdc_calib_status = Xil_In32(TDC_CALIB_STATUS);
	// Xil_DCacheFlushRange((UINTPTR)(RX_BUFFER_POOLS[Index]), MAX_PKT_LEN);
	queue_push(0, &dma_rx_address);
	while (1)
	{
		if (status == CALIBING || status == TDC_MEAS || status == TDC_PAUSE || status == CALIBFIISHED)
		{

			Xil_DCacheFlushRange((UINTPTR)(dma_rx_address), MAX_PKT_LEN);
			Status = XAxiDma_SimpleTransfer(&AxiDma, (UINTPTR)(dma_rx_address + rx_size), MAX_PKT_LEN, XAXIDMA_DEVICE_TO_DMA);
			TimeOut = POLL_TIMEOUT_COUNTER;
			while (1)
			{
				if (Error)
				{
					Error = 0;
					xil_printf("ERROR: DMA internal error \r\n");
				}
				if (RxDone)
				{
					tdc_calib_status = Xil_In32(TDC_CALIB_STATUS);
					rx_size += XAxiDma_ReadReg(AxiDma.RxBdRing[0].ChanBase, XAXIDMA_BUFFLEN_OFFSET);
					RxDone = 0;
					++cnt;
					if (cnt >= TDC_MEAS_MAX)
					{
						if (queue_push(rx_size, &dma_rx_address)) // push to queue if not full
						{
							total_size += rx_size;
							rx_size = 0;
						}
						else // memory pool is full , do nothing
						{
							xil_printf("ERROR: send to pc overload \r\n");
						}
						cnt = 0;
					}
					break;
				}
				--TimeOut;
				if(TimeOut == 0)
				{
					if (cnt)
					{
						if (queue_push(rx_size, &dma_rx_address)) // push to queue if not full
						{
								total_size += rx_size;
								rx_size = 0;
								cnt = 0;
						}
						else // memory pool is full , wait for queue
						{
							vTaskDelay(1 / portTICK_RATE_MS); // 1ms
							xil_printf("ERROR: send to pc overload \r\n");
						}
						TimeOut = POLL_TIMEOUT_COUNTER;
					}
				}

				vTaskDelay(0.001 / portTICK_RATE_MS); // 10us
				if (status == CALIBING || status == TDC_MEAS || status == TDC_PAUSE || status == CALIBFIISHED)
					continue;
				else
					break;
			}
//			if (TimeOut == 0) // transfer stopped
//			{
//			}
		}
		// else if (status == TDC_PAUSE || status == CALIBFIISHED) // ¡¤??????¨¤????
		// {
		// 	Xil_DCacheFlushRange((UINTPTR)(dma_rx_address), MAX_PKT_LEN);
		// 	Status = XAxiDma_SimpleTransfer(&AxiDma, (UINTPTR)(dma_rx_address + rx_size), MAX_PKT_LEN, XAXIDMA_DEVICE_TO_DMA);
		// 	TimeOut = POLL_TIMEOUT_COUNTER;
		// 	while (TimeOut)
		// 	{
		// 		if (RxDone)
		// 		{
		// 			tdc_calib_status = Xil_In32(TDC_CALIB_STATUS);
		// 			rx_size += XAxiDma_ReadReg(AxiDma.RxBdRing[0].ChanBase, XAXIDMA_BUFFLEN_OFFSET);
		// 			RxDone = 0;
		// 			++cnt;
		// 			if (cnt >= TDC_MEAS_MAX)
		// 			{
		// 				if (queue_push(rx_size, &dma_rx_address)) // push to queue if not full
		// 				{
		// 					rx_size = 0;
		// 					// break;
		// 				}
		// 				else // memory pool is full , do nothing
		// 				{
		// 					xil_printf("ERROR: send to pc overload \r\n");
		// 				}

		// 				// if (send_pc == 1)
		// 				// 	xil_printf("TDC_PAUSE send to pc overload \r\n");
		// 				// else // ??????????
		// 				// {
		// 				// 	send_pc_size = rx_size;
		// 				// 	send_pc_address = RX_BUFFER_POOLS[Index];
		// 				// 	send_pc = 1;
		// 				// 	cnt = 0;
		// 				// 	++Index;
		// 				// 	Index = Index % 2;
		// 				// }
		// 				xil_printf("TDC_PAUSE number read is %d\r\n", rx_size); // used for debug
		// 				rx_size = 0;
		// 				// vTaskDelay(1000 * 10 / portTICK_RATE_MS); // ??????
		// 			}
		// 			break;
		// 		}
		// 		--TimeOut;
		// 		vTaskDelay(100 / portTICK_RATE_MS); // 10us
		// 	}
			// if (TimeOut == 0)
			// {
			// 	queue_push(rx_size, &dma_rx_address);
			// 	// send_pc_size = rx_size;
			// 	// send_pc_address = RX_BUFFER_POOLS[Index];
			// 	// send_pc = 1;
			// 	cnt = 0;
			// 	rx_size = 0;
			// 	sync_dma_tx_finished = 1;
			// 	vTaskDelay(10 / portTICK_RATE_MS);
			// }
		// }
		else
			vTaskDelay(200 / portTICK_RATE_MS);
		//
		// if (start_measurement)
		// {
		// 	++cnt;
		// 	Xil_DCacheFlushRange((UINTPTR)(RX_BUFFER_POOLS[Index]), MAX_PKT_LEN);
		// 	Status = XAxiDma_SimpleTransfer(&AxiDma, (UINTPTR)(RX_BUFFER_POOLS[Index] + rx_size), MAX_PKT_LEN, XAXIDMA_DEVICE_TO_DMA);
		// 	if (Status != XST_SUCCESS)
		// 	{
		// 		return XST_FAILURE;
		// 	}
		// 	/*Wait till tranfer is done or 1usec * 10^6 iterations of timeout occurs*/
		// 	TimeOut = POLL_TIMEOUT_COUNTER;
		// 	while (TimeOut)
		// 	{
		// 		if (RxDone)
		// 		{

		// 			//					mem_queue.indx = Index;
		// 			//					mem_queue.rx_size = XAxiDma_ReadReg(AxiDma.RxBdRing[0].ChanBase, XAXIDMA_BUFFLEN_OFFSET);
		// 			rx_size += XAxiDma_ReadReg(AxiDma.RxBdRing[0].ChanBase, XAXIDMA_BUFFLEN_OFFSET);
		// 			RxDone = 0;
		// 			//					vTaskDelay(10/ portTICK_RATE_MS);
		// 			if (cnt >= TDC_MEAS_MAX)
		// 			{
		// 				if (send_pc == 1)
		// 					xil_printf("send to pc overload \r\n");
		// 				else // ??????????
		// 				{
		// 					send_pc_size = rx_size;
		// 					send_pc_address = RX_BUFFER_POOLS[Index];
		// 					send_pc = 1;
		// 					cnt = 0;
		// 					++Index;
		// 					Index = Index % 2;
		// 				}
		// 				xil_printf("number read is %d\r\n", rx_size);
		// 				rx_size = 0;
		// 				vTaskDelay(1000 * 10 / portTICK_RATE_MS); // ??????

		// 				//						break;
		// 				//						queue_push(&mem_queue);
		// 				//						send_pc = 0;
		// 				//						lwip_send_nonblocked(new_sd, (char *)send_pc_address, 100);
		// 			}
		// 			break;
		// 		}
		// 		TimeOut--;
		// 		//				vTaskDelay(0.01 / portTICK_RATE_MS);
		// 		//				xil_printf("number %d read is %d\r\n", mem_queue.indx,mem_queue.rx_size);
		// 		//							xil_printf("status %x\r\n",  XAxiDma_ReadReg(AxiDma.RxBdRing[0].ChanBase, XAXIDMA_SR_OFFSET));
		// 		//							xil_printf("CRstatus %x\r\n",  XAxiDma_ReadReg(AxiDma.RxBdRing[0].ChanBase, XAXIDMA_CR_OFFSET));
		// 	}
		// 	//			xil_printf("number %d read is %d\r\n", mem_queue.indx,mem_queue.rx_size);
		// 	//			xil_printf("status %x\r\n",  XAxiDma_ReadReg(AxiDma.RxBdRing[0].ChanBase, XAXIDMA_SR_OFFSET));
		// 	//			xil_printf("CRstatus %x\r\n",  XAxiDma_ReadReg(AxiDma.RxBdRing[0].ChanBase, XAXIDMA_CR_OFFSET));
		// 	if (TimeOut == 0)
		// 		xil_printf("TimeOut for Rx\r\n");
		// 	//			if(send_pc)
		// 	//				while(1)
		// 	//				{
		// 	//					vTaskDelay(1 / portTICK_RATE_MS);
		// 	//				}
		// }
		// else

		// {
		// 	cnt = 0;
		// 	rx_size = 0;
		// 	vTaskDelay(0.01 / portTICK_RATE_MS);
		// }
	}
	DisableIntrSystem(&xInterruptController, RX_INTR_ID, RX_INTR_ID);
	return XST_SUCCESS;
}

/*****************************************************************************/
/**
 * The example to do the simple transfer through polling. The constant
 * NUMBER_OF_TRANSFERS defines how many times a simple transfer is repeated.
 *
 * @param	DeviceId is the Device Id of the XAxiDma instance
 *
 * @return
 *		- XST_SUCCESS if example finishes successfully
 *		- XST_FAILURE if error occurs
 *
 * @note		None
 *
 *
 ******************************************************************************/
// #ifndef SDT
// int XAxiDma_SimplePollExample(u16 DeviceId)
// #else
// int XAxiDma_SimplePollExample(UINTPTR BaseAddress)
// #endif
//{
//	XAxiDma_Config *CfgPtr;
//	int Status;
//	int Tries = NUMBER_OF_TRANSFERS;
//	int Index;
//	u8 *TxBufferPtr;
//	u8 *RxBufferPtr;
//	u8 Value;
//	int TimeOut = POLL_TIMEOUT_COUNTER;
//
//	// TxBufferPtr = (u8 *)TX_BUFFER_BASE;
//	RxBufferPtr = (u8 *)RX_BUFFER_BASE;
//
//	/* Initialize the XAxiDma device.
//	 */
// #ifndef SDT
//	CfgPtr = XAxiDma_LookupConfig(DeviceId);
//	if (!CfgPtr)
//	{
//		xil_printf("No config found for %d\r\n", DeviceId);
//		return XST_FAILURE;
//	}
// #else
//	CfgPtr = XAxiDma_LookupConfig(BaseAddress);
//	if (!CfgPtr)
//	{
//		xil_printf("No config found for %d\r\n", BaseAddress);
//		return XST_FAILURE;
//	}
// #endif
//
//	Status = XAxiDma_CfgInitialize(&AxiDma, CfgPtr);
//	if (Status != XST_SUCCESS)
//	{
//		xil_printf("Initialization failed %d\r\n", Status);
//		return XST_FAILURE;
//	}
//
//	if (XAxiDma_HasSg(&AxiDma))
//	{
//		xil_printf("Device configured as SG mode \r\n");
//		return XST_FAILURE;
//	}
//
//	/* Set up Interrupt system   add */
// #ifndef SDT
//	Status = SetupIntrSystem(&Intc, &AxiDma, RX_INTR_ID, RX_INTR_ID);
//	if (Status != XST_SUCCESS)
//	{
//
//		xil_printf("Failed intr setup\r\n");
//		return XST_FAILURE;
//	}
// #else
//	Status = XSetupInterruptSystem(&AxiDma, &TxIntrHandler,
//								   Config->IntrId[0], Config->IntrParent,
//								   XINTERRUPT_DEFAULT_PRIORITY);
//	if (Status != XST_SUCCESS)
//	{
//		return XST_FAILURE;
//	}
//
//	Status = XSetupInterruptSystem(&AxiDma, &RxIntrHandler,
//								   Config->IntrId[1], Config->IntrParent,
//								   XINTERRUPT_DEFAULT_PRIORITY);
//	if (Status != XST_SUCCESS)
//	{
//		return XST_FAILURE;
//	}
// #endif
//
//	/* Disable interrupts, we use polling mode add
//	 */
//	XAxiDma_IntrDisable(&AxiDma, XAXIDMA_IRQ_ALL_MASK,
//						XAXIDMA_DEVICE_TO_DMA);
//	XAxiDma_IntrDisable(&AxiDma, XAXIDMA_IRQ_ALL_MASK,
//						XAXIDMA_DMA_TO_DEVICE);
//
//	/* Enable all interrupts */
//	//	XAxiDma_IntrEnable(&AxiDma, XAXIDMA_IRQ_ALL_MASK,
//	//			   XAXIDMA_DMA_TO_DEVICE);
//
//	XAxiDma_IntrEnable(&AxiDma, XAXIDMA_IRQ_ALL_MASK,
//					   XAXIDMA_DEVICE_TO_DMA);
//
//	/* Initialize flags before start transfer test add   */
//	TxDone = 0;
//	RxDone = 0;
//	Error = 0;
//
//	Value = TEST_START_VALUE;
//
//	/* Flush the buffers before the DMA transfer, in case the Data Cache
//	 * is enabled
//	 */
//	Xil_DCacheFlushRange((UINTPTR)RxBufferPtr, 1024 * 8);
//	Tries = 1;
//	for (Index = 0; Index < Tries; Index++)
//	{
//
////		XAxiDma_WriteReg(AxiDma.RxBdRing[0].ChanBase, 0x58, 1024 * 8);
//		xil_printf("number read is %d", XAxiDma_ReadReg(AxiDma.RxBdRing[0].ChanBase, 0x58));
//		Status = XAxiDma_SimpleTransfer(&AxiDma, (UINTPTR)RxBufferPtr,
//										8000, XAXIDMA_DEVICE_TO_DMA);
//		//		XAxiDma_WriteReg(AxiDma.RxBdRing[0].ChanBase,XAXIDMA_BUFFLEN_OFFSET,1024*8);
//		xil_printf("number read is %d", XAxiDma_ReadReg(AxiDma.RxBdRing[0].ChanBase, XAXIDMA_BUFFLEN_OFFSET));
//
//		if (Status != XST_SUCCESS)
//		{
//			return XST_FAILURE;
//		}
//
//		//		Status = XAxiDma_SimpleTransfer(&AxiDma, (UINTPTR) TxBufferPtr,
//		//						MAX_PKT_LEN, XAXIDMA_DMA_TO_DEVICE);
//
//		if (Status != XST_SUCCESS)
//		{
//			return XST_FAILURE;
//		}
//
//		//		Status = Xil_WaitForEventSet(POLL_TIMEOUT_COUNTER, NUMBER_OF_EVENTS, &RxDone);
//		//				if (Status != XST_SUCCESS) {
//		//					xil_printf("here\r\n");
//		//				}
//
//		/*Wait till tranfer is done or 1usec * 10^6 iterations of timeout occurs*/
//		while (TimeOut)
//		{
//			//			if (!(XAxiDma_Busy(&AxiDma, XAXIDMA_DEVICE_TO_DMA))) {
//			//				break;
//			if (RxDone)
//			{
//				RxDone = 0;
//				break;
//			}
//			TimeOut--;
//			usleep(1U);
//		}
//		//		XAxiDma_WriteReg(AxiDma.RxBdRing[0].ChanBase,0x30,
//		//				XAxiDma_ReadReg(AxiDma.RxBdRing[0].ChanBase,0x30) & 0x7FFFFFFF);
//		//		usleep(1U);
//		xil_printf("number read is %d", XAxiDma_ReadReg(AxiDma.RxBdRing[0].ChanBase, XAXIDMA_BUFFLEN_OFFSET));
//		if (TimeOut == 0)
//			xil_printf("TimeOut for Rx\r\n");
//		//		Status = CheckData();
//		if (Status != XST_SUCCESS)
//		{
//			return XST_FAILURE;
//		}
//	}
// #ifndef SDT
//	DisableIntrSystem(&Intc, RX_INTR_ID, RX_INTR_ID);
// #else
//	XDisconnectInterruptCntrl(Config->IntrId[0], Config->IntrParent);
//	XDisconnectInterruptCntrl(Config->IntrId[1], Config->IntrParent);
// #endif
//	/* Test finishes successfully
//	 */
//	return XST_SUCCESS;
//}

/*****************************************************************************/
/*
 *
 * This function checks data buffer after the DMA transfer is finished.
 *
 * @param	None
 *
 * @return
 *		- XST_SUCCESS if validation is successful.
 *		- XST_FAILURE otherwise.
 *
 * @note		None.
 *
 ******************************************************************************/
// static int CheckData(void)
//{
//	u8 *RxPacket;
//	int Index = 0;
//	u8 Value;
//
//	RxPacket = (u8 *)RX_BUFFER_BASE;
//	Value = TEST_START_VALUE;
//
//	/* Invalidate the DestBuffer before receiving the data, in case the
//	 * Data Cache is enabled
//	 */
//	Xil_DCacheInvalidateRange((UINTPTR)RxPacket, MAX_PKT_LEN);
//
//	for (Index = 0; Index < MAX_PKT_LEN; Index++)
//	{
//		if (RxPacket[Index] != Value)
//		{
//			xil_printf("Data error %d: %x/%x\r\n",
//					   Index, (unsigned int)RxPacket[Index],
//					   (unsigned int)Value);
//
//			//			return XST_FAILURE;
//		}
//		Value = (Value + 1) & 0xFF;
//	}
//
//	return XST_SUCCESS;
// }

/*****************************************************************************/
/*
 *
 * This is the DMA RX interrupt handler function
 *
 * It gets the interrupt status from the hardware, acknowledges it, and if any
 * error happens, it resets the hardware. Otherwise, if a completion interrupt
 * is present, then it sets the RxDone flag.
 *
 * @param	Callback is a pointer to RX channel of the DMA engine.
 *
 * @return	None.
 *
 * @note		None.
 *
 ******************************************************************************/
static void RxIntrHandler(void *Callback)
{
	u32 IrqStatus;
	int TimeOut;
	XAxiDma *AxiDmaInst = (XAxiDma *)Callback;
	/* Read pending interrupts */
	IrqStatus = XAxiDma_IntrGetIrq(AxiDmaInst, XAXIDMA_DEVICE_TO_DMA);
	/* Acknowledge pending interrupts */
	XAxiDma_IntrAckIrq(AxiDmaInst, IrqStatus, XAXIDMA_DEVICE_TO_DMA);

	/*
	 * If no interrupt is asserted, we do not do anything
	 */
	if (!(IrqStatus & XAXIDMA_IRQ_ALL_MASK))
	{
		xil_printf("ERROR: IrqStatus %x\r\n", IrqStatus);
		return;
	}

	/*
	 * If error interrupt is asserted, raise error flag, reset the
	 * hardware to recover from the error, and return with no further
	 * processing.
	 */
	if ((IrqStatus & XAXIDMA_IRQ_ERROR_MASK))
	{

		Error = 1;
		xil_printf("Error %x\r\n", XAxiDma_ReadReg(AxiDma.RxBdRing[0].ChanBase, XAXIDMA_CR_OFFSET));
		/* Reset could fail and hang
		 * NEED a way to handle this or do not call it??
		 */
		XAxiDma_Reset(AxiDmaInst);

		TimeOut = 1000;

		while (TimeOut)
		{
			if (XAxiDma_ResetIsDone(AxiDmaInst))
			{
				break;
			}

			TimeOut -= 1;
		}

		return;
	}

	/*
	 * If completion interrupt is asserted, then set RxDone flag
	 */
	if ((IrqStatus & XAXIDMA_IRQ_IOC_MASK))
	{
		RxDone = 1;
		//		XAxiDma_WriteReg(AxiDma.RxBdRing[0].ChanBase,
		//				XAXIDMA_SR_OFFSET,
		//							(~XAXIDMA_IRQ_IOC_MASK) & XAxiDma_ReadReg(AxiDma.RxBdRing[0].ChanBase, XAXIDMA_SR_OFFSET));
		//	xil_printf("XAXIDMA_SR_OFFSET %x\r\n",XAxiDma_ReadReg(AxiDma.RxBdRing[0].ChanBase, XAXIDMA_SR_OFFSET));
	}
}

/*****************************************************************************/
/*
 *
 * This function setups the interrupt system so interrupts can occur for the
 * DMA, it assumes INTC component exists in the hardware system.
 *
 * @param	IntcInstancePtr is a pointer to the instance of the INTC.
 * @param	AxiDmaPtr is a pointer to the instance of the DMA engine
 * @param	TxIntrId is the TX channel Interrupt ID.
 * @param	RxIntrId is the RX channel Interrupt ID.
 *
 * @return
 *		- XST_SUCCESS if successful,
 *		- XST_FAILURE.if not successful
 *
 * @note		None.
 *
 ******************************************************************************/
static int SetupIntrSystem(INTC *IntcInstancePtr,
						   XAxiDma *AxiDmaPtr, u16 TxIntrId, u16 RxIntrId)
{
	int Status;

#ifdef XPAR_INTC_0_DEVICE_ID

	/* Initialize the interrupt controller and connect the ISRs */
	Status = XIntc_Initialize(IntcInstancePtr, INTC_DEVICE_ID);
	if (Status != XST_SUCCESS)
	{

		xil_printf("Failed init intc\r\n");
		return XST_FAILURE;
	}

	Status = XIntc_Connect(IntcInstancePtr, TxIntrId,
						   (XInterruptHandler)TxIntrHandler, AxiDmaPtr);
	if (Status != XST_SUCCESS)
	{

		xil_printf("Failed tx connect intc\r\n");
		return XST_FAILURE;
	}

	Status = XIntc_Connect(IntcInstancePtr, RxIntrId,
						   (XInterruptHandler)RxIntrHandler, AxiDmaPtr);
	if (Status != XST_SUCCESS)
	{

		xil_printf("Failed rx connect intc\r\n");
		return XST_FAILURE;
	}

	/* Start the interrupt controller */
	Status = XIntc_Start(IntcInstancePtr, XIN_REAL_MODE);
	if (Status != XST_SUCCESS)
	{

		xil_printf("Failed to start intc\r\n");
		return XST_FAILURE;
	}

	XIntc_Enable(IntcInstancePtr, TxIntrId);
	XIntc_Enable(IntcInstancePtr, RxIntrId);

#else

	XScuGic_Config *IntcConfig;

	/*
	 * Initialize the interrupt controller driver so that it is ready to
	 * use.
	 */
	IntcConfig = XScuGic_LookupConfig(INTC_DEVICE_ID);
	if (NULL == IntcConfig)
	{
		return XST_FAILURE;
	}
	//
	//	Status = XScuGic_CfgInitialize(IntcInstancePtr, IntcConfig,
	//								   IntcConfig->CpuBaseAddress);
	//	if (Status != XST_SUCCESS)
	//	{
	//		return XST_FAILURE;
	//	}
	//
	//	//	sXScuGic_SetPriorityTriggerType(IntcInstancePtr, TxIntrId, 0xA0, 0x3);
	//
	//	XScuGic_SetPriorityTriggerType(IntcInstancePtr, RxIntrId, 0xA0, 0x3);
	//	XScuGic_SetPriorityTriggerType(IntcInstancePtr, RxIntrId, 0xA0, 0x3);

	/*
	 * Connect the device driver handler that will be called when an
	 * interrupt for the device occurs, the handler defined above performs
	 * the specific interrupt processing for the device.
	 */
	//	Status = XScuGic_Connect(IntcInstancePtr, TxIntrId,
	//				 (Xil_InterruptHandler)TxIntrHandler,
	//				 AxiDmaPtr);
	//	if (Status != XST_SUCCESS) {
	//		return Status;
	//	}

	Status = XScuGic_Connect(IntcInstancePtr, RxIntrId,
							 (Xil_InterruptHandler)RxIntrHandler,
							 AxiDmaPtr);
	if (Status != XST_SUCCESS)
	{
		return Status;
	}

	//	XScuGic_Enable(IntcInstancePtr, TxIntrId);
	XScuGic_Enable(IntcInstancePtr, RxIntrId);

#endif

	/* Enable interrupts from the hardware */
	//
	//	Xil_ExceptionInit();
	//	Xil_ExceptionRegisterHandler(XIL_EXCEPTION_ID_INT,
	//								 (Xil_ExceptionHandler)INTC_HANDLER,
	//								 (void *)IntcInstancePtr);
	//
	//	Xil_ExceptionEnable();

	return XST_SUCCESS;
}

/*****************************************************************************/
/**
 *
 * This function disables the interrupts for DMA engine.
 *
 * @param	IntcInstancePtr is the pointer to the INTC component instance
 * @param	TxIntrId is interrupt ID associated w/ DMA TX channel
 * @param	RxIntrId is interrupt ID associated w/ DMA RX channel
 *
 * @return	None.
 *
 * @note		None.
 *
 ******************************************************************************/
static void DisableIntrSystem(INTC *IntcInstancePtr,
							  u16 TxIntrId, u16 RxIntrId)
{
#ifdef XPAR_INTC_0_DEVICE_ID
	/* Disconnect the interrupts for the DMA TX and RX channels */
	XIntc_Disconnect(IntcInstancePtr, TxIntrId);
	XIntc_Disconnect(IntcInstancePtr, RxIntrId);
#else
	XScuGic_Disconnect(IntcInstancePtr, TxIntrId);
	XScuGic_Disconnect(IntcInstancePtr, RxIntrId);
#endif
}
