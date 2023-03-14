#include "../src/scaledown.h"
#include "../src/file_define_catapult.h"
#include <ac_int.h>
#include <mc_scverify.h>

CCS_MAIN(int argc, char** argv)
{
    top_register topParam;
    scaledown_register scaledown_param;

    ac_channel<uint10> y_src;
    ac_channel<uint10> u_src;
    ac_channel<uint10> v_src;
    ac_channel<uint10> y_dst;
    ac_channel<uint10> u_dst;
    ac_channel<uint10> v_dst;
    int x;
    uint10 y_in_data;
    uint10 u_in_data;
    uint10 v_in_data;
    uint10 y_out_data;
    uint10 u_out_data;
    uint10 v_out_data;

    printf("\tTest for ISP scaledown module!\n");

    const char* config_file = "../config/xkISP_HLS.cfg";

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

                if(strstr(key, "scaledown_enable"))
                {
                    scaledown_param.m_nEb = atoi(value);
                    printf("scaledown_enable = %d\n", scaledown_param.m_nEb);
                    continue;
                }

                if(strstr(key, "output_times"))
                {
                    scaledown_param.times = atoi(value);
                    //crop_param.times = scaledown_param.times;
                    printf("output_times = %d\n", scaledown_param.times);
                    continue;
                }
            }
        }
    }

    uint13 out_width_1 = topParam.frameWidth;
    uint13 out_height_1 = topParam.frameHeight;
    scaledown_param.times = 2;
    uint13 out_width_2 = topParam.frameWidth / scaledown_param.times;
    uint13 out_height_2 = topParam.frameHeight / scaledown_param.times;
    scaledown_param.times = 4;
    uint13 out_width_3 = topParam.frameWidth / scaledown_param.times;
    uint13 out_height_3 = topParam.frameHeight / scaledown_param.times;

    uint16_t frameIn_1[3];
    uint16_t frameGolden_1;
    uint16_t frameOut_1;

    //In
    FILE *fp_r1 = fopen(scaledown_SRC1, "r");
    if(!fp_r1){
        printf("Can not open input file!\n");
    }

    for (x = 0; x < 3 * topParam.frameWidth * topParam.frameHeight; x++) {
        if(x < topParam.frameWidth * topParam.frameHeight)
        {
            fread(&frameIn_1[0], sizeof(uint16_t), 1, fp_r1);
            y_in_data = (uint10)frameIn_1[0];
            y_src.write(y_in_data);
        }
        else if(x < 2 * topParam.frameWidth * topParam.frameHeight)
        {
            fread(&frameIn_1[1], sizeof(uint16_t), 1, fp_r1);
            u_in_data = (uint10)frameIn_1[1];
            u_src.write(u_in_data);
        }
        else
        {
            fread(&frameIn_1[2], sizeof(uint16_t), 1, fp_r1);
            v_in_data = (uint10)frameIn_1[2];
            v_src.write(v_in_data);
        }
    }
    printf("\tInit done!\n");

    //Golden
    FILE *fp_g1 = fopen(scaledown_GOLDEN1, "r");
    if(!fp_g1){
        printf("Can not open golden file!\n");
    }

    printf("\tEnvironment set up!\n");

    //Execution
    CCS_DESIGN(scaledown) (topParam, scaledown_param, y_src, u_src, v_src, y_dst, u_dst, v_dst);

    printf("\tExecution completed!\n");
    printf("\t%d\n",y_dst.size());
    printf("\t%d\n",u_dst.size());
    printf("\t%d\n",v_dst.size());

    //Out
    FILE *fp_w1 = fopen(scaledown_DST1, "w");
    if(!fp_w1){
        printf("\tCan not open write back file!\n");
    }

    for (x = 0; x < 3 * topParam.frameWidth * topParam.frameHeight; x++) {
        if(x < topParam.frameWidth * topParam.frameHeight)
        {
            y_out_data = y_dst.read();
            frameOut_1 = y_out_data;
            fwrite(&frameOut_1, sizeof(uint16_t), 1, fp_w1);
        }
        else if(x < 2 * topParam.frameWidth * topParam.frameHeight)
        {
            u_out_data = u_dst.read();
            frameOut_1 = u_out_data;
            fwrite(&frameOut_1, sizeof(uint16_t), 1, fp_w1);
        }
        else
        {
            v_out_data = v_dst.read();
            frameOut_1 = v_out_data;
            fwrite(&frameOut_1, sizeof(uint16_t), 1, fp_w1);
        }

        fread(&frameGolden_1, sizeof(uint16_t), 1, fp_g1);

        if (frameGolden_1 != frameOut_1) {
            printf("\t\tFirst mismatch in pixel %d, channel %d!\n", x / 3, x % 3);
            cout << "Golden = " << setbase(10) << frameGolden_1 << endl;
            cout << "result = " << setbase(10) << frameOut_1 << endl;
            exit(0);
        }
    }
    printf("\tTest passed!\n");

    fclose(fp_r1);
    fclose(fp_g1);
    fclose(fp_w1);
/*
    scaledown_param.m_nEb = 1;
    scaledown_param.times = 2;

    //In
    FILE *fp_r2 = fopen(scaledown_SRC2, "r");
    if(!fp_r2){
        printf("Can not open input file!\n");
    }

    for (x = 0; x < 3 * topParam.frameWidth * topParam.frameHeight; x++) {
        if(x < topParam.frameWidth * topParam.frameHeight)
        {
            fread(&frameIn_2[x], sizeof(uint16_t), 1, fp_r2);
            y_in_data = (uint10)frameIn_2[x];
            y_src.write(y_in_data);
        }
        else if(x < 2 * topParam.frameWidth * topParam.frameHeight)
        {
            fread(&frameIn_2[x], sizeof(uint16_t), 1, fp_r2);
            u_in_data = (uint10)frameIn_2[x];
            u_src.write(u_in_data);
        }
        else
        {
            fread(&frameIn_2[x], sizeof(uint16_t), 1, fp_r2);
            v_in_data = (uint10)frameIn_2[x];
            v_src.write(v_in_data);
        }
    }
    printf("\tInit done!\n");

    //Golden
    FILE *fp_g2 = fopen(scaledown_GOLDEN2, "r");
    if(!fp_g2){
        printf("Can not open golden file!\n");
    }

    for (x = 0; x < 3 * out_width_2 * out_height_2; x++) {
        fread(&frameGolden_2[x], sizeof(uint16_t), 1, fp_g2);
    }
    printf("\tEnvironment set up!\n");

    //Execution
    scaledown(topParam, scaledown_param, y_src, u_src, v_src, y_dst, u_dst, v_dst);
    printf("\tExecution completed!\n");
    printf("\t%d\n",y_dst.size());
    printf("\t%d\n",u_dst.size());
    printf("\t%d\n",v_dst.size());

    //Out
    FILE *fp_w2 = fopen(scaledown_DST2, "w");
    if(!fp_w2){
        printf("\tCan not open write back file!\n");
    }

    for (x = 0; x < 3 * out_width_2 * out_height_2; x++) {
        if(x < out_width_2 * out_height_2)
        {
            y_out_data = y_dst.read();
            frameOut_2[x] = y_out_data;
        }
        else if(x < 2 * out_width_2 * out_height_2)
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

    fwrite(frameOut_2, sizeof(uint16_t), (3 * out_width_2 * out_height_2), fp_w2);

    //Checker
    for (x = 0; x < 3 * out_width_2 * out_height_2; x++) {
        if(frameGolden_2[x] != frameOut_2[x]) {
            printf("\t\tFirst mismatch in pixel %d, channel %d!\n", x, x % 2);
            cout << "Golden = " << setbase(16) << frameGolden_2[x] << endl;
            cout << "result = " << setbase(16) << frameOut_2[x] << endl;
            exit(0);
        }
    }
    printf("\tTest passed!\n");

    fclose(fp_r2);
    fclose(fp_g2);
    fclose(fp_w2);
*/

    return 0;
}
