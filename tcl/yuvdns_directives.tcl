set_directive_top -name yuv444dns "yuv444dns"
set_directive_array_partition -type complete -dim 0 yuv444dns yWindow
set_directive_array_partition -type complete -dim 0 yuv444dns uWindow
set_directive_array_partition -type complete -dim 0 yuv444dns vWindow
set_directive_array_partition -type block -dim 1 -factor 8 yuv444dns ylineBuf
set_directive_array_partition -type block -dim 1 -factor 8 yuv444dns ulineBuf
set_directive_array_partition -type block -dim 1 -factor 8 yuv444dns vlineBuf
set_directive_loop_tripcount -max 7680 -avg 1920 "yuv444dns/yuvdns_row"
set_directive_loop_merge "yuv444dns/yuvdns_row"
set_directive_pipeline "yuv444dns/yuvdns_col"
set_directive_loop_tripcount -max 4320 -avg 1080 "yuv444dns/yuvdns_col"
set_directive_unroll "yuv444dns/out_window_loop"
set_directive_unroll "yuv444dns/window_read"
set_directive_unroll "yuv444dns/lines_read"
set_directive_pipeline "yuv444dns/addon_loop_1"
set_directive_pipeline "yuv444dns/addon_loop_2"

set_directive_inline "yuvdns_weight2_clip"
set_directive_inline "yuvdns_abs"
set_directive_allocation -limit 3 -type function yuv444dns yuvdns_nlm
set_directive_loop_tripcount -max 7 -min 3 "yuvdns_nlm/nlm_row_loop"
set_directive_loop_tripcount -max 7 -min 3 "yuvdns_nlm/nlm_col_loop"
set_directive_pipeline "yuvdns_nlm/nlm_col_loop"

