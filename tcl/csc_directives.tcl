set_directive_loop_tripcount -max 8192 -avg 1920 "csc/csc_row"
set_directive_pipeline "csc/csc_col"
set_directive_loop_tripcount -avg 1080 "csc/csc_col"
set_directive_unroll "csc/csc_cal1"
set_directive_unroll "csc/csc_cal2"
set_directive_top -name csc "csc"
set_directive_unroll "csc/csc_cal3"
set_directive_array_partition -type complete -dim 1 "csc" csc_reg.coeff
set_directive_array_partition -type complete -dim 1 "csc" seed
set_directive_array_partition -type complete -dim 1 "csc" src_w
set_directive_array_partition -type complete -dim 1 "csc" tmp_w
set_directive_array_partition -type complete -dim 1 "csc" res_w
set_directive_array_partition -type complete -dim 1 "csc" dst_w
set_directive_array_partition -dim 1 -type complete "csc" seed2
set_directive_array_partition -dim 1 -type complete "csc" res_w2
set_directive_array_partition -dim 1 -type complete "csc" tmp_w2
