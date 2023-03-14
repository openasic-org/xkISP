//  Catapult Prime Synthesis 2022.1/981271 (Production Release) Thu Feb 10 22:05:20 PST 2022
//  
//          Copyright (c) Siemens EDA, 1996-2022, All Rights Reserved.
//                        UNPUBLISHED, LICENSED SOFTWARE.
//             CONFIDENTIAL AND PROPRIETARY INFORMATION WHICH IS THE
//                   PROPERTY OF SIEMENS EDA OR ITS LICENSORS.
//  
//  Running on Linux wanwei.xiao@alish-rs-cs08.eng.t-head.cn 3.10.0-1160.66.1.el7.x86_64 x86_64 aol
//  
//  Package information: SIFLIBS v25.1_0.0, HLS_PKGS v25.1_0.0, 
//                       SIF_TOOLKITS v25.1_0.0, SIF_XILINX v25.1_0.0, 
//                       SIF_ALTERA v25.1_0.0, CCS_LIBS v25.1_0.0, 
//                       CDS_PPRO v10.6, CDS_DesigChecker v2022.1, 
//                       CDS_OASYS v21.1_2.5, CDS_PSR v21.1_0.4, 
//                       DesignPad v2.78_1.0
//  
solution new -state initial
solution options defaults
solution options set /Input/CppStandard c++11
solution options set /Output/GenerateCycleNetlist false
solution options set /Flows/SCVerify/USE_QUESTASIM false
solution options set /Flows/SCVerify/USE_OSCI false
solution options set /Flows/SCVerify/USE_VCS true
solution options set /Flows/VCS/VG_ENV32_SCRIPT source_me_gcc483_32.csh
solution options set /Flows/VCS/VG_ENV64_SCRIPT source_me_gcc483_64.csh
solution options set /Flows/VCS/VLOGAN_OPTS {+v2k +no_tchk_msg -kdb -lca}
solution options set /Flows/VCS/VCSELAB_OPTS {-debug_acc+all -debug_region+cell+encrypt -timescale=1ps/1ps -sysc=blocksync -sysc=2.3.1 -sysc=slow_sc_main}
solution options set /Flows/VCS/SYSC_VERSION 2.3.1
flow package require /SCVerify
solution file add ../src/afc.h -type CHEADER -exclude true
solution file add ../src/afc.cpp -type C++
solution file add ../tb/tb_afc_catapult.cpp -type C++ -exclude true
solution file add ../src/file_define_catapult.h -type CHEADER -exclude true
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
directive set -IDLE_SIGNAL {}
directive set -STALL_FLAG_SV off
directive set -STALL_FLAG false
directive set -TRANSACTION_DONE_SIGNAL true
directive set -DONE_FLAG {}
directive set -READY_FLAG {}
directive set -START_FLAG {}
directive set -TRANSACTION_SYNC ready
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
directive set -PROTOTYPING_ENGINE oasys
directive set -PIPELINE_RAMP_UP true
go new
directive set -ON_THE_FLY_PROTOTYPING false
go analyze
solution design set afc -top
solution design set ac::fx_div<8> -block
go compile
solution library add nangate-45nm_beh -- -rtlsyntool DesignCompiler -vendor Nangate -technology 045nm
solution library add ccs_sample_mem
go libraries
directive set -CLOCKS {clk {-CLOCK_PERIOD 3.33 -CLOCK_EDGE rising -CLOCK_UNCERTAINTY 0.0 -CLOCK_HIGH_TIME 1.665 -RESET_SYNC_NAME rst -RESET_ASYNC_NAME arst_n -RESET_KIND sync -RESET_SYNC_ACTIVE high -RESET_ASYNC_ACTIVE low -ENABLE_ACTIVE high}}
go assembly
directive set /afc/top_reg.frameWidth:rsc -MAP_TO_MODULE {[DirectInput]}
directive set /afc/top_reg.frameHeight:rsc -MAP_TO_MODULE {[DirectInput]}
directive set /afc/top_reg.inputFormat:rsc -MAP_TO_MODULE {[DirectInput]}
directive set /afc/top_reg.imgPattern:rsc -MAP_TO_MODULE {[DirectInput]}
directive set /afc/top_reg.pipeMode:rsc -MAP_TO_MODULE {[DirectInput]}
directive set /afc/top_reg.blc:rsc -MAP_TO_MODULE {[DirectInput]}
directive set /afc/top_reg.shadowEb:rsc -MAP_TO_MODULE {[DirectInput]}
directive set /afc/top_reg.binningFrameWidth:rsc -MAP_TO_MODULE {[DirectInput]}
directive set /afc/top_reg.binningFrameHeight:rsc -MAP_TO_MODULE {[DirectInput]}
directive set /afc/top_reg.scalerFrameWidth:rsc -MAP_TO_MODULE {[DirectInput]}
directive set /afc/top_reg.scalerFrameHeight:rsc -MAP_TO_MODULE {[DirectInput]}
directive set /afc/afc_reg.eb:rsc -MAP_TO_MODULE {[DirectInput]}
directive set /afc/afc_reg.location_row:rsc -MAP_TO_MODULE {[DirectInput]}
directive set /afc/afc_reg.location_col:rsc -MAP_TO_MODULE {[DirectInput]}
directive set /afc/afc_reg.m_bIfHardThreshold:rsc -MAP_TO_MODULE {[DirectInput]}
directive set /afc/afc_reg.ThrList:rsc -MAP_TO_MODULE {[DirectInput]}
directive set /afc/afc_reg.T:rsc -MAP_TO_MODULE {[DirectInput]}
directive set /afc/core/lineBuffer:rsc -BLOCK_SIZE 8192
directive set /afc/core/rawWindow:rsc -MAP_TO_MODULE {[Register]}
directive set /afc/core/raw_int:rsc -MAP_TO_MODULE {[Register]}
directive set /afc/core/main -PIPELINE_INIT_INTERVAL 1
directive set /afc/core/rawWin_loop -UNROLL yes
directive set /afc/core/rawWindow_read -UNROLL yes
directive set /afc/core/line_write -UNROLL yes
directive set /afc/core/raw_int_read_row -UNROLL yes
directive set /afc/core/raw_int_read_col -UNROLL yes
directive set /afc/core/loop_sobel_1 -UNROLL yes
directive set /afc/core/loop_sobel_2 -UNROLL yes
directive set /afc/core/loop_laplace_1 -UNROLL yes
directive set /afc/core/loop_laplace_2 -UNROLL yes
directive set /afc/core/loop_H5_1 -UNROLL yes
directive set /afc/core/loop_H5_2 -UNROLL yes
directive set /afc/core/loop_IIRH1 -UNROLL yes
directive set /afc/core/loop_IIRH2_1 -UNROLL yes
directive set /afc/core/loop_IIRH2_2 -UNROLL yes
go architect
directive set /afc/core/rawWindow_read:read_mem(lineBuffer:rsc(1)(0).@) -IGNORE_DEPENDENCY_FROM {line_write:write_mem(lineBuffer:rsc(0)(0).@) line_write:write_mem(lineBuffer:rsc(1)(0).@)#1 line_write:write_mem(lineBuffer:rsc(2)(0).@)#2 line_write:write_mem(lineBuffer:rsc(3)(0).@)#3 line_write:write_mem(lineBuffer:rsc(4)(0).@)#4 line_write:write_mem(lineBuffer:rsc(5)(0).@)#5 line_write:write_mem(lineBuffer:rsc(6)(0).@)#6 line_write:write_mem(lineBuffer:rsc(7)(0).@)#7}
directive set /afc/core/rawWindow_read:read_mem(lineBuffer:rsc(2)(0).@)#1 -IGNORE_DEPENDENCY_FROM {line_write:write_mem(lineBuffer:rsc(0)(0).@) line_write:write_mem(lineBuffer:rsc(1)(0).@)#1 line_write:write_mem(lineBuffer:rsc(2)(0).@)#2 line_write:write_mem(lineBuffer:rsc(3)(0).@)#3 line_write:write_mem(lineBuffer:rsc(4)(0).@)#4 line_write:write_mem(lineBuffer:rsc(5)(0).@)#5 line_write:write_mem(lineBuffer:rsc(6)(0).@)#6 line_write:write_mem(lineBuffer:rsc(7)(0).@)#7}
directive set /afc/core/rawWindow_read:read_mem(lineBuffer:rsc(3)(0).@)#2 -IGNORE_DEPENDENCY_FROM {line_write:write_mem(lineBuffer:rsc(0)(0).@) line_write:write_mem(lineBuffer:rsc(1)(0).@)#1 line_write:write_mem(lineBuffer:rsc(2)(0).@)#2 line_write:write_mem(lineBuffer:rsc(3)(0).@)#3 line_write:write_mem(lineBuffer:rsc(4)(0).@)#4 line_write:write_mem(lineBuffer:rsc(5)(0).@)#5 line_write:write_mem(lineBuffer:rsc(6)(0).@)#6 line_write:write_mem(lineBuffer:rsc(7)(0).@)#7}
directive set /afc/core/rawWindow_read:read_mem(lineBuffer:rsc(4)(0).@)#3 -IGNORE_DEPENDENCY_FROM {line_write:write_mem(lineBuffer:rsc(0)(0).@) line_write:write_mem(lineBuffer:rsc(1)(0).@)#1 line_write:write_mem(lineBuffer:rsc(2)(0).@)#2 line_write:write_mem(lineBuffer:rsc(3)(0).@)#3 line_write:write_mem(lineBuffer:rsc(4)(0).@)#4 line_write:write_mem(lineBuffer:rsc(5)(0).@)#5 line_write:write_mem(lineBuffer:rsc(6)(0).@)#6 line_write:write_mem(lineBuffer:rsc(7)(0).@)#7}
directive set /afc/core/rawWindow_read:read_mem(lineBuffer:rsc(5)(0).@)#4 -IGNORE_DEPENDENCY_FROM {line_write:write_mem(lineBuffer:rsc(0)(0).@) line_write:write_mem(lineBuffer:rsc(1)(0).@)#1 line_write:write_mem(lineBuffer:rsc(2)(0).@)#2 line_write:write_mem(lineBuffer:rsc(3)(0).@)#3 line_write:write_mem(lineBuffer:rsc(4)(0).@)#4 line_write:write_mem(lineBuffer:rsc(5)(0).@)#5 line_write:write_mem(lineBuffer:rsc(6)(0).@)#6 line_write:write_mem(lineBuffer:rsc(7)(0).@)#7}
directive set /afc/core/rawWindow_read:read_mem(lineBuffer:rsc(6)(0).@)#5 -IGNORE_DEPENDENCY_FROM {line_write:write_mem(lineBuffer:rsc(0)(0).@) line_write:write_mem(lineBuffer:rsc(1)(0).@)#1 line_write:write_mem(lineBuffer:rsc(2)(0).@)#2 line_write:write_mem(lineBuffer:rsc(3)(0).@)#3 line_write:write_mem(lineBuffer:rsc(4)(0).@)#4 line_write:write_mem(lineBuffer:rsc(5)(0).@)#5 line_write:write_mem(lineBuffer:rsc(6)(0).@)#6 line_write:write_mem(lineBuffer:rsc(7)(0).@)#7}
directive set /afc/core/rawWindow_read:read_mem(lineBuffer:rsc(7)(0).@)#6 -IGNORE_DEPENDENCY_FROM {line_write:write_mem(lineBuffer:rsc(0)(0).@) line_write:write_mem(lineBuffer:rsc(1)(0).@)#1 line_write:write_mem(lineBuffer:rsc(2)(0).@)#2 line_write:write_mem(lineBuffer:rsc(3)(0).@)#3 line_write:write_mem(lineBuffer:rsc(4)(0).@)#4 line_write:write_mem(lineBuffer:rsc(5)(0).@)#5 line_write:write_mem(lineBuffer:rsc(6)(0).@)#6 line_write:write_mem(lineBuffer:rsc(7)(0).@)#7}
directive set /afc/core/rawWindow_read:read_mem(lineBuffer:rsc(0)(0).@)#7 -IGNORE_DEPENDENCY_FROM {line_write:write_mem(lineBuffer:rsc(0)(0).@) line_write:write_mem(lineBuffer:rsc(1)(0).@)#1 line_write:write_mem(lineBuffer:rsc(2)(0).@)#2 line_write:write_mem(lineBuffer:rsc(3)(0).@)#3 line_write:write_mem(lineBuffer:rsc(4)(0).@)#4 line_write:write_mem(lineBuffer:rsc(5)(0).@)#5 line_write:write_mem(lineBuffer:rsc(6)(0).@)#6 line_write:write_mem(lineBuffer:rsc(7)(0).@)#7}
go allocate
go extract
//  Catapult Prime Synthesis 2022.1/981271 (Production Release) Thu Feb 10 22:05:20 PST 2022
//
//          Copyright (c) Siemens EDA, 1996-2022, All Rights Reserved.
//                        UNPUBLISHED, LICENSED SOFTWARE.
//             CONFIDENTIAL AND PROPRIETARY INFORMATION WHICH IS THE
//                   PROPERTY OF SIEMENS EDA OR ITS LICENSORS.
//
//  Running on Linux wanwei.xiao@alish-rs-cs08.eng.t-head.cn 3.10.0-1160.66.1.el7.x86_64 x86_64 aol
//
//  Package information: SIFLIBS v25.1_0.0, HLS_PKGS v25.1_0.0,
//                       SIF_TOOLKITS v25.1_0.0, SIF_XILINX v25.1_0.0,
//                       SIF_ALTERA v25.1_0.0, CCS_LIBS v25.1_0.0,
//                       CDS_PPRO v10.6, CDS_DesigChecker v2022.1,
//                       CDS_OASYS v21.1_2.5, CDS_PSR v21.1_0.4,
//                       DesignPad v2.78_1.0
//
solution new -state initial
solution options defaults
solution options set /Input/CppStandard c++11
solution options set /Output/GenerateCycleNetlist false
solution options set /Flows/SCVerify/USE_QUESTASIM false
solution options set /Flows/SCVerify/USE_OSCI false
solution options set /Flows/SCVerify/USE_VCS true
solution options set /Flows/VCS/VG_ENV32_SCRIPT source_me_gcc483_32.csh
solution options set /Flows/VCS/VG_ENV64_SCRIPT source_me_gcc483_64.csh
solution options set /Flows/VCS/VLOGAN_OPTS {+v2k +no_tchk_msg -kdb -lca}
solution options set /Flows/VCS/VCSELAB_OPTS {-debug_acc+all -debug_region+cell+encrypt -timescale=1ps/1ps -sysc=blocksync -sysc=2.3.1 -sysc=slow_sc_main}
solution options set /Flows/VCS/SYSC_VERSION 2.3.1
flow package require /SCVerify
solution file add ../src/tpg.h -type CHEADER -exclude true
solution file add ../src/tpg.cpp -type C++
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
directive set -IDLE_SIGNAL {}
directive set -STALL_FLAG_SV off
directive set -STALL_FLAG false
directive set -TRANSACTION_DONE_SIGNAL true
directive set -DONE_FLAG {}
directive set -READY_FLAG {}
directive set -START_FLAG {}
directive set -TRANSACTION_SYNC ready
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
directive set -PROTOTYPING_ENGINE oasys
directive set -PIPELINE_RAMP_UP true
go new
solution design set tpg -top
solution design set ac::fx_div<8> -block
go compile
solution library add nangate-45nm_beh -- -rtlsyntool DesignCompiler -vendor Nangate -technology 045nm
solution library add ccs_sample_mem
go libraries
solution design set tpg -top
solution design set ac::fx_div<8> -block
directive set -CLOCKS {clk {-CLOCK_PERIOD 3.33 -CLOCK_EDGE rising -CLOCK_UNCERTAINTY 0.0 -CLOCK_HIGH_TIME 1.665 -RESET_SYNC_NAME rst -RESET_ASYNC_NAME arst_n -RESET_KIND sync -RESET_SYNC_ACTIVE high -RESET_ASYNC_ACTIVE low -ENABLE_ACTIVE high}}
go assembly
directive set /tpg/top_reg.frameWidth:rsc -MAP_TO_MODULE {[DirectInput]}
directive set /tpg/top_reg.frameHeight:rsc -MAP_TO_MODULE {[DirectInput]}
directive set /tpg/top_reg.inputFormat:rsc -MAP_TO_MODULE {[DirectInput]}
directive set /tpg/top_reg.imgPattern:rsc -MAP_TO_MODULE {[DirectInput]}
directive set /tpg/top_reg.pipeMode:rsc -MAP_TO_MODULE {[DirectInput]}
directive set /tpg/top_reg.blc:rsc -MAP_TO_MODULE {[DirectInput]}
directive set /tpg/top_reg.shadowEb:rsc -MAP_TO_MODULE {[DirectInput]}
directive set /tpg/top_reg.binningFrameWidth:rsc -MAP_TO_MODULE {[DirectInput]}
directive set /tpg/top_reg.binningFrameHeight:rsc -MAP_TO_MODULE {[DirectInput]}
directive set /tpg/top_reg.scalerFrameWidth:rsc -MAP_TO_MODULE {[DirectInput]}
directive set /tpg/top_reg.scalerFrameHeight:rsc -MAP_TO_MODULE {[DirectInput]}
directive set /tpg/tpg_reg.m_bTPG_en:rsc -MAP_TO_MODULE {[DirectInput]}
directive set /tpg/tpg_reg.m_nWidth:rsc -MAP_TO_MODULE {[DirectInput]}
directive set /tpg/tpg_reg.m_nHeight:rsc -MAP_TO_MODULE {[DirectInput]}
directive set /tpg/tpg_reg.m_nCFAPattern:rsc -MAP_TO_MODULE {[DirectInput]}
directive set /tpg/tpg_reg.m_bRollingEnable:rsc -MAP_TO_MODULE {[DirectInput]}
directive set /tpg/tpg_reg.m_bSensor_timing_en:rsc -MAP_TO_MODULE {[DirectInput]}
directive set /tpg/tpg_reg.m_nVBlank_num:rsc -MAP_TO_MODULE {[DirectInput]}
directive set /tpg/tpg_reg.m_nHBlank_num:rsc -MAP_TO_MODULE {[DirectInput]}
directive set /tpg/tpg_reg.m_valid_blank:rsc -MAP_TO_MODULE {[DirectInput]}
directive set /tpg/tpg_reg.m_nID:rsc -MAP_TO_MODULE {[DirectInput]}
directive set /tpg/core/main -PIPELINE_INIT_INTERVAL 1
go architect
go extract
//  Catapult Prime Synthesis 2022.1/981271 (Production Release) Thu Feb 10 22:05:20 PST 2022
//
//          Copyright (c) Siemens EDA, 1996-2022, All Rights Reserved.
//                        UNPUBLISHED, LICENSED SOFTWARE.
//             CONFIDENTIAL AND PROPRIETARY INFORMATION WHICH IS THE
//                   PROPERTY OF SIEMENS EDA OR ITS LICENSORS.
//
//  Running on Linux wanwei.xiao@alish-rs-cs08.eng.t-head.cn 3.10.0-1160.66.1.el7.x86_64 x86_64 aol
//
//  Package information: SIFLIBS v25.1_0.0, HLS_PKGS v25.1_0.0,
//                       SIF_TOOLKITS v25.1_0.0, SIF_XILINX v25.1_0.0,
//                       SIF_ALTERA v25.1_0.0, CCS_LIBS v25.1_0.0,
//                       CDS_PPRO v10.6, CDS_DesigChecker v2022.1,
//                       CDS_OASYS v21.1_2.5, CDS_PSR v21.1_0.4,
//                       DesignPad v2.78_1.0
//
solution new -state initial
solution options defaults
solution options set /Input/CppStandard c++11
solution options set /Flows/SCVerify/USE_QUESTASIM false
solution options set /Flows/SCVerify/USE_OSCI false
solution options set /Flows/SCVerify/USE_VCS true
solution options set /Flows/VCS/VG_ENV32_SCRIPT source_me_gcc483_32.csh
solution options set /Flows/VCS/VG_ENV64_SCRIPT source_me_gcc483_64.csh
solution options set /Flows/VCS/VLOGAN_OPTS {+v2k +no_tchk_msg -kdb -lca}
solution options set /Flows/VCS/VCSELAB_OPTS {-debug_acc+all -debug_region+cell+encrypt -timescale=1ps/1ps -sysc=blocksync -sysc=2.3.1 -sysc=slow_sc_main}
solution options set /Flows/VCS/SYSC_VERSION 2.3.1
flow package require /SCVerify
solution file add ../src/dgain.h -type CHEADER -exclude true
solution file add ../src/dgain.cpp -type C++
solution file add ../src/file_define_catapult.h -type CHEADER -exclude true
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
directive set -IDLE_SIGNAL {}
directive set -STALL_FLAG_SV off
directive set -STALL_FLAG false
directive set -TRANSACTION_DONE_SIGNAL true
directive set -DONE_FLAG {}
directive set -READY_FLAG {}
directive set -START_FLAG {}
directive set -TRANSACTION_SYNC ready
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
directive set -PROTOTYPING_ENGINE oasys
directive set -PIPELINE_RAMP_UP true
go new
solution design set dgain -top
solution design set ac::fx_div<8> -block
directive set -ON_THE_FLY_PROTOTYPING false
go analyze
go compile
solution design set dgain -top
solution design set ac::fx_div<8> -block
solution library add nangate-45nm_beh -- -rtlsyntool DesignCompiler -vendor Nangate -technology 045nm
solution library add ccs_sample_mem
go libraries
directive set -CLOCKS {clk {-CLOCK_PERIOD 3.33 -CLOCK_EDGE rising -CLOCK_UNCERTAINTY 0.0 -CLOCK_HIGH_TIME 1.665 -RESET_SYNC_NAME rst -RESET_ASYNC_NAME arst_n -RESET_KIND sync -RESET_SYNC_ACTIVE high -RESET_ASYNC_ACTIVE low -ENABLE_ACTIVE high}}
go assembly
directive set /dgain/top_reg.frameWidth:rsc -MAP_TO_MODULE {[DirectInput]}
directive set /dgain/top_reg.frameHeight:rsc -MAP_TO_MODULE {[DirectInput]}
directive set /dgain/top_reg.inputFormat:rsc -MAP_TO_MODULE {[DirectInput]}
directive set /dgain/top_reg.imgPattern:rsc -MAP_TO_MODULE {[DirectInput]}
directive set /dgain/top_reg.pipeMode:rsc -MAP_TO_MODULE {[DirectInput]}
directive set /dgain/top_reg.blc:rsc -MAP_TO_MODULE {[DirectInput]}
directive set /dgain/top_reg.shadowEb:rsc -MAP_TO_MODULE {[DirectInput]}
directive set /dgain/top_reg.binningFrameWidth:rsc -MAP_TO_MODULE {[DirectInput]}
directive set /dgain/top_reg.binningFrameHeight:rsc -MAP_TO_MODULE {[DirectInput]}
directive set /dgain/top_reg.scalerFrameWidth:rsc -MAP_TO_MODULE {[DirectInput]}
directive set /dgain/top_reg.scalerFrameHeight:rsc -MAP_TO_MODULE {[DirectInput]}
directive set /dgain/dgain_reg.m_nEb:rsc -MAP_TO_MODULE {[DirectInput]}
directive set /dgain/dgain_reg.m_nBlcR:rsc -MAP_TO_MODULE {[DirectInput]}
directive set /dgain/dgain_reg.m_nBlcGr:rsc -MAP_TO_MODULE {[DirectInput]}
directive set /dgain/dgain_reg.m_nBlcGb:rsc -MAP_TO_MODULE {[DirectInput]}
directive set /dgain/dgain_reg.m_nBlcB:rsc -MAP_TO_MODULE {[DirectInput]}
directive set /dgain/dgain_reg.m_nR:rsc -MAP_TO_MODULE {[DirectInput]}
directive set /dgain/dgain_reg.m_nGr:rsc -MAP_TO_MODULE {[DirectInput]}
directive set /dgain/dgain_reg.m_nGb:rsc -MAP_TO_MODULE {[DirectInput]}
directive set /dgain/dgain_reg.m_nB:rsc -MAP_TO_MODULE {[DirectInput]}
directive set /dgain/core/main -PIPELINE_INIT_INTERVAL 1
go allocate
go extract
//  Catapult Prime Synthesis 2022.1/981271 (Production Release) Thu Feb 10 22:05:20 PST 2022
//
//          Copyright (c) Siemens EDA, 1996-2022, All Rights Reserved.
//                        UNPUBLISHED, LICENSED SOFTWARE.
//             CONFIDENTIAL AND PROPRIETARY INFORMATION WHICH IS THE
//                   PROPERTY OF SIEMENS EDA OR ITS LICENSORS.
//
//  Running on Linux wanwei.xiao@alish-rs-cs08.eng.t-head.cn 3.10.0-1160.66.1.el7.x86_64 x86_64 aol
//
//  Package information: SIFLIBS v25.1_0.0, HLS_PKGS v25.1_0.0,
//                       SIF_TOOLKITS v25.1_0.0, SIF_XILINX v25.1_0.0,
//                       SIF_ALTERA v25.1_0.0, CCS_LIBS v25.1_0.0,
//                       CDS_PPRO v10.6, CDS_DesigChecker v2022.1,
//                       CDS_OASYS v21.1_2.5, CDS_PSR v21.1_0.4,
//                       DesignPad v2.78_1.0
//
solution new -state initial
solution options defaults
solution options set /Input/CppStandard c++11
solution options set /Output/GenerateCycleNetlist false
solution options set /Flows/SCVerify/USE_QUESTASIM false
solution options set /Flows/SCVerify/USE_OSCI false
solution options set /Flows/SCVerify/USE_VCS true
solution options set /Flows/VCS/VG_ENV32_SCRIPT source_me_gcc483_32.csh
solution options set /Flows/VCS/VG_ENV64_SCRIPT source_me_gcc483_64.csh
solution options set /Flows/VCS/VLOGAN_OPTS {+v2k +no_tchk_msg -kdb -lca}
solution options set /Flows/VCS/VCSELAB_OPTS {-debug_acc+all -debug_region+cell+encrypt -timescale=1ps/1ps -sysc=blocksync -sysc=2.3.1 -sysc=slow_sc_main}
solution options set /Flows/VCS/SYSC_VERSION 2.3.1
flow package require /SCVerify
solution file add ../src/lsc.cpp -type C++
solution file add ../src/lsc.h -type CHEADER -exclude true
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
directive set -IDLE_SIGNAL {}
directive set -STALL_FLAG_SV off
directive set -STALL_FLAG false
directive set -TRANSACTION_DONE_SIGNAL true
directive set -DONE_FLAG {}
directive set -READY_FLAG {}
directive set -START_FLAG {}
directive set -TRANSACTION_SYNC ready
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
directive set -PROTOTYPING_ENGINE oasys
directive set -PIPELINE_RAMP_UP true
go new
solution design set lsc -top
solution design set ac::fx_div<8> -block
go analyze
go compile
solution design set lsc -top
solution library add nangate-45nm_beh -- -rtlsyntool DesignCompiler -vendor Nangate -technology 045nm
solution library add ccs_sample_mem
go libraries
directive set -CLOCKS {clk {-CLOCK_PERIOD 3.33 -CLOCK_EDGE rising -CLOCK_UNCERTAINTY 0.0 -CLOCK_HIGH_TIME 1.665 -RESET_SYNC_NAME rst -RESET_ASYNC_NAME arst_n -RESET_KIND sync -RESET_SYNC_ACTIVE high -RESET_ASYNC_ACTIVE low -ENABLE_ACTIVE high}}
go assembly
directive set /lsc/topRegister.frameWidth:rsc -MAP_TO_MODULE {[DirectInput]}
directive set /lsc/topRegister.frameHeight:rsc -MAP_TO_MODULE {[DirectInput]}
directive set /lsc/topRegister.inputFormat:rsc -MAP_TO_MODULE {[DirectInput]}
directive set /lsc/topRegister.imgPattern:rsc -MAP_TO_MODULE {[DirectInput]}
directive set /lsc/topRegister.pipeMode:rsc -MAP_TO_MODULE {[DirectInput]}
directive set /lsc/topRegister.blc:rsc -MAP_TO_MODULE {[DirectInput]}
directive set /lsc/topRegister.shadowEb:rsc -MAP_TO_MODULE {[DirectInput]}
directive set /lsc/topRegister.binningFrameWidth:rsc -MAP_TO_MODULE {[DirectInput]}
directive set /lsc/topRegister.binningFrameHeight:rsc -MAP_TO_MODULE {[DirectInput]}
directive set /lsc/topRegister.scalerFrameWidth:rsc -MAP_TO_MODULE {[DirectInput]}
directive set /lsc/topRegister.scalerFrameHeight:rsc -MAP_TO_MODULE {[DirectInput]}
directive set /lsc/lscRegister.eb:rsc -MAP_TO_MODULE {[DirectInput]}
directive set /lsc/lscRegister.blockHeight:rsc -MAP_TO_MODULE {[DirectInput]}
directive set /lsc/lscRegister.blockWidth:rsc -MAP_TO_MODULE {[DirectInput]}
directive set /lsc/lscRegister.blockWidth_1:rsc -MAP_TO_MODULE {[DirectInput]}
directive set /lsc/lscRegister.blockHeight_1:rsc -MAP_TO_MODULE {[DirectInput]}
directive set /lsc/core/main -PIPELINE_INIT_INTERVAL 1
directive set /lsc/lscRegister.rGain:rsc -MAP_TO_MODULE {[DirectInput]}
directive set /lsc/lscRegister.rGain:rsc -PACKING_MODE sidebyside
directive set /lsc/lscRegister.rGain -WORD_WIDTH 2873
directive set /lsc/lscRegister.GrGain:rsc -MAP_TO_MODULE {[DirectInput]}
directive set /lsc/lscRegister.GrGain:rsc -PACKING_MODE sidebyside
directive set /lsc/lscRegister.GrGain -WORD_WIDTH 2873
directive set /lsc/lscRegister.GbGain:rsc -MAP_TO_MODULE {[DirectInput]}
directive set /lsc/lscRegister.GbGain:rsc -PACKING_MODE sidebyside
directive set /lsc/lscRegister.GbGain -WORD_WIDTH 2873
directive set /lsc/lscRegister.bGain:rsc -MAP_TO_MODULE {[DirectInput]}
directive set /lsc/lscRegister.bGain:rsc -PACKING_MODE sidebyside
directive set /lsc/lscRegister.bGain -WORD_WIDTH 2873
go architect
go extract
//  Catapult Ultra Synthesis 2022.1/981271 (Production Release) Thu Feb 10 22:05:20 PST 2022
//
//          Copyright (c) Siemens EDA, 1996-2022, All Rights Reserved.
//                        UNPUBLISHED, LICENSED SOFTWARE.
//             CONFIDENTIAL AND PROPRIETARY INFORMATION WHICH IS THE
//                   PROPERTY OF SIEMENS EDA OR ITS LICENSORS.
//
//  Running on Linux yasun@n8sa24 3.10.0-957.27.2.el7.x86_64 x86_64 aol
//
//  Package information: SIFLIBS v25.1_0.0, HLS_PKGS v25.1_0.0,
//                       SIF_TOOLKITS v25.1_0.0, SIF_XILINX v25.1_0.0,
//                       SIF_ALTERA v25.1_0.0, CCS_LIBS v25.1_0.0,
//                       CDS_PPRO v10.6, CDS_DesigChecker v2022.1,
//                       CDS_OASYS v21.1_2.5, CDS_PSR v21.1_0.4,
//                       DesignPad v2.78_1.0
//
solution new -state initial
solution options defaults
solution options set /Input/CppStandard c++11
solution options set /Output/GenerateCycleNetlist false
solution options set /Flows/SCVerify/USE_QUESTASIM false
solution options set /Flows/SCVerify/USE_OSCI false
solution options set /Flows/SCVerify/USE_VCS true
solution options set /Flows/VCS/VG_ENV32_SCRIPT source_me_gcc483_32.csh
solution options set /Flows/VCS/VG_ENV64_SCRIPT source_me_gcc483_64.csh
solution options set /Flows/VCS/VLOGAN_OPTS {+v2k +no_tchk_msg -kdb -lca}
solution options set /Flows/VCS/VCSELAB_OPTS {-debug_acc+all -debug_region+cell+encrypt -timescale=1ps/1ps -sysc=blocksync -sysc=2.3.1 -sysc=slow_sc_main}
solution options set /Flows/VCS/SYSC_VERSION 2.3.1
flow package require /SCVerify
solution file add ../src/dpc.h -type CHEADER -exclude true
solution file add ../src/dpc.cpp -type C++
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
directive set -IDLE_SIGNAL {}
directive set -STALL_FLAG_SV off
directive set -STALL_FLAG false
directive set -TRANSACTION_DONE_SIGNAL true
directive set -DONE_FLAG {}
directive set -READY_FLAG {}
directive set -START_FLAG {}
directive set -TRANSACTION_SYNC ready
directive set -RESET_CLEARS_ALL_REGS use_library
directive set -CLOCK_OVERHEAD 20.000000
directive set -ON_THE_FLY_PROTOTYPING false
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
directive set -PROTOTYPING_ENGINE oasys
directive set -PIPELINE_RAMP_UP true
go new
solution design set dpc -top
solution design set ac::fx_div<8> -block
go compile
solution design set dpc -top
solution design set ac::fx_div<8> -block
solution library add nangate-45nm_beh -- -rtlsyntool DesignCompiler -vendor Nangate -technology 045nm
solution library add ccs_sample_mem
go libraries
directive set -CLOCKS {clk {-CLOCK_PERIOD 3.33 -CLOCK_EDGE rising -CLOCK_UNCERTAINTY 0.0 -CLOCK_HIGH_TIME 1.665 -RESET_SYNC_NAME rst -RESET_ASYNC_NAME arst_n -RESET_KIND sync -RESET_SYNC_ACTIVE high -RESET_ASYNC_ACTIVE low -ENABLE_ACTIVE high}}
go assembly
directive set /dpc/core/lineBuffer:rsc -BLOCK_SIZE 8192
directive set /dpc/core/main -PIPELINE_INIT_INTERVAL 1
directive set /dpc/core/rawWin_loop -UNROLL yes
directive set /dpc/core/rawWindow_read -UNROLL yes
directive set /dpc/core/line_write -UNROLL yes
directive set /dpc/core/MF_outer -UNROLL yes
directive set /dpc/core/MF_inter -UNROLL yes
directive set /dpc/core/MF_outer#1 -UNROLL yes
directive set /dpc/core/MF_inter#1 -UNROLL yes
directive set /dpc/top_reg.frameWidth:rsc -MAP_TO_MODULE {[DirectInput]}
directive set /dpc/top_reg.frameHeight:rsc -MAP_TO_MODULE {[DirectInput]}
directive set /dpc/top_reg.inputFormat:rsc -MAP_TO_MODULE {[DirectInput]}
directive set /dpc/top_reg.imgPattern:rsc -MAP_TO_MODULE {[DirectInput]}
directive set /dpc/top_reg.pipeMode:rsc -MAP_TO_MODULE {[DirectInput]}
directive set /dpc/top_reg.blc:rsc -MAP_TO_MODULE {[DirectInput]}
directive set /dpc/top_reg.shadowEb:rsc -MAP_TO_MODULE {[DirectInput]}
directive set /dpc/top_reg.binningFrameWidth:rsc -MAP_TO_MODULE {[DirectInput]}
directive set /dpc/top_reg.binningFrameHeight:rsc -MAP_TO_MODULE {[DirectInput]}
directive set /dpc/top_reg.scalerFrameWidth:rsc -MAP_TO_MODULE {[DirectInput]}
directive set /dpc/top_reg.scalerFrameHeight:rsc -MAP_TO_MODULE {[DirectInput]}
directive set /dpc/dpc_reg.eb:rsc -MAP_TO_MODULE {[DirectInput]}
directive set /dpc/dpc_reg.th_w:rsc -MAP_TO_MODULE {[DirectInput]}
directive set /dpc/dpc_reg.th_b:rsc -MAP_TO_MODULE {[DirectInput]}
directive set /dpc/core/main -PIPELINE_STALL_MODE flush
directive set /dpc/core -CLOCK_OVERHEAD 0.000000
go architect
directive set /dpc/core/rawWindow_read:read_mem(lineBuffer:rsc(0)(0).@) -IGNORE_DEPENDENCY_FROM {line_write:write_mem(lineBuffer:rsc(0)(0).@) line_write:write_mem(lineBuffer:rsc(1)(0).@)#1 line_write:write_mem(lineBuffer:rsc(2)(0).@)#2 line_write:write_mem(lineBuffer:rsc(3)(0).@)#3}
directive set /dpc/core/rawWindow_read:read_mem(lineBuffer:rsc(1)(0).@)#1 -IGNORE_DEPENDENCY_FROM {line_write:write_mem(lineBuffer:rsc(0)(0).@) line_write:write_mem(lineBuffer:rsc(1)(0).@)#1 line_write:write_mem(lineBuffer:rsc(2)(0).@)#2 line_write:write_mem(lineBuffer:rsc(3)(0).@)#3}
directive set /dpc/core/rawWindow_read:read_mem(lineBuffer:rsc(2)(0).@)#2 -IGNORE_DEPENDENCY_FROM {line_write:write_mem(lineBuffer:rsc(0)(0).@) line_write:write_mem(lineBuffer:rsc(1)(0).@)#1 line_write:write_mem(lineBuffer:rsc(2)(0).@)#2 line_write:write_mem(lineBuffer:rsc(3)(0).@)#3}
directive set /dpc/core/rawWindow_read:read_mem(lineBuffer:rsc(3)(0).@)#3 -IGNORE_DEPENDENCY_FROM {line_write:write_mem(lineBuffer:rsc(0)(0).@) line_write:write_mem(lineBuffer:rsc(1)(0).@)#1 line_write:write_mem(lineBuffer:rsc(2)(0).@)#2 line_write:write_mem(lineBuffer:rsc(3)(0).@)#3}
go allocate
go extract
//  Catapult Prime Synthesis 2022.1/981271 (Production Release) Thu Feb 10 22:05:20 PST 2022
//
//          Copyright (c) Siemens EDA, 1996-2022, All Rights Reserved.
//                        UNPUBLISHED, LICENSED SOFTWARE.
//             CONFIDENTIAL AND PROPRIETARY INFORMATION WHICH IS THE
//                   PROPERTY OF SIEMENS EDA OR ITS LICENSORS.
//
//  Running on Linux wanwei.xiao@alish-rs-cs08.eng.t-head.cn 3.10.0-1160.66.1.el7.x86_64 x86_64 aol
//
//  Package information: SIFLIBS v25.1_0.0, HLS_PKGS v25.1_0.0,
//                       SIF_TOOLKITS v25.1_0.0, SIF_XILINX v25.1_0.0,
//                       SIF_ALTERA v25.1_0.0, CCS_LIBS v25.1_0.0,
//                       CDS_PPRO v10.6, CDS_DesigChecker v2022.1,
//                       CDS_OASYS v21.1_2.5, CDS_PSR v21.1_0.4,
//                       DesignPad v2.78_1.0
//
solution new -state initial
solution options defaults
solution options set /Input/CppStandard c++11
solution options set /Output/GenerateCycleNetlist false
solution options set /Flows/SCVerify/USE_QUESTASIM false
solution options set /Flows/SCVerify/USE_OSCI false
solution options set /Flows/SCVerify/USE_VCS true
solution options set /Flows/VCS/VG_ENV32_SCRIPT source_me_gcc483_32.csh
solution options set /Flows/VCS/VG_ENV64_SCRIPT source_me_gcc483_64.csh
solution options set /Flows/VCS/VLOGAN_OPTS {+v2k +no_tchk_msg -kdb -lca}
solution options set /Flows/VCS/VCSELAB_OPTS {-debug_acc+all -debug_region+cell+encrypt -timescale=1ps/1ps -sysc=blocksync -sysc=2.3.1 -sysc=slow_sc_main}
solution options set /Flows/VCS/SYSC_VERSION 2.3.1
flow package require /SCVerify
solution file add ../src/rawdns.h -type CHEADER -exclude true
solution file add ../src/rawdns.cpp -type C++
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
directive set -IDLE_SIGNAL {}
directive set -STALL_FLAG_SV off
directive set -STALL_FLAG false
directive set -TRANSACTION_DONE_SIGNAL true
directive set -DONE_FLAG {}
directive set -READY_FLAG {}
directive set -START_FLAG {}
directive set -TRANSACTION_SYNC ready
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
directive set -PROTOTYPING_ENGINE oasys
directive set -PIPELINE_RAMP_UP true
go new
solution design set isp_rawdns -top
solution design set ac::fx_div<8> -block
go analyze
solution design set isp_rawdns -top
solution design set ac::fx_div<8> -block
solution design set rawdns_process -block
solution design set rawdns_process -top
solution design set isp_rawdns -block
go compile
solution library add nangate-45nm_beh -- -rtlsyntool DesignCompiler -vendor Nangate -technology 045nm
go libraries
solution design set rawdns_process -ccore
directive set -CLOCKS {clk {-CLOCK_PERIOD 3.33 -CLOCK_EDGE rising -CLOCK_UNCERTAINTY 0.0 -CLOCK_HIGH_TIME 1.665 -RESET_SYNC_NAME rst -RESET_ASYNC_NAME arst_n -RESET_KIND sync -RESET_SYNC_ACTIVE high -RESET_ASYNC_ACTIVE low -ENABLE_ACTIVE high}}
go assembly
directive set /rawdns_process/core/main -PIPELINE_INIT_INTERVAL 1
directive set /rawdns_process/core/for -UNROLL yes
directive set /rawdns_process/core/for:for -UNROLL yes
directive set /rawdns_process/core/Cal_Eur_Distance:for -UNROLL yes
directive set /rawdns_process/core/Cal_Eur_Distance:for:for -UNROLL yes
directive set /rawdns_process/core/Cal_Eur_Distance:for#1 -UNROLL yes
directive set /rawdns_process/core/Cal_Eur_Distance:for#1:for -UNROLL yes
directive set /rawdns_process/core/ac_math::ac_div<25,13,25,13>:for -UNROLL yes
go architect
go extract
//  Catapult Prime Synthesis 2022.1/981271 (Production Release) Thu Feb 10 22:05:20 PST 2022
//
//          Copyright (c) Siemens EDA, 1996-2022, All Rights Reserved.
//                        UNPUBLISHED, LICENSED SOFTWARE.
//             CONFIDENTIAL AND PROPRIETARY INFORMATION WHICH IS THE
//                   PROPERTY OF SIEMENS EDA OR ITS LICENSORS.
//
//  Running on Linux wanwei.xiao@alish-rs-cs08.eng.t-head.cn 3.10.0-1160.66.1.el7.x86_64 x86_64 aol
//
//  Package information: SIFLIBS v25.1_0.0, HLS_PKGS v25.1_0.0,
//                       SIF_TOOLKITS v25.1_0.0, SIF_XILINX v25.1_0.0,
//                       SIF_ALTERA v25.1_0.0, CCS_LIBS v25.1_0.0,
//                       CDS_PPRO v10.6, CDS_DesigChecker v2022.1,
//                       CDS_OASYS v21.1_2.5, CDS_PSR v21.1_0.4,
//                       DesignPad v2.78_1.0
//
solution new -state initial
solution options defaults
solution options set /Input/CppStandard c++11
solution options set /Output/GenerateCycleNetlist false
solution options set /Flows/SCVerify/USE_QUESTASIM false
solution options set /Flows/SCVerify/USE_OSCI false
solution options set /Flows/SCVerify/USE_VCS true
solution options set /Flows/VCS/VG_ENV32_SCRIPT source_me_gcc483_32.csh
solution options set /Flows/VCS/VG_ENV64_SCRIPT source_me_gcc483_64.csh
solution options set /Flows/VCS/VLOGAN_OPTS {+v2k +no_tchk_msg -kdb -lca}
solution options set /Flows/VCS/VCSELAB_OPTS {-debug_acc+all -debug_region+cell+encrypt -timescale=1ps/1ps -sysc=blocksync -sysc=2.3.1 -sysc=slow_sc_main}
solution options set /Flows/VCS/SYSC_VERSION 2.3.1
flow package require /SCVerify
solution file add ../src/rawdns.h -type CHEADER -exclude true
solution file add ../src/rawdns.cpp -type C++
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
directive set -IDLE_SIGNAL {}
directive set -STALL_FLAG_SV off
directive set -STALL_FLAG false
directive set -TRANSACTION_DONE_SIGNAL true
directive set -DONE_FLAG {}
directive set -READY_FLAG {}
directive set -START_FLAG {}
directive set -TRANSACTION_SYNC ready
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
directive set -PROTOTYPING_ENGINE oasys
directive set -PIPELINE_RAMP_UP true
go new
solution design set isp_rawdns -top
solution design set ac::fx_div<8> -block
go analyze
solution design set isp_rawdns -block
solution design set ac::fx_div<8> -block
solution design set rawdns_process -top -ccore
solution design set rawdns_process -block
solution design set isp_rawdns -top
go compile
solution library add nangate-45nm_beh -- -rtlsyntool DesignCompiler -vendor Nangate -technology 045nm
solution library add ccs_sample_mem
go libraries
directive set -CLOCKS {clk {-CLOCK_PERIOD 3.33 -CLOCK_EDGE rising -CLOCK_UNCERTAINTY 0.0 -CLOCK_HIGH_TIME 1.665 -RESET_SYNC_NAME rst -RESET_ASYNC_NAME arst_n -RESET_KIND sync -RESET_SYNC_ACTIVE high -RESET_ASYNC_ACTIVE low -ENABLE_ACTIVE high}}
go assembly
directive set /isp_rawdns/top_reg.frameWidth:rsc -MAP_TO_MODULE {[DirectInput]}
directive set /isp_rawdns/top_reg.frameHeight:rsc -MAP_TO_MODULE {[DirectInput]}
directive set /isp_rawdns/top_reg.inputFormat:rsc -MAP_TO_MODULE {[DirectInput]}
directive set /isp_rawdns/top_reg.imgPattern:rsc -MAP_TO_MODULE {[DirectInput]}
directive set /isp_rawdns/top_reg.pipeMode:rsc -MAP_TO_MODULE {[DirectInput]}
directive set /isp_rawdns/top_reg.blc:rsc -MAP_TO_MODULE {[DirectInput]}
directive set /isp_rawdns/top_reg.shadowEb:rsc -MAP_TO_MODULE {[DirectInput]}
directive set /isp_rawdns/top_reg.binningFrameWidth:rsc -MAP_TO_MODULE {[DirectInput]}
directive set /isp_rawdns/top_reg.binningFrameHeight:rsc -MAP_TO_MODULE {[DirectInput]}
directive set /isp_rawdns/top_reg.scalerFrameWidth:rsc -MAP_TO_MODULE {[DirectInput]}
directive set /isp_rawdns/top_reg.scalerFrameHeight:rsc -MAP_TO_MODULE {[DirectInput]}
directive set /isp_rawdns/rawdns_reg.sigma:rsc -MAP_TO_MODULE {[DirectInput]}
directive set /isp_rawdns/rawdns_reg.eb:rsc -MAP_TO_MODULE {[DirectInput]}
directive set /isp_rawdns/rawdns_reg.Filterpara:rsc -MAP_TO_MODULE {[DirectInput]}
directive set /isp_rawdns/rawdns_reg.invksigma2:rsc -MAP_TO_MODULE {[DirectInput]}
directive set /isp_rawdns/core/rawdns_lines:rsc -BLOCK_SIZE 8192
directive set /isp_rawdns/core/rawdns_block:rsc -MAP_TO_MODULE {[Register]}
directive set /isp_rawdns/core/main -PIPELINE_INIT_INTERVAL 1
directive set /isp_rawdns/core/pixel_loop -PIPELINE_INIT_INTERVAL 1
directive set /isp_rawdns/core/padding_loop1 -PIPELINE_INIT_INTERVAL 1
directive set /isp_rawdns/core/padding_loop2 -PIPELINE_INIT_INTERVAL 1
directive set /isp_rawdns/core/reg_refresh_out_loop -UNROLL yes
directive set /isp_rawdns/core/reg_refresh_inner_loop -UNROLL yes
directive set /isp_rawdns/core/pixel_loop:if#1:for -UNROLL yes
directive set /isp_rawdns/core/pixel_loop:if#1:for#1 -UNROLL yes
directive set /isp_rawdns/core/loop2_inner_loop -UNROLL no
go architect
directive set /isp_rawdns/core/pixel_loop:if#1:for:read_mem(rawdns_lines:rsc(1)(0).@) -IGNORE_DEPENDENCY_FROM {pixel_loop:if#1:for#1:write_mem(rawdns_lines:rsc(0)(0).@) pixel_loop:if#1:for#1:write_mem(rawdns_lines:rsc(1)(0).@)#1 pixel_loop:if#1:for#1:write_mem(rawdns_lines:rsc(2)(0).@)#2 pixel_loop:if#1:for#1:write_mem(rawdns_lines:rsc(3)(0).@)#3 pixel_loop:if#1:for#1:write_mem(rawdns_lines:rsc(4)(0).@)#4 pixel_loop:if#1:for#1:write_mem(rawdns_lines:rsc(5)(0).@)#5 pixel_loop:if#1:for#1:write_mem(rawdns_lines:rsc(6)(0).@)#6 pixel_loop:if#1:for#1:write_mem(rawdns_lines:rsc(7)(0).@)#7 pixel_loop:if#1:for#1:write_mem(rawdns_lines:rsc(8)(0).@)#8 pixel_loop:if#1:for#1:write_mem(rawdns_lines:rsc(9)(0).@)#9}
directive set /isp_rawdns/core/pixel_loop:if#1:for:read_mem(rawdns_lines:rsc(2)(0).@)#1 -IGNORE_DEPENDENCY_FROM {pixel_loop:if#1:for#1:write_mem(rawdns_lines:rsc(0)(0).@) pixel_loop:if#1:for#1:write_mem(rawdns_lines:rsc(1)(0).@)#1 pixel_loop:if#1:for#1:write_mem(rawdns_lines:rsc(2)(0).@)#2 pixel_loop:if#1:for#1:write_mem(rawdns_lines:rsc(3)(0).@)#3 pixel_loop:if#1:for#1:write_mem(rawdns_lines:rsc(4)(0).@)#4 pixel_loop:if#1:for#1:write_mem(rawdns_lines:rsc(5)(0).@)#5 pixel_loop:if#1:for#1:write_mem(rawdns_lines:rsc(6)(0).@)#6 pixel_loop:if#1:for#1:write_mem(rawdns_lines:rsc(7)(0).@)#7 pixel_loop:if#1:for#1:write_mem(rawdns_lines:rsc(8)(0).@)#8 pixel_loop:if#1:for#1:write_mem(rawdns_lines:rsc(9)(0).@)#9}
directive set /isp_rawdns/core/pixel_loop:if#1:for:read_mem(rawdns_lines:rsc(3)(0).@)#2 -IGNORE_DEPENDENCY_FROM {pixel_loop:if#1:for#1:write_mem(rawdns_lines:rsc(0)(0).@) pixel_loop:if#1:for#1:write_mem(rawdns_lines:rsc(1)(0).@)#1 pixel_loop:if#1:for#1:write_mem(rawdns_lines:rsc(2)(0).@)#2 pixel_loop:if#1:for#1:write_mem(rawdns_lines:rsc(3)(0).@)#3 pixel_loop:if#1:for#1:write_mem(rawdns_lines:rsc(4)(0).@)#4 pixel_loop:if#1:for#1:write_mem(rawdns_lines:rsc(5)(0).@)#5 pixel_loop:if#1:for#1:write_mem(rawdns_lines:rsc(6)(0).@)#6 pixel_loop:if#1:for#1:write_mem(rawdns_lines:rsc(7)(0).@)#7 pixel_loop:if#1:for#1:write_mem(rawdns_lines:rsc(8)(0).@)#8 pixel_loop:if#1:for#1:write_mem(rawdns_lines:rsc(9)(0).@)#9}
directive set /isp_rawdns/core/pixel_loop:if#1:for:read_mem(rawdns_lines:rsc(4)(0).@)#3 -IGNORE_DEPENDENCY_FROM {pixel_loop:if#1:for#1:write_mem(rawdns_lines:rsc(0)(0).@) pixel_loop:if#1:for#1:write_mem(rawdns_lines:rsc(1)(0).@)#1 pixel_loop:if#1:for#1:write_mem(rawdns_lines:rsc(2)(0).@)#2 pixel_loop:if#1:for#1:write_mem(rawdns_lines:rsc(3)(0).@)#3 pixel_loop:if#1:for#1:write_mem(rawdns_lines:rsc(4)(0).@)#4 pixel_loop:if#1:for#1:write_mem(rawdns_lines:rsc(5)(0).@)#5 pixel_loop:if#1:for#1:write_mem(rawdns_lines:rsc(6)(0).@)#6 pixel_loop:if#1:for#1:write_mem(rawdns_lines:rsc(7)(0).@)#7 pixel_loop:if#1:for#1:write_mem(rawdns_lines:rsc(8)(0).@)#8 pixel_loop:if#1:for#1:write_mem(rawdns_lines:rsc(9)(0).@)#9}
directive set /isp_rawdns/core/pixel_loop:if#1:for:read_mem(rawdns_lines:rsc(5)(0).@)#4 -IGNORE_DEPENDENCY_FROM {pixel_loop:if#1:for#1:write_mem(rawdns_lines:rsc(0)(0).@) pixel_loop:if#1:for#1:write_mem(rawdns_lines:rsc(1)(0).@)#1 pixel_loop:if#1:for#1:write_mem(rawdns_lines:rsc(2)(0).@)#2 pixel_loop:if#1:for#1:write_mem(rawdns_lines:rsc(3)(0).@)#3 pixel_loop:if#1:for#1:write_mem(rawdns_lines:rsc(4)(0).@)#4 pixel_loop:if#1:for#1:write_mem(rawdns_lines:rsc(5)(0).@)#5 pixel_loop:if#1:for#1:write_mem(rawdns_lines:rsc(6)(0).@)#6 pixel_loop:if#1:for#1:write_mem(rawdns_lines:rsc(7)(0).@)#7 pixel_loop:if#1:for#1:write_mem(rawdns_lines:rsc(8)(0).@)#8 pixel_loop:if#1:for#1:write_mem(rawdns_lines:rsc(9)(0).@)#9}
directive set /isp_rawdns/core/pixel_loop:if#1:for:read_mem(rawdns_lines:rsc(6)(0).@)#5 -IGNORE_DEPENDENCY_FROM {pixel_loop:if#1:for#1:write_mem(rawdns_lines:rsc(0)(0).@) pixel_loop:if#1:for#1:write_mem(rawdns_lines:rsc(1)(0).@)#1 pixel_loop:if#1:for#1:write_mem(rawdns_lines:rsc(2)(0).@)#2 pixel_loop:if#1:for#1:write_mem(rawdns_lines:rsc(3)(0).@)#3 pixel_loop:if#1:for#1:write_mem(rawdns_lines:rsc(4)(0).@)#4 pixel_loop:if#1:for#1:write_mem(rawdns_lines:rsc(5)(0).@)#5 pixel_loop:if#1:for#1:write_mem(rawdns_lines:rsc(6)(0).@)#6 pixel_loop:if#1:for#1:write_mem(rawdns_lines:rsc(7)(0).@)#7 pixel_loop:if#1:for#1:write_mem(rawdns_lines:rsc(8)(0).@)#8 pixel_loop:if#1:for#1:write_mem(rawdns_lines:rsc(9)(0).@)#9}
directive set /isp_rawdns/core/pixel_loop:if#1:for:read_mem(rawdns_lines:rsc(7)(0).@)#6 -IGNORE_DEPENDENCY_FROM {pixel_loop:if#1:for#1:write_mem(rawdns_lines:rsc(0)(0).@) pixel_loop:if#1:for#1:write_mem(rawdns_lines:rsc(1)(0).@)#1 pixel_loop:if#1:for#1:write_mem(rawdns_lines:rsc(2)(0).@)#2 pixel_loop:if#1:for#1:write_mem(rawdns_lines:rsc(3)(0).@)#3 pixel_loop:if#1:for#1:write_mem(rawdns_lines:rsc(4)(0).@)#4 pixel_loop:if#1:for#1:write_mem(rawdns_lines:rsc(5)(0).@)#5 pixel_loop:if#1:for#1:write_mem(rawdns_lines:rsc(6)(0).@)#6 pixel_loop:if#1:for#1:write_mem(rawdns_lines:rsc(7)(0).@)#7 pixel_loop:if#1:for#1:write_mem(rawdns_lines:rsc(8)(0).@)#8 pixel_loop:if#1:for#1:write_mem(rawdns_lines:rsc(9)(0).@)#9}
directive set /isp_rawdns/core/pixel_loop:if#1:for:read_mem(rawdns_lines:rsc(8)(0).@)#7 -IGNORE_DEPENDENCY_FROM {pixel_loop:if#1:for#1:write_mem(rawdns_lines:rsc(0)(0).@) pixel_loop:if#1:for#1:write_mem(rawdns_lines:rsc(1)(0).@)#1 pixel_loop:if#1:for#1:write_mem(rawdns_lines:rsc(2)(0).@)#2 pixel_loop:if#1:for#1:write_mem(rawdns_lines:rsc(3)(0).@)#3 pixel_loop:if#1:for#1:write_mem(rawdns_lines:rsc(4)(0).@)#4 pixel_loop:if#1:for#1:write_mem(rawdns_lines:rsc(5)(0).@)#5 pixel_loop:if#1:for#1:write_mem(rawdns_lines:rsc(6)(0).@)#6 pixel_loop:if#1:for#1:write_mem(rawdns_lines:rsc(7)(0).@)#7 pixel_loop:if#1:for#1:write_mem(rawdns_lines:rsc(8)(0).@)#8 pixel_loop:if#1:for#1:write_mem(rawdns_lines:rsc(9)(0).@)#9}
directive set /isp_rawdns/core/pixel_loop:if#1:for:read_mem(rawdns_lines:rsc(9)(0).@)#8 -IGNORE_DEPENDENCY_FROM {pixel_loop:if#1:for#1:write_mem(rawdns_lines:rsc(0)(0).@) pixel_loop:if#1:for#1:write_mem(rawdns_lines:rsc(1)(0).@)#1 pixel_loop:if#1:for#1:write_mem(rawdns_lines:rsc(2)(0).@)#2 pixel_loop:if#1:for#1:write_mem(rawdns_lines:rsc(3)(0).@)#3 pixel_loop:if#1:for#1:write_mem(rawdns_lines:rsc(4)(0).@)#4 pixel_loop:if#1:for#1:write_mem(rawdns_lines:rsc(5)(0).@)#5 pixel_loop:if#1:for#1:write_mem(rawdns_lines:rsc(6)(0).@)#6 pixel_loop:if#1:for#1:write_mem(rawdns_lines:rsc(7)(0).@)#7 pixel_loop:if#1:for#1:write_mem(rawdns_lines:rsc(8)(0).@)#8 pixel_loop:if#1:for#1:write_mem(rawdns_lines:rsc(9)(0).@)#9}
directive set /isp_rawdns/core/pixel_loop:if#1:for:read_mem(rawdns_lines:rsc(0)(0).@)#9 -IGNORE_DEPENDENCY_FROM {pixel_loop:if#1:for#1:write_mem(rawdns_lines:rsc(0)(0).@) pixel_loop:if#1:for#1:write_mem(rawdns_lines:rsc(1)(0).@)#1 pixel_loop:if#1:for#1:write_mem(rawdns_lines:rsc(2)(0).@)#2 pixel_loop:if#1:for#1:write_mem(rawdns_lines:rsc(3)(0).@)#3 pixel_loop:if#1:for#1:write_mem(rawdns_lines:rsc(4)(0).@)#4 pixel_loop:if#1:for#1:write_mem(rawdns_lines:rsc(5)(0).@)#5 pixel_loop:if#1:for#1:write_mem(rawdns_lines:rsc(6)(0).@)#6 pixel_loop:if#1:for#1:write_mem(rawdns_lines:rsc(7)(0).@)#7 pixel_loop:if#1:for#1:write_mem(rawdns_lines:rsc(8)(0).@)#8 pixel_loop:if#1:for#1:write_mem(rawdns_lines:rsc(9)(0).@)#9}
directive set /isp_rawdns/core/padding_loop1:read_mem(rawdns_lines:rsc(3)(0).@) -IGNORE_DEPENDENCY_FROM {pixel_loop:if#1:for#1:write_mem(rawdns_lines:rsc(0)(0).@) pixel_loop:if#1:for#1:write_mem(rawdns_lines:rsc(1)(0).@)#1 pixel_loop:if#1:for#1:write_mem(rawdns_lines:rsc(2)(0).@)#2 pixel_loop:if#1:for#1:write_mem(rawdns_lines:rsc(3)(0).@)#3 pixel_loop:if#1:for#1:write_mem(rawdns_lines:rsc(4)(0).@)#4 pixel_loop:if#1:for#1:write_mem(rawdns_lines:rsc(5)(0).@)#5 pixel_loop:if#1:for#1:write_mem(rawdns_lines:rsc(6)(0).@)#6 pixel_loop:if#1:for#1:write_mem(rawdns_lines:rsc(7)(0).@)#7 pixel_loop:if#1:for#1:write_mem(rawdns_lines:rsc(8)(0).@)#8 pixel_loop:if#1:for#1:write_mem(rawdns_lines:rsc(9)(0).@)#9}
directive set /isp_rawdns/core/padding_loop1:read_mem(rawdns_lines:rsc(4)(0).@) -IGNORE_DEPENDENCY_FROM {pixel_loop:if#1:for#1:write_mem(rawdns_lines:rsc(0)(0).@) pixel_loop:if#1:for#1:write_mem(rawdns_lines:rsc(1)(0).@)#1 pixel_loop:if#1:for#1:write_mem(rawdns_lines:rsc(2)(0).@)#2 pixel_loop:if#1:for#1:write_mem(rawdns_lines:rsc(3)(0).@)#3 pixel_loop:if#1:for#1:write_mem(rawdns_lines:rsc(4)(0).@)#4 pixel_loop:if#1:for#1:write_mem(rawdns_lines:rsc(5)(0).@)#5 pixel_loop:if#1:for#1:write_mem(rawdns_lines:rsc(6)(0).@)#6 pixel_loop:if#1:for#1:write_mem(rawdns_lines:rsc(7)(0).@)#7 pixel_loop:if#1:for#1:write_mem(rawdns_lines:rsc(8)(0).@)#8 pixel_loop:if#1:for#1:write_mem(rawdns_lines:rsc(9)(0).@)#9}
directive set /isp_rawdns/core/loop2_inner_loop:read_mem(rawdns_lines:rsc(5)(0).@) -IGNORE_DEPENDENCY_FROM {pixel_loop:if#1:for#1:write_mem(rawdns_lines:rsc(0)(0).@) pixel_loop:if#1:for#1:write_mem(rawdns_lines:rsc(1)(0).@)#1 pixel_loop:if#1:for#1:write_mem(rawdns_lines:rsc(2)(0).@)#2 pixel_loop:if#1:for#1:write_mem(rawdns_lines:rsc(3)(0).@)#3 pixel_loop:if#1:for#1:write_mem(rawdns_lines:rsc(4)(0).@)#4 pixel_loop:if#1:for#1:write_mem(rawdns_lines:rsc(5)(0).@)#5 pixel_loop:if#1:for#1:write_mem(rawdns_lines:rsc(6)(0).@)#6 pixel_loop:if#1:for#1:write_mem(rawdns_lines:rsc(7)(0).@)#7 pixel_loop:if#1:for#1:write_mem(rawdns_lines:rsc(8)(0).@)#8 pixel_loop:if#1:for#1:write_mem(rawdns_lines:rsc(9)(0).@)#9}
directive set /isp_rawdns/core/loop2_inner_loop:read_mem(rawdns_lines:rsc(6)(0).@) -IGNORE_DEPENDENCY_FROM {pixel_loop:if#1:for#1:write_mem(rawdns_lines:rsc(0)(0).@) pixel_loop:if#1:for#1:write_mem(rawdns_lines:rsc(1)(0).@)#1 pixel_loop:if#1:for#1:write_mem(rawdns_lines:rsc(2)(0).@)#2 pixel_loop:if#1:for#1:write_mem(rawdns_lines:rsc(3)(0).@)#3 pixel_loop:if#1:for#1:write_mem(rawdns_lines:rsc(4)(0).@)#4 pixel_loop:if#1:for#1:write_mem(rawdns_lines:rsc(5)(0).@)#5 pixel_loop:if#1:for#1:write_mem(rawdns_lines:rsc(6)(0).@)#6 pixel_loop:if#1:for#1:write_mem(rawdns_lines:rsc(7)(0).@)#7 pixel_loop:if#1:for#1:write_mem(rawdns_lines:rsc(8)(0).@)#8 pixel_loop:if#1:for#1:write_mem(rawdns_lines:rsc(9)(0).@)#9}
directive set /isp_rawdns/core/loop2_inner_loop:read_mem(rawdns_lines:rsc(7)(0).@) -IGNORE_DEPENDENCY_FROM {pixel_loop:if#1:for#1:write_mem(rawdns_lines:rsc(0)(0).@) pixel_loop:if#1:for#1:write_mem(rawdns_lines:rsc(1)(0).@)#1 pixel_loop:if#1:for#1:write_mem(rawdns_lines:rsc(2)(0).@)#2 pixel_loop:if#1:for#1:write_mem(rawdns_lines:rsc(3)(0).@)#3 pixel_loop:if#1:for#1:write_mem(rawdns_lines:rsc(4)(0).@)#4 pixel_loop:if#1:for#1:write_mem(rawdns_lines:rsc(5)(0).@)#5 pixel_loop:if#1:for#1:write_mem(rawdns_lines:rsc(6)(0).@)#6 pixel_loop:if#1:for#1:write_mem(rawdns_lines:rsc(7)(0).@)#7 pixel_loop:if#1:for#1:write_mem(rawdns_lines:rsc(8)(0).@)#8 pixel_loop:if#1:for#1:write_mem(rawdns_lines:rsc(9)(0).@)#9}
directive set /isp_rawdns/core/loop2_inner_loop:read_mem(rawdns_lines:rsc(8)(0).@) -IGNORE_DEPENDENCY_FROM {pixel_loop:if#1:for#1:write_mem(rawdns_lines:rsc(0)(0).@) pixel_loop:if#1:for#1:write_mem(rawdns_lines:rsc(1)(0).@)#1 pixel_loop:if#1:for#1:write_mem(rawdns_lines:rsc(2)(0).@)#2 pixel_loop:if#1:for#1:write_mem(rawdns_lines:rsc(3)(0).@)#3 pixel_loop:if#1:for#1:write_mem(rawdns_lines:rsc(4)(0).@)#4 pixel_loop:if#1:for#1:write_mem(rawdns_lines:rsc(5)(0).@)#5 pixel_loop:if#1:for#1:write_mem(rawdns_lines:rsc(6)(0).@)#6 pixel_loop:if#1:for#1:write_mem(rawdns_lines:rsc(7)(0).@)#7 pixel_loop:if#1:for#1:write_mem(rawdns_lines:rsc(8)(0).@)#8 pixel_loop:if#1:for#1:write_mem(rawdns_lines:rsc(9)(0).@)#9}
directive set /isp_rawdns/core/loop2_inner_loop:read_mem(rawdns_lines:rsc(9)(0).@) -IGNORE_DEPENDENCY_FROM {pixel_loop:if#1:for#1:write_mem(rawdns_lines:rsc(0)(0).@) pixel_loop:if#1:for#1:write_mem(rawdns_lines:rsc(1)(0).@)#1 pixel_loop:if#1:for#1:write_mem(rawdns_lines:rsc(2)(0).@)#2 pixel_loop:if#1:for#1:write_mem(rawdns_lines:rsc(3)(0).@)#3 pixel_loop:if#1:for#1:write_mem(rawdns_lines:rsc(4)(0).@)#4 pixel_loop:if#1:for#1:write_mem(rawdns_lines:rsc(5)(0).@)#5 pixel_loop:if#1:for#1:write_mem(rawdns_lines:rsc(6)(0).@)#6 pixel_loop:if#1:for#1:write_mem(rawdns_lines:rsc(7)(0).@)#7 pixel_loop:if#1:for#1:write_mem(rawdns_lines:rsc(8)(0).@)#8 pixel_loop:if#1:for#1:write_mem(rawdns_lines:rsc(9)(0).@)#9}
go allocate
go extract
//  Catapult Prime Synthesis 2022.1/981271 (Production Release) Thu Feb 10 22:05:20 PST 2022
//
//          Copyright (c) Siemens EDA, 1996-2022, All Rights Reserved.
//                        UNPUBLISHED, LICENSED SOFTWARE.
//             CONFIDENTIAL AND PROPRIETARY INFORMATION WHICH IS THE
//                   PROPERTY OF SIEMENS EDA OR ITS LICENSORS.
//
//  Running on Linux wanwei.xiao@alish-rs-cs08.eng.t-head.cn 3.10.0-1160.66.1.el7.x86_64 x86_64 aol
//
//  Package information: SIFLIBS v25.1_0.0, HLS_PKGS v25.1_0.0,
//                       SIF_TOOLKITS v25.1_0.0, SIF_XILINX v25.1_0.0,
//                       SIF_ALTERA v25.1_0.0, CCS_LIBS v25.1_0.0,
//                       CDS_PPRO v10.6, CDS_DesigChecker v2022.1,
//                       CDS_OASYS v21.1_2.5, CDS_PSR v21.1_0.4,
//                       DesignPad v2.78_1.0
//
solution new -state initial
solution options defaults
solution options set /Input/CppStandard c++11
solution options set /Output/GenerateCycleNetlist false
solution options set /Flows/SCVerify/USE_QUESTASIM false
solution options set /Flows/SCVerify/USE_OSCI false
solution options set /Flows/SCVerify/USE_VCS true
solution options set /Flows/VCS/VG_ENV32_SCRIPT source_me_gcc483_32.csh
solution options set /Flows/VCS/VG_ENV64_SCRIPT source_me_gcc483_64.csh
solution options set /Flows/VCS/VLOGAN_OPTS {+v2k +no_tchk_msg -kdb -lca}
solution options set /Flows/VCS/VCSELAB_OPTS {-debug_acc+all -debug_region+cell+encrypt -timescale=1ps/1ps -sysc=blocksync -sysc=2.3.1 -sysc=slow_sc_main}
solution options set /Flows/VCS/SYSC_VERSION 2.3.1
flow package require /SCVerify
solution file add ../src/wbc.h -type CHEADER -exclude true
solution file add ../src/wbc.cpp -type C++
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
directive set -IDLE_SIGNAL {}
directive set -STALL_FLAG_SV off
directive set -STALL_FLAG false
directive set -TRANSACTION_DONE_SIGNAL true
directive set -DONE_FLAG {}
directive set -READY_FLAG {}
directive set -START_FLAG {}
directive set -TRANSACTION_SYNC ready
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
directive set -PROTOTYPING_ENGINE oasys
directive set -PIPELINE_RAMP_UP true
go new
solution design set wbc -top
solution design set ac::fx_div<8> -block
go analyze
go compile
solution library add nangate-45nm_beh -- -rtlsyntool DesignCompiler -vendor Nangate -technology 045nm
solution library add ccs_sample_mem
go libraries
solution design set wbc -top
solution design set ac::fx_div<8> -block
directive set -CLOCKS {clk {-CLOCK_PERIOD 3.33 -CLOCK_EDGE rising -CLOCK_UNCERTAINTY 0.0 -CLOCK_HIGH_TIME 1.665 -RESET_SYNC_NAME rst -RESET_ASYNC_NAME arst_n -RESET_KIND sync -RESET_SYNC_ACTIVE high -RESET_ASYNC_ACTIVE low -ENABLE_ACTIVE high}}
go assembly
directive set /wbc/top_reg.frameWidth:rsc -MAP_TO_MODULE {[DirectInput]}
directive set /wbc/top_reg.frameHeight:rsc -MAP_TO_MODULE {[DirectInput]}
directive set /wbc/top_reg.inputFormat:rsc -MAP_TO_MODULE {[DirectInput]}
directive set /wbc/top_reg.imgPattern:rsc -MAP_TO_MODULE {[DirectInput]}
directive set /wbc/top_reg.pipeMode:rsc -MAP_TO_MODULE {[DirectInput]}
directive set /wbc/top_reg.blc:rsc -MAP_TO_MODULE {[DirectInput]}
directive set /wbc/top_reg.shadowEb:rsc -MAP_TO_MODULE {[DirectInput]}
directive set /wbc/top_reg.binningFrameWidth:rsc -MAP_TO_MODULE {[DirectInput]}
directive set /wbc/top_reg.binningFrameHeight:rsc -MAP_TO_MODULE {[DirectInput]}
directive set /wbc/top_reg.scalerFrameWidth:rsc -MAP_TO_MODULE {[DirectInput]}
directive set /wbc/top_reg.scalerFrameHeight:rsc -MAP_TO_MODULE {[DirectInput]}
directive set /wbc/wbc_reg.m_nEb:rsc -MAP_TO_MODULE {[DirectInput]}
directive set /wbc/wbc_reg.m_nR:rsc -MAP_TO_MODULE {[DirectInput]}
directive set /wbc/wbc_reg.m_nGr:rsc -MAP_TO_MODULE {[DirectInput]}
directive set /wbc/wbc_reg.m_nGb:rsc -MAP_TO_MODULE {[DirectInput]}
directive set /wbc/wbc_reg.m_nB:rsc -MAP_TO_MODULE {[DirectInput]}
directive set /wbc/core/main -PIPELINE_INIT_INTERVAL 1
go architect
go extract
//  Catapult Prime Synthesis 2022.1/981271 (Production Release) Thu Feb 10 22:05:20 PST 2022
//
//          Copyright (c) Siemens EDA, 1996-2022, All Rights Reserved.
//                        UNPUBLISHED, LICENSED SOFTWARE.
//             CONFIDENTIAL AND PROPRIETARY INFORMATION WHICH IS THE
//                   PROPERTY OF SIEMENS EDA OR ITS LICENSORS.
//
//  Running on Linux wanwei.xiao@alish-rs-cs08.eng.t-head.cn 3.10.0-1160.66.1.el7.x86_64 x86_64 aol
//
//  Package information: SIFLIBS v25.1_0.0, HLS_PKGS v25.1_0.0,
//                       SIF_TOOLKITS v25.1_0.0, SIF_XILINX v25.1_0.0,
//                       SIF_ALTERA v25.1_0.0, CCS_LIBS v25.1_0.0,
//                       CDS_PPRO v10.6, CDS_DesigChecker v2022.1,
//                       CDS_OASYS v21.1_2.5, CDS_PSR v21.1_0.4,
//                       DesignPad v2.78_1.0
//
solution new -state initial
solution options defaults
solution options set /Input/CppStandard c++11
solution options set /Output/GenerateCycleNetlist false
solution options set /Flows/SCVerify/USE_QUESTASIM false
solution options set /Flows/SCVerify/USE_OSCI false
solution options set /Flows/SCVerify/USE_VCS true
solution options set /Flows/VCS/VG_ENV32_SCRIPT source_me_gcc483_32.csh
solution options set /Flows/VCS/VG_ENV64_SCRIPT source_me_gcc483_64.csh
solution options set /Flows/VCS/VLOGAN_OPTS {+v2k +no_tchk_msg -kdb -lca}
solution options set /Flows/VCS/VCSELAB_OPTS {-debug_acc+all -debug_region+cell+encrypt -timescale=1ps/1ps -sysc=blocksync -sysc=2.3.1 -sysc=slow_sc_main}
solution options set /Flows/VCS/SYSC_VERSION 2.3.1
flow package require /SCVerify
solution file add ../src/gb.h -type CHEADER -exclude true
solution file add ../src/gb.cpp -type C++
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
directive set -IDLE_SIGNAL {}
directive set -STALL_FLAG_SV off
directive set -STALL_FLAG false
directive set -TRANSACTION_DONE_SIGNAL true
directive set -DONE_FLAG {}
directive set -READY_FLAG {}
directive set -START_FLAG {}
directive set -TRANSACTION_SYNC ready
directive set -RESET_CLEARS_ALL_REGS use_library
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
directive set -PROTOTYPING_ENGINE oasys
directive set -PIPELINE_RAMP_UP true
go new
solution design set greenbalance2 -top
solution design set ac::fx_div<8> -block
go analyze
go compile
solution library add nangate-45nm_beh -- -rtlsyntool DesignCompiler -vendor Nangate -technology 045nm
solution library add ccs_sample_mem
go libraries
directive set -CLOCKS {clk {-CLOCK_PERIOD 3.33 -CLOCK_EDGE rising -CLOCK_UNCERTAINTY 0.0 -CLOCK_HIGH_TIME 1.665 -RESET_SYNC_NAME rst -RESET_ASYNC_NAME arst_n -RESET_KIND sync -RESET_SYNC_ACTIVE high -RESET_ASYNC_ACTIVE low -ENABLE_ACTIVE high}}
directive set -CLOCK_OVERHEAD 0.000000
go assembly
directive set /greenbalance2/top_reg.frameWidth:rsc -MAP_TO_MODULE {[DirectInput]}
directive set /greenbalance2/top_reg.frameHeight:rsc -MAP_TO_MODULE {[DirectInput]}
directive set /greenbalance2/top_reg.inputFormat:rsc -MAP_TO_MODULE {[DirectInput]}
directive set /greenbalance2/top_reg.imgPattern:rsc -MAP_TO_MODULE {[DirectInput]}
directive set /greenbalance2/top_reg.pipeMode:rsc -MAP_TO_MODULE {[DirectInput]}
directive set /greenbalance2/top_reg.blc:rsc -MAP_TO_MODULE {[DirectInput]}
directive set /greenbalance2/top_reg.shadowEb:rsc -MAP_TO_MODULE {[DirectInput]}
directive set /greenbalance2/top_reg.binningFrameWidth:rsc -MAP_TO_MODULE {[DirectInput]}
directive set /greenbalance2/top_reg.binningFrameHeight:rsc -MAP_TO_MODULE {[DirectInput]}
directive set /greenbalance2/top_reg.scalerFrameWidth:rsc -MAP_TO_MODULE {[DirectInput]}
directive set /greenbalance2/top_reg.scalerFrameHeight:rsc -MAP_TO_MODULE {[DirectInput]}
directive set /greenbalance2/gb_reg.eb:rsc -MAP_TO_MODULE {[DirectInput]}
directive set /greenbalance2/gb_reg.win_size:rsc -MAP_TO_MODULE {[DirectInput]}
directive set /greenbalance2/gb_reg.Lbound:rsc -MAP_TO_MODULE {[DirectInput]}
directive set /greenbalance2/gb_reg.Hbound:rsc -MAP_TO_MODULE {[DirectInput]}
directive set /greenbalance2/gb_reg.threhold:rsc -MAP_TO_MODULE {[DirectInput]}
directive set /greenbalance2/core/gb_lines:rsc -BLOCK_SIZE 8192
directive set /greenbalance2/core/gb_block:rsc -MAP_TO_MODULE {[Register]}
directive set /greenbalance2/core/main -PIPELINE_INIT_INTERVAL 1
directive set /greenbalance2/core/main -PIPELINE_STALL_MODE flush
directive set /greenbalance2/core/out_window_loop -UNROLL yes
directive set /greenbalance2/core/in_window_loop -UNROLL yes
directive set /greenbalance2/core/line_feed_loop -UNROLL yes
directive set /greenbalance2/core/lines_write_loop -UNROLL yes
directive set /greenbalance2/core/block_loop1 -UNROLL yes
directive set /greenbalance2/core/block_loop2 -UNROLL yes
directive set /greenbalance2/core/begin_end_loop -UNROLL yes
directive set /greenbalance2/core/sawtooth_loop_1 -UNROLL yes
directive set /greenbalance2/core/sawtooth_loop_2 -UNROLL yes
directive set /greenbalance2/core/sawtooth2_loop_1 -UNROLL yes
directive set /greenbalance2/core/sawtooth2_loop_2 -UNROLL yes
go architect
directive set /greenbalance2/core/line_feed_loop:read_mem(gb_lines:rsc(0)(0).@) -IGNORE_DEPENDENCY_FROM {lines_write_loop:write_mem(gb_lines:rsc(0)(0).@) lines_write_loop:write_mem(gb_lines:rsc(1)(0).@)#1 lines_write_loop:write_mem(gb_lines:rsc(2)(0).@)#2 lines_write_loop:write_mem(gb_lines:rsc(3)(0).@)#3 lines_write_loop:write_mem(gb_lines:rsc(4)(0).@)#4 lines_write_loop:write_mem(gb_lines:rsc(5)(0).@)#5}
directive set /greenbalance2/core/line_feed_loop:read_mem(gb_lines:rsc(1)(0).@)#1 -IGNORE_DEPENDENCY_FROM {lines_write_loop:write_mem(gb_lines:rsc(0)(0).@) lines_write_loop:write_mem(gb_lines:rsc(1)(0).@)#1 lines_write_loop:write_mem(gb_lines:rsc(2)(0).@)#2 lines_write_loop:write_mem(gb_lines:rsc(3)(0).@)#3 lines_write_loop:write_mem(gb_lines:rsc(4)(0).@)#4 lines_write_loop:write_mem(gb_lines:rsc(5)(0).@)#5}
directive set /greenbalance2/core/line_feed_loop:read_mem(gb_lines:rsc(2)(0).@)#2 -IGNORE_DEPENDENCY_FROM {lines_write_loop:write_mem(gb_lines:rsc(0)(0).@) lines_write_loop:write_mem(gb_lines:rsc(1)(0).@)#1 lines_write_loop:write_mem(gb_lines:rsc(2)(0).@)#2 lines_write_loop:write_mem(gb_lines:rsc(3)(0).@)#3 lines_write_loop:write_mem(gb_lines:rsc(4)(0).@)#4 lines_write_loop:write_mem(gb_lines:rsc(5)(0).@)#5}
directive set /greenbalance2/core/line_feed_loop:read_mem(gb_lines:rsc(3)(0).@)#3 -IGNORE_DEPENDENCY_FROM {lines_write_loop:write_mem(gb_lines:rsc(0)(0).@) lines_write_loop:write_mem(gb_lines:rsc(1)(0).@)#1 lines_write_loop:write_mem(gb_lines:rsc(2)(0).@)#2 lines_write_loop:write_mem(gb_lines:rsc(3)(0).@)#3 lines_write_loop:write_mem(gb_lines:rsc(4)(0).@)#4 lines_write_loop:write_mem(gb_lines:rsc(5)(0).@)#5}
directive set /greenbalance2/core/line_feed_loop:read_mem(gb_lines:rsc(4)(0).@)#4 -IGNORE_DEPENDENCY_FROM {lines_write_loop:write_mem(gb_lines:rsc(0)(0).@) lines_write_loop:write_mem(gb_lines:rsc(1)(0).@)#1 lines_write_loop:write_mem(gb_lines:rsc(2)(0).@)#2 lines_write_loop:write_mem(gb_lines:rsc(3)(0).@)#3 lines_write_loop:write_mem(gb_lines:rsc(4)(0).@)#4 lines_write_loop:write_mem(gb_lines:rsc(5)(0).@)#5}
directive set /greenbalance2/core/line_feed_loop:read_mem(gb_lines:rsc(5)(0).@)#5 -IGNORE_DEPENDENCY_FROM {lines_write_loop:write_mem(gb_lines:rsc(0)(0).@) lines_write_loop:write_mem(gb_lines:rsc(1)(0).@)#1 lines_write_loop:write_mem(gb_lines:rsc(2)(0).@)#2 lines_write_loop:write_mem(gb_lines:rsc(3)(0).@)#3 lines_write_loop:write_mem(gb_lines:rsc(4)(0).@)#4 lines_write_loop:write_mem(gb_lines:rsc(5)(0).@)#5}
directive set /greenbalance2/core/padding_inter_loop:read_mem(gb_lines:rsc(3)(0).@) -IGNORE_DEPENDENCY_FROM {lines_write_loop:write_mem(gb_lines:rsc(0)(0).@) lines_write_loop:write_mem(gb_lines:rsc(1)(0).@)#1 lines_write_loop:write_mem(gb_lines:rsc(2)(0).@)#2 lines_write_loop:write_mem(gb_lines:rsc(3)(0).@)#3 lines_write_loop:write_mem(gb_lines:rsc(4)(0).@)#4 lines_write_loop:write_mem(gb_lines:rsc(5)(0).@)#5}
directive set /greenbalance2/core/padding_inter_loop:read_mem(gb_lines:rsc(4)(0).@) -IGNORE_DEPENDENCY_FROM {lines_write_loop:write_mem(gb_lines:rsc(0)(0).@) lines_write_loop:write_mem(gb_lines:rsc(1)(0).@)#1 lines_write_loop:write_mem(gb_lines:rsc(2)(0).@)#2 lines_write_loop:write_mem(gb_lines:rsc(3)(0).@)#3 lines_write_loop:write_mem(gb_lines:rsc(4)(0).@)#4 lines_write_loop:write_mem(gb_lines:rsc(5)(0).@)#5}
directive set /greenbalance2/core/padding_inter_loop:read_mem(gb_lines:rsc(5)(0).@) -IGNORE_DEPENDENCY_FROM {lines_write_loop:write_mem(gb_lines:rsc(0)(0).@) lines_write_loop:write_mem(gb_lines:rsc(1)(0).@)#1 lines_write_loop:write_mem(gb_lines:rsc(2)(0).@)#2 lines_write_loop:write_mem(gb_lines:rsc(3)(0).@)#3 lines_write_loop:write_mem(gb_lines:rsc(4)(0).@)#4 lines_write_loop:write_mem(gb_lines:rsc(5)(0).@)#5}
go allocate
go extract
//  Catapult Prime Synthesis 2022.1/981271 (Production Release) Thu Feb 10 22:05:20 PST 2022
//
//          Copyright (c) Siemens EDA, 1996-2022, All Rights Reserved.
//                        UNPUBLISHED, LICENSED SOFTWARE.
//             CONFIDENTIAL AND PROPRIETARY INFORMATION WHICH IS THE
//                   PROPERTY OF SIEMENS EDA OR ITS LICENSORS.
//
//  Running on Linux wanwei.xiao@alish-rs-cs08.eng.t-head.cn 3.10.0-1160.66.1.el7.x86_64 x86_64 aol
//
//  Package information: SIFLIBS v25.1_0.0, HLS_PKGS v25.1_0.0,
//                       SIF_TOOLKITS v25.1_0.0, SIF_XILINX v25.1_0.0,
//                       SIF_ALTERA v25.1_0.0, CCS_LIBS v25.1_0.0,
//                       CDS_PPRO v10.6, CDS_DesigChecker v2022.1,
//                       CDS_OASYS v21.1_2.5, CDS_PSR v21.1_0.4,
//                       DesignPad v2.78_1.0
//
solution new -state initial
solution options defaults
solution options set /Input/CppStandard c++11
solution options set /Flows/SCVerify/USE_QUESTASIM false
solution options set /Flows/SCVerify/USE_OSCI false
solution options set /Flows/SCVerify/USE_VCS true
solution options set /Flows/VCS/VG_ENV32_SCRIPT source_me_gcc483_32.csh
solution options set /Flows/VCS/VG_ENV64_SCRIPT source_me_gcc483_64.csh
solution options set /Flows/VCS/VLOGAN_OPTS {+v2k +no_tchk_msg -kdb -lca}
solution options set /Flows/VCS/VCSELAB_OPTS {-debug_acc+all -debug_region+cell+encrypt -timescale=1ps/1ps -sysc=blocksync -sysc=2.3.1 -sysc=slow_sc_main}
solution options set /Flows/VCS/SYSC_VERSION 2.3.1
flow package require /SCVerify
solution file add ../src/demosaic.h -type CHEADER -exclude true
solution file add ../src/demosaic.cpp -type C++
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
directive set -IDLE_SIGNAL {}
directive set -STALL_FLAG_SV off
directive set -STALL_FLAG false
directive set -TRANSACTION_DONE_SIGNAL true
directive set -DONE_FLAG {}
directive set -READY_FLAG {}
directive set -START_FLAG {}
directive set -TRANSACTION_SYNC ready
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
directive set -PROTOTYPING_ENGINE oasys
directive set -PIPELINE_RAMP_UP true
go new
solution design set demosaic -top
solution design set ac::fx_div<8> -block
go compile
solution library add nangate-45nm_beh -- -rtlsyntool DesignCompiler -vendor Nangate -technology 045nm
solution library add ccs_sample_mem
go libraries
directive set -CLOCKS {clk {-CLOCK_PERIOD 3.33 -CLOCK_EDGE rising -CLOCK_UNCERTAINTY 0.0 -CLOCK_HIGH_TIME 1.665 -RESET_SYNC_NAME rst -RESET_ASYNC_NAME arst_n -RESET_KIND sync -RESET_SYNC_ACTIVE high -RESET_ASYNC_ACTIVE low -ENABLE_ACTIVE high}}
go assembly
directive set /demosaic/top_reg.frameWidth:rsc -MAP_TO_MODULE {[DirectInput]}
directive set /demosaic/top_reg.frameHeight:rsc -MAP_TO_MODULE {[DirectInput]}
directive set /demosaic/top_reg.inputFormat:rsc -MAP_TO_MODULE {[DirectInput]}
directive set /demosaic/top_reg.imgPattern:rsc -MAP_TO_MODULE {[DirectInput]}
directive set /demosaic/top_reg.pipeMode:rsc -MAP_TO_MODULE {[DirectInput]}
directive set /demosaic/top_reg.blc:rsc -MAP_TO_MODULE {[DirectInput]}
directive set /demosaic/top_reg.shadowEb:rsc -MAP_TO_MODULE {[DirectInput]}
directive set /demosaic/top_reg.binningFrameWidth:rsc -MAP_TO_MODULE {[DirectInput]}
directive set /demosaic/top_reg.binningFrameHeight:rsc -MAP_TO_MODULE {[DirectInput]}
directive set /demosaic/top_reg.scalerFrameWidth:rsc -MAP_TO_MODULE {[DirectInput]}
directive set /demosaic/top_reg.scalerFrameHeight:rsc -MAP_TO_MODULE {[DirectInput]}
directive set /demosaic/demosaic_reg.eb:rsc -MAP_TO_MODULE {[DirectInput]}
directive set /demosaic/core/lineBuf:rsc -BLOCK_SIZE 8192
directive set /demosaic/core/main -PIPELINE_INIT_INTERVAL 1
directive set /demosaic/core/window_loop -UNROLL yes
directive set /demosaic/core/raw_read -UNROLL yes
directive set /demosaic/core/line_write -UNROLL yes
go architect
directive set /demosaic/core/raw_read:read_mem(lineBuf:rsc(1)(0).@) -IGNORE_DEPENDENCY_FROM {line_write:write_mem(lineBuf:rsc(0)(0).@) line_write:write_mem(lineBuf:rsc(1)(0).@)#1 line_write:write_mem(lineBuf:rsc(2)(0).@)#2 line_write:write_mem(lineBuf:rsc(3)(0).@)#3}
directive set /demosaic/core/raw_read:read_mem(lineBuf:rsc(2)(0).@)#1 -IGNORE_DEPENDENCY_FROM {line_write:write_mem(lineBuf:rsc(0)(0).@) line_write:write_mem(lineBuf:rsc(1)(0).@)#1 line_write:write_mem(lineBuf:rsc(2)(0).@)#2 line_write:write_mem(lineBuf:rsc(3)(0).@)#3}
directive set /demosaic/core/raw_read:read_mem(lineBuf:rsc(3)(0).@)#2 -IGNORE_DEPENDENCY_FROM {line_write:write_mem(lineBuf:rsc(0)(0).@) line_write:write_mem(lineBuf:rsc(1)(0).@)#1 line_write:write_mem(lineBuf:rsc(2)(0).@)#2 line_write:write_mem(lineBuf:rsc(3)(0).@)#3}
directive set /demosaic/core/raw_read:read_mem(lineBuf:rsc(0)(0).@)#3 -IGNORE_DEPENDENCY_FROM {line_write:write_mem(lineBuf:rsc(0)(0).@) line_write:write_mem(lineBuf:rsc(1)(0).@)#1 line_write:write_mem(lineBuf:rsc(2)(0).@)#2 line_write:write_mem(lineBuf:rsc(3)(0).@)#3}
go allocate
go extract
//  Catapult Prime Synthesis 2022.1/981271 (Production Release) Thu Feb 10 22:05:20 PST 2022
//
//          Copyright (c) Siemens EDA, 1996-2022, All Rights Reserved.
//                        UNPUBLISHED, LICENSED SOFTWARE.
//             CONFIDENTIAL AND PROPRIETARY INFORMATION WHICH IS THE
//                   PROPERTY OF SIEMENS EDA OR ITS LICENSORS.
//
//  Running on Linux wanwei.xiao@alish-rs-cs08.eng.t-head.cn 3.10.0-1160.66.1.el7.x86_64 x86_64 aol
//
//  Package information: SIFLIBS v25.1_0.0, HLS_PKGS v25.1_0.0,
//                       SIF_TOOLKITS v25.1_0.0, SIF_XILINX v25.1_0.0,
//                       SIF_ALTERA v25.1_0.0, CCS_LIBS v25.1_0.0,
//                       CDS_PPRO v10.6, CDS_DesigChecker v2022.1,
//                       CDS_OASYS v21.1_2.5, CDS_PSR v21.1_0.4,
//                       DesignPad v2.78_1.0
//
solution new -state initial
solution options defaults
solution options set /Input/CppStandard c++11
solution options set /Output/GenerateCycleNetlist false
solution options set /Flows/SCVerify/USE_QUESTASIM false
solution options set /Flows/SCVerify/USE_OSCI false
solution options set /Flows/SCVerify/USE_VCS true
solution options set /Flows/VCS/VG_ENV32_SCRIPT source_me_gcc483_32.csh
solution options set /Flows/VCS/VG_ENV64_SCRIPT source_me_gcc483_64.csh
solution options set /Flows/VCS/VLOGAN_OPTS {+v2k +no_tchk_msg -kdb -lca}
solution options set /Flows/VCS/VCSELAB_OPTS {-debug_acc+all -debug_region+cell+encrypt -timescale=1ps/1ps -sysc=blocksync -sysc=2.3.1 -sysc=slow_sc_main}
solution options set /Flows/VCS/SYSC_VERSION 2.3.1
flow package require /SCVerify
solution file add ../src/ee.h -type CHEADER -exclude true
solution file add ../src/ee.cpp -type C++
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
directive set -IDLE_SIGNAL {}
directive set -STALL_FLAG_SV off
directive set -STALL_FLAG false
directive set -TRANSACTION_DONE_SIGNAL true
directive set -DONE_FLAG {}
directive set -READY_FLAG {}
directive set -START_FLAG {}
directive set -TRANSACTION_SYNC ready
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
directive set -PROTOTYPING_ENGINE oasys
directive set -PIPELINE_RAMP_UP true
go new
solution design set edgeenhancement -top
solution design set ac::fx_div<8> -block
go compile
solution library add nangate-45nm_beh -- -rtlsyntool DesignCompiler -vendor Nangate -technology 045nm
solution library add ccs_sample_mem
go libraries
directive set -CLOCKS {clk {-CLOCK_PERIOD 3.0 -CLOCK_EDGE rising -CLOCK_UNCERTAINTY 0.0 -CLOCK_HIGH_TIME 1.5 -RESET_SYNC_NAME rst -RESET_ASYNC_NAME arst_n -RESET_KIND sync -RESET_SYNC_ACTIVE high -RESET_ASYNC_ACTIVE low -ENABLE_ACTIVE high}}
go assembly
directive set /edgeenhancement/isp_top.frameWidth:rsc -MAP_TO_MODULE {[DirectInput]}
directive set /edgeenhancement/isp_top.frameHeight:rsc -MAP_TO_MODULE {[DirectInput]}
directive set /edgeenhancement/isp_top.inputFormat:rsc -MAP_TO_MODULE {[DirectInput]}
directive set /edgeenhancement/isp_top.imgPattern:rsc -MAP_TO_MODULE {[DirectInput]}
directive set /edgeenhancement/isp_top.pipeMode:rsc -MAP_TO_MODULE {[DirectInput]}
directive set /edgeenhancement/isp_top.blc:rsc -MAP_TO_MODULE {[DirectInput]}
directive set /edgeenhancement/isp_top.shadowEb:rsc -MAP_TO_MODULE {[DirectInput]}
directive set /edgeenhancement/isp_top.binningFrameWidth:rsc -MAP_TO_MODULE {[DirectInput]}
directive set /edgeenhancement/isp_top.binningFrameHeight:rsc -MAP_TO_MODULE {[DirectInput]}
directive set /edgeenhancement/isp_top.scalerFrameWidth:rsc -MAP_TO_MODULE {[DirectInput]}
directive set /edgeenhancement/isp_top.scalerFrameHeight:rsc -MAP_TO_MODULE {[DirectInput]}
directive set /edgeenhancement/ee_top.eb:rsc -MAP_TO_MODULE {[DirectInput]}
directive set /edgeenhancement/ee_top.coeff:rsc -MAP_TO_MODULE {[DirectInput]}
directive set /edgeenhancement/eeprocess:guass_55.rom:rsc -MAP_TO_MODULE {[Register]}
directive set /edgeenhancement/core/main -PIPELINE_INIT_INTERVAL 1
directive set /edgeenhancement/core/single_loop -PIPELINE_INIT_INTERVAL 1
directive set /edgeenhancement/core/ee_lines:rsc -BLOCK_SIZE 8192
directive set /edgeenhancement/core/block_refresh_loop_out -UNROLL yes
directive set /edgeenhancement/core/block_refresh_loop_in -UNROLL yes
directive set /edgeenhancement/core/single_loop:for -UNROLL yes
directive set /edgeenhancement/core/single_loop:for#1 -UNROLL yes
directive set /edgeenhancement/core/eeprocess:for -UNROLL yes
directive set /edgeenhancement/core/eeprocess:for:for -UNROLL yes
directive set /edgeenhancement/core/eeprocess:for#1 -UNROLL yes
directive set /edgeenhancement/core/eeprocess:for#1:for -UNROLL yes
directive set /edgeenhancement/core/eeprocess:for#2 -UNROLL yes
directive set /edgeenhancement/core/eeprocess:for#3 -UNROLL yes
directive set /edgeenhancement/core/eeprocess:for#3:for -UNROLL yes
directive set /edgeenhancement/core/eeprocess:for#4 -UNROLL yes
directive set /edgeenhancement/core/eeprocess:for#5 -UNROLL yes
directive set /edgeenhancement/core/eeprocess:for#5:for -UNROLL yes
directive set /edgeenhancement/core/eeprocess:for#6 -UNROLL yes
go architect
directive set /edgeenhancement/core/single_loop:for:read_mem(ee_lines:rsc(1)(0).@) -IGNORE_DEPENDENCY_FROM {single_loop:for#1:write_mem(ee_lines:rsc(0)(0).@) single_loop:for#1:write_mem(ee_lines:rsc(1)(0).@)#1 single_loop:for#1:write_mem(ee_lines:rsc(2)(0).@)#2 single_loop:for#1:write_mem(ee_lines:rsc(3)(0).@)#3}
directive set /edgeenhancement/core/single_loop:for:read_mem(ee_lines:rsc(2)(0).@)#1 -IGNORE_DEPENDENCY_FROM {single_loop:for#1:write_mem(ee_lines:rsc(0)(0).@) single_loop:for#1:write_mem(ee_lines:rsc(1)(0).@)#1 single_loop:for#1:write_mem(ee_lines:rsc(2)(0).@)#2 single_loop:for#1:write_mem(ee_lines:rsc(3)(0).@)#3}
directive set /edgeenhancement/core/single_loop:for:read_mem(ee_lines:rsc(3)(0).@)#2 -IGNORE_DEPENDENCY_FROM {single_loop:for#1:write_mem(ee_lines:rsc(0)(0).@) single_loop:for#1:write_mem(ee_lines:rsc(1)(0).@)#1 single_loop:for#1:write_mem(ee_lines:rsc(2)(0).@)#2 single_loop:for#1:write_mem(ee_lines:rsc(3)(0).@)#3}
directive set /edgeenhancement/core/single_loop:for:read_mem(ee_lines:rsc(0)(0).@)#3 -IGNORE_DEPENDENCY_FROM {single_loop:for#1:write_mem(ee_lines:rsc(0)(0).@) single_loop:for#1:write_mem(ee_lines:rsc(1)(0).@)#1 single_loop:for#1:write_mem(ee_lines:rsc(2)(0).@)#2 single_loop:for#1:write_mem(ee_lines:rsc(3)(0).@)#3}
directive set /edgeenhancement/core/padding_loop_1:read_mem(ee_lines:rsc(0)(0).@) -IGNORE_DEPENDENCY_FROM {single_loop:for#1:write_mem(ee_lines:rsc(0)(0).@) single_loop:for#1:write_mem(ee_lines:rsc(1)(0).@)#1 single_loop:for#1:write_mem(ee_lines:rsc(2)(0).@)#2 single_loop:for#1:write_mem(ee_lines:rsc(3)(0).@)#3}
directive set /edgeenhancement/core/padding_loop_1:read_mem(ee_lines:rsc(1)(0).@) -IGNORE_DEPENDENCY_FROM {single_loop:for#1:write_mem(ee_lines:rsc(0)(0).@) single_loop:for#1:write_mem(ee_lines:rsc(1)(0).@)#1 single_loop:for#1:write_mem(ee_lines:rsc(2)(0).@)#2 single_loop:for#1:write_mem(ee_lines:rsc(3)(0).@)#3}
directive set /edgeenhancement/core/padding_loop_3:read_mem(ee_lines:rsc(2)(0).@) -IGNORE_DEPENDENCY_FROM {single_loop:for#1:write_mem(ee_lines:rsc(0)(0).@) single_loop:for#1:write_mem(ee_lines:rsc(1)(0).@)#1 single_loop:for#1:write_mem(ee_lines:rsc(2)(0).@)#2 single_loop:for#1:write_mem(ee_lines:rsc(3)(0).@)#3}
directive set /edgeenhancement/core/padding_loop_3:read_mem(ee_lines:rsc(3)(0).@) -IGNORE_DEPENDENCY_FROM {single_loop:for#1:write_mem(ee_lines:rsc(0)(0).@) single_loop:for#1:write_mem(ee_lines:rsc(1)(0).@)#1 single_loop:for#1:write_mem(ee_lines:rsc(2)(0).@)#2 single_loop:for#1:write_mem(ee_lines:rsc(3)(0).@)#3}
go allocate
go extract
//  Catapult Prime Synthesis 2022.1/981271 (Production Release) Thu Feb 10 22:05:20 PST 2022
//
//          Copyright (c) Siemens EDA, 1996-2022, All Rights Reserved.
//                        UNPUBLISHED, LICENSED SOFTWARE.
//             CONFIDENTIAL AND PROPRIETARY INFORMATION WHICH IS THE
//                   PROPERTY OF SIEMENS EDA OR ITS LICENSORS.
//
//  Running on Linux wanwei.xiao@alish-rs-cs08.eng.t-head.cn 3.10.0-1160.66.1.el7.x86_64 x86_64 aol
//
//  Package information: SIFLIBS v25.1_0.0, HLS_PKGS v25.1_0.0,
//                       SIF_TOOLKITS v25.1_0.0, SIF_XILINX v25.1_0.0,
//                       SIF_ALTERA v25.1_0.0, CCS_LIBS v25.1_0.0,
//                       CDS_PPRO v10.6, CDS_DesigChecker v2022.1,
//                       CDS_OASYS v21.1_2.5, CDS_PSR v21.1_0.4,
//                       DesignPad v2.78_1.0
//
solution new -state initial
solution options defaults
solution options set /Input/CppStandard c++11
solution options set /Output/GenerateCycleNetlist false
solution options set /Flows/SCVerify/USE_QUESTASIM false
solution options set /Flows/SCVerify/USE_OSCI false
solution options set /Flows/SCVerify/USE_VCS true
solution options set /Flows/VCS/VG_ENV32_SCRIPT source_me_gcc483_32.csh
solution options set /Flows/VCS/VG_ENV64_SCRIPT source_me_gcc483_64.csh
solution options set /Flows/VCS/VLOGAN_OPTS {+v2k +no_tchk_msg -kdb -lca}
solution options set /Flows/VCS/VCSELAB_OPTS {-debug_acc+all -debug_region+cell+encrypt -timescale=1ps/1ps -sysc=blocksync -sysc=2.3.1 -sysc=slow_sc_main}
solution options set /Flows/VCS/SYSC_VERSION 2.3.1
flow package require /SCVerify
solution file add ../src/cmc.h -type CHEADER -exclude true
solution file add ../src/cmc.cpp -type C++
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
directive set -IDLE_SIGNAL {}
directive set -STALL_FLAG_SV off
directive set -STALL_FLAG false
directive set -TRANSACTION_DONE_SIGNAL true
directive set -DONE_FLAG {}
directive set -READY_FLAG {}
directive set -START_FLAG {}
directive set -TRANSACTION_SYNC ready
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
directive set -PROTOTYPING_ENGINE oasys
directive set -PIPELINE_RAMP_UP true
go new
solution design set cmc -top
solution design set ac::fx_div<8> -block
go analyze
go compile
solution library add nangate-45nm_beh -- -rtlsyntool DesignCompiler -vendor Nangate -technology 045nm
solution library add ccs_sample_mem
go libraries
directive set -CLOCKS {clk {-CLOCK_PERIOD 3.33 -CLOCK_EDGE rising -CLOCK_UNCERTAINTY 0.0 -CLOCK_HIGH_TIME 1.665 -RESET_SYNC_NAME rst -RESET_ASYNC_NAME arst_n -RESET_KIND sync -RESET_SYNC_ACTIVE high -RESET_ASYNC_ACTIVE low -ENABLE_ACTIVE high}}
go assembly
directive set /cmc/top_reg.frameWidth:rsc -MAP_TO_MODULE {[DirectInput]}
directive set /cmc/top_reg.frameHeight:rsc -MAP_TO_MODULE {[DirectInput]}
directive set /cmc/top_reg.inputFormat:rsc -MAP_TO_MODULE {[DirectInput]}
directive set /cmc/top_reg.imgPattern:rsc -MAP_TO_MODULE {[DirectInput]}
directive set /cmc/top_reg.pipeMode:rsc -MAP_TO_MODULE {[DirectInput]}
directive set /cmc/top_reg.blc:rsc -MAP_TO_MODULE {[DirectInput]}
directive set /cmc/top_reg.shadowEb:rsc -MAP_TO_MODULE {[DirectInput]}
directive set /cmc/top_reg.binningFrameWidth:rsc -MAP_TO_MODULE {[DirectInput]}
directive set /cmc/top_reg.binningFrameHeight:rsc -MAP_TO_MODULE {[DirectInput]}
directive set /cmc/top_reg.scalerFrameWidth:rsc -MAP_TO_MODULE {[DirectInput]}
directive set /cmc/top_reg.scalerFrameHeight:rsc -MAP_TO_MODULE {[DirectInput]}
directive set /cmc/cmc_reg.m_nEb:rsc -MAP_TO_MODULE {[DirectInput]}
directive set /cmc/cmc_reg.m_nGain:rsc -MAP_TO_MODULE {[DirectInput]}
directive set /cmc/cmc_reg.m_bCFCEnable:rsc -MAP_TO_MODULE {[DirectInput]}
directive set /cmc/cmc_reg.m_bDiscardH:rsc -MAP_TO_MODULE {[DirectInput]}
directive set /cmc/cmc_reg.m_pHueRange:rsc -MAP_TO_MODULE {[DirectInput]}
directive set /cmc/cmc_reg.m_nHueBandShift:rsc -MAP_TO_MODULE {[DirectInput]}
directive set /cmc/cmc_reg.m_nEdgeThre:rsc -MAP_TO_MODULE {[DirectInput]}
directive set /cmc/cmc_reg.m_nEdgeBandShift:rsc -MAP_TO_MODULE {[DirectInput]}
directive set /cmc/cmc_reg.m_nCFCStrength:rsc -MAP_TO_MODULE {[DirectInput]}
directive set /cmc/core/cmc_row -PIPELINE_INIT_INTERVAL 1
directive set /cmc/core/cmc_cal1 -UNROLL yes
directive set /cmc/core/cmc_cal2 -UNROLL yes
directive set /cmc/core/cmc_cal3 -UNROLL yes
directive set /cmc/core/main -PIPELINE_INIT_INTERVAL 1
go architect
go extract
//  Catapult Prime Synthesis 2022.1/981271 (Production Release) Thu Feb 10 22:05:20 PST 2022
//
//          Copyright (c) Siemens EDA, 1996-2022, All Rights Reserved.
//                        UNPUBLISHED, LICENSED SOFTWARE.
//             CONFIDENTIAL AND PROPRIETARY INFORMATION WHICH IS THE
//                   PROPERTY OF SIEMENS EDA OR ITS LICENSORS.
//
//  Running on Linux wanwei.xiao@alish-rs-cs08.eng.t-head.cn 3.10.0-1160.66.1.el7.x86_64 x86_64 aol
//
//  Package information: SIFLIBS v25.1_0.0, HLS_PKGS v25.1_0.0,
//                       SIF_TOOLKITS v25.1_0.0, SIF_XILINX v25.1_0.0,
//                       SIF_ALTERA v25.1_0.0, CCS_LIBS v25.1_0.0,
//                       CDS_PPRO v10.6, CDS_DesigChecker v2022.1,
//                       CDS_OASYS v21.1_2.5, CDS_PSR v21.1_0.4,
//                       DesignPad v2.78_1.0
//
solution new -state initial
solution options defaults
solution options set /Input/CppStandard c++11
solution options set /Flows/SCVerify/USE_QUESTASIM false
solution options set /Flows/SCVerify/USE_OSCI false
solution options set /Flows/SCVerify/USE_VCS true
solution options set /Flows/VCS/VG_ENV32_SCRIPT source_me_gcc483_32.csh
solution options set /Flows/VCS/VG_ENV64_SCRIPT source_me_gcc483_64.csh
solution options set /Flows/VCS/VLOGAN_OPTS {+v2k +no_tchk_msg -kdb -lca}
solution options set /Flows/VCS/VCSELAB_OPTS {-debug_acc+all -debug_region+cell+encrypt -timescale=1ps/1ps -sysc=blocksync -sysc=2.3.1 -sysc=slow_sc_main}
solution options set /Flows/VCS/SYSC_VERSION 2.3.1
flow package require /SCVerify
solution file add ../src/gtm.cpp -type C++
solution file add ../src/gtm.h -type CHEADER -exclude true
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
directive set -IDLE_SIGNAL {}
directive set -STALL_FLAG_SV off
directive set -STALL_FLAG false
directive set -TRANSACTION_DONE_SIGNAL true
directive set -DONE_FLAG {}
directive set -READY_FLAG {}
directive set -START_FLAG {}
directive set -TRANSACTION_SYNC ready
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
directive set -PROTOTYPING_ENGINE oasys
directive set -PIPELINE_RAMP_UP true
go new
solution design set gtm -top
solution design set ac::fx_div<8> -block
go analyze
go compile
solution library add nangate-45nm_beh -- -rtlsyntool DesignCompiler -vendor Nangate -technology 045nm
solution library add ccs_sample_mem
go libraries
directive set -CLOCKS {clk {-CLOCK_PERIOD 3.33 -CLOCK_EDGE rising -CLOCK_UNCERTAINTY 0.0 -CLOCK_HIGH_TIME 1.665 -RESET_SYNC_NAME rst -RESET_ASYNC_NAME arst_n -RESET_KIND sync -RESET_SYNC_ACTIVE high -RESET_ASYNC_ACTIVE low -ENABLE_ACTIVE high}}
go assembly
directive set /gtm/top_reg.frameWidth:rsc -MAP_TO_MODULE {[DirectInput]}
directive set /gtm/top_reg.frameHeight:rsc -MAP_TO_MODULE {[DirectInput]}
directive set /gtm/top_reg.inputFormat:rsc -MAP_TO_MODULE {[DirectInput]}
directive set /gtm/top_reg.imgPattern:rsc -MAP_TO_MODULE {[DirectInput]}
directive set /gtm/top_reg.pipeMode:rsc -MAP_TO_MODULE {[DirectInput]}
directive set /gtm/top_reg.blc:rsc -MAP_TO_MODULE {[DirectInput]}
directive set /gtm/top_reg.shadowEb:rsc -MAP_TO_MODULE {[DirectInput]}
directive set /gtm/top_reg.binningFrameWidth:rsc -MAP_TO_MODULE {[DirectInput]}
directive set /gtm/top_reg.binningFrameHeight:rsc -MAP_TO_MODULE {[DirectInput]}
directive set /gtm/top_reg.scalerFrameWidth:rsc -MAP_TO_MODULE {[DirectInput]}
directive set /gtm/top_reg.scalerFrameHeight:rsc -MAP_TO_MODULE {[DirectInput]}
directive set /gtm/gtm_reg.eb:rsc -MAP_TO_MODULE {[DirectInput]}
directive set /gtm/gtm_reg.m_bDitheringEnable:rsc -MAP_TO_MODULE {[DirectInput]}
directive set /gtm/gtm_reg.gtmTab_0:rsc -MAP_TO_MODULE ccs_sample_mem.ccs_ram_sync_dualport
directive set /gtm/gtm_reg.gtmTab_1:rsc -MAP_TO_MODULE ccs_sample_mem.ccs_ram_sync_dualport
directive set /gtm/gtm_reg.gtmTab_2:rsc -MAP_TO_MODULE ccs_sample_mem.ccs_ram_sync_dualport
directive set /gtm/core/main -PIPELINE_INIT_INTERVAL 1
go architect
go extract
//  Catapult Prime Synthesis 2022.1/981271 (Production Release) Thu Feb 10 22:05:20 PST 2022
//
//          Copyright (c) Siemens EDA, 1996-2022, All Rights Reserved.
//                        UNPUBLISHED, LICENSED SOFTWARE.
//             CONFIDENTIAL AND PROPRIETARY INFORMATION WHICH IS THE
//                   PROPERTY OF SIEMENS EDA OR ITS LICENSORS.
//
//  Running on Linux wanwei.xiao@alish-rs-cs08.eng.t-head.cn 3.10.0-1160.66.1.el7.x86_64 x86_64 aol
//
//  Package information: SIFLIBS v25.1_0.0, HLS_PKGS v25.1_0.0,
//                       SIF_TOOLKITS v25.1_0.0, SIF_XILINX v25.1_0.0,
//                       SIF_ALTERA v25.1_0.0, CCS_LIBS v25.1_0.0,
//                       CDS_PPRO v10.6, CDS_DesigChecker v2022.1,
//                       CDS_OASYS v21.1_2.5, CDS_PSR v21.1_0.4,
//                       DesignPad v2.78_1.0
//
solution new -state initial
solution options defaults
solution options set /Input/CppStandard c++11
solution options set /Output/GenerateCycleNetlist false
solution options set /Flows/SCVerify/USE_QUESTASIM false
solution options set /Flows/SCVerify/USE_OSCI false
solution options set /Flows/SCVerify/USE_VCS true
solution options set /Flows/VCS/VG_ENV32_SCRIPT source_me_gcc483_32.csh
solution options set /Flows/VCS/VG_ENV64_SCRIPT source_me_gcc483_64.csh
solution options set /Flows/VCS/VLOGAN_OPTS {+v2k +no_tchk_msg -kdb}
solution options set /Flows/VCS/VCSELAB_OPTS {-debug_acc+all -debug_region+cell+encrypt -timescale=1ps/1ps -sysc=2.3.1 -sysc=slow_sc_main}
solution options set /Flows/VCS/SYSC_VERSION 2.3.1
flow package require /SCVerify
solution file add ../src/lut.h -type CHEADER -exclude true
solution file add ../src/lut.cpp -type C++
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
directive set -IDLE_SIGNAL {}
directive set -STALL_FLAG_SV off
directive set -STALL_FLAG false
directive set -TRANSACTION_DONE_SIGNAL true
directive set -DONE_FLAG {}
directive set -READY_FLAG {}
directive set -START_FLAG {}
directive set -TRANSACTION_SYNC ready
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
directive set -PROTOTYPING_ENGINE oasys
directive set -PIPELINE_RAMP_UP true
go new
solution design set lut -top
solution design set ac::fx_div<8> -block
go analyze
go compile
solution library add nangate-45nm_beh -- -rtlsyntool DesignCompiler -vendor Nangate -technology 045nm
solution library add ccs_sample_mem
go libraries
directive set -CLOCKS {clk {-CLOCK_PERIOD 3.33 -CLOCK_EDGE rising -CLOCK_UNCERTAINTY 0.0 -CLOCK_HIGH_TIME 1.665 -RESET_SYNC_NAME rst -RESET_ASYNC_NAME arst_n -RESET_KIND sync -RESET_SYNC_ACTIVE high -RESET_ASYNC_ACTIVE low -ENABLE_ACTIVE high}}
go assembly
directive set /lut/top_reg.frameWidth:rsc -MAP_TO_MODULE {[DirectInput]}
directive set /lut/top_reg.frameHeight:rsc -MAP_TO_MODULE {[DirectInput]}
directive set /lut/top_reg.inputFormat:rsc -MAP_TO_MODULE {[DirectInput]}
directive set /lut/top_reg.imgPattern:rsc -MAP_TO_MODULE {[DirectInput]}
directive set /lut/top_reg.pipeMode:rsc -MAP_TO_MODULE {[DirectInput]}
directive set /lut/top_reg.blc:rsc -MAP_TO_MODULE {[DirectInput]}
directive set /lut/top_reg.shadowEb:rsc -MAP_TO_MODULE {[DirectInput]}
directive set /lut/top_reg.binningFrameWidth:rsc -MAP_TO_MODULE {[DirectInput]}
directive set /lut/top_reg.binningFrameHeight:rsc -MAP_TO_MODULE {[DirectInput]}
directive set /lut/top_reg.scalerFrameWidth:rsc -MAP_TO_MODULE {[DirectInput]}
directive set /lut/top_reg.scalerFrameHeight:rsc -MAP_TO_MODULE {[DirectInput]}
directive set /lut/lut_reg.eb:rsc -MAP_TO_MODULE {[DirectInput]}
directive set /lut/lut_reg.size:rsc -MAP_TO_MODULE {[DirectInput]}
directive set /lut/lut_reg.lines:rsc -MAP_TO_MODULE {[DirectInput]}
directive set /lut/core/main -PIPELINE_INIT_INTERVAL 1
go architect
go extract
//  Catapult Prime Synthesis 2022.1/981271 (Production Release) Thu Feb 10 22:05:20 PST 2022
//
//          Copyright (c) Siemens EDA, 1996-2022, All Rights Reserved.
//                        UNPUBLISHED, LICENSED SOFTWARE.
//             CONFIDENTIAL AND PROPRIETARY INFORMATION WHICH IS THE
//                   PROPERTY OF SIEMENS EDA OR ITS LICENSORS.
//
//  Running on Linux wanwei.xiao@alish-rs-cs08.eng.t-head.cn 3.10.0-1160.66.1.el7.x86_64 x86_64 aol
//
//  Package information: SIFLIBS v25.1_0.0, HLS_PKGS v25.1_0.0,
//                       SIF_TOOLKITS v25.1_0.0, SIF_XILINX v25.1_0.0,
//                       SIF_ALTERA v25.1_0.0, CCS_LIBS v25.1_0.0,
//                       CDS_PPRO v10.6, CDS_DesigChecker v2022.1,
//                       CDS_OASYS v21.1_2.5, CDS_PSR v21.1_0.4,
//                       DesignPad v2.78_1.0
//
solution new -state initial
solution options defaults
solution options set /Input/CppStandard c++11
solution options set /Output/GenerateCycleNetlist false
solution options set /Flows/SCVerify/USE_QUESTASIM false
solution options set /Flows/SCVerify/USE_OSCI false
solution options set /Flows/SCVerify/USE_VCS true
solution options set /Flows/VCS/VG_ENV32_SCRIPT source_me_gcc483_32.csh
solution options set /Flows/VCS/VG_ENV64_SCRIPT source_me_gcc483_64.csh
solution options set /Flows/VCS/VLOGAN_OPTS {+v2k +no_tchk_msg -kdb -lca}
solution options set /Flows/VCS/VCSELAB_OPTS {-debug_acc+all -debug_region+cell+encrypt -timescale=1ps/1ps -sysc=blocksync -sysc=2.3.1 -sysc=slow_sc_main}
solution options set /Flows/VCS/SYSC_VERSION 2.3.1
flow package require /SCVerify
solution file add ../src/ltm.h -type CHEADER -exclude true
solution file add ../src/ltm.cpp -type C++
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
directive set -IDLE_SIGNAL {}
directive set -STALL_FLAG_SV off
directive set -STALL_FLAG false
directive set -TRANSACTION_DONE_SIGNAL true
directive set -DONE_FLAG {}
directive set -READY_FLAG {}
directive set -START_FLAG {}
directive set -TRANSACTION_SYNC ready
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
directive set -PROTOTYPING_ENGINE oasys
directive set -PIPELINE_RAMP_UP true
go new
solution design set ltm -top
solution design set ac::fx_div<8> -block
go analyze
solution design set ltm -top
solution design set ac::fx_div<8> -block
solution design set bilaterS -top
solution design set ltm -inline
solution design set ltm -inline
go compile
solution design set ltm -top
solution design set ac::fx_div<8> -block
solution design set bilaterS -top
solution design set ltm -inline
solution design set ltm -inline
solution library add nangate-45nm_beh -- -rtlsyntool DesignCompiler -vendor Nangate -technology 045nm
go libraries
solution design set bilaterS -ccore
directive set -CLOCKS {clk {-CLOCK_PERIOD 3.33 -CLOCK_EDGE rising -CLOCK_UNCERTAINTY 0.0 -CLOCK_HIGH_TIME 1.665 -RESET_SYNC_NAME rst -RESET_ASYNC_NAME arst_n -RESET_KIND sync -RESET_SYNC_ACTIVE high -RESET_ASYNC_ACTIVE low -ENABLE_ACTIVE high}}
go assembly
directive set /bilaterS/core/biS_loop1 -PIPELINE_INIT_INTERVAL 0
directive set /bilaterS/core/biS_loop1 -UNROLL yes
directive set /bilaterS/core/biS_loop2 -PIPELINE_INIT_INTERVAL 0
directive set /bilaterS/core/biS_loop2 -UNROLL yes
directive set /bilaterS/core/biS_loop3 -PIPELINE_INIT_INTERVAL 0
directive set /bilaterS/core/biS_loop3 -UNROLL yes
directive set /bilaterS/core/biS_loop4 -PIPELINE_INIT_INTERVAL 0
directive set /bilaterS/core/biS_loop4 -UNROLL yes
directive set /bilaterS/core/ac_math::ac_div<32,19,32,19>:for -PIPELINE_INIT_INTERVAL 0
directive set /bilaterS/core/ac_math::ac_div<32,19,32,19>:for -UNROLL yes
directive set /bilaterS/core/ac_math::ac_div<32,32,14,32>:for -PIPELINE_INIT_INTERVAL 0
directive set /bilaterS/core/ac_math::ac_div<32,32,14,32>:for -UNROLL yes
directive set /bilaterS/core/ac_math::ac_div<32,32,14,32>#1:for -PIPELINE_INIT_INTERVAL 0
directive set /bilaterS/core/ac_math::ac_div<32,32,14,32>#1:for -UNROLL yes
directive set /bilaterS/core/ac_math::ac_div<32,32,14,32>#2:for -PIPELINE_INIT_INTERVAL 0
directive set /bilaterS/core/ac_math::ac_div<32,32,14,32>#2:for -UNROLL yes
go architect
go extract
//  Catapult Prime Synthesis 2022.1/981271 (Production Release) Thu Feb 10 22:05:20 PST 2022
//
//          Copyright (c) Siemens EDA, 1996-2022, All Rights Reserved.
//                        UNPUBLISHED, LICENSED SOFTWARE.
//             CONFIDENTIAL AND PROPRIETARY INFORMATION WHICH IS THE
//                   PROPERTY OF SIEMENS EDA OR ITS LICENSORS.
//
//  Running on Linux wanwei.xiao@alish-rs-cs08.eng.t-head.cn 3.10.0-1160.66.1.el7.x86_64 x86_64 aol
//
//  Package information: SIFLIBS v25.1_0.0, HLS_PKGS v25.1_0.0,
//                       SIF_TOOLKITS v25.1_0.0, SIF_XILINX v25.1_0.0,
//                       SIF_ALTERA v25.1_0.0, CCS_LIBS v25.1_0.0,
//                       CDS_PPRO v10.6, CDS_DesigChecker v2022.1,
//                       CDS_OASYS v21.1_2.5, CDS_PSR v21.1_0.4,
//                       DesignPad v2.78_1.0
//
solution new -state initial
solution options defaults
solution options set /Input/CppStandard c++11
solution options set /Output/GenerateCycleNetlist false
solution options set /Flows/SCVerify/USE_QUESTASIM false
solution options set /Flows/SCVerify/USE_OSCI false
solution options set /Flows/SCVerify/USE_VCS true
solution options set /Flows/VCS/VG_ENV32_SCRIPT source_me_gcc483_32.csh
solution options set /Flows/VCS/VG_ENV64_SCRIPT source_me_gcc483_64.csh
solution options set /Flows/VCS/VLOGAN_OPTS {+v2k +no_tchk_msg -kdb -lca}
solution options set /Flows/VCS/VCSELAB_OPTS {-debug_acc+all -debug_region+cell+encrypt -timescale=1ps/1ps -sysc=blocksync -sysc=2.3.1 -sysc=slow_sc_main}
solution options set /Flows/VCS/SYSC_VERSION 2.3.1
flow package require /SCVerify
solution file add ../src/ltm.h -type CHEADER -exclude true
solution file add ../src/ltm.cpp -type C++
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
directive set -IDLE_SIGNAL {}
directive set -STALL_FLAG_SV off
directive set -STALL_FLAG false
directive set -TRANSACTION_DONE_SIGNAL true
directive set -DONE_FLAG {}
directive set -READY_FLAG {}
directive set -START_FLAG {}
directive set -TRANSACTION_SYNC ready
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
directive set -PROTOTYPING_ENGINE oasys
directive set -PIPELINE_RAMP_UP true
go new
solution design set ltm -top
solution design set ac::fx_div<8> -block
go analyze
solution design set ltm -inline
solution design set ac::fx_div<8> -block
solution design set bilaterS -top -ccore
solution design set bilaterS -block
solution design set ltm -top
go compile
solution library add nangate-45nm_beh -- -rtlsyntool DesignCompiler -vendor Nangate -technology 045nm
solution library add ccs_sample_mem
go libraries
solution design set ltm -inline
solution design set ac::fx_div<8> -block
solution design set bilaterS -top -ccore
solution design set bilaterS -block
solution design set ltm -top
directive set -CLOCKS {clk {-CLOCK_PERIOD 3.33 -CLOCK_EDGE rising -CLOCK_UNCERTAINTY 0.0 -CLOCK_HIGH_TIME 1.665 -RESET_SYNC_NAME rst -RESET_ASYNC_NAME arst_n -RESET_KIND sync -RESET_SYNC_ACTIVE high -RESET_ASYNC_ACTIVE low -ENABLE_ACTIVE high}}
go assembly
directive set /ltm/top_reg.frameWidth:rsc -MAP_TO_MODULE {[DirectInput]}
directive set /ltm/top_reg.frameHeight:rsc -MAP_TO_MODULE {[DirectInput]}
directive set /ltm/top_reg.inputFormat:rsc -MAP_TO_MODULE {[DirectInput]}
directive set /ltm/top_reg.imgPattern:rsc -MAP_TO_MODULE {[DirectInput]}
directive set /ltm/top_reg.pipeMode:rsc -MAP_TO_MODULE {[DirectInput]}
directive set /ltm/top_reg.blc:rsc -MAP_TO_MODULE {[DirectInput]}
directive set /ltm/top_reg.shadowEb:rsc -MAP_TO_MODULE {[DirectInput]}
directive set /ltm/top_reg.binningFrameWidth:rsc -MAP_TO_MODULE {[DirectInput]}
directive set /ltm/top_reg.binningFrameHeight:rsc -MAP_TO_MODULE {[DirectInput]}
directive set /ltm/top_reg.scalerFrameWidth:rsc -MAP_TO_MODULE {[DirectInput]}
directive set /ltm/top_reg.scalerFrameHeight:rsc -MAP_TO_MODULE {[DirectInput]}
directive set /ltm/ltm_reg.m_nEb:rsc -MAP_TO_MODULE {[DirectInput]}
directive set /ltm/ltm_reg.contrast:rsc -MAP_TO_MODULE {[DirectInput]}
directive set /ltm/ltm_reg.ratio:rsc -MAP_TO_MODULE {[DirectInput]}
directive set /ltm/core/rWindow:rsc -MAP_TO_MODULE {[Register]}
directive set /ltm/core/gWindow:rsc -MAP_TO_MODULE {[Register]}
directive set /ltm/core/bWindow:rsc -MAP_TO_MODULE {[Register]}
directive set /ltm/core/rlineBuf:rsc -BLOCK_SIZE 8192
directive set /ltm/core/glineBuf:rsc -BLOCK_SIZE 8192
directive set /ltm/core/blineBuf:rsc -BLOCK_SIZE 8192
directive set /ltm/core/main -PIPELINE_INIT_INTERVAL 1
directive set /ltm/core/out_window_loop -UNROLL yes
directive set /ltm/core/in_window_loop -UNROLL yes
directive set /ltm/core/ltm_window_read -UNROLL yes
directive set /ltm/core/ltm_lines_read -UNROLL yes
go architect
directive set /ltm/core/ltm_window_read:read_mem(rlineBuf:rsc(1)(0).@) -IGNORE_DEPENDENCY_FROM {ltm_lines_read:write_mem(rlineBuf:rsc(0)(0).@) ltm_lines_read:write_mem(glineBuf:rsc(0)(0).@) ltm_lines_read:write_mem(blineBuf:rsc(0)(0).@) ltm_lines_read:write_mem(rlineBuf:rsc(1)(0).@)#1 ltm_lines_read:write_mem(glineBuf:rsc(1)(0).@)#1 ltm_lines_read:write_mem(blineBuf:rsc(1)(0).@)#1 ltm_lines_read:write_mem(rlineBuf:rsc(2)(0).@)#2 ltm_lines_read:write_mem(glineBuf:rsc(2)(0).@)#2 ltm_lines_read:write_mem(blineBuf:rsc(2)(0).@)#2 ltm_lines_read:write_mem(rlineBuf:rsc(3)(0).@)#3 ltm_lines_read:write_mem(glineBuf:rsc(3)(0).@)#3 ltm_lines_read:write_mem(blineBuf:rsc(3)(0).@)#3 ltm_lines_read:write_mem(rlineBuf:rsc(4)(0).@)#4 ltm_lines_read:write_mem(glineBuf:rsc(4)(0).@)#4 ltm_lines_read:write_mem(blineBuf:rsc(4)(0).@)#4 ltm_lines_read:write_mem(rlineBuf:rsc(5)(0).@)#5 ltm_lines_read:write_mem(glineBuf:rsc(5)(0).@)#5 ltm_lines_read:write_mem(blineBuf:rsc(5)(0).@)#5 ltm_lines_read:write_mem(rlineBuf:rsc(6)(0).@)#6 ltm_lines_read:write_mem(glineBuf:rsc(6)(0).@)#6 ltm_lines_read:write_mem(blineBuf:rsc(6)(0).@)#6 ltm_col:if:write_mem(rlineBuf:rsc(7)(0).@) ltm_col:if:write_mem(glineBuf:rsc(7)(0).@) ltm_col:if:write_mem(blineBuf:rsc(7)(0).@)}
directive set /ltm/core/ltm_window_read:read_mem(glineBuf:rsc(1)(0).@) -IGNORE_DEPENDENCY_FROM {ltm_lines_read:write_mem(rlineBuf:rsc(0)(0).@) ltm_lines_read:write_mem(glineBuf:rsc(0)(0).@) ltm_lines_read:write_mem(blineBuf:rsc(0)(0).@) ltm_lines_read:write_mem(rlineBuf:rsc(1)(0).@)#1 ltm_lines_read:write_mem(glineBuf:rsc(1)(0).@)#1 ltm_lines_read:write_mem(blineBuf:rsc(1)(0).@)#1 ltm_lines_read:write_mem(rlineBuf:rsc(2)(0).@)#2 ltm_lines_read:write_mem(glineBuf:rsc(2)(0).@)#2 ltm_lines_read:write_mem(blineBuf:rsc(2)(0).@)#2 ltm_lines_read:write_mem(rlineBuf:rsc(3)(0).@)#3 ltm_lines_read:write_mem(glineBuf:rsc(3)(0).@)#3 ltm_lines_read:write_mem(blineBuf:rsc(3)(0).@)#3 ltm_lines_read:write_mem(rlineBuf:rsc(4)(0).@)#4 ltm_lines_read:write_mem(glineBuf:rsc(4)(0).@)#4 ltm_lines_read:write_mem(blineBuf:rsc(4)(0).@)#4 ltm_lines_read:write_mem(rlineBuf:rsc(5)(0).@)#5 ltm_lines_read:write_mem(glineBuf:rsc(5)(0).@)#5 ltm_lines_read:write_mem(blineBuf:rsc(5)(0).@)#5 ltm_lines_read:write_mem(rlineBuf:rsc(6)(0).@)#6 ltm_lines_read:write_mem(glineBuf:rsc(6)(0).@)#6 ltm_lines_read:write_mem(blineBuf:rsc(6)(0).@)#6 ltm_col:if:write_mem(rlineBuf:rsc(7)(0).@) ltm_col:if:write_mem(glineBuf:rsc(7)(0).@) ltm_col:if:write_mem(blineBuf:rsc(7)(0).@)}
directive set /ltm/core/ltm_window_read:read_mem(blineBuf:rsc(1)(0).@) -IGNORE_DEPENDENCY_FROM {ltm_lines_read:write_mem(rlineBuf:rsc(0)(0).@) ltm_lines_read:write_mem(glineBuf:rsc(0)(0).@) ltm_lines_read:write_mem(blineBuf:rsc(0)(0).@) ltm_lines_read:write_mem(rlineBuf:rsc(1)(0).@)#1 ltm_lines_read:write_mem(glineBuf:rsc(1)(0).@)#1 ltm_lines_read:write_mem(blineBuf:rsc(1)(0).@)#1 ltm_lines_read:write_mem(rlineBuf:rsc(2)(0).@)#2 ltm_lines_read:write_mem(glineBuf:rsc(2)(0).@)#2 ltm_lines_read:write_mem(blineBuf:rsc(2)(0).@)#2 ltm_lines_read:write_mem(rlineBuf:rsc(3)(0).@)#3 ltm_lines_read:write_mem(glineBuf:rsc(3)(0).@)#3 ltm_lines_read:write_mem(blineBuf:rsc(3)(0).@)#3 ltm_lines_read:write_mem(rlineBuf:rsc(4)(0).@)#4 ltm_lines_read:write_mem(glineBuf:rsc(4)(0).@)#4 ltm_lines_read:write_mem(blineBuf:rsc(4)(0).@)#4 ltm_lines_read:write_mem(rlineBuf:rsc(5)(0).@)#5 ltm_lines_read:write_mem(glineBuf:rsc(5)(0).@)#5 ltm_lines_read:write_mem(blineBuf:rsc(5)(0).@)#5 ltm_lines_read:write_mem(rlineBuf:rsc(6)(0).@)#6 ltm_lines_read:write_mem(glineBuf:rsc(6)(0).@)#6 ltm_lines_read:write_mem(blineBuf:rsc(6)(0).@)#6 ltm_col:if:write_mem(rlineBuf:rsc(7)(0).@) ltm_col:if:write_mem(glineBuf:rsc(7)(0).@) ltm_col:if:write_mem(blineBuf:rsc(7)(0).@)}
directive set /ltm/core/ltm_window_read:read_mem(rlineBuf:rsc(2)(0).@)#1 -IGNORE_DEPENDENCY_FROM {ltm_lines_read:write_mem(rlineBuf:rsc(0)(0).@) ltm_lines_read:write_mem(glineBuf:rsc(0)(0).@) ltm_lines_read:write_mem(blineBuf:rsc(0)(0).@) ltm_lines_read:write_mem(rlineBuf:rsc(1)(0).@)#1 ltm_lines_read:write_mem(glineBuf:rsc(1)(0).@)#1 ltm_lines_read:write_mem(blineBuf:rsc(1)(0).@)#1 ltm_lines_read:write_mem(rlineBuf:rsc(2)(0).@)#2 ltm_lines_read:write_mem(glineBuf:rsc(2)(0).@)#2 ltm_lines_read:write_mem(blineBuf:rsc(2)(0).@)#2 ltm_lines_read:write_mem(rlineBuf:rsc(3)(0).@)#3 ltm_lines_read:write_mem(glineBuf:rsc(3)(0).@)#3 ltm_lines_read:write_mem(blineBuf:rsc(3)(0).@)#3 ltm_lines_read:write_mem(rlineBuf:rsc(4)(0).@)#4 ltm_lines_read:write_mem(glineBuf:rsc(4)(0).@)#4 ltm_lines_read:write_mem(blineBuf:rsc(4)(0).@)#4 ltm_lines_read:write_mem(rlineBuf:rsc(5)(0).@)#5 ltm_lines_read:write_mem(glineBuf:rsc(5)(0).@)#5 ltm_lines_read:write_mem(blineBuf:rsc(5)(0).@)#5 ltm_lines_read:write_mem(rlineBuf:rsc(6)(0).@)#6 ltm_lines_read:write_mem(glineBuf:rsc(6)(0).@)#6 ltm_lines_read:write_mem(blineBuf:rsc(6)(0).@)#6 ltm_col:if:write_mem(rlineBuf:rsc(7)(0).@) ltm_col:if:write_mem(glineBuf:rsc(7)(0).@) ltm_col:if:write_mem(blineBuf:rsc(7)(0).@)}
directive set /ltm/core/ltm_window_read:read_mem(glineBuf:rsc(2)(0).@)#1 -IGNORE_DEPENDENCY_FROM {ltm_lines_read:write_mem(rlineBuf:rsc(0)(0).@) ltm_lines_read:write_mem(glineBuf:rsc(0)(0).@) ltm_lines_read:write_mem(blineBuf:rsc(0)(0).@) ltm_lines_read:write_mem(rlineBuf:rsc(1)(0).@)#1 ltm_lines_read:write_mem(glineBuf:rsc(1)(0).@)#1 ltm_lines_read:write_mem(blineBuf:rsc(1)(0).@)#1 ltm_lines_read:write_mem(rlineBuf:rsc(2)(0).@)#2 ltm_lines_read:write_mem(glineBuf:rsc(2)(0).@)#2 ltm_lines_read:write_mem(blineBuf:rsc(2)(0).@)#2 ltm_lines_read:write_mem(rlineBuf:rsc(3)(0).@)#3 ltm_lines_read:write_mem(glineBuf:rsc(3)(0).@)#3 ltm_lines_read:write_mem(blineBuf:rsc(3)(0).@)#3 ltm_lines_read:write_mem(rlineBuf:rsc(4)(0).@)#4 ltm_lines_read:write_mem(glineBuf:rsc(4)(0).@)#4 ltm_lines_read:write_mem(blineBuf:rsc(4)(0).@)#4 ltm_lines_read:write_mem(rlineBuf:rsc(5)(0).@)#5 ltm_lines_read:write_mem(glineBuf:rsc(5)(0).@)#5 ltm_lines_read:write_mem(blineBuf:rsc(5)(0).@)#5 ltm_lines_read:write_mem(rlineBuf:rsc(6)(0).@)#6 ltm_lines_read:write_mem(glineBuf:rsc(6)(0).@)#6 ltm_lines_read:write_mem(blineBuf:rsc(6)(0).@)#6 ltm_col:if:write_mem(rlineBuf:rsc(7)(0).@) ltm_col:if:write_mem(glineBuf:rsc(7)(0).@) ltm_col:if:write_mem(blineBuf:rsc(7)(0).@)}
directive set /ltm/core/ltm_window_read:read_mem(blineBuf:rsc(2)(0).@)#1 -IGNORE_DEPENDENCY_FROM {ltm_lines_read:write_mem(rlineBuf:rsc(0)(0).@) ltm_lines_read:write_mem(glineBuf:rsc(0)(0).@) ltm_lines_read:write_mem(blineBuf:rsc(0)(0).@) ltm_lines_read:write_mem(rlineBuf:rsc(1)(0).@)#1 ltm_lines_read:write_mem(glineBuf:rsc(1)(0).@)#1 ltm_lines_read:write_mem(blineBuf:rsc(1)(0).@)#1 ltm_lines_read:write_mem(rlineBuf:rsc(2)(0).@)#2 ltm_lines_read:write_mem(glineBuf:rsc(2)(0).@)#2 ltm_lines_read:write_mem(blineBuf:rsc(2)(0).@)#2 ltm_lines_read:write_mem(rlineBuf:rsc(3)(0).@)#3 ltm_lines_read:write_mem(glineBuf:rsc(3)(0).@)#3 ltm_lines_read:write_mem(blineBuf:rsc(3)(0).@)#3 ltm_lines_read:write_mem(rlineBuf:rsc(4)(0).@)#4 ltm_lines_read:write_mem(glineBuf:rsc(4)(0).@)#4 ltm_lines_read:write_mem(blineBuf:rsc(4)(0).@)#4 ltm_lines_read:write_mem(rlineBuf:rsc(5)(0).@)#5 ltm_lines_read:write_mem(glineBuf:rsc(5)(0).@)#5 ltm_lines_read:write_mem(blineBuf:rsc(5)(0).@)#5 ltm_lines_read:write_mem(rlineBuf:rsc(6)(0).@)#6 ltm_lines_read:write_mem(glineBuf:rsc(6)(0).@)#6 ltm_lines_read:write_mem(blineBuf:rsc(6)(0).@)#6 ltm_col:if:write_mem(rlineBuf:rsc(7)(0).@) ltm_col:if:write_mem(glineBuf:rsc(7)(0).@) ltm_col:if:write_mem(blineBuf:rsc(7)(0).@)}
directive set /ltm/core/ltm_window_read:read_mem(rlineBuf:rsc(3)(0).@)#2 -IGNORE_DEPENDENCY_FROM {ltm_lines_read:write_mem(rlineBuf:rsc(0)(0).@) ltm_lines_read:write_mem(glineBuf:rsc(0)(0).@) ltm_lines_read:write_mem(blineBuf:rsc(0)(0).@) ltm_lines_read:write_mem(rlineBuf:rsc(1)(0).@)#1 ltm_lines_read:write_mem(glineBuf:rsc(1)(0).@)#1 ltm_lines_read:write_mem(blineBuf:rsc(1)(0).@)#1 ltm_lines_read:write_mem(rlineBuf:rsc(2)(0).@)#2 ltm_lines_read:write_mem(glineBuf:rsc(2)(0).@)#2 ltm_lines_read:write_mem(blineBuf:rsc(2)(0).@)#2 ltm_lines_read:write_mem(rlineBuf:rsc(3)(0).@)#3 ltm_lines_read:write_mem(glineBuf:rsc(3)(0).@)#3 ltm_lines_read:write_mem(blineBuf:rsc(3)(0).@)#3 ltm_lines_read:write_mem(rlineBuf:rsc(4)(0).@)#4 ltm_lines_read:write_mem(glineBuf:rsc(4)(0).@)#4 ltm_lines_read:write_mem(blineBuf:rsc(4)(0).@)#4 ltm_lines_read:write_mem(rlineBuf:rsc(5)(0).@)#5 ltm_lines_read:write_mem(glineBuf:rsc(5)(0).@)#5 ltm_lines_read:write_mem(blineBuf:rsc(5)(0).@)#5 ltm_lines_read:write_mem(rlineBuf:rsc(6)(0).@)#6 ltm_lines_read:write_mem(glineBuf:rsc(6)(0).@)#6 ltm_lines_read:write_mem(blineBuf:rsc(6)(0).@)#6 ltm_col:if:write_mem(rlineBuf:rsc(7)(0).@) ltm_col:if:write_mem(glineBuf:rsc(7)(0).@) ltm_col:if:write_mem(blineBuf:rsc(7)(0).@)}
directive set /ltm/core/ltm_window_read:read_mem(glineBuf:rsc(3)(0).@)#2 -IGNORE_DEPENDENCY_FROM {ltm_lines_read:write_mem(rlineBuf:rsc(0)(0).@) ltm_lines_read:write_mem(glineBuf:rsc(0)(0).@) ltm_lines_read:write_mem(blineBuf:rsc(0)(0).@) ltm_lines_read:write_mem(rlineBuf:rsc(1)(0).@)#1 ltm_lines_read:write_mem(glineBuf:rsc(1)(0).@)#1 ltm_lines_read:write_mem(blineBuf:rsc(1)(0).@)#1 ltm_lines_read:write_mem(rlineBuf:rsc(2)(0).@)#2 ltm_lines_read:write_mem(glineBuf:rsc(2)(0).@)#2 ltm_lines_read:write_mem(blineBuf:rsc(2)(0).@)#2 ltm_lines_read:write_mem(rlineBuf:rsc(3)(0).@)#3 ltm_lines_read:write_mem(glineBuf:rsc(3)(0).@)#3 ltm_lines_read:write_mem(blineBuf:rsc(3)(0).@)#3 ltm_lines_read:write_mem(rlineBuf:rsc(4)(0).@)#4 ltm_lines_read:write_mem(glineBuf:rsc(4)(0).@)#4 ltm_lines_read:write_mem(blineBuf:rsc(4)(0).@)#4 ltm_lines_read:write_mem(rlineBuf:rsc(5)(0).@)#5 ltm_lines_read:write_mem(glineBuf:rsc(5)(0).@)#5 ltm_lines_read:write_mem(blineBuf:rsc(5)(0).@)#5 ltm_lines_read:write_mem(rlineBuf:rsc(6)(0).@)#6 ltm_lines_read:write_mem(glineBuf:rsc(6)(0).@)#6 ltm_lines_read:write_mem(blineBuf:rsc(6)(0).@)#6 ltm_col:if:write_mem(rlineBuf:rsc(7)(0).@) ltm_col:if:write_mem(glineBuf:rsc(7)(0).@) ltm_col:if:write_mem(blineBuf:rsc(7)(0).@)}
directive set /ltm/core/ltm_window_read:read_mem(blineBuf:rsc(3)(0).@)#2 -IGNORE_DEPENDENCY_FROM {ltm_lines_read:write_mem(rlineBuf:rsc(0)(0).@) ltm_lines_read:write_mem(glineBuf:rsc(0)(0).@) ltm_lines_read:write_mem(blineBuf:rsc(0)(0).@) ltm_lines_read:write_mem(rlineBuf:rsc(1)(0).@)#1 ltm_lines_read:write_mem(glineBuf:rsc(1)(0).@)#1 ltm_lines_read:write_mem(blineBuf:rsc(1)(0).@)#1 ltm_lines_read:write_mem(rlineBuf:rsc(2)(0).@)#2 ltm_lines_read:write_mem(glineBuf:rsc(2)(0).@)#2 ltm_lines_read:write_mem(blineBuf:rsc(2)(0).@)#2 ltm_lines_read:write_mem(rlineBuf:rsc(3)(0).@)#3 ltm_lines_read:write_mem(glineBuf:rsc(3)(0).@)#3 ltm_lines_read:write_mem(blineBuf:rsc(3)(0).@)#3 ltm_lines_read:write_mem(rlineBuf:rsc(4)(0).@)#4 ltm_lines_read:write_mem(glineBuf:rsc(4)(0).@)#4 ltm_lines_read:write_mem(blineBuf:rsc(4)(0).@)#4 ltm_lines_read:write_mem(rlineBuf:rsc(5)(0).@)#5 ltm_lines_read:write_mem(glineBuf:rsc(5)(0).@)#5 ltm_lines_read:write_mem(blineBuf:rsc(5)(0).@)#5 ltm_lines_read:write_mem(rlineBuf:rsc(6)(0).@)#6 ltm_lines_read:write_mem(glineBuf:rsc(6)(0).@)#6 ltm_lines_read:write_mem(blineBuf:rsc(6)(0).@)#6 ltm_col:if:write_mem(rlineBuf:rsc(7)(0).@) ltm_col:if:write_mem(glineBuf:rsc(7)(0).@) ltm_col:if:write_mem(blineBuf:rsc(7)(0).@)}
directive set /ltm/core/ltm_window_read:read_mem(rlineBuf:rsc(4)(0).@)#3 -IGNORE_DEPENDENCY_FROM {ltm_lines_read:write_mem(rlineBuf:rsc(0)(0).@) ltm_lines_read:write_mem(glineBuf:rsc(0)(0).@) ltm_lines_read:write_mem(blineBuf:rsc(0)(0).@) ltm_lines_read:write_mem(rlineBuf:rsc(1)(0).@)#1 ltm_lines_read:write_mem(glineBuf:rsc(1)(0).@)#1 ltm_lines_read:write_mem(blineBuf:rsc(1)(0).@)#1 ltm_lines_read:write_mem(rlineBuf:rsc(2)(0).@)#2 ltm_lines_read:write_mem(glineBuf:rsc(2)(0).@)#2 ltm_lines_read:write_mem(blineBuf:rsc(2)(0).@)#2 ltm_lines_read:write_mem(rlineBuf:rsc(3)(0).@)#3 ltm_lines_read:write_mem(glineBuf:rsc(3)(0).@)#3 ltm_lines_read:write_mem(blineBuf:rsc(3)(0).@)#3 ltm_lines_read:write_mem(rlineBuf:rsc(4)(0).@)#4 ltm_lines_read:write_mem(glineBuf:rsc(4)(0).@)#4 ltm_lines_read:write_mem(blineBuf:rsc(4)(0).@)#4 ltm_lines_read:write_mem(rlineBuf:rsc(5)(0).@)#5 ltm_lines_read:write_mem(glineBuf:rsc(5)(0).@)#5 ltm_lines_read:write_mem(blineBuf:rsc(5)(0).@)#5 ltm_lines_read:write_mem(rlineBuf:rsc(6)(0).@)#6 ltm_lines_read:write_mem(glineBuf:rsc(6)(0).@)#6 ltm_lines_read:write_mem(blineBuf:rsc(6)(0).@)#6 ltm_col:if:write_mem(rlineBuf:rsc(7)(0).@) ltm_col:if:write_mem(glineBuf:rsc(7)(0).@) ltm_col:if:write_mem(blineBuf:rsc(7)(0).@)}
directive set /ltm/core/ltm_window_read:read_mem(glineBuf:rsc(4)(0).@)#3 -IGNORE_DEPENDENCY_FROM {ltm_lines_read:write_mem(rlineBuf:rsc(0)(0).@) ltm_lines_read:write_mem(glineBuf:rsc(0)(0).@) ltm_lines_read:write_mem(blineBuf:rsc(0)(0).@) ltm_lines_read:write_mem(rlineBuf:rsc(1)(0).@)#1 ltm_lines_read:write_mem(glineBuf:rsc(1)(0).@)#1 ltm_lines_read:write_mem(blineBuf:rsc(1)(0).@)#1 ltm_lines_read:write_mem(rlineBuf:rsc(2)(0).@)#2 ltm_lines_read:write_mem(glineBuf:rsc(2)(0).@)#2 ltm_lines_read:write_mem(blineBuf:rsc(2)(0).@)#2 ltm_lines_read:write_mem(rlineBuf:rsc(3)(0).@)#3 ltm_lines_read:write_mem(glineBuf:rsc(3)(0).@)#3 ltm_lines_read:write_mem(blineBuf:rsc(3)(0).@)#3 ltm_lines_read:write_mem(rlineBuf:rsc(4)(0).@)#4 ltm_lines_read:write_mem(glineBuf:rsc(4)(0).@)#4 ltm_lines_read:write_mem(blineBuf:rsc(4)(0).@)#4 ltm_lines_read:write_mem(rlineBuf:rsc(5)(0).@)#5 ltm_lines_read:write_mem(glineBuf:rsc(5)(0).@)#5 ltm_lines_read:write_mem(blineBuf:rsc(5)(0).@)#5 ltm_lines_read:write_mem(rlineBuf:rsc(6)(0).@)#6 ltm_lines_read:write_mem(glineBuf:rsc(6)(0).@)#6 ltm_lines_read:write_mem(blineBuf:rsc(6)(0).@)#6 ltm_col:if:write_mem(rlineBuf:rsc(7)(0).@) ltm_col:if:write_mem(glineBuf:rsc(7)(0).@) ltm_col:if:write_mem(blineBuf:rsc(7)(0).@)}
directive set /ltm/core/ltm_window_read:read_mem(blineBuf:rsc(4)(0).@)#3 -IGNORE_DEPENDENCY_FROM {ltm_lines_read:write_mem(rlineBuf:rsc(0)(0).@) ltm_lines_read:write_mem(glineBuf:rsc(0)(0).@) ltm_lines_read:write_mem(blineBuf:rsc(0)(0).@) ltm_lines_read:write_mem(rlineBuf:rsc(1)(0).@)#1 ltm_lines_read:write_mem(glineBuf:rsc(1)(0).@)#1 ltm_lines_read:write_mem(blineBuf:rsc(1)(0).@)#1 ltm_lines_read:write_mem(rlineBuf:rsc(2)(0).@)#2 ltm_lines_read:write_mem(glineBuf:rsc(2)(0).@)#2 ltm_lines_read:write_mem(blineBuf:rsc(2)(0).@)#2 ltm_lines_read:write_mem(rlineBuf:rsc(3)(0).@)#3 ltm_lines_read:write_mem(glineBuf:rsc(3)(0).@)#3 ltm_lines_read:write_mem(blineBuf:rsc(3)(0).@)#3 ltm_lines_read:write_mem(rlineBuf:rsc(4)(0).@)#4 ltm_lines_read:write_mem(glineBuf:rsc(4)(0).@)#4 ltm_lines_read:write_mem(blineBuf:rsc(4)(0).@)#4 ltm_lines_read:write_mem(rlineBuf:rsc(5)(0).@)#5 ltm_lines_read:write_mem(glineBuf:rsc(5)(0).@)#5 ltm_lines_read:write_mem(blineBuf:rsc(5)(0).@)#5 ltm_lines_read:write_mem(rlineBuf:rsc(6)(0).@)#6 ltm_lines_read:write_mem(glineBuf:rsc(6)(0).@)#6 ltm_lines_read:write_mem(blineBuf:rsc(6)(0).@)#6 ltm_col:if:write_mem(rlineBuf:rsc(7)(0).@) ltm_col:if:write_mem(glineBuf:rsc(7)(0).@) ltm_col:if:write_mem(blineBuf:rsc(7)(0).@)}
directive set /ltm/core/ltm_window_read:read_mem(rlineBuf:rsc(5)(0).@)#4 -IGNORE_DEPENDENCY_FROM {ltm_lines_read:write_mem(rlineBuf:rsc(0)(0).@) ltm_lines_read:write_mem(glineBuf:rsc(0)(0).@) ltm_lines_read:write_mem(blineBuf:rsc(0)(0).@) ltm_lines_read:write_mem(rlineBuf:rsc(1)(0).@)#1 ltm_lines_read:write_mem(glineBuf:rsc(1)(0).@)#1 ltm_lines_read:write_mem(blineBuf:rsc(1)(0).@)#1 ltm_lines_read:write_mem(rlineBuf:rsc(2)(0).@)#2 ltm_lines_read:write_mem(glineBuf:rsc(2)(0).@)#2 ltm_lines_read:write_mem(blineBuf:rsc(2)(0).@)#2 ltm_lines_read:write_mem(rlineBuf:rsc(3)(0).@)#3 ltm_lines_read:write_mem(glineBuf:rsc(3)(0).@)#3 ltm_lines_read:write_mem(blineBuf:rsc(3)(0).@)#3 ltm_lines_read:write_mem(rlineBuf:rsc(4)(0).@)#4 ltm_lines_read:write_mem(glineBuf:rsc(4)(0).@)#4 ltm_lines_read:write_mem(blineBuf:rsc(4)(0).@)#4 ltm_lines_read:write_mem(rlineBuf:rsc(5)(0).@)#5 ltm_lines_read:write_mem(glineBuf:rsc(5)(0).@)#5 ltm_lines_read:write_mem(blineBuf:rsc(5)(0).@)#5 ltm_lines_read:write_mem(rlineBuf:rsc(6)(0).@)#6 ltm_lines_read:write_mem(glineBuf:rsc(6)(0).@)#6 ltm_lines_read:write_mem(blineBuf:rsc(6)(0).@)#6 ltm_col:if:write_mem(rlineBuf:rsc(7)(0).@) ltm_col:if:write_mem(glineBuf:rsc(7)(0).@) ltm_col:if:write_mem(blineBuf:rsc(7)(0).@)}
directive set /ltm/core/ltm_window_read:read_mem(glineBuf:rsc(5)(0).@)#4 -IGNORE_DEPENDENCY_FROM {ltm_lines_read:write_mem(rlineBuf:rsc(0)(0).@) ltm_lines_read:write_mem(glineBuf:rsc(0)(0).@) ltm_lines_read:write_mem(blineBuf:rsc(0)(0).@) ltm_lines_read:write_mem(rlineBuf:rsc(1)(0).@)#1 ltm_lines_read:write_mem(glineBuf:rsc(1)(0).@)#1 ltm_lines_read:write_mem(blineBuf:rsc(1)(0).@)#1 ltm_lines_read:write_mem(rlineBuf:rsc(2)(0).@)#2 ltm_lines_read:write_mem(glineBuf:rsc(2)(0).@)#2 ltm_lines_read:write_mem(blineBuf:rsc(2)(0).@)#2 ltm_lines_read:write_mem(rlineBuf:rsc(3)(0).@)#3 ltm_lines_read:write_mem(glineBuf:rsc(3)(0).@)#3 ltm_lines_read:write_mem(blineBuf:rsc(3)(0).@)#3 ltm_lines_read:write_mem(rlineBuf:rsc(4)(0).@)#4 ltm_lines_read:write_mem(glineBuf:rsc(4)(0).@)#4 ltm_lines_read:write_mem(blineBuf:rsc(4)(0).@)#4 ltm_lines_read:write_mem(rlineBuf:rsc(5)(0).@)#5 ltm_lines_read:write_mem(glineBuf:rsc(5)(0).@)#5 ltm_lines_read:write_mem(blineBuf:rsc(5)(0).@)#5 ltm_lines_read:write_mem(rlineBuf:rsc(6)(0).@)#6 ltm_lines_read:write_mem(glineBuf:rsc(6)(0).@)#6 ltm_lines_read:write_mem(blineBuf:rsc(6)(0).@)#6 ltm_col:if:write_mem(rlineBuf:rsc(7)(0).@) ltm_col:if:write_mem(glineBuf:rsc(7)(0).@) ltm_col:if:write_mem(blineBuf:rsc(7)(0).@)}
directive set /ltm/core/ltm_window_read:read_mem(blineBuf:rsc(5)(0).@)#4 -IGNORE_DEPENDENCY_FROM {ltm_lines_read:write_mem(rlineBuf:rsc(0)(0).@) ltm_lines_read:write_mem(glineBuf:rsc(0)(0).@) ltm_lines_read:write_mem(blineBuf:rsc(0)(0).@) ltm_lines_read:write_mem(rlineBuf:rsc(1)(0).@)#1 ltm_lines_read:write_mem(glineBuf:rsc(1)(0).@)#1 ltm_lines_read:write_mem(blineBuf:rsc(1)(0).@)#1 ltm_lines_read:write_mem(rlineBuf:rsc(2)(0).@)#2 ltm_lines_read:write_mem(glineBuf:rsc(2)(0).@)#2 ltm_lines_read:write_mem(blineBuf:rsc(2)(0).@)#2 ltm_lines_read:write_mem(rlineBuf:rsc(3)(0).@)#3 ltm_lines_read:write_mem(glineBuf:rsc(3)(0).@)#3 ltm_lines_read:write_mem(blineBuf:rsc(3)(0).@)#3 ltm_lines_read:write_mem(rlineBuf:rsc(4)(0).@)#4 ltm_lines_read:write_mem(glineBuf:rsc(4)(0).@)#4 ltm_lines_read:write_mem(blineBuf:rsc(4)(0).@)#4 ltm_lines_read:write_mem(rlineBuf:rsc(5)(0).@)#5 ltm_lines_read:write_mem(glineBuf:rsc(5)(0).@)#5 ltm_lines_read:write_mem(blineBuf:rsc(5)(0).@)#5 ltm_lines_read:write_mem(rlineBuf:rsc(6)(0).@)#6 ltm_lines_read:write_mem(glineBuf:rsc(6)(0).@)#6 ltm_lines_read:write_mem(blineBuf:rsc(6)(0).@)#6 ltm_col:if:write_mem(rlineBuf:rsc(7)(0).@) ltm_col:if:write_mem(glineBuf:rsc(7)(0).@) ltm_col:if:write_mem(blineBuf:rsc(7)(0).@)}
directive set /ltm/core/ltm_window_read:read_mem(rlineBuf:rsc(6)(0).@)#5 -IGNORE_DEPENDENCY_FROM {ltm_lines_read:write_mem(rlineBuf:rsc(0)(0).@) ltm_lines_read:write_mem(glineBuf:rsc(0)(0).@) ltm_lines_read:write_mem(blineBuf:rsc(0)(0).@) ltm_lines_read:write_mem(rlineBuf:rsc(1)(0).@)#1 ltm_lines_read:write_mem(glineBuf:rsc(1)(0).@)#1 ltm_lines_read:write_mem(blineBuf:rsc(1)(0).@)#1 ltm_lines_read:write_mem(rlineBuf:rsc(2)(0).@)#2 ltm_lines_read:write_mem(glineBuf:rsc(2)(0).@)#2 ltm_lines_read:write_mem(blineBuf:rsc(2)(0).@)#2 ltm_lines_read:write_mem(rlineBuf:rsc(3)(0).@)#3 ltm_lines_read:write_mem(glineBuf:rsc(3)(0).@)#3 ltm_lines_read:write_mem(blineBuf:rsc(3)(0).@)#3 ltm_lines_read:write_mem(rlineBuf:rsc(4)(0).@)#4 ltm_lines_read:write_mem(glineBuf:rsc(4)(0).@)#4 ltm_lines_read:write_mem(blineBuf:rsc(4)(0).@)#4 ltm_lines_read:write_mem(rlineBuf:rsc(5)(0).@)#5 ltm_lines_read:write_mem(glineBuf:rsc(5)(0).@)#5 ltm_lines_read:write_mem(blineBuf:rsc(5)(0).@)#5 ltm_lines_read:write_mem(rlineBuf:rsc(6)(0).@)#6 ltm_lines_read:write_mem(glineBuf:rsc(6)(0).@)#6 ltm_lines_read:write_mem(blineBuf:rsc(6)(0).@)#6 ltm_col:if:write_mem(rlineBuf:rsc(7)(0).@) ltm_col:if:write_mem(glineBuf:rsc(7)(0).@) ltm_col:if:write_mem(blineBuf:rsc(7)(0).@)}
directive set /ltm/core/ltm_window_read:read_mem(glineBuf:rsc(6)(0).@)#5 -IGNORE_DEPENDENCY_FROM {ltm_lines_read:write_mem(rlineBuf:rsc(0)(0).@) ltm_lines_read:write_mem(glineBuf:rsc(0)(0).@) ltm_lines_read:write_mem(blineBuf:rsc(0)(0).@) ltm_lines_read:write_mem(rlineBuf:rsc(1)(0).@)#1 ltm_lines_read:write_mem(glineBuf:rsc(1)(0).@)#1 ltm_lines_read:write_mem(blineBuf:rsc(1)(0).@)#1 ltm_lines_read:write_mem(rlineBuf:rsc(2)(0).@)#2 ltm_lines_read:write_mem(glineBuf:rsc(2)(0).@)#2 ltm_lines_read:write_mem(blineBuf:rsc(2)(0).@)#2 ltm_lines_read:write_mem(rlineBuf:rsc(3)(0).@)#3 ltm_lines_read:write_mem(glineBuf:rsc(3)(0).@)#3 ltm_lines_read:write_mem(blineBuf:rsc(3)(0).@)#3 ltm_lines_read:write_mem(rlineBuf:rsc(4)(0).@)#4 ltm_lines_read:write_mem(glineBuf:rsc(4)(0).@)#4 ltm_lines_read:write_mem(blineBuf:rsc(4)(0).@)#4 ltm_lines_read:write_mem(rlineBuf:rsc(5)(0).@)#5 ltm_lines_read:write_mem(glineBuf:rsc(5)(0).@)#5 ltm_lines_read:write_mem(blineBuf:rsc(5)(0).@)#5 ltm_lines_read:write_mem(rlineBuf:rsc(6)(0).@)#6 ltm_lines_read:write_mem(glineBuf:rsc(6)(0).@)#6 ltm_lines_read:write_mem(blineBuf:rsc(6)(0).@)#6 ltm_col:if:write_mem(rlineBuf:rsc(7)(0).@) ltm_col:if:write_mem(glineBuf:rsc(7)(0).@) ltm_col:if:write_mem(blineBuf:rsc(7)(0).@)}
directive set /ltm/core/ltm_window_read:read_mem(blineBuf:rsc(6)(0).@)#5 -IGNORE_DEPENDENCY_FROM {ltm_lines_read:write_mem(rlineBuf:rsc(0)(0).@) ltm_lines_read:write_mem(glineBuf:rsc(0)(0).@) ltm_lines_read:write_mem(blineBuf:rsc(0)(0).@) ltm_lines_read:write_mem(rlineBuf:rsc(1)(0).@)#1 ltm_lines_read:write_mem(glineBuf:rsc(1)(0).@)#1 ltm_lines_read:write_mem(blineBuf:rsc(1)(0).@)#1 ltm_lines_read:write_mem(rlineBuf:rsc(2)(0).@)#2 ltm_lines_read:write_mem(glineBuf:rsc(2)(0).@)#2 ltm_lines_read:write_mem(blineBuf:rsc(2)(0).@)#2 ltm_lines_read:write_mem(rlineBuf:rsc(3)(0).@)#3 ltm_lines_read:write_mem(glineBuf:rsc(3)(0).@)#3 ltm_lines_read:write_mem(blineBuf:rsc(3)(0).@)#3 ltm_lines_read:write_mem(rlineBuf:rsc(4)(0).@)#4 ltm_lines_read:write_mem(glineBuf:rsc(4)(0).@)#4 ltm_lines_read:write_mem(blineBuf:rsc(4)(0).@)#4 ltm_lines_read:write_mem(rlineBuf:rsc(5)(0).@)#5 ltm_lines_read:write_mem(glineBuf:rsc(5)(0).@)#5 ltm_lines_read:write_mem(blineBuf:rsc(5)(0).@)#5 ltm_lines_read:write_mem(rlineBuf:rsc(6)(0).@)#6 ltm_lines_read:write_mem(glineBuf:rsc(6)(0).@)#6 ltm_lines_read:write_mem(blineBuf:rsc(6)(0).@)#6 ltm_col:if:write_mem(rlineBuf:rsc(7)(0).@) ltm_col:if:write_mem(glineBuf:rsc(7)(0).@) ltm_col:if:write_mem(blineBuf:rsc(7)(0).@)}
directive set /ltm/core/ltm_window_read:read_mem(rlineBuf:rsc(7)(0).@)#6 -IGNORE_DEPENDENCY_FROM {ltm_lines_read:write_mem(rlineBuf:rsc(0)(0).@) ltm_lines_read:write_mem(glineBuf:rsc(0)(0).@) ltm_lines_read:write_mem(blineBuf:rsc(0)(0).@) ltm_lines_read:write_mem(rlineBuf:rsc(1)(0).@)#1 ltm_lines_read:write_mem(glineBuf:rsc(1)(0).@)#1 ltm_lines_read:write_mem(blineBuf:rsc(1)(0).@)#1 ltm_lines_read:write_mem(rlineBuf:rsc(2)(0).@)#2 ltm_lines_read:write_mem(glineBuf:rsc(2)(0).@)#2 ltm_lines_read:write_mem(blineBuf:rsc(2)(0).@)#2 ltm_lines_read:write_mem(rlineBuf:rsc(3)(0).@)#3 ltm_lines_read:write_mem(glineBuf:rsc(3)(0).@)#3 ltm_lines_read:write_mem(blineBuf:rsc(3)(0).@)#3 ltm_lines_read:write_mem(rlineBuf:rsc(4)(0).@)#4 ltm_lines_read:write_mem(glineBuf:rsc(4)(0).@)#4 ltm_lines_read:write_mem(blineBuf:rsc(4)(0).@)#4 ltm_lines_read:write_mem(rlineBuf:rsc(5)(0).@)#5 ltm_lines_read:write_mem(glineBuf:rsc(5)(0).@)#5 ltm_lines_read:write_mem(blineBuf:rsc(5)(0).@)#5 ltm_lines_read:write_mem(rlineBuf:rsc(6)(0).@)#6 ltm_lines_read:write_mem(glineBuf:rsc(6)(0).@)#6 ltm_lines_read:write_mem(blineBuf:rsc(6)(0).@)#6 ltm_col:if:write_mem(rlineBuf:rsc(7)(0).@) ltm_col:if:write_mem(glineBuf:rsc(7)(0).@) ltm_col:if:write_mem(blineBuf:rsc(7)(0).@)}
directive set /ltm/core/ltm_window_read:read_mem(glineBuf:rsc(7)(0).@)#6 -IGNORE_DEPENDENCY_FROM {ltm_lines_read:write_mem(rlineBuf:rsc(0)(0).@) ltm_lines_read:write_mem(glineBuf:rsc(0)(0).@) ltm_lines_read:write_mem(blineBuf:rsc(0)(0).@) ltm_lines_read:write_mem(rlineBuf:rsc(1)(0).@)#1 ltm_lines_read:write_mem(glineBuf:rsc(1)(0).@)#1 ltm_lines_read:write_mem(blineBuf:rsc(1)(0).@)#1 ltm_lines_read:write_mem(rlineBuf:rsc(2)(0).@)#2 ltm_lines_read:write_mem(glineBuf:rsc(2)(0).@)#2 ltm_lines_read:write_mem(blineBuf:rsc(2)(0).@)#2 ltm_lines_read:write_mem(rlineBuf:rsc(3)(0).@)#3 ltm_lines_read:write_mem(glineBuf:rsc(3)(0).@)#3 ltm_lines_read:write_mem(blineBuf:rsc(3)(0).@)#3 ltm_lines_read:write_mem(rlineBuf:rsc(4)(0).@)#4 ltm_lines_read:write_mem(glineBuf:rsc(4)(0).@)#4 ltm_lines_read:write_mem(blineBuf:rsc(4)(0).@)#4 ltm_lines_read:write_mem(rlineBuf:rsc(5)(0).@)#5 ltm_lines_read:write_mem(glineBuf:rsc(5)(0).@)#5 ltm_lines_read:write_mem(blineBuf:rsc(5)(0).@)#5 ltm_lines_read:write_mem(rlineBuf:rsc(6)(0).@)#6 ltm_lines_read:write_mem(glineBuf:rsc(6)(0).@)#6 ltm_lines_read:write_mem(blineBuf:rsc(6)(0).@)#6 ltm_col:if:write_mem(rlineBuf:rsc(7)(0).@) ltm_col:if:write_mem(glineBuf:rsc(7)(0).@) ltm_col:if:write_mem(blineBuf:rsc(7)(0).@)}
directive set /ltm/core/ltm_window_read:read_mem(blineBuf:rsc(7)(0).@)#6 -IGNORE_DEPENDENCY_FROM {ltm_lines_read:write_mem(rlineBuf:rsc(0)(0).@) ltm_lines_read:write_mem(glineBuf:rsc(0)(0).@) ltm_lines_read:write_mem(blineBuf:rsc(0)(0).@) ltm_lines_read:write_mem(rlineBuf:rsc(1)(0).@)#1 ltm_lines_read:write_mem(glineBuf:rsc(1)(0).@)#1 ltm_lines_read:write_mem(blineBuf:rsc(1)(0).@)#1 ltm_lines_read:write_mem(rlineBuf:rsc(2)(0).@)#2 ltm_lines_read:write_mem(glineBuf:rsc(2)(0).@)#2 ltm_lines_read:write_mem(blineBuf:rsc(2)(0).@)#2 ltm_lines_read:write_mem(rlineBuf:rsc(3)(0).@)#3 ltm_lines_read:write_mem(glineBuf:rsc(3)(0).@)#3 ltm_lines_read:write_mem(blineBuf:rsc(3)(0).@)#3 ltm_lines_read:write_mem(rlineBuf:rsc(4)(0).@)#4 ltm_lines_read:write_mem(glineBuf:rsc(4)(0).@)#4 ltm_lines_read:write_mem(blineBuf:rsc(4)(0).@)#4 ltm_lines_read:write_mem(rlineBuf:rsc(5)(0).@)#5 ltm_lines_read:write_mem(glineBuf:rsc(5)(0).@)#5 ltm_lines_read:write_mem(blineBuf:rsc(5)(0).@)#5 ltm_lines_read:write_mem(rlineBuf:rsc(6)(0).@)#6 ltm_lines_read:write_mem(glineBuf:rsc(6)(0).@)#6 ltm_lines_read:write_mem(blineBuf:rsc(6)(0).@)#6 ltm_col:if:write_mem(rlineBuf:rsc(7)(0).@) ltm_col:if:write_mem(glineBuf:rsc(7)(0).@) ltm_col:if:write_mem(blineBuf:rsc(7)(0).@)}
directive set /ltm/core/ltm_window_read:read_mem(rlineBuf:rsc(0)(0).@)#7 -IGNORE_DEPENDENCY_FROM {ltm_lines_read:write_mem(rlineBuf:rsc(0)(0).@) ltm_lines_read:write_mem(glineBuf:rsc(0)(0).@) ltm_lines_read:write_mem(blineBuf:rsc(0)(0).@) ltm_lines_read:write_mem(rlineBuf:rsc(1)(0).@)#1 ltm_lines_read:write_mem(glineBuf:rsc(1)(0).@)#1 ltm_lines_read:write_mem(blineBuf:rsc(1)(0).@)#1 ltm_lines_read:write_mem(rlineBuf:rsc(2)(0).@)#2 ltm_lines_read:write_mem(glineBuf:rsc(2)(0).@)#2 ltm_lines_read:write_mem(blineBuf:rsc(2)(0).@)#2 ltm_lines_read:write_mem(rlineBuf:rsc(3)(0).@)#3 ltm_lines_read:write_mem(glineBuf:rsc(3)(0).@)#3 ltm_lines_read:write_mem(blineBuf:rsc(3)(0).@)#3 ltm_lines_read:write_mem(rlineBuf:rsc(4)(0).@)#4 ltm_lines_read:write_mem(glineBuf:rsc(4)(0).@)#4 ltm_lines_read:write_mem(blineBuf:rsc(4)(0).@)#4 ltm_lines_read:write_mem(rlineBuf:rsc(5)(0).@)#5 ltm_lines_read:write_mem(glineBuf:rsc(5)(0).@)#5 ltm_lines_read:write_mem(blineBuf:rsc(5)(0).@)#5 ltm_lines_read:write_mem(rlineBuf:rsc(6)(0).@)#6 ltm_lines_read:write_mem(glineBuf:rsc(6)(0).@)#6 ltm_lines_read:write_mem(blineBuf:rsc(6)(0).@)#6 ltm_col:if:write_mem(rlineBuf:rsc(7)(0).@) ltm_col:if:write_mem(glineBuf:rsc(7)(0).@) ltm_col:if:write_mem(blineBuf:rsc(7)(0).@)}
directive set /ltm/core/ltm_window_read:read_mem(glineBuf:rsc(0)(0).@)#7 -IGNORE_DEPENDENCY_FROM {ltm_lines_read:write_mem(rlineBuf:rsc(0)(0).@) ltm_lines_read:write_mem(glineBuf:rsc(0)(0).@) ltm_lines_read:write_mem(blineBuf:rsc(0)(0).@) ltm_lines_read:write_mem(rlineBuf:rsc(1)(0).@)#1 ltm_lines_read:write_mem(glineBuf:rsc(1)(0).@)#1 ltm_lines_read:write_mem(blineBuf:rsc(1)(0).@)#1 ltm_lines_read:write_mem(rlineBuf:rsc(2)(0).@)#2 ltm_lines_read:write_mem(glineBuf:rsc(2)(0).@)#2 ltm_lines_read:write_mem(blineBuf:rsc(2)(0).@)#2 ltm_lines_read:write_mem(rlineBuf:rsc(3)(0).@)#3 ltm_lines_read:write_mem(glineBuf:rsc(3)(0).@)#3 ltm_lines_read:write_mem(blineBuf:rsc(3)(0).@)#3 ltm_lines_read:write_mem(rlineBuf:rsc(4)(0).@)#4 ltm_lines_read:write_mem(glineBuf:rsc(4)(0).@)#4 ltm_lines_read:write_mem(blineBuf:rsc(4)(0).@)#4 ltm_lines_read:write_mem(rlineBuf:rsc(5)(0).@)#5 ltm_lines_read:write_mem(glineBuf:rsc(5)(0).@)#5 ltm_lines_read:write_mem(blineBuf:rsc(5)(0).@)#5 ltm_lines_read:write_mem(rlineBuf:rsc(6)(0).@)#6 ltm_lines_read:write_mem(glineBuf:rsc(6)(0).@)#6 ltm_lines_read:write_mem(blineBuf:rsc(6)(0).@)#6 ltm_col:if:write_mem(rlineBuf:rsc(7)(0).@) ltm_col:if:write_mem(glineBuf:rsc(7)(0).@) ltm_col:if:write_mem(blineBuf:rsc(7)(0).@)}
directive set /ltm/core/ltm_window_read:read_mem(blineBuf:rsc(0)(0).@)#7 -IGNORE_DEPENDENCY_FROM {ltm_lines_read:write_mem(rlineBuf:rsc(0)(0).@) ltm_lines_read:write_mem(glineBuf:rsc(0)(0).@) ltm_lines_read:write_mem(blineBuf:rsc(0)(0).@) ltm_lines_read:write_mem(rlineBuf:rsc(1)(0).@)#1 ltm_lines_read:write_mem(glineBuf:rsc(1)(0).@)#1 ltm_lines_read:write_mem(blineBuf:rsc(1)(0).@)#1 ltm_lines_read:write_mem(rlineBuf:rsc(2)(0).@)#2 ltm_lines_read:write_mem(glineBuf:rsc(2)(0).@)#2 ltm_lines_read:write_mem(blineBuf:rsc(2)(0).@)#2 ltm_lines_read:write_mem(rlineBuf:rsc(3)(0).@)#3 ltm_lines_read:write_mem(glineBuf:rsc(3)(0).@)#3 ltm_lines_read:write_mem(blineBuf:rsc(3)(0).@)#3 ltm_lines_read:write_mem(rlineBuf:rsc(4)(0).@)#4 ltm_lines_read:write_mem(glineBuf:rsc(4)(0).@)#4 ltm_lines_read:write_mem(blineBuf:rsc(4)(0).@)#4 ltm_lines_read:write_mem(rlineBuf:rsc(5)(0).@)#5 ltm_lines_read:write_mem(glineBuf:rsc(5)(0).@)#5 ltm_lines_read:write_mem(blineBuf:rsc(5)(0).@)#5 ltm_lines_read:write_mem(rlineBuf:rsc(6)(0).@)#6 ltm_lines_read:write_mem(glineBuf:rsc(6)(0).@)#6 ltm_lines_read:write_mem(blineBuf:rsc(6)(0).@)#6 ltm_col:if:write_mem(rlineBuf:rsc(7)(0).@) ltm_col:if:write_mem(glineBuf:rsc(7)(0).@) ltm_col:if:write_mem(blineBuf:rsc(7)(0).@)}
directive set /ltm/core/addon_loop_2:for:read_mem(rlineBuf:rsc(4)(0).@) -IGNORE_DEPENDENCY_FROM {ltm_lines_read:write_mem(rlineBuf:rsc(0)(0).@) ltm_lines_read:write_mem(glineBuf:rsc(0)(0).@) ltm_lines_read:write_mem(blineBuf:rsc(0)(0).@) ltm_lines_read:write_mem(rlineBuf:rsc(1)(0).@)#1 ltm_lines_read:write_mem(glineBuf:rsc(1)(0).@)#1 ltm_lines_read:write_mem(blineBuf:rsc(1)(0).@)#1 ltm_lines_read:write_mem(rlineBuf:rsc(2)(0).@)#2 ltm_lines_read:write_mem(glineBuf:rsc(2)(0).@)#2 ltm_lines_read:write_mem(blineBuf:rsc(2)(0).@)#2 ltm_lines_read:write_mem(rlineBuf:rsc(3)(0).@)#3 ltm_lines_read:write_mem(glineBuf:rsc(3)(0).@)#3 ltm_lines_read:write_mem(blineBuf:rsc(3)(0).@)#3 ltm_lines_read:write_mem(rlineBuf:rsc(4)(0).@)#4 ltm_lines_read:write_mem(glineBuf:rsc(4)(0).@)#4 ltm_lines_read:write_mem(blineBuf:rsc(4)(0).@)#4 ltm_lines_read:write_mem(rlineBuf:rsc(5)(0).@)#5 ltm_lines_read:write_mem(glineBuf:rsc(5)(0).@)#5 ltm_lines_read:write_mem(blineBuf:rsc(5)(0).@)#5 ltm_lines_read:write_mem(rlineBuf:rsc(6)(0).@)#6 ltm_lines_read:write_mem(glineBuf:rsc(6)(0).@)#6 ltm_lines_read:write_mem(blineBuf:rsc(6)(0).@)#6 ltm_col:if:write_mem(rlineBuf:rsc(7)(0).@) ltm_col:if:write_mem(glineBuf:rsc(7)(0).@) ltm_col:if:write_mem(blineBuf:rsc(7)(0).@)}
directive set /ltm/core/addon_loop_2:for:read_mem(glineBuf:rsc(4)(0).@) -IGNORE_DEPENDENCY_FROM {ltm_lines_read:write_mem(rlineBuf:rsc(0)(0).@) ltm_lines_read:write_mem(glineBuf:rsc(0)(0).@) ltm_lines_read:write_mem(blineBuf:rsc(0)(0).@) ltm_lines_read:write_mem(rlineBuf:rsc(1)(0).@)#1 ltm_lines_read:write_mem(glineBuf:rsc(1)(0).@)#1 ltm_lines_read:write_mem(blineBuf:rsc(1)(0).@)#1 ltm_lines_read:write_mem(rlineBuf:rsc(2)(0).@)#2 ltm_lines_read:write_mem(glineBuf:rsc(2)(0).@)#2 ltm_lines_read:write_mem(blineBuf:rsc(2)(0).@)#2 ltm_lines_read:write_mem(rlineBuf:rsc(3)(0).@)#3 ltm_lines_read:write_mem(glineBuf:rsc(3)(0).@)#3 ltm_lines_read:write_mem(blineBuf:rsc(3)(0).@)#3 ltm_lines_read:write_mem(rlineBuf:rsc(4)(0).@)#4 ltm_lines_read:write_mem(glineBuf:rsc(4)(0).@)#4 ltm_lines_read:write_mem(blineBuf:rsc(4)(0).@)#4 ltm_lines_read:write_mem(rlineBuf:rsc(5)(0).@)#5 ltm_lines_read:write_mem(glineBuf:rsc(5)(0).@)#5 ltm_lines_read:write_mem(blineBuf:rsc(5)(0).@)#5 ltm_lines_read:write_mem(rlineBuf:rsc(6)(0).@)#6 ltm_lines_read:write_mem(glineBuf:rsc(6)(0).@)#6 ltm_lines_read:write_mem(blineBuf:rsc(6)(0).@)#6 ltm_col:if:write_mem(rlineBuf:rsc(7)(0).@) ltm_col:if:write_mem(glineBuf:rsc(7)(0).@) ltm_col:if:write_mem(blineBuf:rsc(7)(0).@)}
directive set /ltm/core/addon_loop_2:for:read_mem(blineBuf:rsc(4)(0).@) -IGNORE_DEPENDENCY_FROM {ltm_lines_read:write_mem(rlineBuf:rsc(0)(0).@) ltm_lines_read:write_mem(glineBuf:rsc(0)(0).@) ltm_lines_read:write_mem(blineBuf:rsc(0)(0).@) ltm_lines_read:write_mem(rlineBuf:rsc(1)(0).@)#1 ltm_lines_read:write_mem(glineBuf:rsc(1)(0).@)#1 ltm_lines_read:write_mem(blineBuf:rsc(1)(0).@)#1 ltm_lines_read:write_mem(rlineBuf:rsc(2)(0).@)#2 ltm_lines_read:write_mem(glineBuf:rsc(2)(0).@)#2 ltm_lines_read:write_mem(blineBuf:rsc(2)(0).@)#2 ltm_lines_read:write_mem(rlineBuf:rsc(3)(0).@)#3 ltm_lines_read:write_mem(glineBuf:rsc(3)(0).@)#3 ltm_lines_read:write_mem(blineBuf:rsc(3)(0).@)#3 ltm_lines_read:write_mem(rlineBuf:rsc(4)(0).@)#4 ltm_lines_read:write_mem(glineBuf:rsc(4)(0).@)#4 ltm_lines_read:write_mem(blineBuf:rsc(4)(0).@)#4 ltm_lines_read:write_mem(rlineBuf:rsc(5)(0).@)#5 ltm_lines_read:write_mem(glineBuf:rsc(5)(0).@)#5 ltm_lines_read:write_mem(blineBuf:rsc(5)(0).@)#5 ltm_lines_read:write_mem(rlineBuf:rsc(6)(0).@)#6 ltm_lines_read:write_mem(glineBuf:rsc(6)(0).@)#6 ltm_lines_read:write_mem(blineBuf:rsc(6)(0).@)#6 ltm_col:if:write_mem(rlineBuf:rsc(7)(0).@) ltm_col:if:write_mem(glineBuf:rsc(7)(0).@) ltm_col:if:write_mem(blineBuf:rsc(7)(0).@)}
directive set /ltm/core/addon_loop_2:for:read_mem(rlineBuf:rsc(5)(0).@) -IGNORE_DEPENDENCY_FROM {ltm_lines_read:write_mem(rlineBuf:rsc(0)(0).@) ltm_lines_read:write_mem(glineBuf:rsc(0)(0).@) ltm_lines_read:write_mem(blineBuf:rsc(0)(0).@) ltm_lines_read:write_mem(rlineBuf:rsc(1)(0).@)#1 ltm_lines_read:write_mem(glineBuf:rsc(1)(0).@)#1 ltm_lines_read:write_mem(blineBuf:rsc(1)(0).@)#1 ltm_lines_read:write_mem(rlineBuf:rsc(2)(0).@)#2 ltm_lines_read:write_mem(glineBuf:rsc(2)(0).@)#2 ltm_lines_read:write_mem(blineBuf:rsc(2)(0).@)#2 ltm_lines_read:write_mem(rlineBuf:rsc(3)(0).@)#3 ltm_lines_read:write_mem(glineBuf:rsc(3)(0).@)#3 ltm_lines_read:write_mem(blineBuf:rsc(3)(0).@)#3 ltm_lines_read:write_mem(rlineBuf:rsc(4)(0).@)#4 ltm_lines_read:write_mem(glineBuf:rsc(4)(0).@)#4 ltm_lines_read:write_mem(blineBuf:rsc(4)(0).@)#4 ltm_lines_read:write_mem(rlineBuf:rsc(5)(0).@)#5 ltm_lines_read:write_mem(glineBuf:rsc(5)(0).@)#5 ltm_lines_read:write_mem(blineBuf:rsc(5)(0).@)#5 ltm_lines_read:write_mem(rlineBuf:rsc(6)(0).@)#6 ltm_lines_read:write_mem(glineBuf:rsc(6)(0).@)#6 ltm_lines_read:write_mem(blineBuf:rsc(6)(0).@)#6 ltm_col:if:write_mem(rlineBuf:rsc(7)(0).@) ltm_col:if:write_mem(glineBuf:rsc(7)(0).@) ltm_col:if:write_mem(blineBuf:rsc(7)(0).@)}
directive set /ltm/core/addon_loop_2:for:read_mem(glineBuf:rsc(5)(0).@) -IGNORE_DEPENDENCY_FROM {ltm_lines_read:write_mem(rlineBuf:rsc(0)(0).@) ltm_lines_read:write_mem(glineBuf:rsc(0)(0).@) ltm_lines_read:write_mem(blineBuf:rsc(0)(0).@) ltm_lines_read:write_mem(rlineBuf:rsc(1)(0).@)#1 ltm_lines_read:write_mem(glineBuf:rsc(1)(0).@)#1 ltm_lines_read:write_mem(blineBuf:rsc(1)(0).@)#1 ltm_lines_read:write_mem(rlineBuf:rsc(2)(0).@)#2 ltm_lines_read:write_mem(glineBuf:rsc(2)(0).@)#2 ltm_lines_read:write_mem(blineBuf:rsc(2)(0).@)#2 ltm_lines_read:write_mem(rlineBuf:rsc(3)(0).@)#3 ltm_lines_read:write_mem(glineBuf:rsc(3)(0).@)#3 ltm_lines_read:write_mem(blineBuf:rsc(3)(0).@)#3 ltm_lines_read:write_mem(rlineBuf:rsc(4)(0).@)#4 ltm_lines_read:write_mem(glineBuf:rsc(4)(0).@)#4 ltm_lines_read:write_mem(blineBuf:rsc(4)(0).@)#4 ltm_lines_read:write_mem(rlineBuf:rsc(5)(0).@)#5 ltm_lines_read:write_mem(glineBuf:rsc(5)(0).@)#5 ltm_lines_read:write_mem(blineBuf:rsc(5)(0).@)#5 ltm_lines_read:write_mem(rlineBuf:rsc(6)(0).@)#6 ltm_lines_read:write_mem(glineBuf:rsc(6)(0).@)#6 ltm_lines_read:write_mem(blineBuf:rsc(6)(0).@)#6 ltm_col:if:write_mem(rlineBuf:rsc(7)(0).@) ltm_col:if:write_mem(glineBuf:rsc(7)(0).@) ltm_col:if:write_mem(blineBuf:rsc(7)(0).@)}
directive set /ltm/core/addon_loop_2:for:read_mem(blineBuf:rsc(5)(0).@) -IGNORE_DEPENDENCY_FROM {ltm_lines_read:write_mem(rlineBuf:rsc(0)(0).@) ltm_lines_read:write_mem(glineBuf:rsc(0)(0).@) ltm_lines_read:write_mem(blineBuf:rsc(0)(0).@) ltm_lines_read:write_mem(rlineBuf:rsc(1)(0).@)#1 ltm_lines_read:write_mem(glineBuf:rsc(1)(0).@)#1 ltm_lines_read:write_mem(blineBuf:rsc(1)(0).@)#1 ltm_lines_read:write_mem(rlineBuf:rsc(2)(0).@)#2 ltm_lines_read:write_mem(glineBuf:rsc(2)(0).@)#2 ltm_lines_read:write_mem(blineBuf:rsc(2)(0).@)#2 ltm_lines_read:write_mem(rlineBuf:rsc(3)(0).@)#3 ltm_lines_read:write_mem(glineBuf:rsc(3)(0).@)#3 ltm_lines_read:write_mem(blineBuf:rsc(3)(0).@)#3 ltm_lines_read:write_mem(rlineBuf:rsc(4)(0).@)#4 ltm_lines_read:write_mem(glineBuf:rsc(4)(0).@)#4 ltm_lines_read:write_mem(blineBuf:rsc(4)(0).@)#4 ltm_lines_read:write_mem(rlineBuf:rsc(5)(0).@)#5 ltm_lines_read:write_mem(glineBuf:rsc(5)(0).@)#5 ltm_lines_read:write_mem(blineBuf:rsc(5)(0).@)#5 ltm_lines_read:write_mem(rlineBuf:rsc(6)(0).@)#6 ltm_lines_read:write_mem(glineBuf:rsc(6)(0).@)#6 ltm_lines_read:write_mem(blineBuf:rsc(6)(0).@)#6 ltm_col:if:write_mem(rlineBuf:rsc(7)(0).@) ltm_col:if:write_mem(glineBuf:rsc(7)(0).@) ltm_col:if:write_mem(blineBuf:rsc(7)(0).@)}
directive set /ltm/core/addon_loop_2:for:read_mem(rlineBuf:rsc(6)(0).@) -IGNORE_DEPENDENCY_FROM {ltm_lines_read:write_mem(rlineBuf:rsc(0)(0).@) ltm_lines_read:write_mem(glineBuf:rsc(0)(0).@) ltm_lines_read:write_mem(blineBuf:rsc(0)(0).@) ltm_lines_read:write_mem(rlineBuf:rsc(1)(0).@)#1 ltm_lines_read:write_mem(glineBuf:rsc(1)(0).@)#1 ltm_lines_read:write_mem(blineBuf:rsc(1)(0).@)#1 ltm_lines_read:write_mem(rlineBuf:rsc(2)(0).@)#2 ltm_lines_read:write_mem(glineBuf:rsc(2)(0).@)#2 ltm_lines_read:write_mem(blineBuf:rsc(2)(0).@)#2 ltm_lines_read:write_mem(rlineBuf:rsc(3)(0).@)#3 ltm_lines_read:write_mem(glineBuf:rsc(3)(0).@)#3 ltm_lines_read:write_mem(blineBuf:rsc(3)(0).@)#3 ltm_lines_read:write_mem(rlineBuf:rsc(4)(0).@)#4 ltm_lines_read:write_mem(glineBuf:rsc(4)(0).@)#4 ltm_lines_read:write_mem(blineBuf:rsc(4)(0).@)#4 ltm_lines_read:write_mem(rlineBuf:rsc(5)(0).@)#5 ltm_lines_read:write_mem(glineBuf:rsc(5)(0).@)#5 ltm_lines_read:write_mem(blineBuf:rsc(5)(0).@)#5 ltm_lines_read:write_mem(rlineBuf:rsc(6)(0).@)#6 ltm_lines_read:write_mem(glineBuf:rsc(6)(0).@)#6 ltm_lines_read:write_mem(blineBuf:rsc(6)(0).@)#6 ltm_col:if:write_mem(rlineBuf:rsc(7)(0).@) ltm_col:if:write_mem(glineBuf:rsc(7)(0).@) ltm_col:if:write_mem(blineBuf:rsc(7)(0).@)}
directive set /ltm/core/addon_loop_2:for:read_mem(glineBuf:rsc(6)(0).@) -IGNORE_DEPENDENCY_FROM {ltm_lines_read:write_mem(rlineBuf:rsc(0)(0).@) ltm_lines_read:write_mem(glineBuf:rsc(0)(0).@) ltm_lines_read:write_mem(blineBuf:rsc(0)(0).@) ltm_lines_read:write_mem(rlineBuf:rsc(1)(0).@)#1 ltm_lines_read:write_mem(glineBuf:rsc(1)(0).@)#1 ltm_lines_read:write_mem(blineBuf:rsc(1)(0).@)#1 ltm_lines_read:write_mem(rlineBuf:rsc(2)(0).@)#2 ltm_lines_read:write_mem(glineBuf:rsc(2)(0).@)#2 ltm_lines_read:write_mem(blineBuf:rsc(2)(0).@)#2 ltm_lines_read:write_mem(rlineBuf:rsc(3)(0).@)#3 ltm_lines_read:write_mem(glineBuf:rsc(3)(0).@)#3 ltm_lines_read:write_mem(blineBuf:rsc(3)(0).@)#3 ltm_lines_read:write_mem(rlineBuf:rsc(4)(0).@)#4 ltm_lines_read:write_mem(glineBuf:rsc(4)(0).@)#4 ltm_lines_read:write_mem(blineBuf:rsc(4)(0).@)#4 ltm_lines_read:write_mem(rlineBuf:rsc(5)(0).@)#5 ltm_lines_read:write_mem(glineBuf:rsc(5)(0).@)#5 ltm_lines_read:write_mem(blineBuf:rsc(5)(0).@)#5 ltm_lines_read:write_mem(rlineBuf:rsc(6)(0).@)#6 ltm_lines_read:write_mem(glineBuf:rsc(6)(0).@)#6 ltm_lines_read:write_mem(blineBuf:rsc(6)(0).@)#6 ltm_col:if:write_mem(rlineBuf:rsc(7)(0).@) ltm_col:if:write_mem(glineBuf:rsc(7)(0).@) ltm_col:if:write_mem(blineBuf:rsc(7)(0).@)}
directive set /ltm/core/addon_loop_2:for:read_mem(blineBuf:rsc(6)(0).@) -IGNORE_DEPENDENCY_FROM {ltm_lines_read:write_mem(rlineBuf:rsc(0)(0).@) ltm_lines_read:write_mem(glineBuf:rsc(0)(0).@) ltm_lines_read:write_mem(blineBuf:rsc(0)(0).@) ltm_lines_read:write_mem(rlineBuf:rsc(1)(0).@)#1 ltm_lines_read:write_mem(glineBuf:rsc(1)(0).@)#1 ltm_lines_read:write_mem(blineBuf:rsc(1)(0).@)#1 ltm_lines_read:write_mem(rlineBuf:rsc(2)(0).@)#2 ltm_lines_read:write_mem(glineBuf:rsc(2)(0).@)#2 ltm_lines_read:write_mem(blineBuf:rsc(2)(0).@)#2 ltm_lines_read:write_mem(rlineBuf:rsc(3)(0).@)#3 ltm_lines_read:write_mem(glineBuf:rsc(3)(0).@)#3 ltm_lines_read:write_mem(blineBuf:rsc(3)(0).@)#3 ltm_lines_read:write_mem(rlineBuf:rsc(4)(0).@)#4 ltm_lines_read:write_mem(glineBuf:rsc(4)(0).@)#4 ltm_lines_read:write_mem(blineBuf:rsc(4)(0).@)#4 ltm_lines_read:write_mem(rlineBuf:rsc(5)(0).@)#5 ltm_lines_read:write_mem(glineBuf:rsc(5)(0).@)#5 ltm_lines_read:write_mem(blineBuf:rsc(5)(0).@)#5 ltm_lines_read:write_mem(rlineBuf:rsc(6)(0).@)#6 ltm_lines_read:write_mem(glineBuf:rsc(6)(0).@)#6 ltm_lines_read:write_mem(blineBuf:rsc(6)(0).@)#6 ltm_col:if:write_mem(rlineBuf:rsc(7)(0).@) ltm_col:if:write_mem(glineBuf:rsc(7)(0).@) ltm_col:if:write_mem(blineBuf:rsc(7)(0).@)}
directive set /ltm/core/addon_loop_2:for:read_mem(rlineBuf:rsc(7)(0).@) -IGNORE_DEPENDENCY_FROM {ltm_lines_read:write_mem(rlineBuf:rsc(0)(0).@) ltm_lines_read:write_mem(glineBuf:rsc(0)(0).@) ltm_lines_read:write_mem(blineBuf:rsc(0)(0).@) ltm_lines_read:write_mem(rlineBuf:rsc(1)(0).@)#1 ltm_lines_read:write_mem(glineBuf:rsc(1)(0).@)#1 ltm_lines_read:write_mem(blineBuf:rsc(1)(0).@)#1 ltm_lines_read:write_mem(rlineBuf:rsc(2)(0).@)#2 ltm_lines_read:write_mem(glineBuf:rsc(2)(0).@)#2 ltm_lines_read:write_mem(blineBuf:rsc(2)(0).@)#2 ltm_lines_read:write_mem(rlineBuf:rsc(3)(0).@)#3 ltm_lines_read:write_mem(glineBuf:rsc(3)(0).@)#3 ltm_lines_read:write_mem(blineBuf:rsc(3)(0).@)#3 ltm_lines_read:write_mem(rlineBuf:rsc(4)(0).@)#4 ltm_lines_read:write_mem(glineBuf:rsc(4)(0).@)#4 ltm_lines_read:write_mem(blineBuf:rsc(4)(0).@)#4 ltm_lines_read:write_mem(rlineBuf:rsc(5)(0).@)#5 ltm_lines_read:write_mem(glineBuf:rsc(5)(0).@)#5 ltm_lines_read:write_mem(blineBuf:rsc(5)(0).@)#5 ltm_lines_read:write_mem(rlineBuf:rsc(6)(0).@)#6 ltm_lines_read:write_mem(glineBuf:rsc(6)(0).@)#6 ltm_lines_read:write_mem(blineBuf:rsc(6)(0).@)#6 ltm_col:if:write_mem(rlineBuf:rsc(7)(0).@) ltm_col:if:write_mem(glineBuf:rsc(7)(0).@) ltm_col:if:write_mem(blineBuf:rsc(7)(0).@)}
directive set /ltm/core/addon_loop_2:for:read_mem(glineBuf:rsc(7)(0).@) -IGNORE_DEPENDENCY_FROM {ltm_lines_read:write_mem(rlineBuf:rsc(0)(0).@) ltm_lines_read:write_mem(glineBuf:rsc(0)(0).@) ltm_lines_read:write_mem(blineBuf:rsc(0)(0).@) ltm_lines_read:write_mem(rlineBuf:rsc(1)(0).@)#1 ltm_lines_read:write_mem(glineBuf:rsc(1)(0).@)#1 ltm_lines_read:write_mem(blineBuf:rsc(1)(0).@)#1 ltm_lines_read:write_mem(rlineBuf:rsc(2)(0).@)#2 ltm_lines_read:write_mem(glineBuf:rsc(2)(0).@)#2 ltm_lines_read:write_mem(blineBuf:rsc(2)(0).@)#2 ltm_lines_read:write_mem(rlineBuf:rsc(3)(0).@)#3 ltm_lines_read:write_mem(glineBuf:rsc(3)(0).@)#3 ltm_lines_read:write_mem(blineBuf:rsc(3)(0).@)#3 ltm_lines_read:write_mem(rlineBuf:rsc(4)(0).@)#4 ltm_lines_read:write_mem(glineBuf:rsc(4)(0).@)#4 ltm_lines_read:write_mem(blineBuf:rsc(4)(0).@)#4 ltm_lines_read:write_mem(rlineBuf:rsc(5)(0).@)#5 ltm_lines_read:write_mem(glineBuf:rsc(5)(0).@)#5 ltm_lines_read:write_mem(blineBuf:rsc(5)(0).@)#5 ltm_lines_read:write_mem(rlineBuf:rsc(6)(0).@)#6 ltm_lines_read:write_mem(glineBuf:rsc(6)(0).@)#6 ltm_lines_read:write_mem(blineBuf:rsc(6)(0).@)#6 ltm_col:if:write_mem(rlineBuf:rsc(7)(0).@) ltm_col:if:write_mem(glineBuf:rsc(7)(0).@) ltm_col:if:write_mem(blineBuf:rsc(7)(0).@)}
directive set /ltm/core/addon_loop_2:for:read_mem(blineBuf:rsc(7)(0).@) -IGNORE_DEPENDENCY_FROM {ltm_lines_read:write_mem(rlineBuf:rsc(0)(0).@) ltm_lines_read:write_mem(glineBuf:rsc(0)(0).@) ltm_lines_read:write_mem(blineBuf:rsc(0)(0).@) ltm_lines_read:write_mem(rlineBuf:rsc(1)(0).@)#1 ltm_lines_read:write_mem(glineBuf:rsc(1)(0).@)#1 ltm_lines_read:write_mem(blineBuf:rsc(1)(0).@)#1 ltm_lines_read:write_mem(rlineBuf:rsc(2)(0).@)#2 ltm_lines_read:write_mem(glineBuf:rsc(2)(0).@)#2 ltm_lines_read:write_mem(blineBuf:rsc(2)(0).@)#2 ltm_lines_read:write_mem(rlineBuf:rsc(3)(0).@)#3 ltm_lines_read:write_mem(glineBuf:rsc(3)(0).@)#3 ltm_lines_read:write_mem(blineBuf:rsc(3)(0).@)#3 ltm_lines_read:write_mem(rlineBuf:rsc(4)(0).@)#4 ltm_lines_read:write_mem(glineBuf:rsc(4)(0).@)#4 ltm_lines_read:write_mem(blineBuf:rsc(4)(0).@)#4 ltm_lines_read:write_mem(rlineBuf:rsc(5)(0).@)#5 ltm_lines_read:write_mem(glineBuf:rsc(5)(0).@)#5 ltm_lines_read:write_mem(blineBuf:rsc(5)(0).@)#5 ltm_lines_read:write_mem(rlineBuf:rsc(6)(0).@)#6 ltm_lines_read:write_mem(glineBuf:rsc(6)(0).@)#6 ltm_lines_read:write_mem(blineBuf:rsc(6)(0).@)#6 ltm_col:if:write_mem(rlineBuf:rsc(7)(0).@) ltm_col:if:write_mem(glineBuf:rsc(7)(0).@) ltm_col:if:write_mem(blineBuf:rsc(7)(0).@)}
go allocate
go extract
//  Catapult Prime Synthesis 2022.1/981271 (Production Release) Thu Feb 10 22:05:20 PST 2022
//
//          Copyright (c) Siemens EDA, 1996-2022, All Rights Reserved.
//                        UNPUBLISHED, LICENSED SOFTWARE.
//             CONFIDENTIAL AND PROPRIETARY INFORMATION WHICH IS THE
//                   PROPERTY OF SIEMENS EDA OR ITS LICENSORS.
//
//  Running on Linux wanwei.xiao@alish-rs-cs08.eng.t-head.cn 3.10.0-1160.66.1.el7.x86_64 x86_64 aol
//
//  Package information: SIFLIBS v25.1_0.0, HLS_PKGS v25.1_0.0,
//                       SIF_TOOLKITS v25.1_0.0, SIF_XILINX v25.1_0.0,
//                       SIF_ALTERA v25.1_0.0, CCS_LIBS v25.1_0.0,
//                       CDS_PPRO v10.6, CDS_DesigChecker v2022.1,
//                       CDS_OASYS v21.1_2.5, CDS_PSR v21.1_0.4,
//                       DesignPad v2.78_1.0
//
solution new -state initial
solution options defaults
solution options set /Input/CppStandard c++11
solution options set /Output/GenerateCycleNetlist false
solution options set /Flows/SCVerify/USE_QUESTASIM false
solution options set /Flows/SCVerify/USE_OSCI false
solution options set /Flows/SCVerify/USE_VCS true
solution options set /Flows/VCS/VG_ENV32_SCRIPT source_me_gcc483_32.csh
solution options set /Flows/VCS/VG_ENV64_SCRIPT source_me_gcc483_64.csh
solution options set /Flows/VCS/VLOGAN_OPTS {+v2k +no_tchk_msg -kdb -lca}
solution options set /Flows/VCS/VCSELAB_OPTS {-debug_acc+all -debug_region+cell+encrypt -timescale=1ps/1ps -sysc=blocksync -sysc=2.3.1 -sysc=slow_sc_main}
solution options set /Flows/VCS/SYSC_VERSION 2.3.1
flow package require /SCVerify
solution file add ../src/cac.h -type CHEADER -exclude true
solution file add ../src/cac.cpp -type C++
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
directive set -IDLE_SIGNAL {}
directive set -STALL_FLAG_SV off
directive set -STALL_FLAG false
directive set -TRANSACTION_DONE_SIGNAL true
directive set -DONE_FLAG {}
directive set -READY_FLAG {}
directive set -START_FLAG {}
directive set -TRANSACTION_SYNC ready
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
directive set -PROTOTYPING_ENGINE oasys
directive set -PIPELINE_RAMP_UP true
go new
solution design set cac -top
solution design set ac::fx_div<8> -block
go analyze
go compile
solution library add nangate-45nm_beh -- -rtlsyntool DesignCompiler -vendor Nangate -technology 045nm
solution library add ccs_sample_mem
go libraries
directive set -CLOCKS {clk {-CLOCK_PERIOD 3.33 -CLOCK_EDGE rising -CLOCK_UNCERTAINTY 0.0 -CLOCK_HIGH_TIME 1.665 -RESET_SYNC_NAME rst -RESET_ASYNC_NAME arst_n -RESET_KIND sync -RESET_SYNC_ACTIVE high -RESET_ASYNC_ACTIVE low -ENABLE_ACTIVE high}}
go assembly
directive set /cac/top_reg.frameWidth:rsc -MAP_TO_MODULE {[DirectInput]}
directive set /cac/top_reg.frameHeight:rsc -MAP_TO_MODULE {[DirectInput]}
directive set /cac/top_reg.inputFormat:rsc -MAP_TO_MODULE {[DirectInput]}
directive set /cac/top_reg.imgPattern:rsc -MAP_TO_MODULE {[DirectInput]}
directive set /cac/top_reg.pipeMode:rsc -MAP_TO_MODULE {[DirectInput]}
directive set /cac/top_reg.blc:rsc -MAP_TO_MODULE {[DirectInput]}
directive set /cac/top_reg.shadowEb:rsc -MAP_TO_MODULE {[DirectInput]}
directive set /cac/top_reg.binningFrameWidth:rsc -MAP_TO_MODULE {[DirectInput]}
directive set /cac/top_reg.binningFrameHeight:rsc -MAP_TO_MODULE {[DirectInput]}
directive set /cac/top_reg.scalerFrameWidth:rsc -MAP_TO_MODULE {[DirectInput]}
directive set /cac/top_reg.scalerFrameHeight:rsc -MAP_TO_MODULE {[DirectInput]}
directive set /cac/cac_reg.eb:rsc -MAP_TO_MODULE {[DirectInput]}
directive set /cac/cac_reg.t_transient:rsc -MAP_TO_MODULE {[DirectInput]}
directive set /cac/cac_reg.t_edge:rsc -MAP_TO_MODULE {[DirectInput]}
directive set /cac/core/rgbWindow:rsc -MAP_TO_MODULE {[Register]}
directive set /cac/core/lineBuffer:rsc -BLOCK_SIZE 8192
directive set /cac/core/inPixel_int.r:rsc -MAP_TO_MODULE {[Register]}
directive set /cac/core/inPixel_int.g:rsc -MAP_TO_MODULE {[Register]}
directive set /cac/core/inPixel_int.b:rsc -MAP_TO_MODULE {[Register]}
directive set /cac/core/main -PIPELINE_INIT_INTERVAL 1
directive set /cac/core/storeWindow_r:rsc -MAP_TO_MODULE {[Register]}
directive set /cac/core/storeWindow_b:rsc -MAP_TO_MODULE {[Register]}
directive set /cac/core/storeBuffer_r:rsc -BLOCK_SIZE 8192
directive set /cac/core/storeBuffer_b:rsc -BLOCK_SIZE 8192
directive set /cac/core/storeWindow_shift_row -UNROLL yes
directive set /cac/core/storeWindow_shift_col -UNROLL yes
directive set /cac/core/storeWindow_in -UNROLL yes
directive set /cac/core/rgbWindow_loop -UNROLL yes
directive set /cac/core/rgbWindow_loop_j -UNROLL yes
directive set /cac/core/rgbWindow_read -UNROLL yes
directive set /cac/core/linebuffer_read -UNROLL yes
directive set /cac/core/pixel_temp_row -UNROLL yes
directive set /cac/core/pixel_temp_col -UNROLL yes
directive set /cac/core/edge_h_loop -UNROLL yes
directive set /cac/core/diff_loop -UNROLL yes
directive set /cac/core/l_r_loop -UNROLL yes
directive set /cac/core/u_d_loop -UNROLL yes
directive set /cac/core/storeWindow_loop -UNROLL yes
directive set /cac/core/storeBuffer_write -UNROLL yes
go architect
directive set /cac/core/storeWindow_in:read_mem(storeBuffer_r:rsc(1)(0).@) -IGNORE_DEPENDENCY_FROM {linebuffer_read:write_mem(lineBuffer:rsc(0)(0).@) linebuffer_read:write_mem(lineBuffer:rsc(1)(0).@)#1 linebuffer_read:write_mem(lineBuffer:rsc(2)(0).@)#2 linebuffer_read:write_mem(lineBuffer:rsc(3)(0).@)#3 linebuffer_read:write_mem(lineBuffer:rsc(4)(0).@)#4 cac_col:if:write_mem(lineBuffer:rsc(5)(0).@) storeBuffer_write:if:write_mem(storeBuffer_r:rsc(1)(0).@)#1 storeBuffer_write:if:write_mem(storeBuffer_b:rsc(1)(0).@)#1 storeBuffer_write:if:write_mem(storeBuffer_r:rsc(2)(0).@)#2 storeBuffer_write:if:write_mem(storeBuffer_b:rsc(2)(0).@)#2 storeBuffer_write:if:write_mem(storeBuffer_r:rsc(3)(0).@)#3 storeBuffer_write:if:write_mem(storeBuffer_b:rsc(3)(0).@)#3 storeBuffer_write:if:write_mem(storeBuffer_r:rsc(4)(0).@)#4 storeBuffer_write:if:write_mem(storeBuffer_b:rsc(4)(0).@)#4 storeBuffer_write:if:write_mem(storeBuffer_r:rsc(5)(0).@)#5 storeBuffer_write:if:write_mem(storeBuffer_b:rsc(5)(0).@)#5 storeBuffer_write:else:if:write_mem(storeBuffer_r:rsc(1)(0).@)#1 storeBuffer_write:else:if:write_mem(storeBuffer_b:rsc(1)(0).@)#1 storeBuffer_write:else:if:write_mem(storeBuffer_r:rsc(2)(0).@)#2 storeBuffer_write:else:if:write_mem(storeBuffer_b:rsc(2)(0).@)#2 storeBuffer_write:else:if:write_mem(storeBuffer_r:rsc(3)(0).@)#3 storeBuffer_write:else:if:write_mem(storeBuffer_b:rsc(3)(0).@)#3 storeBuffer_write:else:if:write_mem(storeBuffer_r:rsc(4)(0).@)#4 storeBuffer_write:else:if:write_mem(storeBuffer_b:rsc(4)(0).@)#4 storeBuffer_write:else:if:write_mem(storeBuffer_r:rsc(5)(0).@)#5 storeBuffer_write:else:if:write_mem(storeBuffer_b:rsc(5)(0).@)#5 storeBuffer_write:else:else:write_mem(storeBuffer_r:rsc(1)(0).@)#6 storeBuffer_write:else:else:write_mem(storeBuffer_b:rsc(1)(0).@)#6 storeBuffer_write:else:else:write_mem(storeBuffer_b:rsc(2)(0).@)#6 storeBuffer_write:else:else:write_mem(storeBuffer_r:rsc(2)(0).@)#6 storeBuffer_write:else:else:write_mem(storeBuffer_r:rsc(3)(0).@)#6 storeBuffer_write:else:else:write_mem(storeBuffer_b:rsc(3)(0).@)#6 storeBuffer_write:else:else:write_mem(storeBuffer_r:rsc(5)(0).@)#6 storeBuffer_write:else:else:write_mem(storeBuffer_r:rsc(4)(0).@)#6 storeBuffer_write:else:else:write_mem(storeBuffer_b:rsc(5)(0).@)#6 storeBuffer_write:else:else:write_mem(storeBuffer_b:rsc(4)(0).@)#6}
directive set /cac/core/storeWindow_in:read_mem(storeBuffer_b:rsc(1)(0).@) -IGNORE_DEPENDENCY_FROM {linebuffer_read:write_mem(lineBuffer:rsc(0)(0).@) linebuffer_read:write_mem(lineBuffer:rsc(1)(0).@)#1 linebuffer_read:write_mem(lineBuffer:rsc(2)(0).@)#2 linebuffer_read:write_mem(lineBuffer:rsc(3)(0).@)#3 linebuffer_read:write_mem(lineBuffer:rsc(4)(0).@)#4 cac_col:if:write_mem(lineBuffer:rsc(5)(0).@) storeBuffer_write:if:write_mem(storeBuffer_r:rsc(1)(0).@)#1 storeBuffer_write:if:write_mem(storeBuffer_b:rsc(1)(0).@)#1 storeBuffer_write:if:write_mem(storeBuffer_r:rsc(2)(0).@)#2 storeBuffer_write:if:write_mem(storeBuffer_b:rsc(2)(0).@)#2 storeBuffer_write:if:write_mem(storeBuffer_r:rsc(3)(0).@)#3 storeBuffer_write:if:write_mem(storeBuffer_b:rsc(3)(0).@)#3 storeBuffer_write:if:write_mem(storeBuffer_r:rsc(4)(0).@)#4 storeBuffer_write:if:write_mem(storeBuffer_b:rsc(4)(0).@)#4 storeBuffer_write:if:write_mem(storeBuffer_r:rsc(5)(0).@)#5 storeBuffer_write:if:write_mem(storeBuffer_b:rsc(5)(0).@)#5 storeBuffer_write:else:if:write_mem(storeBuffer_r:rsc(1)(0).@)#1 storeBuffer_write:else:if:write_mem(storeBuffer_b:rsc(1)(0).@)#1 storeBuffer_write:else:if:write_mem(storeBuffer_r:rsc(2)(0).@)#2 storeBuffer_write:else:if:write_mem(storeBuffer_b:rsc(2)(0).@)#2 storeBuffer_write:else:if:write_mem(storeBuffer_r:rsc(3)(0).@)#3 storeBuffer_write:else:if:write_mem(storeBuffer_b:rsc(3)(0).@)#3 storeBuffer_write:else:if:write_mem(storeBuffer_r:rsc(4)(0).@)#4 storeBuffer_write:else:if:write_mem(storeBuffer_b:rsc(4)(0).@)#4 storeBuffer_write:else:if:write_mem(storeBuffer_r:rsc(5)(0).@)#5 storeBuffer_write:else:if:write_mem(storeBuffer_b:rsc(5)(0).@)#5 storeBuffer_write:else:else:write_mem(storeBuffer_r:rsc(1)(0).@)#6 storeBuffer_write:else:else:write_mem(storeBuffer_b:rsc(1)(0).@)#6 storeBuffer_write:else:else:write_mem(storeBuffer_b:rsc(2)(0).@)#6 storeBuffer_write:else:else:write_mem(storeBuffer_r:rsc(2)(0).@)#6 storeBuffer_write:else:else:write_mem(storeBuffer_r:rsc(3)(0).@)#6 storeBuffer_write:else:else:write_mem(storeBuffer_b:rsc(3)(0).@)#6 storeBuffer_write:else:else:write_mem(storeBuffer_r:rsc(5)(0).@)#6 storeBuffer_write:else:else:write_mem(storeBuffer_r:rsc(4)(0).@)#6 storeBuffer_write:else:else:write_mem(storeBuffer_b:rsc(5)(0).@)#6 storeBuffer_write:else:else:write_mem(storeBuffer_b:rsc(4)(0).@)#6}
directive set /cac/core/storeWindow_in:read_mem(storeBuffer_r:rsc(2)(0).@)#1 -IGNORE_DEPENDENCY_FROM {linebuffer_read:write_mem(lineBuffer:rsc(0)(0).@) linebuffer_read:write_mem(lineBuffer:rsc(1)(0).@)#1 linebuffer_read:write_mem(lineBuffer:rsc(2)(0).@)#2 linebuffer_read:write_mem(lineBuffer:rsc(3)(0).@)#3 linebuffer_read:write_mem(lineBuffer:rsc(4)(0).@)#4 cac_col:if:write_mem(lineBuffer:rsc(5)(0).@) storeBuffer_write:if:write_mem(storeBuffer_r:rsc(1)(0).@)#1 storeBuffer_write:if:write_mem(storeBuffer_b:rsc(1)(0).@)#1 storeBuffer_write:if:write_mem(storeBuffer_r:rsc(2)(0).@)#2 storeBuffer_write:if:write_mem(storeBuffer_b:rsc(2)(0).@)#2 storeBuffer_write:if:write_mem(storeBuffer_r:rsc(3)(0).@)#3 storeBuffer_write:if:write_mem(storeBuffer_b:rsc(3)(0).@)#3 storeBuffer_write:if:write_mem(storeBuffer_r:rsc(4)(0).@)#4 storeBuffer_write:if:write_mem(storeBuffer_b:rsc(4)(0).@)#4 storeBuffer_write:if:write_mem(storeBuffer_r:rsc(5)(0).@)#5 storeBuffer_write:if:write_mem(storeBuffer_b:rsc(5)(0).@)#5 storeBuffer_write:else:if:write_mem(storeBuffer_r:rsc(1)(0).@)#1 storeBuffer_write:else:if:write_mem(storeBuffer_b:rsc(1)(0).@)#1 storeBuffer_write:else:if:write_mem(storeBuffer_r:rsc(2)(0).@)#2 storeBuffer_write:else:if:write_mem(storeBuffer_b:rsc(2)(0).@)#2 storeBuffer_write:else:if:write_mem(storeBuffer_r:rsc(3)(0).@)#3 storeBuffer_write:else:if:write_mem(storeBuffer_b:rsc(3)(0).@)#3 storeBuffer_write:else:if:write_mem(storeBuffer_r:rsc(4)(0).@)#4 storeBuffer_write:else:if:write_mem(storeBuffer_b:rsc(4)(0).@)#4 storeBuffer_write:else:if:write_mem(storeBuffer_r:rsc(5)(0).@)#5 storeBuffer_write:else:if:write_mem(storeBuffer_b:rsc(5)(0).@)#5 storeBuffer_write:else:else:write_mem(storeBuffer_r:rsc(1)(0).@)#6 storeBuffer_write:else:else:write_mem(storeBuffer_b:rsc(1)(0).@)#6 storeBuffer_write:else:else:write_mem(storeBuffer_b:rsc(2)(0).@)#6 storeBuffer_write:else:else:write_mem(storeBuffer_r:rsc(2)(0).@)#6 storeBuffer_write:else:else:write_mem(storeBuffer_r:rsc(3)(0).@)#6 storeBuffer_write:else:else:write_mem(storeBuffer_b:rsc(3)(0).@)#6 storeBuffer_write:else:else:write_mem(storeBuffer_r:rsc(5)(0).@)#6 storeBuffer_write:else:else:write_mem(storeBuffer_r:rsc(4)(0).@)#6 storeBuffer_write:else:else:write_mem(storeBuffer_b:rsc(5)(0).@)#6 storeBuffer_write:else:else:write_mem(storeBuffer_b:rsc(4)(0).@)#6}
directive set /cac/core/storeWindow_in:read_mem(storeBuffer_b:rsc(2)(0).@)#1 -IGNORE_DEPENDENCY_FROM {linebuffer_read:write_mem(lineBuffer:rsc(0)(0).@) linebuffer_read:write_mem(lineBuffer:rsc(1)(0).@)#1 linebuffer_read:write_mem(lineBuffer:rsc(2)(0).@)#2 linebuffer_read:write_mem(lineBuffer:rsc(3)(0).@)#3 linebuffer_read:write_mem(lineBuffer:rsc(4)(0).@)#4 cac_col:if:write_mem(lineBuffer:rsc(5)(0).@) storeBuffer_write:if:write_mem(storeBuffer_r:rsc(1)(0).@)#1 storeBuffer_write:if:write_mem(storeBuffer_b:rsc(1)(0).@)#1 storeBuffer_write:if:write_mem(storeBuffer_r:rsc(2)(0).@)#2 storeBuffer_write:if:write_mem(storeBuffer_b:rsc(2)(0).@)#2 storeBuffer_write:if:write_mem(storeBuffer_r:rsc(3)(0).@)#3 storeBuffer_write:if:write_mem(storeBuffer_b:rsc(3)(0).@)#3 storeBuffer_write:if:write_mem(storeBuffer_r:rsc(4)(0).@)#4 storeBuffer_write:if:write_mem(storeBuffer_b:rsc(4)(0).@)#4 storeBuffer_write:if:write_mem(storeBuffer_r:rsc(5)(0).@)#5 storeBuffer_write:if:write_mem(storeBuffer_b:rsc(5)(0).@)#5 storeBuffer_write:else:if:write_mem(storeBuffer_r:rsc(1)(0).@)#1 storeBuffer_write:else:if:write_mem(storeBuffer_b:rsc(1)(0).@)#1 storeBuffer_write:else:if:write_mem(storeBuffer_r:rsc(2)(0).@)#2 storeBuffer_write:else:if:write_mem(storeBuffer_b:rsc(2)(0).@)#2 storeBuffer_write:else:if:write_mem(storeBuffer_r:rsc(3)(0).@)#3 storeBuffer_write:else:if:write_mem(storeBuffer_b:rsc(3)(0).@)#3 storeBuffer_write:else:if:write_mem(storeBuffer_r:rsc(4)(0).@)#4 storeBuffer_write:else:if:write_mem(storeBuffer_b:rsc(4)(0).@)#4 storeBuffer_write:else:if:write_mem(storeBuffer_r:rsc(5)(0).@)#5 storeBuffer_write:else:if:write_mem(storeBuffer_b:rsc(5)(0).@)#5 storeBuffer_write:else:else:write_mem(storeBuffer_r:rsc(1)(0).@)#6 storeBuffer_write:else:else:write_mem(storeBuffer_b:rsc(1)(0).@)#6 storeBuffer_write:else:else:write_mem(storeBuffer_b:rsc(2)(0).@)#6 storeBuffer_write:else:else:write_mem(storeBuffer_r:rsc(2)(0).@)#6 storeBuffer_write:else:else:write_mem(storeBuffer_r:rsc(3)(0).@)#6 storeBuffer_write:else:else:write_mem(storeBuffer_b:rsc(3)(0).@)#6 storeBuffer_write:else:else:write_mem(storeBuffer_r:rsc(5)(0).@)#6 storeBuffer_write:else:else:write_mem(storeBuffer_r:rsc(4)(0).@)#6 storeBuffer_write:else:else:write_mem(storeBuffer_b:rsc(5)(0).@)#6 storeBuffer_write:else:else:write_mem(storeBuffer_b:rsc(4)(0).@)#6}
directive set /cac/core/storeWindow_in:read_mem(storeBuffer_r:rsc(3)(0).@)#2 -IGNORE_DEPENDENCY_FROM {linebuffer_read:write_mem(lineBuffer:rsc(0)(0).@) linebuffer_read:write_mem(lineBuffer:rsc(1)(0).@)#1 linebuffer_read:write_mem(lineBuffer:rsc(2)(0).@)#2 linebuffer_read:write_mem(lineBuffer:rsc(3)(0).@)#3 linebuffer_read:write_mem(lineBuffer:rsc(4)(0).@)#4 cac_col:if:write_mem(lineBuffer:rsc(5)(0).@) storeBuffer_write:if:write_mem(storeBuffer_r:rsc(1)(0).@)#1 storeBuffer_write:if:write_mem(storeBuffer_b:rsc(1)(0).@)#1 storeBuffer_write:if:write_mem(storeBuffer_r:rsc(2)(0).@)#2 storeBuffer_write:if:write_mem(storeBuffer_b:rsc(2)(0).@)#2 storeBuffer_write:if:write_mem(storeBuffer_r:rsc(3)(0).@)#3 storeBuffer_write:if:write_mem(storeBuffer_b:rsc(3)(0).@)#3 storeBuffer_write:if:write_mem(storeBuffer_r:rsc(4)(0).@)#4 storeBuffer_write:if:write_mem(storeBuffer_b:rsc(4)(0).@)#4 storeBuffer_write:if:write_mem(storeBuffer_r:rsc(5)(0).@)#5 storeBuffer_write:if:write_mem(storeBuffer_b:rsc(5)(0).@)#5 storeBuffer_write:else:if:write_mem(storeBuffer_r:rsc(1)(0).@)#1 storeBuffer_write:else:if:write_mem(storeBuffer_b:rsc(1)(0).@)#1 storeBuffer_write:else:if:write_mem(storeBuffer_r:rsc(2)(0).@)#2 storeBuffer_write:else:if:write_mem(storeBuffer_b:rsc(2)(0).@)#2 storeBuffer_write:else:if:write_mem(storeBuffer_r:rsc(3)(0).@)#3 storeBuffer_write:else:if:write_mem(storeBuffer_b:rsc(3)(0).@)#3 storeBuffer_write:else:if:write_mem(storeBuffer_r:rsc(4)(0).@)#4 storeBuffer_write:else:if:write_mem(storeBuffer_b:rsc(4)(0).@)#4 storeBuffer_write:else:if:write_mem(storeBuffer_r:rsc(5)(0).@)#5 storeBuffer_write:else:if:write_mem(storeBuffer_b:rsc(5)(0).@)#5 storeBuffer_write:else:else:write_mem(storeBuffer_r:rsc(1)(0).@)#6 storeBuffer_write:else:else:write_mem(storeBuffer_b:rsc(1)(0).@)#6 storeBuffer_write:else:else:write_mem(storeBuffer_b:rsc(2)(0).@)#6 storeBuffer_write:else:else:write_mem(storeBuffer_r:rsc(2)(0).@)#6 storeBuffer_write:else:else:write_mem(storeBuffer_r:rsc(3)(0).@)#6 storeBuffer_write:else:else:write_mem(storeBuffer_b:rsc(3)(0).@)#6 storeBuffer_write:else:else:write_mem(storeBuffer_r:rsc(5)(0).@)#6 storeBuffer_write:else:else:write_mem(storeBuffer_r:rsc(4)(0).@)#6 storeBuffer_write:else:else:write_mem(storeBuffer_b:rsc(5)(0).@)#6 storeBuffer_write:else:else:write_mem(storeBuffer_b:rsc(4)(0).@)#6}
directive set /cac/core/storeWindow_in:read_mem(storeBuffer_b:rsc(3)(0).@)#2 -IGNORE_DEPENDENCY_FROM {linebuffer_read:write_mem(lineBuffer:rsc(0)(0).@) linebuffer_read:write_mem(lineBuffer:rsc(1)(0).@)#1 linebuffer_read:write_mem(lineBuffer:rsc(2)(0).@)#2 linebuffer_read:write_mem(lineBuffer:rsc(3)(0).@)#3 linebuffer_read:write_mem(lineBuffer:rsc(4)(0).@)#4 cac_col:if:write_mem(lineBuffer:rsc(5)(0).@) storeBuffer_write:if:write_mem(storeBuffer_r:rsc(1)(0).@)#1 storeBuffer_write:if:write_mem(storeBuffer_b:rsc(1)(0).@)#1 storeBuffer_write:if:write_mem(storeBuffer_r:rsc(2)(0).@)#2 storeBuffer_write:if:write_mem(storeBuffer_b:rsc(2)(0).@)#2 storeBuffer_write:if:write_mem(storeBuffer_r:rsc(3)(0).@)#3 storeBuffer_write:if:write_mem(storeBuffer_b:rsc(3)(0).@)#3 storeBuffer_write:if:write_mem(storeBuffer_r:rsc(4)(0).@)#4 storeBuffer_write:if:write_mem(storeBuffer_b:rsc(4)(0).@)#4 storeBuffer_write:if:write_mem(storeBuffer_r:rsc(5)(0).@)#5 storeBuffer_write:if:write_mem(storeBuffer_b:rsc(5)(0).@)#5 storeBuffer_write:else:if:write_mem(storeBuffer_r:rsc(1)(0).@)#1 storeBuffer_write:else:if:write_mem(storeBuffer_b:rsc(1)(0).@)#1 storeBuffer_write:else:if:write_mem(storeBuffer_r:rsc(2)(0).@)#2 storeBuffer_write:else:if:write_mem(storeBuffer_b:rsc(2)(0).@)#2 storeBuffer_write:else:if:write_mem(storeBuffer_r:rsc(3)(0).@)#3 storeBuffer_write:else:if:write_mem(storeBuffer_b:rsc(3)(0).@)#3 storeBuffer_write:else:if:write_mem(storeBuffer_r:rsc(4)(0).@)#4 storeBuffer_write:else:if:write_mem(storeBuffer_b:rsc(4)(0).@)#4 storeBuffer_write:else:if:write_mem(storeBuffer_r:rsc(5)(0).@)#5 storeBuffer_write:else:if:write_mem(storeBuffer_b:rsc(5)(0).@)#5 storeBuffer_write:else:else:write_mem(storeBuffer_r:rsc(1)(0).@)#6 storeBuffer_write:else:else:write_mem(storeBuffer_b:rsc(1)(0).@)#6 storeBuffer_write:else:else:write_mem(storeBuffer_b:rsc(2)(0).@)#6 storeBuffer_write:else:else:write_mem(storeBuffer_r:rsc(2)(0).@)#6 storeBuffer_write:else:else:write_mem(storeBuffer_r:rsc(3)(0).@)#6 storeBuffer_write:else:else:write_mem(storeBuffer_b:rsc(3)(0).@)#6 storeBuffer_write:else:else:write_mem(storeBuffer_r:rsc(5)(0).@)#6 storeBuffer_write:else:else:write_mem(storeBuffer_r:rsc(4)(0).@)#6 storeBuffer_write:else:else:write_mem(storeBuffer_b:rsc(5)(0).@)#6 storeBuffer_write:else:else:write_mem(storeBuffer_b:rsc(4)(0).@)#6}
directive set /cac/core/storeWindow_in:read_mem(storeBuffer_r:rsc(4)(0).@)#3 -IGNORE_DEPENDENCY_FROM {linebuffer_read:write_mem(lineBuffer:rsc(0)(0).@) linebuffer_read:write_mem(lineBuffer:rsc(1)(0).@)#1 linebuffer_read:write_mem(lineBuffer:rsc(2)(0).@)#2 linebuffer_read:write_mem(lineBuffer:rsc(3)(0).@)#3 linebuffer_read:write_mem(lineBuffer:rsc(4)(0).@)#4 cac_col:if:write_mem(lineBuffer:rsc(5)(0).@) storeBuffer_write:if:write_mem(storeBuffer_r:rsc(1)(0).@)#1 storeBuffer_write:if:write_mem(storeBuffer_b:rsc(1)(0).@)#1 storeBuffer_write:if:write_mem(storeBuffer_r:rsc(2)(0).@)#2 storeBuffer_write:if:write_mem(storeBuffer_b:rsc(2)(0).@)#2 storeBuffer_write:if:write_mem(storeBuffer_r:rsc(3)(0).@)#3 storeBuffer_write:if:write_mem(storeBuffer_b:rsc(3)(0).@)#3 storeBuffer_write:if:write_mem(storeBuffer_r:rsc(4)(0).@)#4 storeBuffer_write:if:write_mem(storeBuffer_b:rsc(4)(0).@)#4 storeBuffer_write:if:write_mem(storeBuffer_r:rsc(5)(0).@)#5 storeBuffer_write:if:write_mem(storeBuffer_b:rsc(5)(0).@)#5 storeBuffer_write:else:if:write_mem(storeBuffer_r:rsc(1)(0).@)#1 storeBuffer_write:else:if:write_mem(storeBuffer_b:rsc(1)(0).@)#1 storeBuffer_write:else:if:write_mem(storeBuffer_r:rsc(2)(0).@)#2 storeBuffer_write:else:if:write_mem(storeBuffer_b:rsc(2)(0).@)#2 storeBuffer_write:else:if:write_mem(storeBuffer_r:rsc(3)(0).@)#3 storeBuffer_write:else:if:write_mem(storeBuffer_b:rsc(3)(0).@)#3 storeBuffer_write:else:if:write_mem(storeBuffer_r:rsc(4)(0).@)#4 storeBuffer_write:else:if:write_mem(storeBuffer_b:rsc(4)(0).@)#4 storeBuffer_write:else:if:write_mem(storeBuffer_r:rsc(5)(0).@)#5 storeBuffer_write:else:if:write_mem(storeBuffer_b:rsc(5)(0).@)#5 storeBuffer_write:else:else:write_mem(storeBuffer_r:rsc(1)(0).@)#6 storeBuffer_write:else:else:write_mem(storeBuffer_b:rsc(1)(0).@)#6 storeBuffer_write:else:else:write_mem(storeBuffer_b:rsc(2)(0).@)#6 storeBuffer_write:else:else:write_mem(storeBuffer_r:rsc(2)(0).@)#6 storeBuffer_write:else:else:write_mem(storeBuffer_r:rsc(3)(0).@)#6 storeBuffer_write:else:else:write_mem(storeBuffer_b:rsc(3)(0).@)#6 storeBuffer_write:else:else:write_mem(storeBuffer_r:rsc(5)(0).@)#6 storeBuffer_write:else:else:write_mem(storeBuffer_r:rsc(4)(0).@)#6 storeBuffer_write:else:else:write_mem(storeBuffer_b:rsc(5)(0).@)#6 storeBuffer_write:else:else:write_mem(storeBuffer_b:rsc(4)(0).@)#6}
directive set /cac/core/storeWindow_in:read_mem(storeBuffer_b:rsc(4)(0).@)#3 -IGNORE_DEPENDENCY_FROM {linebuffer_read:write_mem(lineBuffer:rsc(0)(0).@) linebuffer_read:write_mem(lineBuffer:rsc(1)(0).@)#1 linebuffer_read:write_mem(lineBuffer:rsc(2)(0).@)#2 linebuffer_read:write_mem(lineBuffer:rsc(3)(0).@)#3 linebuffer_read:write_mem(lineBuffer:rsc(4)(0).@)#4 cac_col:if:write_mem(lineBuffer:rsc(5)(0).@) storeBuffer_write:if:write_mem(storeBuffer_r:rsc(1)(0).@)#1 storeBuffer_write:if:write_mem(storeBuffer_b:rsc(1)(0).@)#1 storeBuffer_write:if:write_mem(storeBuffer_r:rsc(2)(0).@)#2 storeBuffer_write:if:write_mem(storeBuffer_b:rsc(2)(0).@)#2 storeBuffer_write:if:write_mem(storeBuffer_r:rsc(3)(0).@)#3 storeBuffer_write:if:write_mem(storeBuffer_b:rsc(3)(0).@)#3 storeBuffer_write:if:write_mem(storeBuffer_r:rsc(4)(0).@)#4 storeBuffer_write:if:write_mem(storeBuffer_b:rsc(4)(0).@)#4 storeBuffer_write:if:write_mem(storeBuffer_r:rsc(5)(0).@)#5 storeBuffer_write:if:write_mem(storeBuffer_b:rsc(5)(0).@)#5 storeBuffer_write:else:if:write_mem(storeBuffer_r:rsc(1)(0).@)#1 storeBuffer_write:else:if:write_mem(storeBuffer_b:rsc(1)(0).@)#1 storeBuffer_write:else:if:write_mem(storeBuffer_r:rsc(2)(0).@)#2 storeBuffer_write:else:if:write_mem(storeBuffer_b:rsc(2)(0).@)#2 storeBuffer_write:else:if:write_mem(storeBuffer_r:rsc(3)(0).@)#3 storeBuffer_write:else:if:write_mem(storeBuffer_b:rsc(3)(0).@)#3 storeBuffer_write:else:if:write_mem(storeBuffer_r:rsc(4)(0).@)#4 storeBuffer_write:else:if:write_mem(storeBuffer_b:rsc(4)(0).@)#4 storeBuffer_write:else:if:write_mem(storeBuffer_r:rsc(5)(0).@)#5 storeBuffer_write:else:if:write_mem(storeBuffer_b:rsc(5)(0).@)#5 storeBuffer_write:else:else:write_mem(storeBuffer_r:rsc(1)(0).@)#6 storeBuffer_write:else:else:write_mem(storeBuffer_b:rsc(1)(0).@)#6 storeBuffer_write:else:else:write_mem(storeBuffer_b:rsc(2)(0).@)#6 storeBuffer_write:else:else:write_mem(storeBuffer_r:rsc(2)(0).@)#6 storeBuffer_write:else:else:write_mem(storeBuffer_r:rsc(3)(0).@)#6 storeBuffer_write:else:else:write_mem(storeBuffer_b:rsc(3)(0).@)#6 storeBuffer_write:else:else:write_mem(storeBuffer_r:rsc(5)(0).@)#6 storeBuffer_write:else:else:write_mem(storeBuffer_r:rsc(4)(0).@)#6 storeBuffer_write:else:else:write_mem(storeBuffer_b:rsc(5)(0).@)#6 storeBuffer_write:else:else:write_mem(storeBuffer_b:rsc(4)(0).@)#6}
directive set /cac/core/storeWindow_in:read_mem(storeBuffer_r:rsc(5)(0).@)#4 -IGNORE_DEPENDENCY_FROM {linebuffer_read:write_mem(lineBuffer:rsc(0)(0).@) linebuffer_read:write_mem(lineBuffer:rsc(1)(0).@)#1 linebuffer_read:write_mem(lineBuffer:rsc(2)(0).@)#2 linebuffer_read:write_mem(lineBuffer:rsc(3)(0).@)#3 linebuffer_read:write_mem(lineBuffer:rsc(4)(0).@)#4 cac_col:if:write_mem(lineBuffer:rsc(5)(0).@) storeBuffer_write:if:write_mem(storeBuffer_r:rsc(1)(0).@)#1 storeBuffer_write:if:write_mem(storeBuffer_b:rsc(1)(0).@)#1 storeBuffer_write:if:write_mem(storeBuffer_r:rsc(2)(0).@)#2 storeBuffer_write:if:write_mem(storeBuffer_b:rsc(2)(0).@)#2 storeBuffer_write:if:write_mem(storeBuffer_r:rsc(3)(0).@)#3 storeBuffer_write:if:write_mem(storeBuffer_b:rsc(3)(0).@)#3 storeBuffer_write:if:write_mem(storeBuffer_r:rsc(4)(0).@)#4 storeBuffer_write:if:write_mem(storeBuffer_b:rsc(4)(0).@)#4 storeBuffer_write:if:write_mem(storeBuffer_r:rsc(5)(0).@)#5 storeBuffer_write:if:write_mem(storeBuffer_b:rsc(5)(0).@)#5 storeBuffer_write:else:if:write_mem(storeBuffer_r:rsc(1)(0).@)#1 storeBuffer_write:else:if:write_mem(storeBuffer_b:rsc(1)(0).@)#1 storeBuffer_write:else:if:write_mem(storeBuffer_r:rsc(2)(0).@)#2 storeBuffer_write:else:if:write_mem(storeBuffer_b:rsc(2)(0).@)#2 storeBuffer_write:else:if:write_mem(storeBuffer_r:rsc(3)(0).@)#3 storeBuffer_write:else:if:write_mem(storeBuffer_b:rsc(3)(0).@)#3 storeBuffer_write:else:if:write_mem(storeBuffer_r:rsc(4)(0).@)#4 storeBuffer_write:else:if:write_mem(storeBuffer_b:rsc(4)(0).@)#4 storeBuffer_write:else:if:write_mem(storeBuffer_r:rsc(5)(0).@)#5 storeBuffer_write:else:if:write_mem(storeBuffer_b:rsc(5)(0).@)#5 storeBuffer_write:else:else:write_mem(storeBuffer_r:rsc(1)(0).@)#6 storeBuffer_write:else:else:write_mem(storeBuffer_b:rsc(1)(0).@)#6 storeBuffer_write:else:else:write_mem(storeBuffer_b:rsc(2)(0).@)#6 storeBuffer_write:else:else:write_mem(storeBuffer_r:rsc(2)(0).@)#6 storeBuffer_write:else:else:write_mem(storeBuffer_r:rsc(3)(0).@)#6 storeBuffer_write:else:else:write_mem(storeBuffer_b:rsc(3)(0).@)#6 storeBuffer_write:else:else:write_mem(storeBuffer_r:rsc(5)(0).@)#6 storeBuffer_write:else:else:write_mem(storeBuffer_r:rsc(4)(0).@)#6 storeBuffer_write:else:else:write_mem(storeBuffer_b:rsc(5)(0).@)#6 storeBuffer_write:else:else:write_mem(storeBuffer_b:rsc(4)(0).@)#6}
directive set /cac/core/storeWindow_in:read_mem(storeBuffer_b:rsc(5)(0).@)#4 -IGNORE_DEPENDENCY_FROM {linebuffer_read:write_mem(lineBuffer:rsc(0)(0).@) linebuffer_read:write_mem(lineBuffer:rsc(1)(0).@)#1 linebuffer_read:write_mem(lineBuffer:rsc(2)(0).@)#2 linebuffer_read:write_mem(lineBuffer:rsc(3)(0).@)#3 linebuffer_read:write_mem(lineBuffer:rsc(4)(0).@)#4 cac_col:if:write_mem(lineBuffer:rsc(5)(0).@) storeBuffer_write:if:write_mem(storeBuffer_r:rsc(1)(0).@)#1 storeBuffer_write:if:write_mem(storeBuffer_b:rsc(1)(0).@)#1 storeBuffer_write:if:write_mem(storeBuffer_r:rsc(2)(0).@)#2 storeBuffer_write:if:write_mem(storeBuffer_b:rsc(2)(0).@)#2 storeBuffer_write:if:write_mem(storeBuffer_r:rsc(3)(0).@)#3 storeBuffer_write:if:write_mem(storeBuffer_b:rsc(3)(0).@)#3 storeBuffer_write:if:write_mem(storeBuffer_r:rsc(4)(0).@)#4 storeBuffer_write:if:write_mem(storeBuffer_b:rsc(4)(0).@)#4 storeBuffer_write:if:write_mem(storeBuffer_r:rsc(5)(0).@)#5 storeBuffer_write:if:write_mem(storeBuffer_b:rsc(5)(0).@)#5 storeBuffer_write:else:if:write_mem(storeBuffer_r:rsc(1)(0).@)#1 storeBuffer_write:else:if:write_mem(storeBuffer_b:rsc(1)(0).@)#1 storeBuffer_write:else:if:write_mem(storeBuffer_r:rsc(2)(0).@)#2 storeBuffer_write:else:if:write_mem(storeBuffer_b:rsc(2)(0).@)#2 storeBuffer_write:else:if:write_mem(storeBuffer_r:rsc(3)(0).@)#3 storeBuffer_write:else:if:write_mem(storeBuffer_b:rsc(3)(0).@)#3 storeBuffer_write:else:if:write_mem(storeBuffer_r:rsc(4)(0).@)#4 storeBuffer_write:else:if:write_mem(storeBuffer_b:rsc(4)(0).@)#4 storeBuffer_write:else:if:write_mem(storeBuffer_r:rsc(5)(0).@)#5 storeBuffer_write:else:if:write_mem(storeBuffer_b:rsc(5)(0).@)#5 storeBuffer_write:else:else:write_mem(storeBuffer_r:rsc(1)(0).@)#6 storeBuffer_write:else:else:write_mem(storeBuffer_b:rsc(1)(0).@)#6 storeBuffer_write:else:else:write_mem(storeBuffer_b:rsc(2)(0).@)#6 storeBuffer_write:else:else:write_mem(storeBuffer_r:rsc(2)(0).@)#6 storeBuffer_write:else:else:write_mem(storeBuffer_r:rsc(3)(0).@)#6 storeBuffer_write:else:else:write_mem(storeBuffer_b:rsc(3)(0).@)#6 storeBuffer_write:else:else:write_mem(storeBuffer_r:rsc(5)(0).@)#6 storeBuffer_write:else:else:write_mem(storeBuffer_r:rsc(4)(0).@)#6 storeBuffer_write:else:else:write_mem(storeBuffer_b:rsc(5)(0).@)#6 storeBuffer_write:else:else:write_mem(storeBuffer_b:rsc(4)(0).@)#6}
directive set /cac/core/rgbWindow_read:read_mem(lineBuffer:rsc(1)(0).@) -IGNORE_DEPENDENCY_FROM {linebuffer_read:write_mem(lineBuffer:rsc(0)(0).@) linebuffer_read:write_mem(lineBuffer:rsc(1)(0).@)#1 linebuffer_read:write_mem(lineBuffer:rsc(2)(0).@)#2 linebuffer_read:write_mem(lineBuffer:rsc(3)(0).@)#3 linebuffer_read:write_mem(lineBuffer:rsc(4)(0).@)#4 cac_col:if:write_mem(lineBuffer:rsc(5)(0).@) storeBuffer_write:if:write_mem(storeBuffer_r:rsc(1)(0).@)#1 storeBuffer_write:if:write_mem(storeBuffer_b:rsc(1)(0).@)#1 storeBuffer_write:if:write_mem(storeBuffer_r:rsc(2)(0).@)#2 storeBuffer_write:if:write_mem(storeBuffer_b:rsc(2)(0).@)#2 storeBuffer_write:if:write_mem(storeBuffer_r:rsc(3)(0).@)#3 storeBuffer_write:if:write_mem(storeBuffer_b:rsc(3)(0).@)#3 storeBuffer_write:if:write_mem(storeBuffer_r:rsc(4)(0).@)#4 storeBuffer_write:if:write_mem(storeBuffer_b:rsc(4)(0).@)#4 storeBuffer_write:if:write_mem(storeBuffer_r:rsc(5)(0).@)#5 storeBuffer_write:if:write_mem(storeBuffer_b:rsc(5)(0).@)#5 storeBuffer_write:else:if:write_mem(storeBuffer_r:rsc(1)(0).@)#1 storeBuffer_write:else:if:write_mem(storeBuffer_b:rsc(1)(0).@)#1 storeBuffer_write:else:if:write_mem(storeBuffer_r:rsc(2)(0).@)#2 storeBuffer_write:else:if:write_mem(storeBuffer_b:rsc(2)(0).@)#2 storeBuffer_write:else:if:write_mem(storeBuffer_r:rsc(3)(0).@)#3 storeBuffer_write:else:if:write_mem(storeBuffer_b:rsc(3)(0).@)#3 storeBuffer_write:else:if:write_mem(storeBuffer_r:rsc(4)(0).@)#4 storeBuffer_write:else:if:write_mem(storeBuffer_b:rsc(4)(0).@)#4 storeBuffer_write:else:if:write_mem(storeBuffer_r:rsc(5)(0).@)#5 storeBuffer_write:else:if:write_mem(storeBuffer_b:rsc(5)(0).@)#5 storeBuffer_write:else:else:write_mem(storeBuffer_r:rsc(1)(0).@)#6 storeBuffer_write:else:else:write_mem(storeBuffer_b:rsc(1)(0).@)#6 storeBuffer_write:else:else:write_mem(storeBuffer_b:rsc(2)(0).@)#6 storeBuffer_write:else:else:write_mem(storeBuffer_r:rsc(2)(0).@)#6 storeBuffer_write:else:else:write_mem(storeBuffer_r:rsc(3)(0).@)#6 storeBuffer_write:else:else:write_mem(storeBuffer_b:rsc(3)(0).@)#6 storeBuffer_write:else:else:write_mem(storeBuffer_r:rsc(5)(0).@)#6 storeBuffer_write:else:else:write_mem(storeBuffer_r:rsc(4)(0).@)#6 storeBuffer_write:else:else:write_mem(storeBuffer_b:rsc(5)(0).@)#6 storeBuffer_write:else:else:write_mem(storeBuffer_b:rsc(4)(0).@)#6}
directive set /cac/core/rgbWindow_read:read_mem(lineBuffer:rsc(2)(0).@)#1 -IGNORE_DEPENDENCY_FROM {linebuffer_read:write_mem(lineBuffer:rsc(0)(0).@) linebuffer_read:write_mem(lineBuffer:rsc(1)(0).@)#1 linebuffer_read:write_mem(lineBuffer:rsc(2)(0).@)#2 linebuffer_read:write_mem(lineBuffer:rsc(3)(0).@)#3 linebuffer_read:write_mem(lineBuffer:rsc(4)(0).@)#4 cac_col:if:write_mem(lineBuffer:rsc(5)(0).@) storeBuffer_write:if:write_mem(storeBuffer_r:rsc(1)(0).@)#1 storeBuffer_write:if:write_mem(storeBuffer_b:rsc(1)(0).@)#1 storeBuffer_write:if:write_mem(storeBuffer_r:rsc(2)(0).@)#2 storeBuffer_write:if:write_mem(storeBuffer_b:rsc(2)(0).@)#2 storeBuffer_write:if:write_mem(storeBuffer_r:rsc(3)(0).@)#3 storeBuffer_write:if:write_mem(storeBuffer_b:rsc(3)(0).@)#3 storeBuffer_write:if:write_mem(storeBuffer_r:rsc(4)(0).@)#4 storeBuffer_write:if:write_mem(storeBuffer_b:rsc(4)(0).@)#4 storeBuffer_write:if:write_mem(storeBuffer_r:rsc(5)(0).@)#5 storeBuffer_write:if:write_mem(storeBuffer_b:rsc(5)(0).@)#5 storeBuffer_write:else:if:write_mem(storeBuffer_r:rsc(1)(0).@)#1 storeBuffer_write:else:if:write_mem(storeBuffer_b:rsc(1)(0).@)#1 storeBuffer_write:else:if:write_mem(storeBuffer_r:rsc(2)(0).@)#2 storeBuffer_write:else:if:write_mem(storeBuffer_b:rsc(2)(0).@)#2 storeBuffer_write:else:if:write_mem(storeBuffer_r:rsc(3)(0).@)#3 storeBuffer_write:else:if:write_mem(storeBuffer_b:rsc(3)(0).@)#3 storeBuffer_write:else:if:write_mem(storeBuffer_r:rsc(4)(0).@)#4 storeBuffer_write:else:if:write_mem(storeBuffer_b:rsc(4)(0).@)#4 storeBuffer_write:else:if:write_mem(storeBuffer_r:rsc(5)(0).@)#5 storeBuffer_write:else:if:write_mem(storeBuffer_b:rsc(5)(0).@)#5 storeBuffer_write:else:else:write_mem(storeBuffer_r:rsc(1)(0).@)#6 storeBuffer_write:else:else:write_mem(storeBuffer_b:rsc(1)(0).@)#6 storeBuffer_write:else:else:write_mem(storeBuffer_b:rsc(2)(0).@)#6 storeBuffer_write:else:else:write_mem(storeBuffer_r:rsc(2)(0).@)#6 storeBuffer_write:else:else:write_mem(storeBuffer_r:rsc(3)(0).@)#6 storeBuffer_write:else:else:write_mem(storeBuffer_b:rsc(3)(0).@)#6 storeBuffer_write:else:else:write_mem(storeBuffer_r:rsc(5)(0).@)#6 storeBuffer_write:else:else:write_mem(storeBuffer_r:rsc(4)(0).@)#6 storeBuffer_write:else:else:write_mem(storeBuffer_b:rsc(5)(0).@)#6 storeBuffer_write:else:else:write_mem(storeBuffer_b:rsc(4)(0).@)#6}
directive set /cac/core/rgbWindow_read:read_mem(lineBuffer:rsc(3)(0).@)#2 -IGNORE_DEPENDENCY_FROM {linebuffer_read:write_mem(lineBuffer:rsc(0)(0).@) linebuffer_read:write_mem(lineBuffer:rsc(1)(0).@)#1 linebuffer_read:write_mem(lineBuffer:rsc(2)(0).@)#2 linebuffer_read:write_mem(lineBuffer:rsc(3)(0).@)#3 linebuffer_read:write_mem(lineBuffer:rsc(4)(0).@)#4 cac_col:if:write_mem(lineBuffer:rsc(5)(0).@) storeBuffer_write:if:write_mem(storeBuffer_r:rsc(1)(0).@)#1 storeBuffer_write:if:write_mem(storeBuffer_b:rsc(1)(0).@)#1 storeBuffer_write:if:write_mem(storeBuffer_r:rsc(2)(0).@)#2 storeBuffer_write:if:write_mem(storeBuffer_b:rsc(2)(0).@)#2 storeBuffer_write:if:write_mem(storeBuffer_r:rsc(3)(0).@)#3 storeBuffer_write:if:write_mem(storeBuffer_b:rsc(3)(0).@)#3 storeBuffer_write:if:write_mem(storeBuffer_r:rsc(4)(0).@)#4 storeBuffer_write:if:write_mem(storeBuffer_b:rsc(4)(0).@)#4 storeBuffer_write:if:write_mem(storeBuffer_r:rsc(5)(0).@)#5 storeBuffer_write:if:write_mem(storeBuffer_b:rsc(5)(0).@)#5 storeBuffer_write:else:if:write_mem(storeBuffer_r:rsc(1)(0).@)#1 storeBuffer_write:else:if:write_mem(storeBuffer_b:rsc(1)(0).@)#1 storeBuffer_write:else:if:write_mem(storeBuffer_r:rsc(2)(0).@)#2 storeBuffer_write:else:if:write_mem(storeBuffer_b:rsc(2)(0).@)#2 storeBuffer_write:else:if:write_mem(storeBuffer_r:rsc(3)(0).@)#3 storeBuffer_write:else:if:write_mem(storeBuffer_b:rsc(3)(0).@)#3 storeBuffer_write:else:if:write_mem(storeBuffer_r:rsc(4)(0).@)#4 storeBuffer_write:else:if:write_mem(storeBuffer_b:rsc(4)(0).@)#4 storeBuffer_write:else:if:write_mem(storeBuffer_r:rsc(5)(0).@)#5 storeBuffer_write:else:if:write_mem(storeBuffer_b:rsc(5)(0).@)#5 storeBuffer_write:else:else:write_mem(storeBuffer_r:rsc(1)(0).@)#6 storeBuffer_write:else:else:write_mem(storeBuffer_b:rsc(1)(0).@)#6 storeBuffer_write:else:else:write_mem(storeBuffer_b:rsc(2)(0).@)#6 storeBuffer_write:else:else:write_mem(storeBuffer_r:rsc(2)(0).@)#6 storeBuffer_write:else:else:write_mem(storeBuffer_r:rsc(3)(0).@)#6 storeBuffer_write:else:else:write_mem(storeBuffer_b:rsc(3)(0).@)#6 storeBuffer_write:else:else:write_mem(storeBuffer_r:rsc(5)(0).@)#6 storeBuffer_write:else:else:write_mem(storeBuffer_r:rsc(4)(0).@)#6 storeBuffer_write:else:else:write_mem(storeBuffer_b:rsc(5)(0).@)#6 storeBuffer_write:else:else:write_mem(storeBuffer_b:rsc(4)(0).@)#6}
directive set /cac/core/rgbWindow_read:read_mem(lineBuffer:rsc(4)(0).@)#3 -IGNORE_DEPENDENCY_FROM {linebuffer_read:write_mem(lineBuffer:rsc(0)(0).@) linebuffer_read:write_mem(lineBuffer:rsc(1)(0).@)#1 linebuffer_read:write_mem(lineBuffer:rsc(2)(0).@)#2 linebuffer_read:write_mem(lineBuffer:rsc(3)(0).@)#3 linebuffer_read:write_mem(lineBuffer:rsc(4)(0).@)#4 cac_col:if:write_mem(lineBuffer:rsc(5)(0).@) storeBuffer_write:if:write_mem(storeBuffer_r:rsc(1)(0).@)#1 storeBuffer_write:if:write_mem(storeBuffer_b:rsc(1)(0).@)#1 storeBuffer_write:if:write_mem(storeBuffer_r:rsc(2)(0).@)#2 storeBuffer_write:if:write_mem(storeBuffer_b:rsc(2)(0).@)#2 storeBuffer_write:if:write_mem(storeBuffer_r:rsc(3)(0).@)#3 storeBuffer_write:if:write_mem(storeBuffer_b:rsc(3)(0).@)#3 storeBuffer_write:if:write_mem(storeBuffer_r:rsc(4)(0).@)#4 storeBuffer_write:if:write_mem(storeBuffer_b:rsc(4)(0).@)#4 storeBuffer_write:if:write_mem(storeBuffer_r:rsc(5)(0).@)#5 storeBuffer_write:if:write_mem(storeBuffer_b:rsc(5)(0).@)#5 storeBuffer_write:else:if:write_mem(storeBuffer_r:rsc(1)(0).@)#1 storeBuffer_write:else:if:write_mem(storeBuffer_b:rsc(1)(0).@)#1 storeBuffer_write:else:if:write_mem(storeBuffer_r:rsc(2)(0).@)#2 storeBuffer_write:else:if:write_mem(storeBuffer_b:rsc(2)(0).@)#2 storeBuffer_write:else:if:write_mem(storeBuffer_r:rsc(3)(0).@)#3 storeBuffer_write:else:if:write_mem(storeBuffer_b:rsc(3)(0).@)#3 storeBuffer_write:else:if:write_mem(storeBuffer_r:rsc(4)(0).@)#4 storeBuffer_write:else:if:write_mem(storeBuffer_b:rsc(4)(0).@)#4 storeBuffer_write:else:if:write_mem(storeBuffer_r:rsc(5)(0).@)#5 storeBuffer_write:else:if:write_mem(storeBuffer_b:rsc(5)(0).@)#5 storeBuffer_write:else:else:write_mem(storeBuffer_r:rsc(1)(0).@)#6 storeBuffer_write:else:else:write_mem(storeBuffer_b:rsc(1)(0).@)#6 storeBuffer_write:else:else:write_mem(storeBuffer_b:rsc(2)(0).@)#6 storeBuffer_write:else:else:write_mem(storeBuffer_r:rsc(2)(0).@)#6 storeBuffer_write:else:else:write_mem(storeBuffer_r:rsc(3)(0).@)#6 storeBuffer_write:else:else:write_mem(storeBuffer_b:rsc(3)(0).@)#6 storeBuffer_write:else:else:write_mem(storeBuffer_r:rsc(5)(0).@)#6 storeBuffer_write:else:else:write_mem(storeBuffer_r:rsc(4)(0).@)#6 storeBuffer_write:else:else:write_mem(storeBuffer_b:rsc(5)(0).@)#6 storeBuffer_write:else:else:write_mem(storeBuffer_b:rsc(4)(0).@)#6}
directive set /cac/core/rgbWindow_read:read_mem(lineBuffer:rsc(5)(0).@)#4 -IGNORE_DEPENDENCY_FROM {linebuffer_read:write_mem(lineBuffer:rsc(0)(0).@) linebuffer_read:write_mem(lineBuffer:rsc(1)(0).@)#1 linebuffer_read:write_mem(lineBuffer:rsc(2)(0).@)#2 linebuffer_read:write_mem(lineBuffer:rsc(3)(0).@)#3 linebuffer_read:write_mem(lineBuffer:rsc(4)(0).@)#4 cac_col:if:write_mem(lineBuffer:rsc(5)(0).@) storeBuffer_write:if:write_mem(storeBuffer_r:rsc(1)(0).@)#1 storeBuffer_write:if:write_mem(storeBuffer_b:rsc(1)(0).@)#1 storeBuffer_write:if:write_mem(storeBuffer_r:rsc(2)(0).@)#2 storeBuffer_write:if:write_mem(storeBuffer_b:rsc(2)(0).@)#2 storeBuffer_write:if:write_mem(storeBuffer_r:rsc(3)(0).@)#3 storeBuffer_write:if:write_mem(storeBuffer_b:rsc(3)(0).@)#3 storeBuffer_write:if:write_mem(storeBuffer_r:rsc(4)(0).@)#4 storeBuffer_write:if:write_mem(storeBuffer_b:rsc(4)(0).@)#4 storeBuffer_write:if:write_mem(storeBuffer_r:rsc(5)(0).@)#5 storeBuffer_write:if:write_mem(storeBuffer_b:rsc(5)(0).@)#5 storeBuffer_write:else:if:write_mem(storeBuffer_r:rsc(1)(0).@)#1 storeBuffer_write:else:if:write_mem(storeBuffer_b:rsc(1)(0).@)#1 storeBuffer_write:else:if:write_mem(storeBuffer_r:rsc(2)(0).@)#2 storeBuffer_write:else:if:write_mem(storeBuffer_b:rsc(2)(0).@)#2 storeBuffer_write:else:if:write_mem(storeBuffer_r:rsc(3)(0).@)#3 storeBuffer_write:else:if:write_mem(storeBuffer_b:rsc(3)(0).@)#3 storeBuffer_write:else:if:write_mem(storeBuffer_r:rsc(4)(0).@)#4 storeBuffer_write:else:if:write_mem(storeBuffer_b:rsc(4)(0).@)#4 storeBuffer_write:else:if:write_mem(storeBuffer_r:rsc(5)(0).@)#5 storeBuffer_write:else:if:write_mem(storeBuffer_b:rsc(5)(0).@)#5 storeBuffer_write:else:else:write_mem(storeBuffer_r:rsc(1)(0).@)#6 storeBuffer_write:else:else:write_mem(storeBuffer_b:rsc(1)(0).@)#6 storeBuffer_write:else:else:write_mem(storeBuffer_b:rsc(2)(0).@)#6 storeBuffer_write:else:else:write_mem(storeBuffer_r:rsc(2)(0).@)#6 storeBuffer_write:else:else:write_mem(storeBuffer_r:rsc(3)(0).@)#6 storeBuffer_write:else:else:write_mem(storeBuffer_b:rsc(3)(0).@)#6 storeBuffer_write:else:else:write_mem(storeBuffer_r:rsc(5)(0).@)#6 storeBuffer_write:else:else:write_mem(storeBuffer_r:rsc(4)(0).@)#6 storeBuffer_write:else:else:write_mem(storeBuffer_b:rsc(5)(0).@)#6 storeBuffer_write:else:else:write_mem(storeBuffer_b:rsc(4)(0).@)#6}
directive set /cac/core/rgbWindow_read:read_mem(lineBuffer:rsc(0)(0).@)#5 -IGNORE_DEPENDENCY_FROM {linebuffer_read:write_mem(lineBuffer:rsc(0)(0).@) linebuffer_read:write_mem(lineBuffer:rsc(1)(0).@)#1 linebuffer_read:write_mem(lineBuffer:rsc(2)(0).@)#2 linebuffer_read:write_mem(lineBuffer:rsc(3)(0).@)#3 linebuffer_read:write_mem(lineBuffer:rsc(4)(0).@)#4 cac_col:if:write_mem(lineBuffer:rsc(5)(0).@) storeBuffer_write:if:write_mem(storeBuffer_r:rsc(1)(0).@)#1 storeBuffer_write:if:write_mem(storeBuffer_b:rsc(1)(0).@)#1 storeBuffer_write:if:write_mem(storeBuffer_r:rsc(2)(0).@)#2 storeBuffer_write:if:write_mem(storeBuffer_b:rsc(2)(0).@)#2 storeBuffer_write:if:write_mem(storeBuffer_r:rsc(3)(0).@)#3 storeBuffer_write:if:write_mem(storeBuffer_b:rsc(3)(0).@)#3 storeBuffer_write:if:write_mem(storeBuffer_r:rsc(4)(0).@)#4 storeBuffer_write:if:write_mem(storeBuffer_b:rsc(4)(0).@)#4 storeBuffer_write:if:write_mem(storeBuffer_r:rsc(5)(0).@)#5 storeBuffer_write:if:write_mem(storeBuffer_b:rsc(5)(0).@)#5 storeBuffer_write:else:if:write_mem(storeBuffer_r:rsc(1)(0).@)#1 storeBuffer_write:else:if:write_mem(storeBuffer_b:rsc(1)(0).@)#1 storeBuffer_write:else:if:write_mem(storeBuffer_r:rsc(2)(0).@)#2 storeBuffer_write:else:if:write_mem(storeBuffer_b:rsc(2)(0).@)#2 storeBuffer_write:else:if:write_mem(storeBuffer_r:rsc(3)(0).@)#3 storeBuffer_write:else:if:write_mem(storeBuffer_b:rsc(3)(0).@)#3 storeBuffer_write:else:if:write_mem(storeBuffer_r:rsc(4)(0).@)#4 storeBuffer_write:else:if:write_mem(storeBuffer_b:rsc(4)(0).@)#4 storeBuffer_write:else:if:write_mem(storeBuffer_r:rsc(5)(0).@)#5 storeBuffer_write:else:if:write_mem(storeBuffer_b:rsc(5)(0).@)#5 storeBuffer_write:else:else:write_mem(storeBuffer_r:rsc(1)(0).@)#6 storeBuffer_write:else:else:write_mem(storeBuffer_b:rsc(1)(0).@)#6 storeBuffer_write:else:else:write_mem(storeBuffer_b:rsc(2)(0).@)#6 storeBuffer_write:else:else:write_mem(storeBuffer_r:rsc(2)(0).@)#6 storeBuffer_write:else:else:write_mem(storeBuffer_r:rsc(3)(0).@)#6 storeBuffer_write:else:else:write_mem(storeBuffer_b:rsc(3)(0).@)#6 storeBuffer_write:else:else:write_mem(storeBuffer_r:rsc(5)(0).@)#6 storeBuffer_write:else:else:write_mem(storeBuffer_r:rsc(4)(0).@)#6 storeBuffer_write:else:else:write_mem(storeBuffer_b:rsc(5)(0).@)#6 storeBuffer_write:else:else:write_mem(storeBuffer_b:rsc(4)(0).@)#6}
directive set /cac/core/addon_loop_2:for:read_mem(lineBuffer:rsc(1)(0).@) -IGNORE_DEPENDENCY_FROM {linebuffer_read:write_mem(lineBuffer:rsc(0)(0).@) linebuffer_read:write_mem(lineBuffer:rsc(1)(0).@)#1 linebuffer_read:write_mem(lineBuffer:rsc(2)(0).@)#2 linebuffer_read:write_mem(lineBuffer:rsc(3)(0).@)#3 linebuffer_read:write_mem(lineBuffer:rsc(4)(0).@)#4 cac_col:if:write_mem(lineBuffer:rsc(5)(0).@) storeBuffer_write:if:write_mem(storeBuffer_r:rsc(1)(0).@)#1 storeBuffer_write:if:write_mem(storeBuffer_b:rsc(1)(0).@)#1 storeBuffer_write:if:write_mem(storeBuffer_r:rsc(2)(0).@)#2 storeBuffer_write:if:write_mem(storeBuffer_b:rsc(2)(0).@)#2 storeBuffer_write:if:write_mem(storeBuffer_r:rsc(3)(0).@)#3 storeBuffer_write:if:write_mem(storeBuffer_b:rsc(3)(0).@)#3 storeBuffer_write:if:write_mem(storeBuffer_r:rsc(4)(0).@)#4 storeBuffer_write:if:write_mem(storeBuffer_b:rsc(4)(0).@)#4 storeBuffer_write:if:write_mem(storeBuffer_r:rsc(5)(0).@)#5 storeBuffer_write:if:write_mem(storeBuffer_b:rsc(5)(0).@)#5 storeBuffer_write:else:if:write_mem(storeBuffer_r:rsc(1)(0).@)#1 storeBuffer_write:else:if:write_mem(storeBuffer_b:rsc(1)(0).@)#1 storeBuffer_write:else:if:write_mem(storeBuffer_r:rsc(2)(0).@)#2 storeBuffer_write:else:if:write_mem(storeBuffer_b:rsc(2)(0).@)#2 storeBuffer_write:else:if:write_mem(storeBuffer_r:rsc(3)(0).@)#3 storeBuffer_write:else:if:write_mem(storeBuffer_b:rsc(3)(0).@)#3 storeBuffer_write:else:if:write_mem(storeBuffer_r:rsc(4)(0).@)#4 storeBuffer_write:else:if:write_mem(storeBuffer_b:rsc(4)(0).@)#4 storeBuffer_write:else:if:write_mem(storeBuffer_r:rsc(5)(0).@)#5 storeBuffer_write:else:if:write_mem(storeBuffer_b:rsc(5)(0).@)#5 storeBuffer_write:else:else:write_mem(storeBuffer_r:rsc(1)(0).@)#6 storeBuffer_write:else:else:write_mem(storeBuffer_b:rsc(1)(0).@)#6 storeBuffer_write:else:else:write_mem(storeBuffer_b:rsc(2)(0).@)#6 storeBuffer_write:else:else:write_mem(storeBuffer_r:rsc(2)(0).@)#6 storeBuffer_write:else:else:write_mem(storeBuffer_r:rsc(3)(0).@)#6 storeBuffer_write:else:else:write_mem(storeBuffer_b:rsc(3)(0).@)#6 storeBuffer_write:else:else:write_mem(storeBuffer_r:rsc(5)(0).@)#6 storeBuffer_write:else:else:write_mem(storeBuffer_r:rsc(4)(0).@)#6 storeBuffer_write:else:else:write_mem(storeBuffer_b:rsc(5)(0).@)#6 storeBuffer_write:else:else:write_mem(storeBuffer_b:rsc(4)(0).@)#6}
directive set /cac/core/addon_loop_2:for:read_mem(lineBuffer:rsc(2)(0).@) -IGNORE_DEPENDENCY_FROM {linebuffer_read:write_mem(lineBuffer:rsc(0)(0).@) linebuffer_read:write_mem(lineBuffer:rsc(1)(0).@)#1 linebuffer_read:write_mem(lineBuffer:rsc(2)(0).@)#2 linebuffer_read:write_mem(lineBuffer:rsc(3)(0).@)#3 linebuffer_read:write_mem(lineBuffer:rsc(4)(0).@)#4 cac_col:if:write_mem(lineBuffer:rsc(5)(0).@) storeBuffer_write:if:write_mem(storeBuffer_r:rsc(1)(0).@)#1 storeBuffer_write:if:write_mem(storeBuffer_b:rsc(1)(0).@)#1 storeBuffer_write:if:write_mem(storeBuffer_r:rsc(2)(0).@)#2 storeBuffer_write:if:write_mem(storeBuffer_b:rsc(2)(0).@)#2 storeBuffer_write:if:write_mem(storeBuffer_r:rsc(3)(0).@)#3 storeBuffer_write:if:write_mem(storeBuffer_b:rsc(3)(0).@)#3 storeBuffer_write:if:write_mem(storeBuffer_r:rsc(4)(0).@)#4 storeBuffer_write:if:write_mem(storeBuffer_b:rsc(4)(0).@)#4 storeBuffer_write:if:write_mem(storeBuffer_r:rsc(5)(0).@)#5 storeBuffer_write:if:write_mem(storeBuffer_b:rsc(5)(0).@)#5 storeBuffer_write:else:if:write_mem(storeBuffer_r:rsc(1)(0).@)#1 storeBuffer_write:else:if:write_mem(storeBuffer_b:rsc(1)(0).@)#1 storeBuffer_write:else:if:write_mem(storeBuffer_r:rsc(2)(0).@)#2 storeBuffer_write:else:if:write_mem(storeBuffer_b:rsc(2)(0).@)#2 storeBuffer_write:else:if:write_mem(storeBuffer_r:rsc(3)(0).@)#3 storeBuffer_write:else:if:write_mem(storeBuffer_b:rsc(3)(0).@)#3 storeBuffer_write:else:if:write_mem(storeBuffer_r:rsc(4)(0).@)#4 storeBuffer_write:else:if:write_mem(storeBuffer_b:rsc(4)(0).@)#4 storeBuffer_write:else:if:write_mem(storeBuffer_r:rsc(5)(0).@)#5 storeBuffer_write:else:if:write_mem(storeBuffer_b:rsc(5)(0).@)#5 storeBuffer_write:else:else:write_mem(storeBuffer_r:rsc(1)(0).@)#6 storeBuffer_write:else:else:write_mem(storeBuffer_b:rsc(1)(0).@)#6 storeBuffer_write:else:else:write_mem(storeBuffer_b:rsc(2)(0).@)#6 storeBuffer_write:else:else:write_mem(storeBuffer_r:rsc(2)(0).@)#6 storeBuffer_write:else:else:write_mem(storeBuffer_r:rsc(3)(0).@)#6 storeBuffer_write:else:else:write_mem(storeBuffer_b:rsc(3)(0).@)#6 storeBuffer_write:else:else:write_mem(storeBuffer_r:rsc(5)(0).@)#6 storeBuffer_write:else:else:write_mem(storeBuffer_r:rsc(4)(0).@)#6 storeBuffer_write:else:else:write_mem(storeBuffer_b:rsc(5)(0).@)#6 storeBuffer_write:else:else:write_mem(storeBuffer_b:rsc(4)(0).@)#6}
directive set /cac/core/addon_loop_2:for:read_mem(lineBuffer:rsc(3)(0).@) -IGNORE_DEPENDENCY_FROM {linebuffer_read:write_mem(lineBuffer:rsc(0)(0).@) linebuffer_read:write_mem(lineBuffer:rsc(1)(0).@)#1 linebuffer_read:write_mem(lineBuffer:rsc(2)(0).@)#2 linebuffer_read:write_mem(lineBuffer:rsc(3)(0).@)#3 linebuffer_read:write_mem(lineBuffer:rsc(4)(0).@)#4 cac_col:if:write_mem(lineBuffer:rsc(5)(0).@) storeBuffer_write:if:write_mem(storeBuffer_r:rsc(1)(0).@)#1 storeBuffer_write:if:write_mem(storeBuffer_b:rsc(1)(0).@)#1 storeBuffer_write:if:write_mem(storeBuffer_r:rsc(2)(0).@)#2 storeBuffer_write:if:write_mem(storeBuffer_b:rsc(2)(0).@)#2 storeBuffer_write:if:write_mem(storeBuffer_r:rsc(3)(0).@)#3 storeBuffer_write:if:write_mem(storeBuffer_b:rsc(3)(0).@)#3 storeBuffer_write:if:write_mem(storeBuffer_r:rsc(4)(0).@)#4 storeBuffer_write:if:write_mem(storeBuffer_b:rsc(4)(0).@)#4 storeBuffer_write:if:write_mem(storeBuffer_r:rsc(5)(0).@)#5 storeBuffer_write:if:write_mem(storeBuffer_b:rsc(5)(0).@)#5 storeBuffer_write:else:if:write_mem(storeBuffer_r:rsc(1)(0).@)#1 storeBuffer_write:else:if:write_mem(storeBuffer_b:rsc(1)(0).@)#1 storeBuffer_write:else:if:write_mem(storeBuffer_r:rsc(2)(0).@)#2 storeBuffer_write:else:if:write_mem(storeBuffer_b:rsc(2)(0).@)#2 storeBuffer_write:else:if:write_mem(storeBuffer_r:rsc(3)(0).@)#3 storeBuffer_write:else:if:write_mem(storeBuffer_b:rsc(3)(0).@)#3 storeBuffer_write:else:if:write_mem(storeBuffer_r:rsc(4)(0).@)#4 storeBuffer_write:else:if:write_mem(storeBuffer_b:rsc(4)(0).@)#4 storeBuffer_write:else:if:write_mem(storeBuffer_r:rsc(5)(0).@)#5 storeBuffer_write:else:if:write_mem(storeBuffer_b:rsc(5)(0).@)#5 storeBuffer_write:else:else:write_mem(storeBuffer_r:rsc(1)(0).@)#6 storeBuffer_write:else:else:write_mem(storeBuffer_b:rsc(1)(0).@)#6 storeBuffer_write:else:else:write_mem(storeBuffer_b:rsc(2)(0).@)#6 storeBuffer_write:else:else:write_mem(storeBuffer_r:rsc(2)(0).@)#6 storeBuffer_write:else:else:write_mem(storeBuffer_r:rsc(3)(0).@)#6 storeBuffer_write:else:else:write_mem(storeBuffer_b:rsc(3)(0).@)#6 storeBuffer_write:else:else:write_mem(storeBuffer_r:rsc(5)(0).@)#6 storeBuffer_write:else:else:write_mem(storeBuffer_r:rsc(4)(0).@)#6 storeBuffer_write:else:else:write_mem(storeBuffer_b:rsc(5)(0).@)#6 storeBuffer_write:else:else:write_mem(storeBuffer_b:rsc(4)(0).@)#6}
directive set /cac/core/addon_loop_2:for:read_mem(lineBuffer:rsc(4)(0).@) -IGNORE_DEPENDENCY_FROM {linebuffer_read:write_mem(lineBuffer:rsc(0)(0).@) linebuffer_read:write_mem(lineBuffer:rsc(1)(0).@)#1 linebuffer_read:write_mem(lineBuffer:rsc(2)(0).@)#2 linebuffer_read:write_mem(lineBuffer:rsc(3)(0).@)#3 linebuffer_read:write_mem(lineBuffer:rsc(4)(0).@)#4 cac_col:if:write_mem(lineBuffer:rsc(5)(0).@) storeBuffer_write:if:write_mem(storeBuffer_r:rsc(1)(0).@)#1 storeBuffer_write:if:write_mem(storeBuffer_b:rsc(1)(0).@)#1 storeBuffer_write:if:write_mem(storeBuffer_r:rsc(2)(0).@)#2 storeBuffer_write:if:write_mem(storeBuffer_b:rsc(2)(0).@)#2 storeBuffer_write:if:write_mem(storeBuffer_r:rsc(3)(0).@)#3 storeBuffer_write:if:write_mem(storeBuffer_b:rsc(3)(0).@)#3 storeBuffer_write:if:write_mem(storeBuffer_r:rsc(4)(0).@)#4 storeBuffer_write:if:write_mem(storeBuffer_b:rsc(4)(0).@)#4 storeBuffer_write:if:write_mem(storeBuffer_r:rsc(5)(0).@)#5 storeBuffer_write:if:write_mem(storeBuffer_b:rsc(5)(0).@)#5 storeBuffer_write:else:if:write_mem(storeBuffer_r:rsc(1)(0).@)#1 storeBuffer_write:else:if:write_mem(storeBuffer_b:rsc(1)(0).@)#1 storeBuffer_write:else:if:write_mem(storeBuffer_r:rsc(2)(0).@)#2 storeBuffer_write:else:if:write_mem(storeBuffer_b:rsc(2)(0).@)#2 storeBuffer_write:else:if:write_mem(storeBuffer_r:rsc(3)(0).@)#3 storeBuffer_write:else:if:write_mem(storeBuffer_b:rsc(3)(0).@)#3 storeBuffer_write:else:if:write_mem(storeBuffer_r:rsc(4)(0).@)#4 storeBuffer_write:else:if:write_mem(storeBuffer_b:rsc(4)(0).@)#4 storeBuffer_write:else:if:write_mem(storeBuffer_r:rsc(5)(0).@)#5 storeBuffer_write:else:if:write_mem(storeBuffer_b:rsc(5)(0).@)#5 storeBuffer_write:else:else:write_mem(storeBuffer_r:rsc(1)(0).@)#6 storeBuffer_write:else:else:write_mem(storeBuffer_b:rsc(1)(0).@)#6 storeBuffer_write:else:else:write_mem(storeBuffer_b:rsc(2)(0).@)#6 storeBuffer_write:else:else:write_mem(storeBuffer_r:rsc(2)(0).@)#6 storeBuffer_write:else:else:write_mem(storeBuffer_r:rsc(3)(0).@)#6 storeBuffer_write:else:else:write_mem(storeBuffer_b:rsc(3)(0).@)#6 storeBuffer_write:else:else:write_mem(storeBuffer_r:rsc(5)(0).@)#6 storeBuffer_write:else:else:write_mem(storeBuffer_r:rsc(4)(0).@)#6 storeBuffer_write:else:else:write_mem(storeBuffer_b:rsc(5)(0).@)#6 storeBuffer_write:else:else:write_mem(storeBuffer_b:rsc(4)(0).@)#6}
directive set /cac/core/addon_loop_2:for:read_mem(lineBuffer:rsc(5)(0).@) -IGNORE_DEPENDENCY_FROM {linebuffer_read:write_mem(lineBuffer:rsc(0)(0).@) linebuffer_read:write_mem(lineBuffer:rsc(1)(0).@)#1 linebuffer_read:write_mem(lineBuffer:rsc(2)(0).@)#2 linebuffer_read:write_mem(lineBuffer:rsc(3)(0).@)#3 linebuffer_read:write_mem(lineBuffer:rsc(4)(0).@)#4 cac_col:if:write_mem(lineBuffer:rsc(5)(0).@) storeBuffer_write:if:write_mem(storeBuffer_r:rsc(1)(0).@)#1 storeBuffer_write:if:write_mem(storeBuffer_b:rsc(1)(0).@)#1 storeBuffer_write:if:write_mem(storeBuffer_r:rsc(2)(0).@)#2 storeBuffer_write:if:write_mem(storeBuffer_b:rsc(2)(0).@)#2 storeBuffer_write:if:write_mem(storeBuffer_r:rsc(3)(0).@)#3 storeBuffer_write:if:write_mem(storeBuffer_b:rsc(3)(0).@)#3 storeBuffer_write:if:write_mem(storeBuffer_r:rsc(4)(0).@)#4 storeBuffer_write:if:write_mem(storeBuffer_b:rsc(4)(0).@)#4 storeBuffer_write:if:write_mem(storeBuffer_r:rsc(5)(0).@)#5 storeBuffer_write:if:write_mem(storeBuffer_b:rsc(5)(0).@)#5 storeBuffer_write:else:if:write_mem(storeBuffer_r:rsc(1)(0).@)#1 storeBuffer_write:else:if:write_mem(storeBuffer_b:rsc(1)(0).@)#1 storeBuffer_write:else:if:write_mem(storeBuffer_r:rsc(2)(0).@)#2 storeBuffer_write:else:if:write_mem(storeBuffer_b:rsc(2)(0).@)#2 storeBuffer_write:else:if:write_mem(storeBuffer_r:rsc(3)(0).@)#3 storeBuffer_write:else:if:write_mem(storeBuffer_b:rsc(3)(0).@)#3 storeBuffer_write:else:if:write_mem(storeBuffer_r:rsc(4)(0).@)#4 storeBuffer_write:else:if:write_mem(storeBuffer_b:rsc(4)(0).@)#4 storeBuffer_write:else:if:write_mem(storeBuffer_r:rsc(5)(0).@)#5 storeBuffer_write:else:if:write_mem(storeBuffer_b:rsc(5)(0).@)#5 storeBuffer_write:else:else:write_mem(storeBuffer_r:rsc(1)(0).@)#6 storeBuffer_write:else:else:write_mem(storeBuffer_b:rsc(1)(0).@)#6 storeBuffer_write:else:else:write_mem(storeBuffer_b:rsc(2)(0).@)#6 storeBuffer_write:else:else:write_mem(storeBuffer_r:rsc(2)(0).@)#6 storeBuffer_write:else:else:write_mem(storeBuffer_r:rsc(3)(0).@)#6 storeBuffer_write:else:else:write_mem(storeBuffer_b:rsc(3)(0).@)#6 storeBuffer_write:else:else:write_mem(storeBuffer_r:rsc(5)(0).@)#6 storeBuffer_write:else:else:write_mem(storeBuffer_r:rsc(4)(0).@)#6 storeBuffer_write:else:else:write_mem(storeBuffer_b:rsc(5)(0).@)#6 storeBuffer_write:else:else:write_mem(storeBuffer_b:rsc(4)(0).@)#6}
go allocate
go extract
//  Catapult Prime Synthesis 2022.1/981271 (Production Release) Thu Feb 10 22:05:20 PST 2022
//
//          Copyright (c) Siemens EDA, 1996-2022, All Rights Reserved.
//                        UNPUBLISHED, LICENSED SOFTWARE.
//             CONFIDENTIAL AND PROPRIETARY INFORMATION WHICH IS THE
//                   PROPERTY OF SIEMENS EDA OR ITS LICENSORS.
//
//  Running on Linux wanwei.xiao@alish-rs-cs08.eng.t-head.cn 3.10.0-1160.66.1.el7.x86_64 x86_64 aol
//
//  Package information: SIFLIBS v25.1_0.0, HLS_PKGS v25.1_0.0,
//                       SIF_TOOLKITS v25.1_0.0, SIF_XILINX v25.1_0.0,
//                       SIF_ALTERA v25.1_0.0, CCS_LIBS v25.1_0.0,
//                       CDS_PPRO v10.6, CDS_DesigChecker v2022.1,
//                       CDS_OASYS v21.1_2.5, CDS_PSR v21.1_0.4,
//                       DesignPad v2.78_1.0
//
solution new -state initial
solution options defaults
solution options set /Input/CppStandard c++11
solution options set /Flows/SCVerify/USE_QUESTASIM false
solution options set /Flows/SCVerify/USE_OSCI false
solution options set /Flows/SCVerify/USE_VCS true
solution options set /Flows/VCS/VG_ENV32_SCRIPT source_me_gcc483_32.csh
solution options set /Flows/VCS/VG_ENV64_SCRIPT source_me_gcc483_64.csh
solution options set /Flows/VCS/VLOGAN_OPTS {+v2k +no_tchk_msg -kdb -lca}
solution options set /Flows/VCS/VCSELAB_OPTS {-debug_acc+all -debug_region+cell+encrypt -timescale=1ps/1ps -sysc=blocksync -sysc=2.3.1 -sysc=slow_sc_main}
solution options set /Flows/VCS/SYSC_VERSION 2.3.1
flow package require /SCVerify
solution file add ../src/csc.h -type CHEADER -exclude true
solution file add ../src/csc.cpp -type C++
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
directive set -IDLE_SIGNAL {}
directive set -STALL_FLAG_SV off
directive set -STALL_FLAG false
directive set -TRANSACTION_DONE_SIGNAL true
directive set -DONE_FLAG {}
directive set -READY_FLAG {}
directive set -START_FLAG {}
directive set -TRANSACTION_SYNC ready
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
directive set -PROTOTYPING_ENGINE oasys
directive set -PIPELINE_RAMP_UP true
go new
solution design set csc -top
solution design set ac::fx_div<8> -block
go compile
solution library add nangate-45nm_beh -- -rtlsyntool DesignCompiler -vendor Nangate -technology 045nm
solution library add ccs_sample_mem
go libraries
directive set -CLOCKS {clk {-CLOCK_PERIOD 3.33 -CLOCK_EDGE rising -CLOCK_UNCERTAINTY 0.0 -CLOCK_HIGH_TIME 1.665 -RESET_SYNC_NAME rst -RESET_ASYNC_NAME arst_n -RESET_KIND sync -RESET_SYNC_ACTIVE high -RESET_ASYNC_ACTIVE low -ENABLE_ACTIVE high}}
go assembly
directive set /csc/top_reg.frameWidth:rsc -MAP_TO_MODULE {[DirectInput]}
directive set /csc/top_reg.frameHeight:rsc -MAP_TO_MODULE {[DirectInput]}
directive set /csc/top_reg.inputFormat:rsc -MAP_TO_MODULE {[DirectInput]}
directive set /csc/top_reg.imgPattern:rsc -MAP_TO_MODULE {[DirectInput]}
directive set /csc/top_reg.pipeMode:rsc -MAP_TO_MODULE {[DirectInput]}
directive set /csc/top_reg.blc:rsc -MAP_TO_MODULE {[DirectInput]}
directive set /csc/top_reg.shadowEb:rsc -MAP_TO_MODULE {[DirectInput]}
directive set /csc/top_reg.binningFrameWidth:rsc -MAP_TO_MODULE {[DirectInput]}
directive set /csc/top_reg.binningFrameHeight:rsc -MAP_TO_MODULE {[DirectInput]}
directive set /csc/top_reg.scalerFrameWidth:rsc -MAP_TO_MODULE {[DirectInput]}
directive set /csc/top_reg.scalerFrameHeight:rsc -MAP_TO_MODULE {[DirectInput]}
directive set /csc/csc_reg.m_nEb:rsc -MAP_TO_MODULE {[DirectInput]}
directive set /csc/csc_reg.coeff:rsc -MAP_TO_MODULE {[DirectInput]}
directive set /csc/core/main -PIPELINE_INIT_INTERVAL 1
directive set /csc/core/csc_cal1 -UNROLL yes
directive set /csc/core/csc_cal2 -UNROLL yes
go architect
go extract
//  Catapult Prime Synthesis 2022.1/981271 (Production Release) Thu Feb 10 22:05:20 PST 2022
//
//          Copyright (c) Siemens EDA, 1996-2022, All Rights Reserved.
//                        UNPUBLISHED, LICENSED SOFTWARE.
//             CONFIDENTIAL AND PROPRIETARY INFORMATION WHICH IS THE
//                   PROPERTY OF SIEMENS EDA OR ITS LICENSORS.
//
//  Running on Linux wanwei.xiao@alish-rs-cs08.eng.t-head.cn 3.10.0-1160.66.1.el7.x86_64 x86_64 aol
//
//  Package information: SIFLIBS v25.1_0.0, HLS_PKGS v25.1_0.0,
//                       SIF_TOOLKITS v25.1_0.0, SIF_XILINX v25.1_0.0,
//                       SIF_ALTERA v25.1_0.0, CCS_LIBS v25.1_0.0,
//                       CDS_PPRO v10.6, CDS_DesigChecker v2022.1,
//                       CDS_OASYS v21.1_2.5, CDS_PSR v21.1_0.4,
//                       DesignPad v2.78_1.0
//
solution new -state initial
solution options defaults
solution options set /Input/CppStandard c++11
solution options set /Output/GenerateCycleNetlist false
solution options set /Flows/SCVerify/USE_QUESTASIM false
solution options set /Flows/SCVerify/USE_OSCI false
solution options set /Flows/SCVerify/USE_VCS true
solution options set /Flows/VCS/VG_ENV32_SCRIPT source_me_gcc483_32.csh
solution options set /Flows/VCS/VG_ENV64_SCRIPT source_me_gcc483_64.csh
solution options set /Flows/VCS/VLOGAN_OPTS {+v2k +no_tchk_msg -kdb -lca}
solution options set /Flows/VCS/VCSELAB_OPTS {-debug_acc+all -debug_region+cell+encrypt -timescale=1ps/1ps -sysc=blocksync -sysc=2.3.1 -sysc=slow_sc_main}
solution options set /Flows/VCS/SYSC_VERSION 2.3.1
flow package require /SCVerify
solution file add ../src/yfc.h -type CHEADER -exclude true
solution file add ../src/yfc.cpp -type C++
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
directive set -IDLE_SIGNAL {}
directive set -STALL_FLAG_SV off
directive set -STALL_FLAG false
directive set -TRANSACTION_DONE_SIGNAL true
directive set -DONE_FLAG {}
directive set -READY_FLAG {}
directive set -START_FLAG {}
directive set -TRANSACTION_SYNC ready
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
directive set -PROTOTYPING_ENGINE oasys
directive set -PIPELINE_RAMP_UP true
go new
solution design set yfc -top
solution design set ac::fx_div<8> -block
go compile
solution library add nangate-45nm_beh -- -rtlsyntool DesignCompiler -vendor Nangate -technology 045nm
solution library add ccs_sample_mem
go libraries
directive set -CLOCKS {clk {-CLOCK_PERIOD 3.33 -CLOCK_EDGE rising -CLOCK_UNCERTAINTY 0.0 -CLOCK_HIGH_TIME 1.665 -RESET_SYNC_NAME rst -RESET_ASYNC_NAME arst_n -RESET_KIND sync -RESET_SYNC_ACTIVE high -RESET_ASYNC_ACTIVE low -ENABLE_ACTIVE high}}
go assembly
directive set /yfc/top_reg.frameWidth:rsc -MAP_TO_MODULE {[DirectInput]}
directive set /yfc/top_reg.frameHeight:rsc -MAP_TO_MODULE {[DirectInput]}
directive set /yfc/top_reg.inputFormat:rsc -MAP_TO_MODULE {[DirectInput]}
directive set /yfc/top_reg.imgPattern:rsc -MAP_TO_MODULE {[DirectInput]}
directive set /yfc/top_reg.pipeMode:rsc -MAP_TO_MODULE {[DirectInput]}
directive set /yfc/top_reg.blc:rsc -MAP_TO_MODULE {[DirectInput]}
directive set /yfc/top_reg.shadowEb:rsc -MAP_TO_MODULE {[DirectInput]}
directive set /yfc/top_reg.binningFrameWidth:rsc -MAP_TO_MODULE {[DirectInput]}
directive set /yfc/top_reg.binningFrameHeight:rsc -MAP_TO_MODULE {[DirectInput]}
directive set /yfc/top_reg.scalerFrameWidth:rsc -MAP_TO_MODULE {[DirectInput]}
directive set /yfc/top_reg.scalerFrameHeight:rsc -MAP_TO_MODULE {[DirectInput]}
directive set /yfc/yfc_reg.m_nEb:rsc -MAP_TO_MODULE {[DirectInput]}
directive set /yfc/yfc_reg.yuvpattern:rsc -MAP_TO_MODULE {[DirectInput]}
directive set /yfc/core/u_linebuffer:rsc -BLOCK_SIZE 8192
directive set /yfc/core/v_linebuffer:rsc -BLOCK_SIZE 8192
directive set /yfc/core/main -PIPELINE_INIT_INTERVAL 1
go architect
go extract
//  Catapult Prime Synthesis 2022.1/981271 (Production Release) Thu Feb 10 22:05:20 PST 2022
//
//          Copyright (c) Siemens EDA, 1996-2022, All Rights Reserved.
//                        UNPUBLISHED, LICENSED SOFTWARE.
//             CONFIDENTIAL AND PROPRIETARY INFORMATION WHICH IS THE
//                   PROPERTY OF SIEMENS EDA OR ITS LICENSORS.
//
//  Running on Linux wanwei.xiao@alish-rs-cs08.eng.t-head.cn 3.10.0-1160.66.1.el7.x86_64 x86_64 aol
//
//  Package information: SIFLIBS v25.1_0.0, HLS_PKGS v25.1_0.0,
//                       SIF_TOOLKITS v25.1_0.0, SIF_XILINX v25.1_0.0,
//                       SIF_ALTERA v25.1_0.0, CCS_LIBS v25.1_0.0,
//                       CDS_PPRO v10.6, CDS_DesigChecker v2022.1,
//                       CDS_OASYS v21.1_2.5, CDS_PSR v21.1_0.4,
//                       DesignPad v2.78_1.0
//
solution new -state initial
solution options defaults
solution options set /Input/CppStandard c++11
solution options set /Output/GenerateCycleNetlist false
solution options set /Flows/SCVerify/USE_QUESTASIM false
solution options set /Flows/SCVerify/USE_OSCI false
solution options set /Flows/SCVerify/USE_VCS true
solution options set /Flows/VCS/VG_ENV32_SCRIPT source_me_gcc483_32.csh
solution options set /Flows/VCS/VG_ENV64_SCRIPT source_me_gcc483_64.csh
solution options set /Flows/VCS/VLOGAN_OPTS {+v2k +no_tchk_msg -kdb -lca}
solution options set /Flows/VCS/VCSELAB_OPTS {-debug_acc+all -debug_region+cell+encrypt -timescale=1ps/1ps -sysc=blocksync -sysc=2.3.1 -sysc=slow_sc_main}
solution options set /Flows/VCS/SYSC_VERSION 2.3.1
flow package require /SCVerify
solution file add ../src/yuvdns.cpp -type C++
solution file add ../src/yuvdns.h -type CHEADER -exclude true
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
directive set -IDLE_SIGNAL {}
directive set -STALL_FLAG_SV off
directive set -STALL_FLAG false
directive set -TRANSACTION_DONE_SIGNAL true
directive set -DONE_FLAG {}
directive set -READY_FLAG {}
directive set -START_FLAG {}
directive set -TRANSACTION_SYNC ready
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
directive set -PROTOTYPING_ENGINE oasys
directive set -PIPELINE_RAMP_UP true
go new
solution design set yuv444dns -top
solution design set ac::fx_div<8> -block
go analyze
solution design set yuv444dns -top
solution design set ac::fx_div<8> -block
solution design set yuvdns_nlm -top
solution design set yuv444dns -block
go compile
solution library add nangate-45nm_beh -- -rtlsyntool DesignCompiler -vendor Nangate -technology 045nm
go libraries
solution design set yuvdns_nlm -ccore
directive set -CLOCKS {clk {-CLOCK_PERIOD 3.33 -CLOCK_EDGE rising -CLOCK_UNCERTAINTY 0.0 -CLOCK_HIGH_TIME 1.665 -RESET_SYNC_NAME rst -RESET_ASYNC_NAME arst_n -RESET_KIND sync -RESET_SYNC_ACTIVE high -RESET_ASYNC_ACTIVE low -ENABLE_ACTIVE high}}
go assembly
directive set /yuvdns_nlm/core/nlm_row_loop -PIPELINE_INIT_INTERVAL 0
directive set /yuvdns_nlm/core/nlm_row_loop -UNROLL yes
directive set /yuvdns_nlm/core/nlm_col_loop -PIPELINE_INIT_INTERVAL 0
directive set /yuvdns_nlm/core/nlm_col_loop -UNROLL yes
directive set /yuvdns_nlm/core/ac_math::ac_div<25,14,10,14>:for -PIPELINE_INIT_INTERVAL 0
directive set /yuvdns_nlm/core/ac_math::ac_div<25,14,10,14>:for -UNROLL yes
go architect
go extract
//  Catapult Prime Synthesis 2022.1/981271 (Production Release) Thu Feb 10 22:05:20 PST 2022
//
//          Copyright (c) Siemens EDA, 1996-2022, All Rights Reserved.
//                        UNPUBLISHED, LICENSED SOFTWARE.
//             CONFIDENTIAL AND PROPRIETARY INFORMATION WHICH IS THE
//                   PROPERTY OF SIEMENS EDA OR ITS LICENSORS.
//
//  Running on Linux wanwei.xiao@alish-rs-cs08.eng.t-head.cn 3.10.0-1160.66.1.el7.x86_64 x86_64 aol
//
//  Package information: SIFLIBS v25.1_0.0, HLS_PKGS v25.1_0.0,
//                       SIF_TOOLKITS v25.1_0.0, SIF_XILINX v25.1_0.0,
//                       SIF_ALTERA v25.1_0.0, CCS_LIBS v25.1_0.0,
//                       CDS_PPRO v10.6, CDS_DesigChecker v2022.1,
//                       CDS_OASYS v21.1_2.5, CDS_PSR v21.1_0.4,
//                       DesignPad v2.78_1.0
//
solution new -state initial
solution options defaults
solution options set /Input/CppStandard c++11
solution options set /Output/GenerateCycleNetlist false
solution options set /Flows/SCVerify/USE_QUESTASIM false
solution options set /Flows/SCVerify/USE_OSCI false
solution options set /Flows/SCVerify/USE_VCS true
solution options set /Flows/VCS/VG_ENV32_SCRIPT source_me_gcc483_32.csh
solution options set /Flows/VCS/VG_ENV64_SCRIPT source_me_gcc483_64.csh
solution options set /Flows/VCS/VLOGAN_OPTS {+v2k +no_tchk_msg -kdb -lca}
solution options set /Flows/VCS/VCSELAB_OPTS {-debug_acc+all -debug_region+cell+encrypt -timescale=1ps/1ps -sysc=blocksync -sysc=2.3.1 -sysc=slow_sc_main}
solution options set /Flows/VCS/SYSC_VERSION 2.3.1
flow package require /SCVerify
solution file add ../src/yuvdns.cpp -type C++
solution file add ../src/yuvdns.h -type CHEADER -exclude true
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
directive set -IDLE_SIGNAL {}
directive set -STALL_FLAG_SV off
directive set -STALL_FLAG false
directive set -TRANSACTION_DONE_SIGNAL true
directive set -DONE_FLAG {}
directive set -READY_FLAG {}
directive set -START_FLAG {}
directive set -TRANSACTION_SYNC ready
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
directive set -PROTOTYPING_ENGINE oasys
directive set -PIPELINE_RAMP_UP true
go new
solution design set yuv444dns -top
solution design set ac::fx_div<8> -block
go analyze
solution design set yuv444dns -block
solution design set ac::fx_div<8> -block
solution design set yuvdns_nlm -top -ccore
solution design set yuvdns_nlm -block
solution design set yuv444dns -top
go compile
solution design set yuv444dns -block
solution design set ac::fx_div<8> -block
solution design set yuvdns_nlm -top -ccore
solution design set yuvdns_nlm -block
solution design set yuv444dns -top
solution library add nangate-45nm_beh -- -rtlsyntool DesignCompiler -vendor Nangate -technology 045nm
solution library add ccs_sample_mem
go libraries
solution design set yuv444dns -block
solution design set ac::fx_div<8> -block
solution design set yuvdns_nlm -top -ccore
solution design set yuvdns_nlm -block
solution design set yuv444dns -top
directive set -CLOCKS {clk {-CLOCK_PERIOD 3.33 -CLOCK_EDGE rising -CLOCK_UNCERTAINTY 0.0 -CLOCK_HIGH_TIME 1.665 -RESET_SYNC_NAME rst -RESET_ASYNC_NAME arst_n -RESET_KIND sync -RESET_SYNC_ACTIVE high -RESET_ASYNC_ACTIVE low -ENABLE_ACTIVE high}}
go assembly
directive set /yuv444dns/top_reg.frameWidth:rsc -MAP_TO_MODULE {[DirectInput]}
directive set /yuv444dns/top_reg.frameHeight:rsc -MAP_TO_MODULE {[DirectInput]}
directive set /yuv444dns/top_reg.inputFormat:rsc -MAP_TO_MODULE {[DirectInput]}
directive set /yuv444dns/top_reg.imgPattern:rsc -MAP_TO_MODULE {[DirectInput]}
directive set /yuv444dns/top_reg.pipeMode:rsc -MAP_TO_MODULE {[DirectInput]}
directive set /yuv444dns/top_reg.blc:rsc -MAP_TO_MODULE {[DirectInput]}
directive set /yuv444dns/top_reg.shadowEb:rsc -MAP_TO_MODULE {[DirectInput]}
directive set /yuv444dns/top_reg.binningFrameWidth:rsc -MAP_TO_MODULE {[DirectInput]}
directive set /yuv444dns/top_reg.binningFrameHeight:rsc -MAP_TO_MODULE {[DirectInput]}
directive set /yuv444dns/top_reg.scalerFrameWidth:rsc -MAP_TO_MODULE {[DirectInput]}
directive set /yuv444dns/top_reg.scalerFrameHeight:rsc -MAP_TO_MODULE {[DirectInput]}
directive set /yuv444dns/yuvdns_reg.eb:rsc -MAP_TO_MODULE {[DirectInput]}
directive set /yuv444dns/yuvdns_reg.ysigma2:rsc -MAP_TO_MODULE {[DirectInput]}
directive set /yuv444dns/yuvdns_reg.yinvsigma2:rsc -MAP_TO_MODULE {[DirectInput]}
directive set /yuv444dns/yuvdns_reg.uvsigma2:rsc -MAP_TO_MODULE {[DirectInput]}
directive set /yuv444dns/yuvdns_reg.uvinvsigma2:rsc -MAP_TO_MODULE {[DirectInput]}
directive set /yuv444dns/yuvdns_reg.yfilt:rsc -MAP_TO_MODULE {[DirectInput]}
directive set /yuv444dns/yuvdns_reg.uvfilt:rsc -MAP_TO_MODULE {[DirectInput]}
directive set /yuv444dns/yuvdns_reg.yinvfilt:rsc -MAP_TO_MODULE {[DirectInput]}
directive set /yuv444dns/yuvdns_reg.uvinvfilt:rsc -MAP_TO_MODULE {[DirectInput]}
directive set /yuv444dns/yuvdns_reg.yH2:rsc -MAP_TO_MODULE {[DirectInput]}
directive set /yuv444dns/yuvdns_reg.yinvH2:rsc -MAP_TO_MODULE {[DirectInput]}
directive set /yuv444dns/yuvdns_reg.uvH2:rsc -MAP_TO_MODULE {[DirectInput]}
directive set /yuv444dns/yuvdns_reg.uvinvH2:rsc -MAP_TO_MODULE {[DirectInput]}
directive set /yuv444dns/core/yWindow:rsc -MAP_TO_MODULE {[Register]}
directive set /yuv444dns/core/uWindow:rsc -MAP_TO_MODULE {[Register]}
directive set /yuv444dns/core/vWindow:rsc -MAP_TO_MODULE {[Register]}
directive set /yuv444dns/core/ylineBuf:rsc -BLOCK_SIZE 8192
directive set /yuv444dns/core/ulineBuf:rsc -BLOCK_SIZE 8192
directive set /yuv444dns/core/vlineBuf:rsc -BLOCK_SIZE 8192
directive set /yuv444dns/core/main -PIPELINE_INIT_INTERVAL 1
directive set /yuv444dns/core/out_window_loop -UNROLL yes
directive set /yuv444dns/core/in_window_loop -UNROLL yes
directive set /yuv444dns/core/window_read -UNROLL yes
directive set /yuv444dns/core/lines_read -UNROLL yes
go architect
directive set /yuv444dns/core/window_read:read_mem(ylineBuf:rsc(1)(0).@) -IGNORE_DEPENDENCY_FROM {lines_read:write_mem(ylineBuf:rsc(0)(0).@) lines_read:write_mem(ulineBuf:rsc(0)(0).@) lines_read:write_mem(vlineBuf:rsc(0)(0).@) lines_read:write_mem(ylineBuf:rsc(1)(0).@)#1 lines_read:write_mem(ulineBuf:rsc(1)(0).@)#1 lines_read:write_mem(vlineBuf:rsc(1)(0).@)#1 lines_read:write_mem(ylineBuf:rsc(2)(0).@)#2 lines_read:write_mem(ulineBuf:rsc(2)(0).@)#2 lines_read:write_mem(vlineBuf:rsc(2)(0).@)#2 lines_read:write_mem(ylineBuf:rsc(3)(0).@)#3 lines_read:write_mem(ulineBuf:rsc(3)(0).@)#3 lines_read:write_mem(vlineBuf:rsc(3)(0).@)#3 lines_read:write_mem(ylineBuf:rsc(4)(0).@)#4 lines_read:write_mem(ulineBuf:rsc(4)(0).@)#4 lines_read:write_mem(vlineBuf:rsc(4)(0).@)#4 lines_read:write_mem(ylineBuf:rsc(5)(0).@)#5 lines_read:write_mem(ulineBuf:rsc(5)(0).@)#5 lines_read:write_mem(vlineBuf:rsc(5)(0).@)#5 lines_read:write_mem(ylineBuf:rsc(6)(0).@)#6 lines_read:write_mem(ulineBuf:rsc(6)(0).@)#6 lines_read:write_mem(vlineBuf:rsc(6)(0).@)#6 yuvdns_col:if:write_mem(ylineBuf:rsc(7)(0).@) yuvdns_col:if:write_mem(ulineBuf:rsc(7)(0).@) yuvdns_col:if:write_mem(vlineBuf:rsc(7)(0).@)}
directive set /yuv444dns/core/window_read:read_mem(ulineBuf:rsc(1)(0).@) -IGNORE_DEPENDENCY_FROM {lines_read:write_mem(ylineBuf:rsc(0)(0).@) lines_read:write_mem(ulineBuf:rsc(0)(0).@) lines_read:write_mem(vlineBuf:rsc(0)(0).@) lines_read:write_mem(ylineBuf:rsc(1)(0).@)#1 lines_read:write_mem(ulineBuf:rsc(1)(0).@)#1 lines_read:write_mem(vlineBuf:rsc(1)(0).@)#1 lines_read:write_mem(ylineBuf:rsc(2)(0).@)#2 lines_read:write_mem(ulineBuf:rsc(2)(0).@)#2 lines_read:write_mem(vlineBuf:rsc(2)(0).@)#2 lines_read:write_mem(ylineBuf:rsc(3)(0).@)#3 lines_read:write_mem(ulineBuf:rsc(3)(0).@)#3 lines_read:write_mem(vlineBuf:rsc(3)(0).@)#3 lines_read:write_mem(ylineBuf:rsc(4)(0).@)#4 lines_read:write_mem(ulineBuf:rsc(4)(0).@)#4 lines_read:write_mem(vlineBuf:rsc(4)(0).@)#4 lines_read:write_mem(ylineBuf:rsc(5)(0).@)#5 lines_read:write_mem(ulineBuf:rsc(5)(0).@)#5 lines_read:write_mem(vlineBuf:rsc(5)(0).@)#5 lines_read:write_mem(ylineBuf:rsc(6)(0).@)#6 lines_read:write_mem(ulineBuf:rsc(6)(0).@)#6 lines_read:write_mem(vlineBuf:rsc(6)(0).@)#6 yuvdns_col:if:write_mem(ylineBuf:rsc(7)(0).@) yuvdns_col:if:write_mem(ulineBuf:rsc(7)(0).@) yuvdns_col:if:write_mem(vlineBuf:rsc(7)(0).@)}
directive set /yuv444dns/core/window_read:read_mem(vlineBuf:rsc(1)(0).@) -IGNORE_DEPENDENCY_FROM {lines_read:write_mem(ylineBuf:rsc(0)(0).@) lines_read:write_mem(ulineBuf:rsc(0)(0).@) lines_read:write_mem(vlineBuf:rsc(0)(0).@) lines_read:write_mem(ylineBuf:rsc(1)(0).@)#1 lines_read:write_mem(ulineBuf:rsc(1)(0).@)#1 lines_read:write_mem(vlineBuf:rsc(1)(0).@)#1 lines_read:write_mem(ylineBuf:rsc(2)(0).@)#2 lines_read:write_mem(ulineBuf:rsc(2)(0).@)#2 lines_read:write_mem(vlineBuf:rsc(2)(0).@)#2 lines_read:write_mem(ylineBuf:rsc(3)(0).@)#3 lines_read:write_mem(ulineBuf:rsc(3)(0).@)#3 lines_read:write_mem(vlineBuf:rsc(3)(0).@)#3 lines_read:write_mem(ylineBuf:rsc(4)(0).@)#4 lines_read:write_mem(ulineBuf:rsc(4)(0).@)#4 lines_read:write_mem(vlineBuf:rsc(4)(0).@)#4 lines_read:write_mem(ylineBuf:rsc(5)(0).@)#5 lines_read:write_mem(ulineBuf:rsc(5)(0).@)#5 lines_read:write_mem(vlineBuf:rsc(5)(0).@)#5 lines_read:write_mem(ylineBuf:rsc(6)(0).@)#6 lines_read:write_mem(ulineBuf:rsc(6)(0).@)#6 lines_read:write_mem(vlineBuf:rsc(6)(0).@)#6 yuvdns_col:if:write_mem(ylineBuf:rsc(7)(0).@) yuvdns_col:if:write_mem(ulineBuf:rsc(7)(0).@) yuvdns_col:if:write_mem(vlineBuf:rsc(7)(0).@)}
directive set /yuv444dns/core/window_read:read_mem(ylineBuf:rsc(2)(0).@)#1 -IGNORE_DEPENDENCY_FROM {lines_read:write_mem(ylineBuf:rsc(0)(0).@) lines_read:write_mem(ulineBuf:rsc(0)(0).@) lines_read:write_mem(vlineBuf:rsc(0)(0).@) lines_read:write_mem(ylineBuf:rsc(1)(0).@)#1 lines_read:write_mem(ulineBuf:rsc(1)(0).@)#1 lines_read:write_mem(vlineBuf:rsc(1)(0).@)#1 lines_read:write_mem(ylineBuf:rsc(2)(0).@)#2 lines_read:write_mem(ulineBuf:rsc(2)(0).@)#2 lines_read:write_mem(vlineBuf:rsc(2)(0).@)#2 lines_read:write_mem(ylineBuf:rsc(3)(0).@)#3 lines_read:write_mem(ulineBuf:rsc(3)(0).@)#3 lines_read:write_mem(vlineBuf:rsc(3)(0).@)#3 lines_read:write_mem(ylineBuf:rsc(4)(0).@)#4 lines_read:write_mem(ulineBuf:rsc(4)(0).@)#4 lines_read:write_mem(vlineBuf:rsc(4)(0).@)#4 lines_read:write_mem(ylineBuf:rsc(5)(0).@)#5 lines_read:write_mem(ulineBuf:rsc(5)(0).@)#5 lines_read:write_mem(vlineBuf:rsc(5)(0).@)#5 lines_read:write_mem(ylineBuf:rsc(6)(0).@)#6 lines_read:write_mem(ulineBuf:rsc(6)(0).@)#6 lines_read:write_mem(vlineBuf:rsc(6)(0).@)#6 yuvdns_col:if:write_mem(ylineBuf:rsc(7)(0).@) yuvdns_col:if:write_mem(ulineBuf:rsc(7)(0).@) yuvdns_col:if:write_mem(vlineBuf:rsc(7)(0).@)}
directive set /yuv444dns/core/window_read:read_mem(ulineBuf:rsc(2)(0).@)#1 -IGNORE_DEPENDENCY_FROM {lines_read:write_mem(ylineBuf:rsc(0)(0).@) lines_read:write_mem(ulineBuf:rsc(0)(0).@) lines_read:write_mem(vlineBuf:rsc(0)(0).@) lines_read:write_mem(ylineBuf:rsc(1)(0).@)#1 lines_read:write_mem(ulineBuf:rsc(1)(0).@)#1 lines_read:write_mem(vlineBuf:rsc(1)(0).@)#1 lines_read:write_mem(ylineBuf:rsc(2)(0).@)#2 lines_read:write_mem(ulineBuf:rsc(2)(0).@)#2 lines_read:write_mem(vlineBuf:rsc(2)(0).@)#2 lines_read:write_mem(ylineBuf:rsc(3)(0).@)#3 lines_read:write_mem(ulineBuf:rsc(3)(0).@)#3 lines_read:write_mem(vlineBuf:rsc(3)(0).@)#3 lines_read:write_mem(ylineBuf:rsc(4)(0).@)#4 lines_read:write_mem(ulineBuf:rsc(4)(0).@)#4 lines_read:write_mem(vlineBuf:rsc(4)(0).@)#4 lines_read:write_mem(ylineBuf:rsc(5)(0).@)#5 lines_read:write_mem(ulineBuf:rsc(5)(0).@)#5 lines_read:write_mem(vlineBuf:rsc(5)(0).@)#5 lines_read:write_mem(ylineBuf:rsc(6)(0).@)#6 lines_read:write_mem(ulineBuf:rsc(6)(0).@)#6 lines_read:write_mem(vlineBuf:rsc(6)(0).@)#6 yuvdns_col:if:write_mem(ylineBuf:rsc(7)(0).@) yuvdns_col:if:write_mem(ulineBuf:rsc(7)(0).@) yuvdns_col:if:write_mem(vlineBuf:rsc(7)(0).@)}
directive set /yuv444dns/core/window_read:read_mem(vlineBuf:rsc(2)(0).@)#1 -IGNORE_DEPENDENCY_FROM {lines_read:write_mem(ylineBuf:rsc(0)(0).@) lines_read:write_mem(ulineBuf:rsc(0)(0).@) lines_read:write_mem(vlineBuf:rsc(0)(0).@) lines_read:write_mem(ylineBuf:rsc(1)(0).@)#1 lines_read:write_mem(ulineBuf:rsc(1)(0).@)#1 lines_read:write_mem(vlineBuf:rsc(1)(0).@)#1 lines_read:write_mem(ylineBuf:rsc(2)(0).@)#2 lines_read:write_mem(ulineBuf:rsc(2)(0).@)#2 lines_read:write_mem(vlineBuf:rsc(2)(0).@)#2 lines_read:write_mem(ylineBuf:rsc(3)(0).@)#3 lines_read:write_mem(ulineBuf:rsc(3)(0).@)#3 lines_read:write_mem(vlineBuf:rsc(3)(0).@)#3 lines_read:write_mem(ylineBuf:rsc(4)(0).@)#4 lines_read:write_mem(ulineBuf:rsc(4)(0).@)#4 lines_read:write_mem(vlineBuf:rsc(4)(0).@)#4 lines_read:write_mem(ylineBuf:rsc(5)(0).@)#5 lines_read:write_mem(ulineBuf:rsc(5)(0).@)#5 lines_read:write_mem(vlineBuf:rsc(5)(0).@)#5 lines_read:write_mem(ylineBuf:rsc(6)(0).@)#6 lines_read:write_mem(ulineBuf:rsc(6)(0).@)#6 lines_read:write_mem(vlineBuf:rsc(6)(0).@)#6 yuvdns_col:if:write_mem(ylineBuf:rsc(7)(0).@) yuvdns_col:if:write_mem(ulineBuf:rsc(7)(0).@) yuvdns_col:if:write_mem(vlineBuf:rsc(7)(0).@)}
directive set /yuv444dns/core/window_read:read_mem(ylineBuf:rsc(3)(0).@)#2 -IGNORE_DEPENDENCY_FROM {lines_read:write_mem(ylineBuf:rsc(0)(0).@) lines_read:write_mem(ulineBuf:rsc(0)(0).@) lines_read:write_mem(vlineBuf:rsc(0)(0).@) lines_read:write_mem(ylineBuf:rsc(1)(0).@)#1 lines_read:write_mem(ulineBuf:rsc(1)(0).@)#1 lines_read:write_mem(vlineBuf:rsc(1)(0).@)#1 lines_read:write_mem(ylineBuf:rsc(2)(0).@)#2 lines_read:write_mem(ulineBuf:rsc(2)(0).@)#2 lines_read:write_mem(vlineBuf:rsc(2)(0).@)#2 lines_read:write_mem(ylineBuf:rsc(3)(0).@)#3 lines_read:write_mem(ulineBuf:rsc(3)(0).@)#3 lines_read:write_mem(vlineBuf:rsc(3)(0).@)#3 lines_read:write_mem(ylineBuf:rsc(4)(0).@)#4 lines_read:write_mem(ulineBuf:rsc(4)(0).@)#4 lines_read:write_mem(vlineBuf:rsc(4)(0).@)#4 lines_read:write_mem(ylineBuf:rsc(5)(0).@)#5 lines_read:write_mem(ulineBuf:rsc(5)(0).@)#5 lines_read:write_mem(vlineBuf:rsc(5)(0).@)#5 lines_read:write_mem(ylineBuf:rsc(6)(0).@)#6 lines_read:write_mem(ulineBuf:rsc(6)(0).@)#6 lines_read:write_mem(vlineBuf:rsc(6)(0).@)#6 yuvdns_col:if:write_mem(ylineBuf:rsc(7)(0).@) yuvdns_col:if:write_mem(ulineBuf:rsc(7)(0).@) yuvdns_col:if:write_mem(vlineBuf:rsc(7)(0).@)}
directive set /yuv444dns/core/window_read:read_mem(ulineBuf:rsc(3)(0).@)#2 -IGNORE_DEPENDENCY_FROM {lines_read:write_mem(ylineBuf:rsc(0)(0).@) lines_read:write_mem(ulineBuf:rsc(0)(0).@) lines_read:write_mem(vlineBuf:rsc(0)(0).@) lines_read:write_mem(ylineBuf:rsc(1)(0).@)#1 lines_read:write_mem(ulineBuf:rsc(1)(0).@)#1 lines_read:write_mem(vlineBuf:rsc(1)(0).@)#1 lines_read:write_mem(ylineBuf:rsc(2)(0).@)#2 lines_read:write_mem(ulineBuf:rsc(2)(0).@)#2 lines_read:write_mem(vlineBuf:rsc(2)(0).@)#2 lines_read:write_mem(ylineBuf:rsc(3)(0).@)#3 lines_read:write_mem(ulineBuf:rsc(3)(0).@)#3 lines_read:write_mem(vlineBuf:rsc(3)(0).@)#3 lines_read:write_mem(ylineBuf:rsc(4)(0).@)#4 lines_read:write_mem(ulineBuf:rsc(4)(0).@)#4 lines_read:write_mem(vlineBuf:rsc(4)(0).@)#4 lines_read:write_mem(ylineBuf:rsc(5)(0).@)#5 lines_read:write_mem(ulineBuf:rsc(5)(0).@)#5 lines_read:write_mem(vlineBuf:rsc(5)(0).@)#5 lines_read:write_mem(ylineBuf:rsc(6)(0).@)#6 lines_read:write_mem(ulineBuf:rsc(6)(0).@)#6 lines_read:write_mem(vlineBuf:rsc(6)(0).@)#6 yuvdns_col:if:write_mem(ylineBuf:rsc(7)(0).@) yuvdns_col:if:write_mem(ulineBuf:rsc(7)(0).@) yuvdns_col:if:write_mem(vlineBuf:rsc(7)(0).@)}
directive set /yuv444dns/core/window_read:read_mem(vlineBuf:rsc(3)(0).@)#2 -IGNORE_DEPENDENCY_FROM {lines_read:write_mem(ylineBuf:rsc(0)(0).@) lines_read:write_mem(ulineBuf:rsc(0)(0).@) lines_read:write_mem(vlineBuf:rsc(0)(0).@) lines_read:write_mem(ylineBuf:rsc(1)(0).@)#1 lines_read:write_mem(ulineBuf:rsc(1)(0).@)#1 lines_read:write_mem(vlineBuf:rsc(1)(0).@)#1 lines_read:write_mem(ylineBuf:rsc(2)(0).@)#2 lines_read:write_mem(ulineBuf:rsc(2)(0).@)#2 lines_read:write_mem(vlineBuf:rsc(2)(0).@)#2 lines_read:write_mem(ylineBuf:rsc(3)(0).@)#3 lines_read:write_mem(ulineBuf:rsc(3)(0).@)#3 lines_read:write_mem(vlineBuf:rsc(3)(0).@)#3 lines_read:write_mem(ylineBuf:rsc(4)(0).@)#4 lines_read:write_mem(ulineBuf:rsc(4)(0).@)#4 lines_read:write_mem(vlineBuf:rsc(4)(0).@)#4 lines_read:write_mem(ylineBuf:rsc(5)(0).@)#5 lines_read:write_mem(ulineBuf:rsc(5)(0).@)#5 lines_read:write_mem(vlineBuf:rsc(5)(0).@)#5 lines_read:write_mem(ylineBuf:rsc(6)(0).@)#6 lines_read:write_mem(ulineBuf:rsc(6)(0).@)#6 lines_read:write_mem(vlineBuf:rsc(6)(0).@)#6 yuvdns_col:if:write_mem(ylineBuf:rsc(7)(0).@) yuvdns_col:if:write_mem(ulineBuf:rsc(7)(0).@) yuvdns_col:if:write_mem(vlineBuf:rsc(7)(0).@)}
directive set /yuv444dns/core/window_read:read_mem(ylineBuf:rsc(4)(0).@)#3 -IGNORE_DEPENDENCY_FROM {lines_read:write_mem(ylineBuf:rsc(0)(0).@) lines_read:write_mem(ulineBuf:rsc(0)(0).@) lines_read:write_mem(vlineBuf:rsc(0)(0).@) lines_read:write_mem(ylineBuf:rsc(1)(0).@)#1 lines_read:write_mem(ulineBuf:rsc(1)(0).@)#1 lines_read:write_mem(vlineBuf:rsc(1)(0).@)#1 lines_read:write_mem(ylineBuf:rsc(2)(0).@)#2 lines_read:write_mem(ulineBuf:rsc(2)(0).@)#2 lines_read:write_mem(vlineBuf:rsc(2)(0).@)#2 lines_read:write_mem(ylineBuf:rsc(3)(0).@)#3 lines_read:write_mem(ulineBuf:rsc(3)(0).@)#3 lines_read:write_mem(vlineBuf:rsc(3)(0).@)#3 lines_read:write_mem(ylineBuf:rsc(4)(0).@)#4 lines_read:write_mem(ulineBuf:rsc(4)(0).@)#4 lines_read:write_mem(vlineBuf:rsc(4)(0).@)#4 lines_read:write_mem(ylineBuf:rsc(5)(0).@)#5 lines_read:write_mem(ulineBuf:rsc(5)(0).@)#5 lines_read:write_mem(vlineBuf:rsc(5)(0).@)#5 lines_read:write_mem(ylineBuf:rsc(6)(0).@)#6 lines_read:write_mem(ulineBuf:rsc(6)(0).@)#6 lines_read:write_mem(vlineBuf:rsc(6)(0).@)#6 yuvdns_col:if:write_mem(ylineBuf:rsc(7)(0).@) yuvdns_col:if:write_mem(ulineBuf:rsc(7)(0).@) yuvdns_col:if:write_mem(vlineBuf:rsc(7)(0).@)}
directive set /yuv444dns/core/window_read:read_mem(ulineBuf:rsc(4)(0).@)#3 -IGNORE_DEPENDENCY_FROM {lines_read:write_mem(ylineBuf:rsc(0)(0).@) lines_read:write_mem(ulineBuf:rsc(0)(0).@) lines_read:write_mem(vlineBuf:rsc(0)(0).@) lines_read:write_mem(ylineBuf:rsc(1)(0).@)#1 lines_read:write_mem(ulineBuf:rsc(1)(0).@)#1 lines_read:write_mem(vlineBuf:rsc(1)(0).@)#1 lines_read:write_mem(ylineBuf:rsc(2)(0).@)#2 lines_read:write_mem(ulineBuf:rsc(2)(0).@)#2 lines_read:write_mem(vlineBuf:rsc(2)(0).@)#2 lines_read:write_mem(ylineBuf:rsc(3)(0).@)#3 lines_read:write_mem(ulineBuf:rsc(3)(0).@)#3 lines_read:write_mem(vlineBuf:rsc(3)(0).@)#3 lines_read:write_mem(ylineBuf:rsc(4)(0).@)#4 lines_read:write_mem(ulineBuf:rsc(4)(0).@)#4 lines_read:write_mem(vlineBuf:rsc(4)(0).@)#4 lines_read:write_mem(ylineBuf:rsc(5)(0).@)#5 lines_read:write_mem(ulineBuf:rsc(5)(0).@)#5 lines_read:write_mem(vlineBuf:rsc(5)(0).@)#5 lines_read:write_mem(ylineBuf:rsc(6)(0).@)#6 lines_read:write_mem(ulineBuf:rsc(6)(0).@)#6 lines_read:write_mem(vlineBuf:rsc(6)(0).@)#6 yuvdns_col:if:write_mem(ylineBuf:rsc(7)(0).@) yuvdns_col:if:write_mem(ulineBuf:rsc(7)(0).@) yuvdns_col:if:write_mem(vlineBuf:rsc(7)(0).@)}
directive set /yuv444dns/core/window_read:read_mem(vlineBuf:rsc(4)(0).@)#3 -IGNORE_DEPENDENCY_FROM {lines_read:write_mem(ylineBuf:rsc(0)(0).@) lines_read:write_mem(ulineBuf:rsc(0)(0).@) lines_read:write_mem(vlineBuf:rsc(0)(0).@) lines_read:write_mem(ylineBuf:rsc(1)(0).@)#1 lines_read:write_mem(ulineBuf:rsc(1)(0).@)#1 lines_read:write_mem(vlineBuf:rsc(1)(0).@)#1 lines_read:write_mem(ylineBuf:rsc(2)(0).@)#2 lines_read:write_mem(ulineBuf:rsc(2)(0).@)#2 lines_read:write_mem(vlineBuf:rsc(2)(0).@)#2 lines_read:write_mem(ylineBuf:rsc(3)(0).@)#3 lines_read:write_mem(ulineBuf:rsc(3)(0).@)#3 lines_read:write_mem(vlineBuf:rsc(3)(0).@)#3 lines_read:write_mem(ylineBuf:rsc(4)(0).@)#4 lines_read:write_mem(ulineBuf:rsc(4)(0).@)#4 lines_read:write_mem(vlineBuf:rsc(4)(0).@)#4 lines_read:write_mem(ylineBuf:rsc(5)(0).@)#5 lines_read:write_mem(ulineBuf:rsc(5)(0).@)#5 lines_read:write_mem(vlineBuf:rsc(5)(0).@)#5 lines_read:write_mem(ylineBuf:rsc(6)(0).@)#6 lines_read:write_mem(ulineBuf:rsc(6)(0).@)#6 lines_read:write_mem(vlineBuf:rsc(6)(0).@)#6 yuvdns_col:if:write_mem(ylineBuf:rsc(7)(0).@) yuvdns_col:if:write_mem(ulineBuf:rsc(7)(0).@) yuvdns_col:if:write_mem(vlineBuf:rsc(7)(0).@)}
directive set /yuv444dns/core/window_read:read_mem(ylineBuf:rsc(5)(0).@)#4 -IGNORE_DEPENDENCY_FROM {lines_read:write_mem(ylineBuf:rsc(0)(0).@) lines_read:write_mem(ulineBuf:rsc(0)(0).@) lines_read:write_mem(vlineBuf:rsc(0)(0).@) lines_read:write_mem(ylineBuf:rsc(1)(0).@)#1 lines_read:write_mem(ulineBuf:rsc(1)(0).@)#1 lines_read:write_mem(vlineBuf:rsc(1)(0).@)#1 lines_read:write_mem(ylineBuf:rsc(2)(0).@)#2 lines_read:write_mem(ulineBuf:rsc(2)(0).@)#2 lines_read:write_mem(vlineBuf:rsc(2)(0).@)#2 lines_read:write_mem(ylineBuf:rsc(3)(0).@)#3 lines_read:write_mem(ulineBuf:rsc(3)(0).@)#3 lines_read:write_mem(vlineBuf:rsc(3)(0).@)#3 lines_read:write_mem(ylineBuf:rsc(4)(0).@)#4 lines_read:write_mem(ulineBuf:rsc(4)(0).@)#4 lines_read:write_mem(vlineBuf:rsc(4)(0).@)#4 lines_read:write_mem(ylineBuf:rsc(5)(0).@)#5 lines_read:write_mem(ulineBuf:rsc(5)(0).@)#5 lines_read:write_mem(vlineBuf:rsc(5)(0).@)#5 lines_read:write_mem(ylineBuf:rsc(6)(0).@)#6 lines_read:write_mem(ulineBuf:rsc(6)(0).@)#6 lines_read:write_mem(vlineBuf:rsc(6)(0).@)#6 yuvdns_col:if:write_mem(ylineBuf:rsc(7)(0).@) yuvdns_col:if:write_mem(ulineBuf:rsc(7)(0).@) yuvdns_col:if:write_mem(vlineBuf:rsc(7)(0).@)}
directive set /yuv444dns/core/window_read:read_mem(ulineBuf:rsc(5)(0).@)#4 -IGNORE_DEPENDENCY_FROM {lines_read:write_mem(ylineBuf:rsc(0)(0).@) lines_read:write_mem(ulineBuf:rsc(0)(0).@) lines_read:write_mem(vlineBuf:rsc(0)(0).@) lines_read:write_mem(ylineBuf:rsc(1)(0).@)#1 lines_read:write_mem(ulineBuf:rsc(1)(0).@)#1 lines_read:write_mem(vlineBuf:rsc(1)(0).@)#1 lines_read:write_mem(ylineBuf:rsc(2)(0).@)#2 lines_read:write_mem(ulineBuf:rsc(2)(0).@)#2 lines_read:write_mem(vlineBuf:rsc(2)(0).@)#2 lines_read:write_mem(ylineBuf:rsc(3)(0).@)#3 lines_read:write_mem(ulineBuf:rsc(3)(0).@)#3 lines_read:write_mem(vlineBuf:rsc(3)(0).@)#3 lines_read:write_mem(ylineBuf:rsc(4)(0).@)#4 lines_read:write_mem(ulineBuf:rsc(4)(0).@)#4 lines_read:write_mem(vlineBuf:rsc(4)(0).@)#4 lines_read:write_mem(ylineBuf:rsc(5)(0).@)#5 lines_read:write_mem(ulineBuf:rsc(5)(0).@)#5 lines_read:write_mem(vlineBuf:rsc(5)(0).@)#5 lines_read:write_mem(ylineBuf:rsc(6)(0).@)#6 lines_read:write_mem(ulineBuf:rsc(6)(0).@)#6 lines_read:write_mem(vlineBuf:rsc(6)(0).@)#6 yuvdns_col:if:write_mem(ylineBuf:rsc(7)(0).@) yuvdns_col:if:write_mem(ulineBuf:rsc(7)(0).@) yuvdns_col:if:write_mem(vlineBuf:rsc(7)(0).@)}
directive set /yuv444dns/core/window_read:read_mem(vlineBuf:rsc(5)(0).@)#4 -IGNORE_DEPENDENCY_FROM {lines_read:write_mem(ylineBuf:rsc(0)(0).@) lines_read:write_mem(ulineBuf:rsc(0)(0).@) lines_read:write_mem(vlineBuf:rsc(0)(0).@) lines_read:write_mem(ylineBuf:rsc(1)(0).@)#1 lines_read:write_mem(ulineBuf:rsc(1)(0).@)#1 lines_read:write_mem(vlineBuf:rsc(1)(0).@)#1 lines_read:write_mem(ylineBuf:rsc(2)(0).@)#2 lines_read:write_mem(ulineBuf:rsc(2)(0).@)#2 lines_read:write_mem(vlineBuf:rsc(2)(0).@)#2 lines_read:write_mem(ylineBuf:rsc(3)(0).@)#3 lines_read:write_mem(ulineBuf:rsc(3)(0).@)#3 lines_read:write_mem(vlineBuf:rsc(3)(0).@)#3 lines_read:write_mem(ylineBuf:rsc(4)(0).@)#4 lines_read:write_mem(ulineBuf:rsc(4)(0).@)#4 lines_read:write_mem(vlineBuf:rsc(4)(0).@)#4 lines_read:write_mem(ylineBuf:rsc(5)(0).@)#5 lines_read:write_mem(ulineBuf:rsc(5)(0).@)#5 lines_read:write_mem(vlineBuf:rsc(5)(0).@)#5 lines_read:write_mem(ylineBuf:rsc(6)(0).@)#6 lines_read:write_mem(ulineBuf:rsc(6)(0).@)#6 lines_read:write_mem(vlineBuf:rsc(6)(0).@)#6 yuvdns_col:if:write_mem(ylineBuf:rsc(7)(0).@) yuvdns_col:if:write_mem(ulineBuf:rsc(7)(0).@) yuvdns_col:if:write_mem(vlineBuf:rsc(7)(0).@)}
directive set /yuv444dns/core/window_read:read_mem(ylineBuf:rsc(6)(0).@)#5 -IGNORE_DEPENDENCY_FROM {lines_read:write_mem(ylineBuf:rsc(0)(0).@) lines_read:write_mem(ulineBuf:rsc(0)(0).@) lines_read:write_mem(vlineBuf:rsc(0)(0).@) lines_read:write_mem(ylineBuf:rsc(1)(0).@)#1 lines_read:write_mem(ulineBuf:rsc(1)(0).@)#1 lines_read:write_mem(vlineBuf:rsc(1)(0).@)#1 lines_read:write_mem(ylineBuf:rsc(2)(0).@)#2 lines_read:write_mem(ulineBuf:rsc(2)(0).@)#2 lines_read:write_mem(vlineBuf:rsc(2)(0).@)#2 lines_read:write_mem(ylineBuf:rsc(3)(0).@)#3 lines_read:write_mem(ulineBuf:rsc(3)(0).@)#3 lines_read:write_mem(vlineBuf:rsc(3)(0).@)#3 lines_read:write_mem(ylineBuf:rsc(4)(0).@)#4 lines_read:write_mem(ulineBuf:rsc(4)(0).@)#4 lines_read:write_mem(vlineBuf:rsc(4)(0).@)#4 lines_read:write_mem(ylineBuf:rsc(5)(0).@)#5 lines_read:write_mem(ulineBuf:rsc(5)(0).@)#5 lines_read:write_mem(vlineBuf:rsc(5)(0).@)#5 lines_read:write_mem(ylineBuf:rsc(6)(0).@)#6 lines_read:write_mem(ulineBuf:rsc(6)(0).@)#6 lines_read:write_mem(vlineBuf:rsc(6)(0).@)#6 yuvdns_col:if:write_mem(ylineBuf:rsc(7)(0).@) yuvdns_col:if:write_mem(ulineBuf:rsc(7)(0).@) yuvdns_col:if:write_mem(vlineBuf:rsc(7)(0).@)}
directive set /yuv444dns/core/window_read:read_mem(ulineBuf:rsc(6)(0).@)#5 -IGNORE_DEPENDENCY_FROM {lines_read:write_mem(ylineBuf:rsc(0)(0).@) lines_read:write_mem(ulineBuf:rsc(0)(0).@) lines_read:write_mem(vlineBuf:rsc(0)(0).@) lines_read:write_mem(ylineBuf:rsc(1)(0).@)#1 lines_read:write_mem(ulineBuf:rsc(1)(0).@)#1 lines_read:write_mem(vlineBuf:rsc(1)(0).@)#1 lines_read:write_mem(ylineBuf:rsc(2)(0).@)#2 lines_read:write_mem(ulineBuf:rsc(2)(0).@)#2 lines_read:write_mem(vlineBuf:rsc(2)(0).@)#2 lines_read:write_mem(ylineBuf:rsc(3)(0).@)#3 lines_read:write_mem(ulineBuf:rsc(3)(0).@)#3 lines_read:write_mem(vlineBuf:rsc(3)(0).@)#3 lines_read:write_mem(ylineBuf:rsc(4)(0).@)#4 lines_read:write_mem(ulineBuf:rsc(4)(0).@)#4 lines_read:write_mem(vlineBuf:rsc(4)(0).@)#4 lines_read:write_mem(ylineBuf:rsc(5)(0).@)#5 lines_read:write_mem(ulineBuf:rsc(5)(0).@)#5 lines_read:write_mem(vlineBuf:rsc(5)(0).@)#5 lines_read:write_mem(ylineBuf:rsc(6)(0).@)#6 lines_read:write_mem(ulineBuf:rsc(6)(0).@)#6 lines_read:write_mem(vlineBuf:rsc(6)(0).@)#6 yuvdns_col:if:write_mem(ylineBuf:rsc(7)(0).@) yuvdns_col:if:write_mem(ulineBuf:rsc(7)(0).@) yuvdns_col:if:write_mem(vlineBuf:rsc(7)(0).@)}
directive set /yuv444dns/core/window_read:read_mem(vlineBuf:rsc(6)(0).@)#5 -IGNORE_DEPENDENCY_FROM {lines_read:write_mem(ylineBuf:rsc(0)(0).@) lines_read:write_mem(ulineBuf:rsc(0)(0).@) lines_read:write_mem(vlineBuf:rsc(0)(0).@) lines_read:write_mem(ylineBuf:rsc(1)(0).@)#1 lines_read:write_mem(ulineBuf:rsc(1)(0).@)#1 lines_read:write_mem(vlineBuf:rsc(1)(0).@)#1 lines_read:write_mem(ylineBuf:rsc(2)(0).@)#2 lines_read:write_mem(ulineBuf:rsc(2)(0).@)#2 lines_read:write_mem(vlineBuf:rsc(2)(0).@)#2 lines_read:write_mem(ylineBuf:rsc(3)(0).@)#3 lines_read:write_mem(ulineBuf:rsc(3)(0).@)#3 lines_read:write_mem(vlineBuf:rsc(3)(0).@)#3 lines_read:write_mem(ylineBuf:rsc(4)(0).@)#4 lines_read:write_mem(ulineBuf:rsc(4)(0).@)#4 lines_read:write_mem(vlineBuf:rsc(4)(0).@)#4 lines_read:write_mem(ylineBuf:rsc(5)(0).@)#5 lines_read:write_mem(ulineBuf:rsc(5)(0).@)#5 lines_read:write_mem(vlineBuf:rsc(5)(0).@)#5 lines_read:write_mem(ylineBuf:rsc(6)(0).@)#6 lines_read:write_mem(ulineBuf:rsc(6)(0).@)#6 lines_read:write_mem(vlineBuf:rsc(6)(0).@)#6 yuvdns_col:if:write_mem(ylineBuf:rsc(7)(0).@) yuvdns_col:if:write_mem(ulineBuf:rsc(7)(0).@) yuvdns_col:if:write_mem(vlineBuf:rsc(7)(0).@)}
directive set /yuv444dns/core/window_read:read_mem(ylineBuf:rsc(7)(0).@)#6 -IGNORE_DEPENDENCY_FROM {lines_read:write_mem(ylineBuf:rsc(0)(0).@) lines_read:write_mem(ulineBuf:rsc(0)(0).@) lines_read:write_mem(vlineBuf:rsc(0)(0).@) lines_read:write_mem(ylineBuf:rsc(1)(0).@)#1 lines_read:write_mem(ulineBuf:rsc(1)(0).@)#1 lines_read:write_mem(vlineBuf:rsc(1)(0).@)#1 lines_read:write_mem(ylineBuf:rsc(2)(0).@)#2 lines_read:write_mem(ulineBuf:rsc(2)(0).@)#2 lines_read:write_mem(vlineBuf:rsc(2)(0).@)#2 lines_read:write_mem(ylineBuf:rsc(3)(0).@)#3 lines_read:write_mem(ulineBuf:rsc(3)(0).@)#3 lines_read:write_mem(vlineBuf:rsc(3)(0).@)#3 lines_read:write_mem(ylineBuf:rsc(4)(0).@)#4 lines_read:write_mem(ulineBuf:rsc(4)(0).@)#4 lines_read:write_mem(vlineBuf:rsc(4)(0).@)#4 lines_read:write_mem(ylineBuf:rsc(5)(0).@)#5 lines_read:write_mem(ulineBuf:rsc(5)(0).@)#5 lines_read:write_mem(vlineBuf:rsc(5)(0).@)#5 lines_read:write_mem(ylineBuf:rsc(6)(0).@)#6 lines_read:write_mem(ulineBuf:rsc(6)(0).@)#6 lines_read:write_mem(vlineBuf:rsc(6)(0).@)#6 yuvdns_col:if:write_mem(ylineBuf:rsc(7)(0).@) yuvdns_col:if:write_mem(ulineBuf:rsc(7)(0).@) yuvdns_col:if:write_mem(vlineBuf:rsc(7)(0).@)}
directive set /yuv444dns/core/window_read:read_mem(ulineBuf:rsc(7)(0).@)#6 -IGNORE_DEPENDENCY_FROM {lines_read:write_mem(ylineBuf:rsc(0)(0).@) lines_read:write_mem(ulineBuf:rsc(0)(0).@) lines_read:write_mem(vlineBuf:rsc(0)(0).@) lines_read:write_mem(ylineBuf:rsc(1)(0).@)#1 lines_read:write_mem(ulineBuf:rsc(1)(0).@)#1 lines_read:write_mem(vlineBuf:rsc(1)(0).@)#1 lines_read:write_mem(ylineBuf:rsc(2)(0).@)#2 lines_read:write_mem(ulineBuf:rsc(2)(0).@)#2 lines_read:write_mem(vlineBuf:rsc(2)(0).@)#2 lines_read:write_mem(ylineBuf:rsc(3)(0).@)#3 lines_read:write_mem(ulineBuf:rsc(3)(0).@)#3 lines_read:write_mem(vlineBuf:rsc(3)(0).@)#3 lines_read:write_mem(ylineBuf:rsc(4)(0).@)#4 lines_read:write_mem(ulineBuf:rsc(4)(0).@)#4 lines_read:write_mem(vlineBuf:rsc(4)(0).@)#4 lines_read:write_mem(ylineBuf:rsc(5)(0).@)#5 lines_read:write_mem(ulineBuf:rsc(5)(0).@)#5 lines_read:write_mem(vlineBuf:rsc(5)(0).@)#5 lines_read:write_mem(ylineBuf:rsc(6)(0).@)#6 lines_read:write_mem(ulineBuf:rsc(6)(0).@)#6 lines_read:write_mem(vlineBuf:rsc(6)(0).@)#6 yuvdns_col:if:write_mem(ylineBuf:rsc(7)(0).@) yuvdns_col:if:write_mem(ulineBuf:rsc(7)(0).@) yuvdns_col:if:write_mem(vlineBuf:rsc(7)(0).@)}
directive set /yuv444dns/core/window_read:read_mem(vlineBuf:rsc(7)(0).@)#6 -IGNORE_DEPENDENCY_FROM {lines_read:write_mem(ylineBuf:rsc(0)(0).@) lines_read:write_mem(ulineBuf:rsc(0)(0).@) lines_read:write_mem(vlineBuf:rsc(0)(0).@) lines_read:write_mem(ylineBuf:rsc(1)(0).@)#1 lines_read:write_mem(ulineBuf:rsc(1)(0).@)#1 lines_read:write_mem(vlineBuf:rsc(1)(0).@)#1 lines_read:write_mem(ylineBuf:rsc(2)(0).@)#2 lines_read:write_mem(ulineBuf:rsc(2)(0).@)#2 lines_read:write_mem(vlineBuf:rsc(2)(0).@)#2 lines_read:write_mem(ylineBuf:rsc(3)(0).@)#3 lines_read:write_mem(ulineBuf:rsc(3)(0).@)#3 lines_read:write_mem(vlineBuf:rsc(3)(0).@)#3 lines_read:write_mem(ylineBuf:rsc(4)(0).@)#4 lines_read:write_mem(ulineBuf:rsc(4)(0).@)#4 lines_read:write_mem(vlineBuf:rsc(4)(0).@)#4 lines_read:write_mem(ylineBuf:rsc(5)(0).@)#5 lines_read:write_mem(ulineBuf:rsc(5)(0).@)#5 lines_read:write_mem(vlineBuf:rsc(5)(0).@)#5 lines_read:write_mem(ylineBuf:rsc(6)(0).@)#6 lines_read:write_mem(ulineBuf:rsc(6)(0).@)#6 lines_read:write_mem(vlineBuf:rsc(6)(0).@)#6 yuvdns_col:if:write_mem(ylineBuf:rsc(7)(0).@) yuvdns_col:if:write_mem(ulineBuf:rsc(7)(0).@) yuvdns_col:if:write_mem(vlineBuf:rsc(7)(0).@)}
directive set /yuv444dns/core/window_read:read_mem(ylineBuf:rsc(0)(0).@)#7 -IGNORE_DEPENDENCY_FROM {lines_read:write_mem(ylineBuf:rsc(0)(0).@) lines_read:write_mem(ulineBuf:rsc(0)(0).@) lines_read:write_mem(vlineBuf:rsc(0)(0).@) lines_read:write_mem(ylineBuf:rsc(1)(0).@)#1 lines_read:write_mem(ulineBuf:rsc(1)(0).@)#1 lines_read:write_mem(vlineBuf:rsc(1)(0).@)#1 lines_read:write_mem(ylineBuf:rsc(2)(0).@)#2 lines_read:write_mem(ulineBuf:rsc(2)(0).@)#2 lines_read:write_mem(vlineBuf:rsc(2)(0).@)#2 lines_read:write_mem(ylineBuf:rsc(3)(0).@)#3 lines_read:write_mem(ulineBuf:rsc(3)(0).@)#3 lines_read:write_mem(vlineBuf:rsc(3)(0).@)#3 lines_read:write_mem(ylineBuf:rsc(4)(0).@)#4 lines_read:write_mem(ulineBuf:rsc(4)(0).@)#4 lines_read:write_mem(vlineBuf:rsc(4)(0).@)#4 lines_read:write_mem(ylineBuf:rsc(5)(0).@)#5 lines_read:write_mem(ulineBuf:rsc(5)(0).@)#5 lines_read:write_mem(vlineBuf:rsc(5)(0).@)#5 lines_read:write_mem(ylineBuf:rsc(6)(0).@)#6 lines_read:write_mem(ulineBuf:rsc(6)(0).@)#6 lines_read:write_mem(vlineBuf:rsc(6)(0).@)#6 yuvdns_col:if:write_mem(ylineBuf:rsc(7)(0).@) yuvdns_col:if:write_mem(ulineBuf:rsc(7)(0).@) yuvdns_col:if:write_mem(vlineBuf:rsc(7)(0).@)}
directive set /yuv444dns/core/window_read:read_mem(ulineBuf:rsc(0)(0).@)#7 -IGNORE_DEPENDENCY_FROM {lines_read:write_mem(ylineBuf:rsc(0)(0).@) lines_read:write_mem(ulineBuf:rsc(0)(0).@) lines_read:write_mem(vlineBuf:rsc(0)(0).@) lines_read:write_mem(ylineBuf:rsc(1)(0).@)#1 lines_read:write_mem(ulineBuf:rsc(1)(0).@)#1 lines_read:write_mem(vlineBuf:rsc(1)(0).@)#1 lines_read:write_mem(ylineBuf:rsc(2)(0).@)#2 lines_read:write_mem(ulineBuf:rsc(2)(0).@)#2 lines_read:write_mem(vlineBuf:rsc(2)(0).@)#2 lines_read:write_mem(ylineBuf:rsc(3)(0).@)#3 lines_read:write_mem(ulineBuf:rsc(3)(0).@)#3 lines_read:write_mem(vlineBuf:rsc(3)(0).@)#3 lines_read:write_mem(ylineBuf:rsc(4)(0).@)#4 lines_read:write_mem(ulineBuf:rsc(4)(0).@)#4 lines_read:write_mem(vlineBuf:rsc(4)(0).@)#4 lines_read:write_mem(ylineBuf:rsc(5)(0).@)#5 lines_read:write_mem(ulineBuf:rsc(5)(0).@)#5 lines_read:write_mem(vlineBuf:rsc(5)(0).@)#5 lines_read:write_mem(ylineBuf:rsc(6)(0).@)#6 lines_read:write_mem(ulineBuf:rsc(6)(0).@)#6 lines_read:write_mem(vlineBuf:rsc(6)(0).@)#6 yuvdns_col:if:write_mem(ylineBuf:rsc(7)(0).@) yuvdns_col:if:write_mem(ulineBuf:rsc(7)(0).@) yuvdns_col:if:write_mem(vlineBuf:rsc(7)(0).@)}
directive set /yuv444dns/core/window_read:read_mem(vlineBuf:rsc(0)(0).@)#7 -IGNORE_DEPENDENCY_FROM {lines_read:write_mem(ylineBuf:rsc(0)(0).@) lines_read:write_mem(ulineBuf:rsc(0)(0).@) lines_read:write_mem(vlineBuf:rsc(0)(0).@) lines_read:write_mem(ylineBuf:rsc(1)(0).@)#1 lines_read:write_mem(ulineBuf:rsc(1)(0).@)#1 lines_read:write_mem(vlineBuf:rsc(1)(0).@)#1 lines_read:write_mem(ylineBuf:rsc(2)(0).@)#2 lines_read:write_mem(ulineBuf:rsc(2)(0).@)#2 lines_read:write_mem(vlineBuf:rsc(2)(0).@)#2 lines_read:write_mem(ylineBuf:rsc(3)(0).@)#3 lines_read:write_mem(ulineBuf:rsc(3)(0).@)#3 lines_read:write_mem(vlineBuf:rsc(3)(0).@)#3 lines_read:write_mem(ylineBuf:rsc(4)(0).@)#4 lines_read:write_mem(ulineBuf:rsc(4)(0).@)#4 lines_read:write_mem(vlineBuf:rsc(4)(0).@)#4 lines_read:write_mem(ylineBuf:rsc(5)(0).@)#5 lines_read:write_mem(ulineBuf:rsc(5)(0).@)#5 lines_read:write_mem(vlineBuf:rsc(5)(0).@)#5 lines_read:write_mem(ylineBuf:rsc(6)(0).@)#6 lines_read:write_mem(ulineBuf:rsc(6)(0).@)#6 lines_read:write_mem(vlineBuf:rsc(6)(0).@)#6 yuvdns_col:if:write_mem(ylineBuf:rsc(7)(0).@) yuvdns_col:if:write_mem(ulineBuf:rsc(7)(0).@) yuvdns_col:if:write_mem(vlineBuf:rsc(7)(0).@)}
directive set /yuv444dns/core/addon_loop_2:for:read_mem(ylineBuf:rsc(4)(0).@) -IGNORE_DEPENDENCY_FROM {lines_read:write_mem(ylineBuf:rsc(0)(0).@) lines_read:write_mem(ulineBuf:rsc(0)(0).@) lines_read:write_mem(vlineBuf:rsc(0)(0).@) lines_read:write_mem(ylineBuf:rsc(1)(0).@)#1 lines_read:write_mem(ulineBuf:rsc(1)(0).@)#1 lines_read:write_mem(vlineBuf:rsc(1)(0).@)#1 lines_read:write_mem(ylineBuf:rsc(2)(0).@)#2 lines_read:write_mem(ulineBuf:rsc(2)(0).@)#2 lines_read:write_mem(vlineBuf:rsc(2)(0).@)#2 lines_read:write_mem(ylineBuf:rsc(3)(0).@)#3 lines_read:write_mem(ulineBuf:rsc(3)(0).@)#3 lines_read:write_mem(vlineBuf:rsc(3)(0).@)#3 lines_read:write_mem(ylineBuf:rsc(4)(0).@)#4 lines_read:write_mem(ulineBuf:rsc(4)(0).@)#4 lines_read:write_mem(vlineBuf:rsc(4)(0).@)#4 lines_read:write_mem(ylineBuf:rsc(5)(0).@)#5 lines_read:write_mem(ulineBuf:rsc(5)(0).@)#5 lines_read:write_mem(vlineBuf:rsc(5)(0).@)#5 lines_read:write_mem(ylineBuf:rsc(6)(0).@)#6 lines_read:write_mem(ulineBuf:rsc(6)(0).@)#6 lines_read:write_mem(vlineBuf:rsc(6)(0).@)#6 yuvdns_col:if:write_mem(ylineBuf:rsc(7)(0).@) yuvdns_col:if:write_mem(ulineBuf:rsc(7)(0).@) yuvdns_col:if:write_mem(vlineBuf:rsc(7)(0).@)}
directive set /yuv444dns/core/addon_loop_2:for:read_mem(ylineBuf:rsc(5)(0).@) -IGNORE_DEPENDENCY_FROM {lines_read:write_mem(ylineBuf:rsc(0)(0).@) lines_read:write_mem(ulineBuf:rsc(0)(0).@) lines_read:write_mem(vlineBuf:rsc(0)(0).@) lines_read:write_mem(ylineBuf:rsc(1)(0).@)#1 lines_read:write_mem(ulineBuf:rsc(1)(0).@)#1 lines_read:write_mem(vlineBuf:rsc(1)(0).@)#1 lines_read:write_mem(ylineBuf:rsc(2)(0).@)#2 lines_read:write_mem(ulineBuf:rsc(2)(0).@)#2 lines_read:write_mem(vlineBuf:rsc(2)(0).@)#2 lines_read:write_mem(ylineBuf:rsc(3)(0).@)#3 lines_read:write_mem(ulineBuf:rsc(3)(0).@)#3 lines_read:write_mem(vlineBuf:rsc(3)(0).@)#3 lines_read:write_mem(ylineBuf:rsc(4)(0).@)#4 lines_read:write_mem(ulineBuf:rsc(4)(0).@)#4 lines_read:write_mem(vlineBuf:rsc(4)(0).@)#4 lines_read:write_mem(ylineBuf:rsc(5)(0).@)#5 lines_read:write_mem(ulineBuf:rsc(5)(0).@)#5 lines_read:write_mem(vlineBuf:rsc(5)(0).@)#5 lines_read:write_mem(ylineBuf:rsc(6)(0).@)#6 lines_read:write_mem(ulineBuf:rsc(6)(0).@)#6 lines_read:write_mem(vlineBuf:rsc(6)(0).@)#6 yuvdns_col:if:write_mem(ylineBuf:rsc(7)(0).@) yuvdns_col:if:write_mem(ulineBuf:rsc(7)(0).@) yuvdns_col:if:write_mem(vlineBuf:rsc(7)(0).@)}
directive set /yuv444dns/core/addon_loop_2:for:read_mem(ylineBuf:rsc(6)(0).@) -IGNORE_DEPENDENCY_FROM {lines_read:write_mem(ylineBuf:rsc(0)(0).@) lines_read:write_mem(ulineBuf:rsc(0)(0).@) lines_read:write_mem(vlineBuf:rsc(0)(0).@) lines_read:write_mem(ylineBuf:rsc(1)(0).@)#1 lines_read:write_mem(ulineBuf:rsc(1)(0).@)#1 lines_read:write_mem(vlineBuf:rsc(1)(0).@)#1 lines_read:write_mem(ylineBuf:rsc(2)(0).@)#2 lines_read:write_mem(ulineBuf:rsc(2)(0).@)#2 lines_read:write_mem(vlineBuf:rsc(2)(0).@)#2 lines_read:write_mem(ylineBuf:rsc(3)(0).@)#3 lines_read:write_mem(ulineBuf:rsc(3)(0).@)#3 lines_read:write_mem(vlineBuf:rsc(3)(0).@)#3 lines_read:write_mem(ylineBuf:rsc(4)(0).@)#4 lines_read:write_mem(ulineBuf:rsc(4)(0).@)#4 lines_read:write_mem(vlineBuf:rsc(4)(0).@)#4 lines_read:write_mem(ylineBuf:rsc(5)(0).@)#5 lines_read:write_mem(ulineBuf:rsc(5)(0).@)#5 lines_read:write_mem(vlineBuf:rsc(5)(0).@)#5 lines_read:write_mem(ylineBuf:rsc(6)(0).@)#6 lines_read:write_mem(ulineBuf:rsc(6)(0).@)#6 lines_read:write_mem(vlineBuf:rsc(6)(0).@)#6 yuvdns_col:if:write_mem(ylineBuf:rsc(7)(0).@) yuvdns_col:if:write_mem(ulineBuf:rsc(7)(0).@) yuvdns_col:if:write_mem(vlineBuf:rsc(7)(0).@)}
directive set /yuv444dns/core/addon_loop_2:for:read_mem(ylineBuf:rsc(7)(0).@) -IGNORE_DEPENDENCY_FROM {lines_read:write_mem(ylineBuf:rsc(0)(0).@) lines_read:write_mem(ulineBuf:rsc(0)(0).@) lines_read:write_mem(vlineBuf:rsc(0)(0).@) lines_read:write_mem(ylineBuf:rsc(1)(0).@)#1 lines_read:write_mem(ulineBuf:rsc(1)(0).@)#1 lines_read:write_mem(vlineBuf:rsc(1)(0).@)#1 lines_read:write_mem(ylineBuf:rsc(2)(0).@)#2 lines_read:write_mem(ulineBuf:rsc(2)(0).@)#2 lines_read:write_mem(vlineBuf:rsc(2)(0).@)#2 lines_read:write_mem(ylineBuf:rsc(3)(0).@)#3 lines_read:write_mem(ulineBuf:rsc(3)(0).@)#3 lines_read:write_mem(vlineBuf:rsc(3)(0).@)#3 lines_read:write_mem(ylineBuf:rsc(4)(0).@)#4 lines_read:write_mem(ulineBuf:rsc(4)(0).@)#4 lines_read:write_mem(vlineBuf:rsc(4)(0).@)#4 lines_read:write_mem(ylineBuf:rsc(5)(0).@)#5 lines_read:write_mem(ulineBuf:rsc(5)(0).@)#5 lines_read:write_mem(vlineBuf:rsc(5)(0).@)#5 lines_read:write_mem(ylineBuf:rsc(6)(0).@)#6 lines_read:write_mem(ulineBuf:rsc(6)(0).@)#6 lines_read:write_mem(vlineBuf:rsc(6)(0).@)#6 yuvdns_col:if:write_mem(ylineBuf:rsc(7)(0).@) yuvdns_col:if:write_mem(ulineBuf:rsc(7)(0).@) yuvdns_col:if:write_mem(vlineBuf:rsc(7)(0).@)}
directive set /yuv444dns/core/addon_loop_2:for:read_mem(ulineBuf:rsc(4)(0).@) -IGNORE_DEPENDENCY_FROM {lines_read:write_mem(ylineBuf:rsc(0)(0).@) lines_read:write_mem(ulineBuf:rsc(0)(0).@) lines_read:write_mem(vlineBuf:rsc(0)(0).@) lines_read:write_mem(ylineBuf:rsc(1)(0).@)#1 lines_read:write_mem(ulineBuf:rsc(1)(0).@)#1 lines_read:write_mem(vlineBuf:rsc(1)(0).@)#1 lines_read:write_mem(ylineBuf:rsc(2)(0).@)#2 lines_read:write_mem(ulineBuf:rsc(2)(0).@)#2 lines_read:write_mem(vlineBuf:rsc(2)(0).@)#2 lines_read:write_mem(ylineBuf:rsc(3)(0).@)#3 lines_read:write_mem(ulineBuf:rsc(3)(0).@)#3 lines_read:write_mem(vlineBuf:rsc(3)(0).@)#3 lines_read:write_mem(ylineBuf:rsc(4)(0).@)#4 lines_read:write_mem(ulineBuf:rsc(4)(0).@)#4 lines_read:write_mem(vlineBuf:rsc(4)(0).@)#4 lines_read:write_mem(ylineBuf:rsc(5)(0).@)#5 lines_read:write_mem(ulineBuf:rsc(5)(0).@)#5 lines_read:write_mem(vlineBuf:rsc(5)(0).@)#5 lines_read:write_mem(ylineBuf:rsc(6)(0).@)#6 lines_read:write_mem(ulineBuf:rsc(6)(0).@)#6 lines_read:write_mem(vlineBuf:rsc(6)(0).@)#6 yuvdns_col:if:write_mem(ylineBuf:rsc(7)(0).@) yuvdns_col:if:write_mem(ulineBuf:rsc(7)(0).@) yuvdns_col:if:write_mem(vlineBuf:rsc(7)(0).@)}
directive set /yuv444dns/core/addon_loop_2:for:read_mem(ulineBuf:rsc(5)(0).@) -IGNORE_DEPENDENCY_FROM {lines_read:write_mem(ylineBuf:rsc(0)(0).@) lines_read:write_mem(ulineBuf:rsc(0)(0).@) lines_read:write_mem(vlineBuf:rsc(0)(0).@) lines_read:write_mem(ylineBuf:rsc(1)(0).@)#1 lines_read:write_mem(ulineBuf:rsc(1)(0).@)#1 lines_read:write_mem(vlineBuf:rsc(1)(0).@)#1 lines_read:write_mem(ylineBuf:rsc(2)(0).@)#2 lines_read:write_mem(ulineBuf:rsc(2)(0).@)#2 lines_read:write_mem(vlineBuf:rsc(2)(0).@)#2 lines_read:write_mem(ylineBuf:rsc(3)(0).@)#3 lines_read:write_mem(ulineBuf:rsc(3)(0).@)#3 lines_read:write_mem(vlineBuf:rsc(3)(0).@)#3 lines_read:write_mem(ylineBuf:rsc(4)(0).@)#4 lines_read:write_mem(ulineBuf:rsc(4)(0).@)#4 lines_read:write_mem(vlineBuf:rsc(4)(0).@)#4 lines_read:write_mem(ylineBuf:rsc(5)(0).@)#5 lines_read:write_mem(ulineBuf:rsc(5)(0).@)#5 lines_read:write_mem(vlineBuf:rsc(5)(0).@)#5 lines_read:write_mem(ylineBuf:rsc(6)(0).@)#6 lines_read:write_mem(ulineBuf:rsc(6)(0).@)#6 lines_read:write_mem(vlineBuf:rsc(6)(0).@)#6 yuvdns_col:if:write_mem(ylineBuf:rsc(7)(0).@) yuvdns_col:if:write_mem(ulineBuf:rsc(7)(0).@) yuvdns_col:if:write_mem(vlineBuf:rsc(7)(0).@)}
directive set /yuv444dns/core/addon_loop_2:for:read_mem(ulineBuf:rsc(6)(0).@) -IGNORE_DEPENDENCY_FROM {lines_read:write_mem(ylineBuf:rsc(0)(0).@) lines_read:write_mem(ulineBuf:rsc(0)(0).@) lines_read:write_mem(vlineBuf:rsc(0)(0).@) lines_read:write_mem(ylineBuf:rsc(1)(0).@)#1 lines_read:write_mem(ulineBuf:rsc(1)(0).@)#1 lines_read:write_mem(vlineBuf:rsc(1)(0).@)#1 lines_read:write_mem(ylineBuf:rsc(2)(0).@)#2 lines_read:write_mem(ulineBuf:rsc(2)(0).@)#2 lines_read:write_mem(vlineBuf:rsc(2)(0).@)#2 lines_read:write_mem(ylineBuf:rsc(3)(0).@)#3 lines_read:write_mem(ulineBuf:rsc(3)(0).@)#3 lines_read:write_mem(vlineBuf:rsc(3)(0).@)#3 lines_read:write_mem(ylineBuf:rsc(4)(0).@)#4 lines_read:write_mem(ulineBuf:rsc(4)(0).@)#4 lines_read:write_mem(vlineBuf:rsc(4)(0).@)#4 lines_read:write_mem(ylineBuf:rsc(5)(0).@)#5 lines_read:write_mem(ulineBuf:rsc(5)(0).@)#5 lines_read:write_mem(vlineBuf:rsc(5)(0).@)#5 lines_read:write_mem(ylineBuf:rsc(6)(0).@)#6 lines_read:write_mem(ulineBuf:rsc(6)(0).@)#6 lines_read:write_mem(vlineBuf:rsc(6)(0).@)#6 yuvdns_col:if:write_mem(ylineBuf:rsc(7)(0).@) yuvdns_col:if:write_mem(ulineBuf:rsc(7)(0).@) yuvdns_col:if:write_mem(vlineBuf:rsc(7)(0).@)}
directive set /yuv444dns/core/addon_loop_2:for:read_mem(ulineBuf:rsc(7)(0).@) -IGNORE_DEPENDENCY_FROM {lines_read:write_mem(ylineBuf:rsc(0)(0).@) lines_read:write_mem(ulineBuf:rsc(0)(0).@) lines_read:write_mem(vlineBuf:rsc(0)(0).@) lines_read:write_mem(ylineBuf:rsc(1)(0).@)#1 lines_read:write_mem(ulineBuf:rsc(1)(0).@)#1 lines_read:write_mem(vlineBuf:rsc(1)(0).@)#1 lines_read:write_mem(ylineBuf:rsc(2)(0).@)#2 lines_read:write_mem(ulineBuf:rsc(2)(0).@)#2 lines_read:write_mem(vlineBuf:rsc(2)(0).@)#2 lines_read:write_mem(ylineBuf:rsc(3)(0).@)#3 lines_read:write_mem(ulineBuf:rsc(3)(0).@)#3 lines_read:write_mem(vlineBuf:rsc(3)(0).@)#3 lines_read:write_mem(ylineBuf:rsc(4)(0).@)#4 lines_read:write_mem(ulineBuf:rsc(4)(0).@)#4 lines_read:write_mem(vlineBuf:rsc(4)(0).@)#4 lines_read:write_mem(ylineBuf:rsc(5)(0).@)#5 lines_read:write_mem(ulineBuf:rsc(5)(0).@)#5 lines_read:write_mem(vlineBuf:rsc(5)(0).@)#5 lines_read:write_mem(ylineBuf:rsc(6)(0).@)#6 lines_read:write_mem(ulineBuf:rsc(6)(0).@)#6 lines_read:write_mem(vlineBuf:rsc(6)(0).@)#6 yuvdns_col:if:write_mem(ylineBuf:rsc(7)(0).@) yuvdns_col:if:write_mem(ulineBuf:rsc(7)(0).@) yuvdns_col:if:write_mem(vlineBuf:rsc(7)(0).@)}
directive set /yuv444dns/core/addon_loop_2:for:read_mem(vlineBuf:rsc(4)(0).@) -IGNORE_DEPENDENCY_FROM {lines_read:write_mem(ylineBuf:rsc(0)(0).@) lines_read:write_mem(ulineBuf:rsc(0)(0).@) lines_read:write_mem(vlineBuf:rsc(0)(0).@) lines_read:write_mem(ylineBuf:rsc(1)(0).@)#1 lines_read:write_mem(ulineBuf:rsc(1)(0).@)#1 lines_read:write_mem(vlineBuf:rsc(1)(0).@)#1 lines_read:write_mem(ylineBuf:rsc(2)(0).@)#2 lines_read:write_mem(ulineBuf:rsc(2)(0).@)#2 lines_read:write_mem(vlineBuf:rsc(2)(0).@)#2 lines_read:write_mem(ylineBuf:rsc(3)(0).@)#3 lines_read:write_mem(ulineBuf:rsc(3)(0).@)#3 lines_read:write_mem(vlineBuf:rsc(3)(0).@)#3 lines_read:write_mem(ylineBuf:rsc(4)(0).@)#4 lines_read:write_mem(ulineBuf:rsc(4)(0).@)#4 lines_read:write_mem(vlineBuf:rsc(4)(0).@)#4 lines_read:write_mem(ylineBuf:rsc(5)(0).@)#5 lines_read:write_mem(ulineBuf:rsc(5)(0).@)#5 lines_read:write_mem(vlineBuf:rsc(5)(0).@)#5 lines_read:write_mem(ylineBuf:rsc(6)(0).@)#6 lines_read:write_mem(ulineBuf:rsc(6)(0).@)#6 lines_read:write_mem(vlineBuf:rsc(6)(0).@)#6 yuvdns_col:if:write_mem(ylineBuf:rsc(7)(0).@) yuvdns_col:if:write_mem(ulineBuf:rsc(7)(0).@) yuvdns_col:if:write_mem(vlineBuf:rsc(7)(0).@)}
directive set /yuv444dns/core/addon_loop_2:for:read_mem(vlineBuf:rsc(5)(0).@) -IGNORE_DEPENDENCY_FROM {lines_read:write_mem(ylineBuf:rsc(0)(0).@) lines_read:write_mem(ulineBuf:rsc(0)(0).@) lines_read:write_mem(vlineBuf:rsc(0)(0).@) lines_read:write_mem(ylineBuf:rsc(1)(0).@)#1 lines_read:write_mem(ulineBuf:rsc(1)(0).@)#1 lines_read:write_mem(vlineBuf:rsc(1)(0).@)#1 lines_read:write_mem(ylineBuf:rsc(2)(0).@)#2 lines_read:write_mem(ulineBuf:rsc(2)(0).@)#2 lines_read:write_mem(vlineBuf:rsc(2)(0).@)#2 lines_read:write_mem(ylineBuf:rsc(3)(0).@)#3 lines_read:write_mem(ulineBuf:rsc(3)(0).@)#3 lines_read:write_mem(vlineBuf:rsc(3)(0).@)#3 lines_read:write_mem(ylineBuf:rsc(4)(0).@)#4 lines_read:write_mem(ulineBuf:rsc(4)(0).@)#4 lines_read:write_mem(vlineBuf:rsc(4)(0).@)#4 lines_read:write_mem(ylineBuf:rsc(5)(0).@)#5 lines_read:write_mem(ulineBuf:rsc(5)(0).@)#5 lines_read:write_mem(vlineBuf:rsc(5)(0).@)#5 lines_read:write_mem(ylineBuf:rsc(6)(0).@)#6 lines_read:write_mem(ulineBuf:rsc(6)(0).@)#6 lines_read:write_mem(vlineBuf:rsc(6)(0).@)#6 yuvdns_col:if:write_mem(ylineBuf:rsc(7)(0).@) yuvdns_col:if:write_mem(ulineBuf:rsc(7)(0).@) yuvdns_col:if:write_mem(vlineBuf:rsc(7)(0).@)}
directive set /yuv444dns/core/addon_loop_2:for:read_mem(vlineBuf:rsc(6)(0).@) -IGNORE_DEPENDENCY_FROM {lines_read:write_mem(ylineBuf:rsc(0)(0).@) lines_read:write_mem(ulineBuf:rsc(0)(0).@) lines_read:write_mem(vlineBuf:rsc(0)(0).@) lines_read:write_mem(ylineBuf:rsc(1)(0).@)#1 lines_read:write_mem(ulineBuf:rsc(1)(0).@)#1 lines_read:write_mem(vlineBuf:rsc(1)(0).@)#1 lines_read:write_mem(ylineBuf:rsc(2)(0).@)#2 lines_read:write_mem(ulineBuf:rsc(2)(0).@)#2 lines_read:write_mem(vlineBuf:rsc(2)(0).@)#2 lines_read:write_mem(ylineBuf:rsc(3)(0).@)#3 lines_read:write_mem(ulineBuf:rsc(3)(0).@)#3 lines_read:write_mem(vlineBuf:rsc(3)(0).@)#3 lines_read:write_mem(ylineBuf:rsc(4)(0).@)#4 lines_read:write_mem(ulineBuf:rsc(4)(0).@)#4 lines_read:write_mem(vlineBuf:rsc(4)(0).@)#4 lines_read:write_mem(ylineBuf:rsc(5)(0).@)#5 lines_read:write_mem(ulineBuf:rsc(5)(0).@)#5 lines_read:write_mem(vlineBuf:rsc(5)(0).@)#5 lines_read:write_mem(ylineBuf:rsc(6)(0).@)#6 lines_read:write_mem(ulineBuf:rsc(6)(0).@)#6 lines_read:write_mem(vlineBuf:rsc(6)(0).@)#6 yuvdns_col:if:write_mem(ylineBuf:rsc(7)(0).@) yuvdns_col:if:write_mem(ulineBuf:rsc(7)(0).@) yuvdns_col:if:write_mem(vlineBuf:rsc(7)(0).@)}
directive set /yuv444dns/core/addon_loop_2:for:read_mem(vlineBuf:rsc(7)(0).@) -IGNORE_DEPENDENCY_FROM {lines_read:write_mem(ylineBuf:rsc(0)(0).@) lines_read:write_mem(ulineBuf:rsc(0)(0).@) lines_read:write_mem(vlineBuf:rsc(0)(0).@) lines_read:write_mem(ylineBuf:rsc(1)(0).@)#1 lines_read:write_mem(ulineBuf:rsc(1)(0).@)#1 lines_read:write_mem(vlineBuf:rsc(1)(0).@)#1 lines_read:write_mem(ylineBuf:rsc(2)(0).@)#2 lines_read:write_mem(ulineBuf:rsc(2)(0).@)#2 lines_read:write_mem(vlineBuf:rsc(2)(0).@)#2 lines_read:write_mem(ylineBuf:rsc(3)(0).@)#3 lines_read:write_mem(ulineBuf:rsc(3)(0).@)#3 lines_read:write_mem(vlineBuf:rsc(3)(0).@)#3 lines_read:write_mem(ylineBuf:rsc(4)(0).@)#4 lines_read:write_mem(ulineBuf:rsc(4)(0).@)#4 lines_read:write_mem(vlineBuf:rsc(4)(0).@)#4 lines_read:write_mem(ylineBuf:rsc(5)(0).@)#5 lines_read:write_mem(ulineBuf:rsc(5)(0).@)#5 lines_read:write_mem(vlineBuf:rsc(5)(0).@)#5 lines_read:write_mem(ylineBuf:rsc(6)(0).@)#6 lines_read:write_mem(ulineBuf:rsc(6)(0).@)#6 lines_read:write_mem(vlineBuf:rsc(6)(0).@)#6 yuvdns_col:if:write_mem(ylineBuf:rsc(7)(0).@) yuvdns_col:if:write_mem(ulineBuf:rsc(7)(0).@) yuvdns_col:if:write_mem(vlineBuf:rsc(7)(0).@)}
go allocate
go extract
//  Catapult Prime Synthesis 2022.1/981271 (Production Release) Thu Feb 10 22:05:20 PST 2022
//
//          Copyright (c) Siemens EDA, 1996-2022, All Rights Reserved.
//                        UNPUBLISHED, LICENSED SOFTWARE.
//             CONFIDENTIAL AND PROPRIETARY INFORMATION WHICH IS THE
//                   PROPERTY OF SIEMENS EDA OR ITS LICENSORS.
//
//  Running on Linux wanwei.xiao@alish-rs-cs08.eng.t-head.cn 3.10.0-1160.66.1.el7.x86_64 x86_64 aol
//
//  Package information: SIFLIBS v25.1_0.0, HLS_PKGS v25.1_0.0,
//                       SIF_TOOLKITS v25.1_0.0, SIF_XILINX v25.1_0.0,
//                       SIF_ALTERA v25.1_0.0, CCS_LIBS v25.1_0.0,
//                       CDS_PPRO v10.6, CDS_DesigChecker v2022.1,
//                       CDS_OASYS v21.1_2.5, CDS_PSR v21.1_0.4,
//                       DesignPad v2.78_1.0
//
solution new -state initial
solution options defaults
solution options set /Input/CppStandard c++11
solution options set /Output/GenerateCycleNetlist false
solution options set /Flows/SCVerify/USE_QUESTASIM false
solution options set /Flows/SCVerify/USE_OSCI false
solution options set /Flows/SCVerify/USE_VCS true
solution options set /Flows/VCS/VG_ENV32_SCRIPT source_me_gcc483_32.csh
solution options set /Flows/VCS/VG_ENV64_SCRIPT source_me_gcc483_64.csh
solution options set /Flows/VCS/VLOGAN_OPTS {+v2k +no_tchk_msg -kdb -lca}
solution options set /Flows/VCS/VCSELAB_OPTS {-debug_acc+all -debug_region+cell+encrypt -timescale=1ps/1ps -sysc=blocksync -sysc=2.3.1 -sysc=slow_sc_main}
solution options set /Flows/VCS/SYSC_VERSION 2.3.1
flow package require /SCVerify
solution file add ../src/scaledown.h -type CHEADER -exclude true
solution file add ../src/scaledown.cpp -type C++
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
directive set -IDLE_SIGNAL {}
directive set -STALL_FLAG_SV off
directive set -STALL_FLAG false
directive set -TRANSACTION_DONE_SIGNAL true
directive set -DONE_FLAG {}
directive set -READY_FLAG {}
directive set -START_FLAG {}
directive set -TRANSACTION_SYNC ready
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
directive set -PROTOTYPING_ENGINE oasys
directive set -PIPELINE_RAMP_UP true
go new
solution design set scaledown -top
solution design set ac::fx_div<8> -block
go analyze
go compile
solution library add nangate-45nm_beh -- -rtlsyntool DesignCompiler -vendor Nangate -technology 045nm
solution library add ccs_sample_mem
go libraries
directive set -CLOCKS {clk {-CLOCK_PERIOD 3.33 -CLOCK_EDGE rising -CLOCK_UNCERTAINTY 0.0 -CLOCK_HIGH_TIME 1.665 -RESET_SYNC_NAME rst -RESET_ASYNC_NAME arst_n -RESET_KIND sync -RESET_SYNC_ACTIVE high -RESET_ASYNC_ACTIVE low -ENABLE_ACTIVE high}}
go assembly
directive set /scaledown/top_reg.frameWidth:rsc -MAP_TO_MODULE {[DirectInput]}
directive set /scaledown/top_reg.frameHeight:rsc -MAP_TO_MODULE {[DirectInput]}
directive set /scaledown/top_reg.inputFormat:rsc -MAP_TO_MODULE {[DirectInput]}
directive set /scaledown/top_reg.imgPattern:rsc -MAP_TO_MODULE {[DirectInput]}
directive set /scaledown/top_reg.pipeMode:rsc -MAP_TO_MODULE {[DirectInput]}
directive set /scaledown/top_reg.blc:rsc -MAP_TO_MODULE {[DirectInput]}
directive set /scaledown/top_reg.shadowEb:rsc -MAP_TO_MODULE {[DirectInput]}
directive set /scaledown/top_reg.binningFrameWidth:rsc -MAP_TO_MODULE {[DirectInput]}
directive set /scaledown/top_reg.binningFrameHeight:rsc -MAP_TO_MODULE {[DirectInput]}
directive set /scaledown/top_reg.scalerFrameWidth:rsc -MAP_TO_MODULE {[DirectInput]}
directive set /scaledown/top_reg.scalerFrameHeight:rsc -MAP_TO_MODULE {[DirectInput]}
directive set /scaledown/scaledown_reg.m_nEb:rsc -MAP_TO_MODULE {[DirectInput]}
directive set /scaledown/scaledown_reg.yuvpattern:rsc -MAP_TO_MODULE {[DirectInput]}
directive set /scaledown/scaledown_reg.times:rsc -MAP_TO_MODULE {[DirectInput]}
directive set /scaledown/core/y_linebuffer:rsc -BLOCK_SIZE 8192
directive set /scaledown/core/u_linebuffer:rsc -BLOCK_SIZE 8192
directive set /scaledown/core/v_linebuffer:rsc -BLOCK_SIZE 8192
directive set /scaledown/core/main -PIPELINE_INIT_INTERVAL 1
go architect
go extract
//  Catapult Prime Synthesis 2022.1/981271 (Production Release) Thu Feb 10 22:05:20 PST 2022
//
//          Copyright (c) Siemens EDA, 1996-2022, All Rights Reserved.
//                        UNPUBLISHED, LICENSED SOFTWARE.
//             CONFIDENTIAL AND PROPRIETARY INFORMATION WHICH IS THE
//                   PROPERTY OF SIEMENS EDA OR ITS LICENSORS.
//
//  Running on Linux wanwei.xiao@alish-rs-cs08.eng.t-head.cn 3.10.0-1160.66.1.el7.x86_64 x86_64 aol
//
//  Package information: SIFLIBS v25.1_0.0, HLS_PKGS v25.1_0.0,
//                       SIF_TOOLKITS v25.1_0.0, SIF_XILINX v25.1_0.0,
//                       SIF_ALTERA v25.1_0.0, CCS_LIBS v25.1_0.0,
//                       CDS_PPRO v10.6, CDS_DesigChecker v2022.1,
//                       CDS_OASYS v21.1_2.5, CDS_PSR v21.1_0.4,
//                       DesignPad v2.78_1.0
//
solution new -state initial
solution options defaults
solution options set /Input/CppStandard c++11
solution options set /Output/GenerateCycleNetlist false
solution options set /Flows/SCVerify/USE_QUESTASIM false
solution options set /Flows/SCVerify/USE_OSCI false
solution options set /Flows/SCVerify/USE_VCS true
solution options set /Flows/VCS/VG_ENV32_SCRIPT source_me_gcc483_32.csh
solution options set /Flows/VCS/VG_ENV64_SCRIPT source_me_gcc483_64.csh
solution options set /Flows/VCS/VLOGAN_OPTS {+v2k +no_tchk_msg -kdb -lca}
solution options set /Flows/VCS/VCSELAB_OPTS {-debug_acc+all -debug_region+cell+encrypt -timescale=1ps/1ps -sysc=blocksync -sysc=2.3.1 -sysc=slow_sc_main}
solution options set /Flows/VCS/SYSC_VERSION 2.3.1
flow package require /SCVerify
solution file add ../src/crop.cpp -type C++
solution file add ../src/crop.h -type CHEADER -exclude true
solution file add ../tb/tb_crop_catapult.cpp -type C++ -exclude true
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
directive set -IDLE_SIGNAL {}
directive set -STALL_FLAG_SV off
directive set -STALL_FLAG false
directive set -TRANSACTION_DONE_SIGNAL true
directive set -DONE_FLAG {}
directive set -READY_FLAG {}
directive set -START_FLAG {}
directive set -TRANSACTION_SYNC ready
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
directive set -PROTOTYPING_ENGINE oasys
directive set -PIPELINE_RAMP_UP true
go new
solution design set crop -top
solution design set ac::fx_div<8> -block
solution design set crop -top
go analyze
go compile
solution library add nangate-45nm_beh -- -rtlsyntool DesignCompiler -vendor Nangate -technology 045nm
solution library add ccs_sample_mem
go libraries
directive set -CLOCKS {clk {-CLOCK_PERIOD 3.33 -CLOCK_EDGE rising -CLOCK_UNCERTAINTY 0.0 -CLOCK_HIGH_TIME 1.665 -RESET_SYNC_NAME rst -RESET_ASYNC_NAME arst_n -RESET_KIND sync -RESET_SYNC_ACTIVE high -RESET_ASYNC_ACTIVE low -ENABLE_ACTIVE high}}
go assembly
directive set /crop/top_reg.frameWidth:rsc -MAP_TO_MODULE {[DirectInput]}
directive set /crop/top_reg.frameHeight:rsc -MAP_TO_MODULE {[DirectInput]}
directive set /crop/top_reg.inputFormat:rsc -MAP_TO_MODULE {[DirectInput]}
directive set /crop/top_reg.imgPattern:rsc -MAP_TO_MODULE {[DirectInput]}
directive set /crop/top_reg.pipeMode:rsc -MAP_TO_MODULE {[DirectInput]}
directive set /crop/top_reg.blc:rsc -MAP_TO_MODULE {[DirectInput]}
directive set /crop/top_reg.shadowEb:rsc -MAP_TO_MODULE {[DirectInput]}
directive set /crop/top_reg.binningFrameWidth:rsc -MAP_TO_MODULE {[DirectInput]}
directive set /crop/top_reg.binningFrameHeight:rsc -MAP_TO_MODULE {[DirectInput]}
directive set /crop/top_reg.scalerFrameWidth:rsc -MAP_TO_MODULE {[DirectInput]}
directive set /crop/top_reg.scalerFrameHeight:rsc -MAP_TO_MODULE {[DirectInput]}
directive set /crop/crop_reg.m_nEb:rsc -MAP_TO_MODULE {[DirectInput]}
directive set /crop/crop_reg.upper_left_x:rsc -MAP_TO_MODULE {[DirectInput]}
directive set /crop/crop_reg.upper_left_y:rsc -MAP_TO_MODULE {[DirectInput]}
directive set /crop/crop_reg.lower_right_x:rsc -MAP_TO_MODULE {[DirectInput]}
directive set /crop/crop_reg.lower_right_y:rsc -MAP_TO_MODULE {[DirectInput]}
directive set /crop/crop_reg.yuvpattern:rsc -MAP_TO_MODULE {[DirectInput]}
directive set /crop/core/main -PIPELINE_INIT_INTERVAL 1
go architect
go extract
//  Catapult Prime Synthesis 2022.1/981271 (Production Release) Thu Feb 10 22:05:20 PST 2022
//
//          Copyright (c) Siemens EDA, 1996-2022, All Rights Reserved.
//                        UNPUBLISHED, LICENSED SOFTWARE.
//             CONFIDENTIAL AND PROPRIETARY INFORMATION WHICH IS THE
//                   PROPERTY OF SIEMENS EDA OR ITS LICENSORS.
//
//  Running on Linux wanwei.xiao@alish-rs-cs08.eng.t-head.cn 3.10.0-1160.66.1.el7.x86_64 x86_64 aol
//
//  Package information: SIFLIBS v25.1_0.0, HLS_PKGS v25.1_0.0,
//                       SIF_TOOLKITS v25.1_0.0, SIF_XILINX v25.1_0.0,
//                       SIF_ALTERA v25.1_0.0, CCS_LIBS v25.1_0.0,
//                       CDS_PPRO v10.6, CDS_DesigChecker v2022.1,
//                       CDS_OASYS v21.1_2.5, CDS_PSR v21.1_0.4,
//                       DesignPad v2.78_1.0
//
solution new -state initial
solution options defaults
solution options set /Input/CppStandard c++11
solution options set /Output/GenerateCycleNetlist false
solution options set /Flows/SCVerify/USE_QUESTASIM false
solution options set /Flows/SCVerify/USE_OSCI false
solution options set /Flows/SCVerify/USE_VCS true
solution options set /Flows/VCS/VG_ENV32_SCRIPT source_me_gcc483_32.csh
solution options set /Flows/VCS/VG_ENV64_SCRIPT source_me_gcc483_64.csh
solution options set /Flows/VCS/VLOGAN_OPTS {+v2k +no_tchk_msg -kdb -lca}
solution options set /Flows/VCS/VCSELAB_OPTS {-debug_acc+all -debug_region+cell+encrypt -timescale=1ps/1ps -sysc=blocksync -sysc=2.3.1 -sysc=slow_sc_main}
solution options set /Flows/VCS/SYSC_VERSION 2.3.1
flow package require /SCVerify
solution file add ../src/awb.h -type CHEADER -exclude true
solution file add ../src/awb.cpp -type C++
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
directive set -IDLE_SIGNAL {}
directive set -STALL_FLAG_SV off
directive set -STALL_FLAG false
directive set -TRANSACTION_DONE_SIGNAL true
directive set -DONE_FLAG {}
directive set -READY_FLAG {}
directive set -START_FLAG {}
directive set -TRANSACTION_SYNC ready
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
directive set -PROTOTYPING_ENGINE oasys
directive set -PIPELINE_RAMP_UP true
go new
solution design set awb -top
solution design set ac::fx_div<8> -block
go compile
solution library add nangate-45nm_beh -- -rtlsyntool DesignCompiler -vendor Nangate -technology 045nm
solution library add ccs_sample_mem
go libraries
directive set -CLOCKS {clk {-CLOCK_PERIOD 3.33 -CLOCK_EDGE rising -CLOCK_UNCERTAINTY 0.0 -CLOCK_HIGH_TIME 1.665 -RESET_SYNC_NAME rst -RESET_ASYNC_NAME arst_n -RESET_KIND sync -RESET_SYNC_ACTIVE high -RESET_ASYNC_ACTIVE low -ENABLE_ACTIVE high}}
go assembly
directive set /awb/top_reg.frameWidth:rsc -MAP_TO_MODULE {[DirectInput]}
directive set /awb/top_reg.frameHeight:rsc -MAP_TO_MODULE {[DirectInput]}
directive set /awb/top_reg.inputFormat:rsc -MAP_TO_MODULE {[DirectInput]}
directive set /awb/top_reg.imgPattern:rsc -MAP_TO_MODULE {[DirectInput]}
directive set /awb/top_reg.pipeMode:rsc -MAP_TO_MODULE {[DirectInput]}
directive set /awb/top_reg.blc:rsc -MAP_TO_MODULE {[DirectInput]}
directive set /awb/top_reg.shadowEb:rsc -MAP_TO_MODULE {[DirectInput]}
directive set /awb/top_reg.binningFrameWidth:rsc -MAP_TO_MODULE {[DirectInput]}
directive set /awb/top_reg.binningFrameHeight:rsc -MAP_TO_MODULE {[DirectInput]}
directive set /awb/top_reg.scalerFrameWidth:rsc -MAP_TO_MODULE {[DirectInput]}
directive set /awb/top_reg.scalerFrameHeight:rsc -MAP_TO_MODULE {[DirectInput]}
directive set /awb/awb_reg.m_nEb:rsc -MAP_TO_MODULE {[DirectInput]}
directive set /awb/awb_reg.coeff:rsc -MAP_TO_MODULE {[DirectInput]}
directive set /awb/core/main -PIPELINE_INIT_INTERVAL 1
go architect
go extract
//  Catapult Prime Synthesis 2022.1/981271 (Production Release) Thu Feb 10 22:05:20 PST 2022
//
//          Copyright (c) Siemens EDA, 1996-2022, All Rights Reserved.
//                        UNPUBLISHED, LICENSED SOFTWARE.
//             CONFIDENTIAL AND PROPRIETARY INFORMATION WHICH IS THE
//                   PROPERTY OF SIEMENS EDA OR ITS LICENSORS.
//
//  Running on Linux wanwei.xiao@alish-rs-cs08.eng.t-head.cn 3.10.0-1160.66.1.el7.x86_64 x86_64 aol
//
//  Package information: SIFLIBS v25.1_0.0, HLS_PKGS v25.1_0.0,
//                       SIF_TOOLKITS v25.1_0.0, SIF_XILINX v25.1_0.0,
//                       SIF_ALTERA v25.1_0.0, CCS_LIBS v25.1_0.0,
//                       CDS_PPRO v10.6, CDS_DesigChecker v2022.1,
//                       CDS_OASYS v21.1_2.5, CDS_PSR v21.1_0.4,
//                       DesignPad v2.78_1.0
//
solution new -state initial
solution options defaults
solution options set /Input/CppStandard c++11
solution options set /Output/GenerateCycleNetlist false
solution options set /Flows/SCVerify/USE_QUESTASIM false
solution options set /Flows/SCVerify/USE_OSCI false
solution options set /Flows/SCVerify/USE_VCS true
solution options set /Flows/VCS/VG_ENV32_SCRIPT source_me_gcc483_32.csh
solution options set /Flows/VCS/VG_ENV64_SCRIPT source_me_gcc483_64.csh
solution options set /Flows/VCS/VLOGAN_OPTS {+v2k +no_tchk_msg -kdb -lca}
solution options set /Flows/VCS/VCSELAB_OPTS {-debug_acc+all -debug_region+cell+encrypt -timescale=1ps/1ps -sysc=blocksync -sysc=2.3.1 -sysc=slow_sc_main}
solution options set /Flows/VCS/SYSC_VERSION 2.3.1
flow package require /SCVerify
solution file add ../src/afc.h -type CHEADER -exclude true
solution file add ../src/afc.cpp -type C++
solution file add ../src/crop.cpp -type C++
solution file add ../src/crop.h -type CHEADER -exclude true
solution file add ../src/awb.h -type CHEADER -exclude true
solution file add ../src/csc.cpp -type C++
solution file add ../src/cac.h -type CHEADER -exclude true
solution file add ../src/cmc.cpp -type C++
solution file add ../src/cac.cpp -type C++
solution file add ../src/awb.cpp -type C++
solution file add ../src/csc.h -type CHEADER -exclude true
solution file add ../src/cmc.h -type CHEADER -exclude true
solution file add ../src/dpc.h -type CHEADER -exclude true
solution file add ../src/demosaic.h -type CHEADER -exclude true
solution file add ../src/ee.cpp -type C++
solution file add ../src/dpc.cpp -type C++
solution file add ../src/ee.h -type CHEADER -exclude true
solution file add ../src/dgain.cpp -type C++
solution file add ../src/dgain.h -type CHEADER -exclude true
solution file add ../src/demosaic.cpp -type C++
solution file add ../src/gb.h -type CHEADER -exclude true
solution file add ../src/gb.cpp -type C++
solution file add ../src/gtm.cpp -type C++
solution file add ../src/file_define_catapult.h -type CHEADER -exclude true
solution file add ../src/gtm.h -type CHEADER -exclude true
solution file add ../src/top.h -type CHEADER -exclude true
solution file add ../src/lut.cpp -type C++
solution file add ../src/top.cpp -type C++
solution file add ../src/lut.h -type CHEADER -exclude true
solution file add ../src/ltm.cpp -type C++
solution file add ../src/scaledown.h -type CHEADER -exclude true
solution file add ../src/rawdns.h -type CHEADER -exclude true
solution file add ../src/scaledown.cpp -type C++
solution file add ../src/lsc.cpp -type C++
solution file add ../src/lsc.h -type CHEADER -exclude true
solution file add ../src/ltm.h -type CHEADER -exclude true
solution file add ../src/rawdns.cpp -type C++
solution file add ../src/tpg.cpp -type C++
solution file add ../src/yuvdns.cpp -type C++
solution file add ../src/yfc.h -type CHEADER -exclude true
solution file add ../src/wbc.h -type CHEADER -exclude true
solution file add ../src/yfc.cpp -type C++
solution file add ../src/wbc.cpp -type C++
solution file add ../src/yuvdns.h -type CHEADER -exclude true
solution file add ../src/tpg.h -type CHEADER -exclude true
solution file add ../tb/tb_top_catapult.cpp -type C++ -exclude true
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
directive set -IDLE_SIGNAL {}
directive set -STALL_FLAG_SV off
directive set -STALL_FLAG false
directive set -TRANSACTION_DONE_SIGNAL true
directive set -DONE_FLAG {}
directive set -READY_FLAG {}
directive set -START_FLAG {}
directive set -TRANSACTION_SYNC ready
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
directive set -PROTOTYPING_ENGINE oasys
directive set -PIPELINE_RAMP_UP true
go new
solution design set afc -block
solution design set crop -block
solution design set ac::fx_div<8> -block
solution design set csc -block
solution design set cmc -block
solution design set cac -block
solution design set awb -block
solution design set edgeenhancement -block
solution design set dpc -block
solution design set dgain -block
solution design set demosaic -block
solution design set greenbalance2 -block
solution design set gtm -block
solution design set lut -block
solution design set isp_top -top
solution design set ltm -block
solution design set scaledown -block
solution design set lsc -block
solution design set isp_rawdns -block
solution design set tpg -block
solution design set yuv444dns -block
solution design set yfc -block
solution design set wbc -block
go compile
solution library add nangate-45nm_beh -- -rtlsyntool DesignCompiler -vendor Nangate -technology 045nm
solution library add ccs_sample_mem
solution library add {[Block] afc.v1}
solution library add {[Block] awb.v1}
solution library add {[Block] cac.v1}
solution library add {[Block] cmc.v1}
solution library add {[Block] crop.v1}
solution library add {[Block] csc.v1}
solution library add {[Block] demosaic.v1}
solution library add {[Block] dgain.v1}
solution library add {[Block] dpc.v1}
solution library add {[Block] edgeenhancement.v1}
solution library add {[Block] greenbalance2.v1}
solution library add {[Block] gtm.v1}
solution library add {[Block] isp_rawdns.v1}
solution library add {[Block] lsc.v1}
solution library add {[Block] ltm.v1}
solution library add {[Block] lut.v1}
solution library add {[Block] scaledown.v1}
solution library add {[Block] tpg.v1}
solution library add {[Block] wbc.v1}
solution library add {[Block] yfc.v1}
solution library add {[Block] yuv444dns.v1}
go libraries
directive set -CLOCKS {clk {-CLOCK_PERIOD 3.33 -CLOCK_EDGE rising -CLOCK_UNCERTAINTY 0.0 -CLOCK_HIGH_TIME 1.665 -RESET_SYNC_NAME rst -RESET_ASYNC_NAME arst_n -RESET_KIND sync -RESET_SYNC_ACTIVE high -RESET_ASYNC_ACTIVE low -ENABLE_ACTIVE high}}
directive set /isp_top/dpc -MAP_TO_MODULE {[Block] afc.v1}
directive set /isp_top/dpc -MAP_TO_MODULE {[Block] dpc.v1}
directive set /isp_top/lsc -MAP_TO_MODULE {[Block] lsc.v1}
directive set /isp_top/crop -MAP_TO_MODULE {[Block] crop.v1}
directive set /isp_top/tpg -MAP_TO_MODULE {[Block] tpg.v1}
directive set /isp_top/dgain -MAP_TO_MODULE {[Block] dgain.v1}
directive set /isp_top/scaledown -MAP_TO_MODULE {[Block] scaledown.v1}
directive set /isp_top/yuv444dns -MAP_TO_MODULE {[Block] yuv444dns.v1}
directive set /isp_top/yfc -MAP_TO_MODULE {[Block] yfc.v1}
directive set /isp_top/csc -MAP_TO_MODULE {[Block] csc.v1}
directive set /isp_top/cac -MAP_TO_MODULE {[Block] cac.v1}
directive set /isp_top/ltm -MAP_TO_MODULE {[Block] ltm.v1}
directive set /isp_top/lut -MAP_TO_MODULE {[Block] lut.v1}
directive set /isp_top/gtm -MAP_TO_MODULE {[Block] gtm.v1}
directive set /isp_top/cmc -MAP_TO_MODULE {[Block] cmc.v1}
directive set /isp_top/edgeenhancement -MAP_TO_MODULE {[Block] edgeenhancement.v1}
directive set /isp_top/demosaic -MAP_TO_MODULE {[Block] demosaic.v1}
directive set /isp_top/greenbalance2 -MAP_TO_MODULE {[Block] greenbalance2.v1}
directive set /isp_top/wbc -MAP_TO_MODULE {[Block] wbc.v1}
directive set /isp_top/awb -MAP_TO_MODULE {[Block] awb.v1}
directive set /isp_top/isp_rawdns -MAP_TO_MODULE {[Block] isp_rawdns.v1}
go assembly
directive set /isp_top/afc_tpg_data:cns -FIFO_DEPTH 12
directive set /isp_top/tpg_dgain_data:cns -FIFO_DEPTH 12
directive set /isp_top/dgain_lsc_data:cns -FIFO_DEPTH 5
directive set /isp_top/lsc_dpc_data:cns -FIFO_DEPTH 5
directive set /isp_top/dpc_rawdns_data:cns -FIFO_DEPTH 25
directive set /isp_top/rawdns_awb_data:cns -FIFO_DEPTH 12
directive set /isp_top/awb_wbc_data:cns -FIFO_DEPTH 3
directive set /isp_top/wbc_gb_data:cns -FIFO_DEPTH 4
directive set /isp_top/gb_demosaic_data:cns -FIFO_DEPTH 13
directive set /isp_top/demosaic_ee_data:cns -FIFO_DEPTH 14
directive set /isp_top/ee_cmc_data:cns -FIFO_DEPTH 13
directive set /isp_top/cmc_gtm_data:cns -FIFO_DEPTH 5
directive set /isp_top/gtm_lut_data:cns -FIFO_DEPTH 5
directive set /isp_top/lut_ltm_data:cns -FIFO_DEPTH 22
directive set /isp_top/ltm_cac_data:cns -FIFO_DEPTH 15
directive set /isp_top/cac_csc_data:cns -FIFO_DEPTH 13
directive set /isp_top/csc_yfc_data:cns -FIFO_DEPTH 3
directive set /isp_top/yfc_yuvdns_data_y:cns -FIFO_DEPTH 30
directive set /isp_top/yfc_yuvdns_data_u:cns -FIFO_DEPTH 30
directive set /isp_top/yfc_yuvdns_data_v:cns -FIFO_DEPTH 30
directive set /isp_top/yuvdns_scale_data_y:cns -FIFO_DEPTH 12
directive set /isp_top/yuvdns_scale_data_u:cns -FIFO_DEPTH 12
directive set /isp_top/yuvdns_scale_data_v:cns -FIFO_DEPTH 12
directive set /isp_top/scale_crop_data_y:cns -FIFO_DEPTH 12
directive set /isp_top/scale_crop_data_u:cns -FIFO_DEPTH 13
directive set /isp_top/scale_crop_data_v:cns -FIFO_DEPTH 13
go architect
go extract
