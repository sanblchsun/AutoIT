#include <GUIConstantsEx.au3>

$hGUI = GUICreate("Test", 500, 500)
$cLabel = GUICtrlCreateLabel("", 100, 100, 300, 300)
$cButton = GUICtrlCreateButton("Change", 10, 450, 80, 30)
GUISetState()

While 1
	Switch GUIGetMsg()
		Case $GUI_EVENT_CLOSE
			Exit
		Case $cButton
			$iColour = Random(0, 0xFFFFFF, 1)
			GUISetBkColor($iColour)
			$iContrast_Colour = _CalcContrastColour($iColour)
			GUICtrlSetBkColor($cLabel, $iContrast_Colour)
	EndSwitch
WEnd

Func _CalcContrastColour($iColour, $iTolerance = 30)
	Switch $iTolerance
		Case 0 To 255
			$iTolerance = Int($iTolerance)
		Case Else
			$iTolerance = 30
	EndSwitch

	If (Abs(BitAND($iColour, 0xFF) - 0x80) <= $iTolerance And _
			Abs(BitAND(BitShift($iColour, 8), 0xFF) - 0x80) <= $iTolerance And _
			Abs(BitAND(BitShift($iColour, 16), 0xFF) - 0x80) <= $iTolerance) _
			Then Return BitAND((0x7F7F7F + $iColour), 0xFFFFFF)

	Return BitXOR($iColour, 0xFFFFFF)
EndFunc