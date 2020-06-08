#include <WinAPI.au3>
#include <WindowsConstants.au3>
Global Const $GUI_RUNDEFMSG = 'GUI_RUNDEFMSG'
Global $btn1, $btn2, $iMemo = 0, $Button1

$Gui = GUICreate('My Program', 250, 260)
$Button1 = GUICtrlCreateButton('Start', 10, 10, 120, 22)
$Label1 = GUICtrlCreateLabel('StatusBar', 5, 260 - 20, 150, 17)
GUISetState()
GUIRegisterMsg(0x004E, "WM_NOTIFY")

While 1
	$msg = GUIGetMsg()
	If $iMemo = 2 Then
		$iMemo = 0
		_MsgFile($Button1)
	EndIf
	Switch $msg
		Case -3
			Exit
	EndSwitch
WEnd

Func _MsgFile($ctrl)
	$cgp = ControlGetPos($Gui, "", $ctrl)
	$tpoint = DllStructCreate("int X;int Y")
	_WinAPI_ClientToScreen($Gui, $tpoint)
	$x = DllStructGetData($tpoint, "X") + $cgp[0]
	$y = DllStructGetData($tpoint, "Y") + $cgp[1] + $cgp[3]
	
	Local $EditBut, $Gui1, $GuiPos, $msg, $StrBut
	; GUISetState(@SW_DISABLE, $Gui)
	
	$Gui1 = GUICreate('Сообщение', 22 * 7, 22 * 5, $x, $y, $WS_POPUPWINDOW, $WS_EX_TOOLWINDOW + $WS_EX_TOPMOST, $Gui)
	$aWord = StringSplit('9999bb|aa99aa|cccc00|CCCCEE|b0b558|dadd4e|FF0000|FFCA42|E2B4B4|C04141|99CCFF|F06320|862D2D|F9E6E6|0000FF|FFFF00|72ADC0|71AE71|C738B9|AAA6DB|0080FF|FF46FF|FF8080|D29A6C|EA9515|F000FF|0080C0|7D8AE6|FFFFFF|cccccc|696969|CCCCEE|5d5d5d|AAAAAA|3F3F3F', '|')
	Local $aBt[$aWord[0] + 1]
	For $i = 1 To $aWord[0]
		$gcm = Opt("GUICoordMode", 2)
		Switch $i
			Case 8, 15, 22, 29
				$aBt[$i] = GUICtrlCreateLabel('', -22 * 7, 0, 22, 22)
				GUICtrlSetBkColor(-1, Dec($aWord[$i]))
			Case 1
				$aBt[$i] = GUICtrlCreateLabel('', 1, 2, 22, 22)
				GUICtrlSetBkColor(-1, Dec($aWord[$i]))
			Case Else
				$aBt[$i] = GUICtrlCreateLabel('', 0, -1, 22, 22)
				GUICtrlSetBkColor(-1, Dec($aWord[$i]))
		EndSwitch
		Opt("GUICoordMode", $gcm)
	Next
	GUISetState(@SW_SHOW, $Gui1)

	While 1
		$msg = GUIGetMsg()
		For $i = 1 To $aWord[0]
			If $msg = $aBt[$i] Then
				GUICtrlSetData($Button1, $aWord[$i])
				GUICtrlSetBkColor($Gui, Dec($aWord[$i]))
				GUISetBkColor(Dec($aWord[$i]), $Gui)
				ExitLoop 2
			EndIf
		Next
		If $iMemo = 1 Then
			$Gui1ci = GUIGetCursorInfo($Gui1)
			; GUICtrlSetData($Label1, $Gui1ci[0])
			If $Gui1ci[0] < -2 Or $Gui1ci[1] < -5 Or $Gui1ci[0] > 154 Or $Gui1ci[1] > 110 Then
				$iMemo = 0
				ExitLoop
			EndIf
		EndIf
	WEnd
	; GUISetState(@SW_ENABLE, $Gui)
	GUIDelete($Gui1)
EndFunc

Func WM_NOTIFY($hWnd, $msg, $wParam, $lParam)
	
	#forceref $hWnd, $Msg, $wParam
	; If $hWnd<>$Gui Then Return $GUI_RUNDEFMSG
	Local Const $BCN_HOTITEMCHANGE = -1249
	Local $tNMBHOTITEM = DllStructCreate("hwnd hWndFrom;int IDFrom;int Code;dword dwFlags", $lParam)
	Local $nNotifyCode = DllStructGetData($tNMBHOTITEM, "Code")
	Local $nID = DllStructGetData($tNMBHOTITEM, "IDFrom")
	Local $hCtrl = DllStructGetData($tNMBHOTITEM, "hWndFrom")
	Local $dwFlags = DllStructGetData($tNMBHOTITEM, "dwFlags")
	Local $sText = ""

	If $nID = $Button1 Then
		Switch $nNotifyCode
			Case $BCN_HOTITEMCHANGE ; Win XP and Above
				If BitAND($dwFlags, 0x10) = 0x10 Then
					$iMemo = 2
				ElseIf BitAND($dwFlags, 0x20) = 0x20 Then
					$iMemo = 1
				EndIf
		EndSwitch
	EndIf
	Return $GUI_RUNDEFMSG
EndFunc