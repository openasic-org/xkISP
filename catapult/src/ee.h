#ifndef xkISP_EE_H_
#define xkISP_EE_H_


#include "top.h"

typedef struct{
    bool eb;
    uint8 coeff;
}ee_register;

typedef struct{
   uint12 r;
   uint12 g;
   uint12 b;
}ee_pixel_t;

void edgeenhancement(top_register&, ee_register&, stream_u36&, stream_u36&);
uint36 eeprocess(uint36[5][5], ee_register&);

#endif

