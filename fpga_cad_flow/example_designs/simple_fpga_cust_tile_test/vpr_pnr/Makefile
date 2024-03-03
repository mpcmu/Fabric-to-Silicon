#.ONESHELL:

#SHELL =? /bin/bash

VPR_RUN = vpr
VPR_RUN_GUI = vpr_gui
VPR_RUN_GUI_FP = vpr_gui_fp
GEN_FASM = genfasm
YOSYS_OUTPUTS = $(WORK_DIR)/yosys/outputs
NUM_CHAN ?= 
NUM_CHAN = --route_chan_width 80
PLACE_FILE ?= vpr_pin_place

$(VPR_RUN):
	cp $(WORK_DIR)/yosys/outputs/$(DESIGN_NAME)_syn.v . && vpr $(ARCH_FILE) $(WORK_DIR)/yosys/outputs/$(DESIGN_NAME)_syn.eblif --gen_post_synthesis_netlist on --write_rr_graph rr.xml --disp off --timing_report_detail aggregated --sdc_file fpga.sdc $(NUM_CHAN) --constant_net_method route --write_vpr_constraints out_constraints.xml --fix_clusters $(PLACE_FILE)

$(VPR_RUN_GUI):
	cp $(WORK_DIR)/yosys/outputs/$(DESIGN_NAME)_syn.v . && vpr $(ARCH_FILE) $(WORK_DIR)/yosys/outputs/$(DESIGN_NAME)_syn.eblif --gen_post_synthesis_netlist on --write_rr_graph rr.xml --disp on --timing_report_detail aggregated --sdc_file fpga.sdc $(NUM_CHAN) --constant_net_method route --write_vpr_constraints out_constraints.xml --fix_clusters $(PLACE_FILE)

$(VPR_RUN_GUI_FP):
	cp $(WORK_DIR)/yosys/outputs/$(DESIGN_NAME)_syn.v . && vpr $(ARCH_FILE) $(WORK_DIR)/yosys/outputs/$(DESIGN_NAME)_syn.eblif --gen_post_synthesis_netlist on --write_rr_graph rr.xml --disp on --timing_report_detail aggregated --sdc_file fpga.sdc $(NUM_CHAN) --constant_net_method route --fix_clusters $(PLACE_FILE)
	#cp $(WORK_DIR)/yosys/outputs/$(DESIGN_NAME)_syn.v . && vpr $(ARCH_FILE) $(WORK_DIR)/yosys/outputs/$(DESIGN_NAME)_syn.eblif --gen_post_synthesis_netlist on --write_rr_graph rr.xml --disp on --timing_report_detail aggregated --sdc_file fpga.sdc $(NUM_CHAN) --write_vpr_constraints out_constraints.xml --read_vpr_constraints $(PLACE_FILE)

$(GEN_FASM):
	python3 modify_rr.py
	/home/kmgroup/software/vtr-verilog-to-routing/build/utils/fasm/genfasm $(ARCH_FILE) $(WORK_DIR)/yosys/outputs/$(DESIGN_NAME)_syn.eblif $(NUM_CHAN) --read_rr_graph rr_fasm.xml 
	#python3 adjust_fasm.py

clean:
	rm -f *.v *.sdf *.blif *.eblif
	rm -f *.net *.place *.route
	rm -f *.rpt
	rm -f *.xml *.log *.fasm


# vpr /home/kmgroup/projects/vexriscv/hardware/efpga/efpga_xplore_s8/example_designs/gpio_test/../../vpr_arch_files/k4_N8_hybrid_fasm.xml /home/kmgroup/projects/vexriscv/hardware/efpga/efpga_xplore_s8/example_designs/gpio_test/yosys/outputs/test1_syn.eblif --gen_post_synthesis_netlist on --write_rr_graph rr.xml --disp on --timing_report_detail aggregated --sdc_file fpga.sdc --route_chan_width 108 --constant_net_method route --fix_clusters vpr_pin_place
