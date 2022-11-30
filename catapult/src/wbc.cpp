#include "wbc.h"

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

void wbc(top_register top_reg, wbc_register wbc_reg, stream_u12 &src, stream_u12 &dst){
    uint12 src_t;
    uint12 dst_t;
    wbc_row: for (uint13 y=0; y<top_reg.frameHeight; y++){
        wbc_col: for (uint13 x=0; x<top_reg.frameWidth; x++){
            src_t = src.read();
            if(wbc_reg.m_nEb == 1) {
                int16  dst_val;
                uint15 gain_w;
                uint2  bayerPattern = (((y & 1) << 1) + (x & 1))^top_reg.imgPattern;

                if (bayerPattern == 0) {
                    gain_w = wbc_reg.m_nR;
                } else if (bayerPattern == 1) {
                    gain_w = wbc_reg.m_nGr;
                } else if (bayerPattern == 2) {
                    gain_w = wbc_reg.m_nGb;
                } else {
                    gain_w = wbc_reg.m_nB;
                }

                dst_val = (((src_t - top_reg.blc) * gain_w + 2048) >> 12) + top_reg.blc;
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
