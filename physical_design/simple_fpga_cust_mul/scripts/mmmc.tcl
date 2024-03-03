# ASAP has only one QRC tech file (typical corner)

# Create constraint mode (SDC + analysis view)
create_constraint_mode -name func -sdc_files $env(WORK_DIR)/outputs/$env(DESIGN_NAME)_syn.sdc

# Create library set & delay corner
create_library_set -name {tt_0p7v_25c} -timing $lib_files
create_timing_condition -name tt_0p7v_25c_TYP -library_sets { tt_0p7v_25c }
create_rc_corner -name rc_typ_25 -qrc_tech $env(ASIC_PATH)/qrc/qrcTechFile_typ03_scaled4xV06 -T 25
create_delay_corner -name tt_0p7v_25c_typ_25c -timing_condition {tt_0p7v_25c_TYP} -rc_corner {rc_typ_25}

# Create analysis view
create_analysis_view -name func_typ -constraint_mode {func} -delay_corner {tt_0p7v_25c_typ_25c}

# Set TT as setup and hold analysis view
set_analysis_view -setup {func_typ} -hold {func_typ}
