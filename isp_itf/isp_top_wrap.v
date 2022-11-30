module isp_top_wrapp (
        CLK,
        RST_N,
        //y master write
        m_axi_gmem0_AWVALID,
        m_axi_gmem0_AWREADY,
        m_axi_gmem0_AWADDR,
        m_axi_gmem0_AWID,
        m_axi_gmem0_AWLEN,
        m_axi_gmem0_AWSIZE,
        m_axi_gmem0_AWBURST,
        m_axi_gmem0_AWLOCK,
        m_axi_gmem0_AWCACHE,
        m_axi_gmem0_AWPROT,
        m_axi_gmem0_AWQOS,
        m_axi_gmem0_AWREGION,
        m_axi_gmem0_AWUSER,
        m_axi_gmem0_WVALID,
        m_axi_gmem0_WREADY,
        m_axi_gmem0_WDATA,
        m_axi_gmem0_WSTRB,
        m_axi_gmem0_WLAST,
        m_axi_gmem0_WID,
        m_axi_gmem0_WUSER,
        m_axi_gmem0_ARVALID,
        m_axi_gmem0_ARREADY,
        m_axi_gmem0_ARADDR,
        m_axi_gmem0_ARID,
        m_axi_gmem0_ARLEN,
        m_axi_gmem0_ARSIZE,
        m_axi_gmem0_ARBURST,
        m_axi_gmem0_ARLOCK,
        m_axi_gmem0_ARCACHE,
        m_axi_gmem0_ARPROT,
        m_axi_gmem0_ARQOS,
        m_axi_gmem0_ARREGION,
        m_axi_gmem0_ARUSER,
        m_axi_gmem0_RVALID,
        m_axi_gmem0_RREADY,
        m_axi_gmem0_RDATA,
        m_axi_gmem0_RLAST,
        m_axi_gmem0_RID,
        m_axi_gmem0_RUSER,
        m_axi_gmem0_RRESP,
        m_axi_gmem0_BVALID,
        m_axi_gmem0_BREADY,
        m_axi_gmem0_BRESP,
        m_axi_gmem0_BID,
        m_axi_gmem0_BUSER,
        //u master write
        m_axi_gmem1_AWVALID,
        m_axi_gmem1_AWREADY,
        m_axi_gmem1_AWADDR,
        m_axi_gmem1_AWID,
        m_axi_gmem1_AWLEN,
        m_axi_gmem1_AWSIZE,
        m_axi_gmem1_AWBURST,
        m_axi_gmem1_AWLOCK,
        m_axi_gmem1_AWCACHE,
        m_axi_gmem1_AWPROT,
        m_axi_gmem1_AWQOS,
        m_axi_gmem1_AWREGION,
        m_axi_gmem1_AWUSER,
        m_axi_gmem1_WVALID,
        m_axi_gmem1_WREADY,
        m_axi_gmem1_WDATA,
        m_axi_gmem1_WSTRB,
        m_axi_gmem1_WLAST,
        m_axi_gmem1_WID,
        m_axi_gmem1_WUSER,
        m_axi_gmem1_ARVALID,
        m_axi_gmem1_ARREADY,
        m_axi_gmem1_ARADDR,
        m_axi_gmem1_ARID,
        m_axi_gmem1_ARLEN,
        m_axi_gmem1_ARSIZE,
        m_axi_gmem1_ARBURST,
        m_axi_gmem1_ARLOCK,
        m_axi_gmem1_ARCACHE,
        m_axi_gmem1_ARPROT,
        m_axi_gmem1_ARQOS,
        m_axi_gmem1_ARREGION,
        m_axi_gmem1_ARUSER,
        m_axi_gmem1_RVALID,
        m_axi_gmem1_RREADY,
        m_axi_gmem1_RDATA,
        m_axi_gmem1_RLAST,
        m_axi_gmem1_RID,
        m_axi_gmem1_RUSER,
        m_axi_gmem1_RRESP,
        m_axi_gmem1_BVALID,
        m_axi_gmem1_BREADY,
        m_axi_gmem1_BRESP,
        m_axi_gmem1_BID,
        m_axi_gmem1_BUSER,
        //v master write
        m_axi_gmem2_AWVALID,
        m_axi_gmem2_AWREADY,
        m_axi_gmem2_AWADDR,
        m_axi_gmem2_AWID,
        m_axi_gmem2_AWLEN,
        m_axi_gmem2_AWSIZE,
        m_axi_gmem2_AWBURST,
        m_axi_gmem2_AWLOCK,
        m_axi_gmem2_AWCACHE,
        m_axi_gmem2_AWPROT,
        m_axi_gmem2_AWQOS,
        m_axi_gmem2_AWREGION,
        m_axi_gmem2_AWUSER,
        m_axi_gmem2_WVALID,
        m_axi_gmem2_WREADY,
        m_axi_gmem2_WDATA,
        m_axi_gmem2_WSTRB,
        m_axi_gmem2_WLAST,
        m_axi_gmem2_WID,
        m_axi_gmem2_WUSER,
        m_axi_gmem2_ARVALID,
        m_axi_gmem2_ARREADY,
        m_axi_gmem2_ARADDR,
        m_axi_gmem2_ARID,
        m_axi_gmem2_ARLEN,
        m_axi_gmem2_ARSIZE,
        m_axi_gmem2_ARBURST,
        m_axi_gmem2_ARLOCK,
        m_axi_gmem2_ARCACHE,
        m_axi_gmem2_ARPROT,
        m_axi_gmem2_ARQOS,
        m_axi_gmem2_ARREGION,
        m_axi_gmem2_ARUSER,
        m_axi_gmem2_RVALID,
        m_axi_gmem2_RREADY,
        m_axi_gmem2_RDATA,
        m_axi_gmem2_RLAST,
        m_axi_gmem2_RID,
        m_axi_gmem2_RUSER,
        m_axi_gmem2_RRESP,
        m_axi_gmem2_BVALID,
        m_axi_gmem2_BREADY,
        m_axi_gmem2_BRESP,
        m_axi_gmem2_BID,
        m_axi_gmem2_BUSER,
        //raw master read 
        M_AXI_AWID,
	M_AXI_AWADDR,
	M_AXI_AWLEN,
	M_AXI_AWSIZE,
	M_AXI_AWBURST,
	M_AXI_AWLOCK,
	M_AXI_AWCACHE,
	M_AXI_AWPROT,
	M_AXI_AWVALID,
	M_AXI_AWREADY,
	M_AXI_WDATA,
	M_AXI_WSTRB,
        M_AXI_WLAST,
	M_AXI_WVALID,
	M_AXI_WREADY,
	M_AXI_BID,
	M_AXI_BRESP,
	M_AXI_BVALID,
	M_AXI_BREADY,
	M_AXI_ARID,
	M_AXI_ARADDR,
	M_AXI_ARLEN,
	M_AXI_ARSIZE,
	M_AXI_ARBURST,
	M_AXI_ARLOCK,
	M_AXI_ARCACHE,
	M_AXI_ARPROT,
	M_AXI_ARVALID,
	M_AXI_ARREADY,
	M_AXI_RID,
	M_AXI_RDATA,
	M_AXI_RRESP,
	M_AXI_RLAST,
	M_AXI_RVALID,
	M_AXI_RREADY,
        //slave lite interface
	S_AXIL_AWADDR,
	S_AXIL_AWVALID,
	S_AXIL_AWREADY,
	S_AXIL_WDATA,
	S_AXIL_WSTRB,
	S_AXIL_WVALID,
	S_AXIL_WREADY,
	S_AXIL_BRESP,
	S_AXIL_BVALID,
	S_AXIL_BREADY,
	S_AXIL_ARADDR,
	S_AXIL_ARVALID,
	S_AXIL_ARREADY,
	S_AXIL_RDATA,
	S_AXIL_RRESP,
	S_AXIL_RVALID,
	S_AXIL_RREADY
);
parameter    C_M_AXI_GMEM0_ID_WIDTH = 1;
parameter    C_M_AXI_GMEM0_ADDR_WIDTH = 32;
parameter    C_M_AXI_GMEM0_DATA_WIDTH = 32;
parameter    C_M_AXI_GMEM0_AWUSER_WIDTH = 1;
parameter    C_M_AXI_GMEM0_ARUSER_WIDTH = 1;
parameter    C_M_AXI_GMEM0_WUSER_WIDTH = 1;
parameter    C_M_AXI_GMEM0_RUSER_WIDTH = 1;
parameter    C_M_AXI_GMEM0_BUSER_WIDTH = 1;
parameter    C_M_AXI_GMEM0_USER_VALUE = 0;
parameter    C_M_AXI_GMEM0_PROT_VALUE = 0;
parameter    C_M_AXI_GMEM0_CACHE_VALUE = 3;
parameter    C_M_AXI_ID_WIDTH = 1;
parameter    C_M_AXI_ADDR_WIDTH = 32;
parameter    C_M_AXI_DATA_WIDTH = 32;
parameter    C_M_AXI_AWUSER_WIDTH = 1;
parameter    C_M_AXI_ARUSER_WIDTH = 1;
parameter    C_M_AXI_WUSER_WIDTH = 1;
parameter    C_M_AXI_RUSER_WIDTH = 1;
parameter    C_M_AXI_BUSER_WIDTH = 1;
parameter    C_M_AXI_GMEM1_ID_WIDTH = 1;
parameter    C_M_AXI_GMEM1_ADDR_WIDTH = 32;
parameter    C_M_AXI_GMEM1_DATA_WIDTH = 32;
parameter    C_M_AXI_GMEM1_AWUSER_WIDTH = 1;
parameter    C_M_AXI_GMEM1_ARUSER_WIDTH = 1;
parameter    C_M_AXI_GMEM1_WUSER_WIDTH = 1;
parameter    C_M_AXI_GMEM1_RUSER_WIDTH = 1;
parameter    C_M_AXI_GMEM1_BUSER_WIDTH = 1;
parameter    C_M_AXI_GMEM1_USER_VALUE = 0;
parameter    C_M_AXI_GMEM1_PROT_VALUE = 0;
parameter    C_M_AXI_GMEM1_CACHE_VALUE = 3;
parameter    C_M_AXI_GMEM2_ID_WIDTH = 1;
parameter    C_M_AXI_GMEM2_ADDR_WIDTH = 32;
parameter    C_M_AXI_GMEM2_DATA_WIDTH = 32;
parameter    C_M_AXI_GMEM2_AWUSER_WIDTH = 1;
parameter    C_M_AXI_GMEM2_ARUSER_WIDTH = 1;
parameter    C_M_AXI_GMEM2_WUSER_WIDTH = 1;
parameter    C_M_AXI_GMEM2_RUSER_WIDTH = 1;
parameter    C_M_AXI_GMEM2_BUSER_WIDTH = 1;
parameter    C_M_AXI_GMEM2_USER_VALUE = 0;
parameter    C_M_AXI_GMEM2_PROT_VALUE = 0;
parameter    C_M_AXI_GMEM2_CACHE_VALUE = 3;

parameter C_M_AXI_GMEM0_WSTRB_WIDTH = (32 / 8);
parameter C_M_AXI_WSTRB_WIDTH = (32 / 8);
parameter C_M_AXI_GMEM1_WSTRB_WIDTH = (32 / 8);
parameter C_M_AXI_GMEM2_WSTRB_WIDTH = (32 / 8);



output  m_axi_gmem0_AWVALID;
input   m_axi_gmem0_AWREADY;
output  [C_M_AXI_GMEM0_ADDR_WIDTH - 1:0] m_axi_gmem0_AWADDR;
output  [C_M_AXI_GMEM0_ID_WIDTH - 1:0] m_axi_gmem0_AWID;
output  [7:0] m_axi_gmem0_AWLEN;
output  [2:0] m_axi_gmem0_AWSIZE;
output  [1:0] m_axi_gmem0_AWBURST;
output  [1:0] m_axi_gmem0_AWLOCK;
output  [3:0] m_axi_gmem0_AWCACHE;
output  [2:0] m_axi_gmem0_AWPROT;
output  [3:0] m_axi_gmem0_AWQOS;
output  [3:0] m_axi_gmem0_AWREGION;
output  [C_M_AXI_GMEM0_AWUSER_WIDTH - 1:0] m_axi_gmem0_AWUSER;
output   m_axi_gmem0_WVALID;
input   m_axi_gmem0_WREADY;
output  [C_M_AXI_GMEM0_DATA_WIDTH - 1:0] m_axi_gmem0_WDATA;
output  [C_M_AXI_GMEM0_WSTRB_WIDTH - 1:0] m_axi_gmem0_WSTRB;
output   m_axi_gmem0_WLAST;
output  [C_M_AXI_GMEM0_ID_WIDTH - 1:0] m_axi_gmem0_WID;
output  [C_M_AXI_GMEM0_WUSER_WIDTH - 1:0] m_axi_gmem0_WUSER;
output   m_axi_gmem0_ARVALID;
input   m_axi_gmem0_ARREADY;
output  [C_M_AXI_GMEM0_ADDR_WIDTH - 1:0] m_axi_gmem0_ARADDR;
output  [C_M_AXI_GMEM0_ID_WIDTH - 1:0] m_axi_gmem0_ARID;
output  [7:0] m_axi_gmem0_ARLEN;
output  [2:0] m_axi_gmem0_ARSIZE;
output  [1:0] m_axi_gmem0_ARBURST;
output  [1:0] m_axi_gmem0_ARLOCK;
output  [3:0] m_axi_gmem0_ARCACHE;
output  [2:0] m_axi_gmem0_ARPROT;
output  [3:0] m_axi_gmem0_ARQOS;
output  [3:0] m_axi_gmem0_ARREGION;
output  [C_M_AXI_GMEM0_ARUSER_WIDTH - 1:0] m_axi_gmem0_ARUSER;
input   m_axi_gmem0_RVALID;
output   m_axi_gmem0_RREADY;
input  [C_M_AXI_GMEM0_DATA_WIDTH - 1:0] m_axi_gmem0_RDATA;
input   m_axi_gmem0_RLAST;
input  [C_M_AXI_GMEM0_ID_WIDTH - 1:0] m_axi_gmem0_RID;
input  [C_M_AXI_GMEM0_RUSER_WIDTH - 1:0] m_axi_gmem0_RUSER;
input  [1:0] m_axi_gmem0_RRESP;
input   m_axi_gmem0_BVALID;
output   m_axi_gmem0_BREADY;
input  [1:0] m_axi_gmem0_BRESP;
input  [C_M_AXI_GMEM0_ID_WIDTH - 1:0] m_axi_gmem0_BID;
input  [C_M_AXI_GMEM0_BUSER_WIDTH - 1:0] m_axi_gmem0_BUSER;
input    CLK;
input    RST_N;
output   m_axi_gmem1_AWVALID;
input   m_axi_gmem1_AWREADY;
output  [C_M_AXI_GMEM1_ADDR_WIDTH - 1:0] m_axi_gmem1_AWADDR;
output  [C_M_AXI_GMEM1_ID_WIDTH - 1:0] m_axi_gmem1_AWID;
output  [7:0] m_axi_gmem1_AWLEN;
output  [2:0] m_axi_gmem1_AWSIZE;
output  [1:0] m_axi_gmem1_AWBURST;
output  [1:0] m_axi_gmem1_AWLOCK;
output  [3:0] m_axi_gmem1_AWCACHE;
output  [2:0] m_axi_gmem1_AWPROT;
output  [3:0] m_axi_gmem1_AWQOS;
output  [3:0] m_axi_gmem1_AWREGION;
output  [C_M_AXI_GMEM1_AWUSER_WIDTH - 1:0] m_axi_gmem1_AWUSER;
output   m_axi_gmem1_WVALID;
input   m_axi_gmem1_WREADY;
output  [C_M_AXI_GMEM1_DATA_WIDTH - 1:0] m_axi_gmem1_WDATA;
output  [C_M_AXI_GMEM1_WSTRB_WIDTH - 1:0] m_axi_gmem1_WSTRB;
output   m_axi_gmem1_WLAST;
output  [C_M_AXI_GMEM1_ID_WIDTH - 1:0] m_axi_gmem1_WID;
output  [C_M_AXI_GMEM1_WUSER_WIDTH - 1:0] m_axi_gmem1_WUSER;
output   m_axi_gmem1_ARVALID;
input   m_axi_gmem1_ARREADY;
output  [C_M_AXI_GMEM1_ADDR_WIDTH - 1:0] m_axi_gmem1_ARADDR;
output  [C_M_AXI_GMEM1_ID_WIDTH - 1:0] m_axi_gmem1_ARID;
output  [7:0] m_axi_gmem1_ARLEN;
output  [2:0] m_axi_gmem1_ARSIZE;
output  [1:0] m_axi_gmem1_ARBURST;
output  [1:0] m_axi_gmem1_ARLOCK;
output  [3:0] m_axi_gmem1_ARCACHE;
output  [2:0] m_axi_gmem1_ARPROT;
output  [3:0] m_axi_gmem1_ARQOS;
output  [3:0] m_axi_gmem1_ARREGION;
output  [C_M_AXI_GMEM1_ARUSER_WIDTH - 1:0] m_axi_gmem1_ARUSER;
input   m_axi_gmem1_RVALID;
output   m_axi_gmem1_RREADY;
input  [C_M_AXI_GMEM1_DATA_WIDTH - 1:0] m_axi_gmem1_RDATA;
input   m_axi_gmem1_RLAST;
input  [C_M_AXI_GMEM1_ID_WIDTH - 1:0] m_axi_gmem1_RID;
input  [C_M_AXI_GMEM1_RUSER_WIDTH - 1:0] m_axi_gmem1_RUSER;
input  [1:0] m_axi_gmem1_RRESP;
input   m_axi_gmem1_BVALID;
output   m_axi_gmem1_BREADY;
input  [1:0] m_axi_gmem1_BRESP;
input  [C_M_AXI_GMEM1_ID_WIDTH - 1:0] m_axi_gmem1_BID;
input  [C_M_AXI_GMEM1_BUSER_WIDTH - 1:0] m_axi_gmem1_BUSER;
output   m_axi_gmem2_AWVALID;
input   m_axi_gmem2_AWREADY;
output  [C_M_AXI_GMEM2_ADDR_WIDTH - 1:0] m_axi_gmem2_AWADDR;
output  [C_M_AXI_GMEM2_ID_WIDTH - 1:0] m_axi_gmem2_AWID;
output  [7:0] m_axi_gmem2_AWLEN;
output  [2:0] m_axi_gmem2_AWSIZE;
output  [1:0] m_axi_gmem2_AWBURST;
output  [1:0] m_axi_gmem2_AWLOCK;
output  [3:0] m_axi_gmem2_AWCACHE;
output  [2:0] m_axi_gmem2_AWPROT;
output  [3:0] m_axi_gmem2_AWQOS;
output  [3:0] m_axi_gmem2_AWREGION;
output  [C_M_AXI_GMEM2_AWUSER_WIDTH - 1:0] m_axi_gmem2_AWUSER;
output   m_axi_gmem2_WVALID;
input   m_axi_gmem2_WREADY;
output  [C_M_AXI_GMEM2_DATA_WIDTH - 1:0] m_axi_gmem2_WDATA;
output  [C_M_AXI_GMEM2_WSTRB_WIDTH - 1:0] m_axi_gmem2_WSTRB;
output   m_axi_gmem2_WLAST;
output  [C_M_AXI_GMEM2_ID_WIDTH - 1:0] m_axi_gmem2_WID;
output  [C_M_AXI_GMEM2_WUSER_WIDTH - 1:0] m_axi_gmem2_WUSER;
output   m_axi_gmem2_ARVALID;
input   m_axi_gmem2_ARREADY;
output  [C_M_AXI_GMEM2_ADDR_WIDTH - 1:0] m_axi_gmem2_ARADDR;
output  [C_M_AXI_GMEM2_ID_WIDTH - 1:0] m_axi_gmem2_ARID;
output  [7:0] m_axi_gmem2_ARLEN;
output  [2:0] m_axi_gmem2_ARSIZE;
output  [1:0] m_axi_gmem2_ARBURST;
output  [1:0] m_axi_gmem2_ARLOCK;
output  [3:0] m_axi_gmem2_ARCACHE;
output  [2:0] m_axi_gmem2_ARPROT;
output  [3:0] m_axi_gmem2_ARQOS;
output  [3:0] m_axi_gmem2_ARREGION;
output  [C_M_AXI_GMEM2_ARUSER_WIDTH - 1:0] m_axi_gmem2_ARUSER;
input   m_axi_gmem2_RVALID;
output   m_axi_gmem2_RREADY;
input  [C_M_AXI_GMEM2_DATA_WIDTH - 1:0] m_axi_gmem2_RDATA;
input   m_axi_gmem2_RLAST;
input  [C_M_AXI_GMEM2_ID_WIDTH - 1:0] m_axi_gmem2_RID;
input  [C_M_AXI_GMEM2_RUSER_WIDTH - 1:0] m_axi_gmem2_RUSER;
input  [1:0] m_axi_gmem2_RRESP;
input   m_axi_gmem2_BVALID;
output   m_axi_gmem2_BREADY;
input  [1:0] m_axi_gmem2_BRESP;
input  [C_M_AXI_GMEM2_ID_WIDTH - 1:0] m_axi_gmem2_BID;
input  [C_M_AXI_GMEM2_BUSER_WIDTH - 1:0] m_axi_gmem2_BUSER;

//M AXI interface
output wire [C_M_AXI_ID_WIDTH-1 : 0] M_AXI_AWID;
output wire [C_M_AXI_ADDR_WIDTH-1 : 0] M_AXI_AWADDR;
output wire [7 : 0] M_AXI_AWLEN;
output wire [2 : 0] M_AXI_AWSIZE;
output wire [1 : 0] M_AXI_AWBURST;
output wire  M_AXI_AWLOCK;
output wire [3 : 0] M_AXI_AWCACHE;
output wire [2 : 0] M_AXI_AWPROT;

output wire  M_AXI_AWVALID;
input wire  M_AXI_AWREADY;
output wire [64-1 : 0] M_AXI_WDATA;
output wire [64/8-1 : 0] M_AXI_WSTRB;
output wire  M_AXI_WLAST;

output wire  M_AXI_WVALID;
input wire  M_AXI_WREADY;
input wire [C_M_AXI_ID_WIDTH-1 : 0] M_AXI_BID;
input wire [1 : 0] M_AXI_BRESP;
input wire  M_AXI_BVALID;
output wire  M_AXI_BREADY;
output wire [C_M_AXI_ID_WIDTH-1 : 0] M_AXI_ARID;
output wire [C_M_AXI_ADDR_WIDTH-1 : 0] M_AXI_ARADDR;
output wire [7 : 0] M_AXI_ARLEN;
output wire [2 : 0] M_AXI_ARSIZE;
output wire [1 : 0] M_AXI_ARBURST;
output wire  M_AXI_ARLOCK;
output wire [3 : 0] M_AXI_ARCACHE;
output wire [2 : 0] M_AXI_ARPROT;
output wire  M_AXI_ARVALID;
input wire  M_AXI_ARREADY;
input wire  M_AXI_RID;
input wire [64-1 : 0] M_AXI_RDATA;
input wire [1 : 0] M_AXI_RRESP;
input wire  M_AXI_RLAST;
input wire  M_AXI_RVALID;
output wire  M_AXI_RREADY;

//slave axilite interface
input wire [10-1:0]     S_AXIL_AWADDR;
input wire 		S_AXIL_AWVALID;
output wire 		S_AXIL_AWREADY;
input  wire [32-1:0]	S_AXIL_WDATA;
input  wire [3:0]       S_AXIL_WSTRB;
input  wire             S_AXIL_WVALID;
output wire             S_AXIL_WREADY;
output wire [1:0]       S_AXIL_BRESP;
output wire             S_AXIL_BVALID;
input  wire 	        S_AXIL_BREADY;
input  wire [32-1:0]    S_AXIL_ARADDR;
input  wire             S_AXIL_ARVALID;
output wire             S_AXIL_ARREADY;
output wire [32-1:0]    S_AXIL_RDATA;
output wire [1:0]       S_AXIL_RRESP;
output wire      	S_AXIL_RVALID;
input  wire             S_AXIL_RREADY;


wire  [11:0] src_V_V_dout;
wire   src_V_V_empty_n;
wire   src_V_V_read;
wire  [31:0] y_ptr_V;
wire  [31:0] u_ptr_V;
wire  [31:0] v_ptr_V;
wire  [12:0] top_register_frameWidth_V;
wire  [12:0] top_register_frameHeight_V;
wire  [0:0] top_register_inputFormat;
wire  [1:0] top_register_imgPattern_V;
wire  [1:0] top_register_pipeMode_V;
wire  [8:0] top_register_blc_V;
wire  [0:0] top_register_shadowEb;
wire  [12:0] top_register_binningFrameWidth_V;
wire  [12:0] top_register_binningFrameHeight_V;
wire  [12:0] top_register_scalerFrameWidth_V;
wire  [12:0] top_register_scalerFrameHeight_V;
wire  [0:0] tpg_register_m_bTPG_en;
wire  [12:0] tpg_register_m_nWidth_V;
wire  [12:0] tpg_register_m_nHeight_V;
wire  [1:0] tpg_register_m_nCFAPattern_V;
wire  [0:0] tpg_register_m_bRollingEnable;
wire  [0:0] tpg_register_m_bSensor_timing_en;
wire  [11:0] tpg_register_m_nVBlank_num_V;
wire  [11:0] tpg_register_m_nHBlank_num_V;
wire  [7:0] tpg_register_m_valid_blank_V;
wire  [2:0] tpg_register_m_nID_V;
wire  [0:0] dgain_register_m_nEb;
wire  [8:0] dgain_register_m_nBlcR_V;
wire  [8:0] dgain_register_m_nBlcGr_V;
wire  [8:0] dgain_register_m_nBlcGb_V;
wire  [8:0] dgain_register_m_nBlcB_V;
wire  [19:0] dgain_register_m_nR_V;
wire  [19:0] dgain_register_m_nGr_V;
wire  [19:0] dgain_register_m_nGb_V;
wire  [19:0] dgain_register_m_nB_V;
wire  [0:0] lsc_register_eb;
wire  [12:0] lsc_register_rGain_V_0;
wire  [12:0] lsc_register_rGain_V_1;
wire  [12:0] lsc_register_rGain_V_2;
wire  [12:0] lsc_register_rGain_V_3;
wire  [12:0] lsc_register_rGain_V_4;
wire  [12:0] lsc_register_rGain_V_5;
wire  [12:0] lsc_register_rGain_V_6;
wire  [12:0] lsc_register_rGain_V_7;
wire  [12:0] lsc_register_rGain_V_8;
wire  [12:0] lsc_register_rGain_V_9;
wire  [12:0] lsc_register_rGain_V_10;
wire  [12:0] lsc_register_rGain_V_11;
wire  [12:0] lsc_register_rGain_V_12;
wire  [12:0] lsc_register_rGain_V_13;
wire  [12:0] lsc_register_rGain_V_14;
wire  [12:0] lsc_register_rGain_V_15;
wire  [12:0] lsc_register_rGain_V_16;
wire  [12:0] lsc_register_rGain_V_17;
wire  [12:0] lsc_register_rGain_V_18;
wire  [12:0] lsc_register_rGain_V_19;
wire  [12:0] lsc_register_rGain_V_20;
wire  [12:0] lsc_register_rGain_V_21;
wire  [12:0] lsc_register_rGain_V_22;
wire  [12:0] lsc_register_rGain_V_23;
wire  [12:0] lsc_register_rGain_V_24;
wire  [12:0] lsc_register_rGain_V_25;
wire  [12:0] lsc_register_rGain_V_26;
wire  [12:0] lsc_register_rGain_V_27;
wire  [12:0] lsc_register_rGain_V_28;
wire  [12:0] lsc_register_rGain_V_29;
wire  [12:0] lsc_register_rGain_V_30;
wire  [12:0] lsc_register_rGain_V_31;
wire  [12:0] lsc_register_rGain_V_32;
wire  [12:0] lsc_register_rGain_V_33;
wire  [12:0] lsc_register_rGain_V_34;
wire  [12:0] lsc_register_rGain_V_35;
wire  [12:0] lsc_register_rGain_V_36;
wire  [12:0] lsc_register_rGain_V_37;
wire  [12:0] lsc_register_rGain_V_38;
wire  [12:0] lsc_register_rGain_V_39;
wire  [12:0] lsc_register_rGain_V_40;
wire  [12:0] lsc_register_rGain_V_41;
wire  [12:0] lsc_register_rGain_V_42;
wire  [12:0] lsc_register_rGain_V_43;
wire  [12:0] lsc_register_rGain_V_44;
wire  [12:0] lsc_register_rGain_V_45;
wire  [12:0] lsc_register_rGain_V_46;
wire  [12:0] lsc_register_rGain_V_47;
wire  [12:0] lsc_register_rGain_V_48;
wire  [12:0] lsc_register_rGain_V_49;
wire  [12:0] lsc_register_rGain_V_50;
wire  [12:0] lsc_register_rGain_V_51;
wire  [12:0] lsc_register_rGain_V_52;
wire  [12:0] lsc_register_rGain_V_53;
wire  [12:0] lsc_register_rGain_V_54;
wire  [12:0] lsc_register_rGain_V_55;
wire  [12:0] lsc_register_rGain_V_56;
wire  [12:0] lsc_register_rGain_V_57;
wire  [12:0] lsc_register_rGain_V_58;
wire  [12:0] lsc_register_rGain_V_59;
wire  [12:0] lsc_register_rGain_V_60;
wire  [12:0] lsc_register_rGain_V_61;
wire  [12:0] lsc_register_rGain_V_62;
wire  [12:0] lsc_register_rGain_V_63;
wire  [12:0] lsc_register_rGain_V_64;
wire  [12:0] lsc_register_rGain_V_65;
wire  [12:0] lsc_register_rGain_V_66;
wire  [12:0] lsc_register_rGain_V_67;
wire  [12:0] lsc_register_rGain_V_68;
wire  [12:0] lsc_register_rGain_V_69;
wire  [12:0] lsc_register_rGain_V_70;
wire  [12:0] lsc_register_rGain_V_71;
wire  [12:0] lsc_register_rGain_V_72;
wire  [12:0] lsc_register_rGain_V_73;
wire  [12:0] lsc_register_rGain_V_74;
wire  [12:0] lsc_register_rGain_V_75;
wire  [12:0] lsc_register_rGain_V_76;
wire  [12:0] lsc_register_rGain_V_77;
wire  [12:0] lsc_register_rGain_V_78;
wire  [12:0] lsc_register_rGain_V_79;
wire  [12:0] lsc_register_rGain_V_80;
wire  [12:0] lsc_register_rGain_V_81;
wire  [12:0] lsc_register_rGain_V_82;
wire  [12:0] lsc_register_rGain_V_83;
wire  [12:0] lsc_register_rGain_V_84;
wire  [12:0] lsc_register_rGain_V_85;
wire  [12:0] lsc_register_rGain_V_86;
wire  [12:0] lsc_register_rGain_V_87;
wire  [12:0] lsc_register_rGain_V_88;
wire  [12:0] lsc_register_rGain_V_89;
wire  [12:0] lsc_register_rGain_V_90;
wire  [12:0] lsc_register_rGain_V_91;
wire  [12:0] lsc_register_rGain_V_92;
wire  [12:0] lsc_register_rGain_V_93;
wire  [12:0] lsc_register_rGain_V_94;
wire  [12:0] lsc_register_rGain_V_95;
wire  [12:0] lsc_register_rGain_V_96;
wire  [12:0] lsc_register_rGain_V_97;
wire  [12:0] lsc_register_rGain_V_98;
wire  [12:0] lsc_register_rGain_V_99;
wire  [12:0] lsc_register_rGain_V_100;
wire  [12:0] lsc_register_rGain_V_101;
wire  [12:0] lsc_register_rGain_V_102;
wire  [12:0] lsc_register_rGain_V_103;
wire  [12:0] lsc_register_rGain_V_104;
wire  [12:0] lsc_register_rGain_V_105;
wire  [12:0] lsc_register_rGain_V_106;
wire  [12:0] lsc_register_rGain_V_107;
wire  [12:0] lsc_register_rGain_V_108;
wire  [12:0] lsc_register_rGain_V_109;
wire  [12:0] lsc_register_rGain_V_110;
wire  [12:0] lsc_register_rGain_V_111;
wire  [12:0] lsc_register_rGain_V_112;
wire  [12:0] lsc_register_rGain_V_113;
wire  [12:0] lsc_register_rGain_V_114;
wire  [12:0] lsc_register_rGain_V_115;
wire  [12:0] lsc_register_rGain_V_116;
wire  [12:0] lsc_register_rGain_V_117;
wire  [12:0] lsc_register_rGain_V_118;
wire  [12:0] lsc_register_rGain_V_119;
wire  [12:0] lsc_register_rGain_V_120;
wire  [12:0] lsc_register_rGain_V_121;
wire  [12:0] lsc_register_rGain_V_122;
wire  [12:0] lsc_register_rGain_V_123;
wire  [12:0] lsc_register_rGain_V_124;
wire  [12:0] lsc_register_rGain_V_125;
wire  [12:0] lsc_register_rGain_V_126;
wire  [12:0] lsc_register_rGain_V_127;
wire  [12:0] lsc_register_rGain_V_128;
wire  [12:0] lsc_register_rGain_V_129;
wire  [12:0] lsc_register_rGain_V_130;
wire  [12:0] lsc_register_rGain_V_131;
wire  [12:0] lsc_register_rGain_V_132;
wire  [12:0] lsc_register_rGain_V_133;
wire  [12:0] lsc_register_rGain_V_134;
wire  [12:0] lsc_register_rGain_V_135;
wire  [12:0] lsc_register_rGain_V_136;
wire  [12:0] lsc_register_rGain_V_137;
wire  [12:0] lsc_register_rGain_V_138;
wire  [12:0] lsc_register_rGain_V_139;
wire  [12:0] lsc_register_rGain_V_140;
wire  [12:0] lsc_register_rGain_V_141;
wire  [12:0] lsc_register_rGain_V_142;
wire  [12:0] lsc_register_rGain_V_143;
wire  [12:0] lsc_register_rGain_V_144;
wire  [12:0] lsc_register_rGain_V_145;
wire  [12:0] lsc_register_rGain_V_146;
wire  [12:0] lsc_register_rGain_V_147;
wire  [12:0] lsc_register_rGain_V_148;
wire  [12:0] lsc_register_rGain_V_149;
wire  [12:0] lsc_register_rGain_V_150;
wire  [12:0] lsc_register_rGain_V_151;
wire  [12:0] lsc_register_rGain_V_152;
wire  [12:0] lsc_register_rGain_V_153;
wire  [12:0] lsc_register_rGain_V_154;
wire  [12:0] lsc_register_rGain_V_155;
wire  [12:0] lsc_register_rGain_V_156;
wire  [12:0] lsc_register_rGain_V_157;
wire  [12:0] lsc_register_rGain_V_158;
wire  [12:0] lsc_register_rGain_V_159;
wire  [12:0] lsc_register_rGain_V_160;
wire  [12:0] lsc_register_rGain_V_161;
wire  [12:0] lsc_register_rGain_V_162;
wire  [12:0] lsc_register_rGain_V_163;
wire  [12:0] lsc_register_rGain_V_164;
wire  [12:0] lsc_register_rGain_V_165;
wire  [12:0] lsc_register_rGain_V_166;
wire  [12:0] lsc_register_rGain_V_167;
wire  [12:0] lsc_register_rGain_V_168;
wire  [12:0] lsc_register_rGain_V_169;
wire  [12:0] lsc_register_rGain_V_170;
wire  [12:0] lsc_register_rGain_V_171;
wire  [12:0] lsc_register_rGain_V_172;
wire  [12:0] lsc_register_rGain_V_173;
wire  [12:0] lsc_register_rGain_V_174;
wire  [12:0] lsc_register_rGain_V_175;
wire  [12:0] lsc_register_rGain_V_176;
wire  [12:0] lsc_register_rGain_V_177;
wire  [12:0] lsc_register_rGain_V_178;
wire  [12:0] lsc_register_rGain_V_179;
wire  [12:0] lsc_register_rGain_V_180;
wire  [12:0] lsc_register_rGain_V_181;
wire  [12:0] lsc_register_rGain_V_182;
wire  [12:0] lsc_register_rGain_V_183;
wire  [12:0] lsc_register_rGain_V_184;
wire  [12:0] lsc_register_rGain_V_185;
wire  [12:0] lsc_register_rGain_V_186;
wire  [12:0] lsc_register_rGain_V_187;
wire  [12:0] lsc_register_rGain_V_188;
wire  [12:0] lsc_register_rGain_V_189;
wire  [12:0] lsc_register_rGain_V_190;
wire  [12:0] lsc_register_rGain_V_191;
wire  [12:0] lsc_register_rGain_V_192;
wire  [12:0] lsc_register_rGain_V_193;
wire  [12:0] lsc_register_rGain_V_194;
wire  [12:0] lsc_register_rGain_V_195;
wire  [12:0] lsc_register_rGain_V_196;
wire  [12:0] lsc_register_rGain_V_197;
wire  [12:0] lsc_register_rGain_V_198;
wire  [12:0] lsc_register_rGain_V_199;
wire  [12:0] lsc_register_rGain_V_200;
wire  [12:0] lsc_register_rGain_V_201;
wire  [12:0] lsc_register_rGain_V_202;
wire  [12:0] lsc_register_rGain_V_203;
wire  [12:0] lsc_register_rGain_V_204;
wire  [12:0] lsc_register_rGain_V_205;
wire  [12:0] lsc_register_rGain_V_206;
wire  [12:0] lsc_register_rGain_V_207;
wire  [12:0] lsc_register_rGain_V_208;
wire  [12:0] lsc_register_rGain_V_209;
wire  [12:0] lsc_register_rGain_V_210;
wire  [12:0] lsc_register_rGain_V_211;
wire  [12:0] lsc_register_rGain_V_212;
wire  [12:0] lsc_register_rGain_V_213;
wire  [12:0] lsc_register_rGain_V_214;
wire  [12:0] lsc_register_rGain_V_215;
wire  [12:0] lsc_register_rGain_V_216;
wire  [12:0] lsc_register_rGain_V_217;
wire  [12:0] lsc_register_rGain_V_218;
wire  [12:0] lsc_register_rGain_V_219;
wire  [12:0] lsc_register_rGain_V_220;
wire  [12:0] lsc_register_GrGain_V_0;
wire  [12:0] lsc_register_GrGain_V_1;
wire  [12:0] lsc_register_GrGain_V_2;
wire  [12:0] lsc_register_GrGain_V_3;
wire  [12:0] lsc_register_GrGain_V_4;
wire  [12:0] lsc_register_GrGain_V_5;
wire  [12:0] lsc_register_GrGain_V_6;
wire  [12:0] lsc_register_GrGain_V_7;
wire  [12:0] lsc_register_GrGain_V_8;
wire  [12:0] lsc_register_GrGain_V_9;
wire  [12:0] lsc_register_GrGain_V_10;
wire  [12:0] lsc_register_GrGain_V_11;
wire  [12:0] lsc_register_GrGain_V_12;
wire  [12:0] lsc_register_GrGain_V_13;
wire  [12:0] lsc_register_GrGain_V_14;
wire  [12:0] lsc_register_GrGain_V_15;
wire  [12:0] lsc_register_GrGain_V_16;
wire  [12:0] lsc_register_GrGain_V_17;
wire  [12:0] lsc_register_GrGain_V_18;
wire  [12:0] lsc_register_GrGain_V_19;
wire  [12:0] lsc_register_GrGain_V_20;
wire  [12:0] lsc_register_GrGain_V_21;
wire  [12:0] lsc_register_GrGain_V_22;
wire  [12:0] lsc_register_GrGain_V_23;
wire  [12:0] lsc_register_GrGain_V_24;
wire  [12:0] lsc_register_GrGain_V_25;
wire  [12:0] lsc_register_GrGain_V_26;
wire  [12:0] lsc_register_GrGain_V_27;
wire  [12:0] lsc_register_GrGain_V_28;
wire  [12:0] lsc_register_GrGain_V_29;
wire  [12:0] lsc_register_GrGain_V_30;
wire  [12:0] lsc_register_GrGain_V_31;
wire  [12:0] lsc_register_GrGain_V_32;
wire  [12:0] lsc_register_GrGain_V_33;
wire  [12:0] lsc_register_GrGain_V_34;
wire  [12:0] lsc_register_GrGain_V_35;
wire  [12:0] lsc_register_GrGain_V_36;
wire  [12:0] lsc_register_GrGain_V_37;
wire  [12:0] lsc_register_GrGain_V_38;
wire  [12:0] lsc_register_GrGain_V_39;
wire  [12:0] lsc_register_GrGain_V_40;
wire  [12:0] lsc_register_GrGain_V_41;
wire  [12:0] lsc_register_GrGain_V_42;
wire  [12:0] lsc_register_GrGain_V_43;
wire  [12:0] lsc_register_GrGain_V_44;
wire  [12:0] lsc_register_GrGain_V_45;
wire  [12:0] lsc_register_GrGain_V_46;
wire  [12:0] lsc_register_GrGain_V_47;
wire  [12:0] lsc_register_GrGain_V_48;
wire  [12:0] lsc_register_GrGain_V_49;
wire  [12:0] lsc_register_GrGain_V_50;
wire  [12:0] lsc_register_GrGain_V_51;
wire  [12:0] lsc_register_GrGain_V_52;
wire  [12:0] lsc_register_GrGain_V_53;
wire  [12:0] lsc_register_GrGain_V_54;
wire  [12:0] lsc_register_GrGain_V_55;
wire  [12:0] lsc_register_GrGain_V_56;
wire  [12:0] lsc_register_GrGain_V_57;
wire  [12:0] lsc_register_GrGain_V_58;
wire  [12:0] lsc_register_GrGain_V_59;
wire  [12:0] lsc_register_GrGain_V_60;
wire  [12:0] lsc_register_GrGain_V_61;
wire  [12:0] lsc_register_GrGain_V_62;
wire  [12:0] lsc_register_GrGain_V_63;
wire  [12:0] lsc_register_GrGain_V_64;
wire  [12:0] lsc_register_GrGain_V_65;
wire  [12:0] lsc_register_GrGain_V_66;
wire  [12:0] lsc_register_GrGain_V_67;
wire  [12:0] lsc_register_GrGain_V_68;
wire  [12:0] lsc_register_GrGain_V_69;
wire  [12:0] lsc_register_GrGain_V_70;
wire  [12:0] lsc_register_GrGain_V_71;
wire  [12:0] lsc_register_GrGain_V_72;
wire  [12:0] lsc_register_GrGain_V_73;
wire  [12:0] lsc_register_GrGain_V_74;
wire  [12:0] lsc_register_GrGain_V_75;
wire  [12:0] lsc_register_GrGain_V_76;
wire  [12:0] lsc_register_GrGain_V_77;
wire  [12:0] lsc_register_GrGain_V_78;
wire  [12:0] lsc_register_GrGain_V_79;
wire  [12:0] lsc_register_GrGain_V_80;
wire  [12:0] lsc_register_GrGain_V_81;
wire  [12:0] lsc_register_GrGain_V_82;
wire  [12:0] lsc_register_GrGain_V_83;
wire  [12:0] lsc_register_GrGain_V_84;
wire  [12:0] lsc_register_GrGain_V_85;
wire  [12:0] lsc_register_GrGain_V_86;
wire  [12:0] lsc_register_GrGain_V_87;
wire  [12:0] lsc_register_GrGain_V_88;
wire  [12:0] lsc_register_GrGain_V_89;
wire  [12:0] lsc_register_GrGain_V_90;
wire  [12:0] lsc_register_GrGain_V_91;
wire  [12:0] lsc_register_GrGain_V_92;
wire  [12:0] lsc_register_GrGain_V_93;
wire  [12:0] lsc_register_GrGain_V_94;
wire  [12:0] lsc_register_GrGain_V_95;
wire  [12:0] lsc_register_GrGain_V_96;
wire  [12:0] lsc_register_GrGain_V_97;
wire  [12:0] lsc_register_GrGain_V_98;
wire  [12:0] lsc_register_GrGain_V_99;
wire  [12:0] lsc_register_GrGain_V_100;
wire  [12:0] lsc_register_GrGain_V_101;
wire  [12:0] lsc_register_GrGain_V_102;
wire  [12:0] lsc_register_GrGain_V_103;
wire  [12:0] lsc_register_GrGain_V_104;
wire  [12:0] lsc_register_GrGain_V_105;
wire  [12:0] lsc_register_GrGain_V_106;
wire  [12:0] lsc_register_GrGain_V_107;
wire  [12:0] lsc_register_GrGain_V_108;
wire  [12:0] lsc_register_GrGain_V_109;
wire  [12:0] lsc_register_GrGain_V_110;
wire  [12:0] lsc_register_GrGain_V_111;
wire  [12:0] lsc_register_GrGain_V_112;
wire  [12:0] lsc_register_GrGain_V_113;
wire  [12:0] lsc_register_GrGain_V_114;
wire  [12:0] lsc_register_GrGain_V_115;
wire  [12:0] lsc_register_GrGain_V_116;
wire  [12:0] lsc_register_GrGain_V_117;
wire  [12:0] lsc_register_GrGain_V_118;
wire  [12:0] lsc_register_GrGain_V_119;
wire  [12:0] lsc_register_GrGain_V_120;
wire  [12:0] lsc_register_GrGain_V_121;
wire  [12:0] lsc_register_GrGain_V_122;
wire  [12:0] lsc_register_GrGain_V_123;
wire  [12:0] lsc_register_GrGain_V_124;
wire  [12:0] lsc_register_GrGain_V_125;
wire  [12:0] lsc_register_GrGain_V_126;
wire  [12:0] lsc_register_GrGain_V_127;
wire  [12:0] lsc_register_GrGain_V_128;
wire  [12:0] lsc_register_GrGain_V_129;
wire  [12:0] lsc_register_GrGain_V_130;
wire  [12:0] lsc_register_GrGain_V_131;
wire  [12:0] lsc_register_GrGain_V_132;
wire  [12:0] lsc_register_GrGain_V_133;
wire  [12:0] lsc_register_GrGain_V_134;
wire  [12:0] lsc_register_GrGain_V_135;
wire  [12:0] lsc_register_GrGain_V_136;
wire  [12:0] lsc_register_GrGain_V_137;
wire  [12:0] lsc_register_GrGain_V_138;
wire  [12:0] lsc_register_GrGain_V_139;
wire  [12:0] lsc_register_GrGain_V_140;
wire  [12:0] lsc_register_GrGain_V_141;
wire  [12:0] lsc_register_GrGain_V_142;
wire  [12:0] lsc_register_GrGain_V_143;
wire  [12:0] lsc_register_GrGain_V_144;
wire  [12:0] lsc_register_GrGain_V_145;
wire  [12:0] lsc_register_GrGain_V_146;
wire  [12:0] lsc_register_GrGain_V_147;
wire  [12:0] lsc_register_GrGain_V_148;
wire  [12:0] lsc_register_GrGain_V_149;
wire  [12:0] lsc_register_GrGain_V_150;
wire  [12:0] lsc_register_GrGain_V_151;
wire  [12:0] lsc_register_GrGain_V_152;
wire  [12:0] lsc_register_GrGain_V_153;
wire  [12:0] lsc_register_GrGain_V_154;
wire  [12:0] lsc_register_GrGain_V_155;
wire  [12:0] lsc_register_GrGain_V_156;
wire  [12:0] lsc_register_GrGain_V_157;
wire  [12:0] lsc_register_GrGain_V_158;
wire  [12:0] lsc_register_GrGain_V_159;
wire  [12:0] lsc_register_GrGain_V_160;
wire  [12:0] lsc_register_GrGain_V_161;
wire  [12:0] lsc_register_GrGain_V_162;
wire  [12:0] lsc_register_GrGain_V_163;
wire  [12:0] lsc_register_GrGain_V_164;
wire  [12:0] lsc_register_GrGain_V_165;
wire  [12:0] lsc_register_GrGain_V_166;
wire  [12:0] lsc_register_GrGain_V_167;
wire  [12:0] lsc_register_GrGain_V_168;
wire  [12:0] lsc_register_GrGain_V_169;
wire  [12:0] lsc_register_GrGain_V_170;
wire  [12:0] lsc_register_GrGain_V_171;
wire  [12:0] lsc_register_GrGain_V_172;
wire  [12:0] lsc_register_GrGain_V_173;
wire  [12:0] lsc_register_GrGain_V_174;
wire  [12:0] lsc_register_GrGain_V_175;
wire  [12:0] lsc_register_GrGain_V_176;
wire  [12:0] lsc_register_GrGain_V_177;
wire  [12:0] lsc_register_GrGain_V_178;
wire  [12:0] lsc_register_GrGain_V_179;
wire  [12:0] lsc_register_GrGain_V_180;
wire  [12:0] lsc_register_GrGain_V_181;
wire  [12:0] lsc_register_GrGain_V_182;
wire  [12:0] lsc_register_GrGain_V_183;
wire  [12:0] lsc_register_GrGain_V_184;
wire  [12:0] lsc_register_GrGain_V_185;
wire  [12:0] lsc_register_GrGain_V_186;
wire  [12:0] lsc_register_GrGain_V_187;
wire  [12:0] lsc_register_GrGain_V_188;
wire  [12:0] lsc_register_GrGain_V_189;
wire  [12:0] lsc_register_GrGain_V_190;
wire  [12:0] lsc_register_GrGain_V_191;
wire  [12:0] lsc_register_GrGain_V_192;
wire  [12:0] lsc_register_GrGain_V_193;
wire  [12:0] lsc_register_GrGain_V_194;
wire  [12:0] lsc_register_GrGain_V_195;
wire  [12:0] lsc_register_GrGain_V_196;
wire  [12:0] lsc_register_GrGain_V_197;
wire  [12:0] lsc_register_GrGain_V_198;
wire  [12:0] lsc_register_GrGain_V_199;
wire  [12:0] lsc_register_GrGain_V_200;
wire  [12:0] lsc_register_GrGain_V_201;
wire  [12:0] lsc_register_GrGain_V_202;
wire  [12:0] lsc_register_GrGain_V_203;
wire  [12:0] lsc_register_GrGain_V_204;
wire  [12:0] lsc_register_GrGain_V_205;
wire  [12:0] lsc_register_GrGain_V_206;
wire  [12:0] lsc_register_GrGain_V_207;
wire  [12:0] lsc_register_GrGain_V_208;
wire  [12:0] lsc_register_GrGain_V_209;
wire  [12:0] lsc_register_GrGain_V_210;
wire  [12:0] lsc_register_GrGain_V_211;
wire  [12:0] lsc_register_GrGain_V_212;
wire  [12:0] lsc_register_GrGain_V_213;
wire  [12:0] lsc_register_GrGain_V_214;
wire  [12:0] lsc_register_GrGain_V_215;
wire  [12:0] lsc_register_GrGain_V_216;
wire  [12:0] lsc_register_GrGain_V_217;
wire  [12:0] lsc_register_GrGain_V_218;
wire  [12:0] lsc_register_GrGain_V_219;
wire  [12:0] lsc_register_GrGain_V_220;
wire  [12:0] lsc_register_GbGain_V_0;
wire  [12:0] lsc_register_GbGain_V_1;
wire  [12:0] lsc_register_GbGain_V_2;
wire  [12:0] lsc_register_GbGain_V_3;
wire  [12:0] lsc_register_GbGain_V_4;
wire  [12:0] lsc_register_GbGain_V_5;
wire  [12:0] lsc_register_GbGain_V_6;
wire  [12:0] lsc_register_GbGain_V_7;
wire  [12:0] lsc_register_GbGain_V_8;
wire  [12:0] lsc_register_GbGain_V_9;
wire  [12:0] lsc_register_GbGain_V_10;
wire  [12:0] lsc_register_GbGain_V_11;
wire  [12:0] lsc_register_GbGain_V_12;
wire  [12:0] lsc_register_GbGain_V_13;
wire  [12:0] lsc_register_GbGain_V_14;
wire  [12:0] lsc_register_GbGain_V_15;
wire  [12:0] lsc_register_GbGain_V_16;
wire  [12:0] lsc_register_GbGain_V_17;
wire  [12:0] lsc_register_GbGain_V_18;
wire  [12:0] lsc_register_GbGain_V_19;
wire  [12:0] lsc_register_GbGain_V_20;
wire  [12:0] lsc_register_GbGain_V_21;
wire  [12:0] lsc_register_GbGain_V_22;
wire  [12:0] lsc_register_GbGain_V_23;
wire  [12:0] lsc_register_GbGain_V_24;
wire  [12:0] lsc_register_GbGain_V_25;
wire  [12:0] lsc_register_GbGain_V_26;
wire  [12:0] lsc_register_GbGain_V_27;
wire  [12:0] lsc_register_GbGain_V_28;
wire  [12:0] lsc_register_GbGain_V_29;
wire  [12:0] lsc_register_GbGain_V_30;
wire  [12:0] lsc_register_GbGain_V_31;
wire  [12:0] lsc_register_GbGain_V_32;
wire  [12:0] lsc_register_GbGain_V_33;
wire  [12:0] lsc_register_GbGain_V_34;
wire  [12:0] lsc_register_GbGain_V_35;
wire  [12:0] lsc_register_GbGain_V_36;
wire  [12:0] lsc_register_GbGain_V_37;
wire  [12:0] lsc_register_GbGain_V_38;
wire  [12:0] lsc_register_GbGain_V_39;
wire  [12:0] lsc_register_GbGain_V_40;
wire  [12:0] lsc_register_GbGain_V_41;
wire  [12:0] lsc_register_GbGain_V_42;
wire  [12:0] lsc_register_GbGain_V_43;
wire  [12:0] lsc_register_GbGain_V_44;
wire  [12:0] lsc_register_GbGain_V_45;
wire  [12:0] lsc_register_GbGain_V_46;
wire  [12:0] lsc_register_GbGain_V_47;
wire  [12:0] lsc_register_GbGain_V_48;
wire  [12:0] lsc_register_GbGain_V_49;
wire  [12:0] lsc_register_GbGain_V_50;
wire  [12:0] lsc_register_GbGain_V_51;
wire  [12:0] lsc_register_GbGain_V_52;
wire  [12:0] lsc_register_GbGain_V_53;
wire  [12:0] lsc_register_GbGain_V_54;
wire  [12:0] lsc_register_GbGain_V_55;
wire  [12:0] lsc_register_GbGain_V_56;
wire  [12:0] lsc_register_GbGain_V_57;
wire  [12:0] lsc_register_GbGain_V_58;
wire  [12:0] lsc_register_GbGain_V_59;
wire  [12:0] lsc_register_GbGain_V_60;
wire  [12:0] lsc_register_GbGain_V_61;
wire  [12:0] lsc_register_GbGain_V_62;
wire  [12:0] lsc_register_GbGain_V_63;
wire  [12:0] lsc_register_GbGain_V_64;
wire  [12:0] lsc_register_GbGain_V_65;
wire  [12:0] lsc_register_GbGain_V_66;
wire  [12:0] lsc_register_GbGain_V_67;
wire  [12:0] lsc_register_GbGain_V_68;
wire  [12:0] lsc_register_GbGain_V_69;
wire  [12:0] lsc_register_GbGain_V_70;
wire  [12:0] lsc_register_GbGain_V_71;
wire  [12:0] lsc_register_GbGain_V_72;
wire  [12:0] lsc_register_GbGain_V_73;
wire  [12:0] lsc_register_GbGain_V_74;
wire  [12:0] lsc_register_GbGain_V_75;
wire  [12:0] lsc_register_GbGain_V_76;
wire  [12:0] lsc_register_GbGain_V_77;
wire  [12:0] lsc_register_GbGain_V_78;
wire  [12:0] lsc_register_GbGain_V_79;
wire  [12:0] lsc_register_GbGain_V_80;
wire  [12:0] lsc_register_GbGain_V_81;
wire  [12:0] lsc_register_GbGain_V_82;
wire  [12:0] lsc_register_GbGain_V_83;
wire  [12:0] lsc_register_GbGain_V_84;
wire  [12:0] lsc_register_GbGain_V_85;
wire  [12:0] lsc_register_GbGain_V_86;
wire  [12:0] lsc_register_GbGain_V_87;
wire  [12:0] lsc_register_GbGain_V_88;
wire  [12:0] lsc_register_GbGain_V_89;
wire  [12:0] lsc_register_GbGain_V_90;
wire  [12:0] lsc_register_GbGain_V_91;
wire  [12:0] lsc_register_GbGain_V_92;
wire  [12:0] lsc_register_GbGain_V_93;
wire  [12:0] lsc_register_GbGain_V_94;
wire  [12:0] lsc_register_GbGain_V_95;
wire  [12:0] lsc_register_GbGain_V_96;
wire  [12:0] lsc_register_GbGain_V_97;
wire  [12:0] lsc_register_GbGain_V_98;
wire  [12:0] lsc_register_GbGain_V_99;
wire  [12:0] lsc_register_GbGain_V_100;
wire  [12:0] lsc_register_GbGain_V_101;
wire  [12:0] lsc_register_GbGain_V_102;
wire  [12:0] lsc_register_GbGain_V_103;
wire  [12:0] lsc_register_GbGain_V_104;
wire  [12:0] lsc_register_GbGain_V_105;
wire  [12:0] lsc_register_GbGain_V_106;
wire  [12:0] lsc_register_GbGain_V_107;
wire  [12:0] lsc_register_GbGain_V_108;
wire  [12:0] lsc_register_GbGain_V_109;
wire  [12:0] lsc_register_GbGain_V_110;
wire  [12:0] lsc_register_GbGain_V_111;
wire  [12:0] lsc_register_GbGain_V_112;
wire  [12:0] lsc_register_GbGain_V_113;
wire  [12:0] lsc_register_GbGain_V_114;
wire  [12:0] lsc_register_GbGain_V_115;
wire  [12:0] lsc_register_GbGain_V_116;
wire  [12:0] lsc_register_GbGain_V_117;
wire  [12:0] lsc_register_GbGain_V_118;
wire  [12:0] lsc_register_GbGain_V_119;
wire  [12:0] lsc_register_GbGain_V_120;
wire  [12:0] lsc_register_GbGain_V_121;
wire  [12:0] lsc_register_GbGain_V_122;
wire  [12:0] lsc_register_GbGain_V_123;
wire  [12:0] lsc_register_GbGain_V_124;
wire  [12:0] lsc_register_GbGain_V_125;
wire  [12:0] lsc_register_GbGain_V_126;
wire  [12:0] lsc_register_GbGain_V_127;
wire  [12:0] lsc_register_GbGain_V_128;
wire  [12:0] lsc_register_GbGain_V_129;
wire  [12:0] lsc_register_GbGain_V_130;
wire  [12:0] lsc_register_GbGain_V_131;
wire  [12:0] lsc_register_GbGain_V_132;
wire  [12:0] lsc_register_GbGain_V_133;
wire  [12:0] lsc_register_GbGain_V_134;
wire  [12:0] lsc_register_GbGain_V_135;
wire  [12:0] lsc_register_GbGain_V_136;
wire  [12:0] lsc_register_GbGain_V_137;
wire  [12:0] lsc_register_GbGain_V_138;
wire  [12:0] lsc_register_GbGain_V_139;
wire  [12:0] lsc_register_GbGain_V_140;
wire  [12:0] lsc_register_GbGain_V_141;
wire  [12:0] lsc_register_GbGain_V_142;
wire  [12:0] lsc_register_GbGain_V_143;
wire  [12:0] lsc_register_GbGain_V_144;
wire  [12:0] lsc_register_GbGain_V_145;
wire  [12:0] lsc_register_GbGain_V_146;
wire  [12:0] lsc_register_GbGain_V_147;
wire  [12:0] lsc_register_GbGain_V_148;
wire  [12:0] lsc_register_GbGain_V_149;
wire  [12:0] lsc_register_GbGain_V_150;
wire  [12:0] lsc_register_GbGain_V_151;
wire  [12:0] lsc_register_GbGain_V_152;
wire  [12:0] lsc_register_GbGain_V_153;
wire  [12:0] lsc_register_GbGain_V_154;
wire  [12:0] lsc_register_GbGain_V_155;
wire  [12:0] lsc_register_GbGain_V_156;
wire  [12:0] lsc_register_GbGain_V_157;
wire  [12:0] lsc_register_GbGain_V_158;
wire  [12:0] lsc_register_GbGain_V_159;
wire  [12:0] lsc_register_GbGain_V_160;
wire  [12:0] lsc_register_GbGain_V_161;
wire  [12:0] lsc_register_GbGain_V_162;
wire  [12:0] lsc_register_GbGain_V_163;
wire  [12:0] lsc_register_GbGain_V_164;
wire  [12:0] lsc_register_GbGain_V_165;
wire  [12:0] lsc_register_GbGain_V_166;
wire  [12:0] lsc_register_GbGain_V_167;
wire  [12:0] lsc_register_GbGain_V_168;
wire  [12:0] lsc_register_GbGain_V_169;
wire  [12:0] lsc_register_GbGain_V_170;
wire  [12:0] lsc_register_GbGain_V_171;
wire  [12:0] lsc_register_GbGain_V_172;
wire  [12:0] lsc_register_GbGain_V_173;
wire  [12:0] lsc_register_GbGain_V_174;
wire  [12:0] lsc_register_GbGain_V_175;
wire  [12:0] lsc_register_GbGain_V_176;
wire  [12:0] lsc_register_GbGain_V_177;
wire  [12:0] lsc_register_GbGain_V_178;
wire  [12:0] lsc_register_GbGain_V_179;
wire  [12:0] lsc_register_GbGain_V_180;
wire  [12:0] lsc_register_GbGain_V_181;
wire  [12:0] lsc_register_GbGain_V_182;
wire  [12:0] lsc_register_GbGain_V_183;
wire  [12:0] lsc_register_GbGain_V_184;
wire  [12:0] lsc_register_GbGain_V_185;
wire  [12:0] lsc_register_GbGain_V_186;
wire  [12:0] lsc_register_GbGain_V_187;
wire  [12:0] lsc_register_GbGain_V_188;
wire  [12:0] lsc_register_GbGain_V_189;
wire  [12:0] lsc_register_GbGain_V_190;
wire  [12:0] lsc_register_GbGain_V_191;
wire  [12:0] lsc_register_GbGain_V_192;
wire  [12:0] lsc_register_GbGain_V_193;
wire  [12:0] lsc_register_GbGain_V_194;
wire  [12:0] lsc_register_GbGain_V_195;
wire  [12:0] lsc_register_GbGain_V_196;
wire  [12:0] lsc_register_GbGain_V_197;
wire  [12:0] lsc_register_GbGain_V_198;
wire  [12:0] lsc_register_GbGain_V_199;
wire  [12:0] lsc_register_GbGain_V_200;
wire  [12:0] lsc_register_GbGain_V_201;
wire  [12:0] lsc_register_GbGain_V_202;
wire  [12:0] lsc_register_GbGain_V_203;
wire  [12:0] lsc_register_GbGain_V_204;
wire  [12:0] lsc_register_GbGain_V_205;
wire  [12:0] lsc_register_GbGain_V_206;
wire  [12:0] lsc_register_GbGain_V_207;
wire  [12:0] lsc_register_GbGain_V_208;
wire  [12:0] lsc_register_GbGain_V_209;
wire  [12:0] lsc_register_GbGain_V_210;
wire  [12:0] lsc_register_GbGain_V_211;
wire  [12:0] lsc_register_GbGain_V_212;
wire  [12:0] lsc_register_GbGain_V_213;
wire  [12:0] lsc_register_GbGain_V_214;
wire  [12:0] lsc_register_GbGain_V_215;
wire  [12:0] lsc_register_GbGain_V_216;
wire  [12:0] lsc_register_GbGain_V_217;
wire  [12:0] lsc_register_GbGain_V_218;
wire  [12:0] lsc_register_GbGain_V_219;
wire  [12:0] lsc_register_GbGain_V_220;
wire  [12:0] lsc_register_bGain_V_0;
wire  [12:0] lsc_register_bGain_V_1;
wire  [12:0] lsc_register_bGain_V_2;
wire  [12:0] lsc_register_bGain_V_3;
wire  [12:0] lsc_register_bGain_V_4;
wire  [12:0] lsc_register_bGain_V_5;
wire  [12:0] lsc_register_bGain_V_6;
wire  [12:0] lsc_register_bGain_V_7;
wire  [12:0] lsc_register_bGain_V_8;
wire  [12:0] lsc_register_bGain_V_9;
wire  [12:0] lsc_register_bGain_V_10;
wire  [12:0] lsc_register_bGain_V_11;
wire  [12:0] lsc_register_bGain_V_12;
wire  [12:0] lsc_register_bGain_V_13;
wire  [12:0] lsc_register_bGain_V_14;
wire  [12:0] lsc_register_bGain_V_15;
wire  [12:0] lsc_register_bGain_V_16;
wire  [12:0] lsc_register_bGain_V_17;
wire  [12:0] lsc_register_bGain_V_18;
wire  [12:0] lsc_register_bGain_V_19;
wire  [12:0] lsc_register_bGain_V_20;
wire  [12:0] lsc_register_bGain_V_21;
wire  [12:0] lsc_register_bGain_V_22;
wire  [12:0] lsc_register_bGain_V_23;
wire  [12:0] lsc_register_bGain_V_24;
wire  [12:0] lsc_register_bGain_V_25;
wire  [12:0] lsc_register_bGain_V_26;
wire  [12:0] lsc_register_bGain_V_27;
wire  [12:0] lsc_register_bGain_V_28;
wire  [12:0] lsc_register_bGain_V_29;
wire  [12:0] lsc_register_bGain_V_30;
wire  [12:0] lsc_register_bGain_V_31;
wire  [12:0] lsc_register_bGain_V_32;
wire  [12:0] lsc_register_bGain_V_33;
wire  [12:0] lsc_register_bGain_V_34;
wire  [12:0] lsc_register_bGain_V_35;
wire  [12:0] lsc_register_bGain_V_36;
wire  [12:0] lsc_register_bGain_V_37;
wire  [12:0] lsc_register_bGain_V_38;
wire  [12:0] lsc_register_bGain_V_39;
wire  [12:0] lsc_register_bGain_V_40;
wire  [12:0] lsc_register_bGain_V_41;
wire  [12:0] lsc_register_bGain_V_42;
wire  [12:0] lsc_register_bGain_V_43;
wire  [12:0] lsc_register_bGain_V_44;
wire  [12:0] lsc_register_bGain_V_45;
wire  [12:0] lsc_register_bGain_V_46;
wire  [12:0] lsc_register_bGain_V_47;
wire  [12:0] lsc_register_bGain_V_48;
wire  [12:0] lsc_register_bGain_V_49;
wire  [12:0] lsc_register_bGain_V_50;
wire  [12:0] lsc_register_bGain_V_51;
wire  [12:0] lsc_register_bGain_V_52;
wire  [12:0] lsc_register_bGain_V_53;
wire  [12:0] lsc_register_bGain_V_54;
wire  [12:0] lsc_register_bGain_V_55;
wire  [12:0] lsc_register_bGain_V_56;
wire  [12:0] lsc_register_bGain_V_57;
wire  [12:0] lsc_register_bGain_V_58;
wire  [12:0] lsc_register_bGain_V_59;
wire  [12:0] lsc_register_bGain_V_60;
wire  [12:0] lsc_register_bGain_V_61;
wire  [12:0] lsc_register_bGain_V_62;
wire  [12:0] lsc_register_bGain_V_63;
wire  [12:0] lsc_register_bGain_V_64;
wire  [12:0] lsc_register_bGain_V_65;
wire  [12:0] lsc_register_bGain_V_66;
wire  [12:0] lsc_register_bGain_V_67;
wire  [12:0] lsc_register_bGain_V_68;
wire  [12:0] lsc_register_bGain_V_69;
wire  [12:0] lsc_register_bGain_V_70;
wire  [12:0] lsc_register_bGain_V_71;
wire  [12:0] lsc_register_bGain_V_72;
wire  [12:0] lsc_register_bGain_V_73;
wire  [12:0] lsc_register_bGain_V_74;
wire  [12:0] lsc_register_bGain_V_75;
wire  [12:0] lsc_register_bGain_V_76;
wire  [12:0] lsc_register_bGain_V_77;
wire  [12:0] lsc_register_bGain_V_78;
wire  [12:0] lsc_register_bGain_V_79;
wire  [12:0] lsc_register_bGain_V_80;
wire  [12:0] lsc_register_bGain_V_81;
wire  [12:0] lsc_register_bGain_V_82;
wire  [12:0] lsc_register_bGain_V_83;
wire  [12:0] lsc_register_bGain_V_84;
wire  [12:0] lsc_register_bGain_V_85;
wire  [12:0] lsc_register_bGain_V_86;
wire  [12:0] lsc_register_bGain_V_87;
wire  [12:0] lsc_register_bGain_V_88;
wire  [12:0] lsc_register_bGain_V_89;
wire  [12:0] lsc_register_bGain_V_90;
wire  [12:0] lsc_register_bGain_V_91;
wire  [12:0] lsc_register_bGain_V_92;
wire  [12:0] lsc_register_bGain_V_93;
wire  [12:0] lsc_register_bGain_V_94;
wire  [12:0] lsc_register_bGain_V_95;
wire  [12:0] lsc_register_bGain_V_96;
wire  [12:0] lsc_register_bGain_V_97;
wire  [12:0] lsc_register_bGain_V_98;
wire  [12:0] lsc_register_bGain_V_99;
wire  [12:0] lsc_register_bGain_V_100;
wire  [12:0] lsc_register_bGain_V_101;
wire  [12:0] lsc_register_bGain_V_102;
wire  [12:0] lsc_register_bGain_V_103;
wire  [12:0] lsc_register_bGain_V_104;
wire  [12:0] lsc_register_bGain_V_105;
wire  [12:0] lsc_register_bGain_V_106;
wire  [12:0] lsc_register_bGain_V_107;
wire  [12:0] lsc_register_bGain_V_108;
wire  [12:0] lsc_register_bGain_V_109;
wire  [12:0] lsc_register_bGain_V_110;
wire  [12:0] lsc_register_bGain_V_111;
wire  [12:0] lsc_register_bGain_V_112;
wire  [12:0] lsc_register_bGain_V_113;
wire  [12:0] lsc_register_bGain_V_114;
wire  [12:0] lsc_register_bGain_V_115;
wire  [12:0] lsc_register_bGain_V_116;
wire  [12:0] lsc_register_bGain_V_117;
wire  [12:0] lsc_register_bGain_V_118;
wire  [12:0] lsc_register_bGain_V_119;
wire  [12:0] lsc_register_bGain_V_120;
wire  [12:0] lsc_register_bGain_V_121;
wire  [12:0] lsc_register_bGain_V_122;
wire  [12:0] lsc_register_bGain_V_123;
wire  [12:0] lsc_register_bGain_V_124;
wire  [12:0] lsc_register_bGain_V_125;
wire  [12:0] lsc_register_bGain_V_126;
wire  [12:0] lsc_register_bGain_V_127;
wire  [12:0] lsc_register_bGain_V_128;
wire  [12:0] lsc_register_bGain_V_129;
wire  [12:0] lsc_register_bGain_V_130;
wire  [12:0] lsc_register_bGain_V_131;
wire  [12:0] lsc_register_bGain_V_132;
wire  [12:0] lsc_register_bGain_V_133;
wire  [12:0] lsc_register_bGain_V_134;
wire  [12:0] lsc_register_bGain_V_135;
wire  [12:0] lsc_register_bGain_V_136;
wire  [12:0] lsc_register_bGain_V_137;
wire  [12:0] lsc_register_bGain_V_138;
wire  [12:0] lsc_register_bGain_V_139;
wire  [12:0] lsc_register_bGain_V_140;
wire  [12:0] lsc_register_bGain_V_141;
wire  [12:0] lsc_register_bGain_V_142;
wire  [12:0] lsc_register_bGain_V_143;
wire  [12:0] lsc_register_bGain_V_144;
wire  [12:0] lsc_register_bGain_V_145;
wire  [12:0] lsc_register_bGain_V_146;
wire  [12:0] lsc_register_bGain_V_147;
wire  [12:0] lsc_register_bGain_V_148;
wire  [12:0] lsc_register_bGain_V_149;
wire  [12:0] lsc_register_bGain_V_150;
wire  [12:0] lsc_register_bGain_V_151;
wire  [12:0] lsc_register_bGain_V_152;
wire  [12:0] lsc_register_bGain_V_153;
wire  [12:0] lsc_register_bGain_V_154;
wire  [12:0] lsc_register_bGain_V_155;
wire  [12:0] lsc_register_bGain_V_156;
wire  [12:0] lsc_register_bGain_V_157;
wire  [12:0] lsc_register_bGain_V_158;
wire  [12:0] lsc_register_bGain_V_159;
wire  [12:0] lsc_register_bGain_V_160;
wire  [12:0] lsc_register_bGain_V_161;
wire  [12:0] lsc_register_bGain_V_162;
wire  [12:0] lsc_register_bGain_V_163;
wire  [12:0] lsc_register_bGain_V_164;
wire  [12:0] lsc_register_bGain_V_165;
wire  [12:0] lsc_register_bGain_V_166;
wire  [12:0] lsc_register_bGain_V_167;
wire  [12:0] lsc_register_bGain_V_168;
wire  [12:0] lsc_register_bGain_V_169;
wire  [12:0] lsc_register_bGain_V_170;
wire  [12:0] lsc_register_bGain_V_171;
wire  [12:0] lsc_register_bGain_V_172;
wire  [12:0] lsc_register_bGain_V_173;
wire  [12:0] lsc_register_bGain_V_174;
wire  [12:0] lsc_register_bGain_V_175;
wire  [12:0] lsc_register_bGain_V_176;
wire  [12:0] lsc_register_bGain_V_177;
wire  [12:0] lsc_register_bGain_V_178;
wire  [12:0] lsc_register_bGain_V_179;
wire  [12:0] lsc_register_bGain_V_180;
wire  [12:0] lsc_register_bGain_V_181;
wire  [12:0] lsc_register_bGain_V_182;
wire  [12:0] lsc_register_bGain_V_183;
wire  [12:0] lsc_register_bGain_V_184;
wire  [12:0] lsc_register_bGain_V_185;
wire  [12:0] lsc_register_bGain_V_186;
wire  [12:0] lsc_register_bGain_V_187;
wire  [12:0] lsc_register_bGain_V_188;
wire  [12:0] lsc_register_bGain_V_189;
wire  [12:0] lsc_register_bGain_V_190;
wire  [12:0] lsc_register_bGain_V_191;
wire  [12:0] lsc_register_bGain_V_192;
wire  [12:0] lsc_register_bGain_V_193;
wire  [12:0] lsc_register_bGain_V_194;
wire  [12:0] lsc_register_bGain_V_195;
wire  [12:0] lsc_register_bGain_V_196;
wire  [12:0] lsc_register_bGain_V_197;
wire  [12:0] lsc_register_bGain_V_198;
wire  [12:0] lsc_register_bGain_V_199;
wire  [12:0] lsc_register_bGain_V_200;
wire  [12:0] lsc_register_bGain_V_201;
wire  [12:0] lsc_register_bGain_V_202;
wire  [12:0] lsc_register_bGain_V_203;
wire  [12:0] lsc_register_bGain_V_204;
wire  [12:0] lsc_register_bGain_V_205;
wire  [12:0] lsc_register_bGain_V_206;
wire  [12:0] lsc_register_bGain_V_207;
wire  [12:0] lsc_register_bGain_V_208;
wire  [12:0] lsc_register_bGain_V_209;
wire  [12:0] lsc_register_bGain_V_210;
wire  [12:0] lsc_register_bGain_V_211;
wire  [12:0] lsc_register_bGain_V_212;
wire  [12:0] lsc_register_bGain_V_213;
wire  [12:0] lsc_register_bGain_V_214;
wire  [12:0] lsc_register_bGain_V_215;
wire  [12:0] lsc_register_bGain_V_216;
wire  [12:0] lsc_register_bGain_V_217;
wire  [12:0] lsc_register_bGain_V_218;
wire  [12:0] lsc_register_bGain_V_219;
wire  [12:0] lsc_register_bGain_V_220;
wire  [8:0] lsc_register_blockHeight_V;
wire  [8:0] lsc_register_blockWidth_V;
wire  [13:0] lsc_register_blockWidth_1_V;
wire  [9:0] lsc_register_blockHeight_1_V;
wire  [0:0] dpc_register_eb;
wire  [10:0] dpc_register_th_w_V;
wire  [10:0] dpc_register_th_b_V;
wire  [5:0] rawdns_register_sigma_V;
wire  [0:0] rawdns_register_eb_V;
wire  [6:0] rawdns_register_Filterpara_V;
wire  [11:0] rawdns_register_invksigma2_V;
wire  [0:0] awb_register_m_nEb;
wire  [14:0] awb_register_r_gain_V;
wire  [14:0] awb_register_g_gain_V;
wire  [14:0] awb_register_b_gain_V;
wire  [4:0] awb_register_coeff_V;
wire  [0:0] wbc_register_m_nEb;
wire  [14:0] wbc_register_m_nR_V;
wire  [14:0] wbc_register_m_nGr_V;
wire  [14:0] wbc_register_m_nGb_V;
wire  [14:0] wbc_register_m_nB_V;
wire  [0:0] gb_register_eb;
wire  [3:0] gb_register_win_size_V;
wire  [3:0] gb_register_Lbound_V;
wire  [5:0] gb_register_Hbound_V;
wire  [9:0] gb_register_threhold_V;
wire  [0:0] demosaic_register_eb;
wire  [0:0] ee_register_eb;
wire  [7:0] ee_register_coeff_V;
wire  [0:0] cmc_register_m_nEb;
wire  [15:0] cmc_register_m_nGain_V_0;
wire  [15:0] cmc_register_m_nGain_V_1;
wire  [15:0] cmc_register_m_nGain_V_2;
wire  [15:0] cmc_register_m_nGain_V_3;
wire  [15:0] cmc_register_m_nGain_V_4;
wire  [15:0] cmc_register_m_nGain_V_5;
wire  [15:0] cmc_register_m_nGain_V_6;
wire  [15:0] cmc_register_m_nGain_V_7;
wire  [15:0] cmc_register_m_nGain_V_8;
wire  [15:0] cmc_register_m_nGain_V_9;
wire  [15:0] cmc_register_m_nGain_V_10;
wire  [15:0] cmc_register_m_nGain_V_11;
wire  [0:0] cmc_register_m_bCFCEnable;
wire  [0:0] cmc_register_m_bDiscardH;
wire  [8:0] cmc_register_m_pHueRange_V_0;
wire  [8:0] cmc_register_m_pHueRange_V_1;
wire  [2:0] cmc_register_m_nHueBandShift_V;
wire  [7:0] cmc_register_m_nEdgeThre_V;
wire  [2:0] cmc_register_m_nEdgeBandShift_V;
wire  [4:0] cmc_register_m_nCFCStrength_V;
wire  [0:0] gtm_register_eb;
wire  [0:0] gtm_register_m_bDitheringEnable;
wire  [9:0] gtm_register_gtmTab_V_0;
wire  [9:0] gtm_register_gtmTab_V_1;
wire  [9:0] gtm_register_gtmTab_V_2;
wire  [9:0] gtm_register_gtmTab_V_3;
wire  [9:0] gtm_register_gtmTab_V_4;
wire  [9:0] gtm_register_gtmTab_V_5;
wire  [9:0] gtm_register_gtmTab_V_6;
wire  [9:0] gtm_register_gtmTab_V_7;
wire  [9:0] gtm_register_gtmTab_V_8;
wire  [9:0] gtm_register_gtmTab_V_9;
wire  [9:0] gtm_register_gtmTab_V_10;
wire  [9:0] gtm_register_gtmTab_V_11;
wire  [9:0] gtm_register_gtmTab_V_12;
wire  [9:0] gtm_register_gtmTab_V_13;
wire  [9:0] gtm_register_gtmTab_V_14;
wire  [9:0] gtm_register_gtmTab_V_15;
wire  [9:0] gtm_register_gtmTab_V_16;
wire  [9:0] gtm_register_gtmTab_V_17;
wire  [9:0] gtm_register_gtmTab_V_18;
wire  [9:0] gtm_register_gtmTab_V_19;
wire  [9:0] gtm_register_gtmTab_V_20;
wire  [9:0] gtm_register_gtmTab_V_21;
wire  [9:0] gtm_register_gtmTab_V_22;
wire  [9:0] gtm_register_gtmTab_V_23;
wire  [9:0] gtm_register_gtmTab_V_24;
wire  [9:0] gtm_register_gtmTab_V_25;
wire  [9:0] gtm_register_gtmTab_V_26;
wire  [9:0] gtm_register_gtmTab_V_27;
wire  [9:0] gtm_register_gtmTab_V_28;
wire  [9:0] gtm_register_gtmTab_V_29;
wire  [9:0] gtm_register_gtmTab_V_30;
wire  [9:0] gtm_register_gtmTab_V_31;
wire  [9:0] gtm_register_gtmTab_V_32;
wire  [9:0] gtm_register_gtmTab_V_33;
wire  [9:0] gtm_register_gtmTab_V_34;
wire  [9:0] gtm_register_gtmTab_V_35;
wire  [9:0] gtm_register_gtmTab_V_36;
wire  [9:0] gtm_register_gtmTab_V_37;
wire  [9:0] gtm_register_gtmTab_V_38;
wire  [9:0] gtm_register_gtmTab_V_39;
wire  [9:0] gtm_register_gtmTab_V_40;
wire  [9:0] gtm_register_gtmTab_V_41;
wire  [9:0] gtm_register_gtmTab_V_42;
wire  [9:0] gtm_register_gtmTab_V_43;
wire  [9:0] gtm_register_gtmTab_V_44;
wire  [9:0] gtm_register_gtmTab_V_45;
wire  [9:0] gtm_register_gtmTab_V_46;
wire  [9:0] gtm_register_gtmTab_V_47;
wire  [9:0] gtm_register_gtmTab_V_48;
wire  [9:0] gtm_register_gtmTab_V_49;
wire  [9:0] gtm_register_gtmTab_V_50;
wire  [9:0] gtm_register_gtmTab_V_51;
wire  [9:0] gtm_register_gtmTab_V_52;
wire  [9:0] gtm_register_gtmTab_V_53;
wire  [9:0] gtm_register_gtmTab_V_54;
wire  [9:0] gtm_register_gtmTab_V_55;
wire  [9:0] gtm_register_gtmTab_V_56;
wire  [9:0] gtm_register_gtmTab_V_57;
wire  [9:0] gtm_register_gtmTab_V_58;
wire  [9:0] gtm_register_gtmTab_V_59;
wire  [9:0] gtm_register_gtmTab_V_60;
wire  [9:0] gtm_register_gtmTab_V_61;
wire  [9:0] gtm_register_gtmTab_V_62;
wire  [9:0] gtm_register_gtmTab_V_63;
wire  [9:0] gtm_register_gtmTab_V_64;
wire  [9:0] gtm_register_gtmTab_V_65;
wire  [9:0] gtm_register_gtmTab_V_66;
wire  [9:0] gtm_register_gtmTab_V_67;
wire  [9:0] gtm_register_gtmTab_V_68;
wire  [9:0] gtm_register_gtmTab_V_69;
wire  [9:0] gtm_register_gtmTab_V_70;
wire  [9:0] gtm_register_gtmTab_V_71;
wire  [9:0] gtm_register_gtmTab_V_72;
wire  [9:0] gtm_register_gtmTab_V_73;
wire  [9:0] gtm_register_gtmTab_V_74;
wire  [9:0] gtm_register_gtmTab_V_75;
wire  [9:0] gtm_register_gtmTab_V_76;
wire  [9:0] gtm_register_gtmTab_V_77;
wire  [9:0] gtm_register_gtmTab_V_78;
wire  [9:0] gtm_register_gtmTab_V_79;
wire  [9:0] gtm_register_gtmTab_V_80;
wire  [9:0] gtm_register_gtmTab_V_81;
wire  [9:0] gtm_register_gtmTab_V_82;
wire  [9:0] gtm_register_gtmTab_V_83;
wire  [9:0] gtm_register_gtmTab_V_84;
wire  [9:0] gtm_register_gtmTab_V_85;
wire  [9:0] gtm_register_gtmTab_V_86;
wire  [9:0] gtm_register_gtmTab_V_87;
wire  [9:0] gtm_register_gtmTab_V_88;
wire  [9:0] gtm_register_gtmTab_V_89;
wire  [9:0] gtm_register_gtmTab_V_90;
wire  [9:0] gtm_register_gtmTab_V_91;
wire  [9:0] gtm_register_gtmTab_V_92;
wire  [9:0] gtm_register_gtmTab_V_93;
wire  [9:0] gtm_register_gtmTab_V_94;
wire  [9:0] gtm_register_gtmTab_V_95;
wire  [9:0] gtm_register_gtmTab_V_96;
wire  [9:0] gtm_register_gtmTab_V_97;
wire  [9:0] gtm_register_gtmTab_V_98;
wire  [9:0] gtm_register_gtmTab_V_99;
wire  [9:0] gtm_register_gtmTab_V_100;
wire  [9:0] gtm_register_gtmTab_V_101;
wire  [9:0] gtm_register_gtmTab_V_102;
wire  [9:0] gtm_register_gtmTab_V_103;
wire  [9:0] gtm_register_gtmTab_V_104;
wire  [9:0] gtm_register_gtmTab_V_105;
wire  [9:0] gtm_register_gtmTab_V_106;
wire  [9:0] gtm_register_gtmTab_V_107;
wire  [9:0] gtm_register_gtmTab_V_108;
wire  [9:0] gtm_register_gtmTab_V_109;
wire  [9:0] gtm_register_gtmTab_V_110;
wire  [9:0] gtm_register_gtmTab_V_111;
wire  [9:0] gtm_register_gtmTab_V_112;
wire  [9:0] gtm_register_gtmTab_V_113;
wire  [9:0] gtm_register_gtmTab_V_114;
wire  [9:0] gtm_register_gtmTab_V_115;
wire  [9:0] gtm_register_gtmTab_V_116;
wire  [9:0] gtm_register_gtmTab_V_117;
wire  [9:0] gtm_register_gtmTab_V_118;
wire  [9:0] gtm_register_gtmTab_V_119;
wire  [9:0] gtm_register_gtmTab_V_120;
wire  [9:0] gtm_register_gtmTab_V_121;
wire  [9:0] gtm_register_gtmTab_V_122;
wire  [9:0] gtm_register_gtmTab_V_123;
wire  [9:0] gtm_register_gtmTab_V_124;
wire  [9:0] gtm_register_gtmTab_V_125;
wire  [9:0] gtm_register_gtmTab_V_126;
wire  [9:0] gtm_register_gtmTab_V_127;
wire  [9:0] gtm_register_gtmTab_V_128;
wire  [0:0] ltm_register_m_nEb_V;
wire  [15:0] ltm_register_contrast_V;
wire  [15:0] ltm_register_ratio_V;
wire  [0:0] cac_register_eb;
wire  [16:0] cac_register_t_transient_V;
wire  [16:0] cac_register_t_edge_V;
wire  [0:0] csc_register_m_nEb;
wire  [10:0] csc_register_coeff_V_0;
wire  [10:0] csc_register_coeff_V_1;
wire  [10:0] csc_register_coeff_V_2;
wire  [10:0] csc_register_coeff_V_3;
wire  [10:0] csc_register_coeff_V_4;
wire  [10:0] csc_register_coeff_V_5;
wire  [10:0] csc_register_coeff_V_6;
wire  [10:0] csc_register_coeff_V_7;
wire  [10:0] csc_register_coeff_V_8;
wire  [10:0] csc_register_coeff_V_9;
wire  [10:0] csc_register_coeff_V_10;
wire  [10:0] csc_register_coeff_V_11;
wire  [0:0] yfc_register_m_nEb;
wire  [0:0] yfc_register_yuvpattern;
wire  [0:0] yuvdns_register_eb_V;
wire  [13:0] yuvdns_register_ysigma2_V;
wire  [9:0] yuvdns_register_yinvsigma2_V;
wire  [13:0] yuvdns_register_uvsigma2_V;
wire  [9:0] yuvdns_register_uvinvsigma2_V;
wire  [3:0] yuvdns_register_yfilt_V;
wire  [3:0] yuvdns_register_uvfilt_V;
wire  [4:0] yuvdns_register_yinvfilt_V;
wire  [4:0] yuvdns_register_uvinvfilt_V;
wire  [13:0] yuvdns_register_yH2_V;
wire  [17:0] yuvdns_register_yinvH2_V;
wire  [13:0] yuvdns_register_uvH2_V;
wire  [17:0] yuvdns_register_uvinvH2_V;
wire  [0:0] scaledown_register_m_nEb;
wire  [1:0] scaledown_register_yuvpattern_V;
wire  [4:0] scaledown_register_times_V;
wire  [0:0] crop_register_m_nEb;
wire  [12:0] crop_register_upper_left_x_V;
wire  [12:0] crop_register_upper_left_y_V;
wire  [12:0] crop_register_lower_right_x_V;
wire  [12:0] crop_register_lower_right_y_V;
wire  [1:0] crop_register_yuvpattern_V;
wire   READ_START;
wire   ap_start;
wire   ap_done;
wire   ap_ready;
wire   ap_idle;

wire [31:0]  isp_read_raw_addr;
wire [31:0]  isp_write_y_addr;
wire [31:0]  isp_write_u_addr;
wire [31:0]  isp_write_v_addr;

wire [15:0] fifo_rd_data;
assign src_V_V_dout = fifo_rd_data[11:0];
wire [31:0] burst_one_frame_total;
wire [63:0] wr_data;
wire        w_en;
wire        full_n;

isp_top isp_top_U0(
    .m_axi_gmem0_AWVALID(m_axi_gmem0_AWVALID),
    .m_axi_gmem0_AWREADY(m_axi_gmem0_AWREADY),
    .m_axi_gmem0_AWADDR(m_axi_gmem0_AWADDR),
    .m_axi_gmem0_AWID(m_axi_gmem0_AWID),
    .m_axi_gmem0_AWLEN(m_axi_gmem0_AWLEN),
    .m_axi_gmem0_AWSIZE(m_axi_gmem0_AWSIZE),
    .m_axi_gmem0_AWBURST(m_axi_gmem0_AWBURST),
    .m_axi_gmem0_AWLOCK(m_axi_gmem0_AWLOCK),
    .m_axi_gmem0_AWCACHE(m_axi_gmem0_AWCACHE),
    .m_axi_gmem0_AWPROT(m_axi_gmem0_AWPROT),
    .m_axi_gmem0_AWQOS(m_axi_gmem0_AWQOS),
    .m_axi_gmem0_AWREGION(m_axi_gmem0_AWREGION),
    .m_axi_gmem0_AWUSER(m_axi_gmem0_AWUSER),
    .m_axi_gmem0_WVALID(m_axi_gmem0_WVALID),
    .m_axi_gmem0_WREADY(m_axi_gmem0_WREADY),
    .m_axi_gmem0_WDATA(m_axi_gmem0_WDATA),
    .m_axi_gmem0_WSTRB(m_axi_gmem0_WSTRB),
    .m_axi_gmem0_WLAST(m_axi_gmem0_WLAST),
    .m_axi_gmem0_WID(m_axi_gmem0_WID),
    .m_axi_gmem0_WUSER(m_axi_gmem0_WUSER),
    .m_axi_gmem0_ARVALID(m_axi_gmem0_ARVALID),
    .m_axi_gmem0_ARREADY(m_axi_gmem0_ARREADY),
    .m_axi_gmem0_ARADDR(m_axi_gmem0_ARADDR),
    .m_axi_gmem0_ARID(m_axi_gmem0_ARID),
    .m_axi_gmem0_ARLEN(m_axi_gmem0_ARLEN),
    .m_axi_gmem0_ARSIZE(m_axi_gmem0_ARSIZE),
    .m_axi_gmem0_ARBURST(m_axi_gmem0_ARBURST),
    .m_axi_gmem0_ARLOCK(m_axi_gmem0_ARLOCK),
    .m_axi_gmem0_ARCACHE(m_axi_gmem0_ARCACHE),
    .m_axi_gmem0_ARPROT(m_axi_gmem0_ARPROT),
    .m_axi_gmem0_ARQOS(m_axi_gmem0_ARQOS),
    .m_axi_gmem0_ARREGION(m_axi_gmem0_ARREGION),
    .m_axi_gmem0_ARUSER(m_axi_gmem0_ARUSER),
    .m_axi_gmem0_RVALID(m_axi_gmem0_RVALID),
    .m_axi_gmem0_RREADY(m_axi_gmem0_RREADY),
    .m_axi_gmem0_RDATA(m_axi_gmem0_RDATA),
    .m_axi_gmem0_RLAST(m_axi_gmem0_RLAST),
    .m_axi_gmem0_RID(m_axi_gmem0_RID),
    .m_axi_gmem0_RUSER(m_axi_gmem0_RUSER),
    .m_axi_gmem0_RRESP(m_axi_gmem0_RRESP),
    .m_axi_gmem0_BVALID(m_axi_gmem0_BVALID),
    .m_axi_gmem0_BREADY(m_axi_gmem0_BREADY),
    .m_axi_gmem0_BRESP(m_axi_gmem0_BRESP),
    .m_axi_gmem0_BID(m_axi_gmem0_BID),
    .m_axi_gmem0_BUSER(m_axi_gmem0_BUSER),
    .ap_clk(CLK),
    .ap_rst_n(RST_N),
    .m_axi_gmem1_AWVALID(m_axi_gmem1_AWVALID),
    .m_axi_gmem1_AWREADY(m_axi_gmem1_AWREADY),
    .m_axi_gmem1_AWADDR(m_axi_gmem1_AWADDR),
    .m_axi_gmem1_AWID(m_axi_gmem1_AWID),
    .m_axi_gmem1_AWLEN(m_axi_gmem1_AWLEN),
    .m_axi_gmem1_AWSIZE(m_axi_gmem1_AWSIZE),
    .m_axi_gmem1_AWBURST(m_axi_gmem1_AWBURST),
    .m_axi_gmem1_AWLOCK(m_axi_gmem1_AWLOCK),
    .m_axi_gmem1_AWCACHE(m_axi_gmem1_AWCACHE),
    .m_axi_gmem1_AWPROT(m_axi_gmem1_AWPROT),
    .m_axi_gmem1_AWQOS(m_axi_gmem1_AWQOS),
    .m_axi_gmem1_AWREGION(m_axi_gmem1_AWREGION),
    .m_axi_gmem1_AWUSER(m_axi_gmem1_AWUSER),
    .m_axi_gmem1_WVALID(m_axi_gmem1_WVALID),
    .m_axi_gmem1_WREADY(m_axi_gmem1_WREADY),
    .m_axi_gmem1_WDATA(m_axi_gmem1_WDATA),
    .m_axi_gmem1_WSTRB(m_axi_gmem1_WSTRB),
    .m_axi_gmem1_WLAST(m_axi_gmem1_WLAST),
    .m_axi_gmem1_WID(m_axi_gmem1_WID),
    .m_axi_gmem1_WUSER(m_axi_gmem1_WUSER),
    .m_axi_gmem1_ARVALID(m_axi_gmem1_ARVALID),
    .m_axi_gmem1_ARREADY(m_axi_gmem1_ARREADY),
    .m_axi_gmem1_ARADDR(m_axi_gmem1_ARADDR),
    .m_axi_gmem1_ARID(m_axi_gmem1_ARID),
    .m_axi_gmem1_ARLEN(m_axi_gmem1_ARLEN),
    .m_axi_gmem1_ARSIZE(m_axi_gmem1_ARSIZE),
    .m_axi_gmem1_ARBURST(m_axi_gmem1_ARBURST),
    .m_axi_gmem1_ARLOCK(m_axi_gmem1_ARLOCK),
    .m_axi_gmem1_ARCACHE(m_axi_gmem1_ARCACHE),
    .m_axi_gmem1_ARPROT(m_axi_gmem1_ARPROT),
    .m_axi_gmem1_ARQOS(m_axi_gmem1_ARQOS),
    .m_axi_gmem1_ARREGION(m_axi_gmem1_ARREGION),
    .m_axi_gmem1_ARUSER(m_axi_gmem1_ARUSER),
    .m_axi_gmem1_RVALID(m_axi_gmem1_RVALID),
    .m_axi_gmem1_RREADY(m_axi_gmem1_RREADY),
    .m_axi_gmem1_RDATA(m_axi_gmem1_RDATA),
    .m_axi_gmem1_RLAST(m_axi_gmem1_RLAST),
    .m_axi_gmem1_RID(m_axi_gmem1_RID),
    .m_axi_gmem1_RUSER(m_axi_gmem1_RUSER),
    .m_axi_gmem1_RRESP(m_axi_gmem1_RRESP),
    .m_axi_gmem1_BVALID(m_axi_gmem1_BVALID),
    .m_axi_gmem1_BREADY(m_axi_gmem1_BREADY),
    .m_axi_gmem1_BRESP(m_axi_gmem1_BRESP),
    .m_axi_gmem1_BID(m_axi_gmem1_BID),
    .m_axi_gmem1_BUSER(m_axi_gmem1_BUSER),
    .m_axi_gmem2_AWVALID(m_axi_gmem2_AWVALID),
    .m_axi_gmem2_AWREADY(m_axi_gmem2_AWREADY),
    .m_axi_gmem2_AWADDR(m_axi_gmem2_AWADDR),
    .m_axi_gmem2_AWID(m_axi_gmem2_AWID),
    .m_axi_gmem2_AWLEN(m_axi_gmem2_AWLEN),
    .m_axi_gmem2_AWSIZE(m_axi_gmem2_AWSIZE),
    .m_axi_gmem2_AWBURST(m_axi_gmem2_AWBURST),
    .m_axi_gmem2_AWLOCK(m_axi_gmem2_AWLOCK),
    .m_axi_gmem2_AWCACHE(m_axi_gmem2_AWCACHE),
    .m_axi_gmem2_AWPROT(m_axi_gmem2_AWPROT),
    .m_axi_gmem2_AWQOS(m_axi_gmem2_AWQOS),
    .m_axi_gmem2_AWREGION(m_axi_gmem2_AWREGION),
    .m_axi_gmem2_AWUSER(m_axi_gmem2_AWUSER),
    .m_axi_gmem2_WVALID(m_axi_gmem2_WVALID),
    .m_axi_gmem2_WREADY(m_axi_gmem2_WREADY),
    .m_axi_gmem2_WDATA(m_axi_gmem2_WDATA),
    .m_axi_gmem2_WSTRB(m_axi_gmem2_WSTRB),
    .m_axi_gmem2_WLAST(m_axi_gmem2_WLAST),
    .m_axi_gmem2_WID(m_axi_gmem2_WID),
    .m_axi_gmem2_WUSER(m_axi_gmem2_WUSER),
    .m_axi_gmem2_ARVALID(m_axi_gmem2_ARVALID),
    .m_axi_gmem2_ARREADY(m_axi_gmem2_ARREADY),
    .m_axi_gmem2_ARADDR(m_axi_gmem2_ARADDR),
    .m_axi_gmem2_ARID(m_axi_gmem2_ARID),
    .m_axi_gmem2_ARLEN(m_axi_gmem2_ARLEN),
    .m_axi_gmem2_ARSIZE(m_axi_gmem2_ARSIZE),
    .m_axi_gmem2_ARBURST(m_axi_gmem2_ARBURST),
    .m_axi_gmem2_ARLOCK(m_axi_gmem2_ARLOCK),
    .m_axi_gmem2_ARCACHE(m_axi_gmem2_ARCACHE),
    .m_axi_gmem2_ARPROT(m_axi_gmem2_ARPROT),
    .m_axi_gmem2_ARQOS(m_axi_gmem2_ARQOS),
    .m_axi_gmem2_ARREGION(m_axi_gmem2_ARREGION),
    .m_axi_gmem2_ARUSER(m_axi_gmem2_ARUSER),
    .m_axi_gmem2_RVALID(m_axi_gmem2_RVALID),
    .m_axi_gmem2_RREADY(m_axi_gmem2_RREADY),
    .m_axi_gmem2_RDATA(m_axi_gmem2_RDATA),
    .m_axi_gmem2_RLAST(m_axi_gmem2_RLAST),
    .m_axi_gmem2_RID(m_axi_gmem2_RID),
    .m_axi_gmem2_RUSER(m_axi_gmem2_RUSER),
    .m_axi_gmem2_RRESP(m_axi_gmem2_RRESP),
    .m_axi_gmem2_BVALID(m_axi_gmem2_BVALID),
    .m_axi_gmem2_BREADY(m_axi_gmem2_BREADY),
    .m_axi_gmem2_BRESP(m_axi_gmem2_BRESP),
    .m_axi_gmem2_BID(m_axi_gmem2_BID),
    .m_axi_gmem2_BUSER(m_axi_gmem2_BUSER),
    .src_V_V_dout(src_V_V_dout),
    .src_V_V_empty_n(src_V_V_empty_n),
    .src_V_V_read(src_V_V_read),
    .y_ptr_V(isp_write_y_addr),
    .u_ptr_V(isp_write_u_addr),
    .v_ptr_V(isp_write_v_addr),
    .top_register_frameWidth_V(top_register_frameWidth_V),
    .top_register_frameHeight_V(top_register_frameHeight_V),
    .top_register_inputFormat(top_register_inputFormat),
    .top_register_imgPattern_V(top_register_imgPattern_V),
    .top_register_pipeMode_V(top_register_pipeMode_V),
    .top_register_blc_V(top_register_blc_V),
    .top_register_shadowEb(top_register_shadowEb),
    .top_register_binningFrameWidth_V(top_register_binningFrameWidth_V),
    .top_register_binningFrameHeight_V(top_register_binningFrameHeight_V),
    .top_register_scalerFrameWidth_V(top_register_scalerFrameWidth_V),
    .top_register_scalerFrameHeight_V(top_register_scalerFrameHeight_V),
    .tpg_register_m_bTPG_en(tpg_register_m_bTPG_en),
    .tpg_register_m_nWidth_V(tpg_register_m_nWidth_V),
    .tpg_register_m_nHeight_V(tpg_register_m_nHeight_V),
    .tpg_register_m_nCFAPattern_V(tpg_register_m_nCFAPattern_V),
    .tpg_register_m_bRollingEnable(tpg_register_m_bRollingEnable),
    .tpg_register_m_bSensor_timing_en(tpg_register_m_bSensor_timing_en),
    .tpg_register_m_nVBlank_num_V(tpg_register_m_nVBlank_num_V),
    .tpg_register_m_nHBlank_num_V(tpg_register_m_nHBlank_num_V),
    .tpg_register_m_valid_blank_V(tpg_register_m_valid_blank_V),
    .tpg_register_m_nID_V(tpg_register_m_nID_V),
    .dgain_register_m_nEb(dgain_register_m_nEb),
    .dgain_register_m_nBlcR_V(dgain_register_m_nBlcR_V),
    .dgain_register_m_nBlcGr_V(dgain_register_m_nBlcGr_V),
    .dgain_register_m_nBlcGb_V(dgain_register_m_nBlcGb_V),
    .dgain_register_m_nBlcB_V(dgain_register_m_nBlcB_V),
    .dgain_register_m_nR_V(dgain_register_m_nR_V),
    .dgain_register_m_nGr_V(dgain_register_m_nGr_V),
    .dgain_register_m_nGb_V(dgain_register_m_nGb_V),
    .dgain_register_m_nB_V(dgain_register_m_nB_V),
    .lsc_register_eb(lsc_register_eb),
    .lsc_register_rGain_V_0(lsc_register_rGain_V_0),
    .lsc_register_rGain_V_1(lsc_register_rGain_V_1),
    .lsc_register_rGain_V_2(lsc_register_rGain_V_2),
    .lsc_register_rGain_V_3(lsc_register_rGain_V_3),
    .lsc_register_rGain_V_4(lsc_register_rGain_V_4),
    .lsc_register_rGain_V_5(lsc_register_rGain_V_5),
    .lsc_register_rGain_V_6(lsc_register_rGain_V_6),
    .lsc_register_rGain_V_7(lsc_register_rGain_V_7),
    .lsc_register_rGain_V_8(lsc_register_rGain_V_8),
    .lsc_register_rGain_V_9(lsc_register_rGain_V_9),
    .lsc_register_rGain_V_10(lsc_register_rGain_V_10),
    .lsc_register_rGain_V_11(lsc_register_rGain_V_11),
    .lsc_register_rGain_V_12(lsc_register_rGain_V_12),
    .lsc_register_rGain_V_13(lsc_register_rGain_V_13),
    .lsc_register_rGain_V_14(lsc_register_rGain_V_14),
    .lsc_register_rGain_V_15(lsc_register_rGain_V_15),
    .lsc_register_rGain_V_16(lsc_register_rGain_V_16),
    .lsc_register_rGain_V_17(lsc_register_rGain_V_17),
    .lsc_register_rGain_V_18(lsc_register_rGain_V_18),
    .lsc_register_rGain_V_19(lsc_register_rGain_V_19),
    .lsc_register_rGain_V_20(lsc_register_rGain_V_20),
    .lsc_register_rGain_V_21(lsc_register_rGain_V_21),
    .lsc_register_rGain_V_22(lsc_register_rGain_V_22),
    .lsc_register_rGain_V_23(lsc_register_rGain_V_23),
    .lsc_register_rGain_V_24(lsc_register_rGain_V_24),
    .lsc_register_rGain_V_25(lsc_register_rGain_V_25),
    .lsc_register_rGain_V_26(lsc_register_rGain_V_26),
    .lsc_register_rGain_V_27(lsc_register_rGain_V_27),
    .lsc_register_rGain_V_28(lsc_register_rGain_V_28),
    .lsc_register_rGain_V_29(lsc_register_rGain_V_29),
    .lsc_register_rGain_V_30(lsc_register_rGain_V_30),
    .lsc_register_rGain_V_31(lsc_register_rGain_V_31),
    .lsc_register_rGain_V_32(lsc_register_rGain_V_32),
    .lsc_register_rGain_V_33(lsc_register_rGain_V_33),
    .lsc_register_rGain_V_34(lsc_register_rGain_V_34),
    .lsc_register_rGain_V_35(lsc_register_rGain_V_35),
    .lsc_register_rGain_V_36(lsc_register_rGain_V_36),
    .lsc_register_rGain_V_37(lsc_register_rGain_V_37),
    .lsc_register_rGain_V_38(lsc_register_rGain_V_38),
    .lsc_register_rGain_V_39(lsc_register_rGain_V_39),
    .lsc_register_rGain_V_40(lsc_register_rGain_V_40),
    .lsc_register_rGain_V_41(lsc_register_rGain_V_41),
    .lsc_register_rGain_V_42(lsc_register_rGain_V_42),
    .lsc_register_rGain_V_43(lsc_register_rGain_V_43),
    .lsc_register_rGain_V_44(lsc_register_rGain_V_44),
    .lsc_register_rGain_V_45(lsc_register_rGain_V_45),
    .lsc_register_rGain_V_46(lsc_register_rGain_V_46),
    .lsc_register_rGain_V_47(lsc_register_rGain_V_47),
    .lsc_register_rGain_V_48(lsc_register_rGain_V_48),
    .lsc_register_rGain_V_49(lsc_register_rGain_V_49),
    .lsc_register_rGain_V_50(lsc_register_rGain_V_50),
    .lsc_register_rGain_V_51(lsc_register_rGain_V_51),
    .lsc_register_rGain_V_52(lsc_register_rGain_V_52),
    .lsc_register_rGain_V_53(lsc_register_rGain_V_53),
    .lsc_register_rGain_V_54(lsc_register_rGain_V_54),
    .lsc_register_rGain_V_55(lsc_register_rGain_V_55),
    .lsc_register_rGain_V_56(lsc_register_rGain_V_56),
    .lsc_register_rGain_V_57(lsc_register_rGain_V_57),
    .lsc_register_rGain_V_58(lsc_register_rGain_V_58),
    .lsc_register_rGain_V_59(lsc_register_rGain_V_59),
    .lsc_register_rGain_V_60(lsc_register_rGain_V_60),
    .lsc_register_rGain_V_61(lsc_register_rGain_V_61),
    .lsc_register_rGain_V_62(lsc_register_rGain_V_62),
    .lsc_register_rGain_V_63(lsc_register_rGain_V_63),
    .lsc_register_rGain_V_64(lsc_register_rGain_V_64),
    .lsc_register_rGain_V_65(lsc_register_rGain_V_65),
    .lsc_register_rGain_V_66(lsc_register_rGain_V_66),
    .lsc_register_rGain_V_67(lsc_register_rGain_V_67),
    .lsc_register_rGain_V_68(lsc_register_rGain_V_68),
    .lsc_register_rGain_V_69(lsc_register_rGain_V_69),
    .lsc_register_rGain_V_70(lsc_register_rGain_V_70),
    .lsc_register_rGain_V_71(lsc_register_rGain_V_71),
    .lsc_register_rGain_V_72(lsc_register_rGain_V_72),
    .lsc_register_rGain_V_73(lsc_register_rGain_V_73),
    .lsc_register_rGain_V_74(lsc_register_rGain_V_74),
    .lsc_register_rGain_V_75(lsc_register_rGain_V_75),
    .lsc_register_rGain_V_76(lsc_register_rGain_V_76),
    .lsc_register_rGain_V_77(lsc_register_rGain_V_77),
    .lsc_register_rGain_V_78(lsc_register_rGain_V_78),
    .lsc_register_rGain_V_79(lsc_register_rGain_V_79),
    .lsc_register_rGain_V_80(lsc_register_rGain_V_80),
    .lsc_register_rGain_V_81(lsc_register_rGain_V_81),
    .lsc_register_rGain_V_82(lsc_register_rGain_V_82),
    .lsc_register_rGain_V_83(lsc_register_rGain_V_83),
    .lsc_register_rGain_V_84(lsc_register_rGain_V_84),
    .lsc_register_rGain_V_85(lsc_register_rGain_V_85),
    .lsc_register_rGain_V_86(lsc_register_rGain_V_86),
    .lsc_register_rGain_V_87(lsc_register_rGain_V_87),
    .lsc_register_rGain_V_88(lsc_register_rGain_V_88),
    .lsc_register_rGain_V_89(lsc_register_rGain_V_89),
    .lsc_register_rGain_V_90(lsc_register_rGain_V_90),
    .lsc_register_rGain_V_91(lsc_register_rGain_V_91),
    .lsc_register_rGain_V_92(lsc_register_rGain_V_92),
    .lsc_register_rGain_V_93(lsc_register_rGain_V_93),
    .lsc_register_rGain_V_94(lsc_register_rGain_V_94),
    .lsc_register_rGain_V_95(lsc_register_rGain_V_95),
    .lsc_register_rGain_V_96(lsc_register_rGain_V_96),
    .lsc_register_rGain_V_97(lsc_register_rGain_V_97),
    .lsc_register_rGain_V_98(lsc_register_rGain_V_98),
    .lsc_register_rGain_V_99(lsc_register_rGain_V_99),
    .lsc_register_rGain_V_100(lsc_register_rGain_V_100),
    .lsc_register_rGain_V_101(lsc_register_rGain_V_101),
    .lsc_register_rGain_V_102(lsc_register_rGain_V_102),
    .lsc_register_rGain_V_103(lsc_register_rGain_V_103),
    .lsc_register_rGain_V_104(lsc_register_rGain_V_104),
    .lsc_register_rGain_V_105(lsc_register_rGain_V_105),
    .lsc_register_rGain_V_106(lsc_register_rGain_V_106),
    .lsc_register_rGain_V_107(lsc_register_rGain_V_107),
    .lsc_register_rGain_V_108(lsc_register_rGain_V_108),
    .lsc_register_rGain_V_109(lsc_register_rGain_V_109),
    .lsc_register_rGain_V_110(lsc_register_rGain_V_110),
    .lsc_register_rGain_V_111(lsc_register_rGain_V_111),
    .lsc_register_rGain_V_112(lsc_register_rGain_V_112),
    .lsc_register_rGain_V_113(lsc_register_rGain_V_113),
    .lsc_register_rGain_V_114(lsc_register_rGain_V_114),
    .lsc_register_rGain_V_115(lsc_register_rGain_V_115),
    .lsc_register_rGain_V_116(lsc_register_rGain_V_116),
    .lsc_register_rGain_V_117(lsc_register_rGain_V_117),
    .lsc_register_rGain_V_118(lsc_register_rGain_V_118),
    .lsc_register_rGain_V_119(lsc_register_rGain_V_119),
    .lsc_register_rGain_V_120(lsc_register_rGain_V_120),
    .lsc_register_rGain_V_121(lsc_register_rGain_V_121),
    .lsc_register_rGain_V_122(lsc_register_rGain_V_122),
    .lsc_register_rGain_V_123(lsc_register_rGain_V_123),
    .lsc_register_rGain_V_124(lsc_register_rGain_V_124),
    .lsc_register_rGain_V_125(lsc_register_rGain_V_125),
    .lsc_register_rGain_V_126(lsc_register_rGain_V_126),
    .lsc_register_rGain_V_127(lsc_register_rGain_V_127),
    .lsc_register_rGain_V_128(lsc_register_rGain_V_128),
    .lsc_register_rGain_V_129(lsc_register_rGain_V_129),
    .lsc_register_rGain_V_130(lsc_register_rGain_V_130),
    .lsc_register_rGain_V_131(lsc_register_rGain_V_131),
    .lsc_register_rGain_V_132(lsc_register_rGain_V_132),
    .lsc_register_rGain_V_133(lsc_register_rGain_V_133),
    .lsc_register_rGain_V_134(lsc_register_rGain_V_134),
    .lsc_register_rGain_V_135(lsc_register_rGain_V_135),
    .lsc_register_rGain_V_136(lsc_register_rGain_V_136),
    .lsc_register_rGain_V_137(lsc_register_rGain_V_137),
    .lsc_register_rGain_V_138(lsc_register_rGain_V_138),
    .lsc_register_rGain_V_139(lsc_register_rGain_V_139),
    .lsc_register_rGain_V_140(lsc_register_rGain_V_140),
    .lsc_register_rGain_V_141(lsc_register_rGain_V_141),
    .lsc_register_rGain_V_142(lsc_register_rGain_V_142),
    .lsc_register_rGain_V_143(lsc_register_rGain_V_143),
    .lsc_register_rGain_V_144(lsc_register_rGain_V_144),
    .lsc_register_rGain_V_145(lsc_register_rGain_V_145),
    .lsc_register_rGain_V_146(lsc_register_rGain_V_146),
    .lsc_register_rGain_V_147(lsc_register_rGain_V_147),
    .lsc_register_rGain_V_148(lsc_register_rGain_V_148),
    .lsc_register_rGain_V_149(lsc_register_rGain_V_149),
    .lsc_register_rGain_V_150(lsc_register_rGain_V_150),
    .lsc_register_rGain_V_151(lsc_register_rGain_V_151),
    .lsc_register_rGain_V_152(lsc_register_rGain_V_152),
    .lsc_register_rGain_V_153(lsc_register_rGain_V_153),
    .lsc_register_rGain_V_154(lsc_register_rGain_V_154),
    .lsc_register_rGain_V_155(lsc_register_rGain_V_155),
    .lsc_register_rGain_V_156(lsc_register_rGain_V_156),
    .lsc_register_rGain_V_157(lsc_register_rGain_V_157),
    .lsc_register_rGain_V_158(lsc_register_rGain_V_158),
    .lsc_register_rGain_V_159(lsc_register_rGain_V_159),
    .lsc_register_rGain_V_160(lsc_register_rGain_V_160),
    .lsc_register_rGain_V_161(lsc_register_rGain_V_161),
    .lsc_register_rGain_V_162(lsc_register_rGain_V_162),
    .lsc_register_rGain_V_163(lsc_register_rGain_V_163),
    .lsc_register_rGain_V_164(lsc_register_rGain_V_164),
    .lsc_register_rGain_V_165(lsc_register_rGain_V_165),
    .lsc_register_rGain_V_166(lsc_register_rGain_V_166),
    .lsc_register_rGain_V_167(lsc_register_rGain_V_167),
    .lsc_register_rGain_V_168(lsc_register_rGain_V_168),
    .lsc_register_rGain_V_169(lsc_register_rGain_V_169),
    .lsc_register_rGain_V_170(lsc_register_rGain_V_170),
    .lsc_register_rGain_V_171(lsc_register_rGain_V_171),
    .lsc_register_rGain_V_172(lsc_register_rGain_V_172),
    .lsc_register_rGain_V_173(lsc_register_rGain_V_173),
    .lsc_register_rGain_V_174(lsc_register_rGain_V_174),
    .lsc_register_rGain_V_175(lsc_register_rGain_V_175),
    .lsc_register_rGain_V_176(lsc_register_rGain_V_176),
    .lsc_register_rGain_V_177(lsc_register_rGain_V_177),
    .lsc_register_rGain_V_178(lsc_register_rGain_V_178),
    .lsc_register_rGain_V_179(lsc_register_rGain_V_179),
    .lsc_register_rGain_V_180(lsc_register_rGain_V_180),
    .lsc_register_rGain_V_181(lsc_register_rGain_V_181),
    .lsc_register_rGain_V_182(lsc_register_rGain_V_182),
    .lsc_register_rGain_V_183(lsc_register_rGain_V_183),
    .lsc_register_rGain_V_184(lsc_register_rGain_V_184),
    .lsc_register_rGain_V_185(lsc_register_rGain_V_185),
    .lsc_register_rGain_V_186(lsc_register_rGain_V_186),
    .lsc_register_rGain_V_187(lsc_register_rGain_V_187),
    .lsc_register_rGain_V_188(lsc_register_rGain_V_188),
    .lsc_register_rGain_V_189(lsc_register_rGain_V_189),
    .lsc_register_rGain_V_190(lsc_register_rGain_V_190),
    .lsc_register_rGain_V_191(lsc_register_rGain_V_191),
    .lsc_register_rGain_V_192(lsc_register_rGain_V_192),
    .lsc_register_rGain_V_193(lsc_register_rGain_V_193),
    .lsc_register_rGain_V_194(lsc_register_rGain_V_194),
    .lsc_register_rGain_V_195(lsc_register_rGain_V_195),
    .lsc_register_rGain_V_196(lsc_register_rGain_V_196),
    .lsc_register_rGain_V_197(lsc_register_rGain_V_197),
    .lsc_register_rGain_V_198(lsc_register_rGain_V_198),
    .lsc_register_rGain_V_199(lsc_register_rGain_V_199),
    .lsc_register_rGain_V_200(lsc_register_rGain_V_200),
    .lsc_register_rGain_V_201(lsc_register_rGain_V_201),
    .lsc_register_rGain_V_202(lsc_register_rGain_V_202),
    .lsc_register_rGain_V_203(lsc_register_rGain_V_203),
    .lsc_register_rGain_V_204(lsc_register_rGain_V_204),
    .lsc_register_rGain_V_205(lsc_register_rGain_V_205),
    .lsc_register_rGain_V_206(lsc_register_rGain_V_206),
    .lsc_register_rGain_V_207(lsc_register_rGain_V_207),
    .lsc_register_rGain_V_208(lsc_register_rGain_V_208),
    .lsc_register_rGain_V_209(lsc_register_rGain_V_209),
    .lsc_register_rGain_V_210(lsc_register_rGain_V_210),
    .lsc_register_rGain_V_211(lsc_register_rGain_V_211),
    .lsc_register_rGain_V_212(lsc_register_rGain_V_212),
    .lsc_register_rGain_V_213(lsc_register_rGain_V_213),
    .lsc_register_rGain_V_214(lsc_register_rGain_V_214),
    .lsc_register_rGain_V_215(lsc_register_rGain_V_215),
    .lsc_register_rGain_V_216(lsc_register_rGain_V_216),
    .lsc_register_rGain_V_217(lsc_register_rGain_V_217),
    .lsc_register_rGain_V_218(lsc_register_rGain_V_218),
    .lsc_register_rGain_V_219(lsc_register_rGain_V_219),
    .lsc_register_rGain_V_220(lsc_register_rGain_V_220),
    .lsc_register_GrGain_V_0(lsc_register_GrGain_V_0),
    .lsc_register_GrGain_V_1(lsc_register_GrGain_V_1),
    .lsc_register_GrGain_V_2(lsc_register_GrGain_V_2),
    .lsc_register_GrGain_V_3(lsc_register_GrGain_V_3),
    .lsc_register_GrGain_V_4(lsc_register_GrGain_V_4),
    .lsc_register_GrGain_V_5(lsc_register_GrGain_V_5),
    .lsc_register_GrGain_V_6(lsc_register_GrGain_V_6),
    .lsc_register_GrGain_V_7(lsc_register_GrGain_V_7),
    .lsc_register_GrGain_V_8(lsc_register_GrGain_V_8),
    .lsc_register_GrGain_V_9(lsc_register_GrGain_V_9),
    .lsc_register_GrGain_V_10(lsc_register_GrGain_V_10),
    .lsc_register_GrGain_V_11(lsc_register_GrGain_V_11),
    .lsc_register_GrGain_V_12(lsc_register_GrGain_V_12),
    .lsc_register_GrGain_V_13(lsc_register_GrGain_V_13),
    .lsc_register_GrGain_V_14(lsc_register_GrGain_V_14),
    .lsc_register_GrGain_V_15(lsc_register_GrGain_V_15),
    .lsc_register_GrGain_V_16(lsc_register_GrGain_V_16),
    .lsc_register_GrGain_V_17(lsc_register_GrGain_V_17),
    .lsc_register_GrGain_V_18(lsc_register_GrGain_V_18),
    .lsc_register_GrGain_V_19(lsc_register_GrGain_V_19),
    .lsc_register_GrGain_V_20(lsc_register_GrGain_V_20),
    .lsc_register_GrGain_V_21(lsc_register_GrGain_V_21),
    .lsc_register_GrGain_V_22(lsc_register_GrGain_V_22),
    .lsc_register_GrGain_V_23(lsc_register_GrGain_V_23),
    .lsc_register_GrGain_V_24(lsc_register_GrGain_V_24),
    .lsc_register_GrGain_V_25(lsc_register_GrGain_V_25),
    .lsc_register_GrGain_V_26(lsc_register_GrGain_V_26),
    .lsc_register_GrGain_V_27(lsc_register_GrGain_V_27),
    .lsc_register_GrGain_V_28(lsc_register_GrGain_V_28),
    .lsc_register_GrGain_V_29(lsc_register_GrGain_V_29),
    .lsc_register_GrGain_V_30(lsc_register_GrGain_V_30),
    .lsc_register_GrGain_V_31(lsc_register_GrGain_V_31),
    .lsc_register_GrGain_V_32(lsc_register_GrGain_V_32),
    .lsc_register_GrGain_V_33(lsc_register_GrGain_V_33),
    .lsc_register_GrGain_V_34(lsc_register_GrGain_V_34),
    .lsc_register_GrGain_V_35(lsc_register_GrGain_V_35),
    .lsc_register_GrGain_V_36(lsc_register_GrGain_V_36),
    .lsc_register_GrGain_V_37(lsc_register_GrGain_V_37),
    .lsc_register_GrGain_V_38(lsc_register_GrGain_V_38),
    .lsc_register_GrGain_V_39(lsc_register_GrGain_V_39),
    .lsc_register_GrGain_V_40(lsc_register_GrGain_V_40),
    .lsc_register_GrGain_V_41(lsc_register_GrGain_V_41),
    .lsc_register_GrGain_V_42(lsc_register_GrGain_V_42),
    .lsc_register_GrGain_V_43(lsc_register_GrGain_V_43),
    .lsc_register_GrGain_V_44(lsc_register_GrGain_V_44),
    .lsc_register_GrGain_V_45(lsc_register_GrGain_V_45),
    .lsc_register_GrGain_V_46(lsc_register_GrGain_V_46),
    .lsc_register_GrGain_V_47(lsc_register_GrGain_V_47),
    .lsc_register_GrGain_V_48(lsc_register_GrGain_V_48),
    .lsc_register_GrGain_V_49(lsc_register_GrGain_V_49),
    .lsc_register_GrGain_V_50(lsc_register_GrGain_V_50),
    .lsc_register_GrGain_V_51(lsc_register_GrGain_V_51),
    .lsc_register_GrGain_V_52(lsc_register_GrGain_V_52),
    .lsc_register_GrGain_V_53(lsc_register_GrGain_V_53),
    .lsc_register_GrGain_V_54(lsc_register_GrGain_V_54),
    .lsc_register_GrGain_V_55(lsc_register_GrGain_V_55),
    .lsc_register_GrGain_V_56(lsc_register_GrGain_V_56),
    .lsc_register_GrGain_V_57(lsc_register_GrGain_V_57),
    .lsc_register_GrGain_V_58(lsc_register_GrGain_V_58),
    .lsc_register_GrGain_V_59(lsc_register_GrGain_V_59),
    .lsc_register_GrGain_V_60(lsc_register_GrGain_V_60),
    .lsc_register_GrGain_V_61(lsc_register_GrGain_V_61),
    .lsc_register_GrGain_V_62(lsc_register_GrGain_V_62),
    .lsc_register_GrGain_V_63(lsc_register_GrGain_V_63),
    .lsc_register_GrGain_V_64(lsc_register_GrGain_V_64),
    .lsc_register_GrGain_V_65(lsc_register_GrGain_V_65),
    .lsc_register_GrGain_V_66(lsc_register_GrGain_V_66),
    .lsc_register_GrGain_V_67(lsc_register_GrGain_V_67),
    .lsc_register_GrGain_V_68(lsc_register_GrGain_V_68),
    .lsc_register_GrGain_V_69(lsc_register_GrGain_V_69),
    .lsc_register_GrGain_V_70(lsc_register_GrGain_V_70),
    .lsc_register_GrGain_V_71(lsc_register_GrGain_V_71),
    .lsc_register_GrGain_V_72(lsc_register_GrGain_V_72),
    .lsc_register_GrGain_V_73(lsc_register_GrGain_V_73),
    .lsc_register_GrGain_V_74(lsc_register_GrGain_V_74),
    .lsc_register_GrGain_V_75(lsc_register_GrGain_V_75),
    .lsc_register_GrGain_V_76(lsc_register_GrGain_V_76),
    .lsc_register_GrGain_V_77(lsc_register_GrGain_V_77),
    .lsc_register_GrGain_V_78(lsc_register_GrGain_V_78),
    .lsc_register_GrGain_V_79(lsc_register_GrGain_V_79),
    .lsc_register_GrGain_V_80(lsc_register_GrGain_V_80),
    .lsc_register_GrGain_V_81(lsc_register_GrGain_V_81),
    .lsc_register_GrGain_V_82(lsc_register_GrGain_V_82),
    .lsc_register_GrGain_V_83(lsc_register_GrGain_V_83),
    .lsc_register_GrGain_V_84(lsc_register_GrGain_V_84),
    .lsc_register_GrGain_V_85(lsc_register_GrGain_V_85),
    .lsc_register_GrGain_V_86(lsc_register_GrGain_V_86),
    .lsc_register_GrGain_V_87(lsc_register_GrGain_V_87),
    .lsc_register_GrGain_V_88(lsc_register_GrGain_V_88),
    .lsc_register_GrGain_V_89(lsc_register_GrGain_V_89),
    .lsc_register_GrGain_V_90(lsc_register_GrGain_V_90),
    .lsc_register_GrGain_V_91(lsc_register_GrGain_V_91),
    .lsc_register_GrGain_V_92(lsc_register_GrGain_V_92),
    .lsc_register_GrGain_V_93(lsc_register_GrGain_V_93),
    .lsc_register_GrGain_V_94(lsc_register_GrGain_V_94),
    .lsc_register_GrGain_V_95(lsc_register_GrGain_V_95),
    .lsc_register_GrGain_V_96(lsc_register_GrGain_V_96),
    .lsc_register_GrGain_V_97(lsc_register_GrGain_V_97),
    .lsc_register_GrGain_V_98(lsc_register_GrGain_V_98),
    .lsc_register_GrGain_V_99(lsc_register_GrGain_V_99),
    .lsc_register_GrGain_V_100(lsc_register_GrGain_V_100),
    .lsc_register_GrGain_V_101(lsc_register_GrGain_V_101),
    .lsc_register_GrGain_V_102(lsc_register_GrGain_V_102),
    .lsc_register_GrGain_V_103(lsc_register_GrGain_V_103),
    .lsc_register_GrGain_V_104(lsc_register_GrGain_V_104),
    .lsc_register_GrGain_V_105(lsc_register_GrGain_V_105),
    .lsc_register_GrGain_V_106(lsc_register_GrGain_V_106),
    .lsc_register_GrGain_V_107(lsc_register_GrGain_V_107),
    .lsc_register_GrGain_V_108(lsc_register_GrGain_V_108),
    .lsc_register_GrGain_V_109(lsc_register_GrGain_V_109),
    .lsc_register_GrGain_V_110(lsc_register_GrGain_V_110),
    .lsc_register_GrGain_V_111(lsc_register_GrGain_V_111),
    .lsc_register_GrGain_V_112(lsc_register_GrGain_V_112),
    .lsc_register_GrGain_V_113(lsc_register_GrGain_V_113),
    .lsc_register_GrGain_V_114(lsc_register_GrGain_V_114),
    .lsc_register_GrGain_V_115(lsc_register_GrGain_V_115),
    .lsc_register_GrGain_V_116(lsc_register_GrGain_V_116),
    .lsc_register_GrGain_V_117(lsc_register_GrGain_V_117),
    .lsc_register_GrGain_V_118(lsc_register_GrGain_V_118),
    .lsc_register_GrGain_V_119(lsc_register_GrGain_V_119),
    .lsc_register_GrGain_V_120(lsc_register_GrGain_V_120),
    .lsc_register_GrGain_V_121(lsc_register_GrGain_V_121),
    .lsc_register_GrGain_V_122(lsc_register_GrGain_V_122),
    .lsc_register_GrGain_V_123(lsc_register_GrGain_V_123),
    .lsc_register_GrGain_V_124(lsc_register_GrGain_V_124),
    .lsc_register_GrGain_V_125(lsc_register_GrGain_V_125),
    .lsc_register_GrGain_V_126(lsc_register_GrGain_V_126),
    .lsc_register_GrGain_V_127(lsc_register_GrGain_V_127),
    .lsc_register_GrGain_V_128(lsc_register_GrGain_V_128),
    .lsc_register_GrGain_V_129(lsc_register_GrGain_V_129),
    .lsc_register_GrGain_V_130(lsc_register_GrGain_V_130),
    .lsc_register_GrGain_V_131(lsc_register_GrGain_V_131),
    .lsc_register_GrGain_V_132(lsc_register_GrGain_V_132),
    .lsc_register_GrGain_V_133(lsc_register_GrGain_V_133),
    .lsc_register_GrGain_V_134(lsc_register_GrGain_V_134),
    .lsc_register_GrGain_V_135(lsc_register_GrGain_V_135),
    .lsc_register_GrGain_V_136(lsc_register_GrGain_V_136),
    .lsc_register_GrGain_V_137(lsc_register_GrGain_V_137),
    .lsc_register_GrGain_V_138(lsc_register_GrGain_V_138),
    .lsc_register_GrGain_V_139(lsc_register_GrGain_V_139),
    .lsc_register_GrGain_V_140(lsc_register_GrGain_V_140),
    .lsc_register_GrGain_V_141(lsc_register_GrGain_V_141),
    .lsc_register_GrGain_V_142(lsc_register_GrGain_V_142),
    .lsc_register_GrGain_V_143(lsc_register_GrGain_V_143),
    .lsc_register_GrGain_V_144(lsc_register_GrGain_V_144),
    .lsc_register_GrGain_V_145(lsc_register_GrGain_V_145),
    .lsc_register_GrGain_V_146(lsc_register_GrGain_V_146),
    .lsc_register_GrGain_V_147(lsc_register_GrGain_V_147),
    .lsc_register_GrGain_V_148(lsc_register_GrGain_V_148),
    .lsc_register_GrGain_V_149(lsc_register_GrGain_V_149),
    .lsc_register_GrGain_V_150(lsc_register_GrGain_V_150),
    .lsc_register_GrGain_V_151(lsc_register_GrGain_V_151),
    .lsc_register_GrGain_V_152(lsc_register_GrGain_V_152),
    .lsc_register_GrGain_V_153(lsc_register_GrGain_V_153),
    .lsc_register_GrGain_V_154(lsc_register_GrGain_V_154),
    .lsc_register_GrGain_V_155(lsc_register_GrGain_V_155),
    .lsc_register_GrGain_V_156(lsc_register_GrGain_V_156),
    .lsc_register_GrGain_V_157(lsc_register_GrGain_V_157),
    .lsc_register_GrGain_V_158(lsc_register_GrGain_V_158),
    .lsc_register_GrGain_V_159(lsc_register_GrGain_V_159),
    .lsc_register_GrGain_V_160(lsc_register_GrGain_V_160),
    .lsc_register_GrGain_V_161(lsc_register_GrGain_V_161),
    .lsc_register_GrGain_V_162(lsc_register_GrGain_V_162),
    .lsc_register_GrGain_V_163(lsc_register_GrGain_V_163),
    .lsc_register_GrGain_V_164(lsc_register_GrGain_V_164),
    .lsc_register_GrGain_V_165(lsc_register_GrGain_V_165),
    .lsc_register_GrGain_V_166(lsc_register_GrGain_V_166),
    .lsc_register_GrGain_V_167(lsc_register_GrGain_V_167),
    .lsc_register_GrGain_V_168(lsc_register_GrGain_V_168),
    .lsc_register_GrGain_V_169(lsc_register_GrGain_V_169),
    .lsc_register_GrGain_V_170(lsc_register_GrGain_V_170),
    .lsc_register_GrGain_V_171(lsc_register_GrGain_V_171),
    .lsc_register_GrGain_V_172(lsc_register_GrGain_V_172),
    .lsc_register_GrGain_V_173(lsc_register_GrGain_V_173),
    .lsc_register_GrGain_V_174(lsc_register_GrGain_V_174),
    .lsc_register_GrGain_V_175(lsc_register_GrGain_V_175),
    .lsc_register_GrGain_V_176(lsc_register_GrGain_V_176),
    .lsc_register_GrGain_V_177(lsc_register_GrGain_V_177),
    .lsc_register_GrGain_V_178(lsc_register_GrGain_V_178),
    .lsc_register_GrGain_V_179(lsc_register_GrGain_V_179),
    .lsc_register_GrGain_V_180(lsc_register_GrGain_V_180),
    .lsc_register_GrGain_V_181(lsc_register_GrGain_V_181),
    .lsc_register_GrGain_V_182(lsc_register_GrGain_V_182),
    .lsc_register_GrGain_V_183(lsc_register_GrGain_V_183),
    .lsc_register_GrGain_V_184(lsc_register_GrGain_V_184),
    .lsc_register_GrGain_V_185(lsc_register_GrGain_V_185),
    .lsc_register_GrGain_V_186(lsc_register_GrGain_V_186),
    .lsc_register_GrGain_V_187(lsc_register_GrGain_V_187),
    .lsc_register_GrGain_V_188(lsc_register_GrGain_V_188),
    .lsc_register_GrGain_V_189(lsc_register_GrGain_V_189),
    .lsc_register_GrGain_V_190(lsc_register_GrGain_V_190),
    .lsc_register_GrGain_V_191(lsc_register_GrGain_V_191),
    .lsc_register_GrGain_V_192(lsc_register_GrGain_V_192),
    .lsc_register_GrGain_V_193(lsc_register_GrGain_V_193),
    .lsc_register_GrGain_V_194(lsc_register_GrGain_V_194),
    .lsc_register_GrGain_V_195(lsc_register_GrGain_V_195),
    .lsc_register_GrGain_V_196(lsc_register_GrGain_V_196),
    .lsc_register_GrGain_V_197(lsc_register_GrGain_V_197),
    .lsc_register_GrGain_V_198(lsc_register_GrGain_V_198),
    .lsc_register_GrGain_V_199(lsc_register_GrGain_V_199),
    .lsc_register_GrGain_V_200(lsc_register_GrGain_V_200),
    .lsc_register_GrGain_V_201(lsc_register_GrGain_V_201),
    .lsc_register_GrGain_V_202(lsc_register_GrGain_V_202),
    .lsc_register_GrGain_V_203(lsc_register_GrGain_V_203),
    .lsc_register_GrGain_V_204(lsc_register_GrGain_V_204),
    .lsc_register_GrGain_V_205(lsc_register_GrGain_V_205),
    .lsc_register_GrGain_V_206(lsc_register_GrGain_V_206),
    .lsc_register_GrGain_V_207(lsc_register_GrGain_V_207),
    .lsc_register_GrGain_V_208(lsc_register_GrGain_V_208),
    .lsc_register_GrGain_V_209(lsc_register_GrGain_V_209),
    .lsc_register_GrGain_V_210(lsc_register_GrGain_V_210),
    .lsc_register_GrGain_V_211(lsc_register_GrGain_V_211),
    .lsc_register_GrGain_V_212(lsc_register_GrGain_V_212),
    .lsc_register_GrGain_V_213(lsc_register_GrGain_V_213),
    .lsc_register_GrGain_V_214(lsc_register_GrGain_V_214),
    .lsc_register_GrGain_V_215(lsc_register_GrGain_V_215),
    .lsc_register_GrGain_V_216(lsc_register_GrGain_V_216),
    .lsc_register_GrGain_V_217(lsc_register_GrGain_V_217),
    .lsc_register_GrGain_V_218(lsc_register_GrGain_V_218),
    .lsc_register_GrGain_V_219(lsc_register_GrGain_V_219),
    .lsc_register_GrGain_V_220(lsc_register_GrGain_V_220),
    .lsc_register_GbGain_V_0(lsc_register_GbGain_V_0),
    .lsc_register_GbGain_V_1(lsc_register_GbGain_V_1),
    .lsc_register_GbGain_V_2(lsc_register_GbGain_V_2),
    .lsc_register_GbGain_V_3(lsc_register_GbGain_V_3),
    .lsc_register_GbGain_V_4(lsc_register_GbGain_V_4),
    .lsc_register_GbGain_V_5(lsc_register_GbGain_V_5),
    .lsc_register_GbGain_V_6(lsc_register_GbGain_V_6),
    .lsc_register_GbGain_V_7(lsc_register_GbGain_V_7),
    .lsc_register_GbGain_V_8(lsc_register_GbGain_V_8),
    .lsc_register_GbGain_V_9(lsc_register_GbGain_V_9),
    .lsc_register_GbGain_V_10(lsc_register_GbGain_V_10),
    .lsc_register_GbGain_V_11(lsc_register_GbGain_V_11),
    .lsc_register_GbGain_V_12(lsc_register_GbGain_V_12),
    .lsc_register_GbGain_V_13(lsc_register_GbGain_V_13),
    .lsc_register_GbGain_V_14(lsc_register_GbGain_V_14),
    .lsc_register_GbGain_V_15(lsc_register_GbGain_V_15),
    .lsc_register_GbGain_V_16(lsc_register_GbGain_V_16),
    .lsc_register_GbGain_V_17(lsc_register_GbGain_V_17),
    .lsc_register_GbGain_V_18(lsc_register_GbGain_V_18),
    .lsc_register_GbGain_V_19(lsc_register_GbGain_V_19),
    .lsc_register_GbGain_V_20(lsc_register_GbGain_V_20),
    .lsc_register_GbGain_V_21(lsc_register_GbGain_V_21),
    .lsc_register_GbGain_V_22(lsc_register_GbGain_V_22),
    .lsc_register_GbGain_V_23(lsc_register_GbGain_V_23),
    .lsc_register_GbGain_V_24(lsc_register_GbGain_V_24),
    .lsc_register_GbGain_V_25(lsc_register_GbGain_V_25),
    .lsc_register_GbGain_V_26(lsc_register_GbGain_V_26),
    .lsc_register_GbGain_V_27(lsc_register_GbGain_V_27),
    .lsc_register_GbGain_V_28(lsc_register_GbGain_V_28),
    .lsc_register_GbGain_V_29(lsc_register_GbGain_V_29),
    .lsc_register_GbGain_V_30(lsc_register_GbGain_V_30),
    .lsc_register_GbGain_V_31(lsc_register_GbGain_V_31),
    .lsc_register_GbGain_V_32(lsc_register_GbGain_V_32),
    .lsc_register_GbGain_V_33(lsc_register_GbGain_V_33),
    .lsc_register_GbGain_V_34(lsc_register_GbGain_V_34),
    .lsc_register_GbGain_V_35(lsc_register_GbGain_V_35),
    .lsc_register_GbGain_V_36(lsc_register_GbGain_V_36),
    .lsc_register_GbGain_V_37(lsc_register_GbGain_V_37),
    .lsc_register_GbGain_V_38(lsc_register_GbGain_V_38),
    .lsc_register_GbGain_V_39(lsc_register_GbGain_V_39),
    .lsc_register_GbGain_V_40(lsc_register_GbGain_V_40),
    .lsc_register_GbGain_V_41(lsc_register_GbGain_V_41),
    .lsc_register_GbGain_V_42(lsc_register_GbGain_V_42),
    .lsc_register_GbGain_V_43(lsc_register_GbGain_V_43),
    .lsc_register_GbGain_V_44(lsc_register_GbGain_V_44),
    .lsc_register_GbGain_V_45(lsc_register_GbGain_V_45),
    .lsc_register_GbGain_V_46(lsc_register_GbGain_V_46),
    .lsc_register_GbGain_V_47(lsc_register_GbGain_V_47),
    .lsc_register_GbGain_V_48(lsc_register_GbGain_V_48),
    .lsc_register_GbGain_V_49(lsc_register_GbGain_V_49),
    .lsc_register_GbGain_V_50(lsc_register_GbGain_V_50),
    .lsc_register_GbGain_V_51(lsc_register_GbGain_V_51),
    .lsc_register_GbGain_V_52(lsc_register_GbGain_V_52),
    .lsc_register_GbGain_V_53(lsc_register_GbGain_V_53),
    .lsc_register_GbGain_V_54(lsc_register_GbGain_V_54),
    .lsc_register_GbGain_V_55(lsc_register_GbGain_V_55),
    .lsc_register_GbGain_V_56(lsc_register_GbGain_V_56),
    .lsc_register_GbGain_V_57(lsc_register_GbGain_V_57),
    .lsc_register_GbGain_V_58(lsc_register_GbGain_V_58),
    .lsc_register_GbGain_V_59(lsc_register_GbGain_V_59),
    .lsc_register_GbGain_V_60(lsc_register_GbGain_V_60),
    .lsc_register_GbGain_V_61(lsc_register_GbGain_V_61),
    .lsc_register_GbGain_V_62(lsc_register_GbGain_V_62),
    .lsc_register_GbGain_V_63(lsc_register_GbGain_V_63),
    .lsc_register_GbGain_V_64(lsc_register_GbGain_V_64),
    .lsc_register_GbGain_V_65(lsc_register_GbGain_V_65),
    .lsc_register_GbGain_V_66(lsc_register_GbGain_V_66),
    .lsc_register_GbGain_V_67(lsc_register_GbGain_V_67),
    .lsc_register_GbGain_V_68(lsc_register_GbGain_V_68),
    .lsc_register_GbGain_V_69(lsc_register_GbGain_V_69),
    .lsc_register_GbGain_V_70(lsc_register_GbGain_V_70),
    .lsc_register_GbGain_V_71(lsc_register_GbGain_V_71),
    .lsc_register_GbGain_V_72(lsc_register_GbGain_V_72),
    .lsc_register_GbGain_V_73(lsc_register_GbGain_V_73),
    .lsc_register_GbGain_V_74(lsc_register_GbGain_V_74),
    .lsc_register_GbGain_V_75(lsc_register_GbGain_V_75),
    .lsc_register_GbGain_V_76(lsc_register_GbGain_V_76),
    .lsc_register_GbGain_V_77(lsc_register_GbGain_V_77),
    .lsc_register_GbGain_V_78(lsc_register_GbGain_V_78),
    .lsc_register_GbGain_V_79(lsc_register_GbGain_V_79),
    .lsc_register_GbGain_V_80(lsc_register_GbGain_V_80),
    .lsc_register_GbGain_V_81(lsc_register_GbGain_V_81),
    .lsc_register_GbGain_V_82(lsc_register_GbGain_V_82),
    .lsc_register_GbGain_V_83(lsc_register_GbGain_V_83),
    .lsc_register_GbGain_V_84(lsc_register_GbGain_V_84),
    .lsc_register_GbGain_V_85(lsc_register_GbGain_V_85),
    .lsc_register_GbGain_V_86(lsc_register_GbGain_V_86),
    .lsc_register_GbGain_V_87(lsc_register_GbGain_V_87),
    .lsc_register_GbGain_V_88(lsc_register_GbGain_V_88),
    .lsc_register_GbGain_V_89(lsc_register_GbGain_V_89),
    .lsc_register_GbGain_V_90(lsc_register_GbGain_V_90),
    .lsc_register_GbGain_V_91(lsc_register_GbGain_V_91),
    .lsc_register_GbGain_V_92(lsc_register_GbGain_V_92),
    .lsc_register_GbGain_V_93(lsc_register_GbGain_V_93),
    .lsc_register_GbGain_V_94(lsc_register_GbGain_V_94),
    .lsc_register_GbGain_V_95(lsc_register_GbGain_V_95),
    .lsc_register_GbGain_V_96(lsc_register_GbGain_V_96),
    .lsc_register_GbGain_V_97(lsc_register_GbGain_V_97),
    .lsc_register_GbGain_V_98(lsc_register_GbGain_V_98),
    .lsc_register_GbGain_V_99(lsc_register_GbGain_V_99),
    .lsc_register_GbGain_V_100(lsc_register_GbGain_V_100),
    .lsc_register_GbGain_V_101(lsc_register_GbGain_V_101),
    .lsc_register_GbGain_V_102(lsc_register_GbGain_V_102),
    .lsc_register_GbGain_V_103(lsc_register_GbGain_V_103),
    .lsc_register_GbGain_V_104(lsc_register_GbGain_V_104),
    .lsc_register_GbGain_V_105(lsc_register_GbGain_V_105),
    .lsc_register_GbGain_V_106(lsc_register_GbGain_V_106),
    .lsc_register_GbGain_V_107(lsc_register_GbGain_V_107),
    .lsc_register_GbGain_V_108(lsc_register_GbGain_V_108),
    .lsc_register_GbGain_V_109(lsc_register_GbGain_V_109),
    .lsc_register_GbGain_V_110(lsc_register_GbGain_V_110),
    .lsc_register_GbGain_V_111(lsc_register_GbGain_V_111),
    .lsc_register_GbGain_V_112(lsc_register_GbGain_V_112),
    .lsc_register_GbGain_V_113(lsc_register_GbGain_V_113),
    .lsc_register_GbGain_V_114(lsc_register_GbGain_V_114),
    .lsc_register_GbGain_V_115(lsc_register_GbGain_V_115),
    .lsc_register_GbGain_V_116(lsc_register_GbGain_V_116),
    .lsc_register_GbGain_V_117(lsc_register_GbGain_V_117),
    .lsc_register_GbGain_V_118(lsc_register_GbGain_V_118),
    .lsc_register_GbGain_V_119(lsc_register_GbGain_V_119),
    .lsc_register_GbGain_V_120(lsc_register_GbGain_V_120),
    .lsc_register_GbGain_V_121(lsc_register_GbGain_V_121),
    .lsc_register_GbGain_V_122(lsc_register_GbGain_V_122),
    .lsc_register_GbGain_V_123(lsc_register_GbGain_V_123),
    .lsc_register_GbGain_V_124(lsc_register_GbGain_V_124),
    .lsc_register_GbGain_V_125(lsc_register_GbGain_V_125),
    .lsc_register_GbGain_V_126(lsc_register_GbGain_V_126),
    .lsc_register_GbGain_V_127(lsc_register_GbGain_V_127),
    .lsc_register_GbGain_V_128(lsc_register_GbGain_V_128),
    .lsc_register_GbGain_V_129(lsc_register_GbGain_V_129),
    .lsc_register_GbGain_V_130(lsc_register_GbGain_V_130),
    .lsc_register_GbGain_V_131(lsc_register_GbGain_V_131),
    .lsc_register_GbGain_V_132(lsc_register_GbGain_V_132),
    .lsc_register_GbGain_V_133(lsc_register_GbGain_V_133),
    .lsc_register_GbGain_V_134(lsc_register_GbGain_V_134),
    .lsc_register_GbGain_V_135(lsc_register_GbGain_V_135),
    .lsc_register_GbGain_V_136(lsc_register_GbGain_V_136),
    .lsc_register_GbGain_V_137(lsc_register_GbGain_V_137),
    .lsc_register_GbGain_V_138(lsc_register_GbGain_V_138),
    .lsc_register_GbGain_V_139(lsc_register_GbGain_V_139),
    .lsc_register_GbGain_V_140(lsc_register_GbGain_V_140),
    .lsc_register_GbGain_V_141(lsc_register_GbGain_V_141),
    .lsc_register_GbGain_V_142(lsc_register_GbGain_V_142),
    .lsc_register_GbGain_V_143(lsc_register_GbGain_V_143),
    .lsc_register_GbGain_V_144(lsc_register_GbGain_V_144),
    .lsc_register_GbGain_V_145(lsc_register_GbGain_V_145),
    .lsc_register_GbGain_V_146(lsc_register_GbGain_V_146),
    .lsc_register_GbGain_V_147(lsc_register_GbGain_V_147),
    .lsc_register_GbGain_V_148(lsc_register_GbGain_V_148),
    .lsc_register_GbGain_V_149(lsc_register_GbGain_V_149),
    .lsc_register_GbGain_V_150(lsc_register_GbGain_V_150),
    .lsc_register_GbGain_V_151(lsc_register_GbGain_V_151),
    .lsc_register_GbGain_V_152(lsc_register_GbGain_V_152),
    .lsc_register_GbGain_V_153(lsc_register_GbGain_V_153),
    .lsc_register_GbGain_V_154(lsc_register_GbGain_V_154),
    .lsc_register_GbGain_V_155(lsc_register_GbGain_V_155),
    .lsc_register_GbGain_V_156(lsc_register_GbGain_V_156),
    .lsc_register_GbGain_V_157(lsc_register_GbGain_V_157),
    .lsc_register_GbGain_V_158(lsc_register_GbGain_V_158),
    .lsc_register_GbGain_V_159(lsc_register_GbGain_V_159),
    .lsc_register_GbGain_V_160(lsc_register_GbGain_V_160),
    .lsc_register_GbGain_V_161(lsc_register_GbGain_V_161),
    .lsc_register_GbGain_V_162(lsc_register_GbGain_V_162),
    .lsc_register_GbGain_V_163(lsc_register_GbGain_V_163),
    .lsc_register_GbGain_V_164(lsc_register_GbGain_V_164),
    .lsc_register_GbGain_V_165(lsc_register_GbGain_V_165),
    .lsc_register_GbGain_V_166(lsc_register_GbGain_V_166),
    .lsc_register_GbGain_V_167(lsc_register_GbGain_V_167),
    .lsc_register_GbGain_V_168(lsc_register_GbGain_V_168),
    .lsc_register_GbGain_V_169(lsc_register_GbGain_V_169),
    .lsc_register_GbGain_V_170(lsc_register_GbGain_V_170),
    .lsc_register_GbGain_V_171(lsc_register_GbGain_V_171),
    .lsc_register_GbGain_V_172(lsc_register_GbGain_V_172),
    .lsc_register_GbGain_V_173(lsc_register_GbGain_V_173),
    .lsc_register_GbGain_V_174(lsc_register_GbGain_V_174),
    .lsc_register_GbGain_V_175(lsc_register_GbGain_V_175),
    .lsc_register_GbGain_V_176(lsc_register_GbGain_V_176),
    .lsc_register_GbGain_V_177(lsc_register_GbGain_V_177),
    .lsc_register_GbGain_V_178(lsc_register_GbGain_V_178),
    .lsc_register_GbGain_V_179(lsc_register_GbGain_V_179),
    .lsc_register_GbGain_V_180(lsc_register_GbGain_V_180),
    .lsc_register_GbGain_V_181(lsc_register_GbGain_V_181),
    .lsc_register_GbGain_V_182(lsc_register_GbGain_V_182),
    .lsc_register_GbGain_V_183(lsc_register_GbGain_V_183),
    .lsc_register_GbGain_V_184(lsc_register_GbGain_V_184),
    .lsc_register_GbGain_V_185(lsc_register_GbGain_V_185),
    .lsc_register_GbGain_V_186(lsc_register_GbGain_V_186),
    .lsc_register_GbGain_V_187(lsc_register_GbGain_V_187),
    .lsc_register_GbGain_V_188(lsc_register_GbGain_V_188),
    .lsc_register_GbGain_V_189(lsc_register_GbGain_V_189),
    .lsc_register_GbGain_V_190(lsc_register_GbGain_V_190),
    .lsc_register_GbGain_V_191(lsc_register_GbGain_V_191),
    .lsc_register_GbGain_V_192(lsc_register_GbGain_V_192),
    .lsc_register_GbGain_V_193(lsc_register_GbGain_V_193),
    .lsc_register_GbGain_V_194(lsc_register_GbGain_V_194),
    .lsc_register_GbGain_V_195(lsc_register_GbGain_V_195),
    .lsc_register_GbGain_V_196(lsc_register_GbGain_V_196),
    .lsc_register_GbGain_V_197(lsc_register_GbGain_V_197),
    .lsc_register_GbGain_V_198(lsc_register_GbGain_V_198),
    .lsc_register_GbGain_V_199(lsc_register_GbGain_V_199),
    .lsc_register_GbGain_V_200(lsc_register_GbGain_V_200),
    .lsc_register_GbGain_V_201(lsc_register_GbGain_V_201),
    .lsc_register_GbGain_V_202(lsc_register_GbGain_V_202),
    .lsc_register_GbGain_V_203(lsc_register_GbGain_V_203),
    .lsc_register_GbGain_V_204(lsc_register_GbGain_V_204),
    .lsc_register_GbGain_V_205(lsc_register_GbGain_V_205),
    .lsc_register_GbGain_V_206(lsc_register_GbGain_V_206),
    .lsc_register_GbGain_V_207(lsc_register_GbGain_V_207),
    .lsc_register_GbGain_V_208(lsc_register_GbGain_V_208),
    .lsc_register_GbGain_V_209(lsc_register_GbGain_V_209),
    .lsc_register_GbGain_V_210(lsc_register_GbGain_V_210),
    .lsc_register_GbGain_V_211(lsc_register_GbGain_V_211),
    .lsc_register_GbGain_V_212(lsc_register_GbGain_V_212),
    .lsc_register_GbGain_V_213(lsc_register_GbGain_V_213),
    .lsc_register_GbGain_V_214(lsc_register_GbGain_V_214),
    .lsc_register_GbGain_V_215(lsc_register_GbGain_V_215),
    .lsc_register_GbGain_V_216(lsc_register_GbGain_V_216),
    .lsc_register_GbGain_V_217(lsc_register_GbGain_V_217),
    .lsc_register_GbGain_V_218(lsc_register_GbGain_V_218),
    .lsc_register_GbGain_V_219(lsc_register_GbGain_V_219),
    .lsc_register_GbGain_V_220(lsc_register_GbGain_V_220),
    .lsc_register_bGain_V_0(lsc_register_bGain_V_0),
    .lsc_register_bGain_V_1(lsc_register_bGain_V_1),
    .lsc_register_bGain_V_2(lsc_register_bGain_V_2),
    .lsc_register_bGain_V_3(lsc_register_bGain_V_3),
    .lsc_register_bGain_V_4(lsc_register_bGain_V_4),
    .lsc_register_bGain_V_5(lsc_register_bGain_V_5),
    .lsc_register_bGain_V_6(lsc_register_bGain_V_6),
    .lsc_register_bGain_V_7(lsc_register_bGain_V_7),
    .lsc_register_bGain_V_8(lsc_register_bGain_V_8),
    .lsc_register_bGain_V_9(lsc_register_bGain_V_9),
    .lsc_register_bGain_V_10(lsc_register_bGain_V_10),
    .lsc_register_bGain_V_11(lsc_register_bGain_V_11),
    .lsc_register_bGain_V_12(lsc_register_bGain_V_12),
    .lsc_register_bGain_V_13(lsc_register_bGain_V_13),
    .lsc_register_bGain_V_14(lsc_register_bGain_V_14),
    .lsc_register_bGain_V_15(lsc_register_bGain_V_15),
    .lsc_register_bGain_V_16(lsc_register_bGain_V_16),
    .lsc_register_bGain_V_17(lsc_register_bGain_V_17),
    .lsc_register_bGain_V_18(lsc_register_bGain_V_18),
    .lsc_register_bGain_V_19(lsc_register_bGain_V_19),
    .lsc_register_bGain_V_20(lsc_register_bGain_V_20),
    .lsc_register_bGain_V_21(lsc_register_bGain_V_21),
    .lsc_register_bGain_V_22(lsc_register_bGain_V_22),
    .lsc_register_bGain_V_23(lsc_register_bGain_V_23),
    .lsc_register_bGain_V_24(lsc_register_bGain_V_24),
    .lsc_register_bGain_V_25(lsc_register_bGain_V_25),
    .lsc_register_bGain_V_26(lsc_register_bGain_V_26),
    .lsc_register_bGain_V_27(lsc_register_bGain_V_27),
    .lsc_register_bGain_V_28(lsc_register_bGain_V_28),
    .lsc_register_bGain_V_29(lsc_register_bGain_V_29),
    .lsc_register_bGain_V_30(lsc_register_bGain_V_30),
    .lsc_register_bGain_V_31(lsc_register_bGain_V_31),
    .lsc_register_bGain_V_32(lsc_register_bGain_V_32),
    .lsc_register_bGain_V_33(lsc_register_bGain_V_33),
    .lsc_register_bGain_V_34(lsc_register_bGain_V_34),
    .lsc_register_bGain_V_35(lsc_register_bGain_V_35),
    .lsc_register_bGain_V_36(lsc_register_bGain_V_36),
    .lsc_register_bGain_V_37(lsc_register_bGain_V_37),
    .lsc_register_bGain_V_38(lsc_register_bGain_V_38),
    .lsc_register_bGain_V_39(lsc_register_bGain_V_39),
    .lsc_register_bGain_V_40(lsc_register_bGain_V_40),
    .lsc_register_bGain_V_41(lsc_register_bGain_V_41),
    .lsc_register_bGain_V_42(lsc_register_bGain_V_42),
    .lsc_register_bGain_V_43(lsc_register_bGain_V_43),
    .lsc_register_bGain_V_44(lsc_register_bGain_V_44),
    .lsc_register_bGain_V_45(lsc_register_bGain_V_45),
    .lsc_register_bGain_V_46(lsc_register_bGain_V_46),
    .lsc_register_bGain_V_47(lsc_register_bGain_V_47),
    .lsc_register_bGain_V_48(lsc_register_bGain_V_48),
    .lsc_register_bGain_V_49(lsc_register_bGain_V_49),
    .lsc_register_bGain_V_50(lsc_register_bGain_V_50),
    .lsc_register_bGain_V_51(lsc_register_bGain_V_51),
    .lsc_register_bGain_V_52(lsc_register_bGain_V_52),
    .lsc_register_bGain_V_53(lsc_register_bGain_V_53),
    .lsc_register_bGain_V_54(lsc_register_bGain_V_54),
    .lsc_register_bGain_V_55(lsc_register_bGain_V_55),
    .lsc_register_bGain_V_56(lsc_register_bGain_V_56),
    .lsc_register_bGain_V_57(lsc_register_bGain_V_57),
    .lsc_register_bGain_V_58(lsc_register_bGain_V_58),
    .lsc_register_bGain_V_59(lsc_register_bGain_V_59),
    .lsc_register_bGain_V_60(lsc_register_bGain_V_60),
    .lsc_register_bGain_V_61(lsc_register_bGain_V_61),
    .lsc_register_bGain_V_62(lsc_register_bGain_V_62),
    .lsc_register_bGain_V_63(lsc_register_bGain_V_63),
    .lsc_register_bGain_V_64(lsc_register_bGain_V_64),
    .lsc_register_bGain_V_65(lsc_register_bGain_V_65),
    .lsc_register_bGain_V_66(lsc_register_bGain_V_66),
    .lsc_register_bGain_V_67(lsc_register_bGain_V_67),
    .lsc_register_bGain_V_68(lsc_register_bGain_V_68),
    .lsc_register_bGain_V_69(lsc_register_bGain_V_69),
    .lsc_register_bGain_V_70(lsc_register_bGain_V_70),
    .lsc_register_bGain_V_71(lsc_register_bGain_V_71),
    .lsc_register_bGain_V_72(lsc_register_bGain_V_72),
    .lsc_register_bGain_V_73(lsc_register_bGain_V_73),
    .lsc_register_bGain_V_74(lsc_register_bGain_V_74),
    .lsc_register_bGain_V_75(lsc_register_bGain_V_75),
    .lsc_register_bGain_V_76(lsc_register_bGain_V_76),
    .lsc_register_bGain_V_77(lsc_register_bGain_V_77),
    .lsc_register_bGain_V_78(lsc_register_bGain_V_78),
    .lsc_register_bGain_V_79(lsc_register_bGain_V_79),
    .lsc_register_bGain_V_80(lsc_register_bGain_V_80),
    .lsc_register_bGain_V_81(lsc_register_bGain_V_81),
    .lsc_register_bGain_V_82(lsc_register_bGain_V_82),
    .lsc_register_bGain_V_83(lsc_register_bGain_V_83),
    .lsc_register_bGain_V_84(lsc_register_bGain_V_84),
    .lsc_register_bGain_V_85(lsc_register_bGain_V_85),
    .lsc_register_bGain_V_86(lsc_register_bGain_V_86),
    .lsc_register_bGain_V_87(lsc_register_bGain_V_87),
    .lsc_register_bGain_V_88(lsc_register_bGain_V_88),
    .lsc_register_bGain_V_89(lsc_register_bGain_V_89),
    .lsc_register_bGain_V_90(lsc_register_bGain_V_90),
    .lsc_register_bGain_V_91(lsc_register_bGain_V_91),
    .lsc_register_bGain_V_92(lsc_register_bGain_V_92),
    .lsc_register_bGain_V_93(lsc_register_bGain_V_93),
    .lsc_register_bGain_V_94(lsc_register_bGain_V_94),
    .lsc_register_bGain_V_95(lsc_register_bGain_V_95),
    .lsc_register_bGain_V_96(lsc_register_bGain_V_96),
    .lsc_register_bGain_V_97(lsc_register_bGain_V_97),
    .lsc_register_bGain_V_98(lsc_register_bGain_V_98),
    .lsc_register_bGain_V_99(lsc_register_bGain_V_99),
    .lsc_register_bGain_V_100(lsc_register_bGain_V_100),
    .lsc_register_bGain_V_101(lsc_register_bGain_V_101),
    .lsc_register_bGain_V_102(lsc_register_bGain_V_102),
    .lsc_register_bGain_V_103(lsc_register_bGain_V_103),
    .lsc_register_bGain_V_104(lsc_register_bGain_V_104),
    .lsc_register_bGain_V_105(lsc_register_bGain_V_105),
    .lsc_register_bGain_V_106(lsc_register_bGain_V_106),
    .lsc_register_bGain_V_107(lsc_register_bGain_V_107),
    .lsc_register_bGain_V_108(lsc_register_bGain_V_108),
    .lsc_register_bGain_V_109(lsc_register_bGain_V_109),
    .lsc_register_bGain_V_110(lsc_register_bGain_V_110),
    .lsc_register_bGain_V_111(lsc_register_bGain_V_111),
    .lsc_register_bGain_V_112(lsc_register_bGain_V_112),
    .lsc_register_bGain_V_113(lsc_register_bGain_V_113),
    .lsc_register_bGain_V_114(lsc_register_bGain_V_114),
    .lsc_register_bGain_V_115(lsc_register_bGain_V_115),
    .lsc_register_bGain_V_116(lsc_register_bGain_V_116),
    .lsc_register_bGain_V_117(lsc_register_bGain_V_117),
    .lsc_register_bGain_V_118(lsc_register_bGain_V_118),
    .lsc_register_bGain_V_119(lsc_register_bGain_V_119),
    .lsc_register_bGain_V_120(lsc_register_bGain_V_120),
    .lsc_register_bGain_V_121(lsc_register_bGain_V_121),
    .lsc_register_bGain_V_122(lsc_register_bGain_V_122),
    .lsc_register_bGain_V_123(lsc_register_bGain_V_123),
    .lsc_register_bGain_V_124(lsc_register_bGain_V_124),
    .lsc_register_bGain_V_125(lsc_register_bGain_V_125),
    .lsc_register_bGain_V_126(lsc_register_bGain_V_126),
    .lsc_register_bGain_V_127(lsc_register_bGain_V_127),
    .lsc_register_bGain_V_128(lsc_register_bGain_V_128),
    .lsc_register_bGain_V_129(lsc_register_bGain_V_129),
    .lsc_register_bGain_V_130(lsc_register_bGain_V_130),
    .lsc_register_bGain_V_131(lsc_register_bGain_V_131),
    .lsc_register_bGain_V_132(lsc_register_bGain_V_132),
    .lsc_register_bGain_V_133(lsc_register_bGain_V_133),
    .lsc_register_bGain_V_134(lsc_register_bGain_V_134),
    .lsc_register_bGain_V_135(lsc_register_bGain_V_135),
    .lsc_register_bGain_V_136(lsc_register_bGain_V_136),
    .lsc_register_bGain_V_137(lsc_register_bGain_V_137),
    .lsc_register_bGain_V_138(lsc_register_bGain_V_138),
    .lsc_register_bGain_V_139(lsc_register_bGain_V_139),
    .lsc_register_bGain_V_140(lsc_register_bGain_V_140),
    .lsc_register_bGain_V_141(lsc_register_bGain_V_141),
    .lsc_register_bGain_V_142(lsc_register_bGain_V_142),
    .lsc_register_bGain_V_143(lsc_register_bGain_V_143),
    .lsc_register_bGain_V_144(lsc_register_bGain_V_144),
    .lsc_register_bGain_V_145(lsc_register_bGain_V_145),
    .lsc_register_bGain_V_146(lsc_register_bGain_V_146),
    .lsc_register_bGain_V_147(lsc_register_bGain_V_147),
    .lsc_register_bGain_V_148(lsc_register_bGain_V_148),
    .lsc_register_bGain_V_149(lsc_register_bGain_V_149),
    .lsc_register_bGain_V_150(lsc_register_bGain_V_150),
    .lsc_register_bGain_V_151(lsc_register_bGain_V_151),
    .lsc_register_bGain_V_152(lsc_register_bGain_V_152),
    .lsc_register_bGain_V_153(lsc_register_bGain_V_153),
    .lsc_register_bGain_V_154(lsc_register_bGain_V_154),
    .lsc_register_bGain_V_155(lsc_register_bGain_V_155),
    .lsc_register_bGain_V_156(lsc_register_bGain_V_156),
    .lsc_register_bGain_V_157(lsc_register_bGain_V_157),
    .lsc_register_bGain_V_158(lsc_register_bGain_V_158),
    .lsc_register_bGain_V_159(lsc_register_bGain_V_159),
    .lsc_register_bGain_V_160(lsc_register_bGain_V_160),
    .lsc_register_bGain_V_161(lsc_register_bGain_V_161),
    .lsc_register_bGain_V_162(lsc_register_bGain_V_162),
    .lsc_register_bGain_V_163(lsc_register_bGain_V_163),
    .lsc_register_bGain_V_164(lsc_register_bGain_V_164),
    .lsc_register_bGain_V_165(lsc_register_bGain_V_165),
    .lsc_register_bGain_V_166(lsc_register_bGain_V_166),
    .lsc_register_bGain_V_167(lsc_register_bGain_V_167),
    .lsc_register_bGain_V_168(lsc_register_bGain_V_168),
    .lsc_register_bGain_V_169(lsc_register_bGain_V_169),
    .lsc_register_bGain_V_170(lsc_register_bGain_V_170),
    .lsc_register_bGain_V_171(lsc_register_bGain_V_171),
    .lsc_register_bGain_V_172(lsc_register_bGain_V_172),
    .lsc_register_bGain_V_173(lsc_register_bGain_V_173),
    .lsc_register_bGain_V_174(lsc_register_bGain_V_174),
    .lsc_register_bGain_V_175(lsc_register_bGain_V_175),
    .lsc_register_bGain_V_176(lsc_register_bGain_V_176),
    .lsc_register_bGain_V_177(lsc_register_bGain_V_177),
    .lsc_register_bGain_V_178(lsc_register_bGain_V_178),
    .lsc_register_bGain_V_179(lsc_register_bGain_V_179),
    .lsc_register_bGain_V_180(lsc_register_bGain_V_180),
    .lsc_register_bGain_V_181(lsc_register_bGain_V_181),
    .lsc_register_bGain_V_182(lsc_register_bGain_V_182),
    .lsc_register_bGain_V_183(lsc_register_bGain_V_183),
    .lsc_register_bGain_V_184(lsc_register_bGain_V_184),
    .lsc_register_bGain_V_185(lsc_register_bGain_V_185),
    .lsc_register_bGain_V_186(lsc_register_bGain_V_186),
    .lsc_register_bGain_V_187(lsc_register_bGain_V_187),
    .lsc_register_bGain_V_188(lsc_register_bGain_V_188),
    .lsc_register_bGain_V_189(lsc_register_bGain_V_189),
    .lsc_register_bGain_V_190(lsc_register_bGain_V_190),
    .lsc_register_bGain_V_191(lsc_register_bGain_V_191),
    .lsc_register_bGain_V_192(lsc_register_bGain_V_192),
    .lsc_register_bGain_V_193(lsc_register_bGain_V_193),
    .lsc_register_bGain_V_194(lsc_register_bGain_V_194),
    .lsc_register_bGain_V_195(lsc_register_bGain_V_195),
    .lsc_register_bGain_V_196(lsc_register_bGain_V_196),
    .lsc_register_bGain_V_197(lsc_register_bGain_V_197),
    .lsc_register_bGain_V_198(lsc_register_bGain_V_198),
    .lsc_register_bGain_V_199(lsc_register_bGain_V_199),
    .lsc_register_bGain_V_200(lsc_register_bGain_V_200),
    .lsc_register_bGain_V_201(lsc_register_bGain_V_201),
    .lsc_register_bGain_V_202(lsc_register_bGain_V_202),
    .lsc_register_bGain_V_203(lsc_register_bGain_V_203),
    .lsc_register_bGain_V_204(lsc_register_bGain_V_204),
    .lsc_register_bGain_V_205(lsc_register_bGain_V_205),
    .lsc_register_bGain_V_206(lsc_register_bGain_V_206),
    .lsc_register_bGain_V_207(lsc_register_bGain_V_207),
    .lsc_register_bGain_V_208(lsc_register_bGain_V_208),
    .lsc_register_bGain_V_209(lsc_register_bGain_V_209),
    .lsc_register_bGain_V_210(lsc_register_bGain_V_210),
    .lsc_register_bGain_V_211(lsc_register_bGain_V_211),
    .lsc_register_bGain_V_212(lsc_register_bGain_V_212),
    .lsc_register_bGain_V_213(lsc_register_bGain_V_213),
    .lsc_register_bGain_V_214(lsc_register_bGain_V_214),
    .lsc_register_bGain_V_215(lsc_register_bGain_V_215),
    .lsc_register_bGain_V_216(lsc_register_bGain_V_216),
    .lsc_register_bGain_V_217(lsc_register_bGain_V_217),
    .lsc_register_bGain_V_218(lsc_register_bGain_V_218),
    .lsc_register_bGain_V_219(lsc_register_bGain_V_219),
    .lsc_register_bGain_V_220(lsc_register_bGain_V_220),
    .lsc_register_blockHeight_V(lsc_register_blockHeight_V),
    .lsc_register_blockWidth_V(lsc_register_blockWidth_V),
    .lsc_register_blockWidth_1_V(lsc_register_blockWidth_1_V),
    .lsc_register_blockHeight_1_V(lsc_register_blockHeight_1_V),
    .dpc_register_eb(dpc_register_eb),
    .dpc_register_th_w_V(dpc_register_th_w_V),
    .dpc_register_th_b_V(dpc_register_th_b_V),
    .rawdns_register_sigma_V(rawdns_register_sigma_V),
    .rawdns_register_eb_V(rawdns_register_eb_V),
    .rawdns_register_Filterpara_V(rawdns_register_Filterpara_V),
    .rawdns_register_invksigma2_V(rawdns_register_invksigma2_V),
    .awb_register_m_nEb(awb_register_m_nEb),
    .awb_register_r_gain_V(awb_register_r_gain_V),
    .awb_register_g_gain_V(awb_register_g_gain_V),
    .awb_register_b_gain_V(awb_register_b_gain_V),
    .awb_register_coeff_V(awb_register_coeff_V),
    .wbc_register_m_nEb(wbc_register_m_nEb),
    .wbc_register_m_nR_V(wbc_register_m_nR_V),
    .wbc_register_m_nGr_V(wbc_register_m_nGr_V),
    .wbc_register_m_nGb_V(wbc_register_m_nGb_V),
    .wbc_register_m_nB_V(wbc_register_m_nB_V),
    .gb_register_eb(gb_register_eb),
    .gb_register_win_size_V(gb_register_win_size_V),
    .gb_register_Lbound_V(gb_register_Lbound_V),
    .gb_register_Hbound_V(gb_register_Hbound_V),
    .gb_register_threhold_V(gb_register_threhold_V),
    .demosaic_register_eb(demosaic_register_eb),
    .ee_register_eb(ee_register_eb),
    .ee_register_coeff_V(ee_register_coeff_V),
    .cmc_register_m_nEb(cmc_register_m_nEb),
    .cmc_register_m_nGain_V_0(cmc_register_m_nGain_V_0),
    .cmc_register_m_nGain_V_1(cmc_register_m_nGain_V_1),
    .cmc_register_m_nGain_V_2(cmc_register_m_nGain_V_2),
    .cmc_register_m_nGain_V_3(cmc_register_m_nGain_V_3),
    .cmc_register_m_nGain_V_4(cmc_register_m_nGain_V_4),
    .cmc_register_m_nGain_V_5(cmc_register_m_nGain_V_5),
    .cmc_register_m_nGain_V_6(cmc_register_m_nGain_V_6),
    .cmc_register_m_nGain_V_7(cmc_register_m_nGain_V_7),
    .cmc_register_m_nGain_V_8(cmc_register_m_nGain_V_8),
    .cmc_register_m_nGain_V_9(cmc_register_m_nGain_V_9),
    .cmc_register_m_nGain_V_10(cmc_register_m_nGain_V_10),
    .cmc_register_m_nGain_V_11(cmc_register_m_nGain_V_11),
    .cmc_register_m_bCFCEnable(cmc_register_m_bCFCEnable),
    .cmc_register_m_bDiscardH(cmc_register_m_bDiscardH),
    .cmc_register_m_pHueRange_V_0(cmc_register_m_pHueRange_V_0),
    .cmc_register_m_pHueRange_V_1(cmc_register_m_pHueRange_V_1),
    .cmc_register_m_nHueBandShift_V(cmc_register_m_nHueBandShift_V),
    .cmc_register_m_nEdgeThre_V(cmc_register_m_nEdgeThre_V),
    .cmc_register_m_nEdgeBandShift_V(cmc_register_m_nEdgeBandShift_V),
    .cmc_register_m_nCFCStrength_V(cmc_register_m_nCFCStrength_V),
    .gtm_register_eb(gtm_register_eb),
    .gtm_register_m_bDitheringEnable(gtm_register_m_bDitheringEnable),
    .gtm_register_gtmTab_V_0(gtm_register_gtmTab_V_0),
    .gtm_register_gtmTab_V_1(gtm_register_gtmTab_V_1),
    .gtm_register_gtmTab_V_2(gtm_register_gtmTab_V_2),
    .gtm_register_gtmTab_V_3(gtm_register_gtmTab_V_3),
    .gtm_register_gtmTab_V_4(gtm_register_gtmTab_V_4),
    .gtm_register_gtmTab_V_5(gtm_register_gtmTab_V_5),
    .gtm_register_gtmTab_V_6(gtm_register_gtmTab_V_6),
    .gtm_register_gtmTab_V_7(gtm_register_gtmTab_V_7),
    .gtm_register_gtmTab_V_8(gtm_register_gtmTab_V_8),
    .gtm_register_gtmTab_V_9(gtm_register_gtmTab_V_9),
    .gtm_register_gtmTab_V_10(gtm_register_gtmTab_V_10),
    .gtm_register_gtmTab_V_11(gtm_register_gtmTab_V_11),
    .gtm_register_gtmTab_V_12(gtm_register_gtmTab_V_12),
    .gtm_register_gtmTab_V_13(gtm_register_gtmTab_V_13),
    .gtm_register_gtmTab_V_14(gtm_register_gtmTab_V_14),
    .gtm_register_gtmTab_V_15(gtm_register_gtmTab_V_15),
    .gtm_register_gtmTab_V_16(gtm_register_gtmTab_V_16),
    .gtm_register_gtmTab_V_17(gtm_register_gtmTab_V_17),
    .gtm_register_gtmTab_V_18(gtm_register_gtmTab_V_18),
    .gtm_register_gtmTab_V_19(gtm_register_gtmTab_V_19),
    .gtm_register_gtmTab_V_20(gtm_register_gtmTab_V_20),
    .gtm_register_gtmTab_V_21(gtm_register_gtmTab_V_21),
    .gtm_register_gtmTab_V_22(gtm_register_gtmTab_V_22),
    .gtm_register_gtmTab_V_23(gtm_register_gtmTab_V_23),
    .gtm_register_gtmTab_V_24(gtm_register_gtmTab_V_24),
    .gtm_register_gtmTab_V_25(gtm_register_gtmTab_V_25),
    .gtm_register_gtmTab_V_26(gtm_register_gtmTab_V_26),
    .gtm_register_gtmTab_V_27(gtm_register_gtmTab_V_27),
    .gtm_register_gtmTab_V_28(gtm_register_gtmTab_V_28),
    .gtm_register_gtmTab_V_29(gtm_register_gtmTab_V_29),
    .gtm_register_gtmTab_V_30(gtm_register_gtmTab_V_30),
    .gtm_register_gtmTab_V_31(gtm_register_gtmTab_V_31),
    .gtm_register_gtmTab_V_32(gtm_register_gtmTab_V_32),
    .gtm_register_gtmTab_V_33(gtm_register_gtmTab_V_33),
    .gtm_register_gtmTab_V_34(gtm_register_gtmTab_V_34),
    .gtm_register_gtmTab_V_35(gtm_register_gtmTab_V_35),
    .gtm_register_gtmTab_V_36(gtm_register_gtmTab_V_36),
    .gtm_register_gtmTab_V_37(gtm_register_gtmTab_V_37),
    .gtm_register_gtmTab_V_38(gtm_register_gtmTab_V_38),
    .gtm_register_gtmTab_V_39(gtm_register_gtmTab_V_39),
    .gtm_register_gtmTab_V_40(gtm_register_gtmTab_V_40),
    .gtm_register_gtmTab_V_41(gtm_register_gtmTab_V_41),
    .gtm_register_gtmTab_V_42(gtm_register_gtmTab_V_42),
    .gtm_register_gtmTab_V_43(gtm_register_gtmTab_V_43),
    .gtm_register_gtmTab_V_44(gtm_register_gtmTab_V_44),
    .gtm_register_gtmTab_V_45(gtm_register_gtmTab_V_45),
    .gtm_register_gtmTab_V_46(gtm_register_gtmTab_V_46),
    .gtm_register_gtmTab_V_47(gtm_register_gtmTab_V_47),
    .gtm_register_gtmTab_V_48(gtm_register_gtmTab_V_48),
    .gtm_register_gtmTab_V_49(gtm_register_gtmTab_V_49),
    .gtm_register_gtmTab_V_50(gtm_register_gtmTab_V_50),
    .gtm_register_gtmTab_V_51(gtm_register_gtmTab_V_51),
    .gtm_register_gtmTab_V_52(gtm_register_gtmTab_V_52),
    .gtm_register_gtmTab_V_53(gtm_register_gtmTab_V_53),
    .gtm_register_gtmTab_V_54(gtm_register_gtmTab_V_54),
    .gtm_register_gtmTab_V_55(gtm_register_gtmTab_V_55),
    .gtm_register_gtmTab_V_56(gtm_register_gtmTab_V_56),
    .gtm_register_gtmTab_V_57(gtm_register_gtmTab_V_57),
    .gtm_register_gtmTab_V_58(gtm_register_gtmTab_V_58),
    .gtm_register_gtmTab_V_59(gtm_register_gtmTab_V_59),
    .gtm_register_gtmTab_V_60(gtm_register_gtmTab_V_60),
    .gtm_register_gtmTab_V_61(gtm_register_gtmTab_V_61),
    .gtm_register_gtmTab_V_62(gtm_register_gtmTab_V_62),
    .gtm_register_gtmTab_V_63(gtm_register_gtmTab_V_63),
    .gtm_register_gtmTab_V_64(gtm_register_gtmTab_V_64),
    .gtm_register_gtmTab_V_65(gtm_register_gtmTab_V_65),
    .gtm_register_gtmTab_V_66(gtm_register_gtmTab_V_66),
    .gtm_register_gtmTab_V_67(gtm_register_gtmTab_V_67),
    .gtm_register_gtmTab_V_68(gtm_register_gtmTab_V_68),
    .gtm_register_gtmTab_V_69(gtm_register_gtmTab_V_69),
    .gtm_register_gtmTab_V_70(gtm_register_gtmTab_V_70),
    .gtm_register_gtmTab_V_71(gtm_register_gtmTab_V_71),
    .gtm_register_gtmTab_V_72(gtm_register_gtmTab_V_72),
    .gtm_register_gtmTab_V_73(gtm_register_gtmTab_V_73),
    .gtm_register_gtmTab_V_74(gtm_register_gtmTab_V_74),
    .gtm_register_gtmTab_V_75(gtm_register_gtmTab_V_75),
    .gtm_register_gtmTab_V_76(gtm_register_gtmTab_V_76),
    .gtm_register_gtmTab_V_77(gtm_register_gtmTab_V_77),
    .gtm_register_gtmTab_V_78(gtm_register_gtmTab_V_78),
    .gtm_register_gtmTab_V_79(gtm_register_gtmTab_V_79),
    .gtm_register_gtmTab_V_80(gtm_register_gtmTab_V_80),
    .gtm_register_gtmTab_V_81(gtm_register_gtmTab_V_81),
    .gtm_register_gtmTab_V_82(gtm_register_gtmTab_V_82),
    .gtm_register_gtmTab_V_83(gtm_register_gtmTab_V_83),
    .gtm_register_gtmTab_V_84(gtm_register_gtmTab_V_84),
    .gtm_register_gtmTab_V_85(gtm_register_gtmTab_V_85),
    .gtm_register_gtmTab_V_86(gtm_register_gtmTab_V_86),
    .gtm_register_gtmTab_V_87(gtm_register_gtmTab_V_87),
    .gtm_register_gtmTab_V_88(gtm_register_gtmTab_V_88),
    .gtm_register_gtmTab_V_89(gtm_register_gtmTab_V_89),
    .gtm_register_gtmTab_V_90(gtm_register_gtmTab_V_90),
    .gtm_register_gtmTab_V_91(gtm_register_gtmTab_V_91),
    .gtm_register_gtmTab_V_92(gtm_register_gtmTab_V_92),
    .gtm_register_gtmTab_V_93(gtm_register_gtmTab_V_93),
    .gtm_register_gtmTab_V_94(gtm_register_gtmTab_V_94),
    .gtm_register_gtmTab_V_95(gtm_register_gtmTab_V_95),
    .gtm_register_gtmTab_V_96(gtm_register_gtmTab_V_96),
    .gtm_register_gtmTab_V_97(gtm_register_gtmTab_V_97),
    .gtm_register_gtmTab_V_98(gtm_register_gtmTab_V_98),
    .gtm_register_gtmTab_V_99(gtm_register_gtmTab_V_99),
    .gtm_register_gtmTab_V_100(gtm_register_gtmTab_V_100),
    .gtm_register_gtmTab_V_101(gtm_register_gtmTab_V_101),
    .gtm_register_gtmTab_V_102(gtm_register_gtmTab_V_102),
    .gtm_register_gtmTab_V_103(gtm_register_gtmTab_V_103),
    .gtm_register_gtmTab_V_104(gtm_register_gtmTab_V_104),
    .gtm_register_gtmTab_V_105(gtm_register_gtmTab_V_105),
    .gtm_register_gtmTab_V_106(gtm_register_gtmTab_V_106),
    .gtm_register_gtmTab_V_107(gtm_register_gtmTab_V_107),
    .gtm_register_gtmTab_V_108(gtm_register_gtmTab_V_108),
    .gtm_register_gtmTab_V_109(gtm_register_gtmTab_V_109),
    .gtm_register_gtmTab_V_110(gtm_register_gtmTab_V_110),
    .gtm_register_gtmTab_V_111(gtm_register_gtmTab_V_111),
    .gtm_register_gtmTab_V_112(gtm_register_gtmTab_V_112),
    .gtm_register_gtmTab_V_113(gtm_register_gtmTab_V_113),
    .gtm_register_gtmTab_V_114(gtm_register_gtmTab_V_114),
    .gtm_register_gtmTab_V_115(gtm_register_gtmTab_V_115),
    .gtm_register_gtmTab_V_116(gtm_register_gtmTab_V_116),
    .gtm_register_gtmTab_V_117(gtm_register_gtmTab_V_117),
    .gtm_register_gtmTab_V_118(gtm_register_gtmTab_V_118),
    .gtm_register_gtmTab_V_119(gtm_register_gtmTab_V_119),
    .gtm_register_gtmTab_V_120(gtm_register_gtmTab_V_120),
    .gtm_register_gtmTab_V_121(gtm_register_gtmTab_V_121),
    .gtm_register_gtmTab_V_122(gtm_register_gtmTab_V_122),
    .gtm_register_gtmTab_V_123(gtm_register_gtmTab_V_123),
    .gtm_register_gtmTab_V_124(gtm_register_gtmTab_V_124),
    .gtm_register_gtmTab_V_125(gtm_register_gtmTab_V_125),
    .gtm_register_gtmTab_V_126(gtm_register_gtmTab_V_126),
    .gtm_register_gtmTab_V_127(gtm_register_gtmTab_V_127),
    .gtm_register_gtmTab_V_128(gtm_register_gtmTab_V_128),
    .ltm_register_m_nEb_V(ltm_register_m_nEb_V),
    .ltm_register_contrast_V(ltm_register_contrast_V),
    .ltm_register_ratio_V(ltm_register_ratio_V),
    .cac_register_eb(cac_register_eb),
    .cac_register_t_transient_V(cac_register_t_transient_V),
    .cac_register_t_edge_V(cac_register_t_edge_V),
    .csc_register_m_nEb(csc_register_m_nEb),
    .csc_register_coeff_V_0(csc_register_coeff_V_0),
    .csc_register_coeff_V_1(csc_register_coeff_V_1),
    .csc_register_coeff_V_2(csc_register_coeff_V_2),
    .csc_register_coeff_V_3(csc_register_coeff_V_3),
    .csc_register_coeff_V_4(csc_register_coeff_V_4),
    .csc_register_coeff_V_5(csc_register_coeff_V_5),
    .csc_register_coeff_V_6(csc_register_coeff_V_6),
    .csc_register_coeff_V_7(csc_register_coeff_V_7),
    .csc_register_coeff_V_8(csc_register_coeff_V_8),
    .csc_register_coeff_V_9(csc_register_coeff_V_9),
    .csc_register_coeff_V_10(csc_register_coeff_V_10),
    .csc_register_coeff_V_11(csc_register_coeff_V_11),
    .yfc_register_m_nEb(yfc_register_m_nEb),
    .yfc_register_yuvpattern(yfc_register_yuvpattern),
    .yuvdns_register_eb_V(yuvdns_register_eb_V),
    .yuvdns_register_ysigma2_V(yuvdns_register_ysigma2_V),
    .yuvdns_register_yinvsigma2_V(yuvdns_register_yinvsigma2_V),
    .yuvdns_register_uvsigma2_V(yuvdns_register_uvsigma2_V),
    .yuvdns_register_uvinvsigma2_V(yuvdns_register_uvinvsigma2_V),
    .yuvdns_register_yfilt_V(yuvdns_register_yfilt_V),
    .yuvdns_register_uvfilt_V(yuvdns_register_uvfilt_V),
    .yuvdns_register_yinvfilt_V(yuvdns_register_yinvfilt_V),
    .yuvdns_register_uvinvfilt_V(yuvdns_register_uvinvfilt_V),
    .yuvdns_register_yH2_V(yuvdns_register_yH2_V),
    .yuvdns_register_yinvH2_V(yuvdns_register_yinvH2_V),
    .yuvdns_register_uvH2_V(yuvdns_register_uvH2_V),
    .yuvdns_register_uvinvH2_V(yuvdns_register_uvinvH2_V),
    .scaledown_register_m_nEb(scaledown_register_m_nEb),
    .scaledown_register_yuvpattern_V(scaledown_register_yuvpattern_V),
    .scaledown_register_times_V(scaledown_register_times_V),
    .crop_register_m_nEb(crop_register_m_nEb),
    .crop_register_upper_left_x_V(crop_register_upper_left_x_V),
    .crop_register_upper_left_y_V(crop_register_upper_left_y_V),
    .crop_register_lower_right_x_V(crop_register_lower_right_x_V),
    .crop_register_lower_right_y_V(crop_register_lower_right_y_V),
    .crop_register_yuvpattern_V(crop_register_yuvpattern_V),
    .ap_start(ap_start),
    .ap_done(ap_done),
    .ap_ready(ap_ready),
    .ap_idle(ap_idle)
);

// ap_start must hold high until ap_ready=1 
     localparam 
         IDLE  =2'b00,
         START =2'd1,
         RUN   =2'd2;
     reg [1:0] ip_state=IDLE;
     reg [1:0] ip_next;

     assign ap_start=(ip_state==START)?1'b1:1'b0;
     
     always@(posedge CLK)begin
         if(!RST_N)
             ip_state <= IDLE;
         else 
             ip_state <= ip_next;
     end

     always@(*) begin
         case(ip_state)
             IDLE: 
                 if(!full_n)
                      ip_next=START;
             START:
                 if(ap_ready)
                      ip_next=RUN;
             RUN:
                 if(ap_done)
                      ip_next=IDLE;
             default:
                 ip_next=IDLE;
          endcase
    end
         
         


isp_saxil #(
    C_S_AXI_ADDR_WIDTH (10),
    C_S_AXI_DATA_WIDTH (32)
)
isp_saxil_U0(
    .ACLK(CLK),
    .ARESET(RST_N),
    .ACLK_EN(1'b1),
    .AWADDR(S_AXIL_AWADDR),
    .AWVALID(S_AXIL_AWVALID),
    .AWREADY(S_AXIL_AWREADY),
    .WDATA(S_AXIL_WDATA),
    .WSTRB(S_AXIL_WSTRB),
    .WVALID(S_AXIL_WVALID),
    .WREADY(S_AXIL_WREADY),
    .BRESP(S_AXIL_BRESP),
    .BVALID(S_AXIL_BVALID),
    .BREADY(S_AXIL_BREADY),
    .ARADDR(S_AXIL_ARADDR),
    .ARVALID(S_AXIL_ARVALID),
    .ARREADY(S_AXIL_ARREADY),
    .RDATA(S_AXIL_RDATA),
    .RRESP(S_AXIL_RRESP),
    .RVALID(S_AXIL_RVALID),
    .RREADY(S_AXIL_RREADY),
    .read_start(READ_START),
    .ap_done(ap_done),
    .ap_ready(ap_ready),
    .ap_idle(ap_idle),
    .top_register_frameWidth_V(top_register_frameWidth_V),
    .top_register_frameHeight_V(top_register_frameHeight_V),
    .top_register_inputFormat(top_register_inputFormat),
    .top_register_imgPattern_V(top_register_imgPattern_V),
    .top_register_pipeMode_V(top_register_pipeMode_V),
    .top_register_blc_V(top_register_blc_V),
    .top_register_shadowEb(top_register_shadowEb),
    .top_register_binningFrameWidth_V(top_register_binningFrameWidth_V),
    .top_register_binningFrameHeight_V(top_register_binningFrameHeight_V),
    .top_register_scalerFrameWidth_V(top_register_scalerFrameWidth_V),
    .top_register_scalerFrameHeight_V(top_register_scalerFrameHeight_V),
    .tpg_register_m_bTPG_en(tpg_register_m_bTPG_en),
    .tpg_register_m_nWidth_V(tpg_register_m_nWidth_V),
    .tpg_register_m_nHeight_V(tpg_register_m_nHeight_V),
    .tpg_register_m_nCFAPattern_V(tpg_register_m_nCFAPattern_V),
    .tpg_register_m_bRollingEnable(tpg_register_m_bRollingEnable),
    .tpg_register_m_bSensor_timing_en(tpg_register_m_bSensor_timing_en),
    .tpg_register_m_nVBlank_num_V(tpg_register_m_nVBlank_num_V),
    .tpg_register_m_nHBlank_num_V(tpg_register_m_nHBlank_num_V),
    .tpg_register_m_valid_blank_V(tpg_register_m_valid_blank_V),
    .tpg_register_m_nID_V(tpg_register_m_nID_V),
    .dgain_register_m_nEb(dgain_register_m_nEb),
    .dgain_register_m_nBlcR_V(dgain_register_m_nBlcR_V),
    .dgain_register_m_nBlcGr_V(dgain_register_m_nBlcGr_V),
    .dgain_register_m_nBlcGb_V(dgain_register_m_nBlcGb_V),
    .dgain_register_m_nBlcB_V(dgain_register_m_nBlcB_V),
    .dgain_register_m_nR_V(dgain_register_m_nR_V),
    .dgain_register_m_nGr_V(dgain_register_m_nGr_V),
    .dgain_register_m_nGb_V(dgain_register_m_nGb_V),
    .dgain_register_m_nB_V(dgain_register_m_nB_V),
    .lsc_register_eb(lsc_register_eb),
    .lsc_register_rGain_V_0(lsc_register_rGain_V_0),
    .lsc_register_rGain_V_1(lsc_register_rGain_V_1),
    .lsc_register_rGain_V_2(lsc_register_rGain_V_2),
    .lsc_register_rGain_V_3(lsc_register_rGain_V_3),
    .lsc_register_rGain_V_4(lsc_register_rGain_V_4),
    .lsc_register_rGain_V_5(lsc_register_rGain_V_5),
    .lsc_register_rGain_V_6(lsc_register_rGain_V_6),
    .lsc_register_rGain_V_7(lsc_register_rGain_V_7),
    .lsc_register_rGain_V_8(lsc_register_rGain_V_8),
    .lsc_register_rGain_V_9(lsc_register_rGain_V_9),
    .lsc_register_rGain_V_10(lsc_register_rGain_V_10),
    .lsc_register_rGain_V_11(lsc_register_rGain_V_11),
    .lsc_register_rGain_V_12(lsc_register_rGain_V_12),
    .lsc_register_rGain_V_13(lsc_register_rGain_V_13),
    .lsc_register_rGain_V_14(lsc_register_rGain_V_14),
    .lsc_register_rGain_V_15(lsc_register_rGain_V_15),
    .lsc_register_rGain_V_16(lsc_register_rGain_V_16),
    .lsc_register_rGain_V_17(lsc_register_rGain_V_17),
    .lsc_register_rGain_V_18(lsc_register_rGain_V_18),
    .lsc_register_rGain_V_19(lsc_register_rGain_V_19),
    .lsc_register_rGain_V_20(lsc_register_rGain_V_20),
    .lsc_register_rGain_V_21(lsc_register_rGain_V_21),
    .lsc_register_rGain_V_22(lsc_register_rGain_V_22),
    .lsc_register_rGain_V_23(lsc_register_rGain_V_23),
    .lsc_register_rGain_V_24(lsc_register_rGain_V_24),
    .lsc_register_rGain_V_25(lsc_register_rGain_V_25),
    .lsc_register_rGain_V_26(lsc_register_rGain_V_26),
    .lsc_register_rGain_V_27(lsc_register_rGain_V_27),
    .lsc_register_rGain_V_28(lsc_register_rGain_V_28),
    .lsc_register_rGain_V_29(lsc_register_rGain_V_29),
    .lsc_register_rGain_V_30(lsc_register_rGain_V_30),
    .lsc_register_rGain_V_31(lsc_register_rGain_V_31),
    .lsc_register_rGain_V_32(lsc_register_rGain_V_32),
    .lsc_register_rGain_V_33(lsc_register_rGain_V_33),
    .lsc_register_rGain_V_34(lsc_register_rGain_V_34),
    .lsc_register_rGain_V_35(lsc_register_rGain_V_35),
    .lsc_register_rGain_V_36(lsc_register_rGain_V_36),
    .lsc_register_rGain_V_37(lsc_register_rGain_V_37),
    .lsc_register_rGain_V_38(lsc_register_rGain_V_38),
    .lsc_register_rGain_V_39(lsc_register_rGain_V_39),
    .lsc_register_rGain_V_40(lsc_register_rGain_V_40),
    .lsc_register_rGain_V_41(lsc_register_rGain_V_41),
    .lsc_register_rGain_V_42(lsc_register_rGain_V_42),
    .lsc_register_rGain_V_43(lsc_register_rGain_V_43),
    .lsc_register_rGain_V_44(lsc_register_rGain_V_44),
    .lsc_register_rGain_V_45(lsc_register_rGain_V_45),
    .lsc_register_rGain_V_46(lsc_register_rGain_V_46),
    .lsc_register_rGain_V_47(lsc_register_rGain_V_47),
    .lsc_register_rGain_V_48(lsc_register_rGain_V_48),
    .lsc_register_rGain_V_49(lsc_register_rGain_V_49),
    .lsc_register_rGain_V_50(lsc_register_rGain_V_50),
    .lsc_register_rGain_V_51(lsc_register_rGain_V_51),
    .lsc_register_rGain_V_52(lsc_register_rGain_V_52),
    .lsc_register_rGain_V_53(lsc_register_rGain_V_53),
    .lsc_register_rGain_V_54(lsc_register_rGain_V_54),
    .lsc_register_rGain_V_55(lsc_register_rGain_V_55),
    .lsc_register_rGain_V_56(lsc_register_rGain_V_56),
    .lsc_register_rGain_V_57(lsc_register_rGain_V_57),
    .lsc_register_rGain_V_58(lsc_register_rGain_V_58),
    .lsc_register_rGain_V_59(lsc_register_rGain_V_59),
    .lsc_register_rGain_V_60(lsc_register_rGain_V_60),
    .lsc_register_rGain_V_61(lsc_register_rGain_V_61),
    .lsc_register_rGain_V_62(lsc_register_rGain_V_62),
    .lsc_register_rGain_V_63(lsc_register_rGain_V_63),
    .lsc_register_rGain_V_64(lsc_register_rGain_V_64),
    .lsc_register_rGain_V_65(lsc_register_rGain_V_65),
    .lsc_register_rGain_V_66(lsc_register_rGain_V_66),
    .lsc_register_rGain_V_67(lsc_register_rGain_V_67),
    .lsc_register_rGain_V_68(lsc_register_rGain_V_68),
    .lsc_register_rGain_V_69(lsc_register_rGain_V_69),
    .lsc_register_rGain_V_70(lsc_register_rGain_V_70),
    .lsc_register_rGain_V_71(lsc_register_rGain_V_71),
    .lsc_register_rGain_V_72(lsc_register_rGain_V_72),
    .lsc_register_rGain_V_73(lsc_register_rGain_V_73),
    .lsc_register_rGain_V_74(lsc_register_rGain_V_74),
    .lsc_register_rGain_V_75(lsc_register_rGain_V_75),
    .lsc_register_rGain_V_76(lsc_register_rGain_V_76),
    .lsc_register_rGain_V_77(lsc_register_rGain_V_77),
    .lsc_register_rGain_V_78(lsc_register_rGain_V_78),
    .lsc_register_rGain_V_79(lsc_register_rGain_V_79),
    .lsc_register_rGain_V_80(lsc_register_rGain_V_80),
    .lsc_register_rGain_V_81(lsc_register_rGain_V_81),
    .lsc_register_rGain_V_82(lsc_register_rGain_V_82),
    .lsc_register_rGain_V_83(lsc_register_rGain_V_83),
    .lsc_register_rGain_V_84(lsc_register_rGain_V_84),
    .lsc_register_rGain_V_85(lsc_register_rGain_V_85),
    .lsc_register_rGain_V_86(lsc_register_rGain_V_86),
    .lsc_register_rGain_V_87(lsc_register_rGain_V_87),
    .lsc_register_rGain_V_88(lsc_register_rGain_V_88),
    .lsc_register_rGain_V_89(lsc_register_rGain_V_89),
    .lsc_register_rGain_V_90(lsc_register_rGain_V_90),
    .lsc_register_rGain_V_91(lsc_register_rGain_V_91),
    .lsc_register_rGain_V_92(lsc_register_rGain_V_92),
    .lsc_register_rGain_V_93(lsc_register_rGain_V_93),
    .lsc_register_rGain_V_94(lsc_register_rGain_V_94),
    .lsc_register_rGain_V_95(lsc_register_rGain_V_95),
    .lsc_register_rGain_V_96(lsc_register_rGain_V_96),
    .lsc_register_rGain_V_97(lsc_register_rGain_V_97),
    .lsc_register_rGain_V_98(lsc_register_rGain_V_98),
    .lsc_register_rGain_V_99(lsc_register_rGain_V_99),
    .lsc_register_rGain_V_100(lsc_register_rGain_V_100),
    .lsc_register_rGain_V_101(lsc_register_rGain_V_101),
    .lsc_register_rGain_V_102(lsc_register_rGain_V_102),
    .lsc_register_rGain_V_103(lsc_register_rGain_V_103),
    .lsc_register_rGain_V_104(lsc_register_rGain_V_104),
    .lsc_register_rGain_V_105(lsc_register_rGain_V_105),
    .lsc_register_rGain_V_106(lsc_register_rGain_V_106),
    .lsc_register_rGain_V_107(lsc_register_rGain_V_107),
    .lsc_register_rGain_V_108(lsc_register_rGain_V_108),
    .lsc_register_rGain_V_109(lsc_register_rGain_V_109),
    .lsc_register_rGain_V_110(lsc_register_rGain_V_110),
    .lsc_register_rGain_V_111(lsc_register_rGain_V_111),
    .lsc_register_rGain_V_112(lsc_register_rGain_V_112),
    .lsc_register_rGain_V_113(lsc_register_rGain_V_113),
    .lsc_register_rGain_V_114(lsc_register_rGain_V_114),
    .lsc_register_rGain_V_115(lsc_register_rGain_V_115),
    .lsc_register_rGain_V_116(lsc_register_rGain_V_116),
    .lsc_register_rGain_V_117(lsc_register_rGain_V_117),
    .lsc_register_rGain_V_118(lsc_register_rGain_V_118),
    .lsc_register_rGain_V_119(lsc_register_rGain_V_119),
    .lsc_register_rGain_V_120(lsc_register_rGain_V_120),
    .lsc_register_rGain_V_121(lsc_register_rGain_V_121),
    .lsc_register_rGain_V_122(lsc_register_rGain_V_122),
    .lsc_register_rGain_V_123(lsc_register_rGain_V_123),
    .lsc_register_rGain_V_124(lsc_register_rGain_V_124),
    .lsc_register_rGain_V_125(lsc_register_rGain_V_125),
    .lsc_register_rGain_V_126(lsc_register_rGain_V_126),
    .lsc_register_rGain_V_127(lsc_register_rGain_V_127),
    .lsc_register_rGain_V_128(lsc_register_rGain_V_128),
    .lsc_register_rGain_V_129(lsc_register_rGain_V_129),
    .lsc_register_rGain_V_130(lsc_register_rGain_V_130),
    .lsc_register_rGain_V_131(lsc_register_rGain_V_131),
    .lsc_register_rGain_V_132(lsc_register_rGain_V_132),
    .lsc_register_rGain_V_133(lsc_register_rGain_V_133),
    .lsc_register_rGain_V_134(lsc_register_rGain_V_134),
    .lsc_register_rGain_V_135(lsc_register_rGain_V_135),
    .lsc_register_rGain_V_136(lsc_register_rGain_V_136),
    .lsc_register_rGain_V_137(lsc_register_rGain_V_137),
    .lsc_register_rGain_V_138(lsc_register_rGain_V_138),
    .lsc_register_rGain_V_139(lsc_register_rGain_V_139),
    .lsc_register_rGain_V_140(lsc_register_rGain_V_140),
    .lsc_register_rGain_V_141(lsc_register_rGain_V_141),
    .lsc_register_rGain_V_142(lsc_register_rGain_V_142),
    .lsc_register_rGain_V_143(lsc_register_rGain_V_143),
    .lsc_register_rGain_V_144(lsc_register_rGain_V_144),
    .lsc_register_rGain_V_145(lsc_register_rGain_V_145),
    .lsc_register_rGain_V_146(lsc_register_rGain_V_146),
    .lsc_register_rGain_V_147(lsc_register_rGain_V_147),
    .lsc_register_rGain_V_148(lsc_register_rGain_V_148),
    .lsc_register_rGain_V_149(lsc_register_rGain_V_149),
    .lsc_register_rGain_V_150(lsc_register_rGain_V_150),
    .lsc_register_rGain_V_151(lsc_register_rGain_V_151),
    .lsc_register_rGain_V_152(lsc_register_rGain_V_152),
    .lsc_register_rGain_V_153(lsc_register_rGain_V_153),
    .lsc_register_rGain_V_154(lsc_register_rGain_V_154),
    .lsc_register_rGain_V_155(lsc_register_rGain_V_155),
    .lsc_register_rGain_V_156(lsc_register_rGain_V_156),
    .lsc_register_rGain_V_157(lsc_register_rGain_V_157),
    .lsc_register_rGain_V_158(lsc_register_rGain_V_158),
    .lsc_register_rGain_V_159(lsc_register_rGain_V_159),
    .lsc_register_rGain_V_160(lsc_register_rGain_V_160),
    .lsc_register_rGain_V_161(lsc_register_rGain_V_161),
    .lsc_register_rGain_V_162(lsc_register_rGain_V_162),
    .lsc_register_rGain_V_163(lsc_register_rGain_V_163),
    .lsc_register_rGain_V_164(lsc_register_rGain_V_164),
    .lsc_register_rGain_V_165(lsc_register_rGain_V_165),
    .lsc_register_rGain_V_166(lsc_register_rGain_V_166),
    .lsc_register_rGain_V_167(lsc_register_rGain_V_167),
    .lsc_register_rGain_V_168(lsc_register_rGain_V_168),
    .lsc_register_rGain_V_169(lsc_register_rGain_V_169),
    .lsc_register_rGain_V_170(lsc_register_rGain_V_170),
    .lsc_register_rGain_V_171(lsc_register_rGain_V_171),
    .lsc_register_rGain_V_172(lsc_register_rGain_V_172),
    .lsc_register_rGain_V_173(lsc_register_rGain_V_173),
    .lsc_register_rGain_V_174(lsc_register_rGain_V_174),
    .lsc_register_rGain_V_175(lsc_register_rGain_V_175),
    .lsc_register_rGain_V_176(lsc_register_rGain_V_176),
    .lsc_register_rGain_V_177(lsc_register_rGain_V_177),
    .lsc_register_rGain_V_178(lsc_register_rGain_V_178),
    .lsc_register_rGain_V_179(lsc_register_rGain_V_179),
    .lsc_register_rGain_V_180(lsc_register_rGain_V_180),
    .lsc_register_rGain_V_181(lsc_register_rGain_V_181),
    .lsc_register_rGain_V_182(lsc_register_rGain_V_182),
    .lsc_register_rGain_V_183(lsc_register_rGain_V_183),
    .lsc_register_rGain_V_184(lsc_register_rGain_V_184),
    .lsc_register_rGain_V_185(lsc_register_rGain_V_185),
    .lsc_register_rGain_V_186(lsc_register_rGain_V_186),
    .lsc_register_rGain_V_187(lsc_register_rGain_V_187),
    .lsc_register_rGain_V_188(lsc_register_rGain_V_188),
    .lsc_register_rGain_V_189(lsc_register_rGain_V_189),
    .lsc_register_rGain_V_190(lsc_register_rGain_V_190),
    .lsc_register_rGain_V_191(lsc_register_rGain_V_191),
    .lsc_register_rGain_V_192(lsc_register_rGain_V_192),
    .lsc_register_rGain_V_193(lsc_register_rGain_V_193),
    .lsc_register_rGain_V_194(lsc_register_rGain_V_194),
    .lsc_register_rGain_V_195(lsc_register_rGain_V_195),
    .lsc_register_rGain_V_196(lsc_register_rGain_V_196),
    .lsc_register_rGain_V_197(lsc_register_rGain_V_197),
    .lsc_register_rGain_V_198(lsc_register_rGain_V_198),
    .lsc_register_rGain_V_199(lsc_register_rGain_V_199),
    .lsc_register_rGain_V_200(lsc_register_rGain_V_200),
    .lsc_register_rGain_V_201(lsc_register_rGain_V_201),
    .lsc_register_rGain_V_202(lsc_register_rGain_V_202),
    .lsc_register_rGain_V_203(lsc_register_rGain_V_203),
    .lsc_register_rGain_V_204(lsc_register_rGain_V_204),
    .lsc_register_rGain_V_205(lsc_register_rGain_V_205),
    .lsc_register_rGain_V_206(lsc_register_rGain_V_206),
    .lsc_register_rGain_V_207(lsc_register_rGain_V_207),
    .lsc_register_rGain_V_208(lsc_register_rGain_V_208),
    .lsc_register_rGain_V_209(lsc_register_rGain_V_209),
    .lsc_register_rGain_V_210(lsc_register_rGain_V_210),
    .lsc_register_rGain_V_211(lsc_register_rGain_V_211),
    .lsc_register_rGain_V_212(lsc_register_rGain_V_212),
    .lsc_register_rGain_V_213(lsc_register_rGain_V_213),
    .lsc_register_rGain_V_214(lsc_register_rGain_V_214),
    .lsc_register_rGain_V_215(lsc_register_rGain_V_215),
    .lsc_register_rGain_V_216(lsc_register_rGain_V_216),
    .lsc_register_rGain_V_217(lsc_register_rGain_V_217),
    .lsc_register_rGain_V_218(lsc_register_rGain_V_218),
    .lsc_register_rGain_V_219(lsc_register_rGain_V_219),
    .lsc_register_rGain_V_220(lsc_register_rGain_V_220),
    .lsc_register_GrGain_V_0(lsc_register_GrGain_V_0),
    .lsc_register_GrGain_V_1(lsc_register_GrGain_V_1),
    .lsc_register_GrGain_V_2(lsc_register_GrGain_V_2),
    .lsc_register_GrGain_V_3(lsc_register_GrGain_V_3),
    .lsc_register_GrGain_V_4(lsc_register_GrGain_V_4),
    .lsc_register_GrGain_V_5(lsc_register_GrGain_V_5),
    .lsc_register_GrGain_V_6(lsc_register_GrGain_V_6),
    .lsc_register_GrGain_V_7(lsc_register_GrGain_V_7),
    .lsc_register_GrGain_V_8(lsc_register_GrGain_V_8),
    .lsc_register_GrGain_V_9(lsc_register_GrGain_V_9),
    .lsc_register_GrGain_V_10(lsc_register_GrGain_V_10),
    .lsc_register_GrGain_V_11(lsc_register_GrGain_V_11),
    .lsc_register_GrGain_V_12(lsc_register_GrGain_V_12),
    .lsc_register_GrGain_V_13(lsc_register_GrGain_V_13),
    .lsc_register_GrGain_V_14(lsc_register_GrGain_V_14),
    .lsc_register_GrGain_V_15(lsc_register_GrGain_V_15),
    .lsc_register_GrGain_V_16(lsc_register_GrGain_V_16),
    .lsc_register_GrGain_V_17(lsc_register_GrGain_V_17),
    .lsc_register_GrGain_V_18(lsc_register_GrGain_V_18),
    .lsc_register_GrGain_V_19(lsc_register_GrGain_V_19),
    .lsc_register_GrGain_V_20(lsc_register_GrGain_V_20),
    .lsc_register_GrGain_V_21(lsc_register_GrGain_V_21),
    .lsc_register_GrGain_V_22(lsc_register_GrGain_V_22),
    .lsc_register_GrGain_V_23(lsc_register_GrGain_V_23),
    .lsc_register_GrGain_V_24(lsc_register_GrGain_V_24),
    .lsc_register_GrGain_V_25(lsc_register_GrGain_V_25),
    .lsc_register_GrGain_V_26(lsc_register_GrGain_V_26),
    .lsc_register_GrGain_V_27(lsc_register_GrGain_V_27),
    .lsc_register_GrGain_V_28(lsc_register_GrGain_V_28),
    .lsc_register_GrGain_V_29(lsc_register_GrGain_V_29),
    .lsc_register_GrGain_V_30(lsc_register_GrGain_V_30),
    .lsc_register_GrGain_V_31(lsc_register_GrGain_V_31),
    .lsc_register_GrGain_V_32(lsc_register_GrGain_V_32),
    .lsc_register_GrGain_V_33(lsc_register_GrGain_V_33),
    .lsc_register_GrGain_V_34(lsc_register_GrGain_V_34),
    .lsc_register_GrGain_V_35(lsc_register_GrGain_V_35),
    .lsc_register_GrGain_V_36(lsc_register_GrGain_V_36),
    .lsc_register_GrGain_V_37(lsc_register_GrGain_V_37),
    .lsc_register_GrGain_V_38(lsc_register_GrGain_V_38),
    .lsc_register_GrGain_V_39(lsc_register_GrGain_V_39),
    .lsc_register_GrGain_V_40(lsc_register_GrGain_V_40),
    .lsc_register_GrGain_V_41(lsc_register_GrGain_V_41),
    .lsc_register_GrGain_V_42(lsc_register_GrGain_V_42),
    .lsc_register_GrGain_V_43(lsc_register_GrGain_V_43),
    .lsc_register_GrGain_V_44(lsc_register_GrGain_V_44),
    .lsc_register_GrGain_V_45(lsc_register_GrGain_V_45),
    .lsc_register_GrGain_V_46(lsc_register_GrGain_V_46),
    .lsc_register_GrGain_V_47(lsc_register_GrGain_V_47),
    .lsc_register_GrGain_V_48(lsc_register_GrGain_V_48),
    .lsc_register_GrGain_V_49(lsc_register_GrGain_V_49),
    .lsc_register_GrGain_V_50(lsc_register_GrGain_V_50),
    .lsc_register_GrGain_V_51(lsc_register_GrGain_V_51),
    .lsc_register_GrGain_V_52(lsc_register_GrGain_V_52),
    .lsc_register_GrGain_V_53(lsc_register_GrGain_V_53),
    .lsc_register_GrGain_V_54(lsc_register_GrGain_V_54),
    .lsc_register_GrGain_V_55(lsc_register_GrGain_V_55),
    .lsc_register_GrGain_V_56(lsc_register_GrGain_V_56),
    .lsc_register_GrGain_V_57(lsc_register_GrGain_V_57),
    .lsc_register_GrGain_V_58(lsc_register_GrGain_V_58),
    .lsc_register_GrGain_V_59(lsc_register_GrGain_V_59),
    .lsc_register_GrGain_V_60(lsc_register_GrGain_V_60),
    .lsc_register_GrGain_V_61(lsc_register_GrGain_V_61),
    .lsc_register_GrGain_V_62(lsc_register_GrGain_V_62),
    .lsc_register_GrGain_V_63(lsc_register_GrGain_V_63),
    .lsc_register_GrGain_V_64(lsc_register_GrGain_V_64),
    .lsc_register_GrGain_V_65(lsc_register_GrGain_V_65),
    .lsc_register_GrGain_V_66(lsc_register_GrGain_V_66),
    .lsc_register_GrGain_V_67(lsc_register_GrGain_V_67),
    .lsc_register_GrGain_V_68(lsc_register_GrGain_V_68),
    .lsc_register_GrGain_V_69(lsc_register_GrGain_V_69),
    .lsc_register_GrGain_V_70(lsc_register_GrGain_V_70),
    .lsc_register_GrGain_V_71(lsc_register_GrGain_V_71),
    .lsc_register_GrGain_V_72(lsc_register_GrGain_V_72),
    .lsc_register_GrGain_V_73(lsc_register_GrGain_V_73),
    .lsc_register_GrGain_V_74(lsc_register_GrGain_V_74),
    .lsc_register_GrGain_V_75(lsc_register_GrGain_V_75),
    .lsc_register_GrGain_V_76(lsc_register_GrGain_V_76),
    .lsc_register_GrGain_V_77(lsc_register_GrGain_V_77),
    .lsc_register_GrGain_V_78(lsc_register_GrGain_V_78),
    .lsc_register_GrGain_V_79(lsc_register_GrGain_V_79),
    .lsc_register_GrGain_V_80(lsc_register_GrGain_V_80),
    .lsc_register_GrGain_V_81(lsc_register_GrGain_V_81),
    .lsc_register_GrGain_V_82(lsc_register_GrGain_V_82),
    .lsc_register_GrGain_V_83(lsc_register_GrGain_V_83),
    .lsc_register_GrGain_V_84(lsc_register_GrGain_V_84),
    .lsc_register_GrGain_V_85(lsc_register_GrGain_V_85),
    .lsc_register_GrGain_V_86(lsc_register_GrGain_V_86),
    .lsc_register_GrGain_V_87(lsc_register_GrGain_V_87),
    .lsc_register_GrGain_V_88(lsc_register_GrGain_V_88),
    .lsc_register_GrGain_V_89(lsc_register_GrGain_V_89),
    .lsc_register_GrGain_V_90(lsc_register_GrGain_V_90),
    .lsc_register_GrGain_V_91(lsc_register_GrGain_V_91),
    .lsc_register_GrGain_V_92(lsc_register_GrGain_V_92),
    .lsc_register_GrGain_V_93(lsc_register_GrGain_V_93),
    .lsc_register_GrGain_V_94(lsc_register_GrGain_V_94),
    .lsc_register_GrGain_V_95(lsc_register_GrGain_V_95),
    .lsc_register_GrGain_V_96(lsc_register_GrGain_V_96),
    .lsc_register_GrGain_V_97(lsc_register_GrGain_V_97),
    .lsc_register_GrGain_V_98(lsc_register_GrGain_V_98),
    .lsc_register_GrGain_V_99(lsc_register_GrGain_V_99),
    .lsc_register_GrGain_V_100(lsc_register_GrGain_V_100),
    .lsc_register_GrGain_V_101(lsc_register_GrGain_V_101),
    .lsc_register_GrGain_V_102(lsc_register_GrGain_V_102),
    .lsc_register_GrGain_V_103(lsc_register_GrGain_V_103),
    .lsc_register_GrGain_V_104(lsc_register_GrGain_V_104),
    .lsc_register_GrGain_V_105(lsc_register_GrGain_V_105),
    .lsc_register_GrGain_V_106(lsc_register_GrGain_V_106),
    .lsc_register_GrGain_V_107(lsc_register_GrGain_V_107),
    .lsc_register_GrGain_V_108(lsc_register_GrGain_V_108),
    .lsc_register_GrGain_V_109(lsc_register_GrGain_V_109),
    .lsc_register_GrGain_V_110(lsc_register_GrGain_V_110),
    .lsc_register_GrGain_V_111(lsc_register_GrGain_V_111),
    .lsc_register_GrGain_V_112(lsc_register_GrGain_V_112),
    .lsc_register_GrGain_V_113(lsc_register_GrGain_V_113),
    .lsc_register_GrGain_V_114(lsc_register_GrGain_V_114),
    .lsc_register_GrGain_V_115(lsc_register_GrGain_V_115),
    .lsc_register_GrGain_V_116(lsc_register_GrGain_V_116),
    .lsc_register_GrGain_V_117(lsc_register_GrGain_V_117),
    .lsc_register_GrGain_V_118(lsc_register_GrGain_V_118),
    .lsc_register_GrGain_V_119(lsc_register_GrGain_V_119),
    .lsc_register_GrGain_V_120(lsc_register_GrGain_V_120),
    .lsc_register_GrGain_V_121(lsc_register_GrGain_V_121),
    .lsc_register_GrGain_V_122(lsc_register_GrGain_V_122),
    .lsc_register_GrGain_V_123(lsc_register_GrGain_V_123),
    .lsc_register_GrGain_V_124(lsc_register_GrGain_V_124),
    .lsc_register_GrGain_V_125(lsc_register_GrGain_V_125),
    .lsc_register_GrGain_V_126(lsc_register_GrGain_V_126),
    .lsc_register_GrGain_V_127(lsc_register_GrGain_V_127),
    .lsc_register_GrGain_V_128(lsc_register_GrGain_V_128),
    .lsc_register_GrGain_V_129(lsc_register_GrGain_V_129),
    .lsc_register_GrGain_V_130(lsc_register_GrGain_V_130),
    .lsc_register_GrGain_V_131(lsc_register_GrGain_V_131),
    .lsc_register_GrGain_V_132(lsc_register_GrGain_V_132),
    .lsc_register_GrGain_V_133(lsc_register_GrGain_V_133),
    .lsc_register_GrGain_V_134(lsc_register_GrGain_V_134),
    .lsc_register_GrGain_V_135(lsc_register_GrGain_V_135),
    .lsc_register_GrGain_V_136(lsc_register_GrGain_V_136),
    .lsc_register_GrGain_V_137(lsc_register_GrGain_V_137),
    .lsc_register_GrGain_V_138(lsc_register_GrGain_V_138),
    .lsc_register_GrGain_V_139(lsc_register_GrGain_V_139),
    .lsc_register_GrGain_V_140(lsc_register_GrGain_V_140),
    .lsc_register_GrGain_V_141(lsc_register_GrGain_V_141),
    .lsc_register_GrGain_V_142(lsc_register_GrGain_V_142),
    .lsc_register_GrGain_V_143(lsc_register_GrGain_V_143),
    .lsc_register_GrGain_V_144(lsc_register_GrGain_V_144),
    .lsc_register_GrGain_V_145(lsc_register_GrGain_V_145),
    .lsc_register_GrGain_V_146(lsc_register_GrGain_V_146),
    .lsc_register_GrGain_V_147(lsc_register_GrGain_V_147),
    .lsc_register_GrGain_V_148(lsc_register_GrGain_V_148),
    .lsc_register_GrGain_V_149(lsc_register_GrGain_V_149),
    .lsc_register_GrGain_V_150(lsc_register_GrGain_V_150),
    .lsc_register_GrGain_V_151(lsc_register_GrGain_V_151),
    .lsc_register_GrGain_V_152(lsc_register_GrGain_V_152),
    .lsc_register_GrGain_V_153(lsc_register_GrGain_V_153),
    .lsc_register_GrGain_V_154(lsc_register_GrGain_V_154),
    .lsc_register_GrGain_V_155(lsc_register_GrGain_V_155),
    .lsc_register_GrGain_V_156(lsc_register_GrGain_V_156),
    .lsc_register_GrGain_V_157(lsc_register_GrGain_V_157),
    .lsc_register_GrGain_V_158(lsc_register_GrGain_V_158),
    .lsc_register_GrGain_V_159(lsc_register_GrGain_V_159),
    .lsc_register_GrGain_V_160(lsc_register_GrGain_V_160),
    .lsc_register_GrGain_V_161(lsc_register_GrGain_V_161),
    .lsc_register_GrGain_V_162(lsc_register_GrGain_V_162),
    .lsc_register_GrGain_V_163(lsc_register_GrGain_V_163),
    .lsc_register_GrGain_V_164(lsc_register_GrGain_V_164),
    .lsc_register_GrGain_V_165(lsc_register_GrGain_V_165),
    .lsc_register_GrGain_V_166(lsc_register_GrGain_V_166),
    .lsc_register_GrGain_V_167(lsc_register_GrGain_V_167),
    .lsc_register_GrGain_V_168(lsc_register_GrGain_V_168),
    .lsc_register_GrGain_V_169(lsc_register_GrGain_V_169),
    .lsc_register_GrGain_V_170(lsc_register_GrGain_V_170),
    .lsc_register_GrGain_V_171(lsc_register_GrGain_V_171),
    .lsc_register_GrGain_V_172(lsc_register_GrGain_V_172),
    .lsc_register_GrGain_V_173(lsc_register_GrGain_V_173),
    .lsc_register_GrGain_V_174(lsc_register_GrGain_V_174),
    .lsc_register_GrGain_V_175(lsc_register_GrGain_V_175),
    .lsc_register_GrGain_V_176(lsc_register_GrGain_V_176),
    .lsc_register_GrGain_V_177(lsc_register_GrGain_V_177),
    .lsc_register_GrGain_V_178(lsc_register_GrGain_V_178),
    .lsc_register_GrGain_V_179(lsc_register_GrGain_V_179),
    .lsc_register_GrGain_V_180(lsc_register_GrGain_V_180),
    .lsc_register_GrGain_V_181(lsc_register_GrGain_V_181),
    .lsc_register_GrGain_V_182(lsc_register_GrGain_V_182),
    .lsc_register_GrGain_V_183(lsc_register_GrGain_V_183),
    .lsc_register_GrGain_V_184(lsc_register_GrGain_V_184),
    .lsc_register_GrGain_V_185(lsc_register_GrGain_V_185),
    .lsc_register_GrGain_V_186(lsc_register_GrGain_V_186),
    .lsc_register_GrGain_V_187(lsc_register_GrGain_V_187),
    .lsc_register_GrGain_V_188(lsc_register_GrGain_V_188),
    .lsc_register_GrGain_V_189(lsc_register_GrGain_V_189),
    .lsc_register_GrGain_V_190(lsc_register_GrGain_V_190),
    .lsc_register_GrGain_V_191(lsc_register_GrGain_V_191),
    .lsc_register_GrGain_V_192(lsc_register_GrGain_V_192),
    .lsc_register_GrGain_V_193(lsc_register_GrGain_V_193),
    .lsc_register_GrGain_V_194(lsc_register_GrGain_V_194),
    .lsc_register_GrGain_V_195(lsc_register_GrGain_V_195),
    .lsc_register_GrGain_V_196(lsc_register_GrGain_V_196),
    .lsc_register_GrGain_V_197(lsc_register_GrGain_V_197),
    .lsc_register_GrGain_V_198(lsc_register_GrGain_V_198),
    .lsc_register_GrGain_V_199(lsc_register_GrGain_V_199),
    .lsc_register_GrGain_V_200(lsc_register_GrGain_V_200),
    .lsc_register_GrGain_V_201(lsc_register_GrGain_V_201),
    .lsc_register_GrGain_V_202(lsc_register_GrGain_V_202),
    .lsc_register_GrGain_V_203(lsc_register_GrGain_V_203),
    .lsc_register_GrGain_V_204(lsc_register_GrGain_V_204),
    .lsc_register_GrGain_V_205(lsc_register_GrGain_V_205),
    .lsc_register_GrGain_V_206(lsc_register_GrGain_V_206),
    .lsc_register_GrGain_V_207(lsc_register_GrGain_V_207),
    .lsc_register_GrGain_V_208(lsc_register_GrGain_V_208),
    .lsc_register_GrGain_V_209(lsc_register_GrGain_V_209),
    .lsc_register_GrGain_V_210(lsc_register_GrGain_V_210),
    .lsc_register_GrGain_V_211(lsc_register_GrGain_V_211),
    .lsc_register_GrGain_V_212(lsc_register_GrGain_V_212),
    .lsc_register_GrGain_V_213(lsc_register_GrGain_V_213),
    .lsc_register_GrGain_V_214(lsc_register_GrGain_V_214),
    .lsc_register_GrGain_V_215(lsc_register_GrGain_V_215),
    .lsc_register_GrGain_V_216(lsc_register_GrGain_V_216),
    .lsc_register_GrGain_V_217(lsc_register_GrGain_V_217),
    .lsc_register_GrGain_V_218(lsc_register_GrGain_V_218),
    .lsc_register_GrGain_V_219(lsc_register_GrGain_V_219),
    .lsc_register_GrGain_V_220(lsc_register_GrGain_V_220),
    .lsc_register_GbGain_V_0(lsc_register_GbGain_V_0),
    .lsc_register_GbGain_V_1(lsc_register_GbGain_V_1),
    .lsc_register_GbGain_V_2(lsc_register_GbGain_V_2),
    .lsc_register_GbGain_V_3(lsc_register_GbGain_V_3),
    .lsc_register_GbGain_V_4(lsc_register_GbGain_V_4),
    .lsc_register_GbGain_V_5(lsc_register_GbGain_V_5),
    .lsc_register_GbGain_V_6(lsc_register_GbGain_V_6),
    .lsc_register_GbGain_V_7(lsc_register_GbGain_V_7),
    .lsc_register_GbGain_V_8(lsc_register_GbGain_V_8),
    .lsc_register_GbGain_V_9(lsc_register_GbGain_V_9),
    .lsc_register_GbGain_V_10(lsc_register_GbGain_V_10),
    .lsc_register_GbGain_V_11(lsc_register_GbGain_V_11),
    .lsc_register_GbGain_V_12(lsc_register_GbGain_V_12),
    .lsc_register_GbGain_V_13(lsc_register_GbGain_V_13),
    .lsc_register_GbGain_V_14(lsc_register_GbGain_V_14),
    .lsc_register_GbGain_V_15(lsc_register_GbGain_V_15),
    .lsc_register_GbGain_V_16(lsc_register_GbGain_V_16),
    .lsc_register_GbGain_V_17(lsc_register_GbGain_V_17),
    .lsc_register_GbGain_V_18(lsc_register_GbGain_V_18),
    .lsc_register_GbGain_V_19(lsc_register_GbGain_V_19),
    .lsc_register_GbGain_V_20(lsc_register_GbGain_V_20),
    .lsc_register_GbGain_V_21(lsc_register_GbGain_V_21),
    .lsc_register_GbGain_V_22(lsc_register_GbGain_V_22),
    .lsc_register_GbGain_V_23(lsc_register_GbGain_V_23),
    .lsc_register_GbGain_V_24(lsc_register_GbGain_V_24),
    .lsc_register_GbGain_V_25(lsc_register_GbGain_V_25),
    .lsc_register_GbGain_V_26(lsc_register_GbGain_V_26),
    .lsc_register_GbGain_V_27(lsc_register_GbGain_V_27),
    .lsc_register_GbGain_V_28(lsc_register_GbGain_V_28),
    .lsc_register_GbGain_V_29(lsc_register_GbGain_V_29),
    .lsc_register_GbGain_V_30(lsc_register_GbGain_V_30),
    .lsc_register_GbGain_V_31(lsc_register_GbGain_V_31),
    .lsc_register_GbGain_V_32(lsc_register_GbGain_V_32),
    .lsc_register_GbGain_V_33(lsc_register_GbGain_V_33),
    .lsc_register_GbGain_V_34(lsc_register_GbGain_V_34),
    .lsc_register_GbGain_V_35(lsc_register_GbGain_V_35),
    .lsc_register_GbGain_V_36(lsc_register_GbGain_V_36),
    .lsc_register_GbGain_V_37(lsc_register_GbGain_V_37),
    .lsc_register_GbGain_V_38(lsc_register_GbGain_V_38),
    .lsc_register_GbGain_V_39(lsc_register_GbGain_V_39),
    .lsc_register_GbGain_V_40(lsc_register_GbGain_V_40),
    .lsc_register_GbGain_V_41(lsc_register_GbGain_V_41),
    .lsc_register_GbGain_V_42(lsc_register_GbGain_V_42),
    .lsc_register_GbGain_V_43(lsc_register_GbGain_V_43),
    .lsc_register_GbGain_V_44(lsc_register_GbGain_V_44),
    .lsc_register_GbGain_V_45(lsc_register_GbGain_V_45),
    .lsc_register_GbGain_V_46(lsc_register_GbGain_V_46),
    .lsc_register_GbGain_V_47(lsc_register_GbGain_V_47),
    .lsc_register_GbGain_V_48(lsc_register_GbGain_V_48),
    .lsc_register_GbGain_V_49(lsc_register_GbGain_V_49),
    .lsc_register_GbGain_V_50(lsc_register_GbGain_V_50),
    .lsc_register_GbGain_V_51(lsc_register_GbGain_V_51),
    .lsc_register_GbGain_V_52(lsc_register_GbGain_V_52),
    .lsc_register_GbGain_V_53(lsc_register_GbGain_V_53),
    .lsc_register_GbGain_V_54(lsc_register_GbGain_V_54),
    .lsc_register_GbGain_V_55(lsc_register_GbGain_V_55),
    .lsc_register_GbGain_V_56(lsc_register_GbGain_V_56),
    .lsc_register_GbGain_V_57(lsc_register_GbGain_V_57),
    .lsc_register_GbGain_V_58(lsc_register_GbGain_V_58),
    .lsc_register_GbGain_V_59(lsc_register_GbGain_V_59),
    .lsc_register_GbGain_V_60(lsc_register_GbGain_V_60),
    .lsc_register_GbGain_V_61(lsc_register_GbGain_V_61),
    .lsc_register_GbGain_V_62(lsc_register_GbGain_V_62),
    .lsc_register_GbGain_V_63(lsc_register_GbGain_V_63),
    .lsc_register_GbGain_V_64(lsc_register_GbGain_V_64),
    .lsc_register_GbGain_V_65(lsc_register_GbGain_V_65),
    .lsc_register_GbGain_V_66(lsc_register_GbGain_V_66),
    .lsc_register_GbGain_V_67(lsc_register_GbGain_V_67),
    .lsc_register_GbGain_V_68(lsc_register_GbGain_V_68),
    .lsc_register_GbGain_V_69(lsc_register_GbGain_V_69),
    .lsc_register_GbGain_V_70(lsc_register_GbGain_V_70),
    .lsc_register_GbGain_V_71(lsc_register_GbGain_V_71),
    .lsc_register_GbGain_V_72(lsc_register_GbGain_V_72),
    .lsc_register_GbGain_V_73(lsc_register_GbGain_V_73),
    .lsc_register_GbGain_V_74(lsc_register_GbGain_V_74),
    .lsc_register_GbGain_V_75(lsc_register_GbGain_V_75),
    .lsc_register_GbGain_V_76(lsc_register_GbGain_V_76),
    .lsc_register_GbGain_V_77(lsc_register_GbGain_V_77),
    .lsc_register_GbGain_V_78(lsc_register_GbGain_V_78),
    .lsc_register_GbGain_V_79(lsc_register_GbGain_V_79),
    .lsc_register_GbGain_V_80(lsc_register_GbGain_V_80),
    .lsc_register_GbGain_V_81(lsc_register_GbGain_V_81),
    .lsc_register_GbGain_V_82(lsc_register_GbGain_V_82),
    .lsc_register_GbGain_V_83(lsc_register_GbGain_V_83),
    .lsc_register_GbGain_V_84(lsc_register_GbGain_V_84),
    .lsc_register_GbGain_V_85(lsc_register_GbGain_V_85),
    .lsc_register_GbGain_V_86(lsc_register_GbGain_V_86),
    .lsc_register_GbGain_V_87(lsc_register_GbGain_V_87),
    .lsc_register_GbGain_V_88(lsc_register_GbGain_V_88),
    .lsc_register_GbGain_V_89(lsc_register_GbGain_V_89),
    .lsc_register_GbGain_V_90(lsc_register_GbGain_V_90),
    .lsc_register_GbGain_V_91(lsc_register_GbGain_V_91),
    .lsc_register_GbGain_V_92(lsc_register_GbGain_V_92),
    .lsc_register_GbGain_V_93(lsc_register_GbGain_V_93),
    .lsc_register_GbGain_V_94(lsc_register_GbGain_V_94),
    .lsc_register_GbGain_V_95(lsc_register_GbGain_V_95),
    .lsc_register_GbGain_V_96(lsc_register_GbGain_V_96),
    .lsc_register_GbGain_V_97(lsc_register_GbGain_V_97),
    .lsc_register_GbGain_V_98(lsc_register_GbGain_V_98),
    .lsc_register_GbGain_V_99(lsc_register_GbGain_V_99),
    .lsc_register_GbGain_V_100(lsc_register_GbGain_V_100),
    .lsc_register_GbGain_V_101(lsc_register_GbGain_V_101),
    .lsc_register_GbGain_V_102(lsc_register_GbGain_V_102),
    .lsc_register_GbGain_V_103(lsc_register_GbGain_V_103),
    .lsc_register_GbGain_V_104(lsc_register_GbGain_V_104),
    .lsc_register_GbGain_V_105(lsc_register_GbGain_V_105),
    .lsc_register_GbGain_V_106(lsc_register_GbGain_V_106),
    .lsc_register_GbGain_V_107(lsc_register_GbGain_V_107),
    .lsc_register_GbGain_V_108(lsc_register_GbGain_V_108),
    .lsc_register_GbGain_V_109(lsc_register_GbGain_V_109),
    .lsc_register_GbGain_V_110(lsc_register_GbGain_V_110),
    .lsc_register_GbGain_V_111(lsc_register_GbGain_V_111),
    .lsc_register_GbGain_V_112(lsc_register_GbGain_V_112),
    .lsc_register_GbGain_V_113(lsc_register_GbGain_V_113),
    .lsc_register_GbGain_V_114(lsc_register_GbGain_V_114),
    .lsc_register_GbGain_V_115(lsc_register_GbGain_V_115),
    .lsc_register_GbGain_V_116(lsc_register_GbGain_V_116),
    .lsc_register_GbGain_V_117(lsc_register_GbGain_V_117),
    .lsc_register_GbGain_V_118(lsc_register_GbGain_V_118),
    .lsc_register_GbGain_V_119(lsc_register_GbGain_V_119),
    .lsc_register_GbGain_V_120(lsc_register_GbGain_V_120),
    .lsc_register_GbGain_V_121(lsc_register_GbGain_V_121),
    .lsc_register_GbGain_V_122(lsc_register_GbGain_V_122),
    .lsc_register_GbGain_V_123(lsc_register_GbGain_V_123),
    .lsc_register_GbGain_V_124(lsc_register_GbGain_V_124),
    .lsc_register_GbGain_V_125(lsc_register_GbGain_V_125),
    .lsc_register_GbGain_V_126(lsc_register_GbGain_V_126),
    .lsc_register_GbGain_V_127(lsc_register_GbGain_V_127),
    .lsc_register_GbGain_V_128(lsc_register_GbGain_V_128),
    .lsc_register_GbGain_V_129(lsc_register_GbGain_V_129),
    .lsc_register_GbGain_V_130(lsc_register_GbGain_V_130),
    .lsc_register_GbGain_V_131(lsc_register_GbGain_V_131),
    .lsc_register_GbGain_V_132(lsc_register_GbGain_V_132),
    .lsc_register_GbGain_V_133(lsc_register_GbGain_V_133),
    .lsc_register_GbGain_V_134(lsc_register_GbGain_V_134),
    .lsc_register_GbGain_V_135(lsc_register_GbGain_V_135),
    .lsc_register_GbGain_V_136(lsc_register_GbGain_V_136),
    .lsc_register_GbGain_V_137(lsc_register_GbGain_V_137),
    .lsc_register_GbGain_V_138(lsc_register_GbGain_V_138),
    .lsc_register_GbGain_V_139(lsc_register_GbGain_V_139),
    .lsc_register_GbGain_V_140(lsc_register_GbGain_V_140),
    .lsc_register_GbGain_V_141(lsc_register_GbGain_V_141),
    .lsc_register_GbGain_V_142(lsc_register_GbGain_V_142),
    .lsc_register_GbGain_V_143(lsc_register_GbGain_V_143),
    .lsc_register_GbGain_V_144(lsc_register_GbGain_V_144),
    .lsc_register_GbGain_V_145(lsc_register_GbGain_V_145),
    .lsc_register_GbGain_V_146(lsc_register_GbGain_V_146),
    .lsc_register_GbGain_V_147(lsc_register_GbGain_V_147),
    .lsc_register_GbGain_V_148(lsc_register_GbGain_V_148),
    .lsc_register_GbGain_V_149(lsc_register_GbGain_V_149),
    .lsc_register_GbGain_V_150(lsc_register_GbGain_V_150),
    .lsc_register_GbGain_V_151(lsc_register_GbGain_V_151),
    .lsc_register_GbGain_V_152(lsc_register_GbGain_V_152),
    .lsc_register_GbGain_V_153(lsc_register_GbGain_V_153),
    .lsc_register_GbGain_V_154(lsc_register_GbGain_V_154),
    .lsc_register_GbGain_V_155(lsc_register_GbGain_V_155),
    .lsc_register_GbGain_V_156(lsc_register_GbGain_V_156),
    .lsc_register_GbGain_V_157(lsc_register_GbGain_V_157),
    .lsc_register_GbGain_V_158(lsc_register_GbGain_V_158),
    .lsc_register_GbGain_V_159(lsc_register_GbGain_V_159),
    .lsc_register_GbGain_V_160(lsc_register_GbGain_V_160),
    .lsc_register_GbGain_V_161(lsc_register_GbGain_V_161),
    .lsc_register_GbGain_V_162(lsc_register_GbGain_V_162),
    .lsc_register_GbGain_V_163(lsc_register_GbGain_V_163),
    .lsc_register_GbGain_V_164(lsc_register_GbGain_V_164),
    .lsc_register_GbGain_V_165(lsc_register_GbGain_V_165),
    .lsc_register_GbGain_V_166(lsc_register_GbGain_V_166),
    .lsc_register_GbGain_V_167(lsc_register_GbGain_V_167),
    .lsc_register_GbGain_V_168(lsc_register_GbGain_V_168),
    .lsc_register_GbGain_V_169(lsc_register_GbGain_V_169),
    .lsc_register_GbGain_V_170(lsc_register_GbGain_V_170),
    .lsc_register_GbGain_V_171(lsc_register_GbGain_V_171),
    .lsc_register_GbGain_V_172(lsc_register_GbGain_V_172),
    .lsc_register_GbGain_V_173(lsc_register_GbGain_V_173),
    .lsc_register_GbGain_V_174(lsc_register_GbGain_V_174),
    .lsc_register_GbGain_V_175(lsc_register_GbGain_V_175),
    .lsc_register_GbGain_V_176(lsc_register_GbGain_V_176),
    .lsc_register_GbGain_V_177(lsc_register_GbGain_V_177),
    .lsc_register_GbGain_V_178(lsc_register_GbGain_V_178),
    .lsc_register_GbGain_V_179(lsc_register_GbGain_V_179),
    .lsc_register_GbGain_V_180(lsc_register_GbGain_V_180),
    .lsc_register_GbGain_V_181(lsc_register_GbGain_V_181),
    .lsc_register_GbGain_V_182(lsc_register_GbGain_V_182),
    .lsc_register_GbGain_V_183(lsc_register_GbGain_V_183),
    .lsc_register_GbGain_V_184(lsc_register_GbGain_V_184),
    .lsc_register_GbGain_V_185(lsc_register_GbGain_V_185),
    .lsc_register_GbGain_V_186(lsc_register_GbGain_V_186),
    .lsc_register_GbGain_V_187(lsc_register_GbGain_V_187),
    .lsc_register_GbGain_V_188(lsc_register_GbGain_V_188),
    .lsc_register_GbGain_V_189(lsc_register_GbGain_V_189),
    .lsc_register_GbGain_V_190(lsc_register_GbGain_V_190),
    .lsc_register_GbGain_V_191(lsc_register_GbGain_V_191),
    .lsc_register_GbGain_V_192(lsc_register_GbGain_V_192),
    .lsc_register_GbGain_V_193(lsc_register_GbGain_V_193),
    .lsc_register_GbGain_V_194(lsc_register_GbGain_V_194),
    .lsc_register_GbGain_V_195(lsc_register_GbGain_V_195),
    .lsc_register_GbGain_V_196(lsc_register_GbGain_V_196),
    .lsc_register_GbGain_V_197(lsc_register_GbGain_V_197),
    .lsc_register_GbGain_V_198(lsc_register_GbGain_V_198),
    .lsc_register_GbGain_V_199(lsc_register_GbGain_V_199),
    .lsc_register_GbGain_V_200(lsc_register_GbGain_V_200),
    .lsc_register_GbGain_V_201(lsc_register_GbGain_V_201),
    .lsc_register_GbGain_V_202(lsc_register_GbGain_V_202),
    .lsc_register_GbGain_V_203(lsc_register_GbGain_V_203),
    .lsc_register_GbGain_V_204(lsc_register_GbGain_V_204),
    .lsc_register_GbGain_V_205(lsc_register_GbGain_V_205),
    .lsc_register_GbGain_V_206(lsc_register_GbGain_V_206),
    .lsc_register_GbGain_V_207(lsc_register_GbGain_V_207),
    .lsc_register_GbGain_V_208(lsc_register_GbGain_V_208),
    .lsc_register_GbGain_V_209(lsc_register_GbGain_V_209),
    .lsc_register_GbGain_V_210(lsc_register_GbGain_V_210),
    .lsc_register_GbGain_V_211(lsc_register_GbGain_V_211),
    .lsc_register_GbGain_V_212(lsc_register_GbGain_V_212),
    .lsc_register_GbGain_V_213(lsc_register_GbGain_V_213),
    .lsc_register_GbGain_V_214(lsc_register_GbGain_V_214),
    .lsc_register_GbGain_V_215(lsc_register_GbGain_V_215),
    .lsc_register_GbGain_V_216(lsc_register_GbGain_V_216),
    .lsc_register_GbGain_V_217(lsc_register_GbGain_V_217),
    .lsc_register_GbGain_V_218(lsc_register_GbGain_V_218),
    .lsc_register_GbGain_V_219(lsc_register_GbGain_V_219),
    .lsc_register_GbGain_V_220(lsc_register_GbGain_V_220),
    .lsc_register_bGain_V_0(lsc_register_bGain_V_0),
    .lsc_register_bGain_V_1(lsc_register_bGain_V_1),
    .lsc_register_bGain_V_2(lsc_register_bGain_V_2),
    .lsc_register_bGain_V_3(lsc_register_bGain_V_3),
    .lsc_register_bGain_V_4(lsc_register_bGain_V_4),
    .lsc_register_bGain_V_5(lsc_register_bGain_V_5),
    .lsc_register_bGain_V_6(lsc_register_bGain_V_6),
    .lsc_register_bGain_V_7(lsc_register_bGain_V_7),
    .lsc_register_bGain_V_8(lsc_register_bGain_V_8),
    .lsc_register_bGain_V_9(lsc_register_bGain_V_9),
    .lsc_register_bGain_V_10(lsc_register_bGain_V_10),
    .lsc_register_bGain_V_11(lsc_register_bGain_V_11),
    .lsc_register_bGain_V_12(lsc_register_bGain_V_12),
    .lsc_register_bGain_V_13(lsc_register_bGain_V_13),
    .lsc_register_bGain_V_14(lsc_register_bGain_V_14),
    .lsc_register_bGain_V_15(lsc_register_bGain_V_15),
    .lsc_register_bGain_V_16(lsc_register_bGain_V_16),
    .lsc_register_bGain_V_17(lsc_register_bGain_V_17),
    .lsc_register_bGain_V_18(lsc_register_bGain_V_18),
    .lsc_register_bGain_V_19(lsc_register_bGain_V_19),
    .lsc_register_bGain_V_20(lsc_register_bGain_V_20),
    .lsc_register_bGain_V_21(lsc_register_bGain_V_21),
    .lsc_register_bGain_V_22(lsc_register_bGain_V_22),
    .lsc_register_bGain_V_23(lsc_register_bGain_V_23),
    .lsc_register_bGain_V_24(lsc_register_bGain_V_24),
    .lsc_register_bGain_V_25(lsc_register_bGain_V_25),
    .lsc_register_bGain_V_26(lsc_register_bGain_V_26),
    .lsc_register_bGain_V_27(lsc_register_bGain_V_27),
    .lsc_register_bGain_V_28(lsc_register_bGain_V_28),
    .lsc_register_bGain_V_29(lsc_register_bGain_V_29),
    .lsc_register_bGain_V_30(lsc_register_bGain_V_30),
    .lsc_register_bGain_V_31(lsc_register_bGain_V_31),
    .lsc_register_bGain_V_32(lsc_register_bGain_V_32),
    .lsc_register_bGain_V_33(lsc_register_bGain_V_33),
    .lsc_register_bGain_V_34(lsc_register_bGain_V_34),
    .lsc_register_bGain_V_35(lsc_register_bGain_V_35),
    .lsc_register_bGain_V_36(lsc_register_bGain_V_36),
    .lsc_register_bGain_V_37(lsc_register_bGain_V_37),
    .lsc_register_bGain_V_38(lsc_register_bGain_V_38),
    .lsc_register_bGain_V_39(lsc_register_bGain_V_39),
    .lsc_register_bGain_V_40(lsc_register_bGain_V_40),
    .lsc_register_bGain_V_41(lsc_register_bGain_V_41),
    .lsc_register_bGain_V_42(lsc_register_bGain_V_42),
    .lsc_register_bGain_V_43(lsc_register_bGain_V_43),
    .lsc_register_bGain_V_44(lsc_register_bGain_V_44),
    .lsc_register_bGain_V_45(lsc_register_bGain_V_45),
    .lsc_register_bGain_V_46(lsc_register_bGain_V_46),
    .lsc_register_bGain_V_47(lsc_register_bGain_V_47),
    .lsc_register_bGain_V_48(lsc_register_bGain_V_48),
    .lsc_register_bGain_V_49(lsc_register_bGain_V_49),
    .lsc_register_bGain_V_50(lsc_register_bGain_V_50),
    .lsc_register_bGain_V_51(lsc_register_bGain_V_51),
    .lsc_register_bGain_V_52(lsc_register_bGain_V_52),
    .lsc_register_bGain_V_53(lsc_register_bGain_V_53),
    .lsc_register_bGain_V_54(lsc_register_bGain_V_54),
    .lsc_register_bGain_V_55(lsc_register_bGain_V_55),
    .lsc_register_bGain_V_56(lsc_register_bGain_V_56),
    .lsc_register_bGain_V_57(lsc_register_bGain_V_57),
    .lsc_register_bGain_V_58(lsc_register_bGain_V_58),
    .lsc_register_bGain_V_59(lsc_register_bGain_V_59),
    .lsc_register_bGain_V_60(lsc_register_bGain_V_60),
    .lsc_register_bGain_V_61(lsc_register_bGain_V_61),
    .lsc_register_bGain_V_62(lsc_register_bGain_V_62),
    .lsc_register_bGain_V_63(lsc_register_bGain_V_63),
    .lsc_register_bGain_V_64(lsc_register_bGain_V_64),
    .lsc_register_bGain_V_65(lsc_register_bGain_V_65),
    .lsc_register_bGain_V_66(lsc_register_bGain_V_66),
    .lsc_register_bGain_V_67(lsc_register_bGain_V_67),
    .lsc_register_bGain_V_68(lsc_register_bGain_V_68),
    .lsc_register_bGain_V_69(lsc_register_bGain_V_69),
    .lsc_register_bGain_V_70(lsc_register_bGain_V_70),
    .lsc_register_bGain_V_71(lsc_register_bGain_V_71),
    .lsc_register_bGain_V_72(lsc_register_bGain_V_72),
    .lsc_register_bGain_V_73(lsc_register_bGain_V_73),
    .lsc_register_bGain_V_74(lsc_register_bGain_V_74),
    .lsc_register_bGain_V_75(lsc_register_bGain_V_75),
    .lsc_register_bGain_V_76(lsc_register_bGain_V_76),
    .lsc_register_bGain_V_77(lsc_register_bGain_V_77),
    .lsc_register_bGain_V_78(lsc_register_bGain_V_78),
    .lsc_register_bGain_V_79(lsc_register_bGain_V_79),
    .lsc_register_bGain_V_80(lsc_register_bGain_V_80),
    .lsc_register_bGain_V_81(lsc_register_bGain_V_81),
    .lsc_register_bGain_V_82(lsc_register_bGain_V_82),
    .lsc_register_bGain_V_83(lsc_register_bGain_V_83),
    .lsc_register_bGain_V_84(lsc_register_bGain_V_84),
    .lsc_register_bGain_V_85(lsc_register_bGain_V_85),
    .lsc_register_bGain_V_86(lsc_register_bGain_V_86),
    .lsc_register_bGain_V_87(lsc_register_bGain_V_87),
    .lsc_register_bGain_V_88(lsc_register_bGain_V_88),
    .lsc_register_bGain_V_89(lsc_register_bGain_V_89),
    .lsc_register_bGain_V_90(lsc_register_bGain_V_90),
    .lsc_register_bGain_V_91(lsc_register_bGain_V_91),
    .lsc_register_bGain_V_92(lsc_register_bGain_V_92),
    .lsc_register_bGain_V_93(lsc_register_bGain_V_93),
    .lsc_register_bGain_V_94(lsc_register_bGain_V_94),
    .lsc_register_bGain_V_95(lsc_register_bGain_V_95),
    .lsc_register_bGain_V_96(lsc_register_bGain_V_96),
    .lsc_register_bGain_V_97(lsc_register_bGain_V_97),
    .lsc_register_bGain_V_98(lsc_register_bGain_V_98),
    .lsc_register_bGain_V_99(lsc_register_bGain_V_99),
    .lsc_register_bGain_V_100(lsc_register_bGain_V_100),
    .lsc_register_bGain_V_101(lsc_register_bGain_V_101),
    .lsc_register_bGain_V_102(lsc_register_bGain_V_102),
    .lsc_register_bGain_V_103(lsc_register_bGain_V_103),
    .lsc_register_bGain_V_104(lsc_register_bGain_V_104),
    .lsc_register_bGain_V_105(lsc_register_bGain_V_105),
    .lsc_register_bGain_V_106(lsc_register_bGain_V_106),
    .lsc_register_bGain_V_107(lsc_register_bGain_V_107),
    .lsc_register_bGain_V_108(lsc_register_bGain_V_108),
    .lsc_register_bGain_V_109(lsc_register_bGain_V_109),
    .lsc_register_bGain_V_110(lsc_register_bGain_V_110),
    .lsc_register_bGain_V_111(lsc_register_bGain_V_111),
    .lsc_register_bGain_V_112(lsc_register_bGain_V_112),
    .lsc_register_bGain_V_113(lsc_register_bGain_V_113),
    .lsc_register_bGain_V_114(lsc_register_bGain_V_114),
    .lsc_register_bGain_V_115(lsc_register_bGain_V_115),
    .lsc_register_bGain_V_116(lsc_register_bGain_V_116),
    .lsc_register_bGain_V_117(lsc_register_bGain_V_117),
    .lsc_register_bGain_V_118(lsc_register_bGain_V_118),
    .lsc_register_bGain_V_119(lsc_register_bGain_V_119),
    .lsc_register_bGain_V_120(lsc_register_bGain_V_120),
    .lsc_register_bGain_V_121(lsc_register_bGain_V_121),
    .lsc_register_bGain_V_122(lsc_register_bGain_V_122),
    .lsc_register_bGain_V_123(lsc_register_bGain_V_123),
    .lsc_register_bGain_V_124(lsc_register_bGain_V_124),
    .lsc_register_bGain_V_125(lsc_register_bGain_V_125),
    .lsc_register_bGain_V_126(lsc_register_bGain_V_126),
    .lsc_register_bGain_V_127(lsc_register_bGain_V_127),
    .lsc_register_bGain_V_128(lsc_register_bGain_V_128),
    .lsc_register_bGain_V_129(lsc_register_bGain_V_129),
    .lsc_register_bGain_V_130(lsc_register_bGain_V_130),
    .lsc_register_bGain_V_131(lsc_register_bGain_V_131),
    .lsc_register_bGain_V_132(lsc_register_bGain_V_132),
    .lsc_register_bGain_V_133(lsc_register_bGain_V_133),
    .lsc_register_bGain_V_134(lsc_register_bGain_V_134),
    .lsc_register_bGain_V_135(lsc_register_bGain_V_135),
    .lsc_register_bGain_V_136(lsc_register_bGain_V_136),
    .lsc_register_bGain_V_137(lsc_register_bGain_V_137),
    .lsc_register_bGain_V_138(lsc_register_bGain_V_138),
    .lsc_register_bGain_V_139(lsc_register_bGain_V_139),
    .lsc_register_bGain_V_140(lsc_register_bGain_V_140),
    .lsc_register_bGain_V_141(lsc_register_bGain_V_141),
    .lsc_register_bGain_V_142(lsc_register_bGain_V_142),
    .lsc_register_bGain_V_143(lsc_register_bGain_V_143),
    .lsc_register_bGain_V_144(lsc_register_bGain_V_144),
    .lsc_register_bGain_V_145(lsc_register_bGain_V_145),
    .lsc_register_bGain_V_146(lsc_register_bGain_V_146),
    .lsc_register_bGain_V_147(lsc_register_bGain_V_147),
    .lsc_register_bGain_V_148(lsc_register_bGain_V_148),
    .lsc_register_bGain_V_149(lsc_register_bGain_V_149),
    .lsc_register_bGain_V_150(lsc_register_bGain_V_150),
    .lsc_register_bGain_V_151(lsc_register_bGain_V_151),
    .lsc_register_bGain_V_152(lsc_register_bGain_V_152),
    .lsc_register_bGain_V_153(lsc_register_bGain_V_153),
    .lsc_register_bGain_V_154(lsc_register_bGain_V_154),
    .lsc_register_bGain_V_155(lsc_register_bGain_V_155),
    .lsc_register_bGain_V_156(lsc_register_bGain_V_156),
    .lsc_register_bGain_V_157(lsc_register_bGain_V_157),
    .lsc_register_bGain_V_158(lsc_register_bGain_V_158),
    .lsc_register_bGain_V_159(lsc_register_bGain_V_159),
    .lsc_register_bGain_V_160(lsc_register_bGain_V_160),
    .lsc_register_bGain_V_161(lsc_register_bGain_V_161),
    .lsc_register_bGain_V_162(lsc_register_bGain_V_162),
    .lsc_register_bGain_V_163(lsc_register_bGain_V_163),
    .lsc_register_bGain_V_164(lsc_register_bGain_V_164),
    .lsc_register_bGain_V_165(lsc_register_bGain_V_165),
    .lsc_register_bGain_V_166(lsc_register_bGain_V_166),
    .lsc_register_bGain_V_167(lsc_register_bGain_V_167),
    .lsc_register_bGain_V_168(lsc_register_bGain_V_168),
    .lsc_register_bGain_V_169(lsc_register_bGain_V_169),
    .lsc_register_bGain_V_170(lsc_register_bGain_V_170),
    .lsc_register_bGain_V_171(lsc_register_bGain_V_171),
    .lsc_register_bGain_V_172(lsc_register_bGain_V_172),
    .lsc_register_bGain_V_173(lsc_register_bGain_V_173),
    .lsc_register_bGain_V_174(lsc_register_bGain_V_174),
    .lsc_register_bGain_V_175(lsc_register_bGain_V_175),
    .lsc_register_bGain_V_176(lsc_register_bGain_V_176),
    .lsc_register_bGain_V_177(lsc_register_bGain_V_177),
    .lsc_register_bGain_V_178(lsc_register_bGain_V_178),
    .lsc_register_bGain_V_179(lsc_register_bGain_V_179),
    .lsc_register_bGain_V_180(lsc_register_bGain_V_180),
    .lsc_register_bGain_V_181(lsc_register_bGain_V_181),
    .lsc_register_bGain_V_182(lsc_register_bGain_V_182),
    .lsc_register_bGain_V_183(lsc_register_bGain_V_183),
    .lsc_register_bGain_V_184(lsc_register_bGain_V_184),
    .lsc_register_bGain_V_185(lsc_register_bGain_V_185),
    .lsc_register_bGain_V_186(lsc_register_bGain_V_186),
    .lsc_register_bGain_V_187(lsc_register_bGain_V_187),
    .lsc_register_bGain_V_188(lsc_register_bGain_V_188),
    .lsc_register_bGain_V_189(lsc_register_bGain_V_189),
    .lsc_register_bGain_V_190(lsc_register_bGain_V_190),
    .lsc_register_bGain_V_191(lsc_register_bGain_V_191),
    .lsc_register_bGain_V_192(lsc_register_bGain_V_192),
    .lsc_register_bGain_V_193(lsc_register_bGain_V_193),
    .lsc_register_bGain_V_194(lsc_register_bGain_V_194),
    .lsc_register_bGain_V_195(lsc_register_bGain_V_195),
    .lsc_register_bGain_V_196(lsc_register_bGain_V_196),
    .lsc_register_bGain_V_197(lsc_register_bGain_V_197),
    .lsc_register_bGain_V_198(lsc_register_bGain_V_198),
    .lsc_register_bGain_V_199(lsc_register_bGain_V_199),
    .lsc_register_bGain_V_200(lsc_register_bGain_V_200),
    .lsc_register_bGain_V_201(lsc_register_bGain_V_201),
    .lsc_register_bGain_V_202(lsc_register_bGain_V_202),
    .lsc_register_bGain_V_203(lsc_register_bGain_V_203),
    .lsc_register_bGain_V_204(lsc_register_bGain_V_204),
    .lsc_register_bGain_V_205(lsc_register_bGain_V_205),
    .lsc_register_bGain_V_206(lsc_register_bGain_V_206),
    .lsc_register_bGain_V_207(lsc_register_bGain_V_207),
    .lsc_register_bGain_V_208(lsc_register_bGain_V_208),
    .lsc_register_bGain_V_209(lsc_register_bGain_V_209),
    .lsc_register_bGain_V_210(lsc_register_bGain_V_210),
    .lsc_register_bGain_V_211(lsc_register_bGain_V_211),
    .lsc_register_bGain_V_212(lsc_register_bGain_V_212),
    .lsc_register_bGain_V_213(lsc_register_bGain_V_213),
    .lsc_register_bGain_V_214(lsc_register_bGain_V_214),
    .lsc_register_bGain_V_215(lsc_register_bGain_V_215),
    .lsc_register_bGain_V_216(lsc_register_bGain_V_216),
    .lsc_register_bGain_V_217(lsc_register_bGain_V_217),
    .lsc_register_bGain_V_218(lsc_register_bGain_V_218),
    .lsc_register_bGain_V_219(lsc_register_bGain_V_219),
    .lsc_register_bGain_V_220(lsc_register_bGain_V_220),
    .lsc_register_blockHeight_V(lsc_register_blockHeight_V),
    .lsc_register_blockWidth_V(lsc_register_blockWidth_V),
    .lsc_register_blockWidth_1_V(lsc_register_blockWidth_1_V),
    .lsc_register_blockHeight_1_V(lsc_register_blockHeight_1_V),
    .dpc_register_eb(dpc_register_eb),
    .dpc_register_th_w_V(dpc_register_th_w_V),
    .dpc_register_th_b_V(dpc_register_th_b_V),
    .rawdns_register_sigma_V(rawdns_register_sigma_V),
    .rawdns_register_eb_V(rawdns_register_eb_V),
    .rawdns_register_Filterpara_V(rawdns_register_Filterpara_V),
    .rawdns_register_invksigma2_V(rawdns_register_invksigma2_V),
    .awb_register_m_nEb(awb_register_m_nEb),
    .awb_register_r_gain_V(awb_register_r_gain_V),
    .awb_register_g_gain_V(awb_register_g_gain_V),
    .awb_register_b_gain_V(awb_register_b_gain_V),
    .awb_register_coeff_V(awb_register_coeff_V),
    .wbc_register_m_nEb(wbc_register_m_nEb),
    .wbc_register_m_nR_V(wbc_register_m_nR_V),
    .wbc_register_m_nGr_V(wbc_register_m_nGr_V),
    .wbc_register_m_nGb_V(wbc_register_m_nGb_V),
    .wbc_register_m_nB_V(wbc_register_m_nB_V),
    .gb_register_eb(gb_register_eb),
    .gb_register_win_size_V(gb_register_win_size_V),
    .gb_register_Lbound_V(gb_register_Lbound_V),
    .gb_register_Hbound_V(gb_register_Hbound_V),
    .gb_register_threhold_V(gb_register_threhold_V),
    .demosaic_register_eb(demosaic_register_eb),
    .ee_register_eb(ee_register_eb),
    .ee_register_coeff_V(ee_register_coeff_V),
    .cmc_register_m_nEb(cmc_register_m_nEb),
    .cmc_register_m_nGain_V_0(cmc_register_m_nGain_V_0),
    .cmc_register_m_nGain_V_1(cmc_register_m_nGain_V_1),
    .cmc_register_m_nGain_V_2(cmc_register_m_nGain_V_2),
    .cmc_register_m_nGain_V_3(cmc_register_m_nGain_V_3),
    .cmc_register_m_nGain_V_4(cmc_register_m_nGain_V_4),
    .cmc_register_m_nGain_V_5(cmc_register_m_nGain_V_5),
    .cmc_register_m_nGain_V_6(cmc_register_m_nGain_V_6),
    .cmc_register_m_nGain_V_7(cmc_register_m_nGain_V_7),
    .cmc_register_m_nGain_V_8(cmc_register_m_nGain_V_8),
    .cmc_register_m_nGain_V_9(cmc_register_m_nGain_V_9),
    .cmc_register_m_nGain_V_10(cmc_register_m_nGain_V_10),
    .cmc_register_m_nGain_V_11(cmc_register_m_nGain_V_11),
    .cmc_register_m_bCFCEnable(cmc_register_m_bCFCEnable),
    .cmc_register_m_bDiscardH(cmc_register_m_bDiscardH),
    .cmc_register_m_pHueRange_V_0(cmc_register_m_pHueRange_V_0),
    .cmc_register_m_pHueRange_V_1(cmc_register_m_pHueRange_V_1),
    .cmc_register_m_nHueBandShift_V(cmc_register_m_nHueBandShift_V),
    .cmc_register_m_nEdgeThre_V(cmc_register_m_nEdgeThre_V),
    .cmc_register_m_nEdgeBandShift_V(cmc_register_m_nEdgeBandShift_V),
    .cmc_register_m_nCFCStrength_V(cmc_register_m_nCFCStrength_V),
    .gtm_register_eb(gtm_register_eb),
    .gtm_register_m_bDitheringEnable(gtm_register_m_bDitheringEnable),
    .gtm_register_gtmTab_V_0(gtm_register_gtmTab_V_0),
    .gtm_register_gtmTab_V_1(gtm_register_gtmTab_V_1),
    .gtm_register_gtmTab_V_2(gtm_register_gtmTab_V_2),
    .gtm_register_gtmTab_V_3(gtm_register_gtmTab_V_3),
    .gtm_register_gtmTab_V_4(gtm_register_gtmTab_V_4),
    .gtm_register_gtmTab_V_5(gtm_register_gtmTab_V_5),
    .gtm_register_gtmTab_V_6(gtm_register_gtmTab_V_6),
    .gtm_register_gtmTab_V_7(gtm_register_gtmTab_V_7),
    .gtm_register_gtmTab_V_8(gtm_register_gtmTab_V_8),
    .gtm_register_gtmTab_V_9(gtm_register_gtmTab_V_9),
    .gtm_register_gtmTab_V_10(gtm_register_gtmTab_V_10),
    .gtm_register_gtmTab_V_11(gtm_register_gtmTab_V_11),
    .gtm_register_gtmTab_V_12(gtm_register_gtmTab_V_12),
    .gtm_register_gtmTab_V_13(gtm_register_gtmTab_V_13),
    .gtm_register_gtmTab_V_14(gtm_register_gtmTab_V_14),
    .gtm_register_gtmTab_V_15(gtm_register_gtmTab_V_15),
    .gtm_register_gtmTab_V_16(gtm_register_gtmTab_V_16),
    .gtm_register_gtmTab_V_17(gtm_register_gtmTab_V_17),
    .gtm_register_gtmTab_V_18(gtm_register_gtmTab_V_18),
    .gtm_register_gtmTab_V_19(gtm_register_gtmTab_V_19),
    .gtm_register_gtmTab_V_20(gtm_register_gtmTab_V_20),
    .gtm_register_gtmTab_V_21(gtm_register_gtmTab_V_21),
    .gtm_register_gtmTab_V_22(gtm_register_gtmTab_V_22),
    .gtm_register_gtmTab_V_23(gtm_register_gtmTab_V_23),
    .gtm_register_gtmTab_V_24(gtm_register_gtmTab_V_24),
    .gtm_register_gtmTab_V_25(gtm_register_gtmTab_V_25),
    .gtm_register_gtmTab_V_26(gtm_register_gtmTab_V_26),
    .gtm_register_gtmTab_V_27(gtm_register_gtmTab_V_27),
    .gtm_register_gtmTab_V_28(gtm_register_gtmTab_V_28),
    .gtm_register_gtmTab_V_29(gtm_register_gtmTab_V_29),
    .gtm_register_gtmTab_V_30(gtm_register_gtmTab_V_30),
    .gtm_register_gtmTab_V_31(gtm_register_gtmTab_V_31),
    .gtm_register_gtmTab_V_32(gtm_register_gtmTab_V_32),
    .gtm_register_gtmTab_V_33(gtm_register_gtmTab_V_33),
    .gtm_register_gtmTab_V_34(gtm_register_gtmTab_V_34),
    .gtm_register_gtmTab_V_35(gtm_register_gtmTab_V_35),
    .gtm_register_gtmTab_V_36(gtm_register_gtmTab_V_36),
    .gtm_register_gtmTab_V_37(gtm_register_gtmTab_V_37),
    .gtm_register_gtmTab_V_38(gtm_register_gtmTab_V_38),
    .gtm_register_gtmTab_V_39(gtm_register_gtmTab_V_39),
    .gtm_register_gtmTab_V_40(gtm_register_gtmTab_V_40),
    .gtm_register_gtmTab_V_41(gtm_register_gtmTab_V_41),
    .gtm_register_gtmTab_V_42(gtm_register_gtmTab_V_42),
    .gtm_register_gtmTab_V_43(gtm_register_gtmTab_V_43),
    .gtm_register_gtmTab_V_44(gtm_register_gtmTab_V_44),
    .gtm_register_gtmTab_V_45(gtm_register_gtmTab_V_45),
    .gtm_register_gtmTab_V_46(gtm_register_gtmTab_V_46),
    .gtm_register_gtmTab_V_47(gtm_register_gtmTab_V_47),
    .gtm_register_gtmTab_V_48(gtm_register_gtmTab_V_48),
    .gtm_register_gtmTab_V_49(gtm_register_gtmTab_V_49),
    .gtm_register_gtmTab_V_50(gtm_register_gtmTab_V_50),
    .gtm_register_gtmTab_V_51(gtm_register_gtmTab_V_51),
    .gtm_register_gtmTab_V_52(gtm_register_gtmTab_V_52),
    .gtm_register_gtmTab_V_53(gtm_register_gtmTab_V_53),
    .gtm_register_gtmTab_V_54(gtm_register_gtmTab_V_54),
    .gtm_register_gtmTab_V_55(gtm_register_gtmTab_V_55),
    .gtm_register_gtmTab_V_56(gtm_register_gtmTab_V_56),
    .gtm_register_gtmTab_V_57(gtm_register_gtmTab_V_57),
    .gtm_register_gtmTab_V_58(gtm_register_gtmTab_V_58),
    .gtm_register_gtmTab_V_59(gtm_register_gtmTab_V_59),
    .gtm_register_gtmTab_V_60(gtm_register_gtmTab_V_60),
    .gtm_register_gtmTab_V_61(gtm_register_gtmTab_V_61),
    .gtm_register_gtmTab_V_62(gtm_register_gtmTab_V_62),
    .gtm_register_gtmTab_V_63(gtm_register_gtmTab_V_63),
    .gtm_register_gtmTab_V_64(gtm_register_gtmTab_V_64),
    .gtm_register_gtmTab_V_65(gtm_register_gtmTab_V_65),
    .gtm_register_gtmTab_V_66(gtm_register_gtmTab_V_66),
    .gtm_register_gtmTab_V_67(gtm_register_gtmTab_V_67),
    .gtm_register_gtmTab_V_68(gtm_register_gtmTab_V_68),
    .gtm_register_gtmTab_V_69(gtm_register_gtmTab_V_69),
    .gtm_register_gtmTab_V_70(gtm_register_gtmTab_V_70),
    .gtm_register_gtmTab_V_71(gtm_register_gtmTab_V_71),
    .gtm_register_gtmTab_V_72(gtm_register_gtmTab_V_72),
    .gtm_register_gtmTab_V_73(gtm_register_gtmTab_V_73),
    .gtm_register_gtmTab_V_74(gtm_register_gtmTab_V_74),
    .gtm_register_gtmTab_V_75(gtm_register_gtmTab_V_75),
    .gtm_register_gtmTab_V_76(gtm_register_gtmTab_V_76),
    .gtm_register_gtmTab_V_77(gtm_register_gtmTab_V_77),
    .gtm_register_gtmTab_V_78(gtm_register_gtmTab_V_78),
    .gtm_register_gtmTab_V_79(gtm_register_gtmTab_V_79),
    .gtm_register_gtmTab_V_80(gtm_register_gtmTab_V_80),
    .gtm_register_gtmTab_V_81(gtm_register_gtmTab_V_81),
    .gtm_register_gtmTab_V_82(gtm_register_gtmTab_V_82),
    .gtm_register_gtmTab_V_83(gtm_register_gtmTab_V_83),
    .gtm_register_gtmTab_V_84(gtm_register_gtmTab_V_84),
    .gtm_register_gtmTab_V_85(gtm_register_gtmTab_V_85),
    .gtm_register_gtmTab_V_86(gtm_register_gtmTab_V_86),
    .gtm_register_gtmTab_V_87(gtm_register_gtmTab_V_87),
    .gtm_register_gtmTab_V_88(gtm_register_gtmTab_V_88),
    .gtm_register_gtmTab_V_89(gtm_register_gtmTab_V_89),
    .gtm_register_gtmTab_V_90(gtm_register_gtmTab_V_90),
    .gtm_register_gtmTab_V_91(gtm_register_gtmTab_V_91),
    .gtm_register_gtmTab_V_92(gtm_register_gtmTab_V_92),
    .gtm_register_gtmTab_V_93(gtm_register_gtmTab_V_93),
    .gtm_register_gtmTab_V_94(gtm_register_gtmTab_V_94),
    .gtm_register_gtmTab_V_95(gtm_register_gtmTab_V_95),
    .gtm_register_gtmTab_V_96(gtm_register_gtmTab_V_96),
    .gtm_register_gtmTab_V_97(gtm_register_gtmTab_V_97),
    .gtm_register_gtmTab_V_98(gtm_register_gtmTab_V_98),
    .gtm_register_gtmTab_V_99(gtm_register_gtmTab_V_99),
    .gtm_register_gtmTab_V_100(gtm_register_gtmTab_V_100),
    .gtm_register_gtmTab_V_101(gtm_register_gtmTab_V_101),
    .gtm_register_gtmTab_V_102(gtm_register_gtmTab_V_102),
    .gtm_register_gtmTab_V_103(gtm_register_gtmTab_V_103),
    .gtm_register_gtmTab_V_104(gtm_register_gtmTab_V_104),
    .gtm_register_gtmTab_V_105(gtm_register_gtmTab_V_105),
    .gtm_register_gtmTab_V_106(gtm_register_gtmTab_V_106),
    .gtm_register_gtmTab_V_107(gtm_register_gtmTab_V_107),
    .gtm_register_gtmTab_V_108(gtm_register_gtmTab_V_108),
    .gtm_register_gtmTab_V_109(gtm_register_gtmTab_V_109),
    .gtm_register_gtmTab_V_110(gtm_register_gtmTab_V_110),
    .gtm_register_gtmTab_V_111(gtm_register_gtmTab_V_111),
    .gtm_register_gtmTab_V_112(gtm_register_gtmTab_V_112),
    .gtm_register_gtmTab_V_113(gtm_register_gtmTab_V_113),
    .gtm_register_gtmTab_V_114(gtm_register_gtmTab_V_114),
    .gtm_register_gtmTab_V_115(gtm_register_gtmTab_V_115),
    .gtm_register_gtmTab_V_116(gtm_register_gtmTab_V_116),
    .gtm_register_gtmTab_V_117(gtm_register_gtmTab_V_117),
    .gtm_register_gtmTab_V_118(gtm_register_gtmTab_V_118),
    .gtm_register_gtmTab_V_119(gtm_register_gtmTab_V_119),
    .gtm_register_gtmTab_V_120(gtm_register_gtmTab_V_120),
    .gtm_register_gtmTab_V_121(gtm_register_gtmTab_V_121),
    .gtm_register_gtmTab_V_122(gtm_register_gtmTab_V_122),
    .gtm_register_gtmTab_V_123(gtm_register_gtmTab_V_123),
    .gtm_register_gtmTab_V_124(gtm_register_gtmTab_V_124),
    .gtm_register_gtmTab_V_125(gtm_register_gtmTab_V_125),
    .gtm_register_gtmTab_V_126(gtm_register_gtmTab_V_126),
    .gtm_register_gtmTab_V_127(gtm_register_gtmTab_V_127),
    .gtm_register_gtmTab_V_128(gtm_register_gtmTab_V_128),
    .ltm_register_m_nEb_V(ltm_register_m_nEb_V),
    .ltm_register_contrast_V(ltm_register_contrast_V),
    .ltm_register_ratio_V(ltm_register_ratio_V),
    .cac_register_eb(cac_register_eb),
    .cac_register_t_transient_V(cac_register_t_transient_V),
    .cac_register_t_edge_V(cac_register_t_edge_V),
    .csc_register_m_nEb(csc_register_m_nEb),
    .csc_register_coeff_V_0(csc_register_coeff_V_0),
    .csc_register_coeff_V_1(csc_register_coeff_V_1),
    .csc_register_coeff_V_2(csc_register_coeff_V_2),
    .csc_register_coeff_V_3(csc_register_coeff_V_3),
    .csc_register_coeff_V_4(csc_register_coeff_V_4),
    .csc_register_coeff_V_5(csc_register_coeff_V_5),
    .csc_register_coeff_V_6(csc_register_coeff_V_6),
    .csc_register_coeff_V_7(csc_register_coeff_V_7),
    .csc_register_coeff_V_8(csc_register_coeff_V_8),
    .csc_register_coeff_V_9(csc_register_coeff_V_9),
    .csc_register_coeff_V_10(csc_register_coeff_V_10),
    .csc_register_coeff_V_11(csc_register_coeff_V_11),
    .yfc_register_m_nEb(yfc_register_m_nEb),
    .yfc_register_yuvpattern(yfc_register_yuvpattern),
    .yuvdns_register_eb_V(yuvdns_register_eb_V),
    .yuvdns_register_ysigma2_V(yuvdns_register_ysigma2_V),
    .yuvdns_register_yinvsigma2_V(yuvdns_register_yinvsigma2_V),
    .yuvdns_register_uvsigma2_V(yuvdns_register_uvsigma2_V),
    .yuvdns_register_uvinvsigma2_V(yuvdns_register_uvinvsigma2_V),
    .yuvdns_register_yfilt_V(yuvdns_register_yfilt_V),
    .yuvdns_register_uvfilt_V(yuvdns_register_uvfilt_V),
    .yuvdns_register_yinvfilt_V(yuvdns_register_yinvfilt_V),
    .yuvdns_register_uvinvfilt_V(yuvdns_register_uvinvfilt_V),
    .yuvdns_register_yH2_V(yuvdns_register_yH2_V),
    .yuvdns_register_yinvH2_V(yuvdns_register_yinvH2_V),
    .yuvdns_register_uvH2_V(yuvdns_register_uvH2_V),
    .yuvdns_register_uvinvH2_V(yuvdns_register_uvinvH2_V),
    .scaledown_register_m_nEb(scaledown_register_m_nEb),
    .scaledown_register_yuvpattern_V(scaledown_register_yuvpattern_V),
    .scaledown_register_times_V(scaledown_register_times_V),
    .crop_register_m_nEb(crop_register_m_nEb),
    .crop_register_upper_left_x_V(crop_register_upper_left_x_V),
    .crop_register_upper_left_y_V(crop_register_upper_left_y_V),
    .crop_register_lower_right_x_V(crop_register_lower_right_x_V),
    .crop_register_lower_right_y_V(crop_register_lower_right_y_V),
    .crop_register_yuvpattern_V(crop_register_yuvpattern_V),
    .isp_read_raw_addr(isp_read_raw_addr),
    .isp_write_y_addr(isp_write_y_addr),
    .isp_write_u_addr(isp_write_u_addr),
    .isp_write_v_addr(isp_write_v_addr),
    .burst_one_frame_total(burst_one_frame_total)
);

fifo_in #(
    FIFO_WDATA_WIDTH (64),
    FIFO_RDATA_WIDTH (16),
    FIFO_DEPTH (4096)
)
fifo_in_u0
(
    .clk(CLK),
    .rst_n(RST_N),
    .wr_en(w_en),
    .wr_data(wr_data),
    .full_n(full_n),
    .rd_en(src_V_V_read),
    .rd_data(fifo_rd_data),
    .empty_n(src_V_V_empty_n)
);

isp_maxi_full isp_maxil_full_u0
(
	.M_AXI_ACLK(CLK),
	.M_AXI_ARESETN(RST_N),
	.M_AXI_AWID(M_AXI_AWID),
	.M_AXI_AWADDR(M_AXI_AWADDR),
	.M_AXI_AWLEN(M_AXI_AWLEN),
	.M_AXI_AWSIZE(M_AXI_AWSIZE),
	.M_AXI_AWBURST(M_AXI_AWBURST),
	.M_AXI_AWLOCK(M_AXI_AWLOCK),
	.M_AXI_AWCACHE(M_AXI_AWCACHE),
	.M_AXI_AWPROT(M_AXI_AWPROT),
	.M_AXI_AWVALID(M_AXI_AWVALID),
	.M_AXI_AWREADY(M_AXI_AWREADY),
	.M_AXI_WDATA(M_AXI_WDATA),
	.M_AXI_WSTRB(M_AXI_WSTRB),
	.M_AXI_WLAST(M_AXI_WLAST),
	.M_AXI_WVALID(M_AXI_WVALID),
	.M_AXI_WREADY(M_AXI_WREADY),
	.M_AXI_BID(M_AXI_BID),
	.M_AXI_BRESP(M_AXI_BRESP),
	.M_AXI_BVALID(M_AXI_BVALID),
	.M_AXI_BREADY(M_AXI_BREADY),
	.M_AXI_ARID(M_AXI_ARID),
	.M_AXI_ARADDR(M_AXI_ARADDR),
	.M_AXI_ARLEN(M_AXI_ARLEN),
	.M_AXI_ARSIZE(M_AXI_ARSIZE),
	.M_AXI_ARBURST(M_AXI_ARBURST),
	.M_AXI_ARLOCK(M_AXI_ARLOCK),
	.M_AXI_ARCACHE(M_AXI_ARCACHE),
	.M_AXI_ARPROT(M_AXI_ARPROT),
	.M_AXI_ARVALID(M_AXI_ARVALID),
	.M_AXI_ARREADY(M_AXI_ARREADY),
	.M_AXI_RID(M_AXI_RID),
	.M_AXI_RDATA(M_AXI_RDATA),
	.M_AXI_RRESP(M_AXI_RRESP),
	.M_AXI_RLAST(M_AXI_RLAST),
	.M_AXI_RVALID(M_AXI_RVALID),
	.M_AXI_RREADY(M_AXI_RREADY),
	.READ_START(READ_START),
	.BURST_ONE_FRAME_TOTAL(burst_one_frame_total),
	.wr_data(wr_data),
	.w_en(w_en),
	.full_n(full_n)
);

endmodule



