#ifndef xkISP_AFC_H_
#define xkISP_AFC_H_

#include "top.h"

typedef struct {
    bool eb;
    uint13 location_row;
    uint13 location_col;
    bool m_bIfHardThreshold;
    int13 ThrList[8];
    int14 T;
    uint30 SumHF;
    uint17 CountHF;
    uint32 SumMF;
    uint17 CountMF;
}afc_register;

void afc(top_register top_reg, afc_register& afc_reg, stream_u12 &src, stream_u12 &dst);

#endif
