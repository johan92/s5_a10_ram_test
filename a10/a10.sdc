set_time_format -unit ns -decimal_places 3

create_clock -name {clk} -period 3.000 [get_ports {clk_i}]
