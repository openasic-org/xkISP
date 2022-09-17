#include "../src/cac.h"

int main(int argc, char** argv)
{
    top_register top_param;
    cac_register cac_param;
    hls::stream<uint42> src;
    hls::stream<uint42> dst;

    int x;
    uint14 red;
    uint14 green;
    uint14 blue;
    uint14 red_o;
    uint14 green_o;
    uint14 blue_o;
    uint42 srcdata;
    uint42 dstdata;

    printf("\tTest for ISP cac module!\n");
    memset(&top_param, 0, sizeof(top_register));
    memset(&cac_param, 0, sizeof(cac_register));
    top_param.frameWidth = 640;
    top_param.frameHeight = 480;
    cac_param.eb = 1;
    cac_param.t_transient = 7000;
    cac_param.t_edge = 4000;

    uint16_t* frameIn = (uint16_t*)malloc(3 * top_param.frameWidth * top_param.frameHeight * sizeof(uint16_t));
    uint16_t* frameGolden = (uint16_t*)malloc(3 * top_param.frameWidth * top_param.frameHeight * sizeof(uint16_t));
    uint16_t* frameOut = (uint16_t*)malloc(3 * top_param.frameWidth * top_param.frameHeight * sizeof(uint16_t));

    //In
    FILE *fp_r1 = fopen(CAC_SRC1, "r");
    if(!fp_r1){
        printf("Can not open input file!\n");
    }

    for (x = 0; x < top_param.frameWidth*top_param.frameHeight; x++) {
    	fread(&frameIn[3 * x], sizeof(uint16_t), 1, fp_r1);
        red = (uint14)frameIn[3 * x];
    	fread(&frameIn[3 * x + 1], sizeof(uint16_t), 1, fp_r1);
        green = (uint14)frameIn[3 * x + 1];
    	fread(&frameIn[3 * x + 2], sizeof(uint16_t), 1, fp_r1);
        blue = (uint14)frameIn[3 * x + 2];
        srcdata(41,28) = red;
        srcdata(27,14) = green;
        srcdata(13,0) = blue;
        src.write(srcdata);
    }
    printf("\tInit done!\n");

    //Golden
    FILE *fp_g1 = fopen(CAC_GOLDEN1, "r");
    if(!fp_g1){
        printf("Can not open golden file!\n");
    }

    for (x = 0; x < 3*top_param.frameWidth*top_param.frameHeight; x++) {
        fread(&frameGolden[x], sizeof(uint16_t), 1, fp_g1);
    }

    printf("\tEnvironment set up!\n");

    //Execution
    cac(top_param, cac_param, src, dst);
    printf("\tExecution completed!\n");
    printf("\t%d\n",dst.size());

    //Out
    FILE *fp_w1 = fopen(CAC_DST1, "w");
    if(!fp_w1){
        printf("\tCan not open write back file!\n");
    }

    for (x = 0; x < top_param.frameWidth*top_param.frameHeight; x++) {
        dstdata = dst.read();
        red_o = dstdata >> 28;
        green_o = dstdata(27, 14);
        blue_o = dstdata(13, 0);
        frameOut[3*x] = red_o;
        frameOut[3*x+1] = green_o;
        frameOut[3*x+2] = blue_o;
    }

    fwrite(frameOut, sizeof(uint16_t), 3*(top_param.frameWidth * top_param.frameHeight), fp_w1);

    //Checker
    for (x = 0; x < 3*top_param.frameWidth*top_param.frameHeight; x++) {
        if(frameGolden[x] != frameOut[x]) {
            printf("\t\tFirst mismatch in pixel %d, channel %d!\n", x/3, x%3);
            printf("\t\tFirst mismatch in pixel %d, row = %d!, col = %d!\n", x/3, (x/3)/top_param.frameWidth.to_int(), ((x/3)%top_param.frameWidth.to_int()));
            cout << "Golden = " << setbase(10) << frameGolden[x] << endl;
            cout << "result = " << setbase(10) << frameOut[x] << endl;
            cout << "in = " << setbase(10) << frameIn[x] << endl;
            exit(0);
        }
    }
    printf("\tTest passed!\n");

    fclose(fp_r1);
    fclose(fp_g1);
    fclose(fp_w1);

    return 0;
}

