set_multi_cpu_usage -local_cpu 8
set_db messages .truncate false

# Setup library
source $env(WORK_DIR)/scripts/tool_settings_genus.tcl
source  $env(WORK_DIR)/scripts/init_libs.tcl
set_db / .library $lib_files
set_db lef_library $lef_files

# Temporay lbBuf arc disable to avoid triggering Genus combloop breaking
set_disable_timing -from A -to Y [get_db lib_cells *BUFx2_ASAP7_75t_L]

# Read design
set_db init_hdl_search_path "$env(WORK_DIR)/rtl/"
read_hdl -language sv [glob $env(WORK_DIR)/rtl/*.*v]

elaborate $env(DESIGN_NAME)
#suspend

read_sdc $env(WORK_DIR)/sdc/$env(DESIGN_NAME).sdc
#suspend


set efpga_modules {Tile* ScanConf* CLB* Alu* Cust* IOB* }
# Preserve CB/SB mux hierarchies if required. Helps with analysis/timing reports but not good for optimization.
#lappend efpga_modules "MuxNInput*"
foreach mod $efpga_modules { set_db [get_db modules $mod] .ungroup_ok false }
#change_link -instances  [get_db insts *lbBuf*] -base_cell BUFx2_ASAP7_75t_L

# Renable buffer timing acrs after case analysis takes effect
reset_disable_timing -from A -to Y [get_db lib_cells *BUFx2_ASAP7_75t_L]

time_info -stamp Done_setup
syn_generic
#suspend
time_info -stamp Done_syn_generic

syn_map
time_info -stamp Done_syn_map

syn_opt
time_info -stamp Done_syn_opt
#suspend

# Report 
write_hdl > $env(WORK_DIR)/outputs/$env(DESIGN_NAME)_syn.v
write_sdc $env(DESIGN_NAME) > $env(WORK_DIR)/outputs/$env(DESIGN_NAME)_syn.sdc
report sequential -deleted > $env(WORK_DIR)/reports/genus_seq_deleted_info.rpt
time_info -report

write_db dbs/[get_db designs .name]_syn.db

exit
