/*
    created by: <Xidian University>
    created date: 2024-05-16
*/

`timescale 1ns/1ps

module Noc_route_selector
	import  Noc_parameters::*;
#(
	parameter   bit [4:0]  ACTIVATE_PORT = 5'b11111,
	localparam  int        CHANNELS      = Noc_VC_Channel,
	localparam  int        ID_X_WIDTH    = Noc_ID_X_Width,
	localparam  int        ID_Y_WIDTH    = Noc_ID_Y_Width
)(
	input var logic                   noc_clk,
	input var logic                   noc_rst_n,
	input var logic [ID_X_WIDTH-1:0]  id_x,
	input var logic [ID_Y_WIDTH-1:0]  id_y,
	Noc_control_interface.requester   port_control_if[5],
	Noc_flit_interface.receiver       receiver_if[CHANNELS],
	Noc_flit_interface.sender         sender_if[5]
);

/*------------------- route for each VC channel -----------------*/

Noc_flit_interface #(.Channel(1)) route_if[5*CHANNELS]();

for (genvar i = 0; i < CHANNELS; i = i + 1) begin: g_routing
    e_route route;
    e_route route_latched;

    reg [127:0] flit_data;
    reg flit_is_header,flit_is_tail;
    assign flit_data = receiver_if[i].flit[0][127:0];
    assign flit_is_header = receiver_if[i].is_header(0);
    assign flit_is_tail = receiver_if[i].is_tail(0);

    assign route = (receiver_if[i].is_header(0)) 
                ? select_route(receiver_if[i].flit[0]) : route_latched;

    always @(posedge noc_clk or negedge noc_rst_n) begin
        if (!noc_rst_n)begin
            route_latched <= ROUTE_NA;
        end
        else if (receiver_if[i].is_header(0) & receiver_if[i].valid) begin
            route_latched <= route;
        end
    end

    for (genvar j = 0; j < 5;j = j + 1) begin : g
        always_comb begin
            if (route[j] && ACTIVATE_PORT[j]) begin
                port_control_if[j].request[i]         = receiver_if[i].valid;
                port_control_if[j].free[i]            = receiver_if[i].ready;
                port_control_if[j].start_of_packet[i] = (receiver_if[i].is_header(0)) ? receiver_if[i].valid : 0;
                port_control_if[j].end_of_packet[i]   = (receiver_if[i].is_tail(0)) ? (receiver_if[i].valid & receiver_if[i].ready) : 0;
            end
            else begin
                port_control_if[j].request[i]         = '0;
                port_control_if[j].free[i]            = '0;
                port_control_if[j].start_of_packet[i] = '0;
                port_control_if[j].end_of_packet[i]   = '0;
            end
        end
    end

    Noc_flit_interface_demux #(
        .CHANNELS (1),
        .ENTRIES  (5)
    )
    Noc_flit_interface_demux_inst
    (
        .i_select       (route                  ),
        .receiver_if    (receiver_if[i]         ),
        .sender_if      (route_if[5*i:5*(i+1)-1])
    );
end

function automatic e_route select_route(logic [Noc_Data_Width-1:0] flit);
    logic [3:0]         result;

    logic [Noc_ID_X_Width+Noc_ID_Y_Width-1:0] destination_id;
    logic [Noc_ID_X_Width-1:0]                destination_x_id;
    logic [Noc_ID_Y_Width-1:0]                destination_y_id;

    destination_id   = flit[Noc_Source_Point-1:Noc_Dest_Point];
    destination_x_id = destination_id[Noc_ID_X_Width+Noc_ID_Y_Width-1:Noc_ID_Y_Width];
    destination_y_id = destination_id[Noc_ID_Y_Width-1:0];

    result[0] = (destination_x_id > id_x) ? ACTIVATE_PORT[0] : '0;
    result[1] = (destination_x_id < id_x) ? ACTIVATE_PORT[1] : '0;
    result[2] = (destination_y_id > id_y) ? ACTIVATE_PORT[2] : '0;
    result[3] = (destination_y_id < id_y) ? ACTIVATE_PORT[3] : '0;

    if (result[0]) begin
        return ROUTE_EAST;
    end
    else if (result[1]) begin
        return ROUTE_WEST;
    end
    else if (result[2]) begin
        return ROUTE_SOUTH;
    end
    else if (result[3]) begin
        return ROUTE_NORTH;
    end
    else begin
        return ROUTE_LOCAL;
    end
endfunction

/*--------------------- merge the route interfaces ----------------*/
Noc_flit_interface #(.Channel(1)) vc_if[5*CHANNELS]();

for (genvar i = 0;i < 5; i = i + 1) begin : g_vc_merging
    for (genvar j = 0;j < CHANNELS; j = j + 1) begin : g_connector
        Noc_interface_connect u_connector (route_if[5*j+i], vc_if[CHANNELS*i+j]);
    end

    if (ACTIVATE_PORT[i]) begin : g_true_merge
        Noc_vc_merge vc_merge_inst(
            .noc_clk      ( noc_clk                             ),
            .noc_rst_n    ( noc_rst_n                           ),
            .vc_grant     ( port_control_if[i].grant            ),
            .receiver_if  ( vc_if[CHANNELS*i:CHANNELS*(i+1)-1]  ),
            .sender_if    ( sender_if[i]                        )
        );
    end
    else begin : g_dummy_merge
        assign sender_if[i].valid   = '0;
        assign sender_if[i].flit[0] = '0;

        for (genvar p = 0; p < CHANNELS; p = p + 1) begin : g_dummy_vc_if
            assign vc_if[CHANNELS*i+p].ready    = 1'b0;
            assign vc_if[CHANNELS*i+p].vc_ready = 1'b0;
        end
    end
end
endmodule