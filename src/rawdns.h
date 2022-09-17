#ifndef _ISP_RAWDNS_HLS_
#define  _ISP_RAWDNS_HLS_

#include "top.h"

typedef struct{
    uint6   sigma;    //range[0-63]
    uint1   eb;       //{0,1}
    uint7   Filterpara; //range[0-127]
    uint12  invksigma2; //1/ksigma2 <<12
}rawdns_register;


inline uint12 rawdns_abs(uint12 rawData_1 , uint12 rawData_2)
{
    if(rawData_1 >= rawData_2)
        return rawData_1 - rawData_2;
    else
        return rawData_2 - rawData_1;
}
inline uint30 rawdns_max(uint30 diff, uint14 sigma2)
{
    if(diff <= sigma2)
        return 0;
    else
        return diff - sigma2;
}
inline uint12 rawdns_clip(uint25 result)
{
    if(result>4095)
        return 4095;
    else
        return (uint12)result;
}

uint8 Cal_weight(uint30 diff,rawdns_register& rawdns_reg,uint26 ksigma2);
uint30 Cal_Eur_Distance(uint12 rawdns_block[11][11], uint4 cur_y, uint4 cur_x);
uint12 rawdns_process(uint12 rawdns_block[11][11],rawdns_register& rawdns_reg,uint26 ksigma2,uint13 row, uint13 col, bool nlm_en);
void isp_rawdns(top_register& top_reg, rawdns_register& rawdns_reg, stream_u12& src, stream_u12& dst);
#endif
