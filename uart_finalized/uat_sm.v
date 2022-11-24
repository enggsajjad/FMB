module uat_sm(	// inputs
			clk,
			rst_n,
			din_rdy,
			shift_count,
			// outputs
			start_bit_sig,
			data_bits_sig,
			stop_bit_sig,
			uart_ready			
			);


input clk;
input rst_n;
input din_rdy;
input [3:0] shift_count;
output start_bit_sig;
output data_bits_sig;
output stop_bit_sig;
output uart_ready;

reg [3:0] current_state;
reg [3:0] next_state;

wire start_bit_sig;
wire data_bits_sig;
wire stop_bit_sig;
wire usrt_ready;

parameter [3:0] IDLE		= 4'b1000;
parameter [3:0] START_BIT_ST	= 4'b0100;
parameter [3:0] DATA_BITS_ST	= 4'b0010;
parameter [3:0] STOP_BIT_ST 	= 4'b0001;

// state register
always @(posedge clk or negedge rst_n)
begin
	if(~rst_n)
		current_state <= IDLE;
	else
		current_state <= next_state;
end

// next state logic
always @(current_state or shift_count or din_rdy)
begin
	case(current_state)
		IDLE			:
					begin
					if(din_rdy)
						next_state = START_BIT_ST;
					else
						next_state = IDLE;
					end

		START_BIT_ST	:
					begin
					next_state = DATA_BITS_ST;
					end

		DATA_BITS_ST	:
					begin
					if(shift_count == 8)
						next_state = STOP_BIT_ST;
					else
						next_state = DATA_BITS_ST;
					end

		STOP_BIT_ST	:
					begin
					if(din_rdy)
						next_state = START_BIT_ST;
					else
						next_state = IDLE;
					end

		default		:
					begin
					next_state = IDLE;
					end
	endcase
end

// output signals logic
assign uart_ready = ((current_state == START_BIT_ST) || (current_state == DATA_BITS_ST)) ? 1'b1: 1'b0;
assign start_bit_sig = (current_state == START_BIT_ST) ? 1'b1 : 1'b0;
assign data_bits_sig = (current_state == DATA_BITS_ST) ? 1'b1 : 1'b0;
assign stop_bit_sig = (current_state == STOP_BIT_ST) ? 1'b1 : 1'b0;

endmodule
