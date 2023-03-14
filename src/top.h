#ifndef _ISP_TOP_H_
#define _ISP_TOP_H_

#include <stdio.h>
#include <stdlib.h>
#include <memory.h>
#include <iostream>
using namespace std;

#include "file_define.h"

#define vivado
//#define catapult
//#define DEBUG
//#define ROW_TEST 4
//#define COL_TEST 4

#ifdef vivado
    #include <ap_int.h>
    #include <hls_stream.h>
    typedef ap_int<2>   int2;
    typedef ap_int<3>   int3;
    typedef ap_int<4>   int4;
    typedef ap_int<5>   int5;
    typedef ap_int<6>   int6;
    typedef ap_int<8>   int8;
    typedef ap_int<9>   int9;
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
    typedef ap_int<20>  int20;
    typedef ap_int<21>  int21;
    typedef ap_int<22>  int22;
    typedef ap_int<23>  int23;
    typedef ap_int<24>  int24;
    typedef ap_int<25>  int25;
    typedef ap_int<27>  int27;
    typedef ap_int<30>  int30;
    typedef ap_int<31>  int31;
    typedef ap_int<32>  int32;
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
    typedef ap_uint<17> uint17;
    typedef ap_uint<18> uint18;
    typedef ap_uint<19> uint19;
    typedef ap_uint<20> uint20;
    typedef ap_uint<21> uint21;
    typedef ap_uint<22> uint22;
    typedef ap_uint<24> uint24;
    typedef ap_uint<25> uint25;
    typedef ap_uint<26> uint26;
    typedef ap_uint<27> uint27;
    typedef ap_uint<28> uint28;
    typedef ap_uint<29> uint29;
    typedef ap_uint<30> uint30;
    typedef ap_uint<32> uint32;
    typedef ap_uint<33> uint33;
    typedef ap_uint<34> uint34;
    typedef ap_uint<36> uint36;
    typedef ap_uint<40> uint40;
    typedef ap_uint<42> uint42;
    typedef ap_uint<47> uint47;
    typedef ap_uint<56> uint56;

    typedef hls::stream<uint10> stream_u10;
    typedef hls::stream<uint12> stream_u12;
    typedef hls::stream<uint30> stream_u30;
    typedef hls::stream<uint36> stream_u36;
    typedef hls::stream<uint42> stream_u42;
    typedef hls::stream<uint56> stream_u56;

    typedef struct {
        uint12 data;
        uint1  last;
        uint1  user;
    }src_strm;

    typedef struct {
        uint36 data;
        uint1  last;
        uint1  user;
    }dst_strm;

    typedef hls::stream<src_strm> video_stream_u12;
    typedef hls::stream<dst_strm> video_stream_u36;
    typedef stream_u12  stream_in;
    typedef stream_u30  stream_out;
#endif

#ifdef catapult
    #include <ac_int.h>
    #include <ac_channel.h>
    #include <ac_math.h>
    using namespace ac_math;
    typedef ac_int<2,true>   int2;
    typedef ac_int<4,true>   int4;
    typedef ac_int<6,true>   int6;
    typedef ac_int<8,true>   int8;
    typedef ac_int<9,true>   int9;
    typedef ac_int<10,true>  int10;
    typedef ac_int<11,true>  int11;
    typedef ac_int<12,true>  int12;
    typedef ac_int<13,true>  int13;
    typedef ac_int<14,true>  int14;
    typedef ac_int<15,true>  int15;
    typedef ac_int<16,true>  int16;
    typedef ac_int<17,true>  int17;
    typedef ac_int<18,true>  int18;
    typedef ac_int<19,true>  int19;
    typedef ac_int<21,true>  int21;
    typedef ac_int<22,true>  int22;
    typedef ac_int<23,true>  int23;
    typedef ac_int<24,true>  int24;
    typedef ac_int<25,true>  int25;
    typedef ac_int<27,true>  int27;
    typedef ac_int<31,true>  int31;
    typedef ac_int<32,true>  int32;
    typedef ac_int<34,true>  int34;
    typedef ac_int<1,false>  uint1;
    typedef ac_int<2,false>  uint2;
    typedef ac_int<3,false>  uint3;
    typedef ac_int<4,false>  uint4;
    typedef ac_int<5,false>  uint5;
    typedef ac_int<6,false>  uint6;
    typedef ac_int<7,false>  uint7;
    typedef ac_int<8,false>  uint8;
    typedef ac_int<9,false>  uint9;
    typedef ac_int<10,false> uint10;
    typedef ac_int<11,false> uint11;
    typedef ac_int<12,false> uint12;
    typedef ac_int<13,false> uint13;
    typedef ac_int<14,false> uint14;
    typedef ac_int<15,false> uint15;
    typedef ac_int<16,false> uint16;
    typedef ac_int<17,false> uint17;
    typedef ac_int<18,false> uint18;
    typedef ac_int<19,false> uint19;
    typedef ac_int<20,false> uint20;
    typedef ac_int<21,false> uint21;
    typedef ac_int<22,false> uint22;
    typedef ac_int<24,false> uint24;
    typedef ac_int<25,false> uint25;
    typedef ac_int<26,false> uint26;
    typedef ac_int<27,false> uint27;
    typedef ac_int<28,false> uint28;
    typedef ac_int<29,false> uint29;
    typedef ac_int<30,false> uint30;
    typedef ac_int<32,false> uint32;
    typedef ac_int<33,false> uint33;
    typedef ac_int<34,false> uint34;
    typedef ac_int<36,false> uint36;
    typedef ac_int<40,false> uint40;
    typedef ac_int<42,false> uint42;
    typedef ac_channel<uint12>  stream_in;
    typedef ac_channel<uint30>  stream_out;
    typedef ac_channel<uint10>  stream_u10;
    typedef ac_channel<uint12>  stream_u12;
    typedef ac_channel<uint30>  stream_u30;
    typedef ac_channel<uint36>  stream_u36;
    typedef ac_channel<uint42>  stream_u42;
#endif

#ifdef vivado
typedef struct {
    uint13  frameWidth;    //13 bits
    uint13  frameHeight;   //13 bits
    bool    inputFormat;   //
    uint2   imgPattern;    //2bits 0:r 1:Gr 2:Gb 3:b
    uint2   pipeMode;      //2bits 0:sigle 1:dual 2:hdr
    uint9   blc;           //9bits four chn blc before stretch module
    bool    shadowEb;      //isp reg shadow enable
    uint13  binningFrameWidth; //13 bits
    uint13  binningFrameHeight;  //13 bits;
    uint13  scalerFrameWidth;  //13 bits;
    uint13  scalerFrameHeight; //13 bits;
} top_register;
#endif

#ifdef catapult
typedef struct {
    uint13  frameWidth;    //13 bits
    uint13  frameHeight;   //13 bits
    bool    inputFormat;   //
    uint2   imgPattern;    //2bits 0:r 1:Gr 2:Gb 3:b
    uint2   pipeMode;      //2bits 0:sigle 1:dual 2:hdr
    uint9   blc;           //9bits four chn blc before stretch module
    bool    shadowEb;      //isp reg shadow enable
    uint13  binningFrameWidth; //13 bits
    uint13  binningFrameHeight;  //13 bits;
    uint13  scalerFrameWidth;  //13 bits;
    uint13  scalerFrameHeight; //13 bits;
    uint13  ROW_TEST;
    uint13  COL_TEST;
} top_register;
#endif

#endif
