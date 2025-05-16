// Copyright 1986-2018 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2018.3 (win64) Build 2405991 Thu Dec  6 23:38:27 MST 2018
// Date        : Thu Jul 11 20:13:50 2024
// Host        : DESKTOP-L5QOME4 running 64-bit major release  (build 9200)
// Command     : write_verilog -force -mode funcsim -rename_top decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix -prefix
//               decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_ zynq_blk_hit_src_chg_0_0_sim_netlist.v
// Design      : zynq_blk_hit_src_chg_0_0
// Purpose     : This verilog netlist is a functional simulation representation of the design and should not be modified
//               or synthesized. This netlist cannot be used for SDF annotated simulation.
// Device      : xc7z020clg484-2
// --------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

module decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_hit_src_chg
   (hitO,
    clk_i_p,
    clk_i_n,
    clk_calib,
    channel);
  output hitO;
  input clk_i_p;
  input clk_i_n;
  input clk_calib;
  input channel;

  wire channel;
  wire clk_calib;
  wire clk_i;
  wire clk_i_n;
  wire clk_i_p;
  wire hitO;

  (* BOX_TYPE = "PRIMITIVE" *) 
  (* CAPACITANCE = "DONT_CARE" *) 
  (* IBUF_DELAY_VALUE = "0" *) 
  (* IFD_DELAY_VALUE = "AUTO" *) 
  IBUFDS #(
    .IOSTANDARD("DEFAULT")) 
    HIT_CLK_U
       (.I(clk_i_p),
        .IB(clk_i_n),
        .O(clk_i));
  LUT3 #(
    .INIT(8'hB8)) 
    hitO_INST_0
       (.I0(clk_calib),
        .I1(channel),
        .I2(clk_i),
        .O(hitO));
endmodule

(* CHECK_LICENSE_TYPE = "zynq_blk_hit_src_chg_0_0,hit_src_chg,{}" *) (* DowngradeIPIdentifiedWarnings = "yes" *) (* IP_DEFINITION_SOURCE = "module_ref" *) 
(* X_CORE_INFO = "hit_src_chg,Vivado 2018.3" *) 
(* NotValidForBitStream *)
module decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix
   (hit,
    clk_i_p,
    clk_i_n,
    clk_calib,
    channel,
    hitO);
  input hit;
  input clk_i_p;
  input clk_i_n;
  input clk_calib;
  input channel;
  output hitO;

  wire channel;
  wire clk_calib;
  (* DIFF_TERM = 0 *) (* IBUF_LOW_PWR *) wire clk_i_n;
  (* DIFF_TERM = 0 *) (* IBUF_LOW_PWR *) wire clk_i_p;
  wire hitO;

  decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_hit_src_chg inst
       (.channel(channel),
        .clk_calib(clk_calib),
        .clk_i_n(clk_i_n),
        .clk_i_p(clk_i_p),
        .hitO(hitO));
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
