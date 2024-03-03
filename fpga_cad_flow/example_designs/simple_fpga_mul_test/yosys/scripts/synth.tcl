yosys log -stdout  " >>> LOG: READING VERILOG files TOP_MODULE: $env(DESIGN_NAME)"                                                      
set vlog_files [glob $env(WORK_DIR)/inputs/*.v]                                                                           
foreach vlog_file $vlog_files {                                                                                           
	puts " >>> Reading verilog file: $vlog_file"
	yosys read_verilog $vlog_file
}
yosys hierarchy -check -top $env(DESIGN_NAME)
    
yosys log -stdout  " >>> LOG: GENERIC MAPPING"
yosys stat -width
yosys proc
yosys flatten
yosys opt_expr
yosys opt_clean
yosys check
    
yosys stat -width
#yosys opt -noff
yosys opt
yosys wreduce
yosys peepopt
yosys opt_clean
    
yosys log -stdout  " >>> LOG: OPT"
yosys stat -width
yosys alumacc
yosys share
#yosys opt -noff
yosys opt
yosys stat -width
#yosys fsm  
yosys memory_map
#yosys opt -full -noff
yosys opt -full
yosys techmap
yosys dfflegalize -cell \$_DFF_P_ x
    
yosys log -stdout  " >>> LOG: LUT MAPPING"
yosys stat -width
yosys clean
yosys opt_lut
yosys abc -lut "$env(LUT_TYPES)"
#yosys opt -noff
yosys opt 
yosys flatten
yosys techmap -map scripts/async_flop.v
yosys opt_clean -purge
yosys opt_lut
yosys stat -width

set outputs_dir "$env(WORK_DIR)/yosys/outputs"
yosys log -stdout  " >>> LOG: WRITING VERILOG $outputs_dir/$env(DESIGN_NAME)_syn.v"
yosys write_verilog $outputs_dir/$env(DESIGN_NAME)_syn.v
yosys log -stdout  " >>> LOG: WRITING BLIF $outputs_dir/$env(DESIGN_NAME)_syn.blif"
yosys write_blif -param -cname -conn $outputs_dir/$env(DESIGN_NAME)_syn.eblif
