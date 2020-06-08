#include <WinAPI.au3>
#include <WindowsConstants.au3>

Global $hHook, $hStub_KeyProc, $iEditLog, $Gui

; в AutoIt3 v3.3.6.1 и ниже эти константы не определены
; Global Const $WM_MBUTTONDBLCLK = 0x0209
; Global Const $WM_RBUTTONDBLCLK = 0x0206
; Global Const $WM_MOUSEHWHEEL = 0x020E ???

_Main()

Func _Main()
	OnAutoItExitRegister("Cleanup")

	Local $hmod

	$hStub_KeyProc = DllCallbackRegister("_KeyProc", "long", "int;wparam;lparam")
	$hmod = _WinAPI_GetModuleHandle(0)
	$hHook = _WinAPI_SetWindowsHookEx($WH_MOUSE_LL, DllCallbackGetPtr($hStub_KeyProc), $hmod)

	; Esc - для закрытия скрипта

	$Gui=GUICreate('Пример перехвата с помощю хука', 700, 260, -1 , -1, $WS_OVERLAPPEDWINDOW)
	$iEdit = GUICtrlCreateEdit('', 5, 5, 290, 250)
	$iEditLog = GUICtrlCreateEdit('', 300, 5, 390, 250)
	GUISetState()

	Do
	Until GUIGetMsg()=-3
EndFunc
;===========================================================
; callback function
;===========================================================
Func _KeyProc($nCode, $wParam, $lParam)
	Local $tKEYHOOKS, $X, $Y, $tmp, $Delta
	If $nCode < 0 Then Return _WinAPI_CallNextHookEx($hHook, $nCode, $wParam, $lParam) ; переход к следующей цепочки хуков в очереди (не срабатывает)
	$tKEYHOOKS = DllStructCreate($tagKBDLLHOOKSTRUCT, $lParam)
	; координаты мыши X, Y
	$X = DllStructGetData($tKEYHOOKS, "vkCode")
	$Y = DllStructGetData($tKEYHOOKS, "scanCode")

Switch $wParam
	Case $WM_MOUSEWHEEL ; если колесо мыши крутится
        $Delta = BitShift(DllStructGetData($tKEYHOOKS, "flags"), 16) ; определяет вниз или вврх
		
        If $Delta > 0 Then
			$tmp= 'колесо мыши сдвинулось ВВЕРХ ^'
        Else
			$tmp= 'колесо мыши сдвинулось ВНИЗ v'
        EndIf
		$tmp &= ' ('&$Delta&')'
		
	Case $WM_LBUTTONDOWN
		$tmp= 'Нажатие Левой кнопкой мыши'
		
	Case $WM_LBUTTONUP
		$tmp= 'Отжатие Левой кнопкой мыши'
		
	Case $WM_MBUTTONDOWN
		$tmp= 'Нажатие Средней кнопкой мыши'
		
	Case $WM_MBUTTONUP
		$tmp= 'Отжатие Средней кнопкой мыши'
		
	Case $WM_RBUTTONDOWN
		$tmp= 'Нажатие Правой кнопкой мыши'
		
	Case $WM_RBUTTONUP
		$tmp= 'Отжатие Правой кнопкой мыши'
		
	Case $WM_XBUTTONDOWN
		$tmp= 'Нажатие Дополнительной кнопкой мыши'
		
	Case $WM_XBUTTONUP
		$tmp= 'Отжатие Дополнительной кнопкой мыши'
		
#cs
; это блок не работает
		
	Case $WM_LBUTTONDBLCLK ; не работает
		$tmp= 'Двойной клик Левой кнопкой мыши'
		
	Case $WM_MBUTTONDBLCLK ; не работает
		$tmp= 'Двойной клик Средней кнопкой мыши'
		
	Case $WM_RBUTTONDBLCLK ; не работает
		$tmp= 'Двойной клик Правой кнопкой мыши'
		
	Case $WM_XBUTTONDBLCLK ; не работает
		$tmp= 'Двойной клик дополнительной кнопкой мыши'
		
	Case $WM_NCLBUTTONDBLCLK
		$tmp= 'Двойной клик Левой на заголовке'
		
	Case $WM_NCLBUTTONDOWN
		$tmp= 'Нажатие Левой на заголовке'
		
	Case $WM_NCLBUTTONUP
		$tmp= 'Отжатие Левой на заголовке'
		
	Case $WM_NCMBUTTONDBLCLK
		$tmp= 'Двойной клик Средней на заголовке'
		
	Case $WM_NCMBUTTONDOWN
		$tmp= 'Нажатие Средней на заголовке'
		
	Case $WM_NCMBUTTONUP
		$tmp= 'Отжатие Средней на заголовке'
		
	Case $WM_NCRBUTTONDBLCLK
		$tmp= 'Двойной клик Правой на заголовке'
		
	Case $WM_NCRBUTTONDOWN
		$tmp= 'Нажатие Правой на заголовке'
		
	Case $WM_NCRBUTTONUP
		$tmp= 'Отжатие Правой на заголовке'
		
	Case $WM_NCMOUSEMOVE
		$tmp= 'Перемещение мыши в НЕ клиентской области'
#ce
		
	; Case $WM_MOUSEMOVE ; слишком много лога пишет
		; $tmp= 'Перемещение мыши в клиентской области'
	Case Else
		$tmp = ""
		WinSetTitle($Gui, '', "X: "&$X&", Y: "&$Y)
		Return _WinAPI_CallNextHookEx($hHook, $nCode, $wParam, $lParam) ; переход к следующей цепочки хуков в очереди
EndSwitch
GUICtrlSetData($iEditLog, $tmp& @CRLF, 1)
	; Return _WinAPI_CallNextHookEx($hHook, $nCode, $wParam, $lParam) ; переход к следующей цепочки хуков в очереди
EndFunc

Func Cleanup()
	_WinAPI_UnhookWindowsHookEx($hHook)
	DllCallbackFree($hStub_KeyProc)
EndFunc