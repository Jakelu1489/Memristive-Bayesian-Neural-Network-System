#ifndef TIME_CAL_H_
#define TIME_CAL_H_
#include "../config.h"
#include "./calibLookupTab.h"

// calulate the delay time

struct SCalDlyTime {
    u32 buffer[MAX_PKT_LEN];
    void (*Proc) (volatile struct SCalDlyTime *this, u32 *buffer, u32 size);
};


extern volatile struct SCalDlyTime CalDlyTime;




#endif /* TIME_CAL_H_ */
