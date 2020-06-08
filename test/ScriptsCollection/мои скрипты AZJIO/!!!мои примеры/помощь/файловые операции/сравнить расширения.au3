; http://autoit-script.ru/index.php/topic,7444.msg51109.html#msg51109

$file1 = "C:\wish.txt"
$file2 = "C:\wis4325h.txt"
; !i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i
If _Type1($file1)=_Type1($file2) Then
	MsgBox(0, 'первый вариант', 'Совпадают')
Else
	MsgBox(0, 'первый вариант', 'Не совпадают')
EndIf
Func _Type1($Path)
	Local $SLen, $tmp
	$SLen=StringLen($Path)
	$tmp=StringInStr($Path, '.', 0, -1, $SLen, $SLen-StringInStr($Path, '\', 0, -1))
	If $tmp = 0 Then Return SetError(1, 0, '')
	Return StringTrimLeft($Path, $tmp)
EndFunc
; !i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i
If _Type2($file1)=_Type2($file2) Then
	MsgBox(0, 'второй вариант', 'Совпадают')
Else
	MsgBox(0, 'второй вариант', 'Не совпадают')
EndIf

Func _Type2($Path)
	Local $tmp
	$tmp=StringInStr($Path, '.', 0, -1)
	If $tmp = 0 Then Return SetError(1, 0, '')
	$tmp=StringTrimLeft($Path, $tmp)
	If StringInStr($tmp, '\') Then
		Return SetError(1, 0, '')
	Else
		Return $tmp
	EndIf
EndFunc
; !i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i
If _Type3($file1)=_Type3($file2) Then
	MsgBox(0, 'третий вариант', 'Совпадают')
Else
	MsgBox(0, 'третий вариант', 'Не совпадают')
EndIf

Func _Type3($Path)
	If StringRegExp($Path, '^(?:.*\.)([^\\]+)$') Then
		Return StringRegExpReplace($Path, '^(?:.*\.)([^\\]+)$', '\1')
	Else
		Return SetError(1, 0, '')
	EndIf
EndFunc