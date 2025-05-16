vlib work
vlib riviera

vlib riviera/xil_defaultlib

vmap xil_defaultlib riviera/xil_defaultlib

vcom -work xil_defaultlib -93 \
"../../../../tdc_system_prj.srcs/sources_1/ip/TDCchannel_0_1/MyPkg.vhd" \
"../../../../tdc_system_prj.srcs/sources_1/ip/TDCchannel_0_1/risingEdgeDetector.vhd" \
"../../../../tdc_system_prj.srcs/sources_1/ip/TDCchannel_0_1/delayLine.vhd" \
"../../../../tdc_system_prj.srcs/sources_1/ip/TDCchannel_0_1/adderTreeLegacy.vhd" \
"../../../../tdc_system_prj.srcs/sources_1/ip/TDCchannel_0_1/encoder.vhd" \
"../../../../tdc_system_prj.srcs/sources_1/ip/TDCchannel_0_1/counter.vhd" \
"../../../../tdc_system_prj.srcs/sources_1/ip/TDCchannel_0_1/TDCchannel.vhd" \
"../../../../tdc_system_prj.srcs/sources_1/ip/TDCchannel_0_1/sim/TDCchannel_0.vhd" \


