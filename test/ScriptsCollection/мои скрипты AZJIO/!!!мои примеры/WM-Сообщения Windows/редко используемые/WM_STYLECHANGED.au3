#include <WindowsConstants.au3>
Global $k=0
GUIRegisterMsg (0x007D, "WM_STYLECHANGED")
$Gui = GUICreate("������ ����� ����", 310, 170)
$Label = GUICtrlCreateLabel('', 5, 5, 300, 17)
GUICtrlSetColor(-1,0xff0000)
GUICtrlCreateLabel('������� WM_STYLECHANGED ����������� � ������ ��������� ����� ����.', 5, 25, 300, 34)
$NewStyle = False
$Style = GUICtrlCreateButton("���������� �����", 10, 65, 150, 25)
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
				GUICtrlSetData($Style, '���������� �����')
				$NewStyle = True
			Else
				GUISetStyle($GuiStyles[0], $GuiStyles[1])
				GUICtrlSetData($Style, '���������� �����')
				$NewStyle = False
			EndIf
		Case Else
	EndSwitch
WEnd

Func WM_STYLECHANGED($hWnd, $Msg, $wParam, $lParam)
	$k+=1
	WinSetTitle($Gui, '', '����� ' &$k)
	GUICtrlSetData($Label, '����� ' &$k)
EndFunc