/*
    created by: <Xidian University>
    created date: 2024-05-16
*/

`include "../fabric_rtl/Noc_parameters.v"

module Noc_test_node_verilog
# (
    parameter [`Noc_ID_X_Width-1:0] X_ID = 0,
    parameter [`Noc_ID_Y_Width-1:0] Y_ID = 0,
    parameter [`Noc_ID_X_Width-1:0] DEST_X_ID = 0,
    parameter [`Noc_ID_Y_Width-1:0] DEST_Y_ID = 0,
)
(
    input                           noc_clk,
    input                           noc_rst_n,
    input                           send_start,

    input   [0:0]                   receive_valid,
    output  [0:0]                   receive_ready,
    input   [`Noc_Data_Width-1:0]   receive_flit,
    input   [0:0]                   receive_is_header,
    input   [0:0]                   receive_is_tail,
    
    output  [0:0]                   sender_valid,
    input   [0:0]                   sender_ready,
    output  [`Noc_Data_Width-1:0]   sender_flit,
    output  [0:0]                   sender_is_header,
    output  [0:0]                   sender_is_tail
);

reg [`Noc_Data_Width-1:0] Flit_Header = {`Noc_Head_H, X_ID, Y_ID, DEST_X_ID, DEST_Y_ID, {`Axi_TYPE_Bit{1'b0}}, {`Axi_PACK_ORDER_Bit{1'b0}}, {`Axi_LEN_Bit{1'b0}}, `Noc_Head_E, {`Less_Byte{1'b0}}};
reg [`Noc_Data_Width-1:0] Flit_Data = {Noc_Data_Width{1'b1}};
reg [`Noc_Data_Width-1:0] Flit_Tail = {`Noc_Tail_H, X_ID, Y_ID, DEST_X_ID, DEST_Y_ID, {`Axi_TYPE_Bit{1'b0}}, {`Axi_PACK_ORDER_Bit{1'b0}}, {`Axi_LEN_Bit{1'b0}}, `Noc_Tail_E, {`Less_Byte{1'b0}}};

reg [3:0] send_state;
parameter SEND_IDLE = 4'd0, SEND_HEADER = 4'd1, SEND_DATA = 4'd2, SEND_TAIL = 4'd3;

always @(posedge noc_clk or negedge noc_rst_n) begin
    if (!noc_rst_n) begin
        send_state <= SEND_IDLE;
    end else begin
        case (send_state)
            SEND_IDLE: begin
                if (send_start) begin
                    send_state <= SEND_HEADER;
                    $display("node {x: %d, y: %d} send package to node {x: %d, y: %d}", X_ID, Y_ID, DEST_X_ID, DEST_Y_ID);
                end
                else begin
                    noc_sender_if.valid     <= {Noc_VC_Channel{1'b0}};
                    noc_sender_if.flit[0]   <= 0;
                    noc_sender_if.flit[1]   <= 0;
                    noc_sender_if.flit[2]   <= 0;
                    noc_sender_if.flit[3]   <= 0;
                end
            end

            SEND_HEADER:begin
                if (noc_sender_if.ready[0])begin
                    noc_sender_if.valid[0]  <= 1'b1;
                    noc_sender_if.flit[0]   <= {1'b1, 1'b0, Flit_Header};
                    send_state <= SEND_DATA;
                end
                else begin
                    noc_sender_if.valid[0]  <= 1'b0;
                    noc_sender_if.flit[0]   <= 0;
                end
            end

            SEND_DATA:begin
                if (noc_sender_if.ready[0])begin
                    noc_sender_if.valid[0]  <= 1'b1;
                    noc_sender_if.flit[0]   <= {1'b0, 1'b0, Flit_Data};
                    send_state <= SEND_TAIL;
                end
                else begin
                    noc_sender_if.valid[0]  <= 1'b0;
                    noc_sender_if.flit[0]   <= 0;
                end
            end

            SEND_TAIL:begin
                if (noc_sender_if.ready[0])begin
                    noc_sender_if.valid[0]  <= 1'b1;
                    noc_sender_if.flit[0]   <= {1'b0, 1'b1, Flit_Tail};
                    send_state <= SEND_IDLE;
                end
                else begin
                    noc_sender_if.valid[0]  <= 1'b0;
                    noc_sender_if.flit[0]   <= 0;
                end
            end
        endcase
    end
end

// receive (应该是可以使用多个虚拟通道的，但我这里只有一组接口，所以默认使用通道1)
logic [3:0] receive_state;
logic [Noc_ID_X_Width + Noc_ID_Y_Width - 1:0] source_ID;
logic [Noc_ID_X_Width-1:0] source_X_ID;
logic [Noc_ID_Y_Width-1:0] source_Y_ID;
logic                      header_H_hit;
logic                      header_E_hit;
logic                      tail_H_hit;
logic                      tail_E_hit;
assign header_H_hit = (noc_receiver_if.flit[0][Noc_Data_Width-1:Noc_Point_H] == Noc_Head_H);
assign header_E_hit = (noc_receiver_if.flit[0][Axi_Len_Point-1:Noc_Point_E] == Noc_Head_E);
assign tail_H_hit   = (noc_receiver_if.flit[0][Noc_Data_Width-1:Noc_Point_H] == Noc_Tail_H);
assign tail_E_hit   = (noc_receiver_if.flit[0][Axi_Len_Point-1:Noc_Point_E] == Noc_Tail_E);
assign source_ID  = noc_receiver_if.flit[0][Noc_Point_H-1:Noc_Source_Point];
parameter RECEIVE_HEADER = 4'd1, RECEIVE_DATA = 4'd2, RECEIVE_TAIL = 4'd3;
always_ff @(posedge noc_clk or negedge noc_rst_n) begin
    if (!noc_rst_n) begin
        receive_state <= RECEIVE_HEADER;
        noc_receiver_if.ready <= '1;
        noc_receiver_if.vc_ready <= '1;
    end else begin
        case (receive_state)
            RECEIVE_HEADER: begin
                if (noc_receiver_if.valid != 0) begin
                    if (noc_receiver_if.is_header(0)) begin
                        receive_state <= RECEIVE_DATA;
                        source_X_ID <= source_ID[Noc_ID_X_Width + Noc_ID_Y_Width - 1 : Noc_ID_Y_Width];
                        source_Y_ID <= source_ID[Noc_ID_Y_Width - 1 : 0];
                    end
                end
            end

            RECEIVE_DATA: begin
                if (noc_receiver_if.valid != 0) begin
                    receive_state <= RECEIVE_TAIL;
                end
            end

            RECEIVE_TAIL: begin
                if (noc_receiver_if.valid != 0) begin
                    if (noc_receiver_if.is_tail(0)) begin
                        receive_state <= RECEIVE_HEADER;
                        $display("node {x: %d, y: %d}, had received node {x: %d, y: %d}'s data package ", X_ID, Y_ID, source_X_ID, source_Y_ID);
                    end
                end
            end
        endcase
    end
end


endmodule