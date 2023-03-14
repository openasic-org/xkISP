#include "../src/csc.h"
#include "../src/file_define_catapult.h"
#include <ac_int.h>
#include <mc_scverify.h>

CCS_MAIN(int argc, char** argv)
{
    top_register topParam;
    csc_register csc_param;
    ac_channel<uint42> src;
    ac_channel<uint30> dst;
    int x;
    uint14 red;
    uint14 green;
    uint14 blue;
    uint10 y_o;
    uint10 u_o;
    uint10 v_o;
    uint42 srcdata;
    uint30 dstdata;

    printf("\tTest for ISP csc module!\n");
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

    uint16_t frameIn[3];
    uint16_t frameGolden[3];
    uint16_t frameOut[3];

    //In
    FILE *fp_r1 = fopen(CSC_SRC1, "r");
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
    FILE *fp_g1 = fopen(CSC_GOLDEN1, "r");
    if(!fp_g1){
        printf("Can not open golden file!\n");
    }

    printf("\tEnvironment set up!\n");

    //Execution
    CCS_DESIGN(csc) (topParam, csc_param, src, dst);

    printf("\tExecution completed!\n");
    printf("\t%d\n",dst.size());

    //Out
    FILE *fp_w1 = fopen(CSC_DST1, "w");
    if(!fp_w1){
        printf("\tCan not open write back file!\n");
    }

    for (x = 0; x < topParam.frameWidth*topParam.frameHeight; x++) {
        dstdata = dst.read();
        y_o = dstdata >> 20;
        u_o = (dstdata >> 10) & 0x3ff;
        v_o = dstdata & 0x3ff;
        frameOut[0] = y_o;
        frameOut[1] = u_o;
        frameOut[2] = v_o;
        fwrite(&frameOut[0], sizeof(uint16_t), 1, fp_w1);
        fwrite(&frameOut[1], sizeof(uint16_t), 1, fp_w1);
        fwrite(&frameOut[2], sizeof(uint16_t), 1, fp_w1);
        fread(&frameGolden[0], sizeof(uint16_t), 1, fp_g1);
        fread(&frameGolden[1], sizeof(uint16_t), 1, fp_g1);
        fread(&frameGolden[2], sizeof(uint16_t), 1, fp_g1);
        for (int i = 0; i < 3; i++) {
            if(frameGolden[i] != frameOut[i]) {
                printf("\t\tFirst mismatch in pixel %d, channel %d!\n", x, i);
                cout << "Golden = " << setbase(16) << frameGolden[i] << endl;
                cout << "result = " << setbase(16) << frameOut[i] << endl;
                exit(0);
            }
        }
    }

    printf("\tTest passed!\n");

    fclose(fp_r1);
    fclose(fp_g1);
    fclose(fp_w1);

    return 0;
}
