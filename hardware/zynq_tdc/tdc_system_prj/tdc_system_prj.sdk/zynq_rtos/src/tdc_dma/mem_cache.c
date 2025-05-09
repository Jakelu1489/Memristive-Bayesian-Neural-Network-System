
#include "mem_cache.h"
#include "../time_proc/calibLookupTab.h"
#include "../time_proc/time_cal.h"

// #include <string.h>
volatile QUEUE_T queue;
static void tdc_pool_init()
{
    int j;
    for (j = 0; j < QUEUE_DEEP_MAX; ++j)
    {
        queue.pools[j] = MEM_BASE_ADDR + (j * TDC_MEAS_MAX) * (RX_BUFFER_GUARD + MAX_PKT_LEN);
    }
}

void queue_init()
{
    unsigned char i = 0;
    tdc_pool_init();
    queue.front = 0;
    queue.rear = 0;
    for (i = 0; i < QUEUE_DEEP_MAX; i++)
    {
        queue.index[i].base_address = 0;
        queue.index[i].rx_size = -1;
    }
}

char queue_is_full()
{
    if (((queue.front + 1) % QUEUE_DEEP_MAX) == queue.rear)
    {
        return 1;
    }
    else
    {
        return 0;
    }
}

char queue_is_empty()
{
    if (queue.rear == queue.front)
    {
        return 1;
    }
    else
    {
        return 0;
    }
}

char queue_push(u32 rx_size, UINTPTR *next_addr)
{
    MemCache_T data;
    if (queue_is_full())
    {
        return 0;
    }
    if (rx_size == 0) // returen current address only
    {
        next_addr[0] = queue.pools[queue.front];
        return 2;
    }

    //
    if (calib_finish_flag) // calib finish, then process the data
    {
        data.rx_size = rx_size>>1;
        data.base_address = queue.pools[queue.front];
        CalDlyTime.Proc(&CalDlyTime, (u32 *)data.base_address, rx_size);
    }
    else
    {
        // update next addr and push to queue
        data.rx_size = rx_size;
        data.base_address = queue.pools[queue.front];
    }

    queue.index[queue.front] = data;
    queue.front = (queue.front + 1) % QUEUE_DEEP_MAX;
    next_addr[0] = queue.pools[queue.front];
    return 1;
}

//  char queue_push(MemCache_T *data)
// {
//     if (queue_is_full())
//     {
//         return 0;
//     }
//     queue.index[queue.front] = data[0];
//     queue.front = (queue.front + 1) % QUEUE_DEEP_MAX;
//     return 1;
// }

char queue_pop(MemCache_T *data)
{
    if (queue_is_empty())
    {
        return 0;
    }
    *data = queue.index[queue.rear];
    queue.rear = (queue.rear + 1) % QUEUE_DEEP_MAX;
    return 1;
}
