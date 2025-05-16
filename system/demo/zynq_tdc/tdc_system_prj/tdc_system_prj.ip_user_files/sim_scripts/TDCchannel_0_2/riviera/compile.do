vlib work
vlib riviera

vlib riviera/xil_defaultlib

vmap xil_defaultlib riviera/xil_defaultlib

vcom -work xil_defaultlib -93 \
"../../../../tdc_system_prj.srcs/sources_1/ip/TDCchannel_0_2/MyPkg.vhd" \
"../../../../tdc_system_prj.srcs/sources_1/ip/TDCchannel_0_2/risingEdgeDetector.vhd" \
"../../../../tdc_system_prj.srcs/sources_1/ip/TDCchannel_0_2/delayLine.vhd" \
"../../../../tdc_system_prj.srcs/sources_1/ip/TDCchannel_0_2/adderTreeLegacy.vhd" \
"../../../../tdc_system_prj.srcs/sources_1/ip/TDCchannel_0_2/encoder.vhd" \
"../../../../tdc_system_prj.srcs/sources_1/ip/TDCchannel_0_2/counter.vhd" \
"../../../../tdc_system_prj.srcs/sources_1/ip/TDCchannel_0_2/TDCchannel.vhd" \
"../../../../tdc_system_prj.srcs/sources_1/ip/TDCchannel_0_2/sim/TDCchannel_0.vhd" \


