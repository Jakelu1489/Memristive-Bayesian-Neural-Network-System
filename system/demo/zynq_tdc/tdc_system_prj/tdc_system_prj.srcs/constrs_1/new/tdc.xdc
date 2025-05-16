set_property IOSTANDARD LVCMOS33 [get_ports clk]
set_property IOSTANDARD LVCMOS33 [get_ports rst_n]
# set_property IOSTANDARD LVCMOS33 [get_ports LED_Calib]


# set_property IOSTANDARD LVCMOS33 [get_ports {IIC_tri_io[1]}]
# set_property DRIVE 12 [get_ports {IIC_tri_io[1]}]
# set_property SLEW SLOW [get_ports {IIC_tri_io[1]}]
# set_property IOSTANDARD LVCMOS33 [get_ports {IIC_tri_io[0]}]
# set_property DRIVE 12 [get_ports {IIC_tri_io[0]}]
# set_property SLEW SLOW [get_ports {IIC_tri_io[0]}]
set_property PACKAGE_PIN W17 [get_ports clk]
# set_property PACKAGE_PIN Y14 [get_ports LED_Calib]

# SCL IIC_tri_io[0]
# SDA IIC_tri_io[1]
# set_property PACKAGE_PIN N15 [get_ports {IIC_tri_io[0]}]
# set_property PACKAGE_PIN M15 [get_ports {IIC_tri_io[1]}]




set_property PACKAGE_PIN Y14 [get_ports LED_Calib]
set_property IOSTANDARD LVCMOS33 [get_ports LED_Calib]
set_property IOSTANDARD LVDS_25 [get_ports stop_p]
set_property IOSTANDARD LVCMOS33 [get_ports start]
set_property IOSTANDARD LVCMOS33 [get_ports stop]
set_property PACKAGE_PIN L18 [get_ports start_p]
set_property IOSTANDARD LVDS_25 [get_ports start_p]
set_property PACKAGE_PIN B19 [get_ports start]
set_property PACKAGE_PIN D20 [get_ports stop]
set_property PACKAGE_PIN D18 [get_ports stop_p]




# set_clock_groups -asynchronous -group [get_clocks -include_generated_clocks clk_fpga_0]

set_clock_groups -name clock_100 -asynchronous -group [get_clocks clk_fpga_0]
set_false_path -from [get_cells {{zynq_blk_i/tdc_ctl_sig_0/inst/tdc_ctl_fromps_v1_0_S00_AXI_inst/slv_reg0_reg[0]} {zynq_blk_i/tdc_ctl_sig_0/inst/tdc_ctl_fromps_v1_0_S00_AXI_inst/slv_reg0_reg[1]}}] -to [get_cells {{zynq_blk_i/tdc_ctl_sig_0/inst/tdc_ctl_fromps_v1_0_S00_AXI_inst/out_sync_reg0_reg[0]} {zynq_blk_i/tdc_ctl_sig_0/inst/tdc_ctl_fromps_v1_0_S00_AXI_inst/out_sync_reg0_reg[1]}}]



set_property IOSTANDARD LVCMOS33 [get_ports {SCL_tri_io[0]}]
set_property PACKAGE_PIN R7 [get_ports {SCL_tri_io[0]}]
set_property IOSTANDARD LVCMOS33 [get_ports {SDA_tri_io[0]}]
set_property PACKAGE_PIN U7 [get_ports {SDA_tri_io[0]}]
set_property PACKAGE_PIN V4 [get_ports rst_n]

set_property MARK_DEBUG true [get_nets zynq_blk_i/hit_src_chg_1/hitO]
set_property MARK_DEBUG true [get_nets zynq_blk_i/hit_src_chg_1/channel]
set_property MARK_DEBUG true [get_nets zynq_blk_i/hit_src_chg_0/hitO]

