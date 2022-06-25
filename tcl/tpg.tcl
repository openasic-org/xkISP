#yanheng 20210221
open_project tpg
set_top tpg
add_files ../src/tpg.cpp
add_files ../src/tpg.h
add_files ../src/top.h
add_files -tb ../tb/tb_tpg.cpp
open_solution "tpg"
source "./tpg_directives.tcl"
source "./script.tcl"
