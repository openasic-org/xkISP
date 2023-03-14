#include "afc.h"

int17 abs_afc(int a, int b) {
    int17 result;
    if(a >= b)
        result = a - b;
    else
        result = b - a;
    return result;
}

void afc(top_register top_reg, afc_register& afc_reg, stream_u12 &src, stream_u12 &dst){
    uint12 srcData;

    uint13 afc_location_row;
    uint13 afc_location_col;
    uint13 afc_left;
    uint13 afc_right;
    uint13 afc_up;
    uint13 afc_down;

    if(afc_reg.location_row < 64){
        afc_location_row = 64;
    }
    else if(afc_reg.location_col > top_reg.frameHeight - 1 - 64){
        afc_location_row = top_reg.frameHeight - 1 - 64;
    }
    else{
        afc_location_row = afc_reg.location_row;
    }

    if(afc_reg.location_col < 64){
        afc_location_col = 64;
    }
    else if(afc_reg.location_col > top_reg.frameWidth - 1 - 64){
        afc_location_col = top_reg.frameWidth - 1 - 64;
    }
    else {
        afc_location_col = afc_reg.location_col;
    }

    afc_left = afc_location_col - 64;
    afc_right = afc_location_col + 64;
    afc_up = afc_location_row - 64;
    afc_down = afc_location_row + 64;

    uint12 lineBuffer[8][8192];
    uint12 rawWindow[9][9];
    int17  raw_int[9][9];

    // fv1
    int17 sobel_h_tab[3][3] = {{ 1,  2,  1},
                             { 0,  0,  0},
                             {-1, -2, -1}};

    int17 sobel_v_tab[3][3] = {{ 1,  0, -1},
                             { 2,  0, -2},
                             { 1,  0, -1}};

    int17 laplace_tab[5][5] = {{-1, 0, -1, 0, -1},
                             { 0, 0,  0, 0,  0},
                             {-1, 0,  8, 0, -1},
                             { 0, 0,  0, 0,  0},
                             {-1, 0, -1, 0, -1}};

    int17 H5[5] = {-2, -3, -3, 3, 10};

    int17 H5_tab[9][9] = {{H5[0], 0,     0, 0, H5[0], 0,     0, 0, H5[4]},
                        {    0, 0,     0, 0,     0, 0,     0, 0,     0},
                        {    0, 0, H5[1], 0, H5[1], 0, H5[1], 0,     0},
                        {    0, 0,     0, 0,     0, 0,     0, 0,     0},
                        {H5[0], 0, H5[1], 0, H5[2], 0, H5[3], 0, H5[4]},
                        {    0, 0,     0, 0,     0, 0,     0, 0,     0},
                        {    0, 0, H5[3], 0, H5[3], 0, H5[3], 0,     0},
                        {    0, 0,     0, 0,     0, 0,     0, 0,     0},
                        {H5[0], 0,     0, 0, H5[4], 0,     0, 0, H5[4]}};

    int17 sobel_h_cal = 0;
    int17 sobel_v_cal = 0;
    int17 sobel_cal = 0;
    int17 laplace_cal = 0;
    int17 H5_cal = 0;
    int17 H_sobel = 0;
    int5 WHF = 0;
    uint17 CountHF = 0;
    uint30 SumHF = 0;

    // fv2
    int17 H9[7] = {-2, -3, -3, 3, 10, 3, -3};

    int20 IIRH_1 = 0;
    int20 IIRH_2 = 0;
    int20 IIRV_1 = 0;
    int20 IIRV_2 = 0;
    int22 H9_cal = 0;
    int5 WMF = 0;
    int17 CountMF = 0;
    int32 SumMF = 0;
    uint20 cnt = 0;
    afc_row: for (uint13 row = 0; row < top_reg.frameHeight; row++){
        afc_col: for (uint13 col = 0; col < top_reg.frameWidth; col++){
            srcData = src.read();
            dst.write(srcData);
            if(afc_reg.eb == 1){
                rawWin_loop:for(uint4 i = 0; i < 9; i++){
                    rawWindow[i][0] = rawWindow[i][1];
                    rawWindow[i][1] = rawWindow[i][2];
                    rawWindow[i][2] = rawWindow[i][3];
                    rawWindow[i][3] = rawWindow[i][4];
                    rawWindow[i][4] = rawWindow[i][5];
                    rawWindow[i][5] = rawWindow[i][6];
                    rawWindow[i][6] = rawWindow[i][7];
                    rawWindow[i][7] = rawWindow[i][8];
                }

                rawWindow_read:for(uint4 i = 0; i < 8; i++){
                    rawWindow[i][8] = lineBuffer[i][col];
                }

                rawWindow[8][8] = srcData;

                line_write:for(uint4 i = 0; i < 8; i++){
                    lineBuffer[i][col] = rawWindow[i+1][8];
                }

                raw_int_read_row: for (uint4 i = 0; i < 9; i++){
                    raw_int_read_col: for (uint4 j = 0; j < 9; j++){
                        raw_int[i][j] = rawWindow[i][j];
                    }
                }

                if(((row >= afc_up + 8) && (col >= afc_left + 8)) && ((row <= afc_down) && (col <= afc_right))){
                    // fv1
                    cnt = cnt + 1;
                    loop_sobel_1: for (uint3 x = 0; x < 3; x++){
                        loop_sobel_2: for (uint3 y = 0; y < 3; y++){
                            sobel_h_cal = sobel_h_cal + sobel_h_tab[x][y] * raw_int[3 + x][3 + y];
                            sobel_v_cal = sobel_v_cal + sobel_v_tab[x][y] * raw_int[3 + x][3 + y];
                        }
                    }

                    sobel_cal = abs_afc(sobel_h_cal, 0) + abs_afc(sobel_v_cal, 0);

                    loop_laplace_1: for (uint3 x = 0; x < 5; x++){
                        loop_laplace_2: for (uint3 y = 0; y < 5; y++){
                            laplace_cal = laplace_cal + laplace_tab[x][y] * raw_int[2 + x][2 + y];
                        }
                    }

                    loop_H5_1: for (uint4 x = 0; x < 9; x++){
                        loop_H5_2: for (uint4 y = 0; y < 9; y++){
                            if(x == 4 && y == 4){
                                H5_cal = H5_cal + (H5_tab[4][4] * raw_int[4][4] >> 1);
                            }
                            else {
                                H5_cal = H5_cal + (H5_tab[x][y] * raw_int[x][y] >> 3);
                            }
                        }
                    }

                    H_sobel = ((sobel_cal + laplace_cal) >> 2) + (H5_cal >> 1);

                    if(afc_reg.m_bIfHardThreshold == 0){
                        if(H_sobel < afc_reg.ThrList[0]){
                            WHF = 0;
                        }
                        else if(afc_reg.ThrList[0] <= H_sobel < afc_reg.ThrList[1]){
                            WHF = 1;
                        }
                        else if(afc_reg.ThrList[1] <= H_sobel < afc_reg.ThrList[2]){
                            WHF = 2;
                        }
                        else if(afc_reg.ThrList[2] <= H_sobel < afc_reg.ThrList[3]){
                            WHF = 3;
                        }
                        else if(afc_reg.ThrList[3] <= H_sobel < afc_reg.ThrList[4]){
                            WHF = 4;
                        }
                        else if(afc_reg.ThrList[4] <= H_sobel < afc_reg.ThrList[5]){
                            WHF = 5;
                        }
                        else if(afc_reg.ThrList[5] <= H_sobel < afc_reg.ThrList[6]){
                            WHF = 6;
                        }
                        else if(afc_reg.ThrList[6] <= H_sobel < afc_reg.ThrList[7]){
                            WHF = 7;
                        }
                        else{
                            WHF = 8;
                        }
                    }
                    else {
                        if(H_sobel <= afc_reg.T) {
                            WHF = 0;
                        }
                        else {
                            WHF = 1;
                        }
                    }

                    CountHF = CountHF + WHF;
                    SumHF = SumHF + H_sobel * WHF;

                    #ifdef DEBUG
                    if(row == (ROW_TEST + 4) && col == (COL_TEST + 4)){
                        printf("window 9x9\n");
                        printf("src = %d\n", srcData.to_uint());
                        printf("src = %d\n", rawWindow[8][8].to_uint());
                        printf("%d\t%d\t%d\t%d\t%d\t%d\t%d\t%d\t%d\t\n", raw_int[0][0].to_int(),rawWindow[0][1].to_uint(),rawWindow[0][2].to_uint(),rawWindow[0][3].to_uint(),rawWindow[0][4].to_uint(),rawWindow[0][5].to_uint(),rawWindow[0][6].to_uint(),rawWindow[0][7].to_uint(),rawWindow[0][8].to_uint());
                        printf("%d\t%d\t%d\t%d\t%d\t%d\t%d\t%d\t%d\t\n", rawWindow[1][0].to_uint(),rawWindow[1][1].to_uint(),rawWindow[1][2].to_uint(),rawWindow[1][3].to_uint(),rawWindow[1][4].to_uint(),rawWindow[1][5].to_uint(),rawWindow[1][6].to_uint(),rawWindow[1][7].to_uint(),rawWindow[1][8].to_uint());
                        printf("%d\t%d\t%d\t%d\t%d\t%d\t%d\t%d\t%d\t\n", rawWindow[2][0].to_uint(),rawWindow[2][1].to_uint(),rawWindow[2][2].to_uint(),rawWindow[2][3].to_uint(),rawWindow[2][4].to_uint(),rawWindow[2][5].to_uint(),rawWindow[2][6].to_uint(),rawWindow[2][7].to_uint(),rawWindow[2][8].to_uint());
                        printf("%d\t%d\t%d\t%d\t%d\t%d\t%d\t%d\t%d\t\n", rawWindow[3][0].to_uint(),rawWindow[3][1].to_uint(),rawWindow[3][2].to_uint(),rawWindow[3][3].to_uint(),rawWindow[3][4].to_uint(),rawWindow[3][5].to_uint(),rawWindow[3][6].to_uint(),rawWindow[3][7].to_uint(),rawWindow[3][8].to_uint());
                        printf("%d\t%d\t%d\t%d\t%d\t%d\t%d\t%d\t%d\t\n", rawWindow[4][0].to_uint(),rawWindow[4][1].to_uint(),rawWindow[4][2].to_uint(),rawWindow[4][3].to_uint(),rawWindow[4][4].to_uint(),rawWindow[4][5].to_uint(),rawWindow[4][6].to_uint(),rawWindow[4][7].to_uint(),rawWindow[4][8].to_uint());
                        printf("%d\t%d\t%d\t%d\t%d\t%d\t%d\t%d\t%d\t\n", rawWindow[5][0].to_uint(),rawWindow[5][1].to_uint(),rawWindow[5][2].to_uint(),rawWindow[5][3].to_uint(),rawWindow[5][4].to_uint(),rawWindow[5][5].to_uint(),rawWindow[5][6].to_uint(),rawWindow[5][7].to_uint(),rawWindow[5][8].to_uint());
                        printf("%d\t%d\t%d\t%d\t%d\t%d\t%d\t%d\t%d\t\n", rawWindow[6][0].to_uint(),rawWindow[6][1].to_uint(),rawWindow[6][2].to_uint(),rawWindow[6][3].to_uint(),rawWindow[6][4].to_uint(),rawWindow[6][5].to_uint(),rawWindow[6][6].to_uint(),rawWindow[6][7].to_uint(),rawWindow[6][8].to_uint());
                        printf("%d\t%d\t%d\t%d\t%d\t%d\t%d\t%d\t%d\t\n", rawWindow[7][0].to_uint(),rawWindow[7][1].to_uint(),rawWindow[7][2].to_uint(),rawWindow[7][3].to_uint(),rawWindow[7][4].to_uint(),rawWindow[7][5].to_uint(),rawWindow[7][6].to_uint(),rawWindow[7][7].to_uint(),rawWindow[7][8].to_uint());
                        printf("%d\t%d\t%d\t%d\t%d\t%d\t%d\t%d\t%d\t\n", rawWindow[8][0].to_uint(),rawWindow[8][1].to_uint(),rawWindow[8][2].to_uint(),rawWindow[8][3].to_uint(),rawWindow[8][4].to_uint(),rawWindow[8][5].to_uint(),rawWindow[8][6].to_uint(),rawWindow[8][7].to_uint(),rawWindow[8][8].to_uint());
                        printf("\n");
                        printf("sobel_h_cal = %d\n", sobel_h_cal.to_int());
                        printf("sobel_v_cal = %d\n", sobel_v_cal.to_int());
                        printf("sobel_cal = %d", sobel_cal.to_int());
                        printf("laplace_cal = %d\n", laplace_cal.to_int());
                        printf("H5_cal = %d\n", H5_cal.to_uint());
                        printf("H_sobel = %d\n", H_sobel.to_uint());
                        //printf("afc_left = %d, afc_right = %d, afc_up = %d, afc_down = %d\n", afc_left.to_uint(), afc_right.to_uint(), afc_up.to_uint(), afc_down.to_uint());
                    }
                    #endif

                    sobel_h_cal = 0;
                    sobel_v_cal = 0;
                    sobel_cal = 0;
                    laplace_cal = 0;
                    H5_cal = 0;
                    H_sobel = 0;
                    WHF = 0;

                    // fv2
                    loop_IIRH1: for (uint4 x = 0; x < 7; x++){
                        IIRH_1 = IIRH_1 + (H9[x] * (raw_int[4][x] + raw_int[4][1 + x]
                                        + raw_int[5][x] + raw_int[5][1 + x]) >> 2);
                        IIRV_1 = IIRV_1 + (H9[x] * (raw_int[x][4] + raw_int[x][5]
                                        + raw_int[1 + x][4] + raw_int[1 + x][5]) >> 2);
                    }

                    loop_IIRH2_1: for (uint4 x = 0; x < 7; x = x + 2){
                        IIRH_2 = IIRH_2 + (H9[x] * (raw_int[3][1 + x] + raw_int[4][x]
                                        + raw_int[5][1 + x] + raw_int[4][2 + x]) >> 2);
                        IIRV_2 = IIRV_2 + (H9[x] * (raw_int[x][4] + raw_int[1 + x][3]
                                        + raw_int[1 + x][5] + raw_int[2 + x][4]) >> 2);
                    }

                    loop_IIRH2_2: for (uint4 x = 1; x < 6; x = x + 2) {
                        IIRH_2 = IIRH_2 + (H9[x] * raw_int[3][1 + x] >> 3) + (H9[x] * raw_int[3][3 + x] >> 3)
                                        + (H9[x] * raw_int[5][1 + x] >> 3) + (H9[x] * raw_int[5][3 + x] >> 3)
                                        + (H9[x] * raw_int[4][2 + x] >> 1);
                        IIRV_2 = IIRV_2 + (H9[x] * raw_int[1 + x][3] >> 3) + (H9[x] * raw_int[1 + x][5] >> 3)
                                        + (H9[x] * raw_int[3 + x][3] >> 3) + (H9[x] * raw_int[3 + x][5] >> 3)
                                        + (H9[x] * raw_int[2 + x][4] >> 1);
                    }

                    H9_cal = IIRH_1 + IIRH_2 + IIRV_1 + IIRH_2;

                    if(afc_reg.m_bIfHardThreshold == 0){
                        if(H9_cal < afc_reg.ThrList[0]){
                            WMF = 0;
                        }
                        else if(afc_reg.ThrList[0] <= H9_cal < afc_reg.ThrList[1]){
                            WMF = 1;
                        }
                        else if(afc_reg.ThrList[1] <= H9_cal < afc_reg.ThrList[2]){
                            WMF = 2;
                        }
                        else if(afc_reg.ThrList[2] <= H9_cal < afc_reg.ThrList[3]){
                            WMF = 3;
                        }
                        else if(afc_reg.ThrList[3] <= H9_cal < afc_reg.ThrList[4]){
                            WMF = 4;
                        }
                        else if(afc_reg.ThrList[4] <= H9_cal < afc_reg.ThrList[5]){
                            WMF = 5;
                        }
                        else if(afc_reg.ThrList[5] <= H9_cal < afc_reg.ThrList[6]){
                            WMF = 6;
                        }
                        else if(afc_reg.ThrList[6] <= H9_cal < afc_reg.ThrList[7]){
                            WMF = 7;
                        }
                        else{
                            WMF = 8;
                        }
                    }
                    else {
                        if(H9_cal <= afc_reg.T) {
                            WMF = 0;
                        }
                        else {
                            WMF = 1;
                        }
                    }

                    CountMF = CountMF + WMF;
                    SumMF = SumMF + H9_cal * WMF;

                    IIRH_1 = 0;
                    IIRH_2 = 0;
                    IIRV_1 = 0;
                    IIRV_2 = 0;
                    H9_cal = 0;
                    WMF = 0;
                }
            }
        }
    }
    if(afc_reg.eb == 1) {
        afc_reg.SumHF = SumHF;
        afc_reg.CountHF = (CountHF + 16) >> 5;
        afc_reg.SumMF = SumMF;
        afc_reg.CountMF = (CountMF + 16) >> 5;
    }
    else {
        afc_reg.SumHF = 100;
        afc_reg.CountHF = 100;
        afc_reg.SumMF = 100;
        afc_reg.CountMF = 100;
    }
    printf("SumHF = %d, CountHF = %d\n", afc_reg.SumHF.to_uint(), afc_reg.CountHF.to_uint());
    printf("SumMF = %d, CountMF = %d\n", afc_reg.SumMF.to_uint(), afc_reg.CountMF.to_uint());
}
