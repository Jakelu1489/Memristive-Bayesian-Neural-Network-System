`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/05/26 17:06:54
// Design Name: 
// Module Name: test_fifo_sim
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


module test_fifo_sim;
    wire [63:0] tdata;
   reg clk;
   reg rst_n;
   reg ready;
   wire vaild;
    real         CYCLE_200MHz = 5; 
    always begin
        clk = 0 ; #(CYCLE_200MHz/2) ;
        clk = 1 ; #(CYCLE_200MHz/2) ;
    end 
     //reset generating
    initial begin
        rst_n      = 1'b0 ;
        ready = 1'b0 ;
        #5 rst_n      = 1'b1 ;
        #50 ready = 1;
        #6000 ready = 0;
    end
   
    test_axis_fifo U1 (
    .clk(clk),
    .rst_n(rst_n),
    // axi stream fifo interface 
    .axis_tready(ready),
    .axis_tvalid(vaild),
    .axis_tdata(tdata)
);//123
    
    
    
endmodule
