#include <GUIConstantsEx.au3>
#include <ButtonConstants.au3>

Opt("GUIOnEventMode", 1)
Global $chbutt1_state=0

$win=GUICreate("MyCheckBOX")
GUISetOnEvent($GUI_EVENT_CLOSE, "Close")
;~ GUISetBkColor(0xFFFFCC)
$chbutt1=GUICtrlCreateIcon("chbox0.ico", -1, 30, 30, 16, 16)
GUICtrlSetOnEvent(-1, "ch_chbox")
GUICtrlCreateLabel("Графический чекбокс", 52, 30)
GUISetState()

While 1
	$msg = GUIGetMsg()
	If $msg = $GUI_EVENT_CLOSE Then ExitLoop
WEnd

Func Close()
	Exit
EndFunc

Func ch_chbox()
	If $chbutt1_state=0 Then
		GUICtrlSetImage($chbutt1, "chbox1.ico")
		$chbutt1_state=1
	Else
		GUICtrlSetImage($chbutt1, "chbox0.ico")
		$chbutt1_state=0
	EndIf
EndFunc
