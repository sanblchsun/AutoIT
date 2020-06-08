; Z.Abreu_Tico-Tico

Global $nTempo=0.8
Global $iTone=0
HotKeySet("{ESC}", "_Quit")


_Beep(8,4,100)
_Beep(7,4,100)
_Beep(8,4,100)
_Beep(9,4,100)
_Beep(8,4,100,100)
_Beep(1,5,100,100)

_Beep(8,4,100)
_Beep(7,4,100)
_Beep(8,4,100)
_Beep(9,4,100)
_Beep(8,4,100,100)
_Beep(12,4,100,100)

_Beep(8,4,100)
_Beep(7,4,100)
_Beep(8,4,100)
_Beep(9,4,100)
_Beep(8,4,100)

_Beep(6,5,100)
_Beep(3,5,100)
_Beep(12,4,100)
_Beep(8,4,100)
_Beep(6,4,100)
_Beep(5,4,100)
_Beep(4,4,200,300)

; @AZJIO
Func _Beep($iNote,$iOctave=4,$iDuration=200,$iPause=0)
	$iFrequency=440*2^(($iNote+$iTone)/12+$iOctave+1/6-4)
	Beep($iFrequency, $iDuration/$nTempo)
	If $iPause<>0 Then Sleep($iPause/$nTempo)
EndFunc

Func _Quit()
    Exit
EndFunc