# tpg.md
## parameters

```C++
typedef struct{
    bool    m_bTPG_en;
    uint13  m_nWidth;
    uint13  m_nHeight;
    uint2   m_nCFAPattern;
    bool    m_bRollingEnable;
    bool    m_bSensor_timing_en;
    uint12  m_nVBlank_num;
    uint12  m_nHBlank_num;
    uint8   m_valid_blank;
    uint3   m_nID;
} tpg_register;
```
1. `m_bTPG_en`

   tpg module enable
2. `m_nWidth`

   Parameter to be added
3. `m_nHeight`

   Parameters to be added
4. `m_nCFAPattern`

   CFA pattern ({0, 1, 2, 3} map to {rggb, grgb, bggr})
5. `m_bRollingEnable`

   Parameters to be added
6. `m_bSensor_timeing_en`

   Parameters to be added
7. `m_nVBlank_num`

   Parameters to be added
8. `m_nHBlank_num`

   Parameters to be added
9.  `m_valid_blank`

    Parameters to be added
10. `m_nID`

    Initial colour block ID

## code manual
### algorithm flow
```C++
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
                if((i == ROW_TEST) && (j == COL_TEST)) {
                    printf("\t tpg_in = %x\n",dst_t.to_int());
                }
                #endif
            }
        }
    }
```
in tpg function, for the same col, there are same pixels in the output test image. for the same row, if the `cnt == BlockWidth`, cnt return to 1, and `BlockID++`, Different `BlockID` correspond to different colours, and the `BlockWidth`is the width of one color. `channel` is the bayer channel, for example, if the `top_reg.imgPattern = 0`, so, channel = 0, channel is r channel; channel = 1, channel is gr channel; channel = 10, channel is gb channel; channel = 11, channel is b channel.  The output is then based on the `ColorSelect` function

 for the `ColorSelect` function, it use these code to update the initial color block.
 ```C++
if(tpg_reg.m_bRollingEnable){
    RealID += tpg_reg.m_nID;
    if (RealID > 7){
        RealID -= 8;
    }
}
```
Then fill in the colours according to the `realID`, The correspondence is as follows:
```
realID:
    0 -> white;
    1 -> black;
    2 -> red;
    3 -> green;
    4 -> blue;
    5 -> cyan(B+G);
    6 -> magenta(R+B);
    7 -> yellow(R+G);
```
the final result：
![tpg](./images/tpg.jpg)


