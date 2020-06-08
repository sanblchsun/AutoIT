#cs ----------------------------------------------------------------------------

	AutoIt Version: 3.3.0.0
	Author:         KaFu

	Contributions:...
	Based on work by: Holger Kotsch, R.Gilman (a.k.a. rasim)

	Script Function:
	ShellTristateTreeView

	Version:
	v27, 2009-Jul-27

#ce ----------------------------------------------------------------------------

#include <GUIConstantsEx.au3>
#include <WindowsConstants.au3>

Opt("GUIonEventMode", 1)

Global $aTreeViewItemState[1][1], $aTreeViewItemStateChecked[1][1], $aFolders_Scanned_in_last_Run
Global $c_Checkbox_SearchFor_Recursive
Global $sStateIconFile = "checkbox_modern.bmp"
#include<ShellTristateTreeView_v27.au3>
$sIniFileLocation = @ScriptDir & '\ShellTristateTreeView.ini'


$hGUI = GUICreate("ShellTristateTreeView Example", 240)
GUISetOnEvent($GUI_EVENT_CLOSE, "__ExitFunction")

$c_Checkbox_SearchFor_Recursive = GUICtrlCreateCheckbox("Perform recursive input search", 10, 10, 180, 13)
GUICtrlSetFont(-1, 8, 400)
GUICtrlSetTip($c_Checkbox_SearchFor_Recursive, @CRLF & "Check this box to perform a recursive input scan. Files in sub-folders" & @CRLF _
		 & "of the selected input folders will be added to the scan list." & @CRLF _
		 & "Otherwise only files located directly in the selected folders are scanned.", "Perform recursive scan", 1, 1)

$c_TreeView_LocationFilter = _GUICtrlTreeView_Create($hGUI, 10, 10 + 20, 220, 280, BitOR($TVS_HASBUTTONS, $TVS_HASLINES, $TVS_LINESATROOT, $TVS_DISABLEDRAGDROP, $TVS_CHECKBOXES), $WS_EX_CLIENTEDGE)
$c_Button_RefreshTree = GUICtrlCreateButton("Refresh Tree", 10, 293 + 20, 70, 20)
GUICtrlSetOnEvent($c_Button_RefreshTree, "__func_LocationTree_Create_Do")
GUICtrlSetFont(-1, 8, 400)
GUICtrlSetTip(-1, @CRLF & "The folder tree is not refreshed automatically. Press Button" & @CRLF _
		 & "to force a manual update of the folder tree.", "Refresh Tree", 1, 1)

$c_Checkbox_AddNetworkDrives_Always = GUICtrlCreateCheckbox("Always add network drives", 90, 294 + 20, 150, 17)
GUICtrlSetFont(-1, 8, 400)
GUICtrlSetTip(-1, @CRLF & "By default network drives are not added to the folder tree (performance)." & @CRLF _
		 & "Check this box to override default behavior. If box is checked," & @CRLF _
		 & "network drives will be added to the folder tree by default.", "Always add network drives", 1, 1)

$c_Button_ReturnState = GUICtrlCreateButton("Return checked directories", 20, 340, 200, 50, 0)
GUICtrlSetOnEvent($c_Button_ReturnState, "__func_LocationTree_ReturnState")

GUIRegisterMsg($WM_NOTIFY, "MY_WM_NOTIFY_ShellTristateTreeView")

GUICtrlSetState($c_Checkbox_SearchFor_Recursive, IniRead($sIniFileLocation, "Settings", "Checkbox_SearchFor_Recursive", 1))
GUICtrlSetState($c_Checkbox_AddNetworkDrives_Always, IniRead($sIniFileLocation, "Settings", "Checkbox_AddNetworkDrives_Always", 4))

__func_LocationTree_Create_Do()

GUISetState(@SW_SHOW)


While 1
	Sleep(10)
WEnd








Func __ExitFunction()
	_IniValues_Save($sIniFileLocation)
	Exit
EndFunc   ;==>__ExitFunction

Func _IniValues_Save($s_FileLocation_Save_Ini)
	IniWrite($s_FileLocation_Save_Ini, "Settings", "Checkbox_SearchFor_Recursive", GUICtrlRead($c_Checkbox_SearchFor_Recursive))
	IniWrite($s_FileLocation_Save_Ini, "Settings", "Checkbox_AddNetworkDrives_Always", GUICtrlRead($c_Checkbox_AddNetworkDrives_Always))
EndFunc   ;==>_IniValues_Save


















Func __func_LocationTree_ReturnState()

	$aTreeViewItemState = ""
	Dim $aTreeViewItemState[_GUICtrlTreeView_GetCount($c_TreeView_LocationFilter)][2]
	$hItemRoot = _GUICtrlTreeView_GetFirstItem($c_TreeView_LocationFilter)
	$aTreeViewItemState[0][0] = "My Computer (" & @ComputerName & ")"
	$aTreeViewItemState[0][1] = MyCtrlGetItemState($c_TreeView_LocationFilter, $hItemRoot)
	$iCountStateChecked = 1
	If MyCtrlGetItemState($c_TreeView_LocationFilter, $hItemRoot) = 1 Then ; if "My Computer" is activated
		$hItemSub = _GUICtrlTreeView_GetFirstChild($c_TreeView_LocationFilter, $hItemRoot)
		While $hItemSub
			$iCountStateChecked += 1
			$sText = _GUICtrlTreeView_GetText($c_TreeView_LocationFilter, $hItemSub)
			$aTreeViewItemState[$iCountStateChecked][0] = _ShellTreeView_GetSelected($c_TreeView_LocationFilter, $sText, $hItemSub, True)
			$aTreeViewItemState[$iCountStateChecked][1] = MyCtrlGetItemState($c_TreeView_LocationFilter, $hItemSub)
			$hItemSub = _GUICtrlTreeView_GetNextChild($c_TreeView_LocationFilter, $hItemSub)
		WEnd
	ElseIf MyCtrlGetItemState($c_TreeView_LocationFilter, $hItemRoot) = 2 Then ; if anything else is activated
		_TreeviewGetChildState($c_TreeView_LocationFilter, $hItemRoot, $iCountStateChecked)
	EndIf

	; Parse and clean the results, just keep top-most parent directories activated and skip childs
	_ArrayDelete($aTreeViewItemState, 0)
	_ArraySort($aTreeViewItemState, 1)
	For $iCountStateChecked = UBound($aTreeViewItemState) - 1 To 1 Step -1
		If StringLen($aTreeViewItemState[$iCountStateChecked][0]) = 0 Then _ArrayDelete($aTreeViewItemState, $iCountStateChecked)
	Next
	_ArraySort($aTreeViewItemState)
	For $i = 0 To UBound($aTreeViewItemState) - 2
		If $i = UBound($aTreeViewItemState) - 1 Then ExitLoop
		If StringInStr($aTreeViewItemState[$i + 1][0], $aTreeViewItemState[$i][0]) Then
			_ArrayDelete($aTreeViewItemState, $i + 1)
			$i = $i - 1
		EndIf
	Next
	If StringLen($aTreeViewItemState[0][0]) = 0 Then
		MsgBox(270400, "Error", "No Location selected..." & @CRLF & @CRLF & "You have to select at least one location to search.")
	Else

		IniWrite($sIniFileLocation, "Settings", "Folders_Scanned_in_last_Run", "")
		For $i = 0 To UBound($aTreeViewItemState) - 1 ; loop through selected folders
			If FileExists($aTreeViewItemState[$i][0]) = 1 Then
				IniWrite($sIniFileLocation, "Settings", "Folders_Scanned_in_last_Run", $aTreeViewItemState[$i][0] & "|" & IniRead($sIniFileLocation, "Settings", "Folders_Scanned_in_last_Run", ""))
			EndIf
		Next

		_ArrayDisplay($aTreeViewItemState)

	EndIf
EndFunc   ;==>__func_LocationTree_ReturnState
; =======================
; Create Treeview
; =======================
Func __func_LocationTree_Create($b_AddNetworkDrives)

	_GUICtrlTreeView_DeleteAll($c_TreeView_LocationFilter)
	_GUICtrlTreeView_BeginUpdate($c_TreeView_LocationFilter)
	_ShellTreeView_Create($c_TreeView_LocationFilter, $b_AddNetworkDrives) ; AddNetworkDrives Default = true (always)
	_GUICtrlTreeView_SetState($c_TreeView_LocationFilter, _GUICtrlTreeView_GetFirstItem($c_TreeView_LocationFilter), $TVIS_EXPANDED, True) ; expand First level (show drives)
	_ShellTreeView_GetSelected($c_TreeView_LocationFilter, _GUICtrlTreeView_GetText($c_TreeView_LocationFilter, _GUICtrlTreeView_GetFirstItem($c_TreeView_LocationFilter)), _GUICtrlTreeView_GetFirstItem($c_TreeView_LocationFilter))

	Global $aFolders_Scanned_in_last_Run = StringSplit(IniRead($sIniFileLocation, "Settings", "Folders_Scanned_in_last_Run", ""), "|")
	_ArrayDelete($aFolders_Scanned_in_last_Run, UBound($aFolders_Scanned_in_last_Run) - 1)
	$aFolders_Scanned_in_last_Run[0] = UBound($aFolders_Scanned_in_last_Run) - 1
	If $aFolders_Scanned_in_last_Run[0] > 0 Then
		For $i = 1 To $aFolders_Scanned_in_last_Run[0]
			If UBound($aFolders_Scanned_in_last_Run) = $i Then ExitLoop
			If Not StringInStr(FileGetAttrib($aFolders_Scanned_in_last_Run[$i]), 'D') Then
				_ArrayDelete($aFolders_Scanned_in_last_Run, $i)
				$aFolders_Scanned_in_last_Run[0] = UBound($aFolders_Scanned_in_last_Run) - 1
				$i -= 1
			EndIf
		Next
	EndIf
	$aFolders_Scanned_in_last_Run[0] = UBound($aFolders_Scanned_in_last_Run) - 1

	If $aFolders_Scanned_in_last_Run[0] > 0 Then
		__func_LocationTree_CheckOldValues()
		_GUICtrlTreeView_Expand($c_TreeView_LocationFilter, _GUICtrlTreeView_GetFirstItem($c_TreeView_LocationFilter), False) ; collapse back to root
		_GUICtrlTreeView_SetState($c_TreeView_LocationFilter, _GUICtrlTreeView_GetFirstItem($c_TreeView_LocationFilter), $TVIS_EXPANDED, True) ; expand First level (show drives)
	EndIf

	_GUICtrlTreeView_EndUpdate($c_TreeView_LocationFilter)
	LoadStateImage($c_TreeView_LocationFilter, $sStateIconFile)

	_GUICtrlTreeView_SetUnicodeFormat($c_TreeView_LocationFilter)

EndFunc   ;==>__func_LocationTree_Create

Func __func_LocationTree_Create_Do()
	If GUICtrlRead($c_Checkbox_AddNetworkDrives_Always) = $GUI_CHECKED Then
		__func_LocationTree_Create(True)
	Else
		__func_LocationTree_Create(False)
	EndIf
EndFunc   ;==>__func_LocationTree_Create_Do

Func __func_LocationTree_CheckOldValues($hItemRoot = '')
	If $hItemRoot = '' Then $hItemRoot = _GUICtrlTreeView_GetFirstItem($c_TreeView_LocationFilter)
	; ConsoleWrite('__func_LocationTree_CheckOldValues ' & $hItemRoot & @CRLF)
	$hItemSub = _GUICtrlTreeView_GetFirstChild($c_TreeView_LocationFilter, $hItemRoot)

	While $hItemSub
		If $aFolders_Scanned_in_last_Run[0] = 0 Then Return
		$sText = _GUICtrlTreeView_GetText($c_TreeView_LocationFilter, $hItemSub)
		$sDirPointer = _ShellTreeView_GetSelected($c_TreeView_LocationFilter, $sText, $hItemSub, True)
		If FileExists($sDirPointer) Then
			For $i = 1 To $aFolders_Scanned_in_last_Run[0]
				If $sDirPointer = $aFolders_Scanned_in_last_Run[$i] Then
					; check item
					; ConsoleWrite("Check " & $sDirPointer & @CRLF)
					MyCtrlSetItemState($c_TreeView_LocationFilter, $hItemSub, $GUI_CHECKED)
					_ArrayDelete($aFolders_Scanned_in_last_Run, $i)
					$aFolders_Scanned_in_last_Run[0] -= 1
				ElseIf StringInStr($aFolders_Scanned_in_last_Run[$i], $sDirPointer) Then
					; expand
					; recurse function
					; ConsoleWrite("Expand " & $sDirPointer & @CRLF)
					If _GUICtrlTreeView_GetExpanded($c_TreeView_LocationFilter, $hItemSub) = False Then
						;ConsoleWrite(_GUICtrlTreeView_GetText($hWndFrom, $hControl) & @CRLF)
						_ShellTreeView_GetSelected($c_TreeView_LocationFilter, _GUICtrlTreeView_GetText($c_TreeView_LocationFilter, $hItemSub), $hItemSub, False, False)
					EndIf
					_GUICtrlTreeView_SetState($c_TreeView_LocationFilter, $hItemSub, $TVIS_EXPANDED, True)
					__func_LocationTree_CheckOldValues($hItemSub)
				EndIf
			Next
		EndIf
		$hItemSub = _GUICtrlTreeView_GetNextChild($c_TreeView_LocationFilter, $hItemSub)
	WEnd
EndFunc   ;==>__func_LocationTree_CheckOldValues


; #FUNCTION# ==================================================================================================
; Name............: MY_WM_NOTIFY
; Description.....: Add TreeView items with directorys structures
;					Handle Windows Message notifications
;					Merge of the two MY_WM_NOTIFY functions from
;					ShellTreeView.au3 and TristateTreeViewLib.au3
;					Please don't ask me about the magic being done here in detail : )
;
;					Though I'm quiet sure the function needs consolidation....
;
; ====================================================================================================

Func MY_WM_NOTIFY_ShellTristateTreeView($hWnd, $Msg, $wParam, $lParam)

	;ShellTreeView.au3
	; ==========
	Local $tNMHDR, $hWndFrom, $iCode
	$tNMHDR = DllStructCreate($tagNMHDR, $lParam)
	$hWndFrom = DllStructGetData($tNMHDR, "hWndFrom")
	$iCode = DllStructGetData($tNMHDR, "Code")
	Switch $hWndFrom
		Case $hWndTreeView
			;ConsoleWrite($iCode & @CRLF)
			Switch $iCode
				Case - 454 ; $TVN_ITEMEXPANDING (-405) > Changed due to TreeView UNICODE to -454!!!!?
					;Case $TVN_ITEMEXPANDING
					;ConsoleWrite($TVN_ITEMEXPANDING & @CRLF)
					Local $tINFO = DllStructCreate($tagNMTREEVIEW, $lParam)
					Local $hControl = DllStructGetData($tINFO, "NewhItem")
					If _GUICtrlTreeView_GetExpanded($hWndTreeView, $hControl) = False Then
						;ConsoleWrite(_GUICtrlTreeView_GetText($hWndFrom, $hControl) & @CRLF)
						_ShellTreeView_GetSelected($hWndFrom, _GUICtrlTreeView_GetText($hWndFrom, $hControl), $hControl, False, False)
					EndIf
			EndSwitch
	EndSwitch

	;TristateTreeViewLib.au3
	; ==========
	Local $stNmhdr = DllStructCreate("dword;int;int", $lParam)
	Local $hWndFrom = DllStructGetData($stNmhdr, 1)
	Local $nNotifyCode = DllStructGetData($stNmhdr, 3)
	Local $hItem = 0
	; Check if its treeview and only NM_CLICK and TVN_KEYDOWN
	If Not BitAND(GetWindowLong($hWndFrom, $GWL_STYLE), $TVS_CHECKBOXES) Or _
			Not ($nNotifyCode = $NM_CLICK Or $nNotifyCode = $TVN_KEYDOWN) Then Return $GUI_RUNDEFMSG

	If $nNotifyCode = $TVN_KEYDOWN Then
		Local $lpNMTVKEYDOWN = DllStructCreate("dword;int;int;short;uint", $lParam)

		; Check for 'SPACE'-press
		If DllStructGetData($lpNMTVKEYDOWN, 4) <> $VK_SPACE Then Return $GUI_RUNDEFMSG
		$hItem = SendMessage($hWndFrom, $TVM_GETNEXTITEM, $TVGN_CARET, 0)
	Else
		Local $Point = DllStructCreate("int;int")

		GetCursorPos($Point)
		ScreenToClient($hWndFrom, $Point)

		; Check if clicked on state icon
		Local $tvHit = DllStructCreate("int[2];uint;dword")
		DllStructSetData($tvHit, 1, DllStructGetData($Point, 1), 1)
		DllStructSetData($tvHit, 1, DllStructGetData($Point, 2), 2)

		$hItem = SendMessage($hWndFrom, $TVM_HITTEST, 0, DllStructGetPtr($tvHit))

		If Not BitAND(DllStructGetData($tvHit, 2), $TVHT_ONITEMSTATEICON) Then Return $GUI_RUNDEFMSG
	EndIf

	If $hItem > 0 Then

		Local $nState = GetItemState($hWndFrom, $hItem)

		$bCheckItems = 1

		If $nState = 2 Then
			$nState = 0
		ElseIf $nState = 3 Then
			$nState = 1
		ElseIf $nState > 3 Then
			$nState = $nState - 1
			$bCheckItems = 0
		EndIf

		SetItemState($hWndFrom, $hItem, $nState)

		$nState += 1

		; If item are disabled there is no chance to change it and it's parents/children
		If $bCheckItems Then
			CheckParents($hWndFrom, $hItem, $nState)
			CheckChildItems($hWndFrom, $hItem, $nState)
		EndIf
	EndIf

	Return $GUI_RUNDEFMSG
EndFunc   ;==>MY_WM_NOTIFY_ShellTristateTreeView
