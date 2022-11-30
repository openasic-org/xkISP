#include "../src/ltm.h"
#include "../src/file_define_catapult.h"
#include <ac_int.h>
#include <mc_scverify.h>

CCS_MAIN(int argc, char** argv)
{
    top_register topParam;
    ltm_register ltm_param;

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

    printf("\tTest for ISP ltm module!\n");
    memset(&topParam, 0, sizeof(top_register));
    memset(&ltm_param, 0, sizeof(ltm_register));

    topParam.frameWidth = 640;
    topParam.frameHeight = 480;
    ltm_param.m_nEb=1;
    ltm_param.contrast=3401;
    ltm_param.ratio=38;
    int img_size = topParam.frameWidth * topParam.frameHeight;

    uint16_t frameIn[3 * img_size];
    uint16_t frameGolden[3 * img_size];
    uint16_t frameOut[3 * img_size];

    //In
    FILE* fp_r1 = fopen(LTM_SRC1, "rb");
    if (!fp_r1) {
        printf("Can not open input file!\n");
    }

    for (x = 0; x < topParam.frameWidth*topParam.frameHeight; x++) {
        fread(&frameIn[x], sizeof(uint16_t), 1, fp_r1);
        red = (uint14)frameIn[x];
        fread(&frameIn[x], sizeof(uint16_t), 1, fp_r1);
        green = (uint14)frameIn[x];
        fread(&frameIn[x], sizeof(uint16_t), 1, fp_r1);
        blue = (uint14)frameIn[x];
        srcdata = red;
        srcdata = (srcdata << 14) + green;
        srcdata = (srcdata << 14) + blue;
        src.write(srcdata);
    }
    printf("\tsrc stream loaded!\n");
    //Golden
    FILE *fp_g1 = fopen(LTM_GOLDEN1, "r");
    if(!fp_g1){
        printf("Can not open golden file!\n");
    }

    for (x = 0; x < 3*topParam.frameWidth*topParam.frameHeight; x++) {
        fread(&frameGolden[x], sizeof(uint16_t), 1, fp_g1);
    }
    printf("\tEnvironment set up!\n");
    //Execution
    CCS_DESIGN(ltm) (topParam, ltm_param, src, dst);
    printf("\tExecution completed!\n");
    printf("\t%d\n",dst.size());
    //Out
    FILE *fp_w1 = fopen(LTM_DST1, "w");
    if(!fp_w1){
        printf("\tCan not open write back file!\n");
    }
    topParam.frameHeight=480;
    topParam.frameWidth=640;
    for (x = 0; x < topParam.frameWidth*topParam.frameHeight; x++) {
        dstdata = dst.read();
        red_o = dstdata >> 28;
        green_o = (dstdata >> 14) & 0x3fff;
        blue_o = dstdata & 0x3fff;
        frameOut[3*x] = red_o;
        frameOut[3*x+1] = green_o;
        frameOut[3*x+2] = blue_o;
    }

    fwrite(frameOut, sizeof(uint16_t), 3*(topParam.frameWidth * topParam.frameHeight), fp_w1);

    //Checker
    uint32_t error_count=0;
    for (x = 0; x < 3*topParam.frameWidth*topParam.frameHeight; x++) {
        if(frameGolden[x] != frameOut[x]) {
            error_count+=1;
            printf("\t\tFirst mismatch in pixel %d, channel %d! Golden=%d,result=%d\n", x/3, x%3,frameGolden[x],frameOut[x]);
            cout << "Golden = " << setbase(16) << frameGolden[x] << endl;
            cout << "result = " << setbase(16) << frameOut[x] << endl;
            exit(0);
        }
    }
    printf("\tTest passed! Errors:%d\n",error_count);

    fclose(fp_r1);
    fclose(fp_g1);
    fclose(fp_w1);

    CCS_RETURN(0);
}
