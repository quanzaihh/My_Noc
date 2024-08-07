`timescale 1ns / 1ps
/*
    created by: <Xidian University>
    created date: 2024-05-16
*/
`include "Noc_parameters.v"

module Noc_connector(
    input                           noc_clk,
    input                           rst_n,    
    input   [0:0]                   Noc_0_0_receive_valid,
    output  [0:0]                   Noc_0_0_receive_ready,
    input   [`Noc_Data_Width-1:0]   Noc_0_0_receive_flit,
    input   [0:0]                   Noc_0_0_receive_is_header,
    input   [0:0]                   Noc_0_0_receive_is_tail             
);


                                                                   
                                                                   
endmodule