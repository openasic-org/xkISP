/**
* Copyright (C) 2020 Xilinx, Inc
*
* Licensed under the Apache License, Version 2.0 (the "License"). You may
* not use this file except in compliance with the License. A copy of the
* License is located at
*
*     http://www.apache.org/licenses/LICENSE-2.0
*
* Unless required by applicable law or agreed to in writing, software
* distributed under the License is distributed on an "AS IS" BASIS, WITHOUT
* WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied. See the
* License for the specific language governing permissions and limitations
* under the License.
**/

#include "xcl2.hpp"
#include <algorithm>
#include <vector>
#include "top.h"
#include <memory.h>
#include <cstdlib>
#include <string>
#include <cstring>

const std::string TOP_SRC1 = "../tv/input.raw";
const std::string TOP_CONFIG = "../tv/hls_param.txt";
const std::string TOP_DST1 = "../../../output.yuv";
const std::string TOP_GODEN1 = "../tv/crop_out_packed.yuv";

typedef in_t img_t;
const int IMG_WIDTH = 640;
const int IMG_HEIGHT = 480;
const int CROP_WIDTH = 640;
const int CROP_HEIGHT = 480;

int strkv(char *src, char *key, char *value)
{
    char *p, *q;
    p = strchr(src, '=');
    q = strchr(src, '\n');

    if (p != NULL && q != NULL)
    {
        *q = '\0';
        strncpy(key, src, p - src);
        strcpy(value, p + 1);
        return 1;
     }
     return 0;
}

void config_reg_host(std::vector<tab_t, aligned_allocator<tab_t> > & arg_config){
    top_register top_reg;
    tpg_register tpg_reg;
    dgain_register dgain_reg;
    lsc_register lsc_reg;
    dpc_register dpc_reg;
    rawdns_register rawdns_reg;
    awb_register awb_reg;
    wbc_register wbc_reg;
    gb_register gb_reg;
    demosaic_register demosaic_reg;
    ee_register ee_reg;
    cmc_register cmc_reg;
    gtm_register gtm_reg;
    csc_register csc_reg;
    yfc_register yfc_reg;
    yuvdns_register yuvdns_reg;
    scale_register scale_reg;
    crop_register crop_reg;
    hls::stream<uint12> src;
    hls::stream<uint30> dst;
    uint10 y_o;
    uint10 u_o;
    uint10 v_o;
    uint42 srcdata;
    uint30 dstdata;

    memset(&top_reg, 0, sizeof(top_register));
    memset(&tpg_reg, 0, sizeof(tpg_register));
    memset(&dgain_reg, 0, sizeof(dgain_register));
    memset(&lsc_reg, 0, sizeof(lsc_register));
    memset(&dpc_reg, 0, sizeof(dpc_register));
    memset(&rawdns_reg,0,sizeof(rawdns_register));
    memset(&awb_reg, 0, sizeof(awb_register));
    memset(&wbc_reg, 0, sizeof(wbc_register));
    memset(&gb_reg, 0, sizeof(gb_register));
    memset(&demosaic_reg, 0, sizeof(demosaic_register));
    memset(&ee_reg, 0, sizeof(ee_register));
    memset(&cmc_reg, 0, sizeof(cmc_register));
    memset(&gtm_reg, 0, sizeof(gtm_register));
    memset(&csc_reg, 0, sizeof(csc_register));
    memset(&yfc_reg, 0, sizeof(yfc_register));
    memset(&yuvdns_reg, 0, sizeof(yuvdns_register));
    memset(&scale_reg, 0, sizeof(scale_register));
    memset(&crop_reg, 0, sizeof(crop_register));

    char buf[100] = "";
    FILE* fp_config = fopen(TOP_CONFIG.c_str(),"r");
    char *p, *q;
    char key[100], value[100];
    float gtm_gamma = 0.0;
    if(fp_config == NULL)
    {
        printf("\t Warning: no configuration file!\n");
        printf("\t Will use default initial values!\n");
    }
    else
    {
        while (fgets(buf, 100, fp_config))
        {
            p = strchr(buf, '=');
            q = strchr(buf, '\n');
            if (p != NULL && q != NULL)
            {
                *q = '\0';
                strncpy(key, buf, p - buf);
                strcpy(value, p + 1);

                if(strstr(key, "frame_width"))
                {
                    top_reg.frameWidth = atoi(value);
                    continue;
                }

                if(strstr(key, "frame_height"))
                {
                    top_reg.frameHeight = atoi(value);
                    continue;
                }

                if(strstr(key, "image_pattern"))
                {
                    top_reg.imgPattern = atoi(value);
                    continue;
                }

                if(strstr(key, "blc"))
                {
                    top_reg.blc = atoi(value);
                    continue;
                }

                if(strstr(key, "dgain_enable"))
                {
                    dgain_reg.m_nEb = atoi(value);
                    continue;
                }

                if(strstr(key, "lsc_enable"))
                {
                    lsc_reg.eb = atoi(value);
                    continue;
                }

                if(strstr(key, "dpc_enable"))
                {
                    dpc_reg.eb = atoi(value);
                    continue;
                }

                if(strstr(key, "dpc_threshold_w"))
                {
                    dpc_reg.th_w = atoi(value);
                    continue;
                }

                if(strstr(key, "dpc_threshold_b"))
                {
                    dpc_reg.th_b = atoi(value);
                    continue;
                }

                if(strstr(key, "rawdns_enable"))
                {
                    rawdns_reg.eb = atoi(value);
                    continue;
                }

                if(strstr(key, "rawdns_sigma"))
                {
                    rawdns_reg.sigma = atoi(value);
                    continue;
                }

                if(strstr(key, "rawdns_filter"))
                {
                    rawdns_reg.Filterpara = atoi(value);
                    rawdns_reg.invksigma2 = 4096 * 65536 / (rawdns_reg.Filterpara * rawdns_reg.Filterpara * rawdns_reg.sigma * rawdns_reg.sigma);
                    continue;
                }

                if(strstr(key, "awb_enable"))
                {
                    awb_reg.eb = atoi(value);
                    continue;
                }

                if(strstr(key, "wbc_enable"))
                {
                    wbc_reg.m_nEb = atoi(value);
                    continue;
                }

                if(strstr(key, "wbc_rgain"))
                {
                    wbc_reg.m_nR = atoi(value);
                    continue;
                }

                if(strstr(key, "wbc_ggain"))
                {
                    wbc_reg.m_nGr = atoi(value);
                    wbc_reg.m_nGb = atoi(value);
                    continue;
                }

                if(strstr(key, "wbc_bgain"))
                {
                    wbc_reg.m_nB = atoi(value);
                    continue;
                }

                if(strstr(key, "gb_enable"))
                {
                    gb_reg.eb = atoi(value);
                    continue;
                }

                if(strstr(key, "ee_enable"))
                {
                    ee_reg.eb = atoi(value);
                    continue;
                }

                if(strstr(key, "ee_coeff"))
                {
                    ee_reg.coeff = atoi(value);
                    continue;
                }

                if(strstr(key, "cmc_enable"))
                {
                    cmc_reg.m_nEb = atoi(value);
                    continue;
                }

                if(strstr(key, "gtm_enable"))
                {
                    gtm_reg.eb = atoi(value);
                    continue;
                }

                if(strstr(key, "gtm_gamma"))
                {
                    gtm_gamma = atof(value);
                    continue;
                }

                if(strstr(key, "yuvdns_enable"))
                {
                    yuvdns_reg.eb = atoi(value);
                    continue;
                }

                if(strstr(key, "yuvdns_ysigma"))
                {
                    int ysigma = atoi(value);
                    yuvdns_reg.ysigma2 = ysigma * ysigma;
                    yuvdns_reg.yinvsigma2 = 128 * 128 / yuvdns_reg.ysigma2;
                    continue;
                }

                if(strstr(key, "yuvdns_uvsigma"))
                {
                    int uvsigma = atoi(value);
                    yuvdns_reg.uvsigma2 = uvsigma * uvsigma;
                    yuvdns_reg.uvinvsigma2 = 128 * 128 / yuvdns_reg.uvsigma2;
                    continue;
                }

                if(strstr(key, "output_left"))
                {
                    crop_reg.upper_left_x = atoi(value);
                    continue;
                }

                if(strstr(key, "output_up"))
                {
                    crop_reg.upper_left_y = atoi(value);
                    continue;
                }

                if(strstr(key, "output_right"))
                {
                    crop_reg.lower_right_x = atoi(value);
                    continue;
                }

                if(strstr(key, "output_down"))
                {
                    crop_reg.lower_right_y = atoi(value);
                    continue;
                }
            }
        }
        fclose(fp_config);
    }

    //others
    demosaic_reg.eb = 1;
    gtm_reg.m_bDitheringEnable = 1;
    csc_reg.m_nEb = 1;
    dgain_reg.m_nR= 0x01000;
    dgain_reg.m_nGr = 0x01000;
    dgain_reg.m_nGb = 0x01000;
    dgain_reg.m_nB = 0x01000;
    awb_reg.coeff = 8;
    gb_reg.win_size = 7;
    gb_reg.Lbound = 4;
    gb_reg.Hbound = 20;
    gb_reg.threhold = 683;

    yuvdns_reg.yfilt = 0x6;
    yuvdns_reg.uvfilt = 0x6;
    yuvdns_reg.yinvfilt = 0x5;
    yuvdns_reg.uvinvfilt = 0x5;
    scale_reg.times = 1;
    crop_reg.m_nEb = 1;

    yuvdns_reg.yH2 = (yuvdns_reg.yfilt * yuvdns_reg.yfilt * yuvdns_reg.ysigma2 + 255) >> 8;
    yuvdns_reg.yinvH2 = (yuvdns_reg.yinvfilt * yuvdns_reg.yinvfilt * yuvdns_reg.yinvsigma2 + 3) >> 2;
    yuvdns_reg.uvH2 = (yuvdns_reg.uvfilt * yuvdns_reg.uvfilt * yuvdns_reg.uvsigma2 + 255) >> 8;
    yuvdns_reg.uvinvH2 = (yuvdns_reg.uvinvfilt * yuvdns_reg.uvinvfilt * yuvdns_reg.uvinvsigma2 + 3) >> 2;

    lsc_reg.blockHeight = (top_reg.frameHeight - 1) / 12 + 1;
    lsc_reg.blockWidth = (top_reg.frameWidth - 1) / 16 + 1;
    //printf("\ttop_reg.frameWidth = %d\n",top_reg.frameWidth.to_int());
    //printf("\tlsc_reg.blockWidth = %d\n",lsc_reg.blockWidth.to_int());
    lsc_reg.blockHeight_1 = 32768 / lsc_reg.blockHeight;
    lsc_reg.blockWidth_1 = 524288 / lsc_reg.blockWidth.to_int();
    //printf("\tlsc_reg.blockWidth_1 = %d\n",lsc_reg.blockWidth_1.to_int());

    int16 m_nGain[12] = {6709, -2591, -22, 0, -632, 5336, -607, 0, 156, -2970, 6912, 0};

    uint10 gtm_gtmTab[129+3] =
        {0, 20, 40, 64, 84, 108, 128, 148, 168, 196, 220, 244, 268, 296, 320, 344,
        368, 388, 408, 428, 448, 468, 488, 504, 524, 540, 556, 568, 584, 596, 608, 616,
        628, 636, 648, 656, 664, 672, 680, 688, 696, 704, 708, 716, 724, 728, 736, 740,
        748, 752, 760, 764, 772, 776, 784, 788, 796, 800, 804, 812, 816, 820, 824, 828,
        832, 836, 840, 844, 848, 852, 856, 860, 864, 868, 868, 872, 876, 880, 880, 884,
        888, 892, 892, 896, 900, 904, 904, 908, 912, 916, 916, 920, 924, 928, 928, 932,
        936, 940, 940, 944, 948, 948, 952, 952, 956, 960, 960, 964, 968, 972, 972, 976,
        980, 980, 984, 984, 988, 992, 992, 996, 1000, 1000, 1004, 1004, 1008, 1012, 1012, 1016, 1023,
        0, 0, 0};   //132

    int16 coeff[12] = {308, 600, 116, 0, -172, -340, 512, 512, 512, -428, -84, 512};

    uint13 lsc_rgainTab[13*17 + 3] =    {2776,2684,2728,2690,2640,2580,2522,2474,2504,2550,2610,2682,2778,2862,2970,2920,3356,2759,2687,2690,2633,2555,2497,2429,2395,2397,2449,2519,2625,2719,2813,2872,2956,3108,2825,2707,2678,2603,2521,2464,2376,2344,2333,2399,2469,2587,2695,2787,2891,2952,3129,2846,2720,2658,2574,2496,2418,2332,2254,2242,2318,2428,2552,2654,2764,2878,2978,3138,2862,2735,2665,2568,2481,2385,2268,2155,2123,2218,2364,2533,2645,2784,2893,2985,3189,2897,2767,2679,2577,2485,2379,2216,2099,2061,2165,2323,2534,2653,2801,2911,3027,3216,2952,2808,2694,2642,2506,2392,2226,2100,2074,2174,2354,2566,2696,2850,2962,3090,3272,3010,2864,2795,2691,2578,2473,2323,2229,2205,2307,2453,2651,2781,2917,3046,3166,3357,3091,2933,2871,2780,2678,2587,2469,2391,2384,2479,2599,2740,2881,3014,3134,3242,3427,3172,3024,2962,2886,2802,2696,2614,2574,2580,2662,2746,2882,2998,3132,3240,3336,3478,3201,3095,3057,2999,2915,2829,2751,2715,2728,2799,2891,3027,3140,3255,3327,3390,3557,3218,3139,3128,3080,3029,2955,2887,2856,2869,2939,3013,3143,3252,3349,3409,3411,3654,3428,3176,3238,3210,3178,3112,3070,3052,3088,3112,3206,3324,3396,3466,3532,3542,4158,0,0,0 };
    uint13 lsc_grgainTab[13*17 + 3] =   {2718,2620,2664,2622,2570,2510,2458,2434,2440,2480,2520,2598,2686,2748,2836,2808,3224,2683,2631,2631,2579,2503,2447,2380,2357,2351,2390,2450,2541,2626,2715,2768,2831,2957,2743,2657,2608,2546,2466,2406,2335,2297,2291,2338,2401,2498,2593,2695,2776,2839,2959,2774,2664,2596,2516,2446,2360,2290,2226,2204,2270,2364,2472,2572,2674,2778,2840,2996,2790,2671,2595,2513,2427,2335,2229,2145,2111,2187,2310,2457,2557,2672,2779,2864,3022,2818,2695,2607,2529,2426,2332,2197,2098,2059,2143,2278,2456,2561,2691,2792,2891,3057,2850,2730,2636,2554,2446,2352,2208,2100,2074,2150,2300,2476,2604,2722,2832,2938,3092,2901,2786,2699,2613,2507,2411,2291,2205,2185,2267,2386,2551,2669,2795,2903,3005,3159,2961,2853,2773,2688,2597,2507,2403,2349,2339,2410,2514,2637,2755,2881,2983,3069,3225,3022,2928,2862,2784,2698,2610,2524,2492,2500,2562,2634,2752,2846,2978,3060,3150,3274,3061,2961,2932,2880,2791,2722,2652,2613,2621,2683,2755,2864,2963,3068,3149,3202,3347,3072,3007,2979,2947,2899,2838,2767,2745,2752,2803,2869,2977,3073,3156,3216,3234,3441,3254,3060,3082,3054,3016,2980,2926,2902,2898,2954,3034,3128,3194,3260,3292,3338,3810,0,0,0 };
    uint13 lsc_gbgainTab[13*17 + 3] =   {2708,2594,2654,2610,2554,2502,2448,2424,2426,2466,2520,2594,2678,2748,2828,2796,3186,2681,2626,2618,2571,2498,2436,2377,2350,2347,2380,2442,2533,2617,2705,2761,2817,2951,2734,2658,2601,2536,2459,2400,2326,2294,2284,2331,2397,2492,2584,2684,2769,2821,2963,2762,2658,2590,2518,2436,2360,2282,2220,2198,2272,2356,2472,2564,2666,2768,2848,2980,2787,2672,2586,2504,2423,2335,2227,2139,2107,2187,2311,2449,2556,2670,2776,2857,3013,2813,2696,2601,2523,2427,2331,2197,2093,2059,2143,2279,2456,2563,2687,2793,2891,3045,2844,2726,2644,2550,2446,2350,2210,2100,2076,2156,2306,2478,2600,2728,2830,2942,3098,2907,2789,2703,2616,2507,2417,2296,2203,2193,2275,2391,2558,2665,2788,2906,3005,3150,2969,2857,2785,2693,2598,2514,2412,2350,2348,2417,2517,2645,2755,2887,2983,3067,3223,3036,2934,2872,2796,2698,2622,2536,2504,2502,2578,2642,2758,2856,2978,3072,3148,3282,3063,2971,2939,2887,2805,2733,2663,2619,2635,2693,2758,2871,2971,3078,3155,3198,3340,3081,3025,2988,2961,2915,2845,2784,2755,2758,2822,2877,2988,3081,3171,3219,3235,3437,3276,3062,3078,3060,3018,2992,2926,2916,2920,2968,3056,3130,3202,3278,3290,3332,3826,0,0,0 };
    uint13 lsc_bgainTab[13*17 + 3] =    {2760,2630,2702,2642,2588,2518,2466,2414,2442,2476,2522,2608,2696,2784,2876,2852,3314,2732,2645,2639,2591,2511,2459,2387,2351,2344,2384,2449,2533,2645,2730,2789,2851,3005,2797,2664,2622,2553,2468,2411,2334,2295,2279,2328,2393,2505,2600,2709,2801,2873,3027,2814,2666,2614,2530,2450,2366,2288,2222,2196,2262,2350,2464,2582,2706,2778,2870,3048,2834,2673,2604,2518,2431,2340,2229,2143,2106,2174,2308,2451,2564,2684,2792,2879,3059,2858,2698,2620,2527,2421,2331,2199,2103,2061,2138,2271,2451,2564,2705,2813,2915,3081,2878,2732,2640,2562,2448,2346,2212,2106,2082,2148,2290,2478,2602,2732,2850,2976,3126,2939,2794,2717,2621,2505,2414,2295,2210,2189,2268,2379,2545,2671,2806,2923,3026,3213,3009,2858,2801,2697,2607,2511,2404,2351,2335,2412,2514,2644,2765,2895,3004,3099,3277,3060,2946,2888,2804,2702,2628,2538,2496,2494,2564,2648,2766,2868,3000,3096,3188,3354,3119,2987,2965,2899,2815,2739,2657,2627,2625,2683,2767,2884,2999,3099,3183,3259,3396,3135,3042,3023,2992,2926,2857,2791,2753,2756,2818,2891,3009,3104,3202,3265,3296,3528,3338,3090,3138,3096,3058,3020,2932,2936,2926,2984,3080,3158,3258,3322,3348,3392,3908,0,0,0 };

    if(gtm_gamma != 0.0) {
        float curve_x[129];
        curve_x[0]=0;
        for (int i = 1; i < 129; i++)
        {
            curve_x[i] = curve_x[i-1]+ 0.0078125;
        };
        for (int i = 0; i < 129 ;i++)
        {
            gtm_gtmTab[i] = (uint10)(((float)pow(curve_x[i],gtm_gamma))*1023);
        };
    }

    config_t config[7];
    config_t top_demosaic_gtm_csc_number = 0;   //128-bit

    ap_uint<64> tdgc_small = 0;//
    ap_uint<64> tdgc_large = 0;//

    // top reg
    tdgc_small.range(12, 0)  = top_reg.frameWidth;
    tdgc_small.range(25, 13) = top_reg.frameHeight;
    tdgc_small.range(26, 26) = top_reg.inputFormat;
    tdgc_small.range(28, 27) = top_reg.imgPattern;
    tdgc_small.range(30, 29) = top_reg.pipeMode;
    tdgc_small.range(39, 31) = top_reg.blc;
    tdgc_small.range(40, 40) = top_reg.shadowEb;
    tdgc_small.range(53, 41) = top_reg.binningFrameWidth;

    tdgc_large.range(12, 0)  = top_reg.binningFrameHeight;
    tdgc_large.range(25, 13) = top_reg.scalerFrameWidth;
    tdgc_large.range(38, 26) = top_reg.scalerFrameHeight;

    // demosaic reg
    tdgc_large.range(39, 39) = demosaic_reg.eb;
    // gtm reg
    tdgc_large.range(40, 40) = gtm_reg.eb;
    tdgc_large.range(41, 41) = gtm_reg.m_bDitheringEnable;
    // csc reg
    tdgc_large.range(42, 42) = csc_reg.m_nEb;
    //awb
    tdgc_large.range(43, 43) = awb_reg.eb;
    tdgc_large.range(49, 44) = awb_reg.coeff;
    //concat
    top_demosaic_gtm_csc_number.range(63, 0) = tdgc_small;
    top_demosaic_gtm_csc_number.range(127, 64) = tdgc_large;
    config[0] = top_demosaic_gtm_csc_number;

    config_t tpg_wbc_number = 0;// = config[1];
    ap_uint<64> tw_small = 0;//tpg_wbc_number.range(63, 0);
    ap_uint<64> tw_large = 0;//tpg_wbc_number.range(127, 64);

    // tpg reg
    tw_small.range(0,  0)  = tpg_reg.m_bTPG_en;
    tw_small.range(13, 1)  = tpg_reg.m_nWidth;
    tw_small.range(26, 14) = tpg_reg.m_nHeight;

    tw_small.range(27, 27) = tpg_reg.m_bSensor_timing_en;
    tw_small.range(39, 28) = tpg_reg.m_nVBlank_num;
    tw_small.range(51, 40) = tpg_reg.m_nHBlank_num;
    tw_small.range(59, 52) = tpg_reg.m_valid_blank;
    tw_small.range(63, 60) = tpg_reg.m_nID;

    tw_large.range(1, 0) = tpg_reg.m_nCFAPattern;
    tw_large.range(2, 2) = tpg_reg.m_bRollingEnable;

    // wbc reg
    tw_large.range(3, 3)   = wbc_reg.m_nEb;
    tw_large.range(18, 4)  = wbc_reg.m_nR;
    tw_large.range(33, 19) = wbc_reg.m_nGr;
    tw_large.range(48, 34) = wbc_reg.m_nGb;
    tw_large.range(63, 49) = wbc_reg.m_nB;

    tpg_wbc_number.range(63, 0) = tw_small;
    tpg_wbc_number.range(127, 64) = tw_large;
    config[1] = tpg_wbc_number;

    config_t dgain_number = 0;
    ap_uint<64> d_small = 0;
    ap_uint<64> d_large = 0;

    // dgain register
    d_small.range(0, 0)   = dgain_reg.m_nEb;
    d_small.range(9, 1)   = dgain_reg.m_nBlcR;
    d_small.range(18, 10) = dgain_reg.m_nBlcGr;
    d_small.range(27, 19) = dgain_reg.m_nBlcGb;
    d_small.range(36, 28) = dgain_reg.m_nBlcB;
    d_small.range(56, 37) = dgain_reg.m_nR;

    d_large.range(19, 0)  = dgain_reg.m_nGr;
    d_large.range(39, 20) = dgain_reg.m_nGb;
    d_large.range(59, 40) = dgain_reg.m_nB;

    dgain_number.range(63, 0) = d_small;
    dgain_number.range(127, 64) = d_large;
    config[2] = dgain_number;

    config_t cmc_gb_yfc_number = 0;
    ap_uint<64> c_small = 0;
    ap_uint<64> c_large = 0;
    c_small.range(0, 0) = cmc_reg.m_nEb;
    c_small.range(1, 1) = cmc_reg.m_bCFCEnable;
    c_small.range(2, 2) = cmc_reg.m_bDiscardH;
    c_small.range(11, 3) = cmc_reg.m_pHueRange[0];
    c_small.range(20, 12) = cmc_reg.m_pHueRange[1];
    c_small.range(23, 21) = cmc_reg.m_nHueBandShift;
    c_small.range(31, 24) = cmc_reg.m_nEdgeThre;
    c_small.range(34, 32) = cmc_reg.m_nEdgeBandShift;
    c_small.range(39, 35) = cmc_reg.m_nCFCStrength;

    c_small.range(40,40) = rawdns_reg.eb;
    c_small.range(46,41) = rawdns_reg.sigma;
    c_small.range(53,47) = rawdns_reg.Filterpara;

    c_large.range(0, 0) = lsc_reg.eb;
    c_large.range(9, 1) = lsc_reg.blockHeight;
    c_large.range(18, 10) = lsc_reg.blockWidth;
    c_large.range(32, 19) = lsc_reg.blockWidth_1;
    c_large.range(42, 33) = lsc_reg.blockHeight_1;

    c_large.range(43, 43) = yfc_reg.m_nEb;
    c_large.range(44, 44) = yfc_reg.yuvpattern;
    c_large.range(56, 45) = rawdns_reg.invksigma2;

    cmc_gb_yfc_number.range(63, 0) = c_small;
    cmc_gb_yfc_number.range(127, 64) = c_large;
    config[3] = cmc_gb_yfc_number;

    config_t gb_crop_number = 0;
    ap_uint<64> lc_small = 0;
    ap_uint<64> lc_large = 0;
    lc_small.range(0, 0) = crop_reg.m_nEb;
    lc_small.range(13, 1) = crop_reg.upper_left_x;
    lc_small.range(26, 14) = crop_reg.upper_left_y;
    lc_small.range(39, 27) = crop_reg.lower_right_x;
    lc_small.range(52, 40) = crop_reg.lower_right_y;

    lc_large.range(0, 0) = gb_reg.eb;
    lc_large.range(4, 1) = gb_reg.win_size;
    lc_large.range(8, 5) = gb_reg.Lbound;
    lc_large.range(14, 9) = gb_reg.Hbound;
    lc_large.range(24, 15) = gb_reg.threhold;
    lc_large.range(25, 25) = ee_reg.eb;
    lc_large.range(31, 26) = ee_reg.coeff;
    lc_large.range(32, 32) = dpc_reg.eb;
    lc_large.range(43, 33) = dpc_reg.th_w;
    lc_large.range(54, 44) = dpc_reg.th_b;
    lc_large.range(55, 55) = scale_reg.m_nEb;
    lc_large.range(57, 56) = scale_reg.yuvpattern;
    lc_large.range(62, 58) = scale_reg.times;

    gb_crop_number.range(63, 0) = lc_small;
    gb_crop_number.range(127, 64) = lc_large;
    config[4] = gb_crop_number;

    config_t yuvdns_number = 0;
    ap_uint<64> yd_small = 0;
    ap_uint<64> yd_large = 0;
    yd_small.range(0, 0) = yuvdns_reg.eb;
    yd_small.range(14, 1) = yuvdns_reg.ysigma2;
    yd_small.range(24, 15) = yuvdns_reg.yinvsigma2;
    yd_small.range(38, 25) = yuvdns_reg.uvsigma2;
    yd_small.range(48, 39) = yuvdns_reg.uvinvsigma2;
    yd_small.range(52, 49) = yuvdns_reg.yfilt;
    yd_small.range(56, 53) = yuvdns_reg.uvfilt;

    yd_large.range(4, 0) = yuvdns_reg.yinvfilt;
    yd_large.range(9, 5) = yuvdns_reg.uvinvfilt;
    yd_large.range(23,10) = yuvdns_reg.yH2;
    yd_large.range(41,24) = yuvdns_reg.yinvH2;

    yuvdns_number.range(63, 0) = yd_small;
    yuvdns_number.range(127, 64) = yd_large;
    config[5] = yuvdns_number;

    config_t yuvdns2_number = 0;
    ap_uint<64> yd2_small = 0;
    ap_uint<64> yd2_large = 0;
    yd2_small.range(13, 0) = yuvdns_reg.uvH2;
    yd2_small.range(31, 14) = yuvdns_reg.uvinvH2;

    yuvdns2_number.range(63, 0) = yd2_small;
    yuvdns2_number.range(127, 64) = yd2_large;
    config[6] = yuvdns2_number;

    for(int i = 0; i < 132 / 6; ++i){
        tab_t tmp = 0;
        tmp.range(9, 0) = gtm_gtmTab[i*6+0];
        tmp.range(19, 10) = gtm_gtmTab[i*6+1];
        tmp.range(29, 20) = gtm_gtmTab[i*6+2];
        tmp.range(39, 30) = gtm_gtmTab[i*6+3];
        tmp.range(49, 40) = gtm_gtmTab[i*6+4];
        tmp.range(59, 50) = gtm_gtmTab[i*6+5];
        arg_config[i+224] = tmp;
    }

    for(int i = 0; i < 224 / 4; ++i){
        tab_t tmp = 0;
        tmp.range(12,0) = lsc_rgainTab[i*4+0];
        tmp.range(25,13) = lsc_rgainTab[i*4+1];
        tmp.range(38,26) = lsc_rgainTab[i*4+2];
        tmp.range(51,39) = lsc_rgainTab[i*4+3];
        arg_config[i] = tmp;
    }

    for(int i = 0; i < 224 / 4; ++i){
        tab_t tmp = 0;
        tmp.range(12,0) = lsc_grgainTab[i*4+0];
        tmp.range(25,13) = lsc_grgainTab[i*4+1];
        tmp.range(38,26) = lsc_grgainTab[i*4+2];
        tmp.range(51,39) = lsc_grgainTab[i*4+3];
        arg_config[i+56] = tmp;
    }

    for(int i = 0; i < 224 / 4; ++i){
        tab_t tmp = 0;
        tmp.range(12,0) = lsc_gbgainTab[i*4+0];
        tmp.range(25,13) = lsc_gbgainTab[i*4+1];
        tmp.range(38,26) = lsc_gbgainTab[i*4+2];
        tmp.range(51,39) = lsc_gbgainTab[i*4+3];
        arg_config[i+112] = tmp;
    }

    for(int i = 0; i < 224 / 4; ++i){
        tab_t tmp = 0;
        tmp.range(12,0) = lsc_bgainTab[i*4+0];
        tmp.range(25,13) = lsc_bgainTab[i*4+1];
        tmp.range(38,26) = lsc_bgainTab[i*4+2];
        tmp.range(51,39) = lsc_bgainTab[i*4+3];
        arg_config[i+168] = tmp;
    }

    arg_config[246].range(15,0) = m_nGain[0];
    arg_config[246].range(31,16) = m_nGain[1];
    arg_config[246].range(47,32) = m_nGain[2];
    arg_config[246].range(63,48) = m_nGain[3];
    arg_config[247].range(15,0) = m_nGain[4];
    arg_config[247].range(31,16) = m_nGain[5];
    arg_config[247].range(47,32) = m_nGain[6];
    arg_config[247].range(63,48) = m_nGain[7];
    arg_config[248].range(15,0) = m_nGain[8];
    arg_config[248].range(31,16) = m_nGain[9];
    arg_config[248].range(47,32) = m_nGain[10];
    arg_config[248].range(63,48) = m_nGain[11];
    arg_config[249].range(15,0) = coeff[0];
    arg_config[249].range(31,16) = coeff[1];
    arg_config[249].range(47,32) = coeff[2];
    arg_config[249].range(63,48) = coeff[3];
    arg_config[250].range(15,0) = coeff[4];
    arg_config[250].range(31,16) = coeff[5];
    arg_config[250].range(47,32) = coeff[6];
    arg_config[250].range(63,48) = coeff[7];
    arg_config[251].range(15,0) = coeff[8];
    arg_config[251].range(31,16) = coeff[9];
    arg_config[251].range(47,32) = coeff[10];
    arg_config[251].range(63,48) = coeff[11];

    for(int i = 0; i < 7; ++i){
        arg_config[i*2 + 252] = config[i].range(63,0);
        arg_config[i*2 + 253] = config[i].range(127,64);
    }
}


template<typename T>
void load_img(std::vector<T, aligned_allocator<T> >& img_vec, const std::string file_name, int len){
    FILE* fp = fopen(file_name.c_str(), "r");
    assert(fp != NULL);
    fread(img_vec.data(), sizeof(T), len, fp);
    fclose(fp);
}

template<typename T>
void write_img(const std::vector<T, aligned_allocator<T> >& img_vec, const std::string file_name, int len){
    FILE* fp = fopen(file_name.c_str(), "w");
    assert(fp != NULL);
    fwrite(img_vec.data(), sizeof(T), len, fp);
    fclose(fp);
}

void convert_img(std::vector<out_t, aligned_allocator<out_t> >& out_vec,
                 std::vector<img_t, aligned_allocator<img_t> >& cvt_vec, int len){
    for (int x = 0; x < len; ++x) {
        out_t pixel = out_vec[x];
        img_t y_o = pixel >> 20;
        img_t u_o = (pixel >> 10) & 0x3ff;
        img_t v_o = pixel & 0x3ff;
        cvt_vec[3 * x] = y_o;
        cvt_vec[3 * x + 1] = u_o;
        cvt_vec[3 * x + 2] = v_o;
    }
    out_t gain_vec[3];
    gain_vec[0] = out_vec[len];
    gain_vec[1] = out_vec[len + 1];
    gain_vec[2] = out_vec[len + 2];
    int rgain;
    int ggain;
    int bgain;
    rgain = (4096 * gain_vec[1])/gain_vec[0];
    ggain = 4096;
    bgain = (4096 * gain_vec[1])/gain_vec[2];
    std::cout << "r_gain = " << rgain << std::endl;
    std::cout << "g_gain = " << ggain << std::endl;
    std::cout << "b_gain = " << bgain << std::endl;
}

int main(int argc, char** argv) {
    if (argc != 2) {
        std::cout << "Usage: " << argv[0] << " <XCLBIN File>" << std::endl;
        return EXIT_FAILURE;
    }

    std::string binaryFile = argv[1];
    cl_int err;
    cl::Context context;
    cl::Kernel krnl_isp_top;
    cl::CommandQueue q;
    // union_regs u;

    // config_union(u);
    // Allocate Memory in Host Memory
    // When creating a buffer with user pointer (CL_MEM_USE_HOST_PTR), under the
    // hood user ptr
    // is used if it is properly aligned. when not aligned, runtime had no choice
    // but to create
    // its own host side buffer. So it is recommended to use this allocator if
    // user wish to
    // create buffer using CL_MEM_USE_HOST_PTR to align user buffer to page
    // boundary. It will
    // ensure that user buffer is used when user create Buffer/Mem object with
    // CL_MEM_USE_HOST_PTR

    std::vector<in_t, aligned_allocator<in_t> > in_img(IMG_HEIGHT * IMG_WIDTH);
    std::vector<out_t, aligned_allocator<out_t> > out_img(CROP_HEIGHT * CROP_WIDTH + 3);
    std::vector<tab_t, aligned_allocator<tab_t> > config(266);
    std::vector<img_t, aligned_allocator<img_t> > cvrted_img(IMG_HEIGHT * IMG_WIDTH * 3);
    std::vector<img_t, aligned_allocator<img_t> > golden_img(IMG_HEIGHT * IMG_WIDTH * 3);

    // Create the test data
    load_img<in_t>(in_img, TOP_SRC1, IMG_WIDTH * IMG_HEIGHT);
    config_reg_host(config);


    // OPENCL HOST CODE AREA START
    // get_xil_devices() is a utility API which will find the xilinx
    // platforms and will return list of devices connected to Xilinx platform
    auto devices = xcl::get_xil_devices();
    // read_binary_file() is a utility API which will load the binaryFile
    // and will return the pointer to file buffer.
    auto fileBuf = xcl::read_binary_file(binaryFile);
    cl::Program::Binaries bins{{fileBuf.data(), fileBuf.size()}};
    bool valid_device = false;
    for (unsigned int i = 0; i < devices.size(); i++) {
        auto device = devices[i];
        // Creating Context and Command Queue for selected Device
        OCL_CHECK(err, context = cl::Context(device, NULL, NULL, NULL, &err));
        OCL_CHECK(err, q = cl::CommandQueue(context, device, CL_QUEUE_PROFILING_ENABLE, &err));
        std::cout << "Trying to program device[" << i << "]: " << device.getInfo<CL_DEVICE_NAME>() << std::endl;
        cl::Program program(context, {device}, bins, NULL, &err);
        if (err != CL_SUCCESS) {
            std::cout << "Failed to program device[" << i << "] with xclbin file!\n";
        } else {
            std::cout << "Device[" << i << "]: program successful!\n";
            OCL_CHECK(err, krnl_isp_top = cl::Kernel(program, "isp_top", &err));
            valid_device = true;
            break; // we break because we found a valid device
        }
    }
    if (!valid_device) {
        std::cout << "Failed to program any device found, exit!\n";
        exit(EXIT_FAILURE);
    }

    // Allocate Buffer in Global Memory
    // Buffers are allocated using CL_MEM_USE_HOST_PTR for efficient memory and
    // Device-to-host communication
    OCL_CHECK(err, cl::Buffer buffer_in(context, CL_MEM_USE_HOST_PTR | CL_MEM_READ_ONLY, IMG_HEIGHT * IMG_WIDTH * sizeof(in_t),
                                        in_img.data(), &err));
    OCL_CHECK(err, cl::Buffer buffer_out(context, CL_MEM_USE_HOST_PTR | CL_MEM_WRITE_ONLY, (CROP_HEIGHT * CROP_WIDTH + 3) * sizeof(out_t),
                                        out_img.data(), &err));
    OCL_CHECK(err, cl::Buffer buffer_config(context, CL_MEM_USE_HOST_PTR | CL_MEM_READ_ONLY, 266 * sizeof(tab_t),
                                        config.data(), &err));

    OCL_CHECK(err, err = krnl_isp_top.setArg(0, buffer_in));
    OCL_CHECK(err, err = krnl_isp_top.setArg(1, buffer_out));
    OCL_CHECK(err, err = krnl_isp_top.setArg(2, buffer_config));

    // Copy input data to device global memory
    OCL_CHECK(err, err = q.enqueueMigrateMemObjects({buffer_in, buffer_config}, 0 /* 0 means from host*/));

    OCL_CHECK(err, err = q.finish());

    unsigned long start, end, nsduration;
    cl::Event event;
    // Launch the Kernel
    // For HLS kernels global and local size is always (1,1,1). So, it is
    // recommended
    // to always use enqueueTask() for invoking HLS kernel
    OCL_CHECK(err, err = q.enqueueTask(krnl_isp_top, NULL, &event));
    OCL_CHECK(err, err = event.wait());
    end = OCL_CHECK(err, event.getProfilingInfo<CL_PROFILING_COMMAND_END>(&err));
    start = OCL_CHECK(err, event.getProfilingInfo<CL_PROFILING_COMMAND_START>(&err));
    nsduration = end - start;
    std::cout << "Running Time: " << (double)nsduration / ((double)1000000000) << " sec" << std::endl;
    // Copy Result from Device Global Memory to Host Local Memory
    OCL_CHECK(err, err = q.enqueueMigrateMemObjects({buffer_out}, CL_MIGRATE_MEM_OBJECT_HOST));
    q.finish();
    // OPENCL HOST CODE AREA END

    convert_img(out_img, cvrted_img, CROP_HEIGHT * CROP_WIDTH);

    write_img<img_t>(cvrted_img, TOP_DST1, 3 * CROP_HEIGHT * CROP_WIDTH);
    load_img<img_t>(golden_img, TOP_GODEN1, 3 * CROP_HEIGHT * CROP_WIDTH);
    // Compare the results of the Device to the simulation
    bool match = true;
    for (int i = 0; i < IMG_WIDTH * IMG_HEIGHT * 3; ++i) {
        if (cvrted_img[i] != golden_img[i]) {
            std::cout << "Error: Result mismatch" << std::endl;
            std::cout << "i = " << i << " Golden result = " << golden_img[i]
                      << " Device result = " << cvrted_img[i] << std::endl;
            std::cout << "row = "<<i/1920<<" col = "<<(i-(i/1920)*1920)/3<<std::endl;
            match = false;
            break;
        }
    }

    //std::cout << "TEST " << (match ? "PASSED" : "FAILED") << std::endl;
    return 0;
    //return (match ? EXIT_SUCCESS : EXIT_FAILURE);
}

