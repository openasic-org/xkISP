#ifndef xkISP_SDE_H_
#define xkISP_SDE_H_

#include "top.h"


typedef struct{
    uint1   m_nEb;
    int11   brightness; 
    int9    contrast; 
    uint8   saturation; 
    uint8   coshue;
    uint8   sinhue; 
} sde_register;

void sde(top_register top_reg, sde_register sde_reg, stream_u10 &src_y, stream_u10 &src_u, stream_u10 &src_v, stream_u10 &dst_y, stream_u10 &dst_u, stream_u10 &dst_v);

#endif