set_directive_loop_merge "awb/awb_row"
set_directive_loop_tripcount -max 8192 -avg 1920 "awb/awb_row"
set_directive_pipeline "awb/awb_col"
set_directive_loop_tripcount -avg 1080 "awb/awb_col"
