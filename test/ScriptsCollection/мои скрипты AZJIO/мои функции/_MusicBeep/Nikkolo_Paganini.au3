;  Converting @AZJIO
; Nikkolo Paganini

#include <_MusicBeep.au3>
HotKeySet("{ESC}", "_Quit")
Func _Quit()
    Exit
EndFunc

;=========================1
$Note1= _
'10,4,200,100|'& _ ;====
'10,4,100, 0|'& _
'10,4,100, 0|'& _
'1,5,100, 0|'& _
'12,4,100, 0|'& _
'10,4,100, 0|'& _
'5,5,300, 0|'& _
'5,4,100, 0|'& _
'5,4,100, 0|'& _
'9,4,100, 0|'& _
'7,4,100, 0|'& _
'5,4,100, 0|'& _
'10,4,200,100|'& _
'10,4,100, 0|'& _
'10,4,100, 0|'& _
'1,5,100, 0|'& _
'12,4,100, 0|'& _
'10,4,100, 0|'& _
'5,5,300,100|'& _
'5,4,300,100|'& _
'10,4,200,100|'& _ ;====
'10,4,100, 0|'& _
'10,4,100, 0|'& _
'1,5,100, 0|'& _
'12,4,100, 0|'& _
'10,4,100, 0|'& _
'5,5,300, 0|'& _
'5,4,100, 0|'& _
'5,4,100, 0|'& _
'9,4,100, 0|'& _
'7,4,100, 0|'& _
'5,4,100, 0|'& _
'10,4,200,100|'& _
'10,4,100, 0|'& _
'10,4,100, 0|'& _
'1,5,100, 0|'& _
'12,4,100, 0|'& _
'10,4,100, 0|'& _
'5,5,300,100|'& _
'5,4,300,100|'& _
'10,5,200,100|'& _ ;====
'10,5,100, 0|'& _
'10,5,100, 0|'& _
'11,5,100, 0|'& _
'10,5,100, 0|'& _
'8,5,100, 0|'& _
'6,5,200,100|'& _
'3,5,100, 0|'& _
'3,5,100, 0|'& _
'6,5,100, 0|'& _
'5,5,100, 0|'& _
'3,5,100, 0|'& _
'8,5,200,100|'& _
'8,5,100, 0|'& _
'8,5,100, 0|'& _
'10,5,100, 0|'& _
'8,5,100, 0|'& _
'6,5,100, 0|'& _
'5,5,200,100|'& _
'1,5,100, 0|'& _
'1,5,100, 0|'& _
'5,5,100, 0|'& _
'3,5,100, 0|'& _
'1,5,100, 0|'& _
'6,5,200,100|'& _
'12,4,100, 0|'& _
'12,4,100, 0|'& _
'3,5,100, 0|'& _
'1,5,100, 0|'& _
'12,4,100, 0|'& _
'5,5,200,100|'& _
'10,4,100, 0|'& _
'10,4,100, 0|'& _
'1,5,100, 0|'& _
'12,4,100, 0|'& _
'10,4,100, 0|'& _
'4,4,200, 0|'& _
'4,5,200, 0|'& _
'5,4,100, 0|'& _
'5,5,100, 0|'& _
'3,5,100, 0|'& _
'12,4,100, 0|'& _
'10,4,200,200|'& _
'10,3,200,200'
$Note1=_StrToArr4(StringStripWS($Note1, 8))

;=========================2

$Note2= _
'10,5,200,100|'& _
'10,5,100, 0|'& _
'10,5,100, 0|'& _
'1,6,100, 0|'& _
'12,5,100, 0|'& _
'10,5,100, 0|'& _
'5,6,300, 0|'& _
'5,5,100, 0|'& _
'5,5,100, 0|'& _
'9,5,100, 0|'& _
'7,5,100, 0|'& _
'5,5,100, 0|'& _
'10,5,200,100|'& _
'10,5,100, 0|'& _
'10,5,100, 0|'& _
'1,6,100, 0|'& _
'12,5,100, 0|'& _
'10,5,100, 0|'& _
'5,6,300,100|'& _
'5,5,300,100|'& _
'10,5,200,100|'& _ ;====
'10,5,100, 0|'& _
'10,5,100, 0|'& _
'1,6,100, 0|'& _
'12,5,100, 0|'& _
'10,5,100, 0|'& _
'5,6,300, 0|'& _
'5,5,100, 0|'& _
'5,5,100, 0|'& _
'9,5,100, 0|'& _
'7,5,100, 0|'& _
'5,5,100, 0|'& _
'10,5,200,100|'& _
'10,5,100, 0|'& _
'10,5,100, 0|'& _
'1,6,100, 0|'& _
'12,5,100, 0|'& _
'10,5,100, 0|'& _
'5,6,300,100|'& _
'5,5,300,100|'& _
'10,6,200,100|'& _ ;====
'10,6,100, 0|'& _
'10,6,100, 0|'& _
'11,6,100, 0|'& _
'10,6,100, 0|'& _
'8,6,100, 0|'& _
'6,6,200,100|'& _
'3,6,100, 0|'& _
'3,6,100, 0|'& _
'6,6,100, 0|'& _
'5,6,100, 0|'& _
'3,6,100, 0|'& _
'8,6,200,100|'& _
'8,6,100, 0|'& _
'8,6,100, 0|'& _
'10,6,100, 0|'& _
'8,6,100, 0|'& _
'6,6,100, 0|'& _
'5,6,200,100|'& _
'1,6,100, 0|'& _
'1,6,100, 0|'& _
'5,6,100, 0|'& _
'3,6,100, 0|'& _
'1,6,100, 0|'& _
'6,6,200,100|'& _
'12,5,100, 0|'& _
'12,5,100, 0|'& _
'3,6,100, 0|'& _
'1,6,100, 0|'& _
'12,5,100, 0|'& _
'5,6,200,100|'& _
'10,5,100, 0|'& _
'10,5,100, 0|'& _
'1,6,100, 0|'& _
'12,5,100, 0|'& _
'10,5,100, 0|'& _
'4,5,200, 0|'& _
'4,6,200, 0|'& _
'5,5,100, 0|'& _
'5,6,100, 0|'& _
'3,6,100, 0|'& _
'12,5,100, 0|'& _
'10,5,200,528'
$Note2=_StrToArr4(StringStripWS($Note2, 8))
;'10,4,200,200|'& _


;=========================3


$Note3= _
'5,5,36, 0|'& _
'1,6,36, 0|'& _
'5,6,133, 0|'& _
'1,6,133, 0|'& _
'10,5,133, 0|'& _
'5,5,133, 0|'& _
'1,5,133, 0|'& _
'10,4,60, 0|'& _
'5,5,36, 0|'& _
'9,5,36, 0|'& _
'12,5,133, 0|'& _
'9,5,133, 0|'& _
'5,5,133, 0|'& _
'12,4,133, 0|'& _
'9,4,133, 0|'& _
'5,4,60, 0|'& _
'5,5,36, 0|'& _
'9,5,36, 0|'& _
'5,6,133, 0|'& _
'1,6,133, 0|'& _
'10,5,133, 0|'& _
'5,5,133, 0|'& _
'1,5,133, 0|'& _
'10,4,133, 0|'& _
'5,6,266,134|'& _
'5,5,250,60|'& _
'5,5,36, 0|'& _ ;====
'1,6,36, 0|'& _
'5,6,133, 0|'& _
'1,6,133, 0|'& _
'10,5,133, 0|'& _
'5,5,133, 0|'& _
'1,5,133, 0|'& _
'10,4,60, 0|'& _
'5,5,36, 0|'& _
'9,5,36, 0|'& _
'12,5,133, 0|'& _
'9,5,133, 0|'& _
'5,5,133, 0|'& _
'12,4,133, 0|'& _
'9,4,133, 0|'& _
'5,4,60, 0|'& _
'5,5,36, 0|'& _
'9,5,36, 0|'& _
'5,6,133, 0|'& _
'1,6,133, 0|'& _
'10,5,133, 0|'& _
'5,5,133, 0|'& _
'1,5,133, 0|'& _
'10,4,133, 0|'& _
'5,6,266,134|'& _
'5,5,250,60|'& _
'2,6,36, 0|'& _ ;====
'5,6,36, 0|'& _
'10,6,100, 0|'& _
'5,6,100, 0|'& _
'2,6,100, 0|'& _
'10,5,100, 0|'& _
'5,5,100, 0|'& _
'2,5,100, 0|'& _
'10,4,100, 0|'& _
'3,4,100, 0|'& _
'6,4,100, 0|'& _
'10,4,100, 0|'& _
'3,5,100, 0|'& _
'6,5,100, 0|'& _
'10,5,133, 0|'& _
'3,6,133, 0|'& _
'6,6,133, 0|'& _
'8,6,100, 0|'& _
'6,6,100, 0|'& _
'3,6,100, 0|'& _
'12,5,100, 0|'& _
'8,5,100, 0|'& _
'6,5,100, 0|'& _
'3,5,100, 0|'& _
'1,4,100, 0|'& _
'5,4,100, 0|'& _
'8,4,100, 0|'& _
'1,5,100, 0|'& _
'5,5,100, 0|'& _
'8,5,133, 0|'& _
'1,6,133, 0|'& _
'5,6,133, 0|'& _
'6,6,100, 0|'& _
'3,6,100, 0|'& _
'12,5,100, 0|'& _
'9,5,100, 0|'& _
'6,5,133, 0|'& _
'3,5,133, 0|'& _
'12,4,133, 0|'& _
'5,6,100, 0|'& _
'1,6,100, 0|'& _
'10,5,100, 0|'& _
'5,5,100, 0|'& _
'1,5,133, 0|'& _
'10,4,133, 0|'& _
'5,4,133, 0|'& _
'6,4,100, 0|'& _
'10,4,100, 0|'& _
'3,5,100, 0|'& _
'6,5,100, 0|'& _
'5,4,100, 0|'& _
'5,5,100, 0|'& _
'3,5,100, 0|'& _
'9,4,100, 0|'& _
'10,4,300,500'
$Note3=_StrToArr4(StringStripWS($Note3, 8))

;=========================4


$Note4= _
'10,5,100, 0|'& _
'9,5,100, 0|'& _
'10,5,50, 0|'& _
'9,5,50, 0|'& _
'11,5,100, 0|'& _
'10,5,100, 0|'& _
'12,5,100, 0|'& _
'1,6,100, 0|'& _
'3,6,100, 0|'& _
'5,6,100, 0|'& _
'4,6,100, 0|'& _
'5,6,50, 0|'& _
'4,6,50, 0|'& _
'6,6,100, 0|'& _
'5,6,100, 0|'& _
'3,6,100, 0|'& _
'1,6,100, 0|'& _
'12,5,100, 0|'& _
'10,5,100, 0|'& _
'9,5,100, 0|'& _
'10,5,50, 0|'& _
'9,5,50, 0|'& _
'11,5,100, 0|'& _
'10,5,100, 0|'& _
'12,5,100, 0|'& _
'1,6,100, 0|'& _
'3,6,100, 0|'& _
'5,6,100, 0|'& _
'4,6,100, 0|'& _
'5,6,50, 0|'& _
'4,6,50, 0|'& _
'6,6,100, 0|'& _
'5,6,200, 0|'& _
'5,5,200, 0|'& _
'10,5,100, 0|'& _ ;====
'9,5,100, 0|'& _
'10,5,50, 0|'& _
'9,5,50, 0|'& _
'11,5,100, 0|'& _
'10,5,100, 0|'& _
'12,5,100, 0|'& _
'1,6,100, 0|'& _
'3,6,100, 0|'& _
'5,6,100, 0|'& _
'4,6,100, 0|'& _
'5,6,50, 0|'& _
'4,6,50, 0|'& _
'6,6,100, 0|'& _
'5,6,100, 0|'& _
'3,6,100, 0|'& _
'1,6,100, 0|'& _
'12,5,100, 0|'& _
'10,5,100, 0|'& _
'9,5,100, 0|'& _
'10,5,50, 0|'& _
'9,5,50, 0|'& _
'11,5,100, 0|'& _
'10,5,100, 0|'& _
'12,5,100, 0|'& _
'1,6,100, 0|'& _
'3,6,100, 0|'& _
'5,6,100, 0|'& _
'4,6,100, 0|'& _
'5,6,50, 0|'& _
'4,6,50, 0|'& _
'6,6,100, 0|'& _
'5,6,200,200|'& _;'5,5,200,200|'& _
'10,6,100, 0|'& _ ;====
'9,6,100, 0|'& _
'10,6,50, 0|'& _
'9,6,50, 0|'& _
'11,6,100, 0|'& _
'10,6,100, 0|'& _
'8,6,100, 0|'& _
'6,6,100, 0|'& _
'5,6,100, 0|'& _
'3,6,100, 0|'& _
'2,6,100, 0|'& _
'3,6,50, 0|'& _
'2,6,50, 0|'& _
'4,6,100, 0|'& _
'3,6,100, 0|'& _
'5,6,100, 0|'& _
'6,6,100, 0|'& _
'3,6,100, 0|'& _
'8,6,100, 0|'& _
'7,6,100, 0|'& _
'8,6,50, 0|'& _
'7,6,50, 0|'& _
'9,6,100, 0|'& _
'8,6,100, 0|'& _
'6,6,100, 0|'& _
'5,6,100, 0|'& _
'3,6,100, 0|'& _
'1,6,100, 0|'& _
'12,5,100, 0|'& _
'1,6,50, 0|'& _
'12,5,50, 0|'& _
'3,6,100, 0|'& _
'1,6,100, 0|'& _
'3,6,100, 0|'& _
'5,6,100, 0|'& _
'1,6,100, 0|'& _
'6,6,100, 0|'& _
'5,6,100, 0|'& _
'6,6,50, 0|'& _
'5,6,50, 0|'& _
'8,6,100, 0|'& _
'6,6,100, 0|'& _
'3,6,100, 0|'& _
'1,6,100, 0|'& _
'12,5,100, 0|'& _
'5,6,100, 0|'& _
'4,6,100, 0|'& _
'5,6,50, 0|'& _
'4,6,50, 0|'& _
'6,6,100, 0|'& _
'5,6,100, 0|'& _
'1,6,100, 0|'& _
'12,5,100, 0|'& _
'10,5,100, 0|'& _
'12,5,100, 0|'& _
'11,5,100, 0|'& _
'12,5,50, 0|'& _
'11,5,50, 0|'& _
'1,6,100, 0|'& _
'12,5,100, 0|'& _
'6,6,100, 0|'& _
'5,6,100, 0|'& _
'9,5,100, 0|'& _
'10,5,100, 0|'& _
'9,5,100, 0|'& _
'10,5,50, 0|'& _
'9,5,50, 0|'& _
'12,5,100, 0|'& _
'10,5,300,300'
$Note4=_StrToArr4(StringStripWS($Note4, 8))

;=========================5


$Note5= _
'6,5,50,150|'& _ ;====
'5,5,200, 0|'& _
'5,4,200,200|'& _
'4,6,50,150|'& _
'5,6,200, 0|'& _
'5,5,200,200|'& _
'6,5,50,150|'& _ ;====
'5,5,200, 0|'& _
'5,4,200,200|'& _
'4,6,50,150|'& _
'5,6,200, 0|'& _
'5,5,200,200|'& _
'6,5,50,150|'& _ ;====
'5,5,200, 0|'& _
'5,4,200,200|'& _
'4,6,50,150|'& _
'5,6,200, 0|'& _
'5,5,200,200|'& _
'6,5,50,150|'& _ ;====
'5,5,200, 0|'& _
'5,4,200,200|'& _
'4,6,50,150|'& _
'5,6,200, 0|'& _
'5,5,200,200|'& _
'11,5,50,150|'& _ ;====
'10,5,200, 0|'& _
'10,4,200,200|'& _
'5,6,50,150|'& _
'6,6,200, 0|'& _
'6,5,200,200|'& _
'9,5,50,150|'& _
'8,5,200, 0|'& _
'8,4,200,200|'& _
'4,6,50,150|'& _
'5,6,200, 0|'& _
'1,5,200,200|'& _
'1,6,50,150|'& _
'12,5,200, 0|'& _
'12,4,200,200|'& _
'9,5,50,150|'& _
'10,5,200, 0|'& _
'10,4,200,200|'& _
'6,6,50,150|'& _
'3,6,200, 0|'& _
'3,5,200,200|'& _
'5,6,100,100|'& _
'10,5,100,300'
$Note5=_StrToArr4(StringStripWS($Note5, 8))

;=========================6


$Note6= _
'1,6,600, 0|'& _ ;====
'12,5,100, 0|'& _
'10,5,100, 0|'& _
'9,5,100, 0|'& _
'6,5,100, 0|'& _
'5,5,100, 0|'& _
'3,5,100, 0|'& _
'1,5,100, 0|'& _
'12,4,100, 0|'& _
'10,4,100, 0|'& _
'9,4,100, 0|'& _
'10,4,600, 0|'& _
'12,4,100, 0|'& _
'1,5,100, 0|'& _
'12,4,100, 0|'& _
'10,4,100, 0|'& _
'9,4,100, 0|'& _
'7,4,100, 0|'& _
'5,4,400, 0|'& _
'1,6,600, 0|'& _ ;====
'12,5,100, 0|'& _
'10,5,100, 0|'& _
'9,5,100, 0|'& _
'6,5,100, 0|'& _
'5,5,100, 0|'& _
'3,5,100, 0|'& _
'1,5,100, 0|'& _
'12,4,100, 0|'& _
'10,4,100, 0|'& _
'9,4,100, 0|'& _
'10,4,600, 0|'& _
'12,4,100, 0|'& _
'1,5,100, 0|'& _
'12,4,100, 0|'& _
'10,4,100, 0|'& _
'9,4,100, 0|'& _
'7,4,100, 0|'& _
'5,4,400, 0|'& _
'2,5,600, 0|'& _ ;====
'3,5,100, 0|'& _
'5,5,100, 0|'& _
'6,5,100, 0|'& _
'8,5,100, 0|'& _
'10,5,100, 0|'& _
'12,5,100, 0|'& _
'2,6,100, 0|'& _
'3,6,100, 0|'& _
'5,6,100, 0|'& _
'6,6,100, 0|'& _
'12,4,600, 0|'& _ ;====
'1,5,100, 0|'& _
'3,5,100, 0|'& _
'5,5,100, 0|'& _
'6,5,100, 0|'& _
'8,5,100, 0|'& _
'10,5,100, 0|'& _
'12,5,100, 0|'& _
'1,6,100, 0|'& _
'3,6,100, 0|'& _
'5,6,100, 0|'& _
'6,6,600, 0|'& _ ;====
'5,6,100, 0|'& _
'3,6,100, 0|'& _
'5,6,600, 0|'& _
'3,6,100, 0|'& _
'1,6,100, 0|'& _
'6,6,200, 0|'& _
'5,6,100, 0|'& _
'3,6,100, 0|'& _
'1,6,200, 0|'& _
'12,5,200, 0|'& _
'10,5,600,200'
$Note6=_StrToArr4(StringStripWS($Note6, 8))

;=========================7



$Note7= _
'5,6,36, 0|'& _ ;====
'6,6,36, 0|'& _
'5,6,128, 0|'& _
'1,6,400, 0|'& _
'10,5,36, 0|'& _
'12,5,36, 0|'& _
'10,5,128, 0|'& _
'12,5,36, 0|'& _
'1,6,36, 0|'& _
'12,5,128, 0|'& _
'9,5,36, 0|'& _
'10,5,36, 0|'& _
'9,5,128, 0|'& _
'5,5,36, 0|'& _
'6,5,36, 0|'& _
'5,5,128, 0|'& _
'12,4,200, 0|'& _
'5,6,36, 0|'& _
'6,6,36, 0|'& _
'5,6,128, 0|'& _
'1,6,400, 0|'& _
'6,4,36, 0|'& _
'8,4,36, 0|'& _
'6,4,128, 0|'& _
'5,4,36, 0|'& _
'6,4,36, 0|'& _
'5,4,128, 0|'& _
'9,4,36, 0|'& _
'10,4,36, 0|'& _
'9,4,128, 0|'& _
'12,4,36, 0|'& _
'1,5,36, 0|'& _
'12,4,128, 0|'& _
'9,4,36, 0|'& _
'10,4,36, 0|'& _
'9,4,128, 0|'& _
'5,6,36, 0|'& _ ;====
'6,6,36, 0|'& _
'5,6,128, 0|'& _
'1,6,400, 0|'& _
'10,5,36, 0|'& _
'12,5,36, 0|'& _
'10,5,128, 0|'& _
'12,5,36, 0|'& _
'1,6,36, 0|'& _
'12,5,128, 0|'& _
'9,5,36, 0|'& _
'10,5,36, 0|'& _
'9,5,128, 0|'& _
'5,5,36, 0|'& _
'6,5,36, 0|'& _
'5,5,128, 0|'& _
'12,4,200, 0|'& _
'5,6,36, 0|'& _
'6,6,36, 0|'& _
'5,6,128, 0|'& _
'1,6,400, 0|'& _
'6,4,36, 0|'& _
'8,4,36, 0|'& _
'6,4,128, 0|'& _
'5,4,36, 0|'& _
'6,4,36, 0|'& _
'5,4,128, 0|'& _
'9,4,36, 0|'& _
'10,4,36, 0|'& _
'9,4,128, 0|'& _
'12,4,36, 0|'& _
'1,5,36, 0|'& _
'12,4,128, 0|'& _
'9,4,36, 0|'& _
'10,4,36, 0|'& _
'9,4,128, 0|'& _
'5,6,36, 0|'& _ ;====
'6,6,36, 0|'& _
'5,6,128, 0|'& _
'2,6,400, 0|'& _
'10,5,36, 0|'& _
'12,5,36, 0|'& _
'10,5,128, 0|'& _
'3,6,100,100|'& _
'10,4,100,100|'& _
'6,4,100,100|'& _
'3,4,100,100|'& _
'3,6,36, 0|'& _
'5,6,36, 0|'& _
'3,6,128, 0|'& _
'12,5,400, 0|'& _
'8,5,36, 0|'& _
'10,5,36, 0|'& _
'8,5,128, 0|'& _
'1,6,100,100|'& _
'8,4,100,100|'& _
'5,4,100,100|'& _
'1,4,100,100|'& _
'3,6,36, 0|'& _
'5,6,36, 0|'& _
'3,6,128, 0|'& _
'6,6,100,100|'& _
'12,4,100,100|'& _
'3,5,100,100|'& _
'1,6,36, 0|'& _
'3,6,36, 0|'& _
'1,6,128, 0|'& _
'5,6,100,100|'& _
'10,4,100,100|'& _
'1,5,100,100|'& _
'3,6,36, 0|'& _
'5,6,36, 0|'& _
'3,6,128, 0|'& _
'6,4,100,100|'& _
'12,5,36, 0|'& _
'1,6,36, 0|'& _
'12,5,128, 0|'& _
'5,4,100,100|'& _
'10,4,100,100|'& _
'10,5,36, 0|'& _
'12,5,36, 0|'& _
'10,5,128, 0|'& _
'10,3,100,300'
$Note7=_StrToArr4(StringStripWS($Note7, 8))

;=========================8

$Note8= _
'1,6,100, 0|'& _ ;====
'10,5,100, 0|'& _
'5,5,100, 0|'& _
'1,5,100, 0|'& _
'10,4,100, 0|'& _
'5,5,100, 0|'& _
'1,5,100, 0|'& _
'12,4,100, 0|'& _
'12,5,100, 0|'& _
'9,5,100, 0|'& _
'5,5,100, 0|'& _
'3,6,100, 0|'& _
'12,5,100, 0|'& _
'5,5,100, 0|'& _
'9,5,100, 0|'& _
'5,5,100, 0|'& _
'1,6,100, 0|'& _
'10,5,100, 0|'& _
'5,5,100, 0|'& _
'1,5,100, 0|'& _
'10,4,100, 0|'& _
'5,5,100, 0|'& _
'1,5,100, 0|'& _
'10,4,100, 0|'& _
'12,5,100, 0|'& _
'9,5,100, 0|'& _
'5,5,100, 0|'& _
'5,5,100, 0|'& _
'12,4,100, 0|'& _
'9,4,100, 0|'& _
'5,4,100,100|'& _
'1,6,100, 0|'& _ ;====
'10,5,100, 0|'& _
'5,5,100, 0|'& _
'1,5,100, 0|'& _
'10,4,100, 0|'& _
'5,5,100, 0|'& _
'1,5,100, 0|'& _
'12,4,100, 0|'& _
'12,5,100, 0|'& _
'9,5,100, 0|'& _
'5,5,100, 0|'& _
'3,6,100, 0|'& _
'12,5,100, 0|'& _
'5,5,100, 0|'& _
'9,5,100, 0|'& _
'5,5,100, 0|'& _
'1,6,100, 0|'& _
'10,5,100, 0|'& _
'5,5,100, 0|'& _
'1,5,100, 0|'& _
'10,4,100, 0|'& _
'5,5,100, 0|'& _
'1,5,100, 0|'& _
'10,4,100, 0|'& _
'12,5,100, 0|'& _
'9,5,100, 0|'& _
'5,5,100, 0|'& _
'5,5,100, 0|'& _
'12,4,100, 0|'& _
'9,4,100, 0|'& _
'5,4,100,100|'& _
'5,6,100, 0|'& _ ;====
'2,6,100, 0|'& _
'10,5,100, 0|'& _
'5,5,100, 0|'& _
'2,5,100, 0|'& _
'10,4,100, 0|'& _
'8,4,100, 0|'& _
'5,4,100, 0|'& _
'3,4,100, 0|'& _
'6,4,100, 0|'& _
'3,6,100, 0|'& _
'10,5,100, 0|'& _
'6,5,100, 0|'& _
'3,5,100, 0|'& _
'10,4,100, 0|'& _
'6,4,100, 0|'& _
'3,6,100, 0|'& _
'12,5,100, 0|'& _
'8,5,100, 0|'& _
'3,5,100, 0|'& _
'8,4,100, 0|'& _
'6,4,100, 0|'& _
'5,4,100, 0|'& _
'3,4,100, 0|'& _
'1,4,100, 0|'& _
'5,4,100, 0|'& _
'1,6,100, 0|'& _
'8,5,100, 0|'& _
'5,5,100, 0|'& _
'1,5,100, 0|'& _
'8,4,100, 0|'& _
'5,4,100, 0|'& _
'12,5,100, 0|'& _
'10,5,100, 0|'& _
'9,5,100, 0|'& _
'7,5,100, 0|'& _
'5,5,100, 0|'& _
'3,5,100, 0|'& _
'1,5,100, 0|'& _
'12,4,100, 0|'& _
'10,4,100, 0|'& _
'8,4,100, 0|'& _
'6,4,100, 0|'& _
'5,4,100, 0|'& _
'3,4,100, 0|'& _
'1,4,100, 0|'& _
'12,3,100, 0|'& _
'10,3,100, 0|'& _
'12,3,100, 0|'& _
'3,4,100, 0|'& _
'10,4,100, 0|'& _
'6,4,100, 0|'& _
'12,3,100, 0|'& _
'5,4,100, 0|'& _
'12,4,100, 0|'& _
'9,4,100, 0|'& _
'10,4,100, 0|'& _
'5,4,100, 0|'& _
'1,4,100, 0|'& _
'12,3,100, 0|'& _
'10,3,400, 0'
$Note8=_StrToArr4(StringStripWS($Note8, 8))

;=========================9

$Note9= _
'10,5,600, 0|'& _ ;====
'5,5,100, 0|'& _
'1,6,100, 0|'& _
'12,5,100, 0|'& _
'10,5,100, 0|'& _
'9,5,100, 0|'& _
'7,5,100, 0|'& _
'5,5,100, 0|'& _
'7,5,100, 0|'& _
'9,5,100, 0|'& _
'5,5,100, 0|'& _
'10,5,500, 0|'& _
'12,5,100, 0|'& _
'1,6,100, 0|'& _
'3,6,100, 0|'& _
'4,6,200, 0|'& _
'5,6,200, 0|'& _
'5,5,400, 0|'& _
'10,5,600, 0|'& _ ;====
'5,5,100, 0|'& _
'1,6,100, 0|'& _
'12,5,100, 0|'& _
'10,5,100, 0|'& _
'9,5,100, 0|'& _
'7,5,100, 0|'& _
'5,5,100, 0|'& _
'7,5,100, 0|'& _
'9,5,100, 0|'& _
'5,5,100, 0|'& _
'10,5,500, 0|'& _
'12,5,100, 0|'& _
'1,6,100, 0|'& _
'3,6,100, 0|'& _
'4,6,200, 0|'& _
'5,6,200, 0|'& _
'5,5,400, 0|'& _
'10,5,500, 0|'& _ ;====
'5,6,100, 0|'& _
'2,6,100, 0|'& _
'10,5,100, 0|'& _
'8,5,100, 0|'& _
'5,5,100, 0|'& _
'2,5,100, 0|'& _
'10,4,100, 0|'& _
'8,4,100, 0|'& _
'5,4,100, 0|'& _
'2,4,100, 0|'& _
'10,3,100, 0|'& _
'8,5,500, 0|'& _
'3,6,100, 0|'& _
'12,5,100, 0|'& _
'8,5,100, 0|'& _
'6,6,100, 0|'& _
'3,6,100, 0|'& _
'12,5,100, 0|'& _
'8,5,100, 0|'& _
'6,5,100, 0|'& _
'5,5,100, 0|'& _
'3,5,100, 0|'& _
'1,5,100, 0|'& _
'6,6,500, 0|'& _
'3,6,100, 0|'& _
'12,5,100, 0|'& _
'10,5,100, 0|'& _
'9,5,100, 0|'& _
'5,5,100, 0|'& _
'3,5,100, 0|'& _
'12,4,100, 0|'& _
'10,4,100, 0|'& _
'5,5,100, 0|'& _
'10,5,100, 0|'& _
'8,5,100, 0|'& _
'6,5,100, 0|'& _
'3,6,100, 0|'& _
'12,5,100, 0|'& _
'10,5,100, 0|'& _
'9,5,200, 0|'& _
'5,5,200, 0|'& _
'10,6,800, 0'
$Note9=_StrToArr4(StringStripWS($Note9, 8))


_MusicBeep($Note1, 1, 1, -12)
_MusicBeep($Note2, 1, 1, -12)
_MusicBeep($Note3, 1, 1, -12)
_MusicBeep($Note4, 1, 1, -12)
_MusicBeep($Note5, 1, 1, -12)
_MusicBeep($Note6, 1, 1, -12)
_MusicBeep($Note7, 1, 1, -12)
_MusicBeep($Note8, 1, 1, -12)
_MusicBeep($Note9, 1, 1, -12)