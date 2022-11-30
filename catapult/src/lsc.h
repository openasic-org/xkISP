#ifndef _ISP_LSC_H_
#define _ISP_LSC_H_

#include "top.h"

typedef struct{
    bool eb;
    uint13 rGain[13*17];
    uint13 GrGain[13*17];
    uint13 GbGain[13*17];
    uint13 bGain[13*17];
    uint9 blockHeight;
    uint9 blockWidth;
    uint14 blockWidth_1;
    uint10 blockHeight_1;
} lsc_register;

uint13 BilinearInterpolation(uint13* LeftTopGain, uint13* LeftDownGain,uint13* RightTopGain, uint13* RightDownGain,
                             uint9 BlockWidthCount, uint9 BlockHeightCount, uint14 blockWidth_1, uint10 blockHeight_1);

void lsc(top_register topRegister, lsc_register &lscRegister, stream_u12 &src, stream_u12 &dst);

#endif
