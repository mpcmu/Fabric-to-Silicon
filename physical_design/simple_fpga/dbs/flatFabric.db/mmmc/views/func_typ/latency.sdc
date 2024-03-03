set_clock_latency -source -early -max -rise  -206.472 [get_ports {io_ctrlSignals_confClock}] -clock conf_clk 
set_clock_latency -source -early -max -fall  -205.281 [get_ports {io_ctrlSignals_confClock}] -clock conf_clk 
set_clock_latency -source -late -max -rise  -206.472 [get_ports {io_ctrlSignals_confClock}] -clock conf_clk 
set_clock_latency -source -late -max -fall  -205.281 [get_ports {io_ctrlSignals_confClock}] -clock conf_clk 
set_clock_latency -source -early -max -rise  -173.415 [get_ports {clock}] -clock clk 
set_clock_latency -source -early -max -fall  -170.741 [get_ports {clock}] -clock clk 
set_clock_latency -source -late -max -rise  -173.415 [get_ports {clock}] -clock clk 
set_clock_latency -source -late -max -fall  -170.741 [get_ports {clock}] -clock clk 
