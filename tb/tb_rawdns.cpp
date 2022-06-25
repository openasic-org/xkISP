#include "../src/rawdns.h"

int main(int argc, char* argv[])
{
    top_register topParam;
    rawdns_register rawdnsParam;

    hls::stream<uint12> src("input stream");
    hls::stream<uint12> dst("output stream");

    memset(&topParam, 0, sizeof(top_register));
    memset(&rawdnsParam, 0, sizeof(rawdns_register));
    
    topParam.frameWidth = 640;
    topParam.frameHeight = 480;

    rawdnsParam.eb = 1;
    rawdnsParam.sigma = 30;
    rawdnsParam.Filterpara = 50;
    rawdnsParam.invksigma2 = 119;//1/34<<12;

    uint16_t* frame_in = (uint16_t*)malloc(sizeof(uint16_t) * topParam.frameWidth * topParam.frameHeight);
    uint16_t* golden_in = (uint16_t*)malloc(sizeof(uint16_t) * topParam.frameWidth * topParam.frameHeight);
    uint16_t* frame_out = (uint16_t*)malloc(sizeof(uint16_t) * topParam.frameWidth * topParam.frameHeight);

    uint12 src_in ;
    uint12 dst_out;
    
    //the 1928*1088 phase

    FILE* fp4 = fopen(RAWDNS_SRC1, "r");
    if (fp4 == NULL)
    {
        printf("SRC file open failed!\n");
        return false;
    }

    for (int i = 0; i < topParam.frameWidth * topParam.frameHeight; i++) {
        fread(&frame_in[i], sizeof(uint16_t),1, fp4);
        src_in = (uint12)frame_in[i];
        src << src_in;
    }
    fclose(fp4);

    //read ref in and store in heap golden in
    FILE* fp5 = fopen(RAWDNS_GOLDEN1, "r");
    if (fp5 == NULL)
    {
        printf("GOLDEN file open failed!\n");
        return false;
    }


    for (int i = 0; i < topParam.frameWidth * topParam.frameHeight; i++) {
        fread(&golden_in[i], sizeof(uint16_t), 1, fp5);
    }
    fclose(fp5);

    //execution and write out 
    isp_rawdns(topParam, rawdnsParam, src, dst);
    
    FILE* fp6 = fopen(RAWDNS_DST1, "w");
    if (fp6 == NULL)
    {
        printf("DST file open failed!\n");
        return false;
    }
    
    for (int i = 0; i < topParam.frameWidth * topParam.frameHeight; i++) {
        dst>>dst_out;
        frame_out[i] = dst_out;
    }
    
    fwrite(frame_out,sizeof(uint16_t),topParam.frameWidth * topParam.frameHeight,fp6);
    fclose(fp6);

    //Compare and print results
    for (int i = 0; i < topParam.frameWidth * topParam.frameHeight; i++) {
        uint16_t golden_pixel = golden_in[i];
        uint16_t dst_pixel = frame_out[i];
        
        if (golden_pixel != dst_pixel)
        {
            cout << "Golden = " << setbase(10) << golden_in[i] << endl;
            cout << "result = " << setbase(10) << frame_out[i] << endl;
            printf("\t i=%d, \trows=%d,\tcols=%d\n", i, i / topParam.frameWidth.to_int(), i - (i / topParam.frameWidth.to_int()) * topParam.frameWidth.to_int());
            //exit(0);
        }
    }

    printf("Test Passed !\n");
    printf("Total pixel number is %d\n", topParam.frameWidth.to_int() * topParam.frameHeight.to_int());
    printf("640x480 Verification finished!\n");

    free(frame_in);
    free(golden_in);
    free(frame_out);
    return 0;
}

