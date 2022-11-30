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

    uint26 n;
    uint13 i = 0,j = 0,count = 0;
    uint4  k,l;

    uint6 sigma = rawdns_reg.sigma;
    uint7 filterpara = rawdns_reg.Filterpara;
    uint13 ksigma  = sigma * filterpara;
    uint26 ksigma2 = (ksigma * ksigma) >> (16 - 8);

    uint12 src_data ,dst_data;

    pixel_loop:for(n=0;n<top_reg.frameHeight * top_reg.frameWidth;n++)
    {
        src_data = src.read();

        if(count == top_reg.frameWidth)
        {
            i++;
            count = 0;
        }

        count++;
        j = n - i * top_reg.frameWidth;

     //rw and process
        if(rawdns_reg.eb)
        {
            //cache move
            reg_refresh_out_loop:for(k = 0; k < 11;k++){
                reg_refresh_inner_loop:for( l = 0; l < 10 ;l++){
                    rawdns_block[k][l] = rawdns_block[k][l+1];
                }
            }

            for(l = 0; l < 10 ;l++){
                rawdns_block[l][10] = rawdns_lines[l][j];
            }

            rawdns_block[10][10] = src_data;

            for(l = 0; l < 10 ;l++){
                rawdns_lines[l][j] = rawdns_block[l+1][10];
            }

            bool nlm_en = (i > 9) && (j > 9);
            dst_data = rawdns_process(rawdns_block, rawdns_reg,ksigma2,i,j,nlm_en);

            #ifdef  DEBUG
                if ((i == ROW_TEST + 5)&&(j == COL_TEST + 5))
                {
                    printf("\t%d\t%d\n",i.to_int(),j.to_int());
                    printf("\t%d\n",src_data.to_int());
                    printf("\t%d\n",rawdns_block[5][5].to_int());
                    printf("\t%d\t%d\t%d\t%d\t%d\t%d\t%d\t%d\t%d\t%d\t%d\n", rawdns_block[0][0].to_int(), rawdns_block[0][1].to_int(), rawdns_block[0][2].to_int(), rawdns_block[0][3].to_int(), rawdns_block[0][4].to_int(), rawdns_block[0][5].to_int(), rawdns_block[0][6].to_int(), rawdns_block[0][7].to_int(), rawdns_block[0][8].to_int(), rawdns_block[0][9].to_int(), rawdns_block[0][10].to_int());
                    printf("\t%d\t%d\t%d\t%d\t%d\t%d\t%d\t%d\t%d\t%d\t%d\n", rawdns_block[1][0].to_int(), rawdns_block[1][1].to_int(), rawdns_block[1][2].to_int(), rawdns_block[1][3].to_int(), rawdns_block[1][4].to_int(), rawdns_block[1][5].to_int(), rawdns_block[1][6].to_int(), rawdns_block[1][7].to_int(), rawdns_block[1][8].to_int(), rawdns_block[1][9].to_int(), rawdns_block[1][10].to_int());
                    printf("\t%d\t%d\t%d\t%d\t%d\t%d\t%d\t%d\t%d\t%d\t%d\n", rawdns_block[2][0].to_int(), rawdns_block[2][1].to_int(), rawdns_block[2][2].to_int(), rawdns_block[2][3].to_int(), rawdns_block[2][4].to_int(), rawdns_block[2][5].to_int(), rawdns_block[2][6].to_int(), rawdns_block[2][7].to_int(), rawdns_block[2][8].to_int(), rawdns_block[2][9].to_int(), rawdns_block[2][10].to_int());
                    printf("\t%d\t%d\t%d\t%d\t%d\t%d\t%d\t%d\t%d\t%d\t%d\n", rawdns_block[3][0].to_int(), rawdns_block[3][1].to_int(), rawdns_block[3][2].to_int(), rawdns_block[3][3].to_int(), rawdns_block[3][4].to_int(), rawdns_block[3][5].to_int(), rawdns_block[3][6].to_int(), rawdns_block[3][7].to_int(), rawdns_block[3][8].to_int(), rawdns_block[3][9].to_int(), rawdns_block[3][10].to_int());
                    printf("\t%d\t%d\t%d\t%d\t%d\t%d\t%d\t%d\t%d\t%d\t%d\n", rawdns_block[4][0].to_int(), rawdns_block[4][1].to_int(), rawdns_block[4][2].to_int(), rawdns_block[4][3].to_int(), rawdns_block[4][4].to_int(), rawdns_block[4][5].to_int(), rawdns_block[4][6].to_int(), rawdns_block[4][7].to_int(), rawdns_block[4][8].to_int(), rawdns_block[4][9].to_int(), rawdns_block[4][10].to_int());
                    printf("\t%d\t%d\t%d\t%d\t%d\t%d\t%d\t%d\t%d\t%d\t%d\n", rawdns_block[5][0].to_int(), rawdns_block[5][1].to_int(), rawdns_block[5][2].to_int(), rawdns_block[5][3].to_int(), rawdns_block[5][4].to_int(), rawdns_block[5][5].to_int(), rawdns_block[5][6].to_int(), rawdns_block[5][7].to_int(), rawdns_block[5][8].to_int(), rawdns_block[5][9].to_int(), rawdns_block[5][10].to_int());
                    printf("\t%d\t%d\t%d\t%d\t%d\t%d\t%d\t%d\t%d\t%d\t%d\n", rawdns_block[6][0].to_int(), rawdns_block[6][1].to_int(), rawdns_block[6][2].to_int(), rawdns_block[6][3].to_int(), rawdns_block[6][4].to_int(), rawdns_block[6][5].to_int(), rawdns_block[6][6].to_int(), rawdns_block[6][7].to_int(), rawdns_block[6][8].to_int(), rawdns_block[6][9].to_int(), rawdns_block[6][10].to_int());
                    printf("\t%d\t%d\t%d\t%d\t%d\t%d\t%d\t%d\t%d\t%d\t%d\n", rawdns_block[7][0].to_int(), rawdns_block[7][1].to_int(), rawdns_block[7][2].to_int(), rawdns_block[7][3].to_int(), rawdns_block[7][4].to_int(), rawdns_block[7][5].to_int(), rawdns_block[7][6].to_int(), rawdns_block[7][7].to_int(), rawdns_block[7][8].to_int(), rawdns_block[7][9].to_int(), rawdns_block[7][10].to_int());
                    printf("\t%d\t%d\t%d\t%d\t%d\t%d\t%d\t%d\t%d\t%d\t%d\n", rawdns_block[8][0].to_int(), rawdns_block[8][1].to_int(), rawdns_block[8][2].to_int(), rawdns_block[8][3].to_int(), rawdns_block[8][4].to_int(), rawdns_block[8][5].to_int(), rawdns_block[8][6].to_int(), rawdns_block[8][7].to_int(), rawdns_block[8][8].to_int(), rawdns_block[8][9].to_int(), rawdns_block[8][10].to_int());
                    printf("\t%d\t%d\t%d\t%d\t%d\t%d\t%d\t%d\t%d\t%d\t%d\n", rawdns_block[9][0].to_int(), rawdns_block[9][1].to_int(), rawdns_block[9][2].to_int(), rawdns_block[9][3].to_int(), rawdns_block[9][4].to_int(), rawdns_block[9][5].to_int(), rawdns_block[9][6].to_int(), rawdns_block[9][7].to_int(), rawdns_block[9][8].to_int(), rawdns_block[9][9].to_int(), rawdns_block[9][10].to_int());
                    printf("\t%d\t%d\t%d\t%d\t%d\t%d\t%d\t%d\t%d\t%d\t%d\n", rawdns_block[10][0].to_int(), rawdns_block[10][1].to_int(), rawdns_block[10][2].to_int(), rawdns_block[10][3].to_int(), rawdns_block[10][4].to_int(), rawdns_block[10][5].to_int(), rawdns_block[10][6].to_int(), rawdns_block[10][7].to_int(), rawdns_block[10][8].to_int(), rawdns_block[10][9].to_int(), rawdns_block[10][10].to_int());
                    printf("\t%d\n",dst_data.to_int());
                    printf("\n\n\n");
                }
            #endif
            if((i > 5)||((i == 5)&&(j > 4)))
            {
                dst.write(dst_data);
            }
        }
        else
        {
            dst_data = src_data;
            dst.write(dst_data);
        }
    }

    //padding process
    if(rawdns_reg.eb)
    {
        padding_loop1:for(k = 0; k < 5 ;k++)
        {

            dst_data = rawdns_lines[4][top_reg.frameWidth - 5 + k];
            dst.write(dst_data);
        }

        padding_loop2:for(k = 0; k < 5 ;k++)
        {

            loop2_inner_loop:for(i = 0;i < top_reg.frameWidth;i++)
            {
                dst_data = rawdns_lines[k + 5][i];
                dst.write(dst_data);
            }
        }
    }
}
