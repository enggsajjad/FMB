module top_test_uar(clk,rst_n,enable1,enable2,din_rdy,
                   din_byte,dout_byte, ser_out,
			     dout_byte_rdy,uart_ready, ff2_out, ff1_out,
				  data_buf, shift_count,dout_byte_temp);

input  clk, rst_n, din_rdy,enable1,enable2;
 
input [7:0] din_byte;

output [7:0] dout_byte;
output ser_out;
output dout_byte_rdy;
output uart_ready;
output ff2_out, ff1_out;
output [8:0] data_buf;
output [3:0] shift_count;
output [9:0] dout_byte_temp;

wire [9:0] dout_byte_temp;
wire [3:0] shift_count;
wire [8:0] data_buf;
wire ser_out , ser_in;

wire rst_ff1;
reg ff1_out, ff2_out;
 

always@(posedge din_rdy or posedge rst_ff1 or negedge rst_n)	
	if(~rst_n)
		ff1_out <= 0;
	else if(rst_ff1)
		ff1_out <= 0;
	else 
		ff1_out <= 1;
	
always@(posedge clk or negedge rst_n)
	if(~rst_n)
		ff2_out <= 0;
	else if(enable1) 
		ff2_out <= ff1_out;
	else 
		ff2_out <= ff2_out;

assign rst_ff1 = ff2_out;

UA_Receiver u1 (
    .clk(clk), 
    .rst_n(rst_n), 
    .enable(enable2), 
    .ser_in(ser_out), 
    .dout_byte(dout_byte),
    .dout_byte_rdy(dout_byte_rdy),
	 .dout_byte_temp(dout_byte_temp)
     );
UA_Transmitter u2 (
    .clk(clk), 
    .rst_n(rst_n), 
    .enable(enable1), 
    .din_rdy(ff2_out), 
    .din_byte(din_byte), 
    .ser_out(ser_out), 
    .uart_ready(uart_ready),
	 .shift_count(shift_count),
	 .data_buf(data_buf)
    );

endmodule
