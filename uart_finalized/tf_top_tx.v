`timescale 1ns/1ns

module tf_top_tx();

// DATE:     15:29:28 08/07/2009 
// MODULE:   top_tx
// DESIGN:   top_tx
// FILENAME: tf_top_tx.v
// PROJECT:  UART_Enable
// VERSION:  


// Inputs
    reg clk;
    reg rst;


// Outputs
    wire ser_out;
    wire uart_ready;


// Bidirs


// Instantiate the UUT
    top_tx uut (
        .clk(clk), 
        .rst(rst), 
        .ser_out(ser_out), 
        .uart_ready(uart_ready)
        );


// Initialize Inputs
        initial begin
            clk = 0;
            rst = 0;
				#10_000 rst = 1;
        	   #10_000 rst = 0;
        end

always
#23 clk=~clk;

endmodule