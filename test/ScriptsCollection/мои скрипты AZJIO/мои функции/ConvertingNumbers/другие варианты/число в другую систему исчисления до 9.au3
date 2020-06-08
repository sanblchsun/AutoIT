$re=''
For $i = 2 To 9
	$re &= _DecToN('18118', $i)&@LF
Next
$re=StringTrimRight($re, 1)
MsgBox(0, 'Сообщение', $re)

$aNum=StringSplit($re, @LF)
$re=''
For $i = 1 To $aNum[0]
	$re &= _NToDec($aNum[$i])&@LF
Next
MsgBox(0, 'Сообщение', $re)

Func _DecToN($decnum, $base)
	Local $Out, $ost
	Do
		$ost=Mod($decnum, $base)
		$decnum=($decnum-$ost)/$base
		$Out=$ost&$Out
	Until $decnum=0
	Return $base&'n'&$Out
EndFunc

Func _NToDec($nnum)
	Local $aNum, $i, $n, $Out
	$aNum=StringSplit($nnum, 'n')
	If @error Or Not IsArray($aNum) Or $aNum[0]<>2 Then Return SetError(1)
	$n=StringSplit($aNum[2], '')
	For $i = 1 To $n[0]
		$Out += $n[$i]*$aNum[1]^($n[0]-$i)
	Next
	Return $Out
EndFunc