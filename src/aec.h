#ifndef xkISP_AEC_H_
#define xkISP_AEC_H_

#include "top.h"

typedef struct {
    bool m_nEb;
    uint15 mean_y;
    uint8 weights[3*3]; //weights 3x3 
    uint8 weight_sum;   // average of sum of weights
    uint16 block_width; //Grid width
    uint16 block_height;//Grid height
    
}aec_register;

void aec(top_register top_reg, aec_register& aec_reg, stream_u42 &src, stream_u42 &dst);

#endif
