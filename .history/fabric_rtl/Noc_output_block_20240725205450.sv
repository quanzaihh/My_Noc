/*
    created by: <Xidian University>
    created date: 2024-05-16
*/

`timescale 1ns/1ps

module Noc_output_block import Noc_parameters::*; 
#(
    parameter int       CHANNELS      = Noc_VC_Channel,
    parameter port_type Port_Type     = INTERNAL,
    parameter int       SWITCH        = (Port_Type) ? 1 : CHANNELS,
    parameter int       PORT_CHANNELS = (Port_Type) ? CHANNELS : 1
)
(
    input var logic                   noc_clk,
    input var logic                   noc_rst_n,
    Noc_flit_interface.receiver       receiver_if[5],
    Noc_flit_interface.sender         sender_if,
    Noc_control_interface.controller  port_control_if[5]
);

//--------------------------------------------------------------
//  Re-order
//--------------------------------------------------------------
Noc_flit_interface #(.Channel(PORT_CHANNELS)) port_if[5*SWITCH]();

if (Port_Type==LOCAL) begin : g_local_port
    for (genvar i = 0;i < CHANNELS;++i) begin : g
        for (genvar j = 0;j < 5;++j) begin : g
            always_comb begin
                port_if[5*i+j].valid        = receiver_if[j].valid[i];
                receiver_if[j].ready[i]     = port_if[5*i+j].ready;
                port_if[5*i+j].flit         = receiver_if[j].flit;
                receiver_if[j].vc_ready[i]  = port_if[5*i+j].vc_ready;
            end
        end
    end
end
else begin : g_internal_port
    for (genvar i = 0;i < 5;++i) begin : g
        Noc_interface_connect u_connector (receiver_if[i], port_if[i]);
    end
end

//--------------------------------------------------------------
//  Port controller
//--------------------------------------------------------------

logic [SWITCH-1:0][4:0] output_grant;
logic [SWITCH-1:0]      output_free;

if (Port_Type==LOCAL) begin : g_local_port_controller
    Noc_port_control_local u_port_control(
        .noc_clk          ( noc_clk            ),
        .noc_rst_n        ( noc_rst_n          ),
        .vc_ready         ( sender_if.vc_ready ),
        .port_control_if  ( port_control_if    ),
        .grant_o          ( output_grant       ),
        .free_i           ( output_free        ) 
    );
end
else begin : g_internal_port_controller
    Noc_port_control_internal u_port_control(
        .noc_clk          ( noc_clk            ),
        .noc_rst_n        ( noc_rst_n          ),
        .vc_ready         ( sender_if.vc_ready ),
        .port_control_if  ( port_control_if    ),
        .grant_o          ( output_grant       ),
        .free_i           ( output_free        ) 
    );
end

//--------------------------------------------------------------
//  Switch
//--------------------------------------------------------------
Noc_flit_interface #(.Channel(PORT_CHANNELS)) switch_if[SWITCH]();

for (genvar i = 0;i < SWITCH;++i) begin : g_switch
    Noc_output_switch #(
        .Port_Type      (Port_Type      ),
        .CHANNELS       (PORT_CHANNELS  )
    ) u_switch (
        .noc_clk     (noc_clk                ),
        .noc_rst_n   (noc_rst_n              ),
        .receiver_if (port_if[5*i:5*(i+1)-1] ),
        .sender_if   (switch_if[i]           ),
        .i_grant     (output_grant[i]        ),
        .o_free      (output_free[i]         )
    );
end

if (Port_Type==LOCAL) begin : g_vc_mux
    for (genvar i = 0;i < CHANNELS;++i) begin : gggggg
        always_comb begin
            sender_if.valid[i]    = switch_if[i].valid;
            switch_if[i].ready    = sender_if.ready[i];
            sender_if.flit[i]     = switch_if[i].flit[0];
            switch_if[i].vc_ready = sender_if.vc_ready[i];
        end
    end
end
else begin : g_rename
    Noc_interface_connect u_connector (switch_if[0], sender_if);
end

endmodule