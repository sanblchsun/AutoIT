#include <WinAPI.au3> 
 
Global Const $SPI_SETSCREENSAVEACTIVE = 17 
Global Const $SPIF_UPDATEINIFILE = 0x1 
 
;���������� �������� 
_WinAPI_SystemParametersInfo($SPI_SETSCREENSAVEACTIVE, 0, 0, $SPIF_UPDATEINIFILE) 
 
;��� ���������� ������� 
 
;��������� �������� 
_WinAPI_SystemParametersInfo($SPI_SETSCREENSAVEACTIVE, 1, 0, $SPIF_UPDATEINIFILE)