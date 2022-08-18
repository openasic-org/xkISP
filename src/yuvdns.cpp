#include "yuvdns.h"
#include <assert.h>
#define YUVDNS_BIT_DEPTH    10
#define YUVDNS_Max_Value    (1 << YUVDNS_BIT_DEPTH) - 1

uint32 yuvdns_weight2_clip(uint32 count){
	if(count > 15)
		count = 15;
	else if(count < 0)
		count = 0;
	return (uint32)count;
}

uint10 yuvdns_abs(uint11 a, uint10 b){
	uint10 dif;
	if(a > b)
		dif = a-b;
	else
		dif = b-a;
	return dif;
}

uint10 yuvdns_clip(uint10 a,int upper,int lower) {
    if (a < lower)
        a = lower;
    else if (a > upper)
        a = upper;
    return (uint10)a;
}


uint10 yuvdns_nlm(uint10 Window[9][9],uint14 sigma2, uint14 H2,uint18 invH2){
    uint8  weight_1[8]={255,226,200,176,156,138,122,108};
    uint8  weight_2[16]={88,72,59,48,39,32,26,21,17,14,11,9,7,5,2,0};

    uint21 diff;
    uint22 diff_1;
    uint22 diff_2;
    uint22 diff_3;
    uint28 diff_tmp; 
    uint8 weight = 0, maxweight = 0; 
    uint14 totalweight =0; 
    uint25 totalvalue = 0;
    nlm_row_loop:for (uint4 j = 1; j < 8; j++){
        nlm_col_loop:for (uint4 i = 1; i < 8; i++) {
            if (i != 4 || j != 4) {
                uint10 dis_1 = 0;
                uint20 dis_11 = 0;
                dis_1 = yuvdns_abs(Window[j-1][i-1],Window[3][3]);
                dis_11 =  dis_1 * dis_1;

                uint10 dis_2 = 0;
                uint20 dis_22 = 0;
                dis_2 = yuvdns_abs(Window[j-1][i],Window[3][4]);
                dis_22 =  dis_2 * dis_2;

                uint10 dis_3 = 0;
                uint20 dis_33 = 0;
                dis_3 = yuvdns_abs(Window[j-1][i+1],Window[3][5]);
                dis_33 = dis_3 * dis_3;

                uint10 dis_4 = 0;
                uint20 dis_44 = 0;
                dis_4 = yuvdns_abs(Window[j][i-1],Window[4][3]);
                dis_44 = dis_4 * dis_4;

                uint10 dis_5 = 0;
                uint20 dis_55 = 0;
                dis_5 = yuvdns_abs(Window[j][i],Window[4][4]);
                dis_55 = dis_5 * dis_5;

                uint10 dis_6 = 0;
                uint20 dis_66 = 0;
                dis_6 = yuvdns_abs(Window[j][i+1],Window[4][5]);
                dis_66 = dis_6 * dis_6;

                uint10 dis_7 = 0;
                uint20 dis_77 = 0;
                dis_7 = yuvdns_abs(Window[j+1][i-1],Window[5][3]);
                dis_77 = dis_7 * dis_7;

                uint10 dis_8 = 0;
                uint20 dis_88 = 0;
                dis_8 = yuvdns_abs(Window[j+1][i],Window[5][4]);
                dis_88 = dis_8 * dis_8;

                uint10 dis_9 = 0;
                uint20 dis_99 = 0;
                dis_9 = yuvdns_abs(Window[j+1][i+1],Window[5][5]);
                dis_99 = dis_9 * dis_9;

                diff_1 = dis_11 + dis_22 + dis_33;
                diff_2 = dis_44 + dis_55 + dis_66;
                diff_3 = dis_77 + dis_88 + dis_99;

                diff = (diff_1 + diff_2 + diff_3) >> 3;

                if(diff < 2 * sigma2){
                	diff = 0;
                }else{
                	diff = diff - 2 * sigma2;
                }

                uint32 count = 0;
                if(H2 == 0){
                    weight = 0;
                }                   
                else if(diff <= H2){
                    diff_tmp = 7 * diff;
                    count = (diff_tmp * invH2)>>14;
                    weight = weight_1[count];
                }
                else{
                    diff_tmp = 5 * diff;
                    count = (diff_tmp * invH2)>>14;
                    count = yuvdns_weight2_clip((count -5));
                    weight = weight_2[count];
                }

                if(weight > maxweight){
                    maxweight = weight;
                }
                totalweight = totalweight + weight;
                totalvalue = totalvalue + Window[j][i] * weight;
           }
        }
    }
    totalweight =  totalweight + maxweight;
    totalvalue = totalvalue + Window[4][4] * maxweight;

    if(totalweight==0)
        return Window[4][4];
    else
        return yuvdns_clip(totalvalue / totalweight, YUVDNS_Max_Value, 0);
}

void yuv444dns(top_register top_reg, yuvdns_register yuvdns_reg, stream_u10 &src_y, stream_u10 &src_u, stream_u10 &src_v, stream_u10 &dst_y, stream_u10 &dst_u, stream_u10 &dst_v){
    uint10 y_t;
    uint10 u_t;
    uint10 v_t;
    uint10 y_dst_t;
    uint10 u_dst_t;
    uint10 v_dst_t;
    uint10 yWindow[9][9];
    uint10 uWindow[9][9];
    uint10 vWindow[9][9];
    uint10 ylineBuf[8][8192];
    uint10 ulineBuf[8][8192];
    uint10 vlineBuf[8][8192];


    yuvdns_row:for(uint13 row = 0;row < top_reg.frameHeight; row++){
        yuvdns_col:for(uint13 col = 0 ;col < top_reg.frameWidth; col++){      
            y_t = src_y.read();
            u_t = src_u.read();
            v_t = src_v.read();
            if(yuvdns_reg.eb == 1){
                out_window_loop:for(uint4 i = 0; i < 9; i++){
                    in_window_loop:for(uint4 j = 0; j < 8; j++){                           
                        yWindow[i][j] = yWindow[i][j+1];
                        uWindow[i][j] = uWindow[i][j+1];
                        vWindow[i][j] = vWindow[i][j+1];
                    }
                }

                window_read:for(uint4 i = 0; i < 8; i++){
                    yWindow[i][8] = ylineBuf[i][col];
                    uWindow[i][8] = ulineBuf[i][col];
                    vWindow[i][8] = vlineBuf[i][col];
                }
                    yWindow[8][8] = y_t;
                    uWindow[8][8] = u_t;
                    vWindow[8][8] = v_t;

                lines_read:for(uint4 i = 0; i < 7; i++){
                    ylineBuf[i][col] = yWindow[i+1][8];
                    ulineBuf[i][col] = uWindow[i+1][8];
                    vlineBuf[i][col] = vWindow[i+1][8];
                }
                    ylineBuf[7][col] = y_t;
                    ulineBuf[7][col] = u_t;     
                    vlineBuf[7][col] = v_t;     

                yuvdns:if((row > 7) && (col > 7)){
                    y_dst_t = yuvdns_nlm(yWindow,yuvdns_reg.ysigma2,yuvdns_reg.yH2,yuvdns_reg.yinvH2);
                    u_dst_t = yuvdns_nlm(uWindow,yuvdns_reg.uvsigma2,yuvdns_reg.uvH2,yuvdns_reg.uvinvH2);
                    v_dst_t = yuvdns_nlm(vWindow,yuvdns_reg.uvsigma2,yuvdns_reg.uvH2,yuvdns_reg.uvinvH2);
                }
                else{
                    y_dst_t = yWindow[4][4];
                    u_dst_t = uWindow[4][4];
                    v_dst_t = vWindow[4][4];
                }
            }
            else{
                y_dst_t = y_t;
                u_dst_t = u_t;
                v_dst_t = v_t;
            }

            if((row > 4) || ((row == 4) && (col > 3))){
                dst_y.write(y_dst_t);
                dst_u.write(u_dst_t);
                dst_v.write(v_dst_t);
            }
        }
    }

    addon_loop_1: for (uint3 i = 0; i < 4; i++){
        y_dst_t = yWindow[4][i+5];
        u_dst_t = uWindow[4][i+5];
        v_dst_t = vWindow[4][i+5];
        dst_y.write(y_dst_t);
        dst_u.write(u_dst_t);
        dst_v.write(v_dst_t);
    }
    addon_loop_2: for (uint3 i = 0; i < 4; i++){
        for(uint13 j = 0; j < top_reg.frameWidth; j++){
            y_dst_t = ylineBuf[i+4][j];
            u_dst_t = ulineBuf[i+4][j];
            v_dst_t = vlineBuf[i+4][j];
            dst_y.write(y_dst_t);
            dst_u.write(u_dst_t);
            dst_v.write(v_dst_t);
        }
    }
}

