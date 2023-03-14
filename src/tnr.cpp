#include "tnr.h"

uint8 abs9(int9 x){
    if (x < 0) return -x;
    else return x;
}


#define MD_SIZE 5
#define MD_OFF 2
#define THRE 3750

uint10 abs11(int11 x){
    if (x < 0) return -x;
    else return x;
}

uint1 motionDection(uint20 ywindow[MD_SIZE][MD_SIZE], uint20 uwindow[MD_SIZE][MD_SIZE], uint20 vwindow[MD_SIZE][MD_SIZE])
{
    uint17 sad = 0;
    for(int i = 0; i < MD_SIZE; i++)
        for(int i = 0; i < MD_SIZE; i++)
        {
            {
                int11 ypixel0 = ywindow[MD_OFF][MD_OFF].slc<10>(0);
                int11 ypixel1 = ywindow[MD_OFF][MD_OFF].slc<10>(10);
                int11 upixel0 = uwindow[MD_OFF][MD_OFF].slc<10>(0);
                int11 upixel1 = uwindow[MD_OFF][MD_OFF].slc<10>(10);
                int11 vpixel0 = vwindow[MD_OFF][MD_OFF].slc<10>(0);
                int11 vpixel1 = vwindow[MD_OFF][MD_OFF].slc<10>(10);
                uint10 ydiff = abs11(ypixel0 - ypixel1);
                uint10 udiff = abs11(upixel0 - upixel1);
                uint10 vdiff = abs11(vpixel0 - vpixel1);
                sad += ydiff + udiff + vdiff;
            }
        }
        uint1 motion;
        if(sad > THRE) motion = 1;
        else motion = 0;
        return motion;
}





const uint8 mtf[256] = {0, 0, 0, 0, 0, 0, 0, 1, 2, 3, 5, 7, 9, 12, 15, 18, 21, 24, 28, 31, 35, 38, 41, 45, 48, 51, 55, 58, 61, 64, 67, 70, 73, 76, 79, 81, 84, 87, 89, 91, 94, 96, 98, 101, 103, 105, 107, 109, 111, 113, 115, 116, 118, 120, 122, 123, 125, 126, 128, 129, 131, 132, 134, 135, 136, 138, 139, 140, 142, 143, 144, 145, 146, 147, 149, 150, 151, 152, 153, 154, 155, 156, 157, 157, 158, 159, 160, 161, 162, 163, 164, 164, 165, 166, 167, 167, 168, 169, 170, 170, 171, 172, 172, 173, 174, 174, 175, 175, 176, 177, 177, 178, 178, 179, 180, 180, 181, 181, 182, 182, 183, 183, 184, 184, 185, 185, 186, 186, 187, 187, 187, 188, 188, 189, 189, 190, 190, 190, 191, 191, 192, 192, 192, 193, 193, 194, 194, 194, 195, 195, 195, 196, 196, 196, 197, 197, 197, 198, 198, 198, 199, 199, 199, 200, 200, 200, 200, 201, 201, 201, 202, 202, 202, 202, 203, 203, 203, 203, 204, 204, 204, 204, 205, 205, 205, 205, 206, 206, 206, 206, 207, 207, 207, 207, 207, 208, 208, 208, 208, 209, 209, 209, 209, 209, 210, 210, 210, 210, 210, 211, 211, 211, 211, 211, 212, 212, 212, 212, 212, 212, 213, 213, 213, 213, 213, 213, 214, 214, 214, 214, 214, 214, 215, 215, 215, 215, 215, 215, 216, 216, 216, 216, 216, 216, 216, 217, 217, 217, 217, 217, 217, 217, 218, 218, 218, 218};

uint10 merge(uint10 src0, uint10 src1, uint1 motion)
{
    int11 diff = src1 - src0;
    uint10 adiff = abs11(diff);
    uint8 id = adiff;
    uint8 k = 255;
    if(adiff > 255) k = 255;
    else k = mtf[id];
    int11 res_t = src0 + ((k * diff) >> 8);
    uint10 res;
    if(motion) res = src1;
    else res = res_t;
    return res;
}

void tnrBlock(uint13 width, uint13 height, stream_u10 &y0, stream_u10 &y1, stream_u10 &y2, stream_u10 &u0, stream_u10 &u1, stream_u10 &u2,stream_u10 &v0, stream_u10 &v1, stream_u10 &v2)
{
    // SACRIFICE BORDER PIXELS
    // DEF
    uint20 ywindow[MD_SIZE][MD_SIZE];
    uint20 uwindow[MD_SIZE][MD_SIZE];
    uint20 vwindow[MD_SIZE][MD_SIZE];
    uint20 ylineBuffer[MD_SIZE - 1][MAX_WIDTH];
    uint20 ulineBuffer[MD_SIZE - 1][MAX_WIDTH];
    uint20 vlineBuffer[MD_SIZE - 1][MAX_WIDTH];
    uint10 src0yIn;
    uint10 src1yIn;
    uint10 src0uIn;
    uint10 src1uIn;
    uint10 src0vIn;
    uint10 src1vIn;
    uint20 pixIn;
    // Main Loop
    for(uint13 row = 0; row < height + MD_OFF; row++)
        for(uint13 col = 0; col < width + MD_OFF; col++)
        {
            // Window Shifter Considering border
            for (int ii = 0; ii < MD_SIZE; ii++)
                for (int jj = 0; jj < MD_SIZE - 1; jj++)
                {
                    ywindow[ii][jj] = ywindow[ii][jj + 1];
                    uwindow[ii][jj] = uwindow[ii][jj + 1];
                    vwindow[ii][jj] = vwindow[ii][jj + 1];
                }
            // Window Last Column
            if (col < width)
            {
                for (int ii = 0; ii < MD_SIZE - 1; ii++)
                    {ywindow[ii][MD_SIZE - 1] = ylineBuffer[ii][col];
                    uwindow[ii][MD_SIZE - 1] = ulineBuffer[ii][col];
                    vwindow[ii][MD_SIZE - 1] = vlineBuffer[ii][col];
                    }}
            // LineBuffer Shifter
            if (col < width)
            {
                for (int ii = 0; ii < MD_SIZE - 2; ii++)
                    {ylineBuffer[ii][col] = ylineBuffer[ii + 1][col];
                    ulineBuffer[ii][col] = ulineBuffer[ii + 1][col];
                    vlineBuffer[ii][col] = vlineBuffer[ii + 1][col];}
            }
            // Fill incoming pixel
            if (row < height && col < width)
            {
                //y
                src0yIn = y0.read();
                src1yIn = y1.read();
                pixIn.set_slc(0, src0yIn);
                pixIn.set_slc(10, src1yIn);
                ywindow[MD_SIZE - 1][MD_SIZE - 1] = pixIn;
                ylineBuffer[MD_SIZE - 2][col] = pixIn;
                //u
                src0uIn = u0.read();
                src1uIn = u1.read();
                pixIn.set_slc(0, src0uIn);
                pixIn.set_slc(10, src1uIn);
                uwindow[MD_SIZE - 1][MD_SIZE - 1] = pixIn;
                ulineBuffer[MD_SIZE - 2][col] = pixIn;
                //v
                src0vIn = v0.read();
                src1vIn = v1.read();
                pixIn.set_slc(0, src0vIn);
                pixIn.set_slc(10, src1vIn);
                vwindow[MD_SIZE - 1][MD_SIZE - 1] = pixIn;
                vlineBuffer[MD_SIZE - 2][col] = pixIn;
            }
            // Process
            int11 ypixel0 = ywindow[MD_OFF][MD_OFF].slc<10>(0);
            int11 ypixel1 = ywindow[MD_OFF][MD_OFF].slc<10>(10);
            int11 upixel0 = uwindow[MD_OFF][MD_OFF].slc<10>(0);
            int11 upixel1 = uwindow[MD_OFF][MD_OFF].slc<10>(10);
            int11 vpixel0 = vwindow[MD_OFF][MD_OFF].slc<10>(0);
            int11 vpixel1 = vwindow[MD_OFF][MD_OFF].slc<10>(10);
            uint10 yrst, urst, vrst;
            uint1 mask =  motionDection(ywindow,uwindow,vwindow);
            // Output & Process
            yrst = merge(ypixel0,ypixel1,mask);
            urst = merge(upixel0,upixel1,mask);
            vrst = merge(vpixel0,vpixel1,mask);
            // Border Handling
            if((row < MD_SIZE - 1)|| (col < MD_SIZE - 1)||(row >= height)||(col >= width))
            {
                yrst = ypixel1;
                urst = upixel1;
                vrst = vpixel1;
            }       
            // Output 
            if ((row > MD_OFF - 1) && (col > MD_OFF - 1))
            {
                y2.write(yrst);
                u2.write(urst);
                v2.write(vrst);
                }
                // DEBUG
}
}
