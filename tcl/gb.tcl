open_project gb
set_top greenbalance2
add_files ../src/gb.cpp
add_files ../src/gb.h
add_files ../src/top.h
add_files -tb ../tb/tb_gb.cpp
open_solution "gb"
source "./gb_directives.tcl"
source "./script.tcl"
