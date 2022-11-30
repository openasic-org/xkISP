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

    topParam.frameWidth = 640;
    topParam.frameHeight = 480;
    uint13 out_width_1 = topParam.frameWidth;
    uint13 out_height_1 = topParam.frameHeight;
    scaledown_param.times = 2;
    uint13 out_width_2 = topParam.frameWidth / scaledown_param.times;
    uint13 out_height_2 = topParam.frameHeight / scaledown_param.times;
    scaledown_param.times = 4;
    uint13 out_width_3 = topParam.frameWidth / scaledown_param.times;
    uint13 out_height_3 = topParam.frameHeight / scaledown_param.times;

    int img_size = topParam.frameWidth * topParam.frameHeight;

    uint16_t frameIn_1[3 * img_size];
    uint16_t frameGolden_1[3 * img_size];
    uint16_t frameOut_1[3 * img_size];

    scaledown_param.m_nEb = 0;

    //In
    FILE *fp_r1 = fopen(scaledown_SRC1, "r");
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
    FILE *fp_g1 = fopen(scaledown_GOLDEN1, "r");
    if(!fp_g1){
        printf("Can not open golden file!\n");
    }

    for (x = 0; x < 3 * out_width_1 * out_height_1; x++) {
        fread(&frameGolden_1[x], sizeof(uint16_t), 1, fp_g1);
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

    for (x = 0; x < 3 * out_width_1 * out_height_1; x++) {
        if(x < out_width_1 * out_height_1)
        {
            y_out_data = y_dst.read();
            frameOut_1[x] = y_out_data;
        }
        else if(x < 2 * out_width_1 * out_height_1)
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

    fwrite(frameOut_1, sizeof(uint16_t), (3 * out_width_1 * out_height_1), fp_w1);

    //Checker
    for (x = 0; x < 3 * out_width_1 * out_height_1; x++) {
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
