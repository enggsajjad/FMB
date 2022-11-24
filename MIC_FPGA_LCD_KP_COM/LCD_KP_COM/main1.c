/** *********************************************************************************************
Programmer:		SAJJAD HUSSAIN S.E.
Date:				30-07-2009
Description:	see the ReadMe.txt
***********************************************************************************************/
#include <at89c51rc2.h>
#include "lcd.h"
unsigned char Key;
void main(void)
{          
	int i;
	TMOD = 0x11;
	for(i=0;i<1000;i++)
		DelayOnems();
	P1 = 0xF0;
	LcdInit();
	LcdClear();
	LcdWriteStr("MIC_FPGA_LCD_KP");
	EX0 = 1;
	IT0 = 1;
	EA = 1;
	while(1);

}//main

void keypad() interrupt 0
{
	Key = P1&0xF0;
	Key = Key>>4;
	LcdClear();
	Putc(Key+48);
}
 



























