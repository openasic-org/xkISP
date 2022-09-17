//  Catapult Prime Synthesis 10.5/861329 (Production Release) Wed Mar  4 15:45:36 PST 2020
//  
//  Copyright (c) Mentor Graphics Corporation, 1996-2020, All Rights Reserved.
//                        UNPUBLISHED, LICENSED SOFTWARE.
//             CONFIDENTIAL AND PROPRIETARY INFORMATION WHICH IS THE
//                 PROPERTY OF MENTOR GRAPHICS OR ITS LICENSORS
//  
//  Running on Linux hongbo.ke@sh01rs-rain.eng.t-head.cn 3.10.0-1127.el7.x86_64 x86_64 aol
//  
//  Package information: SIFLIBS v23.5_0.0, HLS_PKGS v23.5_0.0, 
//                       SIF_TOOLKITS v23.5_0.0, SIF_XILINX v23.5_0.0, 
//                       SIF_ALTERA v23.5_0.0, CCS_LIBS v23.5_0.0, 
//                       CDS_PPRO v10.3c_2, CDS_DesigChecker v10.5, 
//                       CDS_OASYS v19.1_3.7, CDS_PSR v19.2_0.9, 
//                       DesignPad v2.78_1.0
//  
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
directive set -PIPELINE_RAMP_UP true
directive set -CLUSTER_TYPE combinational
directive set -CLUSTER_FAST_MODE false
directive set -CLUSTER_RTL_SYN false
directive set -CLUSTER_OPT_CONSTANT_INPUTS true
directive set -CLUSTER_ADDTREE_IN_COUNT_THRESHOLD 0
directive set -CLUSTER_ADDTREE_IN_WIDTH_THRESHOLD 0
directive set -ROM_THRESHOLD 64
directive set -PROTOTYPE_ROM true
directive set -CHARACTERIZE_ROM false
directive set -OPT_CONST_MULTS use_library
directive set -CLOCK_OVERHEAD 20.000000
directive set -RESET_CLEARS_ALL_REGS use_library
directive set -START_FLAG {}
directive set -READY_FLAG {}
directive set -DONE_FLAG {}
directive set -TRANSACTION_DONE_SIGNAL true
directive set -STALL_FLAG false
directive set -IDLE_SIGNAL {}
directive set -REGISTER_IDLE_SIGNAL false
directive set -ARRAY_SIZE 1024
directive set -CHAN_IO_PROTOCOL use_library
directive set -IO_MODE super
directive set -UNROLL no
directive set -REALLOC true
directive set -MUXPATH true
directive set -TIMING_CHECKS true
directive set -ASSIGN_OVERHEAD 0
directive set -REGISTER_SHARING_LIMIT 0
directive set -REGISTER_SHARING_MAX_WIDTH_DIFFERENCE 8
directive set -SAFE_FSM false
directive set -NO_X_ASSIGNMENTS true
directive set -REG_MAX_FANOUT 0
directive set -FSM_BINARY_ENCODING_THRESHOLD 64
directive set -FSM_ENCODING none
directive set -LOGIC_OPT false
directive set -MEM_MAP_THRESHOLD 32
directive set -REGISTER_THRESHOLD 256
directive set -MERGEABLE true
directive set -SPECULATE true
directive set -DESIGN_GOAL area
go new
solution design set dgain -block
solution design set lsc -block
solution design set dpc -block
solution design set isp_rawdns -top
solution design set isp_rawdns -block
solution design set dpc -block
solution design set lsc -block
solution design set dgain -block
solution design set awb -top
solution design set dgain -block
solution design set lsc -block
solution design set dpc -block
solution design set isp_rawdns -block
solution design set awb -block
solution design set demosaic -block
solution design set csc -top
solution design set csc -block
solution design set demosaic -block
solution design set awb -block
solution design set isp_rawdns -block
solution design set dpc -block
solution design set lsc -block
solution design set dgain -block
solution design set yfc -top
solution library add mgc_Xilinx-VIRTEX-uplus-1_beh -- -rtlsyntool Vivado -manufacturer Xilinx -family VIRTEX-uplus -speed -1 -part xcvu9p-flgb2104-1-e
solution library add Xilinx_RAMS
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
