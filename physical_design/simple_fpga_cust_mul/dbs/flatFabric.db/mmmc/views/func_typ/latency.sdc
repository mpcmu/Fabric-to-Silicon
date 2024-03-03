set_clock_latency -source -early -max -rise  -189.75 [get_ports {io_ctrlSignals_confClock}] -clock conf_clk 
set_clock_latency -source -early -max -fall  -189.69 [get_ports {io_ctrlSignals_confClock}] -clock conf_clk 
set_clock_latency -source -late -max -rise  -189.75 [get_ports {io_ctrlSignals_confClock}] -clock conf_clk 
set_clock_latency -source -late -max -fall  -189.69 [get_ports {io_ctrlSignals_confClock}] -clock conf_clk 
set_clock_latency -source -early -max -rise  -184.076 [get_ports {clock}] -clock clk 
set_clock_latency -source -early -max -fall  -181.247 [get_ports {clock}] -clock clk 
set_clock_latency -source -late -max -rise  -184.076 [get_ports {clock}] -clock clk 
set_clock_latency -source -late -max -fall  -181.247 [get_ports {clock}] -clock clk 
