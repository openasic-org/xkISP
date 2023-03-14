#include "dgain.h"

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

void dgain(top_register top_reg, dgain_register dgain_reg, stream_u12 &src, stream_u12 &dst){
    uint12 src_t;
    uint12 dst_t;
    uint13 y = 0, x = 0, count = 0;
    dgain_loop: for (uint26 n = 0; n < top_reg.frameHeight * top_reg.frameWidth; n++) {
        if(count == top_reg.frameWidth)
        {
            count = 0;
            x++;
        }
        count++;
        y = n - x * top_reg.frameWidth;
        src_t = src.read();
        if(dgain_reg.m_nEb == 1) {
            int34  dst_tmp;
            int22  dst_val;
            uint20 gain_w;
            uint9  blc_w;
            uint2  bayerPattern = (((y & 1) << 1) + (x & 1))^top_reg.imgPattern;

            if (bayerPattern == 0) {
                blc_w = dgain_reg.m_nBlcR;
                gain_w = dgain_reg.m_nR;
            } else if (bayerPattern == 1) {
                blc_w = dgain_reg.m_nBlcGr;
                gain_w = dgain_reg.m_nGr;
            } else if (bayerPattern == 2) {
                blc_w = dgain_reg.m_nBlcGb;
                gain_w = dgain_reg.m_nGb;
            } else {
                blc_w = dgain_reg.m_nBlcB;
                gain_w = dgain_reg.m_nB;
            }

            dst_tmp = (src_t - blc_w) * gain_w + GAIN_HALF_VALUE;
            dst_val = (dst_tmp >> GAIN_BITS) + top_reg.blc;
            dst_t = dgain_clip(dst_val,0,4095);
            #ifdef DEBUG
            if((x == top_reg.COL_TEST) && (y == top_reg.ROW_TEST)) {
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
};
