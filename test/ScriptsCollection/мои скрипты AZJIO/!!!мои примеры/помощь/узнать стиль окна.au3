Global $stl[24][2] = [[ _
		23, 23],[ _
		'0x00800000', 'WS_BORDER'],[ _
		'0x80000000', 'WS_POPUP'],[ _
		'0x00C00000', 'WS_CAPTION'],[ _
		'0x02000000', 'WS_CLIPCHILDREN'],[ _
		'0x04000000', 'WS_CLIPSIBLINGS'],[ _
		'0x08000000', 'WS_DISABLED'],[ _
		'0x00400000', 'WS_DLGFRAME'],[ _
		'0x00100000', 'WS_HSCROLL'],[ _
		'0x01000000', 'WS_MAXIMIZE'],[ _
		'0x00010000', 'WS_MAXIMIZEBOX, WS_TABSTOP'],[ _
		'0x20000000', 'WS_MINIMIZE'],[ _
		'0x00020000', 'WS_MINIMIZEBOX, WS_GROUP'],[ _
		'0x00000000', 'WS_OVERLAPPED'],[ _
		'0x00CF0000', 'WS_OVERLAPPEDWINDOW'],[ _
		'0x80880000', 'WS_POPUPWINDOW'],[ _
		'0x00080000', 'WS_SYSMENU'],[ _
		'0x00040000', 'WS_SIZEBOX, WS_THICKFRAME'],[ _
		'0x00200000', 'WS_VSCROLL'],[ _
		'0x10000000', 'WS_VISIBLE'],[ _
		'0x40000000', 'WS_CHILD'],[ _
		'0x00000080', 'DS_MODALFRAME'],[ _
		'0x00000200', 'DS_SETFOREGROUND'],[ _
		'0x00002000', 'DS_CONTEXTHELP']]

Global $estl[16][2] = [[ _
		15, 15],[ _
		'0x00000010', 'WS_EX_ACCEPTFILES'],[ _
		'0x00040000', 'WS_EX_APPWINDOW'],[ _
		'0x02000000', 'WS_EX_COMPOSITED'],[ _
		'0x00000200', 'WS_EX_CLIENTEDGE'],[ _
		'0x00000400', 'WS_EX_CONTEXTHELP'],[ _
		'0x00000001', 'WS_EX_DLGMODALFRAME'],[ _
		'0x00000040', 'WS_EX_MDICHILD'],[ _
		'0x00000300', 'WS_EX_OVERLAPPEDWINDOW'],[ _
		'0x00020000', 'WS_EX_STATICEDGE'],[ _
		'0x00000008', 'WS_EX_TOPMOST'],[ _
		'0x00000020', 'WS_EX_TRANSPARENT'],[ _
		'0x00000080', 'WS_EX_TOOLWINDOW'],[ _
		'0x00000100', 'WS_EX_WINDOWEDGE'],[ _
		'0x00080000', 'WS_EX_LAYERED'],[ _
		'0x00100000', 'GUI_WS_EX_PARENTDRAG']]

Run('Notepad')
$Title = '[CLASS:Notepad]'
If WinWaitActive($Title, '', 5) Then ; ждём появления блокнота 5 сек
	; $Title='[ACTIVE]' ; активируйте нужное окно в течении 2-х секунд
	; Sleep(2000)
	$hwnd = WinGetHandle($Title)
	If @error Then Exit
	$aStyle = DllCall("user32.dll", "long", "GetWindowLong", "hwnd", $hwnd, "int", -16)
	$aExStyle = DllCall("user32.dll", "long", "GetWindowLong", "hwnd", $hwnd, "int", -20)
	$aStyle = _Assot(_ArrGetVal($aStyle[0]), $stl)
	$aExStyle = _Assot(_ArrGetVal($aExStyle[0]), $estl)

	MsgBox(0, "", "Style" & @CRLF & $aStyle & @CRLF & @CRLF & "ExStyle" & @CRLF & $aExStyle)
Else
	MsgBox(0, 'Сообщение', 'Окно не найдено, завершаем работу скрипта')
EndIf

Func _ArrGetVal($Value)
	Local $sOut, $n = 0.5
	For $i = 0 To Int(Log($Value) / Log(2))
		$n *= 2
		If BitAND($Value, $n) Then $sOut &= '0x' & Hex(Int($n), 8) & @LF
		; If BitAnd($Value, $n) Then $sOut&='0x'&StringFormat("%08x", $n) &@LF
		; If BitAnd($Value, $n) Then $sOut&=StringFormat("%#x", $n) &@LF
	Next
	Return StringTrimRight($sOut, 1)
EndFunc

Func _Assot($val, $aStl)
	If $val = '' Then Return ''
	Local $tmp, $out
	$val = StringSplit($val, @LF)
	For $i = 1 To $val[0]
		$tmp = ''
		For $j = 1 To $aStl[0][0]
			If Number($val[$i]) = Number($aStl[$j][0]) Then
				$tmp = $val[$i] & ' - ' & $aStl[$j][1] & @CRLF
				ExitLoop
			EndIf
		Next
		If Not $tmp Then $tmp = $val[$i] & ' - не найдено' & @CRLF
		$out &= $tmp
	Next
	Return StringTrimRight($out, 2)
EndFunc