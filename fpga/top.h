#ifndef _ISP_TOP_H_
#define _ISP_TOP_H_

#include "stdio.h"
#include <ap_int.h>
#include <hls_stream.h>
typedef ap_int<4>   int4;
typedef ap_int<6>   int6;
typedef ap_int<10>  int10;
typedef ap_int<11>  int11;
typedef ap_int<12>  int12;
typedef ap_int<13>  int13;
typedef ap_int<14>  int14;
typedef ap_int<15>  int15;
typedef ap_int<16>  int16;
typedef ap_int<17>  int17;
typedef ap_int<18>  int18;
typedef ap_int<19>  int19;
typedef ap_int<21>  int21;
typedef ap_int<22>  int22;
typedef ap_int<23>  int23;
typedef ap_int<24>  int24;
typedef ap_int<25>  int25;
typedef ap_int<27>  int27;
typedef ap_int<30>  int30;
typedef ap_int<31>  int31;
typedef ap_int<34>  int34;
typedef ap_uint<1>  uint1;
typedef ap_uint<2>  uint2;
typedef ap_uint<3>  uint3;
typedef ap_uint<4>  uint4;
typedef ap_uint<5>  uint5;
typedef ap_uint<6>  uint6;
typedef ap_uint<7>  uint7;
typedef ap_uint<8>  uint8;
typedef ap_uint<9>  uint9;
typedef ap_uint<10> uint10;
typedef ap_uint<11> uint11;
typedef ap_uint<12> uint12;
typedef ap_uint<13> uint13;
typedef ap_uint<14> uint14;
typedef ap_uint<15> uint15;
typedef ap_uint<16> uint16;
typedef ap_uint<18> uint18;
typedef ap_uint<20> uint20;
typedef ap_uint<21> uint21;
typedef ap_uint<22> uint22;
typedef ap_uint<24> uint24;
typedef ap_uint<25> uint25;
typedef ap_uint<26> uint26;
typedef ap_uint<28> uint28;
typedef ap_uint<30> uint30;
typedef ap_uint<32> uint32;
typedef ap_uint<33> uint33;
typedef ap_uint<36> uint36;
typedef ap_uint<40> uint40;
typedef ap_uint<42> uint42;
typedef hls::stream<uint10> stream_u10;
typedef hls::stream<uint12> stream_u12;
typedef hls::stream<uint16> stream_u16;
typedef hls::stream<uint30> stream_u30;
typedef hls::stream<uint36> stream_u36;
typedef hls::stream<uint42> stream_u42;
typedef stream_u12  stream_in;
typedef stream_u30  stream_out;
typedef ap_uint<16> in_t;
typedef ap_uint<32> out_t;
typedef ap_uint<16> awb_gain_t;
typedef ap_uint<128> config_t;
typedef ap_uint<1> bool_t;
typedef ap_uint<64> tab_t;

#define DEBUG
#define COL_TEST 636
#define ROW_TEST 475
// top module header
typedef struct{
    uint13  frameWidth;    //13 bits
    uint13  frameHeight;   //13 bits
    bool_t  inputFormat;   //
    uint2   imgPattern;    //2bits 0:r 1:Gr 2:Gb 3:b
    uint2   pipeMode;      //2bits 0:sigle 1:dual 2:hdr
    uint9   blc;           //9bits four chn blc before stretch moduel
    bool_t  shadowEb;      //isp reg shadow enable
    uint13  binningFrameWidth; //13 bits
    uint13  binningFrameHeight;  //13 bits;
    uint13  scalerFrameWidth;  //13 bits;
    uint13  scalerFrameHeight; //13 bits;
}top_register;// 93-bit

// tpg module header
typedef struct{
    bool_t  m_bTPG_en;  // 1u
    uint13  m_nWidth;   // 13u
    uint13  m_nHeight;  // 13u
    bool_t  m_bSensor_timing_en; // 1u
    uint12  m_nVBlank_num;  //12u
    uint12  m_nHBlank_num; //12u
    uint8   m_valid_blank; //8u
    uint4   m_nID; //4u
    // split
    uint2   m_nCFAPattern;  // 2u
    bool_t  m_bRollingEnable; // 1u
} tpg_register; //67-bit

void tpg(top_register top_register, tpg_register tpg_register, stream_u12 &src, stream_u12 &dst);

// dgain module header
#define GAIN_BITS 12
#define GAIN_HALF_VALUE (1 << (GAIN_BITS - 1))

typedef struct{
    bool_t  m_nEb; //1 bit
    uint9   m_nBlcR; //9 bit
    uint9   m_nBlcGr; //9 bit
    uint9   m_nBlcGb; //9 bit
    uint9   m_nBlcB; //9 bit
    uint20  m_nR;  //20 bits -> (8.12)256X gain
    uint20  m_nGr; //20 bits
    uint20  m_nGb; //20 bits
    uint20  m_nB; //20 bits
} dgain_register;   // 117-bit

void dgain(top_register top_register, dgain_register dgain_register, stream_u12 &src, stream_u12 &dst);

// lsc module header
typedef struct{
    bool_t  eb; //1 bit
//    uint13 rGain[13*17]; //13 bit
//    uint13 GrGain[13*17]; //13 bit
//    uint13 GbGain[13*17]; //13 bit
//    uint13 bGain[13*17]; //13 bit
    uint9   blockHeight; //9 bit
    uint9   blockWidth; //9 bit
    uint14  blockWidth_1; //14 bit
    uint10  blockHeight_1; //10 bit
} lsc_register; // 93-bit

void lsc(top_register topRegister, lsc_register lscRegister, stream_u12 &src, stream_u12 &dsti, uint13 rGain[224], uint13 GrGain[224], uint13 GbGain[224], uint13 bGain[224]);

//dpc module header
typedef struct
{
    bool     eb; //i bit
    uint11   th_w; //11 bit
    uint11   th_b; //11 bit
}dpc_register; //23-bit

void dpc(top_register top_reg, dpc_register dpc_reg, stream_u12& src, stream_u12& dst);

//rawdns module header
typedef struct
{
    bool_t eb;
    uint6 sigma;
    uint7 Filterpara;
    uint12  invksigma2;
}rawdns_register;

uint8 Cal_weight(uint30 diff,rawdns_register& rawdns_reg,uint26 ksigma2);
uint30 Cal_Eur_Distance(uint12 rawdns_block[11][11], uint4 cur_y, uint4 cur_x);
uint12 rawdns_process(uint12 rawdns_block[11][11],rawdns_register& rawdns_reg,uint26 ksigma2,uint13 row, uint13 col);
void rawdns(top_register top_reg, rawdns_register rawdns_reg, stream_u12& src, stream_u12& dst);

//awb module header
typedef struct {
    bool eb;
    uint6 coeff;
}awb_register;

void awb(top_register top_register, awb_register awb_register, stream_u12 &src, stream_u16 &awb_gain, stream_u12 &dst);

// wbc module header
typedef struct{
    bool_t  m_nEb;
    uint15  m_nR; //15 bits (3.12) 7.93X gain
    uint15  m_nGr; //15 bits (3.12) 7.93X gain
    uint15  m_nGb; //15 bits (3.12) 7.93X gain
    uint15  m_nB; //15 bits (3.12) 7.93X gain
} wbc_register; // 61-bit

void wbc(top_register top_register, wbc_register wbc_register, stream_u12 &src, stream_u12 &dst);

// gb module header
typedef struct
{
    bool_t  eb;
    uint4   win_size;
    uint4   Lbound;
    uint6   Hbound;
    uint10  threhold;
}gb_register;

void greenbalance2(top_register top_reg,gb_register gb_reg,stream_u12 &src,stream_u12 &dst);

// demosaic module header
typedef struct {
    bool_t  eb; // 1 bit
} demosaic_register;

typedef uint12 rawData_t;
typedef stream_u12 Stream_t;
typedef stream_u36 Stream_3t;
void demosiac_filter(Stream_t& in,Stream_3t& out);

struct pixel_t
{
    rawData_t r;
    rawData_t g;
    rawData_t b;
};

struct pixelTmp_t
{
    int18 r;
    int18 g;
    int18 b;
};

void demosaic(top_register top_register, demosaic_register demosaic_register, Stream_t& src, Stream_3t& dst);


//ee module header
typedef struct{
    bool eb;
    uint6 coeff;
}ee_register;

typedef struct{
    uint12 r;
    uint12 g;
    uint12 b;
}ee_pixel_t;

void ee(top_register top_register , ee_register ee_register, Stream_3t& src, Stream_3t& dst);
uint36 eeprocess(uint36[5][5], ee_register&);

// cmc module header
#define CMC_BITS_DEEP 14
#define CMC_BLC_BITS_DEEP 12
#define CMC_SHIFT_DEEP 10
#define CMC_HALF_VALUE (1 << (CMC_SHIFT_DEEP - 1))
#define CMC_MAX_VALUE  ((1 << CMC_BITS_DEEP) - 1)

typedef struct{
    bool_t  m_nEb; //1 bit
//    int16   m_nGain[9]; //16bits 4096 1X
    bool_t  m_bCFCEnable; //1 bit
    bool_t  m_bDiscardH;  //1 bit
    uint9   m_pHueRange[2]; //9ub
    uint3   m_nHueBandShift; //3ub
    uint8   m_nEdgeThre; //8ub
    uint3   m_nEdgeBandShift; //3ub
    uint5   m_nCFCStrength; //5ub
} cmc_register; // 40-bit

void cmc(top_register top_register, cmc_register cmc_register, stream_u36 &src, stream_u42 &dsti, int16 m_nGain[12]);

// gtm module header
typedef struct{
    bool_t  eb;
    bool_t  m_bDitheringEnable;
//    uint10  gtmTab[129];
} gtm_register; // 2-bit + 1290-bit

void gtm(top_register top_register, gtm_register gtm_register, stream_u42 &src, stream_u42 &dst, uint10 gtmTab[132]);

// csc module header
typedef struct{
    bool_t  m_nEb;
    // int11 coeff[12];
} csc_register; // 1-bit + 132-bit

void csc(top_register top_register, csc_register csc_register, stream_u42 &src, stream_u30 &dst, int11 coeff[12]);

// yfc module header
typedef struct {
    bool m_nEb;
    bool yuvpattern;//0:yuv422 1:yuv420
} yfc_register;

void yfc(top_register top_register, yfc_register yfc_register, stream_u30& src, stream_u10& y_dst, stream_u10& u_dst, stream_u10& v_dst);

// yuvdns module header
typedef struct 
{
    bool eb; //1 bit
    uint14 ysigma2;// 14 bit
    uint10 yinvsigma2;// 10 bit
    uint14 uvsigma2;//14 bit
    uint10 uvinvsigma2;//10 bit
    uint4 yfilt;//4 bit
    uint4 uvfilt;//4 bit
    uint5 yinvfilt;//5 bit
    uint5 uvinvfilt;//5 bit 
    uint14 yH2;//14 bit
    uint18 yinvH2; //18 bit
    uint14 uvH2;//14 bit
    uint18 uvinvH2; //18 bit

}yuvdns_register; //67+64-bit

void yuv444dns(top_register top_register, yuvdns_register yuvdns_register, stream_u10 &src_y, stream_u10 &src_u, stream_u10 &src_v, stream_u10 &dst_y, stream_u10 &dst_u, stream_u10 &dst_v);


// scale module header
typedef struct {
    bool m_nEb;
    uint2 yuvpattern;//0:yuv444 1:yuv422 2:yuv420
    uint5 times;
} scale_register;

void scale(top_register top_register, scale_register scale_register, stream_u10 &y_src, stream_u10 &u_src, stream_u10 &v_src, stream_u10& y_dst, stream_u10& u_dst, stream_u10& v_dst);

// crop module header
typedef struct {
    bool m_nEb;
    uint13 upper_left_x;
    uint13 upper_left_y;
    uint13 lower_right_x;
    uint13 lower_right_y;
    uint2  yuvpattern;//0:yuv444 1:yuv422 2:yuv420
}crop_register;

void crop(top_register top_register, crop_register crop_register, stream_u10 &y_src, stream_u10 &u_src, stream_u10 &v_src, stream_u10& y_dst, stream_u10& u_dst, stream_u10& v_dst);

#endif

