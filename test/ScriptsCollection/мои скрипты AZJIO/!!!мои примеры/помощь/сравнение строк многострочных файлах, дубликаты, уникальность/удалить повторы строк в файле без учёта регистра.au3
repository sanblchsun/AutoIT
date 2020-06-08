Func _CreateFile($Path_In)
	Local $hFile, $i, $s = ''
	For $i = 0 To 1000000
		$s &= Random(1, 1000, 1) & @CRLF
	Next
	$hFile = FileOpen($Path_In, 2)
	FileWrite($hFile, $s)
	FileClose($hFile)
EndFunc

$Path_In = @ScriptDir & '\test_in.txt'
_CreateFile($Path_In)
$Path_Out = @ScriptDir & '\test_Out.txt'
$sText = FileRead($Path_In)
$err = 0

$timer = TimerInit()
$aText_Out = _StringUnique($sText)
If @error Then $err = @error
$timer = Round(TimerDiff($timer) / 1000, 2)

If $err Then
	MsgBox(0, 'error', 'not found' & @CRLF & 'Time = ' & $timer & 'sec')
	Exit
Else
	$hFile = FileOpen($Path_Out, 2)
	FileWrite($hFile, $aText_Out)
	FileClose($hFile)
EndIf

MsgBox(0, "Time", 'Time = ' & $timer & 'sec')

; не учитывает регистр String = StRiNg = STRING
; not case sensitive, String = StRiNg = STRING
Func _StringUnique($sText, $sep = @CRLF)
	Local $i, $k, $aText, $s, $Trg = 0, $LenSep
	If StringInStr($sText, '[') And $sep <> '[' Then
		For $i = 0 To 255
			$s = Chr($i)
			If Not StringInStr($sText, $s) Then
				If StringInStr($sep, $s) Then ContinueLoop
				$sText = StringReplace($sText, '[', $s)
				$Trg = 1
				ExitLoop
			EndIf
		Next
		If Not $Trg Then Return SetError(1, 0, '')
	EndIf

	$LenSep = StringLen($sep)
	$aText = StringSplit($sText, $sep, 1)
	Assign('/', 2, 1)
	$k = 0
	$sText = ''
	For $i = 1 To $aText[0]
		If Not IsDeclared($aText[$i] & '/') Then
			Assign($aText[$i] & '/', 0, 1)
			$sText &= $aText[$i] & $sep
			$k += 1
		EndIf
	Next
	If $k = 0 Then Return SetError(2, 0, '')
	If $Trg Then $sText = StringReplace($sText, $s, '[')
	Return StringTrimRight($sText, $LenSep)
EndFunc