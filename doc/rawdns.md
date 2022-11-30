# Raw Denoise

**The RAWDNS module implements image denoising on the raw domain.The the NLMs(Non-local Means) algorithm based on block matching is used for denoising.**

## Parameter

```c++
typedef struct{
    uint6   sigma;    //range[0-63]
    uint1   eb;       //{0,1}
    uint7   Filterpara; //range[0-127]
    uint12  invksigma2; //1/ksigma2 <<12
}rawdns_register;
```
Param ```sigma``` and ```Filterpara``` jointly control the intensity of the filtering.Param ```invksigma2``` is the quantized reciprocal of the product of sigma and Filterpara。
## Input  & Ouput
```c++
typedef stream_u12 Stream_t;//input raw data
typedef stream_u12 Stream_t;//output rgb data
```
## Resources
The algorithm uses a 11x11 window to complete the denoising process, and the storage resources are listed as follows
```c++
uint12 rawdns_lines[10][8192];//10x8192 sram
uint12 rawdns_block[11][11];// 11x11 registers
```
## Algorithm
Function ```rawdns_process``` describes the block matching based NLM algorithm, and the main calculation process is the following loop.
```c++
for(k=1;k<=9;k+=2){
    for(l=1;l<=9;l+=2){
        if((k!=5) || (l!=5))
        {
            eur_distance = Cal_Eur_Distance(rawdns_block,k,l);
            diff = rawdns_max(eur_distance, sigma2);
            weight = Cal_weight(diff,rawdns_reg ,ksigma2);
            if(weight > max_weight)
            {
                max_weight = weight;
            }
            total_weight += weight;
            total_value += weight * rawdns_block[k][l];
           }
        }
    }
```
The ```Cal_Eur_Distance``` function calculates the Euclidean distance between different blocks, and ```cal_weight``` calculates the Gaussian weights of different pixels.Finally, according to the calculation result, the pixel value after denoising(usually center pixel of the window) is output.
```c++
if(total_weight == 0)
    return rawdns_block[5][5];
else
    return rawdns_clip(total_value/total_weight);

```