
`timescale  1ns/ 1ns
module Trans_tf();

// DATE:     10:52:04 07/21/2008 
// MODULE:   UA_Transmitter
// DESIGN:   UA_Transmitter
// FILENAME: Trans.v
// PROJECT:  uart1
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


// Bidirs


// Instantiate the UUT
    UA_Transmitter uut (
        .clk(clk), 
        .rst(rst_n), 
        .enable(enable), 
        .din_rdy(din_rdy), 
        .din_byte(din_byte), 
        .ser_out(ser_out), 
        .uart_ready(uart_ready)
        );


// Initialize Inputs
        initial begin
            clk = 0;
            rst_n = 0;
            enable = 0;
            din_rdy = 0;
            din_byte = 8'hAA;
		  #100 rst_n = 1;
		  #100 rst_n = 0;

		 #1000 din_rdy=1;
		 #100 din_rdy=0;


        end

always
#160 clk = ~clk;


always
begin
#((160*160)-160) enable =1 ;
#((160*160)) enable =0 ;
end




endmodule

