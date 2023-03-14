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
    uint12 r_q;
    uint12 b_q;
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
            #ifdef DEBUG
            if ((x == top_reg.ROW_TEST)&&(y == top_reg.COL_TEST)) {
                 printf("\t%d\n",src_t.to_int());
            }
            #endif
        }
    }

    r_avg = (r_total * awb_reg.coeff) >> 19;
    g_avg = (g_total * awb_reg.coeff) >> 20;
    b_avg = (b_total * awb_reg.coeff) >> 19;
#ifdef AWB_DIV
    #ifdef catapult
    ac_math::ac_div(g_avg,r_avg,r_q);
    ac_math::ac_div(g_avg,b_avg,b_q);
    #endif
    #ifdef vivado
    r_q = g_avg / r_avg;
    b_q = g_avg / b_avg;
    #endif
    awb_reg.r_gain = 4096 * r_q >> 1;
    awb_reg.g_gain = 4096;
    awb_reg.b_gain = 4096 * b_q >> 1;

    printf ("r_gain_1 = %d\n" ,r_avg.to_int() );
    printf ("g_gain_1 = %d\n" ,g_avg.to_int() );
    printf ("b_gain_1 = %d\n" ,b_avg.to_int() );
#else
    awb_reg.r_gain = r_avg;
    awb_reg.g_gain = g_avg;
    awb_reg.b_gain = b_avg;
#endif
}
