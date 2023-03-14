############################################################
## This file is generated automatically by Vitis HLS.
## Please DO NOT edit it.
## Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
############################################################
set_directive_top -name dehaze "dehaze"
set_directive_pipeline -II 1 "minfilter/min_r"
set_directive_pipeline -II 1 "minfilter/min_c"
set_directive_array_partition -type block -factor 3 -dim 1 "minfilter" rlineBuf
set_directive_array_partition -type block -factor 3 -dim 1 "minfilter" glineBuf
set_directive_array_partition -type block -factor 3 -dim 1 "minfilter" blineBuf
set_directive_array_partition -type complete -dim 0 "minfilter" bWindow
set_directive_array_partition -type complete -dim 0 "minfilter" gWindow
set_directive_array_partition -type complete -dim 0 "minfilter" rWindow
set_directive_array_partition -type block -factor 10 -dim 1 "tRefine_rgbRec" rlineBuf
set_directive_array_partition -type block -factor 10 -dim 1 "tRefine_rgbRec" glineBuf
set_directive_array_partition -type block -factor 10 -dim 1 "tRefine_rgbRec" blineBuf
set_directive_array_partition -type block -factor 10 -dim 1 "tRefine_rgbRec" dclineBuf
set_directive_array_partition -type complete -dim 0 "tRefine_rgbRec" rWindow
set_directive_array_partition -type complete -dim 0 "tRefine_rgbRec" gWindow
set_directive_array_partition -type complete -dim 0 "tRefine_rgbRec" bWindow
set_directive_array_partition -type complete -dim 0 "tRefine_rgbRec" dcWindow
set_directive_array_partition -type complete -dim 0 "gf_rec_core" iWindow
set_directive_array_partition -type complete -dim 0 "gf_rec_core" tWindow
set_directive_pipeline -II 1 "tRefine_rgbRec/gf_row"
set_directive_pipeline -II 1 "tRefine_rgbRec/gf_col"
set_directive_dataflow "dehaze"
set_directive_array_partition -type complete -dim 0 "dehaze" atm
set_directive_loop_tripcount -min 1080 -max 2160 -avg 1080 "minfilter/min_r"
set_directive_loop_tripcount -min 1920 -max 3840 -avg 1920 "minfilter/min_c"
set_directive_loop_tripcount -min 1920 -max 3840 -avg 1920 "tRefine_rgbRec/gf_col"
set_directive_loop_tripcount -min 1080 -max 2160 -avg 1080 "tRefine_rgbRec/gf_row"
set_directive_unroll "gf_rec_core/gf_rec_core_label1"
set_directive_unroll "gf_rec_core/gf_rec_core_label2"
set_directive_unroll "gf_rec_core/gf_rec_core_label3"
set_directive_unroll "gf_rec_core/gf_rec_core_label4"
