#include "../src/top.h"
#include "../src/tpg.h"
#include "../src/dgain.h"
#include "../src/lsc.h"
#include "../src/dpc.h"
#include "../src/rawdns.h"
#include "../src/awb.h"
#include "../src/wbc.h"
#include "../src/gb.h"
#include "../src/demosaic.h"
#include "../src/ee.h"
#include "../src/cmc.h"
#include "../src/gtm.h"
#include "../src/ltm.h"
#include "../src/cac.h"
#include "../src/csc.h"
#include "../src/yfc.h"
#include "../src/yuvdns.h"
#include "../src/scaledown.h"
#include "../src/crop.h"
#include "../src/isp_top.h"




#define TOP_SRC1 "../../../../../tv/input.raw"
#define TOP_DST1 "../../../../../tv/top_hls_output.yuv"
#define TOP_GOLDEN1 "../../../../../tv/output.yuv"



int main(int argc, char** argv)
{
    top_register       topParam;

    tpg_register       tpg_param;
    dgain_register     dgain_param;
    lsc_register       lsc_param;
    dpc_register       dpc_param;
    rawdns_register    rawdns_param;
    awb_register       awb_param;
    wbc_register       wbc_param;
    gb_register        gb_param;
    demosaic_register  demosaic_param;
    ee_register        ee_param;
    cmc_register       cmc_param;
    gtm_register       gtm_param;
    ltm_register       ltm_param;
    cac_register       cac_param;
    csc_register       csc_param;
    yfc_register       yfc_param;
    yuvdns_register    yuvdns_param;
    scaledown_register scaledown_param;
    crop_register      crop_param;

    stream_u12 src;
    uint16   dst_y[640*480];
    uint16    dst_u[640*480];
    uint16    dst_v[640*480];
    //stream_u10 dst_y;
    //stream_u10 dst_u;
    //stream_u10 dst_v;

    int x;
    uint10 y_o;
    uint10 u_o;
    uint10 v_o;
    uint12 srcdata;
    uint30 dstdata;

    printf("\tTest for ISP top module!\n");
    memset(&topParam, 0, sizeof(top_register));
    memset(&tpg_param, 0, sizeof(tpg_register));
    memset(&dgain_param, 0, sizeof(dgain_register));
    memset(&lsc_param, 0, sizeof(lsc_register));
    memset(&dpc_param, 0, sizeof(dpc_register));
    memset(&rawdns_param, 0, sizeof(rawdns_register));
    memset(&awb_param, 0, sizeof(awb_register));
    memset(&wbc_param, 0, sizeof(wbc_register));
    memset(&gb_param, 0, sizeof(gb_register));
    memset(&demosaic_param, 0, sizeof(demosaic_register));
    memset(&ee_param, 0, sizeof(ee_register));
    memset(&cmc_param, 0, sizeof(cmc_register));
    memset(&gtm_param, 0, sizeof(gtm_register));
    memset(&ltm_param, 0, sizeof(ltm_register));
    memset(&cac_param, 0, sizeof(cac_register));
    memset(&csc_param, 0, sizeof(csc_register));
    memset(&yfc_param, 0, sizeof(yfc_register));
    memset(&yuvdns_param, 0, sizeof(yuvdns_register));
    memset(&scaledown_param, 0, sizeof(scaledown_register));
    memset(&crop_param, 0, sizeof(crop_register));


    /********* top param *********/
    topParam.frameWidth = 640;
    topParam.frameHeight = 480;
    topParam.imgPattern=3;
    topParam.blc = 0;
    /********* tpg param *********/
    tpg_param.m_bTPG_en=0;
    /********* dgain param *********/
    dgain_param.m_nEb = 1;
    dgain_param.m_nR= 0x04000;
    dgain_param.m_nGr = 0x04000;
    dgain_param.m_nGb = 0x04000;
    dgain_param.m_nB = 0x04000;
    /********* lsc param *********/
    lsc_param.eb = 1;
    uint13 rgain[13*17] =    {2776,2684,2728,2690,2640,2580,2522,2474,2504,2550,2610,2682,2778,2862,2970,2920,3356,2759,2687,2690,2633,2555,2497,2429,2395,2397,2449,2519,2625,2719,2813,2872,2956,3108,2825,2707,2678,2603,2521,2464,2376,2344,2333,2399,2469,2587,2695,2787,2891,2952,3129,2846,2720,2658,2574,2496,2418,2332,2254,2242,2318,2428,2552,2654,2764,2878,2978,3138,2862,2735,2665,2568,2481,2385,2268,2155,2123,2218,2364,2533,2645,2784,2893,2985,3189,2897,2767,2679,2577,2485,2379,2216,2099,2061,2165,2323,2534,2653,2801,2911,3027,3216,2952,2808,2694,2642,2506,2392,2226,2100,2074,2174,2354,2566,2696,2850,2962,3090,3272,3010,2864,2795,2691,2578,2473,2323,2229,2205,2307,2453,2651,2781,2917,3046,3166,3357,3091,2933,2871,2780,2678,2587,2469,2391,2384,2479,2599,2740,2881,3014,3134,3242,3427,3172,3024,2962,2886,2802,2696,2614,2574,2580,2662,2746,2882,2998,3132,3240,3336,3478,3201,3095,3057,2999,2915,2829,2751,2715,2728,2799,2891,3027,3140,3255,3327,3390,3557,3218,3139,3128,3080,3029,2955,2887,2856,2869,2939,3013,3143,3252,3349,3409,3411,3654,3428,3176,3238,3210,3178,3112,3070,3052,3088,3112,3206,3324,3396,3466,3532,3542,4158 };
    uint13 grgain[13*17] =   {2718,2620,2664,2622,2570,2510,2458,2434,2440,2480,2520,2598,2686,2748,2836,2808,3224,2683,2631,2631,2579,2503,2447,2380,2357,2351,2390,2450,2541,2626,2715,2768,2831,2957,2743,2657,2608,2546,2466,2406,2335,2297,2291,2338,2401,2498,2593,2695,2776,2839,2959,2774,2664,2596,2516,2446,2360,2290,2226,2204,2270,2364,2472,2572,2674,2778,2840,2996,2790,2671,2595,2513,2427,2335,2229,2145,2111,2187,2310,2457,2557,2672,2779,2864,3022,2818,2695,2607,2529,2426,2332,2197,2098,2059,2143,2278,2456,2561,2691,2792,2891,3057,2850,2730,2636,2554,2446,2352,2208,2100,2074,2150,2300,2476,2604,2722,2832,2938,3092,2901,2786,2699,2613,2507,2411,2291,2205,2185,2267,2386,2551,2669,2795,2903,3005,3159,2961,2853,2773,2688,2597,2507,2403,2349,2339,2410,2514,2637,2755,2881,2983,3069,3225,3022,2928,2862,2784,2698,2610,2524,2492,2500,2562,2634,2752,2846,2978,3060,3150,3274,3061,2961,2932,2880,2791,2722,2652,2613,2621,2683,2755,2864,2963,3068,3149,3202,3347,3072,3007,2979,2947,2899,2838,2767,2745,2752,2803,2869,2977,3073,3156,3216,3234,3441,3254,3060,3082,3054,3016,2980,2926,2902,2898,2954,3034,3128,3194,3260,3292,3338,3810 };
    uint13 gbgain[13*17] =   {2708,2594,2654,2610,2554,2502,2448,2424,2426,2466,2520,2594,2678,2748,2828,2796,3186,2681,2626,2618,2571,2498,2436,2377,2350,2347,2380,2442,2533,2617,2705,2761,2817,2951,2734,2658,2601,2536,2459,2400,2326,2294,2284,2331,2397,2492,2584,2684,2769,2821,2963,2762,2658,2590,2518,2436,2360,2282,2220,2198,2272,2356,2472,2564,2666,2768,2848,2980,2787,2672,2586,2504,2423,2335,2227,2139,2107,2187,2311,2449,2556,2670,2776,2857,3013,2813,2696,2601,2523,2427,2331,2197,2093,2059,2143,2279,2456,2563,2687,2793,2891,3045,2844,2726,2644,2550,2446,2350,2210,2100,2076,2156,2306,2478,2600,2728,2830,2942,3098,2907,2789,2703,2616,2507,2417,2296,2203,2193,2275,2391,2558,2665,2788,2906,3005,3150,2969,2857,2785,2693,2598,2514,2412,2350,2348,2417,2517,2645,2755,2887,2983,3067,3223,3036,2934,2872,2796,2698,2622,2536,2504,2502,2578,2642,2758,2856,2978,3072,3148,3282,3063,2971,2939,2887,2805,2733,2663,2619,2635,2693,2758,2871,2971,3078,3155,3198,3340,3081,3025,2988,2961,2915,2845,2784,2755,2758,2822,2877,2988,3081,3171,3219,3235,3437,3276,3062,3078,3060,3018,2992,2926,2916,2920,2968,3056,3130,3202,3278,3290,3332,3826 };
    uint13 bgain[13*17] =    {2760,2630,2702,2642,2588,2518,2466,2414,2442,2476,2522,2608,2696,2784,2876,2852,3314,2732,2645,2639,2591,2511,2459,2387,2351,2344,2384,2449,2533,2645,2730,2789,2851,3005,2797,2664,2622,2553,2468,2411,2334,2295,2279,2328,2393,2505,2600,2709,2801,2873,3027,2814,2666,2614,2530,2450,2366,2288,2222,2196,2262,2350,2464,2582,2706,2778,2870,3048,2834,2673,2604,2518,2431,2340,2229,2143,2106,2174,2308,2451,2564,2684,2792,2879,3059,2858,2698,2620,2527,2421,2331,2199,2103,2061,2138,2271,2451,2564,2705,2813,2915,3081,2878,2732,2640,2562,2448,2346,2212,2106,2082,2148,2290,2478,2602,2732,2850,2976,3126,2939,2794,2717,2621,2505,2414,2295,2210,2189,2268,2379,2545,2671,2806,2923,3026,3213,3009,2858,2801,2697,2607,2511,2404,2351,2335,2412,2514,2644,2765,2895,3004,3099,3277,3060,2946,2888,2804,2702,2628,2538,2496,2494,2564,2648,2766,2868,3000,3096,3188,3354,3119,2987,2965,2899,2815,2739,2657,2627,2625,2683,2767,2884,2999,3099,3183,3259,3396,3135,3042,3023,2992,2926,2857,2791,2753,2756,2818,2891,3009,3104,3202,3265,3296,3528,3338,3090,3138,3096,3058,3020,2932,2936,2926,2984,3080,3158,3258,3322,3348,3392,3908 };

    for(uint10 i =0;i<(13*17);i++)
    {
        lsc_param.rGain[i] = rgain[i];
        lsc_param.GrGain[i] = grgain[i];
        lsc_param.GbGain[i] = gbgain[i];
        lsc_param.bGain[i] = bgain[i];
    }
    lsc_param.blockHeight = (topParam.frameHeight - 1) / 12 + 1;
    lsc_param.blockWidth =  (topParam.frameWidth - 1)  / 16 + 1;
    lsc_param.blockHeight_1 = 819;
    lsc_param.blockWidth_1  = 13107;
    /********* dpc param *********/
    dpc_param.eb = 1;
    dpc_param.th_w = 300;
    dpc_param.th_b = 300;
    /********* rawdns param *********/
    rawdns_param.eb = 1;
    rawdns_param.sigma = 30;
    rawdns_param.Filterpara = 50;
    rawdns_param.invksigma2 = 119;//1/34<<12;
    /********* awb param *********/
    awb_param.m_nEb = 0;
    awb_param.coeff = 1;
    /********* wbc param *********/
    wbc_param.m_nEb = 1;
    wbc_param.m_nR= 4821;//4111;
    wbc_param.m_nGr = 4096;//4096;
    wbc_param.m_nGb = 4096;//4096;
    wbc_param.m_nB = 6486;//4088;
    /********* gb param *********/
    gb_param.eb = 1;
    gb_param.win_size = 7;
    gb_param.Lbound = 4;
    gb_param.Hbound = 20;
    gb_param.threhold = 683;
    /********* demosaic param *********/
    demosaic_param.eb = 1;
    /********* ee param *********/
    ee_param.eb = 1;
    ee_param.coeff = 30;
    /********* cmc param *********/
    cmc_param.m_nEb = 1;
    cmc_param.m_bDiscardH = 0;
    cmc_param.m_nGain[0] = 6709;
    cmc_param.m_nGain[1] = -2591;
    cmc_param.m_nGain[2] = -22;
    cmc_param.m_nGain[3] = 0;
    cmc_param.m_nGain[4] = -632;
    cmc_param.m_nGain[5] = 5336;
    cmc_param.m_nGain[6] = -607;
    cmc_param.m_nGain[7] = 0;
    cmc_param.m_nGain[8] = 156;
    cmc_param.m_nGain[9] = -2970;
    cmc_param.m_nGain[10] = 6912;
    cmc_param.m_nGain[11] = 0;
    /********* gtm param *********/
    gtm_param.eb = 1;
    gtm_param.m_bDitheringEnable = 1;
    float gtm_gamma = 1.2;
    uint10 tab[129] =
        {0, 20, 40, 64, 84, 108, 128, 148, 168, 196, 220, 244, 268, 296, 320, 344,
        368, 388, 408, 428, 448, 468, 488, 504, 524, 540, 556, 568, 584, 596, 608, 616,
        628, 636, 648, 656, 664, 672, 680, 688, 696, 704, 708, 716, 724, 728, 736, 740,
        748, 752, 760, 764, 772, 776, 784, 788, 796, 800, 804, 812, 816, 820, 824, 828,
        832, 836, 840, 844, 848, 852, 856, 860, 864, 868, 868, 872, 876, 880, 880, 884,
        888, 892, 892, 896, 900, 904, 904, 908, 912, 916, 916, 920, 924, 928, 928, 932,
        936, 940, 940, 944, 948, 948, 952, 952, 956, 960, 960, 964, 968, 972, 972, 976,
        980, 980, 984, 984, 988, 992, 992, 996, 1000, 1000, 1004, 1004, 1008, 1012, 1012, 1016, 1023};

    if(gtm_gamma != 0.0) {
        float curve_x[129];
        curve_x[0]=0;
        for (int i = 1; i < 129; i++)
        {
            curve_x[i] = curve_x[i-1]+ 0.0078125;
        };
        for (int i = 0; i < 129 ;i++)
        {
            tab[i] = (uint10)(((float)pow(curve_x[i],gtm_gamma))*1023);
        };
    }

    for (x=0;x<129;x++){
        gtm_param.gtmTab[x] = tab[x];
    }
    /********* ltm param *********/
    ltm_param.m_nEb=1;
    ltm_param.contrast=3401;
    ltm_param.ratio=38;
    /********* cac param *********/
    cac_param.eb = 1;
    cac_param.t_transient = 7000;
    cac_param.t_edge = 4000;
    /********* csc param *********/
    csc_param.m_nEb = 1;
    csc_param.coeff[0] = 308;
    csc_param.coeff[1] = 600;
    csc_param.coeff[2] = 116;
    csc_param.coeff[3] = 0;
    csc_param.coeff[4] = -172;
    csc_param.coeff[5] = -340;
    csc_param.coeff[6] = 512;
    csc_param.coeff[7] = 512;
    csc_param.coeff[8] = 512;
    csc_param.coeff[9] = -428;
    csc_param.coeff[10] = -84;
    csc_param.coeff[11] = 512;
    /********* yfc param *********/
    yfc_param.m_nEb = 0;
    /********* yuvdns param *********/
    yuvdns_param.eb = 1;
    yuvdns_param.ysigma2 = 3600;
    yuvdns_param.yinvsigma2 = 0x4;// (1 / sigma2) << 14
    yuvdns_param.uvsigma2 = 6400;
    yuvdns_param.uvinvsigma2 = 0x2;
    yuvdns_param.yfilt = 0x6;// 0.4 << 6
    yuvdns_param.uvfilt = 0x6;// 0.4 << 6
    yuvdns_param.yinvfilt = 0x5; // (1 / yfilt) << 1
    yuvdns_param.uvinvfilt = 0x5; // (1 / uvfilt) << 1
    yuvdns_param.yH2 = (yuvdns_param.yfilt * yuvdns_param.yfilt * yuvdns_param.ysigma2 + 255) >> 8;
    yuvdns_param.yinvH2 = (yuvdns_param.yinvfilt * yuvdns_param.yinvfilt * yuvdns_param.yinvsigma2 + 3) >> 2;
    yuvdns_param.uvH2 = (yuvdns_param.uvfilt * yuvdns_param.uvfilt * yuvdns_param.uvsigma2 + 255) >> 8;
    yuvdns_param.uvinvH2 = (yuvdns_param.uvinvfilt * yuvdns_param.uvinvfilt * yuvdns_param.uvinvsigma2 + 3) >> 2;
    /********* scaledown param *********/
    scaledown_param.m_nEb = 0;
    /********* crop param *********/
    crop_param.m_nEb = 1;
    crop_param.upper_left_x = 0;
    crop_param.upper_left_y = 0;
    crop_param.lower_right_x = 640;
    crop_param.lower_right_y = 480;
    



    int output_width = crop_param.lower_right_x - crop_param.upper_left_x;
    int output_height = crop_param.lower_right_y - crop_param.upper_left_y;
    uint16_t* frameIn = (uint16_t*)malloc((int)topParam.frameWidth * (int)topParam.frameHeight * sizeof(uint16_t));
    uint16_t* frameGolden = (uint16_t*)malloc(3 * output_width * output_height * sizeof(uint16_t));
    uint16_t* frameOut = (uint16_t*)malloc(3 * output_width * output_height * sizeof(uint16_t));

    //In
    FILE *fp_r1 = fopen(TOP_SRC1, "r");
    if(!fp_r1){
        printf("Can not open input file!\n");
    }

    for (x = 0; x < topParam.frameWidth*topParam.frameHeight; x++) {
        fread(&frameIn[x], sizeof(uint16_t), 1, fp_r1);
        srcdata = (uint12)frameIn[x];
        src.write(srcdata);
    }
    printf("\tInit done!\n");

    //Golden
    FILE *fp_g1 = fopen(TOP_GOLDEN1, "r");
    if(!fp_g1){
        printf("Can not open golden file!\n");
    }

    for (x = 0; x < 3*output_width*output_height; x++) {
        fread(&frameGolden[x], sizeof(uint16_t), 1, fp_g1);
    }
    printf("\tEnvironment set up!\n");

    //Execution
    isp_top(src, dst_y, dst_u, dst_v, 
            topParam, 
            tpg_param, 
            dgain_param, 
            lsc_param, 
            dpc_param,
            rawdns_param,
            awb_param,
            wbc_param, 
            gb_param, 
            demosaic_param, 
            ee_param,
            cmc_param, 
            gtm_param, 
            ltm_param, 
            cac_param,
            csc_param, 
            yfc_param,
            yuvdns_param,
            scaledown_param, 
            crop_param);

    printf("\tExecution completed!\n");
    //printf("\tY component size:%d\n",dst_y.size());
    //printf("\tU component size:%d\n",dst_u.size());
    //printf("\tV component size:%d\n",dst_v.size());

    //Out
    FILE *fp_w1 = fopen(TOP_DST1, "w");
    if(!fp_w1){
        printf("\tCan not open write back file!\n");
    }

    for (x = 0; x < 3 * output_width * output_height; x++) {
        if(x < output_width * output_height)
        {
            y_o = dst_y[x%(output_width*output_height)];//dst_y.read();
            frameOut[x] = y_o;
        }
        else if(x < 2 * output_width * output_height)
        {
            u_o =  dst_u[x%(output_width*output_height)];//dst_u.read();
            frameOut[x] = u_o;
        }
        else
        {
            v_o =  dst_v[x%(output_width*output_height)];//dst_v.read();
            frameOut[x] = v_o;
        }
    }

    fwrite(frameOut, sizeof(uint16_t), (3 * output_width * output_height), fp_w1);

    //Checker
    for (x = 0; x < 3 * output_width * output_height; x++) {
        if(frameGolden[x] != frameOut[x]) {
            printf("\t\tFirst mismatch in pixel %d, channel %d!\n", x/3, x%3);
            cout << "Golden = " << setbase(16) << frameGolden[x] << endl;
            cout << "result = " << setbase(16) << frameOut[x] << endl;
            exit(0);
        }
    }
    printf("\tTest passed!\n");

    fclose(fp_r1);
    fclose(fp_g1);
    fclose(fp_w1);

    return 0;
}

