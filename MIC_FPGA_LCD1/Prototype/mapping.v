module mapping(clk,rst,Port0,Port1,Port2,Port3,LcdBus,LcdRS,LcdRW,LcdEN,LcdBK,SSA,SSB,SSC,SSD,SSE,SSF,SSG,SSP,MAX9,MAX10,Key,KeyIntr);

input clk;
input rst;
inout [7:0] Port0;
input [7:0] Port1;
output [7:0] Port2;
output [7:0] Port3;
inout [7:0] LcdBus;
output LcdRS;
output LcdRW;
output LcdEN;
output LcdBK;
output SSA;
output SSB;
output SSC;
output SSD;
output SSE;
output SSF;
output SSG;
output SSP;
input MAX9;
output MAX10;
input [3:0] Key;
input KeyIntr;


reg [7:0] count;

//assign LcdBus = Port0;
assign LcdBK = Port1[0];
assign LcdRS = Port1[1];
assign LcdRW = Port1[2];
assign LcdEN = Port1[3];

assign SSA = 1'b1;
assign SSB = 1'b0;
assign SSC = 1'b1;
assign SSD = 1'b1;
assign SSE = 1'b1;
assign SSF = 1'b1;
assign SSG = 1'b0;
assign SSP = 1'b1;
assign MAX10 = 1'b1;



always @(posedge clk or posedge rst)
if(rst)
	count<=0;
else
	count<=count+1;

assign Port3=count;
assign Port2={Key,KeyIntr, 3'b101};

// Instantiate the module
iobuf8bit instance_name (
    .dataLCD(LcdBus), 
    .datauC(Port0), 
    .RW(LcdRW)
    );
endmodule