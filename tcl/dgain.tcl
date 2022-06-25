#yanheng 20210221
open_project dgain
set_top dgain
add_files ../src/dgain.cpp
add_files ../src/dgain.h
add_files ../src/top.h
add_files -tb ../tb/tb_dgain.cpp
open_solution "dgain"
source "./dgain_directives.tcl"
source "./script.tcl"
