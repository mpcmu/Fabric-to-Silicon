set_clock_latency -source -early -max -rise  -392.925 [get_ports {io_ctrlSignals_confClock}] -clock conf_clk 
set_clock_latency -source -early -max -fall  -399.43 [get_ports {io_ctrlSignals_confClock}] -clock conf_clk 
set_clock_latency -source -late -max -rise  -392.925 [get_ports {io_ctrlSignals_confClock}] -clock conf_clk 
set_clock_latency -source -late -max -fall  -399.43 [get_ports {io_ctrlSignals_confClock}] -clock conf_clk 
set_clock_latency -source -early -max -rise  -358.113 [get_ports {clock}] -clock clk 
set_clock_latency -source -early -max -fall  -372.494 [get_ports {clock}] -clock clk 
set_clock_latency -source -late -max -rise  -358.113 [get_ports {clock}] -clock clk 
set_clock_latency -source -late -max -fall  -372.494 [get_ports {clock}] -clock clk 
