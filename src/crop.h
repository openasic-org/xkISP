#ifndef _ISP_CROP_H_
#define _ISP_CROP_H_

#include "top.h"

typedef struct {
    bool m_nEb;
    uint13 upper_left_x;
    uint13 upper_left_y;
    uint13 lower_right_x;
    uint13 lower_right_y;
    uint2 yuvpattern;//0:yuv444 1:yuv422 2:yuv420
}crop_register;

void crop(top_register top_reg, crop_register crop_reg, stream_u10 &y_src, stream_u10 &u_src, stream_u10 &v_src, stream_u10& y_dst, stream_u10& u_dst, stream_u10& v_dst);

#endif
