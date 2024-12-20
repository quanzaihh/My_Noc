/*
    created by: <Xidian University>
    created date: 2024-05-16
*/

module Noc_top 
    import Noc_parameters::*;
(); 

logic                       noc_clk;
logic                       noc_rst_n;
logic [Noc_Node_Num-1:0]    send_start;

initial begin
    noc_clk = 0;
    forever #5 noc_clk = ~noc_clk;
end

initial begin
    noc_rst_n = 0;
    #100 noc_rst_n = 1;
end

initial begin
    send_start = {Noc_Node_Num{1'b0}};
    #100
    repeat(10)begin
        #100 send_start = 1 << $urandom_range(0, Noc_Node_Num-1);
        #10  send_start = {Noc_Node_Num{1'b0}};
    end
end

Noc_flit_interface #(.Port_Type(LOCAL)) noc_receiver_if[Noc_Node_Num]();
Noc_flit_interface #(.Port_Type(LOCAL)) noc_sender_if[Noc_Node_Num]();

Noc_fabric Noc_fabric_inst
(
    .noc_clk             (noc_clk),
    .noc_rst_n           (noc_rst_n),
    .noc_receiver_if     (noc_receiver_if),
    .noc_sender_if       (noc_sender_if)
);

for (genvar y = 0; y < Noc_Y_Size; y++) begin : noc_node_gen_y
    for (genvar x = 0; x < Noc_X_Size; x++) begin : noc_node_gen_x
        localparam int index = y * Noc_X_Size + x;
        Noc_test_node #(
            .X_ID   (x),
            .Y_ID   (y)
        ) 
        Noc_test_node_inst
        (
            .noc_clk             (noc_clk),
            .noc_rst_n           (noc_rst_n),
            .send_start          (send_start[index]),
            .noc_receiver_if     (noc_sender_if[index]),
            .noc_sender_if       (noc_receiver_if[index])
        );
    end
end

endmodule