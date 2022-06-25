set_directive_loop_merge "crop/crop_row"
set_directive_loop_tripcount -max 8192 -avg 1920 "crop/crop_row"
set_directive_pipeline "crop/crop_col"
set_directive_loop_tripcount -avg 1080 "crop/crop_col"
