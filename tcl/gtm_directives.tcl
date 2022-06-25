set_directive_loop_merge "gtm/gtm_row"
set_directive_loop_tripcount -max 8192 -avg 1920 "gtm/gtm_row"
set_directive_pipeline "gtm/gtm_col"
set_directive_loop_tripcount -avg 1080 "gtm/gtm_col"
set_directive_unroll "gtm/gtm_cal"
set_directive_array_partition gtm seed
set_directive_array_partition gtm gtm_register.gtmTab
