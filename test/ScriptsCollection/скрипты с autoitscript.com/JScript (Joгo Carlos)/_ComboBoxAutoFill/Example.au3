#include <ButtonConstants.au3>
#include <ComboConstants.au3>
#include <GUIConstantsEx.au3>
#include <StaticConstants.au3>
#include <WindowsConstants.au3>
#include <GuiComboBox.au3>
#include <Constants.au3>

#include "_ComboBoxAutoFill.au3"

_Main()

Func _Main()
	Local $Form1, $hCombo, $iButton, $asData

	$Form1 = GUICreate("_ComboBoxAutoFill.au3 example", 365, 122, -1, 200)

	$hCombo = _GUICtrlComboBox_Create($Form1, "", 108, 32, 243, 25, BitOR($CBS_DROPDOWN, $CBS_AUTOHSCROLL, $WS_VSCROLL));, $CBS_SORT))

	GUICtrlCreateLabel("Enter a keyword:", 8, 34, 95, 17)
	$iButton = GUICtrlCreateButton("Add new item...", 144, 81, 75, 25)

	$asData = IniReadSection(@ScriptDir & "\Data.ini", "data")
	_GUICtrlComboBox_BeginUpdate($hCombo)
	For $i = 0 To $asData[0][0]
		_GUICtrlComboBox_AddString($hCombo, $asData[$i][1])
	Next
	_GUICtrlComboBox_EndUpdate($hCombo)

	;----> AutoFill a ComboBox edit control.
	_GUICtrlComboBox_AutoFillCreate($hCombo)
	;<----
	GUISetState(@SW_SHOW)

	While 1
		$nMsg = GUIGetMsg()
		Switch $nMsg
			Case $GUI_EVENT_CLOSE
				Exit
			Case $iButton
				Local $sNewItem = InputBox("Add new item...", "Type new item:")
				If Not @error Then
					_GUICtrlComboBox_AddString($hCombo, $sNewItem)
					_GUICtrlComboBox_AutoFillUpdateContent($hCombo)
				EndIf
		EndSwitch
	WEnd
EndFunc   ;==>_Main