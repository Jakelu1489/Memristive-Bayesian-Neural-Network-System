#ifndef __MEM_CACHE_H__
#define __MEM_CACHE_H__

#include "../config.h"


typedef struct MemCache
{  
    UINTPTR base_address; // index of cache pool
    u32 rx_size; //recv size of index cache pool
} MemCache_T;


typedef struct 
{
    unsigned char front; // «∞∂Àµÿ÷∑
    unsigned char rear; // Œ≤∂Àµÿ÷∑
    MemCache_T index[QUEUE_DEEP_MAX];
    UINTPTR pools[QUEUE_DEEP_MAX];


} QUEUE_T;
  

extern volatile  QUEUE_T queue;



char queue_is_empty();
char queue_pop(MemCache_T *data);
void queue_init();
char queue_push(u32 rx_size, UINTPTR *next_addr);
char queue_is_full();


#endif // __MEM_CACHE_H__