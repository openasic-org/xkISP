#include "../src/tpg.h"

int main(int argc, char** argv)
{
    top_register topParam;
    tpg_register tpg_param;
    hls::stream<uint12> src;
    hls::stream<uint12> dst;
    int x;

    printf("\tTest for ISP tpg module!\n");
    memset(&topParam, 0, sizeof(top_register));
    memset(&tpg_param, 0, sizeof(tpg_register));

    topParam.frameWidth = 640;
    topParam.frameHeight = 480;
    topParam.imgPattern = 3;

    uint16_t* frameIn = (uint16_t*)malloc(topParam.frameWidth * topParam.frameHeight * sizeof(uint16_t));
    uint16_t* frameGolden = (uint16_t*)malloc(topParam.frameWidth * topParam.frameHeight * sizeof(uint16_t));
    uint16_t* frameOut = (uint16_t*)malloc(topParam.frameWidth * topParam.frameHeight * sizeof(uint16_t));

    //In
    FILE *fp_r1 = fopen(TPG_SRC1, "r");
    if(!fp_r1){
        printf("Can not open golden file!\n");
    }

    for (x = 0; x < topParam.frameWidth*topParam.frameHeight; x++) {
        fread(&frameGolden[x], sizeof(uint16_t), 1, fp_r1);
        uint12 srcdata = (uint12)frameGolden[x];
        src << srcdata;
    }
    printf("\tInit done!\n");

    //Golden
    FILE *fp_g1 = fopen(TPG_GOLDEN1, "r");
    printf("\tEnvironment set up!\n");

    //Execution
    tpg(topParam, tpg_param, src, dst);
    printf("\tExecution completed!\n");

    //Out
    FILE *fp_w1 = fopen(TPG_DST1, "w");
    if(!fp_w1){
        printf("\t Can not open write back file!\n");
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
            printf("\t\tFirst mismatch in pixel %d!", x);
            printf("\t\tGolden = %d, result = %d!", frameGolden[x], frameOut[x]);
            exit(0);
        }
    }
    printf("\tTest passed!\n");

    fclose(fp_r1);
    fclose(fp_g1);
    fclose(fp_w1);

    return 0;
}

