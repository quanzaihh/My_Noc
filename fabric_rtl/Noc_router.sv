/*
    created by: <Xidian University>
    created date: 2024-05-16
*/

`timescale 1ns/1ps

module Noc_router import Noc_parameters::*;
#(
    parameter bit [4:0] ACTIVATE_PORT = 5'b11111,
    parameter int       CHANNELS      = Noc_VC_Channel
) 
(
    input var logic                          noc_clk,
    input var logic                          noc_rst_n,
    input var logic [Noc_ID_X_Width-1:0]     id_x,
    input var logic [Noc_ID_Y_Width-1:0]     id_y,
    // interface [east, west, south, north, local]
    Noc_flit_interface.receiver              receiver_if[4],
    Noc_flit_interface.sender                sender_if[4],
    Noc_flit_interface.receiver              local_receiver,
    Noc_flit_interface.sender                local_sender
);

Noc_flit_interface input_block_flit_if[25]();
Noc_flit_interface output_block_flit_if[25]();
Noc_control_interface   input_block_port_control_if[25]();
Noc_control_interface   output_block_port_control_if[25]();

/*----------------------- input block ---------------------------*/
// internal input block
for (genvar i = 0; i < 4; i = i + 1) begin: gen_input_block
    if (ACTIVATE_PORT[i]) begin: g_true_block
        Noc_input_block# (
            .ACTIVATE_PORT (ACTIVATE_PORT)
        )
        Noc_input_block_inst
        (
            .noc_clk            (noc_clk                                    ),
            .noc_rst_n          (noc_rst_n                                  ),
            .id_x               (id_x                                       ),
            .id_y               (id_y                                       ),
            .receiver_if        (receiver_if[i]                             ),
            .sender_if          (input_block_flit_if[5*i:5*(i+1)-1]         ),
            .port_control_if    (input_block_port_control_if[5*i:5*(i+1)-1] )
        );
    end
    else begin: g_fake_block
        assign receiver_if[i].ready     = {CHANNELS{1'b0}};
        assign receiver_if[i].vc_ready  = {CHANNELS{1'b0}}; 
        for (genvar P = 0; P < 5; P = P + 1) begin : g
            assign input_block_flit_if[5*i+P].valid                    = '0;
            assign input_block_flit_if[5*i+P].flit[0]                  = '0;    
            assign input_block_port_control_if[5*i+P].request          = '0;
            assign input_block_port_control_if[5*i+P].free             = '0;
            assign input_block_port_control_if[5*i+P].start_of_packet  = '0;
            assign input_block_port_control_if[5*i+P].end_of_packet    = '0;
        end
    end
end
// local input block
Noc_input_block# (
    .ACTIVATE_PORT (ACTIVATE_PORT),
    .Port_Type     (LOCAL        )
)
Noc_input_block_local
(
    .noc_clk            (noc_clk                            ),
    .noc_rst_n          (noc_rst_n                          ),
    .id_x               (id_x                               ),
    .id_y               (id_y                               ),
    .receiver_if        (local_receiver                     ),
    .sender_if          (input_block_flit_if[20:24]         ),
    .port_control_if    (input_block_port_control_if[20:24] )
);

/*-------------------------------- transpose ----------------------------*/
for (genvar i = 0; i < 5; i = i + 1) begin : g
    for (genvar j = 0;j < 5; j = j + 1) begin : g
        Noc_interface_connect u_flit_if_connector (
            input_block_flit_if[5*i+j], output_block_flit_if[5*j+i]
        );

        always_comb begin
            output_block_port_control_if[5*j+i].request         = input_block_port_control_if[5*i+j].request;
            output_block_port_control_if[5*j+i].free            = input_block_port_control_if[5*i+j].free;
            output_block_port_control_if[5*j+i].start_of_packet = input_block_port_control_if[5*i+j].start_of_packet;
            output_block_port_control_if[5*j+i].end_of_packet   = input_block_port_control_if[5*i+j].end_of_packet;
            input_block_port_control_if[5*i+j].grant            = output_block_port_control_if[5*j+i].grant;
        end
    end
end

/*----------------------- output block ---------*/
// internal output block
for (genvar i = 0; i < 4; i = i + 1) begin: gen_output_block
    if (ACTIVATE_PORT[i]) begin: g_true_block
        Noc_output_block output_block (
            .noc_clk         ( noc_clk                                     ),            
            .noc_rst_n       ( noc_rst_n                                   ),          
            .receiver_if     ( output_block_flit_if[5*i:5*(i+1)-1]         ),
            .sender_if       ( sender_if[i]                                ),
            .port_control_if ( output_block_port_control_if[5*i:5*(i+1)-1] )
        );
    end
    else begin : g_fake_block
        assign sender_if[i].valid  = '0;
        assign sender_if[i].flit[0]= '0; 
        for (genvar P = 0; P < 5; P = P + 1) begin : g
            assign output_block_flit_if[5*i+P].ready         = '0;
            assign output_block_flit_if[5*i+P].vc_ready      = '0;    
            assign output_block_port_control_if[5*i+P].grant = '0;
        end
    end
end

Noc_flit_interface local_output();

// local output block
Noc_output_block #(
    .Port_Type (INTERNAL)
)
output_block (
    .noc_clk         ( noc_clk                                     ),            
    .noc_rst_n       ( noc_rst_n                                   ),          
    .receiver_if     ( output_block_flit_if[20:24]                 ),
    .sender_if       ( local_output                                ),
    .port_control_if ( output_block_port_control_if[20:24]         )
);

reg [129:0] data_check;

always_comb begin : outputss
    local_sender.valid[0] = |local_output.valid[0];
    local_output.ready = {CHANNELS{local_sender.ready[0]}};
    local_output.vc_ready = {CHANNELS{local_sender.vc_ready[0]}};
    local_sender.flit[0]  = local_output.flit[0];
    data_check = local_output.flit[0];
end



endmodule