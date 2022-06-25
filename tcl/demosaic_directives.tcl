set_directive_loop_merge "demosaic/outer_loop"
set_directive_loop_tripcount -max 8192 -avg 1920 "demosaic/outer_loop"
set_directive_pipeline "demosaic/inner_loop"
set_directive_loop_tripcount -avg 1080 "demosaic/inner_loop"
set_directive_unroll "demosaic/window_loop"
set_directive_unroll "demosaic/addon_loop"
set_directive_array_partition demosaic lineBuf
