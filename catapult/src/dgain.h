#ifndef xkISP_DGAIN_H_
#define xkISP_DGAIN_H_

#include "top.h"

#define GAIN_BITS 12
#define GAIN_HALF_VALUE (1 << (GAIN_BITS - 1))

typedef struct{
    bool    m_nEb; //1 bit
    uint9   m_nBlcR; //9 bit
    uint9   m_nBlcGr; //9 bit
    uint9   m_nBlcGb; //9 bit
    uint9   m_nBlcB; //9 bit
    uint20  m_nR;  //20 bits -> (8.12)256X gain
    uint20  m_nGr; //20 bits
    uint20  m_nGb; //20 bits
    uint20  m_nB; //20 bits
} dgain_register;

void dgain(top_register top_reg, dgain_register dgain_reg, stream_u12 &src, stream_u12 &dst);

#endif

