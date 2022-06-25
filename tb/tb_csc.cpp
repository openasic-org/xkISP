#include "../src/csc.h"

int main(int argc, char** argv)
{
    top_register topParam;
    csc_register csc_param;
    hls::stream<uint42> src;
    hls::stream<uint30> dst;
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
    memset(&topParam, 0, sizeof(top_register));
    memset(&csc_param, 0, sizeof(csc_register));
    topParam.frameWidth = 1920;
    topParam.frameHeight = 1080;
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

    uint16_t* frameIn = (uint16_t*)malloc(3 * topParam.frameWidth * topParam.frameHeight * sizeof(uint16_t));
    uint16_t* frameGolden = (uint16_t*)malloc(3 * topParam.frameWidth * topParam.frameHeight * sizeof(uint16_t));
    uint16_t* frameOut = (uint16_t*)malloc(3 * topParam.frameWidth * topParam.frameHeight * sizeof(uint16_t));

    topParam.frameWidth = 640;
    topParam.frameHeight = 480;

    //In
    FILE *fp_r1 = fopen(CSC_SRC1, "r");
    if(!fp_r1){
        printf("Can not open input file!\n");
    }

    for (x = 0; x < topParam.frameWidth*topParam.frameHeight; x++) {
    	fread(&frameIn[x], sizeof(uint16_t), 1, fp_r1);
        red = (uint14)frameIn[x];
    	fread(&frameIn[x], sizeof(uint16_t), 1, fp_r1);
        green = (uint14)frameIn[x];
    	fread(&frameIn[x], sizeof(uint16_t), 1, fp_r1);
        blue = (uint14)frameIn[x];
        srcdata(41,28) = red;
        srcdata(27,14) = green;
        srcdata(13,0) = blue;
        src.write(srcdata);
    }
    printf("\tInit done!\n");

    //Golden
    FILE *fp_g1 = fopen(CSC_GOLDEN1, "r");
    if(!fp_g1){
        printf("Can not open golden file!\n");
    }

    for (x = 0; x < 3*topParam.frameWidth*topParam.frameHeight; x++) {
        fread(&frameGolden[x], sizeof(uint16_t), 1, fp_g1);
    }
    printf("\tEnvironment set up!\n");

    //Execution
    csc(topParam, csc_param, src, dst);
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
        frameOut[3*x] = y_o;
        frameOut[3*x+1] = u_o;
        frameOut[3*x+2] = v_o;
    }

    fwrite(frameOut, sizeof(uint16_t), (topParam.frameWidth * topParam.frameHeight), fp_w1);

    //Checker
    for (x = 0; x < topParam.frameWidth*topParam.frameHeight; x++) {
        if(frameGolden[x] != frameOut[x]) {
            printf("\t\tFirst mismatch in pixel %d, channel %d!\n", x/3, x%3);
            cout << "Golden = " << setbase(16) << frameGolden[x] << endl;
            cout << "result = " << setbase(16) << frameOut[x] << endl;
            exit(0);
        }
    }
    printf("\tTest passed!\n");

    fclose(fp_r1);
    fclose(fp_g1);
    fclose(fp_w1);

    return 0;
}

