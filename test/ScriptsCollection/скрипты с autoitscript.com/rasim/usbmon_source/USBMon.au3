#AutoIt3Wrapper_Icon=remdrive.ico

#NoTrayIcon
;============# Prevent from secondary run #====================================
$hMutex = DllCall("kernel32.dll", "hwnd", "OpenMutex", "int", 0x1F0001, "int", False, "str", "USBMon")

If $hMutex[0] Then
	$hWnd = WinGetHandle("USBMon")
	WinSetState($hWnd, "", @SW_RESTORE)
	DllCall("user32.dll", "int", "SetForegroundWindow", "hwnd", $hWnd)
	Exit
EndIf

$hMutex = DllCall("kernel32.dll", "hwnd", "CreateMutex", "int", 0, "int", False, "str", "USBMon")
;================================================================================

#include <GuiConstantsEx.au3>
#include <WindowsConstants.au3>
#include <Constants.au3>
#include <ButtonConstants.au3>
#include <StaticConstants.au3>
#include <GuiListView.au3>
#include <GuiComboBox.au3>
#include <GuiMenu.au3>
;

#Region variables and settings
Opt("TrayIconHide", 0)
Opt("TrayMenuMode", 1)
Opt("TrayOnEventMode", 1)

Global Const $WM_DEVICECHANGE = 0x0219

Global Const $DBT_DEVICEARRIVAL          = 0x8000 ; Dystem detected a new device 
Global Const $DBT_DEVICEREMOVECOMPLETE   = 0x8004 ; Device is gone 

Global Const $DBT_DEVTYP_VOLUME          = 0x00000002 ; Logical volume

Global Const $NTMS_EJECT_START = 0
Global Const $NTMS_EJECT_FORCE = 3
#EndRegion variables and settings
;

#Region GUI
$hGUI = GUICreate("USBMon", 340, 280)

$DriveGroup = GUICtrlCreateGroup("Removable devices", 10, 10, 320, 85)
DllCall("UxTheme.dll", "int", "SetWindowTheme", "hwnd", GUICtrlGetHandle($DriveGroup), "wstr", "", "wstr", "")
GUICtrlSetColor(-1, 0x0046D5)

$DriveLabel = GUICtrlCreateLabel("", 15, 30, 310, 16, $SS_CENTER)
GUICtrlSetState(-1, $GUI_FOCUS)

$DriveCombo = GUICtrlCreateCombo("", 95, 50, 150, 20, BitOR($CBS_DROPDOWN, $CBS_DROPDOWNLIST, $CBS_AUTOHSCROLL, $WS_VSCROLL))

GUICtrlCreateGroup("", -99, -99, 1, 1)

GUICtrlCreateLabel("Drive Content", 134, 103, 70, 16)

$hListView = GUICtrlCreateListView("Path|Type|Size", 10, 120, 320, 115, $LVS_REPORT, _
								   BitOR($LVS_EX_INFOTIP, $WS_EX_CLIENTEDGE))

_GUICtrlListView_SetColumnWidth($hListView, 0, 156)
_GUICtrlListView_SetColumnWidth($hListView, 1, 80)
_GUICtrlListView_SetColumnWidth($hListView, 2, 80)

Global $B_DESCENDING[_GUICtrlListView_GetColumnCount($hListView)]

$EjectButton = GUICtrlCreateButton("Eject", 10, 247, 75, 23)

$ExitButton = GUICtrlCreateButton("Exit", 255, 247, 75, 23)

$DriveMenu = TrayCreateMenu("Eject Drive")

Dim $aDrives = _DriveGet()

If UBound($aDrives) > 1 Then
	For $i = 1 To $aDrives[0]
		TrayCreateItem($aDrives[$i], $DriveMenu)
		TrayItemSetOnEvent(-1, "_TrayEvent")
	Next
Else
	TrayItemSetState($DriveMenu, $TRAY_DISABLE)
EndIf

$RestoreItem = TrayCreateItem("Restore")
TrayItemSetOnEvent(-1, "_ShowGUI")

$ExitItem = TrayCreateItem("Exit")
TrayItemSetOnEvent(-1, "_Exit")

TraySetClick(16)
TraySetOnEvent($TRAY_EVENT_PRIMARYUP, "_ShowGUI")

GUIRegisterMsg($WM_DEVICECHANGE, "WM_DEVICECHANGE")
GUIRegisterMsg($WM_NOTIFY, "WM_NOTIFY")

GUISetState()
#EndRegion GUI
;

_ProcessReduceMemory(@AutoItPID)
_SetToolTip()

While 1
	$msg = GUIGetMsg()
	Switch $msg
		Case $GUI_EVENT_CLOSE, $ExitButton
			Exit
		Case $GUI_EVENT_MINIMIZE
			WinSetState($hGUI, "", @SW_HIDE)
			TrayItemSetState($RestoreItem, $TRAY_ENABLE)
			_SetToolTip()
		Case $EjectButton
			_DriveRemove(GUICtrlRead($DriveCombo))
		Case $DriveCombo
			$DriveRead = GUICtrlRead($DriveCombo)
			If $DriveRead <> "" Then
				_DriveEnumContent($DriveRead)
			EndIf
	EndSwitch
	
	If BitAND(WinGetState($hGUI), 2) And BitAND(TrayItemGetState($RestoreItem), $TRAY_ENABLE) Then TrayItemSetState($RestoreItem, $TRAY_DISABLE)
WEnd

Func WM_DEVICECHANGE($hWnd, $Msg, $wParam, $lParam)
	If ($wParam = $DBT_DEVICEARRIVAL) Or ($wParam = $DBT_DEVICEREMOVECOMPLETE) Then
		Local $DEV_BROADCAST_VOLUME = DllStructCreate("int dbcvsize;int dbcvdevicetype;int dbcvreserved;int dbcvunitmask;" & _
													  "ushort dbcvflags", $lParam)
		Local $iDriveType = DllStructGetData($DEV_BROADCAST_VOLUME, "dbcvdevicetype")
	Else
		Return $GUI_RUNDEFMSG
	EndIf
	
	If $iDriveType <> $DBT_DEVTYP_VOLUME Then Return $GUI_RUNDEFMSG
	
	Local $iMask = DllStructGetData($DEV_BROADCAST_VOLUME, "dbcvunitmask")
	$iMask = Log($iMask) / Log(2)
	
	Local $iDrive = Chr(65 + $iMask) & ":"
	
	Switch $wParam
		Case $DBT_DEVICEARRIVAL
			_DriveAdd($iDrive)
		Case $DBT_DEVICEREMOVECOMPLETE
			_DriveRemove($iDrive)
	EndSwitch
	
	Return $GUI_RUNDEFMSG
EndFunc   ;==>WM_DEVICECHANGE

Func WM_NOTIFY($hWnd, $Msg, $wParam, $lParam)
	Local $tNMHDR, $iIDFrom, $iCode
	
	$tNMHDR = DllStructCreate($tagNMHDR, $lParam)
	$iIDFrom = DllStructGetData($tNMHDR, "IDFrom")
	$iCode = DllStructGetData($tNMHDR, "Code")
	
	Switch $iIDFrom
		Case $hListView
			Switch $iCode
				Case $LVN_COLUMNCLICK
					Local $tInfo = DllStructCreate($tagNMLISTVIEW, $lParam)
					_GUICtrlListView_SimpleSort($hListView, $B_DESCENDING, DllStructGetData($tInfo, "SubItem"))
			EndSwitch
	EndSwitch
	
	Return $GUI_RUNDEFMSG
EndFunc   ;==>WM_NOTIFY

Func _DriveGet()
	Local $aDrive = DriveGetDrive("REMOVABLE")
	If @error Then Return False
	
	Local $iCount = 0, $aRetDrive[1], $i
	
	For $i = 1 To $aDrive[0]
		If ($aDrive[$i] = "a:") Or (DriveStatus($aDrive[$i]) <> "READY") Then ContinueLoop
		$aRetDrive[0] += 1
		ReDim $aRetDrive[$aRetDrive[0] + 1]
		$aRetDrive[$aRetDrive[0]] = StringUpper($aDrive[$i])
		_GUICtrlComboBox_AddString($DriveCombo, StringUpper($aDrive[$i]))
		$iCount += 1
	Next
	
	GUICtrlSetData($DriveLabel, $iCount & " removable device(s) found")
	TrayTip("USBMon", $iCount & " removable device(s) found", 3, 1)
	
	Return $aRetDrive
EndFunc   ;==>_DriveGet

Func _DriveAdd($sDrive)
	If DriveGetType($sDrive) <> "Removable" Then Return False
	
	Local $iNumber, $iPrevData
	
	$iNumber = StringRegExpReplace(GUICtrlRead($DriveLabel), "(\D)", "")
	
	TrayTip("USBMon", $iNumber + 1 & " removable device(s) found", 3, 1)
	TrayCreateItem(StringUpper($sDrive), $DriveMenu)
	TrayItemSetOnEvent(-1, "_TrayEvent")
	TrayItemSetState($DriveMenu, $TRAY_ENABLE)
	
	GUICtrlSetData($DriveLabel, $iNumber + 1 & " removable device(s) found")
	
	_GUICtrlComboBox_AddString($DriveCombo, StringUpper($sDrive))
	_SetToolTip()
EndFunc   ;==>_DriveAdd

Func _DriveRemove($sDrive)
	Local $iIndex = _GUICtrlComboBox_FindString($DriveCombo, $sDrive, 0)
	If $iIndex = -1 Then Return False
	
	If _GUICtrlComboBox_GetCurSel($DriveCombo) = $iIndex Then _GUICtrlListView_DeleteAllItems($hListView)
	_GUICtrlComboBox_DeleteString($DriveCombo, $iIndex)
	
	Local $iNumber = StringRegExpReplace(GUICtrlRead($DriveLabel), "(\D)", "")
	GUICtrlSetData($DriveLabel, $iNumber - 1 & " removable device(s) found")
	
	Local $iCount = _GUICtrlMenu_GetItemCount(TrayItemGetHandle($DriveMenu)), $i
	
	For $i = 0 To $iCount - 1
		If _GUICtrlMenu_GetItemText(TrayItemGetHandle($DriveMenu), $i) = $sDrive Then _
		   _GUICtrlMenu_DeleteMenu(TrayItemGetHandle($DriveMenu), $i)
	Next
	
	If _GUICtrlComboBox_GetCount($DriveCombo) = 0 Then TrayItemSetState($DriveMenu, $TRAY_DISABLE)
	
	If DriveStatus($sDrive = "READY") Then _DriveEject($sDrive)
	
	TrayTip("USBMon", "Removable drive " & $sDrive & " is ejected", 3, 1)
	
	DllCall("user32.dll", "int", "RedrawWindow", "hwnd", GUICtrlGetHandle($DriveCombo), "ptr", 0, "int", 0, "int", $RDW_INVALIDATE)
	
	_SetToolTip()
EndFunc   ;==>_DriveRemove

Func _DriveEnumContent($sDrive)
	Local $iSearch, $iFile
	
	_GUICtrlListView_DeleteAllItems($hListView)
	
	$iSearch = FileFindFirstFile($sDrive & "\*.*")
	If $iSearch = -1 Then Return False
	
	_GUICtrlListView_BeginUpdate($hListView)
	
	While 1
		$iFile = FileFindNextFile($iSearch)
		If @error Then ExitLoop
		
		If StringInStr(FileGetAttrib($sDrive & "\" & $iFile), "D") Then
			GUICtrlCreateListViewItem($iFile & "|Folder" & "|" & DirGetSize($sDrive & "\" & $iFile) & " Byte", $hListView)
		Else
			GUICtrlCreateListViewItem($iFile & "|File" & "|" & FileGetSize($sDrive & "\" & $iFile) & " Byte", $hListView)
		EndIf
	WEnd
	
	FileClose($iSearch)
	
	_GUICtrlListView_EndUpdate($hListView)
EndFunc   ;==>_DriveEnumContent

Func _DriveEject($sDrive)
	Local Const $IOCTL_STORAGE_GET_DEVICE_NUMBER = 0x2D1080
	Local Const $FILE_SHARE_READ  = 0x1
	Local Const $FILE_SHARE_WRITE = 0x2
	Local Const $OPEN_EXISTING    = 3
	
	Local $szVolumeName = "\\.\" & $sDrive
	
	$hDrive = DllCall("kernel32.dll", "hwnd", "CreateFile", _
					  "str", $szVolumeName, _
					  "int", 0, _
					  "int", BitOR($FILE_SHARE_READ, $FILE_SHARE_WRITE), _
					  "ptr", 0, _
					  "int", $OPEN_EXISTING, _
					  "int", 0, _
					  "int", 0)
				  
	If $hDrive[0] = -1 Then Return False
	
	Local $STORAGE_DEVICE_NUMBER = DllStructCreate("int;int;int")
	Local $ByteRet = DllStructCreate("int")
	
	DllCall("kernel32.dll", "int", "DeviceIoControl", _
			"hwnd", $hDrive[0], _
			"int", $IOCTL_STORAGE_GET_DEVICE_NUMBER, _
			"ptr", 0, _
			"int", 0, _
			"ptr", DllStructGetPtr($STORAGE_DEVICE_NUMBER), _
			"int", DllStructGetSize($STORAGE_DEVICE_NUMBER), _
			"int*", $ByteRet, _
			"ptr", 0)

	DllCall("kernel32.dll", "int", "CloseHandle", "hwnd", $hDrive[0])
	
	Local $iDrive = "\\.\PhysicalDrive" & DllStructGetData($STORAGE_DEVICE_NUMBER, 2)
	
	DllCall("ntmsapi.dll", "int", "EjectDiskFromSADriveA", "str", "", "str", "", "str", $iDrive, "hwnd", 0, _
			"str", "Title", "str", "Eject drive", "int", $NTMS_EJECT_FORCE)
EndFunc

Func _TrayEvent()
	_DriveRemove(TrayItemGetText(@TRAY_ID))
EndFunc   ;==>_TrayEvent

Func _ShowGUI()
	WinSetState($hGUI, "", @SW_RESTORE)
	DllCall("user32.dll", "int", "SetForegroundWindow", "hwnd", $hGUI)
EndFunc   ;==>_ShowGUI

Func _SetToolTip()
	Local $iCount = _GUICtrlComboBox_GetCount($DriveCombo)
	
	If $iCount = 0 Then
		TraySetToolTip(GUICtrlRead($DriveLabel))
		Return False
	EndIf
	
	Local $iDrives, $iText
	
	For $i = 0 To $iCount - 1
		_GUICtrlComboBox_GetLBText($DriveCombo, $i, $iText)
		$iDrives &= $iText & @LF
	Next
	
	TraySetToolTip(GUICtrlRead($DriveLabel) & @LF & _
				   $iDrives)
EndFunc   ;==>_SetToolTip

Func _ProcessReduceMemory($iPID)
    Local $iProcExists = ProcessExists($iPID) ;To get the PID and check process existence
    Local $hOpenProc, $aEmptyWorkSet_Ret

    If Not $iProcExists Then Return SetError(1, 0, 0)
    If IsString($iPID) Then $iPID = $iProcExists

    If $iPID = - 1 Then
        $aEmptyWorkSet_Ret = DllCall("Psapi.dll", "int", "EmptyWorkingSet", "int", -1)
    Else
        $hOpenProc = DllCall("Kernel32.dll", "hwnd", "OpenProcess", "int", $PROCESS_ALL_ACCESS, "int", False, "int", $iPID)
        $aEmptyWorkSet_Ret = DllCall("Psapi.dll", "int", "EmptyWorkingSet", "hwnd", $hOpenProc[0])
        DllCall("Kernel32.dll", "int", "CloseHandle", "int", $hOpenProc[0])
    EndIf
 
    If Not IsArray($aEmptyWorkSet_Ret) Then Return SetError(2, 0, 0) 
    Return $aEmptyWorkSet_Ret[0] 
EndFunc   ;==>_ProcessReduceMemory

Func _Exit()
	Exit
EndFunc   ;==>_Exit