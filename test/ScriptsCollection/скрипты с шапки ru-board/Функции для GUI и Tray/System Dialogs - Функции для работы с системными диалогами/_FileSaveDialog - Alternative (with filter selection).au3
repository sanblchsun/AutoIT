
$hWnd = WinGetHandle("")
$sFilter = "Text File (*.txt)|*.txt|AutoIt v3 Script (*.au3)|*.au3|AutoIt3X Files (*.a3x)|*.a3x|All (*.*)|*.*"

$Ret = _FileSaveDialog("Save as", "C:\", $sFilter, 18, "New Script", 2, $hWnd)

If Not @error Then MsgBox(64, "Results", StringFormat("Saved as: %s\n\nSelected Filter Index: %d", $Ret, @extended))

Func _FileSaveDialog($sTitle, $sInitDir, $sFilter = 'All (*.*)', $iOpt = 0, $sDefFile = '', $iDefFilter = 1, $hWnd = 0)
	Local $iFileLen = 65536 ; Max chars in returned string
	
	; API flags prepare
	Local $iFlag = BitOR(BitShift(BitAND($iOpt, 2), -10), BitShift(BitAND($iOpt, 16), 3))
	
	; Filter string to array convertion
	If Not StringInStr($sFilter, '|') Then $sFilter &= '|*.*'
	$sFilter = StringRegExpReplace($sFilter, '|+', '|')
	
	Local $asFLines = StringSplit($sFilter, '|')
	Local $i, $suFilter = ''

	For $i = 1 To $asFLines[0] Step 2
		If $i < $asFLines[0] Then _
			$suFilter &= 'byte[' & StringLen($asFLines[$i]) + 1 & '];char[' & StringLen($asFLines[$i + 1]) + 1 & '];'
	Next
	
	; Create API structures
	Local $uOFN = DllStructCreate('dword;int;int;ptr;ptr;dword;dword;ptr;dword' & _
			';ptr;int;ptr;ptr;dword;short;short;ptr;ptr;ptr;ptr;ptr;dword;dword')
	Local $usTitle = DllStructCreate('char[' & StringLen($sTitle) + 1 & ']')
	Local $usInitDir = DllStructCreate('char[' & StringLen($sInitDir) + 1 & ']')
	Local $usFilter = DllStructCreate($suFilter & 'byte')
	Local $usFile = DllStructCreate('char[' & $iFileLen & ']')
	Local $usExtn = DllStructCreate('char[1]')

	For $i = 1 To $asFLines[0]
		DllStructSetData($usFilter, $i, $asFLines[$i])
	Next
	
	; Set Data of API structures
	DllStructSetData($usTitle, 1, $sTitle)
	DllStructSetData($usInitDir, 1, $sInitDir)
	DllStructSetData($usFile, 1, $sDefFile)
	DllStructSetData($usExtn, 1, "")
	DllStructSetData($uOFN, 1, DllStructGetSize($uOFN))
	DllStructSetData($uOFN, 2, $hWnd)
	DllStructSetData($uOFN, 4, DllStructGetPtr($usFilter))
	DllStructSetData($uOFN, 7, $iDefFilter)
	DllStructSetData($uOFN, 8, DllStructGetPtr($usFile))
	DllStructSetData($uOFN, 9, $iFileLen)
	DllStructSetData($uOFN, 12, DllStructGetPtr($usInitDir))
	DllStructSetData($uOFN, 13, DllStructGetPtr($usTitle))
	DllStructSetData($uOFN, 14, $iFlag)
	DllStructSetData($uOFN, 17, DllStructGetPtr($usExtn))
	DllStructSetData($uOFN, 23, BitShift(BitAND($iOpt, 32), 5))
	
	;Set Timer to check FileName Input for file extension
	Local $hCallBack = DllCallbackRegister("_Check_FSD_Input", "none", "hwnd;int;int;dword")
	Local $ahTimer = DllCall("user32.dll", "int", "SetTimer", "hwnd", 0, _
		"int", TimerInit(), "int", 100, "ptr", DllCallbackGetPtr($hCallBack))
	
	; Call API function
	Local $aRet = DllCall('comdlg32.dll', 'int', 'GetSaveFileName', 'ptr', DllStructGetPtr($uOFN))
	
	;Free CallBack and kill the timer
	DllCallBackFree($hCallBack)
	DllCall("user32.dll", "int", "KillTimer", "hwnd", 0, "int", $ahTimer)
	
	If Not IsArray($aRet) Or Not $aRet[0] Then Return SetError(1, 0, "")
	
	;Return Results
	Local $sRet = StringStripWS(DllStructGetData($usFile, 1), 3)
	Return SetExtended(DllStructGetData($uOFN, 7), $sRet) ;@extended is the 1-based index of selected filter
EndFunc   ;==>_FileSaveDialog

Func _Check_FSD_Input($hWndGUI, $MsgID, $WParam, $LParam)
	Local $sSaveAs_hWnd = _WinGetHandleEx(@AutoItPID, "#32770", "", "FolderView")
	
	If ControlGetFocus($sSaveAs_hWnd) = "Edit1" Then Return
	
	Local $sEdit_Data = ControlGetText($sSaveAs_hWnd, "", "Edit1")
	Local $sFilter_Ext = ControlCommand($sSaveAs_hWnd, "", "ComboBox3", "GetCurrentSelection")
	$sFilter_Ext = StringRegExpReplace($sFilter_Ext, ".*\(\*(.*?)\)$", "\1")
	
	If $sFilter_Ext = ".*" Then
		$sFilter_Ext = ""
	ElseIf Not StringInStr($sFilter_Ext, ".") Then
		Return
	EndIf
	
	Local $sEdit_Ext = StringRegExpReplace($sEdit_Data, "^.*\.", ".")
	
	If $sEdit_Ext <> $sFilter_Ext And ($sEdit_Ext <> $sEdit_Data Or $sFilter_Ext <> "") Then
		$sEdit_Data = StringRegExpReplace($sEdit_Data, "\.[^.]*$", "")
		ControlSetText($sSaveAs_hWnd, "", "Edit1", $sEdit_Data & $sFilter_Ext)
	EndIf
EndFunc   ;==>_Check_FSD_Input

Func _WinGetHandleEx($iPID, $sClassNN="", $sPartTitle="", $sText="", $iVisibleOnly=1)
	If IsString($iPID) Then $iPID = ProcessExists($iPID)
	
	Local $aWList = WinList("[CLASS:" & $sClassNN & ";REGEXPTITLE:(?i).*" & $sPartTitle & ".*]", $sText)
	If @error Then Return SetError(1, 0, "")
	
	For $i = 1 To $aWList[0][0]
		If WinGetProcess($aWList[$i][1]) = $iPID And (Not $iVisibleOnly Or _
			($iVisibleOnly And BitAND(WinGetState($aWList[$i][1]), 2))) Then Return $aWList[$i][1]
	Next
	
	Return SetError(2, 0, "")
EndFunc   ;==>_WinGetHandleEx
