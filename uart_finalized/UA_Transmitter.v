module UA_Transmitter( // inputs
		   clk,		// susyem clock input
		   rst,
		   enable,		// active low reset input
		   din_rdy,		// 1-bit ready input signal that indicates the data is ready at input for Tx
		   din_byte,		// 8-bit data input in UART for Tx
		// outputs
		   ser_out,		//1-bit Tx data output from UART
		   uart_ready
			//data_buf,
			// shift_count
		);

// Declaration inputs,outputs
input clk;
input rst;
input enable;
input din_rdy;
input [7:0] din_byte;

output ser_out;
output uart_ready;
//output [8:0] data_buf;
//output [3:0] shift_count;
/////////////////

wire ser_out;
reg [8:0] data_buf;
reg [3:0] shift_count;

assign ser_out = data_buf[0];

always @(posedge clk or posedge rst)
begin
	if(rst)
		data_buf <= 9'h1ff;
	else if (enable)
	     begin
	       if(din_rdy)
		     data_buf <= {din_byte,1'b0};
		  else
		      data_buf <= {1'b1,data_buf[8:1]};
		end
     
end
	 
// counter that count shift in data buffer logic
always @(posedge clk or posedge rst)
begin
	if(rst)
		shift_count <= 4'h0;
	else if (enable)
		begin
		if(din_rdy)
			shift_count <= 0;
		else if (shift_count==4'h9)
			shift_count <= shift_count;
		else
		     shift_count<=shift_count+1;
		end
end

assign uart_ready = (shift_count==9)?0:1;

endmodule