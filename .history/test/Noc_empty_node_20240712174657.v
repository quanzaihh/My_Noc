/*
    created by: <Xidian University>
    created date: 2024-05-16
*/

`include "../fabric_rtl/Noc_parameters.v"

module Noc_empty_node(
    input                           noc_clk,
    input                           noc_rst_n,

    input   [0:0]                   receive_valid,
    output  [0:0]                   receive_ready,
    input   [`Noc_Data_Width-1:0]   receive_flit,
    input   [0:0]                   receive_is_header,
    input   [0:0]                   receive_is_tail,
    
    output  reg[0:0]                sender_valid,
    input   [0:0]                   sender_ready,
    output  reg[`Noc_Data_Width-1:0]sender_flit,
    output  reg[0:0]                sender_is_header,
    output  reg[0:0]                sender_is_tail
);

assign receive_ready = 0;




endmodule