`timescale 1ns / 1ps
/*
    created by: <Xidian University>
    created date: 2024-05-16
*/
`include "Noc_parameters.v"

module Noc_bridge(
    input                           noc_clk,
    input                           noc_rst_n,    
    input   [0:0]                   Noc_receive_valid,
    output  [0:0]                   Noc_receive_ready,
    input   [`Noc_Data_Width-1:0]   Noc_receive_flit,
    input   [0:0]                   Noc_receive_is_header,
    input   [0:0]                   Noc_receive_is_tail,

    output  [0:0]                   Noc_sender_channel0_valid,
    input   [0:0]                   Noc_sender_channel0_ready,
    output  [`Noc_Data_Width-1:0]   Noc_sender_channel0_flit,
    input   [0:0]                   Noc_sender_channel0_VCready,
    output  [0:0]                   Noc_sender_channel0_is_header,
    output  [0:0]                   Noc_sender_channel0_is_tail,

    output  [0:0]                   Noc_sender_channel1_valid,
    input   [0:0]                   Noc_sender_channel1_ready,
    output  [`Noc_Data_Width-1:0]   Noc_sender_channel1_flit,
    input   [0:0]                   Noc_sender_channel1_VCready,
    output  [0:0]                   Noc_sender_channel1_is_header,
    output  [0:0]                   Noc_sender_channel1_is_tail
);

reg [`Noc_VC_Channel-1:0]   now_select_reg;

always @(posedge noc_clk or negedge noc_rst_n)begin                                                  
    if(!noc_rst_n) begin
        now_select_reg <= 1;
    end  
    else if (Noc_receive_is_tail)begin                                                                                
        if (Noc_sender_channel0_VCready) begin
            now_select_reg <= 1<<0;
        end
        else if (Noc_sender_channel1_VCready)begin
            now_select_reg <= 1<<1;
        end   
    end                                                                
end

assign Noc_receive_ready = (now_select_reg[0]) ? Noc_sender_channel0_ready :
                            (now_select_reg[1]) ? Noc_sender_channel1_ready : 0;

assign Noc_sender_channel0_valid        = (now_select_reg[0]) ? Noc_receive_valid : 0;
assign Noc_sender_channel0_flit         = (now_select_reg[0]) ? Noc_receive_flit : 0;
assign Noc_sender_channel0_is_header    = (now_select_reg[0]) ? Noc_receive_is_header : 0;
assign Noc_sender_channel0_is_tail      = (now_select_reg[0]) ? Noc_receive_is_tail : 0;

assign Noc_sender_channel1_valid        = (now_select_reg[1]) ? Noc_receive_valid : 0;
assign Noc_sender_channel1_flit         = (now_select_reg[1]) ? Noc_receive_flit : 0;
assign Noc_sender_channel1_is_header    = (now_select_reg[1]) ? Noc_receive_is_header : 0;
assign Noc_sender_channel1_is_tail      = (now_select_reg[1]) ? Noc_receive_is_tail : 0;


                                                                   
                                                                   
endmodule