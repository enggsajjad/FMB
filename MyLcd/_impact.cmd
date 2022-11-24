setPreference -pref UserLevel:NOVICE
setPreference -pref MessageLevel:DETAILED
setPreference -pref ConcurrentMode:FALSE
setPreference -pref UseHighz:FALSE
setPreference -pref ConfigOnFailure:STOP
setPreference -pref StartupCLock:AUTO_CORRECTION
setPreference -pref AutoSignature:FALSE
setPreference -pref KeepSVF:FALSE
setPreference -pref svfUseTime:FALSE
setPreference -pref UserLevel:NOVICE
setPreference -pref MessageLevel:DETAILED
setPreference -pref ConcurrentMode:FALSE
setPreference -pref UseHighz:FALSE
setPreference -pref ConfigOnFailure:STOP
setPreference -pref StartupCLock:AUTO_CORRECTION
setPreference -pref AutoSignature:FALSE
setPreference -pref KeepSVF:FALSE
setPreference -pref svfUseTime:FALSE
setMode -bs
setCable -port lpt1
Identify
setAttribute -position 1 -attr devicePartName -value "xcf02s"
setAttribute -position 1 -attr configFileName -value "F:\LCD_Controller\MyLcd\top.mcs"
setAttribute -position 2 -attr configFileName -value "F:\LCD_Controller\MyLcd\lcd.bit"
Program -p 1 -e -v -loadfpga 
in -index 0
addDevice -position 1 -file "F:\LCD_Controller\MyLcd\lcd.bit"
setMode -pff
setAttribute -configdevice -attr fillValue -value "FF"
setAttribute -configdevice -attr fileFormat -value "mcs"
setAttribute -collection -attr dir -value "UP"
setAttribute -configdevice -attr path -value "f:\lcd_controller\mylcd/"
setAttribute -collection -attr name -value "top"
generate -generic
setCurrentDesign -version 0
