/*
 * calibLookupTab.h
 *
 *  Created on: 2025Äê1ÔÂ30ÈÕ
 *      Author: alvin
 */

#ifndef SRC_TIME_PROC_CALIBLOOKUPTAB_H_
#define SRC_TIME_PROC_CALIBLOOKUPTAB_H_

#include "../config.h"

#define DELAY_UNIT_NUMBER 192
#define DELAY_UNIT_NUMBER_MAX 255

#define BURST_SIZE MAX_PKT_TDC_LEN

#define TDC_CLOCK_PERIOD (float)(1e6 / 350.0) // units : ps
typedef enum
{
    STATE_INIT,
    STATE_Capture_CALIB_DATA,
    STATE_LOOKUP_TABLE_PROCESS,
    STATE_SEND_CALIB_DATA,
    STATE_CALIB_FINAL
} CalibState;

struct SCalibLookupTab
{
    float start_ch[DELAY_UNIT_NUMBER_MAX];
    float stop_ch[DELAY_UNIT_NUMBER_MAX];
    CalibState state;
    u32 recv_number;
    void (*Init)(volatile struct SCalibLookupTab *this);                            /* initialize */
    void (*StateMachine)(volatile struct SCalibLookupTab *this);                    /* state machine */
    char (*CheckStatus)(volatile struct SCalibLookupTab *this);         /* check the status */
    void (*AddBuffer)(volatile struct SCalibLookupTab *this, u8 *buffer, u32 size); /* add data to the  calib_data_buffer */
    void (*LookupTableProcess)(volatile struct SCalibLookupTab *this);              /* process the lookup table */
    void (*Transfer)(volatile struct SCalibLookupTab *this); /* transfer the lookup table to the PC */
};

void calib_proc_thread(void *pvParameters);
extern volatile struct SCalibLookupTab CalibLookupTab;
extern volatile char calib_finish_flag;
#endif /* SRC_TIME_PROC_CALIBLOOKUPTAB_H_ */
