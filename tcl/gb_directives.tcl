############################################################
## This file is generated automatically by Vivado HLS.
## Please DO NOT edit it.
## Copyright (C) 1986-2020 Xilinx, Inc. All Rights Reserved.
############################################################
set_directive_loop_tripcount -max 8192 -avg 1920 "greenbalance2/row_loop"
set_directive_pipeline "greenbalance2/col_loop"
set_directive_loop_tripcount -avg 1080 "greenbalance2/col_loop"
set_directive_unroll "greenbalance2/out_window_loop"
set_directive_unroll "greenbalance2/inner_loop"
set_directive_loop_tripcount -avg 5760 "greenbalance2/padding_loop"
set_directive_loop_tripcount -avg 1920 "greenbalance2/inter_loop"
set_directive_unroll -factor 20 "greenbalance2/padding_loop"
set_directive_unroll -factor 20 "greenbalance2/inter_loop"
set_directive_array_partition -type block -factor 7 -dim 1 "greenbalance2" temp_block
set_directive_array_partition -type block -factor 6 -dim 1 "greenbalance2" gb_lines
set_directive_latency -min 1 -max 3 "gb_process"
set_directive_dependence -variable Gfifo -type inter -dependent false "gb_process"
set_directive_dependence -variable countfifo -type inter -dependent false "gb_process"
set_directive_expression_balance "gb_process"
set_directive_array_partition -type complete -dim 1 "greenbalance2" countfifo
set_directive_array_partition -type complete -dim 1 "greenbalance2" Gfifo
set_directive_dependence -variable Gfifo -type inter -dependent false "ColumnStatistic"
set_directive_dependence -variable countfifo -type inter -dependent false "ColumnStatistic"
set_directive_unroll "greenbalance2/in_loop"
set_directive_pipeline "greenbalance2/padding_inter_loop"
set_directive_unroll "greenbalance2/greenbalance2_label0"
