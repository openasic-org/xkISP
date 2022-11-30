#pragma once
#ifndef _ISP_lut_
#define _ISP_lut_

#include "top.h"

typedef struct{
    bool eb;
    uint7 size;
    uint18 lines;
    uint42 lut_000[4913];
    uint42 lut_001[4913];
    uint42 lut_010[4913];
    uint42 lut_011[4913];
    uint42 lut_100[4913];
    uint42 lut_101[4913];
    uint42 lut_110[4913];
    uint42 lut_111[4913];
}lut_register;

typedef struct{
    uint15 r;
    uint15 g;
    uint15 b;
}pixel_uint;

typedef struct{
    int15 r;
    int15 g;
    int15 b;
}pixel_int;

void lut(const top_register top_reg, const lut_register &lut_reg, stream_u42 &src, stream_u42 &dst);

#endif
