/*
    created by: <Xidian University>
    created date: 2024-05-16
*/

module Noc_test_node_verilog import Noc_parameters::*;
# (
    parameter bit [Noc_ID_X_Width-1:0] X_ID = 0,
    parameter bit [Noc_ID_Y_Width-1:0] Y_ID = 0
)
(
    input var logic             noc_clk,
    input var logic             noc_rst_n,
    input var logic             send_start,
    Noc_flit_interface.receiver noc_receiver_if,
    Noc_flit_interface.sender   noc_sender_if
);


endmodule