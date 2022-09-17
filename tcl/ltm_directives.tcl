set_directive_top -name ltm "ltm"
set_directive_array_partition -type complete -dim 0 ltm rWindow
set_directive_array_partition -type complete -dim 0 ltm gWindow
set_directive_array_partition -type complete -dim 0 ltm bWindow
set_directive_array_partition -type block -dim 1 -factor 8 ltm rlineBuf
set_directive_array_partition -type block -dim 1 -factor 8 ltm glineBuf
set_directive_array_partition -type block -dim 1 -factor 8 ltm blineBuf

set_directive_loop_tripcount -max 7680 -avg 1920 "ltm/ltm_row"
set_directive_pipeline "ltm/ltm_row"
set_directive_pipeline "ltm/ltm_col"
set_directive_loop_tripcount -max 4320 -avg 1080 "ltm/ltm_col"

set_directive_unroll "ltm/out_window_loop"
set_directive_unroll "ltm/ltm_window_read"
set_directive_unroll "ltm/ltm_lines_read"
set_directive_pipeline "ltm/addon_loop_1"
set_directive_pipeline "ltm/addon_loop_2"

set_directive_inline "ltm_abs"
set_directive_inline "ltm_clip"
set_directive_allocation -limit 3 -type function ltm bilaterS

set_directive_unroll "bilaterS/biS_loop1"
set_directive_unroll "bilaterS/biS_loop2"
set_directive_unroll "bilaterS/biS_loop3"
set_directive_unroll "bilaterS/biS_loop4"

