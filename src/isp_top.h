#ifndef _ISP_ISPTOP_H_
#define _ISP_ISPTOP_H_

#include <iomanip>
#include "top.h"
#include "tpg.h"
#include "dgain.h"
#include "lsc.h"
#include "dpc.h"
#include "awb.h"
#include "wbc.h"
#include "rawdns.h"
#include "gb.h"
#include "demosaic.h"
#include "ee.h"
#include "cmc.h"
#include "gtm.h"
#include "ltm.h"
#include "cac.h"
#include "csc.h"
#include "yfc.h"
#include "yuvdns.h"
#include "crop.h"
#include "scaledown.h"

void isp_top(stream_u12 &src, stream_u30 &dst,
             top_register top_register,
             tpg_register tpg_register,
             dgain_register dgain_register,
             lsc_register lsc_register,
             dpc_register dpc_register,
             awb_register awb_register,
             wbc_register wbc_register,
             rawdns_register rawdns_register,
             gb_register gb_register,
             demosaic_register demosaic_register,
             ee_register ee_register,
             cmc_register cmc_register,
             gtm_register gtm_register,
             ltm_register ltm_register,
             csc_register csc_register,
             yfc_register yfc_register,
             yuvdns_register yuvdns_register,
             scaledown_register scaledown_register,
             crop_register crop_register
);

#endif
