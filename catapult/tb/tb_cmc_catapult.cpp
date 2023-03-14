#include "../src/cmc.h"
#include "../src/file_define_catapult.h"
#include <ac_int.h>
#include <mc_scverify.h>

CCS_MAIN(int argc, char** argv)
{
    top_register topParam;
    cmc_register cmc_param;
    ac_channel<uint36> src;
    ac_channel<uint42> dst;
    int x;
    uint12 red;
    uint12 green;
    uint12 blue;
    uint14 red_o;
    uint14 green_o;
    uint14 blue_o;
    uint36 srcdata;
    uint42 dstdata;

    printf("\tTest for ISP cmc module!\n");
    memset(&topParam, 0, sizeof(top_register));
    memset(&cmc_param, 0, sizeof(cmc_register));
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

                if(strstr(key, "cmc_enable"))
                {
                    cmc_param.m_nEb = atoi(value);
                    printf("cmc_enable = %d\n", cmc_param.m_nEb);
                    continue;
                }
            }
        }
    }

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

    uint16_t frameIn[4];
    uint16_t frameGolden[3];
    uint16_t frameOut[3];

    //In
    FILE *fp_r1 = fopen(CMC_SRC1, "r");
    if(!fp_r1){
        printf("Can not open input file!\n");
    }

    for (x = 0; x < topParam.frameWidth*topParam.frameHeight; x++) {
        fread(&frameIn[0], sizeof(uint16_t), 1, fp_r1);
        red = (uint12)frameIn[0];
        fread(&frameIn[1], sizeof(uint16_t), 1, fp_r1);
        green = (uint12)frameIn[1];
        fread(&frameIn[2], sizeof(uint16_t), 1, fp_r1);
        blue = (uint12)frameIn[2];
        fread(&frameIn[3], sizeof(uint16_t), 1, fp_r1);
        srcdata = red;
        srcdata = (srcdata << 12) + green;
        srcdata = (srcdata << 12) + blue;
        src.write(srcdata);
    }
    printf("\tInit done!\n");

    //Golden
    FILE *fp_g1 = fopen(CMC_GOLDEN1, "r");
    if(!fp_g1){
        printf("Can not open golden file!\n");
    }

    printf("\tEnvironment set up!\n");

    //Execution
    CCS_DESIGN(cmc) (topParam, cmc_param, src, dst);

    printf("\tExecution completed!\n");
    printf("\t%d\n",dst.size());

    //Out
    FILE *fp_w1 = fopen(CMC_DST1, "w");
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

    return 0;
}
