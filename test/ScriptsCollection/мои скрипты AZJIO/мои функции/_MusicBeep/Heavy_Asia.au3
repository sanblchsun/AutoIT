;  Converting @AZJIO
;  Heavy Asia

#include <_MusicBeep.au3>
HotKeySet("{ESC}", "_Quit")
Func _Quit()
    Exit
EndFunc

; ================== 1
$Note1= _
'5,5,130, 0|'& _
'7,5,130, 0|'& _
'11,5,130, 0|'& _
'7,5,130, 0|'& _
'11,5,130, 0|'& _
'12,5,130, 0|'& _
'11,5,450,70|'& _
'7,5,130,130|'& _
'7,5,130, 0|'& _
'5,5,250,130|'& _
'7,5,260, 0|'& _
'5,5,65,65|'& _
'7,5,260, 0|'& _
'5,5,65,65|'& _
'7,5,86,130|'& _
'7,5,65,65|'& _
'8,5,65,65|'& _
'8,5,130,130|'& _
'8,5,170,350|'

$Note1&= _
'5,5,130, 0|'& _
'7,5,130, 0|'& _
'11,5,130, 0|'& _
'7,5,130, 0|'& _
'11,5,130, 0|'& _
'12,5,130, 0|'& _
'11,5,390, 0|'& _
'12,5,86, 0|'& _
'11,5,43, 0|'& _
'7,5,130,130|'& _
'7,5,130, 0|'& _
'5,5,250,130|'& _
'7,5,260, 0|'& _
'5,5,65,65|'& _
'7,5,260, 0|'& _
'5,5,65,65|'& _
'5,5,170,86|'& _
'7,5,65,65|'& _
'8,5,65,65|'& _
'8,5,130,130|'& _
'8,5,170,350'
$Note1=_StrToArr4(StringStripWS($Note1, 8))


; ================== 2
$Note2= _
'7,3,130,130|'& _
'7,3,170,86|'& _
'5,3,86,43|'& _
'7,3,217,43|'& _
'5,3,86,43|'& _
'7,3,170,86|'& _
'7,3,216,434|'

$Note2&= _
'5,3,86,43|'& _
'7,3,130,130|'& _
'7,3,170,86|'& _
'5,3,86,43|'& _
'7,3,217,43|'& _
'5,3,86,43|'& _
'7,3,170,86|'& _
'7,3,217,43|'

$Note2&= _
'8,3,43,86|'& _
'8,3,43,86|'& _
'8,3,43,86|'& _
'8,3,43,86|'

$Note2&= _
'7,3,130,130|'& _
'7,3,170,86|'& _
'5,3,86,43|'& _
'7,3,217,43|'& _
'5,3,86,43|'& _
'7,3,170,86|'& _
'7,3,216,434|'

$Note2&= _
'5,3,86,43|'& _
'7,3,130,130|'& _
'7,3,170,86|'& _
'5,3,86,43|'& _
'7,3,217,43|'& _
'5,3,86,43|'& _
'7,3,170,86|'& _
'7,3,217,43|'

$Note2&= _
'8,3,520, 0'
$Note2=_StrToArr4(StringStripWS($Note2, 8))

; ================== 3
$Note3= _
'12,3,390, 0|'& _
'7,4,390, 0|'& _
'6,4,520, 0|'& _
'5,4,450, 0|'& _
'3,4,330, 0|'

$Note3&= _
'12,3,390, 0|'& _
'7,4,390, 0|'& _
'6,4,520, 0|'& _
'5,4,450, 0|'& _
'3,4,330, 0|'

$Note3&= _
'5,3,390, 0|'& _
'12,3,390, 0|'& _
'11,3,520, 0|'& _
'10,3,450, 0|'& _
'8,3,330, 0|'

$Note3&= _
'5,3,390, 0|'& _
'12,3,390, 0|'& _
'11,3,520, 0|'& _
'10,3,450, 0|'& _
'8,3,330, 0'
$Note3=_StrToArr4(StringStripWS($Note3, 8))

_MusicBeep($Note1, 1, 1, -3)
_MusicBeep($Note2, 1, 1, -3)
_MusicBeep($Note3, 1, 1, -3)