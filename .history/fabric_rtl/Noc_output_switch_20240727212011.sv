/*
    created by: <Xidian University>
    created date: 2024-05-16
*/

`timescale 1ns/1ps

module Noc_output_switch import Noc_parameters::*; 
#(
    parameter int       CHANNELS      = Noc_VC_Channel,
    parameter int       FLIT_WIDTH    = Noc_Flit_Width,
    parameter port_type Port_Type     = LOCAL
)
(
    input   var logic                 noc_clk,
    input   var logic                 noc_rst_n,
    Noc_flit_interface.receiver       receiver_if[5],
    Noc_flit_interface.sender         sender_if,
    input   var logic [4:0]           i_grant,
    output  var logic                 o_free
);

logic [4:0] port_ack;

always_comb begin
    o_free = |port_ack;
end

for (genvar i = 0; i < 5; i++) begin : g
    assign port_ack[i] = (receiver_if[i].valid & receiver_if[i].ready != 0) ? 1'b1 : 1'b0;
end

Noc_flit_interface #(.Channel(CHANNELS)) flit_if();
Noc_multi_case #(.N(5), .DataWidth(CHANNELS)) u_noc_case_valid();
Noc_multi_case #(.N(5), .DataWidth(FLIT_WIDTH)) u_noc_case_flit();

logic [4:0][CHANNELS-1:0]   valid;
logic [4:0][FLIT_WIDTH-1:0] flit;

for (genvar i = 0;i < 5; i = i + 1) begin : gggg
    always_comb begin
        valid[i]                = receiver_if[i].valid;
        flit[i]                 = receiver_if[i].flit[0];
        receiver_if[i].ready    = (i_grant[i]) ? flit_if.ready : '0;
        receiver_if[i].vc_ready = (i_grant[i]) ? flit_if.vc_ready : '0;
    end
end

assign  flit_if.valid = u_noc_case_valid.set_case(i_grant, valid);
assign  flit_if.flit[0]  = u_noc_case_flit.set_case(i_grant, flit);

logic [127:0]   m_flit_data;
logic m_is_header, m_is_tail;
logic [127:0]   s_flit_data;
logic s_is_header, s_is_tail;
assign  m_flit_data = flit_if.flit[0][127:0];
assign  m_is_header = flit_if.flit[0][129];
assign  m_is_tail   = flit_if.flit[0][128];
assign  s_flit_data = sender_if.flit[0][127:0];
assign  s_is_header = sender_if.flit[0][129];
assign  s_is_tail   = sender_if.flit[0][128];

Noc_flit_interface_fifo #(
    .CHANNELS       (CHANNELS           ),
    .DEPTH          (Noc_VC_Fifo_Depth  ),
    .THRESHOLD      (Noc_VC_Fifo_Depth-2),
    .DATA_FF_OUT    (0                  ),
    .Port_Type      (Port_Type          )
) u_fifo (
    .noc_clk        (noc_clk        ),
    .noc_rst_n      (noc_rst_n      ),
    .i_clear        ('0             ),
    .o_empty        (               ),
    .o_almost_full  (               ),
    .o_full         (               ),
    .receiver_if    (flit_if        ),
    .sender_if      (sender_if      )
);

endmodule