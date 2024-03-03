proc highlight_tiles_by_col {} {
    for {set i 0} {$i < 12} {incr i} {
        set tiles [get_db hinsts "Tile_${i}_\[0-9\]+_\[0-9A-Za-z\]+\$" -regexp]
        puts $tiles
        gui_highlight -auto_color $tiles
    }
}

proc highlight_tiles_by_row {} {
    for {set i 0} {$i < 12} {incr i} {
        set tiles [get_db hinsts "Tile_\[0-9\]+_${i}_\[0-9A-Za-z\]+\$" -regexp]
        puts $tiles
        gui_highlight -auto_color $tiles
    }
}

proc highlight_tiles {} {
    set tiles [get_db hinsts "Tile_\[0-9\]+_\[0-9\]+_\[0-9A-Za-z\]+\$" -regexp]
    foreach tile $tiles {
        gui_highlight -auto_color $tile
    }
}

proc highlight_logic_blocks {} {
    gui_highlight -auto_color  [get_db hinsts *logicBlock]
}

proc highlight_config_blocks {} {
    gui_highlight -auto_color  [get_db hinsts *configBlock]
}
