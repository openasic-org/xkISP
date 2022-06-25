#yanheng 20210221
open_project demosaic
set_top demosaic
add_files ../src/demosaic.cpp
add_files ../src/demosaic.h
add_files ../src/top.h
add_files -tb ../tb/tb_demosaic.cpp
open_solution "demosaic"
source "./demosaic_directives.tcl"
source "./script.tcl"
