#include "../src/dpc.h"

int main(int argc, char** argv)
{
    top_register top_param;
    dpc_register dpc_param;
    hls::stream<uint12> src;
    hls::stream<uint12> dst;
    int x;

    printf("\tTest for ISP dpc module!\n");
    memset(&top_param, 0, sizeof(top_register));
    memset(&dpc_param, 0, sizeof(dpc_register));
    top_param.frameWidth = 640;
    top_param.frameHeight = 480;
    top_param.imgPattern = 3;

    dpc_param.eb = 1;
    dpc_param.th_w = 300;
    dpc_param.th_b = 300;

    uint16_t* frameIn = (uint16_t*)malloc(top_param.frameWidth * top_param.frameHeight * sizeof(uint16_t));
    uint16_t* frameGolden = (uint16_t*)malloc(top_param.frameWidth * top_param.frameHeight * sizeof(uint16_t));
    uint16_t* frameOut = (uint16_t*)malloc(top_param.frameWidth * top_param.frameHeight * sizeof(uint16_t));

    //In
    FILE *fp_r1 = fopen(DPC_SRC1, "r");
    if(!fp_r1){
        printf("Can not input file!\n");
    }

    for (x = 0; x < top_param.frameWidth*top_param.frameHeight; x++) {
        fread(&frameIn[x], sizeof(uint16_t), 1, fp_r1);
        uint12 srcdata = (uint12)frameIn[x];
        src << srcdata;
    }
    printf("\tInit done!\n");

    //Golden
    FILE *fp_g1 = fopen(DPC_GOLDEN1, "r");
    if(!fp_g1){
        printf("Can not open golden file!\n");
    }

    for (x = 0; x < top_param.frameWidth*top_param.frameHeight; x++) {
        fread(&frameGolden[x], sizeof(uint16_t), 1, fp_g1);
    }
    printf("\tEnvironment set up!\n");

    //Execution
    dpc(top_param, dpc_param, src, dst);
    printf("\tExecution completed!\n");

    //Out
    FILE *fp_w1 = fopen(DPC_DST1, "w");
    if(!fp_w1){
        printf("\tCan not open write back file!\n");
    }

    for (x = 0; x < top_param.frameWidth*top_param.frameHeight; x++) {
        uint12 dstdata;
        dst >> dstdata;
        frameOut[x] = dstdata;
    }

    fwrite(frameOut, sizeof(uint16_t), (top_param.frameWidth * top_param.frameHeight), fp_w1);

    //Checker
    for (x = 0; x < top_param.frameWidth*top_param.frameHeight; x++) {
        int tmp = frameGolden[x] - frameOut[x];
        if(tmp != 0) {
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
