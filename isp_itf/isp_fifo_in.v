// ==============================================================
// ISP read fifo entity
// 
// ==============================================================
module fifo_in
#(parameter
    FIFO_WDATA_WIDTH = 64,
    FIFO_RDATA_WIDTH = 16,
    FIFO_DEPTH = 4096
)
(
    clk,
    rst_n,
    wr_en,
    wr_data,
    full_n,
    rd_en,
    rd_data,
    empty_n
);
localparam 
    FIFO_DEPTH_WIDTH = $clog2(FIFO_DEPTH);

//----------------clk, rst-----------------
input    clk;
input    rst_n;
//----------------write signal-------------
input                             wr_en;
input    [FIFO_WDATA_WIDTH-1:0]   wr_data;
output                            full_n;
//----------------read signal--------------
input                             rd_en;
output   reg [FIFO_RDATA_WIDTH-1:0]   rd_data;
output                            empty_n;
//-----------------------------------------

reg    [FIFO_DEPTH_WIDTH-1:0]    wr_ptr;
reg    [FIFO_DEPTH_WIDTH-1:0]    rd_ptr;
reg    [FIFO_DEPTH_WIDTH:0]      count;
reg    [FIFO_WDATA_WIDTH-1:0]    mem[FIFO_DEPTH-1:0];
reg    [1:0]                     rd_cnt;

always @(posedge clk)begin
    if(rst_n==1'b0)begin
        rd_cnt<=2'b0;
    end
    else if(rd_en&&empty_n)begin
        rd_cnt<=rd_cnt+1'b1;
    end
end



always @(posedge clk)begin
    if(rst_n==1'b0)begin
        wr_ptr<={FIFO_DEPTH_WIDTH{1'b0}};
    end
    else if((full_n==1'b1)&&(wr_en==1'b1))begin
        wr_ptr<=wr_ptr+1'b1;
    end 
end


always@(posedge clk)begin
    if(rst_n==1'b0)begin
        rd_ptr<={FIFO_DEPTH_WIDTH{1'b0}};
    end
    else if((empty_n==1'b1)&&(rd_en==1'b1)&&(rd_cnt==2'b11))begin
        rd_ptr<=rd_ptr+1'b1;
    end
end

always@(posedge clk)begin
    if(rst_n==1'b0)begin
        count<=0;
    end
    else if((rd_en==1'b0)&&(wr_en==1'b1)&&(full_n==1'b1))begin
        count<=count+1'b1;
    end
    else if((wr_en==1'b0)&&(rd_en==1'b1)&&(empty_n==1'b1))begin
        count<=count-1'b1;
    end
end

always@(posedge clk)begin
    if(rst_n==1'b0)begin
        mem[0]<={FIFO_WDATA_WIDTH{1'b0}};
    end
    else if((wr_en==1'b1)&&(full_n==1'b1))begin
        mem[wr_ptr]<=wr_data;
    end
end

always@(*)begin
    case(rd_cnt)
    2'b00:rd_data<=mem[wr_ptr][15:0];
    2'b01:rd_data<=mem[wr_ptr][31:16];
    2'b10:rd_data<=mem[wr_ptr][47:32];
    2'b11:rd_data<=mem[wr_ptr][63:48];
    endcase

end


assign full_n=(count[FIFO_DEPTH_WIDTH]==1'b1)?1'b0:1'b1;
assign empty_n=(count=={(FIFO_DEPTH_WIDTH+1){1'b0}})?1'b0:1'b1;

endmodule



