// Copyright 1986-2018 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2018.3 (win64) Build 2405991 Thu Dec  6 23:38:27 MST 2018
// Date        : Sat Jun  1 23:15:21 2024
// Host        : DESKTOP-QJLKIHB running 64-bit major release  (build 9200)
// Command     : write_verilog -force -mode funcsim -rename_top decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix -prefix
//               decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_ zynq_blk_tdc_ctl_fromps_0_1_sim_netlist.v
// Design      : zynq_blk_tdc_ctl_fromps_0_1
// Purpose     : This verilog netlist is a functional simulation representation of the design and should not be modified
//               or synthesized. This netlist cannot be used for SDF annotated simulation.
// Device      : xc7z020clg484-2
// --------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

module decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_tdc_ctl_fromps_v1_0
   (out,
    S_AXI_WREADY,
    S_AXI_AWREADY,
    S_AXI_ARREADY,
    s00_axi_rdata,
    s00_axi_bvalid,
    s00_axi_rvalid,
    tdc_calib_finish,
    tdc_calibing,
    s00_axi_aclk,
    s00_axi_awaddr,
    s00_axi_wvalid,
    s00_axi_awvalid,
    s00_axi_araddr,
    s00_axi_arvalid,
    clk_sys,
    s00_axi_wdata,
    s00_axi_wstrb,
    s00_axi_aresetn,
    s00_axi_bready,
    s00_axi_rready);
  output [1:0]out;
  output S_AXI_WREADY;
  output S_AXI_AWREADY;
  output S_AXI_ARREADY;
  output [31:0]s00_axi_rdata;
  output s00_axi_bvalid;
  output s00_axi_rvalid;
  input tdc_calib_finish;
  input tdc_calibing;
  input s00_axi_aclk;
  input [1:0]s00_axi_awaddr;
  input s00_axi_wvalid;
  input s00_axi_awvalid;
  input [1:0]s00_axi_araddr;
  input s00_axi_arvalid;
  input clk_sys;
  input [31:0]s00_axi_wdata;
  input [3:0]s00_axi_wstrb;
  input s00_axi_aresetn;
  input s00_axi_bready;
  input s00_axi_rready;

  wire S_AXI_ARREADY;
  wire S_AXI_AWREADY;
  wire S_AXI_WREADY;
  wire clk_sys;
  wire [1:0]out;
  wire s00_axi_aclk;
  wire [1:0]s00_axi_araddr;
  wire s00_axi_aresetn;
  wire s00_axi_arvalid;
  wire [1:0]s00_axi_awaddr;
  wire s00_axi_awvalid;
  wire s00_axi_bready;
  wire s00_axi_bvalid;
  wire [31:0]s00_axi_rdata;
  wire s00_axi_rready;
  wire s00_axi_rvalid;
  wire [31:0]s00_axi_wdata;
  wire [3:0]s00_axi_wstrb;
  wire s00_axi_wvalid;
  wire tdc_calib_finish;
  wire tdc_calibing;

  decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_tdc_ctl_fromps_v1_0_S00_AXI tdc_ctl_fromps_v1_0_S00_AXI_inst
       (.clk_sys(clk_sys),
        .out(out),
        .s00_axi_aclk(s00_axi_aclk),
        .s00_axi_araddr(s00_axi_araddr),
        .s00_axi_aresetn(s00_axi_aresetn),
        .s00_axi_arready(S_AXI_ARREADY),
        .s00_axi_arvalid(s00_axi_arvalid),
        .s00_axi_awaddr(s00_axi_awaddr),
        .s00_axi_awready(S_AXI_AWREADY),
        .s00_axi_awvalid(s00_axi_awvalid),
        .s00_axi_bready(s00_axi_bready),
        .s00_axi_bvalid(s00_axi_bvalid),
        .s00_axi_rdata(s00_axi_rdata),
        .s00_axi_rready(s00_axi_rready),
        .s00_axi_rvalid(s00_axi_rvalid),
        .s00_axi_wdata(s00_axi_wdata),
        .s00_axi_wready(S_AXI_WREADY),
        .s00_axi_wstrb(s00_axi_wstrb),
        .s00_axi_wvalid(s00_axi_wvalid),
        .tdc_calib_finish(tdc_calib_finish),
        .tdc_calibing(tdc_calibing));
endmodule

module decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_tdc_ctl_fromps_v1_0_S00_AXI
   (out,
    s00_axi_wready,
    s00_axi_awready,
    s00_axi_arready,
    s00_axi_rdata,
    s00_axi_bvalid,
    s00_axi_rvalid,
    tdc_calib_finish,
    tdc_calibing,
    s00_axi_aclk,
    s00_axi_awaddr,
    s00_axi_wvalid,
    s00_axi_awvalid,
    s00_axi_araddr,
    s00_axi_arvalid,
    clk_sys,
    s00_axi_wdata,
    s00_axi_wstrb,
    s00_axi_aresetn,
    s00_axi_bready,
    s00_axi_rready);
  output [1:0]out;
  output s00_axi_wready;
  output s00_axi_awready;
  output s00_axi_arready;
  output [31:0]s00_axi_rdata;
  output s00_axi_bvalid;
  output s00_axi_rvalid;
  input tdc_calib_finish;
  input tdc_calibing;
  input s00_axi_aclk;
  input [1:0]s00_axi_awaddr;
  input s00_axi_wvalid;
  input s00_axi_awvalid;
  input [1:0]s00_axi_araddr;
  input s00_axi_arvalid;
  input clk_sys;
  input [31:0]s00_axi_wdata;
  input [3:0]s00_axi_wstrb;
  input s00_axi_aresetn;
  input s00_axi_bready;
  input s00_axi_rready;

  wire aw_en_i_1_n_0;
  wire aw_en_reg_n_0;
  wire [3:2]axi_araddr;
  wire \axi_araddr[2]_i_1_n_0 ;
  wire \axi_araddr[3]_i_1_n_0 ;
  wire axi_arready0;
  wire [3:2]axi_awaddr;
  wire \axi_awaddr[2]_i_1_n_0 ;
  wire \axi_awaddr[3]_i_1_n_0 ;
  wire axi_awready0__0;
  wire axi_bvalid_i_1_n_0;
  wire \axi_rdata[0]_i_1_n_0 ;
  wire \axi_rdata[10]_i_1_n_0 ;
  wire \axi_rdata[11]_i_1_n_0 ;
  wire \axi_rdata[12]_i_1_n_0 ;
  wire \axi_rdata[13]_i_1_n_0 ;
  wire \axi_rdata[14]_i_1_n_0 ;
  wire \axi_rdata[15]_i_1_n_0 ;
  wire \axi_rdata[16]_i_1_n_0 ;
  wire \axi_rdata[17]_i_1_n_0 ;
  wire \axi_rdata[18]_i_1_n_0 ;
  wire \axi_rdata[19]_i_1_n_0 ;
  wire \axi_rdata[1]_i_1_n_0 ;
  wire \axi_rdata[20]_i_1_n_0 ;
  wire \axi_rdata[21]_i_1_n_0 ;
  wire \axi_rdata[22]_i_1_n_0 ;
  wire \axi_rdata[23]_i_1_n_0 ;
  wire \axi_rdata[24]_i_1_n_0 ;
  wire \axi_rdata[25]_i_1_n_0 ;
  wire \axi_rdata[26]_i_1_n_0 ;
  wire \axi_rdata[27]_i_1_n_0 ;
  wire \axi_rdata[28]_i_1_n_0 ;
  wire \axi_rdata[29]_i_1_n_0 ;
  wire \axi_rdata[2]_i_1_n_0 ;
  wire \axi_rdata[30]_i_1_n_0 ;
  wire \axi_rdata[31]_i_1_n_0 ;
  wire \axi_rdata[3]_i_1_n_0 ;
  wire \axi_rdata[4]_i_1_n_0 ;
  wire \axi_rdata[5]_i_1_n_0 ;
  wire \axi_rdata[6]_i_1_n_0 ;
  wire \axi_rdata[7]_i_1_n_0 ;
  wire \axi_rdata[8]_i_1_n_0 ;
  wire \axi_rdata[9]_i_1_n_0 ;
  wire axi_rvalid_i_1_n_0;
  wire axi_wready0__0;
  wire clk_sys;
  (* async_reg = "true" *) wire [31:0]out_sync_reg0;
  (* async_reg = "true" *) wire [31:0]out_sync_reg01;
  wire p_0_in;
  wire [31:0]p_1_in;
  wire s00_axi_aclk;
  wire [1:0]s00_axi_araddr;
  wire s00_axi_aresetn;
  wire s00_axi_arready;
  wire s00_axi_arvalid;
  wire [1:0]s00_axi_awaddr;
  wire s00_axi_awready;
  wire s00_axi_awvalid;
  wire s00_axi_bready;
  wire s00_axi_bvalid;
  wire [31:0]s00_axi_rdata;
  wire s00_axi_rready;
  wire s00_axi_rvalid;
  wire [31:0]s00_axi_wdata;
  wire s00_axi_wready;
  wire [3:0]s00_axi_wstrb;
  wire s00_axi_wvalid;
  wire [31:0]slv_reg0;
  wire slv_reg_rden__0;
  wire slv_reg_wren;
  wire tdc_calib_finish;
  (* async_reg = "true" *) wire tdc_calib_finish_r;
  (* async_reg = "true" *) wire tdc_calib_finish_r1;
  wire tdc_calibing;
  (* async_reg = "true" *) wire tdc_calibing_r;
  (* async_reg = "true" *) wire tdc_calibing_r1;

  assign out[1:0] = out_sync_reg01[1:0];
  LUT6 #(
    .INIT(64'hF7FFC4CCC4CCC4CC)) 
    aw_en_i_1
       (.I0(s00_axi_awvalid),
        .I1(aw_en_reg_n_0),
        .I2(s00_axi_awready),
        .I3(s00_axi_wvalid),
        .I4(s00_axi_bready),
        .I5(s00_axi_bvalid),
        .O(aw_en_i_1_n_0));
  FDSE aw_en_reg
       (.C(s00_axi_aclk),
        .CE(1'b1),
        .D(aw_en_i_1_n_0),
        .Q(aw_en_reg_n_0),
        .S(p_0_in));
  (* SOFT_HLUTNM = "soft_lutpair0" *) 
  LUT4 #(
    .INIT(16'hFB08)) 
    \axi_araddr[2]_i_1 
       (.I0(s00_axi_araddr[0]),
        .I1(s00_axi_arvalid),
        .I2(s00_axi_arready),
        .I3(axi_araddr[2]),
        .O(\axi_araddr[2]_i_1_n_0 ));
  LUT4 #(
    .INIT(16'hFB08)) 
    \axi_araddr[3]_i_1 
       (.I0(s00_axi_araddr[1]),
        .I1(s00_axi_arvalid),
        .I2(s00_axi_arready),
        .I3(axi_araddr[3]),
        .O(\axi_araddr[3]_i_1_n_0 ));
  FDRE \axi_araddr_reg[2] 
       (.C(s00_axi_aclk),
        .CE(1'b1),
        .D(\axi_araddr[2]_i_1_n_0 ),
        .Q(axi_araddr[2]),
        .R(p_0_in));
  FDRE \axi_araddr_reg[3] 
       (.C(s00_axi_aclk),
        .CE(1'b1),
        .D(\axi_araddr[3]_i_1_n_0 ),
        .Q(axi_araddr[3]),
        .R(p_0_in));
  (* SOFT_HLUTNM = "soft_lutpair0" *) 
  LUT2 #(
    .INIT(4'h2)) 
    axi_arready_i_1
       (.I0(s00_axi_arvalid),
        .I1(s00_axi_arready),
        .O(axi_arready0));
  FDRE axi_arready_reg
       (.C(s00_axi_aclk),
        .CE(1'b1),
        .D(axi_arready0),
        .Q(s00_axi_arready),
        .R(p_0_in));
  LUT6 #(
    .INIT(64'hFBFFFFFF08000000)) 
    \axi_awaddr[2]_i_1 
       (.I0(s00_axi_awaddr[0]),
        .I1(s00_axi_wvalid),
        .I2(s00_axi_awready),
        .I3(aw_en_reg_n_0),
        .I4(s00_axi_awvalid),
        .I5(axi_awaddr[2]),
        .O(\axi_awaddr[2]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'hFBFFFFFF08000000)) 
    \axi_awaddr[3]_i_1 
       (.I0(s00_axi_awaddr[1]),
        .I1(s00_axi_wvalid),
        .I2(s00_axi_awready),
        .I3(aw_en_reg_n_0),
        .I4(s00_axi_awvalid),
        .I5(axi_awaddr[3]),
        .O(\axi_awaddr[3]_i_1_n_0 ));
  FDRE \axi_awaddr_reg[2] 
       (.C(s00_axi_aclk),
        .CE(1'b1),
        .D(\axi_awaddr[2]_i_1_n_0 ),
        .Q(axi_awaddr[2]),
        .R(p_0_in));
  FDRE \axi_awaddr_reg[3] 
       (.C(s00_axi_aclk),
        .CE(1'b1),
        .D(\axi_awaddr[3]_i_1_n_0 ),
        .Q(axi_awaddr[3]),
        .R(p_0_in));
  (* SOFT_HLUTNM = "soft_lutpair1" *) 
  LUT4 #(
    .INIT(16'h2000)) 
    axi_awready0
       (.I0(s00_axi_wvalid),
        .I1(s00_axi_awready),
        .I2(aw_en_reg_n_0),
        .I3(s00_axi_awvalid),
        .O(axi_awready0__0));
  LUT1 #(
    .INIT(2'h1)) 
    axi_awready_i_1
       (.I0(s00_axi_aresetn),
        .O(p_0_in));
  FDRE axi_awready_reg
       (.C(s00_axi_aclk),
        .CE(1'b1),
        .D(axi_awready0__0),
        .Q(s00_axi_awready),
        .R(p_0_in));
  LUT6 #(
    .INIT(64'h0000FFFF80008000)) 
    axi_bvalid_i_1
       (.I0(s00_axi_awvalid),
        .I1(s00_axi_wvalid),
        .I2(s00_axi_awready),
        .I3(s00_axi_wready),
        .I4(s00_axi_bready),
        .I5(s00_axi_bvalid),
        .O(axi_bvalid_i_1_n_0));
  FDRE axi_bvalid_reg
       (.C(s00_axi_aclk),
        .CE(1'b1),
        .D(axi_bvalid_i_1_n_0),
        .Q(s00_axi_bvalid),
        .R(p_0_in));
  LUT4 #(
    .INIT(16'h00E2)) 
    \axi_rdata[0]_i_1 
       (.I0(slv_reg0[0]),
        .I1(axi_araddr[2]),
        .I2(tdc_calib_finish_r1),
        .I3(axi_araddr[3]),
        .O(\axi_rdata[0]_i_1_n_0 ));
  LUT3 #(
    .INIT(8'h04)) 
    \axi_rdata[10]_i_1 
       (.I0(axi_araddr[2]),
        .I1(slv_reg0[10]),
        .I2(axi_araddr[3]),
        .O(\axi_rdata[10]_i_1_n_0 ));
  LUT3 #(
    .INIT(8'h04)) 
    \axi_rdata[11]_i_1 
       (.I0(axi_araddr[2]),
        .I1(slv_reg0[11]),
        .I2(axi_araddr[3]),
        .O(\axi_rdata[11]_i_1_n_0 ));
  LUT3 #(
    .INIT(8'h04)) 
    \axi_rdata[12]_i_1 
       (.I0(axi_araddr[2]),
        .I1(slv_reg0[12]),
        .I2(axi_araddr[3]),
        .O(\axi_rdata[12]_i_1_n_0 ));
  LUT3 #(
    .INIT(8'h04)) 
    \axi_rdata[13]_i_1 
       (.I0(axi_araddr[2]),
        .I1(slv_reg0[13]),
        .I2(axi_araddr[3]),
        .O(\axi_rdata[13]_i_1_n_0 ));
  LUT3 #(
    .INIT(8'h04)) 
    \axi_rdata[14]_i_1 
       (.I0(axi_araddr[2]),
        .I1(slv_reg0[14]),
        .I2(axi_araddr[3]),
        .O(\axi_rdata[14]_i_1_n_0 ));
  LUT3 #(
    .INIT(8'h04)) 
    \axi_rdata[15]_i_1 
       (.I0(axi_araddr[2]),
        .I1(slv_reg0[15]),
        .I2(axi_araddr[3]),
        .O(\axi_rdata[15]_i_1_n_0 ));
  LUT3 #(
    .INIT(8'h04)) 
    \axi_rdata[16]_i_1 
       (.I0(axi_araddr[2]),
        .I1(slv_reg0[16]),
        .I2(axi_araddr[3]),
        .O(\axi_rdata[16]_i_1_n_0 ));
  LUT3 #(
    .INIT(8'h04)) 
    \axi_rdata[17]_i_1 
       (.I0(axi_araddr[2]),
        .I1(slv_reg0[17]),
        .I2(axi_araddr[3]),
        .O(\axi_rdata[17]_i_1_n_0 ));
  LUT3 #(
    .INIT(8'h04)) 
    \axi_rdata[18]_i_1 
       (.I0(axi_araddr[2]),
        .I1(slv_reg0[18]),
        .I2(axi_araddr[3]),
        .O(\axi_rdata[18]_i_1_n_0 ));
  LUT3 #(
    .INIT(8'h04)) 
    \axi_rdata[19]_i_1 
       (.I0(axi_araddr[2]),
        .I1(slv_reg0[19]),
        .I2(axi_araddr[3]),
        .O(\axi_rdata[19]_i_1_n_0 ));
  LUT4 #(
    .INIT(16'h00E2)) 
    \axi_rdata[1]_i_1 
       (.I0(slv_reg0[1]),
        .I1(axi_araddr[2]),
        .I2(tdc_calibing_r1),
        .I3(axi_araddr[3]),
        .O(\axi_rdata[1]_i_1_n_0 ));
  LUT3 #(
    .INIT(8'h04)) 
    \axi_rdata[20]_i_1 
       (.I0(axi_araddr[2]),
        .I1(slv_reg0[20]),
        .I2(axi_araddr[3]),
        .O(\axi_rdata[20]_i_1_n_0 ));
  LUT3 #(
    .INIT(8'h04)) 
    \axi_rdata[21]_i_1 
       (.I0(axi_araddr[2]),
        .I1(slv_reg0[21]),
        .I2(axi_araddr[3]),
        .O(\axi_rdata[21]_i_1_n_0 ));
  LUT3 #(
    .INIT(8'h04)) 
    \axi_rdata[22]_i_1 
       (.I0(axi_araddr[2]),
        .I1(slv_reg0[22]),
        .I2(axi_araddr[3]),
        .O(\axi_rdata[22]_i_1_n_0 ));
  LUT3 #(
    .INIT(8'h04)) 
    \axi_rdata[23]_i_1 
       (.I0(axi_araddr[2]),
        .I1(slv_reg0[23]),
        .I2(axi_araddr[3]),
        .O(\axi_rdata[23]_i_1_n_0 ));
  LUT3 #(
    .INIT(8'h04)) 
    \axi_rdata[24]_i_1 
       (.I0(axi_araddr[2]),
        .I1(slv_reg0[24]),
        .I2(axi_araddr[3]),
        .O(\axi_rdata[24]_i_1_n_0 ));
  LUT3 #(
    .INIT(8'h04)) 
    \axi_rdata[25]_i_1 
       (.I0(axi_araddr[2]),
        .I1(slv_reg0[25]),
        .I2(axi_araddr[3]),
        .O(\axi_rdata[25]_i_1_n_0 ));
  LUT3 #(
    .INIT(8'h04)) 
    \axi_rdata[26]_i_1 
       (.I0(axi_araddr[2]),
        .I1(slv_reg0[26]),
        .I2(axi_araddr[3]),
        .O(\axi_rdata[26]_i_1_n_0 ));
  LUT3 #(
    .INIT(8'h04)) 
    \axi_rdata[27]_i_1 
       (.I0(axi_araddr[2]),
        .I1(slv_reg0[27]),
        .I2(axi_araddr[3]),
        .O(\axi_rdata[27]_i_1_n_0 ));
  LUT3 #(
    .INIT(8'h04)) 
    \axi_rdata[28]_i_1 
       (.I0(axi_araddr[2]),
        .I1(slv_reg0[28]),
        .I2(axi_araddr[3]),
        .O(\axi_rdata[28]_i_1_n_0 ));
  LUT3 #(
    .INIT(8'h04)) 
    \axi_rdata[29]_i_1 
       (.I0(axi_araddr[2]),
        .I1(slv_reg0[29]),
        .I2(axi_araddr[3]),
        .O(\axi_rdata[29]_i_1_n_0 ));
  LUT3 #(
    .INIT(8'h04)) 
    \axi_rdata[2]_i_1 
       (.I0(axi_araddr[2]),
        .I1(slv_reg0[2]),
        .I2(axi_araddr[3]),
        .O(\axi_rdata[2]_i_1_n_0 ));
  LUT3 #(
    .INIT(8'h04)) 
    \axi_rdata[30]_i_1 
       (.I0(axi_araddr[2]),
        .I1(slv_reg0[30]),
        .I2(axi_araddr[3]),
        .O(\axi_rdata[30]_i_1_n_0 ));
  LUT3 #(
    .INIT(8'h04)) 
    \axi_rdata[31]_i_1 
       (.I0(axi_araddr[2]),
        .I1(slv_reg0[31]),
        .I2(axi_araddr[3]),
        .O(\axi_rdata[31]_i_1_n_0 ));
  LUT3 #(
    .INIT(8'h04)) 
    \axi_rdata[3]_i_1 
       (.I0(axi_araddr[2]),
        .I1(slv_reg0[3]),
        .I2(axi_araddr[3]),
        .O(\axi_rdata[3]_i_1_n_0 ));
  LUT3 #(
    .INIT(8'h04)) 
    \axi_rdata[4]_i_1 
       (.I0(axi_araddr[2]),
        .I1(slv_reg0[4]),
        .I2(axi_araddr[3]),
        .O(\axi_rdata[4]_i_1_n_0 ));
  LUT3 #(
    .INIT(8'h04)) 
    \axi_rdata[5]_i_1 
       (.I0(axi_araddr[2]),
        .I1(slv_reg0[5]),
        .I2(axi_araddr[3]),
        .O(\axi_rdata[5]_i_1_n_0 ));
  LUT3 #(
    .INIT(8'h04)) 
    \axi_rdata[6]_i_1 
       (.I0(axi_araddr[2]),
        .I1(slv_reg0[6]),
        .I2(axi_araddr[3]),
        .O(\axi_rdata[6]_i_1_n_0 ));
  LUT3 #(
    .INIT(8'h04)) 
    \axi_rdata[7]_i_1 
       (.I0(axi_araddr[2]),
        .I1(slv_reg0[7]),
        .I2(axi_araddr[3]),
        .O(\axi_rdata[7]_i_1_n_0 ));
  LUT3 #(
    .INIT(8'h04)) 
    \axi_rdata[8]_i_1 
       (.I0(axi_araddr[2]),
        .I1(slv_reg0[8]),
        .I2(axi_araddr[3]),
        .O(\axi_rdata[8]_i_1_n_0 ));
  LUT3 #(
    .INIT(8'h04)) 
    \axi_rdata[9]_i_1 
       (.I0(axi_araddr[2]),
        .I1(slv_reg0[9]),
        .I2(axi_araddr[3]),
        .O(\axi_rdata[9]_i_1_n_0 ));
  FDRE \axi_rdata_reg[0] 
       (.C(s00_axi_aclk),
        .CE(slv_reg_rden__0),
        .D(\axi_rdata[0]_i_1_n_0 ),
        .Q(s00_axi_rdata[0]),
        .R(p_0_in));
  FDRE \axi_rdata_reg[10] 
       (.C(s00_axi_aclk),
        .CE(slv_reg_rden__0),
        .D(\axi_rdata[10]_i_1_n_0 ),
        .Q(s00_axi_rdata[10]),
        .R(p_0_in));
  FDRE \axi_rdata_reg[11] 
       (.C(s00_axi_aclk),
        .CE(slv_reg_rden__0),
        .D(\axi_rdata[11]_i_1_n_0 ),
        .Q(s00_axi_rdata[11]),
        .R(p_0_in));
  FDRE \axi_rdata_reg[12] 
       (.C(s00_axi_aclk),
        .CE(slv_reg_rden__0),
        .D(\axi_rdata[12]_i_1_n_0 ),
        .Q(s00_axi_rdata[12]),
        .R(p_0_in));
  FDRE \axi_rdata_reg[13] 
       (.C(s00_axi_aclk),
        .CE(slv_reg_rden__0),
        .D(\axi_rdata[13]_i_1_n_0 ),
        .Q(s00_axi_rdata[13]),
        .R(p_0_in));
  FDRE \axi_rdata_reg[14] 
       (.C(s00_axi_aclk),
        .CE(slv_reg_rden__0),
        .D(\axi_rdata[14]_i_1_n_0 ),
        .Q(s00_axi_rdata[14]),
        .R(p_0_in));
  FDRE \axi_rdata_reg[15] 
       (.C(s00_axi_aclk),
        .CE(slv_reg_rden__0),
        .D(\axi_rdata[15]_i_1_n_0 ),
        .Q(s00_axi_rdata[15]),
        .R(p_0_in));
  FDRE \axi_rdata_reg[16] 
       (.C(s00_axi_aclk),
        .CE(slv_reg_rden__0),
        .D(\axi_rdata[16]_i_1_n_0 ),
        .Q(s00_axi_rdata[16]),
        .R(p_0_in));
  FDRE \axi_rdata_reg[17] 
       (.C(s00_axi_aclk),
        .CE(slv_reg_rden__0),
        .D(\axi_rdata[17]_i_1_n_0 ),
        .Q(s00_axi_rdata[17]),
        .R(p_0_in));
  FDRE \axi_rdata_reg[18] 
       (.C(s00_axi_aclk),
        .CE(slv_reg_rden__0),
        .D(\axi_rdata[18]_i_1_n_0 ),
        .Q(s00_axi_rdata[18]),
        .R(p_0_in));
  FDRE \axi_rdata_reg[19] 
       (.C(s00_axi_aclk),
        .CE(slv_reg_rden__0),
        .D(\axi_rdata[19]_i_1_n_0 ),
        .Q(s00_axi_rdata[19]),
        .R(p_0_in));
  FDRE \axi_rdata_reg[1] 
       (.C(s00_axi_aclk),
        .CE(slv_reg_rden__0),
        .D(\axi_rdata[1]_i_1_n_0 ),
        .Q(s00_axi_rdata[1]),
        .R(p_0_in));
  FDRE \axi_rdata_reg[20] 
       (.C(s00_axi_aclk),
        .CE(slv_reg_rden__0),
        .D(\axi_rdata[20]_i_1_n_0 ),
        .Q(s00_axi_rdata[20]),
        .R(p_0_in));
  FDRE \axi_rdata_reg[21] 
       (.C(s00_axi_aclk),
        .CE(slv_reg_rden__0),
        .D(\axi_rdata[21]_i_1_n_0 ),
        .Q(s00_axi_rdata[21]),
        .R(p_0_in));
  FDRE \axi_rdata_reg[22] 
       (.C(s00_axi_aclk),
        .CE(slv_reg_rden__0),
        .D(\axi_rdata[22]_i_1_n_0 ),
        .Q(s00_axi_rdata[22]),
        .R(p_0_in));
  FDRE \axi_rdata_reg[23] 
       (.C(s00_axi_aclk),
        .CE(slv_reg_rden__0),
        .D(\axi_rdata[23]_i_1_n_0 ),
        .Q(s00_axi_rdata[23]),
        .R(p_0_in));
  FDRE \axi_rdata_reg[24] 
       (.C(s00_axi_aclk),
        .CE(slv_reg_rden__0),
        .D(\axi_rdata[24]_i_1_n_0 ),
        .Q(s00_axi_rdata[24]),
        .R(p_0_in));
  FDRE \axi_rdata_reg[25] 
       (.C(s00_axi_aclk),
        .CE(slv_reg_rden__0),
        .D(\axi_rdata[25]_i_1_n_0 ),
        .Q(s00_axi_rdata[25]),
        .R(p_0_in));
  FDRE \axi_rdata_reg[26] 
       (.C(s00_axi_aclk),
        .CE(slv_reg_rden__0),
        .D(\axi_rdata[26]_i_1_n_0 ),
        .Q(s00_axi_rdata[26]),
        .R(p_0_in));
  FDRE \axi_rdata_reg[27] 
       (.C(s00_axi_aclk),
        .CE(slv_reg_rden__0),
        .D(\axi_rdata[27]_i_1_n_0 ),
        .Q(s00_axi_rdata[27]),
        .R(p_0_in));
  FDRE \axi_rdata_reg[28] 
       (.C(s00_axi_aclk),
        .CE(slv_reg_rden__0),
        .D(\axi_rdata[28]_i_1_n_0 ),
        .Q(s00_axi_rdata[28]),
        .R(p_0_in));
  FDRE \axi_rdata_reg[29] 
       (.C(s00_axi_aclk),
        .CE(slv_reg_rden__0),
        .D(\axi_rdata[29]_i_1_n_0 ),
        .Q(s00_axi_rdata[29]),
        .R(p_0_in));
  FDRE \axi_rdata_reg[2] 
       (.C(s00_axi_aclk),
        .CE(slv_reg_rden__0),
        .D(\axi_rdata[2]_i_1_n_0 ),
        .Q(s00_axi_rdata[2]),
        .R(p_0_in));
  FDRE \axi_rdata_reg[30] 
       (.C(s00_axi_aclk),
        .CE(slv_reg_rden__0),
        .D(\axi_rdata[30]_i_1_n_0 ),
        .Q(s00_axi_rdata[30]),
        .R(p_0_in));
  FDRE \axi_rdata_reg[31] 
       (.C(s00_axi_aclk),
        .CE(slv_reg_rden__0),
        .D(\axi_rdata[31]_i_1_n_0 ),
        .Q(s00_axi_rdata[31]),
        .R(p_0_in));
  FDRE \axi_rdata_reg[3] 
       (.C(s00_axi_aclk),
        .CE(slv_reg_rden__0),
        .D(\axi_rdata[3]_i_1_n_0 ),
        .Q(s00_axi_rdata[3]),
        .R(p_0_in));
  FDRE \axi_rdata_reg[4] 
       (.C(s00_axi_aclk),
        .CE(slv_reg_rden__0),
        .D(\axi_rdata[4]_i_1_n_0 ),
        .Q(s00_axi_rdata[4]),
        .R(p_0_in));
  FDRE \axi_rdata_reg[5] 
       (.C(s00_axi_aclk),
        .CE(slv_reg_rden__0),
        .D(\axi_rdata[5]_i_1_n_0 ),
        .Q(s00_axi_rdata[5]),
        .R(p_0_in));
  FDRE \axi_rdata_reg[6] 
       (.C(s00_axi_aclk),
        .CE(slv_reg_rden__0),
        .D(\axi_rdata[6]_i_1_n_0 ),
        .Q(s00_axi_rdata[6]),
        .R(p_0_in));
  FDRE \axi_rdata_reg[7] 
       (.C(s00_axi_aclk),
        .CE(slv_reg_rden__0),
        .D(\axi_rdata[7]_i_1_n_0 ),
        .Q(s00_axi_rdata[7]),
        .R(p_0_in));
  FDRE \axi_rdata_reg[8] 
       (.C(s00_axi_aclk),
        .CE(slv_reg_rden__0),
        .D(\axi_rdata[8]_i_1_n_0 ),
        .Q(s00_axi_rdata[8]),
        .R(p_0_in));
  FDRE \axi_rdata_reg[9] 
       (.C(s00_axi_aclk),
        .CE(slv_reg_rden__0),
        .D(\axi_rdata[9]_i_1_n_0 ),
        .Q(s00_axi_rdata[9]),
        .R(p_0_in));
  LUT4 #(
    .INIT(16'h08F8)) 
    axi_rvalid_i_1
       (.I0(s00_axi_arready),
        .I1(s00_axi_arvalid),
        .I2(s00_axi_rvalid),
        .I3(s00_axi_rready),
        .O(axi_rvalid_i_1_n_0));
  FDRE axi_rvalid_reg
       (.C(s00_axi_aclk),
        .CE(1'b1),
        .D(axi_rvalid_i_1_n_0),
        .Q(s00_axi_rvalid),
        .R(p_0_in));
  (* SOFT_HLUTNM = "soft_lutpair1" *) 
  LUT4 #(
    .INIT(16'h0800)) 
    axi_wready0
       (.I0(s00_axi_awvalid),
        .I1(s00_axi_wvalid),
        .I2(s00_axi_wready),
        .I3(aw_en_reg_n_0),
        .O(axi_wready0__0));
  FDRE axi_wready_reg
       (.C(s00_axi_aclk),
        .CE(1'b1),
        .D(axi_wready0__0),
        .Q(s00_axi_wready),
        .R(p_0_in));
  (* ASYNC_REG *) 
  (* KEEP = "yes" *) 
  FDRE \out_sync_reg01_reg[0] 
       (.C(clk_sys),
        .CE(1'b1),
        .D(out_sync_reg0[0]),
        .Q(out_sync_reg01[0]),
        .R(1'b0));
  (* ASYNC_REG *) 
  (* KEEP = "yes" *) 
  FDRE \out_sync_reg01_reg[10] 
       (.C(clk_sys),
        .CE(1'b1),
        .D(out_sync_reg0[10]),
        .Q(out_sync_reg01[10]),
        .R(1'b0));
  (* ASYNC_REG *) 
  (* KEEP = "yes" *) 
  FDRE \out_sync_reg01_reg[11] 
       (.C(clk_sys),
        .CE(1'b1),
        .D(out_sync_reg0[11]),
        .Q(out_sync_reg01[11]),
        .R(1'b0));
  (* ASYNC_REG *) 
  (* KEEP = "yes" *) 
  FDRE \out_sync_reg01_reg[12] 
       (.C(clk_sys),
        .CE(1'b1),
        .D(out_sync_reg0[12]),
        .Q(out_sync_reg01[12]),
        .R(1'b0));
  (* ASYNC_REG *) 
  (* KEEP = "yes" *) 
  FDRE \out_sync_reg01_reg[13] 
       (.C(clk_sys),
        .CE(1'b1),
        .D(out_sync_reg0[13]),
        .Q(out_sync_reg01[13]),
        .R(1'b0));
  (* ASYNC_REG *) 
  (* KEEP = "yes" *) 
  FDRE \out_sync_reg01_reg[14] 
       (.C(clk_sys),
        .CE(1'b1),
        .D(out_sync_reg0[14]),
        .Q(out_sync_reg01[14]),
        .R(1'b0));
  (* ASYNC_REG *) 
  (* KEEP = "yes" *) 
  FDRE \out_sync_reg01_reg[15] 
       (.C(clk_sys),
        .CE(1'b1),
        .D(out_sync_reg0[15]),
        .Q(out_sync_reg01[15]),
        .R(1'b0));
  (* ASYNC_REG *) 
  (* KEEP = "yes" *) 
  FDRE \out_sync_reg01_reg[16] 
       (.C(clk_sys),
        .CE(1'b1),
        .D(out_sync_reg0[16]),
        .Q(out_sync_reg01[16]),
        .R(1'b0));
  (* ASYNC_REG *) 
  (* KEEP = "yes" *) 
  FDRE \out_sync_reg01_reg[17] 
       (.C(clk_sys),
        .CE(1'b1),
        .D(out_sync_reg0[17]),
        .Q(out_sync_reg01[17]),
        .R(1'b0));
  (* ASYNC_REG *) 
  (* KEEP = "yes" *) 
  FDRE \out_sync_reg01_reg[18] 
       (.C(clk_sys),
        .CE(1'b1),
        .D(out_sync_reg0[18]),
        .Q(out_sync_reg01[18]),
        .R(1'b0));
  (* ASYNC_REG *) 
  (* KEEP = "yes" *) 
  FDRE \out_sync_reg01_reg[19] 
       (.C(clk_sys),
        .CE(1'b1),
        .D(out_sync_reg0[19]),
        .Q(out_sync_reg01[19]),
        .R(1'b0));
  (* ASYNC_REG *) 
  (* KEEP = "yes" *) 
  FDRE \out_sync_reg01_reg[1] 
       (.C(clk_sys),
        .CE(1'b1),
        .D(out_sync_reg0[1]),
        .Q(out_sync_reg01[1]),
        .R(1'b0));
  (* ASYNC_REG *) 
  (* KEEP = "yes" *) 
  FDRE \out_sync_reg01_reg[20] 
       (.C(clk_sys),
        .CE(1'b1),
        .D(out_sync_reg0[20]),
        .Q(out_sync_reg01[20]),
        .R(1'b0));
  (* ASYNC_REG *) 
  (* KEEP = "yes" *) 
  FDRE \out_sync_reg01_reg[21] 
       (.C(clk_sys),
        .CE(1'b1),
        .D(out_sync_reg0[21]),
        .Q(out_sync_reg01[21]),
        .R(1'b0));
  (* ASYNC_REG *) 
  (* KEEP = "yes" *) 
  FDRE \out_sync_reg01_reg[22] 
       (.C(clk_sys),
        .CE(1'b1),
        .D(out_sync_reg0[22]),
        .Q(out_sync_reg01[22]),
        .R(1'b0));
  (* ASYNC_REG *) 
  (* KEEP = "yes" *) 
  FDRE \out_sync_reg01_reg[23] 
       (.C(clk_sys),
        .CE(1'b1),
        .D(out_sync_reg0[23]),
        .Q(out_sync_reg01[23]),
        .R(1'b0));
  (* ASYNC_REG *) 
  (* KEEP = "yes" *) 
  FDRE \out_sync_reg01_reg[24] 
       (.C(clk_sys),
        .CE(1'b1),
        .D(out_sync_reg0[24]),
        .Q(out_sync_reg01[24]),
        .R(1'b0));
  (* ASYNC_REG *) 
  (* KEEP = "yes" *) 
  FDRE \out_sync_reg01_reg[25] 
       (.C(clk_sys),
        .CE(1'b1),
        .D(out_sync_reg0[25]),
        .Q(out_sync_reg01[25]),
        .R(1'b0));
  (* ASYNC_REG *) 
  (* KEEP = "yes" *) 
  FDRE \out_sync_reg01_reg[26] 
       (.C(clk_sys),
        .CE(1'b1),
        .D(out_sync_reg0[26]),
        .Q(out_sync_reg01[26]),
        .R(1'b0));
  (* ASYNC_REG *) 
  (* KEEP = "yes" *) 
  FDRE \out_sync_reg01_reg[27] 
       (.C(clk_sys),
        .CE(1'b1),
        .D(out_sync_reg0[27]),
        .Q(out_sync_reg01[27]),
        .R(1'b0));
  (* ASYNC_REG *) 
  (* KEEP = "yes" *) 
  FDRE \out_sync_reg01_reg[28] 
       (.C(clk_sys),
        .CE(1'b1),
        .D(out_sync_reg0[28]),
        .Q(out_sync_reg01[28]),
        .R(1'b0));
  (* ASYNC_REG *) 
  (* KEEP = "yes" *) 
  FDRE \out_sync_reg01_reg[29] 
       (.C(clk_sys),
        .CE(1'b1),
        .D(out_sync_reg0[29]),
        .Q(out_sync_reg01[29]),
        .R(1'b0));
  (* ASYNC_REG *) 
  (* KEEP = "yes" *) 
  FDRE \out_sync_reg01_reg[2] 
       (.C(clk_sys),
        .CE(1'b1),
        .D(out_sync_reg0[2]),
        .Q(out_sync_reg01[2]),
        .R(1'b0));
  (* ASYNC_REG *) 
  (* KEEP = "yes" *) 
  FDRE \out_sync_reg01_reg[30] 
       (.C(clk_sys),
        .CE(1'b1),
        .D(out_sync_reg0[30]),
        .Q(out_sync_reg01[30]),
        .R(1'b0));
  (* ASYNC_REG *) 
  (* KEEP = "yes" *) 
  FDRE \out_sync_reg01_reg[31] 
       (.C(clk_sys),
        .CE(1'b1),
        .D(out_sync_reg0[31]),
        .Q(out_sync_reg01[31]),
        .R(1'b0));
  (* ASYNC_REG *) 
  (* KEEP = "yes" *) 
  FDRE \out_sync_reg01_reg[3] 
       (.C(clk_sys),
        .CE(1'b1),
        .D(out_sync_reg0[3]),
        .Q(out_sync_reg01[3]),
        .R(1'b0));
  (* ASYNC_REG *) 
  (* KEEP = "yes" *) 
  FDRE \out_sync_reg01_reg[4] 
       (.C(clk_sys),
        .CE(1'b1),
        .D(out_sync_reg0[4]),
        .Q(out_sync_reg01[4]),
        .R(1'b0));
  (* ASYNC_REG *) 
  (* KEEP = "yes" *) 
  FDRE \out_sync_reg01_reg[5] 
       (.C(clk_sys),
        .CE(1'b1),
        .D(out_sync_reg0[5]),
        .Q(out_sync_reg01[5]),
        .R(1'b0));
  (* ASYNC_REG *) 
  (* KEEP = "yes" *) 
  FDRE \out_sync_reg01_reg[6] 
       (.C(clk_sys),
        .CE(1'b1),
        .D(out_sync_reg0[6]),
        .Q(out_sync_reg01[6]),
        .R(1'b0));
  (* ASYNC_REG *) 
  (* KEEP = "yes" *) 
  FDRE \out_sync_reg01_reg[7] 
       (.C(clk_sys),
        .CE(1'b1),
        .D(out_sync_reg0[7]),
        .Q(out_sync_reg01[7]),
        .R(1'b0));
  (* ASYNC_REG *) 
  (* KEEP = "yes" *) 
  FDRE \out_sync_reg01_reg[8] 
       (.C(clk_sys),
        .CE(1'b1),
        .D(out_sync_reg0[8]),
        .Q(out_sync_reg01[8]),
        .R(1'b0));
  (* ASYNC_REG *) 
  (* KEEP = "yes" *) 
  FDRE \out_sync_reg01_reg[9] 
       (.C(clk_sys),
        .CE(1'b1),
        .D(out_sync_reg0[9]),
        .Q(out_sync_reg01[9]),
        .R(1'b0));
  (* ASYNC_REG *) 
  (* KEEP = "yes" *) 
  FDRE \out_sync_reg0_reg[0] 
       (.C(clk_sys),
        .CE(1'b1),
        .D(slv_reg0[0]),
        .Q(out_sync_reg0[0]),
        .R(1'b0));
  (* ASYNC_REG *) 
  (* KEEP = "yes" *) 
  FDRE \out_sync_reg0_reg[10] 
       (.C(clk_sys),
        .CE(1'b1),
        .D(slv_reg0[10]),
        .Q(out_sync_reg0[10]),
        .R(1'b0));
  (* ASYNC_REG *) 
  (* KEEP = "yes" *) 
  FDRE \out_sync_reg0_reg[11] 
       (.C(clk_sys),
        .CE(1'b1),
        .D(slv_reg0[11]),
        .Q(out_sync_reg0[11]),
        .R(1'b0));
  (* ASYNC_REG *) 
  (* KEEP = "yes" *) 
  FDRE \out_sync_reg0_reg[12] 
       (.C(clk_sys),
        .CE(1'b1),
        .D(slv_reg0[12]),
        .Q(out_sync_reg0[12]),
        .R(1'b0));
  (* ASYNC_REG *) 
  (* KEEP = "yes" *) 
  FDRE \out_sync_reg0_reg[13] 
       (.C(clk_sys),
        .CE(1'b1),
        .D(slv_reg0[13]),
        .Q(out_sync_reg0[13]),
        .R(1'b0));
  (* ASYNC_REG *) 
  (* KEEP = "yes" *) 
  FDRE \out_sync_reg0_reg[14] 
       (.C(clk_sys),
        .CE(1'b1),
        .D(slv_reg0[14]),
        .Q(out_sync_reg0[14]),
        .R(1'b0));
  (* ASYNC_REG *) 
  (* KEEP = "yes" *) 
  FDRE \out_sync_reg0_reg[15] 
       (.C(clk_sys),
        .CE(1'b1),
        .D(slv_reg0[15]),
        .Q(out_sync_reg0[15]),
        .R(1'b0));
  (* ASYNC_REG *) 
  (* KEEP = "yes" *) 
  FDRE \out_sync_reg0_reg[16] 
       (.C(clk_sys),
        .CE(1'b1),
        .D(slv_reg0[16]),
        .Q(out_sync_reg0[16]),
        .R(1'b0));
  (* ASYNC_REG *) 
  (* KEEP = "yes" *) 
  FDRE \out_sync_reg0_reg[17] 
       (.C(clk_sys),
        .CE(1'b1),
        .D(slv_reg0[17]),
        .Q(out_sync_reg0[17]),
        .R(1'b0));
  (* ASYNC_REG *) 
  (* KEEP = "yes" *) 
  FDRE \out_sync_reg0_reg[18] 
       (.C(clk_sys),
        .CE(1'b1),
        .D(slv_reg0[18]),
        .Q(out_sync_reg0[18]),
        .R(1'b0));
  (* ASYNC_REG *) 
  (* KEEP = "yes" *) 
  FDRE \out_sync_reg0_reg[19] 
       (.C(clk_sys),
        .CE(1'b1),
        .D(slv_reg0[19]),
        .Q(out_sync_reg0[19]),
        .R(1'b0));
  (* ASYNC_REG *) 
  (* KEEP = "yes" *) 
  FDRE \out_sync_reg0_reg[1] 
       (.C(clk_sys),
        .CE(1'b1),
        .D(slv_reg0[1]),
        .Q(out_sync_reg0[1]),
        .R(1'b0));
  (* ASYNC_REG *) 
  (* KEEP = "yes" *) 
  FDRE \out_sync_reg0_reg[20] 
       (.C(clk_sys),
        .CE(1'b1),
        .D(slv_reg0[20]),
        .Q(out_sync_reg0[20]),
        .R(1'b0));
  (* ASYNC_REG *) 
  (* KEEP = "yes" *) 
  FDRE \out_sync_reg0_reg[21] 
       (.C(clk_sys),
        .CE(1'b1),
        .D(slv_reg0[21]),
        .Q(out_sync_reg0[21]),
        .R(1'b0));
  (* ASYNC_REG *) 
  (* KEEP = "yes" *) 
  FDRE \out_sync_reg0_reg[22] 
       (.C(clk_sys),
        .CE(1'b1),
        .D(slv_reg0[22]),
        .Q(out_sync_reg0[22]),
        .R(1'b0));
  (* ASYNC_REG *) 
  (* KEEP = "yes" *) 
  FDRE \out_sync_reg0_reg[23] 
       (.C(clk_sys),
        .CE(1'b1),
        .D(slv_reg0[23]),
        .Q(out_sync_reg0[23]),
        .R(1'b0));
  (* ASYNC_REG *) 
  (* KEEP = "yes" *) 
  FDRE \out_sync_reg0_reg[24] 
       (.C(clk_sys),
        .CE(1'b1),
        .D(slv_reg0[24]),
        .Q(out_sync_reg0[24]),
        .R(1'b0));
  (* ASYNC_REG *) 
  (* KEEP = "yes" *) 
  FDRE \out_sync_reg0_reg[25] 
       (.C(clk_sys),
        .CE(1'b1),
        .D(slv_reg0[25]),
        .Q(out_sync_reg0[25]),
        .R(1'b0));
  (* ASYNC_REG *) 
  (* KEEP = "yes" *) 
  FDRE \out_sync_reg0_reg[26] 
       (.C(clk_sys),
        .CE(1'b1),
        .D(slv_reg0[26]),
        .Q(out_sync_reg0[26]),
        .R(1'b0));
  (* ASYNC_REG *) 
  (* KEEP = "yes" *) 
  FDRE \out_sync_reg0_reg[27] 
       (.C(clk_sys),
        .CE(1'b1),
        .D(slv_reg0[27]),
        .Q(out_sync_reg0[27]),
        .R(1'b0));
  (* ASYNC_REG *) 
  (* KEEP = "yes" *) 
  FDRE \out_sync_reg0_reg[28] 
       (.C(clk_sys),
        .CE(1'b1),
        .D(slv_reg0[28]),
        .Q(out_sync_reg0[28]),
        .R(1'b0));
  (* ASYNC_REG *) 
  (* KEEP = "yes" *) 
  FDRE \out_sync_reg0_reg[29] 
       (.C(clk_sys),
        .CE(1'b1),
        .D(slv_reg0[29]),
        .Q(out_sync_reg0[29]),
        .R(1'b0));
  (* ASYNC_REG *) 
  (* KEEP = "yes" *) 
  FDRE \out_sync_reg0_reg[2] 
       (.C(clk_sys),
        .CE(1'b1),
        .D(slv_reg0[2]),
        .Q(out_sync_reg0[2]),
        .R(1'b0));
  (* ASYNC_REG *) 
  (* KEEP = "yes" *) 
  FDRE \out_sync_reg0_reg[30] 
       (.C(clk_sys),
        .CE(1'b1),
        .D(slv_reg0[30]),
        .Q(out_sync_reg0[30]),
        .R(1'b0));
  (* ASYNC_REG *) 
  (* KEEP = "yes" *) 
  FDRE \out_sync_reg0_reg[31] 
       (.C(clk_sys),
        .CE(1'b1),
        .D(slv_reg0[31]),
        .Q(out_sync_reg0[31]),
        .R(1'b0));
  (* ASYNC_REG *) 
  (* KEEP = "yes" *) 
  FDRE \out_sync_reg0_reg[3] 
       (.C(clk_sys),
        .CE(1'b1),
        .D(slv_reg0[3]),
        .Q(out_sync_reg0[3]),
        .R(1'b0));
  (* ASYNC_REG *) 
  (* KEEP = "yes" *) 
  FDRE \out_sync_reg0_reg[4] 
       (.C(clk_sys),
        .CE(1'b1),
        .D(slv_reg0[4]),
        .Q(out_sync_reg0[4]),
        .R(1'b0));
  (* ASYNC_REG *) 
  (* KEEP = "yes" *) 
  FDRE \out_sync_reg0_reg[5] 
       (.C(clk_sys),
        .CE(1'b1),
        .D(slv_reg0[5]),
        .Q(out_sync_reg0[5]),
        .R(1'b0));
  (* ASYNC_REG *) 
  (* KEEP = "yes" *) 
  FDRE \out_sync_reg0_reg[6] 
       (.C(clk_sys),
        .CE(1'b1),
        .D(slv_reg0[6]),
        .Q(out_sync_reg0[6]),
        .R(1'b0));
  (* ASYNC_REG *) 
  (* KEEP = "yes" *) 
  FDRE \out_sync_reg0_reg[7] 
       (.C(clk_sys),
        .CE(1'b1),
        .D(slv_reg0[7]),
        .Q(out_sync_reg0[7]),
        .R(1'b0));
  (* ASYNC_REG *) 
  (* KEEP = "yes" *) 
  FDRE \out_sync_reg0_reg[8] 
       (.C(clk_sys),
        .CE(1'b1),
        .D(slv_reg0[8]),
        .Q(out_sync_reg0[8]),
        .R(1'b0));
  (* ASYNC_REG *) 
  (* KEEP = "yes" *) 
  FDRE \out_sync_reg0_reg[9] 
       (.C(clk_sys),
        .CE(1'b1),
        .D(slv_reg0[9]),
        .Q(out_sync_reg0[9]),
        .R(1'b0));
  LUT5 #(
    .INIT(32'hFFFB0008)) 
    \slv_reg0[0]_i_1 
       (.I0(s00_axi_wdata[0]),
        .I1(s00_axi_wstrb[0]),
        .I2(axi_awaddr[2]),
        .I3(axi_awaddr[3]),
        .I4(slv_reg0[0]),
        .O(p_1_in[0]));
  LUT5 #(
    .INIT(32'hFFFB0008)) 
    \slv_reg0[10]_i_1 
       (.I0(s00_axi_wdata[10]),
        .I1(s00_axi_wstrb[1]),
        .I2(axi_awaddr[2]),
        .I3(axi_awaddr[3]),
        .I4(slv_reg0[10]),
        .O(p_1_in[10]));
  LUT5 #(
    .INIT(32'hFFFB0008)) 
    \slv_reg0[11]_i_1 
       (.I0(s00_axi_wdata[11]),
        .I1(s00_axi_wstrb[1]),
        .I2(axi_awaddr[2]),
        .I3(axi_awaddr[3]),
        .I4(slv_reg0[11]),
        .O(p_1_in[11]));
  LUT5 #(
    .INIT(32'hFFFB0008)) 
    \slv_reg0[12]_i_1 
       (.I0(s00_axi_wdata[12]),
        .I1(s00_axi_wstrb[1]),
        .I2(axi_awaddr[2]),
        .I3(axi_awaddr[3]),
        .I4(slv_reg0[12]),
        .O(p_1_in[12]));
  LUT5 #(
    .INIT(32'hFFFB0008)) 
    \slv_reg0[13]_i_1 
       (.I0(s00_axi_wdata[13]),
        .I1(s00_axi_wstrb[1]),
        .I2(axi_awaddr[2]),
        .I3(axi_awaddr[3]),
        .I4(slv_reg0[13]),
        .O(p_1_in[13]));
  LUT5 #(
    .INIT(32'hFFFB0008)) 
    \slv_reg0[14]_i_1 
       (.I0(s00_axi_wdata[14]),
        .I1(s00_axi_wstrb[1]),
        .I2(axi_awaddr[2]),
        .I3(axi_awaddr[3]),
        .I4(slv_reg0[14]),
        .O(p_1_in[14]));
  LUT5 #(
    .INIT(32'hFFFB0008)) 
    \slv_reg0[15]_i_1 
       (.I0(s00_axi_wdata[15]),
        .I1(s00_axi_wstrb[1]),
        .I2(axi_awaddr[2]),
        .I3(axi_awaddr[3]),
        .I4(slv_reg0[15]),
        .O(p_1_in[15]));
  LUT5 #(
    .INIT(32'hFFFB0008)) 
    \slv_reg0[16]_i_1 
       (.I0(s00_axi_wdata[16]),
        .I1(s00_axi_wstrb[2]),
        .I2(axi_awaddr[2]),
        .I3(axi_awaddr[3]),
        .I4(slv_reg0[16]),
        .O(p_1_in[16]));
  LUT5 #(
    .INIT(32'hFFFB0008)) 
    \slv_reg0[17]_i_1 
       (.I0(s00_axi_wdata[17]),
        .I1(s00_axi_wstrb[2]),
        .I2(axi_awaddr[2]),
        .I3(axi_awaddr[3]),
        .I4(slv_reg0[17]),
        .O(p_1_in[17]));
  LUT5 #(
    .INIT(32'hFFFB0008)) 
    \slv_reg0[18]_i_1 
       (.I0(s00_axi_wdata[18]),
        .I1(s00_axi_wstrb[2]),
        .I2(axi_awaddr[2]),
        .I3(axi_awaddr[3]),
        .I4(slv_reg0[18]),
        .O(p_1_in[18]));
  LUT5 #(
    .INIT(32'hFFFB0008)) 
    \slv_reg0[19]_i_1 
       (.I0(s00_axi_wdata[19]),
        .I1(s00_axi_wstrb[2]),
        .I2(axi_awaddr[2]),
        .I3(axi_awaddr[3]),
        .I4(slv_reg0[19]),
        .O(p_1_in[19]));
  LUT5 #(
    .INIT(32'hFFFB0008)) 
    \slv_reg0[1]_i_1 
       (.I0(s00_axi_wdata[1]),
        .I1(s00_axi_wstrb[0]),
        .I2(axi_awaddr[2]),
        .I3(axi_awaddr[3]),
        .I4(slv_reg0[1]),
        .O(p_1_in[1]));
  LUT5 #(
    .INIT(32'hFFFB0008)) 
    \slv_reg0[20]_i_1 
       (.I0(s00_axi_wdata[20]),
        .I1(s00_axi_wstrb[2]),
        .I2(axi_awaddr[2]),
        .I3(axi_awaddr[3]),
        .I4(slv_reg0[20]),
        .O(p_1_in[20]));
  LUT5 #(
    .INIT(32'hFFFB0008)) 
    \slv_reg0[21]_i_1 
       (.I0(s00_axi_wdata[21]),
        .I1(s00_axi_wstrb[2]),
        .I2(axi_awaddr[2]),
        .I3(axi_awaddr[3]),
        .I4(slv_reg0[21]),
        .O(p_1_in[21]));
  LUT5 #(
    .INIT(32'hFFFB0008)) 
    \slv_reg0[22]_i_1 
       (.I0(s00_axi_wdata[22]),
        .I1(s00_axi_wstrb[2]),
        .I2(axi_awaddr[2]),
        .I3(axi_awaddr[3]),
        .I4(slv_reg0[22]),
        .O(p_1_in[22]));
  LUT5 #(
    .INIT(32'hFFFB0008)) 
    \slv_reg0[23]_i_1 
       (.I0(s00_axi_wdata[23]),
        .I1(s00_axi_wstrb[2]),
        .I2(axi_awaddr[2]),
        .I3(axi_awaddr[3]),
        .I4(slv_reg0[23]),
        .O(p_1_in[23]));
  LUT5 #(
    .INIT(32'hFFFB0008)) 
    \slv_reg0[24]_i_1 
       (.I0(s00_axi_wdata[24]),
        .I1(s00_axi_wstrb[3]),
        .I2(axi_awaddr[2]),
        .I3(axi_awaddr[3]),
        .I4(slv_reg0[24]),
        .O(p_1_in[24]));
  LUT5 #(
    .INIT(32'hFFFB0008)) 
    \slv_reg0[25]_i_1 
       (.I0(s00_axi_wdata[25]),
        .I1(s00_axi_wstrb[3]),
        .I2(axi_awaddr[2]),
        .I3(axi_awaddr[3]),
        .I4(slv_reg0[25]),
        .O(p_1_in[25]));
  LUT5 #(
    .INIT(32'hFFFB0008)) 
    \slv_reg0[26]_i_1 
       (.I0(s00_axi_wdata[26]),
        .I1(s00_axi_wstrb[3]),
        .I2(axi_awaddr[2]),
        .I3(axi_awaddr[3]),
        .I4(slv_reg0[26]),
        .O(p_1_in[26]));
  LUT5 #(
    .INIT(32'hFFFB0008)) 
    \slv_reg0[27]_i_1 
       (.I0(s00_axi_wdata[27]),
        .I1(s00_axi_wstrb[3]),
        .I2(axi_awaddr[2]),
        .I3(axi_awaddr[3]),
        .I4(slv_reg0[27]),
        .O(p_1_in[27]));
  LUT5 #(
    .INIT(32'hFFFB0008)) 
    \slv_reg0[28]_i_1 
       (.I0(s00_axi_wdata[28]),
        .I1(s00_axi_wstrb[3]),
        .I2(axi_awaddr[2]),
        .I3(axi_awaddr[3]),
        .I4(slv_reg0[28]),
        .O(p_1_in[28]));
  LUT5 #(
    .INIT(32'hFFFB0008)) 
    \slv_reg0[29]_i_1 
       (.I0(s00_axi_wdata[29]),
        .I1(s00_axi_wstrb[3]),
        .I2(axi_awaddr[2]),
        .I3(axi_awaddr[3]),
        .I4(slv_reg0[29]),
        .O(p_1_in[29]));
  LUT5 #(
    .INIT(32'hFFFB0008)) 
    \slv_reg0[2]_i_1 
       (.I0(s00_axi_wdata[2]),
        .I1(s00_axi_wstrb[0]),
        .I2(axi_awaddr[2]),
        .I3(axi_awaddr[3]),
        .I4(slv_reg0[2]),
        .O(p_1_in[2]));
  LUT5 #(
    .INIT(32'hFFFB0008)) 
    \slv_reg0[30]_i_1 
       (.I0(s00_axi_wdata[30]),
        .I1(s00_axi_wstrb[3]),
        .I2(axi_awaddr[2]),
        .I3(axi_awaddr[3]),
        .I4(slv_reg0[30]),
        .O(p_1_in[30]));
  LUT4 #(
    .INIT(16'h8000)) 
    \slv_reg0[31]_i_1 
       (.I0(s00_axi_wready),
        .I1(s00_axi_awready),
        .I2(s00_axi_awvalid),
        .I3(s00_axi_wvalid),
        .O(slv_reg_wren));
  LUT5 #(
    .INIT(32'hFFFB0008)) 
    \slv_reg0[31]_i_2 
       (.I0(s00_axi_wdata[31]),
        .I1(s00_axi_wstrb[3]),
        .I2(axi_awaddr[2]),
        .I3(axi_awaddr[3]),
        .I4(slv_reg0[31]),
        .O(p_1_in[31]));
  LUT5 #(
    .INIT(32'hFFFB0008)) 
    \slv_reg0[3]_i_1 
       (.I0(s00_axi_wdata[3]),
        .I1(s00_axi_wstrb[0]),
        .I2(axi_awaddr[2]),
        .I3(axi_awaddr[3]),
        .I4(slv_reg0[3]),
        .O(p_1_in[3]));
  LUT5 #(
    .INIT(32'hFFFB0008)) 
    \slv_reg0[4]_i_1 
       (.I0(s00_axi_wdata[4]),
        .I1(s00_axi_wstrb[0]),
        .I2(axi_awaddr[2]),
        .I3(axi_awaddr[3]),
        .I4(slv_reg0[4]),
        .O(p_1_in[4]));
  LUT5 #(
    .INIT(32'hFFFB0008)) 
    \slv_reg0[5]_i_1 
       (.I0(s00_axi_wdata[5]),
        .I1(s00_axi_wstrb[0]),
        .I2(axi_awaddr[2]),
        .I3(axi_awaddr[3]),
        .I4(slv_reg0[5]),
        .O(p_1_in[5]));
  LUT5 #(
    .INIT(32'hFFFB0008)) 
    \slv_reg0[6]_i_1 
       (.I0(s00_axi_wdata[6]),
        .I1(s00_axi_wstrb[0]),
        .I2(axi_awaddr[2]),
        .I3(axi_awaddr[3]),
        .I4(slv_reg0[6]),
        .O(p_1_in[6]));
  LUT5 #(
    .INIT(32'hFFFB0008)) 
    \slv_reg0[7]_i_1 
       (.I0(s00_axi_wdata[7]),
        .I1(s00_axi_wstrb[0]),
        .I2(axi_awaddr[2]),
        .I3(axi_awaddr[3]),
        .I4(slv_reg0[7]),
        .O(p_1_in[7]));
  LUT5 #(
    .INIT(32'hFFFB0008)) 
    \slv_reg0[8]_i_1 
       (.I0(s00_axi_wdata[8]),
        .I1(s00_axi_wstrb[1]),
        .I2(axi_awaddr[2]),
        .I3(axi_awaddr[3]),
        .I4(slv_reg0[8]),
        .O(p_1_in[8]));
  LUT5 #(
    .INIT(32'hFFFB0008)) 
    \slv_reg0[9]_i_1 
       (.I0(s00_axi_wdata[9]),
        .I1(s00_axi_wstrb[1]),
        .I2(axi_awaddr[2]),
        .I3(axi_awaddr[3]),
        .I4(slv_reg0[9]),
        .O(p_1_in[9]));
  FDRE \slv_reg0_reg[0] 
       (.C(s00_axi_aclk),
        .CE(slv_reg_wren),
        .D(p_1_in[0]),
        .Q(slv_reg0[0]),
        .R(p_0_in));
  FDRE \slv_reg0_reg[10] 
       (.C(s00_axi_aclk),
        .CE(slv_reg_wren),
        .D(p_1_in[10]),
        .Q(slv_reg0[10]),
        .R(p_0_in));
  FDRE \slv_reg0_reg[11] 
       (.C(s00_axi_aclk),
        .CE(slv_reg_wren),
        .D(p_1_in[11]),
        .Q(slv_reg0[11]),
        .R(p_0_in));
  FDRE \slv_reg0_reg[12] 
       (.C(s00_axi_aclk),
        .CE(slv_reg_wren),
        .D(p_1_in[12]),
        .Q(slv_reg0[12]),
        .R(p_0_in));
  FDRE \slv_reg0_reg[13] 
       (.C(s00_axi_aclk),
        .CE(slv_reg_wren),
        .D(p_1_in[13]),
        .Q(slv_reg0[13]),
        .R(p_0_in));
  FDRE \slv_reg0_reg[14] 
       (.C(s00_axi_aclk),
        .CE(slv_reg_wren),
        .D(p_1_in[14]),
        .Q(slv_reg0[14]),
        .R(p_0_in));
  FDRE \slv_reg0_reg[15] 
       (.C(s00_axi_aclk),
        .CE(slv_reg_wren),
        .D(p_1_in[15]),
        .Q(slv_reg0[15]),
        .R(p_0_in));
  FDRE \slv_reg0_reg[16] 
       (.C(s00_axi_aclk),
        .CE(slv_reg_wren),
        .D(p_1_in[16]),
        .Q(slv_reg0[16]),
        .R(p_0_in));
  FDRE \slv_reg0_reg[17] 
       (.C(s00_axi_aclk),
        .CE(slv_reg_wren),
        .D(p_1_in[17]),
        .Q(slv_reg0[17]),
        .R(p_0_in));
  FDRE \slv_reg0_reg[18] 
       (.C(s00_axi_aclk),
        .CE(slv_reg_wren),
        .D(p_1_in[18]),
        .Q(slv_reg0[18]),
        .R(p_0_in));
  FDRE \slv_reg0_reg[19] 
       (.C(s00_axi_aclk),
        .CE(slv_reg_wren),
        .D(p_1_in[19]),
        .Q(slv_reg0[19]),
        .R(p_0_in));
  FDRE \slv_reg0_reg[1] 
       (.C(s00_axi_aclk),
        .CE(slv_reg_wren),
        .D(p_1_in[1]),
        .Q(slv_reg0[1]),
        .R(p_0_in));
  FDRE \slv_reg0_reg[20] 
       (.C(s00_axi_aclk),
        .CE(slv_reg_wren),
        .D(p_1_in[20]),
        .Q(slv_reg0[20]),
        .R(p_0_in));
  FDRE \slv_reg0_reg[21] 
       (.C(s00_axi_aclk),
        .CE(slv_reg_wren),
        .D(p_1_in[21]),
        .Q(slv_reg0[21]),
        .R(p_0_in));
  FDRE \slv_reg0_reg[22] 
       (.C(s00_axi_aclk),
        .CE(slv_reg_wren),
        .D(p_1_in[22]),
        .Q(slv_reg0[22]),
        .R(p_0_in));
  FDRE \slv_reg0_reg[23] 
       (.C(s00_axi_aclk),
        .CE(slv_reg_wren),
        .D(p_1_in[23]),
        .Q(slv_reg0[23]),
        .R(p_0_in));
  FDRE \slv_reg0_reg[24] 
       (.C(s00_axi_aclk),
        .CE(slv_reg_wren),
        .D(p_1_in[24]),
        .Q(slv_reg0[24]),
        .R(p_0_in));
  FDRE \slv_reg0_reg[25] 
       (.C(s00_axi_aclk),
        .CE(slv_reg_wren),
        .D(p_1_in[25]),
        .Q(slv_reg0[25]),
        .R(p_0_in));
  FDRE \slv_reg0_reg[26] 
       (.C(s00_axi_aclk),
        .CE(slv_reg_wren),
        .D(p_1_in[26]),
        .Q(slv_reg0[26]),
        .R(p_0_in));
  FDRE \slv_reg0_reg[27] 
       (.C(s00_axi_aclk),
        .CE(slv_reg_wren),
        .D(p_1_in[27]),
        .Q(slv_reg0[27]),
        .R(p_0_in));
  FDRE \slv_reg0_reg[28] 
       (.C(s00_axi_aclk),
        .CE(slv_reg_wren),
        .D(p_1_in[28]),
        .Q(slv_reg0[28]),
        .R(p_0_in));
  FDRE \slv_reg0_reg[29] 
       (.C(s00_axi_aclk),
        .CE(slv_reg_wren),
        .D(p_1_in[29]),
        .Q(slv_reg0[29]),
        .R(p_0_in));
  FDRE \slv_reg0_reg[2] 
       (.C(s00_axi_aclk),
        .CE(slv_reg_wren),
        .D(p_1_in[2]),
        .Q(slv_reg0[2]),
        .R(p_0_in));
  FDRE \slv_reg0_reg[30] 
       (.C(s00_axi_aclk),
        .CE(slv_reg_wren),
        .D(p_1_in[30]),
        .Q(slv_reg0[30]),
        .R(p_0_in));
  FDRE \slv_reg0_reg[31] 
       (.C(s00_axi_aclk),
        .CE(slv_reg_wren),
        .D(p_1_in[31]),
        .Q(slv_reg0[31]),
        .R(p_0_in));
  FDRE \slv_reg0_reg[3] 
       (.C(s00_axi_aclk),
        .CE(slv_reg_wren),
        .D(p_1_in[3]),
        .Q(slv_reg0[3]),
        .R(p_0_in));
  FDRE \slv_reg0_reg[4] 
       (.C(s00_axi_aclk),
        .CE(slv_reg_wren),
        .D(p_1_in[4]),
        .Q(slv_reg0[4]),
        .R(p_0_in));
  FDRE \slv_reg0_reg[5] 
       (.C(s00_axi_aclk),
        .CE(slv_reg_wren),
        .D(p_1_in[5]),
        .Q(slv_reg0[5]),
        .R(p_0_in));
  FDRE \slv_reg0_reg[6] 
       (.C(s00_axi_aclk),
        .CE(slv_reg_wren),
        .D(p_1_in[6]),
        .Q(slv_reg0[6]),
        .R(p_0_in));
  FDRE \slv_reg0_reg[7] 
       (.C(s00_axi_aclk),
        .CE(slv_reg_wren),
        .D(p_1_in[7]),
        .Q(slv_reg0[7]),
        .R(p_0_in));
  FDRE \slv_reg0_reg[8] 
       (.C(s00_axi_aclk),
        .CE(slv_reg_wren),
        .D(p_1_in[8]),
        .Q(slv_reg0[8]),
        .R(p_0_in));
  FDRE \slv_reg0_reg[9] 
       (.C(s00_axi_aclk),
        .CE(slv_reg_wren),
        .D(p_1_in[9]),
        .Q(slv_reg0[9]),
        .R(p_0_in));
  LUT3 #(
    .INIT(8'h20)) 
    slv_reg_rden
       (.I0(s00_axi_arvalid),
        .I1(s00_axi_rvalid),
        .I2(s00_axi_arready),
        .O(slv_reg_rden__0));
  (* ASYNC_REG *) 
  (* KEEP = "yes" *) 
  FDRE tdc_calib_finish_r1_reg
       (.C(s00_axi_aclk),
        .CE(1'b1),
        .D(tdc_calib_finish_r),
        .Q(tdc_calib_finish_r1),
        .R(1'b0));
  (* ASYNC_REG *) 
  (* KEEP = "yes" *) 
  FDRE tdc_calib_finish_r_reg
       (.C(s00_axi_aclk),
        .CE(1'b1),
        .D(tdc_calib_finish),
        .Q(tdc_calib_finish_r),
        .R(1'b0));
  (* ASYNC_REG *) 
  (* KEEP = "yes" *) 
  FDRE tdc_calibing_r1_reg
       (.C(s00_axi_aclk),
        .CE(1'b1),
        .D(tdc_calibing_r),
        .Q(tdc_calibing_r1),
        .R(1'b0));
  (* ASYNC_REG *) 
  (* KEEP = "yes" *) 
  FDRE tdc_calibing_r_reg
       (.C(s00_axi_aclk),
        .CE(1'b1),
        .D(tdc_calibing),
        .Q(tdc_calibing_r),
        .R(1'b0));
endmodule

(* CHECK_LICENSE_TYPE = "zynq_blk_tdc_ctl_fromps_0_1,tdc_ctl_fromps_v1_0,{}" *) (* DowngradeIPIdentifiedWarnings = "yes" *) (* X_CORE_INFO = "tdc_ctl_fromps_v1_0,Vivado 2018.3" *) 
(* NotValidForBitStream *)
module decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix
   (clk_sys,
    s00_axi_awaddr,
    s00_axi_awprot,
    s00_axi_awvalid,
    s00_axi_awready,
    s00_axi_wdata,
    s00_axi_wstrb,
    s00_axi_wvalid,
    s00_axi_wready,
    s00_axi_bresp,
    s00_axi_bvalid,
    s00_axi_bready,
    s00_axi_araddr,
    s00_axi_arprot,
    s00_axi_arvalid,
    s00_axi_arready,
    s00_axi_rdata,
    s00_axi_rresp,
    s00_axi_rvalid,
    s00_axi_rready,
    tdc_run,
    tdc_calib_en,
    tdc_calibing,
    tdc_calib_finish,
    s00_axi_aclk,
    s00_axi_aresetn);
  input clk_sys;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 S00_AXI AWADDR" *) input [3:0]s00_axi_awaddr;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 S00_AXI AWPROT" *) input [2:0]s00_axi_awprot;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 S00_AXI AWVALID" *) input s00_axi_awvalid;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 S00_AXI AWREADY" *) output s00_axi_awready;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 S00_AXI WDATA" *) input [31:0]s00_axi_wdata;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 S00_AXI WSTRB" *) input [3:0]s00_axi_wstrb;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 S00_AXI WVALID" *) input s00_axi_wvalid;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 S00_AXI WREADY" *) output s00_axi_wready;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 S00_AXI BRESP" *) output [1:0]s00_axi_bresp;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 S00_AXI BVALID" *) output s00_axi_bvalid;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 S00_AXI BREADY" *) input s00_axi_bready;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 S00_AXI ARADDR" *) input [3:0]s00_axi_araddr;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 S00_AXI ARPROT" *) input [2:0]s00_axi_arprot;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 S00_AXI ARVALID" *) input s00_axi_arvalid;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 S00_AXI ARREADY" *) output s00_axi_arready;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 S00_AXI RDATA" *) output [31:0]s00_axi_rdata;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 S00_AXI RRESP" *) output [1:0]s00_axi_rresp;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 S00_AXI RVALID" *) output s00_axi_rvalid;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 S00_AXI RREADY" *) (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME S00_AXI, WIZ_DATA_WIDTH 32, WIZ_NUM_REG 4, SUPPORTS_NARROW_BURST 0, DATA_WIDTH 32, PROTOCOL AXI4LITE, FREQ_HZ 100000000, ID_WIDTH 0, ADDR_WIDTH 4, AWUSER_WIDTH 0, ARUSER_WIDTH 0, WUSER_WIDTH 0, RUSER_WIDTH 0, BUSER_WIDTH 0, READ_WRITE_MODE READ_WRITE, HAS_BURST 0, HAS_LOCK 0, HAS_PROT 1, HAS_CACHE 0, HAS_QOS 0, HAS_REGION 0, HAS_WSTRB 1, HAS_BRESP 1, HAS_RRESP 1, NUM_READ_OUTSTANDING 1, NUM_WRITE_OUTSTANDING 1, MAX_BURST_LENGTH 1, PHASE 0.000, CLK_DOMAIN zynq_blk_processing_system7_0_0_FCLK_CLK0, NUM_READ_THREADS 1, NUM_WRITE_THREADS 1, RUSER_BITS_PER_BYTE 0, WUSER_BITS_PER_BYTE 0, INSERT_VIP 0" *) input s00_axi_rready;
  output tdc_run;
  output tdc_calib_en;
  input tdc_calibing;
  input tdc_calib_finish;
  (* X_INTERFACE_INFO = "xilinx.com:signal:clock:1.0 S00_AXI_CLK CLK" *) (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME S00_AXI_CLK, ASSOCIATED_BUSIF S00_AXI, ASSOCIATED_RESET s00_axi_aresetn, FREQ_HZ 100000000, PHASE 0.000, CLK_DOMAIN zynq_blk_processing_system7_0_0_FCLK_CLK0, INSERT_VIP 0" *) input s00_axi_aclk;
  (* X_INTERFACE_INFO = "xilinx.com:signal:reset:1.0 S00_AXI_RST RST" *) (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME S00_AXI_RST, POLARITY ACTIVE_LOW, INSERT_VIP 0" *) input s00_axi_aresetn;

  wire \<const0> ;
  wire clk_sys;
  wire s00_axi_aclk;
  wire [3:0]s00_axi_araddr;
  wire s00_axi_aresetn;
  wire s00_axi_arready;
  wire s00_axi_arvalid;
  wire [3:0]s00_axi_awaddr;
  wire s00_axi_awready;
  wire s00_axi_awvalid;
  wire s00_axi_bready;
  wire s00_axi_bvalid;
  wire [31:0]s00_axi_rdata;
  wire s00_axi_rready;
  wire s00_axi_rvalid;
  wire [31:0]s00_axi_wdata;
  wire s00_axi_wready;
  wire [3:0]s00_axi_wstrb;
  wire s00_axi_wvalid;
  wire tdc_calib_en;
  wire tdc_calib_finish;
  wire tdc_calibing;
  wire tdc_run;

  assign s00_axi_bresp[1] = \<const0> ;
  assign s00_axi_bresp[0] = \<const0> ;
  assign s00_axi_rresp[1] = \<const0> ;
  assign s00_axi_rresp[0] = \<const0> ;
  GND GND
       (.G(\<const0> ));
  decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_tdc_ctl_fromps_v1_0 inst
       (.S_AXI_ARREADY(s00_axi_arready),
        .S_AXI_AWREADY(s00_axi_awready),
        .S_AXI_WREADY(s00_axi_wready),
        .clk_sys(clk_sys),
        .out({tdc_calib_en,tdc_run}),
        .s00_axi_aclk(s00_axi_aclk),
        .s00_axi_araddr(s00_axi_araddr[3:2]),
        .s00_axi_aresetn(s00_axi_aresetn),
        .s00_axi_arvalid(s00_axi_arvalid),
        .s00_axi_awaddr(s00_axi_awaddr[3:2]),
        .s00_axi_awvalid(s00_axi_awvalid),
        .s00_axi_bready(s00_axi_bready),
        .s00_axi_bvalid(s00_axi_bvalid),
        .s00_axi_rdata(s00_axi_rdata),
        .s00_axi_rready(s00_axi_rready),
        .s00_axi_rvalid(s00_axi_rvalid),
        .s00_axi_wdata(s00_axi_wdata),
        .s00_axi_wstrb(s00_axi_wstrb),
        .s00_axi_wvalid(s00_axi_wvalid),
        .tdc_calib_finish(tdc_calib_finish),
        .tdc_calibing(tdc_calibing));
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
