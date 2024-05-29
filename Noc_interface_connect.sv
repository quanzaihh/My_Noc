/*
    created by: <Xidian University>
    created date: 2024-05-16
*/

module Noc_interface_connect import Noc_parameters::*; 
(
    Noc_flit_interface.receiver       receiver_if,
	Noc_flit_interface.sender         sender_if
);

always_comb begin
    sender_if.valid       = receiver_if.valid;
    receiver_if.ready     = sender_if.ready;
    sender_if.flit        = receiver_if.flit;
    receiver_if.vc_ready  = sender_if.vc_ready;
end

endmodule