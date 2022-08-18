solution new -state initial
solution options defaults
solution options set /Input/CppStandard c++11
solution options set /Input/TargetPlatform x86_64
solution options set /Output/GenerateCycleNetlist false
solution options set /Flows/SCVerify/USE_QUESTASIM false
solution options set /Flows/SCVerify/USE_VCS true
flow package require /SCVerify
solution file add ../../src/tpg.h -type CHEADER
solution file add ../../src/tpg.cpp -type C++
solution file add ../../src/dgain.h -type CHEADER
solution file add ../../src/dgain.cpp -type C++
solution file add ../../src/lsc.h -type CHEADER
solution file add ../../src/lsc.cpp -type C++
solution file add ../../src/dpc.h -type CHEADER
solution file add ../../src/dpc.cpp -type C++
solution file add ../../src/rawdns.h -type CHEADER
solution file add ../../src/rawdns.cpp -type C++
solution file add ../../src/awb.cpp -type C++
solution file add ../../src/awb.h -type CHEADER
solution file add ../../src/wbc.h -type CHEADER
solution file add ../../src/wbc.cpp -type C++
solution file add ../../src/gb.h -type CHEADER
solution file add ../../src/gb.cpp -type C++
solution file add ../../src/demosaic.h -type CHEADER
solution file add ../../src/demosaic.cpp -type C++
solution file add ../../src/ee.h -type CHEADER
solution file add ../../src/ee.cpp -type C++
solution file add ../../src/cmc.h -type CHEADER
solution file add ../../src/cmc.cpp -type C++
solution file add ../../src/gtm.h -type CHEADER
solution file add ../../src/gtm.cpp -type C++
solution file add ../../src/csc.h -type CHEADER
solution file add ../../src/csc.cpp -type C++
solution file add ../../src/yfc.h -type CHEADER
solution file add ../../src/yfc.cpp -type C++
solution file add ../../src/yuvdns.h -type CHEADER
solution file add ../../src/yuvdns.cpp -type C++
solution file add ../../src/scaledown.h -type CHEADER
solution file add ../../src/scaledown.cpp -type C++
solution file add ../../src/crop.h -type CHEADER
solution file add ../../src/crop.cpp -type C++
solution file add ../../src/top.h -type CHEADER
solution file add ../../src/top.cpp -type C++
solution file add ../../src/isp_top.h -type CHEADER
solution file add ../../tb/tb_top.cpp -type C++ -exclude true

directive set -DESIGN_GOAL area
directive set -SPECULATE true
directive set -MERGEABLE true
directive set -REGISTER_THRESHOLD 256
directive set -MEM_MAP_THRESHOLD 32
directive set -LOGIC_OPT false
directive set -FSM_ENCODING none
directive set -FSM_BINARY_ENCODING_THRESHOLD 64
directive set -REG_MAX_FANOUT 0
directive set -NO_X_ASSIGNMENTS true
directive set -SAFE_FSM false
directive set -REGISTER_SHARING_MAX_WIDTH_DIFFERENCE 8
directive set -REGISTER_SHARING_LIMIT 0
directive set -ASSIGN_OVERHEAD 0
directive set -TIMING_CHECKS true
directive set -MUXPATH true
directive set -REALLOC true
directive set -UNROLL no
directive set -IO_MODE super
directive set -CHAN_IO_PROTOCOL use_library
directive set -ARRAY_SIZE 1024
directive set -REGISTER_IDLE_SIGNAL false
directive set -IDLE_SIGNAL {}
directive set -STALL_FLAG false
directive set -TRANSACTION_DONE_SIGNAL true
directive set -DONE_FLAG {}
directive set -READY_FLAG {}
directive set -START_FLAG {}
directive set -RESET_CLEARS_ALL_REGS use_library
directive set -CLOCK_OVERHEAD 20.000000
directive set -OPT_CONST_MULTS use_library
directive set -CHARACTERIZE_ROM false
directive set -PROTOTYPE_ROM true
directive set -ROM_THRESHOLD 64
directive set -CLUSTER_ADDTREE_IN_WIDTH_THRESHOLD 0
directive set -CLUSTER_ADDTREE_IN_COUNT_THRESHOLD 0
directive set -CLUSTER_OPT_CONSTANT_INPUTS true
directive set -CLUSTER_RTL_SYN false
directive set -CLUSTER_FAST_MODE false
directive set -CLUSTER_TYPE combinational
directive set -PIPELINE_RAMP_UP true
go new
solution design set isp_top -top
solution design set tpg -block
solution design set dgain -block
solution design set lsc -block
solution design set dpc -block
solution design set isp_rawdns -block
solution design set awb -block
solution design set wbc -block
solution design set greenbalance2 -block
solution design set demosaic -block
solution design set edgeenhancement -block
solution design set cmc -block
solution design set gtm -block
solution design set csc -block
solution design set yfc -block
solution design set yuv444dns -block
solution design set scaledown -block
solution design set crop -block

go compile
solution library add nangate-45nm_beh -- -rtlsyntool DesignCompiler
solution library add ccs_sample_mem
go libraries
directive set -CLOCKS {clk {-CLOCK_PERIOD 10.0 -CLOCK_EDGE rising -CLOCK_UNCERTAINTY 0.0 -CLOCK_HIGH_TIME 5.0 -RESET_SYNC_NAME rst -RESET_ASYNC_NAME arst_n -RESET_KIND async -RESET_SYNC_ACTIVE high -RESET_ASYNC_ACTIVE low -ENABLE_ACTIVE high}}
go assembly
directive set /isp_top/demosaic/core/rawWindow:rsc -MAP_TO_MODULE {[Register]}
directive set /isp_top/csc/csc_reg.m_nEb:rsc -MAP_TO_MODULE {[DirectInput]}
directive set /isp_top/csc_register.m_nEb:rsc -MAP_TO_MODULE {[DirectInput]}
directive set /isp_top/gtm_register.m_bDitheringEnable:rsc -MAP_TO_MODULE {[DirectInput]}
directive set /isp_top/gtm_register.eb:rsc -MAP_TO_MODULE {[DirectInput]}
directive set /isp_top/cmc_register.m_nCFCStrength:rsc -MAP_TO_MODULE {[DirectInput]}
directive set /isp_top/cmc_register.m_nEdgeBandShift:rsc -MAP_TO_MODULE {[DirectInput]}
directive set /isp_top/cmc_register.m_nEdgeThre:rsc -MAP_TO_MODULE {[DirectInput]}
directive set /isp_top/cmc_register.m_nHueBandShift:rsc -MAP_TO_MODULE {[DirectInput]}
directive set /isp_top/cmc_register.m_pHueRange:rsc -MAP_TO_MODULE {[DirectInput]}
directive set /isp_top/cmc_register.m_bDiscardH:rsc -MAP_TO_MODULE {[DirectInput]}
directive set /isp_top/cmc_register.m_bCFCEnable:rsc -MAP_TO_MODULE {[DirectInput]}
directive set /isp_top/cmc_register.m_nGain:rsc -MAP_TO_MODULE {[DirectInput]}
directive set /isp_top/cmc_register.m_nEb:rsc -MAP_TO_MODULE {[DirectInput]}
directive set /isp_top/demosaic_register.eb:rsc -MAP_TO_MODULE {[DirectInput]}
directive set /isp_top/wbc_register.m_nB:rsc -MAP_TO_MODULE {[DirectInput]}
directive set /isp_top/wbc_register.m_nGb:rsc -MAP_TO_MODULE {[DirectInput]}
directive set /isp_top/wbc_register.m_nGr:rsc -MAP_TO_MODULE {[DirectInput]}
directive set /isp_top/wbc_register.m_nR:rsc -MAP_TO_MODULE {[DirectInput]}
directive set /isp_top/wbc_register.m_nEb:rsc -MAP_TO_MODULE {[DirectInput]}
directive set /isp_top/dgain_register.m_nB:rsc -MAP_TO_MODULE {[DirectInput]}
directive set /isp_top/dgain_register.m_nGb:rsc -MAP_TO_MODULE {[DirectInput]}
directive set /isp_top/dgain_register.m_nGr:rsc -MAP_TO_MODULE {[DirectInput]}
directive set /isp_top/dgain_register.m_nR:rsc -MAP_TO_MODULE {[DirectInput]}
directive set /isp_top/dgain_register.m_nBlcB:rsc -MAP_TO_MODULE {[DirectInput]}
directive set /isp_top/dgain_register.m_nBlcGb:rsc -MAP_TO_MODULE {[DirectInput]}
directive set /isp_top/dgain_register.m_nBlcGr:rsc -MAP_TO_MODULE {[DirectInput]}
directive set /isp_top/dgain_register.m_nBlcR:rsc -MAP_TO_MODULE {[DirectInput]}
directive set /isp_top/dgain_register.m_nEb:rsc -MAP_TO_MODULE {[DirectInput]}
directive set /isp_top/tpg_register.m_nID:rsc -MAP_TO_MODULE {[DirectInput]}
directive set /isp_top/tpg_register.m_valid_blank:rsc -MAP_TO_MODULE {[DirectInput]}
directive set /isp_top/tpg_register.m_nHBlank_num:rsc -MAP_TO_MODULE {[DirectInput]}
directive set /isp_top/tpg_register.m_nVBlank_num:rsc -MAP_TO_MODULE {[DirectInput]}
directive set /isp_top/tpg_register.m_bSensor_timing_en:rsc -MAP_TO_MODULE {[DirectInput]}
directive set /isp_top/tpg_register.m_bRollingEnable:rsc -MAP_TO_MODULE {[DirectInput]}
directive set /isp_top/tpg_register.m_nCFAPattern:rsc -MAP_TO_MODULE {[DirectInput]}
directive set /isp_top/tpg_register.m_nHeight:rsc -MAP_TO_MODULE {[DirectInput]}
directive set /isp_top/tpg_register.m_nWidth:rsc -MAP_TO_MODULE {[DirectInput]}
directive set /isp_top/tpg_register.m_bTPG_en:rsc -MAP_TO_MODULE {[DirectInput]}
directive set /isp_top/cmc/cmc_reg.m_nCFCStrength:rsc -MAP_TO_MODULE {[DirectInput]}
directive set /isp_top/cmc/cmc_reg.m_nEdgeBandShift:rsc -MAP_TO_MODULE {[DirectInput]}
directive set /isp_top/cmc/cmc_reg.m_nEdgeThre:rsc -MAP_TO_MODULE {[DirectInput]}
directive set /isp_top/cmc/cmc_reg.m_nHueBandShift:rsc -MAP_TO_MODULE {[DirectInput]}
directive set /isp_top/cmc/cmc_reg.m_pHueRange:rsc -MAP_TO_MODULE {[DirectInput]}
directive set /isp_top/cmc/cmc_reg.m_bDiscardH:rsc -MAP_TO_MODULE {[DirectInput]}
directive set /isp_top/cmc/cmc_reg.m_bCFCEnable:rsc -MAP_TO_MODULE {[DirectInput]}
directive set /isp_top/cmc/cmc_reg.m_nGain:rsc -MAP_TO_MODULE {[DirectInput]}
directive set /isp_top/cmc/cmc_reg.m_nEb:rsc -MAP_TO_MODULE {[DirectInput]}
directive set /isp_top/tpg/tpg_reg.m_nID:rsc -MAP_TO_MODULE {[DirectInput]}
directive set /isp_top/tpg/tpg_reg.m_valid_blank:rsc -MAP_TO_MODULE {[DirectInput]}
directive set /isp_top/tpg/tpg_reg.m_nHBlank_num:rsc -MAP_TO_MODULE {[DirectInput]}
directive set /isp_top/tpg/tpg_reg.m_nVBlank_num:rsc -MAP_TO_MODULE {[DirectInput]}
directive set /isp_top/tpg/tpg_reg.m_bSensor_timing_en:rsc -MAP_TO_MODULE {[DirectInput]}
directive set /isp_top/tpg/tpg_reg.m_bRollingEnable:rsc -MAP_TO_MODULE {[DirectInput]}
directive set /isp_top/tpg/tpg_reg.m_nCFAPattern:rsc -MAP_TO_MODULE {[DirectInput]}
directive set /isp_top/tpg/tpg_reg.m_nHeight:rsc -MAP_TO_MODULE {[DirectInput]}
directive set /isp_top/tpg/tpg_reg.m_nWidth:rsc -MAP_TO_MODULE {[DirectInput]}
directive set /isp_top/tpg/tpg_reg.m_bTPG_en:rsc -MAP_TO_MODULE {[DirectInput]}
directive set /isp_top/gtm/gtm_reg.m_bDitheringEnable:rsc -MAP_TO_MODULE {[DirectInput]}
directive set /isp_top/gtm/gtm_reg.eb:rsc -MAP_TO_MODULE {[DirectInput]}
directive set /isp_top/dgain/dgain_reg.m_nB:rsc -MAP_TO_MODULE {[DirectInput]}
directive set /isp_top/dgain/dgain_reg.m_nGb:rsc -MAP_TO_MODULE {[DirectInput]}
directive set /isp_top/dgain/dgain_reg.m_nGr:rsc -MAP_TO_MODULE {[DirectInput]}
directive set /isp_top/dgain/dgain_reg.m_nR:rsc -MAP_TO_MODULE {[DirectInput]}
directive set /isp_top/dgain/dgain_reg.m_nBlcB:rsc -MAP_TO_MODULE {[DirectInput]}
directive set /isp_top/dgain/dgain_reg.m_nBlcGb:rsc -MAP_TO_MODULE {[DirectInput]}
directive set /isp_top/dgain/dgain_reg.m_nBlcGr:rsc -MAP_TO_MODULE {[DirectInput]}
directive set /isp_top/dgain/dgain_reg.m_nBlcR:rsc -MAP_TO_MODULE {[DirectInput]}
directive set /isp_top/dgain/dgain_reg.m_nEb:rsc -MAP_TO_MODULE {[DirectInput]}
directive set /isp_top/wbc/wbc_reg.m_nB:rsc -MAP_TO_MODULE {[DirectInput]}
directive set /isp_top/wbc/wbc_reg.m_nGb:rsc -MAP_TO_MODULE {[DirectInput]}
directive set /isp_top/wbc/wbc_reg.m_nGr:rsc -MAP_TO_MODULE {[DirectInput]}
directive set /isp_top/wbc/wbc_reg.m_nR:rsc -MAP_TO_MODULE {[DirectInput]}
directive set /isp_top/wbc/wbc_reg.m_nEb:rsc -MAP_TO_MODULE {[DirectInput]}
directive set /isp_top/demosaic/demosaic_reg.eb:rsc -MAP_TO_MODULE {[DirectInput]}
directive set /isp_top/demosaic/core/inner_loop -PIPELINE_INIT_INTERVAL 1
directive set /isp_top/demosaic/core/window_loop -UNROLL yes
directive set /isp_top/demosaic/core/addon_loop -PIPELINE_INIT_INTERVAL 1
directive set /isp_top/cmc/core/cmc_cal1 -UNROLL yes
directive set /isp_top/cmc/core/cmc_cal2 -UNROLL yes
directive set /isp_top/cmc/core/cmc_cal3 -UNROLL yes
directive set /isp_top/cmc/core/cmc_cal3 -MERGEABLE true
directive set /isp_top/cmc/core/cmc_cal2 -MERGEABLE true
directive set /isp_top/cmc/core/cmc_cal1 -MERGEABLE true
directive set /isp_top/gtm/core/gtm_cal -UNROLL yes
directive set /isp_top/csc/core/csc_cal1 -UNROLL yes
directive set /isp_top/csc/core/csc_cal2 -UNROLL yes
directive set /isp_top/csc/csc_reg.coeff:rsc -MAP_TO_MODULE {[DirectInput]}
directive set /isp_top/csc_register.coeff:rsc -MAP_TO_MODULE {[DirectInput]}
directive set /isp_top/gtm/gtm_reg.gtmTab:rsc -MAP_TO_MODULE {[DirectInput]}
directive set /isp_top/gtm/gtm_reg.gtmTab:rsc -PACKING_MODE sidebyside
directive set /isp_top/gtm/gtm_reg.gtmTab -WORD_WIDTH 1290
directive set /isp_top/gtm_register.gtmTab:rsc -MAP_TO_MODULE {[DirectInput]}
directive set /isp_top/gtm_register.gtmTab:rsc -PACKING_MODE sidebyside
directive set /isp_top/gtm_register.gtmTab -WORD_WIDTH 1290
directive set /isp_top/cmc/core/cmc_reg.m_nGain:rsc -MAP_TO_MODULE {[Register]}
directive set /isp_top/cmc/core/cmc_reg.m_nGain:rsc -GEN_EXTERNAL_ENABLE false
directive set /isp_top/gtm/seed.rom:rsc -MAP_TO_MODULE {[Register]}
directive set /isp_top/csc/seed.rom:rsc -MAP_TO_MODULE {[Register]}
directive set /isp_top/csc/core/seed:rsc -MAP_TO_MODULE {[Register]}
directive set /isp_top/gtm/core/gtm_reg.gtmTab:rsc -MAP_TO_MODULE {[Register]}
directive set /isp_top/gtm/core/gtm_reg.gtmTab:rsc -GEN_EXTERNAL_ENABLE false
directive set /isp_top/top_register.scalerFrameHeight:rsc -MAP_TO_MODULE {[DirectInput]}
directive set /isp_top/cmc/top_reg.scalerFrameHeight:rsc -MAP_TO_MODULE {[DirectInput]}
directive set /isp_top/tpg/top_reg.scalerFrameHeight:rsc -MAP_TO_MODULE {[DirectInput]}
directive set /isp_top/gtm/top_reg.scalerFrameHeight:rsc -MAP_TO_MODULE {[DirectInput]}
directive set /isp_top/dgain/top_reg.scalerFrameHeight:rsc -MAP_TO_MODULE {[DirectInput]}
directive set /isp_top/csc/top_reg.scalerFrameHeight:rsc -MAP_TO_MODULE {[DirectInput]}
directive set /isp_top/wbc/top_reg.scalerFrameHeight:rsc -MAP_TO_MODULE {[DirectInput]}
directive set /isp_top/demosaic/top_reg.scalerFrameHeight:rsc -MAP_TO_MODULE {[DirectInput]}
directive set /isp_top/top_register.scalerFrameWidth:rsc -MAP_TO_MODULE {[DirectInput]}
directive set /isp_top/cmc/top_reg.scalerFrameWidth:rsc -MAP_TO_MODULE {[DirectInput]}
directive set /isp_top/tpg/top_reg.scalerFrameWidth:rsc -MAP_TO_MODULE {[DirectInput]}
directive set /isp_top/gtm/top_reg.scalerFrameWidth:rsc -MAP_TO_MODULE {[DirectInput]}
directive set /isp_top/dgain/top_reg.scalerFrameWidth:rsc -MAP_TO_MODULE {[DirectInput]}
directive set /isp_top/csc/top_reg.scalerFrameWidth:rsc -MAP_TO_MODULE {[DirectInput]}
directive set /isp_top/wbc/top_reg.scalerFrameWidth:rsc -MAP_TO_MODULE {[DirectInput]}
directive set /isp_top/demosaic/top_reg.scalerFrameWidth:rsc -MAP_TO_MODULE {[DirectInput]}
directive set /isp_top/top_register.binningFrameHeight:rsc -MAP_TO_MODULE {[DirectInput]}
directive set /isp_top/cmc/top_reg.binningFrameHeight:rsc -MAP_TO_MODULE {[DirectInput]}
directive set /isp_top/tpg/top_reg.binningFrameHeight:rsc -MAP_TO_MODULE {[DirectInput]}
directive set /isp_top/gtm/top_reg.binningFrameHeight:rsc -MAP_TO_MODULE {[DirectInput]}
directive set /isp_top/dgain/top_reg.binningFrameHeight:rsc -MAP_TO_MODULE {[DirectInput]}
directive set /isp_top/csc/top_reg.binningFrameHeight:rsc -MAP_TO_MODULE {[DirectInput]}
directive set /isp_top/wbc/top_reg.binningFrameHeight:rsc -MAP_TO_MODULE {[DirectInput]}
directive set /isp_top/demosaic/top_reg.binningFrameHeight:rsc -MAP_TO_MODULE {[DirectInput]}
directive set /isp_top/top_register.binningFrameWidth:rsc -MAP_TO_MODULE {[DirectInput]}
directive set /isp_top/cmc/top_reg.binningFrameWidth:rsc -MAP_TO_MODULE {[DirectInput]}
directive set /isp_top/tpg/top_reg.binningFrameWidth:rsc -MAP_TO_MODULE {[DirectInput]}
directive set /isp_top/gtm/top_reg.binningFrameWidth:rsc -MAP_TO_MODULE {[DirectInput]}
directive set /isp_top/dgain/top_reg.binningFrameWidth:rsc -MAP_TO_MODULE {[DirectInput]}
directive set /isp_top/csc/top_reg.binningFrameWidth:rsc -MAP_TO_MODULE {[DirectInput]}
directive set /isp_top/wbc/top_reg.binningFrameWidth:rsc -MAP_TO_MODULE {[DirectInput]}
directive set /isp_top/demosaic/top_reg.binningFrameWidth:rsc -MAP_TO_MODULE {[DirectInput]}
directive set /isp_top/top_register.shadowEb:rsc -MAP_TO_MODULE {[DirectInput]}
directive set /isp_top/top_register.blc:rsc -MAP_TO_MODULE {[DirectInput]}
directive set /isp_top/top_register.pipeMode:rsc -MAP_TO_MODULE {[DirectInput]}
directive set /isp_top/top_register.imgPattern:rsc -MAP_TO_MODULE {[DirectInput]}
directive set /isp_top/top_register.inputFormat:rsc -MAP_TO_MODULE {[DirectInput]}
directive set /isp_top/top_register.frameHeight:rsc -MAP_TO_MODULE {[DirectInput]}
directive set /isp_top/cmc/top_reg.shadowEb:rsc -MAP_TO_MODULE {[DirectInput]}
directive set /isp_top/cmc/top_reg.blc:rsc -MAP_TO_MODULE {[DirectInput]}
directive set /isp_top/cmc/top_reg.pipeMode:rsc -MAP_TO_MODULE {[DirectInput]}
directive set /isp_top/cmc/top_reg.imgPattern:rsc -MAP_TO_MODULE {[DirectInput]}
directive set /isp_top/cmc/top_reg.inputFormat:rsc -MAP_TO_MODULE {[DirectInput]}
directive set /isp_top/cmc/top_reg.frameHeight:rsc -MAP_TO_MODULE {[DirectInput]}
directive set /isp_top/tpg/top_reg.shadowEb:rsc -MAP_TO_MODULE {[DirectInput]}
directive set /isp_top/tpg/top_reg.blc:rsc -MAP_TO_MODULE {[DirectInput]}
directive set /isp_top/tpg/top_reg.pipeMode:rsc -MAP_TO_MODULE {[DirectInput]}
directive set /isp_top/tpg/top_reg.imgPattern:rsc -MAP_TO_MODULE {[DirectInput]}
directive set /isp_top/tpg/top_reg.inputFormat:rsc -MAP_TO_MODULE {[DirectInput]}
directive set /isp_top/tpg/top_reg.frameHeight:rsc -MAP_TO_MODULE {[DirectInput]}
directive set /isp_top/gtm/top_reg.shadowEb:rsc -MAP_TO_MODULE {[DirectInput]}
directive set /isp_top/gtm/top_reg.blc:rsc -MAP_TO_MODULE {[DirectInput]}
directive set /isp_top/gtm/top_reg.pipeMode:rsc -MAP_TO_MODULE {[DirectInput]}
directive set /isp_top/gtm/top_reg.imgPattern:rsc -MAP_TO_MODULE {[DirectInput]}
directive set /isp_top/gtm/top_reg.inputFormat:rsc -MAP_TO_MODULE {[DirectInput]}
directive set /isp_top/gtm/top_reg.frameHeight:rsc -MAP_TO_MODULE {[DirectInput]}
directive set /isp_top/dgain/top_reg.shadowEb:rsc -MAP_TO_MODULE {[DirectInput]}
directive set /isp_top/dgain/top_reg.blc:rsc -MAP_TO_MODULE {[DirectInput]}
directive set /isp_top/dgain/top_reg.pipeMode:rsc -MAP_TO_MODULE {[DirectInput]}
directive set /isp_top/dgain/top_reg.imgPattern:rsc -MAP_TO_MODULE {[DirectInput]}
directive set /isp_top/dgain/top_reg.inputFormat:rsc -MAP_TO_MODULE {[DirectInput]}
directive set /isp_top/dgain/top_reg.frameHeight:rsc -MAP_TO_MODULE {[DirectInput]}
directive set /isp_top/csc/top_reg.shadowEb:rsc -MAP_TO_MODULE {[DirectInput]}
directive set /isp_top/csc/top_reg.blc:rsc -MAP_TO_MODULE {[DirectInput]}
directive set /isp_top/csc/top_reg.pipeMode:rsc -MAP_TO_MODULE {[DirectInput]}
directive set /isp_top/csc/top_reg.imgPattern:rsc -MAP_TO_MODULE {[DirectInput]}
directive set /isp_top/csc/top_reg.inputFormat:rsc -MAP_TO_MODULE {[DirectInput]}
directive set /isp_top/csc/top_reg.frameHeight:rsc -MAP_TO_MODULE {[DirectInput]}
directive set /isp_top/wbc/top_reg.shadowEb:rsc -MAP_TO_MODULE {[DirectInput]}
directive set /isp_top/wbc/top_reg.blc:rsc -MAP_TO_MODULE {[DirectInput]}
directive set /isp_top/wbc/top_reg.pipeMode:rsc -MAP_TO_MODULE {[DirectInput]}
directive set /isp_top/wbc/top_reg.imgPattern:rsc -MAP_TO_MODULE {[DirectInput]}
directive set /isp_top/wbc/top_reg.inputFormat:rsc -MAP_TO_MODULE {[DirectInput]}
directive set /isp_top/wbc/top_reg.frameHeight:rsc -MAP_TO_MODULE {[DirectInput]}
directive set /isp_top/demosaic/top_reg.shadowEb:rsc -MAP_TO_MODULE {[DirectInput]}
directive set /isp_top/demosaic/top_reg.blc:rsc -MAP_TO_MODULE {[DirectInput]}
directive set /isp_top/demosaic/top_reg.pipeMode:rsc -MAP_TO_MODULE {[DirectInput]}
directive set /isp_top/demosaic/top_reg.imgPattern:rsc -MAP_TO_MODULE {[DirectInput]}
directive set /isp_top/demosaic/top_reg.inputFormat:rsc -MAP_TO_MODULE {[DirectInput]}
directive set /isp_top/demosaic/top_reg.frameHeight:rsc -MAP_TO_MODULE {[DirectInput]}
directive set /isp_top/top_register.frameWidth:rsc -MAP_TO_MODULE {[DirectInput]}
directive set /isp_top/cmc/top_reg.frameWidth:rsc -MAP_TO_MODULE {[DirectInput]}
directive set /isp_top/tpg/top_reg.frameWidth:rsc -MAP_TO_MODULE {[DirectInput]}
directive set /isp_top/gtm/top_reg.frameWidth:rsc -MAP_TO_MODULE {[DirectInput]}
directive set /isp_top/dgain/top_reg.frameWidth:rsc -MAP_TO_MODULE {[DirectInput]}
directive set /isp_top/csc/top_reg.frameWidth:rsc -MAP_TO_MODULE {[DirectInput]}
directive set /isp_top/wbc/top_reg.frameWidth:rsc -MAP_TO_MODULE {[DirectInput]}
directive set /isp_top/demosaic/top_reg.frameWidth:rsc -MAP_TO_MODULE {[DirectInput]}
directive set /isp_top/demosaic/core/lineBuf:rsc -BLOCK_SIZE 4096
directive set /isp_top/demosaic/core/lineBuf:rsc -INTERLEAVE 4
directive set /isp_top/tpg/core/main -PIPELINE_INIT_INTERVAL 1
directive set /isp_top/dgain/core/main -PIPELINE_INIT_INTERVAL 1
directive set /isp_top/wbc/core/main -PIPELINE_INIT_INTERVAL 1
directive set /isp_top/cmc/core/main -PIPELINE_INIT_INTERVAL 1
directive set /isp_top/gtm/core/main -PIPELINE_INIT_INTERVAL 1
directive set /isp_top/csc/core/main -PIPELINE_INIT_INTERVAL 1
directive set /isp_top/demosaic/core/main -PIPELINE_INIT_INTERVAL 1
directive set /isp_top/lsc/core/main -PIPELINE_INIT_INTERVAL 1
directive set /isp_top/awb/awb_reg.m_nEb:rsc -MAP_TO_MODULE {[DirectInput]}
directive set /isp_top/awb/awb_reg.coeff:rsc -MAP_TO_MODULE {[DirectInput]}
directive set /isp_top/awb/core/main -PIPELINE_INIT_INTERVAL 1
directive set /isp_top/dpc/dpc_reg.eb:rsc -MAP_TO_MODULE {[DirectInput]}
directive set /isp_top/dpc/dpc_reg.th_w:rsc -MAP_TO_MODULE {[DirectInput]}
directive set /isp_top/dpc/dpc_reg.th_b:rsc -MAP_TO_MODULE {[DirectInput]}
directive set /isp_top/dpc/core/main -PIPELINE_INIT_INTERVAL 1
directive set /isp_top/lsc/lscRegister.eb:rsc -MAP_TO_MODULE {[DirectInput]}
directive set /isp_top/lsc/lscRegister.blockHeight:rsc -MAP_TO_MODULE {[DirectInput]}
directive set /isp_top/lsc/lscRegister.blockWidth:rsc -MAP_TO_MODULE {[DirectInput]}
directive set /isp_top/lsc/lscRegister.blockWidth_1:rsc -MAP_TO_MODULE {[DirectInput]}
directive set /isp_top/lsc/lscRegister.blockHeight_1:rsc -MAP_TO_MODULE {[DirectInput]}
directive set /isp_top/lsc_register.eb:rsc -MAP_TO_MODULE {[DirectInput]}
directive set /isp_top/lsc_register.blockHeight:rsc -MAP_TO_MODULE {[DirectInput]}
directive set /isp_top/lsc_register.blockHeight_1:rsc -MAP_TO_MODULE {[DirectInput]}
directive set /isp_top/dpc_register.eb:rsc -MAP_TO_MODULE {[DirectInput]}
directive set /isp_top/dpc_register.th_b:rsc -MAP_TO_MODULE {[DirectInput]}
directive set /isp_top/awb_register.m_nEb:rsc -MAP_TO_MODULE {[DirectInput]}
directive set /isp_top/awb_register.coeff:rsc -MAP_TO_MODULE {[DirectInput]}
directive set /isp_top/lsc/lscRegister.rGain:rsc -MAP_TO_MODULE {[DirectInput]}
directive set /isp_top/lsc/lscRegister.rGain:rsc -PACKING_MODE sidebyside
directive set /isp_top/lsc/lscRegister.rGain -WORD_WIDTH 2873
directive set /isp_top/lsc/lscRegister.GrGain:rsc -MAP_TO_MODULE {[DirectInput]}
directive set /isp_top/lsc/lscRegister.GrGain:rsc -PACKING_MODE sidebyside
directive set /isp_top/lsc/lscRegister.GrGain -WORD_WIDTH 2873
directive set /isp_top/lsc/lscRegister.GbGain:rsc -MAP_TO_MODULE {[DirectInput]}
directive set /isp_top/lsc/lscRegister.GbGain:rsc -PACKING_MODE sidebyside
directive set /isp_top/lsc/lscRegister.GbGain -WORD_WIDTH 2873
directive set /isp_top/lsc/lscRegister.bGain:rsc -MAP_TO_MODULE {[DirectInput]}
directive set /isp_top/lsc/lscRegister.bGain:rsc -PACKING_MODE sidebyside
directive set /isp_top/lsc/lscRegister.bGain -WORD_WIDTH 2873
directive set /isp_top/lsc_register.rGain:rsc -MAP_TO_MODULE {[DirectInput]}
directive set /isp_top/lsc_register.rGain:rsc -PACKING_MODE sidebyside
directive set /isp_top/lsc_register.rGain -WORD_WIDTH 2873
directive set /isp_top/lsc_register.GrGain:rsc -MAP_TO_MODULE {[DirectInput]}
directive set /isp_top/lsc_register.GrGain:rsc -PACKING_MODE sidebyside
directive set /isp_top/lsc_register.GrGain -WORD_WIDTH 2873
directive set /isp_top/lsc_register.GbGain:rsc -MAP_TO_MODULE {[DirectInput]}
directive set /isp_top/lsc_register.GbGain:rsc -PACKING_MODE sidebyside
directive set /isp_top/lsc_register.GbGain -WORD_WIDTH 2873
directive set /isp_top/lsc_register.bGain:rsc -MAP_TO_MODULE {[DirectInput]}
directive set /isp_top/lsc_register.bGain:rsc -PACKING_MODE sidebyside
directive set /isp_top/lsc_register.bGain -WORD_WIDTH 2873
directive set /isp_top/edgeenhancement/core/padding_loop_3 -PIPELINE_INIT_INTERVAL 1
directive set /isp_top/edgeenhancement/core/ee_lines:rsc -INTERLEAVE 4
directive set /isp_top/edgeenhancement/core/ee_lines:rsc -BLOCK_SIZE 4096
directive set /isp_top/edgeenhancement/core/main -PIPELINE_INIT_INTERVAL 1
directive set /isp_top/edgeenhancement/core/single_loop -PIPELINE_INIT_INTERVAL 0
directive set /isp_top/edgeenhancement/core/padding_loop_1 -UNROLL no
directive set /isp_top/edgeenhancement/isp_top.inputFormat:rsc -MAP_TO_MODULE {[DirectInput]}
directive set /isp_top/edgeenhancement/isp_top.imgPattern:rsc -MAP_TO_MODULE {[DirectInput]}
directive set /isp_top/edgeenhancement/isp_top.pipeMode:rsc -MAP_TO_MODULE {[DirectInput]}
directive set /isp_top/edgeenhancement/isp_top.blc:rsc -MAP_TO_MODULE {[DirectInput]}
directive set /isp_top/edgeenhancement/isp_top.shadowEb:rsc -MAP_TO_MODULE {[DirectInput]}
directive set /isp_top/edgeenhancement/isp_top.binningFrameWidth:rsc -MAP_TO_MODULE {[DirectInput]}
directive set /isp_top/edgeenhancement/isp_top.binningFrameHeight:rsc -MAP_TO_MODULE {[DirectInput]}
directive set /isp_top/edgeenhancement/isp_top.scalerFrameWidth:rsc -MAP_TO_MODULE {[DirectInput]}
directive set /isp_top/edgeenhancement/isp_top.scalerFrameHeight:rsc -MAP_TO_MODULE {[DirectInput]}
directive set /isp_top/edgeenhancement/ee_top.eb:rsc -MAP_TO_MODULE {[DirectInput]}
directive set /isp_top/edgeenhancement/ee_top.coeff:rsc -MAP_TO_MODULE {[DirectInput]}
directive set /isp_top/edgeenhancement/core/padding_loop_2 -UNROLL no
directive set /isp_top/ee_register.coeff:rsc -MAP_TO_MODULE {[DirectInput]}
directive set /isp_top/greenbalance2/gb_reg.eb:rsc -MAP_TO_MODULE {[DirectInput]}
directive set /isp_top/greenbalance2/gb_reg.win_size:rsc -MAP_TO_MODULE {[DirectInput]}
directive set /isp_top/greenbalance2/gb_reg.Lbound:rsc -MAP_TO_MODULE {[DirectInput]}
directive set /isp_top/greenbalance2/gb_reg.Hbound:rsc -MAP_TO_MODULE {[DirectInput]}
directive set /isp_top/greenbalance2/gb_reg.threhold:rsc -MAP_TO_MODULE {[DirectInput]}
directive set /isp_top/greenbalance2/core/gb_lines:rsc -INTERLEAVE 6
directive set /isp_top/greenbalance2/core/gb_lines:rsc -BLOCK_SIZE 4096
directive set /isp_top/greenbalance2/core/main -PIPELINE_INIT_INTERVAL 1
directive set /isp_top/gb_register.eb:rsc -MAP_TO_MODULE {[DirectInput]}
directive set /isp_top/gb_register.win_size:rsc -MAP_TO_MODULE {[DirectInput]}
directive set /isp_top/gb_register.Lbound:rsc -MAP_TO_MODULE {[DirectInput]}
directive set /isp_top/gb_register.Hbound:rsc -MAP_TO_MODULE {[DirectInput]}
directive set /isp_top/gb_register.threhold:rsc -MAP_TO_MODULE {[DirectInput]}
directive set /isp_top/greenbalance2/core/gb_block:rsc -MAP_TO_MODULE {[Register]}
directive set /isp_top/greenbalance2/core/gb_block:rsc -GEN_EXTERNAL_ENABLE false
directive set /isp_top/greenbalance2/core/out_window_loop -UNROLL no
directive set /isp_top/greenbalance2/core/greenbalance2_label0 -UNROLL no
directive set /isp_top/isp_rawdns/top_reg.inputFormat:rsc -MAP_TO_MODULE {[DirectInput]}
directive set /isp_top/isp_rawdns/top_reg.imgPattern:rsc -MAP_TO_MODULE {[DirectInput]}
directive set /isp_top/isp_rawdns/top_reg.pipeMode:rsc -MAP_TO_MODULE {[DirectInput]}
directive set /isp_top/isp_rawdns/top_reg.blc:rsc -MAP_TO_MODULE {[DirectInput]}
directive set /isp_top/isp_rawdns/top_reg.shadowEb:rsc -MAP_TO_MODULE {[DirectInput]}
directive set /isp_top/isp_rawdns/top_reg.binningFrameWidth:rsc -MAP_TO_MODULE {[DirectInput]}
directive set /isp_top/isp_rawdns/top_reg.binningFrameHeight:rsc -MAP_TO_MODULE {[DirectInput]}
directive set /isp_top/isp_rawdns/top_reg.scalerFrameWidth:rsc -MAP_TO_MODULE {[DirectInput]}
directive set /isp_top/isp_rawdns/top_reg.scalerFrameHeight:rsc -MAP_TO_MODULE {[DirectInput]}
directive set /isp_top/isp_rawdns/rawdns_reg.sigma:rsc -MAP_TO_MODULE {[DirectInput]}
directive set /isp_top/isp_rawdns/rawdns_reg.eb:rsc -MAP_TO_MODULE {[DirectInput]}
directive set /isp_top/isp_rawdns/rawdns_reg.Filterpara:rsc -MAP_TO_MODULE {[DirectInput]}
directive set /isp_top/isp_rawdns/rawdns_reg.invksigma2:rsc -MAP_TO_MODULE {[DirectInput]}
directive set /isp_top/isp_rawdns/core/rawdns_lines:rsc -BLOCK_SIZE 4096
directive set /isp_top/isp_rawdns/core/rawdns_lines:rsc -INTERLEAVE 10
directive set /isp_top/isp_rawdns/core/rawdns_block:rsc -MAP_TO_MODULE {[Register]}
directive set /isp_top/isp_rawdns/core/main -PIPELINE_INIT_INTERVAL 1
directive set /isp_top/rawdns_register.sigma:rsc -MAP_TO_MODULE {[DirectInput]}
directive set /isp_top/rawdns_register.eb:rsc -MAP_TO_MODULE {[DirectInput]}
directive set /isp_top/rawdns_register.Filterpara:rsc -MAP_TO_MODULE {[DirectInput]}
directive set /isp_top/rawdns_register.invksigma2:rsc -MAP_TO_MODULE {[DirectInput]}

directive set /isp_top/crop/core/main -PIPELINE_INIT_INTERVAL 1
directive set /isp_top/scaledown/core/y_linebuffer:rsc -MAP_TO_MODULE ccs_sample_mem.ccs_ram_sync_dualport
directive set /isp_top/scaledown/core/y_linebuffer:rsc -BLOCK_SIZE 4096
directive set /isp_top/scaledown/core/u_linebuffer:rsc -MAP_TO_MODULE ccs_sample_mem.ccs_ram_sync_dualport
directive set /isp_top/scaledown/core/u_linebuffer:rsc -BLOCK_SIZE 4096
directive set /isp_top/scaledown/core/v_linebuffer:rsc -MAP_TO_MODULE ccs_sample_mem.ccs_ram_sync_dualport
directive set /isp_top/scaledown/core/v_linebuffer:rsc -BLOCK_SIZE 4096
directive set /isp_top/scaledown/core/main -PIPELINE_INIT_INTERVAL 1
directive set /isp_top/yfc/core/main -PIPELINE_INIT_INTERVAL 1
directive set /isp_top/yuv444dns/core/ylineBuf:rsc -MAP_TO_MODULE ccs_sample_mem.ccs_ram_sync_dualport
directive set /isp_top/yuv444dns/core/ylineBuf:rsc -BLOCK_SIZE 4096
directive set /isp_top/yuv444dns/core/ulineBuf:rsc -BLOCK_SIZE 4096
directive set /isp_top/yuv444dns/core/ulineBuf:rsc -MAP_TO_MODULE ccs_sample_mem.ccs_ram_sync_dualport
directive set /isp_top/yuv444dns/core/vlineBuf:rsc -BLOCK_SIZE 4096
directive set /isp_top/yuv444dns/core/vlineBuf:rsc -MAP_TO_MODULE ccs_sample_mem.ccs_ram_sync_dualport
directive set /isp_top/yuv444dns/core/main -PIPELINE_INIT_INTERVAL 1
directive set /isp_top/yuv444dns/core/yWindow:rsc -MAP_TO_MODULE {[Register]}
directive set /isp_top/yuv444dns/core/yWindow:rsc -GEN_EXTERNAL_ENABLE false
directive set /isp_top/yuv444dns/core/uWindow:rsc -MAP_TO_MODULE {[Register]}
directive set /isp_top/yuv444dns/core/uWindow:rsc -GEN_EXTERNAL_ENABLE false
directive set /isp_top/yuv444dns/core/vWindow:rsc -MAP_TO_MODULE {[Register]}
directive set /isp_top/yuv444dns/core/vWindow:rsc -GEN_EXTERNAL_ENABLE false

directive set /isp_top/scaledown/scaledown_reg.m_nEb:rsc -MAP_TO_MODULE {[DirectInput]}
directive set /isp_top/scaledown/scaledown_reg.yuvpattern:rsc -MAP_TO_MODULE {[DirectInput]}
directive set /isp_top/scaledown/scaledown_reg.times:rsc -MAP_TO_MODULE {[DirectInput]}
directive set /isp_top/yuv444dns/yuvdns_reg.eb:rsc -MAP_TO_MODULE {[DirectInput]}
directive set /isp_top/yuv444dns/yuvdns_reg.ysigma2:rsc -MAP_TO_MODULE {[DirectInput]}
directive set /isp_top/yuv444dns/yuvdns_reg.yinvsigma2:rsc -MAP_TO_MODULE {[DirectInput]}
directive set /isp_top/yuv444dns/yuvdns_reg.uvsigma2:rsc -MAP_TO_MODULE {[DirectInput]}
directive set /isp_top/yuv444dns/yuvdns_reg.uvinvsigma2:rsc -MAP_TO_MODULE {[DirectInput]}
directive set /isp_top/yuv444dns/yuvdns_reg.yfilt:rsc -MAP_TO_MODULE {[DirectInput]}
directive set /isp_top/yuv444dns/yuvdns_reg.uvfilt:rsc -MAP_TO_MODULE {[DirectInput]}
directive set /isp_top/yuv444dns/yuvdns_reg.yinvfilt:rsc -MAP_TO_MODULE {[DirectInput]}
directive set /isp_top/yuv444dns/yuvdns_reg.uvinvfilt:rsc -MAP_TO_MODULE {[DirectInput]}
directive set /isp_top/yuv444dns/yuvdns_reg.yH2:rsc -MAP_TO_MODULE {[DirectInput]}
directive set /isp_top/yuv444dns/yuvdns_reg.yinvH2:rsc -MAP_TO_MODULE {[DirectInput]}
directive set /isp_top/yuv444dns/yuvdns_reg.uvH2:rsc -MAP_TO_MODULE {[DirectInput]}
directive set /isp_top/yuv444dns/yuvdns_reg.uvinvH2:rsc -MAP_TO_MODULE {[DirectInput]}
directive set /isp_top/yfc/yfc_reg.m_nEb:rsc -MAP_TO_MODULE {[DirectInput]}
directive set /isp_top/yfc/yfc_reg.yuvpattern:rsc -MAP_TO_MODULE {[DirectInput]}
directive set /isp_top/yfc_register.m_nEb:rsc -MAP_TO_MODULE {[DirectInput]}
directive set /isp_top/yuvdns_register.eb:rsc -MAP_TO_MODULE {[DirectInput]}
directive set /isp_top/yuvdns_register.uvsigma2:rsc -MAP_TO_MODULE {[DirectInput]}
directive set /isp_top/yuvdns_register.uvinvsigma2:rsc -MAP_TO_MODULE {[DirectInput]}
directive set /isp_top/yuvdns_register.yinvfilt:rsc -MAP_TO_MODULE {[DirectInput]}
directive set /isp_top/yuvdns_register.yH2:rsc -MAP_TO_MODULE {[DirectInput]}
directive set /isp_top/yuvdns_register.yinvH2:rsc -MAP_TO_MODULE {[DirectInput]}
directive set /isp_top/yuvdns_register.uvinvH2:rsc -MAP_TO_MODULE {[DirectInput]}
directive set /isp_top/scaledown_register.m_nEb:rsc -MAP_TO_MODULE {[DirectInput]}
directive set /isp_top/scaledown_register.times:rsc -MAP_TO_MODULE {[DirectInput]}
directive set /isp_top/crop/crop_reg.m_nEb:rsc -MAP_TO_MODULE {[DirectInput]}
directive set /isp_top/crop/crop_reg.upper_left_x:rsc -MAP_TO_MODULE {[DirectInput]}
directive set /isp_top/crop/crop_reg.upper_left_y:rsc -MAP_TO_MODULE {[DirectInput]}
directive set /isp_top/crop/crop_reg.lower_right_x:rsc -MAP_TO_MODULE {[DirectInput]}
directive set /isp_top/crop/crop_reg.lower_right_y:rsc -MAP_TO_MODULE {[DirectInput]}
directive set /isp_top/crop/crop_reg.yuvpattern:rsc -MAP_TO_MODULE {[DirectInput]}
directive set /isp_top/crop_register.m_nEb:rsc -MAP_TO_MODULE {[DirectInput]}
directive set /isp_top/crop_register.upper_left_x:rsc -MAP_TO_MODULE {[DirectInput]}
directive set /isp_top/crop_register.upper_left_y:rsc -MAP_TO_MODULE {[DirectInput]}
directive set /isp_top/crop_register.lower_right_x:rsc -MAP_TO_MODULE {[DirectInput]}
directive set /isp_top/crop_register.lower_right_y:rsc -MAP_TO_MODULE {[DirectInput]}
directive set /isp_top/crop_register.yuvpattern:rsc -MAP_TO_MODULE {[DirectInput]}

go architect
go allocate
go extract
