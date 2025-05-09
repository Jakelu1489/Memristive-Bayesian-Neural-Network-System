// Copyright 1986-2018 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2018.3 (win64) Build 2405991 Thu Dec  6 23:38:27 MST 2018
// Date        : Mon Jun 10 15:19:55 2024
// Host        : DESKTOP-QJLKIHB running 64-bit major release  (build 9200)
// Command     : write_verilog -force -mode synth_stub
//               D:/zynq_tdc/tdc_system_prj/tdc_system_prj.srcs/sources_1/bd/zynq_blk/ip/zynq_blk_tdc_control_0_0/zynq_blk_tdc_control_0_0_stub.v
// Design      : zynq_blk_tdc_control_0_0
// Purpose     : Stub declaration of top-level module interface
// Device      : xc7z020clg484-2
// --------------------------------------------------------------------------------

// This empty module with port declaration file causes synthesis tools to infer a black box for IP.
// The synthesis directives are for Synopsys Synplify support to prevent IO buffer insertion.
// Please paste the declaration into a Verilog source file or add the file as an additional source.
(* X_CORE_INFO = "tdc_control,Vivado 2018.3" *)
module zynq_blk_tdc_control_0_0(clk, rst_n, ValidOutStart, ValidOutStop, 
  timestampStart, timestampStop, DLenable, run, calib_en, calibing_flag, calib_finished, 
  hit_source, axis_tready, axis_tdata, axis_tkeep, axis_tlast, axis_tvalid)
/* synthesis syn_black_box black_box_pad_pin="clk,rst_n,ValidOutStart,ValidOutStop,timestampStart[31:0],timestampStop[31:0],DLenable,run,calib_en,calibing_flag,calib_finished,hit_source,axis_tready,axis_tdata[63:0],axis_tkeep[7:0],axis_tlast,axis_tvalid" */;
  input clk;
  input rst_n;
  input ValidOutStart;
  input ValidOutStop;
  input [31:0]timestampStart;
  input [31:0]timestampStop;
  output DLenable;
  input run;
  input calib_en;
  output calibing_flag;
  output calib_finished;
  output hit_source;
  input axis_tready;
  output [63:0]axis_tdata;
  output [7:0]axis_tkeep;
  output axis_tlast;
  output axis_tvalid;
endmodule
