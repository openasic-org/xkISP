############################################################
## This file is generated automatically by Vivado HLS.
## Please DO NOT edit it.
## Copyright (C) 1986-2020 Xilinx, Inc. All Rights Reserved.
############################################################
set_directive_pipeline "tpg/tpg_row"
set_directive_loop_tripcount -max 8192 -avg 1920 "tpg/tpg_row"
set_directive_pipeline "tpg/tpg_col"
set_directive_loop_tripcount -avg 1080 "tpg/tpg_col"
set_directive_pipeline "dgain/dgain_row"
set_directive_loop_tripcount -max 8192 -avg 1920 "dgain/dgain_row"
set_directive_pipeline "dgain/dgain_col"
set_directive_loop_tripcount -avg 1080 "dgain/dgain_col"
set_directive_pipeline "lsc/lsc_row"
set_directive_loop_tripcount -max 8192 -avg 1920 "lsc/lsc_row"
set_directive_pipeline "lsc/lsc_col"
set_directive_loop_tripcount -avg 1080 "lsc/lsc_col"
set_directive_pipeline "dpc/dpc_loop_out"
set_directive_loop_tripcount -max 8192 -avg 1920 "dpc/dpc_loop_out"
set_directive_pipeline "dpc/dpc_loop_in"
set_directive_loop_tripcount -avg 1080 "dpc/dpc_loop_in"
set_directive_unroll "dpc/rawWin_loop"
set_directive_unroll "dpc/addon_loop"
set_directive_array_partition -type complete -dim 1 "dpc" rawWindow
set_directive_array_partition -type complete -dim 1 "dpc" arr_ori
set_directive_array_partition -type complete -dim 1 "dpc" arr_sort
set_directive_array_partition -type block -factor 4 -dim 1 "dpc" lineBuffer
set_directive_array_partition -type complete -dim 1 "Cal_weight" weight_1
set_directive_array_partition -type complete -dim 1 "Cal_weight" weight_2
set_directive_array_partition -type block -factor 10 -dim 1 "isp_rawdns" rawdns_lines
set_directive_array_partition -type complete -dim 0 "isp_rawdns" rawdns_block
set_directive_loop_tripcount -avg 2048 "isp_rawdns/pixel_loop"
set_directive_pipeline "isp_rawdns/pixel_loop"
set_directive_unroll "isp_rawdns/padding_loop1"
set_directive_unroll -factor 5 "isp_rawdns/padding_loop2"
set_directive_pipeline "isp_rawdns/loop2_inner_loop"
set_directive_pipeline "awb/awb_row"
set_directive_loop_tripcount -max 8192 -avg 1920 "awb/awb_row"
set_directive_pipeline "awb/awb_col"
set_directive_loop_tripcount -avg 1080 "awb/awb_col"
set_directive_pipeline "wbc/wbc_row"
set_directive_loop_tripcount -max 8192 -avg 1920 "wbc/wbc_row"
set_directive_pipeline "wbc/wbc_col"
set_directive_loop_tripcount -avg 1080 "wbc/wbc_col"
set_directive_pipeline "greenbalance2/row_loop"
set_directive_pipeline "greenbalance2/col_loop"
set_directive_loop_tripcount -avg 1080 "greenbalance2/col_loop"
set_directive_unroll "greenbalance2/out_window_loop"
set_directive_unroll "greenbalance2/inner_loop"
set_directive_loop_tripcount -avg 5760 "greenbalance2/padding_loop"
set_directive_loop_tripcount -avg 1920 "greenbalance2/inter_loop"
set_directive_unroll -factor 20 "greenbalance2/padding_loop"
set_directive_unroll -factor 20 "greenbalance2/inter_loop"
set_directive_array_partition -type block -factor 7 -dim 1 "greenbalance2" temp_block
set_directive_array_partition -type block -factor 6 -dim 1 "greenbalance2" gb_lines
set_directive_latency -min 1 -max 3 "gb_process"
set_directive_dependence -variable Gfifo -type inter -dependent false "gb_process"
set_directive_dependence -variable countfifo -type inter -dependent false "gb_process"
set_directive_expression_balance "gb_process"
set_directive_array_partition -type complete -dim 1 "greenbalance2" countfifo
set_directive_array_partition -type complete -dim 1 "greenbalance2" Gfifo
set_directive_dependence -variable Gfifo -type inter -dependent false "ColumnStatistic"
set_directive_dependence -variable countfifo -type inter -dependent false "ColumnStatistic"
set_directive_unroll "greenbalance2/in_loop"
set_directive_pipeline "greenbalance2/padding_inter_loop"
set_directive_unroll "greenbalance2/greenbalance2_label0"
set_directive_pipeline "demosaic/outer_loop"
set_directive_loop_tripcount -max 8192 -avg 1920 "demosaic/outer_loop"
set_directive_pipeline "demosaic/inner_loop"
set_directive_loop_tripcount -avg 1080 "demosaic/inner_loop"
set_directive_unroll "demosaic/window_loop"
set_directive_unroll "demosaic/addon_loop"
set_directive_array_partition -type complete -dim 1 "demosaic" lineBuf
set_directive_array_partition -type complete -dim 0 "edgeenhancement" ee_block
set_directive_array_partition -type block -factor 4 -dim 1 "edgeenhancement" ee_lines
set_directive_unroll "edgeenhancement/padding_loop_1"
set_directive_unroll -factor 2 "edgeenhancement/padding_loop_2"
set_directive_pipeline "edgeenhancement/padding_loop_3"
set_directive_loop_tripcount -min 1080 -max 8192 -avg 4096 "edgeenhancement/row_loop"
set_directive_loop_tripcount -avg 1920 "edgeenhancement/col_loop"
set_directive_loop_flatten "edgeenhancement/block_refresh_loop_out"
set_directive_pipeline "edgeenhancement/col_loop"
set_directive_pipeline "edgeenhancement/single_loop"
set_directive_array_partition -type complete -dim 0 "eeprocess" gblock
set_directive_array_partition -type complete -dim 0 "eeprocess" guass_55
set_directive_array_partition -type complete -dim 0 "eeprocess" feq_h
set_directive_array_partition -type complete -dim 0 "eeprocess" result_v
set_directive_pipeline "cmc/cmc_row"
set_directive_loop_tripcount -max 8192 -avg 1920 "cmc/cmc_row"
set_directive_pipeline "cmc/cmc_col"
set_directive_loop_tripcount -avg 1080 "cmc/cmc_col"
set_directive_unroll "cmc/cmc_cal1"
set_directive_unroll "cmc/cmc_cal2"
set_directive_unroll "cmc/cmc_cal3"
set_directive_array_partition -type complete -dim 1 "cmc" gain
set_directive_array_partition -type complete -dim 1 "cmc" cmc_register.m_nGain
set_directive_pipeline "gtm/gtm_row"
set_directive_loop_tripcount -max 8192 -avg 1920 "gtm/gtm_row"
set_directive_pipeline "gtm/gtm_col"
set_directive_loop_tripcount -avg 1080 "gtm/gtm_col"
set_directive_unroll "gtm/gtm_cal"
set_directive_array_partition -type complete -dim 1 "gtm" seed
set_directive_array_partition -type complete -dim 1 "gtm" gtm_register.gtmTab
set_directive_array_partition -type complete -dim 1 "gtm" gtm_reg.gtmTab
set_directive_array_partition -type complete -dim 0 "ltm" rWindow
set_directive_array_partition -type complete -dim 0 "ltm" gWindow
set_directive_array_partition -type complete -dim 0 "ltm" bWindow
set_directive_array_partition -type block -factor 8 -dim 1 "ltm" rlineBuf
set_directive_array_partition -type block -factor 8 -dim 1 "ltm" glineBuf
set_directive_array_partition -type block -factor 8 -dim 1 "ltm" blineBuf
set_directive_loop_tripcount -max 8192 -avg 1920 "ltm/ltm_row"
set_directive_pipeline "ltm/ltm_row"
set_directive_pipeline "ltm/ltm_col"
set_directive_loop_tripcount -max 4320 -avg 1080 "ltm/ltm_col"
set_directive_unroll "ltm/out_window_loop"
set_directive_unroll "ltm/ltm_window_read"
set_directive_unroll "ltm/ltm_lines_read"
set_directive_pipeline "ltm/addon_loop_1"
set_directive_pipeline "ltm/addon_loop_2"
set_directive_inline "ltm_abs"
set_directive_inline "ltm_clip"
set_directive_allocation -type function -limit 3 "ltm" bilaterS
set_directive_unroll "bilaterS/biS_loop1"
set_directive_unroll "bilaterS/biS_loop2"
set_directive_unroll "bilaterS/biS_loop3"
set_directive_unroll "bilaterS/biS_loop4"
set_directive_array_partition -type block -factor 6 -dim 1 "cac" lineBuffer
set_directive_array_partition -type complete -dim 0 "cac" rgbWindow
set_directive_loop_tripcount -max 8192 -avg 1920 "cac/cac_row"
set_directive_pipeline "cac/cac_col"
set_directive_loop_tripcount -max 4032 -avg 1080 "cac/cac_col"
set_directive_unroll "cac/rgbWindow_loop_j"
set_directive_unroll "cac/rgbWindow_read"
set_directive_unroll "cac/pixel_temp_row"
set_directive_unroll "cac/pixel_temp_col"
set_directive_unroll "cac/edge_h_loop"
set_directive_unroll "cac/diff_loop"
set_directive_unroll "cac/window_return_row"
set_directive_pipeline "cac/addon_loop_1"
set_directive_pipeline "cac/addon_loop_2"
set_directive_pipeline "cac/cac_row"
set_directive_array_partition -type complete -dim 0 "cac" r_edge_h
set_directive_array_partition -type complete -dim 0 "cac" g_edge_h
set_directive_array_partition -type complete -dim 0 "cac" b_edge_h
set_directive_array_partition -type complete -dim 0 "cac" r_edge_v
set_directive_array_partition -type complete -dim 0 "cac" g_edge_v
set_directive_array_partition -type complete -dim 0 "cac" b_edge_v
set_directive_array_partition -type complete -dim 0 "cac" inPixel_int
set_directive_array_partition -type complete -dim 0 "cac" bg_diff_h
set_directive_array_partition -type complete -dim 0 "cac" rg_diff_h
set_directive_array_partition -type complete -dim 0 "cac" bg_diff_v
set_directive_array_partition -type complete -dim 0 "cac" rg_diff_v
set_directive_pipeline "csc/csc_row"
set_directive_loop_tripcount -max 8192 -avg 1920 "csc/csc_row"
set_directive_pipeline "csc/csc_col"
set_directive_loop_tripcount -avg 1080 "csc/csc_col"
set_directive_unroll "csc/csc_cal1"
set_directive_unroll "csc/csc_cal2"
set_directive_array_partition -type complete -dim 1 "csc" seed
set_directive_array_partition -type complete -dim 1 "csc" csc_register.coeff
set_directive_pipeline "yfc/yfc_row"
set_directive_loop_tripcount -max 8192 -avg 1920 "yfc/yfc_row"
set_directive_pipeline "yfc/yfc_col"
set_directive_loop_tripcount -avg 1080 "yfc/yfc_col"
set_directive_array_partition -type complete -dim 0 "yuv444dns" yWindow
set_directive_array_partition -type complete -dim 0 "yuv444dns" uWindow
set_directive_array_partition -type complete -dim 0 "yuv444dns" vWindow
set_directive_array_partition -type block -factor 8 -dim 1 "yuv444dns" ylineBuf
set_directive_array_partition -type block -factor 8 -dim 1 "yuv444dns" ulineBuf
set_directive_array_partition -type block -factor 8 -dim 1 "yuv444dns" vlineBuf
set_directive_loop_tripcount -max 8192 -avg 1920 "yuv444dns/yuvdns_row"
set_directive_pipeline "yuv444dns/yuvdns_row"
set_directive_pipeline "yuv444dns/yuvdns_col"
set_directive_loop_tripcount -max 4320 -avg 1080 "yuv444dns/yuvdns_col"
set_directive_unroll "yuv444dns/out_window_loop"
set_directive_unroll "yuv444dns/window_read"
set_directive_unroll "yuv444dns/lines_read"
set_directive_pipeline "yuv444dns/addon_loop_1"
set_directive_pipeline "yuv444dns/addon_loop_2"
set_directive_inline "yuvdns_weight2_clip"
set_directive_inline "yuvdns_abs"
set_directive_allocation -type function -limit 3 "yuv444dns" yuvdns_nlm
set_directive_loop_tripcount -min 3 -max 7 "yuvdns_nlm/nlm_row_loop"
set_directive_loop_tripcount -min 3 -max 7 "yuvdns_nlm/nlm_col_loop"
set_directive_pipeline "yuvdns_nlm/nlm_col_loop"
set_directive_pipeline "scaledown/scaledown_row"
set_directive_loop_tripcount -max 8192 -avg 1920 "scaledown/scaledown_row"
set_directive_pipeline "scaledown/scaledown_col"
set_directive_loop_tripcount -avg 1080 "scaledown/scaledown_col"
set_directive_array_partition -type complete -dim 1 "scaledown" y_linebuffer
set_directive_array_partition -type complete -dim 1 "scaledown" u_linebuffer
set_directive_array_partition -type complete -dim 1 "scaledown" v_linebuffer
set_directive_pipeline "crop/crop_row"
set_directive_loop_tripcount -max 8192 -avg 1920 "crop/crop_row"
set_directive_array_partition -type complete -dim 1 "isp_top" lsc_register.rGain
set_directive_array_partition -type complete -dim 1 "isp_top" lsc_register.GrGain
set_directive_array_partition -type complete -dim 1 "isp_top" lsc_register.GbGain
set_directive_array_partition -type complete -dim 1 "isp_top" lsc_register.bGain
set_directive_array_partition -type complete -dim 1 "isp_top" cmc_register.m_nGain
set_directive_array_partition -type complete -dim 1 "isp_top" cmc_register.m_pHueRange
set_directive_array_partition -type complete -dim 1 "isp_top" gtm_register.gtmTab
set_directive_array_partition -type complete -dim 1 "isp_top" csc_register.coeff
set_directive_pipeline "crop/crop_col"
set_directive_loop_tripcount -avg 1080 "crop/crop_col"
set_directive_loop_merge "yuvdns_nlm/nlm_row_loop"
set_directive_pipeline "isp_rawdns/rawdns_row"
set_directive_pipeline "isp_rawdns/rwadns_col"
set_directive_loop_tripcount -max 8192 -avg 1920 "edgeenhancement/ee_row"
set_directive_pipeline "edgeenhancement/ee_col"
set_directive_array_partition -type complete -dim 0 "eeprocess" rblock
set_directive_array_partition -type complete -dim 0 "eeprocess" bblock
set_directive_array_partition -type complete -dim 0 "eeprocess" feq_l
set_directive_unroll "eeprocess/eeprocess_label0"
set_directive_unroll "eeprocess/eeprocess_label1"
set_directive_unroll "eeprocess/eeprocess_label2"
set_directive_unroll "eeprocess/eeprocess_label3"
set_directive_unroll "eeprocess/eeprocess_label5"
set_directive_unroll "eeprocess/eeprocess_label4"
set_directive_array_partition -type complete -dim 0 "greenbalance2" gb_block
set_directive_array_partition -type complete -dim 0 "cac" storeWindow_r
set_directive_array_partition -type complete -dim 0 "cac" storeWindow_b
set_directive_array_partition -type block -factor 6 -dim 1 "cac" storeBuffer_r
set_directive_array_partition -type block -factor 6 -dim 1 "cac" storeBuffer_b
set_directive_unroll "cac/storeWindow_shift_row"
set_directive_unroll "cac/storeWindow_shift_col"
set_directive_unroll "cac/storeWindow_in"
set_directive_unroll "cac/rgbWindow_loop"
set_directive_unroll "cac/linebuffer_read"
set_directive_unroll "cac/l_r_loop"
set_directive_unroll "cac/u_d_loop"
set_directive_unroll "cac/storeWindow_loop"
set_directive_unroll "cac/storeBuffer_write"
set_directive_top -name isp_top "isp_top"
set_directive_array_partition -type complete -dim 1 "isp_top" cmc_reg.m_nGain
set_directive_array_partition -type complete -dim 1 "isp_top" cmc_reg.m_pHueRange
set_directive_array_partition -type complete -dim 1 "isp_top" gtm_reg.gtmTab
set_directive_array_partition -type complete -dim 1 "isp_top" csc_reg.coeff
set_directive_pipeline "edgeenhancement/ee_row"
set_directive_loop_tripcount -avg 1080 "edgeenhancement/ee_col"
set_directive_loop_tripcount -max 8192 -avg 1920 "greenbalance2/row_loop"
set_directive_loop_tripcount -max 8192 -avg 1920 "isp_rawdns/rawdns_row"
set_directive_loop_tripcount -avg 1080 "isp_rawdns/rwadns_col"
set_directive_array_partition -dim 1 -type complete "csc" seed2
set_directive_array_partition -dim 1 -type complete "csc" res_w2
set_directive_array_partition -dim 1 -type complete "csc" tmp_w2
set_directive_array_partition -dim 1 -type complete "csc" src_w
set_directive_array_partition -dim 1 -type complete "csc" dst_w
set_directive_unroll "csc/csc_cal3"
