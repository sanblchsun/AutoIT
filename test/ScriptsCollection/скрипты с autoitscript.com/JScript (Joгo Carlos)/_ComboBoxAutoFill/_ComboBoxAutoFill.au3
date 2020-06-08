#AutoIt3Wrapper_Au3Check_Parameters=-d -w 1 -w 2 -w 3 -w- 4 -w 5 -w 6 -w- 7 ; Uncomment this line to Au3Check!
#include-once
; #INDEX# =======================================================================================================================
; Title .........: _ComboBoxAutoFill.au3
; Version .......: 0.12.1812.2600b
; AutoIt Version.: 3.3.8.1
; Language.......: English
; Description ...: AutoFill a ComboBox edit control.
; Author ........: João Carlos (jscript)
; Remarks .......: Need this UDF: _GUIRegisterMsgEx.au3
; ===============================================================================================================================

; #CURRENT# =====================================================================================================================
; _GUICtrlComboBox_AutoFillCreate
; _GUICtrlComboBox_AutoFillDelete
; _GUICtrlComboBox_AutoFillAddString
; _GUICtrlComboBox_AutoFillDelString
; ===============================================================================================================================

; #INTERNAL_USE_ONLY# ===========================================================================================================
; __CBA_AutoFill
; __CBA_WM_COMMAND
; __CBA_GetHWndIndex
; ===============================================================================================================================

; #INCLUDES# ====================================================================================================================
#include <WinAPI.au3>
#include <GuiEdit.au3>
#include <GuiComboBox.au3>
#include <ComboConstants.au3>
#include <GUIConstantsEx.au3>
#include <WindowsConstants.au3>
;
#include "_GUIRegisterMsgEx.au3"
; ===============================================================================================================================

; #VARIABLES# ===================================================================================================================
Global $avCBA_MSGIDS[1][6]
; ===============================================================================================================================

; #FUNCTION# ====================================================================================================================
; Name ..........: _GUICtrlComboBox_AutoFillCreate
; Description ...: AutoFill a ComboBox edit control.
; Syntax ........: _GUICtrlComboBox_AutoFillCreate($hWnd[, $lPartialSearch = False])
; Parameters ....: $hWnd                - Control ID/Handle to the control.
;				   $lPartialSearch		- [Optional] Search mode, True for partial. Default is False (Search from the beginning!).
; Return values .: Success 	 			- Returns a handle to be used with _GUICtrlComboBox_AutoFillDelete function.
;				   Failure 	 			- Returns 0.
; Author ........: JScript
; Modified ......:
; Remarks .......:
; Related .......:
; Link ..........:
; Example .......: No
; ===============================================================================================================================
Func _GUICtrlComboBox_AutoFillCreate($hWnd, $lPartialSearch = False)
	Local $hMsgReg, $iIndex, $aList, $iCount = 0

	If $hWnd = -1 Then $hWnd = _WinAPI_GetDlgCtrlID(GUICtrlGetHandle(-1))

	If Not IsHWnd($hWnd) Then $hWnd = GUICtrlGetHandle($hWnd)

	Switch $lPartialSearch
		Case Default, 0, False
			$lPartialSearch = False
		Case Else
			$lPartialSearch = True
	EndSwitch

	$iIndex = __CBA_GetHWndIndex($hWnd)
	If $iIndex Then Return 0

	$hMsgReg = _GUICtrlMsg_Register($hWnd, $WM_COMMAND, "__CBA_WM_COMMAND")
	If Not $hMsgReg Then Return 0

	$aList = _GUICtrlComboBox_GetListArray($hWnd)
	If $aList[0] > 1 Then $iCount = $aList[0]

	;----> Fills array with the control data!
	$iIndex = $avCBA_MSGIDS[0][0] + 1
	ReDim $avCBA_MSGIDS[$iIndex + 1][6]
	$avCBA_MSGIDS[0][0] = $iIndex
	$avCBA_MSGIDS[$iIndex][0] = $hWnd
	$avCBA_MSGIDS[$iIndex][1] = $hMsgReg
	$avCBA_MSGIDS[$iIndex][2] = $iCount
	$avCBA_MSGIDS[$iIndex][3] = $aList
	$avCBA_MSGIDS[$iIndex][4] = _GUICtrlComboBox_GetMinVisible($hWnd)
	$avCBA_MSGIDS[$iIndex][5] = $lPartialSearch
	;<----
	Return $hWnd
EndFunc   ;==>_GUICtrlComboBox_AutoFillCreate

; #FUNCTION# ====================================================================================================================
; Name ..........: _GUICtrlComboBox_AutoFillSetContent
; Description ...: Set the content of a ComboBox
; Syntax ........: _GUICtrlComboBox_AutoFillSetContent($hWnd, $vData)
; Parameters ....: $hWnd                - Control ID/Handle to the control.
;                  $vData               - Either an 1-Based array of items, or a pipe "|" delimited string of items.
; Return values .: Success 	 			- Returns items count.
;				   Failure 	 			- Returns -1.
; Author ........: Matwachich
; Modified ......: JScript
; Remarks .......:
; Related .......:
; Link ..........:
; Example .......: No
; ===============================================================================================================================
Func _GUICtrlComboBox_AutoFillSetContent($hWnd, $vData)
	Local $iIndex, $iCount

	$iIndex = __CBA_GetHWndIndex($hWnd)
	If Not $iIndex Then Return -1

	_GUICtrlComboBox_ResetContent($hWnd)
	If Not IsArray($vData) Then
		$vData = StringSplit($vData, "|")
		If @error Then Return -1
	EndIf
	$iCount = $vData[0]

	_GUICtrlComboBox_BeginUpdate($hWnd)
	For $i = 1 To $vData[0]
		_GUICtrlComboBox_InsertString($hWnd, $vData[$i])
	Next
	_GUICtrlComboBox_EndUpdate($hWnd)

	$avCBA_MSGIDS[$iIndex][2] = $iCount
	$avCBA_MSGIDS[$iIndex][3] = $vData
	Return $iCount
EndFunc   ;==>_GUICtrlComboBox_AutoFillSetContent

; #FUNCTION# ====================================================================================================================
; Name ..........: _GUICtrlComboBox_AutoFillUpdateContent
; Description ...: Update the auto-fill system with the data (items) contained in a comboBox
; Syntax ........: _GUICtrlComboBox_AutoFillUpdateContent($hWnd)
; Parameters ....: $hWnd                - Control ID/Handle to the control.
; Return values .: Success 	 			- Returns items count.
;				   Failure 	 			- Returns -1.
; Author ........: Matwachich
; Modified ......: JScript
; Remarks .......: Usefull when you change the data of the comboBox with the default AutoIt functions, and you want to update
;				  |the auto-fill data.
; Related .......:
; Link ..........:
; Example .......: No
; ===============================================================================================================================
Func _GUICtrlComboBox_AutoFillUpdateContent($hWnd)
	Local $iIndex, $iCount

	$iIndex = __CBA_GetHWndIndex($hWnd)
	If Not $iIndex Then Return -1

	$aList = _GUICtrlComboBox_GetListArray($hWnd)
	$iCount = $aList[0]

	;----> Update array with the new item!
	$avCBA_MSGIDS[$iIndex][2] = $iCount
	$avCBA_MSGIDS[$iIndex][3] = $aList
	;<----
	Return $iCount
EndFunc   ;==>_GUICtrlComboBox_AutoFillUpdateContent

; #FUNCTION# ====================================================================================================================
; Name ..........: _GUICtrlComboBox_AutoFillDelete
; Description ...: Remove AutoFill control.
; Syntax ........: _GUICtrlComboBox_AutoFillDelete($hWnd)
; Parameters ....: $hWnd                - Control ID/Handle to the control.
; Return values .: Success 	 			- Returns 1.
;				   Failure 	 			- Returns 0.
; Author ........: JScript
; Modified ......:
; Remarks .......:
; Related .......:
; Link ..........:
; Example .......: No
; ===============================================================================================================================
Func _GUICtrlComboBox_AutoFillDelete($hWnd)
	Local $iIndex

	$iIndex = __CBA_GetHWndIndex($hWnd)
	If Not $iIndex Then Return 0

	For $i = $iIndex To UBound($avCBA_MSGIDS) - 2
		For $j = 0 To 5
			$avCBA_MSGIDS[$i][$j] = $avCBA_MSGIDS[$i + 1][$j]
		Next
	Next
	ReDim $avCBA_MSGIDS[$avCBA_MSGIDS[0][0]][6]
	$avCBA_MSGIDS[0][0] -= 1

	Return 1
EndFunc   ;==>_GUICtrlComboBox_AutoFillDelete

; #INTERNAL_USE_ONLY# ===========================================================================================================
; Name ..........: __CBA_AutoFill
; Description ...:
; Syntax ........: __CBA_AutoFill($hWnd, $sBuffer, $aList)
; Parameters ....: $hWnd                - A handle value.
;                  $sBuffer             - A string value.
;                  $aList               - An array of combo list.
; Return values .: None
; Author ........: JScript
; Modified ......:
; Remarks .......:
; Related .......:
; Link ..........:
; Example .......: No
; ===============================================================================================================================
Func __CBA_AutoFill($hWnd, $sBuffer, $aList, $lSearchMode)
	Local $sStrLower, $iStrLeft, $iIndex

	$sBuffer = StringLower($sBuffer)
	_GUICtrlComboBox_BeginUpdate($hWnd)
	For $i = 1 To $aList[0]
		$sStrLower = StringLower($aList[$i])
		$iStrLeft = StringLeft($sStrLower, StringLen($sBuffer))

		$iIndex = _GUICtrlComboBox_FindStringExact($hWnd, $aList[$i])
		Switch $lSearchMode
			Case True
				If StringInStr($sStrLower, $sBuffer) Then
					If $iIndex = -1 Then
						_GUICtrlComboBox_AddString($hWnd, $aList[$i])
					EndIf
				Else
					If $iIndex > -1 Then
						_GUICtrlComboBox_DeleteString($hWnd, $iIndex)
					EndIf
				EndIf
			Case Else
				If $iStrLeft = $sBuffer Then
					If $iIndex = -1 Then
						_GUICtrlComboBox_AddString($hWnd, $aList[$i])
					EndIf
				Else
					If $iIndex > -1 Then
						_GUICtrlComboBox_DeleteString($hWnd, $iIndex)
					EndIf
				EndIf
		EndSwitch
	Next
	_GUICtrlComboBox_EndUpdate($hWnd)
EndFunc   ;==>__CBA_AutoFill

; #INTERNAL_USE_ONLY# ===========================================================================================================
; Name ..........: __CBA_WM_COMMAND
; Description ...:
; Syntax ........: __CBA_WM_COMMAND($hWinWnd, $iMsg, $iwParam, $lParam)
; Parameters ....: $hWinWnd             - A handle value.
;                  $iMsg                - An integer value.
;                  $iwParam             - An integer value.
;                  $lParam              - An unknown value.
; Return values .: None
; Author ........: JScript
; Modified ......:
; Remarks .......:
; Related .......:
; Link ..........:
; Example .......: No
; ===============================================================================================================================
Func __CBA_WM_COMMAND($hWinWnd, $iMsg, $iwParam, $lParam)
	#forceref $hWinWnd, $iMsg
	Local $iCode = _WinAPI_HiWord($iwParam)
	Local $hWnd = _WinAPI_GetParent($lParam)

	Switch $iCode
		Case $EN_CHANGE
			Local $iIndex = __CBA_GetHWndIndex($hWnd)
			Local $iCount = $avCBA_MSGIDS[$iIndex][2]
			Local $aList = $avCBA_MSGIDS[$iIndex][3]
			Local $iVisible = $avCBA_MSGIDS[$iIndex][4]
			Local $lSearchMode = $avCBA_MSGIDS[$iIndex][5]

			Switch $iCount
				Case 0
					$aList = _GUICtrlComboBox_GetListArray($hWnd)
					If $aList[0] > 1 Then $iCount = $aList[0]
					$avCBA_MSGIDS[$iIndex][2] = $iCount
					$avCBA_MSGIDS[$iIndex][3] = $aList
				Case Else
					_GUICtrlMsg_UnRegister($hWnd, $WM_COMMAND)
					;
					Local $sBuffer = _GUICtrlComboBox_GetEditText($hWnd)
					If $sBuffer Then
						__CBA_AutoFill($hWnd, $sBuffer, $aList, $lSearchMode)
					Else
						_GUICtrlComboBox_ResetContent($hWnd)
						For $i = 1 To $aList[0]
							_GUICtrlComboBox_AddString($hWnd, $aList[$i])
						Next
					EndIf
					;$iVisible = _GUICtrlComboBox_GetMinVisible($hWnd)
					$iCount = _GUICtrlComboBox_GetCount($hWnd)
					If $iCount < $iVisible Then
						_GUICtrlComboBox_SetMinVisible($hWnd, $iCount)
					Else
						_GUICtrlComboBox_SetMinVisible($hWnd, $iVisible)
					EndIf
					_GUICtrlComboBox_ShowDropDown($hWnd, True)
					_GUICtrlComboBox_SetEditText($hWnd, $sBuffer)
					_GUICtrlComboBox_AutoComplete($hWnd)
					;
					Return _GUICtrlMsg_Register($hWnd, $WM_COMMAND, "__CBA_WM_COMMAND")
			EndSwitch
	EndSwitch
	Return $GUI_RUNDEFMSG
EndFunc   ;==>__CBA_WM_COMMAND

; #INTERNAL_USE_ONLY# ===========================================================================================================
; Name ..........: __CBA_GetHWndIndex
; Description ...:
; Syntax ........: __CBA_GetHWndIndex($hWnd)
; Parameters ....: $hWnd             - A handle value.
; Return values .: None
; Author ........: JScript
; Modified ......:
; Remarks .......:
; Related .......:
; Link ..........:
; Example .......: No
; ===============================================================================================================================
Func __CBA_GetHWndIndex($hWnd)
	If $avCBA_MSGIDS[0][0] Then
		For $iIndex = 1 To $avCBA_MSGIDS[0][0]
			Switch $hWnd
				Case $avCBA_MSGIDS[$iIndex][0]
					Return $iIndex
			EndSwitch
		Next
	EndIf
	Return 0
EndFunc   ;==>__CBA_GetHWndIndex