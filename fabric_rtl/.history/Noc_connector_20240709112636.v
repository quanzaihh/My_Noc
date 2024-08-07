/*
    created by: <Xidian University>
    created date: 2024-05-16
*/

`include "Noc_parameters.v"

module Noc_connector
(
    input                           noc_clk,
    input                           noc_rst_n,

    input   [0:0]                   Noc_0_0_receive_valid,
    output  [0:0]                   Noc_0_0_receive_ready,
    input   [`Noc_Data_Width-1:0]   Noc_0_0_receive_flit,
    input   [0:0]                   Noc_0_0_receive_is_header,
    input   [0:0]                   Noc_0_0_receive_is_tail,
    
    output  [0:0]                   Noc_0_0_sender_valid,
    input   [0:0]                   Noc_0_0_sender_ready,
    output  [`Noc_Data_Width-1:0]   Noc_0_0_sender_flit,
    input   [0:0]                   Noc_0_0_sender_VCready,
    output  [0:0]                   Noc_0_0_sender_is_header,
    output  [0:0]                   Noc_0_0_sender_is_tail,

    input   [0:0]                   Noc_0_1_receive_valid,
    output  [0:0]                   Noc_0_1_receive_ready,
    input   [`Noc_Data_Width-1:0]   Noc_0_1_receive_flit,
    input   [0:0]                   Noc_0_1_receive_is_header,
    input   [0:0]                   Noc_0_1_receive_is_tail,
    
    output  [0:0]                   Noc_0_1_sender_valid,
    input   [0:0]                   Noc_0_1_sender_ready,
    output  [`Noc_Data_Width-1:0]   Noc_0_1_sender_flit,
    input   [0:0]                   Noc_0_1_sender_VCready,
    output  [0:0]                   Noc_0_1_sender_is_header,
    output  [0:0]                   Noc_0_1_sender_is_tail,

    input   [0:0]                   Noc_1_0_receive_valid,
    output  [0:0]                   Noc_1_0_receive_ready,
    input   [`Noc_Data_Width-1:0]   Noc_1_0_receive_flit,
    input   [0:0]                   Noc_1_0_receive_is_header,
    input   [0:0]                   Noc_1_0_receive_is_tail,
    
    output  [0:0]                   Noc_1_0_sender_valid,
    input   [0:0]                   Noc_1_0_sender_ready,
    output  [`Noc_Data_Width-1:0]   Noc_1_0_sender_flit,
    input   [0:0]                   Noc_1_0_sender_VCready,
    output  [0:0]                   Noc_1_0_sender_is_header,
    output  [0:0]                   Noc_1_0_sender_is_tail,

    input   [0:0]                   Noc_1_1_receive_valid,
    output  [0:0]                   Noc_1_1_receive_ready,
    input   [`Noc_Data_Width-1:0]   Noc_1_1_receive_flit,
    input   [0:0]                   Noc_1_1_receive_is_header,
    input   [0:0]                   Noc_1_1_receive_is_tail,
    
    output  [0:0]                   Noc_1_1_sender_valid,
    input   [0:0]                   Noc_1_1_sender_ready,
    output  [`Noc_Data_Width-1:0]   Noc_1_1_sender_flit,
    input   [0:0]                   Noc_1_1_sender_VCready,
    output  [0:0]                   Noc_1_1_sender_is_header,
    output  [0:0]                   Noc_1_1_sender_is_tail
);

endmodule