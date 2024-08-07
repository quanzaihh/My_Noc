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
);

Noc_connector u_Noc_connector(
	.noc_clk                   	( noc_clk                    ),
	.noc_rst_n                 	( noc_rst_n                  ),
	.Noc_0_0_receive_valid     	( Noc_0_0_receive_valid      ),
	.Noc_0_0_receive_ready     	( Noc_0_0_receive_ready      ),
	.Noc_0_0_receive_flit      	( Noc_0_0_receive_flit       ),
	.Noc_0_0_receive_is_header 	( Noc_0_0_receive_is_header  ),
	.Noc_0_0_receive_is_tail   	( Noc_0_0_receive_is_tail    ),
	.Noc_0_0_sender_valid      	( Noc_0_0_sender_valid       ),
	.Noc_0_0_sender_ready      	( Noc_0_0_sender_ready       ),
	.Noc_0_0_sender_flit       	( Noc_0_0_sender_flit        ),
	.Noc_0_0_sender_VCready    	( Noc_0_0_sender_VCready     ),
	.Noc_0_0_sender_is_header  	( Noc_0_0_sender_is_header   ),
	.Noc_0_0_sender_is_tail    	( Noc_0_0_sender_is_tail     ),
	.Noc_0_1_receive_valid     	( Noc_0_1_receive_valid      ),
	.Noc_0_1_receive_ready     	( Noc_0_1_receive_ready      ),
	.Noc_0_1_receive_flit      	( Noc_0_1_receive_flit       ),
	.Noc_0_1_receive_is_header 	( Noc_0_1_receive_is_header  ),
	.Noc_0_1_receive_is_tail   	( Noc_0_1_receive_is_tail    ),
	.Noc_0_1_sender_valid      	( Noc_0_1_sender_valid       ),
	.Noc_0_1_sender_ready      	( Noc_0_1_sender_ready       ),
	.Noc_0_1_sender_flit       	( Noc_0_1_sender_flit        ),
	.Noc_0_1_sender_VCready    	( Noc_0_1_sender_VCready     ),
	.Noc_0_1_sender_is_header  	( Noc_0_1_sender_is_header   ),
	.Noc_0_1_sender_is_tail    	( Noc_0_1_sender_is_tail     ),
	.Noc_1_0_receive_valid     	( Noc_1_0_receive_valid      ),
	.Noc_1_0_receive_ready     	( Noc_1_0_receive_ready      ),
	.Noc_1_0_receive_flit      	( Noc_1_0_receive_flit       ),
	.Noc_1_0_receive_is_header 	( Noc_1_0_receive_is_header  ),
	.Noc_1_0_receive_is_tail   	( Noc_1_0_receive_is_tail    ),
	.Noc_1_0_sender_valid      	( Noc_1_0_sender_valid       ),
	.Noc_1_0_sender_ready      	( Noc_1_0_sender_ready       ),
	.Noc_1_0_sender_flit       	( Noc_1_0_sender_flit        ),
	.Noc_1_0_sender_VCready    	( Noc_1_0_sender_VCready     ),
	.Noc_1_0_sender_is_header  	( Noc_1_0_sender_is_header   ),
	.Noc_1_0_sender_is_tail    	( Noc_1_0_sender_is_tail     ),
	.Noc_1_1_receive_valid     	( Noc_1_1_receive_valid      ),
	.Noc_1_1_receive_ready     	( Noc_1_1_receive_ready      ),
	.Noc_1_1_receive_flit      	( Noc_1_1_receive_flit       ),
	.Noc_1_1_receive_is_header 	( Noc_1_1_receive_is_header  ),
	.Noc_1_1_receive_is_tail   	( Noc_1_1_receive_is_tail    ),
	.Noc_1_1_sender_valid      	( Noc_1_1_sender_valid       ),
	.Noc_1_1_sender_ready      	( Noc_1_1_sender_ready       ),
	.Noc_1_1_sender_flit       	( Noc_1_1_sender_flit        ),
	.Noc_1_1_sender_VCready    	( Noc_1_1_sender_VCready     ),
	.Noc_1_1_sender_is_header  	( Noc_1_1_sender_is_header   ),
	.Noc_1_1_sender_is_tail    	( Noc_1_1_sender_is_tail     )
);


endmodule