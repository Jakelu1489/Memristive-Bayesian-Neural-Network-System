module ps_ddr_write(
              input wire rstn,
              input wire clk,  
              // Master Write Address
              output [0:0]  M_AXI_AWID,
              output [31:0] M_AXI_AWADDR,
              output [7:0]  M_AXI_AWLEN,    // Burst Length: 0-255
              output [2:0]  M_AXI_AWSIZE,   // Burst Size: Fixed 2'b011
              output [1:0]  M_AXI_AWBURST,  // Burst Type: Fixed 2'b01(Incremental Burst)
              output        M_AXI_AWLOCK,   // Lock: Fixed 2'b00
              output [3:0]  M_AXI_AWCACHE,  // Cache: Fiex 2'b0011
              output [2:0]  M_AXI_AWPROT,   // Protect: Fixed 2'b000
              output [3:0]  M_AXI_AWQOS,    // QoS: Fixed 2'b0000
              output [0:0]  M_AXI_AWUSER,   // User: Fixed 32'd0
              output        M_AXI_AWVALID,
              input         M_AXI_AWREADY,
            
              // Master Write Data
              output [63:0] M_AXI_WDATA,
              output [7:0]  M_AXI_WSTRB,
              output        M_AXI_WLAST,
              output [0:0]  M_AXI_WUSER,
              output        M_AXI_WVALID,
              input         M_AXI_WREADY,
            
              // Master Write Response
              input [0:0]   M_AXI_BID,
              input [1:0]   M_AXI_BRESP,
              input [0:0]   M_AXI_BUSER,
              input         M_AXI_BVALID,
              output        M_AXI_BREADY,
              output triger_start
    );

wire wr_burst_finish;
wire wr_burst_req;
wire[7:0] wr_burst_len;
wire[31:0] wr_burst_addr;
wire[63 : 0] wr_burst_data;
wire wr_ready;
wire [2:0]write_state;
wire [7:0]len_left;
wire write_en;

assign triger_start=wr_burst_req;

aq_axi_master u_aq_axi_master
    (
      .ARESETN(rstn),
      .ACLK(clk),
      .M_AXI_AWID(M_AXI_AWID),
      .M_AXI_AWADDR(M_AXI_AWADDR), 
      .M_AXI_AWLEN(M_AXI_AWLEN),
      .M_AXI_AWSIZE(M_AXI_AWSIZE),
      .M_AXI_AWBURST(M_AXI_AWBURST),
      .M_AXI_AWLOCK(M_AXI_AWLOCK),
      .M_AXI_AWCACHE(M_AXI_AWCACHE),
      .M_AXI_AWPROT(M_AXI_AWPROT),
      .M_AXI_AWQOS(M_AXI_AWQOS),
      .M_AXI_AWUSER(M_AXI_AWUSER),
      .M_AXI_AWVALID(M_AXI_AWVALID),
      .M_AXI_AWREADY(M_AXI_AWREADY),
      
      .M_AXI_WDATA(M_AXI_WDATA),
      .M_AXI_WSTRB(M_AXI_WSTRB),
      .M_AXI_WLAST(M_AXI_WLAST),
      .M_AXI_WUSER(M_AXI_WUSER),
      .M_AXI_WVALID(M_AXI_WVALID),
      .M_AXI_WREADY(M_AXI_WREADY),
      
      .M_AXI_BID(M_AXI_BID),
      .M_AXI_BRESP(M_AXI_BRESP),
      .M_AXI_BUSER(M_AXI_BUSER),
      .M_AXI_BVALID(M_AXI_BVALID),
      .M_AXI_BREADY(M_AXI_BREADY),

      .MASTER_RST(1'b0),
      
      .WR_START(wr_burst_req),
      .WR_ADRS(wr_burst_addr),
      .WR_LEN(wr_burst_len), 
      .WR_READY(wr_ready),
      .WR_FIFO_RE(write_en),
      .WR_FIFO_EMPTY(1'b0),
      .WR_FIFO_AEMPTY(1'b0),
      .WR_FIFO_DATA(wr_burst_data),
	  .WR_DONE(wr_burst_finish)                       
    );


reg [31:0]triger_write_cnt_reg;
reg triger_write_req_reg;
reg [31:0]addr_write_reg;
reg [63:0]write_data_reg;
reg [7:0]write_len_reg;


assign wr_burst_len=write_len_reg;
assign wr_burst_req=triger_write_req_reg;
assign wr_burst_addr=addr_write_reg;
assign wr_burst_data=write_data_reg;

parameter WRITE_ADDR_OFFSET=128*1024*1024;
parameter ADDR_MAX=WRITE_ADDR_OFFSET+256;

parameter WRITE_COUNTER_MAX=1024-1;
parameter TRIGER_OFFSET=WRITE_COUNTER_MAX/2;
parameter WRITE_LEN='d16;

//实现1024个时钟周期触发一次传输。计数0的时候触发
always@(posedge clk or negedge rstn)
begin
    if(rstn==1'b0)begin
        triger_write_cnt_reg<='b0;
    end
    else begin
        if(triger_write_cnt_reg<WRITE_COUNTER_MAX)triger_write_cnt_reg<=triger_write_cnt_reg+'d1;
        else triger_write_cnt_reg<='b0;
    end
end



//以下代码简单的实现写地址递增，收到读取数据使能1的时候数据自加
 reg [28:0]addr_offset_reg;
always@(posedge clk or negedge rstn)
begin
    if(rstn==1'b0)begin
        triger_write_req_reg<=1'b0;
        addr_write_reg<=WRITE_ADDR_OFFSET+'b0;
        write_data_reg<='b0;
        addr_offset_reg<='b0;
    end
    else begin
        if(triger_write_cnt_reg=='b0)begin
             triger_write_req_reg<=1'b0;
             addr_write_reg<=WRITE_ADDR_OFFSET+addr_offset_reg;
             write_len_reg<=WRITE_LEN;
             if(addr_offset_reg<ADDR_MAX)addr_offset_reg<=addr_offset_reg+'d128;
             else addr_offset_reg=WRITE_ADDR_OFFSET;
        end
        else if(triger_write_cnt_reg==TRIGER_OFFSET)begin
            triger_write_req_reg<='b1;
        end
        else if(triger_write_cnt_reg>TRIGER_OFFSET+WRITE_LEN+1'b1)triger_write_req_reg<='b0;
        if(write_en==1'b1)   write_data_reg<=write_data_reg+'d1;
        else if(addr_offset_reg==ADDR_MAX)write_data_reg<=0;
    end
end

 

endmodule
