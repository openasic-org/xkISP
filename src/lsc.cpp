#include"lsc.h"

uint12 lsc_clip(int16 a, int lower, int upper) {
    uint12 result;
    if (a < lower)
        result = lower;
    else if (a > upper)
        result = upper;
    else
        result = a;
    return result;
};

int14 BilinearInterpolation(uint13 LeftTopGain, uint13 LeftDownGain,uint13 RightTopGain, uint13 RightDownGain,
                            uint9 BlockWidthCount, uint9 BlockHeightCount, uint14 blockWidth_1, uint10 blockHeight_1)
{
    int14 result;

    int14 tmp_t = 0;
    int14 tmp_d = 0;
    int14 LT = LeftTopGain;
    int14 LD = LeftDownGain;
    int14 RT = RightTopGain;
    int14 RD = RightDownGain;

    tmp_t = LT - (((LT - RT) * BlockWidthCount * blockWidth_1 + 128) >> 19);
    tmp_d = LD - (((LD - RD) * BlockWidthCount * blockWidth_1 + 128) >> 19);

    result = tmp_t - (((tmp_t - tmp_d) * BlockHeightCount * blockHeight_1 + 128) >> 15);
    return result;
};

void lsc(top_register topRegister, lsc_register lscRegister, stream_u12 &src, stream_u12 &dst)
{
    uint12 src_w;
    uint12 dst_t;
    uint9 block_width = lscRegister.blockWidth;
    uint9 block_height = lscRegister.blockHeight;
    uint14 block_width_1 = lscRegister.blockWidth_1;
    uint10 block_height_1 = lscRegister.blockHeight_1;
    uint2  bayerPattern = topRegister.imgPattern;
    int27 dst_value;
    int13 src_t;

    static uint9 block_width_count = 0;
    static uint9 block_height_count = 0;

    static bool line_is_blue; //0: red; 1: blue
    static uint13 gain_0_lt;
    static uint13 gain_0_rt;
    static uint13 gain_0_ld;
    static uint13 gain_0_rd;
    static uint13 gain_1_lt;
    static uint13 gain_1_rt;
    static uint13 gain_1_ld;
    static uint13 gain_1_rd;
    static uint13 gain_2_lt;
    static uint13 gain_2_rt;
    static uint13 gain_2_ld;
    static uint13 gain_2_rd;
    static uint13 gain_3_lt;
    static uint13 gain_3_rt;
    static uint13 gain_3_ld;
    static uint13 gain_3_rd;
    static uint13 gain_rGb_t_nxt;
    static uint13 gain_rGb_d_nxt;
    static uint13 gain_Grb_t_nxt;
    static uint13 gain_Grb_d_nxt;
    static uint8 block_count_rGr;
    static uint8 block_count_Gbb;
    uint13 gain_lt;
    uint13 gain_rt;
    uint13 gain_ld;
    uint13 gain_rd;

    lsc_row: for(uint13 y = 0; y < topRegister.frameHeight; y++){
        lsc_col: for(uint13 x = 0; x < topRegister.frameWidth; x++){
            src_w = src.read();
            if(lscRegister.eb == 1)
            {
                if((x == 0) && (y == 0))
                {
                    gain_0_lt = lscRegister.rGain[0];
                    gain_0_rt = lscRegister.rGain[1];
                    gain_0_ld = lscRegister.rGain[17];
                    gain_0_rd = lscRegister.rGain[18];
                    gain_1_lt = lscRegister.GrGain[0];
                    gain_1_rt = lscRegister.GrGain[1];
                    gain_1_ld = lscRegister.GrGain[17];
                    gain_1_rd = lscRegister.GrGain[18];
                    gain_2_lt = lscRegister.GbGain[0];
                    gain_2_rt = lscRegister.GbGain[1];
                    gain_2_ld = lscRegister.GbGain[17];
                    gain_2_rd = lscRegister.GbGain[18];
                    gain_3_lt = lscRegister.bGain[0];
                    gain_3_rt = lscRegister.bGain[1];
                    gain_3_ld = lscRegister.bGain[17];
                    gain_3_rd = lscRegister.bGain[18];
                    gain_rGb_t_nxt = line_is_blue ? lscRegister.GbGain[2] : lscRegister.rGain[2];
                    gain_rGb_d_nxt = line_is_blue ? lscRegister.GbGain[19] : lscRegister.rGain[19];
                    gain_Grb_t_nxt = line_is_blue ? lscRegister.bGain[2] : lscRegister.GrGain[2];
                    gain_Grb_d_nxt = line_is_blue ? lscRegister.bGain[19] : lscRegister.GrGain[19];
                    line_is_blue = (bayerPattern > 1); //0: red; 1: blue
                }
                //calculation
                bayerPattern = (((y & 1) << 1) + (x & 1)) ^ topRegister.imgPattern;
                src_t = src_w - topRegister.blc;
                if (bayerPattern == 0)
                {
                    gain_lt = gain_0_lt;
                    gain_rt = gain_0_rt;
                    gain_ld = gain_0_ld;
                    gain_rd = gain_0_rd;
                }
                else if (bayerPattern == 1)
                {
                    gain_lt = gain_1_lt;
                    gain_rt = gain_1_rt;
                    gain_ld = gain_1_ld;
                    gain_rd = gain_1_rd;
                }
                else if (bayerPattern == 2)
                {
                    gain_lt = gain_2_lt;
                    gain_rt = gain_2_rt;
                    gain_ld = gain_2_ld;
                    gain_rd = gain_2_rd;
                }
                else if (bayerPattern == 3)
                {
                    gain_lt = gain_3_lt;
                    gain_rt = gain_3_rt;
                    gain_ld = gain_3_ld;
                    gain_rd = gain_3_rd;
                }
                dst_value = src_t * BilinearInterpolation(gain_lt, gain_ld, gain_rt, gain_rd,
                                                          block_width_count, block_height_count,
                                                          block_width_1, block_height_1);
                dst_value = ((dst_value + 1024) >> 11) + topRegister.blc;
                dst_t = lsc_clip(dst_value, 0, 4095);

                #ifdef DEBUG
                if((x == COL_TEST) && (y == ROW_TEST)) {
                    printf("\t lsc_in = %d\n", src_t.to_int());
                    printf("\t line_is_blue = %d\n", line_is_blue);
                    printf("\t gain_lt = %d\n", gain_lt.to_int());
                    printf("\t gain_rt = %d\n", gain_rt.to_int());
                    printf("\t gain_ld = %d\n", gain_ld.to_int());
                    printf("\t gain_rd = %d\n", gain_rd.to_int());
                    printf("\t block_width_count = %d\n", block_width_count.to_int());
                    printf("\t block_height_count = %d\n", block_height_count.to_int());
                    printf("\t lsc_out = %d\n", dst_t.to_int());
                }
                #endif

                //update
                if((x == 0) && (y == 0))
                {
                    block_count_rGr = 2;
                }
                else if((x == topRegister.frameWidth - 1) && (line_is_blue == 0))
                {
                    if((block_height_count == block_height - 1) || (block_height_count == block_height -2))
                    {
                        block_count_rGr += 2;
                    }
                    else
                    {
                        block_count_rGr -= 15;
                    }
                }
                else if((block_width_count == block_width - 1) && (line_is_blue == 0))
                {
                    block_count_rGr++;
                }

                if((x == 0) && (y == 0))
                {
                    block_count_Gbb = 2;
                }
                else if((x == topRegister.frameWidth - 1) && (line_is_blue == 1))
                {
                    if((block_height_count == block_height - 1) || (block_height_count == block_height -2))
                    {
                        block_count_Gbb += 2;
                    }
                    else
                    {
                        block_count_Gbb -= 15;
                    }
                }
                else if((block_width_count == block_width - 1) && (line_is_blue == 1))
                {
                    block_count_Gbb++;
                }

                if((block_width_count == block_width - 1) && (line_is_blue == 0))
                {
                    gain_0_lt = gain_0_rt;
                    gain_0_ld = gain_0_rd;
                    gain_0_rt = gain_rGb_t_nxt;
                    gain_0_rd = gain_rGb_d_nxt;
                    gain_1_lt = gain_1_rt;
                    gain_1_ld = gain_1_rd;
                    gain_1_rt = gain_Grb_t_nxt;
                    gain_1_rd = gain_Grb_d_nxt;
                }
                else if((line_is_blue == 1) && (x == 5) && (y != 0))
                {
                    gain_0_lt = lscRegister.rGain[block_count_rGr - 2];
                }
                else if((line_is_blue == 1) && (x == 6) && (y != 0))
                {
                    gain_0_rt = lscRegister.rGain[block_count_rGr - 1];
                }
                else if((line_is_blue == 1) && (x == 7) && (y != 0))
                {
                    gain_0_ld = lscRegister.rGain[block_count_rGr + 15];
                }
                else if((line_is_blue == 1) && (x == 8) && (y != 0))
                {
                    gain_0_rd = lscRegister.rGain[block_count_rGr + 16];
                }
                else if((line_is_blue == 1) && (x == 9) && (y != 0))
                {
                    gain_1_lt = lscRegister.GrGain[block_count_rGr - 2];
                }
                else if((line_is_blue == 1) && (x == 10) && (y != 0))
                {
                    gain_1_rt = lscRegister.GrGain[block_count_rGr - 1];
                }
                else if((line_is_blue == 1) && (x == 11) && (y != 0))
                {
                    gain_1_ld = lscRegister.GrGain[block_count_rGr + 15];
                }
                else if((line_is_blue == 1) && (x == 12) && (y != 0))
                {
                    gain_1_rd = lscRegister.GrGain[block_count_rGr + 16];
                }

                if((block_width_count == block_width - 1) && (line_is_blue == 1))
                {
                    gain_2_lt = gain_2_rt;
                    gain_2_ld = gain_2_rd;
                    gain_2_rt = gain_rGb_t_nxt;
                    gain_2_rd = gain_rGb_d_nxt;
                    gain_3_lt = gain_3_rt;
                    gain_3_ld = gain_3_rd;
                    gain_3_rt = gain_Grb_t_nxt;
                    gain_3_rd = gain_Grb_d_nxt;
                }
                else if((line_is_blue == 0) && (x == 5) && (y != 0))
                {
                    gain_2_lt = lscRegister.GbGain[block_count_Gbb - 2];
                }
                else if((line_is_blue == 0) && (x == 6) && (y != 0))
                {
                    gain_2_rt = lscRegister.GbGain[block_count_Gbb - 1];
                }
                else if((line_is_blue == 0) && (x == 7) && (y != 0))
                {
                    gain_2_ld = lscRegister.GbGain[block_count_Gbb + 15];
                }
                else if((line_is_blue == 0) && (x == 8) && (y != 0))
                {
                    gain_2_rd = lscRegister.GbGain[block_count_Gbb + 16];
                }
                else if((line_is_blue == 0) && (x == 9) && (y != 0))
                {
                    gain_3_lt = lscRegister.bGain[block_count_Gbb - 2];
                }
                else if((line_is_blue == 0) && (x == 10) && (y != 0))
                {
                    gain_3_rt = lscRegister.bGain[block_count_Gbb - 1];
                }
                else if((line_is_blue == 0) && (x == 11) && (y != 0))
                {
                    gain_3_ld = lscRegister.bGain[block_count_Gbb + 15];
                }
                else if((line_is_blue == 0) && (x == 12) && (y != 0))
                {
                    gain_3_rd = lscRegister.bGain[block_count_Gbb + 16];
                }

                if(block_width_count == 0)
                {
                    gain_rGb_t_nxt = (line_is_blue) ? lscRegister.GbGain[block_count_Gbb] : lscRegister.rGain[block_count_rGr];
                }
                else if(block_width_count == 1)
                {
                    gain_Grb_t_nxt = (line_is_blue) ? lscRegister.bGain[block_count_Gbb] : lscRegister.GrGain[block_count_rGr];
                }
                else if(block_width_count == 2)
                {
                    gain_rGb_d_nxt = (line_is_blue) ? lscRegister.GbGain[block_count_Gbb + 17] : lscRegister.rGain[block_count_rGr + 17];
                }
                else if(block_width_count == 3)
                {
                    gain_Grb_d_nxt = (line_is_blue) ? lscRegister.bGain[block_count_Gbb + 17] : lscRegister.GrGain[block_count_rGr + 17];
                }

                if((x == topRegister.frameWidth - 1) && (block_height_count == block_height - 1))
                {
                    block_height_count = 0;
                }
                else if(x == topRegister.frameWidth - 1)
                {
                    block_height_count++;
                }

                if((block_width_count == block_width - 1) || (x == topRegister.frameWidth - 1))
                {
                    block_width_count = 0;
                }
                else
                {
                    block_width_count++;
                }

                if(x == topRegister.frameWidth - 1)
                {
                    line_is_blue = (line_is_blue == 0);
                }
            }
            else
            {
                dst_t = src_t;
            }
            dst.write(dst_t);
        }
    }
};

