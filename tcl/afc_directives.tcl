set_directive_loop_merge "afc/afc_row"
set_directive_loop_tripcount -max 8192 -avg 1920 "afc/afc_row"
set_directive_pipeline "afc/afc_col"
set_directive_loop_tripcount -avg 1080 "afc/afc_col"
set_directive_array_partition -type complete -dim 0 "afc" rawWindow
set_directive_array_partition -type complete -dim 0 "afc" raw_int
set_directive_array_partition -type complete -dim 0 "afc" afc_reg.ThrList
set_directive_array_partition -type block -factor 8 -dim 1 "cac" lineBuffer
set_directive_unroll "afc/rawWin_loop"
set_directive_unroll "afc/rawWindow_read"
set_directive_unroll "afc/line_write"
set_directive_unroll "afc/raw_int_read_row"
set_directive_unroll "afc/raw_int_read_col"
set_directive_unroll "afc/loop_sobel_1"
set_directive_unroll "afc/loop_sobel_2"
set_directive_unroll "afc/loop_laplace_1"
set_directive_unroll "afc/loop_laplace_2"
set_directive_unroll "afc/loop_H5_1"
set_directive_unroll "afc/loop_H5_2"
set_directive_unroll "afc/loop_IIRH1"
set_directive_unroll "afc/loop_IIRH2_1"
set_directive_unroll "afc/loop_IIRH2_2"
