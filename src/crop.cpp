#include"crop.h"

void crop(top_register top_reg, crop_register crop_reg, stream_u10 &y_src, stream_u10 &u_src, stream_u10 &v_src, stream_u10& y_dst, stream_u10& u_dst, stream_u10& v_dst) {
    uint10 y_t;
    uint10 u_t;
    uint10 v_t;

    crop_row: for (uint13 y = 0; y < top_reg.frameHeight; y++) {
        crop_col: for (uint13 x = 0; x < top_reg.frameWidth; x++) {

            //yuv444 pattern
            if(crop_reg.yuvpattern == 0) 
            {
                y_t = y_src.read();
                u_t = u_src.read();
                v_t = v_src.read();

                if(crop_reg.m_nEb == 1)
                {
                    if ((y >= crop_reg.upper_left_y) && (y < crop_reg.lower_right_y) && (x >= crop_reg.upper_left_x) && (x < crop_reg.lower_right_x))
                    {
                        y_dst.write(y_t);
                        u_dst.write(u_t);
                        v_dst.write(v_t);
                    }
                }
                else
                {
                    y_dst.write(y_t);
                    u_dst.write(u_t);
                    v_dst.write(v_t);
                }
            }

            //yuv422 pattern
            else if(crop_reg.yuvpattern == 1)
            {
                if((x & 1) == 0)
                {
                    y_t = y_src.read();
                }
                else
                {
                    y_t = y_src.read();
                    u_t = u_src.read();
                    v_t = v_src.read();
                }

                if(crop_reg.m_nEb == 1)
                {
                    if ((y >= crop_reg.upper_left_y) && (y < crop_reg.lower_right_y) && (x >= crop_reg.upper_left_x) && (x < crop_reg.lower_right_x))
                    {
                        if((x & 1) == 0)
                        {
                            y_dst.write(y_t);
                        }
                        else
                        {
                            y_dst.write(y_t);
                            u_dst.write(u_t);
                            v_dst.write(v_t);
                        }
                    }
                }
                else
                {
                    if((x & 1) == 0)
                    {
                        y_dst.write(y_t);
                    }
                    else
                    {
                        y_dst.write(y_t);
                        u_dst.write(u_t);
                        v_dst.write(v_t);
                    }
                }
            }

            //yuv420 pattern
            else if(crop_reg.yuvpattern == 2)
            {
                if((y & 1) == 0 || (x & 1) == 0)
                {
                    y_t = y_src.read();    
                }
                else
                {
                    y_t = y_src.read();
                    u_t = u_src.read();
                    v_t = v_src.read();
                }

                if(crop_reg.m_nEb == 1)
                {
                    if ((y >= crop_reg.upper_left_y) && (y < crop_reg.lower_right_y) && (x >= crop_reg.upper_left_x) && (x < crop_reg.lower_right_x))
                    {
                        if((y & 1) == 0 || (x & 1) == 0)
                        {
                            y_dst.write(y_t);
                        }
                        else
                        {
                            y_dst.write(y_t);
                            u_dst.write(u_t);
                            v_dst.write(v_t);
                        }
                    }
                }
                else
                {
                    if((y & 1) == 0 || (x & 1) == 0)
                    {
                        y_dst.write(y_t);
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
    }
}
            
