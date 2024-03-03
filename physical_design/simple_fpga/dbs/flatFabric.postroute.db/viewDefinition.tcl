if {![namespace exists ::IMEX]} { namespace eval ::IMEX {} }
set ::IMEX::dataVar [file dirname [file normalize [info script]]]
set ::IMEX::libVar ${::IMEX::dataVar}/libs

create_library_set -name tt_0p7v_25c\
   -timing\
    [list ${::IMEX::libVar}/mmmc/asap7sc7p5t_AO_RVT_TT_nldm_211120.lib\
    ${::IMEX::libVar}/mmmc/asap7sc7p5t_INVBUF_RVT_TT_nldm_220122.lib\
    ${::IMEX::libVar}/mmmc/asap7sc7p5t_OA_RVT_TT_nldm_211120.lib\
    ${::IMEX::libVar}/mmmc/asap7sc7p5t_SEQ_RVT_TT_nldm_220123.lib\
    ${::IMEX::libVar}/mmmc/asap7sc7p5t_SIMPLE_RVT_TT_nldm_211120.lib\
    ${::IMEX::libVar}/mmmc/asap7sc7p5t_AO_LVT_TT_nldm_211120.lib\
    ${::IMEX::libVar}/mmmc/asap7sc7p5t_INVBUF_LVT_TT_nldm_220122.lib\
    ${::IMEX::libVar}/mmmc/asap7sc7p5t_OA_LVT_TT_nldm_211120.lib\
    ${::IMEX::libVar}/mmmc/asap7sc7p5t_SEQ_LVT_TT_nldm_220123.lib\
    ${::IMEX::libVar}/mmmc/asap7sc7p5t_SIMPLE_LVT_TT_nldm_211120.lib]
create_timing_condition -name tt_0p7v_25c_TYP\
   -library_sets [list tt_0p7v_25c]
create_rc_corner -name rc_typ_25\
   -pre_route_res 1\
   -post_route_res 1\
   -pre_route_cap 1\
   -post_route_cap 1\
   -post_route_cross_cap 1\
   -pre_route_clock_res 0\
   -pre_route_clock_cap 0\
   -temperature 25\
   -qrc_tech ${::IMEX::libVar}/mmmc/rc_typ_25/qrcTechFile_typ03_scaled4xV06
create_delay_corner -name tt_0p7v_25c_typ_25c\
   -timing_condition {tt_0p7v_25c_TYP}\
   -rc_corner rc_typ_25
create_constraint_mode -name func\
   -sdc_files\
    [list ${::IMEX::dataVar}/mmmc/modes/func/func.sdc]
create_analysis_view -name func_typ -constraint_mode func -delay_corner tt_0p7v_25c_typ_25c -latency_file ${::IMEX::dataVar}/mmmc/views/func_typ/latency.sdc
set_analysis_view -setup [list func_typ] -hold [list func_typ]
catch {set_interactive_constraint_mode [list func] } 
