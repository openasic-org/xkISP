#include "ee.h"

inline uint12 ee_clip(int15 ee_result)
{
   if(ee_result > 4095)
      return 4095;
   else if(ee_result < 0)
      return 0;
   else
      return (uint12)ee_result;
}

inline uint12 ee_clip(int25 ee_result)
{
   if(ee_result > 4095)
      return 4095;
   else if(ee_result < 0)
      return 0;
   else
      return (uint12)ee_result;
}


uint36 eeprocess(uint36 ee_block[5][5], ee_register& ee_top)
{
    uint1  eb = ee_top.eb;
    uint4  coeff = ee_top.coeff;
    const static uint5 guass_55[5][5] = {1,2,4,2,1,2,4,8,4,2,4,8,16,8,4,2,4,8,4,2,1,2,4,2,1};
    int23  sharpen_threhold_r = 0,sharpen_threhold_g = 0,sharpen_threhold_b = 0;
    int13  rblock[5][5],gblock[5][5],bblock[5][5];

    int14  feq_l[4] = {0};
    int14  feq_h[4] = {0};
    int14  result_v[5] = {0};

    int15  low_feq_r = 0,low_feq_g = 0,low_feq_b = 0;
    int15  high_feq_r = 0,high_feq_g = 0,high_feq_b = 0;
    int15  temp_r = 0,temp_g = 0,temp_b = 0;
    int24  r_middle = 0,g_middle = 0,b_middle = 0;
    int25  r_result = 0,g_result = 0, b_result = 0;

    uint3 k,l;
    uint36 result;
    ee_pixel_t center;

   //prepare
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

    sharpen_threhold_r = sharpen_threhold_r >> 10;
    sharpen_threhold_g = sharpen_threhold_g >> 10;
    sharpen_threhold_b = sharpen_threhold_b >> 10;

    center.r = ee_block[2][2] >> 24;
    center.g = gblock[2][2];
    center.b = ee_block[2][2] & 0xfff;

    //process r
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

    }

    for(k = 0; k < 4; k++) {

        feq_l[k] = result_v[k]/2 + result_v[k+1]/2;
        feq_h[k] = result_v[k]/2 - result_v[k+1]/2;

        if(feq_h[k] > sharpen_threhold_r)
        {
            feq_h[k] -= sharpen_threhold_r;
        }
        else if(feq_h[k] < -sharpen_threhold_r)
        {
            feq_h[k] += sharpen_threhold_r;
        }
        else
        {
            feq_h[k] = 0;
        }
    }

    temp_r = feq_l[1]/2 + feq_h[1]/2 + feq_l[2]/2 + feq_h[2]/2;


    //process g
    for(k = 0; k < 5; k++) {
        for (l = 0; l < 4; l++) {

            feq_l[l] = gblock[l][k]/2 + gblock[l + 1][k]/2;
            feq_h[l] = gblock[l][k]/2 - gblock[l + 1][k]/2;

            if(feq_h[l] > sharpen_threhold_g)
            {
                feq_h[l] -= sharpen_threhold_g;
            }
            else if(feq_h[l] < - sharpen_threhold_g)
            {
                feq_h[l] += sharpen_threhold_g;
            }
            else
            {
                feq_h[l] = 0;
            }
        }

        temp_g = feq_l[1]/2 + feq_h[1]/2 + feq_l[2]/2 + feq_h[2]/2;
        result_v[k] = ee_clip(temp_g);

    }

    for(k = 0; k < 4; k++) {

        feq_l[k] = result_v[k]/2 + result_v[k+1]/2;
        feq_h[k] = result_v[k]/2 - result_v[k+1]/2;

        if(feq_h[k] > sharpen_threhold_g)
        {
            feq_h[k] -= sharpen_threhold_g;
        }
        else if(feq_h[k] < -sharpen_threhold_g)
        {
            feq_h[k] += sharpen_threhold_g;
        }
        else
        {
            feq_h[k] = 0;
        }
    }

    temp_g = feq_l[1]/2 + feq_h[1]/2 + feq_l[2]/2 + feq_h[2]/2;



    //process b
    for(k = 0; k < 5; k++) {
        for (l = 0; l < 4; l++) {

            feq_l[l] = bblock[l][k]/2 + bblock[l + 1][k]/2;
            feq_h[l] = bblock[l][k]/2 - bblock[l + 1][k]/2;

            if(feq_h[l] > sharpen_threhold_b)
            {
                feq_h[l] -= sharpen_threhold_b;
            }
            else if(feq_h[l] < - sharpen_threhold_b)
            {
                feq_h[l] += sharpen_threhold_b;
            }
            else
            {
                feq_h[l] = 0;
            }
        }

        temp_b = feq_l[1]/2 + feq_h[1]/2 + feq_l[2]/2 + feq_h[2]/2;
        result_v[k] = ee_clip(temp_b);

    }

    for(k = 0; k < 4; k++) {

        feq_l[k] = result_v[k]/2 + result_v[k+1]/2;
        feq_h[k] = result_v[k]/2 - result_v[k+1]/2;

        if(feq_h[k] > sharpen_threhold_b)
        {
            feq_h[k] -= sharpen_threhold_b;
        }
        else if(feq_h[k] < -sharpen_threhold_b)
        {
            feq_h[k] += sharpen_threhold_b;
        }
        else
        {
            feq_h[k] = 0;
        }
    }

    temp_b = feq_l[1]/2 + feq_h[1]/2 + feq_l[2]/2 + feq_h[2]/2;

    low_feq_r =  ee_clip(temp_r);
    low_feq_g =  ee_clip(temp_g);
    low_feq_b =  ee_clip(temp_b);
    high_feq_r = (int15)rblock[2][2] - low_feq_r;
    high_feq_g = (int15)gblock[2][2] - low_feq_g;
    high_feq_b = (int15)bblock[2][2] - low_feq_b;
    r_middle = high_feq_r * ee_top.coeff + 8;
    g_middle = high_feq_g * ee_top.coeff + 8;
    b_middle = high_feq_b * ee_top.coeff + 8;
    r_result = (r_middle >> 4) + low_feq_r;
    g_result = (g_middle >> 4) + low_feq_g;
    b_result = (b_middle >> 4) + low_feq_b;
    center.r = ee_clip(r_result);
    center.g = ee_clip(g_result);
    center.b = ee_clip(b_result);
    result = (uint36)(center.r) << 24 | (uint36)(center.g) << 12 |(uint36)(center.b);
    return result;
}


void edgeenhancement(top_register& isp_top, ee_register& ee_top, stream_u36& src, stream_u36& dst)
{
    uint36 src_in,dst_out;
    uint36 ee_block[5][5];
    uint36 ee_lines[4][8192];
    uint13 i = 0,j = 0,count = 0;
    uint3  k,l;


    uint26 n;
    single_loop:for(n = 0;n < isp_top.frameHeight * isp_top.frameWidth;n++){
        if(count == isp_top.frameWidth)
        {
            count = 0;
            i++;
        }

        count++;
        j = n - i * isp_top.frameWidth;

        src_in = src.read();

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
        }
        else
        {
            dst_out = src_in;
            dst.write(dst_out);
        }
    }

   if(ee_top.eb)
   {
       padding_loop_1:for(k = 0;k < 2;k++){
           dst_out = ee_lines[1][isp_top.frameWidth - 2 + k];
           dst.write(dst_out);
       }

       padding_loop_2:for(k = 0;k < 2;k++){
           padding_loop_3:for(i = 0;i < isp_top.frameWidth;i++){
               dst.write(ee_lines[k+2][i]);
           }
       }
   }
}
