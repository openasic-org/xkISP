# WBC
## parameters
```C++
typedef struct{
    bool    m_nEb;
    uint15  m_nR;
    uint15  m_nGr;
    uint15  m_nGb;
    uint15  m_nB;
} wbc_register;
```
1. `m_nEb`

wbc module enable

2. `m_nR`, `m_nGr`, `m_nGb`, `m_nB`

the gain values of R, Gr, Gb, B

## code manual
###  code
select the pixel bayer channel according to the bayerpattern,
the get the gain value according to the bayerpattern
```C++
uint2  bayerPattern = (((y & 1) << 1) + (x & 1))^top_reg.imgPattern;

if (bayerPattern == 0) {
  gain_w = wbc_reg.m_nR;
} else if (bayerPattern == 1) {
  gain_w = wbc_reg.m_nGr;
} else if (bayerPattern == 2) {
  gain_w = wbc_reg.m_nGb;
} else {
  gain_w = wbc_reg.m_nB;
}
```

calculate the pixel value according to the gain value
```C++
dst_val = (((src_t - top_reg.blc) * gain_w + 2048) >> 12) + top_reg.blc;
dst_t = wbc_clip(dst_val,0,4095);
```
