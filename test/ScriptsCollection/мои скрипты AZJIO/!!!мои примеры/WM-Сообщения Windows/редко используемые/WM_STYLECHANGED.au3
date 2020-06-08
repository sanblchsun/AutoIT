#include <WindowsConstants.au3>
Global $k=0
GUIRegisterMsg (0x007D, "WM_STYLECHANGED")
$Gui = GUICreate("Измени стиль окна", 310, 170)
$Label = GUICtrlCreateLabel('', 5, 5, 300, 17)
GUICtrlSetColor(-1,0xff0000)
GUICtrlCreateLabel('Функция WM_STYLECHANGED срабатывает в момент изменения стиля окна.', 5, 25, 300, 34)
$NewStyle = False
$Style = GUICtrlCreateButton("Установить стиль", 10, 65, 150, 25)
$GuiStyles = GUIGetStyle($Gui)

GUISetState()

While 1
	$Msg = GUIGetMsg()
	Switch $Msg
		Case -3
			Exit
		Case $Style
			If Not $NewStyle Then
				GUISetStyle(BitOR($WS_POPUPWINDOW, $WS_THICKFRAME))
				GUICtrlSetData($Style, 'Возвратить стиль')
				$NewStyle = True
			Else
				GUISetStyle($GuiStyles[0], $GuiStyles[1])
				GUICtrlSetData($Style, 'Установить стиль')
				$NewStyle = False
			EndIf
		Case Else
	EndSwitch
WEnd

Func WM_STYLECHANGED($hWnd, $Msg, $wParam, $lParam)
	$k+=1
	WinSetTitle($Gui, '', 'Вызов ' &$k)
	GUICtrlSetData($Label, 'Вызов ' &$k)
EndFunc