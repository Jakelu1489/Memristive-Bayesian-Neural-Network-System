/*
 * network_mannger.c
 *
 *  Created on: 2024年5月26日
 *      Author: alvinPC
 */

#include "network_mannger.h"
#include "xparameters.h"
#include "netif/xadapter.h"
#include "../platform_config.h"
#include "xil_printf.h"
#include "../cjson/cJSON.h"
#include "../tdc_dma/mem_cache.h"
#include "../config.h"
#include "../dac0501/dac0501.h"

// DAC dac0501
extern volatile char dac_init_flag ;



static struct netif server_netif;
struct netif *echo_netif;
volatile char sync_status_topc_1;
char tdc_data_send_cache[TDC_DATA_SEND_PKG_SIZE];

#ifdef XPS_BOARD_ZCU102
#ifdef XPAR_XIICPS_0_DEVICE_ID
int IicPhyReset(void);
#endif
#endif
char lwip_send_nonblocked(int sd, char *ptr, int size);

#if LWIP_IPV6 == 0
#if LWIP_DHCP == 1
extern volatile int dhcp_timoutcntr;
err_t dhcp_start(struct netif *netif);
#endif
#endif
extern UINTPTR RX_BUFFER_POOLS[QUEUE_DEEP_MAX];
int lwip_thread()
{
#if LWIP_DHCP == 1
	int mscnt = 0;
#endif

#ifdef XPS_BOARD_ZCU102
	IicPhyReset();
#endif

	/* initialize lwIP before calling sys_thread_new */
	lwip_init();
	/* any thread using lwIP should be created using sys_thread_new */
	sys_thread_new("NW_THRD", network_thread, NULL,
				   THREAD_STACKSIZE,
				   DEFAULT_THREAD_PRIO);

#if LWIP_IPV6 == 0
#if LWIP_DHCP == 1
	while (1)
	{
		vTaskDelay(DHCP_FINE_TIMER_MSECS / portTICK_RATE_MS);
		if (server_netif.ip_addr.addr)
		{
			xil_printf("DHCP request success\r\n");
			print_ip_settings(&(server_netif.ip_addr), &(server_netif.netmask), &(server_netif.gw));
			print_echo_app_header();
			xil_printf("\r\n");
			sys_thread_new("echod", echo_application_thread, 0,
						   THREAD_STACKSIZE,
						   DEFAULT_THREAD_PRIO);
			break;
		}
		mscnt += DHCP_FINE_TIMER_MSECS;
		if (mscnt >= 10000)
		{
			xil_printf("ERROR: DHCP request timed out\r\n");
			xil_printf("Configuring default IP of 192.168.1.10\r\n");
			IP4_ADDR(&(server_netif.ip_addr), 192, 168, 1, 10);
			IP4_ADDR(&(server_netif.netmask), 255, 255, 255, 0);
			IP4_ADDR(&(server_netif.gw), 192, 168, 1, 1);
			print_ip_settings(&(server_netif.ip_addr), &(server_netif.netmask), &(server_netif.gw));
			/* print all application headers */
			xil_printf("\r\n");
			xil_printf("%20s %6s %s\r\n", "Server", "Port", "Connect With..");
			xil_printf("%20s %6s %s\r\n", "--------------------", "------", "--------------------");

			print_echo_app_header();
			xil_printf("\r\n");
			sys_thread_new("echod", echo_application_thread, 0,
						   THREAD_STACKSIZE,
						   DEFAULT_THREAD_PRIO);
			break;
		}
	}
#endif
#endif
	vTaskDelete(NULL);
	return 0;
}

void network_thread(void *p)
{
	struct netif *netif;
	/* the mac address of the board. this should be unique per board */
	unsigned char mac_ethernet_address[] = {0x00, 0x0a, 0x35, 0x00, 0x01, 0x02};
#if LWIP_IPV6 == 0
	ip_addr_t ipaddr, netmask, gw;
#if LWIP_DHCP == 1
	int mscnt = 0;
#endif
#endif

	netif = &server_netif;
	xil_printf("\r\n\r\n");
	xil_printf("-----lwIP: start network_thread ------\r\n");

#if LWIP_IPV6 == 0
#if LWIP_DHCP == 0
	/* initliaze IP addresses to be used */
	IP4_ADDR(&ipaddr, 192, 168, 1, 1);
	IP4_ADDR(&netmask, 255, 255, 255, 0);
	IP4_ADDR(&gw, 192, 168, 1, 1);
#endif

	/* print out IP settings of the board */

#if LWIP_DHCP == 0
	print_ip_settings(&ipaddr, &netmask, &gw);
	/* print all application headers */
#endif

#if LWIP_DHCP == 1
	ipaddr.addr = 0;
	gw.addr = 0;
	netmask.addr = 0;
#endif
#endif

#if LWIP_IPV6 == 0
	/* Add network interface to the netif_list, and set it as default */
	if (!xemac_add(netif, &ipaddr, &netmask, &gw, mac_ethernet_address, PLATFORM_EMAC_BASEADDR))
	{
		xil_printf("Error adding N/W interface\r\n");
		return;
	}
#else
	/* Add network interface to the netif_list, and set it as default */
	if (!xemac_add(netif, NULL, NULL, NULL, mac_ethernet_address, PLATFORM_EMAC_BASEADDR))
	{
		xil_printf("Error adding N/W interface\r\n");
		return;
	}

	netif->ip6_autoconfig_enabled = 1;

	netif_create_ip6_linklocal_address(netif, 1);
	netif_ip6_addr_set_state(netif, 0, IP6_ADDR_VALID);

	print_ip6("\n\rBoard IPv6 address ", &netif->ip6_addr[0].u_addr.ip6);
#endif

	netif_set_default(netif);

	/* specify that the network if is up */
	netif_set_up(netif);

	/* start packet receive thread - required for lwIP operation */
	sys_thread_new("xemacif_input_thread", (void (*)(void *))xemacif_input_thread, netif,
				   THREAD_STACKSIZE,
				   DEFAULT_THREAD_PRIO);

#if LWIP_IPV6 == 0
#if LWIP_DHCP == 1
	dhcp_start(netif);
	while (1)
	{
		vTaskDelay(DHCP_FINE_TIMER_MSECS / portTICK_RATE_MS);
		dhcp_fine_tmr();
		mscnt += DHCP_FINE_TIMER_MSECS;
		if (mscnt >= DHCP_COARSE_TIMER_SECS * 1000)
		{
			dhcp_coarse_tmr();
			mscnt = 0;
		}
	}
#else

	//    print_echo_app_header();
	//	xil_printf("\r\n");
	//    sys_thread_new("echod", echo_application_thread, 0,
	//		THREAD_STACKSIZE,
	//		DEFAULT_THREAD_PRIO);

	sys_thread_new("cmd_thrd", socket_cmd_thread, 0,
				   THREAD_STACKSIZE,
				   DEFAULT_THREAD_PRIO);

	sys_thread_new("data_thrd", socket_data_thread, 0,
				   THREAD_STACKSIZE,
				   DEFAULT_THREAD_PRIO);

	vTaskDelete(NULL);
#endif
#else
	print_echo_app_header();
	xil_printf("\r\n");
	sys_thread_new("echod", echo_application_thread, 0,
				   THREAD_STACKSIZE,
				   DEFAULT_THREAD_PRIO);
	vTaskDelete(NULL);
#endif
	return;
}

void socket_cmd_thread(void *p)
{
	int sock, new_sd;
	int size;
	struct sockaddr_in address, remote;
	int nonblock = 1;
	ioctlsocket(sock, FIONBIO, &nonblock); // non block mode
	memset(&address, 0, sizeof(address));
	if ((sock = lwip_socket(AF_INET, SOCK_STREAM, 0)) < 0)
		return;

	ioctlsocket(sock, FIONBIO, &nonblock); // non block mode

	address.sin_family = AF_INET;
	address.sin_port = htons(CMD_PORT);
	address.sin_addr.s_addr = INADDR_ANY;

	if (lwip_bind(sock, (struct sockaddr *)&address, sizeof(address)) < 0)
		return;

	lwip_listen(sock, 0);

	size = sizeof(remote);

	while (1)
	{

		if ((new_sd = lwip_accept(sock, (struct sockaddr *)&remote, (socklen_t *)&size)) > 0)
		{
			sys_thread_new("cmd_req_thrd", process_socket_cmd_request_thread,
						   (void *)new_sd,
						   THREAD_STACKSIZE,
						   DEFAULT_THREAD_PRIO);
			xil_printf("cmd_req_thrd  on process_socket_cmd_request_thread \r\n");
		}
		vTaskDelay(2000 / portTICK_RATE_MS);
		xil_printf("cmd_req_thrd watting on port %d,%d\r\n", status, sync_status_topc);
	}
}
extern volatile u32 send_pc;
extern volatile u32 send_pc_size;
extern volatile u32 send_pc_address;
volatile u32 new_sd;
char recv_buf[1024];

void socket_data_thread(void *p)
{
	int sock, new_sd;
	int size;
	int nonblock = 1;
	struct sockaddr_in address, remote;
	memset(&address, 0, sizeof(address));
	ioctlsocket(sock, FIONBIO, &nonblock); // non block mode

	if ((sock = lwip_socket(AF_INET, SOCK_STREAM, 0)) < 0)
		return;
	ioctlsocket(sock, FIONBIO, &nonblock); // non block mode

	address.sin_family = AF_INET;
	address.sin_port = htons(DATA_PORT);
	address.sin_addr.s_addr = INADDR_ANY;

	if (lwip_bind(sock, (struct sockaddr *)&address, sizeof(address)) < 0)
		return;

	lwip_listen(sock, 0);
	size = sizeof(remote);
	while (1)
	{
		if ((new_sd = lwip_accept(sock, (struct sockaddr *)&remote, (socklen_t *)&size)) > 0)
		{
			sys_thread_new("data_req_thrd", process_socket_data_request_thread,
						   (void *)new_sd,
						   THREAD_STACKSIZE,
						   TCPIP_THREAD_PRIO);
			xil_printf("data_req_thrd  on process_socket_data_request_thread \r\n");
		}
		vTaskDelay(2000 / portTICK_RATE_MS);
		xil_printf("socket_data_thread watting on port \r\n");
	}
}

char lwip_send_nonblocked(int sd, char *ptr, int size)
{
	int len;
	int timeout = 0;
	while (1)
	{
		++timeout;
		if (timeout >= 10000)
			return -1;
		len = write(sd, ptr, size);
		if (len <= 0)
		{
			vTaskDelay(0.1 / portTICK_RATE_MS);
			continue;
		}
		if (len == size)
			return 1;
		ptr += len;
		size -= len;
	}
}

void cjson_parse_errorhandle(int sd, cJSON *cjson_reponse, char error_code)
{
	char *str;
	cJSON_ReplaceItemInObject(cjson_reponse, "status", cJSON_CreateNumber(error_code));
	str = cJSON_Print(cjson_reponse);
	lwip_send_nonblocked(sd, str, strlen(str));
	free(str);
}
// 提取参数错误处理
char cjson_params_parse_error(int sd, cJSON *cjson_params, cJSON *cjson_reponse, cJSON *params[], const char *key)
{
	params[0] = cJSON_GetObjectItem(cjson_params, key);
	if (params[0] == NULL || params[0]->type == cJSON_NULL) // 解析错误：-1
	{
		cjson_parse_errorhandle(sd, cjson_reponse, -1);
		cJSON_Delete(params[0]);
		return -1;
	}
	return 1;
}
//{"index":2,"volt_ref":3.12,"start":1,"protocol":0}
void process_socket_cmd_request_thread(void *p)
{
	int sd = (int)p;
	const int RECV_BUF_SIZE = 1024;
	char recv_buf[RECV_BUF_SIZE];
	int n;
	int index;
	float volt_ref = 0;
	int nonblock = 1;
	ioctlsocket(sd, FIONBIO, &nonblock); // non block mode

	//	char start=0;
	cJSON *cjson_reponse = NULL;
	cJSON *cjson_params = NULL;
	cJSON *tmp[4]; // start,vlot_ref,index,protocal
	char *str = NULL;
	cjson_reponse = cJSON_CreateObject();
	cJSON_AddNumberToObject(cjson_reponse, "status", 1); // 1表示通信正确，0表示通信错误，2表示校准，3表示正常采集
	cJSON_AddNumberToObject(cjson_reponse, "index", 1);	 
	start_measurement = 0;
	net_conn_status = net_conn_status | 0x1;

	while (1)
	{
		if (status == CONN_OK && !sync_status_topc)
		{
			cJSON_AddNumberToObject(cjson_reponse, "status", 2);
			str = cJSON_Print(cjson_reponse);
			lwip_send_nonblocked(sd, str, strlen(str));
			sync_status_topc = 1;
			vTaskDelay(1000 / portTICK_RATE_MS);
			xil_printf("status == CONN_OK  on process_socket_data_request_thread \r\n");
		}
		else if ((status == TDC_PAUSE || status == CALIBFIISHED) && !sync_status_topc) // 发送剩余数据
		{
			cJSON_AddNumberToObject(cjson_reponse, "status", 3);
			str = cJSON_Print(cjson_reponse);
			lwip_send_nonblocked(sd, str, strlen(str));
			sync_status_topc = 1;
			calib_finish_flag = 1;
			vTaskDelay(100 / portTICK_RATE_MS);
		}
		vTaskDelay(1000 / portTICK_RATE_MS);

		/* read a max of RECV_BUF_SIZE bytes from socket */
		if ((n = read(sd, recv_buf, RECV_BUF_SIZE)) < 0)
		{
			// xil_printf("%s: error reading from  socket %d, closing socket\r\n", __FUNCTION__, sd);
			vTaskDelay(SOCK_WAIT_TIMER_MSECS / portTICK_RATE_MS);
			continue;
		}

		/* break if the recved message = "quit" */
		//		if (!strncmp(recv_buf, "quit", 4))
		//			break;

		/* break if client closed connection */
		if (n == 0)
		{
			vTaskDelay(SOCK_WAIT_TIMER_MSECS / portTICK_RATE_MS);
			continue;
		}

		/* handle request */
		// 解析数据
		cjson_params = cJSON_Parse(recv_buf);
		const char *error_ptr = cJSON_GetErrorPtr();
		if (error_ptr != NULL) // 解析错误-1；
		{
			xil_printf("Error before: %s\n", error_ptr);
			cjson_parse_errorhandle(sd, cjson_reponse, -1);
			cJSON_Delete(cjson_params);
			continue;
		}
		tmp[3] = cJSON_GetObjectItem(cjson_params, "protocol");

		if (tmp[3] == NULL || tmp[3]->type == cJSON_NULL) // 解析错误：-1
		{
			cjson_parse_errorhandle(sd, cjson_reponse, -1);
			cJSON_Delete(cjson_params);
			continue;
		}

		if (tmp[3]->valueint != 0) // protocol is available：-2
		{
			cjson_parse_errorhandle(sd, cjson_reponse, -2);
			cJSON_Delete(cjson_params);
			continue;
		}
		if (cjson_params_parse_error(sd, cjson_params, cjson_reponse, tmp + 1, "volt_ref") == 1)
		{
			volt_ref = tmp[1]->valuedouble;
			volt_ref = volt_ref/1000;
			printf("set ref volt to %f \r\n ",volt_ref);
			SetVoltage(volt_ref);
		}
		if (cjson_params_parse_error(sd, cjson_params, cjson_reponse, tmp + 2, "index") == 1)
		{
			index = tmp[2]->valueint;
		}

		if (cjson_params_parse_error(sd, cjson_params, cjson_reponse, tmp, "start") == 1)
		{
			//			start =tmp[0]->valueint;
			start_measurement = tmp[0]->valueint;
		}

		cJSON_Delete(cjson_params);
		xil_printf("start: %d\r\n index: %d\r\n", start_measurement, index);
		//		cJSON_ReplaceItemInObject(cjson_reponse, "index", cJSON_CreateNumber(index));
		//		cjson_parse_errorhandle(sd,  cjson_reponse, 0);
	}
	/* close connection */
	close(sd);
	net_conn_status = net_conn_status & (~0x1);
	vTaskDelete(NULL);
}

void process_socket_data_request_thread(void *p)
{

	int sd = (int)p;
//	const int RECV_BUF_SIZE = 1024;
	//int n;
	u32 address_cache;
	u32 send_size;
	u32 send_size_once;
	net_conn_status = net_conn_status | (0x2);
	sync_status_topc_1 = 0;
	// tdc_data_send_cache
	u32 total_size = 0;
	MemCache_T address;
	while (1)
	{

		if (queue_pop(&address))
		{
			send_size = address.rx_size;
			address_cache = address.base_address;
			total_size += send_size;
			xil_printf("%d,%x,%d\r\n",send_size,address_cache,total_size);
			if(send_size  <= 0)
				continue;
			while (1)
			{
				if (send_size > TDC_DATA_SEND_PKG_SIZE)
				{
					send_size_once = TDC_DATA_SEND_PKG_SIZE;
					send_size -= TDC_DATA_SEND_PKG_SIZE;
				}
				else
				{
					send_size_once = send_size;
					send_size = 0;
					// send_pc = 0;
				}
				memcpy(tdc_data_send_cache, (char *)address_cache, send_size_once);
				CalibLookupTab.AddBuffer(&CalibLookupTab, tdc_data_send_cache, send_size_once);
				if (lwip_send_nonblocked(sd, tdc_data_send_cache, send_size_once) < 0)
					xil_printf("error on tdc_data_send_cache \r\n");
				if (send_size == 0)
				{
					if ((status == TDC_PAUSE || status == CALIBFIISHED) && queue_is_empty())
						sync_status_topc_1 = 1;
					break;
				}
				vTaskDelay(1 / portTICK_RATE_MS); // 1ms
				address_cache += send_size_once;
			}
		}
		else
		{
			xil_printf("total_size:%d \r\n",total_size);
			vTaskDelay(1000 / portTICK_RATE_MS);

		}


		// if (status == TDC_PAUSE || status == CALIBFIISHED) // 发送剩余数据
		// {
		// 	if (sync_dma_tx_finished)
		// 	{
		// 		if (send_pc)
		// 		{
		// 			send_size = send_pc_size;
		// 			address_cache = send_pc_address;
		// 			while (1)
		// 			{
		// 				if (send_size > TDC_DATA_SEND_PKG_SIZE)
		// 				{
		// 					send_size_once = TDC_DATA_SEND_PKG_SIZE;
		// 					send_size -= TDC_DATA_SEND_PKG_SIZE;
		// 				}
		// 				else
		// 				{
		// 					send_size_once = send_size;
		// 					send_size = 0;
		// 					send_pc = 0;
		// 				}
		// 				memcpy(tdc_data_send_cache, (char *)address_cache, send_size_once);
		// 				if (lwip_send_nonblocked(sd, tdc_data_send_cache, send_size_once) < 0)
		// 					xil_printf("error on tdc_data_send_cache \r\n");
		// 				if (send_size == 0)
		// 				{
		// 					sync_status_topc_1 = 1;
		// 					break;
		// 				}
		// 				vTaskDelay(0.001 / portTICK_RATE_MS); // 1us
		// 				address_cache += send_size_once;
		// 			}
		// 		}
		// 		else
		// 			vTaskDelay(100 / portTICK_RATE_MS); // 10us
		// 	}
		// 	else
		// 		vTaskDelay(100 / portTICK_RATE_MS); // 10us
		// }
		// else if (status == CALIBING || status == TDC_MEAS)
		// 	{
		// 	if (send_pc)
		// 	{
		// 		send_size = send_pc_size;
		// 		address_cache = send_pc_address;
		// 		while (1)
		// 		{
		// 			if (send_size > TDC_DATA_SEND_PKG_SIZE)
		// 			{
		// 				send_size_once = TDC_DATA_SEND_PKG_SIZE;
		// 				send_size -= TDC_DATA_SEND_PKG_SIZE;
		// 			}
		// 			else
		// 			{
		// 				send_size_once = send_size;
		// 				send_size = 0;
		// 				send_pc = 0;
		// 			}

		// 			memcpy(tdc_data_send_cache, (char *)address_cache, send_size_once);
		// 			if (lwip_send_nonblocked(sd, tdc_data_send_cache, send_size_once) < 0)
		// 				xil_printf("error on tdc_data_send_cache \r\n");
		// 			if (send_size == 0)
		// 				break;
		// 			address_cache += send_size_once;
		// 			vTaskDelay(1 / portTICK_RATE_MS); // 1us
		// 		}
		// 	}
		// 	else
		// 		vTaskDelay(100 / portTICK_RATE_MS); // 10us
		// 	}
		// 	else
		// 		vTaskDelay(100 / portTICK_RATE_MS); // 10us
	}
	//		/* close connection */
	close(sd);
	net_conn_status = net_conn_status & (~0x2);
	vTaskDelete(NULL);
}

#if LWIP_IPV6 == 1
void print_ip6(char *msg, ip_addr_t *ip)
{
	print(msg);
	xil_printf(" %x:%x:%x:%x:%x:%x:%x:%x\n\r",
			   IP6_ADDR_BLOCK1(&ip->u_addr.ip6),
			   IP6_ADDR_BLOCK2(&ip->u_addr.ip6),
			   IP6_ADDR_BLOCK3(&ip->u_addr.ip6),
			   IP6_ADDR_BLOCK4(&ip->u_addr.ip6),
			   IP6_ADDR_BLOCK5(&ip->u_addr.ip6),
			   IP6_ADDR_BLOCK6(&ip->u_addr.ip6),
			   IP6_ADDR_BLOCK7(&ip->u_addr.ip6),
			   IP6_ADDR_BLOCK8(&ip->u_addr.ip6));
}

#else
void print_ip(char *msg, ip_addr_t *ip)
{
	xil_printf(msg);
	xil_printf("%d.%d.%d.%d\n\r", ip4_addr1(ip), ip4_addr2(ip),
			   ip4_addr3(ip), ip4_addr4(ip));
}

void print_ip_settings(ip_addr_t *ip, ip_addr_t *mask, ip_addr_t *gw)
{

	print_ip("Board IP: ", ip);
	print_ip("Netmask : ", mask);
	print_ip("Gateway : ", gw);
}

#endif
