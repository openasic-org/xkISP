#include "dehaze.h"




#define DEHAZE_BIT_DEPTH    14
#define DEHAZE_Max_Value    ((1 << DEHAZE_BIT_DEPTH) - 1)
#define DEHAZE_Half_Value   (1 << (DEHAZE_BIT_DEPTH - 1))



uint32 dehaze_abs(uint32 a, uint32 b) {
    return a > b ? a - b : b - a;
}

uint32 dehaze_clip(uint32 count, uint32 upper, uint32 lower ){
    if (count > upper) {
        count = upper;
    }
    else if (count < lower) {
        count = lower;
    }
    return count;
}

void gf_rec_core(dehaze_register dehaze_reg,uint16 atm[3],uint16 rWindow[GF_SIZE][GF_SIZE],uint16 gWindow[GF_SIZE][GF_SIZE],uint16 bWindow[GF_SIZE][GF_SIZE],uint16 dcWindow[GF_SIZE][GF_SIZE],uint14& r_dst,uint14& g_dst,uint14& b_dst){
    uint16 iWindow[GF_SIZE][GF_SIZE];
    //get gray Window from rgb Widnow

    for(uint8 i=0;i<GF_SIZE;i++){
        for(uint8 j=0;j<GF_SIZE;j++){
            iWindow[i][j]=(rWindow[i][j]+gWindow[i][j]+bWindow[i][j])/3;
        }
    }
    //get coarse t Window from dc Window
    uint16 tWindow[GF_SIZE][GF_SIZE];
    for(uint8 i=0;i<GF_SIZE;i++){
        for(uint8 j=0;j<GF_SIZE;j++){
            tWindow[i][j]=DEHAZE_Max_Value-((dcWindow[i][j]*dehaze_reg.strength)>>8);
        }
    }
    //refine coarse t , gray  as guided image


    int32 mean_a=0;
    int32 mean_b=0;
    gf_rec_core_label1:for(uint8 i=0;i<((GF_SIZE+1)>>1);i++){
        gf_rec_core_label2:for(uint8 j=0;j<((GF_SIZE+1)>>1);j++){
            int32 a=0;
            int32 b=0;
            int32 mean_I=0;
            int32 mean_p=0;
            int32 mean_Ip=0;
            int32 mean_II=0;
            gf_rec_core_label3:for(uint8 r=0;r<((GF_SIZE+1)>>1);r++){
                gf_rec_core_label4:for(uint8 c=0;c<((GF_SIZE+1)>>1);c++){
   
                    int32 i_val=(iWindow[i+r][j+c])/64; //14bit to 8bit
                    int32 t_val=tWindow[i+r][j+c]/64;
                    mean_I+=i_val;
                    mean_p+=t_val;
                    mean_Ip+=i_val*t_val;
                    mean_II+=i_val*i_val;
                }
            }
            mean_I=mean_I/(((GF_SIZE+1)>>1)*((GF_SIZE+1)>>1));
            mean_p=mean_p/(((GF_SIZE+1)>>1)*((GF_SIZE+1)>>1));
            mean_Ip=mean_Ip/(((GF_SIZE+1)>>1)*((GF_SIZE+1)>>1));
            mean_II=mean_II/(((GF_SIZE+1)>>1)*((GF_SIZE+1)>>1));

            a=(int32)((mean_Ip-mean_I*mean_p)*256)/(int32)((mean_II-mean_I*mean_I)+100); //amplify 1 to 256
            b=mean_p-((a*mean_I)/256);                                   
            mean_a+=a;
            mean_b+=b;

          
        }
    }
    mean_a=mean_a/(((GF_SIZE+1)>>1)*((GF_SIZE+1)>>1));
    mean_b=mean_b/(((GF_SIZE+1)>>1)*((GF_SIZE+1)>>1));
    int32 t_refine=(mean_a*iWindow[((GF_SIZE-1)>>1)][((GF_SIZE-1)>>1)]/(256*64))+mean_b;   //max 256
    
    int32 r_src=rWindow[((GF_SIZE-1)>>1)][((GF_SIZE-1)>>1)];
    int32 g_src=gWindow[((GF_SIZE-1)>>1)][((GF_SIZE-1)>>1)];
    int32 b_src=bWindow[((GF_SIZE-1)>>1)][((GF_SIZE-1)>>1)];

    

    int32 t=t_refine;
    t=(t>256)?(int32)256:(t<=0?(int32)1:t);

    //recover
    int32 r_temp=((r_src-atm[0])*256/t +atm[0]);
    int32 g_temp=((g_src-atm[1])*256/t +atm[1]);
    int32 b_temp=((b_src-atm[2])*256/t +atm[2]);

    r_dst=(r_temp<=0)?(uint14)0:((r_temp>16383)?(uint14)16383:(uint14)r_temp);
    g_dst=(g_temp<=0)?(uint14)0:((g_temp>16383)?(uint14)16383:(uint14)g_temp);
    b_dst=(b_temp<=0)?(uint14)0:((b_temp>16383)?(uint14)16383:(uint14)b_temp);
    
    
}

void tRefine_rgbRec(top_register top_reg,dehaze_register dehaze_reg,uint16 atm[3],stream_u56 &srcRGBDC,stream_u42 &dstRGB){
    uint14 r_src;
    uint14 g_src;
    uint14 b_src;
    uint14 dc_src;
    uint14 r_dst;
    uint14 g_dst;
    uint14 b_dst;
    uint56 src56;
    uint42 dst42;
    uint16 rWindow[GF_SIZE][GF_SIZE];
    uint16 gWindow[GF_SIZE][GF_SIZE];
    uint16 bWindow[GF_SIZE][GF_SIZE];
    uint16 dcWindow[GF_SIZE][GF_SIZE];
    uint16 rlineBuf[GF_SIZE-1][4096];
    uint16 glineBuf[GF_SIZE-1][4096];
    uint16 blineBuf[GF_SIZE-1][4096];
    uint16 dclineBuf[GF_SIZE-1][4096];
    uint16 box_min=DEHAZE_Max_Value;
    uint32 frameWidth=top_reg.frameWidth;
    uint32 frameHeight=top_reg.frameHeight;



    gf_row:for(uint13 row = 0;row < frameHeight; row++){
        gf_col:for(uint13 col = 0 ;col < frameWidth; col++){
            src56= srcRGBDC.read();
            r_src= src56>>42;
            g_src= (src56>>28)&0x3fff;
            b_src= (src56>>14)&0x3fff;
            dc_src= src56&0x3fff;
            if(dehaze_reg.m_nEb == 1){
                out_window_loop:for(uint8 i = 0; i < GF_SIZE; i++){
                    in_window_loop:for(uint8 j = 0; j < (GF_SIZE-1); j++){                           
                        rWindow[i][j] = rWindow[i][j+1];
                        gWindow[i][j] = gWindow[i][j+1];
                        bWindow[i][j] = bWindow[i][j+1];
                        dcWindow[i][j] = dcWindow[i][j+1];
                    }
                }

                window_read:for(uint8 i = 0; i < (GF_SIZE-1); i++){
                    rWindow[i][GF_SIZE-1] = rlineBuf[i][col];
                    gWindow[i][GF_SIZE-1] = glineBuf[i][col];
                    bWindow[i][GF_SIZE-1] = blineBuf[i][col];
                    dcWindow[i][GF_SIZE-1] = dclineBuf[i][col];
                }
                    rWindow[GF_SIZE-1][GF_SIZE-1] = r_src;
                    gWindow[GF_SIZE-1][GF_SIZE-1] = g_src;
                    bWindow[GF_SIZE-1][GF_SIZE-1] = b_src;
                    dcWindow[GF_SIZE-1][GF_SIZE-1] = dc_src;

                lines_read:for(uint8 i = 0; i < GF_SIZE-2; i++){
                    rlineBuf[i][col] = rWindow[i+1][GF_SIZE-1];
                    glineBuf[i][col] = gWindow[i+1][GF_SIZE-1];
                    blineBuf[i][col] = bWindow[i+1][GF_SIZE-1];
                    dclineBuf[i][col] = dcWindow[i+1][GF_SIZE-1];
                }
                    rlineBuf[GF_SIZE-2][col] = r_src;
                    glineBuf[GF_SIZE-2][col] = g_src;     
                    blineBuf[GF_SIZE-2][col] = b_src;    
                    dclineBuf[GF_SIZE-2][col] = dc_src; 

                if((row > (GF_SIZE-2)) && (col > (GF_SIZE-2))){
                    //Core function,guide filter and recover in window

                    gf_rec_core(dehaze_reg,atm,rWindow,gWindow,bWindow,dcWindow,r_dst,g_dst,b_dst);
 
          
                }
                else{
                    r_dst = rWindow[((GF_SIZE-1)>>1)][((GF_SIZE-1)>>1)];
                    g_dst = gWindow[((GF_SIZE-1)>>1)][((GF_SIZE-1)>>1)];
                    b_dst = bWindow[((GF_SIZE-1)>>1)][((GF_SIZE-1)>>1)];
                    
                }
                if((row > ((GF_SIZE-1)>>1)) || ((row == ((GF_SIZE-1)>>1)) && (col > (((GF_SIZE-1)>>1))-1))){
                   dst42(41,28)=r_dst;
                   dst42(27,14)=g_dst;
                   dst42(13,0) =b_dst;
                   dstRGB.write(dst42);
                }

            }
            else{
                r_dst = r_src;
                g_dst = g_src;
                b_dst = b_src;
                dst42(41,28)=r_dst;
                dst42(27,14)=g_dst;
                dst42(13,0) =b_dst;
                dstRGB.write(dst42);
                
            }
        }
    }
    if(dehaze_reg.m_nEb == 1){
        addon_loop_1: for (uint8 i = 0; i < ((GF_SIZE-1)>>1); i++){
            r_dst = rWindow[((GF_SIZE-1)>>1)][i+((GF_SIZE+1)>>1)];
            g_dst = gWindow[((GF_SIZE-1)>>1)][i+((GF_SIZE+1)>>1)];
            b_dst = bWindow[((GF_SIZE-1)>>1)][i+((GF_SIZE+1)>>1)];
            
            dst42(41,28)=r_dst;
            dst42(27,14)=g_dst;
            dst42(13,0) =b_dst;
            dstRGB.write(dst42);

        }
        addon_loop_2: for (uint8 i = 0; i < ((GF_SIZE-1)>>1); i++){
            for(uint13 j = 0; j < frameWidth; j++){
                r_dst = rlineBuf[i+((GF_SIZE-1)>>1)][j];
                g_dst = glineBuf[i+((GF_SIZE-1)>>1)][j];
                b_dst = blineBuf[i+((GF_SIZE-1)>>1)][j];
              
                dst42(41,28)=r_dst;
                dst42(27,14)=g_dst;
                dst42(13,0) =b_dst;
                dstRGB.write(dst42);
             }
        }
    } 


}


void minfilter(top_register top_reg, dehaze_register &dehaze_reg,stream_u42 &srcRGB,stream_u56  &dstRGBDC){
    uint14 r_src;
    uint14 g_src;
    uint14 b_src;

    uint14 r_dst;
    uint14 g_dst;
    uint14 b_dst;
    uint14 box_min=DEHAZE_Max_Value;
    uint16 rWindow[MIN_SIZE][MIN_SIZE];
    uint16 gWindow[MIN_SIZE][MIN_SIZE];
    uint16 bWindow[MIN_SIZE][MIN_SIZE];
    uint16 rlineBuf[MIN_SIZE-1][4096];
    uint16 glineBuf[MIN_SIZE-1][4096];
    uint16 blineBuf[MIN_SIZE-1][4096];
    uint42 src42;
    uint56 dst56;
    uint32 frameWidth=top_reg.frameWidth;
    uint32 frameHeight=top_reg.frameHeight;
    uint16 atm_o[3];
    uint16 dc_max=0;
    min_r:for(uint13 row = 0;row < frameHeight; row++){
        min_c:for(uint13 col = 0 ;col < frameWidth; col++){
            src42=srcRGB.read();
            r_src=src42>>28;
            g_src=(src42>>14)&0x3fff;
            b_src=src42&0x3fff;
            if(dehaze_reg.m_nEb == 1){
                out_window_loop:for(uint8 i = 0; i < MIN_SIZE; i++){
                    in_window_loop:for(uint8 j = 0; j < (MIN_SIZE-1); j++){                           
                        rWindow[i][j] = rWindow[i][j+1];
                        gWindow[i][j] = gWindow[i][j+1];
                        bWindow[i][j] = bWindow[i][j+1];
                    }
                }

                window_read:for(uint8 i = 0; i < (MIN_SIZE-1); i++){
                    rWindow[i][MIN_SIZE-1] = rlineBuf[i][col];
                    gWindow[i][MIN_SIZE-1] = glineBuf[i][col];
                    bWindow[i][MIN_SIZE-1] = blineBuf[i][col];
                }
                    rWindow[MIN_SIZE-1][MIN_SIZE-1] = r_src;
                    gWindow[MIN_SIZE-1][MIN_SIZE-1] = g_src;
                    bWindow[MIN_SIZE-1][MIN_SIZE-1] = b_src;

                lines_read:for(uint8 i = 0; i < (MIN_SIZE-2); i++){
                    rlineBuf[i][col] = rWindow[i+1][MIN_SIZE-1];
                    glineBuf[i][col] = gWindow[i+1][MIN_SIZE-1];
                    blineBuf[i][col] = bWindow[i+1][MIN_SIZE-1];
                }
                    rlineBuf[MIN_SIZE-2][col] = r_src;
                    glineBuf[MIN_SIZE-2][col] = g_src;     
                    blineBuf[MIN_SIZE-2][col] = b_src;     

                if((row > (MIN_SIZE-2)) && (col > (MIN_SIZE-2))){
                    //Core function,minfilter in window
                    box_min=DEHAZE_Max_Value;
                    for(uint8 i=0;i<MIN_SIZE;i++){
                        for(uint8 j=0;j<MIN_SIZE;j++){   
                        uint16 channel_min=(rWindow[i][j]>gWindow[i][j])?(bWindow[i][j]>gWindow[i][j]?gWindow[i][j]:bWindow[i][j]):(bWindow[i][j]>rWindow[i][j]?rWindow[i][j]:bWindow[i][j]);
                        box_min=(box_min<channel_min)?box_min:(uint14)channel_min;
                        }
                    }
                    if(box_min>dc_max){
                    	dc_max=box_min;
                    	atm_o[0]=rWindow[(MIN_SIZE-1)>>1][(MIN_SIZE-1)>>1];
                    	atm_o[1]=gWindow[(MIN_SIZE-1)>>1][(MIN_SIZE-1)>>1];
                    	atm_o[2]=bWindow[(MIN_SIZE-1)>>1][(MIN_SIZE-1)>>1];
                        dehaze_reg.atm_r=atm_o[0];
                        dehaze_reg.atm_g=atm_o[1];
                        dehaze_reg.atm_b=atm_o[2];
                    }
                    r_dst = rWindow[(MIN_SIZE-1)>>1][(MIN_SIZE-1)>>1];
                    g_dst = gWindow[(MIN_SIZE-1)>>1][(MIN_SIZE-1)>>1];
                    b_dst = bWindow[(MIN_SIZE-1)>>1][(MIN_SIZE-1)>>1];
                }
                else{
                    r_dst = rWindow[(MIN_SIZE-1)>>1][(MIN_SIZE-1)>>1];
                    g_dst = gWindow[(MIN_SIZE-1)>>1][(MIN_SIZE-1)>>1];
                    b_dst = bWindow[(MIN_SIZE-1)>>1][(MIN_SIZE-1)>>1];
                    box_min=(rWindow[(MIN_SIZE-1)>>1][(MIN_SIZE-1)>>1]>gWindow[(MIN_SIZE-1)>>1][(MIN_SIZE-1)>>1])?(bWindow[(MIN_SIZE-1)>>1][(MIN_SIZE-1)>>1]>gWindow[(MIN_SIZE-1)>>1][(MIN_SIZE-1)>>1]?gWindow[(MIN_SIZE-1)>>1][(MIN_SIZE-1)>>1]:bWindow[(MIN_SIZE-1)>>1][(MIN_SIZE-1)>>1]):(bWindow[(MIN_SIZE-1)>>1][(MIN_SIZE-1)>>1]>rWindow[(MIN_SIZE-1)>>1][(MIN_SIZE-1)>>1]?rWindow[(MIN_SIZE-1)>>1][(MIN_SIZE-1)>>1]:bWindow[(MIN_SIZE-1)>>1][(MIN_SIZE-1)>>1]);
                }
                if((row > ((MIN_SIZE-1)>>1)) || ((row == ((MIN_SIZE-1)>>1)) && (col > (((MIN_SIZE-1)>>1)-1)))){
                  
                   dst56(55,42)=r_dst;
                   dst56(41,28)=g_dst;
                   dst56(27,14)=b_dst;
                   dst56(13,0)= box_min;
                   dstRGBDC.write(dst56);
                }

            }
            else{
                r_dst = r_src;
                g_dst = g_src;
                b_dst = b_src;
                dst56(55,42)=r_dst;
                dst56(41,28)=g_dst;
                dst56(27,14)=b_dst;
                dst56(13,0)= 0;
                dstRGBDC.write(dst56);
            }
        }
    }
    if(dehaze_reg.m_nEb == 1){
        addon_loop_1: for (uint8 i = 0; i < ((MIN_SIZE-1)>>1); i++){
            r_dst = rWindow[(MIN_SIZE-1)>>1][i+((MIN_SIZE+1)>>1)];
            g_dst = gWindow[(MIN_SIZE-1)>>1][i+((MIN_SIZE+1)>>1)];
            b_dst = bWindow[(MIN_SIZE-1)>>1][i+((MIN_SIZE+1)>>1)];
            box_min=(r_dst>g_dst)?(b_dst>g_dst?g_dst:b_dst):(b_dst>r_dst?r_dst:b_dst);
            dst56(55,42)=r_dst;
            dst56(41,28)=g_dst;
            dst56(27,14)=b_dst;
            dst56(13,0)= box_min;
            dstRGBDC.write(dst56);
        }
        addon_loop_2: for (uint8 i = 0; i < ((MIN_SIZE-1)>>1); i++){
            for(uint13 j = 0; j < frameWidth; j++){
                r_dst = rlineBuf[i+((MIN_SIZE-1)>>1)][j];
                g_dst = glineBuf[i+((MIN_SIZE-1)>>1)][j];
                b_dst = blineBuf[i+((MIN_SIZE-1)>>1)][j];
                box_min=(r_dst>g_dst)?(b_dst>g_dst?g_dst:b_dst):(b_dst>r_dst?r_dst:b_dst);
                dst56(55,42)=r_dst;
                dst56(41,28)=g_dst;
                dst56(27,14)=b_dst;
                dst56(13,0)= box_min;
                dstRGBDC.write(dst56);
             }
        }
    }
}

void dehaze(top_register top_reg, dehaze_register &dehaze_reg, stream_u42 &srcData, stream_u42 &dstData){

    stream_u56 internal_data;
    #pragma HLS STREAM variable=internal_data depth=2 dim=1
    dehaze_reg.strength=128;
    dehaze_reg.atm_r=240*64;
    dehaze_reg.atm_g=240*64;
    dehaze_reg.atm_b=240*64;
    uint16 atm[3]={240*64,240*64,240*64};
    minfilter(top_reg,dehaze_reg,srcData,internal_data);
    tRefine_rgbRec(top_reg,dehaze_reg,atm,internal_data,dstData);

}




