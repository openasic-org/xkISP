// ==============================================================
// ISP axi-lite wrapper
// 
// ==============================================================
`timescale 1ns/1ps
module isp_axil
#(parameter
    C_S_AXI_ADDR_WIDTH = 10,
    C_S_AXI_DATA_WIDTH = 32
)(
    /*********AXI-Lite Slave Interface*********/
    input  wire                          ACLK,
    input  wire                          ARESET,
    input  wire                          ACLK_EN,
    input  wire [C_S_AXI_ADDR_WIDTH-1:0] AWADDR,
    input  wire                          AWVALID,
    output wire                          AWREADY,
    input  wire [C_S_AXI_DATA_WIDTH-1:0] WDATA,
    input  wire [C_S_AXI_DATA_WIDTH/8-1:0] WSTRB,
    input  wire                          WVALID,
    output wire                          WREADY,
    output wire [1:0]                    BRESP,
    output wire                          BVALID,
    input  wire                          BREADY,
    input  wire [C_S_AXI_ADDR_WIDTH-1:0] ARADDR,
    input  wire                          ARVALID,
    output wire                          ARREADY,
    output wire [C_S_AXI_DATA_WIDTH-1:0] RDATA,
    output wire [1:0]                    RRESP,
    output wire                          RVALID,
    input  wire                          RREADY,
    /*******************************************/
    output wire                          read_start,
    input  wire                          ap_done,
    input  wire                          ap_ready,
    input  wire                          ap_idle,
    /*********************************************/
    output wire  [12:0] top_register_frameWidth_V,
    output wire  [12:0] top_register_frameHeight_V,
    output wire  [0:0] top_register_inputFormat,
    output wire  [1:0] top_register_imgPattern_V,
    output wire  [1:0] top_register_pipeMode_V,
    output wire  [8:0] top_register_blc_V,
    output wire  [0:0] top_register_shadowEb,
    output wire  [12:0] top_register_binningFrameWidth_V,
    output wire  [12:0] top_register_binningFrameHeight_V,
    output wire  [12:0] top_register_scalerFrameWidth_V,
    output wire  [12:0] top_register_scalerFrameHeight_V,
    output wire  [0:0] tpg_register_m_bTPG_en,
    output wire  [12:0] tpg_register_m_nWidth_V,
    output wire  [12:0] tpg_register_m_nHeight_V,
    output wire  [1:0] tpg_register_m_nCFAPattern_V,
    output wire  [0:0] tpg_register_m_bRollingEnable,
    output wire  [0:0] tpg_register_m_bSensor_timing_en,
    output wire  [11:0] tpg_register_m_nVBlank_num_V,
    output wire  [11:0] tpg_register_m_nHBlank_num_V,
    output wire  [7:0] tpg_register_m_valid_blank_V,
    output wire  [2:0] tpg_register_m_nID_V,
    output wire  [0:0] dgain_register_m_nEb,
    output wire  [8:0] dgain_register_m_nBlcR_V,
    output wire  [8:0] dgain_register_m_nBlcGr_V,
    output wire  [8:0] dgain_register_m_nBlcGb_V,
    output wire  [8:0] dgain_register_m_nBlcB_V,
    output wire  [19:0] dgain_register_m_nR_V,
    output wire  [19:0] dgain_register_m_nGr_V,
    output wire  [19:0] dgain_register_m_nGb_V,
    output wire  [19:0] dgain_register_m_nB_V,
    output wire  [0:0] lsc_register_eb,
    output wire  [12:0] lsc_register_rGain_V_0,
    output wire  [12:0] lsc_register_rGain_V_1,
    output wire  [12:0] lsc_register_rGain_V_2,
    output wire  [12:0] lsc_register_rGain_V_3,
    output wire  [12:0] lsc_register_rGain_V_4,
    output wire  [12:0] lsc_register_rGain_V_5,
    output wire  [12:0] lsc_register_rGain_V_6,
    output wire  [12:0] lsc_register_rGain_V_7,
    output wire  [12:0] lsc_register_rGain_V_8,
    output wire  [12:0] lsc_register_rGain_V_9,
    output wire  [12:0] lsc_register_rGain_V_10,
    output wire  [12:0] lsc_register_rGain_V_11,
    output wire  [12:0] lsc_register_rGain_V_12,
    output wire  [12:0] lsc_register_rGain_V_13,
    output wire  [12:0] lsc_register_rGain_V_14,
    output wire  [12:0] lsc_register_rGain_V_15,
    output wire  [12:0] lsc_register_rGain_V_16,
    output wire  [12:0] lsc_register_rGain_V_17,
    output wire  [12:0] lsc_register_rGain_V_18,
    output wire  [12:0] lsc_register_rGain_V_19,
    output wire  [12:0] lsc_register_rGain_V_20,
    output wire  [12:0] lsc_register_rGain_V_21,
    output wire  [12:0] lsc_register_rGain_V_22,
    output wire  [12:0] lsc_register_rGain_V_23,
    output wire  [12:0] lsc_register_rGain_V_24,
    output wire  [12:0] lsc_register_rGain_V_25,
    output wire  [12:0] lsc_register_rGain_V_26,
    output wire  [12:0] lsc_register_rGain_V_27,
    output wire  [12:0] lsc_register_rGain_V_28,
    output wire  [12:0] lsc_register_rGain_V_29,
    output wire  [12:0] lsc_register_rGain_V_30,
    output wire  [12:0] lsc_register_rGain_V_31,
    output wire  [12:0] lsc_register_rGain_V_32,
    output wire  [12:0] lsc_register_rGain_V_33,
    output wire  [12:0] lsc_register_rGain_V_34,
    output wire  [12:0] lsc_register_rGain_V_35,
    output wire  [12:0] lsc_register_rGain_V_36,
    output wire  [12:0] lsc_register_rGain_V_37,
    output wire  [12:0] lsc_register_rGain_V_38,
    output wire  [12:0] lsc_register_rGain_V_39,
    output wire  [12:0] lsc_register_rGain_V_40,
    output wire  [12:0] lsc_register_rGain_V_41,
    output wire  [12:0] lsc_register_rGain_V_42,
    output wire  [12:0] lsc_register_rGain_V_43,
    output wire  [12:0] lsc_register_rGain_V_44,
    output wire  [12:0] lsc_register_rGain_V_45,
    output wire  [12:0] lsc_register_rGain_V_46,
    output wire  [12:0] lsc_register_rGain_V_47,
    output wire  [12:0] lsc_register_rGain_V_48,
    output wire  [12:0] lsc_register_rGain_V_49,
    output wire  [12:0] lsc_register_rGain_V_50,
    output wire  [12:0] lsc_register_rGain_V_51,
    output wire  [12:0] lsc_register_rGain_V_52,
    output wire  [12:0] lsc_register_rGain_V_53,
    output wire  [12:0] lsc_register_rGain_V_54,
    output wire  [12:0] lsc_register_rGain_V_55,
    output wire  [12:0] lsc_register_rGain_V_56,
    output wire  [12:0] lsc_register_rGain_V_57,
    output wire  [12:0] lsc_register_rGain_V_58,
    output wire  [12:0] lsc_register_rGain_V_59,
    output wire  [12:0] lsc_register_rGain_V_60,
    output wire  [12:0] lsc_register_rGain_V_61,
    output wire  [12:0] lsc_register_rGain_V_62,
    output wire  [12:0] lsc_register_rGain_V_63,
    output wire  [12:0] lsc_register_rGain_V_64,
    output wire  [12:0] lsc_register_rGain_V_65,
    output wire  [12:0] lsc_register_rGain_V_66,
    output wire  [12:0] lsc_register_rGain_V_67,
    output wire  [12:0] lsc_register_rGain_V_68,
    output wire  [12:0] lsc_register_rGain_V_69,
    output wire  [12:0] lsc_register_rGain_V_70,
    output wire  [12:0] lsc_register_rGain_V_71,
    output wire  [12:0] lsc_register_rGain_V_72,
    output wire  [12:0] lsc_register_rGain_V_73,
    output wire  [12:0] lsc_register_rGain_V_74,
    output wire  [12:0] lsc_register_rGain_V_75,
    output wire  [12:0] lsc_register_rGain_V_76,
    output wire  [12:0] lsc_register_rGain_V_77,
    output wire  [12:0] lsc_register_rGain_V_78,
    output wire  [12:0] lsc_register_rGain_V_79,
    output wire  [12:0] lsc_register_rGain_V_80,
    output wire  [12:0] lsc_register_rGain_V_81,
    output wire  [12:0] lsc_register_rGain_V_82,
    output wire  [12:0] lsc_register_rGain_V_83,
    output wire  [12:0] lsc_register_rGain_V_84,
    output wire  [12:0] lsc_register_rGain_V_85,
    output wire  [12:0] lsc_register_rGain_V_86,
    output wire  [12:0] lsc_register_rGain_V_87,
    output wire  [12:0] lsc_register_rGain_V_88,
    output wire  [12:0] lsc_register_rGain_V_89,
    output wire  [12:0] lsc_register_rGain_V_90,
    output wire  [12:0] lsc_register_rGain_V_91,
    output wire  [12:0] lsc_register_rGain_V_92,
    output wire  [12:0] lsc_register_rGain_V_93,
    output wire  [12:0] lsc_register_rGain_V_94,
    output wire  [12:0] lsc_register_rGain_V_95,
    output wire  [12:0] lsc_register_rGain_V_96,
    output wire  [12:0] lsc_register_rGain_V_97,
    output wire  [12:0] lsc_register_rGain_V_98,
    output wire  [12:0] lsc_register_rGain_V_99,
    output wire  [12:0] lsc_register_rGain_V_100,
    output wire  [12:0] lsc_register_rGain_V_101,
    output wire  [12:0] lsc_register_rGain_V_102,
    output wire  [12:0] lsc_register_rGain_V_103,
    output wire  [12:0] lsc_register_rGain_V_104,
    output wire  [12:0] lsc_register_rGain_V_105,
    output wire  [12:0] lsc_register_rGain_V_106,
    output wire  [12:0] lsc_register_rGain_V_107,
    output wire  [12:0] lsc_register_rGain_V_108,
    output wire  [12:0] lsc_register_rGain_V_109,
    output wire  [12:0] lsc_register_rGain_V_110,
    output wire  [12:0] lsc_register_rGain_V_111,
    output wire  [12:0] lsc_register_rGain_V_112,
    output wire  [12:0] lsc_register_rGain_V_113,
    output wire  [12:0] lsc_register_rGain_V_114,
    output wire  [12:0] lsc_register_rGain_V_115,
    output wire  [12:0] lsc_register_rGain_V_116,
    output wire  [12:0] lsc_register_rGain_V_117,
    output wire  [12:0] lsc_register_rGain_V_118,
    output wire  [12:0] lsc_register_rGain_V_119,
    output wire  [12:0] lsc_register_rGain_V_120,
    output wire  [12:0] lsc_register_rGain_V_121,
    output wire  [12:0] lsc_register_rGain_V_122,
    output wire  [12:0] lsc_register_rGain_V_123,
    output wire  [12:0] lsc_register_rGain_V_124,
    output wire  [12:0] lsc_register_rGain_V_125,
    output wire  [12:0] lsc_register_rGain_V_126,
    output wire  [12:0] lsc_register_rGain_V_127,
    output wire  [12:0] lsc_register_rGain_V_128,
    output wire  [12:0] lsc_register_rGain_V_129,
    output wire  [12:0] lsc_register_rGain_V_130,
    output wire  [12:0] lsc_register_rGain_V_131,
    output wire  [12:0] lsc_register_rGain_V_132,
    output wire  [12:0] lsc_register_rGain_V_133,
    output wire  [12:0] lsc_register_rGain_V_134,
    output wire  [12:0] lsc_register_rGain_V_135,
    output wire  [12:0] lsc_register_rGain_V_136,
    output wire  [12:0] lsc_register_rGain_V_137,
    output wire  [12:0] lsc_register_rGain_V_138,
    output wire  [12:0] lsc_register_rGain_V_139,
    output wire  [12:0] lsc_register_rGain_V_140,
    output wire  [12:0] lsc_register_rGain_V_141,
    output wire  [12:0] lsc_register_rGain_V_142,
    output wire  [12:0] lsc_register_rGain_V_143,
    output wire  [12:0] lsc_register_rGain_V_144,
    output wire  [12:0] lsc_register_rGain_V_145,
    output wire  [12:0] lsc_register_rGain_V_146,
    output wire  [12:0] lsc_register_rGain_V_147,
    output wire  [12:0] lsc_register_rGain_V_148,
    output wire  [12:0] lsc_register_rGain_V_149,
    output wire  [12:0] lsc_register_rGain_V_150,
    output wire  [12:0] lsc_register_rGain_V_151,
    output wire  [12:0] lsc_register_rGain_V_152,
    output wire  [12:0] lsc_register_rGain_V_153,
    output wire  [12:0] lsc_register_rGain_V_154,
    output wire  [12:0] lsc_register_rGain_V_155,
    output wire  [12:0] lsc_register_rGain_V_156,
    output wire  [12:0] lsc_register_rGain_V_157,
    output wire  [12:0] lsc_register_rGain_V_158,
    output wire  [12:0] lsc_register_rGain_V_159,
    output wire  [12:0] lsc_register_rGain_V_160,
    output wire  [12:0] lsc_register_rGain_V_161,
    output wire  [12:0] lsc_register_rGain_V_162,
    output wire  [12:0] lsc_register_rGain_V_163,
    output wire  [12:0] lsc_register_rGain_V_164,
    output wire  [12:0] lsc_register_rGain_V_165,
    output wire  [12:0] lsc_register_rGain_V_166,
    output wire  [12:0] lsc_register_rGain_V_167,
    output wire  [12:0] lsc_register_rGain_V_168,
    output wire  [12:0] lsc_register_rGain_V_169,
    output wire  [12:0] lsc_register_rGain_V_170,
    output wire  [12:0] lsc_register_rGain_V_171,
    output wire  [12:0] lsc_register_rGain_V_172,
    output wire  [12:0] lsc_register_rGain_V_173,
    output wire  [12:0] lsc_register_rGain_V_174,
    output wire  [12:0] lsc_register_rGain_V_175,
    output wire  [12:0] lsc_register_rGain_V_176,
    output wire  [12:0] lsc_register_rGain_V_177,
    output wire  [12:0] lsc_register_rGain_V_178,
    output wire  [12:0] lsc_register_rGain_V_179,
    output wire  [12:0] lsc_register_rGain_V_180,
    output wire  [12:0] lsc_register_rGain_V_181,
    output wire  [12:0] lsc_register_rGain_V_182,
    output wire  [12:0] lsc_register_rGain_V_183,
    output wire  [12:0] lsc_register_rGain_V_184,
    output wire  [12:0] lsc_register_rGain_V_185,
    output wire  [12:0] lsc_register_rGain_V_186,
    output wire  [12:0] lsc_register_rGain_V_187,
    output wire  [12:0] lsc_register_rGain_V_188,
    output wire  [12:0] lsc_register_rGain_V_189,
    output wire  [12:0] lsc_register_rGain_V_190,
    output wire  [12:0] lsc_register_rGain_V_191,
    output wire  [12:0] lsc_register_rGain_V_192,
    output wire  [12:0] lsc_register_rGain_V_193,
    output wire  [12:0] lsc_register_rGain_V_194,
    output wire  [12:0] lsc_register_rGain_V_195,
    output wire  [12:0] lsc_register_rGain_V_196,
    output wire  [12:0] lsc_register_rGain_V_197,
    output wire  [12:0] lsc_register_rGain_V_198,
    output wire  [12:0] lsc_register_rGain_V_199,
    output wire  [12:0] lsc_register_rGain_V_200,
    output wire  [12:0] lsc_register_rGain_V_201,
    output wire  [12:0] lsc_register_rGain_V_202,
    output wire  [12:0] lsc_register_rGain_V_203,
    output wire  [12:0] lsc_register_rGain_V_204,
    output wire  [12:0] lsc_register_rGain_V_205,
    output wire  [12:0] lsc_register_rGain_V_206,
    output wire  [12:0] lsc_register_rGain_V_207,
    output wire  [12:0] lsc_register_rGain_V_208,
    output wire  [12:0] lsc_register_rGain_V_209,
    output wire  [12:0] lsc_register_rGain_V_210,
    output wire  [12:0] lsc_register_rGain_V_211,
    output wire  [12:0] lsc_register_rGain_V_212,
    output wire  [12:0] lsc_register_rGain_V_213,
    output wire  [12:0] lsc_register_rGain_V_214,
    output wire  [12:0] lsc_register_rGain_V_215,
    output wire  [12:0] lsc_register_rGain_V_216,
    output wire  [12:0] lsc_register_rGain_V_217,
    output wire  [12:0] lsc_register_rGain_V_218,
    output wire  [12:0] lsc_register_rGain_V_219,
    output wire  [12:0] lsc_register_rGain_V_220,
    output wire  [12:0] lsc_register_GrGain_V_0,
    output wire  [12:0] lsc_register_GrGain_V_1,
    output wire  [12:0] lsc_register_GrGain_V_2,
    output wire  [12:0] lsc_register_GrGain_V_3,
    output wire  [12:0] lsc_register_GrGain_V_4,
    output wire  [12:0] lsc_register_GrGain_V_5,
    output wire  [12:0] lsc_register_GrGain_V_6,
    output wire  [12:0] lsc_register_GrGain_V_7,
    output wire  [12:0] lsc_register_GrGain_V_8,
    output wire  [12:0] lsc_register_GrGain_V_9,
    output wire  [12:0] lsc_register_GrGain_V_10,
    output wire  [12:0] lsc_register_GrGain_V_11,
    output wire  [12:0] lsc_register_GrGain_V_12,
    output wire  [12:0] lsc_register_GrGain_V_13,
    output wire  [12:0] lsc_register_GrGain_V_14,
    output wire  [12:0] lsc_register_GrGain_V_15,
    output wire  [12:0] lsc_register_GrGain_V_16,
    output wire  [12:0] lsc_register_GrGain_V_17,
    output wire  [12:0] lsc_register_GrGain_V_18,
    output wire  [12:0] lsc_register_GrGain_V_19,
    output wire  [12:0] lsc_register_GrGain_V_20,
    output wire  [12:0] lsc_register_GrGain_V_21,
    output wire  [12:0] lsc_register_GrGain_V_22,
    output wire  [12:0] lsc_register_GrGain_V_23,
    output wire  [12:0] lsc_register_GrGain_V_24,
    output wire  [12:0] lsc_register_GrGain_V_25,
    output wire  [12:0] lsc_register_GrGain_V_26,
    output wire  [12:0] lsc_register_GrGain_V_27,
    output wire  [12:0] lsc_register_GrGain_V_28,
    output wire  [12:0] lsc_register_GrGain_V_29,
    output wire  [12:0] lsc_register_GrGain_V_30,
    output wire  [12:0] lsc_register_GrGain_V_31,
    output wire  [12:0] lsc_register_GrGain_V_32,
    output wire  [12:0] lsc_register_GrGain_V_33,
    output wire  [12:0] lsc_register_GrGain_V_34,
    output wire  [12:0] lsc_register_GrGain_V_35,
    output wire  [12:0] lsc_register_GrGain_V_36,
    output wire  [12:0] lsc_register_GrGain_V_37,
    output wire  [12:0] lsc_register_GrGain_V_38,
    output wire  [12:0] lsc_register_GrGain_V_39,
    output wire  [12:0] lsc_register_GrGain_V_40,
    output wire  [12:0] lsc_register_GrGain_V_41,
    output wire  [12:0] lsc_register_GrGain_V_42,
    output wire  [12:0] lsc_register_GrGain_V_43,
    output wire  [12:0] lsc_register_GrGain_V_44,
    output wire  [12:0] lsc_register_GrGain_V_45,
    output wire  [12:0] lsc_register_GrGain_V_46,
    output wire  [12:0] lsc_register_GrGain_V_47,
    output wire  [12:0] lsc_register_GrGain_V_48,
    output wire  [12:0] lsc_register_GrGain_V_49,
    output wire  [12:0] lsc_register_GrGain_V_50,
    output wire  [12:0] lsc_register_GrGain_V_51,
    output wire  [12:0] lsc_register_GrGain_V_52,
    output wire  [12:0] lsc_register_GrGain_V_53,
    output wire  [12:0] lsc_register_GrGain_V_54,
    output wire  [12:0] lsc_register_GrGain_V_55,
    output wire  [12:0] lsc_register_GrGain_V_56,
    output wire  [12:0] lsc_register_GrGain_V_57,
    output wire  [12:0] lsc_register_GrGain_V_58,
    output wire  [12:0] lsc_register_GrGain_V_59,
    output wire  [12:0] lsc_register_GrGain_V_60,
    output wire  [12:0] lsc_register_GrGain_V_61,
    output wire  [12:0] lsc_register_GrGain_V_62,
    output wire  [12:0] lsc_register_GrGain_V_63,
    output wire  [12:0] lsc_register_GrGain_V_64,
    output wire  [12:0] lsc_register_GrGain_V_65,
    output wire  [12:0] lsc_register_GrGain_V_66,
    output wire  [12:0] lsc_register_GrGain_V_67,
    output wire  [12:0] lsc_register_GrGain_V_68,
    output wire  [12:0] lsc_register_GrGain_V_69,
    output wire  [12:0] lsc_register_GrGain_V_70,
    output wire  [12:0] lsc_register_GrGain_V_71,
    output wire  [12:0] lsc_register_GrGain_V_72,
    output wire  [12:0] lsc_register_GrGain_V_73,
    output wire  [12:0] lsc_register_GrGain_V_74,
    output wire  [12:0] lsc_register_GrGain_V_75,
    output wire  [12:0] lsc_register_GrGain_V_76,
    output wire  [12:0] lsc_register_GrGain_V_77,
    output wire  [12:0] lsc_register_GrGain_V_78,
    output wire  [12:0] lsc_register_GrGain_V_79,
    output wire  [12:0] lsc_register_GrGain_V_80,
    output wire  [12:0] lsc_register_GrGain_V_81,
    output wire  [12:0] lsc_register_GrGain_V_82,
    output wire  [12:0] lsc_register_GrGain_V_83,
    output wire  [12:0] lsc_register_GrGain_V_84,
    output wire  [12:0] lsc_register_GrGain_V_85,
    output wire  [12:0] lsc_register_GrGain_V_86,
    output wire  [12:0] lsc_register_GrGain_V_87,
    output wire  [12:0] lsc_register_GrGain_V_88,
    output wire  [12:0] lsc_register_GrGain_V_89,
    output wire  [12:0] lsc_register_GrGain_V_90,
    output wire  [12:0] lsc_register_GrGain_V_91,
    output wire  [12:0] lsc_register_GrGain_V_92,
    output wire  [12:0] lsc_register_GrGain_V_93,
    output wire  [12:0] lsc_register_GrGain_V_94,
    output wire  [12:0] lsc_register_GrGain_V_95,
    output wire  [12:0] lsc_register_GrGain_V_96,
    output wire  [12:0] lsc_register_GrGain_V_97,
    output wire  [12:0] lsc_register_GrGain_V_98,
    output wire  [12:0] lsc_register_GrGain_V_99,
    output wire  [12:0] lsc_register_GrGain_V_100,
    output wire  [12:0] lsc_register_GrGain_V_101,
    output wire  [12:0] lsc_register_GrGain_V_102,
    output wire  [12:0] lsc_register_GrGain_V_103,
    output wire  [12:0] lsc_register_GrGain_V_104,
    output wire  [12:0] lsc_register_GrGain_V_105,
    output wire  [12:0] lsc_register_GrGain_V_106,
    output wire  [12:0] lsc_register_GrGain_V_107,
    output wire  [12:0] lsc_register_GrGain_V_108,
    output wire  [12:0] lsc_register_GrGain_V_109,
    output wire  [12:0] lsc_register_GrGain_V_110,
    output wire  [12:0] lsc_register_GrGain_V_111,
    output wire  [12:0] lsc_register_GrGain_V_112,
    output wire  [12:0] lsc_register_GrGain_V_113,
    output wire  [12:0] lsc_register_GrGain_V_114,
    output wire  [12:0] lsc_register_GrGain_V_115,
    output wire  [12:0] lsc_register_GrGain_V_116,
    output wire  [12:0] lsc_register_GrGain_V_117,
    output wire  [12:0] lsc_register_GrGain_V_118,
    output wire  [12:0] lsc_register_GrGain_V_119,
    output wire  [12:0] lsc_register_GrGain_V_120,
    output wire  [12:0] lsc_register_GrGain_V_121,
    output wire  [12:0] lsc_register_GrGain_V_122,
    output wire  [12:0] lsc_register_GrGain_V_123,
    output wire  [12:0] lsc_register_GrGain_V_124,
    output wire  [12:0] lsc_register_GrGain_V_125,
    output wire  [12:0] lsc_register_GrGain_V_126,
    output wire  [12:0] lsc_register_GrGain_V_127,
    output wire  [12:0] lsc_register_GrGain_V_128,
    output wire  [12:0] lsc_register_GrGain_V_129,
    output wire  [12:0] lsc_register_GrGain_V_130,
    output wire  [12:0] lsc_register_GrGain_V_131,
    output wire  [12:0] lsc_register_GrGain_V_132,
    output wire  [12:0] lsc_register_GrGain_V_133,
    output wire  [12:0] lsc_register_GrGain_V_134,
    output wire  [12:0] lsc_register_GrGain_V_135,
    output wire  [12:0] lsc_register_GrGain_V_136,
    output wire  [12:0] lsc_register_GrGain_V_137,
    output wire  [12:0] lsc_register_GrGain_V_138,
    output wire  [12:0] lsc_register_GrGain_V_139,
    output wire  [12:0] lsc_register_GrGain_V_140,
    output wire  [12:0] lsc_register_GrGain_V_141,
    output wire  [12:0] lsc_register_GrGain_V_142,
    output wire  [12:0] lsc_register_GrGain_V_143,
    output wire  [12:0] lsc_register_GrGain_V_144,
    output wire  [12:0] lsc_register_GrGain_V_145,
    output wire  [12:0] lsc_register_GrGain_V_146,
    output wire  [12:0] lsc_register_GrGain_V_147,
    output wire  [12:0] lsc_register_GrGain_V_148,
    output wire  [12:0] lsc_register_GrGain_V_149,
    output wire  [12:0] lsc_register_GrGain_V_150,
    output wire  [12:0] lsc_register_GrGain_V_151,
    output wire  [12:0] lsc_register_GrGain_V_152,
    output wire  [12:0] lsc_register_GrGain_V_153,
    output wire  [12:0] lsc_register_GrGain_V_154,
    output wire  [12:0] lsc_register_GrGain_V_155,
    output wire  [12:0] lsc_register_GrGain_V_156,
    output wire  [12:0] lsc_register_GrGain_V_157,
    output wire  [12:0] lsc_register_GrGain_V_158,
    output wire  [12:0] lsc_register_GrGain_V_159,
    output wire  [12:0] lsc_register_GrGain_V_160,
    output wire  [12:0] lsc_register_GrGain_V_161,
    output wire  [12:0] lsc_register_GrGain_V_162,
    output wire  [12:0] lsc_register_GrGain_V_163,
    output wire  [12:0] lsc_register_GrGain_V_164,
    output wire  [12:0] lsc_register_GrGain_V_165,
    output wire  [12:0] lsc_register_GrGain_V_166,
    output wire  [12:0] lsc_register_GrGain_V_167,
    output wire  [12:0] lsc_register_GrGain_V_168,
    output wire  [12:0] lsc_register_GrGain_V_169,
    output wire  [12:0] lsc_register_GrGain_V_170,
    output wire  [12:0] lsc_register_GrGain_V_171,
    output wire  [12:0] lsc_register_GrGain_V_172,
    output wire  [12:0] lsc_register_GrGain_V_173,
    output wire  [12:0] lsc_register_GrGain_V_174,
    output wire  [12:0] lsc_register_GrGain_V_175,
    output wire  [12:0] lsc_register_GrGain_V_176,
    output wire  [12:0] lsc_register_GrGain_V_177,
    output wire  [12:0] lsc_register_GrGain_V_178,
    output wire  [12:0] lsc_register_GrGain_V_179,
    output wire  [12:0] lsc_register_GrGain_V_180,
    output wire  [12:0] lsc_register_GrGain_V_181,
    output wire  [12:0] lsc_register_GrGain_V_182,
    output wire  [12:0] lsc_register_GrGain_V_183,
    output wire  [12:0] lsc_register_GrGain_V_184,
    output wire  [12:0] lsc_register_GrGain_V_185,
    output wire  [12:0] lsc_register_GrGain_V_186,
    output wire  [12:0] lsc_register_GrGain_V_187,
    output wire  [12:0] lsc_register_GrGain_V_188,
    output wire  [12:0] lsc_register_GrGain_V_189,
    output wire  [12:0] lsc_register_GrGain_V_190,
    output wire  [12:0] lsc_register_GrGain_V_191,
    output wire  [12:0] lsc_register_GrGain_V_192,
    output wire  [12:0] lsc_register_GrGain_V_193,
    output wire  [12:0] lsc_register_GrGain_V_194,
    output wire  [12:0] lsc_register_GrGain_V_195,
    output wire  [12:0] lsc_register_GrGain_V_196,
    output wire  [12:0] lsc_register_GrGain_V_197,
    output wire  [12:0] lsc_register_GrGain_V_198,
    output wire  [12:0] lsc_register_GrGain_V_199,
    output wire  [12:0] lsc_register_GrGain_V_200,
    output wire  [12:0] lsc_register_GrGain_V_201,
    output wire  [12:0] lsc_register_GrGain_V_202,
    output wire  [12:0] lsc_register_GrGain_V_203,
    output wire  [12:0] lsc_register_GrGain_V_204,
    output wire  [12:0] lsc_register_GrGain_V_205,
    output wire  [12:0] lsc_register_GrGain_V_206,
    output wire  [12:0] lsc_register_GrGain_V_207,
    output wire  [12:0] lsc_register_GrGain_V_208,
    output wire  [12:0] lsc_register_GrGain_V_209,
    output wire  [12:0] lsc_register_GrGain_V_210,
    output wire  [12:0] lsc_register_GrGain_V_211,
    output wire  [12:0] lsc_register_GrGain_V_212,
    output wire  [12:0] lsc_register_GrGain_V_213,
    output wire  [12:0] lsc_register_GrGain_V_214,
    output wire  [12:0] lsc_register_GrGain_V_215,
    output wire  [12:0] lsc_register_GrGain_V_216,
    output wire  [12:0] lsc_register_GrGain_V_217,
    output wire  [12:0] lsc_register_GrGain_V_218,
    output wire  [12:0] lsc_register_GrGain_V_219,
    output wire  [12:0] lsc_register_GrGain_V_220,
    output wire  [12:0] lsc_register_GbGain_V_0,
    output wire  [12:0] lsc_register_GbGain_V_1,
    output wire  [12:0] lsc_register_GbGain_V_2,
    output wire  [12:0] lsc_register_GbGain_V_3,
    output wire  [12:0] lsc_register_GbGain_V_4,
    output wire  [12:0] lsc_register_GbGain_V_5,
    output wire  [12:0] lsc_register_GbGain_V_6,
    output wire  [12:0] lsc_register_GbGain_V_7,
    output wire  [12:0] lsc_register_GbGain_V_8,
    output wire  [12:0] lsc_register_GbGain_V_9,
    output wire  [12:0] lsc_register_GbGain_V_10,
    output wire  [12:0] lsc_register_GbGain_V_11,
    output wire  [12:0] lsc_register_GbGain_V_12,
    output wire  [12:0] lsc_register_GbGain_V_13,
    output wire  [12:0] lsc_register_GbGain_V_14,
    output wire  [12:0] lsc_register_GbGain_V_15,
    output wire  [12:0] lsc_register_GbGain_V_16,
    output wire  [12:0] lsc_register_GbGain_V_17,
    output wire  [12:0] lsc_register_GbGain_V_18,
    output wire  [12:0] lsc_register_GbGain_V_19,
    output wire  [12:0] lsc_register_GbGain_V_20,
    output wire  [12:0] lsc_register_GbGain_V_21,
    output wire  [12:0] lsc_register_GbGain_V_22,
    output wire  [12:0] lsc_register_GbGain_V_23,
    output wire  [12:0] lsc_register_GbGain_V_24,
    output wire  [12:0] lsc_register_GbGain_V_25,
    output wire  [12:0] lsc_register_GbGain_V_26,
    output wire  [12:0] lsc_register_GbGain_V_27,
    output wire  [12:0] lsc_register_GbGain_V_28,
    output wire  [12:0] lsc_register_GbGain_V_29,
    output wire  [12:0] lsc_register_GbGain_V_30,
    output wire  [12:0] lsc_register_GbGain_V_31,
    output wire  [12:0] lsc_register_GbGain_V_32,
    output wire  [12:0] lsc_register_GbGain_V_33,
    output wire  [12:0] lsc_register_GbGain_V_34,
    output wire  [12:0] lsc_register_GbGain_V_35,
    output wire  [12:0] lsc_register_GbGain_V_36,
    output wire  [12:0] lsc_register_GbGain_V_37,
    output wire  [12:0] lsc_register_GbGain_V_38,
    output wire  [12:0] lsc_register_GbGain_V_39,
    output wire  [12:0] lsc_register_GbGain_V_40,
    output wire  [12:0] lsc_register_GbGain_V_41,
    output wire  [12:0] lsc_register_GbGain_V_42,
    output wire  [12:0] lsc_register_GbGain_V_43,
    output wire  [12:0] lsc_register_GbGain_V_44,
    output wire  [12:0] lsc_register_GbGain_V_45,
    output wire  [12:0] lsc_register_GbGain_V_46,
    output wire  [12:0] lsc_register_GbGain_V_47,
    output wire  [12:0] lsc_register_GbGain_V_48,
    output wire  [12:0] lsc_register_GbGain_V_49,
    output wire  [12:0] lsc_register_GbGain_V_50,
    output wire  [12:0] lsc_register_GbGain_V_51,
    output wire  [12:0] lsc_register_GbGain_V_52,
    output wire  [12:0] lsc_register_GbGain_V_53,
    output wire  [12:0] lsc_register_GbGain_V_54,
    output wire  [12:0] lsc_register_GbGain_V_55,
    output wire  [12:0] lsc_register_GbGain_V_56,
    output wire  [12:0] lsc_register_GbGain_V_57,
    output wire  [12:0] lsc_register_GbGain_V_58,
    output wire  [12:0] lsc_register_GbGain_V_59,
    output wire  [12:0] lsc_register_GbGain_V_60,
    output wire  [12:0] lsc_register_GbGain_V_61,
    output wire  [12:0] lsc_register_GbGain_V_62,
    output wire  [12:0] lsc_register_GbGain_V_63,
    output wire  [12:0] lsc_register_GbGain_V_64,
    output wire  [12:0] lsc_register_GbGain_V_65,
    output wire  [12:0] lsc_register_GbGain_V_66,
    output wire  [12:0] lsc_register_GbGain_V_67,
    output wire  [12:0] lsc_register_GbGain_V_68,
    output wire  [12:0] lsc_register_GbGain_V_69,
    output wire  [12:0] lsc_register_GbGain_V_70,
    output wire  [12:0] lsc_register_GbGain_V_71,
    output wire  [12:0] lsc_register_GbGain_V_72,
    output wire  [12:0] lsc_register_GbGain_V_73,
    output wire  [12:0] lsc_register_GbGain_V_74,
    output wire  [12:0] lsc_register_GbGain_V_75,
    output wire  [12:0] lsc_register_GbGain_V_76,
    output wire  [12:0] lsc_register_GbGain_V_77,
    output wire  [12:0] lsc_register_GbGain_V_78,
    output wire  [12:0] lsc_register_GbGain_V_79,
    output wire  [12:0] lsc_register_GbGain_V_80,
    output wire  [12:0] lsc_register_GbGain_V_81,
    output wire  [12:0] lsc_register_GbGain_V_82,
    output wire  [12:0] lsc_register_GbGain_V_83,
    output wire  [12:0] lsc_register_GbGain_V_84,
    output wire  [12:0] lsc_register_GbGain_V_85,
    output wire  [12:0] lsc_register_GbGain_V_86,
    output wire  [12:0] lsc_register_GbGain_V_87,
    output wire  [12:0] lsc_register_GbGain_V_88,
    output wire  [12:0] lsc_register_GbGain_V_89,
    output wire  [12:0] lsc_register_GbGain_V_90,
    output wire  [12:0] lsc_register_GbGain_V_91,
    output wire  [12:0] lsc_register_GbGain_V_92,
    output wire  [12:0] lsc_register_GbGain_V_93,
    output wire  [12:0] lsc_register_GbGain_V_94,
    output wire  [12:0] lsc_register_GbGain_V_95,
    output wire  [12:0] lsc_register_GbGain_V_96,
    output wire  [12:0] lsc_register_GbGain_V_97,
    output wire  [12:0] lsc_register_GbGain_V_98,
    output wire  [12:0] lsc_register_GbGain_V_99,
    output wire  [12:0] lsc_register_GbGain_V_100,
    output wire  [12:0] lsc_register_GbGain_V_101,
    output wire  [12:0] lsc_register_GbGain_V_102,
    output wire  [12:0] lsc_register_GbGain_V_103,
    output wire  [12:0] lsc_register_GbGain_V_104,
    output wire  [12:0] lsc_register_GbGain_V_105,
    output wire  [12:0] lsc_register_GbGain_V_106,
    output wire  [12:0] lsc_register_GbGain_V_107,
    output wire  [12:0] lsc_register_GbGain_V_108,
    output wire  [12:0] lsc_register_GbGain_V_109,
    output wire  [12:0] lsc_register_GbGain_V_110,
    output wire  [12:0] lsc_register_GbGain_V_111,
    output wire  [12:0] lsc_register_GbGain_V_112,
    output wire  [12:0] lsc_register_GbGain_V_113,
    output wire  [12:0] lsc_register_GbGain_V_114,
    output wire  [12:0] lsc_register_GbGain_V_115,
    output wire  [12:0] lsc_register_GbGain_V_116,
    output wire  [12:0] lsc_register_GbGain_V_117,
    output wire  [12:0] lsc_register_GbGain_V_118,
    output wire  [12:0] lsc_register_GbGain_V_119,
    output wire  [12:0] lsc_register_GbGain_V_120,
    output wire  [12:0] lsc_register_GbGain_V_121,
    output wire  [12:0] lsc_register_GbGain_V_122,
    output wire  [12:0] lsc_register_GbGain_V_123,
    output wire  [12:0] lsc_register_GbGain_V_124,
    output wire  [12:0] lsc_register_GbGain_V_125,
    output wire  [12:0] lsc_register_GbGain_V_126,
    output wire  [12:0] lsc_register_GbGain_V_127,
    output wire  [12:0] lsc_register_GbGain_V_128,
    output wire  [12:0] lsc_register_GbGain_V_129,
    output wire  [12:0] lsc_register_GbGain_V_130,
    output wire  [12:0] lsc_register_GbGain_V_131,
    output wire  [12:0] lsc_register_GbGain_V_132,
    output wire  [12:0] lsc_register_GbGain_V_133,
    output wire  [12:0] lsc_register_GbGain_V_134,
    output wire  [12:0] lsc_register_GbGain_V_135,
    output wire  [12:0] lsc_register_GbGain_V_136,
    output wire  [12:0] lsc_register_GbGain_V_137,
    output wire  [12:0] lsc_register_GbGain_V_138,
    output wire  [12:0] lsc_register_GbGain_V_139,
    output wire  [12:0] lsc_register_GbGain_V_140,
    output wire  [12:0] lsc_register_GbGain_V_141,
    output wire  [12:0] lsc_register_GbGain_V_142,
    output wire  [12:0] lsc_register_GbGain_V_143,
    output wire  [12:0] lsc_register_GbGain_V_144,
    output wire  [12:0] lsc_register_GbGain_V_145,
    output wire  [12:0] lsc_register_GbGain_V_146,
    output wire  [12:0] lsc_register_GbGain_V_147,
    output wire  [12:0] lsc_register_GbGain_V_148,
    output wire  [12:0] lsc_register_GbGain_V_149,
    output wire  [12:0] lsc_register_GbGain_V_150,
    output wire  [12:0] lsc_register_GbGain_V_151,
    output wire  [12:0] lsc_register_GbGain_V_152,
    output wire  [12:0] lsc_register_GbGain_V_153,
    output wire  [12:0] lsc_register_GbGain_V_154,
    output wire  [12:0] lsc_register_GbGain_V_155,
    output wire  [12:0] lsc_register_GbGain_V_156,
    output wire  [12:0] lsc_register_GbGain_V_157,
    output wire  [12:0] lsc_register_GbGain_V_158,
    output wire  [12:0] lsc_register_GbGain_V_159,
    output wire  [12:0] lsc_register_GbGain_V_160,
    output wire  [12:0] lsc_register_GbGain_V_161,
    output wire  [12:0] lsc_register_GbGain_V_162,
    output wire  [12:0] lsc_register_GbGain_V_163,
    output wire  [12:0] lsc_register_GbGain_V_164,
    output wire  [12:0] lsc_register_GbGain_V_165,
    output wire  [12:0] lsc_register_GbGain_V_166,
    output wire  [12:0] lsc_register_GbGain_V_167,
    output wire  [12:0] lsc_register_GbGain_V_168,
    output wire  [12:0] lsc_register_GbGain_V_169,
    output wire  [12:0] lsc_register_GbGain_V_170,
    output wire  [12:0] lsc_register_GbGain_V_171,
    output wire  [12:0] lsc_register_GbGain_V_172,
    output wire  [12:0] lsc_register_GbGain_V_173,
    output wire  [12:0] lsc_register_GbGain_V_174,
    output wire  [12:0] lsc_register_GbGain_V_175,
    output wire  [12:0] lsc_register_GbGain_V_176,
    output wire  [12:0] lsc_register_GbGain_V_177,
    output wire  [12:0] lsc_register_GbGain_V_178,
    output wire  [12:0] lsc_register_GbGain_V_179,
    output wire  [12:0] lsc_register_GbGain_V_180,
    output wire  [12:0] lsc_register_GbGain_V_181,
    output wire  [12:0] lsc_register_GbGain_V_182,
    output wire  [12:0] lsc_register_GbGain_V_183,
    output wire  [12:0] lsc_register_GbGain_V_184,
    output wire  [12:0] lsc_register_GbGain_V_185,
    output wire  [12:0] lsc_register_GbGain_V_186,
    output wire  [12:0] lsc_register_GbGain_V_187,
    output wire  [12:0] lsc_register_GbGain_V_188,
    output wire  [12:0] lsc_register_GbGain_V_189,
    output wire  [12:0] lsc_register_GbGain_V_190,
    output wire  [12:0] lsc_register_GbGain_V_191,
    output wire  [12:0] lsc_register_GbGain_V_192,
    output wire  [12:0] lsc_register_GbGain_V_193,
    output wire  [12:0] lsc_register_GbGain_V_194,
    output wire  [12:0] lsc_register_GbGain_V_195,
    output wire  [12:0] lsc_register_GbGain_V_196,
    output wire  [12:0] lsc_register_GbGain_V_197,
    output wire  [12:0] lsc_register_GbGain_V_198,
    output wire  [12:0] lsc_register_GbGain_V_199,
    output wire  [12:0] lsc_register_GbGain_V_200,
    output wire  [12:0] lsc_register_GbGain_V_201,
    output wire  [12:0] lsc_register_GbGain_V_202,
    output wire  [12:0] lsc_register_GbGain_V_203,
    output wire  [12:0] lsc_register_GbGain_V_204,
    output wire  [12:0] lsc_register_GbGain_V_205,
    output wire  [12:0] lsc_register_GbGain_V_206,
    output wire  [12:0] lsc_register_GbGain_V_207,
    output wire  [12:0] lsc_register_GbGain_V_208,
    output wire  [12:0] lsc_register_GbGain_V_209,
    output wire  [12:0] lsc_register_GbGain_V_210,
    output wire  [12:0] lsc_register_GbGain_V_211,
    output wire  [12:0] lsc_register_GbGain_V_212,
    output wire  [12:0] lsc_register_GbGain_V_213,
    output wire  [12:0] lsc_register_GbGain_V_214,
    output wire  [12:0] lsc_register_GbGain_V_215,
    output wire  [12:0] lsc_register_GbGain_V_216,
    output wire  [12:0] lsc_register_GbGain_V_217,
    output wire  [12:0] lsc_register_GbGain_V_218,
    output wire  [12:0] lsc_register_GbGain_V_219,
    output wire  [12:0] lsc_register_GbGain_V_220,
    output wire  [12:0] lsc_register_bGain_V_0,
    output wire  [12:0] lsc_register_bGain_V_1,
    output wire  [12:0] lsc_register_bGain_V_2,
    output wire  [12:0] lsc_register_bGain_V_3,
    output wire  [12:0] lsc_register_bGain_V_4,
    output wire  [12:0] lsc_register_bGain_V_5,
    output wire  [12:0] lsc_register_bGain_V_6,
    output wire  [12:0] lsc_register_bGain_V_7,
    output wire  [12:0] lsc_register_bGain_V_8,
    output wire  [12:0] lsc_register_bGain_V_9,
    output wire  [12:0] lsc_register_bGain_V_10,
    output wire  [12:0] lsc_register_bGain_V_11,
    output wire  [12:0] lsc_register_bGain_V_12,
    output wire  [12:0] lsc_register_bGain_V_13,
    output wire  [12:0] lsc_register_bGain_V_14,
    output wire  [12:0] lsc_register_bGain_V_15,
    output wire  [12:0] lsc_register_bGain_V_16,
    output wire  [12:0] lsc_register_bGain_V_17,
    output wire  [12:0] lsc_register_bGain_V_18,
    output wire  [12:0] lsc_register_bGain_V_19,
    output wire  [12:0] lsc_register_bGain_V_20,
    output wire  [12:0] lsc_register_bGain_V_21,
    output wire  [12:0] lsc_register_bGain_V_22,
    output wire  [12:0] lsc_register_bGain_V_23,
    output wire  [12:0] lsc_register_bGain_V_24,
    output wire  [12:0] lsc_register_bGain_V_25,
    output wire  [12:0] lsc_register_bGain_V_26,
    output wire  [12:0] lsc_register_bGain_V_27,
    output wire  [12:0] lsc_register_bGain_V_28,
    output wire  [12:0] lsc_register_bGain_V_29,
    output wire  [12:0] lsc_register_bGain_V_30,
    output wire  [12:0] lsc_register_bGain_V_31,
    output wire  [12:0] lsc_register_bGain_V_32,
    output wire  [12:0] lsc_register_bGain_V_33,
    output wire  [12:0] lsc_register_bGain_V_34,
    output wire  [12:0] lsc_register_bGain_V_35,
    output wire  [12:0] lsc_register_bGain_V_36,
    output wire  [12:0] lsc_register_bGain_V_37,
    output wire  [12:0] lsc_register_bGain_V_38,
    output wire  [12:0] lsc_register_bGain_V_39,
    output wire  [12:0] lsc_register_bGain_V_40,
    output wire  [12:0] lsc_register_bGain_V_41,
    output wire  [12:0] lsc_register_bGain_V_42,
    output wire  [12:0] lsc_register_bGain_V_43,
    output wire  [12:0] lsc_register_bGain_V_44,
    output wire  [12:0] lsc_register_bGain_V_45,
    output wire  [12:0] lsc_register_bGain_V_46,
    output wire  [12:0] lsc_register_bGain_V_47,
    output wire  [12:0] lsc_register_bGain_V_48,
    output wire  [12:0] lsc_register_bGain_V_49,
    output wire  [12:0] lsc_register_bGain_V_50,
    output wire  [12:0] lsc_register_bGain_V_51,
    output wire  [12:0] lsc_register_bGain_V_52,
    output wire  [12:0] lsc_register_bGain_V_53,
    output wire  [12:0] lsc_register_bGain_V_54,
    output wire  [12:0] lsc_register_bGain_V_55,
    output wire  [12:0] lsc_register_bGain_V_56,
    output wire  [12:0] lsc_register_bGain_V_57,
    output wire  [12:0] lsc_register_bGain_V_58,
    output wire  [12:0] lsc_register_bGain_V_59,
    output wire  [12:0] lsc_register_bGain_V_60,
    output wire  [12:0] lsc_register_bGain_V_61,
    output wire  [12:0] lsc_register_bGain_V_62,
    output wire  [12:0] lsc_register_bGain_V_63,
    output wire  [12:0] lsc_register_bGain_V_64,
    output wire  [12:0] lsc_register_bGain_V_65,
    output wire  [12:0] lsc_register_bGain_V_66,
    output wire  [12:0] lsc_register_bGain_V_67,
    output wire  [12:0] lsc_register_bGain_V_68,
    output wire  [12:0] lsc_register_bGain_V_69,
    output wire  [12:0] lsc_register_bGain_V_70,
    output wire  [12:0] lsc_register_bGain_V_71,
    output wire  [12:0] lsc_register_bGain_V_72,
    output wire  [12:0] lsc_register_bGain_V_73,
    output wire  [12:0] lsc_register_bGain_V_74,
    output wire  [12:0] lsc_register_bGain_V_75,
    output wire  [12:0] lsc_register_bGain_V_76,
    output wire  [12:0] lsc_register_bGain_V_77,
    output wire  [12:0] lsc_register_bGain_V_78,
    output wire  [12:0] lsc_register_bGain_V_79,
    output wire  [12:0] lsc_register_bGain_V_80,
    output wire  [12:0] lsc_register_bGain_V_81,
    output wire  [12:0] lsc_register_bGain_V_82,
    output wire  [12:0] lsc_register_bGain_V_83,
    output wire  [12:0] lsc_register_bGain_V_84,
    output wire  [12:0] lsc_register_bGain_V_85,
    output wire  [12:0] lsc_register_bGain_V_86,
    output wire  [12:0] lsc_register_bGain_V_87,
    output wire  [12:0] lsc_register_bGain_V_88,
    output wire  [12:0] lsc_register_bGain_V_89,
    output wire  [12:0] lsc_register_bGain_V_90,
    output wire  [12:0] lsc_register_bGain_V_91,
    output wire  [12:0] lsc_register_bGain_V_92,
    output wire  [12:0] lsc_register_bGain_V_93,
    output wire  [12:0] lsc_register_bGain_V_94,
    output wire  [12:0] lsc_register_bGain_V_95,
    output wire  [12:0] lsc_register_bGain_V_96,
    output wire  [12:0] lsc_register_bGain_V_97,
    output wire  [12:0] lsc_register_bGain_V_98,
    output wire  [12:0] lsc_register_bGain_V_99,
    output wire  [12:0] lsc_register_bGain_V_100,
    output wire  [12:0] lsc_register_bGain_V_101,
    output wire  [12:0] lsc_register_bGain_V_102,
    output wire  [12:0] lsc_register_bGain_V_103,
    output wire  [12:0] lsc_register_bGain_V_104,
    output wire  [12:0] lsc_register_bGain_V_105,
    output wire  [12:0] lsc_register_bGain_V_106,
    output wire  [12:0] lsc_register_bGain_V_107,
    output wire  [12:0] lsc_register_bGain_V_108,
    output wire  [12:0] lsc_register_bGain_V_109,
    output wire  [12:0] lsc_register_bGain_V_110,
    output wire  [12:0] lsc_register_bGain_V_111,
    output wire  [12:0] lsc_register_bGain_V_112,
    output wire  [12:0] lsc_register_bGain_V_113,
    output wire  [12:0] lsc_register_bGain_V_114,
    output wire  [12:0] lsc_register_bGain_V_115,
    output wire  [12:0] lsc_register_bGain_V_116,
    output wire  [12:0] lsc_register_bGain_V_117,
    output wire  [12:0] lsc_register_bGain_V_118,
    output wire  [12:0] lsc_register_bGain_V_119,
    output wire  [12:0] lsc_register_bGain_V_120,
    output wire  [12:0] lsc_register_bGain_V_121,
    output wire  [12:0] lsc_register_bGain_V_122,
    output wire  [12:0] lsc_register_bGain_V_123,
    output wire  [12:0] lsc_register_bGain_V_124,
    output wire  [12:0] lsc_register_bGain_V_125,
    output wire  [12:0] lsc_register_bGain_V_126,
    output wire  [12:0] lsc_register_bGain_V_127,
    output wire  [12:0] lsc_register_bGain_V_128,
    output wire  [12:0] lsc_register_bGain_V_129,
    output wire  [12:0] lsc_register_bGain_V_130,
    output wire  [12:0] lsc_register_bGain_V_131,
    output wire  [12:0] lsc_register_bGain_V_132,
    output wire  [12:0] lsc_register_bGain_V_133,
    output wire  [12:0] lsc_register_bGain_V_134,
    output wire  [12:0] lsc_register_bGain_V_135,
    output wire  [12:0] lsc_register_bGain_V_136,
    output wire  [12:0] lsc_register_bGain_V_137,
    output wire  [12:0] lsc_register_bGain_V_138,
    output wire  [12:0] lsc_register_bGain_V_139,
    output wire  [12:0] lsc_register_bGain_V_140,
    output wire  [12:0] lsc_register_bGain_V_141,
    output wire  [12:0] lsc_register_bGain_V_142,
    output wire  [12:0] lsc_register_bGain_V_143,
    output wire  [12:0] lsc_register_bGain_V_144,
    output wire  [12:0] lsc_register_bGain_V_145,
    output wire  [12:0] lsc_register_bGain_V_146,
    output wire  [12:0] lsc_register_bGain_V_147,
    output wire  [12:0] lsc_register_bGain_V_148,
    output wire  [12:0] lsc_register_bGain_V_149,
    output wire  [12:0] lsc_register_bGain_V_150,
    output wire  [12:0] lsc_register_bGain_V_151,
    output wire  [12:0] lsc_register_bGain_V_152,
    output wire  [12:0] lsc_register_bGain_V_153,
    output wire  [12:0] lsc_register_bGain_V_154,
    output wire  [12:0] lsc_register_bGain_V_155,
    output wire  [12:0] lsc_register_bGain_V_156,
    output wire  [12:0] lsc_register_bGain_V_157,
    output wire  [12:0] lsc_register_bGain_V_158,
    output wire  [12:0] lsc_register_bGain_V_159,
    output wire  [12:0] lsc_register_bGain_V_160,
    output wire  [12:0] lsc_register_bGain_V_161,
    output wire  [12:0] lsc_register_bGain_V_162,
    output wire  [12:0] lsc_register_bGain_V_163,
    output wire  [12:0] lsc_register_bGain_V_164,
    output wire  [12:0] lsc_register_bGain_V_165,
    output wire  [12:0] lsc_register_bGain_V_166,
    output wire  [12:0] lsc_register_bGain_V_167,
    output wire  [12:0] lsc_register_bGain_V_168,
    output wire  [12:0] lsc_register_bGain_V_169,
    output wire  [12:0] lsc_register_bGain_V_170,
    output wire  [12:0] lsc_register_bGain_V_171,
    output wire  [12:0] lsc_register_bGain_V_172,
    output wire  [12:0] lsc_register_bGain_V_173,
    output wire  [12:0] lsc_register_bGain_V_174,
    output wire  [12:0] lsc_register_bGain_V_175,
    output wire  [12:0] lsc_register_bGain_V_176,
    output wire  [12:0] lsc_register_bGain_V_177,
    output wire  [12:0] lsc_register_bGain_V_178,
    output wire  [12:0] lsc_register_bGain_V_179,
    output wire  [12:0] lsc_register_bGain_V_180,
    output wire  [12:0] lsc_register_bGain_V_181,
    output wire  [12:0] lsc_register_bGain_V_182,
    output wire  [12:0] lsc_register_bGain_V_183,
    output wire  [12:0] lsc_register_bGain_V_184,
    output wire  [12:0] lsc_register_bGain_V_185,
    output wire  [12:0] lsc_register_bGain_V_186,
    output wire  [12:0] lsc_register_bGain_V_187,
    output wire  [12:0] lsc_register_bGain_V_188,
    output wire  [12:0] lsc_register_bGain_V_189,
    output wire  [12:0] lsc_register_bGain_V_190,
    output wire  [12:0] lsc_register_bGain_V_191,
    output wire  [12:0] lsc_register_bGain_V_192,
    output wire  [12:0] lsc_register_bGain_V_193,
    output wire  [12:0] lsc_register_bGain_V_194,
    output wire  [12:0] lsc_register_bGain_V_195,
    output wire  [12:0] lsc_register_bGain_V_196,
    output wire  [12:0] lsc_register_bGain_V_197,
    output wire  [12:0] lsc_register_bGain_V_198,
    output wire  [12:0] lsc_register_bGain_V_199,
    output wire  [12:0] lsc_register_bGain_V_200,
    output wire  [12:0] lsc_register_bGain_V_201,
    output wire  [12:0] lsc_register_bGain_V_202,
    output wire  [12:0] lsc_register_bGain_V_203,
    output wire  [12:0] lsc_register_bGain_V_204,
    output wire  [12:0] lsc_register_bGain_V_205,
    output wire  [12:0] lsc_register_bGain_V_206,
    output wire  [12:0] lsc_register_bGain_V_207,
    output wire  [12:0] lsc_register_bGain_V_208,
    output wire  [12:0] lsc_register_bGain_V_209,
    output wire  [12:0] lsc_register_bGain_V_210,
    output wire  [12:0] lsc_register_bGain_V_211,
    output wire  [12:0] lsc_register_bGain_V_212,
    output wire  [12:0] lsc_register_bGain_V_213,
    output wire  [12:0] lsc_register_bGain_V_214,
    output wire  [12:0] lsc_register_bGain_V_215,
    output wire  [12:0] lsc_register_bGain_V_216,
    output wire  [12:0] lsc_register_bGain_V_217,
    output wire  [12:0] lsc_register_bGain_V_218,
    output wire  [12:0] lsc_register_bGain_V_219,
    output wire  [12:0] lsc_register_bGain_V_220,
    output wire  [8:0] lsc_register_blockHeight_V,
    output wire  [8:0] lsc_register_blockWidth_V,
    output wire  [13:0] lsc_register_blockWidth_1_V,
    output wire  [9:0] lsc_register_blockHeight_1_V,
    output wire  [0:0] dpc_register_eb,
    output wire  [10:0] dpc_register_th_w_V,
    output wire  [10:0] dpc_register_th_b_V,
    output wire  [5:0] rawdns_register_sigma_V,
    output wire  [0:0] rawdns_register_eb_V,
    output wire  [6:0] rawdns_register_Filterpara_V,
    output wire  [11:0] rawdns_register_invksigma2_V,
    output wire  [0:0] awb_register_m_nEb,
    output wire  [14:0] awb_register_r_gain_V,
    output wire  [14:0] awb_register_g_gain_V,
    output wire  [14:0] awb_register_b_gain_V,
    output wire  [4:0] awb_register_coeff_V,
    output wire  [0:0] wbc_register_m_nEb,
    output wire  [14:0] wbc_register_m_nR_V,
    output wire  [14:0] wbc_register_m_nGr_V,
    output wire  [14:0] wbc_register_m_nGb_V,
    output wire  [14:0] wbc_register_m_nB_V,
    output wire  [0:0] gb_register_eb,
    output wire  [3:0] gb_register_win_size_V,
    output wire  [3:0] gb_register_Lbound_V,
    output wire  [5:0] gb_register_Hbound_V,
    output wire  [9:0] gb_register_threhold_V,
    output wire  [0:0] demosaic_register_eb,
    output wire  [0:0] ee_register_eb,
    output wire  [7:0] ee_register_coeff_V,
    output wire  [0:0] cmc_register_m_nEb,
    output wire  [15:0] cmc_register_m_nGain_V_0,
    output wire  [15:0] cmc_register_m_nGain_V_1,
    output wire  [15:0] cmc_register_m_nGain_V_2,
    output wire  [15:0] cmc_register_m_nGain_V_3,
    output wire  [15:0] cmc_register_m_nGain_V_4,
    output wire  [15:0] cmc_register_m_nGain_V_5,
    output wire  [15:0] cmc_register_m_nGain_V_6,
    output wire  [15:0] cmc_register_m_nGain_V_7,
    output wire  [15:0] cmc_register_m_nGain_V_8,
    output wire  [15:0] cmc_register_m_nGain_V_9,
    output wire  [15:0] cmc_register_m_nGain_V_10,
    output wire  [15:0] cmc_register_m_nGain_V_11,
    output wire  [0:0] cmc_register_m_bCFCEnable,
    output wire  [0:0] cmc_register_m_bDiscardH,
    output wire  [8:0] cmc_register_m_pHueRange_V_0,
    output wire  [8:0] cmc_register_m_pHueRange_V_1,
    output wire  [2:0] cmc_register_m_nHueBandShift_V,
    output wire  [7:0] cmc_register_m_nEdgeThre_V,
    output wire  [2:0] cmc_register_m_nEdgeBandShift_V,
    output wire  [4:0] cmc_register_m_nCFCStrength_V,
    output wire  [0:0] gtm_register_eb,
    output wire  [0:0] gtm_register_m_bDitheringEnable,
    output wire  [9:0] gtm_register_gtmTab_V_0,
    output wire  [9:0] gtm_register_gtmTab_V_1,
    output wire  [9:0] gtm_register_gtmTab_V_2,
    output wire  [9:0] gtm_register_gtmTab_V_3,
    output wire  [9:0] gtm_register_gtmTab_V_4,
    output wire  [9:0] gtm_register_gtmTab_V_5,
    output wire  [9:0] gtm_register_gtmTab_V_6,
    output wire  [9:0] gtm_register_gtmTab_V_7,
    output wire  [9:0] gtm_register_gtmTab_V_8,
    output wire  [9:0] gtm_register_gtmTab_V_9,
    output wire  [9:0] gtm_register_gtmTab_V_10,
    output wire  [9:0] gtm_register_gtmTab_V_11,
    output wire  [9:0] gtm_register_gtmTab_V_12,
    output wire  [9:0] gtm_register_gtmTab_V_13,
    output wire  [9:0] gtm_register_gtmTab_V_14,
    output wire  [9:0] gtm_register_gtmTab_V_15,
    output wire  [9:0] gtm_register_gtmTab_V_16,
    output wire  [9:0] gtm_register_gtmTab_V_17,
    output wire  [9:0] gtm_register_gtmTab_V_18,
    output wire  [9:0] gtm_register_gtmTab_V_19,
    output wire  [9:0] gtm_register_gtmTab_V_20,
    output wire  [9:0] gtm_register_gtmTab_V_21,
    output wire  [9:0] gtm_register_gtmTab_V_22,
    output wire  [9:0] gtm_register_gtmTab_V_23,
    output wire  [9:0] gtm_register_gtmTab_V_24,
    output wire  [9:0] gtm_register_gtmTab_V_25,
    output wire  [9:0] gtm_register_gtmTab_V_26,
    output wire  [9:0] gtm_register_gtmTab_V_27,
    output wire  [9:0] gtm_register_gtmTab_V_28,
    output wire  [9:0] gtm_register_gtmTab_V_29,
    output wire  [9:0] gtm_register_gtmTab_V_30,
    output wire  [9:0] gtm_register_gtmTab_V_31,
    output wire  [9:0] gtm_register_gtmTab_V_32,
    output wire  [9:0] gtm_register_gtmTab_V_33,
    output wire  [9:0] gtm_register_gtmTab_V_34,
    output wire  [9:0] gtm_register_gtmTab_V_35,
    output wire  [9:0] gtm_register_gtmTab_V_36,
    output wire  [9:0] gtm_register_gtmTab_V_37,
    output wire  [9:0] gtm_register_gtmTab_V_38,
    output wire  [9:0] gtm_register_gtmTab_V_39,
    output wire  [9:0] gtm_register_gtmTab_V_40,
    output wire  [9:0] gtm_register_gtmTab_V_41,
    output wire  [9:0] gtm_register_gtmTab_V_42,
    output wire  [9:0] gtm_register_gtmTab_V_43,
    output wire  [9:0] gtm_register_gtmTab_V_44,
    output wire  [9:0] gtm_register_gtmTab_V_45,
    output wire  [9:0] gtm_register_gtmTab_V_46,
    output wire  [9:0] gtm_register_gtmTab_V_47,
    output wire  [9:0] gtm_register_gtmTab_V_48,
    output wire  [9:0] gtm_register_gtmTab_V_49,
    output wire  [9:0] gtm_register_gtmTab_V_50,
    output wire  [9:0] gtm_register_gtmTab_V_51,
    output wire  [9:0] gtm_register_gtmTab_V_52,
    output wire  [9:0] gtm_register_gtmTab_V_53,
    output wire  [9:0] gtm_register_gtmTab_V_54,
    output wire  [9:0] gtm_register_gtmTab_V_55,
    output wire  [9:0] gtm_register_gtmTab_V_56,
    output wire  [9:0] gtm_register_gtmTab_V_57,
    output wire  [9:0] gtm_register_gtmTab_V_58,
    output wire  [9:0] gtm_register_gtmTab_V_59,
    output wire  [9:0] gtm_register_gtmTab_V_60,
    output wire  [9:0] gtm_register_gtmTab_V_61,
    output wire  [9:0] gtm_register_gtmTab_V_62,
    output wire  [9:0] gtm_register_gtmTab_V_63,
    output wire  [9:0] gtm_register_gtmTab_V_64,
    output wire  [9:0] gtm_register_gtmTab_V_65,
    output wire  [9:0] gtm_register_gtmTab_V_66,
    output wire  [9:0] gtm_register_gtmTab_V_67,
    output wire  [9:0] gtm_register_gtmTab_V_68,
    output wire  [9:0] gtm_register_gtmTab_V_69,
    output wire  [9:0] gtm_register_gtmTab_V_70,
    output wire  [9:0] gtm_register_gtmTab_V_71,
    output wire  [9:0] gtm_register_gtmTab_V_72,
    output wire  [9:0] gtm_register_gtmTab_V_73,
    output wire  [9:0] gtm_register_gtmTab_V_74,
    output wire  [9:0] gtm_register_gtmTab_V_75,
    output wire  [9:0] gtm_register_gtmTab_V_76,
    output wire  [9:0] gtm_register_gtmTab_V_77,
    output wire  [9:0] gtm_register_gtmTab_V_78,
    output wire  [9:0] gtm_register_gtmTab_V_79,
    output wire  [9:0] gtm_register_gtmTab_V_80,
    output wire  [9:0] gtm_register_gtmTab_V_81,
    output wire  [9:0] gtm_register_gtmTab_V_82,
    output wire  [9:0] gtm_register_gtmTab_V_83,
    output wire  [9:0] gtm_register_gtmTab_V_84,
    output wire  [9:0] gtm_register_gtmTab_V_85,
    output wire  [9:0] gtm_register_gtmTab_V_86,
    output wire  [9:0] gtm_register_gtmTab_V_87,
    output wire  [9:0] gtm_register_gtmTab_V_88,
    output wire  [9:0] gtm_register_gtmTab_V_89,
    output wire  [9:0] gtm_register_gtmTab_V_90,
    output wire  [9:0] gtm_register_gtmTab_V_91,
    output wire  [9:0] gtm_register_gtmTab_V_92,
    output wire  [9:0] gtm_register_gtmTab_V_93,
    output wire  [9:0] gtm_register_gtmTab_V_94,
    output wire  [9:0] gtm_register_gtmTab_V_95,
    output wire  [9:0] gtm_register_gtmTab_V_96,
    output wire  [9:0] gtm_register_gtmTab_V_97,
    output wire  [9:0] gtm_register_gtmTab_V_98,
    output wire  [9:0] gtm_register_gtmTab_V_99,
    output wire  [9:0] gtm_register_gtmTab_V_100,
    output wire  [9:0] gtm_register_gtmTab_V_101,
    output wire  [9:0] gtm_register_gtmTab_V_102,
    output wire  [9:0] gtm_register_gtmTab_V_103,
    output wire  [9:0] gtm_register_gtmTab_V_104,
    output wire  [9:0] gtm_register_gtmTab_V_105,
    output wire  [9:0] gtm_register_gtmTab_V_106,
    output wire  [9:0] gtm_register_gtmTab_V_107,
    output wire  [9:0] gtm_register_gtmTab_V_108,
    output wire  [9:0] gtm_register_gtmTab_V_109,
    output wire  [9:0] gtm_register_gtmTab_V_110,
    output wire  [9:0] gtm_register_gtmTab_V_111,
    output wire  [9:0] gtm_register_gtmTab_V_112,
    output wire  [9:0] gtm_register_gtmTab_V_113,
    output wire  [9:0] gtm_register_gtmTab_V_114,
    output wire  [9:0] gtm_register_gtmTab_V_115,
    output wire  [9:0] gtm_register_gtmTab_V_116,
    output wire  [9:0] gtm_register_gtmTab_V_117,
    output wire  [9:0] gtm_register_gtmTab_V_118,
    output wire  [9:0] gtm_register_gtmTab_V_119,
    output wire  [9:0] gtm_register_gtmTab_V_120,
    output wire  [9:0] gtm_register_gtmTab_V_121,
    output wire  [9:0] gtm_register_gtmTab_V_122,
    output wire  [9:0] gtm_register_gtmTab_V_123,
    output wire  [9:0] gtm_register_gtmTab_V_124,
    output wire  [9:0] gtm_register_gtmTab_V_125,
    output wire  [9:0] gtm_register_gtmTab_V_126,
    output wire  [9:0] gtm_register_gtmTab_V_127,
    output wire  [9:0] gtm_register_gtmTab_V_128,
    output wire  [0:0] ltm_register_m_nEb_V,
    output wire  [15:0] ltm_register_contrast_V,
    output wire  [15:0] ltm_register_ratio_V,
    output wire  [0:0] cac_register_eb,
    output wire  [16:0] cac_register_t_transient_V,
    output wire  [16:0] cac_register_t_edge_V,
    output wire  [0:0] csc_register_m_nEb,
    output wire  [10:0] csc_register_coeff_V_0,
    output wire  [10:0] csc_register_coeff_V_1,
    output wire  [10:0] csc_register_coeff_V_2,
    output wire  [10:0] csc_register_coeff_V_3,
    output wire  [10:0] csc_register_coeff_V_4,
    output wire  [10:0] csc_register_coeff_V_5,
    output wire  [10:0] csc_register_coeff_V_6,
    output wire  [10:0] csc_register_coeff_V_7,
    output wire  [10:0] csc_register_coeff_V_8,
    output wire  [10:0] csc_register_coeff_V_9,
    output wire  [10:0] csc_register_coeff_V_10,
    output wire  [10:0] csc_register_coeff_V_11,
    output wire  [0:0] yfc_register_m_nEb,
    output wire  [0:0] yfc_register_yuvpattern,
    output wire  [0:0] yuvdns_register_eb_V,
    output wire  [13:0] yuvdns_register_ysigma2_V,
    output wire  [9:0] yuvdns_register_yinvsigma2_V,
    output wire  [13:0] yuvdns_register_uvsigma2_V,
    output wire  [9:0] yuvdns_register_uvinvsigma2_V,
    output wire  [3:0] yuvdns_register_yfilt_V,
    output wire  [3:0] yuvdns_register_uvfilt_V,
    output wire  [4:0] yuvdns_register_yinvfilt_V,
    output wire  [4:0] yuvdns_register_uvinvfilt_V,
    output wire  [13:0] yuvdns_register_yH2_V,
    output wire  [17:0] yuvdns_register_yinvH2_V,
    output wire  [13:0] yuvdns_register_uvH2_V,
    output wire  [17:0] yuvdns_register_uvinvH2_V,
    output wire  [0:0] scaledown_register_m_nEb,
    output wire  [1:0] scaledown_register_yuvpattern_V,
    output wire  [4:0] scaledown_register_times_V,
    output wire  [0:0] crop_register_m_nEb,
    output wire  [12:0] crop_register_upper_left_x_V,
    output wire  [12:0] crop_register_upper_left_y_V,
    output wire  [12:0] crop_register_lower_right_x_V,
    output wire  [12:0] crop_register_lower_right_y_V,
    output wire  [1:0] crop_register_yuvpattern_V,
    output wire  [31:0] isp_read_raw_addr,
    output wire  [31:0] isp_write_y_addr,
    output wire  [31:0] isp_write_u_addr,
    output wire  [31:0] isp_write_v_addr,
    output wire  [31:0] burst_one_frame_total
);

//------------------------Parameter----------------------
localparam    
    
    WRIDLE                 = 2'd0,
    WRDATA                 = 2'd1,
    WRRESP                 = 2'd2,
    WRRESET                = 2'd3,
    RDIDLE                 = 2'd0,
    RDDATA                 = 2'd1,
    RDRESET                = 2'd2,
    ADDR_BITS              = 32,

    ADDR_AXIL_ISPSLAVE_BASE   = 32'h001ef233,
    ADDR_START             = ADDR_AXIL_ISPSLAVE_BASE +32'h01100800,
    ADDR_IDLE_READY_DONE   = ADDR_AXIL_ISPSLAVE_BASE +32'h01100804,

    
    ADDR_TOP_REGISTER_FRAMEWIDTH_V = ADDR_AXIL_ISPSLAVE_BASE + 32'h0,
    ADDR_TOP_REGISTER_FRAMEHEIGHT_V = ADDR_AXIL_ISPSLAVE_BASE + 32'h4,
    ADDR_TOP_REGISTER_INPUTFORMAT = ADDR_AXIL_ISPSLAVE_BASE + 32'h8,
    ADDR_TOP_REGISTER_IMGPATTERN_V = ADDR_AXIL_ISPSLAVE_BASE + 32'hc,
    ADDR_TOP_REGISTER_PIPEMODE_V = ADDR_AXIL_ISPSLAVE_BASE + 32'h10,
    ADDR_TOP_REGISTER_BLC_V = ADDR_AXIL_ISPSLAVE_BASE + 32'h14,
    ADDR_TOP_REGISTER_SHADOWEB = ADDR_AXIL_ISPSLAVE_BASE + 32'h18,
    ADDR_TOP_REGISTER_BINNINGFRAMEWIDTH_V = ADDR_AXIL_ISPSLAVE_BASE + 32'h1c,
    ADDR_TOP_REGISTER_BINNINGFRAMEHEIGHT_V = ADDR_AXIL_ISPSLAVE_BASE + 32'h20,
    ADDR_TOP_REGISTER_SCALERFRAMEWIDTH_V = ADDR_AXIL_ISPSLAVE_BASE + 32'h24,
    ADDR_TOP_REGISTER_SCALERFRAMEHEIGHT_V = ADDR_AXIL_ISPSLAVE_BASE + 32'h28,
    ADDR_TPG_REGISTER_M_BTPG_EN = ADDR_AXIL_ISPSLAVE_BASE + 32'h2c,
    ADDR_TPG_REGISTER_M_NWIDTH_V = ADDR_AXIL_ISPSLAVE_BASE + 32'h30,
    ADDR_TPG_REGISTER_M_NHEIGHT_V = ADDR_AXIL_ISPSLAVE_BASE + 32'h34,
    ADDR_TPG_REGISTER_M_NCFAPATTERN_V = ADDR_AXIL_ISPSLAVE_BASE + 32'h38,
    ADDR_TPG_REGISTER_M_BROLLINGENABLE = ADDR_AXIL_ISPSLAVE_BASE + 32'h3c,
    ADDR_TPG_REGISTER_M_BSENSOR_TIMING_EN = ADDR_AXIL_ISPSLAVE_BASE + 32'h40,
    ADDR_TPG_REGISTER_M_NVBLANK_NUM_V = ADDR_AXIL_ISPSLAVE_BASE + 32'h44,
    ADDR_TPG_REGISTER_M_NHBLANK_NUM_V = ADDR_AXIL_ISPSLAVE_BASE + 32'h48,
    ADDR_TPG_REGISTER_M_VALID_BLANK_V = ADDR_AXIL_ISPSLAVE_BASE + 32'h4c,
    ADDR_TPG_REGISTER_M_NID_V = ADDR_AXIL_ISPSLAVE_BASE + 32'h50,
    ADDR_DGAIN_REGISTER_M_NEB = ADDR_AXIL_ISPSLAVE_BASE + 32'h54,
    ADDR_DGAIN_REGISTER_M_NBLCR_V = ADDR_AXIL_ISPSLAVE_BASE + 32'h58,
    ADDR_DGAIN_REGISTER_M_NBLCGR_V = ADDR_AXIL_ISPSLAVE_BASE + 32'h5c,
    ADDR_DGAIN_REGISTER_M_NBLCGB_V = ADDR_AXIL_ISPSLAVE_BASE + 32'h60,
    ADDR_DGAIN_REGISTER_M_NBLCB_V = ADDR_AXIL_ISPSLAVE_BASE + 32'h64,
    ADDR_DGAIN_REGISTER_M_NR_V = ADDR_AXIL_ISPSLAVE_BASE + 32'h68,
    ADDR_DGAIN_REGISTER_M_NGR_V = ADDR_AXIL_ISPSLAVE_BASE + 32'h6c,
    ADDR_DGAIN_REGISTER_M_NGB_V = ADDR_AXIL_ISPSLAVE_BASE + 32'h70,
    ADDR_DGAIN_REGISTER_M_NB_V = ADDR_AXIL_ISPSLAVE_BASE + 32'h74,
    ADDR_LSC_REGISTER_EB = ADDR_AXIL_ISPSLAVE_BASE + 32'h78,
    ADDR_LSC_REGISTER_RGAIN_V_0 = ADDR_AXIL_ISPSLAVE_BASE + 32'h7c,
    ADDR_LSC_REGISTER_RGAIN_V_1 = ADDR_AXIL_ISPSLAVE_BASE + 32'h80,
    ADDR_LSC_REGISTER_RGAIN_V_2 = ADDR_AXIL_ISPSLAVE_BASE + 32'h84,
    ADDR_LSC_REGISTER_RGAIN_V_3 = ADDR_AXIL_ISPSLAVE_BASE + 32'h88,
    ADDR_LSC_REGISTER_RGAIN_V_4 = ADDR_AXIL_ISPSLAVE_BASE + 32'h8c,
    ADDR_LSC_REGISTER_RGAIN_V_5 = ADDR_AXIL_ISPSLAVE_BASE + 32'h90,
    ADDR_LSC_REGISTER_RGAIN_V_6 = ADDR_AXIL_ISPSLAVE_BASE + 32'h94,
    ADDR_LSC_REGISTER_RGAIN_V_7 = ADDR_AXIL_ISPSLAVE_BASE + 32'h98,
    ADDR_LSC_REGISTER_RGAIN_V_8 = ADDR_AXIL_ISPSLAVE_BASE + 32'h9c,
    ADDR_LSC_REGISTER_RGAIN_V_9 = ADDR_AXIL_ISPSLAVE_BASE + 32'ha0,
    ADDR_LSC_REGISTER_RGAIN_V_10 = ADDR_AXIL_ISPSLAVE_BASE + 32'ha4,
    ADDR_LSC_REGISTER_RGAIN_V_11 = ADDR_AXIL_ISPSLAVE_BASE + 32'ha8,
    ADDR_LSC_REGISTER_RGAIN_V_12 = ADDR_AXIL_ISPSLAVE_BASE + 32'hac,
    ADDR_LSC_REGISTER_RGAIN_V_13 = ADDR_AXIL_ISPSLAVE_BASE + 32'hb0,
    ADDR_LSC_REGISTER_RGAIN_V_14 = ADDR_AXIL_ISPSLAVE_BASE + 32'hb4,
    ADDR_LSC_REGISTER_RGAIN_V_15 = ADDR_AXIL_ISPSLAVE_BASE + 32'hb8,
    ADDR_LSC_REGISTER_RGAIN_V_16 = ADDR_AXIL_ISPSLAVE_BASE + 32'hbc,
    ADDR_LSC_REGISTER_RGAIN_V_17 = ADDR_AXIL_ISPSLAVE_BASE + 32'hc0,
    ADDR_LSC_REGISTER_RGAIN_V_18 = ADDR_AXIL_ISPSLAVE_BASE + 32'hc4,
    ADDR_LSC_REGISTER_RGAIN_V_19 = ADDR_AXIL_ISPSLAVE_BASE + 32'hc8,
    ADDR_LSC_REGISTER_RGAIN_V_20 = ADDR_AXIL_ISPSLAVE_BASE + 32'hcc,
    ADDR_LSC_REGISTER_RGAIN_V_21 = ADDR_AXIL_ISPSLAVE_BASE + 32'hd0,
    ADDR_LSC_REGISTER_RGAIN_V_22 = ADDR_AXIL_ISPSLAVE_BASE + 32'hd4,
    ADDR_LSC_REGISTER_RGAIN_V_23 = ADDR_AXIL_ISPSLAVE_BASE + 32'hd8,
    ADDR_LSC_REGISTER_RGAIN_V_24 = ADDR_AXIL_ISPSLAVE_BASE + 32'hdc,
    ADDR_LSC_REGISTER_RGAIN_V_25 = ADDR_AXIL_ISPSLAVE_BASE + 32'he0,
    ADDR_LSC_REGISTER_RGAIN_V_26 = ADDR_AXIL_ISPSLAVE_BASE + 32'he4,
    ADDR_LSC_REGISTER_RGAIN_V_27 = ADDR_AXIL_ISPSLAVE_BASE + 32'he8,
    ADDR_LSC_REGISTER_RGAIN_V_28 = ADDR_AXIL_ISPSLAVE_BASE + 32'hec,
    ADDR_LSC_REGISTER_RGAIN_V_29 = ADDR_AXIL_ISPSLAVE_BASE + 32'hf0,
    ADDR_LSC_REGISTER_RGAIN_V_30 = ADDR_AXIL_ISPSLAVE_BASE + 32'hf4,
    ADDR_LSC_REGISTER_RGAIN_V_31 = ADDR_AXIL_ISPSLAVE_BASE + 32'hf8,
    ADDR_LSC_REGISTER_RGAIN_V_32 = ADDR_AXIL_ISPSLAVE_BASE + 32'hfc,
    ADDR_LSC_REGISTER_RGAIN_V_33 = ADDR_AXIL_ISPSLAVE_BASE + 32'h100,
    ADDR_LSC_REGISTER_RGAIN_V_34 = ADDR_AXIL_ISPSLAVE_BASE + 32'h104,
    ADDR_LSC_REGISTER_RGAIN_V_35 = ADDR_AXIL_ISPSLAVE_BASE + 32'h108,
    ADDR_LSC_REGISTER_RGAIN_V_36 = ADDR_AXIL_ISPSLAVE_BASE + 32'h10c,
    ADDR_LSC_REGISTER_RGAIN_V_37 = ADDR_AXIL_ISPSLAVE_BASE + 32'h110,
    ADDR_LSC_REGISTER_RGAIN_V_38 = ADDR_AXIL_ISPSLAVE_BASE + 32'h114,
    ADDR_LSC_REGISTER_RGAIN_V_39 = ADDR_AXIL_ISPSLAVE_BASE + 32'h118,
    ADDR_LSC_REGISTER_RGAIN_V_40 = ADDR_AXIL_ISPSLAVE_BASE + 32'h11c,
    ADDR_LSC_REGISTER_RGAIN_V_41 = ADDR_AXIL_ISPSLAVE_BASE + 32'h120,
    ADDR_LSC_REGISTER_RGAIN_V_42 = ADDR_AXIL_ISPSLAVE_BASE + 32'h124,
    ADDR_LSC_REGISTER_RGAIN_V_43 = ADDR_AXIL_ISPSLAVE_BASE + 32'h128,
    ADDR_LSC_REGISTER_RGAIN_V_44 = ADDR_AXIL_ISPSLAVE_BASE + 32'h12c,
    ADDR_LSC_REGISTER_RGAIN_V_45 = ADDR_AXIL_ISPSLAVE_BASE + 32'h130,
    ADDR_LSC_REGISTER_RGAIN_V_46 = ADDR_AXIL_ISPSLAVE_BASE + 32'h134,
    ADDR_LSC_REGISTER_RGAIN_V_47 = ADDR_AXIL_ISPSLAVE_BASE + 32'h138,
    ADDR_LSC_REGISTER_RGAIN_V_48 = ADDR_AXIL_ISPSLAVE_BASE + 32'h13c,
    ADDR_LSC_REGISTER_RGAIN_V_49 = ADDR_AXIL_ISPSLAVE_BASE + 32'h140,
    ADDR_LSC_REGISTER_RGAIN_V_50 = ADDR_AXIL_ISPSLAVE_BASE + 32'h144,
    ADDR_LSC_REGISTER_RGAIN_V_51 = ADDR_AXIL_ISPSLAVE_BASE + 32'h148,
    ADDR_LSC_REGISTER_RGAIN_V_52 = ADDR_AXIL_ISPSLAVE_BASE + 32'h14c,
    ADDR_LSC_REGISTER_RGAIN_V_53 = ADDR_AXIL_ISPSLAVE_BASE + 32'h150,
    ADDR_LSC_REGISTER_RGAIN_V_54 = ADDR_AXIL_ISPSLAVE_BASE + 32'h154,
    ADDR_LSC_REGISTER_RGAIN_V_55 = ADDR_AXIL_ISPSLAVE_BASE + 32'h158,
    ADDR_LSC_REGISTER_RGAIN_V_56 = ADDR_AXIL_ISPSLAVE_BASE + 32'h15c,
    ADDR_LSC_REGISTER_RGAIN_V_57 = ADDR_AXIL_ISPSLAVE_BASE + 32'h160,
    ADDR_LSC_REGISTER_RGAIN_V_58 = ADDR_AXIL_ISPSLAVE_BASE + 32'h164,
    ADDR_LSC_REGISTER_RGAIN_V_59 = ADDR_AXIL_ISPSLAVE_BASE + 32'h168,
    ADDR_LSC_REGISTER_RGAIN_V_60 = ADDR_AXIL_ISPSLAVE_BASE + 32'h16c,
    ADDR_LSC_REGISTER_RGAIN_V_61 = ADDR_AXIL_ISPSLAVE_BASE + 32'h170,
    ADDR_LSC_REGISTER_RGAIN_V_62 = ADDR_AXIL_ISPSLAVE_BASE + 32'h174,
    ADDR_LSC_REGISTER_RGAIN_V_63 = ADDR_AXIL_ISPSLAVE_BASE + 32'h178,
    ADDR_LSC_REGISTER_RGAIN_V_64 = ADDR_AXIL_ISPSLAVE_BASE + 32'h17c,
    ADDR_LSC_REGISTER_RGAIN_V_65 = ADDR_AXIL_ISPSLAVE_BASE + 32'h180,
    ADDR_LSC_REGISTER_RGAIN_V_66 = ADDR_AXIL_ISPSLAVE_BASE + 32'h184,
    ADDR_LSC_REGISTER_RGAIN_V_67 = ADDR_AXIL_ISPSLAVE_BASE + 32'h188,
    ADDR_LSC_REGISTER_RGAIN_V_68 = ADDR_AXIL_ISPSLAVE_BASE + 32'h18c,
    ADDR_LSC_REGISTER_RGAIN_V_69 = ADDR_AXIL_ISPSLAVE_BASE + 32'h190,
    ADDR_LSC_REGISTER_RGAIN_V_70 = ADDR_AXIL_ISPSLAVE_BASE + 32'h194,
    ADDR_LSC_REGISTER_RGAIN_V_71 = ADDR_AXIL_ISPSLAVE_BASE + 32'h198,
    ADDR_LSC_REGISTER_RGAIN_V_72 = ADDR_AXIL_ISPSLAVE_BASE + 32'h19c,
    ADDR_LSC_REGISTER_RGAIN_V_73 = ADDR_AXIL_ISPSLAVE_BASE + 32'h1a0,
    ADDR_LSC_REGISTER_RGAIN_V_74 = ADDR_AXIL_ISPSLAVE_BASE + 32'h1a4,
    ADDR_LSC_REGISTER_RGAIN_V_75 = ADDR_AXIL_ISPSLAVE_BASE + 32'h1a8,
    ADDR_LSC_REGISTER_RGAIN_V_76 = ADDR_AXIL_ISPSLAVE_BASE + 32'h1ac,
    ADDR_LSC_REGISTER_RGAIN_V_77 = ADDR_AXIL_ISPSLAVE_BASE + 32'h1b0,
    ADDR_LSC_REGISTER_RGAIN_V_78 = ADDR_AXIL_ISPSLAVE_BASE + 32'h1b4,
    ADDR_LSC_REGISTER_RGAIN_V_79 = ADDR_AXIL_ISPSLAVE_BASE + 32'h1b8,
    ADDR_LSC_REGISTER_RGAIN_V_80 = ADDR_AXIL_ISPSLAVE_BASE + 32'h1bc,
    ADDR_LSC_REGISTER_RGAIN_V_81 = ADDR_AXIL_ISPSLAVE_BASE + 32'h1c0,
    ADDR_LSC_REGISTER_RGAIN_V_82 = ADDR_AXIL_ISPSLAVE_BASE + 32'h1c4,
    ADDR_LSC_REGISTER_RGAIN_V_83 = ADDR_AXIL_ISPSLAVE_BASE + 32'h1c8,
    ADDR_LSC_REGISTER_RGAIN_V_84 = ADDR_AXIL_ISPSLAVE_BASE + 32'h1cc,
    ADDR_LSC_REGISTER_RGAIN_V_85 = ADDR_AXIL_ISPSLAVE_BASE + 32'h1d0,
    ADDR_LSC_REGISTER_RGAIN_V_86 = ADDR_AXIL_ISPSLAVE_BASE + 32'h1d4,
    ADDR_LSC_REGISTER_RGAIN_V_87 = ADDR_AXIL_ISPSLAVE_BASE + 32'h1d8,
    ADDR_LSC_REGISTER_RGAIN_V_88 = ADDR_AXIL_ISPSLAVE_BASE + 32'h1dc,
    ADDR_LSC_REGISTER_RGAIN_V_89 = ADDR_AXIL_ISPSLAVE_BASE + 32'h1e0,
    ADDR_LSC_REGISTER_RGAIN_V_90 = ADDR_AXIL_ISPSLAVE_BASE + 32'h1e4,
    ADDR_LSC_REGISTER_RGAIN_V_91 = ADDR_AXIL_ISPSLAVE_BASE + 32'h1e8,
    ADDR_LSC_REGISTER_RGAIN_V_92 = ADDR_AXIL_ISPSLAVE_BASE + 32'h1ec,
    ADDR_LSC_REGISTER_RGAIN_V_93 = ADDR_AXIL_ISPSLAVE_BASE + 32'h1f0,
    ADDR_LSC_REGISTER_RGAIN_V_94 = ADDR_AXIL_ISPSLAVE_BASE + 32'h1f4,
    ADDR_LSC_REGISTER_RGAIN_V_95 = ADDR_AXIL_ISPSLAVE_BASE + 32'h1f8,
    ADDR_LSC_REGISTER_RGAIN_V_96 = ADDR_AXIL_ISPSLAVE_BASE + 32'h1fc,
    ADDR_LSC_REGISTER_RGAIN_V_97 = ADDR_AXIL_ISPSLAVE_BASE + 32'h200,
    ADDR_LSC_REGISTER_RGAIN_V_98 = ADDR_AXIL_ISPSLAVE_BASE + 32'h204,
    ADDR_LSC_REGISTER_RGAIN_V_99 = ADDR_AXIL_ISPSLAVE_BASE + 32'h208,
    ADDR_LSC_REGISTER_RGAIN_V_100 = ADDR_AXIL_ISPSLAVE_BASE + 32'h20c,
    ADDR_LSC_REGISTER_RGAIN_V_101 = ADDR_AXIL_ISPSLAVE_BASE + 32'h210,
    ADDR_LSC_REGISTER_RGAIN_V_102 = ADDR_AXIL_ISPSLAVE_BASE + 32'h214,
    ADDR_LSC_REGISTER_RGAIN_V_103 = ADDR_AXIL_ISPSLAVE_BASE + 32'h218,
    ADDR_LSC_REGISTER_RGAIN_V_104 = ADDR_AXIL_ISPSLAVE_BASE + 32'h21c,
    ADDR_LSC_REGISTER_RGAIN_V_105 = ADDR_AXIL_ISPSLAVE_BASE + 32'h220,
    ADDR_LSC_REGISTER_RGAIN_V_106 = ADDR_AXIL_ISPSLAVE_BASE + 32'h224,
    ADDR_LSC_REGISTER_RGAIN_V_107 = ADDR_AXIL_ISPSLAVE_BASE + 32'h228,
    ADDR_LSC_REGISTER_RGAIN_V_108 = ADDR_AXIL_ISPSLAVE_BASE + 32'h22c,
    ADDR_LSC_REGISTER_RGAIN_V_109 = ADDR_AXIL_ISPSLAVE_BASE + 32'h230,
    ADDR_LSC_REGISTER_RGAIN_V_110 = ADDR_AXIL_ISPSLAVE_BASE + 32'h234,
    ADDR_LSC_REGISTER_RGAIN_V_111 = ADDR_AXIL_ISPSLAVE_BASE + 32'h238,
    ADDR_LSC_REGISTER_RGAIN_V_112 = ADDR_AXIL_ISPSLAVE_BASE + 32'h23c,
    ADDR_LSC_REGISTER_RGAIN_V_113 = ADDR_AXIL_ISPSLAVE_BASE + 32'h240,
    ADDR_LSC_REGISTER_RGAIN_V_114 = ADDR_AXIL_ISPSLAVE_BASE + 32'h244,
    ADDR_LSC_REGISTER_RGAIN_V_115 = ADDR_AXIL_ISPSLAVE_BASE + 32'h248,
    ADDR_LSC_REGISTER_RGAIN_V_116 = ADDR_AXIL_ISPSLAVE_BASE + 32'h24c,
    ADDR_LSC_REGISTER_RGAIN_V_117 = ADDR_AXIL_ISPSLAVE_BASE + 32'h250,
    ADDR_LSC_REGISTER_RGAIN_V_118 = ADDR_AXIL_ISPSLAVE_BASE + 32'h254,
    ADDR_LSC_REGISTER_RGAIN_V_119 = ADDR_AXIL_ISPSLAVE_BASE + 32'h258,
    ADDR_LSC_REGISTER_RGAIN_V_120 = ADDR_AXIL_ISPSLAVE_BASE + 32'h25c,
    ADDR_LSC_REGISTER_RGAIN_V_121 = ADDR_AXIL_ISPSLAVE_BASE + 32'h260,
    ADDR_LSC_REGISTER_RGAIN_V_122 = ADDR_AXIL_ISPSLAVE_BASE + 32'h264,
    ADDR_LSC_REGISTER_RGAIN_V_123 = ADDR_AXIL_ISPSLAVE_BASE + 32'h268,
    ADDR_LSC_REGISTER_RGAIN_V_124 = ADDR_AXIL_ISPSLAVE_BASE + 32'h26c,
    ADDR_LSC_REGISTER_RGAIN_V_125 = ADDR_AXIL_ISPSLAVE_BASE + 32'h270,
    ADDR_LSC_REGISTER_RGAIN_V_126 = ADDR_AXIL_ISPSLAVE_BASE + 32'h274,
    ADDR_LSC_REGISTER_RGAIN_V_127 = ADDR_AXIL_ISPSLAVE_BASE + 32'h278,
    ADDR_LSC_REGISTER_RGAIN_V_128 = ADDR_AXIL_ISPSLAVE_BASE + 32'h27c,
    ADDR_LSC_REGISTER_RGAIN_V_129 = ADDR_AXIL_ISPSLAVE_BASE + 32'h280,
    ADDR_LSC_REGISTER_RGAIN_V_130 = ADDR_AXIL_ISPSLAVE_BASE + 32'h284,
    ADDR_LSC_REGISTER_RGAIN_V_131 = ADDR_AXIL_ISPSLAVE_BASE + 32'h288,
    ADDR_LSC_REGISTER_RGAIN_V_132 = ADDR_AXIL_ISPSLAVE_BASE + 32'h28c,
    ADDR_LSC_REGISTER_RGAIN_V_133 = ADDR_AXIL_ISPSLAVE_BASE + 32'h290,
    ADDR_LSC_REGISTER_RGAIN_V_134 = ADDR_AXIL_ISPSLAVE_BASE + 32'h294,
    ADDR_LSC_REGISTER_RGAIN_V_135 = ADDR_AXIL_ISPSLAVE_BASE + 32'h298,
    ADDR_LSC_REGISTER_RGAIN_V_136 = ADDR_AXIL_ISPSLAVE_BASE + 32'h29c,
    ADDR_LSC_REGISTER_RGAIN_V_137 = ADDR_AXIL_ISPSLAVE_BASE + 32'h2a0,
    ADDR_LSC_REGISTER_RGAIN_V_138 = ADDR_AXIL_ISPSLAVE_BASE + 32'h2a4,
    ADDR_LSC_REGISTER_RGAIN_V_139 = ADDR_AXIL_ISPSLAVE_BASE + 32'h2a8,
    ADDR_LSC_REGISTER_RGAIN_V_140 = ADDR_AXIL_ISPSLAVE_BASE + 32'h2ac,
    ADDR_LSC_REGISTER_RGAIN_V_141 = ADDR_AXIL_ISPSLAVE_BASE + 32'h2b0,
    ADDR_LSC_REGISTER_RGAIN_V_142 = ADDR_AXIL_ISPSLAVE_BASE + 32'h2b4,
    ADDR_LSC_REGISTER_RGAIN_V_143 = ADDR_AXIL_ISPSLAVE_BASE + 32'h2b8,
    ADDR_LSC_REGISTER_RGAIN_V_144 = ADDR_AXIL_ISPSLAVE_BASE + 32'h2bc,
    ADDR_LSC_REGISTER_RGAIN_V_145 = ADDR_AXIL_ISPSLAVE_BASE + 32'h2c0,
    ADDR_LSC_REGISTER_RGAIN_V_146 = ADDR_AXIL_ISPSLAVE_BASE + 32'h2c4,
    ADDR_LSC_REGISTER_RGAIN_V_147 = ADDR_AXIL_ISPSLAVE_BASE + 32'h2c8,
    ADDR_LSC_REGISTER_RGAIN_V_148 = ADDR_AXIL_ISPSLAVE_BASE + 32'h2cc,
    ADDR_LSC_REGISTER_RGAIN_V_149 = ADDR_AXIL_ISPSLAVE_BASE + 32'h2d0,
    ADDR_LSC_REGISTER_RGAIN_V_150 = ADDR_AXIL_ISPSLAVE_BASE + 32'h2d4,
    ADDR_LSC_REGISTER_RGAIN_V_151 = ADDR_AXIL_ISPSLAVE_BASE + 32'h2d8,
    ADDR_LSC_REGISTER_RGAIN_V_152 = ADDR_AXIL_ISPSLAVE_BASE + 32'h2dc,
    ADDR_LSC_REGISTER_RGAIN_V_153 = ADDR_AXIL_ISPSLAVE_BASE + 32'h2e0,
    ADDR_LSC_REGISTER_RGAIN_V_154 = ADDR_AXIL_ISPSLAVE_BASE + 32'h2e4,
    ADDR_LSC_REGISTER_RGAIN_V_155 = ADDR_AXIL_ISPSLAVE_BASE + 32'h2e8,
    ADDR_LSC_REGISTER_RGAIN_V_156 = ADDR_AXIL_ISPSLAVE_BASE + 32'h2ec,
    ADDR_LSC_REGISTER_RGAIN_V_157 = ADDR_AXIL_ISPSLAVE_BASE + 32'h2f0,
    ADDR_LSC_REGISTER_RGAIN_V_158 = ADDR_AXIL_ISPSLAVE_BASE + 32'h2f4,
    ADDR_LSC_REGISTER_RGAIN_V_159 = ADDR_AXIL_ISPSLAVE_BASE + 32'h2f8,
    ADDR_LSC_REGISTER_RGAIN_V_160 = ADDR_AXIL_ISPSLAVE_BASE + 32'h2fc,
    ADDR_LSC_REGISTER_RGAIN_V_161 = ADDR_AXIL_ISPSLAVE_BASE + 32'h300,
    ADDR_LSC_REGISTER_RGAIN_V_162 = ADDR_AXIL_ISPSLAVE_BASE + 32'h304,
    ADDR_LSC_REGISTER_RGAIN_V_163 = ADDR_AXIL_ISPSLAVE_BASE + 32'h308,
    ADDR_LSC_REGISTER_RGAIN_V_164 = ADDR_AXIL_ISPSLAVE_BASE + 32'h30c,
    ADDR_LSC_REGISTER_RGAIN_V_165 = ADDR_AXIL_ISPSLAVE_BASE + 32'h310,
    ADDR_LSC_REGISTER_RGAIN_V_166 = ADDR_AXIL_ISPSLAVE_BASE + 32'h314,
    ADDR_LSC_REGISTER_RGAIN_V_167 = ADDR_AXIL_ISPSLAVE_BASE + 32'h318,
    ADDR_LSC_REGISTER_RGAIN_V_168 = ADDR_AXIL_ISPSLAVE_BASE + 32'h31c,
    ADDR_LSC_REGISTER_RGAIN_V_169 = ADDR_AXIL_ISPSLAVE_BASE + 32'h320,
    ADDR_LSC_REGISTER_RGAIN_V_170 = ADDR_AXIL_ISPSLAVE_BASE + 32'h324,
    ADDR_LSC_REGISTER_RGAIN_V_171 = ADDR_AXIL_ISPSLAVE_BASE + 32'h328,
    ADDR_LSC_REGISTER_RGAIN_V_172 = ADDR_AXIL_ISPSLAVE_BASE + 32'h32c,
    ADDR_LSC_REGISTER_RGAIN_V_173 = ADDR_AXIL_ISPSLAVE_BASE + 32'h330,
    ADDR_LSC_REGISTER_RGAIN_V_174 = ADDR_AXIL_ISPSLAVE_BASE + 32'h334,
    ADDR_LSC_REGISTER_RGAIN_V_175 = ADDR_AXIL_ISPSLAVE_BASE + 32'h338,
    ADDR_LSC_REGISTER_RGAIN_V_176 = ADDR_AXIL_ISPSLAVE_BASE + 32'h33c,
    ADDR_LSC_REGISTER_RGAIN_V_177 = ADDR_AXIL_ISPSLAVE_BASE + 32'h340,
    ADDR_LSC_REGISTER_RGAIN_V_178 = ADDR_AXIL_ISPSLAVE_BASE + 32'h344,
    ADDR_LSC_REGISTER_RGAIN_V_179 = ADDR_AXIL_ISPSLAVE_BASE + 32'h348,
    ADDR_LSC_REGISTER_RGAIN_V_180 = ADDR_AXIL_ISPSLAVE_BASE + 32'h34c,
    ADDR_LSC_REGISTER_RGAIN_V_181 = ADDR_AXIL_ISPSLAVE_BASE + 32'h350,
    ADDR_LSC_REGISTER_RGAIN_V_182 = ADDR_AXIL_ISPSLAVE_BASE + 32'h354,
    ADDR_LSC_REGISTER_RGAIN_V_183 = ADDR_AXIL_ISPSLAVE_BASE + 32'h358,
    ADDR_LSC_REGISTER_RGAIN_V_184 = ADDR_AXIL_ISPSLAVE_BASE + 32'h35c,
    ADDR_LSC_REGISTER_RGAIN_V_185 = ADDR_AXIL_ISPSLAVE_BASE + 32'h360,
    ADDR_LSC_REGISTER_RGAIN_V_186 = ADDR_AXIL_ISPSLAVE_BASE + 32'h364,
    ADDR_LSC_REGISTER_RGAIN_V_187 = ADDR_AXIL_ISPSLAVE_BASE + 32'h368,
    ADDR_LSC_REGISTER_RGAIN_V_188 = ADDR_AXIL_ISPSLAVE_BASE + 32'h36c,
    ADDR_LSC_REGISTER_RGAIN_V_189 = ADDR_AXIL_ISPSLAVE_BASE + 32'h370,
    ADDR_LSC_REGISTER_RGAIN_V_190 = ADDR_AXIL_ISPSLAVE_BASE + 32'h374,
    ADDR_LSC_REGISTER_RGAIN_V_191 = ADDR_AXIL_ISPSLAVE_BASE + 32'h378,
    ADDR_LSC_REGISTER_RGAIN_V_192 = ADDR_AXIL_ISPSLAVE_BASE + 32'h37c,
    ADDR_LSC_REGISTER_RGAIN_V_193 = ADDR_AXIL_ISPSLAVE_BASE + 32'h380,
    ADDR_LSC_REGISTER_RGAIN_V_194 = ADDR_AXIL_ISPSLAVE_BASE + 32'h384,
    ADDR_LSC_REGISTER_RGAIN_V_195 = ADDR_AXIL_ISPSLAVE_BASE + 32'h388,
    ADDR_LSC_REGISTER_RGAIN_V_196 = ADDR_AXIL_ISPSLAVE_BASE + 32'h38c,
    ADDR_LSC_REGISTER_RGAIN_V_197 = ADDR_AXIL_ISPSLAVE_BASE + 32'h390,
    ADDR_LSC_REGISTER_RGAIN_V_198 = ADDR_AXIL_ISPSLAVE_BASE + 32'h394,
    ADDR_LSC_REGISTER_RGAIN_V_199 = ADDR_AXIL_ISPSLAVE_BASE + 32'h398,
    ADDR_LSC_REGISTER_RGAIN_V_200 = ADDR_AXIL_ISPSLAVE_BASE + 32'h39c,
    ADDR_LSC_REGISTER_RGAIN_V_201 = ADDR_AXIL_ISPSLAVE_BASE + 32'h3a0,
    ADDR_LSC_REGISTER_RGAIN_V_202 = ADDR_AXIL_ISPSLAVE_BASE + 32'h3a4,
    ADDR_LSC_REGISTER_RGAIN_V_203 = ADDR_AXIL_ISPSLAVE_BASE + 32'h3a8,
    ADDR_LSC_REGISTER_RGAIN_V_204 = ADDR_AXIL_ISPSLAVE_BASE + 32'h3ac,
    ADDR_LSC_REGISTER_RGAIN_V_205 = ADDR_AXIL_ISPSLAVE_BASE + 32'h3b0,
    ADDR_LSC_REGISTER_RGAIN_V_206 = ADDR_AXIL_ISPSLAVE_BASE + 32'h3b4,
    ADDR_LSC_REGISTER_RGAIN_V_207 = ADDR_AXIL_ISPSLAVE_BASE + 32'h3b8,
    ADDR_LSC_REGISTER_RGAIN_V_208 = ADDR_AXIL_ISPSLAVE_BASE + 32'h3bc,
    ADDR_LSC_REGISTER_RGAIN_V_209 = ADDR_AXIL_ISPSLAVE_BASE + 32'h3c0,
    ADDR_LSC_REGISTER_RGAIN_V_210 = ADDR_AXIL_ISPSLAVE_BASE + 32'h3c4,
    ADDR_LSC_REGISTER_RGAIN_V_211 = ADDR_AXIL_ISPSLAVE_BASE + 32'h3c8,
    ADDR_LSC_REGISTER_RGAIN_V_212 = ADDR_AXIL_ISPSLAVE_BASE + 32'h3cc,
    ADDR_LSC_REGISTER_RGAIN_V_213 = ADDR_AXIL_ISPSLAVE_BASE + 32'h3d0,
    ADDR_LSC_REGISTER_RGAIN_V_214 = ADDR_AXIL_ISPSLAVE_BASE + 32'h3d4,
    ADDR_LSC_REGISTER_RGAIN_V_215 = ADDR_AXIL_ISPSLAVE_BASE + 32'h3d8,
    ADDR_LSC_REGISTER_RGAIN_V_216 = ADDR_AXIL_ISPSLAVE_BASE + 32'h3dc,
    ADDR_LSC_REGISTER_RGAIN_V_217 = ADDR_AXIL_ISPSLAVE_BASE + 32'h3e0,
    ADDR_LSC_REGISTER_RGAIN_V_218 = ADDR_AXIL_ISPSLAVE_BASE + 32'h3e4,
    ADDR_LSC_REGISTER_RGAIN_V_219 = ADDR_AXIL_ISPSLAVE_BASE + 32'h3e8,
    ADDR_LSC_REGISTER_RGAIN_V_220 = ADDR_AXIL_ISPSLAVE_BASE + 32'h3ec,
    ADDR_LSC_REGISTER_GRGAIN_V_0 = ADDR_AXIL_ISPSLAVE_BASE + 32'h3f0,
    ADDR_LSC_REGISTER_GRGAIN_V_1 = ADDR_AXIL_ISPSLAVE_BASE + 32'h3f4,
    ADDR_LSC_REGISTER_GRGAIN_V_2 = ADDR_AXIL_ISPSLAVE_BASE + 32'h3f8,
    ADDR_LSC_REGISTER_GRGAIN_V_3 = ADDR_AXIL_ISPSLAVE_BASE + 32'h3fc,
    ADDR_LSC_REGISTER_GRGAIN_V_4 = ADDR_AXIL_ISPSLAVE_BASE + 32'h400,
    ADDR_LSC_REGISTER_GRGAIN_V_5 = ADDR_AXIL_ISPSLAVE_BASE + 32'h404,
    ADDR_LSC_REGISTER_GRGAIN_V_6 = ADDR_AXIL_ISPSLAVE_BASE + 32'h408,
    ADDR_LSC_REGISTER_GRGAIN_V_7 = ADDR_AXIL_ISPSLAVE_BASE + 32'h40c,
    ADDR_LSC_REGISTER_GRGAIN_V_8 = ADDR_AXIL_ISPSLAVE_BASE + 32'h410,
    ADDR_LSC_REGISTER_GRGAIN_V_9 = ADDR_AXIL_ISPSLAVE_BASE + 32'h414,
    ADDR_LSC_REGISTER_GRGAIN_V_10 = ADDR_AXIL_ISPSLAVE_BASE + 32'h418,
    ADDR_LSC_REGISTER_GRGAIN_V_11 = ADDR_AXIL_ISPSLAVE_BASE + 32'h41c,
    ADDR_LSC_REGISTER_GRGAIN_V_12 = ADDR_AXIL_ISPSLAVE_BASE + 32'h420,
    ADDR_LSC_REGISTER_GRGAIN_V_13 = ADDR_AXIL_ISPSLAVE_BASE + 32'h424,
    ADDR_LSC_REGISTER_GRGAIN_V_14 = ADDR_AXIL_ISPSLAVE_BASE + 32'h428,
    ADDR_LSC_REGISTER_GRGAIN_V_15 = ADDR_AXIL_ISPSLAVE_BASE + 32'h42c,
    ADDR_LSC_REGISTER_GRGAIN_V_16 = ADDR_AXIL_ISPSLAVE_BASE + 32'h430,
    ADDR_LSC_REGISTER_GRGAIN_V_17 = ADDR_AXIL_ISPSLAVE_BASE + 32'h434,
    ADDR_LSC_REGISTER_GRGAIN_V_18 = ADDR_AXIL_ISPSLAVE_BASE + 32'h438,
    ADDR_LSC_REGISTER_GRGAIN_V_19 = ADDR_AXIL_ISPSLAVE_BASE + 32'h43c,
    ADDR_LSC_REGISTER_GRGAIN_V_20 = ADDR_AXIL_ISPSLAVE_BASE + 32'h440,
    ADDR_LSC_REGISTER_GRGAIN_V_21 = ADDR_AXIL_ISPSLAVE_BASE + 32'h444,
    ADDR_LSC_REGISTER_GRGAIN_V_22 = ADDR_AXIL_ISPSLAVE_BASE + 32'h448,
    ADDR_LSC_REGISTER_GRGAIN_V_23 = ADDR_AXIL_ISPSLAVE_BASE + 32'h44c,
    ADDR_LSC_REGISTER_GRGAIN_V_24 = ADDR_AXIL_ISPSLAVE_BASE + 32'h450,
    ADDR_LSC_REGISTER_GRGAIN_V_25 = ADDR_AXIL_ISPSLAVE_BASE + 32'h454,
    ADDR_LSC_REGISTER_GRGAIN_V_26 = ADDR_AXIL_ISPSLAVE_BASE + 32'h458,
    ADDR_LSC_REGISTER_GRGAIN_V_27 = ADDR_AXIL_ISPSLAVE_BASE + 32'h45c,
    ADDR_LSC_REGISTER_GRGAIN_V_28 = ADDR_AXIL_ISPSLAVE_BASE + 32'h460,
    ADDR_LSC_REGISTER_GRGAIN_V_29 = ADDR_AXIL_ISPSLAVE_BASE + 32'h464,
    ADDR_LSC_REGISTER_GRGAIN_V_30 = ADDR_AXIL_ISPSLAVE_BASE + 32'h468,
    ADDR_LSC_REGISTER_GRGAIN_V_31 = ADDR_AXIL_ISPSLAVE_BASE + 32'h46c,
    ADDR_LSC_REGISTER_GRGAIN_V_32 = ADDR_AXIL_ISPSLAVE_BASE + 32'h470,
    ADDR_LSC_REGISTER_GRGAIN_V_33 = ADDR_AXIL_ISPSLAVE_BASE + 32'h474,
    ADDR_LSC_REGISTER_GRGAIN_V_34 = ADDR_AXIL_ISPSLAVE_BASE + 32'h478,
    ADDR_LSC_REGISTER_GRGAIN_V_35 = ADDR_AXIL_ISPSLAVE_BASE + 32'h47c,
    ADDR_LSC_REGISTER_GRGAIN_V_36 = ADDR_AXIL_ISPSLAVE_BASE + 32'h480,
    ADDR_LSC_REGISTER_GRGAIN_V_37 = ADDR_AXIL_ISPSLAVE_BASE + 32'h484,
    ADDR_LSC_REGISTER_GRGAIN_V_38 = ADDR_AXIL_ISPSLAVE_BASE + 32'h488,
    ADDR_LSC_REGISTER_GRGAIN_V_39 = ADDR_AXIL_ISPSLAVE_BASE + 32'h48c,
    ADDR_LSC_REGISTER_GRGAIN_V_40 = ADDR_AXIL_ISPSLAVE_BASE + 32'h490,
    ADDR_LSC_REGISTER_GRGAIN_V_41 = ADDR_AXIL_ISPSLAVE_BASE + 32'h494,
    ADDR_LSC_REGISTER_GRGAIN_V_42 = ADDR_AXIL_ISPSLAVE_BASE + 32'h498,
    ADDR_LSC_REGISTER_GRGAIN_V_43 = ADDR_AXIL_ISPSLAVE_BASE + 32'h49c,
    ADDR_LSC_REGISTER_GRGAIN_V_44 = ADDR_AXIL_ISPSLAVE_BASE + 32'h4a0,
    ADDR_LSC_REGISTER_GRGAIN_V_45 = ADDR_AXIL_ISPSLAVE_BASE + 32'h4a4,
    ADDR_LSC_REGISTER_GRGAIN_V_46 = ADDR_AXIL_ISPSLAVE_BASE + 32'h4a8,
    ADDR_LSC_REGISTER_GRGAIN_V_47 = ADDR_AXIL_ISPSLAVE_BASE + 32'h4ac,
    ADDR_LSC_REGISTER_GRGAIN_V_48 = ADDR_AXIL_ISPSLAVE_BASE + 32'h4b0,
    ADDR_LSC_REGISTER_GRGAIN_V_49 = ADDR_AXIL_ISPSLAVE_BASE + 32'h4b4,
    ADDR_LSC_REGISTER_GRGAIN_V_50 = ADDR_AXIL_ISPSLAVE_BASE + 32'h4b8,
    ADDR_LSC_REGISTER_GRGAIN_V_51 = ADDR_AXIL_ISPSLAVE_BASE + 32'h4bc,
    ADDR_LSC_REGISTER_GRGAIN_V_52 = ADDR_AXIL_ISPSLAVE_BASE + 32'h4c0,
    ADDR_LSC_REGISTER_GRGAIN_V_53 = ADDR_AXIL_ISPSLAVE_BASE + 32'h4c4,
    ADDR_LSC_REGISTER_GRGAIN_V_54 = ADDR_AXIL_ISPSLAVE_BASE + 32'h4c8,
    ADDR_LSC_REGISTER_GRGAIN_V_55 = ADDR_AXIL_ISPSLAVE_BASE + 32'h4cc,
    ADDR_LSC_REGISTER_GRGAIN_V_56 = ADDR_AXIL_ISPSLAVE_BASE + 32'h4d0,
    ADDR_LSC_REGISTER_GRGAIN_V_57 = ADDR_AXIL_ISPSLAVE_BASE + 32'h4d4,
    ADDR_LSC_REGISTER_GRGAIN_V_58 = ADDR_AXIL_ISPSLAVE_BASE + 32'h4d8,
    ADDR_LSC_REGISTER_GRGAIN_V_59 = ADDR_AXIL_ISPSLAVE_BASE + 32'h4dc,
    ADDR_LSC_REGISTER_GRGAIN_V_60 = ADDR_AXIL_ISPSLAVE_BASE + 32'h4e0,
    ADDR_LSC_REGISTER_GRGAIN_V_61 = ADDR_AXIL_ISPSLAVE_BASE + 32'h4e4,
    ADDR_LSC_REGISTER_GRGAIN_V_62 = ADDR_AXIL_ISPSLAVE_BASE + 32'h4e8,
    ADDR_LSC_REGISTER_GRGAIN_V_63 = ADDR_AXIL_ISPSLAVE_BASE + 32'h4ec,
    ADDR_LSC_REGISTER_GRGAIN_V_64 = ADDR_AXIL_ISPSLAVE_BASE + 32'h4f0,
    ADDR_LSC_REGISTER_GRGAIN_V_65 = ADDR_AXIL_ISPSLAVE_BASE + 32'h4f4,
    ADDR_LSC_REGISTER_GRGAIN_V_66 = ADDR_AXIL_ISPSLAVE_BASE + 32'h4f8,
    ADDR_LSC_REGISTER_GRGAIN_V_67 = ADDR_AXIL_ISPSLAVE_BASE + 32'h4fc,
    ADDR_LSC_REGISTER_GRGAIN_V_68 = ADDR_AXIL_ISPSLAVE_BASE + 32'h500,
    ADDR_LSC_REGISTER_GRGAIN_V_69 = ADDR_AXIL_ISPSLAVE_BASE + 32'h504,
    ADDR_LSC_REGISTER_GRGAIN_V_70 = ADDR_AXIL_ISPSLAVE_BASE + 32'h508,
    ADDR_LSC_REGISTER_GRGAIN_V_71 = ADDR_AXIL_ISPSLAVE_BASE + 32'h50c,
    ADDR_LSC_REGISTER_GRGAIN_V_72 = ADDR_AXIL_ISPSLAVE_BASE + 32'h510,
    ADDR_LSC_REGISTER_GRGAIN_V_73 = ADDR_AXIL_ISPSLAVE_BASE + 32'h514,
    ADDR_LSC_REGISTER_GRGAIN_V_74 = ADDR_AXIL_ISPSLAVE_BASE + 32'h518,
    ADDR_LSC_REGISTER_GRGAIN_V_75 = ADDR_AXIL_ISPSLAVE_BASE + 32'h51c,
    ADDR_LSC_REGISTER_GRGAIN_V_76 = ADDR_AXIL_ISPSLAVE_BASE + 32'h520,
    ADDR_LSC_REGISTER_GRGAIN_V_77 = ADDR_AXIL_ISPSLAVE_BASE + 32'h524,
    ADDR_LSC_REGISTER_GRGAIN_V_78 = ADDR_AXIL_ISPSLAVE_BASE + 32'h528,
    ADDR_LSC_REGISTER_GRGAIN_V_79 = ADDR_AXIL_ISPSLAVE_BASE + 32'h52c,
    ADDR_LSC_REGISTER_GRGAIN_V_80 = ADDR_AXIL_ISPSLAVE_BASE + 32'h530,
    ADDR_LSC_REGISTER_GRGAIN_V_81 = ADDR_AXIL_ISPSLAVE_BASE + 32'h534,
    ADDR_LSC_REGISTER_GRGAIN_V_82 = ADDR_AXIL_ISPSLAVE_BASE + 32'h538,
    ADDR_LSC_REGISTER_GRGAIN_V_83 = ADDR_AXIL_ISPSLAVE_BASE + 32'h53c,
    ADDR_LSC_REGISTER_GRGAIN_V_84 = ADDR_AXIL_ISPSLAVE_BASE + 32'h540,
    ADDR_LSC_REGISTER_GRGAIN_V_85 = ADDR_AXIL_ISPSLAVE_BASE + 32'h544,
    ADDR_LSC_REGISTER_GRGAIN_V_86 = ADDR_AXIL_ISPSLAVE_BASE + 32'h548,
    ADDR_LSC_REGISTER_GRGAIN_V_87 = ADDR_AXIL_ISPSLAVE_BASE + 32'h54c,
    ADDR_LSC_REGISTER_GRGAIN_V_88 = ADDR_AXIL_ISPSLAVE_BASE + 32'h550,
    ADDR_LSC_REGISTER_GRGAIN_V_89 = ADDR_AXIL_ISPSLAVE_BASE + 32'h554,
    ADDR_LSC_REGISTER_GRGAIN_V_90 = ADDR_AXIL_ISPSLAVE_BASE + 32'h558,
    ADDR_LSC_REGISTER_GRGAIN_V_91 = ADDR_AXIL_ISPSLAVE_BASE + 32'h55c,
    ADDR_LSC_REGISTER_GRGAIN_V_92 = ADDR_AXIL_ISPSLAVE_BASE + 32'h560,
    ADDR_LSC_REGISTER_GRGAIN_V_93 = ADDR_AXIL_ISPSLAVE_BASE + 32'h564,
    ADDR_LSC_REGISTER_GRGAIN_V_94 = ADDR_AXIL_ISPSLAVE_BASE + 32'h568,
    ADDR_LSC_REGISTER_GRGAIN_V_95 = ADDR_AXIL_ISPSLAVE_BASE + 32'h56c,
    ADDR_LSC_REGISTER_GRGAIN_V_96 = ADDR_AXIL_ISPSLAVE_BASE + 32'h570,
    ADDR_LSC_REGISTER_GRGAIN_V_97 = ADDR_AXIL_ISPSLAVE_BASE + 32'h574,
    ADDR_LSC_REGISTER_GRGAIN_V_98 = ADDR_AXIL_ISPSLAVE_BASE + 32'h578,
    ADDR_LSC_REGISTER_GRGAIN_V_99 = ADDR_AXIL_ISPSLAVE_BASE + 32'h57c,
    ADDR_LSC_REGISTER_GRGAIN_V_100 = ADDR_AXIL_ISPSLAVE_BASE + 32'h580,
    ADDR_LSC_REGISTER_GRGAIN_V_101 = ADDR_AXIL_ISPSLAVE_BASE + 32'h584,
    ADDR_LSC_REGISTER_GRGAIN_V_102 = ADDR_AXIL_ISPSLAVE_BASE + 32'h588,
    ADDR_LSC_REGISTER_GRGAIN_V_103 = ADDR_AXIL_ISPSLAVE_BASE + 32'h58c,
    ADDR_LSC_REGISTER_GRGAIN_V_104 = ADDR_AXIL_ISPSLAVE_BASE + 32'h590,
    ADDR_LSC_REGISTER_GRGAIN_V_105 = ADDR_AXIL_ISPSLAVE_BASE + 32'h594,
    ADDR_LSC_REGISTER_GRGAIN_V_106 = ADDR_AXIL_ISPSLAVE_BASE + 32'h598,
    ADDR_LSC_REGISTER_GRGAIN_V_107 = ADDR_AXIL_ISPSLAVE_BASE + 32'h59c,
    ADDR_LSC_REGISTER_GRGAIN_V_108 = ADDR_AXIL_ISPSLAVE_BASE + 32'h5a0,
    ADDR_LSC_REGISTER_GRGAIN_V_109 = ADDR_AXIL_ISPSLAVE_BASE + 32'h5a4,
    ADDR_LSC_REGISTER_GRGAIN_V_110 = ADDR_AXIL_ISPSLAVE_BASE + 32'h5a8,
    ADDR_LSC_REGISTER_GRGAIN_V_111 = ADDR_AXIL_ISPSLAVE_BASE + 32'h5ac,
    ADDR_LSC_REGISTER_GRGAIN_V_112 = ADDR_AXIL_ISPSLAVE_BASE + 32'h5b0,
    ADDR_LSC_REGISTER_GRGAIN_V_113 = ADDR_AXIL_ISPSLAVE_BASE + 32'h5b4,
    ADDR_LSC_REGISTER_GRGAIN_V_114 = ADDR_AXIL_ISPSLAVE_BASE + 32'h5b8,
    ADDR_LSC_REGISTER_GRGAIN_V_115 = ADDR_AXIL_ISPSLAVE_BASE + 32'h5bc,
    ADDR_LSC_REGISTER_GRGAIN_V_116 = ADDR_AXIL_ISPSLAVE_BASE + 32'h5c0,
    ADDR_LSC_REGISTER_GRGAIN_V_117 = ADDR_AXIL_ISPSLAVE_BASE + 32'h5c4,
    ADDR_LSC_REGISTER_GRGAIN_V_118 = ADDR_AXIL_ISPSLAVE_BASE + 32'h5c8,
    ADDR_LSC_REGISTER_GRGAIN_V_119 = ADDR_AXIL_ISPSLAVE_BASE + 32'h5cc,
    ADDR_LSC_REGISTER_GRGAIN_V_120 = ADDR_AXIL_ISPSLAVE_BASE + 32'h5d0,
    ADDR_LSC_REGISTER_GRGAIN_V_121 = ADDR_AXIL_ISPSLAVE_BASE + 32'h5d4,
    ADDR_LSC_REGISTER_GRGAIN_V_122 = ADDR_AXIL_ISPSLAVE_BASE + 32'h5d8,
    ADDR_LSC_REGISTER_GRGAIN_V_123 = ADDR_AXIL_ISPSLAVE_BASE + 32'h5dc,
    ADDR_LSC_REGISTER_GRGAIN_V_124 = ADDR_AXIL_ISPSLAVE_BASE + 32'h5e0,
    ADDR_LSC_REGISTER_GRGAIN_V_125 = ADDR_AXIL_ISPSLAVE_BASE + 32'h5e4,
    ADDR_LSC_REGISTER_GRGAIN_V_126 = ADDR_AXIL_ISPSLAVE_BASE + 32'h5e8,
    ADDR_LSC_REGISTER_GRGAIN_V_127 = ADDR_AXIL_ISPSLAVE_BASE + 32'h5ec,
    ADDR_LSC_REGISTER_GRGAIN_V_128 = ADDR_AXIL_ISPSLAVE_BASE + 32'h5f0,
    ADDR_LSC_REGISTER_GRGAIN_V_129 = ADDR_AXIL_ISPSLAVE_BASE + 32'h5f4,
    ADDR_LSC_REGISTER_GRGAIN_V_130 = ADDR_AXIL_ISPSLAVE_BASE + 32'h5f8,
    ADDR_LSC_REGISTER_GRGAIN_V_131 = ADDR_AXIL_ISPSLAVE_BASE + 32'h5fc,
    ADDR_LSC_REGISTER_GRGAIN_V_132 = ADDR_AXIL_ISPSLAVE_BASE + 32'h600,
    ADDR_LSC_REGISTER_GRGAIN_V_133 = ADDR_AXIL_ISPSLAVE_BASE + 32'h604,
    ADDR_LSC_REGISTER_GRGAIN_V_134 = ADDR_AXIL_ISPSLAVE_BASE + 32'h608,
    ADDR_LSC_REGISTER_GRGAIN_V_135 = ADDR_AXIL_ISPSLAVE_BASE + 32'h60c,
    ADDR_LSC_REGISTER_GRGAIN_V_136 = ADDR_AXIL_ISPSLAVE_BASE + 32'h610,
    ADDR_LSC_REGISTER_GRGAIN_V_137 = ADDR_AXIL_ISPSLAVE_BASE + 32'h614,
    ADDR_LSC_REGISTER_GRGAIN_V_138 = ADDR_AXIL_ISPSLAVE_BASE + 32'h618,
    ADDR_LSC_REGISTER_GRGAIN_V_139 = ADDR_AXIL_ISPSLAVE_BASE + 32'h61c,
    ADDR_LSC_REGISTER_GRGAIN_V_140 = ADDR_AXIL_ISPSLAVE_BASE + 32'h620,
    ADDR_LSC_REGISTER_GRGAIN_V_141 = ADDR_AXIL_ISPSLAVE_BASE + 32'h624,
    ADDR_LSC_REGISTER_GRGAIN_V_142 = ADDR_AXIL_ISPSLAVE_BASE + 32'h628,
    ADDR_LSC_REGISTER_GRGAIN_V_143 = ADDR_AXIL_ISPSLAVE_BASE + 32'h62c,
    ADDR_LSC_REGISTER_GRGAIN_V_144 = ADDR_AXIL_ISPSLAVE_BASE + 32'h630,
    ADDR_LSC_REGISTER_GRGAIN_V_145 = ADDR_AXIL_ISPSLAVE_BASE + 32'h634,
    ADDR_LSC_REGISTER_GRGAIN_V_146 = ADDR_AXIL_ISPSLAVE_BASE + 32'h638,
    ADDR_LSC_REGISTER_GRGAIN_V_147 = ADDR_AXIL_ISPSLAVE_BASE + 32'h63c,
    ADDR_LSC_REGISTER_GRGAIN_V_148 = ADDR_AXIL_ISPSLAVE_BASE + 32'h640,
    ADDR_LSC_REGISTER_GRGAIN_V_149 = ADDR_AXIL_ISPSLAVE_BASE + 32'h644,
    ADDR_LSC_REGISTER_GRGAIN_V_150 = ADDR_AXIL_ISPSLAVE_BASE + 32'h648,
    ADDR_LSC_REGISTER_GRGAIN_V_151 = ADDR_AXIL_ISPSLAVE_BASE + 32'h64c,
    ADDR_LSC_REGISTER_GRGAIN_V_152 = ADDR_AXIL_ISPSLAVE_BASE + 32'h650,
    ADDR_LSC_REGISTER_GRGAIN_V_153 = ADDR_AXIL_ISPSLAVE_BASE + 32'h654,
    ADDR_LSC_REGISTER_GRGAIN_V_154 = ADDR_AXIL_ISPSLAVE_BASE + 32'h658,
    ADDR_LSC_REGISTER_GRGAIN_V_155 = ADDR_AXIL_ISPSLAVE_BASE + 32'h65c,
    ADDR_LSC_REGISTER_GRGAIN_V_156 = ADDR_AXIL_ISPSLAVE_BASE + 32'h660,
    ADDR_LSC_REGISTER_GRGAIN_V_157 = ADDR_AXIL_ISPSLAVE_BASE + 32'h664,
    ADDR_LSC_REGISTER_GRGAIN_V_158 = ADDR_AXIL_ISPSLAVE_BASE + 32'h668,
    ADDR_LSC_REGISTER_GRGAIN_V_159 = ADDR_AXIL_ISPSLAVE_BASE + 32'h66c,
    ADDR_LSC_REGISTER_GRGAIN_V_160 = ADDR_AXIL_ISPSLAVE_BASE + 32'h670,
    ADDR_LSC_REGISTER_GRGAIN_V_161 = ADDR_AXIL_ISPSLAVE_BASE + 32'h674,
    ADDR_LSC_REGISTER_GRGAIN_V_162 = ADDR_AXIL_ISPSLAVE_BASE + 32'h678,
    ADDR_LSC_REGISTER_GRGAIN_V_163 = ADDR_AXIL_ISPSLAVE_BASE + 32'h67c,
    ADDR_LSC_REGISTER_GRGAIN_V_164 = ADDR_AXIL_ISPSLAVE_BASE + 32'h680,
    ADDR_LSC_REGISTER_GRGAIN_V_165 = ADDR_AXIL_ISPSLAVE_BASE + 32'h684,
    ADDR_LSC_REGISTER_GRGAIN_V_166 = ADDR_AXIL_ISPSLAVE_BASE + 32'h688,
    ADDR_LSC_REGISTER_GRGAIN_V_167 = ADDR_AXIL_ISPSLAVE_BASE + 32'h68c,
    ADDR_LSC_REGISTER_GRGAIN_V_168 = ADDR_AXIL_ISPSLAVE_BASE + 32'h690,
    ADDR_LSC_REGISTER_GRGAIN_V_169 = ADDR_AXIL_ISPSLAVE_BASE + 32'h694,
    ADDR_LSC_REGISTER_GRGAIN_V_170 = ADDR_AXIL_ISPSLAVE_BASE + 32'h698,
    ADDR_LSC_REGISTER_GRGAIN_V_171 = ADDR_AXIL_ISPSLAVE_BASE + 32'h69c,
    ADDR_LSC_REGISTER_GRGAIN_V_172 = ADDR_AXIL_ISPSLAVE_BASE + 32'h6a0,
    ADDR_LSC_REGISTER_GRGAIN_V_173 = ADDR_AXIL_ISPSLAVE_BASE + 32'h6a4,
    ADDR_LSC_REGISTER_GRGAIN_V_174 = ADDR_AXIL_ISPSLAVE_BASE + 32'h6a8,
    ADDR_LSC_REGISTER_GRGAIN_V_175 = ADDR_AXIL_ISPSLAVE_BASE + 32'h6ac,
    ADDR_LSC_REGISTER_GRGAIN_V_176 = ADDR_AXIL_ISPSLAVE_BASE + 32'h6b0,
    ADDR_LSC_REGISTER_GRGAIN_V_177 = ADDR_AXIL_ISPSLAVE_BASE + 32'h6b4,
    ADDR_LSC_REGISTER_GRGAIN_V_178 = ADDR_AXIL_ISPSLAVE_BASE + 32'h6b8,
    ADDR_LSC_REGISTER_GRGAIN_V_179 = ADDR_AXIL_ISPSLAVE_BASE + 32'h6bc,
    ADDR_LSC_REGISTER_GRGAIN_V_180 = ADDR_AXIL_ISPSLAVE_BASE + 32'h6c0,
    ADDR_LSC_REGISTER_GRGAIN_V_181 = ADDR_AXIL_ISPSLAVE_BASE + 32'h6c4,
    ADDR_LSC_REGISTER_GRGAIN_V_182 = ADDR_AXIL_ISPSLAVE_BASE + 32'h6c8,
    ADDR_LSC_REGISTER_GRGAIN_V_183 = ADDR_AXIL_ISPSLAVE_BASE + 32'h6cc,
    ADDR_LSC_REGISTER_GRGAIN_V_184 = ADDR_AXIL_ISPSLAVE_BASE + 32'h6d0,
    ADDR_LSC_REGISTER_GRGAIN_V_185 = ADDR_AXIL_ISPSLAVE_BASE + 32'h6d4,
    ADDR_LSC_REGISTER_GRGAIN_V_186 = ADDR_AXIL_ISPSLAVE_BASE + 32'h6d8,
    ADDR_LSC_REGISTER_GRGAIN_V_187 = ADDR_AXIL_ISPSLAVE_BASE + 32'h6dc,
    ADDR_LSC_REGISTER_GRGAIN_V_188 = ADDR_AXIL_ISPSLAVE_BASE + 32'h6e0,
    ADDR_LSC_REGISTER_GRGAIN_V_189 = ADDR_AXIL_ISPSLAVE_BASE + 32'h6e4,
    ADDR_LSC_REGISTER_GRGAIN_V_190 = ADDR_AXIL_ISPSLAVE_BASE + 32'h6e8,
    ADDR_LSC_REGISTER_GRGAIN_V_191 = ADDR_AXIL_ISPSLAVE_BASE + 32'h6ec,
    ADDR_LSC_REGISTER_GRGAIN_V_192 = ADDR_AXIL_ISPSLAVE_BASE + 32'h6f0,
    ADDR_LSC_REGISTER_GRGAIN_V_193 = ADDR_AXIL_ISPSLAVE_BASE + 32'h6f4,
    ADDR_LSC_REGISTER_GRGAIN_V_194 = ADDR_AXIL_ISPSLAVE_BASE + 32'h6f8,
    ADDR_LSC_REGISTER_GRGAIN_V_195 = ADDR_AXIL_ISPSLAVE_BASE + 32'h6fc,
    ADDR_LSC_REGISTER_GRGAIN_V_196 = ADDR_AXIL_ISPSLAVE_BASE + 32'h700,
    ADDR_LSC_REGISTER_GRGAIN_V_197 = ADDR_AXIL_ISPSLAVE_BASE + 32'h704,
    ADDR_LSC_REGISTER_GRGAIN_V_198 = ADDR_AXIL_ISPSLAVE_BASE + 32'h708,
    ADDR_LSC_REGISTER_GRGAIN_V_199 = ADDR_AXIL_ISPSLAVE_BASE + 32'h70c,
    ADDR_LSC_REGISTER_GRGAIN_V_200 = ADDR_AXIL_ISPSLAVE_BASE + 32'h710,
    ADDR_LSC_REGISTER_GRGAIN_V_201 = ADDR_AXIL_ISPSLAVE_BASE + 32'h714,
    ADDR_LSC_REGISTER_GRGAIN_V_202 = ADDR_AXIL_ISPSLAVE_BASE + 32'h718,
    ADDR_LSC_REGISTER_GRGAIN_V_203 = ADDR_AXIL_ISPSLAVE_BASE + 32'h71c,
    ADDR_LSC_REGISTER_GRGAIN_V_204 = ADDR_AXIL_ISPSLAVE_BASE + 32'h720,
    ADDR_LSC_REGISTER_GRGAIN_V_205 = ADDR_AXIL_ISPSLAVE_BASE + 32'h724,
    ADDR_LSC_REGISTER_GRGAIN_V_206 = ADDR_AXIL_ISPSLAVE_BASE + 32'h728,
    ADDR_LSC_REGISTER_GRGAIN_V_207 = ADDR_AXIL_ISPSLAVE_BASE + 32'h72c,
    ADDR_LSC_REGISTER_GRGAIN_V_208 = ADDR_AXIL_ISPSLAVE_BASE + 32'h730,
    ADDR_LSC_REGISTER_GRGAIN_V_209 = ADDR_AXIL_ISPSLAVE_BASE + 32'h734,
    ADDR_LSC_REGISTER_GRGAIN_V_210 = ADDR_AXIL_ISPSLAVE_BASE + 32'h738,
    ADDR_LSC_REGISTER_GRGAIN_V_211 = ADDR_AXIL_ISPSLAVE_BASE + 32'h73c,
    ADDR_LSC_REGISTER_GRGAIN_V_212 = ADDR_AXIL_ISPSLAVE_BASE + 32'h740,
    ADDR_LSC_REGISTER_GRGAIN_V_213 = ADDR_AXIL_ISPSLAVE_BASE + 32'h744,
    ADDR_LSC_REGISTER_GRGAIN_V_214 = ADDR_AXIL_ISPSLAVE_BASE + 32'h748,
    ADDR_LSC_REGISTER_GRGAIN_V_215 = ADDR_AXIL_ISPSLAVE_BASE + 32'h74c,
    ADDR_LSC_REGISTER_GRGAIN_V_216 = ADDR_AXIL_ISPSLAVE_BASE + 32'h750,
    ADDR_LSC_REGISTER_GRGAIN_V_217 = ADDR_AXIL_ISPSLAVE_BASE + 32'h754,
    ADDR_LSC_REGISTER_GRGAIN_V_218 = ADDR_AXIL_ISPSLAVE_BASE + 32'h758,
    ADDR_LSC_REGISTER_GRGAIN_V_219 = ADDR_AXIL_ISPSLAVE_BASE + 32'h75c,
    ADDR_LSC_REGISTER_GRGAIN_V_220 = ADDR_AXIL_ISPSLAVE_BASE + 32'h760,
    ADDR_LSC_REGISTER_GBGAIN_V_0 = ADDR_AXIL_ISPSLAVE_BASE + 32'h764,
    ADDR_LSC_REGISTER_GBGAIN_V_1 = ADDR_AXIL_ISPSLAVE_BASE + 32'h768,
    ADDR_LSC_REGISTER_GBGAIN_V_2 = ADDR_AXIL_ISPSLAVE_BASE + 32'h76c,
    ADDR_LSC_REGISTER_GBGAIN_V_3 = ADDR_AXIL_ISPSLAVE_BASE + 32'h770,
    ADDR_LSC_REGISTER_GBGAIN_V_4 = ADDR_AXIL_ISPSLAVE_BASE + 32'h774,
    ADDR_LSC_REGISTER_GBGAIN_V_5 = ADDR_AXIL_ISPSLAVE_BASE + 32'h778,
    ADDR_LSC_REGISTER_GBGAIN_V_6 = ADDR_AXIL_ISPSLAVE_BASE + 32'h77c,
    ADDR_LSC_REGISTER_GBGAIN_V_7 = ADDR_AXIL_ISPSLAVE_BASE + 32'h780,
    ADDR_LSC_REGISTER_GBGAIN_V_8 = ADDR_AXIL_ISPSLAVE_BASE + 32'h784,
    ADDR_LSC_REGISTER_GBGAIN_V_9 = ADDR_AXIL_ISPSLAVE_BASE + 32'h788,
    ADDR_LSC_REGISTER_GBGAIN_V_10 = ADDR_AXIL_ISPSLAVE_BASE + 32'h78c,
    ADDR_LSC_REGISTER_GBGAIN_V_11 = ADDR_AXIL_ISPSLAVE_BASE + 32'h790,
    ADDR_LSC_REGISTER_GBGAIN_V_12 = ADDR_AXIL_ISPSLAVE_BASE + 32'h794,
    ADDR_LSC_REGISTER_GBGAIN_V_13 = ADDR_AXIL_ISPSLAVE_BASE + 32'h798,
    ADDR_LSC_REGISTER_GBGAIN_V_14 = ADDR_AXIL_ISPSLAVE_BASE + 32'h79c,
    ADDR_LSC_REGISTER_GBGAIN_V_15 = ADDR_AXIL_ISPSLAVE_BASE + 32'h7a0,
    ADDR_LSC_REGISTER_GBGAIN_V_16 = ADDR_AXIL_ISPSLAVE_BASE + 32'h7a4,
    ADDR_LSC_REGISTER_GBGAIN_V_17 = ADDR_AXIL_ISPSLAVE_BASE + 32'h7a8,
    ADDR_LSC_REGISTER_GBGAIN_V_18 = ADDR_AXIL_ISPSLAVE_BASE + 32'h7ac,
    ADDR_LSC_REGISTER_GBGAIN_V_19 = ADDR_AXIL_ISPSLAVE_BASE + 32'h7b0,
    ADDR_LSC_REGISTER_GBGAIN_V_20 = ADDR_AXIL_ISPSLAVE_BASE + 32'h7b4,
    ADDR_LSC_REGISTER_GBGAIN_V_21 = ADDR_AXIL_ISPSLAVE_BASE + 32'h7b8,
    ADDR_LSC_REGISTER_GBGAIN_V_22 = ADDR_AXIL_ISPSLAVE_BASE + 32'h7bc,
    ADDR_LSC_REGISTER_GBGAIN_V_23 = ADDR_AXIL_ISPSLAVE_BASE + 32'h7c0,
    ADDR_LSC_REGISTER_GBGAIN_V_24 = ADDR_AXIL_ISPSLAVE_BASE + 32'h7c4,
    ADDR_LSC_REGISTER_GBGAIN_V_25 = ADDR_AXIL_ISPSLAVE_BASE + 32'h7c8,
    ADDR_LSC_REGISTER_GBGAIN_V_26 = ADDR_AXIL_ISPSLAVE_BASE + 32'h7cc,
    ADDR_LSC_REGISTER_GBGAIN_V_27 = ADDR_AXIL_ISPSLAVE_BASE + 32'h7d0,
    ADDR_LSC_REGISTER_GBGAIN_V_28 = ADDR_AXIL_ISPSLAVE_BASE + 32'h7d4,
    ADDR_LSC_REGISTER_GBGAIN_V_29 = ADDR_AXIL_ISPSLAVE_BASE + 32'h7d8,
    ADDR_LSC_REGISTER_GBGAIN_V_30 = ADDR_AXIL_ISPSLAVE_BASE + 32'h7dc,
    ADDR_LSC_REGISTER_GBGAIN_V_31 = ADDR_AXIL_ISPSLAVE_BASE + 32'h7e0,
    ADDR_LSC_REGISTER_GBGAIN_V_32 = ADDR_AXIL_ISPSLAVE_BASE + 32'h7e4,
    ADDR_LSC_REGISTER_GBGAIN_V_33 = ADDR_AXIL_ISPSLAVE_BASE + 32'h7e8,
    ADDR_LSC_REGISTER_GBGAIN_V_34 = ADDR_AXIL_ISPSLAVE_BASE + 32'h7ec,
    ADDR_LSC_REGISTER_GBGAIN_V_35 = ADDR_AXIL_ISPSLAVE_BASE + 32'h7f0,
    ADDR_LSC_REGISTER_GBGAIN_V_36 = ADDR_AXIL_ISPSLAVE_BASE + 32'h7f4,
    ADDR_LSC_REGISTER_GBGAIN_V_37 = ADDR_AXIL_ISPSLAVE_BASE + 32'h7f8,
    ADDR_LSC_REGISTER_GBGAIN_V_38 = ADDR_AXIL_ISPSLAVE_BASE + 32'h7fc,
    ADDR_LSC_REGISTER_GBGAIN_V_39 = ADDR_AXIL_ISPSLAVE_BASE + 32'h800,
    ADDR_LSC_REGISTER_GBGAIN_V_40 = ADDR_AXIL_ISPSLAVE_BASE + 32'h804,
    ADDR_LSC_REGISTER_GBGAIN_V_41 = ADDR_AXIL_ISPSLAVE_BASE + 32'h808,
    ADDR_LSC_REGISTER_GBGAIN_V_42 = ADDR_AXIL_ISPSLAVE_BASE + 32'h80c,
    ADDR_LSC_REGISTER_GBGAIN_V_43 = ADDR_AXIL_ISPSLAVE_BASE + 32'h810,
    ADDR_LSC_REGISTER_GBGAIN_V_44 = ADDR_AXIL_ISPSLAVE_BASE + 32'h814,
    ADDR_LSC_REGISTER_GBGAIN_V_45 = ADDR_AXIL_ISPSLAVE_BASE + 32'h818,
    ADDR_LSC_REGISTER_GBGAIN_V_46 = ADDR_AXIL_ISPSLAVE_BASE + 32'h81c,
    ADDR_LSC_REGISTER_GBGAIN_V_47 = ADDR_AXIL_ISPSLAVE_BASE + 32'h820,
    ADDR_LSC_REGISTER_GBGAIN_V_48 = ADDR_AXIL_ISPSLAVE_BASE + 32'h824,
    ADDR_LSC_REGISTER_GBGAIN_V_49 = ADDR_AXIL_ISPSLAVE_BASE + 32'h828,
    ADDR_LSC_REGISTER_GBGAIN_V_50 = ADDR_AXIL_ISPSLAVE_BASE + 32'h82c,
    ADDR_LSC_REGISTER_GBGAIN_V_51 = ADDR_AXIL_ISPSLAVE_BASE + 32'h830,
    ADDR_LSC_REGISTER_GBGAIN_V_52 = ADDR_AXIL_ISPSLAVE_BASE + 32'h834,
    ADDR_LSC_REGISTER_GBGAIN_V_53 = ADDR_AXIL_ISPSLAVE_BASE + 32'h838,
    ADDR_LSC_REGISTER_GBGAIN_V_54 = ADDR_AXIL_ISPSLAVE_BASE + 32'h83c,
    ADDR_LSC_REGISTER_GBGAIN_V_55 = ADDR_AXIL_ISPSLAVE_BASE + 32'h840,
    ADDR_LSC_REGISTER_GBGAIN_V_56 = ADDR_AXIL_ISPSLAVE_BASE + 32'h844,
    ADDR_LSC_REGISTER_GBGAIN_V_57 = ADDR_AXIL_ISPSLAVE_BASE + 32'h848,
    ADDR_LSC_REGISTER_GBGAIN_V_58 = ADDR_AXIL_ISPSLAVE_BASE + 32'h84c,
    ADDR_LSC_REGISTER_GBGAIN_V_59 = ADDR_AXIL_ISPSLAVE_BASE + 32'h850,
    ADDR_LSC_REGISTER_GBGAIN_V_60 = ADDR_AXIL_ISPSLAVE_BASE + 32'h854,
    ADDR_LSC_REGISTER_GBGAIN_V_61 = ADDR_AXIL_ISPSLAVE_BASE + 32'h858,
    ADDR_LSC_REGISTER_GBGAIN_V_62 = ADDR_AXIL_ISPSLAVE_BASE + 32'h85c,
    ADDR_LSC_REGISTER_GBGAIN_V_63 = ADDR_AXIL_ISPSLAVE_BASE + 32'h860,
    ADDR_LSC_REGISTER_GBGAIN_V_64 = ADDR_AXIL_ISPSLAVE_BASE + 32'h864,
    ADDR_LSC_REGISTER_GBGAIN_V_65 = ADDR_AXIL_ISPSLAVE_BASE + 32'h868,
    ADDR_LSC_REGISTER_GBGAIN_V_66 = ADDR_AXIL_ISPSLAVE_BASE + 32'h86c,
    ADDR_LSC_REGISTER_GBGAIN_V_67 = ADDR_AXIL_ISPSLAVE_BASE + 32'h870,
    ADDR_LSC_REGISTER_GBGAIN_V_68 = ADDR_AXIL_ISPSLAVE_BASE + 32'h874,
    ADDR_LSC_REGISTER_GBGAIN_V_69 = ADDR_AXIL_ISPSLAVE_BASE + 32'h878,
    ADDR_LSC_REGISTER_GBGAIN_V_70 = ADDR_AXIL_ISPSLAVE_BASE + 32'h87c,
    ADDR_LSC_REGISTER_GBGAIN_V_71 = ADDR_AXIL_ISPSLAVE_BASE + 32'h880,
    ADDR_LSC_REGISTER_GBGAIN_V_72 = ADDR_AXIL_ISPSLAVE_BASE + 32'h884,
    ADDR_LSC_REGISTER_GBGAIN_V_73 = ADDR_AXIL_ISPSLAVE_BASE + 32'h888,
    ADDR_LSC_REGISTER_GBGAIN_V_74 = ADDR_AXIL_ISPSLAVE_BASE + 32'h88c,
    ADDR_LSC_REGISTER_GBGAIN_V_75 = ADDR_AXIL_ISPSLAVE_BASE + 32'h890,
    ADDR_LSC_REGISTER_GBGAIN_V_76 = ADDR_AXIL_ISPSLAVE_BASE + 32'h894,
    ADDR_LSC_REGISTER_GBGAIN_V_77 = ADDR_AXIL_ISPSLAVE_BASE + 32'h898,
    ADDR_LSC_REGISTER_GBGAIN_V_78 = ADDR_AXIL_ISPSLAVE_BASE + 32'h89c,
    ADDR_LSC_REGISTER_GBGAIN_V_79 = ADDR_AXIL_ISPSLAVE_BASE + 32'h8a0,
    ADDR_LSC_REGISTER_GBGAIN_V_80 = ADDR_AXIL_ISPSLAVE_BASE + 32'h8a4,
    ADDR_LSC_REGISTER_GBGAIN_V_81 = ADDR_AXIL_ISPSLAVE_BASE + 32'h8a8,
    ADDR_LSC_REGISTER_GBGAIN_V_82 = ADDR_AXIL_ISPSLAVE_BASE + 32'h8ac,
    ADDR_LSC_REGISTER_GBGAIN_V_83 = ADDR_AXIL_ISPSLAVE_BASE + 32'h8b0,
    ADDR_LSC_REGISTER_GBGAIN_V_84 = ADDR_AXIL_ISPSLAVE_BASE + 32'h8b4,
    ADDR_LSC_REGISTER_GBGAIN_V_85 = ADDR_AXIL_ISPSLAVE_BASE + 32'h8b8,
    ADDR_LSC_REGISTER_GBGAIN_V_86 = ADDR_AXIL_ISPSLAVE_BASE + 32'h8bc,
    ADDR_LSC_REGISTER_GBGAIN_V_87 = ADDR_AXIL_ISPSLAVE_BASE + 32'h8c0,
    ADDR_LSC_REGISTER_GBGAIN_V_88 = ADDR_AXIL_ISPSLAVE_BASE + 32'h8c4,
    ADDR_LSC_REGISTER_GBGAIN_V_89 = ADDR_AXIL_ISPSLAVE_BASE + 32'h8c8,
    ADDR_LSC_REGISTER_GBGAIN_V_90 = ADDR_AXIL_ISPSLAVE_BASE + 32'h8cc,
    ADDR_LSC_REGISTER_GBGAIN_V_91 = ADDR_AXIL_ISPSLAVE_BASE + 32'h8d0,
    ADDR_LSC_REGISTER_GBGAIN_V_92 = ADDR_AXIL_ISPSLAVE_BASE + 32'h8d4,
    ADDR_LSC_REGISTER_GBGAIN_V_93 = ADDR_AXIL_ISPSLAVE_BASE + 32'h8d8,
    ADDR_LSC_REGISTER_GBGAIN_V_94 = ADDR_AXIL_ISPSLAVE_BASE + 32'h8dc,
    ADDR_LSC_REGISTER_GBGAIN_V_95 = ADDR_AXIL_ISPSLAVE_BASE + 32'h8e0,
    ADDR_LSC_REGISTER_GBGAIN_V_96 = ADDR_AXIL_ISPSLAVE_BASE + 32'h8e4,
    ADDR_LSC_REGISTER_GBGAIN_V_97 = ADDR_AXIL_ISPSLAVE_BASE + 32'h8e8,
    ADDR_LSC_REGISTER_GBGAIN_V_98 = ADDR_AXIL_ISPSLAVE_BASE + 32'h8ec,
    ADDR_LSC_REGISTER_GBGAIN_V_99 = ADDR_AXIL_ISPSLAVE_BASE + 32'h8f0,
    ADDR_LSC_REGISTER_GBGAIN_V_100 = ADDR_AXIL_ISPSLAVE_BASE + 32'h8f4,
    ADDR_LSC_REGISTER_GBGAIN_V_101 = ADDR_AXIL_ISPSLAVE_BASE + 32'h8f8,
    ADDR_LSC_REGISTER_GBGAIN_V_102 = ADDR_AXIL_ISPSLAVE_BASE + 32'h8fc,
    ADDR_LSC_REGISTER_GBGAIN_V_103 = ADDR_AXIL_ISPSLAVE_BASE + 32'h900,
    ADDR_LSC_REGISTER_GBGAIN_V_104 = ADDR_AXIL_ISPSLAVE_BASE + 32'h904,
    ADDR_LSC_REGISTER_GBGAIN_V_105 = ADDR_AXIL_ISPSLAVE_BASE + 32'h908,
    ADDR_LSC_REGISTER_GBGAIN_V_106 = ADDR_AXIL_ISPSLAVE_BASE + 32'h90c,
    ADDR_LSC_REGISTER_GBGAIN_V_107 = ADDR_AXIL_ISPSLAVE_BASE + 32'h910,
    ADDR_LSC_REGISTER_GBGAIN_V_108 = ADDR_AXIL_ISPSLAVE_BASE + 32'h914,
    ADDR_LSC_REGISTER_GBGAIN_V_109 = ADDR_AXIL_ISPSLAVE_BASE + 32'h918,
    ADDR_LSC_REGISTER_GBGAIN_V_110 = ADDR_AXIL_ISPSLAVE_BASE + 32'h91c,
    ADDR_LSC_REGISTER_GBGAIN_V_111 = ADDR_AXIL_ISPSLAVE_BASE + 32'h920,
    ADDR_LSC_REGISTER_GBGAIN_V_112 = ADDR_AXIL_ISPSLAVE_BASE + 32'h924,
    ADDR_LSC_REGISTER_GBGAIN_V_113 = ADDR_AXIL_ISPSLAVE_BASE + 32'h928,
    ADDR_LSC_REGISTER_GBGAIN_V_114 = ADDR_AXIL_ISPSLAVE_BASE + 32'h92c,
    ADDR_LSC_REGISTER_GBGAIN_V_115 = ADDR_AXIL_ISPSLAVE_BASE + 32'h930,
    ADDR_LSC_REGISTER_GBGAIN_V_116 = ADDR_AXIL_ISPSLAVE_BASE + 32'h934,
    ADDR_LSC_REGISTER_GBGAIN_V_117 = ADDR_AXIL_ISPSLAVE_BASE + 32'h938,
    ADDR_LSC_REGISTER_GBGAIN_V_118 = ADDR_AXIL_ISPSLAVE_BASE + 32'h93c,
    ADDR_LSC_REGISTER_GBGAIN_V_119 = ADDR_AXIL_ISPSLAVE_BASE + 32'h940,
    ADDR_LSC_REGISTER_GBGAIN_V_120 = ADDR_AXIL_ISPSLAVE_BASE + 32'h944,
    ADDR_LSC_REGISTER_GBGAIN_V_121 = ADDR_AXIL_ISPSLAVE_BASE + 32'h948,
    ADDR_LSC_REGISTER_GBGAIN_V_122 = ADDR_AXIL_ISPSLAVE_BASE + 32'h94c,
    ADDR_LSC_REGISTER_GBGAIN_V_123 = ADDR_AXIL_ISPSLAVE_BASE + 32'h950,
    ADDR_LSC_REGISTER_GBGAIN_V_124 = ADDR_AXIL_ISPSLAVE_BASE + 32'h954,
    ADDR_LSC_REGISTER_GBGAIN_V_125 = ADDR_AXIL_ISPSLAVE_BASE + 32'h958,
    ADDR_LSC_REGISTER_GBGAIN_V_126 = ADDR_AXIL_ISPSLAVE_BASE + 32'h95c,
    ADDR_LSC_REGISTER_GBGAIN_V_127 = ADDR_AXIL_ISPSLAVE_BASE + 32'h960,
    ADDR_LSC_REGISTER_GBGAIN_V_128 = ADDR_AXIL_ISPSLAVE_BASE + 32'h964,
    ADDR_LSC_REGISTER_GBGAIN_V_129 = ADDR_AXIL_ISPSLAVE_BASE + 32'h968,
    ADDR_LSC_REGISTER_GBGAIN_V_130 = ADDR_AXIL_ISPSLAVE_BASE + 32'h96c,
    ADDR_LSC_REGISTER_GBGAIN_V_131 = ADDR_AXIL_ISPSLAVE_BASE + 32'h970,
    ADDR_LSC_REGISTER_GBGAIN_V_132 = ADDR_AXIL_ISPSLAVE_BASE + 32'h974,
    ADDR_LSC_REGISTER_GBGAIN_V_133 = ADDR_AXIL_ISPSLAVE_BASE + 32'h978,
    ADDR_LSC_REGISTER_GBGAIN_V_134 = ADDR_AXIL_ISPSLAVE_BASE + 32'h97c,
    ADDR_LSC_REGISTER_GBGAIN_V_135 = ADDR_AXIL_ISPSLAVE_BASE + 32'h980,
    ADDR_LSC_REGISTER_GBGAIN_V_136 = ADDR_AXIL_ISPSLAVE_BASE + 32'h984,
    ADDR_LSC_REGISTER_GBGAIN_V_137 = ADDR_AXIL_ISPSLAVE_BASE + 32'h988,
    ADDR_LSC_REGISTER_GBGAIN_V_138 = ADDR_AXIL_ISPSLAVE_BASE + 32'h98c,
    ADDR_LSC_REGISTER_GBGAIN_V_139 = ADDR_AXIL_ISPSLAVE_BASE + 32'h990,
    ADDR_LSC_REGISTER_GBGAIN_V_140 = ADDR_AXIL_ISPSLAVE_BASE + 32'h994,
    ADDR_LSC_REGISTER_GBGAIN_V_141 = ADDR_AXIL_ISPSLAVE_BASE + 32'h998,
    ADDR_LSC_REGISTER_GBGAIN_V_142 = ADDR_AXIL_ISPSLAVE_BASE + 32'h99c,
    ADDR_LSC_REGISTER_GBGAIN_V_143 = ADDR_AXIL_ISPSLAVE_BASE + 32'h9a0,
    ADDR_LSC_REGISTER_GBGAIN_V_144 = ADDR_AXIL_ISPSLAVE_BASE + 32'h9a4,
    ADDR_LSC_REGISTER_GBGAIN_V_145 = ADDR_AXIL_ISPSLAVE_BASE + 32'h9a8,
    ADDR_LSC_REGISTER_GBGAIN_V_146 = ADDR_AXIL_ISPSLAVE_BASE + 32'h9ac,
    ADDR_LSC_REGISTER_GBGAIN_V_147 = ADDR_AXIL_ISPSLAVE_BASE + 32'h9b0,
    ADDR_LSC_REGISTER_GBGAIN_V_148 = ADDR_AXIL_ISPSLAVE_BASE + 32'h9b4,
    ADDR_LSC_REGISTER_GBGAIN_V_149 = ADDR_AXIL_ISPSLAVE_BASE + 32'h9b8,
    ADDR_LSC_REGISTER_GBGAIN_V_150 = ADDR_AXIL_ISPSLAVE_BASE + 32'h9bc,
    ADDR_LSC_REGISTER_GBGAIN_V_151 = ADDR_AXIL_ISPSLAVE_BASE + 32'h9c0,
    ADDR_LSC_REGISTER_GBGAIN_V_152 = ADDR_AXIL_ISPSLAVE_BASE + 32'h9c4,
    ADDR_LSC_REGISTER_GBGAIN_V_153 = ADDR_AXIL_ISPSLAVE_BASE + 32'h9c8,
    ADDR_LSC_REGISTER_GBGAIN_V_154 = ADDR_AXIL_ISPSLAVE_BASE + 32'h9cc,
    ADDR_LSC_REGISTER_GBGAIN_V_155 = ADDR_AXIL_ISPSLAVE_BASE + 32'h9d0,
    ADDR_LSC_REGISTER_GBGAIN_V_156 = ADDR_AXIL_ISPSLAVE_BASE + 32'h9d4,
    ADDR_LSC_REGISTER_GBGAIN_V_157 = ADDR_AXIL_ISPSLAVE_BASE + 32'h9d8,
    ADDR_LSC_REGISTER_GBGAIN_V_158 = ADDR_AXIL_ISPSLAVE_BASE + 32'h9dc,
    ADDR_LSC_REGISTER_GBGAIN_V_159 = ADDR_AXIL_ISPSLAVE_BASE + 32'h9e0,
    ADDR_LSC_REGISTER_GBGAIN_V_160 = ADDR_AXIL_ISPSLAVE_BASE + 32'h9e4,
    ADDR_LSC_REGISTER_GBGAIN_V_161 = ADDR_AXIL_ISPSLAVE_BASE + 32'h9e8,
    ADDR_LSC_REGISTER_GBGAIN_V_162 = ADDR_AXIL_ISPSLAVE_BASE + 32'h9ec,
    ADDR_LSC_REGISTER_GBGAIN_V_163 = ADDR_AXIL_ISPSLAVE_BASE + 32'h9f0,
    ADDR_LSC_REGISTER_GBGAIN_V_164 = ADDR_AXIL_ISPSLAVE_BASE + 32'h9f4,
    ADDR_LSC_REGISTER_GBGAIN_V_165 = ADDR_AXIL_ISPSLAVE_BASE + 32'h9f8,
    ADDR_LSC_REGISTER_GBGAIN_V_166 = ADDR_AXIL_ISPSLAVE_BASE + 32'h9fc,
    ADDR_LSC_REGISTER_GBGAIN_V_167 = ADDR_AXIL_ISPSLAVE_BASE + 32'ha00,
    ADDR_LSC_REGISTER_GBGAIN_V_168 = ADDR_AXIL_ISPSLAVE_BASE + 32'ha04,
    ADDR_LSC_REGISTER_GBGAIN_V_169 = ADDR_AXIL_ISPSLAVE_BASE + 32'ha08,
    ADDR_LSC_REGISTER_GBGAIN_V_170 = ADDR_AXIL_ISPSLAVE_BASE + 32'ha0c,
    ADDR_LSC_REGISTER_GBGAIN_V_171 = ADDR_AXIL_ISPSLAVE_BASE + 32'ha10,
    ADDR_LSC_REGISTER_GBGAIN_V_172 = ADDR_AXIL_ISPSLAVE_BASE + 32'ha14,
    ADDR_LSC_REGISTER_GBGAIN_V_173 = ADDR_AXIL_ISPSLAVE_BASE + 32'ha18,
    ADDR_LSC_REGISTER_GBGAIN_V_174 = ADDR_AXIL_ISPSLAVE_BASE + 32'ha1c,
    ADDR_LSC_REGISTER_GBGAIN_V_175 = ADDR_AXIL_ISPSLAVE_BASE + 32'ha20,
    ADDR_LSC_REGISTER_GBGAIN_V_176 = ADDR_AXIL_ISPSLAVE_BASE + 32'ha24,
    ADDR_LSC_REGISTER_GBGAIN_V_177 = ADDR_AXIL_ISPSLAVE_BASE + 32'ha28,
    ADDR_LSC_REGISTER_GBGAIN_V_178 = ADDR_AXIL_ISPSLAVE_BASE + 32'ha2c,
    ADDR_LSC_REGISTER_GBGAIN_V_179 = ADDR_AXIL_ISPSLAVE_BASE + 32'ha30,
    ADDR_LSC_REGISTER_GBGAIN_V_180 = ADDR_AXIL_ISPSLAVE_BASE + 32'ha34,
    ADDR_LSC_REGISTER_GBGAIN_V_181 = ADDR_AXIL_ISPSLAVE_BASE + 32'ha38,
    ADDR_LSC_REGISTER_GBGAIN_V_182 = ADDR_AXIL_ISPSLAVE_BASE + 32'ha3c,
    ADDR_LSC_REGISTER_GBGAIN_V_183 = ADDR_AXIL_ISPSLAVE_BASE + 32'ha40,
    ADDR_LSC_REGISTER_GBGAIN_V_184 = ADDR_AXIL_ISPSLAVE_BASE + 32'ha44,
    ADDR_LSC_REGISTER_GBGAIN_V_185 = ADDR_AXIL_ISPSLAVE_BASE + 32'ha48,
    ADDR_LSC_REGISTER_GBGAIN_V_186 = ADDR_AXIL_ISPSLAVE_BASE + 32'ha4c,
    ADDR_LSC_REGISTER_GBGAIN_V_187 = ADDR_AXIL_ISPSLAVE_BASE + 32'ha50,
    ADDR_LSC_REGISTER_GBGAIN_V_188 = ADDR_AXIL_ISPSLAVE_BASE + 32'ha54,
    ADDR_LSC_REGISTER_GBGAIN_V_189 = ADDR_AXIL_ISPSLAVE_BASE + 32'ha58,
    ADDR_LSC_REGISTER_GBGAIN_V_190 = ADDR_AXIL_ISPSLAVE_BASE + 32'ha5c,
    ADDR_LSC_REGISTER_GBGAIN_V_191 = ADDR_AXIL_ISPSLAVE_BASE + 32'ha60,
    ADDR_LSC_REGISTER_GBGAIN_V_192 = ADDR_AXIL_ISPSLAVE_BASE + 32'ha64,
    ADDR_LSC_REGISTER_GBGAIN_V_193 = ADDR_AXIL_ISPSLAVE_BASE + 32'ha68,
    ADDR_LSC_REGISTER_GBGAIN_V_194 = ADDR_AXIL_ISPSLAVE_BASE + 32'ha6c,
    ADDR_LSC_REGISTER_GBGAIN_V_195 = ADDR_AXIL_ISPSLAVE_BASE + 32'ha70,
    ADDR_LSC_REGISTER_GBGAIN_V_196 = ADDR_AXIL_ISPSLAVE_BASE + 32'ha74,
    ADDR_LSC_REGISTER_GBGAIN_V_197 = ADDR_AXIL_ISPSLAVE_BASE + 32'ha78,
    ADDR_LSC_REGISTER_GBGAIN_V_198 = ADDR_AXIL_ISPSLAVE_BASE + 32'ha7c,
    ADDR_LSC_REGISTER_GBGAIN_V_199 = ADDR_AXIL_ISPSLAVE_BASE + 32'ha80,
    ADDR_LSC_REGISTER_GBGAIN_V_200 = ADDR_AXIL_ISPSLAVE_BASE + 32'ha84,
    ADDR_LSC_REGISTER_GBGAIN_V_201 = ADDR_AXIL_ISPSLAVE_BASE + 32'ha88,
    ADDR_LSC_REGISTER_GBGAIN_V_202 = ADDR_AXIL_ISPSLAVE_BASE + 32'ha8c,
    ADDR_LSC_REGISTER_GBGAIN_V_203 = ADDR_AXIL_ISPSLAVE_BASE + 32'ha90,
    ADDR_LSC_REGISTER_GBGAIN_V_204 = ADDR_AXIL_ISPSLAVE_BASE + 32'ha94,
    ADDR_LSC_REGISTER_GBGAIN_V_205 = ADDR_AXIL_ISPSLAVE_BASE + 32'ha98,
    ADDR_LSC_REGISTER_GBGAIN_V_206 = ADDR_AXIL_ISPSLAVE_BASE + 32'ha9c,
    ADDR_LSC_REGISTER_GBGAIN_V_207 = ADDR_AXIL_ISPSLAVE_BASE + 32'haa0,
    ADDR_LSC_REGISTER_GBGAIN_V_208 = ADDR_AXIL_ISPSLAVE_BASE + 32'haa4,
    ADDR_LSC_REGISTER_GBGAIN_V_209 = ADDR_AXIL_ISPSLAVE_BASE + 32'haa8,
    ADDR_LSC_REGISTER_GBGAIN_V_210 = ADDR_AXIL_ISPSLAVE_BASE + 32'haac,
    ADDR_LSC_REGISTER_GBGAIN_V_211 = ADDR_AXIL_ISPSLAVE_BASE + 32'hab0,
    ADDR_LSC_REGISTER_GBGAIN_V_212 = ADDR_AXIL_ISPSLAVE_BASE + 32'hab4,
    ADDR_LSC_REGISTER_GBGAIN_V_213 = ADDR_AXIL_ISPSLAVE_BASE + 32'hab8,
    ADDR_LSC_REGISTER_GBGAIN_V_214 = ADDR_AXIL_ISPSLAVE_BASE + 32'habc,
    ADDR_LSC_REGISTER_GBGAIN_V_215 = ADDR_AXIL_ISPSLAVE_BASE + 32'hac0,
    ADDR_LSC_REGISTER_GBGAIN_V_216 = ADDR_AXIL_ISPSLAVE_BASE + 32'hac4,
    ADDR_LSC_REGISTER_GBGAIN_V_217 = ADDR_AXIL_ISPSLAVE_BASE + 32'hac8,
    ADDR_LSC_REGISTER_GBGAIN_V_218 = ADDR_AXIL_ISPSLAVE_BASE + 32'hacc,
    ADDR_LSC_REGISTER_GBGAIN_V_219 = ADDR_AXIL_ISPSLAVE_BASE + 32'had0,
    ADDR_LSC_REGISTER_GBGAIN_V_220 = ADDR_AXIL_ISPSLAVE_BASE + 32'had4,
    ADDR_LSC_REGISTER_BGAIN_V_0 = ADDR_AXIL_ISPSLAVE_BASE + 32'had8,
    ADDR_LSC_REGISTER_BGAIN_V_1 = ADDR_AXIL_ISPSLAVE_BASE + 32'hadc,
    ADDR_LSC_REGISTER_BGAIN_V_2 = ADDR_AXIL_ISPSLAVE_BASE + 32'hae0,
    ADDR_LSC_REGISTER_BGAIN_V_3 = ADDR_AXIL_ISPSLAVE_BASE + 32'hae4,
    ADDR_LSC_REGISTER_BGAIN_V_4 = ADDR_AXIL_ISPSLAVE_BASE + 32'hae8,
    ADDR_LSC_REGISTER_BGAIN_V_5 = ADDR_AXIL_ISPSLAVE_BASE + 32'haec,
    ADDR_LSC_REGISTER_BGAIN_V_6 = ADDR_AXIL_ISPSLAVE_BASE + 32'haf0,
    ADDR_LSC_REGISTER_BGAIN_V_7 = ADDR_AXIL_ISPSLAVE_BASE + 32'haf4,
    ADDR_LSC_REGISTER_BGAIN_V_8 = ADDR_AXIL_ISPSLAVE_BASE + 32'haf8,
    ADDR_LSC_REGISTER_BGAIN_V_9 = ADDR_AXIL_ISPSLAVE_BASE + 32'hafc,
    ADDR_LSC_REGISTER_BGAIN_V_10 = ADDR_AXIL_ISPSLAVE_BASE + 32'hb00,
    ADDR_LSC_REGISTER_BGAIN_V_11 = ADDR_AXIL_ISPSLAVE_BASE + 32'hb04,
    ADDR_LSC_REGISTER_BGAIN_V_12 = ADDR_AXIL_ISPSLAVE_BASE + 32'hb08,
    ADDR_LSC_REGISTER_BGAIN_V_13 = ADDR_AXIL_ISPSLAVE_BASE + 32'hb0c,
    ADDR_LSC_REGISTER_BGAIN_V_14 = ADDR_AXIL_ISPSLAVE_BASE + 32'hb10,
    ADDR_LSC_REGISTER_BGAIN_V_15 = ADDR_AXIL_ISPSLAVE_BASE + 32'hb14,
    ADDR_LSC_REGISTER_BGAIN_V_16 = ADDR_AXIL_ISPSLAVE_BASE + 32'hb18,
    ADDR_LSC_REGISTER_BGAIN_V_17 = ADDR_AXIL_ISPSLAVE_BASE + 32'hb1c,
    ADDR_LSC_REGISTER_BGAIN_V_18 = ADDR_AXIL_ISPSLAVE_BASE + 32'hb20,
    ADDR_LSC_REGISTER_BGAIN_V_19 = ADDR_AXIL_ISPSLAVE_BASE + 32'hb24,
    ADDR_LSC_REGISTER_BGAIN_V_20 = ADDR_AXIL_ISPSLAVE_BASE + 32'hb28,
    ADDR_LSC_REGISTER_BGAIN_V_21 = ADDR_AXIL_ISPSLAVE_BASE + 32'hb2c,
    ADDR_LSC_REGISTER_BGAIN_V_22 = ADDR_AXIL_ISPSLAVE_BASE + 32'hb30,
    ADDR_LSC_REGISTER_BGAIN_V_23 = ADDR_AXIL_ISPSLAVE_BASE + 32'hb34,
    ADDR_LSC_REGISTER_BGAIN_V_24 = ADDR_AXIL_ISPSLAVE_BASE + 32'hb38,
    ADDR_LSC_REGISTER_BGAIN_V_25 = ADDR_AXIL_ISPSLAVE_BASE + 32'hb3c,
    ADDR_LSC_REGISTER_BGAIN_V_26 = ADDR_AXIL_ISPSLAVE_BASE + 32'hb40,
    ADDR_LSC_REGISTER_BGAIN_V_27 = ADDR_AXIL_ISPSLAVE_BASE + 32'hb44,
    ADDR_LSC_REGISTER_BGAIN_V_28 = ADDR_AXIL_ISPSLAVE_BASE + 32'hb48,
    ADDR_LSC_REGISTER_BGAIN_V_29 = ADDR_AXIL_ISPSLAVE_BASE + 32'hb4c,
    ADDR_LSC_REGISTER_BGAIN_V_30 = ADDR_AXIL_ISPSLAVE_BASE + 32'hb50,
    ADDR_LSC_REGISTER_BGAIN_V_31 = ADDR_AXIL_ISPSLAVE_BASE + 32'hb54,
    ADDR_LSC_REGISTER_BGAIN_V_32 = ADDR_AXIL_ISPSLAVE_BASE + 32'hb58,
    ADDR_LSC_REGISTER_BGAIN_V_33 = ADDR_AXIL_ISPSLAVE_BASE + 32'hb5c,
    ADDR_LSC_REGISTER_BGAIN_V_34 = ADDR_AXIL_ISPSLAVE_BASE + 32'hb60,
    ADDR_LSC_REGISTER_BGAIN_V_35 = ADDR_AXIL_ISPSLAVE_BASE + 32'hb64,
    ADDR_LSC_REGISTER_BGAIN_V_36 = ADDR_AXIL_ISPSLAVE_BASE + 32'hb68,
    ADDR_LSC_REGISTER_BGAIN_V_37 = ADDR_AXIL_ISPSLAVE_BASE + 32'hb6c,
    ADDR_LSC_REGISTER_BGAIN_V_38 = ADDR_AXIL_ISPSLAVE_BASE + 32'hb70,
    ADDR_LSC_REGISTER_BGAIN_V_39 = ADDR_AXIL_ISPSLAVE_BASE + 32'hb74,
    ADDR_LSC_REGISTER_BGAIN_V_40 = ADDR_AXIL_ISPSLAVE_BASE + 32'hb78,
    ADDR_LSC_REGISTER_BGAIN_V_41 = ADDR_AXIL_ISPSLAVE_BASE + 32'hb7c,
    ADDR_LSC_REGISTER_BGAIN_V_42 = ADDR_AXIL_ISPSLAVE_BASE + 32'hb80,
    ADDR_LSC_REGISTER_BGAIN_V_43 = ADDR_AXIL_ISPSLAVE_BASE + 32'hb84,
    ADDR_LSC_REGISTER_BGAIN_V_44 = ADDR_AXIL_ISPSLAVE_BASE + 32'hb88,
    ADDR_LSC_REGISTER_BGAIN_V_45 = ADDR_AXIL_ISPSLAVE_BASE + 32'hb8c,
    ADDR_LSC_REGISTER_BGAIN_V_46 = ADDR_AXIL_ISPSLAVE_BASE + 32'hb90,
    ADDR_LSC_REGISTER_BGAIN_V_47 = ADDR_AXIL_ISPSLAVE_BASE + 32'hb94,
    ADDR_LSC_REGISTER_BGAIN_V_48 = ADDR_AXIL_ISPSLAVE_BASE + 32'hb98,
    ADDR_LSC_REGISTER_BGAIN_V_49 = ADDR_AXIL_ISPSLAVE_BASE + 32'hb9c,
    ADDR_LSC_REGISTER_BGAIN_V_50 = ADDR_AXIL_ISPSLAVE_BASE + 32'hba0,
    ADDR_LSC_REGISTER_BGAIN_V_51 = ADDR_AXIL_ISPSLAVE_BASE + 32'hba4,
    ADDR_LSC_REGISTER_BGAIN_V_52 = ADDR_AXIL_ISPSLAVE_BASE + 32'hba8,
    ADDR_LSC_REGISTER_BGAIN_V_53 = ADDR_AXIL_ISPSLAVE_BASE + 32'hbac,
    ADDR_LSC_REGISTER_BGAIN_V_54 = ADDR_AXIL_ISPSLAVE_BASE + 32'hbb0,
    ADDR_LSC_REGISTER_BGAIN_V_55 = ADDR_AXIL_ISPSLAVE_BASE + 32'hbb4,
    ADDR_LSC_REGISTER_BGAIN_V_56 = ADDR_AXIL_ISPSLAVE_BASE + 32'hbb8,
    ADDR_LSC_REGISTER_BGAIN_V_57 = ADDR_AXIL_ISPSLAVE_BASE + 32'hbbc,
    ADDR_LSC_REGISTER_BGAIN_V_58 = ADDR_AXIL_ISPSLAVE_BASE + 32'hbc0,
    ADDR_LSC_REGISTER_BGAIN_V_59 = ADDR_AXIL_ISPSLAVE_BASE + 32'hbc4,
    ADDR_LSC_REGISTER_BGAIN_V_60 = ADDR_AXIL_ISPSLAVE_BASE + 32'hbc8,
    ADDR_LSC_REGISTER_BGAIN_V_61 = ADDR_AXIL_ISPSLAVE_BASE + 32'hbcc,
    ADDR_LSC_REGISTER_BGAIN_V_62 = ADDR_AXIL_ISPSLAVE_BASE + 32'hbd0,
    ADDR_LSC_REGISTER_BGAIN_V_63 = ADDR_AXIL_ISPSLAVE_BASE + 32'hbd4,
    ADDR_LSC_REGISTER_BGAIN_V_64 = ADDR_AXIL_ISPSLAVE_BASE + 32'hbd8,
    ADDR_LSC_REGISTER_BGAIN_V_65 = ADDR_AXIL_ISPSLAVE_BASE + 32'hbdc,
    ADDR_LSC_REGISTER_BGAIN_V_66 = ADDR_AXIL_ISPSLAVE_BASE + 32'hbe0,
    ADDR_LSC_REGISTER_BGAIN_V_67 = ADDR_AXIL_ISPSLAVE_BASE + 32'hbe4,
    ADDR_LSC_REGISTER_BGAIN_V_68 = ADDR_AXIL_ISPSLAVE_BASE + 32'hbe8,
    ADDR_LSC_REGISTER_BGAIN_V_69 = ADDR_AXIL_ISPSLAVE_BASE + 32'hbec,
    ADDR_LSC_REGISTER_BGAIN_V_70 = ADDR_AXIL_ISPSLAVE_BASE + 32'hbf0,
    ADDR_LSC_REGISTER_BGAIN_V_71 = ADDR_AXIL_ISPSLAVE_BASE + 32'hbf4,
    ADDR_LSC_REGISTER_BGAIN_V_72 = ADDR_AXIL_ISPSLAVE_BASE + 32'hbf8,
    ADDR_LSC_REGISTER_BGAIN_V_73 = ADDR_AXIL_ISPSLAVE_BASE + 32'hbfc,
    ADDR_LSC_REGISTER_BGAIN_V_74 = ADDR_AXIL_ISPSLAVE_BASE + 32'hc00,
    ADDR_LSC_REGISTER_BGAIN_V_75 = ADDR_AXIL_ISPSLAVE_BASE + 32'hc04,
    ADDR_LSC_REGISTER_BGAIN_V_76 = ADDR_AXIL_ISPSLAVE_BASE + 32'hc08,
    ADDR_LSC_REGISTER_BGAIN_V_77 = ADDR_AXIL_ISPSLAVE_BASE + 32'hc0c,
    ADDR_LSC_REGISTER_BGAIN_V_78 = ADDR_AXIL_ISPSLAVE_BASE + 32'hc10,
    ADDR_LSC_REGISTER_BGAIN_V_79 = ADDR_AXIL_ISPSLAVE_BASE + 32'hc14,
    ADDR_LSC_REGISTER_BGAIN_V_80 = ADDR_AXIL_ISPSLAVE_BASE + 32'hc18,
    ADDR_LSC_REGISTER_BGAIN_V_81 = ADDR_AXIL_ISPSLAVE_BASE + 32'hc1c,
    ADDR_LSC_REGISTER_BGAIN_V_82 = ADDR_AXIL_ISPSLAVE_BASE + 32'hc20,
    ADDR_LSC_REGISTER_BGAIN_V_83 = ADDR_AXIL_ISPSLAVE_BASE + 32'hc24,
    ADDR_LSC_REGISTER_BGAIN_V_84 = ADDR_AXIL_ISPSLAVE_BASE + 32'hc28,
    ADDR_LSC_REGISTER_BGAIN_V_85 = ADDR_AXIL_ISPSLAVE_BASE + 32'hc2c,
    ADDR_LSC_REGISTER_BGAIN_V_86 = ADDR_AXIL_ISPSLAVE_BASE + 32'hc30,
    ADDR_LSC_REGISTER_BGAIN_V_87 = ADDR_AXIL_ISPSLAVE_BASE + 32'hc34,
    ADDR_LSC_REGISTER_BGAIN_V_88 = ADDR_AXIL_ISPSLAVE_BASE + 32'hc38,
    ADDR_LSC_REGISTER_BGAIN_V_89 = ADDR_AXIL_ISPSLAVE_BASE + 32'hc3c,
    ADDR_LSC_REGISTER_BGAIN_V_90 = ADDR_AXIL_ISPSLAVE_BASE + 32'hc40,
    ADDR_LSC_REGISTER_BGAIN_V_91 = ADDR_AXIL_ISPSLAVE_BASE + 32'hc44,
    ADDR_LSC_REGISTER_BGAIN_V_92 = ADDR_AXIL_ISPSLAVE_BASE + 32'hc48,
    ADDR_LSC_REGISTER_BGAIN_V_93 = ADDR_AXIL_ISPSLAVE_BASE + 32'hc4c,
    ADDR_LSC_REGISTER_BGAIN_V_94 = ADDR_AXIL_ISPSLAVE_BASE + 32'hc50,
    ADDR_LSC_REGISTER_BGAIN_V_95 = ADDR_AXIL_ISPSLAVE_BASE + 32'hc54,
    ADDR_LSC_REGISTER_BGAIN_V_96 = ADDR_AXIL_ISPSLAVE_BASE + 32'hc58,
    ADDR_LSC_REGISTER_BGAIN_V_97 = ADDR_AXIL_ISPSLAVE_BASE + 32'hc5c,
    ADDR_LSC_REGISTER_BGAIN_V_98 = ADDR_AXIL_ISPSLAVE_BASE + 32'hc60,
    ADDR_LSC_REGISTER_BGAIN_V_99 = ADDR_AXIL_ISPSLAVE_BASE + 32'hc64,
    ADDR_LSC_REGISTER_BGAIN_V_100 = ADDR_AXIL_ISPSLAVE_BASE + 32'hc68,
    ADDR_LSC_REGISTER_BGAIN_V_101 = ADDR_AXIL_ISPSLAVE_BASE + 32'hc6c,
    ADDR_LSC_REGISTER_BGAIN_V_102 = ADDR_AXIL_ISPSLAVE_BASE + 32'hc70,
    ADDR_LSC_REGISTER_BGAIN_V_103 = ADDR_AXIL_ISPSLAVE_BASE + 32'hc74,
    ADDR_LSC_REGISTER_BGAIN_V_104 = ADDR_AXIL_ISPSLAVE_BASE + 32'hc78,
    ADDR_LSC_REGISTER_BGAIN_V_105 = ADDR_AXIL_ISPSLAVE_BASE + 32'hc7c,
    ADDR_LSC_REGISTER_BGAIN_V_106 = ADDR_AXIL_ISPSLAVE_BASE + 32'hc80,
    ADDR_LSC_REGISTER_BGAIN_V_107 = ADDR_AXIL_ISPSLAVE_BASE + 32'hc84,
    ADDR_LSC_REGISTER_BGAIN_V_108 = ADDR_AXIL_ISPSLAVE_BASE + 32'hc88,
    ADDR_LSC_REGISTER_BGAIN_V_109 = ADDR_AXIL_ISPSLAVE_BASE + 32'hc8c,
    ADDR_LSC_REGISTER_BGAIN_V_110 = ADDR_AXIL_ISPSLAVE_BASE + 32'hc90,
    ADDR_LSC_REGISTER_BGAIN_V_111 = ADDR_AXIL_ISPSLAVE_BASE + 32'hc94,
    ADDR_LSC_REGISTER_BGAIN_V_112 = ADDR_AXIL_ISPSLAVE_BASE + 32'hc98,
    ADDR_LSC_REGISTER_BGAIN_V_113 = ADDR_AXIL_ISPSLAVE_BASE + 32'hc9c,
    ADDR_LSC_REGISTER_BGAIN_V_114 = ADDR_AXIL_ISPSLAVE_BASE + 32'hca0,
    ADDR_LSC_REGISTER_BGAIN_V_115 = ADDR_AXIL_ISPSLAVE_BASE + 32'hca4,
    ADDR_LSC_REGISTER_BGAIN_V_116 = ADDR_AXIL_ISPSLAVE_BASE + 32'hca8,
    ADDR_LSC_REGISTER_BGAIN_V_117 = ADDR_AXIL_ISPSLAVE_BASE + 32'hcac,
    ADDR_LSC_REGISTER_BGAIN_V_118 = ADDR_AXIL_ISPSLAVE_BASE + 32'hcb0,
    ADDR_LSC_REGISTER_BGAIN_V_119 = ADDR_AXIL_ISPSLAVE_BASE + 32'hcb4,
    ADDR_LSC_REGISTER_BGAIN_V_120 = ADDR_AXIL_ISPSLAVE_BASE + 32'hcb8,
    ADDR_LSC_REGISTER_BGAIN_V_121 = ADDR_AXIL_ISPSLAVE_BASE + 32'hcbc,
    ADDR_LSC_REGISTER_BGAIN_V_122 = ADDR_AXIL_ISPSLAVE_BASE + 32'hcc0,
    ADDR_LSC_REGISTER_BGAIN_V_123 = ADDR_AXIL_ISPSLAVE_BASE + 32'hcc4,
    ADDR_LSC_REGISTER_BGAIN_V_124 = ADDR_AXIL_ISPSLAVE_BASE + 32'hcc8,
    ADDR_LSC_REGISTER_BGAIN_V_125 = ADDR_AXIL_ISPSLAVE_BASE + 32'hccc,
    ADDR_LSC_REGISTER_BGAIN_V_126 = ADDR_AXIL_ISPSLAVE_BASE + 32'hcd0,
    ADDR_LSC_REGISTER_BGAIN_V_127 = ADDR_AXIL_ISPSLAVE_BASE + 32'hcd4,
    ADDR_LSC_REGISTER_BGAIN_V_128 = ADDR_AXIL_ISPSLAVE_BASE + 32'hcd8,
    ADDR_LSC_REGISTER_BGAIN_V_129 = ADDR_AXIL_ISPSLAVE_BASE + 32'hcdc,
    ADDR_LSC_REGISTER_BGAIN_V_130 = ADDR_AXIL_ISPSLAVE_BASE + 32'hce0,
    ADDR_LSC_REGISTER_BGAIN_V_131 = ADDR_AXIL_ISPSLAVE_BASE + 32'hce4,
    ADDR_LSC_REGISTER_BGAIN_V_132 = ADDR_AXIL_ISPSLAVE_BASE + 32'hce8,
    ADDR_LSC_REGISTER_BGAIN_V_133 = ADDR_AXIL_ISPSLAVE_BASE + 32'hcec,
    ADDR_LSC_REGISTER_BGAIN_V_134 = ADDR_AXIL_ISPSLAVE_BASE + 32'hcf0,
    ADDR_LSC_REGISTER_BGAIN_V_135 = ADDR_AXIL_ISPSLAVE_BASE + 32'hcf4,
    ADDR_LSC_REGISTER_BGAIN_V_136 = ADDR_AXIL_ISPSLAVE_BASE + 32'hcf8,
    ADDR_LSC_REGISTER_BGAIN_V_137 = ADDR_AXIL_ISPSLAVE_BASE + 32'hcfc,
    ADDR_LSC_REGISTER_BGAIN_V_138 = ADDR_AXIL_ISPSLAVE_BASE + 32'hd00,
    ADDR_LSC_REGISTER_BGAIN_V_139 = ADDR_AXIL_ISPSLAVE_BASE + 32'hd04,
    ADDR_LSC_REGISTER_BGAIN_V_140 = ADDR_AXIL_ISPSLAVE_BASE + 32'hd08,
    ADDR_LSC_REGISTER_BGAIN_V_141 = ADDR_AXIL_ISPSLAVE_BASE + 32'hd0c,
    ADDR_LSC_REGISTER_BGAIN_V_142 = ADDR_AXIL_ISPSLAVE_BASE + 32'hd10,
    ADDR_LSC_REGISTER_BGAIN_V_143 = ADDR_AXIL_ISPSLAVE_BASE + 32'hd14,
    ADDR_LSC_REGISTER_BGAIN_V_144 = ADDR_AXIL_ISPSLAVE_BASE + 32'hd18,
    ADDR_LSC_REGISTER_BGAIN_V_145 = ADDR_AXIL_ISPSLAVE_BASE + 32'hd1c,
    ADDR_LSC_REGISTER_BGAIN_V_146 = ADDR_AXIL_ISPSLAVE_BASE + 32'hd20,
    ADDR_LSC_REGISTER_BGAIN_V_147 = ADDR_AXIL_ISPSLAVE_BASE + 32'hd24,
    ADDR_LSC_REGISTER_BGAIN_V_148 = ADDR_AXIL_ISPSLAVE_BASE + 32'hd28,
    ADDR_LSC_REGISTER_BGAIN_V_149 = ADDR_AXIL_ISPSLAVE_BASE + 32'hd2c,
    ADDR_LSC_REGISTER_BGAIN_V_150 = ADDR_AXIL_ISPSLAVE_BASE + 32'hd30,
    ADDR_LSC_REGISTER_BGAIN_V_151 = ADDR_AXIL_ISPSLAVE_BASE + 32'hd34,
    ADDR_LSC_REGISTER_BGAIN_V_152 = ADDR_AXIL_ISPSLAVE_BASE + 32'hd38,
    ADDR_LSC_REGISTER_BGAIN_V_153 = ADDR_AXIL_ISPSLAVE_BASE + 32'hd3c,
    ADDR_LSC_REGISTER_BGAIN_V_154 = ADDR_AXIL_ISPSLAVE_BASE + 32'hd40,
    ADDR_LSC_REGISTER_BGAIN_V_155 = ADDR_AXIL_ISPSLAVE_BASE + 32'hd44,
    ADDR_LSC_REGISTER_BGAIN_V_156 = ADDR_AXIL_ISPSLAVE_BASE + 32'hd48,
    ADDR_LSC_REGISTER_BGAIN_V_157 = ADDR_AXIL_ISPSLAVE_BASE + 32'hd4c,
    ADDR_LSC_REGISTER_BGAIN_V_158 = ADDR_AXIL_ISPSLAVE_BASE + 32'hd50,
    ADDR_LSC_REGISTER_BGAIN_V_159 = ADDR_AXIL_ISPSLAVE_BASE + 32'hd54,
    ADDR_LSC_REGISTER_BGAIN_V_160 = ADDR_AXIL_ISPSLAVE_BASE + 32'hd58,
    ADDR_LSC_REGISTER_BGAIN_V_161 = ADDR_AXIL_ISPSLAVE_BASE + 32'hd5c,
    ADDR_LSC_REGISTER_BGAIN_V_162 = ADDR_AXIL_ISPSLAVE_BASE + 32'hd60,
    ADDR_LSC_REGISTER_BGAIN_V_163 = ADDR_AXIL_ISPSLAVE_BASE + 32'hd64,
    ADDR_LSC_REGISTER_BGAIN_V_164 = ADDR_AXIL_ISPSLAVE_BASE + 32'hd68,
    ADDR_LSC_REGISTER_BGAIN_V_165 = ADDR_AXIL_ISPSLAVE_BASE + 32'hd6c,
    ADDR_LSC_REGISTER_BGAIN_V_166 = ADDR_AXIL_ISPSLAVE_BASE + 32'hd70,
    ADDR_LSC_REGISTER_BGAIN_V_167 = ADDR_AXIL_ISPSLAVE_BASE + 32'hd74,
    ADDR_LSC_REGISTER_BGAIN_V_168 = ADDR_AXIL_ISPSLAVE_BASE + 32'hd78,
    ADDR_LSC_REGISTER_BGAIN_V_169 = ADDR_AXIL_ISPSLAVE_BASE + 32'hd7c,
    ADDR_LSC_REGISTER_BGAIN_V_170 = ADDR_AXIL_ISPSLAVE_BASE + 32'hd80,
    ADDR_LSC_REGISTER_BGAIN_V_171 = ADDR_AXIL_ISPSLAVE_BASE + 32'hd84,
    ADDR_LSC_REGISTER_BGAIN_V_172 = ADDR_AXIL_ISPSLAVE_BASE + 32'hd88,
    ADDR_LSC_REGISTER_BGAIN_V_173 = ADDR_AXIL_ISPSLAVE_BASE + 32'hd8c,
    ADDR_LSC_REGISTER_BGAIN_V_174 = ADDR_AXIL_ISPSLAVE_BASE + 32'hd90,
    ADDR_LSC_REGISTER_BGAIN_V_175 = ADDR_AXIL_ISPSLAVE_BASE + 32'hd94,
    ADDR_LSC_REGISTER_BGAIN_V_176 = ADDR_AXIL_ISPSLAVE_BASE + 32'hd98,
    ADDR_LSC_REGISTER_BGAIN_V_177 = ADDR_AXIL_ISPSLAVE_BASE + 32'hd9c,
    ADDR_LSC_REGISTER_BGAIN_V_178 = ADDR_AXIL_ISPSLAVE_BASE + 32'hda0,
    ADDR_LSC_REGISTER_BGAIN_V_179 = ADDR_AXIL_ISPSLAVE_BASE + 32'hda4,
    ADDR_LSC_REGISTER_BGAIN_V_180 = ADDR_AXIL_ISPSLAVE_BASE + 32'hda8,
    ADDR_LSC_REGISTER_BGAIN_V_181 = ADDR_AXIL_ISPSLAVE_BASE + 32'hdac,
    ADDR_LSC_REGISTER_BGAIN_V_182 = ADDR_AXIL_ISPSLAVE_BASE + 32'hdb0,
    ADDR_LSC_REGISTER_BGAIN_V_183 = ADDR_AXIL_ISPSLAVE_BASE + 32'hdb4,
    ADDR_LSC_REGISTER_BGAIN_V_184 = ADDR_AXIL_ISPSLAVE_BASE + 32'hdb8,
    ADDR_LSC_REGISTER_BGAIN_V_185 = ADDR_AXIL_ISPSLAVE_BASE + 32'hdbc,
    ADDR_LSC_REGISTER_BGAIN_V_186 = ADDR_AXIL_ISPSLAVE_BASE + 32'hdc0,
    ADDR_LSC_REGISTER_BGAIN_V_187 = ADDR_AXIL_ISPSLAVE_BASE + 32'hdc4,
    ADDR_LSC_REGISTER_BGAIN_V_188 = ADDR_AXIL_ISPSLAVE_BASE + 32'hdc8,
    ADDR_LSC_REGISTER_BGAIN_V_189 = ADDR_AXIL_ISPSLAVE_BASE + 32'hdcc,
    ADDR_LSC_REGISTER_BGAIN_V_190 = ADDR_AXIL_ISPSLAVE_BASE + 32'hdd0,
    ADDR_LSC_REGISTER_BGAIN_V_191 = ADDR_AXIL_ISPSLAVE_BASE + 32'hdd4,
    ADDR_LSC_REGISTER_BGAIN_V_192 = ADDR_AXIL_ISPSLAVE_BASE + 32'hdd8,
    ADDR_LSC_REGISTER_BGAIN_V_193 = ADDR_AXIL_ISPSLAVE_BASE + 32'hddc,
    ADDR_LSC_REGISTER_BGAIN_V_194 = ADDR_AXIL_ISPSLAVE_BASE + 32'hde0,
    ADDR_LSC_REGISTER_BGAIN_V_195 = ADDR_AXIL_ISPSLAVE_BASE + 32'hde4,
    ADDR_LSC_REGISTER_BGAIN_V_196 = ADDR_AXIL_ISPSLAVE_BASE + 32'hde8,
    ADDR_LSC_REGISTER_BGAIN_V_197 = ADDR_AXIL_ISPSLAVE_BASE + 32'hdec,
    ADDR_LSC_REGISTER_BGAIN_V_198 = ADDR_AXIL_ISPSLAVE_BASE + 32'hdf0,
    ADDR_LSC_REGISTER_BGAIN_V_199 = ADDR_AXIL_ISPSLAVE_BASE + 32'hdf4,
    ADDR_LSC_REGISTER_BGAIN_V_200 = ADDR_AXIL_ISPSLAVE_BASE + 32'hdf8,
    ADDR_LSC_REGISTER_BGAIN_V_201 = ADDR_AXIL_ISPSLAVE_BASE + 32'hdfc,
    ADDR_LSC_REGISTER_BGAIN_V_202 = ADDR_AXIL_ISPSLAVE_BASE + 32'he00,
    ADDR_LSC_REGISTER_BGAIN_V_203 = ADDR_AXIL_ISPSLAVE_BASE + 32'he04,
    ADDR_LSC_REGISTER_BGAIN_V_204 = ADDR_AXIL_ISPSLAVE_BASE + 32'he08,
    ADDR_LSC_REGISTER_BGAIN_V_205 = ADDR_AXIL_ISPSLAVE_BASE + 32'he0c,
    ADDR_LSC_REGISTER_BGAIN_V_206 = ADDR_AXIL_ISPSLAVE_BASE + 32'he10,
    ADDR_LSC_REGISTER_BGAIN_V_207 = ADDR_AXIL_ISPSLAVE_BASE + 32'he14,
    ADDR_LSC_REGISTER_BGAIN_V_208 = ADDR_AXIL_ISPSLAVE_BASE + 32'he18,
    ADDR_LSC_REGISTER_BGAIN_V_209 = ADDR_AXIL_ISPSLAVE_BASE + 32'he1c,
    ADDR_LSC_REGISTER_BGAIN_V_210 = ADDR_AXIL_ISPSLAVE_BASE + 32'he20,
    ADDR_LSC_REGISTER_BGAIN_V_211 = ADDR_AXIL_ISPSLAVE_BASE + 32'he24,
    ADDR_LSC_REGISTER_BGAIN_V_212 = ADDR_AXIL_ISPSLAVE_BASE + 32'he28,
    ADDR_LSC_REGISTER_BGAIN_V_213 = ADDR_AXIL_ISPSLAVE_BASE + 32'he2c,
    ADDR_LSC_REGISTER_BGAIN_V_214 = ADDR_AXIL_ISPSLAVE_BASE + 32'he30,
    ADDR_LSC_REGISTER_BGAIN_V_215 = ADDR_AXIL_ISPSLAVE_BASE + 32'he34,
    ADDR_LSC_REGISTER_BGAIN_V_216 = ADDR_AXIL_ISPSLAVE_BASE + 32'he38,
    ADDR_LSC_REGISTER_BGAIN_V_217 = ADDR_AXIL_ISPSLAVE_BASE + 32'he3c,
    ADDR_LSC_REGISTER_BGAIN_V_218 = ADDR_AXIL_ISPSLAVE_BASE + 32'he40,
    ADDR_LSC_REGISTER_BGAIN_V_219 = ADDR_AXIL_ISPSLAVE_BASE + 32'he44,
    ADDR_LSC_REGISTER_BGAIN_V_220 = ADDR_AXIL_ISPSLAVE_BASE + 32'he48,
    ADDR_LSC_REGISTER_BLOCKHEIGHT_V = ADDR_AXIL_ISPSLAVE_BASE + 32'he4c,
    ADDR_LSC_REGISTER_BLOCKWIDTH_V = ADDR_AXIL_ISPSLAVE_BASE + 32'he50,
    ADDR_LSC_REGISTER_BLOCKWIDTH_1_V = ADDR_AXIL_ISPSLAVE_BASE + 32'he54,
    ADDR_LSC_REGISTER_BLOCKHEIGHT_1_V = ADDR_AXIL_ISPSLAVE_BASE + 32'he58,
    ADDR_DPC_REGISTER_EB = ADDR_AXIL_ISPSLAVE_BASE + 32'he5c,
    ADDR_DPC_REGISTER_TH_W_V = ADDR_AXIL_ISPSLAVE_BASE + 32'he60,
    ADDR_DPC_REGISTER_TH_B_V = ADDR_AXIL_ISPSLAVE_BASE + 32'he64,
    ADDR_RAWDNS_REGISTER_SIGMA_V = ADDR_AXIL_ISPSLAVE_BASE + 32'he68,
    ADDR_RAWDNS_REGISTER_EB_V = ADDR_AXIL_ISPSLAVE_BASE + 32'he6c,
    ADDR_RAWDNS_REGISTER_FILTERPARA_V = ADDR_AXIL_ISPSLAVE_BASE + 32'he70,
    ADDR_RAWDNS_REGISTER_INVKSIGMA2_V = ADDR_AXIL_ISPSLAVE_BASE + 32'he74,
    ADDR_AWB_REGISTER_M_NEB = ADDR_AXIL_ISPSLAVE_BASE + 32'he78,
    ADDR_AWB_REGISTER_R_GAIN_V = ADDR_AXIL_ISPSLAVE_BASE + 32'he7c,
    ADDR_AWB_REGISTER_G_GAIN_V = ADDR_AXIL_ISPSLAVE_BASE + 32'he80,
    ADDR_AWB_REGISTER_B_GAIN_V = ADDR_AXIL_ISPSLAVE_BASE + 32'he84,
    ADDR_AWB_REGISTER_COEFF_V = ADDR_AXIL_ISPSLAVE_BASE + 32'he88,
    ADDR_WBC_REGISTER_M_NEB = ADDR_AXIL_ISPSLAVE_BASE + 32'he8c,
    ADDR_WBC_REGISTER_M_NR_V = ADDR_AXIL_ISPSLAVE_BASE + 32'he90,
    ADDR_WBC_REGISTER_M_NGR_V = ADDR_AXIL_ISPSLAVE_BASE + 32'he94,
    ADDR_WBC_REGISTER_M_NGB_V = ADDR_AXIL_ISPSLAVE_BASE + 32'he98,
    ADDR_WBC_REGISTER_M_NB_V = ADDR_AXIL_ISPSLAVE_BASE + 32'he9c,
    ADDR_GB_REGISTER_EB = ADDR_AXIL_ISPSLAVE_BASE + 32'hea0,
    ADDR_GB_REGISTER_WIN_SIZE_V = ADDR_AXIL_ISPSLAVE_BASE + 32'hea4,
    ADDR_GB_REGISTER_LBOUND_V = ADDR_AXIL_ISPSLAVE_BASE + 32'hea8,
    ADDR_GB_REGISTER_HBOUND_V = ADDR_AXIL_ISPSLAVE_BASE + 32'heac,
    ADDR_GB_REGISTER_THREHOLD_V = ADDR_AXIL_ISPSLAVE_BASE + 32'heb0,
    ADDR_DEMOSAIC_REGISTER_EB = ADDR_AXIL_ISPSLAVE_BASE + 32'heb4,
    ADDR_EE_REGISTER_EB = ADDR_AXIL_ISPSLAVE_BASE + 32'heb8,
    ADDR_EE_REGISTER_COEFF_V = ADDR_AXIL_ISPSLAVE_BASE + 32'hebc,
    ADDR_CMC_REGISTER_M_NEB = ADDR_AXIL_ISPSLAVE_BASE + 32'hec0,
    ADDR_CMC_REGISTER_M_NGAIN_V_0 = ADDR_AXIL_ISPSLAVE_BASE + 32'hec4,
    ADDR_CMC_REGISTER_M_NGAIN_V_1 = ADDR_AXIL_ISPSLAVE_BASE + 32'hec8,
    ADDR_CMC_REGISTER_M_NGAIN_V_2 = ADDR_AXIL_ISPSLAVE_BASE + 32'hecc,
    ADDR_CMC_REGISTER_M_NGAIN_V_3 = ADDR_AXIL_ISPSLAVE_BASE + 32'hed0,
    ADDR_CMC_REGISTER_M_NGAIN_V_4 = ADDR_AXIL_ISPSLAVE_BASE + 32'hed4,
    ADDR_CMC_REGISTER_M_NGAIN_V_5 = ADDR_AXIL_ISPSLAVE_BASE + 32'hed8,
    ADDR_CMC_REGISTER_M_NGAIN_V_6 = ADDR_AXIL_ISPSLAVE_BASE + 32'hedc,
    ADDR_CMC_REGISTER_M_NGAIN_V_7 = ADDR_AXIL_ISPSLAVE_BASE + 32'hee0,
    ADDR_CMC_REGISTER_M_NGAIN_V_8 = ADDR_AXIL_ISPSLAVE_BASE + 32'hee4,
    ADDR_CMC_REGISTER_M_NGAIN_V_9 = ADDR_AXIL_ISPSLAVE_BASE + 32'hee8,
    ADDR_CMC_REGISTER_M_NGAIN_V_10 = ADDR_AXIL_ISPSLAVE_BASE + 32'heec,
    ADDR_CMC_REGISTER_M_NGAIN_V_11 = ADDR_AXIL_ISPSLAVE_BASE + 32'hef0,
    ADDR_CMC_REGISTER_M_BCFCENABLE = ADDR_AXIL_ISPSLAVE_BASE + 32'hef4,
    ADDR_CMC_REGISTER_M_BDISCARDH = ADDR_AXIL_ISPSLAVE_BASE + 32'hef8,
    ADDR_CMC_REGISTER_M_PHUERANGE_V_0 = ADDR_AXIL_ISPSLAVE_BASE + 32'hefc,
    ADDR_CMC_REGISTER_M_PHUERANGE_V_1 = ADDR_AXIL_ISPSLAVE_BASE + 32'hf00,
    ADDR_CMC_REGISTER_M_NHUEBANDSHIFT_V = ADDR_AXIL_ISPSLAVE_BASE + 32'hf04,
    ADDR_CMC_REGISTER_M_NEDGETHRE_V = ADDR_AXIL_ISPSLAVE_BASE + 32'hf08,
    ADDR_CMC_REGISTER_M_NEDGEBANDSHIFT_V = ADDR_AXIL_ISPSLAVE_BASE + 32'hf0c,
    ADDR_CMC_REGISTER_M_NCFCSTRENGTH_V = ADDR_AXIL_ISPSLAVE_BASE + 32'hf10,
    ADDR_GTM_REGISTER_EB = ADDR_AXIL_ISPSLAVE_BASE + 32'hf14,
    ADDR_GTM_REGISTER_M_BDITHERINGENABLE = ADDR_AXIL_ISPSLAVE_BASE + 32'hf18,
    ADDR_GTM_REGISTER_GTMTAB_V_0 = ADDR_AXIL_ISPSLAVE_BASE + 32'hf1c,
    ADDR_GTM_REGISTER_GTMTAB_V_1 = ADDR_AXIL_ISPSLAVE_BASE + 32'hf20,
    ADDR_GTM_REGISTER_GTMTAB_V_2 = ADDR_AXIL_ISPSLAVE_BASE + 32'hf24,
    ADDR_GTM_REGISTER_GTMTAB_V_3 = ADDR_AXIL_ISPSLAVE_BASE + 32'hf28,
    ADDR_GTM_REGISTER_GTMTAB_V_4 = ADDR_AXIL_ISPSLAVE_BASE + 32'hf2c,
    ADDR_GTM_REGISTER_GTMTAB_V_5 = ADDR_AXIL_ISPSLAVE_BASE + 32'hf30,
    ADDR_GTM_REGISTER_GTMTAB_V_6 = ADDR_AXIL_ISPSLAVE_BASE + 32'hf34,
    ADDR_GTM_REGISTER_GTMTAB_V_7 = ADDR_AXIL_ISPSLAVE_BASE + 32'hf38,
    ADDR_GTM_REGISTER_GTMTAB_V_8 = ADDR_AXIL_ISPSLAVE_BASE + 32'hf3c,
    ADDR_GTM_REGISTER_GTMTAB_V_9 = ADDR_AXIL_ISPSLAVE_BASE + 32'hf40,
    ADDR_GTM_REGISTER_GTMTAB_V_10 = ADDR_AXIL_ISPSLAVE_BASE + 32'hf44,
    ADDR_GTM_REGISTER_GTMTAB_V_11 = ADDR_AXIL_ISPSLAVE_BASE + 32'hf48,
    ADDR_GTM_REGISTER_GTMTAB_V_12 = ADDR_AXIL_ISPSLAVE_BASE + 32'hf4c,
    ADDR_GTM_REGISTER_GTMTAB_V_13 = ADDR_AXIL_ISPSLAVE_BASE + 32'hf50,
    ADDR_GTM_REGISTER_GTMTAB_V_14 = ADDR_AXIL_ISPSLAVE_BASE + 32'hf54,
    ADDR_GTM_REGISTER_GTMTAB_V_15 = ADDR_AXIL_ISPSLAVE_BASE + 32'hf58,
    ADDR_GTM_REGISTER_GTMTAB_V_16 = ADDR_AXIL_ISPSLAVE_BASE + 32'hf5c,
    ADDR_GTM_REGISTER_GTMTAB_V_17 = ADDR_AXIL_ISPSLAVE_BASE + 32'hf60,
    ADDR_GTM_REGISTER_GTMTAB_V_18 = ADDR_AXIL_ISPSLAVE_BASE + 32'hf64,
    ADDR_GTM_REGISTER_GTMTAB_V_19 = ADDR_AXIL_ISPSLAVE_BASE + 32'hf68,
    ADDR_GTM_REGISTER_GTMTAB_V_20 = ADDR_AXIL_ISPSLAVE_BASE + 32'hf6c,
    ADDR_GTM_REGISTER_GTMTAB_V_21 = ADDR_AXIL_ISPSLAVE_BASE + 32'hf70,
    ADDR_GTM_REGISTER_GTMTAB_V_22 = ADDR_AXIL_ISPSLAVE_BASE + 32'hf74,
    ADDR_GTM_REGISTER_GTMTAB_V_23 = ADDR_AXIL_ISPSLAVE_BASE + 32'hf78,
    ADDR_GTM_REGISTER_GTMTAB_V_24 = ADDR_AXIL_ISPSLAVE_BASE + 32'hf7c,
    ADDR_GTM_REGISTER_GTMTAB_V_25 = ADDR_AXIL_ISPSLAVE_BASE + 32'hf80,
    ADDR_GTM_REGISTER_GTMTAB_V_26 = ADDR_AXIL_ISPSLAVE_BASE + 32'hf84,
    ADDR_GTM_REGISTER_GTMTAB_V_27 = ADDR_AXIL_ISPSLAVE_BASE + 32'hf88,
    ADDR_GTM_REGISTER_GTMTAB_V_28 = ADDR_AXIL_ISPSLAVE_BASE + 32'hf8c,
    ADDR_GTM_REGISTER_GTMTAB_V_29 = ADDR_AXIL_ISPSLAVE_BASE + 32'hf90,
    ADDR_GTM_REGISTER_GTMTAB_V_30 = ADDR_AXIL_ISPSLAVE_BASE + 32'hf94,
    ADDR_GTM_REGISTER_GTMTAB_V_31 = ADDR_AXIL_ISPSLAVE_BASE + 32'hf98,
    ADDR_GTM_REGISTER_GTMTAB_V_32 = ADDR_AXIL_ISPSLAVE_BASE + 32'hf9c,
    ADDR_GTM_REGISTER_GTMTAB_V_33 = ADDR_AXIL_ISPSLAVE_BASE + 32'hfa0,
    ADDR_GTM_REGISTER_GTMTAB_V_34 = ADDR_AXIL_ISPSLAVE_BASE + 32'hfa4,
    ADDR_GTM_REGISTER_GTMTAB_V_35 = ADDR_AXIL_ISPSLAVE_BASE + 32'hfa8,
    ADDR_GTM_REGISTER_GTMTAB_V_36 = ADDR_AXIL_ISPSLAVE_BASE + 32'hfac,
    ADDR_GTM_REGISTER_GTMTAB_V_37 = ADDR_AXIL_ISPSLAVE_BASE + 32'hfb0,
    ADDR_GTM_REGISTER_GTMTAB_V_38 = ADDR_AXIL_ISPSLAVE_BASE + 32'hfb4,
    ADDR_GTM_REGISTER_GTMTAB_V_39 = ADDR_AXIL_ISPSLAVE_BASE + 32'hfb8,
    ADDR_GTM_REGISTER_GTMTAB_V_40 = ADDR_AXIL_ISPSLAVE_BASE + 32'hfbc,
    ADDR_GTM_REGISTER_GTMTAB_V_41 = ADDR_AXIL_ISPSLAVE_BASE + 32'hfc0,
    ADDR_GTM_REGISTER_GTMTAB_V_42 = ADDR_AXIL_ISPSLAVE_BASE + 32'hfc4,
    ADDR_GTM_REGISTER_GTMTAB_V_43 = ADDR_AXIL_ISPSLAVE_BASE + 32'hfc8,
    ADDR_GTM_REGISTER_GTMTAB_V_44 = ADDR_AXIL_ISPSLAVE_BASE + 32'hfcc,
    ADDR_GTM_REGISTER_GTMTAB_V_45 = ADDR_AXIL_ISPSLAVE_BASE + 32'hfd0,
    ADDR_GTM_REGISTER_GTMTAB_V_46 = ADDR_AXIL_ISPSLAVE_BASE + 32'hfd4,
    ADDR_GTM_REGISTER_GTMTAB_V_47 = ADDR_AXIL_ISPSLAVE_BASE + 32'hfd8,
    ADDR_GTM_REGISTER_GTMTAB_V_48 = ADDR_AXIL_ISPSLAVE_BASE + 32'hfdc,
    ADDR_GTM_REGISTER_GTMTAB_V_49 = ADDR_AXIL_ISPSLAVE_BASE + 32'hfe0,
    ADDR_GTM_REGISTER_GTMTAB_V_50 = ADDR_AXIL_ISPSLAVE_BASE + 32'hfe4,
    ADDR_GTM_REGISTER_GTMTAB_V_51 = ADDR_AXIL_ISPSLAVE_BASE + 32'hfe8,
    ADDR_GTM_REGISTER_GTMTAB_V_52 = ADDR_AXIL_ISPSLAVE_BASE + 32'hfec,
    ADDR_GTM_REGISTER_GTMTAB_V_53 = ADDR_AXIL_ISPSLAVE_BASE + 32'hff0,
    ADDR_GTM_REGISTER_GTMTAB_V_54 = ADDR_AXIL_ISPSLAVE_BASE + 32'hff4,
    ADDR_GTM_REGISTER_GTMTAB_V_55 = ADDR_AXIL_ISPSLAVE_BASE + 32'hff8,
    ADDR_GTM_REGISTER_GTMTAB_V_56 = ADDR_AXIL_ISPSLAVE_BASE + 32'hffc,
    ADDR_GTM_REGISTER_GTMTAB_V_57 = ADDR_AXIL_ISPSLAVE_BASE + 32'h1000,
    ADDR_GTM_REGISTER_GTMTAB_V_58 = ADDR_AXIL_ISPSLAVE_BASE + 32'h1004,
    ADDR_GTM_REGISTER_GTMTAB_V_59 = ADDR_AXIL_ISPSLAVE_BASE + 32'h1008,
    ADDR_GTM_REGISTER_GTMTAB_V_60 = ADDR_AXIL_ISPSLAVE_BASE + 32'h100c,
    ADDR_GTM_REGISTER_GTMTAB_V_61 = ADDR_AXIL_ISPSLAVE_BASE + 32'h1010,
    ADDR_GTM_REGISTER_GTMTAB_V_62 = ADDR_AXIL_ISPSLAVE_BASE + 32'h1014,
    ADDR_GTM_REGISTER_GTMTAB_V_63 = ADDR_AXIL_ISPSLAVE_BASE + 32'h1018,
    ADDR_GTM_REGISTER_GTMTAB_V_64 = ADDR_AXIL_ISPSLAVE_BASE + 32'h101c,
    ADDR_GTM_REGISTER_GTMTAB_V_65 = ADDR_AXIL_ISPSLAVE_BASE + 32'h1020,
    ADDR_GTM_REGISTER_GTMTAB_V_66 = ADDR_AXIL_ISPSLAVE_BASE + 32'h1024,
    ADDR_GTM_REGISTER_GTMTAB_V_67 = ADDR_AXIL_ISPSLAVE_BASE + 32'h1028,
    ADDR_GTM_REGISTER_GTMTAB_V_68 = ADDR_AXIL_ISPSLAVE_BASE + 32'h102c,
    ADDR_GTM_REGISTER_GTMTAB_V_69 = ADDR_AXIL_ISPSLAVE_BASE + 32'h1030,
    ADDR_GTM_REGISTER_GTMTAB_V_70 = ADDR_AXIL_ISPSLAVE_BASE + 32'h1034,
    ADDR_GTM_REGISTER_GTMTAB_V_71 = ADDR_AXIL_ISPSLAVE_BASE + 32'h1038,
    ADDR_GTM_REGISTER_GTMTAB_V_72 = ADDR_AXIL_ISPSLAVE_BASE + 32'h103c,
    ADDR_GTM_REGISTER_GTMTAB_V_73 = ADDR_AXIL_ISPSLAVE_BASE + 32'h1040,
    ADDR_GTM_REGISTER_GTMTAB_V_74 = ADDR_AXIL_ISPSLAVE_BASE + 32'h1044,
    ADDR_GTM_REGISTER_GTMTAB_V_75 = ADDR_AXIL_ISPSLAVE_BASE + 32'h1048,
    ADDR_GTM_REGISTER_GTMTAB_V_76 = ADDR_AXIL_ISPSLAVE_BASE + 32'h104c,
    ADDR_GTM_REGISTER_GTMTAB_V_77 = ADDR_AXIL_ISPSLAVE_BASE + 32'h1050,
    ADDR_GTM_REGISTER_GTMTAB_V_78 = ADDR_AXIL_ISPSLAVE_BASE + 32'h1054,
    ADDR_GTM_REGISTER_GTMTAB_V_79 = ADDR_AXIL_ISPSLAVE_BASE + 32'h1058,
    ADDR_GTM_REGISTER_GTMTAB_V_80 = ADDR_AXIL_ISPSLAVE_BASE + 32'h105c,
    ADDR_GTM_REGISTER_GTMTAB_V_81 = ADDR_AXIL_ISPSLAVE_BASE + 32'h1060,
    ADDR_GTM_REGISTER_GTMTAB_V_82 = ADDR_AXIL_ISPSLAVE_BASE + 32'h1064,
    ADDR_GTM_REGISTER_GTMTAB_V_83 = ADDR_AXIL_ISPSLAVE_BASE + 32'h1068,
    ADDR_GTM_REGISTER_GTMTAB_V_84 = ADDR_AXIL_ISPSLAVE_BASE + 32'h106c,
    ADDR_GTM_REGISTER_GTMTAB_V_85 = ADDR_AXIL_ISPSLAVE_BASE + 32'h1070,
    ADDR_GTM_REGISTER_GTMTAB_V_86 = ADDR_AXIL_ISPSLAVE_BASE + 32'h1074,
    ADDR_GTM_REGISTER_GTMTAB_V_87 = ADDR_AXIL_ISPSLAVE_BASE + 32'h1078,
    ADDR_GTM_REGISTER_GTMTAB_V_88 = ADDR_AXIL_ISPSLAVE_BASE + 32'h107c,
    ADDR_GTM_REGISTER_GTMTAB_V_89 = ADDR_AXIL_ISPSLAVE_BASE + 32'h1080,
    ADDR_GTM_REGISTER_GTMTAB_V_90 = ADDR_AXIL_ISPSLAVE_BASE + 32'h1084,
    ADDR_GTM_REGISTER_GTMTAB_V_91 = ADDR_AXIL_ISPSLAVE_BASE + 32'h1088,
    ADDR_GTM_REGISTER_GTMTAB_V_92 = ADDR_AXIL_ISPSLAVE_BASE + 32'h108c,
    ADDR_GTM_REGISTER_GTMTAB_V_93 = ADDR_AXIL_ISPSLAVE_BASE + 32'h1090,
    ADDR_GTM_REGISTER_GTMTAB_V_94 = ADDR_AXIL_ISPSLAVE_BASE + 32'h1094,
    ADDR_GTM_REGISTER_GTMTAB_V_95 = ADDR_AXIL_ISPSLAVE_BASE + 32'h1098,
    ADDR_GTM_REGISTER_GTMTAB_V_96 = ADDR_AXIL_ISPSLAVE_BASE + 32'h109c,
    ADDR_GTM_REGISTER_GTMTAB_V_97 = ADDR_AXIL_ISPSLAVE_BASE + 32'h10a0,
    ADDR_GTM_REGISTER_GTMTAB_V_98 = ADDR_AXIL_ISPSLAVE_BASE + 32'h10a4,
    ADDR_GTM_REGISTER_GTMTAB_V_99 = ADDR_AXIL_ISPSLAVE_BASE + 32'h10a8,
    ADDR_GTM_REGISTER_GTMTAB_V_100 = ADDR_AXIL_ISPSLAVE_BASE + 32'h10ac,
    ADDR_GTM_REGISTER_GTMTAB_V_101 = ADDR_AXIL_ISPSLAVE_BASE + 32'h10b0,
    ADDR_GTM_REGISTER_GTMTAB_V_102 = ADDR_AXIL_ISPSLAVE_BASE + 32'h10b4,
    ADDR_GTM_REGISTER_GTMTAB_V_103 = ADDR_AXIL_ISPSLAVE_BASE + 32'h10b8,
    ADDR_GTM_REGISTER_GTMTAB_V_104 = ADDR_AXIL_ISPSLAVE_BASE + 32'h10bc,
    ADDR_GTM_REGISTER_GTMTAB_V_105 = ADDR_AXIL_ISPSLAVE_BASE + 32'h10c0,
    ADDR_GTM_REGISTER_GTMTAB_V_106 = ADDR_AXIL_ISPSLAVE_BASE + 32'h10c4,
    ADDR_GTM_REGISTER_GTMTAB_V_107 = ADDR_AXIL_ISPSLAVE_BASE + 32'h10c8,
    ADDR_GTM_REGISTER_GTMTAB_V_108 = ADDR_AXIL_ISPSLAVE_BASE + 32'h10cc,
    ADDR_GTM_REGISTER_GTMTAB_V_109 = ADDR_AXIL_ISPSLAVE_BASE + 32'h10d0,
    ADDR_GTM_REGISTER_GTMTAB_V_110 = ADDR_AXIL_ISPSLAVE_BASE + 32'h10d4,
    ADDR_GTM_REGISTER_GTMTAB_V_111 = ADDR_AXIL_ISPSLAVE_BASE + 32'h10d8,
    ADDR_GTM_REGISTER_GTMTAB_V_112 = ADDR_AXIL_ISPSLAVE_BASE + 32'h10dc,
    ADDR_GTM_REGISTER_GTMTAB_V_113 = ADDR_AXIL_ISPSLAVE_BASE + 32'h10e0,
    ADDR_GTM_REGISTER_GTMTAB_V_114 = ADDR_AXIL_ISPSLAVE_BASE + 32'h10e4,
    ADDR_GTM_REGISTER_GTMTAB_V_115 = ADDR_AXIL_ISPSLAVE_BASE + 32'h10e8,
    ADDR_GTM_REGISTER_GTMTAB_V_116 = ADDR_AXIL_ISPSLAVE_BASE + 32'h10ec,
    ADDR_GTM_REGISTER_GTMTAB_V_117 = ADDR_AXIL_ISPSLAVE_BASE + 32'h10f0,
    ADDR_GTM_REGISTER_GTMTAB_V_118 = ADDR_AXIL_ISPSLAVE_BASE + 32'h10f4,
    ADDR_GTM_REGISTER_GTMTAB_V_119 = ADDR_AXIL_ISPSLAVE_BASE + 32'h10f8,
    ADDR_GTM_REGISTER_GTMTAB_V_120 = ADDR_AXIL_ISPSLAVE_BASE + 32'h10fc,
    ADDR_GTM_REGISTER_GTMTAB_V_121 = ADDR_AXIL_ISPSLAVE_BASE + 32'h1100,
    ADDR_GTM_REGISTER_GTMTAB_V_122 = ADDR_AXIL_ISPSLAVE_BASE + 32'h1104,
    ADDR_GTM_REGISTER_GTMTAB_V_123 = ADDR_AXIL_ISPSLAVE_BASE + 32'h1108,
    ADDR_GTM_REGISTER_GTMTAB_V_124 = ADDR_AXIL_ISPSLAVE_BASE + 32'h110c,
    ADDR_GTM_REGISTER_GTMTAB_V_125 = ADDR_AXIL_ISPSLAVE_BASE + 32'h1110,
    ADDR_GTM_REGISTER_GTMTAB_V_126 = ADDR_AXIL_ISPSLAVE_BASE + 32'h1114,
    ADDR_GTM_REGISTER_GTMTAB_V_127 = ADDR_AXIL_ISPSLAVE_BASE + 32'h1118,
    ADDR_GTM_REGISTER_GTMTAB_V_128 = ADDR_AXIL_ISPSLAVE_BASE + 32'h111c,
    ADDR_LTM_REGISTER_M_NEB_V = ADDR_AXIL_ISPSLAVE_BASE + 32'h1120,
    ADDR_LTM_REGISTER_CONTRAST_V = ADDR_AXIL_ISPSLAVE_BASE + 32'h1124,
    ADDR_LTM_REGISTER_RATIO_V = ADDR_AXIL_ISPSLAVE_BASE + 32'h1128,
    ADDR_CAC_REGISTER_EB = ADDR_AXIL_ISPSLAVE_BASE + 32'h112c,
    ADDR_CAC_REGISTER_T_TRANSIENT_V = ADDR_AXIL_ISPSLAVE_BASE + 32'h1130,
    ADDR_CAC_REGISTER_T_EDGE_V = ADDR_AXIL_ISPSLAVE_BASE + 32'h1134,
    ADDR_CSC_REGISTER_M_NEB = ADDR_AXIL_ISPSLAVE_BASE + 32'h1138,
    ADDR_CSC_REGISTER_COEFF_V_0 = ADDR_AXIL_ISPSLAVE_BASE + 32'h113c,
    ADDR_CSC_REGISTER_COEFF_V_1 = ADDR_AXIL_ISPSLAVE_BASE + 32'h1140,
    ADDR_CSC_REGISTER_COEFF_V_2 = ADDR_AXIL_ISPSLAVE_BASE + 32'h1144,
    ADDR_CSC_REGISTER_COEFF_V_3 = ADDR_AXIL_ISPSLAVE_BASE + 32'h1148,
    ADDR_CSC_REGISTER_COEFF_V_4 = ADDR_AXIL_ISPSLAVE_BASE + 32'h114c,
    ADDR_CSC_REGISTER_COEFF_V_5 = ADDR_AXIL_ISPSLAVE_BASE + 32'h1150,
    ADDR_CSC_REGISTER_COEFF_V_6 = ADDR_AXIL_ISPSLAVE_BASE + 32'h1154,
    ADDR_CSC_REGISTER_COEFF_V_7 = ADDR_AXIL_ISPSLAVE_BASE + 32'h1158,
    ADDR_CSC_REGISTER_COEFF_V_8 = ADDR_AXIL_ISPSLAVE_BASE + 32'h115c,
    ADDR_CSC_REGISTER_COEFF_V_9 = ADDR_AXIL_ISPSLAVE_BASE + 32'h1160,
    ADDR_CSC_REGISTER_COEFF_V_10 = ADDR_AXIL_ISPSLAVE_BASE + 32'h1164,
    ADDR_CSC_REGISTER_COEFF_V_11 = ADDR_AXIL_ISPSLAVE_BASE + 32'h1168,
    ADDR_YFC_REGISTER_M_NEB = ADDR_AXIL_ISPSLAVE_BASE + 32'h116c,
    ADDR_YFC_REGISTER_YUVPATTERN = ADDR_AXIL_ISPSLAVE_BASE + 32'h1170,
    ADDR_YUVDNS_REGISTER_EB_V = ADDR_AXIL_ISPSLAVE_BASE + 32'h1174,
    ADDR_YUVDNS_REGISTER_YSIGMA2_V = ADDR_AXIL_ISPSLAVE_BASE + 32'h1178,
    ADDR_YUVDNS_REGISTER_YINVSIGMA2_V = ADDR_AXIL_ISPSLAVE_BASE + 32'h117c,
    ADDR_YUVDNS_REGISTER_UVSIGMA2_V = ADDR_AXIL_ISPSLAVE_BASE + 32'h1180,
    ADDR_YUVDNS_REGISTER_UVINVSIGMA2_V = ADDR_AXIL_ISPSLAVE_BASE + 32'h1184,
    ADDR_YUVDNS_REGISTER_YFILT_V = ADDR_AXIL_ISPSLAVE_BASE + 32'h1188,
    ADDR_YUVDNS_REGISTER_UVFILT_V = ADDR_AXIL_ISPSLAVE_BASE + 32'h118c,
    ADDR_YUVDNS_REGISTER_YINVFILT_V = ADDR_AXIL_ISPSLAVE_BASE + 32'h1190,
    ADDR_YUVDNS_REGISTER_UVINVFILT_V = ADDR_AXIL_ISPSLAVE_BASE + 32'h1194,
    ADDR_YUVDNS_REGISTER_YH2_V = ADDR_AXIL_ISPSLAVE_BASE + 32'h1198,
    ADDR_YUVDNS_REGISTER_YINVH2_V = ADDR_AXIL_ISPSLAVE_BASE + 32'h119c,
    ADDR_YUVDNS_REGISTER_UVH2_V = ADDR_AXIL_ISPSLAVE_BASE + 32'h11a0,
    ADDR_YUVDNS_REGISTER_UVINVH2_V = ADDR_AXIL_ISPSLAVE_BASE + 32'h11a4,
    ADDR_SCALEDOWN_REGISTER_M_NEB = ADDR_AXIL_ISPSLAVE_BASE + 32'h11a8,
    ADDR_SCALEDOWN_REGISTER_YUVPATTERN_V = ADDR_AXIL_ISPSLAVE_BASE + 32'h11ac,
    ADDR_SCALEDOWN_REGISTER_TIMES_V = ADDR_AXIL_ISPSLAVE_BASE + 32'h11b0,
    ADDR_CROP_REGISTER_M_NEB = ADDR_AXIL_ISPSLAVE_BASE + 32'h11b4,
    ADDR_CROP_REGISTER_UPPER_LEFT_X_V = ADDR_AXIL_ISPSLAVE_BASE + 32'h11b8,
    ADDR_CROP_REGISTER_UPPER_LEFT_Y_V = ADDR_AXIL_ISPSLAVE_BASE + 32'h11bc,
    ADDR_CROP_REGISTER_LOWER_RIGHT_X_V = ADDR_AXIL_ISPSLAVE_BASE + 32'h11c0,
    ADDR_CROP_REGISTER_LOWER_RIGHT_Y_V = ADDR_AXIL_ISPSLAVE_BASE + 32'h11c4,
    ADDR_CROP_REGISTER_YUVPATTERN_V = ADDR_AXIL_ISPSLAVE_BASE + 32'h11c8,
    
    ADDR_ISP_READ_RAW_ADDR = ADDR_AXIL_ISPSLAVE_BASE + 32'h11cc,
    ADDR_ISP_WRITE_Y_ADDR = ADDR_AXIL_ISPSLAVE_BASE + 32'h11d0,
    ADDR_ISP_WRITE_U_ADDR = ADDR_AXIL_ISPSLAVE_BASE + 32'h11d4,
    ADDR_ISP_WRITE_V_ADDR = ADDR_AXIL_ISPSLAVE_BASE + 32'h11d8,
    ADDR_BURST_ONE_FRAME_TOTAL = ADDR_AXIL_ISPSLAVE_BASE + 32'h11e0;


//------------------------Local signal-------------------
    reg  [1:0]                    wstate = WRRESET;
    reg  [1:0]                    wnext;
    reg  [ADDR_BITS-1:0]          waddr;
    wire [31:0]                   wmask;
    wire                          aw_hs;
    wire                          w_hs;
    reg  [1:0]                    rstate = RDRESET;
    reg  [1:0]                    rnext;
    reg  [31:0]                   rdata;
    wire                          ar_hs;
    wire [ADDR_BITS-1:0]          raddr;
    // internal registers
   


   /*************internal ISP registers**************/
    reg  [12:0] int_top_register_frameWidth_V;
    reg  [12:0] int_top_register_frameHeight_V;
    reg  [0:0] int_top_register_inputFormat;
    reg  [1:0] int_top_register_imgPattern_V;
    reg  [1:0] int_top_register_pipeMode_V;
    reg  [8:0] int_top_register_blc_V;
    reg  [0:0] int_top_register_shadowEb;
    reg  [12:0] int_top_register_binningFrameWidth_V;
    reg  [12:0] int_top_register_binningFrameHeight_V;
    reg  [12:0] int_top_register_scalerFrameWidth_V;
    reg  [12:0] int_top_register_scalerFrameHeight_V;
    reg  [0:0] int_tpg_register_m_bTPG_en;
    reg  [12:0] int_tpg_register_m_nWidth_V;
    reg  [12:0] int_tpg_register_m_nHeight_V;
    reg  [1:0] int_tpg_register_m_nCFAPattern_V;
    reg  [0:0] int_tpg_register_m_bRollingEnable;
    reg  [0:0] int_tpg_register_m_bSensor_timing_en;
    reg  [11:0] int_tpg_register_m_nVBlank_num_V;
    reg  [11:0] int_tpg_register_m_nHBlank_num_V;
    reg  [7:0] int_tpg_register_m_valid_blank_V;
    reg  [2:0] int_tpg_register_m_nID_V;
    reg  [0:0] int_dgain_register_m_nEb;
    reg  [8:0] int_dgain_register_m_nBlcR_V;
    reg  [8:0] int_dgain_register_m_nBlcGr_V;
    reg  [8:0] int_dgain_register_m_nBlcGb_V;
    reg  [8:0] int_dgain_register_m_nBlcB_V;
    reg  [19:0] int_dgain_register_m_nR_V;
    reg  [19:0] int_dgain_register_m_nGr_V;
    reg  [19:0] int_dgain_register_m_nGb_V;
    reg  [19:0] int_dgain_register_m_nB_V;
    reg  [0:0] int_lsc_register_eb;
    reg  [12:0] int_lsc_register_rGain_V_0;
    reg  [12:0] int_lsc_register_rGain_V_1;
    reg  [12:0] int_lsc_register_rGain_V_2;
    reg  [12:0] int_lsc_register_rGain_V_3;
    reg  [12:0] int_lsc_register_rGain_V_4;
    reg  [12:0] int_lsc_register_rGain_V_5;
    reg  [12:0] int_lsc_register_rGain_V_6;
    reg  [12:0] int_lsc_register_rGain_V_7;
    reg  [12:0] int_lsc_register_rGain_V_8;
    reg  [12:0] int_lsc_register_rGain_V_9;
    reg  [12:0] int_lsc_register_rGain_V_10;
    reg  [12:0] int_lsc_register_rGain_V_11;
    reg  [12:0] int_lsc_register_rGain_V_12;
    reg  [12:0] int_lsc_register_rGain_V_13;
    reg  [12:0] int_lsc_register_rGain_V_14;
    reg  [12:0] int_lsc_register_rGain_V_15;
    reg  [12:0] int_lsc_register_rGain_V_16;
    reg  [12:0] int_lsc_register_rGain_V_17;
    reg  [12:0] int_lsc_register_rGain_V_18;
    reg  [12:0] int_lsc_register_rGain_V_19;
    reg  [12:0] int_lsc_register_rGain_V_20;
    reg  [12:0] int_lsc_register_rGain_V_21;
    reg  [12:0] int_lsc_register_rGain_V_22;
    reg  [12:0] int_lsc_register_rGain_V_23;
    reg  [12:0] int_lsc_register_rGain_V_24;
    reg  [12:0] int_lsc_register_rGain_V_25;
    reg  [12:0] int_lsc_register_rGain_V_26;
    reg  [12:0] int_lsc_register_rGain_V_27;
    reg  [12:0] int_lsc_register_rGain_V_28;
    reg  [12:0] int_lsc_register_rGain_V_29;
    reg  [12:0] int_lsc_register_rGain_V_30;
    reg  [12:0] int_lsc_register_rGain_V_31;
    reg  [12:0] int_lsc_register_rGain_V_32;
    reg  [12:0] int_lsc_register_rGain_V_33;
    reg  [12:0] int_lsc_register_rGain_V_34;
    reg  [12:0] int_lsc_register_rGain_V_35;
    reg  [12:0] int_lsc_register_rGain_V_36;
    reg  [12:0] int_lsc_register_rGain_V_37;
    reg  [12:0] int_lsc_register_rGain_V_38;
    reg  [12:0] int_lsc_register_rGain_V_39;
    reg  [12:0] int_lsc_register_rGain_V_40;
    reg  [12:0] int_lsc_register_rGain_V_41;
    reg  [12:0] int_lsc_register_rGain_V_42;
    reg  [12:0] int_lsc_register_rGain_V_43;
    reg  [12:0] int_lsc_register_rGain_V_44;
    reg  [12:0] int_lsc_register_rGain_V_45;
    reg  [12:0] int_lsc_register_rGain_V_46;
    reg  [12:0] int_lsc_register_rGain_V_47;
    reg  [12:0] int_lsc_register_rGain_V_48;
    reg  [12:0] int_lsc_register_rGain_V_49;
    reg  [12:0] int_lsc_register_rGain_V_50;
    reg  [12:0] int_lsc_register_rGain_V_51;
    reg  [12:0] int_lsc_register_rGain_V_52;
    reg  [12:0] int_lsc_register_rGain_V_53;
    reg  [12:0] int_lsc_register_rGain_V_54;
    reg  [12:0] int_lsc_register_rGain_V_55;
    reg  [12:0] int_lsc_register_rGain_V_56;
    reg  [12:0] int_lsc_register_rGain_V_57;
    reg  [12:0] int_lsc_register_rGain_V_58;
    reg  [12:0] int_lsc_register_rGain_V_59;
    reg  [12:0] int_lsc_register_rGain_V_60;
    reg  [12:0] int_lsc_register_rGain_V_61;
    reg  [12:0] int_lsc_register_rGain_V_62;
    reg  [12:0] int_lsc_register_rGain_V_63;
    reg  [12:0] int_lsc_register_rGain_V_64;
    reg  [12:0] int_lsc_register_rGain_V_65;
    reg  [12:0] int_lsc_register_rGain_V_66;
    reg  [12:0] int_lsc_register_rGain_V_67;
    reg  [12:0] int_lsc_register_rGain_V_68;
    reg  [12:0] int_lsc_register_rGain_V_69;
    reg  [12:0] int_lsc_register_rGain_V_70;
    reg  [12:0] int_lsc_register_rGain_V_71;
    reg  [12:0] int_lsc_register_rGain_V_72;
    reg  [12:0] int_lsc_register_rGain_V_73;
    reg  [12:0] int_lsc_register_rGain_V_74;
    reg  [12:0] int_lsc_register_rGain_V_75;
    reg  [12:0] int_lsc_register_rGain_V_76;
    reg  [12:0] int_lsc_register_rGain_V_77;
    reg  [12:0] int_lsc_register_rGain_V_78;
    reg  [12:0] int_lsc_register_rGain_V_79;
    reg  [12:0] int_lsc_register_rGain_V_80;
    reg  [12:0] int_lsc_register_rGain_V_81;
    reg  [12:0] int_lsc_register_rGain_V_82;
    reg  [12:0] int_lsc_register_rGain_V_83;
    reg  [12:0] int_lsc_register_rGain_V_84;
    reg  [12:0] int_lsc_register_rGain_V_85;
    reg  [12:0] int_lsc_register_rGain_V_86;
    reg  [12:0] int_lsc_register_rGain_V_87;
    reg  [12:0] int_lsc_register_rGain_V_88;
    reg  [12:0] int_lsc_register_rGain_V_89;
    reg  [12:0] int_lsc_register_rGain_V_90;
    reg  [12:0] int_lsc_register_rGain_V_91;
    reg  [12:0] int_lsc_register_rGain_V_92;
    reg  [12:0] int_lsc_register_rGain_V_93;
    reg  [12:0] int_lsc_register_rGain_V_94;
    reg  [12:0] int_lsc_register_rGain_V_95;
    reg  [12:0] int_lsc_register_rGain_V_96;
    reg  [12:0] int_lsc_register_rGain_V_97;
    reg  [12:0] int_lsc_register_rGain_V_98;
    reg  [12:0] int_lsc_register_rGain_V_99;
    reg  [12:0] int_lsc_register_rGain_V_100;
    reg  [12:0] int_lsc_register_rGain_V_101;
    reg  [12:0] int_lsc_register_rGain_V_102;
    reg  [12:0] int_lsc_register_rGain_V_103;
    reg  [12:0] int_lsc_register_rGain_V_104;
    reg  [12:0] int_lsc_register_rGain_V_105;
    reg  [12:0] int_lsc_register_rGain_V_106;
    reg  [12:0] int_lsc_register_rGain_V_107;
    reg  [12:0] int_lsc_register_rGain_V_108;
    reg  [12:0] int_lsc_register_rGain_V_109;
    reg  [12:0] int_lsc_register_rGain_V_110;
    reg  [12:0] int_lsc_register_rGain_V_111;
    reg  [12:0] int_lsc_register_rGain_V_112;
    reg  [12:0] int_lsc_register_rGain_V_113;
    reg  [12:0] int_lsc_register_rGain_V_114;
    reg  [12:0] int_lsc_register_rGain_V_115;
    reg  [12:0] int_lsc_register_rGain_V_116;
    reg  [12:0] int_lsc_register_rGain_V_117;
    reg  [12:0] int_lsc_register_rGain_V_118;
    reg  [12:0] int_lsc_register_rGain_V_119;
    reg  [12:0] int_lsc_register_rGain_V_120;
    reg  [12:0] int_lsc_register_rGain_V_121;
    reg  [12:0] int_lsc_register_rGain_V_122;
    reg  [12:0] int_lsc_register_rGain_V_123;
    reg  [12:0] int_lsc_register_rGain_V_124;
    reg  [12:0] int_lsc_register_rGain_V_125;
    reg  [12:0] int_lsc_register_rGain_V_126;
    reg  [12:0] int_lsc_register_rGain_V_127;
    reg  [12:0] int_lsc_register_rGain_V_128;
    reg  [12:0] int_lsc_register_rGain_V_129;
    reg  [12:0] int_lsc_register_rGain_V_130;
    reg  [12:0] int_lsc_register_rGain_V_131;
    reg  [12:0] int_lsc_register_rGain_V_132;
    reg  [12:0] int_lsc_register_rGain_V_133;
    reg  [12:0] int_lsc_register_rGain_V_134;
    reg  [12:0] int_lsc_register_rGain_V_135;
    reg  [12:0] int_lsc_register_rGain_V_136;
    reg  [12:0] int_lsc_register_rGain_V_137;
    reg  [12:0] int_lsc_register_rGain_V_138;
    reg  [12:0] int_lsc_register_rGain_V_139;
    reg  [12:0] int_lsc_register_rGain_V_140;
    reg  [12:0] int_lsc_register_rGain_V_141;
    reg  [12:0] int_lsc_register_rGain_V_142;
    reg  [12:0] int_lsc_register_rGain_V_143;
    reg  [12:0] int_lsc_register_rGain_V_144;
    reg  [12:0] int_lsc_register_rGain_V_145;
    reg  [12:0] int_lsc_register_rGain_V_146;
    reg  [12:0] int_lsc_register_rGain_V_147;
    reg  [12:0] int_lsc_register_rGain_V_148;
    reg  [12:0] int_lsc_register_rGain_V_149;
    reg  [12:0] int_lsc_register_rGain_V_150;
    reg  [12:0] int_lsc_register_rGain_V_151;
    reg  [12:0] int_lsc_register_rGain_V_152;
    reg  [12:0] int_lsc_register_rGain_V_153;
    reg  [12:0] int_lsc_register_rGain_V_154;
    reg  [12:0] int_lsc_register_rGain_V_155;
    reg  [12:0] int_lsc_register_rGain_V_156;
    reg  [12:0] int_lsc_register_rGain_V_157;
    reg  [12:0] int_lsc_register_rGain_V_158;
    reg  [12:0] int_lsc_register_rGain_V_159;
    reg  [12:0] int_lsc_register_rGain_V_160;
    reg  [12:0] int_lsc_register_rGain_V_161;
    reg  [12:0] int_lsc_register_rGain_V_162;
    reg  [12:0] int_lsc_register_rGain_V_163;
    reg  [12:0] int_lsc_register_rGain_V_164;
    reg  [12:0] int_lsc_register_rGain_V_165;
    reg  [12:0] int_lsc_register_rGain_V_166;
    reg  [12:0] int_lsc_register_rGain_V_167;
    reg  [12:0] int_lsc_register_rGain_V_168;
    reg  [12:0] int_lsc_register_rGain_V_169;
    reg  [12:0] int_lsc_register_rGain_V_170;
    reg  [12:0] int_lsc_register_rGain_V_171;
    reg  [12:0] int_lsc_register_rGain_V_172;
    reg  [12:0] int_lsc_register_rGain_V_173;
    reg  [12:0] int_lsc_register_rGain_V_174;
    reg  [12:0] int_lsc_register_rGain_V_175;
    reg  [12:0] int_lsc_register_rGain_V_176;
    reg  [12:0] int_lsc_register_rGain_V_177;
    reg  [12:0] int_lsc_register_rGain_V_178;
    reg  [12:0] int_lsc_register_rGain_V_179;
    reg  [12:0] int_lsc_register_rGain_V_180;
    reg  [12:0] int_lsc_register_rGain_V_181;
    reg  [12:0] int_lsc_register_rGain_V_182;
    reg  [12:0] int_lsc_register_rGain_V_183;
    reg  [12:0] int_lsc_register_rGain_V_184;
    reg  [12:0] int_lsc_register_rGain_V_185;
    reg  [12:0] int_lsc_register_rGain_V_186;
    reg  [12:0] int_lsc_register_rGain_V_187;
    reg  [12:0] int_lsc_register_rGain_V_188;
    reg  [12:0] int_lsc_register_rGain_V_189;
    reg  [12:0] int_lsc_register_rGain_V_190;
    reg  [12:0] int_lsc_register_rGain_V_191;
    reg  [12:0] int_lsc_register_rGain_V_192;
    reg  [12:0] int_lsc_register_rGain_V_193;
    reg  [12:0] int_lsc_register_rGain_V_194;
    reg  [12:0] int_lsc_register_rGain_V_195;
    reg  [12:0] int_lsc_register_rGain_V_196;
    reg  [12:0] int_lsc_register_rGain_V_197;
    reg  [12:0] int_lsc_register_rGain_V_198;
    reg  [12:0] int_lsc_register_rGain_V_199;
    reg  [12:0] int_lsc_register_rGain_V_200;
    reg  [12:0] int_lsc_register_rGain_V_201;
    reg  [12:0] int_lsc_register_rGain_V_202;
    reg  [12:0] int_lsc_register_rGain_V_203;
    reg  [12:0] int_lsc_register_rGain_V_204;
    reg  [12:0] int_lsc_register_rGain_V_205;
    reg  [12:0] int_lsc_register_rGain_V_206;
    reg  [12:0] int_lsc_register_rGain_V_207;
    reg  [12:0] int_lsc_register_rGain_V_208;
    reg  [12:0] int_lsc_register_rGain_V_209;
    reg  [12:0] int_lsc_register_rGain_V_210;
    reg  [12:0] int_lsc_register_rGain_V_211;
    reg  [12:0] int_lsc_register_rGain_V_212;
    reg  [12:0] int_lsc_register_rGain_V_213;
    reg  [12:0] int_lsc_register_rGain_V_214;
    reg  [12:0] int_lsc_register_rGain_V_215;
    reg  [12:0] int_lsc_register_rGain_V_216;
    reg  [12:0] int_lsc_register_rGain_V_217;
    reg  [12:0] int_lsc_register_rGain_V_218;
    reg  [12:0] int_lsc_register_rGain_V_219;
    reg  [12:0] int_lsc_register_rGain_V_220;
    reg  [12:0] int_lsc_register_GrGain_V_0;
    reg  [12:0] int_lsc_register_GrGain_V_1;
    reg  [12:0] int_lsc_register_GrGain_V_2;
    reg  [12:0] int_lsc_register_GrGain_V_3;
    reg  [12:0] int_lsc_register_GrGain_V_4;
    reg  [12:0] int_lsc_register_GrGain_V_5;
    reg  [12:0] int_lsc_register_GrGain_V_6;
    reg  [12:0] int_lsc_register_GrGain_V_7;
    reg  [12:0] int_lsc_register_GrGain_V_8;
    reg  [12:0] int_lsc_register_GrGain_V_9;
    reg  [12:0] int_lsc_register_GrGain_V_10;
    reg  [12:0] int_lsc_register_GrGain_V_11;
    reg  [12:0] int_lsc_register_GrGain_V_12;
    reg  [12:0] int_lsc_register_GrGain_V_13;
    reg  [12:0] int_lsc_register_GrGain_V_14;
    reg  [12:0] int_lsc_register_GrGain_V_15;
    reg  [12:0] int_lsc_register_GrGain_V_16;
    reg  [12:0] int_lsc_register_GrGain_V_17;
    reg  [12:0] int_lsc_register_GrGain_V_18;
    reg  [12:0] int_lsc_register_GrGain_V_19;
    reg  [12:0] int_lsc_register_GrGain_V_20;
    reg  [12:0] int_lsc_register_GrGain_V_21;
    reg  [12:0] int_lsc_register_GrGain_V_22;
    reg  [12:0] int_lsc_register_GrGain_V_23;
    reg  [12:0] int_lsc_register_GrGain_V_24;
    reg  [12:0] int_lsc_register_GrGain_V_25;
    reg  [12:0] int_lsc_register_GrGain_V_26;
    reg  [12:0] int_lsc_register_GrGain_V_27;
    reg  [12:0] int_lsc_register_GrGain_V_28;
    reg  [12:0] int_lsc_register_GrGain_V_29;
    reg  [12:0] int_lsc_register_GrGain_V_30;
    reg  [12:0] int_lsc_register_GrGain_V_31;
    reg  [12:0] int_lsc_register_GrGain_V_32;
    reg  [12:0] int_lsc_register_GrGain_V_33;
    reg  [12:0] int_lsc_register_GrGain_V_34;
    reg  [12:0] int_lsc_register_GrGain_V_35;
    reg  [12:0] int_lsc_register_GrGain_V_36;
    reg  [12:0] int_lsc_register_GrGain_V_37;
    reg  [12:0] int_lsc_register_GrGain_V_38;
    reg  [12:0] int_lsc_register_GrGain_V_39;
    reg  [12:0] int_lsc_register_GrGain_V_40;
    reg  [12:0] int_lsc_register_GrGain_V_41;
    reg  [12:0] int_lsc_register_GrGain_V_42;
    reg  [12:0] int_lsc_register_GrGain_V_43;
    reg  [12:0] int_lsc_register_GrGain_V_44;
    reg  [12:0] int_lsc_register_GrGain_V_45;
    reg  [12:0] int_lsc_register_GrGain_V_46;
    reg  [12:0] int_lsc_register_GrGain_V_47;
    reg  [12:0] int_lsc_register_GrGain_V_48;
    reg  [12:0] int_lsc_register_GrGain_V_49;
    reg  [12:0] int_lsc_register_GrGain_V_50;
    reg  [12:0] int_lsc_register_GrGain_V_51;
    reg  [12:0] int_lsc_register_GrGain_V_52;
    reg  [12:0] int_lsc_register_GrGain_V_53;
    reg  [12:0] int_lsc_register_GrGain_V_54;
    reg  [12:0] int_lsc_register_GrGain_V_55;
    reg  [12:0] int_lsc_register_GrGain_V_56;
    reg  [12:0] int_lsc_register_GrGain_V_57;
    reg  [12:0] int_lsc_register_GrGain_V_58;
    reg  [12:0] int_lsc_register_GrGain_V_59;
    reg  [12:0] int_lsc_register_GrGain_V_60;
    reg  [12:0] int_lsc_register_GrGain_V_61;
    reg  [12:0] int_lsc_register_GrGain_V_62;
    reg  [12:0] int_lsc_register_GrGain_V_63;
    reg  [12:0] int_lsc_register_GrGain_V_64;
    reg  [12:0] int_lsc_register_GrGain_V_65;
    reg  [12:0] int_lsc_register_GrGain_V_66;
    reg  [12:0] int_lsc_register_GrGain_V_67;
    reg  [12:0] int_lsc_register_GrGain_V_68;
    reg  [12:0] int_lsc_register_GrGain_V_69;
    reg  [12:0] int_lsc_register_GrGain_V_70;
    reg  [12:0] int_lsc_register_GrGain_V_71;
    reg  [12:0] int_lsc_register_GrGain_V_72;
    reg  [12:0] int_lsc_register_GrGain_V_73;
    reg  [12:0] int_lsc_register_GrGain_V_74;
    reg  [12:0] int_lsc_register_GrGain_V_75;
    reg  [12:0] int_lsc_register_GrGain_V_76;
    reg  [12:0] int_lsc_register_GrGain_V_77;
    reg  [12:0] int_lsc_register_GrGain_V_78;
    reg  [12:0] int_lsc_register_GrGain_V_79;
    reg  [12:0] int_lsc_register_GrGain_V_80;
    reg  [12:0] int_lsc_register_GrGain_V_81;
    reg  [12:0] int_lsc_register_GrGain_V_82;
    reg  [12:0] int_lsc_register_GrGain_V_83;
    reg  [12:0] int_lsc_register_GrGain_V_84;
    reg  [12:0] int_lsc_register_GrGain_V_85;
    reg  [12:0] int_lsc_register_GrGain_V_86;
    reg  [12:0] int_lsc_register_GrGain_V_87;
    reg  [12:0] int_lsc_register_GrGain_V_88;
    reg  [12:0] int_lsc_register_GrGain_V_89;
    reg  [12:0] int_lsc_register_GrGain_V_90;
    reg  [12:0] int_lsc_register_GrGain_V_91;
    reg  [12:0] int_lsc_register_GrGain_V_92;
    reg  [12:0] int_lsc_register_GrGain_V_93;
    reg  [12:0] int_lsc_register_GrGain_V_94;
    reg  [12:0] int_lsc_register_GrGain_V_95;
    reg  [12:0] int_lsc_register_GrGain_V_96;
    reg  [12:0] int_lsc_register_GrGain_V_97;
    reg  [12:0] int_lsc_register_GrGain_V_98;
    reg  [12:0] int_lsc_register_GrGain_V_99;
    reg  [12:0] int_lsc_register_GrGain_V_100;
    reg  [12:0] int_lsc_register_GrGain_V_101;
    reg  [12:0] int_lsc_register_GrGain_V_102;
    reg  [12:0] int_lsc_register_GrGain_V_103;
    reg  [12:0] int_lsc_register_GrGain_V_104;
    reg  [12:0] int_lsc_register_GrGain_V_105;
    reg  [12:0] int_lsc_register_GrGain_V_106;
    reg  [12:0] int_lsc_register_GrGain_V_107;
    reg  [12:0] int_lsc_register_GrGain_V_108;
    reg  [12:0] int_lsc_register_GrGain_V_109;
    reg  [12:0] int_lsc_register_GrGain_V_110;
    reg  [12:0] int_lsc_register_GrGain_V_111;
    reg  [12:0] int_lsc_register_GrGain_V_112;
    reg  [12:0] int_lsc_register_GrGain_V_113;
    reg  [12:0] int_lsc_register_GrGain_V_114;
    reg  [12:0] int_lsc_register_GrGain_V_115;
    reg  [12:0] int_lsc_register_GrGain_V_116;
    reg  [12:0] int_lsc_register_GrGain_V_117;
    reg  [12:0] int_lsc_register_GrGain_V_118;
    reg  [12:0] int_lsc_register_GrGain_V_119;
    reg  [12:0] int_lsc_register_GrGain_V_120;
    reg  [12:0] int_lsc_register_GrGain_V_121;
    reg  [12:0] int_lsc_register_GrGain_V_122;
    reg  [12:0] int_lsc_register_GrGain_V_123;
    reg  [12:0] int_lsc_register_GrGain_V_124;
    reg  [12:0] int_lsc_register_GrGain_V_125;
    reg  [12:0] int_lsc_register_GrGain_V_126;
    reg  [12:0] int_lsc_register_GrGain_V_127;
    reg  [12:0] int_lsc_register_GrGain_V_128;
    reg  [12:0] int_lsc_register_GrGain_V_129;
    reg  [12:0] int_lsc_register_GrGain_V_130;
    reg  [12:0] int_lsc_register_GrGain_V_131;
    reg  [12:0] int_lsc_register_GrGain_V_132;
    reg  [12:0] int_lsc_register_GrGain_V_133;
    reg  [12:0] int_lsc_register_GrGain_V_134;
    reg  [12:0] int_lsc_register_GrGain_V_135;
    reg  [12:0] int_lsc_register_GrGain_V_136;
    reg  [12:0] int_lsc_register_GrGain_V_137;
    reg  [12:0] int_lsc_register_GrGain_V_138;
    reg  [12:0] int_lsc_register_GrGain_V_139;
    reg  [12:0] int_lsc_register_GrGain_V_140;
    reg  [12:0] int_lsc_register_GrGain_V_141;
    reg  [12:0] int_lsc_register_GrGain_V_142;
    reg  [12:0] int_lsc_register_GrGain_V_143;
    reg  [12:0] int_lsc_register_GrGain_V_144;
    reg  [12:0] int_lsc_register_GrGain_V_145;
    reg  [12:0] int_lsc_register_GrGain_V_146;
    reg  [12:0] int_lsc_register_GrGain_V_147;
    reg  [12:0] int_lsc_register_GrGain_V_148;
    reg  [12:0] int_lsc_register_GrGain_V_149;
    reg  [12:0] int_lsc_register_GrGain_V_150;
    reg  [12:0] int_lsc_register_GrGain_V_151;
    reg  [12:0] int_lsc_register_GrGain_V_152;
    reg  [12:0] int_lsc_register_GrGain_V_153;
    reg  [12:0] int_lsc_register_GrGain_V_154;
    reg  [12:0] int_lsc_register_GrGain_V_155;
    reg  [12:0] int_lsc_register_GrGain_V_156;
    reg  [12:0] int_lsc_register_GrGain_V_157;
    reg  [12:0] int_lsc_register_GrGain_V_158;
    reg  [12:0] int_lsc_register_GrGain_V_159;
    reg  [12:0] int_lsc_register_GrGain_V_160;
    reg  [12:0] int_lsc_register_GrGain_V_161;
    reg  [12:0] int_lsc_register_GrGain_V_162;
    reg  [12:0] int_lsc_register_GrGain_V_163;
    reg  [12:0] int_lsc_register_GrGain_V_164;
    reg  [12:0] int_lsc_register_GrGain_V_165;
    reg  [12:0] int_lsc_register_GrGain_V_166;
    reg  [12:0] int_lsc_register_GrGain_V_167;
    reg  [12:0] int_lsc_register_GrGain_V_168;
    reg  [12:0] int_lsc_register_GrGain_V_169;
    reg  [12:0] int_lsc_register_GrGain_V_170;
    reg  [12:0] int_lsc_register_GrGain_V_171;
    reg  [12:0] int_lsc_register_GrGain_V_172;
    reg  [12:0] int_lsc_register_GrGain_V_173;
    reg  [12:0] int_lsc_register_GrGain_V_174;
    reg  [12:0] int_lsc_register_GrGain_V_175;
    reg  [12:0] int_lsc_register_GrGain_V_176;
    reg  [12:0] int_lsc_register_GrGain_V_177;
    reg  [12:0] int_lsc_register_GrGain_V_178;
    reg  [12:0] int_lsc_register_GrGain_V_179;
    reg  [12:0] int_lsc_register_GrGain_V_180;
    reg  [12:0] int_lsc_register_GrGain_V_181;
    reg  [12:0] int_lsc_register_GrGain_V_182;
    reg  [12:0] int_lsc_register_GrGain_V_183;
    reg  [12:0] int_lsc_register_GrGain_V_184;
    reg  [12:0] int_lsc_register_GrGain_V_185;
    reg  [12:0] int_lsc_register_GrGain_V_186;
    reg  [12:0] int_lsc_register_GrGain_V_187;
    reg  [12:0] int_lsc_register_GrGain_V_188;
    reg  [12:0] int_lsc_register_GrGain_V_189;
    reg  [12:0] int_lsc_register_GrGain_V_190;
    reg  [12:0] int_lsc_register_GrGain_V_191;
    reg  [12:0] int_lsc_register_GrGain_V_192;
    reg  [12:0] int_lsc_register_GrGain_V_193;
    reg  [12:0] int_lsc_register_GrGain_V_194;
    reg  [12:0] int_lsc_register_GrGain_V_195;
    reg  [12:0] int_lsc_register_GrGain_V_196;
    reg  [12:0] int_lsc_register_GrGain_V_197;
    reg  [12:0] int_lsc_register_GrGain_V_198;
    reg  [12:0] int_lsc_register_GrGain_V_199;
    reg  [12:0] int_lsc_register_GrGain_V_200;
    reg  [12:0] int_lsc_register_GrGain_V_201;
    reg  [12:0] int_lsc_register_GrGain_V_202;
    reg  [12:0] int_lsc_register_GrGain_V_203;
    reg  [12:0] int_lsc_register_GrGain_V_204;
    reg  [12:0] int_lsc_register_GrGain_V_205;
    reg  [12:0] int_lsc_register_GrGain_V_206;
    reg  [12:0] int_lsc_register_GrGain_V_207;
    reg  [12:0] int_lsc_register_GrGain_V_208;
    reg  [12:0] int_lsc_register_GrGain_V_209;
    reg  [12:0] int_lsc_register_GrGain_V_210;
    reg  [12:0] int_lsc_register_GrGain_V_211;
    reg  [12:0] int_lsc_register_GrGain_V_212;
    reg  [12:0] int_lsc_register_GrGain_V_213;
    reg  [12:0] int_lsc_register_GrGain_V_214;
    reg  [12:0] int_lsc_register_GrGain_V_215;
    reg  [12:0] int_lsc_register_GrGain_V_216;
    reg  [12:0] int_lsc_register_GrGain_V_217;
    reg  [12:0] int_lsc_register_GrGain_V_218;
    reg  [12:0] int_lsc_register_GrGain_V_219;
    reg  [12:0] int_lsc_register_GrGain_V_220;
    reg  [12:0] int_lsc_register_GbGain_V_0;
    reg  [12:0] int_lsc_register_GbGain_V_1;
    reg  [12:0] int_lsc_register_GbGain_V_2;
    reg  [12:0] int_lsc_register_GbGain_V_3;
    reg  [12:0] int_lsc_register_GbGain_V_4;
    reg  [12:0] int_lsc_register_GbGain_V_5;
    reg  [12:0] int_lsc_register_GbGain_V_6;
    reg  [12:0] int_lsc_register_GbGain_V_7;
    reg  [12:0] int_lsc_register_GbGain_V_8;
    reg  [12:0] int_lsc_register_GbGain_V_9;
    reg  [12:0] int_lsc_register_GbGain_V_10;
    reg  [12:0] int_lsc_register_GbGain_V_11;
    reg  [12:0] int_lsc_register_GbGain_V_12;
    reg  [12:0] int_lsc_register_GbGain_V_13;
    reg  [12:0] int_lsc_register_GbGain_V_14;
    reg  [12:0] int_lsc_register_GbGain_V_15;
    reg  [12:0] int_lsc_register_GbGain_V_16;
    reg  [12:0] int_lsc_register_GbGain_V_17;
    reg  [12:0] int_lsc_register_GbGain_V_18;
    reg  [12:0] int_lsc_register_GbGain_V_19;
    reg  [12:0] int_lsc_register_GbGain_V_20;
    reg  [12:0] int_lsc_register_GbGain_V_21;
    reg  [12:0] int_lsc_register_GbGain_V_22;
    reg  [12:0] int_lsc_register_GbGain_V_23;
    reg  [12:0] int_lsc_register_GbGain_V_24;
    reg  [12:0] int_lsc_register_GbGain_V_25;
    reg  [12:0] int_lsc_register_GbGain_V_26;
    reg  [12:0] int_lsc_register_GbGain_V_27;
    reg  [12:0] int_lsc_register_GbGain_V_28;
    reg  [12:0] int_lsc_register_GbGain_V_29;
    reg  [12:0] int_lsc_register_GbGain_V_30;
    reg  [12:0] int_lsc_register_GbGain_V_31;
    reg  [12:0] int_lsc_register_GbGain_V_32;
    reg  [12:0] int_lsc_register_GbGain_V_33;
    reg  [12:0] int_lsc_register_GbGain_V_34;
    reg  [12:0] int_lsc_register_GbGain_V_35;
    reg  [12:0] int_lsc_register_GbGain_V_36;
    reg  [12:0] int_lsc_register_GbGain_V_37;
    reg  [12:0] int_lsc_register_GbGain_V_38;
    reg  [12:0] int_lsc_register_GbGain_V_39;
    reg  [12:0] int_lsc_register_GbGain_V_40;
    reg  [12:0] int_lsc_register_GbGain_V_41;
    reg  [12:0] int_lsc_register_GbGain_V_42;
    reg  [12:0] int_lsc_register_GbGain_V_43;
    reg  [12:0] int_lsc_register_GbGain_V_44;
    reg  [12:0] int_lsc_register_GbGain_V_45;
    reg  [12:0] int_lsc_register_GbGain_V_46;
    reg  [12:0] int_lsc_register_GbGain_V_47;
    reg  [12:0] int_lsc_register_GbGain_V_48;
    reg  [12:0] int_lsc_register_GbGain_V_49;
    reg  [12:0] int_lsc_register_GbGain_V_50;
    reg  [12:0] int_lsc_register_GbGain_V_51;
    reg  [12:0] int_lsc_register_GbGain_V_52;
    reg  [12:0] int_lsc_register_GbGain_V_53;
    reg  [12:0] int_lsc_register_GbGain_V_54;
    reg  [12:0] int_lsc_register_GbGain_V_55;
    reg  [12:0] int_lsc_register_GbGain_V_56;
    reg  [12:0] int_lsc_register_GbGain_V_57;
    reg  [12:0] int_lsc_register_GbGain_V_58;
    reg  [12:0] int_lsc_register_GbGain_V_59;
    reg  [12:0] int_lsc_register_GbGain_V_60;
    reg  [12:0] int_lsc_register_GbGain_V_61;
    reg  [12:0] int_lsc_register_GbGain_V_62;
    reg  [12:0] int_lsc_register_GbGain_V_63;
    reg  [12:0] int_lsc_register_GbGain_V_64;
    reg  [12:0] int_lsc_register_GbGain_V_65;
    reg  [12:0] int_lsc_register_GbGain_V_66;
    reg  [12:0] int_lsc_register_GbGain_V_67;
    reg  [12:0] int_lsc_register_GbGain_V_68;
    reg  [12:0] int_lsc_register_GbGain_V_69;
    reg  [12:0] int_lsc_register_GbGain_V_70;
    reg  [12:0] int_lsc_register_GbGain_V_71;
    reg  [12:0] int_lsc_register_GbGain_V_72;
    reg  [12:0] int_lsc_register_GbGain_V_73;
    reg  [12:0] int_lsc_register_GbGain_V_74;
    reg  [12:0] int_lsc_register_GbGain_V_75;
    reg  [12:0] int_lsc_register_GbGain_V_76;
    reg  [12:0] int_lsc_register_GbGain_V_77;
    reg  [12:0] int_lsc_register_GbGain_V_78;
    reg  [12:0] int_lsc_register_GbGain_V_79;
    reg  [12:0] int_lsc_register_GbGain_V_80;
    reg  [12:0] int_lsc_register_GbGain_V_81;
    reg  [12:0] int_lsc_register_GbGain_V_82;
    reg  [12:0] int_lsc_register_GbGain_V_83;
    reg  [12:0] int_lsc_register_GbGain_V_84;
    reg  [12:0] int_lsc_register_GbGain_V_85;
    reg  [12:0] int_lsc_register_GbGain_V_86;
    reg  [12:0] int_lsc_register_GbGain_V_87;
    reg  [12:0] int_lsc_register_GbGain_V_88;
    reg  [12:0] int_lsc_register_GbGain_V_89;
    reg  [12:0] int_lsc_register_GbGain_V_90;
    reg  [12:0] int_lsc_register_GbGain_V_91;
    reg  [12:0] int_lsc_register_GbGain_V_92;
    reg  [12:0] int_lsc_register_GbGain_V_93;
    reg  [12:0] int_lsc_register_GbGain_V_94;
    reg  [12:0] int_lsc_register_GbGain_V_95;
    reg  [12:0] int_lsc_register_GbGain_V_96;
    reg  [12:0] int_lsc_register_GbGain_V_97;
    reg  [12:0] int_lsc_register_GbGain_V_98;
    reg  [12:0] int_lsc_register_GbGain_V_99;
    reg  [12:0] int_lsc_register_GbGain_V_100;
    reg  [12:0] int_lsc_register_GbGain_V_101;
    reg  [12:0] int_lsc_register_GbGain_V_102;
    reg  [12:0] int_lsc_register_GbGain_V_103;
    reg  [12:0] int_lsc_register_GbGain_V_104;
    reg  [12:0] int_lsc_register_GbGain_V_105;
    reg  [12:0] int_lsc_register_GbGain_V_106;
    reg  [12:0] int_lsc_register_GbGain_V_107;
    reg  [12:0] int_lsc_register_GbGain_V_108;
    reg  [12:0] int_lsc_register_GbGain_V_109;
    reg  [12:0] int_lsc_register_GbGain_V_110;
    reg  [12:0] int_lsc_register_GbGain_V_111;
    reg  [12:0] int_lsc_register_GbGain_V_112;
    reg  [12:0] int_lsc_register_GbGain_V_113;
    reg  [12:0] int_lsc_register_GbGain_V_114;
    reg  [12:0] int_lsc_register_GbGain_V_115;
    reg  [12:0] int_lsc_register_GbGain_V_116;
    reg  [12:0] int_lsc_register_GbGain_V_117;
    reg  [12:0] int_lsc_register_GbGain_V_118;
    reg  [12:0] int_lsc_register_GbGain_V_119;
    reg  [12:0] int_lsc_register_GbGain_V_120;
    reg  [12:0] int_lsc_register_GbGain_V_121;
    reg  [12:0] int_lsc_register_GbGain_V_122;
    reg  [12:0] int_lsc_register_GbGain_V_123;
    reg  [12:0] int_lsc_register_GbGain_V_124;
    reg  [12:0] int_lsc_register_GbGain_V_125;
    reg  [12:0] int_lsc_register_GbGain_V_126;
    reg  [12:0] int_lsc_register_GbGain_V_127;
    reg  [12:0] int_lsc_register_GbGain_V_128;
    reg  [12:0] int_lsc_register_GbGain_V_129;
    reg  [12:0] int_lsc_register_GbGain_V_130;
    reg  [12:0] int_lsc_register_GbGain_V_131;
    reg  [12:0] int_lsc_register_GbGain_V_132;
    reg  [12:0] int_lsc_register_GbGain_V_133;
    reg  [12:0] int_lsc_register_GbGain_V_134;
    reg  [12:0] int_lsc_register_GbGain_V_135;
    reg  [12:0] int_lsc_register_GbGain_V_136;
    reg  [12:0] int_lsc_register_GbGain_V_137;
    reg  [12:0] int_lsc_register_GbGain_V_138;
    reg  [12:0] int_lsc_register_GbGain_V_139;
    reg  [12:0] int_lsc_register_GbGain_V_140;
    reg  [12:0] int_lsc_register_GbGain_V_141;
    reg  [12:0] int_lsc_register_GbGain_V_142;
    reg  [12:0] int_lsc_register_GbGain_V_143;
    reg  [12:0] int_lsc_register_GbGain_V_144;
    reg  [12:0] int_lsc_register_GbGain_V_145;
    reg  [12:0] int_lsc_register_GbGain_V_146;
    reg  [12:0] int_lsc_register_GbGain_V_147;
    reg  [12:0] int_lsc_register_GbGain_V_148;
    reg  [12:0] int_lsc_register_GbGain_V_149;
    reg  [12:0] int_lsc_register_GbGain_V_150;
    reg  [12:0] int_lsc_register_GbGain_V_151;
    reg  [12:0] int_lsc_register_GbGain_V_152;
    reg  [12:0] int_lsc_register_GbGain_V_153;
    reg  [12:0] int_lsc_register_GbGain_V_154;
    reg  [12:0] int_lsc_register_GbGain_V_155;
    reg  [12:0] int_lsc_register_GbGain_V_156;
    reg  [12:0] int_lsc_register_GbGain_V_157;
    reg  [12:0] int_lsc_register_GbGain_V_158;
    reg  [12:0] int_lsc_register_GbGain_V_159;
    reg  [12:0] int_lsc_register_GbGain_V_160;
    reg  [12:0] int_lsc_register_GbGain_V_161;
    reg  [12:0] int_lsc_register_GbGain_V_162;
    reg  [12:0] int_lsc_register_GbGain_V_163;
    reg  [12:0] int_lsc_register_GbGain_V_164;
    reg  [12:0] int_lsc_register_GbGain_V_165;
    reg  [12:0] int_lsc_register_GbGain_V_166;
    reg  [12:0] int_lsc_register_GbGain_V_167;
    reg  [12:0] int_lsc_register_GbGain_V_168;
    reg  [12:0] int_lsc_register_GbGain_V_169;
    reg  [12:0] int_lsc_register_GbGain_V_170;
    reg  [12:0] int_lsc_register_GbGain_V_171;
    reg  [12:0] int_lsc_register_GbGain_V_172;
    reg  [12:0] int_lsc_register_GbGain_V_173;
    reg  [12:0] int_lsc_register_GbGain_V_174;
    reg  [12:0] int_lsc_register_GbGain_V_175;
    reg  [12:0] int_lsc_register_GbGain_V_176;
    reg  [12:0] int_lsc_register_GbGain_V_177;
    reg  [12:0] int_lsc_register_GbGain_V_178;
    reg  [12:0] int_lsc_register_GbGain_V_179;
    reg  [12:0] int_lsc_register_GbGain_V_180;
    reg  [12:0] int_lsc_register_GbGain_V_181;
    reg  [12:0] int_lsc_register_GbGain_V_182;
    reg  [12:0] int_lsc_register_GbGain_V_183;
    reg  [12:0] int_lsc_register_GbGain_V_184;
    reg  [12:0] int_lsc_register_GbGain_V_185;
    reg  [12:0] int_lsc_register_GbGain_V_186;
    reg  [12:0] int_lsc_register_GbGain_V_187;
    reg  [12:0] int_lsc_register_GbGain_V_188;
    reg  [12:0] int_lsc_register_GbGain_V_189;
    reg  [12:0] int_lsc_register_GbGain_V_190;
    reg  [12:0] int_lsc_register_GbGain_V_191;
    reg  [12:0] int_lsc_register_GbGain_V_192;
    reg  [12:0] int_lsc_register_GbGain_V_193;
    reg  [12:0] int_lsc_register_GbGain_V_194;
    reg  [12:0] int_lsc_register_GbGain_V_195;
    reg  [12:0] int_lsc_register_GbGain_V_196;
    reg  [12:0] int_lsc_register_GbGain_V_197;
    reg  [12:0] int_lsc_register_GbGain_V_198;
    reg  [12:0] int_lsc_register_GbGain_V_199;
    reg  [12:0] int_lsc_register_GbGain_V_200;
    reg  [12:0] int_lsc_register_GbGain_V_201;
    reg  [12:0] int_lsc_register_GbGain_V_202;
    reg  [12:0] int_lsc_register_GbGain_V_203;
    reg  [12:0] int_lsc_register_GbGain_V_204;
    reg  [12:0] int_lsc_register_GbGain_V_205;
    reg  [12:0] int_lsc_register_GbGain_V_206;
    reg  [12:0] int_lsc_register_GbGain_V_207;
    reg  [12:0] int_lsc_register_GbGain_V_208;
    reg  [12:0] int_lsc_register_GbGain_V_209;
    reg  [12:0] int_lsc_register_GbGain_V_210;
    reg  [12:0] int_lsc_register_GbGain_V_211;
    reg  [12:0] int_lsc_register_GbGain_V_212;
    reg  [12:0] int_lsc_register_GbGain_V_213;
    reg  [12:0] int_lsc_register_GbGain_V_214;
    reg  [12:0] int_lsc_register_GbGain_V_215;
    reg  [12:0] int_lsc_register_GbGain_V_216;
    reg  [12:0] int_lsc_register_GbGain_V_217;
    reg  [12:0] int_lsc_register_GbGain_V_218;
    reg  [12:0] int_lsc_register_GbGain_V_219;
    reg  [12:0] int_lsc_register_GbGain_V_220;
    reg  [12:0] int_lsc_register_bGain_V_0;
    reg  [12:0] int_lsc_register_bGain_V_1;
    reg  [12:0] int_lsc_register_bGain_V_2;
    reg  [12:0] int_lsc_register_bGain_V_3;
    reg  [12:0] int_lsc_register_bGain_V_4;
    reg  [12:0] int_lsc_register_bGain_V_5;
    reg  [12:0] int_lsc_register_bGain_V_6;
    reg  [12:0] int_lsc_register_bGain_V_7;
    reg  [12:0] int_lsc_register_bGain_V_8;
    reg  [12:0] int_lsc_register_bGain_V_9;
    reg  [12:0] int_lsc_register_bGain_V_10;
    reg  [12:0] int_lsc_register_bGain_V_11;
    reg  [12:0] int_lsc_register_bGain_V_12;
    reg  [12:0] int_lsc_register_bGain_V_13;
    reg  [12:0] int_lsc_register_bGain_V_14;
    reg  [12:0] int_lsc_register_bGain_V_15;
    reg  [12:0] int_lsc_register_bGain_V_16;
    reg  [12:0] int_lsc_register_bGain_V_17;
    reg  [12:0] int_lsc_register_bGain_V_18;
    reg  [12:0] int_lsc_register_bGain_V_19;
    reg  [12:0] int_lsc_register_bGain_V_20;
    reg  [12:0] int_lsc_register_bGain_V_21;
    reg  [12:0] int_lsc_register_bGain_V_22;
    reg  [12:0] int_lsc_register_bGain_V_23;
    reg  [12:0] int_lsc_register_bGain_V_24;
    reg  [12:0] int_lsc_register_bGain_V_25;
    reg  [12:0] int_lsc_register_bGain_V_26;
    reg  [12:0] int_lsc_register_bGain_V_27;
    reg  [12:0] int_lsc_register_bGain_V_28;
    reg  [12:0] int_lsc_register_bGain_V_29;
    reg  [12:0] int_lsc_register_bGain_V_30;
    reg  [12:0] int_lsc_register_bGain_V_31;
    reg  [12:0] int_lsc_register_bGain_V_32;
    reg  [12:0] int_lsc_register_bGain_V_33;
    reg  [12:0] int_lsc_register_bGain_V_34;
    reg  [12:0] int_lsc_register_bGain_V_35;
    reg  [12:0] int_lsc_register_bGain_V_36;
    reg  [12:0] int_lsc_register_bGain_V_37;
    reg  [12:0] int_lsc_register_bGain_V_38;
    reg  [12:0] int_lsc_register_bGain_V_39;
    reg  [12:0] int_lsc_register_bGain_V_40;
    reg  [12:0] int_lsc_register_bGain_V_41;
    reg  [12:0] int_lsc_register_bGain_V_42;
    reg  [12:0] int_lsc_register_bGain_V_43;
    reg  [12:0] int_lsc_register_bGain_V_44;
    reg  [12:0] int_lsc_register_bGain_V_45;
    reg  [12:0] int_lsc_register_bGain_V_46;
    reg  [12:0] int_lsc_register_bGain_V_47;
    reg  [12:0] int_lsc_register_bGain_V_48;
    reg  [12:0] int_lsc_register_bGain_V_49;
    reg  [12:0] int_lsc_register_bGain_V_50;
    reg  [12:0] int_lsc_register_bGain_V_51;
    reg  [12:0] int_lsc_register_bGain_V_52;
    reg  [12:0] int_lsc_register_bGain_V_53;
    reg  [12:0] int_lsc_register_bGain_V_54;
    reg  [12:0] int_lsc_register_bGain_V_55;
    reg  [12:0] int_lsc_register_bGain_V_56;
    reg  [12:0] int_lsc_register_bGain_V_57;
    reg  [12:0] int_lsc_register_bGain_V_58;
    reg  [12:0] int_lsc_register_bGain_V_59;
    reg  [12:0] int_lsc_register_bGain_V_60;
    reg  [12:0] int_lsc_register_bGain_V_61;
    reg  [12:0] int_lsc_register_bGain_V_62;
    reg  [12:0] int_lsc_register_bGain_V_63;
    reg  [12:0] int_lsc_register_bGain_V_64;
    reg  [12:0] int_lsc_register_bGain_V_65;
    reg  [12:0] int_lsc_register_bGain_V_66;
    reg  [12:0] int_lsc_register_bGain_V_67;
    reg  [12:0] int_lsc_register_bGain_V_68;
    reg  [12:0] int_lsc_register_bGain_V_69;
    reg  [12:0] int_lsc_register_bGain_V_70;
    reg  [12:0] int_lsc_register_bGain_V_71;
    reg  [12:0] int_lsc_register_bGain_V_72;
    reg  [12:0] int_lsc_register_bGain_V_73;
    reg  [12:0] int_lsc_register_bGain_V_74;
    reg  [12:0] int_lsc_register_bGain_V_75;
    reg  [12:0] int_lsc_register_bGain_V_76;
    reg  [12:0] int_lsc_register_bGain_V_77;
    reg  [12:0] int_lsc_register_bGain_V_78;
    reg  [12:0] int_lsc_register_bGain_V_79;
    reg  [12:0] int_lsc_register_bGain_V_80;
    reg  [12:0] int_lsc_register_bGain_V_81;
    reg  [12:0] int_lsc_register_bGain_V_82;
    reg  [12:0] int_lsc_register_bGain_V_83;
    reg  [12:0] int_lsc_register_bGain_V_84;
    reg  [12:0] int_lsc_register_bGain_V_85;
    reg  [12:0] int_lsc_register_bGain_V_86;
    reg  [12:0] int_lsc_register_bGain_V_87;
    reg  [12:0] int_lsc_register_bGain_V_88;
    reg  [12:0] int_lsc_register_bGain_V_89;
    reg  [12:0] int_lsc_register_bGain_V_90;
    reg  [12:0] int_lsc_register_bGain_V_91;
    reg  [12:0] int_lsc_register_bGain_V_92;
    reg  [12:0] int_lsc_register_bGain_V_93;
    reg  [12:0] int_lsc_register_bGain_V_94;
    reg  [12:0] int_lsc_register_bGain_V_95;
    reg  [12:0] int_lsc_register_bGain_V_96;
    reg  [12:0] int_lsc_register_bGain_V_97;
    reg  [12:0] int_lsc_register_bGain_V_98;
    reg  [12:0] int_lsc_register_bGain_V_99;
    reg  [12:0] int_lsc_register_bGain_V_100;
    reg  [12:0] int_lsc_register_bGain_V_101;
    reg  [12:0] int_lsc_register_bGain_V_102;
    reg  [12:0] int_lsc_register_bGain_V_103;
    reg  [12:0] int_lsc_register_bGain_V_104;
    reg  [12:0] int_lsc_register_bGain_V_105;
    reg  [12:0] int_lsc_register_bGain_V_106;
    reg  [12:0] int_lsc_register_bGain_V_107;
    reg  [12:0] int_lsc_register_bGain_V_108;
    reg  [12:0] int_lsc_register_bGain_V_109;
    reg  [12:0] int_lsc_register_bGain_V_110;
    reg  [12:0] int_lsc_register_bGain_V_111;
    reg  [12:0] int_lsc_register_bGain_V_112;
    reg  [12:0] int_lsc_register_bGain_V_113;
    reg  [12:0] int_lsc_register_bGain_V_114;
    reg  [12:0] int_lsc_register_bGain_V_115;
    reg  [12:0] int_lsc_register_bGain_V_116;
    reg  [12:0] int_lsc_register_bGain_V_117;
    reg  [12:0] int_lsc_register_bGain_V_118;
    reg  [12:0] int_lsc_register_bGain_V_119;
    reg  [12:0] int_lsc_register_bGain_V_120;
    reg  [12:0] int_lsc_register_bGain_V_121;
    reg  [12:0] int_lsc_register_bGain_V_122;
    reg  [12:0] int_lsc_register_bGain_V_123;
    reg  [12:0] int_lsc_register_bGain_V_124;
    reg  [12:0] int_lsc_register_bGain_V_125;
    reg  [12:0] int_lsc_register_bGain_V_126;
    reg  [12:0] int_lsc_register_bGain_V_127;
    reg  [12:0] int_lsc_register_bGain_V_128;
    reg  [12:0] int_lsc_register_bGain_V_129;
    reg  [12:0] int_lsc_register_bGain_V_130;
    reg  [12:0] int_lsc_register_bGain_V_131;
    reg  [12:0] int_lsc_register_bGain_V_132;
    reg  [12:0] int_lsc_register_bGain_V_133;
    reg  [12:0] int_lsc_register_bGain_V_134;
    reg  [12:0] int_lsc_register_bGain_V_135;
    reg  [12:0] int_lsc_register_bGain_V_136;
    reg  [12:0] int_lsc_register_bGain_V_137;
    reg  [12:0] int_lsc_register_bGain_V_138;
    reg  [12:0] int_lsc_register_bGain_V_139;
    reg  [12:0] int_lsc_register_bGain_V_140;
    reg  [12:0] int_lsc_register_bGain_V_141;
    reg  [12:0] int_lsc_register_bGain_V_142;
    reg  [12:0] int_lsc_register_bGain_V_143;
    reg  [12:0] int_lsc_register_bGain_V_144;
    reg  [12:0] int_lsc_register_bGain_V_145;
    reg  [12:0] int_lsc_register_bGain_V_146;
    reg  [12:0] int_lsc_register_bGain_V_147;
    reg  [12:0] int_lsc_register_bGain_V_148;
    reg  [12:0] int_lsc_register_bGain_V_149;
    reg  [12:0] int_lsc_register_bGain_V_150;
    reg  [12:0] int_lsc_register_bGain_V_151;
    reg  [12:0] int_lsc_register_bGain_V_152;
    reg  [12:0] int_lsc_register_bGain_V_153;
    reg  [12:0] int_lsc_register_bGain_V_154;
    reg  [12:0] int_lsc_register_bGain_V_155;
    reg  [12:0] int_lsc_register_bGain_V_156;
    reg  [12:0] int_lsc_register_bGain_V_157;
    reg  [12:0] int_lsc_register_bGain_V_158;
    reg  [12:0] int_lsc_register_bGain_V_159;
    reg  [12:0] int_lsc_register_bGain_V_160;
    reg  [12:0] int_lsc_register_bGain_V_161;
    reg  [12:0] int_lsc_register_bGain_V_162;
    reg  [12:0] int_lsc_register_bGain_V_163;
    reg  [12:0] int_lsc_register_bGain_V_164;
    reg  [12:0] int_lsc_register_bGain_V_165;
    reg  [12:0] int_lsc_register_bGain_V_166;
    reg  [12:0] int_lsc_register_bGain_V_167;
    reg  [12:0] int_lsc_register_bGain_V_168;
    reg  [12:0] int_lsc_register_bGain_V_169;
    reg  [12:0] int_lsc_register_bGain_V_170;
    reg  [12:0] int_lsc_register_bGain_V_171;
    reg  [12:0] int_lsc_register_bGain_V_172;
    reg  [12:0] int_lsc_register_bGain_V_173;
    reg  [12:0] int_lsc_register_bGain_V_174;
    reg  [12:0] int_lsc_register_bGain_V_175;
    reg  [12:0] int_lsc_register_bGain_V_176;
    reg  [12:0] int_lsc_register_bGain_V_177;
    reg  [12:0] int_lsc_register_bGain_V_178;
    reg  [12:0] int_lsc_register_bGain_V_179;
    reg  [12:0] int_lsc_register_bGain_V_180;
    reg  [12:0] int_lsc_register_bGain_V_181;
    reg  [12:0] int_lsc_register_bGain_V_182;
    reg  [12:0] int_lsc_register_bGain_V_183;
    reg  [12:0] int_lsc_register_bGain_V_184;
    reg  [12:0] int_lsc_register_bGain_V_185;
    reg  [12:0] int_lsc_register_bGain_V_186;
    reg  [12:0] int_lsc_register_bGain_V_187;
    reg  [12:0] int_lsc_register_bGain_V_188;
    reg  [12:0] int_lsc_register_bGain_V_189;
    reg  [12:0] int_lsc_register_bGain_V_190;
    reg  [12:0] int_lsc_register_bGain_V_191;
    reg  [12:0] int_lsc_register_bGain_V_192;
    reg  [12:0] int_lsc_register_bGain_V_193;
    reg  [12:0] int_lsc_register_bGain_V_194;
    reg  [12:0] int_lsc_register_bGain_V_195;
    reg  [12:0] int_lsc_register_bGain_V_196;
    reg  [12:0] int_lsc_register_bGain_V_197;
    reg  [12:0] int_lsc_register_bGain_V_198;
    reg  [12:0] int_lsc_register_bGain_V_199;
    reg  [12:0] int_lsc_register_bGain_V_200;
    reg  [12:0] int_lsc_register_bGain_V_201;
    reg  [12:0] int_lsc_register_bGain_V_202;
    reg  [12:0] int_lsc_register_bGain_V_203;
    reg  [12:0] int_lsc_register_bGain_V_204;
    reg  [12:0] int_lsc_register_bGain_V_205;
    reg  [12:0] int_lsc_register_bGain_V_206;
    reg  [12:0] int_lsc_register_bGain_V_207;
    reg  [12:0] int_lsc_register_bGain_V_208;
    reg  [12:0] int_lsc_register_bGain_V_209;
    reg  [12:0] int_lsc_register_bGain_V_210;
    reg  [12:0] int_lsc_register_bGain_V_211;
    reg  [12:0] int_lsc_register_bGain_V_212;
    reg  [12:0] int_lsc_register_bGain_V_213;
    reg  [12:0] int_lsc_register_bGain_V_214;
    reg  [12:0] int_lsc_register_bGain_V_215;
    reg  [12:0] int_lsc_register_bGain_V_216;
    reg  [12:0] int_lsc_register_bGain_V_217;
    reg  [12:0] int_lsc_register_bGain_V_218;
    reg  [12:0] int_lsc_register_bGain_V_219;
    reg  [12:0] int_lsc_register_bGain_V_220;
    reg  [8:0] int_lsc_register_blockHeight_V;
    reg  [8:0] int_lsc_register_blockWidth_V;
    reg  [13:0] int_lsc_register_blockWidth_1_V;
    reg  [9:0] int_lsc_register_blockHeight_1_V;
    reg  [0:0] int_dpc_register_eb;
    reg  [10:0] int_dpc_register_th_w_V;
    reg  [10:0] int_dpc_register_th_b_V;
    reg  [5:0] int_rawdns_register_sigma_V;
    reg  [0:0] int_rawdns_register_eb_V;
    reg  [6:0] int_rawdns_register_Filterpara_V;
    reg  [11:0] int_rawdns_register_invksigma2_V;
    reg  [0:0] int_awb_register_m_nEb;
    reg  [14:0] int_awb_register_r_gain_V;
    reg  [14:0] int_awb_register_g_gain_V;
    reg  [14:0] int_awb_register_b_gain_V;
    reg  [4:0] int_awb_register_coeff_V;
    reg  [0:0] int_wbc_register_m_nEb;
    reg  [14:0] int_wbc_register_m_nR_V;
    reg  [14:0] int_wbc_register_m_nGr_V;
    reg  [14:0] int_wbc_register_m_nGb_V;
    reg  [14:0] int_wbc_register_m_nB_V;
    reg  [0:0] int_gb_register_eb;
    reg  [3:0] int_gb_register_win_size_V;
    reg  [3:0] int_gb_register_Lbound_V;
    reg  [5:0] int_gb_register_Hbound_V;
    reg  [9:0] int_gb_register_threhold_V;
    reg  [0:0] int_demosaic_register_eb;
    reg  [0:0] int_ee_register_eb;
    reg  [7:0] int_ee_register_coeff_V;
    reg  [0:0] int_cmc_register_m_nEb;
    reg  [15:0] int_cmc_register_m_nGain_V_0;
    reg  [15:0] int_cmc_register_m_nGain_V_1;
    reg  [15:0] int_cmc_register_m_nGain_V_2;
    reg  [15:0] int_cmc_register_m_nGain_V_3;
    reg  [15:0] int_cmc_register_m_nGain_V_4;
    reg  [15:0] int_cmc_register_m_nGain_V_5;
    reg  [15:0] int_cmc_register_m_nGain_V_6;
    reg  [15:0] int_cmc_register_m_nGain_V_7;
    reg  [15:0] int_cmc_register_m_nGain_V_8;
    reg  [15:0] int_cmc_register_m_nGain_V_9;
    reg  [15:0] int_cmc_register_m_nGain_V_10;
    reg  [15:0] int_cmc_register_m_nGain_V_11;
    reg  [0:0] int_cmc_register_m_bCFCEnable;
    reg  [0:0] int_cmc_register_m_bDiscardH;
    reg  [8:0] int_cmc_register_m_pHueRange_V_0;
    reg  [8:0] int_cmc_register_m_pHueRange_V_1;
    reg  [2:0] int_cmc_register_m_nHueBandShift_V;
    reg  [7:0] int_cmc_register_m_nEdgeThre_V;
    reg  [2:0] int_cmc_register_m_nEdgeBandShift_V;
    reg  [4:0] int_cmc_register_m_nCFCStrength_V;
    reg  [0:0] int_gtm_register_eb;
    reg  [0:0] int_gtm_register_m_bDitheringEnable;
    reg  [9:0] int_gtm_register_int_gtmTab_V_0;
    reg  [9:0] int_gtm_register_int_gtmTab_V_1;
    reg  [9:0] int_gtm_register_int_gtmTab_V_2;
    reg  [9:0] int_gtm_register_int_gtmTab_V_3;
    reg  [9:0] int_gtm_register_int_gtmTab_V_4;
    reg  [9:0] int_gtm_register_int_gtmTab_V_5;
    reg  [9:0] int_gtm_register_int_gtmTab_V_6;
    reg  [9:0] int_gtm_register_int_gtmTab_V_7;
    reg  [9:0] int_gtm_register_int_gtmTab_V_8;
    reg  [9:0] int_gtm_register_int_gtmTab_V_9;
    reg  [9:0] int_gtm_register_int_gtmTab_V_10;
    reg  [9:0] int_gtm_register_int_gtmTab_V_11;
    reg  [9:0] int_gtm_register_int_gtmTab_V_12;
    reg  [9:0] int_gtm_register_int_gtmTab_V_13;
    reg  [9:0] int_gtm_register_int_gtmTab_V_14;
    reg  [9:0] int_gtm_register_int_gtmTab_V_15;
    reg  [9:0] int_gtm_register_int_gtmTab_V_16;
    reg  [9:0] int_gtm_register_int_gtmTab_V_17;
    reg  [9:0] int_gtm_register_int_gtmTab_V_18;
    reg  [9:0] int_gtm_register_int_gtmTab_V_19;
    reg  [9:0] int_gtm_register_int_gtmTab_V_20;
    reg  [9:0] int_gtm_register_int_gtmTab_V_21;
    reg  [9:0] int_gtm_register_int_gtmTab_V_22;
    reg  [9:0] int_gtm_register_int_gtmTab_V_23;
    reg  [9:0] int_gtm_register_int_gtmTab_V_24;
    reg  [9:0] int_gtm_register_int_gtmTab_V_25;
    reg  [9:0] int_gtm_register_int_gtmTab_V_26;
    reg  [9:0] int_gtm_register_int_gtmTab_V_27;
    reg  [9:0] int_gtm_register_int_gtmTab_V_28;
    reg  [9:0] int_gtm_register_int_gtmTab_V_29;
    reg  [9:0] int_gtm_register_int_gtmTab_V_30;
    reg  [9:0] int_gtm_register_int_gtmTab_V_31;
    reg  [9:0] int_gtm_register_int_gtmTab_V_32;
    reg  [9:0] int_gtm_register_int_gtmTab_V_33;
    reg  [9:0] int_gtm_register_int_gtmTab_V_34;
    reg  [9:0] int_gtm_register_int_gtmTab_V_35;
    reg  [9:0] int_gtm_register_int_gtmTab_V_36;
    reg  [9:0] int_gtm_register_int_gtmTab_V_37;
    reg  [9:0] int_gtm_register_int_gtmTab_V_38;
    reg  [9:0] int_gtm_register_int_gtmTab_V_39;
    reg  [9:0] int_gtm_register_int_gtmTab_V_40;
    reg  [9:0] int_gtm_register_int_gtmTab_V_41;
    reg  [9:0] int_gtm_register_int_gtmTab_V_42;
    reg  [9:0] int_gtm_register_int_gtmTab_V_43;
    reg  [9:0] int_gtm_register_int_gtmTab_V_44;
    reg  [9:0] int_gtm_register_int_gtmTab_V_45;
    reg  [9:0] int_gtm_register_int_gtmTab_V_46;
    reg  [9:0] int_gtm_register_int_gtmTab_V_47;
    reg  [9:0] int_gtm_register_int_gtmTab_V_48;
    reg  [9:0] int_gtm_register_int_gtmTab_V_49;
    reg  [9:0] int_gtm_register_int_gtmTab_V_50;
    reg  [9:0] int_gtm_register_int_gtmTab_V_51;
    reg  [9:0] int_gtm_register_int_gtmTab_V_52;
    reg  [9:0] int_gtm_register_int_gtmTab_V_53;
    reg  [9:0] int_gtm_register_int_gtmTab_V_54;
    reg  [9:0] int_gtm_register_int_gtmTab_V_55;
    reg  [9:0] int_gtm_register_int_gtmTab_V_56;
    reg  [9:0] int_gtm_register_int_gtmTab_V_57;
    reg  [9:0] int_gtm_register_int_gtmTab_V_58;
    reg  [9:0] int_gtm_register_int_gtmTab_V_59;
    reg  [9:0] int_gtm_register_int_gtmTab_V_60;
    reg  [9:0] int_gtm_register_int_gtmTab_V_61;
    reg  [9:0] int_gtm_register_int_gtmTab_V_62;
    reg  [9:0] int_gtm_register_int_gtmTab_V_63;
    reg  [9:0] int_gtm_register_int_gtmTab_V_64;
    reg  [9:0] int_gtm_register_int_gtmTab_V_65;
    reg  [9:0] int_gtm_register_int_gtmTab_V_66;
    reg  [9:0] int_gtm_register_int_gtmTab_V_67;
    reg  [9:0] int_gtm_register_int_gtmTab_V_68;
    reg  [9:0] int_gtm_register_int_gtmTab_V_69;
    reg  [9:0] int_gtm_register_int_gtmTab_V_70;
    reg  [9:0] int_gtm_register_int_gtmTab_V_71;
    reg  [9:0] int_gtm_register_int_gtmTab_V_72;
    reg  [9:0] int_gtm_register_int_gtmTab_V_73;
    reg  [9:0] int_gtm_register_int_gtmTab_V_74;
    reg  [9:0] int_gtm_register_int_gtmTab_V_75;
    reg  [9:0] int_gtm_register_int_gtmTab_V_76;
    reg  [9:0] int_gtm_register_int_gtmTab_V_77;
    reg  [9:0] int_gtm_register_int_gtmTab_V_78;
    reg  [9:0] int_gtm_register_int_gtmTab_V_79;
    reg  [9:0] int_gtm_register_int_gtmTab_V_80;
    reg  [9:0] int_gtm_register_int_gtmTab_V_81;
    reg  [9:0] int_gtm_register_int_gtmTab_V_82;
    reg  [9:0] int_gtm_register_int_gtmTab_V_83;
    reg  [9:0] int_gtm_register_int_gtmTab_V_84;
    reg  [9:0] int_gtm_register_int_gtmTab_V_85;
    reg  [9:0] int_gtm_register_int_gtmTab_V_86;
    reg  [9:0] int_gtm_register_int_gtmTab_V_87;
    reg  [9:0] int_gtm_register_int_gtmTab_V_88;
    reg  [9:0] int_gtm_register_int_gtmTab_V_89;
    reg  [9:0] int_gtm_register_int_gtmTab_V_90;
    reg  [9:0] int_gtm_register_int_gtmTab_V_91;
    reg  [9:0] int_gtm_register_int_gtmTab_V_92;
    reg  [9:0] int_gtm_register_int_gtmTab_V_93;
    reg  [9:0] int_gtm_register_int_gtmTab_V_94;
    reg  [9:0] int_gtm_register_int_gtmTab_V_95;
    reg  [9:0] int_gtm_register_int_gtmTab_V_96;
    reg  [9:0] int_gtm_register_int_gtmTab_V_97;
    reg  [9:0] int_gtm_register_int_gtmTab_V_98;
    reg  [9:0] int_gtm_register_int_gtmTab_V_99;
    reg  [9:0] int_gtm_register_int_gtmTab_V_100;
    reg  [9:0] int_gtm_register_int_gtmTab_V_101;
    reg  [9:0] int_gtm_register_int_gtmTab_V_102;
    reg  [9:0] int_gtm_register_int_gtmTab_V_103;
    reg  [9:0] int_gtm_register_int_gtmTab_V_104;
    reg  [9:0] int_gtm_register_int_gtmTab_V_105;
    reg  [9:0] int_gtm_register_int_gtmTab_V_106;
    reg  [9:0] int_gtm_register_int_gtmTab_V_107;
    reg  [9:0] int_gtm_register_int_gtmTab_V_108;
    reg  [9:0] int_gtm_register_int_gtmTab_V_109;
    reg  [9:0] int_gtm_register_int_gtmTab_V_110;
    reg  [9:0] int_gtm_register_int_gtmTab_V_111;
    reg  [9:0] int_gtm_register_int_gtmTab_V_112;
    reg  [9:0] int_gtm_register_int_gtmTab_V_113;
    reg  [9:0] int_gtm_register_int_gtmTab_V_114;
    reg  [9:0] int_gtm_register_int_gtmTab_V_115;
    reg  [9:0] int_gtm_register_int_gtmTab_V_116;
    reg  [9:0] int_gtm_register_int_gtmTab_V_117;
    reg  [9:0] int_gtm_register_int_gtmTab_V_118;
    reg  [9:0] int_gtm_register_int_gtmTab_V_119;
    reg  [9:0] int_gtm_register_int_gtmTab_V_120;
    reg  [9:0] int_gtm_register_int_gtmTab_V_121;
    reg  [9:0] int_gtm_register_int_gtmTab_V_122;
    reg  [9:0] int_gtm_register_int_gtmTab_V_123;
    reg  [9:0] int_gtm_register_int_gtmTab_V_124;
    reg  [9:0] int_gtm_register_int_gtmTab_V_125;
    reg  [9:0] int_gtm_register_int_gtmTab_V_126;
    reg  [9:0] int_gtm_register_int_gtmTab_V_127;
    reg  [9:0] int_gtm_register_int_gtmTab_V_128;
    reg  [0:0] int_ltm_register_m_nEb_V;
    reg  [15:0] int_ltm_register_contrast_V;
    reg  [15:0] int_ltm_register_ratio_V;
    reg  [0:0] int_cac_register_eb;
    reg  [16:0] int_cac_register_t_transient_V;
    reg  [16:0] int_cac_register_t_edge_V;
    reg  [0:0] int_csc_register_m_nEb;
    reg  [10:0] int_csc_register_coeff_V_0;
    reg  [10:0] int_csc_register_coeff_V_1;
    reg  [10:0] int_csc_register_coeff_V_2;
    reg  [10:0] int_csc_register_coeff_V_3;
    reg  [10:0] int_csc_register_coeff_V_4;
    reg  [10:0] int_csc_register_coeff_V_5;
    reg  [10:0] int_csc_register_coeff_V_6;
    reg  [10:0] int_csc_register_coeff_V_7;
    reg  [10:0] int_csc_register_coeff_V_8;
    reg  [10:0] int_csc_register_coeff_V_9;
    reg  [10:0] int_csc_register_coeff_V_10;
    reg  [10:0] int_csc_register_coeff_V_11;
    reg  [0:0] int_yfc_register_m_nEb;
    reg  [0:0] int_yfc_register_yuvpattern;
    reg  [0:0] int_yuvdns_register_eb_V;
    reg  [13:0] int_yuvdns_register_ysigma2_V;
    reg  [9:0] int_yuvdns_register_yinvsigma2_V;
    reg  [13:0] int_yuvdns_register_uvsigma2_V;
    reg  [9:0] int_yuvdns_register_uvinvsigma2_V;
    reg  [3:0] int_yuvdns_register_yfilt_V;
    reg  [3:0] int_yuvdns_register_uvfilt_V;
    reg  [4:0] int_yuvdns_register_yinvfilt_V;
    reg  [4:0] int_yuvdns_register_uvinvfilt_V;
    reg  [13:0] int_yuvdns_register_yH2_V;
    reg  [17:0] int_yuvdns_register_yinvH2_V;
    reg  [13:0] int_yuvdns_register_uvH2_V;
    reg  [17:0] int_yuvdns_register_uvinvH2_V;
    reg  [0:0] int_scaledown_register_m_nEb;
    reg  [1:0] int_scaledown_register_yuvpattern_V;
    reg  [4:0] int_scaledown_register_times_V;
    reg  [0:0] int_crop_register_m_nEb;
    reg  [12:0] int_crop_register_upper_left_x_V;
    reg  [12:0] int_crop_register_upper_left_y_V;
    reg  [12:0] int_crop_register_lower_right_x_V;
    reg  [12:0] int_crop_register_lower_right_y_V;
    reg  [1:0] int_crop_register_yuvpattern_V;

    reg  [31:0] int_isp_read_raw_addr;
    reg  [31:0] int_isp_write_y_addr;
    reg  [31:0] int_isp_write_u_addr;
    reg  [31:0] int_isp_write_v_addr;
    reg  [31:0] int_burst_one_frame_total;

//---------------------Assign reg to output---------------------------
    assign top_register_frameWidth_V=int_top_register_frameWidth_V;
    assign top_register_frameHeight_V=int_top_register_frameHeight_V;
    assign top_register_inputFormat=int_top_register_inputFormat;
    assign top_register_imgPattern_V=int_top_register_imgPattern_V;
    assign top_register_pipeMode_V=int_top_register_pipeMode_V;
    assign top_register_blc_V=int_top_register_blc_V;
    assign top_register_shadowEb=int_top_register_shadowEb;
    assign top_register_binningFrameWidth_V=int_top_register_binningFrameWidth_V;
    assign top_register_binningFrameHeight_V=int_top_register_binningFrameHeight_V;
    assign top_register_scalerFrameWidth_V=int_top_register_scalerFrameWidth_V;
    assign top_register_scalerFrameHeight_V=int_top_register_scalerFrameHeight_V;
    assign tpg_register_m_bTPG_en=int_tpg_register_m_bTPG_en;
    assign tpg_register_m_nWidth_V=int_tpg_register_m_nWidth_V;
    assign tpg_register_m_nHeight_V=int_tpg_register_m_nHeight_V;
    assign tpg_register_m_nCFAPattern_V=int_tpg_register_m_nCFAPattern_V;
    assign tpg_register_m_bRollingEnable=int_tpg_register_m_bRollingEnable;
    assign tpg_register_m_bSensor_timing_en=int_tpg_register_m_bSensor_timing_en;
    assign tpg_register_m_nVBlank_num_V=int_tpg_register_m_nVBlank_num_V;
    assign tpg_register_m_nHBlank_num_V=int_tpg_register_m_nHBlank_num_V;
    assign tpg_register_m_valid_blank_V=int_tpg_register_m_valid_blank_V;
    assign tpg_register_m_nID_V=int_tpg_register_m_nID_V;
    assign dgain_register_m_nEb=int_dgain_register_m_nEb;
    assign dgain_register_m_nBlcR_V=int_dgain_register_m_nBlcR_V;
    assign dgain_register_m_nBlcGr_V=int_dgain_register_m_nBlcGr_V;
    assign dgain_register_m_nBlcGb_V=int_dgain_register_m_nBlcGb_V;
    assign dgain_register_m_nBlcB_V=int_dgain_register_m_nBlcB_V;
    assign dgain_register_m_nR_V=int_dgain_register_m_nR_V;
    assign dgain_register_m_nGr_V=int_dgain_register_m_nGr_V;
    assign dgain_register_m_nGb_V=int_dgain_register_m_nGb_V;
    assign dgain_register_m_nB_V=int_dgain_register_m_nB_V;
    assign lsc_register_eb=int_lsc_register_eb;
    assign lsc_register_rGain_V_0=int_lsc_register_rGain_V_0;
    assign lsc_register_rGain_V_1=int_lsc_register_rGain_V_1;
    assign lsc_register_rGain_V_2=int_lsc_register_rGain_V_2;
    assign lsc_register_rGain_V_3=int_lsc_register_rGain_V_3;
    assign lsc_register_rGain_V_4=int_lsc_register_rGain_V_4;
    assign lsc_register_rGain_V_5=int_lsc_register_rGain_V_5;
    assign lsc_register_rGain_V_6=int_lsc_register_rGain_V_6;
    assign lsc_register_rGain_V_7=int_lsc_register_rGain_V_7;
    assign lsc_register_rGain_V_8=int_lsc_register_rGain_V_8;
    assign lsc_register_rGain_V_9=int_lsc_register_rGain_V_9;
    assign lsc_register_rGain_V_10=int_lsc_register_rGain_V_10;
    assign lsc_register_rGain_V_11=int_lsc_register_rGain_V_11;
    assign lsc_register_rGain_V_12=int_lsc_register_rGain_V_12;
    assign lsc_register_rGain_V_13=int_lsc_register_rGain_V_13;
    assign lsc_register_rGain_V_14=int_lsc_register_rGain_V_14;
    assign lsc_register_rGain_V_15=int_lsc_register_rGain_V_15;
    assign lsc_register_rGain_V_16=int_lsc_register_rGain_V_16;
    assign lsc_register_rGain_V_17=int_lsc_register_rGain_V_17;
    assign lsc_register_rGain_V_18=int_lsc_register_rGain_V_18;
    assign lsc_register_rGain_V_19=int_lsc_register_rGain_V_19;
    assign lsc_register_rGain_V_20=int_lsc_register_rGain_V_20;
    assign lsc_register_rGain_V_21=int_lsc_register_rGain_V_21;
    assign lsc_register_rGain_V_22=int_lsc_register_rGain_V_22;
    assign lsc_register_rGain_V_23=int_lsc_register_rGain_V_23;
    assign lsc_register_rGain_V_24=int_lsc_register_rGain_V_24;
    assign lsc_register_rGain_V_25=int_lsc_register_rGain_V_25;
    assign lsc_register_rGain_V_26=int_lsc_register_rGain_V_26;
    assign lsc_register_rGain_V_27=int_lsc_register_rGain_V_27;
    assign lsc_register_rGain_V_28=int_lsc_register_rGain_V_28;
    assign lsc_register_rGain_V_29=int_lsc_register_rGain_V_29;
    assign lsc_register_rGain_V_30=int_lsc_register_rGain_V_30;
    assign lsc_register_rGain_V_31=int_lsc_register_rGain_V_31;
    assign lsc_register_rGain_V_32=int_lsc_register_rGain_V_32;
    assign lsc_register_rGain_V_33=int_lsc_register_rGain_V_33;
    assign lsc_register_rGain_V_34=int_lsc_register_rGain_V_34;
    assign lsc_register_rGain_V_35=int_lsc_register_rGain_V_35;
    assign lsc_register_rGain_V_36=int_lsc_register_rGain_V_36;
    assign lsc_register_rGain_V_37=int_lsc_register_rGain_V_37;
    assign lsc_register_rGain_V_38=int_lsc_register_rGain_V_38;
    assign lsc_register_rGain_V_39=int_lsc_register_rGain_V_39;
    assign lsc_register_rGain_V_40=int_lsc_register_rGain_V_40;
    assign lsc_register_rGain_V_41=int_lsc_register_rGain_V_41;
    assign lsc_register_rGain_V_42=int_lsc_register_rGain_V_42;
    assign lsc_register_rGain_V_43=int_lsc_register_rGain_V_43;
    assign lsc_register_rGain_V_44=int_lsc_register_rGain_V_44;
    assign lsc_register_rGain_V_45=int_lsc_register_rGain_V_45;
    assign lsc_register_rGain_V_46=int_lsc_register_rGain_V_46;
    assign lsc_register_rGain_V_47=int_lsc_register_rGain_V_47;
    assign lsc_register_rGain_V_48=int_lsc_register_rGain_V_48;
    assign lsc_register_rGain_V_49=int_lsc_register_rGain_V_49;
    assign lsc_register_rGain_V_50=int_lsc_register_rGain_V_50;
    assign lsc_register_rGain_V_51=int_lsc_register_rGain_V_51;
    assign lsc_register_rGain_V_52=int_lsc_register_rGain_V_52;
    assign lsc_register_rGain_V_53=int_lsc_register_rGain_V_53;
    assign lsc_register_rGain_V_54=int_lsc_register_rGain_V_54;
    assign lsc_register_rGain_V_55=int_lsc_register_rGain_V_55;
    assign lsc_register_rGain_V_56=int_lsc_register_rGain_V_56;
    assign lsc_register_rGain_V_57=int_lsc_register_rGain_V_57;
    assign lsc_register_rGain_V_58=int_lsc_register_rGain_V_58;
    assign lsc_register_rGain_V_59=int_lsc_register_rGain_V_59;
    assign lsc_register_rGain_V_60=int_lsc_register_rGain_V_60;
    assign lsc_register_rGain_V_61=int_lsc_register_rGain_V_61;
    assign lsc_register_rGain_V_62=int_lsc_register_rGain_V_62;
    assign lsc_register_rGain_V_63=int_lsc_register_rGain_V_63;
    assign lsc_register_rGain_V_64=int_lsc_register_rGain_V_64;
    assign lsc_register_rGain_V_65=int_lsc_register_rGain_V_65;
    assign lsc_register_rGain_V_66=int_lsc_register_rGain_V_66;
    assign lsc_register_rGain_V_67=int_lsc_register_rGain_V_67;
    assign lsc_register_rGain_V_68=int_lsc_register_rGain_V_68;
    assign lsc_register_rGain_V_69=int_lsc_register_rGain_V_69;
    assign lsc_register_rGain_V_70=int_lsc_register_rGain_V_70;
    assign lsc_register_rGain_V_71=int_lsc_register_rGain_V_71;
    assign lsc_register_rGain_V_72=int_lsc_register_rGain_V_72;
    assign lsc_register_rGain_V_73=int_lsc_register_rGain_V_73;
    assign lsc_register_rGain_V_74=int_lsc_register_rGain_V_74;
    assign lsc_register_rGain_V_75=int_lsc_register_rGain_V_75;
    assign lsc_register_rGain_V_76=int_lsc_register_rGain_V_76;
    assign lsc_register_rGain_V_77=int_lsc_register_rGain_V_77;
    assign lsc_register_rGain_V_78=int_lsc_register_rGain_V_78;
    assign lsc_register_rGain_V_79=int_lsc_register_rGain_V_79;
    assign lsc_register_rGain_V_80=int_lsc_register_rGain_V_80;
    assign lsc_register_rGain_V_81=int_lsc_register_rGain_V_81;
    assign lsc_register_rGain_V_82=int_lsc_register_rGain_V_82;
    assign lsc_register_rGain_V_83=int_lsc_register_rGain_V_83;
    assign lsc_register_rGain_V_84=int_lsc_register_rGain_V_84;
    assign lsc_register_rGain_V_85=int_lsc_register_rGain_V_85;
    assign lsc_register_rGain_V_86=int_lsc_register_rGain_V_86;
    assign lsc_register_rGain_V_87=int_lsc_register_rGain_V_87;
    assign lsc_register_rGain_V_88=int_lsc_register_rGain_V_88;
    assign lsc_register_rGain_V_89=int_lsc_register_rGain_V_89;
    assign lsc_register_rGain_V_90=int_lsc_register_rGain_V_90;
    assign lsc_register_rGain_V_91=int_lsc_register_rGain_V_91;
    assign lsc_register_rGain_V_92=int_lsc_register_rGain_V_92;
    assign lsc_register_rGain_V_93=int_lsc_register_rGain_V_93;
    assign lsc_register_rGain_V_94=int_lsc_register_rGain_V_94;
    assign lsc_register_rGain_V_95=int_lsc_register_rGain_V_95;
    assign lsc_register_rGain_V_96=int_lsc_register_rGain_V_96;
    assign lsc_register_rGain_V_97=int_lsc_register_rGain_V_97;
    assign lsc_register_rGain_V_98=int_lsc_register_rGain_V_98;
    assign lsc_register_rGain_V_99=int_lsc_register_rGain_V_99;
    assign lsc_register_rGain_V_100=int_lsc_register_rGain_V_100;
    assign lsc_register_rGain_V_101=int_lsc_register_rGain_V_101;
    assign lsc_register_rGain_V_102=int_lsc_register_rGain_V_102;
    assign lsc_register_rGain_V_103=int_lsc_register_rGain_V_103;
    assign lsc_register_rGain_V_104=int_lsc_register_rGain_V_104;
    assign lsc_register_rGain_V_105=int_lsc_register_rGain_V_105;
    assign lsc_register_rGain_V_106=int_lsc_register_rGain_V_106;
    assign lsc_register_rGain_V_107=int_lsc_register_rGain_V_107;
    assign lsc_register_rGain_V_108=int_lsc_register_rGain_V_108;
    assign lsc_register_rGain_V_109=int_lsc_register_rGain_V_109;
    assign lsc_register_rGain_V_110=int_lsc_register_rGain_V_110;
    assign lsc_register_rGain_V_111=int_lsc_register_rGain_V_111;
    assign lsc_register_rGain_V_112=int_lsc_register_rGain_V_112;
    assign lsc_register_rGain_V_113=int_lsc_register_rGain_V_113;
    assign lsc_register_rGain_V_114=int_lsc_register_rGain_V_114;
    assign lsc_register_rGain_V_115=int_lsc_register_rGain_V_115;
    assign lsc_register_rGain_V_116=int_lsc_register_rGain_V_116;
    assign lsc_register_rGain_V_117=int_lsc_register_rGain_V_117;
    assign lsc_register_rGain_V_118=int_lsc_register_rGain_V_118;
    assign lsc_register_rGain_V_119=int_lsc_register_rGain_V_119;
    assign lsc_register_rGain_V_120=int_lsc_register_rGain_V_120;
    assign lsc_register_rGain_V_121=int_lsc_register_rGain_V_121;
    assign lsc_register_rGain_V_122=int_lsc_register_rGain_V_122;
    assign lsc_register_rGain_V_123=int_lsc_register_rGain_V_123;
    assign lsc_register_rGain_V_124=int_lsc_register_rGain_V_124;
    assign lsc_register_rGain_V_125=int_lsc_register_rGain_V_125;
    assign lsc_register_rGain_V_126=int_lsc_register_rGain_V_126;
    assign lsc_register_rGain_V_127=int_lsc_register_rGain_V_127;
    assign lsc_register_rGain_V_128=int_lsc_register_rGain_V_128;
    assign lsc_register_rGain_V_129=int_lsc_register_rGain_V_129;
    assign lsc_register_rGain_V_130=int_lsc_register_rGain_V_130;
    assign lsc_register_rGain_V_131=int_lsc_register_rGain_V_131;
    assign lsc_register_rGain_V_132=int_lsc_register_rGain_V_132;
    assign lsc_register_rGain_V_133=int_lsc_register_rGain_V_133;
    assign lsc_register_rGain_V_134=int_lsc_register_rGain_V_134;
    assign lsc_register_rGain_V_135=int_lsc_register_rGain_V_135;
    assign lsc_register_rGain_V_136=int_lsc_register_rGain_V_136;
    assign lsc_register_rGain_V_137=int_lsc_register_rGain_V_137;
    assign lsc_register_rGain_V_138=int_lsc_register_rGain_V_138;
    assign lsc_register_rGain_V_139=int_lsc_register_rGain_V_139;
    assign lsc_register_rGain_V_140=int_lsc_register_rGain_V_140;
    assign lsc_register_rGain_V_141=int_lsc_register_rGain_V_141;
    assign lsc_register_rGain_V_142=int_lsc_register_rGain_V_142;
    assign lsc_register_rGain_V_143=int_lsc_register_rGain_V_143;
    assign lsc_register_rGain_V_144=int_lsc_register_rGain_V_144;
    assign lsc_register_rGain_V_145=int_lsc_register_rGain_V_145;
    assign lsc_register_rGain_V_146=int_lsc_register_rGain_V_146;
    assign lsc_register_rGain_V_147=int_lsc_register_rGain_V_147;
    assign lsc_register_rGain_V_148=int_lsc_register_rGain_V_148;
    assign lsc_register_rGain_V_149=int_lsc_register_rGain_V_149;
    assign lsc_register_rGain_V_150=int_lsc_register_rGain_V_150;
    assign lsc_register_rGain_V_151=int_lsc_register_rGain_V_151;
    assign lsc_register_rGain_V_152=int_lsc_register_rGain_V_152;
    assign lsc_register_rGain_V_153=int_lsc_register_rGain_V_153;
    assign lsc_register_rGain_V_154=int_lsc_register_rGain_V_154;
    assign lsc_register_rGain_V_155=int_lsc_register_rGain_V_155;
    assign lsc_register_rGain_V_156=int_lsc_register_rGain_V_156;
    assign lsc_register_rGain_V_157=int_lsc_register_rGain_V_157;
    assign lsc_register_rGain_V_158=int_lsc_register_rGain_V_158;
    assign lsc_register_rGain_V_159=int_lsc_register_rGain_V_159;
    assign lsc_register_rGain_V_160=int_lsc_register_rGain_V_160;
    assign lsc_register_rGain_V_161=int_lsc_register_rGain_V_161;
    assign lsc_register_rGain_V_162=int_lsc_register_rGain_V_162;
    assign lsc_register_rGain_V_163=int_lsc_register_rGain_V_163;
    assign lsc_register_rGain_V_164=int_lsc_register_rGain_V_164;
    assign lsc_register_rGain_V_165=int_lsc_register_rGain_V_165;
    assign lsc_register_rGain_V_166=int_lsc_register_rGain_V_166;
    assign lsc_register_rGain_V_167=int_lsc_register_rGain_V_167;
    assign lsc_register_rGain_V_168=int_lsc_register_rGain_V_168;
    assign lsc_register_rGain_V_169=int_lsc_register_rGain_V_169;
    assign lsc_register_rGain_V_170=int_lsc_register_rGain_V_170;
    assign lsc_register_rGain_V_171=int_lsc_register_rGain_V_171;
    assign lsc_register_rGain_V_172=int_lsc_register_rGain_V_172;
    assign lsc_register_rGain_V_173=int_lsc_register_rGain_V_173;
    assign lsc_register_rGain_V_174=int_lsc_register_rGain_V_174;
    assign lsc_register_rGain_V_175=int_lsc_register_rGain_V_175;
    assign lsc_register_rGain_V_176=int_lsc_register_rGain_V_176;
    assign lsc_register_rGain_V_177=int_lsc_register_rGain_V_177;
    assign lsc_register_rGain_V_178=int_lsc_register_rGain_V_178;
    assign lsc_register_rGain_V_179=int_lsc_register_rGain_V_179;
    assign lsc_register_rGain_V_180=int_lsc_register_rGain_V_180;
    assign lsc_register_rGain_V_181=int_lsc_register_rGain_V_181;
    assign lsc_register_rGain_V_182=int_lsc_register_rGain_V_182;
    assign lsc_register_rGain_V_183=int_lsc_register_rGain_V_183;
    assign lsc_register_rGain_V_184=int_lsc_register_rGain_V_184;
    assign lsc_register_rGain_V_185=int_lsc_register_rGain_V_185;
    assign lsc_register_rGain_V_186=int_lsc_register_rGain_V_186;
    assign lsc_register_rGain_V_187=int_lsc_register_rGain_V_187;
    assign lsc_register_rGain_V_188=int_lsc_register_rGain_V_188;
    assign lsc_register_rGain_V_189=int_lsc_register_rGain_V_189;
    assign lsc_register_rGain_V_190=int_lsc_register_rGain_V_190;
    assign lsc_register_rGain_V_191=int_lsc_register_rGain_V_191;
    assign lsc_register_rGain_V_192=int_lsc_register_rGain_V_192;
    assign lsc_register_rGain_V_193=int_lsc_register_rGain_V_193;
    assign lsc_register_rGain_V_194=int_lsc_register_rGain_V_194;
    assign lsc_register_rGain_V_195=int_lsc_register_rGain_V_195;
    assign lsc_register_rGain_V_196=int_lsc_register_rGain_V_196;
    assign lsc_register_rGain_V_197=int_lsc_register_rGain_V_197;
    assign lsc_register_rGain_V_198=int_lsc_register_rGain_V_198;
    assign lsc_register_rGain_V_199=int_lsc_register_rGain_V_199;
    assign lsc_register_rGain_V_200=int_lsc_register_rGain_V_200;
    assign lsc_register_rGain_V_201=int_lsc_register_rGain_V_201;
    assign lsc_register_rGain_V_202=int_lsc_register_rGain_V_202;
    assign lsc_register_rGain_V_203=int_lsc_register_rGain_V_203;
    assign lsc_register_rGain_V_204=int_lsc_register_rGain_V_204;
    assign lsc_register_rGain_V_205=int_lsc_register_rGain_V_205;
    assign lsc_register_rGain_V_206=int_lsc_register_rGain_V_206;
    assign lsc_register_rGain_V_207=int_lsc_register_rGain_V_207;
    assign lsc_register_rGain_V_208=int_lsc_register_rGain_V_208;
    assign lsc_register_rGain_V_209=int_lsc_register_rGain_V_209;
    assign lsc_register_rGain_V_210=int_lsc_register_rGain_V_210;
    assign lsc_register_rGain_V_211=int_lsc_register_rGain_V_211;
    assign lsc_register_rGain_V_212=int_lsc_register_rGain_V_212;
    assign lsc_register_rGain_V_213=int_lsc_register_rGain_V_213;
    assign lsc_register_rGain_V_214=int_lsc_register_rGain_V_214;
    assign lsc_register_rGain_V_215=int_lsc_register_rGain_V_215;
    assign lsc_register_rGain_V_216=int_lsc_register_rGain_V_216;
    assign lsc_register_rGain_V_217=int_lsc_register_rGain_V_217;
    assign lsc_register_rGain_V_218=int_lsc_register_rGain_V_218;
    assign lsc_register_rGain_V_219=int_lsc_register_rGain_V_219;
    assign lsc_register_rGain_V_220=int_lsc_register_rGain_V_220;
    assign lsc_register_GrGain_V_0=int_lsc_register_GrGain_V_0;
    assign lsc_register_GrGain_V_1=int_lsc_register_GrGain_V_1;
    assign lsc_register_GrGain_V_2=int_lsc_register_GrGain_V_2;
    assign lsc_register_GrGain_V_3=int_lsc_register_GrGain_V_3;
    assign lsc_register_GrGain_V_4=int_lsc_register_GrGain_V_4;
    assign lsc_register_GrGain_V_5=int_lsc_register_GrGain_V_5;
    assign lsc_register_GrGain_V_6=int_lsc_register_GrGain_V_6;
    assign lsc_register_GrGain_V_7=int_lsc_register_GrGain_V_7;
    assign lsc_register_GrGain_V_8=int_lsc_register_GrGain_V_8;
    assign lsc_register_GrGain_V_9=int_lsc_register_GrGain_V_9;
    assign lsc_register_GrGain_V_10=int_lsc_register_GrGain_V_10;
    assign lsc_register_GrGain_V_11=int_lsc_register_GrGain_V_11;
    assign lsc_register_GrGain_V_12=int_lsc_register_GrGain_V_12;
    assign lsc_register_GrGain_V_13=int_lsc_register_GrGain_V_13;
    assign lsc_register_GrGain_V_14=int_lsc_register_GrGain_V_14;
    assign lsc_register_GrGain_V_15=int_lsc_register_GrGain_V_15;
    assign lsc_register_GrGain_V_16=int_lsc_register_GrGain_V_16;
    assign lsc_register_GrGain_V_17=int_lsc_register_GrGain_V_17;
    assign lsc_register_GrGain_V_18=int_lsc_register_GrGain_V_18;
    assign lsc_register_GrGain_V_19=int_lsc_register_GrGain_V_19;
    assign lsc_register_GrGain_V_20=int_lsc_register_GrGain_V_20;
    assign lsc_register_GrGain_V_21=int_lsc_register_GrGain_V_21;
    assign lsc_register_GrGain_V_22=int_lsc_register_GrGain_V_22;
    assign lsc_register_GrGain_V_23=int_lsc_register_GrGain_V_23;
    assign lsc_register_GrGain_V_24=int_lsc_register_GrGain_V_24;
    assign lsc_register_GrGain_V_25=int_lsc_register_GrGain_V_25;
    assign lsc_register_GrGain_V_26=int_lsc_register_GrGain_V_26;
    assign lsc_register_GrGain_V_27=int_lsc_register_GrGain_V_27;
    assign lsc_register_GrGain_V_28=int_lsc_register_GrGain_V_28;
    assign lsc_register_GrGain_V_29=int_lsc_register_GrGain_V_29;
    assign lsc_register_GrGain_V_30=int_lsc_register_GrGain_V_30;
    assign lsc_register_GrGain_V_31=int_lsc_register_GrGain_V_31;
    assign lsc_register_GrGain_V_32=int_lsc_register_GrGain_V_32;
    assign lsc_register_GrGain_V_33=int_lsc_register_GrGain_V_33;
    assign lsc_register_GrGain_V_34=int_lsc_register_GrGain_V_34;
    assign lsc_register_GrGain_V_35=int_lsc_register_GrGain_V_35;
    assign lsc_register_GrGain_V_36=int_lsc_register_GrGain_V_36;
    assign lsc_register_GrGain_V_37=int_lsc_register_GrGain_V_37;
    assign lsc_register_GrGain_V_38=int_lsc_register_GrGain_V_38;
    assign lsc_register_GrGain_V_39=int_lsc_register_GrGain_V_39;
    assign lsc_register_GrGain_V_40=int_lsc_register_GrGain_V_40;
    assign lsc_register_GrGain_V_41=int_lsc_register_GrGain_V_41;
    assign lsc_register_GrGain_V_42=int_lsc_register_GrGain_V_42;
    assign lsc_register_GrGain_V_43=int_lsc_register_GrGain_V_43;
    assign lsc_register_GrGain_V_44=int_lsc_register_GrGain_V_44;
    assign lsc_register_GrGain_V_45=int_lsc_register_GrGain_V_45;
    assign lsc_register_GrGain_V_46=int_lsc_register_GrGain_V_46;
    assign lsc_register_GrGain_V_47=int_lsc_register_GrGain_V_47;
    assign lsc_register_GrGain_V_48=int_lsc_register_GrGain_V_48;
    assign lsc_register_GrGain_V_49=int_lsc_register_GrGain_V_49;
    assign lsc_register_GrGain_V_50=int_lsc_register_GrGain_V_50;
    assign lsc_register_GrGain_V_51=int_lsc_register_GrGain_V_51;
    assign lsc_register_GrGain_V_52=int_lsc_register_GrGain_V_52;
    assign lsc_register_GrGain_V_53=int_lsc_register_GrGain_V_53;
    assign lsc_register_GrGain_V_54=int_lsc_register_GrGain_V_54;
    assign lsc_register_GrGain_V_55=int_lsc_register_GrGain_V_55;
    assign lsc_register_GrGain_V_56=int_lsc_register_GrGain_V_56;
    assign lsc_register_GrGain_V_57=int_lsc_register_GrGain_V_57;
    assign lsc_register_GrGain_V_58=int_lsc_register_GrGain_V_58;
    assign lsc_register_GrGain_V_59=int_lsc_register_GrGain_V_59;
    assign lsc_register_GrGain_V_60=int_lsc_register_GrGain_V_60;
    assign lsc_register_GrGain_V_61=int_lsc_register_GrGain_V_61;
    assign lsc_register_GrGain_V_62=int_lsc_register_GrGain_V_62;
    assign lsc_register_GrGain_V_63=int_lsc_register_GrGain_V_63;
    assign lsc_register_GrGain_V_64=int_lsc_register_GrGain_V_64;
    assign lsc_register_GrGain_V_65=int_lsc_register_GrGain_V_65;
    assign lsc_register_GrGain_V_66=int_lsc_register_GrGain_V_66;
    assign lsc_register_GrGain_V_67=int_lsc_register_GrGain_V_67;
    assign lsc_register_GrGain_V_68=int_lsc_register_GrGain_V_68;
    assign lsc_register_GrGain_V_69=int_lsc_register_GrGain_V_69;
    assign lsc_register_GrGain_V_70=int_lsc_register_GrGain_V_70;
    assign lsc_register_GrGain_V_71=int_lsc_register_GrGain_V_71;
    assign lsc_register_GrGain_V_72=int_lsc_register_GrGain_V_72;
    assign lsc_register_GrGain_V_73=int_lsc_register_GrGain_V_73;
    assign lsc_register_GrGain_V_74=int_lsc_register_GrGain_V_74;
    assign lsc_register_GrGain_V_75=int_lsc_register_GrGain_V_75;
    assign lsc_register_GrGain_V_76=int_lsc_register_GrGain_V_76;
    assign lsc_register_GrGain_V_77=int_lsc_register_GrGain_V_77;
    assign lsc_register_GrGain_V_78=int_lsc_register_GrGain_V_78;
    assign lsc_register_GrGain_V_79=int_lsc_register_GrGain_V_79;
    assign lsc_register_GrGain_V_80=int_lsc_register_GrGain_V_80;
    assign lsc_register_GrGain_V_81=int_lsc_register_GrGain_V_81;
    assign lsc_register_GrGain_V_82=int_lsc_register_GrGain_V_82;
    assign lsc_register_GrGain_V_83=int_lsc_register_GrGain_V_83;
    assign lsc_register_GrGain_V_84=int_lsc_register_GrGain_V_84;
    assign lsc_register_GrGain_V_85=int_lsc_register_GrGain_V_85;
    assign lsc_register_GrGain_V_86=int_lsc_register_GrGain_V_86;
    assign lsc_register_GrGain_V_87=int_lsc_register_GrGain_V_87;
    assign lsc_register_GrGain_V_88=int_lsc_register_GrGain_V_88;
    assign lsc_register_GrGain_V_89=int_lsc_register_GrGain_V_89;
    assign lsc_register_GrGain_V_90=int_lsc_register_GrGain_V_90;
    assign lsc_register_GrGain_V_91=int_lsc_register_GrGain_V_91;
    assign lsc_register_GrGain_V_92=int_lsc_register_GrGain_V_92;
    assign lsc_register_GrGain_V_93=int_lsc_register_GrGain_V_93;
    assign lsc_register_GrGain_V_94=int_lsc_register_GrGain_V_94;
    assign lsc_register_GrGain_V_95=int_lsc_register_GrGain_V_95;
    assign lsc_register_GrGain_V_96=int_lsc_register_GrGain_V_96;
    assign lsc_register_GrGain_V_97=int_lsc_register_GrGain_V_97;
    assign lsc_register_GrGain_V_98=int_lsc_register_GrGain_V_98;
    assign lsc_register_GrGain_V_99=int_lsc_register_GrGain_V_99;
    assign lsc_register_GrGain_V_100=int_lsc_register_GrGain_V_100;
    assign lsc_register_GrGain_V_101=int_lsc_register_GrGain_V_101;
    assign lsc_register_GrGain_V_102=int_lsc_register_GrGain_V_102;
    assign lsc_register_GrGain_V_103=int_lsc_register_GrGain_V_103;
    assign lsc_register_GrGain_V_104=int_lsc_register_GrGain_V_104;
    assign lsc_register_GrGain_V_105=int_lsc_register_GrGain_V_105;
    assign lsc_register_GrGain_V_106=int_lsc_register_GrGain_V_106;
    assign lsc_register_GrGain_V_107=int_lsc_register_GrGain_V_107;
    assign lsc_register_GrGain_V_108=int_lsc_register_GrGain_V_108;
    assign lsc_register_GrGain_V_109=int_lsc_register_GrGain_V_109;
    assign lsc_register_GrGain_V_110=int_lsc_register_GrGain_V_110;
    assign lsc_register_GrGain_V_111=int_lsc_register_GrGain_V_111;
    assign lsc_register_GrGain_V_112=int_lsc_register_GrGain_V_112;
    assign lsc_register_GrGain_V_113=int_lsc_register_GrGain_V_113;
    assign lsc_register_GrGain_V_114=int_lsc_register_GrGain_V_114;
    assign lsc_register_GrGain_V_115=int_lsc_register_GrGain_V_115;
    assign lsc_register_GrGain_V_116=int_lsc_register_GrGain_V_116;
    assign lsc_register_GrGain_V_117=int_lsc_register_GrGain_V_117;
    assign lsc_register_GrGain_V_118=int_lsc_register_GrGain_V_118;
    assign lsc_register_GrGain_V_119=int_lsc_register_GrGain_V_119;
    assign lsc_register_GrGain_V_120=int_lsc_register_GrGain_V_120;
    assign lsc_register_GrGain_V_121=int_lsc_register_GrGain_V_121;
    assign lsc_register_GrGain_V_122=int_lsc_register_GrGain_V_122;
    assign lsc_register_GrGain_V_123=int_lsc_register_GrGain_V_123;
    assign lsc_register_GrGain_V_124=int_lsc_register_GrGain_V_124;
    assign lsc_register_GrGain_V_125=int_lsc_register_GrGain_V_125;
    assign lsc_register_GrGain_V_126=int_lsc_register_GrGain_V_126;
    assign lsc_register_GrGain_V_127=int_lsc_register_GrGain_V_127;
    assign lsc_register_GrGain_V_128=int_lsc_register_GrGain_V_128;
    assign lsc_register_GrGain_V_129=int_lsc_register_GrGain_V_129;
    assign lsc_register_GrGain_V_130=int_lsc_register_GrGain_V_130;
    assign lsc_register_GrGain_V_131=int_lsc_register_GrGain_V_131;
    assign lsc_register_GrGain_V_132=int_lsc_register_GrGain_V_132;
    assign lsc_register_GrGain_V_133=int_lsc_register_GrGain_V_133;
    assign lsc_register_GrGain_V_134=int_lsc_register_GrGain_V_134;
    assign lsc_register_GrGain_V_135=int_lsc_register_GrGain_V_135;
    assign lsc_register_GrGain_V_136=int_lsc_register_GrGain_V_136;
    assign lsc_register_GrGain_V_137=int_lsc_register_GrGain_V_137;
    assign lsc_register_GrGain_V_138=int_lsc_register_GrGain_V_138;
    assign lsc_register_GrGain_V_139=int_lsc_register_GrGain_V_139;
    assign lsc_register_GrGain_V_140=int_lsc_register_GrGain_V_140;
    assign lsc_register_GrGain_V_141=int_lsc_register_GrGain_V_141;
    assign lsc_register_GrGain_V_142=int_lsc_register_GrGain_V_142;
    assign lsc_register_GrGain_V_143=int_lsc_register_GrGain_V_143;
    assign lsc_register_GrGain_V_144=int_lsc_register_GrGain_V_144;
    assign lsc_register_GrGain_V_145=int_lsc_register_GrGain_V_145;
    assign lsc_register_GrGain_V_146=int_lsc_register_GrGain_V_146;
    assign lsc_register_GrGain_V_147=int_lsc_register_GrGain_V_147;
    assign lsc_register_GrGain_V_148=int_lsc_register_GrGain_V_148;
    assign lsc_register_GrGain_V_149=int_lsc_register_GrGain_V_149;
    assign lsc_register_GrGain_V_150=int_lsc_register_GrGain_V_150;
    assign lsc_register_GrGain_V_151=int_lsc_register_GrGain_V_151;
    assign lsc_register_GrGain_V_152=int_lsc_register_GrGain_V_152;
    assign lsc_register_GrGain_V_153=int_lsc_register_GrGain_V_153;
    assign lsc_register_GrGain_V_154=int_lsc_register_GrGain_V_154;
    assign lsc_register_GrGain_V_155=int_lsc_register_GrGain_V_155;
    assign lsc_register_GrGain_V_156=int_lsc_register_GrGain_V_156;
    assign lsc_register_GrGain_V_157=int_lsc_register_GrGain_V_157;
    assign lsc_register_GrGain_V_158=int_lsc_register_GrGain_V_158;
    assign lsc_register_GrGain_V_159=int_lsc_register_GrGain_V_159;
    assign lsc_register_GrGain_V_160=int_lsc_register_GrGain_V_160;
    assign lsc_register_GrGain_V_161=int_lsc_register_GrGain_V_161;
    assign lsc_register_GrGain_V_162=int_lsc_register_GrGain_V_162;
    assign lsc_register_GrGain_V_163=int_lsc_register_GrGain_V_163;
    assign lsc_register_GrGain_V_164=int_lsc_register_GrGain_V_164;
    assign lsc_register_GrGain_V_165=int_lsc_register_GrGain_V_165;
    assign lsc_register_GrGain_V_166=int_lsc_register_GrGain_V_166;
    assign lsc_register_GrGain_V_167=int_lsc_register_GrGain_V_167;
    assign lsc_register_GrGain_V_168=int_lsc_register_GrGain_V_168;
    assign lsc_register_GrGain_V_169=int_lsc_register_GrGain_V_169;
    assign lsc_register_GrGain_V_170=int_lsc_register_GrGain_V_170;
    assign lsc_register_GrGain_V_171=int_lsc_register_GrGain_V_171;
    assign lsc_register_GrGain_V_172=int_lsc_register_GrGain_V_172;
    assign lsc_register_GrGain_V_173=int_lsc_register_GrGain_V_173;
    assign lsc_register_GrGain_V_174=int_lsc_register_GrGain_V_174;
    assign lsc_register_GrGain_V_175=int_lsc_register_GrGain_V_175;
    assign lsc_register_GrGain_V_176=int_lsc_register_GrGain_V_176;
    assign lsc_register_GrGain_V_177=int_lsc_register_GrGain_V_177;
    assign lsc_register_GrGain_V_178=int_lsc_register_GrGain_V_178;
    assign lsc_register_GrGain_V_179=int_lsc_register_GrGain_V_179;
    assign lsc_register_GrGain_V_180=int_lsc_register_GrGain_V_180;
    assign lsc_register_GrGain_V_181=int_lsc_register_GrGain_V_181;
    assign lsc_register_GrGain_V_182=int_lsc_register_GrGain_V_182;
    assign lsc_register_GrGain_V_183=int_lsc_register_GrGain_V_183;
    assign lsc_register_GrGain_V_184=int_lsc_register_GrGain_V_184;
    assign lsc_register_GrGain_V_185=int_lsc_register_GrGain_V_185;
    assign lsc_register_GrGain_V_186=int_lsc_register_GrGain_V_186;
    assign lsc_register_GrGain_V_187=int_lsc_register_GrGain_V_187;
    assign lsc_register_GrGain_V_188=int_lsc_register_GrGain_V_188;
    assign lsc_register_GrGain_V_189=int_lsc_register_GrGain_V_189;
    assign lsc_register_GrGain_V_190=int_lsc_register_GrGain_V_190;
    assign lsc_register_GrGain_V_191=int_lsc_register_GrGain_V_191;
    assign lsc_register_GrGain_V_192=int_lsc_register_GrGain_V_192;
    assign lsc_register_GrGain_V_193=int_lsc_register_GrGain_V_193;
    assign lsc_register_GrGain_V_194=int_lsc_register_GrGain_V_194;
    assign lsc_register_GrGain_V_195=int_lsc_register_GrGain_V_195;
    assign lsc_register_GrGain_V_196=int_lsc_register_GrGain_V_196;
    assign lsc_register_GrGain_V_197=int_lsc_register_GrGain_V_197;
    assign lsc_register_GrGain_V_198=int_lsc_register_GrGain_V_198;
    assign lsc_register_GrGain_V_199=int_lsc_register_GrGain_V_199;
    assign lsc_register_GrGain_V_200=int_lsc_register_GrGain_V_200;
    assign lsc_register_GrGain_V_201=int_lsc_register_GrGain_V_201;
    assign lsc_register_GrGain_V_202=int_lsc_register_GrGain_V_202;
    assign lsc_register_GrGain_V_203=int_lsc_register_GrGain_V_203;
    assign lsc_register_GrGain_V_204=int_lsc_register_GrGain_V_204;
    assign lsc_register_GrGain_V_205=int_lsc_register_GrGain_V_205;
    assign lsc_register_GrGain_V_206=int_lsc_register_GrGain_V_206;
    assign lsc_register_GrGain_V_207=int_lsc_register_GrGain_V_207;
    assign lsc_register_GrGain_V_208=int_lsc_register_GrGain_V_208;
    assign lsc_register_GrGain_V_209=int_lsc_register_GrGain_V_209;
    assign lsc_register_GrGain_V_210=int_lsc_register_GrGain_V_210;
    assign lsc_register_GrGain_V_211=int_lsc_register_GrGain_V_211;
    assign lsc_register_GrGain_V_212=int_lsc_register_GrGain_V_212;
    assign lsc_register_GrGain_V_213=int_lsc_register_GrGain_V_213;
    assign lsc_register_GrGain_V_214=int_lsc_register_GrGain_V_214;
    assign lsc_register_GrGain_V_215=int_lsc_register_GrGain_V_215;
    assign lsc_register_GrGain_V_216=int_lsc_register_GrGain_V_216;
    assign lsc_register_GrGain_V_217=int_lsc_register_GrGain_V_217;
    assign lsc_register_GrGain_V_218=int_lsc_register_GrGain_V_218;
    assign lsc_register_GrGain_V_219=int_lsc_register_GrGain_V_219;
    assign lsc_register_GrGain_V_220=int_lsc_register_GrGain_V_220;
    assign lsc_register_GbGain_V_0=int_lsc_register_GbGain_V_0;
    assign lsc_register_GbGain_V_1=int_lsc_register_GbGain_V_1;
    assign lsc_register_GbGain_V_2=int_lsc_register_GbGain_V_2;
    assign lsc_register_GbGain_V_3=int_lsc_register_GbGain_V_3;
    assign lsc_register_GbGain_V_4=int_lsc_register_GbGain_V_4;
    assign lsc_register_GbGain_V_5=int_lsc_register_GbGain_V_5;
    assign lsc_register_GbGain_V_6=int_lsc_register_GbGain_V_6;
    assign lsc_register_GbGain_V_7=int_lsc_register_GbGain_V_7;
    assign lsc_register_GbGain_V_8=int_lsc_register_GbGain_V_8;
    assign lsc_register_GbGain_V_9=int_lsc_register_GbGain_V_9;
    assign lsc_register_GbGain_V_10=int_lsc_register_GbGain_V_10;
    assign lsc_register_GbGain_V_11=int_lsc_register_GbGain_V_11;
    assign lsc_register_GbGain_V_12=int_lsc_register_GbGain_V_12;
    assign lsc_register_GbGain_V_13=int_lsc_register_GbGain_V_13;
    assign lsc_register_GbGain_V_14=int_lsc_register_GbGain_V_14;
    assign lsc_register_GbGain_V_15=int_lsc_register_GbGain_V_15;
    assign lsc_register_GbGain_V_16=int_lsc_register_GbGain_V_16;
    assign lsc_register_GbGain_V_17=int_lsc_register_GbGain_V_17;
    assign lsc_register_GbGain_V_18=int_lsc_register_GbGain_V_18;
    assign lsc_register_GbGain_V_19=int_lsc_register_GbGain_V_19;
    assign lsc_register_GbGain_V_20=int_lsc_register_GbGain_V_20;
    assign lsc_register_GbGain_V_21=int_lsc_register_GbGain_V_21;
    assign lsc_register_GbGain_V_22=int_lsc_register_GbGain_V_22;
    assign lsc_register_GbGain_V_23=int_lsc_register_GbGain_V_23;
    assign lsc_register_GbGain_V_24=int_lsc_register_GbGain_V_24;
    assign lsc_register_GbGain_V_25=int_lsc_register_GbGain_V_25;
    assign lsc_register_GbGain_V_26=int_lsc_register_GbGain_V_26;
    assign lsc_register_GbGain_V_27=int_lsc_register_GbGain_V_27;
    assign lsc_register_GbGain_V_28=int_lsc_register_GbGain_V_28;
    assign lsc_register_GbGain_V_29=int_lsc_register_GbGain_V_29;
    assign lsc_register_GbGain_V_30=int_lsc_register_GbGain_V_30;
    assign lsc_register_GbGain_V_31=int_lsc_register_GbGain_V_31;
    assign lsc_register_GbGain_V_32=int_lsc_register_GbGain_V_32;
    assign lsc_register_GbGain_V_33=int_lsc_register_GbGain_V_33;
    assign lsc_register_GbGain_V_34=int_lsc_register_GbGain_V_34;
    assign lsc_register_GbGain_V_35=int_lsc_register_GbGain_V_35;
    assign lsc_register_GbGain_V_36=int_lsc_register_GbGain_V_36;
    assign lsc_register_GbGain_V_37=int_lsc_register_GbGain_V_37;
    assign lsc_register_GbGain_V_38=int_lsc_register_GbGain_V_38;
    assign lsc_register_GbGain_V_39=int_lsc_register_GbGain_V_39;
    assign lsc_register_GbGain_V_40=int_lsc_register_GbGain_V_40;
    assign lsc_register_GbGain_V_41=int_lsc_register_GbGain_V_41;
    assign lsc_register_GbGain_V_42=int_lsc_register_GbGain_V_42;
    assign lsc_register_GbGain_V_43=int_lsc_register_GbGain_V_43;
    assign lsc_register_GbGain_V_44=int_lsc_register_GbGain_V_44;
    assign lsc_register_GbGain_V_45=int_lsc_register_GbGain_V_45;
    assign lsc_register_GbGain_V_46=int_lsc_register_GbGain_V_46;
    assign lsc_register_GbGain_V_47=int_lsc_register_GbGain_V_47;
    assign lsc_register_GbGain_V_48=int_lsc_register_GbGain_V_48;
    assign lsc_register_GbGain_V_49=int_lsc_register_GbGain_V_49;
    assign lsc_register_GbGain_V_50=int_lsc_register_GbGain_V_50;
    assign lsc_register_GbGain_V_51=int_lsc_register_GbGain_V_51;
    assign lsc_register_GbGain_V_52=int_lsc_register_GbGain_V_52;
    assign lsc_register_GbGain_V_53=int_lsc_register_GbGain_V_53;
    assign lsc_register_GbGain_V_54=int_lsc_register_GbGain_V_54;
    assign lsc_register_GbGain_V_55=int_lsc_register_GbGain_V_55;
    assign lsc_register_GbGain_V_56=int_lsc_register_GbGain_V_56;
    assign lsc_register_GbGain_V_57=int_lsc_register_GbGain_V_57;
    assign lsc_register_GbGain_V_58=int_lsc_register_GbGain_V_58;
    assign lsc_register_GbGain_V_59=int_lsc_register_GbGain_V_59;
    assign lsc_register_GbGain_V_60=int_lsc_register_GbGain_V_60;
    assign lsc_register_GbGain_V_61=int_lsc_register_GbGain_V_61;
    assign lsc_register_GbGain_V_62=int_lsc_register_GbGain_V_62;
    assign lsc_register_GbGain_V_63=int_lsc_register_GbGain_V_63;
    assign lsc_register_GbGain_V_64=int_lsc_register_GbGain_V_64;
    assign lsc_register_GbGain_V_65=int_lsc_register_GbGain_V_65;
    assign lsc_register_GbGain_V_66=int_lsc_register_GbGain_V_66;
    assign lsc_register_GbGain_V_67=int_lsc_register_GbGain_V_67;
    assign lsc_register_GbGain_V_68=int_lsc_register_GbGain_V_68;
    assign lsc_register_GbGain_V_69=int_lsc_register_GbGain_V_69;
    assign lsc_register_GbGain_V_70=int_lsc_register_GbGain_V_70;
    assign lsc_register_GbGain_V_71=int_lsc_register_GbGain_V_71;
    assign lsc_register_GbGain_V_72=int_lsc_register_GbGain_V_72;
    assign lsc_register_GbGain_V_73=int_lsc_register_GbGain_V_73;
    assign lsc_register_GbGain_V_74=int_lsc_register_GbGain_V_74;
    assign lsc_register_GbGain_V_75=int_lsc_register_GbGain_V_75;
    assign lsc_register_GbGain_V_76=int_lsc_register_GbGain_V_76;
    assign lsc_register_GbGain_V_77=int_lsc_register_GbGain_V_77;
    assign lsc_register_GbGain_V_78=int_lsc_register_GbGain_V_78;
    assign lsc_register_GbGain_V_79=int_lsc_register_GbGain_V_79;
    assign lsc_register_GbGain_V_80=int_lsc_register_GbGain_V_80;
    assign lsc_register_GbGain_V_81=int_lsc_register_GbGain_V_81;
    assign lsc_register_GbGain_V_82=int_lsc_register_GbGain_V_82;
    assign lsc_register_GbGain_V_83=int_lsc_register_GbGain_V_83;
    assign lsc_register_GbGain_V_84=int_lsc_register_GbGain_V_84;
    assign lsc_register_GbGain_V_85=int_lsc_register_GbGain_V_85;
    assign lsc_register_GbGain_V_86=int_lsc_register_GbGain_V_86;
    assign lsc_register_GbGain_V_87=int_lsc_register_GbGain_V_87;
    assign lsc_register_GbGain_V_88=int_lsc_register_GbGain_V_88;
    assign lsc_register_GbGain_V_89=int_lsc_register_GbGain_V_89;
    assign lsc_register_GbGain_V_90=int_lsc_register_GbGain_V_90;
    assign lsc_register_GbGain_V_91=int_lsc_register_GbGain_V_91;
    assign lsc_register_GbGain_V_92=int_lsc_register_GbGain_V_92;
    assign lsc_register_GbGain_V_93=int_lsc_register_GbGain_V_93;
    assign lsc_register_GbGain_V_94=int_lsc_register_GbGain_V_94;
    assign lsc_register_GbGain_V_95=int_lsc_register_GbGain_V_95;
    assign lsc_register_GbGain_V_96=int_lsc_register_GbGain_V_96;
    assign lsc_register_GbGain_V_97=int_lsc_register_GbGain_V_97;
    assign lsc_register_GbGain_V_98=int_lsc_register_GbGain_V_98;
    assign lsc_register_GbGain_V_99=int_lsc_register_GbGain_V_99;
    assign lsc_register_GbGain_V_100=int_lsc_register_GbGain_V_100;
    assign lsc_register_GbGain_V_101=int_lsc_register_GbGain_V_101;
    assign lsc_register_GbGain_V_102=int_lsc_register_GbGain_V_102;
    assign lsc_register_GbGain_V_103=int_lsc_register_GbGain_V_103;
    assign lsc_register_GbGain_V_104=int_lsc_register_GbGain_V_104;
    assign lsc_register_GbGain_V_105=int_lsc_register_GbGain_V_105;
    assign lsc_register_GbGain_V_106=int_lsc_register_GbGain_V_106;
    assign lsc_register_GbGain_V_107=int_lsc_register_GbGain_V_107;
    assign lsc_register_GbGain_V_108=int_lsc_register_GbGain_V_108;
    assign lsc_register_GbGain_V_109=int_lsc_register_GbGain_V_109;
    assign lsc_register_GbGain_V_110=int_lsc_register_GbGain_V_110;
    assign lsc_register_GbGain_V_111=int_lsc_register_GbGain_V_111;
    assign lsc_register_GbGain_V_112=int_lsc_register_GbGain_V_112;
    assign lsc_register_GbGain_V_113=int_lsc_register_GbGain_V_113;
    assign lsc_register_GbGain_V_114=int_lsc_register_GbGain_V_114;
    assign lsc_register_GbGain_V_115=int_lsc_register_GbGain_V_115;
    assign lsc_register_GbGain_V_116=int_lsc_register_GbGain_V_116;
    assign lsc_register_GbGain_V_117=int_lsc_register_GbGain_V_117;
    assign lsc_register_GbGain_V_118=int_lsc_register_GbGain_V_118;
    assign lsc_register_GbGain_V_119=int_lsc_register_GbGain_V_119;
    assign lsc_register_GbGain_V_120=int_lsc_register_GbGain_V_120;
    assign lsc_register_GbGain_V_121=int_lsc_register_GbGain_V_121;
    assign lsc_register_GbGain_V_122=int_lsc_register_GbGain_V_122;
    assign lsc_register_GbGain_V_123=int_lsc_register_GbGain_V_123;
    assign lsc_register_GbGain_V_124=int_lsc_register_GbGain_V_124;
    assign lsc_register_GbGain_V_125=int_lsc_register_GbGain_V_125;
    assign lsc_register_GbGain_V_126=int_lsc_register_GbGain_V_126;
    assign lsc_register_GbGain_V_127=int_lsc_register_GbGain_V_127;
    assign lsc_register_GbGain_V_128=int_lsc_register_GbGain_V_128;
    assign lsc_register_GbGain_V_129=int_lsc_register_GbGain_V_129;
    assign lsc_register_GbGain_V_130=int_lsc_register_GbGain_V_130;
    assign lsc_register_GbGain_V_131=int_lsc_register_GbGain_V_131;
    assign lsc_register_GbGain_V_132=int_lsc_register_GbGain_V_132;
    assign lsc_register_GbGain_V_133=int_lsc_register_GbGain_V_133;
    assign lsc_register_GbGain_V_134=int_lsc_register_GbGain_V_134;
    assign lsc_register_GbGain_V_135=int_lsc_register_GbGain_V_135;
    assign lsc_register_GbGain_V_136=int_lsc_register_GbGain_V_136;
    assign lsc_register_GbGain_V_137=int_lsc_register_GbGain_V_137;
    assign lsc_register_GbGain_V_138=int_lsc_register_GbGain_V_138;
    assign lsc_register_GbGain_V_139=int_lsc_register_GbGain_V_139;
    assign lsc_register_GbGain_V_140=int_lsc_register_GbGain_V_140;
    assign lsc_register_GbGain_V_141=int_lsc_register_GbGain_V_141;
    assign lsc_register_GbGain_V_142=int_lsc_register_GbGain_V_142;
    assign lsc_register_GbGain_V_143=int_lsc_register_GbGain_V_143;
    assign lsc_register_GbGain_V_144=int_lsc_register_GbGain_V_144;
    assign lsc_register_GbGain_V_145=int_lsc_register_GbGain_V_145;
    assign lsc_register_GbGain_V_146=int_lsc_register_GbGain_V_146;
    assign lsc_register_GbGain_V_147=int_lsc_register_GbGain_V_147;
    assign lsc_register_GbGain_V_148=int_lsc_register_GbGain_V_148;
    assign lsc_register_GbGain_V_149=int_lsc_register_GbGain_V_149;
    assign lsc_register_GbGain_V_150=int_lsc_register_GbGain_V_150;
    assign lsc_register_GbGain_V_151=int_lsc_register_GbGain_V_151;
    assign lsc_register_GbGain_V_152=int_lsc_register_GbGain_V_152;
    assign lsc_register_GbGain_V_153=int_lsc_register_GbGain_V_153;
    assign lsc_register_GbGain_V_154=int_lsc_register_GbGain_V_154;
    assign lsc_register_GbGain_V_155=int_lsc_register_GbGain_V_155;
    assign lsc_register_GbGain_V_156=int_lsc_register_GbGain_V_156;
    assign lsc_register_GbGain_V_157=int_lsc_register_GbGain_V_157;
    assign lsc_register_GbGain_V_158=int_lsc_register_GbGain_V_158;
    assign lsc_register_GbGain_V_159=int_lsc_register_GbGain_V_159;
    assign lsc_register_GbGain_V_160=int_lsc_register_GbGain_V_160;
    assign lsc_register_GbGain_V_161=int_lsc_register_GbGain_V_161;
    assign lsc_register_GbGain_V_162=int_lsc_register_GbGain_V_162;
    assign lsc_register_GbGain_V_163=int_lsc_register_GbGain_V_163;
    assign lsc_register_GbGain_V_164=int_lsc_register_GbGain_V_164;
    assign lsc_register_GbGain_V_165=int_lsc_register_GbGain_V_165;
    assign lsc_register_GbGain_V_166=int_lsc_register_GbGain_V_166;
    assign lsc_register_GbGain_V_167=int_lsc_register_GbGain_V_167;
    assign lsc_register_GbGain_V_168=int_lsc_register_GbGain_V_168;
    assign lsc_register_GbGain_V_169=int_lsc_register_GbGain_V_169;
    assign lsc_register_GbGain_V_170=int_lsc_register_GbGain_V_170;
    assign lsc_register_GbGain_V_171=int_lsc_register_GbGain_V_171;
    assign lsc_register_GbGain_V_172=int_lsc_register_GbGain_V_172;
    assign lsc_register_GbGain_V_173=int_lsc_register_GbGain_V_173;
    assign lsc_register_GbGain_V_174=int_lsc_register_GbGain_V_174;
    assign lsc_register_GbGain_V_175=int_lsc_register_GbGain_V_175;
    assign lsc_register_GbGain_V_176=int_lsc_register_GbGain_V_176;
    assign lsc_register_GbGain_V_177=int_lsc_register_GbGain_V_177;
    assign lsc_register_GbGain_V_178=int_lsc_register_GbGain_V_178;
    assign lsc_register_GbGain_V_179=int_lsc_register_GbGain_V_179;
    assign lsc_register_GbGain_V_180=int_lsc_register_GbGain_V_180;
    assign lsc_register_GbGain_V_181=int_lsc_register_GbGain_V_181;
    assign lsc_register_GbGain_V_182=int_lsc_register_GbGain_V_182;
    assign lsc_register_GbGain_V_183=int_lsc_register_GbGain_V_183;
    assign lsc_register_GbGain_V_184=int_lsc_register_GbGain_V_184;
    assign lsc_register_GbGain_V_185=int_lsc_register_GbGain_V_185;
    assign lsc_register_GbGain_V_186=int_lsc_register_GbGain_V_186;
    assign lsc_register_GbGain_V_187=int_lsc_register_GbGain_V_187;
    assign lsc_register_GbGain_V_188=int_lsc_register_GbGain_V_188;
    assign lsc_register_GbGain_V_189=int_lsc_register_GbGain_V_189;
    assign lsc_register_GbGain_V_190=int_lsc_register_GbGain_V_190;
    assign lsc_register_GbGain_V_191=int_lsc_register_GbGain_V_191;
    assign lsc_register_GbGain_V_192=int_lsc_register_GbGain_V_192;
    assign lsc_register_GbGain_V_193=int_lsc_register_GbGain_V_193;
    assign lsc_register_GbGain_V_194=int_lsc_register_GbGain_V_194;
    assign lsc_register_GbGain_V_195=int_lsc_register_GbGain_V_195;
    assign lsc_register_GbGain_V_196=int_lsc_register_GbGain_V_196;
    assign lsc_register_GbGain_V_197=int_lsc_register_GbGain_V_197;
    assign lsc_register_GbGain_V_198=int_lsc_register_GbGain_V_198;
    assign lsc_register_GbGain_V_199=int_lsc_register_GbGain_V_199;
    assign lsc_register_GbGain_V_200=int_lsc_register_GbGain_V_200;
    assign lsc_register_GbGain_V_201=int_lsc_register_GbGain_V_201;
    assign lsc_register_GbGain_V_202=int_lsc_register_GbGain_V_202;
    assign lsc_register_GbGain_V_203=int_lsc_register_GbGain_V_203;
    assign lsc_register_GbGain_V_204=int_lsc_register_GbGain_V_204;
    assign lsc_register_GbGain_V_205=int_lsc_register_GbGain_V_205;
    assign lsc_register_GbGain_V_206=int_lsc_register_GbGain_V_206;
    assign lsc_register_GbGain_V_207=int_lsc_register_GbGain_V_207;
    assign lsc_register_GbGain_V_208=int_lsc_register_GbGain_V_208;
    assign lsc_register_GbGain_V_209=int_lsc_register_GbGain_V_209;
    assign lsc_register_GbGain_V_210=int_lsc_register_GbGain_V_210;
    assign lsc_register_GbGain_V_211=int_lsc_register_GbGain_V_211;
    assign lsc_register_GbGain_V_212=int_lsc_register_GbGain_V_212;
    assign lsc_register_GbGain_V_213=int_lsc_register_GbGain_V_213;
    assign lsc_register_GbGain_V_214=int_lsc_register_GbGain_V_214;
    assign lsc_register_GbGain_V_215=int_lsc_register_GbGain_V_215;
    assign lsc_register_GbGain_V_216=int_lsc_register_GbGain_V_216;
    assign lsc_register_GbGain_V_217=int_lsc_register_GbGain_V_217;
    assign lsc_register_GbGain_V_218=int_lsc_register_GbGain_V_218;
    assign lsc_register_GbGain_V_219=int_lsc_register_GbGain_V_219;
    assign lsc_register_GbGain_V_220=int_lsc_register_GbGain_V_220;
    assign lsc_register_bGain_V_0=int_lsc_register_bGain_V_0;
    assign lsc_register_bGain_V_1=int_lsc_register_bGain_V_1;
    assign lsc_register_bGain_V_2=int_lsc_register_bGain_V_2;
    assign lsc_register_bGain_V_3=int_lsc_register_bGain_V_3;
    assign lsc_register_bGain_V_4=int_lsc_register_bGain_V_4;
    assign lsc_register_bGain_V_5=int_lsc_register_bGain_V_5;
    assign lsc_register_bGain_V_6=int_lsc_register_bGain_V_6;
    assign lsc_register_bGain_V_7=int_lsc_register_bGain_V_7;
    assign lsc_register_bGain_V_8=int_lsc_register_bGain_V_8;
    assign lsc_register_bGain_V_9=int_lsc_register_bGain_V_9;
    assign lsc_register_bGain_V_10=int_lsc_register_bGain_V_10;
    assign lsc_register_bGain_V_11=int_lsc_register_bGain_V_11;
    assign lsc_register_bGain_V_12=int_lsc_register_bGain_V_12;
    assign lsc_register_bGain_V_13=int_lsc_register_bGain_V_13;
    assign lsc_register_bGain_V_14=int_lsc_register_bGain_V_14;
    assign lsc_register_bGain_V_15=int_lsc_register_bGain_V_15;
    assign lsc_register_bGain_V_16=int_lsc_register_bGain_V_16;
    assign lsc_register_bGain_V_17=int_lsc_register_bGain_V_17;
    assign lsc_register_bGain_V_18=int_lsc_register_bGain_V_18;
    assign lsc_register_bGain_V_19=int_lsc_register_bGain_V_19;
    assign lsc_register_bGain_V_20=int_lsc_register_bGain_V_20;
    assign lsc_register_bGain_V_21=int_lsc_register_bGain_V_21;
    assign lsc_register_bGain_V_22=int_lsc_register_bGain_V_22;
    assign lsc_register_bGain_V_23=int_lsc_register_bGain_V_23;
    assign lsc_register_bGain_V_24=int_lsc_register_bGain_V_24;
    assign lsc_register_bGain_V_25=int_lsc_register_bGain_V_25;
    assign lsc_register_bGain_V_26=int_lsc_register_bGain_V_26;
    assign lsc_register_bGain_V_27=int_lsc_register_bGain_V_27;
    assign lsc_register_bGain_V_28=int_lsc_register_bGain_V_28;
    assign lsc_register_bGain_V_29=int_lsc_register_bGain_V_29;
    assign lsc_register_bGain_V_30=int_lsc_register_bGain_V_30;
    assign lsc_register_bGain_V_31=int_lsc_register_bGain_V_31;
    assign lsc_register_bGain_V_32=int_lsc_register_bGain_V_32;
    assign lsc_register_bGain_V_33=int_lsc_register_bGain_V_33;
    assign lsc_register_bGain_V_34=int_lsc_register_bGain_V_34;
    assign lsc_register_bGain_V_35=int_lsc_register_bGain_V_35;
    assign lsc_register_bGain_V_36=int_lsc_register_bGain_V_36;
    assign lsc_register_bGain_V_37=int_lsc_register_bGain_V_37;
    assign lsc_register_bGain_V_38=int_lsc_register_bGain_V_38;
    assign lsc_register_bGain_V_39=int_lsc_register_bGain_V_39;
    assign lsc_register_bGain_V_40=int_lsc_register_bGain_V_40;
    assign lsc_register_bGain_V_41=int_lsc_register_bGain_V_41;
    assign lsc_register_bGain_V_42=int_lsc_register_bGain_V_42;
    assign lsc_register_bGain_V_43=int_lsc_register_bGain_V_43;
    assign lsc_register_bGain_V_44=int_lsc_register_bGain_V_44;
    assign lsc_register_bGain_V_45=int_lsc_register_bGain_V_45;
    assign lsc_register_bGain_V_46=int_lsc_register_bGain_V_46;
    assign lsc_register_bGain_V_47=int_lsc_register_bGain_V_47;
    assign lsc_register_bGain_V_48=int_lsc_register_bGain_V_48;
    assign lsc_register_bGain_V_49=int_lsc_register_bGain_V_49;
    assign lsc_register_bGain_V_50=int_lsc_register_bGain_V_50;
    assign lsc_register_bGain_V_51=int_lsc_register_bGain_V_51;
    assign lsc_register_bGain_V_52=int_lsc_register_bGain_V_52;
    assign lsc_register_bGain_V_53=int_lsc_register_bGain_V_53;
    assign lsc_register_bGain_V_54=int_lsc_register_bGain_V_54;
    assign lsc_register_bGain_V_55=int_lsc_register_bGain_V_55;
    assign lsc_register_bGain_V_56=int_lsc_register_bGain_V_56;
    assign lsc_register_bGain_V_57=int_lsc_register_bGain_V_57;
    assign lsc_register_bGain_V_58=int_lsc_register_bGain_V_58;
    assign lsc_register_bGain_V_59=int_lsc_register_bGain_V_59;
    assign lsc_register_bGain_V_60=int_lsc_register_bGain_V_60;
    assign lsc_register_bGain_V_61=int_lsc_register_bGain_V_61;
    assign lsc_register_bGain_V_62=int_lsc_register_bGain_V_62;
    assign lsc_register_bGain_V_63=int_lsc_register_bGain_V_63;
    assign lsc_register_bGain_V_64=int_lsc_register_bGain_V_64;
    assign lsc_register_bGain_V_65=int_lsc_register_bGain_V_65;
    assign lsc_register_bGain_V_66=int_lsc_register_bGain_V_66;
    assign lsc_register_bGain_V_67=int_lsc_register_bGain_V_67;
    assign lsc_register_bGain_V_68=int_lsc_register_bGain_V_68;
    assign lsc_register_bGain_V_69=int_lsc_register_bGain_V_69;
    assign lsc_register_bGain_V_70=int_lsc_register_bGain_V_70;
    assign lsc_register_bGain_V_71=int_lsc_register_bGain_V_71;
    assign lsc_register_bGain_V_72=int_lsc_register_bGain_V_72;
    assign lsc_register_bGain_V_73=int_lsc_register_bGain_V_73;
    assign lsc_register_bGain_V_74=int_lsc_register_bGain_V_74;
    assign lsc_register_bGain_V_75=int_lsc_register_bGain_V_75;
    assign lsc_register_bGain_V_76=int_lsc_register_bGain_V_76;
    assign lsc_register_bGain_V_77=int_lsc_register_bGain_V_77;
    assign lsc_register_bGain_V_78=int_lsc_register_bGain_V_78;
    assign lsc_register_bGain_V_79=int_lsc_register_bGain_V_79;
    assign lsc_register_bGain_V_80=int_lsc_register_bGain_V_80;
    assign lsc_register_bGain_V_81=int_lsc_register_bGain_V_81;
    assign lsc_register_bGain_V_82=int_lsc_register_bGain_V_82;
    assign lsc_register_bGain_V_83=int_lsc_register_bGain_V_83;
    assign lsc_register_bGain_V_84=int_lsc_register_bGain_V_84;
    assign lsc_register_bGain_V_85=int_lsc_register_bGain_V_85;
    assign lsc_register_bGain_V_86=int_lsc_register_bGain_V_86;
    assign lsc_register_bGain_V_87=int_lsc_register_bGain_V_87;
    assign lsc_register_bGain_V_88=int_lsc_register_bGain_V_88;
    assign lsc_register_bGain_V_89=int_lsc_register_bGain_V_89;
    assign lsc_register_bGain_V_90=int_lsc_register_bGain_V_90;
    assign lsc_register_bGain_V_91=int_lsc_register_bGain_V_91;
    assign lsc_register_bGain_V_92=int_lsc_register_bGain_V_92;
    assign lsc_register_bGain_V_93=int_lsc_register_bGain_V_93;
    assign lsc_register_bGain_V_94=int_lsc_register_bGain_V_94;
    assign lsc_register_bGain_V_95=int_lsc_register_bGain_V_95;
    assign lsc_register_bGain_V_96=int_lsc_register_bGain_V_96;
    assign lsc_register_bGain_V_97=int_lsc_register_bGain_V_97;
    assign lsc_register_bGain_V_98=int_lsc_register_bGain_V_98;
    assign lsc_register_bGain_V_99=int_lsc_register_bGain_V_99;
    assign lsc_register_bGain_V_100=int_lsc_register_bGain_V_100;
    assign lsc_register_bGain_V_101=int_lsc_register_bGain_V_101;
    assign lsc_register_bGain_V_102=int_lsc_register_bGain_V_102;
    assign lsc_register_bGain_V_103=int_lsc_register_bGain_V_103;
    assign lsc_register_bGain_V_104=int_lsc_register_bGain_V_104;
    assign lsc_register_bGain_V_105=int_lsc_register_bGain_V_105;
    assign lsc_register_bGain_V_106=int_lsc_register_bGain_V_106;
    assign lsc_register_bGain_V_107=int_lsc_register_bGain_V_107;
    assign lsc_register_bGain_V_108=int_lsc_register_bGain_V_108;
    assign lsc_register_bGain_V_109=int_lsc_register_bGain_V_109;
    assign lsc_register_bGain_V_110=int_lsc_register_bGain_V_110;
    assign lsc_register_bGain_V_111=int_lsc_register_bGain_V_111;
    assign lsc_register_bGain_V_112=int_lsc_register_bGain_V_112;
    assign lsc_register_bGain_V_113=int_lsc_register_bGain_V_113;
    assign lsc_register_bGain_V_114=int_lsc_register_bGain_V_114;
    assign lsc_register_bGain_V_115=int_lsc_register_bGain_V_115;
    assign lsc_register_bGain_V_116=int_lsc_register_bGain_V_116;
    assign lsc_register_bGain_V_117=int_lsc_register_bGain_V_117;
    assign lsc_register_bGain_V_118=int_lsc_register_bGain_V_118;
    assign lsc_register_bGain_V_119=int_lsc_register_bGain_V_119;
    assign lsc_register_bGain_V_120=int_lsc_register_bGain_V_120;
    assign lsc_register_bGain_V_121=int_lsc_register_bGain_V_121;
    assign lsc_register_bGain_V_122=int_lsc_register_bGain_V_122;
    assign lsc_register_bGain_V_123=int_lsc_register_bGain_V_123;
    assign lsc_register_bGain_V_124=int_lsc_register_bGain_V_124;
    assign lsc_register_bGain_V_125=int_lsc_register_bGain_V_125;
    assign lsc_register_bGain_V_126=int_lsc_register_bGain_V_126;
    assign lsc_register_bGain_V_127=int_lsc_register_bGain_V_127;
    assign lsc_register_bGain_V_128=int_lsc_register_bGain_V_128;
    assign lsc_register_bGain_V_129=int_lsc_register_bGain_V_129;
    assign lsc_register_bGain_V_130=int_lsc_register_bGain_V_130;
    assign lsc_register_bGain_V_131=int_lsc_register_bGain_V_131;
    assign lsc_register_bGain_V_132=int_lsc_register_bGain_V_132;
    assign lsc_register_bGain_V_133=int_lsc_register_bGain_V_133;
    assign lsc_register_bGain_V_134=int_lsc_register_bGain_V_134;
    assign lsc_register_bGain_V_135=int_lsc_register_bGain_V_135;
    assign lsc_register_bGain_V_136=int_lsc_register_bGain_V_136;
    assign lsc_register_bGain_V_137=int_lsc_register_bGain_V_137;
    assign lsc_register_bGain_V_138=int_lsc_register_bGain_V_138;
    assign lsc_register_bGain_V_139=int_lsc_register_bGain_V_139;
    assign lsc_register_bGain_V_140=int_lsc_register_bGain_V_140;
    assign lsc_register_bGain_V_141=int_lsc_register_bGain_V_141;
    assign lsc_register_bGain_V_142=int_lsc_register_bGain_V_142;
    assign lsc_register_bGain_V_143=int_lsc_register_bGain_V_143;
    assign lsc_register_bGain_V_144=int_lsc_register_bGain_V_144;
    assign lsc_register_bGain_V_145=int_lsc_register_bGain_V_145;
    assign lsc_register_bGain_V_146=int_lsc_register_bGain_V_146;
    assign lsc_register_bGain_V_147=int_lsc_register_bGain_V_147;
    assign lsc_register_bGain_V_148=int_lsc_register_bGain_V_148;
    assign lsc_register_bGain_V_149=int_lsc_register_bGain_V_149;
    assign lsc_register_bGain_V_150=int_lsc_register_bGain_V_150;
    assign lsc_register_bGain_V_151=int_lsc_register_bGain_V_151;
    assign lsc_register_bGain_V_152=int_lsc_register_bGain_V_152;
    assign lsc_register_bGain_V_153=int_lsc_register_bGain_V_153;
    assign lsc_register_bGain_V_154=int_lsc_register_bGain_V_154;
    assign lsc_register_bGain_V_155=int_lsc_register_bGain_V_155;
    assign lsc_register_bGain_V_156=int_lsc_register_bGain_V_156;
    assign lsc_register_bGain_V_157=int_lsc_register_bGain_V_157;
    assign lsc_register_bGain_V_158=int_lsc_register_bGain_V_158;
    assign lsc_register_bGain_V_159=int_lsc_register_bGain_V_159;
    assign lsc_register_bGain_V_160=int_lsc_register_bGain_V_160;
    assign lsc_register_bGain_V_161=int_lsc_register_bGain_V_161;
    assign lsc_register_bGain_V_162=int_lsc_register_bGain_V_162;
    assign lsc_register_bGain_V_163=int_lsc_register_bGain_V_163;
    assign lsc_register_bGain_V_164=int_lsc_register_bGain_V_164;
    assign lsc_register_bGain_V_165=int_lsc_register_bGain_V_165;
    assign lsc_register_bGain_V_166=int_lsc_register_bGain_V_166;
    assign lsc_register_bGain_V_167=int_lsc_register_bGain_V_167;
    assign lsc_register_bGain_V_168=int_lsc_register_bGain_V_168;
    assign lsc_register_bGain_V_169=int_lsc_register_bGain_V_169;
    assign lsc_register_bGain_V_170=int_lsc_register_bGain_V_170;
    assign lsc_register_bGain_V_171=int_lsc_register_bGain_V_171;
    assign lsc_register_bGain_V_172=int_lsc_register_bGain_V_172;
    assign lsc_register_bGain_V_173=int_lsc_register_bGain_V_173;
    assign lsc_register_bGain_V_174=int_lsc_register_bGain_V_174;
    assign lsc_register_bGain_V_175=int_lsc_register_bGain_V_175;
    assign lsc_register_bGain_V_176=int_lsc_register_bGain_V_176;
    assign lsc_register_bGain_V_177=int_lsc_register_bGain_V_177;
    assign lsc_register_bGain_V_178=int_lsc_register_bGain_V_178;
    assign lsc_register_bGain_V_179=int_lsc_register_bGain_V_179;
    assign lsc_register_bGain_V_180=int_lsc_register_bGain_V_180;
    assign lsc_register_bGain_V_181=int_lsc_register_bGain_V_181;
    assign lsc_register_bGain_V_182=int_lsc_register_bGain_V_182;
    assign lsc_register_bGain_V_183=int_lsc_register_bGain_V_183;
    assign lsc_register_bGain_V_184=int_lsc_register_bGain_V_184;
    assign lsc_register_bGain_V_185=int_lsc_register_bGain_V_185;
    assign lsc_register_bGain_V_186=int_lsc_register_bGain_V_186;
    assign lsc_register_bGain_V_187=int_lsc_register_bGain_V_187;
    assign lsc_register_bGain_V_188=int_lsc_register_bGain_V_188;
    assign lsc_register_bGain_V_189=int_lsc_register_bGain_V_189;
    assign lsc_register_bGain_V_190=int_lsc_register_bGain_V_190;
    assign lsc_register_bGain_V_191=int_lsc_register_bGain_V_191;
    assign lsc_register_bGain_V_192=int_lsc_register_bGain_V_192;
    assign lsc_register_bGain_V_193=int_lsc_register_bGain_V_193;
    assign lsc_register_bGain_V_194=int_lsc_register_bGain_V_194;
    assign lsc_register_bGain_V_195=int_lsc_register_bGain_V_195;
    assign lsc_register_bGain_V_196=int_lsc_register_bGain_V_196;
    assign lsc_register_bGain_V_197=int_lsc_register_bGain_V_197;
    assign lsc_register_bGain_V_198=int_lsc_register_bGain_V_198;
    assign lsc_register_bGain_V_199=int_lsc_register_bGain_V_199;
    assign lsc_register_bGain_V_200=int_lsc_register_bGain_V_200;
    assign lsc_register_bGain_V_201=int_lsc_register_bGain_V_201;
    assign lsc_register_bGain_V_202=int_lsc_register_bGain_V_202;
    assign lsc_register_bGain_V_203=int_lsc_register_bGain_V_203;
    assign lsc_register_bGain_V_204=int_lsc_register_bGain_V_204;
    assign lsc_register_bGain_V_205=int_lsc_register_bGain_V_205;
    assign lsc_register_bGain_V_206=int_lsc_register_bGain_V_206;
    assign lsc_register_bGain_V_207=int_lsc_register_bGain_V_207;
    assign lsc_register_bGain_V_208=int_lsc_register_bGain_V_208;
    assign lsc_register_bGain_V_209=int_lsc_register_bGain_V_209;
    assign lsc_register_bGain_V_210=int_lsc_register_bGain_V_210;
    assign lsc_register_bGain_V_211=int_lsc_register_bGain_V_211;
    assign lsc_register_bGain_V_212=int_lsc_register_bGain_V_212;
    assign lsc_register_bGain_V_213=int_lsc_register_bGain_V_213;
    assign lsc_register_bGain_V_214=int_lsc_register_bGain_V_214;
    assign lsc_register_bGain_V_215=int_lsc_register_bGain_V_215;
    assign lsc_register_bGain_V_216=int_lsc_register_bGain_V_216;
    assign lsc_register_bGain_V_217=int_lsc_register_bGain_V_217;
    assign lsc_register_bGain_V_218=int_lsc_register_bGain_V_218;
    assign lsc_register_bGain_V_219=int_lsc_register_bGain_V_219;
    assign lsc_register_bGain_V_220=int_lsc_register_bGain_V_220;
    assign lsc_register_blockHeight_V=int_lsc_register_blockHeight_V;
    assign lsc_register_blockWidth_V=int_lsc_register_blockWidth_V;
    assign lsc_register_blockWidth_1_V=int_lsc_register_blockWidth_1_V;
    assign lsc_register_blockHeight_1_V=int_lsc_register_blockHeight_1_V;
    assign dpc_register_eb=int_dpc_register_eb;
    assign dpc_register_th_w_V=int_dpc_register_th_w_V;
    assign dpc_register_th_b_V=int_dpc_register_th_b_V;
    assign rawdns_register_sigma_V=int_rawdns_register_sigma_V;
    assign rawdns_register_eb_V=int_rawdns_register_eb_V;
    assign rawdns_register_Filterpara_V=int_rawdns_register_Filterpara_V;
    assign rawdns_register_invksigma2_V=int_rawdns_register_invksigma2_V;
    assign awb_register_m_nEb=int_awb_register_m_nEb;
    assign awb_register_r_gain_V=int_awb_register_r_gain_V;
    assign awb_register_g_gain_V=int_awb_register_g_gain_V;
    assign awb_register_b_gain_V=int_awb_register_b_gain_V;
    assign awb_register_coeff_V=int_awb_register_coeff_V;
    assign wbc_register_m_nEb=int_wbc_register_m_nEb;
    assign wbc_register_m_nR_V=int_wbc_register_m_nR_V;
    assign wbc_register_m_nGr_V=int_wbc_register_m_nGr_V;
    assign wbc_register_m_nGb_V=int_wbc_register_m_nGb_V;
    assign wbc_register_m_nB_V=int_wbc_register_m_nB_V;
    assign gb_register_eb=int_gb_register_eb;
    assign gb_register_win_size_V=int_gb_register_win_size_V;
    assign gb_register_Lbound_V=int_gb_register_Lbound_V;
    assign gb_register_Hbound_V=int_gb_register_Hbound_V;
    assign gb_register_threhold_V=int_gb_register_threhold_V;
    assign demosaic_register_eb=int_demosaic_register_eb;
    assign ee_register_eb=int_ee_register_eb;
    assign ee_register_coeff_V=int_ee_register_coeff_V;
    assign cmc_register_m_nEb=int_cmc_register_m_nEb;
    assign cmc_register_m_nGain_V_0=int_cmc_register_m_nGain_V_0;
    assign cmc_register_m_nGain_V_1=int_cmc_register_m_nGain_V_1;
    assign cmc_register_m_nGain_V_2=int_cmc_register_m_nGain_V_2;
    assign cmc_register_m_nGain_V_3=int_cmc_register_m_nGain_V_3;
    assign cmc_register_m_nGain_V_4=int_cmc_register_m_nGain_V_4;
    assign cmc_register_m_nGain_V_5=int_cmc_register_m_nGain_V_5;
    assign cmc_register_m_nGain_V_6=int_cmc_register_m_nGain_V_6;
    assign cmc_register_m_nGain_V_7=int_cmc_register_m_nGain_V_7;
    assign cmc_register_m_nGain_V_8=int_cmc_register_m_nGain_V_8;
    assign cmc_register_m_nGain_V_9=int_cmc_register_m_nGain_V_9;
    assign cmc_register_m_nGain_V_10=int_cmc_register_m_nGain_V_10;
    assign cmc_register_m_nGain_V_11=int_cmc_register_m_nGain_V_11;
    assign cmc_register_m_bCFCEnable=int_cmc_register_m_bCFCEnable;
    assign cmc_register_m_bDiscardH=int_cmc_register_m_bDiscardH;
    assign cmc_register_m_pHueRange_V_0=int_cmc_register_m_pHueRange_V_0;
    assign cmc_register_m_pHueRange_V_1=int_cmc_register_m_pHueRange_V_1;
    assign cmc_register_m_nHueBandShift_V=int_cmc_register_m_nHueBandShift_V;
    assign cmc_register_m_nEdgeThre_V=int_cmc_register_m_nEdgeThre_V;
    assign cmc_register_m_nEdgeBandShift_V=int_cmc_register_m_nEdgeBandShift_V;
    assign cmc_register_m_nCFCStrength_V=int_cmc_register_m_nCFCStrength_V;
    assign gtm_register_eb=int_gtm_register_eb;
    assign gtm_register_m_bDitheringEnable=int_gtm_register_m_bDitheringEnable;
    assign gtm_register_gtmTab_V_0=int_gtm_register_int_gtmTab_V_0;
    assign gtm_register_gtmTab_V_1=int_gtm_register_int_gtmTab_V_1;
    assign gtm_register_gtmTab_V_2=int_gtm_register_int_gtmTab_V_2;
    assign gtm_register_gtmTab_V_3=int_gtm_register_int_gtmTab_V_3;
    assign gtm_register_gtmTab_V_4=int_gtm_register_int_gtmTab_V_4;
    assign gtm_register_gtmTab_V_5=int_gtm_register_int_gtmTab_V_5;
    assign gtm_register_gtmTab_V_6=int_gtm_register_int_gtmTab_V_6;
    assign gtm_register_gtmTab_V_7=int_gtm_register_int_gtmTab_V_7;
    assign gtm_register_gtmTab_V_8=int_gtm_register_int_gtmTab_V_8;
    assign gtm_register_gtmTab_V_9=int_gtm_register_int_gtmTab_V_9;
    assign gtm_register_gtmTab_V_10=int_gtm_register_int_gtmTab_V_10;
    assign gtm_register_gtmTab_V_11=int_gtm_register_int_gtmTab_V_11;
    assign gtm_register_gtmTab_V_12=int_gtm_register_int_gtmTab_V_12;
    assign gtm_register_gtmTab_V_13=int_gtm_register_int_gtmTab_V_13;
    assign gtm_register_gtmTab_V_14=int_gtm_register_int_gtmTab_V_14;
    assign gtm_register_gtmTab_V_15=int_gtm_register_int_gtmTab_V_15;
    assign gtm_register_gtmTab_V_16=int_gtm_register_int_gtmTab_V_16;
    assign gtm_register_gtmTab_V_17=int_gtm_register_int_gtmTab_V_17;
    assign gtm_register_gtmTab_V_18=int_gtm_register_int_gtmTab_V_18;
    assign gtm_register_gtmTab_V_19=int_gtm_register_int_gtmTab_V_19;
    assign gtm_register_gtmTab_V_20=int_gtm_register_int_gtmTab_V_20;
    assign gtm_register_gtmTab_V_21=int_gtm_register_int_gtmTab_V_21;
    assign gtm_register_gtmTab_V_22=int_gtm_register_int_gtmTab_V_22;
    assign gtm_register_gtmTab_V_23=int_gtm_register_int_gtmTab_V_23;
    assign gtm_register_gtmTab_V_24=int_gtm_register_int_gtmTab_V_24;
    assign gtm_register_gtmTab_V_25=int_gtm_register_int_gtmTab_V_25;
    assign gtm_register_gtmTab_V_26=int_gtm_register_int_gtmTab_V_26;
    assign gtm_register_gtmTab_V_27=int_gtm_register_int_gtmTab_V_27;
    assign gtm_register_gtmTab_V_28=int_gtm_register_int_gtmTab_V_28;
    assign gtm_register_gtmTab_V_29=int_gtm_register_int_gtmTab_V_29;
    assign gtm_register_gtmTab_V_30=int_gtm_register_int_gtmTab_V_30;
    assign gtm_register_gtmTab_V_31=int_gtm_register_int_gtmTab_V_31;
    assign gtm_register_gtmTab_V_32=int_gtm_register_int_gtmTab_V_32;
    assign gtm_register_gtmTab_V_33=int_gtm_register_int_gtmTab_V_33;
    assign gtm_register_gtmTab_V_34=int_gtm_register_int_gtmTab_V_34;
    assign gtm_register_gtmTab_V_35=int_gtm_register_int_gtmTab_V_35;
    assign gtm_register_gtmTab_V_36=int_gtm_register_int_gtmTab_V_36;
    assign gtm_register_gtmTab_V_37=int_gtm_register_int_gtmTab_V_37;
    assign gtm_register_gtmTab_V_38=int_gtm_register_int_gtmTab_V_38;
    assign gtm_register_gtmTab_V_39=int_gtm_register_int_gtmTab_V_39;
    assign gtm_register_gtmTab_V_40=int_gtm_register_int_gtmTab_V_40;
    assign gtm_register_gtmTab_V_41=int_gtm_register_int_gtmTab_V_41;
    assign gtm_register_gtmTab_V_42=int_gtm_register_int_gtmTab_V_42;
    assign gtm_register_gtmTab_V_43=int_gtm_register_int_gtmTab_V_43;
    assign gtm_register_gtmTab_V_44=int_gtm_register_int_gtmTab_V_44;
    assign gtm_register_gtmTab_V_45=int_gtm_register_int_gtmTab_V_45;
    assign gtm_register_gtmTab_V_46=int_gtm_register_int_gtmTab_V_46;
    assign gtm_register_gtmTab_V_47=int_gtm_register_int_gtmTab_V_47;
    assign gtm_register_gtmTab_V_48=int_gtm_register_int_gtmTab_V_48;
    assign gtm_register_gtmTab_V_49=int_gtm_register_int_gtmTab_V_49;
    assign gtm_register_gtmTab_V_50=int_gtm_register_int_gtmTab_V_50;
    assign gtm_register_gtmTab_V_51=int_gtm_register_int_gtmTab_V_51;
    assign gtm_register_gtmTab_V_52=int_gtm_register_int_gtmTab_V_52;
    assign gtm_register_gtmTab_V_53=int_gtm_register_int_gtmTab_V_53;
    assign gtm_register_gtmTab_V_54=int_gtm_register_int_gtmTab_V_54;
    assign gtm_register_gtmTab_V_55=int_gtm_register_int_gtmTab_V_55;
    assign gtm_register_gtmTab_V_56=int_gtm_register_int_gtmTab_V_56;
    assign gtm_register_gtmTab_V_57=int_gtm_register_int_gtmTab_V_57;
    assign gtm_register_gtmTab_V_58=int_gtm_register_int_gtmTab_V_58;
    assign gtm_register_gtmTab_V_59=int_gtm_register_int_gtmTab_V_59;
    assign gtm_register_gtmTab_V_60=int_gtm_register_int_gtmTab_V_60;
    assign gtm_register_gtmTab_V_61=int_gtm_register_int_gtmTab_V_61;
    assign gtm_register_gtmTab_V_62=int_gtm_register_int_gtmTab_V_62;
    assign gtm_register_gtmTab_V_63=int_gtm_register_int_gtmTab_V_63;
    assign gtm_register_gtmTab_V_64=int_gtm_register_int_gtmTab_V_64;
    assign gtm_register_gtmTab_V_65=int_gtm_register_int_gtmTab_V_65;
    assign gtm_register_gtmTab_V_66=int_gtm_register_int_gtmTab_V_66;
    assign gtm_register_gtmTab_V_67=int_gtm_register_int_gtmTab_V_67;
    assign gtm_register_gtmTab_V_68=int_gtm_register_int_gtmTab_V_68;
    assign gtm_register_gtmTab_V_69=int_gtm_register_int_gtmTab_V_69;
    assign gtm_register_gtmTab_V_70=int_gtm_register_int_gtmTab_V_70;
    assign gtm_register_gtmTab_V_71=int_gtm_register_int_gtmTab_V_71;
    assign gtm_register_gtmTab_V_72=int_gtm_register_int_gtmTab_V_72;
    assign gtm_register_gtmTab_V_73=int_gtm_register_int_gtmTab_V_73;
    assign gtm_register_gtmTab_V_74=int_gtm_register_int_gtmTab_V_74;
    assign gtm_register_gtmTab_V_75=int_gtm_register_int_gtmTab_V_75;
    assign gtm_register_gtmTab_V_76=int_gtm_register_int_gtmTab_V_76;
    assign gtm_register_gtmTab_V_77=int_gtm_register_int_gtmTab_V_77;
    assign gtm_register_gtmTab_V_78=int_gtm_register_int_gtmTab_V_78;
    assign gtm_register_gtmTab_V_79=int_gtm_register_int_gtmTab_V_79;
    assign gtm_register_gtmTab_V_80=int_gtm_register_int_gtmTab_V_80;
    assign gtm_register_gtmTab_V_81=int_gtm_register_int_gtmTab_V_81;
    assign gtm_register_gtmTab_V_82=int_gtm_register_int_gtmTab_V_82;
    assign gtm_register_gtmTab_V_83=int_gtm_register_int_gtmTab_V_83;
    assign gtm_register_gtmTab_V_84=int_gtm_register_int_gtmTab_V_84;
    assign gtm_register_gtmTab_V_85=int_gtm_register_int_gtmTab_V_85;
    assign gtm_register_gtmTab_V_86=int_gtm_register_int_gtmTab_V_86;
    assign gtm_register_gtmTab_V_87=int_gtm_register_int_gtmTab_V_87;
    assign gtm_register_gtmTab_V_88=int_gtm_register_int_gtmTab_V_88;
    assign gtm_register_gtmTab_V_89=int_gtm_register_int_gtmTab_V_89;
    assign gtm_register_gtmTab_V_90=int_gtm_register_int_gtmTab_V_90;
    assign gtm_register_gtmTab_V_91=int_gtm_register_int_gtmTab_V_91;
    assign gtm_register_gtmTab_V_92=int_gtm_register_int_gtmTab_V_92;
    assign gtm_register_gtmTab_V_93=int_gtm_register_int_gtmTab_V_93;
    assign gtm_register_gtmTab_V_94=int_gtm_register_int_gtmTab_V_94;
    assign gtm_register_gtmTab_V_95=int_gtm_register_int_gtmTab_V_95;
    assign gtm_register_gtmTab_V_96=int_gtm_register_int_gtmTab_V_96;
    assign gtm_register_gtmTab_V_97=int_gtm_register_int_gtmTab_V_97;
    assign gtm_register_gtmTab_V_98=int_gtm_register_int_gtmTab_V_98;
    assign gtm_register_gtmTab_V_99=int_gtm_register_int_gtmTab_V_99;
    assign gtm_register_gtmTab_V_100=int_gtm_register_int_gtmTab_V_100;
    assign gtm_register_gtmTab_V_101=int_gtm_register_int_gtmTab_V_101;
    assign gtm_register_gtmTab_V_102=int_gtm_register_int_gtmTab_V_102;
    assign gtm_register_gtmTab_V_103=int_gtm_register_int_gtmTab_V_103;
    assign gtm_register_gtmTab_V_104=int_gtm_register_int_gtmTab_V_104;
    assign gtm_register_gtmTab_V_105=int_gtm_register_int_gtmTab_V_105;
    assign gtm_register_gtmTab_V_106=int_gtm_register_int_gtmTab_V_106;
    assign gtm_register_gtmTab_V_107=int_gtm_register_int_gtmTab_V_107;
    assign gtm_register_gtmTab_V_108=int_gtm_register_int_gtmTab_V_108;
    assign gtm_register_gtmTab_V_109=int_gtm_register_int_gtmTab_V_109;
    assign gtm_register_gtmTab_V_110=int_gtm_register_int_gtmTab_V_110;
    assign gtm_register_gtmTab_V_111=int_gtm_register_int_gtmTab_V_111;
    assign gtm_register_gtmTab_V_112=int_gtm_register_int_gtmTab_V_112;
    assign gtm_register_gtmTab_V_113=int_gtm_register_int_gtmTab_V_113;
    assign gtm_register_gtmTab_V_114=int_gtm_register_int_gtmTab_V_114;
    assign gtm_register_gtmTab_V_115=int_gtm_register_int_gtmTab_V_115;
    assign gtm_register_gtmTab_V_116=int_gtm_register_int_gtmTab_V_116;
    assign gtm_register_gtmTab_V_117=int_gtm_register_int_gtmTab_V_117;
    assign gtm_register_gtmTab_V_118=int_gtm_register_int_gtmTab_V_118;
    assign gtm_register_gtmTab_V_119=int_gtm_register_int_gtmTab_V_119;
    assign gtm_register_gtmTab_V_120=int_gtm_register_int_gtmTab_V_120;
    assign gtm_register_gtmTab_V_121=int_gtm_register_int_gtmTab_V_121;
    assign gtm_register_gtmTab_V_122=int_gtm_register_int_gtmTab_V_122;
    assign gtm_register_gtmTab_V_123=int_gtm_register_int_gtmTab_V_123;
    assign gtm_register_gtmTab_V_124=int_gtm_register_int_gtmTab_V_124;
    assign gtm_register_gtmTab_V_125=int_gtm_register_int_gtmTab_V_125;
    assign gtm_register_gtmTab_V_126=int_gtm_register_int_gtmTab_V_126;
    assign gtm_register_gtmTab_V_127=int_gtm_register_int_gtmTab_V_127;
    assign gtm_register_gtmTab_V_128=int_gtm_register_int_gtmTab_V_128;
    assign ltm_register_m_nEb_V=int_ltm_register_m_nEb_V;
    assign ltm_register_contrast_V=int_ltm_register_contrast_V;
    assign ltm_register_ratio_V=int_ltm_register_ratio_V;
    assign cac_register_eb=int_cac_register_eb;
    assign cac_register_t_transient_V=int_cac_register_t_transient_V;
    assign cac_register_t_edge_V=int_cac_register_t_edge_V;
    assign csc_register_m_nEb=int_csc_register_m_nEb;
    assign csc_register_coeff_V_0=int_csc_register_coeff_V_0;
    assign csc_register_coeff_V_1=int_csc_register_coeff_V_1;
    assign csc_register_coeff_V_2=int_csc_register_coeff_V_2;
    assign csc_register_coeff_V_3=int_csc_register_coeff_V_3;
    assign csc_register_coeff_V_4=int_csc_register_coeff_V_4;
    assign csc_register_coeff_V_5=int_csc_register_coeff_V_5;
    assign csc_register_coeff_V_6=int_csc_register_coeff_V_6;
    assign csc_register_coeff_V_7=int_csc_register_coeff_V_7;
    assign csc_register_coeff_V_8=int_csc_register_coeff_V_8;
    assign csc_register_coeff_V_9=int_csc_register_coeff_V_9;
    assign csc_register_coeff_V_10=int_csc_register_coeff_V_10;
    assign csc_register_coeff_V_11=int_csc_register_coeff_V_11;
    assign yfc_register_m_nEb=int_yfc_register_m_nEb;
    assign yfc_register_yuvpattern=int_yfc_register_yuvpattern;
    assign yuvdns_register_eb_V=int_yuvdns_register_eb_V;
    assign yuvdns_register_ysigma2_V=int_yuvdns_register_ysigma2_V;
    assign yuvdns_register_yinvsigma2_V=int_yuvdns_register_yinvsigma2_V;
    assign yuvdns_register_uvsigma2_V=int_yuvdns_register_uvsigma2_V;
    assign yuvdns_register_uvinvsigma2_V=int_yuvdns_register_uvinvsigma2_V;
    assign yuvdns_register_yfilt_V=int_yuvdns_register_yfilt_V;
    assign yuvdns_register_uvfilt_V=int_yuvdns_register_uvfilt_V;
    assign yuvdns_register_yinvfilt_V=int_yuvdns_register_yinvfilt_V;
    assign yuvdns_register_uvinvfilt_V=int_yuvdns_register_uvinvfilt_V;
    assign yuvdns_register_yH2_V=int_yuvdns_register_yH2_V;
    assign yuvdns_register_yinvH2_V=int_yuvdns_register_yinvH2_V;
    assign yuvdns_register_uvH2_V=int_yuvdns_register_uvH2_V;
    assign yuvdns_register_uvinvH2_V=int_yuvdns_register_uvinvH2_V;
    assign scaledown_register_m_nEb=int_scaledown_register_m_nEb;
    assign scaledown_register_yuvpattern_V=int_scaledown_register_yuvpattern_V;
    assign scaledown_register_times_V=int_scaledown_register_times_V;
    assign crop_register_m_nEb=int_crop_register_m_nEb;
    assign crop_register_upper_left_x_V=int_crop_register_upper_left_x_V;
    assign crop_register_upper_left_y_V=int_crop_register_upper_left_y_V;
    assign crop_register_lower_right_x_V=int_crop_register_lower_right_x_V;
    assign crop_register_lower_right_y_V=int_crop_register_lower_right_y_V;
    assign crop_register_yuvpattern_V=int_crop_register_yuvpattern_V;

    assign isp_read_raw_addr=int_isp_read_raw_addr;
    assign isp_write_y_addr=int_isp_write_y_addr;
    assign isp_write_u_addr=int_isp_write_u_addr;
    assign isp_write_v_addr=int_isp_write_v_addr;
    assign burst_one_frame_total=int_burst_one_frame_total;



 
    /************************************************/
    reg                           int_read_start = 1'b0;
 

//------------------------Instantiation------------------

//------------------------AXI write fsm------------------
assign AWREADY = (wstate == WRIDLE);
assign WREADY  = (wstate == WRDATA);
assign BRESP   = 2'b00;  // OKAY
assign BVALID  = (wstate == WRRESP);
assign wmask   = { {8{WSTRB[3]}}, {8{WSTRB[2]}}, {8{WSTRB[1]}}, {8{WSTRB[0]}} };
assign aw_hs   = AWVALID & AWREADY;
assign w_hs    = WVALID & WREADY;

// wstate
always @(posedge ACLK) begin
    if (ARESET)
        wstate <= WRRESET;
    else if (ACLK_EN)
        wstate <= wnext;
end

// wnext
always @(*) begin
    case (wstate)
        WRIDLE:
            if (AWVALID)
                wnext = WRDATA;
            else
                wnext = WRIDLE;
        WRDATA:
            if (WVALID)
                wnext = WRRESP;
            else
                wnext = WRDATA;
        WRRESP:
            if (BREADY)
                wnext = WRIDLE;
            else
                wnext = WRRESP;
        default:
            wnext = WRIDLE;
    endcase
end

// waddr
always @(posedge ACLK) begin
    if (ACLK_EN) begin
        if (aw_hs)
            waddr <= AWADDR[ADDR_BITS-1:0];
    end
end

//------------------------AXI read fsm-------------------
assign ARREADY = (rstate == RDIDLE);
assign RDATA   = rdata;
assign RRESP   = 2'b00;  // OKAY
assign RVALID  = (rstate == RDDATA);
assign ar_hs   = ARVALID & ARREADY;
assign raddr   = ARADDR[ADDR_BITS-1:0];

// rstate
always @(posedge ACLK) begin
    if (ARESET)
        rstate <= RDRESET;
    else if (ACLK_EN)
        rstate <= rnext;
end

// rnext
always @(*) begin
    case (rstate)
        RDIDLE:
            if (ARVALID)
                rnext = RDDATA;
            else
                rnext = RDIDLE;
        RDDATA:
            if (RREADY & RVALID)
                rnext = RDIDLE;
            else
                rnext = RDDATA;
        default:
            rnext = RDIDLE;
    endcase
end

// rdata
always @(posedge ACLK) begin
    if (ACLK_EN) begin
        if (ar_hs) begin
            rdata <= 32'b0;
            case (raddr)
                ADDR_START: begin
                    rdata <= {31'b0, read_start};
                end
                ADDR_IDLE_READY_DONE: begin
                    rdata <= {29'b0,ap_idle,ap_ready,ap_done};
                end
                
                ADDR_TOP_REGISTER_FRAMEWIDTH_V: begin
                    rdata <=int_top_register_frameWidth_V;
                end
                ADDR_TOP_REGISTER_FRAMEHEIGHT_V: begin
                    rdata <=int_top_register_frameHeight_V;
                end
                ADDR_TOP_REGISTER_INPUTFORMAT: begin
                    rdata <=int_top_register_inputFormat;
                end
                ADDR_TOP_REGISTER_IMGPATTERN_V: begin
                    rdata <=int_top_register_imgPattern_V;
                end
                ADDR_TOP_REGISTER_PIPEMODE_V: begin
                    rdata <=int_top_register_pipeMode_V;
                end
                ADDR_TOP_REGISTER_BLC_V: begin
                    rdata <=int_top_register_blc_V;
                end
                ADDR_TOP_REGISTER_SHADOWEB: begin
                    rdata <=int_top_register_shadowEb;
                end
                ADDR_TOP_REGISTER_BINNINGFRAMEWIDTH_V: begin
                    rdata <=int_top_register_binningFrameWidth_V;
                end
                ADDR_TOP_REGISTER_BINNINGFRAMEHEIGHT_V: begin
                    rdata <=int_top_register_binningFrameHeight_V;
                end
                ADDR_TOP_REGISTER_SCALERFRAMEWIDTH_V: begin
                    rdata <=int_top_register_scalerFrameWidth_V;
                end
                ADDR_TOP_REGISTER_SCALERFRAMEHEIGHT_V: begin
                    rdata <=int_top_register_scalerFrameHeight_V;
                end
                ADDR_TPG_REGISTER_M_BTPG_EN: begin
                    rdata <=int_tpg_register_m_bTPG_en;
                end
                ADDR_TPG_REGISTER_M_NWIDTH_V: begin
                    rdata <=int_tpg_register_m_nWidth_V;
                end
                ADDR_TPG_REGISTER_M_NHEIGHT_V: begin
                    rdata <=int_tpg_register_m_nHeight_V;
                end
                ADDR_TPG_REGISTER_M_NCFAPATTERN_V: begin
                    rdata <=int_tpg_register_m_nCFAPattern_V;
                end
                ADDR_TPG_REGISTER_M_BROLLINGENABLE: begin
                    rdata <=int_tpg_register_m_bRollingEnable;
                end
                ADDR_TPG_REGISTER_M_BSENSOR_TIMING_EN: begin
                    rdata <=int_tpg_register_m_bSensor_timing_en;
                end
                ADDR_TPG_REGISTER_M_NVBLANK_NUM_V: begin
                    rdata <=int_tpg_register_m_nVBlank_num_V;
                end
                ADDR_TPG_REGISTER_M_NHBLANK_NUM_V: begin
                    rdata <=int_tpg_register_m_nHBlank_num_V;
                end
                ADDR_TPG_REGISTER_M_VALID_BLANK_V: begin
                    rdata <=int_tpg_register_m_valid_blank_V;
                end
                ADDR_TPG_REGISTER_M_NID_V: begin
                    rdata <=int_tpg_register_m_nID_V;
                end
                ADDR_DGAIN_REGISTER_M_NEB: begin
                    rdata <=int_dgain_register_m_nEb;
                end
                ADDR_DGAIN_REGISTER_M_NBLCR_V: begin
                    rdata <=int_dgain_register_m_nBlcR_V;
                end
                ADDR_DGAIN_REGISTER_M_NBLCGR_V: begin
                    rdata <=int_dgain_register_m_nBlcGr_V;
                end
                ADDR_DGAIN_REGISTER_M_NBLCGB_V: begin
                    rdata <=int_dgain_register_m_nBlcGb_V;
                end
                ADDR_DGAIN_REGISTER_M_NBLCB_V: begin
                    rdata <=int_dgain_register_m_nBlcB_V;
                end
                ADDR_DGAIN_REGISTER_M_NR_V: begin
                    rdata <=int_dgain_register_m_nR_V;
                end
                ADDR_DGAIN_REGISTER_M_NGR_V: begin
                    rdata <=int_dgain_register_m_nGr_V;
                end
                ADDR_DGAIN_REGISTER_M_NGB_V: begin
                    rdata <=int_dgain_register_m_nGb_V;
                end
                ADDR_DGAIN_REGISTER_M_NB_V: begin
                    rdata <=int_dgain_register_m_nB_V;
                end
                ADDR_LSC_REGISTER_EB: begin
                    rdata <=int_lsc_register_eb;
                end
                ADDR_LSC_REGISTER_RGAIN_V_0: begin
                    rdata <=int_lsc_register_rGain_V_0;
                end
                ADDR_LSC_REGISTER_RGAIN_V_1: begin
                    rdata <=int_lsc_register_rGain_V_1;
                end
                ADDR_LSC_REGISTER_RGAIN_V_2: begin
                    rdata <=int_lsc_register_rGain_V_2;
                end
                ADDR_LSC_REGISTER_RGAIN_V_3: begin
                    rdata <=int_lsc_register_rGain_V_3;
                end
                ADDR_LSC_REGISTER_RGAIN_V_4: begin
                    rdata <=int_lsc_register_rGain_V_4;
                end
                ADDR_LSC_REGISTER_RGAIN_V_5: begin
                    rdata <=int_lsc_register_rGain_V_5;
                end
                ADDR_LSC_REGISTER_RGAIN_V_6: begin
                    rdata <=int_lsc_register_rGain_V_6;
                end
                ADDR_LSC_REGISTER_RGAIN_V_7: begin
                    rdata <=int_lsc_register_rGain_V_7;
                end
                ADDR_LSC_REGISTER_RGAIN_V_8: begin
                    rdata <=int_lsc_register_rGain_V_8;
                end
                ADDR_LSC_REGISTER_RGAIN_V_9: begin
                    rdata <=int_lsc_register_rGain_V_9;
                end
                ADDR_LSC_REGISTER_RGAIN_V_10: begin
                    rdata <=int_lsc_register_rGain_V_10;
                end
                ADDR_LSC_REGISTER_RGAIN_V_11: begin
                    rdata <=int_lsc_register_rGain_V_11;
                end
                ADDR_LSC_REGISTER_RGAIN_V_12: begin
                    rdata <=int_lsc_register_rGain_V_12;
                end
                ADDR_LSC_REGISTER_RGAIN_V_13: begin
                    rdata <=int_lsc_register_rGain_V_13;
                end
                ADDR_LSC_REGISTER_RGAIN_V_14: begin
                    rdata <=int_lsc_register_rGain_V_14;
                end
                ADDR_LSC_REGISTER_RGAIN_V_15: begin
                    rdata <=int_lsc_register_rGain_V_15;
                end
                ADDR_LSC_REGISTER_RGAIN_V_16: begin
                    rdata <=int_lsc_register_rGain_V_16;
                end
                ADDR_LSC_REGISTER_RGAIN_V_17: begin
                    rdata <=int_lsc_register_rGain_V_17;
                end
                ADDR_LSC_REGISTER_RGAIN_V_18: begin
                    rdata <=int_lsc_register_rGain_V_18;
                end
                ADDR_LSC_REGISTER_RGAIN_V_19: begin
                    rdata <=int_lsc_register_rGain_V_19;
                end
                ADDR_LSC_REGISTER_RGAIN_V_20: begin
                    rdata <=int_lsc_register_rGain_V_20;
                end
                ADDR_LSC_REGISTER_RGAIN_V_21: begin
                    rdata <=int_lsc_register_rGain_V_21;
                end
                ADDR_LSC_REGISTER_RGAIN_V_22: begin
                    rdata <=int_lsc_register_rGain_V_22;
                end
                ADDR_LSC_REGISTER_RGAIN_V_23: begin
                    rdata <=int_lsc_register_rGain_V_23;
                end
                ADDR_LSC_REGISTER_RGAIN_V_24: begin
                    rdata <=int_lsc_register_rGain_V_24;
                end
                ADDR_LSC_REGISTER_RGAIN_V_25: begin
                    rdata <=int_lsc_register_rGain_V_25;
                end
                ADDR_LSC_REGISTER_RGAIN_V_26: begin
                    rdata <=int_lsc_register_rGain_V_26;
                end
                ADDR_LSC_REGISTER_RGAIN_V_27: begin
                    rdata <=int_lsc_register_rGain_V_27;
                end
                ADDR_LSC_REGISTER_RGAIN_V_28: begin
                    rdata <=int_lsc_register_rGain_V_28;
                end
                ADDR_LSC_REGISTER_RGAIN_V_29: begin
                    rdata <=int_lsc_register_rGain_V_29;
                end
                ADDR_LSC_REGISTER_RGAIN_V_30: begin
                    rdata <=int_lsc_register_rGain_V_30;
                end
                ADDR_LSC_REGISTER_RGAIN_V_31: begin
                    rdata <=int_lsc_register_rGain_V_31;
                end
                ADDR_LSC_REGISTER_RGAIN_V_32: begin
                    rdata <=int_lsc_register_rGain_V_32;
                end
                ADDR_LSC_REGISTER_RGAIN_V_33: begin
                    rdata <=int_lsc_register_rGain_V_33;
                end
                ADDR_LSC_REGISTER_RGAIN_V_34: begin
                    rdata <=int_lsc_register_rGain_V_34;
                end
                ADDR_LSC_REGISTER_RGAIN_V_35: begin
                    rdata <=int_lsc_register_rGain_V_35;
                end
                ADDR_LSC_REGISTER_RGAIN_V_36: begin
                    rdata <=int_lsc_register_rGain_V_36;
                end
                ADDR_LSC_REGISTER_RGAIN_V_37: begin
                    rdata <=int_lsc_register_rGain_V_37;
                end
                ADDR_LSC_REGISTER_RGAIN_V_38: begin
                    rdata <=int_lsc_register_rGain_V_38;
                end
                ADDR_LSC_REGISTER_RGAIN_V_39: begin
                    rdata <=int_lsc_register_rGain_V_39;
                end
                ADDR_LSC_REGISTER_RGAIN_V_40: begin
                    rdata <=int_lsc_register_rGain_V_40;
                end
                ADDR_LSC_REGISTER_RGAIN_V_41: begin
                    rdata <=int_lsc_register_rGain_V_41;
                end
                ADDR_LSC_REGISTER_RGAIN_V_42: begin
                    rdata <=int_lsc_register_rGain_V_42;
                end
                ADDR_LSC_REGISTER_RGAIN_V_43: begin
                    rdata <=int_lsc_register_rGain_V_43;
                end
                ADDR_LSC_REGISTER_RGAIN_V_44: begin
                    rdata <=int_lsc_register_rGain_V_44;
                end
                ADDR_LSC_REGISTER_RGAIN_V_45: begin
                    rdata <=int_lsc_register_rGain_V_45;
                end
                ADDR_LSC_REGISTER_RGAIN_V_46: begin
                    rdata <=int_lsc_register_rGain_V_46;
                end
                ADDR_LSC_REGISTER_RGAIN_V_47: begin
                    rdata <=int_lsc_register_rGain_V_47;
                end
                ADDR_LSC_REGISTER_RGAIN_V_48: begin
                    rdata <=int_lsc_register_rGain_V_48;
                end
                ADDR_LSC_REGISTER_RGAIN_V_49: begin
                    rdata <=int_lsc_register_rGain_V_49;
                end
                ADDR_LSC_REGISTER_RGAIN_V_50: begin
                    rdata <=int_lsc_register_rGain_V_50;
                end
                ADDR_LSC_REGISTER_RGAIN_V_51: begin
                    rdata <=int_lsc_register_rGain_V_51;
                end
                ADDR_LSC_REGISTER_RGAIN_V_52: begin
                    rdata <=int_lsc_register_rGain_V_52;
                end
                ADDR_LSC_REGISTER_RGAIN_V_53: begin
                    rdata <=int_lsc_register_rGain_V_53;
                end
                ADDR_LSC_REGISTER_RGAIN_V_54: begin
                    rdata <=int_lsc_register_rGain_V_54;
                end
                ADDR_LSC_REGISTER_RGAIN_V_55: begin
                    rdata <=int_lsc_register_rGain_V_55;
                end
                ADDR_LSC_REGISTER_RGAIN_V_56: begin
                    rdata <=int_lsc_register_rGain_V_56;
                end
                ADDR_LSC_REGISTER_RGAIN_V_57: begin
                    rdata <=int_lsc_register_rGain_V_57;
                end
                ADDR_LSC_REGISTER_RGAIN_V_58: begin
                    rdata <=int_lsc_register_rGain_V_58;
                end
                ADDR_LSC_REGISTER_RGAIN_V_59: begin
                    rdata <=int_lsc_register_rGain_V_59;
                end
                ADDR_LSC_REGISTER_RGAIN_V_60: begin
                    rdata <=int_lsc_register_rGain_V_60;
                end
                ADDR_LSC_REGISTER_RGAIN_V_61: begin
                    rdata <=int_lsc_register_rGain_V_61;
                end
                ADDR_LSC_REGISTER_RGAIN_V_62: begin
                    rdata <=int_lsc_register_rGain_V_62;
                end
                ADDR_LSC_REGISTER_RGAIN_V_63: begin
                    rdata <=int_lsc_register_rGain_V_63;
                end
                ADDR_LSC_REGISTER_RGAIN_V_64: begin
                    rdata <=int_lsc_register_rGain_V_64;
                end
                ADDR_LSC_REGISTER_RGAIN_V_65: begin
                    rdata <=int_lsc_register_rGain_V_65;
                end
                ADDR_LSC_REGISTER_RGAIN_V_66: begin
                    rdata <=int_lsc_register_rGain_V_66;
                end
                ADDR_LSC_REGISTER_RGAIN_V_67: begin
                    rdata <=int_lsc_register_rGain_V_67;
                end
                ADDR_LSC_REGISTER_RGAIN_V_68: begin
                    rdata <=int_lsc_register_rGain_V_68;
                end
                ADDR_LSC_REGISTER_RGAIN_V_69: begin
                    rdata <=int_lsc_register_rGain_V_69;
                end
                ADDR_LSC_REGISTER_RGAIN_V_70: begin
                    rdata <=int_lsc_register_rGain_V_70;
                end
                ADDR_LSC_REGISTER_RGAIN_V_71: begin
                    rdata <=int_lsc_register_rGain_V_71;
                end
                ADDR_LSC_REGISTER_RGAIN_V_72: begin
                    rdata <=int_lsc_register_rGain_V_72;
                end
                ADDR_LSC_REGISTER_RGAIN_V_73: begin
                    rdata <=int_lsc_register_rGain_V_73;
                end
                ADDR_LSC_REGISTER_RGAIN_V_74: begin
                    rdata <=int_lsc_register_rGain_V_74;
                end
                ADDR_LSC_REGISTER_RGAIN_V_75: begin
                    rdata <=int_lsc_register_rGain_V_75;
                end
                ADDR_LSC_REGISTER_RGAIN_V_76: begin
                    rdata <=int_lsc_register_rGain_V_76;
                end
                ADDR_LSC_REGISTER_RGAIN_V_77: begin
                    rdata <=int_lsc_register_rGain_V_77;
                end
                ADDR_LSC_REGISTER_RGAIN_V_78: begin
                    rdata <=int_lsc_register_rGain_V_78;
                end
                ADDR_LSC_REGISTER_RGAIN_V_79: begin
                    rdata <=int_lsc_register_rGain_V_79;
                end
                ADDR_LSC_REGISTER_RGAIN_V_80: begin
                    rdata <=int_lsc_register_rGain_V_80;
                end
                ADDR_LSC_REGISTER_RGAIN_V_81: begin
                    rdata <=int_lsc_register_rGain_V_81;
                end
                ADDR_LSC_REGISTER_RGAIN_V_82: begin
                    rdata <=int_lsc_register_rGain_V_82;
                end
                ADDR_LSC_REGISTER_RGAIN_V_83: begin
                    rdata <=int_lsc_register_rGain_V_83;
                end
                ADDR_LSC_REGISTER_RGAIN_V_84: begin
                    rdata <=int_lsc_register_rGain_V_84;
                end
                ADDR_LSC_REGISTER_RGAIN_V_85: begin
                    rdata <=int_lsc_register_rGain_V_85;
                end
                ADDR_LSC_REGISTER_RGAIN_V_86: begin
                    rdata <=int_lsc_register_rGain_V_86;
                end
                ADDR_LSC_REGISTER_RGAIN_V_87: begin
                    rdata <=int_lsc_register_rGain_V_87;
                end
                ADDR_LSC_REGISTER_RGAIN_V_88: begin
                    rdata <=int_lsc_register_rGain_V_88;
                end
                ADDR_LSC_REGISTER_RGAIN_V_89: begin
                    rdata <=int_lsc_register_rGain_V_89;
                end
                ADDR_LSC_REGISTER_RGAIN_V_90: begin
                    rdata <=int_lsc_register_rGain_V_90;
                end
                ADDR_LSC_REGISTER_RGAIN_V_91: begin
                    rdata <=int_lsc_register_rGain_V_91;
                end
                ADDR_LSC_REGISTER_RGAIN_V_92: begin
                    rdata <=int_lsc_register_rGain_V_92;
                end
                ADDR_LSC_REGISTER_RGAIN_V_93: begin
                    rdata <=int_lsc_register_rGain_V_93;
                end
                ADDR_LSC_REGISTER_RGAIN_V_94: begin
                    rdata <=int_lsc_register_rGain_V_94;
                end
                ADDR_LSC_REGISTER_RGAIN_V_95: begin
                    rdata <=int_lsc_register_rGain_V_95;
                end
                ADDR_LSC_REGISTER_RGAIN_V_96: begin
                    rdata <=int_lsc_register_rGain_V_96;
                end
                ADDR_LSC_REGISTER_RGAIN_V_97: begin
                    rdata <=int_lsc_register_rGain_V_97;
                end
                ADDR_LSC_REGISTER_RGAIN_V_98: begin
                    rdata <=int_lsc_register_rGain_V_98;
                end
                ADDR_LSC_REGISTER_RGAIN_V_99: begin
                    rdata <=int_lsc_register_rGain_V_99;
                end
                ADDR_LSC_REGISTER_RGAIN_V_100: begin
                    rdata <=int_lsc_register_rGain_V_100;
                end
                ADDR_LSC_REGISTER_RGAIN_V_101: begin
                    rdata <=int_lsc_register_rGain_V_101;
                end
                ADDR_LSC_REGISTER_RGAIN_V_102: begin
                    rdata <=int_lsc_register_rGain_V_102;
                end
                ADDR_LSC_REGISTER_RGAIN_V_103: begin
                    rdata <=int_lsc_register_rGain_V_103;
                end
                ADDR_LSC_REGISTER_RGAIN_V_104: begin
                    rdata <=int_lsc_register_rGain_V_104;
                end
                ADDR_LSC_REGISTER_RGAIN_V_105: begin
                    rdata <=int_lsc_register_rGain_V_105;
                end
                ADDR_LSC_REGISTER_RGAIN_V_106: begin
                    rdata <=int_lsc_register_rGain_V_106;
                end
                ADDR_LSC_REGISTER_RGAIN_V_107: begin
                    rdata <=int_lsc_register_rGain_V_107;
                end
                ADDR_LSC_REGISTER_RGAIN_V_108: begin
                    rdata <=int_lsc_register_rGain_V_108;
                end
                ADDR_LSC_REGISTER_RGAIN_V_109: begin
                    rdata <=int_lsc_register_rGain_V_109;
                end
                ADDR_LSC_REGISTER_RGAIN_V_110: begin
                    rdata <=int_lsc_register_rGain_V_110;
                end
                ADDR_LSC_REGISTER_RGAIN_V_111: begin
                    rdata <=int_lsc_register_rGain_V_111;
                end
                ADDR_LSC_REGISTER_RGAIN_V_112: begin
                    rdata <=int_lsc_register_rGain_V_112;
                end
                ADDR_LSC_REGISTER_RGAIN_V_113: begin
                    rdata <=int_lsc_register_rGain_V_113;
                end
                ADDR_LSC_REGISTER_RGAIN_V_114: begin
                    rdata <=int_lsc_register_rGain_V_114;
                end
                ADDR_LSC_REGISTER_RGAIN_V_115: begin
                    rdata <=int_lsc_register_rGain_V_115;
                end
                ADDR_LSC_REGISTER_RGAIN_V_116: begin
                    rdata <=int_lsc_register_rGain_V_116;
                end
                ADDR_LSC_REGISTER_RGAIN_V_117: begin
                    rdata <=int_lsc_register_rGain_V_117;
                end
                ADDR_LSC_REGISTER_RGAIN_V_118: begin
                    rdata <=int_lsc_register_rGain_V_118;
                end
                ADDR_LSC_REGISTER_RGAIN_V_119: begin
                    rdata <=int_lsc_register_rGain_V_119;
                end
                ADDR_LSC_REGISTER_RGAIN_V_120: begin
                    rdata <=int_lsc_register_rGain_V_120;
                end
                ADDR_LSC_REGISTER_RGAIN_V_121: begin
                    rdata <=int_lsc_register_rGain_V_121;
                end
                ADDR_LSC_REGISTER_RGAIN_V_122: begin
                    rdata <=int_lsc_register_rGain_V_122;
                end
                ADDR_LSC_REGISTER_RGAIN_V_123: begin
                    rdata <=int_lsc_register_rGain_V_123;
                end
                ADDR_LSC_REGISTER_RGAIN_V_124: begin
                    rdata <=int_lsc_register_rGain_V_124;
                end
                ADDR_LSC_REGISTER_RGAIN_V_125: begin
                    rdata <=int_lsc_register_rGain_V_125;
                end
                ADDR_LSC_REGISTER_RGAIN_V_126: begin
                    rdata <=int_lsc_register_rGain_V_126;
                end
                ADDR_LSC_REGISTER_RGAIN_V_127: begin
                    rdata <=int_lsc_register_rGain_V_127;
                end
                ADDR_LSC_REGISTER_RGAIN_V_128: begin
                    rdata <=int_lsc_register_rGain_V_128;
                end
                ADDR_LSC_REGISTER_RGAIN_V_129: begin
                    rdata <=int_lsc_register_rGain_V_129;
                end
                ADDR_LSC_REGISTER_RGAIN_V_130: begin
                    rdata <=int_lsc_register_rGain_V_130;
                end
                ADDR_LSC_REGISTER_RGAIN_V_131: begin
                    rdata <=int_lsc_register_rGain_V_131;
                end
                ADDR_LSC_REGISTER_RGAIN_V_132: begin
                    rdata <=int_lsc_register_rGain_V_132;
                end
                ADDR_LSC_REGISTER_RGAIN_V_133: begin
                    rdata <=int_lsc_register_rGain_V_133;
                end
                ADDR_LSC_REGISTER_RGAIN_V_134: begin
                    rdata <=int_lsc_register_rGain_V_134;
                end
                ADDR_LSC_REGISTER_RGAIN_V_135: begin
                    rdata <=int_lsc_register_rGain_V_135;
                end
                ADDR_LSC_REGISTER_RGAIN_V_136: begin
                    rdata <=int_lsc_register_rGain_V_136;
                end
                ADDR_LSC_REGISTER_RGAIN_V_137: begin
                    rdata <=int_lsc_register_rGain_V_137;
                end
                ADDR_LSC_REGISTER_RGAIN_V_138: begin
                    rdata <=int_lsc_register_rGain_V_138;
                end
                ADDR_LSC_REGISTER_RGAIN_V_139: begin
                    rdata <=int_lsc_register_rGain_V_139;
                end
                ADDR_LSC_REGISTER_RGAIN_V_140: begin
                    rdata <=int_lsc_register_rGain_V_140;
                end
                ADDR_LSC_REGISTER_RGAIN_V_141: begin
                    rdata <=int_lsc_register_rGain_V_141;
                end
                ADDR_LSC_REGISTER_RGAIN_V_142: begin
                    rdata <=int_lsc_register_rGain_V_142;
                end
                ADDR_LSC_REGISTER_RGAIN_V_143: begin
                    rdata <=int_lsc_register_rGain_V_143;
                end
                ADDR_LSC_REGISTER_RGAIN_V_144: begin
                    rdata <=int_lsc_register_rGain_V_144;
                end
                ADDR_LSC_REGISTER_RGAIN_V_145: begin
                    rdata <=int_lsc_register_rGain_V_145;
                end
                ADDR_LSC_REGISTER_RGAIN_V_146: begin
                    rdata <=int_lsc_register_rGain_V_146;
                end
                ADDR_LSC_REGISTER_RGAIN_V_147: begin
                    rdata <=int_lsc_register_rGain_V_147;
                end
                ADDR_LSC_REGISTER_RGAIN_V_148: begin
                    rdata <=int_lsc_register_rGain_V_148;
                end
                ADDR_LSC_REGISTER_RGAIN_V_149: begin
                    rdata <=int_lsc_register_rGain_V_149;
                end
                ADDR_LSC_REGISTER_RGAIN_V_150: begin
                    rdata <=int_lsc_register_rGain_V_150;
                end
                ADDR_LSC_REGISTER_RGAIN_V_151: begin
                    rdata <=int_lsc_register_rGain_V_151;
                end
                ADDR_LSC_REGISTER_RGAIN_V_152: begin
                    rdata <=int_lsc_register_rGain_V_152;
                end
                ADDR_LSC_REGISTER_RGAIN_V_153: begin
                    rdata <=int_lsc_register_rGain_V_153;
                end
                ADDR_LSC_REGISTER_RGAIN_V_154: begin
                    rdata <=int_lsc_register_rGain_V_154;
                end
                ADDR_LSC_REGISTER_RGAIN_V_155: begin
                    rdata <=int_lsc_register_rGain_V_155;
                end
                ADDR_LSC_REGISTER_RGAIN_V_156: begin
                    rdata <=int_lsc_register_rGain_V_156;
                end
                ADDR_LSC_REGISTER_RGAIN_V_157: begin
                    rdata <=int_lsc_register_rGain_V_157;
                end
                ADDR_LSC_REGISTER_RGAIN_V_158: begin
                    rdata <=int_lsc_register_rGain_V_158;
                end
                ADDR_LSC_REGISTER_RGAIN_V_159: begin
                    rdata <=int_lsc_register_rGain_V_159;
                end
                ADDR_LSC_REGISTER_RGAIN_V_160: begin
                    rdata <=int_lsc_register_rGain_V_160;
                end
                ADDR_LSC_REGISTER_RGAIN_V_161: begin
                    rdata <=int_lsc_register_rGain_V_161;
                end
                ADDR_LSC_REGISTER_RGAIN_V_162: begin
                    rdata <=int_lsc_register_rGain_V_162;
                end
                ADDR_LSC_REGISTER_RGAIN_V_163: begin
                    rdata <=int_lsc_register_rGain_V_163;
                end
                ADDR_LSC_REGISTER_RGAIN_V_164: begin
                    rdata <=int_lsc_register_rGain_V_164;
                end
                ADDR_LSC_REGISTER_RGAIN_V_165: begin
                    rdata <=int_lsc_register_rGain_V_165;
                end
                ADDR_LSC_REGISTER_RGAIN_V_166: begin
                    rdata <=int_lsc_register_rGain_V_166;
                end
                ADDR_LSC_REGISTER_RGAIN_V_167: begin
                    rdata <=int_lsc_register_rGain_V_167;
                end
                ADDR_LSC_REGISTER_RGAIN_V_168: begin
                    rdata <=int_lsc_register_rGain_V_168;
                end
                ADDR_LSC_REGISTER_RGAIN_V_169: begin
                    rdata <=int_lsc_register_rGain_V_169;
                end
                ADDR_LSC_REGISTER_RGAIN_V_170: begin
                    rdata <=int_lsc_register_rGain_V_170;
                end
                ADDR_LSC_REGISTER_RGAIN_V_171: begin
                    rdata <=int_lsc_register_rGain_V_171;
                end
                ADDR_LSC_REGISTER_RGAIN_V_172: begin
                    rdata <=int_lsc_register_rGain_V_172;
                end
                ADDR_LSC_REGISTER_RGAIN_V_173: begin
                    rdata <=int_lsc_register_rGain_V_173;
                end
                ADDR_LSC_REGISTER_RGAIN_V_174: begin
                    rdata <=int_lsc_register_rGain_V_174;
                end
                ADDR_LSC_REGISTER_RGAIN_V_175: begin
                    rdata <=int_lsc_register_rGain_V_175;
                end
                ADDR_LSC_REGISTER_RGAIN_V_176: begin
                    rdata <=int_lsc_register_rGain_V_176;
                end
                ADDR_LSC_REGISTER_RGAIN_V_177: begin
                    rdata <=int_lsc_register_rGain_V_177;
                end
                ADDR_LSC_REGISTER_RGAIN_V_178: begin
                    rdata <=int_lsc_register_rGain_V_178;
                end
                ADDR_LSC_REGISTER_RGAIN_V_179: begin
                    rdata <=int_lsc_register_rGain_V_179;
                end
                ADDR_LSC_REGISTER_RGAIN_V_180: begin
                    rdata <=int_lsc_register_rGain_V_180;
                end
                ADDR_LSC_REGISTER_RGAIN_V_181: begin
                    rdata <=int_lsc_register_rGain_V_181;
                end
                ADDR_LSC_REGISTER_RGAIN_V_182: begin
                    rdata <=int_lsc_register_rGain_V_182;
                end
                ADDR_LSC_REGISTER_RGAIN_V_183: begin
                    rdata <=int_lsc_register_rGain_V_183;
                end
                ADDR_LSC_REGISTER_RGAIN_V_184: begin
                    rdata <=int_lsc_register_rGain_V_184;
                end
                ADDR_LSC_REGISTER_RGAIN_V_185: begin
                    rdata <=int_lsc_register_rGain_V_185;
                end
                ADDR_LSC_REGISTER_RGAIN_V_186: begin
                    rdata <=int_lsc_register_rGain_V_186;
                end
                ADDR_LSC_REGISTER_RGAIN_V_187: begin
                    rdata <=int_lsc_register_rGain_V_187;
                end
                ADDR_LSC_REGISTER_RGAIN_V_188: begin
                    rdata <=int_lsc_register_rGain_V_188;
                end
                ADDR_LSC_REGISTER_RGAIN_V_189: begin
                    rdata <=int_lsc_register_rGain_V_189;
                end
                ADDR_LSC_REGISTER_RGAIN_V_190: begin
                    rdata <=int_lsc_register_rGain_V_190;
                end
                ADDR_LSC_REGISTER_RGAIN_V_191: begin
                    rdata <=int_lsc_register_rGain_V_191;
                end
                ADDR_LSC_REGISTER_RGAIN_V_192: begin
                    rdata <=int_lsc_register_rGain_V_192;
                end
                ADDR_LSC_REGISTER_RGAIN_V_193: begin
                    rdata <=int_lsc_register_rGain_V_193;
                end
                ADDR_LSC_REGISTER_RGAIN_V_194: begin
                    rdata <=int_lsc_register_rGain_V_194;
                end
                ADDR_LSC_REGISTER_RGAIN_V_195: begin
                    rdata <=int_lsc_register_rGain_V_195;
                end
                ADDR_LSC_REGISTER_RGAIN_V_196: begin
                    rdata <=int_lsc_register_rGain_V_196;
                end
                ADDR_LSC_REGISTER_RGAIN_V_197: begin
                    rdata <=int_lsc_register_rGain_V_197;
                end
                ADDR_LSC_REGISTER_RGAIN_V_198: begin
                    rdata <=int_lsc_register_rGain_V_198;
                end
                ADDR_LSC_REGISTER_RGAIN_V_199: begin
                    rdata <=int_lsc_register_rGain_V_199;
                end
                ADDR_LSC_REGISTER_RGAIN_V_200: begin
                    rdata <=int_lsc_register_rGain_V_200;
                end
                ADDR_LSC_REGISTER_RGAIN_V_201: begin
                    rdata <=int_lsc_register_rGain_V_201;
                end
                ADDR_LSC_REGISTER_RGAIN_V_202: begin
                    rdata <=int_lsc_register_rGain_V_202;
                end
                ADDR_LSC_REGISTER_RGAIN_V_203: begin
                    rdata <=int_lsc_register_rGain_V_203;
                end
                ADDR_LSC_REGISTER_RGAIN_V_204: begin
                    rdata <=int_lsc_register_rGain_V_204;
                end
                ADDR_LSC_REGISTER_RGAIN_V_205: begin
                    rdata <=int_lsc_register_rGain_V_205;
                end
                ADDR_LSC_REGISTER_RGAIN_V_206: begin
                    rdata <=int_lsc_register_rGain_V_206;
                end
                ADDR_LSC_REGISTER_RGAIN_V_207: begin
                    rdata <=int_lsc_register_rGain_V_207;
                end
                ADDR_LSC_REGISTER_RGAIN_V_208: begin
                    rdata <=int_lsc_register_rGain_V_208;
                end
                ADDR_LSC_REGISTER_RGAIN_V_209: begin
                    rdata <=int_lsc_register_rGain_V_209;
                end
                ADDR_LSC_REGISTER_RGAIN_V_210: begin
                    rdata <=int_lsc_register_rGain_V_210;
                end
                ADDR_LSC_REGISTER_RGAIN_V_211: begin
                    rdata <=int_lsc_register_rGain_V_211;
                end
                ADDR_LSC_REGISTER_RGAIN_V_212: begin
                    rdata <=int_lsc_register_rGain_V_212;
                end
                ADDR_LSC_REGISTER_RGAIN_V_213: begin
                    rdata <=int_lsc_register_rGain_V_213;
                end
                ADDR_LSC_REGISTER_RGAIN_V_214: begin
                    rdata <=int_lsc_register_rGain_V_214;
                end
                ADDR_LSC_REGISTER_RGAIN_V_215: begin
                    rdata <=int_lsc_register_rGain_V_215;
                end
                ADDR_LSC_REGISTER_RGAIN_V_216: begin
                    rdata <=int_lsc_register_rGain_V_216;
                end
                ADDR_LSC_REGISTER_RGAIN_V_217: begin
                    rdata <=int_lsc_register_rGain_V_217;
                end
                ADDR_LSC_REGISTER_RGAIN_V_218: begin
                    rdata <=int_lsc_register_rGain_V_218;
                end
                ADDR_LSC_REGISTER_RGAIN_V_219: begin
                    rdata <=int_lsc_register_rGain_V_219;
                end
                ADDR_LSC_REGISTER_RGAIN_V_220: begin
                    rdata <=int_lsc_register_rGain_V_220;
                end
                ADDR_LSC_REGISTER_GRGAIN_V_0: begin
                    rdata <=int_lsc_register_GrGain_V_0;
                end
                ADDR_LSC_REGISTER_GRGAIN_V_1: begin
                    rdata <=int_lsc_register_GrGain_V_1;
                end
                ADDR_LSC_REGISTER_GRGAIN_V_2: begin
                    rdata <=int_lsc_register_GrGain_V_2;
                end
                ADDR_LSC_REGISTER_GRGAIN_V_3: begin
                    rdata <=int_lsc_register_GrGain_V_3;
                end
                ADDR_LSC_REGISTER_GRGAIN_V_4: begin
                    rdata <=int_lsc_register_GrGain_V_4;
                end
                ADDR_LSC_REGISTER_GRGAIN_V_5: begin
                    rdata <=int_lsc_register_GrGain_V_5;
                end
                ADDR_LSC_REGISTER_GRGAIN_V_6: begin
                    rdata <=int_lsc_register_GrGain_V_6;
                end
                ADDR_LSC_REGISTER_GRGAIN_V_7: begin
                    rdata <=int_lsc_register_GrGain_V_7;
                end
                ADDR_LSC_REGISTER_GRGAIN_V_8: begin
                    rdata <=int_lsc_register_GrGain_V_8;
                end
                ADDR_LSC_REGISTER_GRGAIN_V_9: begin
                    rdata <=int_lsc_register_GrGain_V_9;
                end
                ADDR_LSC_REGISTER_GRGAIN_V_10: begin
                    rdata <=int_lsc_register_GrGain_V_10;
                end
                ADDR_LSC_REGISTER_GRGAIN_V_11: begin
                    rdata <=int_lsc_register_GrGain_V_11;
                end
                ADDR_LSC_REGISTER_GRGAIN_V_12: begin
                    rdata <=int_lsc_register_GrGain_V_12;
                end
                ADDR_LSC_REGISTER_GRGAIN_V_13: begin
                    rdata <=int_lsc_register_GrGain_V_13;
                end
                ADDR_LSC_REGISTER_GRGAIN_V_14: begin
                    rdata <=int_lsc_register_GrGain_V_14;
                end
                ADDR_LSC_REGISTER_GRGAIN_V_15: begin
                    rdata <=int_lsc_register_GrGain_V_15;
                end
                ADDR_LSC_REGISTER_GRGAIN_V_16: begin
                    rdata <=int_lsc_register_GrGain_V_16;
                end
                ADDR_LSC_REGISTER_GRGAIN_V_17: begin
                    rdata <=int_lsc_register_GrGain_V_17;
                end
                ADDR_LSC_REGISTER_GRGAIN_V_18: begin
                    rdata <=int_lsc_register_GrGain_V_18;
                end
                ADDR_LSC_REGISTER_GRGAIN_V_19: begin
                    rdata <=int_lsc_register_GrGain_V_19;
                end
                ADDR_LSC_REGISTER_GRGAIN_V_20: begin
                    rdata <=int_lsc_register_GrGain_V_20;
                end
                ADDR_LSC_REGISTER_GRGAIN_V_21: begin
                    rdata <=int_lsc_register_GrGain_V_21;
                end
                ADDR_LSC_REGISTER_GRGAIN_V_22: begin
                    rdata <=int_lsc_register_GrGain_V_22;
                end
                ADDR_LSC_REGISTER_GRGAIN_V_23: begin
                    rdata <=int_lsc_register_GrGain_V_23;
                end
                ADDR_LSC_REGISTER_GRGAIN_V_24: begin
                    rdata <=int_lsc_register_GrGain_V_24;
                end
                ADDR_LSC_REGISTER_GRGAIN_V_25: begin
                    rdata <=int_lsc_register_GrGain_V_25;
                end
                ADDR_LSC_REGISTER_GRGAIN_V_26: begin
                    rdata <=int_lsc_register_GrGain_V_26;
                end
                ADDR_LSC_REGISTER_GRGAIN_V_27: begin
                    rdata <=int_lsc_register_GrGain_V_27;
                end
                ADDR_LSC_REGISTER_GRGAIN_V_28: begin
                    rdata <=int_lsc_register_GrGain_V_28;
                end
                ADDR_LSC_REGISTER_GRGAIN_V_29: begin
                    rdata <=int_lsc_register_GrGain_V_29;
                end
                ADDR_LSC_REGISTER_GRGAIN_V_30: begin
                    rdata <=int_lsc_register_GrGain_V_30;
                end
                ADDR_LSC_REGISTER_GRGAIN_V_31: begin
                    rdata <=int_lsc_register_GrGain_V_31;
                end
                ADDR_LSC_REGISTER_GRGAIN_V_32: begin
                    rdata <=int_lsc_register_GrGain_V_32;
                end
                ADDR_LSC_REGISTER_GRGAIN_V_33: begin
                    rdata <=int_lsc_register_GrGain_V_33;
                end
                ADDR_LSC_REGISTER_GRGAIN_V_34: begin
                    rdata <=int_lsc_register_GrGain_V_34;
                end
                ADDR_LSC_REGISTER_GRGAIN_V_35: begin
                    rdata <=int_lsc_register_GrGain_V_35;
                end
                ADDR_LSC_REGISTER_GRGAIN_V_36: begin
                    rdata <=int_lsc_register_GrGain_V_36;
                end
                ADDR_LSC_REGISTER_GRGAIN_V_37: begin
                    rdata <=int_lsc_register_GrGain_V_37;
                end
                ADDR_LSC_REGISTER_GRGAIN_V_38: begin
                    rdata <=int_lsc_register_GrGain_V_38;
                end
                ADDR_LSC_REGISTER_GRGAIN_V_39: begin
                    rdata <=int_lsc_register_GrGain_V_39;
                end
                ADDR_LSC_REGISTER_GRGAIN_V_40: begin
                    rdata <=int_lsc_register_GrGain_V_40;
                end
                ADDR_LSC_REGISTER_GRGAIN_V_41: begin
                    rdata <=int_lsc_register_GrGain_V_41;
                end
                ADDR_LSC_REGISTER_GRGAIN_V_42: begin
                    rdata <=int_lsc_register_GrGain_V_42;
                end
                ADDR_LSC_REGISTER_GRGAIN_V_43: begin
                    rdata <=int_lsc_register_GrGain_V_43;
                end
                ADDR_LSC_REGISTER_GRGAIN_V_44: begin
                    rdata <=int_lsc_register_GrGain_V_44;
                end
                ADDR_LSC_REGISTER_GRGAIN_V_45: begin
                    rdata <=int_lsc_register_GrGain_V_45;
                end
                ADDR_LSC_REGISTER_GRGAIN_V_46: begin
                    rdata <=int_lsc_register_GrGain_V_46;
                end
                ADDR_LSC_REGISTER_GRGAIN_V_47: begin
                    rdata <=int_lsc_register_GrGain_V_47;
                end
                ADDR_LSC_REGISTER_GRGAIN_V_48: begin
                    rdata <=int_lsc_register_GrGain_V_48;
                end
                ADDR_LSC_REGISTER_GRGAIN_V_49: begin
                    rdata <=int_lsc_register_GrGain_V_49;
                end
                ADDR_LSC_REGISTER_GRGAIN_V_50: begin
                    rdata <=int_lsc_register_GrGain_V_50;
                end
                ADDR_LSC_REGISTER_GRGAIN_V_51: begin
                    rdata <=int_lsc_register_GrGain_V_51;
                end
                ADDR_LSC_REGISTER_GRGAIN_V_52: begin
                    rdata <=int_lsc_register_GrGain_V_52;
                end
                ADDR_LSC_REGISTER_GRGAIN_V_53: begin
                    rdata <=int_lsc_register_GrGain_V_53;
                end
                ADDR_LSC_REGISTER_GRGAIN_V_54: begin
                    rdata <=int_lsc_register_GrGain_V_54;
                end
                ADDR_LSC_REGISTER_GRGAIN_V_55: begin
                    rdata <=int_lsc_register_GrGain_V_55;
                end
                ADDR_LSC_REGISTER_GRGAIN_V_56: begin
                    rdata <=int_lsc_register_GrGain_V_56;
                end
                ADDR_LSC_REGISTER_GRGAIN_V_57: begin
                    rdata <=int_lsc_register_GrGain_V_57;
                end
                ADDR_LSC_REGISTER_GRGAIN_V_58: begin
                    rdata <=int_lsc_register_GrGain_V_58;
                end
                ADDR_LSC_REGISTER_GRGAIN_V_59: begin
                    rdata <=int_lsc_register_GrGain_V_59;
                end
                ADDR_LSC_REGISTER_GRGAIN_V_60: begin
                    rdata <=int_lsc_register_GrGain_V_60;
                end
                ADDR_LSC_REGISTER_GRGAIN_V_61: begin
                    rdata <=int_lsc_register_GrGain_V_61;
                end
                ADDR_LSC_REGISTER_GRGAIN_V_62: begin
                    rdata <=int_lsc_register_GrGain_V_62;
                end
                ADDR_LSC_REGISTER_GRGAIN_V_63: begin
                    rdata <=int_lsc_register_GrGain_V_63;
                end
                ADDR_LSC_REGISTER_GRGAIN_V_64: begin
                    rdata <=int_lsc_register_GrGain_V_64;
                end
                ADDR_LSC_REGISTER_GRGAIN_V_65: begin
                    rdata <=int_lsc_register_GrGain_V_65;
                end
                ADDR_LSC_REGISTER_GRGAIN_V_66: begin
                    rdata <=int_lsc_register_GrGain_V_66;
                end
                ADDR_LSC_REGISTER_GRGAIN_V_67: begin
                    rdata <=int_lsc_register_GrGain_V_67;
                end
                ADDR_LSC_REGISTER_GRGAIN_V_68: begin
                    rdata <=int_lsc_register_GrGain_V_68;
                end
                ADDR_LSC_REGISTER_GRGAIN_V_69: begin
                    rdata <=int_lsc_register_GrGain_V_69;
                end
                ADDR_LSC_REGISTER_GRGAIN_V_70: begin
                    rdata <=int_lsc_register_GrGain_V_70;
                end
                ADDR_LSC_REGISTER_GRGAIN_V_71: begin
                    rdata <=int_lsc_register_GrGain_V_71;
                end
                ADDR_LSC_REGISTER_GRGAIN_V_72: begin
                    rdata <=int_lsc_register_GrGain_V_72;
                end
                ADDR_LSC_REGISTER_GRGAIN_V_73: begin
                    rdata <=int_lsc_register_GrGain_V_73;
                end
                ADDR_LSC_REGISTER_GRGAIN_V_74: begin
                    rdata <=int_lsc_register_GrGain_V_74;
                end
                ADDR_LSC_REGISTER_GRGAIN_V_75: begin
                    rdata <=int_lsc_register_GrGain_V_75;
                end
                ADDR_LSC_REGISTER_GRGAIN_V_76: begin
                    rdata <=int_lsc_register_GrGain_V_76;
                end
                ADDR_LSC_REGISTER_GRGAIN_V_77: begin
                    rdata <=int_lsc_register_GrGain_V_77;
                end
                ADDR_LSC_REGISTER_GRGAIN_V_78: begin
                    rdata <=int_lsc_register_GrGain_V_78;
                end
                ADDR_LSC_REGISTER_GRGAIN_V_79: begin
                    rdata <=int_lsc_register_GrGain_V_79;
                end
                ADDR_LSC_REGISTER_GRGAIN_V_80: begin
                    rdata <=int_lsc_register_GrGain_V_80;
                end
                ADDR_LSC_REGISTER_GRGAIN_V_81: begin
                    rdata <=int_lsc_register_GrGain_V_81;
                end
                ADDR_LSC_REGISTER_GRGAIN_V_82: begin
                    rdata <=int_lsc_register_GrGain_V_82;
                end
                ADDR_LSC_REGISTER_GRGAIN_V_83: begin
                    rdata <=int_lsc_register_GrGain_V_83;
                end
                ADDR_LSC_REGISTER_GRGAIN_V_84: begin
                    rdata <=int_lsc_register_GrGain_V_84;
                end
                ADDR_LSC_REGISTER_GRGAIN_V_85: begin
                    rdata <=int_lsc_register_GrGain_V_85;
                end
                ADDR_LSC_REGISTER_GRGAIN_V_86: begin
                    rdata <=int_lsc_register_GrGain_V_86;
                end
                ADDR_LSC_REGISTER_GRGAIN_V_87: begin
                    rdata <=int_lsc_register_GrGain_V_87;
                end
                ADDR_LSC_REGISTER_GRGAIN_V_88: begin
                    rdata <=int_lsc_register_GrGain_V_88;
                end
                ADDR_LSC_REGISTER_GRGAIN_V_89: begin
                    rdata <=int_lsc_register_GrGain_V_89;
                end
                ADDR_LSC_REGISTER_GRGAIN_V_90: begin
                    rdata <=int_lsc_register_GrGain_V_90;
                end
                ADDR_LSC_REGISTER_GRGAIN_V_91: begin
                    rdata <=int_lsc_register_GrGain_V_91;
                end
                ADDR_LSC_REGISTER_GRGAIN_V_92: begin
                    rdata <=int_lsc_register_GrGain_V_92;
                end
                ADDR_LSC_REGISTER_GRGAIN_V_93: begin
                    rdata <=int_lsc_register_GrGain_V_93;
                end
                ADDR_LSC_REGISTER_GRGAIN_V_94: begin
                    rdata <=int_lsc_register_GrGain_V_94;
                end
                ADDR_LSC_REGISTER_GRGAIN_V_95: begin
                    rdata <=int_lsc_register_GrGain_V_95;
                end
                ADDR_LSC_REGISTER_GRGAIN_V_96: begin
                    rdata <=int_lsc_register_GrGain_V_96;
                end
                ADDR_LSC_REGISTER_GRGAIN_V_97: begin
                    rdata <=int_lsc_register_GrGain_V_97;
                end
                ADDR_LSC_REGISTER_GRGAIN_V_98: begin
                    rdata <=int_lsc_register_GrGain_V_98;
                end
                ADDR_LSC_REGISTER_GRGAIN_V_99: begin
                    rdata <=int_lsc_register_GrGain_V_99;
                end
                ADDR_LSC_REGISTER_GRGAIN_V_100: begin
                    rdata <=int_lsc_register_GrGain_V_100;
                end
                ADDR_LSC_REGISTER_GRGAIN_V_101: begin
                    rdata <=int_lsc_register_GrGain_V_101;
                end
                ADDR_LSC_REGISTER_GRGAIN_V_102: begin
                    rdata <=int_lsc_register_GrGain_V_102;
                end
                ADDR_LSC_REGISTER_GRGAIN_V_103: begin
                    rdata <=int_lsc_register_GrGain_V_103;
                end
                ADDR_LSC_REGISTER_GRGAIN_V_104: begin
                    rdata <=int_lsc_register_GrGain_V_104;
                end
                ADDR_LSC_REGISTER_GRGAIN_V_105: begin
                    rdata <=int_lsc_register_GrGain_V_105;
                end
                ADDR_LSC_REGISTER_GRGAIN_V_106: begin
                    rdata <=int_lsc_register_GrGain_V_106;
                end
                ADDR_LSC_REGISTER_GRGAIN_V_107: begin
                    rdata <=int_lsc_register_GrGain_V_107;
                end
                ADDR_LSC_REGISTER_GRGAIN_V_108: begin
                    rdata <=int_lsc_register_GrGain_V_108;
                end
                ADDR_LSC_REGISTER_GRGAIN_V_109: begin
                    rdata <=int_lsc_register_GrGain_V_109;
                end
                ADDR_LSC_REGISTER_GRGAIN_V_110: begin
                    rdata <=int_lsc_register_GrGain_V_110;
                end
                ADDR_LSC_REGISTER_GRGAIN_V_111: begin
                    rdata <=int_lsc_register_GrGain_V_111;
                end
                ADDR_LSC_REGISTER_GRGAIN_V_112: begin
                    rdata <=int_lsc_register_GrGain_V_112;
                end
                ADDR_LSC_REGISTER_GRGAIN_V_113: begin
                    rdata <=int_lsc_register_GrGain_V_113;
                end
                ADDR_LSC_REGISTER_GRGAIN_V_114: begin
                    rdata <=int_lsc_register_GrGain_V_114;
                end
                ADDR_LSC_REGISTER_GRGAIN_V_115: begin
                    rdata <=int_lsc_register_GrGain_V_115;
                end
                ADDR_LSC_REGISTER_GRGAIN_V_116: begin
                    rdata <=int_lsc_register_GrGain_V_116;
                end
                ADDR_LSC_REGISTER_GRGAIN_V_117: begin
                    rdata <=int_lsc_register_GrGain_V_117;
                end
                ADDR_LSC_REGISTER_GRGAIN_V_118: begin
                    rdata <=int_lsc_register_GrGain_V_118;
                end
                ADDR_LSC_REGISTER_GRGAIN_V_119: begin
                    rdata <=int_lsc_register_GrGain_V_119;
                end
                ADDR_LSC_REGISTER_GRGAIN_V_120: begin
                    rdata <=int_lsc_register_GrGain_V_120;
                end
                ADDR_LSC_REGISTER_GRGAIN_V_121: begin
                    rdata <=int_lsc_register_GrGain_V_121;
                end
                ADDR_LSC_REGISTER_GRGAIN_V_122: begin
                    rdata <=int_lsc_register_GrGain_V_122;
                end
                ADDR_LSC_REGISTER_GRGAIN_V_123: begin
                    rdata <=int_lsc_register_GrGain_V_123;
                end
                ADDR_LSC_REGISTER_GRGAIN_V_124: begin
                    rdata <=int_lsc_register_GrGain_V_124;
                end
                ADDR_LSC_REGISTER_GRGAIN_V_125: begin
                    rdata <=int_lsc_register_GrGain_V_125;
                end
                ADDR_LSC_REGISTER_GRGAIN_V_126: begin
                    rdata <=int_lsc_register_GrGain_V_126;
                end
                ADDR_LSC_REGISTER_GRGAIN_V_127: begin
                    rdata <=int_lsc_register_GrGain_V_127;
                end
                ADDR_LSC_REGISTER_GRGAIN_V_128: begin
                    rdata <=int_lsc_register_GrGain_V_128;
                end
                ADDR_LSC_REGISTER_GRGAIN_V_129: begin
                    rdata <=int_lsc_register_GrGain_V_129;
                end
                ADDR_LSC_REGISTER_GRGAIN_V_130: begin
                    rdata <=int_lsc_register_GrGain_V_130;
                end
                ADDR_LSC_REGISTER_GRGAIN_V_131: begin
                    rdata <=int_lsc_register_GrGain_V_131;
                end
                ADDR_LSC_REGISTER_GRGAIN_V_132: begin
                    rdata <=int_lsc_register_GrGain_V_132;
                end
                ADDR_LSC_REGISTER_GRGAIN_V_133: begin
                    rdata <=int_lsc_register_GrGain_V_133;
                end
                ADDR_LSC_REGISTER_GRGAIN_V_134: begin
                    rdata <=int_lsc_register_GrGain_V_134;
                end
                ADDR_LSC_REGISTER_GRGAIN_V_135: begin
                    rdata <=int_lsc_register_GrGain_V_135;
                end
                ADDR_LSC_REGISTER_GRGAIN_V_136: begin
                    rdata <=int_lsc_register_GrGain_V_136;
                end
                ADDR_LSC_REGISTER_GRGAIN_V_137: begin
                    rdata <=int_lsc_register_GrGain_V_137;
                end
                ADDR_LSC_REGISTER_GRGAIN_V_138: begin
                    rdata <=int_lsc_register_GrGain_V_138;
                end
                ADDR_LSC_REGISTER_GRGAIN_V_139: begin
                    rdata <=int_lsc_register_GrGain_V_139;
                end
                ADDR_LSC_REGISTER_GRGAIN_V_140: begin
                    rdata <=int_lsc_register_GrGain_V_140;
                end
                ADDR_LSC_REGISTER_GRGAIN_V_141: begin
                    rdata <=int_lsc_register_GrGain_V_141;
                end
                ADDR_LSC_REGISTER_GRGAIN_V_142: begin
                    rdata <=int_lsc_register_GrGain_V_142;
                end
                ADDR_LSC_REGISTER_GRGAIN_V_143: begin
                    rdata <=int_lsc_register_GrGain_V_143;
                end
                ADDR_LSC_REGISTER_GRGAIN_V_144: begin
                    rdata <=int_lsc_register_GrGain_V_144;
                end
                ADDR_LSC_REGISTER_GRGAIN_V_145: begin
                    rdata <=int_lsc_register_GrGain_V_145;
                end
                ADDR_LSC_REGISTER_GRGAIN_V_146: begin
                    rdata <=int_lsc_register_GrGain_V_146;
                end
                ADDR_LSC_REGISTER_GRGAIN_V_147: begin
                    rdata <=int_lsc_register_GrGain_V_147;
                end
                ADDR_LSC_REGISTER_GRGAIN_V_148: begin
                    rdata <=int_lsc_register_GrGain_V_148;
                end
                ADDR_LSC_REGISTER_GRGAIN_V_149: begin
                    rdata <=int_lsc_register_GrGain_V_149;
                end
                ADDR_LSC_REGISTER_GRGAIN_V_150: begin
                    rdata <=int_lsc_register_GrGain_V_150;
                end
                ADDR_LSC_REGISTER_GRGAIN_V_151: begin
                    rdata <=int_lsc_register_GrGain_V_151;
                end
                ADDR_LSC_REGISTER_GRGAIN_V_152: begin
                    rdata <=int_lsc_register_GrGain_V_152;
                end
                ADDR_LSC_REGISTER_GRGAIN_V_153: begin
                    rdata <=int_lsc_register_GrGain_V_153;
                end
                ADDR_LSC_REGISTER_GRGAIN_V_154: begin
                    rdata <=int_lsc_register_GrGain_V_154;
                end
                ADDR_LSC_REGISTER_GRGAIN_V_155: begin
                    rdata <=int_lsc_register_GrGain_V_155;
                end
                ADDR_LSC_REGISTER_GRGAIN_V_156: begin
                    rdata <=int_lsc_register_GrGain_V_156;
                end
                ADDR_LSC_REGISTER_GRGAIN_V_157: begin
                    rdata <=int_lsc_register_GrGain_V_157;
                end
                ADDR_LSC_REGISTER_GRGAIN_V_158: begin
                    rdata <=int_lsc_register_GrGain_V_158;
                end
                ADDR_LSC_REGISTER_GRGAIN_V_159: begin
                    rdata <=int_lsc_register_GrGain_V_159;
                end
                ADDR_LSC_REGISTER_GRGAIN_V_160: begin
                    rdata <=int_lsc_register_GrGain_V_160;
                end
                ADDR_LSC_REGISTER_GRGAIN_V_161: begin
                    rdata <=int_lsc_register_GrGain_V_161;
                end
                ADDR_LSC_REGISTER_GRGAIN_V_162: begin
                    rdata <=int_lsc_register_GrGain_V_162;
                end
                ADDR_LSC_REGISTER_GRGAIN_V_163: begin
                    rdata <=int_lsc_register_GrGain_V_163;
                end
                ADDR_LSC_REGISTER_GRGAIN_V_164: begin
                    rdata <=int_lsc_register_GrGain_V_164;
                end
                ADDR_LSC_REGISTER_GRGAIN_V_165: begin
                    rdata <=int_lsc_register_GrGain_V_165;
                end
                ADDR_LSC_REGISTER_GRGAIN_V_166: begin
                    rdata <=int_lsc_register_GrGain_V_166;
                end
                ADDR_LSC_REGISTER_GRGAIN_V_167: begin
                    rdata <=int_lsc_register_GrGain_V_167;
                end
                ADDR_LSC_REGISTER_GRGAIN_V_168: begin
                    rdata <=int_lsc_register_GrGain_V_168;
                end
                ADDR_LSC_REGISTER_GRGAIN_V_169: begin
                    rdata <=int_lsc_register_GrGain_V_169;
                end
                ADDR_LSC_REGISTER_GRGAIN_V_170: begin
                    rdata <=int_lsc_register_GrGain_V_170;
                end
                ADDR_LSC_REGISTER_GRGAIN_V_171: begin
                    rdata <=int_lsc_register_GrGain_V_171;
                end
                ADDR_LSC_REGISTER_GRGAIN_V_172: begin
                    rdata <=int_lsc_register_GrGain_V_172;
                end
                ADDR_LSC_REGISTER_GRGAIN_V_173: begin
                    rdata <=int_lsc_register_GrGain_V_173;
                end
                ADDR_LSC_REGISTER_GRGAIN_V_174: begin
                    rdata <=int_lsc_register_GrGain_V_174;
                end
                ADDR_LSC_REGISTER_GRGAIN_V_175: begin
                    rdata <=int_lsc_register_GrGain_V_175;
                end
                ADDR_LSC_REGISTER_GRGAIN_V_176: begin
                    rdata <=int_lsc_register_GrGain_V_176;
                end
                ADDR_LSC_REGISTER_GRGAIN_V_177: begin
                    rdata <=int_lsc_register_GrGain_V_177;
                end
                ADDR_LSC_REGISTER_GRGAIN_V_178: begin
                    rdata <=int_lsc_register_GrGain_V_178;
                end
                ADDR_LSC_REGISTER_GRGAIN_V_179: begin
                    rdata <=int_lsc_register_GrGain_V_179;
                end
                ADDR_LSC_REGISTER_GRGAIN_V_180: begin
                    rdata <=int_lsc_register_GrGain_V_180;
                end
                ADDR_LSC_REGISTER_GRGAIN_V_181: begin
                    rdata <=int_lsc_register_GrGain_V_181;
                end
                ADDR_LSC_REGISTER_GRGAIN_V_182: begin
                    rdata <=int_lsc_register_GrGain_V_182;
                end
                ADDR_LSC_REGISTER_GRGAIN_V_183: begin
                    rdata <=int_lsc_register_GrGain_V_183;
                end
                ADDR_LSC_REGISTER_GRGAIN_V_184: begin
                    rdata <=int_lsc_register_GrGain_V_184;
                end
                ADDR_LSC_REGISTER_GRGAIN_V_185: begin
                    rdata <=int_lsc_register_GrGain_V_185;
                end
                ADDR_LSC_REGISTER_GRGAIN_V_186: begin
                    rdata <=int_lsc_register_GrGain_V_186;
                end
                ADDR_LSC_REGISTER_GRGAIN_V_187: begin
                    rdata <=int_lsc_register_GrGain_V_187;
                end
                ADDR_LSC_REGISTER_GRGAIN_V_188: begin
                    rdata <=int_lsc_register_GrGain_V_188;
                end
                ADDR_LSC_REGISTER_GRGAIN_V_189: begin
                    rdata <=int_lsc_register_GrGain_V_189;
                end
                ADDR_LSC_REGISTER_GRGAIN_V_190: begin
                    rdata <=int_lsc_register_GrGain_V_190;
                end
                ADDR_LSC_REGISTER_GRGAIN_V_191: begin
                    rdata <=int_lsc_register_GrGain_V_191;
                end
                ADDR_LSC_REGISTER_GRGAIN_V_192: begin
                    rdata <=int_lsc_register_GrGain_V_192;
                end
                ADDR_LSC_REGISTER_GRGAIN_V_193: begin
                    rdata <=int_lsc_register_GrGain_V_193;
                end
                ADDR_LSC_REGISTER_GRGAIN_V_194: begin
                    rdata <=int_lsc_register_GrGain_V_194;
                end
                ADDR_LSC_REGISTER_GRGAIN_V_195: begin
                    rdata <=int_lsc_register_GrGain_V_195;
                end
                ADDR_LSC_REGISTER_GRGAIN_V_196: begin
                    rdata <=int_lsc_register_GrGain_V_196;
                end
                ADDR_LSC_REGISTER_GRGAIN_V_197: begin
                    rdata <=int_lsc_register_GrGain_V_197;
                end
                ADDR_LSC_REGISTER_GRGAIN_V_198: begin
                    rdata <=int_lsc_register_GrGain_V_198;
                end
                ADDR_LSC_REGISTER_GRGAIN_V_199: begin
                    rdata <=int_lsc_register_GrGain_V_199;
                end
                ADDR_LSC_REGISTER_GRGAIN_V_200: begin
                    rdata <=int_lsc_register_GrGain_V_200;
                end
                ADDR_LSC_REGISTER_GRGAIN_V_201: begin
                    rdata <=int_lsc_register_GrGain_V_201;
                end
                ADDR_LSC_REGISTER_GRGAIN_V_202: begin
                    rdata <=int_lsc_register_GrGain_V_202;
                end
                ADDR_LSC_REGISTER_GRGAIN_V_203: begin
                    rdata <=int_lsc_register_GrGain_V_203;
                end
                ADDR_LSC_REGISTER_GRGAIN_V_204: begin
                    rdata <=int_lsc_register_GrGain_V_204;
                end
                ADDR_LSC_REGISTER_GRGAIN_V_205: begin
                    rdata <=int_lsc_register_GrGain_V_205;
                end
                ADDR_LSC_REGISTER_GRGAIN_V_206: begin
                    rdata <=int_lsc_register_GrGain_V_206;
                end
                ADDR_LSC_REGISTER_GRGAIN_V_207: begin
                    rdata <=int_lsc_register_GrGain_V_207;
                end
                ADDR_LSC_REGISTER_GRGAIN_V_208: begin
                    rdata <=int_lsc_register_GrGain_V_208;
                end
                ADDR_LSC_REGISTER_GRGAIN_V_209: begin
                    rdata <=int_lsc_register_GrGain_V_209;
                end
                ADDR_LSC_REGISTER_GRGAIN_V_210: begin
                    rdata <=int_lsc_register_GrGain_V_210;
                end
                ADDR_LSC_REGISTER_GRGAIN_V_211: begin
                    rdata <=int_lsc_register_GrGain_V_211;
                end
                ADDR_LSC_REGISTER_GRGAIN_V_212: begin
                    rdata <=int_lsc_register_GrGain_V_212;
                end
                ADDR_LSC_REGISTER_GRGAIN_V_213: begin
                    rdata <=int_lsc_register_GrGain_V_213;
                end
                ADDR_LSC_REGISTER_GRGAIN_V_214: begin
                    rdata <=int_lsc_register_GrGain_V_214;
                end
                ADDR_LSC_REGISTER_GRGAIN_V_215: begin
                    rdata <=int_lsc_register_GrGain_V_215;
                end
                ADDR_LSC_REGISTER_GRGAIN_V_216: begin
                    rdata <=int_lsc_register_GrGain_V_216;
                end
                ADDR_LSC_REGISTER_GRGAIN_V_217: begin
                    rdata <=int_lsc_register_GrGain_V_217;
                end
                ADDR_LSC_REGISTER_GRGAIN_V_218: begin
                    rdata <=int_lsc_register_GrGain_V_218;
                end
                ADDR_LSC_REGISTER_GRGAIN_V_219: begin
                    rdata <=int_lsc_register_GrGain_V_219;
                end
                ADDR_LSC_REGISTER_GRGAIN_V_220: begin
                    rdata <=int_lsc_register_GrGain_V_220;
                end
                ADDR_LSC_REGISTER_GBGAIN_V_0: begin
                    rdata <=int_lsc_register_GbGain_V_0;
                end
                ADDR_LSC_REGISTER_GBGAIN_V_1: begin
                    rdata <=int_lsc_register_GbGain_V_1;
                end
                ADDR_LSC_REGISTER_GBGAIN_V_2: begin
                    rdata <=int_lsc_register_GbGain_V_2;
                end
                ADDR_LSC_REGISTER_GBGAIN_V_3: begin
                    rdata <=int_lsc_register_GbGain_V_3;
                end
                ADDR_LSC_REGISTER_GBGAIN_V_4: begin
                    rdata <=int_lsc_register_GbGain_V_4;
                end
                ADDR_LSC_REGISTER_GBGAIN_V_5: begin
                    rdata <=int_lsc_register_GbGain_V_5;
                end
                ADDR_LSC_REGISTER_GBGAIN_V_6: begin
                    rdata <=int_lsc_register_GbGain_V_6;
                end
                ADDR_LSC_REGISTER_GBGAIN_V_7: begin
                    rdata <=int_lsc_register_GbGain_V_7;
                end
                ADDR_LSC_REGISTER_GBGAIN_V_8: begin
                    rdata <=int_lsc_register_GbGain_V_8;
                end
                ADDR_LSC_REGISTER_GBGAIN_V_9: begin
                    rdata <=int_lsc_register_GbGain_V_9;
                end
                ADDR_LSC_REGISTER_GBGAIN_V_10: begin
                    rdata <=int_lsc_register_GbGain_V_10;
                end
                ADDR_LSC_REGISTER_GBGAIN_V_11: begin
                    rdata <=int_lsc_register_GbGain_V_11;
                end
                ADDR_LSC_REGISTER_GBGAIN_V_12: begin
                    rdata <=int_lsc_register_GbGain_V_12;
                end
                ADDR_LSC_REGISTER_GBGAIN_V_13: begin
                    rdata <=int_lsc_register_GbGain_V_13;
                end
                ADDR_LSC_REGISTER_GBGAIN_V_14: begin
                    rdata <=int_lsc_register_GbGain_V_14;
                end
                ADDR_LSC_REGISTER_GBGAIN_V_15: begin
                    rdata <=int_lsc_register_GbGain_V_15;
                end
                ADDR_LSC_REGISTER_GBGAIN_V_16: begin
                    rdata <=int_lsc_register_GbGain_V_16;
                end
                ADDR_LSC_REGISTER_GBGAIN_V_17: begin
                    rdata <=int_lsc_register_GbGain_V_17;
                end
                ADDR_LSC_REGISTER_GBGAIN_V_18: begin
                    rdata <=int_lsc_register_GbGain_V_18;
                end
                ADDR_LSC_REGISTER_GBGAIN_V_19: begin
                    rdata <=int_lsc_register_GbGain_V_19;
                end
                ADDR_LSC_REGISTER_GBGAIN_V_20: begin
                    rdata <=int_lsc_register_GbGain_V_20;
                end
                ADDR_LSC_REGISTER_GBGAIN_V_21: begin
                    rdata <=int_lsc_register_GbGain_V_21;
                end
                ADDR_LSC_REGISTER_GBGAIN_V_22: begin
                    rdata <=int_lsc_register_GbGain_V_22;
                end
                ADDR_LSC_REGISTER_GBGAIN_V_23: begin
                    rdata <=int_lsc_register_GbGain_V_23;
                end
                ADDR_LSC_REGISTER_GBGAIN_V_24: begin
                    rdata <=int_lsc_register_GbGain_V_24;
                end
                ADDR_LSC_REGISTER_GBGAIN_V_25: begin
                    rdata <=int_lsc_register_GbGain_V_25;
                end
                ADDR_LSC_REGISTER_GBGAIN_V_26: begin
                    rdata <=int_lsc_register_GbGain_V_26;
                end
                ADDR_LSC_REGISTER_GBGAIN_V_27: begin
                    rdata <=int_lsc_register_GbGain_V_27;
                end
                ADDR_LSC_REGISTER_GBGAIN_V_28: begin
                    rdata <=int_lsc_register_GbGain_V_28;
                end
                ADDR_LSC_REGISTER_GBGAIN_V_29: begin
                    rdata <=int_lsc_register_GbGain_V_29;
                end
                ADDR_LSC_REGISTER_GBGAIN_V_30: begin
                    rdata <=int_lsc_register_GbGain_V_30;
                end
                ADDR_LSC_REGISTER_GBGAIN_V_31: begin
                    rdata <=int_lsc_register_GbGain_V_31;
                end
                ADDR_LSC_REGISTER_GBGAIN_V_32: begin
                    rdata <=int_lsc_register_GbGain_V_32;
                end
                ADDR_LSC_REGISTER_GBGAIN_V_33: begin
                    rdata <=int_lsc_register_GbGain_V_33;
                end
                ADDR_LSC_REGISTER_GBGAIN_V_34: begin
                    rdata <=int_lsc_register_GbGain_V_34;
                end
                ADDR_LSC_REGISTER_GBGAIN_V_35: begin
                    rdata <=int_lsc_register_GbGain_V_35;
                end
                ADDR_LSC_REGISTER_GBGAIN_V_36: begin
                    rdata <=int_lsc_register_GbGain_V_36;
                end
                ADDR_LSC_REGISTER_GBGAIN_V_37: begin
                    rdata <=int_lsc_register_GbGain_V_37;
                end
                ADDR_LSC_REGISTER_GBGAIN_V_38: begin
                    rdata <=int_lsc_register_GbGain_V_38;
                end
                ADDR_LSC_REGISTER_GBGAIN_V_39: begin
                    rdata <=int_lsc_register_GbGain_V_39;
                end
                ADDR_LSC_REGISTER_GBGAIN_V_40: begin
                    rdata <=int_lsc_register_GbGain_V_40;
                end
                ADDR_LSC_REGISTER_GBGAIN_V_41: begin
                    rdata <=int_lsc_register_GbGain_V_41;
                end
                ADDR_LSC_REGISTER_GBGAIN_V_42: begin
                    rdata <=int_lsc_register_GbGain_V_42;
                end
                ADDR_LSC_REGISTER_GBGAIN_V_43: begin
                    rdata <=int_lsc_register_GbGain_V_43;
                end
                ADDR_LSC_REGISTER_GBGAIN_V_44: begin
                    rdata <=int_lsc_register_GbGain_V_44;
                end
                ADDR_LSC_REGISTER_GBGAIN_V_45: begin
                    rdata <=int_lsc_register_GbGain_V_45;
                end
                ADDR_LSC_REGISTER_GBGAIN_V_46: begin
                    rdata <=int_lsc_register_GbGain_V_46;
                end
                ADDR_LSC_REGISTER_GBGAIN_V_47: begin
                    rdata <=int_lsc_register_GbGain_V_47;
                end
                ADDR_LSC_REGISTER_GBGAIN_V_48: begin
                    rdata <=int_lsc_register_GbGain_V_48;
                end
                ADDR_LSC_REGISTER_GBGAIN_V_49: begin
                    rdata <=int_lsc_register_GbGain_V_49;
                end
                ADDR_LSC_REGISTER_GBGAIN_V_50: begin
                    rdata <=int_lsc_register_GbGain_V_50;
                end
                ADDR_LSC_REGISTER_GBGAIN_V_51: begin
                    rdata <=int_lsc_register_GbGain_V_51;
                end
                ADDR_LSC_REGISTER_GBGAIN_V_52: begin
                    rdata <=int_lsc_register_GbGain_V_52;
                end
                ADDR_LSC_REGISTER_GBGAIN_V_53: begin
                    rdata <=int_lsc_register_GbGain_V_53;
                end
                ADDR_LSC_REGISTER_GBGAIN_V_54: begin
                    rdata <=int_lsc_register_GbGain_V_54;
                end
                ADDR_LSC_REGISTER_GBGAIN_V_55: begin
                    rdata <=int_lsc_register_GbGain_V_55;
                end
                ADDR_LSC_REGISTER_GBGAIN_V_56: begin
                    rdata <=int_lsc_register_GbGain_V_56;
                end
                ADDR_LSC_REGISTER_GBGAIN_V_57: begin
                    rdata <=int_lsc_register_GbGain_V_57;
                end
                ADDR_LSC_REGISTER_GBGAIN_V_58: begin
                    rdata <=int_lsc_register_GbGain_V_58;
                end
                ADDR_LSC_REGISTER_GBGAIN_V_59: begin
                    rdata <=int_lsc_register_GbGain_V_59;
                end
                ADDR_LSC_REGISTER_GBGAIN_V_60: begin
                    rdata <=int_lsc_register_GbGain_V_60;
                end
                ADDR_LSC_REGISTER_GBGAIN_V_61: begin
                    rdata <=int_lsc_register_GbGain_V_61;
                end
                ADDR_LSC_REGISTER_GBGAIN_V_62: begin
                    rdata <=int_lsc_register_GbGain_V_62;
                end
                ADDR_LSC_REGISTER_GBGAIN_V_63: begin
                    rdata <=int_lsc_register_GbGain_V_63;
                end
                ADDR_LSC_REGISTER_GBGAIN_V_64: begin
                    rdata <=int_lsc_register_GbGain_V_64;
                end
                ADDR_LSC_REGISTER_GBGAIN_V_65: begin
                    rdata <=int_lsc_register_GbGain_V_65;
                end
                ADDR_LSC_REGISTER_GBGAIN_V_66: begin
                    rdata <=int_lsc_register_GbGain_V_66;
                end
                ADDR_LSC_REGISTER_GBGAIN_V_67: begin
                    rdata <=int_lsc_register_GbGain_V_67;
                end
                ADDR_LSC_REGISTER_GBGAIN_V_68: begin
                    rdata <=int_lsc_register_GbGain_V_68;
                end
                ADDR_LSC_REGISTER_GBGAIN_V_69: begin
                    rdata <=int_lsc_register_GbGain_V_69;
                end
                ADDR_LSC_REGISTER_GBGAIN_V_70: begin
                    rdata <=int_lsc_register_GbGain_V_70;
                end
                ADDR_LSC_REGISTER_GBGAIN_V_71: begin
                    rdata <=int_lsc_register_GbGain_V_71;
                end
                ADDR_LSC_REGISTER_GBGAIN_V_72: begin
                    rdata <=int_lsc_register_GbGain_V_72;
                end
                ADDR_LSC_REGISTER_GBGAIN_V_73: begin
                    rdata <=int_lsc_register_GbGain_V_73;
                end
                ADDR_LSC_REGISTER_GBGAIN_V_74: begin
                    rdata <=int_lsc_register_GbGain_V_74;
                end
                ADDR_LSC_REGISTER_GBGAIN_V_75: begin
                    rdata <=int_lsc_register_GbGain_V_75;
                end
                ADDR_LSC_REGISTER_GBGAIN_V_76: begin
                    rdata <=int_lsc_register_GbGain_V_76;
                end
                ADDR_LSC_REGISTER_GBGAIN_V_77: begin
                    rdata <=int_lsc_register_GbGain_V_77;
                end
                ADDR_LSC_REGISTER_GBGAIN_V_78: begin
                    rdata <=int_lsc_register_GbGain_V_78;
                end
                ADDR_LSC_REGISTER_GBGAIN_V_79: begin
                    rdata <=int_lsc_register_GbGain_V_79;
                end
                ADDR_LSC_REGISTER_GBGAIN_V_80: begin
                    rdata <=int_lsc_register_GbGain_V_80;
                end
                ADDR_LSC_REGISTER_GBGAIN_V_81: begin
                    rdata <=int_lsc_register_GbGain_V_81;
                end
                ADDR_LSC_REGISTER_GBGAIN_V_82: begin
                    rdata <=int_lsc_register_GbGain_V_82;
                end
                ADDR_LSC_REGISTER_GBGAIN_V_83: begin
                    rdata <=int_lsc_register_GbGain_V_83;
                end
                ADDR_LSC_REGISTER_GBGAIN_V_84: begin
                    rdata <=int_lsc_register_GbGain_V_84;
                end
                ADDR_LSC_REGISTER_GBGAIN_V_85: begin
                    rdata <=int_lsc_register_GbGain_V_85;
                end
                ADDR_LSC_REGISTER_GBGAIN_V_86: begin
                    rdata <=int_lsc_register_GbGain_V_86;
                end
                ADDR_LSC_REGISTER_GBGAIN_V_87: begin
                    rdata <=int_lsc_register_GbGain_V_87;
                end
                ADDR_LSC_REGISTER_GBGAIN_V_88: begin
                    rdata <=int_lsc_register_GbGain_V_88;
                end
                ADDR_LSC_REGISTER_GBGAIN_V_89: begin
                    rdata <=int_lsc_register_GbGain_V_89;
                end
                ADDR_LSC_REGISTER_GBGAIN_V_90: begin
                    rdata <=int_lsc_register_GbGain_V_90;
                end
                ADDR_LSC_REGISTER_GBGAIN_V_91: begin
                    rdata <=int_lsc_register_GbGain_V_91;
                end
                ADDR_LSC_REGISTER_GBGAIN_V_92: begin
                    rdata <=int_lsc_register_GbGain_V_92;
                end
                ADDR_LSC_REGISTER_GBGAIN_V_93: begin
                    rdata <=int_lsc_register_GbGain_V_93;
                end
                ADDR_LSC_REGISTER_GBGAIN_V_94: begin
                    rdata <=int_lsc_register_GbGain_V_94;
                end
                ADDR_LSC_REGISTER_GBGAIN_V_95: begin
                    rdata <=int_lsc_register_GbGain_V_95;
                end
                ADDR_LSC_REGISTER_GBGAIN_V_96: begin
                    rdata <=int_lsc_register_GbGain_V_96;
                end
                ADDR_LSC_REGISTER_GBGAIN_V_97: begin
                    rdata <=int_lsc_register_GbGain_V_97;
                end
                ADDR_LSC_REGISTER_GBGAIN_V_98: begin
                    rdata <=int_lsc_register_GbGain_V_98;
                end
                ADDR_LSC_REGISTER_GBGAIN_V_99: begin
                    rdata <=int_lsc_register_GbGain_V_99;
                end
                ADDR_LSC_REGISTER_GBGAIN_V_100: begin
                    rdata <=int_lsc_register_GbGain_V_100;
                end
                ADDR_LSC_REGISTER_GBGAIN_V_101: begin
                    rdata <=int_lsc_register_GbGain_V_101;
                end
                ADDR_LSC_REGISTER_GBGAIN_V_102: begin
                    rdata <=int_lsc_register_GbGain_V_102;
                end
                ADDR_LSC_REGISTER_GBGAIN_V_103: begin
                    rdata <=int_lsc_register_GbGain_V_103;
                end
                ADDR_LSC_REGISTER_GBGAIN_V_104: begin
                    rdata <=int_lsc_register_GbGain_V_104;
                end
                ADDR_LSC_REGISTER_GBGAIN_V_105: begin
                    rdata <=int_lsc_register_GbGain_V_105;
                end
                ADDR_LSC_REGISTER_GBGAIN_V_106: begin
                    rdata <=int_lsc_register_GbGain_V_106;
                end
                ADDR_LSC_REGISTER_GBGAIN_V_107: begin
                    rdata <=int_lsc_register_GbGain_V_107;
                end
                ADDR_LSC_REGISTER_GBGAIN_V_108: begin
                    rdata <=int_lsc_register_GbGain_V_108;
                end
                ADDR_LSC_REGISTER_GBGAIN_V_109: begin
                    rdata <=int_lsc_register_GbGain_V_109;
                end
                ADDR_LSC_REGISTER_GBGAIN_V_110: begin
                    rdata <=int_lsc_register_GbGain_V_110;
                end
                ADDR_LSC_REGISTER_GBGAIN_V_111: begin
                    rdata <=int_lsc_register_GbGain_V_111;
                end
                ADDR_LSC_REGISTER_GBGAIN_V_112: begin
                    rdata <=int_lsc_register_GbGain_V_112;
                end
                ADDR_LSC_REGISTER_GBGAIN_V_113: begin
                    rdata <=int_lsc_register_GbGain_V_113;
                end
                ADDR_LSC_REGISTER_GBGAIN_V_114: begin
                    rdata <=int_lsc_register_GbGain_V_114;
                end
                ADDR_LSC_REGISTER_GBGAIN_V_115: begin
                    rdata <=int_lsc_register_GbGain_V_115;
                end
                ADDR_LSC_REGISTER_GBGAIN_V_116: begin
                    rdata <=int_lsc_register_GbGain_V_116;
                end
                ADDR_LSC_REGISTER_GBGAIN_V_117: begin
                    rdata <=int_lsc_register_GbGain_V_117;
                end
                ADDR_LSC_REGISTER_GBGAIN_V_118: begin
                    rdata <=int_lsc_register_GbGain_V_118;
                end
                ADDR_LSC_REGISTER_GBGAIN_V_119: begin
                    rdata <=int_lsc_register_GbGain_V_119;
                end
                ADDR_LSC_REGISTER_GBGAIN_V_120: begin
                    rdata <=int_lsc_register_GbGain_V_120;
                end
                ADDR_LSC_REGISTER_GBGAIN_V_121: begin
                    rdata <=int_lsc_register_GbGain_V_121;
                end
                ADDR_LSC_REGISTER_GBGAIN_V_122: begin
                    rdata <=int_lsc_register_GbGain_V_122;
                end
                ADDR_LSC_REGISTER_GBGAIN_V_123: begin
                    rdata <=int_lsc_register_GbGain_V_123;
                end
                ADDR_LSC_REGISTER_GBGAIN_V_124: begin
                    rdata <=int_lsc_register_GbGain_V_124;
                end
                ADDR_LSC_REGISTER_GBGAIN_V_125: begin
                    rdata <=int_lsc_register_GbGain_V_125;
                end
                ADDR_LSC_REGISTER_GBGAIN_V_126: begin
                    rdata <=int_lsc_register_GbGain_V_126;
                end
                ADDR_LSC_REGISTER_GBGAIN_V_127: begin
                    rdata <=int_lsc_register_GbGain_V_127;
                end
                ADDR_LSC_REGISTER_GBGAIN_V_128: begin
                    rdata <=int_lsc_register_GbGain_V_128;
                end
                ADDR_LSC_REGISTER_GBGAIN_V_129: begin
                    rdata <=int_lsc_register_GbGain_V_129;
                end
                ADDR_LSC_REGISTER_GBGAIN_V_130: begin
                    rdata <=int_lsc_register_GbGain_V_130;
                end
                ADDR_LSC_REGISTER_GBGAIN_V_131: begin
                    rdata <=int_lsc_register_GbGain_V_131;
                end
                ADDR_LSC_REGISTER_GBGAIN_V_132: begin
                    rdata <=int_lsc_register_GbGain_V_132;
                end
                ADDR_LSC_REGISTER_GBGAIN_V_133: begin
                    rdata <=int_lsc_register_GbGain_V_133;
                end
                ADDR_LSC_REGISTER_GBGAIN_V_134: begin
                    rdata <=int_lsc_register_GbGain_V_134;
                end
                ADDR_LSC_REGISTER_GBGAIN_V_135: begin
                    rdata <=int_lsc_register_GbGain_V_135;
                end
                ADDR_LSC_REGISTER_GBGAIN_V_136: begin
                    rdata <=int_lsc_register_GbGain_V_136;
                end
                ADDR_LSC_REGISTER_GBGAIN_V_137: begin
                    rdata <=int_lsc_register_GbGain_V_137;
                end
                ADDR_LSC_REGISTER_GBGAIN_V_138: begin
                    rdata <=int_lsc_register_GbGain_V_138;
                end
                ADDR_LSC_REGISTER_GBGAIN_V_139: begin
                    rdata <=int_lsc_register_GbGain_V_139;
                end
                ADDR_LSC_REGISTER_GBGAIN_V_140: begin
                    rdata <=int_lsc_register_GbGain_V_140;
                end
                ADDR_LSC_REGISTER_GBGAIN_V_141: begin
                    rdata <=int_lsc_register_GbGain_V_141;
                end
                ADDR_LSC_REGISTER_GBGAIN_V_142: begin
                    rdata <=int_lsc_register_GbGain_V_142;
                end
                ADDR_LSC_REGISTER_GBGAIN_V_143: begin
                    rdata <=int_lsc_register_GbGain_V_143;
                end
                ADDR_LSC_REGISTER_GBGAIN_V_144: begin
                    rdata <=int_lsc_register_GbGain_V_144;
                end
                ADDR_LSC_REGISTER_GBGAIN_V_145: begin
                    rdata <=int_lsc_register_GbGain_V_145;
                end
                ADDR_LSC_REGISTER_GBGAIN_V_146: begin
                    rdata <=int_lsc_register_GbGain_V_146;
                end
                ADDR_LSC_REGISTER_GBGAIN_V_147: begin
                    rdata <=int_lsc_register_GbGain_V_147;
                end
                ADDR_LSC_REGISTER_GBGAIN_V_148: begin
                    rdata <=int_lsc_register_GbGain_V_148;
                end
                ADDR_LSC_REGISTER_GBGAIN_V_149: begin
                    rdata <=int_lsc_register_GbGain_V_149;
                end
                ADDR_LSC_REGISTER_GBGAIN_V_150: begin
                    rdata <=int_lsc_register_GbGain_V_150;
                end
                ADDR_LSC_REGISTER_GBGAIN_V_151: begin
                    rdata <=int_lsc_register_GbGain_V_151;
                end
                ADDR_LSC_REGISTER_GBGAIN_V_152: begin
                    rdata <=int_lsc_register_GbGain_V_152;
                end
                ADDR_LSC_REGISTER_GBGAIN_V_153: begin
                    rdata <=int_lsc_register_GbGain_V_153;
                end
                ADDR_LSC_REGISTER_GBGAIN_V_154: begin
                    rdata <=int_lsc_register_GbGain_V_154;
                end
                ADDR_LSC_REGISTER_GBGAIN_V_155: begin
                    rdata <=int_lsc_register_GbGain_V_155;
                end
                ADDR_LSC_REGISTER_GBGAIN_V_156: begin
                    rdata <=int_lsc_register_GbGain_V_156;
                end
                ADDR_LSC_REGISTER_GBGAIN_V_157: begin
                    rdata <=int_lsc_register_GbGain_V_157;
                end
                ADDR_LSC_REGISTER_GBGAIN_V_158: begin
                    rdata <=int_lsc_register_GbGain_V_158;
                end
                ADDR_LSC_REGISTER_GBGAIN_V_159: begin
                    rdata <=int_lsc_register_GbGain_V_159;
                end
                ADDR_LSC_REGISTER_GBGAIN_V_160: begin
                    rdata <=int_lsc_register_GbGain_V_160;
                end
                ADDR_LSC_REGISTER_GBGAIN_V_161: begin
                    rdata <=int_lsc_register_GbGain_V_161;
                end
                ADDR_LSC_REGISTER_GBGAIN_V_162: begin
                    rdata <=int_lsc_register_GbGain_V_162;
                end
                ADDR_LSC_REGISTER_GBGAIN_V_163: begin
                    rdata <=int_lsc_register_GbGain_V_163;
                end
                ADDR_LSC_REGISTER_GBGAIN_V_164: begin
                    rdata <=int_lsc_register_GbGain_V_164;
                end
                ADDR_LSC_REGISTER_GBGAIN_V_165: begin
                    rdata <=int_lsc_register_GbGain_V_165;
                end
                ADDR_LSC_REGISTER_GBGAIN_V_166: begin
                    rdata <=int_lsc_register_GbGain_V_166;
                end
                ADDR_LSC_REGISTER_GBGAIN_V_167: begin
                    rdata <=int_lsc_register_GbGain_V_167;
                end
                ADDR_LSC_REGISTER_GBGAIN_V_168: begin
                    rdata <=int_lsc_register_GbGain_V_168;
                end
                ADDR_LSC_REGISTER_GBGAIN_V_169: begin
                    rdata <=int_lsc_register_GbGain_V_169;
                end
                ADDR_LSC_REGISTER_GBGAIN_V_170: begin
                    rdata <=int_lsc_register_GbGain_V_170;
                end
                ADDR_LSC_REGISTER_GBGAIN_V_171: begin
                    rdata <=int_lsc_register_GbGain_V_171;
                end
                ADDR_LSC_REGISTER_GBGAIN_V_172: begin
                    rdata <=int_lsc_register_GbGain_V_172;
                end
                ADDR_LSC_REGISTER_GBGAIN_V_173: begin
                    rdata <=int_lsc_register_GbGain_V_173;
                end
                ADDR_LSC_REGISTER_GBGAIN_V_174: begin
                    rdata <=int_lsc_register_GbGain_V_174;
                end
                ADDR_LSC_REGISTER_GBGAIN_V_175: begin
                    rdata <=int_lsc_register_GbGain_V_175;
                end
                ADDR_LSC_REGISTER_GBGAIN_V_176: begin
                    rdata <=int_lsc_register_GbGain_V_176;
                end
                ADDR_LSC_REGISTER_GBGAIN_V_177: begin
                    rdata <=int_lsc_register_GbGain_V_177;
                end
                ADDR_LSC_REGISTER_GBGAIN_V_178: begin
                    rdata <=int_lsc_register_GbGain_V_178;
                end
                ADDR_LSC_REGISTER_GBGAIN_V_179: begin
                    rdata <=int_lsc_register_GbGain_V_179;
                end
                ADDR_LSC_REGISTER_GBGAIN_V_180: begin
                    rdata <=int_lsc_register_GbGain_V_180;
                end
                ADDR_LSC_REGISTER_GBGAIN_V_181: begin
                    rdata <=int_lsc_register_GbGain_V_181;
                end
                ADDR_LSC_REGISTER_GBGAIN_V_182: begin
                    rdata <=int_lsc_register_GbGain_V_182;
                end
                ADDR_LSC_REGISTER_GBGAIN_V_183: begin
                    rdata <=int_lsc_register_GbGain_V_183;
                end
                ADDR_LSC_REGISTER_GBGAIN_V_184: begin
                    rdata <=int_lsc_register_GbGain_V_184;
                end
                ADDR_LSC_REGISTER_GBGAIN_V_185: begin
                    rdata <=int_lsc_register_GbGain_V_185;
                end
                ADDR_LSC_REGISTER_GBGAIN_V_186: begin
                    rdata <=int_lsc_register_GbGain_V_186;
                end
                ADDR_LSC_REGISTER_GBGAIN_V_187: begin
                    rdata <=int_lsc_register_GbGain_V_187;
                end
                ADDR_LSC_REGISTER_GBGAIN_V_188: begin
                    rdata <=int_lsc_register_GbGain_V_188;
                end
                ADDR_LSC_REGISTER_GBGAIN_V_189: begin
                    rdata <=int_lsc_register_GbGain_V_189;
                end
                ADDR_LSC_REGISTER_GBGAIN_V_190: begin
                    rdata <=int_lsc_register_GbGain_V_190;
                end
                ADDR_LSC_REGISTER_GBGAIN_V_191: begin
                    rdata <=int_lsc_register_GbGain_V_191;
                end
                ADDR_LSC_REGISTER_GBGAIN_V_192: begin
                    rdata <=int_lsc_register_GbGain_V_192;
                end
                ADDR_LSC_REGISTER_GBGAIN_V_193: begin
                    rdata <=int_lsc_register_GbGain_V_193;
                end
                ADDR_LSC_REGISTER_GBGAIN_V_194: begin
                    rdata <=int_lsc_register_GbGain_V_194;
                end
                ADDR_LSC_REGISTER_GBGAIN_V_195: begin
                    rdata <=int_lsc_register_GbGain_V_195;
                end
                ADDR_LSC_REGISTER_GBGAIN_V_196: begin
                    rdata <=int_lsc_register_GbGain_V_196;
                end
                ADDR_LSC_REGISTER_GBGAIN_V_197: begin
                    rdata <=int_lsc_register_GbGain_V_197;
                end
                ADDR_LSC_REGISTER_GBGAIN_V_198: begin
                    rdata <=int_lsc_register_GbGain_V_198;
                end
                ADDR_LSC_REGISTER_GBGAIN_V_199: begin
                    rdata <=int_lsc_register_GbGain_V_199;
                end
                ADDR_LSC_REGISTER_GBGAIN_V_200: begin
                    rdata <=int_lsc_register_GbGain_V_200;
                end
                ADDR_LSC_REGISTER_GBGAIN_V_201: begin
                    rdata <=int_lsc_register_GbGain_V_201;
                end
                ADDR_LSC_REGISTER_GBGAIN_V_202: begin
                    rdata <=int_lsc_register_GbGain_V_202;
                end
                ADDR_LSC_REGISTER_GBGAIN_V_203: begin
                    rdata <=int_lsc_register_GbGain_V_203;
                end
                ADDR_LSC_REGISTER_GBGAIN_V_204: begin
                    rdata <=int_lsc_register_GbGain_V_204;
                end
                ADDR_LSC_REGISTER_GBGAIN_V_205: begin
                    rdata <=int_lsc_register_GbGain_V_205;
                end
                ADDR_LSC_REGISTER_GBGAIN_V_206: begin
                    rdata <=int_lsc_register_GbGain_V_206;
                end
                ADDR_LSC_REGISTER_GBGAIN_V_207: begin
                    rdata <=int_lsc_register_GbGain_V_207;
                end
                ADDR_LSC_REGISTER_GBGAIN_V_208: begin
                    rdata <=int_lsc_register_GbGain_V_208;
                end
                ADDR_LSC_REGISTER_GBGAIN_V_209: begin
                    rdata <=int_lsc_register_GbGain_V_209;
                end
                ADDR_LSC_REGISTER_GBGAIN_V_210: begin
                    rdata <=int_lsc_register_GbGain_V_210;
                end
                ADDR_LSC_REGISTER_GBGAIN_V_211: begin
                    rdata <=int_lsc_register_GbGain_V_211;
                end
                ADDR_LSC_REGISTER_GBGAIN_V_212: begin
                    rdata <=int_lsc_register_GbGain_V_212;
                end
                ADDR_LSC_REGISTER_GBGAIN_V_213: begin
                    rdata <=int_lsc_register_GbGain_V_213;
                end
                ADDR_LSC_REGISTER_GBGAIN_V_214: begin
                    rdata <=int_lsc_register_GbGain_V_214;
                end
                ADDR_LSC_REGISTER_GBGAIN_V_215: begin
                    rdata <=int_lsc_register_GbGain_V_215;
                end
                ADDR_LSC_REGISTER_GBGAIN_V_216: begin
                    rdata <=int_lsc_register_GbGain_V_216;
                end
                ADDR_LSC_REGISTER_GBGAIN_V_217: begin
                    rdata <=int_lsc_register_GbGain_V_217;
                end
                ADDR_LSC_REGISTER_GBGAIN_V_218: begin
                    rdata <=int_lsc_register_GbGain_V_218;
                end
                ADDR_LSC_REGISTER_GBGAIN_V_219: begin
                    rdata <=int_lsc_register_GbGain_V_219;
                end
                ADDR_LSC_REGISTER_GBGAIN_V_220: begin
                    rdata <=int_lsc_register_GbGain_V_220;
                end
                ADDR_LSC_REGISTER_BGAIN_V_0: begin
                    rdata <=int_lsc_register_bGain_V_0;
                end
                ADDR_LSC_REGISTER_BGAIN_V_1: begin
                    rdata <=int_lsc_register_bGain_V_1;
                end
                ADDR_LSC_REGISTER_BGAIN_V_2: begin
                    rdata <=int_lsc_register_bGain_V_2;
                end
                ADDR_LSC_REGISTER_BGAIN_V_3: begin
                    rdata <=int_lsc_register_bGain_V_3;
                end
                ADDR_LSC_REGISTER_BGAIN_V_4: begin
                    rdata <=int_lsc_register_bGain_V_4;
                end
                ADDR_LSC_REGISTER_BGAIN_V_5: begin
                    rdata <=int_lsc_register_bGain_V_5;
                end
                ADDR_LSC_REGISTER_BGAIN_V_6: begin
                    rdata <=int_lsc_register_bGain_V_6;
                end
                ADDR_LSC_REGISTER_BGAIN_V_7: begin
                    rdata <=int_lsc_register_bGain_V_7;
                end
                ADDR_LSC_REGISTER_BGAIN_V_8: begin
                    rdata <=int_lsc_register_bGain_V_8;
                end
                ADDR_LSC_REGISTER_BGAIN_V_9: begin
                    rdata <=int_lsc_register_bGain_V_9;
                end
                ADDR_LSC_REGISTER_BGAIN_V_10: begin
                    rdata <=int_lsc_register_bGain_V_10;
                end
                ADDR_LSC_REGISTER_BGAIN_V_11: begin
                    rdata <=int_lsc_register_bGain_V_11;
                end
                ADDR_LSC_REGISTER_BGAIN_V_12: begin
                    rdata <=int_lsc_register_bGain_V_12;
                end
                ADDR_LSC_REGISTER_BGAIN_V_13: begin
                    rdata <=int_lsc_register_bGain_V_13;
                end
                ADDR_LSC_REGISTER_BGAIN_V_14: begin
                    rdata <=int_lsc_register_bGain_V_14;
                end
                ADDR_LSC_REGISTER_BGAIN_V_15: begin
                    rdata <=int_lsc_register_bGain_V_15;
                end
                ADDR_LSC_REGISTER_BGAIN_V_16: begin
                    rdata <=int_lsc_register_bGain_V_16;
                end
                ADDR_LSC_REGISTER_BGAIN_V_17: begin
                    rdata <=int_lsc_register_bGain_V_17;
                end
                ADDR_LSC_REGISTER_BGAIN_V_18: begin
                    rdata <=int_lsc_register_bGain_V_18;
                end
                ADDR_LSC_REGISTER_BGAIN_V_19: begin
                    rdata <=int_lsc_register_bGain_V_19;
                end
                ADDR_LSC_REGISTER_BGAIN_V_20: begin
                    rdata <=int_lsc_register_bGain_V_20;
                end
                ADDR_LSC_REGISTER_BGAIN_V_21: begin
                    rdata <=int_lsc_register_bGain_V_21;
                end
                ADDR_LSC_REGISTER_BGAIN_V_22: begin
                    rdata <=int_lsc_register_bGain_V_22;
                end
                ADDR_LSC_REGISTER_BGAIN_V_23: begin
                    rdata <=int_lsc_register_bGain_V_23;
                end
                ADDR_LSC_REGISTER_BGAIN_V_24: begin
                    rdata <=int_lsc_register_bGain_V_24;
                end
                ADDR_LSC_REGISTER_BGAIN_V_25: begin
                    rdata <=int_lsc_register_bGain_V_25;
                end
                ADDR_LSC_REGISTER_BGAIN_V_26: begin
                    rdata <=int_lsc_register_bGain_V_26;
                end
                ADDR_LSC_REGISTER_BGAIN_V_27: begin
                    rdata <=int_lsc_register_bGain_V_27;
                end
                ADDR_LSC_REGISTER_BGAIN_V_28: begin
                    rdata <=int_lsc_register_bGain_V_28;
                end
                ADDR_LSC_REGISTER_BGAIN_V_29: begin
                    rdata <=int_lsc_register_bGain_V_29;
                end
                ADDR_LSC_REGISTER_BGAIN_V_30: begin
                    rdata <=int_lsc_register_bGain_V_30;
                end
                ADDR_LSC_REGISTER_BGAIN_V_31: begin
                    rdata <=int_lsc_register_bGain_V_31;
                end
                ADDR_LSC_REGISTER_BGAIN_V_32: begin
                    rdata <=int_lsc_register_bGain_V_32;
                end
                ADDR_LSC_REGISTER_BGAIN_V_33: begin
                    rdata <=int_lsc_register_bGain_V_33;
                end
                ADDR_LSC_REGISTER_BGAIN_V_34: begin
                    rdata <=int_lsc_register_bGain_V_34;
                end
                ADDR_LSC_REGISTER_BGAIN_V_35: begin
                    rdata <=int_lsc_register_bGain_V_35;
                end
                ADDR_LSC_REGISTER_BGAIN_V_36: begin
                    rdata <=int_lsc_register_bGain_V_36;
                end
                ADDR_LSC_REGISTER_BGAIN_V_37: begin
                    rdata <=int_lsc_register_bGain_V_37;
                end
                ADDR_LSC_REGISTER_BGAIN_V_38: begin
                    rdata <=int_lsc_register_bGain_V_38;
                end
                ADDR_LSC_REGISTER_BGAIN_V_39: begin
                    rdata <=int_lsc_register_bGain_V_39;
                end
                ADDR_LSC_REGISTER_BGAIN_V_40: begin
                    rdata <=int_lsc_register_bGain_V_40;
                end
                ADDR_LSC_REGISTER_BGAIN_V_41: begin
                    rdata <=int_lsc_register_bGain_V_41;
                end
                ADDR_LSC_REGISTER_BGAIN_V_42: begin
                    rdata <=int_lsc_register_bGain_V_42;
                end
                ADDR_LSC_REGISTER_BGAIN_V_43: begin
                    rdata <=int_lsc_register_bGain_V_43;
                end
                ADDR_LSC_REGISTER_BGAIN_V_44: begin
                    rdata <=int_lsc_register_bGain_V_44;
                end
                ADDR_LSC_REGISTER_BGAIN_V_45: begin
                    rdata <=int_lsc_register_bGain_V_45;
                end
                ADDR_LSC_REGISTER_BGAIN_V_46: begin
                    rdata <=int_lsc_register_bGain_V_46;
                end
                ADDR_LSC_REGISTER_BGAIN_V_47: begin
                    rdata <=int_lsc_register_bGain_V_47;
                end
                ADDR_LSC_REGISTER_BGAIN_V_48: begin
                    rdata <=int_lsc_register_bGain_V_48;
                end
                ADDR_LSC_REGISTER_BGAIN_V_49: begin
                    rdata <=int_lsc_register_bGain_V_49;
                end
                ADDR_LSC_REGISTER_BGAIN_V_50: begin
                    rdata <=int_lsc_register_bGain_V_50;
                end
                ADDR_LSC_REGISTER_BGAIN_V_51: begin
                    rdata <=int_lsc_register_bGain_V_51;
                end
                ADDR_LSC_REGISTER_BGAIN_V_52: begin
                    rdata <=int_lsc_register_bGain_V_52;
                end
                ADDR_LSC_REGISTER_BGAIN_V_53: begin
                    rdata <=int_lsc_register_bGain_V_53;
                end
                ADDR_LSC_REGISTER_BGAIN_V_54: begin
                    rdata <=int_lsc_register_bGain_V_54;
                end
                ADDR_LSC_REGISTER_BGAIN_V_55: begin
                    rdata <=int_lsc_register_bGain_V_55;
                end
                ADDR_LSC_REGISTER_BGAIN_V_56: begin
                    rdata <=int_lsc_register_bGain_V_56;
                end
                ADDR_LSC_REGISTER_BGAIN_V_57: begin
                    rdata <=int_lsc_register_bGain_V_57;
                end
                ADDR_LSC_REGISTER_BGAIN_V_58: begin
                    rdata <=int_lsc_register_bGain_V_58;
                end
                ADDR_LSC_REGISTER_BGAIN_V_59: begin
                    rdata <=int_lsc_register_bGain_V_59;
                end
                ADDR_LSC_REGISTER_BGAIN_V_60: begin
                    rdata <=int_lsc_register_bGain_V_60;
                end
                ADDR_LSC_REGISTER_BGAIN_V_61: begin
                    rdata <=int_lsc_register_bGain_V_61;
                end
                ADDR_LSC_REGISTER_BGAIN_V_62: begin
                    rdata <=int_lsc_register_bGain_V_62;
                end
                ADDR_LSC_REGISTER_BGAIN_V_63: begin
                    rdata <=int_lsc_register_bGain_V_63;
                end
                ADDR_LSC_REGISTER_BGAIN_V_64: begin
                    rdata <=int_lsc_register_bGain_V_64;
                end
                ADDR_LSC_REGISTER_BGAIN_V_65: begin
                    rdata <=int_lsc_register_bGain_V_65;
                end
                ADDR_LSC_REGISTER_BGAIN_V_66: begin
                    rdata <=int_lsc_register_bGain_V_66;
                end
                ADDR_LSC_REGISTER_BGAIN_V_67: begin
                    rdata <=int_lsc_register_bGain_V_67;
                end
                ADDR_LSC_REGISTER_BGAIN_V_68: begin
                    rdata <=int_lsc_register_bGain_V_68;
                end
                ADDR_LSC_REGISTER_BGAIN_V_69: begin
                    rdata <=int_lsc_register_bGain_V_69;
                end
                ADDR_LSC_REGISTER_BGAIN_V_70: begin
                    rdata <=int_lsc_register_bGain_V_70;
                end
                ADDR_LSC_REGISTER_BGAIN_V_71: begin
                    rdata <=int_lsc_register_bGain_V_71;
                end
                ADDR_LSC_REGISTER_BGAIN_V_72: begin
                    rdata <=int_lsc_register_bGain_V_72;
                end
                ADDR_LSC_REGISTER_BGAIN_V_73: begin
                    rdata <=int_lsc_register_bGain_V_73;
                end
                ADDR_LSC_REGISTER_BGAIN_V_74: begin
                    rdata <=int_lsc_register_bGain_V_74;
                end
                ADDR_LSC_REGISTER_BGAIN_V_75: begin
                    rdata <=int_lsc_register_bGain_V_75;
                end
                ADDR_LSC_REGISTER_BGAIN_V_76: begin
                    rdata <=int_lsc_register_bGain_V_76;
                end
                ADDR_LSC_REGISTER_BGAIN_V_77: begin
                    rdata <=int_lsc_register_bGain_V_77;
                end
                ADDR_LSC_REGISTER_BGAIN_V_78: begin
                    rdata <=int_lsc_register_bGain_V_78;
                end
                ADDR_LSC_REGISTER_BGAIN_V_79: begin
                    rdata <=int_lsc_register_bGain_V_79;
                end
                ADDR_LSC_REGISTER_BGAIN_V_80: begin
                    rdata <=int_lsc_register_bGain_V_80;
                end
                ADDR_LSC_REGISTER_BGAIN_V_81: begin
                    rdata <=int_lsc_register_bGain_V_81;
                end
                ADDR_LSC_REGISTER_BGAIN_V_82: begin
                    rdata <=int_lsc_register_bGain_V_82;
                end
                ADDR_LSC_REGISTER_BGAIN_V_83: begin
                    rdata <=int_lsc_register_bGain_V_83;
                end
                ADDR_LSC_REGISTER_BGAIN_V_84: begin
                    rdata <=int_lsc_register_bGain_V_84;
                end
                ADDR_LSC_REGISTER_BGAIN_V_85: begin
                    rdata <=int_lsc_register_bGain_V_85;
                end
                ADDR_LSC_REGISTER_BGAIN_V_86: begin
                    rdata <=int_lsc_register_bGain_V_86;
                end
                ADDR_LSC_REGISTER_BGAIN_V_87: begin
                    rdata <=int_lsc_register_bGain_V_87;
                end
                ADDR_LSC_REGISTER_BGAIN_V_88: begin
                    rdata <=int_lsc_register_bGain_V_88;
                end
                ADDR_LSC_REGISTER_BGAIN_V_89: begin
                    rdata <=int_lsc_register_bGain_V_89;
                end
                ADDR_LSC_REGISTER_BGAIN_V_90: begin
                    rdata <=int_lsc_register_bGain_V_90;
                end
                ADDR_LSC_REGISTER_BGAIN_V_91: begin
                    rdata <=int_lsc_register_bGain_V_91;
                end
                ADDR_LSC_REGISTER_BGAIN_V_92: begin
                    rdata <=int_lsc_register_bGain_V_92;
                end
                ADDR_LSC_REGISTER_BGAIN_V_93: begin
                    rdata <=int_lsc_register_bGain_V_93;
                end
                ADDR_LSC_REGISTER_BGAIN_V_94: begin
                    rdata <=int_lsc_register_bGain_V_94;
                end
                ADDR_LSC_REGISTER_BGAIN_V_95: begin
                    rdata <=int_lsc_register_bGain_V_95;
                end
                ADDR_LSC_REGISTER_BGAIN_V_96: begin
                    rdata <=int_lsc_register_bGain_V_96;
                end
                ADDR_LSC_REGISTER_BGAIN_V_97: begin
                    rdata <=int_lsc_register_bGain_V_97;
                end
                ADDR_LSC_REGISTER_BGAIN_V_98: begin
                    rdata <=int_lsc_register_bGain_V_98;
                end
                ADDR_LSC_REGISTER_BGAIN_V_99: begin
                    rdata <=int_lsc_register_bGain_V_99;
                end
                ADDR_LSC_REGISTER_BGAIN_V_100: begin
                    rdata <=int_lsc_register_bGain_V_100;
                end
                ADDR_LSC_REGISTER_BGAIN_V_101: begin
                    rdata <=int_lsc_register_bGain_V_101;
                end
                ADDR_LSC_REGISTER_BGAIN_V_102: begin
                    rdata <=int_lsc_register_bGain_V_102;
                end
                ADDR_LSC_REGISTER_BGAIN_V_103: begin
                    rdata <=int_lsc_register_bGain_V_103;
                end
                ADDR_LSC_REGISTER_BGAIN_V_104: begin
                    rdata <=int_lsc_register_bGain_V_104;
                end
                ADDR_LSC_REGISTER_BGAIN_V_105: begin
                    rdata <=int_lsc_register_bGain_V_105;
                end
                ADDR_LSC_REGISTER_BGAIN_V_106: begin
                    rdata <=int_lsc_register_bGain_V_106;
                end
                ADDR_LSC_REGISTER_BGAIN_V_107: begin
                    rdata <=int_lsc_register_bGain_V_107;
                end
                ADDR_LSC_REGISTER_BGAIN_V_108: begin
                    rdata <=int_lsc_register_bGain_V_108;
                end
                ADDR_LSC_REGISTER_BGAIN_V_109: begin
                    rdata <=int_lsc_register_bGain_V_109;
                end
                ADDR_LSC_REGISTER_BGAIN_V_110: begin
                    rdata <=int_lsc_register_bGain_V_110;
                end
                ADDR_LSC_REGISTER_BGAIN_V_111: begin
                    rdata <=int_lsc_register_bGain_V_111;
                end
                ADDR_LSC_REGISTER_BGAIN_V_112: begin
                    rdata <=int_lsc_register_bGain_V_112;
                end
                ADDR_LSC_REGISTER_BGAIN_V_113: begin
                    rdata <=int_lsc_register_bGain_V_113;
                end
                ADDR_LSC_REGISTER_BGAIN_V_114: begin
                    rdata <=int_lsc_register_bGain_V_114;
                end
                ADDR_LSC_REGISTER_BGAIN_V_115: begin
                    rdata <=int_lsc_register_bGain_V_115;
                end
                ADDR_LSC_REGISTER_BGAIN_V_116: begin
                    rdata <=int_lsc_register_bGain_V_116;
                end
                ADDR_LSC_REGISTER_BGAIN_V_117: begin
                    rdata <=int_lsc_register_bGain_V_117;
                end
                ADDR_LSC_REGISTER_BGAIN_V_118: begin
                    rdata <=int_lsc_register_bGain_V_118;
                end
                ADDR_LSC_REGISTER_BGAIN_V_119: begin
                    rdata <=int_lsc_register_bGain_V_119;
                end
                ADDR_LSC_REGISTER_BGAIN_V_120: begin
                    rdata <=int_lsc_register_bGain_V_120;
                end
                ADDR_LSC_REGISTER_BGAIN_V_121: begin
                    rdata <=int_lsc_register_bGain_V_121;
                end
                ADDR_LSC_REGISTER_BGAIN_V_122: begin
                    rdata <=int_lsc_register_bGain_V_122;
                end
                ADDR_LSC_REGISTER_BGAIN_V_123: begin
                    rdata <=int_lsc_register_bGain_V_123;
                end
                ADDR_LSC_REGISTER_BGAIN_V_124: begin
                    rdata <=int_lsc_register_bGain_V_124;
                end
                ADDR_LSC_REGISTER_BGAIN_V_125: begin
                    rdata <=int_lsc_register_bGain_V_125;
                end
                ADDR_LSC_REGISTER_BGAIN_V_126: begin
                    rdata <=int_lsc_register_bGain_V_126;
                end
                ADDR_LSC_REGISTER_BGAIN_V_127: begin
                    rdata <=int_lsc_register_bGain_V_127;
                end
                ADDR_LSC_REGISTER_BGAIN_V_128: begin
                    rdata <=int_lsc_register_bGain_V_128;
                end
                ADDR_LSC_REGISTER_BGAIN_V_129: begin
                    rdata <=int_lsc_register_bGain_V_129;
                end
                ADDR_LSC_REGISTER_BGAIN_V_130: begin
                    rdata <=int_lsc_register_bGain_V_130;
                end
                ADDR_LSC_REGISTER_BGAIN_V_131: begin
                    rdata <=int_lsc_register_bGain_V_131;
                end
                ADDR_LSC_REGISTER_BGAIN_V_132: begin
                    rdata <=int_lsc_register_bGain_V_132;
                end
                ADDR_LSC_REGISTER_BGAIN_V_133: begin
                    rdata <=int_lsc_register_bGain_V_133;
                end
                ADDR_LSC_REGISTER_BGAIN_V_134: begin
                    rdata <=int_lsc_register_bGain_V_134;
                end
                ADDR_LSC_REGISTER_BGAIN_V_135: begin
                    rdata <=int_lsc_register_bGain_V_135;
                end
                ADDR_LSC_REGISTER_BGAIN_V_136: begin
                    rdata <=int_lsc_register_bGain_V_136;
                end
                ADDR_LSC_REGISTER_BGAIN_V_137: begin
                    rdata <=int_lsc_register_bGain_V_137;
                end
                ADDR_LSC_REGISTER_BGAIN_V_138: begin
                    rdata <=int_lsc_register_bGain_V_138;
                end
                ADDR_LSC_REGISTER_BGAIN_V_139: begin
                    rdata <=int_lsc_register_bGain_V_139;
                end
                ADDR_LSC_REGISTER_BGAIN_V_140: begin
                    rdata <=int_lsc_register_bGain_V_140;
                end
                ADDR_LSC_REGISTER_BGAIN_V_141: begin
                    rdata <=int_lsc_register_bGain_V_141;
                end
                ADDR_LSC_REGISTER_BGAIN_V_142: begin
                    rdata <=int_lsc_register_bGain_V_142;
                end
                ADDR_LSC_REGISTER_BGAIN_V_143: begin
                    rdata <=int_lsc_register_bGain_V_143;
                end
                ADDR_LSC_REGISTER_BGAIN_V_144: begin
                    rdata <=int_lsc_register_bGain_V_144;
                end
                ADDR_LSC_REGISTER_BGAIN_V_145: begin
                    rdata <=int_lsc_register_bGain_V_145;
                end
                ADDR_LSC_REGISTER_BGAIN_V_146: begin
                    rdata <=int_lsc_register_bGain_V_146;
                end
                ADDR_LSC_REGISTER_BGAIN_V_147: begin
                    rdata <=int_lsc_register_bGain_V_147;
                end
                ADDR_LSC_REGISTER_BGAIN_V_148: begin
                    rdata <=int_lsc_register_bGain_V_148;
                end
                ADDR_LSC_REGISTER_BGAIN_V_149: begin
                    rdata <=int_lsc_register_bGain_V_149;
                end
                ADDR_LSC_REGISTER_BGAIN_V_150: begin
                    rdata <=int_lsc_register_bGain_V_150;
                end
                ADDR_LSC_REGISTER_BGAIN_V_151: begin
                    rdata <=int_lsc_register_bGain_V_151;
                end
                ADDR_LSC_REGISTER_BGAIN_V_152: begin
                    rdata <=int_lsc_register_bGain_V_152;
                end
                ADDR_LSC_REGISTER_BGAIN_V_153: begin
                    rdata <=int_lsc_register_bGain_V_153;
                end
                ADDR_LSC_REGISTER_BGAIN_V_154: begin
                    rdata <=int_lsc_register_bGain_V_154;
                end
                ADDR_LSC_REGISTER_BGAIN_V_155: begin
                    rdata <=int_lsc_register_bGain_V_155;
                end
                ADDR_LSC_REGISTER_BGAIN_V_156: begin
                    rdata <=int_lsc_register_bGain_V_156;
                end
                ADDR_LSC_REGISTER_BGAIN_V_157: begin
                    rdata <=int_lsc_register_bGain_V_157;
                end
                ADDR_LSC_REGISTER_BGAIN_V_158: begin
                    rdata <=int_lsc_register_bGain_V_158;
                end
                ADDR_LSC_REGISTER_BGAIN_V_159: begin
                    rdata <=int_lsc_register_bGain_V_159;
                end
                ADDR_LSC_REGISTER_BGAIN_V_160: begin
                    rdata <=int_lsc_register_bGain_V_160;
                end
                ADDR_LSC_REGISTER_BGAIN_V_161: begin
                    rdata <=int_lsc_register_bGain_V_161;
                end
                ADDR_LSC_REGISTER_BGAIN_V_162: begin
                    rdata <=int_lsc_register_bGain_V_162;
                end
                ADDR_LSC_REGISTER_BGAIN_V_163: begin
                    rdata <=int_lsc_register_bGain_V_163;
                end
                ADDR_LSC_REGISTER_BGAIN_V_164: begin
                    rdata <=int_lsc_register_bGain_V_164;
                end
                ADDR_LSC_REGISTER_BGAIN_V_165: begin
                    rdata <=int_lsc_register_bGain_V_165;
                end
                ADDR_LSC_REGISTER_BGAIN_V_166: begin
                    rdata <=int_lsc_register_bGain_V_166;
                end
                ADDR_LSC_REGISTER_BGAIN_V_167: begin
                    rdata <=int_lsc_register_bGain_V_167;
                end
                ADDR_LSC_REGISTER_BGAIN_V_168: begin
                    rdata <=int_lsc_register_bGain_V_168;
                end
                ADDR_LSC_REGISTER_BGAIN_V_169: begin
                    rdata <=int_lsc_register_bGain_V_169;
                end
                ADDR_LSC_REGISTER_BGAIN_V_170: begin
                    rdata <=int_lsc_register_bGain_V_170;
                end
                ADDR_LSC_REGISTER_BGAIN_V_171: begin
                    rdata <=int_lsc_register_bGain_V_171;
                end
                ADDR_LSC_REGISTER_BGAIN_V_172: begin
                    rdata <=int_lsc_register_bGain_V_172;
                end
                ADDR_LSC_REGISTER_BGAIN_V_173: begin
                    rdata <=int_lsc_register_bGain_V_173;
                end
                ADDR_LSC_REGISTER_BGAIN_V_174: begin
                    rdata <=int_lsc_register_bGain_V_174;
                end
                ADDR_LSC_REGISTER_BGAIN_V_175: begin
                    rdata <=int_lsc_register_bGain_V_175;
                end
                ADDR_LSC_REGISTER_BGAIN_V_176: begin
                    rdata <=int_lsc_register_bGain_V_176;
                end
                ADDR_LSC_REGISTER_BGAIN_V_177: begin
                    rdata <=int_lsc_register_bGain_V_177;
                end
                ADDR_LSC_REGISTER_BGAIN_V_178: begin
                    rdata <=int_lsc_register_bGain_V_178;
                end
                ADDR_LSC_REGISTER_BGAIN_V_179: begin
                    rdata <=int_lsc_register_bGain_V_179;
                end
                ADDR_LSC_REGISTER_BGAIN_V_180: begin
                    rdata <=int_lsc_register_bGain_V_180;
                end
                ADDR_LSC_REGISTER_BGAIN_V_181: begin
                    rdata <=int_lsc_register_bGain_V_181;
                end
                ADDR_LSC_REGISTER_BGAIN_V_182: begin
                    rdata <=int_lsc_register_bGain_V_182;
                end
                ADDR_LSC_REGISTER_BGAIN_V_183: begin
                    rdata <=int_lsc_register_bGain_V_183;
                end
                ADDR_LSC_REGISTER_BGAIN_V_184: begin
                    rdata <=int_lsc_register_bGain_V_184;
                end
                ADDR_LSC_REGISTER_BGAIN_V_185: begin
                    rdata <=int_lsc_register_bGain_V_185;
                end
                ADDR_LSC_REGISTER_BGAIN_V_186: begin
                    rdata <=int_lsc_register_bGain_V_186;
                end
                ADDR_LSC_REGISTER_BGAIN_V_187: begin
                    rdata <=int_lsc_register_bGain_V_187;
                end
                ADDR_LSC_REGISTER_BGAIN_V_188: begin
                    rdata <=int_lsc_register_bGain_V_188;
                end
                ADDR_LSC_REGISTER_BGAIN_V_189: begin
                    rdata <=int_lsc_register_bGain_V_189;
                end
                ADDR_LSC_REGISTER_BGAIN_V_190: begin
                    rdata <=int_lsc_register_bGain_V_190;
                end
                ADDR_LSC_REGISTER_BGAIN_V_191: begin
                    rdata <=int_lsc_register_bGain_V_191;
                end
                ADDR_LSC_REGISTER_BGAIN_V_192: begin
                    rdata <=int_lsc_register_bGain_V_192;
                end
                ADDR_LSC_REGISTER_BGAIN_V_193: begin
                    rdata <=int_lsc_register_bGain_V_193;
                end
                ADDR_LSC_REGISTER_BGAIN_V_194: begin
                    rdata <=int_lsc_register_bGain_V_194;
                end
                ADDR_LSC_REGISTER_BGAIN_V_195: begin
                    rdata <=int_lsc_register_bGain_V_195;
                end
                ADDR_LSC_REGISTER_BGAIN_V_196: begin
                    rdata <=int_lsc_register_bGain_V_196;
                end
                ADDR_LSC_REGISTER_BGAIN_V_197: begin
                    rdata <=int_lsc_register_bGain_V_197;
                end
                ADDR_LSC_REGISTER_BGAIN_V_198: begin
                    rdata <=int_lsc_register_bGain_V_198;
                end
                ADDR_LSC_REGISTER_BGAIN_V_199: begin
                    rdata <=int_lsc_register_bGain_V_199;
                end
                ADDR_LSC_REGISTER_BGAIN_V_200: begin
                    rdata <=int_lsc_register_bGain_V_200;
                end
                ADDR_LSC_REGISTER_BGAIN_V_201: begin
                    rdata <=int_lsc_register_bGain_V_201;
                end
                ADDR_LSC_REGISTER_BGAIN_V_202: begin
                    rdata <=int_lsc_register_bGain_V_202;
                end
                ADDR_LSC_REGISTER_BGAIN_V_203: begin
                    rdata <=int_lsc_register_bGain_V_203;
                end
                ADDR_LSC_REGISTER_BGAIN_V_204: begin
                    rdata <=int_lsc_register_bGain_V_204;
                end
                ADDR_LSC_REGISTER_BGAIN_V_205: begin
                    rdata <=int_lsc_register_bGain_V_205;
                end
                ADDR_LSC_REGISTER_BGAIN_V_206: begin
                    rdata <=int_lsc_register_bGain_V_206;
                end
                ADDR_LSC_REGISTER_BGAIN_V_207: begin
                    rdata <=int_lsc_register_bGain_V_207;
                end
                ADDR_LSC_REGISTER_BGAIN_V_208: begin
                    rdata <=int_lsc_register_bGain_V_208;
                end
                ADDR_LSC_REGISTER_BGAIN_V_209: begin
                    rdata <=int_lsc_register_bGain_V_209;
                end
                ADDR_LSC_REGISTER_BGAIN_V_210: begin
                    rdata <=int_lsc_register_bGain_V_210;
                end
                ADDR_LSC_REGISTER_BGAIN_V_211: begin
                    rdata <=int_lsc_register_bGain_V_211;
                end
                ADDR_LSC_REGISTER_BGAIN_V_212: begin
                    rdata <=int_lsc_register_bGain_V_212;
                end
                ADDR_LSC_REGISTER_BGAIN_V_213: begin
                    rdata <=int_lsc_register_bGain_V_213;
                end
                ADDR_LSC_REGISTER_BGAIN_V_214: begin
                    rdata <=int_lsc_register_bGain_V_214;
                end
                ADDR_LSC_REGISTER_BGAIN_V_215: begin
                    rdata <=int_lsc_register_bGain_V_215;
                end
                ADDR_LSC_REGISTER_BGAIN_V_216: begin
                    rdata <=int_lsc_register_bGain_V_216;
                end
                ADDR_LSC_REGISTER_BGAIN_V_217: begin
                    rdata <=int_lsc_register_bGain_V_217;
                end
                ADDR_LSC_REGISTER_BGAIN_V_218: begin
                    rdata <=int_lsc_register_bGain_V_218;
                end
                ADDR_LSC_REGISTER_BGAIN_V_219: begin
                    rdata <=int_lsc_register_bGain_V_219;
                end
                ADDR_LSC_REGISTER_BGAIN_V_220: begin
                    rdata <=int_lsc_register_bGain_V_220;
                end
                ADDR_LSC_REGISTER_BLOCKHEIGHT_V: begin
                    rdata <=int_lsc_register_blockHeight_V;
                end
                ADDR_LSC_REGISTER_BLOCKWIDTH_V: begin
                    rdata <=int_lsc_register_blockWidth_V;
                end
                ADDR_LSC_REGISTER_BLOCKWIDTH_1_V: begin
                    rdata <=int_lsc_register_blockWidth_1_V;
                end
                ADDR_LSC_REGISTER_BLOCKHEIGHT_1_V: begin
                    rdata <=int_lsc_register_blockHeight_1_V;
                end
                ADDR_DPC_REGISTER_EB: begin
                    rdata <=int_dpc_register_eb;
                end
                ADDR_DPC_REGISTER_TH_W_V: begin
                    rdata <=int_dpc_register_th_w_V;
                end
                ADDR_DPC_REGISTER_TH_B_V: begin
                    rdata <=int_dpc_register_th_b_V;
                end
                ADDR_RAWDNS_REGISTER_SIGMA_V: begin
                    rdata <=int_rawdns_register_sigma_V;
                end
                ADDR_RAWDNS_REGISTER_EB_V: begin
                    rdata <=int_rawdns_register_eb_V;
                end
                ADDR_RAWDNS_REGISTER_FILTERPARA_V: begin
                    rdata <=int_rawdns_register_Filterpara_V;
                end
                ADDR_RAWDNS_REGISTER_INVKSIGMA2_V: begin
                    rdata <=int_rawdns_register_invksigma2_V;
                end
                ADDR_AWB_REGISTER_M_NEB: begin
                    rdata <=int_awb_register_m_nEb;
                end
                ADDR_AWB_REGISTER_R_GAIN_V: begin
                    rdata <=int_awb_register_r_gain_V;
                end
                ADDR_AWB_REGISTER_G_GAIN_V: begin
                    rdata <=int_awb_register_g_gain_V;
                end
                ADDR_AWB_REGISTER_B_GAIN_V: begin
                    rdata <=int_awb_register_b_gain_V;
                end
                ADDR_AWB_REGISTER_COEFF_V: begin
                    rdata <=int_awb_register_coeff_V;
                end
                ADDR_WBC_REGISTER_M_NEB: begin
                    rdata <=int_wbc_register_m_nEb;
                end
                ADDR_WBC_REGISTER_M_NR_V: begin
                    rdata <=int_wbc_register_m_nR_V;
                end
                ADDR_WBC_REGISTER_M_NGR_V: begin
                    rdata <=int_wbc_register_m_nGr_V;
                end
                ADDR_WBC_REGISTER_M_NGB_V: begin
                    rdata <=int_wbc_register_m_nGb_V;
                end
                ADDR_WBC_REGISTER_M_NB_V: begin
                    rdata <=int_wbc_register_m_nB_V;
                end
                ADDR_GB_REGISTER_EB: begin
                    rdata <=int_gb_register_eb;
                end
                ADDR_GB_REGISTER_WIN_SIZE_V: begin
                    rdata <=int_gb_register_win_size_V;
                end
                ADDR_GB_REGISTER_LBOUND_V: begin
                    rdata <=int_gb_register_Lbound_V;
                end
                ADDR_GB_REGISTER_HBOUND_V: begin
                    rdata <=int_gb_register_Hbound_V;
                end
                ADDR_GB_REGISTER_THREHOLD_V: begin
                    rdata <=int_gb_register_threhold_V;
                end
                ADDR_DEMOSAIC_REGISTER_EB: begin
                    rdata <=int_demosaic_register_eb;
                end
                ADDR_EE_REGISTER_EB: begin
                    rdata <=int_ee_register_eb;
                end
                ADDR_EE_REGISTER_COEFF_V: begin
                    rdata <=int_ee_register_coeff_V;
                end
                ADDR_CMC_REGISTER_M_NEB: begin
                    rdata <=int_cmc_register_m_nEb;
                end
                ADDR_CMC_REGISTER_M_NGAIN_V_0: begin
                    rdata <=int_cmc_register_m_nGain_V_0;
                end
                ADDR_CMC_REGISTER_M_NGAIN_V_1: begin
                    rdata <=int_cmc_register_m_nGain_V_1;
                end
                ADDR_CMC_REGISTER_M_NGAIN_V_2: begin
                    rdata <=int_cmc_register_m_nGain_V_2;
                end
                ADDR_CMC_REGISTER_M_NGAIN_V_3: begin
                    rdata <=int_cmc_register_m_nGain_V_3;
                end
                ADDR_CMC_REGISTER_M_NGAIN_V_4: begin
                    rdata <=int_cmc_register_m_nGain_V_4;
                end
                ADDR_CMC_REGISTER_M_NGAIN_V_5: begin
                    rdata <=int_cmc_register_m_nGain_V_5;
                end
                ADDR_CMC_REGISTER_M_NGAIN_V_6: begin
                    rdata <=int_cmc_register_m_nGain_V_6;
                end
                ADDR_CMC_REGISTER_M_NGAIN_V_7: begin
                    rdata <=int_cmc_register_m_nGain_V_7;
                end
                ADDR_CMC_REGISTER_M_NGAIN_V_8: begin
                    rdata <=int_cmc_register_m_nGain_V_8;
                end
                ADDR_CMC_REGISTER_M_NGAIN_V_9: begin
                    rdata <=int_cmc_register_m_nGain_V_9;
                end
                ADDR_CMC_REGISTER_M_NGAIN_V_10: begin
                    rdata <=int_cmc_register_m_nGain_V_10;
                end
                ADDR_CMC_REGISTER_M_NGAIN_V_11: begin
                    rdata <=int_cmc_register_m_nGain_V_11;
                end
                ADDR_CMC_REGISTER_M_BCFCENABLE: begin
                    rdata <=int_cmc_register_m_bCFCEnable;
                end
                ADDR_CMC_REGISTER_M_BDISCARDH: begin
                    rdata <=int_cmc_register_m_bDiscardH;
                end
                ADDR_CMC_REGISTER_M_PHUERANGE_V_0: begin
                    rdata <=int_cmc_register_m_pHueRange_V_0;
                end
                ADDR_CMC_REGISTER_M_PHUERANGE_V_1: begin
                    rdata <=int_cmc_register_m_pHueRange_V_1;
                end
                ADDR_CMC_REGISTER_M_NHUEBANDSHIFT_V: begin
                    rdata <=int_cmc_register_m_nHueBandShift_V;
                end
                ADDR_CMC_REGISTER_M_NEDGETHRE_V: begin
                    rdata <=int_cmc_register_m_nEdgeThre_V;
                end
                ADDR_CMC_REGISTER_M_NEDGEBANDSHIFT_V: begin
                    rdata <=int_cmc_register_m_nEdgeBandShift_V;
                end
                ADDR_CMC_REGISTER_M_NCFCSTRENGTH_V: begin
                    rdata <=int_cmc_register_m_nCFCStrength_V;
                end
                ADDR_GTM_REGISTER_EB: begin
                    rdata <=int_gtm_register_eb;
                end
                ADDR_GTM_REGISTER_M_BDITHERINGENABLE: begin
                    rdata <=int_gtm_register_m_bDitheringEnable;
                end
                ADDR_GTM_REGISTER_GTMTAB_V_0: begin
                    rdata <=int_gtm_register_int_gtmTab_V_0;
                end
                ADDR_GTM_REGISTER_GTMTAB_V_1: begin
                    rdata <=int_gtm_register_int_gtmTab_V_1;
                end
                ADDR_GTM_REGISTER_GTMTAB_V_2: begin
                    rdata <=int_gtm_register_int_gtmTab_V_2;
                end
                ADDR_GTM_REGISTER_GTMTAB_V_3: begin
                    rdata <=int_gtm_register_int_gtmTab_V_3;
                end
                ADDR_GTM_REGISTER_GTMTAB_V_4: begin
                    rdata <=int_gtm_register_int_gtmTab_V_4;
                end
                ADDR_GTM_REGISTER_GTMTAB_V_5: begin
                    rdata <=int_gtm_register_int_gtmTab_V_5;
                end
                ADDR_GTM_REGISTER_GTMTAB_V_6: begin
                    rdata <=int_gtm_register_int_gtmTab_V_6;
                end
                ADDR_GTM_REGISTER_GTMTAB_V_7: begin
                    rdata <=int_gtm_register_int_gtmTab_V_7;
                end
                ADDR_GTM_REGISTER_GTMTAB_V_8: begin
                    rdata <=int_gtm_register_int_gtmTab_V_8;
                end
                ADDR_GTM_REGISTER_GTMTAB_V_9: begin
                    rdata <=int_gtm_register_int_gtmTab_V_9;
                end
                ADDR_GTM_REGISTER_GTMTAB_V_10: begin
                    rdata <=int_gtm_register_int_gtmTab_V_10;
                end
                ADDR_GTM_REGISTER_GTMTAB_V_11: begin
                    rdata <=int_gtm_register_int_gtmTab_V_11;
                end
                ADDR_GTM_REGISTER_GTMTAB_V_12: begin
                    rdata <=int_gtm_register_int_gtmTab_V_12;
                end
                ADDR_GTM_REGISTER_GTMTAB_V_13: begin
                    rdata <=int_gtm_register_int_gtmTab_V_13;
                end
                ADDR_GTM_REGISTER_GTMTAB_V_14: begin
                    rdata <=int_gtm_register_int_gtmTab_V_14;
                end
                ADDR_GTM_REGISTER_GTMTAB_V_15: begin
                    rdata <=int_gtm_register_int_gtmTab_V_15;
                end
                ADDR_GTM_REGISTER_GTMTAB_V_16: begin
                    rdata <=int_gtm_register_int_gtmTab_V_16;
                end
                ADDR_GTM_REGISTER_GTMTAB_V_17: begin
                    rdata <=int_gtm_register_int_gtmTab_V_17;
                end
                ADDR_GTM_REGISTER_GTMTAB_V_18: begin
                    rdata <=int_gtm_register_int_gtmTab_V_18;
                end
                ADDR_GTM_REGISTER_GTMTAB_V_19: begin
                    rdata <=int_gtm_register_int_gtmTab_V_19;
                end
                ADDR_GTM_REGISTER_GTMTAB_V_20: begin
                    rdata <=int_gtm_register_int_gtmTab_V_20;
                end
                ADDR_GTM_REGISTER_GTMTAB_V_21: begin
                    rdata <=int_gtm_register_int_gtmTab_V_21;
                end
                ADDR_GTM_REGISTER_GTMTAB_V_22: begin
                    rdata <=int_gtm_register_int_gtmTab_V_22;
                end
                ADDR_GTM_REGISTER_GTMTAB_V_23: begin
                    rdata <=int_gtm_register_int_gtmTab_V_23;
                end
                ADDR_GTM_REGISTER_GTMTAB_V_24: begin
                    rdata <=int_gtm_register_int_gtmTab_V_24;
                end
                ADDR_GTM_REGISTER_GTMTAB_V_25: begin
                    rdata <=int_gtm_register_int_gtmTab_V_25;
                end
                ADDR_GTM_REGISTER_GTMTAB_V_26: begin
                    rdata <=int_gtm_register_int_gtmTab_V_26;
                end
                ADDR_GTM_REGISTER_GTMTAB_V_27: begin
                    rdata <=int_gtm_register_int_gtmTab_V_27;
                end
                ADDR_GTM_REGISTER_GTMTAB_V_28: begin
                    rdata <=int_gtm_register_int_gtmTab_V_28;
                end
                ADDR_GTM_REGISTER_GTMTAB_V_29: begin
                    rdata <=int_gtm_register_int_gtmTab_V_29;
                end
                ADDR_GTM_REGISTER_GTMTAB_V_30: begin
                    rdata <=int_gtm_register_int_gtmTab_V_30;
                end
                ADDR_GTM_REGISTER_GTMTAB_V_31: begin
                    rdata <=int_gtm_register_int_gtmTab_V_31;
                end
                ADDR_GTM_REGISTER_GTMTAB_V_32: begin
                    rdata <=int_gtm_register_int_gtmTab_V_32;
                end
                ADDR_GTM_REGISTER_GTMTAB_V_33: begin
                    rdata <=int_gtm_register_int_gtmTab_V_33;
                end
                ADDR_GTM_REGISTER_GTMTAB_V_34: begin
                    rdata <=int_gtm_register_int_gtmTab_V_34;
                end
                ADDR_GTM_REGISTER_GTMTAB_V_35: begin
                    rdata <=int_gtm_register_int_gtmTab_V_35;
                end
                ADDR_GTM_REGISTER_GTMTAB_V_36: begin
                    rdata <=int_gtm_register_int_gtmTab_V_36;
                end
                ADDR_GTM_REGISTER_GTMTAB_V_37: begin
                    rdata <=int_gtm_register_int_gtmTab_V_37;
                end
                ADDR_GTM_REGISTER_GTMTAB_V_38: begin
                    rdata <=int_gtm_register_int_gtmTab_V_38;
                end
                ADDR_GTM_REGISTER_GTMTAB_V_39: begin
                    rdata <=int_gtm_register_int_gtmTab_V_39;
                end
                ADDR_GTM_REGISTER_GTMTAB_V_40: begin
                    rdata <=int_gtm_register_int_gtmTab_V_40;
                end
                ADDR_GTM_REGISTER_GTMTAB_V_41: begin
                    rdata <=int_gtm_register_int_gtmTab_V_41;
                end
                ADDR_GTM_REGISTER_GTMTAB_V_42: begin
                    rdata <=int_gtm_register_int_gtmTab_V_42;
                end
                ADDR_GTM_REGISTER_GTMTAB_V_43: begin
                    rdata <=int_gtm_register_int_gtmTab_V_43;
                end
                ADDR_GTM_REGISTER_GTMTAB_V_44: begin
                    rdata <=int_gtm_register_int_gtmTab_V_44;
                end
                ADDR_GTM_REGISTER_GTMTAB_V_45: begin
                    rdata <=int_gtm_register_int_gtmTab_V_45;
                end
                ADDR_GTM_REGISTER_GTMTAB_V_46: begin
                    rdata <=int_gtm_register_int_gtmTab_V_46;
                end
                ADDR_GTM_REGISTER_GTMTAB_V_47: begin
                    rdata <=int_gtm_register_int_gtmTab_V_47;
                end
                ADDR_GTM_REGISTER_GTMTAB_V_48: begin
                    rdata <=int_gtm_register_int_gtmTab_V_48;
                end
                ADDR_GTM_REGISTER_GTMTAB_V_49: begin
                    rdata <=int_gtm_register_int_gtmTab_V_49;
                end
                ADDR_GTM_REGISTER_GTMTAB_V_50: begin
                    rdata <=int_gtm_register_int_gtmTab_V_50;
                end
                ADDR_GTM_REGISTER_GTMTAB_V_51: begin
                    rdata <=int_gtm_register_int_gtmTab_V_51;
                end
                ADDR_GTM_REGISTER_GTMTAB_V_52: begin
                    rdata <=int_gtm_register_int_gtmTab_V_52;
                end
                ADDR_GTM_REGISTER_GTMTAB_V_53: begin
                    rdata <=int_gtm_register_int_gtmTab_V_53;
                end
                ADDR_GTM_REGISTER_GTMTAB_V_54: begin
                    rdata <=int_gtm_register_int_gtmTab_V_54;
                end
                ADDR_GTM_REGISTER_GTMTAB_V_55: begin
                    rdata <=int_gtm_register_int_gtmTab_V_55;
                end
                ADDR_GTM_REGISTER_GTMTAB_V_56: begin
                    rdata <=int_gtm_register_int_gtmTab_V_56;
                end
                ADDR_GTM_REGISTER_GTMTAB_V_57: begin
                    rdata <=int_gtm_register_int_gtmTab_V_57;
                end
                ADDR_GTM_REGISTER_GTMTAB_V_58: begin
                    rdata <=int_gtm_register_int_gtmTab_V_58;
                end
                ADDR_GTM_REGISTER_GTMTAB_V_59: begin
                    rdata <=int_gtm_register_int_gtmTab_V_59;
                end
                ADDR_GTM_REGISTER_GTMTAB_V_60: begin
                    rdata <=int_gtm_register_int_gtmTab_V_60;
                end
                ADDR_GTM_REGISTER_GTMTAB_V_61: begin
                    rdata <=int_gtm_register_int_gtmTab_V_61;
                end
                ADDR_GTM_REGISTER_GTMTAB_V_62: begin
                    rdata <=int_gtm_register_int_gtmTab_V_62;
                end
                ADDR_GTM_REGISTER_GTMTAB_V_63: begin
                    rdata <=int_gtm_register_int_gtmTab_V_63;
                end
                ADDR_GTM_REGISTER_GTMTAB_V_64: begin
                    rdata <=int_gtm_register_int_gtmTab_V_64;
                end
                ADDR_GTM_REGISTER_GTMTAB_V_65: begin
                    rdata <=int_gtm_register_int_gtmTab_V_65;
                end
                ADDR_GTM_REGISTER_GTMTAB_V_66: begin
                    rdata <=int_gtm_register_int_gtmTab_V_66;
                end
                ADDR_GTM_REGISTER_GTMTAB_V_67: begin
                    rdata <=int_gtm_register_int_gtmTab_V_67;
                end
                ADDR_GTM_REGISTER_GTMTAB_V_68: begin
                    rdata <=int_gtm_register_int_gtmTab_V_68;
                end
                ADDR_GTM_REGISTER_GTMTAB_V_69: begin
                    rdata <=int_gtm_register_int_gtmTab_V_69;
                end
                ADDR_GTM_REGISTER_GTMTAB_V_70: begin
                    rdata <=int_gtm_register_int_gtmTab_V_70;
                end
                ADDR_GTM_REGISTER_GTMTAB_V_71: begin
                    rdata <=int_gtm_register_int_gtmTab_V_71;
                end
                ADDR_GTM_REGISTER_GTMTAB_V_72: begin
                    rdata <=int_gtm_register_int_gtmTab_V_72;
                end
                ADDR_GTM_REGISTER_GTMTAB_V_73: begin
                    rdata <=int_gtm_register_int_gtmTab_V_73;
                end
                ADDR_GTM_REGISTER_GTMTAB_V_74: begin
                    rdata <=int_gtm_register_int_gtmTab_V_74;
                end
                ADDR_GTM_REGISTER_GTMTAB_V_75: begin
                    rdata <=int_gtm_register_int_gtmTab_V_75;
                end
                ADDR_GTM_REGISTER_GTMTAB_V_76: begin
                    rdata <=int_gtm_register_int_gtmTab_V_76;
                end
                ADDR_GTM_REGISTER_GTMTAB_V_77: begin
                    rdata <=int_gtm_register_int_gtmTab_V_77;
                end
                ADDR_GTM_REGISTER_GTMTAB_V_78: begin
                    rdata <=int_gtm_register_int_gtmTab_V_78;
                end
                ADDR_GTM_REGISTER_GTMTAB_V_79: begin
                    rdata <=int_gtm_register_int_gtmTab_V_79;
                end
                ADDR_GTM_REGISTER_GTMTAB_V_80: begin
                    rdata <=int_gtm_register_int_gtmTab_V_80;
                end
                ADDR_GTM_REGISTER_GTMTAB_V_81: begin
                    rdata <=int_gtm_register_int_gtmTab_V_81;
                end
                ADDR_GTM_REGISTER_GTMTAB_V_82: begin
                    rdata <=int_gtm_register_int_gtmTab_V_82;
                end
                ADDR_GTM_REGISTER_GTMTAB_V_83: begin
                    rdata <=int_gtm_register_int_gtmTab_V_83;
                end
                ADDR_GTM_REGISTER_GTMTAB_V_84: begin
                    rdata <=int_gtm_register_int_gtmTab_V_84;
                end
                ADDR_GTM_REGISTER_GTMTAB_V_85: begin
                    rdata <=int_gtm_register_int_gtmTab_V_85;
                end
                ADDR_GTM_REGISTER_GTMTAB_V_86: begin
                    rdata <=int_gtm_register_int_gtmTab_V_86;
                end
                ADDR_GTM_REGISTER_GTMTAB_V_87: begin
                    rdata <=int_gtm_register_int_gtmTab_V_87;
                end
                ADDR_GTM_REGISTER_GTMTAB_V_88: begin
                    rdata <=int_gtm_register_int_gtmTab_V_88;
                end
                ADDR_GTM_REGISTER_GTMTAB_V_89: begin
                    rdata <=int_gtm_register_int_gtmTab_V_89;
                end
                ADDR_GTM_REGISTER_GTMTAB_V_90: begin
                    rdata <=int_gtm_register_int_gtmTab_V_90;
                end
                ADDR_GTM_REGISTER_GTMTAB_V_91: begin
                    rdata <=int_gtm_register_int_gtmTab_V_91;
                end
                ADDR_GTM_REGISTER_GTMTAB_V_92: begin
                    rdata <=int_gtm_register_int_gtmTab_V_92;
                end
                ADDR_GTM_REGISTER_GTMTAB_V_93: begin
                    rdata <=int_gtm_register_int_gtmTab_V_93;
                end
                ADDR_GTM_REGISTER_GTMTAB_V_94: begin
                    rdata <=int_gtm_register_int_gtmTab_V_94;
                end
                ADDR_GTM_REGISTER_GTMTAB_V_95: begin
                    rdata <=int_gtm_register_int_gtmTab_V_95;
                end
                ADDR_GTM_REGISTER_GTMTAB_V_96: begin
                    rdata <=int_gtm_register_int_gtmTab_V_96;
                end
                ADDR_GTM_REGISTER_GTMTAB_V_97: begin
                    rdata <=int_gtm_register_int_gtmTab_V_97;
                end
                ADDR_GTM_REGISTER_GTMTAB_V_98: begin
                    rdata <=int_gtm_register_int_gtmTab_V_98;
                end
                ADDR_GTM_REGISTER_GTMTAB_V_99: begin
                    rdata <=int_gtm_register_int_gtmTab_V_99;
                end
                ADDR_GTM_REGISTER_GTMTAB_V_100: begin
                    rdata <=int_gtm_register_int_gtmTab_V_100;
                end
                ADDR_GTM_REGISTER_GTMTAB_V_101: begin
                    rdata <=int_gtm_register_int_gtmTab_V_101;
                end
                ADDR_GTM_REGISTER_GTMTAB_V_102: begin
                    rdata <=int_gtm_register_int_gtmTab_V_102;
                end
                ADDR_GTM_REGISTER_GTMTAB_V_103: begin
                    rdata <=int_gtm_register_int_gtmTab_V_103;
                end
                ADDR_GTM_REGISTER_GTMTAB_V_104: begin
                    rdata <=int_gtm_register_int_gtmTab_V_104;
                end
                ADDR_GTM_REGISTER_GTMTAB_V_105: begin
                    rdata <=int_gtm_register_int_gtmTab_V_105;
                end
                ADDR_GTM_REGISTER_GTMTAB_V_106: begin
                    rdata <=int_gtm_register_int_gtmTab_V_106;
                end
                ADDR_GTM_REGISTER_GTMTAB_V_107: begin
                    rdata <=int_gtm_register_int_gtmTab_V_107;
                end
                ADDR_GTM_REGISTER_GTMTAB_V_108: begin
                    rdata <=int_gtm_register_int_gtmTab_V_108;
                end
                ADDR_GTM_REGISTER_GTMTAB_V_109: begin
                    rdata <=int_gtm_register_int_gtmTab_V_109;
                end
                ADDR_GTM_REGISTER_GTMTAB_V_110: begin
                    rdata <=int_gtm_register_int_gtmTab_V_110;
                end
                ADDR_GTM_REGISTER_GTMTAB_V_111: begin
                    rdata <=int_gtm_register_int_gtmTab_V_111;
                end
                ADDR_GTM_REGISTER_GTMTAB_V_112: begin
                    rdata <=int_gtm_register_int_gtmTab_V_112;
                end
                ADDR_GTM_REGISTER_GTMTAB_V_113: begin
                    rdata <=int_gtm_register_int_gtmTab_V_113;
                end
                ADDR_GTM_REGISTER_GTMTAB_V_114: begin
                    rdata <=int_gtm_register_int_gtmTab_V_114;
                end
                ADDR_GTM_REGISTER_GTMTAB_V_115: begin
                    rdata <=int_gtm_register_int_gtmTab_V_115;
                end
                ADDR_GTM_REGISTER_GTMTAB_V_116: begin
                    rdata <=int_gtm_register_int_gtmTab_V_116;
                end
                ADDR_GTM_REGISTER_GTMTAB_V_117: begin
                    rdata <=int_gtm_register_int_gtmTab_V_117;
                end
                ADDR_GTM_REGISTER_GTMTAB_V_118: begin
                    rdata <=int_gtm_register_int_gtmTab_V_118;
                end
                ADDR_GTM_REGISTER_GTMTAB_V_119: begin
                    rdata <=int_gtm_register_int_gtmTab_V_119;
                end
                ADDR_GTM_REGISTER_GTMTAB_V_120: begin
                    rdata <=int_gtm_register_int_gtmTab_V_120;
                end
                ADDR_GTM_REGISTER_GTMTAB_V_121: begin
                    rdata <=int_gtm_register_int_gtmTab_V_121;
                end
                ADDR_GTM_REGISTER_GTMTAB_V_122: begin
                    rdata <=int_gtm_register_int_gtmTab_V_122;
                end
                ADDR_GTM_REGISTER_GTMTAB_V_123: begin
                    rdata <=int_gtm_register_int_gtmTab_V_123;
                end
                ADDR_GTM_REGISTER_GTMTAB_V_124: begin
                    rdata <=int_gtm_register_int_gtmTab_V_124;
                end
                ADDR_GTM_REGISTER_GTMTAB_V_125: begin
                    rdata <=int_gtm_register_int_gtmTab_V_125;
                end
                ADDR_GTM_REGISTER_GTMTAB_V_126: begin
                    rdata <=int_gtm_register_int_gtmTab_V_126;
                end
                ADDR_GTM_REGISTER_GTMTAB_V_127: begin
                    rdata <=int_gtm_register_int_gtmTab_V_127;
                end
                ADDR_GTM_REGISTER_GTMTAB_V_128: begin
                    rdata <=int_gtm_register_int_gtmTab_V_128;
                end
                ADDR_LTM_REGISTER_M_NEB_V: begin
                    rdata <=int_ltm_register_m_nEb_V;
                end
                ADDR_LTM_REGISTER_CONTRAST_V: begin
                    rdata <=int_ltm_register_contrast_V;
                end
                ADDR_LTM_REGISTER_RATIO_V: begin
                    rdata <=int_ltm_register_ratio_V;
                end
                ADDR_CAC_REGISTER_EB: begin
                    rdata <=int_cac_register_eb;
                end
                ADDR_CAC_REGISTER_T_TRANSIENT_V: begin
                    rdata <=int_cac_register_t_transient_V;
                end
                ADDR_CAC_REGISTER_T_EDGE_V: begin
                    rdata <=int_cac_register_t_edge_V;
                end
                ADDR_CSC_REGISTER_M_NEB: begin
                    rdata <=int_csc_register_m_nEb;
                end
                ADDR_CSC_REGISTER_COEFF_V_0: begin
                    rdata <=int_csc_register_coeff_V_0;
                end
                ADDR_CSC_REGISTER_COEFF_V_1: begin
                    rdata <=int_csc_register_coeff_V_1;
                end
                ADDR_CSC_REGISTER_COEFF_V_2: begin
                    rdata <=int_csc_register_coeff_V_2;
                end
                ADDR_CSC_REGISTER_COEFF_V_3: begin
                    rdata <=int_csc_register_coeff_V_3;
                end
                ADDR_CSC_REGISTER_COEFF_V_4: begin
                    rdata <=int_csc_register_coeff_V_4;
                end
                ADDR_CSC_REGISTER_COEFF_V_5: begin
                    rdata <=int_csc_register_coeff_V_5;
                end
                ADDR_CSC_REGISTER_COEFF_V_6: begin
                    rdata <=int_csc_register_coeff_V_6;
                end
                ADDR_CSC_REGISTER_COEFF_V_7: begin
                    rdata <=int_csc_register_coeff_V_7;
                end
                ADDR_CSC_REGISTER_COEFF_V_8: begin
                    rdata <=int_csc_register_coeff_V_8;
                end
                ADDR_CSC_REGISTER_COEFF_V_9: begin
                    rdata <=int_csc_register_coeff_V_9;
                end
                ADDR_CSC_REGISTER_COEFF_V_10: begin
                    rdata <=int_csc_register_coeff_V_10;
                end
                ADDR_CSC_REGISTER_COEFF_V_11: begin
                    rdata <=int_csc_register_coeff_V_11;
                end
                ADDR_YFC_REGISTER_M_NEB: begin
                    rdata <=int_yfc_register_m_nEb;
                end
                ADDR_YFC_REGISTER_YUVPATTERN: begin
                    rdata <=int_yfc_register_yuvpattern;
                end
                ADDR_YUVDNS_REGISTER_EB_V: begin
                    rdata <=int_yuvdns_register_eb_V;
                end
                ADDR_YUVDNS_REGISTER_YSIGMA2_V: begin
                    rdata <=int_yuvdns_register_ysigma2_V;
                end
                ADDR_YUVDNS_REGISTER_YINVSIGMA2_V: begin
                    rdata <=int_yuvdns_register_yinvsigma2_V;
                end
                ADDR_YUVDNS_REGISTER_UVSIGMA2_V: begin
                    rdata <=int_yuvdns_register_uvsigma2_V;
                end
                ADDR_YUVDNS_REGISTER_UVINVSIGMA2_V: begin
                    rdata <=int_yuvdns_register_uvinvsigma2_V;
                end
                ADDR_YUVDNS_REGISTER_YFILT_V: begin
                    rdata <=int_yuvdns_register_yfilt_V;
                end
                ADDR_YUVDNS_REGISTER_UVFILT_V: begin
                    rdata <=int_yuvdns_register_uvfilt_V;
                end
                ADDR_YUVDNS_REGISTER_YINVFILT_V: begin
                    rdata <=int_yuvdns_register_yinvfilt_V;
                end
                ADDR_YUVDNS_REGISTER_UVINVFILT_V: begin
                    rdata <=int_yuvdns_register_uvinvfilt_V;
                end
                ADDR_YUVDNS_REGISTER_YH2_V: begin
                    rdata <=int_yuvdns_register_yH2_V;
                end
                ADDR_YUVDNS_REGISTER_YINVH2_V: begin
                    rdata <=int_yuvdns_register_yinvH2_V;
                end
                ADDR_YUVDNS_REGISTER_UVH2_V: begin
                    rdata <=int_yuvdns_register_uvH2_V;
                end
                ADDR_YUVDNS_REGISTER_UVINVH2_V: begin
                    rdata <=int_yuvdns_register_uvinvH2_V;
                end
                ADDR_SCALEDOWN_REGISTER_M_NEB: begin
                    rdata <=int_scaledown_register_m_nEb;
                end
                ADDR_SCALEDOWN_REGISTER_YUVPATTERN_V: begin
                    rdata <=int_scaledown_register_yuvpattern_V;
                end
                ADDR_SCALEDOWN_REGISTER_TIMES_V: begin
                    rdata <=int_scaledown_register_times_V;
                end
                ADDR_CROP_REGISTER_M_NEB: begin
                    rdata <=int_crop_register_m_nEb;
                end
                ADDR_CROP_REGISTER_UPPER_LEFT_X_V: begin
                    rdata <=int_crop_register_upper_left_x_V;
                end
                ADDR_CROP_REGISTER_UPPER_LEFT_Y_V: begin
                    rdata <=int_crop_register_upper_left_y_V;
                end
                ADDR_CROP_REGISTER_LOWER_RIGHT_X_V: begin
                    rdata <=int_crop_register_lower_right_x_V;
                end
                ADDR_CROP_REGISTER_LOWER_RIGHT_Y_V: begin
                    rdata <=int_crop_register_lower_right_y_V;
                end
                ADDR_CROP_REGISTER_YUVPATTERN_V: begin
                    rdata <=int_crop_register_yuvpattern_V;
                end
                ADDR_ISP_READ_RAW_ADDR: begin
                    rdata <=int_isp_read_raw_addr;
                end
                ADDR_ISP_WRITE_Y_ADDR: begin
                    rdata <=int_isp_write_y_addr;
                end
                ADDR_ISP_WRITE_U_ADDR: begin
                    rdata <=int_isp_write_u_addr;
                end
                ADDR_ISP_WRITE_V_ADDR: begin
                    rdata <=int_isp_write_v_addr;
                end

                ADDR_BURST_ONE_FRAME_TOTAL: begin
                    rdata<=int_burst_one_frame_total;
                end


            endcase
        end
        else begin
            rdata<=rdata;
        end

    end
end


//------------------------Register logic-----------------
assign read_start   = int_read_start;
// int_read_start
always @(posedge ACLK) begin
    if (ARESET)
        int_read_start <= 1'b0;
    else if (ACLK_EN) begin
        if (w_hs && waddr == ADDR_START)
            int_read_start <= WDATA;
    end
end

//-------------------------------------------------------------
// int_top_register_frameWidth_V[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_top_register_frameWidth_V<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_TOP_REGISTER_FRAMEWIDTH_V)
            int_top_register_frameWidth_V<=WDATA;
    end
end

// int_top_register_frameHeight_V[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_top_register_frameHeight_V<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_TOP_REGISTER_FRAMEHEIGHT_V)
            int_top_register_frameHeight_V<=WDATA;
    end
end

// int_top_register_inputFormat[0:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_top_register_inputFormat<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_TOP_REGISTER_INPUTFORMAT)
            int_top_register_inputFormat<=WDATA;
    end
end

// int_top_register_imgPattern_V[1:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_top_register_imgPattern_V<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_TOP_REGISTER_IMGPATTERN_V)
            int_top_register_imgPattern_V<=WDATA;
    end
end

// int_top_register_pipeMode_V[1:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_top_register_pipeMode_V<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_TOP_REGISTER_PIPEMODE_V)
            int_top_register_pipeMode_V<=WDATA;
    end
end

// int_top_register_blc_V[8:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_top_register_blc_V<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_TOP_REGISTER_BLC_V)
            int_top_register_blc_V<=WDATA;
    end
end

// int_top_register_shadowEb[0:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_top_register_shadowEb<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_TOP_REGISTER_SHADOWEB)
            int_top_register_shadowEb<=WDATA;
    end
end

// int_top_register_binningFrameWidth_V[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_top_register_binningFrameWidth_V<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_TOP_REGISTER_BINNINGFRAMEWIDTH_V)
            int_top_register_binningFrameWidth_V<=WDATA;
    end
end

// int_top_register_binningFrameHeight_V[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_top_register_binningFrameHeight_V<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_TOP_REGISTER_BINNINGFRAMEHEIGHT_V)
            int_top_register_binningFrameHeight_V<=WDATA;
    end
end

// int_top_register_scalerFrameWidth_V[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_top_register_scalerFrameWidth_V<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_TOP_REGISTER_SCALERFRAMEWIDTH_V)
            int_top_register_scalerFrameWidth_V<=WDATA;
    end
end

// int_top_register_scalerFrameHeight_V[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_top_register_scalerFrameHeight_V<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_TOP_REGISTER_SCALERFRAMEHEIGHT_V)
            int_top_register_scalerFrameHeight_V<=WDATA;
    end
end

// int_tpg_register_m_bTPG_en[0:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_tpg_register_m_bTPG_en<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_TPG_REGISTER_M_BTPG_EN)
            int_tpg_register_m_bTPG_en<=WDATA;
    end
end

// int_tpg_register_m_nWidth_V[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_tpg_register_m_nWidth_V<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_TPG_REGISTER_M_NWIDTH_V)
            int_tpg_register_m_nWidth_V<=WDATA;
    end
end

// int_tpg_register_m_nHeight_V[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_tpg_register_m_nHeight_V<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_TPG_REGISTER_M_NHEIGHT_V)
            int_tpg_register_m_nHeight_V<=WDATA;
    end
end

// int_tpg_register_m_nCFAPattern_V[1:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_tpg_register_m_nCFAPattern_V<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_TPG_REGISTER_M_NCFAPATTERN_V)
            int_tpg_register_m_nCFAPattern_V<=WDATA;
    end
end

// int_tpg_register_m_bRollingEnable[0:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_tpg_register_m_bRollingEnable<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_TPG_REGISTER_M_BROLLINGENABLE)
            int_tpg_register_m_bRollingEnable<=WDATA;
    end
end

// int_tpg_register_m_bSensor_timing_en[0:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_tpg_register_m_bSensor_timing_en<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_TPG_REGISTER_M_BSENSOR_TIMING_EN)
            int_tpg_register_m_bSensor_timing_en<=WDATA;
    end
end

// int_tpg_register_m_nVBlank_num_V[11:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_tpg_register_m_nVBlank_num_V<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_TPG_REGISTER_M_NVBLANK_NUM_V)
            int_tpg_register_m_nVBlank_num_V<=WDATA;
    end
end

// int_tpg_register_m_nHBlank_num_V[11:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_tpg_register_m_nHBlank_num_V<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_TPG_REGISTER_M_NHBLANK_NUM_V)
            int_tpg_register_m_nHBlank_num_V<=WDATA;
    end
end

// int_tpg_register_m_valid_blank_V[7:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_tpg_register_m_valid_blank_V<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_TPG_REGISTER_M_VALID_BLANK_V)
            int_tpg_register_m_valid_blank_V<=WDATA;
    end
end

// int_tpg_register_m_nID_V[2:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_tpg_register_m_nID_V<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_TPG_REGISTER_M_NID_V)
            int_tpg_register_m_nID_V<=WDATA;
    end
end

// int_dgain_register_m_nEb[0:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_dgain_register_m_nEb<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_DGAIN_REGISTER_M_NEB)
            int_dgain_register_m_nEb<=WDATA;
    end
end

// int_dgain_register_m_nBlcR_V[8:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_dgain_register_m_nBlcR_V<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_DGAIN_REGISTER_M_NBLCR_V)
            int_dgain_register_m_nBlcR_V<=WDATA;
    end
end

// int_dgain_register_m_nBlcGr_V[8:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_dgain_register_m_nBlcGr_V<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_DGAIN_REGISTER_M_NBLCGR_V)
            int_dgain_register_m_nBlcGr_V<=WDATA;
    end
end

// int_dgain_register_m_nBlcGb_V[8:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_dgain_register_m_nBlcGb_V<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_DGAIN_REGISTER_M_NBLCGB_V)
            int_dgain_register_m_nBlcGb_V<=WDATA;
    end
end

// int_dgain_register_m_nBlcB_V[8:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_dgain_register_m_nBlcB_V<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_DGAIN_REGISTER_M_NBLCB_V)
            int_dgain_register_m_nBlcB_V<=WDATA;
    end
end

// int_dgain_register_m_nR_V[19:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_dgain_register_m_nR_V<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_DGAIN_REGISTER_M_NR_V)
            int_dgain_register_m_nR_V<=WDATA;
    end
end

// int_dgain_register_m_nGr_V[19:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_dgain_register_m_nGr_V<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_DGAIN_REGISTER_M_NGR_V)
            int_dgain_register_m_nGr_V<=WDATA;
    end
end

// int_dgain_register_m_nGb_V[19:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_dgain_register_m_nGb_V<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_DGAIN_REGISTER_M_NGB_V)
            int_dgain_register_m_nGb_V<=WDATA;
    end
end

// int_dgain_register_m_nB_V[19:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_dgain_register_m_nB_V<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_DGAIN_REGISTER_M_NB_V)
            int_dgain_register_m_nB_V<=WDATA;
    end
end

// int_lsc_register_eb[0:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_eb<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_EB)
            int_lsc_register_eb<=WDATA;
    end
end

// int_lsc_register_rGain_V_0[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_rGain_V_0<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_RGAIN_V_0)
            int_lsc_register_rGain_V_0<=WDATA;
    end
end

// int_lsc_register_rGain_V_1[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_rGain_V_1<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_RGAIN_V_1)
            int_lsc_register_rGain_V_1<=WDATA;
    end
end

// int_lsc_register_rGain_V_2[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_rGain_V_2<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_RGAIN_V_2)
            int_lsc_register_rGain_V_2<=WDATA;
    end
end

// int_lsc_register_rGain_V_3[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_rGain_V_3<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_RGAIN_V_3)
            int_lsc_register_rGain_V_3<=WDATA;
    end
end

// int_lsc_register_rGain_V_4[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_rGain_V_4<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_RGAIN_V_4)
            int_lsc_register_rGain_V_4<=WDATA;
    end
end

// int_lsc_register_rGain_V_5[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_rGain_V_5<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_RGAIN_V_5)
            int_lsc_register_rGain_V_5<=WDATA;
    end
end

// int_lsc_register_rGain_V_6[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_rGain_V_6<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_RGAIN_V_6)
            int_lsc_register_rGain_V_6<=WDATA;
    end
end

// int_lsc_register_rGain_V_7[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_rGain_V_7<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_RGAIN_V_7)
            int_lsc_register_rGain_V_7<=WDATA;
    end
end

// int_lsc_register_rGain_V_8[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_rGain_V_8<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_RGAIN_V_8)
            int_lsc_register_rGain_V_8<=WDATA;
    end
end

// int_lsc_register_rGain_V_9[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_rGain_V_9<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_RGAIN_V_9)
            int_lsc_register_rGain_V_9<=WDATA;
    end
end

// int_lsc_register_rGain_V_10[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_rGain_V_10<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_RGAIN_V_10)
            int_lsc_register_rGain_V_10<=WDATA;
    end
end

// int_lsc_register_rGain_V_11[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_rGain_V_11<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_RGAIN_V_11)
            int_lsc_register_rGain_V_11<=WDATA;
    end
end

// int_lsc_register_rGain_V_12[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_rGain_V_12<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_RGAIN_V_12)
            int_lsc_register_rGain_V_12<=WDATA;
    end
end

// int_lsc_register_rGain_V_13[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_rGain_V_13<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_RGAIN_V_13)
            int_lsc_register_rGain_V_13<=WDATA;
    end
end

// int_lsc_register_rGain_V_14[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_rGain_V_14<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_RGAIN_V_14)
            int_lsc_register_rGain_V_14<=WDATA;
    end
end

// int_lsc_register_rGain_V_15[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_rGain_V_15<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_RGAIN_V_15)
            int_lsc_register_rGain_V_15<=WDATA;
    end
end

// int_lsc_register_rGain_V_16[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_rGain_V_16<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_RGAIN_V_16)
            int_lsc_register_rGain_V_16<=WDATA;
    end
end

// int_lsc_register_rGain_V_17[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_rGain_V_17<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_RGAIN_V_17)
            int_lsc_register_rGain_V_17<=WDATA;
    end
end

// int_lsc_register_rGain_V_18[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_rGain_V_18<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_RGAIN_V_18)
            int_lsc_register_rGain_V_18<=WDATA;
    end
end

// int_lsc_register_rGain_V_19[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_rGain_V_19<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_RGAIN_V_19)
            int_lsc_register_rGain_V_19<=WDATA;
    end
end

// int_lsc_register_rGain_V_20[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_rGain_V_20<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_RGAIN_V_20)
            int_lsc_register_rGain_V_20<=WDATA;
    end
end

// int_lsc_register_rGain_V_21[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_rGain_V_21<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_RGAIN_V_21)
            int_lsc_register_rGain_V_21<=WDATA;
    end
end

// int_lsc_register_rGain_V_22[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_rGain_V_22<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_RGAIN_V_22)
            int_lsc_register_rGain_V_22<=WDATA;
    end
end

// int_lsc_register_rGain_V_23[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_rGain_V_23<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_RGAIN_V_23)
            int_lsc_register_rGain_V_23<=WDATA;
    end
end

// int_lsc_register_rGain_V_24[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_rGain_V_24<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_RGAIN_V_24)
            int_lsc_register_rGain_V_24<=WDATA;
    end
end

// int_lsc_register_rGain_V_25[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_rGain_V_25<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_RGAIN_V_25)
            int_lsc_register_rGain_V_25<=WDATA;
    end
end

// int_lsc_register_rGain_V_26[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_rGain_V_26<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_RGAIN_V_26)
            int_lsc_register_rGain_V_26<=WDATA;
    end
end

// int_lsc_register_rGain_V_27[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_rGain_V_27<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_RGAIN_V_27)
            int_lsc_register_rGain_V_27<=WDATA;
    end
end

// int_lsc_register_rGain_V_28[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_rGain_V_28<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_RGAIN_V_28)
            int_lsc_register_rGain_V_28<=WDATA;
    end
end

// int_lsc_register_rGain_V_29[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_rGain_V_29<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_RGAIN_V_29)
            int_lsc_register_rGain_V_29<=WDATA;
    end
end

// int_lsc_register_rGain_V_30[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_rGain_V_30<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_RGAIN_V_30)
            int_lsc_register_rGain_V_30<=WDATA;
    end
end

// int_lsc_register_rGain_V_31[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_rGain_V_31<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_RGAIN_V_31)
            int_lsc_register_rGain_V_31<=WDATA;
    end
end

// int_lsc_register_rGain_V_32[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_rGain_V_32<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_RGAIN_V_32)
            int_lsc_register_rGain_V_32<=WDATA;
    end
end

// int_lsc_register_rGain_V_33[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_rGain_V_33<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_RGAIN_V_33)
            int_lsc_register_rGain_V_33<=WDATA;
    end
end

// int_lsc_register_rGain_V_34[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_rGain_V_34<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_RGAIN_V_34)
            int_lsc_register_rGain_V_34<=WDATA;
    end
end

// int_lsc_register_rGain_V_35[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_rGain_V_35<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_RGAIN_V_35)
            int_lsc_register_rGain_V_35<=WDATA;
    end
end

// int_lsc_register_rGain_V_36[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_rGain_V_36<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_RGAIN_V_36)
            int_lsc_register_rGain_V_36<=WDATA;
    end
end

// int_lsc_register_rGain_V_37[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_rGain_V_37<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_RGAIN_V_37)
            int_lsc_register_rGain_V_37<=WDATA;
    end
end

// int_lsc_register_rGain_V_38[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_rGain_V_38<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_RGAIN_V_38)
            int_lsc_register_rGain_V_38<=WDATA;
    end
end

// int_lsc_register_rGain_V_39[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_rGain_V_39<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_RGAIN_V_39)
            int_lsc_register_rGain_V_39<=WDATA;
    end
end

// int_lsc_register_rGain_V_40[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_rGain_V_40<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_RGAIN_V_40)
            int_lsc_register_rGain_V_40<=WDATA;
    end
end

// int_lsc_register_rGain_V_41[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_rGain_V_41<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_RGAIN_V_41)
            int_lsc_register_rGain_V_41<=WDATA;
    end
end

// int_lsc_register_rGain_V_42[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_rGain_V_42<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_RGAIN_V_42)
            int_lsc_register_rGain_V_42<=WDATA;
    end
end

// int_lsc_register_rGain_V_43[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_rGain_V_43<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_RGAIN_V_43)
            int_lsc_register_rGain_V_43<=WDATA;
    end
end

// int_lsc_register_rGain_V_44[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_rGain_V_44<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_RGAIN_V_44)
            int_lsc_register_rGain_V_44<=WDATA;
    end
end

// int_lsc_register_rGain_V_45[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_rGain_V_45<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_RGAIN_V_45)
            int_lsc_register_rGain_V_45<=WDATA;
    end
end

// int_lsc_register_rGain_V_46[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_rGain_V_46<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_RGAIN_V_46)
            int_lsc_register_rGain_V_46<=WDATA;
    end
end

// int_lsc_register_rGain_V_47[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_rGain_V_47<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_RGAIN_V_47)
            int_lsc_register_rGain_V_47<=WDATA;
    end
end

// int_lsc_register_rGain_V_48[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_rGain_V_48<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_RGAIN_V_48)
            int_lsc_register_rGain_V_48<=WDATA;
    end
end

// int_lsc_register_rGain_V_49[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_rGain_V_49<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_RGAIN_V_49)
            int_lsc_register_rGain_V_49<=WDATA;
    end
end

// int_lsc_register_rGain_V_50[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_rGain_V_50<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_RGAIN_V_50)
            int_lsc_register_rGain_V_50<=WDATA;
    end
end

// int_lsc_register_rGain_V_51[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_rGain_V_51<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_RGAIN_V_51)
            int_lsc_register_rGain_V_51<=WDATA;
    end
end

// int_lsc_register_rGain_V_52[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_rGain_V_52<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_RGAIN_V_52)
            int_lsc_register_rGain_V_52<=WDATA;
    end
end

// int_lsc_register_rGain_V_53[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_rGain_V_53<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_RGAIN_V_53)
            int_lsc_register_rGain_V_53<=WDATA;
    end
end

// int_lsc_register_rGain_V_54[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_rGain_V_54<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_RGAIN_V_54)
            int_lsc_register_rGain_V_54<=WDATA;
    end
end

// int_lsc_register_rGain_V_55[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_rGain_V_55<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_RGAIN_V_55)
            int_lsc_register_rGain_V_55<=WDATA;
    end
end

// int_lsc_register_rGain_V_56[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_rGain_V_56<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_RGAIN_V_56)
            int_lsc_register_rGain_V_56<=WDATA;
    end
end

// int_lsc_register_rGain_V_57[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_rGain_V_57<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_RGAIN_V_57)
            int_lsc_register_rGain_V_57<=WDATA;
    end
end

// int_lsc_register_rGain_V_58[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_rGain_V_58<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_RGAIN_V_58)
            int_lsc_register_rGain_V_58<=WDATA;
    end
end

// int_lsc_register_rGain_V_59[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_rGain_V_59<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_RGAIN_V_59)
            int_lsc_register_rGain_V_59<=WDATA;
    end
end

// int_lsc_register_rGain_V_60[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_rGain_V_60<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_RGAIN_V_60)
            int_lsc_register_rGain_V_60<=WDATA;
    end
end

// int_lsc_register_rGain_V_61[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_rGain_V_61<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_RGAIN_V_61)
            int_lsc_register_rGain_V_61<=WDATA;
    end
end

// int_lsc_register_rGain_V_62[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_rGain_V_62<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_RGAIN_V_62)
            int_lsc_register_rGain_V_62<=WDATA;
    end
end

// int_lsc_register_rGain_V_63[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_rGain_V_63<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_RGAIN_V_63)
            int_lsc_register_rGain_V_63<=WDATA;
    end
end

// int_lsc_register_rGain_V_64[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_rGain_V_64<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_RGAIN_V_64)
            int_lsc_register_rGain_V_64<=WDATA;
    end
end

// int_lsc_register_rGain_V_65[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_rGain_V_65<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_RGAIN_V_65)
            int_lsc_register_rGain_V_65<=WDATA;
    end
end

// int_lsc_register_rGain_V_66[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_rGain_V_66<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_RGAIN_V_66)
            int_lsc_register_rGain_V_66<=WDATA;
    end
end

// int_lsc_register_rGain_V_67[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_rGain_V_67<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_RGAIN_V_67)
            int_lsc_register_rGain_V_67<=WDATA;
    end
end

// int_lsc_register_rGain_V_68[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_rGain_V_68<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_RGAIN_V_68)
            int_lsc_register_rGain_V_68<=WDATA;
    end
end

// int_lsc_register_rGain_V_69[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_rGain_V_69<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_RGAIN_V_69)
            int_lsc_register_rGain_V_69<=WDATA;
    end
end

// int_lsc_register_rGain_V_70[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_rGain_V_70<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_RGAIN_V_70)
            int_lsc_register_rGain_V_70<=WDATA;
    end
end

// int_lsc_register_rGain_V_71[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_rGain_V_71<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_RGAIN_V_71)
            int_lsc_register_rGain_V_71<=WDATA;
    end
end

// int_lsc_register_rGain_V_72[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_rGain_V_72<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_RGAIN_V_72)
            int_lsc_register_rGain_V_72<=WDATA;
    end
end

// int_lsc_register_rGain_V_73[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_rGain_V_73<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_RGAIN_V_73)
            int_lsc_register_rGain_V_73<=WDATA;
    end
end

// int_lsc_register_rGain_V_74[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_rGain_V_74<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_RGAIN_V_74)
            int_lsc_register_rGain_V_74<=WDATA;
    end
end

// int_lsc_register_rGain_V_75[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_rGain_V_75<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_RGAIN_V_75)
            int_lsc_register_rGain_V_75<=WDATA;
    end
end

// int_lsc_register_rGain_V_76[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_rGain_V_76<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_RGAIN_V_76)
            int_lsc_register_rGain_V_76<=WDATA;
    end
end

// int_lsc_register_rGain_V_77[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_rGain_V_77<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_RGAIN_V_77)
            int_lsc_register_rGain_V_77<=WDATA;
    end
end

// int_lsc_register_rGain_V_78[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_rGain_V_78<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_RGAIN_V_78)
            int_lsc_register_rGain_V_78<=WDATA;
    end
end

// int_lsc_register_rGain_V_79[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_rGain_V_79<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_RGAIN_V_79)
            int_lsc_register_rGain_V_79<=WDATA;
    end
end

// int_lsc_register_rGain_V_80[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_rGain_V_80<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_RGAIN_V_80)
            int_lsc_register_rGain_V_80<=WDATA;
    end
end

// int_lsc_register_rGain_V_81[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_rGain_V_81<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_RGAIN_V_81)
            int_lsc_register_rGain_V_81<=WDATA;
    end
end

// int_lsc_register_rGain_V_82[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_rGain_V_82<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_RGAIN_V_82)
            int_lsc_register_rGain_V_82<=WDATA;
    end
end

// int_lsc_register_rGain_V_83[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_rGain_V_83<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_RGAIN_V_83)
            int_lsc_register_rGain_V_83<=WDATA;
    end
end

// int_lsc_register_rGain_V_84[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_rGain_V_84<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_RGAIN_V_84)
            int_lsc_register_rGain_V_84<=WDATA;
    end
end

// int_lsc_register_rGain_V_85[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_rGain_V_85<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_RGAIN_V_85)
            int_lsc_register_rGain_V_85<=WDATA;
    end
end

// int_lsc_register_rGain_V_86[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_rGain_V_86<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_RGAIN_V_86)
            int_lsc_register_rGain_V_86<=WDATA;
    end
end

// int_lsc_register_rGain_V_87[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_rGain_V_87<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_RGAIN_V_87)
            int_lsc_register_rGain_V_87<=WDATA;
    end
end

// int_lsc_register_rGain_V_88[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_rGain_V_88<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_RGAIN_V_88)
            int_lsc_register_rGain_V_88<=WDATA;
    end
end

// int_lsc_register_rGain_V_89[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_rGain_V_89<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_RGAIN_V_89)
            int_lsc_register_rGain_V_89<=WDATA;
    end
end

// int_lsc_register_rGain_V_90[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_rGain_V_90<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_RGAIN_V_90)
            int_lsc_register_rGain_V_90<=WDATA;
    end
end

// int_lsc_register_rGain_V_91[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_rGain_V_91<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_RGAIN_V_91)
            int_lsc_register_rGain_V_91<=WDATA;
    end
end

// int_lsc_register_rGain_V_92[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_rGain_V_92<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_RGAIN_V_92)
            int_lsc_register_rGain_V_92<=WDATA;
    end
end

// int_lsc_register_rGain_V_93[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_rGain_V_93<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_RGAIN_V_93)
            int_lsc_register_rGain_V_93<=WDATA;
    end
end

// int_lsc_register_rGain_V_94[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_rGain_V_94<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_RGAIN_V_94)
            int_lsc_register_rGain_V_94<=WDATA;
    end
end

// int_lsc_register_rGain_V_95[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_rGain_V_95<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_RGAIN_V_95)
            int_lsc_register_rGain_V_95<=WDATA;
    end
end

// int_lsc_register_rGain_V_96[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_rGain_V_96<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_RGAIN_V_96)
            int_lsc_register_rGain_V_96<=WDATA;
    end
end

// int_lsc_register_rGain_V_97[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_rGain_V_97<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_RGAIN_V_97)
            int_lsc_register_rGain_V_97<=WDATA;
    end
end

// int_lsc_register_rGain_V_98[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_rGain_V_98<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_RGAIN_V_98)
            int_lsc_register_rGain_V_98<=WDATA;
    end
end

// int_lsc_register_rGain_V_99[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_rGain_V_99<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_RGAIN_V_99)
            int_lsc_register_rGain_V_99<=WDATA;
    end
end

// int_lsc_register_rGain_V_100[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_rGain_V_100<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_RGAIN_V_100)
            int_lsc_register_rGain_V_100<=WDATA;
    end
end

// int_lsc_register_rGain_V_101[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_rGain_V_101<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_RGAIN_V_101)
            int_lsc_register_rGain_V_101<=WDATA;
    end
end

// int_lsc_register_rGain_V_102[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_rGain_V_102<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_RGAIN_V_102)
            int_lsc_register_rGain_V_102<=WDATA;
    end
end

// int_lsc_register_rGain_V_103[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_rGain_V_103<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_RGAIN_V_103)
            int_lsc_register_rGain_V_103<=WDATA;
    end
end

// int_lsc_register_rGain_V_104[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_rGain_V_104<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_RGAIN_V_104)
            int_lsc_register_rGain_V_104<=WDATA;
    end
end

// int_lsc_register_rGain_V_105[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_rGain_V_105<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_RGAIN_V_105)
            int_lsc_register_rGain_V_105<=WDATA;
    end
end

// int_lsc_register_rGain_V_106[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_rGain_V_106<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_RGAIN_V_106)
            int_lsc_register_rGain_V_106<=WDATA;
    end
end

// int_lsc_register_rGain_V_107[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_rGain_V_107<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_RGAIN_V_107)
            int_lsc_register_rGain_V_107<=WDATA;
    end
end

// int_lsc_register_rGain_V_108[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_rGain_V_108<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_RGAIN_V_108)
            int_lsc_register_rGain_V_108<=WDATA;
    end
end

// int_lsc_register_rGain_V_109[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_rGain_V_109<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_RGAIN_V_109)
            int_lsc_register_rGain_V_109<=WDATA;
    end
end

// int_lsc_register_rGain_V_110[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_rGain_V_110<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_RGAIN_V_110)
            int_lsc_register_rGain_V_110<=WDATA;
    end
end

// int_lsc_register_rGain_V_111[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_rGain_V_111<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_RGAIN_V_111)
            int_lsc_register_rGain_V_111<=WDATA;
    end
end

// int_lsc_register_rGain_V_112[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_rGain_V_112<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_RGAIN_V_112)
            int_lsc_register_rGain_V_112<=WDATA;
    end
end

// int_lsc_register_rGain_V_113[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_rGain_V_113<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_RGAIN_V_113)
            int_lsc_register_rGain_V_113<=WDATA;
    end
end

// int_lsc_register_rGain_V_114[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_rGain_V_114<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_RGAIN_V_114)
            int_lsc_register_rGain_V_114<=WDATA;
    end
end

// int_lsc_register_rGain_V_115[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_rGain_V_115<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_RGAIN_V_115)
            int_lsc_register_rGain_V_115<=WDATA;
    end
end

// int_lsc_register_rGain_V_116[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_rGain_V_116<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_RGAIN_V_116)
            int_lsc_register_rGain_V_116<=WDATA;
    end
end

// int_lsc_register_rGain_V_117[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_rGain_V_117<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_RGAIN_V_117)
            int_lsc_register_rGain_V_117<=WDATA;
    end
end

// int_lsc_register_rGain_V_118[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_rGain_V_118<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_RGAIN_V_118)
            int_lsc_register_rGain_V_118<=WDATA;
    end
end

// int_lsc_register_rGain_V_119[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_rGain_V_119<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_RGAIN_V_119)
            int_lsc_register_rGain_V_119<=WDATA;
    end
end

// int_lsc_register_rGain_V_120[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_rGain_V_120<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_RGAIN_V_120)
            int_lsc_register_rGain_V_120<=WDATA;
    end
end

// int_lsc_register_rGain_V_121[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_rGain_V_121<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_RGAIN_V_121)
            int_lsc_register_rGain_V_121<=WDATA;
    end
end

// int_lsc_register_rGain_V_122[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_rGain_V_122<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_RGAIN_V_122)
            int_lsc_register_rGain_V_122<=WDATA;
    end
end

// int_lsc_register_rGain_V_123[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_rGain_V_123<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_RGAIN_V_123)
            int_lsc_register_rGain_V_123<=WDATA;
    end
end

// int_lsc_register_rGain_V_124[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_rGain_V_124<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_RGAIN_V_124)
            int_lsc_register_rGain_V_124<=WDATA;
    end
end

// int_lsc_register_rGain_V_125[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_rGain_V_125<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_RGAIN_V_125)
            int_lsc_register_rGain_V_125<=WDATA;
    end
end

// int_lsc_register_rGain_V_126[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_rGain_V_126<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_RGAIN_V_126)
            int_lsc_register_rGain_V_126<=WDATA;
    end
end

// int_lsc_register_rGain_V_127[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_rGain_V_127<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_RGAIN_V_127)
            int_lsc_register_rGain_V_127<=WDATA;
    end
end

// int_lsc_register_rGain_V_128[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_rGain_V_128<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_RGAIN_V_128)
            int_lsc_register_rGain_V_128<=WDATA;
    end
end

// int_lsc_register_rGain_V_129[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_rGain_V_129<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_RGAIN_V_129)
            int_lsc_register_rGain_V_129<=WDATA;
    end
end

// int_lsc_register_rGain_V_130[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_rGain_V_130<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_RGAIN_V_130)
            int_lsc_register_rGain_V_130<=WDATA;
    end
end

// int_lsc_register_rGain_V_131[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_rGain_V_131<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_RGAIN_V_131)
            int_lsc_register_rGain_V_131<=WDATA;
    end
end

// int_lsc_register_rGain_V_132[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_rGain_V_132<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_RGAIN_V_132)
            int_lsc_register_rGain_V_132<=WDATA;
    end
end

// int_lsc_register_rGain_V_133[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_rGain_V_133<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_RGAIN_V_133)
            int_lsc_register_rGain_V_133<=WDATA;
    end
end

// int_lsc_register_rGain_V_134[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_rGain_V_134<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_RGAIN_V_134)
            int_lsc_register_rGain_V_134<=WDATA;
    end
end

// int_lsc_register_rGain_V_135[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_rGain_V_135<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_RGAIN_V_135)
            int_lsc_register_rGain_V_135<=WDATA;
    end
end

// int_lsc_register_rGain_V_136[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_rGain_V_136<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_RGAIN_V_136)
            int_lsc_register_rGain_V_136<=WDATA;
    end
end

// int_lsc_register_rGain_V_137[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_rGain_V_137<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_RGAIN_V_137)
            int_lsc_register_rGain_V_137<=WDATA;
    end
end

// int_lsc_register_rGain_V_138[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_rGain_V_138<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_RGAIN_V_138)
            int_lsc_register_rGain_V_138<=WDATA;
    end
end

// int_lsc_register_rGain_V_139[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_rGain_V_139<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_RGAIN_V_139)
            int_lsc_register_rGain_V_139<=WDATA;
    end
end

// int_lsc_register_rGain_V_140[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_rGain_V_140<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_RGAIN_V_140)
            int_lsc_register_rGain_V_140<=WDATA;
    end
end

// int_lsc_register_rGain_V_141[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_rGain_V_141<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_RGAIN_V_141)
            int_lsc_register_rGain_V_141<=WDATA;
    end
end

// int_lsc_register_rGain_V_142[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_rGain_V_142<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_RGAIN_V_142)
            int_lsc_register_rGain_V_142<=WDATA;
    end
end

// int_lsc_register_rGain_V_143[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_rGain_V_143<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_RGAIN_V_143)
            int_lsc_register_rGain_V_143<=WDATA;
    end
end

// int_lsc_register_rGain_V_144[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_rGain_V_144<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_RGAIN_V_144)
            int_lsc_register_rGain_V_144<=WDATA;
    end
end

// int_lsc_register_rGain_V_145[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_rGain_V_145<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_RGAIN_V_145)
            int_lsc_register_rGain_V_145<=WDATA;
    end
end

// int_lsc_register_rGain_V_146[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_rGain_V_146<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_RGAIN_V_146)
            int_lsc_register_rGain_V_146<=WDATA;
    end
end

// int_lsc_register_rGain_V_147[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_rGain_V_147<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_RGAIN_V_147)
            int_lsc_register_rGain_V_147<=WDATA;
    end
end

// int_lsc_register_rGain_V_148[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_rGain_V_148<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_RGAIN_V_148)
            int_lsc_register_rGain_V_148<=WDATA;
    end
end

// int_lsc_register_rGain_V_149[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_rGain_V_149<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_RGAIN_V_149)
            int_lsc_register_rGain_V_149<=WDATA;
    end
end

// int_lsc_register_rGain_V_150[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_rGain_V_150<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_RGAIN_V_150)
            int_lsc_register_rGain_V_150<=WDATA;
    end
end

// int_lsc_register_rGain_V_151[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_rGain_V_151<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_RGAIN_V_151)
            int_lsc_register_rGain_V_151<=WDATA;
    end
end

// int_lsc_register_rGain_V_152[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_rGain_V_152<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_RGAIN_V_152)
            int_lsc_register_rGain_V_152<=WDATA;
    end
end

// int_lsc_register_rGain_V_153[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_rGain_V_153<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_RGAIN_V_153)
            int_lsc_register_rGain_V_153<=WDATA;
    end
end

// int_lsc_register_rGain_V_154[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_rGain_V_154<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_RGAIN_V_154)
            int_lsc_register_rGain_V_154<=WDATA;
    end
end

// int_lsc_register_rGain_V_155[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_rGain_V_155<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_RGAIN_V_155)
            int_lsc_register_rGain_V_155<=WDATA;
    end
end

// int_lsc_register_rGain_V_156[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_rGain_V_156<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_RGAIN_V_156)
            int_lsc_register_rGain_V_156<=WDATA;
    end
end

// int_lsc_register_rGain_V_157[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_rGain_V_157<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_RGAIN_V_157)
            int_lsc_register_rGain_V_157<=WDATA;
    end
end

// int_lsc_register_rGain_V_158[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_rGain_V_158<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_RGAIN_V_158)
            int_lsc_register_rGain_V_158<=WDATA;
    end
end

// int_lsc_register_rGain_V_159[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_rGain_V_159<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_RGAIN_V_159)
            int_lsc_register_rGain_V_159<=WDATA;
    end
end

// int_lsc_register_rGain_V_160[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_rGain_V_160<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_RGAIN_V_160)
            int_lsc_register_rGain_V_160<=WDATA;
    end
end

// int_lsc_register_rGain_V_161[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_rGain_V_161<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_RGAIN_V_161)
            int_lsc_register_rGain_V_161<=WDATA;
    end
end

// int_lsc_register_rGain_V_162[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_rGain_V_162<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_RGAIN_V_162)
            int_lsc_register_rGain_V_162<=WDATA;
    end
end

// int_lsc_register_rGain_V_163[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_rGain_V_163<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_RGAIN_V_163)
            int_lsc_register_rGain_V_163<=WDATA;
    end
end

// int_lsc_register_rGain_V_164[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_rGain_V_164<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_RGAIN_V_164)
            int_lsc_register_rGain_V_164<=WDATA;
    end
end

// int_lsc_register_rGain_V_165[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_rGain_V_165<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_RGAIN_V_165)
            int_lsc_register_rGain_V_165<=WDATA;
    end
end

// int_lsc_register_rGain_V_166[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_rGain_V_166<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_RGAIN_V_166)
            int_lsc_register_rGain_V_166<=WDATA;
    end
end

// int_lsc_register_rGain_V_167[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_rGain_V_167<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_RGAIN_V_167)
            int_lsc_register_rGain_V_167<=WDATA;
    end
end

// int_lsc_register_rGain_V_168[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_rGain_V_168<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_RGAIN_V_168)
            int_lsc_register_rGain_V_168<=WDATA;
    end
end

// int_lsc_register_rGain_V_169[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_rGain_V_169<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_RGAIN_V_169)
            int_lsc_register_rGain_V_169<=WDATA;
    end
end

// int_lsc_register_rGain_V_170[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_rGain_V_170<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_RGAIN_V_170)
            int_lsc_register_rGain_V_170<=WDATA;
    end
end

// int_lsc_register_rGain_V_171[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_rGain_V_171<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_RGAIN_V_171)
            int_lsc_register_rGain_V_171<=WDATA;
    end
end

// int_lsc_register_rGain_V_172[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_rGain_V_172<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_RGAIN_V_172)
            int_lsc_register_rGain_V_172<=WDATA;
    end
end

// int_lsc_register_rGain_V_173[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_rGain_V_173<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_RGAIN_V_173)
            int_lsc_register_rGain_V_173<=WDATA;
    end
end

// int_lsc_register_rGain_V_174[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_rGain_V_174<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_RGAIN_V_174)
            int_lsc_register_rGain_V_174<=WDATA;
    end
end

// int_lsc_register_rGain_V_175[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_rGain_V_175<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_RGAIN_V_175)
            int_lsc_register_rGain_V_175<=WDATA;
    end
end

// int_lsc_register_rGain_V_176[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_rGain_V_176<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_RGAIN_V_176)
            int_lsc_register_rGain_V_176<=WDATA;
    end
end

// int_lsc_register_rGain_V_177[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_rGain_V_177<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_RGAIN_V_177)
            int_lsc_register_rGain_V_177<=WDATA;
    end
end

// int_lsc_register_rGain_V_178[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_rGain_V_178<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_RGAIN_V_178)
            int_lsc_register_rGain_V_178<=WDATA;
    end
end

// int_lsc_register_rGain_V_179[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_rGain_V_179<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_RGAIN_V_179)
            int_lsc_register_rGain_V_179<=WDATA;
    end
end

// int_lsc_register_rGain_V_180[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_rGain_V_180<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_RGAIN_V_180)
            int_lsc_register_rGain_V_180<=WDATA;
    end
end

// int_lsc_register_rGain_V_181[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_rGain_V_181<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_RGAIN_V_181)
            int_lsc_register_rGain_V_181<=WDATA;
    end
end

// int_lsc_register_rGain_V_182[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_rGain_V_182<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_RGAIN_V_182)
            int_lsc_register_rGain_V_182<=WDATA;
    end
end

// int_lsc_register_rGain_V_183[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_rGain_V_183<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_RGAIN_V_183)
            int_lsc_register_rGain_V_183<=WDATA;
    end
end

// int_lsc_register_rGain_V_184[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_rGain_V_184<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_RGAIN_V_184)
            int_lsc_register_rGain_V_184<=WDATA;
    end
end

// int_lsc_register_rGain_V_185[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_rGain_V_185<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_RGAIN_V_185)
            int_lsc_register_rGain_V_185<=WDATA;
    end
end

// int_lsc_register_rGain_V_186[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_rGain_V_186<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_RGAIN_V_186)
            int_lsc_register_rGain_V_186<=WDATA;
    end
end

// int_lsc_register_rGain_V_187[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_rGain_V_187<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_RGAIN_V_187)
            int_lsc_register_rGain_V_187<=WDATA;
    end
end

// int_lsc_register_rGain_V_188[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_rGain_V_188<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_RGAIN_V_188)
            int_lsc_register_rGain_V_188<=WDATA;
    end
end

// int_lsc_register_rGain_V_189[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_rGain_V_189<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_RGAIN_V_189)
            int_lsc_register_rGain_V_189<=WDATA;
    end
end

// int_lsc_register_rGain_V_190[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_rGain_V_190<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_RGAIN_V_190)
            int_lsc_register_rGain_V_190<=WDATA;
    end
end

// int_lsc_register_rGain_V_191[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_rGain_V_191<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_RGAIN_V_191)
            int_lsc_register_rGain_V_191<=WDATA;
    end
end

// int_lsc_register_rGain_V_192[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_rGain_V_192<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_RGAIN_V_192)
            int_lsc_register_rGain_V_192<=WDATA;
    end
end

// int_lsc_register_rGain_V_193[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_rGain_V_193<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_RGAIN_V_193)
            int_lsc_register_rGain_V_193<=WDATA;
    end
end

// int_lsc_register_rGain_V_194[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_rGain_V_194<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_RGAIN_V_194)
            int_lsc_register_rGain_V_194<=WDATA;
    end
end

// int_lsc_register_rGain_V_195[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_rGain_V_195<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_RGAIN_V_195)
            int_lsc_register_rGain_V_195<=WDATA;
    end
end

// int_lsc_register_rGain_V_196[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_rGain_V_196<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_RGAIN_V_196)
            int_lsc_register_rGain_V_196<=WDATA;
    end
end

// int_lsc_register_rGain_V_197[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_rGain_V_197<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_RGAIN_V_197)
            int_lsc_register_rGain_V_197<=WDATA;
    end
end

// int_lsc_register_rGain_V_198[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_rGain_V_198<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_RGAIN_V_198)
            int_lsc_register_rGain_V_198<=WDATA;
    end
end

// int_lsc_register_rGain_V_199[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_rGain_V_199<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_RGAIN_V_199)
            int_lsc_register_rGain_V_199<=WDATA;
    end
end

// int_lsc_register_rGain_V_200[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_rGain_V_200<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_RGAIN_V_200)
            int_lsc_register_rGain_V_200<=WDATA;
    end
end

// int_lsc_register_rGain_V_201[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_rGain_V_201<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_RGAIN_V_201)
            int_lsc_register_rGain_V_201<=WDATA;
    end
end

// int_lsc_register_rGain_V_202[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_rGain_V_202<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_RGAIN_V_202)
            int_lsc_register_rGain_V_202<=WDATA;
    end
end

// int_lsc_register_rGain_V_203[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_rGain_V_203<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_RGAIN_V_203)
            int_lsc_register_rGain_V_203<=WDATA;
    end
end

// int_lsc_register_rGain_V_204[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_rGain_V_204<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_RGAIN_V_204)
            int_lsc_register_rGain_V_204<=WDATA;
    end
end

// int_lsc_register_rGain_V_205[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_rGain_V_205<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_RGAIN_V_205)
            int_lsc_register_rGain_V_205<=WDATA;
    end
end

// int_lsc_register_rGain_V_206[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_rGain_V_206<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_RGAIN_V_206)
            int_lsc_register_rGain_V_206<=WDATA;
    end
end

// int_lsc_register_rGain_V_207[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_rGain_V_207<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_RGAIN_V_207)
            int_lsc_register_rGain_V_207<=WDATA;
    end
end

// int_lsc_register_rGain_V_208[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_rGain_V_208<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_RGAIN_V_208)
            int_lsc_register_rGain_V_208<=WDATA;
    end
end

// int_lsc_register_rGain_V_209[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_rGain_V_209<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_RGAIN_V_209)
            int_lsc_register_rGain_V_209<=WDATA;
    end
end

// int_lsc_register_rGain_V_210[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_rGain_V_210<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_RGAIN_V_210)
            int_lsc_register_rGain_V_210<=WDATA;
    end
end

// int_lsc_register_rGain_V_211[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_rGain_V_211<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_RGAIN_V_211)
            int_lsc_register_rGain_V_211<=WDATA;
    end
end

// int_lsc_register_rGain_V_212[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_rGain_V_212<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_RGAIN_V_212)
            int_lsc_register_rGain_V_212<=WDATA;
    end
end

// int_lsc_register_rGain_V_213[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_rGain_V_213<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_RGAIN_V_213)
            int_lsc_register_rGain_V_213<=WDATA;
    end
end

// int_lsc_register_rGain_V_214[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_rGain_V_214<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_RGAIN_V_214)
            int_lsc_register_rGain_V_214<=WDATA;
    end
end

// int_lsc_register_rGain_V_215[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_rGain_V_215<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_RGAIN_V_215)
            int_lsc_register_rGain_V_215<=WDATA;
    end
end

// int_lsc_register_rGain_V_216[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_rGain_V_216<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_RGAIN_V_216)
            int_lsc_register_rGain_V_216<=WDATA;
    end
end

// int_lsc_register_rGain_V_217[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_rGain_V_217<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_RGAIN_V_217)
            int_lsc_register_rGain_V_217<=WDATA;
    end
end

// int_lsc_register_rGain_V_218[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_rGain_V_218<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_RGAIN_V_218)
            int_lsc_register_rGain_V_218<=WDATA;
    end
end

// int_lsc_register_rGain_V_219[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_rGain_V_219<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_RGAIN_V_219)
            int_lsc_register_rGain_V_219<=WDATA;
    end
end

// int_lsc_register_rGain_V_220[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_rGain_V_220<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_RGAIN_V_220)
            int_lsc_register_rGain_V_220<=WDATA;
    end
end

// int_lsc_register_GrGain_V_0[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_GrGain_V_0<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_GRGAIN_V_0)
            int_lsc_register_GrGain_V_0<=WDATA;
    end
end

// int_lsc_register_GrGain_V_1[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_GrGain_V_1<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_GRGAIN_V_1)
            int_lsc_register_GrGain_V_1<=WDATA;
    end
end

// int_lsc_register_GrGain_V_2[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_GrGain_V_2<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_GRGAIN_V_2)
            int_lsc_register_GrGain_V_2<=WDATA;
    end
end

// int_lsc_register_GrGain_V_3[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_GrGain_V_3<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_GRGAIN_V_3)
            int_lsc_register_GrGain_V_3<=WDATA;
    end
end

// int_lsc_register_GrGain_V_4[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_GrGain_V_4<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_GRGAIN_V_4)
            int_lsc_register_GrGain_V_4<=WDATA;
    end
end

// int_lsc_register_GrGain_V_5[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_GrGain_V_5<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_GRGAIN_V_5)
            int_lsc_register_GrGain_V_5<=WDATA;
    end
end

// int_lsc_register_GrGain_V_6[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_GrGain_V_6<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_GRGAIN_V_6)
            int_lsc_register_GrGain_V_6<=WDATA;
    end
end

// int_lsc_register_GrGain_V_7[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_GrGain_V_7<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_GRGAIN_V_7)
            int_lsc_register_GrGain_V_7<=WDATA;
    end
end

// int_lsc_register_GrGain_V_8[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_GrGain_V_8<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_GRGAIN_V_8)
            int_lsc_register_GrGain_V_8<=WDATA;
    end
end

// int_lsc_register_GrGain_V_9[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_GrGain_V_9<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_GRGAIN_V_9)
            int_lsc_register_GrGain_V_9<=WDATA;
    end
end

// int_lsc_register_GrGain_V_10[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_GrGain_V_10<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_GRGAIN_V_10)
            int_lsc_register_GrGain_V_10<=WDATA;
    end
end

// int_lsc_register_GrGain_V_11[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_GrGain_V_11<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_GRGAIN_V_11)
            int_lsc_register_GrGain_V_11<=WDATA;
    end
end

// int_lsc_register_GrGain_V_12[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_GrGain_V_12<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_GRGAIN_V_12)
            int_lsc_register_GrGain_V_12<=WDATA;
    end
end

// int_lsc_register_GrGain_V_13[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_GrGain_V_13<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_GRGAIN_V_13)
            int_lsc_register_GrGain_V_13<=WDATA;
    end
end

// int_lsc_register_GrGain_V_14[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_GrGain_V_14<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_GRGAIN_V_14)
            int_lsc_register_GrGain_V_14<=WDATA;
    end
end

// int_lsc_register_GrGain_V_15[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_GrGain_V_15<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_GRGAIN_V_15)
            int_lsc_register_GrGain_V_15<=WDATA;
    end
end

// int_lsc_register_GrGain_V_16[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_GrGain_V_16<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_GRGAIN_V_16)
            int_lsc_register_GrGain_V_16<=WDATA;
    end
end

// int_lsc_register_GrGain_V_17[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_GrGain_V_17<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_GRGAIN_V_17)
            int_lsc_register_GrGain_V_17<=WDATA;
    end
end

// int_lsc_register_GrGain_V_18[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_GrGain_V_18<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_GRGAIN_V_18)
            int_lsc_register_GrGain_V_18<=WDATA;
    end
end

// int_lsc_register_GrGain_V_19[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_GrGain_V_19<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_GRGAIN_V_19)
            int_lsc_register_GrGain_V_19<=WDATA;
    end
end

// int_lsc_register_GrGain_V_20[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_GrGain_V_20<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_GRGAIN_V_20)
            int_lsc_register_GrGain_V_20<=WDATA;
    end
end

// int_lsc_register_GrGain_V_21[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_GrGain_V_21<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_GRGAIN_V_21)
            int_lsc_register_GrGain_V_21<=WDATA;
    end
end

// int_lsc_register_GrGain_V_22[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_GrGain_V_22<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_GRGAIN_V_22)
            int_lsc_register_GrGain_V_22<=WDATA;
    end
end

// int_lsc_register_GrGain_V_23[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_GrGain_V_23<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_GRGAIN_V_23)
            int_lsc_register_GrGain_V_23<=WDATA;
    end
end

// int_lsc_register_GrGain_V_24[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_GrGain_V_24<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_GRGAIN_V_24)
            int_lsc_register_GrGain_V_24<=WDATA;
    end
end

// int_lsc_register_GrGain_V_25[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_GrGain_V_25<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_GRGAIN_V_25)
            int_lsc_register_GrGain_V_25<=WDATA;
    end
end

// int_lsc_register_GrGain_V_26[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_GrGain_V_26<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_GRGAIN_V_26)
            int_lsc_register_GrGain_V_26<=WDATA;
    end
end

// int_lsc_register_GrGain_V_27[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_GrGain_V_27<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_GRGAIN_V_27)
            int_lsc_register_GrGain_V_27<=WDATA;
    end
end

// int_lsc_register_GrGain_V_28[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_GrGain_V_28<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_GRGAIN_V_28)
            int_lsc_register_GrGain_V_28<=WDATA;
    end
end

// int_lsc_register_GrGain_V_29[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_GrGain_V_29<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_GRGAIN_V_29)
            int_lsc_register_GrGain_V_29<=WDATA;
    end
end

// int_lsc_register_GrGain_V_30[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_GrGain_V_30<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_GRGAIN_V_30)
            int_lsc_register_GrGain_V_30<=WDATA;
    end
end

// int_lsc_register_GrGain_V_31[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_GrGain_V_31<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_GRGAIN_V_31)
            int_lsc_register_GrGain_V_31<=WDATA;
    end
end

// int_lsc_register_GrGain_V_32[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_GrGain_V_32<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_GRGAIN_V_32)
            int_lsc_register_GrGain_V_32<=WDATA;
    end
end

// int_lsc_register_GrGain_V_33[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_GrGain_V_33<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_GRGAIN_V_33)
            int_lsc_register_GrGain_V_33<=WDATA;
    end
end

// int_lsc_register_GrGain_V_34[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_GrGain_V_34<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_GRGAIN_V_34)
            int_lsc_register_GrGain_V_34<=WDATA;
    end
end

// int_lsc_register_GrGain_V_35[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_GrGain_V_35<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_GRGAIN_V_35)
            int_lsc_register_GrGain_V_35<=WDATA;
    end
end

// int_lsc_register_GrGain_V_36[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_GrGain_V_36<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_GRGAIN_V_36)
            int_lsc_register_GrGain_V_36<=WDATA;
    end
end

// int_lsc_register_GrGain_V_37[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_GrGain_V_37<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_GRGAIN_V_37)
            int_lsc_register_GrGain_V_37<=WDATA;
    end
end

// int_lsc_register_GrGain_V_38[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_GrGain_V_38<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_GRGAIN_V_38)
            int_lsc_register_GrGain_V_38<=WDATA;
    end
end

// int_lsc_register_GrGain_V_39[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_GrGain_V_39<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_GRGAIN_V_39)
            int_lsc_register_GrGain_V_39<=WDATA;
    end
end

// int_lsc_register_GrGain_V_40[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_GrGain_V_40<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_GRGAIN_V_40)
            int_lsc_register_GrGain_V_40<=WDATA;
    end
end

// int_lsc_register_GrGain_V_41[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_GrGain_V_41<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_GRGAIN_V_41)
            int_lsc_register_GrGain_V_41<=WDATA;
    end
end

// int_lsc_register_GrGain_V_42[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_GrGain_V_42<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_GRGAIN_V_42)
            int_lsc_register_GrGain_V_42<=WDATA;
    end
end

// int_lsc_register_GrGain_V_43[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_GrGain_V_43<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_GRGAIN_V_43)
            int_lsc_register_GrGain_V_43<=WDATA;
    end
end

// int_lsc_register_GrGain_V_44[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_GrGain_V_44<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_GRGAIN_V_44)
            int_lsc_register_GrGain_V_44<=WDATA;
    end
end

// int_lsc_register_GrGain_V_45[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_GrGain_V_45<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_GRGAIN_V_45)
            int_lsc_register_GrGain_V_45<=WDATA;
    end
end

// int_lsc_register_GrGain_V_46[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_GrGain_V_46<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_GRGAIN_V_46)
            int_lsc_register_GrGain_V_46<=WDATA;
    end
end

// int_lsc_register_GrGain_V_47[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_GrGain_V_47<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_GRGAIN_V_47)
            int_lsc_register_GrGain_V_47<=WDATA;
    end
end

// int_lsc_register_GrGain_V_48[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_GrGain_V_48<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_GRGAIN_V_48)
            int_lsc_register_GrGain_V_48<=WDATA;
    end
end

// int_lsc_register_GrGain_V_49[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_GrGain_V_49<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_GRGAIN_V_49)
            int_lsc_register_GrGain_V_49<=WDATA;
    end
end

// int_lsc_register_GrGain_V_50[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_GrGain_V_50<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_GRGAIN_V_50)
            int_lsc_register_GrGain_V_50<=WDATA;
    end
end

// int_lsc_register_GrGain_V_51[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_GrGain_V_51<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_GRGAIN_V_51)
            int_lsc_register_GrGain_V_51<=WDATA;
    end
end

// int_lsc_register_GrGain_V_52[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_GrGain_V_52<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_GRGAIN_V_52)
            int_lsc_register_GrGain_V_52<=WDATA;
    end
end

// int_lsc_register_GrGain_V_53[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_GrGain_V_53<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_GRGAIN_V_53)
            int_lsc_register_GrGain_V_53<=WDATA;
    end
end

// int_lsc_register_GrGain_V_54[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_GrGain_V_54<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_GRGAIN_V_54)
            int_lsc_register_GrGain_V_54<=WDATA;
    end
end

// int_lsc_register_GrGain_V_55[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_GrGain_V_55<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_GRGAIN_V_55)
            int_lsc_register_GrGain_V_55<=WDATA;
    end
end

// int_lsc_register_GrGain_V_56[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_GrGain_V_56<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_GRGAIN_V_56)
            int_lsc_register_GrGain_V_56<=WDATA;
    end
end

// int_lsc_register_GrGain_V_57[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_GrGain_V_57<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_GRGAIN_V_57)
            int_lsc_register_GrGain_V_57<=WDATA;
    end
end

// int_lsc_register_GrGain_V_58[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_GrGain_V_58<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_GRGAIN_V_58)
            int_lsc_register_GrGain_V_58<=WDATA;
    end
end

// int_lsc_register_GrGain_V_59[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_GrGain_V_59<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_GRGAIN_V_59)
            int_lsc_register_GrGain_V_59<=WDATA;
    end
end

// int_lsc_register_GrGain_V_60[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_GrGain_V_60<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_GRGAIN_V_60)
            int_lsc_register_GrGain_V_60<=WDATA;
    end
end

// int_lsc_register_GrGain_V_61[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_GrGain_V_61<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_GRGAIN_V_61)
            int_lsc_register_GrGain_V_61<=WDATA;
    end
end

// int_lsc_register_GrGain_V_62[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_GrGain_V_62<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_GRGAIN_V_62)
            int_lsc_register_GrGain_V_62<=WDATA;
    end
end

// int_lsc_register_GrGain_V_63[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_GrGain_V_63<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_GRGAIN_V_63)
            int_lsc_register_GrGain_V_63<=WDATA;
    end
end

// int_lsc_register_GrGain_V_64[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_GrGain_V_64<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_GRGAIN_V_64)
            int_lsc_register_GrGain_V_64<=WDATA;
    end
end

// int_lsc_register_GrGain_V_65[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_GrGain_V_65<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_GRGAIN_V_65)
            int_lsc_register_GrGain_V_65<=WDATA;
    end
end

// int_lsc_register_GrGain_V_66[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_GrGain_V_66<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_GRGAIN_V_66)
            int_lsc_register_GrGain_V_66<=WDATA;
    end
end

// int_lsc_register_GrGain_V_67[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_GrGain_V_67<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_GRGAIN_V_67)
            int_lsc_register_GrGain_V_67<=WDATA;
    end
end

// int_lsc_register_GrGain_V_68[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_GrGain_V_68<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_GRGAIN_V_68)
            int_lsc_register_GrGain_V_68<=WDATA;
    end
end

// int_lsc_register_GrGain_V_69[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_GrGain_V_69<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_GRGAIN_V_69)
            int_lsc_register_GrGain_V_69<=WDATA;
    end
end

// int_lsc_register_GrGain_V_70[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_GrGain_V_70<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_GRGAIN_V_70)
            int_lsc_register_GrGain_V_70<=WDATA;
    end
end

// int_lsc_register_GrGain_V_71[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_GrGain_V_71<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_GRGAIN_V_71)
            int_lsc_register_GrGain_V_71<=WDATA;
    end
end

// int_lsc_register_GrGain_V_72[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_GrGain_V_72<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_GRGAIN_V_72)
            int_lsc_register_GrGain_V_72<=WDATA;
    end
end

// int_lsc_register_GrGain_V_73[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_GrGain_V_73<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_GRGAIN_V_73)
            int_lsc_register_GrGain_V_73<=WDATA;
    end
end

// int_lsc_register_GrGain_V_74[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_GrGain_V_74<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_GRGAIN_V_74)
            int_lsc_register_GrGain_V_74<=WDATA;
    end
end

// int_lsc_register_GrGain_V_75[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_GrGain_V_75<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_GRGAIN_V_75)
            int_lsc_register_GrGain_V_75<=WDATA;
    end
end

// int_lsc_register_GrGain_V_76[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_GrGain_V_76<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_GRGAIN_V_76)
            int_lsc_register_GrGain_V_76<=WDATA;
    end
end

// int_lsc_register_GrGain_V_77[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_GrGain_V_77<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_GRGAIN_V_77)
            int_lsc_register_GrGain_V_77<=WDATA;
    end
end

// int_lsc_register_GrGain_V_78[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_GrGain_V_78<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_GRGAIN_V_78)
            int_lsc_register_GrGain_V_78<=WDATA;
    end
end

// int_lsc_register_GrGain_V_79[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_GrGain_V_79<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_GRGAIN_V_79)
            int_lsc_register_GrGain_V_79<=WDATA;
    end
end

// int_lsc_register_GrGain_V_80[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_GrGain_V_80<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_GRGAIN_V_80)
            int_lsc_register_GrGain_V_80<=WDATA;
    end
end

// int_lsc_register_GrGain_V_81[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_GrGain_V_81<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_GRGAIN_V_81)
            int_lsc_register_GrGain_V_81<=WDATA;
    end
end

// int_lsc_register_GrGain_V_82[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_GrGain_V_82<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_GRGAIN_V_82)
            int_lsc_register_GrGain_V_82<=WDATA;
    end
end

// int_lsc_register_GrGain_V_83[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_GrGain_V_83<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_GRGAIN_V_83)
            int_lsc_register_GrGain_V_83<=WDATA;
    end
end

// int_lsc_register_GrGain_V_84[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_GrGain_V_84<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_GRGAIN_V_84)
            int_lsc_register_GrGain_V_84<=WDATA;
    end
end

// int_lsc_register_GrGain_V_85[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_GrGain_V_85<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_GRGAIN_V_85)
            int_lsc_register_GrGain_V_85<=WDATA;
    end
end

// int_lsc_register_GrGain_V_86[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_GrGain_V_86<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_GRGAIN_V_86)
            int_lsc_register_GrGain_V_86<=WDATA;
    end
end

// int_lsc_register_GrGain_V_87[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_GrGain_V_87<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_GRGAIN_V_87)
            int_lsc_register_GrGain_V_87<=WDATA;
    end
end

// int_lsc_register_GrGain_V_88[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_GrGain_V_88<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_GRGAIN_V_88)
            int_lsc_register_GrGain_V_88<=WDATA;
    end
end

// int_lsc_register_GrGain_V_89[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_GrGain_V_89<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_GRGAIN_V_89)
            int_lsc_register_GrGain_V_89<=WDATA;
    end
end

// int_lsc_register_GrGain_V_90[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_GrGain_V_90<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_GRGAIN_V_90)
            int_lsc_register_GrGain_V_90<=WDATA;
    end
end

// int_lsc_register_GrGain_V_91[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_GrGain_V_91<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_GRGAIN_V_91)
            int_lsc_register_GrGain_V_91<=WDATA;
    end
end

// int_lsc_register_GrGain_V_92[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_GrGain_V_92<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_GRGAIN_V_92)
            int_lsc_register_GrGain_V_92<=WDATA;
    end
end

// int_lsc_register_GrGain_V_93[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_GrGain_V_93<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_GRGAIN_V_93)
            int_lsc_register_GrGain_V_93<=WDATA;
    end
end

// int_lsc_register_GrGain_V_94[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_GrGain_V_94<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_GRGAIN_V_94)
            int_lsc_register_GrGain_V_94<=WDATA;
    end
end

// int_lsc_register_GrGain_V_95[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_GrGain_V_95<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_GRGAIN_V_95)
            int_lsc_register_GrGain_V_95<=WDATA;
    end
end

// int_lsc_register_GrGain_V_96[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_GrGain_V_96<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_GRGAIN_V_96)
            int_lsc_register_GrGain_V_96<=WDATA;
    end
end

// int_lsc_register_GrGain_V_97[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_GrGain_V_97<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_GRGAIN_V_97)
            int_lsc_register_GrGain_V_97<=WDATA;
    end
end

// int_lsc_register_GrGain_V_98[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_GrGain_V_98<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_GRGAIN_V_98)
            int_lsc_register_GrGain_V_98<=WDATA;
    end
end

// int_lsc_register_GrGain_V_99[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_GrGain_V_99<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_GRGAIN_V_99)
            int_lsc_register_GrGain_V_99<=WDATA;
    end
end

// int_lsc_register_GrGain_V_100[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_GrGain_V_100<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_GRGAIN_V_100)
            int_lsc_register_GrGain_V_100<=WDATA;
    end
end

// int_lsc_register_GrGain_V_101[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_GrGain_V_101<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_GRGAIN_V_101)
            int_lsc_register_GrGain_V_101<=WDATA;
    end
end

// int_lsc_register_GrGain_V_102[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_GrGain_V_102<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_GRGAIN_V_102)
            int_lsc_register_GrGain_V_102<=WDATA;
    end
end

// int_lsc_register_GrGain_V_103[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_GrGain_V_103<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_GRGAIN_V_103)
            int_lsc_register_GrGain_V_103<=WDATA;
    end
end

// int_lsc_register_GrGain_V_104[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_GrGain_V_104<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_GRGAIN_V_104)
            int_lsc_register_GrGain_V_104<=WDATA;
    end
end

// int_lsc_register_GrGain_V_105[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_GrGain_V_105<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_GRGAIN_V_105)
            int_lsc_register_GrGain_V_105<=WDATA;
    end
end

// int_lsc_register_GrGain_V_106[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_GrGain_V_106<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_GRGAIN_V_106)
            int_lsc_register_GrGain_V_106<=WDATA;
    end
end

// int_lsc_register_GrGain_V_107[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_GrGain_V_107<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_GRGAIN_V_107)
            int_lsc_register_GrGain_V_107<=WDATA;
    end
end

// int_lsc_register_GrGain_V_108[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_GrGain_V_108<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_GRGAIN_V_108)
            int_lsc_register_GrGain_V_108<=WDATA;
    end
end

// int_lsc_register_GrGain_V_109[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_GrGain_V_109<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_GRGAIN_V_109)
            int_lsc_register_GrGain_V_109<=WDATA;
    end
end

// int_lsc_register_GrGain_V_110[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_GrGain_V_110<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_GRGAIN_V_110)
            int_lsc_register_GrGain_V_110<=WDATA;
    end
end

// int_lsc_register_GrGain_V_111[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_GrGain_V_111<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_GRGAIN_V_111)
            int_lsc_register_GrGain_V_111<=WDATA;
    end
end

// int_lsc_register_GrGain_V_112[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_GrGain_V_112<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_GRGAIN_V_112)
            int_lsc_register_GrGain_V_112<=WDATA;
    end
end

// int_lsc_register_GrGain_V_113[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_GrGain_V_113<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_GRGAIN_V_113)
            int_lsc_register_GrGain_V_113<=WDATA;
    end
end

// int_lsc_register_GrGain_V_114[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_GrGain_V_114<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_GRGAIN_V_114)
            int_lsc_register_GrGain_V_114<=WDATA;
    end
end

// int_lsc_register_GrGain_V_115[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_GrGain_V_115<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_GRGAIN_V_115)
            int_lsc_register_GrGain_V_115<=WDATA;
    end
end

// int_lsc_register_GrGain_V_116[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_GrGain_V_116<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_GRGAIN_V_116)
            int_lsc_register_GrGain_V_116<=WDATA;
    end
end

// int_lsc_register_GrGain_V_117[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_GrGain_V_117<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_GRGAIN_V_117)
            int_lsc_register_GrGain_V_117<=WDATA;
    end
end

// int_lsc_register_GrGain_V_118[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_GrGain_V_118<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_GRGAIN_V_118)
            int_lsc_register_GrGain_V_118<=WDATA;
    end
end

// int_lsc_register_GrGain_V_119[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_GrGain_V_119<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_GRGAIN_V_119)
            int_lsc_register_GrGain_V_119<=WDATA;
    end
end

// int_lsc_register_GrGain_V_120[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_GrGain_V_120<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_GRGAIN_V_120)
            int_lsc_register_GrGain_V_120<=WDATA;
    end
end

// int_lsc_register_GrGain_V_121[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_GrGain_V_121<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_GRGAIN_V_121)
            int_lsc_register_GrGain_V_121<=WDATA;
    end
end

// int_lsc_register_GrGain_V_122[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_GrGain_V_122<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_GRGAIN_V_122)
            int_lsc_register_GrGain_V_122<=WDATA;
    end
end

// int_lsc_register_GrGain_V_123[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_GrGain_V_123<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_GRGAIN_V_123)
            int_lsc_register_GrGain_V_123<=WDATA;
    end
end

// int_lsc_register_GrGain_V_124[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_GrGain_V_124<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_GRGAIN_V_124)
            int_lsc_register_GrGain_V_124<=WDATA;
    end
end

// int_lsc_register_GrGain_V_125[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_GrGain_V_125<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_GRGAIN_V_125)
            int_lsc_register_GrGain_V_125<=WDATA;
    end
end

// int_lsc_register_GrGain_V_126[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_GrGain_V_126<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_GRGAIN_V_126)
            int_lsc_register_GrGain_V_126<=WDATA;
    end
end

// int_lsc_register_GrGain_V_127[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_GrGain_V_127<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_GRGAIN_V_127)
            int_lsc_register_GrGain_V_127<=WDATA;
    end
end

// int_lsc_register_GrGain_V_128[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_GrGain_V_128<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_GRGAIN_V_128)
            int_lsc_register_GrGain_V_128<=WDATA;
    end
end

// int_lsc_register_GrGain_V_129[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_GrGain_V_129<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_GRGAIN_V_129)
            int_lsc_register_GrGain_V_129<=WDATA;
    end
end

// int_lsc_register_GrGain_V_130[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_GrGain_V_130<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_GRGAIN_V_130)
            int_lsc_register_GrGain_V_130<=WDATA;
    end
end

// int_lsc_register_GrGain_V_131[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_GrGain_V_131<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_GRGAIN_V_131)
            int_lsc_register_GrGain_V_131<=WDATA;
    end
end

// int_lsc_register_GrGain_V_132[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_GrGain_V_132<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_GRGAIN_V_132)
            int_lsc_register_GrGain_V_132<=WDATA;
    end
end

// int_lsc_register_GrGain_V_133[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_GrGain_V_133<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_GRGAIN_V_133)
            int_lsc_register_GrGain_V_133<=WDATA;
    end
end

// int_lsc_register_GrGain_V_134[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_GrGain_V_134<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_GRGAIN_V_134)
            int_lsc_register_GrGain_V_134<=WDATA;
    end
end

// int_lsc_register_GrGain_V_135[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_GrGain_V_135<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_GRGAIN_V_135)
            int_lsc_register_GrGain_V_135<=WDATA;
    end
end

// int_lsc_register_GrGain_V_136[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_GrGain_V_136<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_GRGAIN_V_136)
            int_lsc_register_GrGain_V_136<=WDATA;
    end
end

// int_lsc_register_GrGain_V_137[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_GrGain_V_137<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_GRGAIN_V_137)
            int_lsc_register_GrGain_V_137<=WDATA;
    end
end

// int_lsc_register_GrGain_V_138[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_GrGain_V_138<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_GRGAIN_V_138)
            int_lsc_register_GrGain_V_138<=WDATA;
    end
end

// int_lsc_register_GrGain_V_139[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_GrGain_V_139<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_GRGAIN_V_139)
            int_lsc_register_GrGain_V_139<=WDATA;
    end
end

// int_lsc_register_GrGain_V_140[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_GrGain_V_140<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_GRGAIN_V_140)
            int_lsc_register_GrGain_V_140<=WDATA;
    end
end

// int_lsc_register_GrGain_V_141[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_GrGain_V_141<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_GRGAIN_V_141)
            int_lsc_register_GrGain_V_141<=WDATA;
    end
end

// int_lsc_register_GrGain_V_142[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_GrGain_V_142<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_GRGAIN_V_142)
            int_lsc_register_GrGain_V_142<=WDATA;
    end
end

// int_lsc_register_GrGain_V_143[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_GrGain_V_143<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_GRGAIN_V_143)
            int_lsc_register_GrGain_V_143<=WDATA;
    end
end

// int_lsc_register_GrGain_V_144[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_GrGain_V_144<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_GRGAIN_V_144)
            int_lsc_register_GrGain_V_144<=WDATA;
    end
end

// int_lsc_register_GrGain_V_145[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_GrGain_V_145<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_GRGAIN_V_145)
            int_lsc_register_GrGain_V_145<=WDATA;
    end
end

// int_lsc_register_GrGain_V_146[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_GrGain_V_146<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_GRGAIN_V_146)
            int_lsc_register_GrGain_V_146<=WDATA;
    end
end

// int_lsc_register_GrGain_V_147[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_GrGain_V_147<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_GRGAIN_V_147)
            int_lsc_register_GrGain_V_147<=WDATA;
    end
end

// int_lsc_register_GrGain_V_148[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_GrGain_V_148<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_GRGAIN_V_148)
            int_lsc_register_GrGain_V_148<=WDATA;
    end
end

// int_lsc_register_GrGain_V_149[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_GrGain_V_149<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_GRGAIN_V_149)
            int_lsc_register_GrGain_V_149<=WDATA;
    end
end

// int_lsc_register_GrGain_V_150[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_GrGain_V_150<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_GRGAIN_V_150)
            int_lsc_register_GrGain_V_150<=WDATA;
    end
end

// int_lsc_register_GrGain_V_151[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_GrGain_V_151<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_GRGAIN_V_151)
            int_lsc_register_GrGain_V_151<=WDATA;
    end
end

// int_lsc_register_GrGain_V_152[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_GrGain_V_152<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_GRGAIN_V_152)
            int_lsc_register_GrGain_V_152<=WDATA;
    end
end

// int_lsc_register_GrGain_V_153[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_GrGain_V_153<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_GRGAIN_V_153)
            int_lsc_register_GrGain_V_153<=WDATA;
    end
end

// int_lsc_register_GrGain_V_154[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_GrGain_V_154<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_GRGAIN_V_154)
            int_lsc_register_GrGain_V_154<=WDATA;
    end
end

// int_lsc_register_GrGain_V_155[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_GrGain_V_155<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_GRGAIN_V_155)
            int_lsc_register_GrGain_V_155<=WDATA;
    end
end

// int_lsc_register_GrGain_V_156[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_GrGain_V_156<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_GRGAIN_V_156)
            int_lsc_register_GrGain_V_156<=WDATA;
    end
end

// int_lsc_register_GrGain_V_157[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_GrGain_V_157<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_GRGAIN_V_157)
            int_lsc_register_GrGain_V_157<=WDATA;
    end
end

// int_lsc_register_GrGain_V_158[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_GrGain_V_158<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_GRGAIN_V_158)
            int_lsc_register_GrGain_V_158<=WDATA;
    end
end

// int_lsc_register_GrGain_V_159[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_GrGain_V_159<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_GRGAIN_V_159)
            int_lsc_register_GrGain_V_159<=WDATA;
    end
end

// int_lsc_register_GrGain_V_160[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_GrGain_V_160<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_GRGAIN_V_160)
            int_lsc_register_GrGain_V_160<=WDATA;
    end
end

// int_lsc_register_GrGain_V_161[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_GrGain_V_161<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_GRGAIN_V_161)
            int_lsc_register_GrGain_V_161<=WDATA;
    end
end

// int_lsc_register_GrGain_V_162[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_GrGain_V_162<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_GRGAIN_V_162)
            int_lsc_register_GrGain_V_162<=WDATA;
    end
end

// int_lsc_register_GrGain_V_163[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_GrGain_V_163<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_GRGAIN_V_163)
            int_lsc_register_GrGain_V_163<=WDATA;
    end
end

// int_lsc_register_GrGain_V_164[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_GrGain_V_164<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_GRGAIN_V_164)
            int_lsc_register_GrGain_V_164<=WDATA;
    end
end

// int_lsc_register_GrGain_V_165[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_GrGain_V_165<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_GRGAIN_V_165)
            int_lsc_register_GrGain_V_165<=WDATA;
    end
end

// int_lsc_register_GrGain_V_166[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_GrGain_V_166<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_GRGAIN_V_166)
            int_lsc_register_GrGain_V_166<=WDATA;
    end
end

// int_lsc_register_GrGain_V_167[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_GrGain_V_167<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_GRGAIN_V_167)
            int_lsc_register_GrGain_V_167<=WDATA;
    end
end

// int_lsc_register_GrGain_V_168[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_GrGain_V_168<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_GRGAIN_V_168)
            int_lsc_register_GrGain_V_168<=WDATA;
    end
end

// int_lsc_register_GrGain_V_169[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_GrGain_V_169<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_GRGAIN_V_169)
            int_lsc_register_GrGain_V_169<=WDATA;
    end
end

// int_lsc_register_GrGain_V_170[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_GrGain_V_170<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_GRGAIN_V_170)
            int_lsc_register_GrGain_V_170<=WDATA;
    end
end

// int_lsc_register_GrGain_V_171[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_GrGain_V_171<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_GRGAIN_V_171)
            int_lsc_register_GrGain_V_171<=WDATA;
    end
end

// int_lsc_register_GrGain_V_172[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_GrGain_V_172<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_GRGAIN_V_172)
            int_lsc_register_GrGain_V_172<=WDATA;
    end
end

// int_lsc_register_GrGain_V_173[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_GrGain_V_173<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_GRGAIN_V_173)
            int_lsc_register_GrGain_V_173<=WDATA;
    end
end

// int_lsc_register_GrGain_V_174[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_GrGain_V_174<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_GRGAIN_V_174)
            int_lsc_register_GrGain_V_174<=WDATA;
    end
end

// int_lsc_register_GrGain_V_175[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_GrGain_V_175<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_GRGAIN_V_175)
            int_lsc_register_GrGain_V_175<=WDATA;
    end
end

// int_lsc_register_GrGain_V_176[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_GrGain_V_176<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_GRGAIN_V_176)
            int_lsc_register_GrGain_V_176<=WDATA;
    end
end

// int_lsc_register_GrGain_V_177[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_GrGain_V_177<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_GRGAIN_V_177)
            int_lsc_register_GrGain_V_177<=WDATA;
    end
end

// int_lsc_register_GrGain_V_178[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_GrGain_V_178<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_GRGAIN_V_178)
            int_lsc_register_GrGain_V_178<=WDATA;
    end
end

// int_lsc_register_GrGain_V_179[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_GrGain_V_179<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_GRGAIN_V_179)
            int_lsc_register_GrGain_V_179<=WDATA;
    end
end

// int_lsc_register_GrGain_V_180[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_GrGain_V_180<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_GRGAIN_V_180)
            int_lsc_register_GrGain_V_180<=WDATA;
    end
end

// int_lsc_register_GrGain_V_181[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_GrGain_V_181<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_GRGAIN_V_181)
            int_lsc_register_GrGain_V_181<=WDATA;
    end
end

// int_lsc_register_GrGain_V_182[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_GrGain_V_182<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_GRGAIN_V_182)
            int_lsc_register_GrGain_V_182<=WDATA;
    end
end

// int_lsc_register_GrGain_V_183[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_GrGain_V_183<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_GRGAIN_V_183)
            int_lsc_register_GrGain_V_183<=WDATA;
    end
end

// int_lsc_register_GrGain_V_184[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_GrGain_V_184<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_GRGAIN_V_184)
            int_lsc_register_GrGain_V_184<=WDATA;
    end
end

// int_lsc_register_GrGain_V_185[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_GrGain_V_185<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_GRGAIN_V_185)
            int_lsc_register_GrGain_V_185<=WDATA;
    end
end

// int_lsc_register_GrGain_V_186[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_GrGain_V_186<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_GRGAIN_V_186)
            int_lsc_register_GrGain_V_186<=WDATA;
    end
end

// int_lsc_register_GrGain_V_187[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_GrGain_V_187<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_GRGAIN_V_187)
            int_lsc_register_GrGain_V_187<=WDATA;
    end
end

// int_lsc_register_GrGain_V_188[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_GrGain_V_188<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_GRGAIN_V_188)
            int_lsc_register_GrGain_V_188<=WDATA;
    end
end

// int_lsc_register_GrGain_V_189[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_GrGain_V_189<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_GRGAIN_V_189)
            int_lsc_register_GrGain_V_189<=WDATA;
    end
end

// int_lsc_register_GrGain_V_190[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_GrGain_V_190<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_GRGAIN_V_190)
            int_lsc_register_GrGain_V_190<=WDATA;
    end
end

// int_lsc_register_GrGain_V_191[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_GrGain_V_191<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_GRGAIN_V_191)
            int_lsc_register_GrGain_V_191<=WDATA;
    end
end

// int_lsc_register_GrGain_V_192[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_GrGain_V_192<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_GRGAIN_V_192)
            int_lsc_register_GrGain_V_192<=WDATA;
    end
end

// int_lsc_register_GrGain_V_193[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_GrGain_V_193<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_GRGAIN_V_193)
            int_lsc_register_GrGain_V_193<=WDATA;
    end
end

// int_lsc_register_GrGain_V_194[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_GrGain_V_194<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_GRGAIN_V_194)
            int_lsc_register_GrGain_V_194<=WDATA;
    end
end

// int_lsc_register_GrGain_V_195[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_GrGain_V_195<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_GRGAIN_V_195)
            int_lsc_register_GrGain_V_195<=WDATA;
    end
end

// int_lsc_register_GrGain_V_196[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_GrGain_V_196<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_GRGAIN_V_196)
            int_lsc_register_GrGain_V_196<=WDATA;
    end
end

// int_lsc_register_GrGain_V_197[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_GrGain_V_197<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_GRGAIN_V_197)
            int_lsc_register_GrGain_V_197<=WDATA;
    end
end

// int_lsc_register_GrGain_V_198[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_GrGain_V_198<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_GRGAIN_V_198)
            int_lsc_register_GrGain_V_198<=WDATA;
    end
end

// int_lsc_register_GrGain_V_199[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_GrGain_V_199<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_GRGAIN_V_199)
            int_lsc_register_GrGain_V_199<=WDATA;
    end
end

// int_lsc_register_GrGain_V_200[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_GrGain_V_200<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_GRGAIN_V_200)
            int_lsc_register_GrGain_V_200<=WDATA;
    end
end

// int_lsc_register_GrGain_V_201[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_GrGain_V_201<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_GRGAIN_V_201)
            int_lsc_register_GrGain_V_201<=WDATA;
    end
end

// int_lsc_register_GrGain_V_202[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_GrGain_V_202<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_GRGAIN_V_202)
            int_lsc_register_GrGain_V_202<=WDATA;
    end
end

// int_lsc_register_GrGain_V_203[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_GrGain_V_203<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_GRGAIN_V_203)
            int_lsc_register_GrGain_V_203<=WDATA;
    end
end

// int_lsc_register_GrGain_V_204[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_GrGain_V_204<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_GRGAIN_V_204)
            int_lsc_register_GrGain_V_204<=WDATA;
    end
end

// int_lsc_register_GrGain_V_205[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_GrGain_V_205<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_GRGAIN_V_205)
            int_lsc_register_GrGain_V_205<=WDATA;
    end
end

// int_lsc_register_GrGain_V_206[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_GrGain_V_206<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_GRGAIN_V_206)
            int_lsc_register_GrGain_V_206<=WDATA;
    end
end

// int_lsc_register_GrGain_V_207[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_GrGain_V_207<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_GRGAIN_V_207)
            int_lsc_register_GrGain_V_207<=WDATA;
    end
end

// int_lsc_register_GrGain_V_208[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_GrGain_V_208<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_GRGAIN_V_208)
            int_lsc_register_GrGain_V_208<=WDATA;
    end
end

// int_lsc_register_GrGain_V_209[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_GrGain_V_209<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_GRGAIN_V_209)
            int_lsc_register_GrGain_V_209<=WDATA;
    end
end

// int_lsc_register_GrGain_V_210[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_GrGain_V_210<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_GRGAIN_V_210)
            int_lsc_register_GrGain_V_210<=WDATA;
    end
end

// int_lsc_register_GrGain_V_211[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_GrGain_V_211<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_GRGAIN_V_211)
            int_lsc_register_GrGain_V_211<=WDATA;
    end
end

// int_lsc_register_GrGain_V_212[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_GrGain_V_212<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_GRGAIN_V_212)
            int_lsc_register_GrGain_V_212<=WDATA;
    end
end

// int_lsc_register_GrGain_V_213[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_GrGain_V_213<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_GRGAIN_V_213)
            int_lsc_register_GrGain_V_213<=WDATA;
    end
end

// int_lsc_register_GrGain_V_214[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_GrGain_V_214<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_GRGAIN_V_214)
            int_lsc_register_GrGain_V_214<=WDATA;
    end
end

// int_lsc_register_GrGain_V_215[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_GrGain_V_215<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_GRGAIN_V_215)
            int_lsc_register_GrGain_V_215<=WDATA;
    end
end

// int_lsc_register_GrGain_V_216[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_GrGain_V_216<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_GRGAIN_V_216)
            int_lsc_register_GrGain_V_216<=WDATA;
    end
end

// int_lsc_register_GrGain_V_217[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_GrGain_V_217<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_GRGAIN_V_217)
            int_lsc_register_GrGain_V_217<=WDATA;
    end
end

// int_lsc_register_GrGain_V_218[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_GrGain_V_218<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_GRGAIN_V_218)
            int_lsc_register_GrGain_V_218<=WDATA;
    end
end

// int_lsc_register_GrGain_V_219[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_GrGain_V_219<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_GRGAIN_V_219)
            int_lsc_register_GrGain_V_219<=WDATA;
    end
end

// int_lsc_register_GrGain_V_220[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_GrGain_V_220<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_GRGAIN_V_220)
            int_lsc_register_GrGain_V_220<=WDATA;
    end
end

// int_lsc_register_GbGain_V_0[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_GbGain_V_0<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_GBGAIN_V_0)
            int_lsc_register_GbGain_V_0<=WDATA;
    end
end

// int_lsc_register_GbGain_V_1[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_GbGain_V_1<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_GBGAIN_V_1)
            int_lsc_register_GbGain_V_1<=WDATA;
    end
end

// int_lsc_register_GbGain_V_2[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_GbGain_V_2<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_GBGAIN_V_2)
            int_lsc_register_GbGain_V_2<=WDATA;
    end
end

// int_lsc_register_GbGain_V_3[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_GbGain_V_3<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_GBGAIN_V_3)
            int_lsc_register_GbGain_V_3<=WDATA;
    end
end

// int_lsc_register_GbGain_V_4[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_GbGain_V_4<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_GBGAIN_V_4)
            int_lsc_register_GbGain_V_4<=WDATA;
    end
end

// int_lsc_register_GbGain_V_5[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_GbGain_V_5<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_GBGAIN_V_5)
            int_lsc_register_GbGain_V_5<=WDATA;
    end
end

// int_lsc_register_GbGain_V_6[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_GbGain_V_6<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_GBGAIN_V_6)
            int_lsc_register_GbGain_V_6<=WDATA;
    end
end

// int_lsc_register_GbGain_V_7[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_GbGain_V_7<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_GBGAIN_V_7)
            int_lsc_register_GbGain_V_7<=WDATA;
    end
end

// int_lsc_register_GbGain_V_8[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_GbGain_V_8<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_GBGAIN_V_8)
            int_lsc_register_GbGain_V_8<=WDATA;
    end
end

// int_lsc_register_GbGain_V_9[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_GbGain_V_9<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_GBGAIN_V_9)
            int_lsc_register_GbGain_V_9<=WDATA;
    end
end

// int_lsc_register_GbGain_V_10[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_GbGain_V_10<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_GBGAIN_V_10)
            int_lsc_register_GbGain_V_10<=WDATA;
    end
end

// int_lsc_register_GbGain_V_11[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_GbGain_V_11<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_GBGAIN_V_11)
            int_lsc_register_GbGain_V_11<=WDATA;
    end
end

// int_lsc_register_GbGain_V_12[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_GbGain_V_12<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_GBGAIN_V_12)
            int_lsc_register_GbGain_V_12<=WDATA;
    end
end

// int_lsc_register_GbGain_V_13[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_GbGain_V_13<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_GBGAIN_V_13)
            int_lsc_register_GbGain_V_13<=WDATA;
    end
end

// int_lsc_register_GbGain_V_14[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_GbGain_V_14<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_GBGAIN_V_14)
            int_lsc_register_GbGain_V_14<=WDATA;
    end
end

// int_lsc_register_GbGain_V_15[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_GbGain_V_15<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_GBGAIN_V_15)
            int_lsc_register_GbGain_V_15<=WDATA;
    end
end

// int_lsc_register_GbGain_V_16[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_GbGain_V_16<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_GBGAIN_V_16)
            int_lsc_register_GbGain_V_16<=WDATA;
    end
end

// int_lsc_register_GbGain_V_17[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_GbGain_V_17<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_GBGAIN_V_17)
            int_lsc_register_GbGain_V_17<=WDATA;
    end
end

// int_lsc_register_GbGain_V_18[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_GbGain_V_18<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_GBGAIN_V_18)
            int_lsc_register_GbGain_V_18<=WDATA;
    end
end

// int_lsc_register_GbGain_V_19[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_GbGain_V_19<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_GBGAIN_V_19)
            int_lsc_register_GbGain_V_19<=WDATA;
    end
end

// int_lsc_register_GbGain_V_20[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_GbGain_V_20<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_GBGAIN_V_20)
            int_lsc_register_GbGain_V_20<=WDATA;
    end
end

// int_lsc_register_GbGain_V_21[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_GbGain_V_21<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_GBGAIN_V_21)
            int_lsc_register_GbGain_V_21<=WDATA;
    end
end

// int_lsc_register_GbGain_V_22[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_GbGain_V_22<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_GBGAIN_V_22)
            int_lsc_register_GbGain_V_22<=WDATA;
    end
end

// int_lsc_register_GbGain_V_23[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_GbGain_V_23<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_GBGAIN_V_23)
            int_lsc_register_GbGain_V_23<=WDATA;
    end
end

// int_lsc_register_GbGain_V_24[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_GbGain_V_24<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_GBGAIN_V_24)
            int_lsc_register_GbGain_V_24<=WDATA;
    end
end

// int_lsc_register_GbGain_V_25[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_GbGain_V_25<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_GBGAIN_V_25)
            int_lsc_register_GbGain_V_25<=WDATA;
    end
end

// int_lsc_register_GbGain_V_26[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_GbGain_V_26<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_GBGAIN_V_26)
            int_lsc_register_GbGain_V_26<=WDATA;
    end
end

// int_lsc_register_GbGain_V_27[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_GbGain_V_27<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_GBGAIN_V_27)
            int_lsc_register_GbGain_V_27<=WDATA;
    end
end

// int_lsc_register_GbGain_V_28[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_GbGain_V_28<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_GBGAIN_V_28)
            int_lsc_register_GbGain_V_28<=WDATA;
    end
end

// int_lsc_register_GbGain_V_29[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_GbGain_V_29<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_GBGAIN_V_29)
            int_lsc_register_GbGain_V_29<=WDATA;
    end
end

// int_lsc_register_GbGain_V_30[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_GbGain_V_30<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_GBGAIN_V_30)
            int_lsc_register_GbGain_V_30<=WDATA;
    end
end

// int_lsc_register_GbGain_V_31[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_GbGain_V_31<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_GBGAIN_V_31)
            int_lsc_register_GbGain_V_31<=WDATA;
    end
end

// int_lsc_register_GbGain_V_32[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_GbGain_V_32<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_GBGAIN_V_32)
            int_lsc_register_GbGain_V_32<=WDATA;
    end
end

// int_lsc_register_GbGain_V_33[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_GbGain_V_33<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_GBGAIN_V_33)
            int_lsc_register_GbGain_V_33<=WDATA;
    end
end

// int_lsc_register_GbGain_V_34[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_GbGain_V_34<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_GBGAIN_V_34)
            int_lsc_register_GbGain_V_34<=WDATA;
    end
end

// int_lsc_register_GbGain_V_35[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_GbGain_V_35<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_GBGAIN_V_35)
            int_lsc_register_GbGain_V_35<=WDATA;
    end
end

// int_lsc_register_GbGain_V_36[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_GbGain_V_36<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_GBGAIN_V_36)
            int_lsc_register_GbGain_V_36<=WDATA;
    end
end

// int_lsc_register_GbGain_V_37[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_GbGain_V_37<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_GBGAIN_V_37)
            int_lsc_register_GbGain_V_37<=WDATA;
    end
end

// int_lsc_register_GbGain_V_38[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_GbGain_V_38<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_GBGAIN_V_38)
            int_lsc_register_GbGain_V_38<=WDATA;
    end
end

// int_lsc_register_GbGain_V_39[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_GbGain_V_39<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_GBGAIN_V_39)
            int_lsc_register_GbGain_V_39<=WDATA;
    end
end

// int_lsc_register_GbGain_V_40[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_GbGain_V_40<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_GBGAIN_V_40)
            int_lsc_register_GbGain_V_40<=WDATA;
    end
end

// int_lsc_register_GbGain_V_41[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_GbGain_V_41<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_GBGAIN_V_41)
            int_lsc_register_GbGain_V_41<=WDATA;
    end
end

// int_lsc_register_GbGain_V_42[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_GbGain_V_42<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_GBGAIN_V_42)
            int_lsc_register_GbGain_V_42<=WDATA;
    end
end

// int_lsc_register_GbGain_V_43[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_GbGain_V_43<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_GBGAIN_V_43)
            int_lsc_register_GbGain_V_43<=WDATA;
    end
end

// int_lsc_register_GbGain_V_44[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_GbGain_V_44<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_GBGAIN_V_44)
            int_lsc_register_GbGain_V_44<=WDATA;
    end
end

// int_lsc_register_GbGain_V_45[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_GbGain_V_45<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_GBGAIN_V_45)
            int_lsc_register_GbGain_V_45<=WDATA;
    end
end

// int_lsc_register_GbGain_V_46[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_GbGain_V_46<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_GBGAIN_V_46)
            int_lsc_register_GbGain_V_46<=WDATA;
    end
end

// int_lsc_register_GbGain_V_47[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_GbGain_V_47<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_GBGAIN_V_47)
            int_lsc_register_GbGain_V_47<=WDATA;
    end
end

// int_lsc_register_GbGain_V_48[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_GbGain_V_48<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_GBGAIN_V_48)
            int_lsc_register_GbGain_V_48<=WDATA;
    end
end

// int_lsc_register_GbGain_V_49[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_GbGain_V_49<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_GBGAIN_V_49)
            int_lsc_register_GbGain_V_49<=WDATA;
    end
end

// int_lsc_register_GbGain_V_50[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_GbGain_V_50<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_GBGAIN_V_50)
            int_lsc_register_GbGain_V_50<=WDATA;
    end
end

// int_lsc_register_GbGain_V_51[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_GbGain_V_51<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_GBGAIN_V_51)
            int_lsc_register_GbGain_V_51<=WDATA;
    end
end

// int_lsc_register_GbGain_V_52[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_GbGain_V_52<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_GBGAIN_V_52)
            int_lsc_register_GbGain_V_52<=WDATA;
    end
end

// int_lsc_register_GbGain_V_53[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_GbGain_V_53<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_GBGAIN_V_53)
            int_lsc_register_GbGain_V_53<=WDATA;
    end
end

// int_lsc_register_GbGain_V_54[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_GbGain_V_54<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_GBGAIN_V_54)
            int_lsc_register_GbGain_V_54<=WDATA;
    end
end

// int_lsc_register_GbGain_V_55[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_GbGain_V_55<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_GBGAIN_V_55)
            int_lsc_register_GbGain_V_55<=WDATA;
    end
end

// int_lsc_register_GbGain_V_56[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_GbGain_V_56<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_GBGAIN_V_56)
            int_lsc_register_GbGain_V_56<=WDATA;
    end
end

// int_lsc_register_GbGain_V_57[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_GbGain_V_57<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_GBGAIN_V_57)
            int_lsc_register_GbGain_V_57<=WDATA;
    end
end

// int_lsc_register_GbGain_V_58[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_GbGain_V_58<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_GBGAIN_V_58)
            int_lsc_register_GbGain_V_58<=WDATA;
    end
end

// int_lsc_register_GbGain_V_59[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_GbGain_V_59<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_GBGAIN_V_59)
            int_lsc_register_GbGain_V_59<=WDATA;
    end
end

// int_lsc_register_GbGain_V_60[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_GbGain_V_60<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_GBGAIN_V_60)
            int_lsc_register_GbGain_V_60<=WDATA;
    end
end

// int_lsc_register_GbGain_V_61[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_GbGain_V_61<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_GBGAIN_V_61)
            int_lsc_register_GbGain_V_61<=WDATA;
    end
end

// int_lsc_register_GbGain_V_62[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_GbGain_V_62<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_GBGAIN_V_62)
            int_lsc_register_GbGain_V_62<=WDATA;
    end
end

// int_lsc_register_GbGain_V_63[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_GbGain_V_63<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_GBGAIN_V_63)
            int_lsc_register_GbGain_V_63<=WDATA;
    end
end

// int_lsc_register_GbGain_V_64[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_GbGain_V_64<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_GBGAIN_V_64)
            int_lsc_register_GbGain_V_64<=WDATA;
    end
end

// int_lsc_register_GbGain_V_65[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_GbGain_V_65<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_GBGAIN_V_65)
            int_lsc_register_GbGain_V_65<=WDATA;
    end
end

// int_lsc_register_GbGain_V_66[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_GbGain_V_66<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_GBGAIN_V_66)
            int_lsc_register_GbGain_V_66<=WDATA;
    end
end

// int_lsc_register_GbGain_V_67[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_GbGain_V_67<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_GBGAIN_V_67)
            int_lsc_register_GbGain_V_67<=WDATA;
    end
end

// int_lsc_register_GbGain_V_68[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_GbGain_V_68<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_GBGAIN_V_68)
            int_lsc_register_GbGain_V_68<=WDATA;
    end
end

// int_lsc_register_GbGain_V_69[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_GbGain_V_69<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_GBGAIN_V_69)
            int_lsc_register_GbGain_V_69<=WDATA;
    end
end

// int_lsc_register_GbGain_V_70[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_GbGain_V_70<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_GBGAIN_V_70)
            int_lsc_register_GbGain_V_70<=WDATA;
    end
end

// int_lsc_register_GbGain_V_71[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_GbGain_V_71<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_GBGAIN_V_71)
            int_lsc_register_GbGain_V_71<=WDATA;
    end
end

// int_lsc_register_GbGain_V_72[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_GbGain_V_72<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_GBGAIN_V_72)
            int_lsc_register_GbGain_V_72<=WDATA;
    end
end

// int_lsc_register_GbGain_V_73[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_GbGain_V_73<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_GBGAIN_V_73)
            int_lsc_register_GbGain_V_73<=WDATA;
    end
end

// int_lsc_register_GbGain_V_74[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_GbGain_V_74<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_GBGAIN_V_74)
            int_lsc_register_GbGain_V_74<=WDATA;
    end
end

// int_lsc_register_GbGain_V_75[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_GbGain_V_75<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_GBGAIN_V_75)
            int_lsc_register_GbGain_V_75<=WDATA;
    end
end

// int_lsc_register_GbGain_V_76[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_GbGain_V_76<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_GBGAIN_V_76)
            int_lsc_register_GbGain_V_76<=WDATA;
    end
end

// int_lsc_register_GbGain_V_77[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_GbGain_V_77<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_GBGAIN_V_77)
            int_lsc_register_GbGain_V_77<=WDATA;
    end
end

// int_lsc_register_GbGain_V_78[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_GbGain_V_78<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_GBGAIN_V_78)
            int_lsc_register_GbGain_V_78<=WDATA;
    end
end

// int_lsc_register_GbGain_V_79[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_GbGain_V_79<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_GBGAIN_V_79)
            int_lsc_register_GbGain_V_79<=WDATA;
    end
end

// int_lsc_register_GbGain_V_80[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_GbGain_V_80<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_GBGAIN_V_80)
            int_lsc_register_GbGain_V_80<=WDATA;
    end
end

// int_lsc_register_GbGain_V_81[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_GbGain_V_81<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_GBGAIN_V_81)
            int_lsc_register_GbGain_V_81<=WDATA;
    end
end

// int_lsc_register_GbGain_V_82[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_GbGain_V_82<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_GBGAIN_V_82)
            int_lsc_register_GbGain_V_82<=WDATA;
    end
end

// int_lsc_register_GbGain_V_83[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_GbGain_V_83<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_GBGAIN_V_83)
            int_lsc_register_GbGain_V_83<=WDATA;
    end
end

// int_lsc_register_GbGain_V_84[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_GbGain_V_84<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_GBGAIN_V_84)
            int_lsc_register_GbGain_V_84<=WDATA;
    end
end

// int_lsc_register_GbGain_V_85[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_GbGain_V_85<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_GBGAIN_V_85)
            int_lsc_register_GbGain_V_85<=WDATA;
    end
end

// int_lsc_register_GbGain_V_86[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_GbGain_V_86<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_GBGAIN_V_86)
            int_lsc_register_GbGain_V_86<=WDATA;
    end
end

// int_lsc_register_GbGain_V_87[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_GbGain_V_87<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_GBGAIN_V_87)
            int_lsc_register_GbGain_V_87<=WDATA;
    end
end

// int_lsc_register_GbGain_V_88[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_GbGain_V_88<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_GBGAIN_V_88)
            int_lsc_register_GbGain_V_88<=WDATA;
    end
end

// int_lsc_register_GbGain_V_89[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_GbGain_V_89<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_GBGAIN_V_89)
            int_lsc_register_GbGain_V_89<=WDATA;
    end
end

// int_lsc_register_GbGain_V_90[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_GbGain_V_90<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_GBGAIN_V_90)
            int_lsc_register_GbGain_V_90<=WDATA;
    end
end

// int_lsc_register_GbGain_V_91[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_GbGain_V_91<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_GBGAIN_V_91)
            int_lsc_register_GbGain_V_91<=WDATA;
    end
end

// int_lsc_register_GbGain_V_92[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_GbGain_V_92<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_GBGAIN_V_92)
            int_lsc_register_GbGain_V_92<=WDATA;
    end
end

// int_lsc_register_GbGain_V_93[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_GbGain_V_93<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_GBGAIN_V_93)
            int_lsc_register_GbGain_V_93<=WDATA;
    end
end

// int_lsc_register_GbGain_V_94[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_GbGain_V_94<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_GBGAIN_V_94)
            int_lsc_register_GbGain_V_94<=WDATA;
    end
end

// int_lsc_register_GbGain_V_95[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_GbGain_V_95<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_GBGAIN_V_95)
            int_lsc_register_GbGain_V_95<=WDATA;
    end
end

// int_lsc_register_GbGain_V_96[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_GbGain_V_96<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_GBGAIN_V_96)
            int_lsc_register_GbGain_V_96<=WDATA;
    end
end

// int_lsc_register_GbGain_V_97[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_GbGain_V_97<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_GBGAIN_V_97)
            int_lsc_register_GbGain_V_97<=WDATA;
    end
end

// int_lsc_register_GbGain_V_98[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_GbGain_V_98<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_GBGAIN_V_98)
            int_lsc_register_GbGain_V_98<=WDATA;
    end
end

// int_lsc_register_GbGain_V_99[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_GbGain_V_99<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_GBGAIN_V_99)
            int_lsc_register_GbGain_V_99<=WDATA;
    end
end

// int_lsc_register_GbGain_V_100[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_GbGain_V_100<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_GBGAIN_V_100)
            int_lsc_register_GbGain_V_100<=WDATA;
    end
end

// int_lsc_register_GbGain_V_101[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_GbGain_V_101<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_GBGAIN_V_101)
            int_lsc_register_GbGain_V_101<=WDATA;
    end
end

// int_lsc_register_GbGain_V_102[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_GbGain_V_102<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_GBGAIN_V_102)
            int_lsc_register_GbGain_V_102<=WDATA;
    end
end

// int_lsc_register_GbGain_V_103[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_GbGain_V_103<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_GBGAIN_V_103)
            int_lsc_register_GbGain_V_103<=WDATA;
    end
end

// int_lsc_register_GbGain_V_104[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_GbGain_V_104<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_GBGAIN_V_104)
            int_lsc_register_GbGain_V_104<=WDATA;
    end
end

// int_lsc_register_GbGain_V_105[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_GbGain_V_105<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_GBGAIN_V_105)
            int_lsc_register_GbGain_V_105<=WDATA;
    end
end

// int_lsc_register_GbGain_V_106[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_GbGain_V_106<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_GBGAIN_V_106)
            int_lsc_register_GbGain_V_106<=WDATA;
    end
end

// int_lsc_register_GbGain_V_107[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_GbGain_V_107<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_GBGAIN_V_107)
            int_lsc_register_GbGain_V_107<=WDATA;
    end
end

// int_lsc_register_GbGain_V_108[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_GbGain_V_108<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_GBGAIN_V_108)
            int_lsc_register_GbGain_V_108<=WDATA;
    end
end

// int_lsc_register_GbGain_V_109[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_GbGain_V_109<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_GBGAIN_V_109)
            int_lsc_register_GbGain_V_109<=WDATA;
    end
end

// int_lsc_register_GbGain_V_110[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_GbGain_V_110<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_GBGAIN_V_110)
            int_lsc_register_GbGain_V_110<=WDATA;
    end
end

// int_lsc_register_GbGain_V_111[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_GbGain_V_111<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_GBGAIN_V_111)
            int_lsc_register_GbGain_V_111<=WDATA;
    end
end

// int_lsc_register_GbGain_V_112[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_GbGain_V_112<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_GBGAIN_V_112)
            int_lsc_register_GbGain_V_112<=WDATA;
    end
end

// int_lsc_register_GbGain_V_113[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_GbGain_V_113<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_GBGAIN_V_113)
            int_lsc_register_GbGain_V_113<=WDATA;
    end
end

// int_lsc_register_GbGain_V_114[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_GbGain_V_114<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_GBGAIN_V_114)
            int_lsc_register_GbGain_V_114<=WDATA;
    end
end

// int_lsc_register_GbGain_V_115[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_GbGain_V_115<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_GBGAIN_V_115)
            int_lsc_register_GbGain_V_115<=WDATA;
    end
end

// int_lsc_register_GbGain_V_116[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_GbGain_V_116<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_GBGAIN_V_116)
            int_lsc_register_GbGain_V_116<=WDATA;
    end
end

// int_lsc_register_GbGain_V_117[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_GbGain_V_117<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_GBGAIN_V_117)
            int_lsc_register_GbGain_V_117<=WDATA;
    end
end

// int_lsc_register_GbGain_V_118[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_GbGain_V_118<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_GBGAIN_V_118)
            int_lsc_register_GbGain_V_118<=WDATA;
    end
end

// int_lsc_register_GbGain_V_119[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_GbGain_V_119<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_GBGAIN_V_119)
            int_lsc_register_GbGain_V_119<=WDATA;
    end
end

// int_lsc_register_GbGain_V_120[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_GbGain_V_120<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_GBGAIN_V_120)
            int_lsc_register_GbGain_V_120<=WDATA;
    end
end

// int_lsc_register_GbGain_V_121[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_GbGain_V_121<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_GBGAIN_V_121)
            int_lsc_register_GbGain_V_121<=WDATA;
    end
end

// int_lsc_register_GbGain_V_122[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_GbGain_V_122<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_GBGAIN_V_122)
            int_lsc_register_GbGain_V_122<=WDATA;
    end
end

// int_lsc_register_GbGain_V_123[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_GbGain_V_123<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_GBGAIN_V_123)
            int_lsc_register_GbGain_V_123<=WDATA;
    end
end

// int_lsc_register_GbGain_V_124[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_GbGain_V_124<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_GBGAIN_V_124)
            int_lsc_register_GbGain_V_124<=WDATA;
    end
end

// int_lsc_register_GbGain_V_125[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_GbGain_V_125<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_GBGAIN_V_125)
            int_lsc_register_GbGain_V_125<=WDATA;
    end
end

// int_lsc_register_GbGain_V_126[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_GbGain_V_126<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_GBGAIN_V_126)
            int_lsc_register_GbGain_V_126<=WDATA;
    end
end

// int_lsc_register_GbGain_V_127[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_GbGain_V_127<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_GBGAIN_V_127)
            int_lsc_register_GbGain_V_127<=WDATA;
    end
end

// int_lsc_register_GbGain_V_128[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_GbGain_V_128<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_GBGAIN_V_128)
            int_lsc_register_GbGain_V_128<=WDATA;
    end
end

// int_lsc_register_GbGain_V_129[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_GbGain_V_129<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_GBGAIN_V_129)
            int_lsc_register_GbGain_V_129<=WDATA;
    end
end

// int_lsc_register_GbGain_V_130[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_GbGain_V_130<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_GBGAIN_V_130)
            int_lsc_register_GbGain_V_130<=WDATA;
    end
end

// int_lsc_register_GbGain_V_131[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_GbGain_V_131<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_GBGAIN_V_131)
            int_lsc_register_GbGain_V_131<=WDATA;
    end
end

// int_lsc_register_GbGain_V_132[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_GbGain_V_132<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_GBGAIN_V_132)
            int_lsc_register_GbGain_V_132<=WDATA;
    end
end

// int_lsc_register_GbGain_V_133[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_GbGain_V_133<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_GBGAIN_V_133)
            int_lsc_register_GbGain_V_133<=WDATA;
    end
end

// int_lsc_register_GbGain_V_134[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_GbGain_V_134<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_GBGAIN_V_134)
            int_lsc_register_GbGain_V_134<=WDATA;
    end
end

// int_lsc_register_GbGain_V_135[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_GbGain_V_135<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_GBGAIN_V_135)
            int_lsc_register_GbGain_V_135<=WDATA;
    end
end

// int_lsc_register_GbGain_V_136[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_GbGain_V_136<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_GBGAIN_V_136)
            int_lsc_register_GbGain_V_136<=WDATA;
    end
end

// int_lsc_register_GbGain_V_137[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_GbGain_V_137<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_GBGAIN_V_137)
            int_lsc_register_GbGain_V_137<=WDATA;
    end
end

// int_lsc_register_GbGain_V_138[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_GbGain_V_138<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_GBGAIN_V_138)
            int_lsc_register_GbGain_V_138<=WDATA;
    end
end

// int_lsc_register_GbGain_V_139[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_GbGain_V_139<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_GBGAIN_V_139)
            int_lsc_register_GbGain_V_139<=WDATA;
    end
end

// int_lsc_register_GbGain_V_140[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_GbGain_V_140<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_GBGAIN_V_140)
            int_lsc_register_GbGain_V_140<=WDATA;
    end
end

// int_lsc_register_GbGain_V_141[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_GbGain_V_141<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_GBGAIN_V_141)
            int_lsc_register_GbGain_V_141<=WDATA;
    end
end

// int_lsc_register_GbGain_V_142[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_GbGain_V_142<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_GBGAIN_V_142)
            int_lsc_register_GbGain_V_142<=WDATA;
    end
end

// int_lsc_register_GbGain_V_143[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_GbGain_V_143<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_GBGAIN_V_143)
            int_lsc_register_GbGain_V_143<=WDATA;
    end
end

// int_lsc_register_GbGain_V_144[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_GbGain_V_144<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_GBGAIN_V_144)
            int_lsc_register_GbGain_V_144<=WDATA;
    end
end

// int_lsc_register_GbGain_V_145[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_GbGain_V_145<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_GBGAIN_V_145)
            int_lsc_register_GbGain_V_145<=WDATA;
    end
end

// int_lsc_register_GbGain_V_146[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_GbGain_V_146<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_GBGAIN_V_146)
            int_lsc_register_GbGain_V_146<=WDATA;
    end
end

// int_lsc_register_GbGain_V_147[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_GbGain_V_147<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_GBGAIN_V_147)
            int_lsc_register_GbGain_V_147<=WDATA;
    end
end

// int_lsc_register_GbGain_V_148[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_GbGain_V_148<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_GBGAIN_V_148)
            int_lsc_register_GbGain_V_148<=WDATA;
    end
end

// int_lsc_register_GbGain_V_149[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_GbGain_V_149<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_GBGAIN_V_149)
            int_lsc_register_GbGain_V_149<=WDATA;
    end
end

// int_lsc_register_GbGain_V_150[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_GbGain_V_150<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_GBGAIN_V_150)
            int_lsc_register_GbGain_V_150<=WDATA;
    end
end

// int_lsc_register_GbGain_V_151[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_GbGain_V_151<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_GBGAIN_V_151)
            int_lsc_register_GbGain_V_151<=WDATA;
    end
end

// int_lsc_register_GbGain_V_152[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_GbGain_V_152<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_GBGAIN_V_152)
            int_lsc_register_GbGain_V_152<=WDATA;
    end
end

// int_lsc_register_GbGain_V_153[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_GbGain_V_153<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_GBGAIN_V_153)
            int_lsc_register_GbGain_V_153<=WDATA;
    end
end

// int_lsc_register_GbGain_V_154[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_GbGain_V_154<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_GBGAIN_V_154)
            int_lsc_register_GbGain_V_154<=WDATA;
    end
end

// int_lsc_register_GbGain_V_155[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_GbGain_V_155<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_GBGAIN_V_155)
            int_lsc_register_GbGain_V_155<=WDATA;
    end
end

// int_lsc_register_GbGain_V_156[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_GbGain_V_156<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_GBGAIN_V_156)
            int_lsc_register_GbGain_V_156<=WDATA;
    end
end

// int_lsc_register_GbGain_V_157[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_GbGain_V_157<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_GBGAIN_V_157)
            int_lsc_register_GbGain_V_157<=WDATA;
    end
end

// int_lsc_register_GbGain_V_158[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_GbGain_V_158<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_GBGAIN_V_158)
            int_lsc_register_GbGain_V_158<=WDATA;
    end
end

// int_lsc_register_GbGain_V_159[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_GbGain_V_159<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_GBGAIN_V_159)
            int_lsc_register_GbGain_V_159<=WDATA;
    end
end

// int_lsc_register_GbGain_V_160[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_GbGain_V_160<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_GBGAIN_V_160)
            int_lsc_register_GbGain_V_160<=WDATA;
    end
end

// int_lsc_register_GbGain_V_161[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_GbGain_V_161<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_GBGAIN_V_161)
            int_lsc_register_GbGain_V_161<=WDATA;
    end
end

// int_lsc_register_GbGain_V_162[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_GbGain_V_162<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_GBGAIN_V_162)
            int_lsc_register_GbGain_V_162<=WDATA;
    end
end

// int_lsc_register_GbGain_V_163[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_GbGain_V_163<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_GBGAIN_V_163)
            int_lsc_register_GbGain_V_163<=WDATA;
    end
end

// int_lsc_register_GbGain_V_164[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_GbGain_V_164<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_GBGAIN_V_164)
            int_lsc_register_GbGain_V_164<=WDATA;
    end
end

// int_lsc_register_GbGain_V_165[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_GbGain_V_165<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_GBGAIN_V_165)
            int_lsc_register_GbGain_V_165<=WDATA;
    end
end

// int_lsc_register_GbGain_V_166[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_GbGain_V_166<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_GBGAIN_V_166)
            int_lsc_register_GbGain_V_166<=WDATA;
    end
end

// int_lsc_register_GbGain_V_167[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_GbGain_V_167<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_GBGAIN_V_167)
            int_lsc_register_GbGain_V_167<=WDATA;
    end
end

// int_lsc_register_GbGain_V_168[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_GbGain_V_168<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_GBGAIN_V_168)
            int_lsc_register_GbGain_V_168<=WDATA;
    end
end

// int_lsc_register_GbGain_V_169[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_GbGain_V_169<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_GBGAIN_V_169)
            int_lsc_register_GbGain_V_169<=WDATA;
    end
end

// int_lsc_register_GbGain_V_170[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_GbGain_V_170<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_GBGAIN_V_170)
            int_lsc_register_GbGain_V_170<=WDATA;
    end
end

// int_lsc_register_GbGain_V_171[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_GbGain_V_171<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_GBGAIN_V_171)
            int_lsc_register_GbGain_V_171<=WDATA;
    end
end

// int_lsc_register_GbGain_V_172[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_GbGain_V_172<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_GBGAIN_V_172)
            int_lsc_register_GbGain_V_172<=WDATA;
    end
end

// int_lsc_register_GbGain_V_173[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_GbGain_V_173<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_GBGAIN_V_173)
            int_lsc_register_GbGain_V_173<=WDATA;
    end
end

// int_lsc_register_GbGain_V_174[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_GbGain_V_174<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_GBGAIN_V_174)
            int_lsc_register_GbGain_V_174<=WDATA;
    end
end

// int_lsc_register_GbGain_V_175[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_GbGain_V_175<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_GBGAIN_V_175)
            int_lsc_register_GbGain_V_175<=WDATA;
    end
end

// int_lsc_register_GbGain_V_176[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_GbGain_V_176<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_GBGAIN_V_176)
            int_lsc_register_GbGain_V_176<=WDATA;
    end
end

// int_lsc_register_GbGain_V_177[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_GbGain_V_177<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_GBGAIN_V_177)
            int_lsc_register_GbGain_V_177<=WDATA;
    end
end

// int_lsc_register_GbGain_V_178[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_GbGain_V_178<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_GBGAIN_V_178)
            int_lsc_register_GbGain_V_178<=WDATA;
    end
end

// int_lsc_register_GbGain_V_179[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_GbGain_V_179<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_GBGAIN_V_179)
            int_lsc_register_GbGain_V_179<=WDATA;
    end
end

// int_lsc_register_GbGain_V_180[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_GbGain_V_180<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_GBGAIN_V_180)
            int_lsc_register_GbGain_V_180<=WDATA;
    end
end

// int_lsc_register_GbGain_V_181[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_GbGain_V_181<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_GBGAIN_V_181)
            int_lsc_register_GbGain_V_181<=WDATA;
    end
end

// int_lsc_register_GbGain_V_182[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_GbGain_V_182<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_GBGAIN_V_182)
            int_lsc_register_GbGain_V_182<=WDATA;
    end
end

// int_lsc_register_GbGain_V_183[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_GbGain_V_183<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_GBGAIN_V_183)
            int_lsc_register_GbGain_V_183<=WDATA;
    end
end

// int_lsc_register_GbGain_V_184[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_GbGain_V_184<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_GBGAIN_V_184)
            int_lsc_register_GbGain_V_184<=WDATA;
    end
end

// int_lsc_register_GbGain_V_185[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_GbGain_V_185<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_GBGAIN_V_185)
            int_lsc_register_GbGain_V_185<=WDATA;
    end
end

// int_lsc_register_GbGain_V_186[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_GbGain_V_186<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_GBGAIN_V_186)
            int_lsc_register_GbGain_V_186<=WDATA;
    end
end

// int_lsc_register_GbGain_V_187[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_GbGain_V_187<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_GBGAIN_V_187)
            int_lsc_register_GbGain_V_187<=WDATA;
    end
end

// int_lsc_register_GbGain_V_188[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_GbGain_V_188<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_GBGAIN_V_188)
            int_lsc_register_GbGain_V_188<=WDATA;
    end
end

// int_lsc_register_GbGain_V_189[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_GbGain_V_189<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_GBGAIN_V_189)
            int_lsc_register_GbGain_V_189<=WDATA;
    end
end

// int_lsc_register_GbGain_V_190[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_GbGain_V_190<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_GBGAIN_V_190)
            int_lsc_register_GbGain_V_190<=WDATA;
    end
end

// int_lsc_register_GbGain_V_191[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_GbGain_V_191<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_GBGAIN_V_191)
            int_lsc_register_GbGain_V_191<=WDATA;
    end
end

// int_lsc_register_GbGain_V_192[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_GbGain_V_192<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_GBGAIN_V_192)
            int_lsc_register_GbGain_V_192<=WDATA;
    end
end

// int_lsc_register_GbGain_V_193[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_GbGain_V_193<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_GBGAIN_V_193)
            int_lsc_register_GbGain_V_193<=WDATA;
    end
end

// int_lsc_register_GbGain_V_194[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_GbGain_V_194<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_GBGAIN_V_194)
            int_lsc_register_GbGain_V_194<=WDATA;
    end
end

// int_lsc_register_GbGain_V_195[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_GbGain_V_195<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_GBGAIN_V_195)
            int_lsc_register_GbGain_V_195<=WDATA;
    end
end

// int_lsc_register_GbGain_V_196[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_GbGain_V_196<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_GBGAIN_V_196)
            int_lsc_register_GbGain_V_196<=WDATA;
    end
end

// int_lsc_register_GbGain_V_197[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_GbGain_V_197<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_GBGAIN_V_197)
            int_lsc_register_GbGain_V_197<=WDATA;
    end
end

// int_lsc_register_GbGain_V_198[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_GbGain_V_198<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_GBGAIN_V_198)
            int_lsc_register_GbGain_V_198<=WDATA;
    end
end

// int_lsc_register_GbGain_V_199[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_GbGain_V_199<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_GBGAIN_V_199)
            int_lsc_register_GbGain_V_199<=WDATA;
    end
end

// int_lsc_register_GbGain_V_200[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_GbGain_V_200<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_GBGAIN_V_200)
            int_lsc_register_GbGain_V_200<=WDATA;
    end
end

// int_lsc_register_GbGain_V_201[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_GbGain_V_201<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_GBGAIN_V_201)
            int_lsc_register_GbGain_V_201<=WDATA;
    end
end

// int_lsc_register_GbGain_V_202[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_GbGain_V_202<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_GBGAIN_V_202)
            int_lsc_register_GbGain_V_202<=WDATA;
    end
end

// int_lsc_register_GbGain_V_203[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_GbGain_V_203<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_GBGAIN_V_203)
            int_lsc_register_GbGain_V_203<=WDATA;
    end
end

// int_lsc_register_GbGain_V_204[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_GbGain_V_204<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_GBGAIN_V_204)
            int_lsc_register_GbGain_V_204<=WDATA;
    end
end

// int_lsc_register_GbGain_V_205[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_GbGain_V_205<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_GBGAIN_V_205)
            int_lsc_register_GbGain_V_205<=WDATA;
    end
end

// int_lsc_register_GbGain_V_206[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_GbGain_V_206<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_GBGAIN_V_206)
            int_lsc_register_GbGain_V_206<=WDATA;
    end
end

// int_lsc_register_GbGain_V_207[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_GbGain_V_207<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_GBGAIN_V_207)
            int_lsc_register_GbGain_V_207<=WDATA;
    end
end

// int_lsc_register_GbGain_V_208[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_GbGain_V_208<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_GBGAIN_V_208)
            int_lsc_register_GbGain_V_208<=WDATA;
    end
end

// int_lsc_register_GbGain_V_209[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_GbGain_V_209<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_GBGAIN_V_209)
            int_lsc_register_GbGain_V_209<=WDATA;
    end
end

// int_lsc_register_GbGain_V_210[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_GbGain_V_210<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_GBGAIN_V_210)
            int_lsc_register_GbGain_V_210<=WDATA;
    end
end

// int_lsc_register_GbGain_V_211[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_GbGain_V_211<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_GBGAIN_V_211)
            int_lsc_register_GbGain_V_211<=WDATA;
    end
end

// int_lsc_register_GbGain_V_212[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_GbGain_V_212<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_GBGAIN_V_212)
            int_lsc_register_GbGain_V_212<=WDATA;
    end
end

// int_lsc_register_GbGain_V_213[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_GbGain_V_213<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_GBGAIN_V_213)
            int_lsc_register_GbGain_V_213<=WDATA;
    end
end

// int_lsc_register_GbGain_V_214[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_GbGain_V_214<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_GBGAIN_V_214)
            int_lsc_register_GbGain_V_214<=WDATA;
    end
end

// int_lsc_register_GbGain_V_215[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_GbGain_V_215<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_GBGAIN_V_215)
            int_lsc_register_GbGain_V_215<=WDATA;
    end
end

// int_lsc_register_GbGain_V_216[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_GbGain_V_216<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_GBGAIN_V_216)
            int_lsc_register_GbGain_V_216<=WDATA;
    end
end

// int_lsc_register_GbGain_V_217[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_GbGain_V_217<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_GBGAIN_V_217)
            int_lsc_register_GbGain_V_217<=WDATA;
    end
end

// int_lsc_register_GbGain_V_218[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_GbGain_V_218<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_GBGAIN_V_218)
            int_lsc_register_GbGain_V_218<=WDATA;
    end
end

// int_lsc_register_GbGain_V_219[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_GbGain_V_219<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_GBGAIN_V_219)
            int_lsc_register_GbGain_V_219<=WDATA;
    end
end

// int_lsc_register_GbGain_V_220[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_GbGain_V_220<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_GBGAIN_V_220)
            int_lsc_register_GbGain_V_220<=WDATA;
    end
end

// int_lsc_register_bGain_V_0[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_bGain_V_0<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_BGAIN_V_0)
            int_lsc_register_bGain_V_0<=WDATA;
    end
end

// int_lsc_register_bGain_V_1[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_bGain_V_1<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_BGAIN_V_1)
            int_lsc_register_bGain_V_1<=WDATA;
    end
end

// int_lsc_register_bGain_V_2[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_bGain_V_2<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_BGAIN_V_2)
            int_lsc_register_bGain_V_2<=WDATA;
    end
end

// int_lsc_register_bGain_V_3[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_bGain_V_3<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_BGAIN_V_3)
            int_lsc_register_bGain_V_3<=WDATA;
    end
end

// int_lsc_register_bGain_V_4[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_bGain_V_4<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_BGAIN_V_4)
            int_lsc_register_bGain_V_4<=WDATA;
    end
end

// int_lsc_register_bGain_V_5[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_bGain_V_5<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_BGAIN_V_5)
            int_lsc_register_bGain_V_5<=WDATA;
    end
end

// int_lsc_register_bGain_V_6[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_bGain_V_6<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_BGAIN_V_6)
            int_lsc_register_bGain_V_6<=WDATA;
    end
end

// int_lsc_register_bGain_V_7[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_bGain_V_7<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_BGAIN_V_7)
            int_lsc_register_bGain_V_7<=WDATA;
    end
end

// int_lsc_register_bGain_V_8[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_bGain_V_8<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_BGAIN_V_8)
            int_lsc_register_bGain_V_8<=WDATA;
    end
end

// int_lsc_register_bGain_V_9[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_bGain_V_9<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_BGAIN_V_9)
            int_lsc_register_bGain_V_9<=WDATA;
    end
end

// int_lsc_register_bGain_V_10[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_bGain_V_10<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_BGAIN_V_10)
            int_lsc_register_bGain_V_10<=WDATA;
    end
end

// int_lsc_register_bGain_V_11[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_bGain_V_11<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_BGAIN_V_11)
            int_lsc_register_bGain_V_11<=WDATA;
    end
end

// int_lsc_register_bGain_V_12[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_bGain_V_12<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_BGAIN_V_12)
            int_lsc_register_bGain_V_12<=WDATA;
    end
end

// int_lsc_register_bGain_V_13[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_bGain_V_13<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_BGAIN_V_13)
            int_lsc_register_bGain_V_13<=WDATA;
    end
end

// int_lsc_register_bGain_V_14[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_bGain_V_14<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_BGAIN_V_14)
            int_lsc_register_bGain_V_14<=WDATA;
    end
end

// int_lsc_register_bGain_V_15[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_bGain_V_15<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_BGAIN_V_15)
            int_lsc_register_bGain_V_15<=WDATA;
    end
end

// int_lsc_register_bGain_V_16[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_bGain_V_16<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_BGAIN_V_16)
            int_lsc_register_bGain_V_16<=WDATA;
    end
end

// int_lsc_register_bGain_V_17[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_bGain_V_17<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_BGAIN_V_17)
            int_lsc_register_bGain_V_17<=WDATA;
    end
end

// int_lsc_register_bGain_V_18[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_bGain_V_18<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_BGAIN_V_18)
            int_lsc_register_bGain_V_18<=WDATA;
    end
end

// int_lsc_register_bGain_V_19[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_bGain_V_19<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_BGAIN_V_19)
            int_lsc_register_bGain_V_19<=WDATA;
    end
end

// int_lsc_register_bGain_V_20[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_bGain_V_20<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_BGAIN_V_20)
            int_lsc_register_bGain_V_20<=WDATA;
    end
end

// int_lsc_register_bGain_V_21[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_bGain_V_21<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_BGAIN_V_21)
            int_lsc_register_bGain_V_21<=WDATA;
    end
end

// int_lsc_register_bGain_V_22[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_bGain_V_22<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_BGAIN_V_22)
            int_lsc_register_bGain_V_22<=WDATA;
    end
end

// int_lsc_register_bGain_V_23[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_bGain_V_23<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_BGAIN_V_23)
            int_lsc_register_bGain_V_23<=WDATA;
    end
end

// int_lsc_register_bGain_V_24[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_bGain_V_24<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_BGAIN_V_24)
            int_lsc_register_bGain_V_24<=WDATA;
    end
end

// int_lsc_register_bGain_V_25[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_bGain_V_25<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_BGAIN_V_25)
            int_lsc_register_bGain_V_25<=WDATA;
    end
end

// int_lsc_register_bGain_V_26[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_bGain_V_26<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_BGAIN_V_26)
            int_lsc_register_bGain_V_26<=WDATA;
    end
end

// int_lsc_register_bGain_V_27[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_bGain_V_27<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_BGAIN_V_27)
            int_lsc_register_bGain_V_27<=WDATA;
    end
end

// int_lsc_register_bGain_V_28[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_bGain_V_28<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_BGAIN_V_28)
            int_lsc_register_bGain_V_28<=WDATA;
    end
end

// int_lsc_register_bGain_V_29[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_bGain_V_29<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_BGAIN_V_29)
            int_lsc_register_bGain_V_29<=WDATA;
    end
end

// int_lsc_register_bGain_V_30[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_bGain_V_30<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_BGAIN_V_30)
            int_lsc_register_bGain_V_30<=WDATA;
    end
end

// int_lsc_register_bGain_V_31[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_bGain_V_31<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_BGAIN_V_31)
            int_lsc_register_bGain_V_31<=WDATA;
    end
end

// int_lsc_register_bGain_V_32[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_bGain_V_32<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_BGAIN_V_32)
            int_lsc_register_bGain_V_32<=WDATA;
    end
end

// int_lsc_register_bGain_V_33[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_bGain_V_33<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_BGAIN_V_33)
            int_lsc_register_bGain_V_33<=WDATA;
    end
end

// int_lsc_register_bGain_V_34[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_bGain_V_34<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_BGAIN_V_34)
            int_lsc_register_bGain_V_34<=WDATA;
    end
end

// int_lsc_register_bGain_V_35[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_bGain_V_35<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_BGAIN_V_35)
            int_lsc_register_bGain_V_35<=WDATA;
    end
end

// int_lsc_register_bGain_V_36[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_bGain_V_36<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_BGAIN_V_36)
            int_lsc_register_bGain_V_36<=WDATA;
    end
end

// int_lsc_register_bGain_V_37[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_bGain_V_37<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_BGAIN_V_37)
            int_lsc_register_bGain_V_37<=WDATA;
    end
end

// int_lsc_register_bGain_V_38[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_bGain_V_38<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_BGAIN_V_38)
            int_lsc_register_bGain_V_38<=WDATA;
    end
end

// int_lsc_register_bGain_V_39[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_bGain_V_39<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_BGAIN_V_39)
            int_lsc_register_bGain_V_39<=WDATA;
    end
end

// int_lsc_register_bGain_V_40[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_bGain_V_40<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_BGAIN_V_40)
            int_lsc_register_bGain_V_40<=WDATA;
    end
end

// int_lsc_register_bGain_V_41[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_bGain_V_41<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_BGAIN_V_41)
            int_lsc_register_bGain_V_41<=WDATA;
    end
end

// int_lsc_register_bGain_V_42[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_bGain_V_42<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_BGAIN_V_42)
            int_lsc_register_bGain_V_42<=WDATA;
    end
end

// int_lsc_register_bGain_V_43[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_bGain_V_43<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_BGAIN_V_43)
            int_lsc_register_bGain_V_43<=WDATA;
    end
end

// int_lsc_register_bGain_V_44[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_bGain_V_44<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_BGAIN_V_44)
            int_lsc_register_bGain_V_44<=WDATA;
    end
end

// int_lsc_register_bGain_V_45[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_bGain_V_45<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_BGAIN_V_45)
            int_lsc_register_bGain_V_45<=WDATA;
    end
end

// int_lsc_register_bGain_V_46[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_bGain_V_46<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_BGAIN_V_46)
            int_lsc_register_bGain_V_46<=WDATA;
    end
end

// int_lsc_register_bGain_V_47[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_bGain_V_47<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_BGAIN_V_47)
            int_lsc_register_bGain_V_47<=WDATA;
    end
end

// int_lsc_register_bGain_V_48[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_bGain_V_48<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_BGAIN_V_48)
            int_lsc_register_bGain_V_48<=WDATA;
    end
end

// int_lsc_register_bGain_V_49[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_bGain_V_49<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_BGAIN_V_49)
            int_lsc_register_bGain_V_49<=WDATA;
    end
end

// int_lsc_register_bGain_V_50[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_bGain_V_50<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_BGAIN_V_50)
            int_lsc_register_bGain_V_50<=WDATA;
    end
end

// int_lsc_register_bGain_V_51[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_bGain_V_51<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_BGAIN_V_51)
            int_lsc_register_bGain_V_51<=WDATA;
    end
end

// int_lsc_register_bGain_V_52[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_bGain_V_52<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_BGAIN_V_52)
            int_lsc_register_bGain_V_52<=WDATA;
    end
end

// int_lsc_register_bGain_V_53[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_bGain_V_53<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_BGAIN_V_53)
            int_lsc_register_bGain_V_53<=WDATA;
    end
end

// int_lsc_register_bGain_V_54[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_bGain_V_54<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_BGAIN_V_54)
            int_lsc_register_bGain_V_54<=WDATA;
    end
end

// int_lsc_register_bGain_V_55[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_bGain_V_55<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_BGAIN_V_55)
            int_lsc_register_bGain_V_55<=WDATA;
    end
end

// int_lsc_register_bGain_V_56[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_bGain_V_56<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_BGAIN_V_56)
            int_lsc_register_bGain_V_56<=WDATA;
    end
end

// int_lsc_register_bGain_V_57[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_bGain_V_57<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_BGAIN_V_57)
            int_lsc_register_bGain_V_57<=WDATA;
    end
end

// int_lsc_register_bGain_V_58[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_bGain_V_58<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_BGAIN_V_58)
            int_lsc_register_bGain_V_58<=WDATA;
    end
end

// int_lsc_register_bGain_V_59[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_bGain_V_59<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_BGAIN_V_59)
            int_lsc_register_bGain_V_59<=WDATA;
    end
end

// int_lsc_register_bGain_V_60[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_bGain_V_60<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_BGAIN_V_60)
            int_lsc_register_bGain_V_60<=WDATA;
    end
end

// int_lsc_register_bGain_V_61[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_bGain_V_61<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_BGAIN_V_61)
            int_lsc_register_bGain_V_61<=WDATA;
    end
end

// int_lsc_register_bGain_V_62[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_bGain_V_62<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_BGAIN_V_62)
            int_lsc_register_bGain_V_62<=WDATA;
    end
end

// int_lsc_register_bGain_V_63[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_bGain_V_63<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_BGAIN_V_63)
            int_lsc_register_bGain_V_63<=WDATA;
    end
end

// int_lsc_register_bGain_V_64[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_bGain_V_64<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_BGAIN_V_64)
            int_lsc_register_bGain_V_64<=WDATA;
    end
end

// int_lsc_register_bGain_V_65[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_bGain_V_65<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_BGAIN_V_65)
            int_lsc_register_bGain_V_65<=WDATA;
    end
end

// int_lsc_register_bGain_V_66[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_bGain_V_66<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_BGAIN_V_66)
            int_lsc_register_bGain_V_66<=WDATA;
    end
end

// int_lsc_register_bGain_V_67[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_bGain_V_67<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_BGAIN_V_67)
            int_lsc_register_bGain_V_67<=WDATA;
    end
end

// int_lsc_register_bGain_V_68[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_bGain_V_68<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_BGAIN_V_68)
            int_lsc_register_bGain_V_68<=WDATA;
    end
end

// int_lsc_register_bGain_V_69[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_bGain_V_69<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_BGAIN_V_69)
            int_lsc_register_bGain_V_69<=WDATA;
    end
end

// int_lsc_register_bGain_V_70[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_bGain_V_70<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_BGAIN_V_70)
            int_lsc_register_bGain_V_70<=WDATA;
    end
end

// int_lsc_register_bGain_V_71[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_bGain_V_71<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_BGAIN_V_71)
            int_lsc_register_bGain_V_71<=WDATA;
    end
end

// int_lsc_register_bGain_V_72[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_bGain_V_72<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_BGAIN_V_72)
            int_lsc_register_bGain_V_72<=WDATA;
    end
end

// int_lsc_register_bGain_V_73[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_bGain_V_73<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_BGAIN_V_73)
            int_lsc_register_bGain_V_73<=WDATA;
    end
end

// int_lsc_register_bGain_V_74[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_bGain_V_74<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_BGAIN_V_74)
            int_lsc_register_bGain_V_74<=WDATA;
    end
end

// int_lsc_register_bGain_V_75[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_bGain_V_75<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_BGAIN_V_75)
            int_lsc_register_bGain_V_75<=WDATA;
    end
end

// int_lsc_register_bGain_V_76[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_bGain_V_76<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_BGAIN_V_76)
            int_lsc_register_bGain_V_76<=WDATA;
    end
end

// int_lsc_register_bGain_V_77[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_bGain_V_77<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_BGAIN_V_77)
            int_lsc_register_bGain_V_77<=WDATA;
    end
end

// int_lsc_register_bGain_V_78[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_bGain_V_78<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_BGAIN_V_78)
            int_lsc_register_bGain_V_78<=WDATA;
    end
end

// int_lsc_register_bGain_V_79[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_bGain_V_79<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_BGAIN_V_79)
            int_lsc_register_bGain_V_79<=WDATA;
    end
end

// int_lsc_register_bGain_V_80[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_bGain_V_80<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_BGAIN_V_80)
            int_lsc_register_bGain_V_80<=WDATA;
    end
end

// int_lsc_register_bGain_V_81[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_bGain_V_81<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_BGAIN_V_81)
            int_lsc_register_bGain_V_81<=WDATA;
    end
end

// int_lsc_register_bGain_V_82[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_bGain_V_82<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_BGAIN_V_82)
            int_lsc_register_bGain_V_82<=WDATA;
    end
end

// int_lsc_register_bGain_V_83[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_bGain_V_83<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_BGAIN_V_83)
            int_lsc_register_bGain_V_83<=WDATA;
    end
end

// int_lsc_register_bGain_V_84[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_bGain_V_84<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_BGAIN_V_84)
            int_lsc_register_bGain_V_84<=WDATA;
    end
end

// int_lsc_register_bGain_V_85[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_bGain_V_85<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_BGAIN_V_85)
            int_lsc_register_bGain_V_85<=WDATA;
    end
end

// int_lsc_register_bGain_V_86[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_bGain_V_86<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_BGAIN_V_86)
            int_lsc_register_bGain_V_86<=WDATA;
    end
end

// int_lsc_register_bGain_V_87[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_bGain_V_87<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_BGAIN_V_87)
            int_lsc_register_bGain_V_87<=WDATA;
    end
end

// int_lsc_register_bGain_V_88[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_bGain_V_88<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_BGAIN_V_88)
            int_lsc_register_bGain_V_88<=WDATA;
    end
end

// int_lsc_register_bGain_V_89[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_bGain_V_89<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_BGAIN_V_89)
            int_lsc_register_bGain_V_89<=WDATA;
    end
end

// int_lsc_register_bGain_V_90[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_bGain_V_90<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_BGAIN_V_90)
            int_lsc_register_bGain_V_90<=WDATA;
    end
end

// int_lsc_register_bGain_V_91[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_bGain_V_91<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_BGAIN_V_91)
            int_lsc_register_bGain_V_91<=WDATA;
    end
end

// int_lsc_register_bGain_V_92[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_bGain_V_92<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_BGAIN_V_92)
            int_lsc_register_bGain_V_92<=WDATA;
    end
end

// int_lsc_register_bGain_V_93[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_bGain_V_93<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_BGAIN_V_93)
            int_lsc_register_bGain_V_93<=WDATA;
    end
end

// int_lsc_register_bGain_V_94[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_bGain_V_94<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_BGAIN_V_94)
            int_lsc_register_bGain_V_94<=WDATA;
    end
end

// int_lsc_register_bGain_V_95[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_bGain_V_95<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_BGAIN_V_95)
            int_lsc_register_bGain_V_95<=WDATA;
    end
end

// int_lsc_register_bGain_V_96[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_bGain_V_96<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_BGAIN_V_96)
            int_lsc_register_bGain_V_96<=WDATA;
    end
end

// int_lsc_register_bGain_V_97[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_bGain_V_97<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_BGAIN_V_97)
            int_lsc_register_bGain_V_97<=WDATA;
    end
end

// int_lsc_register_bGain_V_98[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_bGain_V_98<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_BGAIN_V_98)
            int_lsc_register_bGain_V_98<=WDATA;
    end
end

// int_lsc_register_bGain_V_99[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_bGain_V_99<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_BGAIN_V_99)
            int_lsc_register_bGain_V_99<=WDATA;
    end
end

// int_lsc_register_bGain_V_100[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_bGain_V_100<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_BGAIN_V_100)
            int_lsc_register_bGain_V_100<=WDATA;
    end
end

// int_lsc_register_bGain_V_101[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_bGain_V_101<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_BGAIN_V_101)
            int_lsc_register_bGain_V_101<=WDATA;
    end
end

// int_lsc_register_bGain_V_102[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_bGain_V_102<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_BGAIN_V_102)
            int_lsc_register_bGain_V_102<=WDATA;
    end
end

// int_lsc_register_bGain_V_103[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_bGain_V_103<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_BGAIN_V_103)
            int_lsc_register_bGain_V_103<=WDATA;
    end
end

// int_lsc_register_bGain_V_104[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_bGain_V_104<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_BGAIN_V_104)
            int_lsc_register_bGain_V_104<=WDATA;
    end
end

// int_lsc_register_bGain_V_105[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_bGain_V_105<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_BGAIN_V_105)
            int_lsc_register_bGain_V_105<=WDATA;
    end
end

// int_lsc_register_bGain_V_106[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_bGain_V_106<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_BGAIN_V_106)
            int_lsc_register_bGain_V_106<=WDATA;
    end
end

// int_lsc_register_bGain_V_107[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_bGain_V_107<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_BGAIN_V_107)
            int_lsc_register_bGain_V_107<=WDATA;
    end
end

// int_lsc_register_bGain_V_108[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_bGain_V_108<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_BGAIN_V_108)
            int_lsc_register_bGain_V_108<=WDATA;
    end
end

// int_lsc_register_bGain_V_109[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_bGain_V_109<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_BGAIN_V_109)
            int_lsc_register_bGain_V_109<=WDATA;
    end
end

// int_lsc_register_bGain_V_110[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_bGain_V_110<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_BGAIN_V_110)
            int_lsc_register_bGain_V_110<=WDATA;
    end
end

// int_lsc_register_bGain_V_111[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_bGain_V_111<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_BGAIN_V_111)
            int_lsc_register_bGain_V_111<=WDATA;
    end
end

// int_lsc_register_bGain_V_112[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_bGain_V_112<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_BGAIN_V_112)
            int_lsc_register_bGain_V_112<=WDATA;
    end
end

// int_lsc_register_bGain_V_113[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_bGain_V_113<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_BGAIN_V_113)
            int_lsc_register_bGain_V_113<=WDATA;
    end
end

// int_lsc_register_bGain_V_114[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_bGain_V_114<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_BGAIN_V_114)
            int_lsc_register_bGain_V_114<=WDATA;
    end
end

// int_lsc_register_bGain_V_115[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_bGain_V_115<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_BGAIN_V_115)
            int_lsc_register_bGain_V_115<=WDATA;
    end
end

// int_lsc_register_bGain_V_116[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_bGain_V_116<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_BGAIN_V_116)
            int_lsc_register_bGain_V_116<=WDATA;
    end
end

// int_lsc_register_bGain_V_117[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_bGain_V_117<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_BGAIN_V_117)
            int_lsc_register_bGain_V_117<=WDATA;
    end
end

// int_lsc_register_bGain_V_118[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_bGain_V_118<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_BGAIN_V_118)
            int_lsc_register_bGain_V_118<=WDATA;
    end
end

// int_lsc_register_bGain_V_119[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_bGain_V_119<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_BGAIN_V_119)
            int_lsc_register_bGain_V_119<=WDATA;
    end
end

// int_lsc_register_bGain_V_120[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_bGain_V_120<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_BGAIN_V_120)
            int_lsc_register_bGain_V_120<=WDATA;
    end
end

// int_lsc_register_bGain_V_121[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_bGain_V_121<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_BGAIN_V_121)
            int_lsc_register_bGain_V_121<=WDATA;
    end
end

// int_lsc_register_bGain_V_122[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_bGain_V_122<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_BGAIN_V_122)
            int_lsc_register_bGain_V_122<=WDATA;
    end
end

// int_lsc_register_bGain_V_123[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_bGain_V_123<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_BGAIN_V_123)
            int_lsc_register_bGain_V_123<=WDATA;
    end
end

// int_lsc_register_bGain_V_124[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_bGain_V_124<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_BGAIN_V_124)
            int_lsc_register_bGain_V_124<=WDATA;
    end
end

// int_lsc_register_bGain_V_125[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_bGain_V_125<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_BGAIN_V_125)
            int_lsc_register_bGain_V_125<=WDATA;
    end
end

// int_lsc_register_bGain_V_126[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_bGain_V_126<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_BGAIN_V_126)
            int_lsc_register_bGain_V_126<=WDATA;
    end
end

// int_lsc_register_bGain_V_127[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_bGain_V_127<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_BGAIN_V_127)
            int_lsc_register_bGain_V_127<=WDATA;
    end
end

// int_lsc_register_bGain_V_128[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_bGain_V_128<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_BGAIN_V_128)
            int_lsc_register_bGain_V_128<=WDATA;
    end
end

// int_lsc_register_bGain_V_129[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_bGain_V_129<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_BGAIN_V_129)
            int_lsc_register_bGain_V_129<=WDATA;
    end
end

// int_lsc_register_bGain_V_130[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_bGain_V_130<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_BGAIN_V_130)
            int_lsc_register_bGain_V_130<=WDATA;
    end
end

// int_lsc_register_bGain_V_131[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_bGain_V_131<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_BGAIN_V_131)
            int_lsc_register_bGain_V_131<=WDATA;
    end
end

// int_lsc_register_bGain_V_132[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_bGain_V_132<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_BGAIN_V_132)
            int_lsc_register_bGain_V_132<=WDATA;
    end
end

// int_lsc_register_bGain_V_133[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_bGain_V_133<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_BGAIN_V_133)
            int_lsc_register_bGain_V_133<=WDATA;
    end
end

// int_lsc_register_bGain_V_134[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_bGain_V_134<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_BGAIN_V_134)
            int_lsc_register_bGain_V_134<=WDATA;
    end
end

// int_lsc_register_bGain_V_135[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_bGain_V_135<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_BGAIN_V_135)
            int_lsc_register_bGain_V_135<=WDATA;
    end
end

// int_lsc_register_bGain_V_136[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_bGain_V_136<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_BGAIN_V_136)
            int_lsc_register_bGain_V_136<=WDATA;
    end
end

// int_lsc_register_bGain_V_137[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_bGain_V_137<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_BGAIN_V_137)
            int_lsc_register_bGain_V_137<=WDATA;
    end
end

// int_lsc_register_bGain_V_138[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_bGain_V_138<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_BGAIN_V_138)
            int_lsc_register_bGain_V_138<=WDATA;
    end
end

// int_lsc_register_bGain_V_139[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_bGain_V_139<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_BGAIN_V_139)
            int_lsc_register_bGain_V_139<=WDATA;
    end
end

// int_lsc_register_bGain_V_140[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_bGain_V_140<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_BGAIN_V_140)
            int_lsc_register_bGain_V_140<=WDATA;
    end
end

// int_lsc_register_bGain_V_141[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_bGain_V_141<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_BGAIN_V_141)
            int_lsc_register_bGain_V_141<=WDATA;
    end
end

// int_lsc_register_bGain_V_142[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_bGain_V_142<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_BGAIN_V_142)
            int_lsc_register_bGain_V_142<=WDATA;
    end
end

// int_lsc_register_bGain_V_143[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_bGain_V_143<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_BGAIN_V_143)
            int_lsc_register_bGain_V_143<=WDATA;
    end
end

// int_lsc_register_bGain_V_144[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_bGain_V_144<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_BGAIN_V_144)
            int_lsc_register_bGain_V_144<=WDATA;
    end
end

// int_lsc_register_bGain_V_145[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_bGain_V_145<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_BGAIN_V_145)
            int_lsc_register_bGain_V_145<=WDATA;
    end
end

// int_lsc_register_bGain_V_146[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_bGain_V_146<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_BGAIN_V_146)
            int_lsc_register_bGain_V_146<=WDATA;
    end
end

// int_lsc_register_bGain_V_147[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_bGain_V_147<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_BGAIN_V_147)
            int_lsc_register_bGain_V_147<=WDATA;
    end
end

// int_lsc_register_bGain_V_148[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_bGain_V_148<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_BGAIN_V_148)
            int_lsc_register_bGain_V_148<=WDATA;
    end
end

// int_lsc_register_bGain_V_149[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_bGain_V_149<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_BGAIN_V_149)
            int_lsc_register_bGain_V_149<=WDATA;
    end
end

// int_lsc_register_bGain_V_150[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_bGain_V_150<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_BGAIN_V_150)
            int_lsc_register_bGain_V_150<=WDATA;
    end
end

// int_lsc_register_bGain_V_151[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_bGain_V_151<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_BGAIN_V_151)
            int_lsc_register_bGain_V_151<=WDATA;
    end
end

// int_lsc_register_bGain_V_152[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_bGain_V_152<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_BGAIN_V_152)
            int_lsc_register_bGain_V_152<=WDATA;
    end
end

// int_lsc_register_bGain_V_153[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_bGain_V_153<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_BGAIN_V_153)
            int_lsc_register_bGain_V_153<=WDATA;
    end
end

// int_lsc_register_bGain_V_154[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_bGain_V_154<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_BGAIN_V_154)
            int_lsc_register_bGain_V_154<=WDATA;
    end
end

// int_lsc_register_bGain_V_155[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_bGain_V_155<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_BGAIN_V_155)
            int_lsc_register_bGain_V_155<=WDATA;
    end
end

// int_lsc_register_bGain_V_156[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_bGain_V_156<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_BGAIN_V_156)
            int_lsc_register_bGain_V_156<=WDATA;
    end
end

// int_lsc_register_bGain_V_157[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_bGain_V_157<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_BGAIN_V_157)
            int_lsc_register_bGain_V_157<=WDATA;
    end
end

// int_lsc_register_bGain_V_158[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_bGain_V_158<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_BGAIN_V_158)
            int_lsc_register_bGain_V_158<=WDATA;
    end
end

// int_lsc_register_bGain_V_159[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_bGain_V_159<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_BGAIN_V_159)
            int_lsc_register_bGain_V_159<=WDATA;
    end
end

// int_lsc_register_bGain_V_160[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_bGain_V_160<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_BGAIN_V_160)
            int_lsc_register_bGain_V_160<=WDATA;
    end
end

// int_lsc_register_bGain_V_161[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_bGain_V_161<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_BGAIN_V_161)
            int_lsc_register_bGain_V_161<=WDATA;
    end
end

// int_lsc_register_bGain_V_162[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_bGain_V_162<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_BGAIN_V_162)
            int_lsc_register_bGain_V_162<=WDATA;
    end
end

// int_lsc_register_bGain_V_163[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_bGain_V_163<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_BGAIN_V_163)
            int_lsc_register_bGain_V_163<=WDATA;
    end
end

// int_lsc_register_bGain_V_164[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_bGain_V_164<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_BGAIN_V_164)
            int_lsc_register_bGain_V_164<=WDATA;
    end
end

// int_lsc_register_bGain_V_165[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_bGain_V_165<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_BGAIN_V_165)
            int_lsc_register_bGain_V_165<=WDATA;
    end
end

// int_lsc_register_bGain_V_166[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_bGain_V_166<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_BGAIN_V_166)
            int_lsc_register_bGain_V_166<=WDATA;
    end
end

// int_lsc_register_bGain_V_167[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_bGain_V_167<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_BGAIN_V_167)
            int_lsc_register_bGain_V_167<=WDATA;
    end
end

// int_lsc_register_bGain_V_168[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_bGain_V_168<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_BGAIN_V_168)
            int_lsc_register_bGain_V_168<=WDATA;
    end
end

// int_lsc_register_bGain_V_169[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_bGain_V_169<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_BGAIN_V_169)
            int_lsc_register_bGain_V_169<=WDATA;
    end
end

// int_lsc_register_bGain_V_170[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_bGain_V_170<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_BGAIN_V_170)
            int_lsc_register_bGain_V_170<=WDATA;
    end
end

// int_lsc_register_bGain_V_171[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_bGain_V_171<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_BGAIN_V_171)
            int_lsc_register_bGain_V_171<=WDATA;
    end
end

// int_lsc_register_bGain_V_172[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_bGain_V_172<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_BGAIN_V_172)
            int_lsc_register_bGain_V_172<=WDATA;
    end
end

// int_lsc_register_bGain_V_173[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_bGain_V_173<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_BGAIN_V_173)
            int_lsc_register_bGain_V_173<=WDATA;
    end
end

// int_lsc_register_bGain_V_174[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_bGain_V_174<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_BGAIN_V_174)
            int_lsc_register_bGain_V_174<=WDATA;
    end
end

// int_lsc_register_bGain_V_175[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_bGain_V_175<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_BGAIN_V_175)
            int_lsc_register_bGain_V_175<=WDATA;
    end
end

// int_lsc_register_bGain_V_176[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_bGain_V_176<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_BGAIN_V_176)
            int_lsc_register_bGain_V_176<=WDATA;
    end
end

// int_lsc_register_bGain_V_177[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_bGain_V_177<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_BGAIN_V_177)
            int_lsc_register_bGain_V_177<=WDATA;
    end
end

// int_lsc_register_bGain_V_178[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_bGain_V_178<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_BGAIN_V_178)
            int_lsc_register_bGain_V_178<=WDATA;
    end
end

// int_lsc_register_bGain_V_179[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_bGain_V_179<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_BGAIN_V_179)
            int_lsc_register_bGain_V_179<=WDATA;
    end
end

// int_lsc_register_bGain_V_180[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_bGain_V_180<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_BGAIN_V_180)
            int_lsc_register_bGain_V_180<=WDATA;
    end
end

// int_lsc_register_bGain_V_181[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_bGain_V_181<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_BGAIN_V_181)
            int_lsc_register_bGain_V_181<=WDATA;
    end
end

// int_lsc_register_bGain_V_182[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_bGain_V_182<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_BGAIN_V_182)
            int_lsc_register_bGain_V_182<=WDATA;
    end
end

// int_lsc_register_bGain_V_183[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_bGain_V_183<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_BGAIN_V_183)
            int_lsc_register_bGain_V_183<=WDATA;
    end
end

// int_lsc_register_bGain_V_184[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_bGain_V_184<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_BGAIN_V_184)
            int_lsc_register_bGain_V_184<=WDATA;
    end
end

// int_lsc_register_bGain_V_185[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_bGain_V_185<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_BGAIN_V_185)
            int_lsc_register_bGain_V_185<=WDATA;
    end
end

// int_lsc_register_bGain_V_186[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_bGain_V_186<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_BGAIN_V_186)
            int_lsc_register_bGain_V_186<=WDATA;
    end
end

// int_lsc_register_bGain_V_187[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_bGain_V_187<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_BGAIN_V_187)
            int_lsc_register_bGain_V_187<=WDATA;
    end
end

// int_lsc_register_bGain_V_188[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_bGain_V_188<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_BGAIN_V_188)
            int_lsc_register_bGain_V_188<=WDATA;
    end
end

// int_lsc_register_bGain_V_189[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_bGain_V_189<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_BGAIN_V_189)
            int_lsc_register_bGain_V_189<=WDATA;
    end
end

// int_lsc_register_bGain_V_190[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_bGain_V_190<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_BGAIN_V_190)
            int_lsc_register_bGain_V_190<=WDATA;
    end
end

// int_lsc_register_bGain_V_191[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_bGain_V_191<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_BGAIN_V_191)
            int_lsc_register_bGain_V_191<=WDATA;
    end
end

// int_lsc_register_bGain_V_192[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_bGain_V_192<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_BGAIN_V_192)
            int_lsc_register_bGain_V_192<=WDATA;
    end
end

// int_lsc_register_bGain_V_193[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_bGain_V_193<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_BGAIN_V_193)
            int_lsc_register_bGain_V_193<=WDATA;
    end
end

// int_lsc_register_bGain_V_194[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_bGain_V_194<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_BGAIN_V_194)
            int_lsc_register_bGain_V_194<=WDATA;
    end
end

// int_lsc_register_bGain_V_195[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_bGain_V_195<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_BGAIN_V_195)
            int_lsc_register_bGain_V_195<=WDATA;
    end
end

// int_lsc_register_bGain_V_196[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_bGain_V_196<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_BGAIN_V_196)
            int_lsc_register_bGain_V_196<=WDATA;
    end
end

// int_lsc_register_bGain_V_197[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_bGain_V_197<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_BGAIN_V_197)
            int_lsc_register_bGain_V_197<=WDATA;
    end
end

// int_lsc_register_bGain_V_198[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_bGain_V_198<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_BGAIN_V_198)
            int_lsc_register_bGain_V_198<=WDATA;
    end
end

// int_lsc_register_bGain_V_199[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_bGain_V_199<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_BGAIN_V_199)
            int_lsc_register_bGain_V_199<=WDATA;
    end
end

// int_lsc_register_bGain_V_200[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_bGain_V_200<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_BGAIN_V_200)
            int_lsc_register_bGain_V_200<=WDATA;
    end
end

// int_lsc_register_bGain_V_201[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_bGain_V_201<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_BGAIN_V_201)
            int_lsc_register_bGain_V_201<=WDATA;
    end
end

// int_lsc_register_bGain_V_202[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_bGain_V_202<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_BGAIN_V_202)
            int_lsc_register_bGain_V_202<=WDATA;
    end
end

// int_lsc_register_bGain_V_203[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_bGain_V_203<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_BGAIN_V_203)
            int_lsc_register_bGain_V_203<=WDATA;
    end
end

// int_lsc_register_bGain_V_204[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_bGain_V_204<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_BGAIN_V_204)
            int_lsc_register_bGain_V_204<=WDATA;
    end
end

// int_lsc_register_bGain_V_205[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_bGain_V_205<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_BGAIN_V_205)
            int_lsc_register_bGain_V_205<=WDATA;
    end
end

// int_lsc_register_bGain_V_206[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_bGain_V_206<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_BGAIN_V_206)
            int_lsc_register_bGain_V_206<=WDATA;
    end
end

// int_lsc_register_bGain_V_207[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_bGain_V_207<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_BGAIN_V_207)
            int_lsc_register_bGain_V_207<=WDATA;
    end
end

// int_lsc_register_bGain_V_208[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_bGain_V_208<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_BGAIN_V_208)
            int_lsc_register_bGain_V_208<=WDATA;
    end
end

// int_lsc_register_bGain_V_209[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_bGain_V_209<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_BGAIN_V_209)
            int_lsc_register_bGain_V_209<=WDATA;
    end
end

// int_lsc_register_bGain_V_210[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_bGain_V_210<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_BGAIN_V_210)
            int_lsc_register_bGain_V_210<=WDATA;
    end
end

// int_lsc_register_bGain_V_211[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_bGain_V_211<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_BGAIN_V_211)
            int_lsc_register_bGain_V_211<=WDATA;
    end
end

// int_lsc_register_bGain_V_212[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_bGain_V_212<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_BGAIN_V_212)
            int_lsc_register_bGain_V_212<=WDATA;
    end
end

// int_lsc_register_bGain_V_213[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_bGain_V_213<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_BGAIN_V_213)
            int_lsc_register_bGain_V_213<=WDATA;
    end
end

// int_lsc_register_bGain_V_214[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_bGain_V_214<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_BGAIN_V_214)
            int_lsc_register_bGain_V_214<=WDATA;
    end
end

// int_lsc_register_bGain_V_215[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_bGain_V_215<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_BGAIN_V_215)
            int_lsc_register_bGain_V_215<=WDATA;
    end
end

// int_lsc_register_bGain_V_216[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_bGain_V_216<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_BGAIN_V_216)
            int_lsc_register_bGain_V_216<=WDATA;
    end
end

// int_lsc_register_bGain_V_217[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_bGain_V_217<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_BGAIN_V_217)
            int_lsc_register_bGain_V_217<=WDATA;
    end
end

// int_lsc_register_bGain_V_218[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_bGain_V_218<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_BGAIN_V_218)
            int_lsc_register_bGain_V_218<=WDATA;
    end
end

// int_lsc_register_bGain_V_219[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_bGain_V_219<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_BGAIN_V_219)
            int_lsc_register_bGain_V_219<=WDATA;
    end
end

// int_lsc_register_bGain_V_220[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_bGain_V_220<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_BGAIN_V_220)
            int_lsc_register_bGain_V_220<=WDATA;
    end
end

// int_lsc_register_blockHeight_V[8:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_blockHeight_V<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_BLOCKHEIGHT_V)
            int_lsc_register_blockHeight_V<=WDATA;
    end
end

// int_lsc_register_blockWidth_V[8:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_blockWidth_V<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_BLOCKWIDTH_V)
            int_lsc_register_blockWidth_V<=WDATA;
    end
end

// int_lsc_register_blockWidth_1_V[13:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_blockWidth_1_V<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_BLOCKWIDTH_1_V)
            int_lsc_register_blockWidth_1_V<=WDATA;
    end
end

// int_lsc_register_blockHeight_1_V[9:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_lsc_register_blockHeight_1_V<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LSC_REGISTER_BLOCKHEIGHT_1_V)
            int_lsc_register_blockHeight_1_V<=WDATA;
    end
end

// int_dpc_register_eb[0:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_dpc_register_eb<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_DPC_REGISTER_EB)
            int_dpc_register_eb<=WDATA;
    end
end

// int_dpc_register_th_w_V[10:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_dpc_register_th_w_V<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_DPC_REGISTER_TH_W_V)
            int_dpc_register_th_w_V<=WDATA;
    end
end

// int_dpc_register_th_b_V[10:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_dpc_register_th_b_V<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_DPC_REGISTER_TH_B_V)
            int_dpc_register_th_b_V<=WDATA;
    end
end

// int_rawdns_register_sigma_V[5:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_rawdns_register_sigma_V<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_RAWDNS_REGISTER_SIGMA_V)
            int_rawdns_register_sigma_V<=WDATA;
    end
end

// int_rawdns_register_eb_V[0:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_rawdns_register_eb_V<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_RAWDNS_REGISTER_EB_V)
            int_rawdns_register_eb_V<=WDATA;
    end
end

// int_rawdns_register_Filterpara_V[6:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_rawdns_register_Filterpara_V<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_RAWDNS_REGISTER_FILTERPARA_V)
            int_rawdns_register_Filterpara_V<=WDATA;
    end
end

// int_rawdns_register_invksigma2_V[11:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_rawdns_register_invksigma2_V<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_RAWDNS_REGISTER_INVKSIGMA2_V)
            int_rawdns_register_invksigma2_V<=WDATA;
    end
end

// int_awb_register_m_nEb[0:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_awb_register_m_nEb<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_AWB_REGISTER_M_NEB)
            int_awb_register_m_nEb<=WDATA;
    end
end

// int_awb_register_r_gain_V[14:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_awb_register_r_gain_V<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_AWB_REGISTER_R_GAIN_V)
            int_awb_register_r_gain_V<=WDATA;
    end
end

// int_awb_register_g_gain_V[14:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_awb_register_g_gain_V<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_AWB_REGISTER_G_GAIN_V)
            int_awb_register_g_gain_V<=WDATA;
    end
end

// int_awb_register_b_gain_V[14:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_awb_register_b_gain_V<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_AWB_REGISTER_B_GAIN_V)
            int_awb_register_b_gain_V<=WDATA;
    end
end

// int_awb_register_coeff_V[4:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_awb_register_coeff_V<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_AWB_REGISTER_COEFF_V)
            int_awb_register_coeff_V<=WDATA;
    end
end

// int_wbc_register_m_nEb[0:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_wbc_register_m_nEb<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_WBC_REGISTER_M_NEB)
            int_wbc_register_m_nEb<=WDATA;
    end
end

// int_wbc_register_m_nR_V[14:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_wbc_register_m_nR_V<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_WBC_REGISTER_M_NR_V)
            int_wbc_register_m_nR_V<=WDATA;
    end
end

// int_wbc_register_m_nGr_V[14:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_wbc_register_m_nGr_V<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_WBC_REGISTER_M_NGR_V)
            int_wbc_register_m_nGr_V<=WDATA;
    end
end

// int_wbc_register_m_nGb_V[14:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_wbc_register_m_nGb_V<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_WBC_REGISTER_M_NGB_V)
            int_wbc_register_m_nGb_V<=WDATA;
    end
end

// int_wbc_register_m_nB_V[14:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_wbc_register_m_nB_V<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_WBC_REGISTER_M_NB_V)
            int_wbc_register_m_nB_V<=WDATA;
    end
end

// int_gb_register_eb[0:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_gb_register_eb<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_GB_REGISTER_EB)
            int_gb_register_eb<=WDATA;
    end
end

// int_gb_register_win_size_V[3:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_gb_register_win_size_V<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_GB_REGISTER_WIN_SIZE_V)
            int_gb_register_win_size_V<=WDATA;
    end
end

// int_gb_register_Lbound_V[3:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_gb_register_Lbound_V<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_GB_REGISTER_LBOUND_V)
            int_gb_register_Lbound_V<=WDATA;
    end
end

// int_gb_register_Hbound_V[5:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_gb_register_Hbound_V<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_GB_REGISTER_HBOUND_V)
            int_gb_register_Hbound_V<=WDATA;
    end
end

// int_gb_register_threhold_V[9:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_gb_register_threhold_V<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_GB_REGISTER_THREHOLD_V)
            int_gb_register_threhold_V<=WDATA;
    end
end

// int_demosaic_register_eb[0:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_demosaic_register_eb<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_DEMOSAIC_REGISTER_EB)
            int_demosaic_register_eb<=WDATA;
    end
end

// int_ee_register_eb[0:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_ee_register_eb<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_EE_REGISTER_EB)
            int_ee_register_eb<=WDATA;
    end
end

// int_ee_register_coeff_V[7:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_ee_register_coeff_V<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_EE_REGISTER_COEFF_V)
            int_ee_register_coeff_V<=WDATA;
    end
end

// int_cmc_register_m_nEb[0:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_cmc_register_m_nEb<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_CMC_REGISTER_M_NEB)
            int_cmc_register_m_nEb<=WDATA;
    end
end

// int_cmc_register_m_nGain_V_0[15:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_cmc_register_m_nGain_V_0<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_CMC_REGISTER_M_NGAIN_V_0)
            int_cmc_register_m_nGain_V_0<=WDATA;
    end
end

// int_cmc_register_m_nGain_V_1[15:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_cmc_register_m_nGain_V_1<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_CMC_REGISTER_M_NGAIN_V_1)
            int_cmc_register_m_nGain_V_1<=WDATA;
    end
end

// int_cmc_register_m_nGain_V_2[15:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_cmc_register_m_nGain_V_2<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_CMC_REGISTER_M_NGAIN_V_2)
            int_cmc_register_m_nGain_V_2<=WDATA;
    end
end

// int_cmc_register_m_nGain_V_3[15:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_cmc_register_m_nGain_V_3<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_CMC_REGISTER_M_NGAIN_V_3)
            int_cmc_register_m_nGain_V_3<=WDATA;
    end
end

// int_cmc_register_m_nGain_V_4[15:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_cmc_register_m_nGain_V_4<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_CMC_REGISTER_M_NGAIN_V_4)
            int_cmc_register_m_nGain_V_4<=WDATA;
    end
end

// int_cmc_register_m_nGain_V_5[15:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_cmc_register_m_nGain_V_5<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_CMC_REGISTER_M_NGAIN_V_5)
            int_cmc_register_m_nGain_V_5<=WDATA;
    end
end

// int_cmc_register_m_nGain_V_6[15:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_cmc_register_m_nGain_V_6<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_CMC_REGISTER_M_NGAIN_V_6)
            int_cmc_register_m_nGain_V_6<=WDATA;
    end
end

// int_cmc_register_m_nGain_V_7[15:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_cmc_register_m_nGain_V_7<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_CMC_REGISTER_M_NGAIN_V_7)
            int_cmc_register_m_nGain_V_7<=WDATA;
    end
end

// int_cmc_register_m_nGain_V_8[15:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_cmc_register_m_nGain_V_8<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_CMC_REGISTER_M_NGAIN_V_8)
            int_cmc_register_m_nGain_V_8<=WDATA;
    end
end

// int_cmc_register_m_nGain_V_9[15:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_cmc_register_m_nGain_V_9<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_CMC_REGISTER_M_NGAIN_V_9)
            int_cmc_register_m_nGain_V_9<=WDATA;
    end
end

// int_cmc_register_m_nGain_V_10[15:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_cmc_register_m_nGain_V_10<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_CMC_REGISTER_M_NGAIN_V_10)
            int_cmc_register_m_nGain_V_10<=WDATA;
    end
end

// int_cmc_register_m_nGain_V_11[15:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_cmc_register_m_nGain_V_11<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_CMC_REGISTER_M_NGAIN_V_11)
            int_cmc_register_m_nGain_V_11<=WDATA;
    end
end

// int_cmc_register_m_bCFCEnable[0:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_cmc_register_m_bCFCEnable<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_CMC_REGISTER_M_BCFCENABLE)
            int_cmc_register_m_bCFCEnable<=WDATA;
    end
end

// int_cmc_register_m_bDiscardH[0:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_cmc_register_m_bDiscardH<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_CMC_REGISTER_M_BDISCARDH)
            int_cmc_register_m_bDiscardH<=WDATA;
    end
end

// int_cmc_register_m_pHueRange_V_0[8:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_cmc_register_m_pHueRange_V_0<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_CMC_REGISTER_M_PHUERANGE_V_0)
            int_cmc_register_m_pHueRange_V_0<=WDATA;
    end
end

// int_cmc_register_m_pHueRange_V_1[8:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_cmc_register_m_pHueRange_V_1<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_CMC_REGISTER_M_PHUERANGE_V_1)
            int_cmc_register_m_pHueRange_V_1<=WDATA;
    end
end

// int_cmc_register_m_nHueBandShift_V[2:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_cmc_register_m_nHueBandShift_V<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_CMC_REGISTER_M_NHUEBANDSHIFT_V)
            int_cmc_register_m_nHueBandShift_V<=WDATA;
    end
end

// int_cmc_register_m_nEdgeThre_V[7:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_cmc_register_m_nEdgeThre_V<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_CMC_REGISTER_M_NEDGETHRE_V)
            int_cmc_register_m_nEdgeThre_V<=WDATA;
    end
end

// int_cmc_register_m_nEdgeBandShift_V[2:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_cmc_register_m_nEdgeBandShift_V<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_CMC_REGISTER_M_NEDGEBANDSHIFT_V)
            int_cmc_register_m_nEdgeBandShift_V<=WDATA;
    end
end

// int_cmc_register_m_nCFCStrength_V[4:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_cmc_register_m_nCFCStrength_V<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_CMC_REGISTER_M_NCFCSTRENGTH_V)
            int_cmc_register_m_nCFCStrength_V<=WDATA;
    end
end

// int_gtm_register_eb[0:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_gtm_register_eb<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_GTM_REGISTER_EB)
            int_gtm_register_eb<=WDATA;
    end
end

// int_gtm_register_m_bDitheringEnable[0:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_gtm_register_m_bDitheringEnable<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_GTM_REGISTER_M_BDITHERINGENABLE)
            int_gtm_register_m_bDitheringEnable<=WDATA;
    end
end

// int_gtm_register_int_gtmTab_V_0[9:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_gtm_register_int_gtmTab_V_0<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_GTM_REGISTER_GTMTAB_V_0)
            int_gtm_register_int_gtmTab_V_0<=WDATA;
    end
end

// int_gtm_register_int_gtmTab_V_1[9:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_gtm_register_int_gtmTab_V_1<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_GTM_REGISTER_GTMTAB_V_1)
            int_gtm_register_int_gtmTab_V_1<=WDATA;
    end
end

// int_gtm_register_int_gtmTab_V_2[9:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_gtm_register_int_gtmTab_V_2<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_GTM_REGISTER_GTMTAB_V_2)
            int_gtm_register_int_gtmTab_V_2<=WDATA;
    end
end

// int_gtm_register_int_gtmTab_V_3[9:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_gtm_register_int_gtmTab_V_3<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_GTM_REGISTER_GTMTAB_V_3)
            int_gtm_register_int_gtmTab_V_3<=WDATA;
    end
end

// int_gtm_register_int_gtmTab_V_4[9:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_gtm_register_int_gtmTab_V_4<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_GTM_REGISTER_GTMTAB_V_4)
            int_gtm_register_int_gtmTab_V_4<=WDATA;
    end
end

// int_gtm_register_int_gtmTab_V_5[9:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_gtm_register_int_gtmTab_V_5<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_GTM_REGISTER_GTMTAB_V_5)
            int_gtm_register_int_gtmTab_V_5<=WDATA;
    end
end

// int_gtm_register_int_gtmTab_V_6[9:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_gtm_register_int_gtmTab_V_6<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_GTM_REGISTER_GTMTAB_V_6)
            int_gtm_register_int_gtmTab_V_6<=WDATA;
    end
end

// int_gtm_register_int_gtmTab_V_7[9:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_gtm_register_int_gtmTab_V_7<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_GTM_REGISTER_GTMTAB_V_7)
            int_gtm_register_int_gtmTab_V_7<=WDATA;
    end
end

// int_gtm_register_int_gtmTab_V_8[9:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_gtm_register_int_gtmTab_V_8<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_GTM_REGISTER_GTMTAB_V_8)
            int_gtm_register_int_gtmTab_V_8<=WDATA;
    end
end

// int_gtm_register_int_gtmTab_V_9[9:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_gtm_register_int_gtmTab_V_9<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_GTM_REGISTER_GTMTAB_V_9)
            int_gtm_register_int_gtmTab_V_9<=WDATA;
    end
end

// int_gtm_register_int_gtmTab_V_10[9:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_gtm_register_int_gtmTab_V_10<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_GTM_REGISTER_GTMTAB_V_10)
            int_gtm_register_int_gtmTab_V_10<=WDATA;
    end
end

// int_gtm_register_int_gtmTab_V_11[9:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_gtm_register_int_gtmTab_V_11<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_GTM_REGISTER_GTMTAB_V_11)
            int_gtm_register_int_gtmTab_V_11<=WDATA;
    end
end

// int_gtm_register_int_gtmTab_V_12[9:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_gtm_register_int_gtmTab_V_12<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_GTM_REGISTER_GTMTAB_V_12)
            int_gtm_register_int_gtmTab_V_12<=WDATA;
    end
end

// int_gtm_register_int_gtmTab_V_13[9:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_gtm_register_int_gtmTab_V_13<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_GTM_REGISTER_GTMTAB_V_13)
            int_gtm_register_int_gtmTab_V_13<=WDATA;
    end
end

// int_gtm_register_int_gtmTab_V_14[9:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_gtm_register_int_gtmTab_V_14<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_GTM_REGISTER_GTMTAB_V_14)
            int_gtm_register_int_gtmTab_V_14<=WDATA;
    end
end

// int_gtm_register_int_gtmTab_V_15[9:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_gtm_register_int_gtmTab_V_15<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_GTM_REGISTER_GTMTAB_V_15)
            int_gtm_register_int_gtmTab_V_15<=WDATA;
    end
end

// int_gtm_register_int_gtmTab_V_16[9:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_gtm_register_int_gtmTab_V_16<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_GTM_REGISTER_GTMTAB_V_16)
            int_gtm_register_int_gtmTab_V_16<=WDATA;
    end
end

// int_gtm_register_int_gtmTab_V_17[9:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_gtm_register_int_gtmTab_V_17<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_GTM_REGISTER_GTMTAB_V_17)
            int_gtm_register_int_gtmTab_V_17<=WDATA;
    end
end

// int_gtm_register_int_gtmTab_V_18[9:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_gtm_register_int_gtmTab_V_18<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_GTM_REGISTER_GTMTAB_V_18)
            int_gtm_register_int_gtmTab_V_18<=WDATA;
    end
end

// int_gtm_register_int_gtmTab_V_19[9:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_gtm_register_int_gtmTab_V_19<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_GTM_REGISTER_GTMTAB_V_19)
            int_gtm_register_int_gtmTab_V_19<=WDATA;
    end
end

// int_gtm_register_int_gtmTab_V_20[9:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_gtm_register_int_gtmTab_V_20<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_GTM_REGISTER_GTMTAB_V_20)
            int_gtm_register_int_gtmTab_V_20<=WDATA;
    end
end

// int_gtm_register_int_gtmTab_V_21[9:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_gtm_register_int_gtmTab_V_21<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_GTM_REGISTER_GTMTAB_V_21)
            int_gtm_register_int_gtmTab_V_21<=WDATA;
    end
end

// int_gtm_register_int_gtmTab_V_22[9:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_gtm_register_int_gtmTab_V_22<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_GTM_REGISTER_GTMTAB_V_22)
            int_gtm_register_int_gtmTab_V_22<=WDATA;
    end
end

// int_gtm_register_int_gtmTab_V_23[9:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_gtm_register_int_gtmTab_V_23<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_GTM_REGISTER_GTMTAB_V_23)
            int_gtm_register_int_gtmTab_V_23<=WDATA;
    end
end

// int_gtm_register_int_gtmTab_V_24[9:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_gtm_register_int_gtmTab_V_24<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_GTM_REGISTER_GTMTAB_V_24)
            int_gtm_register_int_gtmTab_V_24<=WDATA;
    end
end

// int_gtm_register_int_gtmTab_V_25[9:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_gtm_register_int_gtmTab_V_25<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_GTM_REGISTER_GTMTAB_V_25)
            int_gtm_register_int_gtmTab_V_25<=WDATA;
    end
end

// int_gtm_register_int_gtmTab_V_26[9:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_gtm_register_int_gtmTab_V_26<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_GTM_REGISTER_GTMTAB_V_26)
            int_gtm_register_int_gtmTab_V_26<=WDATA;
    end
end

// int_gtm_register_int_gtmTab_V_27[9:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_gtm_register_int_gtmTab_V_27<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_GTM_REGISTER_GTMTAB_V_27)
            int_gtm_register_int_gtmTab_V_27<=WDATA;
    end
end

// int_gtm_register_int_gtmTab_V_28[9:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_gtm_register_int_gtmTab_V_28<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_GTM_REGISTER_GTMTAB_V_28)
            int_gtm_register_int_gtmTab_V_28<=WDATA;
    end
end

// int_gtm_register_int_gtmTab_V_29[9:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_gtm_register_int_gtmTab_V_29<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_GTM_REGISTER_GTMTAB_V_29)
            int_gtm_register_int_gtmTab_V_29<=WDATA;
    end
end

// int_gtm_register_int_gtmTab_V_30[9:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_gtm_register_int_gtmTab_V_30<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_GTM_REGISTER_GTMTAB_V_30)
            int_gtm_register_int_gtmTab_V_30<=WDATA;
    end
end

// int_gtm_register_int_gtmTab_V_31[9:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_gtm_register_int_gtmTab_V_31<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_GTM_REGISTER_GTMTAB_V_31)
            int_gtm_register_int_gtmTab_V_31<=WDATA;
    end
end

// int_gtm_register_int_gtmTab_V_32[9:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_gtm_register_int_gtmTab_V_32<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_GTM_REGISTER_GTMTAB_V_32)
            int_gtm_register_int_gtmTab_V_32<=WDATA;
    end
end

// int_gtm_register_int_gtmTab_V_33[9:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_gtm_register_int_gtmTab_V_33<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_GTM_REGISTER_GTMTAB_V_33)
            int_gtm_register_int_gtmTab_V_33<=WDATA;
    end
end

// int_gtm_register_int_gtmTab_V_34[9:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_gtm_register_int_gtmTab_V_34<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_GTM_REGISTER_GTMTAB_V_34)
            int_gtm_register_int_gtmTab_V_34<=WDATA;
    end
end

// int_gtm_register_int_gtmTab_V_35[9:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_gtm_register_int_gtmTab_V_35<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_GTM_REGISTER_GTMTAB_V_35)
            int_gtm_register_int_gtmTab_V_35<=WDATA;
    end
end

// int_gtm_register_int_gtmTab_V_36[9:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_gtm_register_int_gtmTab_V_36<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_GTM_REGISTER_GTMTAB_V_36)
            int_gtm_register_int_gtmTab_V_36<=WDATA;
    end
end

// int_gtm_register_int_gtmTab_V_37[9:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_gtm_register_int_gtmTab_V_37<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_GTM_REGISTER_GTMTAB_V_37)
            int_gtm_register_int_gtmTab_V_37<=WDATA;
    end
end

// int_gtm_register_int_gtmTab_V_38[9:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_gtm_register_int_gtmTab_V_38<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_GTM_REGISTER_GTMTAB_V_38)
            int_gtm_register_int_gtmTab_V_38<=WDATA;
    end
end

// int_gtm_register_int_gtmTab_V_39[9:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_gtm_register_int_gtmTab_V_39<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_GTM_REGISTER_GTMTAB_V_39)
            int_gtm_register_int_gtmTab_V_39<=WDATA;
    end
end

// int_gtm_register_int_gtmTab_V_40[9:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_gtm_register_int_gtmTab_V_40<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_GTM_REGISTER_GTMTAB_V_40)
            int_gtm_register_int_gtmTab_V_40<=WDATA;
    end
end

// int_gtm_register_int_gtmTab_V_41[9:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_gtm_register_int_gtmTab_V_41<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_GTM_REGISTER_GTMTAB_V_41)
            int_gtm_register_int_gtmTab_V_41<=WDATA;
    end
end

// int_gtm_register_int_gtmTab_V_42[9:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_gtm_register_int_gtmTab_V_42<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_GTM_REGISTER_GTMTAB_V_42)
            int_gtm_register_int_gtmTab_V_42<=WDATA;
    end
end

// int_gtm_register_int_gtmTab_V_43[9:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_gtm_register_int_gtmTab_V_43<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_GTM_REGISTER_GTMTAB_V_43)
            int_gtm_register_int_gtmTab_V_43<=WDATA;
    end
end

// int_gtm_register_int_gtmTab_V_44[9:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_gtm_register_int_gtmTab_V_44<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_GTM_REGISTER_GTMTAB_V_44)
            int_gtm_register_int_gtmTab_V_44<=WDATA;
    end
end

// int_gtm_register_int_gtmTab_V_45[9:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_gtm_register_int_gtmTab_V_45<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_GTM_REGISTER_GTMTAB_V_45)
            int_gtm_register_int_gtmTab_V_45<=WDATA;
    end
end

// int_gtm_register_int_gtmTab_V_46[9:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_gtm_register_int_gtmTab_V_46<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_GTM_REGISTER_GTMTAB_V_46)
            int_gtm_register_int_gtmTab_V_46<=WDATA;
    end
end

// int_gtm_register_int_gtmTab_V_47[9:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_gtm_register_int_gtmTab_V_47<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_GTM_REGISTER_GTMTAB_V_47)
            int_gtm_register_int_gtmTab_V_47<=WDATA;
    end
end

// int_gtm_register_int_gtmTab_V_48[9:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_gtm_register_int_gtmTab_V_48<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_GTM_REGISTER_GTMTAB_V_48)
            int_gtm_register_int_gtmTab_V_48<=WDATA;
    end
end

// int_gtm_register_int_gtmTab_V_49[9:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_gtm_register_int_gtmTab_V_49<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_GTM_REGISTER_GTMTAB_V_49)
            int_gtm_register_int_gtmTab_V_49<=WDATA;
    end
end

// int_gtm_register_int_gtmTab_V_50[9:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_gtm_register_int_gtmTab_V_50<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_GTM_REGISTER_GTMTAB_V_50)
            int_gtm_register_int_gtmTab_V_50<=WDATA;
    end
end

// int_gtm_register_int_gtmTab_V_51[9:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_gtm_register_int_gtmTab_V_51<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_GTM_REGISTER_GTMTAB_V_51)
            int_gtm_register_int_gtmTab_V_51<=WDATA;
    end
end

// int_gtm_register_int_gtmTab_V_52[9:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_gtm_register_int_gtmTab_V_52<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_GTM_REGISTER_GTMTAB_V_52)
            int_gtm_register_int_gtmTab_V_52<=WDATA;
    end
end

// int_gtm_register_int_gtmTab_V_53[9:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_gtm_register_int_gtmTab_V_53<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_GTM_REGISTER_GTMTAB_V_53)
            int_gtm_register_int_gtmTab_V_53<=WDATA;
    end
end

// int_gtm_register_int_gtmTab_V_54[9:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_gtm_register_int_gtmTab_V_54<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_GTM_REGISTER_GTMTAB_V_54)
            int_gtm_register_int_gtmTab_V_54<=WDATA;
    end
end

// int_gtm_register_int_gtmTab_V_55[9:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_gtm_register_int_gtmTab_V_55<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_GTM_REGISTER_GTMTAB_V_55)
            int_gtm_register_int_gtmTab_V_55<=WDATA;
    end
end

// int_gtm_register_int_gtmTab_V_56[9:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_gtm_register_int_gtmTab_V_56<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_GTM_REGISTER_GTMTAB_V_56)
            int_gtm_register_int_gtmTab_V_56<=WDATA;
    end
end

// int_gtm_register_int_gtmTab_V_57[9:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_gtm_register_int_gtmTab_V_57<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_GTM_REGISTER_GTMTAB_V_57)
            int_gtm_register_int_gtmTab_V_57<=WDATA;
    end
end

// int_gtm_register_int_gtmTab_V_58[9:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_gtm_register_int_gtmTab_V_58<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_GTM_REGISTER_GTMTAB_V_58)
            int_gtm_register_int_gtmTab_V_58<=WDATA;
    end
end

// int_gtm_register_int_gtmTab_V_59[9:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_gtm_register_int_gtmTab_V_59<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_GTM_REGISTER_GTMTAB_V_59)
            int_gtm_register_int_gtmTab_V_59<=WDATA;
    end
end

// int_gtm_register_int_gtmTab_V_60[9:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_gtm_register_int_gtmTab_V_60<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_GTM_REGISTER_GTMTAB_V_60)
            int_gtm_register_int_gtmTab_V_60<=WDATA;
    end
end

// int_gtm_register_int_gtmTab_V_61[9:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_gtm_register_int_gtmTab_V_61<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_GTM_REGISTER_GTMTAB_V_61)
            int_gtm_register_int_gtmTab_V_61<=WDATA;
    end
end

// int_gtm_register_int_gtmTab_V_62[9:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_gtm_register_int_gtmTab_V_62<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_GTM_REGISTER_GTMTAB_V_62)
            int_gtm_register_int_gtmTab_V_62<=WDATA;
    end
end

// int_gtm_register_int_gtmTab_V_63[9:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_gtm_register_int_gtmTab_V_63<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_GTM_REGISTER_GTMTAB_V_63)
            int_gtm_register_int_gtmTab_V_63<=WDATA;
    end
end

// int_gtm_register_int_gtmTab_V_64[9:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_gtm_register_int_gtmTab_V_64<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_GTM_REGISTER_GTMTAB_V_64)
            int_gtm_register_int_gtmTab_V_64<=WDATA;
    end
end

// int_gtm_register_int_gtmTab_V_65[9:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_gtm_register_int_gtmTab_V_65<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_GTM_REGISTER_GTMTAB_V_65)
            int_gtm_register_int_gtmTab_V_65<=WDATA;
    end
end

// int_gtm_register_int_gtmTab_V_66[9:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_gtm_register_int_gtmTab_V_66<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_GTM_REGISTER_GTMTAB_V_66)
            int_gtm_register_int_gtmTab_V_66<=WDATA;
    end
end

// int_gtm_register_int_gtmTab_V_67[9:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_gtm_register_int_gtmTab_V_67<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_GTM_REGISTER_GTMTAB_V_67)
            int_gtm_register_int_gtmTab_V_67<=WDATA;
    end
end

// int_gtm_register_int_gtmTab_V_68[9:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_gtm_register_int_gtmTab_V_68<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_GTM_REGISTER_GTMTAB_V_68)
            int_gtm_register_int_gtmTab_V_68<=WDATA;
    end
end

// int_gtm_register_int_gtmTab_V_69[9:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_gtm_register_int_gtmTab_V_69<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_GTM_REGISTER_GTMTAB_V_69)
            int_gtm_register_int_gtmTab_V_69<=WDATA;
    end
end

// int_gtm_register_int_gtmTab_V_70[9:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_gtm_register_int_gtmTab_V_70<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_GTM_REGISTER_GTMTAB_V_70)
            int_gtm_register_int_gtmTab_V_70<=WDATA;
    end
end

// int_gtm_register_int_gtmTab_V_71[9:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_gtm_register_int_gtmTab_V_71<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_GTM_REGISTER_GTMTAB_V_71)
            int_gtm_register_int_gtmTab_V_71<=WDATA;
    end
end

// int_gtm_register_int_gtmTab_V_72[9:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_gtm_register_int_gtmTab_V_72<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_GTM_REGISTER_GTMTAB_V_72)
            int_gtm_register_int_gtmTab_V_72<=WDATA;
    end
end

// int_gtm_register_int_gtmTab_V_73[9:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_gtm_register_int_gtmTab_V_73<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_GTM_REGISTER_GTMTAB_V_73)
            int_gtm_register_int_gtmTab_V_73<=WDATA;
    end
end

// int_gtm_register_int_gtmTab_V_74[9:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_gtm_register_int_gtmTab_V_74<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_GTM_REGISTER_GTMTAB_V_74)
            int_gtm_register_int_gtmTab_V_74<=WDATA;
    end
end

// int_gtm_register_int_gtmTab_V_75[9:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_gtm_register_int_gtmTab_V_75<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_GTM_REGISTER_GTMTAB_V_75)
            int_gtm_register_int_gtmTab_V_75<=WDATA;
    end
end

// int_gtm_register_int_gtmTab_V_76[9:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_gtm_register_int_gtmTab_V_76<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_GTM_REGISTER_GTMTAB_V_76)
            int_gtm_register_int_gtmTab_V_76<=WDATA;
    end
end

// int_gtm_register_int_gtmTab_V_77[9:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_gtm_register_int_gtmTab_V_77<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_GTM_REGISTER_GTMTAB_V_77)
            int_gtm_register_int_gtmTab_V_77<=WDATA;
    end
end

// int_gtm_register_int_gtmTab_V_78[9:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_gtm_register_int_gtmTab_V_78<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_GTM_REGISTER_GTMTAB_V_78)
            int_gtm_register_int_gtmTab_V_78<=WDATA;
    end
end

// int_gtm_register_int_gtmTab_V_79[9:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_gtm_register_int_gtmTab_V_79<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_GTM_REGISTER_GTMTAB_V_79)
            int_gtm_register_int_gtmTab_V_79<=WDATA;
    end
end

// int_gtm_register_int_gtmTab_V_80[9:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_gtm_register_int_gtmTab_V_80<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_GTM_REGISTER_GTMTAB_V_80)
            int_gtm_register_int_gtmTab_V_80<=WDATA;
    end
end

// int_gtm_register_int_gtmTab_V_81[9:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_gtm_register_int_gtmTab_V_81<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_GTM_REGISTER_GTMTAB_V_81)
            int_gtm_register_int_gtmTab_V_81<=WDATA;
    end
end

// int_gtm_register_int_gtmTab_V_82[9:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_gtm_register_int_gtmTab_V_82<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_GTM_REGISTER_GTMTAB_V_82)
            int_gtm_register_int_gtmTab_V_82<=WDATA;
    end
end

// int_gtm_register_int_gtmTab_V_83[9:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_gtm_register_int_gtmTab_V_83<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_GTM_REGISTER_GTMTAB_V_83)
            int_gtm_register_int_gtmTab_V_83<=WDATA;
    end
end

// int_gtm_register_int_gtmTab_V_84[9:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_gtm_register_int_gtmTab_V_84<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_GTM_REGISTER_GTMTAB_V_84)
            int_gtm_register_int_gtmTab_V_84<=WDATA;
    end
end

// int_gtm_register_int_gtmTab_V_85[9:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_gtm_register_int_gtmTab_V_85<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_GTM_REGISTER_GTMTAB_V_85)
            int_gtm_register_int_gtmTab_V_85<=WDATA;
    end
end

// int_gtm_register_int_gtmTab_V_86[9:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_gtm_register_int_gtmTab_V_86<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_GTM_REGISTER_GTMTAB_V_86)
            int_gtm_register_int_gtmTab_V_86<=WDATA;
    end
end

// int_gtm_register_int_gtmTab_V_87[9:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_gtm_register_int_gtmTab_V_87<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_GTM_REGISTER_GTMTAB_V_87)
            int_gtm_register_int_gtmTab_V_87<=WDATA;
    end
end

// int_gtm_register_int_gtmTab_V_88[9:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_gtm_register_int_gtmTab_V_88<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_GTM_REGISTER_GTMTAB_V_88)
            int_gtm_register_int_gtmTab_V_88<=WDATA;
    end
end

// int_gtm_register_int_gtmTab_V_89[9:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_gtm_register_int_gtmTab_V_89<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_GTM_REGISTER_GTMTAB_V_89)
            int_gtm_register_int_gtmTab_V_89<=WDATA;
    end
end

// int_gtm_register_int_gtmTab_V_90[9:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_gtm_register_int_gtmTab_V_90<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_GTM_REGISTER_GTMTAB_V_90)
            int_gtm_register_int_gtmTab_V_90<=WDATA;
    end
end

// int_gtm_register_int_gtmTab_V_91[9:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_gtm_register_int_gtmTab_V_91<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_GTM_REGISTER_GTMTAB_V_91)
            int_gtm_register_int_gtmTab_V_91<=WDATA;
    end
end

// int_gtm_register_int_gtmTab_V_92[9:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_gtm_register_int_gtmTab_V_92<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_GTM_REGISTER_GTMTAB_V_92)
            int_gtm_register_int_gtmTab_V_92<=WDATA;
    end
end

// int_gtm_register_int_gtmTab_V_93[9:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_gtm_register_int_gtmTab_V_93<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_GTM_REGISTER_GTMTAB_V_93)
            int_gtm_register_int_gtmTab_V_93<=WDATA;
    end
end

// int_gtm_register_int_gtmTab_V_94[9:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_gtm_register_int_gtmTab_V_94<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_GTM_REGISTER_GTMTAB_V_94)
            int_gtm_register_int_gtmTab_V_94<=WDATA;
    end
end

// int_gtm_register_int_gtmTab_V_95[9:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_gtm_register_int_gtmTab_V_95<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_GTM_REGISTER_GTMTAB_V_95)
            int_gtm_register_int_gtmTab_V_95<=WDATA;
    end
end

// int_gtm_register_int_gtmTab_V_96[9:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_gtm_register_int_gtmTab_V_96<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_GTM_REGISTER_GTMTAB_V_96)
            int_gtm_register_int_gtmTab_V_96<=WDATA;
    end
end

// int_gtm_register_int_gtmTab_V_97[9:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_gtm_register_int_gtmTab_V_97<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_GTM_REGISTER_GTMTAB_V_97)
            int_gtm_register_int_gtmTab_V_97<=WDATA;
    end
end

// int_gtm_register_int_gtmTab_V_98[9:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_gtm_register_int_gtmTab_V_98<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_GTM_REGISTER_GTMTAB_V_98)
            int_gtm_register_int_gtmTab_V_98<=WDATA;
    end
end

// int_gtm_register_int_gtmTab_V_99[9:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_gtm_register_int_gtmTab_V_99<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_GTM_REGISTER_GTMTAB_V_99)
            int_gtm_register_int_gtmTab_V_99<=WDATA;
    end
end

// int_gtm_register_int_gtmTab_V_100[9:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_gtm_register_int_gtmTab_V_100<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_GTM_REGISTER_GTMTAB_V_100)
            int_gtm_register_int_gtmTab_V_100<=WDATA;
    end
end

// int_gtm_register_int_gtmTab_V_101[9:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_gtm_register_int_gtmTab_V_101<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_GTM_REGISTER_GTMTAB_V_101)
            int_gtm_register_int_gtmTab_V_101<=WDATA;
    end
end

// int_gtm_register_int_gtmTab_V_102[9:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_gtm_register_int_gtmTab_V_102<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_GTM_REGISTER_GTMTAB_V_102)
            int_gtm_register_int_gtmTab_V_102<=WDATA;
    end
end

// int_gtm_register_int_gtmTab_V_103[9:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_gtm_register_int_gtmTab_V_103<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_GTM_REGISTER_GTMTAB_V_103)
            int_gtm_register_int_gtmTab_V_103<=WDATA;
    end
end

// int_gtm_register_int_gtmTab_V_104[9:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_gtm_register_int_gtmTab_V_104<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_GTM_REGISTER_GTMTAB_V_104)
            int_gtm_register_int_gtmTab_V_104<=WDATA;
    end
end

// int_gtm_register_int_gtmTab_V_105[9:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_gtm_register_int_gtmTab_V_105<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_GTM_REGISTER_GTMTAB_V_105)
            int_gtm_register_int_gtmTab_V_105<=WDATA;
    end
end

// int_gtm_register_int_gtmTab_V_106[9:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_gtm_register_int_gtmTab_V_106<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_GTM_REGISTER_GTMTAB_V_106)
            int_gtm_register_int_gtmTab_V_106<=WDATA;
    end
end

// int_gtm_register_int_gtmTab_V_107[9:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_gtm_register_int_gtmTab_V_107<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_GTM_REGISTER_GTMTAB_V_107)
            int_gtm_register_int_gtmTab_V_107<=WDATA;
    end
end

// int_gtm_register_int_gtmTab_V_108[9:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_gtm_register_int_gtmTab_V_108<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_GTM_REGISTER_GTMTAB_V_108)
            int_gtm_register_int_gtmTab_V_108<=WDATA;
    end
end

// int_gtm_register_int_gtmTab_V_109[9:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_gtm_register_int_gtmTab_V_109<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_GTM_REGISTER_GTMTAB_V_109)
            int_gtm_register_int_gtmTab_V_109<=WDATA;
    end
end

// int_gtm_register_int_gtmTab_V_110[9:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_gtm_register_int_gtmTab_V_110<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_GTM_REGISTER_GTMTAB_V_110)
            int_gtm_register_int_gtmTab_V_110<=WDATA;
    end
end

// int_gtm_register_int_gtmTab_V_111[9:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_gtm_register_int_gtmTab_V_111<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_GTM_REGISTER_GTMTAB_V_111)
            int_gtm_register_int_gtmTab_V_111<=WDATA;
    end
end

// int_gtm_register_int_gtmTab_V_112[9:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_gtm_register_int_gtmTab_V_112<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_GTM_REGISTER_GTMTAB_V_112)
            int_gtm_register_int_gtmTab_V_112<=WDATA;
    end
end

// int_gtm_register_int_gtmTab_V_113[9:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_gtm_register_int_gtmTab_V_113<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_GTM_REGISTER_GTMTAB_V_113)
            int_gtm_register_int_gtmTab_V_113<=WDATA;
    end
end

// int_gtm_register_int_gtmTab_V_114[9:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_gtm_register_int_gtmTab_V_114<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_GTM_REGISTER_GTMTAB_V_114)
            int_gtm_register_int_gtmTab_V_114<=WDATA;
    end
end

// int_gtm_register_int_gtmTab_V_115[9:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_gtm_register_int_gtmTab_V_115<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_GTM_REGISTER_GTMTAB_V_115)
            int_gtm_register_int_gtmTab_V_115<=WDATA;
    end
end

// int_gtm_register_int_gtmTab_V_116[9:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_gtm_register_int_gtmTab_V_116<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_GTM_REGISTER_GTMTAB_V_116)
            int_gtm_register_int_gtmTab_V_116<=WDATA;
    end
end

// int_gtm_register_int_gtmTab_V_117[9:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_gtm_register_int_gtmTab_V_117<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_GTM_REGISTER_GTMTAB_V_117)
            int_gtm_register_int_gtmTab_V_117<=WDATA;
    end
end

// int_gtm_register_int_gtmTab_V_118[9:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_gtm_register_int_gtmTab_V_118<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_GTM_REGISTER_GTMTAB_V_118)
            int_gtm_register_int_gtmTab_V_118<=WDATA;
    end
end

// int_gtm_register_int_gtmTab_V_119[9:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_gtm_register_int_gtmTab_V_119<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_GTM_REGISTER_GTMTAB_V_119)
            int_gtm_register_int_gtmTab_V_119<=WDATA;
    end
end

// int_gtm_register_int_gtmTab_V_120[9:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_gtm_register_int_gtmTab_V_120<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_GTM_REGISTER_GTMTAB_V_120)
            int_gtm_register_int_gtmTab_V_120<=WDATA;
    end
end

// int_gtm_register_int_gtmTab_V_121[9:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_gtm_register_int_gtmTab_V_121<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_GTM_REGISTER_GTMTAB_V_121)
            int_gtm_register_int_gtmTab_V_121<=WDATA;
    end
end

// int_gtm_register_int_gtmTab_V_122[9:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_gtm_register_int_gtmTab_V_122<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_GTM_REGISTER_GTMTAB_V_122)
            int_gtm_register_int_gtmTab_V_122<=WDATA;
    end
end

// int_gtm_register_int_gtmTab_V_123[9:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_gtm_register_int_gtmTab_V_123<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_GTM_REGISTER_GTMTAB_V_123)
            int_gtm_register_int_gtmTab_V_123<=WDATA;
    end
end

// int_gtm_register_int_gtmTab_V_124[9:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_gtm_register_int_gtmTab_V_124<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_GTM_REGISTER_GTMTAB_V_124)
            int_gtm_register_int_gtmTab_V_124<=WDATA;
    end
end

// int_gtm_register_int_gtmTab_V_125[9:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_gtm_register_int_gtmTab_V_125<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_GTM_REGISTER_GTMTAB_V_125)
            int_gtm_register_int_gtmTab_V_125<=WDATA;
    end
end

// int_gtm_register_int_gtmTab_V_126[9:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_gtm_register_int_gtmTab_V_126<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_GTM_REGISTER_GTMTAB_V_126)
            int_gtm_register_int_gtmTab_V_126<=WDATA;
    end
end

// int_gtm_register_int_gtmTab_V_127[9:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_gtm_register_int_gtmTab_V_127<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_GTM_REGISTER_GTMTAB_V_127)
            int_gtm_register_int_gtmTab_V_127<=WDATA;
    end
end

// int_gtm_register_int_gtmTab_V_128[9:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_gtm_register_int_gtmTab_V_128<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_GTM_REGISTER_GTMTAB_V_128)
            int_gtm_register_int_gtmTab_V_128<=WDATA;
    end
end

// int_ltm_register_m_nEb_V[0:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_ltm_register_m_nEb_V<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LTM_REGISTER_M_NEB_V)
            int_ltm_register_m_nEb_V<=WDATA;
    end
end

// int_ltm_register_contrast_V[15:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_ltm_register_contrast_V<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LTM_REGISTER_CONTRAST_V)
            int_ltm_register_contrast_V<=WDATA;
    end
end

// int_ltm_register_ratio_V[15:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_ltm_register_ratio_V<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_LTM_REGISTER_RATIO_V)
            int_ltm_register_ratio_V<=WDATA;
    end
end

// int_cac_register_eb[0:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_cac_register_eb<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_CAC_REGISTER_EB)
            int_cac_register_eb<=WDATA;
    end
end

// int_cac_register_t_transient_V[16:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_cac_register_t_transient_V<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_CAC_REGISTER_T_TRANSIENT_V)
            int_cac_register_t_transient_V<=WDATA;
    end
end

// int_cac_register_t_edge_V[16:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_cac_register_t_edge_V<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_CAC_REGISTER_T_EDGE_V)
            int_cac_register_t_edge_V<=WDATA;
    end
end

// int_csc_register_m_nEb[0:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_csc_register_m_nEb<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_CSC_REGISTER_M_NEB)
            int_csc_register_m_nEb<=WDATA;
    end
end

// int_csc_register_coeff_V_0[10:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_csc_register_coeff_V_0<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_CSC_REGISTER_COEFF_V_0)
            int_csc_register_coeff_V_0<=WDATA;
    end
end

// int_csc_register_coeff_V_1[10:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_csc_register_coeff_V_1<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_CSC_REGISTER_COEFF_V_1)
            int_csc_register_coeff_V_1<=WDATA;
    end
end

// int_csc_register_coeff_V_2[10:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_csc_register_coeff_V_2<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_CSC_REGISTER_COEFF_V_2)
            int_csc_register_coeff_V_2<=WDATA;
    end
end

// int_csc_register_coeff_V_3[10:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_csc_register_coeff_V_3<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_CSC_REGISTER_COEFF_V_3)
            int_csc_register_coeff_V_3<=WDATA;
    end
end

// int_csc_register_coeff_V_4[10:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_csc_register_coeff_V_4<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_CSC_REGISTER_COEFF_V_4)
            int_csc_register_coeff_V_4<=WDATA;
    end
end

// int_csc_register_coeff_V_5[10:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_csc_register_coeff_V_5<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_CSC_REGISTER_COEFF_V_5)
            int_csc_register_coeff_V_5<=WDATA;
    end
end

// int_csc_register_coeff_V_6[10:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_csc_register_coeff_V_6<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_CSC_REGISTER_COEFF_V_6)
            int_csc_register_coeff_V_6<=WDATA;
    end
end

// int_csc_register_coeff_V_7[10:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_csc_register_coeff_V_7<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_CSC_REGISTER_COEFF_V_7)
            int_csc_register_coeff_V_7<=WDATA;
    end
end

// int_csc_register_coeff_V_8[10:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_csc_register_coeff_V_8<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_CSC_REGISTER_COEFF_V_8)
            int_csc_register_coeff_V_8<=WDATA;
    end
end

// int_csc_register_coeff_V_9[10:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_csc_register_coeff_V_9<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_CSC_REGISTER_COEFF_V_9)
            int_csc_register_coeff_V_9<=WDATA;
    end
end

// int_csc_register_coeff_V_10[10:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_csc_register_coeff_V_10<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_CSC_REGISTER_COEFF_V_10)
            int_csc_register_coeff_V_10<=WDATA;
    end
end

// int_csc_register_coeff_V_11[10:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_csc_register_coeff_V_11<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_CSC_REGISTER_COEFF_V_11)
            int_csc_register_coeff_V_11<=WDATA;
    end
end

// int_yfc_register_m_nEb[0:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_yfc_register_m_nEb<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_YFC_REGISTER_M_NEB)
            int_yfc_register_m_nEb<=WDATA;
    end
end

// int_yfc_register_yuvpattern[0:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_yfc_register_yuvpattern<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_YFC_REGISTER_YUVPATTERN)
            int_yfc_register_yuvpattern<=WDATA;
    end
end

// int_yuvdns_register_eb_V[0:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_yuvdns_register_eb_V<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_YUVDNS_REGISTER_EB_V)
            int_yuvdns_register_eb_V<=WDATA;
    end
end

// int_yuvdns_register_ysigma2_V[13:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_yuvdns_register_ysigma2_V<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_YUVDNS_REGISTER_YSIGMA2_V)
            int_yuvdns_register_ysigma2_V<=WDATA;
    end
end

// int_yuvdns_register_yinvsigma2_V[9:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_yuvdns_register_yinvsigma2_V<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_YUVDNS_REGISTER_YINVSIGMA2_V)
            int_yuvdns_register_yinvsigma2_V<=WDATA;
    end
end

// int_yuvdns_register_uvsigma2_V[13:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_yuvdns_register_uvsigma2_V<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_YUVDNS_REGISTER_UVSIGMA2_V)
            int_yuvdns_register_uvsigma2_V<=WDATA;
    end
end

// int_yuvdns_register_uvinvsigma2_V[9:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_yuvdns_register_uvinvsigma2_V<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_YUVDNS_REGISTER_UVINVSIGMA2_V)
            int_yuvdns_register_uvinvsigma2_V<=WDATA;
    end
end

// int_yuvdns_register_yfilt_V[3:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_yuvdns_register_yfilt_V<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_YUVDNS_REGISTER_YFILT_V)
            int_yuvdns_register_yfilt_V<=WDATA;
    end
end

// int_yuvdns_register_uvfilt_V[3:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_yuvdns_register_uvfilt_V<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_YUVDNS_REGISTER_UVFILT_V)
            int_yuvdns_register_uvfilt_V<=WDATA;
    end
end

// int_yuvdns_register_yinvfilt_V[4:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_yuvdns_register_yinvfilt_V<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_YUVDNS_REGISTER_YINVFILT_V)
            int_yuvdns_register_yinvfilt_V<=WDATA;
    end
end

// int_yuvdns_register_uvinvfilt_V[4:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_yuvdns_register_uvinvfilt_V<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_YUVDNS_REGISTER_UVINVFILT_V)
            int_yuvdns_register_uvinvfilt_V<=WDATA;
    end
end

// int_yuvdns_register_yH2_V[13:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_yuvdns_register_yH2_V<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_YUVDNS_REGISTER_YH2_V)
            int_yuvdns_register_yH2_V<=WDATA;
    end
end

// int_yuvdns_register_yinvH2_V[17:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_yuvdns_register_yinvH2_V<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_YUVDNS_REGISTER_YINVH2_V)
            int_yuvdns_register_yinvH2_V<=WDATA;
    end
end

// int_yuvdns_register_uvH2_V[13:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_yuvdns_register_uvH2_V<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_YUVDNS_REGISTER_UVH2_V)
            int_yuvdns_register_uvH2_V<=WDATA;
    end
end

// int_yuvdns_register_uvinvH2_V[17:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_yuvdns_register_uvinvH2_V<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_YUVDNS_REGISTER_UVINVH2_V)
            int_yuvdns_register_uvinvH2_V<=WDATA;
    end
end

// int_scaledown_register_m_nEb[0:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_scaledown_register_m_nEb<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_SCALEDOWN_REGISTER_M_NEB)
            int_scaledown_register_m_nEb<=WDATA;
    end
end

// int_scaledown_register_yuvpattern_V[1:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_scaledown_register_yuvpattern_V<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_SCALEDOWN_REGISTER_YUVPATTERN_V)
            int_scaledown_register_yuvpattern_V<=WDATA;
    end
end

// int_scaledown_register_times_V[4:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_scaledown_register_times_V<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_SCALEDOWN_REGISTER_TIMES_V)
            int_scaledown_register_times_V<=WDATA;
    end
end

// int_crop_register_m_nEb[0:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_crop_register_m_nEb<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_CROP_REGISTER_M_NEB)
            int_crop_register_m_nEb<=WDATA;
    end
end

// int_crop_register_upper_left_x_V[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_crop_register_upper_left_x_V<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_CROP_REGISTER_UPPER_LEFT_X_V)
            int_crop_register_upper_left_x_V<=WDATA;
    end
end

// int_crop_register_upper_left_y_V[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_crop_register_upper_left_y_V<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_CROP_REGISTER_UPPER_LEFT_Y_V)
            int_crop_register_upper_left_y_V<=WDATA;
    end
end

// int_crop_register_lower_right_x_V[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_crop_register_lower_right_x_V<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_CROP_REGISTER_LOWER_RIGHT_X_V)
            int_crop_register_lower_right_x_V<=WDATA;
    end
end

// int_crop_register_lower_right_y_V[12:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_crop_register_lower_right_y_V<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_CROP_REGISTER_LOWER_RIGHT_Y_V)
            int_crop_register_lower_right_y_V<=WDATA;
    end
end

// int_crop_register_yuvpattern_V[1:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_crop_register_yuvpattern_V<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_CROP_REGISTER_YUVPATTERN_V)
            int_crop_register_yuvpattern_V<=WDATA;
    end
end

// int_isp_read_raw_addr[31:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_crop_register_yuvpattern_V<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_ISP_READ_RAW_ADDR)
            int_crop_register_yuvpattern_V<=WDATA;
    end
end

//int_isp_write_y_addr[31:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_isp_write_y_addr<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_ISP_WRITE_Y_ADDR)
            int_isp_write_y_addr<=WDATA;
    end
end
//int_isp_write_u_addr[31:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_isp_write_u_addr<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_ISP_WRITE_U_ADDR)
            int_isp_write_u_addr<=WDATA;
    end
end
//int_isp_write_v_addr[31:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_isp_write_v_addr<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_ISP_WRITE_V_ADDR)
            int_isp_write_v_addr<=WDATA;
    end
end
//int_burst_one_frame_total[31:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_burst_one_frame_total<=0;
    else if (ACLK_EN) begin
        if(w_hs && waddr == ADDR_BURST_ONE_FRAME_TOTAL)
            int_burst_one_frame_total<=WDATA;
    end
end


endmodule
