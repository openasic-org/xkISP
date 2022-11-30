#include "../src/lut.h"

int main(int argc, char** argv)
{
    top_register top_param;
    lut_register lut_param;
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

    printf("\tTest for ISP lut module!\n");
    memset(&top_param, 0, sizeof(top_register));
    memset(&lut_param, 0, sizeof(lut_register));
    top_param.frameWidth = 640;
    top_param.frameHeight = 480;
    lut_param.eb = 1;
    lut_param.size = 32;
    lut_param.lines = lut_param.size * lut_param.size * lut_param.size;

//loading file
    const char* lut_file;
    char *p, *q, *r, *s;
    char line[300];
    char line2[300];
    char line3[300];
    char value1[100], value2[100], value3[100];
    int i = 0;
    int k = 0;
    int DataStart = 1;
    int axis_r, axis_g, axis_b;
    int odd_r, odd_g, odd_b;
    FILE* fp_lut;
    if(lut_param.size == 17) {
        fp_lut = fopen((const char*)LUT_CUBE_17, "r");
    }
    else if(lut_param.size == 32) {
        fp_lut = fopen((const char*)LUT_CUBE, "r");
    }
    else {
        fp_lut = fopen((const char*)LUT_CUBE, "r");
    }

    if(fp_lut == NULL)
    {
        printf("\t Warning: no lut file!\n");
    }
    else{
        while(fgets(line, 300, fp_lut)){
            p = strchr(line, ' ');
            if (p != NULL)
            {
                strncpy(value1, line, p - line);
                strcpy(line2, p + 1);
                q = strchr(line2, ' ');
                if (q != NULL)
                {
                    strncpy(value2, line2, q - line2);
                    strcpy(value3, q + 1);
                }
            }

            axis_r = i % lut_param.size;
            axis_g = (i % (lut_param.size * lut_param.size)) / lut_param.size;
            axis_b = i / (lut_param.size * lut_param.size);

            odd_r = axis_r % 2;
            odd_g = axis_g % 2;
            odd_b = axis_b % 2;

            k = (axis_r / 2) + (axis_g / 2) * ((lut_param.size + 1) >> 1) + (axis_b / 2) * ((lut_param.size + 1) >> 1) * ((lut_param.size + 1) >> 1);

            if(odd_r == 0 && odd_g == 0 && odd_b == 0) {
                lut_param.lut_000[k](41, 28) = atoi(value1);
                lut_param.lut_000[k](27, 14) = atoi(value2);
                lut_param.lut_000[k](13, 0) = atoi(value3);
            }
            else if(odd_r == 0 && odd_g == 0 && odd_b == 1) {
                lut_param.lut_001[k](41, 28) = atoi(value1);
                lut_param.lut_001[k](27, 14) = atoi(value2);
                lut_param.lut_001[k](13, 0) = atoi(value3);
            }
            else if(odd_r == 0 && odd_g == 1 && odd_b == 0) {
                lut_param.lut_010[k](41, 28) = atoi(value1);
                lut_param.lut_010[k](27, 14) = atoi(value2);
                lut_param.lut_010[k](13, 0) = atoi(value3);
            }
            else if(odd_r == 0 && odd_g == 1 && odd_b == 1) {
                lut_param.lut_011[k](41, 28) = atoi(value1);
                lut_param.lut_011[k](27, 14) = atoi(value2);
                lut_param.lut_011[k](13, 0) = atoi(value3);
            }
            else if(odd_r == 1 && odd_g == 0 && odd_b == 0) {
                lut_param.lut_100[k](41, 28) = atoi(value1);
                lut_param.lut_100[k](27, 14) = atoi(value2);
                lut_param.lut_100[k](13, 0) = atoi(value3);
            }
            else if(odd_r == 1 && odd_g == 0 && odd_b == 1) {
                lut_param.lut_101[k](41, 28) = atoi(value1);
                lut_param.lut_101[k](27, 14) = atoi(value2);
                lut_param.lut_101[k](13, 0) = atoi(value3);
            }
            else if(odd_r == 1 && odd_g == 1 && odd_b == 0) {
                lut_param.lut_110[k](41, 28) = atoi(value1);
                lut_param.lut_110[k](27, 14) = atoi(value2);
                lut_param.lut_110[k](13, 0) = atoi(value3);
            }
            else if(odd_r == 1 && odd_g == 1 && odd_b == 1) {
                lut_param.lut_111[k](41, 28) = atoi(value1);
                lut_param.lut_111[k](27, 14) = atoi(value2);
                lut_param.lut_111[k](13, 0) = atoi(value3);
            }

            i++;
        }
    }

    uint16_t* frameIn = (uint16_t*)malloc(3 * top_param.frameWidth * top_param.frameHeight * sizeof(uint16_t));
    uint16_t* frameGolden = (uint16_t*)malloc(3 * top_param.frameWidth * top_param.frameHeight * sizeof(uint16_t));
    uint16_t* frameOut = (uint16_t*)malloc(3 * top_param.frameWidth * top_param.frameHeight * sizeof(uint16_t));

    //In
    FILE *fp_r1 = fopen(LUT_SRC1, "r");
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
    FILE *fp_g1 = fopen(LUT_GOLDEN1, "r");
    if(!fp_g1){
        printf("Can not open golden file!\n");
    }

    for (x = 0; x < 3*top_param.frameWidth*top_param.frameHeight; x++) {
        fread(&frameGolden[x], sizeof(uint16_t), 1, fp_g1);
    }

    printf("\tEnvironment set up!\n");

    //Execution
    lut(top_param, lut_param, src, dst);
    printf("\tExecution completed!\n");
    printf("\t%d\n",dst.size());

    //Out
    FILE *fp_w1 = fopen(LUT_DST1, "w");
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
