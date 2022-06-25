#ifndef xkISP_CMC_H_
#define xkISP_CMC_H_

#include "top.h"

#define CMC_BITS_DEEP 14
#define CMC_BLC_BITS_DEEP 12
#define CMC_SHIFT_DEEP 10
#define CMC_HALF_VALUE (1 << (CMC_SHIFT_DEEP - 1))
#define CMC_MAX_VALUE  ((1 << CMC_BITS_DEEP) - 1)

typedef struct{
    bool    m_nEb; //1 bit
    int16   m_nGain[12]; //16bits 4096 1X
    bool    m_bCFCEnable; //1 bit
    bool    m_bDiscardH;  //1 bit
    uint9   m_pHueRange[2]; //9ub
    uint3   m_nHueBandShift; //3ub
    uint8   m_nEdgeThre; //8ub
    uint3   m_nEdgeBandShift; //3ub
    uint5   m_nCFCStrength; //5ub
} cmc_register;

void cmc(top_register top_reg, cmc_register cmc_reg, stream_u36 &src, stream_u42 &dst);

#endif

