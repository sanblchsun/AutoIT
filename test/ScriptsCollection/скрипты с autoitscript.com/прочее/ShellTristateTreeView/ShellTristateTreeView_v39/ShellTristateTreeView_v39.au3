#include-once
#include <GuiTreeView.au3>
#include <GuiImageList.au3>
#include <WindowsConstants.au3>

;===============================================================================
;
; Program Name:   	ShellTristateTreeView.au3
;					build02
;
;					AutoIt Version: 3.3.0.0
;
; Author(s):        Rasim (ShellTreeView.au3)
;					Holger Kotsch (TristateTreeViewLib.au3)
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

; http://www.autoitscript.com/forum/index.php?showtopic=107303&st=0&p=756879&hl=OSBuild&fromsearch=1&#entry756879
; NerdFencer
; #CONSTANTS# ===================================================================================================================
Global Const $Macro_SysNone = 0 ; Pre-Win2k
Global Const $Macro_Sys2000 = 1 ; Win2k line (Home Editions+server2000)
Global Const $Macro_Sys2003 = 2 ; WinXP line (Home Editions+server2003)
Global Const $Macro_Sys2008 = 3 ; WinVista line (Home Editions+server2008)
Global Const $Macro_Sys2010 = 4 ; Win7 line (Home Editions+server2008R2)

; @OSBuild
Global Const $MACRO_OSBUILD_NT31 = "528"
Global Const $MACRO_OSBUILD_NT35 = "807"
Global Const $MACRO_OSBUILD_NT351 = "1057"
Global Const $MACRO_OSBUILD_NT4 = "1381"
Global Const $MACRO_OSBUILD_NT5 = "2195"
Global Const $MACRO_OSBUILD_NT51 = "2600"
Global Const $MACRO_OSBUILD_NT52 = "3790"
Global Const $MACRO_OSBUILD_2000 = "2195"
Global Const $MACRO_OSBUILD_XP_ERA = "2600"
Global Const $MACRO_OSBUILD_XP_64_ERA = "3790"
Global Const $MACRO_OSBUILD_VISTA_ERA = "6000"
Global Const $MACRO_OSBUILD_VISTA_ERA_SP1 = "6001"
Global Const $MACRO_OSBUILD_VISTA_ERA_SP2 = "6002"
Global Const $MACRO_OSBUILD_7_ERA = "7600"
Global Const $MACRO_OSBUILD_XP = "2600"
Global Const $MACRO_OSBUILD_XP_64 = "3790"
Global Const $MACRO_OSBUILD_SERVER_2003 = "2600"
Global Const $MACRO_OSBUILD_SERVER_2003_SP2 = "2721"
Global Const $MACRO_OSBUILD_SERVER_2003_Beta2 = "2805"
Global Const $MACRO_OSBUILD_SERVER_2003_Latest = "3959"
Global Const $MACRO_OSBUILD_SERVER_2003_64 = "3790"
Global Const $MACRO_OSBUILD_SERVER_HOME = "3790"
Global Const $MACRO_OSBUILD_VISTA = "6000"
Global Const $MACRO_OSBUILD_VISTA_SP1 = "6001"
Global Const $MACRO_OSBUILD_VISTA_SP2 = "6002"
Global Const $MACRO_OSBUILD_SERVER_2008 = "6000"
Global Const $MACRO_OSBUILD_SERVER_2008_SP2 = "6002"
Global Const $MACRO_OSBUILD_7 = "7600"
Global Const $MACRO_OSBUILD_SERVER_2008_R2 = "7600"

; @OSVersion
Global Const $MACRO_OS_SERVER_2008_R2 = "WIN_2008R2"
Global Const $MACRO_OS_SERVER_2008 = "WIN_2008"
Global Const $MACRO_OS_7 = "WIN_7"
Global Const $MACRO_OS_VISTA = "WIN_VISTA"
Global Const $MACRO_OS_SERVER_2003 = "WIN_2003"
Global Const $MACRO_OS_XP = "WIN_XP"
Global Const $MACRO_OS_XPE = "WIN_XPe"
Global Const $MACRO_OS_2000 = "WIN_2000"
; #CONSTANTS# ===================================================================================================================

Global $PlatformCompatabillity = _Macro_GetPlatformCompatabillity()

If Not IsDeclared("LR_LOADFROMFILE")		Then	Global Const $LR_LOADFROMFILE			= 0x0010
If Not IsDeclared("LR_LOADTRANSPARENT")		Then	Global Const $LR_LOADTRANSPARENT		= 0x0020
If Not IsDeclared("LR_CREATEDIBSECTION")	Then	Global Const $LR_CREATEDIBSECTION		= 0x2000
;If Not IsDeclared("CLR_NONE")				Then	Global Const $CLR_NONE					= 0xFFFFFFFF
If Not IsDeclared("IMAGE_BITMAP")			Then	Global Const $IMAGE_BITMAP				= 0
If Not IsDeclared("VK_SPACE") Then Global Const $VK_SPACE = 32
If Not IsDeclared("GWL_STYLE")				Then	Global Const $GWL_STYLE					= -16

Global $hImage, $hImageList, $hWndTreeView, $hCommonDocs, $hMyDocs, $hMyDesktop;, $hMyVideo
Global $RootItem, $aTreeViewItemState


Global $sFolderName_MyComputer = "My Computer"
$sRegString = RegRead('HKEY_CLASSES_ROOT\CLSID\{20D04FE0-3AEA-1069-A2D8-08002B30309D}', '')
If $sRegString Then $sFolderName_MyComputer = $sRegString

Global $sFolderName_Desktop = "Desktop"
$sRegString = RegRead("HKEY_USERS\.DEFAULT\Software\Microsoft\Windows\CurrentVersion\Explorer\User Shell Folders", "Desktop")
If $sRegString Then $sFolderName_Desktop = StringRight($sRegString, StringLen($sRegString) - StringInStr($sRegString, "\", 0, -1))

If $PlatformCompatabillity < 3 Then

	Global $sFolderName_MyDocuments = "My Documents"
	$sRegString = RegRead('HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\CLSID\{450D8FBA-AD25-11D0-98A8-0800361B1103}', '')
	If $sRegString Then $sFolderName_MyDocuments = StringRight($sRegString, StringLen($sRegString) - StringInStr($sRegString, "\", 0, -1))

	; Global $sFolderName_SharedDocuments = "Shared Documents"
	; $sRegString = RegRead("HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Shell Folders", "Common Documents")
	; If $sRegString Then $sFolderName_SharedDocuments = StringRight($sRegString, StringLen($sRegString) - StringInStr($sRegString, "\", 0, -1))

Else

	Global $sFolderName_MyDocuments = @UserName

EndIf

; Global $sFolderName_MyVideo = "My Video"
; $sRegString = RegRead("HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\Shell Folders", "My Video")
;$sRegString = RegRead("HKEY_USERS\.DEFAULT\Software\Microsoft\Windows\CurrentVersion\Explorer\User Shell Folders", "My Video")
; If $sRegString Then $sFolderName_MyVideo = StringRight($sRegString, StringLen($sRegString) - StringInStr($sRegString, "\", 0, -1))


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

	#cs
		For $i = 1 To $aDrives[0]
		$aDrives[$i] = StringUpper($aDrives[$i])
		If DriveGetLabel($aDrives[$i]) Then
		$aDriveLabel[$i] = DriveGetLabel($aDrives[$i]) & " (" & $aDrives[$i] & ")"
		Else
		$aDriveLabel[$i] = "(" & $aDrives[$i] & ")"
		EndIf
		Next
	#ce

	$hMyDesktop = _GUICtrlTreeView_AddChild($hWndTreeView, $RootItem, $sFolderName_Desktop, 9, 9)
	_ShellTreeView_GetSelected($hWndTreeView, _MyDesktopDir(), $hMyDesktop, False, True)

	;If $PlatformCompatabillity < 3 Then
	$hMyDocs = _GUICtrlTreeView_AddChild($hWndTreeView, $RootItem, $sFolderName_MyDocuments, 3, 3)
	_ShellTreeView_GetSelected($hWndTreeView, _MyDocumentsDir(), $hMyDocs, False, True)
	;EndIf

	#cs
		If StringInStr(FileGetAttrib(RegRead("HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\Shell Folders", "My Video")), "D") Then
		$hMyVideo = _GUICtrlTreeView_AddChild($hWndTreeView, $RootItem, $sFolderName_MyVideo, 3, 3)
		_ShellTreeView_GetSelected($hWndTreeView, _MyVideoDir(), $hMyVideo, False, True)
		EndIf
	#ce

	;$hCommonDocs = _GUICtrlTreeView_AddChild($hWndTreeView, $RootItem, $sFolderName_SharedDocuments, 3, 3)
	;_ShellTreeView_GetSelected($hWndTreeView, _DocumentsCommonDir(), $hCommonDocs, False, True)

	For $i = 1 To $aDrives[0]
		$aDrives[$i] = StringUpper($aDrives[$i])
		If $iIncludeNetworkDrives = False And DriveMapGet($aDrives[$i]) Then ContinueLoop
		If DriveGetLabel($aDrives[$i]) Then
			$aDriveLabel[$i] = DriveGetLabel($aDrives[$i]) & " (" & $aDrives[$i] & ")"
		Else
			$aDriveLabel[$i] = "(" & $aDrives[$i] & ")"
		EndIf

		Switch DriveGetType($aDrives[$i])
			Case "Removable"
				If ($aDrives[$i] = "a:") Or ($aDrives[$i] = "b:") Then
					$hChild = _GUICtrlTreeView_AddChild($hWndTreeView, $RootItem, $aDriveLabel[$i], 1, 1)
				Else
					$hChild = _GUICtrlTreeView_AddChild($hWndTreeView, $RootItem, $aDriveLabel[$i], 4, 4)
				EndIf
				_ShellTreeView_GetSelected($hWndTreeView, $aDrives[$i], $hChild, False, True)
			Case "Fixed"
				#cs
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
				#ce

				$hChild = _GUICtrlTreeView_AddChild($hWndTreeView, $RootItem, $aDriveLabel[$i], 2, 2)
				_ShellTreeView_GetSelected($hWndTreeView, $aDrives[$i], $hChild, False, True)
			Case "CDROM"
				$hChild = _GUICtrlTreeView_AddChild($hWndTreeView, $RootItem, $aDriveLabel[$i], 6, 6)
				_ShellTreeView_GetSelected($hWndTreeView, $aDrives[$i], $hChild, False, True)
			Case "Network"
				If $iIncludeNetworkDrives = False Then ContinueLoop
				$hChild = _GUICtrlTreeView_AddChild($hWndTreeView, $RootItem, $aDriveLabel[$i], 7, 7)
				_ShellTreeView_GetSelected($hWndTreeView, $aDrives[$i], $hChild, False, True)
		EndSwitch
		If DriveStatus($aDrives[$i]) <> "READY" Then
			_SetItemState($hWndTreeView, $hChild, 4)
		EndIf
	Next

	_GUICtrlTreeView_EndUpdate($hWndTreeView)

EndFunc   ;==>_ShellTreeView_Create


#cs
	Func _DocumentsCommonDir()
	Local $sDocumentsCommonDir = @DocumentsCommonDir
	$sDocumentsCommonDir = StringUpper(StringLeft($sDocumentsCommonDir, 1)) & StringRight($sDocumentsCommonDir, StringLen($sDocumentsCommonDir) - 1)
	If StringRight($sDocumentsCommonDir, 1) <> "\" Then
	Return $sDocumentsCommonDir & "\"
	Else
	Return $sDocumentsCommonDir
	EndIf
	EndFunc   ;==>_DocumentsCommonDir
#ce

Func _MyDocumentsDir()
	If $PlatformCompatabillity < 3 Then
		Local $sMyDocumentsDir = @MyDocumentsDir
		$sMyDocumentsDir = StringUpper(StringLeft($sMyDocumentsDir, 1)) & StringRight($sMyDocumentsDir, StringLen($sMyDocumentsDir) - 1)
		If StringRight($sMyDocumentsDir, 1) <> "\" Then
			Return $sMyDocumentsDir & "\"
		Else
			Return $sMyDocumentsDir
		EndIf

	Else
		Local $sMyDocumentsDir = @UserProfileDir
		$sMyDocumentsDir = StringUpper(StringLeft($sMyDocumentsDir, 1)) & StringRight($sMyDocumentsDir, StringLen($sMyDocumentsDir) - 1)
		If StringRight($sMyDocumentsDir, 1) <> "\" Then
			Return $sMyDocumentsDir & "\"
		Else
			Return $sMyDocumentsDir
		EndIf

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

#cs
	Func _MyVideoDir()
	Local $sMyVideoDir = RegRead("HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\Shell Folders", "My Video")
	$sMyVideoDir = StringUpper(StringLeft($sMyVideoDir, 1)) & StringRight($sMyVideoDir, StringLen($sMyVideoDir) - 1)
	If StringRight($sMyVideoDir, 1) <> "\" Then
	Return $sMyVideoDir & "\"
	Else
	Return $sMyVideoDir
	EndIf
	EndFunc   ;==>_MyVideoDir
#ce


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

	If _GetItemState($hWndTreeView, $hControl) = 4 Then Return

	If $sDrive = $sFolderName_MyComputer & " (" & @ComputerName & ")" Then Return $sDrive

	Switch _IsDocDir($sDrive, $hControl)
		;Case 1
		;	$sDrive = _DocumentsCommonDir()
		Case 2
			$sDrive = _MyDocumentsDir()
		Case 3
			$sDrive = _MyDesktopDir()
			;Case 4
			;	$sDrive = _MyVideoDir()
	EndSwitch

	;If StringInStr($sDrive, ":") And $sDrive <> _DocumentsCommonDir() And $sDrive <> _MyDocumentsDir() And $sDrive <> _MyDesktopDir() And $sDrive <> _MyVideoDir() Then
	If StringInStr($sDrive, ":") And $sDrive <> _MyDocumentsDir() And $sDrive <> _MyDesktopDir() Then
		$sDrive = StringLeft(StringRight($sDrive, 3), 2) & "\"
		If DriveStatus(StringLeft($sDrive, 2)) = "NOTREADY" Then
			Return $sDrive
		EndIf
	EndIf

	If (Not FileExists($sDrive) Or Not StringInStr($sDrive, ":")) Then ; stringinstr to capture search for directories in @scriptdir :lol:

		Local $hParent = _GUICtrlTreeView_GetParentHandle($hWndTreeView, $hControl), $iFullPath
		;If _GUICtrlTreeView_GetText($hWndTreeView, $hParent) = $sFolderName_SharedDocuments Then
		;	$iFullPath = _DocumentsCommonDir() & $sDrive

		;If $PlatformCompatabillity < 3 Then
		If _GUICtrlTreeView_GetText($hWndTreeView, $hParent) = $sFolderName_MyDocuments Then
			$iFullPath = _MyDocumentsDir() & $sDrive
		ElseIf _GUICtrlTreeView_GetText($hWndTreeView, $hParent) = $sFolderName_Desktop Then
			$iFullPath = _MyDesktopDir() & $sDrive
			;ElseIf _GUICtrlTreeView_GetText($hWndTreeView, $hParent) = $sFolderName_MyVideo Then
			;	$iFullPath = _MyVideoDir() & $sDrive
		Else
			If StringInStr(_GUICtrlTreeView_GetText($hWndTreeView, $hParent), ":") Then
				$FullPathParent = StringLeft(StringRight(_GUICtrlTreeView_GetText($hWndTreeView, $hParent), 3), 2) & "\"
			Else
				$FullPathParent = _GUICtrlTreeView_GetText($hWndTreeView, $hParent) & "\"
			EndIf
			$iFullPath = $FullPathParent & $sDrive
		EndIf
		#cs
			Else
			If _GUICtrlTreeView_GetText($hWndTreeView, $hParent) = $sFolderName_Desktop Then
			$iFullPath = _MyDesktopDir() & $sDrive
			;ElseIf _GUICtrlTreeView_GetText($hWndTreeView, $hParent) = $sFolderName_MyVideo Then
			;	$iFullPath = _MyVideoDir() & $sDrive
			Else
			If StringInStr(_GUICtrlTreeView_GetText($hWndTreeView, $hParent), ":") Then
			$FullPathParent = StringLeft(StringRight(_GUICtrlTreeView_GetText($hWndTreeView, $hParent), 3), 2) & "\"
			Else
			$FullPathParent = _GUICtrlTreeView_GetText($hWndTreeView, $hParent) & "\"
			EndIf
			$iFullPath = $FullPathParent & $sDrive
			EndIf

			EndIf
		#ce

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
			;If _GUICtrlTreeView_GetText($hWndTreeView, $hParent) = $sFolderName_SharedDocuments Then
			;	$iFullPath = _DocumentsCommonDir() & $iFullPath
			;If $PlatformCompatabillity < 3 Then
			If _GUICtrlTreeView_GetText($hWndTreeView, $hParent) = $sFolderName_MyDocuments Then
				$iFullPath = _MyDocumentsDir() & $iFullPath
				;ElseIf _GUICtrlTreeView_GetText($hWndTreeView, $hParent) = $sFolderName_MyVideo Then
				;	$iFullPath = _MyVideoDir() & $iFullPath
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
			#cs
				Else
				If _GUICtrlTreeView_GetText($hWndTreeView, $hParent) = $sFolderName_Desktop Then
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

				EndIf
			#ce
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

	; $aFilesSize = DirGetSize($sDrive, 3)
	; If $aFilesSize[2] = 0 Then Return

	$hSearch = FileFindFirstFile($sDrive & "\*.*")

	ReDim $aFiles[2]

	$i = 0
	While Not @error ; first file found
		;ConsoleWrite($aFilesSize[2] & @TAB & $i & @crlf )
		$aFiles_new = FileFindNextFile($hSearch)
		If @error Then ExitLoop ; next file found
		$sDirAttribs = FileGetAttrib($sDrive & $aFiles_new)
		If GUICtrlRead($c_Checkbox_HideSystemFiles) = 1 Then
			If StringInStr($sDirAttribs, "D") And Not StringInStr($sDirAttribs, "H") And Not StringInStr($sDirAttribs, "S") Then
				If UBound($aFiles) = $i Then ReDim $aFiles[UBound($aFiles) + 2]
				$aFiles[$i] = $aFiles_new
				$i += 1
			EndIf
		Else
			If StringInStr($sDirAttribs, "D") Then
				If UBound($aFiles) = $i Then ReDim $aFiles[UBound($aFiles) + 2]
				$aFiles[$i] = $aFiles_new
				$i += 1
			EndIf
		EndIf
	WEnd
	FileClose($hSearch)
	; if $sDrive = "H:\" then _ArrayDisplay($aFiles)
	;_ArrayDelete($aFiles,UBound($aFiles))
	If $i > 0 Then ; Valid dirs found
		;_ArraySort($aFiles, 1)
		ReDim $aFiles[$i]
		;_ArraySort($aFiles)
		_ArraySortClib($aFiles, 1)
	Else ; no Valid dirs found, might have found hidden dirs but return anyhow
		Return
	EndIf

	For $i = 0 To UBound($aFiles) - 1
		;ConsoleWrite($aFiles[$i] & @tab & StringLen($aFiles[$i]) & @crlf)
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
				$sDirAttribs = FileGetAttrib($sDrive & $aFiles[$i] & "\" & $aFiles_sub_new)
				If GUICtrlRead($c_Checkbox_HideSystemFiles) = 1 Then
					If StringInStr($sDirAttribs, "D") And Not StringInStr($sDirAttribs, "H") And Not StringInStr($sDirAttribs, "S") Then
						$aFiles_sub[$y] = $aFiles_sub_new
						$y += 1
						ExitLoop
					EndIf
				Else
					If StringInStr($sDirAttribs, "D") Then
						$aFiles_sub[$y] = $aFiles_sub_new
						$y += 1
						ExitLoop
					EndIf
				EndIf
			WEnd
			FileClose($hSearchSub)
			;_ArrayDelete($aFiles_sub,UBound($aFiles_sub))

			If $y > 0 Then
				;_ArraySort($aFiles_sub, 1)
				_ArraySortClib($aFiles_sub, 1, 1)
				ReDim $aFiles_sub[$y]
				;_ArraySort($aFiles_sub)
				_ArraySortClib($aFiles_sub, 1)
			EndIf

			For $y = 0 To UBound($aFiles_sub) - 1
				;ConsoleWrite("Add child: " & $y & @crlf)
				$iSubChildsub = _GUICtrlTreeView_AddChild($hWndTreeView, $iSubChild, $aFiles_sub[$y], 3, 5)
				If GUICtrlRead($c_Checkbox_SearchFor_Recursive) = 1 Then
					If MyCtrlGetItemState($hWndTreeView, $iSubChild) <> 4 Then MyCtrlSetItemState($hWndTreeView, $iSubChildsub, MyCtrlGetItemState($hWndTreeView, $iSubChild))
				EndIf
				ExitLoop
			Next
		EndIf
	Next

EndFunc   ;==>_GetFolders

Func _IsDocDir($sPath, $hControl)
	;If $sPath = $sFolderName_SharedDocuments And ($hControl = $hCommonDocs) Then
	;	Return 1

	If $sPath = $sFolderName_MyDocuments And ($hControl = $hMyDocs) Then
		Return 2
	ElseIf $sPath = $sFolderName_Desktop And ($hControl = $hMyDesktop) Then
		Return 3
		;ElseIf $sPath = $sFolderName_MyVideo And ($hControl = $hMyVideo) Then
		;	Return 4
	Else
		Return False
	EndIf


	#cs
		If $PlatformCompatabillity < 3 Then

		If $sPath = $sFolderName_MyDocuments And ($hControl = $hMyDocs) Then
		Return 2
		ElseIf $sPath = $sFolderName_Desktop And ($hControl = $hMyDesktop) Then
		Return 3
		;ElseIf $sPath = $sFolderName_MyVideo And ($hControl = $hMyVideo) Then
		;	Return 4
		Else
		Return False
		EndIf
		Else
		If $sPath = $sFolderName_Desktop And ($hControl = $hMyDesktop) Then
		Return 3
		;ElseIf $sPath = $sFolderName_MyVideo And ($hControl = $hMyVideo) Then
		;	Return 4
		Else
		Return False
		EndIf

		EndIf
	#ce
EndFunc   ;==>_IsDocDir

;**********************************************************
; Get an item state
;**********************************************************
Func MyCtrlGetItemState($hTV, $nID)

	$nState = _GetItemState($hTV, $nID)

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

	_SetItemState($hTV, $nID, $nState)
	CheckChildItems($hTV, $nID, $nState)
	CheckParents($hTV, $nID, $nState)

EndFunc   ;==>MyCtrlSetItemState


;**********************************************************
; Helper functions
;**********************************************************
Func CheckChildItems($hWnd, $hItem, $nState)
	Local $hChild = _SendMessage($hWnd, $TVM_GETNEXTITEM, $TVGN_CHILD, $hItem)
	While $hChild > 0
		If _GetItemState($hWnd, $hChild) <> 4 Then _SetItemState($hWnd, $hChild, $nState)
		CheckChildItems($hWnd, $hChild, $nState)
		$hChild = _SendMessage($hWnd, $TVM_GETNEXTITEM, $TVGN_NEXT, $hChild)
	WEnd
EndFunc   ;==>CheckChildItems


Func CheckParents($hWnd, $hItem, $nState)
	Local $nTmpState1 = 0, $nTmpState2 = 0
	Local $bDiff = 0
	Local $i = 0

	Local $hParent = _SendMessage($hWnd, $TVM_GETNEXTITEM, $TVGN_PARENT, $hItem)

	If $hParent > 0 Then
		Local $hChild = _SendMessage($hWnd, $TVM_GETNEXTITEM, $TVGN_CHILD, $hParent)

		If $hChild > 0 Then
			Do
				$i += 1

				If $hChild = $hItem Then
					$nTmpState2 = $nState
				Else
					$nTmpState2 = _GetItemState($hWnd, $hChild)
				EndIf

				If $i = 1 Then $nTmpState1 = $nTmpState2

				If $nTmpState1 <> $nTmpState2 Then
					$bDiff = 1
					ExitLoop
				EndIf

				$hChild = _SendMessage($hWnd, $TVM_GETNEXTITEM, $TVGN_NEXT, $hChild)

			Until $hChild <= 0

			If $bDiff Then
				_SetItemState($hWnd, $hParent, 3)
				$nState = 3
			ElseIf $nState = 1 Then
				_SetItemState($hWnd, $hParent, 1)
				$nState = 1
			ElseIf $i = 1 Then
				_SetItemState($hWnd, $hParent, 3)
				$nState = 3
			EndIf
		EndIf

		CheckParents($hWnd, $hParent, $nState)
	EndIf
EndFunc   ;==>CheckParents



Func _SetItemState($hWnd, $hItem, $nState)
	$nState = BitShift($nState, -12)

	Local $tvItem = DllStructCreate("uint;dword;uint;uint;ptr;int;int;int;int;int;int")

	DllStructSetData($tvItem, 1, $TVIF_STATE)
	DllStructSetData($tvItem, 2, $hItem)
	DllStructSetData($tvItem, 3, $nState)
	DllStructSetData($tvItem, 4, $TVIS_STATEIMAGEMASK)

	_SendMessage($hWnd, $TVM_SETITEMA, 0, DllStructGetPtr($tvItem))
EndFunc   ;==>_SetItemState


Func _GetItemState($hWnd, $hItem)
	Local $tvItem = DllStructCreate("uint;dword;uint;uint;ptr;int;int;int;int;int;int")
	DllStructSetData($tvItem, 1, $TVIF_STATE)
	DllStructSetData($tvItem, 2, $hItem)
	DllStructSetData($tvItem, 4, $TVIS_STATEIMAGEMASK)
	_SendMessage($hWnd, $TVM_GETITEMA, 0, DllStructGetPtr($tvItem))
	Local $nState = DllStructGetData($tvItem, 3)
	$nState = BitAND($nState, $TVIS_STATEIMAGEMASK)
	$nState = BitShift($nState, 12)
	Return $nState
EndFunc   ;==>_GetItemState


Func _LoadStateImage($hTreeView, $sFile)
	Local $hWnd = GUICtrlGetHandle($hTreeView)
	If $hWnd = 0 Then $hWnd = $hTreeView

	Local $hImageList = 0

	;	If @Compiled Then
	;		Local $hModule = LoadLibrary(@ScriptFullPath)
	;		$hImageList = ImageList_LoadImage($hModule, "#170", 16, 1, $CLR_NONE, $IMAGE_BITMAP, BitOr($LR_LOADTRANSPARENT, $LR_CREATEDIBSECTION))
	;	Else
	;		$hImageList = ImageList_LoadImage(0, $sFile, 16, 1, $CLR_NONE, $IMAGE_BITMAP, BitOr($LR_LOADFROMFILE, $LR_LOADTRANSPARENT, $LR_CREATEDIBSECTION))
	;	EndIf

	$hImageList = _ImageList_LoadImage(0, $sFile, 16, 1, $CLR_NONE, $IMAGE_BITMAP, BitOR($LR_LOADFROMFILE, $LR_LOADTRANSPARENT, $LR_CREATEDIBSECTION))

	_SendMessage($hWnd, $TVM_SETIMAGELIST, $TVSIL_STATE, $hImageList)
	_InvalidateRect($hWnd, 0, 1)
EndFunc   ;==>_LoadStateImage


;**********************************************************
; Win32-API functions
;**********************************************************
#cs
	Func SendMessage($hWnd, $Msg, $wParam, $lParam)
	$nResult = DllCall("user32.dll", "int", "SendMessage", _
	"hwnd", $hWnd, _
	"int", $Msg, _
	"int", $wParam, _
	"int", $lParam)
	Return $nResult[0]
	EndFunc   ;==>SendMessage
#ce

Func _GetWindowLong($hWnd, $nIndex)
	$nResult = DllCall("user32.dll", "int", "GetWindowLong", "hwnd", $hWnd, "int", $nIndex)
	Return $nResult[0]
EndFunc   ;==>_GetWindowLong


Func _GetCursorPos($Point)
	DllCall("user32.dll", "int", "GetCursorPos", "ptr", DllStructGetPtr($Point))
EndFunc   ;==>_GetCursorPos


Func _ScreenToClient($hWnd, $Point)
	DllCall("user32.dll", "int", "ScreenToClient", "hwnd", $hWnd, "ptr", DllStructGetPtr($Point))
EndFunc   ;==>_ScreenToClient


Func _InvalidateRect($hWnd, $lpRect, $bErase)
	DllCall("user32.dll", "int", "InvalidateRect", _
			"hwnd", $hWnd, _
			"ptr", $lpRect, _
			"int", $bErase)
EndFunc   ;==>_InvalidateRect


Func _LoadLibrary($sFile)
	Local $hModule = DllCall("kernel32.dll", "hwnd", "LoadLibrary", "str", $sFile)
	Return $hModule[0]
EndFunc   ;==>_LoadLibrary


Func _ImageList_LoadImage($hInst, $sFile, $cx, $cGrow, $crMask, $uType, $uFlags)
	Local $hImageList = DllCall("comctl32.dll", "hwnd", "ImageList_LoadImage", _
			"hwnd", $hInst, _
			"str", $sFile, _
			"int", $cx, _
			"int", $cGrow, _
			"int", $crMask, _
			"int", $uType, _
			"int", $uFlags)
	Return $hImageList[0]
EndFunc   ;==>_ImageList_LoadImage


Func _DestroyImageList()
	DllCall("comctl32.dll", "int", "ImageList_Destroy", "hwnd", $hImageList)
EndFunc   ;==>_DestroyImageList



; ===============================================================================================================================
; http://www.autoitscript.com/forum/index.php?showtopic=107303&st=0&p=756879&hl=OSBuild&fromsearch=1&#entry756879
; NerdFencer

; MsgBox(0,"",_Macro_GetPlatformCompatabillity())

; #FUNCTION# ====================================================================================================================
; Name...........: _Macro_GetPlatformCompatabillity
; Description ...: Returns a value describing the OS platform that is being run
; Syntax.........: _Macro_GetPlatformCompatabillity()
; Parameters ....: None.
; Return values .: Success      - $Macro_Sys2010, $Macro_Sys2008, $Macro_Sys2003, $Macro_Sys2000, or $Macro_SysNone
;                  Failure      - Error
; Author ........: Matthew McMullan (NerdFencer)
; Modified.......:
; Remarks .......:
; Related .......:
; Link ..........:
; Example .......:
; ===============================================================================================================================
Func _Macro_GetPlatformCompatabillity()
	If @OSVersion == $MACRO_OS_SERVER_2008_R2 Or @OSVersion == $MACRO_OS_7 Then
		Return $Macro_Sys2010
	ElseIf @OSVersion == $MACRO_OS_SERVER_2008 Or @OSVersion == $MACRO_OS_VISTA Then
		Return $Macro_Sys2008
	ElseIf @OSBuild >= $MACRO_OSBUILD_XP And @OSBuild < $MACRO_OSBUILD_VISTA Then
		Return $Macro_Sys2003
	ElseIf @OSBuild >= $MACRO_OSBUILD_2000 Then
		Return $Macro_Sys2000
	EndIf
	Return $Macro_SysNone
EndFunc   ;==>_Macro_GetPlatformCompatabillity


; http://www.autoitscript.com/forum/index.php?showtopic=63525&view=findpost&p=474072
;===============================================================================
; Function Name:    _ArraySortClib() v4
; Description:         Sort 1D/2D array using qsort() from C runtime library
; Syntax:
; Parameter(s):      $Array - the array to be sorted, ByRef
;                    $iMode - sort mode, can be one of the following:
;                        0 = numerical, using double precision float compare
;                        1 = string sort, case insensitive (default)
;                        2 = string sort, case sensitive
;                        3 = word sort, case insensitive - compatible with AutoIt's native compare
;                    $fDescend - sort direction. True = descending, False = ascending (default)
;                    $iStart - index of starting element (default 0 = $array[0])
;                    $iEnd - index of ending element (default 0 = Ubound($array)-1)
;                    $iColumn - index of column to sort by (default 0 = first column)
;                    $iStrMax - max string length of each array element to compare (default 4095 chars)
; Requirement(s):    msvcrt.dll (shipped with Windows since Win98 at least), 32-bit version of AutoIt
; Return Value(s):    Success = Returns 1
;                    Failure = Returns 0 and sets error:
;                        @error 1 = invalid array
;                        @error 2 = invalid param
;                        @error 3 = dll error
;                        @error 64 = 64-bit AutoIt unsupported
; Author(s):   Siao
; Modification(s):
;===============================================================================

Func _ArraySortClib(ByRef $array, $iMode = 1, $fDescend = False, $iStart = 0, $iEnd = 0, $iColumn = 0, $iStrMax = 4095)
	If @AutoItX64 Then Return SetError(64, 0, 0)
	Local $iArrayDims = UBound($array, 0)
	If @error Or $iArrayDims > 2 Then Return SetError(1, 0, 0)
	Local $iArraySize = UBound($array, 1), $iColumnMax = UBound($array, 2)
	If $iArraySize < 2 Then Return SetError(1, 0, 0)
	If $iEnd < 1 Or $iEnd > $iArraySize - 1 Then $iEnd = $iArraySize - 1
	If ($iEnd - $iStart < 2) Then Return SetError(2, 0, 0)
	If $iArrayDims = 2 And ($iColumnMax - $iColumn < 0) Then Return SetError(2, 0, 0)
	If $iStrMax < 1 Then Return SetError(2, 0, 0)
	Local $i, $j, $iCount = $iEnd - $iStart + 1, $fNumeric, $aRet, $sZero = ChrW(0), $sStrCmp, $sBufType = 'byte[', $tSource, $tIndex, $tFloatCmp, $tCmpWrap = DllStructCreate('byte[64]'), $tEnumProc = DllStructCreate('byte[64]')



	If $h_DLL_msvcrt = -1 Then Return SetError(3, 0, 0)
	;; initialize compare proc
	Switch $iMode
		Case 0
			$fNumeric = True
			$tFloatCmp = DllStructCreate('byte[36]')
			DllStructSetData($tFloatCmp, 1, '0x8B4C24048B542408DD01DC1ADFE0F6C440750D80E441740433C048C333C040C333C0C3')
			DllStructSetData($tCmpWrap, 1, '0xBA' & Hex(Binary(DllStructGetPtr($tFloatCmp)), 8) & '8B4424088B4C2404FF30FF31FFD283C408C3')
			DllStructSetData($tEnumProc, 1, '0x8B7424048B7C24088B4C240C8B442410893789470483C60883C708404975F1C21000')
		Case 1, 2
			$sStrCmp = "_strcmpi" ;case insensitive
			If $iMode = 2 Then $sStrCmp = "strcmp" ;case sensitive
			$aRet = DllCall($h_DLL_Kernel32, 'ptr', 'GetModuleHandle', 'str', 'msvcrt.dll')
			$aRet = DllCall($h_DLL_Kernel32, 'ptr', 'GetProcAddress', 'ptr', $aRet[0], 'str', $sStrCmp)
			;If $aRet[0] = 0 Then Return SetError(3, 0, 0 * DllClose($h_DLL_msvcrt))
			If $aRet[0] = 0 Then Return SetError(3, 0, 1)
			DllStructSetData($tCmpWrap, 1, '0xBA' & Hex(Binary($aRet[0]), 8) & '8B4424088B4C2404FF30FF31FFD283C408C3')
			DllStructSetData($tEnumProc, 1, '0x8B7424048B7C24088B4C240C8B542410893789570483C7088A064684C075F9424975EDC21000')
		Case 3
			$sBufType = 'wchar['
			$aRet = DllCall($h_DLL_Kernel32, 'ptr', 'GetModuleHandle', 'str', 'kernel32.dll')
			$aRet = DllCall($h_DLL_Kernel32, 'ptr', 'GetProcAddress', 'ptr', $aRet[0], 'str', 'CompareStringW')
			;If $aRet[0] = 0 Then Return SetError(3, 0, 0 * DllClose($h_DLL_msvcrt))
			If $aRet[0] = 0 Then Return SetError(3, 0, 1)
			DllStructSetData($tCmpWrap, 1, '0xBA' & Hex(Binary($aRet[0]), 8) & '8B4424088B4C24046AFFFF306AFFFF3168000000006800040000FFD283E802C3')
			DllStructSetData($tEnumProc, 1, '0x8B7424048B7C24088B4C240C8B542410893789570483C7080FB70683C60285C075F6424975EAC21000')
		Case Else
			Return SetError(2, 0, 0)
	EndSwitch
	;; write data to memory
	If $fNumeric Then
		$tSource = DllStructCreate('double[' & $iCount & ']')
		If $iArrayDims = 1 Then
			For $i = 1 To $iCount
				DllStructSetData($tSource, 1, $array[$iStart + $i - 1], $i)
			Next
		Else
			For $i = 1 To $iCount
				DllStructSetData($tSource, 1, $array[$iStart + $i - 1][$iColumn], $i)
			Next
		EndIf
	Else
		Local $sMem = ""
		If $iArrayDims = 1 Then
			For $i = $iStart To $iEnd
				$sMem &= StringLeft($array[$i], $iStrMax) & $sZero
			Next
		Else
			For $i = $iStart To $iEnd
				$sMem &= StringLeft($array[$i][$iColumn], $iStrMax) & $sZero
			Next
		EndIf
		$tSource = DllStructCreate($sBufType & StringLen($sMem) + 1 & ']')
		DllStructSetData($tSource, 1, $sMem)
		$sMem = ""
	EndIf
	;; index data
	$tIndex = DllStructCreate('int[' & $iCount * 2 & ']')
	DllCall($h_DLL_user32, 'uint', 'CallWindowProc', 'ptr', DllStructGetPtr($tEnumProc), 'ptr', DllStructGetPtr($tSource), 'ptr', DllStructGetPtr($tIndex), 'int', $iCount, 'int', $iStart)
	;; sort
	DllCall($h_DLL_msvcrt, 'none:cdecl', 'qsort', 'ptr', DllStructGetPtr($tIndex), 'int', $iCount, 'int', 8, 'ptr', DllStructGetPtr($tCmpWrap))
	;DllClose($h_DLL_msvcrt)
	;; rearrange the array by sorted index
	Local $aTmp = $array, $iRef
	If $iArrayDims = 1 Then ; 1D
		If $fDescend Then
			For $i = 0 To $iCount - 1
				$iRef = DllStructGetData($tIndex, 1, $i * 2 + 2)
				$array[$iEnd - $i] = $aTmp[$iRef]
			Next
		Else ; ascending
			For $i = $iStart To $iEnd
				$iRef = DllStructGetData($tIndex, 1, ($i - $iStart) * 2 + 2)
				$array[$i] = $aTmp[$iRef]
			Next
		EndIf
	Else ; 2D
		If $fDescend Then
			For $i = 0 To $iCount - 1
				$iRef = DllStructGetData($tIndex, 1, $i * 2 + 2)
				For $j = 0 To $iColumnMax - 1
					$array[$iEnd - $i][$j] = $aTmp[$iRef][$j]
				Next
			Next
		Else ; ascending
			For $i = $iStart To $iEnd
				$iRef = DllStructGetData($tIndex, 1, ($i - $iStart) * 2 + 2)
				For $j = 0 To $iColumnMax - 1
					$array[$i][$j] = $aTmp[$iRef][$j]
				Next
			Next
		EndIf
	EndIf
	Return 1
EndFunc   ;==>_ArraySortClib