#yanheng 20210221
open_project lsc
set_top lsc
add_files ../src/lsc.cpp
add_files ../src/lsc.h
add_files ../src/top.h
add_files -tb ../tb/tb_lsc.cpp
open_solution "lsc"
source "./lsc_directives.tcl"
source "./script.tcl"
