/*
 * network_mannger.h
 *
 *  Created on: 2024��5��26��
 *      Author: alvinPC
 */

#ifndef SRC_NETWORK_NETWORK_MANNGER_H_
#define SRC_NETWORK_NETWORK_MANNGER_H_
#include "../config.h"
#include "netif/xadapter.h"
#include "lwip/sockets.h"
#include "lwipopts.h"
#include "FreeRTOS.h"
#include "task.h"
#include "../time_proc/calibLookupTab.h"


#define CMD_PORT 1000
#define DATA_PORT 2000
//extern volatile u32 start_measurement;

#define SOCK_WAIT_TIMER_MSECS 200   /* milliseconds*/
extern struct netif *echo_netif;

void lwip_init();
int lwip_thread();
void network_thread(void *p);
void socket_cmd_thread(void *p);
void socket_data_thread(void *p);
void process_socket_cmd_request_thread(void *p);
void process_socket_data_request_thread(void *p);


void print_ip(char *msg, ip_addr_t *ip);
void print_ip_settings(ip_addr_t *ip, ip_addr_t *mask, ip_addr_t *gw);


#endif /* SRC_NETWORK_NETWORK_MANNGER_H_ */
