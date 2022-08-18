#include "top.h"
#include "tpg.h"
#include "dgain.h"
#include "lsc.h"
#include "dpc.h"
#include "rawdns.h"
#include "awb.h"
#include "wbc.h"
#include "gb.h"
#include "demosaic.h"
#include "ee.h"
#include "cmc.h"
#include "gtm.h"
#include "csc.h"
#include "yfc.h"
#include "yuvdns.h"
#include "scaledown.h"
#include "crop.h"

void isp_top(stream_u12 &src,
             stream_u10 &dst_y,
             stream_u10 &dst_u,
             stream_u10 &dst_v,
             top_register top_register,
             tpg_register tpg_register,
             dgain_register dgain_register,
             lsc_register lsc_register,
             dpc_register dpc_register,
             rawdns_register rawdns_register,
             awb_register awb_register,
             wbc_register wbc_register,
             gb_register gb_register,
             demosaic_register demosaic_register,
             ee_register ee_register,
             cmc_register cmc_register,
             gtm_register gtm_register,
             csc_register csc_register,
             yfc_register yfc_register,
             yuvdns_register yuvdns_register,
             scaledown_register scaledown_register,
             crop_register crop_register
) {
    #pragma HLS dataflow

#ifdef vivado
    #pragma HLS STREAM variable=dst dim=1
    #pragma HLS STREAM variable=src dim=1
    #pragma HLS INTERFACE s_axilite port=tpg_register bundle=tpg_regs
    #pragma HLS INTERFACE s_axilite port=dgain_register bundle=dgain_regs
    #pragma HLS INTERFACE s_axilite port=lsc_register bundle=lsc_regs
    #pragma HLS INTERFACE s_axilite port=wbc_register bundle=wbc_regs
    #pragma HLS INTERFACE s_axilite port=gb_register bundle=gb_regs
    #pragma HLS INTERFACE s_axilite port=demosaic_register bundle=demosaic_regs
    #pragma HLS INTERFACE s_axilite port=cmc_register bundle=cmc_regs
    #pragma HLS INTERFACE s_axilite port=gtm_register bundle=gtm_regs
    #pragma HLS INTERFACE s_axilite port=csc_register bundle=csc_regs
    #pragma HLS INTERFACE s_axilite port=yuv444to422_register bundle=yuv444to422_regs
    #pragma HLS INTERFACE s_axilite port=crop_register bundle=crop_regs
//    #pragma HLS INTERFACE s_axilite port=scaledown_register bundle=scaledown_regs
    #pragma HLS INTERFACE s_axilite port=top_register bundle=global_regs
    #pragma HLS array_partition variable=gtm_register.gtmTab
    #pragma HLS array_partition variable=lsc_register.rGain
    #pragma HLS array_partition variable=lsc_register.GrGain
    #pragma HLS array_partition variable=lsc_register.GbGain
    #pragma HLS array_partition variable=lsc_register.bGain
    stream_u12 tpg_dgain_data;
    #pragma HLS STREAM variable=tpg_dgain_data depth=2 dim=1
    stream_u12 dgain_lsc_data;
    #pragma HLS STREAM variable=dgain_lsc_data depth=2 dim=1
    stream_u12 lsc_dpc_data;
    #pragma HLS STREAM variable=lsc_dpc_data depth=2 dim=1
    stream_u12 dpc_rawdns_data;
    #pragma HLS STREAM variable=dpc_rawdns_data depth=2 dim=1
    stream_u12 rawdns_awb_data;
    #pragma HLS STREAM variable=rawdns_awb_data depth=2 dim=1
    stream_u12 awb_wbc_data;
    #pragma HLS STREAM variable=awb_wbc_data depth=2 dim=1
    stream_u12 wbc_gb_data;
    #pragma HLS STREAM variable=wbc_gb_data depth=2 dim=1
    stream_u12 gb_demosaic_data;
    #pragma HLS STREAM variable=gb_demosaic_data depth=2 dim=1
    stream_u36 demosaic_cmc_data;
    #pragma HLS STREAM variable=demosaic_cmc_data depth=2 dim=1
    stream_u42 cmc_gtm_data;
    #pragma HLS STREAM variable=cmc_gtm_data depth=2 dim=1
    stream_u42 gtm_csc_data;
    #pragma HLS STREAM variable=gtm_csc_data depth=2 dim=1
    stream_u30 csc_444to422_data;
    #pragma HLS STREAM variable=csc_444to422_data depth=2 dim=1
    stream_u30 yuv444to422_crop_data;
    #pragma HLS STREAM variable=yuv444to422_crop_data depth=2 dim=1
    stream_u30 crop_scaledown_data;
    #pragma HLS STREAM variable=crop_scaledown_data depth=2 dim=1
#endif

#ifdef catapult
    static stream_u12 tpg_dgain_data;
    static stream_u12 dgain_lsc_data;
    static stream_u12 lsc_dpc_data;
    static stream_u12 dpc_rawdns_data;
    static stream_u12 rawdns_awb_data;
    static stream_u12 awb_wbc_data;
    static stream_u12 wbc_gb_data;
    static stream_u12 gb_demosaic_data;
    static stream_u36 demosaic_ee_data;
    static stream_u36 ee_cmc_data;
    static stream_u42 cmc_gtm_data;
    static stream_u42 gtm_csc_data;
    static stream_u30 csc_yfc_data;
    static stream_u10 yfc_yuvdns_data_y;
    static stream_u10 yfc_yuvdns_data_u;
    static stream_u10 yfc_yuvdns_data_v;
    static stream_u10 yuvdns_scale_data_y;
    static stream_u10 yuvdns_scale_data_u;
    static stream_u10 yuvdns_scale_data_v;
    static stream_u10 scale_crop_data_y;
    static stream_u10 scale_crop_data_u;
    static stream_u10 scale_crop_data_v;
#endif

    tpg(top_register, tpg_register, src, tpg_dgain_data);
    dgain(top_register, dgain_register, tpg_dgain_data, dgain_lsc_data);
    lsc(top_register, lsc_register, dgain_lsc_data, lsc_dpc_data);
    dpc(top_register, dpc_register, lsc_dpc_data, dpc_rawdns_data);
    isp_rawdns(top_register, rawdns_register, dpc_rawdns_data, rawdns_awb_data);
    awb(top_register, awb_register, rawdns_awb_data, awb_wbc_data);
    wbc(top_register, wbc_register, awb_wbc_data, wbc_gb_data);
    greenbalance2(top_register, gb_register, wbc_gb_data, gb_demosaic_data);
    demosaic(top_register, demosaic_register, gb_demosaic_data, demosaic_ee_data);
    edgeenhancement(top_register, ee_register, demosaic_ee_data, ee_cmc_data);
    cmc(top_register, cmc_register, ee_cmc_data, cmc_gtm_data);
    gtm(top_register, gtm_register, cmc_gtm_data, gtm_csc_data);
    csc(top_register, csc_register, gtm_csc_data, csc_yfc_data);
    yfc(top_register, yfc_register, csc_yfc_data, yfc_yuvdns_data_y, yfc_yuvdns_data_u, yfc_yuvdns_data_v);
    yuv444dns(top_register, yuvdns_register, yfc_yuvdns_data_y, yfc_yuvdns_data_u, yfc_yuvdns_data_v, yuvdns_scale_data_y, yuvdns_scale_data_u, yuvdns_scale_data_v);
    scaledown(top_register, scaledown_register, yuvdns_scale_data_y, yuvdns_scale_data_u, yuvdns_scale_data_v, scale_crop_data_y, scale_crop_data_u, scale_crop_data_v);
    crop(top_register, crop_register, scale_crop_data_y, scale_crop_data_u, scale_crop_data_v, dst_y, dst_u, dst_v);
};
