set_part {xcvu9p-fsgd2104-2-e}
create_clock -period 20 -name default
csim_design
csynth_design
cosim_design
export_design -format ip_catalog
exit
