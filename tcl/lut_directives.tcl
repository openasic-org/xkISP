set_directive_loop_merge "lut/lut_row"
set_directive_loop_tripcount -max 8192 -avg 1920 "lut/lut_row"
set_directive_pipeline "lut/lut_col"
set_directive_loop_tripcount -max 4032 -avg 1080 "lut/lut_col"
set_directive_inline "lut_max"
set_directive_inline "lut_max"
set_directive_inline "lut_clip"
set_directive_unroll "lut/P_loop"
set_directive_unroll "lut/index_loop"
set_directive_array_partition -type block -factor 1 -dim 1 lut lut_register.lut_000
set_directive_array_partition -type block -factor 1 -dim 1 lut lut_register.lut_001
set_directive_array_partition -type block -factor 1 -dim 1 lut lut_register.lut_010
set_directive_array_partition -type block -factor 1 -dim 1 lut lut_register.lut_011
set_directive_array_partition -type block -factor 1 -dim 1 lut lut_register.lut_100
set_directive_array_partition -type block -factor 1 -dim 1 lut lut_register.lut_101
set_directive_array_partition -type block -factor 1 -dim 1 lut lut_register.lut_110
set_directive_array_partition -type block -factor 1 -dim 1 lut lut_register.lut_111
set_directive_array_partition -type complete -dim 1 lut index_temp
set_directive_array_partition -type complete -dim 1 lut index_ram_temp
set_directive_array_partition -type complete -dim 1 lut P
set_directive_array_partition -type complete -dim 1 lut value
