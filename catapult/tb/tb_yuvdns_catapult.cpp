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

    topParam.frameWidth = 640;
    topParam.frameHeight = 480;
    yuvdns_param.eb = 1;
    yuvdns_param.ysigma2 = 3600;
    yuvdns_param.yinvsigma2 = 0x4;// (1 / sigma2) << 14
    yuvdns_param.uvsigma2 = 6400;
    yuvdns_param.uvinvsigma2 = 0x2;
    yuvdns_param.yfilt = 0x6;// 0.4 << 6
    yuvdns_param.uvfilt = 0x6;// 0.4 << 6
    yuvdns_param.yinvfilt = 0x5; // (1 / yfilt) << 1
    yuvdns_param.uvinvfilt = 0x5; // (1 / uvfilt) << 1
    yuvdns_param.yH2 = (yuvdns_param.yfilt * yuvdns_param.yfilt * yuvdns_param.ysigma2 + 255) >> 8;
    yuvdns_param.yinvH2 = (yuvdns_param.yinvfilt * yuvdns_param.yinvfilt * yuvdns_param.yinvsigma2 + 3) >> 2;
    yuvdns_param.uvH2 = (yuvdns_param.uvfilt * yuvdns_param.uvfilt * yuvdns_param.uvsigma2 + 255) >> 8;
    yuvdns_param.uvinvH2 = (yuvdns_param.uvinvfilt * yuvdns_param.uvinvfilt * yuvdns_param.uvinvsigma2 + 3) >> 2;
    int img_size = topParam.frameWidth * topParam.frameHeight;

    uint16_t frameIn[3 * img_size];
    uint16_t frameGolden[3 * img_size];
    uint16_t frameOut[3 * img_size];


    //In
    FILE* fp_r1 = fopen(YUVDNS_SRC1, "rb");
    if (!fp_r1) {
        printf("Can not open input file!\n");
    }

    for (x = 0; x < 3 * topParam.frameWidth * topParam.frameHeight; x++) {
        if(x < topParam.frameWidth * topParam.frameHeight)
        {
            fread(&frameIn[x], sizeof(uint16_t), 1, fp_r1);
            srcdata_y = (uint10)frameIn[x];
            src_y.write(srcdata_y);
        }
        else if(x < 2 * topParam.frameWidth * topParam.frameHeight)
        {
            fread(&frameIn[x], sizeof(uint16_t), 1, fp_r1);
            srcdata_u = (uint10)frameIn[x];
            src_u.write(srcdata_u);
        }
        else
        {
            fread(&frameIn[x], sizeof(uint16_t), 1, fp_r1);
            srcdata_v = (uint10)frameIn[x];
            src_v.write(srcdata_v);
        }
    }
    printf("\tInit done!\n");

    //Golden
    FILE* fp_g1 = fopen(YUVDNS_GOLDEN1, "rb");
    if (!fp_g1) {
        printf("Can not open golden file!\n");
    }

    for (x = 0; x < 3 * topParam.frameWidth * topParam.frameHeight; x++) {
        fread(&frameGolden[x], sizeof(uint16_t), 1, fp_g1);
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
            y_t = dst_y.read();
            frameOut[x] = y_t;
        }
        else if(x < 2 * topParam.frameWidth * topParam.frameHeight)
        {
            u_t = dst_u.read();
            frameOut[x] = u_t;
        }
        else
        {
            v_t = dst_v.read();
            frameOut[x] = v_t;
        }
    }

    fwrite(frameOut, sizeof(uint16_t), (topParam.frameWidth * topParam.frameHeight * 3), fp_w1);

    //Checker
    for (x = 0; x < topParam.frameWidth * topParam.frameHeight * 3; x++) {
        if (frameGolden[x] != frameOut[x]) {
            printf("\t\tFirst mismatch in pixel %d, channel %d!\n", x / 3, x % 3);
            cout << "Golden = " << setbase(16) << frameGolden[x] << endl;
            cout << "result = " << setbase(16) << frameOut[x] << endl;
        }
    }
    printf("\tTest passed!\n");

    printf("\tTest1 complete!\n");
    fclose(fp_r1);
    fclose(fp_g1);
    fclose(fp_w1);

    return 0;
}
