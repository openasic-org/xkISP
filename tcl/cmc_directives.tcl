set_directive_loop_merge "cmc/cmc_row"
set_directive_loop_tripcount -max 8192 -avg 1920 "cmc/cmc_row"
set_directive_pipeline "cmc/cmc_col"
set_directive_loop_tripcount -avg 1080 "cmc/cmc_col"
set_directive_unroll "cmc/cmc_cal1"
set_directive_unroll "cmc/cmc_cal2"
set_directive_unroll "cmc/cmc_cal3"
set_directive_array_partition cmc gain
set_directive_array_partition cmc cmc_register.m_nGain
