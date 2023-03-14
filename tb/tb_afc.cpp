#include "../src/afc.h"

int main(int argc, char** argv)
{
    top_register topParam;
    afc_register afc_param;
    hls::stream<uint12> src("in");
    hls::stream<uint12> dst("out");
    int x;

    printf("\tTest for ISP afc module!\n");
    memset(&topParam, 0, sizeof(top_register));
    memset(&afc_param, 0, sizeof(afc_register));
    topParam.frameWidth = 640;
    topParam.frameHeight = 480;
    topParam.imgPattern = 3;
    afc_param.eb = 1;
    afc_param.location_row = 240;
    afc_param.location_col = 320;
    afc_param.m_bIfHardThreshold = 0;
    afc_param.ThrList[0] = 200;
    afc_param.ThrList[1] = 400;
    afc_param.ThrList[2] = 600;
    afc_param.ThrList[3] = 800;
    afc_param.ThrList[4] = 1000;
    afc_param.ThrList[5] = 1200;
    afc_param.ThrList[6] = 1400;
    afc_param.ThrList[7] = 1600;
    afc_param.T = 1000;

    uint16_t* frameIn = (uint16_t*)malloc(topParam.frameWidth * topParam.frameHeight * sizeof(uint16_t));

    //In
    FILE *fp_r1 = fopen(AFC_SRC1, "r");
    if(!fp_r1){
        printf("Can not input file!\n");
    }

    for (x = 0; x < topParam.frameWidth*topParam.frameHeight; x++) {
        fread(&frameIn[x], sizeof(uint16_t), 1, fp_r1);
        uint12 srcdata = (uint12)frameIn[x];
        src << srcdata;
    }
    printf("\tInit done!\n");

    //Execution
    afc(topParam, afc_param, src, dst);
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
