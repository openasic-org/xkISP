#include "gtm.h"

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

void gtm(top_register top_reg, gtm_register gtm_reg, stream_u42 &src, stream_u42 &dst) {
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

    gtm_row: for (uint13 y=0; y<top_reg.frameHeight; y++){
        gtm_col: for (uint13 x=0; x<top_reg.frameWidth; x++){
            src_t = src.read();
            src_w[0] = src_t >> 28;
            src_w[1] = (src_t >> 14) & 0x3fff;
            src_w[2] = src_t & 0x3fff;
            bool y0 = y & 0x1;
            
            if(gtm_reg.eb == 1) {
                gtm_cal: for (int k=0; k<3; k++) {
                    index = src_w[k] >> 7;
                    x_value = src_w[k] & 0x7f;
                    if (gtm_reg.gtmTab[index] !=0) {
                        y_pos0 = gtm_reg.gtmTab[index] * 16 + 15;
                    } else {
                        y_pos0 = 0;
                    }
                    if (gtm_reg.gtmTab[index+1] !=0) {
                        y_pos1 = gtm_reg.gtmTab[index+1] * 16 + 15;
                    } else {
                        y_pos1 = 1;
                    }
                    y_value = y_pos1-y_pos0;

                    if (index == 127) {
                        temp1 = (y_value * x_value * 129 + 2048) >> 12;
                    } else {
                        temp1 = (y_value * x_value + 16) >> 5;
                    }

                    if (gtm_reg.m_bDitheringEnable) {
                        temp2 = y_pos0*4 + temp1 + seed[y0*3+k];
                        seed[y0*3+k] = temp2 & 0x1f;
                        temp3 = temp2 >> 2;
                    } else {
                        temp3 = y_pos0 + ((temp1+2) >> 2);
                    }
                    dst_w[k] = gtm_clip(temp3,0,16383);
                    #ifdef DEBUG
                    if((x == COL_TEST) & (y == ROW_TEST)){
                        printf("\tgtm_tmp = %x\t%x\t%x\n",temp1.to_int(),temp2.to_int(),temp3.to_int());
                        printf("\tgtm_index = %x\t%x\t%x\n",index.to_int(),y_pos0.to_int(),y_pos1.to_int());
                        printf("\tgtm_data = %x\t%x\t%x\n",src_w[k].to_int(),dst_w[k].to_int(),y_value.to_int());
                    }
                    #endif
                }
            } else {
                dst_w[0] = src_w[0];
                dst_w[1] = src_w[1];
                dst_w[2] = src_w[2];
            }
            #ifdef vivado
            dst_t(41,28) = dst_w[0];
            dst_t(27,14) = dst_w[1];
            dst_t(13,0) = dst_w[2];
            #endif
            #ifdef catapult
            dst_t.set_slc(28,dst_w[0]);
            dst_t.set_slc(14,dst_w[1]);
            dst_t.set_slc(0,dst_w[2]);
            #endif
            dst.write(dst_t);
        }
    }
};
