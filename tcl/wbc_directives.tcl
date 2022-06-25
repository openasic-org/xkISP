set_directive_loop_merge "wbc/wbc_row"
set_directive_loop_tripcount -max 8192 -avg 1920 "wbc/wbc_row"
set_directive_pipeline "wbc/wbc_col"
set_directive_loop_tripcount -avg 1080 "wbc/wbc_col"
