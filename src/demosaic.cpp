//Created by Jia Wang 2021/2/20

#include "demosaic.h"

rawData_t demosaic_clip(int18 a, int lower, int upper) {
    rawData_t result;
    if (a < lower)
        result = lower;
    else if (a > upper)
        result = upper;
    else
        result = a;
    return result;
}

pixel_t demosaicInterpol(rawData_t rawWindow[5][5], uint2 bayerPattern)
{
    pixelTmp_t  pixTmp;
    pixel_t   pixel;

    if (bayerPattern == 0)
    {
        pixTmp.r = rawWindow[2][2];
        pixTmp.g = 4 * rawWindow[2][2] - rawWindow[0][2] - rawWindow[2][0] - rawWindow[4][2] - rawWindow[2][4] \
                   + 2 * (rawWindow[3][2] + rawWindow[2][3] + rawWindow[1][2] + rawWindow[2][1]);
        pixTmp.b = 6 * rawWindow[2][2] - 3 * (rawWindow[0][2] + rawWindow[2][0] + rawWindow[4][2] + rawWindow[2][4]) / 2 \
                   + 2 * (rawWindow[1][1] + rawWindow[1][3] + rawWindow[3][1] + rawWindow[3][3]);
        pixTmp.g = pixTmp.g / 8;
        pixTmp.b = pixTmp.b / 8; 
    }
    else if (bayerPattern == 1)
    {
        pixTmp.r = 5 * rawWindow[2][2] - rawWindow[2][0] - rawWindow[1][1] - rawWindow[3][1] - rawWindow[1][3] - rawWindow[3][3] - rawWindow[2][4] \
                   + (rawWindow[0][2] + rawWindow[4][2]) / 2 + 4 * (rawWindow[2][1] + rawWindow[2][3]);
        pixTmp.g = rawWindow[2][2];
        pixTmp.b = 5 * rawWindow[2][2] - rawWindow[0][2] - rawWindow[1][1] - rawWindow[1][3] - rawWindow[4][2] - rawWindow[3][1] - rawWindow[3][3] \
                   + (rawWindow[2][0] + rawWindow[2][4]) / 2 + 4 * (rawWindow[1][2] + rawWindow[3][2]);
        pixTmp.r = pixTmp.r / 8;
        pixTmp.b = pixTmp.b / 8;
    }
    else if (bayerPattern == 2)
    {
        pixTmp.r = 5 * rawWindow[2][2] - rawWindow[0][2] - rawWindow[1][1] - rawWindow[1][3] - rawWindow[4][2] - rawWindow[3][1] - rawWindow[3][3] \
                   + (rawWindow[2][0] + rawWindow[2][4]) / 2 + 4 * (rawWindow[1][2] + rawWindow[3][2]);
        pixTmp.g = rawWindow[2][2];
        pixTmp.b = 5 * rawWindow[2][2] - rawWindow[2][0] - rawWindow[1][1] - rawWindow[3][1] - rawWindow[1][3] - rawWindow[3][3] - rawWindow[2][4] \
                   + (rawWindow[0][2] + rawWindow[4][2]) / 2 + 4 * (rawWindow[2][1] + rawWindow[2][3]);
        pixTmp.r = pixTmp.r / 8;
        pixTmp.b = pixTmp.b / 8;
    }
    else
    {
        pixTmp.r = 6 * rawWindow[2][2] - 3 * (rawWindow[0][2] + rawWindow[2][0] + rawWindow[4][2] + rawWindow[2][4]) / 2 \
                   + 2 * (rawWindow[1][1] + rawWindow[1][3] + rawWindow[3][1] + rawWindow[3][3]);
        pixTmp.g = 4 * rawWindow[2][2] - rawWindow[0][2] - rawWindow[2][0] - rawWindow[4][2] - rawWindow[2][4] \
                   + 2 * (rawWindow[3][2] + rawWindow[2][3] + rawWindow[1][2] + rawWindow[2][1]);
        pixTmp.b = rawWindow[2][2];
        pixTmp.r = pixTmp.r / 8;
        pixTmp.g = pixTmp.g / 8;
    }
    pixel.r = demosaic_clip(pixTmp.r, 0, 4095);
    pixel.g = demosaic_clip(pixTmp.g, 0, 4095);
    pixel.b = demosaic_clip(pixTmp.b, 0, 4095);

    return pixel;
}

void demosaic(top_register top_reg, demosaic_register demosaic_reg, Stream_t& src, Stream_3t& dst)
{
    uint36 dst_t;
    rawData_t srcPixel;
    rawData_t rawWindow[5][5];
    int jiayou = 0;
    uint3 i;

    rawData_t lineBuf[4][4096];
    pixel_t outPixel;
    outer_loop:for(uint13 row = 0; row < top_reg.frameHeight; row++){
        inner_loop:for(uint13 col = 0; col < top_reg.frameWidth; col++){
            srcPixel = src.read();
            if(demosaic_reg.eb == 1) {
                window_loop:for(i = 0; i < 5; i++){
                    rawWindow[i][0] = rawWindow[i][1];
                    rawWindow[i][1] = rawWindow[i][2];
                    rawWindow[i][2] = rawWindow[i][3];
                    rawWindow[i][3] = rawWindow[i][4];
                }

                raw_read: for(i = 0; i < 4; i++) {
                    rawWindow[i][4] = lineBuf[i][col];
                }
                rawWindow[4][4] = srcPixel;
                line_write: for(i = 0; i < 4; i++) {
                    lineBuf[i][col] = rawWindow[i+1][4];
                } 

                if((row > 3) && (col > 3)){
                    uint2 bayerPattern = (((row & 1) << 1) + (col & 1))^top_reg.imgPattern;
                    outPixel = demosaicInterpol(rawWindow, bayerPattern);
                #ifdef vivado
                    dst_t(35,24) = outPixel.r;
                    dst_t(23,12) = outPixel.g;
                    dst_t(11,0) = outPixel.b;
                #endif
                #ifdef catapult
                    dst_t.set_slc(24,outPixel.r);
                    dst_t.set_slc(12,outPixel.g);
                    dst_t.set_slc(0,outPixel.b);
                #endif
                #ifdef DEBUG
                    if((row == ROW_TEST) && (col == COL_TEST)) {
                        printf("\t%x\t%x\n",row.to_int(),col.to_int());
                        printf("\tpattern = %d\n",bayerPattern.to_int());
                        printf("\t%x\t%x\t%x\t%x\t%x\n",rawWindow[0][0].to_int(),rawWindow[0][1].to_int(),rawWindow[0][2].to_int(),rawWindow[0][3].to_int(),rawWindow[0][4].to_int());
                        printf("\t%x\t%x\t%x\t%x\t%x\n",rawWindow[1][0].to_int(),rawWindow[1][1].to_int(),rawWindow[1][2].to_int(),rawWindow[1][3].to_int(),rawWindow[1][4].to_int());
                        printf("\t%x\t%x\t%x\t%x\t%x\n",rawWindow[2][0].to_int(),rawWindow[2][1].to_int(),rawWindow[2][2].to_int(),rawWindow[2][3].to_int(),rawWindow[2][4].to_int());
                        printf("\t%x\t%x\t%x\t%x\t%x\n",rawWindow[3][0].to_int(),rawWindow[3][1].to_int(),rawWindow[3][2].to_int(),rawWindow[3][3].to_int(),rawWindow[3][4].to_int());
                        printf("\t%x\t%x\t%x\t%x\t%x\n",rawWindow[4][0].to_int(),rawWindow[4][1].to_int(),rawWindow[4][2].to_int(),rawWindow[4][3].to_int(),rawWindow[4][4].to_int());
                        printf("\t%x\t%x\t%x\n",outPixel.r.to_int(),outPixel.g.to_int(),outPixel.b.to_int());
                    }
                #endif
                } else {
                    dst_t = 0;
                }
            } else {
                dst_t = 0; //srcPixel * (2^24) + srcPixel * (2^12) + srcPixel;
            }
            if((row > 2) || ((row==2) && (col > 1))){
                dst.write(dst_t);
            }
        }
    }
    addon_loop: for (uint14 cnt = 0; cnt < 2*top_reg.frameWidth + 2; cnt++){
        dst.write(0);
    }
};
