`timescale 1ps/1ps

`include "../fabric_rtl/Noc_parameters.v"
module simulation_top();

reg noc_clk, noc_rst_n;

initial begin
    noc_clk = 0;
    forever #5 noc_clk = ~noc_clk;
end

initial begin
    noc_rst_n = 0;
    #100 noc_rst_n = 1;
end

// outports wire
wire [0:0]                 	Noc_0_0_receive_valid;
wire [`Noc_Data_Width-1:0] 	Noc_0_0_receive_flit;
wire [0:0]                 	Noc_0_0_receive_is_header;
wire [0:0]                 	Noc_0_0_receive_is_tail;
wire [0:0]                  Noc_0_0_receive_ready;
wire [0:0]                 	Noc_0_0_sender_valid;
wire [`Noc_Data_Width-1:0] 	Noc_0_0_sender_flit;
wire [0:0]                 	Noc_0_0_sender_is_header;
wire [0:0]                 	Noc_0_0_sender_is_tail;
wire [0:0]                  Noc_0_0_sender_ready;

wire [0:0]                 	Noc_0_1_receive_valid;
wire [`Noc_Data_Width-1:0] 	Noc_0_1_receive_flit;
wire [0:0]                 	Noc_0_1_receive_is_header;
wire [0:0]                 	Noc_0_1_receive_is_tail;
wire [0:0]                  Noc_0_1_receive_ready;
wire [0:0]                 	Noc_0_1_sender_valid;
wire [`Noc_Data_Width-1:0] 	Noc_0_1_sender_flit;
wire [0:0]                 	Noc_0_1_sender_is_header;
wire [0:0]                 	Noc_0_1_sender_is_tail;
wire [0:0]                  Noc_0_1_sender_ready;

wire [0:0]                 	Noc_1_0_receive_valid;
wire [`Noc_Data_Width-1:0] 	Noc_1_0_receive_flit;
wire [0:0]                 	Noc_1_0_receive_is_header;
wire [0:0]                 	Noc_1_0_receive_is_tail;
wire [0:0]                  Noc_1_0_receive_ready;
wire [0:0]                 	Noc_1_0_sender_valid;
wire [`Noc_Data_Width-1:0] 	Noc_1_0_sender_flit;
wire [0:0]                 	Noc_1_0_sender_is_header;
wire [0:0]                 	Noc_1_0_sender_is_tail;
wire [0:0]                  Noc_1_0_sender_ready;

wire [0:0]                 	Noc_1_1_receive_valid;
wire [`Noc_Data_Width-1:0] 	Noc_1_1_receive_flit;
wire [0:0]                 	Noc_1_1_receive_is_header;
wire [0:0]                 	Noc_1_1_receive_is_tail;
wire [0:0]                  Noc_1_1_receive_ready;
wire [0:0]                 	Noc_1_1_sender_valid;
wire [`Noc_Data_Width-1:0] 	Noc_1_1_sender_flit;
wire [0:0]                 	Noc_1_1_sender_is_header;
wire [0:0]                 	Noc_1_1_sender_is_tail;
wire [0:0]                  Noc_1_1_sender_ready;

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
	.Noc_1_1_sender_is_header  	( Noc_1_1_sender_is_header   ),
	.Noc_1_1_sender_is_tail    	( Noc_1_1_sender_is_tail     )
);


// Noc_empty_node u_Noc_empty_node_0_1(
// 	.noc_clk           	( noc_clk                       ),
// 	.noc_rst_n         	( noc_rst_n                     ),
// 	.receive_valid     	( Noc_0_1_sender_valid          ),
// 	.receive_ready     	( Noc_0_1_sender_ready          ),
// 	.receive_flit      	( Noc_0_1_sender_flit           ),
// 	.receive_is_header 	( Noc_0_1_sender_is_header      ),
// 	.receive_is_tail   	( Noc_0_1_sender_is_tail        ),
// 	.sender_valid      	( Noc_0_1_receive_valid         ),
// 	.sender_ready      	( Noc_0_1_receive_ready         ),
// 	.sender_flit       	( Noc_0_1_receive_flit          ),
// 	.sender_is_header  	( Noc_0_1_receive_is_header     ),
// 	.sender_is_tail    	( Noc_0_1_receive_is_tail       )
// );

// Noc_empty_node u_Noc_empty_node_1_0(
// 	.noc_clk           	( noc_clk                       ),
// 	.noc_rst_n         	( noc_rst_n                     ),
// 	.receive_valid     	( Noc_1_0_sender_valid          ),
// 	.receive_ready     	( Noc_1_0_sender_ready          ),
// 	.receive_flit      	( Noc_1_0_sender_flit           ),
// 	.receive_is_header 	( Noc_1_0_sender_is_header      ),
// 	.receive_is_tail   	( Noc_1_0_sender_is_tail        ),
// 	.sender_valid      	( Noc_1_0_receive_valid         ),
// 	.sender_ready      	( Noc_1_0_receive_ready         ),
// 	.sender_flit       	( Noc_1_0_receive_flit          ),
// 	.sender_is_header  	( Noc_1_0_receive_is_header     ),
// 	.sender_is_tail    	( Noc_1_0_receive_is_tail       )
// );

wire [7:0] receive_num_0_0;
wire [7:0] receive_num_1_0;
wire [7:0] receive_num_1_1;
wire [7:0] receive_num_0_1；

Noc_test_node_verilog #(
	.X_ID      	( 0  ),
	.Y_ID      	( 0  ),
	.DEST_X_ID 	( 1  ),
	.DEST_Y_ID 	( 1  )
)u_Noc_test_node_verilog_0_0(
	.noc_clk           	( noc_clk                   ),
	.noc_rst_n         	( noc_rst_n                 ),
	.receive_valid     	( Noc_0_0_sender_valid      ),
	.receive_ready     	( Noc_0_0_sender_ready      ),
	.receive_flit      	( Noc_0_0_sender_flit       ),
	.receive_is_header 	( Noc_0_0_sender_is_header  ),
	.receive_is_tail   	( Noc_0_0_sender_is_tail    ),
	.sender_valid      	( Noc_0_0_receive_valid     ),
	.sender_ready      	( Noc_0_0_receive_ready     ),
	.sender_flit       	( Noc_0_0_receive_flit      ),
	.sender_is_header  	( Noc_0_0_receive_is_header ),
	.sender_is_tail    	( Noc_0_0_receive_is_tail   ),
	.receive_num       	( receive_num_0_0           )
);

Noc_test_node_verilog #(
	.X_ID      	( 1  ),
	.Y_ID      	( 1  ),
	.DEST_X_ID 	( 0  ),
	.DEST_Y_ID 	( 0  )
)u_Noc_test_node_verilog_1_1(
	.noc_clk           	( noc_clk                   ),
	.noc_rst_n         	( noc_rst_n                 ),
	.receive_valid     	( Noc_1_1_sender_valid      ),
	.receive_ready     	( Noc_1_1_sender_ready      ),
	.receive_flit      	( Noc_1_1_sender_flit       ),
	.receive_is_header 	( Noc_1_1_sender_is_header  ),
	.receive_is_tail   	( Noc_1_1_sender_is_tail    ),
	.sender_valid      	( Noc_1_1_receive_valid     ),
	.sender_ready      	( Noc_1_1_receive_ready     ),
	.sender_flit       	( Noc_1_1_receive_flit      ),
	.sender_is_header  	( Noc_1_1_receive_is_header ),
	.sender_is_tail    	( Noc_1_1_receive_is_tail   ),
	.receive_num       	( receive_num_1_1           )
);

Noc_test_node_verilog #(
	.X_ID      	( 1  ),
	.Y_ID      	( 0  ),
	.DEST_X_ID 	( 0  ),
	.DEST_Y_ID 	( 1  )
)u_Noc_test_node_verilog_1_0(
	.noc_clk           	( noc_clk                   ),
	.noc_rst_n         	( noc_rst_n                 ),
	.receive_valid     	( Noc_1_0_sender_valid      ),
	.receive_ready     	( Noc_1_0_sender_ready      ),
	.receive_flit      	( Noc_1_0_sender_flit       ),
	.receive_is_header 	( Noc_1_0_sender_is_header  ),
	.receive_is_tail   	( Noc_1_0_sender_is_tail    ),
	.sender_valid      	( Noc_1_0_receive_valid     ),
	.sender_ready      	( Noc_1_0_receive_ready     ),
	.sender_flit       	( Noc_1_0_receive_flit      ),
	.sender_is_header  	( Noc_1_0_receive_is_header ),
	.sender_is_tail    	( Noc_1_0_receive_is_tail   ),
	.receive_num       	( receive_num_1_0           )
);

Noc_test_node_verilog #(
	.X_ID      	( 0  ),
	.Y_ID      	( 1  ),
	.DEST_X_ID 	( 1  ),
	.DEST_Y_ID 	( 0  )
)u_Noc_test_node_verilog_0_1(
	.noc_clk           	( noc_clk                   ),
	.noc_rst_n         	( noc_rst_n                 ),
	.receive_valid     	( Noc_0_1_sender_valid      ),
	.receive_ready     	( Noc_0_1_sender_ready      ),
	.receive_flit      	( Noc_0_1_sender_flit       ),
	.receive_is_header 	( Noc_0_1_sender_is_header  ),
	.receive_is_tail   	( Noc_0_1_sender_is_tail    ),
	.sender_valid      	( Noc_0_1_receive_valid     ),
	.sender_ready      	( Noc_0_1_receive_ready     ),
	.sender_flit       	( Noc_0_1_receive_flit      ),
	.sender_is_header  	( Noc_0_1_receive_is_header ),
	.sender_is_tail    	( Noc_0_1_receive_is_tail   ),
	.receive_num       	( receive_num_0_1           )
);

endmodule