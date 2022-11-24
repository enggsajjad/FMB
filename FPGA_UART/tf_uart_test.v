// Verilog test fixture created from schematic uart.sch - Mon Jul 21 13:46:44 2008

`timescale 1ns/1ns
 module tf1();

// Inputs
   reg clk;
   reg rx;

// Output
   wire tx;
   reg res;

// Bidirs

// Instantiate the UUT
   uart UUT (
		.clk(clk), 
		.tx(tx), 
		.rx(rx),
		.res(res)
   );
// Initialize Inputs
   
       initial 
	  begin
		clk=0;
		res =0;
		rx=1;		
		#100  res  =1;
		#100  res  =0;

		#(52083*12) rx =1;
		
		
		#52083 rx =0;//start
		
		#52083 rx =0;//d0
		#52083 rx =1;
		#52083 rx =0;
		#52083 rx =1;
		#52083 rx =0;
		#52083 rx =1;
		#52083 rx =0;
		#52083 rx =1;

		#52083 rx =1;//stop
		#52083 rx =1;
		
		
		#52083 rx =0;//start
		
		#52083 rx =0;//d0
		#52083 rx =0;
		#52083 rx =0;
		#52083 rx =1;
		#52083 rx =0;
		#52083 rx =1;
		#52083 rx =0;
		#52083 rx =1;

		#52083 rx =1;//stop
		#52083 rx =1;


       end

always 
//#(10*16) clk = ~clk;
#(10) clk = ~clk;

							
endmodule