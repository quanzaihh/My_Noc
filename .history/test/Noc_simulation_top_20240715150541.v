`timescale 1ps/1ps

module simulation_top();

reg clk, rst_n;

initial begin
    clk = 0;
    forever #5 clk = ~clk;
end

initial begin
    rst_n = 0;
    #100 rst_n = 1;
end

Noc_block_design_wrapper Noc_block_design_wrapper_inst(
    .noc_clk_0      (clk),
    .noc_rst_n_0    (rst_n)
)

endmodule