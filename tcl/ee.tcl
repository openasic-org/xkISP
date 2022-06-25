open_project ee
set_top edgeenhancement
add_files ../src/ee.cpp
add_files ../src/ee.h
add_files ../src/top.h
add_files -tb ../tb/tb_ee.cpp
open_solution "ee"
source "./ee_directives.tcl"
source "./script.tcl"
