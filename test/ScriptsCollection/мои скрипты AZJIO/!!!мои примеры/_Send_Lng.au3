
Global $lng=@OSLang

MsgBox(0, '—ообщение', 'ќткрываем меню проводника использу€ имитацию Alt+a'&@CRLF&'¬место "f" используем "'&_Send_Lng('f')&'"'&@CRLF&'¬место "V" используем "'&_Send_Lng('V')&'"'&@CRLF&'¬место "a" используем "'&_Send_Lng('a')&'"')
$win_handle = WinGetHandle('') ; получаем хэндл активного окна
$CurLang =HEX(_WinAPI_GetKeyboardLayout($win_handle)) ; запоминаем текущую раскладку окна
_SetKeyboardLayout('0000'&$lng, $win_handle) ; устанавливаем в активном окне раскладку по умолчанию
Send('!{'&_Send_Lng('a')&'}') ; имитаци€ вызова гор€чей клавиши Alt+a в проводнике, откуда стартует скрипт.
_SetKeyboardLayout($CurLang, $win_handle) ; возвращаем €зык по умолчанию


Func _Send_Lng($s)
	If $lng = '0409' Then Return $s
	Local $n, $out
	Local $EnDef = "`qwertyuiop[]asdfghjkl;'zxcvbnm,./~QWERTYUIOP{}ASDFGHJKL:""|ZXCVBNM<>?@#$^&"
	
	; подмена символа взависимости от €зыка. јналогичную вставку можно сделать и дл€ других €зыков
	; количество символов в переменной $RuDef может быть убавлено по количеству вызываемых клавиш в скрипте
	Local $RuDef = "Єйцукенгшщзхъфывапролджэ€чсмитьбю.®…÷” ≈Ќ√Ўў«’Џ‘џ¬јѕ–ќЋƒ∆Ё/я„—ћ»“№Ѕё,""є;:?"
	If $lng = '0419' Then
		$n=StringInStr($EnDef,$s,1)
		$out = StringMid($RuDef, $n, 1)
		Return $out
	EndIf
	
	Return $s
EndFunc

; переключение раскладки клавиатуры
Func _SetKeyboardLayout($sLayoutID, $hWnd)
    Local $ret = DllCall("user32.dll", "long", "LoadKeyboardLayout", "str", $sLayoutID, "int", 0)
    DllCall("user32.dll", "int", "SendMessage", "hwnd", $hWnd, "int", 0x50, "int", 1, "int", $ret[0])
EndFunc

; Func _WinAPI_GetKeyboardLayout($hWnd)

	; Local $ret

	; $ret = DllCall('user32.dll', 'long', 'GetWindowThreadProcessId', 'hwnd', $hWnd, 'ptr', 0)
	; If (@error) Or (Not $ret[0]) Then
		; Return SetError(1, 0, 0)
	; EndIf
	; $ret = DllCall('user32.dll', 'long', 'GetKeyboardLayout', 'long', $ret[0])
	; If (@error) Or (Not $ret[0]) Then
		; Return SetError(1, 0, 0)
	; EndIf
	; Return BitAND($ret[0], 0xFFFF)
; EndFunc   ;==>_WinAPI_GetKeyboardLayout