; MsgBox(0, 'Message', _DecToN('2n18118'))
; MsgBox(0, 'Сообщение', Hex(Int('255'),2))


$re=''
For $i = 2 To 16
	$re &= _DecToN('255', $i)&@LF
Next
$re=StringTrimRight($re, 1)
MsgBox(0, 'Сообщение', $re)

$aNum=StringSplit($re, @LF)
; #include <Array.au3>
; _ArrayDisplay($aNum, 'Array')
$re=''
For $i = 1 To $aNum[0]
	$re &= $aNum[$i] & ' - ' & _NToDec($aNum[$i])&@LF
Next
MsgBox(0, 'Сообщение', $re)

Func _DecToN($decnum, $base)
	Local $Out, $ost, $n[16]=['0','1','2','3','4','5','6','7','8','9','A','B','C','D','E','F']
	Do
		$ost=Mod($decnum, $base)
		$decnum=($decnum-$ost)/$base
		$Out=$n[$ost]&$Out
	Until $decnum=0
	Return $base&'n'&$Out
EndFunc

Func _NToDec($nnum)
	Local $aNum, $i, $n, $Out
	$aNum=StringSplit($nnum, 'n')
	If @error Or Not IsArray($aNum) Or $aNum[0]<>2 Then Return SetError(1)
	If StringRegExp($aNum[2], '(?i)[A-F]') Then
		$aNum[2]=StringRegExpReplace($aNum[2], '.', '\0,')
		$aNum[2]=StringTrimRight($aNum[2], 1)
		$aNum[2]=StringReplace($aNum[2], 'A', '10')
		$aNum[2]=StringReplace($aNum[2], 'B', '11')
		$aNum[2]=StringReplace($aNum[2], 'C', '12')
		$aNum[2]=StringReplace($aNum[2], 'D', '13')
		$aNum[2]=StringReplace($aNum[2], 'E', '14')
		$aNum[2]=StringReplace($aNum[2], 'F', '15')
		$n=StringSplit($aNum[2], ',')
	Else
		$n=StringSplit($aNum[2], '')
	EndIf
	For $i = 1 To $n[0]
		$Out += $n[$i]*$aNum[1]^($n[0]-$i)
	Next
	Return $Out
EndFunc