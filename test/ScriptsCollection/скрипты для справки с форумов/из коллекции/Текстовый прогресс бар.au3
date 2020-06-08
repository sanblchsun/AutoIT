#include <ButtonConstants.au3>
#include <GUIConstantsEx.au3>
#include <StaticConstants.au3>
#include <WindowsConstants.au3>

Global $sString, $hLabel1
Global Const $COLOR = 0x0000FF

$hForm = GUICreate("Text Progress Bar", 625, 85)
$hLabel1 = GUICtrlCreateLabel("", 8, 8, 611, 24)
GUICtrlSetFont(-1, 12, 800, 0, "MS Sans Serif")
GUICtrlSetColor(-1, $COLOR)
$hButton1 = GUICtrlCreateButton("Ok", 536, 48, 75, 25, 0)

GUISetState(@SW_SHOW)

While 1
	$nMsg = GUIGetMsg()
	Switch $nMsg
		Case $GUI_EVENT_CLOSE
			Exit

		Case $hButton1
			For $i = 0 To 100
				Sleep(10)
				GUICtrlSetData($hLabel1, _TPB_ProgressSet($i))
				GUICtrlSetData($hButton1, $i & " %")
			Next

	EndSwitch
WEnd

Func _TPB_ProgressSet($Prosent = 0)

	If $Prosent < 0 Or $Prosent > 100 Then Return SetError(1, 0, 0)
	$String = "**************************************************************************************"
	Return StringLeft($String, $Prosent / (100 / StringLen($String)))

EndFunc   ;==>_TPB_ProgressSet
