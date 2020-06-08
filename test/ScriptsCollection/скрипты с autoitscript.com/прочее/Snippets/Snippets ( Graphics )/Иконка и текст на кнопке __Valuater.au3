; Icon on Button - (made easy)
#include <GUIConstantsEx.au3>
#include <WindowsConstants.au3>
#include <GUIConstants.au3>

Global $mywin = GUICreate("my gui")
Local $btn1 = _IconOnButton(" Help", 30, 30, 70, 32, 23)
GUISetState()

While 1
	Local $msg = GUIGetMsg()
	If $msg = $btn1 Then MsgBox(0, 0, "You pressed the Icon Button", 2)
	If $msg = $GUI_EVENT_CLOSE Then Exit
WEnd

Func _IconOnButton($BItext, $BIleft, $BItop, $BIwidth, $BIheight, $BIconNum, $BIDLL = "shell32.dll")
	GUICtrlCreateIcon($BIDLL, $BIconNum, $BIleft + 5, $BItop + (($BIheight - 16) / 2), 16, 16)
	GUICtrlSetState(-1, $GUI_DISABLE)
	Local $XS_btnx = GUICtrlCreateButton($BItext, $BIleft, $BItop, $BIwidth, $BIheight, $WS_CLIPSIBLINGS)
	Return $XS_btnx
EndFunc