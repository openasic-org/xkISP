#ifndef _ISP_DEHAZE_H_
#define _ISP_DEHAZE_H_
#include "top.h"

#define MIN_SIZE             3
#define GF_SIZE              9
typedef struct{
    uint1 m_nEb;
    uint16 atm_r;
    uint16 atm_g;
    uint16 atm_b;
    uint16 strength;  //255==>>remove all ,0==>> preserve all
}dehaze_register;




void minfilter(top_register top_reg,dehaze_register dehaze_reg,stream_u42 &srcRGB,stream_u56  &dstRGBDC);
void tRefine_rgbRec(top_register top_reg, dehaze_register dehaze_reg,uint16 atm[3],stream_u56 &srcRGBDC,stream_u42 &dstRGB );
void dehaze(top_register top_reg, dehaze_register dehaze_reg, stream_u42 &srcData, stream_u42 &dstData);





#endif // _ISP_DEHAZE_H_
