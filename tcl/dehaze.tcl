open_project dehaze
set_top dehaze
add_files ../src/dehaze.cpp
add_files ../src/dehaze.h
add_files ../src/top.h
add_files -tb ../tb/tb_dehaze.cpp
open_solution "dehaze"
source "./dehaze_directives.tcl"
source "./script.tcl"
