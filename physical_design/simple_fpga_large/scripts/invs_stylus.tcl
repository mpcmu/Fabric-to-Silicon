
set_multi_cpu_usage -local_cpu 16
# the script is slightly different for different versions of innovus. please set this variable wit the version number
#set VERSION 17
#set VERSION 18
#set VERSION 19
#set VERSION 20
set VERSION 21

set_db init_design_uniquify 1
# MANUALLY TRANSLATE (ERROR-50): File '$env(WORK_DIR)/scripts/init_libs.tcl' does not exist.
source $env(WORK_DIR)/scripts/init_libs.tcl
set_db init_netlist_files "$env(WORK_DIR)/outputs/$env(DESIGN_NAME)_syn.v"

set_db init_design_netlist_type {Verilog}
# MANUALLY TRANSLATE (WARN-41): UDM 'init_design_settop' is obsolete in common UI and is removed. 
# set init_design_settop {1}
# MANUALLY TRANSLATE (WARN-41): UDM 'init_top_cell' is obsolete in common UI and is removed. 
# set init_top_cell $env(DESIGN_NAME)

set DB_PATH "$env(WORK_DIR)/dbs/"
#set LEF_PATH "../lef/scaled/"
#set TLEF_PATH "../techlef/"
#
#set CELL_LEF "$LEF_PATH/asap7sc7p5t_28_L_4x_220121a.lef $LEF_PATH/asap7sc7p5t_28_SL_4x_220121a.lef $LEF_PATH/asap7sc7p5t_28_R_4x_220121a.lef"
#set TECH_LEF $TLEF_PATH/asap7_tech_4x_201209.lef

#tech lef first, cell lef later
#set init_lef_file "$TECH_LEF $CELL_LEF"
set_db init_lef_files $lef_files

# MANUALLY TRANSLATE (ERROR-40): UDM 'fp_core_cntl' has no common UI definition and is removed, contact Cadence for support. 
# set fp_core_cntl {aspect}
# MANUALLY TRANSLATE (ERROR-40): UDM 'fp_aspect_ratio' has no common UI definition and is removed, contact Cadence for support. 
# set fp_aspect_ratio {1.0000}
set_db extract_rc_shrink_factor {1.0}
# MANUALLY TRANSLATE (ERROR-40): UDM 'init_assign_buffer' has no common UI definition and is removed, contact Cadence for support. 
# set init_assign_buffer {0}
set_db init_power_nets {VDD}
set_db init_ground_nets {VSS}

# here starts the timing libraries
# MANUALLY TRANSLATE (WARN-41): UDM 'init_cpf_file' is obsolete in common UI and is removed. 
# set init_cpf_file {}
set_db init_mmmc_files $env(WORK_DIR)/scripts/mmmc.tcl

#MANUALLY TRANSLATE: init_design variables may be set in {$env(WORK_DIR)/scripts/init_libs.tcl}, which are not get translated
read_mmmc "$env(WORK_DIR)/scripts/mmmc.tcl"
read_physical -lef "$lef_files"
read_netlist "$env(WORK_DIR)/outputs/$env(DESIGN_NAME)_syn.v" -top "$env(DESIGN_NAME)"
#read_power_intent -cpf ""
init_design 

suspend

# settings begin here
# defines tech node
set_db design_process_node 7 ; set_db design_tech_node n7


set_db design_bottom_routing_layer 2
set_db design_top_routing_layer 7


#this is the VDD for the std cells
# MANUALLY TRANSLATE (ERROR-11): Argument '-inst' for command 'globalNetConnect' has no common UI definition and is removed, contact Cadence for support. 
connect_global_net VDD -type pg_pin -pin_base_name VDD 

# and the VSS
# MANUALLY TRANSLATE (ERROR-11): Argument '-inst' for command 'globalNetConnect' has no common UI definition and is removed, contact Cadence for support. 
connect_global_net VSS -type pg_pin -pin_base_name VSS 

set FP_RING_OFFSET 0.384
set FP_RING_WIDTH 2.176
set FP_RING_SPACE 0.384
set FP_RING_SIZE [expr {$FP_RING_SPACE + 2*$FP_RING_WIDTH + $FP_RING_OFFSET + 1.1}]
#set FP_RING_SIZE [expr {$FP_RING_SPACE + 2*$FP_RING_WIDTH + $FP_RING_OFFSET}]
set FP_TARGET [expr round(sqrt([get_db [get_db designs] .area]*1.25))]
set FP_MUL 5
# important: these numbers cannot be chosen arbitrarily, otherwise all VDD/VSS stripes are offgrid or there are no valid vias that can drop on them 
# FP_TARGET is the only variable you can freely modify. this one determines the number of standard cell rows in your design
# FP_MUL controls the aspect ratio. FP_MUL = 5 gives you a perfectly square design
# the additional 0.1 is to account for situations where innovus snaps the fplan and the space becomes too narrow to fit the rings 

set cellheight [expr 0.270 * 4 ]
set cellhgrid  0.216

set fpxdim [expr $cellhgrid * $FP_TARGET*$FP_MUL]
set fpydim [expr $cellheight * $FP_TARGET ]

# this command prints the snapping rules, it is useful for debugging
floorplan_get_snap_rule

# MANUALLY TRANSLATE (WARN-14): Argument '-noSnap' for command 'floorPlan' partially matches '-noSnapToGrid'.
create_floorplan -site asap7sc7p5t -core_size $fpxdim $fpydim $FP_RING_SIZE $FP_RING_SIZE $FP_RING_SIZE $FP_RING_SIZE -no_snap_to_grid
# this is likely not perfect because some snapping is done by innovus. the commands below came with the reference script by ASU. 
#changeFloorplan -coreToBottom [expr $FP_RING_SIZE] 
#add_tracks -honor_pitch

# the interval setting matches the M3 stripes for saving some resources. 
#add_well_taps -cell TAPCELL_ASAP7_75t_L -cell_interval 12.960 -in_row_offset 1.296

if {$VERSION >= 21} {
	# this series of commands makes innovus 21 happy :)
	add_tracks -snap_m1_track_to_cell_pins
	add_tracks -mode replace -offsets {M5 vertical 0}
	delete_all_floorplan_objs
	add_well_taps -cell TAPCELL_ASAP7_75t_L -cell_interval 12.960 -in_row_offset 1.296
}

# classic setting: all inputs on the left, all outputs on the right.
#edit_pin -fix_overlap 1 -unit micron -spread_direction clockwise -side Left -layer 3 -spread_type center -spacing 2.016 -pin {reset_noise_lib_pin clk {address[0]} {address[1]} {address[2]} {address[3]} {address[4]} {address[5]} {address[6]} {address[7]} cs we {write_data[0]} {write_data[1]} {write_data[2]} {write_data[3]} {write_data[4]} {write_data[5]} {write_data[6]} {write_data[7]} {write_data[8]} {write_data[9]} {write_data[10]} {write_data[11]} {write_data[12]} {write_data[13]} {write_data[14]} {write_data[15]} {write_data[16]} {write_data[17]} {write_data[18]} {write_data[19]} {write_data[20]} {write_data[21]} {write_data[22]} {write_data[23]} {write_data[24]} {write_data[25]} {write_data[26]} {write_data[27]} {write_data[28]} {write_data[29]} {write_data[30]} {write_data[31]}}
#edit_pin -fix_overlap 1 -unit micron -spread_direction clockwise -side Right -layer 3 -spread_type center -spacing 2 -pin {error {read_data[0]} {read_data[1]} {read_data[2]} {read_data[3]} {read_data[4]} {read_data[5]} {read_data[6]} {read_data[7]} {read_data[8]} {read_data[9]} {read_data[10]} {read_data[11]} {read_data[12]} {read_data[13]} {read_data[14]} {read_data[15]} {read_data[16]} {read_data[17]} {read_data[18]} {read_data[19]} {read_data[20]} {read_data[21]} {read_data[22]} {read_data[23]} {read_data[24]} {read_data[25]} {read_data[26]} {read_data[27]} {read_data[28]} {read_data[29]} {read_data[30]} {read_data[31]}}
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

suspend

# now we are going to add the core ring using M6/M7
#set_db add_rings_target default ; set_db add_rings_extend_over_row 0 ; set_db add_rings_ignore_rows 0 ; set_db add_rings_avoid_short 0 ; set_db add_rings_skip_shared_inner_ring none ; set_db add_rings_stacked_via_top_layer Pad ; set_db add_rings_stacked_via_bottom_layer M1 ; set_db add_rings_via_using_exact_crossover_size 1 ; set_db add_rings_orthogonal_only true ; set_db add_rings_skip_via_on_pin {  standardcell } ; set_db add_rings_skip_via_on_wire_shape {  noshape }
#add_rings -nets {VDD VSS} -type core_rings -follow core -layer {top M7 bottom M7 left M6 right M6} -width $FP_RING_WIDTH -spacing $FP_RING_SPACE -offset $FP_RING_OFFSET -center 0 -threshold 0 -jog_distance 0 -snap_wire_center_to_grid none

# now we are going to add M2 follow rails. on top of every standard cell row. we need to add VSS and VDD separately because the number of rows is not always odd. it is possible you need one extra stripe of VDD, but not VSS.
# MANUALLY TRANSLATE (ERROR-11): Argument '-skip_via_on_wire_shape' for command 'addStripe' has no common UI definition and is removed, contact Cadence for support. 
# MANUALLY TRANSLATE (ERROR-11): Argument '-skip_via_on_pin' for command 'addStripe' has no common UI definition and is removed, contact Cadence for support. 
# MANUALLY TRANSLATE (ERROR-11): Argument '-stacked_via_top_layer' for command 'addStripe' has no common UI definition and is removed, contact Cadence for support. 
# MANUALLY TRANSLATE (ERROR-11): Argument '-stacked_via_bottom_layer' for command 'addStripe' has no common UI definition and is removed, contact Cadence for support. 
set_db add_rings_skip_via_on_pin standardcell
set_db add_stripes_stacked_via_top_layer M1
set_db add_stripes_stacked_via_bottom_layer M1
set_db add_stripes_skip_via_on_wire_shape blockring
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

# MANUALLY TRANSLATE (ERROR-11): Argument '-skip_via_on_wire_shape' for command 'addStripe' has no common UI definition and is removed, contact Cadence for support. 
# MANUALLY TRANSLATE (ERROR-11): Argument '-skip_via_on_pin' for command 'addStripe' has no common UI definition and is removed, contact Cadence for support. 
# MANUALLY TRANSLATE (ERROR-11): Argument '-stacked_via_top_layer' for command 'addStripe' has no common UI definition and is removed, contact Cadence for support. 
# MANUALLY TRANSLATE (ERROR-11): Argument '-stacked_via_bottom_layer' for command 'addStripe' has no common UI definition and is removed, contact Cadence for support. 
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


#suspend
# now we are going to add vertical M3 stripes. the metal stack is very restrictive, it is not easy to use other metals because of assumptions made with respect to V2 and V1. 
set m3pwrwidth 0.936
set m3pwrspacing 0.360
set m3pwrspacing [expr 0.360*15]
set m3pwrset2setdist    12.960


# looks like this   |0.936|0.360|0.936|long space... repeat pattern 
# if the last vertical M3 stripe is too close to the edge of the core, it can create a DRC violation. this stripe can be deleted manually.

# MANUALLY TRANSLATE (ERROR-11): Argument '-skip_via_on_wire_shape' for command 'addStripe' has no common UI definition and is removed, contact Cadence for support. 
# MANUALLY TRANSLATE (ERROR-11): Argument '-skip_via_on_pin' for command 'addStripe' has no common UI definition and is removed, contact Cadence for support. 
# MANUALLY TRANSLATE (ERROR-11): Argument '-stacked_via_top_layer' for command 'addStripe' has no common UI definition and is removed, contact Cadence for support. 
# MANUALLY TRANSLATE (ERROR-11): Argument '-stacked_via_bottom_layer' for command 'addStripe' has no common UI definition and is removed, contact Cadence for support. 
set_db add_stripes_stacked_via_top_layer M3
set_db add_stripes_stacked_via_bottom_layer M2
set_db add_stripes_skip_via_on_pin standardcell
get_db add_stripes_skip_via_on_wire_shape noshape
add_stripes  \
-set_to_set_distance $m3pwrset2setdist  \
-spacing $m3pwrspacing  \
-x_left_offset 0.360  \
-layer M3  \
-width $m3pwrwidth  \
-nets {VDD VSS}  \
-start_from left

# innovus 17 does some unusual large via selection for the power grid and generates violations
# the commands below fix that
if {$VERSION == 17} {
	update_power_vias -delete_vias 1 -top_layer 4 -bottom_layer 3
	update_power_vias -add_vias 1
}

# now we are going to add horizontal M4 stripes. the metal stack is very restrictive, it is not easy to use other metals because of assumptions made with respect to V2 and V1. 
set m4pwrwidth 0.864
set m4pwrspacing 0.864
set m4pwrspacing [expr 0.864*8]
set m4pwrset2setdist 21.6
set m4pwrset2setdist [expr 0.864*16]
set m4pwrwidth 0.480
set m4pwrspacing [expr 0.480*7]
set m4pwrset2setdist [expr 0.480*16]

# looks like this   |0.864|0.864|0.864|long space... repeat pattern 
# MANUALLY TRANSLATE (ERROR-11): Argument '-skip_via_on_wire_shape' for command 'addStripe' has no common UI definition and is removed, contact Cadence for support. 
# MANUALLY TRANSLATE (ERROR-11): Argument '-skip_via_on_pin' for command 'addStripe' has no common UI definition and is removed, contact Cadence for support. 
# MANUALLY TRANSLATE (ERROR-11): Argument '-stacked_via_top_layer' for command 'addStripe' has no common UI definition and is removed, contact Cadence for support. 
# MANUALLY TRANSLATE (ERROR-11): Argument '-stacked_via_bottom_layer' for command 'addStripe' has no common UI definition and is removed, contact Cadence for support. 
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

set m5pwrwidth 0.864
set m5pwrspacing [expr 0.864*11]
set m5pwrset2setdist [expr 0.864*24]

set_db add_stripes_stacked_via_top_layer M5
set_db add_stripes_stacked_via_bottom_layer M4
set_db add_stripes_skip_via_on_pin standardcell
add_stripes  \
-set_to_set_distance $m5pwrset2setdist  \
-spacing $m5pwrspacing \
-x_left_offset [expr 0.360]  \
-layer M5  \
-width $m5pwrwidth \
-nets {VDD VSS}  \
-start_from left

set m6pwrwidth 0.640
set m6pwrspacing [expr 0.640*11]
set m6pwrset2setdist [expr 0.640*24]

set_db add_stripes_stacked_via_top_layer M7
set_db add_stripes_stacked_via_bottom_layer M5
add_stripes  \
-direction horizontal  \
-set_to_set_distance $m6pwrset2setdist  \
-spacing $m6pwrspacing  \
-layer M6  \
-width $m6pwrwidth  \
-nets {VDD VSS}  \
-start_from bottom

#reset_db -category route_special
#set_db route_special_via_connect_to_shape { noshape }
#route_special -connect {core_pin} -layer_change_range { M1(1) M7(1) } -block_pin_target {nearest_target} -floating_stripe_target {block_ring pad_ring ring stripe ring_pin block_pin followpin} -delete_existing_routes -allow_jogging 0 -crossover_via_layer_range { M1(1) Pad(10) } -nets { VDD VSS } -allow_layer_change 0 -target_via_layer_range { M1(1) Pad(10) }

update_power_vias -add_vias 1 -orthogonal_only 0

check_drc

set_db opt_hold_target_slack  0.020
set_db opt_setup_target_slack 0.020

#setPlaceMode -place_detail_preroute_as_obs 3

# this helps verify_drc realize that some metals are colored. 
add_power_mesh_colors


#suspend


place_opt_design

write_db -sdc dbs/place.db
suspend

# add tie hi lo at this point. could have been handled in genus too.
set_db add_tieoffs_max_fanout 5
add_tieoffs -prefix TIE -lib_cell {TIELOx1_ASAP7_75t_L TIEHIx1_ASAP7_75t_L}

# CTS

# CTS no skew
set_db opt_useful_skew_max_allowed_delay 50
set_db ccopt_auto_limit_insertion_delay_factor 1.1 
set_db opt_useful_skew_ccopt none
set_db opt_useful_skew_no_boundary true
set_db opt_useful_skew_pre_cts false
set_db opt_useful_skew_delay_pre_cts false

ccopt_design

report_clock_trees > reports/clock_tree.rpt
write_db -sdc dbs/cts.db
#suspend

# MANUALLY TRANSLATE 
#This command all_constraint_modes is hidden and obsolete and may be removed in the next release. You should change to use ?get_db constraint_modes? instead. For example, instead of ?all_constraint_modes -active_hold?, you should use ?get_db constraint_modes -if {.is_hold}?.

set_interactive_constraint_modes [all_constraint_modes -active]
reset_propagated_clock [all_clocks]
if {$VERSION == 21} {
set_propagated_clock [all_clocks]
#update_io_latency -source -verbose
} else {
set_propagated_clock [all_clocks]
}

legalize_pins  

route_design

write_db -sdc dbs/route.db
suspend
# for some versions of innovus, silly mistakes are made when assigning colors to vias on the power rings. these lines fix it.
update_power_vias -delete_vias 1 -top_layer 7 -bottom_layer 6	
update_power_vias -delete_vias 1 -top_layer 6 -bottom_layer 5
update_power_vias -delete_vias 1 -top_layer 5 -bottom_layer 4
update_power_vias -delete_vias 1 -top_layer 4 -bottom_layer 3
update_power_vias -delete_vias 1 -top_layer 3 -bottom_layer 2
update_power_vias -delete_vias 1 -top_layer 2 -bottom_layer 1
update_power_vias -add_vias 1
set_db timing_analysis_type ocv
set_db si_glitch_enable_report true
set_db si_enable_glitch_propagation true
set_db si_delay_enable_report true
opt_design -post_route
opt_design -post_route -hold

report_noise -threshold 0.2 
report_noise -noisy_waveform 

# Writing out the def file and the netlist
set_db write_def_include_lef_vias 1
set_db write_def_include_lef_ndr 1
#write_def -netlist -routing -all_layers ${DB_PATH}${init_top_cell}_v${VERSION}.def
write_netlist outputs/[get_db designs .name].postroute.vg.gz
write_db -sdc dbs/[get_db designs .name].db
# setStreamOutMode -reset

