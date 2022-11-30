# dgain.md
## parameter

```C++
typedef struct{
    bool    m_nEb;
    uint9   m_nBlcR;
    uint9   m_nBlcGr;
    uint9   m_nBlcGb;
    uint9   m_nBlcB;
    uint20  m_nR;
    uint20  m_nGr;
    uint20  m_nGb;
    uint20  m_nB;
} dgain_register;
```
1. `m_nEb`

    dgain module enable
2. `m_nBlcR`, `m_nBlcGr`, `m_nBlcGb`, `m_nBlcB`

    R, Gr, Gb, B channel black level correction values
3. `m_nR`, `m_nGr`, `m_nGb`, `m_nB`
    Bayer array R, Gr, Gb,B channel gain values

## dgain code manual
`src_t = src.read` get the input values of input pixels. if the `m_nEb == 1`, calculate the bayerPattern, for example, if the `top_reg.imgPattern = 0`, so, bayerPattern = 0, channel is r channel; bayerPattern = 1, channel is gr channel; bayerPattern = 10, channel is gb channel; bayerPattern = 11, channel is b channel. Choose the gain_w channel and blc_w channel according to the bayerPattern, the code is shown below:
```C++
if (bayerPattern == 0) {
    blc_w = dgain_reg.m_nBlcR;
    gain_w = dgain_reg.m_nR;
} else if (bayerPattern == 1) {
    blc_w = dgain_reg.m_nBlcGr;
    gain_w = dgain_reg.m_nGr;
} else if (bayerPattern == 2) {
    blc_w = dgain_reg.m_nBlcGb;
    gain_w = dgain_reg.m_nGb;
} else {
    blc_w = dgain_reg.m_nBlcB;
    gain_w = dgain_reg.m_nB;
}
```
Finally the output pixel values are calculated from the input values, gain values and black level correction values.
the code is shown below:
```C++
dst_tmp = (src_t - blc_w) * gain_w + GAIN_HALF_VALUE;
dst_val = (dst_tmp >> GAIN_BITS) + top_reg.blc;
dst_t = dgain_clip(dst_val,0,4095);
```

if `m_nEb = 0`, directly output of input pixel values