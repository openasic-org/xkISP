#include "../src/crop.h"

int main(int argc, char** argv)
{
    top_register topParam;
    crop_register crop_param;
    hls::stream<uint10> y_src("y_in");
    hls::stream<uint10> u_src("u_in");
    hls::stream<uint10> v_src("v_in");
    hls::stream<uint10> y_dst("y_out");
    hls::stream<uint10> u_dst("u_out");
    hls::stream<uint10> v_dst("v_out");
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
    topParam.frameWidth = 640;
    topParam.frameHeight = 480;
    crop_param.upper_left_x = 0;
    crop_param.upper_left_y = 0;
    crop_param.lower_right_x = 640;
    crop_param.lower_right_y = 480;
    crop_param.m_nEb = 1;
    uint13 out_width = crop_param.lower_right_y - crop_param.upper_left_y;
    uint13 out_height = crop_param.lower_right_x - crop_param.upper_left_x;

    uint16_t* frameIn_1 = (uint16_t*)malloc(3 * topParam.frameWidth * topParam.frameHeight * sizeof(uint16_t));
    uint16_t* frameGolden_1 = (uint16_t*)malloc(3 * out_width * out_height * sizeof(uint16_t));
    uint16_t* frameOut_1 = (uint16_t*)malloc(3 * out_width * out_height * sizeof(uint16_t));

    uint16_t* frameIn_2 = (uint16_t*)malloc(2 * topParam.frameWidth * topParam.frameHeight * sizeof(uint16_t));
    uint16_t* frameGolden_2 = (uint16_t*)malloc(2 * out_width * out_height * sizeof(uint16_t));
    uint16_t* frameOut_2 = (uint16_t*)malloc(2 * out_width * out_height * sizeof(uint16_t));

    uint16_t* frameIn_3 = (uint16_t*)malloc(3 * topParam.frameWidth * topParam.frameHeight * sizeof(uint16_t) / 2);
    uint16_t* frameGolden_3 = (uint16_t*)malloc(3 * out_width * out_height * sizeof(uint16_t) / 2);
    uint16_t* frameOut_3 = (uint16_t*)malloc(3 * out_width * out_height * sizeof(uint16_t) / 2);

    crop_param.yuvpattern = 0;

    //In
    FILE *fp_r1 = fopen(CROP_SRC1, "r");
    if(!fp_r1){
        printf("Can not open input file!\n");
    }

    for (x = 0; x < 3 * topParam.frameWidth * topParam.frameHeight; x++) {
        if(x < topParam.frameWidth * topParam.frameHeight)
        {
            fread(&frameIn_1[x], sizeof(uint16_t), 1, fp_r1);
            y_in_data = (uint10)frameIn_1[x];
            y_src.write(y_in_data);
        }
        else if(x < 2 * topParam.frameWidth * topParam.frameHeight)
        {
            fread(&frameIn_1[x], sizeof(uint16_t), 1, fp_r1);
            u_in_data = (uint10)frameIn_1[x];
            u_src.write(u_in_data);
        }
        else
        {
            fread(&frameIn_1[x], sizeof(uint16_t), 1, fp_r1);
            v_in_data = (uint10)frameIn_1[x];
            v_src.write(v_in_data);
        }
    }
    printf("\tInit done!\n");

    //Golden
    FILE *fp_g1 = fopen(CROP_GOLDEN1, "r");
    if(!fp_g1){
        printf("Can not open golden file!\n");
    }

    for (x = 0; x < 3 * out_width * out_height; x++) {
        fread(&frameGolden_1[x], sizeof(uint16_t), 1, fp_g1);
    }
    printf("\tEnvironment set up!\n");

    //Execution
    crop(topParam, crop_param, y_src, u_src, v_src, y_dst, u_dst, v_dst);
    printf("\tExecution completed!\n");
    printf("\t%d\n",y_dst.size());
    printf("\t%d\n",u_dst.size());
    printf("\t%d\n",v_dst.size());

    //Out
    FILE *fp_w1 = fopen(CROP_DST1, "w");
    if(!fp_w1){
        printf("\tCan not open write back file!\n");
    }

    for (x = 0; x < 3 * out_width * out_height; x++) {
        if(x < out_width * out_height)
        {
            y_out_data = y_dst.read();
            frameOut_1[x] = y_out_data;
        }
        else if(x < 2 * out_width * out_height)
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

    fwrite(frameOut_1, sizeof(uint16_t), (3 * out_width * out_height), fp_w1);

    //Checker
    for (x = 0; x < 3 * out_width * out_height; x++) {
        if(frameGolden_1[x] != frameOut_1[x]) {
            printf("\t\tFirst mismatch in pixel %d, channel %d!\n", x/3, x%3);
            cout << "Golden = " << setbase(16) << frameGolden_1[x] << endl;
            cout << "result = " << setbase(16) << frameOut_1[x] << endl;
            exit(0);
        }
    }
    printf("\tTest passed!\n");

    fclose(fp_r1);
    fclose(fp_g1);
    fclose(fp_w1);

    return 0;
}

