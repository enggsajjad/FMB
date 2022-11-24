module clk_gen(clk, rst, en_rx, en_tx);

input clk;
input rst;
output en_rx;
output en_tx;

reg [7:0] cnt3;


reg [3:0] cnt1;
reg [3:0] cnt2;

always  @(posedge clk or posedge rst)
if(rst)
cnt1<=0;
//else if (cnt1==9)
else if (cnt1==8)
cnt1<=0;
else
cnt1<=cnt1+1;

//assign en_rx = (cnt1==9)?1:0;//50MHz 19200   Div=16
assign en_rx = (cnt1==8)?1:0;//22.1184MHz 19200   Div=8
/*
always  @(posedge clk or posedge rst)
if(rst)
cnt2<=0;
else if (cnt1==9)
cnt2<=cnt2+1;

assign en_tx  = ((cnt1==9)&&(cnt2==15))?1:0;
*/


always  @(posedge clk or posedge rst)
if(rst)
cnt3<=0;
//else if (cnt3==160)
else if (cnt3==143)
cnt3<=0;
else
cnt3<=cnt3+1;

//assign en_tx  = (cnt3==160)?1:0;//50MHz 19200 Div=16
assign en_tx  = (cnt3==143)?1:0;//22.1184MHz 19200   Div=8

endmodule
