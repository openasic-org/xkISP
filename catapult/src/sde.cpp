#include "sde.h"

void sde(top_register top_reg, sde_register sde_reg, stream_u10 &src_y, stream_u10 &src_u, stream_u10 &src_v, stream_u10 &dst_y, stream_u10 &dst_u, stream_u10 &dst_v)
{
    uint10 y_t;
    uint10 u_t;
    uint10 v_t;
    int12 y_dst_t;
    int12 u_dst_t;
    int12 v_dst_t;
    int11   brightness = sde_reg.brightness; 
    int9    contrast   = sde_reg.contrast;
    uint8   saturation = sde_reg.saturation; 
    uint8   coshue     = sde_reg.coshue;
    uint8   sinhue     = sde_reg.sinhue;

    sde_row:for(uint13 row = 0;row < top_reg.frameHeight; row++){
        sde_col:for(uint13 col = 0 ;col < top_reg.frameWidth; col++){
            y_t = src_y.read();
            u_t = src_u.read();
            v_t = src_v.read();
            if (sde_reg.m_nEb)
            {
                // Y plane
                y_dst_t = y_t + brightness;
                if(y_dst_t < 0) y_dst_t = 0;
                y_dst_t = y_dst_t + (((y_dst_t - 511) * contrast) >> 7);
                // UV plane
                u_dst_t = (((u_t - 512) * saturation) >> 7) + 512;
                v_dst_t = (((v_t - 512) * saturation) >> 7) + 512;
                if(u_dst_t < 0) u_dst_t = 0; else if(u_dst_t > 1023) u_dst_t = 1023;
                if(v_dst_t < 0) v_dst_t = 0; else if(v_dst_t > 1023) v_dst_t = 1023;
                int12 u_tmp;
                u_tmp = (((u_dst_t - 512) * coshue + (v_dst_t - 512) * sinhue) >> 8) + 512;
                v_dst_t = (((v_dst_t - 512) * coshue + (u_dst_t - 512) * sinhue) >> 8) + 512;
                u_dst_t = u_tmp;
            }
            else
            {
                y_dst_t = y_t;
                u_dst_t = u_t;
                v_dst_t = v_t;
            }
            // Output
            dst_y.write(y_dst_t);
            dst_u.write(u_dst_t);
            dst_v.write(v_dst_t);
            }
      }
}