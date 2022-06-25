#yanheng 20210221
open_project cmc
set_top cmc
add_files ../src/cmc.cpp
add_files ../src/cmc.h
add_files ../src/top.h
add_files -tb ../tb/tb_cmc.cpp
open_solution "cmc"
source "./cmc_directives.tcl"
source "./script.tcl"
