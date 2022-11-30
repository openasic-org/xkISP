
`timescale 1 ns / 1 ps

	module isp_maxi_full #
	(
		parameter  C_M_TARGET_SLAVE_BASE_ADDR	= 32'h40000000,
		parameter integer C_M_AXI_BURST_LEN	= 256,
		parameter integer C_M_AXI_ID_WIDTH	= 1,
		parameter integer C_M_AXI_ADDR_WIDTH	= 32,
		parameter integer C_M_AXI_DATA_WIDTH	= 64,
		parameter integer C_M_AXI_AWUSER_WIDTH	= 0,
		parameter integer C_M_AXI_ARUSER_WIDTH	= 0,
		parameter integer C_M_AXI_WUSER_WIDTH	= 0,
		parameter integer C_M_AXI_RUSER_WIDTH	= 0,
		parameter integer C_M_AXI_BUSER_WIDTH	= 0
	)
	(
		input wire                             M_AXI_ACLK,
		input wire                             M_AXI_ARESETN,
		output wire [C_M_AXI_ID_WIDTH-1 : 0]   M_AXI_AWID,
		output wire [C_M_AXI_ADDR_WIDTH-1 : 0] M_AXI_AWADDR,
		output wire [7 : 0]                    M_AXI_AWLEN,
		output wire [2 : 0]                    M_AXI_AWSIZE,
		output wire [1 : 0]                    M_AXI_AWBURST,
		output wire                            M_AXI_AWLOCK,
		output wire [3 : 0]                    M_AXI_AWCACHE,
                output wire [2 : 0]                    M_AXI_AWPROT,
		output wire                            M_AXI_AWVALID,
		input wire                             M_AXI_AWREADY,
		output wire [C_M_AXI_DATA_WIDTH-1 : 0] M_AXI_WDATA,
		output wire [C_M_AXI_DATA_WIDTH/8-1 : 0] M_AXI_WSTRB,
		output wire                            M_AXI_WLAST,
		output wire                            M_AXI_WVALID,
		input wire                             M_AXI_WREADY,
		input wire [C_M_AXI_ID_WIDTH-1 : 0]    M_AXI_BID,
		input wire [1 : 0]                     M_AXI_BRESP,
		input wire                             M_AXI_BVALID,
		output wire                            M_AXI_BREADY,
		output wire [C_M_AXI_ID_WIDTH-1 : 0]   M_AXI_ARID,
		output wire [C_M_AXI_ADDR_WIDTH-1 : 0] M_AXI_ARADDR,
		output wire [7 : 0]                    M_AXI_ARLEN,
		output wire [2 : 0]                    M_AXI_ARSIZE,
		output wire [1 : 0]                    M_AXI_ARBURST,
		output wire                            M_AXI_ARLOCK,
		output wire [3 : 0]                    M_AXI_ARCACHE,
		output wire [2 : 0]                    M_AXI_ARPROT,
		output wire                            M_AXI_ARVALID,
		input wire                             M_AXI_ARREADY,
		input wire [C_M_AXI_ID_WIDTH-1 : 0]    M_AXI_RID,
		input wire [C_M_AXI_DATA_WIDTH-1 : 0]  M_AXI_RDATA,
		input wire [1 : 0]                     M_AXI_RRESP,
		input wire                             M_AXI_RLAST,
		input wire                             M_AXI_RVALID,
		output wire                            M_AXI_RREADY,
      //----------------from axi lite wrapper------------------
                input wire                             READ_START,
                input wire [31 : 0]                    BURST_ONE_FRAME_TOTAL,
      //----------------to fifo-----------------
                output wire [C_M_AXI_DATA_WIDTH-1 : 0] wr_data,
                output wire                            w_en ,
                input  wire                            full_n
	);
   

               
	  function integer clogb2 (input integer bit_depth);              
	  begin                                                           
	    for(clogb2=0; bit_depth>0; clogb2=clogb2+1)                   
	      bit_depth = bit_depth >> 1;                                 
	    end                                                           
	  endfunction                                                     

	 localparam integer C_TRANSACTIONS_NUM = clogb2(C_M_AXI_BURST_LEN-1);

	 localparam integer C_MASTER_LENGTH	= 12;

	 localparam integer C_NO_BURSTS_REQ = C_MASTER_LENGTH-clogb2((C_M_AXI_BURST_LEN*C_M_AXI_DATA_WIDTH/8)-1);

	
	reg [C_M_AXI_ADDR_WIDTH-1 : 0] 	axi_awaddr;
	reg  	                        axi_awvalid;
	reg [C_M_AXI_DATA_WIDTH-1 : 0] 	axi_wdata;
	reg  	                        axi_wlast;
	reg  	                        axi_wvalid;
	reg  	                        axi_bready;
	reg [C_M_AXI_ADDR_WIDTH-1 : 0] 	axi_araddr;
	reg  	                        axi_arvalid;
	wire  	                        axi_rready;
	wire [C_TRANSACTIONS_NUM+2 : 0] burst_size_bytes;
	
	reg  	writes_done;
	reg  	reads_done;
	reg  	error_reg;
	reg  	read_mismatch;
	reg  	burst_write_active;
	reg  	burst_read_active;

	wire  	write_resp_error;
	wire  	read_resp_error;
	wire  	wnext;
	wire  	rnext;
	



	assign M_AXI_AWID	= 'b0;
	assign M_AXI_AWADDR	= C_M_TARGET_SLAVE_BASE_ADDR + axi_awaddr;
	assign M_AXI_AWLEN	= C_M_AXI_BURST_LEN - 1;
	assign M_AXI_AWSIZE	= clogb2((C_M_AXI_DATA_WIDTH/8)-1);
	assign M_AXI_AWBURST	= 2'b01;
	assign M_AXI_AWLOCK	= 1'b0;
	assign M_AXI_AWCACHE	= 4'b0010;
	assign M_AXI_AWPROT	= 3'h0;
	assign M_AXI_AWVALID	= axi_awvalid;
	assign M_AXI_WDATA	= axi_wdata;
	assign M_AXI_WSTRB	= {(C_M_AXI_DATA_WIDTH/8){1'b1}};
	assign M_AXI_WLAST	= axi_wlast;
	assign M_AXI_WVALID	= axi_wvalid;
	assign M_AXI_BREADY	= axi_bready;
	assign M_AXI_ARID	= 'b0;
	assign M_AXI_ARADDR	= C_M_TARGET_SLAVE_BASE_ADDR + axi_araddr;
	assign M_AXI_ARLEN	= C_M_AXI_BURST_LEN - 1;
	assign M_AXI_ARSIZE	= clogb2((C_M_AXI_DATA_WIDTH/8)-1);
	assign M_AXI_ARBURST	= 2'b01;
	assign M_AXI_ARLOCK	= 1'b0;
	assign M_AXI_ARCACHE	= 4'b0010;
	assign M_AXI_ARPROT	= 3'h0;
	assign M_AXI_ARVALID	= axi_arvalid;
	assign M_AXI_RREADY	= axi_rready;
	assign burst_size_bytes	= C_M_AXI_BURST_LEN * C_M_AXI_DATA_WIDTH/8;
                                                                    
	assign write_resp_error = axi_bready & M_AXI_BVALID & M_AXI_BRESP[1];                                     	                                                                                                                                          
   //READ_START 0>>>1  detection
   reg read_start0,read_start1;
   wire read_start01;   
   assign  read_start01=(!read_start1)&&read_start0;

   
   always@(posedge M_AXI_ACLK)begin
      if(M_AXI_ARESETN == 0)begin
          read_start0<=0;
          read_start1<=0;
      end
      else begin
          read_start0<=READ_START;
          read_start1<=read_start0;
      end
    end
   

   reg [31:0] read_burst_count;
   always@(posedge M_AXI_ACLK)begin
      if(M_AXI_ARESETN == 0)begin
         axi_arvalid<=1'b0;
      end 
      else if (~axi_arvalid && read_start01)begin
         axi_arvalid<=1'b1;
      end
      else if (axi_arvalid && (read_burst_count==BURST_ONE_FRAME_TOTAL))begin
         axi_arvalid<=1'b0;
      end
   end

   always@(posedge M_AXI_ACLK)begin
      if(M_AXI_ARESETN == 0)begin
         axi_araddr<='b0;
         read_burst_count<='b0;
      end
      else if (~axi_arvalid && READ_START)begin
         axi_araddr<='b0;
         read_burst_count<='b0;
      end
      else if (axi_arvalid && M_AXI_ARREADY && (read_burst_count<BURST_ONE_FRAME_TOTAL))begin
         axi_araddr<=axi_araddr+burst_size_bytes;
         read_burst_count<=read_burst_count+1'b1;
      end
      else if (axi_arvalid && M_AXI_ARREADY && (read_burst_count==BURST_ONE_FRAME_TOTAL))begin
         axi_araddr<='b0;
         read_burst_count<='b0;
      end
   end

   assign axi_rready = full_n;
   assign w_en = M_AXI_RVALID && axi_rready;
   assign wr_data = M_AXI_RDATA;
   



    endmodule

