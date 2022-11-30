#ifndef _ISP_TPG_H_
#define _ISP_TPG_H_

#include "top.h"

typedef struct{
    bool    m_bTPG_en;
    uint13  m_nWidth;
    uint13  m_nHeight;
    uint2   m_nCFAPattern;
    bool    m_bRollingEnable;
    bool    m_bSensor_timing_en;
    uint12  m_nVBlank_num;
    uint12  m_nHBlank_num;
    uint8   m_valid_blank;
    uint3   m_nID;
} tpg_register;

void tpg(top_register top_reg, tpg_register tpg_reg, stream_u12 &src, stream_u12 &dst);

#endif

