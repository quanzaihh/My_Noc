/*
    created by: <Xidian University>
    created date: 2024-05-16
*/

module Noc_fifo #(
	parameter int   WIDTH       = 8,
	parameter type  DATA_TYPE   = logic [WIDTH-1:0],
	parameter int   DEPTH       = 8,
	parameter int   THRESHOLD   = DEPTH,
	parameter bit   DATA_FF_OUT = 0,
	parameter bit   FLAG_FF_OUT = 0
)(
	input   logic     clk,
	input   logic     rst_n,
	input   logic     i_clear,
	output  logic     o_empty,
	output  logic     o_almost_full,
	output  logic     o_full,
	input   logic     i_push,
	input   DATA_TYPE i_data,
	input   logic     i_pop,
	output  DATA_TYPE o_data
);
	localparam  int COUNTER_WIDTH = $clog2(DEPTH + 1);
	localparam  int RAM_WORDS     = (DATA_FF_OUT) ? DEPTH - 1 : DEPTH;
	localparam  int POINTER_WIDTH = (RAM_WORDS >= 2) ? $clog2(RAM_WORDS) : 1;

	typedef struct packed {
		logic empty;
		logic almost_full;
		logic full;
	} s_status_flags;

	logic                     push;
	logic                     pop;
	logic [COUNTER_WIDTH-1:0] word_count;
	logic [COUNTER_WIDTH-1:0] word_count_next;
	s_status_flags            status_flags;
	logic                     write_to_ff;
	logic                     write_to_ram;
	logic [POINTER_WIDTH-1:0] write_pointer;
	logic                     read_from_ram;
	logic [POINTER_WIDTH-1:0] read_pointer;
	DATA_TYPE                 ram_read_data;
	DATA_TYPE                 out_data;

	//--------------------------------------------------------------
	//  word counter
	//--------------------------------------------------------------
	assign  push  = (i_push && (!status_flags.full )) ? 1'b1 : 1'b0;
	assign  pop   = (i_pop  && (!status_flags.empty)) ? 1'b1 : 1'b0;

	Noc_counter #(
		.MAX_COUNT  (DEPTH  ),
		.MIN_COUNT  (0      )
	) u_word_counter (
		.clk          (clk              ),
		.rst_n        (rst_n            ),
		.i_clear      (i_clear          ),
		.i_set        ('0               ),
		.i_set_value  ('0               ),
		.i_up         (push             ),
		.i_down       (pop              ),
		.o_count      (word_count       ),
		.o_count_next (word_count_next  )
	);

	//--------------------------------------------------------------
	//  status flags
	//--------------------------------------------------------------
	assign  o_empty       = status_flags.empty;
	assign  o_almost_full = status_flags.almost_full;
	assign  o_full        = status_flags.full;

	if (FLAG_FF_OUT) begin : g_flag_ff_out
		localparam  s_status_flags  INITIAL_FLAGS = '{
			empty: 1'b1, almost_full: 1'b0, full: 1'b0
		};

		always_ff @(posedge clk, negedge rst_n) begin
			if (!rst_n) begin
				status_flags  <= INITIAL_FLAGS;
			end
			else if (i_clear) begin
				status_flags  <= INITIAL_FLAGS;
			end
			else begin
				status_flags  <= get_status_flags(word_count_next);
			end
		end
	end
	else begin : g_flag_logic_out
		assign  status_flags  = get_status_flags(word_count);
	end

	function automatic s_status_flags get_status_flags(
		input logic [COUNTER_WIDTH-1:0] word_count
	);
		s_status_flags  flags;
		flags.empty       = (word_count == 0        ) ? '1 : '0;
		flags.almost_full = (word_count >= THRESHOLD) ? '1 : '0;
		flags.full        = (word_count == DEPTH    ) ? '1 : '0;
		return flags;
	endfunction

	//--------------------------------------------------------------
	//  write/read pointer
	//--------------------------------------------------------------
	if (DATA_FF_OUT) begin
		assign  write_to_ff   = (status_flags.empty || (  pop  && (word_count == 1))) ? push : '0;
		assign  write_to_ram  = ((word_count >= 2)  || ((!pop) && (word_count == 1))) ? push : '0;
		assign  read_from_ram = ( word_count >= 2                                   ) ? pop  : '0;
	end
	else begin
		assign  write_to_ff   = '0;
		assign  write_to_ram  = push;
		assign  read_from_ram = pop;
	end

	if (RAM_WORDS >= 2) begin : g_multi_words_ram
		localparam  bit [POINTER_WIDTH-1:0] LAST_POINTER  = RAM_WORDS - 1;

		Noc_counter #(
			.MAX_COUNT  (LAST_POINTER ),
			.MIN_COUNT  (0            )
		) u_write_pointer (
			.clk          (clk            ),
			.rst_n        (rst_n          ),
			.i_clear      (i_clear        ),
			.i_set        ('0             ),
			.i_set_value  ('0             ),
			.i_up         (write_to_ram   ),
			.i_down       ('0             ),
			.o_count      (write_pointer  ),
			.o_count_next ()
		);

		Noc_counter #(
			.MAX_COUNT  (LAST_POINTER ),
			.MIN_COUNT  (0            )
		) u_read_pointer (
			.clk          (clk            ),
			.rst_n        (rst_n          ),
			.i_clear      (i_clear        ),
			.i_set        ('0             ),
			.i_set_value  ('0             ),
			.i_up         (read_from_ram  ),
			.i_down       ('0             ),
			.o_count      (read_pointer   ),
			.o_count_next ()
			);
	end
	else begin : g_single_word_ram
		assign  write_pointer = '0;
		assign  read_pointer  = '0;
	end

	//--------------------------------------------------------------
	//  RAM
	//--------------------------------------------------------------
	if (RAM_WORDS >= 1) begin : g_ram
		DATA_TYPE ram[RAM_WORDS];
		assign  ram_read_data = ram[read_pointer];
		always_ff @(posedge clk or negedge rst_n) begin
			if (!rst_n) begin
				for (int i = 0; i < RAM_WORDS; i++) begin
					ram[i]  <= DATA_TYPE'(0);
				end
			end
			else if (write_to_ram) begin
				ram[write_pointer]  <= i_data;
			end
		end
	end
	else begin : g_no_ram
		assign  ram_read_data = DATA_TYPE'(0);
	end

	//--------------------------------------------------------------
	//  output control
	//--------------------------------------------------------------
	assign  o_data  = out_data;

	if (DATA_FF_OUT) begin
		always_ff @(posedge clk or negedge rst_n) begin
		if (!rst_n) begin
			out_data  <= DATA_TYPE'(0);
		end
		else if (write_to_ff) begin
			out_data  <= i_data;
		end
		else if (read_from_ram) begin
			out_data  <= ram_read_data;
		end
		end
	end
	else begin
		assign  out_data  = ram_read_data;
	end
endmodule

module Noc_counter #(
	parameter   int MAX_COUNT     = 3,
	parameter   int MIN_COUNT     = 0,
	parameter   int INITIAL_COUNT = MIN_COUNT,
	parameter   bit WRAP_AROUND   = 1,
	localparam  int WIDTH         = $clog2(MAX_COUNT + 1)
)
(
	input   logic             clk,
	input   logic             rst_n,
	input   logic             i_clear,
	input   logic             i_set,
	input   logic [WIDTH-1:0] i_set_value,
	input   logic             i_up,
	input   logic             i_down,
	output  logic [WIDTH-1:0] o_count,
	output  logic [WIDTH-1:0] o_count_next
);
	localparam  bit [WIDTH-1:0] INITIAL = INITIAL_COUNT;
	localparam  bit [WIDTH-1:0] MAX     = MAX_COUNT;
	localparam  bit [WIDTH-1:0] MIN     = MIN_COUNT;

	logic [WIDTH-1:0] count;
	logic [WIDTH-1:0] count_next;

	assign  o_count       = count;
	assign  o_count_next  = count_next;
	assign  count_next    = get_count_next(
		.clear          (i_clear      ),
		.set            (i_set        ),
		.set_value      (i_set_value  ),
		.up             (i_up         ),
		.down           (i_down       ),
		.current_count  (count        )
	);

	always_ff @(posedge clk, negedge rst_n) begin
		if (!rst_n) begin
			count <= INITIAL;
		end
		else begin
			count <= count_next;
		end
	end

	function automatic logic [WIDTH-1:0] get_count_next(
		input logic             clear,
		input logic             set,
		input logic [WIDTH-1:0] set_value,
		input logic             up,
		input logic             down,
		input logic [WIDTH-1:0] current_count
	);
		if (clear) begin
			return INITIAL;
		end
		else if (set) begin
			return set_value;
		end
		else if ({up, down} == 2'b10) begin
			return count_up(current_count);
		end
		else if ({up, down} == 2'b01) begin
			return count_down(current_count);
		end
		else begin
			return current_count;
		end
	endfunction

	function automatic logic [WIDTH-1:0] count_up(input logic [WIDTH-1:0] current_count);
		if (current_count == MAX) begin
			return (WRAP_AROUND) ? MIN : MAX;
		end
		else begin
			return current_count + 1;
		end
	endfunction

	function automatic logic [WIDTH-1:0] count_down(input logic [WIDTH-1:0] current_count);
		if (current_count == MIN) begin
			return (WRAP_AROUND) ? MAX : MIN;
		end
		else begin
			return count - 1;
		end
	endfunction
endmodule
