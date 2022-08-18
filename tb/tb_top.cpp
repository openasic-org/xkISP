#include "../src/top.h"
#include "../src/tpg.h"
#include "../src/dgain.h"
#include "../src/lsc.h"
#include "../src/wbc.h"
#include "../src/gb2.h"
#include "../src/demosaic.h"
#include "../src/cmc.h"
#include "../src/gtm.h"
#include "../src/csc.h"
#include "../src/yuv444to422.h"
#include "../src/crop.h"
#include "../src/isp_top.h"

#define CASE3

#ifdef CASE0
#define TOP_SRC1 "/rshome/yanheng.lu/20210220/ISP_FPGA_prototype/vivado_hls/tv/top/input3.raw" //tpg case, actually useless
#define TOP_DST1 "/rshome/yanheng.lu/20210220/ISP_FPGA_prototype/vivado_hls/tv/top/output0_result.yuv"
#define TOP_GOLDEN1 "/rshome/yanheng.lu/20210220/ISP_FPGA_prototype/vivado_hls/tv/top/output0_csc.yuv"
#endif
#ifdef CASE1
#define TOP_SRC1 "/rshome/yanheng.lu/20210220/ISP_FPGA_prototype/vivado_hls/tv/top/input1.raw"
#define TOP_DST1 "/rshome/yanheng.lu/20210220/ISP_FPGA_prototype/vivado_hls/tv/top/output1_result.yuv"
#define TOP_GOLDEN1 "/rshome/yanheng.lu/20210220/ISP_FPGA_prototype/vivado_hls/tv/top/output1_csc.yuv"
#endif
#ifdef CASE3
#define TOP_SRC1 "/rshome/yanheng.lu/20210908/ISP_FPGA_prototype/vivado_hls/tv/top/input3.raw"
#define TOP_DST1 "/rshome/yanheng.lu/20210908/ISP_FPGA_prototype/vivado_hls/tv/top/output3_result.yuv"
#define TOP_GOLDEN1 "/rshome/yanheng.lu/20210908/ISP_FPGA_prototype/vivado_hls/tv/top/output3.yuv"
#endif

int main(int argc, char** argv)
{
    top_register topParam;
    tpg_register tpg_param;
    dgain_register dgain_param;
    lsc_register lsc_param;
    wbc_register wbc_param;
    gb_register gb_param;
    demosaic_register demosaic_param;
    cmc_register cmc_param;
    gtm_register gtm_param;
    csc_register csc_param;
    yuv444to422_register yuv444to422_param;
    crop_register crop_param;
    stream_u12 src;
    stream_u30 dst;
    int x;
    uint10 y_o;
    uint10 u_o;
    uint10 v_o;
    uint12 srcdata;
    uint30 dstdata;

    printf("\tTest for ISP top module!\n");
    memset(&topParam, 0, sizeof(top_register));
    memset(&tpg_param, 0, sizeof(tpg_register));
    memset(&dgain_param, 0, sizeof(dgain_register));
    memset(&lsc_param, 0, sizeof(lsc_register));
    memset(&wbc_param, 0, sizeof(wbc_register));
    memset(&gb_param, 0, sizeof(gb_register));
    memset(&demosaic_param, 0, sizeof(demosaic_register));
    memset(&cmc_param, 0, sizeof(cmc_register));
    memset(&gtm_param, 0, sizeof(gtm_register));
    memset(&csc_param, 0, sizeof(csc_register));
    memset(&yuv444to422_param, 0, sizeof(yuv444to422_register));
    memset(&crop_param, 0, sizeof(crop_register));

#ifdef CASE1
    topParam.frameWidth = 1920;
    topParam.frameHeight = 1080;
    dgain_param.m_nEb = 1;
    dgain_param.m_nR= 0x01000;
    dgain_param.m_nGr = 0x01000;
    dgain_param.m_nGb = 0x01000;
    dgain_param.m_nB = 0x01000;
    wbc_param.m_nEb = 1;
    wbc_param.m_nR= 4096;
    wbc_param.m_nGr = 4096;
    wbc_param.m_nGb = 4096;
    wbc_param.m_nB = 4096;
    demosaic_param.eb = 1;
    cmc_param.m_nEb = 1;
    cmc_param.m_nGain[0] = 4096;
    cmc_param.m_nGain[1] = 0;
    cmc_param.m_nGain[2] = 0;
    cmc_param.m_nGain[3] = 0;
    cmc_param.m_nGain[4] = 4096;
    cmc_param.m_nGain[5] = 0;
    cmc_param.m_nGain[6] = 0;
    cmc_param.m_nGain[7] = 0;
    cmc_param.m_nGain[8] = 4096;
    gtm_param.eb = 1;
    gtm_param.m_bDitheringEnable = 1;
    uint10 tab[129] =
        {0, 20, 40, 64, 84, 108, 128, 148, 168, 196, 220, 244, 268, 296, 320, 344,
        368, 388, 408, 428, 448, 468, 488, 504, 524, 540, 556, 568, 584, 596, 608, 616,
        628, 636, 648, 656, 664, 672, 680, 688, 696, 704, 708, 716, 724, 728, 736, 740,
        748, 752, 760, 764, 772, 776, 784, 788, 796, 800, 804, 812, 816, 820, 824, 828,
        832, 836, 840, 844, 848, 852, 856, 860, 864, 868, 868, 872, 876, 880, 880, 884,
        888, 892, 892, 896, 900, 904, 904, 908, 912, 916, 916, 920, 924, 928, 928, 932,
        936, 940, 940, 944, 948, 948, 952, 952, 956, 960, 960, 964, 968, 972, 972, 976,
        980, 980, 984, 984, 988, 992, 992, 996, 1000, 1000, 1004, 1004, 1008, 1012, 1012, 1016, 1023};
    for (x=0;x<129;x++){
        gtm_param.gtmTab[x] = tab[x];
    }
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
#endif
#ifdef CASE0
    topParam.frameWidth = 1920;
    topParam.frameHeight = 1080;
    tpg_param.m_bTPG_en = 1;
    dgain_param.m_nEb = 1;
    dgain_param.m_nR= 0x01000;
    dgain_param.m_nGr = 0x01000;
    dgain_param.m_nGb = 0x01000;
    dgain_param.m_nB = 0x01000;
    wbc_param.m_nEb = 1;
    wbc_param.m_nR= 4096;
    wbc_param.m_nGr = 4096;
    wbc_param.m_nGb = 4096;
    wbc_param.m_nB = 4096;
    demosaic_param.eb = 1;
    cmc_param.m_nEb = 1;
    cmc_param.m_nGain[0] = 4096;
    cmc_param.m_nGain[1] = 0;
    cmc_param.m_nGain[2] = 0;
    cmc_param.m_nGain[3] = 0;
    cmc_param.m_nGain[4] = 4096;
    cmc_param.m_nGain[5] = 0;
    cmc_param.m_nGain[6] = 0;
    cmc_param.m_nGain[7] = 0;
    cmc_param.m_nGain[8] = 4096;
    gtm_param.eb = 1;
    gtm_param.m_bDitheringEnable = 1;
    uint10 tab[129] =
        {0, 20, 40, 64, 84, 108, 128, 148, 168, 196, 220, 244, 268, 296, 320, 344,
        368, 388, 408, 428, 448, 468, 488, 504, 524, 540, 556, 568, 584, 596, 608, 616,
        628, 636, 648, 656, 664, 672, 680, 688, 696, 704, 708, 716, 724, 728, 736, 740,
        748, 752, 760, 764, 772, 776, 784, 788, 796, 800, 804, 812, 816, 820, 824, 828,
        832, 836, 840, 844, 848, 852, 856, 860, 864, 868, 868, 872, 876, 880, 880, 884,
        888, 892, 892, 896, 900, 904, 904, 908, 912, 916, 916, 920, 924, 928, 928, 932,
        936, 940, 940, 944, 948, 948, 952, 952, 956, 960, 960, 964, 968, 972, 972, 976,
        980, 980, 984, 984, 988, 992, 992, 996, 1000, 1000, 1004, 1004, 1008, 1012, 1012, 1016, 1023};
    for (x=0;x<129;x++){
        gtm_param.gtmTab[x] = tab[x];
    }
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
#endif
#ifdef CASE3
    topParam.frameWidth = 1928;
    topParam.frameHeight = 1088;
    topParam.blc = 16;
    topParam.imgPattern = 3;
    dgain_param.m_nEb = 1;
    dgain_param.m_nR= 0x01000;
    dgain_param.m_nGr = 0x01000;
    dgain_param.m_nGb = 0x01000;
    dgain_param.m_nB = 0x01000;
    wbc_param.m_nEb = 1;
    wbc_param.m_nR= 8192;
    wbc_param.m_nGr = 4096;
    wbc_param.m_nGb = 4096;
    wbc_param.m_nB = 8192;
    demosaic_param.eb = 1;
    gb_param.eb = 1;
    gb_param.win_size = 7;
    cmc_param.m_nEb = 1;
    cmc_param.m_nGain[0] = 7893;
    cmc_param.m_nGain[1] = -2503;
    cmc_param.m_nGain[2] = -1229;
    cmc_param.m_nGain[4] = -2093;
    cmc_param.m_nGain[5] = 7115;
    cmc_param.m_nGain[6] = -655;
    cmc_param.m_nGain[8] = 98;
    cmc_param.m_nGain[9] = -708;
    cmc_param.m_nGain[10] = 7299;
    gtm_param.eb = 1;
    gtm_param.m_bDitheringEnable = 1;
    uint10 tab[129] =
        {0, 20, 40, 64, 84, 108, 128, 148, 168, 196, 220, 244, 268, 296, 320, 344,
        368, 388, 408, 428, 448, 468, 488, 504, 524, 540, 556, 568, 584, 596, 608, 616,
        628, 636, 648, 656, 664, 672, 680, 688, 696, 704, 708, 716, 724, 728, 736, 740,
        748, 752, 760, 764, 772, 776, 784, 788, 796, 800, 804, 812, 816, 820, 824, 828,
        832, 836, 840, 844, 848, 852, 856, 860, 864, 868, 868, 872, 876, 880, 880, 884,
        888, 892, 892, 896, 900, 904, 904, 908, 912, 916, 916, 920, 924, 928, 928, 932,
        936, 940, 940, 944, 948, 948, 952, 952, 956, 960, 960, 964, 968, 972, 972, 976,
        980, 980, 984, 984, 988, 992, 992, 996, 1000, 1000, 1004, 1004, 1008, 1012, 1012, 1016, 1023};
    for (x=0;x<129;x++){
        gtm_param.gtmTab[x] = tab[x];
    }
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
    yuv444to422_param.m_nEb = 1;
    crop_param.m_nEb = 1;
    crop_param.upper_left_x = 160;
    crop_param.upper_left_y = 120;
    crop_param.lower_right_x = 1280;
    crop_param.lower_right_y = 860;
#endif

    int output_width = crop_param.lower_right_x - crop_param.upper_left_x;
    int output_height = crop_param.lower_right_y - crop_param.upper_left_y;
    uint16_t* frameIn = (uint16_t*)malloc((int)topParam.frameWidth * (int)topParam.frameHeight * sizeof(uint16_t));
    uint16_t* frameGolden = (uint16_t*)malloc(3 * output_width * output_height * sizeof(uint16_t));
    uint16_t* frameOut = (uint16_t*)malloc(3 * output_width * output_height * sizeof(uint16_t));

    //In
    FILE *fp_r1 = fopen(TOP_SRC1, "r");
    if(!fp_r1){
        printf("Can not open input file!\n");
    }

    for (x = 0; x < topParam.frameWidth*topParam.frameHeight; x++) {
        fread(&frameIn[x], sizeof(uint16_t), 1, fp_r1);
        srcdata = (uint12)frameIn[x];
        src.write(srcdata);
    }
    printf("\tInit done!\n");

    //Golden
    FILE *fp_g1 = fopen(TOP_GOLDEN1, "r");
    if(!fp_g1){
        printf("Can not open golden file!\n");
    }

    for (x = 0; x < 3*output_width*output_height; x++) {
        fread(&frameGolden[x], sizeof(uint16_t), 1, fp_g1);
    }
    printf("\tEnvironment set up!\n");

    //Execution
    isp_top(src, dst, topParam, tpg_param, dgain_param, lsc_param, wbc_param, gb_param, demosaic_param, cmc_param, gtm_param, csc_param, yuv444to422_param, crop_param);
    printf("\tExecution completed!\n");
    printf("\t%d\n",dst.size());

    //Out
    FILE *fp_w1 = fopen(TOP_DST1, "w");
    if(!fp_w1){
        printf("\tCan not open write back file!\n");
    }

    for (x = 0; x < output_width*output_height; x++) {
        dstdata = dst.read();
        y_o = dstdata >> 20;
        u_o = (dstdata >> 10) & 0x3ff;
        v_o = dstdata & 0x3ff;
        frameOut[3*x] = y_o;
        frameOut[3*x+1] = u_o;
        frameOut[3*x+2] = v_o;
    }

    fwrite(frameOut, sizeof(uint16_t), (3* output_width * output_height), fp_w1);

    //Checker
    for (x = 0; x < 3 * output_width*output_height; x++) {
        if(frameGolden[x] != frameOut[x]) {
            printf("\t\tFirst mismatch in pixel %d, channel %d!\n", x/3, x%3);
            cout << "Golden = " << setbase(16) << frameGolden[x] << endl;
            cout << "result = " << setbase(16) << frameOut[x] << endl;
            exit(0);
        }
    }
    printf("\tTest passed!\n");

    fclose(fp_r1);
    fclose(fp_g1);
    fclose(fp_w1);

    return 0;
}

