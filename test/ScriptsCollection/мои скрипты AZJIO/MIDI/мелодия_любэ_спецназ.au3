;  @AZJIO
_Beep(3,5,250)
_Beep(5,5,250)
_Beep(6,5,250)
_Beep(5,5,250)
_Beep(3,5,400,100)
_Beep(1,5,250)
_Beep(11,4,250)
_Beep(10,4,500,1250)
_Beep(3,5,250)
_Beep(5,5,250)
_Beep(6,5,250)
_Beep(5,5,250)
_Beep(3,5,400,100)
_Beep(6,5,250)
_Beep(8,5,250)
_Beep(10,5,500,1000)
_Beep(3,5,250)
_Beep(3,5,250)
_Beep(11,5,400,100)
_Beep(10,5,400,100)
_Beep(8,5,650,100)
_Beep(10,5,400,100)
_Beep(8,5,250)
_Beep(6,5,250)
_Beep(5,5,250)
_Beep(6,5,400,100)
_Beep(3,5,250)
_Beep(5,5,250)
_Beep(6,5,250)
_Beep(6,5,250)
_Beep(6,5,250)
_Beep(8,5,250)
_Beep(10,5,400,100)
_Beep(5,5,250)
_Beep(6,5,250)
_Beep(3,5,500)


Func _Beep($nota,$oktava=4,$Duration=200,$pause=0)
	$Frequency=440*2^($nota/12+$oktava+1/6-4)
	Beep($Frequency, $Duration)
	If $pause<>0 Then Sleep($pause)
EndFunc














