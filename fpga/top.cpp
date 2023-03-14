#include "top.h"
#include "memory.h"


// tpg module

#define TPG_BITS 12
#define MAXS ((1<<TPG_BITS) - 1)

uint12 ColorSelect(uint2 channel, uint4 BlockID, tpg_register tpg_register)
{
    uint4 RealID;

    RealID = BlockID;
    if(tpg_register.m_bRollingEnable){
        RealID += tpg_register.m_nID;
        if (RealID > 7){
            RealID -= 8;
        }
    }

    switch(RealID){
        case 0: //white
            return MAXS;
        case 1: //black
            return 0;
        case 2: //red
            if (0 == channel){
                return MAXS;
            }else{
                return 0;
            }
        case 3: //green
            if(1 == channel || 2 == channel){
                return MAXS;
            }else{
                return 0;
            }
        case 4: //blue
            if(3 == channel){
                return MAXS;
            }else{
                return 0;
            }
        case 5: //cyan B+G
            if(0 != channel){
                return MAXS;
            }else{
                return 0;
            }
        case 6: //magenta R+B
            if(0 == channel || 3 == channel){
                return MAXS;
            }else{
                return 0;
            }
        case 7: //yellow R+G
            if(3 != channel){
                return MAXS;
            }else{
                return 0;
            }

        default:
            return 0;
    }
};

void tpg(const top_register top_register,const tpg_register tpg_register, stream_u12 &src, stream_u12 &dst){

    uint2   channel;
    uint10  cnt;
    uint10  BlockWidth = (top_register.frameWidth >> 3) & 0x3fe;
    uint4   BlockID; // [0-8]

    uint12  dst_t = 0;

    tpg_row: for(uint13 i = 0; i < top_register.frameHeight; i++){
        #pragma HLS loop_merge
        #pragma HLS loop_tripcount max=8192 avg=1920
        cnt = 0;
        BlockID = 0;
        tpg_col: for(uint13 j = 0; j < top_register.frameWidth; j++){
            #pragma HLS pipeline
            #pragma HLS loop_tripcount avg=1080
            if(tpg_register.m_bTPG_en == 1) {
                if (cnt == BlockWidth){
                    cnt = 0;
                    BlockID++;
                }

                if(BlockID > 7){
                    BlockID = 7;
                }
                dst_t =src.read();

                channel = (((i & 1) << 1) + (j & 1))^top_register.imgPattern;
                dst_t   = ColorSelect(channel, BlockID, tpg_register);
                dst.write(dst_t);

                cnt++;
            } else {
                dst_t = src.read();
                dst.write(dst_t);
                #ifdef DEBUG
                if((i == ROW_TEST) && (j == COL_TEST)) {
                    printf("\t tpg_in = %x\n",dst_t.to_int());
                }
                #endif
            }
        }
    }
};


// dgain module

uint12 dgain_clip(int22 a, int lower, int upper) {
    uint12 result;
    if (a < lower)
        result = lower;
    else if (a > upper)
        result = upper;
    else
        result = a;
    return result;
};

void dgain(const top_register top_register, const dgain_register dgain_register, stream_u12 &src, stream_u12 &dst){
    uint12 src_t;
    uint12 dst_t;
    dgain_row: for (uint13 y=0; y<top_register.frameHeight; y++){
        #pragma HLS loop_merge
        #pragma HLS loop_tripcount max=8192 avg=1920
        dgain_col: for (uint13 x=0; x<top_register.frameWidth; x++){
            #pragma HLS pipeline
            #pragma HLS loop_tripcount avg=1080
            src_t = src.read();
            if(dgain_register.m_nEb == 1) {
                int22  dst_val;
                int34  dst_tmp;
                uint20 gain_w;
                uint9  blc_w;
                uint2  bayerPattern = (((y & 1) << 1) + (x & 1))^top_register.imgPattern;

                if (bayerPattern == 0) {
                    blc_w = dgain_register.m_nBlcR;
                    gain_w = dgain_register.m_nR;
                } else if (bayerPattern == 1) {
                    blc_w = dgain_register.m_nBlcGr;
                    gain_w = dgain_register.m_nGr;
                } else if (bayerPattern == 2) {
                    blc_w = dgain_register.m_nBlcGb;
                    gain_w = dgain_register.m_nGb;
                } else {
                    blc_w = dgain_register.m_nBlcB;
                    gain_w = dgain_register.m_nB;
                }

                dst_tmp = (src_t-blc_w) * gain_w + GAIN_HALF_VALUE;
                dst_val = (dst_tmp >> GAIN_BITS) + top_register.blc;
                dst_t = dgain_clip(dst_val,0,4095);
                #ifdef DEBUG
                if((x == COL_TEST) && (y == ROW_TEST)) {
                    printf("\t dgain_in = %x\n",src_t.to_int());
                    printf("\t dgain_val = %x\n",dst_val.to_int());
                    printf("\t dgain_out = %x\n",dst_t.to_int());
                }
                #endif
            } else {
                dst_t = src_t;
            }
            dst.write(dst_t);
        }
    }
};

//lsc module

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

void lsc(const top_register topRegister, const lsc_register lscRegister, stream_u12 &src, stream_u12 &dst, const uint13 rGain[224], const uint13 GrGain[224], const uint13 GbGain[224], const uint13 bGain[224])
{
    uint12 src_w;
    uint12 dst_t;
    uint9 block_width = lscRegister.blockWidth;
    uint9 block_height = lscRegister.blockHeight;
    uint14 block_width_1 = lscRegister.blockWidth_1;
    uint10 block_height_1 = lscRegister.blockHeight_1;
    uint2 bayerPattern = topRegister.imgPattern;
    int27 dst_value;
    int13 src_t;

    static uint9 block_width_count = 0;
    static uint9 block_height_count = 0;

    static bool line_is_blue; //0: red; 1: blue
    static uint13 gain_0_lt = rGain[0];
    static uint13 gain_0_rt = rGain[1];
    static uint13 gain_0_ld = rGain[17];
    static uint13 gain_0_rd = rGain[18];
    static uint13 gain_1_lt = GrGain[0];
    static uint13 gain_1_rt = GrGain[1];
    static uint13 gain_1_ld = GrGain[17];
    static uint13 gain_1_rd = GrGain[18];
    static uint13 gain_2_lt = GbGain[0];
    static uint13 gain_2_rt = GbGain[1];
    static uint13 gain_2_ld = GbGain[17];
    static uint13 gain_2_rd = GbGain[18];
    static uint13 gain_3_lt = bGain[0];
    static uint13 gain_3_rt = bGain[1];
    static uint13 gain_3_ld = bGain[17];
    static uint13 gain_3_rd = bGain[18];
    static uint13 gain_rGb_t_nxt = line_is_blue ? GbGain[2] : rGain[2];
    static uint13 gain_rGb_d_nxt = line_is_blue ? GbGain[19] : rGain[19];
    static uint13 gain_Grb_t_nxt = line_is_blue ? bGain[2] : GrGain[2];
    static uint13 gain_Grb_d_nxt = line_is_blue ? bGain[19] : GrGain[19];
    static uint9 block_count_rGr = 2;
    static uint9 block_count_Gbb = 2;
    uint13 gain_lt;
    uint13 gain_rt;
    uint13 gain_ld;
    uint13 gain_rd;

    lsc_row: for(uint13 y = 0; y < topRegister.frameHeight; y++){
        #pragma HLS loop_merge
        #pragma HLS loop_tripcount max=8192 avg=1920
        lsc_col: for(uint13 x = 0; x < topRegister.frameWidth; x++){
            #pragma HLS pipeline
            #pragma HLS loop_tripcount avg=1080
            src_w = src.read();
            if(lscRegister.eb == 1)
            {
                //calculation
                bayerPattern = (((y & 1) << 1) + (x & 1)) ^ topRegister.imgPattern;
                line_is_blue = (bayerPattern > 1); //0: red; 1: blue
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
                    printf("\t block_width_1 = %d", block_width_1.to_int());
                    printf("\t block_height_1 = %d", block_height_1.to_int());
                    printf("\t dst_value = %d", dst_value.to_int());
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
                    gain_0_lt = rGain[block_count_rGr - 2];
                }
                else if((line_is_blue == 1) && (x == 6) && (y != 0))
                {
                    gain_0_rt = rGain[block_count_rGr - 1];
                }
                else if((line_is_blue == 1) && (x == 7) && (y != 0))
                {
                    gain_0_ld = rGain[block_count_rGr + 15];
                }
                else if((line_is_blue == 1) && (x == 8) && (y != 0))
                {
                    gain_0_rd = rGain[block_count_rGr + 16];
                }
                else if((line_is_blue == 1) && (x == 9) && (y != 0))
                {
                    gain_1_lt = GrGain[block_count_rGr - 2];
                }
                else if((line_is_blue == 1) && (x == 10) && (y != 0))
                {
                    gain_1_rt = GrGain[block_count_rGr - 1];
                }
                else if((line_is_blue == 1) && (x == 11) && (y != 0))
                {
                    gain_1_ld = GrGain[block_count_rGr + 15];
                }
                else if((line_is_blue == 1) && (x == 12) && (y != 0))
                {
                    gain_1_rd = GrGain[block_count_rGr + 16];
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
                    gain_2_lt = GbGain[block_count_Gbb - 2];
                }
                else if((line_is_blue == 0) && (x == 6) && (y != 0))
                {
                    gain_2_rt = GbGain[block_count_Gbb - 1];
                }
                else if((line_is_blue == 0) && (x == 7) && (y != 0))
                {
                    gain_2_ld = GbGain[block_count_Gbb + 15];
                }
                else if((line_is_blue == 0) && (x == 8) && (y != 0))
                {
                    gain_2_rd = GbGain[block_count_Gbb + 16];
                }
                else if((line_is_blue == 0) && (x == 9) && (y != 0))
                {
                    gain_3_lt = bGain[block_count_Gbb - 2];
                }
                else if((line_is_blue == 0) && (x == 10) && (y != 0))
                {
                    gain_3_rt = bGain[block_count_Gbb - 1];
                }
                else if((line_is_blue == 0) && (x == 11) && (y != 0))
                {
                    gain_3_ld = bGain[block_count_Gbb + 15];
                }
                else if((line_is_blue == 0) && (x == 12) && (y != 0))
                {
                    gain_3_rd = bGain[block_count_Gbb + 16];
                }

                if(block_width_count == 1)
                {
                    gain_rGb_t_nxt = (line_is_blue) ? GbGain[block_count_Gbb] : rGain[block_count_rGr];
                }
                else if(block_width_count == 2)
                {
                    gain_Grb_t_nxt = (line_is_blue) ? bGain[block_count_Gbb] : GrGain[block_count_rGr];
                }
                else if(block_width_count == 3)
                {
                    gain_rGb_d_nxt = (line_is_blue) ? GbGain[block_count_Gbb + 17] : rGain[block_count_rGr + 17];
                }
                else if(block_width_count == 4)
                {
                    gain_Grb_d_nxt = (line_is_blue) ? bGain[block_count_Gbb + 17] : GrGain[block_count_rGr + 17];
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
            }
            else
            {
                dst_t = src_w;
            }
            dst.write(dst_t);
        }
    }
};


//dpc module

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
            }
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
    #pragma HLS array_partition variable=arr_ori type=complete dim=1
    #pragma HLS array_partition variable=arr_sort type=complete dim=1
    #pragma HLS array_partition variable=rawWindow type=complete dim=1
    bool flag;
    uint11 th_w = dpc_reg.th_w;
    uint11 th_b = dpc_reg.th_b;

    uint12 lineBuf[4][4096];
    #pragma HLS array_partition variable=lineBuf

    int n_n = 0;

    dpc_loop_out:for(uint13 row = 0; row < top_reg.frameHeight; row++){
        #pragma HLS loop_merge
        #pragma HLS loop_tripcount max=8192 avg=1920
        dpc_loop_in:for(uint13 col = 0; col < top_reg.frameWidth; col++){
            #pragma HLS pipeline
            #pragma HLS loop_tripcount avg=1080
            srcData = src.read();
            if(dpc_reg.eb == 1){
                rawWin_loop:for(uint3 i = 0; i < 5; i++){
                #pragma HLS unroll
                    rawWindow[i][0] = rawWindow[i][1];
                    rawWindow[i][1] = rawWindow[i][2];
                    rawWindow[i][2] = rawWindow[i][3];
                    rawWindow[i][3] = rawWindow[i][4];
                }

                rawWindow_read:for(uint3 i = 0; i < 4; i++){
                    rawWindow[i][4] = lineBuf[i][col];
                }

                rawWindow[4][4] = srcData;

                line_write:for(uint3 i = 0; i < 4; i++){
                    lineBuf[i][col] = rawWindow[i+1][4];
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
        #pragma HLS pipeline
        dst.write(0);
    }
};


//rawdns module

inline uint12 rawdns_abs(uint12 rawData_1 , uint12 rawData_2)
{
    if(rawData_1 >= rawData_2)
        return rawData_1 - rawData_2;
    else
        return rawData_2 - rawData_1;
}
inline uint30 rawdns_max(uint30 diff, uint14 sigma2)
{
    if(diff <= sigma2)
        return 0;
    else
        return diff - sigma2;
}

inline uint12 rawdns_clip(uint25 result)
{
    if(result>4095)
        return 4095;
    else
        return (uint12)result;
}

uint8 Cal_weight(uint30 diff,rawdns_register& rawdns_reg,uint26 ksigma2)
{
    const static uint8 weight_1[10] = {244,220,197,180,163,148,133,120,111,99};
#pragma HLS array_partition variable=weight_1 complete dim=1
    const static uint8 weight_2[18] = {85,70,57,47,39,32,26,21,18,15,12,10,8,7,6,3,1,0};
#pragma HLS array_partition variable=weight_2 complete dim=1

    uint8 weight;
    uint40 weight_temp;

    if(ksigma2 == 0)
    {
        weight = 0;
    }
    else if (diff > ksigma2)
    {
        diff = 5 * diff;
        weight_temp = ((diff * rawdns_reg.invksigma2) >> 12) - 5;

        if(diff < 6 * ksigma2)
            weight = weight_2[0];
        else if(diff >= 22 * ksigma2)
            weight = weight_2[17];
        else
            weight = weight_2[weight_temp];
    }
    else
    {
        diff = 10 * diff;
        weight_temp = (diff * rawdns_reg.invksigma2) >> 12;

        if(diff < ksigma2)
            weight = weight_1[0];
        else if(diff >= 9 * ksigma2)
            weight = weight_1[9];
        else
            weight = weight_1[weight_temp];
    }
    return weight;
}

uint30 Cal_Eur_Distance(uint12 rawdns_block[11][11], uint4 cur_y, uint4 cur_x)
{
    uint24 temp_block[3][3];
    uint12 temp;
    uint30 Eur_distance = 0;
    int4 k,l;

    for(k = -1; k <= 1;k++){
        for(l = -1;l <= 1;l++){
            temp = rawdns_abs(rawdns_block[5 + k][5 + l] , rawdns_block[cur_y + k][cur_x + l]);
            temp_block[k + 1][l + 1] = temp ;
        }
    }

    for(k = 0; k <= 2;k++){
        for(l = 0;l <= 2;l++){
            temp_block[k][l] = temp_block[k][l] * temp_block[k][l];
            Eur_distance = Eur_distance + temp_block[k][l];
        }
    }
    return Eur_distance;
}

uint12 rawdns_process(uint12 rawdns_block[11][11],rawdns_register& rawdns_reg, uint26 ksigma2,uint13 row,uint13 col)
{
    uint30 eur_distance;
    int30  diff;
    uint13 total_weight = 0;
    uint25 total_value = 0;
    uint4 k,l;
    uint6 sigma = rawdns_reg.sigma;
    uint14 sigma2 = 2 * sigma * sigma;
    uint8 weight,max_weight = 0;

    for(k=1;k<=9;k+=2){
        for(l=1;l<=9;l+=2){
           if((k!=5) || (l!=5))
           {
               eur_distance = Cal_Eur_Distance(rawdns_block,k,l);

               diff = rawdns_max(eur_distance, sigma2);
               weight = Cal_weight(diff,rawdns_reg ,ksigma2);

               if(weight > max_weight)
               {
                   max_weight = weight;
               }
               total_weight += weight;
               total_value += weight * rawdns_block[k][l];
           }
        }
    }

    total_weight += max_weight;
    total_value += max_weight * rawdns_block[5][5];

    if(total_weight == 0)
        return rawdns_block[5][5];
    else
        return rawdns_clip(total_value/total_weight);
}

void rawdns(top_register top_reg, rawdns_register rawdns_reg, stream_u12& src, stream_u12& dst)
{
    uint12 rawdns_lines[10][4096];
#pragma HLS array_partition variable=rawdns_lines block factor=10 dim=1
    uint12 rawdns_block[11][11];
#pragma HLS array_partition variable=rawdns_block complete dim=0

    uint26 n;
    uint13 i = 0,j = 0,count = 0;
    uint4  k,l;

    uint6 sigma = rawdns_reg.sigma;
    uint7 filterpara = rawdns_reg.Filterpara;
    uint13 ksigma  = sigma * filterpara;
    uint26 ksigma2 = (ksigma * ksigma) >> 16;

    uint12 src_data ,dst_data;

    pixel_loop:for(n=0;n<top_reg.frameHeight * top_reg.frameWidth;n++)
    {
#pragma HLS LOOP_TRIPCOUNT avg=2048
#pragma HLS PIPELINE
        src_data = src.read();

        if(count == top_reg.frameWidth)
        {
            i++;
            count = 0;
        }

        count++;
        j = n - i * top_reg.frameWidth;

     //rw and process
        if(rawdns_reg.eb)
        {
            //cache move
            reg_refresh_out_loop:for(k = 0; k < 11;k++){
                reg_refresh_inner_loop:for( l = 0; l < 10 ;l++){
                    rawdns_block[k][l] = rawdns_block[k][l+1];
                }
            }

            for(l = 0; l < 10 ;l++){
                rawdns_block[l][10] = rawdns_lines[l][j];
            }

            rawdns_block[10][10] = src_data;

            for(l = 0; l < 10 ;l++){
                rawdns_lines[l][j] = rawdns_block[l+1][10];
            }


            if((i > 9) && (j > 9))
            {
                dst_data = rawdns_process(rawdns_block, rawdns_reg,ksigma2,i,j);
            }
            else
            {
                dst_data = rawdns_block[5][5];
            }

            #ifdef  DEBUG
                if ((i == ROW_TEST + 5)&&(j == COL_TEST + 5))
                {
                    printf("\t%d\t%d\n",i.to_int(),j.to_int());
                    printf("\t%d\n",src_data.to_int());
                    printf("\t%d\n",rawdns_block[5][5].to_int());
                    printf("\t%d\t%d\t%d\t%d\t%d\t%d\t%d\t%d\t%d\t%d\t%d\n", rawdns_block[0][0].to_int(), rawdns_block[0][1].to_int(), rawdns_block[0][2].to_int(), rawdns_block[0][3].to_int(), rawdns_block[0][4].to_int(), rawdns_block[0][5].to_int(), rawdns_block[0][6].to_int(), rawdns_block[0][7].to_int(), rawdns_block[0][8].to_int(), rawdns_block[0][9].to_int(), rawdns_block[0][10].to_int());
                    printf("\t%d\t%d\t%d\t%d\t%d\t%d\t%d\t%d\t%d\t%d\t%d\n", rawdns_block[1][0].to_int(), rawdns_block[1][1].to_int(), rawdns_block[1][2].to_int(), rawdns_block[1][3].to_int(), rawdns_block[1][4].to_int(), rawdns_block[1][5].to_int(), rawdns_block[1][6].to_int(), rawdns_block[1][7].to_int(), rawdns_block[1][8].to_int(), rawdns_block[1][9].to_int(), rawdns_block[1][10].to_int());
                    printf("\t%d\t%d\t%d\t%d\t%d\t%d\t%d\t%d\t%d\t%d\t%d\n", rawdns_block[2][0].to_int(), rawdns_block[2][1].to_int(), rawdns_block[2][2].to_int(), rawdns_block[2][3].to_int(), rawdns_block[2][4].to_int(), rawdns_block[2][5].to_int(), rawdns_block[2][6].to_int(), rawdns_block[2][7].to_int(), rawdns_block[2][8].to_int(), rawdns_block[2][9].to_int(), rawdns_block[2][10].to_int());
                    printf("\t%d\t%d\t%d\t%d\t%d\t%d\t%d\t%d\t%d\t%d\t%d\n", rawdns_block[3][0].to_int(), rawdns_block[3][1].to_int(), rawdns_block[3][2].to_int(), rawdns_block[3][3].to_int(), rawdns_block[3][4].to_int(), rawdns_block[3][5].to_int(), rawdns_block[3][6].to_int(), rawdns_block[3][7].to_int(), rawdns_block[3][8].to_int(), rawdns_block[3][9].to_int(), rawdns_block[3][10].to_int());
                    printf("\t%d\t%d\t%d\t%d\t%d\t%d\t%d\t%d\t%d\t%d\t%d\n", rawdns_block[4][0].to_int(), rawdns_block[4][1].to_int(), rawdns_block[4][2].to_int(), rawdns_block[4][3].to_int(), rawdns_block[4][4].to_int(), rawdns_block[4][5].to_int(), rawdns_block[4][6].to_int(), rawdns_block[4][7].to_int(), rawdns_block[4][8].to_int(), rawdns_block[4][9].to_int(), rawdns_block[4][10].to_int());
                    printf("\t%d\t%d\t%d\t%d\t%d\t%d\t%d\t%d\t%d\t%d\t%d\n", rawdns_block[5][0].to_int(), rawdns_block[5][1].to_int(), rawdns_block[5][2].to_int(), rawdns_block[5][3].to_int(), rawdns_block[5][4].to_int(), rawdns_block[5][5].to_int(), rawdns_block[5][6].to_int(), rawdns_block[5][7].to_int(), rawdns_block[5][8].to_int(), rawdns_block[5][9].to_int(), rawdns_block[5][10].to_int());
                    printf("\t%d\t%d\t%d\t%d\t%d\t%d\t%d\t%d\t%d\t%d\t%d\n", rawdns_block[6][0].to_int(), rawdns_block[6][1].to_int(), rawdns_block[6][2].to_int(), rawdns_block[6][3].to_int(), rawdns_block[6][4].to_int(), rawdns_block[6][5].to_int(), rawdns_block[6][6].to_int(), rawdns_block[6][7].to_int(), rawdns_block[6][8].to_int(), rawdns_block[6][9].to_int(), rawdns_block[6][10].to_int());
                    printf("\t%d\t%d\t%d\t%d\t%d\t%d\t%d\t%d\t%d\t%d\t%d\n", rawdns_block[7][0].to_int(), rawdns_block[7][1].to_int(), rawdns_block[7][2].to_int(), rawdns_block[7][3].to_int(), rawdns_block[7][4].to_int(), rawdns_block[7][5].to_int(), rawdns_block[7][6].to_int(), rawdns_block[7][7].to_int(), rawdns_block[7][8].to_int(), rawdns_block[7][9].to_int(), rawdns_block[7][10].to_int());
                    printf("\t%d\t%d\t%d\t%d\t%d\t%d\t%d\t%d\t%d\t%d\t%d\n", rawdns_block[8][0].to_int(), rawdns_block[8][1].to_int(), rawdns_block[8][2].to_int(), rawdns_block[8][3].to_int(), rawdns_block[8][4].to_int(), rawdns_block[8][5].to_int(), rawdns_block[8][6].to_int(), rawdns_block[8][7].to_int(), rawdns_block[8][8].to_int(), rawdns_block[8][9].to_int(), rawdns_block[8][10].to_int());
                    printf("\t%d\t%d\t%d\t%d\t%d\t%d\t%d\t%d\t%d\t%d\t%d\n", rawdns_block[9][0].to_int(), rawdns_block[9][1].to_int(), rawdns_block[9][2].to_int(), rawdns_block[9][3].to_int(), rawdns_block[9][4].to_int(), rawdns_block[9][5].to_int(), rawdns_block[9][6].to_int(), rawdns_block[9][7].to_int(), rawdns_block[9][8].to_int(), rawdns_block[9][9].to_int(), rawdns_block[9][10].to_int());
                    printf("\t%d\t%d\t%d\t%d\t%d\t%d\t%d\t%d\t%d\t%d\t%d\n", rawdns_block[10][0].to_int(), rawdns_block[10][1].to_int(), rawdns_block[10][2].to_int(), rawdns_block[10][3].to_int(), rawdns_block[10][4].to_int(), rawdns_block[10][5].to_int(), rawdns_block[10][6].to_int(), rawdns_block[10][7].to_int(), rawdns_block[10][8].to_int(), rawdns_block[10][9].to_int(), rawdns_block[10][10].to_int());
                    printf("\t%d\n",dst_data.to_int());
                    printf("\n\n\n");
                }
            #endif
            if((i > 5)||((i == 5)&&(j > 4)))
            {
                dst.write(dst_data);
            }
        }
        else
        {
            dst_data = src_data;
            dst.write(dst_data);
        }
    }

    //padding process
    if(rawdns_reg.eb)
    {
        padding_loop1:for(k = 0; k < 5 ;k++)
        {
#pragma HLS UNROLL

            dst_data = rawdns_lines[4][top_reg.frameWidth - 5 + k];
            dst.write(dst_data);
        }

        padding_loop2:for(k = 0; k < 5 ;k++)
        {
#pragma HLS UNROLL factor=5

            loop2_inner_loop:for(i = 0;i < top_reg.frameWidth;i++)
            {
#pragma HLS PIPELINE

                dst_data = rawdns_lines[k + 5][i];
                dst.write(dst_data);
            }
        }
    }
}

//awb module
void awb(top_register top_register, awb_register awb_register, stream_u12 &src, stream_u16 &awb_gain, stream_u12 &dst) {
    uint12 src_t;
    uint33 r_total = 0;
    uint33 g_total = 0;
    uint33 b_total = 0;
    uint12 r_avg = 0;
    uint12 g_avg = 0;
    uint12 b_avg = 0;
    uint26 gray = 0;
    awb_row: for (uint13 y = 0; y < top_register.frameHeight; y++) {
        #pragma HLS loop_merge
        #pragma HLS loop_tripcount max=8192 avg=1920
        awb_col: for (uint13 x = 0; x < top_register.frameWidth; x++) {
            #pragma HLS pipeline
            #pragma HLS loop_tripcount avg=1080
            src_t = src.read();                      
            if(awb_register.eb == 1)
            {
                uint2  bayerPattern = (((y & 1) << 1) + (x & 1))^top_register.imgPattern;

                if (bayerPattern == 0)
                {
                    r_total = r_total + src_t;
                }
                else if (bayerPattern == 1)
                {
                    g_total = g_total + src_t;
                }
                else if (bayerPattern == 2)
                {
                    g_total = g_total + src_t;
                }
                else
                {
                    b_total = b_total + src_t;
                }
            }
                dst.write(src_t);
                #ifdef DEBUG
                if((x == COL_TEST) && (y == ROW_TEST)) {
                    printf("\t lsc_in = %d\n", src_t.to_int());
                }
                #endif
            }
    }

    r_avg = (r_total * awb_register.coeff) >> 19;
    g_avg = (g_total * awb_register.coeff) >> 20;
    b_avg = (b_total * awb_register.coeff) >> 19;
    awb_gain.write(r_avg);
    awb_gain.write(g_avg);
    awb_gain.write(b_avg);
    printf ("r_gain_1 = %d\n" ,r_avg.to_int() );
    printf ("g_gain_1 = %d\n" ,g_avg.to_int() );
    printf ("b_gain_1 = %d\n" ,b_avg.to_int() );
}

// wbc module

uint12 wbc_clip(int16 a, int lower, int upper) {
    uint12 result;
    if (a < lower)
        result = lower;
    else if (a > upper)
        result = upper;
    else
        result = a;
    return result;
};

void wbc(const top_register top_register, const wbc_register wbc_register, stream_u12 &src, stream_u12 &dst){
    uint12 src_t;
    uint12 dst_t;
    wbc_row: for (uint13 y=0; y<top_register.frameHeight; y++){
        #pragma HLS loop_merge
        #pragma HLS loop_tripcount max=8192 avg=1920
        wbc_col: for (uint13 x=0; x<top_register.frameWidth; x++){
            #pragma HLS pipeline
            #pragma HLS loop_tripcount avg=1080
            src_t = src.read();
            if(wbc_register.m_nEb == 1) {
                int16  dst_val;
                uint15 gain_w;
                uint2  bayerPattern = (((y & 1) << 1) + (x & 1))^top_register.imgPattern;

                if (bayerPattern == 0) {
                    gain_w = wbc_register.m_nR;
                } else if (bayerPattern == 1) {
                    gain_w = wbc_register.m_nGr;
                } else if (bayerPattern == 2) {
                    gain_w = wbc_register.m_nGb;
                } else {
                    gain_w = wbc_register.m_nB;
                }

                dst_val = (((src_t - top_register.blc) * gain_w + 2048) >> 12) + top_register.blc;
                dst_t = wbc_clip(dst_val,0,4095);
                #ifdef DEBUG
                if((x == COL_TEST) && (y == ROW_TEST)) {
                    printf("\t wbc_in = %x\n",src_t.to_int());
                    printf("\t wbc_out = %x\n",dst_t.to_int());
                }
                #endif
            } else {
                dst_t = src_t;
            }
            dst.write(dst_t);
        }
    }
};

//gb module

inline uint12 gb_abs(uint12 rawData_1 , uint12 rawData_2)
{
    if(rawData_1 >= rawData_2)
        return rawData_1 - rawData_2;
    else
        return rawData_2 - rawData_1;
}

inline uint12 gb_clip(int31 result)
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
     #pragma HLS ARRAY_PARTITION variable=Lut complete dim=1
     uint6 Lut_value = 0;

     uint4 i,j;

     if(IfRBpixel)
     {
         sawtooth_loop_1:for (i = 1; i < 7; i += 2) {
             sawtooth_loop_2:for(j = 0; j < 8; j += 2)
             {
                 if(j == 0)
                 {
                     if(gb_abs(gb_block[i][j],gb_block[i - 1][j + 1]) < gb_reg.threhold)
                     {
                         sum_total+=(gb_block[i][j] - gb_block[i - 1][j + 1]);
                         count_total++;
                     }
                     if(gb_abs(gb_block[i][j],gb_block[i + 1][j + 1]) < gb_reg.threhold)
                     {
                         sum_total+=(gb_block[i][j] - gb_block[i + 1][j + 1]);
                         count_total++;
                     }
                 }

                 else if(j == 6)
                 {
                     if(gb_abs(gb_block[i][j],gb_block[i - 1][j - 1]) < gb_reg.threhold)
                     {
                         sum_total+=(gb_block[i][j] - gb_block[i - 1][j - 1]);
                         count_total++;
                     }
                     if(gb_abs(gb_block[i][j],gb_block[i + 1][j - 1]) < gb_reg.threhold)
                     {
                         sum_total+=(gb_block[i][j] - gb_block[i + 1][j - 1]);
                         count_total++;
                     }
                 }
                 else
                 {
                     if(gb_abs(gb_block[i][j],gb_block[i - 1][j - 1]) < gb_reg.threhold)
                     {
                         sum_total+=(gb_block[i][j] - gb_block[i - 1][j - 1]);
                         count_total++;
                     }
                     if(gb_abs(gb_block[i][j],gb_block[i + 1][j - 1]) < gb_reg.threhold)
                     {
                         sum_total+=(gb_block[i][j] - gb_block[i + 1][j - 1]);
                         count_total++;
                     }
                     if(gb_abs(gb_block[i][j],gb_block[i - 1][j + 1]) < gb_reg.threhold)
                     {
                         sum_total+=(gb_block[i][j] - gb_block[i - 1][j + 1]);
                         count_total++;
                     }
                     if(gb_abs(gb_block[i][j],gb_block[i + 1][j + 1]) < gb_reg.threhold)
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
                 if(gb_abs(gb_block[i][j],gb_block[i - 1][j - 1]) < gb_reg.threhold)
                 {
                     sum_total+=(gb_block[i][j] - gb_block[i - 1][j - 1]);
                     count_total++;
                 }
                 if(gb_abs(gb_block[i][j],gb_block[i + 1][j - 1]) < gb_reg.threhold)
                 {
                     sum_total+=(gb_block[i][j] - gb_block[i + 1][j - 1]);
                     count_total++;
                 }
                 if(gb_abs(gb_block[i][j],gb_block[i - 1][j + 1]) < gb_reg.threhold)
                 {
                     sum_total+=(gb_block[i][j] - gb_block[i - 1][j + 1]);
                     count_total++;
                 }
                 if(gb_abs(gb_block[i][j],gb_block[i + 1][j + 1]) < gb_reg.threhold)
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
    return gb_clip((int31)gb_block[3][3] - sum_total);
}



void greenbalance2(top_register top_reg, gb_register gb_reg, hls::stream<uint12>& src, hls::stream<uint12>& dst)
{
    uint12 pixel_in;
    uint12 pixel_out;
    uint12 gb_lines[6][4096];
    #pragma HLS ARRAY_PARTITION variable=gb_lines block factor=6 dim=1
    uint12 temp[5];
    uint12 gb_block[7][7];
    #pragma HLS ARRAY_PARTITION variable=gb_block complete dim=0
    uint13 row, col, i, j;
    uint3  k, l;

    bool   bIfRBpixel;
    bool   bGreen;

    bGreen = ((top_reg.imgPattern >> 1) ^ (top_reg.imgPattern & 1));
    row_loop:for (row = 0; row < top_reg.frameHeight; row++) {
    #pragma HLS LOOP_TRIPCOUNT max=8192 avg=1920
        col_loop:for (col = 0; col < top_reg.frameWidth; col++) {
        #pragma HLS pipeline
        pixel_in = src.read();
        if (gb_reg.eb)
        {
            out_window_loop:for (k = 0; k < 7; k++) {
            #pragma HLS unroll
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
        #pragma HLS unroll
            dst.write(gb_block[3][k+4]);
        }

        padding_outer_loop:for (k = 0;k < 3;k++){
            padding_inter_loop:for(i = 0;i < top_reg.frameWidth;i++){
            #pragma HLS pipeline
                gb_block[3][6] = gb_lines[k+3][i];
                dst.write(gb_block[3][6]);
            }
        }
    }
}
// demosaic module

rawData_t demosaic_clip(int18 a, int lower, int upper) {
    rawData_t result;
    if (a < lower)
        result = lower;
    else if (a > upper)
        result = upper;
    else
        result = a;
    return result;
}

pixel_t demosaicInterpol(rawData_t rawWindow[5][5], uint2 bayerPattern)
{
    pixelTmp_t  pixTmp;
    pixel_t   pixel;

    if (bayerPattern == 0)
    {
        pixTmp.r = rawWindow[2][2];
        pixTmp.g = 4 * rawWindow[2][2] - rawWindow[0][2] - rawWindow[2][0] - rawWindow[4][2] - rawWindow[2][4] \
                   + 2 * (rawWindow[3][2] + rawWindow[2][3] + rawWindow[1][2] + rawWindow[2][1]);
        pixTmp.b = 6 * rawWindow[2][2] - 3 * (rawWindow[0][2] + rawWindow[2][0] + rawWindow[4][2] + rawWindow[2][4]) / 2 \
                   + 2 * (rawWindow[1][1] + rawWindow[1][3] + rawWindow[3][1] + rawWindow[3][3]);
        pixTmp.g = pixTmp.g / 8;
        pixTmp.b = pixTmp.b / 8;
    }
    else if (bayerPattern == 1)
    {
        pixTmp.r = 5 * rawWindow[2][2] - rawWindow[2][0] - rawWindow[1][1] - rawWindow[3][1] - rawWindow[1][3] - rawWindow[3][3] - rawWindow[2][4] \
                   + (rawWindow[0][2] + rawWindow[4][2]) / 2 + 4 * (rawWindow[2][1] + rawWindow[2][3]);
        pixTmp.g = rawWindow[2][2];
        pixTmp.b = 5 * rawWindow[2][2] - rawWindow[0][2] - rawWindow[1][1] - rawWindow[1][3] - rawWindow[4][2] - rawWindow[3][1] - rawWindow[3][3] \
                   + (rawWindow[2][0] + rawWindow[2][4]) / 2 + 4 * (rawWindow[1][2] + rawWindow[3][2]);
        pixTmp.r = pixTmp.r / 8;
        pixTmp.b = pixTmp.b / 8;
    }
    else if (bayerPattern == 2)
    {
        pixTmp.r = 5 * rawWindow[2][2] - rawWindow[0][2] - rawWindow[1][1] - rawWindow[1][3] - rawWindow[4][2] - rawWindow[3][1] - rawWindow[3][3] \
                   + (rawWindow[2][0] + rawWindow[2][4]) / 2 + 4 * (rawWindow[1][2] + rawWindow[3][2]);
        pixTmp.g = rawWindow[2][2];
        pixTmp.b = 5 * rawWindow[2][2] - rawWindow[2][0] - rawWindow[1][1] - rawWindow[3][1] - rawWindow[1][3] - rawWindow[3][3] - rawWindow[2][4] \
                   + (rawWindow[0][2] + rawWindow[4][2]) / 2 + 4 * (rawWindow[2][1] + rawWindow[2][3]);
        pixTmp.r = pixTmp.r / 8;
        pixTmp.b = pixTmp.b / 8;
    }
    else
    {
        pixTmp.r = 6 * rawWindow[2][2] - 3 * (rawWindow[0][2] + rawWindow[2][0] + rawWindow[4][2] + rawWindow[2][4]) / 2 \
                   + 2 * (rawWindow[1][1] + rawWindow[1][3] + rawWindow[3][1] + rawWindow[3][3]);
        pixTmp.g = 4 * rawWindow[2][2] - rawWindow[0][2] - rawWindow[2][0] - rawWindow[4][2] - rawWindow[2][4] \
                   + 2 * (rawWindow[3][2] + rawWindow[2][3] + rawWindow[1][2] + rawWindow[2][1]);
        pixTmp.b = rawWindow[2][2];
        pixTmp.r = pixTmp.r / 8;
        pixTmp.g = pixTmp.g / 8;
    }
    pixel.r = demosaic_clip(pixTmp.r, 0, 4095);
    pixel.g = demosaic_clip(pixTmp.g, 0, 4095);
    pixel.b = demosaic_clip(pixTmp.b, 0, 4095);

    return pixel;
}

void demosaic(const top_register top_register, const demosaic_register demosaic_register, Stream_t& src, Stream_3t& dst)
{
    uint36 dst_t;
    rawData_t srcPixel;
    rawData_t rawWindow[5][5];
    int jiayou = 0;

    rawData_t lineBuf[4][4096];
    #pragma HLS array_partition variable=lineBuf
    pixel_t outPixel;
    outer_loop:for(uint13 row = 0; row < top_register.frameHeight; row++){
        #pragma HLS loop_merge
        #pragma HLS loop_tripcount max=8192 avg=1920
        inner_loop:for(uint13 col = 0; col < top_register.frameWidth; col++){
            #pragma HLS pipeline
            #pragma HLS loop_tripcount avg=1080

            srcPixel = src.read();
            if(demosaic_register.eb == 1) {
                window_loop:for(uint3 i = 0; i < 5; i++){
                    #pragma HLS unroll
                    rawWindow[i][0] = rawWindow[i][1];
                    rawWindow[i][1] = rawWindow[i][2];
                    rawWindow[i][2] = rawWindow[i][3];
                    rawWindow[i][3] = rawWindow[i][4];
                }

                rawWindow[0][4] = lineBuf[0][col];
                rawWindow[1][4] = lineBuf[1][col];
                rawWindow[2][4] = lineBuf[2][col];
                rawWindow[3][4] = lineBuf[3][col];
                rawWindow[4][4] = srcPixel;
                lineBuf[0][col] = lineBuf[1][col];
                lineBuf[1][col] = lineBuf[2][col];
                lineBuf[2][col] = lineBuf[3][col];
                lineBuf[3][col] = srcPixel;

                if((row > 3) && (col > 3)/* && (row < (top_register.frameHeight)) && (col < (top_register.frameWidth))*/){
                    uint2 bayerPattern = (((row & 1) << 1) + (col & 1))^top_register.imgPattern;
                    outPixel = demosaicInterpol(rawWindow, bayerPattern);
                    dst_t(35,24) = outPixel.r;
                    dst_t(23,12) = outPixel.g;
                    dst_t(11,0) = outPixel.b;
                    #ifdef DEBUG
                    if((col == COL_TEST + 2) && (row == ROW_TEST + 2)) {
                        printf("%8x\n",dst_t.to_long());
                        printf("\t%x\t%x\n",row.to_int(),col.to_int());
                        printf("\tpattern = %d\n",bayerPattern.to_int());
                        printf("\t%x\t%x\t%x\t%x\t%x\n",rawWindow[0][0].to_int(),rawWindow[0][1].to_int(),rawWindow[0][2].to_int(),rawWindow[0][3].to_int(),rawWindow[0][4].to_int());
                        printf("\t%x\t%x\t%x\t%x\t%x\n",rawWindow[1][0].to_int(),rawWindow[1][1].to_int(),rawWindow[1][2].to_int(),rawWindow[1][3].to_int(),rawWindow[1][4].to_int());
                        printf("\t%x\t%x\t%x\t%x\t%x\n",rawWindow[2][0].to_int(),rawWindow[2][1].to_int(),rawWindow[2][2].to_int(),rawWindow[2][3].to_int(),rawWindow[2][4].to_int());
                        printf("\t%x\t%x\t%x\t%x\t%x\n",rawWindow[3][0].to_int(),rawWindow[3][1].to_int(),rawWindow[3][2].to_int(),rawWindow[3][3].to_int(),rawWindow[3][4].to_int());
                        printf("\t%x\t%x\t%x\t%x\t%x\n",rawWindow[4][0].to_int(),rawWindow[4][1].to_int(),rawWindow[4][2].to_int(),rawWindow[4][3].to_int(),rawWindow[4][4].to_int());
                        printf("\t%x\t%x\t%x\n",outPixel.r.to_int(),outPixel.g.to_int(),outPixel.b.to_int());
                    }
                    #endif
                } else {
                    dst_t = 0;
                }
            } else {
                dst_t = (srcPixel << 24) | (srcPixel << 12) | srcPixel;
            }
            if((row > 2) || ((row==2) && (col > 1))){
                dst.write(dst_t);
            }
        }
    }
    addon_loop: for (uint14 cnt = 0; cnt < 2*top_register.frameWidth + 2; cnt++){
        dst.write(0);
    }
};


//ee_module
inline uint12 ee_clip(int15 ee_result)
{
   if(ee_result > 4095)
      return 4095;
   else if(ee_result < 0)
      return 0;
   else
      return (uint12)ee_result;
}

inline uint12 ee_clip(int25 ee_result)
{
   if(ee_result > 4095)
      return 4095;
   else if(ee_result < 0)
      return 0;
   else
      return (uint12)ee_result;
}

uint36 eeprocess(uint36 ee_block[5][5], ee_register& ee_top)
{
    uint1  eb = ee_top.eb;
    uint4  coeff = ee_top.coeff;
    const static uint5 guass_55[5][5] = {1,2,4,2,1,2,4,8,4,2,4,8,16,8,4,2,4,8,4,2,1,2,4,2,1};
    #pragma HLS ARRAY_PARTITION variable=guass_55 complete dim=1
    int23  sharpen_threhold_r = 0,sharpen_threhold_g = 0,sharpen_threhold_b = 0;
    int13  rblock[5][5],gblock[5][5],bblock[5][5];
    #pragma HLS ARRAY_PARTITION variable=rblock complete dim=1
    #pragma HLS ARRAY_PARTITION variable=bblock complete dim=1
    #pragma HLS ARRAY_PARTITION variable=gblock complete dim=1
    int14  feq_l[4] = {0};
    #pragma HLS ARRAY_PARTITION variable=feq_l complete dim=1
    int14  feq_h[4] = {0};
    #pragma HLS ARRAY_PARTITION variable=feq_h complete dim=1
    int14  result_v[5] = {0};
    #pragma HLS ARRAY_PARTITION variable=result_v complete dim=1

    int15  low_feq_r = 0,low_feq_g = 0,low_feq_b = 0;
    int15  high_feq_r = 0,high_feq_g = 0,high_feq_b = 0;
    int15  temp_r = 0,temp_g = 0,temp_b = 0;
    int24  r_middle = 0,g_middle = 0,b_middle = 0;
    int25  r_result = 0,g_result = 0, b_result = 0;

    uint3 k,l;
    uint36 result;
    ee_pixel_t center;

   //prepare
    for(k = 0;k < 5 ;k++)
    {
        for(l = 0;l < 5 ;l++)
        {
            rblock[k][l] = (int13)(ee_block[k][l] >> 24);
            gblock[k][l] = (int13)((ee_block[k][l] >> 12) & 0xfff);
            bblock[k][l] = (int13)(ee_block[k][l] & 0xfff);
            sharpen_threhold_r += guass_55[k][l] * rblock[k][l];
            sharpen_threhold_g += guass_55[k][l] * gblock[k][l];
            sharpen_threhold_b += guass_55[k][l] * bblock[k][l];
        }
    }

    sharpen_threhold_r = sharpen_threhold_r >> 10;
    sharpen_threhold_g = sharpen_threhold_g >> 10;
    sharpen_threhold_b = sharpen_threhold_b >> 10;

    center.r = ee_block[2][2] >> 24;
    center.g = gblock[2][2];
    center.b = ee_block[2][2] & 0xfff;

    //process r
    for(k = 0; k < 5; k++) {
        for (l = 0; l < 4; l++) {

            feq_l[l] = rblock[l][k]/2 + rblock[l + 1][k]/2;
            feq_h[l] = rblock[l][k]/2 - rblock[l + 1][k]/2;

            if(feq_h[l] > sharpen_threhold_r)
            {
                feq_h[l] -= sharpen_threhold_r;
            }
            else if(feq_h[l] < - sharpen_threhold_r)
            {
                feq_h[l] += sharpen_threhold_r;
            }
            else
            {
                feq_h[l] = 0;
            }
        }

        temp_r = feq_l[1]/2 + feq_h[1]/2 + feq_l[2]/2 + feq_h[2]/2;
        result_v[k] = ee_clip(temp_r);

    }

    for(k = 0; k < 4; k++) {

        feq_l[k] = result_v[k]/2 + result_v[k+1]/2;
        feq_h[k] = result_v[k]/2 - result_v[k+1]/2;

        if(feq_h[k] > sharpen_threhold_r)
        {
            feq_h[k] -= sharpen_threhold_r;
        }
        else if(feq_h[k] < -sharpen_threhold_r)
        {
            feq_h[k] += sharpen_threhold_r;
        }
        else
        {
            feq_h[k] = 0;
        }
    }

    temp_r = feq_l[1]/2 + feq_h[1]/2 + feq_l[2]/2 + feq_h[2]/2;


    //process g
    for(k = 0; k < 5; k++) {
        for (l = 0; l < 4; l++) {

            feq_l[l] = gblock[l][k]/2 + gblock[l + 1][k]/2;
            feq_h[l] = gblock[l][k]/2 - gblock[l + 1][k]/2;

            if(feq_h[l] > sharpen_threhold_g)
            {
                feq_h[l] -= sharpen_threhold_g;
            }
            else if(feq_h[l] < - sharpen_threhold_g)
            {
                feq_h[l] += sharpen_threhold_g;
            }
            else
            {
                feq_h[l] = 0;
            }
        }

        temp_g = feq_l[1]/2 + feq_h[1]/2 + feq_l[2]/2 + feq_h[2]/2;
        result_v[k] = ee_clip(temp_g);

    }

    for(k = 0; k < 4; k++) {

        feq_l[k] = result_v[k]/2 + result_v[k+1]/2;
        feq_h[k] = result_v[k]/2 - result_v[k+1]/2;

        if(feq_h[k] > sharpen_threhold_g)
        {
            feq_h[k] -= sharpen_threhold_g;
        }
        else if(feq_h[k] < -sharpen_threhold_g)
        {
            feq_h[k] += sharpen_threhold_g;
        }
        else
        {
            feq_h[k] = 0;
        }
    }

    temp_g = feq_l[1]/2 + feq_h[1]/2 + feq_l[2]/2 + feq_h[2]/2;



    //process b
    for(k = 0; k < 5; k++) {
        for (l = 0; l < 4; l++) {

            feq_l[l] = bblock[l][k]/2 + bblock[l + 1][k]/2;
            feq_h[l] = bblock[l][k]/2 - bblock[l + 1][k]/2;

            if(feq_h[l] > sharpen_threhold_b)
            {
                feq_h[l] -= sharpen_threhold_b;
            }
            else if(feq_h[l] < - sharpen_threhold_b)
            {
                feq_h[l] += sharpen_threhold_b;
            }
            else
            {
                feq_h[l] = 0;
            }
        }

        temp_b = feq_l[1]/2 + feq_h[1]/2 + feq_l[2]/2 + feq_h[2]/2;
        result_v[k] = ee_clip(temp_b);

    }

    for(k = 0; k < 4; k++) {

        feq_l[k] = result_v[k]/2 + result_v[k+1]/2;
        feq_h[k] = result_v[k]/2 - result_v[k+1]/2;

        if(feq_h[k] > sharpen_threhold_b)
        {
            feq_h[k] -= sharpen_threhold_b;
        }
        else if(feq_h[k] < -sharpen_threhold_b)
        {
            feq_h[k] += sharpen_threhold_b;
        }
        else
        {
            feq_h[k] = 0;
        }
    }

    temp_b = feq_l[1]/2 + feq_h[1]/2 + feq_l[2]/2 + feq_h[2]/2;

    low_feq_r =  ee_clip(temp_r);
    low_feq_g =  ee_clip(temp_g);
    low_feq_b =  ee_clip(temp_b);
    high_feq_r = (int15)rblock[2][2] - low_feq_r;
    high_feq_g = (int15)gblock[2][2] - low_feq_g;
    high_feq_b = (int15)bblock[2][2] - low_feq_b;
    r_middle = high_feq_r * ee_top.coeff + 8;
    g_middle = high_feq_g * ee_top.coeff + 8;
    b_middle = high_feq_b * ee_top.coeff + 8;
    r_result = (r_middle >> 4) + low_feq_r;
    g_result = (g_middle >> 4) + low_feq_g;
    b_result = (b_middle >> 4) + low_feq_b;
    center.r = ee_clip(r_result);
    center.g = ee_clip(g_result);
    center.b = ee_clip(b_result);
    result = (uint36)(center.r) << 24 | (uint36)(center.g) << 12 |(uint36)(center.b);
    return result;
}

void ee(top_register isp_top, ee_register ee_top, stream_u36& src, stream_u36& dst)
{
    uint36 src_in,dst_out;
    uint36 ee_block[5][5];
    #pragma HLS ARRAY_PARTITION variable=ee_block block factor=5 dim=1
    uint36 ee_lines[4][4096];
    #pragma HLS ARRAY_PARTITION variable=ee_lines block factor=4 dim=1
    uint13 i = 0,j = 0,count = 0;
    uint3  k,l;

    uint26 n;
    single_loop:for(n = 0;n < isp_top.frameHeight * isp_top.frameWidth;n++){
    #pragma HLS PIPELINE
        if(count == isp_top.frameWidth)
        {
            count = 0;
            i++;
        }

        count++;
        j = n - i * isp_top.frameWidth;

        src_in = src.read();

        block_refresh_loop_out:for(k = 0;k < 5;k++){
        #pragma HLS LOOP_FLATTEN
            block_refresh_loop_in:for(l = 0;l < 4;l++){
                ee_block[k][l] = ee_block[k][l+1];
            }
        }

        for(k = 0;k < 4;k++){
            ee_block[k][4] = ee_lines[k][j];
        }
        ee_block[4][4] = src_in;

        for(k = 0;k < 4;k++){
            ee_lines[k][j] = ee_block[k+1][4];
        }

        if(ee_top.eb)
        {
            if((i > 3) && (j > 3))
            {
                dst_out = eeprocess(ee_block, ee_top);
            }
            else
            {
                dst_out = ee_block[2][2];
            }

            if((i > 2) || ((i == 2) && (j >= 2)))
            {
                dst.write(dst_out);
            }
        }
        else
        {
            dst_out = src_in;
            dst.write(dst_out);
        }
    }

   if(ee_top.eb)
   {
       padding_loop_1:for(k = 0;k < 2;k++){
        #pragma HLS unroll
           dst_out = ee_lines[1][isp_top.frameWidth - 2 + k];
           dst.write(dst_out);
       }

       padding_loop_2:for(k = 0;k < 2;k++){
        #pragma HLS unroll factor=2
           padding_loop_3:for(i = 0;i < isp_top.frameWidth;i++){
            #pragma HLS PIPELINE
               dst.write(ee_lines[k+2][i]);
           }
       }
   }
}
// cmc module

uint14 cmc_clip(int21 a, int lower, int upper){
    uint14 result;
    if(a < lower)
        result = lower;
    else if (a > upper)
        result = upper;
    else
        result = a;
    return result;
}

void cmc(const top_register top_register, const cmc_register cmc_register, stream_u36 &src, stream_u42 &dst, const int16 m_nGain[9]) {
    uint12 src_w[3];
    uint14 dst_w[3];
    uint36 src_t;
    uint42 dst_t;
    uint15 temp_disable;
    uint6  ratio;
    int13  red;
    int13  green;
    int13  blue;
    uint12 h = 0;
    uint14 temph;
    uint11 tempblc;
    int31  temp1;
    int21  temp2;
    int16  gain[12];
    #pragma HLS array_partition variable=gain

    cmc_row: for (uint13 y=0; y<top_register.frameHeight; y++){
    #pragma HLS loop_merge
    #pragma HLS loop_tripcount max=8192 avg=1920
        cmc_col: for (uint13 x=0; x<top_register.frameWidth; x++){
        #pragma HLS pipeline
        #pragma HLS loop_tripcount avg=1080
            src_t = src.read();
            src_w[0] = src_t >> 24;
            src_w[1] = (src_t >> 12) & 0xfff;
            src_w[2] = src_t & 0xfff;
            if(cmc_register.m_nEb == 1) {
                red = src_w[0] - top_register.blc;
                green = src_w[1] - top_register.blc;
                blue = src_w[2] - top_register.blc;

                if(cmc_register.m_bCFCEnable) {
                    ratio = cmc_register.m_nCFCStrength;
                } else {
                    ratio = 0;
                }

                cmc_cal1: for(int i = 0; i < 12; i++){
                    #pragma HLS unroll
                    //set_directive_unroll "cmc/cmc_cal1"
                    if(0 == i || 5 == i || 10 == i){
                        gain[i] = m_nGain[i] + (ratio << 6) - ((m_nGain[i] * ratio) >> 6);
                    } else if (3 == i || 7 == i || 11 == i){
                        gain[i] = m_nGain[i];
                    } else {
                        gain[i] = m_nGain[i] - (((m_nGain[i]) * ratio) >> 6);
                    }
                }

                if(cmc_register.m_bDiscardH) {
                    temph = 0;
                } else {
                    temph = (h<<2) | 0x3;
                }

                tempblc = (top_register.blc << 2) | 0x3;
                cmc_cal2: for (int k=0; k<3; k++){
                    #pragma HLS unroll
                    temp1 = red*gain[k*4] + green*gain[k*4+1] + blue*gain[k*4+2] + CMC_HALF_VALUE;
                    temp2 = (temp1 >> CMC_SHIFT_DEEP) + temph + tempblc + gain[k*4+3];

                    #ifdef DEBUG
                    if((y == ROW_TEST) && (x == COL_TEST)){
                        printf("\t%x\t%x\n",temph.to_int(),tempblc.to_int());
                        printf("\t%x\t%x\t%x\n",gain[k*3].to_int(),gain[k*3+1].to_int(),gain[k*3+2].to_int());
                    }
                    #endif
                    dst_w[k] = cmc_clip(temp2,0,CMC_MAX_VALUE);
                }
            } else {
                cmc_cal3: for (int k=0; k<3; k++) {
                    #pragma HLS unroll
                    temp_disable = ((src_w[k] + (cmc_register.m_bDiscardH ? 0 : 0)) << 2) + 3;
                    //if (temp_disable > CMC_MAX_VALUE) {
                    //    dst_w[k] = CMC_MAX_VALUE;
                    //} else {
                        dst_w[k] = temp_disable;
                    //}
                }
            }

            #ifdef DEBUG
            if((y == ROW_TEST) && (x == COL_TEST)){
                printf("\t%x\t%x\n",temph.to_int(),tempblc.to_int());
                printf("\t%x\t%x\t%x\n",red.to_int(),green.to_int(),blue.to_int());
                printf("\t%x\t%x\t%x\n",dst_w[0].to_int(),dst_w[1].to_int(),dst_w[2].to_int());
            }
            #endif

            dst_t(41,28) = dst_w[0];
            dst_t(27,14) = dst_w[1];
            dst_t(13,0) = dst_w[2];
            dst.write(dst_t);
        }
    }
};

// gtm module

uint14 gtm_clip(int16 a, int lower, int upper) {
    uint14 result;
    if (a < lower)
        result = lower;
    else if (a > upper)
        result = upper;
    else
        result = a;
    return result;
};

void gtm(const top_register top_register, const gtm_register gtm_register, stream_u42 &src, stream_u42 &dst, const uint10 gtmTab[132]) {
    uint14 src_w[3];
    uint14 dst_w[3];
    uint42 src_t;
    uint42 dst_t;
    uint7  index;
    uint14 y_pos0;
    uint14 y_pos1;
    int15  y_value;
    uint7  x_value;
    int17  temp1;
    int18  temp2;
    int16  temp3;
    uint5  seed[6] = {8,8,8,8,8,8};
    #pragma HLS array_partition variable=seed
    gtm_row: for (uint13 y=0; y<top_register.frameHeight; y++){
        #pragma HLS loop_merge
        #pragma HLS loop_tripcount max=8192 avg=1920
        gtm_col: for (uint13 x=0; x<top_register.frameWidth; x++){
            #pragma HLS pipeline
            #pragma HLS loop_tripcount avg=1080
            src_t = src.read();
            src_w[0] = src_t >> 28;
            src_w[1] = (src_t >> 14) & 0x3fff;
            src_w[2] = src_t & 0x3fff;
            bool y0 = y & 0x1;

            if(gtm_register.eb == 1) {
                gtm_cal: for (int k=0; k<3; k++) {
                    #pragma HLS unroll
                    index = src_w[k] >> 7;
                    x_value = src_w[k] & 0x7f;
                    if (gtmTab[index] !=0) {
                        y_pos0 = gtmTab[index] * 16 + 15;
                    } else {
                        y_pos0 = 0;
                    }
                    if (gtmTab[index+1] !=0) {
                        y_pos1 = gtmTab[index+1] * 16 + 15;
                    } else {
                        y_pos1 = 1;
                    }
                    y_value = y_pos1-y_pos0;

                    if (index == 127) {
                        temp1 = (y_value * x_value * 129 + 2048) >> 12;
                    } else {
                        temp1 = (y_value * x_value + 16) >> 5;
                    }

                    if (gtm_register.m_bDitheringEnable) {
                        temp2 = y_pos0*4 + temp1 + seed[y0*3+k];
                        seed[y0*3+k] = temp2 & 0x1f;
                        temp3 = temp2 >> 2;
                    } else {
                        temp3 = y_pos0 + ((temp1+2) >> 2);
                    }
                    dst_w[k] = gtm_clip(temp3,0,16383);

                    #ifdef DEBUG
                    if((x == COL_TEST) && (y == ROW_TEST)) {
                        printf("\t%x\t%x\t%x\n",temp1.to_int(),temp2.to_int(),temp3.to_int());
                        printf("\t%x\t%x\t%x\n",index.to_int(),y_pos0.to_int(),y_pos1.to_int());
                        printf("\t%x\t%x\t%x\n",src_w[k].to_int(),dst_w[k].to_int(),y_value.to_int());
                    }
                    #endif
                }
            } else {
                dst_w[0] = src_w[0];
                dst_w[1] = src_w[1];
                dst_w[2] = src_w[2];
            }
            dst_t(41,28) = dst_w[0];
            dst_t(27,14) = dst_w[1];
            dst_t(13,0) = dst_w[2];
            dst.write(dst_t);
        }
    }
};
// csc module

uint10 csc_clip(int13 a, int lower, int upper) {
    uint10 result;
    if (a < lower)
        result = lower;
    else if (a > upper)
        result = upper;
    else
        result = a;
    return result;
}

void csc(const top_register top_register, const csc_register csc_register, stream_u42 &src, stream_u30 &dst, const int11 coeff[12]) {
    int23  temp1;
    int13  temp2;
    uint42 src_t;
    uint30 dst_t;
    uint14 src_w[3];
    uint14 tmp_w[3];
    uint10 res_w[3];
    uint10 dst_w[3];
    uint4  seed[6] = {4,4,4,4,4,4};
    bool   y0;
    int    k;
    #pragma HLS array_partition variable=seed
    csc_row: for (uint13 y=0; y<top_register.frameHeight; y++){
        #pragma HLS loop_merge
        #pragma HLS loop_tripcount max=8192 avg=1920
        csc_col: for (uint13 x=0; x<top_register.frameWidth; x++){
            #pragma HLS pipeline
            #pragma HLS loop_tripcount avg=1080
            src_t = src.read();
            src_w[0] = src_t >> 28;
            src_w[1] = (src_t >> 14) & 0x3fff;
            src_w[2] = src_t & 0x3fff;
            y0 = y & 1;

            csc_cal1: for(k=0; k<3; k++) {
                #pragma HLS unroll
                tmp_w[k] = src_w[k]/4 + seed[y0*3+k];
                seed[y0*3+k] = tmp_w[k] & 0xf;
                if (tmp_w[k]/4 > 1023) {
                    res_w[k] = 0x3ff;
                } else {
                    res_w[k] = tmp_w[k]/4;
                }
            }

            if(csc_register.m_nEb == 1) {
                csc_cal2: for (k=0; k<3; k++) {
                    #pragma HLS unroll
                    temp1 = res_w[0]*coeff[4*k] + res_w[1]*coeff[4*k+1] + res_w[2]*coeff[4*k+2];
                    temp2 = ((temp1+512)>>10)+coeff[4*k+3];
                    dst_w[k] = csc_clip(temp2,0,1023);
                }
            } else {
                dst_w[0] = res_w[0];
                dst_w[1] = res_w[1];
                dst_w[2] = res_w[2];
            }
            dst_t(29,20) = dst_w[0];
            dst_t(19,10) = dst_w[1];
            dst_t(9,0) = dst_w[2];
           #ifdef DEBUG
           if((y == ROW_TEST) && (x == COL_TEST)){
               printf("\tcsc_in = %x\t%x\t%x\n",src_w[0].to_int(),src_w[1].to_int(),src_w[2].to_int());
               printf("\tcsc_out = %x\t%x\t%x\n",dst_w[0].to_int(),dst_w[1].to_int(),dst_w[2].to_int());
           }
           #endif
            dst.write(dst_t);
        }
    }
};

//yfc module

void yfc(top_register top_register, yfc_register yfc_register, stream_u30& src, stream_u10& y_dst, stream_u10& u_dst, stream_u10& v_dst) {
    uint30 src_t;
    uint10 y_t;
    uint10 u_t;
    uint10 v_t;
    uint11 u_tmp_422;
    uint11 v_tmp_422;
    uint12 u_tmp_420;
    uint12 v_tmp_420;
    uint10 u_linebuffer[4096];
    uint10 v_linebuffer[4096];

    yfc_row: for (uint13 y = 0; y < top_register.frameHeight; y++) {
        #pragma HLS loop_merge
        #pragma HLS loop_tripcount max=8192 avg=1920
        yfc_col: for (uint13 x = 0; x < top_register.frameWidth; x++) {
            #pragma HLS pipeline
            #pragma HLS loop_tripcount avg=1080

            src_t = src.read();
            y_t = src_t >> 20;
            u_t = (src_t >> 10) & 0x3ff;
            v_t = src_t & 0x3ff;

            if(yfc_register.m_nEb == 1)
            {
                if(yfc_register.yuvpattern == 0)
                {
                    if ((x & 1) == 0)
                    {
                        u_tmp_422 = u_t;
                        v_tmp_422 = v_t;
                        y_dst.write(y_t);
                    }
                    else
                    {
                        u_tmp_422 = u_tmp_422 + u_t;
                        v_tmp_422 = v_tmp_422 + v_t;
                        u_t = u_tmp_422 >> 1;
                        v_t = v_tmp_422 >> 1;
                        y_dst.write(y_t);
                        u_dst.write(u_t);
                        v_dst.write(v_t);
                    }
                }
                else if(yfc_register.yuvpattern == 1)
                {
                    if ((y & 1) == 0)
                    {
                        u_linebuffer[x] = u_t;
                        v_linebuffer[x] = v_t;
                        y_dst.write(y_t);
                    }
                    else
                    {
                        if ((x & 1) == 0)
                        {
                            u_tmp_420 = u_t + u_linebuffer[x];
                            v_tmp_420 = v_t + v_linebuffer[x];
                            y_dst.write(y_t);
                        }
                        else
                        {
                            u_tmp_420 = u_tmp_420 + u_t + u_linebuffer[x];
                            v_tmp_420 = v_tmp_420 + v_t + v_linebuffer[x];
                            u_t = u_tmp_420 >> 2;
                            v_t = v_tmp_420 >> 2;
                            y_dst.write(y_t);
                            u_dst.write(u_t);
                            v_dst.write(v_t);
                        }
                    }
                }
            }
            else
            {
                y_dst.write(y_t);
                u_dst.write(u_t);
                v_dst.write(v_t);
            }
        }
    }
}

//yuvdns module

#define YUVDNS_BIT_DEPTH    10// yuv image`data 10bits
#define YUVDNS_Max_Value    (1 << YUVDNS_BIT_DEPTH) - 1

uint32 yuvdns_weight2_clip(uint32 count){
    #pragma HLS INLINE
    if(count > 15)
        count = 15;
    else if(count < 0)
        count = 0;
    return (uint32)count;
}

uint10 yuvdns_abs(uint11 a, uint10 b){
    #pragma HLS INLINE
    uint10 dif;
    if(a > b)
        dif = a-b;
    else
        dif = b-a;
    return dif;
}

uint10 yuvdns_clip(uint10 a,int upper,int lower) {
    if (a < lower)
        a = lower;
    else if (a > upper)
        a = upper;
    return (uint10)a;
}


uint10 yuvdns_nlm(uint10 Window[9][9],uint14 sigma2, uint14 H2,uint18 invH2){
    #pragma HLS allocation function instances=yuvdns_nlm limit=3
    uint8  weight_1[8]={255,226,200,176,156,138,122,108};
    uint8  weight_2[16]={88,72,59,48,39,32,26,21,17,14,11,9,7,5,2,0};

    uint21 diff;
    uint22 diff_1;
    uint22 diff_2;
    uint22 diff_3;
    uint28 diff_tmp; 
    uint8 weight = 0, maxweight = 0; 
    uint14 totalweight =0; 
    uint25 totalvalue = 0;
    nlm_row_loop:for (uint4 j = 1; j < 8; j++){
        #pragma HLS LOOP_TRIPCOUNT max=7 min=3
        nlm_col_loop:for (uint4 i = 1; i < 8; i++) {
            #pragma HLS LOOP_TRIPCOUNT max=7 min=3
            #pragma HLS PIPELINE
            if (i != 4 || j != 4) {
                uint10 dis_1 = 0;
                uint20 dis_11 = 0;
                dis_1 = yuvdns_abs(Window[j-1][i-1],Window[3][3]);
                dis_11 =  dis_1 * dis_1;

                uint10 dis_2 = 0;
                uint20 dis_22 = 0;
                dis_2 = yuvdns_abs(Window[j-1][i],Window[3][4]);
                dis_22 =  dis_2 * dis_2;

                uint10 dis_3 = 0;
                uint20 dis_33 = 0;
                dis_3 = yuvdns_abs(Window[j-1][i+1],Window[3][5]);
                dis_33 = dis_3 * dis_3;

                uint10 dis_4 = 0;
                uint20 dis_44 = 0;
                dis_4 = yuvdns_abs(Window[j][i-1],Window[4][3]);
                dis_44 = dis_4 * dis_4;

                uint10 dis_5 = 0;
                uint20 dis_55 = 0;
                dis_5 = yuvdns_abs(Window[j][i],Window[4][4]);
                dis_55 = dis_5 * dis_5;

                uint10 dis_6 = 0;
                uint20 dis_66 = 0;
                dis_6 = yuvdns_abs(Window[j][i+1],Window[4][5]);
                dis_66 = dis_6 * dis_6;

                uint10 dis_7 = 0;
                uint20 dis_77 = 0;
                dis_7 = yuvdns_abs(Window[j+1][i-1],Window[5][3]);
                dis_77 = dis_7 * dis_7;

                uint10 dis_8 = 0;
                uint20 dis_88 = 0;
                dis_8 = yuvdns_abs(Window[j+1][i],Window[5][4]);
                dis_88 = dis_8 * dis_8;

                uint10 dis_9 = 0;
                uint20 dis_99 = 0;
                dis_9 = yuvdns_abs(Window[j+1][i+1],Window[5][5]);
                dis_99 = dis_9 * dis_9;

                diff_1 = dis_11 + dis_22 + dis_33;
                diff_2 = dis_44 + dis_55 + dis_66;
                diff_3 = dis_77 + dis_88 + dis_99;

                diff = (diff_1 + diff_2 + diff_3) >> 3;

                if(diff < 2 * sigma2){
                    diff = 0;
                }else{
                    diff = diff - 2 * sigma2;
                }

                uint32 count = 0;
                if(H2 == 0){
                    weight = 0;
                }                   
                else if(diff <= H2){
                    diff_tmp = 7 * diff;
                    count = (diff_tmp * invH2)>>14;
                    weight = weight_1[count];
                }
                else{
                    diff_tmp = 5 * diff;
                    count = (diff_tmp * invH2)>>14;
                    count = yuvdns_weight2_clip((count -5));
                    weight = weight_2[count];
                }

                if(weight > maxweight){
                    maxweight = weight;
                }
                totalweight = totalweight + weight;
                totalvalue = totalvalue + Window[j][i] * weight;
           }
        }
    }
    totalweight =  totalweight + maxweight;
    totalvalue = totalvalue + Window[4][4] * maxweight;

    if(totalweight==0)
        return Window[4][4];
    else
        return yuvdns_clip(totalvalue / totalweight, YUVDNS_Max_Value, 0);
}

void yuv444dns(top_register top_register, yuvdns_register yuvdns_reg, stream_u10 &src_y, stream_u10 &src_u, stream_u10 &src_v, stream_u10 &dst_y, stream_u10 &dst_u, stream_u10 &dst_v){
    uint10 y_t;
    uint10 u_t;
    uint10 v_t;
    uint10 y_dst_t;
    uint10 u_dst_t;
    uint10 v_dst_t;
    uint10 yWindow[9][9];
    uint10 uWindow[9][9];
    uint10 vWindow[9][9];
    uint10 ylineBuf[8][4096];
    uint10 ulineBuf[8][4096];
    uint10 vlineBuf[8][4096];

    #pragma HLS array_partition variable=yWindow dim=0 complete   
    #pragma HLS array_partition variable=uWindow dim=0 complete   
    #pragma HLS array_partition variable=vWindow dim=0 complete   
    #pragma HLS array_partition variable=ylineBuf dim=1 block factor=8
    #pragma HLS array_partition variable=ulineBuf dim=1 block factor=8    
    #pragma HLS array_partition variable=vlineBuf dim=1 block factor=8    

    yuvdns_row:for(uint13 row = 0;row < top_register.frameHeight; row++){
        #pragma HLS LOOP_MERGE
        #pragma HLS LOOP_TRIPCOUNT max=7680 avg=1920
        yuvdns_col:for(uint13 col = 0 ;col < top_register.frameWidth; col++){
            #pragma HLS LOOP_TRIPCOUNT max=4320 avg=1080
            #pragma HLS PIPELINE            
            y_t = src_y.read();
            u_t = src_u.read();
            v_t = src_v.read();
            if(yuvdns_reg.eb == 1){
                out_window_loop:for(uint4 i = 0; i < 9; i++){
                    #pragma HLS unroll
                    in_window_loop:for(uint4 j = 0; j < 8; j++){                           
                        yWindow[i][j] = yWindow[i][j+1];
                        uWindow[i][j] = uWindow[i][j+1];
                        vWindow[i][j] = vWindow[i][j+1];
                    }
                }

                window_read:for(uint4 i = 0; i < 8; i++){
                    #pragma HLS unroll
                    yWindow[i][8] = ylineBuf[i][col];
                    uWindow[i][8] = ulineBuf[i][col];
                    vWindow[i][8] = vlineBuf[i][col];
                }
                    yWindow[8][8] = y_t;
                    uWindow[8][8] = u_t;
                    vWindow[8][8] = v_t;

                lines_read:for(uint4 i = 0; i < 7; i++){
                    #pragma HLS unroll
                    ylineBuf[i][col] = ylineBuf[i+1][col];
                    ulineBuf[i][col] = ulineBuf[i+1][col];
                    vlineBuf[i][col] = vlineBuf[i+1][col];
                }
                    ylineBuf[7][col] = y_t;
                    ulineBuf[7][col] = u_t;     
                    vlineBuf[7][col] = v_t;     

                yuvdns:if((row > 7) && (col > 7)){
                    y_dst_t = yuvdns_nlm(yWindow,yuvdns_reg.ysigma2,yuvdns_reg.yH2,yuvdns_reg.yinvH2);
                    u_dst_t = yuvdns_nlm(uWindow,yuvdns_reg.uvsigma2,yuvdns_reg.uvH2,yuvdns_reg.uvinvH2);
                    v_dst_t = yuvdns_nlm(vWindow,yuvdns_reg.uvsigma2,yuvdns_reg.uvH2,yuvdns_reg.uvinvH2);
                }
                else{
                    y_dst_t = yWindow[4][4];
                    u_dst_t = uWindow[4][4];
                    v_dst_t = vWindow[4][4];
                }
            }
            else{
                y_dst_t = y_t;
                u_dst_t = u_t;
                v_dst_t = v_t;
            }

            if((row > 4) || ((row == 4) && (col > 3))){
                dst_y.write(y_dst_t);
                dst_u.write(u_dst_t);
                dst_v.write(v_dst_t);
            }
        }
    }

    addon_loop_1: for (uint3 i = 0; i < 4; i++){
        #pragma HLS PIPELINE
        y_dst_t = yWindow[4][i+5];
        u_dst_t = uWindow[4][i+5];
        v_dst_t = vWindow[4][i+5];
        dst_y.write(y_dst_t);
        dst_u.write(u_dst_t);
        dst_v.write(v_dst_t);
    }
    addon_loop_2: for (uint3 i = 0; i < 4; i++){
        for(uint13 j = 0; j < top_register.frameWidth; j++){
            #pragma HLS PIPELINE
            y_dst_t = ylineBuf[i+4][j];
            u_dst_t = ulineBuf[i+4][j];
            v_dst_t   = vlineBuf[i+4][j];
            dst_y.write(y_dst_t);
            dst_u.write(u_dst_t);
            dst_v.write(v_dst_t);
        }
    }
}

//scale module

void scale(top_register top_register, scale_register scale_register, stream_u10 &y_src, stream_u10 &u_src, stream_u10 &v_src, stream_u10& y_dst, stream_u10& u_dst, stream_u10& v_dst) {
    uint10 y_t;
    uint10 u_t;
    uint10 v_t;
    uint15 y_tmp;
    uint15 u_tmp;
    uint15 v_tmp;
    uint10 y_linebuffer[4096];
    uint10 u_linebuffer[4096];
    uint10 v_linebuffer[4096];

    scale_row: for (uint13 y = 0; y < top_register.frameHeight; y++) {
        #pragma HLS loop_merge
        #pragma HLS loop_tripcount max=8192 avg=1920
        scale_col: for (uint13 x = 0; x < top_register.frameWidth; x++) {
            #pragma HLS pipeline
            #pragma HLS loop_tripcount avg=1080

            y_t = y_src.read();
            u_t = u_src.read();
            v_t = v_src.read();
            if(scale_register.m_nEb == 1)
            {
                if(scale_register.yuvpattern == 0)
                {
                    if(scale_register.times == 2)
                    {
                        if ((y & 1) == 0)
                        {
                            y_linebuffer[x] = y_t;
                            u_linebuffer[x] = u_t;
                            v_linebuffer[x] = v_t;
                        }
                        else if ((x & 1) == 0)
                        {
                            y_tmp = y_t + y_linebuffer[x];
                            u_tmp = u_t + u_linebuffer[x];
                            v_tmp = v_t + v_linebuffer[x];
                        }
                        else
                        {
                            y_tmp = y_tmp + y_t + y_linebuffer[x];
                            u_tmp = u_tmp + u_t + u_linebuffer[x];
                            v_tmp = v_tmp + v_t + v_linebuffer[x];
                            y_t = y_tmp >> 2;
                            u_t = u_tmp >> 2;
                            v_t = v_tmp >> 2;
                            y_dst.write(y_t);
                            u_dst.write(u_t);
                            v_dst.write(v_t);
                        }
                    }
                }
            }
            else
            {
                y_dst.write(y_t);
                u_dst.write(u_t);
                v_dst.write(v_t);
            }
        }
    }
}

//crop module

void crop(top_register top_register, crop_register crop_register, stream_u10 &y_src, stream_u10 &u_src, stream_u10 &v_src, stream_u10& y_dst, stream_u10& u_dst, stream_u10& v_dst) {
    uint10 y_t;
    uint10 u_t;
    uint10 v_t;

    crop_row: for (uint13 y = 0; y < top_register.frameHeight; y++) {
        #pragma HLS loop_merge
        #pragma HLS loop_tripcount max=8192 avg=1920
        crop_col: for (uint13 x = 0; x < top_register.frameWidth; x++) {
            #pragma HLS pipeline
            #pragma HLS loop_tripcount avg=1080

            //yuv444 pattern
            if(crop_register.yuvpattern == 0)
            {
                y_t = y_src.read();
                u_t = u_src.read();
                v_t = v_src.read();

                if(crop_register.m_nEb == 1)
                {
                    if ((y >= crop_register.upper_left_y) && (y < crop_register.lower_right_y) && (x >= crop_register.upper_left_x) && (x < crop_register.lower_right_x))
                    {
                        y_dst.write(y_t);
                        u_dst.write(u_t);
                        v_dst.write(v_t);
                    }
                }
                else
                {
                    y_dst.write(y_t);
                    u_dst.write(u_t);
                    v_dst.write(v_t);
                }
            }

            //yuv422 pattern
            else if(crop_register.yuvpattern == 1)
            {
                if((x & 1) == 0)
                {
                    y_t = y_src.read();
                }
                else
                {
                    y_t = y_src.read();
                    u_t = u_src.read();
                    v_t = v_src.read();
                }

                if(crop_register.m_nEb == 1)
                {
                    if ((y >= crop_register.upper_left_y) && (y < crop_register.lower_right_y) && (x >= crop_register.upper_left_x) && (x < crop_register.lower_right_x))
                    {
                        if((x & 1) == 0)
                        {
                            y_dst.write(y_t);
                        }
                        else
                        {
                            y_dst.write(y_t);
                            u_dst.write(u_t);
                            v_dst.write(v_t);
                        }
                    }
                }
                else
                {
                    if((x & 1) == 0)
                    {
                        y_dst.write(y_t);
                    }
                    else
                    {
                        y_dst.write(y_t);
                        u_dst.write(u_t);
                        v_dst.write(v_t);
                    }
                }
            }

            //yuv420 pattern
            else if(crop_register.yuvpattern == 2)
            {
                if((y & 1) == 0 || (x & 1) == 0)
                {
                    y_t = y_src.read();
                }
                else
                {
                    y_t = y_src.read();
                    u_t = u_src.read();
                    v_t = v_src.read();
                }

                if(crop_register.m_nEb == 1)
                {
                    if ((y >= crop_register.upper_left_y) && (y < crop_register.lower_right_y) && (x >= crop_register.upper_left_x) && (x < crop_register.lower_right_x))
                    {
                        if((y & 1) == 0 || (x & 1) == 0)
                        {
                            y_dst.write(y_t);
                            u_dst.write(u_t);
                            v_dst.write(v_t);
                        }
                    }
                }
                else
                {
                    if((y & 1) == 0 || (x & 1) == 0)
                    {
                        y_dst.write(y_t);
                    }
                    else
                    {
                        y_dst.write(y_t);
                        u_dst.write(u_t);
                        v_dst.write(v_t);
                    }
                }
            }

        }
    }
}

inline void config_reg(
                    const tab_t* config_ptr,
                    top_register& top_reg,
                    tpg_register& tpg_reg,
                    dgain_register& dgain_reg,
                    lsc_register& lsc_reg,
                    dpc_register& dpc_reg,
                    rawdns_register& rawdns_reg,
                    awb_register& awb_reg,
                    wbc_register& wbc_reg,
                    gb_register& gb_reg,
                    demosaic_register& demosaic_reg,
                    ee_register& ee_reg,
                    cmc_register& cmc_reg,
                    gtm_register& gtm_reg,
                    csc_register& csc_reg,
                    yfc_register& yfc_reg,
                    yuvdns_register& yuvdns_reg,
                    scale_register& scale_reg,
                    crop_register& crop_reg,
                    uint13 rGain[224],
                    uint13 GrGain[224],
                    uint13 GbGain[224],
                    uint13 bGain[224],
                    int16 cmc_m_nGain[12],
                    uint10 gtm_gtmTab[132],
                    int11 csc_coeff[12]){

    ap_uint<64> tdgc_small = config_ptr[252];//top_demosaic_gtm_csc_number.range(63, 0);
    ap_uint<64> tdgc_large = config_ptr[253];//top_demosaic_gtm_csc_number.range(127, 64);

    // top reg
    top_reg.frameWidth  = tdgc_small.range(12, 0);
    top_reg.frameHeight = tdgc_small.range(25, 13);
    top_reg.inputFormat = tdgc_small.range(26, 26);
    top_reg.imgPattern  = tdgc_small.range(28, 27);
    top_reg.pipeMode    = tdgc_small.range(30, 29);
    top_reg.blc         = tdgc_small.range(39, 31);
    top_reg.shadowEb    = tdgc_small.range(40, 40);
    top_reg.binningFrameWidth = tdgc_small.range(53, 41);

    top_reg.binningFrameHeight = tdgc_large.range(12, 0);
    top_reg.scalerFrameWidth   = tdgc_large.range(25, 13);
    top_reg.scalerFrameHeight  = tdgc_large.range(38, 26);

    // demosaic reg
    demosaic_reg.eb  = tdgc_large.range(39, 39);
    // gtm reg
    gtm_reg.eb       = tdgc_large.range(40, 40);
    gtm_reg.m_bDitheringEnable = tdgc_large.range(41, 41);
    // csc reg
    csc_reg.m_nEb    = tdgc_large.range(42, 42);
    // awb reg
    awb_reg.eb       = tdgc_large.range(43, 43);
    awb_reg.coeff    = tdgc_large.range(49, 44);

    ap_uint<64> tw_small = config_ptr[254];//tpg_wbc_number.range(63, 0);
    ap_uint<64> tw_large = config_ptr[255];//tpg_wbc_number.range(127, 64);

    // tpg reg
    tpg_reg.m_bTPG_en = tw_small.range(0,  0);
    tpg_reg.m_nWidth  = tw_small.range(13, 1);
    tpg_reg.m_nHeight = tw_small.range(26, 14);

    tpg_reg.m_bSensor_timing_en = tw_small.range(27, 27);
    tpg_reg.m_nVBlank_num = tw_small.range(39, 28);
    tpg_reg.m_nHBlank_num = tw_small.range(51, 40);
    tpg_reg.m_valid_blank = tw_small.range(59, 52);
    tpg_reg.m_nID         = tw_small.range(63, 60);

    tpg_reg.m_nCFAPattern = tw_large.range(1, 0);
    tpg_reg.m_bRollingEnable = tw_large.range(2, 2);

    // wbc reg
    wbc_reg.m_nEb = tw_large.range(3, 3);
    wbc_reg.m_nR  = tw_large.range(18, 4);
    wbc_reg.m_nGr = tw_large.range(33, 19);
    wbc_reg.m_nGb = tw_large.range(48, 34);
    wbc_reg.m_nB  = tw_large.range(63, 49);

    ap_uint<64> d_small = config_ptr[256];//dgain_number.range(63, 0);
    ap_uint<64> d_large = config_ptr[257];//dgain_number.range(127, 64);

    // dgain register
    dgain_reg.m_nEb    = d_small.range(0, 0);
    dgain_reg.m_nBlcR  = d_small.range(9, 1);
    dgain_reg.m_nBlcGr = d_small.range(18, 10);
    dgain_reg.m_nBlcGb = d_small.range(27, 19);
    dgain_reg.m_nBlcB  = d_small.range(36, 28);
    dgain_reg.m_nR     = d_small.range(56, 37);

    dgain_reg.m_nGr    = d_large.range(19, 0);
    dgain_reg.m_nGb    = d_large.range(39, 20);
    dgain_reg.m_nB     = d_large.range(59, 40);

    ap_uint<64> cly_small = config_ptr[258];//cmc_lsc_yfc_number.range(63, 0);
    ap_uint<64> cly_large = config_ptr[259];//cmc_lsc_yfc_number.range(127, 64);

    //cmc register
    cmc_reg.m_nEb = cly_small.range(0, 0);
    cmc_reg.m_bCFCEnable = cly_small.range(1, 1);
    cmc_reg.m_bDiscardH = cly_small.range(2, 2);
    cmc_reg.m_pHueRange[0] = cly_small.range(11, 3);
    cmc_reg.m_pHueRange[1] = cly_small.range(20, 12);
    cmc_reg.m_nHueBandShift = cly_small.range(23, 21);
    cmc_reg.m_nEdgeThre = cly_small.range(31, 24);
    cmc_reg.m_nEdgeBandShift = cly_small.range(34, 32);
    cmc_reg.m_nCFCStrength = cly_small.range(39, 35);

    //rawdns_reg
    rawdns_reg.eb = cly_small.range(40, 40);
    rawdns_reg.sigma = cly_small.range(46,41);
    rawdns_reg.Filterpara = cly_small.range(53,47);
    rawdns_reg.invksigma2 = cly_large.range(56,45);

    //lsc register
    lsc_reg.eb = cly_large.range(0,0);
    lsc_reg.blockHeight = cly_large.range(9,1);
    lsc_reg.blockWidth = cly_large.range(18,10);
    lsc_reg.blockWidth_1 = cly_large.range(32,19);
    lsc_reg.blockHeight_1 = cly_large.range(42,33);

    //yfc register
    yfc_reg.m_nEb = cly_large.range(43,43);
    yfc_reg.yuvpattern = cly_large.range(44,44);


    ap_uint<64> cg_small = config_ptr[260];//crop_gb_number.range(63, 0);
    ap_uint<64> cg_large = config_ptr[261];//crop_gb_number.range(127, 64);

    //crop register
    crop_reg.m_nEb = cg_small.range(0, 0);
    crop_reg.upper_left_x = cg_small.range(13, 1);
    crop_reg.upper_left_y = cg_small.range(26, 14);
    crop_reg.lower_right_x = cg_small.range(39, 27);
    crop_reg.lower_right_y = cg_small.range(52, 40);

    //gb register
    gb_reg.eb = cg_large.range(0, 0);
    gb_reg.win_size = cg_large.range(4, 1);
    gb_reg.Lbound = cg_large.range(8, 5);
    gb_reg.Hbound = cg_large.range(14, 9);
    gb_reg.threhold = cg_large.range(24, 15);

    //ee register
    ee_reg.eb = cg_large.range(25,25);
    ee_reg.coeff = cg_large.range(31,26);

    //dpc register
    dpc_reg.eb = cg_large.range(32,32);
    dpc_reg.th_w = cg_large.range(43,33);
    dpc_reg.th_b = cg_large.range(54,44);

    //scale_register
    scale_reg.m_nEb = cg_large.range(55,55);
    scale_reg.yuvpattern = cg_large.range(57,56);
    crop_reg.yuvpattern = cg_large.range(57,56);
    scale_reg.times = cg_large.range(62,58);

    ap_uint<64> cyd_small = config_ptr[262];//yuvdns_number.range(63, 0);
    ap_uint<64> cyd_large = config_ptr[263];//yuvdns_number.range(127, 64);

    //yuvdns_register
    yuvdns_reg.eb = cyd_small.range(0, 0);
    yuvdns_reg.ysigma2 = cyd_small.range(14, 1);
    yuvdns_reg.yinvsigma2 = cyd_small.range(24, 15);
    yuvdns_reg.uvsigma2 = cyd_small.range(38, 25);
    yuvdns_reg.uvinvsigma2 = cyd_small.range(48, 39);
    yuvdns_reg.yfilt = cyd_small.range(52, 49);
    yuvdns_reg.uvfilt = cyd_small.range(56, 53);
    yuvdns_reg.yinvfilt = cyd_large.range(4, 0);
    yuvdns_reg.uvinvfilt = cyd_large.range(9, 5);
    yuvdns_reg.yH2 = cyd_large.range(23,10);
    yuvdns_reg.yinvH2 = cyd_large.range(41,24);

    ap_uint<64> cyd2_small = config_ptr[264];//yuvdns2_number.range(63, 0);
    ap_uint<64> cyd2_large = config_ptr[265];//yuvdns2_number.range(127, 64);

    //yuvdns_register2
    yuvdns_reg.uvH2 = cyd2_small.range(13, 0);
    yuvdns_reg.uvinvH2 = cyd2_small.range(31, 14);

    for(int i = 0; i < 224 / 4; ++i){
    #pragma HLS unroll
        tab_t tmp = config_ptr[i];
        rGain[i*4+0] = tmp.range(12, 0);
        rGain[i*4+1] = tmp.range(25, 13);
        rGain[i*4+2] = tmp.range(38, 26);
        rGain[i*4+3] = tmp.range(51, 39);
    }
    for(int i = 0; i < 224 / 4; ++i){
    #pragma HLS unroll
        tab_t tmp = config_ptr[i+56];
        GrGain[i*4+0] = tmp.range(12, 0);
        GrGain[i*4+1] = tmp.range(25, 13);
        GrGain[i*4+2] = tmp.range(38, 26);
        GrGain[i*4+3] = tmp.range(51, 39);
    }
    for(int i = 0; i < 224 / 4; ++i){
    #pragma HLS unroll
        tab_t tmp = config_ptr[i+112];
        GbGain[i*4+0] = tmp.range(12, 0);
        GbGain[i*4+1] = tmp.range(25, 13);
        GbGain[i*4+2] = tmp.range(38, 26);
        GbGain[i*4+3] = tmp.range(51, 39);
    }
    for(int i = 0; i < 224 / 4; ++i){
    #pragma HLS unroll
        tab_t tmp = config_ptr[i+168];
        bGain[i*4+0] = tmp.range(12, 0);
        bGain[i*4+1] = tmp.range(25, 13);
        bGain[i*4+2] = tmp.range(38, 26);
        bGain[i*4+3] = tmp.range(51, 39);
    }
    for(int i = 0; i < 132 / 6; ++i){
    #pragma HLS unroll
        tab_t tmp = config_ptr[i+224];
        gtm_gtmTab[i*6+0] = tmp.range(9, 0);
        gtm_gtmTab[i*6+1] = tmp.range(19, 10);
        gtm_gtmTab[i*6+2] = tmp.range(29, 20);
        gtm_gtmTab[i*6+3] = tmp.range(39, 30);
        gtm_gtmTab[i*6+4] = tmp.range(49, 40);
        gtm_gtmTab[i*6+5] = tmp.range(59, 50);
    }
    for(int i = 0; i < 12/4; ++i){
    #pragma HLS unroll
        tab_t tmp = config_ptr[i+246];
        cmc_m_nGain[i*4+0] = tmp.range(15,0);
        cmc_m_nGain[i*4+1] = tmp.range(31,16);
        cmc_m_nGain[i*4+2] = tmp.range(47,32);
        cmc_m_nGain[i*4+3] = tmp.range(63,48);
    }
    for(int i = 0; i < 12/4; ++i){
    #pragma HLS unroll
        tab_t tmp = config_ptr[i+249];
        csc_coeff[i*4+0] = tmp.range(15,0);
        csc_coeff[i*4+1] = tmp.range(31,16);
        csc_coeff[i*4+2] = tmp.range(47,32);
        csc_coeff[i*4+3] = tmp.range(63,48);
    }
}

void load_in(const in_t* in_ptr, stream_u12& src, const top_register top_register){
    for(uint25 i = 0; i < top_register.frameHeight * top_register.frameWidth; ++i){
        #pragma HLS loop_tripcount max=7680*4320 avg=1920*1080
        #pragma HLS pipeline
        in_t tmp = in_ptr[i];
        src.write((uint12)(tmp));
    }
}

void store_out(stream_u10& dst_y, stream_u10& dst_u, stream_u10& dst_v, stream_u16& awb_gain_data, out_t* out_ptr, const crop_register crop_register){
    uint13 out_height = crop_register.lower_right_y - crop_register.upper_left_y;
    uint13 out_width = crop_register.lower_right_x - crop_register.upper_left_x;
    uint26 i;
    uint30 tmp;
    uint10 tmp_y;
    uint10 tmp_u;
    uint10 tmp_v;
    for(i = 0; i < out_height * out_width; i++){
        #pragma HLS loop_tripcount avg=2073600
        #pragma HLS pipeline
        #pragma HLS dependence variable=out_ptr inter false
        tmp_y = dst_y.read();
        tmp_u = dst_u.read();
        tmp_v = dst_v.read();
        tmp(29,20) = tmp_y;
        tmp(19,10) = tmp_u;
        tmp(9,0) = tmp_v;
        out_ptr[i] = ((out_t)(tmp));
    }
    out_ptr[out_height*out_width] = (out_t)(awb_gain_data.read());
    out_ptr[out_height*out_width + 1] = (out_t)(awb_gain_data.read());
    out_ptr[out_height*out_width + 2] = (out_t)(awb_gain_data.read());
}


void isp_dataflow(const in_t* in_ptr,
                out_t* out_ptr,
                const top_register& top_reg,
                const tpg_register& tpg_reg,
                const dgain_register& dgain_reg,
                const lsc_register& lsc_reg,
                const dpc_register& dpc_reg,
                const rawdns_register& rawdns_reg,
                const awb_register& awb_reg,
                const wbc_register& wbc_reg,
                const gb_register& gb_reg,
                const demosaic_register& demosaic_reg,
                const ee_register& ee_reg,
                const cmc_register& cmc_reg,
                const gtm_register& gtm_reg,
                const csc_register& csc_reg,
                const yfc_register& yfc_reg,
                const yuvdns_register& yuvdns_reg,
                const scale_register& scale_reg,
                const crop_register& crop_reg,
                const uint13 rGain[224],
                const uint13 GrGain[224],
                const uint13 GbGain[224],
                const uint13 bGain[224],
                const int16 cmc_m_nGain[12],
                const uint10 gtm_gtmTab[132],
                const int11 csc_coeff[12]) {
    #pragma HLS inline off
    #pragma HLS dataflow

    stream_u12 src;
    #pragma HLS STREAM variable=src

    stream_u12 tpg_dgain_data;
    #pragma HLS STREAM variable=tpg_dgain_data depth=2 dim=1
    stream_u12 dgain_lsc_data;
    #pragma HLS STREAM variable=dgain_lsc_data depth=2 dim=1
    stream_u12 lsc_dpc_data;
    #pragma HLS STREAM variable=lsc_dpc_data depth=2 dim=1
    stream_u12 dpc_rawdns_data;
    #pragma HLS STREAM variable=dpc_rawdns_data depth=2 dim=1
    stream_u12 rawdns_awb_data;
    #pragma HLS STREAM variable=rawdns_awb_data depth=2 dim=1
    stream_u12 awb_wbc_data;
    #pragma HLS STREAM variable=awb_wbc_data depth=2 dim=1
    stream_u16 awb_gain_data;
    #pragma HLS STREAM variable=awb_gain_data depth=2 dim=1
    stream_u12 wbc_gb_data;
    #pragma HLS STREAM variable=wbc_gb_data depth=2 dim=1
    stream_u12 gb_demosaic_data;
    #pragma HLS STREAM variable=gb_demosaic_data depth=2 dim=1
    stream_u36 demosaic_ee_data;
    #pragma HLS STREAM variable=demosaic_ee_data depth=2 dim=1
    stream_u36 ee_cmc_data;
    #pragma HLS STREAM variable=ee_cmc_data depth=2 dim=1
    stream_u42 cmc_gtm_data;
    #pragma HLS STREAM variable=cmc_gtm_data depth=2 dim=1
    stream_u42 gtm_csc_data;
    #pragma HLS STREAM variable=gtm_csc_data depth=2 dim=1
    stream_u30 csc_yfc_data;
    #pragma HLS STREAM variable=csc_yfc_data depth=2 dim=1
    stream_u10 yfc_yuvdns_data_y;
    #pragma HLS STREAM variable=yfc_yuvdns_data_y depth=2 dim=1
    stream_u10 yfc_yuvdns_data_u;
    #pragma HLS STREAM variable=yfc_yuvdns_data_u depth=2 dim=1
    stream_u10 yfc_yuvdns_data_v;
    #pragma HLS STREAM variable=yfc_yuvdns_data_v depth=2 dim=1
    stream_u10 yuvdns_scale_data_y;
    #pragma HLS STREAM variable=yuvdns_scale_data_y depth=2 dim=1
    stream_u10 yuvdns_scale_data_u;
    #pragma HLS STREAM variable=yuvdns_scale_data_u depth=2 dim=1
    stream_u10 yuvdns_scale_data_v;
    #pragma HLS STREAM variable=yuvdns_scale_data_v depth=2 dim=1
    stream_u10 scale_crop_data_y;
    #pragma HLS STREAM variable=scale_crop_data_y depth=2 dim=1
    stream_u10 scale_crop_data_u;
    #pragma HLS STREAM variable=scale_crop_data_u depth=2 dim=1
    stream_u10 scale_crop_data_v;
    #pragma HLS STREAM variable=scale_crop_data_v depth=2 dim=1
    stream_u10 dst_y;
    #pragma HLS STREAM variable=dst_y
    stream_u10 dst_u;
    #pragma HLS STREAM variable=dst_u
    stream_u10 dst_v;
    #pragma HLS STREAM variable=dst_v

    load_in(in_ptr, src, top_reg);
    tpg(top_reg, tpg_reg, src, tpg_dgain_data);
    dgain(top_reg, dgain_reg, tpg_dgain_data, dgain_lsc_data);
    lsc(top_reg, lsc_reg, dgain_lsc_data, lsc_dpc_data, rGain, GrGain, GbGain, bGain);
    dpc(top_reg, dpc_reg, lsc_dpc_data, dpc_rawdns_data);
    rawdns(top_reg, rawdns_reg, dpc_rawdns_data, rawdns_awb_data);
    awb(top_reg, awb_reg, rawdns_awb_data, awb_gain_data, awb_wbc_data);
    wbc(top_reg, wbc_reg, awb_wbc_data, wbc_gb_data);
    greenbalance2(top_reg, gb_reg, wbc_gb_data, gb_demosaic_data);
    demosaic(top_reg, demosaic_reg, gb_demosaic_data, demosaic_ee_data);
    ee(top_reg, ee_reg, demosaic_ee_data, ee_cmc_data);
    cmc(top_reg, cmc_reg, ee_cmc_data, cmc_gtm_data, cmc_m_nGain);
    gtm(top_reg, gtm_reg, cmc_gtm_data, gtm_csc_data, gtm_gtmTab);
    csc(top_reg, csc_reg, gtm_csc_data, csc_yfc_data, csc_coeff);
    yfc(top_reg, yfc_reg, csc_yfc_data, yfc_yuvdns_data_y, yfc_yuvdns_data_u, yfc_yuvdns_data_v);
    yuv444dns(top_reg, yuvdns_reg, yfc_yuvdns_data_y, yfc_yuvdns_data_u, yfc_yuvdns_data_v, yuvdns_scale_data_y, yuvdns_scale_data_u, yuvdns_scale_data_v);
    scale(top_reg, scale_reg, yuvdns_scale_data_y, yuvdns_scale_data_u, yuvdns_scale_data_v, scale_crop_data_y, scale_crop_data_u, scale_crop_data_v);
    crop(top_reg, crop_reg, scale_crop_data_y, scale_crop_data_u, scale_crop_data_v, dst_y, dst_u, dst_v);
    store_out(dst_y, dst_u, dst_v, awb_gain_data, out_ptr, crop_reg);
}


extern "C"{
    void isp_top(const in_t* in_ptr,
                out_t* out_ptr,
                const tab_t* config_ptr){
#pragma HLS interface m_axi port = in_ptr offset = slave bundle=gmem1
#pragma HLS interface m_axi port = out_ptr offset = slave bundle=gmem2
#pragma HLS interface m_axi port = config_ptr offset = slave bundle=gmem3

#pragma HLS interface s_axilite port = return

// global register definition
    top_register         top_reg;
    tpg_register         tpg_reg;
    dgain_register       dgain_reg;
    lsc_register         lsc_reg;
    dpc_register         dpc_reg;
    rawdns_register      rawdns_reg;
    awb_register         awb_reg;
    wbc_register         wbc_reg;
    gb_register          gb_reg;
    demosaic_register    demosaic_reg;
    ee_register          ee_reg;
    cmc_register         cmc_reg;
    gtm_register         gtm_reg;
    csc_register         csc_reg;
    yfc_register         yfc_reg;
    yuvdns_register      yuvdns_reg;
    scale_register       scale_reg;
    crop_register        crop_reg;
    uint13  rGain[224]; //13 bit
    uint13  GrGain[224]; //13 bit
    uint13  GbGain[224]; //13 bit
    uint13  bGain[224]; //13 bit
    uint10  gtmTab[132];    // modified
    int16   m_nGain[12];     // cmc
    int11  coeff[12];       // csc
    #pragma HLS array_partition variable=gtmTab
    #pragma HLS array_partition variable=m_nGain
    #pragma HLS array_partition variable=coeff
    #pragma HLS data_pack variable=top_reg
    #pragma HLS data_pack variable=tpg_reg
    #pragma HLS data_pack variable=dgain_reg
    #pragma HLS data_pack variable=lsc_reg
    #pragma HLS data_pack variable=dpc_reg
    #pragma HLS data_pack variable=rawdns_reg
    #pragma HLS data_pack variable=awb_reg
    #pragma HLS data_pack variable=wbc_reg
    #pragma HLS data_pack variable=gb_reg
    #pragma HLS data_pack variable=demosaic_reg
    #pragma HLS data_pack variable=ee_reg
    #pragma HLS data_pack variable=cmc_reg
    #pragma HLS data_pack variable=gtm_reg
    #pragma HLS data_pack variable=csc_reg
    #pragma HLS data_pack variable=yfc_reg
    #pragma HLS data_pack variable=yuvdns_reg
    #pragma HLS data_pack variable=scale_reg
    #pragma HLS data_pack variable=crop_reg


    config_reg( config_ptr,
                top_reg,
                tpg_reg,
                dgain_reg,
                lsc_reg,
                dpc_reg,
                rawdns_reg,
                awb_reg,
                wbc_reg,
                gb_reg,
                demosaic_reg,
                ee_reg,
                cmc_reg,
                gtm_reg,
                csc_reg,
                yfc_reg,
                yuvdns_reg,
                scale_reg,
                crop_reg,
                rGain,
                GrGain,
                GbGain,
                bGain,
                m_nGain,
                gtmTab,
                coeff
    );

    isp_dataflow(in_ptr,
                out_ptr,
                top_reg,
                tpg_reg,
                dgain_reg,
                lsc_reg,
                dpc_reg,
                rawdns_reg,
                awb_reg,
                wbc_reg,
                gb_reg,
                demosaic_reg,
                ee_reg,
                cmc_reg,
                gtm_reg,
                csc_reg,
                yfc_reg,
                yuvdns_reg,
                scale_reg,
                crop_reg,
                rGain,
                GrGain,
                GbGain,
                bGain,
                m_nGain,
                gtmTab,
                coeff);
    }
}


