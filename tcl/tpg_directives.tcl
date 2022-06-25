set_directive_loop_merge "tpg/tpg_row"
set_directive_loop_tripcount -max 8192 -avg 1920 "tpg/tpg_row"
set_directive_pipeline "tpg/tpg_col"
set_directive_loop_tripcount -avg 1080 "tpg/tpg_col"
