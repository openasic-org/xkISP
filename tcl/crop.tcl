#yuxin 20210811
open_project crop
set_top crop
add_files ../src/crop.cpp
add_files ../src/crop.h
add_files ../src/top.h
add_files -tb ../tb/tb_crop.cpp
open_solution "crop"
source "./crop_directives.tcl"
source "./script.tcl"
