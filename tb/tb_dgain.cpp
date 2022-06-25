#include "../src/dgain.h"

int main(int argc, char** argv)
{
    top_register topParam;
    dgain_register dgain_param;
    hls::stream<uint12> src;
    hls::stream<uint12> dst;
    int x;

    printf("\tTest for ISP dgain module!\n");
    memset(&topParam, 0, sizeof(top_register));
    memset(&dgain_param, 0, sizeof(dgain_register));
    topParam.frameWidth = 1920;
    topParam.frameHeight = 1080;
    dgain_param.m_nEb = 1;

    uint16_t* frameIn = (uint16_t*)malloc(topParam.frameWidth * topParam.frameHeight * sizeof(uint16_t));
    uint16_t* frameGolden = (uint16_t*)malloc(topParam.frameWidth * topParam.frameHeight * sizeof(uint16_t));
    uint16_t* frameOut = (uint16_t*)malloc(topParam.frameWidth * topParam.frameHeight * sizeof(uint16_t));

    topParam.frameWidth = 640;
    topParam.frameHeight = 480;
    dgain_param.m_nR= 0x01000;
    dgain_param.m_nGr = 0x01000;
    dgain_param.m_nGb = 0x01000;
    dgain_param.m_nB = 0x01000;

    //In
    FILE *fp_r1 = fopen(Dgain_SRC1, "r");
    if(!fp_r1){
        printf("Can not open input file!\n");
    }

    for (x = 0; x < topParam.frameWidth*topParam.frameHeight; x++) {
    	fread(&frameIn[x], sizeof(uint16_t), 1, fp_r1);
        uint12 srcdata = (uint12)frameIn[x];
        src << srcdata;
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
    dgain(topParam, dgain_param, src, dst);
    printf("\tExecution completed!\n");

    //Out
    FILE *fp_w1 = fopen(Dgain_DST1, "w");
    if(!fp_w1){
        printf("\tCan not open write back file!\n");
    }

    for (x = 0; x < topParam.frameWidth*topParam.frameHeight; x++) {
        uint12 dstdata;
        dst >> dstdata;
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

