open_project lut
set_top lut
add_files ../src/lut.cpp
add_files ../src/lut.h
add_files ../src/top.h
add_files -tb ../tb/tb_lut.cpp
open_solution "lut"
source "./lut_directives.tcl"
source "./script.tcl"
