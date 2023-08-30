# the -name is useful if I need to refer to
# this clock in another statement
create_clock -period 10.000 -name master_ck [get_ports i_ck]

create_generated_clock -name {ckdiv/Q[0]} -source [get_ports i_ck] -divide_by 4 [get_pins {ckdiv/r_internal_count_reg[1]/Q}]
