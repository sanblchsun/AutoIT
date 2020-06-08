#Region ;**** Directives created by AutoIt3Wrapper_GUI ****
#AutoIt3Wrapper_UseUpx=n
#AutoIt3Wrapper_UseX64=n
#EndRegion ;**** Directives created by AutoIt3Wrapper_GUI ****
#cs ----------------------------------------------------------------------------

	AutoIt Version: 3.3.6.1
	Author:         KaFu

	Contributions:...
	Based on work by: Holger Kotsch, R.Gilman (a.k.a. rasim)

	Script Function:
	ShellTristateTreeView

	Version:
	v27, 2009-Jul-27
	v39, 2010-Aug-14

#ce ----------------------------------------------------------------------------

#include <GUIConstantsEx.au3>
#include <WindowsConstants.au3>
#include <Array.au3>
#include <Winapi.au3>

If @AutoItX64 Then
	MsgBox(16 + 262144, "Error", "ShellTristateTreeView will not work as x64!")
	Exit
EndIf

Opt("GUIonEventMode", 1)

Global $h_DLL_msvcrt = DllOpen('msvcrt.dll')
Global $h_DLL_Kernel32 = DllOpen("kernel32.dll")
Global $h_DLL_user32 = DllOpen("user32.dll")

Global $aTreeViewItemState[1][2], $aTreeViewItemStateChecked[1][1], $aFolders_Scanned_in_last_Run, $aFolders_Scanned_in_last_Run_CheckOldValues[1][1]
Global $c_Checkbox_SearchFor_Recursive, $c_Checkbox_HideSystemFiles, $b_Checkbox_HideSystemFiles
Global $c_Input_Recursive_Depth, $iDepth, $c_Input_FilterExtension
Global $sStateIconFile = @ScriptDir & "\checkbox_modern.bmp"
Global $b_ShellTristateTreeView_Set = False
#include<ShellTristateTreeView_v39.au3>

$sIniFileLocation = @ScriptDir & '\ShellTristateTreeView.ini'

$hGUI = GUICreate("ShellTristateTreeView Example", 240)
GUISetOnEvent($GUI_EVENT_CLOSE, "__ExitFunction")

#cs
$c_Checkbox_SearchFor_Recursive = GUICtrlCreateCheckbox("Perform recursive input search", 10, 10, 180, 13)
GUICtrlSetFont(-1, 8, 400)
GUICtrlSetTip($c_Checkbox_SearchFor_Recursive, @CRLF & "Check this box to perform a recursive input scan. Files in sub-folders" & @CRLF _
		 & "of the selected input folders will be added to the scan list." & @CRLF _
		 & "Otherwise only files located directly in the selected folders are scanned.", "Perform recursive scan", 1, 1)
#ce

$c_Checkbox_HideSystemFiles = GUICtrlCreateCheckbox("Exclude hidden and system directories", 10, 10, 200, 13)
GUICtrlSetOnEvent($c_Checkbox_HideSystemFiles, "__func_LocationTree_Create_Do")
GUICtrlSetFont(-1, 8, 400)

$c_TreeView_LocationFilter = _GUICtrlTreeView_Create($hGUI, 10, 30, 220, 280, BitOR($TVS_HASBUTTONS, $TVS_HASLINES, $TVS_LINESATROOT, $TVS_DISABLEDRAGDROP, $TVS_CHECKBOXES, $TVS_NOTOOLTIPS), $WS_EX_CLIENTEDGE)
_GUICtrlTreeView_SetBkColor($c_TreeView_LocationFilter, "0xFFFED8")

$c_Button_RefreshTree = GUICtrlCreateButton("Refresh Tree", 10, 293 + 20, 70, 20)
GUICtrlSetOnEvent($c_Button_RefreshTree, "__func_LocationTree_Create_Do")
GUICtrlSetFont(-1, 8, 400)
GUICtrlSetTip(-1, @CRLF & "The folder tree is not refreshed automatically. Press Button" & @CRLF _
		 & "to force a manual update of the folder tree.", "Refresh Tree", 1, 1)

$c_Checkbox_AddNetworkDrives_Always = GUICtrlCreateCheckbox("Always add network drives", 90, 294 + 20, 150, 17)
GUICtrlSetOnEvent($c_Checkbox_AddNetworkDrives_Always, "__func_LocationTree_Create_Do")
GUICtrlSetFont(-1, 8, 400)
GUICtrlSetTip(-1, @CRLF & "By default network drives are not added to the folder tree (performance)." & @CRLF _
		 & "Check this box to override default behavior. If box is checked," & @CRLF _
		 & "network drives will be added to the folder tree by default.", "Always add network drives", 1, 1)

$c_Button_ReturnState = GUICtrlCreateButton("Return checked directories", 20, 340, 200, 50, 0)
GUICtrlSetOnEvent($c_Button_ReturnState, "Treeview_Read_ItemState_Do")

;GUICtrlSetState($c_Checkbox_SearchFor_Recursive, IniRead($sIniFileLocation, "Settings", "Checkbox_SearchFor_Recursive", 1))
GUICtrlSetState($c_Checkbox_AddNetworkDrives_Always, IniRead($sIniFileLocation, "Settings", "Checkbox_AddNetworkDrives_Always", 4))

__func_LocationTree_Create_Do()

GUISetState(@SW_SHOW)

While 1
	Sleep(10)
WEnd








Func __ExitFunction()
	_IniValues_Save($sIniFileLocation)
	If IsDeclared("c_TreeView_LocationFilter") Then Treeview_Read_ItemState()
	If IsDeclared("c_TreeView_LocationFilter") Then Treeview_Save_ItemState()
	Exit
EndFunc   ;==>__ExitFunction

Func _IniValues_Save($s_FileLocation_Save_Ini)
	;IniWrite($s_FileLocation_Save_Ini, "Settings", "Checkbox_SearchFor_Recursive", GUICtrlRead($c_Checkbox_SearchFor_Recursive))
	IniWrite($s_FileLocation_Save_Ini, "Settings", "Checkbox_AddNetworkDrives_Always", GUICtrlRead($c_Checkbox_AddNetworkDrives_Always))
EndFunc   ;==>_IniValues_Save


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
	ReDim $aFolders_Scanned_in_last_Run_CheckOldValues[UBound($aFolders_Scanned_in_last_Run)][2]
	For $i = 0 To UBound($aFolders_Scanned_in_last_Run) - 1
		$aFolders_Scanned_in_last_Run_CheckOldValues[$i][0] = $aFolders_Scanned_in_last_Run[$i]
		$aFolders_Scanned_in_last_Run_CheckOldValues[$i][1] = 0
	Next

	;_ArrayDisplay($aFolders_Scanned_in_last_Run_CheckOldValues)
	If $aFolders_Scanned_in_last_Run_CheckOldValues[0][0] > 0 Then
		__func_LocationTree_CheckOldValues()
		_GUICtrlTreeView_Expand($c_TreeView_LocationFilter, _GUICtrlTreeView_GetFirstItem($c_TreeView_LocationFilter), False) ; collapse back to root
		_GUICtrlTreeView_SetState($c_TreeView_LocationFilter, _GUICtrlTreeView_GetFirstItem($c_TreeView_LocationFilter), $TVIS_EXPANDED, True) ; expand First level (show drives)
	EndIf

	_GUICtrlTreeView_EndUpdate($c_TreeView_LocationFilter)
	_LoadStateImage($c_TreeView_LocationFilter, $sStateIconFile)

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
	_GUICtrlTreeView_BeginUpdate($c_TreeView_LocationFilter)
	If $hItemRoot = '' Then $hItemRoot = _GUICtrlTreeView_GetFirstItem($c_TreeView_LocationFilter)
	; ConsoleWrite('__func_LocationTree_CheckOldValues ' & $hItemRoot & @CRLF)
	Local $hItemSub = _GUICtrlTreeView_GetFirstChild($c_TreeView_LocationFilter, $hItemRoot)

	While $hItemSub
		;If $aFolders_Scanned_in_last_Run_CheckOldValues[0][0] = 0 Then Return
		$sText = _GUICtrlTreeView_GetText($c_TreeView_LocationFilter, $hItemSub)
		Local $sDirPointer = _ShellTreeView_GetSelected($c_TreeView_LocationFilter, $sText, $hItemSub, True)
		;ConsoleWrite($sDirPointer & @CRLF)
		If FileExists($sDirPointer) Then
			;For $i = 1 To UBound($aFolders_Scanned_in_last_Run_CheckOldValues) - 1
			For $i = 1 To $aFolders_Scanned_in_last_Run_CheckOldValues[0][0]
				If $aFolders_Scanned_in_last_Run_CheckOldValues[$i][1] <> 1 Then ; not found yet
					If $sDirPointer = $aFolders_Scanned_in_last_Run_CheckOldValues[$i][0] Then
						; check item
						;ConsoleWrite("Check " & $sDirPointer & @CRLF)
						MyCtrlSetItemState($c_TreeView_LocationFilter, $hItemSub, $GUI_CHECKED)
						$aFolders_Scanned_in_last_Run_CheckOldValues[$i][1] = 1 ; found
						;_ArrayDelete($aFolders_Scanned_in_last_Run, $i)
						;$aFolders_Scanned_in_last_Run[0] -= 1
					ElseIf StringInStr($aFolders_Scanned_in_last_Run_CheckOldValues[$i][0], $sDirPointer) Then
						; expand
						; recurse function
						;ConsoleWrite("Expand " & $sDirPointer & @CRLF)
						If Not _GUICtrlTreeView_GetExpanded($c_TreeView_LocationFilter, $hItemSub) Then
							;ConsoleWrite(_GUICtrlTreeView_GetText($hWndFrom, $hControl) & @CRLF)
							_ShellTreeView_GetSelected($c_TreeView_LocationFilter, _GUICtrlTreeView_GetText($c_TreeView_LocationFilter, $hItemSub), $hItemSub, False, False)
						EndIf
						_GUICtrlTreeView_SetState($c_TreeView_LocationFilter, $hItemSub, $TVIS_EXPANDED, True)
						__func_LocationTree_CheckOldValues($hItemSub)
					EndIf
				EndIf
			Next
		EndIf
		$hItemSub = _GUICtrlTreeView_GetNextChild($c_TreeView_LocationFilter, $hItemSub)
	WEnd
	_GUICtrlTreeView_EndUpdate($c_TreeView_LocationFilter)
EndFunc   ;==>__func_LocationTree_CheckOldValues

Func Treeview_Read_ItemState_Do()
	Treeview_Read_ItemState()
	_ArrayDisplay($aTreeViewItemState)
EndFunc   ;==>Treeview_Read_ItemState_Do

Func Treeview_Read_ItemState()
	; $aTreeViewItemState is a Global var

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
	;_ArraySort($aTreeViewItemState, 1)
	_ArraySortClib($aTreeViewItemState, 1, 1)

	For $iCountStateChecked = UBound($aTreeViewItemState) - 1 To 1 Step -1
		If StringLen($aTreeViewItemState[$iCountStateChecked][0]) = 0 Then _ArrayDelete($aTreeViewItemState, $iCountStateChecked)
	Next
	_ArraySortClib($aTreeViewItemState, 1)
	;_ArraySort($aTreeViewItemState)
	For $i = 0 To UBound($aTreeViewItemState) - 2
		If $i = UBound($aTreeViewItemState) - 1 Then ExitLoop
		If StringInStr($aTreeViewItemState[$i + 1][0], $aTreeViewItemState[$i][0]) Then
			_ArrayDelete($aTreeViewItemState, $i + 1)
			$i = $i - 1
		EndIf
	Next
	;_ArrayDisplay($aTreeViewItemState)

EndFunc   ;==>Treeview_Read_ItemState

Func Treeview_Save_ItemState()
	IniWrite($sIniFileLocation, "Settings", "Folders_Scanned_in_last_Run", "")
	For $i = 0 To UBound($aTreeViewItemState) - 1 ; loop through selected folders
		If FileExists($aTreeViewItemState[$i][0]) = 1 Then
			IniWrite($sIniFileLocation, "Settings", "Folders_Scanned_in_last_Run", $aTreeViewItemState[$i][0] & "|" & IniRead($sIniFileLocation, "Settings", "Folders_Scanned_in_last_Run", ""))
		EndIf
	Next
EndFunc   ;==>Treeview_Save_ItemState

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

	Local $tNMHDR = DllStructCreate($tagNMHDR, $lParam)
	Local $hWndFrom = DllStructGetData($tNMHDR, "hWndFrom")
	Local $nNotifyCode = DllStructGetData($tNMHDR, "Code")
	Local $hItem = 0

	Switch $hWndFrom
		Case $hWndTreeView

			Switch $nNotifyCode
				Case -454 ; $TVN_ITEMEXPANDING (-405) > Changed due to TreeView UNICODE to -454!!!!?
					Local $tINFO = DllStructCreate($tagNMTREEVIEW, $lParam)
					Local $hControl = DllStructGetData($tINFO, "NewhItem")
					If Not _GUICtrlTreeView_GetExpanded($hWndTreeView, $hControl) Then _ShellTreeView_GetSelected($hWndFrom, _GUICtrlTreeView_GetText($hWndFrom, $hControl), $hControl, False, False)
					Return $GUI_RUNDEFMSG

				Case $TVN_KEYDOWN
					Local $lpNMTVKEYDOWN = DllStructCreate("dword;int;int;short;uint", $lParam)
					; Check for 'SPACE'-press
					If DllStructGetData($lpNMTVKEYDOWN, 4) <> $VK_SPACE Then Return $GUI_RUNDEFMSG
					$hItem = _SendMessage($hWndFrom, $TVM_GETNEXTITEM, $TVGN_CARET, 0)

				Case $NM_CLICK
					Local $Point = DllStructCreate("int;int")

					_GetCursorPos($Point)
					_ScreenToClient($hWndFrom, $Point)

					; Check if clicked on state icon
					Local $tvHit = DllStructCreate("int[2];uint;dword")
					DllStructSetData($tvHit, 1, DllStructGetData($Point, 1), 1)
					DllStructSetData($tvHit, 1, DllStructGetData($Point, 2), 2)

					$hItem = _SendMessage($hWndFrom, $TVM_HITTEST, 0, DllStructGetPtr($tvHit))
					If Not BitAND(DllStructGetData($tvHit, 2), $TVHT_ONITEMSTATEICON) Then Return $GUI_RUNDEFMSG
			EndSwitch

			If $hItem > 0 Then

				Local $nState = _GetItemState($hWndFrom, $hItem)

				$bCheckItems = 1

				If $nState = 2 Then
					$nState = 0
				ElseIf $nState = 3 Then
					$nState = 1
				ElseIf $nState > 3 Then
					$nState = $nState - 1
					$bCheckItems = 0
				EndIf

				_SetItemState($hWndFrom, $hItem, $nState)
				$b_ShellTristateTreeView_Set = True

				$nState += 1

				; If item are disabled there is no chance to change it and it's parents/children
				If $bCheckItems Then
					CheckParents($hWndFrom, $hItem, $nState)
					CheckChildItems($hWndFrom, $hItem, $nState)
				EndIf

				Return $GUI_RUNDEFMSG

			EndIf

			If $nNotifyCode = -12 And $b_ShellTristateTreeView_Set Then
				$b_ShellTristateTreeView_Set = False

				Local $nTreeView_ItemsChecked = 0
				Local $nTreeView_ItemsCount = 0
				Local $hItem_Check = _GUICtrlTreeView_GetFirstChild($hWndFrom, $RootItem)
				Do
					$nTreeView_ItemsCount += 1
					Switch _GetItemState($hWndFrom, $hItem_Check)
						Case 2, 3
							$nTreeView_ItemsChecked += 1
						Case 4
							$nTreeView_ItemsCount -= 1
					EndSwitch
					;ConsoleWrite($hItem_Check & @TAB & _GetItemState($hWndFrom, $hItem_Check) & @CRLF)
					$hItem_Check = _GUICtrlTreeView_GetNextChild($hWndFrom, $hItem_Check)
				Until $hItem_Check = 0

				;ConsoleWrite($nNotifyCode & @TAB & "$nTreeView_ItemsCount " & $nTreeView_ItemsCount & @TAB & "$nTreeView_ItemsChecked " & $nTreeView_ItemsChecked & @CRLF & @CRLF & @CRLF)
				If $nTreeView_ItemsChecked = 0 Then
					_SetItemState($hWndFrom, $RootItem, 1)
				ElseIf $nTreeView_ItemsCount = $nTreeView_ItemsChecked Then
					_SetItemState($hWndFrom, $RootItem, 2) ; Unchecked
				Else
					_SetItemState($hWndFrom, $RootItem, 3) ; Intermediate
				EndIf
			EndIf

	EndSwitch

	Return $GUI_RUNDEFMSG
EndFunc   ;==>MY_WM_NOTIFY_ShellTristateTreeView