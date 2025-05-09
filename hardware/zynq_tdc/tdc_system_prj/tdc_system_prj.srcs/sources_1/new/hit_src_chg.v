`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/06/01 16:31:55
// Design Name: 
// Module Name: hit_src_chg
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module hit_src_chg(
    input   hit,
    input 	clk_i_p	,
	input 	clk_i_n	,
    input clk_calib,
    input channel,
    output hitO
    );
wire clk_i;
//IBUFGDS HIT_CLK_U(
IBUFDS HIT_CLK_U(
	.I	(	clk_i_p	),
	.IB	(	clk_i_n	),
	.O	(	clk_i	)
);

//assign hitO = (channel == 0) ? hit | clk_i : clk_calib;

assign hitO = (channel == 0) ?  clk_i : clk_calib;
endmodule
