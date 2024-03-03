#######################################################
#                                                     
#  Innovus Command Logging File                     
#  Created on Sun Mar  3 07:02:53 2024                
#                                                     
#######################################################

#@(#)CDS: Innovus v21.13-s100_1 (64bit) 03/04/2022 14:32 (Linux 3.10.0-693.el7.x86_64)
#@(#)CDS: NanoRoute 21.13-s100_1 NR220220-0140/21_13-UB (database version 18.20.572) {superthreading v2.17}
#@(#)CDS: AAE 21.13-s034 (64bit) 03/04/2022 (Linux 3.10.0-693.el7.x86_64)
#@(#)CDS: CTE 21.13-s042_1 () Mar  4 2022 08:38:36 ( )
#@(#)CDS: SYNTECH 21.13-s014_1 () Feb 17 2022 23:50:03 ( )
#@(#)CDS: CPE v21.13-s074
#@(#)CDS: IQuantus/TQuantus 20.1.2-s656 (64bit) Tue Nov 9 23:11:16 PST 2021 (Linux 2.6.32-431.11.2.el6.x86_64)

#@ source scripts/invs_stylus.tcl
#@ Begin verbose source (pre): source scripts/invs_stylus.tcl
set_multi_cpu_usage -local_cpu 16
set_db init_design_uniquify 1
#@ source $env(WORK_DIR)/scripts/init_libs.tcl
#@ Begin verbose source /afs/ece/project/km_group/.vol9/asap7/fpga_demos/simple_fpga_cust_mul/scripts/init_libs.tcl (pre)
set vtlist [list RVT LVT]
set corners [list TT]
set lef_files [list $env(ASIC_PATH)/techlef_misc/asap7_tech_4x_201209_mod.lef\
                    $env(ASIC_PATH)/LEF/scaled/asap7sc7p5t_28_R_4x_220121a.lef\
                    $env(ASIC_PATH)/LEF/scaled/asap7sc7p5t_28_SRAM_4x_220121a.lef\
                    $env(ASIC_PATH)/LEF/scaled/asap7sc7p5t_28_L_4x_220121a.lef\
                    $env(ASIC_PATH)/LEF/scaled/asap7sc7p5t_28_SL_4x_220121a.lef]
set lib_files [list]
foreach corner $corners {
    foreach vt $vtlist {
        lappend lib_files {*}[glob $env(ASIC_PATH)/LIB/NLDM/*_${vt}_${corner}_nldm*.lib]
    }
}
#@ End verbose source /afs/ece/project/km_group/.vol9/asap7/fpga_demos/simple_fpga_cust_mul/scripts/init_libs.tcl
set_db init_netlist_files "$env(WORK_DIR)/outputs/$env(DESIGN_NAME)_syn.v"
set_db init_design_netlist_type {Verilog}
set_db init_lef_files $lef_files
set_db extract_rc_shrink_factor {1.0}
set_db init_power_nets {VDD}
set_db init_ground_nets {VSS}
set_db init_mmmc_files $env(WORK_DIR)/scripts/mmmc.tcl
read_mmmc "$env(WORK_DIR)/scripts/mmmc.tcl"
#@ Begin verbose source /afs/ece/project/km_group/.vol9/asap7/fpga_demos/simple_fpga_cust_mul/scripts/mmmc.tcl (pre)
create_constraint_mode -name func -sdc_files $env(WORK_DIR)/outputs/$env(DESIGN_NAME)_syn.sdc
create_library_set -name {tt_0p7v_25c} -timing $lib_files
create_timing_condition -name tt_0p7v_25c_TYP -library_sets { tt_0p7v_25c }
create_rc_corner -name rc_typ_25 -qrc_tech $env(ASIC_PATH)/qrc/qrcTechFile_typ03_scaled4xV06 -T 25
create_delay_corner -name tt_0p7v_25c_typ_25c -timing_condition {tt_0p7v_25c_TYP} -rc_corner {rc_typ_25}
create_analysis_view -name func_typ -constraint_mode {func} -delay_corner {tt_0p7v_25c_typ_25c}
set_analysis_view -setup {func_typ} -hold {func_typ}
#@ End verbose source /afs/ece/project/km_group/.vol9/asap7/fpga_demos/simple_fpga_cust_mul/scripts/mmmc.tcl
read_physical -lef "$lef_files"
read_netlist "$env(WORK_DIR)/outputs/$env(DESIGN_NAME)_syn.v" -top "$env(DESIGN_NAME)"
init_design 
set_db design_process_node 7
set_db design_tech_node n7
set_db design_bottom_routing_layer 2
set_db design_top_routing_layer 7
connect_global_net VDD -type pg_pin -pin_base_name VDD 
connect_global_net VSS -type pg_pin -pin_base_name VSS 
set FP_RING_OFFSET 0.384
set FP_RING_WIDTH 2.176
set FP_RING_SPACE 0.384
set FP_RING_SIZE [expr {$FP_RING_SPACE + 2*$FP_RING_WIDTH + $FP_RING_OFFSET + 1.1}]
set FP_TARGET [expr round(sqrt([get_db [get_db designs] .area]*1.25))]
set FP_MUL 5
set cellheight [expr 0.270 * 4 ]
set cellhgrid  0.216
set fpxdim [expr $cellhgrid * $FP_TARGET*$FP_MUL]
set fpydim [expr $cellheight * $FP_TARGET ]
create_floorplan -site asap7sc7p5t -core_size $fpxdim $fpydim $FP_RING_SIZE $FP_RING_SIZE $FP_RING_SIZE $FP_RING_SIZE -no_snap_to_grid
add_tracks -snap_m1_track_to_cell_pins
add_tracks -mode replace -offsets {M5 vertical 0}
delete_all_floorplan_objs
add_well_taps -cell TAPCELL_ASAP7_75t_L -cell_interval 12.960 -in_row_offset 1.296
set_db assign_pins_edit_in_batch true
set base_pins [get_db ports .base_name]
edit_pin -fix_overlap 1 -unit track -spread_direction clockwise -side Left -layer M4 -spacing 4 -spread_type center -pin $base_pins
set io_o_pins [get_db ports .base_name *io_IO_o*]
edit_pin -fix_overlap 1 -unit track -spread_direction clockwise -side Right -layer M4 -spacing 16 -spread_type center -pin $io_o_pins
set io_i_pins [get_db ports .base_name *io_IO_i*]
edit_pin -fix_overlap 1 -unit track -spread_direction clockwise -side Right -layer M4 -spacing 16 -spread_type center -pin $io_i_pins
set conf_pins [get_db ports .base_name *conf*]
edit_pin -fix_overlap 1 -unit track -spread_direction clockwise -side Top -layer M3 -spacing 16 -spread_type center -pin $conf_pins
edit_pin -snap track -pin *
set_db assign_pins_edit_in_batch false
legalize_pins
add_stripes  \
-direction horizontal  \
-set_to_set_distance [expr 2*$cellheight]  \
-layer M2  \
-width 0.072  \
-nets {VDD}  \
-start_from bottom  \
-snap_wire_center_to_grid none  \
-start_offset -0.044  \
-stop_offset -0.044
add_stripes  \
-direction horizontal  \
-set_to_set_distance [expr 2*$cellheight]  \
-layer M2  \
-width 0.072  \
-nets {VSS}  \
-start_from bottom  \
-snap_wire_center_to_grid none  \
-start_offset [expr $cellheight -0.044]  \
-stop_offset -0.044
set m3pwrwidth 0.936
set m3pwrspacing 0.360
set m3pwrset2setdist    12.960
set_db add_stripes_stacked_via_top_layer M3
set_db add_stripes_stacked_via_bottom_layer M2
set_db add_stripes_skip_via_on_pin standardcell
add_stripes  \
-set_to_set_distance $m3pwrset2setdist  \
-spacing $m3pwrspacing  \
-x_left_offset 0.360  \
-layer M3  \
-width $m3pwrwidth  \
-nets {VDD VSS}  \
-start_from left
set m4pwrwidth 0.864
set m4pwrspacing 0.864
set m4pwrset2setdist 21.6
set_db add_stripes_stacked_via_top_layer M4
set_db add_stripes_stacked_via_bottom_layer M3
add_stripes  \
-direction horizontal  \
-set_to_set_distance $m4pwrset2setdist  \
-spacing $m4pwrspacing  \
-layer M4  \
-width $m4pwrwidth  \
-nets {VDD VSS}  \
-start_from bottom
update_power_vias -add_vias 1 -orthogonal_only 0
check_drc
add_power_mesh_colors
write_db dbs/floorplan.db
place_opt_design
set_db add_tieoffs_max_fanout 5
add_tieoffs -prefix TIE -lib_cell {TIELOx1_ASAP7_75t_L TIEHIx1_ASAP7_75t_L}
set_db opt_useful_skew_max_allowed_delay 50
set_db ccopt_auto_limit_insertion_delay_factor 1.1 
set_db opt_useful_skew_ccopt none
set_db opt_useful_skew_no_boundary true
set_db opt_useful_skew_pre_cts false
set_db opt_useful_skew_delay_pre_cts false
ccopt_design
report_clock_trees > reports/clock_tree.rpt
write_db dbs/cts.db
set_interactive_constraint_modes [all_constraint_modes -active]
reset_propagated_clock [all_clocks]
set_propagated_clock [all_clocks]
route_design
set_db timing_analysis_type ocv
set_db si_glitch_enable_report true
set_db si_enable_glitch_propagation true
set_db si_delay_enable_report true
opt_design -post_route
opt_design -post_route -hold
write_netlist outputs/[get_db designs .name].postroute.vg.gz
write_db -sdc dbs/[get_db designs .name].db
exit
