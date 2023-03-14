#include "sde.h"
#include "../src/file_define_catapult.h"
#include <ac_int.h>
#include <mc_scverify.h>


CCS_MAIN(int argc, char** argv)
{
    top_register topParam;
    sde_register sdeParam;
    ac_channel<uint10> src_y;
    ac_channel<uint10> src_u;
    ac_channel<uint10> src_v;
    ac_channel<uint10> dst_y;
    ac_channel<uint10> dst_u;
    ac_channel<uint10> dst_v;
    int x;
    uint10 y_t;
    uint10 u_t;
    uint10 v_t;
    uint10 srcdata_y;
    uint10 srcdata_u;
    uint10 srcdata_v;
    uint10 dstdata_y;
    uint10 dstdata_u;
    uint10 dstdata_v;

    printf("\tTest for ISP SDE module!\n");
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
                    printf("frame_width = %d\n", topParam.frameWidth.to_int());
                    continue;
                }

                if(strstr(key, "frame_height"))
                {
                    topParam.frameHeight = atoi(value);
                    printf("frame_height = %d\n", topParam.frameHeight.to_int());
                    continue;
                }

                if(strstr(key, "image_pattern"))
                {
                    topParam.imgPattern = atoi(value);
                    printf("image_pattern = %d\n", topParam.imgPattern.to_int());
                    continue;
                }

                if(strstr(key, "blc"))
                {
                    topParam.blc = atoi(value);
                    printf("blc = %d\n", topParam.blc.to_int());
                    continue;
                }

                if(strstr(key, "sde_enable"))
                {
                    sdeParam.m_nEb = atoi(value);
                    printf("sde_enable = %d\n", sdeParam.m_nEb.to_int());
                    continue;
                }

                if(strstr(key, "sde_brightness"))
                {
                    sdeParam.brightness = atoi(value);
                    printf("sde_brightness = %d\n", sdeParam.brightness.to_int());
                    continue;
                }

                if(strstr(key, "sde_contrast"))
                {
                    sdeParam.contrast = atoi(value);
                    printf("sde_contrast = %d\n", sdeParam.contrast.to_int());
                    continue;
                }

                if(strstr(key, "sde_saturation"))
                {
                    sdeParam.saturation = atoi(value);
                    printf("sde_saturation = %d\n", sdeParam.saturation.to_int());
                    continue;
                }

                if(strstr(key, "sde_hue"))
                {
                    int hue = atoi(value);
                    int32_t coslut[256] = {256,256,256,255,255,254,253,252,251,250,248,247,245,243,241,239,237,234,231,229,226,223,220,216,213,209,206,202,198,194,190,185,181,177,172,167,162,157,152,147,142,137,132,126,121,115,109,104,98,92,86,80,74,68,62,56,50,44,38,31,25,19,13,6,0,-6,-13,-19,-25,-31,-38,-44,-50,-56,-62,-68,-74,-80,-86,-92,-98,-104,-109,-115,-121,-126,-132,-137,-142,-147,-152,-157,-162,-167,-172,-177,-181,-185,-190,-194,-198,-202,-206,-209,-213,-216,-220,-223,-226,-229,-231,-234,-237,-239,-241,-243,-245,-247,-248,-250,-251,-252,-253,-254,-255,-255,-256,-256,-256,-256,-256,-255,-255,-254,-253,-252,-251,-250,-248,-247,-245,-243,-241,-239,-237,-234,-231,-229,-226,-223,-220,-216,-213,-209,-206,-202,-198,-194,-190,-185,-181,-177,-172,-167,-162,-157,-152,-147,-142,-137,-132,-126,-121,-115,-109,-104,-98,-92,-86,-80,-74,-68,-62,-56,-50,-44,-38,-31,-25,-19,-13,-6,0,6,13,19,25,31,38,44,50,56,62,68,74,80,86,92,98,104,109,115,121,126,132,137,142,147,152,157,162,167,172,177,181,185,190,194,198,202,206,209,213,216,220,223,226,229,231,234,237,239,241,243,245,247,248,250,251,252,253,254,255,255,256,256
};
                    int cos_value = coslut[hue];
                    int sin_value = coslut[(hue <= 64) ? 64 - hue : 320 - hue];
                    sdeParam.coshue = cos_value;
                    sdeParam.sinhue = sin_value;
                    printf("sde_coshue = %d\n", sdeParam.coshue.to_uint());
                    printf("sde_sinhue = %d\n", sdeParam.sinhue.to_uint());
                }

            }
        }
    }

    uint16_t frameIn[3];
    uint16_t frameGolden;
    uint16_t frameOut;


    //In
    FILE* fp_r1 = fopen(SDE_SRC1, "rb");
    if (!fp_r1) {
        printf("Can not open input file!\n");
    }

    for (x = 0; x < 3 * topParam.frameWidth * topParam.frameHeight; x++) {
        if(x < topParam.frameWidth * topParam.frameHeight)
        {
            fread(&frameIn[0], sizeof(uint16_t), 1, fp_r1);
            srcdata_y = (uint10)frameIn[0];
            src_y.write(srcdata_y);
        }
        else if(x < 2 * topParam.frameWidth * topParam.frameHeight)
        {
            fread(&frameIn[1], sizeof(uint16_t), 1, fp_r1);
            srcdata_u = (uint10)frameIn[1];
            src_u.write(srcdata_u);
        }
        else
        {
            fread(&frameIn[2], sizeof(uint16_t), 1, fp_r1);
            srcdata_v = (uint10)frameIn[2];
            src_v.write(srcdata_v);
        }
    }
    printf("\tInit done!\n");

    //Golden
    FILE* fp_g1 = fopen(SDE_GOLDEN1, "rb");
    if (!fp_g1) {
        printf("Can not open golden file!\n");
    }

    printf("\tEnvironment set up!\n");

    //Execution
    CCS_DESIGN(sde) (topParam, sdeParam, src_y, src_u, src_v, dst_y, dst_u, dst_v);

    printf("\tExecution completed!\n");
    printf("\t%d\n", dst_y.size());

    //Out
    FILE* fp_w1 = fopen(SDE_DST1, "wb");
    if (!fp_w1) {
        printf("\tCan not open write back file!\n");
    }

    for (x = 0; x < 3 * topParam.frameWidth * topParam.frameHeight; x++) {
        if(x < topParam.frameWidth * topParam.frameHeight)
        {
            dstdata_y = dst_y.read();
            frameOut = dstdata_y;
            fwrite(&frameOut, sizeof(uint16_t), 1, fp_w1);
        }
        else if(x < 2 * topParam.frameWidth * topParam.frameHeight)
        {
            dstdata_u = dst_u.read();
            frameOut = dstdata_u;
            fwrite(&frameOut, sizeof(uint16_t), 1, fp_w1);
        }
        else
        {
            dstdata_v = dst_v.read();
            frameOut = dstdata_v;
            fwrite(&frameOut, sizeof(uint16_t), 1, fp_w1);
        }

        fread(&frameGolden, sizeof(uint16_t), 1, fp_g1);

        if (frameGolden != frameOut) {
            int size = topParam.frameWidth.to_int() * topParam.frameHeight.to_int();
            printf("\t\tFirst mismatch in pixel %d, channel %d!\n", x % size, x / size);
            printf("Golden = %d\n", frameGolden);
            printf("Result = %d\n", frameOut);
            exit(0);
        }
    }
    printf("\tTest passed!\n");

    printf("\tTest1 complete!\n");
    fclose(fp_r1);
    fclose(fp_g1);
    fclose(fp_w1);

    return 0;
}
