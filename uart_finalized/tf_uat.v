
`timescale 1ps/1ps
module tf_uat();

// DATE:     09:10:44 11/15/2006 
// MODULE:   uat_top
// DESIGN:   uat_top
// FILENAME: tf_uat.v
// PROJECT:  UART_Enable
// VERSION:  


// Inputs
    reg clk;
    reg rst_n;
    reg enable;
    reg din_rdy;
    reg [7:0] din_byte;


// Outputs
    wire ser_out;
    wire uart_ready;
    wire [3:0] shift_count;
   reg [3:0] count;


// Bidirs


// Instantiate the UUT
    uat_top uut (
        .clk(clk), 
        .rst_n(rst_n), 
        .enable(enable), 
        .din_rdy(din_rdy), 
        .din_byte(din_byte), 
        .ser_out(ser_out), 
        .uart_ready(uart_ready),
	   .shift_count(shift_count)
        );


// Initialize Inputs

        initial 
	   begin
            clk = 0;
            rst_n = 0;
            enable =0 ;
            din_rdy = 0;
            din_byte = 8'haa;
		  #10_000 rst_n = 0;
        	  #10_000 rst_n = 1;

	    end

always 
#25431 clk = ~clk;

always @(posedge clk or negedge rst_n)
if(~rst_n)
din_rdy<=0;
else if (enable)
begin
if (count==9)
din_rdy<=1;
else 
din_rdy<=0;
end


always @(posedge clk or negedge rst_n)
if(~rst_n)
count<=0;
else if (enable) 
count<=count+1;

reg [10:0] counte;
always @(negedge clk or negedge rst_n)
if(~rst_n)
counte<=0;
else  
counte<=counte+1;

always @(counte)
if(counte==11'h7ff)
enable=1;
else
enable=0;



endmodule

