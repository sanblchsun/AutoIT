; —охранение координат и размера окна и проверка валидности этих параметров при запуске.
; в отличии от предыдущих вариантов здесь используетс€ $GUI_EVENT_RESIZED и WM_MOVING. ќба событи€ не реагируют на максимизацию окна, а значит при закрытии максимизированного окна не сохран€ют размеры на весь экран. Ќо максимизаци€ сохран€етс€ отдельным параметром. ƒл€ большей точности событи€ $GUI_EVENT_MAXIMIZE и $GUI_EVENT_RESTORE позвол€т сохранить состо€ние даже когда максимизированное окно закрыто из свЄрнутого состо€ни€.
#include <GUIConstantsEx.au3>
#include <WindowsConstants.au3>
#include <WinAPI.au3>
#Include <UserGUI.au3>

Global $WHXY[5], $ini = @ScriptDir & '\SaveXY.ini'

$WHXY[0] = Number(IniRead($ini, 'Set', 'W', '330'))
$WHXY[1] = Number(IniRead($ini, 'Set', 'H', '220'))
$WHXY[2] = IniRead($ini, 'Set', 'X', '')
$WHXY[3] = IniRead($ini, 'Set', 'Y', '')
$WHXY[4] = Number(IniRead($ini, 'Set', 'WinMax', ''))

_SetCoor($WHXY, 230 , 300, 0) ; ограничение ширины 230, ограничение высоты 300

$hGui = GUICreate('My Program', $WHXY[0], $WHXY[1], $WHXY[2], $WHXY[3], $WS_OVERLAPPEDWINDOW)
$OpFile = GUICtrlCreateButton('...', 150, 5, 86, 28)
$StatusBar = GUICtrlCreateLabel('—татистика', 5, 45, 240, 135)
GUISetState()
If $WHXY[4] Then GUISetState(@SW_MAXIMIZE, $hGui)

OnAutoItExitRegister("_Exit_Save_Ini")
GUIRegisterMsg(0x0216, "WM_MOVING")

While 1
	Switch GUIGetMsg()
		Case $GUI_EVENT_MAXIMIZE
			$WHXY[4] = 1
		Case $GUI_EVENT_RESTORE
			$WHXY[4] = 0
		Case $GUI_EVENT_RESIZED
			_Resized()
		Case $OpFile
			$tmp = FileOpenDialog('open', @ScriptDir, '¬се (*.*)', '', '', $hGui)
			If Not @error Then MsgBox(0, 'Message', $tmp)
		Case -3
			Exit
	EndSwitch
WEnd

Func _Exit_Save_Ini()
	$iState = WinGetState($hGui)
	$aWA = _WinAPI_GetWorkingArea()
	; ≈сли окно не свЄрнуто или не развЄрнуто на весь экран, то получаем его координаты и размеры
	; If Not (BitAnd($iState, 16) Or BitAnd($iState, 32)) Then _Resized()
	IniWrite($ini, 'Set', 'WinMax', $WHXY[4])
	IniWrite($ini, 'Set', 'W', $WHXY[0])
	IniWrite($ini, 'Set', 'H', $WHXY[1])
	IniWrite($ini, 'Set', 'X', $WHXY[2] - $aWA[0])
	IniWrite($ini, 'Set', 'Y', $WHXY[3] - $aWA[1])
EndFunc   ;==>_Exit_Save_Ini

Func _Resized() ; срабатывает один раз при изменении размера окна, но не при "–азвернуть на весь экран", "¬осстановить"
	$GuiPos = WinGetPos($hGui)
	$ClientSz = WinGetClientSize($hGui) ; сохран€етс€ размер клиентской области
	$WHXY[0] = $ClientSz[0]
	$WHXY[1] = $ClientSz[1]
	$WHXY[2] = $GuiPos[0]
	$WHXY[3] = $GuiPos[1]
EndFunc   ;==>_Resized

Func WM_MOVING($hWnd, $Msg, $wParam, $lParam)
	; получаем координаты окна. Ёто нужно при закрытии свЄрнутого скрипта
	Local $sRect = DllStructCreate("Int[4]", $lParam)
	$WHXY[2] = DllStructGetData($sRect, 1, 1)
	$WHXY[3] = DllStructGetData($sRect, 1, 2)
	Return $GUI_RUNDEFMSG
EndFunc   ;==>WM_MOVING