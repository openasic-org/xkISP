#include "gb.h"

inline uint12 abs(uint12 rawData_1 , uint12 rawData_2)
{
    return rawData_1 >= rawData_2 ? rawData_1 - rawData_2 : rawData_2 - rawData_1;
}

inline uint12 clip(int31 result)
{
    if(result < 0)
        return 0;
    else if(result > 4095)
        return 4095;
    else
        return (uint12)result;
}

void greenbalance2(top_register top_reg, gb_register gb_reg, stream_u12& src, stream_u12& dst)
{
    uint12 pixel_in;
    uint12 pixel_out;
    uint12 gb_lines[6][8192];

    uint12 temp[5];
    uint12 gb_block[7][7];
    uint12 left_block[4][4];
    uint12 right_block[4][4];
    uint13  index_i, index_j;

    uint13 row, col, i, j;
    uint3  k, l;

    bool   bIfRBpixel;
    bool   bGreen;

    bGreen = ((top_reg.imgPattern >> 1) ^ (top_reg.imgPattern & 1));
    row_loop:for (row = 0; row < top_reg.frameHeight; row++) {
        col_loop:for (col = 0; col < top_reg.frameWidth; col++) {

            pixel_in = src.read();
            if (gb_reg.eb)
            {
                out_window_loop:for (k = 0; k < 7; k++) {
                    in_window_loop:for (l = 0; l < 6; l++) {
                        gb_block[k][l] = gb_block[k][l + 1];
                    }
                }

                line_feed_loop:for (k = 0; k < 6; k++) {
                    gb_block[k][6] = gb_lines[k][col];
                }

                gb_block[6][6] = pixel_in;

                lines_write_loop:for (k = 0; k < 6; k++) {
                    gb_lines[k][col] = gb_block[k + 1][6];
                }

                if((row > 5) && (col> 5))
                {
                    bIfRBpixel = (((row + col - 6) & 1) == 0 ) ^ bGreen;
                    uint4 low_num = gb_reg.Lbound;
                    uint6 high_num = gb_reg.Hbound;
                    uint10 thre = gb_reg.threhold;

                    bool flag = 0;
                    int31 sum_total = 0;
                    int31 sum_total_1 = 0;
                    int31 sum_total_2 = 0;
                    int31 sum_temp_1;
                    int31 sum_temp_2;
                    uint12 temp_value;
                    int31 sum_total_temp[12] = {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0};
                    uint6 count_total = 0;
                    uint6 count_total_temp[12] = {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0};

                    const uint6 Lut[32]={51,43,37,32,28,26,23,21,20,18,17,16,15,14,13,13,12,12,11,11,10,10,9,9,9,9,8,8,8,8,7,7};

                    uint6 Lut_value = 0;

                    uint4 i,j;

                    block_loop1: for (i = 0; i < 4; i++) {
                        block_loop2: for (j = 0; j < 4; j++) {
                            index_i = (2 * i + 1) > 6 ? uint13(6) : uint13(2 * i + 1);
                            index_j = (2 * j + 1) > 6 ? uint13(6) : uint13(2 * j + 1);
                            left_block[i][j] = bIfRBpixel ? gb_block[index_i][2 * j] : gb_block[index_i][index_j];
                            right_block[i][j] = bIfRBpixel ? gb_block[2 * i][index_j] : gb_block[2 * i][2 * j];
                        }
                    }
                    if(bIfRBpixel){
                        begin_end_loop: for (i = 0; i < 3; i++) {
                            sum_total_temp[4 * i] = ((abs(left_block[i][0],right_block[i][0]) < gb_reg.threhold) ? int13(left_block[i][0] - right_block[i][0]) : int13(0))
                                                  + ((abs(left_block[i][0],right_block[i+1][0]) < gb_reg.threhold) ? int13(left_block[i][0] - right_block[i+1][0]) : int13(0));
                            count_total_temp[4 * i] = (abs(left_block[i][0],right_block[i][0]) < gb_reg.threhold)
                                                  + (abs(left_block[i][0],right_block[i+1][0]) < gb_reg.threhold);
                            sum_total_temp[4 * i + 3] = ((abs(left_block[i][3],right_block[i][2]) < gb_reg.threhold) ? int13(left_block[i][3] - right_block[i][2]) : int13(0))
                                                  + ((abs(left_block[i][3],right_block[i+1][2]) < gb_reg.threhold) ? int13(left_block[i][3] - right_block[i+1][2]) : int13(0));
                            count_total_temp[4 * i + 3] = (abs(left_block[i][3],right_block[i][2]) < gb_reg.threhold)
                                                  + (abs(left_block[i][3],right_block[i+1][2]) < gb_reg.threhold);
                        }
                        sawtooth_loop_1: for (i = 0; i < 3; i++) {
                            sawtooth_loop_2: for (j = 1; j < 3; j ++) {
                                sum_total_temp[4 * i + j] = ((abs(left_block[i][j],right_block[i][j-1]) < gb_reg.threhold) ? int13(left_block[i][j] - right_block[i][j-1]) : int13(0))
                                                          + ((abs(left_block[i][j],right_block[i][j]) < gb_reg.threhold) ? int13(left_block[i][j] - right_block[i][j]) : int13(0))
                                                          + ((abs(left_block[i][j],right_block[i+1][j-1]) < gb_reg.threhold) ? int13(left_block[i][j] - right_block[i+1][j-1]) : int13(0))
                                                          + ((abs(left_block[i][j],right_block[i+1][j]) < gb_reg.threhold) ? int13(left_block[i][j] - right_block[i+1][j]) : int13(0));
                                count_total_temp[4 * i + j] = (abs(left_block[i][j],right_block[i][j-1]) < gb_reg.threhold)
                                                          + (abs(left_block[i][j],right_block[i][j]) < gb_reg.threhold)
                                                          + (abs(left_block[i][j],right_block[i+1][j-1]) < gb_reg.threhold)
                                                          + (abs(left_block[i][j],right_block[i+1][j]) < gb_reg.threhold);
                            }
                        }
                    }
                    else{
                        sawtooth2_loop_1: for (i = 0; i < 3; i++) {
                            sawtooth2_loop_2: for (j = 0; j < 3; j ++) {
                                 sum_total_temp[4 * i + j] = ((abs(left_block[i][j],right_block[i][j]) < gb_reg.threhold) ? int13(left_block[i][j] - right_block[i][j]) : int13(0))
                                                          + ((abs(left_block[i][j],right_block[i][j+1]) < gb_reg.threhold) ? int13(left_block[i][j] - right_block[i][j+1]) : int13(0))
                                                          + ((abs(left_block[i][j],right_block[i+1][j]) < gb_reg.threhold) ? int13(left_block[i][j] - right_block[i+1][j]) : int13(0))
                                                          + ((abs(left_block[i][j],right_block[i+1][j+1]) < gb_reg.threhold) ? int13(left_block[i][j] - right_block[i+1][j+1]) : int13(0));
                                count_total_temp[4 * i + j] = (abs(left_block[i][j],right_block[i][j]) < gb_reg.threhold)
                                                          + (abs(left_block[i][j],right_block[i][j+1]) < gb_reg.threhold)
                                                          + (abs(left_block[i][j],right_block[i+1][j]) < gb_reg.threhold)
                                                          + (abs(left_block[i][j],right_block[i+1][j+1]) < gb_reg.threhold);
                            }
                        }
                    }

                    sum_total = sum_total_temp[0] + sum_total_temp[1] + sum_total_temp[2] + sum_total_temp[3] + sum_total_temp[4] + sum_total_temp[5] + sum_total_temp[6] + sum_total_temp[7] + sum_total_temp[8] + sum_total_temp[9] + sum_total_temp[10] + sum_total_temp[11];
                    count_total = count_total_temp[0] + count_total_temp[1] + count_total_temp[2] + count_total_temp[3] + count_total_temp[4] + count_total_temp[5] + count_total_temp[6] + count_total_temp[7] + count_total_temp[8] + count_total_temp[9] + count_total_temp[10] + count_total_temp[11];

                    Lut_value = Lut[count_total - 5];
                    sum_temp_1 = (sum_total >= 0) ? int37((sum_total * Lut_value)>>8) : int37(~(((~sum_total + 1) * Lut_value) >> 8) + 1);
                    sum_temp_2 = (sum_total >= 0) ? int46((((count_total - low_num) * sum_total * Lut_value>>8) + 8) / 16) : int46(~((((count_total - low_num) * (~sum_total + 1) * Lut_value >> 8) + 8) / 16) + 1);
                    sum_total_1 = (count_total < low_num) ? int31(0) : \
                                ((count_total >= high_num) ? int31(sum_temp_1) : int31(sum_temp_2));
                    sum_total_2 = sum_total_1 >> 1;
                    temp_value = gb_block[3][3];
                    pixel_out = clip((int31)temp_value - sum_total_2);
                }
                else
                {
                    pixel_out = gb_block[3][3];
                }

                if ((row > 3) || ((row == 3) && (col > 2)))
                {
                    dst.write(pixel_out);
                }
            }
            else
            {
                pixel_out = pixel_in;
                dst.write(pixel_out);
            }
            #ifdef DEBUG
            if((row == ROW_TEST + 3) && (col == COL_TEST + 3)) {
                printf("\t%x\t%x\n",row.to_int(),col.to_int());
                printf("\t%x\t%x\t%x\t%x\t%x\t%x\t%x\n",gb_block[0][0].to_int(),gb_block[0][1].to_int(),gb_block[0][2].to_int(),gb_block[0][3].to_int(),gb_block[0][4].to_int(),gb_block[0][5].to_int(),gb_block[0][6].to_int());
                printf("\t%x\t%x\t%x\t%x\t%x\t%x\t%x\n",gb_block[1][0].to_int(),gb_block[1][1].to_int(),gb_block[1][2].to_int(),gb_block[1][3].to_int(),gb_block[1][4].to_int(),gb_block[1][5].to_int(),gb_block[1][6].to_int());
                printf("\t%x\t%x\t%x\t%x\t%x\t%x\t%x\n",gb_block[2][0].to_int(),gb_block[2][1].to_int(),gb_block[2][2].to_int(),gb_block[2][3].to_int(),gb_block[2][4].to_int(),gb_block[2][5].to_int(),gb_block[3][6].to_int());
                printf("\t%x\t%x\t%x\t%x\t%x\t%x\t%x\n",gb_block[3][0].to_int(),gb_block[3][1].to_int(),gb_block[3][2].to_int(),gb_block[3][3].to_int(),gb_block[3][4].to_int(),gb_block[3][5].to_int(),gb_block[3][6].to_int());
                printf("\t%x\t%x\t%x\t%x\t%x\t%x\t%x\n",gb_block[4][0].to_int(),gb_block[4][1].to_int(),gb_block[4][2].to_int(),gb_block[4][3].to_int(),gb_block[4][4].to_int(),gb_block[4][5].to_int(),gb_block[4][6].to_int());
                printf("\t%x\t%x\t%x\t%x\t%x\t%x\t%x\n",gb_block[5][0].to_int(),gb_block[5][1].to_int(),gb_block[5][2].to_int(),gb_block[5][3].to_int(),gb_block[5][4].to_int(),gb_block[5][5].to_int(),gb_block[5][6].to_int());
                printf("\t%x\t%x\t%x\t%x\t%x\t%x\t%x\n",gb_block[6][0].to_int(),gb_block[6][1].to_int(),gb_block[6][2].to_int(),gb_block[6][3].to_int(),gb_block[6][4].to_int(),gb_block[6][5].to_int(),gb_block[6][6].to_int());
                printf("\t%x\t%x\n",pixel_in.to_int(), pixel_out.to_int());
            }
            #endif
        }
    }

    uint12 dst_temp;
    if (gb_reg.eb)
    {
        greenbalance2_label0:for (k = 0;k < 3;k++){
            dst.write(gb_block[3][k+4]);
        }

       padding_outer_loop:for (k = 0;k < 3;k++){
            padding_inter_loop:for(i = 0;i < top_reg.frameWidth;i++){
                dst_temp = gb_lines[k+3][i];
                dst.write(dst_temp);
            }
       }
    }
}
