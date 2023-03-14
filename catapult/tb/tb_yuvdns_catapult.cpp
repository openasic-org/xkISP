#include "../src/yuvdns.h"
#include "../src/file_define_catapult.h"
#include <ac_int.h>
#include <mc_scverify.h>


CCS_MAIN(int argc, char** argv)
{
    top_register topParam;
    yuvdns_register yuvdns_param;
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

    printf("\tTest for ISP yuv444DNS module!\n");
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
            }
        }
    }

    uint16_t frameIn[3];
    uint16_t frameGolden;
    uint16_t frameOut;


    //In
    FILE* fp_r1 = fopen(YUVDNS_SRC1, "rb");
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
    FILE* fp_g1 = fopen(YUVDNS_GOLDEN1, "rb");
    if (!fp_g1) {
        printf("Can not open golden file!\n");
    }

    printf("\tEnvironment set up!\n");

    //Execution
    CCS_DESIGN(yuv444dns) (topParam, yuvdns_param, src_y, src_u, src_v, dst_y, dst_u, dst_v);

    printf("\tExecution completed!\n");
    printf("\t%d\n", dst_y.size());

    //Out
    FILE* fp_w1 = fopen(YUVDNS_DST1, "wb");
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
            printf("\t\tFirst mismatch in pixel %d, channel %d!\n", x / 3, x % 3);
            cout << "Golden = " << setbase(16) << frameGolden << endl;
            cout << "result = " << setbase(16) << frameOut << endl;
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
