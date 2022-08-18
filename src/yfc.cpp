#include"yfc.h"

void yfc(top_register top_reg, yfc_register yfc_reg, stream_u30& src, stream_u10& y_dst, stream_u10& u_dst, stream_u10& v_dst) {
    uint30 src_t;
    uint10 y_t;
    uint10 u_t;
    uint10 v_t;
    uint11 u_tmp_422;
    uint11 v_tmp_422;
    uint12 u_tmp_420;
    uint12 v_tmp_420;
    uint10 u_linebuffer[8192];
    uint10 v_linebuffer[8192];
    
    
    yfc_row: for (uint13 y = 0; y < top_reg.frameHeight; y++) {
        yfc_col: for (uint13 x = 0; x < top_reg.frameWidth; x++) {

            src_t = src.read();
            y_t = src_t >> 20;
            u_t = (src_t >> 10) & 0x3ff;
            v_t = src_t & 0x3ff;

            if(yfc_reg.m_nEb == 1)
            {
                if(yfc_reg.yuvpattern == 0)
                {
                    if ((x & 1) == 0)
                    {
                        u_tmp_422 = u_t;
                        v_tmp_422 = v_t;
                        y_dst.write(y_t);
                    }
                    else
                    {
                        u_tmp_422 = u_tmp_422 + u_t;
                        v_tmp_422 = v_tmp_422 + v_t;
                        u_t = u_tmp_422 >> 1;
                        v_t = v_tmp_422 >> 1;
                        y_dst.write(y_t);
                        u_dst.write(u_t);
                        v_dst.write(v_t);
                    }
                }
                else if(yfc_reg.yuvpattern == 1)
                {
                    if ((y & 1) == 0)
                    {
                        u_linebuffer[x] = u_t;
                        v_linebuffer[x] = v_t;
                        y_dst.write(y_t);
                    }
                    else
                    {
                        if ((x & 1) == 0)
                        {
                            u_tmp_420 = u_t + u_linebuffer[x];
                            v_tmp_420 = v_t + v_linebuffer[x];
                            y_dst.write(y_t);
                        }
                        else
                        {
                            u_tmp_420 = u_tmp_420 + u_t + u_linebuffer[x];
                            v_tmp_420 = v_tmp_420 + v_t + v_linebuffer[x];
                            u_t = u_tmp_420 >> 2;
                            v_t = v_tmp_420 >> 2;
                            y_dst.write(y_t);
                            u_dst.write(u_t);
                            v_dst.write(v_t);
                        }
                    }
                }    
            }
            else
            {
                y_dst.write(y_t);
                u_dst.write(u_t);
                v_dst.write(v_t);
            }
        }
    }
}
