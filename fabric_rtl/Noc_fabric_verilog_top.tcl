startgroup
create_bd_port -dir I -from 3 -to 0 Noc_0_0_receive_valid
connect_bd_net [get_bd_pins /Noc_fabric_verilog_t_0/Noc_0_0_receive_valid] [get_bd_ports Noc_0_0_receive_valid]
endgroup
startgroup
create_bd_port -dir I -from 127 -to 0 Noc_0_0_receive_flit
connect_bd_net [get_bd_pins /Noc_fabric_verilog_t_0/Noc_0_0_receive_flit] [get_bd_ports Noc_0_0_receive_flit]
endgroup
startgroup
create_bd_port -dir I -from 3 -to 0 Noc_0_0_sender_ready
connect_bd_net [get_bd_pins /Noc_fabric_verilog_t_0/Noc_0_0_sender_ready] [get_bd_ports Noc_0_0_sender_ready]
endgroup
startgroup
create_bd_port -dir I -from 3 -to 0 Noc_0_0_sender_vc_ready
connect_bd_net [get_bd_pins /Noc_fabric_verilog_t_0/Noc_0_0_sender_vc_ready] [get_bd_ports Noc_0_0_sender_vc_ready]
endgroup
startgroup
create_bd_port -dir O -from 3 -to 0 Noc_0_0_receive_ready
connect_bd_net [get_bd_pins /Noc_fabric_verilog_t_0/Noc_0_0_receive_ready] [get_bd_ports Noc_0_0_receive_ready]
endgroup
startgroup
create_bd_port -dir O -from 3 -to 0 Noc_0_0_receive_vc_ready
connect_bd_net [get_bd_pins /Noc_fabric_verilog_t_0/Noc_0_0_receive_vc_ready] [get_bd_ports Noc_0_0_receive_vc_ready]
endgroup
startgroup
create_bd_port -dir O -from 3 -to 0 Noc_0_0_sender_valid
connect_bd_net [get_bd_pins /Noc_fabric_verilog_t_0/Noc_0_0_sender_valid] [get_bd_ports Noc_0_0_sender_valid]
endgroup
startgroup
create_bd_port -dir O -from 127 -to 0 Noc_0_0_sender_flit
connect_bd_net [get_bd_pins /Noc_fabric_verilog_t_0/Noc_0_0_sender_flit] [get_bd_ports Noc_0_0_sender_flit]
endgroup
startgroup
create_bd_port -dir I -from 3 -to 0 Noc_0_1_receive_valid
connect_bd_net [get_bd_pins /Noc_fabric_verilog_t_0/Noc_0_1_receive_valid] [get_bd_ports Noc_0_1_receive_valid]
endgroup
startgroup
create_bd_port -dir I -from 127 -to 0 Noc_0_1_receive_flit
connect_bd_net [get_bd_pins /Noc_fabric_verilog_t_0/Noc_0_1_receive_flit] [get_bd_ports Noc_0_1_receive_flit]
endgroup
startgroup
create_bd_port -dir I -from 3 -to 0 Noc_0_1_sender_ready
connect_bd_net [get_bd_pins /Noc_fabric_verilog_t_0/Noc_0_1_sender_ready] [get_bd_ports Noc_0_1_sender_ready]
endgroup
startgroup
create_bd_port -dir I -from 3 -to 0 Noc_0_1_sender_vc_ready
connect_bd_net [get_bd_pins /Noc_fabric_verilog_t_0/Noc_0_1_sender_vc_ready] [get_bd_ports Noc_0_1_sender_vc_ready]
endgroup
startgroup
create_bd_port -dir O -from 3 -to 0 Noc_0_1_receive_ready
connect_bd_net [get_bd_pins /Noc_fabric_verilog_t_0/Noc_0_1_receive_ready] [get_bd_ports Noc_0_1_receive_ready]
endgroup
startgroup
create_bd_port -dir O -from 3 -to 0 Noc_0_1_receive_vc_ready
connect_bd_net [get_bd_pins /Noc_fabric_verilog_t_0/Noc_0_1_receive_vc_ready] [get_bd_ports Noc_0_1_receive_vc_ready]
endgroup
startgroup
create_bd_port -dir O -from 3 -to 0 Noc_0_1_sender_valid
connect_bd_net [get_bd_pins /Noc_fabric_verilog_t_0/Noc_0_1_sender_valid] [get_bd_ports Noc_0_1_sender_valid]
endgroup
startgroup
create_bd_port -dir O -from 127 -to 0 Noc_0_1_sender_flit
connect_bd_net [get_bd_pins /Noc_fabric_verilog_t_0/Noc_0_1_sender_flit] [get_bd_ports Noc_0_1_sender_flit]
endgroup
startgroup
create_bd_port -dir I -from 3 -to 0 Noc_1_0_receive_valid
connect_bd_net [get_bd_pins /Noc_fabric_verilog_t_0/Noc_1_0_receive_valid] [get_bd_ports Noc_1_0_receive_valid]
endgroup
startgroup
create_bd_port -dir I -from 127 -to 0 Noc_1_0_receive_flit
connect_bd_net [get_bd_pins /Noc_fabric_verilog_t_0/Noc_1_0_receive_flit] [get_bd_ports Noc_1_0_receive_flit]
endgroup
startgroup
create_bd_port -dir I -from 3 -to 0 Noc_1_0_sender_ready
connect_bd_net [get_bd_pins /Noc_fabric_verilog_t_0/Noc_1_0_sender_ready] [get_bd_ports Noc_1_0_sender_ready]
endgroup
startgroup
create_bd_port -dir I -from 3 -to 0 Noc_1_0_sender_vc_ready
connect_bd_net [get_bd_pins /Noc_fabric_verilog_t_0/Noc_1_0_sender_vc_ready] [get_bd_ports Noc_1_0_sender_vc_ready]
endgroup
startgroup
create_bd_port -dir O -from 3 -to 0 Noc_1_0_receive_ready
connect_bd_net [get_bd_pins /Noc_fabric_verilog_t_0/Noc_1_0_receive_ready] [get_bd_ports Noc_1_0_receive_ready]
endgroup
startgroup
create_bd_port -dir O -from 3 -to 0 Noc_1_0_receive_vc_ready
connect_bd_net [get_bd_pins /Noc_fabric_verilog_t_0/Noc_1_0_receive_vc_ready] [get_bd_ports Noc_1_0_receive_vc_ready]
endgroup
startgroup
create_bd_port -dir O -from 3 -to 0 Noc_1_0_sender_valid
connect_bd_net [get_bd_pins /Noc_fabric_verilog_t_0/Noc_1_0_sender_valid] [get_bd_ports Noc_1_0_sender_valid]
endgroup
startgroup
create_bd_port -dir O -from 127 -to 0 Noc_1_0_sender_flit
connect_bd_net [get_bd_pins /Noc_fabric_verilog_t_0/Noc_1_0_sender_flit] [get_bd_ports Noc_1_0_sender_flit]
endgroup
startgroup
create_bd_port -dir I -from 3 -to 0 Noc_1_1_receive_valid
connect_bd_net [get_bd_pins /Noc_fabric_verilog_t_0/Noc_1_1_receive_valid] [get_bd_ports Noc_1_1_receive_valid]
endgroup
startgroup
create_bd_port -dir I -from 127 -to 0 Noc_1_1_receive_flit
connect_bd_net [get_bd_pins /Noc_fabric_verilog_t_0/Noc_1_1_receive_flit] [get_bd_ports Noc_1_1_receive_flit]
endgroup
startgroup
create_bd_port -dir I -from 3 -to 0 Noc_1_1_sender_ready
connect_bd_net [get_bd_pins /Noc_fabric_verilog_t_0/Noc_1_1_sender_ready] [get_bd_ports Noc_1_1_sender_ready]
endgroup
startgroup
create_bd_port -dir I -from 3 -to 0 Noc_1_1_sender_vc_ready
connect_bd_net [get_bd_pins /Noc_fabric_verilog_t_0/Noc_1_1_sender_vc_ready] [get_bd_ports Noc_1_1_sender_vc_ready]
endgroup
startgroup
create_bd_port -dir O -from 3 -to 0 Noc_1_1_receive_ready
connect_bd_net [get_bd_pins /Noc_fabric_verilog_t_0/Noc_1_1_receive_ready] [get_bd_ports Noc_1_1_receive_ready]
endgroup
startgroup
create_bd_port -dir O -from 3 -to 0 Noc_1_1_receive_vc_ready
connect_bd_net [get_bd_pins /Noc_fabric_verilog_t_0/Noc_1_1_receive_vc_ready] [get_bd_ports Noc_1_1_receive_vc_ready]
endgroup
startgroup
create_bd_port -dir O -from 3 -to 0 Noc_1_1_sender_valid
connect_bd_net [get_bd_pins /Noc_fabric_verilog_t_0/Noc_1_1_sender_valid] [get_bd_ports Noc_1_1_sender_valid]
endgroup
startgroup
create_bd_port -dir O -from 127 -to 0 Noc_1_1_sender_flit
connect_bd_net [get_bd_pins /Noc_fabric_verilog_t_0/Noc_1_1_sender_flit] [get_bd_ports Noc_1_1_sender_flit]
endgroup
