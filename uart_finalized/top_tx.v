module top_tx( clk,
					rst, 
    				ser_out, 
    				uart_ready
				);
input clk;
input rst;
output ser_out;
output uart_ready;

wire en_tx;
reg [7:0] din_byte;
reg din_rdy;

reg [3:0] count3;
always @(posedge clk or posedge rst)
if(rst)
count3<=0;
else if (en_tx) 
begin
if(count3==9)
count3<=0;
else
count3<=count3+1;
end

always @(posedge clk or posedge rst)
if(rst)
din_byte<=0;
else if (en_tx)
begin
if (count3==7)
din_byte<=din_byte+1;
else 
din_byte<=din_byte;
end


always @(posedge clk or posedge rst)
if(rst)
din_rdy<=0;
else if (en_tx)
begin
if (count3==9)
din_rdy<=1;
else 
din_rdy<=0;
end



// Instantiate the module
clk_gen u1 (
    .clk(clk), 
    .rst(rst), 
    .en_tx(en_tx), 
    .en_rx()
    );

UA_Transmitter u2 (
    .clk(clk), 
    .rst(rst), 
    .enable(en_tx), 
    .din_rdy(din_rdy), 
    .din_byte(din_byte), 
    .ser_out(ser_out), 
    .uart_ready(uart_ready)
    );


endmodule