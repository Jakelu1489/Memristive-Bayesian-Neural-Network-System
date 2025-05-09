// Copyright 1986-2018 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2018.3 (win64) Build 2405991 Thu Dec  6 23:38:27 MST 2018
// Date        : Thu Jul 11 20:13:50 2024
// Host        : DESKTOP-L5QOME4 running 64-bit major release  (build 9200)
// Command     : write_verilog -force -mode synth_stub -rename_top decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix -prefix
//               decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_ zynq_blk_hit_src_chg_1_0_stub.v
// Design      : zynq_blk_hit_src_chg_1_0
// Purpose     : Stub declaration of top-level module interface
// Device      : xc7z020clg484-2
// --------------------------------------------------------------------------------

// This empty module with port declaration file causes synthesis tools to infer a black box for IP.
// The synthesis directives are for Synopsys Synplify support to prevent IO buffer insertion.
// Please paste the declaration into a Verilog source file or add the file as an additional source.
(* X_CORE_INFO = "hit_src_chg,Vivado 2018.3" *)
module decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix(hit, clk_i_p, clk_i_n, clk_calib, channel, hitO)
/* synthesis syn_black_box black_box_pad_pin="hit,clk_i_p,clk_i_n,clk_calib,channel,hitO" */;
  input hit;
  input clk_i_p;
  input clk_i_n;
  input clk_calib;
  input channel;
  output hitO;
endmodule
