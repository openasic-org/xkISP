#yanheng 20210221
open_project gtm
set_top gtm
add_files ../src/gtm.cpp
add_files ../src/gtm.h
add_files ../src/top.h
add_files -tb ../tb/tb_gtm.cpp
open_solution "gtm"
source "./gtm_directives.tcl"
source "./script.tcl"
