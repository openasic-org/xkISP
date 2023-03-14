#include "../src/crop.h"
#include "../src/file_define_catapult.h"
#include <ac_int.h>
#include <mc_scverify.h>

CCS_MAIN(int argc, char** argv)
{
    top_register topParam;
    crop_register crop_param;
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

    printf("\tTest for ISP crop module!\n");
    memset(&topParam, 0, sizeof(top_register));
    memset(&crop_param, 0, sizeof(crop_register));
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

                if(strstr(key, "crop_enable"))
                {
                    crop_param.m_nEb = atoi(value);
                    printf("crop_enable = %d\n", crop_param.m_nEb);
                    continue;
                }

                if(strstr(key, "output_left"))
                {
                    crop_param.upper_left_x = atoi(value);
                    printf("output_left = %d\n", crop_param.upper_left_x);
                    continue;
                }

                if(strstr(key, "output_up"))
                {
                    crop_param.upper_left_y = atoi(value);
                    printf("output_up = %d\n", crop_param.upper_left_y);
                    continue;
                }

                if(strstr(key, "output_right"))
                {
                    crop_param.lower_right_x = atoi(value);
                    printf("output_right = %d\n", crop_param.lower_right_x);
                    if(crop_param.lower_right_x > topParam.frameWidth)
                    {
                        printf("\tError: parameter output_right should be smaller than frame_width\n");
                        exit(-1);
                    }
                    else if(crop_param.lower_right_x <= crop_param.upper_left_x)
                    {
                        printf("\tError: parameter output_right should be bigger than output_left\n");
                        exit(-1);
                    }
                    continue;
                }

                if(strstr(key, "output_down"))
                {
                    crop_param.lower_right_y = atoi(value);
                    printf("output_down = %d\n", crop_param.lower_right_y);
                    if(crop_param.lower_right_y > topParam.frameHeight)
                    {
                        printf("\tError: parameter output_down should be smaller than frame_height\n");
                        exit(-1);
                    }
                    else if(crop_param.lower_right_y <= crop_param.upper_left_y)
                    {
                        printf("\tError: parameter output_down should be bigger than output_up\n");
                        exit(-1);
                    }
                    continue;
                }
            }
        }
    }

    uint13 out_width = crop_param.lower_right_y - crop_param.upper_left_y;
    uint13 out_height = crop_param.lower_right_x - crop_param.upper_left_x;

    uint16_t frameIn_1[3];
    uint16_t frameGolden_1;
    uint16_t frameOut_1;

    //In
    FILE *fp_r1 = fopen(CROP_SRC1, "r");
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
    FILE *fp_g1 = fopen(CROP_GOLDEN1, "r");
    if(!fp_g1){
        printf("Can not open golden file!\n");
    }

    printf("\tEnvironment set up!\n");

    //Execution
    CCS_DESIGN(crop) (topParam, crop_param, y_src, u_src, v_src, y_dst, u_dst, v_dst);

    printf("\tExecution completed!\n");
    printf("\t%d\n",y_dst.size());
    printf("\t%d\n",u_dst.size());
    printf("\t%d\n",v_dst.size());

    //Out
    FILE *fp_w1 = fopen(CROP_DST1, "w");
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

    return 0;
}
