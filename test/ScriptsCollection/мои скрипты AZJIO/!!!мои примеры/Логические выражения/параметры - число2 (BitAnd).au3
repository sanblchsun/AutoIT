
$1=2047
; $1=1023

$aA=_ArrGetVal($1)
$T=''
For $i = 1 to $aA[0]
	$T&=$aA[$i]&@CRLF
Next
MsgBox(0, 'Сообщение', $T)


Func _ArrGetVal($Value)
	Local $k=0, $aV[15], $aN=StringSplit('1|2|4|8|16|32|64|128|256|512|1024|2048|4096|8192', '|')
	For $i = $aN[0] to 1 Step -1
		If BitAnd($Value,$aN[$i]) Then
			$k+=1
			$aV[$k]=$aN[$i]
		EndIf
	Next
	ReDim $aV[$k+1]
	$aV[0]=$k
    return $aV
EndFunc

; Func _ArrGetVal($Value)
	; Local $k=0, $aV[15], $aN=StringSplit('1|2|4|8|16|32|64|128|256|512|1024|2048|4096|8192', '|')
	; For $i = $aN[0] to 1 Step -1
		; If $Value >= $aN[$i] Then
			; $Value=Mod($Value,$aN[$i])
			; $k+=1
			; $aV[$k]=$aN[$i]
		; EndIf
		; If $Value = 0 Then ExitLoop
	; Next
	; ReDim $aV[$k+1]
	; $aV[0]=$k
    ; return $aV
; EndFunc

; If $Value > 0 Then
	; ReDim $aA[$k+2]
	; $aA[0]=$k+1
	; $aA[$aA[0]+1]='Error'
; Else
	; ReDim $aA[$k+1]
	; $aA[0]=$k
; EndIf