#yanheng 20210221
open_project csc
set_top csc
add_files ../src/csc.cpp
add_files ../src/csc.h
add_files ../src/top.h
add_files -tb ../tb/tb_csc.cpp
open_solution "csc"
source "./csc_directives.tcl"
source "./script.tcl"
