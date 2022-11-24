module mapping
(
Port0,
Port1,
LcdBus,
LcdRS,
LcdRW,
LcdEN,
LcdBK
);


input [7:0] Port0;
input [3:0] Port1;
output [7:0] LcdBus;
output LcdRS;
output LcdRW;
output LcdEN;
output LcdBK;


assign LcdBus = Port0;
assign LcdBK = Port1[0];
assign LcdRS = Port1[1];
assign LcdRW = Port1[2];
assign LcdEN = Port1[3];


endmodule