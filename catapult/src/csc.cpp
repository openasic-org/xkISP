#include "csc.h"

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

void csc(top_register top_reg, csc_register csc_reg, stream_u42 &src, stream_u30 &dst) {
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

    csc_row: for (uint13 y=0; y<top_reg.frameHeight; y++){
        csc_col: for (uint13 x=0; x<top_reg.frameWidth; x++){
            src_t = src.read();
            src_w[0] = src_t >> 28;
            src_w[1] = (src_t >> 14) & 0x3fff;
            src_w[2] = src_t & 0x3fff;
            y0 = y & 1;

            csc_cal1: for(k=0; k<3; k++) {
                tmp_w[k] = src_w[k]/4 + seed[y0*3+k];
                seed[y0*3+k] = tmp_w[k] & 0xf;
                if (tmp_w[k]/4 > 1023) {
                    res_w[k] = 0x3ff;
                } else {
                    res_w[k] = tmp_w[k]/4;
                }
            }

            if(csc_reg.m_nEb == 1) {
                csc_cal2: for (k=0; k<3; k++) {
                    temp1 = res_w[0]*csc_reg.coeff[4*k] + res_w[1]*csc_reg.coeff[4*k+1] + res_w[2]*csc_reg.coeff[4*k+2];
                    temp2 = ((temp1+512)>>10)+csc_reg.coeff[4*k+3];
                    dst_w[k] = csc_clip(temp2,0,1023);
                }
            } else {
                dst_w[0] = res_w[0];
                dst_w[1] = res_w[1];
                dst_w[2] = res_w[2];
            }
            #ifdef vivado
            dst_t(29,20) = dst_w[0];
            dst_t(19,10) = dst_w[1];
            dst_t(9,0) = dst_w[2];
            #endif
            #ifdef catapult
            dst_t.set_slc(20,dst_w[0]);
            dst_t.set_slc(10,dst_w[1]);
            dst_t.set_slc(0,dst_w[2]);
            #endif
            #ifdef DEBUG
            if((y == top_reg.ROW_TEST) && (x == top_reg.COL_TEST)){
                printf("\tcsc_in = %x\t%x\t%x\n",src_w[0].to_int(),src_w[1].to_int(),src_w[2].to_int());
                printf("\tcsc_out = %x\t%x\t%x\n",dst_w[0].to_int(),dst_w[1].to_int(),dst_w[2].to_int());
            }
            #endif
            dst.write(dst_t);
        }
    }
};
