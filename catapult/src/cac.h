//#pragma once
#ifndef _ISP_CAC_H_
#define _ISP_CAC_H_
#include "top.h"

typedef uint16 rgbData_t;

typedef struct{
    bool eb;
    int17 t_transient;
    int17 t_edge;
}cac_register;

struct pixel_cac {
    rgbData_t r;
    rgbData_t g;
    rgbData_t b;
};

struct pixel_temp {
    int18 r;
    int18 g;
    int18 b;
};
void cac(top_register top_reg, cac_register cac_reg, stream_u42 &src, stream_u42 &dst);

#endif
