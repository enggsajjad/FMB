module LcdWrite(clk,rst,intr,din,rs,rw,en,dout,ok);

input clk;				// main clock 22.1184MHz
input rst;				// system reset
input intr; 			// start writing to lcd
input [25:0] din;		// [17bit delay,1bit rs,8bit data]
output rs;				// register select pin to lcd
output rw;				// read/write pin to lcd
output en;				// enable pin to lcd
output ok;				// shows that commanad has been written to lcd

output [7:0] dout;	// lcd data bus

wire intr1;				// delay 1 cycle "intr"
wire dly_done;			// delay of a write operation completed
wire en_done;			// enable generated

reg flag_dly;			// start the delay
reg flag_en;			// start generating enable signal
reg [16:0] delay;		// delay value register
reg [16:0] dly_cntr;	// used in generating delay fot write
reg [3:0] en_cntr;	// used in generating enable signal
reg [2:0]  state;		// State machine variable
reg [2:0]  nstate;	// State machine variable
reg [7:0]  dout;		// lcd data bus
reg ok;					// shows that commanad has been written to lcd

`define 	WAIT			3'd0
`define 	SEND			3'd1
`define 	SEND_WAIT	3'd2
`define 	DLY_START	3'd3
`define 	DLY_DONE		3'd4
`define 	WRITE_OK		3'd5

// intr to be delayed
reg [3:0] shift;
always @(posedge clk or posedge rst)
if(rst)
	shift<=0;
else
	shift<={shift[2:0],intr};
// assign delayed version of intr
assign intr1 = shift[1];
// capture 17bit value for delay
always @(posedge clk or posedge rst)
if(rst)
	delay<=0;
else if(intr)
	delay<=din[25:9];
else
	delay<=delay;
// capture register select to distinguish command/data
assign rs = din[8];
// always we are writting
assign rw = 0;

// assign 7bit data to lcd data bus
always @(posedge clk or posedge rst)
if(rst)
	dout<=0;
else
	dout <= din[7:0];
// generate delay when asked
always @(posedge clk or posedge rst)
if(rst)
	dly_cntr <= delay;
else if(flag_dly)
	dly_cntr <= 0;
else if (dly_cntr == delay)
	dly_cntr<=dly_cntr;
else
	dly_cntr <= dly_cntr+1;
// indicate completion of delay
assign dly_done = (dly_cntr==(delay-2))?1:0;

// make enable signal for LCD
always @(posedge clk or posedge rst)
if(rst)
	en_cntr <= 15;
else if(flag_en)
	en_cntr <= 0;
else if (en_cntr == 15)
	en_cntr<=en_cntr;
else
	en_cntr <= en_cntr+1;
// enable signal generated
assign en_done = (en_cntr==10)?1:0;
// generate the enable signal of some width
assign en = (en_cntr>=2 && en_cntr<=10) ? 1 : 0;
		  
// State machine
always @(posedge clk or posedge rst)
if(rst)
	state<=`WRITE_OK;
else
	state<=nstate;

always @(state or  dly_done or en_done or intr1)
case(state)
	`WAIT:
		if(intr1)
			nstate = `SEND;
		else
			nstate = `WAIT;
	`SEND:
			nstate = `SEND_WAIT;
	`SEND_WAIT:
		if(en_done)
			nstate = `DLY_START;
		else
			nstate = `SEND_WAIT;
	`DLY_START:
			nstate = `DLY_DONE;
	`DLY_DONE:
		if(dly_done)
			nstate = `WRITE_OK;
		else
			nstate = `DLY_DONE;
	`WRITE_OK:
		nstate = `WAIT;
	default:
		nstate = `WAIT;
endcase

always @(state)
begin
	flag_en = 0;
	flag_dly = 0;
	ok = 0;
	case(state)
		`WAIT:;
		`SEND:	 
			flag_en = 1;
		`SEND_WAIT:;
		`DLY_START:
			flag_dly=1;
		`DLY_DONE:;
		`WRITE_OK:
			ok = 1;			
	endcase
end
endmodule