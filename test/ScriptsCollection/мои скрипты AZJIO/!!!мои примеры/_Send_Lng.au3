
Global $lng=@OSLang

MsgBox(0, '���������', '��������� ���� ���������� ��������� �������� Alt+a'&@CRLF&'������ "f" ���������� "'&_Send_Lng('f')&'"'&@CRLF&'������ "V" ���������� "'&_Send_Lng('V')&'"'&@CRLF&'������ "a" ���������� "'&_Send_Lng('a')&'"')
$win_handle = WinGetHandle('') ; �������� ����� ��������� ����
$CurLang =HEX(_WinAPI_GetKeyboardLayout($win_handle)) ; ���������� ������� ��������� ����
_SetKeyboardLayout('0000'&$lng, $win_handle) ; ������������� � �������� ���� ��������� �� ���������
Send('!{'&_Send_Lng('a')&'}') ; �������� ������ ������� ������� Alt+a � ����������, ������ �������� ������.
_SetKeyboardLayout($CurLang, $win_handle) ; ���������� ���� �� ���������


Func _Send_Lng($s)
	If $lng = '0409' Then Return $s
	Local $n, $out
	Local $EnDef = "`qwertyuiop[]asdfghjkl;'zxcvbnm,./~QWERTYUIOP{}ASDFGHJKL:""|ZXCVBNM<>?@#$^&"
	
	; ������� ������� ������������ �� �����. ����������� ������� ����� ������� � ��� ������ ������
	; ���������� �������� � ���������� $RuDef ����� ���� �������� �� ���������� ���������� ������ � �������
	Local $RuDef = "���������������������������������.������������������������/���������,""�;:?"
	If $lng = '0419' Then
		$n=StringInStr($EnDef,$s,1)
		$out = StringMid($RuDef, $n, 1)
		Return $out
	EndIf
	
	Return $s
EndFunc

; ������������ ��������� ����������
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