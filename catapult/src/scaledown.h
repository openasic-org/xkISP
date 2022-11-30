#ifndef xkISP_SCALEDOWN_H_
#define xkISP_SCALEDOWN_H_

#include "top.h"

typedef struct {
    bool m_nEb;
    uint2 yuvpattern;//0:yuv444 1:yuv422 2:yuv420
    uint5 times;
} scaledown_register;

void scaledown(top_register top_reg, scaledown_register scaledown_reg, stream_u10 &y_src, stream_u10 &u_src, stream_u10 &v_src, stream_u10& y_dst, stream_u10& u_dst, stream_u10& v_dst);

#endif
