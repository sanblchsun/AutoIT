#include <GUIConstantsEx.au3>

#include "GUIExtender.au3"

$hGUI = GUICreate("Test", 300, 390)

$Button = GUICtrlCreateButton("Test", 10, 20, 70, 22)

GUISetState()

While 1
	$iMsg = GUIGetMsg()
	Switch $iMsg
		Case $Button
			_Child()
		Case $GUI_EVENT_CLOSE
			Exit
	EndSwitch
WEnd

Func _Child()
    $hGUI_Child = GUICreate("Test", 250, 170)

    _GUIExtender_Init($hGUI_Child)

    _GUIExtender_Section_Start(0, 70)
    GUICtrlCreateGroup(" 1 - Static ", 10, 10, 230, 50)
    _GUIExtender_Section_Action(2, "", "", 220, 40, 15, 15) ; Normal button
    _GUIExtender_Section_End()

    _GUIExtender_Section_Start(70, 100)
    GUICtrlCreateGroup(" 2 - Extendable ", 10, 70, 230, 90)
    _GUIExtender_Section_End()

    GUICtrlCreateGroup("", -99, -99, 1, 1)

    GUISetState()

	While 1
        $iMsg = GUIGetMsg()
        Switch $iMsg
            Case $GUI_EVENT_CLOSE
                GUIDelete($hGUI_Child)
				_GUIExtender_Clear() ; If this is omitted, the script will crash when the child is created a second time
				Return
        EndSwitch
        _GUIExtender_Action($iMsg) ; Check for click on Action control
    WEnd
EndFunc

