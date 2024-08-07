/*
    created by: <Xidian University>
    created date: 2024-05-16
*/

`timescale 1ns/1ps

module Noc_flit_interface_fifo import Noc_parameters::*; 
#(
    parameter int CHANNELS          = Noc_VC_Channel,
    parameter int DEPTH             = 8,
    parameter int THRESHOLD         = DEPTH,
    parameter int FLIT_WIDTH        = Noc_Flit_Width, 
    parameter int DATA_FF_OUT       = 1,
    parameter port_type Port_Type   = INTERNAL,
    parameter int FLITS             = (Port_Type==LOCAL) ? CHANNELS : 1
)
(
    input   var logic             noc_clk,
    input   var logic             noc_rst_n,
    input   var logic             i_clear,
    output  var logic  [FLITS-1:0]o_empty,
    output  var logic  [FLITS-1:0]o_almost_full,
    output  var logic  [FLITS-1:0]o_full,
    Noc_flit_interface.receiver   receiver_if,
    Noc_flit_interface.sender     sender_if
);

typedef struct packed {
    logic [CHANNELS-1:0]    valid;
    logic [FLIT_WIDTH-1:0]  flit;
} fifo_data;

logic [FLITS-1:0] empty;
logic [FLITS-1:0] almost_full;
logic [FLITS-1:0] full;

assign  o_empty       = empty;
assign  o_almost_full = almost_full;
assign  o_full        = full;
if (Port_Type==LOCAL) begin : g_local_port
    always_comb begin
        receiver_if.ready     = ~full;
        receiver_if.vc_ready  = ~almost_full;
    end

    always_comb begin
        sender_if.valid = ~empty;
    end
    
    for (genvar i=0; i<CHANNELS; i++) begin : g_fifo
        Noc_fifo #(
            .WIDTH        (FLIT_WIDTH   ),
            .DEPTH        (DEPTH        ),
            .THRESHOLD    (THRESHOLD    ),
            .FLAG_FF_OUT  (1            ),
            .DATA_FF_OUT  (DATA_FF_OUT  )
        ) u_fifo (
            .clk            (noc_clk                ),
            .rst_n          (noc_rst_n              ),
            .i_clear        (i_clear                ),
            .o_empty        (empty[i]               ),
            .o_almost_full  (almost_full[i]         ),
            .o_full         (full[i]                ),
            .i_push         (receiver_if.valid[i]   ),
            .i_data         (receiver_if.flit[i]    ),
            .i_pop          (sender_if.ready[i]     ),
            .o_data         (sender_if.flit[i]      )
        );
    end
end
else if (CHANNELS >= 2) begin : g_multi_channels
    logic     push;
    fifo_data push_data;

    always_comb begin
        push                  = |receiver_if.valid;
        push_data.valid       = receiver_if.valid;
        push_data.flit        = receiver_if.flit[0];
        receiver_if.ready     = {CHANNELS{~full}};
        receiver_if.vc_ready  = {CHANNELS{~almost_full}};
    end

    logic     pop;
    fifo_data pop_data;

    always_comb begin
        sender_if.valid   = (!empty) ? pop_data.valid : '0;
        sender_if.flit[0] = pop_data.flit;
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
        .i_data         (receiver_if.flit[0]),
        .i_pop          (sender_if.ready    ),
        .o_data         (sender_if.flit[0]  )
    );
end

endmodule