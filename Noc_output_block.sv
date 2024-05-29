/*
    created by: <Xidian University>
    created date: 2024-05-16
*/

module Noc_output_block import Noc_parameters::*; 
#(
    parameter int       CHANNELS      = Noc_VC_Channel,
    parameter int       DATA_WIDTH    = Noc_Data_Width
)
(
    input var logic                   noc_clk,
    input var logic                   noc_rst_n,
    Noc_flit_interface.receiver       receiver_if[5],
    Noc_flit_interface.sender         sender_if,
    Noc_control_interface.controller  port_control_if[5]
);

//--------------------------------------------------------------
//  Port controller
//--------------------------------------------------------------
Noc_flit_interface #(.Channel(1)) port_if[5]();

logic [4:0] output_grant;
logic       output_free;

Noc_port_control u_port_control(
    .noc_clk          ( noc_clk            ),
    .noc_rst_n        ( noc_rst_n          ),
    .vc_ready         ( sender_if.vc_ready ),
    .port_control_if  ( port_control_if    ),
    .grant_o          ( output_grant       ),
    .free_i           ( output_free        ) 
);

//--------------------------------------------------------------
//  Switch
//--------------------------------------------------------------
logic [4:0] port_ack;
always_comb begin
    output_free = |port_ack;
end

for (genvar i = 0; i < 5; i = i + 1) begin : g
    always_comb begin
        port_ack[i] = ((receiver_if[i].valid & receiver_if[i].ready) != '0) ? '1 : '0;
    end
end

logic [4:0][CHANNELS-1:0]   valid;
logic [4:0][DATA_WIDTH-1:0] flit;

Noc_multi_case #(.N(5), .DataWidth(CHANNELS)) u_noc_case_valid();
Noc_multi_case #(.N(5), .DataWidth(DATA_WIDTH)) u_noc_case_flit();
Noc_flit_interface flit_if();

for (genvar i = 0;i < 5; i = i + 1) begin : gggg
    assign  valid[i]                = receiver_if[i].valid;
    assign  flit[i]                 = receiver_if[i].flit;
    assign  receiver_if[i].ready    = (output_grant[i]) ? flit_if.ready : '0;
    assign  receiver_if[i].vc_ready = (output_grant[i]) ? flit_if.vc_ready : '0;
end

assign  flit_if.valid = u_noc_case_valid.set_case(output_grant, valid);
assign  flit_if.flit  = u_noc_case_flit.set_case(output_grant, flit);

Noc_flit_interface_fifo #(
    .CHANNELS       ( CHANNELS           ),
    .DEPTH          ( Noc_VC_Fifo_Depth  ),
    .THRESHOLD      ( Noc_VC_Fifo_Depth-2),
    .DATA_FF_OUT    ( 0                  )
) u_fifo (
    .noc_clk        ( noc_clk            ),
    .noc_rst_n      ( noc_rst_n          ),
    .i_clear        ( '0                 ),
    .o_empty        (                    ),
    .o_almost_full  (                    ),
    .o_full         (                    ),
    .receiver_if    ( flit_if            ),
    .sender_if      ( sender_if          )
); 

endmodule