;  Converting @AZJIO
; Europe


#include <_MusicBeep.au3>
HotKeySet('{ESC}', "_Quit")
Func _Quit()
    Exit
EndFunc

$Note1= _
'12,5,50,0|'& _
'3,6,50,0|'& _
'12,5,50,0|'& _
'3,6,50,0|'& _
'7,6,100,0|'& _
'12,5,50,0|'& _
'3,6,50,0|'& _
'12,5,50,0|'& _
'3,6,50,0|'& _
'7,6,100,0|'& _
'12,5,50,0|'& _
'3,6,50,0|'& _
'12,5,50,0|'& _
'3,6,50,0|'& _
'7,6,100,0|'& _
'12,5,50,0|'& _
'3,6,50,0|'& _
'12,5,50,0|'& _
'3,6,50,0|'& _
'7,6,100,0|'

$Note1&= _
'12,5,50,0|'& _
'3,6,50,0|'& _
'12,5,50,0|'& _
'3,6,50,0|'& _
'7,6,200,0|'

$Note1&= _
'2,6,50,0|'& _
'5,6,50,0|'& _
'2,6,50,0|'& _
'5,6,50,0|'& _
'8,6,100,0|'& _
'2,6,50,0|'& _
'5,6,50,0|'& _
'2,6,50,0|'& _
'5,6,50,0|'& _
'8,6,100,0|'& _
'2,6,50,0|'& _
'5,6,50,0|'& _
'2,6,50,0|'& _
'5,6,50,0|'& _
'8,6,100,0|'& _
'2,6,50,0|'& _
'5,6,50,0|'& _
'2,6,50,0|'& _
'5,6,50,0|'& _
'8,6,100,0|'

$Note1&= _
'2,6,50,0|'& _
'5,6,50,0|'& _
'2,6,50,0|'& _
'5,6,50,0|'& _
'8,6,200,0|'

$Note1&= _
'3,6,50,0|'& _
'7,6,50,0|'& _
'3,6,50,0|'& _
'7,6,50,0|'& _
'10,6,100,0|'& _
'3,6,50,0|'& _
'7,6,50,0|'& _
'3,6,50,0|'& _
'7,6,50,0|'& _
'10,6,100,0|'& _
'3,6,50,0|'& _
'7,6,50,0|'& _
'3,6,50,0|'& _
'7,6,50,0|'& _
'10,6,100,0|'& _
'3,6,50,0|'& _
'7,6,50,0|'& _
'3,6,50,0|'& _
'7,6,50,0|'& _
'10,6,100,0|'

$Note1&= _
'3,6,50,0|'& _
'7,6,50,0|'& _
'3,6,50,0|'& _
'7,6,50,0|'

$Note1&= _
'10,6,200,0|'& _
'8,5,100,0|'& _
'10,5,100,0|'& _
'12,5,100,0|'& _
'8,5,100,0|'& _
'10,5,100,0|'& _
'12,5,100,0|'& _
'8,5,100,0|'& _
'10,5,100,0|'& _
'12,5,100,0|'& _
'10,5,100,0|'& _
'8,5,100,0|'& _
'7,5,100,0|'& _
'10,5,100,0|'& _
'8,5,100,0|'& _
'7,5,100,0|'& _
'3,5,100,0|'& _
'5,5,600,0|'& _
'8,5,90,10|'& _
'8,5,90,10|'& _
'8,5,190,10'
$Note1=_StrToArr4(StringStripWS($Note1, 8))


$Note2= _
'7,5,50,0|'& _
'8,5,50,0|'& _ ;====
'7,5,100,0|'& _
'5,5,200,0|'& _
'3,5,190,10|'& _
'3,5,390,10|'& _
'2,5,390,10|'& _
'12,4,390,10|'

$Note2&= _
'10,4,390,10|'& _
'12,5,390,10|'& _
'10,5,100,0|'& _
'7,5,100,0|'& _
'10,5,100,0|'& _
'7,5,200,0|'& _
'12,5,100,0|'& _
'10,5,100,0|'& _
'7,5,100,0|'& _
'9,5,100,0|'& _
'5,5,100,0|'& _
'7,5,190,10|'& _
'7,5,100,0|'& _
'5,5,100,0|'& _
'3,5,100,0|'& _
'12,4,100,0|'& _
'5,5,100,0|'& _
'12,4,100,0|'& _
'3,5,100,0|'& _
'5,5,890,10'
$Note2=_StrToArr4(StringStripWS($Note2, 8))

$Note3= _
'7,5,100,0|'& _
'8,5,50,0|'& _ ;====
'7,5,50,0|'& _
'5,5,200,0|'& _
'3,5,200,0|'& _
'12,5,390,10|'& _ ;====
'10,5,390,10|'& _
'3,5,390,10|'& _
'5,5,390,10|'& _
'7,5,1590,10|'& _
'9,5,600,0|'& _
'12,5,200,0|'& _
'9,5,800,0'
$Note3=_StrToArr4(StringStripWS($Note3, 8))

_MusicBeep($Note1, 1, 0.7, -12)
_MusicBeep($Note2, 1, 0.7, -12)
_MusicBeep($Note1, 1, 0.7, -12)
_MusicBeep($Note3, 1, 0.7, -12)