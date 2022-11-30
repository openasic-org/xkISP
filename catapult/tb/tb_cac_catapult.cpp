#include "../src/cac.h"
#include "../src/file_define_catapult.h"
#include <ac_int.h>
#include <mc_scverify.h>

CCS_MAIN(int argc, char** argv)
{
    top_register top_param;
    cac_register cac_param;
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

    printf("\tTest for ISP cac module!\n");
    memset(&top_param, 0, sizeof(top_register));
    memset(&cac_param, 0, sizeof(cac_register));
    top_param.frameWidth = 640;
    top_param.frameHeight = 480;
    cac_param.eb = 1;
    cac_param.t_transient = 7000;
    cac_param.t_edge = 4000;
    int img_size = top_param.frameWidth * top_param.frameHeight;

    uint16_t frameIn[3 * img_size];
    uint16_t frameGolden[3 * img_size];
    uint16_t frameOut[3 * img_size];

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
        srcdata = red;
        srcdata = (srcdata << 14) + green;
        srcdata = (srcdata << 14) + blue;
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
    CCS_DESIGN(cac) (top_param, cac_param, src, dst);

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
        green_o = uint14(dstdata >> 14);
        blue_o = uint14(dstdata);
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
