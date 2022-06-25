set_directive_loop_merge "scaledown/scaledown_row"
set_directive_loop_tripcount -max 8192 -avg 1920 "scaledown/scaledown_row"
set_directive_pipeline "scaledown/scaledown_col"
set_directive_loop_tripcount -avg 1080 "scaledown/scaledown_col"
set_directive_array_partition -type complete -dim 1 "scaledown" y_linebuffer
set_directive_array_partition -type complete -dim 1 "scaledown" u_linebuffer
set_directive_array_partition -type complete -dim 1 "scaledown" v_linebuffer
