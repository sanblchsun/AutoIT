$1=0x00000110
; $1=1023

MsgBox(0, 'Сообщение', _ArrGetVal($1))


Func _ArrGetVal($Value)
	Local $s, $sV=''
	For $i = 1 to 64
		$s=2^$i
		If $s>$Value Then
			$s=$i-1
			ExitLoop
		EndIf
	Next
	For $i = $s to 1 Step -1
		$s=2^$i
		If BitAnd($Value, $s) Then $sV&=$s &@CRLF
	Next
    return $sV
EndFunc
