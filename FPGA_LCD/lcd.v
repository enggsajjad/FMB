module lcd(clk,rst,rs,rw,en,dout);

input clk;				// main clock 22.1184MHz
input rst;				// system reset
output rw;				// read/write pin to lcd
output rs;				// register select pin to lcd
output en;				// enable pin to lcd
output [7:0] dout;	// lcd data bus

wire ok;					// shows that commanad has been written to lcd
wire intr; 				// start writing to lcd
wire ok1;				// delayed version of ok, 1 cycle
reg [25:0]  din;		// [17bit delay,1bit rs,8bit data]

parameter	COMM = 1'b0,
				DATA = 1'b1;
parameter	DLY4pt1ms	=	17'd90685,
				DLY100us	=	17'd2212,
				DLY40us	=	17'd885,
				DLY1pt64ms	= 17'd36275;
parameter	FUNC_SET	=	8'h38,
				ENTR_SET = 	8'h06,	
				DISP_SET =  8'h0C,
				DISP_CLR =  8'h01;
parameter	ROW1 =  8'h80,ROW2 =  8'hC0,ROW3 =  8'h94,ROW4 =  8'hD4,

				COL1 =  8'h00,COL2 =  8'h01,COL3 =  8'h02,COL4 =  8'h03,
				COL5 =  8'h04,COL6 =  8'h05,COL7 =  8'h06,COL8 =  8'h07,
				COL9 =  8'h08,COL10 =  8'h09,COL11 =  8'h0A,COL12 =  8'h0B,
				COL13 =  8'h0C,COL14 =  8'h0D,COL15 =  8'h0E,COL16 =  8'h0F,
				COL17 =  8'h10,COL18 =  8'h11,COL19 =  8'h12,COL20 =  8'h13;
// Generate "intr" signal from the "ok" signal
// that is ready next when lcd is free
reg [2:0] shift;
reg [4:0]  addr;
always @ (posedge clk or posedge rst)
if(rst)
	shift<=0;
else 
	shift<= {shift[1:0],ok};
// delayed "ok"
assign ok1 = shift[2];
// generate interrupt after every "ok" till specified address
assign intr = ok1 && (addr<18);
// increment the address
always @(posedge clk or posedge rst)
if(rst)
	addr<=-1;
else if(addr == 18)
	addr <= addr;
else if(ok)
	addr<=addr+1;
else 
	addr<=addr;
// look up table to be sent to lcd
always @(addr)
case(addr)
5'd0:		din={DLY4pt1ms,COMM,FUNC_SET};
5'd1:		din={DLY100us,COMM,FUNC_SET};
5'd2:		din={DLY40us,COMM,FUNC_SET};
5'd3:		din={DLY40us,COMM,ENTR_SET};
5'd4:		din={DLY40us,COMM,DISP_SET};
5'd5:		din={DLY1pt64ms,COMM,DISP_CLR};
5'd6:		din={DLY40us,DATA,8'h48};
5'd7:		din={DLY40us,DATA,8'h45};
5'd8:		din={DLY40us,DATA,8'h4C};
5'd9:		din={DLY40us,DATA,8'h4C};
5'd10:	din={DLY40us,DATA,8'h4F};
5'd11:	din={DLY40us,COMM,ROW3+COL1};
5'd12:	din={DLY40us,DATA,8'h53};
5'd13:	din={DLY40us,DATA,8'h41};
5'd14:	din={DLY40us,DATA,8'h4A};
5'd15:	din={DLY40us,DATA,8'h4A};
5'd16:	din={DLY40us,DATA,8'h41};
5'd17:	din={DLY40us,DATA,8'h44};
5'd18:	din={DLY40us,DATA,8'h21};

default:	din={DLY4pt1ms,COMM,FUNC_SET};
endcase
// instance of lcd module
LcdWrite LcdWriteInst(
    .clk(clk),
	 .rst(rst), 
    .intr(intr), 
    .din(din), 
    .rs(rs), 
    .rw(rw), 
    .en(en), 
    .dout(dout),
	 .ok(ok)
    );
endmodule