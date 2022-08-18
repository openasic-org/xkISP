#include"scaledown.h"

void scaledown(top_register top_reg, scaledown_register scaledown_reg, stream_u10 &y_src, stream_u10 &u_src, stream_u10 &v_src, stream_u10& y_dst, stream_u10& u_dst, stream_u10& v_dst) {
    uint10 y_t;
    uint10 u_t;
    uint10 v_t;
    uint15 y_tmp;
    uint15 u_tmp;
    uint15 v_tmp;
    uint10 y_linebuffer[3][8192];
    uint10 u_linebuffer[3][8192];
    uint10 v_linebuffer[3][8192];

    scaledown_row: for (uint13 y = 0; y < top_reg.frameHeight; y++) {
        scaledown_col: for (uint13 x = 0; x < top_reg.frameWidth; x++) {

            y_t = y_src.read();
            u_t = u_src.read();
            v_t = v_src.read();

            if(scaledown_reg.m_nEb == 1)
            {
                if(scaledown_reg.yuvpattern == 0)
                {
                    if(scaledown_reg.times == 2)
                    {
                        if ((y & 1) == 0)
                        {
                            y_linebuffer[0][x] = y_t;
                            u_linebuffer[0][x] = u_t;
                            v_linebuffer[0][x] = v_t;
                        }
                        else if ((x & 1) == 0)
                        {
                            y_tmp = y_t + y_linebuffer[0][x];
                            u_tmp = u_t + u_linebuffer[0][x];
                            v_tmp = v_t + v_linebuffer[0][x];
                        }
                        else
                        {
                            y_tmp = y_tmp + y_t + y_linebuffer[0][x];
                            u_tmp = u_tmp + u_t + u_linebuffer[0][x];
                            v_tmp = v_tmp + v_t + v_linebuffer[0][x];
                            y_t = y_tmp >> 2;
                            u_t = u_tmp >> 2;
                            v_t = v_tmp >> 2;
                            y_dst.write(y_t);
                            u_dst.write(u_t);
                            v_dst.write(v_t);
                        }
                    }
                    else if(scaledown_reg.times == 4)
                    {
                        if ((y % 4) == 0)
                        {
                            y_linebuffer[0][x] = y_t;
                            u_linebuffer[0][x] = u_t;
                            v_linebuffer[0][x] = v_t;
                        }
                        else if((y % 4) == 1)
                        {
                            y_linebuffer[1][x] = y_t;
                            u_linebuffer[1][x] = u_t;
                            v_linebuffer[1][x] = v_t;
                        }
                        else if((y % 4) == 2)
                        {
                            y_linebuffer[2][x] = y_t;
                            u_linebuffer[2][x] = u_t;
                            v_linebuffer[2][x] = v_t;
                        }
                        else if((x % 4) == 0)
                        {
                            y_tmp = y_t + y_linebuffer[0][x] + y_linebuffer[1][x] + y_linebuffer[2][x];
                            u_tmp = u_t + u_linebuffer[0][x] + u_linebuffer[1][x] + u_linebuffer[2][x];
                            v_tmp = v_t + v_linebuffer[0][x] + v_linebuffer[1][x] + v_linebuffer[2][x];
                        }
                        else if((x % 4) == 1)
                        {
                            y_tmp = y_tmp + y_t + y_linebuffer[0][x] + y_linebuffer[1][x] + y_linebuffer[2][x];
                            u_tmp = u_tmp + u_t + u_linebuffer[0][x] + u_linebuffer[1][x] + u_linebuffer[2][x];
                            v_tmp = v_tmp + v_t + v_linebuffer[0][x] + v_linebuffer[1][x] + v_linebuffer[2][x];
                        }
                        else if((x % 4) == 2)
                        {
                            y_tmp = y_tmp + y_t + y_linebuffer[0][x] + y_linebuffer[1][x] + y_linebuffer[2][x];
                            u_tmp = u_tmp + u_t + u_linebuffer[0][x] + u_linebuffer[1][x] + u_linebuffer[2][x];
                            v_tmp = v_tmp + v_t + v_linebuffer[0][x] + v_linebuffer[1][x] + v_linebuffer[2][x];
                        }
                        else
                        {
                            y_tmp = y_tmp + y_t + y_linebuffer[0][x] + y_linebuffer[1][x] + y_linebuffer[2][x];
                            u_tmp = u_tmp + u_t + u_linebuffer[0][x] + u_linebuffer[1][x] + u_linebuffer[2][x];
                            v_tmp = v_tmp + v_t + v_linebuffer[0][x] + v_linebuffer[1][x] + v_linebuffer[2][x];
                            y_t = y_tmp >> 4;
                            u_t = u_tmp >> 4;
                            v_t = v_tmp >> 4;
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
