module test_axis_fifo(
clk,
rst_n,

//s_data,
//s_datavalid,
//s_datalast,
// master_axi
axis_tready,
axis_tdata,
axis_tkeep,
axis_tlast,
axis_tvalid
);
input clk;
input rst_n;
input axis_tready;
output[63:0] axis_tdata;
output[7:0]  axis_tkeep;
output axis_tlast;
output axis_tvalid;

reg [63:0] axis_tdata;
reg [7:0] axis_tkeep;
reg axis_tlast;

reg [63:0] cnt;

assign axis_tvalid = 1'b1;
assign axis_tdata = cnt;

always @(posedge clk or negedge rst_n)
begin 
   if(!rst_n)
       cnt <=0;
   else if(axis_tready & axis_tvalid)
       cnt <= cnt + 1;
end 

reg flag;
always@(posedge clk or negedge rst_n)
begin
    if(!rst)
    begin
        axis_tkeep <= 8'b0000_0000;
        axis_tlast<=0;
        flag <= 1;   
    end
    else
    begin
       if(axis_tready==1)
             begin
                axis_tkeep <= 8'b1111_1111;
                if(cnt[9]==flag) // send to memory 1024 bytes
                begin 
                    flag = ~flag; 
                    axis_tlast <= 1;
                end 
                else 
                    axis_tlast <= 0;
            end
        else 
        begin
            axis_tkeep <= 4'b0000_0000;
            axis_tlast<=0;
        end
    end
end

endmodule




//module test_axis_fifo (
//    clk,
//    rst_n,
//    // axi stream fifo interface 
//    axis_tready,
//    axis_tvalid,
//    axis_tdata

//);//123
//input clk;
//input rst_n;
//input axis_tready;
//output axis_tvalid;
//output [63:0] axis_tdata;

//reg [63:0] cnt;
//reg axis_tvalid_r;

//always @(posedge clk or negedge rst_n)
//begin 
//    if(!rst_n)
//        cnt <=0;
//    else if(axis_tready & axis_tvalid)
//        cnt <= cnt + 1;
//end 

//always @(posedge clk or negedge rst_n)
//begin 
//    if(!rst_n)
//        axis_tvalid_r <=0;
//    else 
//        axis_tvalid_r <= 1;
//end 
//assign axis_tdata = cnt;
//assign axis_tvalid = axis_tvalid_r;

//endmodule