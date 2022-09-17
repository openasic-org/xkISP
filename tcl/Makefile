#make file for module level verification

all: tpg dgain lsc dpc rawdns awb wbc gb demosaic ee cmc ltm gtm cac csc yfc yuvdns scaledown crop

#before 2021.1 vivado_hls
#after 2021.1 vitis_hls
cmd = vitis_hls

clean:
	rm -rf tpg dgain lsc dpc rawdns awb wbc gb demosaic ee cmc ltm gtm cac csc yfc yuvdns scaledown crop

tpg:
	$(cmd) -f tpg.tcl

dgain:
	$(cmd) -f dgain.tcl

lsc:
	$(cmd) -f lsc.tcl

dpc:
	$(cmd) -f dpc.tcl

rawdns:
	$(cmd) -f rawdns.tcl

awb:
	$(cmd) -f awb.tcl

wbc:
	$(cmd) -f wbc.tcl

gb:
	$(cmd) -f gb.tcl

demosaic:
	$(cmd) -f demosaic.tcl

ee:
	$(cmd) -f ee.tcl

cmc:
	$(cmd) -f cmc.tcl

ltm:
	$(cmd) -f ltm.tcl

gtm:
	$(cmd) -f gtm.tcl

cac:
	$(cmd) -f cac.tcl

csc:
	$(cmd) -f csc.tcl

yfc:
	$(cmd) -f yfc.tcl

yuvdns:
	$(cmd) -f yuvdns.tcl

scaledown:
	$(cmd) -f scaledown.tcl

crop:
	$(cmd) -f crop.tcl
