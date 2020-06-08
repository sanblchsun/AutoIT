#include <GUIConstantsEx.au3>
#include <WindowsConstants.au3>

Global $TrHelp=0

$Gui = GUICreate("CONTEXTHELP", 440, 270, -1, -1, BitOr($WS_SYSMENU,$WS_CAPTION), $WS_EX_CONTEXTHELP)
$iHelp =GUICtrlCreateLabel('����� 1.', 25, 25, 430, 17)
$iData = GUICtrlCreateLabel('����� 2', 25, 65, 430, 17)
$iButton = GUICtrlCreateButton('Button', 10, 100, 70, 25)
GUISetState()
GUIRegisterMsg($WM_SYSCOMMAND, "WM_SYSCOMMAND")

While 1
	$msg = GUIGetMsg()
	If $TrHelp Then
		$a = GUIGetCursorInfo()
		Switch $a[4]
			Case $iButton
				ToolTip('��� ������')
			Case $iHelp
				ToolTip('��� ������� 1')
			Case $iData
				ToolTip('��� ������� 2')
		EndSwitch
		AdlibRegister('_CloseToolTip', 2000)
		$TrHelp=0
		ContinueLoop
	EndIf
	Switch $msg
		Case $iButton
			GUICtrlSetData($iData,'Done')
		Case -3
			 Exit
	EndSwitch
WEnd

Func _CloseToolTip()
    AdlibUnRegister('_CloseToolTip')
    ToolTip('')
EndFunc

Func WM_SYSCOMMAND($hWnd, $Msg, $wParam, $lParam)
    If BitAND($wParam, 0xFFFF) = 0xF180 Then $TrHelp=1
    Return $GUI_RUNDEFMSG
EndFunc