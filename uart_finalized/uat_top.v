module uat_top( // inputs
		   clk,		// susyem clock input
		   rst_n,		// active low reset input
		   din_rdy,		// 1-bit ready input signal that indicates the data is ready at input for Tx
		   din_byte,		// 8-bit data input in UART for Tx
		// outputs
		   ser_out,		//1-bit Tx data output from UART
		   uart_ready	  // 1-bit control signal goes to sequence controller
		);

// Declaration inputs,outputs
input clk;
input rst_n;
input din_rdy;
input [7:0] din_byte;

output ser_out;
output uart_ready;

reg ser_out;
reg [7:0] data_buf;
reg [3:0] shift_count;
reg din_rdy_reg;

wire start_bit_sig;
wire data_bits_sig;
wire stop_bit_sig;

// registered data ready signal
always @(negedge clk or negedge rst_n)
begin
	if(~rst_n)
		din_rdy_reg <= 1'b0;
	else
		din_rdy_reg <= din_rdy;
end

// output logic
always @(negedge clk or negedge rst_n)
begin
	if (~rst_n)
		ser_out <= 1'b1;
	else
	begin
		case ({start_bit_sig,data_bits_sig,stop_bit_sig})
			3'b100:	ser_out <= 1'b0;
			3'b010:	ser_out <= data_buf[0];
			3'b001:	ser_out <= 1'b1;
			default: ser_out <= 1'b1;
		endcase
	end
end


// start bit pipelining
always @(negedge clk or negedge rst_n)
begin
	if(~rst_n)
		data_buf <= 8'h0;
	else if(start_bit_sig)
		data_buf <= din_byte;	// at just arriving the start_bit_sig, we load data into data_bffer
	else if(data_bits_sig)
		data_buf <= {1'b1,data_buf[7:1]};
	else
		data_buf <= data_buf;
end

// counter that count shift in data buffer logic
always @(negedge clk or negedge rst_n)
begin
	if(~rst_n)
		shift_count <= 4'h0;
	else if(data_bits_sig)
		shift_count <= shift_count+1;
	else if (shift_count==4'h8)
		shift_count <= 4'h0;
end


// state machine for Tx
uat_sm uat_sm_inst( // inputs
				.clk	     (clk),
				.rst_n	     (rst_n),
				.din_rdy	    (din_rdy_reg),		// 1-bit serial data from channel
				.shift_count	(shift_count),
		    // outputs
				.start_bit_sig	(start_bit_sig),	// start bit insertion control signal generated from state machine
				.data_bits_sig	(data_bits_sig),	// data bits insertion control signal generated from state machine
				.stop_bit_sig	 (stop_bit_sig),	// stop bit insertion control signal generated from state machine
				.uart_ready	   (uart_ready)
				);
endmodule
