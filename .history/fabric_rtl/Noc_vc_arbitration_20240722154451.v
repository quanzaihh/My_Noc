/*
    created by: <Xidian University>
    created date: 2024-05-16
*/

`include "Noc_parameters.v"

module Noc_vc_arbitration
(
    input                           noc_clk,
    input                           noc_rst_n,
    input   [0:0]                   Noc_receive_valid,
    output  [0:0]                   Noc_receive_ready,
    input   [`Noc_Data_Width-1:0]   Noc_receive_flit,
    input   [0:0]                   Noc_receive_is_header,
    input   [0:0]                   Noc_receive_is_tail,
    output  [0:0]                   Noc_channel0_sender_valid,
    input   [0:0]                   Noc_channel0_sender_ready,
    output  [`Noc_Data_Width-1:0]   Noc_channel0_sender_flit,
    input   [0:0]                   Noc_channel0_sender_VCready,
    output  [0:0]                   Noc_channel0_sender_is_header,
    output  [0:0]                   Noc_channel0_sender_is_tail,

    output  [0:0]                   Noc_channel1_sender_valid,
    input   [0:0]                   Noc_channel1_sender_ready,
    output  [`Noc_Data_Width-1:0]   Noc_channel1_sender_flit,
    input   [0:0]                   Noc_channel1_sender_VCready,
    output  [0:0]                   Noc_channel1_sender_is_header,
    output  [0:0]                   Noc_channel1_sender_is_tail
);
reg [`Noc_VC_Channel-1:0]   now_select_reg;

always @(posedge noc_clk or negedge noc_rst_n)begin                                                  
    if(!noc_rst_n) begin
        now_select_reg <= 1;
    end  
    else if (Noc_receive_is_tail)begin                                                                                
        if (Noc_channel0_sender_VCready) begin
            now_select_reg <= 1<<0;
        end
        else if (Noc_channel1_sender_VCready)begin
            now_select_reg <= 1<<1;
        end
    end                                                                
end
assign Noc_receive_ready = (now_select_reg[0]) ? Noc_channel0_sender_ready :
                            (now_select_reg[1]) ? Noc_channel1_sender_ready : 0;

assign Noc_channel0_sender_valid        = (now_select_reg[0]) ? Noc_receive_valid : 0;
assign Noc_channel0_sender_flit         = (now_select_reg[0]) ? Noc_receive_flit : 0;
assign Noc_channel0_sender_is_header    = (now_select_reg[0]) ? Noc_receive_is_header : 0;
assign Noc_channel0_sender_is_tail      = (now_select_reg[0]) ? Noc_receive_is_tail : 0;
assign Noc_channel1_sender_valid        = (now_select_reg[1]) ? Noc_receive_valid : 0;
assign Noc_channel1_sender_flit         = (now_select_reg[1]) ? Noc_receive_flit : 0;
assign Noc_channel1_sender_is_header    = (now_select_reg[1]) ? Noc_receive_is_header : 0;
assign Noc_channel1_sender_is_tail      = (now_select_reg[1]) ? Noc_receive_is_tail : 0;


endmodule