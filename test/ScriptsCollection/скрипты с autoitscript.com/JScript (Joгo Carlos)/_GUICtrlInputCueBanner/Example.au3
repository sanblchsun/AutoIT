#include <GUIConstantsEx.au3>
#include <ButtonConstants.au3>
#include <EditConstants.au3>
#include <WindowsConstants.au3>

#include "_GUICtrlInputCueBanner.au3"

_Example()

Func _Example()
	Local $hForm, $iInput1, $iInput2, $iButton

	$hForm = GUICreate("Example", 360, 163, -1, -1)

	GUICtrlCreateLabel("Background comment using _GuiCtrlInput_SetComment function!", 25, 32, 314, 17)

	$iInput1 = GUICtrlCreateInput("", 57, 64, 247, 21, $ES_PASSWORD)
	_GuiCtrlInput_SetCueBanner(-1, "Type new password", 0x696969, 0xCFCFCF)

	$iInput2 = GUICtrlCreateInput("", 57, 94, 247, 21, $ES_PASSWORD)
	_GuiCtrlInput_SetCueBanner(-1, "Confirm new password", 0x696969, 0xCFCFCF)

	$iButton = GUICtrlCreateButton("Exit", 136, 126, 75, 25)

	GUISetState(@SW_SHOW)

	While 1
		$nMsg = GUIGetMsg()
		Switch $nMsg
			Case $iButton, $GUI_EVENT_CLOSE
				Exit
		EndSwitch
	WEnd
EndFunc   ;==>_Example