`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/05/31 21:57:23
// Design Name: 
// Module Name: test_tdc_control
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


module test_tdc_control;

reg clk,clk_50;
real  CYCLE_350MHz = 2.857;
real  CYCLE_50MHz  = 20;
real  CYCLE_3502626 =28.55;

reg rst_n;
wire start_sig_vaild,stop_sig_vaild;

reg ready;
always
begin
    clk_50 = 0 ; #(CYCLE_50MHz/2) ;
    clk_50 = 1 ; #(CYCLE_50MHz/2) ;
end 

always
begin
    clk = 0 ; #(CYCLE_350MHz/2) ;
    clk = 1 ; #(CYCLE_350MHz/2) ;
end 


// 模拟信号

reg start_sig,stop_sig;
always @(posedge clk_50 or negedge rst_n)
begin
    if(!rst_n)
        start_sig<= 0;
    else
       start_sig <= ~start_sig;
end 

always @(posedge clk_50 or negedge rst_n)
begin
    if(!rst_n)
        stop_sig<= 0;
    else
       stop_sig <= start_sig;
end 

reg stop;
reg start_vaild_1,stop_sig_vaild_1;
always @(posedge clk or negedge rst_n)
begin
    if(!rst_n)
        start_vaild_1 <= 0;
    else
       start_vaild_1 <= start_sig;
       
end
always @(posedge clk or negedge rst_n)
begin
    if(!rst_n)
        stop_sig_vaild_1 <= 0;
    else 
       stop_sig_vaild_1 <= stop_sig;      
end
assign  start_sig_vaild= start_sig & ~start_vaild_1 &~stop;
assign stop_sig_vaild= start_sig_vaild;//stop_sig &   ~stop_sig_vaild_1 &~stop;

 

// always @(posedge clk_50 or negedge rst_n)
// begin 
//     stop_sig_vaild =0;
//  wait(start_sig_vaild);
//   #3 stop_sig_vaild =1;
//   #10 stop_sig_vaild =0;
//  wait(start_sig_vaild==0);
// end 


// wire [31:0] start_timestamp;
// reg start;
// wire start_channel_vaild;
// reg  enable;
// wire valid;

wire calibing_flag, calib_finished,hit_source,axis_tlast,axis_tvalid;
wire [7 : 0] axis_tkeep;
wire [63 : 0] axis_tdata;
reg run;
tdc_control #(
    .Calib_SIZE(10),
    .Brust_SIZE(128),
    .TimeOut_SIZE(2)
  ) inst (
    .clk(clk),
    .rst_n(rst_n),
    .ValidOutStart(start_sig_vaild),
    .ValidOutStop(stop_sig_vaild),
    .timestampStart(32'h1234),
    .timestampStop(32'h5678),
    .DLenable(1),
    .run(run),
    .calib_en(1),
    .calibing_flag(calibing_flag),
    .calib_finished(calib_finished),
    .hit_source(hit_source),
    .axis_tready(ready),
    .axis_tdata(axis_tdata),
    .axis_tkeep(axis_tkeep),
    .axis_tlast(axis_tlast),
    .axis_tvalid(axis_tvalid)
  );




  initial begin
        ready =1;
        run =0;
        stop=0;
      #1250  ready =0;
      @(posedge clk_50) ready =0;
      @(posedge clk_50);
      @(posedge clk_50) ready =1;
    #61200 //run =0;
        stop=1;
       #1  ready =1;
        // #31 start      = 1'b1 ;
        // #30 start      = 1'b0 ;
        // #31 start      = 1'b1 ;
        // #30 start      = 1'b0 ;
    end



// TDCchannel #(.NTaps(192))
// // start_channel ( 
//       .clk(clk),  
//       .hit(start),
//       .DLenable(enable),
//       .ValidOut(start_channel_vaild),
//       .timestamp (start_timestamp));
//  delayLine  #(.NTaps(192))
//    Port23 ( 
//       .clk(clk),  
//       .hit(start),
//       .enable(enable),
//       .thermo(start_channel_vaild),
//       .valid (valid));

  initial begin
        rst_n =1;
      #1  rst_n =0;
       #1  rst_n =1;
        // #31 start      = 1'b1 ;
        // #30 start      = 1'b0 ;
        // #31 start      = 1'b1 ;
        // #30 start      = 1'b0 ;
    end



endmodule
