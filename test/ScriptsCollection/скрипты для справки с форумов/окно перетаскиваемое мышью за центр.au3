#include <GuiConstants.au3>

$Gui = GUICreate("Drag Window Demo", 400, 300, -1, -1)

$BackPicID = GUICtrlCreatePic("C:\WINDOWS\Штукатурка.bmp", 0, 0, 400, 300)
GUICtrlSetState(-1, $GUI_DISABLE)

$ExitButton = GUICtrlCreateButton("Exit", 20, 270, 70, 20)

GUISetState()

While 1
	$Msg = GUIGetMsg()
	Switch $Msg
		Case -3
			Exit
		Case $ExitButton
			Exit
		Case $GUI_EVENT_PRIMARYDOWN
			DragWindow($Gui)
	EndSwitch
WEnd

Func DragWindow($hWnd)
	Local $MousePos = MouseGetPos()
	Local $hWndPos = WinGetPos($hWnd)
	Local $WinPos[2], $IsPressed[1], $OpenDll, $GuiCurInfo[5]
	$WinPos[0] = $MousePos[0] - $hWndPos[0]
	$WinPos[1] = $MousePos[1] - $hWndPos[1]
	$OpenDll = DllOpen("user32.dll")
	$GuiCurInfo = GUIGetCursorInfo($hWnd)
	If $OpenDll <> -1 And ($GuiCurInfo[4] = 0 Or $GuiCurInfo[4] = $BackPicID) Then
		Do
			$hWndPos = MouseGetPos()
			WinMove($hWnd, '', $hWndPos[0] - $WinPos[0], $hWndPos[1] - $WinPos[1])
			Sleep(20)
			$IsPressed = DllCall($OpenDll, "int", "GetAsyncKeyState", "int", '0x01')
		Until @error Or BitAND($IsPressed[0], 0x8000) <> 0x8000
	EndIf
	DllClose($OpenDll)
EndFunc   ;==>DragWindow
