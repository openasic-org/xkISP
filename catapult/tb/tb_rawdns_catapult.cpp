#include "../src/rawdns.h"
#include "../src/file_define_catapult.h"
#include <ac_int.h>
#include <mc_scverify.h>

CCS_MAIN(int argc, char* argv[])
{
    top_register topParam;
    rawdns_register rawdnsParam;

    ac_channel<uint12> src;
    ac_channel<uint12> dst;

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

                if(strstr(key, "rawdns_enable"))
                {
                    rawdnsParam.eb = atoi(value);
                    printf("rawdns_enable = %d\n", rawdnsParam.eb);
                    continue;
                }

                if(strstr(key, "rawdns_sigma"))
                {
                    rawdnsParam.sigma = atoi(value);
                    printf("rawdns_sigma = %d\n", rawdnsParam.sigma);
                    continue;
                }

                if(strstr(key, "rawdns_filter"))
                {
                    rawdnsParam.Filterpara = atoi(value);
                    printf("rawdns_filter = %d\n", rawdnsParam.Filterpara);
                    continue;
                }

                if(strstr(key, "rawdns_bitwidth"))
                {
                    uint5 bitwidth = atoi(value);
                    printf("rawdns_bitwidth = %d\n", bitwidth);
                    rawdnsParam.invksigma2 = 4096 * 256 / (rawdnsParam.Filterpara * rawdnsParam.sigma) * (65536 >> ((bitwidth - 8) * 2) ) / (rawdnsParam.Filterpara * rawdnsParam.sigma);
                    printf("rawdnsParam.invksigma2 = %d\n", rawdnsParam.invksigma2);
                    continue;
                }
            }
        }
    }

    uint16_t frame_in;
    uint16_t golden_in;
    uint16_t frame_out;

    uint12 src_in ;
    uint12 dst_out;

    FILE* fp4 = fopen(RAWDNS_SRC1, "r");
    if (fp4 == NULL)
    {
        printf("SRC file open failed!\n");
        return false;
    }

    for (int i = 0; i < topParam.frameWidth * topParam.frameHeight; i++) {
        fread(&frame_in, sizeof(uint16_t),1, fp4);
        src_in = (uint12)frame_in;
        src.write(src_in);
    }
    fclose(fp4);

    //read ref in and store in heap golden in
    FILE* fp5 = fopen(RAWDNS_GOLDEN1, "r");
    if (fp5 == NULL)
    {
        printf("GOLDEN file open failed!\n");
        return false;
    }

    //execution and write out
    CCS_DESIGN(isp_rawdns) (topParam, rawdnsParam, src, dst);

    FILE* fp6 = fopen(RAWDNS_DST1, "w");
    if (fp6 == NULL)
    {
        printf("DST file open failed!\n");
        return false;
    }

    for (int x = 0; x < topParam.frameWidth*topParam.frameHeight; x++) {
        fread(&golden_in, sizeof(uint16_t), 1, fp5);
        uint12 dstdata;
        dstdata = dst.read();
        frame_out = dstdata;
        fwrite(&frame_out, sizeof(uint16_t), 1, fp6);
        if(golden_in != frame_out) {
            printf("\t\tFirst mismatch in pixel %d!\n", x);
            printf("\t\tGolden = %d, result = %d!\n", golden_in, frame_out);
            exit(0);
        }
        frame_out = 0;
        golden_in = 0;
    }

    fclose(fp5);
    fclose(fp6);

    return 0;
}
