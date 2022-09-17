#include "cac.h"

uint14 cac_clip(int21 a, int lower, int upper){
    uint14 result;
    if(a < lower)
        result = lower;
    else if (a > upper)
        result = upper;
    else
        result = a;
    return result;
}

int18 cac_max(int a, int b) {
    int18 result;
    if(a > b)
        result = a;
    else
        result = b;
    return result;
}

int18 cac_min(int a, int b) {
    int18 result;
    if(a < b)
        result = a;
    else
        result = b;
    return result;
}

void cac(top_register top_reg, cac_register cac_reg, stream_u42 &src, stream_u42 &dst) {
    uint42 src_t;
    uint42 dst_t;
    uint42 rgbWindow[7][7];
    uint42 lineBuffer[6][8192];
    int17 r_edge_h[5]; // the fourth row horizontal sobel edge detection value of r channel
    int17 g_edge_h[5];
    int17 b_edge_h[5];
    int17 r_edge_v[5]; // the fourth column vertical sobel edge detection value of r channel
    int17 g_edge_v[5];
    int17 b_edge_v[5];
    pixel_temp inPixel_int[7][7]; // the signed pixel values
    int15 bg_diff_h[7]; // the diff between b and g in horizontal direction
    int15 rg_diff_h[7];
    int15 bg_diff_v[7]; // the diff between b and g in vertical direction
    int15 rg_diff_v[7];
    uint3 l_t; // the left edge of horizontal transient
    uint3 r_t;
    uint3 u_t;
    uint3 d_t;

    cac_row: for(uint13 row = 0; row < top_reg.frameHeight; row++) {
        cac_col: for(uint13 col = 0; col < top_reg.frameWidth; col++) {
            src_t = src.read();

            if(cac_reg.eb == 1) {
                // loading rgbWindow in the first six col
                rgbWindow_loop: for(uint3 i = 0; i < 7; i++) {
                    rgbWindow_loop_j: for(uint3 j = 0; j < 6; j ++) {
                        rgbWindow[i][j] = rgbWindow[i][j+1];
                    }
                }

                // loading linebuffer to rgbWindow
                rgbWindow_read: for(uint3 i = 0; i < 6; i++) {
                    rgbWindow[i][6] = lineBuffer[i][col];
                }

                rgbWindow[6][6] = src_t;

                if((row > 5) || ((row == 5) && (col > 2))){
                    if((row > 5) && (col > 5)) {
                        // divide rgbWindow to r, g, b channel
                        pixel_temp_row: for(uint3 i = 0; i < 7; i++) {
                            pixel_temp_col: for(uint3 j = 0; j < 7; j++) {
                                inPixel_int[i][j].r = rgbWindow[i][j] >> 28;
                                inPixel_int[i][j].g = (rgbWindow[i][j]>>14)&0x3fff;
                                inPixel_int[i][j].b = rgbWindow[i][j]&0x3fff;
                            }
                        }

                        // caculate edge information with sobel mask
                        edge_h_loop: for(uint3 i = 0; i < 5; i++) {
                            r_edge_h[i] = 2 * inPixel_int[3][i].r + inPixel_int[2][i].r + inPixel_int[4][i].r - 2 * inPixel_int[3][i+2].r - inPixel_int[2][i+2].r - inPixel_int[4][i+2].r;
                            g_edge_h[i] = 2 * inPixel_int[3][i].g + inPixel_int[2][i].g + inPixel_int[4][i].g - 2 * inPixel_int[3][i+2].g - inPixel_int[2][i+2].g - inPixel_int[4][i+2].g;
                            b_edge_h[i] = 2 * inPixel_int[3][i].b + inPixel_int[2][i].b + inPixel_int[4][i].b - 2 * inPixel_int[3][i+2].b - inPixel_int[2][i+2].b - inPixel_int[4][i+2].b;
                            r_edge_v[i] = 2 * inPixel_int[i][3].r + inPixel_int[i][2].r + inPixel_int[i][4].r - 2 * inPixel_int[i+2][3].r - inPixel_int[i+2][2].r - inPixel_int[i+2][4].r;
                            g_edge_v[i] = 2 * inPixel_int[i][3].g + inPixel_int[i][2].g + inPixel_int[i][4].g - 2 * inPixel_int[i+2][3].g - inPixel_int[i+2][2].g - inPixel_int[i+2][4].g;
                            b_edge_v[i] = 2 * inPixel_int[i][3].b + inPixel_int[i][2].b + inPixel_int[i][4].b - 2 * inPixel_int[i+2][3].b - inPixel_int[i+2][2].b - inPixel_int[i+2][4].b;
                        }

                        // caculate difference information
                        diff_loop: for(uint3 i = 0; i < 7; i++) {
                            bg_diff_h[i] = inPixel_int[3][i].b - inPixel_int[3][i].g;
                            rg_diff_h[i] = inPixel_int[3][i].r - inPixel_int[3][i].g;
                            bg_diff_v[i] = inPixel_int[i][3].b - inPixel_int[i][3].g;
                            rg_diff_v[i] = inPixel_int[i][3].r - inPixel_int[i][3].g;
                        }

                        #ifdef DEBUG
                        if(row == ROW_TEST + 5 && col == COL_TEST + 3) {
                            printf("rg_diff_h \t%d\t%d\t%d\t%d\t%d|\t%d\t%d\n", rg_diff_h[0].to_int(),rg_diff_h[1].to_int(),rg_diff_h[2].to_int(),rg_diff_h[3].to_int(),rg_diff_h[4].to_int(),rg_diff_h[5].to_int(),rg_diff_h[6].to_int());
                            printf("bg_diff_h \t%d\t%d\t%d\t%d\t%d|\t%d\t%d\n", bg_diff_h[0].to_int(),bg_diff_h[1].to_int(),bg_diff_h[2].to_int(),bg_diff_h[3].to_int(),bg_diff_h[4].to_int(),bg_diff_h[5].to_int(),bg_diff_h[6].to_int());
                            printf("rg_diff_v \t%d\t%d\t%d\t%d\t%d|\t%d\t%d\n", rg_diff_v[0].to_int(),rg_diff_v[1].to_int(),rg_diff_v[2].to_int(),rg_diff_v[3].to_int(),rg_diff_v[4].to_int(),rg_diff_v[5].to_int(),rg_diff_v[6].to_int());
                            printf("bg_diff_v \t%d\t%d\t%d\t%d\t%d|\t%d\t%d\n", bg_diff_v[0].to_int(),bg_diff_v[1].to_int(),bg_diff_v[2].to_int(),bg_diff_v[3].to_int(),bg_diff_v[4].to_int(),bg_diff_v[5].to_int(),bg_diff_v[6].to_int());
                            printf("r_edge_h \t%d\t%d\t%d\t%d\t%d|\n", r_edge_h[0].to_int(),r_edge_h[1].to_int(),r_edge_h[2].to_int(),r_edge_h[3].to_int(),r_edge_h[4].to_int());
                            printf("g_edge_h \t%d\t%d\t%d\t%d\t%d|\n", g_edge_h[0].to_int(),g_edge_h[1].to_int(),g_edge_h[2].to_int(),g_edge_h[3].to_int(),g_edge_h[4].to_int());
                            printf("b_edge_h \t%d\t%d\t%d\t%d\t%d|\n", b_edge_h[0].to_int(),b_edge_h[1].to_int(),b_edge_h[2].to_int(),b_edge_h[3].to_int(),b_edge_h[4].to_int());
                            printf("r_edge_v \t%d\t%d\t%d\t%d\t%d|\n", r_edge_v[0].to_int(),r_edge_v[1].to_int(),r_edge_v[2].to_int(),r_edge_v[3].to_int(),r_edge_v[4].to_int());
                            printf("g_edge_v \t%d\t%d\t%d\t%d\t%d|\n", g_edge_v[0].to_int(),g_edge_v[1].to_int(),g_edge_v[2].to_int(),g_edge_v[3].to_int(),g_edge_v[4].to_int());
                            printf("b_edge_v \t%d\t%d\t%d\t%d\t%d|\n", b_edge_v[0].to_int(),b_edge_v[1].to_int(),b_edge_v[2].to_int(),b_edge_v[3].to_int(),b_edge_v[4].to_int());
                        }
                        #endif

                        if(g_edge_h[2] > cac_reg.t_transient || g_edge_h[2] < -cac_reg.t_transient) {
                            // the mux to search l_t and r_t, the abs operation is divided to plus or minus operation
                            if(g_edge_h[2] > cac_reg.t_transient) {
                                if((r_edge_h[1] < cac_reg.t_edge) && (g_edge_h[1] < cac_reg.t_edge) && (b_edge_h[1] < cac_reg.t_edge))
                                    l_t = 2;
                                else if((r_edge_h[0] < cac_reg.t_edge) && (g_edge_h[0] < cac_reg.t_edge) && (b_edge_h[0] < cac_reg.t_edge))
                                    l_t = 1;
                                else
                                    l_t = 0; // if can not find the l_t, the gradients are large in all left pixels， so l_t = 0

                                if((r_edge_h[3] < cac_reg.t_edge) && (g_edge_h[3] < cac_reg.t_edge) && (b_edge_h[3] < cac_reg.t_edge))
                                    r_t = 4;
                                else if((r_edge_h[4] < cac_reg.t_edge) && (g_edge_h[4] < cac_reg.t_edge) && (b_edge_h[4] < cac_reg.t_edge))
                                    r_t = 5;
                                else
                                    r_t = 6; // if can not find the r_t, the gradients are large in all right pixels， so r_t = 6
                            }
                            else {
                                if((r_edge_h[1] > -cac_reg.t_edge) && (g_edge_h[1] > -cac_reg.t_edge) && (b_edge_h[1] > -cac_reg.t_edge))
                                    l_t = 2;
                                else if((r_edge_h[0] > -cac_reg.t_edge) && (g_edge_h[0] > -cac_reg.t_edge) && (b_edge_h[0] > -cac_reg.t_edge))
                                    l_t = 1;
                                else
                                    l_t = 0;

                                if((r_edge_h[3] > -cac_reg.t_edge) && (g_edge_h[3] > -cac_reg.t_edge) && (b_edge_h[3] > -cac_reg.t_edge))
                                    r_t = 4;
                                else if((r_edge_h[4] > -cac_reg.t_edge) && (g_edge_h[4] > -cac_reg.t_edge) && (b_edge_h[4] >- cac_reg.t_edge))
                                    r_t = 5;
                                else
                                    r_t = 6;
                            }

                            // correction horizontal pixels between l_t and r_t
                            #ifdef catapult
                            // vivado can not pipeline with these code, so it is only for catapult, although there are larger area, there are greater slack
                            // catapult slack = 3.23 area = 74456.86
                            l_r_loop: for(uint3 i = l_t; i <= d_t; i++) {
                                if(bg_diff_h[i] > cac_max(bg_diff_h[l_t], bg_diff_h[r_t])) {
                                    inPixel_int[3][i].b = inPixel_int[3][i].g + cac_max(bg_diff_h[l_t],bg_diff_h[r_t]);
                                }
                                else if(bg_diff_h[i] < cac_min(bg_diff_h[l_t], bg_diff_h[r_t])) {
                                    inPixel_int[3][i].b = inPixel_int[3][i].g + cac_min(bg_diff_h[l_t],bg_diff_h[r_t]);
                                }

                                if(rg_diff_h[i] > cac_max(rg_diff_h[l_t], rg_diff_h[r_t])) {
                                    inPixel_int[3][i].r = inPixel_int[3][i].g + cac_max(rg_diff_h[l_t],rg_diff_h[r_t]);
                                }
                                else if(rg_diff_h[i] < cac_min(rg_diff_h[l_t], rg_diff_h[r_t])) {
                                    inPixel_int[3][i].r = inPixel_int[3][i].g + cac_min(rg_diff_h[l_t],rg_diff_h[r_t]);
                                }
                            }
                            #endif

                            #ifdef vivado
                            //catapult slack = 0 area = 65718.81
                            l_r_loop: for(uint3 i = 0; i <= 6; i++) {
                                if(i > l_t && i < r_t) {
                                    if(bg_diff_h[i] > cac_max(bg_diff_h[l_t], bg_diff_h[r_t])) {
                                        inPixel_int[3][i].b = inPixel_int[3][i].g + cac_max(bg_diff_h[l_t],bg_diff_h[r_t]);
                                    }
                                    else if(bg_diff_h[i] < cac_min(bg_diff_h[l_t], bg_diff_h[r_t])) {
                                        inPixel_int[3][i].b = inPixel_int[3][i].g + cac_min(bg_diff_h[l_t],bg_diff_h[r_t]);
                                    }

                                    if(rg_diff_h[i] > cac_max(rg_diff_h[l_t], rg_diff_h[r_t])) {
                                        inPixel_int[3][i].r = inPixel_int[3][i].g + cac_max(rg_diff_h[l_t],rg_diff_h[r_t]);
                                    }
                                    else if(rg_diff_h[i] < cac_min(rg_diff_h[l_t], rg_diff_h[r_t])) {
                                        inPixel_int[3][i].r = inPixel_int[3][i].g + cac_min(rg_diff_h[l_t],rg_diff_h[r_t]);
                                    }
                                }
                            }
                            #endif

                            #ifdef DEBUG
                            if(row == ROW_TEST + 5 && col == COL_TEST + 3) {
                                printf("inPixel_int[1][3].r=%d\n", inPixel_int[1][3].r.to_int());
                                printf("inPixel_int[1][3].b=%d\n", inPixel_int[1][3].b.to_int());
                            }
                            #endif
                        }

                        if(g_edge_v[2] > cac_reg.t_transient || g_edge_v[2] < -cac_reg.t_transient) {
                            // the mux to search l_t and r_t,  the abs operation is divided to plus or minus operation
                            if(g_edge_v[2] > cac_reg.t_transient) {
                                if((r_edge_v[1] < cac_reg.t_edge) && (g_edge_v[1] < cac_reg.t_edge) && (b_edge_v[1] < cac_reg.t_edge))
                                    u_t = 2;
                                else if((r_edge_v[0] < cac_reg.t_edge) && (g_edge_v[0] < cac_reg.t_edge) && (b_edge_v[0] < cac_reg.t_edge))
                                    u_t = 1;
                                else
                                    u_t = 0; // if can not find the u_t, the gradients are large in all up pixels， so u_t = 0

                                if((r_edge_v[3] < cac_reg.t_edge) && (g_edge_v[3] < cac_reg.t_edge) && (b_edge_v[3] < cac_reg.t_edge))
                                    d_t = 4;
                                else if((r_edge_v[4] < cac_reg.t_edge) && (g_edge_v[4] < cac_reg.t_edge) && (b_edge_v[4] < cac_reg.t_edge))
                                    d_t = 5;
                                else
                                    d_t = 6; // if can not find the d_t, the gradients are large in all down pixels， so d_t = 6
                            }
                            else {
                                if((r_edge_v[1] > -cac_reg.t_edge) && (g_edge_v[1] > -cac_reg.t_edge) && (b_edge_v[1] > -cac_reg.t_edge))
                                    u_t = 2;
                                else if((r_edge_v[0] > -cac_reg.t_edge) && (g_edge_v[0] > -cac_reg.t_edge) && (b_edge_v[0] > -cac_reg.t_edge))
                                    u_t = 1;
                                else
                                    u_t = 0;

                                if((r_edge_v[3] > -cac_reg.t_edge) && (g_edge_v[3] > -cac_reg.t_edge) && (b_edge_v[3] > -cac_reg.t_edge))
                                    d_t = 4;
                                else if((r_edge_v[4] > -cac_reg.t_edge) && (g_edge_v[4] > -cac_reg.t_edge) && (b_edge_v[4] >- cac_reg.t_edge))
                                    d_t = 5;
                                else
                                    d_t = 6;
                            }

                            // correction vertical pixels between u_t and d_t, the same as horizontal direction
                            #ifdef catapult
                            u_d_loop: for(uint3 i = u_t; i <= d_t; i++) {
                                    if(bg_diff_v[i] > cac_max(bg_diff_v[u_t], bg_diff_v[d_t])) {
                                        inPixel_int[i][3].b = inPixel_int[i][3].g + cac_max(bg_diff_v[u_t],bg_diff_v[d_t]);
                                    }
                                    else if(bg_diff_v[i] < cac_min(bg_diff_v[u_t], bg_diff_v[d_t])) {
                                        inPixel_int[i][3].b = inPixel_int[i][3].g + cac_min(bg_diff_v[u_t],bg_diff_v[d_t]);
                                    }

                                    if(rg_diff_v[i] > cac_max(rg_diff_v[u_t], rg_diff_v[d_t])) {
                                        inPixel_int[i][3].r = inPixel_int[i][3].g + cac_max(rg_diff_v[u_t],rg_diff_v[d_t]);
                                    }
                                    else if(rg_diff_v[i] < cac_min(rg_diff_v[u_t], rg_diff_v[d_t])) {
                                        inPixel_int[i][3].r = inPixel_int[i][3].g + cac_min(rg_diff_v[u_t],rg_diff_v[d_t]);
                                    }
                            }
                            #endif

                            #ifdef vivado
                            u_d_loop: for(uint3 i = 0; i <= 6; i++) {
                                if(i > u_t && i < d_t) {
                                    if(bg_diff_v[i] > cac_max(bg_diff_v[u_t], bg_diff_v[d_t])) {
                                        inPixel_int[i][3].b = inPixel_int[i][3].g + cac_max(bg_diff_v[u_t],bg_diff_v[d_t]);
                                    }
                                    else if(bg_diff_v[i] < cac_min(bg_diff_v[u_t], bg_diff_v[d_t])) {
                                        inPixel_int[i][3].b = inPixel_int[i][3].g + cac_min(bg_diff_v[u_t],bg_diff_v[d_t]);
                                    }

                                    if(rg_diff_v[i] > cac_max(rg_diff_v[u_t], rg_diff_v[d_t])) {
                                        inPixel_int[i][3].r = inPixel_int[i][3].g + cac_max(rg_diff_v[u_t],rg_diff_v[d_t]);
                                    }
                                    else if(rg_diff_v[i] < cac_min(rg_diff_v[u_t], rg_diff_v[d_t])) {
                                        inPixel_int[i][3].r = inPixel_int[i][3].g + cac_min(rg_diff_v[u_t],rg_diff_v[d_t]);
                                    }
                                }
                            }
                            #endif

                            #ifdef DEBUG
                            if(row == ROW_TEST + 5 && col == COL_TEST + 3) {
                                printf("inPixel_int[1][3].r=%d\n", inPixel_int[1][3].r.to_int());
                                printf("inPixel_int[1][3].b=%d\n", inPixel_int[1][3].b.to_int());
                            }
                            #endif
                        }

                        // output the inPixel[1][3]
                        #ifdef vivado
                        dst_t(41,28) = uint14(cac_clip(inPixel_int[1][3].r, 0, 16383));
                        dst_t(27,14) = uint14(cac_clip(inPixel_int[1][3].g, 0, 16383));
                        dst_t(13,0) = uint14(cac_clip(inPixel_int[1][3].b, 0, 16383));
                        #endif
                        #ifdef catapult
                        dst_t.set_slc(28,uint14(cac_clip(inPixel_int[1][3].r, 0, 16383)));
                        dst_t.set_slc(14,uint14(cac_clip(inPixel_int[1][3].g, 0, 16383)));
                        dst_t.set_slc(0,uint14(cac_clip(inPixel_int[1][3].b, 0, 16383)));
                        #endif

                        // write back the pixels to rgbWindow, only for the third row and the third column
                        window_return_row: for(uint4 j = 1; j < 6; j++) {
                            #ifdef vivado
                            rgbWindow[3][j](41,28) = uint14(cac_clip(inPixel_int[3][j].r, 0, 16383));
                            rgbWindow[3][j](27,14) = uint14(cac_clip(inPixel_int[3][j].g, 0, 16383));
                            rgbWindow[3][j](13,0) = uint14(cac_clip(inPixel_int[3][j].b, 0, 16383));
                            rgbWindow[j][3](41,28) = uint14(cac_clip(inPixel_int[j][3].r, 0, 16383));
                            rgbWindow[j][3](27,14) = uint14(cac_clip(inPixel_int[j][3].g, 0, 16383));
                            rgbWindow[j][3](13,0) = uint14(cac_clip(inPixel_int[j][3].b, 0, 16383));
                            #endif
                            #ifdef catapult
                            rgbWindow[3][j].set_slc(28, uint14(cac_clip(inPixel_int[3][j].r, 0, 16383)));
                            rgbWindow[3][j].set_slc(14, uint14(cac_clip(inPixel_int[3][j].g, 0, 16383)));
                            rgbWindow[3][j].set_slc(0, uint14(cac_clip(inPixel_int[3][j].b, 0, 16383)));
                            rgbWindow[j][3].set_slc(28, uint14(cac_clip(inPixel_int[j][3].r, 0, 16383)));
                            rgbWindow[j][3].set_slc(14, uint14(cac_clip(inPixel_int[j][3].g, 0, 16383)));
                            rgbWindow[j][3].set_slc(0, uint14(cac_clip(inPixel_int[j][3].b, 0, 16383)));
                            #endif
                        }
                    }
                    else {
                        dst_t = rgbWindow[1][3];
                    }
                    dst.write(dst_t);
                }

                // write back to the pixels to the linebuffer
                lineBuffer_write: for(uint4 i = 0; i < 6; i++) {
                    // before correction cycles, write back the final column
                    if(row <= 5 || ((row == 6) && (col < 6))) {
                        lineBuffer[i][col] = rgbWindow[i+1][6];
                    }
                    // correction cycles, write back the first column
                    else if(col >= 6) {
                        lineBuffer[i][col - 6] = rgbWindow[i+1][0];
                    }
                    else {
                        lineBuffer[i][top_reg.frameWidth + col - 6] = rgbWindow[i+1][0];
                    }
                }

            }
            else {
                dst.write(src_t);
            }
        }
    }

    // padding processing
    if(cac_reg.eb == 1) {
        addon_loop_1: for (uint4 cnt = 0; cnt < 3; cnt++){
            dst.write(rgbWindow[1][4+cnt]);
        }
        addon_loop_2: for (uint3 i = 0; i < 5; i++) {
            for(uint14 j = 0; j < top_reg.frameWidth; j++) {
                if(j < top_reg.frameWidth - 6) {
                    dst.write(lineBuffer[i+1][j]);
                }
                else {
                    dst.write(rgbWindow[i+2][7+j-top_reg.frameWidth]);
                }
            }
        }
    }
}
