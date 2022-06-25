#include"awb.h"

void awb(top_register top_reg, awb_register& awb_reg, stream_u12 &src, stream_u12 &dst) {
    uint12 src_t;
    uint12 dst_t;
    uint33 r_total = 0;
    uint33 g_total = 0;
    uint33 b_total = 0;
    uint12 r_avg = 0;
    uint12 g_avg = 0;
    uint12 b_avg = 0;
    uint26 gray = 0;

    awb_row: for (uint13 y = 0; y < top_reg.frameHeight; y++) {
        awb_col: for (uint13 x = 0; x < top_reg.frameWidth; x++) {
            src_t = src.read();
            if(awb_reg.m_nEb == 1)
            {
                uint2  bayerPattern = (((y & 1) << 1) + (x & 1))^top_reg.imgPattern;

                if (bayerPattern == 0)
                {
                    r_total = r_total + src_t;
                }
                else if (bayerPattern == 1)
                {
                    g_total = g_total + src_t;
                }
                else if (bayerPattern == 2)
                {
                    g_total = g_total + src_t;
                }
                else
                {
                    b_total = b_total + src_t;
                }
            }
            dst_t = src_t;
            dst.write(dst_t);
        }
    }

    r_avg = (r_total * awb_reg.coeff) >> 19;
    g_avg = (g_total * awb_reg.coeff) >> 20;
    b_avg = (b_total * awb_reg.coeff) >> 19;

    awb_reg.r_gain = 16384 * g_avg / r_avg;
    awb_reg.g_gain = 16384;
    awb_reg.b_gain = 16384 * g_avg / b_avg;
}
