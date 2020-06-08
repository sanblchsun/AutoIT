
; $_String='Ctrl+{'
; MsgBox(0, '—ообщение', _HotKeyString_To_AutoitCode($_String))


MsgBox(0, '—ообщение', _
'^{F1}'&@Tab&' => ' &@Tab&_AutoitCode_To_HotKeyString('^{F1}') &@CRLF& _
'^!{F1}'&@Tab&' => ' &@Tab&_AutoitCode_To_HotKeyString('^!{F1}') &@CRLF& _
'Ctrl + F1'&@Tab&' => ' &@Tab&_HotKeyString_To_AutoitCode('Ctrl + F1') &@CRLF& _
'Alt + Shift + P'&@Tab&' => ' &@Tab&_HotKeyString_To_AutoitCode('Alt + Shift + P'))

Func _HotKeyString_To_AutoitCode($Key)
	Local $ch, $k
	if $Key = '' Then Return SetError(1, 0, '')
	; $Key = '{'&StringReplace(StringStripWS($Key, 8),'+', '}{')&'}'
	$Key='{'&StringRegExpReplace(StringStripWS($Key, 8), '(?<!\+)\+', '}{')&'}' ; удал€ем пробелы, используем "+" как разделитель
	$Key=StringRegExpReplace($Key, '\{([^!+^#{}])\}', '\1') ; если не метасимволы то убираем обрамл€ющие фигурные скобки
	
	; проверка наличие только одной клавиши в сочетании с модификаторами
	$ch = StringRegExpReplace($Key, '(\{Alt\}|\{Shift\}|\{Ctrl\}|\{Win\})','') ; удал€ем модификаторы
	$ch = StringRegExpReplace($ch, '\{.*?\}','') ; подсчитываем элементы обрамлЄнные фигурными скобками
	$k=@extended
	$k+=StringLen($ch) ; добавл€ем количество символов без фигурных скобок
	If $k <> 1 Then Return SetError(1, 0, '') ; возвращает пустую строку при ошибке
	
	; замены модификаторов
	$Key = StringReplace($Key, '{Alt}','!')
	$Key = StringReplace($Key, '{Shift}','+')
	$Key = StringReplace($Key, '{Ctrl}','^')
	$Key = StringReplace($Key, '{Win}','#')
	Return $Key
EndFunc

Func _AutoitCode_To_HotKeyString($Key)
	If StringRight($Key, 1)<>'}' Then
		$Key1=StringRight($Key, 1)
		$Key = StringTrimRight($Key, 1)
		If StringInStr('!+^#', $Key1) Then Return SetError(1, 0, '')
	Else
		$p=StringInStr($Key, '{')
		$Key1=StringMid($Key, $p+1)
		$Key1 = StringTrimRight($Key1, 1)
		$Key = StringLeft($Key, $p-1)
	EndIf
	$aKey = StringSplit($Key, '')
	For $i = 1 to $aKey[0]
		If Not StringInStr('!+^#', $aKey[$i]) Then Return SetError(1, 0, '')
	Next
	; замены модификаторов
	$Key = StringReplace($Key, '+', 'Shift+')
	$Key = StringReplace($Key, '!', 'Alt+')
	$Key = StringReplace($Key, '^', 'Ctrl+')
	$Key = StringReplace($Key, '#', 'Win+')
	Return $Key&$Key1
EndFunc