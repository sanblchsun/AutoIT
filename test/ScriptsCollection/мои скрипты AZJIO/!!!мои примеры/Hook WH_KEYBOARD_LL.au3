#include <WinAPI.au3>
#include <WindowsConstants.au3>

Global $vkCode[256]
_vkCodeToArray() ; делаем массив, в котором индекс массива равен константе клавиши

Global $hHook, $hStub_KeyProc, $buffer = '', $buffer_up = '', $iEditLog, $Gui

Global Const $LLKHF_UP2			= 0x81 ; $LLKHF_DOWN (почему DOWN, если срабатывает при UP)
; Global Const $MOD_CONTROL			= 0x2


_Main()

Func _Main()
	OnAutoItExitRegister("Cleanup") ; удаление хука при завершении скрипта

	Local $hmod

	$hStub_KeyProc = DllCallbackRegister("_KeyProc", "long", "int;wparam;lparam")
	$hmod = _WinAPI_GetModuleHandle(0) ; дескриптор файла, который создал процесс
	$hHook = _WinAPI_SetWindowsHookEx($WH_KEYBOARD_LL, DllCallbackGetPtr($hStub_KeyProc), $hmod)

	; Esc - для закрытия скрипта

	$Gui=GUICreate('Пример перехвата с помощю хука', 700, 260, -1 , -1, $WS_OVERLAPPEDWINDOW)
	$iEdit = GUICtrlCreateEdit('', 5, 5, 290, 250)
	$iEditLog = GUICtrlCreateEdit('', 300, 5, 390, 250)
	GUISetState()

	Do
	Until GUIGetMsg()=-3
EndFunc
;===========================================================
; функия обратного вызова (callback)
;===========================================================
Func _KeyProc($nCode, $wParam, $lParam)
	Local $tKEYHOOKS
	$tKEYHOOKS = DllStructCreate($tagKBDLLHOOKSTRUCT, $lParam)
	If $nCode < 0 Then
		MsgBox(0, 'Сообщение', $nCode)
		Return _WinAPI_CallNextHookEx($hHook, $nCode, $wParam, $lParam) ; переход к следующей цепочки хуков в очереди
	EndIf
	Local $n=DllStructGetData($tKEYHOOKS, "vkCode")
	; WinSetTitle($Gui, '', $n)
	If $wParam = $WM_KEYDOWN Then ; если ввод с клавиатуры
		_key_down($n) ; срабатывает при удерживании
		GUICtrlSetData($iEditLog, "DOWN: scanCode - " & DllStructGetData($tKEYHOOKS, "scanCode") & @TAB & "vkCode - " & $vkCode[$n]& ' ('&$n&')' & @CRLF, 1)
	Else
		Local $flags = DllStructGetData($tKEYHOOKS, "flags")
		Switch $flags
			Case $LLKHF_ALTDOWN
				GUICtrlSetData($iEditLog, "$LLKHF_ALTDOWN" & @CRLF, 1) ; Нажатие и удерживание Alt
			Case $LLKHF_EXTENDED ; расширенные клавиши
				GUICtrlSetData($iEditLog, "$LLKHF_EXTENDED" & @CRLF, 1)
			Case $LLKHF_INJECTED ; наверно программное нажатие клавиши (не с клавиатуры)
				GUICtrlSetData($iEditLog, "$LLKHF_INJECTED" & @CRLF, 1)
			Case $LLKHF_UP ; отжатие клавиши
				GUICtrlSetData($iEditLog, "$LLKHF_UP: scanCode - " & DllStructGetData($tKEYHOOKS, "scanCode") & @TAB & "vkCode - " & $vkCode[$n]& ' ('&$n&')' & @CRLF, 1)
				_Key_UP($n) ; срабатывает при отпуске. То есть удерживание не работает
			Case $LLKHF_UP2 ; отжатие клавиши, дублирующие справа и специальные
				GUICtrlSetData($iEditLog, "$LLKHF_UP2: scanCode - " & DllStructGetData($tKEYHOOKS, "scanCode") & @TAB & "vkCode - " & $vkCode[$n]& ' ('&$n&')' & @CRLF, 1)
			Case $MOD_CONTROL
				GUICtrlSetData($iEditLog, "$MOD_CONTROL: scanCode - " & DllStructGetData($tKEYHOOKS, "scanCode") & @TAB & "vkCode - " & $vkCode[$n]& ' ('&$n&')' & @CRLF, 1)
		EndSwitch
	EndIf
	Return _WinAPI_CallNextHookEx($hHook, $nCode, $wParam, $lParam) ; переход к следующей цепочки хуков в очереди
EndFunc

Func _Key_UP($keycode)
	If $keycode = 162 Then ; Ctrl
		$buffer_up &= $keycode&','
		AdlibRegister('_Reset_buffer_up', 700) ; сброс буфера, чтобы при интервале более 0.7 сек между нажатиями хук уже не срабатывал
		Switch $buffer_up
			Case "162,162,"
				ToolTip("Двойной левый Ctrl") ; срабатывает по отжатию
				AdlibRegister('_ToolTipClose', 2000)
				$buffer_up='' ; сброс буфера чтобы возможность повторного вызова сразу
		EndSwitch
	Else
		$buffer_up = ''
	EndIf
EndFunc

Func _Reset_buffer_up()
	AdlibUnRegister('_Reset_buffer_up')
	$buffer_up = ''
EndFunc

Func _Reset_buffer()
	AdlibUnRegister('_Reset_buffer')
	$buffer = ''
EndFunc

Func _key_down($keycode)
	Switch $keycode
		Case 160 To 163 ; Ctrl, Shift - сброс буфера 0.7 сек при нажатии модификаторов Ctrl, Shift (левый и правый)
			AdlibRegister('_Reset_buffer', 700)
	EndSwitch
	; If (($keycode > 64) And ($keycode < 91)) _ ; a - z
			; Or (($keycode > 96) And ($keycode < 123)) _ ; A - Z
			; Or (($keycode > 47) And ($keycode < 58)) Then ; 0 - 9
		; $buffer &= Chr($keycode)
		; Switch $buffer
			; Case "Jon"
				; ToolTip("Что вы ещё скажете?")
			; Case "AutoIt"
				; ToolTip("AutoIt это круто")
		; EndSwitch
	If ($keycode = 162) Or ($keycode = 81) Then ; Ctrl + Q
		$buffer &= $keycode&','
		; If StringLen($buffer)>7 Then ; вариант сброса буфера при переполнении
			; $buffer = ""
			; Return
		; EndIf
		Switch $buffer
			Case "162,81,"
				ToolTip("Это типа хоткей Ctrl + Q")
				AdlibRegister('_ToolTipClose', 2000)
				$buffer='' ; сброс буфера чтобы возможность повторного вызова сразу
			Case "162,"
				Return
			Case Else ; сброс буфера при
				$buffer=''
		EndSwitch
	; ElseIf ($keycode > 159) And ($keycode < 164) Then
		; Return
	; ElseIf ($keycode = 27) Then ; esc key
		; Exit
	Else
		$buffer = ""
	EndIf
	WinSetTitle($Gui, '', '$buffer = '&$buffer)
EndFunc

Func _ToolTipClose()
	AdlibUnRegister('_ToolTipClose')
	ToolTip("")
EndFunc

Func Cleanup()
	_WinAPI_UnhookWindowsHookEx($hHook)
	DllCallbackFree($hStub_KeyProc)
EndFunc

; таблица только для показа в логе срабатывания клавиш
Func _vkCodeToArray()
Local $vkCodeTmp[197][2]=[ _
['VK_LBUTTON', 1], _
['VK_RBUTTON', 2], _
['VK_CANCEL', 3], _
['VK_MBUTTON', 4], _
['VK_XBUTTON1', 5], _
['VK_XBUTTON2', 6], _
['VK_BACK', 8], _
['VK_TAB', 9], _
['VK_CLEAR', 12], _
['VK_RETURN', 13], _
['VK_PAUSE', 19], _
['VK_CAPITAL', 20], _
['VK_KANA', 21], _
['VK_JUNJA', 23], _
['VK_FINAL', 24], _
['VK_KANJI', 25], _
['VK_ESCAPE', 27], _
['VK_CONVERT', 28], _
['VK_NONCONVERT', 29], _
['VK_ACCEPT', 30], _
['VK_MODECHANGE', 31], _
['VK_SPACE', 32], _
['VK_PRIOR', 33], _
['VK_NEXT', 34], _
['VK_END', 35], _
['VK_HOME', 36], _
['VK_LEFT', 37], _
['VK_UP', 38], _
['VK_UP', 38], _
['VK_RIGHT', 39], _
['VK_DOWN', 40], _
['VK_SELECT', 41], _
['VK_PRINT', 42], _
['VK_EXECUTE', 43], _
['VK_SNAPSHOT', 44], _
['VK_INSERT', 45], _
['VK_DELETE', 46], _
['VK_HELP', 47], _
['VK_KEY_0', 48], _
['VK_KEY_1', 49], _
['VK_KEY_2', 50], _
['VK_KEY_3', 51], _
['VK_KEY_4', 52], _
['VK_KEY_5', 53], _
['VK_KEY_6', 54], _
['VK_KEY_7', 55], _
['VK_KEY_8', 56], _
['VK_KEY_9', 57], _
['VK_KEY_A', 65], _
['VK_KEY_B', 66], _
['VK_KEY_C', 67], _
['VK_KEY_D', 68], _
['VK_KEY_E', 69], _
['VK_KEY_F', 70], _
['VK_KEY_G', 71], _
['VK_KEY_H', 72], _
['VK_KEY_I', 73], _
['VK_KEY_J', 74], _
['VK_KEY_K', 75], _
['VK_KEY_L', 76], _
['VK_KEY_M', 77], _
['VK_KEY_N', 78], _
['VK_KEY_O', 79], _
['VK_KEY_P', 80], _
['VK_KEY_Q', 81], _
['VK_KEY_R', 82], _
['VK_KEY_S', 83], _
['VK_KEY_T', 84], _
['VK_KEY_U', 85], _
['VK_KEY_V', 86], _
['VK_KEY_W', 87], _
['VK_KEY_X', 88], _
['VK_KEY_Y', 89], _
['VK_KEY_Z', 90], _
['VK_LWIN', 91], _
['VK_RWIN', 92], _
['VK_APPS', 93], _
['VK_SLEEP', 95], _
['VK_NUMPAD0', 96], _
['VK_NUMPAD1', 97], _
['VK_NUMPAD2', 98], _
['VK_NUMPAD3', 99], _
['VK_NUMPAD4', 100], _
['VK_NUMPAD5', 101], _
['VK_NUMPAD6', 102], _
['VK_NUMPAD7', 103], _
['VK_NUMPAD8', 104], _
['VK_NUMPAD9', 105], _
['VK_MULTIPLY', 106], _
['VK_ADD', 107], _
['VK_SEPARATOR', 108], _
['VK_SUBTRACT', 109], _
['VK_DECIMAL', 110], _
['VK_DIVIDE', 111], _
['VK_F1', 112], _
['VK_F2', 113], _
['VK_F3', 114], _
['VK_F4', 115], _
['VK_F5', 116], _
['VK_F6', 117], _
['VK_F7', 118], _
['VK_F8', 119], _
['VK_F9', 120], _
['VK_F10', 121], _
['VK_F11', 122], _
['VK_F12', 123], _
['VK_F13', 124], _
['VK_F14', 125], _
['VK_F15', 126], _
['VK_F16', 127], _
['VK_F17', 128], _
['VK_F18', 129], _
['VK_F19', 130], _
['VK_F20', 131], _
['VK_F21', 132], _
['VK_F22', 133], _
['VK_F23', 134], _
['VK_F24', 135], _
['VK_NUMLOCK', 144], _
['VK_SCROLL', 145], _
['VK_OEM_FJ_JISHO', 146], _
['VK_OEM_FJ_MASSHOU', 147], _
['VK_OEM_FJ_TOUROKU', 148], _
['VK_OEM_FJ_LOYA', 149], _
['VK_OEM_FJ_ROYA', 150], _
['VK_LSHIFT', 160], _
['VK_RSHIFT', 161], _
['VK_LCONTROL', 162], _
['VK_RCONTROL', 163], _
['VK_LMENU', 164], _
['VK_RMENU', 165], _
['VK_BROWSER_BACK', 166], _
['VK_BROWSER_FORWARD', 167], _
['VK_BROWSER_REFRESH', 168], _
['VK_BROWSER_STOP', 169], _
['VK_BROWSER_SEARCH', 170], _
['VK_BROWSER_FAVORITES', 171], _
['VK_BROWSER_HOME', 172], _
['VK_VOLUME_MUTE', 173], _
['VK_VOLUME_DOWN', 174], _
['VK_VOLUME_UP', 175], _
['VK_MEDIA_NEXT_TRACK', 176], _
['VK_MEDIA_PREV_TRACK', 177], _
['VK_MEDIA_STOP', 178], _
['VK_MEDIA_PLAY_PAUSE', 179], _
['VK_LAUNCH_MAIL', 180], _
['VK_LAUNCH_MEDIA_SELECT', 181], _
['VK_LAUNCH_APP1', 182], _
['VK_LAUNCH_APP2', 183], _
['VK_OEM_1', 186], _
['VK_OEM_PLUS', 187], _
['VK_OEM_COMMA', 188], _
['VK_OEM_MINUS', 189], _
['VK_OEM_PERIOD', 190], _
['VK_OEM_2', 191], _
['VK_OEM_3', 192], _
['VK_ABNT_C1', 193], _
['VK_ABNT_C2', 194], _
['VK_OEM_4', 219], _
['VK_OEM_5', 220], _
['VK_OEM_6', 221], _
['VK_OEM_7', 222], _
['VK_OEM_8', 223], _
['VK_OEM_AX', 225], _
['VK_OEM_102', 226], _
['VK_ICO_HELP', 227], _
['VK_ICO_00', 228], _
['VK_PROCESSKEY', 229], _
['VK_ICO_CLEAR', 230], _
['VK_PACKET', 231], _
['VK_OEM_RESET', 233], _
['VK_OEM_JUMP', 234], _
['VK_OEM_PA1', 235], _
['VK_OEM_PA2', 236], _
['VK_OEM_PA3', 237], _
['VK_OEM_WSCTRL', 238], _
['VK_OEM_CUSEL', 239], _
['VK_OEM_ATTN', 240], _
['VK_OEM_FINISH', 241], _
['VK_OEM_COPY', 242], _
['VK_OEM_AUTO', 243], _
['VK_OEM_ENLW', 244], _
['VK_OEM_BACKTAB', 245], _
['VK_ATTN', 246], _
['VK_CRSEL', 247], _
['VK_EXSEL', 248], _
['VK_EREOF', 249], _
['VK_PLAY', 250], _
['VK_ZOOM', 251], _
['VK_NONAME', 252], _
['VK_PA1', 253], _
['VK_OEM_CLEAR', 254], _
['VK__none_', 255]]

For $i = 0 To 196
	$vkCode[ $vkCodeTmp[$i][1] ] = $vkCodeTmp[$i][0]
Next
EndFunc