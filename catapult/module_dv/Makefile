
cmd = /tools/mentor/catapult/catapult_2022_1/Mgc_home/bin/catapult -p prime -file

clean:
	rm -rf Catapult* \
	rm -r catapult* \
	rm -f design* \
	rm -f catapult.log \
	rm -rf scverify \
	rm -rf verdiLog* \
	rm -f inter.fsdb \
	rm -f inter* \
	rm -f novas.conf \
	rm -f novas.rc \
	rm -f novas_dump.log \
	rm -f ucli.key
tpg:
	$(cmd) tpg.tcl &

afc:
	$(cmd) afc.tcl &

dgain:
	$(cmd) dgain.tcl &

lsc:
	$(cmd) lsc.tcl &

dpc:
	$(cmd) dpc.tcl &

rawdns:
	$(cmd) rawdns.tcl &

wbc:
	$(cmd) wbc.tcl &

gb:
	$(cmd) gb.tcl &

demosaic:
	$(cmd) demosaic.tcl &

ee:
	$(cmd) ee.tcl &

cmc:
	$(cmd) cmc.tcl &

gtm:
	$(cmd) gtm.tcl &

lut:
	$(cmd) lut.tcl &

ltm:
	$(cmd) ltm.tcl &

cac:
	$(cmd) cac.tcl &

csc:
	$(cmd) csc.tcl &

yfc:
	$(cmd) yfc.tcl &

yuvdns:
	$(cmd) yuvdns.tcl &

scaledown:
	$(cmd) scaledown.tcl &

crop:
	$(cmd) crop.tcl &

top:
	$(cmd) top.tcl &

top_multifile:
	$(cmd) top_multifile.tcl &
