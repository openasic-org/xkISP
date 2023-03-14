#include "../src/lut.h"

#include "../src/file_define_catapult.h"
#include <ac_int.h>
#include <mc_scverify.h>

#define LUT_SRC1 "../../tv/gtm_out.rgb"
#define LUT_DST1 "../../tv/lut_hls.rgb"
#define LUT_GOLDEN1 "../../tv/lut_out.rgb"
#define LUT_CUBE "../../tv/integer.cube"
#define LUT_CUBE_17 "../../tv/integer_17.cube"

CCS_MAIN(int argc, char** argv)
{
    top_register topParam;
    lut_register lut_param;
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

    printf("\tTest for ISP lut module!\n");
    memset(&topParam, 0, sizeof(top_register));
    memset(&lut_param, 0, sizeof(lut_register));
    const char* config_file = "../config/xkISP.cfg";

    char buf[100] = "";
    FILE* fp_config = fopen((const char*)config_file, "r");
    char *p, *q;
    char key[100], value[100];
    int output_yuvpattern = 0; //0:444 1:422 2:420
    int Noise_Mode;
    int Img_Format;
    float rawdns_sigma;
    int noise_es_enable;
    int lsc_config = 0;
    float gtm_gamma = 0.0;

    if(fp_config == NULL)
    {
        printf("\t Warning: no configuration file!\n");
        printf("\t Will use default initial values!\n");
    }
    else
    {
        while (fgets(buf, 100, fp_config))
        {
            p = strchr(buf, '=');
            q = strchr(buf, '\n');
            if (p != NULL && q != NULL)
            {
                *q = '\0';
                strncpy(key, buf, p - buf);
                strcpy(value, p + 1);

                if(strstr(key, "frame_width"))
                {
                    topParam.frameWidth = atoi(value);
                    printf("frame_width = %d\n", topParam.frameWidth);
                    continue;
                }

                if(strstr(key, "frame_height"))
                {
                    topParam.frameHeight = atoi(value);
                    printf("frame_height = %d\n", topParam.frameHeight);
                    continue;
                }

                if(strstr(key, "image_pattern"))
                {
                    topParam.imgPattern = atoi(value);
                    printf("image_pattern = %d\n", topParam.imgPattern);
                    continue;
                }

                if(strstr(key, "blc"))
                {
                    topParam.blc = atoi(value);
                    printf("blc = %d\n", topParam.blc);
                    continue;
                }

                if(strstr(key, "lut_enable"))
                {
                    lut_param.eb = atoi(value);
                    printf("lut_enable = %d\n", lut_param.eb);
                    continue;
                }

                if(strstr(key, "lut_size"))
                {
                    lut_param.size = atoi(value);
                    printf("lut_size = %d\n", lut_param.size);
                    lut_param.lines = lut_param.size * lut_param.size * lut_param.size;
                    printf("lut_lines = %d\n", lut_param.lines);
                    continue;
                }
            }
        }
    }

//loading file
    const char* lut_file;
    char *p1, *q1, *r, *s;
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
            p1 = strchr(line, ' ');
            if (p1 != NULL)
            {
                strncpy(value1, line, p1 - line);
                strcpy(line2, p1 + 1);
                q1 = strchr(line2, ' ');
                if (q1 != NULL)
                {
                    strncpy(value2, line2, q1 - line2);
                    strcpy(value3, q1 + 1);
                }
            }

            axis_r = i % lut_param.size;
            axis_g = (i % (lut_param.size * lut_param.size)) / lut_param.size;
            axis_b = i / (lut_param.size * lut_param.size);

            odd_r = axis_r % 2;
            odd_g = axis_g % 2;
            odd_b = axis_b % 2;

            k = (axis_r / 2) + (axis_g / 2) * ((32 + 1) >> 1) + (axis_b / 2) * ((32 + 1) >> 1) * ((32 + 1) >> 1);

            if(odd_r == 0 && odd_g == 0 && odd_b == 0) {
                lut_param.lut_000[k] = atoi(value1);
                lut_param.lut_000[k] = atoi(value2) + (lut_param.lut_000[k] << 14);
                lut_param.lut_000[k] = atoi(value3) + (lut_param.lut_000[k] << 14);
            }
            else if(odd_r == 0 && odd_g == 0 && odd_b == 1) {
                lut_param.lut_001[k] = atoi(value1);
                lut_param.lut_001[k] = atoi(value2) + (lut_param.lut_001[k] << 14);
                lut_param.lut_001[k] = atoi(value3) + (lut_param.lut_001[k] << 14);
            }
            else if(odd_r == 0 && odd_g == 1 && odd_b == 0) {
                lut_param.lut_010[k] = atoi(value1);
                lut_param.lut_010[k] = atoi(value2) + (lut_param.lut_010[k] << 14);
                lut_param.lut_010[k] = atoi(value3) + (lut_param.lut_010[k] << 14);
            }
            else if(odd_r == 0 && odd_g == 1 && odd_b == 1) {
                lut_param.lut_011[k] = atoi(value1);
                lut_param.lut_011[k] = atoi(value2) + (lut_param.lut_011[k] << 14);
                lut_param.lut_011[k] = atoi(value3) + (lut_param.lut_011[k] << 14);
            }
            else if(odd_r == 1 && odd_g == 0 && odd_b == 0) {
                lut_param.lut_100[k] = atoi(value1);
                lut_param.lut_100[k] = atoi(value2) + (lut_param.lut_100[k] << 14);
                lut_param.lut_100[k] = atoi(value3) + (lut_param.lut_100[k] << 14);
            }
            else if(odd_r == 1 && odd_g == 0 && odd_b == 1) {
                lut_param.lut_101[k] = atoi(value1);
                lut_param.lut_101[k] = atoi(value2) + (lut_param.lut_101[k] << 14);
                lut_param.lut_101[k] = atoi(value3) + (lut_param.lut_101[k] << 14);
            }
            else if(odd_r == 1 && odd_g == 1 && odd_b == 0) {
                lut_param.lut_110[k] = atoi(value1);
                lut_param.lut_110[k] = atoi(value2) + (lut_param.lut_110[k] << 14);
                lut_param.lut_110[k] = atoi(value3) + (lut_param.lut_110[k] << 14);
            }
            else if(odd_r == 1 && odd_g == 1 && odd_b == 1) {
                lut_param.lut_111[k] = atoi(value1);
                lut_param.lut_111[k] = atoi(value2) + (lut_param.lut_111[k] << 14);
                lut_param.lut_111[k] = atoi(value3) + (lut_param.lut_111[k] << 14);
            }
            i++;
        }
    }

    uint16_t frameIn[3];
    uint16_t frameGolden[3];
    uint16_t frameOut[3];

    //In
    FILE *fp_r1 = fopen(LUT_SRC1, "r");
    if(!fp_r1){
        printf("Can not open input file!\n");
    }

    for (x = 0; x < topParam.frameWidth*topParam.frameHeight; x++) {
        fread(&frameIn[0], sizeof(uint16_t), 1, fp_r1);
        red = (uint14)frameIn[0];
        fread(&frameIn[1], sizeof(uint16_t), 1, fp_r1);
        green = (uint14)frameIn[1];
        fread(&frameIn[2], sizeof(uint16_t), 1, fp_r1);
        blue = (uint14)frameIn[2];
        srcdata.set_slc(28, red);
        srcdata.set_slc(14, green);
        srcdata.set_slc(0, blue);
        src.write(srcdata);
    }
    printf("\tInit done!\n");

    //Golden
    FILE *fp_g1 = fopen(LUT_GOLDEN1, "r");
    if(!fp_g1){
        printf("Can not open golden file!\n");
    }

    printf("\tEnvironment set up!\n");

    //Execution
    CCS_DESIGN(lut) (topParam, lut_param, src, dst);

    printf("\tExecution completed!\n");
    printf("\t%d\n",dst.size());

    //Out
    FILE *fp_w1 = fopen(LUT_DST1, "w");
    if(!fp_w1){
        printf("\tCan not open write back file!\n");
    }

    for (x = 0; x < topParam.frameWidth*topParam.frameHeight; x++) {
        dstdata = dst.read();
        red_o = dstdata >> 28;
        green_o = (dstdata >> 14) & 0x3fff;
        blue_o = dstdata & 0x3fff;
        frameOut[0] = red_o;
        frameOut[1] = green_o;
        frameOut[2] = blue_o;
        fwrite(&frameOut[0], sizeof(uint16_t), 1, fp_w1);
        fwrite(&frameOut[1], sizeof(uint16_t), 1, fp_w1);
        fwrite(&frameOut[2], sizeof(uint16_t), 1, fp_w1);
        fread(&frameGolden[0], sizeof(uint16_t), 1, fp_g1);
        fread(&frameGolden[1], sizeof(uint16_t), 1, fp_g1);
        fread(&frameGolden[2], sizeof(uint16_t), 1, fp_g1);
        if((frameGolden[0] != frameOut[0]) || (frameGolden[1] != frameOut[1]) || (frameGolden[2] != frameOut[2])) {
            printf("\t\tFirst mismatch in pixel %d, channel %d!\n", x/3, x%3);
            cout << "Golden = " << setbase(10) << frameGolden[x%3] << endl;
            cout << "result = " << setbase(10) << frameOut[x%3] << endl;
            exit(0);
        }
    }
    printf("\tTest passed!\n");

    fclose(fp_r1);
    fclose(fp_g1);
    fclose(fp_w1);

    CCS_RETURN(0);
}
