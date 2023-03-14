#include "../src/ee.h"
#include "../src/file_define_catapult.h"
#include <ac_int.h>
#include <mc_scverify.h>

CCS_MAIN(int argc, char** argv)
{
    top_register topParam;
    ee_register ee_param;
    ac_channel<uint36> src;
    ac_channel<uint36> dst;
    int x;
    ee_pixel_t pix;

    printf("\tTest for ISP edge_enhancement module!\n");

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
            }
        }
    }

    uint16_t frameIn;
    uint16_t frameGolden;
    uint16_t frameOut;

    //In
    FILE *fp_r1 = fopen(EE_SRC, "r");
    if(!fp_r1){
        printf("Can not open input file!\n");
    }

    for (x = 0; x < topParam.frameWidth*topParam.frameHeight; x++) {
        fread(&frameIn, sizeof(uint64_t), 1, fp_r1);
        uint64_t srcdata = frameIn;
        uint36 in;

        pix.r = (uint12)(srcdata);
        pix.g = (uint12)((srcdata>>16)&0xfff);
        pix.b = (uint12) ((srcdata>>32)&0xfff);

        in = ((uint36) pix.r << 24)|((uint36) pix.g << 12)|((uint36) pix.b);
        src.write(in);
    }
    printf("\tInit done!\n");

    //Golden
    FILE *fp_g1 = fopen(EE_GOLDEN, "r");
    if(!fp_g1){
        printf("Can not open golden file!\n");
    }

    printf("\tEnvironment set up!\n");


    //Execution
    CCS_DESIGN(edgeenhancement) (topParam, ee_param, src, dst);

    printf("\tExecution completed!\n");

    //Out
    FILE *fp_w1 = fopen(EE_DST, "w");
    if(!fp_w1){
        printf("\tCan not open write back file!\n");
    }

    for (x = 0; x < topParam.frameWidth*topParam.frameHeight; x++) {
        uint64_t dstdata = 0;
        uint36 out;
        out = dst.read();

        pix.r = out >> 24;
        pix.g = uint12(out >> 12);
        pix.b = uint12(out);

        dstdata = ((uint64_t)(pix.r)) |((uint64_t)(pix.g) << 16) | ((uint64_t)(pix.b) << 32);
        frameOut = dstdata;
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
