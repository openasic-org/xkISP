#ifndef xkISP_AWB_H_
#define xkISP_AWB_H_

#include "top.h"

typedef struct {
    bool m_nEb;
    uint15 r_gain;
    uint15 g_gain;
    uint15 b_gain;
    uint5 coeff;
}awb_register;

void awb(top_register top_reg, awb_register& awb_reg, stream_u12 &src, stream_u12 &dst);

#endif
