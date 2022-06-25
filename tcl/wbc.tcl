#yanheng 20210308
open_project wbc
set_top wbc
add_files ../src/wbc.cpp
add_files ../src/wbc.h
add_files ../src/top.h
add_files -tb ../tb/tb_wbc.cpp
open_solution "wbc"
source "./wbc_directives.tcl"
source "./script.tcl"
