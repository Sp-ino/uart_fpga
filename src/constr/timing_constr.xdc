# the -name is useful if I need to refer to
# this clock in another statement
create_clock -period 10.000 -name master_ck [get_ports i_ckin]


create_generated_clock -name top_i/ckdiv_ip_0/U0/o_ckout -source [get_ports i_ckin] -divide_by 16 [get_pins {top_i/ckdiv_ip_0/U0/r_internal_count_reg[3]/Q}]
