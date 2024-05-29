/*
    created by: <Xidian University>
    created date: 2024-05-16
*/

`ifndef NOC_CONTROL_INTERFACE_SV
`define NOC_CONTROL_INTERFACE_SV

interface Noc_control_interface import Noc_parameters::*;
#(
    parameter int   Channel     = Noc_VC_Channel
)();

logic [Channel-1:0]  request;
logic [Channel-1:0]  grant;
logic [Channel-1:0]  free;
logic [Channel-1:0]  start_of_packet;
logic [Channel-1:0]  end_of_packet;

modport requester (
    output  request,
    input   grant,
    output  free,
    output  start_of_packet,
    output  end_of_packet
);

modport controller (
    input   request,
    output  grant,
    input   free,
    input   start_of_packet,
    input   end_of_packet
);

endinterface

`endif