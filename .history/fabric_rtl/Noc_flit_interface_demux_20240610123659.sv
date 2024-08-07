/*
    created by: <Xidian University>
    created date: 2024-05-16
*/

`timescale 1ns/1ps

module Noc_flit_interface_demux
	import  Noc_parameters::*;
#(
    parameter int   CHANNELS  = Noc_VC_Channel,
    parameter int   ENTRIES   = 2
)(
    input var logic [ENTRIES-1:0]     i_select,
	Noc_flit_interface.receiver       receiver_if,
	Noc_flit_interface.sender         sender_if[ENTRIES]
);

logic [ENTRIES-1:0][CHANNELS-1:0] ready;
logic [ENTRIES-1:0][CHANNELS-1:0] vc_ready;

for (genvar i = 0;i < ENTRIES;++i) begin : g
    assign  sender_if[i].valid  = (i_select[i]) ? receiver_if.valid : 1'b0;
    assign  ready[i]            = sender_if[i].ready;
    assign  vc_ready[i]         = sender_if[i].vc_ready;
end

Noc_multi_case #(.N(ENTRIES), .DataWidth(CHANNELS)) u_Noc_multi_case_ready();
Noc_multi_case #(.N(ENTRIES), .DataWidth(CHANNELS)) u_Noc_multi_case_vc_ready();

assign receiver_if.ready = u_Noc_multi_case_ready.set_case(i_select, ready);
assign receiver_if.vc_ready = u_Noc_multi_case_vc_ready.set_case(i_select, vc_ready);

for (genvar i = 0;i < ENTRIES;++i) begin : g_flit
    assign sender_if[i].flit = receiver_if.flit;
end

endmodule