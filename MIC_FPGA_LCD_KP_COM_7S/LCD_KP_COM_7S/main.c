/** *********************************************************************************************
Programmer:		SAJJAD HUSSAIN S.E.
Date:				30-07-2009
Description:	see the ReadMe.txt
***********************************************************************************************/
#include <at89c51rc2.h>
#include "lcd.h"
unsigned char Key,RecChar;
bit rxFlag;
void main(void)
{          
	int i;
	SCON   = 0x50;
	TCON 	 = 0x05;
	TMOD   = 0x21;
	TL1 = -1;
	TH1 = -1;
	TR1 = 1;
	for(i=0;i<1000;i++)
		DelayOnems();
	P1 = 0xF0;
	P2 = 0x00;
	LcdInit();
	LcdClear();
	LcdWriteStr("MIC_FPGA_LCD_KP");
	ES = 1;
	EX0 = 1;
	IT0 = 1;
	EA = 1;
	SendChar('S');
	SendChar('a');
	SendChar('j');
	SendChar('j');
	SendChar('a');
	SendChar('d');
	
	while(1)
	{
	 if(rxFlag)
	 {
	 	rxFlag = 0;
	 	Putc(RecChar);
	 }
	 display_digit(i%10);
	 i++;
	 DelaySec(1);
	}

}//main

void keypad() interrupt 0
{
	Key = P1&0xF0;
	Key = Key>>4;
	LcdClear();
	Putc(Key+48);
}
void Serial() interrupt 4
{
	if (RI)
	{
		RI = 0;
		RecChar = SBUF;
		rxFlag = 1;
	}//end RI
}
 

































