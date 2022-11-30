#include "./rawdns.h"

uint8 Cal_weight(uint30 diff,rawdns_register& rawdns_reg,uint26 ksigma2)
{
    const static uint8 weight_1[10] = {244,220,197,180,163,148,133,120,111,99};
    const static uint8 weight_2[18] = {85,70,57,47,39,32,26,21,18,15,12,10,8,7,6,3,1,0};

    uint8 weight;
    uint40 weight_temp;
    
    if(ksigma2 == 0)
    {
        weight = 0;
    }
    else if (diff > ksigma2)
    {
        diff = 5 * diff;
        weight_temp = ((diff * rawdns_reg.invksigma2) >> 20) - 5;

        if(diff < 6 * ksigma2)
            weight = weight_2[0];
        else if(diff >= 22 * ksigma2)
            weight = weight_2[17];
        else
            weight = weight_2[weight_temp];
    }
    else
    {
        diff = 10 * diff;
        weight_temp = (diff * rawdns_reg.invksigma2) >> 20;

        if(diff < ksigma2)
            weight = weight_1[0];
        else if(diff >= 9 * ksigma2)
            weight = weight_1[9];
        else
            weight = weight_1[weight_temp];
    }
    return weight;
}

uint30 Cal_Eur_Distance(uint12 rawdns_block[11][11], uint4 cur_y, uint4 cur_x)
{
    uint24 temp_block[3][3];
    uint12 temp;
    uint30 Eur_distance = 0;
    int4 k,l;

    for(k = -1; k <= 1;k++){
        for(l = -1;l <= 1;l++){
            temp = rawdns_abs(rawdns_block[5 + k][5 + l] , rawdns_block[cur_y + k][cur_x + l]);
            temp_block[k + 1][l + 1] = temp ;
        }
    }

    for(k = 0; k <= 2;k++){
        for(l = 0;l <= 2;l++){
            temp_block[k][l] = temp_block[k][l] * temp_block[k][l];
            Eur_distance = Eur_distance + temp_block[k][l];
        }
    }
    return Eur_distance;
}

uint12 rawdns_process(uint12 rawdns_block[11][11],rawdns_register& rawdns_reg, uint26 ksigma2,uint13 row,uint13 col,bool nlm_en)
{
    uint30 eur_distance;
    int30  diff;
    uint13 total_weight = 0;
    uint25 total_value = 0;
    uint4 k,l;
    uint6 sigma = rawdns_reg.sigma;
    uint14 sigma2 = 2 * sigma * sigma;
    uint8 weight,max_weight = 0;
    uint25 total_q;

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

    total_weight += max_weight;
    total_value += max_weight * rawdns_block[5][5];

    if(total_weight == 0 || nlm_en == 0)
        return rawdns_block[5][5];
    else
    #ifdef catapult
        ac_math::ac_div(total_value, total_weight, total_q);
    #endif
    #ifdef vivado
        total_q = total_value / total_weight;
    #endif    
        return rawdns_clip(total_q);
}

void isp_rawdns(top_register& top_reg, rawdns_register& rawdns_reg, stream_u12& src, stream_u12& dst)
{
    uint12 rawdns_lines[10][8192];
    uint12 rawdns_block[11][11];


    uint6 sigma = rawdns_reg.sigma;
    uint7 filterpara = rawdns_reg.Filterpara;
    uint13 ksigma  = sigma * filterpara;
    uint26 ksigma2 = (ksigma * ksigma) >> (16 - 8);

    uint12 src_data ,dst_data;
    rawdns_row:for(uint13 row=0;row<top_reg.frameHeight;row++){
    	rwadns_col:for(uint13 col=0;col<top_reg.frameWidth;col++){
    		src_data = src.read();
    		if(rawdns_reg.eb){
            //cache move
                reg_refresh_out_loop:for(uint4 k = 0; k < 11;k++){
                    reg_refresh_inner_loop:for(uint4  l = 0; l < 10 ;l++){
                        rawdns_block[k][l] = rawdns_block[k][l+1];
                    }
                }

                isp_rawdns_label0:for(uint4 l = 0; l < 10 ;l++){
                    rawdns_block[l][10] = rawdns_lines[l][col];
                }

                rawdns_block[10][10] = src_data;

                isp_rawdns_label1:for(uint4 l = 0; l < 10 ;l++){
                    rawdns_lines[l][col] = rawdns_block[l+1][10];
                }

                bool nlm_en = (row > 9) && (col > 9);
                dst_data = rawdns_process(rawdns_block, rawdns_reg,ksigma2,row,col,nlm_en);
                if((row > 5)||((row == 5)&&(col > 4))){
                    dst.write(dst_data);
                }
            }
            else{
                dst_data = src_data;
                dst.write(dst_data);
            }
    	}

    }


    //padding process
    if(rawdns_reg.eb)
    {
        padding_loop1:for(uint3 k = 0; k < 5 ;k++)
        {

            dst_data = rawdns_block[5][k+6];//rawdns_lines[4][top_reg.frameWidth - 5 + k];
            dst.write(dst_data);
        }

        padding_loop2:for(uint3 k = 0; k < 5 ;k++)
        {

            loop2_inner_loop:for(uint13 i = 0;i < top_reg.frameWidth;i++)
            {
                dst_data = rawdns_lines[k + 5][i];
                dst.write(dst_data);
            }
        }
    }
}
