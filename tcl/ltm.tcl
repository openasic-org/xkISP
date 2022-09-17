open_project ltm
set_top ltm
add_files ../src/ltm.cpp
add_files ../src/ltm.h
add_files ../src/top.h
add_files -tb ../tb/tb_ltm.cpp
open_solution "ltm"
source "./ltm_directives.tcl"
source "./script.tcl"