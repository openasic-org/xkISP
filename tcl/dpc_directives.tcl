############################################################
## This file is generated automatically by Vivado HLS.
## Please DO NOT edit it.
## Copyright (C) 1986-2020 Xilinx, Inc. All Rights Reserved.
############################################################
set_directive_loop_merge "dpc/dpc_loop_out"
set_directive_loop_tripcount -max 8192 -avg 1088 "dpc/dpc_loop_out"
set_directive_pipeline "dpc/dpc_loop_in"
set_directive_loop_tripcount -avg 1928 "dpc/dpc_loop_in"
set_directive_unroll "dpc/rawWin_loop"
set_directive_unroll "dpc/addon_loop"
set_directive_array_partition -type complete -dim 1 "dpc" rawWindow
set_directive_array_partition -type complete -dim 1 "dpc" arr_ori
set_directive_array_partition -type complete -dim 1 "dpc" arr_sort
set_directive_array_partition -type block -factor 4 -dim 1 "dpc" lineBuffer
