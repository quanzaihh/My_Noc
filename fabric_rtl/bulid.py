import os
import re

from traits.trait_types import self

# ------------------------获取x,y的size------------------------
parameter_file = 'Noc_parameters.v'
reg_file = open(parameter_file)
parameters_value_list = []
parameters_name_list = []
for line in reg_file.readlines():
    m = re.match(r"`define(\s+)", line)
    if m:
        line = line[len(m.group(0)):]
        m = re.match(r"(\S+)", line)
        if m:
            line = line[len(m.group(0)):]
            parameters_name = m.group(0)
            if line == '\n':
                continue
            m = re.match(r"\s+", line)
            if m:
                s = len(m.group(0))
                try:
                    a = int(line[s:])
                    parameters_name_list.append(parameters_name)
                    parameters_value_list.append(a)
                except ValueError:
                    continue

Noc_X_Size = 0
Noc_Y_Size = 0
Noc_channel = 0
for index, name in enumerate(parameters_name_list):
    if name == "Noc_X_Size": Noc_X_Size = parameters_value_list[index]
    elif name == "Noc_Y_Size": Noc_Y_Size = parameters_value_list[index]
    elif name == "Noc_VC_Channel": Noc_channel = parameters_value_list[index]
if Noc_X_Size == 0 or Noc_Y_Size == 0:
    print("找不到Noc_X_Size,Noc_Y_Size")

# ------------------------------- system verilog interface To verilog interface ----------------------------
code_str = '''/*
    created by: <Xidian University>
    created date: 2024-05-16
*/

module Noc_fabric_verilog_interface import Noc_parameters::*;
(
    input                           noc_clk,
    input                           noc_rst_n,

'''
for x in range(Noc_X_Size):
    for y in range(Noc_Y_Size):
        for c in range(Noc_channel):
            port_str = '''    input   [0:0]                   Noc_{x}_{y}_channel{c}_receive_valid,
    output  [0:0]                   Noc_{x}_{y}_channel{c}_receive_ready,
    input   [Noc_Data_Width-1:0]    Noc_{x}_{y}_channel{c}_receive_flit,
    output  [0:0]                   Noc_{x}_{y}_channel{c}_receive_vc_ready,
    input   [0:0]                   Noc_{x}_{y}_channel{c}_receive_is_header,
    input   [0:0]                   Noc_{x}_{y}_channel{c}_receive_is_tail,
 
    output  [0:0]                   Noc_{x}_{y}_channel{c}_sender_valid,
    input   [0:0]                   Noc_{x}_{y}_channel{c}_sender_ready,
    output  [Noc_Data_Width-1:0]    Noc_{x}_{y}_channel{c}_sender_flit,
    input   [0:0]                   Noc_{x}_{y}_channel{c}_sender_vc_ready,
    output  [0:0]                   Noc_{x}_{y}_channel{c}_sender_is_header,
    output  [0:0]                   Noc_{x}_{y}_channel{c}_sender_is_tail,'''.format(x=x, y=y, c=c)
            if x == Noc_X_Size - 1 and y == Noc_Y_Size - 1 and c == Noc_channel - 1:
                port_str = port_str[:-1] + '\n);'
            else:
                port_str = port_str + "\n\n"
            code_str += port_str

define_str = '''\n\nNoc_flit_interface noc_receiver_if[Noc_Node_Num]();
Noc_flit_interface noc_sender_if[Noc_Node_Num]();'''

code_str += define_str

connect_str = ''
for x in range(Noc_X_Size):
    for y in range(Noc_Y_Size):
        for c in range(Noc_channel):
            node_index = Noc_X_Size * y + x
            connect_str_port = '''  
assign noc_receiver_if[{node_index}].valid[{c}] = Noc_{x}_{y}_channel{c}_receive_valid;
assign Noc_{x}_{y}_channel{c}_receive_ready = noc_receiver_if[{node_index}].ready[{c}];
assign noc_receiver_if[{node_index}].flit[{c}] = {{Noc_{x}_{y}_channel{c}_receive_is_header, Noc_{x}_{y}_channel{c}_receive_is_tail, Noc_{x}_{y}_channel{c}_receive_flit}};
assign Noc_{x}_{y}_channel{c}_receive_vc_ready = noc_receiver_if[{node_index}].vc_ready[{c}];

assign Noc_{x}_{y}_channel{c}_sender_valid = noc_sender_if[{node_index}].valid[{c}];
assign noc_sender_if[{node_index}].ready[{c}] = Noc_{x}_{y}_channel{c}_sender_ready;
assign Noc_{x}_{y}_channel{c}_sender_flit = noc_sender_if[{node_index}].flit[{c}][Noc_Data_Width-1:0];
assign noc_sender_if[{node_index}].vc_ready[{c}] = Noc_{x}_{y}_channel{c}_sender_vc_ready;
assign Noc_{x}_{y}_channel{c}_sender_is_header = noc_sender_if[{node_index}].flit[{c}][Noc_Data_Width+1];
assign Noc_{x}_{y}_channel{c}_sender_is_tail = noc_sender_if[{node_index}].flit[{c}][Noc_Data_Width];
    '''.format(node_index=node_index, x=x, y=y, c=c)
            connect_str += connect_str_port
connect_str += "\n\n"

code_str += connect_str

instance_str = '''Noc_fabric Noc_fabric_inst(
    .noc_clk            (noc_clk),
    .noc_rst_n          (noc_rst_n),
    .noc_receiver_if    (noc_receiver_if),
    .noc_sender_if      (noc_sender_if)
);'''

code_str += instance_str
code_str += "\n\nendmodule"

file = open("./Noc_fabric_verilog_interface.sv", 'w')
file.write(code_str)
file.close()

# --------------------------------- system file To verilog file -----------------------------------
code_str = '''/*
    created by: <Xidian University>
    created date: 2024-05-16
*/

`include "Noc_parameters.v"

module Noc_fabric_verilog_top
(
    input                           noc_clk,
    input                           noc_rst_n,

'''
for x in range(Noc_X_Size):
    for y in range(Noc_Y_Size):
        for c in range(Noc_channel):
            port_str = '''    input   [0:0]                   Noc_{x}_{y}_channel{c}_receive_valid,
    output  [0:0]                   Noc_{x}_{y}_channel{c}_receive_ready,
    input   [`Noc_Data_Width-1:0]   Noc_{x}_{y}_channel{c}_receive_flit,
    output  [0:0]                   Noc_{x}_{y}_channel{c}_receive_VCready,
    input   [0:0]                   Noc_{x}_{y}_channel{c}_receive_is_header,
    input   [0:0]                   Noc_{x}_{y}_channel{c}_receive_is_tail,

    output  [0:0]                   Noc_{x}_{y}_channel{c}_sender_valid,
    input   [0:0]                   Noc_{x}_{y}_channel{c}_sender_ready,
    output  [`Noc_Data_Width-1:0]   Noc_{x}_{y}_channel{c}_sender_flit,
    input   [0:0]                   Noc_{x}_{y}_channel{c}_sender_VCready,
    output  [0:0]                   Noc_{x}_{y}_channel{c}_sender_is_header,
    output  [0:0]                   Noc_{x}_{y}_channel{c}_sender_is_tail,'''.format(x=x, y=y, c=c)
            if x == Noc_X_Size - 1 and y == Noc_Y_Size - 1 and c == Noc_channel - 1:
                port_str = port_str[:-1] + '\n);'
            else:
                port_str = port_str + "\n\n"
            code_str += port_str

instance_str = '''\n\nNoc_fabric_verilog_interface Noc_fabric_verilog_interface_inst(\n'''
instance_str += '''    .noc_clk                             (noc_clk),
    .noc_rst_n                           (noc_rst_n),
'''
for x in range(Noc_X_Size):
    for y in range(Noc_Y_Size):
        for c in range(Noc_channel):
            instance_str_post = '''    .Noc_{x}_{y}_channel{c}_receive_valid      (Noc_{x}_{y}_channel{c}_receive_valid),
    .Noc_{x}_{y}_channel{c}_receive_ready      (Noc_{x}_{y}_channel{c}_receive_ready),
    .Noc_{x}_{y}_channel{c}_receive_flit       (Noc_{x}_{y}_channel{c}_receive_flit),
    .Noc_{x}_{y}_channel{c}_receive_vc_ready   (Noc_{x}_{y}_channel{c}_receive_VCready),
    .Noc_{x}_{y}_channel{c}_receive_is_header  (Noc_{x}_{y}_channel{c}_receive_is_header),
    .Noc_{x}_{y}_channel{c}_receive_is_tail    (Noc_{x}_{y}_channel{c}_receive_is_tail),

    .Noc_{x}_{y}_channel{c}_sender_valid       (Noc_{x}_{y}_channel{c}_sender_valid),
    .Noc_{x}_{y}_channel{c}_sender_ready       (Noc_{x}_{y}_channel{c}_sender_ready),
    .Noc_{x}_{y}_channel{c}_sender_flit        (Noc_{x}_{y}_channel{c}_sender_flit),
    .Noc_{x}_{y}_channel{c}_sender_vc_ready    (Noc_{x}_{y}_channel{c}_sender_VCready),
    .Noc_{x}_{y}_channel{c}_sender_is_header   (Noc_{x}_{y}_channel{c}_sender_is_header),
    .Noc_{x}_{y}_channel{c}_sender_is_tail     (Noc_{x}_{y}_channel{c}_sender_is_tail),'''.format(x=x, y=y, c=c)
            if x == Noc_X_Size - 1 and y == Noc_Y_Size - 1 and c == Noc_channel - 1:
                instance_str_post = instance_str_post[:-1] + '\n);'
            else:
                instance_str_post = instance_str_post + "\n\n"
            instance_str += instance_str_post

code_str += instance_str
code_str += "\n\nendmodule"

file = open("./Noc_fabric_verilog_top.v", 'w')
file.write(code_str)
file.close()

# ------------------------------------------- 桥接模块 -----------------------------------------------------
code_str = '''/*
    created by: <Xidian University>
    created date: 2024-05-16
*/

`include "Noc_parameters.v"

module Noc_bridge
(
    input                           noc_clk,
    input                           noc_rst_n,
    input   [0:0]                   Noc_receive_valid,
    output  [0:0]                   Noc_receive_ready,
    input   [`Noc_Data_Width-1:0]   Noc_receive_flit,
    input   [0:0]                   Noc_receive_is_header,
    input   [0:0]                   Noc_receive_is_tail,
'''
for c in range(Noc_channel):
    port_str = '''    output  [0:0]                   Noc_channel{c}_sender_valid,
    input   [0:0]                   Noc_channel{c}_sender_ready,
    output  [`Noc_Data_Width-1:0]   Noc_channel{c}_sender_flit,
    input   [0:0]                   Noc_channel{c}_sender_VCready,
    output  [0:0]                   Noc_channel{c}_sender_is_header,
    output  [0:0]                   Noc_channel{c}_sender_is_tail,'''.format(c=c)
    if c == Noc_channel - 1:
        port_str = port_str[:-1] + '\n);'
    else:
        port_str = port_str + "\n\n"
    code_str += port_str

code_str += '''
reg [`Noc_VC_Channel-1:0]   now_select_reg;

always @(posedge noc_clk or negedge noc_rst_n)begin                                                  
    if(!noc_rst_n) begin
        now_select_reg <= 1;
    end  
    else if (Noc_receive_is_tail)begin                                                                                
        if (Noc_channel0_sender_VCready) begin
            now_select_reg <= 1<<0;
        end
'''
for c in range(Noc_channel-1):
    port_str = '''        else if (Noc_channel{c}_sender_VCready)begin
            now_select_reg <= 1<<{c};
        end
    '''.format(c=c+1)
    code_str += port_str

code_str += '''end                                                                
end'''

code_str += '''
assign Noc_receive_ready = (now_select_reg[0]) ? Noc_channel0_sender_ready :'''
if Noc_channel == 1:
    code_str += ''' 0;

'''
else:
    for c in range(Noc_channel-1):
        port_str = '''
                            (now_select_reg[{c}]) ? Noc_channel{c}_sender_ready :'''.format(c=c+1)
        code_str += port_str
    code_str += ''' 0;

'''

for c in range(Noc_channel):
    port_str = '''assign Noc_channel{c}_sender_valid        = (now_select_reg[{c}]) ? Noc_receive_valid : 0;
assign Noc_channel{c}_sender_flit         = (now_select_reg[{c}]) ? Noc_receive_flit : 0;
assign Noc_channel{c}_sender_is_header    = (now_select_reg[{c}]) ? Noc_receive_is_header : 0;
assign Noc_channel{c}_sender_is_tail      = (now_select_reg[{c}]) ? Noc_receive_is_tail : 0;
'''.format(c=c)
    code_str += port_str

code_str += "\n\nendmodule"

file = open("./Noc_bridge.v", 'w')
file.write(code_str)
file.close()

# # ------------------------------------------------------ TCL 接线命令 ---------------------------------------------
#
# tcl_code = ''''''
# for x in range(Noc_X_Size):
#     for y in range(Noc_Y_Size):
#         tcl_code_port = '''startgroup
# create_bd_port -dir I -from 3 -to 0 Noc_{x}_{y}_receive_valid
# connect_bd_net [get_bd_pins /Noc_fabric_verilog_t_0/Noc_{x}_{y}_receive_valid] [get_bd_ports Noc_{x}_{y}_receive_valid]
# endgroup
# startgroup
# create_bd_port -dir I -from 127 -to 0 Noc_{x}_{y}_receive_flit
# connect_bd_net [get_bd_pins /Noc_fabric_verilog_t_0/Noc_{x}_{y}_receive_flit] [get_bd_ports Noc_{x}_{y}_receive_flit]
# endgroup
# startgroup
# create_bd_port -dir I -from 3 -to 0 Noc_{x}_{y}_sender_ready
# connect_bd_net [get_bd_pins /Noc_fabric_verilog_t_0/Noc_{x}_{y}_sender_ready] [get_bd_ports Noc_{x}_{y}_sender_ready]
# endgroup
# startgroup
# create_bd_port -dir I -from 3 -to 0 Noc_{x}_{y}_sender_vc_ready
# connect_bd_net [get_bd_pins /Noc_fabric_verilog_t_0/Noc_{x}_{y}_sender_vc_ready] [get_bd_ports Noc_{x}_{y}_sender_vc_ready]
# endgroup
# startgroup
# create_bd_port -dir O -from 3 -to 0 Noc_{x}_{y}_receive_ready
# connect_bd_net [get_bd_pins /Noc_fabric_verilog_t_0/Noc_{x}_{y}_receive_ready] [get_bd_ports Noc_{x}_{y}_receive_ready]
# endgroup
# startgroup
# create_bd_port -dir O -from 3 -to 0 Noc_{x}_{y}_receive_vc_ready
# connect_bd_net [get_bd_pins /Noc_fabric_verilog_t_0/Noc_{x}_{y}_receive_vc_ready] [get_bd_ports Noc_{x}_{y}_receive_vc_ready]
# endgroup
# startgroup
# create_bd_port -dir O -from 3 -to 0 Noc_{x}_{y}_sender_valid
# connect_bd_net [get_bd_pins /Noc_fabric_verilog_t_0/Noc_{x}_{y}_sender_valid] [get_bd_ports Noc_{x}_{y}_sender_valid]
# endgroup
# startgroup
# create_bd_port -dir O -from 127 -to 0 Noc_{x}_{y}_sender_flit
# connect_bd_net [get_bd_pins /Noc_fabric_verilog_t_0/Noc_{x}_{y}_sender_flit] [get_bd_ports Noc_{x}_{y}_sender_flit]
# endgroup
# '''.format(x=x, y=y)
#         tcl_code += tcl_code_port
#
# file = open("./Noc_fabric_verilog_top.tcl", 'w')
# file.write(tcl_code)
# file.close()
#
# # ---------------------------------------------------------- IP 接线命令 ------------------------------------------------
#
# tcl_code = ''''''
# for x in range(Noc_X_Size):
#     for y in range(Noc_Y_Size):
#         tcl_code_port = '''ipx::add_bus_interface Noc_{x}_{y}_receive [ipx::current_core]
# set_property abstraction_type_vlnv xidian:user:Noc_flit_interface_rtl:1.0 [ipx::get_bus_interfaces Noc_{x}_{y}_receive -of_objects [ipx::current_core]]
# set_property bus_type_vlnv xidian:user:Noc_flit_interface:1.0 [ipx::get_bus_interfaces Noc_{x}_{y}_receive -of_objects [ipx::current_core]]
# ipx::add_port_map valid [ipx::get_bus_interfaces Noc_{x}_{y}_receive -of_objects [ipx::current_core]]
# set_property physical_name Noc_{x}_{y}_receive_valid [ipx::get_port_maps valid -of_objects [ipx::get_bus_interfaces Noc_{x}_{y}_receive -of_objects [ipx::current_core]]]
# ipx::add_port_map flit [ipx::get_bus_interfaces Noc_{x}_{y}_receive -of_objects [ipx::current_core]]
# set_property physical_name Noc_{x}_{y}_receive_flit [ipx::get_port_maps flit -of_objects [ipx::get_bus_interfaces Noc_{x}_{y}_receive -of_objects [ipx::current_core]]]
# ipx::add_port_map vc_ready [ipx::get_bus_interfaces Noc_{x}_{y}_receive -of_objects [ipx::current_core]]
# set_property physical_name Noc_{x}_{y}_receive_vc_ready [ipx::get_port_maps vc_ready -of_objects [ipx::get_bus_interfaces Noc_{x}_{y}_receive -of_objects [ipx::current_core]]]
# ipx::add_port_map ready [ipx::get_bus_interfaces Noc_{x}_{y}_receive -of_objects [ipx::current_core]]
# set_property physical_name Noc_{x}_{y}_receive_ready [ipx::get_port_maps ready -of_objects [ipx::get_bus_interfaces Noc_{x}_{y}_receive -of_objects [ipx::current_core]]]
# ipx::add_bus_interface Noc_{x}_{y}_sender [ipx::current_core]
# set_property abstraction_type_vlnv xidian:user:Noc_flit_interface_rtl:1.0 [ipx::get_bus_interfaces Noc_{x}_{y}_sender -of_objects [ipx::current_core]]
# set_property bus_type_vlnv xidian:user:Noc_flit_interface:1.0 [ipx::get_bus_interfaces Noc_{x}_{y}_sender -of_objects [ipx::current_core]]
# set_property interface_mode master [ipx::get_bus_interfaces Noc_{x}_{y}_sender -of_objects [ipx::current_core]]
# ipx::add_port_map valid [ipx::get_bus_interfaces Noc_{x}_{y}_sender -of_objects [ipx::current_core]]
# set_property physical_name Noc_{x}_{y}_sender_valid [ipx::get_port_maps valid -of_objects [ipx::get_bus_interfaces Noc_{x}_{y}_sender -of_objects [ipx::current_core]]]
# ipx::add_port_map flit [ipx::get_bus_interfaces Noc_{x}_{y}_sender -of_objects [ipx::current_core]]
# set_property physical_name Noc_{x}_{y}_sender_flit [ipx::get_port_maps flit -of_objects [ipx::get_bus_interfaces Noc_{x}_{y}_sender -of_objects [ipx::current_core]]]
# ipx::add_port_map vc_ready [ipx::get_bus_interfaces Noc_{x}_{y}_sender -of_objects [ipx::current_core]]
# set_property physical_name Noc_{x}_{y}_sender_vc_ready [ipx::get_port_maps vc_ready -of_objects [ipx::get_bus_interfaces Noc_{x}_{y}_sender -of_objects [ipx::current_core]]]
# ipx::add_port_map ready [ipx::get_bus_interfaces Noc_{x}_{y}_sender -of_objects [ipx::current_core]]
# set_property physical_name Noc_{x}_{y}_sender_ready [ipx::get_port_maps ready -of_objects [ipx::get_bus_interfaces Noc_{x}_{y}_sender -of_objects [ipx::current_core]]]
# '''.format(x=x, y=y)
#         tcl_code += tcl_code_port
#
# file = open("./Noc_fabric_ip.tcl", 'w')
# file.write(tcl_code)
# file.close()