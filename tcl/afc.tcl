open_project afc
set_top afc
add_files ../src/afc.cpp
add_files ../src/afc.h
add_files ../src/top.h
add_files -tb ../tb/tb_afc.cpp
open_solution "afc"
source "./afc_directives.tcl"
source "./script.tcl"
