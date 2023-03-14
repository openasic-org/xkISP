#include"dpc.h"
uint12 dpc_clip(int16 a, int lower, int upper) {
    uint12 result;
    if (a < lower)
        result = lower;
    else if (a > upper)
        result = upper;
    else
        result = a;
    return result;
};

uint12 medianFilter(uint12 arr_ori[8], uint12 arr_sort[8]){
    uint12 item;
    uint12 t; //tmp value
    uint13 result;
    MF_outer:for (int6 i = 0; i < 8; i++)
    {
        item = arr_ori[i];

        MF_inter:for (int6 j = 7; j >= 0; j--) {
            t = (j > i) ? (arr_sort[j]) : ((j > 0 && arr_sort[j - 1] > item) ? (arr_sort[j - 1]) : (item));
            item = (j > i) ? (item) : ((j > 0 && arr_sort[j - 1] > item) ? (item) : (arr_sort[j - 1]));
            /*
            if (j > i) {
                t = arr_sort[j];
            }
            else if (j > 0 && arr_sort[j - 1] > item)
            {
                t = arr_sort[j - 1];
            }
            else
            {
                t = item;
                if (j > 0)
                    item = arr_sort[j - 1];
            }*/
            arr_sort[j] = t;
        }

    }

    result = (arr_sort[3] + arr_sort[4]) >> 1;
    return result;
}

bool defectPixelDetection(uint12 arr_ori[8], uint12 pixel, uint11 th_w, uint11 th_b){
    int12 th_1 = th_w;
    int12 th_2 = -th_b;

    int13 diff_0;
    int13 diff_1;
    int13 diff_2;
    int13 diff_3;
    int13 diff_4;
    int13 diff_5;
    int13 diff_6;
    int13 diff_7;

    bool rst;

    diff_0 = arr_ori[0] - pixel;
    diff_1 = arr_ori[1] - pixel;
    diff_2 = arr_ori[2] - pixel;
    diff_3 = arr_ori[3] - pixel;
    diff_4 = arr_ori[4] - pixel;
    diff_5 = arr_ori[5] - pixel;
    diff_6 = arr_ori[6] - pixel;
    diff_7 = arr_ori[7] - pixel;

    if (diff_0 < th_2 && diff_1 < th_2 && diff_2 < th_2 && diff_3 < th_2 && diff_4 < th_2 && diff_5 < th_2 && diff_6 < th_2 && diff_7 < th_2) {
        rst = 1; //defect pixel, black defect pixl
    }
    else if(diff_0 > th_1 && diff_1 > th_1 && diff_2 > th_1 && diff_3 > th_1 && diff_4 > th_1 && diff_5 > th_1 && diff_6 > th_1 && diff_7 > th_1)
    {
        rst = 1; //defect pixel, white defect pixel
    }
    else
    {
        rst = 0; //right pixel
    }

    return rst;
}

void dpc(top_register top_reg, dpc_register dpc_reg, stream_u12& src, stream_u12& dst){
    uint12 srcData;
    uint12 dstData;
    uint12 rawWindow[5][5] = {0};

    uint12 pixel;
    uint12 arr_ori[8] = {0};
    uint12 arr_sort[8] = {0};
    bool flag;
    uint11 th_w = dpc_reg.th_w;
    uint11 th_b = dpc_reg.th_b;

    uint12 lineBuffer[4][8192];

    int n_n = 0;

    dpc_loop_out:for(uint13 row = 0; row < top_reg.frameHeight; row++){
        dpc_loop_in:for(uint13 col = 0; col < top_reg.frameWidth; col++){
            srcData = src.read();
            if(dpc_reg.eb == 1){
                rawWin_loop:for(uint3 i = 0; i < 5; i++){
                    rawWindow[i][0] = rawWindow[i][1];
                    rawWindow[i][1] = rawWindow[i][2];
                    rawWindow[i][2] = rawWindow[i][3];
                    rawWindow[i][3] = rawWindow[i][4];
                }

                rawWindow_read:for(uint3 i = 0; i < 4; i++){
                    rawWindow[i][4] = lineBuffer[i][col];

                }

                rawWindow[4][4] = srcData;

                line_write:for(uint3 i = 0; i < 4; i++){
                    lineBuffer[i][col] = rawWindow[i+1][4];

                }

                if((row > 3)&&(col > 3)){
                    uint2 bayerPattern = (((row & 1) << 1) + (col & 1))^top_reg.imgPattern;
                    pixel = rawWindow[2][2];

                    if(bayerPattern == 0 || bayerPattern == 3){
                        arr_ori[0] = rawWindow[0][0];
                        arr_ori[1] = rawWindow[0][2];
                        arr_ori[2] = rawWindow[0][4];
                        arr_ori[3] = rawWindow[2][0];
                        arr_ori[4] = rawWindow[2][4];
                        arr_ori[5] = rawWindow[4][0];
                        arr_ori[6] = rawWindow[4][2];
                        arr_ori[7] = rawWindow[4][4];

                        flag = defectPixelDetection(arr_ori, pixel, th_w, th_b);
                        if(flag == 1){
                            dstData = medianFilter(arr_ori, arr_sort);
                        }
                        else{
                            dstData = pixel;
                        }
                    }
                    else{
                        arr_ori[0] = rawWindow[0][2];
                        arr_ori[1] = rawWindow[1][1];
                        arr_ori[2] = rawWindow[1][3];
                        arr_ori[3] = rawWindow[2][0];
                        arr_ori[4] = rawWindow[2][4];
                        arr_ori[5] = rawWindow[3][1];
                        arr_ori[6] = rawWindow[3][3];
                        arr_ori[7] = rawWindow[4][2];

                        flag = defectPixelDetection(arr_ori, pixel, th_w, th_b);
                        if(flag == 1){
                            dstData = medianFilter(arr_ori, arr_sort);
                        }
                        else{
                            dstData = pixel;
                        }
                    }
                }
                else{
                    dstData = 0;
                }
                #ifdef DEBUG
                if((row == top_reg.ROW_TEST + 2) && (col == top_reg.COL_TEST + 2)) {
                    printf("\t dpc_in = %d\n",srcData.to_int());
                    printf("\t dpc_out = %d\n",dstData.to_int());
                    printf("\t%d\t%d\n",row.to_int(),col.to_int());
                    printf("\t%d\t%d\t%d\t%d\t%d\n",rawWindow[0][0].to_int(),rawWindow[0][1].to_int(),rawWindow[0][2].to_int(),rawWindow[0][3].to_int(),rawWindow[0][4].to_int());
                    printf("\t%d\t%d\t%d\t%d\t%d\n",rawWindow[1][0].to_int(),rawWindow[1][1].to_int(),rawWindow[1][2].to_int(),rawWindow[1][3].to_int(),rawWindow[1][4].to_int());
                    printf("\t%d\t%d\t%d\t%d\t%d\n",rawWindow[2][0].to_int(),rawWindow[2][1].to_int(),rawWindow[2][2].to_int(),rawWindow[2][3].to_int(),rawWindow[2][4].to_int());
                    printf("\t%d\t%d\t%d\t%d\t%d\n",rawWindow[3][0].to_int(),rawWindow[3][1].to_int(),rawWindow[3][2].to_int(),rawWindow[3][3].to_int(),rawWindow[3][4].to_int());
                    printf("\t%d\t%d\t%d\t%d\t%d\n",rawWindow[4][0].to_int(),rawWindow[4][1].to_int(),rawWindow[4][2].to_int(),rawWindow[4][3].to_int(),rawWindow[4][4].to_int());
                }
                #endif
            }
            else
            {
                dstData = srcData;
            }
            if((row > 2) || ((row==2) && (col > 1))){
                dst.write(dstData);
            }
        }
    }

    addon_loop:for (uint14 cnt = 0; cnt < 2*top_reg.frameWidth + 2; cnt++){
        dst.write(0);
    }
};
