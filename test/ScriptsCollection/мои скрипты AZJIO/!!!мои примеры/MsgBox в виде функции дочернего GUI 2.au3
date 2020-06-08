#include <WindowsConstants.au3>

$Gui = GUICreate('My program', 420, 250)
$MsgBox = GUICtrlCreateButton("Button", 20, 20, 90, 30)
GUISetState()

While 1
	Switch GUIGetMsg()
		Case $MsgBox
			_MsgBox()
		Case -3
			Exit
	EndSwitch
WEnd

Func _MsgBox()
	Local $EditBut, $Gui1, $GP, $msg, $StrBut
	$GP = _ChildCoor($Gui, 410, 240)
	GUISetState(@SW_DISABLE, $Gui)
	
	$Gui1 = GUICreate('—ообщение', $GP[2], $GP[3], $GP[0], $GP[1], $WS_CAPTION + $WS_SYSMENU + $WS_POPUP, -1, $Gui)
	GUICtrlCreateLabel('„то будем делать сейчас?', 20, 10, 180, 23)
	$EditBut = GUICtrlCreateButton('–едактор', 10, 40, 80, 22)
	$StrBut = GUICtrlCreateButton(' алькул€тор', 100, 40, 80, 22)
	GUISetState(@SW_SHOW, $Gui1)
	While 1
		Switch GUIGetMsg()
			Case $EditBut
				Run('Notepad.exe')
			Case $StrBut
				ShellExecute('Calc.exe')
			Case -3
				GUISetState(@SW_ENABLE, $Gui)
				GUIDelete($Gui1)
				ExitLoop
		EndSwitch
	WEnd
EndFunc

; вычисление координат дочернего окна
; 1 - дескриптор родительского окна
; 2 - ширина дочернего окна
; 3 - высота дочернего окна
; 4 - тип 0 - по центру, или 0 - к левому верхнему родительского окна
; 5 - отступ от краЄв
Func _ChildCoor($Gui, $w, $h, $c = 0, $d = 0)
	Local $aWA = _WinAPI_GetWorkingArea(), _
			$GP = WinGetPos($Gui), _
			$wgcs = WinGetClientSize($Gui)
	Local $dLeft = ($GP[2] - $wgcs[0]) / 2, _
			$dTor = $GP[3] - $wgcs[1] - $dLeft
	If $c = 0 Then
		$GP[0] = $GP[0] + ($GP[2] - $w) / 2 - $dLeft
		$GP[1] = $GP[1] + ($GP[3] - $h - $dLeft - $dTor) / 2
	EndIf
	If $d > ($aWA[2] - $aWA[0] - $w - $dLeft * 2) / 2 Or $d > ($aWA[3] - $aWA[1] - $h - $dLeft + $dTor) / 2 Then $d = 0
	If $GP[0] + $w + $dLeft * 2 + $d > $aWA[2] Then $GP[0] = $aWA[2] - $w - $d - $dLeft * 2
	If $GP[1] + $h + $dLeft + $dTor + $d > $aWA[3] Then $GP[1] = $aWA[3] - $h - $dLeft - $dTor - $d
	If $GP[0] <= $aWA[0] + $d Then $GP[0] = $aWA[0] + $d
	If $GP[1] <= $aWA[1] + $d Then $GP[1] = $aWA[1] + $d
	$GP[2] = $w
	$GP[3] = $h
	Return $GP
EndFunc

Func _WinAPI_GetWorkingArea()
	Local Const $SPI_GETWORKAREA = 48
	Local $stRECT = DllStructCreate("long; long; long; long")

	Local $SPIRet = DllCall("User32.dll", "int", "SystemParametersInfo", "uint", $SPI_GETWORKAREA, "uint", 0, "ptr", DllStructGetPtr($stRECT), "uint", 0)
	If @error Then Return 0
	If $SPIRet[0] = 0 Then Return 0

	Local $sLeftArea = DllStructGetData($stRECT, 1)
	Local $sTopArea = DllStructGetData($stRECT, 2)
	Local $sRightArea = DllStructGetData($stRECT, 3)
	Local $sBottomArea = DllStructGetData($stRECT, 4)

	Local $aRet[4] = [$sLeftArea, $sTopArea, $sRightArea, $sBottomArea]
	Return $aRet
EndFunc