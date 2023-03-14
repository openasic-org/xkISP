
open_project aec
set_top aec
add_files ../src/aec.cpp
add_files ../src/aec.h
add_files ../src/top.h
add_files -tb ../tb/tb_aec.cpp
open_solution "aec"
source "./aec_directives.tcl"
source "./script.tcl"
