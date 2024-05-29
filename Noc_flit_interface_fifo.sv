/*
    created by: <Xidian University>
    created date: 2024-05-16
*/

module Noc_flit_interface_fifo import Noc_parameters::*; 
#(
    parameter int CHANNELS    = Noc_VC_Channel,
    parameter int DEPTH       = 8,
    parameter int THRESHOLD   = DEPTH,
    parameter int FLIT_WIDTH  = Noc_Data_Width,
    parameter int DATA_FF_OUT = 1
)
(
    input   var logic             noc_clk,
    input   var logic             noc_rst_n,
    input   var logic             i_clear,
    output  var logic             o_empty,
    output  var logic             o_almost_full,
    output  var logic             o_full,
    Noc_flit_interface.receiver   receiver_if,
    Noc_flit_interface.sender     sender_if
);

typedef struct packed {
    logic [CHANNELS-1:0]    valid;
    logic [FLIT_WIDTH-1:0]  flit;
} fifo_data;

logic empty;
logic almost_full;
logic full;

assign  o_empty       = empty;
assign  o_almost_full = almost_full;
assign  o_full        = full;

if (CHANNELS >= 2) begin : g_multi_channels
    logic     push;
    fifo_data push_data;

    always_comb begin
        push                  = |receiver_if.valid;
        push_data.valid       = receiver_if.valid;
        push_data.flit        = receiver_if.flit;
        receiver_if.ready     = {CHANNELS{~full}};
        receiver_if.vc_ready  = {CHANNELS{~almost_full}};
    end

    logic     pop;
    fifo_data pop_data;

    always_comb begin
        sender_if.valid   = (!empty) ? pop_data.valid : '0;
        sender_if.flit    = pop_data.flit;
        pop               = |(sender_if.valid & sender_if.ready);
    end

    Noc_fifo #(
        .DATA_TYPE    (fifo_data    ),
        .DEPTH        (DEPTH        ),
        .THRESHOLD    (THRESHOLD    ),
        .FLAG_FF_OUT  (1            ),
        .DATA_FF_OUT  (DATA_FF_OUT  )
    ) u_fifo (
        .clk            (noc_clk    ),
        .rst_n          (noc_rst_n  ),
        .i_clear        (i_clear    ),
        .o_empty        (empty      ),
        .o_almost_full  (almost_full),
        .o_full         (full       ),
        .i_push         (push       ),
        .i_data         (push_data  ),
        .i_pop          (pop        ),
        .o_data         (pop_data   )
    );
end
else begin : g_single_channel
    always_comb begin
        receiver_if.ready     = ~full;
        receiver_if.vc_ready  = ~almost_full;
    end

    always_comb begin
        sender_if.valid = ~empty;
    end

    Noc_fifo #(
        .WIDTH        (FLIT_WIDTH   ),
        .DEPTH        (DEPTH        ),
        .THRESHOLD    (THRESHOLD    ),
        .FLAG_FF_OUT  (1            ),
        .DATA_FF_OUT  (DATA_FF_OUT  )
    ) u_fifo (
        .clk            (noc_clk            ),
        .rst_n          (noc_rst_n          ),
        .i_clear        (i_clear            ),
        .o_empty        (empty              ),
        .o_almost_full  (almost_full        ),
        .o_full         (full               ),
        .i_push         (receiver_if.valid  ),
        .i_data         (receiver_if.flit   ),
        .i_pop          (sender_if.ready    ),
        .o_data         (sender_if.flit     )
    );
end

endmodule