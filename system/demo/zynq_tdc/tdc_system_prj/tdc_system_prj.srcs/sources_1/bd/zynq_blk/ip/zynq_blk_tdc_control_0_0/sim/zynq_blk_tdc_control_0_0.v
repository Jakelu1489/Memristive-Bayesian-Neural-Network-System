// (c) Copyright 1995-2024 Xilinx, Inc. All rights reserved.
// 
// This file contains confidential and proprietary information
// of Xilinx, Inc. and is protected under U.S. and
// international copyright and other intellectual property
// laws.
// 
// DISCLAIMER
// This disclaimer is not a license and does not grant any
// rights to the materials distributed herewith. Except as
// otherwise provided in a valid license issued to you by
// Xilinx, and to the maximum extent permitted by applicable
// law: (1) THESE MATERIALS ARE MADE AVAILABLE "AS IS" AND
// WITH ALL FAULTS, AND XILINX HEREBY DISCLAIMS ALL WARRANTIES
// AND CONDITIONS, EXPRESS, IMPLIED, OR STATUTORY, INCLUDING
// BUT NOT LIMITED TO WARRANTIES OF MERCHANTABILITY, NON-
// INFRINGEMENT, OR FITNESS FOR ANY PARTICULAR PURPOSE; and
// (2) Xilinx shall not be liable (whether in contract or tort,
// including negligence, or under any other theory of
// liability) for any loss or damage of any kind or nature
// related to, arising under or in connection with these
// materials, including for any direct, or any indirect,
// special, incidental, or consequential loss or damage
// (including loss of data, profits, goodwill, or any type of
// loss or damage suffered as a result of any action brought
// by a third party) even if such damage or loss was
// reasonably foreseeable or Xilinx had been advised of the
// possibility of the same.
// 
// CRITICAL APPLICATIONS
// Xilinx products are not designed or intended to be fail-
// safe, or for use in any application requiring fail-safe
// performance, such as life-support or safety devices or
// systems, Class III medical devices, nuclear facilities,
// applications related to the deployment of airbags, or any
// other applications that could lead to death, personal
// injury, or severe property or environmental damage
// (individually and collectively, "Critical
// Applications"). Customer assumes the sole risk and
// liability of any use of Xilinx products in Critical
// Applications, subject only to applicable laws and
// regulations governing limitations on product liability.
// 
// THIS COPYRIGHT NOTICE AND DISCLAIMER MUST BE RETAINED AS
// PART OF THIS FILE AT ALL TIMES.
// 
// DO NOT MODIFY THIS FILE.


// IP VLNV: xilinx.com:module_ref:tdc_control:1.0
// IP Revision: 1

`timescale 1ns/1ps

(* IP_DEFINITION_SOURCE = "module_ref" *)
(* DowngradeIPIdentifiedWarnings = "yes" *)
module zynq_blk_tdc_control_0_0 (
  clk,
  rst_n,
  ValidOutStart,
  ValidOutStop,
  timestampStart,
  timestampStop,
  DLenable,
  run,
  calib_en,
  calibing_flag,
  calib_finished,
  hit_source,
  axis_tready,
  axis_tdata,
  axis_tkeep,
  axis_tlast,
  axis_tvalid
);

(* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME clk, ASSOCIATED_BUSIF axis, FREQ_HZ 350000000, PHASE 0.0, CLK_DOMAIN /clk_wiz_0_clk_out1, INSERT_VIP 0" *)
(* X_INTERFACE_INFO = "xilinx.com:signal:clock:1.0 clk CLK" *)
input wire clk;
(* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME rst_n, POLARITY ACTIVE_LOW, INSERT_VIP 0" *)
(* X_INTERFACE_INFO = "xilinx.com:signal:reset:1.0 rst_n RST" *)
input wire rst_n;
input wire ValidOutStart;
input wire ValidOutStop;
input wire [31 : 0] timestampStart;
input wire [31 : 0] timestampStop;
output wire DLenable;
input wire run;
input wire calib_en;
output wire calibing_flag;
output wire calib_finished;
output wire hit_source;
(* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 axis TREADY" *)
input wire axis_tready;
(* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 axis TDATA" *)
output wire [63 : 0] axis_tdata;
(* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 axis TKEEP" *)
output wire [7 : 0] axis_tkeep;
(* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 axis TLAST" *)
output wire axis_tlast;
(* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME axis, TDATA_NUM_BYTES 8, TDEST_WIDTH 0, TID_WIDTH 0, TUSER_WIDTH 0, HAS_TREADY 1, HAS_TSTRB 0, HAS_TKEEP 1, HAS_TLAST 1, FREQ_HZ 350000000, PHASE 0.0, CLK_DOMAIN /clk_wiz_0_clk_out1, LAYERED_METADATA undef, INSERT_VIP 0" *)
(* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 axis TVALID" *)
output wire axis_tvalid;

  tdc_control #(
    .Calib_SIZE(100),
    .Brust_SIZE(512),
    .TimeOut_SIZE(12)
  ) inst (
    .clk(clk),
    .rst_n(rst_n),
    .ValidOutStart(ValidOutStart),
    .ValidOutStop(ValidOutStop),
    .timestampStart(timestampStart),
    .timestampStop(timestampStop),
    .DLenable(DLenable),
    .run(run),
    .calib_en(calib_en),
    .calibing_flag(calibing_flag),
    .calib_finished(calib_finished),
    .hit_source(hit_source),
    .axis_tready(axis_tready),
    .axis_tdata(axis_tdata),
    .axis_tkeep(axis_tkeep),
    .axis_tlast(axis_tlast),
    .axis_tvalid(axis_tvalid)
  );
endmodule
