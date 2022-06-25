#include "../src/cmc.h"

int main(int argc, char** argv)
{
    top_register topParam;
    cmc_register cmc_param;
    hls::stream<uint36> src;
    hls::stream<uint42> dst;
    int x;
    uint12 red;
    uint12 green;
    uint12 blue;
    uint14 red_o;
    uint14 green_o;
    uint14 blue_o;
    uint36 srcdata;
    uint42 dstdata;

    printf("\tTest for ISP cmc module!\n");
    memset(&topParam, 0, sizeof(top_register));
    memset(&cmc_param, 0, sizeof(cmc_register));
    topParam.frameWidth = 1920;
    topParam.frameHeight = 1080;
    cmc_param.m_nEb = 1;
    cmc_param.m_bDiscardH = 0;
    cmc_param.m_nGain[0] = 6709;
    cmc_param.m_nGain[1] = -2591;
    cmc_param.m_nGain[2] = -22;
    cmc_param.m_nGain[3] = 0;
    cmc_param.m_nGain[4] = -632;
    cmc_param.m_nGain[5] = 5336;
    cmc_param.m_nGain[6] = -607;
    cmc_param.m_nGain[7] = 0;
    cmc_param.m_nGain[8] = 156;
    cmc_param.m_nGain[9] = -2970;
    cmc_param.m_nGain[10] = 6912;
    cmc_param.m_nGain[11] = 0;

    uint16_t* frameIn = (uint16_t*)malloc(4 * topParam.frameWidth * topParam.frameHeight * sizeof(uint16_t));
    uint16_t* frameGolden = (uint16_t*)malloc(3 * topParam.frameWidth * topParam.frameHeight * sizeof(uint16_t));
    uint16_t* frameOut = (uint16_t*)malloc(3 * topParam.frameWidth * topParam.frameHeight * sizeof(uint16_t));

    topParam.frameWidth = 640;
    topParam.frameHeight = 480;

    //In
    FILE *fp_r1 = fopen(CMC_SRC1, "r");
    if(!fp_r1){
        printf("Can not open input file!\n");
    }

    for (x = 0; x < topParam.frameWidth*topParam.frameHeight; x++) {
        fread(&frameIn[x], sizeof(uint16_t), 1, fp_r1);
        red = (uint12)frameIn[x];
        fread(&frameIn[x], sizeof(uint16_t), 1, fp_r1);
        green = (uint12)frameIn[x];
        fread(&frameIn[x], sizeof(uint16_t), 1, fp_r1);
        blue = (uint12)frameIn[x];
        fread(&frameIn[x], sizeof(uint16_t), 1, fp_r1);
        srcdata(35,24) = red;
        srcdata(23,12) = green;
        srcdata(11,0) = blue;
        src.write(srcdata);
    }
    printf("\tInit done!\n");

    //Golden
    FILE *fp_g1 = fopen(CMC_GOLDEN1, "r");
    if(!fp_g1){
        printf("Can not open golden file!\n");
    }

    for (x = 0; x < 3*topParam.frameWidth*topParam.frameHeight; x++) {
        fread(&frameGolden[x], sizeof(uint16_t), 1, fp_g1);
    }
    printf("\tEnvironment set up!\n");

    //Execution
    cmc(topParam, cmc_param, src, dst);
    printf("\tExecution completed!\n");
    printf("\t%d\n",dst.size());

    //Out
    FILE *fp_w1 = fopen(CMC_DST1, "w");
    if(!fp_w1){
        printf("\tCan not open write back file!\n");
    }

    for (x = 0; x < topParam.frameWidth*topParam.frameHeight; x++) {
        dstdata = dst.read();
        red_o = dstdata >> 28;
        green_o = (dstdata >> 14) & 0x3fff;
        blue_o = dstdata & 0x3fff;
        frameOut[3*x] = red_o;
        frameOut[3*x+1] = green_o;
        frameOut[3*x+2] = blue_o;
    }

    fwrite(frameOut, sizeof(uint16_t), (3*topParam.frameWidth * topParam.frameHeight), fp_w1);

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

