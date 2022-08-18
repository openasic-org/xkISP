#include "top.h"
typedef struct
{
    bool eb;
    uint4 win_size;
    uint4 Lbound;
    uint6 Hbound;
    uint10 threhold;
} gb_register;


inline uint12 abs(uint12 rawData_1 , uint12 rawData_2)
{
    if(rawData_1 >= rawData_2)
        return rawData_1 - rawData_2;
    else
        return rawData_2 - rawData_1;
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

uint12 ColumnStatistic(uint12 gb_block[7][7], bool IfRBpixel, gb_register& gb_reg)
{
     uint4 low_num = gb_reg.Lbound;
     uint6 high_num = gb_reg.Hbound;
     uint10 thre = gb_reg.threhold;

     bool flag = 0;
     int31 sum_total = 0;
     uint6 count_total = 0;

     const uint6 Lut[32]={51,43,37,32,28,26,23,21,20,18,17,16,15,14,13,13,12,12,11,11,10,10,9,9,9,9,8,8,8,8,7,7};

     uint6 Lut_value = 0;

     uint4 i,j;

     if(IfRBpixel)
     {
         sawtooth_loop_1:for (i = 1; i < 7; i += 2) {
             sawtooth_loop_2:for(j = 0; j < 8; j += 2)
             {
                 if(j == 0)
                 {
                     if(abs(gb_block[i][j],gb_block[i - 1][j + 1]) < gb_reg.threhold)
                     {
                         sum_total+=(gb_block[i][j] - gb_block[i - 1][j + 1]);
                         count_total++;
                     }
                     if(abs(gb_block[i][j],gb_block[i + 1][j + 1]) < gb_reg.threhold)
                     {
                         sum_total+=(gb_block[i][j] - gb_block[i + 1][j + 1]);
                         count_total++;
                     }
                 }

                 else if(j == 6)
                 {
                     if(abs(gb_block[i][j],gb_block[i - 1][j - 1]) < gb_reg.threhold)
                     {
                         sum_total+=(gb_block[i][j] - gb_block[i - 1][j - 1]);
                         count_total++;
                     }
                     if(abs(gb_block[i][j],gb_block[i + 1][j - 1]) < gb_reg.threhold)
                     {
                         sum_total+=(gb_block[i][j] - gb_block[i + 1][j - 1]);
                         count_total++;
                     }
                 }
                 else
                 {
                     if(abs(gb_block[i][j],gb_block[i - 1][j - 1]) < gb_reg.threhold)
                     {
                         sum_total+=(gb_block[i][j] - gb_block[i - 1][j - 1]);
                         count_total++;
                     }
                     if(abs(gb_block[i][j],gb_block[i + 1][j - 1]) < gb_reg.threhold)
                     {
                         sum_total+=(gb_block[i][j] - gb_block[i + 1][j - 1]);
                         count_total++;
                     }
                     if(abs(gb_block[i][j],gb_block[i - 1][j + 1]) < gb_reg.threhold)
                     {
                         sum_total+=(gb_block[i][j] - gb_block[i - 1][j + 1]);
                         count_total++;
                     }
                     if(abs(gb_block[i][j],gb_block[i + 1][j + 1]) < gb_reg.threhold)
                     {
                         sum_total+=(gb_block[i][j] - gb_block[i + 1][j + 1]);
                         count_total++;
                     }
                 }
             }
         }
     }
     else
     {
         sawtooth_loop_3:for (i = 1; i < 7; i += 2) {
             sawtooth_loop_4:for(j = 1; j < 7; j += 2)
             {
                 if(abs(gb_block[i][j],gb_block[i - 1][j - 1]) < gb_reg.threhold)
                 {
                     sum_total+=(gb_block[i][j] - gb_block[i - 1][j - 1]);
                     count_total++;
                 }
                 if(abs(gb_block[i][j],gb_block[i + 1][j - 1]) < gb_reg.threhold)
                 {
                     sum_total+=(gb_block[i][j] - gb_block[i + 1][j - 1]);
                     count_total++;
                 }
                 if(abs(gb_block[i][j],gb_block[i - 1][j + 1]) < gb_reg.threhold)
                 {
                     sum_total+=(gb_block[i][j] - gb_block[i - 1][j + 1]);
                     count_total++;
                 }
                 if(abs(gb_block[i][j],gb_block[i + 1][j + 1]) < gb_reg.threhold)
                 {
                     sum_total+=(gb_block[i][j] - gb_block[i + 1][j + 1]);
                     count_total++;
                  }
             }
         }
     }



     if (count_total < low_num)
     {
        sum_total = 0;
     }
     else if (count_total >= high_num)
     {
        Lut_value = Lut[count_total - 5];
        if(sum_total >= 0)
        {
            sum_total = (sum_total * Lut_value)>>8;
        }
        else
        {
            sum_total = ((~sum_total + 1) * Lut_value) >> 8;
            sum_total = ~sum_total + 1;
        }
     }
     else
     {
            Lut_value = Lut[count_total - 5];
            if(sum_total >= 0)
            {
                sum_total = (((count_total - low_num) * sum_total * Lut_value>>8) + 8) / 16;
            }
            else
            {
                sum_total = (((count_total - low_num) * (~sum_total + 1) * Lut_value >> 8) + 8) / 16;
                sum_total = ~sum_total + 1;
            }
     }
    sum_total = sum_total >> 1;
    return clip((int31)gb_block[3][3] - sum_total);
}



void greenbalance2(top_register top_reg, gb_register gb_reg, stream_u12& src, stream_u12& dst)
{
    uint12 pixel_in;
    uint12 pixel_out;
    uint12 gb_lines[6][8192];

    uint12 temp[5];
    uint12 gb_block[7][7];

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
                    pixel_out = ColumnStatistic(gb_block, bIfRBpixel,gb_reg);
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

    if (gb_reg.eb)
    {
        greenbalance2_label0:for (k = 0;k < 3;k++){
            dst.write(gb_block[3][k+4]);
        }

        padding_outer_loop:for (k = 0;k < 3;k++){
            padding_inter_loop:for(i = 0;i < top_reg.frameWidth;i++){
                gb_block[3][6] = gb_lines[k+3][i];
                dst.write(gb_block[3][6]);
            }
        }
    }
}
