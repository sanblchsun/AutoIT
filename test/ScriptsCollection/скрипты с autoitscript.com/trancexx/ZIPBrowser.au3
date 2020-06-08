#AutoIt3Wrapper_Au3Check_Parameters=-d -w 1 -w 2 -w 3 -w 4 -w 5 -w 6


; ZIP BROWSER
;.......script written by trancexx (trancexx at yahoo dot com)

Opt("WinWaitDelay", 0) ; 0 ms

HotKeySet("{ESC}", "_ZIPBrowser_Quit")
Func _ZIPBrowser_Quit()
	Exit
EndFunc   ;==>_ZIPBrowser_Quit

; DLLs to use
Global Const $hKERNEL32 = DllOpen("kernel32.dll")
Global Const $hCOMCTL32 = DllOpen("comctl32.dll")
Global Const $hUSER32 = DllOpen("user32.dll")
Global Const $hSHELL32 = DllOpen("shell32.dll")

; GUI
Global $hGUI = GUICreate("ZIP Browser ", 500, 500, -1, -1, 0xCF0000, 16) ; WS_OVERLAPPEDWINDOW, $WS_EX_ACCEPTFILES
GUISetIcon(@SystemDir & "\zipfldr.dll")
Global $hTreeViewZIP = GUICtrlCreateTreeView(10, 10, 480, 420, 63)
GUICtrlSetResizing(-1, 102)
Global $hButtonBrowse = GUICtrlCreateButton("&Open", 20, 455, 70, 25)
GUICtrlSetResizing(-1, 834)
GUICtrlSetTip(-1, "Browse for ZIP")
Global $hButtonClose = GUICtrlCreateButton("Cl&ose", 365, 455, 90, 25)
GUICtrlSetResizing(-1, 836)
GUICtrlSetTip(-1, "Close this window")
HotKeySet("{F5}", "_ZIPBrowser_ShakeIt")
Global $hDots = _ZIPBrowser_CreateDragDots($hGUI)
; Additional win message processing
GUIRegisterMsg(5, "_ZIPBrowser_WM_SIZE") ; WM_SIZE
GUIRegisterMsg(36, "_ZIPBrowser_WM_GETMINMAXINFO") ; WM_GETMINMAXINFO
GUIRegisterMsg(563, "_ZIPBrowser_WM_DROPFILES") ; WM_DROPFILES
; Show the GUI
GUISetState()

Global $sZip ; zip file to load
If @Compiled Then $sZip = StringReplace($CmdLineRaw, '"', "")

While 1
	Switch GUIGetMsg()
		Case -3, $hButtonClose
			Exit
		Case $hButtonBrowse
			$sZip = FileOpenDialog("ZIP Browser ", "", "ZIP(*.zip)|All files(*)", 1, "", $hGUI)
	EndSwitch
	If $sZip Then
		GUISetCursor(15, 1)
		GUISetState(@SW_LOCK, $hGUI)
		_ZIPBrowser_ShowZIP($sZip, $hTreeViewZIP, $hGUI)
		If @error Then _ZIPBrowser_MessageBeep(48)
		GUISetState(@SW_UNLOCK, $hGUI)
		GUISetCursor(-1)
		GUICtrlSetData($hButtonBrowse, "&New")
		$sZip = ""
	EndIf
WEnd

; The End


; FUNCTIONS:

Func _ZIPBrowser_ShowZIP($sFileZIP, $hTreeViewControl, $hParent)
	Local $iZipFileSize = FileGetSize($sFileZIP)
	Local $iStartingPos = 0
	If $iZipFileSize > 65536 Then $iStartingPos = $iZipFileSize - 65536
	Local $hFile = FileOpen($sFileZIP, 16)
	If FileRead($hFile, 2) <> 0x4B50 Then ; ZIP signature
		FileClose($hFile)
		Return SetError(1)
	EndIf
	FileSetPos($hFile, $iStartingPos, 0)
	Local $bBinary = FileRead($hFile)
	FileClose($hFile)
	Local $sOrgString = _ZIPBrowser_GetZIPString($bBinary)
	If @error Then Return SetError(2)
	Local $iDim1, $iDim2
	Local $aAr1, $aAr2
	; Determine the size of the resulting array (to avoid thousand ReDims)
	$aAr1 = StringSplit($sOrgString, @LF, 2)
	For $i = 0 To UBound($aAr1) - 1
		$aAr2 = StringRegExp($aAr1[$i], "(.*?/)|.+\z", 3)
		For $j = 0 To UBound($aAr2) - 1
			If $j > $iDim2 Then $iDim2 = $j
		Next
		$iDim1 = $i
	Next
	; Check if valid
	If Not $iDim1 Then Return SetError(3)
	; Make the array
	Local $aItems[$iDim1][$iDim2 + 1]
	; Populate it now
	$aAr1 = StringSplit($sOrgString, @LF, 2)
	For $i = 0 To UBound($aAr1) - 1
		$aAr2 = StringRegExp($aAr1[$i], "(.*?/)|.+\z", 3)
		For $j = 0 To UBound($aAr2) - 1
			$aItems[$i][$j] = $aAr2[$j]
		Next
	Next
	; Clear old treeview
	_ZIPBrowser_RebuildTreeView($hTreeViewControl)
	GUICtrlSetImage($hTreeViewControl, @SystemDir & "\shell32.dll", 4)
	; Populate new treeview
	Local $fDontSkip
	Local $aControls = $aItems, $hParentControl
	; Get handle of treeview's image list
	Local $hImageListTreeView = GUICtrlSendMsg($hTreeViewControl, 4360, 0, 0) ; TVM_GETIMAGELIST, TVSIL_NORMAL
	Local $tTVITEM = DllStructCreate("dword Mask;" & _
			"handle Item;" & _
			"dword State;" & _
			"dword StateMask;" & _
			"ptr Text;" & _
			"int TextMax;" & _
			"int Image;" & _
			"int SelectedImage;" & _
			"int Children;" & _
			"lparam Param")
	Local $pTVITEM = DllStructGetPtr($tTVITEM)
	; Set wanted mask
	DllStructSetData($tTVITEM, "Mask", 34) ; TVIF_IMAGE|TVIF_SELECTEDIMAGE
	Local $hNewIconIndex
	; Start filling the control
	;GUICtrlSendMsg($hTreeViewControl, 11, 0, 0) ; disable treeview changes (not needed since I have the gui locked)
	For $m = 0 To $iDim2
		For $i = 0 To UBound($aItems) - 1
			If $aItems[$i][$m] Then
				$fDontSkip = True
				For $j = $i - 1 To 0 Step -1
					If Not $aItems[$j][$m] Then ExitLoop
					If $aItems[$i][$m] = $aItems[$j][$m] Then
						$fDontSkip = False
						ExitLoop
					EndIf
				Next
				If $fDontSkip Then
					For $n = 0 To $m
						If $m = $n Then
							If $m = 0 Then
								$hParentControl = $hTreeViewControl
							Else
								For $x = $i To 0 Step -1
									If IsNumber($aControls[$x][$m - 1]) And StringInStr($aItems[$x][$m - 1], "/") Then ExitLoop ; indicates real, folder control
								Next
								$hParentControl = $aControls[$x][$m - 1]
							EndIf
							$aControls[$i][$n] = GUICtrlCreateTreeViewItem(_ZIPBrowser_MultiByteToWideChar(StringReplace($aItems[$i][$n], "/", "")), $hParentControl)
							If StringRight($aItems[$i][$n], 1) <> "/" Then
								; using associative array approach for determining icon indexes
								$hNewIconIndex = _ZIPBrowser_GetSetImageListIcon(StringRegExpReplace($aItems[$i][$n], ".*\.", ""), $hImageListTreeView)
								DllStructSetData($tTVITEM, "Image", $hNewIconIndex)
								DllStructSetData($tTVITEM, "SelectedImage", $hNewIconIndex)
								DllStructSetData($tTVITEM, "Item", GUICtrlGetHandle(-1))
								; Set it to the control
								GUICtrlSendMsg($hTreeViewControl, 4415, 0, $pTVITEM) ; $TVM_SETITEMW
							EndIf
						EndIf
					Next
				EndIf
			EndIf
		Next
	Next
	;GUICtrlSendMsg($hTreeViewControl, 11, 1, 0) ; enable treeview changes
	; Reset 'ImageList String'
	_ZIPBrowser_GetSetImageListIcon(0, 0, True)
	WinSetTitle($hParent, 0, "ZIP Browser - " & StringRegExpReplace($sZip, ".*\\", ""))
	Return 1 ; success
EndFunc   ;==>_ZIPBrowser_ShowZIP

Func _ZIPBrowser_GetSetImageListIcon($sString, $hImageListTreeView, $fReset = False)
	Local Static $sIcons = ";"
	If $fReset Then $sIcons = ";"
	Local $aArray = StringRegExp($sIcons, "(?i);(\d+)\|" & $sString & ";", 3)
	If @error Then
		Local $hIconNew = _ZIPBrowser_GetFileIcon("x." & $sString) ; file's associated icon (only extension is important)
		Local $hNewIconIndex = _ZIPBrowser_ImageList_ReplaceIcon($hImageListTreeView, -1, $hIconNew) ; add it to the imagelist
		_ZIPBrowser_DestroyIcon($hIconNew) ; not needed anymore
		$sIcons &= $hNewIconIndex & "|" & $sString & ";"
		Return $hNewIconIndex
	EndIf
	Return $aArray[0]
EndFunc   ;==>_ZIPBrowser_GetSetImageListIcon

Func _ZIPBrowser_GetZIPString($bBinary)
	Local $iLenBinary = BinaryLen($bBinary)
	Local $iStartOffset = $iLenBinary - 65535 ; limiting allowed size of Central directory to 65536 bytes
	If $iStartOffset < 1 Then $iStartOffset = 1
	Local $iOffset = StringInStr(BinaryToString(BinaryMid($bBinary, $iStartOffset)), BinaryToString("0x504B0102"), 1) ; Central directory signature
	If Not $iOffset Then Return SetError(1)
	Local $tData = DllStructCreate("byte[" & $iLenBinary - $iOffset & "]")
	DllStructSetData($tData, 1, BinaryMid($bBinary, $iOffset + $iStartOffset - 1))
	Local $pPointer = DllStructGetPtr($tData)
	Local $sOut
	While 1
		Local $tZipCentral = DllStructCreate("dword Signature;" & _
				"word VMadeBy;" & _
				"word VToextract;" & _
				"word GPFlag;" & _
				"word Method;" & _
				"word LastModTime;" & _
				"word LastModDate;" & _
				"dword CRC32;" & _
				"dword CompressedSize;" & _
				"dword UncompressedSize;" & _
				"word NameLength;" & _
				"word ExtraFieldLength;" & _
				"word CommentLength;" & _
				"word DiskNumstart;" & _
				"word InternalAttrib;" & _
				"dword ExternalAttrib;" & _
				"dword LocalHeader;", _
				$pPointer)
		$pPointer += 46 ; size of $tZipCentral
		If DllStructGetData($tZipCentral, "Signature") <> 33639248 Then ExitLoop ; Central directory signature (dword form)
		If DllStructGetData($tZipCentral, "NameLength") Then $sOut &= DllStructGetData(DllStructCreate("char Filename[" & DllStructGetData($tZipCentral, "NameLength") & "]", $pPointer), "Filename") & @LF
		$pPointer += DllStructGetData($tZipCentral, "NameLength")
		$pPointer += DllStructGetData($tZipCentral, "ExtraFieldLength")
		$pPointer += DllStructGetData($tZipCentral, "CommentLength")
	WEnd
	Return $sOut
EndFunc   ;==>_ZIPBrowser_GetZIPString

Func _ZIPBrowser_MultiByteToWideChar($sText)
	Local $aCall = DllCall($hKERNEL32, "int", "MultiByteToWideChar", _
			"dword", 1, _ ; CP_OEMCP
			"dword", 0, _
			"str", $sText, _
			"int", -1, _ ; null-terminated
			"wstr", 0, _
			"int", 65536)
	If @error Or Not $aCall[0] Then Return SetError(1, 0, $sText)
	Return $aCall[5]
EndFunc   ;==>_ZIPBrowser_MultiByteToWideChar

Func _ZIPBrowser_RebuildTreeView(ByRef $hTreeViewControl)
	Local $aTreeViewPos = ControlGetPos($hGUI, 0, $hTreeViewControl)
	GUICtrlDelete($hTreeViewControl)
	$hTreeViewControl = GUICtrlCreateTreeView($aTreeViewPos[0], $aTreeViewPos[1], $aTreeViewPos[2], $aTreeViewPos[3], 63)
	GUICtrlSendMsg($hTreeViewControl, 4379, 18, 0) ; set size
	GUICtrlSetResizing($hTreeViewControl, 102)
EndFunc   ;==>_ZIPBrowser_RebuildTreeView

Func _ZIPBrowser_DestroyIcon($hIcon)
	Local $aCall = DllCall($hUSER32, "bool", "DestroyIcon", "handle", $hIcon)
	If @error Or Not $aCall[0] Then Return SetError(1, 0, 0)
	Return 1
EndFunc   ;==>_ZIPBrowser_DestroyIcon

Func _ZIPBrowser_ImageList_ReplaceIcon($hImageList, $iIndex, $hIcon)
	Local $aCall = DllCall($hCOMCTL32, "int", "ImageList_ReplaceIcon", _
			"handle", $hImageList, _
			"int", $iIndex, _
			"handle", $hIcon)
	If @error Or $aCall[0] = -1 Then Return SetError(1, 0, 0)
	Return $aCall[0]
EndFunc   ;==>_ZIPBrowser_ImageList_ReplaceIcon

Func _ZIPBrowser_GetFileIcon($sFile)
	Local $tSHFILEINFOW = DllStructCreate("handle Icon;" & _
			"int IconIndex;" & _
			"dword Attributes;" & _
			"wchar DisplayName[260];" & _
			"wchar TypeName[80]")
	DllCall($hSHELL32, "dword_ptr", "SHGetFileInfoW", _
			"wstr", $sFile, _
			"dword", 0, _
			"ptr", DllStructGetPtr($tSHFILEINFOW), _
			"dword", DllStructGetSize($tSHFILEINFOW), _
			"dword", 0x111) ; SHGFI_ICON | SHGFI_USEFILEATTRIBUTES | SHGFI_SMALLICON
	Return DllStructGetData($tSHFILEINFOW, "Icon")
EndFunc   ;==>_ZIPBrowser_GetFileIcon

Func _ZIPBrowser_CreateDragDots($hGUI)
	Local $aCall = DllCall($hUSER32, "hwnd", "CreateWindowExW", _
			"dword", 0, _
			"wstr", "Scrollbar", _
			"ptr", 0, _
			"dword", 0x50000018, _ ; $WS_CHILD|$WS_VISIBLE|$SBS_SIZEBOX|$SBS_SIZEBOXOWNERDRAWFIXED
			"int", 0, _
			"int", 0, _
			"int", 17, _ ; Width
			"int", 17, _ ; Height
			"hwnd", $hGUI, _
			"hwnd", 0, _
			"hwnd", 0, _
			"int", 0)
	If @error Or Not $aCall[0] Then Return SetError(1, 0, 0)
	Return $aCall[0]
EndFunc   ;==>_ZIPBrowser_CreateDragDots

Func _ZIPBrowser_DragQueryFile($hDrop, $iIndex = 0)
	Local $aCall = DllCall($hSHELL32, "dword", "DragQueryFileW", _
			"handle", $hDrop, _
			"dword", $iIndex, _
			"wstr", "", _
			"dword", 32767)
	If @error Or Not $aCall[0] Then Return SetError(1, 0, "")
	Return $aCall[3]
EndFunc   ;==>_ZIPBrowser_DragQueryFile

Func _ZIPBrowser_DragFinish($hDrop)
	DllCall($hSHELL32, "none", "DragFinish", "handle", $hDrop)
EndFunc   ;==>_ZIPBrowser_DragFinish

Func _ZIPBrowser_MessageBeep($iType)
	DllCall($hUSER32, "int", "MessageBeep", "dword", $iType)
EndFunc   ;==>_ZIPBrowser_MessageBeep

Func _ZIPBrowser_ShakeIt()
	HotKeySet("{F5}")
	Send("{F5}")
	Local $aPos1 = WinGetPos($hGUI, 0)
	For $i = 1 To 40
		$aPos1[0] += 14 * Sin(9 * $i)
		$aPos1[1] += 9 * Cos(9 * $i)
		WinMove($hGUI, 0, $aPos1[0], $aPos1[1])
		Sleep(10)
	Next
	WinMove($hGUI, 0, $aPos1[0] - 8, $aPos1[1] + 5)
	$aPos1 = ControlGetPos($hGUI, 0, $hTreeViewZIP)
	For $i = 1 To 40
		$aPos1[0] += 14 * Sin(9 * $i)
		$aPos1[1] += 9 * Cos(9 * $i)
		WinMove(GUICtrlGetHandle($hTreeViewZIP), 0, $aPos1[0], $aPos1[1])
		Sleep(10)
	Next
	WinMove(GUICtrlGetHandle($hTreeViewZIP), 0, $aPos1[0] - 8, $aPos1[1] + 5)
	$aPos1 = ControlGetPos($hGUI, 0, $hButtonBrowse)
	Local $aPos2 = ControlGetPos($hGUI, 0, $hButtonClose)
	For $i = 1 To 40
		$aPos1[0] += 14 * Sin(9 * $i)
		$aPos1[1] += 9 * Cos(9 * $i)
		$aPos2[0] += 14 * Sin(9 * $i)
		$aPos2[1] += 9 * Cos(9 * $i)
		GUICtrlSetPos($hButtonBrowse, $aPos1[0], $aPos1[1])
		GUICtrlSetPos($hButtonClose, $aPos2[0], $aPos2[1])
		Sleep(10)
	Next
	GUICtrlSetPos($hButtonBrowse, $aPos1[0] - 8, $aPos1[1] + 5)
	GUICtrlSetPos($hButtonClose, $aPos2[0] - 8, $aPos2[1] + 5)
	HotKeySet("{F5}", "_ZIPBrowser_ShakeIt")
EndFunc   ;==>_ZIPBrowser_ShakeIt

Func _ZIPBrowser_WM_SIZE($hWnd, $iMsg, $wParam, $lParam)
	#forceref $iMsg
	Local $aClientSize[2] = [BitAND($lParam, 65535), BitShift($lParam, 16)]
	If $hWnd = $hGUI Then
		Switch $wParam
			Case 0
				WinMove($hDots, 0, $aClientSize[0] - 17, $aClientSize[1] - 17)
				WinSetState($hDots, 0, @SW_RESTORE)
			Case 2; SIZE_MAXIMIZED
				WinSetState($hDots, 0, @SW_HIDE)
		EndSwitch
	EndIf
EndFunc   ;==>_ZIPBrowser_WM_SIZE

Func _ZIPBrowser_WM_GETMINMAXINFO($hWnd, $iMsg, $wParam, $lParam)
	#forceref $iMsg, $wParam
	If $hWnd = $hGUI Then
		Local $tMINMAXINFO = DllStructCreate("int;int;" & _
				"int MaxSizeX; int MaxSizeY;" & _
				"int MaxPositionX;int MaxPositionY;" & _
				"int MinTrackSizeX; int MinTrackSizeY;" & _
				"int MaxTrackSizeX; int MaxTrackSizeY", _
				$lParam)
		DllStructSetData($tMINMAXINFO, "MinTrackSizeX", 240)
		DllStructSetData($tMINMAXINFO, "MinTrackSizeY", 350)
	EndIf
EndFunc   ;==>_ZIPBrowser_WM_GETMINMAXINFO

Func _ZIPBrowser_WM_DROPFILES($hWnd, $iMsg, $wParam, $lParam)
	#forceref $iMsg, $lParam
	If $hWnd = $hGUI Then
		$sZip = _ZIPBrowser_DragQueryFile($wParam)
		If @error Then
			_ZIPBrowser_MessageBeep(48)
			Return 1
		EndIf
		If StringInStr(FileGetAttrib($sZip), "D") Then
			_ZIPBrowser_MessageBeep(48)
			$sZip = ""
		EndIf
		_ZIPBrowser_DragFinish($wParam)
		Return 1
	EndIf
	_ZIPBrowser_MessageBeep(48)
	Return 1
EndFunc   ;==>_ZIPBrowser_WM_DROPFILES