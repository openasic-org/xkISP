#ifndef xkISP_GTM_H_
#define xkISP_GTM_H_

#include "top.h"

typedef struct{
    bool    eb;
    bool    m_bDitheringEnable;
    uint10  gtmTab[129];
} gtm_register;

void gtm(top_register top_reg, gtm_register gtm_reg, stream_u42 &src, stream_u42 &dst);

#endif

