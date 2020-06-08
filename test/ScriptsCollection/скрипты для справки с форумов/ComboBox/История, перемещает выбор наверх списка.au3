#include <GuiComboBox.au3>

Global $hCombo, $sText

$hGUI = GUICreate("(UDF) ComboBox Create", 450, 396)
$hCombo = GUICtrlCreateCombo("", 5, 4, 440, 296)
; $hCombo = GUICtrlGetHandle($iCombo)

$iDummy = GUICtrlCreateDummy()

Dim $AccelKeys[1][2] = [["{Enter}", $iDummy]]
GUISetAccelerators($AccelKeys)

GUISetState()

_GUICtrlComboBox_BeginUpdate($hCombo)
For $i = 1 To 10
	_GUICtrlComboBox_AddString($hCombo, $i & ' строка')
Next
_GUICtrlComboBox_EndUpdate($hCombo)

While 1
	Switch GUIGetMsg()
		Case $hCombo
			$iIndex = _GUICtrlComboBox_GetCurSel($hCombo)
			_GUICtrlComboBox_GetLBText($hCombo, $iIndex, $sText)
			_GUICtrlComboBox_DeleteString($hCombo, $iIndex)
			_GUICtrlComboBox_InsertString($hCombo, $sText, 0)
			_GUICtrlComboBox_SetCurSel($hCombo, 0)
		Case $iDummy
			$sText = _GUICtrlComboBox_GetEditText($hCombo)
			$iIndex = _GUICtrlComboBox_FindStringExact($hCombo, $sText)
			If $iIndex = -1 Then
				$iCount = _GUICtrlComboBox_GetCount($hCombo)
				If $iCount > 12 Then _GUICtrlComboBox_DeleteString($hCombo, $iCount - 1)
				_GUICtrlComboBox_InsertString($hCombo, $sText, 0)
			Else
				; _GUICtrlComboBox_GetLBText($hCombo, $iIndex, $sText)
				_GUICtrlComboBox_DeleteString($hCombo, $iIndex)
				_GUICtrlComboBox_InsertString($hCombo, $sText, 0)
			EndIf
		Case -3
			Exit
	EndSwitch
WEnd