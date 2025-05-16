// Copyright 1986-2018 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2018.3 (win64) Build 2405991 Thu Dec  6 23:38:27 MST 2018
// Date        : Mon Jun 10 15:19:55 2024
// Host        : DESKTOP-QJLKIHB running 64-bit major release  (build 9200)
// Command     : write_verilog -force -mode funcsim
//               D:/zynq_tdc/tdc_system_prj/tdc_system_prj.srcs/sources_1/bd/zynq_blk/ip/zynq_blk_tdc_control_0_0/zynq_blk_tdc_control_0_0_sim_netlist.v
// Design      : zynq_blk_tdc_control_0_0
// Purpose     : This verilog netlist is a functional simulation representation of the design and should not be modified
//               or synthesized. This netlist cannot be used for SDF annotated simulation.
// Device      : xc7z020clg484-2
// --------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

(* CHECK_LICENSE_TYPE = "zynq_blk_tdc_control_0_0,tdc_control,{}" *) (* DowngradeIPIdentifiedWarnings = "yes" *) (* IP_DEFINITION_SOURCE = "module_ref" *) 
(* X_CORE_INFO = "tdc_control,Vivado 2018.3" *) 
(* NotValidForBitStream *)
module zynq_blk_tdc_control_0_0
   (clk,
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
    axis_tvalid);
  (* X_INTERFACE_INFO = "xilinx.com:signal:clock:1.0 clk CLK" *) (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME clk, ASSOCIATED_BUSIF axis, FREQ_HZ 350000000, PHASE 0.0, CLK_DOMAIN /clk_wiz_0_clk_out1, INSERT_VIP 0" *) input clk;
  (* X_INTERFACE_INFO = "xilinx.com:signal:reset:1.0 rst_n RST" *) (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME rst_n, POLARITY ACTIVE_LOW, INSERT_VIP 0" *) input rst_n;
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
  (* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 axis TREADY" *) input axis_tready;
  (* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 axis TDATA" *) output [63:0]axis_tdata;
  (* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 axis TKEEP" *) output [7:0]axis_tkeep;
  (* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 axis TLAST" *) output axis_tlast;
  (* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 axis TVALID" *) (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME axis, TDATA_NUM_BYTES 8, TDEST_WIDTH 0, TID_WIDTH 0, TUSER_WIDTH 0, HAS_TREADY 1, HAS_TSTRB 0, HAS_TKEEP 1, HAS_TLAST 1, FREQ_HZ 350000000, PHASE 0.0, CLK_DOMAIN /clk_wiz_0_clk_out1, LAYERED_METADATA undef, INSERT_VIP 0" *) output axis_tvalid;

  wire DLenable;
  wire ValidOutStart;
  wire ValidOutStop;
  wire [63:0]axis_tdata;
  wire axis_tlast;
  wire axis_tready;
  wire axis_tvalid;
  wire calib_en;
  wire calib_finished;
  wire calibing_flag;
  wire clk;
  wire hit_source;
  wire rst_n;
  wire run;
  wire [31:0]timestampStart;
  wire [31:0]timestampStop;

  assign axis_tkeep[7] = DLenable;
  assign axis_tkeep[6] = DLenable;
  assign axis_tkeep[5] = DLenable;
  assign axis_tkeep[4] = DLenable;
  assign axis_tkeep[3] = DLenable;
  assign axis_tkeep[2] = DLenable;
  assign axis_tkeep[1] = DLenable;
  assign axis_tkeep[0] = DLenable;
  zynq_blk_tdc_control_0_0_tdc_control inst
       (.DLenable(DLenable),
        .ValidOutStart(ValidOutStart),
        .ValidOutStop(ValidOutStop),
        .axis_tdata(axis_tdata),
        .axis_tlast(axis_tlast),
        .axis_tready(axis_tready),
        .axis_tvalid(axis_tvalid),
        .calib_en(calib_en),
        .calibing_flag_r_reg_0(calibing_flag),
        .clk(clk),
        .\cnt_burst_calib_reg[5]_0 (calib_finished),
        .hit_source(hit_source),
        .rst_n(rst_n),
        .run(run),
        .timestampStart(timestampStart),
        .timestampStop(timestampStop));
endmodule

(* ORIG_REF_NAME = "tdc_control" *) 
module zynq_blk_tdc_control_0_0_tdc_control
   (axis_tdata,
    axis_tlast,
    axis_tvalid,
    calibing_flag_r_reg_0,
    \cnt_burst_calib_reg[5]_0 ,
    hit_source,
    DLenable,
    clk,
    ValidOutStart,
    timestampStart,
    ValidOutStop,
    timestampStop,
    run,
    axis_tready,
    rst_n,
    calib_en);
  output [63:0]axis_tdata;
  output axis_tlast;
  output axis_tvalid;
  output calibing_flag_r_reg_0;
  output \cnt_burst_calib_reg[5]_0 ;
  output hit_source;
  output DLenable;
  input clk;
  input ValidOutStart;
  input [31:0]timestampStart;
  input ValidOutStop;
  input [31:0]timestampStop;
  input run;
  input axis_tready;
  input rst_n;
  input calib_en;

  wire DLenable;
  wire \FSM_onehot_state[1]_i_1_n_0 ;
  wire \FSM_onehot_state[1]_i_3_n_0 ;
  wire \FSM_onehot_state[2]_i_1_n_0 ;
  wire \FSM_onehot_state[3]_i_1_n_0 ;
  wire \FSM_onehot_state[4]_i_10_n_0 ;
  wire \FSM_onehot_state[4]_i_11_n_0 ;
  wire \FSM_onehot_state[4]_i_12_n_0 ;
  wire \FSM_onehot_state[4]_i_13_n_0 ;
  wire \FSM_onehot_state[4]_i_14_n_0 ;
  wire \FSM_onehot_state[4]_i_1_n_0 ;
  wire \FSM_onehot_state[4]_i_2_n_0 ;
  wire \FSM_onehot_state[4]_i_3_n_0 ;
  wire \FSM_onehot_state[4]_i_4_n_0 ;
  wire \FSM_onehot_state[4]_i_5_n_0 ;
  wire \FSM_onehot_state[4]_i_6_n_0 ;
  wire \FSM_onehot_state[4]_i_7_n_0 ;
  wire \FSM_onehot_state[4]_i_8_n_0 ;
  wire \FSM_onehot_state[4]_i_9_n_0 ;
  wire \FSM_onehot_state_reg_n_0_[0] ;
  wire \FSM_onehot_state_reg_n_0_[1] ;
  wire \FSM_onehot_state_reg_n_0_[3] ;
  wire \FSM_onehot_state_reg_n_0_[4] ;
  wire ValidOutStart;
  wire ValidOutStop;
  wire [63:0]axis_tdata;
  wire axis_tlast;
  wire axis_tready;
  wire axis_tvalid;
  wire calib_en;
  wire calib_finished_INST_0_i_1_n_0;
  wire calibing_flag_r_i_1_n_0;
  wire calibing_flag_r_i_2_n_0;
  wire calibing_flag_r_i_3_n_0;
  wire calibing_flag_r_i_4_n_0;
  wire calibing_flag_r_i_5_n_0;
  wire calibing_flag_r_i_6_n_0;
  wire calibing_flag_r_reg_0;
  wire clear;
  wire clk;
  wire \clk_cnt[0]_i_3_n_0 ;
  wire [15:0]clk_cnt_reg;
  wire \clk_cnt_reg[0]_i_2_n_0 ;
  wire \clk_cnt_reg[0]_i_2_n_1 ;
  wire \clk_cnt_reg[0]_i_2_n_2 ;
  wire \clk_cnt_reg[0]_i_2_n_3 ;
  wire \clk_cnt_reg[0]_i_2_n_4 ;
  wire \clk_cnt_reg[0]_i_2_n_5 ;
  wire \clk_cnt_reg[0]_i_2_n_6 ;
  wire \clk_cnt_reg[0]_i_2_n_7 ;
  wire \clk_cnt_reg[12]_i_1_n_1 ;
  wire \clk_cnt_reg[12]_i_1_n_2 ;
  wire \clk_cnt_reg[12]_i_1_n_3 ;
  wire \clk_cnt_reg[12]_i_1_n_4 ;
  wire \clk_cnt_reg[12]_i_1_n_5 ;
  wire \clk_cnt_reg[12]_i_1_n_6 ;
  wire \clk_cnt_reg[12]_i_1_n_7 ;
  wire \clk_cnt_reg[4]_i_1_n_0 ;
  wire \clk_cnt_reg[4]_i_1_n_1 ;
  wire \clk_cnt_reg[4]_i_1_n_2 ;
  wire \clk_cnt_reg[4]_i_1_n_3 ;
  wire \clk_cnt_reg[4]_i_1_n_4 ;
  wire \clk_cnt_reg[4]_i_1_n_5 ;
  wire \clk_cnt_reg[4]_i_1_n_6 ;
  wire \clk_cnt_reg[4]_i_1_n_7 ;
  wire \clk_cnt_reg[8]_i_1_n_0 ;
  wire \clk_cnt_reg[8]_i_1_n_1 ;
  wire \clk_cnt_reg[8]_i_1_n_2 ;
  wire \clk_cnt_reg[8]_i_1_n_3 ;
  wire \clk_cnt_reg[8]_i_1_n_4 ;
  wire \clk_cnt_reg[8]_i_1_n_5 ;
  wire \clk_cnt_reg[8]_i_1_n_6 ;
  wire \clk_cnt_reg[8]_i_1_n_7 ;
  wire cnt_burst_calib;
  wire \cnt_burst_calib[6]_i_2_n_0 ;
  wire \cnt_burst_calib[7]_i_3_n_0 ;
  wire \cnt_burst_calib_reg[5]_0 ;
  wire [7:0]cnt_burst_calib_reg__0;
  wire data_timestamp_start;
  wire eqOp12_in;
  wire hit_source;
  wire [9:0]plusOp;
  wire [7:0]plusOp__0;
  wire rst_n;
  wire run;
  wire sel;
  wire \timeout_cnt[0]_i_3_n_0 ;
  wire \timeout_cnt[0]_i_4_n_0 ;
  wire \timeout_cnt[0]_i_5_n_0 ;
  wire \timeout_cnt[0]_i_6_n_0 ;
  wire [12:0]timeout_cnt_reg;
  wire \timeout_cnt_reg[0]_i_2_n_0 ;
  wire \timeout_cnt_reg[0]_i_2_n_1 ;
  wire \timeout_cnt_reg[0]_i_2_n_2 ;
  wire \timeout_cnt_reg[0]_i_2_n_3 ;
  wire \timeout_cnt_reg[0]_i_2_n_4 ;
  wire \timeout_cnt_reg[0]_i_2_n_5 ;
  wire \timeout_cnt_reg[0]_i_2_n_6 ;
  wire \timeout_cnt_reg[0]_i_2_n_7 ;
  wire \timeout_cnt_reg[12]_i_1_n_7 ;
  wire \timeout_cnt_reg[4]_i_1_n_0 ;
  wire \timeout_cnt_reg[4]_i_1_n_1 ;
  wire \timeout_cnt_reg[4]_i_1_n_2 ;
  wire \timeout_cnt_reg[4]_i_1_n_3 ;
  wire \timeout_cnt_reg[4]_i_1_n_4 ;
  wire \timeout_cnt_reg[4]_i_1_n_5 ;
  wire \timeout_cnt_reg[4]_i_1_n_6 ;
  wire \timeout_cnt_reg[4]_i_1_n_7 ;
  wire \timeout_cnt_reg[8]_i_1_n_0 ;
  wire \timeout_cnt_reg[8]_i_1_n_1 ;
  wire \timeout_cnt_reg[8]_i_1_n_2 ;
  wire \timeout_cnt_reg[8]_i_1_n_3 ;
  wire \timeout_cnt_reg[8]_i_1_n_4 ;
  wire \timeout_cnt_reg[8]_i_1_n_5 ;
  wire \timeout_cnt_reg[8]_i_1_n_6 ;
  wire \timeout_cnt_reg[8]_i_1_n_7 ;
  wire timeout_en;
  wire timeout_en_i_1_n_0;
  wire timeout_en_i_2_n_0;
  wire timeout_en_i_3_n_0;
  wire timeout_en_i_4_n_0;
  wire timeout_en_i_5_n_0;
  wire timeout_en_i_6_n_0;
  wire timeout_en_i_7_n_0;
  wire timeout_en_i_8_n_0;
  wire [31:0]timestampStart;
  wire [31:0]timestampStop;
  wire tlast_i_1_n_0;
  wire tvalid_i_1_n_0;
  wire \tx_num_meas[6]_i_2_n_0 ;
  wire \tx_num_meas[9]_i_2_n_0 ;
  wire [9:0]tx_num_meas_reg__0;
  wire [3:3]\NLW_clk_cnt_reg[12]_i_1_CO_UNCONNECTED ;
  wire [3:0]\NLW_timeout_cnt_reg[12]_i_1_CO_UNCONNECTED ;
  wire [3:1]\NLW_timeout_cnt_reg[12]_i_1_O_UNCONNECTED ;

  LUT6 #(
    .INIT(64'hFFFFFFFF11110010)) 
    \FSM_onehot_state[1]_i_1 
       (.I0(calibing_flag_r_reg_0),
        .I1(run),
        .I2(\FSM_onehot_state_reg_n_0_[3] ),
        .I3(eqOp12_in),
        .I4(\FSM_onehot_state_reg_n_0_[4] ),
        .I5(\FSM_onehot_state[1]_i_3_n_0 ),
        .O(\FSM_onehot_state[1]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair3" *) 
  LUT5 #(
    .INIT(32'h80000000)) 
    \FSM_onehot_state[1]_i_2 
       (.I0(calibing_flag_r_i_5_n_0),
        .I1(tx_num_meas_reg__0[4]),
        .I2(tx_num_meas_reg__0[5]),
        .I3(tx_num_meas_reg__0[2]),
        .I4(tx_num_meas_reg__0[3]),
        .O(eqOp12_in));
  (* SOFT_HLUTNM = "soft_lutpair4" *) 
  LUT5 #(
    .INIT(32'hA0A0A0A3)) 
    \FSM_onehot_state[1]_i_3 
       (.I0(axis_tready),
        .I1(\FSM_onehot_state_reg_n_0_[3] ),
        .I2(data_timestamp_start),
        .I3(\FSM_onehot_state_reg_n_0_[1] ),
        .I4(\FSM_onehot_state_reg_n_0_[4] ),
        .O(\FSM_onehot_state[1]_i_3_n_0 ));
  LUT6 #(
    .INIT(64'h50FF504050405040)) 
    \FSM_onehot_state[2]_i_1 
       (.I0(ValidOutStop),
        .I1(calibing_flag_r_reg_0),
        .I2(\FSM_onehot_state_reg_n_0_[4] ),
        .I3(run),
        .I4(\cnt_burst_calib_reg[5]_0 ),
        .I5(\FSM_onehot_state_reg_n_0_[1] ),
        .O(\FSM_onehot_state[2]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'hE000FFFFE000E000)) 
    \FSM_onehot_state[3]_i_1 
       (.I0(calibing_flag_r_reg_0),
        .I1(run),
        .I2(\FSM_onehot_state_reg_n_0_[4] ),
        .I3(ValidOutStop),
        .I4(axis_tready),
        .I5(data_timestamp_start),
        .O(\FSM_onehot_state[3]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'hFFFFFFFFFFFEFEFE)) 
    \FSM_onehot_state[4]_i_1 
       (.I0(\FSM_onehot_state[4]_i_3_n_0 ),
        .I1(\FSM_onehot_state[4]_i_4_n_0 ),
        .I2(\FSM_onehot_state[4]_i_5_n_0 ),
        .I3(\FSM_onehot_state[4]_i_6_n_0 ),
        .I4(\FSM_onehot_state[4]_i_7_n_0 ),
        .I5(\FSM_onehot_state[4]_i_8_n_0 ),
        .O(\FSM_onehot_state[4]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'hFFFFFFFFFFFFFFFE)) 
    \FSM_onehot_state[4]_i_10 
       (.I0(tx_num_meas_reg__0[8]),
        .I1(tx_num_meas_reg__0[9]),
        .I2(tx_num_meas_reg__0[7]),
        .I3(tx_num_meas_reg__0[6]),
        .I4(tx_num_meas_reg__0[0]),
        .I5(tx_num_meas_reg__0[1]),
        .O(\FSM_onehot_state[4]_i_10_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair3" *) 
  LUT4 #(
    .INIT(16'hFFFE)) 
    \FSM_onehot_state[4]_i_11 
       (.I0(tx_num_meas_reg__0[2]),
        .I1(tx_num_meas_reg__0[3]),
        .I2(tx_num_meas_reg__0[4]),
        .I3(tx_num_meas_reg__0[5]),
        .O(\FSM_onehot_state[4]_i_11_n_0 ));
  LUT6 #(
    .INIT(64'h8000000000000000)) 
    \FSM_onehot_state[4]_i_12 
       (.I0(timeout_cnt_reg[7]),
        .I1(timeout_cnt_reg[8]),
        .I2(timeout_cnt_reg[9]),
        .I3(timeout_cnt_reg[10]),
        .I4(timeout_cnt_reg[12]),
        .I5(timeout_cnt_reg[11]),
        .O(\FSM_onehot_state[4]_i_12_n_0 ));
  LUT3 #(
    .INIT(8'h80)) 
    \FSM_onehot_state[4]_i_13 
       (.I0(timeout_cnt_reg[2]),
        .I1(timeout_cnt_reg[1]),
        .I2(timeout_cnt_reg[0]),
        .O(\FSM_onehot_state[4]_i_13_n_0 ));
  LUT4 #(
    .INIT(16'h8000)) 
    \FSM_onehot_state[4]_i_14 
       (.I0(timeout_cnt_reg[6]),
        .I1(timeout_cnt_reg[5]),
        .I2(timeout_cnt_reg[4]),
        .I3(timeout_cnt_reg[3]),
        .O(\FSM_onehot_state[4]_i_14_n_0 ));
  LUT6 #(
    .INIT(64'hFFFAFFFAFFBABABA)) 
    \FSM_onehot_state[4]_i_2 
       (.I0(calibing_flag_r_i_3_n_0),
        .I1(\cnt_burst_calib_reg[5]_0 ),
        .I2(\FSM_onehot_state_reg_n_0_[1] ),
        .I3(\FSM_onehot_state_reg_n_0_[3] ),
        .I4(calibing_flag_r_reg_0),
        .I5(run),
        .O(\FSM_onehot_state[4]_i_2_n_0 ));
  LUT5 #(
    .INIT(32'hE0E0E0EC)) 
    \FSM_onehot_state[4]_i_3 
       (.I0(data_timestamp_start),
        .I1(\FSM_onehot_state_reg_n_0_[4] ),
        .I2(ValidOutStop),
        .I3(run),
        .I4(calibing_flag_r_reg_0),
        .O(\FSM_onehot_state[4]_i_3_n_0 ));
  LUT6 #(
    .INIT(64'hAAAAA2AAAAAAAAAA)) 
    \FSM_onehot_state[4]_i_4 
       (.I0(\FSM_onehot_state[4]_i_9_n_0 ),
        .I1(calib_finished_INST_0_i_1_n_0),
        .I2(cnt_burst_calib_reg__0[7]),
        .I3(cnt_burst_calib_reg__0[6]),
        .I4(cnt_burst_calib_reg__0[4]),
        .I5(cnt_burst_calib_reg__0[5]),
        .O(\FSM_onehot_state[4]_i_4_n_0 ));
  LUT6 #(
    .INIT(64'hA800000000000000)) 
    \FSM_onehot_state[4]_i_5 
       (.I0(\FSM_onehot_state_reg_n_0_[4] ),
        .I1(\FSM_onehot_state[4]_i_10_n_0 ),
        .I2(\FSM_onehot_state[4]_i_11_n_0 ),
        .I3(\FSM_onehot_state[4]_i_12_n_0 ),
        .I4(\FSM_onehot_state[4]_i_13_n_0 ),
        .I5(\FSM_onehot_state[4]_i_14_n_0 ),
        .O(\FSM_onehot_state[4]_i_5_n_0 ));
  LUT6 #(
    .INIT(64'h0020000000000000)) 
    \FSM_onehot_state[4]_i_6 
       (.I0(calib_finished_INST_0_i_1_n_0),
        .I1(cnt_burst_calib_reg__0[7]),
        .I2(cnt_burst_calib_reg__0[6]),
        .I3(cnt_burst_calib_reg__0[4]),
        .I4(cnt_burst_calib_reg__0[5]),
        .I5(\FSM_onehot_state_reg_n_0_[1] ),
        .O(\FSM_onehot_state[4]_i_6_n_0 ));
  LUT6 #(
    .INIT(64'hFFFFFFFFE0000000)) 
    \FSM_onehot_state[4]_i_7 
       (.I0(\FSM_onehot_state[4]_i_10_n_0 ),
        .I1(\FSM_onehot_state[4]_i_11_n_0 ),
        .I2(\FSM_onehot_state[4]_i_14_n_0 ),
        .I3(\FSM_onehot_state[4]_i_13_n_0 ),
        .I4(\FSM_onehot_state[4]_i_12_n_0 ),
        .I5(run),
        .O(\FSM_onehot_state[4]_i_7_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair4" *) 
  LUT5 #(
    .INIT(32'hA8A8A8AB)) 
    \FSM_onehot_state[4]_i_8 
       (.I0(axis_tready),
        .I1(\FSM_onehot_state_reg_n_0_[3] ),
        .I2(data_timestamp_start),
        .I3(\FSM_onehot_state_reg_n_0_[1] ),
        .I4(\FSM_onehot_state_reg_n_0_[4] ),
        .O(\FSM_onehot_state[4]_i_8_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair9" *) 
  LUT2 #(
    .INIT(4'h8)) 
    \FSM_onehot_state[4]_i_9 
       (.I0(\FSM_onehot_state_reg_n_0_[1] ),
        .I1(calib_en),
        .O(\FSM_onehot_state[4]_i_9_n_0 ));
  (* FSM_ENCODED_STATES = "eof:00100,running:10000,store:01000,idle:00010,iSTATE:00001" *) 
  FDPE #(
    .INIT(1'b1)) 
    \FSM_onehot_state_reg[0] 
       (.C(clk),
        .CE(\FSM_onehot_state[4]_i_1_n_0 ),
        .D(1'b0),
        .PRE(calibing_flag_r_i_2_n_0),
        .Q(\FSM_onehot_state_reg_n_0_[0] ));
  (* FSM_ENCODED_STATES = "eof:00100,running:10000,store:01000,idle:00010,iSTATE:00001" *) 
  FDCE #(
    .INIT(1'b0)) 
    \FSM_onehot_state_reg[1] 
       (.C(clk),
        .CE(\FSM_onehot_state[4]_i_1_n_0 ),
        .CLR(calibing_flag_r_i_2_n_0),
        .D(\FSM_onehot_state[1]_i_1_n_0 ),
        .Q(\FSM_onehot_state_reg_n_0_[1] ));
  (* FSM_ENCODED_STATES = "eof:00100,running:10000,store:01000,idle:00010,iSTATE:00001" *) 
  FDCE #(
    .INIT(1'b0)) 
    \FSM_onehot_state_reg[2] 
       (.C(clk),
        .CE(\FSM_onehot_state[4]_i_1_n_0 ),
        .CLR(calibing_flag_r_i_2_n_0),
        .D(\FSM_onehot_state[2]_i_1_n_0 ),
        .Q(data_timestamp_start));
  (* FSM_ENCODED_STATES = "eof:00100,running:10000,store:01000,idle:00010,iSTATE:00001" *) 
  FDCE #(
    .INIT(1'b0)) 
    \FSM_onehot_state_reg[3] 
       (.C(clk),
        .CE(\FSM_onehot_state[4]_i_1_n_0 ),
        .CLR(calibing_flag_r_i_2_n_0),
        .D(\FSM_onehot_state[3]_i_1_n_0 ),
        .Q(\FSM_onehot_state_reg_n_0_[3] ));
  (* FSM_ENCODED_STATES = "eof:00100,running:10000,store:01000,idle:00010,iSTATE:00001" *) 
  FDCE #(
    .INIT(1'b0)) 
    \FSM_onehot_state_reg[4] 
       (.C(clk),
        .CE(\FSM_onehot_state[4]_i_1_n_0 ),
        .CLR(calibing_flag_r_i_2_n_0),
        .D(\FSM_onehot_state[4]_i_2_n_0 ),
        .Q(\FSM_onehot_state_reg_n_0_[4] ));
  LUT1 #(
    .INIT(2'h1)) 
    \axis_tkeep[0]_INST_0 
       (.I0(\FSM_onehot_state_reg_n_0_[0] ),
        .O(DLenable));
  (* SOFT_HLUTNM = "soft_lutpair0" *) 
  LUT5 #(
    .INIT(32'h00200000)) 
    calib_finished_INST_0
       (.I0(cnt_burst_calib_reg__0[5]),
        .I1(cnt_burst_calib_reg__0[4]),
        .I2(cnt_burst_calib_reg__0[6]),
        .I3(cnt_burst_calib_reg__0[7]),
        .I4(calib_finished_INST_0_i_1_n_0),
        .O(\cnt_burst_calib_reg[5]_0 ));
  (* SOFT_HLUTNM = "soft_lutpair5" *) 
  LUT4 #(
    .INIT(16'h0100)) 
    calib_finished_INST_0_i_1
       (.I0(cnt_burst_calib_reg__0[1]),
        .I1(cnt_burst_calib_reg__0[0]),
        .I2(cnt_burst_calib_reg__0[3]),
        .I3(cnt_burst_calib_reg__0[2]),
        .O(calib_finished_INST_0_i_1_n_0));
  LUT6 #(
    .INIT(64'hFF7777778F000000)) 
    calibing_flag_r_i_1
       (.I0(calibing_flag_r_i_3_n_0),
        .I1(calibing_flag_r_i_4_n_0),
        .I2(\cnt_burst_calib_reg[5]_0 ),
        .I3(\FSM_onehot_state_reg_n_0_[1] ),
        .I4(calib_en),
        .I5(calibing_flag_r_reg_0),
        .O(calibing_flag_r_i_1_n_0));
  LUT1 #(
    .INIT(2'h1)) 
    calibing_flag_r_i_2
       (.I0(rst_n),
        .O(calibing_flag_r_i_2_n_0));
  LUT6 #(
    .INIT(64'h8000000000000000)) 
    calibing_flag_r_i_3
       (.I0(tx_num_meas_reg__0[3]),
        .I1(tx_num_meas_reg__0[2]),
        .I2(tx_num_meas_reg__0[5]),
        .I3(tx_num_meas_reg__0[4]),
        .I4(calibing_flag_r_i_5_n_0),
        .I5(\FSM_onehot_state_reg_n_0_[3] ),
        .O(calibing_flag_r_i_3_n_0));
  LUT4 #(
    .INIT(16'h0002)) 
    calibing_flag_r_i_4
       (.I0(calibing_flag_r_i_6_n_0),
        .I1(cnt_burst_calib_reg__0[2]),
        .I2(cnt_burst_calib_reg__0[3]),
        .I3(cnt_burst_calib_reg__0[4]),
        .O(calibing_flag_r_i_4_n_0));
  LUT6 #(
    .INIT(64'h0080000000000000)) 
    calibing_flag_r_i_5
       (.I0(tx_num_meas_reg__0[6]),
        .I1(tx_num_meas_reg__0[7]),
        .I2(tx_num_meas_reg__0[8]),
        .I3(tx_num_meas_reg__0[9]),
        .I4(tx_num_meas_reg__0[0]),
        .I5(tx_num_meas_reg__0[1]),
        .O(calibing_flag_r_i_5_n_0));
  LUT6 #(
    .INIT(64'h0080000000000000)) 
    calibing_flag_r_i_6
       (.I0(cnt_burst_calib_reg__0[5]),
        .I1(cnt_burst_calib_reg__0[6]),
        .I2(axis_tready),
        .I3(cnt_burst_calib_reg__0[7]),
        .I4(cnt_burst_calib_reg__0[1]),
        .I5(cnt_burst_calib_reg__0[0]),
        .O(calibing_flag_r_i_6_n_0));
  FDCE #(
    .INIT(1'b0)) 
    calibing_flag_r_reg
       (.C(clk),
        .CE(1'b1),
        .CLR(calibing_flag_r_i_2_n_0),
        .D(calibing_flag_r_i_1_n_0),
        .Q(calibing_flag_r_reg_0));
  LUT1 #(
    .INIT(2'h1)) 
    \clk_cnt[0]_i_1 
       (.I0(timeout_en),
        .O(clear));
  LUT1 #(
    .INIT(2'h1)) 
    \clk_cnt[0]_i_3 
       (.I0(clk_cnt_reg[0]),
        .O(\clk_cnt[0]_i_3_n_0 ));
  FDRE #(
    .INIT(1'b0)) 
    \clk_cnt_reg[0] 
       (.C(clk),
        .CE(1'b1),
        .D(\clk_cnt_reg[0]_i_2_n_7 ),
        .Q(clk_cnt_reg[0]),
        .R(clear));
  CARRY4 \clk_cnt_reg[0]_i_2 
       (.CI(1'b0),
        .CO({\clk_cnt_reg[0]_i_2_n_0 ,\clk_cnt_reg[0]_i_2_n_1 ,\clk_cnt_reg[0]_i_2_n_2 ,\clk_cnt_reg[0]_i_2_n_3 }),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b1}),
        .O({\clk_cnt_reg[0]_i_2_n_4 ,\clk_cnt_reg[0]_i_2_n_5 ,\clk_cnt_reg[0]_i_2_n_6 ,\clk_cnt_reg[0]_i_2_n_7 }),
        .S({clk_cnt_reg[3:1],\clk_cnt[0]_i_3_n_0 }));
  FDRE #(
    .INIT(1'b0)) 
    \clk_cnt_reg[10] 
       (.C(clk),
        .CE(1'b1),
        .D(\clk_cnt_reg[8]_i_1_n_5 ),
        .Q(clk_cnt_reg[10]),
        .R(clear));
  FDRE #(
    .INIT(1'b0)) 
    \clk_cnt_reg[11] 
       (.C(clk),
        .CE(1'b1),
        .D(\clk_cnt_reg[8]_i_1_n_4 ),
        .Q(clk_cnt_reg[11]),
        .R(clear));
  FDRE #(
    .INIT(1'b0)) 
    \clk_cnt_reg[12] 
       (.C(clk),
        .CE(1'b1),
        .D(\clk_cnt_reg[12]_i_1_n_7 ),
        .Q(clk_cnt_reg[12]),
        .R(clear));
  CARRY4 \clk_cnt_reg[12]_i_1 
       (.CI(\clk_cnt_reg[8]_i_1_n_0 ),
        .CO({\NLW_clk_cnt_reg[12]_i_1_CO_UNCONNECTED [3],\clk_cnt_reg[12]_i_1_n_1 ,\clk_cnt_reg[12]_i_1_n_2 ,\clk_cnt_reg[12]_i_1_n_3 }),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O({\clk_cnt_reg[12]_i_1_n_4 ,\clk_cnt_reg[12]_i_1_n_5 ,\clk_cnt_reg[12]_i_1_n_6 ,\clk_cnt_reg[12]_i_1_n_7 }),
        .S(clk_cnt_reg[15:12]));
  FDRE #(
    .INIT(1'b0)) 
    \clk_cnt_reg[13] 
       (.C(clk),
        .CE(1'b1),
        .D(\clk_cnt_reg[12]_i_1_n_6 ),
        .Q(clk_cnt_reg[13]),
        .R(clear));
  FDRE #(
    .INIT(1'b0)) 
    \clk_cnt_reg[14] 
       (.C(clk),
        .CE(1'b1),
        .D(\clk_cnt_reg[12]_i_1_n_5 ),
        .Q(clk_cnt_reg[14]),
        .R(clear));
  FDRE #(
    .INIT(1'b0)) 
    \clk_cnt_reg[15] 
       (.C(clk),
        .CE(1'b1),
        .D(\clk_cnt_reg[12]_i_1_n_4 ),
        .Q(clk_cnt_reg[15]),
        .R(clear));
  FDRE #(
    .INIT(1'b0)) 
    \clk_cnt_reg[1] 
       (.C(clk),
        .CE(1'b1),
        .D(\clk_cnt_reg[0]_i_2_n_6 ),
        .Q(clk_cnt_reg[1]),
        .R(clear));
  FDRE #(
    .INIT(1'b0)) 
    \clk_cnt_reg[2] 
       (.C(clk),
        .CE(1'b1),
        .D(\clk_cnt_reg[0]_i_2_n_5 ),
        .Q(clk_cnt_reg[2]),
        .R(clear));
  FDRE #(
    .INIT(1'b0)) 
    \clk_cnt_reg[3] 
       (.C(clk),
        .CE(1'b1),
        .D(\clk_cnt_reg[0]_i_2_n_4 ),
        .Q(clk_cnt_reg[3]),
        .R(clear));
  FDRE #(
    .INIT(1'b0)) 
    \clk_cnt_reg[4] 
       (.C(clk),
        .CE(1'b1),
        .D(\clk_cnt_reg[4]_i_1_n_7 ),
        .Q(clk_cnt_reg[4]),
        .R(clear));
  CARRY4 \clk_cnt_reg[4]_i_1 
       (.CI(\clk_cnt_reg[0]_i_2_n_0 ),
        .CO({\clk_cnt_reg[4]_i_1_n_0 ,\clk_cnt_reg[4]_i_1_n_1 ,\clk_cnt_reg[4]_i_1_n_2 ,\clk_cnt_reg[4]_i_1_n_3 }),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O({\clk_cnt_reg[4]_i_1_n_4 ,\clk_cnt_reg[4]_i_1_n_5 ,\clk_cnt_reg[4]_i_1_n_6 ,\clk_cnt_reg[4]_i_1_n_7 }),
        .S(clk_cnt_reg[7:4]));
  FDRE #(
    .INIT(1'b0)) 
    \clk_cnt_reg[5] 
       (.C(clk),
        .CE(1'b1),
        .D(\clk_cnt_reg[4]_i_1_n_6 ),
        .Q(clk_cnt_reg[5]),
        .R(clear));
  FDRE #(
    .INIT(1'b0)) 
    \clk_cnt_reg[6] 
       (.C(clk),
        .CE(1'b1),
        .D(\clk_cnt_reg[4]_i_1_n_5 ),
        .Q(clk_cnt_reg[6]),
        .R(clear));
  FDRE #(
    .INIT(1'b0)) 
    \clk_cnt_reg[7] 
       (.C(clk),
        .CE(1'b1),
        .D(\clk_cnt_reg[4]_i_1_n_4 ),
        .Q(clk_cnt_reg[7]),
        .R(clear));
  FDRE #(
    .INIT(1'b0)) 
    \clk_cnt_reg[8] 
       (.C(clk),
        .CE(1'b1),
        .D(\clk_cnt_reg[8]_i_1_n_7 ),
        .Q(clk_cnt_reg[8]),
        .R(clear));
  CARRY4 \clk_cnt_reg[8]_i_1 
       (.CI(\clk_cnt_reg[4]_i_1_n_0 ),
        .CO({\clk_cnt_reg[8]_i_1_n_0 ,\clk_cnt_reg[8]_i_1_n_1 ,\clk_cnt_reg[8]_i_1_n_2 ,\clk_cnt_reg[8]_i_1_n_3 }),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O({\clk_cnt_reg[8]_i_1_n_4 ,\clk_cnt_reg[8]_i_1_n_5 ,\clk_cnt_reg[8]_i_1_n_6 ,\clk_cnt_reg[8]_i_1_n_7 }),
        .S(clk_cnt_reg[11:8]));
  FDRE #(
    .INIT(1'b0)) 
    \clk_cnt_reg[9] 
       (.C(clk),
        .CE(1'b1),
        .D(\clk_cnt_reg[8]_i_1_n_6 ),
        .Q(clk_cnt_reg[9]),
        .R(clear));
  LUT1 #(
    .INIT(2'h1)) 
    \cnt_burst_calib[0]_i_1 
       (.I0(cnt_burst_calib_reg__0[0]),
        .O(plusOp__0[0]));
  (* SOFT_HLUTNM = "soft_lutpair8" *) 
  LUT2 #(
    .INIT(4'h6)) 
    \cnt_burst_calib[1]_i_1 
       (.I0(cnt_burst_calib_reg__0[0]),
        .I1(cnt_burst_calib_reg__0[1]),
        .O(plusOp__0[1]));
  (* SOFT_HLUTNM = "soft_lutpair6" *) 
  LUT3 #(
    .INIT(8'h78)) 
    \cnt_burst_calib[2]_i_1 
       (.I0(cnt_burst_calib_reg__0[1]),
        .I1(cnt_burst_calib_reg__0[0]),
        .I2(cnt_burst_calib_reg__0[2]),
        .O(plusOp__0[2]));
  (* SOFT_HLUTNM = "soft_lutpair6" *) 
  LUT4 #(
    .INIT(16'h7F80)) 
    \cnt_burst_calib[3]_i_1 
       (.I0(cnt_burst_calib_reg__0[0]),
        .I1(cnt_burst_calib_reg__0[1]),
        .I2(cnt_burst_calib_reg__0[2]),
        .I3(cnt_burst_calib_reg__0[3]),
        .O(plusOp__0[3]));
  (* SOFT_HLUTNM = "soft_lutpair5" *) 
  LUT5 #(
    .INIT(32'h7FFF8000)) 
    \cnt_burst_calib[4]_i_1 
       (.I0(cnt_burst_calib_reg__0[3]),
        .I1(cnt_burst_calib_reg__0[2]),
        .I2(cnt_burst_calib_reg__0[1]),
        .I3(cnt_burst_calib_reg__0[0]),
        .I4(cnt_burst_calib_reg__0[4]),
        .O(plusOp__0[4]));
  LUT6 #(
    .INIT(64'h7FFFFFFF80000000)) 
    \cnt_burst_calib[5]_i_1 
       (.I0(cnt_burst_calib_reg__0[0]),
        .I1(cnt_burst_calib_reg__0[1]),
        .I2(cnt_burst_calib_reg__0[2]),
        .I3(cnt_burst_calib_reg__0[3]),
        .I4(cnt_burst_calib_reg__0[4]),
        .I5(cnt_burst_calib_reg__0[5]),
        .O(plusOp__0[5]));
  LUT6 #(
    .INIT(64'hFFFF7FFF00008000)) 
    \cnt_burst_calib[6]_i_1 
       (.I0(cnt_burst_calib_reg__0[5]),
        .I1(cnt_burst_calib_reg__0[4]),
        .I2(cnt_burst_calib_reg__0[3]),
        .I3(cnt_burst_calib_reg__0[2]),
        .I4(\cnt_burst_calib[6]_i_2_n_0 ),
        .I5(cnt_burst_calib_reg__0[6]),
        .O(plusOp__0[6]));
  (* SOFT_HLUTNM = "soft_lutpair8" *) 
  LUT2 #(
    .INIT(4'h7)) 
    \cnt_burst_calib[6]_i_2 
       (.I0(cnt_burst_calib_reg__0[0]),
        .I1(cnt_burst_calib_reg__0[1]),
        .O(\cnt_burst_calib[6]_i_2_n_0 ));
  LUT3 #(
    .INIT(8'h80)) 
    \cnt_burst_calib[7]_i_1 
       (.I0(calibing_flag_r_reg_0),
        .I1(axis_tready),
        .I2(calibing_flag_r_i_3_n_0),
        .O(cnt_burst_calib));
  LUT3 #(
    .INIT(8'hD2)) 
    \cnt_burst_calib[7]_i_2 
       (.I0(cnt_burst_calib_reg__0[6]),
        .I1(\cnt_burst_calib[7]_i_3_n_0 ),
        .I2(cnt_burst_calib_reg__0[7]),
        .O(plusOp__0[7]));
  LUT6 #(
    .INIT(64'h7FFFFFFFFFFFFFFF)) 
    \cnt_burst_calib[7]_i_3 
       (.I0(cnt_burst_calib_reg__0[0]),
        .I1(cnt_burst_calib_reg__0[1]),
        .I2(cnt_burst_calib_reg__0[2]),
        .I3(cnt_burst_calib_reg__0[3]),
        .I4(cnt_burst_calib_reg__0[4]),
        .I5(cnt_burst_calib_reg__0[5]),
        .O(\cnt_burst_calib[7]_i_3_n_0 ));
  FDCE #(
    .INIT(1'b0)) 
    \cnt_burst_calib_reg[0] 
       (.C(clk),
        .CE(cnt_burst_calib),
        .CLR(calibing_flag_r_i_2_n_0),
        .D(plusOp__0[0]),
        .Q(cnt_burst_calib_reg__0[0]));
  FDCE #(
    .INIT(1'b0)) 
    \cnt_burst_calib_reg[1] 
       (.C(clk),
        .CE(cnt_burst_calib),
        .CLR(calibing_flag_r_i_2_n_0),
        .D(plusOp__0[1]),
        .Q(cnt_burst_calib_reg__0[1]));
  FDCE #(
    .INIT(1'b0)) 
    \cnt_burst_calib_reg[2] 
       (.C(clk),
        .CE(cnt_burst_calib),
        .CLR(calibing_flag_r_i_2_n_0),
        .D(plusOp__0[2]),
        .Q(cnt_burst_calib_reg__0[2]));
  FDCE #(
    .INIT(1'b0)) 
    \cnt_burst_calib_reg[3] 
       (.C(clk),
        .CE(cnt_burst_calib),
        .CLR(calibing_flag_r_i_2_n_0),
        .D(plusOp__0[3]),
        .Q(cnt_burst_calib_reg__0[3]));
  FDCE #(
    .INIT(1'b0)) 
    \cnt_burst_calib_reg[4] 
       (.C(clk),
        .CE(cnt_burst_calib),
        .CLR(calibing_flag_r_i_2_n_0),
        .D(plusOp__0[4]),
        .Q(cnt_burst_calib_reg__0[4]));
  FDCE #(
    .INIT(1'b0)) 
    \cnt_burst_calib_reg[5] 
       (.C(clk),
        .CE(cnt_burst_calib),
        .CLR(calibing_flag_r_i_2_n_0),
        .D(plusOp__0[5]),
        .Q(cnt_burst_calib_reg__0[5]));
  FDCE #(
    .INIT(1'b0)) 
    \cnt_burst_calib_reg[6] 
       (.C(clk),
        .CE(cnt_burst_calib),
        .CLR(calibing_flag_r_i_2_n_0),
        .D(plusOp__0[6]),
        .Q(cnt_burst_calib_reg__0[6]));
  FDCE #(
    .INIT(1'b0)) 
    \cnt_burst_calib_reg[7] 
       (.C(clk),
        .CE(cnt_burst_calib),
        .CLR(calibing_flag_r_i_2_n_0),
        .D(plusOp__0[7]),
        .Q(cnt_burst_calib_reg__0[7]));
  FDSE #(
    .INIT(1'b1)) 
    \data_timestamp_start_reg[0] 
       (.C(clk),
        .CE(ValidOutStart),
        .D(timestampStart[0]),
        .Q(axis_tdata[0]),
        .S(data_timestamp_start));
  FDSE #(
    .INIT(1'b1)) 
    \data_timestamp_start_reg[10] 
       (.C(clk),
        .CE(ValidOutStart),
        .D(timestampStart[10]),
        .Q(axis_tdata[10]),
        .S(data_timestamp_start));
  FDSE #(
    .INIT(1'b1)) 
    \data_timestamp_start_reg[11] 
       (.C(clk),
        .CE(ValidOutStart),
        .D(timestampStart[11]),
        .Q(axis_tdata[11]),
        .S(data_timestamp_start));
  FDSE #(
    .INIT(1'b1)) 
    \data_timestamp_start_reg[12] 
       (.C(clk),
        .CE(ValidOutStart),
        .D(timestampStart[12]),
        .Q(axis_tdata[12]),
        .S(data_timestamp_start));
  FDSE #(
    .INIT(1'b1)) 
    \data_timestamp_start_reg[13] 
       (.C(clk),
        .CE(ValidOutStart),
        .D(timestampStart[13]),
        .Q(axis_tdata[13]),
        .S(data_timestamp_start));
  FDSE #(
    .INIT(1'b1)) 
    \data_timestamp_start_reg[14] 
       (.C(clk),
        .CE(ValidOutStart),
        .D(timestampStart[14]),
        .Q(axis_tdata[14]),
        .S(data_timestamp_start));
  FDSE #(
    .INIT(1'b1)) 
    \data_timestamp_start_reg[15] 
       (.C(clk),
        .CE(ValidOutStart),
        .D(timestampStart[15]),
        .Q(axis_tdata[15]),
        .S(data_timestamp_start));
  FDSE #(
    .INIT(1'b1)) 
    \data_timestamp_start_reg[16] 
       (.C(clk),
        .CE(ValidOutStart),
        .D(timestampStart[16]),
        .Q(axis_tdata[16]),
        .S(data_timestamp_start));
  FDSE #(
    .INIT(1'b1)) 
    \data_timestamp_start_reg[17] 
       (.C(clk),
        .CE(ValidOutStart),
        .D(timestampStart[17]),
        .Q(axis_tdata[17]),
        .S(data_timestamp_start));
  FDSE #(
    .INIT(1'b1)) 
    \data_timestamp_start_reg[18] 
       (.C(clk),
        .CE(ValidOutStart),
        .D(timestampStart[18]),
        .Q(axis_tdata[18]),
        .S(data_timestamp_start));
  FDSE #(
    .INIT(1'b1)) 
    \data_timestamp_start_reg[19] 
       (.C(clk),
        .CE(ValidOutStart),
        .D(timestampStart[19]),
        .Q(axis_tdata[19]),
        .S(data_timestamp_start));
  FDSE #(
    .INIT(1'b1)) 
    \data_timestamp_start_reg[1] 
       (.C(clk),
        .CE(ValidOutStart),
        .D(timestampStart[1]),
        .Q(axis_tdata[1]),
        .S(data_timestamp_start));
  FDSE #(
    .INIT(1'b1)) 
    \data_timestamp_start_reg[20] 
       (.C(clk),
        .CE(ValidOutStart),
        .D(timestampStart[20]),
        .Q(axis_tdata[20]),
        .S(data_timestamp_start));
  FDSE #(
    .INIT(1'b1)) 
    \data_timestamp_start_reg[21] 
       (.C(clk),
        .CE(ValidOutStart),
        .D(timestampStart[21]),
        .Q(axis_tdata[21]),
        .S(data_timestamp_start));
  FDSE #(
    .INIT(1'b1)) 
    \data_timestamp_start_reg[22] 
       (.C(clk),
        .CE(ValidOutStart),
        .D(timestampStart[22]),
        .Q(axis_tdata[22]),
        .S(data_timestamp_start));
  FDSE #(
    .INIT(1'b1)) 
    \data_timestamp_start_reg[23] 
       (.C(clk),
        .CE(ValidOutStart),
        .D(timestampStart[23]),
        .Q(axis_tdata[23]),
        .S(data_timestamp_start));
  FDSE #(
    .INIT(1'b1)) 
    \data_timestamp_start_reg[24] 
       (.C(clk),
        .CE(ValidOutStart),
        .D(timestampStart[24]),
        .Q(axis_tdata[24]),
        .S(data_timestamp_start));
  FDSE #(
    .INIT(1'b1)) 
    \data_timestamp_start_reg[25] 
       (.C(clk),
        .CE(ValidOutStart),
        .D(timestampStart[25]),
        .Q(axis_tdata[25]),
        .S(data_timestamp_start));
  FDSE #(
    .INIT(1'b1)) 
    \data_timestamp_start_reg[26] 
       (.C(clk),
        .CE(ValidOutStart),
        .D(timestampStart[26]),
        .Q(axis_tdata[26]),
        .S(data_timestamp_start));
  FDSE #(
    .INIT(1'b1)) 
    \data_timestamp_start_reg[27] 
       (.C(clk),
        .CE(ValidOutStart),
        .D(timestampStart[27]),
        .Q(axis_tdata[27]),
        .S(data_timestamp_start));
  FDSE #(
    .INIT(1'b1)) 
    \data_timestamp_start_reg[28] 
       (.C(clk),
        .CE(ValidOutStart),
        .D(timestampStart[28]),
        .Q(axis_tdata[28]),
        .S(data_timestamp_start));
  FDSE #(
    .INIT(1'b1)) 
    \data_timestamp_start_reg[29] 
       (.C(clk),
        .CE(ValidOutStart),
        .D(timestampStart[29]),
        .Q(axis_tdata[29]),
        .S(data_timestamp_start));
  FDSE #(
    .INIT(1'b1)) 
    \data_timestamp_start_reg[2] 
       (.C(clk),
        .CE(ValidOutStart),
        .D(timestampStart[2]),
        .Q(axis_tdata[2]),
        .S(data_timestamp_start));
  FDSE #(
    .INIT(1'b1)) 
    \data_timestamp_start_reg[30] 
       (.C(clk),
        .CE(ValidOutStart),
        .D(timestampStart[30]),
        .Q(axis_tdata[30]),
        .S(data_timestamp_start));
  FDSE #(
    .INIT(1'b1)) 
    \data_timestamp_start_reg[31] 
       (.C(clk),
        .CE(ValidOutStart),
        .D(timestampStart[31]),
        .Q(axis_tdata[31]),
        .S(data_timestamp_start));
  FDSE #(
    .INIT(1'b1)) 
    \data_timestamp_start_reg[3] 
       (.C(clk),
        .CE(ValidOutStart),
        .D(timestampStart[3]),
        .Q(axis_tdata[3]),
        .S(data_timestamp_start));
  FDSE #(
    .INIT(1'b1)) 
    \data_timestamp_start_reg[4] 
       (.C(clk),
        .CE(ValidOutStart),
        .D(timestampStart[4]),
        .Q(axis_tdata[4]),
        .S(data_timestamp_start));
  FDSE #(
    .INIT(1'b1)) 
    \data_timestamp_start_reg[5] 
       (.C(clk),
        .CE(ValidOutStart),
        .D(timestampStart[5]),
        .Q(axis_tdata[5]),
        .S(data_timestamp_start));
  FDSE #(
    .INIT(1'b1)) 
    \data_timestamp_start_reg[6] 
       (.C(clk),
        .CE(ValidOutStart),
        .D(timestampStart[6]),
        .Q(axis_tdata[6]),
        .S(data_timestamp_start));
  FDSE #(
    .INIT(1'b1)) 
    \data_timestamp_start_reg[7] 
       (.C(clk),
        .CE(ValidOutStart),
        .D(timestampStart[7]),
        .Q(axis_tdata[7]),
        .S(data_timestamp_start));
  FDSE #(
    .INIT(1'b1)) 
    \data_timestamp_start_reg[8] 
       (.C(clk),
        .CE(ValidOutStart),
        .D(timestampStart[8]),
        .Q(axis_tdata[8]),
        .S(data_timestamp_start));
  FDSE #(
    .INIT(1'b1)) 
    \data_timestamp_start_reg[9] 
       (.C(clk),
        .CE(ValidOutStart),
        .D(timestampStart[9]),
        .Q(axis_tdata[9]),
        .S(data_timestamp_start));
  FDSE #(
    .INIT(1'b1)) 
    \data_timestamp_stop_reg[0] 
       (.C(clk),
        .CE(ValidOutStop),
        .D(timestampStop[0]),
        .Q(axis_tdata[32]),
        .S(data_timestamp_start));
  FDSE #(
    .INIT(1'b1)) 
    \data_timestamp_stop_reg[10] 
       (.C(clk),
        .CE(ValidOutStop),
        .D(timestampStop[10]),
        .Q(axis_tdata[42]),
        .S(data_timestamp_start));
  FDSE #(
    .INIT(1'b1)) 
    \data_timestamp_stop_reg[11] 
       (.C(clk),
        .CE(ValidOutStop),
        .D(timestampStop[11]),
        .Q(axis_tdata[43]),
        .S(data_timestamp_start));
  FDSE #(
    .INIT(1'b1)) 
    \data_timestamp_stop_reg[12] 
       (.C(clk),
        .CE(ValidOutStop),
        .D(timestampStop[12]),
        .Q(axis_tdata[44]),
        .S(data_timestamp_start));
  FDSE #(
    .INIT(1'b1)) 
    \data_timestamp_stop_reg[13] 
       (.C(clk),
        .CE(ValidOutStop),
        .D(timestampStop[13]),
        .Q(axis_tdata[45]),
        .S(data_timestamp_start));
  FDSE #(
    .INIT(1'b1)) 
    \data_timestamp_stop_reg[14] 
       (.C(clk),
        .CE(ValidOutStop),
        .D(timestampStop[14]),
        .Q(axis_tdata[46]),
        .S(data_timestamp_start));
  FDSE #(
    .INIT(1'b1)) 
    \data_timestamp_stop_reg[15] 
       (.C(clk),
        .CE(ValidOutStop),
        .D(timestampStop[15]),
        .Q(axis_tdata[47]),
        .S(data_timestamp_start));
  FDSE #(
    .INIT(1'b1)) 
    \data_timestamp_stop_reg[16] 
       (.C(clk),
        .CE(ValidOutStop),
        .D(timestampStop[16]),
        .Q(axis_tdata[48]),
        .S(data_timestamp_start));
  FDSE #(
    .INIT(1'b1)) 
    \data_timestamp_stop_reg[17] 
       (.C(clk),
        .CE(ValidOutStop),
        .D(timestampStop[17]),
        .Q(axis_tdata[49]),
        .S(data_timestamp_start));
  FDSE #(
    .INIT(1'b1)) 
    \data_timestamp_stop_reg[18] 
       (.C(clk),
        .CE(ValidOutStop),
        .D(timestampStop[18]),
        .Q(axis_tdata[50]),
        .S(data_timestamp_start));
  FDSE #(
    .INIT(1'b1)) 
    \data_timestamp_stop_reg[19] 
       (.C(clk),
        .CE(ValidOutStop),
        .D(timestampStop[19]),
        .Q(axis_tdata[51]),
        .S(data_timestamp_start));
  FDSE #(
    .INIT(1'b1)) 
    \data_timestamp_stop_reg[1] 
       (.C(clk),
        .CE(ValidOutStop),
        .D(timestampStop[1]),
        .Q(axis_tdata[33]),
        .S(data_timestamp_start));
  FDSE #(
    .INIT(1'b1)) 
    \data_timestamp_stop_reg[20] 
       (.C(clk),
        .CE(ValidOutStop),
        .D(timestampStop[20]),
        .Q(axis_tdata[52]),
        .S(data_timestamp_start));
  FDSE #(
    .INIT(1'b1)) 
    \data_timestamp_stop_reg[21] 
       (.C(clk),
        .CE(ValidOutStop),
        .D(timestampStop[21]),
        .Q(axis_tdata[53]),
        .S(data_timestamp_start));
  FDSE #(
    .INIT(1'b1)) 
    \data_timestamp_stop_reg[22] 
       (.C(clk),
        .CE(ValidOutStop),
        .D(timestampStop[22]),
        .Q(axis_tdata[54]),
        .S(data_timestamp_start));
  FDSE #(
    .INIT(1'b1)) 
    \data_timestamp_stop_reg[23] 
       (.C(clk),
        .CE(ValidOutStop),
        .D(timestampStop[23]),
        .Q(axis_tdata[55]),
        .S(data_timestamp_start));
  FDSE #(
    .INIT(1'b1)) 
    \data_timestamp_stop_reg[24] 
       (.C(clk),
        .CE(ValidOutStop),
        .D(timestampStop[24]),
        .Q(axis_tdata[56]),
        .S(data_timestamp_start));
  FDSE #(
    .INIT(1'b1)) 
    \data_timestamp_stop_reg[25] 
       (.C(clk),
        .CE(ValidOutStop),
        .D(timestampStop[25]),
        .Q(axis_tdata[57]),
        .S(data_timestamp_start));
  FDSE #(
    .INIT(1'b1)) 
    \data_timestamp_stop_reg[26] 
       (.C(clk),
        .CE(ValidOutStop),
        .D(timestampStop[26]),
        .Q(axis_tdata[58]),
        .S(data_timestamp_start));
  FDSE #(
    .INIT(1'b1)) 
    \data_timestamp_stop_reg[27] 
       (.C(clk),
        .CE(ValidOutStop),
        .D(timestampStop[27]),
        .Q(axis_tdata[59]),
        .S(data_timestamp_start));
  FDSE #(
    .INIT(1'b1)) 
    \data_timestamp_stop_reg[28] 
       (.C(clk),
        .CE(ValidOutStop),
        .D(timestampStop[28]),
        .Q(axis_tdata[60]),
        .S(data_timestamp_start));
  FDSE #(
    .INIT(1'b1)) 
    \data_timestamp_stop_reg[29] 
       (.C(clk),
        .CE(ValidOutStop),
        .D(timestampStop[29]),
        .Q(axis_tdata[61]),
        .S(data_timestamp_start));
  FDSE #(
    .INIT(1'b1)) 
    \data_timestamp_stop_reg[2] 
       (.C(clk),
        .CE(ValidOutStop),
        .D(timestampStop[2]),
        .Q(axis_tdata[34]),
        .S(data_timestamp_start));
  FDSE #(
    .INIT(1'b1)) 
    \data_timestamp_stop_reg[30] 
       (.C(clk),
        .CE(ValidOutStop),
        .D(timestampStop[30]),
        .Q(axis_tdata[62]),
        .S(data_timestamp_start));
  FDSE #(
    .INIT(1'b1)) 
    \data_timestamp_stop_reg[31] 
       (.C(clk),
        .CE(ValidOutStop),
        .D(timestampStop[31]),
        .Q(axis_tdata[63]),
        .S(data_timestamp_start));
  FDSE #(
    .INIT(1'b1)) 
    \data_timestamp_stop_reg[3] 
       (.C(clk),
        .CE(ValidOutStop),
        .D(timestampStop[3]),
        .Q(axis_tdata[35]),
        .S(data_timestamp_start));
  FDSE #(
    .INIT(1'b1)) 
    \data_timestamp_stop_reg[4] 
       (.C(clk),
        .CE(ValidOutStop),
        .D(timestampStop[4]),
        .Q(axis_tdata[36]),
        .S(data_timestamp_start));
  FDSE #(
    .INIT(1'b1)) 
    \data_timestamp_stop_reg[5] 
       (.C(clk),
        .CE(ValidOutStop),
        .D(timestampStop[5]),
        .Q(axis_tdata[37]),
        .S(data_timestamp_start));
  FDSE #(
    .INIT(1'b1)) 
    \data_timestamp_stop_reg[6] 
       (.C(clk),
        .CE(ValidOutStop),
        .D(timestampStop[6]),
        .Q(axis_tdata[38]),
        .S(data_timestamp_start));
  FDSE #(
    .INIT(1'b1)) 
    \data_timestamp_stop_reg[7] 
       (.C(clk),
        .CE(ValidOutStop),
        .D(timestampStop[7]),
        .Q(axis_tdata[39]),
        .S(data_timestamp_start));
  FDSE #(
    .INIT(1'b1)) 
    \data_timestamp_stop_reg[8] 
       (.C(clk),
        .CE(ValidOutStop),
        .D(timestampStop[8]),
        .Q(axis_tdata[40]),
        .S(data_timestamp_start));
  FDSE #(
    .INIT(1'b1)) 
    \data_timestamp_stop_reg[9] 
       (.C(clk),
        .CE(ValidOutStop),
        .D(timestampStop[9]),
        .Q(axis_tdata[41]),
        .S(data_timestamp_start));
  LUT1 #(
    .INIT(2'h1)) 
    hit_source_INST_0
       (.I0(\cnt_burst_calib_reg[5]_0 ),
        .O(hit_source));
  LUT6 #(
    .INIT(64'h0000000200000000)) 
    \timeout_cnt[0]_i_1 
       (.I0(\timeout_cnt[0]_i_3_n_0 ),
        .I1(clk_cnt_reg[1]),
        .I2(clk_cnt_reg[0]),
        .I3(clk_cnt_reg[3]),
        .I4(clk_cnt_reg[2]),
        .I5(\timeout_cnt[0]_i_4_n_0 ),
        .O(sel));
  LUT4 #(
    .INIT(16'h0001)) 
    \timeout_cnt[0]_i_3 
       (.I0(clk_cnt_reg[7]),
        .I1(clk_cnt_reg[6]),
        .I2(clk_cnt_reg[5]),
        .I3(clk_cnt_reg[4]),
        .O(\timeout_cnt[0]_i_3_n_0 ));
  LUT5 #(
    .INIT(32'h00010000)) 
    \timeout_cnt[0]_i_4 
       (.I0(clk_cnt_reg[12]),
        .I1(clk_cnt_reg[13]),
        .I2(clk_cnt_reg[14]),
        .I3(clk_cnt_reg[15]),
        .I4(\timeout_cnt[0]_i_6_n_0 ),
        .O(\timeout_cnt[0]_i_4_n_0 ));
  LUT1 #(
    .INIT(2'h1)) 
    \timeout_cnt[0]_i_5 
       (.I0(timeout_cnt_reg[0]),
        .O(\timeout_cnt[0]_i_5_n_0 ));
  LUT4 #(
    .INIT(16'h0001)) 
    \timeout_cnt[0]_i_6 
       (.I0(clk_cnt_reg[11]),
        .I1(clk_cnt_reg[10]),
        .I2(clk_cnt_reg[9]),
        .I3(clk_cnt_reg[8]),
        .O(\timeout_cnt[0]_i_6_n_0 ));
  FDRE #(
    .INIT(1'b0)) 
    \timeout_cnt_reg[0] 
       (.C(clk),
        .CE(sel),
        .D(\timeout_cnt_reg[0]_i_2_n_7 ),
        .Q(timeout_cnt_reg[0]),
        .R(clear));
  CARRY4 \timeout_cnt_reg[0]_i_2 
       (.CI(1'b0),
        .CO({\timeout_cnt_reg[0]_i_2_n_0 ,\timeout_cnt_reg[0]_i_2_n_1 ,\timeout_cnt_reg[0]_i_2_n_2 ,\timeout_cnt_reg[0]_i_2_n_3 }),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b1}),
        .O({\timeout_cnt_reg[0]_i_2_n_4 ,\timeout_cnt_reg[0]_i_2_n_5 ,\timeout_cnt_reg[0]_i_2_n_6 ,\timeout_cnt_reg[0]_i_2_n_7 }),
        .S({timeout_cnt_reg[3:1],\timeout_cnt[0]_i_5_n_0 }));
  FDRE #(
    .INIT(1'b0)) 
    \timeout_cnt_reg[10] 
       (.C(clk),
        .CE(sel),
        .D(\timeout_cnt_reg[8]_i_1_n_5 ),
        .Q(timeout_cnt_reg[10]),
        .R(clear));
  FDRE #(
    .INIT(1'b0)) 
    \timeout_cnt_reg[11] 
       (.C(clk),
        .CE(sel),
        .D(\timeout_cnt_reg[8]_i_1_n_4 ),
        .Q(timeout_cnt_reg[11]),
        .R(clear));
  FDRE #(
    .INIT(1'b0)) 
    \timeout_cnt_reg[12] 
       (.C(clk),
        .CE(sel),
        .D(\timeout_cnt_reg[12]_i_1_n_7 ),
        .Q(timeout_cnt_reg[12]),
        .R(clear));
  CARRY4 \timeout_cnt_reg[12]_i_1 
       (.CI(\timeout_cnt_reg[8]_i_1_n_0 ),
        .CO(\NLW_timeout_cnt_reg[12]_i_1_CO_UNCONNECTED [3:0]),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O({\NLW_timeout_cnt_reg[12]_i_1_O_UNCONNECTED [3:1],\timeout_cnt_reg[12]_i_1_n_7 }),
        .S({1'b0,1'b0,1'b0,timeout_cnt_reg[12]}));
  FDRE #(
    .INIT(1'b0)) 
    \timeout_cnt_reg[1] 
       (.C(clk),
        .CE(sel),
        .D(\timeout_cnt_reg[0]_i_2_n_6 ),
        .Q(timeout_cnt_reg[1]),
        .R(clear));
  FDRE #(
    .INIT(1'b0)) 
    \timeout_cnt_reg[2] 
       (.C(clk),
        .CE(sel),
        .D(\timeout_cnt_reg[0]_i_2_n_5 ),
        .Q(timeout_cnt_reg[2]),
        .R(clear));
  FDRE #(
    .INIT(1'b0)) 
    \timeout_cnt_reg[3] 
       (.C(clk),
        .CE(sel),
        .D(\timeout_cnt_reg[0]_i_2_n_4 ),
        .Q(timeout_cnt_reg[3]),
        .R(clear));
  FDRE #(
    .INIT(1'b0)) 
    \timeout_cnt_reg[4] 
       (.C(clk),
        .CE(sel),
        .D(\timeout_cnt_reg[4]_i_1_n_7 ),
        .Q(timeout_cnt_reg[4]),
        .R(clear));
  CARRY4 \timeout_cnt_reg[4]_i_1 
       (.CI(\timeout_cnt_reg[0]_i_2_n_0 ),
        .CO({\timeout_cnt_reg[4]_i_1_n_0 ,\timeout_cnt_reg[4]_i_1_n_1 ,\timeout_cnt_reg[4]_i_1_n_2 ,\timeout_cnt_reg[4]_i_1_n_3 }),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O({\timeout_cnt_reg[4]_i_1_n_4 ,\timeout_cnt_reg[4]_i_1_n_5 ,\timeout_cnt_reg[4]_i_1_n_6 ,\timeout_cnt_reg[4]_i_1_n_7 }),
        .S(timeout_cnt_reg[7:4]));
  FDRE #(
    .INIT(1'b0)) 
    \timeout_cnt_reg[5] 
       (.C(clk),
        .CE(sel),
        .D(\timeout_cnt_reg[4]_i_1_n_6 ),
        .Q(timeout_cnt_reg[5]),
        .R(clear));
  FDRE #(
    .INIT(1'b0)) 
    \timeout_cnt_reg[6] 
       (.C(clk),
        .CE(sel),
        .D(\timeout_cnt_reg[4]_i_1_n_5 ),
        .Q(timeout_cnt_reg[6]),
        .R(clear));
  FDRE #(
    .INIT(1'b0)) 
    \timeout_cnt_reg[7] 
       (.C(clk),
        .CE(sel),
        .D(\timeout_cnt_reg[4]_i_1_n_4 ),
        .Q(timeout_cnt_reg[7]),
        .R(clear));
  FDRE #(
    .INIT(1'b0)) 
    \timeout_cnt_reg[8] 
       (.C(clk),
        .CE(sel),
        .D(\timeout_cnt_reg[8]_i_1_n_7 ),
        .Q(timeout_cnt_reg[8]),
        .R(clear));
  CARRY4 \timeout_cnt_reg[8]_i_1 
       (.CI(\timeout_cnt_reg[4]_i_1_n_0 ),
        .CO({\timeout_cnt_reg[8]_i_1_n_0 ,\timeout_cnt_reg[8]_i_1_n_1 ,\timeout_cnt_reg[8]_i_1_n_2 ,\timeout_cnt_reg[8]_i_1_n_3 }),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O({\timeout_cnt_reg[8]_i_1_n_4 ,\timeout_cnt_reg[8]_i_1_n_5 ,\timeout_cnt_reg[8]_i_1_n_6 ,\timeout_cnt_reg[8]_i_1_n_7 }),
        .S(timeout_cnt_reg[11:8]));
  FDRE #(
    .INIT(1'b0)) 
    \timeout_cnt_reg[9] 
       (.C(clk),
        .CE(sel),
        .D(\timeout_cnt_reg[8]_i_1_n_6 ),
        .Q(timeout_cnt_reg[9]),
        .R(clear));
  LUT6 #(
    .INIT(64'hEEEEEEEFEEEEEEE0)) 
    timeout_en_i_1
       (.I0(timeout_en_i_2_n_0),
        .I1(timeout_en_i_3_n_0),
        .I2(timeout_en_i_4_n_0),
        .I3(timeout_en_i_5_n_0),
        .I4(timeout_en_i_6_n_0),
        .I5(timeout_en),
        .O(timeout_en_i_1_n_0));
  LUT5 #(
    .INIT(32'hFFFF7F00)) 
    timeout_en_i_2
       (.I0(\FSM_onehot_state[4]_i_14_n_0 ),
        .I1(\FSM_onehot_state[4]_i_13_n_0 ),
        .I2(\FSM_onehot_state[4]_i_12_n_0 ),
        .I3(\FSM_onehot_state_reg_n_0_[1] ),
        .I4(data_timestamp_start),
        .O(timeout_en_i_2_n_0));
  LUT6 #(
    .INIT(64'h00A8A8A8A8A8A8A8)) 
    timeout_en_i_3
       (.I0(\FSM_onehot_state_reg_n_0_[4] ),
        .I1(\FSM_onehot_state[4]_i_10_n_0 ),
        .I2(\FSM_onehot_state[4]_i_11_n_0 ),
        .I3(\FSM_onehot_state[4]_i_12_n_0 ),
        .I4(\FSM_onehot_state[4]_i_13_n_0 ),
        .I5(\FSM_onehot_state[4]_i_14_n_0 ),
        .O(timeout_en_i_3_n_0));
  LUT6 #(
    .INIT(64'h4000400040000000)) 
    timeout_en_i_4
       (.I0(run),
        .I1(calib_finished_INST_0_i_1_n_0),
        .I2(timeout_en_i_7_n_0),
        .I3(timeout_en_i_8_n_0),
        .I4(\FSM_onehot_state[4]_i_11_n_0 ),
        .I5(\FSM_onehot_state[4]_i_10_n_0 ),
        .O(timeout_en_i_4_n_0));
  LUT5 #(
    .INIT(32'h00008880)) 
    timeout_en_i_5
       (.I0(\FSM_onehot_state_reg_n_0_[4] ),
        .I1(rst_n),
        .I2(calibing_flag_r_reg_0),
        .I3(run),
        .I4(ValidOutStop),
        .O(timeout_en_i_5_n_0));
  LUT6 #(
    .INIT(64'hAA00AA0000000300)) 
    timeout_en_i_6
       (.I0(axis_tready),
        .I1(\FSM_onehot_state_reg_n_0_[1] ),
        .I2(\FSM_onehot_state_reg_n_0_[4] ),
        .I3(rst_n),
        .I4(data_timestamp_start),
        .I5(\FSM_onehot_state_reg_n_0_[3] ),
        .O(timeout_en_i_6_n_0));
  (* SOFT_HLUTNM = "soft_lutpair0" *) 
  LUT4 #(
    .INIT(16'h0400)) 
    timeout_en_i_7
       (.I0(cnt_burst_calib_reg__0[7]),
        .I1(cnt_burst_calib_reg__0[6]),
        .I2(cnt_burst_calib_reg__0[4]),
        .I3(cnt_burst_calib_reg__0[5]),
        .O(timeout_en_i_7_n_0));
  (* SOFT_HLUTNM = "soft_lutpair9" *) 
  LUT2 #(
    .INIT(4'h8)) 
    timeout_en_i_8
       (.I0(rst_n),
        .I1(\FSM_onehot_state_reg_n_0_[1] ),
        .O(timeout_en_i_8_n_0));
  FDRE #(
    .INIT(1'b0)) 
    timeout_en_reg
       (.C(clk),
        .CE(1'b1),
        .D(timeout_en_i_1_n_0),
        .Q(timeout_en),
        .R(1'b0));
  LUT6 #(
    .INIT(64'hFFFFF111FFEEF000)) 
    tlast_i_1
       (.I0(\FSM_onehot_state_reg_n_0_[1] ),
        .I1(\FSM_onehot_state_reg_n_0_[4] ),
        .I2(data_timestamp_start),
        .I3(axis_tready),
        .I4(calibing_flag_r_i_3_n_0),
        .I5(axis_tlast),
        .O(tlast_i_1_n_0));
  FDCE tlast_reg
       (.C(clk),
        .CE(1'b1),
        .CLR(calibing_flag_r_i_2_n_0),
        .D(tlast_i_1_n_0),
        .Q(axis_tlast));
  LUT6 #(
    .INIT(64'hA8A8A8FFA8A8A8A8)) 
    tvalid_i_1
       (.I0(axis_tready),
        .I1(\FSM_onehot_state_reg_n_0_[3] ),
        .I2(data_timestamp_start),
        .I3(\FSM_onehot_state_reg_n_0_[4] ),
        .I4(\FSM_onehot_state_reg_n_0_[1] ),
        .I5(axis_tvalid),
        .O(tvalid_i_1_n_0));
  FDCE tvalid_reg
       (.C(clk),
        .CE(1'b1),
        .CLR(calibing_flag_r_i_2_n_0),
        .D(tvalid_i_1_n_0),
        .Q(axis_tvalid));
  (* SOFT_HLUTNM = "soft_lutpair10" *) 
  LUT1 #(
    .INIT(2'h1)) 
    \tx_num_meas[0]_i_1 
       (.I0(tx_num_meas_reg__0[0]),
        .O(plusOp[0]));
  (* SOFT_HLUTNM = "soft_lutpair10" *) 
  LUT2 #(
    .INIT(4'h6)) 
    \tx_num_meas[1]_i_1 
       (.I0(tx_num_meas_reg__0[0]),
        .I1(tx_num_meas_reg__0[1]),
        .O(plusOp[1]));
  (* SOFT_HLUTNM = "soft_lutpair7" *) 
  LUT3 #(
    .INIT(8'h78)) 
    \tx_num_meas[2]_i_1 
       (.I0(tx_num_meas_reg__0[0]),
        .I1(tx_num_meas_reg__0[1]),
        .I2(tx_num_meas_reg__0[2]),
        .O(plusOp[2]));
  (* SOFT_HLUTNM = "soft_lutpair2" *) 
  LUT4 #(
    .INIT(16'h7F80)) 
    \tx_num_meas[3]_i_1 
       (.I0(tx_num_meas_reg__0[1]),
        .I1(tx_num_meas_reg__0[0]),
        .I2(tx_num_meas_reg__0[2]),
        .I3(tx_num_meas_reg__0[3]),
        .O(plusOp[3]));
  (* SOFT_HLUTNM = "soft_lutpair2" *) 
  LUT5 #(
    .INIT(32'h7FFF8000)) 
    \tx_num_meas[4]_i_1 
       (.I0(tx_num_meas_reg__0[3]),
        .I1(tx_num_meas_reg__0[2]),
        .I2(tx_num_meas_reg__0[0]),
        .I3(tx_num_meas_reg__0[1]),
        .I4(tx_num_meas_reg__0[4]),
        .O(plusOp[4]));
  LUT6 #(
    .INIT(64'h7FFFFFFF80000000)) 
    \tx_num_meas[5]_i_1 
       (.I0(tx_num_meas_reg__0[1]),
        .I1(tx_num_meas_reg__0[0]),
        .I2(tx_num_meas_reg__0[2]),
        .I3(tx_num_meas_reg__0[3]),
        .I4(tx_num_meas_reg__0[4]),
        .I5(tx_num_meas_reg__0[5]),
        .O(plusOp[5]));
  LUT6 #(
    .INIT(64'hFFFF7FFF00008000)) 
    \tx_num_meas[6]_i_1 
       (.I0(tx_num_meas_reg__0[5]),
        .I1(tx_num_meas_reg__0[4]),
        .I2(tx_num_meas_reg__0[3]),
        .I3(tx_num_meas_reg__0[2]),
        .I4(\tx_num_meas[6]_i_2_n_0 ),
        .I5(tx_num_meas_reg__0[6]),
        .O(plusOp[6]));
  (* SOFT_HLUTNM = "soft_lutpair7" *) 
  LUT2 #(
    .INIT(4'h7)) 
    \tx_num_meas[6]_i_2 
       (.I0(tx_num_meas_reg__0[1]),
        .I1(tx_num_meas_reg__0[0]),
        .O(\tx_num_meas[6]_i_2_n_0 ));
  LUT3 #(
    .INIT(8'hB4)) 
    \tx_num_meas[7]_i_1 
       (.I0(\tx_num_meas[9]_i_2_n_0 ),
        .I1(tx_num_meas_reg__0[6]),
        .I2(tx_num_meas_reg__0[7]),
        .O(plusOp[7]));
  (* SOFT_HLUTNM = "soft_lutpair1" *) 
  LUT4 #(
    .INIT(16'hF708)) 
    \tx_num_meas[8]_i_1 
       (.I0(tx_num_meas_reg__0[7]),
        .I1(tx_num_meas_reg__0[6]),
        .I2(\tx_num_meas[9]_i_2_n_0 ),
        .I3(tx_num_meas_reg__0[8]),
        .O(plusOp[8]));
  (* SOFT_HLUTNM = "soft_lutpair1" *) 
  LUT5 #(
    .INIT(32'hDFFF2000)) 
    \tx_num_meas[9]_i_1 
       (.I0(tx_num_meas_reg__0[8]),
        .I1(\tx_num_meas[9]_i_2_n_0 ),
        .I2(tx_num_meas_reg__0[6]),
        .I3(tx_num_meas_reg__0[7]),
        .I4(tx_num_meas_reg__0[9]),
        .O(plusOp[9]));
  LUT6 #(
    .INIT(64'h7FFFFFFFFFFFFFFF)) 
    \tx_num_meas[9]_i_2 
       (.I0(tx_num_meas_reg__0[1]),
        .I1(tx_num_meas_reg__0[0]),
        .I2(tx_num_meas_reg__0[2]),
        .I3(tx_num_meas_reg__0[3]),
        .I4(tx_num_meas_reg__0[4]),
        .I5(tx_num_meas_reg__0[5]),
        .O(\tx_num_meas[9]_i_2_n_0 ));
  FDRE #(
    .INIT(1'b0)) 
    \tx_num_meas_reg[0] 
       (.C(clk),
        .CE(axis_tvalid),
        .D(plusOp[0]),
        .Q(tx_num_meas_reg__0[0]),
        .R(axis_tlast));
  FDRE #(
    .INIT(1'b0)) 
    \tx_num_meas_reg[1] 
       (.C(clk),
        .CE(axis_tvalid),
        .D(plusOp[1]),
        .Q(tx_num_meas_reg__0[1]),
        .R(axis_tlast));
  FDRE #(
    .INIT(1'b0)) 
    \tx_num_meas_reg[2] 
       (.C(clk),
        .CE(axis_tvalid),
        .D(plusOp[2]),
        .Q(tx_num_meas_reg__0[2]),
        .R(axis_tlast));
  FDRE #(
    .INIT(1'b0)) 
    \tx_num_meas_reg[3] 
       (.C(clk),
        .CE(axis_tvalid),
        .D(plusOp[3]),
        .Q(tx_num_meas_reg__0[3]),
        .R(axis_tlast));
  FDRE #(
    .INIT(1'b0)) 
    \tx_num_meas_reg[4] 
       (.C(clk),
        .CE(axis_tvalid),
        .D(plusOp[4]),
        .Q(tx_num_meas_reg__0[4]),
        .R(axis_tlast));
  FDRE #(
    .INIT(1'b0)) 
    \tx_num_meas_reg[5] 
       (.C(clk),
        .CE(axis_tvalid),
        .D(plusOp[5]),
        .Q(tx_num_meas_reg__0[5]),
        .R(axis_tlast));
  FDRE #(
    .INIT(1'b0)) 
    \tx_num_meas_reg[6] 
       (.C(clk),
        .CE(axis_tvalid),
        .D(plusOp[6]),
        .Q(tx_num_meas_reg__0[6]),
        .R(axis_tlast));
  FDRE #(
    .INIT(1'b0)) 
    \tx_num_meas_reg[7] 
       (.C(clk),
        .CE(axis_tvalid),
        .D(plusOp[7]),
        .Q(tx_num_meas_reg__0[7]),
        .R(axis_tlast));
  FDRE #(
    .INIT(1'b0)) 
    \tx_num_meas_reg[8] 
       (.C(clk),
        .CE(axis_tvalid),
        .D(plusOp[8]),
        .Q(tx_num_meas_reg__0[8]),
        .R(axis_tlast));
  FDRE #(
    .INIT(1'b0)) 
    \tx_num_meas_reg[9] 
       (.C(clk),
        .CE(axis_tvalid),
        .D(plusOp[9]),
        .Q(tx_num_meas_reg__0[9]),
        .R(axis_tlast));
endmodule
`ifndef GLBL
`define GLBL
`timescale  1 ps / 1 ps

module glbl ();

    parameter ROC_WIDTH = 100000;
    parameter TOC_WIDTH = 0;

//--------   STARTUP Globals --------------
    wire GSR;
    wire GTS;
    wire GWE;
    wire PRLD;
    tri1 p_up_tmp;
    tri (weak1, strong0) PLL_LOCKG = p_up_tmp;

    wire PROGB_GLBL;
    wire CCLKO_GLBL;
    wire FCSBO_GLBL;
    wire [3:0] DO_GLBL;
    wire [3:0] DI_GLBL;
   
    reg GSR_int;
    reg GTS_int;
    reg PRLD_int;

//--------   JTAG Globals --------------
    wire JTAG_TDO_GLBL;
    wire JTAG_TCK_GLBL;
    wire JTAG_TDI_GLBL;
    wire JTAG_TMS_GLBL;
    wire JTAG_TRST_GLBL;

    reg JTAG_CAPTURE_GLBL;
    reg JTAG_RESET_GLBL;
    reg JTAG_SHIFT_GLBL;
    reg JTAG_UPDATE_GLBL;
    reg JTAG_RUNTEST_GLBL;

    reg JTAG_SEL1_GLBL = 0;
    reg JTAG_SEL2_GLBL = 0 ;
    reg JTAG_SEL3_GLBL = 0;
    reg JTAG_SEL4_GLBL = 0;

    reg JTAG_USER_TDO1_GLBL = 1'bz;
    reg JTAG_USER_TDO2_GLBL = 1'bz;
    reg JTAG_USER_TDO3_GLBL = 1'bz;
    reg JTAG_USER_TDO4_GLBL = 1'bz;

    assign (strong1, weak0) GSR = GSR_int;
    assign (strong1, weak0) GTS = GTS_int;
    assign (weak1, weak0) PRLD = PRLD_int;

    initial begin
	GSR_int = 1'b1;
	PRLD_int = 1'b1;
	#(ROC_WIDTH)
	GSR_int = 1'b0;
	PRLD_int = 1'b0;
    end

    initial begin
	GTS_int = 1'b1;
	#(TOC_WIDTH)
	GTS_int = 1'b0;
    end

endmodule
`endif
