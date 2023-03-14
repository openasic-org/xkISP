#include "../src/gtm.h"
#include "../src/file_define_catapult.h"
#include <ac_int.h>
#include <mc_scverify.h>

CCS_MAIN(int argc, char** argv)
{
    top_register topParam;
    gtm_register gtm_param;
    ac_channel<uint42> src;
    ac_channel<uint42> dst;
    int x;
    uint14 red;
    uint14 green;
    uint14 blue;
    uint14 red_o;
    uint14 green_o;
    uint14 blue_o;
    uint42 srcdata;
    uint42 dstdata;

    printf("\tTest for ISP gtm module!\n");

    const char* config_file = "../config/xkISP.cfg";

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
            }
        }
    }

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

    uint16_t frameIn[3];
    uint16_t frameGolden[3];
    uint16_t frameOut[3];

    //In
    FILE *fp_r1 = fopen(GTM_SRC1, "r");
    if(!fp_r1){
        printf("Can not open input file!\n");
    }

    for (x = 0; x < topParam.frameWidth*topParam.frameHeight; x++) {
        fread(&frameIn[0], sizeof(uint16_t), 1, fp_r1);
        red = (uint14)frameIn[0];
        fread(&frameIn[1], sizeof(uint16_t), 1, fp_r1);
        green = (uint14)frameIn[1];
        fread(&frameIn[2], sizeof(uint16_t), 1, fp_r1);
        blue = (uint14)frameIn[2];
        srcdata = red;
        srcdata = (srcdata << 14) + green;
        srcdata = (srcdata << 14) + blue;
        src.write(srcdata);
    }
    printf("\tInit done!\n");

    //Golden
    FILE *fp_g1 = fopen(GTM_GOLDEN1, "r");
    if(!fp_g1){
        printf("Can not open golden file!\n");
    }

    printf("\tEnvironment set up!\n");

    //Execution
    CCS_DESIGN(gtm) (topParam, gtm_param, src, dst);

    printf("\tExecution completed!\n");
    printf("\t%d\n",dst.size());

    //Out
    FILE *fp_w1 = fopen(GTM_DST1, "w");
    if(!fp_w1){
        printf("\tCan not open write back file!\n");
    }

    for (x = 0; x < topParam.frameWidth*topParam.frameHeight; x++) {
        dstdata = dst.read();
        red_o = dstdata >> 28;
        green_o = (dstdata >> 14) & 0x3fff;
        blue_o = dstdata & 0x3fff;
        frameOut[0] = red_o;
        frameOut[1] = green_o;
        frameOut[2] = blue_o;
        fwrite(&frameOut[0], sizeof(uint16_t), 1, fp_w1);
        fwrite(&frameOut[1], sizeof(uint16_t), 1, fp_w1);
        fwrite(&frameOut[2], sizeof(uint16_t), 1, fp_w1);
        fread(&frameGolden[0], sizeof(uint16_t), 1, fp_g1);
        fread(&frameGolden[1], sizeof(uint16_t), 1, fp_g1);
        fread(&frameGolden[2], sizeof(uint16_t), 1, fp_g1);
        if((frameGolden[0] != frameOut[0]) || (frameGolden[1] != frameOut[1]) || (frameGolden[2] != frameOut[2])) {
            printf("\t\tFirst mismatch in pixel %d, channel %d!\n", x/3, x%3);
            cout << "Golden = " << setbase(16) << frameGolden[x%3] << endl;
            cout << "result = " << setbase(16) << frameOut[x%3] << endl;
            exit(0);
        }
    }
    printf("\tTest passed!\n");

    fclose(fp_r1);
    fclose(fp_g1);
    fclose(fp_w1);
/*
    topParam.frameWidth = 1920;
    topParam.frameHeight = 1080;

    //In
    FILE *fp_r2 = fopen(GTM_SRC2, "r");
    if(!fp_r2){
        printf("Can not open input file!\n");
    }

    for (x = 0; x < topParam.frameWidth*topParam.frameHeight; x++) {
        fread(&frameIn[x], sizeof(uint16_t), 1, fp_r2);
        red = (uint14)frameIn[x];
        fread(&frameIn[x], sizeof(uint16_t), 1, fp_r2);
        green = (uint14)frameIn[x];
        fread(&frameIn[x], sizeof(uint16_t), 1, fp_r2);
        blue = (uint14)frameIn[x];
        srcdata(41,28) = red;
        srcdata(27,14) = green;
        srcdata(13,0) = blue;
        src.write(srcdata);
    }
    printf("\tInit done!\n");

    //Golden
    FILE *fp_g2 = fopen(GTM_GOLDEN2, "r");
    if(!fp_g2){
        printf("Can not open golden file!\n");
    }

    for (x = 0; x < 3*topParam.frameWidth*topParam.frameHeight; x++) {
        fread(&frameGolden[x], sizeof(uint16_t), 1, fp_g2);
    }
    printf("\tEnvironment set up!\n");

    //Execution
    gtm(topParam, gtm_param, src, dst);
    printf("\tExecution completed!\n");
    printf("\t%d\n",dst.size());

    //Out
    FILE *fp_w2 = fopen(GTM_DST2, "w");
    if(!fp_w2){
        printf("\tCan not open write back file!\n");
    }

    for (x = 0; x < topParam.frameWidth*topParam.frameHeight; x++) {
        dstdata = dst.read();
        red_o = dstdata >> 28;
        green_o = (dstdata >> 14) & 0x3fff;
        blue_o = dstdata & 0x3fff;
        frameOut[3*x] = red_o;
        frameOut[3*x+1] = green_o;
        frameOut[3*x+2] = blue_o;
    }

    fwrite(frameOut, sizeof(uint16_t), (topParam.frameWidth * topParam.frameHeight), fp_w2);

    //Checker
    for (x = 0; x < topParam.frameWidth*topParam.frameHeight; x++) {
        if(frameGolden[x] != frameOut[x]) {
            printf("\t\tFirst mismatch in pixel %d, channel %d!\n", x/3, x%3);
            cout << "Golden = " << setbase(16) << frameGolden[x] << endl;
            cout << "result = " << setbase(16) << frameOut[x] << endl;
            exit(0);
        }
    }
    printf("\tTest passed!\n");

    fclose(fp_r2);
    fclose(fp_g2);
    fclose(fp_w2);
*/
    return 0;
}
