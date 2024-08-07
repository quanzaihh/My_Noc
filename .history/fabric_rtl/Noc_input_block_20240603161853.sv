/*
    created by: <Xidian University>
    created date: 2024-05-16
*/

module Noc_input_block import Noc_parameters::*;
# (
    parameter int       CHANNELS        = Noc_VC_Channel,
    parameter bit [4:0] ACTIVATE_PORT   = 5'b11111,
    parameter port_type Port_Type       = INTERNAL
)
(
    input var logic                         noc_clk,
    input var logic                         noc_rst_n,
    input var logic [Noc_ID_X_Width-1:0]    id_x,
    input var logic [Noc_ID_Y_Width-1:0]    id_y,
    Noc_flit_interface.receiver             receiver_if,
    Noc_flit_interface.sender               sender_if[5],
    Noc_control_interface.requester         port_control_if[5]
);

Noc_flit_interface #(.Channel(1)) flit_if[CHANNELS]();

Noc_input_fifo #(
    .DEPTH          (Noc_VC_Fifo_Depth),
    .CHANNELS       (CHANNELS),
    .Port_Type      (Port_Type)
) u_input_fifo (
    .noc_clk      (noc_clk      ),
    .noc_rst_n    (noc_rst_n    ),
    .receiver_if  (receiver_if  ),
    .sender_if    (flit_if      )
);

Noc_route_selector #(
	.ACTIVATE_PORT   (ACTIVATE_PORT)
)
Noc_route_selector_inst
(
	.noc_clk                 (noc_clk           ),
	.noc_rst_n               (noc_rst_n         ),   
	.id_x                    (id_x              ),
	.id_y                    (id_y              ),
	.port_control_if         (port_control_if   ),
	.receiver_if             (flit_if           ),
	.sender_if               (sender_if         )
);

endmodule