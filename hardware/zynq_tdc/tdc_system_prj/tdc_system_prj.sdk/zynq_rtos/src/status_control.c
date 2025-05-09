/*
 * status_control.c
 *
 *  Created on: 2024年6月2日
 *      Author: alvinPC
 */
#include "config.h"

volatile enum STATUS status;
volatile char net_conn_status = 0; // 0:disconnect ;1: cmd connect; 3: data connect;
volatile u32 tdc_calib_status = 0;
volatile u32 tdc_calib_control = 0;
volatile char start_measurement = 0; // 开始测量
volatile char sync_status_topc = 0;
volatile char sync_dma_tx_finished = 0;

void setrun()
{
    static char cur_start_measurement = 0;
    if (cur_start_measurement == 0 && start_measurement == 1)
    {
        cur_start_measurement = start_measurement;
        Xil_Out32(TDC_CALIB_CONT, TDC_RUN_BIT);
    }
    else if (cur_start_measurement == 1 && start_measurement == 0)
    {
        cur_start_measurement = start_measurement;
        Xil_Out32(TDC_CALIB_CONT, 0);
    }
}

void status_machine()
{
    status = INIT;
    Xil_Out32(TDC_CALIB_CONT, 0); // stop  measurement
    while (1)
    {
        switch (status)
        {
        case INIT:
            if (net_conn_status == 0x3)  // 0:disconnect ;1: cmd connect; 3: data connect;
                status = CONN_OK;
            break;
        case CONN_OK:
            if (!(tdc_calib_status & TDC_CALIB_FINISH_EN) || (tdc_calib_status & TDC_CALIBING_BIT))
            {
                if (sync_status_topc)
                {
                    Xil_Out32(TDC_CALIB_CONT, TDC_CALIB_EN_BIT);
                    sync_status_topc = 0;
                    status = CALIBING;
                }
            }
            break;
        case CALIBING :
            if (tdc_calib_status & TDC_CALIBING_BIT)
                status = CALIBING;
            else if ((tdc_calib_status & TDC_CALIB_FINISH_EN))
                status = CALIBFIISHED;
            break;

        case CALIBFIISHED :
            if (net_conn_status != 0x3)
                status = CALIBFIISHED;
            else if (sync_status_topc && sync_dma_tx_finished) // DMA 接收完成，并发送完整，且发送状态到上位机
            {
                status = TDC_MEAS;
                sync_status_topc = 0;
                sync_dma_tx_finished = 0;
            }
            else
                status = TDC_PAUSE;
            break;

        case TDC_MEAS :
            if (net_conn_status != 0x3) // connection lost
                status = CALIBFIISHED;
            else if (start_measurement)
            {
                status = TDC_MEAS;
            }
            else
            {
                status = TDC_PAUSE;
            }
            setrun();

            break;

        case TDC_PAUSE :
            if (net_conn_status != 0x3)
                status = CALIBFIISHED;
            else if (start_measurement)
            {
                status = TDC_MEAS;
            }
            else
            {
                status = TDC_PAUSE;
            }
            //            setrun();
            if (sync_dma_tx_finished)
                sync_dma_tx_finished = 0;
            else
                setrun();

        default:
            break;
        }
        vTaskDelay(100 / portTICK_RATE_MS);
    }

    vTaskDelete(NULL);
}
