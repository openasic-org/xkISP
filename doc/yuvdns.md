## Algorithm


Our YUV denoise module performs in YUV space.we choose the Non-local mean as our denosing algorithm in our hls implementation since it’s a hardware-friendly algorithm  and can be realized by using several line buffers to support for the window serach operation required by each pixel.


The NLM algorithm[<sup>1</sup>](#ref-anchor-1) is a simple but effective denosing method. Given a discrete noisy image $v = {v(i) | i ∈ I}$, the estimated value $NL[v](i)$, for a pixel i, is computed as a weighted average of all the pixels in the image,
$$ NL[v](i)=\sum_{j \in L}\omega(i,j)v(j) $$

the weights $\omega(i,j)$ are defined as:

$$\omega(i,j)=\frac{1}{Z(i)}e^{-\frac{\Vert v(N_i)-v(N_j)\Vert^2,a}{h^2}}$$

$v(N_i)$ is a vector formed by the grey values of the pixels around a squre neighborhood of fixed size centoered at pixel i.

As shown in Fig 1, similar pixel neighborhoods will be given a large weight, $w(p,q1)$ and $w(p,q2)$, while much different neighborhoods give a small weight $w(p,q3)$ .

![alt nlm_lena](./nlm_lena.png )
## HLS Implementation

### **register parameters**


```c++
    typedef struct{
    uint1 eb;//1 bit
    uint14 ysigma2;// sigma = [5,127]
    uint10 yinvsigma2;// invsigma = (1/sigma)<< 7
    uint14 uvsigma2;//[5,127]
    uint10 uvinvsigma2;//(1 / sigma) << 7
    uint4 yfilt;//[0.1~0.8] << 4
    uint4 uvfilt;//[0.1~0.8] << 4
    uint5 yinvfilt;//(1 / filt) << 1
    uint5 uvinvfilt;//(1 / filt) << 1
    uint14 yH2;
    uint18 yinvH2;
    uint14 uvH2;
    uint18 uvinvH2;
    }yuvdns_register;
```
the explanation of parameters in yuvdns_register are listed in **Table 1**



|parameters|explanation|
|:----:|:----|
|eb |controls the yuvdns module is enable or not|
|ysigma2|controls the squared deviation of the gaussian kernel used for distance measure for in Y plane|
|uvsigma2|controls the squared deviation of the gaussian kernel used for distance measure for in UV plane|
|yH2|acts as a degree of filtering in Y plane|
|uvH2|acts as a degree of filtering in UV plane|

## functions
### yuv444dns


```c++

void yuv444dns(top_register top_reg, yuvdns_register yuvdns_reg, stream_u10 &src_y, stream_u10 &src_u, stream_u10 &src_v, stream_u10 &dst_y, stream_u10 &dst_u, stream_u10 &dst_v)
```
### input/output description
|Params| description|
|:----:|:----|
|top_reg|global configure register |
|yuvdns_reg|a configure register used only by yuvdns moudule|
|src_y|Y component of source image streams|
|src_u|U component of source image streams|
|src_v|V component of source image streams|
|dst_y|	Y compoent of denoised image streams|
|dst_u|	U compoent of denoised image streams|
|dst_v|	V compoent of denoised image streams|

### Return value
**None**

### function description

yuv444dns is the top denosing function,it performs NLM denoise for incoming src_y、src_u、src_v pixel streams and outputs denosied pixel streams dst_y、dst_u、dst_v seperately and simutaneosly.

in the original Non local mean algorithm, the denosied value of a pixel is computed as a weighted average of all the pixels in the image which has a high demand of line buffers to store neighbor pixels,  thus we decrease the search area from the whole image to a 9x9 neigbor Window around the pixel.

in yuv444dns function 8 line buffers are defined to store previous line data, and a 9x9 2D array to get the searching window from   around the denosing pixel.
```c++
uint10 yWindow[9][9];
uint10 uWindow[9][9];
uint10 vWindow[9][9];
uint10 ylineBuf[8][4096];
uint10 ulineBuf[8][4096];
uint10 vlineBuf[8][4096];
```
for each pixel prepared to be denosied, we get the 9x9 window formed by it’s arounding pixels

the window pixel preparation could be diveded into three steps

**Step 1**
datas in the window shift left 1 pixel  width

```c++
for(uint4 i = 0; i < 9; i++){
    for(uint4 j = 0; j < 8; j++){
        yWindow[i][j] = yWindow[i][j+1];
        uWindow[i][j] = uWindow[i][j+1];
        vWindow[i][j] = vWindow[i][j+1];
    }
}


```
**Step 2**

the 9x9 Window reads 8x1 pixel data from the 8 linebuffers and the input stream pixel **y_t,u_t,v_t** and the 9x1 new pixels are stored in the rightest column of the Window
```c++
for(uint4 i = 0; i < 8; i++){
    yWindow[i][8] = ylineBuf[i][col];
    uWindow[i][8] = ulineBuf[i][col];
    vWindow[i][8] = vlineBuf[i][col];
}
yWindow[8][8] = y_t;
uWindow[8][8] = u_t;
vWindow[8][8] = v_t;
```
**Step 3**


Update the line buffer
```c++
for(uint4 i = 0; i < 7; i++){
    ylineBuf[i][col] = ylineBuf[i+1][col];
    ulineBuf[i][col] = ulineBuf[i+1][col];
    vlineBuf[i][col] = vlineBuf[i+1][col];
    }
ylineBuf[7][col] = y_t;
ulineBuf[7][col] = u_t;
vlineBuf[7][col] = v_t;
```
After the above 3 steps are finished,  a **yuvdns_nlm** function(will be discussed later) is called to perform the block serach operation.

Additionally, it's worth noting that for those border pixels which do not have enough neibor pixels to form a 9x9 search window, we directly ouput its’ origin value. finally every pixels of a frame will be denoised except the 4-pixel width border.


### yuvdns_nlm
function declaration
```c++
uint10 yuvdns_nlm(uint10 Window[9][9],uint14 sigma2, uint14 H2,uint18 invH2)
```
|Params| description|
|:----:|:----|
|Window[9][9]|	search area of the pixel to be denoised |
|sigma2 |squared deviation of gaussian kernel for distance measure|
|H2 |$h^2$|			
|invH2|$\frac{1}{h^2}$|

**Return**

the denoised value of the center pixel in Window[9][9]


### function description

**yuvdns_nlm** performs nlm search in the 9x9 Window which calculates the similarity between each pixel and the center pixel. The output  of yuvdns_nlm is the denosied  pixel in the 9x9 Window. As shown in Fig 2
![alt win_op](./window_op.png )





## Reference
<div id="ref-anchor-1"></div>[1]Buades, A. ,  B. Coll , and  J. M. Morel . "A non-local algorithm for image denoising." Computer Vision and Pattern Recognition, 2005. CVPR 2005. IEEE Computer Society Conference on IEEE, 2005.
