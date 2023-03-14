//TPG
#define TPG_SRC1 "../../../../../tv/input.raw"
#define TPG_DST1 "../../../../../tv/tpg_hls.raw"
#define TPG_GOLDEN1 "../../../../../tv/tpg_out.raw"
//AFC
#define AFC_SRC1 "../../../../../tv/input.raw"
//Dgain
#define Dgain_SRC1 "../../../../../tv/input.raw"
#define Dgain_DST1 "../../../../../tv/dgain_hls.raw"
#define Dgain_GOLDEN1 "../../../../../tv/dgain_out.raw"
//LSC
#define LSC_SRC1 "../../../../../tv/dgain_out.raw"
#define LSC_DST1 "../../../../../tv/lsc_hls.raw"
#define LSC_GOLDEN1 "../../../../../tv/lsc_out.raw"
//DPC
#define DPC_SRC1 "../../../../../tv/lsc_out.raw"
#define DPC_DST1 "../../../../../tv/dpc_hls.raw"
#define DPC_GOLDEN1 "../../../../../tv/dpc_out.raw"
//RAWDNS
#define RAWDNS_SRC1 "../../../../../tv/dpc_out.raw"
#define RAWDNS_DST1 "../../../../../tv/rawdns_hls.raw"
#define RAWDNS_GOLDEN1 "../../../../../tv/rawdns_out.raw"
//AWB
#define AWB_SRC1 "../../../../../tv/rawdns_out.raw"
#define AWB_DST1 "../../../../../tv/rawdns_out.raw"
//WBC
#define WBC_SRC1 "../../../../../tv/rawdns_out.raw"
#define WBC_DST1 "../../../../../tv/wbc_hls.raw"
#define WBC_GOLDEN1 "../../../../../tv/wbc_out.raw"
//GB
#define GB_SRC1 "../../../../../tv/wbc_out.raw"
#define GB_DST1 "../../../../../tv/gb_hls.raw"
#define GB_GOLDEN1 "../../../../../tv/gb_out.raw"
//Demosaic
#define DEMOSAIC_SRC1 "../../../../../tv/gb_out.raw"
#define DEMOSAIC_DST1 "../../../../../tv/demosaic_hls.rgbh"
#define DEMOSAIC_GOLDEN1 "../../../../../tv/demosaic_out.rgbh"
//EE
#define EE_SRC "../../../../../tv/demosaic_out.rgbh"
#define EE_DST "../../../../../tv/ee_hls.rgbh"
#define EE_GOLDEN "../../../../../tv/ee_out.rgbh"
//Hist
//Histeq
//CMC
#define CMC_SRC1 "../../../../../tv/ee_out.rgbh"
#define CMC_DST1 "../../../../../tv/cmc_hls.rgb"
#define CMC_GOLDEN1 "../../../../../tv/cmc_out.rgb"
//AEC
#define AEC_SRC1 "../../../../../tv/cmc_out.rgb"
#define AEC_DST1 "../../../../../tv/aec_hls.rgb"
#define AEC_GOLDEN1 "../../../../../tv/aec_out.rgb"
//GTM
#define GTM_SRC1 "../../../../../tv/cmc_out.rgb"
#define GTM_DST1 "../../../../../tv/gtm_hls.rgb"
#define GTM_GOLDEN1 "../../../../../tv/gtm_out.rgb"
//LUT
#define LUT_SRC1 "../../../../../tv/gtm_out.rgb"
#define LUT_DST1 "../../../../../tv/lut_hls.rgb"
#define LUT_GOLDEN1 "../../../../../tv/lut_out.rgb"
#define LUT_CUBE "../../../../../tv/integer.cube"
#define LUT_CUBE_17 "../../../../../tv/integer_17.cube"
//LTM
#define LTM_SRC1    "../../../../../tv/gtm_out.rgb" //tmp
#define LTM_DST1    "../../../../../tv/ltm_hls.rgb"
#define LTM_GOLDEN1 "../../../../../tv/ltm_out.rgb"
//DEHAZE
#define DEHAZE_SRC1    "../../../../../tv/gtm_out.rgb"
#define DEHAZE_DST1    "../../../../../tv/dehaze_hls.rgb"
#define DEHAZE_GOLDEN1 "../../../../../tv/dehaze_out.rgb"
//CAC
#define CAC_SRC1 "../../../../../tv/ltm_out.rgb"
#define CAC_DST1 "../../../../../tv/cac_hls.rgb"
#define CAC_GOLDEN1 "../../../../../tv/cac_out.rgb"
//CSC
#define CSC_SRC1 "../../../../../tv/cac_out.rgb"
#define CSC_DST1 "../../../../../tv/csc_hls.rgb"
#define CSC_GOLDEN1 "../../../../../tv/csc_out.yuv"
//YFC
#define YFC_SRC "../../../../../tv/csc_out.yuv"
#define YFC_DST1 "../../../../../tv/yfc_hls_444.yuv"
#define YFC_GOLDEN1 "../../../../../tv/yfc_out.yuv"
#define YFC_DST2 "../../../../../tv/yfc_hls_422.yuv"
#define YFC_GOLDEN2 "../../../../../tv/yfc_out_422.yuv"
#define YFC_DST3 "../../../../../tv/yfc_hls_420.yuv"
#define YFC_GOLDEN3 "../../../../../tv/yfc_out_420.yuv"
//YUVDNS
#define YUVDNS_SRC1 "../../../../../tv/yfc_out.yuv"
#define YUVDNS_DST1 "../../../../../tv/yuvdns_hls_60_80.yuv"
#define YUVDNS_GOLDEN1 "../../../../../tv/yuvdns_out.yuv"
//Scale down
#define scaledown_SRC1 "../../../../../tv/yuvdns_out.yuv"
#define scaledown_DST1 "../../../../../tv/scaledown_hls.yuv"
#define scaledown_GOLDEN1 "../../../../../tv/scaledown_out.yuv"
//Crop
#define CROP_SRC1 "../../../../../tv/scaledown_out.yuv"
#define CROP_DST1 "../../../../../tv/crop_hls.yuv"
#define CROP_GOLDEN1 "../../../../../tv/crop_out.yuv"

