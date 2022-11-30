#include "../src/dgain.h"
#include "../src/file_define_catapult.h"
#include <ac_int.h>
#include <mc_scverify.h>

CCS_MAIN(int argc, char** argv)
{
    top_register topParam;
    dgain_register dgain_param;
    ac_channel<uint12> src;
    ac_channel<uint12> dst;
    int x;

    printf("\tTest for ISP dgain module!\n");
    memset(&topParam, 0, sizeof(top_register));
    memset(&dgain_param, 0, sizeof(dgain_register));
    topParam.frameWidth = 640;
    topParam.frameHeight = 480;
    dgain_param.m_nEb = 1;
    int img_size = topParam.frameWidth * topParam.frameHeight;

    uint16_t frameIn[img_size];
    uint16_t frameGolden[img_size];
    uint16_t frameOut[img_size];

    topParam.frameWidth = 640;
    topParam.frameHeight = 480;
    dgain_param.m_nR= 0x04000;
    dgain_param.m_nGr = 0x04000;
    dgain_param.m_nGb = 0x04000;
    dgain_param.m_nB = 0x04000;

    //In
    FILE *fp_r1 = fopen(Dgain_SRC1, "r");
    if(!fp_r1){
        printf("Can not open input file!\n");
    }

    for (x = 0; x < topParam.frameWidth*topParam.frameHeight; x++) {
    	fread(&frameIn[x], sizeof(uint16_t), 1, fp_r1);
        uint12 srcdata = (uint12)frameIn[x];
        src.write(srcdata);
    }
    printf("\tInit done!\n");

    //Golden
    FILE *fp_g1 = fopen(Dgain_GOLDEN1, "r");
    if(!fp_g1){
        printf("Can not open golden file!\n");
    }

    for (x = 0; x < topParam.frameWidth*topParam.frameHeight; x++) {
        fread(&frameGolden[x], sizeof(uint16_t), 1, fp_g1);
    }
    printf("\tEnvironment set up!\n");

    //Execution
    CCS_DESIGN(dgain) (topParam, dgain_param, src, dst);

    printf("\tExecution completed!\n");

    //Out
    FILE *fp_w1 = fopen(Dgain_DST1, "w");
    if(!fp_w1){
        printf("\tCan not open write back file!\n");
    }

    for (x = 0; x < topParam.frameWidth*topParam.frameHeight; x++) {
        uint12 dstdata;
        dstdata = dst.read();
        frameOut[x] = dstdata;
    }

    fwrite(frameOut, sizeof(uint16_t), (topParam.frameWidth * topParam.frameHeight), fp_w1);

    //Checker
    for (x = 0; x < topParam.frameWidth*topParam.frameHeight; x++) {
        if(frameGolden[x] != frameOut[x]) {
            printf("\t\tFirst mismatch in pixel %d!\n", x);
            printf("\t\tGolden = %d, result = %d!\n", frameGolden[x], frameOut[x]);
            exit(0);
        }
    }
    printf("\tTest passed!\n");

    fclose(fp_r1);
    fclose(fp_g1);
    fclose(fp_w1);

    return 0;
}
