/*
    created by: <Xidian University>
    created date: 2024-05-16
*/

`timescale 1ns/1ps

module Noc_vc_merge import Noc_parameters::*;
# (
    parameter CHANNELS = Noc_VC_Channel
)
(
    input var logic                         noc_clk,
    input var logic                         noc_rst_n,
    input var logic [CHANNELS-1:0]          vc_grant,
    Noc_flit_interface.receiver             receiver_if[CHANNELS],
    Noc_flit_interface.sender               sender_if
);

logic [CHANNELS-1:0][Noc_Flit_Width-1:0]  flit;
Noc_flit_interface fifo_filt();

for (genvar i = 0;i < CHANNELS;++i) begin : g
    assign fifo_filt.valid[i]       = (vc_grant[i]) ? receiver_if[i].valid : '0;
    assign receiver_if[i].ready     = (vc_grant[i]) ? fifo_filt.ready[i] : '0;
    assign flit[i]                  = receiver_if[i].flit[0];
    assign receiver_if[i].vc_ready  = fifo_filt.vc_ready[i];
end

Noc_multi_case #(.N(CHANNELS),.DataWidth(Noc_Flit_Width)) noc_case_flit();

assign fifo_filt.flit[0] = noc_case_flit.set_case(vc_grant, flit);

/*------------ fifo 缓存 ------------*/
Noc_flit_interface_fifo #(
    .CHANNELS       (CHANNELS             ),
    .DEPTH          (Noc_VC_Fifo_Depth    ),
    .THRESHOLD      (Noc_VC_Fifo_Depth -2 ),
    .DATA_FF_OUT    (0                    )
) merge_fifo (
    .noc_clk        (noc_clk        ),
    .noc_rst_n      (noc_rst_n      ),
    .i_clear        ('0             ),
    .o_empty        (               ),
    .o_almost_full  (               ),
    .o_full         (               ),
    .receiver_if    (fifo_filt      ),
    .sender_if      (sender_if      )
);

endmodule