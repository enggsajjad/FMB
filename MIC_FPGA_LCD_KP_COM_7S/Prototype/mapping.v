module mapping(P0,
					P1_LSB,
					P1_MSB,
					P3_2,
					LcdBus,
					LcdRS,
					LcdRW,
					LcdEN,
					LcdBK,
					Key,
					KeyIntr,
					P3_0,
					P3_1,
					MAX9,
					MAX10,
					P2,
					SS
					);


inout [7:0] P0;
input [3:0] P1_LSB;
inout [7:0] LcdBus;
output [3:0] P1_MSB;
output P3_2;
output LcdRS;
output LcdRW;
output LcdEN;
output LcdBK;
input [3:0] Key;
input KeyIntr;
output P3_0;
input P3_1;
output MAX10;
input MAX9;

input [7:0] P2;
output [7:0] SS;
assign LcdBK = P1_LSB[0];
assign LcdRS = P1_LSB[1];
assign LcdRW = P1_LSB[2];
assign LcdEN = P1_LSB[3];

assign P1_MSB = Key;
assign P3_2	= KeyIntr;

assign MAX10 = P3_1;
assign P3_0 = MAX9;

assign SS = P2;

// Instantiate the module
iobuf8bit sajjad_iobuf8 (
    .dataLCD(LcdBus), 
    .datauC(P0), 
    .RW(LcdRW)
    );
endmodule