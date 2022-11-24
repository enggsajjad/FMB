module iobuf8bit(dataLCD, datauC,RW);

inout [7:0] dataLCD;
inout [7:0] datauC;
input RW;


assign dataLCD =(RW==0)? datauC:	8'hzz;
assign datauC  =(RW==1) ? dataLCD:	8'hzz;

endmodule