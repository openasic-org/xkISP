#ifndef xkISP_CSC_H_
#define xkISP_CSC_H_

#include "top.h"

typedef struct{
    bool m_nEb;
    int11 coeff[12];
} csc_register;

void csc(top_register top_reg, csc_register csc_reg, stream_u42 &src, stream_u30 &dst);

#endif

