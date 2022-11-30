# AWB
## parameters
```C++
typedef struct {
    bool m_nEb;
    uint15 r_gain;
    uint15 g_gain;
    uint15 b_gain;
    uint5 coeff;
}awb_register;
```
1. `m_nEb`

awb module enable

2. `r_gain`, `g_gain`, `b_gain`

the output of r,g,b gain values

3. `coeff`

mean coefficient

## code manual
###  code
calculate the pixel sum for the r, g, b channel according to the bayerpattern
```C++
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
```

calculate the pixel average for the r, g, b channel
```C++
r_avg = (r_total * awb_reg.coeff) >> 19;
g_avg = (g_total * awb_reg.coeff) >> 20;
b_avg = (b_total * awb_reg.coeff) >> 19;
```

calculate the `r_gain`, `g_gain`, `b_gain`
```C++
awb_reg.r_gain = 16384 * g_avg / r_avg;
awb_reg.g_gain = 16384;
awb_reg.b_gain = 16384 * g_avg / b_avg;
```
