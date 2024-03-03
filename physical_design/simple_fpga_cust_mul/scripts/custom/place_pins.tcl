set_db assign_pins_edit_in_batch true  

# start at 140 & repeat every 111.24

set base_pins [get_db ports .base_name]
edit_pin -offset_start 50 -edge 3 -layer {M3 M5} -spread_direction clockwise -pattern fill_track -unit track -spacing 100 -pin $base_pins -fixed_pin 1

set buses {pull_en pwrupzhl puq prg_slew ppen pd enq enabq drv2 drv1 drv0 dq outi}
set repeat 111.24

for {set i 15} {$i >= 0} { incr i -1} {
    set base_pins [list]
    set offset [expr 74 + $i * 111.24]
    set start_pin_id [expr $i * 4]
    foreach bus $buses {
        for {set j 0} {$j <= 3} { incr j} {
            lappend base_pins {*}[get_db ports .base_name "*$bus\[[expr $start_pin_id + $j]\]"]
        }
    }
    

    edit_pin -offset_start $offset -edge 3 -layer {M3 M5} -spread_direction clockwise \
        -pattern fill_track -unit track -spacing 4 -pin $base_pins -fixed_pin 1
}

set clk_pins [list]
set clk_pins [get_db [get_db ports -if .is_clock_used_as_clock] .base_name]

edit_pin -pin $clk_pins -pin_width 0.108

set_db assign_pins_edit_in_batch false
