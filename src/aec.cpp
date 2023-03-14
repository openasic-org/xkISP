#include"aec.h"
#define AEC_BIT_DEPTH    14// yuv image`data 10bits
#define AEC_Max_Value    (1 << AEC_BIT_DEPTH) - 1
void aec(top_register top_reg, aec_register& aec_reg, stream_u42 &src, stream_u42 &dst) {
    uint14 src_w[3];
    uint14 dst_w[3];
    uint42 src_t;
    uint42 dst_t;
    
    uint47 W_Black=0;
    uint47 M_Black=0;
    uint47 W_Middle=0;
    uint47 M_Middle=0;
    uint47 W_High=0;
    uint47 M_High=0;
    uint47 mean_y=0;
    
    uint16 block_width=aec_reg.block_width;
    uint16 block_height=aec_reg.block_height;
    
    aec_row: for (uint13 y = 0; y < top_reg.frameHeight; y++) {
        aec_col: for (uint13 x = 0; x < top_reg.frameWidth; x++) {
            src_t = src.read();
            src_w[0] = src_t>>28;
            src_w[1] = (src_t >> 14) & 0x3fff;
            src_w[2] = src_t & 0x3fff;
            if(aec_reg.m_nEb == 1)
            {               

                uint14 nY=(2*src_w[0]+9*src_w[1]+5*src_w[2]+8)>>(4);
                uint8 w_index=3*(y/block_height)+x/block_width;


                if((nY>=0)&&(nY<4915)){
                    W_Black+=aec_reg.weights[w_index];
                    M_Black=M_Black+nY*aec_reg.weights[w_index];
                }else if((nY>=4915)&&(nY<11468)){
                    W_Middle+=aec_reg.weights[w_index];
                    M_Middle=M_Middle+nY*aec_reg.weights[w_index];

                }else{
                    W_High+=aec_reg.weights[w_index];
                    M_High=M_High+nY*aec_reg.weights[w_index];
                }

                
            }
            
            dst_t = src_t;
            dst.write(dst_t);
            #ifdef DEBUG
            //if ((x == ROW_TEST)&&(y == COL_TEST)) {
              //   printf("\t%d\n",src_t.to_int());
            //}
            #endif
        }
    }
    uint47 W=W_Black+W_Middle+W_High;
    uint47 M=M_Black+M_Middle+M_High;

    if(aec_reg.m_nEb){
        aec_reg.mean_y=M/(top_reg.frameHeight*top_reg.frameWidth*aec_reg.weight_sum);  //TODO: W should be a constant number
    }
    
   
    

}
