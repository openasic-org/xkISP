set_directive_array_partition -type complete -dim 1 Cal_weight weight_1
set_directive_array_partition -type complete -dim 1 Cal_weight weight_2
set_directive_array_partition -type block -factor 10 -dim 1 isp_rawdns rawdns_lines
set_directive_array_partition -type complete -dim 0 isp_rawdns rawdns_block
set_directive_loop_tripcount -avg 2048 "isp_rawdns/pixel_loop"
set_directive_pipeline "isp_rawdns/pixel_loop"
set_directive_unroll "isp_rawdns/padding_loop1"
set_directive_unroll -factor 5 "isp_rawdns/padding_loop2"
set_directive_pipeline "isp_rawdns/loop2_inner_loop"
