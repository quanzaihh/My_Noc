/*
    created by: <Xidian University>
    created date: 2024-05-16
*/

module Noc_position_mux import Noc_parameters::*;
(
    input var logic                   noc_clk,
    input var logic                   noc_rst_n,
    Noc_flit_interface.receiver       receiver_east,
    Noc_flit_interface.sender         sender_east,
    Noc_flit_interface.receiver       receiver_west,
    Noc_flit_interface.sender         sender_west,
    Noc_flit_interface.receiver       receiver_south,
    Noc_flit_interface.sender         sender_south,
    Noc_flit_interface.receiver       receiver_north,
    Noc_flit_interface.sender         sender_north,
    Noc_flit_interface.receiver       receiver_local,
    Noc_flit_interface.sender         sender_local,
    // interface [east, west, south, north, local]
    Noc_flit_interface.receiver       from_router[5],
    Noc_flit_interface.sender         to_router[5]
);

Noc_interface_connect east_in_out   (receiver_east, to_router[0]);
Noc_interface_connect west_in_out   (receiver_west, to_router[1]);
Noc_interface_connect south_in_out  (receiver_south, to_router[2]);
Noc_interface_connect north_in_out  (receiver_north, to_router[3]);
Noc_interface_connect local_in_out  (receiver_local, to_router[4]);

Noc_interface_connect east_out_in   (from_router[0], sender_east);
Noc_interface_connect west_out_in   (from_router[1], sender_west);
Noc_interface_connect south_out_in  (from_router[2], sender_south);
Noc_interface_connect north_out_in  (from_router[3], sender_north);
Noc_interface_connect local_out_in  (from_router[4], sender_local);

endmodule