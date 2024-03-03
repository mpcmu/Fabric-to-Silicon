create_clock -period 0.5 clk
#create_clock -period 0.6 clk2
#create_clock -period 0.5 -name vio_clk
#set_clock_groups -exclusive -group {clk} -group {clk2}
#set_input_delay -clock vio_clk -max 0.25 [get_ports {*}]
#set_output_delay -clock vio_clk -max 0.45 [get_ports {*}]
set_input_delay -clock clk -max 0.2 [get_ports {*}]
set_output_delay -clock clk -max 0.2 [get_ports {*}]
#set_input_delay -clock clk2 -max 0.4 [get_ports {*}]
#set_output_delay -clock clk2 -max 0.4 [get_ports {*}]
