open_project dpc
set_top dpc
add_files ../src/dpc.cpp
add_files ../src/dpc.h
add_files ../src/top.h
add_files -tb ../tb/tb_dpc.cpp
open_solution "dpc"
source "./dpc_directives.tcl"
source "./script.tcl"
