
 `timescale 1ps/1ps
module test_uar_tf();

// DATE:     12:39:54 11/15/2006 
// MODULE:   top_test_uar
// DESIGN:   top_test_uar
// FILENAME: tf_uar_test.v
// PROJECT:  UART_Enable
// VERSION:  


// Inputs
    reg clk;
    reg rst_n;
    reg enable1;
    reg enable2;
    reg din_rdy;
    reg [7:0] din_byte;


// Outputs
    	wire [7:0] dout_byte;
   	wire 	 ser_out;
  	wire 	dout_byte_rdy;
  	wire 	uart_ready,ff2_out, ff1_out;
	wire [9:0] dout_byte_temp;

	  wire [3:0] shift_count;
wire [8:0] data_buf;

// Instantiate the UUT
    top_test_uar uut (
        .clk(clk), 
        .rst_n(rst_n), 
        .enable1(enable1), 
        .enable2(enable2), 
        .din_rdy(din_rdy), 
        .din_byte(din_byte), 
        .dout_byte(dout_byte),
	   .ser_out(ser_out),
	   .dout_byte_rdy(dout_byte_rdy),
	   .uart_ready(uart_ready),
		.ff2_out(ff2_out),
		. ff1_out(ff1_out),
	 .shift_count(shift_count),
	 .data_buf(data_buf),
	 .dout_byte_temp(dout_byte_temp)
        );



 initial 
	   begin
            clk = 0;
            rst_n = 1;
            enable1 =0 ;
		  enable2 =0 ;
            din_rdy = 0;
            din_byte = 8'haa;
		   #10_000 rst_n = 0;
        	  #10_000 rst_n = 1;


	    end

reg [3:0] count;

always 
#25431 clk = ~clk;

always @(posedge clk or negedge rst_n)
if(~rst_n)
din_byte<=0;
else if (enable1)
begin
if (count==7)
din_byte<=din_byte+1;
else 
din_byte<=din_byte;
end


always @(posedge clk or negedge rst_n)
if(~rst_n)
din_rdy<=0;
else if (enable1)
begin
if (count==9)
din_rdy<=1;
else 
din_rdy<=0;
end

always @(posedge clk or negedge rst_n)
if(~rst_n)
count<=0;
else if (enable1) 
begin
if(count==9)
count<=0;
else
count<=count+1;
end

reg [10:0] counte;
always @(negedge clk or negedge rst_n)
if(~rst_n)
counte<=0;
else  
counte<=counte+1;

always @(counte)
if(counte==11'h7ff)
enable1=1;
else
enable1=0;

always @(counte)
if(counte[6:0]==7'h7f)
enable2=1;
else
enable2=0;

endmodule

