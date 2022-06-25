open_project rawdns
set_top isp_rawdns
add_files ../src/rawdns.cpp
add_files ../src/rawdns.h
add_files ../src/top.h
add_files -tb ../tb/tb_rawdns.cpp
open_solution "rawdns"
source "./rawdns_directives.tcl"
source "./script.tcl"
