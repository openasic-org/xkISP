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
#include "ltm.h"
#include "cac.h"
#include "csc.h"
#include "yfc.h"
#include "yuvdns.h"
#include "scaledown.h"
#include "crop.h"
void store_out(const crop_register crop_register, stream_u10 &dst_y,stream_u10 &dst_u,stream_u10 &dst_v, uint16* y_ptr,uint16* u_ptr,uint16* v_ptr){
	uint13 out_height=crop_register.lower_right_y-crop_register.upper_left_y;
	uint13 out_width =crop_register.lower_right_x-crop_register.upper_left_x;
	uint26 i;

    uint10 temp_y;
    uint10 temp_u;
    uint10 temp_v;
    for(i=0;i<out_height*out_width;i++){
#pragma HLS DEPENDENCE variable=v_ptr inter false
#pragma HLS DEPENDENCE variable=u_ptr inter false
#pragma HLS DEPENDENCE variable=y_ptr inter false
#pragma HLS PIPELINE
    	temp_y=dst_y.read();
    	temp_u=dst_u.read();
    	temp_v=dst_v.read();
    	y_ptr[i]=temp_y;
    	u_ptr[i]=temp_u;
    	v_ptr[i]=temp_v;
    }

};
void isp_top(stream_u12 &src,
	     uint16* y_ptr,
	     uint16* u_ptr,
             uint16* v_ptr,
             //stream_u10 &dst_y,
             //stream_u10 &dst_u,
             //stream_u10 &dst_v,
             top_register top_reg,
             tpg_register tpg_reg,
             dgain_register dgain_reg,
             lsc_register lsc_reg,
             dpc_register dpc_reg,
             rawdns_register rawdns_reg,
             awb_register awb_reg,
             wbc_register wbc_reg,
             gb_register gb_reg,
             demosaic_register demosaic_reg,
             ee_register ee_reg,
             cmc_register cmc_reg,
             gtm_register gtm_reg,
             ltm_register ltm_reg,
             cac_register cac_reg,
             csc_register csc_reg,
             yfc_register yfc_reg,
             yuvdns_register yuvdns_reg,
             scaledown_register scaledown_reg,
             crop_register crop_reg
) {
    #pragma HLS dataflow

#ifdef vivado
    //#pragma HLS STREAM variable=dst_y dim=1
    //#pragma HLS STREAM variable=dst_u dim=1
    //#pragma HLS STREAM variable=dst_v dim=1
    #pragma HLS INTERFACE m_axi depth=307200 port=v_ptr offset=direct bundle=gmem2
    #pragma HLS INTERFACE m_axi depth=307200 port=u_ptr offset=direct bundle=gmem1
    #pragma HLS INTERFACE m_axi depth=307200 port=y_ptr offset=direct bundle=gmem0
    #pragma HLS STREAM variable=src dim=1

    #pragma HLS array_partition variable=lsc_reg.rGain
    #pragma HLS array_partition variable=lsc_reg.GrGain
    #pragma HLS array_partition variable=lsc_reg.GbGain
    #pragma HLS array_partition variable=lsc_reg.bGain
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
    stream_u36 demosaic_ee_data;
    #pragma HLS STREAM variable=demosaic_ee_data depth=2 dim=1
    stream_u36 ee_cmc_data;
    #pragma HLS STREAM variable=ee_cmc_data depth=2 dim=1
    stream_u42 cmc_gtm_data;
    #pragma HLS STREAM variable=cmc_gtm_data depth=2 dim=1
    stream_u42 gtm_ltm_data;
    #pragma HLS STREAM variable=gtm_ltm_data depth=2 dim=1
    stream_u42 ltm_cac_data;
    #pragma HLS STREAM variable=ltm_cac_data depth=2 dim=1
    stream_u42 cac_csc_data;
    #pragma HLS STREAM variable=cac_csc_data depth=2 dim=1
    stream_u30 csc_yfc_data;
    #pragma HLS STREAM variable=csc_yfc_data depth=2 dim=1
    stream_u10 yfc_yuvdns_data_y;
    stream_u10 yfc_yuvdns_data_u;
    stream_u10 yfc_yuvdns_data_v;
    #pragma HLS STREAM variable=yfc_yuvdns_data_y depth=2 dim=1
    #pragma HLS STREAM variable=yfc_yuvdns_data_u depth=2 dim=1
    #pragma HLS STREAM variable=yfc_yuvdns_data_v depth=2 dim=1
    stream_u10 yuvdns_scale_data_y;
    stream_u10 yuvdns_scale_data_u;
    stream_u10 yuvdns_scale_data_v;
    #pragma HLS STREAM variable=yuvdns_scale_data_y depth=2 dim=1
    #pragma HLS STREAM variable=yuvdns_scale_data_u depth=2 dim=1
    #pragma HLS STREAM variable=yuvdns_scale_data_v depth=2 dim=1
    stream_u10 scale_crop_data_y;
    stream_u10 scale_crop_data_u;
    stream_u10 scale_crop_data_v;
    #pragma HLS STREAM variable=scale_crop_data_y depth=2 dim=1
    #pragma HLS STREAM variable=scale_crop_data_u depth=2 dim=1
    #pragma HLS STREAM variable=scale_crop_data_v depth=2 dim=1
    stream_u10 dst_y;
    stream_u10 dst_u;
    stream_u10 dst_v;
    #pragma HLS STREAM variable=dst_y depth=2 dim=1
    #pragma HLS STREAM variable=dst_u depth=2 dim=1
    #pragma HLS STREAM variable=dst_v depth=2 dim=1

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
    static stream_u42 gtm_ltm_data;
    static stream_u42 ltm_cac_data;
    static stream_u42 cac_csc_data;
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

    tpg(top_reg, tpg_reg, src, tpg_dgain_data);
    dgain(top_reg, dgain_reg, tpg_dgain_data, dgain_lsc_data);
    lsc(top_reg, lsc_reg, dgain_lsc_data, lsc_dpc_data);
    dpc(top_reg, dpc_reg, lsc_dpc_data, dpc_rawdns_data);
    isp_rawdns(top_reg, rawdns_reg, dpc_rawdns_data, rawdns_awb_data);
    awb(top_reg, awb_reg, rawdns_awb_data, awb_wbc_data);
    wbc(top_reg, wbc_reg, awb_wbc_data, wbc_gb_data);
    greenbalance2(top_reg, gb_reg, wbc_gb_data, gb_demosaic_data);
    demosaic(top_reg, demosaic_reg, gb_demosaic_data, demosaic_ee_data);
    edgeenhancement(top_reg, ee_reg, demosaic_ee_data, ee_cmc_data);
    cmc(top_reg, cmc_reg, ee_cmc_data, cmc_gtm_data);
    gtm(top_reg, gtm_reg, cmc_gtm_data, gtm_ltm_data);
    ltm(top_reg,ltm_reg,gtm_ltm_data,ltm_cac_data);
    cac(top_reg, cac_reg, ltm_cac_data, cac_csc_data);
    csc(top_reg, csc_reg, cac_csc_data, csc_yfc_data);
    yfc(top_reg, yfc_reg, csc_yfc_data, yfc_yuvdns_data_y, yfc_yuvdns_data_u, yfc_yuvdns_data_v);
    yuv444dns(top_reg, yuvdns_reg, yfc_yuvdns_data_y, yfc_yuvdns_data_u, yfc_yuvdns_data_v, yuvdns_scale_data_y, yuvdns_scale_data_u, yuvdns_scale_data_v);
    scaledown(top_reg, scaledown_reg, yuvdns_scale_data_y, yuvdns_scale_data_u, yuvdns_scale_data_v, scale_crop_data_y, scale_crop_data_u, scale_crop_data_v);
    crop(top_reg, crop_reg, scale_crop_data_y, scale_crop_data_u, scale_crop_data_v, dst_y, dst_u, dst_v);
    store_out(crop_reg,dst_y,dst_u,dst_v,y_ptr,u_ptr,v_ptr);
};
