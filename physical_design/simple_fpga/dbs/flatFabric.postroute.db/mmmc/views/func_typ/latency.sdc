set_clock_latency -source -early -max -rise  -190.956 [get_ports {io_ctrlSignals_confClock}] -clock conf_clk 
set_clock_latency -source -early -max -fall  -186.722 [get_ports {io_ctrlSignals_confClock}] -clock conf_clk 
set_clock_latency -source -late -max -rise  -190.956 [get_ports {io_ctrlSignals_confClock}] -clock conf_clk 
set_clock_latency -source -late -max -fall  -186.722 [get_ports {io_ctrlSignals_confClock}] -clock conf_clk 
set_clock_latency -source -early -max -rise  -167.729 [get_ports {clock}] -clock clk 
set_clock_latency -source -early -max -fall  -165.039 [get_ports {clock}] -clock clk 
set_clock_latency -source -late -max -rise  -167.729 [get_ports {clock}] -clock clk 
set_clock_latency -source -late -max -fall  -165.039 [get_ports {clock}] -clock clk 
