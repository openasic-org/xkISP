# dpc
## parameters
```C++
typedef struct
{
    bool     eb;
    uint11   th_w;
    uint11   th_b;
}dpc_register;
```

1. `eb`

dpc module enable

2. `th_w`

hightlighted pixel threshold

3. `th_b`

dim pixel threshold

## code manual
### algorithm
The pinto algorithm is used for processing. The pinto algorithm is based on the fact that a dead pixel is an extremely bright or dark pixel in its neighborhood, and the pixel value is the largest (smallest) value in the neighborhood. If the difference between the central pixel value and the surrounding pixel values is all positive or all negative, the point is a dead pixel which is replaced by the median value of the surrounding pixels; if the difference is both positive and negative, the point is considered normal and is not processed by the pinto algorithm. The templates of the R, G and B channels are selected separately for filtering.

### code
```C++
dpc_loop_out:for(uint13 row = 0; row < top_reg.frameHeight; row++){
        dpc_loop_in:for(uint13 col = 0; col < top_reg.frameWidth; col++){
            srcData = src.read();
            if(dpc_reg.eb == 1){
                rawWin_loop:for(uint3 i = 0; i < 5; i++){
                    rawWindow[i][0] = rawWindow[i][1];
                    rawWindow[i][1] = rawWindow[i][2];
                    rawWindow[i][2] = rawWindow[i][3];
                    rawWindow[i][3] = rawWindow[i][4];
                }

                rawWindow_read:for(uint3 i = 0; i < 4; i++){
                    rawWindow[i][4] = lineBuffer[i][col];

                }

                rawWindow[4][4] = srcData;

                line_write:for(uint3 i = 0; i < 4; i++){
                    lineBuffer[i][col] = rawWindow[i+1][4];

                }

                if((row > 3)&&(col > 3)){
                    uint2 bayerPattern = (((row & 1) << 1) + (col & 1))^top_reg.imgPattern;
                    pixel = rawWindow[2][2];

                    if(bayerPattern == 0 || bayerPattern == 3){
                        arr_ori[0] = rawWindow[0][0];
                        arr_ori[1] = rawWindow[0][2];
                        arr_ori[2] = rawWindow[0][4];
                        arr_ori[3] = rawWindow[2][0];
                        arr_ori[4] = rawWindow[2][4];
                        arr_ori[5] = rawWindow[4][0];
                        arr_ori[6] = rawWindow[4][2];
                        arr_ori[7] = rawWindow[4][4];

                        flag = defectPixelDetection(arr_ori, pixel, th_w, th_b);
                        if(flag == 1){
                            dstData = medianFilter(arr_ori, arr_sort);
                        }
                        else{
                            dstData = pixel;
                        }
                    }
                    else{
                        arr_ori[0] = rawWindow[0][2];
                        arr_ori[1] = rawWindow[1][1];
                        arr_ori[2] = rawWindow[1][3];
                        arr_ori[3] = rawWindow[2][0];
                        arr_ori[4] = rawWindow[2][4];
                        arr_ori[5] = rawWindow[3][1];
                        arr_ori[6] = rawWindow[3][3];
                        arr_ori[7] = rawWindow[4][2];

                        flag = defectPixelDetection(arr_ori, pixel, th_w, th_b);
                        if(flag == 1){
                            dstData = medianFilter(arr_ori, arr_sort);
                        }
                        else{
                            dstData = pixel;
                        }
                    }
                }
                else{
                    dstData = 0;
                }
            }
            else
            {
                dstData = srcData;
            }
            if((row > 2) || ((row==2) && (col > 1))){

                dst.write(dstData);
            }
        }
    }
```
If `dpc_reg.eb = 1` get the 5x5 windows to evaluate if the centre point is a dead pixel.
```C++
rawWin_loop:for(uint3 i = 0; i < 5; i++){
  rawWindow[i][0] = rawWindow[i][1];
  rawWindow[i][1] = rawWindow[i][2];
  rawWindow[i][2] = rawWindow[i][3];
  rawWindow[i][3] = rawWindow[i][4];
}

rawWindow_read:for(uint3 i = 0; i < 4; i++){
  rawWindow[i][4] = lineBuffer[i][col];

}

rawWindow[4][4] = srcData;

line_write:for(uint3 i = 0; i < 4; i++){
  lineBuffer[i][col] = rawWindow[i+1][4];

}
```

Dead pixel detection. Get the difference between center pixel and surrounding pixel, if the difference bigger than `th_w`, the center pixel is a hightlighted pixel, and if the difference smaller than `th_b`, the center pixel is a dim pixel. These two cases return 1, the center pixel is a dead pixel.
```C++
bool defectPixelDetection(uint12 arr_ori[8], uint12 pixel, uint11 th_w, uint11 th_b){
    int12 th_1 = th_w;
    int12 th_2 = -th_b;

    int13 diff_0;
    int13 diff_1;
    int13 diff_2;
    int13 diff_3;
    int13 diff_4;
    int13 diff_5;
    int13 diff_6;
    int13 diff_7;

    bool rst;

    diff_0 = arr_ori[0] - pixel;
    diff_1 = arr_ori[1] - pixel;
    diff_2 = arr_ori[2] - pixel;
    diff_3 = arr_ori[3] - pixel;
    diff_4 = arr_ori[4] - pixel;
    diff_5 = arr_ori[5] - pixel;
    diff_6 = arr_ori[6] - pixel;
    diff_7 = arr_ori[7] - pixel;

    if (diff_0 < th_2 && diff_1 < th_2 && diff_2 < th_2 && diff_3 < th_2 && diff_4 < th_2 && diff_5 < th_2 && diff_6 < th_2 && diff_7 < th_2) {
        rst = 1; //defect pixel, black defect pixl
    }
    else if(diff_0 > th_1 && diff_1 > th_1 && diff_2 > th_1 && diff_3 > th_1 && diff_4 > th_1 && diff_5 > th_1 && diff_6 > th_1 && diff_7 > th_1)
    {
        rst = 1; //defect pixel, white defect pixel
    }
    else
    {
        rst = 0; //right pixel
    }

    return rst;
}
```

Median filter. The median filter first selects an i, does not sort for the time being for the corresponding value of j greater than i, makes a sort from smallest to largest for the corresponding value of j less than or equal to i, i traverses all the numbers, can get the original eight numbers from smallest to largest arrangement, finally takes the average of `arr_sort[3]` and `arrsort[4]` to get the median.
```C++
uint12 medianFilter(uint12 arr_ori[8], uint12 arr_sort[8]){
    uint12 item;
    uint12 t; //tmp value
    uint13 result;
    MF_outer:for (int6 i = 0; i < 8; i++)
    {
        item = arr_ori[i];

        MF_inter:for (int6 j = 7; j >= 0; j--) {
            if (j > i) {
                t = arr_sort[j];
            }
            else if (j > 0 && arr_sort[j - 1] > item)
            {
                t = arr_sort[j - 1];
            }
            else
            {
                t = item;
                if (j > 0)
                    item = arr_sort[j - 1];
            }
            arr_sort[j] = t;
        }

    }

    result = (arr_sort[3] + arr_sort[4]) >> 1;
    return result;
}
```
Finally the dead pixels are replaced by the median value and the good pixels are left unprocessed to obtain the output
