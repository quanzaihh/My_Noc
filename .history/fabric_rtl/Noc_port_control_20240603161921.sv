/*
    created by: <Xidian University>
    created date: 2024-05-16
*/

module Noc_port_control_internal import Noc_parameters::*; 
#(
    parameter int       CHANNELS      = Noc_VC_Channel
)
(
    input   var logic                 noc_clk,
    input   var logic                 noc_rst_n,
    input   var logic [CHANNELS-1:0]  vc_ready,
    Noc_control_interface.controller  port_control_if[5],
    output  var logic [4:0]           grant_o,
    input   var logic                 free_i
);

logic [CHANNELS-1:0][4:0] request;
logic [CHANNELS-1:0][4:0] grant;
logic [CHANNELS-1:0][4:0] free;

for (genvar i = 0; i < CHANNELS; i = i + 1) begin : g_reorder
    for (genvar j = 0; j < 5; j = j + 1) begin : g
        always_comb begin
            request[i][j]               = port_control_if[j].request[i];
            port_control_if[j].grant[i] = grant[i][j];
            free[i][j]                  = port_control_if[j].free[i];
        end
    end
end

//--------------------------------------------------------------
//  Port Arbitration
//--------------------------------------------------------------
logic [CHANNELS-1:0][4:0] port_grant;

for (genvar i = 0; i < CHANNELS; i = i + 1) begin : g_port_arbitration
    logic [4:0] port_request;
    logic [4:0] port_free;

    for (genvar j = 0; j < 5; j = j + 1) begin : g
        always_comb begin
            port_request[j] = port_control_if[j].start_of_packet[i];
            port_free[j]    = port_control_if[j].end_of_packet[i];
        end
    end

    Noc_round_robin_arbiter #(
        .REQUESTS     (5  ),
        .KEEP_RESULT  (1  )
    ) u_arbiter (
        .noc_clk    ( noc_clk        ),
        .noc_rst_n  ( noc_rst_n      ),
        .request    ( port_request   ),
        .o_grant    ( port_grant[i]  ),
        .free       ( port_free      )
    );
end

//--------------------------------------------------------------
//  VC Arbitration
//--------------------------------------------------------------
logic [CHANNELS-1:0]  vc_grant;
logic [CHANNELS-1:0]  vc_free;

if (CHANNELS >= 2) begin : g_vc_arbtration
    logic [CHANNELS-1:0]  vc_request;

    always_comb begin
        for (int i = 0;i < CHANNELS;++i) begin
            vc_request[i] = |(request[i] & port_grant[i] & {5{vc_ready[i]}});
            vc_free[i]    = |(free[i]    & port_grant[i]);
        end
    end

    Noc_round_robin_arbiter #(
        .REQUESTS     (CHANNELS ),
        .KEEP_RESULT  (1        )
    ) u_arbiter (
        .noc_clk    (noc_clk    ),
        .noc_rst_n  (noc_rst_n  ),
        .request    (vc_request ),
        .o_grant    (vc_grant   ),
        .free       (vc_free    )
    );
end
else begin : g_vc_arbtration
    always_comb begin
        vc_grant  = |(request[0] & port_grant[0]);
        vc_free   = |(free[0]    & port_grant[0]);
    end
end

//------------------------ Grant Output ----------------------------
logic       fifo_full;
logic       fifo_push;
logic       fifo_pop;
logic [4:0] output_grant;

always_comb begin
    for (int i = 0;i < CHANNELS;++i) begin
        grant[i]  = (vc_grant[i] && (!fifo_full)) ? port_grant[i] : '0;
    end
end
Noc_multi_case #(.N(CHANNELS), .DataWidth(5)) u_noc_case();
assign output_grant = u_noc_case.set_case(vc_grant, port_grant);

always_comb begin
    fifo_push = |vc_free;
    fifo_pop  = free_i;
end

Noc_fifo #(
    .WIDTH        (5    ),
    .DEPTH        (2    ),
    .FLAG_FF_OUT  (1    ),
    .DATA_FF_OUT  (1    )
) u_grant_fifo (
    .clk            (noc_clk      ),
    .rst_n          (noc_rst_n    ),
    .i_clear        ('0           ),
    .o_empty        (             ),
    .o_almost_full  (             ),
    .o_full         (fifo_full    ),
    .i_push         (fifo_push    ),
    .i_data         (output_grant ),
    .i_pop          (fifo_pop     ),
    .o_data         (grant_o      )
);
endmodule