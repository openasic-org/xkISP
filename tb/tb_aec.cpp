#include "../src/aec.h"

int main(int argc, char** argv)
{
    top_register topParam;
    aec_register aec_param;
    hls::stream<uint42> src("in");
    hls::stream<uint42> dst("out");
    int x;
    uint14 red;
    uint14 green;
    uint14 blue;
    uint14 red_o;
    uint14 green_o;
    uint14 blue_o;
    uint42 srcdata;
    uint42 dstdata;
    printf("\tTest for ISP aec module!\n");


    memset(&topParam, 0, sizeof(top_register));
    memset(&aec_param, 0, sizeof(aec_register));
    topParam.frameWidth = 640;
    topParam.frameHeight = 480;
    topParam.imgPattern = 3;

    aec_param.m_nEb = 1;
    aec_param.weights[0]=128;
    aec_param.weights[1]=128;
    aec_param.weights[2]=128;
    aec_param.weights[3]=128;
    aec_param.weights[4]=128;
    aec_param.weights[5]=128;
    aec_param.weights[6]=128;
    aec_param.weights[7]=128;
    aec_param.weights[8]=128;
    
    uint16 weight_sum=0;
    for(int i=0;i<9;i++){
        weight_sum+=aec_param.weights[i];
    }
    weight_sum=weight_sum/(3*3);
    aec_param.weight_sum=weight_sum;
    aec_param.block_width=(topParam.frameWidth-1)/3+1;
    aec_param.block_height=(topParam.frameHeight-1)/3+1;
    

    uint16_t* frameIn = (uint16_t*)malloc(3 * topParam.frameWidth * topParam.frameHeight * sizeof(uint16_t));
    uint16_t* frameGolden = (uint16_t*)malloc(3 * topParam.frameWidth * topParam.frameHeight * sizeof(uint16_t));
    uint16_t* frameOut = (uint16_t*)malloc(3 * topParam.frameWidth * topParam.frameHeight * sizeof(uint16_t));

    topParam.frameWidth = 640;
    topParam.frameHeight = 480;

    //In
    FILE *fp_r1 = fopen(AEC_SRC1, "r");
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
    FILE *fp_g1 = fopen(AEC_GOLDEN1, "r");
    if(!fp_g1){
        printf("Can not open golden file!\n");
    }

    for (x = 0; x < 3*topParam.frameWidth*topParam.frameHeight; x++) {
        fread(&frameGolden[x], sizeof(uint16_t), 1, fp_g1);
    }
    printf("\tEnvironment set up!\n");

    //Execution
    aec(topParam, aec_param, src, dst);
    printf("\tExecution completed!\n");
    printf("\t%d\n",dst.size());

    //Out
    FILE *fp_w1 = fopen(AEC_DST1, "w");
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

    cout << "AEC statistic: mean y = " << aec_param.mean_y << endl;
  

    fclose(fp_r1);
    fclose(fp_w1);
    fclose(fp_g1);

    return 0;
}

