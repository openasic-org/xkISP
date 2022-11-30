#include "../src/ee.h"
#include "../src/file_define_catapult.h"
#include <ac_int.h>
#include <mc_scverify.h>

CCS_MAIN(int argc, char** argv)
{
    top_register topParam;
    ee_register ee_param;
    ac_channel<uint36> src;
    ac_channel<uint36> dst;
    int x;
    ee_pixel_t pix;

    printf("\tTest for ISP edge_enhancement module!\n");

    topParam.frameWidth = 640;
    topParam.frameHeight = 480;

    ee_param.eb = 1;
    ee_param.coeff = 30;
    int img_size = topParam.frameWidth * topParam.frameHeight;

    uint16_t frameIn[img_size];
    uint16_t frameGolden[img_size];
    uint16_t frameOut[img_size];

    //In
    FILE *fp_r1 = fopen(EE_SRC, "r");
    if(!fp_r1){
        printf("Can not open input file!\n");
    }

    for (x = 0; x < topParam.frameWidth*topParam.frameHeight; x++) {
        fread(&frameIn[x], sizeof(uint64_t), 1, fp_r1);
        uint64_t srcdata = frameIn[x];
        uint36 in;

        pix.r = (uint12)(srcdata);
        pix.g = (uint12)((srcdata>>16)&0xfff);
        pix.b = (uint12) ((srcdata>>32)&0xfff);

        in = ((uint36) pix.r << 24)|((uint36) pix.g << 12)|((uint36) pix.b);
        src.write(in);
    }
    printf("\tInit done!\n");

    //Golden
    FILE *fp_g1 = fopen(EE_GOLDEN, "r");
    if(!fp_g1){
        printf("Can not open golden file!\n");
    }

    for (x = 0; x < topParam.frameWidth*topParam.frameHeight; x++) {
        fread(&frameGolden[x], sizeof(uint64_t), 1, fp_g1);
    }
    printf("\tEnvironment set up!\n");


    //Execution
    CCS_DESIGN(edgeenhancement) (topParam, ee_param, src, dst);

    printf("\tExecution completed!\n");

    //Out
    FILE *fp_w1 = fopen(EE_DST, "w");
    if(!fp_w1){
        printf("\tCan not open write back file!\n");
    }

    for (x = 0; x < topParam.frameWidth*topParam.frameHeight; x++) {
        uint64_t dstdata = 0;
        uint36 out;
        out = dst.read();

        pix.r = out >> 24;
        pix.g = uint12(out >> 12);
        pix.b = uint12(out);

        dstdata = ((uint64_t)(pix.r)) |((uint64_t)(pix.g) << 16) | ((uint64_t)(pix.b) << 32);
        frameOut[x] = dstdata;
    }

    fwrite(frameOut, sizeof(uint64_t), (topParam.frameWidth * topParam.frameHeight), fp_w1);

    //Checker
    for (x = 0; x < topParam.frameWidth*topParam.frameHeight; x++) {
        if(frameGolden[x] != frameOut[x]) {
            printf("\t\tFirst mismatch in pixel %d!\n", x);
            printf("\t\tGolden_r = %d, result_r = %d!\n",(uint16_t)(frameGolden[x]), (uint16_t)(frameOut[x]));
            printf("\t\tGolden_g = %d, result_g = %d!\n",(uint16_t)(frameGolden[x]>>16), (uint16_t)(frameOut[x]>>16));
            printf("\t\tGolden_b = %d, result_b = %d!\n",(uint16_t)(frameGolden[x]>>32), (uint16_t)(frameOut[x]>>32));
            exit(0);
        }
    }

    printf("\tTest passed!\n");

    fclose(fp_r1);
    fclose(fp_g1);
    fclose(fp_w1);
    return 0;
}
