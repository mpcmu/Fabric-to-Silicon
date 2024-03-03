set vtlist [list RVT LVT]
set corners [list TT]

set lef_files [list $env(ASIC_PATH)/techlef_misc/asap7_tech_4x_201209_mod.lef\
                    $env(ASIC_PATH)/LEF/scaled/asap7sc7p5t_28_R_4x_220121a.lef\
                    $env(ASIC_PATH)/LEF/scaled/asap7sc7p5t_28_SRAM_4x_220121a.lef\
                    $env(ASIC_PATH)/LEF/scaled/asap7sc7p5t_28_L_4x_220121a.lef\
                    $env(ASIC_PATH)/LEF/scaled/asap7sc7p5t_28_SL_4x_220121a.lef]
                    #$env(WORK_DIR)/mux_BB.lef]

set lib_files [list]
foreach corner $corners {
    foreach vt $vtlist {
        lappend lib_files {*}[glob $env(ASIC_PATH)/LIB/NLDM/*_${vt}_${corner}_nldm*.lib]
    }
}
