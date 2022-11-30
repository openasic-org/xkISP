#include "../src/yfc.h"

int main(int argc, char** argv)
{
    top_register topParam;
    yfc_register yfc_param;
    hls::stream<uint30> src;
    hls::stream<uint10> y_dst;
    hls::stream<uint10> u_dst;
    hls::stream<uint10> v_dst;
    int x;
    uint30 srcdata;
    uint10 y_in_data;
    uint10 u_in_data;
    uint10 v_in_data;
    uint10 y_out_data;
    uint10 u_out_data;
    uint10 v_out_data;

    printf("\tTest for ISP yfc module!\n");
    memset(&topParam, 0, sizeof(top_register));
    memset(&yfc_param, 0, sizeof(yfc_register));
    topParam.frameWidth = 640;
    topParam.frameHeight = 480;

    uint16_t* frameIn = (uint16_t*)malloc(3 * topParam.frameWidth * topParam.frameHeight * sizeof(uint16_t));
    uint16_t* frameGolden_1 = (uint16_t*)malloc(3 * topParam.frameWidth * topParam.frameHeight * sizeof(uint16_t));
    uint16_t* frameOut_1 = (uint16_t*)malloc(3 * topParam.frameWidth * topParam.frameHeight * sizeof(uint16_t));

    uint16_t* frameGolden_2 = (uint16_t*)malloc(2 * topParam.frameWidth * topParam.frameHeight * sizeof(uint16_t));
    uint16_t* frameOut_2 = (uint16_t*)malloc(2 * topParam.frameWidth * topParam.frameHeight * sizeof(uint16_t));

    uint16_t* frameGolden_3 = (uint16_t*)malloc(3 * topParam.frameWidth * topParam.frameHeight * sizeof(uint16_t) / 2);
    uint16_t* frameOut_3 = (uint16_t*)malloc(3 * topParam.frameWidth * topParam.frameHeight * sizeof(uint16_t) / 2);

    //yuv444
    yfc_param.m_nEb = 0;

    //In
    FILE* fp_r1 = fopen(YFC_SRC, "r");
    if (!fp_r1) {
        printf("Can not open input file!\n");
    }

    for (x = 0; x < topParam.frameWidth * topParam.frameHeight; x++) {
        fread(&frameIn[x], sizeof(uint16_t), 1, fp_r1);
        y_in_data = (uint10)frameIn[x];
        fread(&frameIn[x], sizeof(uint16_t), 1, fp_r1);
        u_in_data = (uint10)frameIn[x];
        fread(&frameIn[x], sizeof(uint16_t), 1, fp_r1);
        v_in_data = (uint10)frameIn[x];
        srcdata(29, 20) = y_in_data;
        srcdata(19, 10) = u_in_data;
        srcdata(9, 0) = v_in_data;
        src.write(srcdata);
    }
    printf("\tInit done!\n");

    //Golden
    FILE* fp_g1 = fopen(YFC_GOLDEN1, "r");
    if (!fp_g1) {
        printf("Can not open golden file!\n");
    }

    for (x = 0; x < 3 * topParam.frameWidth * topParam.frameHeight; x++) {
        fread(&frameGolden_1[x], sizeof(uint16_t), 1, fp_g1);
    }
    printf("\tEnvironment set up!\n");

    //Execution
    yfc(topParam, yfc_param, src, y_dst, u_dst, v_dst);
    printf("\tExecution completed!\n");
    printf("\t%d\n", y_dst.size());
    printf("\t%d\n", u_dst.size());
    printf("\t%d\n", v_dst.size());

    //Out
    FILE* fp_w1 = fopen(YFC_DST1, "w");
    if (!fp_w1) {
        printf("\tCan not open write back file!\n");
    }

    for (x = 0; x < 3 * topParam.frameWidth * topParam.frameHeight; x++) {
        if(x < topParam.frameWidth * topParam.frameHeight)
        {
            y_out_data = y_dst.read();
            frameOut_1[x] = y_out_data;
        }
        else if(x < 2 * topParam.frameWidth * topParam.frameHeight)
        {
            u_out_data = u_dst.read();
            frameOut_1[x] = u_out_data;
        }
        else
        {
            v_out_data = v_dst.read();
            frameOut_1[x] = v_out_data;
        }
    }

    fwrite(frameOut_1, sizeof(uint16_t), (3 * topParam.frameWidth * topParam.frameHeight), fp_w1);

    //Checker
    for (x = 0; x < 3 * topParam.frameWidth * topParam.frameHeight; x++) {
        if (frameGolden_1[x] != frameOut_1[x]) {
            printf("\t\tFirst mismatch in pixel %d, channel %d!\n", x / 3, x % 3);
            cout << "Golden = " << setbase(16) << frameGolden_1[x] << endl;
            cout << "result = " << setbase(16) << frameOut_1[x] << endl;
            exit(0);
        }

    }
    printf("\tTest passed!\n");

    fclose(fp_r1);
    fclose(fp_g1);
    fclose(fp_w1);
/*
    //yuv422
    yfc_param.m_nEb = 1;
    yfc_param.yuvpattern = 0;

    //In
    FILE* fp_r2 = fopen(YFC_SRC, "r");
    if (!fp_r2) {
        printf("Can not open input file!\n");
    }

    for (x = 0; x < topParam.frameWidth * topParam.frameHeight; x++) {
        fread(&frameIn[x], sizeof(uint16_t), 1, fp_r2);
        y_in_data = (uint10)frameIn[x];
        fread(&frameIn[x], sizeof(uint16_t), 1, fp_r2);
        u_in_data = (uint10)frameIn[x];
        fread(&frameIn[x], sizeof(uint16_t), 1, fp_r2);
        v_in_data = (uint10)frameIn[x];
        srcdata(29, 20) = y_in_data;
        srcdata(19, 10) = u_in_data;
        srcdata(9, 0) = v_in_data;
        src.write(srcdata);
    }
    printf("\tInit done!\n");

    //Golden
    FILE* fp_g2 = fopen(YFC_GOLDEN2, "r");
    if (!fp_g2) {
        printf("Can not open golden file!\n");
    }

    for (x = 0; x < 2 * topParam.frameWidth * topParam.frameHeight; x++) {
        fread(&frameGolden_2[x], sizeof(uint16_t), 1, fp_g2);
    }
    printf("\tEnvironment set up!\n");

    //Execution
    yfc(topParam, yfc_param, src, y_dst, u_dst, v_dst);
    printf("\tExecution completed!\n");
    printf("\t%d\n", y_dst.size());
    printf("\t%d\n", u_dst.size());
    printf("\t%d\n", v_dst.size());

    //Out
    FILE* fp_w2 = fopen(YFC_DST2, "w");
    if (!fp_w2) {
        printf("\tCan not open write back file!\n");
    }

    for (x = 0; x < 2 * topParam.frameWidth * topParam.frameHeight; x++) {
        if(x < topParam.frameWidth * topParam.frameHeight)
        {
            y_out_data = y_dst.read();
            frameOut_2[x] = y_out_data;
        }
        else if(x < 3 * topParam.frameWidth * topParam.frameHeight / 2)
        {
            u_out_data = u_dst.read();
            frameOut_2[x] = u_out_data;
        }
        else
        {
            v_out_data = v_dst.read();
            frameOut_2[x] = v_out_data;
        }
    }

    fwrite(frameOut_2, sizeof(uint16_t), (2 * topParam.frameWidth * topParam.frameHeight), fp_w2);

    //Checker
    for (x = 0; x < 2 * topParam.frameWidth * topParam.frameHeight; x++) {
        if (frameGolden_2[x] != frameOut_2[x]) {
            printf("\t\tFirst mismatch in pixel %d, channel %d!\n", x , x % 2);
            cout << "Golden = " << setbase(16) << frameGolden_2[x] << endl;
            cout << "result = " << setbase(16) << frameOut_2[x] << endl;
            exit(0);
        }
    }
    printf("\tTest passed!\n");

    fclose(fp_r2);
    fclose(fp_g2);
    fclose(fp_w2);

    //yuv420
    yfc_param.m_nEb = 1;
    yfc_param.yuvpattern = 1;

    FILE* fp_r3= fopen(YFC_SRC, "r");
    if (!fp_r3) {
        printf("Can not open input file!\n");
    }

    for (x = 0; x < topParam.frameWidth * topParam.frameHeight; x++) {
        fread(&frameIn[x], sizeof(uint16_t), 1, fp_r3);
        y_in_data = (uint10)frameIn[x];
        fread(&frameIn[x], sizeof(uint16_t), 1, fp_r3);
        u_in_data = (uint10)frameIn[x];
        fread(&frameIn[x], sizeof(uint16_t), 1, fp_r3);
        v_in_data = (uint10)frameIn[x];
        srcdata(29, 20) = y_in_data;
        srcdata(19, 10) = u_in_data;
        srcdata(9, 0) = v_in_data;
        src.write(srcdata);
    }
    printf("\tInit done!\n");

    //Golden
    FILE *fp_g3 = fopen(YFC_GOLDEN3, "r");
    if(!fp_g3){
        printf("Can not open golden file!\n");
    }

    for (x = 0; x < 3 * topParam.frameWidth * topParam.frameHeight / 2; x++) {
        fread(&frameGolden_3[x], sizeof(uint16_t), 1, fp_g3);
    }
    printf("\tEnvironment set up!\n");

    //Execution
    yfc(topParam, yfc_param, src, y_dst, u_dst, v_dst);
    printf("\tExecution completed!\n");
    printf("\t%d\n",y_dst.size());
    printf("\t%d\n",u_dst.size());
    printf("\t%d\n",v_dst.size());

    //Out
    FILE *fp_w3 = fopen(YFC_DST3, "w");
    if(!fp_w3){
        printf("\tCan not open write back file!\n");
    }

    for (x = 0; x < 3 * topParam.frameWidth * topParam.frameHeight / 2; x++) {
        if(x < topParam.frameWidth * topParam.frameHeight)
        {
            y_out_data = y_dst.read();
            frameOut_3[x] = y_out_data;
        }
        else if(x < 5 * topParam.frameWidth * topParam.frameHeight / 4)
        {
            u_out_data = u_dst.read();
            frameOut_3[x] = u_out_data;
        }
        else
        {
            v_out_data = v_dst.read();
            frameOut_3[x] = v_out_data;
        }
    }

    fwrite(frameOut_3, sizeof(uint16_t), (3 * topParam.frameWidth * topParam.frameHeight / 2), fp_w3);

    //Checker
    for (x = 0; x < 3 * topParam.frameWidth * topParam.frameHeight / 2; x++) {
        if(frameGolden_3[x] != frameOut_3[x]) {
            printf("\t\tFirst mismatch in pixel %d, channel %d!\n", x, x % 2);
            cout << "Golden = " << setbase(16) << frameGolden_3[x] << endl;
            cout << "result = " << setbase(16) << frameOut_3[x] << endl;
            exit(0);
        }
    }
    printf("\tTest passed!\n");

    fclose(fp_r3);
    fclose(fp_g3);
    fclose(fp_w3);
*/
    return 0;
}

