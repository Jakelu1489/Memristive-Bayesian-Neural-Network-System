#include "calibLookupTab.h"
#include "time_cal.h"



// size is bytes number of the buffer
static void Proc(volatile struct SCalDlyTime *this, u32 *buffer, u32 size)
{
    float t;
    u8 start_fine, stop_fine;
    u32 corse;
    for (int i = 0; i < size; i+=2)
       {
           start_fine = buffer[i] & 0x000000FF;
           stop_fine = buffer[i+1] & 0x000000FF;
          corse = ((buffer[i+1] & 0xFFFFFF00)-(buffer[i] & 0xFFFFFF00))>>8;
           t = corse * TDC_CLOCK_PERIOD+CalibLookupTab.start_ch[start_fine]- CalibLookupTab.stop_ch[stop_fine];
           buffer[i>>1] = (u32)t;
       }
}


volatile struct SCalDlyTime CalDlyTime={
    .Proc = Proc
};
