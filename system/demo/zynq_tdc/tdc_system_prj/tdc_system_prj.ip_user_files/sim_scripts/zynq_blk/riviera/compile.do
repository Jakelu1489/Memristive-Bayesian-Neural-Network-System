vlib work
vlib riviera

vlib riviera/xilinx_vip
vlib riviera/xil_defaultlib
vlib riviera/xpm
vlib riviera/axi_infrastructure_v1_1_0
vlib riviera/axi_vip_v1_1_4
vlib riviera/processing_system7_vip_v1_0_6
vlib riviera/work
vlib riviera/axis_infrastructure_v1_1_0
vlib riviera/axis_data_fifo_v2_0_0
vlib riviera/lib_pkg_v1_0_2
vlib riviera/fifo_generator_v13_2_3
vlib riviera/lib_fifo_v1_0_12
vlib riviera/lib_srl_fifo_v1_0_2
vlib riviera/lib_cdc_v1_0_2
vlib riviera/axi_datamover_v5_1_20
vlib riviera/axi_sg_v4_1_11
vlib riviera/axi_dma_v7_1_19
vlib riviera/xlconstant_v1_1_5
vlib riviera/proc_sys_reset_v5_0_13
vlib riviera/smartconnect_v1_0
vlib riviera/generic_baseblocks_v2_1_0
vlib riviera/axi_register_slice_v2_1_18
vlib riviera/axi_data_fifo_v2_1_17
vlib riviera/axi_crossbar_v2_1_19
vlib riviera/axi_lite_ipif_v3_0_4
vlib riviera/interrupt_control_v3_1_4
vlib riviera/axi_gpio_v2_0_20
vlib riviera/axi_protocol_converter_v2_1_18

vmap xilinx_vip riviera/xilinx_vip
vmap xil_defaultlib riviera/xil_defaultlib
vmap xpm riviera/xpm
vmap axi_infrastructure_v1_1_0 riviera/axi_infrastructure_v1_1_0
vmap axi_vip_v1_1_4 riviera/axi_vip_v1_1_4
vmap processing_system7_vip_v1_0_6 riviera/processing_system7_vip_v1_0_6
vmap work riviera/work
vmap axis_infrastructure_v1_1_0 riviera/axis_infrastructure_v1_1_0
vmap axis_data_fifo_v2_0_0 riviera/axis_data_fifo_v2_0_0
vmap lib_pkg_v1_0_2 riviera/lib_pkg_v1_0_2
vmap fifo_generator_v13_2_3 riviera/fifo_generator_v13_2_3
vmap lib_fifo_v1_0_12 riviera/lib_fifo_v1_0_12
vmap lib_srl_fifo_v1_0_2 riviera/lib_srl_fifo_v1_0_2
vmap lib_cdc_v1_0_2 riviera/lib_cdc_v1_0_2
vmap axi_datamover_v5_1_20 riviera/axi_datamover_v5_1_20
vmap axi_sg_v4_1_11 riviera/axi_sg_v4_1_11
vmap axi_dma_v7_1_19 riviera/axi_dma_v7_1_19
vmap xlconstant_v1_1_5 riviera/xlconstant_v1_1_5
vmap proc_sys_reset_v5_0_13 riviera/proc_sys_reset_v5_0_13
vmap smartconnect_v1_0 riviera/smartconnect_v1_0
vmap generic_baseblocks_v2_1_0 riviera/generic_baseblocks_v2_1_0
vmap axi_register_slice_v2_1_18 riviera/axi_register_slice_v2_1_18
vmap axi_data_fifo_v2_1_17 riviera/axi_data_fifo_v2_1_17
vmap axi_crossbar_v2_1_19 riviera/axi_crossbar_v2_1_19
vmap axi_lite_ipif_v3_0_4 riviera/axi_lite_ipif_v3_0_4
vmap interrupt_control_v3_1_4 riviera/interrupt_control_v3_1_4
vmap axi_gpio_v2_0_20 riviera/axi_gpio_v2_0_20
vmap axi_protocol_converter_v2_1_18 riviera/axi_protocol_converter_v2_1_18

vlog -work xilinx_vip  -sv2k12 "+incdir+D:/xilinx/Vivado/2018.3/data/xilinx_vip/include" \
"D:/xilinx/Vivado/2018.3/data/xilinx_vip/hdl/axi4stream_vip_axi4streampc.sv" \
"D:/xilinx/Vivado/2018.3/data/xilinx_vip/hdl/axi_vip_axi4pc.sv" \
"D:/xilinx/Vivado/2018.3/data/xilinx_vip/hdl/xil_common_vip_pkg.sv" \
"D:/xilinx/Vivado/2018.3/data/xilinx_vip/hdl/axi4stream_vip_pkg.sv" \
"D:/xilinx/Vivado/2018.3/data/xilinx_vip/hdl/axi_vip_pkg.sv" \
"D:/xilinx/Vivado/2018.3/data/xilinx_vip/hdl/axi4stream_vip_if.sv" \
"D:/xilinx/Vivado/2018.3/data/xilinx_vip/hdl/axi_vip_if.sv" \
"D:/xilinx/Vivado/2018.3/data/xilinx_vip/hdl/clk_vip_if.sv" \
"D:/xilinx/Vivado/2018.3/data/xilinx_vip/hdl/rst_vip_if.sv" \

vlog -work xil_defaultlib  -sv2k12 "+incdir+../../../../tdc_system_prj.srcs/sources_1/bd/zynq_blk/ipshared/ec67/hdl" "+incdir+../../../../tdc_system_prj.srcs/sources_1/bd/zynq_blk/ipshared/70cf/hdl" "+incdir+../../../../tdc_system_prj.srcs/sources_1/bd/zynq_blk/ipshared/8713/hdl" "+incdir+../../../../tdc_system_prj.srcs/sources_1/bd/zynq_blk/ipshared/979d/hdl/verilog" "+incdir+../../../../tdc_system_prj.srcs/sources_1/bd/zynq_blk/ipshared/b2d0/hdl/verilog" "+incdir+../../../../tdc_system_prj.srcs/sources_1/bd/zynq_blk/ipshared/85a3" "+incdir+../../../../tdc_system_prj.srcs/sources_1/bd/zynq_blk/ip/zynq_blk_processing_system7_0_0" "+incdir+D:/xilinx/Vivado/2018.3/data/xilinx_vip/include" \
"D:/xilinx/Vivado/2018.3/data/ip/xpm/xpm_cdc/hdl/xpm_cdc.sv" \
"D:/xilinx/Vivado/2018.3/data/ip/xpm/xpm_fifo/hdl/xpm_fifo.sv" \
"D:/xilinx/Vivado/2018.3/data/ip/xpm/xpm_memory/hdl/xpm_memory.sv" \

vcom -work xpm -93 \
"D:/xilinx/Vivado/2018.3/data/ip/xpm/xpm_VCOMP.vhd" \

vlog -work axi_infrastructure_v1_1_0  -v2k5 "+incdir+../../../../tdc_system_prj.srcs/sources_1/bd/zynq_blk/ipshared/ec67/hdl" "+incdir+../../../../tdc_system_prj.srcs/sources_1/bd/zynq_blk/ipshared/70cf/hdl" "+incdir+../../../../tdc_system_prj.srcs/sources_1/bd/zynq_blk/ipshared/8713/hdl" "+incdir+../../../../tdc_system_prj.srcs/sources_1/bd/zynq_blk/ipshared/979d/hdl/verilog" "+incdir+../../../../tdc_system_prj.srcs/sources_1/bd/zynq_blk/ipshared/b2d0/hdl/verilog" "+incdir+../../../../tdc_system_prj.srcs/sources_1/bd/zynq_blk/ipshared/85a3" "+incdir+../../../../tdc_system_prj.srcs/sources_1/bd/zynq_blk/ip/zynq_blk_processing_system7_0_0" "+incdir+D:/xilinx/Vivado/2018.3/data/xilinx_vip/include" \
"../../../../tdc_system_prj.srcs/sources_1/bd/zynq_blk/ipshared/ec67/hdl/axi_infrastructure_v1_1_vl_rfs.v" \

vlog -work axi_vip_v1_1_4  -sv2k12 "+incdir+../../../../tdc_system_prj.srcs/sources_1/bd/zynq_blk/ipshared/ec67/hdl" "+incdir+../../../../tdc_system_prj.srcs/sources_1/bd/zynq_blk/ipshared/70cf/hdl" "+incdir+../../../../tdc_system_prj.srcs/sources_1/bd/zynq_blk/ipshared/8713/hdl" "+incdir+../../../../tdc_system_prj.srcs/sources_1/bd/zynq_blk/ipshared/979d/hdl/verilog" "+incdir+../../../../tdc_system_prj.srcs/sources_1/bd/zynq_blk/ipshared/b2d0/hdl/verilog" "+incdir+../../../../tdc_system_prj.srcs/sources_1/bd/zynq_blk/ipshared/85a3" "+incdir+../../../../tdc_system_prj.srcs/sources_1/bd/zynq_blk/ip/zynq_blk_processing_system7_0_0" "+incdir+D:/xilinx/Vivado/2018.3/data/xilinx_vip/include" \
"../../../../tdc_system_prj.srcs/sources_1/bd/zynq_blk/ipshared/98af/hdl/axi_vip_v1_1_vl_rfs.sv" \

vlog -work processing_system7_vip_v1_0_6  -sv2k12 "+incdir+../../../../tdc_system_prj.srcs/sources_1/bd/zynq_blk/ipshared/ec67/hdl" "+incdir+../../../../tdc_system_prj.srcs/sources_1/bd/zynq_blk/ipshared/70cf/hdl" "+incdir+../../../../tdc_system_prj.srcs/sources_1/bd/zynq_blk/ipshared/8713/hdl" "+incdir+../../../../tdc_system_prj.srcs/sources_1/bd/zynq_blk/ipshared/979d/hdl/verilog" "+incdir+../../../../tdc_system_prj.srcs/sources_1/bd/zynq_blk/ipshared/b2d0/hdl/verilog" "+incdir+../../../../tdc_system_prj.srcs/sources_1/bd/zynq_blk/ipshared/85a3" "+incdir+../../../../tdc_system_prj.srcs/sources_1/bd/zynq_blk/ip/zynq_blk_processing_system7_0_0" "+incdir+D:/xilinx/Vivado/2018.3/data/xilinx_vip/include" \
"../../../../tdc_system_prj.srcs/sources_1/bd/zynq_blk/ipshared/70cf/hdl/processing_system7_vip_v1_0_vl_rfs.sv" \

vlog -work work  -v2k5 "+incdir+../../../../tdc_system_prj.srcs/sources_1/bd/zynq_blk/ipshared/ec67/hdl" "+incdir+../../../../tdc_system_prj.srcs/sources_1/bd/zynq_blk/ipshared/70cf/hdl" "+incdir+../../../../tdc_system_prj.srcs/sources_1/bd/zynq_blk/ipshared/8713/hdl" "+incdir+../../../../tdc_system_prj.srcs/sources_1/bd/zynq_blk/ipshared/979d/hdl/verilog" "+incdir+../../../../tdc_system_prj.srcs/sources_1/bd/zynq_blk/ipshared/b2d0/hdl/verilog" "+incdir+../../../../tdc_system_prj.srcs/sources_1/bd/zynq_blk/ipshared/85a3" "+incdir+../../../../tdc_system_prj.srcs/sources_1/bd/zynq_blk/ip/zynq_blk_processing_system7_0_0" "+incdir+D:/xilinx/Vivado/2018.3/data/xilinx_vip/include" \
"../../../bd/zynq_blk/ip/zynq_blk_processing_system7_0_0/sim/zynq_blk_processing_system7_0_0.v" \

vlog -work axis_infrastructure_v1_1_0  -v2k5 "+incdir+../../../../tdc_system_prj.srcs/sources_1/bd/zynq_blk/ipshared/ec67/hdl" "+incdir+../../../../tdc_system_prj.srcs/sources_1/bd/zynq_blk/ipshared/70cf/hdl" "+incdir+../../../../tdc_system_prj.srcs/sources_1/bd/zynq_blk/ipshared/8713/hdl" "+incdir+../../../../tdc_system_prj.srcs/sources_1/bd/zynq_blk/ipshared/979d/hdl/verilog" "+incdir+../../../../tdc_system_prj.srcs/sources_1/bd/zynq_blk/ipshared/b2d0/hdl/verilog" "+incdir+../../../../tdc_system_prj.srcs/sources_1/bd/zynq_blk/ipshared/85a3" "+incdir+../../../../tdc_system_prj.srcs/sources_1/bd/zynq_blk/ip/zynq_blk_processing_system7_0_0" "+incdir+D:/xilinx/Vivado/2018.3/data/xilinx_vip/include" \
"../../../../tdc_system_prj.srcs/sources_1/bd/zynq_blk/ipshared/8713/hdl/axis_infrastructure_v1_1_vl_rfs.v" \

vlog -work axis_data_fifo_v2_0_0  -v2k5 "+incdir+../../../../tdc_system_prj.srcs/sources_1/bd/zynq_blk/ipshared/ec67/hdl" "+incdir+../../../../tdc_system_prj.srcs/sources_1/bd/zynq_blk/ipshared/70cf/hdl" "+incdir+../../../../tdc_system_prj.srcs/sources_1/bd/zynq_blk/ipshared/8713/hdl" "+incdir+../../../../tdc_system_prj.srcs/sources_1/bd/zynq_blk/ipshared/979d/hdl/verilog" "+incdir+../../../../tdc_system_prj.srcs/sources_1/bd/zynq_blk/ipshared/b2d0/hdl/verilog" "+incdir+../../../../tdc_system_prj.srcs/sources_1/bd/zynq_blk/ipshared/85a3" "+incdir+../../../../tdc_system_prj.srcs/sources_1/bd/zynq_blk/ip/zynq_blk_processing_system7_0_0" "+incdir+D:/xilinx/Vivado/2018.3/data/xilinx_vip/include" \
"../../../../tdc_system_prj.srcs/sources_1/bd/zynq_blk/ipshared/4efd/hdl/axis_data_fifo_v2_0_vl_rfs.v" \

vlog -work work  -v2k5 "+incdir+../../../../tdc_system_prj.srcs/sources_1/bd/zynq_blk/ipshared/ec67/hdl" "+incdir+../../../../tdc_system_prj.srcs/sources_1/bd/zynq_blk/ipshared/70cf/hdl" "+incdir+../../../../tdc_system_prj.srcs/sources_1/bd/zynq_blk/ipshared/8713/hdl" "+incdir+../../../../tdc_system_prj.srcs/sources_1/bd/zynq_blk/ipshared/979d/hdl/verilog" "+incdir+../../../../tdc_system_prj.srcs/sources_1/bd/zynq_blk/ipshared/b2d0/hdl/verilog" "+incdir+../../../../tdc_system_prj.srcs/sources_1/bd/zynq_blk/ipshared/85a3" "+incdir+../../../../tdc_system_prj.srcs/sources_1/bd/zynq_blk/ip/zynq_blk_processing_system7_0_0" "+incdir+D:/xilinx/Vivado/2018.3/data/xilinx_vip/include" \
"../../../bd/zynq_blk/ip/zynq_blk_axis_data_fifo_0_0/sim/zynq_blk_axis_data_fifo_0_0.v" \

vcom -work lib_pkg_v1_0_2 -93 \
"../../../../tdc_system_prj.srcs/sources_1/bd/zynq_blk/ipshared/0513/hdl/lib_pkg_v1_0_rfs.vhd" \

vlog -work fifo_generator_v13_2_3  -v2k5 "+incdir+../../../../tdc_system_prj.srcs/sources_1/bd/zynq_blk/ipshared/ec67/hdl" "+incdir+../../../../tdc_system_prj.srcs/sources_1/bd/zynq_blk/ipshared/70cf/hdl" "+incdir+../../../../tdc_system_prj.srcs/sources_1/bd/zynq_blk/ipshared/8713/hdl" "+incdir+../../../../tdc_system_prj.srcs/sources_1/bd/zynq_blk/ipshared/979d/hdl/verilog" "+incdir+../../../../tdc_system_prj.srcs/sources_1/bd/zynq_blk/ipshared/b2d0/hdl/verilog" "+incdir+../../../../tdc_system_prj.srcs/sources_1/bd/zynq_blk/ipshared/85a3" "+incdir+../../../../tdc_system_prj.srcs/sources_1/bd/zynq_blk/ip/zynq_blk_processing_system7_0_0" "+incdir+D:/xilinx/Vivado/2018.3/data/xilinx_vip/include" \
"../../../../tdc_system_prj.srcs/sources_1/bd/zynq_blk/ipshared/64f4/simulation/fifo_generator_vlog_beh.v" \

vcom -work fifo_generator_v13_2_3 -93 \
"../../../../tdc_system_prj.srcs/sources_1/bd/zynq_blk/ipshared/64f4/hdl/fifo_generator_v13_2_rfs.vhd" \

vlog -work fifo_generator_v13_2_3  -v2k5 "+incdir+../../../../tdc_system_prj.srcs/sources_1/bd/zynq_blk/ipshared/ec67/hdl" "+incdir+../../../../tdc_system_prj.srcs/sources_1/bd/zynq_blk/ipshared/70cf/hdl" "+incdir+../../../../tdc_system_prj.srcs/sources_1/bd/zynq_blk/ipshared/8713/hdl" "+incdir+../../../../tdc_system_prj.srcs/sources_1/bd/zynq_blk/ipshared/979d/hdl/verilog" "+incdir+../../../../tdc_system_prj.srcs/sources_1/bd/zynq_blk/ipshared/b2d0/hdl/verilog" "+incdir+../../../../tdc_system_prj.srcs/sources_1/bd/zynq_blk/ipshared/85a3" "+incdir+../../../../tdc_system_prj.srcs/sources_1/bd/zynq_blk/ip/zynq_blk_processing_system7_0_0" "+incdir+D:/xilinx/Vivado/2018.3/data/xilinx_vip/include" \
"../../../../tdc_system_prj.srcs/sources_1/bd/zynq_blk/ipshared/64f4/hdl/fifo_generator_v13_2_rfs.v" \

vcom -work lib_fifo_v1_0_12 -93 \
"../../../../tdc_system_prj.srcs/sources_1/bd/zynq_blk/ipshared/544a/hdl/lib_fifo_v1_0_rfs.vhd" \

vcom -work lib_srl_fifo_v1_0_2 -93 \
"../../../../tdc_system_prj.srcs/sources_1/bd/zynq_blk/ipshared/51ce/hdl/lib_srl_fifo_v1_0_rfs.vhd" \

vcom -work lib_cdc_v1_0_2 -93 \
"../../../../tdc_system_prj.srcs/sources_1/bd/zynq_blk/ipshared/ef1e/hdl/lib_cdc_v1_0_rfs.vhd" \

vcom -work axi_datamover_v5_1_20 -93 \
"../../../../tdc_system_prj.srcs/sources_1/bd/zynq_blk/ipshared/dfb3/hdl/axi_datamover_v5_1_vh_rfs.vhd" \

vcom -work axi_sg_v4_1_11 -93 \
"../../../../tdc_system_prj.srcs/sources_1/bd/zynq_blk/ipshared/efa7/hdl/axi_sg_v4_1_rfs.vhd" \

vcom -work axi_dma_v7_1_19 -93 \
"../../../../tdc_system_prj.srcs/sources_1/bd/zynq_blk/ipshared/09b0/hdl/axi_dma_v7_1_vh_rfs.vhd" \

vcom -work work -93 \
"../../../bd/zynq_blk/ip/zynq_blk_axi_dma_0_0/sim/zynq_blk_axi_dma_0_0.vhd" \

vlog -work work  -v2k5 "+incdir+../../../../tdc_system_prj.srcs/sources_1/bd/zynq_blk/ipshared/ec67/hdl" "+incdir+../../../../tdc_system_prj.srcs/sources_1/bd/zynq_blk/ipshared/70cf/hdl" "+incdir+../../../../tdc_system_prj.srcs/sources_1/bd/zynq_blk/ipshared/8713/hdl" "+incdir+../../../../tdc_system_prj.srcs/sources_1/bd/zynq_blk/ipshared/979d/hdl/verilog" "+incdir+../../../../tdc_system_prj.srcs/sources_1/bd/zynq_blk/ipshared/b2d0/hdl/verilog" "+incdir+../../../../tdc_system_prj.srcs/sources_1/bd/zynq_blk/ipshared/85a3" "+incdir+../../../../tdc_system_prj.srcs/sources_1/bd/zynq_blk/ip/zynq_blk_processing_system7_0_0" "+incdir+D:/xilinx/Vivado/2018.3/data/xilinx_vip/include" \
"../../../bd/zynq_blk/ip/zynq_blk_smartconnect_0_0/bd_0/sim/bd_39ac.v" \

vlog -work xlconstant_v1_1_5  -v2k5 "+incdir+../../../../tdc_system_prj.srcs/sources_1/bd/zynq_blk/ipshared/ec67/hdl" "+incdir+../../../../tdc_system_prj.srcs/sources_1/bd/zynq_blk/ipshared/70cf/hdl" "+incdir+../../../../tdc_system_prj.srcs/sources_1/bd/zynq_blk/ipshared/8713/hdl" "+incdir+../../../../tdc_system_prj.srcs/sources_1/bd/zynq_blk/ipshared/979d/hdl/verilog" "+incdir+../../../../tdc_system_prj.srcs/sources_1/bd/zynq_blk/ipshared/b2d0/hdl/verilog" "+incdir+../../../../tdc_system_prj.srcs/sources_1/bd/zynq_blk/ipshared/85a3" "+incdir+../../../../tdc_system_prj.srcs/sources_1/bd/zynq_blk/ip/zynq_blk_processing_system7_0_0" "+incdir+D:/xilinx/Vivado/2018.3/data/xilinx_vip/include" \
"../../../../tdc_system_prj.srcs/sources_1/bd/zynq_blk/ipshared/4649/hdl/xlconstant_v1_1_vl_rfs.v" \

vlog -work work  -v2k5 "+incdir+../../../../tdc_system_prj.srcs/sources_1/bd/zynq_blk/ipshared/ec67/hdl" "+incdir+../../../../tdc_system_prj.srcs/sources_1/bd/zynq_blk/ipshared/70cf/hdl" "+incdir+../../../../tdc_system_prj.srcs/sources_1/bd/zynq_blk/ipshared/8713/hdl" "+incdir+../../../../tdc_system_prj.srcs/sources_1/bd/zynq_blk/ipshared/979d/hdl/verilog" "+incdir+../../../../tdc_system_prj.srcs/sources_1/bd/zynq_blk/ipshared/b2d0/hdl/verilog" "+incdir+../../../../tdc_system_prj.srcs/sources_1/bd/zynq_blk/ipshared/85a3" "+incdir+../../../../tdc_system_prj.srcs/sources_1/bd/zynq_blk/ip/zynq_blk_processing_system7_0_0" "+incdir+D:/xilinx/Vivado/2018.3/data/xilinx_vip/include" \
"../../../bd/zynq_blk/ip/zynq_blk_smartconnect_0_0/bd_0/ip/ip_0/sim/bd_39ac_one_0.v" \

vcom -work proc_sys_reset_v5_0_13 -93 \
"../../../../tdc_system_prj.srcs/sources_1/bd/zynq_blk/ipshared/8842/hdl/proc_sys_reset_v5_0_vh_rfs.vhd" \

vcom -work work -93 \
"../../../bd/zynq_blk/ip/zynq_blk_smartconnect_0_0/bd_0/ip/ip_1/sim/bd_39ac_psr_aclk_0.vhd" \

vlog -work smartconnect_v1_0  -sv2k12 "+incdir+../../../../tdc_system_prj.srcs/sources_1/bd/zynq_blk/ipshared/ec67/hdl" "+incdir+../../../../tdc_system_prj.srcs/sources_1/bd/zynq_blk/ipshared/70cf/hdl" "+incdir+../../../../tdc_system_prj.srcs/sources_1/bd/zynq_blk/ipshared/8713/hdl" "+incdir+../../../../tdc_system_prj.srcs/sources_1/bd/zynq_blk/ipshared/979d/hdl/verilog" "+incdir+../../../../tdc_system_prj.srcs/sources_1/bd/zynq_blk/ipshared/b2d0/hdl/verilog" "+incdir+../../../../tdc_system_prj.srcs/sources_1/bd/zynq_blk/ipshared/85a3" "+incdir+../../../../tdc_system_prj.srcs/sources_1/bd/zynq_blk/ip/zynq_blk_processing_system7_0_0" "+incdir+D:/xilinx/Vivado/2018.3/data/xilinx_vip/include" \
"../../../../tdc_system_prj.srcs/sources_1/bd/zynq_blk/ipshared/979d/hdl/sc_util_v1_0_vl_rfs.sv" \
"../../../../tdc_system_prj.srcs/sources_1/bd/zynq_blk/ipshared/f85e/hdl/sc_mmu_v1_0_vl_rfs.sv" \

vlog -work work  -sv2k12 "+incdir+../../../../tdc_system_prj.srcs/sources_1/bd/zynq_blk/ipshared/ec67/hdl" "+incdir+../../../../tdc_system_prj.srcs/sources_1/bd/zynq_blk/ipshared/70cf/hdl" "+incdir+../../../../tdc_system_prj.srcs/sources_1/bd/zynq_blk/ipshared/8713/hdl" "+incdir+../../../../tdc_system_prj.srcs/sources_1/bd/zynq_blk/ipshared/979d/hdl/verilog" "+incdir+../../../../tdc_system_prj.srcs/sources_1/bd/zynq_blk/ipshared/b2d0/hdl/verilog" "+incdir+../../../../tdc_system_prj.srcs/sources_1/bd/zynq_blk/ipshared/85a3" "+incdir+../../../../tdc_system_prj.srcs/sources_1/bd/zynq_blk/ip/zynq_blk_processing_system7_0_0" "+incdir+D:/xilinx/Vivado/2018.3/data/xilinx_vip/include" \
"../../../bd/zynq_blk/ip/zynq_blk_smartconnect_0_0/bd_0/ip/ip_2/sim/bd_39ac_s00mmu_0.sv" \

vlog -work smartconnect_v1_0  -sv2k12 "+incdir+../../../../tdc_system_prj.srcs/sources_1/bd/zynq_blk/ipshared/ec67/hdl" "+incdir+../../../../tdc_system_prj.srcs/sources_1/bd/zynq_blk/ipshared/70cf/hdl" "+incdir+../../../../tdc_system_prj.srcs/sources_1/bd/zynq_blk/ipshared/8713/hdl" "+incdir+../../../../tdc_system_prj.srcs/sources_1/bd/zynq_blk/ipshared/979d/hdl/verilog" "+incdir+../../../../tdc_system_prj.srcs/sources_1/bd/zynq_blk/ipshared/b2d0/hdl/verilog" "+incdir+../../../../tdc_system_prj.srcs/sources_1/bd/zynq_blk/ipshared/85a3" "+incdir+../../../../tdc_system_prj.srcs/sources_1/bd/zynq_blk/ip/zynq_blk_processing_system7_0_0" "+incdir+D:/xilinx/Vivado/2018.3/data/xilinx_vip/include" \
"../../../../tdc_system_prj.srcs/sources_1/bd/zynq_blk/ipshared/ca72/hdl/sc_transaction_regulator_v1_0_vl_rfs.sv" \

vlog -work work  -sv2k12 "+incdir+../../../../tdc_system_prj.srcs/sources_1/bd/zynq_blk/ipshared/ec67/hdl" "+incdir+../../../../tdc_system_prj.srcs/sources_1/bd/zynq_blk/ipshared/70cf/hdl" "+incdir+../../../../tdc_system_prj.srcs/sources_1/bd/zynq_blk/ipshared/8713/hdl" "+incdir+../../../../tdc_system_prj.srcs/sources_1/bd/zynq_blk/ipshared/979d/hdl/verilog" "+incdir+../../../../tdc_system_prj.srcs/sources_1/bd/zynq_blk/ipshared/b2d0/hdl/verilog" "+incdir+../../../../tdc_system_prj.srcs/sources_1/bd/zynq_blk/ipshared/85a3" "+incdir+../../../../tdc_system_prj.srcs/sources_1/bd/zynq_blk/ip/zynq_blk_processing_system7_0_0" "+incdir+D:/xilinx/Vivado/2018.3/data/xilinx_vip/include" \
"../../../bd/zynq_blk/ip/zynq_blk_smartconnect_0_0/bd_0/ip/ip_3/sim/bd_39ac_s00tr_0.sv" \

vlog -work smartconnect_v1_0  -sv2k12 "+incdir+../../../../tdc_system_prj.srcs/sources_1/bd/zynq_blk/ipshared/ec67/hdl" "+incdir+../../../../tdc_system_prj.srcs/sources_1/bd/zynq_blk/ipshared/70cf/hdl" "+incdir+../../../../tdc_system_prj.srcs/sources_1/bd/zynq_blk/ipshared/8713/hdl" "+incdir+../../../../tdc_system_prj.srcs/sources_1/bd/zynq_blk/ipshared/979d/hdl/verilog" "+incdir+../../../../tdc_system_prj.srcs/sources_1/bd/zynq_blk/ipshared/b2d0/hdl/verilog" "+incdir+../../../../tdc_system_prj.srcs/sources_1/bd/zynq_blk/ipshared/85a3" "+incdir+../../../../tdc_system_prj.srcs/sources_1/bd/zynq_blk/ip/zynq_blk_processing_system7_0_0" "+incdir+D:/xilinx/Vivado/2018.3/data/xilinx_vip/include" \
"../../../../tdc_system_prj.srcs/sources_1/bd/zynq_blk/ipshared/9ade/hdl/sc_si_converter_v1_0_vl_rfs.sv" \

vlog -work work  -sv2k12 "+incdir+../../../../tdc_system_prj.srcs/sources_1/bd/zynq_blk/ipshared/ec67/hdl" "+incdir+../../../../tdc_system_prj.srcs/sources_1/bd/zynq_blk/ipshared/70cf/hdl" "+incdir+../../../../tdc_system_prj.srcs/sources_1/bd/zynq_blk/ipshared/8713/hdl" "+incdir+../../../../tdc_system_prj.srcs/sources_1/bd/zynq_blk/ipshared/979d/hdl/verilog" "+incdir+../../../../tdc_system_prj.srcs/sources_1/bd/zynq_blk/ipshared/b2d0/hdl/verilog" "+incdir+../../../../tdc_system_prj.srcs/sources_1/bd/zynq_blk/ipshared/85a3" "+incdir+../../../../tdc_system_prj.srcs/sources_1/bd/zynq_blk/ip/zynq_blk_processing_system7_0_0" "+incdir+D:/xilinx/Vivado/2018.3/data/xilinx_vip/include" \
"../../../bd/zynq_blk/ip/zynq_blk_smartconnect_0_0/bd_0/ip/ip_4/sim/bd_39ac_s00sic_0.sv" \

vlog -work smartconnect_v1_0  -sv2k12 "+incdir+../../../../tdc_system_prj.srcs/sources_1/bd/zynq_blk/ipshared/ec67/hdl" "+incdir+../../../../tdc_system_prj.srcs/sources_1/bd/zynq_blk/ipshared/70cf/hdl" "+incdir+../../../../tdc_system_prj.srcs/sources_1/bd/zynq_blk/ipshared/8713/hdl" "+incdir+../../../../tdc_system_prj.srcs/sources_1/bd/zynq_blk/ipshared/979d/hdl/verilog" "+incdir+../../../../tdc_system_prj.srcs/sources_1/bd/zynq_blk/ipshared/b2d0/hdl/verilog" "+incdir+../../../../tdc_system_prj.srcs/sources_1/bd/zynq_blk/ipshared/85a3" "+incdir+../../../../tdc_system_prj.srcs/sources_1/bd/zynq_blk/ip/zynq_blk_processing_system7_0_0" "+incdir+D:/xilinx/Vivado/2018.3/data/xilinx_vip/include" \
"../../../../tdc_system_prj.srcs/sources_1/bd/zynq_blk/ipshared/b89e/hdl/sc_axi2sc_v1_0_vl_rfs.sv" \

vlog -work work  -sv2k12 "+incdir+../../../../tdc_system_prj.srcs/sources_1/bd/zynq_blk/ipshared/ec67/hdl" "+incdir+../../../../tdc_system_prj.srcs/sources_1/bd/zynq_blk/ipshared/70cf/hdl" "+incdir+../../../../tdc_system_prj.srcs/sources_1/bd/zynq_blk/ipshared/8713/hdl" "+incdir+../../../../tdc_system_prj.srcs/sources_1/bd/zynq_blk/ipshared/979d/hdl/verilog" "+incdir+../../../../tdc_system_prj.srcs/sources_1/bd/zynq_blk/ipshared/b2d0/hdl/verilog" "+incdir+../../../../tdc_system_prj.srcs/sources_1/bd/zynq_blk/ipshared/85a3" "+incdir+../../../../tdc_system_prj.srcs/sources_1/bd/zynq_blk/ip/zynq_blk_processing_system7_0_0" "+incdir+D:/xilinx/Vivado/2018.3/data/xilinx_vip/include" \
"../../../bd/zynq_blk/ip/zynq_blk_smartconnect_0_0/bd_0/ip/ip_5/sim/bd_39ac_s00a2s_0.sv" \

vlog -work smartconnect_v1_0  -sv2k12 "+incdir+../../../../tdc_system_prj.srcs/sources_1/bd/zynq_blk/ipshared/ec67/hdl" "+incdir+../../../../tdc_system_prj.srcs/sources_1/bd/zynq_blk/ipshared/70cf/hdl" "+incdir+../../../../tdc_system_prj.srcs/sources_1/bd/zynq_blk/ipshared/8713/hdl" "+incdir+../../../../tdc_system_prj.srcs/sources_1/bd/zynq_blk/ipshared/979d/hdl/verilog" "+incdir+../../../../tdc_system_prj.srcs/sources_1/bd/zynq_blk/ipshared/b2d0/hdl/verilog" "+incdir+../../../../tdc_system_prj.srcs/sources_1/bd/zynq_blk/ipshared/85a3" "+incdir+../../../../tdc_system_prj.srcs/sources_1/bd/zynq_blk/ip/zynq_blk_processing_system7_0_0" "+incdir+D:/xilinx/Vivado/2018.3/data/xilinx_vip/include" \
"../../../../tdc_system_prj.srcs/sources_1/bd/zynq_blk/ipshared/b2d0/hdl/sc_node_v1_0_vl_rfs.sv" \

vlog -work work  -sv2k12 "+incdir+../../../../tdc_system_prj.srcs/sources_1/bd/zynq_blk/ipshared/ec67/hdl" "+incdir+../../../../tdc_system_prj.srcs/sources_1/bd/zynq_blk/ipshared/70cf/hdl" "+incdir+../../../../tdc_system_prj.srcs/sources_1/bd/zynq_blk/ipshared/8713/hdl" "+incdir+../../../../tdc_system_prj.srcs/sources_1/bd/zynq_blk/ipshared/979d/hdl/verilog" "+incdir+../../../../tdc_system_prj.srcs/sources_1/bd/zynq_blk/ipshared/b2d0/hdl/verilog" "+incdir+../../../../tdc_system_prj.srcs/sources_1/bd/zynq_blk/ipshared/85a3" "+incdir+../../../../tdc_system_prj.srcs/sources_1/bd/zynq_blk/ip/zynq_blk_processing_system7_0_0" "+incdir+D:/xilinx/Vivado/2018.3/data/xilinx_vip/include" \
"../../../bd/zynq_blk/ip/zynq_blk_smartconnect_0_0/bd_0/ip/ip_6/sim/bd_39ac_sawn_0.sv" \
"../../../bd/zynq_blk/ip/zynq_blk_smartconnect_0_0/bd_0/ip/ip_7/sim/bd_39ac_swn_0.sv" \
"../../../bd/zynq_blk/ip/zynq_blk_smartconnect_0_0/bd_0/ip/ip_8/sim/bd_39ac_sbn_0.sv" \

vlog -work smartconnect_v1_0  -sv2k12 "+incdir+../../../../tdc_system_prj.srcs/sources_1/bd/zynq_blk/ipshared/ec67/hdl" "+incdir+../../../../tdc_system_prj.srcs/sources_1/bd/zynq_blk/ipshared/70cf/hdl" "+incdir+../../../../tdc_system_prj.srcs/sources_1/bd/zynq_blk/ipshared/8713/hdl" "+incdir+../../../../tdc_system_prj.srcs/sources_1/bd/zynq_blk/ipshared/979d/hdl/verilog" "+incdir+../../../../tdc_system_prj.srcs/sources_1/bd/zynq_blk/ipshared/b2d0/hdl/verilog" "+incdir+../../../../tdc_system_prj.srcs/sources_1/bd/zynq_blk/ipshared/85a3" "+incdir+../../../../tdc_system_prj.srcs/sources_1/bd/zynq_blk/ip/zynq_blk_processing_system7_0_0" "+incdir+D:/xilinx/Vivado/2018.3/data/xilinx_vip/include" \
"../../../../tdc_system_prj.srcs/sources_1/bd/zynq_blk/ipshared/7005/hdl/sc_sc2axi_v1_0_vl_rfs.sv" \

vlog -work work  -sv2k12 "+incdir+../../../../tdc_system_prj.srcs/sources_1/bd/zynq_blk/ipshared/ec67/hdl" "+incdir+../../../../tdc_system_prj.srcs/sources_1/bd/zynq_blk/ipshared/70cf/hdl" "+incdir+../../../../tdc_system_prj.srcs/sources_1/bd/zynq_blk/ipshared/8713/hdl" "+incdir+../../../../tdc_system_prj.srcs/sources_1/bd/zynq_blk/ipshared/979d/hdl/verilog" "+incdir+../../../../tdc_system_prj.srcs/sources_1/bd/zynq_blk/ipshared/b2d0/hdl/verilog" "+incdir+../../../../tdc_system_prj.srcs/sources_1/bd/zynq_blk/ipshared/85a3" "+incdir+../../../../tdc_system_prj.srcs/sources_1/bd/zynq_blk/ip/zynq_blk_processing_system7_0_0" "+incdir+D:/xilinx/Vivado/2018.3/data/xilinx_vip/include" \
"../../../bd/zynq_blk/ip/zynq_blk_smartconnect_0_0/bd_0/ip/ip_9/sim/bd_39ac_m00s2a_0.sv" \

vlog -work smartconnect_v1_0  -sv2k12 "+incdir+../../../../tdc_system_prj.srcs/sources_1/bd/zynq_blk/ipshared/ec67/hdl" "+incdir+../../../../tdc_system_prj.srcs/sources_1/bd/zynq_blk/ipshared/70cf/hdl" "+incdir+../../../../tdc_system_prj.srcs/sources_1/bd/zynq_blk/ipshared/8713/hdl" "+incdir+../../../../tdc_system_prj.srcs/sources_1/bd/zynq_blk/ipshared/979d/hdl/verilog" "+incdir+../../../../tdc_system_prj.srcs/sources_1/bd/zynq_blk/ipshared/b2d0/hdl/verilog" "+incdir+../../../../tdc_system_prj.srcs/sources_1/bd/zynq_blk/ipshared/85a3" "+incdir+../../../../tdc_system_prj.srcs/sources_1/bd/zynq_blk/ip/zynq_blk_processing_system7_0_0" "+incdir+D:/xilinx/Vivado/2018.3/data/xilinx_vip/include" \
"../../../../tdc_system_prj.srcs/sources_1/bd/zynq_blk/ipshared/b387/hdl/sc_exit_v1_0_vl_rfs.sv" \

vlog -work work  -sv2k12 "+incdir+../../../../tdc_system_prj.srcs/sources_1/bd/zynq_blk/ipshared/ec67/hdl" "+incdir+../../../../tdc_system_prj.srcs/sources_1/bd/zynq_blk/ipshared/70cf/hdl" "+incdir+../../../../tdc_system_prj.srcs/sources_1/bd/zynq_blk/ipshared/8713/hdl" "+incdir+../../../../tdc_system_prj.srcs/sources_1/bd/zynq_blk/ipshared/979d/hdl/verilog" "+incdir+../../../../tdc_system_prj.srcs/sources_1/bd/zynq_blk/ipshared/b2d0/hdl/verilog" "+incdir+../../../../tdc_system_prj.srcs/sources_1/bd/zynq_blk/ipshared/85a3" "+incdir+../../../../tdc_system_prj.srcs/sources_1/bd/zynq_blk/ip/zynq_blk_processing_system7_0_0" "+incdir+D:/xilinx/Vivado/2018.3/data/xilinx_vip/include" \
"../../../bd/zynq_blk/ip/zynq_blk_smartconnect_0_0/bd_0/ip/ip_10/sim/bd_39ac_m00e_0.sv" \

vlog -work work  -v2k5 "+incdir+../../../../tdc_system_prj.srcs/sources_1/bd/zynq_blk/ipshared/ec67/hdl" "+incdir+../../../../tdc_system_prj.srcs/sources_1/bd/zynq_blk/ipshared/70cf/hdl" "+incdir+../../../../tdc_system_prj.srcs/sources_1/bd/zynq_blk/ipshared/8713/hdl" "+incdir+../../../../tdc_system_prj.srcs/sources_1/bd/zynq_blk/ipshared/979d/hdl/verilog" "+incdir+../../../../tdc_system_prj.srcs/sources_1/bd/zynq_blk/ipshared/b2d0/hdl/verilog" "+incdir+../../../../tdc_system_prj.srcs/sources_1/bd/zynq_blk/ipshared/85a3" "+incdir+../../../../tdc_system_prj.srcs/sources_1/bd/zynq_blk/ip/zynq_blk_processing_system7_0_0" "+incdir+D:/xilinx/Vivado/2018.3/data/xilinx_vip/include" \
"../../../bd/zynq_blk/ip/zynq_blk_smartconnect_0_0/sim/zynq_blk_smartconnect_0_0.v" \

vcom -work work -93 \
"../../../bd/zynq_blk/ip/zynq_blk_rst_ps7_0_100M_1_0/sim/zynq_blk_rst_ps7_0_100M_1_0.vhd" \

vlog -work work  -v2k5 "+incdir+../../../../tdc_system_prj.srcs/sources_1/bd/zynq_blk/ipshared/ec67/hdl" "+incdir+../../../../tdc_system_prj.srcs/sources_1/bd/zynq_blk/ipshared/70cf/hdl" "+incdir+../../../../tdc_system_prj.srcs/sources_1/bd/zynq_blk/ipshared/8713/hdl" "+incdir+../../../../tdc_system_prj.srcs/sources_1/bd/zynq_blk/ipshared/979d/hdl/verilog" "+incdir+../../../../tdc_system_prj.srcs/sources_1/bd/zynq_blk/ipshared/b2d0/hdl/verilog" "+incdir+../../../../tdc_system_prj.srcs/sources_1/bd/zynq_blk/ipshared/85a3" "+incdir+../../../../tdc_system_prj.srcs/sources_1/bd/zynq_blk/ip/zynq_blk_processing_system7_0_0" "+incdir+D:/xilinx/Vivado/2018.3/data/xilinx_vip/include" \
"../../../bd/zynq_blk/ip/zynq_blk_clk_wiz_0_0/zynq_blk_clk_wiz_0_0_clk_wiz.v" \
"../../../bd/zynq_blk/ip/zynq_blk_clk_wiz_0_0/zynq_blk_clk_wiz_0_0.v" \

vcom -work work -93 \
"../../../bd/zynq_blk/ipshared/34d3/MyPkg.vhd" \
"../../../bd/zynq_blk/ipshared/34d3/risingEdgeDetector.vhd" \
"../../../bd/zynq_blk/ipshared/34d3/delayLine.vhd" \
"../../../bd/zynq_blk/ipshared/34d3/adderTreeLegacy.vhd" \
"../../../bd/zynq_blk/ipshared/34d3/encoder.vhd" \
"../../../bd/zynq_blk/ipshared/34d3/counter.vhd" \
"../../../bd/zynq_blk/ipshared/34d3/TDCchannel.vhd" \
"../../../bd/zynq_blk/ip/zynq_blk_TDCchannel_0_0/sim/zynq_blk_TDCchannel_0_0.vhd" \
"../../../bd/zynq_blk/ip/zynq_blk_TDCchannel_1_0/sim/zynq_blk_TDCchannel_1_0.vhd" \

vlog -work work  -v2k5 "+incdir+../../../../tdc_system_prj.srcs/sources_1/bd/zynq_blk/ipshared/ec67/hdl" "+incdir+../../../../tdc_system_prj.srcs/sources_1/bd/zynq_blk/ipshared/70cf/hdl" "+incdir+../../../../tdc_system_prj.srcs/sources_1/bd/zynq_blk/ipshared/8713/hdl" "+incdir+../../../../tdc_system_prj.srcs/sources_1/bd/zynq_blk/ipshared/979d/hdl/verilog" "+incdir+../../../../tdc_system_prj.srcs/sources_1/bd/zynq_blk/ipshared/b2d0/hdl/verilog" "+incdir+../../../../tdc_system_prj.srcs/sources_1/bd/zynq_blk/ipshared/85a3" "+incdir+../../../../tdc_system_prj.srcs/sources_1/bd/zynq_blk/ip/zynq_blk_processing_system7_0_0" "+incdir+D:/xilinx/Vivado/2018.3/data/xilinx_vip/include" \
"../../../bd/zynq_blk/sim/zynq_blk.v" \

vlog -work generic_baseblocks_v2_1_0  -v2k5 "+incdir+../../../../tdc_system_prj.srcs/sources_1/bd/zynq_blk/ipshared/ec67/hdl" "+incdir+../../../../tdc_system_prj.srcs/sources_1/bd/zynq_blk/ipshared/70cf/hdl" "+incdir+../../../../tdc_system_prj.srcs/sources_1/bd/zynq_blk/ipshared/8713/hdl" "+incdir+../../../../tdc_system_prj.srcs/sources_1/bd/zynq_blk/ipshared/979d/hdl/verilog" "+incdir+../../../../tdc_system_prj.srcs/sources_1/bd/zynq_blk/ipshared/b2d0/hdl/verilog" "+incdir+../../../../tdc_system_prj.srcs/sources_1/bd/zynq_blk/ipshared/85a3" "+incdir+../../../../tdc_system_prj.srcs/sources_1/bd/zynq_blk/ip/zynq_blk_processing_system7_0_0" "+incdir+D:/xilinx/Vivado/2018.3/data/xilinx_vip/include" \
"../../../../tdc_system_prj.srcs/sources_1/bd/zynq_blk/ipshared/b752/hdl/generic_baseblocks_v2_1_vl_rfs.v" \

vlog -work axi_register_slice_v2_1_18  -v2k5 "+incdir+../../../../tdc_system_prj.srcs/sources_1/bd/zynq_blk/ipshared/ec67/hdl" "+incdir+../../../../tdc_system_prj.srcs/sources_1/bd/zynq_blk/ipshared/70cf/hdl" "+incdir+../../../../tdc_system_prj.srcs/sources_1/bd/zynq_blk/ipshared/8713/hdl" "+incdir+../../../../tdc_system_prj.srcs/sources_1/bd/zynq_blk/ipshared/979d/hdl/verilog" "+incdir+../../../../tdc_system_prj.srcs/sources_1/bd/zynq_blk/ipshared/b2d0/hdl/verilog" "+incdir+../../../../tdc_system_prj.srcs/sources_1/bd/zynq_blk/ipshared/85a3" "+incdir+../../../../tdc_system_prj.srcs/sources_1/bd/zynq_blk/ip/zynq_blk_processing_system7_0_0" "+incdir+D:/xilinx/Vivado/2018.3/data/xilinx_vip/include" \
"../../../../tdc_system_prj.srcs/sources_1/bd/zynq_blk/ipshared/cc23/hdl/axi_register_slice_v2_1_vl_rfs.v" \

vlog -work axi_data_fifo_v2_1_17  -v2k5 "+incdir+../../../../tdc_system_prj.srcs/sources_1/bd/zynq_blk/ipshared/ec67/hdl" "+incdir+../../../../tdc_system_prj.srcs/sources_1/bd/zynq_blk/ipshared/70cf/hdl" "+incdir+../../../../tdc_system_prj.srcs/sources_1/bd/zynq_blk/ipshared/8713/hdl" "+incdir+../../../../tdc_system_prj.srcs/sources_1/bd/zynq_blk/ipshared/979d/hdl/verilog" "+incdir+../../../../tdc_system_prj.srcs/sources_1/bd/zynq_blk/ipshared/b2d0/hdl/verilog" "+incdir+../../../../tdc_system_prj.srcs/sources_1/bd/zynq_blk/ipshared/85a3" "+incdir+../../../../tdc_system_prj.srcs/sources_1/bd/zynq_blk/ip/zynq_blk_processing_system7_0_0" "+incdir+D:/xilinx/Vivado/2018.3/data/xilinx_vip/include" \
"../../../../tdc_system_prj.srcs/sources_1/bd/zynq_blk/ipshared/c4fd/hdl/axi_data_fifo_v2_1_vl_rfs.v" \

vlog -work axi_crossbar_v2_1_19  -v2k5 "+incdir+../../../../tdc_system_prj.srcs/sources_1/bd/zynq_blk/ipshared/ec67/hdl" "+incdir+../../../../tdc_system_prj.srcs/sources_1/bd/zynq_blk/ipshared/70cf/hdl" "+incdir+../../../../tdc_system_prj.srcs/sources_1/bd/zynq_blk/ipshared/8713/hdl" "+incdir+../../../../tdc_system_prj.srcs/sources_1/bd/zynq_blk/ipshared/979d/hdl/verilog" "+incdir+../../../../tdc_system_prj.srcs/sources_1/bd/zynq_blk/ipshared/b2d0/hdl/verilog" "+incdir+../../../../tdc_system_prj.srcs/sources_1/bd/zynq_blk/ipshared/85a3" "+incdir+../../../../tdc_system_prj.srcs/sources_1/bd/zynq_blk/ip/zynq_blk_processing_system7_0_0" "+incdir+D:/xilinx/Vivado/2018.3/data/xilinx_vip/include" \
"../../../../tdc_system_prj.srcs/sources_1/bd/zynq_blk/ipshared/6c9d/hdl/axi_crossbar_v2_1_vl_rfs.v" \

vlog -work work  -v2k5 "+incdir+../../../../tdc_system_prj.srcs/sources_1/bd/zynq_blk/ipshared/ec67/hdl" "+incdir+../../../../tdc_system_prj.srcs/sources_1/bd/zynq_blk/ipshared/70cf/hdl" "+incdir+../../../../tdc_system_prj.srcs/sources_1/bd/zynq_blk/ipshared/8713/hdl" "+incdir+../../../../tdc_system_prj.srcs/sources_1/bd/zynq_blk/ipshared/979d/hdl/verilog" "+incdir+../../../../tdc_system_prj.srcs/sources_1/bd/zynq_blk/ipshared/b2d0/hdl/verilog" "+incdir+../../../../tdc_system_prj.srcs/sources_1/bd/zynq_blk/ipshared/85a3" "+incdir+../../../../tdc_system_prj.srcs/sources_1/bd/zynq_blk/ip/zynq_blk_processing_system7_0_0" "+incdir+D:/xilinx/Vivado/2018.3/data/xilinx_vip/include" \
"../../../bd/zynq_blk/ip/zynq_blk_xbar_0/sim/zynq_blk_xbar_0.v" \

vcom -work axi_lite_ipif_v3_0_4 -93 \
"../../../../tdc_system_prj.srcs/sources_1/bd/zynq_blk/ipshared/66ea/hdl/axi_lite_ipif_v3_0_vh_rfs.vhd" \

vcom -work interrupt_control_v3_1_4 -93 \
"../../../../tdc_system_prj.srcs/sources_1/bd/zynq_blk/ipshared/a040/hdl/interrupt_control_v3_1_vh_rfs.vhd" \

vcom -work axi_gpio_v2_0_20 -93 \
"../../../../tdc_system_prj.srcs/sources_1/bd/zynq_blk/ipshared/a7c9/hdl/axi_gpio_v2_0_vh_rfs.vhd" \

vcom -work work -93 \
"../../../bd/zynq_blk/ip/zynq_blk_axi_gpio_0_0/sim/zynq_blk_axi_gpio_0_0.vhd" \

vlog -work work  -v2k5 "+incdir+../../../../tdc_system_prj.srcs/sources_1/bd/zynq_blk/ipshared/ec67/hdl" "+incdir+../../../../tdc_system_prj.srcs/sources_1/bd/zynq_blk/ipshared/70cf/hdl" "+incdir+../../../../tdc_system_prj.srcs/sources_1/bd/zynq_blk/ipshared/8713/hdl" "+incdir+../../../../tdc_system_prj.srcs/sources_1/bd/zynq_blk/ipshared/979d/hdl/verilog" "+incdir+../../../../tdc_system_prj.srcs/sources_1/bd/zynq_blk/ipshared/b2d0/hdl/verilog" "+incdir+../../../../tdc_system_prj.srcs/sources_1/bd/zynq_blk/ipshared/85a3" "+incdir+../../../../tdc_system_prj.srcs/sources_1/bd/zynq_blk/ip/zynq_blk_processing_system7_0_0" "+incdir+D:/xilinx/Vivado/2018.3/data/xilinx_vip/include" \
"../../../bd/zynq_blk/ipshared/5982/hdl/tdc_ctl_fromps_v1_0_S00_AXI.v" \
"../../../bd/zynq_blk/ipshared/5982/hdl/tdc_ctl_fromps_v1_0.v" \
"../../../bd/zynq_blk/ip/zynq_blk_tdc_ctl_fromps_0_1/sim/zynq_blk_tdc_ctl_fromps_0_1.v" \

vcom -work work -93 \
"../../../bd/zynq_blk/ip/zynq_blk_proc_rst_clk2_0/sim/zynq_blk_proc_rst_clk2_0.vhd" \

vlog -work work  -v2k5 "+incdir+../../../../tdc_system_prj.srcs/sources_1/bd/zynq_blk/ipshared/ec67/hdl" "+incdir+../../../../tdc_system_prj.srcs/sources_1/bd/zynq_blk/ipshared/70cf/hdl" "+incdir+../../../../tdc_system_prj.srcs/sources_1/bd/zynq_blk/ipshared/8713/hdl" "+incdir+../../../../tdc_system_prj.srcs/sources_1/bd/zynq_blk/ipshared/979d/hdl/verilog" "+incdir+../../../../tdc_system_prj.srcs/sources_1/bd/zynq_blk/ipshared/b2d0/hdl/verilog" "+incdir+../../../../tdc_system_prj.srcs/sources_1/bd/zynq_blk/ipshared/85a3" "+incdir+../../../../tdc_system_prj.srcs/sources_1/bd/zynq_blk/ip/zynq_blk_processing_system7_0_0" "+incdir+D:/xilinx/Vivado/2018.3/data/xilinx_vip/include" \
"../../../bd/zynq_blk/ip/zynq_blk_tdc_control_0_0/sim/zynq_blk_tdc_control_0_0.v" \
"../../../bd/zynq_blk/ip/zynq_blk_clk_wiz_1_0/zynq_blk_clk_wiz_1_0_clk_wiz.v" \
"../../../bd/zynq_blk/ip/zynq_blk_clk_wiz_1_0/zynq_blk_clk_wiz_1_0.v" \
"../../../bd/zynq_blk/ip/zynq_blk_hit_src_chg_0_0/sim/zynq_blk_hit_src_chg_0_0.v" \
"../../../bd/zynq_blk/ip/zynq_blk_hit_src_chg_1_0/sim/zynq_blk_hit_src_chg_1_0.v" \

vlog -work axi_protocol_converter_v2_1_18  -v2k5 "+incdir+../../../../tdc_system_prj.srcs/sources_1/bd/zynq_blk/ipshared/ec67/hdl" "+incdir+../../../../tdc_system_prj.srcs/sources_1/bd/zynq_blk/ipshared/70cf/hdl" "+incdir+../../../../tdc_system_prj.srcs/sources_1/bd/zynq_blk/ipshared/8713/hdl" "+incdir+../../../../tdc_system_prj.srcs/sources_1/bd/zynq_blk/ipshared/979d/hdl/verilog" "+incdir+../../../../tdc_system_prj.srcs/sources_1/bd/zynq_blk/ipshared/b2d0/hdl/verilog" "+incdir+../../../../tdc_system_prj.srcs/sources_1/bd/zynq_blk/ipshared/85a3" "+incdir+../../../../tdc_system_prj.srcs/sources_1/bd/zynq_blk/ip/zynq_blk_processing_system7_0_0" "+incdir+D:/xilinx/Vivado/2018.3/data/xilinx_vip/include" \
"../../../../tdc_system_prj.srcs/sources_1/bd/zynq_blk/ipshared/7a04/hdl/axi_protocol_converter_v2_1_vl_rfs.v" \

vlog -work work  -v2k5 "+incdir+../../../../tdc_system_prj.srcs/sources_1/bd/zynq_blk/ipshared/ec67/hdl" "+incdir+../../../../tdc_system_prj.srcs/sources_1/bd/zynq_blk/ipshared/70cf/hdl" "+incdir+../../../../tdc_system_prj.srcs/sources_1/bd/zynq_blk/ipshared/8713/hdl" "+incdir+../../../../tdc_system_prj.srcs/sources_1/bd/zynq_blk/ipshared/979d/hdl/verilog" "+incdir+../../../../tdc_system_prj.srcs/sources_1/bd/zynq_blk/ipshared/b2d0/hdl/verilog" "+incdir+../../../../tdc_system_prj.srcs/sources_1/bd/zynq_blk/ipshared/85a3" "+incdir+../../../../tdc_system_prj.srcs/sources_1/bd/zynq_blk/ip/zynq_blk_processing_system7_0_0" "+incdir+D:/xilinx/Vivado/2018.3/data/xilinx_vip/include" \
"../../../bd/zynq_blk/ip/zynq_blk_auto_pc_0/sim/zynq_blk_auto_pc_0.v" \

vlog -work work \
"glbl.v"

