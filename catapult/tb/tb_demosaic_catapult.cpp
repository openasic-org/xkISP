#include "../src/demosaic.h"
#include "../src/file_define_catapult.h"
#include <ac_int.h>
#include <mc_scverify.h>

CCS_MAIN(int argc, char** argv)
{
    top_register topParam;
    demosaic_register demosaic_param;
    ac_channel<uint12> src;
    ac_channel<uint36> dst;
    int x;
    uint64_t red;
    uint64_t green;
    uint64_t blue;

    printf("\tTest for ISP demosaic module!\n");
    memset(&topParam, 0, sizeof(top_register));
    memset(&demosaic_param, 0, sizeof(demosaic_register));
    const char* config_file = "../config/xkISP_HLS.cfg";

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
            }
        }
    }
    demosaic_param.eb = 1;

    uint16_t frameIn;
    uint64_t frameGolden;
    uint64_t frameOut;

    //In
    FILE *fp_r1 = fopen(DEMOSAIC_SRC1, "r");
    if(!fp_r1){
        printf("Can not open input file!\n");
    }

    for (x = 0; x < topParam.frameWidth*topParam.frameHeight; x++) {
        fread(&frameIn, sizeof(uint16_t), 1, fp_r1);
        uint12 srcdata = (uint12)frameIn;
        src.write(srcdata);
    }
    printf("\tInit done!\n");

    //Golden
    FILE *fp_g1 = fopen(DEMOSAIC_GOLDEN1, "r");
    if(!fp_g1){
        printf("Can not open golden file!\n");
    }

    printf("\tEnvironment set up!\n");

    //Execution
    CCS_DESIGN(demosaic) (topParam, demosaic_param, src, dst);
    printf("\tExecution completed!\n");
    printf("\t%d\n",dst.size());

    //Out
    FILE *fp_w1 = fopen(DEMOSAIC_DST1, "w");
    if(!fp_w1){
        printf("\tCan not open write back file!\n");
    }

    for (x = 0; x < topParam.frameWidth*topParam.frameHeight; x++) {
        uint36 dstdata;
        dstdata = dst.read();
        red = dstdata >> 24;
        green = (dstdata >> 12) & 0xfff;
        blue = dstdata & 0xfff;
        uint64_t temp;
        temp = red | (green << 16) | (blue << 32);

        frameOut = temp;
        fwrite(&frameOut, sizeof(uint64_t), 1, fp_w1);
        fread(&frameGolden, sizeof(uint64_t), 1, fp_g1);
        if(frameGolden != frameOut) {
            printf("\t\tFirst mismatch in pixel %d!\n", x);
            printf("\t\tGolden_r = %d, result_r = %d!\n",(uint16_t)(frameGolden), (uint16_t)(frameOut));
            printf("\t\tGolden_g = %d, result_g = %d!\n",(uint16_t)(frameGolden>>16), (uint16_t)(frameOut>>16));
            printf("\t\tGolden_b = %d, result_b = %d!\n",(uint16_t)(frameGolden>>32), (uint16_t)(frameOut>>32));
            exit(0);
        }
        frameOut = 0;
        frameGolden = 0;
    }

    printf("\tTest passed!\n");

    fclose(fp_r1);
    fclose(fp_g1);
    fclose(fp_w1);

    return 0;
}

