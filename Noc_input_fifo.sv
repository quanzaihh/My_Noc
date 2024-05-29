/*
    created by: <Xidian University>
    created date: 2024-05-16
*/

module Noc_input_fifo import Noc_parameters::*; 
#(
    parameter int DEPTH     = 32,
    parameter int CHANNELS  = 32
)
(
    input var logic                   noc_clk,
    input var logic                   noc_rst_n,
    Noc_flit_interface.receiver       receiver_if,
    Noc_flit_interface.sender         sender_if[CHANNELS]
);

// split the input flit into virtual channels
Noc_flit_interface #(.Channel(1)) flit_vc_if[CHANNELS]();
for (genvar i = 0; i < CHANNELS; i++) begin : vc_split
    assign flit_vc_if[i].valid     = receiver_if.valid[i];
    assign receiver_if.ready[i]    = flit_vc_if[i].ready;
    assign receiver_if.vc_ready[i] = flit_vc_if[i].vc_ready;
    assign flit_vc_if[i].flit      = receiver_if.flit;
end

for (genvar i = 0;i < CHANNELS;++i) begin : g
    Noc_flit_interface_fifo #(
        .CHANNELS       (1              ),
        .DEPTH          (DEPTH          ),
        .THRESHOLD      (DEPTH -2       ),
        .DATA_FF_OUT    (0              )
    ) u_fifo (
        .noc_clk        (noc_clk        ),
        .noc_rst_n      (noc_rst_n      ),
        .i_clear        ('0             ),
        .o_empty        (),
        .o_almost_full  (),
        .o_full         (),
        .receiver_if    (flit_vc_if[i]  ),
        .sender_if      (sender_if[i]   )
    );
end

endmodule