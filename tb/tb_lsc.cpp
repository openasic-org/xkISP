#include "../src/lsc.h"

int main(int argc, char** argv)
{
    top_register top_param;
    lsc_register lsc_param;
    hls::stream<uint12> src;
    hls::stream<uint12> dst;
    int x;

    printf("\tTest for ISP lsc module!\n");
    memset(&top_param, 0, sizeof(top_register));
    memset(&lsc_param, 0, sizeof(lsc_register));
    top_param.frameWidth = 640;
    top_param.frameHeight = 480;
    lsc_param.eb = 1;
    top_param.imgPattern = 3;
    top_param.blc = 0;

    uint16_t* frameIn = (uint16_t*)malloc(top_param.frameWidth * top_param.frameHeight * sizeof(uint16_t));
    uint16_t* frameGolden = (uint16_t*)malloc(top_param.frameWidth * top_param.frameHeight * sizeof(uint16_t));
    uint16_t* frameOut = (uint16_t*)malloc(top_param.frameWidth * top_param.frameHeight * sizeof(uint16_t));

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
    lsc_param.blockHeight = (top_param.frameHeight - 1) / 12 + 1;
    lsc_param.blockWidth =  (top_param.frameWidth - 1)  / 16 + 1;
    lsc_param.blockHeight_1 = 819;
    lsc_param.blockWidth_1  = 13107;
    //In
    FILE *fp_r1 = fopen(LSC_SRC1, "r");
    if(!fp_r1){
        printf("Can not input file!\n");
    }

    for (x = 0; x < top_param.frameWidth*top_param.frameHeight; x++) {
        fread(&frameIn[x], sizeof(uint16_t), 1, fp_r1);
        uint12 srcdata = (uint12)frameIn[x];
        src << srcdata;
    }
    printf("\tInit done!\n");

    //Golden
    FILE *fp_g1 = fopen(LSC_GOLDEN1, "r");
    if(!fp_g1){
        printf("Can not open golden file!\n");
    }

    for (x = 0; x < top_param.frameWidth*top_param.frameHeight; x++) {
        fread(&frameGolden[x], sizeof(uint16_t), 1, fp_g1);
    }
    printf("\tEnvironment set up!\n");

    //Execution
    lsc(top_param,lsc_param,src,dst);
    printf("\tExecution completed!\n");

    //Out
    FILE *fp_w1 = fopen(LSC_DST1, "w");
    if(!fp_w1){
        printf("\tCan not open write back file!\n");
    }

    for (x = 0; x < top_param.frameWidth*top_param.frameHeight; x++) {
        uint12 dstdata;
        dst >> dstdata;
        frameOut[x] = dstdata;
    }

    fwrite(frameOut, sizeof(uint16_t), (top_param.frameWidth * top_param.frameHeight), fp_w1);

    //Checker
    for (x = 0; x < top_param.frameWidth*top_param.frameHeight; x++) {
        int tmp = frameGolden[x] - frameOut[x];
        if(tmp != 0) {
            printf("\t\tFirst mismatch in pixel %d!\n", x);
            printf("\t\tGolden = %d, result = %d!\n", frameGolden[x], frameOut[x]);
            exit(0);
        }
    }
    printf("\tTest passed!\n");

    fclose(fp_r1);
    fclose(fp_g1);
    fclose(fp_w1);
}
