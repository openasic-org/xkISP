#weiyuheng 20220901
open_project top
set_top isp_top
add_files ../src/tpg.cpp
add_files ../src/tpg.h
add_files ../src/dgain.cpp
add_files ../src/dgain.h
add_files ../src/lsc.cpp
add_files ../src/lsc.h
add_files ../src/dpc.cpp
add_files ../src/dpc.h
add_files ../src/rawdns.cpp
add_files ../src/rawdns.h
add_files ../src/awb.cpp
add_files ../src/awb.h
add_files ../src/wbc.cpp
add_files ../src/wbc.h
add_files ../src/gb.cpp
add_files ../src/gb.h
add_files ../src/demosaic.cpp
add_files ../src/demosaic.h
add_files ../src/ee.cpp
add_files ../src/ee.h
add_files ../src/cmc.cpp
add_files ../src/cmc.h
add_files ../src/gtm.cpp
add_files ../src/gtm.h
add_files ../src/ltm.cpp
add_files ../src/ltm.h
add_files ../src/cac.cpp
add_files ../src/cac.h
add_files ../src/csc.cpp
add_files ../src/csc.h
add_files ../src/yfc.cpp
add_files ../src/yfc.h
add_files ../src/yuvdns.cpp
add_files ../src/yuvdns.h
add_files ../src/scaledown.cpp
add_files ../src/scaledown.h
add_files ../src/crop.cpp
add_files ../src/crop.h
add_files ../src/top.cpp
add_files ../src/top.h
add_files ../src/isp_top.h
add_files -tb ../tb/tb_top.cpp
open_solution "top"
source "./top_directives.tcl"
source "./script.tcl"