#include "../src/dgain.h"
#include "../src/top.h"
#include "../src/tpg.h"
#include "../src/dgain.h"
#include "../src/lsc.h"
#include "../src/dpc.h"
#include "../src/awb.h"
#include "../src/wbc.h"
#include "../src/rawdns.h"
#include "../src/gb.h"
#include "../src/demosaic.h"
#include "../src/ee.h"
#include "../src/cmc.h"
#include "../src/gtm.h"
#include "../src/lut.h"
#include "../src/ltm.h"
#include "../src/cac.h"
#include "../src/csc.h"
#include "../src/yfc.h"
#include "../src/yuvdns.h"
#include "../src/crop.h"
#include "../src/scaledown.h"

#include <stdio.h>
#include <dirent.h>
#include <cstring>
#include <string>
#include <sstream>
#include <unistd.h>
#include <stdlib.h>

#include <ac_int.h>
#include <mc_scverify.h>

//Top
#define LUT_CUBE "../../tv/integer.cube"
#define LUT_CUBE_17 "../../tv/integer_17.cube"

CCS_MAIN(int argc, char** argv)
{
    top_register topParam;
    afc_register afc_param;
    tpg_register tpg_param;
    dgain_register dgain_param;
    lsc_register lsc_param;
    dpc_register dpc_param;
    rawdns_register rawdns_param;
    awb_register awb_param;
    wbc_register wbc_param;
    gb_register  gb_param;
    demosaic_register demosaic_param;
    ee_register ee_param;
    cmc_register cmc_param;
    gtm_register gtm_param;
    lut_register lut_param;
    ltm_register ltm_param;
    cac_register cac_param;
    csc_register csc_param;
    yfc_register yfc_param;
    yuvdns_register yuvdns_param;
    scaledown_register scaledown_param;
    crop_register crop_param;

    ac_channel<uint12> src;
    ac_channel<uint10> y_dst;
    ac_channel<uint10> u_dst;
    ac_channel<uint10> v_dst;

    int x;
    uint10 y_out_data;
    uint10 u_out_data;
    uint10 v_out_data;

    printf("\tTest for ISP TOP module!\n");

// path
    const char* config_file = "../config/xkISP.cfg";

    struct dirent *ptr_src;
    DIR *dir_raw;
    dir_raw=opendir("../RAW");
    char* src_name;
    const char* top_src;
    std::string path_src;
    path_src = "../RAW/";

    struct dirent *ptr_golden;
    DIR *dir_yuv;
    dir_yuv=opendir("../YUV");
    char* golden_name;
    const char* top_golden;
    std::string path_golden;
    path_golden = "../YUV/";

    struct dirent *ptr_wb;
    DIR *dir_wb;
    dir_wb=opendir("../WB");
    char* wb_name;
    const char* top_wb;
    std::string path_wb;
    path_wb = "../WB/";

    std::string path_dst = "../DST/";
    const char* top_dst;

    char buf[100] = "";
    FILE* fp_config = fopen((const char*)config_file, "r");
    char *p, *q;
    char key[100], value[100];
    int output_yuvpattern = 0; //0:444 1:422 2:420
    int Noise_Mode;
    int Img_Format;
    float rawdns_sigma;
    int noise_es_enable;
    int lsc_config = 0;
    float gtm_gamma = 0.0;

    if(fp_config == NULL)
    {
        printf("\t Warning: no configuration file!\n");
        printf("\t Will use default initial values!\n");
    }
    else
    {
        while (fgets(buf, 100, fp_config))
        {
            p = strchr(buf, '=');
            q = strchr(buf, '\n');
            if (p != NULL && q != NULL)
            {
                *q = '\0';
                strncpy(key, buf, p - buf);
                strcpy(value, p + 1);

                // top
                if(strstr(key, "frame_width"))
                {
                    topParam.frameWidth = atoi(value);
                    printf("frame_width = %d\n", topParam.frameWidth);
                    continue;
                }

                if(strstr(key, "frame_height"))
                {
                    topParam.frameHeight = atoi(value);
                    printf("frame_height = %d\n", topParam.frameHeight);
                    continue;
                }

                if(strstr(key, "image_pattern"))
                {
                    topParam.imgPattern = atoi(value);
                    printf("image_pattern = %d\n", topParam.imgPattern);
                    continue;
                }

                if(strstr(key, "blc"))
                {
                    topParam.blc = atoi(value);
                    printf("blc = %d\n", topParam.blc);
                    continue;
                }

                #ifdef DEBUG
                if(strstr(key, "ROW_TEST"))
                {
                    topParam.ROW_TEST = atoi(value);
                    printf("ROW_TEST = %d\n", topParam.ROW_TEST);
                    continue;
                }

                if(strstr(key, "COL_TEST"))
                {
                    topParam.COL_TEST = atoi(value);
                    printf("COL_TEST = %d\n", topParam.COL_TEST);
                    continue;
                }
                #endif
                //afc
                if(strstr(key, "afc_enable"))
                {
                    afc_param.eb = atoi(value);
                    printf("afc_enable = %d\n", afc_param.eb);
                    continue;
                }

                if(strstr(key, "afc_location_row"))
                {
                    afc_param.location_row = atoi(value);
                    printf("afc_location_row = %d\n", afc_param.location_row);
                    continue;
                }

                if(strstr(key, "afc_location_col"))
                {
                    afc_param.location_col = atoi(value);
                    printf("afc_location_col = %d\n", afc_param.location_col);
                    continue;
                }

                if(strstr(key, "afc_m_bIfHardThreshold"))
                {
                    afc_param.m_bIfHardThreshold = atoi(value);
                    printf("afc_m_bIfHardThreshold = %d\n", afc_param.m_bIfHardThreshold);
                    continue;
                }

                if(strstr(key, "afc_T_value"))
                {
                    afc_param.T = atoi(value);
                    printf("afc_T = %d\n", afc_param.T);
                    continue;
                }

                if(strstr(key, "afc_ThrList_0"))
                {
                    afc_param.ThrList[0] = atoi(value);
                    printf("afc_ThrList[0] = %d\n", afc_param.ThrList[0]);
                    continue;
                }

                if(strstr(key, "afc_ThrList_1"))
                {
                    afc_param.ThrList[1] = atoi(value);
                    printf("afc_ThrList[1] = %d\n", afc_param.ThrList[1]);
                    continue;
                }

                if(strstr(key, "afc_ThrList_2"))
                {
                    afc_param.ThrList[2] = atoi(value);
                    printf("afc_ThrList[2] = %d\n", afc_param.ThrList[2]);
                    continue;
                }

                if(strstr(key, "afc_ThrList_3"))
                {
                    afc_param.ThrList[3] = atoi(value);
                    printf("afc_ThrList[3] = %d\n", afc_param.ThrList[3]);
                    continue;
                }

                if(strstr(key, "afc_ThrList_4"))
                {
                    afc_param.ThrList[4] = atoi(value);
                    printf("afc_ThrList[4] = %d\n", afc_param.ThrList[4]);
                    continue;
                }

                if(strstr(key, "afc_ThrList_5"))
                {
                    afc_param.ThrList[5] = atoi(value);
                    printf("afc_ThrList[5] = %d\n", afc_param.ThrList[5]);
                    continue;
                }

                if(strstr(key, "afc_ThrList_6"))
                {
                    afc_param.ThrList[6] = atoi(value);
                    printf("afc_ThrList[6] = %d\n", afc_param.ThrList[6]);
                    continue;
                }

                if(strstr(key, "afc_ThrList_7"))
                {
                    afc_param.ThrList[7] = atoi(value);
                    printf("afc_ThrList[7] = %d\n", afc_param.ThrList[7]);
                    continue;
                }
                // dgain
                if(strstr(key, "dgain_enable"))
                {
                    dgain_param.m_nEb = atoi(value);
                    printf("dgain_enable = %d\n", dgain_param.m_nEb);
                    continue;
                }

                if(strstr(key, "dgain_rgain"))
                {
                    dgain_param.m_nR = atoi(value);
                    printf("dgain_rgain = %d\n", dgain_param.m_nR);
                    continue;
                }

                if(strstr(key, "dgain_grgain"))
                {
                    dgain_param.m_nGr = atoi(value);
                    printf("dgain_grgain = %d\n", dgain_param.m_nGr);
                    continue;
                }

                if(strstr(key, "dgain_gbgain"))
                {
                    dgain_param.m_nGb = atoi(value);
                    printf("dgain_gbgain = %d\n", dgain_param.m_nGb);
                    continue;
                }

                if(strstr(key, "dgain_bgain"))
                {
                    dgain_param.m_nB = atoi(value);
                    printf("dgain_dgain = %d\n", dgain_param.m_nB);
                    continue;
                }

                // lsc
                if(strstr(key, "lsc_enable"))
                {
                    lsc_param.eb = atoi(value);
                    printf("lsc_enable = %d\n", lsc_param.eb);
                    lsc_param.blockHeight = (topParam.frameHeight - 1) / 12 + 1;
                    lsc_param.blockWidth =  (topParam.frameWidth - 1)  / 16 + 1;
                    lsc_param.blockHeight_1 = 32768 / lsc_param.blockHeight;
                    lsc_param.blockWidth_1  = 524288 / lsc_param.blockWidth;
                    printf("lsc_param.blockHeight = %d\n", lsc_param.blockHeight);
                    printf("lsc_param.blockWidth  = %d\n", lsc_param.blockWidth );
                    printf("lsc_param.blockHeight_1 = %d\n", lsc_param.blockHeight_1);
                    printf("lsc_param.blockWidth_1  = %d\n", lsc_param.blockWidth_1 );

                    continue;
                }

                if(strstr(key, "lsc_config"))
                {
                    lsc_config = atoi(value);
                    printf("lsc_config = %d\n", lsc_config);
                    continue;
                }

                // dpc
                if(strstr(key, "dpc_enable"))
                {
                   dpc_param.eb = atoi(value);
                    printf("dpc_enable = %d\n",dpc_param.eb);
                    continue;
                }

                if(strstr(key, "dpc_threshold_w"))
                {
                   dpc_param.th_w = atoi(value);
                    printf("dpc_threshod_w = %d\n",dpc_param.th_w);
                    continue;
                }

                if(strstr(key, "dpc_threshold_b"))
                {
                   dpc_param.th_b = atoi(value);
                    printf("dpc_threshod_b = %d\n",dpc_param.th_b);
                    continue;
                }

                // rawdns
                if(strstr(key, "rawdns_enable"))
                {
                    rawdns_param.eb = atoi(value);
                    printf("rawdns_enable = %d\n", rawdns_param.eb);
                    continue;
                }

                if(strstr(key, "rawdns_sigma"))
                {
                    rawdns_param.sigma = atoi(value);
                    printf("rawdns_sigma = %d\n", rawdns_param.sigma);
                    continue;
                }

                if(strstr(key, "rawdns_filter"))
                {
                    rawdns_param.Filterpara = atoi(value);
                    printf("rawdns_filter = %d\n", rawdns_param.Filterpara);
                    continue;
                }

                if(strstr(key, "rawdns_bitwidth"))
                {
                    uint5 bitwidth = atoi(value);
                    printf("rawdns_bitwidth = %d\n", bitwidth);
                    rawdns_param.invksigma2 = 4096 * 256 / (rawdns_param.Filterpara * rawdns_param.sigma) * (65536 >> ((bitwidth - 8) * 2) ) / (rawdns_param.Filterpara * rawdns_param.sigma);
                    printf("rawdns_param.invksigma2 = %d\n", rawdns_param.invksigma2);
                    continue;
                }

                // awb
                if(strstr(key, "awb_enable"))
                {
                    awb_param.m_nEb = atoi(value);
                    printf("awb_param.m_nEb = %d\n", awb_param.m_nEb);
                    continue;
                }

                if(strstr(key, "awb_coeff"))
                {
                    awb_param.coeff = atoi(value);
                    printf("awb_param.coeff = %d\n", awb_param.coeff);
                    continue;
                }
                if(strstr(key, "wbc_enable"))
                {
                    wbc_param.m_nEb = atoi(value);
                    printf("wbc_enable = %d\n", wbc_param.m_nEb);
                    continue;
                }

                // wbc
                if(strstr(key, "wbc_rgain"))
                {
                    wbc_param.m_nR = atoi(value);
                    printf("wbc_rgain = %d\n", wbc_param.m_nR);
                    continue;
                }

                if(strstr(key, "wbc_ggain"))
                {
                    wbc_param.m_nGr = atoi(value);
                    wbc_param.m_nGb = atoi(value);
                    printf("wbc_ggain = %d\n", wbc_param.m_nGr);
                    continue;
                }

                if(strstr(key, "wbc_bgain"))
                {
                    wbc_param.m_nB = atoi(value);
                    printf("wbc_bgain = %d\n", wbc_param.m_nB);
                    continue;
                }

                // gb
                if(strstr(key, "gb_enable"))
                {
                    gb_param.eb = atoi(value);
                    printf("gb_enable = %d\n", gb_param.eb);
                    continue;
                }

                if(strstr(key, "win_size"))
                {
                    gb_param.win_size = atoi(value);
                    printf("gb_win_size = %d\n", gb_param.win_size);
                    continue;
                }

                if(strstr(key, "Lbound"))
                {
                    gb_param.Lbound = atoi(value);
                    printf("gb_Lbound = %d\n", gb_param.Lbound);
                    continue;
                }

                if(strstr(key, "Hbound"))
                {
                    gb_param.Hbound = atoi(value);
                    printf("gb_Hbound = %d\n", gb_param.Hbound);
                    continue;
                }

                if(strstr(key, "threhold"))
                {
                    gb_param.threhold = atoi(value);
                    printf("gb_threhold = %d\n", gb_param.threhold);
                    continue;
                }

                // ee
                if(strstr(key, "ee_enable"))
                {
                    ee_param.eb = atoi(value);
                    printf("ee_enable = %d\n", ee_param.eb);
                    continue;
                }

                if(strstr(key, "ee_coeff"))
                {
                    ee_param.coeff = atoi(value);
                    printf("ee_coeff = %d\n", ee_param.coeff);
                    continue;
                }

                // cmc
                if(strstr(key, "cmc_enable"))
                {
                    cmc_param.m_nEb = atoi(value);
                    printf("cmc_enable = %d\n", cmc_param.m_nEb);
                    continue;
                }

                // gtm
                if(strstr(key, "gtm_enable"))
                {
                    gtm_param.eb = atoi(value);
                    printf("gtm_enable = %d\n", gtm_param.eb);
                    continue;
                }

                if(strstr(key, "gtm_m_bDitheringEnable"))
                {
                    gtm_param.m_bDitheringEnable = atoi(value);
                    printf("gtm_m_bDitheringEnable = %d\n", gtm_param.m_bDitheringEnable);
                    continue;
                }

                if(strstr(key, "gtm_gamma"))
                {
                    gtm_gamma = atof(value);
                    printf("gtm_gamma = %f\n", gtm_gamma);
                    continue;
                }

                // lut
                if(strstr(key, "lut_enable"))
                {
                    lut_param.eb = atoi(value);
                    printf("lut_enable = %d\n", lut_param.eb);
                    continue;
                }

                if(strstr(key, "lut_size"))
                {
                    lut_param.size = atoi(value);
                    printf("lut_size = %d\n", lut_param.size);
                    lut_param.lines = lut_param.size * lut_param.size * lut_param.size;
                    printf("lut_lines = %d\n", lut_param.lines);
                    continue;
                }

                // ltm
                if(strstr(key,"ltm_enable"))
                {
                    ltm_param.m_nEb=atoi(value);
                    printf("ltm_enable = %d\n",ltm_param.m_nEb);
                }
                if(strstr(key,"ltm_contrast"))
                {
                    ltm_param.contrast=atoi(value);
                    printf("ltm_contrast = %d\n",ltm_param.contrast);
                }
                if(strstr(key,"ltm_ratio"))
                {
                    ltm_param.ratio=atoi(value);
                    printf("ltm_ratio = %d\n",ltm_param.ratio);
                }

                // cac
                if(strstr(key, "cac_enable"))
                {
                    cac_param.eb = atoi(value);
                    printf("cac_enable = %d\n", cac_param.eb);
                    continue;
                }

                if(strstr(key, "cac_t_transient"))
                {
                    cac_param.t_transient = atoi(value);
                    printf("cac_t_transient = %d\n", cac_param.t_transient);
                    continue;
                }

                if(strstr(key, "cac_t_edge"))
                {
                    cac_param.t_edge = atoi(value);
                    printf("cac_t_edge = %d\n", cac_param.t_edge);
                    continue;
                }

                // yfc
                if(strstr(key, "yfc_enable"))
                {
                    yfc_param.m_nEb = atoi(value);
                    printf("yfc_enalbe = %d\n", yfc_param.m_nEb);
                    continue;
                }

                // yuvdns
                if(strstr(key, "yuvdns_enable"))
                {
                    yuvdns_param.eb = atoi(value);
                    printf("yuvdns_enable = %d\n", yuvdns_param.eb);
                    continue;
                }

                if(strstr(key, "yuvdns_ysigma"))
                {
                    int ysigma = atoi(value);
                    //yuvdns_param.ysigma = ysigma;
                    yuvdns_param.ysigma2 = ysigma * ysigma;
                    yuvdns_param.yinvsigma2 = 128 * 128 / yuvdns_param.ysigma2;
                    printf("yuv_ysigma = %d\n", ysigma);
                    printf("yuv_invysigma2 = %d\n", yuvdns_param.yinvsigma2);
                    continue;
                }

                if(strstr(key, "yuvdns_uvsigma"))
                {
                    int uvsigma = atoi(value);
                    //yuvdns_param.uvsigma = uvsigma;
                    yuvdns_param.uvsigma2 = uvsigma * uvsigma;
                    yuvdns_param.uvinvsigma2 = 128 * 128 / yuvdns_param.uvsigma2;
                    printf("yuv_uvsigma = %d\n", uvsigma);
                    printf("yuv_invuvsigma2 = %d\n", yuvdns_param.uvinvsigma2);
                    continue;
                }

                yuvdns_param.yfilt = 0x6;// 0.4 << 6
                yuvdns_param.uvfilt = 0x6;// 0.4 << 6
                yuvdns_param.yinvfilt = 0x5; // (1 / yfilt) << 1
                yuvdns_param.uvinvfilt = 0x5; // (1 / uvfilt) << 1
                yuvdns_param.yH2 = (yuvdns_param.yfilt * yuvdns_param.yfilt * yuvdns_param.ysigma2 + 255) >> 8;
                yuvdns_param.yinvH2 = (yuvdns_param.yinvfilt * yuvdns_param.yinvfilt * yuvdns_param.yinvsigma2 + 3) >> 2;
                yuvdns_param.uvH2 = (yuvdns_param.uvfilt * yuvdns_param.uvfilt * yuvdns_param.uvsigma2 + 255) >> 8;
                yuvdns_param.uvinvH2 = (yuvdns_param.uvinvfilt * yuvdns_param.uvinvfilt * yuvdns_param.uvinvsigma2 + 3) >> 2;

                // scaledown
                if(strstr(key, "scaledown_enable"))
                {
                    scaledown_param.m_nEb = atoi(value);
                    printf("scaledown_enable = %d\n", scaledown_param.m_nEb);
                    continue;
                }

                if(strstr(key, "output_times"))
                {
                    scaledown_param.times = atoi(value);
                    //crop_param.times = scaledown_param.times;
                    printf("output_times = %d\n", scaledown_param.times);
                    continue;
                }

                // crop
                if(strstr(key, "crop_enable"))
                {
                    crop_param.m_nEb = atoi(value);
                    printf("crop_enable = %d\n", crop_param.m_nEb);
                    continue;
                }

                if(strstr(key, "output_pattern"))
                {
                    crop_param.yuvpattern = atoi(value);
                    printf("output_yuvpattern = %d\n", crop_param.yuvpattern);
                    continue;
                }

                if(strstr(key, "output_left"))
                {
                    crop_param.upper_left_x = atoi(value);
                    printf("output_left = %d\n", crop_param.upper_left_x);
                    continue;
                }

                if(strstr(key, "output_up"))
                {
                    crop_param.upper_left_y = atoi(value);
                    printf("output_up = %d\n", crop_param.upper_left_y);
                    continue;
                }

                if(strstr(key, "output_right"))
                {
                    crop_param.lower_right_x = atoi(value);
                    printf("output_right = %d\n", crop_param.lower_right_x);
                    if(crop_param.lower_right_x > topParam.frameWidth)
                    {
                        printf("\tError: parameter output_right should be smaller than frame_width\n");
                        exit(-1);
                    }
                    else if(crop_param.lower_right_x <= crop_param.upper_left_x)
                    {
                        printf("\tError: parameter output_right should be bigger than output_left\n");
                        exit(-1);
                    }
                    continue;
                }

                if(strstr(key, "output_down"))
                {
                    crop_param.lower_right_y = atoi(value);
                    printf("output_down = %d\n", crop_param.lower_right_y);
                    if(crop_param.lower_right_y > topParam.frameHeight)
                    {
                        printf("\tError: parameter output_down should be smaller than frame_height\n");
                        exit(-1);
                    }
                    else if(crop_param.lower_right_y <= crop_param.upper_left_y)
                    {
                        printf("\tError: parameter output_down should be bigger than output_up\n");
                        exit(-1);
                    }
                    continue;
                }
            }
        }
    }
    //tpg_param
    tpg_param.m_bTPG_en = 0;
    //=======================LSC Param Setting =======================//
    if(lsc_param.eb == 1) {
    if(lsc_config == 0) {
    //param 0 ypsnr:17.126 upsnr 26.179 vpsnr 22.8929
            uint13 rGain[13][17] = { {2098,2136,2244,2252,2240,2230,2230,2216,2238,2254,2278,2296,2336,2358,2408,2274,2320},{2154,2173,2220,2220,2195,2188,2185,2175,2186,2213,2234,2262,2295,2338,2343,2355,2330},{2223,2208,2216,2201,2185,2187,2175,2182,2195,2214,2229,2259,2285,2317,2359,2361,2415},{2256,2214,2212,2188,2186,2180,2190,2188,2194,2226,2254,2258,2290,2306,2352,2376,2460},{2257,2216,2200,2183,2176,2181,2186,2147,2132,2181,2239,2273,2285,2318,2353,2391,2470},{2270,2217,2199,2178,2171,2184,2150,2089,2071,2135,2215,2277,2280,2325,2351,2393,2469},{2280,2216,2192,2180,2174,2176,2128,2062,2048,2120,2216,2284,2296,2326,2362,2400,2474},{2267,2227,2210,2195,2184,2193,2153,2111,2105,2166,2241,2303,2313,2342,2377,2412,2491},{2279,2231,2219,2199,2201,2207,2195,2166,2175,2229,2281,2311,2326,2363,2393,2425,2495},{2284,2232,2234,2218,2214,2202,2224,2236,2242,2286,2308,2326,2354,2382,2414,2430,2512},{2261,2227,2245,2241,2226,2218,2223,2243,2265,2290,2311,2345,2373,2405,2429,2436,2475},{2190,2231,2233,2247,2249,2237,2233,2245,2269,2294,2322,2361,2393,2423,2434,2409,2425},{2192,2170,2280,2276,2290,2290,2296,2306,2322,2346,2376,2416,2438,2468,2466,2390,2448} };
            uint13 GrGain[13][17] = { {2204,2210,2300,2316,2294,2276,2270,2264,2272,2294,2302,2342,2390,2414,2468,2330,2408},{2221,2242,2281,2269,2246,2223,2212,2212,2219,2232,2257,2289,2328,2384,2393,2410,2403},{2296,2263,2261,2239,2213,2203,2196,2200,2212,2227,2235,2268,2307,2356,2405,2415,2489},{2308,2264,2236,2208,2198,2186,2194,2190,2196,2218,2244,2262,2296,2334,2388,2414,2516},{2321,2255,2222,2205,2185,2183,2175,2139,2126,2169,2231,2268,2289,2331,2372,2425,2525},{2322,2249,2221,2198,2185,2184,2143,2079,2065,2119,2199,2277,2285,2333,2373,2419,2536},{2320,2248,2212,2196,2184,2182,2118,2050,2048,2096,2194,2272,2298,2336,2372,2426,2538},{2319,2257,2228,2209,2190,2194,2142,2095,2098,2149,2219,2291,2311,2354,2397,2447,2548},{2323,2269,2245,2219,2202,2211,2185,2159,2171,2213,2265,2303,2327,2379,2413,2463,2557},{2338,2284,2266,2246,2220,2212,2224,2228,2244,2284,2298,2322,2342,2396,2440,2474,2574},{2312,2274,2275,2272,2247,2233,2233,2249,2269,2293,2309,2339,2381,2421,2465,2479,2548},{2244,2278,2278,2285,2280,2263,2256,2264,2286,2307,2331,2375,2413,2455,2483,2464,2497},{2272,2224,2324,2326,2326,2330,2318,2320,2340,2372,2396,2438,2464,2506,2504,2432,2528} };
            uint13 GbGain[13][17] = { {2180,2202,2290,2298,2280,2264,2252,2246,2250,2270,2290,2326,2366,2406,2438,2316,2404},{2218,2233,2273,2260,2231,2212,2201,2195,2202,2217,2245,2277,2318,2379,2389,2401,2397},{2285,2267,2253,2233,2204,2196,2183,2187,2197,2213,2229,2260,2299,2348,2401,2409,2492},{2324,2258,2242,2208,2196,2180,2186,2182,2184,2210,2238,2258,2290,2332,2384,2422,2520},{2323,2261,2227,2203,2191,2183,2173,2133,2118,2167,2227,2264,2291,2336,2377,2431,2537},{2333,2259,2227,2206,2188,2192,2144,2080,2062,2122,2206,2281,2289,2340,2385,2431,2545},{2322,2266,2230,2210,2196,2188,2126,2054,2050,2108,2206,2288,2306,2348,2386,2446,2550},{2337,2272,2249,2223,2204,2206,2152,2100,2104,2160,2231,2306,2321,2367,2414,2463,2569},{2341,2289,2263,2232,2217,2221,2197,2164,2179,2224,2279,2317,2341,2391,2429,2478,2579},{2352,2296,2282,2266,2234,2224,2234,2238,2250,2288,2312,2332,2358,2414,2458,2492,2586},{2331,2289,2291,2285,2259,2243,2245,2251,2281,2306,2319,2355,2393,2444,2479,2499,2562},{2264,2292,2290,2298,2296,2277,2265,2271,2293,2319,2343,2385,2428,2469,2491,2477,2510},{2280,2240,2336,2334,2340,2328,2326,2330,2348,2382,2408,2462,2488,2526,2516,2458,2532} };
            uint13 bGain[13][17] = { {2290,2232,2382,2362,2356,2310,2268,2256,2280,2290,2300,2350,2410,2450,2504,2356,2504},{2306,2271,2329,2316,2257,2245,2216,2200,2199,2212,2243,2284,2341,2399,2425,2438,2489},{2393,2297,2317,2272,2229,2207,2197,2191,2196,2208,2217,2259,2315,2373,2443,2455,2585},{2424,2298,2292,2246,2232,2194,2196,2194,2184,2208,2218,2258,2300,2376,2418,2482,2614},{2414,2293,2270,2236,2215,2201,2192,2139,2123,2152,2227,2269,2299,2358,2425,2467,2628},{2433,2286,2270,2229,2205,2213,2160,2093,2064,2121,2203,2287,2307,2371,2430,2477,2647},{2422,2294,2268,2236,2220,2210,2142,2064,2060,2102,2212,2304,2330,2386,2434,2496,2668},{2433,2307,2280,2251,2223,2227,2164,2107,2105,2165,2239,2323,2353,2399,2459,2521,2698},{2440,2312,2312,2267,2243,2239,2208,2170,2174,2231,2295,2340,2362,2432,2482,2540,2690},{2440,2340,2332,2292,2258,2254,2256,2254,2262,2304,2334,2356,2398,2460,2516,2570,2698},{2421,2334,2359,2331,2299,2267,2269,2276,2296,2315,2347,2383,2442,2506,2556,2584,2691},{2353,2337,2364,2359,2341,2312,2303,2297,2312,2345,2369,2437,2494,2545,2579,2567,2654},{2412,2296,2420,2400,2420,2398,2352,2376,2382,2420,2474,2524,2578,2610,2604,2532,2696} };

            for (int i = 0; i < 13; i++){
                for (int j = 0; j < 17; j++) {
                    lsc_param.rGain[17*i+j] = rGain[i][j];
                    lsc_param.GrGain[17*i+j] = GrGain[i][j];
                    lsc_param.GbGain[17*i+j] = GbGain[i][j];
                    lsc_param.bGain[17*i+j] = bGain[i][j];
                }
            }
        } else if(lsc_config == 1) {
        //param 1 ypsnr:16.969 upsnr:26.6322 vpsnr: 23.097
            uint13 rGain[13][17] ={ {3126,3002,3062,3026,2958,2906,2874,2828,2868,2934,3018,3138,3244,3380,3526,3512,4132},{3036,2967,2967,2904,2827,2769,2715,2680,2696,2763,2864,2993,3145,3256,3362,3482,3663},{3020,2933,2891,2815,2734,2674,2601,2557,2564,2645,2755,2891,3037,3171,3297,3398,3598},{2984,2882,2804,2722,2646,2570,2488,2426,2424,2516,2654,2800,2946,3074,3232,3344,3538},{2932,2817,2747,2662,2572,2469,2369,2264,2250,2359,2531,2707,2861,3023,3173,3300,3509},{2896,2781,2693,2599,2497,2395,2255,2127,2113,2236,2429,2635,2799,2966,3129,3259,3453},{2882,2752,2664,2580,2466,2342,2186,2066,2048,2170,2386,2606,2778,2958,3092,3254,3428},{2873,2773,2691,2593,2491,2379,2229,2127,2130,2242,2436,2633,2806,2977,3130,3265,3467},{2908,2789,2720,2630,2547,2448,2339,2244,2254,2369,2536,2701,2866,3021,3173,3310,3489},{2934,2824,2774,2706,2616,2526,2456,2400,2416,2526,2646,2792,2944,3094,3234,3344,3518},{2973,2867,2841,2773,2697,2621,2565,2529,2551,2629,2751,2903,3053,3183,3301,3385,3584},{2945,2920,2878,2834,2786,2711,2665,2641,2669,2752,2861,2996,3133,3261,3365,3427,3649},{3114,2906,3004,2938,2906,2862,2808,2798,2832,2892,3008,3136,3256,3382,3470,3518,4024} };
            uint13 GrGain[13][17] ={ {3180,3022,3064,3018,2960,2890,2832,2808,2826,2872,2980,3090,3218,3310,3462,3466,4090},{3033,2964,2955,2897,2813,2741,2687,2658,2661,2721,2817,2933,3082,3206,3311,3415,3656},{3031,2928,2863,2799,2701,2636,2571,2527,2525,2600,2699,2828,2967,3114,3249,3343,3539},{2988,2850,2788,2684,2612,2520,2454,2390,2394,2466,2590,2718,2880,3010,3180,3276,3478},{2926,2801,2713,2626,2529,2430,2335,2247,2237,2328,2477,2643,2791,2946,3099,3228,3460},{2889,2757,2667,2569,2464,2359,2231,2119,2104,2207,2389,2571,2730,2898,3046,3191,3419},{2870,2726,2626,2540,2436,2314,2172,2058,2048,2146,2344,2542,2708,2872,3028,3180,3392},{2865,2743,2650,2551,2444,2344,2201,2112,2113,2212,2387,2565,2729,2889,3054,3200,3406},{2902,2766,2690,2586,2497,2403,2297,2220,2231,2325,2479,2619,2789,2945,3101,3229,3453},{2922,2818,2738,2658,2564,2478,2402,2360,2390,2462,2576,2718,2858,3012,3164,3288,3478},{2951,2834,2801,2727,2646,2568,2511,2477,2499,2568,2679,2806,2954,3095,3231,3330,3525},{2946,2886,2840,2796,2739,2667,2618,2590,2619,2676,2790,2921,3062,3187,3300,3359,3606},{3104,2914,2940,2896,2850,2812,2748,2746,2756,2840,2930,3060,3184,3292,3394,3430,3982} };
            uint13 GbGain[13][17] ={ {3140,2998,3022,2972,2924,2860,2806,2772,2784,2842,2950,3056,3180,3296,3424,3436,4062},{3009,2946,2932,2870,2783,2707,2657,2621,2629,2690,2787,2908,3045,3186,3286,3383,3635},{3009,2917,2847,2771,2680,2610,2543,2502,2500,2570,2683,2800,2945,3091,3225,3316,3539},{2978,2848,2778,2680,2596,2506,2428,2370,2360,2448,2570,2708,2854,2996,3158,3268,3490},{2923,2798,2709,2606,2525,2419,2321,2232,2215,2316,2469,2632,2791,2941,3100,3224,3449},{2898,2754,2660,2567,2461,2359,2226,2107,2093,2203,2384,2577,2731,2893,3049,3191,3405},{2856,2742,2632,2540,2438,2316,2174,2056,2048,2156,2356,2550,2714,2880,3036,3190,3390},{2880,2752,2657,2557,2453,2346,2215,2110,2116,2217,2394,2579,2735,2901,3069,3206,3424},{2900,2787,2697,2598,2505,2411,2307,2218,2233,2337,2485,2633,2801,2961,3107,3239,3457},{2948,2822,2762,2662,2572,2480,2410,2372,2384,2474,2590,2726,2866,3020,3178,3286,3506},{2967,2851,2803,2747,2651,2576,2514,2474,2505,2579,2683,2816,2967,3118,3243,3335,3533},{2960,2901,2848,2806,2755,2673,2618,2595,2619,2690,2800,2928,3071,3195,3306,3370,3613},{3104,2922,2948,2902,2852,2820,2762,2750,2766,2836,2956,3062,3192,3290,3414,3448,4014} };
            uint13 bGain[13][17]={ {3356,3128,3230,3150,3068,2984,2916,2874,2882,2942,3050,3154,3320,3474,3666,3638,4636},{3231,3072,3089,2997,2895,2808,2726,2683,2694,2741,2858,2989,3167,3323,3463,3563,3915},{3243,3025,2999,2890,2775,2684,2599,2545,2534,2611,2721,2869,3042,3235,3405,3518,3845},{3170,2960,2896,2786,2672,2556,2484,2390,2390,2456,2606,2770,2954,3158,3296,3452,3820},{3106,2909,2833,2701,2596,2469,2357,2245,2225,2314,2489,2671,2869,3062,3248,3387,3710},{3094,2850,2773,2651,2519,2403,2249,2125,2093,2209,2401,2619,2810,3031,3213,3373,3701},{3062,2850,2750,2620,2510,2348,2198,2070,2048,2150,2364,2598,2794,3012,3194,3390,3672},{3063,2857,2770,2650,2515,2391,2239,2123,2127,2227,2427,2630,2840,3029,3227,3401,3746},{3091,2883,2817,2686,2579,2467,2333,2243,2243,2358,2529,2711,2899,3095,3293,3453,3779},{3124,2944,2872,2784,2660,2550,2460,2406,2420,2512,2646,2818,3000,3192,3360,3538,3818},{3162,2968,2932,2867,2763,2670,2585,2544,2559,2633,2782,2943,3119,3296,3466,3586,3911},{3177,3055,2988,2945,2881,2794,2723,2691,2699,2792,2921,3079,3248,3396,3566,3645,4013},{3350,3086,3134,3082,3028,2978,2888,2858,2890,2974,3102,3252,3406,3586,3676,3696,4500} };

            for (int i = 0; i < 13; i++){
                for (int j = 0; j < 17; j++) {
                    lsc_param.rGain[17*i+j] = rGain[i][j];
                    lsc_param.GrGain[17*i+j] = GrGain[i][j];
                    lsc_param.GbGain[17*i+j] = GbGain[i][j];
                    lsc_param.bGain[17*i+j] = bGain[i][j];
                }
            }
    } else if(lsc_config == 2) {
        //param 2 ypsnr:16.969126 upsnr:26.616530 vpsnr: 23.098202
            uint13 rGain[13][17] ={ {3122,3004,3054,3028,2950,2922,2856,2828,2860,2946,2990,3150,3240,3390,3536,3522,4134},{3033,2967,2965,2899,2829,2771,2709,2678,2693,2770,2870,2993,3141,3256,3359,3478,3665},{3019,2935,2884,2820,2731,2681,2593,2565,2563,2651,2750,2900,3033,3173,3292,3410,3591},{2984,2876,2810,2722,2648,2570,2492,2418,2428,2524,2648,2808,2944,3068,3234,3334,3560},{2929,2825,2745,2659,2567,2471,2357,2267,2247,2365,2521,2712,2859,3029,3167,3307,3492},{2895,2776,2687,2604,2497,2399,2244,2133,2110,2246,2415,2640,2797,2968,3120,3261,3452},{2874,2764,2656,2584,2466,2348,2178,2068,2048,2178,2378,2618,2778,2960,3088,3262,3436},{2877,2772,2681,2597,2489,2380,2225,2130,2125,2250,2418,2644,2802,2979,3124,3270,3458},{2908,2784,2713,2631,2542,2452,2329,2242,2249,2374,2522,2704,2858,3020,3168,3310,3487},{2944,2834,2768,2708,2614,2530,2458,2408,2418,2528,2636,2800,2954,3098,3224,3364,3524},{2969,2869,2834,2773,2697,2627,2558,2532,2551,2637,2741,2906,3043,3188,3295,3399,3587},{2954,2921,2874,2834,2783,2719,2657,2643,2670,2754,2852,2999,3135,3260,3361,3430,3649},{3106,2904,2996,2928,2906,2852,2802,2800,2830,2896,3008,3138,3256,3382,3478,3528,4028} };
            uint13 GrGain[13][17] ={ {3182,3022,3062,3018,2964,2878,2836,2818,2824,2882,2970,3096,3220,3320,3450,3500,4094},{3035,2969,2955,2895,2812,2747,2684,2657,2660,2726,2811,2945,3078,3213,3307,3411,3663},{3034,2929,2865,2799,2700,2640,2564,2530,2529,2609,2692,2835,2966,3119,3249,3348,3550},{2992,2862,2776,2696,2612,2532,2446,2398,2392,2472,2588,2730,2876,3016,3174,3280,3482},{2930,2800,2710,2623,2521,2434,2327,2246,2230,2331,2467,2645,2793,2947,3095,3233,3461},{2894,2761,2658,2574,2461,2366,2221,2123,2102,2215,2375,2583,2725,2898,3047,3200,3411},{2870,2732,2628,2540,2436,2320,2166,2062,2048,2154,2332,2546,2708,2872,3024,3190,3394},{2871,2743,2646,2554,2441,2349,2195,2115,2110,2222,2374,2577,2724,2899,3052,3209,3407},{2895,2767,2683,2590,2498,2403,2289,2221,2226,2331,2467,2628,2777,2947,3101,3237,3453},{2924,2822,2738,2654,2570,2478,2402,2366,2386,2470,2572,2718,2856,3020,3158,3290,3482},{2951,2833,2800,2734,2643,2575,2506,2481,2500,2578,2672,2815,2953,3103,3227,3335,3525},{2949,2883,2843,2794,2735,2673,2617,2593,2620,2686,2781,2927,3058,3191,3291,3366,3615},{3098,2912,2934,2904,2836,2816,2746,2740,2750,2840,2932,3058,3174,3296,3394,3458,3980} };
            uint13 GbGain[13][17] ={ {3136,3008,3030,2984,2918,2876,2792,2776,2786,2854,2930,3058,3178,3304,3426,3464,4074},{3017,2949,2934,2875,2785,2717,2657,2625,2631,2697,2786,2920,3049,3195,3285,3387,3644},{3011,2917,2855,2776,2681,2618,2543,2504,2505,2583,2671,2811,2943,3104,3227,3334,3544},{2984,2864,2766,2680,2600,2518,2426,2382,2366,2454,2576,2720,2860,3008,3160,3278,3488},{2928,2800,2709,2611,2521,2425,2313,2230,2216,2320,2461,2634,2789,2943,3097,3229,3451},{2884,2772,2660,2571,2459,2371,2219,2117,2095,2217,2373,2586,2730,2900,3053,3199,3409},{2868,2744,2632,2544,2434,2328,2172,2062,2048,2162,2346,2558,2712,2890,3038,3202,3402},{2875,2758,2658,2565,2452,2354,2206,2114,2118,2230,2389,2587,2735,2903,3065,3219,3427},{2901,2791,2695,2603,2503,2415,2301,2223,2229,2342,2477,2647,2795,2963,3108,3247,3464},{2952,2832,2754,2672,2572,2490,2414,2374,2390,2482,2578,2732,2866,3032,3178,3298,3508},{2969,2855,2813,2752,2653,2587,2517,2487,2505,2591,2683,2823,2968,3122,3243,3351,3540},{2968,2900,2857,2804,2757,2684,2618,2600,2623,2703,2793,2938,3069,3203,3308,3379,3621},{3102,2932,2954,2906,2856,2816,2764,2752,2762,2846,2944,3082,3192,3302,3404,3478,4016} };
            uint13 bGain[13][17]={ {3348,3140,3222,3142,3072,2996,2916,2844,2886,2966,3018,3164,3326,3482,3660,3650,4654},{3238,3075,3095,3009,2904,2807,2731,2685,2695,2752,2853,2999,3159,3331,3455,3572,3929},{3249,3031,3001,2894,2775,2699,2594,2555,2534,2617,2709,2886,3047,3237,3405,3527,3873},{3194,2978,2906,2770,2694,2572,2480,2400,2394,2476,2586,2798,2954,3150,3306,3474,3788},{3118,2914,2823,2716,2581,2473,2343,2249,2226,2323,2476,2681,2865,3067,3247,3398,3715},{3106,2853,2775,2653,2521,2408,2246,2131,2094,2221,2391,2631,2810,3033,3217,3377,3721},{3076,2836,2750,2630,2502,2374,2196,2078,2048,2166,2368,2606,2794,3022,3192,3406,3672},{3063,2865,2775,2643,2523,2393,2229,2129,2127,2234,2411,2647,2851,3039,3236,3403,3763},{3093,2886,2822,2695,2585,2465,2335,2243,2246,2371,2516,2719,2900,3111,3268,3462,3777},{3124,2932,2872,2782,2664,2560,2454,2418,2422,2520,2646,2838,2992,3182,3386,3528,3864},{3161,2989,2933,2882,2759,2675,2584,2555,2563,2654,2777,2953,3131,3301,3463,3609,3915},{3182,3037,3007,2945,2878,2801,2725,2683,2703,2806,2906,3093,3253,3409,3573,3645,4023},{3354,3074,3150,3068,3032,2970,2872,2874,2894,2972,3126,3264,3408,3602,3652,3714,4518} };

            for (int i = 0; i < 13; i++){
                for (int j = 0; j < 17; j++) {
                    lsc_param.rGain[17*i+j] = rGain[i][j];
                    lsc_param.GrGain[17*i+j] = GrGain[i][j];
                    lsc_param.GbGain[17*i+j] = GbGain[i][j];
                    lsc_param.bGain[17*i+j] = bGain[i][j];
                }
            }
    } else if(lsc_config == 3) {
        //param 3 ypsnr: 16.969824 upsnr:26.563582 vpsnr: 23.645957
            uint13 rGain[13][17] =    { {3498,3250,3300,3274,3178,3150,3098,3020,3032,3062,3090,3160,3230,3284,3380,3344,4036},{3285,3171,3188,3143,3065,2990,2909,2861,2841,2881,2931,3009,3097,3167,3209,3273,3482},{3235,3145,3099,3051,2946,2881,2778,2732,2699,2745,2805,2891,2987,3071,3156,3188,3369},{3196,3056,3006,2918,2844,2760,2644,2570,2530,2586,2680,2788,2866,2970,3068,3132,3282},{3122,2986,2917,2819,2723,2623,2493,2388,2338,2415,2519,2667,2772,2871,2984,3061,3230},{3057,2910,2832,2730,2626,2512,2345,2217,2161,2250,2386,2556,2665,2792,2889,2989,3143},{2994,2842,2760,2666,2552,2420,2238,2098,2050,2136,2300,2484,2608,2718,2830,2938,3102},{2941,2805,2727,2631,2515,2393,2217,2104,2063,2149,2281,2460,2579,2701,2803,2897,3059},{2905,2779,2701,2613,2519,2407,2261,2156,2125,2209,2327,2459,2571,2690,2791,2870,3025},{2914,2748,2706,2626,2528,2432,2332,2260,2238,2304,2372,2506,2590,2698,2780,2868,3020},{2863,2745,2704,2646,2552,2469,2381,2326,2318,2361,2435,2541,2630,2727,2790,2855,2983},{2789,2735,2693,2650,2593,2505,2429,2393,2381,2424,2481,2574,2661,2735,2801,2821,2972},{2832,2698,2748,2708,2640,2598,2532,2498,2484,2500,2582,2650,2726,2810,2840,2846,3104} };
            uint13 GrGain[13][17] =   { {3340,3100,3128,3102,3052,2994,2938,2902,2886,2908,2944,3014,3056,3112,3178,3182,3844},{3102,3029,3035,2997,2927,2866,2791,2750,2725,2755,2795,2871,2945,3019,3048,3096,3288},{3081,2995,2955,2906,2822,2754,2674,2625,2597,2631,2681,2762,2845,2933,2999,3029,3179},{3046,2942,2878,2802,2726,2644,2560,2482,2460,2498,2570,2662,2750,2842,2924,2978,3114},{2981,2867,2791,2717,2622,2530,2415,2336,2294,2347,2442,2559,2654,2754,2846,2916,3071},{2925,2797,2726,2639,2535,2438,2297,2188,2141,2214,2326,2471,2571,2679,2775,2867,3000},{2868,2748,2652,2578,2470,2364,2198,2088,2048,2118,2248,2404,2516,2626,2712,2814,2954},{2819,2717,2627,2548,2438,2338,2185,2089,2059,2125,2235,2388,2489,2599,2700,2791,2928},{2795,2692,2618,2532,2437,2349,2217,2135,2112,2173,2275,2385,2489,2601,2691,2767,2907},{2778,2684,2620,2540,2450,2364,2276,2222,2206,2254,2316,2420,2502,2610,2686,2766,2882},{2747,2648,2613,2563,2474,2403,2322,2275,2265,2307,2364,2454,2539,2630,2701,2755,2869},{2689,2648,2599,2573,2515,2440,2374,2334,2327,2357,2412,2498,2577,2650,2710,2726,2857},{2774,2610,2656,2610,2564,2524,2448,2432,2398,2444,2492,2574,2630,2704,2738,2738,3014} };
            uint13 GbGain[13][17] =   { {3312,3074,3098,3072,3030,2978,2914,2886,2868,2888,2924,2994,3042,3086,3150,3152,3778},{3098,3010,3018,2983,2905,2851,2781,2730,2712,2737,2784,2855,2925,3001,3027,3075,3275},{3066,2986,2941,2882,2807,2745,2659,2614,2584,2619,2668,2751,2831,2913,2982,3021,3160},{3038,2926,2870,2792,2716,2622,2548,2474,2446,2486,2566,2650,2734,2828,2914,2960,3108},{2969,2857,2782,2703,2616,2526,2409,2324,2283,2345,2430,2550,2647,2751,2840,2912,3056},{2916,2801,2717,2625,2531,2433,2291,2180,2135,2211,2325,2470,2563,2678,2767,2859,2989},{2862,2746,2658,2572,2476,2362,2202,2086,2048,2120,2252,2406,2510,2626,2730,2816,2956},{2831,2715,2634,2548,2438,2341,2187,2089,2063,2131,2241,2395,2487,2599,2703,2786,2925},{2805,2693,2623,2532,2438,2350,2221,2137,2119,2180,2278,2393,2496,2597,2692,2767,2905},{2780,2686,2626,2550,2460,2374,2280,2234,2204,2260,2324,2428,2512,2614,2694,2764,2900},{2749,2659,2618,2571,2481,2408,2330,2281,2274,2316,2372,2456,2548,2639,2708,2758,2869},{2689,2658,2606,2578,2524,2449,2381,2346,2331,2371,2421,2504,2580,2664,2709,2730,2851},{2756,2622,2660,2610,2572,2518,2464,2430,2422,2458,2504,2586,2646,2712,2748,2734,3036} };
            uint13 bGain[13][17]=     { {3340,3084,3128,3090,3018,2966,2906,2852,2846,2868,2894,2976,3038,3106,3190,3196,3884},{3145,2996,3017,2976,2883,2832,2761,2705,2681,2709,2759,2831,2925,2993,3042,3098,3321},{3098,2972,2945,2871,2783,2715,2635,2584,2548,2585,2637,2727,2817,2919,2998,3042,3209},{3066,2896,2862,2772,2696,2606,2524,2446,2416,2448,2518,2630,2724,2828,2916,2980,3154},{2980,2840,2765,2681,2594,2493,2386,2297,2262,2309,2409,2519,2634,2745,2844,2907,3091},{2925,2777,2699,2609,2503,2405,2278,2171,2123,2189,2297,2442,2550,2672,2772,2859,3014},{2870,2722,2638,2550,2450,2336,2184,2086,2050,2100,2232,2382,2492,2618,2714,2820,2982},{2839,2693,2619,2529,2415,2323,2171,2090,2058,2121,2222,2369,2484,2600,2703,2803,2960},{2809,2675,2616,2528,2427,2334,2214,2129,2109,2173,2266,2384,2488,2607,2695,2787,2951},{2796,2666,2628,2536,2446,2358,2268,2218,2198,2254,2320,2418,2520,2624,2708,2800,2924},{2772,2653,2629,2570,2481,2402,2321,2277,2260,2303,2368,2467,2558,2653,2734,2791,2925},{2721,2657,2623,2585,2531,2451,2381,2337,2325,2365,2424,2517,2605,2683,2749,2762,2921},{2804,2646,2682,2632,2596,2540,2466,2444,2414,2466,2524,2598,2686,2752,2774,2778,3114} };

            for (int i = 0; i < 13; i++){
                for (int j = 0; j < 17; j++) {
                    lsc_param.rGain[17*i+j] = rGain[i][j];
                    lsc_param.GrGain[17*i+j] = GrGain[i][j];
                    lsc_param.GbGain[17*i+j] = GbGain[i][j];
                    lsc_param.bGain[17*i+j] = bGain[i][j];
                }
            }
    } else if(lsc_config == 4) {
        //param 4 ypsnr:17.111246 upsnr:26.017605 vpsnr:23.262669
            uint13 rGain[13][17] =    { {2776,2684,2728,2690,2640,2580,2522,2474,2504,2550,2610,2682,2778,2862,2970,2920,3356},{2759,2687,2690,2633,2555,2497,2429,2395,2397,2449,2519,2625,2719,2813,2872,2956,3108},{2825,2707,2678,2603,2521,2464,2376,2344,2333,2399,2469,2587,2695,2787,2891,2952,3129},{2846,2720,2658,2574,2496,2418,2332,2254,2242,2318,2428,2552,2654,2764,2878,2978,3138},{2862,2735,2665,2568,2481,2385,2268,2155,2123,2218,2364,2533,2645,2784,2893,2985,3189},{2897,2767,2679,2577,2485,2379,2216,2099,2061,2165,2323,2534,2653,2801,2911,3027,3216},{2952,2808,2694,2642,2506,2392,2226,2100,2074,2174,2354,2566,2696,2850,2962,3090,3272},{3010,2864,2795,2691,2578,2473,2323,2229,2205,2307,2453,2651,2781,2917,3046,3166,3357},{3091,2933,2871,2780,2678,2587,2469,2391,2384,2479,2599,2740,2881,3014,3134,3242,3427},{3172,3024,2962,2886,2802,2696,2614,2574,2580,2662,2746,2882,2998,3132,3240,3336,3478},{3201,3095,3057,2999,2915,2829,2751,2715,2728,2799,2891,3027,3140,3255,3327,3390,3557},{3218,3139,3128,3080,3029,2955,2887,2856,2869,2939,3013,3143,3252,3349,3409,3411,3654},{3428,3176,3238,3210,3178,3112,3070,3052,3088,3112,3206,3324,3396,3466,3532,3542,4158} };
            uint13 GrGain[13][17] =   { {2718,2620,2664,2622,2570,2510,2458,2434,2440,2480,2520,2598,2686,2748,2836,2808,3224},{2683,2631,2631,2579,2503,2447,2380,2357,2351,2390,2450,2541,2626,2715,2768,2831,2957},{2743,2657,2608,2546,2466,2406,2335,2297,2291,2338,2401,2498,2593,2695,2776,2839,2959},{2774,2664,2596,2516,2446,2360,2290,2226,2204,2270,2364,2472,2572,2674,2778,2840,2996},{2790,2671,2595,2513,2427,2335,2229,2145,2111,2187,2310,2457,2557,2672,2779,2864,3022},{2818,2695,2607,2529,2426,2332,2197,2098,2059,2143,2278,2456,2561,2691,2792,2891,3057},{2850,2730,2636,2554,2446,2352,2208,2100,2074,2150,2300,2476,2604,2722,2832,2938,3092},{2901,2786,2699,2613,2507,2411,2291,2205,2185,2267,2386,2551,2669,2795,2903,3005,3159},{2961,2853,2773,2688,2597,2507,2403,2349,2339,2410,2514,2637,2755,2881,2983,3069,3225},{3022,2928,2862,2784,2698,2610,2524,2492,2500,2562,2634,2752,2846,2978,3060,3150,3274},{3061,2961,2932,2880,2791,2722,2652,2613,2621,2683,2755,2864,2963,3068,3149,3202,3347},{3072,3007,2979,2947,2899,2838,2767,2745,2752,2803,2869,2977,3073,3156,3216,3234,3441},{3254,3060,3082,3054,3016,2980,2926,2902,2898,2954,3034,3128,3194,3260,3292,3338,3810} };
            uint13 GbGain[13][17] =   { {2708,2594,2654,2610,2554,2502,2448,2424,2426,2466,2520,2594,2678,2748,2828,2796,3186},{2681,2626,2618,2571,2498,2436,2377,2350,2347,2380,2442,2533,2617,2705,2761,2817,2951},{2734,2658,2601,2536,2459,2400,2326,2294,2284,2331,2397,2492,2584,2684,2769,2821,2963},{2762,2658,2590,2518,2436,2360,2282,2220,2198,2272,2356,2472,2564,2666,2768,2848,2980},{2787,2672,2586,2504,2423,2335,2227,2139,2107,2187,2311,2449,2556,2670,2776,2857,3013},{2813,2696,2601,2523,2427,2331,2197,2093,2059,2143,2279,2456,2563,2687,2793,2891,3045},{2844,2726,2644,2550,2446,2350,2210,2100,2076,2156,2306,2478,2600,2728,2830,2942,3098},{2907,2789,2703,2616,2507,2417,2296,2203,2193,2275,2391,2558,2665,2788,2906,3005,3150},{2969,2857,2785,2693,2598,2514,2412,2350,2348,2417,2517,2645,2755,2887,2983,3067,3223},{3036,2934,2872,2796,2698,2622,2536,2504,2502,2578,2642,2758,2856,2978,3072,3148,3282},{3063,2971,2939,2887,2805,2733,2663,2619,2635,2693,2758,2871,2971,3078,3155,3198,3340},{3081,3025,2988,2961,2915,2845,2784,2755,2758,2822,2877,2988,3081,3171,3219,3235,3437},{3276,3062,3078,3060,3018,2992,2926,2916,2920,2968,3056,3130,3202,3278,3290,3332,3826} };
            uint13 bGain[13][17]=     { {2760,2630,2702,2642,2588,2518,2466,2414,2442,2476,2522,2608,2696,2784,2876,2852,3314},{2732,2645,2639,2591,2511,2459,2387,2351,2344,2384,2449,2533,2645,2730,2789,2851,3005},{2797,2664,2622,2553,2468,2411,2334,2295,2279,2328,2393,2505,2600,2709,2801,2873,3027},{2814,2666,2614,2530,2450,2366,2288,2222,2196,2262,2350,2464,2582,2706,2778,2870,3048},{2834,2673,2604,2518,2431,2340,2229,2143,2106,2174,2308,2451,2564,2684,2792,2879,3059},{2858,2698,2620,2527,2421,2331,2199,2103,2061,2138,2271,2451,2564,2705,2813,2915,3081},{2878,2732,2640,2562,2448,2346,2212,2106,2082,2148,2290,2478,2602,2732,2850,2976,3126},{2939,2794,2717,2621,2505,2414,2295,2210,2189,2268,2379,2545,2671,2806,2923,3026,3213},{3009,2858,2801,2697,2607,2511,2404,2351,2335,2412,2514,2644,2765,2895,3004,3099,3277},{3060,2946,2888,2804,2702,2628,2538,2496,2494,2564,2648,2766,2868,3000,3096,3188,3354},{3119,2987,2965,2899,2815,2739,2657,2627,2625,2683,2767,2884,2999,3099,3183,3259,3396},{3135,3042,3023,2992,2926,2857,2791,2753,2756,2818,2891,3009,3104,3202,3265,3296,3528},{3338,3090,3138,3096,3058,3020,2932,2936,2926,2984,3080,3158,3258,3322,3348,3392,3908} };

            for (int i = 0; i < 13; i++){
                for (int j = 0; j < 17; j++) {
                    lsc_param.rGain[17*i+j] = rGain[i][j];
                    lsc_param.GrGain[17*i+j] = GrGain[i][j];
                    lsc_param.GbGain[17*i+j] = GbGain[i][j];
                    lsc_param.bGain[17*i+j] = bGain[i][j];
                }
            }
        } else if(lsc_config == 5) {
        //param 5 ypsnr:16.985384 upsnr:26.592188 vpsnr: 23.338125
            uint13 rGain[13][17] =    { {3942,3426,3368,3292,3174,3138,3030,2948,2930,2996,3040,3152,3236,3352,3488,3510,4066},{3491,3299,3246,3177,3065,2970,2867,2789,2767,2805,2890,2993,3125,3219,3311,3407,3637},{3399,3247,3183,3079,2966,2871,2731,2657,2611,2667,2759,2895,3007,3151,3256,3338,3545},{3352,3198,3092,2994,2862,2744,2594,2480,2438,2496,2634,2790,2924,3042,3182,3288,3482},{3300,3139,3046,2909,2779,2630,2447,2317,2258,2328,2472,2681,2834,2989,3129,3255,3433},{3276,3112,2989,2853,2703,2541,2331,2186,2109,2200,2363,2591,2765,2943,3087,3220,3398},{3266,3088,2968,2838,2668,2488,2278,2118,2048,2140,2318,2560,2754,2924,3076,3232,3410},{3267,3119,3002,2859,2703,2535,2326,2191,2133,2222,2381,2611,2786,2965,3105,3249,3433},{3305,3148,3041,2916,2777,2627,2446,2323,2275,2370,2507,2699,2866,3025,3165,3295,3465},{3356,3200,3112,3004,2864,2746,2592,2512,2478,2550,2656,2838,2964,3110,3254,3340,3536},{3406,3248,3181,3098,2975,2852,2743,2669,2641,2703,2811,2962,3087,3228,3315,3403,3575},{3485,3317,3234,3170,3085,2973,2875,2816,2795,2857,2946,3071,3200,3311,3387,3445,3685},{3944,3402,3356,3290,3196,3148,3046,3012,2984,3034,3118,3250,3336,3430,3526,3582,4112} };
            uint13 GrGain[13][17] =   { {3816,3308,3248,3188,3096,3030,2946,2898,2866,2894,2958,3036,3138,3224,3340,3364,3956},{3413,3190,3149,3081,2986,2895,2797,2732,2703,2739,2805,2917,3021,3126,3197,3281,3508},{3301,3147,3073,2998,2886,2784,2673,2596,2559,2604,2680,2804,2924,3050,3149,3228,3411},{3244,3096,2998,2908,2794,2678,2538,2436,2388,2448,2562,2710,2838,2964,3080,3170,3350},{3198,3051,2947,2838,2705,2567,2402,2283,2230,2293,2422,2611,2754,2903,3029,3136,3325},{3178,3021,2917,2794,2647,2495,2298,2163,2097,2175,2325,2539,2697,2860,2991,3116,3300},{3164,3006,2880,2766,2616,2454,2248,2100,2048,2118,2284,2502,2682,2842,2984,3118,3294},{3173,3025,2919,2795,2641,2491,2293,2168,2121,2195,2335,2549,2711,2881,3015,3151,3304},{3200,3055,2961,2843,2709,2577,2400,2295,2255,2324,2455,2629,2783,2938,3065,3185,3348},{3236,3116,3022,2934,2792,2672,2536,2464,2434,2496,2588,2746,2874,3018,3134,3236,3410},{3286,3147,3080,3012,2895,2785,2673,2604,2582,2641,2731,2863,2983,3113,3202,3285,3463},{3397,3203,3129,3081,3000,2903,2801,2749,2734,2783,2859,2983,3089,3193,3271,3329,3569},{3780,3318,3236,3168,3106,3060,2958,2916,2900,2950,3030,3136,3206,3308,3372,3440,3972} };
            uint13 GbGain[13][17] =   { {3776,3292,3222,3158,3068,3000,2914,2858,2830,2874,2932,3014,3104,3192,3316,3336,3894},{3377,3181,3124,3058,2962,2872,2773,2711,2680,2713,2784,2892,2998,3105,3172,3260,3480},{3273,3141,3055,2977,2865,2771,2651,2575,2537,2583,2663,2788,2906,3027,3129,3205,3387},{3250,3090,2992,2898,2778,2660,2520,2422,2370,2434,2552,2692,2816,2950,3068,3164,3342},{3194,3046,2941,2825,2699,2562,2389,2269,2216,2287,2410,2596,2744,2891,3025,3131,3313},{3169,3025,2909,2790,2639,2490,2294,2155,2088,2169,2314,2535,2689,2853,2988,3115,3285},{3162,3010,2890,2762,2614,2452,2244,2102,2048,2120,2288,2502,2678,2846,2990,3116,3298},{3179,3031,2922,2799,2645,2492,2295,2163,2121,2197,2337,2557,2714,2879,3010,3147,3319},{3213,3063,2969,2850,2709,2576,2408,2295,2257,2333,2459,2631,2787,2944,3070,3177,3360},{3252,3124,3034,2934,2802,2676,2542,2466,2436,2496,2594,2756,2880,3028,3136,3236,3402},{3299,3158,3083,3017,2899,2792,2681,2607,2589,2646,2729,2863,2989,3121,3210,3289,3469},{3406,3211,3138,3083,3008,2905,2809,2755,2740,2787,2866,2983,3098,3201,3278,3333,3581},{3794,3326,3230,3184,3114,3058,2962,2920,2904,2962,3024,3148,3212,3304,3378,3444,3986} };
            uint13 bGain[13][17]=     { {4000,3448,3390,3306,3184,3096,3006,2916,2906,2948,2988,3124,3218,3334,3452,3464,4266},{3596,3288,3243,3156,3050,2948,2825,2749,2710,2748,2829,2949,3085,3211,3290,3403,3674},{3460,3247,3168,3069,2934,2820,2692,2608,2554,2607,2687,2829,2982,3131,3245,3351,3597},{3398,3172,3100,2978,2834,2702,2548,2430,2374,2436,2554,2724,2866,3030,3164,3290,3518},{3347,3131,3023,2896,2740,2589,2402,2273,2215,2275,2417,2619,2794,2963,3110,3239,3485},{3309,3093,2992,2841,2672,2506,2298,2155,2083,2163,2317,2550,2729,2918,3081,3214,3464},{3340,3076,2968,2814,2658,2468,2254,2106,2048,2110,2284,2524,2718,2900,3068,3226,3438},{3315,3107,3005,2848,2677,2515,2301,2165,2121,2197,2342,2573,2763,2945,3105,3258,3492},{3356,3139,3061,2908,2763,2609,2419,2297,2259,2339,2474,2670,2835,3025,3169,3302,3544},{3378,3216,3134,3010,2860,2726,2570,2488,2452,2532,2626,2804,2952,3120,3256,3390,3594},{3463,3259,3203,3115,2979,2849,2727,2649,2623,2682,2791,2941,3087,3239,3358,3443,3673},{3593,3311,3264,3201,3105,2989,2879,2809,2789,2843,2940,3087,3221,3343,3430,3492,3816},{4164,3452,3424,3302,3240,3166,3056,3004,2988,3050,3142,3272,3362,3466,3536,3624,4274} };

            for (int i = 0; i < 13; i++){
                for (int j = 0; j < 17; j++) {
                    lsc_param.rGain[17*i+j] = rGain[i][j];
                    lsc_param.GrGain[17*i+j] = GrGain[i][j];
                    lsc_param.GbGain[17*i+j] = GbGain[i][j];
                    lsc_param.bGain[17*i+j] = bGain[i][j];
                }
            }
        } else if(lsc_config == 6) {
        //param 6 ypsnr:17.049161 upsnr:26.450756 vpsnr:23.309857
            uint13 rGain[13][17] =    { {2702,2632,2742,2738,2726,2690,2670,2648,2682,2740,2770,2864,2926,2964,3084,3006,3514},{2656,2631,2675,2655,2605,2583,2547,2531,2547,2600,2660,2742,2835,2907,2947,2993,3112},{2689,2625,2628,2585,2536,2507,2463,2451,2459,2524,2571,2669,2753,2838,2918,2961,3087},{2670,2594,2562,2516,2472,2424,2394,2368,2378,2440,2508,2590,2688,2758,2876,2922,3064},{2647,2551,2515,2457,2411,2359,2310,2254,2247,2333,2429,2533,2619,2720,2814,2894,3069},{2609,2524,2472,2407,2358,2313,2221,2142,2113,2229,2357,2481,2562,2680,2765,2871,3024},{2604,2494,2434,2390,2334,2274,2152,2068,2048,2156,2308,2454,2542,2654,2754,2852,3004},{2587,2495,2450,2388,2326,2273,2172,2100,2091,2194,2320,2461,2543,2652,2747,2847,3008},{2597,2494,2458,2407,2350,2308,2233,2172,2178,2273,2379,2479,2559,2673,2765,2855,3003},{2604,2514,2488,2440,2390,2336,2312,2280,2290,2372,2436,2526,2606,2706,2794,2848,2990},{2588,2515,2517,2483,2430,2393,2359,2357,2369,2435,2491,2588,2670,2755,2823,2876,2979},{2528,2523,2522,2503,2485,2441,2417,2410,2429,2485,2546,2640,2709,2793,2848,2845,2953},{2534,2488,2580,2570,2562,2544,2524,2528,2532,2588,2664,2738,2812,2876,2912,2846,3062} };
            uint13 GrGain[13][17] =   { {2702,2604,2692,2682,2670,2642,2618,2620,2614,2658,2698,2790,2852,2896,2974,2922,3388},{2608,2591,2624,2614,2567,2537,2509,2497,2507,2545,2603,2680,2765,2839,2865,2901,3027},{2631,2579,2573,2547,2493,2464,2429,2414,2426,2470,2521,2605,2688,2775,2842,2871,2988},{2622,2548,2520,2474,2436,2392,2360,2334,2344,2394,2454,2544,2620,2714,2794,2844,2960},{2599,2513,2469,2420,2378,2330,2279,2231,2221,2295,2381,2482,2562,2655,2740,2817,2948},{2569,2479,2432,2384,2327,2286,2200,2122,2104,2197,2312,2439,2515,2616,2703,2792,2929},{2546,2454,2396,2352,2304,2246,2142,2054,2048,2130,2270,2404,2492,2596,2678,2766,2910},{2531,2454,2402,2355,2296,2253,2151,2086,2080,2171,2281,2413,2494,2591,2685,2771,2907},{2528,2463,2417,2367,2319,2281,2204,2155,2161,2239,2334,2429,2518,2609,2693,2779,2898},{2546,2480,2446,2398,2348,2310,2278,2254,2264,2332,2394,2474,2552,2648,2726,2796,2898},{2529,2468,2464,2440,2398,2353,2327,2316,2335,2386,2437,2523,2601,2685,2754,2797,2901},{2471,2480,2469,2469,2443,2407,2377,2373,2392,2441,2495,2579,2651,2730,2777,2783,2873},{2500,2458,2520,2524,2514,2504,2460,2464,2474,2534,2582,2668,2728,2786,2808,2790,2954} };
            uint13 GbGain[13][17] =   { {2678,2588,2668,2656,2646,2620,2600,2594,2594,2646,2698,2764,2830,2892,2956,2890,3376},{2599,2584,2608,2596,2553,2522,2496,2480,2491,2531,2583,2669,2749,2826,2853,2891,3015},{2616,2581,2564,2531,2483,2451,2416,2404,2411,2454,2509,2589,2677,2766,2836,2865,2977},{2618,2548,2508,2466,2424,2380,2344,2324,2330,2388,2454,2534,2616,2704,2782,2844,2962},{2595,2509,2459,2413,2370,2325,2271,2221,2212,2288,2377,2473,2561,2655,2745,2817,2950},{2565,2485,2430,2375,2326,2285,2198,2119,2104,2195,2316,2442,2513,2616,2705,2792,2921},{2546,2462,2400,2356,2304,2254,2144,2052,2048,2138,2278,2410,2490,2598,2684,2782,2908},{2547,2461,2412,2362,2301,2261,2160,2091,2090,2177,2294,2427,2497,2599,2694,2779,2906},{2541,2478,2429,2375,2325,2286,2217,2160,2170,2249,2347,2446,2523,2629,2703,2790,2914},{2554,2484,2464,2418,2366,2322,2290,2262,2274,2348,2410,2486,2568,2652,2738,2798,2924},{2537,2482,2479,2452,2405,2370,2335,2328,2348,2401,2451,2534,2613,2707,2768,2811,2915},{2489,2495,2485,2485,2459,2426,2393,2387,2401,2454,2514,2590,2669,2750,2791,2795,2885},{2518,2468,2532,2526,2526,2510,2478,2482,2498,2552,2596,2688,2752,2806,2832,2794,2992} };
            uint13 bGain[13][17]=     { {2786,2662,2758,2754,2730,2684,2652,2618,2644,2716,2736,2830,2932,2992,3066,3034,3568},{2712,2627,2685,2653,2605,2561,2521,2499,2505,2549,2613,2703,2805,2899,2941,2983,3205},{2719,2631,2636,2577,2514,2473,2425,2418,2412,2464,2513,2622,2725,2836,2925,2965,3144},{2728,2590,2566,2522,2444,2390,2358,2330,2326,2374,2438,2548,2638,2780,2862,2940,3114},{2690,2550,2511,2441,2389,2326,2270,2219,2209,2276,2371,2481,2595,2698,2815,2898,3089},{2663,2525,2467,2403,2336,2286,2203,2119,2101,2188,2301,2442,2540,2666,2778,2874,3065},{2624,2498,2432,2374,2318,2248,2144,2060,2048,2118,2272,2420,2514,2644,2738,2872,3034},{2628,2497,2449,2383,2311,2259,2153,2089,2084,2169,2280,2427,2517,2641,2749,2861,3072},{2636,2505,2468,2402,2335,2289,2207,2157,2163,2241,2336,2459,2544,2667,2775,2878,3063},{2646,2530,2512,2428,2374,2322,2300,2260,2272,2336,2422,2496,2594,2710,2830,2896,3086},{2633,2527,2533,2499,2425,2380,2339,2332,2355,2400,2465,2561,2665,2769,2861,2913,3053},{2572,2540,2541,2531,2493,2445,2411,2395,2415,2473,2529,2633,2733,2833,2891,2901,3053},{2590,2518,2640,2602,2594,2556,2498,2512,2524,2586,2676,2750,2834,2914,2932,2926,3122} };

            for (int i = 0; i < 13; i++){
                for (int j = 0; j < 17; j++) {
                    lsc_param.rGain[17*i+j] = rGain[i][j];
                    lsc_param.GrGain[17*i+j] = GrGain[i][j];
                    lsc_param.GbGain[17*i+j] = GbGain[i][j];
                    lsc_param.bGain[17*i+j] = bGain[i][j];
                }
            }
        } else if(lsc_config == 7) {
        //param 7 ypsnr:17.034996 upsnr:26.731127 vpsnr:23.103818
        uint13 rGain[13][17] =    { {2722,2674,2770,2772,2732,2722,2704,2694,2710,2774,2814,2898,2954,3032,3104,3036,3432},{2679,2656,2703,2682,2642,2621,2594,2577,2595,2646,2715,2789,2873,2946,2994,3044,3129},{2703,2661,2657,2622,2581,2559,2521,2501,2511,2569,2637,2729,2807,2893,2962,3008,3112},{2682,2628,2614,2560,2532,2498,2444,2406,2406,2482,2572,2668,2752,2834,2918,2978,3100},{2665,2596,2557,2511,2468,2417,2346,2277,2262,2357,2470,2602,2690,2787,2879,2954,3081},{2627,2563,2509,2460,2411,2356,2243,2149,2123,2237,2379,2542,2631,2749,2833,2918,3038},{2606,2524,2478,2434,2374,2308,2170,2068,2048,2168,2326,2508,2616,2706,2800,2900,3016},{2590,2523,2477,2437,2373,2306,2185,2103,2097,2204,2347,2517,2607,2723,2806,2891,3014},{2589,2527,2480,2439,2399,2347,2252,2183,2188,2292,2413,2540,2641,2741,2817,2897,3011},{2592,2526,2498,2470,2428,2384,2338,2304,2314,2398,2480,2586,2666,2772,2856,2906,3002},{2580,2532,2525,2497,2455,2421,2391,2381,2396,2465,2537,2637,2718,2802,2865,2912,3001},{2513,2537,2523,2515,2498,2461,2440,2439,2460,2520,2588,2676,2751,2834,2886,2889,2963},{2540,2486,2570,2564,2552,2542,2528,2532,2548,2606,2674,2758,2826,2888,2940,2904,3036} };
        uint13 GrGain[13][17] =   { {2802,2696,2782,2772,2750,2722,2700,2694,2706,2752,2782,2874,2952,3004,3076,3048,3442},{2695,2685,2711,2693,2647,2609,2577,2570,2574,2620,2681,2764,2845,2935,2966,3009,3156},{2723,2669,2655,2616,2563,2533,2493,2481,2486,2539,2591,2679,2767,2865,2945,2980,3124},{2706,2624,2588,2538,2496,2460,2410,2382,2384,2440,2514,2606,2692,2788,2882,2944,3098},{2669,2581,2532,2479,2430,2376,2317,2256,2245,2321,2430,2542,2635,2731,2830,2915,3063},{2638,2539,2487,2438,2374,2325,2225,2133,2111,2213,2343,2491,2577,2689,2786,2875,3037},{2614,2504,2450,2402,2344,2276,2156,2054,2048,2136,2290,2446,2554,2660,2744,2854,3016},{2587,2504,2449,2396,2334,2278,2161,2088,2082,2179,2303,2465,2552,2662,2761,2856,3003},{2583,2513,2460,2405,2350,2309,2216,2168,2169,2255,2363,2479,2575,2681,2773,2855,3008},{2582,2526,2478,2438,2376,2336,2296,2272,2288,2362,2428,2524,2598,2712,2798,2874,3010},{2573,2508,2499,2474,2423,2379,2348,2341,2361,2417,2473,2567,2655,2749,2828,2880,2998},{2519,2513,2502,2497,2471,2427,2403,2394,2421,2471,2533,2620,2704,2791,2843,2869,2958},{2564,2482,2550,2544,2530,2518,2488,2490,2504,2570,2620,2716,2778,2838,2892,2862,3082} };
        uint13 GbGain[13][17] =   { {2772,2686,2760,2750,2724,2690,2658,2660,2660,2710,2768,2850,2922,2996,3044,3004,3428},{2695,2673,2699,2675,2625,2590,2553,2535,2547,2593,2654,2741,2827,2911,2957,3003,3130},{2721,2662,2639,2596,2550,2515,2469,2456,2457,2511,2573,2663,2755,2854,2932,2977,3123},{2712,2632,2590,2538,2490,2438,2396,2358,2360,2424,2506,2608,2686,2788,2884,2944,3100},{2687,2588,2535,2481,2433,2377,2311,2247,2229,2317,2426,2542,2638,2739,2842,2925,3083},{2653,2565,2500,2445,2387,2335,2225,2130,2107,2214,2347,2506,2587,2703,2801,2897,3050},{2620,2534,2472,2418,2360,2290,2164,2060,2048,2150,2308,2476,2574,2680,2786,2878,3048},{2612,2534,2474,2420,2354,2298,2181,2097,2092,2194,2325,2487,2568,2686,2784,2881,3030},{2608,2539,2483,2425,2373,2327,2239,2173,2181,2266,2386,2501,2595,2709,2796,2881,3039},{2622,2540,2508,2468,2402,2358,2308,2286,2290,2376,2440,2548,2634,2736,2830,2914,3044},{2606,2534,2520,2494,2444,2401,2363,2349,2372,2431,2496,2585,2683,2779,2855,2902,3037},{2555,2542,2520,2519,2495,2447,2416,2415,2427,2491,2544,2646,2724,2822,2873,2893,2998},{2582,2506,2584,2548,2546,2528,2504,2498,2534,2574,2656,2730,2812,2866,2906,2886,3104} };
        uint13 bGain[13][17]=     { {3108,2898,3072,2972,2962,2892,2862,2798,2814,2870,2870,3022,3148,3258,3388,3326,4100},{3027,2863,2928,2884,2810,2741,2670,2642,2643,2691,2757,2867,3005,3113,3195,3282,3560},{3031,2852,2857,2777,2694,2654,2569,2550,2537,2581,2649,2784,2903,3037,3166,3257,3579},{3010,2808,2792,2694,2640,2542,2492,2432,2424,2472,2570,2706,2812,2992,3060,3214,3528},{2986,2745,2723,2628,2549,2472,2379,2289,2259,2338,2482,2636,2774,2919,3059,3176,3450},{2946,2717,2666,2587,2492,2420,2279,2164,2117,2235,2398,2597,2719,2885,3028,3137,3471},{2882,2668,2622,2548,2470,2384,2210,2086,2048,2160,2366,2570,2720,2878,3000,3142,3432},{2871,2681,2635,2551,2459,2383,2219,2109,2102,2214,2376,2591,2722,2875,2999,3128,3479},{2855,2667,2639,2545,2483,2422,2289,2205,2198,2314,2463,2625,2741,2907,3013,3155,3461},{2866,2696,2670,2612,2532,2438,2404,2348,2350,2452,2546,2682,2802,2950,3100,3204,3478},{2868,2707,2700,2652,2584,2526,2463,2439,2463,2525,2617,2743,2879,2985,3131,3237,3499},{2783,2719,2716,2680,2644,2582,2545,2530,2537,2605,2707,2819,2950,3075,3191,3214,3517},{2926,2704,2850,2774,2774,2724,2638,2662,2690,2748,2852,2924,3072,3166,3286,3196,3668} };

            for (int i = 0; i < 13; i++){
                for (int j = 0; j < 17; j++) {
                    lsc_param.rGain[17*i+j] = rGain[i][j];
                    lsc_param.GrGain[17*i+j] = GrGain[i][j];
                    lsc_param.GbGain[17*i+j] = GbGain[i][j];
                    lsc_param.bGain[17*i+j] = bGain[i][j];
                }
            }
        } else {
            printf("illegal LSC configuration!\n");
            exit(-1);
        }
    }

    // demosaic
    demosaic_param.eb = 1;

    // cmc
    cmc_param.m_nGain[0] = 6709;
    cmc_param.m_nGain[1] = -2591;
    cmc_param.m_nGain[2] = -22;
    cmc_param.m_nGain[3] = 0;
    cmc_param.m_nGain[4] = -632;
    cmc_param.m_nGain[5] = 5336;
    cmc_param.m_nGain[6] = -607;
    cmc_param.m_nGain[7] = 0;
    cmc_param.m_nGain[8] = 156;
    cmc_param.m_nGain[9] = -2970;
    cmc_param.m_nGain[10] = 6912;
    cmc_param.m_nGain[11] = 0;

    // gtm
    uint10 tab[129] =
        {0, 20, 40, 64, 84, 108, 128, 148, 168, 196, 220, 244, 268, 296, 320, 344,
        368, 388, 408, 428, 448, 468, 488, 504, 524, 540, 556, 568, 584, 596, 608, 616,
        628, 636, 648, 656, 664, 672, 680, 688, 696, 704, 708, 716, 724, 728, 736, 740,
        748, 752, 760, 764, 772, 776, 784, 788, 796, 800, 804, 812, 816, 820, 824, 828,
        832, 836, 840, 844, 848, 852, 856, 860, 864, 868, 868, 872, 876, 880, 880, 884,
        888, 892, 892, 896, 900, 904, 904, 908, 912, 916, 916, 920, 924, 928, 928, 932,
        936, 940, 940, 944, 948, 948, 952, 952, 956, 960, 960, 964, 968, 972, 972, 976,
        980, 980, 984, 984, 988, 992, 992, 996, 1000, 1000, 1004, 1004, 1008, 1012, 1012, 1016, 1023};

    if(gtm_gamma != 0.0) {
        float curve_x[129];
        curve_x[0]=0;
        for (int i = 1; i < 129; i++)
        {
            curve_x[i] = curve_x[i-1]+ 0.0078125;
        };
        for (int i = 0; i < 129 ;i++)
        {
            tab[i] = (uint10)(((float)pow(curve_x[i],gtm_gamma))*1023);
        };
    }

    for (x=0;x<129;x++){
        gtm_param.gtmTab_0[x] = tab[x];
        gtm_param.gtmTab_1[x] = tab[x];
        gtm_param.gtmTab_2[x] = tab[x];
    }

    // lut
    const char* lut_file;
    char *p1, *q1, *r, *s;
    char line[300];
    char line2[300];
    char line3[300];
    char value1[100], value2[100], value3[100];
    int i = 0;
    int k = 0;
    int DataStart = 1;
    int axis_r, axis_g, axis_b;
    int odd_r, odd_g, odd_b;
    FILE* fp_lut;
    if(lut_param.size == 17) {
        fp_lut = fopen((const char*)LUT_CUBE_17, "r");
    }
    else if(lut_param.size == 32) {
        fp_lut = fopen((const char*)LUT_CUBE, "r");
    }
    else {
        fp_lut = fopen((const char*)LUT_CUBE, "r");
    }

    if(fp_lut == NULL)
    {
        printf("\t Warning: no lut file!\n");
    }
    else{
        while(fgets(line, 300, fp_lut)){
            p1 = strchr(line, ' ');
            if (p1 != NULL)
            {
                strncpy(value1, line, p1 - line);
                strcpy(line2, p1 + 1);
                q1 = strchr(line2, ' ');
                if (q1 != NULL)
                {
                    strncpy(value2, line2, q1 - line2);
                    strcpy(value3, q1 + 1);
                }
            }

            axis_r = i % lut_param.size;
            axis_g = (i % (lut_param.size * lut_param.size)) / lut_param.size;
            axis_b = i / (lut_param.size * lut_param.size);

            odd_r = axis_r % 2;
            odd_g = axis_g % 2;
            odd_b = axis_b % 2;

            k = (axis_r / 2) + (axis_g / 2) * ((32 + 1) >> 1) + (axis_b / 2) * ((32 + 1) >> 1) * ((32 + 1) >> 1);

            if(odd_r == 0 && odd_g == 0 && odd_b == 0) {
                lut_param.lut_000[k] = atoi(value1);
                lut_param.lut_000[k] = atoi(value2) + (lut_param.lut_000[k] << 14);
                lut_param.lut_000[k] = atoi(value3) + (lut_param.lut_000[k] << 14);
            }
            else if(odd_r == 0 && odd_g == 0 && odd_b == 1) {
                lut_param.lut_001[k] = atoi(value1);
                lut_param.lut_001[k] = atoi(value2) + (lut_param.lut_001[k] << 14);
                lut_param.lut_001[k] = atoi(value3) + (lut_param.lut_001[k] << 14);
            }
            else if(odd_r == 0 && odd_g == 1 && odd_b == 0) {
                lut_param.lut_010[k] = atoi(value1);
                lut_param.lut_010[k] = atoi(value2) + (lut_param.lut_010[k] << 14);
                lut_param.lut_010[k] = atoi(value3) + (lut_param.lut_010[k] << 14);
            }
            else if(odd_r == 0 && odd_g == 1 && odd_b == 1) {
                lut_param.lut_011[k] = atoi(value1);
                lut_param.lut_011[k] = atoi(value2) + (lut_param.lut_011[k] << 14);
                lut_param.lut_011[k] = atoi(value3) + (lut_param.lut_011[k] << 14);
            }
            else if(odd_r == 1 && odd_g == 0 && odd_b == 0) {
                lut_param.lut_100[k] = atoi(value1);
                lut_param.lut_100[k] = atoi(value2) + (lut_param.lut_100[k] << 14);
                lut_param.lut_100[k] = atoi(value3) + (lut_param.lut_100[k] << 14);
            }
            else if(odd_r == 1 && odd_g == 0 && odd_b == 1) {
                lut_param.lut_101[k] = atoi(value1);
                lut_param.lut_101[k] = atoi(value2) + (lut_param.lut_101[k] << 14);
                lut_param.lut_101[k] = atoi(value3) + (lut_param.lut_101[k] << 14);
            }
            else if(odd_r == 1 && odd_g == 1 && odd_b == 0) {
                lut_param.lut_110[k] = atoi(value1);
                lut_param.lut_110[k] = atoi(value2) + (lut_param.lut_110[k] << 14);
                lut_param.lut_110[k] = atoi(value3) + (lut_param.lut_110[k] << 14);
            }
            else if(odd_r == 1 && odd_g == 1 && odd_b == 1) {
                lut_param.lut_111[k] = atoi(value1);
                lut_param.lut_111[k] = atoi(value2) + (lut_param.lut_111[k] << 14);
                lut_param.lut_111[k] = atoi(value3) + (lut_param.lut_111[k] << 14);
            }
            i++;
        }
    }

    // csc
    csc_param.m_nEb = 1;
    csc_param.coeff[0] = 308;
    csc_param.coeff[1] = 600;
    csc_param.coeff[2] = 116;
    csc_param.coeff[3] = 0;
    csc_param.coeff[4] = -172;
    csc_param.coeff[5] = -340;
    csc_param.coeff[6] = 512;
    csc_param.coeff[7] = 512;
    csc_param.coeff[8] = 512;
    csc_param.coeff[9] = -428;
    csc_param.coeff[10] = -84;
    csc_param.coeff[11] = 512;

    // scaledown
    uint13 out_width_1 = topParam.frameWidth;
    uint13 out_height_1 = topParam.frameHeight;
    scaledown_param.times = 2;
    uint13 out_width_2 = topParam.frameWidth / scaledown_param.times;
    uint13 out_height_2 = topParam.frameHeight / scaledown_param.times;
    scaledown_param.times = 4;
    uint13 out_width_3 = topParam.frameWidth / scaledown_param.times;
    uint13 out_height_3 = topParam.frameHeight / scaledown_param.times;

    // crop
    uint13 out_width = crop_param.lower_right_y - crop_param.upper_left_y;
    uint13 out_height = crop_param.lower_right_x - crop_param.upper_left_x;

// execute test
// loading files by time
while((ptr_src=readdir(dir_raw))!=NULL && (ptr_golden=readdir(dir_yuv))!=NULL && (ptr_wb=readdir(dir_wb))!=NULL)
{

    if(ptr_wb->d_name[0] == '.')
        continue;
    wb_name = ptr_wb->d_name;
    std::string path_file_wb = path_wb + wb_name;
    top_wb = path_file_wb.c_str();
    printf("wb file = %s\n", top_wb);

    FILE *fp_wb1 = fopen(top_wb, "r");
    if(!fp_wb1){
        printf("Can not open wb file!\n");
    }
    else {
    char gain[20];
    char r_gain_ch[20];
    char b_gain_ch[20];
    char *ptr;
    fscanf(fp_wb1, "%s", r_gain_ch);
    fscanf(fp_wb1, "%s", b_gain_ch);
    double r_gain = strtod(r_gain_ch, &ptr);
    double b_gain = strtod(b_gain_ch, &ptr);
    printf("%.16lf\n", r_gain);
    printf("%.16lf\n", b_gain);
    wbc_param.m_nR = wbc_param.m_nGr.to_uint() / r_gain;
    wbc_param.m_nB = (wbc_param.m_nGb.to_uint() / b_gain) + 1;
    printf("wbc_param.m_nR = %d\n", wbc_param.m_nR);
    printf("wbc_param.m_nB = %d\n", wbc_param.m_nB);
    }

    if(ptr_src->d_name[0] == '.')
        continue;
    src_name = ptr_src->d_name;
    std::string path_file_src = path_src + src_name;
    top_src = path_file_src.c_str();
    printf("%s\n", top_src);
    FILE *fp_r1 = fopen(top_src, "r");
    if(!fp_r1){
        printf("Can not open input file!\n");
    }

    if(ptr_golden->d_name[0] == '.')
        continue;
    golden_name = ptr_golden->d_name;
    std::string path_file_golden = path_golden + golden_name;
    top_golden = path_file_golden.c_str();
    printf("%s\n", top_golden);
    FILE *fp_g1 = fopen(top_golden, "r");
    if(!fp_g1){
        printf("Can not open golden file!\n");
    }

    std::string path_file_dst = path_dst + golden_name;
    top_dst = path_file_dst.c_str();
    FILE *fp_w1 = fopen(top_dst, "w");
    if(!fp_w1){
        printf("Can not open dst file!\n");
    }

    uint16_t frameIn;
    uint16_t frameGolden_1;
    uint16_t frameOut_1;

    for (x = 0; x < topParam.frameWidth*topParam.frameHeight; x++) {
        fread(&frameIn, sizeof(uint16_t), 1, fp_r1);
        uint12 srcdata = (uint12)frameIn;
        src.write(srcdata);
    }
    printf("\tInit done!\n");

    printf("\tEnvironment set up!\n");

    //Execution
    CCS_DESIGN(isp_top) ( src,
             y_dst,
             u_dst,
             v_dst,
             topParam,
             afc_param,
             tpg_param,
             dgain_param,
             lsc_param,
             dpc_param,
             rawdns_param,
             awb_param,
             wbc_param,
             gb_param,
             demosaic_param,
             ee_param,
             cmc_param,
             gtm_param,
             lut_param,
             ltm_param,
             cac_param,
             csc_param,
             yfc_param,
             yuvdns_param,
             scaledown_param,
             crop_param
        );
    printf("\tExecution completed!\n");

    for (x = 0; x < 3 * topParam.frameWidth * topParam.frameHeight; x++) {
        if(x < topParam.frameWidth * topParam.frameHeight)
        {
            y_out_data = y_dst.read();
            frameOut_1 = y_out_data;
            fwrite(&frameOut_1, sizeof(uint16_t), 1, fp_w1);
        }
        else if(x < 2 * topParam.frameWidth * topParam.frameHeight)
        {
            u_out_data = u_dst.read();
            frameOut_1 = u_out_data;
            fwrite(&frameOut_1, sizeof(uint16_t), 1, fp_w1);
        }
        else
        {
            v_out_data = v_dst.read();
            frameOut_1 = v_out_data;
            fwrite(&frameOut_1, sizeof(uint16_t), 1, fp_w1);
        }

        fread(&frameGolden_1, sizeof(uint16_t), 1, fp_g1);

        if (frameGolden_1 != frameOut_1) {
            printf("\t\tFirst mismatch in pixel %d, channel %d!\n", x / 3, x % 3);
            printf("\t\tFirst mismatch in row %d, col %d!\n", (x/3)/topParam.frameWidth, ((x/3) - (x/3)/topParam.frameWidth * topParam.frameWidth));
            cout << "Golden = " << setbase(10) << frameGolden_1 << endl;
            cout << "result = " << setbase(10) << frameOut_1 << endl;
            exit(0);
        }
        frameGolden_1 = 0;
        frameOut_1 = 0;
    }

    printf("\tTest passed!\n");

    printf("next image \n");
    fclose(fp_r1);
    fclose(fp_g1);
    fclose(fp_wb1);
    fclose(fp_w1);
}

    closedir(dir_raw);
    closedir(dir_yuv);
    closedir(dir_wb);

    return 0;
}