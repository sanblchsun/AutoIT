
Global $Debug_Ed = False
Global $Debug_LV = False
HotKeySet("{F2}", "_VistaRename")

;добавлено переименование с раширением
HotKeySet("+{F2}", "_Rename")

While 1
	Sleep(100)
WEnd

;добавлено переименование с раширением
Func _Rename()
	HotKeySet("{F2}")
	Sleep(100)
			Send("{F2}")
	Sleep(100)
	HotKeySet("{F2}", "_VistaRename")
EndFunc   ;==>_Rename

Func _VistaRename()
	HotKeySet("{F2}")
	Local $sClass = _WinAPI_GetClassName(WinGetHandle("[ACTIVE]")), $sFile, $hListView, $hFileEdit
	If StringInstr("|ExploreWClass|CabinetWClass|Progman|", "|" & $sClass & "|") > 0 Then
		$hActiveControl = ControlGetHandle("[ACTIVE]", "", ControlGetFocus("[ACTIVE]"))
		If _WinAPI_GetClassName($hActiveControl) = "SysListView32" Then
			$hFileEdit = _GUICtrlListView_EditLabel($hActiveControl, _GUICtrlListView_GetNextItem($hActiveControl))
			$sFile = _GUICtrlEdit_GetText($hFileEdit)
			_GUICtrlEdit_SetSel($hFileEdit, 0, StringInStr($sFile, ".", 0, -1) - 1)
		Else
			Send("{F2}")
		EndIf
	Else
		Send("{F2}")
	EndIf
	HotKeySet("{F2}", "_VistaRename")
EndFunc   ;==>_VistaRename

Func _WinAPI_GetClassName($hWnd)
	Local $aResult
	If Not IsHWnd($hWnd) Then $hWnd = GUICtrlGetHandle($hWnd)
	$aResult = DllCall("User32.dll", "int", "GetClassName", "hwnd", $hWnd, "str", "", "int", 4096)
	Return $aResult[2]
EndFunc   ;==>_WinAPI_GetClassName

Func _GUICtrlEdit_GetText($hWnd)
	If $Debug_Ed Then _GUICtrlEdit_ValidateClassName($hWnd)
	If Not IsHWnd($hWnd) Then $hWnd = GUICtrlGetHandle($hWnd)
	Local $iTextLen = _GUICtrlEdit_GetTextLen($hWnd) + 1
	Local $tText = DllStructCreate("char Text[" & $iTextLen & "]")
	_SendMessage($hWnd, 0x000D, $iTextLen, DllStructGetPtr($tText), 0, "wparam", "ptr")
	Return DllStructGetData($tText, "Text")
EndFunc   ;==>_GUICtrlEdit_GetText

Func _GUICtrlEdit_SetSel($hWnd, $iStart, $iEnd)
	If $Debug_Ed Then _GUICtrlEdit_ValidateClassName($hWnd)
	If Not IsHWnd($hWnd) Then $hWnd = GUICtrlGetHandle($hWnd)
	_SendMessage($hWnd, 0xB1, $iStart, $iEnd)
EndFunc   ;==>_GUICtrlEdit_SetSel

Func _GUICtrlListView_EditLabel($hWnd, $iIndex)
	If $Debug_LV Then _GUICtrlListView_ValidateClassName($hWnd)
	If IsHWnd($hWnd) Then
		DllCall("User32.dll", "hwnd", "SetFocus", "hwnd", $hWnd)
		If @AutoItUnicode Then
			Return _SendMessage($hWnd, 0x1000 + 118, $iIndex, 0, 0, "wparam", "lparam", "hwnd")
		Else
			Return _SendMessage($hWnd, 0x1000 + 23, $iIndex, 0, 0, "wparam", "lparam", "hwnd")
		EndIf
	Else
		DllCall("User32.dll", "hwnd", "SetFocus", "hwnd", GUICtrlGetHandle($hWnd))
		If @AutoItUnicode Then
			Return GUICtrlSendMsg($hWnd, 0x1000 + 118, $iIndex, 0)
		Else
			Return GUICtrlSendMsg($hWnd, 0x1000 + 23, $iIndex, 0)
		EndIf
	EndIf
EndFunc   ;==>_GUICtrlListView_EditLabel

Func _GUICtrlListView_GetNextItem($hWnd, $iStart = -1, $iSearch = 0, $iState = 8)
	If $Debug_LV Then _GUICtrlListView_ValidateClassName($hWnd)
	Local $iFlags, $aSearch[5] = [0x0000, 0x0100, 0x0200, 0x0400, 0x0800]
	$iFlags = $aSearch[$iSearch]
	If BitAND($iState, 1) <> 0 Then $iFlags = BitOR($iFlags, 0x0004)
	If BitAND($iState, 2) <> 0 Then $iFlags = BitOR($iFlags, 0x0008)
	If BitAND($iState, 4) <> 0 Then $iFlags = BitOR($iFlags, 0x0001)
	If BitAND($iState, 8) <> 0 Then $iFlags = BitOR($iFlags, 0x0002)
	If IsHWnd($hWnd) Then
		Return _SendMessage($hWnd, 0x1000 + 12, $iStart, $iFlags)
	Else
		Return GUICtrlSendMsg($hWnd, 0x1000 + 12, $iStart, $iFlags)
	EndIf
EndFunc   ;==>_GUICtrlListView_GetNextItem

Func _SendMessage($hWnd, $iMsg, $wParam = 0, $lParam = 0, $iReturn = 0, $wParamType = "wparam", $lParamType = "lparam", $sReturnType = "lparam")
	Local $aResult = DllCall("user32.dll", $sReturnType, "SendMessage", "hwnd", $hWnd, "int", $iMsg, $wParamType, $wParam, $lParamType, $lParam)
	If @error Then Return SetError(@error, @extended, "")
	If $iReturn >= 0 And $iReturn <= 4 Then Return $aResult[$iReturn]
	Return $aResult
EndFunc   ;==>_SendMessage

Func _GUICtrlEdit_GetTextLen($hWnd)
	If $Debug_Ed Then _GUICtrlEdit_ValidateClassName($hWnd)
	If Not IsHWnd($hWnd) Then $hWnd = GUICtrlGetHandle($hWnd)
	Return _SendMessage($hWnd, 0x000E)
EndFunc   ;==>_GUICtrlEdit_GetTextLen

Func _GUICtrlEdit_ValidateClassName($hWnd)
	_GUICtrlEdit_DebugPrint("This is for debugging only, set the debug variable to false before submitting")
	_WinAPI_ValidateClassName($hWnd, "Edit")
EndFunc   ;==>_GUICtrlEdit_ValidateClassName

Func _GUICtrlListView_ValidateClassName($hWnd)
	_GUICtrlListView_DebugPrint("This is for debugging only, set the debug variable to false before submitting")
	_WinAPI_ValidateClassName($hWnd, "SysListView32")
EndFunc   ;==>_GUICtrlListView_ValidateClassName

Func _WinAPI_ValidateClassName($hWnd, $sClassNames)
	Local $aClassNames, $sSeperator = Opt("GUIDataSeparatorChar"), $sText
	If Not _WinAPI_IsClassName($hWnd, $sClassNames) Then
		$aClassNames = StringSplit($sClassNames, $sSeperator)
		For $x = 1 To $aClassNames[0]
			$sText &= $aClassNames[$x] & ", "
		Next
		$sText = StringTrimRight($sText, 2)
		_WinAPI_ShowError("Invalid Class Type(s):" & @LF & @TAB & _
				"Expecting Type(s): " & $sText & @LF & @TAB & _
				"Received Type : " & _WinAPI_GetClassName($hWnd))
	EndIf
EndFunc   ;==>_WinAPI_ValidateClassName

Func _GUICtrlEdit_DebugPrint($sText, $iLine = @ScriptLineNumber)
	ConsoleWrite( _
			"!===========================================================" & @LF & _
			"+======================================================" & @LF & _
			"-->Line(" & StringFormat("%04d", $iLine) & "):" & @TAB & $sText & @LF & _
			"+======================================================" & @LF)
EndFunc   ;==>_GUICtrlEdit_DebugPrint

Func _GUICtrlListView_DebugPrint($sText, $iLine = @ScriptLineNumber)
	ConsoleWrite( _
			"!===========================================================" & @LF & _
			"+======================================================" & @LF & _
			"-->Line(" & StringFormat("%04d", $iLine) & "):" & @TAB & $sText & @LF & _
			"+======================================================" & @LF)
EndFunc   ;==>_GUICtrlListView_DebugPrint

Func _WinAPI_IsClassName($hWnd, $sClassName)
	Local $sSeperator, $aClassName, $sClassCheck
	$sSeperator = Opt("GUIDataSeparatorChar")
	$aClassName = StringSplit($sClassName, $sSeperator)
	If Not IsHWnd($hWnd) Then $hWnd = GUICtrlGetHandle($hWnd)
	$sClassCheck = _WinAPI_GetClassName($hWnd)
	For $x = 1 To UBound($aClassName) - 1
		If StringUpper(StringMid($sClassCheck, 1, StringLen($aClassName[$x]))) = StringUpper($aClassName[$x]) Then
			Return True
		EndIf
	Next
	Return False
EndFunc   ;==>_WinAPI_IsClassName

Func _WinAPI_ShowError($sText, $fExit = True)
	_WinAPI_MsgBox(266256, "Error", $sText)
	If $fExit Then Exit
EndFunc   ;==>_WinAPI_ShowError

Func _WinAPI_MsgBox($iFlags, $sTitle, $sText)
	BlockInput(0)
	MsgBox($iFlags, $sTitle, $sText & " ")
EndFunc   ;==>_WinAPI_MsgBox
