#include-once
#include <GuiTreeView.au3>
#include <GuiImageList.au3>
#include <WindowsConstants.au3>
#include <Constants.au3>
#include <Array.au3>

;===============================================================================
;
; Program Name:   	ShellTristateTreeView.au3
;					build02
;
;					AutoIt Version: 3.2.12.1
;
; Author(s):        Rasim (ShellTreeView.au3)
;					Holger Kotsch (TristateTreeViewLib.au3)
;           		Merged & Modified version by Polyphem
;					Ported to Au native filesearch and further enhancements by KaFu
;
; Note(s):
;   2008-Sep-16    	Modified by KaFu from original functions
;
;===============================================================================


; You could also use an integrated bmp (with ResourceHacker)
; Please see ShellTreeView.au3 (LoadStateImage)
; If you integrate the bmp, You MUST not compile the script it full with UPX, just use after compiling: upx.exe --best --compress-resources=0 xyz.exe!
; If you choose another resource number then 170 you have to change the LoadStateImage() function
;
; You can get other check bitmaps also together with freeware install programs like i.e. NSIS
; it must have 5 image states in it:
; 1.empty, 2.unchecked, 3.checked, 4.disabled and unchecked, 5.disabled and checked
; BTW, for people who like to add icons to their treeviews with _GUICtrlTreeViewSetIcon, make certain you call LoadStateImage after _GUICtrlTreeViewSetIcon
;
; Userfunction My-WM_Notify() is registered in ShellTristateTreeView.au3.
; ----------------------------------------------------------------------------
;
; Script:			Tristate TreeView
; Version:			0.3
; AutoIt Version:	3.2.0.X
; Author:			Holger Kotsch
;
; Script Function:
;	Demonstrates a tristate treeview control -> just more like a fifthstate treeview ; )
;
;	5 item checkbox! states are usable:
;	(can only used with TreeView with TVS_CHECKBOXES-style)
;		- $GUI_CHECKED
;		- $GUI_UNCHECKED
;		- $GUI_INDETERMINATE
;		- $GUI_DISABLE + $GUI_CHECKED
;		- $GUI_DISABLE + $GUI_UNCHECKED
;
; ----------------------------------------------------------------------------

;If Not IsDeclared("LR_LOADFROMFILE")		Then	Global Const $LR_LOADFROMFILE			= 0x0010
;If Not IsDeclared("LR_LOADTRANSPARENT")		Then	Global Const $LR_LOADTRANSPARENT		= 0x0020
;If Not IsDeclared("LR_CREATEDIBSECTION")	Then	Global Const $LR_CREATEDIBSECTION		= 0x2000
;If Not IsDeclared("CLR_NONE")				Then	Global Const $CLR_NONE					= 0xFFFFFFFF
;If Not IsDeclared("IMAGE_BITMAP")			Then	Global Const $IMAGE_BITMAP				= 0
If Not IsDeclared("VK_SPACE") Then Global Const $VK_SPACE = 32
;If Not IsDeclared("GWL_STYLE")				Then	Global Const $GWL_STYLE					= -16

Global $hImage, $hImageList, $hWndTreeView, $hCommonDocs, $hMyDocs, $hMyDesktop, $hMyVideo
Global $RootItem, $aTreeViewItemState


Global $sFolderName_MyComputer = "My Computer"
$sRegString = RegRead('HKEY_CLASSES_ROOT\CLSID\{20D04FE0-3AEA-1069-A2D8-08002B30309D}', '')
If $sRegString Then $sFolderName_MyComputer = $sRegString

Global $sFolderName_Desktop = "Desktop"
$sRegString = RegRead("HKEY_USERS\.DEFAULT\Software\Microsoft\Windows\CurrentVersion\Explorer\User Shell Folders", "Desktop")
If $sRegString Then $sFolderName_Desktop = StringRight($sRegString, StringLen($sRegString) - StringInStr($sRegString, "\", 0, -1))

Global $sFolderName_MyDocuments = "My Documents"
$sRegString = RegRead('HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\CLSID\{450D8FBA-AD25-11D0-98A8-0800361B1103}', '')
If $sRegString Then $sFolderName_MyDocuments = StringRight($sRegString, StringLen($sRegString) - StringInStr($sRegString, "\", 0, -1))

Global $sFolderName_MyVideo = "My Video"
$sRegString = RegRead("HKEY_USERS\.DEFAULT\Software\Microsoft\Windows\CurrentVersion\Explorer\User Shell Folders", "My Video")
If $sRegString Then $sFolderName_MyVideo = StringRight($sRegString, StringLen($sRegString) - StringInStr($sRegString, "\", 0, -1))

Global $sFolderName_SharedDocuments = "Shared Documents"
$sRegString = RegRead("HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Shell Folders", "Common Documents")
If $sRegString Then $sFolderName_SharedDocuments = StringRight($sRegString, StringLen($sRegString) - StringInStr($sRegString, "\", 0, -1))


Func _TreeviewGetChildState($hTreeView, $hItem, $iCountStateChecked)
	Local $hItemSub
	;ConsoleWrite("TV Unicode: " & _GUICtrlTreeView_GetUnicodeFormat($hTreeView) & @crlf)

	$hItemSub = _GUICtrlTreeView_GetFirstChild($hTreeView, $hItem)
	While $hItemSub
		If MyCtrlGetItemState($hTreeView, $hItemSub) = 2 Then
			$iCountStateChecked = _TreeviewGetChildState($hTreeView, $hItemSub, $iCountStateChecked)
		ElseIf MyCtrlGetItemState($hTreeView, $hItemSub) = 1 Then
			$iCountStateChecked += 1
			$sText = _GUICtrlTreeView_GetText($hTreeView, $hItemSub)
			;ConsoleWrite("Parse: " & $sText & @crlf)
			$aTreeViewItemState[$iCountStateChecked][0] = _ShellTreeView_GetSelected($hTreeView, $sText, $hItemSub, True)
			$aTreeViewItemState[$iCountStateChecked][1] = MyCtrlGetItemState($hTreeView, $hItemSub)
		EndIf
		$hItemSub = _GUICtrlTreeView_GetNextChild($hTreeView, $hItemSub)
	WEnd
	Return $iCountStateChecked

EndFunc   ;==>_TreeviewGetChildState

; #FUNCTION# ==================================================================================================
; Name............: _ShellTreeView_Create
; Description.....: Add TreeView items with drives structures
; Syntax..........: _ShellTreeView_Create($hTreeView)
; Parameter(s)....: $hTreeView - Handle to the TreeView control
; Return value(s).: None
; Note(s).........: Tested on AutoIt 3.2.12.1 and Windows XP SP2
; Author(s).......: R.Gilman (a.k.a. rasim)
; ====================================================================================================
Func _ShellTreeView_Create($hTreeView, $iIncludeNetworkDrives = False)

	If IsHWnd($hImage) Then _GUIImageList_Destroy($hImage)

	Global $hImage = _GUIImageList_Create(16, 16, 5, 3)

	_GUIImageList_AddIcon($hImage, @SystemDir & "\shell32.dll", 15) ; 16 = My Computer
	_GUIImageList_AddIcon($hImage, @SystemDir & "\shell32.dll", 6) ; 7 = Disk-Drive
	_GUIImageList_AddIcon($hImage, @SystemDir & "\shell32.dll", 8) ; 9 = HDD
	_GUIImageList_AddIcon($hImage, @SystemDir & "\shell32.dll", 3) ; 4 = Folder closed
	_GUIImageList_AddIcon($hImage, @SystemDir & "\shell32.dll", 7) ; 8 = USB
	_GUIImageList_AddIcon($hImage, @SystemDir & "\shell32.dll", 4) ; 5 = Folder open
	_GUIImageList_AddIcon($hImage, @SystemDir & "\shell32.dll", 11) ; 12 = CD-ROM
	_GUIImageList_AddIcon($hImage, @SystemDir & "\shell32.dll", 9) ; 10 = Networkdrive connected
	_GUIImageList_AddIcon($hImage, @SystemDir & "\shell32.dll", 10) ; 11 =Networkdrive disconnected
	_GUIImageList_AddIcon($hImage, @SystemDir & "\shell32.dll", 34) ; 35 = Desktop

	Local $aDrives, $hChild, $i
	_GUICtrlTreeView_SetUnicodeFormat($hTreeView, True)
	_GUICtrlTreeView_BeginUpdate($hTreeView)
	$hWndTreeView = $hTreeView
	GUIRegisterMsg($WM_NOTIFY, "MY_WM_NOTIFY_ShellTristateTreeView")
	_GUICtrlTreeView_SetNormalImageList($hWndTreeView, $hImage)
	$RootItem = _GUICtrlTreeView_Add($hWndTreeView, 0, $sFolderName_MyComputer & " (" & @ComputerName & ")", 0, 0)

	$aDrives = DriveGetDrive("ALL")
	Dim $aDriveLabel[UBound($aDrives)]

	For $i = 1 To $aDrives[0]
		$aDrives[$i] = StringUpper($aDrives[$i])
		If DriveGetLabel($aDrives[$i]) Then
			$aDriveLabel[$i] = DriveGetLabel($aDrives[$i]) & " (" & $aDrives[$i] & ")"
		Else
			$aDriveLabel[$i] = "(" & $aDrives[$i] & ")"
		EndIf
	Next

	$hMyDesktop = _GUICtrlTreeView_AddChild($hWndTreeView, $RootItem, $sFolderName_Desktop, 9, 9)
	_ShellTreeView_GetSelected($hWndTreeView, _MyDesktopDir(), $hMyDesktop, False, True)

	$hMyDocs = _GUICtrlTreeView_AddChild($hWndTreeView, $RootItem, $sFolderName_MyDocuments, 3, 3)
	_ShellTreeView_GetSelected($hWndTreeView, _MyDocumentsDir(), $hMyDocs, False, True)

	If StringInStr(FileGetAttrib(RegRead("HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\Shell Folders", "My Video")), "D") Then
		$hMyVideo = _GUICtrlTreeView_AddChild($hWndTreeView, $RootItem, $sFolderName_MyVideo, 3, 3)
		_ShellTreeView_GetSelected($hWndTreeView, _MyVideoDir(), $hMyVideo, False, True)
	EndIf

	;$hCommonDocs = _GUICtrlTreeView_AddChild($hWndTreeView, $RootItem, $sFolderName_SharedDocuments, 3, 3)
	;_ShellTreeView_GetSelected($hWndTreeView, _DocumentsCommonDir(), $hCommonDocs, False, True)

	For $i = 1 To $aDrives[0]
		Switch DriveGetType($aDrives[$i])
			Case "Removable"
				If ($aDrives[$i] = "a:") Or ($aDrives[$i] = "b:") Then
					$hChild = _GUICtrlTreeView_AddChild($hWndTreeView, $RootItem, $aDriveLabel[$i], 1, 1)
				Else
					$hChild = _GUICtrlTreeView_AddChild($hWndTreeView, $RootItem, $aDriveLabel[$i], 4, 4)
				EndIf
				_ShellTreeView_GetSelected($hWndTreeView, $aDrives[$i], $hChild, False, True)
			Case "Fixed"
				$drivespacefree = DriveSpaceFree($aDrives[$i]) * 1024 * 1024
				$drivespacetotal = DriveSpaceTotal($aDrives[$i]) * 1024 * 1024
				Switch $drivespacetotal
					Case 1 To 1023
						$drivespace = _StringAddThousandsSepEx(Round($drivespacefree, 1)) & '/' & _StringAddThousandsSepEx(Round($drivespacetotal, 1)) & " Bytes"
					Case 1024 To (1024 * 1024) - 1
						$drivespace = _StringAddThousandsSepEx(Round($drivespacefree / 1024, 1)) & '/' & _StringAddThousandsSepEx(Round($drivespacetotal / 1024, 1)) & " KB"
					Case (1024 * 1024) To (1024 * 1024 * 1024) - 1
						$drivespace = _StringAddThousandsSepEx(Round($drivespacefree / (1024 * 1024), 1)) & '/' & _StringAddThousandsSepEx(Round($drivespacetotal / (1024 * 1024), 1)) & " MB"
					Case (1024 * 1024 * 1024) To (1024 * 1024 * 1024 * 1024) - 1
						$drivespace = _StringAddThousandsSepEx(Round($drivespacefree / (1024 * 1024 * 1024), 1)) & '/' & _StringAddThousandsSepEx(Round($drivespacetotal / (1024 * 1024 * 1024), 1)) & " GB"
					Case Else
						$drivespace = _StringAddThousandsSepEx(Round($drivespacefree / (1024 * 1024 * 1024 * 1024), 1)) & '/' & _StringAddThousandsSepEx(Round($drivespacetotal / (1024 * 1024 * 1024 * 1024), 1)) & " TB"
				EndSwitch

				$hChild = _GUICtrlTreeView_AddChild($hWndTreeView, $RootItem, $aDriveLabel[$i], 2, 2)
				_ShellTreeView_GetSelected($hWndTreeView, $aDrives[$i], $hChild, False, True)
			Case "CDROM"
				$hChild = _GUICtrlTreeView_AddChild($hWndTreeView, $RootItem, $aDriveLabel[$i], 6, 6)
				_ShellTreeView_GetSelected($hWndTreeView, $aDrives[$i], $hChild, False, True)
			Case "Network"
				If $iIncludeNetworkDrives = True Then
					$hChild = _GUICtrlTreeView_AddChild($hWndTreeView, $RootItem, $aDriveLabel[$i], 7, 7)
					_ShellTreeView_GetSelected($hWndTreeView, $aDrives[$i], $hChild, False, True)
				EndIf
		EndSwitch
		If DriveStatus($aDrives[$i]) <> "READY" Then
			SetItemState($hWndTreeView, $hChild, 4)
		EndIf
	Next

	_GUICtrlTreeView_EndUpdate($hWndTreeView)

EndFunc   ;==>_ShellTreeView_Create


Func _DocumentsCommonDir()
	Local $sDocumentsCommonDir = @DocumentsCommonDir
	$sDocumentsCommonDir = StringUpper(StringLeft($sDocumentsCommonDir, 1)) & StringRight($sDocumentsCommonDir, StringLen($sDocumentsCommonDir) - 1)
	If StringRight($sDocumentsCommonDir, 1) <> "\" Then
		Return $sDocumentsCommonDir & "\"
	Else
		Return $sDocumentsCommonDir
	EndIf
EndFunc   ;==>_DocumentsCommonDir

Func _MyDocumentsDir()
	Local $sMyDocumentsDir = @MyDocumentsDir
	$sMyDocumentsDir = StringUpper(StringLeft($sMyDocumentsDir, 1)) & StringRight($sMyDocumentsDir, StringLen($sMyDocumentsDir) - 1)
	If StringRight($sMyDocumentsDir, 1) <> "\" Then
		Return $sMyDocumentsDir & "\"
	Else
		Return $sMyDocumentsDir
	EndIf
EndFunc   ;==>_MyDocumentsDir

Func _MyDesktopDir()
	Local $sDesktopDir = @DesktopDir
	$sDesktopDir = StringUpper(StringLeft($sDesktopDir, 1)) & StringRight($sDesktopDir, StringLen($sDesktopDir) - 1)
	If StringRight($sDesktopDir, 1) <> "\" Then
		Return $sDesktopDir & "\"
	Else
		Return $sDesktopDir
	EndIf
EndFunc   ;==>_MyDesktopDir

Func _MyVideoDir()
	Local $sMyVideoDir = RegRead("HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\Shell Folders", "My Video")
	$sMyVideoDir = StringUpper(StringLeft($sMyVideoDir, 1)) & StringRight($sMyVideoDir, StringLen($sMyVideoDir) - 1)
	If StringRight($sMyVideoDir, 1) <> "\" Then
		Return $sMyVideoDir & "\"
	Else
		Return $sMyVideoDir
	EndIf
EndFunc   ;==>_MyVideoDir



; #FUNCTION# ==================================================================================================
; Name............: _ShellTreeView_GetSelected
; Description.....: Add TreeView items with directorys structures
; Syntax..........: _ShellTreeView_GetSelected($hWndTreeView, $sDrive, $hControl)
; Parameter(s)....: 	$hTreeView - Handle to the TreeView control
;						$sDrive    - String contains drive letter or text of selected TreeView item
;						$hControl  - Child handle
;						$bManualSelect = false - set to true to manually retrieve info on selected item, prevents update of childs
;						$bInitTree = false - true for first build of tree only (see _ShellTreeView_Create())
; Return value(s).: A full path to a selected directory
; Note(s).........: Tested on AutoIt 3.2.12.1 and Windows XP SP2
; Author(s).......: R.Gilman (a.k.a. rasim)
;					KaFu
; ====================================================================================================

Func _ShellTreeView_GetSelected($hWndTreeView, $sDrive, $hControl, $bManualSelect = False, $bInitTree = False)
	; Handle Common Dirs

	If GetItemState($hWndTreeView, $hControl) = 4 Then Return

	If $sDrive = $sFolderName_MyComputer & " (" & @ComputerName & ")" Then Return $sDrive

	Switch _IsDocDir($sDrive, $hControl)
		Case 1
			$sDrive = _DocumentsCommonDir()
		Case 2
			$sDrive = _MyDocumentsDir()
		Case 3
			$sDrive = _MyDesktopDir()
		Case 4
			$sDrive = _MyVideoDir()
	EndSwitch

	If StringInStr($sDrive, ":") And $sDrive <> _DocumentsCommonDir() And $sDrive <> _MyDocumentsDir() And $sDrive <> _MyDesktopDir() And $sDrive <> _MyVideoDir() Then
		$sDrive = StringLeft(StringRight($sDrive, 3), 2) & "\"
		If DriveStatus(StringLeft($sDrive, 2)) = "NOTREADY" Then
			Return $sDrive
		EndIf
	EndIf

	If (Not FileExists($sDrive) Or Not StringInStr($sDrive, ":")) Then ; stringinstr to capture search for directories in @scriptdir :lol:

		Local $hParent = _GUICtrlTreeView_GetParentHandle($hWndTreeView, $hControl), $iFullPath
		If _GUICtrlTreeView_GetText($hWndTreeView, $hParent) = $sFolderName_SharedDocuments Then
			$iFullPath = _DocumentsCommonDir() & $sDrive
		ElseIf _GUICtrlTreeView_GetText($hWndTreeView, $hParent) = $sFolderName_MyDocuments Then
			$iFullPath = _MyDocumentsDir() & $sDrive
		ElseIf _GUICtrlTreeView_GetText($hWndTreeView, $hParent) = $sFolderName_Desktop Then
			$iFullPath = _MyDesktopDir() & $sDrive
		ElseIf _GUICtrlTreeView_GetText($hWndTreeView, $hParent) = $sFolderName_MyVideo Then
			$iFullPath = _MyVideoDir() & $sDrive
		Else
			If StringInStr(_GUICtrlTreeView_GetText($hWndTreeView, $hParent), ":") Then
				$FullPathParent = StringLeft(StringRight(_GUICtrlTreeView_GetText($hWndTreeView, $hParent), 3), 2) & "\"
			Else
				$FullPathParent = _GUICtrlTreeView_GetText($hWndTreeView, $hParent) & "\"
			EndIf
			$iFullPath = $FullPathParent & $sDrive
		EndIf

		While 1
			If $hParent = 0 Then
				If DriveStatus(StringLeft($sDrive, 2)) = "NOTREADY" Then
					Return $sDrive
				Else
					Return
				EndIf
			EndIf

			If FileExists($iFullPath) Then
				If Not StringInStr(StringRight($iFullPath, 1), "\") Then $iFullPath = $iFullPath & "\"
				ExitLoop
			EndIf

			$hParent = _GUICtrlTreeView_GetParentHandle($hWndTreeView, $hParent)
			If _GUICtrlTreeView_GetText($hWndTreeView, $hParent) = $sFolderName_SharedDocuments Then
				$iFullPath = _DocumentsCommonDir() & $iFullPath
			ElseIf _GUICtrlTreeView_GetText($hWndTreeView, $hParent) = $sFolderName_MyDocuments Then
				$iFullPath = _MyDocumentsDir() & $iFullPath
			ElseIf _GUICtrlTreeView_GetText($hWndTreeView, $hParent) = $sFolderName_MyVideo Then
				$iFullPath = _MyVideoDir() & $iFullPath
			ElseIf _GUICtrlTreeView_GetText($hWndTreeView, $hParent) = $sFolderName_Desktop Then
				$iFullPath = _MyDesktopDir() & $iFullPath
			Else
				If StringInStr(_GUICtrlTreeView_GetText($hWndTreeView, $hParent), ":") Then
					$FullPathParent = StringLeft(StringRight(_GUICtrlTreeView_GetText($hWndTreeView, $hParent), 3), 2) & "\"
				Else
					$FullPathParent = _GUICtrlTreeView_GetText($hWndTreeView, $hParent) & "\"
				EndIf
				$iFullPath = $FullPathParent & $iFullPath
				;ConsoleWrite("STTV: " & $iFullPath & @crlf)
			EndIf
		WEnd
		$sDrive = $iFullPath
	EndIf

	If $bManualSelect = False Then
		If FileExists($sDrive) Then
			_GUICtrlTreeView_BeginUpdate($hWndTreeView)
			If _GUICtrlTreeView_ExpandedOnce($hWndTreeView, $hControl) = False Then
				_GUICtrlTreeView_DeleteChildren($hWndTreeView, $hControl)
				_GetFolders($hWndTreeView, $hControl, $sDrive, $bInitTree)
			EndIf
			_GUICtrlTreeView_EndUpdate($hWndTreeView)
		EndIf
	EndIf

	Return $sDrive

EndFunc   ;==>_ShellTreeView_GetSelected

Func _GetFolders($hWndTreeView, $hControl, $sDrive, $bInitTree)
	Local $aFiles[1], $aFiles_sub[1], $i, $y

	$aFilesSize = DirGetSize($sDrive, 3)
	$hSearch = FileFindFirstFile($sDrive & "\*.*")

	If $aFilesSize[2] = 0 Then Return

	ReDim $aFiles[$aFilesSize[2]]

	$i = 0
	While Not @error ; first file found
		;ConsoleWrite($aFilesSize[2] & @TAB & $i & @crlf )
		$aFiles_new = FileFindNextFile($hSearch)
		If @error Then ExitLoop ; next file found
		If StringInStr(FileGetAttrib($sDrive & $aFiles_new), "D") Then
			$aFiles[$i] = $aFiles_new
			$i += 1
		EndIf
	WEnd
	FileClose($hSearch)
	;_ArrayDelete($aFiles,UBound($aFiles))
	_ArraySort($aFiles)
	;_ArrayDisplay($aFiles)

	For $i = 0 To UBound($aFiles) - 1
		$iSubChild = _GUICtrlTreeView_AddChild($hWndTreeView, $hControl, $aFiles[$i], 3, 5)
		If GUICtrlRead($c_Checkbox_SearchFor_Recursive) = 1 Then
			If MyCtrlGetItemState($hWndTreeView, $hControl) <> 4 Then MyCtrlSetItemState($hWndTreeView, $iSubChild, MyCtrlGetItemState($hWndTreeView, $hControl))
		EndIf

		If $bInitTree = False Then
			$aFiles_subSize = DirGetSize($sDrive & $aFiles[$i], 3)
			If $aFiles_subSize[2] = 0 Then ContinueLoop
			ReDim $aFiles_sub[$aFiles_subSize[2]]
			$hSearchSub = FileFindFirstFile($sDrive & $aFiles[$i] & "\*.*")
			$y = 0
			While Not @error ; first file found
				$aFiles_sub_new = FileFindNextFile($hSearchSub)
				If @error Then ExitLoop ; next file found
				If StringInStr(FileGetAttrib($sDrive & $aFiles[$i] & "\" & $aFiles_sub_new), "D") Then
					$aFiles_sub[$y] = $aFiles_sub_new
					$y += 1
				EndIf
			WEnd
			FileClose($hSearchSub)
			;_ArrayDelete($aFiles_sub,UBound($aFiles_sub))
			_ArraySort($aFiles_sub)
			For $y = 0 To UBound($aFiles_sub) - 1
				$iSubChildsub = _GUICtrlTreeView_AddChild($hWndTreeView, $iSubChild, $aFiles_sub[$y], 3, 5)
				If GUICtrlRead($c_Checkbox_SearchFor_Recursive) = 1 Then
					If MyCtrlGetItemState($hWndTreeView, $iSubChild) <> 4 Then MyCtrlSetItemState($hWndTreeView, $iSubChildsub, MyCtrlGetItemState($hWndTreeView, $iSubChild))
				EndIf
			Next
		EndIf
	Next

EndFunc   ;==>_GetFolders

Func _IsDocDir($sPath, $hControl)
	If $sPath = $sFolderName_SharedDocuments And ($hControl = $hCommonDocs) Then
		Return 1
	ElseIf $sPath = $sFolderName_MyDocuments And ($hControl = $hMyDocs) Then
		Return 2
	ElseIf $sPath = $sFolderName_Desktop And ($hControl = $hMyDesktop) Then
		Return 3
	ElseIf $sPath = $sFolderName_MyVideo And ($hControl = $hMyVideo) Then
		Return 4
	Else
		Return False
	EndIf
EndFunc   ;==>_IsDocDir

;**********************************************************
; Get an item state
;**********************************************************
Func MyCtrlGetItemState($hTV, $nID)

	$nState = GetItemState($hTV, $nID)

	Switch $nState
		Case 1
			$nState = $GUI_UNCHECKED
		Case 2
			$nState = $GUI_CHECKED
		Case 3
			$nState = $GUI_INDETERMINATE
		Case 4
			$nState = BitOR($GUI_DISABLE, $GUI_UNCHECKED)
		Case 5
			$nState = BitOR($GUI_DISABLE, $GUI_CHECKED)
		Case Else
			Return 0
	EndSwitch

	Return $nState
EndFunc   ;==>MyCtrlGetItemState


;**********************************************************
; Set an item state
;**********************************************************
Func MyCtrlSetItemState($hTV, $nID, $nState)

	Switch $nState
		Case $GUI_UNCHECKED
			$nState = 1
		Case $GUI_CHECKED
			$nState = 2
		Case $GUI_INDETERMINATE
			$nState = 3
		Case BitOR($GUI_DISABLE, $GUI_UNCHECKED)
			$nState = 4
		Case BitOR($GUI_DISABLE, $GUI_CHECKED)
			$nState = 5
		Case Else
			Return
	EndSwitch

	SetItemState($hTV, $nID, $nState)
	CheckChildItems($hTV, $nID, $nState)
	CheckParents($hTV, $nID, $nState)

EndFunc   ;==>MyCtrlSetItemState


;**********************************************************
; Helper functions
;**********************************************************
Func CheckChildItems($hWnd, $hItem, $nState)
	Local $hChild = SendMessage($hWnd, $TVM_GETNEXTITEM, $TVGN_CHILD, $hItem)
	While $hChild > 0
		If GetItemState($hWnd, $hChild) <> 4 Then SetItemState($hWnd, $hChild, $nState)
		CheckChildItems($hWnd, $hChild, $nState)
		$hChild = SendMessage($hWnd, $TVM_GETNEXTITEM, $TVGN_NEXT, $hChild)
	WEnd
EndFunc   ;==>CheckChildItems


Func CheckParents($hWnd, $hItem, $nState)
	Local $nTmpState1 = 0, $nTmpState2 = 0
	Local $bDiff = 0
	Local $i = 0

	Local $hParent = SendMessage($hWnd, $TVM_GETNEXTITEM, $TVGN_PARENT, $hItem)

	If $hParent > 0 Then
		Local $hChild = SendMessage($hWnd, $TVM_GETNEXTITEM, $TVGN_CHILD, $hParent)

		If $hChild > 0 Then
			Do
				$i += 1

				If $hChild = $hItem Then
					$nTmpState2 = $nState
				Else
					$nTmpState2 = GetItemState($hWnd, $hChild)
				EndIf

				If $i = 1 Then $nTmpState1 = $nTmpState2

				If $nTmpState1 <> $nTmpState2 Then
					$bDiff = 1
					ExitLoop
				EndIf

				$hChild = SendMessage($hWnd, $TVM_GETNEXTITEM, $TVGN_NEXT, $hChild)

			Until $hChild <= 0

			If $bDiff Then
				SetItemState($hWnd, $hParent, 3)
				$nState = 3
			ElseIf $nState = 1 Then
				SetItemState($hWnd, $hParent, 1)
				$nState = 1
			ElseIf $i = 1 Then
				SetItemState($hWnd, $hParent, 3)
				$nState = 3
			EndIf
		EndIf

		CheckParents($hWnd, $hParent, $nState)
	EndIf
EndFunc   ;==>CheckParents



Func SetItemState($hWnd, $hItem, $nState)
	$nState = BitShift($nState, -12)

	Local $tvItem = DllStructCreate("uint;dword;uint;uint;ptr;int;int;int;int;int;int")

	DllStructSetData($tvItem, 1, $TVIF_STATE)
	DllStructSetData($tvItem, 2, $hItem)
	DllStructSetData($tvItem, 3, $nState)
	DllStructSetData($tvItem, 4, $TVIS_STATEIMAGEMASK)

	SendMessage($hWnd, $TVM_SETITEM, 0, DllStructGetPtr($tvItem))
EndFunc   ;==>SetItemState


Func GetItemState($hWnd, $hItem)
	Local $tvItem = DllStructCreate("uint;dword;uint;uint;ptr;int;int;int;int;int;int")
	DllStructSetData($tvItem, 1, $TVIF_STATE)
	DllStructSetData($tvItem, 2, $hItem)
	DllStructSetData($tvItem, 4, $TVIS_STATEIMAGEMASK)
	SendMessage($hWnd, $TVM_GETITEM, 0, DllStructGetPtr($tvItem))
	Local $nState = DllStructGetData($tvItem, 3)
	$nState = BitAND($nState, $TVIS_STATEIMAGEMASK)
	$nState = BitShift($nState, 12)
	Return $nState
EndFunc   ;==>GetItemState


Func LoadStateImage($hTreeView, $sFile)
	Local $hWnd = GUICtrlGetHandle($hTreeView)
	If $hWnd = 0 Then $hWnd = $hTreeView

	Local $hImageList = 0

	;	If @Compiled Then
	;		Local $hModule = LoadLibrary(@ScriptFullPath)
	;		$hImageList = ImageList_LoadImage($hModule, "#170", 16, 1, $CLR_NONE, $IMAGE_BITMAP, BitOr($LR_LOADTRANSPARENT, $LR_CREATEDIBSECTION))
	;	Else
	;		$hImageList = ImageList_LoadImage(0, $sFile, 16, 1, $CLR_NONE, $IMAGE_BITMAP, BitOr($LR_LOADFROMFILE, $LR_LOADTRANSPARENT, $LR_CREATEDIBSECTION))
	;	EndIf

	$hImageList = ImageList_LoadImage(0, $sFile, 16, 1, $CLR_NONE, $IMAGE_BITMAP, BitOR($LR_LOADFROMFILE, $LR_LOADTRANSPARENT, $LR_CREATEDIBSECTION))

	SendMessage($hWnd, $TVM_SETIMAGELIST, $TVSIL_STATE, $hImageList)
	InvalidateRect($hWnd, 0, 1)
EndFunc   ;==>LoadStateImage


;**********************************************************
; Win32-API functions
;**********************************************************
Func SendMessage($hWnd, $Msg, $wParam, $lParam)
	$nResult = DllCall("user32.dll", "int", "SendMessage", _
			"hwnd", $hWnd, _
			"int", $Msg, _
			"int", $wParam, _
			"int", $lParam)
	Return $nResult[0]
EndFunc   ;==>SendMessage


Func GetWindowLong($hWnd, $nIndex)
	$nResult = DllCall("user32.dll", "int", "GetWindowLong", "hwnd", $hWnd, "int", $nIndex)
	Return $nResult[0]
EndFunc   ;==>GetWindowLong


Func GetCursorPos($Point)
	DllCall("user32.dll", "int", "GetCursorPos", "ptr", DllStructGetPtr($Point))
EndFunc   ;==>GetCursorPos


Func ScreenToClient($hWnd, $Point)
	DllCall("user32.dll", "int", "ScreenToClient", "hwnd", $hWnd, "ptr", DllStructGetPtr($Point))
EndFunc   ;==>ScreenToClient


Func InvalidateRect($hWnd, $lpRect, $bErase)
	DllCall("user32.dll", "int", "InvalidateRect", _
			"hwnd", $hWnd, _
			"ptr", $lpRect, _
			"int", $bErase)
EndFunc   ;==>InvalidateRect


Func LoadLibrary($sFile)
	Local $hModule = DllCall("kernel32.dll", "hwnd", "LoadLibrary", "str", $sFile)
	Return $hModule[0]
EndFunc   ;==>LoadLibrary


Func ImageList_LoadImage($hInst, $sFile, $cx, $cGrow, $crMask, $uType, $uFlags)
	Local $hImageList = DllCall("comctl32.dll", "hwnd", "ImageList_LoadImage", _
			"hwnd", $hInst, _
			"str", $sFile, _
			"int", $cx, _
			"int", $cGrow, _
			"int", $crMask, _
			"int", $uType, _
			"int", $uFlags)
	Return $hImageList[0]
EndFunc   ;==>ImageList_LoadImage


Func DestroyImageList()
	DllCall("comctl32.dll", "int", "ImageList_Destroy", "hwnd", $hImageList)
EndFunc   ;==>DestroyImageList










; #FUNCTION# ====================================================================================================================
; Name...........: _StringAddThousandsSepEx
; Description ...: Returns the original numbered string with the Thousands delimiter inserted.
; Syntax.........: _StringAddThousandsSep($sString[, $sThousands = -1[, $sDecimal = -1]])
; Parameters ....: $sString    - The string to be converted.
;                  $sThousands - Optional: The Thousands delimiter
;                  $sDecimal   - Optional: The decimal delimiter
; Return values .: Success - The string with Thousands delimiter added.
; Author ........: SmOke_N (orignal _StringAddComma
; Modified.......: Valik (complete re-write, new function name), KaFu (copied from 3.3.0.0, as function is deprecated in newer AU versions)
; Remarks .......:
; Related .......:
; Link ..........;
; Example .......; Yes
; ===============================================================================================================================
Func _StringAddThousandsSepEx($sString, $sThousands = -1, $sDecimal = -1)
	Local $sResult = "" ; Force string
	Local $rKey = "HKCU\Control Panel\International"
	If $sDecimal = -1 Then $sDecimal = RegRead($rKey, "sDecimal")
	If $sThousands = -1 Then $sThousands = RegRead($rKey, "sThousand")
;~ 	Local $aNumber = StringRegExp($sString, "(\d+)\D?(\d*)", 1)
	Local $aNumber = StringRegExp($sString, "(\D?\d+)\D?(\d*)", 1) ; This one works for negatives.
	If UBound($aNumber) = 2 Then
		Local $sLeft = $aNumber[0]
		While StringLen($sLeft)
			$sResult = $sThousands & StringRight($sLeft, 3) & $sResult
			$sLeft = StringTrimRight($sLeft, 3)
		WEnd
;~ 		$sResult = StringTrimLeft($sResult, 1) ; Strip leading thousands separator
		$sResult = StringTrimLeft($sResult, StringLen($sThousands)) ; Strip leading thousands separator
		If $aNumber[1] <> "" Then $sResult &= $sDecimal & $aNumber[1]
	EndIf
	Return $sResult
EndFunc   ;==>_StringAddThousandsSepEx
