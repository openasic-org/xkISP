#ifndef _DPC_HLS_H_
#define _DPC_HLS_H_
#include"top.h"

typedef struct
{
    bool     eb;
    uint11   th_w;
    uint11   th_b;
}dpc_register;

uint12 medianFilter(uint12 arr_ori[8], uint12 arr_sort[8]);
bool defectPixelDetection(uint12 arr_ori[8], uint12 pixel, uint11 th_w, uint11 th_b);
void dpc(top_register top_reg, dpc_register dpc_reg, stream_u12& src, stream_u12& dst);

#endif

