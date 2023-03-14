#include "tpg.h"

#define TPG_BITS 12
#define MAXS ((1<<TPG_BITS) - 1)

uint12 ColorSelect(uint2 channel, uint4 BlockID, tpg_register tpg_reg)
{
    uint4 RealID;
    tpg_reg.m_nID = 0;
    tpg_reg.m_bRollingEnable = 1;
    RealID = BlockID;
    if(tpg_reg.m_bRollingEnable){
        RealID += tpg_reg.m_nID;
        if (RealID > 7){
            RealID -= 8;
        }
    }

    switch(RealID){
        case 0: //white
            return MAXS;
        case 1: //black
            return 0;
        case 2: //red
            if (0 == channel){
                return MAXS;
            }else{
                return 0;
            }
        case 3: //green
            if(1 == channel || 2 == channel){
                return MAXS;
            }else{
                return 0;
            }
        case 4: //blue
            if(3 == channel){
                return MAXS;
            }else{
                return 0;
}
        case 5: //cyan B+G
            if(0 != channel){
                return MAXS;
            }else{
                return 0;
            }
        case 6: //magenta R+B
            if(0 == channel || 3 == channel){
                return MAXS;
            }else{
                return 0;
            }
        case 7: //yellow R+G
            if(3 != channel){
                return MAXS;
            }else{
                return 0;
            }

        default:
            return 0;
    }
};

void tpg(top_register top_reg, tpg_register tpg_reg, stream_u12 &src, stream_u12 &dst){

    uint2   channel;
    uint10  cnt;
    uint10  BlockWidth = (top_reg.frameWidth >> 3) & 0x3fe;
    uint4   BlockID;
    uint12  dst_t = 0;

    tpg_row: for(uint13 i = 0; i < top_reg.frameHeight; i++){
        cnt = 0;
        BlockID = 0;
        tpg_col: for(uint13 j = 0; j < top_reg.frameWidth; j++){
            if(tpg_reg.m_bTPG_en == 1) {
                if (cnt == BlockWidth){
                    cnt = 1;
                    BlockID++;
                } else {
                    cnt++;
                }

                if(BlockID > 7){
                    BlockID = 7;
                }
                dst_t =src.read();

                channel = (((i & 1) << 1) + (j & 1))^top_reg.imgPattern;
                dst_t   = ColorSelect(channel, BlockID, tpg_reg);
                dst.write(dst_t);
            } else {
                dst_t = src.read();
                dst.write(dst_t);
                #ifdef DEBUG
                if((i == top_reg.ROW_TEST) && (j == top_reg.COL_TEST)) {
                    printf("\t tpg_in = %x\n",dst_t.to_int());
                }
                #endif
            }
        }
    }
};
