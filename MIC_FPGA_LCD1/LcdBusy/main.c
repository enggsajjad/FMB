/** *********************************************************************************************
Programmer:		SAJJAD HUSSAIN S.E.
Date:				30-07-2009
Description:	see the ReadMe.txt
***********************************************************************************************/
#include <at89c51rc2.h>
#include "lcd.h"
unsigned char some=0;
void main(void)
{          
	int i;
	TMOD = 0x11;
	for(i=0;i<2000;i++)
		DelayOnems();
	P1 = 0xF0;
	LcdInit();
	LcdClear();
	LcdWriteStr("FPGA Prototype");
	LcdGotoXY(2,1);LcdWriteStr("Driving LCD ");
	while(1);

}//main
 


















