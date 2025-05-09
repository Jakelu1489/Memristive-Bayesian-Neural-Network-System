vlib questa_lib/work
vlib questa_lib/msim

vlib questa_lib/msim/xil_defaultlib

vmap xil_defaultlib questa_lib/msim/xil_defaultlib

vcom -work xil_defaultlib -64 -93 \
"../../../../tdc_system_prj.srcs/sources_1/ip/TDCchannel_0_1/MyPkg.vhd" \
"../../../../tdc_system_prj.srcs/sources_1/ip/TDCchannel_0_1/risingEdgeDetector.vhd" \
"../../../../tdc_system_prj.srcs/sources_1/ip/TDCchannel_0_1/delayLine.vhd" \
"../../../../tdc_system_prj.srcs/sources_1/ip/TDCchannel_0_1/adderTreeLegacy.vhd" \
"../../../../tdc_system_prj.srcs/sources_1/ip/TDCchannel_0_1/encoder.vhd" \
"../../../../tdc_system_prj.srcs/sources_1/ip/TDCchannel_0_1/counter.vhd" \
"../../../../tdc_system_prj.srcs/sources_1/ip/TDCchannel_0_1/TDCchannel.vhd" \
"../../../../tdc_system_prj.srcs/sources_1/ip/TDCchannel_0_1/sim/TDCchannel_0.vhd" \


