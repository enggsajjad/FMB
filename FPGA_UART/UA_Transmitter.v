module UA_Transmitter(// inputs
		  	 				clk,				// system clock input
		   				rst,
		   				enable,			// active low reset input
		   				din_rdy,			// 1-bit ready input signal that indicates the data is ready at input for Tx
		   				din_byte,		// 8-bit data input in UART for Tx
		   				// outputs
		   				ser_out,			//1-bit Tx data output from UART
		   				uart_ready	
		 					);

// Declaration inputs,outputs
input clk;
input rst;
input enable;
input din_rdy;
input [7:0] din_byte;
output ser_out;
output uart_ready;

wire ser_out;
reg [8:0] data_buf;
reg [3:0] shift_count;

wire rst_ff1;
reg ff1_out, ff2_out;
initial
ff1_out=0;
 
always@(posedge din_rdy or posedge rst_ff1)	
	if(rst_ff1)
		ff1_out <= 0;
	else 
		ff1_out <= 1;
	
always@(posedge clk or posedge rst)
	if(rst)
		ff2_out <= 0;
	else if(enable) 
		ff2_out <= ff1_out;
	else 
		ff2_out <= ff2_out;

assign rst_ff1 = ff2_out;



assign ser_out = data_buf[0];

// start bit pipelining
always @(posedge clk or posedge rst)
begin
	if(rst)
		data_buf <= 9'h1ff;
	else if (enable)
	     begin
	       if(ff2_out) ///din_rdy
		  	data_buf <= {din_byte,1'b0};	// at just arriving the start_bit_sig, we load data into data_bffer
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
		if(ff2_out)	 //din ready synced
			shift_count <= 0;
		else if (shift_count==4'ha)
			shift_count <= shift_count;
		else
		     shift_count<=shift_count+1;
		end
end

assign uart_ready = (shift_count==10)?1:0;

endmodule
