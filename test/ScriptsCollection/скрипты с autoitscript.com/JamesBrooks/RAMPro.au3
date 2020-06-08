#NoTrayIcon
#Region ;**** Directives created by AutoIt3Wrapper_GUI ****
#AutoIt3Wrapper_icon=Sys-Program.ico
#AutoIt3Wrapper_Res_Comment=Free empty working space
#AutoIt3Wrapper_Res_Description=RAMPro
#AutoIt3Wrapper_Res_Fileversion=2.4
#AutoIt3Wrapper_Res_LegalCopyright=James Brooks
#AutoIt3Wrapper_Res_Field=Website|http://www.james-brooks.net
#EndRegion ;**** Directives created by AutoIt3Wrapper_GUI ****
#include <GUIListView.au3>
#include <GuiImageList.au3>
#include <WindowsConstants.au3>
#include <Constants.au3>

Opt("TrayOnEventMode", 1)
Opt("TrayMenuMode", 1)

TraySetOnEvent($TRAY_EVENT_PRIMARYUP, "OpenFromTray")

AdlibRegister("_Auto")

Global $StartIdle, $StartKernel, $StartUser ; CPU
Global $EndIdle, $EndKernel, $EndUser ; CPU
Dim $hMem = MemGetStats(), $bAuto = False
Dim $hTimer = TimerInit() ; We use this to reset the warning box if we need
Dim $iVersion = 2.4 ; Version number
Dim $iCPUTot
Dim $IDLETIME, $KERNELTIME, $USERTIME ; CPU

$IDLETIME = DllStructCreate("dword;dword")
$KERNELTIME = DllStructCreate("dword;dword")
$USERTIME = DllStructCreate("dword;dword")

$hGUI = GUICreate("RAMPro", 373, 165, -1, -1)
$hInfo = _GUICtrlListView_Create($hGUI, "", 8, 8, 177, 149)
_GUICtrlListView_SetExtendedListViewStyle($hInfo, BitOR($LVS_EX_GRIDLINES, $LVS_EX_FULLROWSELECT, $LVS_EX_SUBITEMIMAGES))

$hImage = _GUIImageList_Create() ; Create the solid bitmaps for the icons
_GUIImageList_Add($hImage, _GUICtrlListView_CreateSolidBitMap($hInfo, 0xFF0000, 16, 16)) ; Drive Space is bad 	0
_GUIImageList_Add($hImage, _GUICtrlListView_CreateSolidBitMap($hInfo, 0xFF9900, 16, 16)) ; Drive space is ok	1
_GUIImageList_Add($hImage, _GUICtrlListView_CreateSolidBitMap($hInfo, 0x00FF00, 16, 16)) ; Drive space is good	2

_GUICtrlListView_InsertColumn($hInfo, 0, "Type")
_GUICtrlListView_InsertColumn($hInfo, 1, "Info")
_GUICtrlListView_AddItem($hInfo, "Total RAM", 3)
_GUICtrlListView_AddSubItem($hInfo, 0, $hMem[1], 1)
_GUICtrlListView_AddItem($hInfo, "Available RAM", _DecideStatus(1)) ; Decide what icon should be used
_GUICtrlListView_AddSubItem($hInfo, 1, $hMem[2], 1)
_GUICtrlListView_AddItem($hInfo, "Used RAM", _DecideStatus(2)) ; Decide what icon should be used
_GUICtrlListView_AddSubItem($hInfo, 2, $hMem[3] & "%", 1)
_GUICtrlListView_SetImageList($hInfo, $hImage, 1)

_GUICtrlListView_AddItem($hInfo, "", 3) ; Blank between RAM and CPU

_GUICtrlListView_AddItem($hInfo, "CPU Usage", _DecideStatus(3)) ; Decide what icon should be used
_GUICtrlListView_AddSubItem($hInfo, 4, "", 1)
_GUICtrlListView_SetImageList($hInfo, $hImage, 1)

_GUICtrlListView_SetColumnWidth($hInfo, 0, $LVSCW_AUTOSIZE)
_GUICtrlListView_SetColumnWidth($hInfo, 1, $LVSCW_AUTOSIZE)

$hFree = GUICtrlCreateButton("&Free RAM", 192, 8, 177, 25, 0)
$hSelect = GUICtrlCreateButton("Select &Process", 192, 40, 177, 25, 0)
$hAuto = GUICtrlCreateButton("Enable &Auto Free", 192, 72, 177, 25, 0)

$hStartup = GUICtrlCreateCheckbox("&Run RAMPro at startup", 192, 102, 177, 25)
If FileExists(@StartupDir & "\RAMPro.lnk") Then GUICtrlSetState(-1, 1)

$hAbout = GUICtrlCreateButton("About", 192, 128, 177, 25, 0)

If @Compiled Then
	If $CmdLine[0] = 0 Then
		GUISetState(@SW_SHOW)
	ElseIf StringUpper($CmdLine[1]) == "-AUTEN" Then ; They turned on auto enable from startup!
		$bAuto = True
		GUICtrlSetData($hAuto, "Disable &Auto Free")
		GUISetState(@SW_HIDE)
		TraySetState(1)
	EndIf
Else
	GUISetState(@SW_SHOW) ; When not running from EXE we just want the GUI
EndIf

While 1
	$nMsg = GUIGetMsg()
	Switch $nMsg
		Case -3
			Exit
		Case -4
			GUISetState(@SW_HIDE)
			TraySetState(1)
		Case $hFree
			_ReduceMemory_All()
		Case $hAbout
			MsgBox(0, "RAMPro", "RAMPro Version " & $iVersion & " by James Brooks " & @YEAR & @CRLF & @CRLF & "Visit http://www.james-brooks.net for more programs!")
		Case $hAuto
			If $bAuto = False Then
				$bAuto = True
				GUICtrlSetData($hAuto, "Disable &Auto Free")
			Else
				$bAuto = False
				GUICtrlSetData($hAuto, "Enable &Auto Free")
			EndIf
		Case $hSelect
			_FreeSelected()
		Case $hStartup
			$iState = GUICtrlRead($hStartup)
			If $iState = 1 Then
				_RunStartup(True)
			ElseIf $iState = 4 Then
				_RunStartup(False)
			EndIf
	EndSwitch
WEnd

Func _Auto()
	If $hMem[2] <= $hMem[1] / 4 Then _TrayTipWait("RAMPro", "Warning!" & @CRLF & "Low RAM available!", 40, 2)
	; RAM
	$hMem = MemGetStats()
	_GUICtrlListView_SetItemText($hInfo, 1, $hMem[2], 1)
	_GUICtrlListView_SetItemImage($hInfo, 1, _DecideStatus(1))
	_GUICtrlListView_SetItemText($hInfo, 2, $hMem[0] & "%", 1)
	_GUICtrlListView_SetItemImage($hInfo, 2, _DecideStatus(2))
	; CPU
	_GetSysTime($EndIdle, $EndKernel, $EndUser)
	_CPUCalc()
	_GetSysTime($StartIdle, $StartKernel, $StartUser)
	; Should we auto reduce?
	If $bAuto = True Then _ReduceMemory_All()
	TraySetToolTip($hMem[0] & "% used!")
EndFunc   ;==>_Auto

Func _ReduceMemory_All()
	$list = ProcessList()
	For $i = 1 To $list[0][0]
		Local $ai_Handle = DllCall("kernel32.dll", "int", "OpenProcess", "int", 0x1f0fff, "int", False, "int", $list[$i][1])
		If @error Then _CritErr("Unable to call OpenProcess in kernel32.dll")
		Local $ai_Return = DllCall("psapi.dll", "int", "EmptyWorkingSet", "int", $ai_Handle[0])
		If @error Then _CritErr("Unable to call EmptyWorkingSet in psapi.dll")
		DllCall("kernel32.dll", "int", "CloseHandle", "int", $ai_Handle[0])
		If @error Then _CritErr("Unable to call CloseHandle in kernel32.dll")
	Next
EndFunc   ;==>_ReduceMemory_All

Func _ReduceMemory($i_PID)
	If $i_PID <> -1 Then
		Local $ai_Handle = DllCall("kernel32.dll", 'int', 'OpenProcess', 'int', 0x1f0fff, 'int', False, 'int', $i_PID)
		If @error Then _CritErr("Unable to call OpenProcess in kernel32.dll")
		Local $ai_Return = DllCall("psapi.dll", 'int', 'EmptyWorkingSet', 'long', $ai_Handle[0])
		If @error Then _CritErr("Unable to call EmptyWorkingSet in psapi.dll")
		DllCall('kernel32.dll', 'int', 'CloseHandle', 'int', $ai_Handle[0])
		If @error Then _CritErr("Unable to call CloseHandle in kernel32.dll")
	Else
		Local $ai_Return = DllCall("psapi.dll", 'int', 'EmptyWorkingSet', 'long', -1)
		If @error Then _CritErr("Unable to call EmptyWorkingSet in psapi.dll")
	EndIf

	Return $ai_Return[0]
EndFunc   ;==>_ReduceMemory

Func OpenFromTray()
	TraySetState(2)
	GUISetState(@SW_SHOW)
EndFunc   ;==>OpenFromTray

Func _TrayTipWait($s_TrayTitle, $s_TrayText, $i_TimeOut, $i_Option = 0)
	Local $i_PrevMatchMode = Opt("WinTitleMatchMode", 4)
	Local $i_StartTimer, $aWindows, $h_TrayTip, $b_Clicked = 0

	If $s_TrayText = "" Then
		TrayTip("", "", 30)
	Else
		$i_StartTimer = TimerInit()
		TrayTip($s_TrayTitle, $s_TrayText, 30, $i_Option)

		$aWindows = WinList("[CLASS:tooltips_class32]")
		For $iX = 1 To $aWindows[0][0]
			If BitAND(WinGetState($aWindows[$iX][1]), 2) Then
				$h_TrayTip = $aWindows[$iX][1]
				ExitLoop
			EndIf
		Next

		While BitAND(WinGetState($h_TrayTip), 2) And (TimerDiff($i_StartTimer) < (1000 * $i_TimeOut))
			Sleep(100)
		WEnd
		If TimerDiff($i_StartTimer) < (1000 * $i_TimeOut) Then
			$b_Clicked = 1
		Else
			TrayTip("", "", 10)
			$b_Clicked = 0
		EndIf
	EndIf
	Opt("WinTitleMatchMode", $i_PrevMatchMode)
	Return $b_Clicked
EndFunc   ;==>_TrayTipWait

Func _FreeSelected()
	$hMyProcess = GUICreate("Free RAM from selected process", 354, 262, -1, -1)
	$hProcesses = _GUICtrlListView_Create($hMyProcess, "Processes|Type|Memory", 8, 8, 337, 214, BitOR($LVS_REPORT, $LVS_SHOWSELALWAYS))
	_GUICtrlListView_SetExtendedListViewStyle($hProcesses, BitOR($LVS_EX_GRIDLINES, $LVS_EX_FULLROWSELECT, $LVS_EX_SUBITEMIMAGES))
	$hList = ProcessList()
	For $iList = 1 To $hList[0][0] ; Populate list with processes
		$iStats = ProcessGetStats($hList[$iList][1], 0)
		If IsArray($iStats) Then
			_GUICtrlListView_AddItem($hProcesses, $hList[$iList][0])
			_GUICtrlListView_AddSubItem($hProcesses, $iList - 1, $iStats[0] / 1024, 2) ; WorkingSetSize
		Else
			_GUICtrlListView_AddItem($hProcesses, $hList[$iList][0])
			_GUICtrlListView_AddSubItem($hProcesses, $iList - 1, "<SYSTEM>", 1)
		EndIf
	Next

	_GUICtrlListView_SetColumnWidth($hProcesses, 0, $LVSCW_AUTOSIZE) ; Re-size the process list

	$hKill = GUICtrlCreateButton("&Kill Process", 128, 224, 105, 33)
	$hFreeSelected = GUICtrlCreateButton("Free &Selected", 240, 224, 105, 33, 0)

	GUISetState(@SW_SHOW)

	While WinExists($hMyProcess)
		$iMsg = GUIGetMsg()
		Switch $iMsg
			Case -3;, $hClose
				GUIDelete($hMyProcess)
			Case $hFreeSelected
				$hIndic = _GUICtrlListView_GetSelectedIndices($hProcesses, True) ; Get the selected item
				For $f = 1 To $hIndic[0]
					$hRet = _ReduceMemory($hList[$hIndic[$f]][1]) ; Reduce the process memory
				Next
			Case $hKill
				$hIndic = _GUICtrlListView_GetSelectedIndices($hProcesses, True) ; Get the selected item
				For $k = 1 To $hIndic[0]
					ProcessClose($hList[$hIndic[$k]][1]) ; Close the process
				Next
		EndSwitch
	WEnd
EndFunc   ;==>_FreeSelected

Func _DecideStatus($iType)
	Switch $iType
		Case 1 ; Available RAM
			If $hMem[2] <= $hMem[1] / 4 Then
				Return 0 ; Bad
			ElseIf $hMem[2] <= $hMem[1] / 2 Then
				Return 1 ; Ok
			Else
				Return 2 ; Good
			EndIf
		Case 2 ; Used RAM
			If $hMem[0] <= 25 Then
				Return 2 ; Bad
			ElseIf $hMem[0] <= 50 Then
				Return 1 ; Ok
			ElseIf $hMem[0] <= 75 Then
				Return 0 ; Good
			EndIf
		Case 3 ; CPU Usage
			If $iCPUTot <= 25 Then
				Return 2 ; Bad
			ElseIf $iCPUTot <= 50 Then
				Return 1 ; Ok
			Else
				Return 0 ; Good
			EndIf
	EndSwitch
EndFunc   ;==>_DecideStatus

Func _CritErr($sText)
	$sErrFile = FileOpen(@ScriptDir & '\err.log', 1)
	FileWrite($sErrFile, $sText & " @ " & @MON & "/" & @MDAY & "/" & @YEAR)
	MsgBox(16 + 4096, "RAMPro Critical Error", $sText & @LF & @LF & "Please refer to err.log for further details.")
	FileClose($sErrFile)
	Exit 1
EndFunc   ;==>_CritErr

Func _RunStartup($booShouldRun)
	If $booShouldRun = True Then
		FileCreateShortcut(@ScriptFullPath, @StartupDir & "\RAMPro.lnk", @StartupDir, "-auten")
	ElseIf $booShouldRun = False Then
		FileDelete(@StartupDir & "\RAMPro.lnk")
	EndIf
EndFunc   ;==>_RunStartup

;; CPU Functions by rasim (http://www.autoitscript.com/forum/index.php?showtopic=72689)
Func _GetSysTime(ByRef $sIdle, ByRef $sKernel, ByRef $sUser)
	DllCall("kernel32.dll", "int", "GetSystemTimes", "ptr", DllStructGetPtr($IDLETIME), _
			"ptr", DllStructGetPtr($KERNELTIME), _
			"ptr", DllStructGetPtr($USERTIME))

	$sIdle = DllStructGetData($IDLETIME, 1)
	$sKernel = DllStructGetData($KERNELTIME, 1)
	$sUser = DllStructGetData($USERTIME, 1)
EndFunc   ;==>_GetSysTime

Func _CPUCalc()
	Local $iSystemTime, $iTotal, $iCalcIdle, $iCalcKernel, $iCalcUser

	$iCalcIdle = ($EndIdle - $StartIdle)
	$iCalcKernel = ($EndKernel - $StartKernel)
	$iCalcUser = ($EndUser - $StartUser)

	$iSystemTime = ($iCalcKernel + $iCalcUser)
	$iTotal = Int(($iSystemTime - $iCalcIdle) * (100 / $iSystemTime)) & "%"

	$iCPUTot = Int(($iSystemTime - $iCalcIdle) * (100 / $iSystemTime))

	If _GUICtrlListView_GetItemText($hInfo, 4, 1) <> $iTotal Then
		_GUICtrlListView_SetItemText($hInfo, 4, $iTotal, 1)
		_GUICtrlListView_SetItemImage($hInfo, 4, _DecideStatus(3))
	EndIf
EndFunc   ;==>_CPUCalc

;; Visual Style Stuff
Func ActivateWindowTheme($hWnd)
	$dll = DllCall("uxtheme.dll", "int", "SetWindowTheme", "hwnd", $hWnd, "wstr", "", "wstr", "")
	If Not @error Then Return $dll
EndFunc   ;==>ActivateWindowTheme
