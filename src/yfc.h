#ifndef xkISP_YFC_H_
#define xkISP_YFC_H_

#include "top.h"

typedef struct {
    bool m_nEb;
    bool yuvpattern;//0:yuv422 1:yuv420
} yfc_register;

void yfc(top_register top_reg, yfc_register yfc_reg, stream_u30& src, stream_u10& y_dst, stream_u10& u_dst, stream_u10& v_dst);

#endif
