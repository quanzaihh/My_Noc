`timescale 1ns / 1ps
/*
    created by: <Xidian University>
    created date: 2024-05-16
*/
`include "Noc_parameters.v"

module Noc_bridge(
    input                           noc_clk,
    input                           rst_n,    
    input   [0:0]                   Noc_receive_valid,
    output  [0:0]                   Noc_receive_ready,
    input   [`Noc_Data_Width-1:0]   Noc_receive_flit,
    output  [0:0]                   Noc_receive_VCready,
    input   [0:0]                   Noc_receive_is_header,
    input   [0:0]                   Noc_receive_is_tail,

    output  [0:0]                   Noc_sender_channel0_valid,
    input   [0:0]                   Noc_sender_channel0_ready,
    output  [`Noc_Data_Width-1:0]   Noc_sender_channel0_flit,
    input   [0:0]                   Noc_sender_channel0_VCready,
    output  [0:0]                   Noc_sender_channel0_is_header,
    output  [0:0]                   Noc_sender_channel0_is_tail
);


                                                                   
                                                                   
endmodule