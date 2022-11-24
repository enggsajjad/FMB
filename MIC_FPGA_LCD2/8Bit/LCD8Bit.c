#include<reg51.h>
#define LCD 		P0
#define Putc 		WriteData
sbit BKLT	=	P1^0;
sbit RS		=	P1^1;
sbit RW 		=	P1^2;
sbit ELCD	= 	P1^3;

void Delay2ms(void)
{
	/*TH1 = 0xF8;TL1 = 0xCD;	//1ms	*/
	TH1 = 0xF1;TL1 = 0x9A;	//2ms
	TR1  = 1;
	while(!TF1);
	TR1  = 0;
	TF1  = 0;
}
void Delay40us(void)
{
	TH1 = 0xFF;TL1 = 0xB7;	//40us
	TR1  = 1;
	while(!TF1);
	TR1  = 0;
	TF1  = 0;
}
void WriteControl(unsigned char d)
{
LCD = d;
RS = 0;
ELCD = 1;
ELCD = 0;
Delay40us(); //Approximates the Delay of 40us
}

void WriteData (unsigned char d)
{
LCD = d;
RS = 1;
ELCD = 1;
ELCD = 0;
Delay40us(); //Approximates the Delay of 40us
}
/*
void WriteControl(unsigned char d)
{
	RS   = 0;// RS   = 0;
	RW   = 0;// RW   = 0;
	ELCD = 0;// ELCD = 0;
	LCD  = d;// LCD  = d;
	ELCD = 1;// ELCD = 1;
	ELCD = 0;// ELCD = 0;
	RW   = 1;// RW   = 1;

	for(Delay=0; Delay<500; Delay++);//200
}

void WriteData (unsigned char d)
{
	RS   = 1;// RS   = 1;
	ELCD = 0;// ELCD = 0;
	RW   = 0;// RW   = 0;
	LCD  = d;// LCD  = d;
	ELCD = 1;// ELCD = 1;
	ELCD = 0;// ELCD = 0;
	RW   = 1;// RW   = 1;

	for(Delay=0; Delay<200; Delay++); //60
}
*/
/*
void WriteControl(unsigned char d)
{
	RS   = 0;
	RW   = 0;
	ELCD = 0;
	_nop_();//Added Sajjad
	LCD  = d;
	ELCD = 1;
	_nop_();//Added Sajjad
	for(Delay=0; Delay<500; Delay++);//Added Sajjad
	ELCD = 0;
	RW   = 1;

	//for(Delay=0; Delay<500; Delay++);//200
}

void WriteData (unsigned char d)
{
	RS   = 1;
	ELCD = 0;
	_nop_();//Added Sajjad
	RW   = 0;
	LCD  = d;
	ELCD = 1;
	_nop_();//Added Sajjad
	for(Delay=0; Delay<500; Delay++);//Added Sajjad
	ELCD = 0;
	RW   = 1;

	//for(Delay=0; Delay<200; Delay++); //60
}
*/
void InitDisp()
{
	RW = 0;	//Always Writing to LCD
	WriteControl(0x38); //(8-bit interface, 2 lines, 5*7 Pixels)
	Delay2ms();	//Approximates the Delay of 4.1ms
	Delay2ms();
	WriteControl(0x38);
	Delay40us(); //Approximates the Delay of 100us
	Delay40us();
	WriteControl(0x38);
	WriteControl(0x06); //(Increment AC, Display Shift Off)
	WriteControl(0x0C); //Make cursor invisible
}

void LCDClear (void)
{
	WriteControl(0x01);
	Delay2ms();	//Approximates the Delay of 1.64ms
}

void LCDCursor (char r, char c)
{
	switch (r)
	{
		case 1: WriteControl(0x80 + c - 1); break;
		case 2: WriteControl(0xc0 + c - 1); break;
		case 3: WriteControl(0x94 + c - 1); break;
		case 4: WriteControl(0xd4 + c - 1); break;
		default: break;
	}
}
void PutStr (char *s)
{
	
	while (*s)
	{
		WriteData(*s);
		s++;
	}
}
void main(void)
{
 int k;
 for(k=0;k<50000;k++);
 P0 = 0x00;
 P1 = 0x00;
 TMOD = 0x11;
 for(k=0;k<250;k++)
 	Delay2ms();
 //TMOD = 0x11;
 InitDisp();
 LCDClear();
 PutStr("Sajjad Hussain");
 LCDCursor(2,1);
 PutStr("ICCC");
 while(1);
}


















