connect -url tcp:127.0.0.1:3121
source C:/Users/liuyx/Desktop/zynq_tdc20250311/tdc_system_prj/tdc_system_prj.sdk/zynq_blk_wrapper_hw_platform_0/ps7_init.tcl
targets -set -nocase -filter {name =~"APU*" && jtag_cable_name =~ "Digilent JTAG-SMT3 210357A7D00EA"} -index 0
loadhw -hw C:/Users/liuyx/Desktop/zynq_tdc20250311/tdc_system_prj/tdc_system_prj.sdk/zynq_blk_wrapper_hw_platform_0/system.hdf -mem-ranges [list {0x40000000 0xbfffffff}]
configparams force-mem-access 1
targets -set -nocase -filter {name =~"APU*" && jtag_cable_name =~ "Digilent JTAG-SMT3 210357A7D00EA"} -index 0
stop
ps7_init
ps7_post_config
targets -set -nocase -filter {name =~ "ARM*#0" && jtag_cable_name =~ "Digilent JTAG-SMT3 210357A7D00EA"} -index 0
rst -processor
targets -set -nocase -filter {name =~ "ARM*#0" && jtag_cable_name =~ "Digilent JTAG-SMT3 210357A7D00EA"} -index 0
dow C:/Users/liuyx/Desktop/zynq_tdc20250311/tdc_system_prj/tdc_system_prj.sdk/zynq_rtos/Debug/zynq_rtos.elf
configparams force-mem-access 0
bpadd -addr &main
