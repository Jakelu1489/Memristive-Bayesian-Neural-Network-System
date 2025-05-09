// Copyright 1986-2018 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2018.3 (win64) Build 2405991 Thu Dec  6 23:38:27 MST 2018
// Date        : Thu May 23 19:40:59 2024
// Host        : DESKTOP-QJLKIHB running 64-bit major release  (build 9200)
// Command     : write_verilog -force -mode synth_stub
//               d:/zynq_tdc/tdc_system_prj/tdc_system_prj.srcs/sources_1/ip/TDCchannel_0/TDCchannel_0_stub.v
// Design      : TDCchannel_0
// Purpose     : Stub declaration of top-level module interface
// Device      : xc7z020clg484-2
// --------------------------------------------------------------------------------

// This empty module with port declaration file causes synthesis tools to infer a black box for IP.
// The synthesis directives are for Synopsys Synplify support to prevent IO buffer insertion.
// Please paste the declaration into a Verilog source file or add the file as an additional source.
(* x_core_info = "TDCchannel,Vivado 2018.3" *)
module TDCchannel_0(clk, hit, DLenable, ValidOut, timestamp)
/* synthesis syn_black_box black_box_pad_pin="clk,hit,DLenable,ValidOut,timestamp[31:0]" */;
  input clk;
  input hit;
  input DLenable;
  output ValidOut;
  output [31:0]timestamp;
endmodule
