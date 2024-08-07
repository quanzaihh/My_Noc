/*
    created by: <Xidian University>
    created date: 2024-05-16
*/

module Noc_fabric_verilog_interface import Noc_parameters::*;
(
    input                           noc_clk,
    input                           noc_rst_n,

    input   [0:0]                   Noc_0_0_channel0_receive_valid,
    output  [0:0]                   Noc_0_0_channel0_receive_ready,
    input   [Noc_Data_Width-1:0]    Noc_0_0_channel0_receive_flit,
    output  [0:0]                   Noc_0_0_channel0_receive_vc_ready,
    input   [0:0]                   Noc_0_0_channel0_receive_is_header,
    input   [0:0]                   Noc_0_0_channel0_receive_is_tail,
    input   [0:0]                   Noc_0_0_channel1_receive_valid,
    output  [0:0]                   Noc_0_0_channel1_receive_ready,
    input   [Noc_Data_Width-1:0]    Noc_0_0_channel1_receive_flit,
    output  [0:0]                   Noc_0_0_channel1_receive_vc_ready,
    input   [0:0]                   Noc_0_0_channel1_receive_is_header,
    input   [0:0]                   Noc_0_0_channel1_receive_is_tail,
 
    output  [0:0]                   Noc_0_0_sender_valid,
    input   [0:0]                   Noc_0_0_sender_ready,
    output  [Noc_Data_Width-1:0]    Noc_0_0_sender_flit,
    input   [0:0]                   Noc_0_0_sender_vc_ready,
    output  [0:0]                   Noc_0_0_sender_is_header,
    output  [0:0]                   Noc_0_0_sender_is_tail,

    input   [0:0]                   Noc_0_1_channel0_receive_valid,
    output  [0:0]                   Noc_0_1_channel0_receive_ready,
    input   [Noc_Data_Width-1:0]    Noc_0_1_channel0_receive_flit,
    output  [0:0]                   Noc_0_1_channel0_receive_vc_ready,
    input   [0:0]                   Noc_0_1_channel0_receive_is_header,
    input   [0:0]                   Noc_0_1_channel0_receive_is_tail,
    input   [0:0]                   Noc_0_1_channel1_receive_valid,
    output  [0:0]                   Noc_0_1_channel1_receive_ready,
    input   [Noc_Data_Width-1:0]    Noc_0_1_channel1_receive_flit,
    output  [0:0]                   Noc_0_1_channel1_receive_vc_ready,
    input   [0:0]                   Noc_0_1_channel1_receive_is_header,
    input   [0:0]                   Noc_0_1_channel1_receive_is_tail,
 
    output  [0:0]                   Noc_0_1_sender_valid,
    input   [0:0]                   Noc_0_1_sender_ready,
    output  [Noc_Data_Width-1:0]    Noc_0_1_sender_flit,
    input   [0:0]                   Noc_0_1_sender_vc_ready,
    output  [0:0]                   Noc_0_1_sender_is_header,
    output  [0:0]                   Noc_0_1_sender_is_tail,

    input   [0:0]                   Noc_1_0_channel0_receive_valid,
    output  [0:0]                   Noc_1_0_channel0_receive_ready,
    input   [Noc_Data_Width-1:0]    Noc_1_0_channel0_receive_flit,
    output  [0:0]                   Noc_1_0_channel0_receive_vc_ready,
    input   [0:0]                   Noc_1_0_channel0_receive_is_header,
    input   [0:0]                   Noc_1_0_channel0_receive_is_tail,
    input   [0:0]                   Noc_1_0_channel1_receive_valid,
    output  [0:0]                   Noc_1_0_channel1_receive_ready,
    input   [Noc_Data_Width-1:0]    Noc_1_0_channel1_receive_flit,
    output  [0:0]                   Noc_1_0_channel1_receive_vc_ready,
    input   [0:0]                   Noc_1_0_channel1_receive_is_header,
    input   [0:0]                   Noc_1_0_channel1_receive_is_tail,
 
    output  [0:0]                   Noc_1_0_sender_valid,
    input   [0:0]                   Noc_1_0_sender_ready,
    output  [Noc_Data_Width-1:0]    Noc_1_0_sender_flit,
    input   [0:0]                   Noc_1_0_sender_vc_ready,
    output  [0:0]                   Noc_1_0_sender_is_header,
    output  [0:0]                   Noc_1_0_sender_is_tail,

    input   [0:0]                   Noc_1_1_channel0_receive_valid,
    output  [0:0]                   Noc_1_1_channel0_receive_ready,
    input   [Noc_Data_Width-1:0]    Noc_1_1_channel0_receive_flit,
    output  [0:0]                   Noc_1_1_channel0_receive_vc_ready,
    input   [0:0]                   Noc_1_1_channel0_receive_is_header,
    input   [0:0]                   Noc_1_1_channel0_receive_is_tail,
    input   [0:0]                   Noc_1_1_channel1_receive_valid,
    output  [0:0]                   Noc_1_1_channel1_receive_ready,
    input   [Noc_Data_Width-1:0]    Noc_1_1_channel1_receive_flit,
    output  [0:0]                   Noc_1_1_channel1_receive_vc_ready,
    input   [0:0]                   Noc_1_1_channel1_receive_is_header,
    input   [0:0]                   Noc_1_1_channel1_receive_is_tail,
 
    output  [0:0]                   Noc_1_1_sender_valid,
    input   [0:0]                   Noc_1_1_sender_ready,
    output  [Noc_Data_Width-1:0]    Noc_1_1_sender_flit,
    input   [0:0]                   Noc_1_1_sender_vc_ready,
    output  [0:0]                   Noc_1_1_sender_is_header,
    output  [0:0]                   Noc_1_1_sender_is_tail
);

Noc_flit_interface #(.Port_Type(LOCAL)) noc_receiver_if[Noc_Node_Num]();
Noc_flit_interface #()                  noc_sender_if[Noc_Node_Num]();  
assign noc_receiver_if[0].valid[0] = Noc_0_0_channel0_receive_valid;
assign Noc_0_0_channel0_receive_ready = noc_receiver_if[0].ready[0];
assign noc_receiver_if[0].flit[0] = {Noc_0_0_channel0_receive_is_header, Noc_0_0_channel0_receive_is_tail, Noc_0_0_channel0_receive_flit};
assign Noc_0_0_channel0_receive_vc_ready = noc_receiver_if[0].vc_ready[0];
      
assign noc_receiver_if[0].valid[1] = Noc_0_0_channel1_receive_valid;
assign Noc_0_0_channel1_receive_ready = noc_receiver_if[0].ready[1];
assign noc_receiver_if[0].flit[1] = {Noc_0_0_channel1_receive_is_header, Noc_0_0_channel1_receive_is_tail, Noc_0_0_channel1_receive_flit};
assign Noc_0_0_channel1_receive_vc_ready = noc_receiver_if[0].vc_ready[1];
    
assign Noc_0_0_sender_valid = noc_sender_if[0].valid[0];
assign noc_sender_if[0].ready[0] = Noc_0_0_sender_ready;
assign Noc_0_0_sender_flit = noc_sender_if[0].flit[0][Noc_Data_Width-1:0];
assign noc_sender_if[0].vc_ready[0] = Noc_0_0_sender_vc_ready;
assign Noc_0_0_sender_is_header = noc_sender_if[0].flit[0][Noc_Data_Width+1];
assign Noc_0_0_sender_is_tail = noc_sender_if[0].flit[0][Noc_Data_Width];
  
assign noc_receiver_if[2].valid[0] = Noc_0_1_channel0_receive_valid;
assign Noc_0_1_channel0_receive_ready = noc_receiver_if[2].ready[0];
assign noc_receiver_if[2].flit[0] = {Noc_0_1_channel0_receive_is_header, Noc_0_1_channel0_receive_is_tail, Noc_0_1_channel0_receive_flit};
assign Noc_0_1_channel0_receive_vc_ready = noc_receiver_if[2].vc_ready[0];
      
assign noc_receiver_if[2].valid[1] = Noc_0_1_channel1_receive_valid;
assign Noc_0_1_channel1_receive_ready = noc_receiver_if[2].ready[1];
assign noc_receiver_if[2].flit[1] = {Noc_0_1_channel1_receive_is_header, Noc_0_1_channel1_receive_is_tail, Noc_0_1_channel1_receive_flit};
assign Noc_0_1_channel1_receive_vc_ready = noc_receiver_if[2].vc_ready[1];
    
assign Noc_0_1_sender_valid = noc_sender_if[2].valid[0];
assign noc_sender_if[2].ready[0] = Noc_0_1_sender_ready;
assign Noc_0_1_sender_flit = noc_sender_if[2].flit[0][Noc_Data_Width-1:2];
assign noc_sender_if[2].vc_ready[0] = Noc_0_1_sender_vc_ready;
assign Noc_0_1_sender_is_header = noc_sender_if[2].flit[0][Noc_Data_Width+1];
assign Noc_0_1_sender_is_tail = noc_sender_if[2].flit[0][Noc_Data_Width];
  
assign noc_receiver_if[1].valid[0] = Noc_1_0_channel0_receive_valid;
assign Noc_1_0_channel0_receive_ready = noc_receiver_if[1].ready[0];
assign noc_receiver_if[1].flit[0] = {Noc_1_0_channel0_receive_is_header, Noc_1_0_channel0_receive_is_tail, Noc_1_0_channel0_receive_flit};
assign Noc_1_0_channel0_receive_vc_ready = noc_receiver_if[1].vc_ready[0];
      
assign noc_receiver_if[1].valid[1] = Noc_1_0_channel1_receive_valid;
assign Noc_1_0_channel1_receive_ready = noc_receiver_if[1].ready[1];
assign noc_receiver_if[1].flit[1] = {Noc_1_0_channel1_receive_is_header, Noc_1_0_channel1_receive_is_tail, Noc_1_0_channel1_receive_flit};
assign Noc_1_0_channel1_receive_vc_ready = noc_receiver_if[1].vc_ready[1];
    
assign Noc_1_0_sender_valid = noc_sender_if[1].valid[0];
assign noc_sender_if[1].ready[0] = Noc_1_0_sender_ready;
assign Noc_1_0_sender_flit = noc_sender_if[1].flit[0][Noc_Data_Width-1:1];
assign noc_sender_if[1].vc_ready[0] = Noc_1_0_sender_vc_ready;
assign Noc_1_0_sender_is_header = noc_sender_if[1].flit[0][Noc_Data_Width+1];
assign Noc_1_0_sender_is_tail = noc_sender_if[1].flit[0][Noc_Data_Width];
  
assign noc_receiver_if[3].valid[0] = Noc_1_1_channel0_receive_valid;
assign Noc_1_1_channel0_receive_ready = noc_receiver_if[3].ready[0];
assign noc_receiver_if[3].flit[0] = {Noc_1_1_channel0_receive_is_header, Noc_1_1_channel0_receive_is_tail, Noc_1_1_channel0_receive_flit};
assign Noc_1_1_channel0_receive_vc_ready = noc_receiver_if[3].vc_ready[0];
      
assign noc_receiver_if[3].valid[1] = Noc_1_1_channel1_receive_valid;
assign Noc_1_1_channel1_receive_ready = noc_receiver_if[3].ready[1];
assign noc_receiver_if[3].flit[1] = {Noc_1_1_channel1_receive_is_header, Noc_1_1_channel1_receive_is_tail, Noc_1_1_channel1_receive_flit};
assign Noc_1_1_channel1_receive_vc_ready = noc_receiver_if[3].vc_ready[1];
    
assign Noc_1_1_sender_valid = noc_sender_if[3].valid[0];
assign noc_sender_if[3].ready[0] = Noc_1_1_sender_ready;
assign Noc_1_1_sender_flit = noc_sender_if[3].flit[0][Noc_Data_Width-1:3];
assign noc_sender_if[3].vc_ready[0] = Noc_1_1_sender_vc_ready;
assign Noc_1_1_sender_is_header = noc_sender_if[3].flit[0][Noc_Data_Width+1];
assign Noc_1_1_sender_is_tail = noc_sender_if[3].flit[0][Noc_Data_Width];


Noc_fabric Noc_fabric_inst(
    .noc_clk            (noc_clk),
    .noc_rst_n          (noc_rst_n),
    .noc_receiver_if    (noc_receiver_if),
    .noc_sender_if      (noc_sender_if)
);

endmodule