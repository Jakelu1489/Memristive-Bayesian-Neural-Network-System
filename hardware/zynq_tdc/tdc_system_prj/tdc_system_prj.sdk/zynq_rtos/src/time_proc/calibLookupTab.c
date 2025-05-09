#include "calibLookupTab.h"
#include <stdio.h>
// volatile static u8  calib_data_buffer[MAX_PKT_LEN];
// volatile static u8  start_buffer[MAX_PKT_TDC_LEN];
// volatile static u8  stop_buffer[MAX_PKT_TDC_LEN];

volatile char calib_finish_flag;
void calib_proc_thread(void *pvParameters)
{
    while (1)
    {
        CalibLookupTab.StateMachine(&CalibLookupTab);
        vTaskDelay(100 / portTICK_RATE_MS); // 100ms
    }
    vTaskDelete(NULL);
}

static void Init(volatile struct SCalibLookupTab *this)
{
    // Initialize the lookup table with the default values
    for (int i = 0; i < DELAY_UNIT_NUMBER_MAX; i++)
    {
        this->start_ch[i] = 0.0;
        this->stop_ch[i] = 0.0;
    }
    calib_finish_flag = 0;
    this->state = STATE_INIT;
}

static void StateMachine(volatile struct SCalibLookupTab *this)
{

    switch (this->state)
    {
    case STATE_INIT: // Initialize the lookup table
        this->Init(this);
        this->state = STATE_Capture_CALIB_DATA;
        break;
    case STATE_Capture_CALIB_DATA: // Implement the logic for the calib lookup table
        // wait for the buffer to be full
        if (calib_finish_flag)
        {
            this->state = STATE_LOOKUP_TABLE_PROCESS;
        }
        break;
    case STATE_LOOKUP_TABLE_PROCESS:
        // Implement the logic for the LOOKUP_TABLE_PROCESS state
        this->LookupTableProcess(this);
        this->state = STATE_SEND_CALIB_DATA;
        break;
    case STATE_SEND_CALIB_DATA:
        this->Transfer(this);
        this->state = STATE_CALIB_FINAL;
        // Implement the logic for the SEND_CALIB_DATA state
        break;
    case STATE_CALIB_FINAL:
        // Implement the logic for the CALIB_FINAL state
        vTaskDelay(1000 / portTICK_RATE_MS); // 1s
        break;
    default:
        // Handle the default case
        break;
    }
}

static void AddBuffer(volatile struct SCalibLookupTab *this, u8 *buffer, u32 size)
{
    // split the buffer data into start and stop buffers, little-endian
    //  and to histogram
    if (this->state == STATE_CALIB_FINAL)
        return;
    for (int i = 0; i < size; i += 8)
    {
        this->start_ch[buffer[i] - 1] += 1.0;    // start channel
        this->stop_ch[buffer[i + 4] - 1] += 1.0; // stop channel
        this->recv_number++;
    }
}

static char CheckStatus(volatile struct SCalibLookupTab *this)
{
    if (this->state == STATE_CALIB_FINAL)
        return 1;
    else
        return 0;
}

static void LookupTableProcess(volatile struct SCalibLookupTab *this)
{
    // Implement the logic for the lookup table process
    // check
    u8 flag = 0;
    double w_sum_start = 0, w_sum_stop = 0;
    double w_sum_cache = 0;
    // DELAY_UNIT_NUMBER:DELAY_UNIT_NUMBER_MAX must to be 0
    for (int i = DELAY_UNIT_NUMBER; i < DELAY_UNIT_NUMBER_MAX; i++)
    {
        if (this->start_ch[i] > 1.0)
        {
            flag++;
            this->recv_number--; // remove the invalid data
        }
        if (this->stop_ch[i] > 1.0)
        {
            flag++;
            this->recv_number--; // remove the invalid data
        }
    }
    if (flag > 0)
    {
        xil_printf("LookupTableProcessError: invalid data in the buffer\n");
        flag = 0;
    }
    if(this->recv_number==0)
    {
        xil_printf("LookupTableProcessError: buffer is empty\n");
        return ;
    }
    // calculate the average of the start and stop buffers, Wi=Ni/N*TDC_CLOCK_PERIOD
    for (int i = 0; i < DELAY_UNIT_NUMBER; i++)
    {
        this->start_ch[i] = this->start_ch[i] / (float)this->recv_number * TDC_CLOCK_PERIOD;
        this->stop_ch[i] = this->stop_ch[i] / (float)this->recv_number * TDC_CLOCK_PERIOD;
    }
    // and store the result in the lookup table
    w_sum_start = 0;
    w_sum_stop = 0;
    for (int i = 0; i < DELAY_UNIT_NUMBER; i++)
    {
        w_sum_cache = w_sum_start + this->start_ch[i] / 2.0;
        w_sum_start += this->start_ch[i];
        this->start_ch[i] = w_sum_cache;

        w_sum_cache = w_sum_stop + this->stop_ch[i] / 2.0;
        w_sum_stop += this->stop_ch[i];
        this->stop_ch[i] = w_sum_cache;
    }
}

static void Transfer(volatile struct SCalibLookupTab *this)
{
    static char buffer[32];
    
    // printf the start and stop buffers
    xil_printf("start\n");
    for (int i = 0; i < DELAY_UNIT_NUMBER; i++)
    {
        //sprintf(buffer, "start_ch[%d]: %f\n", i, this->start_ch[i]);
    	sprintf(buffer, "%f\n", this->start_ch[i]);
        xil_printf(buffer);
    }
    xil_printf("stop\n");
    for (int i = 0; i < DELAY_UNIT_NUMBER; i++)
    {
        // xil_printf("stop_ch[%d]: %f\n", i, this->stop_ch[i]);
//        sprintf(buffer, "stop_ch[%d]: %f\n", i, this->stop_ch[i]);
        sprintf(buffer, "%f\n", this->stop_ch[i]);
        xil_printf(buffer);
    }
}

volatile struct SCalibLookupTab CalibLookupTab = {
    .state = STATE_INIT,
    .recv_number = 0,
    .Init = Init,
    .StateMachine = StateMachine,
    .AddBuffer = AddBuffer,
    .CheckStatus = CheckStatus,
    .LookupTableProcess = LookupTableProcess,
    .Transfer = Transfer};
