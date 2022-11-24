module clk_gen(clk,rst,en_tx,en_rx);

input clk;
input rst;
output en_tx;
output en_rx;

reg [8:0] count_tx;
reg [4:0] count_rx;

always @(negedge clk or posedge rst)
if(rst)
count_tx<=0;
else if (count_tx ==383) 
count_tx<=0;
else
count_tx<=count_tx+1;

always @(negedge clk or posedge rst)
if(rst)
count_rx<=0;
else if (count_rx ==23) 
count_rx<=0;
else
count_rx<=count_rx+1;

assign en_tx = (count_tx ==383)?1:0;
assign en_rx = (count_rx ==23)?1:0;

endmodule