#include <GUIConstantsEx.au3>
#include <GUIEdit.au3>
#include <ComboConstants.au3>
#include <WindowsConstants.au3>

#include "GUICtrlCreateTFLabel.au3"

Global $iEdit_Changed = 0, $aLabel_Ctrls

$hGUI = GUICreate("Formated Labels Editor", 650, 400)

#Region Formate text panel

GUICtrlCreateLabel("Size:", 10, 8, -1, 15)
$nSize_Combo = GUICtrlCreateCombo("", 40, 5, 55, 20, BitOr($GUI_SS_DEFAULT_COMBO, $CBS_DROPDOWNLIST))
GUICtrlSetData(-1, "None|8|8.5|9|10|11|12|14|16|18|20|22|24|26|28|36|48|72", "None")

GUICtrlCreateLabel("Weight:", 100, 8, -1, 15)
$nWeight_Combo = GUICtrlCreateCombo("", 140, 5, 55, 20, BitOr($GUI_SS_DEFAULT_COMBO, $CBS_DROPDOWNLIST))
GUICtrlSetData(-1, "None|200|400|600|800|1000", "None")

GUICtrlCreateLabel("Attrib:", 10, 33, -1, 15)
$nAttrib_Combo = GUICtrlCreateCombo("", 40, 30, 155, 20, BitOr($GUI_SS_DEFAULT_COMBO, $CBS_DROPDOWNLIST))
GUICtrlSetData(-1, "None|italic|underlined|strike|italic+underlined+strike|italic+underlined|italic+strike|underlined+strike", "None")

GUICtrlCreateLabel("Name:", 230, 15, 50, 15)
$nName_Combo = GUICtrlCreateCombo("", 230, 30, 160, 20, BitOr($GUI_SS_DEFAULT_COMBO, $CBS_DROPDOWNLIST))
GUICtrlSetData(-1, "None|Arial|Comic Sans Ms|Tahoma|Times|Georgia|Lucida Sans Unicode|Verdana|Times New Roman|Courier New", "None")

GUICtrlCreateLabel("Color:", 400, 15, 50, 15)
$nColor_Combo = GUICtrlCreateCombo("", 400, 30, 60, 20, BitOr($GUI_SS_DEFAULT_COMBO, $CBS_DROPDOWNLIST))
GUICtrlSetData(-1, "None|Red|Green|Blue|Yellow|Orange|Gray|Brown|White", "None")

GUICtrlCreateLabel("Bk Color:", 470, 15, 50, 15)
$nBkColor_Combo = GUICtrlCreateCombo("", 470, 30, 60, 20, BitOr($GUI_SS_DEFAULT_COMBO, $CBS_DROPDOWNLIST))
GUICtrlSetData(-1, "None|Red|Green|Blue|Yellow|Orange|Gray|Brown|White", "None")

GUICtrlCreateLabel("Cursor:", 540, 15, 50, 15)
$nCursor_Combo = GUICtrlCreateCombo("", 540, 30, 100, 20, BitOr($GUI_SS_DEFAULT_COMBO, $CBS_DROPDOWNLIST))
GUICtrlSetData(-1, "None|POINTING|APPSTARTING|ARROW|CROSS|HELP|IBEAM|ICON|NO|SIZE|SIZEALL|SIZENESW|SIZENS|SIZENWSE|SIZEWE|UPARROW|WAIT|HAND", "None")

#EndRegion Formate text panel

GUICtrlCreateLabel("Select text and then select the formating parameters from the above panel:", 10, 60, -1, 15)

$nTextFormate_Edit = GUICtrlCreateEdit("", 10, 75, 630, 145, BitOr($GUI_SS_DEFAULT_EDIT, $ES_NOHIDESEL))

GUICtrlCreateGroup("Preview:", 10, 230, 630, 130)
GUICtrlSetFont(-1, 10, 800)

$nClose_Button = GUICtrlCreateButton("Close", 10, 370, 60, 20)
$nCopy_Button = GUICtrlCreateButton("Copy", 90, 370, 60, 20)

GUIRegisterMsg($WM_COMMAND, "WM_COMMAND")
GUISetState(@SW_SHOW, $hGUI)

While 1
	$nMsg = GUIGetMsg()
	
	Switch $nMsg
		Case $GUI_EVENT_CLOSE, $nClose_Button
			Exit
		Case $nSize_Combo, $nWeight_Combo, $nAttrib_Combo, $nName_Combo, $nColor_Combo, $nBkColor_Combo, $nCursor_Combo
			Local $sParam = StringLower(StringRegExpReplace(GUICtrlRead($nMsg - 1), '\h+|:', ''))
			Local $sValue = GUICtrlRead($nMsg)
			
			_SetFormatedText_Proc($sParam, $sValue)
		Case $nCopy_Button
			Local $sText = GUICtrlRead($nTextFormate_Edit)
			
			If $sText <> "" Then
				ClipPut($sText)
			EndIf
	EndSwitch
	
	If $iEdit_Changed Then
		$iEdit_Changed = 0
		
		For $i = 1 To UBound($aLabel_Ctrls)-1
			GUICtrlDelete($aLabel_Ctrls[$i])
		Next
		
		$aLabel_Ctrls = _GUICtrlCreateTFLabel(GUICtrlRead($nTextFormate_Edit), 20, 245)
	EndIf
WEnd

Func _SetFormatedText_Proc($sParam, $sValue)
	If $sParam = "attrib" And Not StringRegExp($sValue, '(?i)\A(None)?\z') Then
		$aSplit = StringSplit($sValue, "+")
		$sValue = ""
		
		For $i = 1 To $aSplit[0]
			$sValue &= StringLeft($aSplit[$i], 1)
			
			If $i < $aSplit[0] Then
				$sValue &= "+"
			EndIf
		Next
	EndIf
	
	Local $sSelectionData = ControlCommand($hGUI, "", $nTextFormate_Edit, "GetSelected")
	Local $sAddParamValue = ' ' & $sParam & '="' & $sValue & '"'
	
	If $sSelectionData = '' Then
		Return
	EndIf
	
	If StringRegExp($sSelectionData, '(?i)<font.*>.*</font>') Then
		$sSelectionData = StringRegExpReplace($sSelectionData, '(?i)(<font.*)( ' & $sParam & '=".*?")(.*>.*</font>)', '\1\3')
		
		If Not StringRegExp($sValue, '(?i)\A(None)?\z') Then
			$sSelectionData = StringRegExpReplace($sSelectionData, '(?i)(<font.*)(>.*</font>)', '\1' & $sAddParamValue & '\2')
		EndIf
		
		If StringRegExp($sSelectionData, '(?i)<font\h*>.*</font>') Then
			$sSelectionData = StringRegExpReplace($sSelectionData, '(?i)<font.*>(.*)</font>', '\1')
		EndIf
	ElseIf $sAddParamValue <> '' Then
		$sSelectionData = '<font' & $sAddParamValue & '>' & $sSelectionData & '</font>'
	EndIf
	
	_GUICtrlEdit_ReplaceSel($nTextFormate_Edit, $sSelectionData)
	Local $iStart = StringInStr(GUICtrlRead($nTextFormate_Edit), $sSelectionData)-1
	Local $iEnd = $iStart + StringLen($sSelectionData)
	GUICtrlSendMsg($nTextFormate_Edit, $EM_SETSEL, $iStart, $iEnd)
EndFunc

Func WM_COMMAND($hWnd, $nMsg, $wParam, $lParam)
	Local $nNotifyCode = BitShift($wParam, 16)
	Local $nID = BitAND($wParam, 0xFFFF)
	Local $hCtrl = $lParam
	
	Switch $nID
		Case $nTextFormate_Edit
			Switch $nNotifyCode
				Case $EN_CHANGE, $EN_UPDATE
					$iEdit_Changed = 1
			EndSwitch
	EndSwitch
	
	Return $GUI_RUNDEFMSG
EndFunc
