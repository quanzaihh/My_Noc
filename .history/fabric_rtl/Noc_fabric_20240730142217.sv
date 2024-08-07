/*
    created by: <Xidian University>
    created date: 2024-05-16
*/

`timescale 1ns/1ps

module Noc_fabric import Noc_parameters::*;
(
    input var logic             noc_clk,
    input var logic             noc_rst_n,
    Noc_flit_interface.receiver noc_receiver_if[Noc_Node_Num],
    Noc_flit_interface.sender   noc_sender_if[Noc_Node_Num]
);

localparam  int FLIT_IF_SIZE_X  = (Noc_X_Size + 1) * Noc_Y_Size;
localparam  int FLIT_IF_SIZE_Y  = (Noc_Y_Size + 1) * Noc_X_Size;

Noc_flit_interface flit_if_x_e2w[FLIT_IF_SIZE_X]();  // east to west interface
Noc_flit_interface flit_if_x_w2e[FLIT_IF_SIZE_X]();  // west to east interface
Noc_flit_interface flit_if_y_s2n[FLIT_IF_SIZE_Y]();  // south to north interface
Noc_flit_interface flit_if_y_n2s[FLIT_IF_SIZE_Y]();  // north to south interface

typedef logic [Noc_ID_X_Width-1:0] Noc_id_x;
typedef logic [Noc_ID_Y_Width-1:0] Noc_id_y;

for (genvar y = 0; y < Noc_Y_Size; y = y + 1) begin : g_y
    for (genvar x = 0; x < Noc_X_Size; x = x + 1) begin : g_x;
        localparam  int       INDEX_X       = (Noc_X_Size + 1) * y + x;
        localparam  int       INDEX_Y       = (Noc_Y_Size + 1) * x + y;
        localparam  int       INDEX_L       = (Noc_X_Size + 0) * y + x;
        localparam  Noc_id_x  ID_X          = x;
        localparam  Noc_id_y  ID_Y          = y;
        localparam  bit [4:0] ACTIVATE_PORT = get_active_ports(y, x);

        if (Noc_Node_Active[INDEX_L]) begin : active_Node
            Noc_flit_interface router_receiver_if[4]();
            Noc_flit_interface router_sender_if[4]();

            Noc_position_mux Noc_position_mux_inst(
                .noc_clk            (noc_clk                 ),
                .noc_rst_n          (noc_rst_n               ),
                .receiver_east      (flit_if_x_w2e[INDEX_X+1]),
                .sender_east        (flit_if_x_e2w[INDEX_X+1]),
                .receiver_west      (flit_if_x_e2w[INDEX_X+0]),
                .sender_west        (flit_if_x_w2e[INDEX_X+0]),
                .receiver_south     (flit_if_y_n2s[INDEX_Y+1]),
                .sender_south       (flit_if_y_s2n[INDEX_Y+1]),
                .receiver_north     (flit_if_y_s2n[INDEX_Y+0]),
                .sender_north       (flit_if_y_n2s[INDEX_Y+0]),
                .from_router        (router_sender_if        ),
                .to_router          (router_receiver_if      )
            );

            Noc_router #(
                .ACTIVATE_PORT      (ACTIVATE_PORT)
            ) 
            Noc_router_inst(
                .noc_clk            (noc_clk                    ),
                .noc_rst_n          (noc_rst_n                  ),
                .id_x               (ID_X                       ),
                .id_y               (ID_Y                       ),
                .receiver_if        (router_receiver_if         ),
                .sender_if          (router_sender_if           ),
                .local_receiver     (noc_receiver_if[INDEX_L]   ),
                .local_sender       (noc_sender_if[INDEX_L]     )
            );

            if (!ACTIVATE_PORT[0]) begin : g_fake_east
                always_comb begin
                    flit_if_x_e2w[INDEX_X+1].ready       = '0;
                    flit_if_x_e2w[INDEX_X+1].vc_ready    = '0;
                    flit_if_x_w2e[INDEX_X+1].valid       = '0;
                    flit_if_x_w2e[INDEX_X+1].flit[0]     = '0; 
                end
            end

            if (!ACTIVATE_PORT[1]) begin : g_fake_west
                always_comb begin
                    flit_if_x_w2e[INDEX_X+0].ready       = '0;
                    flit_if_x_w2e[INDEX_X+0].vc_ready    = '0;
                    flit_if_x_e2w[INDEX_X+0].valid       = '0;
                    flit_if_x_e2w[INDEX_X+0].flit[0]     = '0;                
                end
            end

            if (!ACTIVATE_PORT[2]) begin : g_fake_south
                always_comb begin
                    flit_if_y_s2n[INDEX_Y+1].ready       = '0;
                    flit_if_y_s2n[INDEX_Y+1].vc_ready    = '0;
                    flit_if_y_n2s[INDEX_Y+1].valid       = '0;
                    flit_if_y_n2s[INDEX_Y+1].flit[0]     = '0;
                end
            end

            if (!ACTIVATE_PORT[3]) begin : g_fake_north
                always_comb begin
                    flit_if_y_n2s[INDEX_Y+0].ready       = '0;
                    flit_if_y_n2s[INDEX_Y+0].vc_ready    = '0;
                    flit_if_y_s2n[INDEX_Y+0].valid       = '0;
                    flit_if_y_s2n[INDEX_Y+0].flit[0]     = '0;
                end
            end
        end
        else begin : inactive_Node
            if (ACTIVATE_PORT[0] & ACTIVATE_PORT[3]) begin : g_connect_east_north
                if (Noc_Link_Reg[INDEX_L]) begin
                    always_comb begin
                        flit_if_x_w2e[INDEX_X+1].valid     = flit_if_x_e2w[INDEX_X+1].valid;
                        flit_if_x_e2w[INDEX_X+1].ready     = flit_if_x_w2e[INDEX_X+1].ready;
                        flit_if_x_w2e[INDEX_X+1].flit      = flit_if_x_e2w[INDEX_X+1].flit;
                        flit_if_x_e2w[INDEX_X+1].vc_ready  = flit_if_x_w2e[INDEX_X+1].vc_ready;
                    end
                end
                else begin
                    always_comb begin
                        flit_if_x_e2w[INDEX_X+1].ready       = '0;
                        flit_if_x_e2w[INDEX_X+1].vc_ready    = '0;
                        flit_if_x_w2e[INDEX_X+1].valid       = '0;
                        flit_if_x_w2e[INDEX_X+1].flit[0]     = '0; 
                    end
                end
            end

            if (!ACTIVATE_PORT[1]) begin : g_connect_west
                always_comb begin
                    flit_if_x_w2e[INDEX_X+0].ready       = '0;
                    flit_if_x_w2e[INDEX_X+0].vc_ready    = '0;
                    flit_if_x_e2w[INDEX_X+0].valid       = '0;
                    flit_if_x_e2w[INDEX_X+0].flit[0]     = '0;                
                end
            end

            if (!ACTIVATE_PORT[2]) begin : g_connect_south
                always_comb begin
                    flit_if_y_s2n[INDEX_Y+1].ready       = '0;
                    flit_if_y_s2n[INDEX_Y+1].vc_ready    = '0;
                    flit_if_y_n2s[INDEX_Y+1].valid       = '0;
                    flit_if_y_n2s[INDEX_Y+1].flit[0]     = '0;
                end
            end

            if (!ACTIVATE_PORT[3]) begin : g_connect_north
                always_comb begin
                    flit_if_y_n2s[INDEX_Y+0].ready       = '0;
                    flit_if_y_n2s[INDEX_Y+0].vc_ready    = '0;
                    flit_if_y_s2n[INDEX_Y+0].valid       = '0;
                    flit_if_y_s2n[INDEX_Y+0].flit[0]     = '0;
                end
            end

            // local interface
            always_comb begin : blockName
                noc_receiver_if[INDEX_L].ready      = '0;
                noc_receiver_if[INDEX_L].vc_ready   = '0;
                noc_sender_if[INDEX_L].valid        = '0;
                noc_sender_if[INDEX_L].flit[0]      = '0;                
            end
        end
    end
end

// return active ports  bits [4:0] {east, west, south, north, local}
function automatic bit [4:0] get_active_ports(int y, int x);
    bit [4:0] active_ports;
    active_ports[0] = (x < (Noc_X_Size - 1)) ? 1 : 0;   // east
    active_ports[1] = (x > 0               ) ? 1 : 0;   // west
    active_ports[2] = (y < (Noc_Y_Size - 1)) ? 1 : 0;   // south
    active_ports[3] = (y > 0               ) ? 1 : 0;   // north
    active_ports[4] = 1;                                // local
    return active_ports;
endfunction


endmodule