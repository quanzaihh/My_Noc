/*
    created by: <Xidian University>
    created date: 2024-05-16
*/

`include "../fabric_rtl/Noc_parameters.v"

module Noc_test_node_verilog
# (
    parameter bit [Noc_ID_X_Width-1:0] X_ID = 0,
    parameter bit [Noc_ID_Y_Width-1:0] Y_ID = 0
)
(
    input                           noc_clk,
    input                           noc_rst_n,
    input                           send_start,

    input   [0:0]                   receive_valid,
    output  [0:0]                   receive_ready,
    input   [`Noc_Data_Width-1:0]   receive_flit,
    input   [0:0]                   receive_is_header,
    input   [0:0]                   receive_is_tail,
    
    output  [0:0]                   sender_valid,
    input   [0:0]                   sender_ready,
    output  [`Noc_Data_Width-1:0]   sender_flit,
    output  [0:0]                   sender_is_header,
    output  [0:0]                   sender_is_tail
);


endmodule