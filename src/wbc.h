#ifndef xkISP_WBC_H_
#define xkISP_WBC_H_

#include "top.h"

typedef struct{
    bool    m_nEb;  
    uint15  m_nR; //15 bits (3.12) 7.93X gain
    uint15  m_nGr; //15 bits (3.12) 7.93X gain
    uint15  m_nGb; //15 bits (3.12) 7.93X gain
    uint15  m_nB; //15 bits (3.12) 7.93X gain
} wbc_register;

void wbc(top_register top_reg, wbc_register wbc_reg, stream_u12 &src, stream_u12 &dst);

#endif

