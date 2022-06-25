set_directive_loop_merge "csc/csc_row"
set_directive_loop_tripcount -max 8192 -avg 1920 "csc/csc_row"
set_directive_pipeline "csc/csc_col"
set_directive_loop_tripcount -avg 1080 "csc/csc_col"
set_directive_unroll "csc/csc_cal1"
set_directive_unroll "csc/csc_cal2"
set_directive_array_partition csc seed
set_directive_array_partition csc csc_register.coeff
