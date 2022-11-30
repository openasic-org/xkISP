#ifndef _ISP_YUVDNS_H_
#define _ISP_YUVDNS_H_

#include "top.h"

typedef struct{
    uint1 eb;//1 bit
    uint14 ysigma2;// sigma = [5,127]
    uint10 yinvsigma2;// invsigma = (1 / sigma) << 7
    uint14 uvsigma2;//[5,127]
    uint10 uvinvsigma2;//(1 / sigma) << 7
    uint4 yfilt;//[0.1~0.8] << 4
    uint4 uvfilt;//[0.1~0.8] << 4
    uint5 yinvfilt;//(1 / filt) << 1
    uint5 uvinvfilt;//(1 / filt) << 1
    uint14 yH2;
    uint18 yinvH2;
    uint14 uvH2;
    uint18 uvinvH2;
}yuvdns_register;

void yuv444dns(top_register top_reg, yuvdns_register yuvdns_reg, stream_u10 &src_y, stream_u10 &src_u, stream_u10 &src_v, stream_u10 &dst_y, stream_u10 &dst_u, stream_u10 &dst_v);

#endif
