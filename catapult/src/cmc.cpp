#include "cmc.h"

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

void cmc(top_register top_reg, cmc_register cmc_reg, stream_u36 &src, stream_u42 &dst) {
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
    int21  temp2;
    int31  temp1;
    int16  gain[12];

    cmc_row: for (uint13 y=0; y<top_reg.frameHeight; y++){
        cmc_col: for (uint13 x=0; x<top_reg.frameWidth; x++){
            src_t = src.read();
            src_w[0] = src_t >> 24;
            src_w[1] = (src_t >> 12) & 0xfff;
            src_w[2] = src_t & 0xfff;
            if(cmc_reg.m_nEb == 1) {
                red = src_w[0] - top_reg.blc;
                green = src_w[1] - top_reg.blc;
                blue = src_w[2] - top_reg.blc;

                if(cmc_reg.m_bCFCEnable) {
                    ratio = cmc_reg.m_nCFCStrength;
                } else {
                    ratio = 0;
                }

                cmc_cal1: for(int i = 0; i < 12; i++){
                    if(0 == i || 5 == i || 10 == i){
                        gain[i] = cmc_reg.m_nGain[i] + (ratio << 6) - ((cmc_reg.m_nGain[i] * ratio) >> 6);
                    }else if(3 == i || 7 == i || 11 == i){
                        gain[i] = cmc_reg.m_nGain[i];
                    }else{
                        gain[i] = cmc_reg.m_nGain[i] - (((cmc_reg.m_nGain[i]) * ratio) >> 6);
                    }
                }

                if(cmc_reg.m_bDiscardH) {
                    temph = 0;
                } else {
                    temph = (h<<2) | 0x3;
                }

                tempblc = (top_reg.blc << 2) | 0x3;
                cmc_cal2: for (int k=0; k<3; k++) {
                    temp1 = red*gain[k*4] + green*gain[k*4+1] + blue*gain[k*4+2] + CMC_HALF_VALUE;
                    temp2 = (temp1 >> CMC_SHIFT_DEEP) + temph + tempblc + gain[k*4+3];
                    #ifdef DEBUG
                    if((y == top_reg.ROW_TEST) && (x == top_reg.COL_TEST)){
                        printf("\t%x\t%x\t\n",temph.to_int(),tempblc.to_int());
                        printf("\t%x\t%x\t%x\n",gain[k*3].to_int(),gain[k*3+1].to_int(),gain[k*3+2].to_int());
                    }
                    #endif
                    dst_w[k] = cmc_clip(temp2,0,CMC_MAX_VALUE);
                }
            } else {
                cmc_cal3: for (int k=0; k<3; k++) {
                    temp_disable = ((src_w[k] + (cmc_reg.m_bDiscardH ? 0 : 0)) << 2) + 3;
                    dst_w[k] = temp_disable;
                }
            }
            #ifdef DEBUG
            if((y == top_reg.ROW_TEST) && (x == top_reg.COL_TEST)){
                printf("\tcmc_in = %x\t%x\t%x\n",red.to_int(),green.to_int(),blue.to_int());
                printf("\tcmc_out = %x\t%x\t%x\n",dst_w[0].to_int(),dst_w[1].to_int(),dst_w[2].to_int());
            }
            #endif
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
