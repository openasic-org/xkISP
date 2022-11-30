//Created by Jia Wang 2021/2/20

#ifndef xkISP_DEMOSAIC_H_
#define xkISP_DEMOSAIC_H_

#include "top.h"

typedef struct {
    bool        eb; // 1 bit

} demosaic_register;

typedef uint12 rawData_t;
typedef stream_u12 Stream_t;
typedef stream_u36 Stream_3t;
void demosiac_filter(Stream_t& in,Stream_3t& out);
struct pixel_t
{
    rawData_t r;
    rawData_t g;
    rawData_t b;
};

struct pixelTmp_t
{
    int18 r;
    int18 g;
    int18 b;
};

void demosaic(top_register top_reg, demosaic_register demosaic_reg, Stream_t& src, Stream_3t& dst);

#endif
