#define Putc LcdWriteChar
sbit BLT = P1^0;
sbit RS  = P1^1; 
sbit RW  = P1^2;
sbit EN  = P1^3;
sbit BS  = P0^7;

sbit dis_a = P2^0;        /*a segment*/
sbit dis_b = P2^1;        /*b segment*/
sbit dis_c = P2^2;        /*c segment*/
sbit dis_d = P2^3;        /*d segment*/
sbit dis_e = P2^4;        /*e segment*/
sbit dis_f = P2^5;        /*f segment*/
sbit dis_g = P2^6;        /*g segment*/
sbit dis_p = P2^7;        /*point*/

void DelayOnems(void)
{
	TL0 = 0xCD;
	TH0 = 0xF8;
	TR0  = 1;
	while(!TF0);
	TR0  = 0;
	TF0  = 0;
}
void DelaySec(unsigned char ds)
{
	unsigned int k; 
	for(k=0;k<(ds*1000);k++)
		DelayOnems();
}
unsigned char Getc(void)
{
	unsigned char c;
	while(!RI);	c = SBUF; RI = 0;
	return(c);
} 
void SendChar(unsigned char ch)
{
	TI=1;
	while (!TI);	TI=0;	SBUF = ch;
	while (!TI);	TI=0; 	
}
void SendStr(char *cmd)
{
	TI=1;
	while(*cmd)
	{
		while (!TI);	TI=0;	SBUF = *cmd;
		cmd++;
	}
	while (!TI);	TI=0;
}
/*---------------------------------------------------
Display the data passed to this function
----------------------------------------------------*/
void display_digit(unsigned char digg)
{
	if (digg==0x00)                /*Display 0*/
	{
		dis_a=1;
		dis_b=1;
		dis_c=1;
		dis_d=1;
		dis_e=1;
		dis_f=1;
		dis_g=0;
	}
	else if (digg==1)
	{
		dis_a=0;
		dis_b=1;
		dis_c=1;
		dis_d=0;
		dis_e=0;
		dis_f=0;
		dis_g=0;
	}
	else if (digg==2)
	{
		dis_a=1;
		dis_b=1;
		dis_c=0;
		dis_d=1;
		dis_e=1;
		dis_f=0;
		dis_g=1;
	}
	else if (digg==3)
	{
		dis_a=1;
		dis_b=1;
		dis_c=1;
		dis_d=1;
		dis_e=0;
		dis_f=0;
		dis_g=1;
	}
	else if (digg==4)
	{
		dis_a=0;
		dis_b=1;
		dis_c=1;
		dis_d=0;
		dis_e=0;
		dis_f=1;
		dis_g=1;
	}
	else if (digg==5)
	{
		dis_a=1;
		dis_b=0;
		dis_c=1;
		dis_d=1;
		dis_e=0;
		dis_f=1;
		dis_g=1;
	}    
	else if (digg==6)
	{
		dis_a=1;
		dis_b=0;
		dis_c=1;
		dis_d=1;
		dis_e=1;
		dis_f=1;
		dis_g=1;
	}
	else if (digg==7)
	{
		dis_a=1;
		dis_b=1;
		dis_c=1;
		dis_d=0;
		dis_e=0;
		dis_f=0;
		dis_g=0;
	}
	else if (digg==8)
	{
		dis_a=1;
		dis_b=1;
		dis_c=1;
		dis_d=1;
		dis_e=1;
		dis_f=1;
		dis_g=1;
	}
	else if (digg==9)
	{
		dis_a=1;
		dis_b=1;
		dis_c=1;
		dis_d=1;
		dis_e=0;
		dis_f=1;
		dis_g=1;
	}
}
void LcdBusy()
{
	P0 = 0xFF;
	BS   = 1;		//Make D7th bit of LCD as i/p
	EN   = 1;       //Make port pin as o/p
	RS   = 0;       //Selected command register
	RW   = 1;		//We are reading
	while(BS)
	{				//read busy flag again and again till it becomes 0 Enable H->L
		EN   = 0;
		EN   = 1;
	}
}
void LcdWriteCmd(unsigned char var)
{
	P0 = 0x00;
	P0 = var;		//Commands to be Written
	RS   = 0;       //Selected command register
	RW   = 0;       //We are writing in instruction register
	EN   = 1;       //Enable H->L
	EN   = 0;
	LcdBusy();		//Wait for LCD to process the command
}
void LcdWriteChar(unsigned char var)
{
	P0 = 0x00;
	P0 = var;		//Data/Character to be Written
	RS   = 1;       //Selected data register
	RW   = 0;       //We are writing
	EN   = 1;       //Enable H->L
	EN   = 0;
	LcdBusy();      //Wait for LCD to process the command
}
void LcdInit()
{
	LcdWriteCmd(0x38);	//Function Set 0x38
	LcdWriteCmd(0x38);	//Function Set
	LcdWriteCmd(0x38);	//Function Set
	LcdWriteCmd(0x06);	//Entry Mode Set 0x06
	LcdWriteCmd(0x0C);	//Display On  Off Control 0x0C
}
void LcdWriteStr(char *var)
{
	while(*var)       //till string ends send characters one by one
	LcdWriteChar(*var++);
}
void LcdGotoXY(unsigned char row, unsigned char col)
{
	switch (row)
	{
		case 1: LcdWriteCmd(0x80 + col - 1); break;
		case 2: LcdWriteCmd(0xc0 + col - 1); break;
		case 3: LcdWriteCmd(0x94 + col - 1); break;
		case 4: LcdWriteCmd(0xd4 + col - 1); break;
		default: break;
	}
}
void LcdClear()
{
	LcdWriteCmd(0x01);
	DelayOnems();
	DelayOnems();
}
 
