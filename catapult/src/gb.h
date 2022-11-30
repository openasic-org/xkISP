#include "top.h"

#ifndef _ISP_GREENBALANCE_H
#define _ISP_GREENBALANCE_H

//#define _DEBUG_
//#define ROW_TEST 7
//#define COL_TEST 6

typedef struct
{
    bool eb;
    uint4 win_size;
    uint4 Lbound;
    uint6 Hbound;
    uint10 threhold;
} gb_register;


inline uint12 gb_abs(uint12 A , uint12 B)
{
    if(A >= B)
        return A - B;
    else
        return B - A;
}

inline uint12 gb_clip(int31 A)
{
    if(A < 0)
        return 0;
    else if(A > 4095)
        return 4095;
    else
        return (uint12)A;
}


void greenbalance2(top_register top_reg, gb_register gb_reg, stream_u12& src, stream_u12& dst);
uint12 ColumnStatistic(uint12 gb_block[7][7], bool IfRBpixel,uint13 row, uint13 col, gb_register& gb_reg, int16 Gfifo[6], uint3 countfifo[6]);

#endif
