`timescale 1ns / 1ns
module tf;

	// Inputs
	reg clk;
	reg rst;

	// Outputs
	wire rs;
	wire rw;
	wire en;
	wire [7:0] dout;

	// Instantiate the Unit Under Test (UUT)
	lcd uut (
		.clk(clk), 
		.rst(rst),
		.rs(rs), 
		.rw(rw), 
		.en(en), 
		.dout(dout)
	);

	initial begin
		// Initialize Inputs
		clk = 0;
		rst = 0;
		#100 rst = 1;
		#100 rst = 0;
       
		// Add stimulus here

	end
always 
#23 clk = ~clk;      
endmodule

