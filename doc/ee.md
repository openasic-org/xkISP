# Edge Enhancement

 **Edge enhancement is an image processing filter that enhances the edge contrast of an image or video in an attempt to improve its acutance (apparent sharpness).**

## **ee.h**

 EE.h header file contains some basic information of ee module.<br/><br/>
The relevant parameters of the ee module are stored in the ee_register struct. The eb parameter controls the switch of the module, and the coeff parameter controls the intensity of sharpening.

```c++
typedef struct{
    bool eb;
    uint8 coeff;
}ee_register;
```

The RGB value of each pixel is stored in the ee_pixel_t struct.

```c++
typedef struct{
   uint12 r;
   uint12 g;
   uint12 b;
}ee_pixel_t;
```

The edgeenhancement function is used as the main function of the ee module, which will call the eeprocess function to perform edge enhancement operations. And we will talk about it later.

```c++
void edgeenhancement(top_register&, ee_register&, stream_u36&, stream_u36&);
uint36 eeprocess(uint36[5][5], ee_register&);
```

## **ee.cpp**

### edgeenhancement


As mentioned above, edgeenhancement function serves as the main function to perform the sharpening operation of the entire image and will be translated by the HLS compiler into the RTL description of the ee module.<br/><br/>

EE module contains two storage unit `ee_block` and `ee_line`.
`ee_block` will be converted into registers for convolution operations, and `ee_line` will be translated into sram to improve throughput.

```c++
    uint36 ee_block[5][5];
    uint36 ee_lines[4][4096];
```

The following pragma instructs the compiler to translate the above two arrays into the corresponding memory.

```c++
set_directive_array_partition -type block -factor 5 -dim 1 "edgeenhancement" ee_block
set_directive_array_partition -type block -factor 4 -dim 1 "edgeenhancement" ee_lines
```

```single_loop``` traverses each pixel to process one pixel in one cycle.

The following code implements the transfer of data between storage units.

```c++
block_refresh_loop_out:for(k = 0;k < 5;k++){
            block_refresh_loop_in:for(l = 0;l < 4;l++){
                ee_block[k][l] = ee_block[k][l+1];
            }
        }

        for(k = 0;k < 4;k++){
            ee_block[k][4] = ee_lines[k][j];
        }
        ee_block[4][4] = src_in;

        for(k = 0;k < 4;k++){
            ee_lines[k][j] = ee_block[k+1][4];
        }
```

When ```eb``` is 0, the input pixels are output directly without any processing.
Only when ```eb``` is 1, the module will perform the sharpening operation on the input data,that is, call the ee_process function.

```c++
if(ee_top.eb)
        {
            if((i > 3) && (j > 3))
            {
                dst_out = eeprocess(ee_block, ee_top);
            }
            else
            {
                dst_out = ee_block[2][2];
            }

            if((i > 2) || ((i == 2) && (j >= 2)))
            {
                dst.write(dst_out);
            }
```

```padding_loop``` handles the case of pixels at the border of the image, which will be output directly from ```ee_line```.

```c++
       padding_loop_1:for(k = 0;k < 2;k++){
           dst_out = ee_lines[1][isp_top.frameWidth - 2 + k];
           dst.write(dst_out);
       }

       padding_loop_2:for(k = 0;k < 2;k++){
           padding_loop_3:for(i = 0;i < isp_top.frameWidth;i++){
               dst.write(ee_lines[k+2][i]);
           }
```


### ee_process
The function ```ee_process``` implements the unsharp masking algorithm.

First, the low-frequency part of the image ```low_feq_r```,```low_feq_g```,```low_feq_b``` is obtained by performing low-pass filtering twice on the image.<br/>
The filtering process is represented by the following two loops.Gaussian filtering comes first.

```c++
for(k = 0;k < 5 ;k++)
    {
        for(l = 0;l < 5 ;l++)
        {
            rblock[k][l] = (int13)(ee_block[k][l] >> 24);
            gblock[k][l] = (int13)((ee_block[k][l] >> 12) & 0xfff);
            bblock[k][l] = (int13)(ee_block[k][l] & 0xfff);
            sharpen_threhold_r += guass_55[k][l] * rblock[k][l];
            sharpen_threhold_g += guass_55[k][l] * gblock[k][l];
            sharpen_threhold_b += guass_55[k][l] * bblock[k][l];
        }
    }
//guass_55[5][5] = {1,2,4,2,1,2,4,8,4,2,4,8,16,8,4,2,4,8,4,2,1,2,4,2,1};
```
The second one is average filtering.
```c++
 for(k = 0; k < 5; k++) {
        for (l = 0; l < 4; l++) {

            feq_l[l] = rblock[l][k]/2 + rblock[l + 1][k]/2;
            feq_h[l] = rblock[l][k]/2 - rblock[l + 1][k]/2;

            if(feq_h[l] > sharpen_threhold_r)
            {
                feq_h[l] -= sharpen_threhold_r;
            }
            else if(feq_h[l] < - sharpen_threhold_r)
            {
                feq_h[l] += sharpen_threhold_r;
            }
            else
            {
                feq_h[l] = 0;
            }
        }

        temp_r = feq_l[1]/2 + feq_h[1]/2 + feq_l[2]/2 + feq_h[2]/2;
        result_v[k] = ee_clip(temp_r);
```
The second step is to subtract the low-frequency image from the original image to obtain high-frequency details.<br/>
Finally,The high-frequency part is multiplied by the set ```coeff``` parameter, and then superimposed on the original image to achieve image sharpening.

```c++
    high_feq_r = (int15)rblock[2][2] - low_feq_r;
    r_middle = high_feq_r * ee_top.coeff + 8;
    r_result = (r_middle >> 4) + low_feq_r;
    //red channnel as an example
```




