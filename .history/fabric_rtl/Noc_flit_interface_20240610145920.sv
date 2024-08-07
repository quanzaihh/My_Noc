/*
    created by: <Xidian University>
    created date: 2024-05-16
*/

`timescale 1ns/1ps

`ifndef NOC_FLIT_INTERFACE_SV
`define NOC_FLIT_INTERFACE_SV

interface Noc_flit_interface import Noc_parameters::*;
#(
    parameter int       Channel     = Noc_VC_Channel,
    parameter int       Flit_width  = Noc_Flit_Width,
    parameter port_type Port_Type   = INTERNAL,
    parameter int       Flit_Num    = (Port_Type) ? 1 : Noc_VC_Channel
)();

//--------------------------------------------------------------
//  Variable declarations
//--------------------------------------------------------------
logic [Channel-1:0]         valid;
logic [Channel-1:0]         ready;
logic [Data_width-1:0]      flit[Flit_Num];
logic [Channel-1:0]         vc_ready;


//--------------------------------------------------------------
//  Modport
//--------------------------------------------------------------
modport sender (            
    output  valid,
    input   ready,
    output  flit,
    input   vc_ready,
    import  is_header,
    import  is_tail
);

modport receiver (
    input   valid,
    output  ready,
    input   flit,
    output  vc_ready,
    import  is_header,
    import  is_tail
);

// header check function
function automatic logic is_header(int channel);
    return ((flit[channel][Noc_Data_Width-1:Noc_Point_H] == Noc_Head_H)
            && (flit[channel][Axi_Len_Point-1:Noc_Point_E] == Noc_Head_E)) ? 1'b1 : 1'b0;
endfunction

// tail check function
function automatic logic is_tail(int channel);
    return ((flit[channel][Noc_Data_Width-1:Noc_Point_H] == Noc_Tail_H)
            && (flit[channel][Axi_Len_Point-1:Noc_Point_E] == Noc_Tail_E)) ? 1'b1 : 1'b0;
endfunction

endinterface

`endif