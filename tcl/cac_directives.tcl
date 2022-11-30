set_directive_array_partition -type complete -dim 0 "cac" rgbWindow
set_directive_array_partition -type complete -dim 0 "cac" storeWindow_r
set_directive_array_partition -type complete -dim 0 "cac" storeWindow_b
set_directive_array_partition -type complete -dim 0 "cac" r_edge_h
set_directive_array_partition -type complete -dim 0 "cac" g_edge_h
set_directive_array_partition -type complete -dim 0 "cac" b_edge_h
set_directive_array_partition -type complete -dim 0 "cac" r_edge_v
set_directive_array_partition -type complete -dim 0 "cac" g_edge_v
set_directive_array_partition -type complete -dim 0 "cac" b_edge_v
set_directive_array_partition -type complete -dim 0 "cac" inPixel_int
set_directive_array_partition -type complete -dim 0 "cac" bg_diff_h
set_directive_array_partition -type complete -dim 0 "cac" rg_diff_h
set_directive_array_partition -type complete -dim 0 "cac" bg_diff_v
set_directive_array_partition -type complete -dim 0 "cac" rg_diff_v
set_directive_array_partition -type block -factor 6 -dim 1 "cac" lineBuffer
set_directive_array_partition -type block -factor 6 -dim 1 "cac" storeBuffer_r
set_directive_array_partition -type block -factor 6 -dim 1 "cac" storeBuffer_b
set_directive_loop_merge "cac/cac_row"
set_directive_loop_tripcount -max 8192 -avg 1920 "cac/cac_row"
set_directive_pipeline "cac/cac_col"
set_directive_loop_tripcount -max 4032 -avg 1080 "cac/cac_col"
set_directive_unroll "cac/storeWindow_in"
set_directive_unroll "cac/rgbWindow_loop"
set_directive_unroll "cac/rgbWindow_loop_j"
set_directive_unroll "cac/rgbWindow_read"
set_directive_unroll "cac/linebuffer_read"
set_directive_unroll "cac/pixel_temp_row"
set_directive_unroll "cac/pixel_temp_col"
set_directive_unroll "cac/edge_h_loop"
set_directive_unroll "cac/diff_loop"
set_directive_unroll "cac/l_r_loop"
set_directive_unroll "cac/u_d_loop"
set_directive_unroll "cac/storeWindow_loop"
set_directive_unroll "cac/storeBuffer_write"
set_directive_unroll "cac/storeWindow_shift_row"
set_directive_unroll "cac/storeWindow_shift_col"
set_directive_pipeline "cac/addon_loop_1"
set_directive_pipeline "cac/addon_loop_2"