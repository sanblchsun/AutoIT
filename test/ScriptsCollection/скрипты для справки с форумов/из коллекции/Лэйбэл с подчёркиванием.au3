
#include <GUIConstantsEx.au3>
#include <StaticConstants.au3>
#include <WindowsConstants.au3>

$fIndex = False
$fIndexRun = False

#Region ### START Koda GUI section ### Form=
$Form1 = GUICreate("Form1", 460, 207, 434, 372)
$Label1 = GUICtrlCreateLabel("Label1", 120, 40, 80, 35)
GUICtrlSetFont(-1, 20, 400, 2, "Arial")
GUICtrlSetColor(-1, 0xFF0000)
$Label2 = GUICtrlCreateLabel("Label2", 114, 95, 85, 35)
GUICtrlSetFont(-1, 20, 400, 2, "Arial")
GUICtrlSetColor(-1, 0x0000FF)
GUISetState(@SW_SHOW)
#EndRegion ### END Koda GUI section ###

While 1
	$nMsg = GUIGetMsg(1)
	Switch $nMsg[0]
		Case $GUI_EVENT_CLOSE
			Exit

		Case $GUI_EVENT_MOUSEMOVE
			If $nMsg[3] > 120 And $nMsg[3] < 200 And $nMsg[4] > 40 And $nMsg[4] < 75 Then
				GUICtrlSetFont($Label1, 20, 400, 6, "Arial")
				GUICtrlSetColor($Label1, 0xFF0000)
				$fIndex = True
			Else
				GUICtrlSetFont($Label1, 20, 400, 2, "Arial")
				GUICtrlSetColor($Label1, 0xFF0000)
				$fIndex = False
			EndIf

		Case $GUI_EVENT_PRIMARYDOWN
			If $nMsg[3] > 120 And $nMsg[3] < 200 And $nMsg[4] > 40 And $nMsg[4] < 75 Then
				$fIndexRun = True
			Else
				$fIndexRun = False
			EndIf

		Case $GUI_EVENT_PRIMARYUP
			If $nMsg[3] > 120 And $nMsg[3] < 200 And $nMsg[4] > 40 And $nMsg[4] < 75 And $fIndexRun = True Then MsgBox(0,"","")

	EndSwitch
WEnd
