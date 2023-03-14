#include "../src/afc.h"
#include "../src/file_define_catapult.h"
#include <ac_int.h>
#include <mc_scverify.h>

CCS_MAIN(int argc, char** argv)
{
    top_register topParam;
    afc_register afc_param;
    ac_channel<uint12> src;
    ac_channel<uint12> dst;
    int x;

    const char* config_file = "../config/xkISP_HLS.cfg";

    printf("\tTest for ISP afc module!\n");

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

                if(strstr(key, "afc_enable"))
                {
                    afc_param.eb = atoi(value);
                    printf("afc_enable = %d\n", afc_param.eb);
                    continue;
                }

                if(strstr(key, "afc_location_row"))
                {
                    afc_param.location_row = atoi(value);
                    printf("afc_location_row = %d\n", afc_param.location_row);
                    continue;
                }

                if(strstr(key, "afc_location_col"))
                {
                    afc_param.location_col = atoi(value);
                    printf("afc_location_col = %d\n", afc_param.location_col);
                    continue;
                }

                if(strstr(key, "afc_m_bIfHardThreshold"))
                {
                    afc_param.m_bIfHardThreshold = atoi(value);
                    printf("afc_m_bIfHardThreshold = %d\n", afc_param.m_bIfHardThreshold);
                    continue;
                }

                if(strstr(key, "afc_T_value"))
                {
                    afc_param.T = atoi(value);
                    printf("afc_T = %d\n", afc_param.T);
                    continue;
                }

                if(strstr(key, "afc_ThrList_0"))
                {
                    afc_param.ThrList[0] = atoi(value);
                    printf("afc_ThrList[0] = %d\n", afc_param.ThrList[0]);
                    continue;
                }

                if(strstr(key, "afc_ThrList_1"))
                {
                    afc_param.ThrList[1] = atoi(value);
                    printf("afc_ThrList[1] = %d\n", afc_param.ThrList[1]);
                    continue;
                }

                if(strstr(key, "afc_ThrList_2"))
                {
                    afc_param.ThrList[2] = atoi(value);
                    printf("afc_ThrList[2] = %d\n", afc_param.ThrList[2]);
                    continue;
                }

                if(strstr(key, "afc_ThrList_3"))
                {
                    afc_param.ThrList[3] = atoi(value);
                    printf("afc_ThrList[3] = %d\n", afc_param.ThrList[3]);
                    continue;
                }

                if(strstr(key, "afc_ThrList_4"))
                {
                    afc_param.ThrList[4] = atoi(value);
                    printf("afc_ThrList[4] = %d\n", afc_param.ThrList[4]);
                    continue;
                }

                if(strstr(key, "afc_ThrList_5"))
                {
                    afc_param.ThrList[5] = atoi(value);
                    printf("afc_ThrList[5] = %d\n", afc_param.ThrList[5]);
                    continue;
                }

                if(strstr(key, "afc_ThrList_6"))
                {
                    afc_param.ThrList[6] = atoi(value);
                    printf("afc_ThrList[6] = %d\n", afc_param.ThrList[6]);
                    continue;
                }

                if(strstr(key, "afc_ThrList_7"))
                {
                    afc_param.ThrList[7] = atoi(value);
                    printf("afc_ThrList[7] = %d\n", afc_param.ThrList[7]);
                    continue;
                }
            }
        }
    }

    uint16_t frameIn;

    //In
    FILE *fp_r1 = fopen(AFC_SRC1, "r");
    if(!fp_r1){
        printf("Can not open input file!\n");
    }

    for (x = 0; x < topParam.frameWidth*topParam.frameHeight; x++) {
    	fread(&frameIn, sizeof(uint16_t), 1, fp_r1);
        uint12 srcdata = (uint12)frameIn;
        src.write(srcdata);
    }
    printf("\tInit done!\n");

    //Execution
    CCS_DESIGN(afc) (topParam, afc_param, src, dst);
    printf("\tExecution completed!\n");

    cout << "hls_SumHF =" << afc_param.SumHF << endl;
    cout << "hls_CountHF =" << afc_param.CountHF << endl;
    cout << "hls_SumMF =" << afc_param.SumMF << endl;
    cout << "hls_CountMF =" << afc_param.CountMF << endl;

    //Out
    printf("\tTest passed!\n");

    fclose(fp_r1);

    return 0;
}
