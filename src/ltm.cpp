#include "ltm.h"
#include <assert.h>
#define LTM_BIT_DEPTH    14
#define LTM_Max_Value    (1 << LTM_BIT_DEPTH) - 1


uint16 ltm_abs(uint16 a, uint16 b){
    uint16 dif;
    if(a > b)
        dif = a-b;
    else
        dif = b-a;
    return dif;
}

uint14 ltm_clip(uint16 a,uint16 upper,uint16 lower) {
    if (a < lower)
        a = lower;
    else if (a > upper)
        a = upper;
    return (uint14)a;
}


void bilaterS(ltm_register ltm_reg, uint16 rWindow[9][9],uint16 gWindow[9][9],uint16 bWindow[9][9],uint14 &r_dst,uint14 &g_dst,uint14 &b_dst){
    uint16 ratio=ltm_reg.ratio;
    uint16 contrast=ltm_reg.contrast;
    uint32 u_lWindow[9][9];
    uint32 u_logWindow[9][9];
    uint32 biWeight[9][9];
    uint32 bisum=0;
    uint19 wsum=0;
    int32 l_center=0;
    int32 logl_c=0;
    
    uint32 pos_kerTab[9][9] = {{0, 0, 0,  0,   0,   0,   0,  0, 0},
                               {0, 0, 2,  14,  26,  14,  2,  0, 0},
                               {0, 2, 45, 246, 432, 246, 45, 2, 0},
                               {0, 14,246,1331,2335,1331,246,14,0},
                               {0, 26,432,2335,4096,2335,432,26,0},
                               {0, 14,246,1331,2335,1331,246,14,0},
                               {0, 2, 45, 246, 432, 246, 45, 2, 0},
                               {0, 0, 2,  14,  26,  14,  2,  0, 0},
                               {0, 0, 0,  0,   0,   0,   0,  0, 0}}; 
                        
                       /*
    uint32_t pos_kerTab[9][9]={{0, 0, 0,  0,   0,   0,   0,  0, 0},
                               {0, 0, 0,  0,   0,   0,   0,  0, 0},
                               {0, 0, 0,  0,   0,   0,   0,  0, 0},
                               {0, 0, 0,  1,   45,  1,   0,  0, 0},
                               {0, 0, 0,  45,  4096,45,  0,  0, 0},
                               {0, 0, 0,  1,   45,  1,   0,  0, 0},
                               {0, 0, 0,  0,   0,   0,   0,  0, 0},
                               {0, 0, 0,  0,   0,   0,   0,  0, 0},
                               {0, 0, 0,  0,   0,   0,   0,  0, 0}};
                               */
    biS_loop1:for(uint4 i=0;i<9;i++){
        biS_loop2:for(uint4 j=0;j<9;j++){
            u_lWindow[i][j]=(rWindow[i][j]*84+gWindow[i][j]*168+bWindow[i][j]*4)>>8;
            u_logWindow[i][j]=log10tab[u_lWindow[i][j]];
        }
    }
    l_center=u_lWindow[4][4];
    biS_loop3:for(uint4 i=0;i<9;i++){
        biS_loop4:for(uint4 j=0;j<9;j++){
            uint32 abs_r=ltm_abs(u_logWindow[i][j],u_logWindow[4][4]);
            biWeight[i][j]=(exptab[abs_r]*pos_kerTab[i][j]+2048)>>12;
            bisum+=biWeight[i][j]*u_logWindow[i][j];
            wsum+=biWeight[i][j];
        }
    }
    uint32 baselayer=(bisum/wsum);
    int32 detaillayer=(int32)u_logWindow[4][4]-baselayer;
    int32 composelayer=((baselayer*contrast+2048)>>12)+detaillayer;
    uint16 u_complayer=exp10tab[composelayer];
    
    uint14 r_tmp=u_complayer*rWindow[4][4]/((l_center>(int32)1)?l_center:(int32)1);
    uint14 g_tmp=u_complayer*gWindow[4][4]/((l_center>(int32)1)?l_center:(int32)1);
    uint14 b_tmp=u_complayer*bWindow[4][4]/((l_center>(int32)1)?l_center:(int32)1);
    
    r_dst=ltm_clip((ratio*r_tmp+4)>>3,LTM_Max_Value,0);
    g_dst=ltm_clip((ratio*g_tmp+4)>>3,LTM_Max_Value,0);
    b_dst=ltm_clip((ratio*b_tmp+4)>>3,LTM_Max_Value,0);
}

void ltm(top_register top_reg, ltm_register ltm_reg, stream_u42 &srcData, stream_u42 &dstData){
    uint14 r_src;
    uint14 g_src;
    uint14 b_src;
    uint14 r_dst;
    uint14 g_dst;
    uint14 b_dst;
    uint42 src42;
    uint42 dst42;
    uint16 rWindow[9][9];
    uint16 gWindow[9][9];
    uint16 bWindow[9][9];
    uint16 rlineBuf[8][4096];
    uint16 glineBuf[8][4096];
    uint16 blineBuf[8][4096];
    uint32 frameWidth=top_reg.frameWidth;
    uint32 frameHeight=top_reg.frameHeight;


ltm_row:for(uint13 row = 0;row < frameHeight; row++){
    ltm_col:for(uint13 col = 0 ;col < frameWidth; col++){ 
    
            src42=srcData.read();
            r_src=src42>>28;
            g_src=(src42>>14)&0x3fff;
            b_src=src42&0x3fff;
            //printf("red:%d,green:%d,blue:%d\t",r_src.to_int(),g_src.to_int(),b_src.to_int());
           // printf("r_src:%u,g_src:%u，b_src:%u\n",(uint14)r_src,(uint14)g_src,(uint14)b_src);
            if(ltm_reg.m_nEb == 1){
                out_window_loop:for(uint4 i = 0; i < 9; i++){
                    in_window_loop:for(uint4 j = 0; j < 8; j++){                           
                        rWindow[i][j] = rWindow[i][j+1];
                        gWindow[i][j] = gWindow[i][j+1];
                        bWindow[i][j] = bWindow[i][j+1];
                    }
                }

                ltm_window_read:for(uint4 i = 0; i < 8; i++){
                    rWindow[i][8] = rlineBuf[i][col];
                    gWindow[i][8] = glineBuf[i][col];
                    bWindow[i][8] = blineBuf[i][col];
                }
                    rWindow[8][8] = r_src;
                    gWindow[8][8] = g_src;
                    bWindow[8][8] = b_src;

                ltm_lines_read:for(uint4 i = 0; i < 7; i++){
                    rlineBuf[i][col] = rWindow[i+1][8];
                    glineBuf[i][col] = gWindow[i+1][8];
                    blineBuf[i][col] = bWindow[i+1][8];
                }
                    rlineBuf[7][col] = r_src;
                    glineBuf[7][col] = g_src;     
                    blineBuf[7][col] = b_src;     

                ltm:if((row > 7) && (col > 7)){
                    bilaterS(ltm_reg,rWindow,gWindow,bWindow,r_dst,g_dst,b_dst);
                }
                else{
                    r_dst = rWindow[4][4];
                    g_dst = gWindow[4][4];
                    b_dst = bWindow[4][4];
                }
                if((row > 4) || ((row == 4) && (col > 3))){
                    #ifdef vivado
                    dst42(41,28)=r_dst;
                    dst42(27,14)=g_dst;
                    dst42(13,0)= b_dst;
                    #endif
                    #ifdef catapult
                    dst42.set_slc(28,r_dst);
                    dst42.set_slc(14,g_dst);
                    dst42.set_slc(0,b_dst);
                    #endif
                    dstData.write(dst42);
                }

            }
            else{
                r_dst = r_src;
                g_dst = g_src;
                b_dst = b_src;
                #ifdef vivado
                dst42(41,28)=r_dst;
                dst42(27,14)=g_dst;
                dst42(13,0)= b_dst;
                #endif
                #ifdef catapult
                dst42.set_slc(28,r_dst);
                dst42.set_slc(14,g_dst);
                dst42.set_slc(0,b_dst);
                #endif
                dstData.write(dst42);
            }  
        }
    }


if(ltm_reg.m_nEb == 1){
    addon_loop_1: for (uint3 i = 0; i < 4; i++){
        r_dst = rWindow[4][i+5];
        g_dst = gWindow[4][i+5];
        b_dst = bWindow[4][i+5];
        #ifdef vivado
        dst42(41,28)=r_dst;
        dst42(27,14)=g_dst;
        dst42(13,0)= b_dst;
        #endif
        #ifdef catapult
        dst42.set_slc(28,r_dst);
        dst42.set_slc(14,g_dst);
        dst42.set_slc(0,b_dst);
        #endif
        dstData.write(dst42);
    }
    addon_loop_2: for (uint3 i = 0; i < 4; i++){
        for(uint13 j = 0; j < frameWidth; j++){
            r_dst = rlineBuf[i+4][j];
            g_dst = glineBuf[i+4][j];
            b_dst = blineBuf[i+4][j];
            #ifdef vivado
            dst42(41,28)=r_dst;
            dst42(27,14)=g_dst;
            dst42(13,0)= b_dst;
            #endif
            #ifdef catapult
            dst42.set_slc(28,r_dst);
            dst42.set_slc(14,g_dst);
            dst42.set_slc(0,b_dst);
            #endif
            dstData.write(dst42);
        }
    }
}
}







