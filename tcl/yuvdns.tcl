open_project yuvdns
set_top yuv444dns
add_files ../src/yuvdns.cpp
add_files ../src/yuvdns.h
add_files ../src/top.h
add_files -tb ../tb/tb_yuvdns.cpp
open_solution "yuvdns"
source "./yuvdns_directives.tcl"
source "./script.tcl"
