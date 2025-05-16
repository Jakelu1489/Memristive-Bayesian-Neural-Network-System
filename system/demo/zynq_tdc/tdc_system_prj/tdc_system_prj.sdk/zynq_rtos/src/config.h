/*
 * conf.h
 *
 *  Created on: 2024年5月26日
 *      Author: alvinPC
 */

#ifndef SRC_CONFIG_H_
#define SRC_CONFIG_H_
#include "FreeRTOS.h"
#include "xil_types.h"
#include "xil_io.h"
#include "task.h"
// FreeRTOS specific
#define THREAD_STACKSIZE 1024
//----------------------------------------------------------------
// networking specific
#define TDC_DATA_SEND_PKG_SIZE 1024 // send packet size of one tcp packet 
//----------------------------------------------------------------
// DMA specific
#ifndef DDR_BASE_ADDR
// #warning CHECK FOR THE VALID DDR ADDRESS IN XPARAMETERS.H, \
// DEFAULT SET TO 0x01000000
#define MEM_BASE_ADDR 0x01000000
#else
#define MEM_BASE_ADDR (DDR_BASE_ADDR + 0x1000000)
#endif

#define MAX_PKT_LEN 4096 // 512 tdc measurements， 8 Byte / TDCmeasurement, size per of  dma transfer
#define MAX_PKT_TDC_LEN  512 // 512 tdc measurements， 8 Byte / TDCmeasurement, size per of  dma transfer
#define CALIB_MEAS_MAX_NUM 400
#define TDC_MEAS_MAX CALIB_MEAS_MAX_NUM																		   // 200K
#define RX_BUFFER_GUARD 256
#define RX_BUFFER_POOLS_SIZE 20 // max number  MAX_PKT_LEN  of one buffer pool
#define QUEUE_DEEP_MAX RX_BUFFER_POOLS_SIZE+1 //定义队列深度为10


//----------------------------------------------------------------
// tdc machine specific
enum STATUS
{
    INIT = 1,
    CONN_OK,
    CALIBING,
    CALIBFIISHED,
    TDC_MEAS,
    TDC_PAUSE
};
//assign slv_reg1[1:0] = {tdc_calibing_r,tdc_calib_finish_r};
//    assign tdc_run = out_sync_reg0[0];
//	assign tdc_calib_en = out_sync_reg0[1];
//reg0
#define TDC_CALIB_CONT XPAR_TDC_CTL_SIG_0_S00_AXI_BASEADDR
//reg1
#define TDC_CALIB_STATUS XPAR_TDC_CTL_SIG_0_S00_AXI_BASEADDR +  4
//----------------------------------------------------------------
// tdc_control machine
#define TDC_RUN_BIT 0x00000001
#define TDC_CALIB_EN_BIT 0x00000002
#define TDC_CALIB_FINISH_EN 0x00000001
#define TDC_CALIBING_BIT 0x00000002
// global variable
extern volatile enum STATUS status;
extern volatile char net_conn_status; // 0:disconnect ;1: cmd connect; 3: data connect;
//extern volatile char calib_ctl;
extern volatile u32 tdc_calib_status;
extern volatile u32 tdc_calib_control;
extern volatile char start_measurement; 
extern volatile char sync_status_topc;
extern volatile char sync_dma_tx_finished;
extern volatile char sync_status_topc_1;

void status_machine();
#endif /* SRC_CONFIG_H_ */
