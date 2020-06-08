#region Example
#include <ButtonConstants.au3>
#include <EditConstants.au3>
#include <GUIConstantsEx.au3>
#include <WindowsConstants.au3>
#include <Constants.au3>
#include <GuiRichEdit.au3>
#include <GuiStatusBar.au3>
#include "RESH.au3"

Global $hGUI = GUICreate("RESH Example", 724, 600)
Global $Button1 = GUICtrlCreateButton("Highlight", 25, 535, 105, 25, $WS_GROUP)
Global $Button2 = GUICtrlCreateButton("Load Test.au3", 25 + 128, 535, 105, 25, $WS_GROUP)
Global $Button3 = GUICtrlCreateButton("Load Large UDF", 25 + (128 * 2), 535, 105, 25, $WS_GROUP)
Global $Button4 = GUICtrlCreateButton("Load Include File", 25 + (128 * 3), 535, 105, 25, $WS_GROUP)
Global $Button5 = GUICtrlCreateButton("Toggle Colors", 25 + (128 * 4), 535, 105, 25, $WS_GROUP)
Global $hRichEdit = _GUICtrlRichEdit_Create($hGUI, "", 8, 8, 701, 510, BitOR($ES_MULTILINE, $WS_VSCROLL, $WS_HSCROLL, $ES_AUTOVSCROLL))

Global $hStatus = _GUICtrlStatusBar_Create($hGUI)
Global $aParts[2] = [60, -1]
_GUICtrlStatusBar_SetParts($hStatus, $aParts)
_GUICtrlStatusBar_SetText($hStatus, 'Status:')
_GUICtrlStatusBar_SetText($hStatus, 'Idle', 1)
GUISetState(@SW_SHOW)

Local $sIncludeDir = StringReplace(@AutoItExe, 'autoit3.exe', 'include')

_LoadFile(@ScriptDir & '\Test.au3')


While 1
	Switch GUIGetMsg()
		Case $GUI_EVENT_CLOSE
			_GUICtrlRichEdit_Destroy($hRichEdit)
			Exit
		Case $Button1
			Global $timetotal = TimerInit()
			Global $sRTFCode = _RESH_SyntaxHighlight($hRichEdit, '_UpdateStats')
			ConsoleWrite('Total Time = ' & TimerDiff($timetotal) & @CRLF)
		Case $Button2
			_LoadFile(@ScriptDir & '\Test.au3')
		Case $Button3
			_LoadFile($sIncludeDir & '\winapi.au3')
		Case $Button4
			Local $open = FileOpenDialog('Select File', $sIncludeDir, "AU3 files (*.au3)")
			If Not @error Then _LoadFile($open)
		Case $Button5
			_ToggleColors()
	EndSwitch
WEnd

;This function shows how to update color settings.
;Each click it will alternate using either the default colors or new array of colors.
Func _ToggleColors()
	Static Local $iToggle = 1

	$iToggle = Not $iToggle

	If $iToggle Then
		;set code to default colors
		_RESH_SetColorTable(Default)
		If @error Then MsgBox(0, 'ERROR', 'Error setting new color table!')
	Else
		;these are not required but its easier to use enum when associating the array element numbers to the color meanings
		Local Enum $iMacros, $iStrings, $iSpecial, $iComments, $iVariables, $iOperators, $iNumbers, $iKeywords, _
				$iUDFs, $iSendKeys, $iFunctions, $iPreProc, $iComObjects

		;array must be 13 elements! no more no less.
		Local $aColorTable[13]

		;notice values can be either 0x or #
		$aColorTable[$iMacros] = '#808000'
		$aColorTable[$iStrings] = 0xFF0000
		$aColorTable[$iSpecial] = '#DC143C'
		$aColorTable[$iComments] = '#008000'
		$aColorTable[$iVariables] = '#5A5A5A'
		$aColorTable[$iOperators] = '#FF8000'
		$aColorTable[$iNumbers] = 0x0000FF
		$aColorTable[$iKeywords] = '#0000FF'
		$aColorTable[$iUDFs] = '#0080FF'
		$aColorTable[$iSendKeys] = '#808080'
		$aColorTable[$iFunctions] = '#000090'
		$aColorTable[$iPreProc] = '#808000'
		$aColorTable[$iComObjects] = 0x993399

		_RESH_SetColorTable($aColorTable)
		If @error Then MsgBox(0, 'ERROR', 'Error setting new color table!')
	EndIf

	;reload file and apply new color values
	_LoadFile()
	Local $timetotal = TimerInit()
	Local $sRTFCode = _RESH_SyntaxHighlight($hRichEdit, '_UpdateStats')
	ConsoleWrite('Total Time = ' & TimerDiff($timetotal) & @CRLF)

	_GUICtrlRichEdit_SetSel($hRichEdit, 0, -1)

EndFunc   ;==>_ToggleColors

Func _UpdateStats($iPercent, $sMsg)
	_GUICtrlStatusBar_SetText($hStatus, '( ' & $iPercent & '% ) ' & $sMsg, 1)
EndFunc   ;==>_UpdateStats

Func _LoadFile($sFile = '')
	Static Local $sLast

	;if $sfile is blank then we are just reloading the last file used.
	If Not $sFile Then $sFile = $sLast

	Local $iStart = _GUICtrlRichEdit_GetFirstCharPosOnLine($hRichEdit)
	Local $aScroll = _GUICtrlRichEdit_GetScrollPos($hRichEdit)

	Local $script = FileRead($sFile)
	_GUICtrlRichEdit_PauseRedraw($hRichEdit)
	_GUICtrlRichEdit_SetSel($hRichEdit, 0, -1, True)
	_GUICtrlRichEdit_ReplaceText($hRichEdit, '')

	_GUICtrlRichEdit_SetFont($hRichEdit, 9, 'Courier New')

	_GUICtrlRichEdit_SetLimitOnText($hRichEdit, Round(StringLen($script) * 1.5))
	_GUICtrlRichEdit_AppendText($hRichEdit, $script)
;~ 	_GUICtrlRichEdit_StreamFromVar($hRichEdit, $script)

	_GUICtrlRichEdit_GotoCharPos($hRichEdit, $iStart)
	_GUICtrlRichEdit_SetScrollPos($hRichEdit, $aScroll[0], $aScroll[1])
	_GUICtrlRichEdit_ResumeRedraw($hRichEdit)

	;save last file used
	$sLast = $sFile
EndFunc   ;==>_LoadFile

#endregion Example