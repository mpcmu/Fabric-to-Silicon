create_clock -name clk -period 2000 -waveform {0 1000} clock
set_clock_uncertainty -setup 50 [get_clocks clk]
set_clock_uncertainty -hold  50 [get_clocks clk]

create_clock -name conf_clk -period 4000 -waveform {0 2000} io_ctrlSignals_confClock
set_clock_uncertainty -setup 50 [get_clocks conf_clk]
set_clock_uncertainty -hold  50 [get_clocks conf_clk]

set_clock_groups -asynchronous -group {clk} -group {conf_clk}

#set_case_analysis 0 io_ctrlSignals_loopBreak -comment "loopBreak"
set_case_analysis 1 io_ctrlSignals_pathBreak -comment "pathBreak"


# Fabric Delay Constraints
set ipin_ffs [get_db insts Tile*/*pb*IPIN_FF*]
set opin_ffs [get_db insts Tile*/*pb*OPIN_FF*]

set ipin_ffs_clb [get_db insts Tile*clbalu*/*pb*IPIN_FF*]
set opin_ffs_clb [get_db insts Tile*clbalu*/*pb*OPIN_FF*]

# All segments grouped together
set sb_ffs [get_db insts Tile*/SBMux*/*pb*SB_FF*] 
set sb_ffs_l2 [get_db insts Tile*/SBMux_L2*/*pb*SB_FF*] 
set sb_ffs_l4 [get_db insts Tile*/SBMux_L4*/*pb*SB_FF*] 
set sb_ffs_l4g [get_db insts Tile*/SBMux_L4g*/*pb*SB_FF*]

set bleffs [get_db insts Tile*clb*/*bleFF*]


# Generic Interconnect (CB / SB)
set_max_delay -from $sb_ffs -to $ipin_ffs -ignore_clock_latency 530
set_max_delay -from $sb_ffs -to $sb_ffs -ignore_clock_latency 530

# Specific Interconnect constraints
set_max_delay -from $sb_ffs_l2 -to $sb_ffs -ignore_clock_latency 430
set_max_delay -from $sb_ffs_l4g -to $sb_ffs -ignore_clock_latency 300

# Logic block (clbadd)
set_max_delay -from $ipin_ffs_clb -to $bleffs -ignore_clock_latency 320
set_max_delay -from $bleffs -to $opin_ffs_clb -ignore_clock_latency 230
set_max_delay -from $ipin_ffs_clb -to $opin_ffs_clb -ignore_clock_latency 610

set_load 10 [all_outputs]
set_max_transition 350 *
set_max_fanout 30 [get_designs $env(DESIGN_NAME)]
