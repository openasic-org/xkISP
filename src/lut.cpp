#include "lut.h"

#define lut_BITS_DEEP 14
#define lut_HALF_VALUE (1 << (lut_BITS_DEEP - 1))
#define lut_MAX_VALUE  ((1 << lut_BITS_DEEP) - 1)

uint14 lut_clip(int21 a, int lower, int upper){
    uint14 result;
    if(a < lower)
        result = lower;
    else if (a > upper)
        result = upper;
    else
        result = a;
    return result;
}

int18 lut_max(int a, int b) {
    int18 result;
    if(a > b)
        result = a;
    else
        result = b;
    return result;
}

int18 lut_min(int a, int b) {
    int18 result;
    if(a < b)
        result = a;
    else
        result = b;
    return result;
}

uint1 lut_mux_r(bool a) {
    uint1 b;
    if(a == 0)
        b = 0;
    else
        b = 1;
    return b;
}

uint5 lut_mux_g(bool a) {
    uint5 b;
    if(a == 0)
        b = 0;
    else
        b = 1;
    return b;
}

uint9 lut_mux_b(bool a) {
    uint9 b;
    if(a == 0)
        b = 0;
    else
        b = 1;
    return b;
}

void lut(const top_register top_reg, const lut_register &lut_reg, stream_u42 &src, stream_u42 &dst){
    uint42 src_t;
    uint42 dst_t;
    uint19 r, g, b;
    uint5 delta_r, delta_g, delta_b;
    uint10 r_temp, g_temp, b_temp;
    uint15 r_h, g_h, b_h;
    uint15 r_l, g_l, b_l;
    uint17 index;
    uint17 index_temp[8];
    uint3 index_ram, index_ram_temp[8];
    pixel_int P[8];
    pixel_int c1, c2, c3;
    uint42 value[8];
    uint9 decoder_b;
    uint5 decoder_g;

    lut_row: for(uint13 row = 0; row < top_reg.frameHeight; row++) {
        lut_col: for(uint13 col = 0; col < top_reg.frameWidth; col++) {
            src_t = src.read();
            if(lut_reg.eb == 1) {
                r = src_t >> 28;
                g = (src_t >> 14) & 0x3fff;
                b = src_t & 0x3fff;

                r_temp = r * (lut_reg.size - 1) << 5 >> 14;
                g_temp = g * (lut_reg.size - 1) << 5 >> 14;
                b_temp = b * (lut_reg.size - 1) << 5 >> 14;

                r_h = (r_temp >> 5) + 1;
                g_h = (g_temp >> 5) + 1;
                b_h = (b_temp >> 5) + 1;

                r_l = r_temp >> 5;
                g_l = g_temp >> 5;
                b_l = b_temp >> 5;

                delta_r = r_temp - (r_l << 5);
                delta_g = g_temp - (g_l << 5);
                delta_b = b_temp - (b_l << 5);

                #ifdef vivado
                index_ram = (r_l(0, 0) << 2) + (g_l(0, 0) << 1) + b_l(0,0);

                index = (r_l >> 1) + ((g_l >> 1) * ((lut_reg.size + 1) >> 1)) + ((b_l >> 1) * ((lut_reg.size + 1) >> 1) * ((lut_reg.size + 1) >> 1));

                decoder_g = ((lut_reg.size + 1) >> 1);
                decoder_b = ((lut_reg.size + 1) >> 1) * ((lut_reg.size + 1) >> 1);

                value[0] = lut_reg.lut_000[index + lut_mux_r(index_ram(2, 2)) + lut_mux_g(index_ram(1, 1)) * decoder_g + lut_mux_b(index_ram(0, 0)) * decoder_b];
                value[1] = lut_reg.lut_001[index + lut_mux_r(index_ram(2, 2)) + lut_mux_g(index_ram(1, 1)) * decoder_g];
                value[2] = lut_reg.lut_010[index + lut_mux_r(index_ram(2, 2)) + lut_mux_b(index_ram(0, 0)) * decoder_b];
                value[3] = lut_reg.lut_011[index + lut_mux_r(index_ram(2, 2))];
                value[4] = lut_reg.lut_100[index + lut_mux_g(index_ram(1, 1)) * decoder_g + lut_mux_b(index_ram(0, 0)) * decoder_b];
                value[5] = lut_reg.lut_101[index + lut_mux_g(index_ram(1, 1)) * decoder_g];
                value[6] = lut_reg.lut_110[index + lut_mux_b(index_ram(0, 0)) * decoder_b];
                value[7] = lut_reg.lut_111[index];

                index_ram_temp[0] = 0 ^ index_ram;

                index_ram_temp[1] = 1 ^ index_ram;

                index_ram_temp[2] = 2 ^ index_ram;

                index_ram_temp[3] = 3 ^ index_ram;

                index_ram_temp[4] = 4 ^ index_ram;

                index_ram_temp[5] = 5 ^ index_ram;

                index_ram_temp[6] = 6 ^ index_ram;

                index_ram_temp[7] = 7 ^ index_ram;

                P[0].r = value[index_ram_temp[0]](41, 28);
                P[0].g = value[index_ram_temp[0]](27, 14);
                P[0].b = value[index_ram_temp[0]](13, 0);

                P[1].r = value[index_ram_temp[1]](41, 28);
                P[1].g = value[index_ram_temp[1]](27, 14);
                P[1].b = value[index_ram_temp[1]](13, 0);

                P[2].r = value[index_ram_temp[2]](41, 28);
                P[2].g = value[index_ram_temp[2]](27, 14);
                P[2].b = value[index_ram_temp[2]](13, 0);

                P[3].r = value[index_ram_temp[3]](41, 28);
                P[3].g = value[index_ram_temp[3]](27, 14);
                P[3].b = value[index_ram_temp[3]](13, 0);

                P[4].r = value[index_ram_temp[4]](41, 28);
                P[4].g = value[index_ram_temp[4]](27, 14);
                P[4].b = value[index_ram_temp[4]](13, 0);

                P[5].r = value[index_ram_temp[5]](41, 28);
                P[5].g = value[index_ram_temp[5]](27, 14);
                P[5].b = value[index_ram_temp[5]](13, 0);

                P[6].r = value[index_ram_temp[6]](41, 28);
                P[6].g = value[index_ram_temp[6]](27, 14);
                P[6].b = value[index_ram_temp[6]](13, 0);

                P[7].r = value[index_ram_temp[7]](41, 28);
                P[7].g = value[index_ram_temp[7]](27, 14);
                P[7].b = value[index_ram_temp[7]](13, 0);

                if(delta_r >= delta_g >= delta_b){
                    c1.r = P[4].r - P[0].r;
                    c1.g = P[4].g - P[0].g;
                    c1.b = P[4].b - P[0].b;

                    c2.r = P[6].r - P[4].r;
                    c2.g = P[6].g - P[4].g;
                    c2.b = P[6].b - P[4].b;

                    c3.r = P[7].r - P[6].r;
                    c3.g = P[7].g - P[6].g;
                    c3.b = P[7].b - P[6].b;
                }
                else if(delta_r >= delta_b >= delta_g){
                    c1.r = P[4].r - P[0].r;
                    c1.g = P[4].g - P[0].g;
                    c1.b = P[4].b - P[0].b;

                    c2.r = P[7].r - P[5].r;
                    c2.g = P[7].g - P[5].g;
                    c2.b = P[7].b - P[5].b;

                    c3.r = P[5].r - P[4].r;
                    c3.g = P[5].g - P[4].g;
                    c3.b = P[5].b - P[4].b;
                }
                else if(delta_b >= delta_r >= delta_g){
                    c1.r = P[5].r - P[1].r;
                    c1.g = P[5].g - P[1].g;
                    c1.b = P[5].b - P[1].b;

                    c2.r = P[7].r - P[5].r;
                    c2.g = P[7].g - P[5].g;
                    c2.b = P[7].b - P[5].b;

                    c3.r = P[1].r - P[0].r;
                    c3.g = P[1].g - P[0].g;
                    c3.b = P[1].b - P[0].b;
                }
                else if(delta_g >= delta_r >= delta_b){
                    c1.r = P[6].r - P[2].r;
                    c1.g = P[6].g - P[2].g;
                    c1.b = P[6].b - P[2].b;

                    c2.r = P[2].r - P[0].r;
                    c2.g = P[2].g - P[0].g;
                    c2.b = P[2].b - P[0].b;

                    c3.r = P[7].r - P[6].r;
                    c3.g = P[7].g - P[6].g;
                    c3.b = P[7].b - P[6].b;
                }
                else if(delta_g >= delta_b >= delta_r){
                    c1.r = P[7].r - P[3].r;
                    c1.g = P[7].g - P[3].g;
                    c1.b = P[7].b - P[3].b;

                    c2.r = P[2].r - P[0].r;
                    c2.g = P[2].g - P[0].g;
                    c2.b = P[2].b - P[0].b;

                    c3.r = P[3].r - P[2].r;
                    c3.g = P[3].g - P[2].g;
                    c3.b = P[3].b - P[2].b;
                }
                else if(delta_b >= delta_g >= delta_r){
                    c1.r = P[7].r - P[3].r;
                    c1.g = P[7].g - P[3].g;
                    c1.b = P[7].b - P[3].b;

                    c2.r = P[3].r - P[1].r;
                    c2.g = P[3].g - P[1].g;
                    c2.b = P[3].b - P[1].b;

                    c3.r = P[1].r - P[0].r;
                    c3.g = P[1].g - P[0].g;
                    c3.b = P[1].b - P[0].b;
                }
                else {
                    c1.r = P[4].r - P[0].r;
                    c1.g = P[4].g - P[0].g;
                    c1.b = P[4].b - P[0].b;

                    c2.r = P[6].r - P[4].r;
                    c2.g = P[6].g - P[4].g;
                    c2.b = P[6].b - P[4].b;

                    c3.r = P[7].r - P[6].r;
                    c3.g = P[7].g - P[6].g;
                    c3.b = P[7].b - P[6].b;
                }

                dst_t(41, 28) = lut_clip(P[0].r + (c1.r * delta_r >> 5) + (c2.r * delta_g >> 5) + (c3.r * delta_b >> 5), 0, 16383);
                dst_t(27, 14) = lut_clip(P[0].g + (c1.g * delta_r >> 5) + (c2.g * delta_g >> 5) + (c3.g * delta_b >> 5), 0, 16383);
                dst_t(13, 0) = lut_clip(P[0].b + (c1.b * delta_r >> 5) + (c2.b * delta_g >> 5) + (c3.b * delta_b >> 5), 0, 16383);

                #ifdef DEBUG
                if(row == ROW_TEST && col == COL_TEST) {
                    printf("test = %d\n", value[1](27,14).to_uint());
                    printf("odd_r = %d, odd_g = %d, odd_b = %d\n", lut_mux_r(index_ram(2, 2)).to_uint(), lut_mux_g(index_ram(1, 1)).to_uint(), lut_mux_b(index_ram(0, 0)).to_uint());
                    printf("index_ram = %d, index = %d, delta_r = %d, delta_g = %d, delta_b = %d\n", index_ram.to_uint(), index.to_uint(), delta_r.to_uint(), delta_g.to_uint(), delta_b.to_uint());
                    printf("P000.r = %d, P000.g = %d, P000.b = %d\n", P[0].r.to_uint(), P[0].g.to_uint(), P[0].b.to_uint());
                    printf("P001.r = %d, P001.g = %d, P001.b = %d\n", P[1].r.to_uint(), P[1].g.to_uint(), P[1].b.to_uint());
                    printf("P010.r = %d, P010.g = %d, P010.b = %d\n", P[2].r.to_uint(), P[2].g.to_uint(), P[2].b.to_uint());
                    printf("P011.r = %d, P011.g = %d, P011.b = %d\n", P[3].r.to_uint(), P[3].g.to_uint(), P[3].b.to_uint());
                    printf("P100.r = %d, P100.g = %d, P100.b = %d\n", P[4].r.to_uint(), P[4].g.to_uint(), P[4].b.to_uint());
                    printf("P101.r = %d, P101.g = %d, P101.b = %d\n", P[5].r.to_uint(), P[5].g.to_uint(), P[5].b.to_uint());
                    printf("P110.r = %d, P110.g = %d, P110.b = %d\n", P[6].r.to_uint(), P[6].g.to_uint(), P[6].b.to_uint());
                    printf("P111.r = %d, P111.g = %d, P111.b = %d\n", P[7].r.to_uint(), P[7].g.to_uint(), P[7].b.to_uint());
                    printf("c1.r = %d, c1.g = %d, c1.b = %d\n", c1.r.to_int(), c1.g.to_int(), c1.b.to_int());
                    printf("c2.r = %d, c2.g = %d, c2.b = %d\n", c2.r.to_int(), c2.g.to_int(), c2.b.to_int());
                    printf("c3.r = %d, c3.g = %d, c3.b = %d\n", c3.r.to_int(), c3.g.to_int(), c3.b.to_int());
                    //printf("color.r = %d, color.g = %d, color.b = %d\n", color.r, color.g, color.b);
                }
                #endif
                #endif

                #ifdef catapult
                index_ram = (uint3(uint1(r_l)) << 2) + (uint2(uint1(g_l)) << 1) + uint1(b_l);

                index = (r_l >> 1) + ((g_l >> 1) << ((lut_reg.size + 1) >> 1)) + ((b_l >> 1) * ((lut_reg.size + 1) >> 1) * ((lut_reg.size + 1) >> 1));

                value[0] = lut_reg.lut_000[index + lut_mux_r(uint1(r_l)) + lut_mux_g(uint1(g_l)) * decoder_g + lut_mux_b(uint1(b_l)) * decoder_b];
                value[1] = lut_reg.lut_001[index + lut_mux_r(uint1(r_l)) + lut_mux_g(uint1(g_l)) * decoder_g];
                value[2] = lut_reg.lut_010[index + lut_mux_r(uint1(r_l)) + lut_mux_b(uint1(b_l)) * decoder_b];
                value[3] = lut_reg.lut_011[index + lut_mux_r(uint1(r_l))];
                value[4] = lut_reg.lut_100[index + lut_mux_g(uint1(g_l)) * decoder_g + lut_mux_b(uint1(b_l)) * decoder_b];
                value[5] = lut_reg.lut_101[index + lut_mux_g(uint1(g_l)) * decoder_g];
                value[6] = lut_reg.lut_110[index + lut_mux_b(uint1(b_l)) * decoder_b];
                value[7] = lut_reg.lut_111[index];

                index_ram_temp[0] = 0 ^ index_ram;

                index_ram_temp[1] = 1 ^ index_ram;

                index_ram_temp[2] = 2 ^ index_ram;

                index_ram_temp[3] = 3 ^ index_ram;

                index_ram_temp[4] = 4 ^ index_ram;

                index_ram_temp[5] = 5 ^ index_ram;

                index_ram_temp[6] = 6 ^ index_ram;

                index_ram_temp[7] = 7 ^ index_ram;

                P[0].r = value[index_ram_temp[0]]>>28;
                P[0].g = uint14(value[index_ram_temp[0]]>>14);
                P[0].b = uint14(value[index_ram_temp[0]]);

                P[1].r = value[index_ram_temp[1]]>>28;
                P[1].g = uint14(value[index_ram_temp[1]]>>14);
                P[1].b = uint14(value[index_ram_temp[1]]);

                P[2].r = value[index_ram_temp[2]]>>28;
                P[2].g = uint14(value[index_ram_temp[2]]>>14);
                P[2].b = uint14(value[index_ram_temp[2]]);

                P[3].r = value[index_ram_temp[3]]>>28;
                P[3].g = uint14(value[index_ram_temp[3]]>>14);
                P[3].b = uint14(value[index_ram_temp[3]]);

                P[4].r = value[index_ram_temp[4]]>>28;
                P[4].g = uint14(value[index_ram_temp[4]]>>14);
                P[4].b = uint14(value[index_ram_temp[4]]);

                P[5].r = value[index_ram_temp[5]]>>28;
                P[5].g = uint14(value[index_ram_temp[5]]>>14);
                P[5].b = uint14(value[index_ram_temp[5]]);

                P[6].r = value[index_ram_temp[6]]>>28;
                P[6].g = uint14(value[index_ram_temp[6]]>>14);
                P[6].b = uint14(value[index_ram_temp[6]]);

                P[7].r = value[index_ram_temp[7]]>>28;
                P[7].g = uint14(value[index_ram_temp[7]]>>14);
                P[7].b = uint14(value[index_ram_temp[7]]);

                if(delta_r >= delta_g >= delta_b){
                    c1.r = P[4].r - P[0].r;
                    c1.g = P[4].g - P[0].g;
                    c1.b = P[4].b - P[0].b;

                    c2.r = P[6].r - P[4].r;
                    c2.g = P[6].g - P[4].g;
                    c2.b = P[6].b - P[4].b;

                    c3.r = P[7].r - P[6].r;
                    c3.g = P[7].g - P[6].g;
                    c3.b = P[7].b - P[6].b;
                }
                else if(delta_r >= delta_b >= delta_g){
                    c1.r = P[4].r - P[0].r;
                    c1.g = P[4].g - P[0].g;
                    c1.b = P[4].b - P[0].b;

                    c2.r = P[7].r - P[5].r;
                    c2.g = P[7].g - P[5].g;
                    c2.b = P[7].b - P[5].b;

                    c3.r = P[5].r - P[4].r;
                    c3.g = P[5].g - P[4].g;
                    c3.b = P[5].b - P[4].b;
                }
                else if(delta_b >= delta_r >= delta_g){
                    c1.r = P[5].r - P[1].r;
                    c1.g = P[5].g - P[1].g;
                    c1.b = P[5].b - P[1].b;

                    c2.r = P[7].r - P[5].r;
                    c2.g = P[7].g - P[5].g;
                    c2.b = P[7].b - P[5].b;

                    c3.r = P[1].r - P[0].r;
                    c3.g = P[1].g - P[0].g;
                    c3.b = P[1].b - P[0].b;
                }
                else if(delta_g >= delta_r >= delta_b){
                    c1.r = P[6].r - P[2].r;
                    c1.g = P[6].g - P[2].g;
                    c1.b = P[6].b - P[2].b;

                    c2.r = P[2].r - P[0].r;
                    c2.g = P[2].g - P[0].g;
                    c2.b = P[2].b - P[0].b;

                    c3.r = P[7].r - P[6].r;
                    c3.g = P[7].g - P[6].g;
                    c3.b = P[7].b - P[6].b;
                }
                else if(delta_g >= delta_b >= delta_r){
                    c1.r = P[7].r - P[3].r;
                    c1.g = P[7].g - P[3].g;
                    c1.b = P[7].b - P[3].b;

                    c2.r = P[2].r - P[0].r;
                    c2.g = P[2].g - P[0].g;
                    c2.b = P[2].b - P[0].b;

                    c3.r = P[3].r - P[2].r;
                    c3.g = P[3].g - P[2].g;
                    c3.b = P[3].b - P[2].b;
                }
                else if(delta_b >= delta_g >= delta_r){
                    c1.r = P[7].r - P[3].r;
                    c1.g = P[7].g - P[3].g;
                    c1.b = P[7].b - P[3].b;

                    c2.r = P[3].r - P[1].r;
                    c2.g = P[3].g - P[1].g;
                    c2.b = P[3].b - P[1].b;

                    c3.r = P[1].r - P[0].r;
                    c3.g = P[1].g - P[0].g;
                    c3.b = P[1].b - P[0].b;
                }

                #ifdef DEBUG
                if(row == top_reg.ROW_TEST && col == top_reg.COL_TEST) {
                    printf("index_ram = %d, index = %d, delta_r = %d, delta_g = %d, delta_b = %d\n", index_ram.to_uint(), index.to_uint(), delta_r.to_uint(), delta_g.to_uint(), delta_b.to_uint());
                    printf("P000.r = %d, P000.g = %d, P000.b = %d\n", P[0].r.to_uint(), P[0].g.to_uint(), P[0].b.to_uint());
                    printf("P001.r = %d, P001.g = %d, P001.b = %d\n", P[1].r.to_uint(), P[1].g.to_uint(), P[1].b.to_uint());
                    printf("P010.r = %d, P010.g = %d, P010.b = %d\n", P[2].r.to_uint(), P[2].g.to_uint(), P[2].b.to_uint());
                    printf("P011.r = %d, P011.g = %d, P011.b = %d\n", P[3].r.to_uint(), P[3].g.to_uint(), P[3].b.to_uint());
                    printf("P100.r = %d, P100.g = %d, P100.b = %d\n", P[4].r.to_uint(), P[4].g.to_uint(), P[4].b.to_uint());
                    printf("P101.r = %d, P101.g = %d, P101.b = %d\n", P[5].r.to_uint(), P[5].g.to_uint(), P[5].b.to_uint());
                    printf("P110.r = %d, P110.g = %d, P110.b = %d\n", P[6].r.to_uint(), P[6].g.to_uint(), P[6].b.to_uint());
                    printf("P111.r = %d, P111.g = %d, P111.b = %d\n", P[7].r.to_uint(), P[7].g.to_uint(), P[7].b.to_uint());
                    printf("c1.r = %d, c1.g = %d, c1.b = %d\n", c1.r.to_int(), c1.g.to_int(), c1.b.to_int());
                    printf("c2.r = %d, c2.g = %d, c2.b = %d\n", c2.r.to_int(), c2.g.to_int(), c2.b.to_int());
                    printf("c3.r = %d, c3.g = %d, c3.b = %d\n", c3.r.to_int(), c3.g.to_int(), c3.b.to_int());
                    //printf("color.r = %d, color.g = %d, color.b = %d\n", color.r, color.g, color.b);
                }
                #endif

                dst_t.set_slc(28, lut_clip(P[0].r + (c1.r * delta_r >> 5) + (c2.r * delta_g >> 5) + (c3.r * delta_b >> 5), 0, 16383));
                dst_t.set_slc(14, lut_clip(P[0].g + (c1.g * delta_r >> 5) + (c2.g * delta_g >> 5) + (c3.g * delta_b >> 5), 0, 16383));
                dst_t.set_slc(0, lut_clip(P[0].b + (c1.b * delta_r >> 5) + (c2.b * delta_g >> 5) + (c3.b * delta_b >> 5), 0, 16383));
                #endif
            }
            else{
                dst_t = src_t;
            }
            dst.write(dst_t);
        }
    }
}
