set_directive_loop_merge "dgain/dgain_row"
set_directive_loop_tripcount -max 8192 -avg 1920 "dgain/dgain_row"
set_directive_pipeline "dgain/dgain_col"
set_directive_loop_tripcount -avg 1080 "dgain/dgain_col"
