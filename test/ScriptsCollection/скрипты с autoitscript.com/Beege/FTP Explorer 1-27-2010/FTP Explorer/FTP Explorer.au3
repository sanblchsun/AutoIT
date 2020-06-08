#include <ComboConstants.au3>
#include <GuiRichEdit.au3>
#include <StructureConstants.au3>
#include <ButtonConstants.au3>
#include <StaticConstants.au3>
#include <WindowsConstants.au3>
#include <GUIConstantsEx.au3>
#include <GUIComboBox.au3>
#include <array.au3>
#include <file.au3>
#include <GUIListView.au3>
#include <FTPEx.au3>
#include <GuiMenu.au3>
#include <Guiedit.au3>
#include <Misc.au3>
#include <GuiStatusBar.au3>
#include <ProgressConstants.au3>
#include <Timers.au3>
#include <String.au3>
#include <Date.au3>
#include <Constants.au3>
#include "Include\Messages.au3"

;~ FileInstall('D:\FTP Explorer Project\FTP Explorer 1-27-10\FTP Worker.a3x', @ScriptDir & '\FTP Worker.a3x', 1)
;~ FileSetAttrib(@ScriptDir & '\FTP Worker.a3x', 'H')

Opt("MustDeclareVars", 1)
_Singleton("FTPPPP", 0)
Global $PSAPI = DllOpen(@SystemDir & "\psapi.dll")
Global $User32 = DllOpen("user32.dll")
Global $Kernel32 = DllOpen('kernel32.dll')
Global $Shell32 = DllOpen('shell32.dll')
Global $gsWorkerCMDLINE = @AutoItExe & ' /AutoIt3ExecuteScript "' & @ScriptDir & '\Include\FTP Worker.au3"'
_StartCommunications()
#Region GUI...........................................................
Global $gl_sTitle = "FTP Explorer"
Global $gl_iGUIWidth = 880
Global $GUI = GUICreate($gl_sTitle, $gl_iGUIWidth, 541)
GUISetStyle(BitOR($WS_MAXIMIZEBOX, $WS_MINIMIZEBOX, $WS_SYSMENU, $WS_CAPTION, $WS_POPUP, $WS_POPUPWINDOW, $WS_GROUP, $WS_TABSTOP, $WS_BORDER, $WS_CLIPSIBLINGS), -1, $GUI)
Local $MenuItem2 = GUICtrlCreateMenu("&File")
Local $MenuItem1 = GUICtrlCreateMenuItem("Connect", $MenuItem2)
Local $MenuItem3 = GUICtrlCreateMenuItem("Disconnect", $MenuItem2)
Local $MenuItem4 = GUICtrlCreateMenuItem("Exit", $MenuItem2)
Local $Help = GUICtrlCreateMenu("&Help")
Local $MenuItem5 = GUICtrlCreateMenuItem("How To Use", $Help)
Local $MenuItem6 = GUICtrlCreateMenuItem("About", $Help)
Global $Local_List = GUICtrlCreateListView("File", 4, 22, 429, 250, $LVS_SHOWSELALWAYS)
Global $FTP_List = GUICtrlCreateListView("File", 444, 22, 429, 250, $LVS_SHOWSELALWAYS)
Global $Queue_List = GUICtrlCreateListView("Name|Target", 4, 291, 429, 201, $LVS_SHOWSELALWAYS)
Global $Status_List = _GUICtrlRichEdit_Create($GUI, "FTP Explorer V2" & @CRLF, 444, 291, 429, 201, BitOR($ES_MULTILINE, $WS_VSCROLL, $WS_HSCROLL, $ES_READONLY))
_GUICtrlRichEdit_SetCharColor($Status_List, '65280')
Global $FTP_Count = GUICtrlCreateLabel("", 444, 272, 428, 17, BitOR($SS_CENTER, $SS_CENTERIMAGE))
Global $Local_Count = GUICtrlCreateLabel("", 5, 272, 428, 17, BitOR($SS_CENTER, $SS_CENTERIMAGE))
Global $FTP_Combo = GUICtrlCreateCombo("", 470, 0, 403, 25)
Local $bFTP_Back = GUICtrlCreateButton("Button1", 444, 0, 25, 21, BitOR($BS_ICON, $WS_GROUP))
GUICtrlSetImage(-1, @SystemDir & "\shell32.dll", -147, 0)
Global $Local_Combo = GUICtrlCreateCombo("", 30, 0, 403, 25)
Local $bLocal_Back = GUICtrlCreateButton("Button1", 4, 0, 25, 21, BitOR($BS_ICON, $WS_GROUP))
GUICtrlSetImage(-1, @SystemDir & "\shell32.dll", -147, 0)
Global $StatusBar, $g_ProgressBar
_Statusbar(1)
Local $GUI_AccelTable[1][2] = [["!+h", $MenuItem4]]
GUISetAccelerators($GUI_AccelTable)
_GUICtrlListView_SetImageList($Local_List, _GUIImageList_GetSystemImageList(), 1)
_GUICtrlListView_SetImageList($FTP_List, _GUIImageList_GetSystemImageList(), 1)
_GUICtrlListView_SetImageList($Queue_List, _GUIImageList_GetSystemImageList(), 1)
_GUICtrlListView_SetColumnWidth($Queue_List, 0, 217)
_GUICtrlListView_SetColumnWidth($Queue_List, 1, 208)
_GUICtrlRichEdit_SetLimitOnText($Status_List, 100000)
#EndRegion ### END Koda GUI section ###
#Region Global Vars, Constants and Handles............................
;Constants
Global Const $tagINTERNET_PROXY_INFO = 'dword AccessType;ptr Proxy;ptr ProxyBypass;';internet options
Global Const $INTERNET_OPTION_RECEIVE_TIMEOUT = 6;internet options
Global Const $cRed = '255', $cGreen = '65280', $cBlue = '16711680';colors
Global Const $cPink = '16711935', $cYellow = '65535', $cTeal = '16776960', $cPurp = '16711830';colors
Global Const $FOLDER_ICON_INDEX = _GUIImageList_GetFileIconIndex(@SystemDir, 0, 1)
;FTP Connection Status Vars
Global Enum $giUploading, $giDownloading, $giIdle, $giFinished; If you change these you must change the ones in FTP_Worker to be the same
Global $FTP_State = $giIdle, $gbFTP_Connected = False, $gbFTP_NOReconnet = False
Global $ghFTPOpen, $ghFTPConnect, $gsServer_Name, $gsServer_IP, $gaConnectionInfo[4], $ghFTPCallBack, $gaQueue[1]
Global $sComboFTP, $sComboLocal
Global $gtIdle_Clock, $CPU
Global $gsLocalCurrent, $gaLocalHistory[20], $gaFTPHistory[20]
Global $CPU_Register, $Transfer_Register, $IdleClock_Register = False;, $Checker_Register
;FTP Connect GUI vars
Global $inIP, $inPort, $inUser, $inPass
Global $hinIP, $ini_Servers, $sINI_History = @ScriptDir & '\History.ini'
;Handles
Global $hQueue_list = GUICtrlGetHandle($Queue_List)
Global $hLocal_List = GUICtrlGetHandle($Local_List)
Global $hFTP_List = GUICtrlGetHandle($FTP_List)
Global $hLocal_Combo = GUICtrlGetHandle($Local_Combo)
Global $hFTP_Combo = GUICtrlGetHandle($FTP_Combo)
Global $hFTP_List_Header = HWnd(_GUICtrlListView_GetHeader($hFTP_List))
Global $hLocal_List_Header = HWnd(_GUICtrlListView_GetHeader($hLocal_List))
#EndRegion Global Vars, Constants and Handles............................

GUIRegisterMsg($WM_NOTIFY, "WM_NOTIFY")
GUIRegisterMsg($WM_COMMAND, "WM_COMMAND")
GUIRegisterMsg($WM_SIZE, "WM_SIZE")
OnAutoItExitRegister('_ExitTime')
_Check_INI_File()
_Columns($hFTP_List, 'FTPColumns', True)
_Columns($hLocal_List, 'LocalColumns', True)
$CPU_Register = _Timer_SetTimer($GUI, 1000, "_CPU_IdleClock_Update")
_MyComputer()
GUISetState(@SW_SHOW, $GUI)
_FTP_Connect_GUI()
If $PSAPI <> -1 Then AdlibRegister('_ReduceMemory', 60000)
_ReduceMemory()
While 1
	Switch GUIGetMsg()
		Case $GUI_EVENT_CLOSE, $MenuItem4
			If $FTP_State <> $giIdle Then
				If MsgBox(36 + 262144, 'Transfer in Progress!', 'Are you sure you want to abort current transfer and quit?') = 7 Then
					ContinueLoop
				Else
					IniWrite($sINI_History, 'Abort', 'Abort', 3); 3 means exit
				EndIf
			Else
				_MsgSend('Worker', 3 & ';');tell worker to disconnect and exit
			EndIf
			_FTP_Disconnect()
			Do
				Sleep(100)
			Until Not _IsReceiver('Worker')
;~ 			If StringRight(@ScriptFullPath, 3) = 'exe' Then FileDelete(@ScriptDir & '\FTP Worker.a3x')
			Exit
;~ 		Case $GUI_EVENT_MAXIMIZE
;~ 			_Resize_Rich_Edit()
		Case $GUI_EVENT_RESTORE, $GUI_EVENT_MAXIMIZE
			If $FTP_State <> $giIdle Then
				Local $FileNameLen
				If ($gl_iGUIWidth / 2) > 480 Then
					$FileNameLen = ($gl_iGUIWidth / 2)
				Else
					$FileNameLen = $gl_iGUIWidth - 580 ; ;[75, ?,  80,  80,  80, 140, 200]
				EndIf
				Local $StatusBar_PartsWidth[7] = [75, $FileNameLen, $FileNameLen + 80, $FileNameLen + 160, $FileNameLen + 240, $FileNameLen + 380, -1]
				_GUICtrlStatusBar_SetParts($StatusBar, $StatusBar_PartsWidth)
				_GUICtrlStatusBar_EmbedControl($StatusBar, 6, GUICtrlGetHandle($g_ProgressBar), 4)
			Else
				Local $StatusBar_PartsWidth[4] = [200, ($gl_iGUIWidth / 2), ($gl_iGUIWidth - 80), -1]
				_GUICtrlStatusBar_SetParts($StatusBar, $StatusBar_PartsWidth)
			EndIf
			_Resize_Rich_Edit()
		Case $MenuItem1 ;connect
			_FTP_Connect_GUI()
		Case $MenuItem3 ;disconnect
			If $FTP_State <> $giIdle Then
				If MsgBox(36 + 262144, 'Transfer in Progress!', 'Are you sure you want to abort current transfer and disconnet?') = 7 Then
					ContinueLoop
				Else
;~ 					$gbFTP_NOReconnet = True
					IniWrite($sINI_History, 'Abort', 'Abort', 2);This will make the call to _FTP_Disconnect
				EndIf
			Else
				_MsgSend('Worker', 2 & ';')
				_FTP_Disconnect()
			EndIf
			GUICtrlSetState($MenuItem1, $GUI_ENABLE)
;~ 			_GUICtrlEdit_AppendText($hStatus_List, 'Disconnected.. ' & @CRLF)
		Case $bFTP_Back
			_FTPBack()
		Case $bLocal_Back
			_LocalBack()
;~ 		Case $MenuItem5
		Case $MenuItem6
			_About("About Info", "FTP Explorer", "Copyright © " & @YEAR & " Brian J Christy. All rights reserved.", "v2.2", "", "http://www.autoitscript.com", _
					'Contact Me', "mailto:FreeFTPExplorer@gmail.com", "Written with AutoIT", "http://www.autoitscript.com/", @AutoItExe, 0x0000FF, 0xFFFFFF, -1, -1, -1, -1, $GUI)
	EndSwitch
WEnd

#Region Transfer and Queue Functions..................................
Func _Transfer($hWnd, $Msg, $iIDTimer, $dwTime)

	If $FTP_State = $giUploading Or $FTP_State = $giDownloading Then Return

	If $FTP_State = $giFinished Then ; Set by FTP worker
		_ArrayDelete($gaQueue, 1)
		_GUICtrlListView_DeleteItem($hQueue_list, 0)
	EndIf

	Static $Up = False, $down = False
	If (UBound($gaQueue) - 1) > 0 Then
		Local $aSplit = StringSplit($gaQueue[1], ';')
	Else
		$FTP_State = $giIdle
		_Timer_KillTimer($GUI, $Transfer_Register)
		If $Up Then _FtpRefresh($INTERNET_FLAG_RELOAD)
		If $down Then _LocalGo($gsLocalCurrent)
		$Up = False
		$down = False
		_Statusbar(2)
		Return
	EndIf

	Select
		Case $aSplit[1] = 'upload'
			_GUICtrlStatusBar_SetText($StatusBar, 'Uploading', 0)
			If $aSplit[2] = 'DIR' Then
				_MsgSend('Worker', 6 & ';' & $aSplit[3] & $aSplit[4] & ';' & $aSplit[5] & $aSplit[4])
			Else
				_GUICtrlStatusBar_SetText($StatusBar, $aSplit[4], 1)
				_MsgSend('Worker', 4 & ';' & $aSplit[3] & ';' & $aSplit[4] & ';' & $aSplit[5])
			EndIf
			$Up = True
		Case $aSplit[1] = 'download'
			_GUICtrlStatusBar_SetText($StatusBar, 'Downloading', 0)
			If $aSplit[2] = 'DIR' Then
				_MsgSend('Worker', 7 & ';' & $aSplit[5] & ';' & $aSplit[4] & ';' & $aSplit[3])
			Else
				_GUICtrlStatusBar_SetText($StatusBar, $aSplit[4], 1)
				_MsgSend('Worker', 5 & ';' & $aSplit[3] & ';' & $aSplit[4] & ';' & $aSplit[5] & ';' & $aSplit[6])
			EndIf
			$down = True
	EndSelect

EndFunc   ;==>_Transfer
Func _QueueItems($hList)

	Local $aSelected, $i, $sFileName, $sItem, $sQueueItem
	Local $iIcon, $sType, $hOtherList, $iDup, $tInfo, $sSource, $sDest

	If $hList = $hFTP_List Then
		$hOtherList = $hLocal_List
	Else
		$hOtherList = $hFTP_List
	EndIf

	$tInfo = DllStructCreate($tagLVFINDINFO)
	DllStructSetData($tInfo, "Flags", $LVFI_STRING)

	Local $sCurrentFTP = StringReplace(_FTP_DirGetCurrent($ghFTPConnect) & '/', '//', '/')
	Local $sCurrentLocal = StringReplace($gsLocalCurrent & '\', '\\', '\')

	$aSelected = _GUICtrlListView_GetSelectedIndices($hList, True)
	For $i = 1 To $aSelected[0]
		$sFileName = _GUICtrlListView_GetItemText($hList, $aSelected[$i], 0)
		$iIcon = _GUICtrlListView_GetItemImage($hList, $aSelected[$i])
		$iDup = _GUICtrlListView_FindItem($hOtherList, -1, $tInfo, $sFileName)
		If $iDup > 0 Then
			If MsgBox(36, 'Confirm Overwrite', $sFileName & ' is already in the location you wish to send it to. Are you sure you want to replace it?') = 7 Then ContinueLoop
		EndIf
		If $iIcon = $FOLDER_ICON_INDEX Then
			$sType = 'DIR'
		Else
			$sType = 'file'
		EndIf
		If $hList = $hFTP_List Then
			$sQueueItem = 'download;' & $sType & ';' & $sCurrentLocal & ';' & $sFileName & ';' & $sCurrentFTP & ';' & _FTP_FileGetSize($ghFTPConnect, $sFileName)
			$sSource = $sCurrentFTP & $sFileName
			$sDest = $sCurrentLocal
		Else
			$sQueueItem = 'upload' & ';' & $sType & ';' & $sCurrentLocal & ';' & $sFileName & ';' & $sCurrentFTP
			$sSource = $sCurrentLocal & $sFileName
			$sDest = $sCurrentFTP
		EndIf
		$sItem = _GUICtrlListView_AddItem($Queue_List, $sSource, $iIcon)
		_GUICtrlListView_AddSubItem($Queue_List, $sItem, $sDest, 1)
		_ArrayAdd($gaQueue, $sQueueItem)
	Next
EndFunc   ;==>_QueueItems
#EndRegion Transfer and Queue Functions..................................
#Region Script Communication Functions................................
Func _StartCommunications()
	_MsgRegister('Boss', '_Receiver')
	Run($gsWorkerCMDLINE)
	Do
		Sleep(100)
	Until _IsReceiver('Worker')
EndFunc   ;==>_StartCommunications
Func _Receiver($Msg)
	Local $aMsg = StringSplit($Msg, ';', 2)
	Switch $aMsg[0]
		Case 1;Set State
			$FTP_State = $aMsg[1]
		Case 2; Update StatusBar transfer values
			Static $Time = 0, $speed = 0, $bytes_transfer = 0

			If $aMsg[4] <> $Time Then
				If $aMsg[4] < 3600 Then;Time
					_GUICtrlStatusBar_SetText($StatusBar, "Time (" & StringFormat("%02i:%02i", Int($aMsg[4] / 60), Mod($aMsg[4], 60)) & ")", 3)
				Else
					Local $iTicks = Mod($aMsg[4], 3600)
					_GUICtrlStatusBar_SetText($StatusBar, "Time (" & StringFormat("%02i:%02i:%02i", Int($aMsg[4] / 3600), Int($iTicks / 60), Mod($iTicks, 60)) & ")", 3)
				EndIf
				$aMsg[4] = $Time
			EndIf

			If $aMsg[3] <> $bytes_transfer Then
				_GUICtrlStatusBar_SetText($StatusBar, $aMsg[3], 5); bytes transferd
				$bytes_transfer = $aMsg[3]
			EndIf
			If $aMsg[2] <> $speed Then
				_GUICtrlStatusBar_SetText($StatusBar, $aMsg[2], 4);speed
				$aMsg[2] = $speed
			EndIf

			GUICtrlSetData($g_ProgressBar, $aMsg[1])
		Case 3; Update StatusBar filename - used when transfering directorys
			_GUICtrlStatusBar_SetText($StatusBar, $aMsg[1], 1)
			_RichEdit_Append('Starting Transfer:' & $aMsg[1], $cBlue)
		Case 4; Transfer of file finshed
			_RichEdit_Append('Transfered: ' & $aMsg[1] & ' ' & _bytes($aMsg[2]) & ' in ' & _Format_Time($aMsg[3]) & _
					' (' & _Speed($aMsg[2], $aMsg[3]) & ')', $cBlue)
		Case 5;console message
			ConsoleWrite('>>>>>>>WORKER MESSAGE: ' & $aMsg[1] & @CRLF)
		Case 6
			_Timer_KillTimer($GUI, $Transfer_Register)
			_RichEdit_Append('Transfer Aborted!', $cRed)
			$FTP_State = $giIdle
			Do
				Sleep(100)
			Until Not _IsReceiver('Worker')
			Local $iDelete = False
			If Int($aMsg[2]) = 1 Then
				_FTP_FileDelete($ghFTPConnect, $aMsg[3])
				If Not @error Then $iDelete = True
			Else
				If FileDelete($aMsg[3]) Then $iDelete = True
			EndIf
			If $iDelete Then
				_RichEdit_Append($aMsg[3] & ' partial file has been deleted.', $cRed)
			Else
				_RichEdit_Append($aMsg[3] & ' partial file removal failed.', $cRed)
			EndIf
			If $aMsg[1] <> '3' Then ;disconnet or abort transfer
				Run($gsWorkerCMDLINE)
				Do
					Sleep(100)
				Until _IsReceiver('Worker')
				If $aMsg[1] = '2' Then _FTP_Disconnect()
			EndIf
			If $aMsg[1] = '1' Then; just abort transfer so reconnect worker
				_MsgSend('Worker', 1 & ';' & $gaConnectionInfo[0] & ';' & $gaConnectionInfo[1] & ';' & $gaConnectionInfo[2] & ';' & $gaConnectionInfo[3])
				_Statusbar(2)
			EndIf
		Case 7
;~ 			$pMemoryAddress = ptr($aMsg[1])
	EndSwitch
EndFunc   ;==>_Receiver
#EndRegion Script Communication Functions................................
#Region Local Navigation Functions....................................
Func _MyComputer()
	Local $drives, $attributes, $item, $Time, $iIndex = 1
	$gsLocalCurrent = 'My Computer'
	_GUICtrlListView_DeleteAllItems($hLocal_List)
	$drives = DriveGetDrive("ALL")
	Local $Columns = IniReadSection($sINI_History, 'LocalColumns')
	For $i = 1 To 5
		$Columns[$i][1] = Int($Columns[$i][1])
	Next
	For $i = 1 To $drives[0]
		$item = _GUICtrlListView_AddItem($hLocal_List, DriveGetLabel($drives[$i] & '\') & ' (' & StringUpper($drives[$i]) & ')', _GUIImageList_GetFileIconIndex($drives[$i] & '\'))
;~ 		$item = _GUICtrlListView_AddItem($Local_List, $drives[$i] & '\', _GUIImageList_GetFileIconIndex($drives[$i] & '\'))
		If $Columns[1][1] Then ;size
			_GUICtrlListView_AddSubItem($Local_List, $item, 'DIR', $iIndex)
			$iIndex += 1
		EndIf
		If $Columns[2][1] Then $iIndex += 1;Modified
		If $Columns[3][1] Then;Attributes
			$attributes = FileGetAttrib($drives[$i] & '\')
			_GUICtrlListView_AddSubItem($Local_List, $item, $attributes, $iIndex)
		EndIf
		$iIndex = 1
	Next
	GUICtrlSetData($Local_Count, $drives[0] & ' Drives')
	_ComboHistoryAdd($Local_Combo, $sComboLocal, 'My Computer')
EndFunc   ;==>_MyComputer
Func _LocalDirSwitch($index)
	Local $sChangeDir
	Select
		Case _GUICtrlListView_GetItemText($Local_List, $index) = '[..]'
			_LocalParent()
			Return
		Case $gsLocalCurrent = 'My Computer';
			Local $sItem = _GUICtrlListView_GetItemText($Local_List, $index)
			$sChangeDir = StringMid($sItem, StringInStr($sItem, '(') + 1, 2) & '\'
		Case Else
			$sChangeDir = StringReplace($gsLocalCurrent & '\' & _GUICtrlListView_GetItemText($Local_List, $index), '\\', '\')
			If StringInStr(FileGetAttrib($sChangeDir), 'D') = 0 Then Return
	EndSelect
	_Push_History($gsLocalCurrent, $gaLocalHistory)
	_LocalGo($sChangeDir)
EndFunc   ;==>_LocalDirSwitch
Func _LocalParent()
	Local $aDirSplit, $sChangeDir
	$aDirSplit = StringSplit($gsLocalCurrent, '\')
	If $aDirSplit[0] = 2 Then
		If $aDirSplit[2] = '' Then
			$sChangeDir = 'My Computer'
		Else
			$sChangeDir = $aDirSplit[1] & '\'
		EndIf
	Else
		For $i = 1 To $aDirSplit[0] - 1
			$sChangeDir &= $aDirSplit[$i] & '\'
		Next
		$sChangeDir = StringTrimRight($sChangeDir, 1)
	EndIf
	_Push_History($gsLocalCurrent, $gaLocalHistory)
	_LocalGo($sChangeDir)
EndFunc   ;==>_LocalParent
Func _LocalGo($sDirectory)
	If $sDirectory = 'My Computer' Then
		_MyComputer()
		Return
	EndIf
	Local $item, $iIcon, $iDirs = 0, $iFiles = 0, $iSize = 0
	Local $iIndex, $sSize, $iIndex = 1, $IsDir, $sFile, $attributes, $Time
	_GUICtrlListView_DeleteAllItems($hLocal_List)
	Local $Columns = IniReadSection($sINI_History, 'LocalColumns')
	For $i = 1 To 5
		$Columns[$i][1] = Int($Columns[$i][1])
	Next
	Local $aList = _FileListToArray_mod($sDirectory)
	_GUICtrlListView_BeginUpdate($hLocal_List)
	_GUICtrlListView_AddItem($Local_List, "[..]", 1)
	If IsArray($aList) Then
		For $i = 1 To $aList[0]
			$sFile = $sDirectory & '\' & $aList[$i]
			$attributes = FileGetAttrib($sFile)
			If StringInStr($attributes, 'D') > 0 Then
				$IsDir = True
				$sSize = 'DIR'
				$iIcon = $FOLDER_ICON_INDEX
				$iDirs += 1
			Else
				$IsDir = False
				$sSize = FileGetSize($sFile)
				$iSize += $sSize
				$iIcon = _GUIImageList_GetFileIconIndex($aList[$i])
				$iFiles += 1
			EndIf
			$item = _GUICtrlListView_AddItem($Local_List, $aList[$i], $iIcon)
			If $Columns[1][1] Then ;size
				If $IsDir Then
					_GUICtrlListView_AddSubItem($Local_List, $item, 'DIR', $iIndex)
				Else
					_GUICtrlListView_AddSubItem($Local_List, $item, _bytes($sSize), $iIndex)
				EndIf
				$iIndex += 1
			EndIf
			If $Columns[2][1] Then;Modified
				$Time = FileGetTime($sFile, 0)
				_GUICtrlListView_AddSubItem($Local_List, $item, $Time[0] & '/' & $Time[1] & '/' & $Time[2] & ' ' & $Time[3] & ':' & $Time[4] & ':' & $Time[5], $iIndex)
				$iIndex += 1
			EndIf
			If $Columns[3][1] Then;Attributes
				_GUICtrlListView_AddSubItem($Local_List, $item, $attributes, $iIndex)
				$iIndex += 1
			EndIf
			If $Columns[4][1] Then;Creation
				$Time = FileGetTime($sFile, 1)
				_GUICtrlListView_AddSubItem($Local_List, $item, $Time[0] & '/' & $Time[1] & '/' & $Time[2] & ' ' & $Time[3] & ':' & $Time[4] & ':' & $Time[5], $iIndex)
				$iIndex += 1
			EndIf
			If $Columns[5][1] Then;Accessed
				$Time = FileGetTime($sFile, 2)
				_GUICtrlListView_AddSubItem($Local_List, $item, $Time[0] & '/' & $Time[1] & '/' & $Time[2] & ' ' & $Time[3] & ':' & $Time[4] & ':' & $Time[5], $iIndex)
				$iIndex += 1
			EndIf
			$iIndex = 1
		Next
	EndIf
	_GUICtrlListView_EndUpdate($hLocal_List)
	If $iFiles = 0 Then
		GUICtrlSetData($Local_Count, $iDirs & ' Directorys, ' & $iFiles & ' Files ')
	Else
		GUICtrlSetData($Local_Count, $iDirs & ' Directorys, ' & $iFiles & ' Files ' & '[' & _bytes($iSize) & ']')
	EndIf
	_ComboHistoryAdd($Local_Combo, $sComboLocal, $sDirectory)
	$gsLocalCurrent = $sDirectory
EndFunc   ;==>_LocalGo
Func _LocalBack()
	If $gaLocalHistory[0] = '' Then Return
	_LocalGo(_Pop_History($gaLocalHistory))
EndFunc   ;==>_LocalBack
Func _Localcreatefolder()
	Local $sName = InputBox('Create New Directory', 'Enter Directory Name', '', " M", Default, 130)
	DirCreate(StringReplace($gsLocalCurrent & '\' & $sName, '\\', '\'))
	_LocalGo($gsLocalCurrent);refresh
EndFunc   ;==>_Localcreatefolder
Func _LocalDelete()
	If MsgBox(36, 'Confirm File Delete', 'Are you sure you want to delete selected files?') = 7 Then Return
	Local $i, $sFileName, $aLocalSelected
	$aLocalSelected = _GUICtrlListView_GetSelectedIndices($hLocal_List, True)
	For $i = 1 To $aLocalSelected[0]
		$sFileName = StringReplace($gsLocalCurrent & '\' & _GUICtrlListView_GetItemText($Local_List, $aLocalSelected[$i], 0), '\\', '\')
		If StringInStr(FileGetAttrib($sFileName), 'D') = 0 Then
			FileDelete($sFileName)
		Else
			DirRemove($sFileName, 1)
		EndIf
	Next
	_GUICtrlListView_DeleteItemsSelected($hLocal_List)
	_LocalGo($gsLocalCurrent);refresh
EndFunc   ;==>_LocalDelete
#EndRegion Local Navigation Functions....................................

;
#Region Ftp Navigation Functions......................................
Func _FTPDirSwitch($index)
	Local $sCurrentFTPDir, $sChangeDir, $aItem
	$sCurrentFTPDir = _FTP_DirGetCurrent($ghFTPConnect)
	If _GUICtrlListView_GetItemText($FTP_List, $index, 0) = '[..]' Then
		$sChangeDir = _FTPParent($sCurrentFTPDir)
	Else
		$aItem = _GUICtrlListView_GetItem($FTP_List, $index)
		If $aItem[4] = $FOLDER_ICON_INDEX Then
			If $sCurrentFTPDir = '/' Then
				$sChangeDir = '/' & _GUICtrlListView_GetItemText($FTP_List, $index)
			Else
				$sChangeDir = $sCurrentFTPDir & '/' & _GUICtrlListView_GetItemText($FTP_List, $index)
			EndIf
		Else
			Return
		EndIf
	EndIf
	_FTPGo($sChangeDir)
	ControlFocus($gl_sTitle, '', $FTP_List);RichEdit keeps stealing Focus
EndFunc   ;==>_FTPDirSwitch
Func _FTPGo($sChangeDir, $iInternet_Flag = $INTERNET_FLAG_HYPERLINK)
	Local $sFTPCurrent = _FTP_DirGetCurrent($ghFTPConnect)
	If $sChangeDir = $sFTPCurrent Then Return
	_RichEdit_Append('Changing Directories...', $cPurp)
	_Push_History($sFTPCurrent, $gaFTPHistory)
	_FTP_DirSetCurrent($ghFTPConnect, $sChangeDir)
	If @error Then
		_RichEdit_Append('ERROR: FTP Directory Change to ' & $sChangeDir & ' Failed...', $cRed)
		_Pop_History($gaFTPHistory)
		Return
	EndIf
	_ComboHistoryAdd($FTP_Combo, $sComboFTP, $sChangeDir)
	_FtpRefresh($iInternet_Flag)
	_RichEdit_Append('Change Successful.' & '"' & $sChangeDir & '"' & ' is the Current Directory', $cPurp)
EndFunc   ;==>_FTPGo
Func _FTPParent($sCurrentDir)
	Local $pos = StringInStr($sCurrentDir, '/', 0, -1)
	If $pos = 1 Then Return '/'
	Return StringLeft($sCurrentDir, $pos - 1)
EndFunc   ;==>_FTPParent
Func _FTPBack()
	If $gaFTPHistory[0] = '' Then Return
	Local $Back = _Pop_History($gaFTPHistory)
	_FTP_DirSetCurrent($ghFTPConnect, $Back)
	If @error Then
		_RichEdit_Append('ERROR: FTP Directory Change to ' & $Back & ' Failed...', $cRed)
		Return
	EndIf
	_ComboHistoryAdd($FTP_Combo, $sComboFTP, $Back)
	_FtpRefresh()
EndFunc   ;==>_FTPBack
Func _FtpRefresh($iFlag = $INTERNET_FLAG_RELOAD)
	Local $aFile, $i, $item, $IsDir, $iIcon, $sCurrent, $iDirs = 0, $iFiles = 0, $iSize = 0, $iIndex = 1
	_GUICtrlListView_DeleteAllItems($hFTP_List)
	$sCurrent = _FTP_DirGetCurrent($ghFTPConnect)
	If $sCurrent <> '/' Then _GUICtrlListView_AddItem($FTP_List, "[..]", 1)
	$aFile = _FTP_ListToArrayEx($ghFTPConnect, 0, $iFlag, 1, $ghFTPCallBack)
	If IsArray($aFile) Then
		Local $Columns = IniReadSection($sINI_History, 'FTPColumns')
		For $i = 1 To 5
			$Columns[$i][1] = Int($Columns[$i][1])
		Next
		_GUICtrlListView_BeginUpdate($hFTP_List)
		For $i = 1 To $aFile[0][0]
			$IsDir = BitAND($aFile[$i][2], $FILE_ATTRIBUTE_DIRECTORY) = $FILE_ATTRIBUTE_DIRECTORY
			If $IsDir Then
				$iIcon = $FOLDER_ICON_INDEX
				$iDirs += 1
			Else
				$iFiles += 1
				$iSize += $aFile[$i][1]
				$iIcon = _GUIImageList_GetFileIconIndex('c:\blank.' & StringRight($aFile[$i][0], 3))
			EndIf
			$item = _GUICtrlListView_AddItem($hFTP_List, $aFile[$i][0], $iIcon)
;~ 				Local $aColumns[5][2] = [["Size", '75'],["Modified", '0'],["Attributes", '0'],["Creation", '0'],["Accessed", '0']]
			If $Columns[1][1] Then ;size
				If $IsDir Then
					_GUICtrlListView_AddSubItem($FTP_List, $item, 'DIR', $iIndex)
				Else
					_GUICtrlListView_AddSubItem($FTP_List, $item, _bytes($aFile[$i][1]), $iIndex)
				EndIf
				$iIndex += 1
			EndIf
			If $Columns[2][1] Then;Modified
				_GUICtrlListView_AddSubItem($FTP_List, $item, $aFile[$i][3], $iIndex)
				$iIndex += 1
			EndIf
			If $Columns[3][1] Then;Attributes
				_GUICtrlListView_AddSubItem($FTP_List, $item, $aFile[$i][2], $iIndex)
				$iIndex += 1
			EndIf
			If $Columns[4][1] Then;Creation
				_GUICtrlListView_AddSubItem($FTP_List, $item, $aFile[$i][4], $iIndex)
				$iIndex += 1
			EndIf
			If $Columns[5][1] Then;Accessed
				_GUICtrlListView_AddSubItem($FTP_List, $item, $aFile[$i][5], $iIndex)
				$iIndex += 1
			EndIf
			$iIndex = 1
		Next
		_GUICtrlListView_EndUpdate($hFTP_List)
	EndIf
	GUICtrlSetData($FTP_Count, $iDirs & ' Directorys, ' & $iFiles & ' Files ' & '[' & _bytes($iSize) & ']')
EndFunc   ;==>_FtpRefresh
#EndRegion Ftp Navigation Functions......................................
#Region FTP Functions.................................................
Func _FTP_Connect_GUI()
	Local $GUI_Connect, $butConnect, $address, $taddress
	Local $server_History, $sLastIP

	$sLastIP = IniRead($sINI_History, 'Last', 'IP', '')
	$ini_Servers = IniReadSectionNames($sINI_History)
	For $i = 1 To $ini_Servers[0]
		Switch $ini_Servers[$i]
			Case 'Abort', 'Last', $sLastIP, 'FTPColumns', 'LocalColumns', 'Queue'
			Case Else
				$server_History &= $ini_Servers[$i] & '|'
		EndSwitch
	Next
	$server_History = StringTrimRight($server_History, 1)
	$GUI_Connect = GUICreate("FTP Connect", 323, 140, Default, Default, Default, Default, $GUI)
	GUISwitch($GUI_Connect)
	$inIP = GUICtrlCreateCombo(IniRead($sINI_History, 'Last', 'IP', ''), 80, 15, 166, 21)
	$hinIP = GUICtrlGetHandle($inIP)
	GUICtrlCreateLabel("Server or Url:", 10, 20, 66, 17)
	$inPort = GUICtrlCreateInput(IniRead($sINI_History, 'Last', 'Port', ''), 285, 15, 26, 21)
	GUICtrlCreateLabel("Port:", 255, 20, 26, 17)
	$inUser = GUICtrlCreateInput(IniRead($sINI_History, 'Last', 'User', ''), 80, 45, 231, 21)
	GUICtrlCreateLabel("User Name:", 10, 50, 60, 17)
	Local $Decrypt_Pass = IniRead($sINI_History, 'Last', 'Pass', '')
	If $Decrypt_Pass <> '' Then $Decrypt_Pass = _StringEncrypt(0, $Decrypt_Pass, 'autoitrocks')
	$inPass = GUICtrlCreateInput($Decrypt_Pass, 80, 75, 231, 21, $ES_PASSWORD)
	GUICtrlCreateLabel("Password:", 10, 80, 53, 17)
	$butConnect = GUICtrlCreateButton("Connect", 100, 105, 106, 26, 0)
	If $server_History <> '' Then GUICtrlSetData($inIP, $server_History)
	GUISetState(@SW_SHOW, $GUI_Connect)
	While 1

		Switch GUIGetMsg()
			Case $GUI_EVENT_CLOSE
				GUIDelete($GUI_Connect)
				$address = ''
				Return $address
			Case $butConnect
				Local $tIP = GUICtrlRead($inIP)
				If $tIP = '' Then
					MsgBox(0, 'ERROR', 'Must Enter Server or Url.', 5)
					ContinueLoop
				EndIf
				$taddress = _CheckIP($tIP)
				Local $tPass = GUICtrlRead($inPass), $tUser = GUICtrlRead($inUser), $tPort = GUICtrlRead($inPort)
				Local $aSearch = _ArraySearch($ini_Servers, $tIP)
				If @error Then;if not found then save address. If its not an array than history file is empty
					If $tPass <> '' Then $tPass = _StringEncrypt(1, $tPass, 'autoitrocks')
					Local $aData[5][2] = [["User", $tUser],["Pass", $tPass],["Port", $tPort],["DIR_History", ''],['Queue', '']]
					IniWriteSection($sINI_History, $tIP, $aData, 0)
				Else;verify that data is still the same.
					If $tPass <> '' Then $tPass = _StringEncrypt(1, $tPass, 'autoitrocks')
					If $tUser <> IniRead($sINI_History, $tIP, 'User', '') Then IniWrite($sINI_History, $tIP, 'User', $tUser)
					If $tPass <> IniRead($sINI_History, $tIP, 'Pass', '') Then IniWrite($sINI_History, $tIP, 'Pass', $tPass)
					If $tPort <> IniRead($sINI_History, $tIP, 'Port', '') Then IniWrite($sINI_History, $tIP, 'Port', $tPort)
					Local $DirHistory = IniRead($sINI_History, $tIP, 'DIR_History', '')
					GUICtrlSetData($FTP_Combo, $DirHistory)
					Local $sQueueHistory = IniRead($sINI_History, $tIP, 'Queue', '')
					If $sQueueHistory <> '' Then
						_LoadQueue($sQueueHistory)
						IniWrite($sINI_History, $tIP, 'Queue', '')
					EndIf
					$sComboFTP = $DirHistory
				EndIf
				Local $aLast[4][2] = [["User", $tUser],["Pass", $tPass],["Port", $tPort],["IP", $tIP]]
				IniWriteSection($sINI_History, 'Last', $aLast, 0)
				GUISetState(@SW_HIDE, $GUI_Connect)
				_connect($taddress, $tUser, GUICtrlRead($inPass), $tPass)
				If @error = -3 Then
					_RichEdit_Append('Failed to Connect to Server..', $cRed)
					GUISetState(@SW_SHOW, $GUI_Connect)
					ContinueLoop
				EndIf
				GUIDelete($GUI_Connect)
				GUISwitch($GUI)
				Return
		EndSwitch
	WEnd
EndFunc   ;==>_FTP_Connect_GUI
Func _LoadQueue($sQueue)
	Local $aQueueSplit, $aItemsplit, $i, $iIcon, $sSource, $sDest, $sItem
	$aQueueSplit = StringSplit($sQueue, '|')
	_ArraytoConsole($aQueueSplit)
	For $i = 1 To $aQueueSplit[0]
		$aItemsplit = StringSplit($aQueueSplit[$i], ';')
		If $aItemsplit[2] = 'DIR' Then
			$iIcon = $FOLDER_ICON_INDEX
		Else
			$iIcon = _GUIImageList_GetFileIconIndex($aItemsplit[4])
		EndIf

		If $aItemsplit[1] = 'download' Then
			$sSource = $aItemsplit[5] & $aItemsplit[4]
			$sDest = $aItemsplit[3]
		Else
			$sSource = $aItemsplit[3] & $aItemsplit[4]
			$sDest = $aItemsplit[5]
		EndIf

		$sItem = _GUICtrlListView_AddItem($Queue_List, $sSource, $iIcon)
		_GUICtrlListView_AddSubItem($Queue_List, $sItem, $sDest, 1)
		_ArrayAdd($gaQueue, $aQueueSplit[$i])
	Next
EndFunc   ;==>_LoadQueue
Func _CheckIP($ip) ; Verifys corrent IP format or converts URL to IP. Needs to be rewrote.
	Local $ipcheck, $newip
	$ipcheck = StringReplace($ip, '.', '')
	If StringIsDigit($ipcheck) Then
		$gsServer_IP = $ip
		$gsServer_Name = ''
		Return $ip
	EndIf
	$gsServer_Name = $ip;
	$ip = StringReplace($ip, 'ftp://', '')
	$ip = StringReplace($ip, 'ftp:/', '')
	If StringRight($ip, 1) = '/' Then $ip = StringTrimRight($ip, 1)
	TCPStartup()
	$newip = TCPNameToIP($ip)
	TCPShutdown()
	If $newip = '' Then
		MsgBox(0, 'ERROR', 'Problem with Server address.')
		Return 0
	EndIf
	$gsServer_IP = $newip
	Return $newip
EndFunc   ;==>_CheckIP
Func _connect($sFTP_IPAddress, $sUser, $sPass, $iPort, $sSession = 'session');;;;
	Local $iDirs = 0, $iFiles = 0, $iSize = 0
	$ghFTPOpen = _FTP_Open($sSession)
	_InternetSetOption($ghFTPOpen, $INTERNET_OPTION_RECEIVE_TIMEOUT, 6000)
	$ghFTPCallBack = _FTP_SetStatusCallback($ghFTPOpen, '_FTP_StatusHandler')
	$ghFTPConnect = _FTP_Connect($ghFTPOpen, $sFTP_IPAddress, $sUser, $sPass, 1, $iPort, 1, 0, $ghFTPCallBack)
	If @error = -1 Then
		$gsServer_IP = ''
		$gsServer_Name = ''
		SetError(-3)
		Return
	EndIf
	$gbFTP_NOReconnet = False
	$gsServer_IP = $sFTP_IPAddress
	$gaConnectionInfo[0] = $sFTP_IPAddress
	$gaConnectionInfo[1] = $sUser
	$gaConnectionInfo[2] = $sPass
	$gaConnectionInfo[3] = $iPort
	_MsgSend('Worker', 1 & ';' & $gaConnectionInfo[0] & ';' & $gaConnectionInfo[1] & ';' & $gaConnectionInfo[2] & ';' & $gaConnectionInfo[3])
	GUICtrlSetState($MenuItem1, $GUI_DISABLE)
	_Statusbar(2)
	_FtpRefresh()
	_ComboHistoryAdd($FTP_Combo, $sComboFTP, '/')
	GUICtrlSetData($FTP_Count, $iDirs & ' Directorys, ' & $iFiles & ' Files ' & '[' & _bytes($iSize) & ']')
EndFunc   ;==>_connect
Func _FTP_Disconnect()
	If $gbFTP_Connected Then
		If $gsServer_Name <> '' Then
			IniWrite($sINI_History, $gsServer_Name, 'DIR_History', $sComboFTP)
		Else
			IniWrite($sINI_History, $gsServer_IP, 'DIR_History', $sComboFTP)
		EndIf
		If (UBound($gaQueue) - 1) > 0 Then
			Local $sQueue = StringTrimLeft(_ArrayToString($gaQueue, '|'), 1)
			If $gsServer_Name <> '' Then
				IniWrite($sINI_History, $gsServer_Name, 'Queue', $sQueue)
			Else
				IniWrite($sINI_History, $gsServer_IP, 'Queue', $sQueue)
			EndIf
		EndIf
		Global $gaQueue[1]
		_GUICtrlListView_DeleteAllItems($hQueue_list)
		_GUICtrlListView_DeleteAllItems($hFTP_List)
		$gsServer_IP = ''
		$gsServer_Name = ''
		$sComboFTP = ''
		GUICtrlSetData($FTP_Combo, '', '')
		$FTP_State = $giIdle
		$IdleClock_Register = False
		_GUICtrlStatusBar_Destroy($StatusBar)
		Local $StatusBar_PartsWidth[4] = [200, ($gl_iGUIWidth / 2), ($gl_iGUIWidth - 80), -1]
		Local $StatusBar_PartsText[4] = ["Not Connected", "", "", $CPU]
		$StatusBar = _GUICtrlStatusBar_Create($GUI, $StatusBar_PartsWidth, $StatusBar_PartsText)
		_GUICtrlStatusBar_SetMinHeight($StatusBar, 21)
;~ 		_Timer_KillTimer($GUI, $IdleClock_Register)
		_FTP_Close($ghFTPOpen)
	EndIf
EndFunc   ;==>_FTP_Disconnect
Func _FTPRemovedir($sFTPDirectory)
	Local $aFile, $hSearch, $sWorkingdir, $sFolderList, $i, $bFirst, $aFolderStack[2] = [1, $sFTPDirectory]
	While $aFolderStack[0] > 0
		$sWorkingdir = $aFolderStack[$aFolderStack[0]]
		$aFolderStack[0] -= 1
		$aFile = _FTP_FindFileFirst($ghFTPConnect, $sWorkingdir & '/*', $hSearch, $INTERNET_FLAG_RELOAD)
		If Not @error Then
			$bFirst = True
			While 1
				If Not $bFirst Then
					$aFile = _FTP_FindFileNext($hSearch)
					If @error Then ExitLoop
				EndIf
				If $aFile[1] = 16 Then
					$aFolderStack[0] += 1
					If UBound($aFolderStack) <= $aFolderStack[0] Then ReDim $aFolderStack[UBound($aFolderStack) * 2]
					$aFolderStack[$aFolderStack[0]] = $sWorkingdir & "/" & $aFile[10]
					$sFolderList &= $sWorkingdir & "/" & $aFile[10] & ';'
				Else
					_FTP_FileDelete($ghFTPConnect, $sWorkingdir & "/" & $aFile[10])
					_RichEdit_Append('File "' & $sWorkingdir & "/" & $aFile[10] & '" was Deleted', $cRed)
				EndIf
				$bFirst = False
			WEnd
		EndIf
		_FTP_FindFileClose($hSearch)
	WEnd
	$aFolderStack = StringSplit(StringTrimRight($sFolderList, 1), ';')
	For $i = $aFolderStack[0] To 1 Step -1
		_FTP_DirDelete($ghFTPConnect, $aFolderStack[$i])
		_RichEdit_Append('Directory "' & $aFolderStack[$i] & '" was Deleted', $cRed)
	Next
EndFunc   ;==>_FTPRemovedir
Func _FTP_Delete()
	Local $aFTPSelected, $sCurrentFTP, $sFileName, $sFileType, $i
	If MsgBox(36 + 262144, 'Confirm File Delete', 'Are you sure you want to delete selected files?') = 7 Then Return
	$aFTPSelected = _GUICtrlListView_GetSelectedIndices($hFTP_List, True)
	$sCurrentFTP = _FTP_DirGetCurrent($ghFTPConnect)
	For $i = 1 To $aFTPSelected[0]
		$sFileName = _GUICtrlListView_GetItemText($FTP_List, $aFTPSelected[$i], 0)
		$sFileType = _GUICtrlListView_GetItemText($FTP_List, $aFTPSelected[$i], 1)
		If $sFileType = 'DIR' Then
			_FTPRemovedir($sCurrentFTP & '/' & $sFileName)
			_FTP_DirSetCurrent($ghFTPConnect, $sCurrentFTP)
			If _FTP_DirDelete($ghFTPConnect, $sFileName) Then
				_RichEdit_Append('Directory "' & $sCurrentFTP & '/' & $sFileName & '" was Deleted', $cRed)
			EndIf
		Else
			If _FTP_FileDelete($ghFTPConnect, $sFileName) Then
				_RichEdit_Append('File "' & $sCurrentFTP & '/' & $sFileName & '" was Deleted', $cRed)
			EndIf
		EndIf
	Next
	_GUICtrlListView_DeleteItemsSelected($hFTP_List)
	_FtpRefresh($INTERNET_FLAG_RELOAD)
EndFunc   ;==>_FTP_Delete
Func _FTP_StatusHandler($hInternet, $dwContent, $dwInternetStatus, $lpvStatusInformation, $dwStatusInformationLength)
	Switch $dwInternetStatus
		Case $INTERNET_STATUS_RESOLVING_NAME
			_RichEdit_Append('Resolving Name...', $cBlue)
		Case $INTERNET_STATUS_NAME_RESOLVED
			_RichEdit_Append('Name Resolved', $cBlue)
		Case $INTERNET_STATUS_CONNECTING_TO_SERVER
			_RichEdit_Append('Connecting to Server: ' & $gsServer_Name & ' (' & $gsServer_IP & ')', $cBlue)
		Case $INTERNET_STATUS_CONNECTED_TO_SERVER
			_RichEdit_Append('Connected!', $cBlue)
			$gbFTP_Connected = True
		Case $INTERNET_STATUS_CONNECTION_CLOSED
			_RichEdit_Append('Connection Closed.', $cBlue)
			$gbFTP_Connected = False
		Case $INTERNET_STATUS_CLOSING_CONNECTION
			_RichEdit_Append('Closing Connection...', $cBlue)
		Case Else
			$gtIdle_Clock = TimerInit()
	EndSwitch

EndFunc   ;==>_FTP_StatusHandler
#EndRegion FTP Functions.................................................
#Region Column Functions..............................................
Func _Columns($hList, $sSection, $bStartup = False)
	Local $iColumnCount = _GUICtrlListView_GetColumnCount($hList)
	Local $Columns = IniReadSection($sINI_History, $sSection)

	If Not $bStartup Then
		For $i = 1 To $iColumnCount
			_GUICtrlListView_DeleteColumn($hList, 1)
		Next
	Else
		_GUICtrlListView_SetColumnWidth($hList, 0, Int(IniRead($sINI_History, $sSection, 'File', 350)))
	EndIf

	For $i = 1 To 5
		If Int($Columns[$i][1]) > 0 Then _GUICtrlListView_AddColumn($hList, $Columns[$i][0], $Columns[$i][1])
	Next

	If $hList = $hFTP_List Then
		_FtpRefresh()
	Else
		_LocalGo($gsLocalCurrent);refresh
	EndIf
EndFunc   ;==>_Columns
Func _SaveColumns($hList, $sSection)
	Local $i, $iCount, $aColunm

	$iCount = _GUICtrlListView_GetColumnCount($hList)

	For $i = 0 To $iCount - 1
		$aColunm = _GUICtrlListView_GetColumn($hList, $i)
		IniWrite($sINI_History, $sSection, $aColunm[5], $aColunm[4])
	Next
EndFunc   ;==>_SaveColumns
#EndRegion Column Functions..............................................
#Region GUI Notification Functions....................................
Func WM_NOTIFY($hWnd, $iMsg, $iwParam, $ilParam)
	Local $tNMHDR = DllStructCreate($tagNMHDR, $ilParam)
	Local $hWndFrom = HWnd(DllStructGetData($tNMHDR, "hWndFrom"))
	Local $iCode = DllStructGetData($tNMHDR, "Code")

	Switch $iCode
;~ 		Case $LVN_COLUMNCLICK
;~ 			Local $tInfo = DllStructCreate($tagNMLISTVIEW, $ilParam)
;~ 			Local $subitem = DllStructGetData($tInfo, "SubItem")
;~ 			_GUICtrlListView_SortItems($hWndFrom, $subitem)
;~ 			Return $__LISTVIEWCONSTANT_GUI_RUNDEFMSG
		Case $LVN_KEYDOWN ; A key has been pressed
			Local $tInfo = DllStructCreate($tagNMLVKEYDOWN, $ilParam)
			Switch DllStructGetData($tInfo, "VKey")
				Case 46;22216750 ;Delete Key
					Switch $hWndFrom
						Case $hLocal_List
							_LocalDelete()
						Case $hFTP_List
							If $gbFTP_Connected Then _FTP_Delete()
						Case $hQueue_list
							_Queue_Delete_items()
					EndSwitch
				Case 8;917512;Backspace key
					Switch $hWndFrom
						Case $hLocal_List
							_LocalBack()
						Case $hFTP_List
							If $gbFTP_Connected Then _FTPBack()
					EndSwitch
				Case 113; F2 Key
					Local $iTotalSelected = _GUICtrlListView_GetSelectedCount($hWndFrom)
					If $iTotalSelected <> 1 Then Return $GUI_RUNDEFMSG
					Switch $hWndFrom
						Case $hLocal_List
							If $gsLocalCurrent = 'My Computer' Then Return $GUI_RUNDEFMSG
							_Rename($hLocal_List)
						Case $hFTP_List
							If Not $gbFTP_Connected Or _FTP_DirGetCurrent($ghFTPConnect) = '/' Then Return $GUI_RUNDEFMSG
							_Rename($hFTP_List)
					EndSwitch
;~ 					ConsoleWrite(DllStructGetData($tInfo, "VKey") & @CRLF)
			EndSwitch
		Case $NM_DBLCLK ; Sent by a list-view control when the user double-clicks an item with the left mouse button
			Local $tInfo = DllStructCreate($tagNMITEMACTIVATE, $ilParam)
			Switch $hWndFrom
				Case $hLocal_List
					_LocalDirSwitch(DllStructGetData($tInfo, "Index"))
				Case $hFTP_List
					_FTPDirSwitch(DllStructGetData($tInfo, "Index"))
			EndSwitch
		Case $NM_RCLICK
			Switch $hWndFrom
				Case $hQueue_list
					_QueueListView_RClick()
				Case $hLocal_List
					_LocalListView_RClick()
				Case $hFTP_List
					_FTPListView_RClick()
				Case $hFTP_List_Header
					_RClick_Attributes($hFTP_List, 'FTPColumns')
				Case $hLocal_List_Header
					_RClick_Attributes($hLocal_List, 'LocalColumns')
			EndSwitch
;~ 		Case $NM_KILLFOCUS
;~ 		Case $NM_SETFOCUS
	EndSwitch
	Return $GUI_RUNDEFMSG
EndFunc   ;==>WM_NOTIFY
Func WM_COMMAND($hWnd, $iMsg, $iwParam, $hWndFrom)
	#forceref $hWnd, $iMsg
	Local $iIDFrom, $iCode;, $hWndEdit
	$iIDFrom = _WinAPI_LoWord($iwParam)
	$iCode = _WinAPI_HiWord($iwParam)
	Switch $hWndFrom
		Case $hFTP_Combo
			Switch $iCode
				Case $CBN_KILLFOCUS ; Sent when a combo box loses the keyboard focus
					AdlibUnRegister('_ComboFTP_Monitor_EnterKey')
				Case $CBN_SELCHANGE ; Sent when the user changes the current selection in the list box of a combo box
					_FTPGo(GUICtrlRead($FTP_Combo))
				Case $CBN_SETFOCUS ; Sent when a combo box receives the keyboard focus
					AdlibRegister('_ComboFTP_Monitor_EnterKey', 75)
			EndSwitch
		Case $hLocal_Combo
			Switch $iCode
				Case $CBN_KILLFOCUS ; Sent when a combo box loses the keyboard focus
					AdlibUnRegister('_ComboLocal_Monitor_EnterKey')
				Case $CBN_SELCHANGE ; Sent when the user changes the current selection in the list box of a combo box
					_Push_History($gsLocalCurrent, $gaLocalHistory)
					_LocalGo(GUICtrlRead($Local_Combo))
				Case $CBN_SETFOCUS ; Sent when a combo box receives the keyboard focus
					AdlibRegister('_ComboLocal_Monitor_EnterKey', 75)
			EndSwitch
		Case $hinIP
			If $iCode = $CBN_SELCHANGE Then; Sent when the user changes the current selection in the list box of a combo box
				Local $sIPRead = GUICtrlRead($inIP)
				Local $Decrypt_Pass = IniRead($sINI_History, $sIPRead, 'Pass', '')
				If $Decrypt_Pass <> '' Then $Decrypt_Pass = _StringEncrypt(0, $Decrypt_Pass, 'autoitrocks')
				GUICtrlSetData($inPass, $Decrypt_Pass)
				GUICtrlSetData($inUser, IniRead($sINI_History, $sIPRead, 'User', ''))
				GUICtrlSetData($inPort, IniRead($sINI_History, $sIPRead, 'Port', ''))
;~ 				ConsoleWrite($hWndFrom & @CRLF & $iCode & @CRLF)
			EndIf
	EndSwitch
	Return $GUI_RUNDEFMSG
EndFunc   ;==>WM_COMMAND
Func WM_SIZE($hWnd, $iMsg, $iwParam, $ilParam)
	$gl_iGUIWidth = _WinAPI_LoWord($ilParam)
	;$iHeight = _WinAPI_HiWord($ilParam)
	_GUICtrlStatusBar_Resize($StatusBar)
	Return $GUI_RUNDEFMSG
EndFunc   ;==>WM_SIZE
#EndRegion GUI Notification Functions....................................
#Region Right Click Menues............................................
Func _FTPListView_RClick()
	Local Enum $idQueue = 1000, $idTransfer, $idDelete, $idRename, $idRefresh, $idFolder, $idAbort, $idConnect
	Local $hMenu = _GUICtrlMenu_CreatePopup()
	Local $iTotalSelected = _GUICtrlListView_GetSelectedCount($hFTP_List)

	If $gbFTP_Connected Then
		If $FTP_State <> $giIdle Then _GUICtrlMenu_AddMenuItem($hMenu, "ABORT Transfer", $idAbort)
		If $iTotalSelected Then
			If $gsLocalCurrent <> 'My Computer' Then _GUICtrlMenu_AddMenuItem($hMenu, "Queue", $idQueue)
			If $FTP_State = $giIdle And $gsLocalCurrent <> 'My Computer' Then _GUICtrlMenu_AddMenuItem($hMenu, "Transfer", $idTransfer)
			_GUICtrlMenu_AddMenuItem($hMenu, "Delete", $idDelete)
		EndIf
		If $iTotalSelected = 1 Then _GUICtrlMenu_AddMenuItem($hMenu, "Rename", $idRename)
		_GUICtrlMenu_AddMenuItem($hMenu, "Refresh", $idRefresh)
		_GUICtrlMenu_AddMenuItem($hMenu, "Create Folder", $idFolder)
	Else
		_GUICtrlMenu_AddMenuItem($hMenu, "Connect", $idConnect)
	EndIf

	Switch _GUICtrlMenu_TrackPopupMenu($hMenu, $hFTP_List, -1, -1, 1, 1, 2)
		Case $idConnect
			_FTP_Connect_GUI()
		Case $idQueue
			_QueueItems($hFTP_List)
		Case $idTransfer
			_QueueItems($hFTP_List)
			If (UBound($gaQueue) - 1) > 0 Then
				_Statusbar(3);Transfer function will change status bar back when finished
				$Transfer_Register = _Timer_SetTimer($GUI, 500, "_Transfer")
			EndIf
		Case $idRename
			_Rename($hFTP_List)
		Case $idRefresh
			_FtpRefresh($INTERNET_FLAG_RELOAD)
		Case $idDelete
			_FTP_Delete()
		Case $idFolder
			_FTP_DirCreate($ghFTPConnect, InputBox('Create New Directory', 'Enter Directory Name', '', " M", Default, 130))
			_FtpRefresh($INTERNET_FLAG_RELOAD)
		Case $idAbort
			IniWrite($sINI_History, 'Abort', 'Abort', 1)
		Case Else
	EndSwitch
	_GUICtrlMenu_DestroyMenu($hMenu)
EndFunc   ;==>_FTPListView_RClick
Func _LocalListView_RClick()
	Local Enum $idQueue = 1000, $idTransfer, $idDelete, $idRefresh, $idFolder, $idRename, $idAbort, $idConnect
	Local $hMenu = _GUICtrlMenu_CreatePopup()
	Local $iTotalSelected = _GUICtrlListView_GetSelectedCount($hLocal_List)

	If $gbFTP_Connected Then
		If $FTP_State <> $giIdle Then _GUICtrlMenu_AddMenuItem($hMenu, "ABORT Transfer", $idAbort)
		If $iTotalSelected Then
			If $FTP_State = $giIdle Then _GUICtrlMenu_AddMenuItem($hMenu, "Transfer", $idTransfer)
			_GUICtrlMenu_AddMenuItem($hMenu, "Queue", $idQueue)
		EndIf
	Else
		_GUICtrlMenu_AddMenuItem($hMenu, "Connect", $idConnect)
	EndIf
	If $iTotalSelected Then _GUICtrlMenu_AddMenuItem($hMenu, "Delete", $idDelete)
	If $iTotalSelected = 1 Then _GUICtrlMenu_AddMenuItem($hMenu, "Rename", $idRename)
	_GUICtrlMenu_AddMenuItem($hMenu, "Refresh", $idRefresh)
	If $gsLocalCurrent <> 'My Computer' Then _GUICtrlMenu_AddMenuItem($hMenu, "Create Folder", $idFolder)

	Switch _GUICtrlMenu_TrackPopupMenu($hMenu, $hLocal_List, -1, -1, 1, 1, 2)
		Case $idQueue
			_QueueItems($hLocal_List)
		Case $idTransfer
			_QueueItems($hLocal_List)
			If (UBound($gaQueue) - 1) > 0 Then
				_Statusbar(3);Transfer function will change status bar back when finished
				$Transfer_Register = _Timer_SetTimer($GUI, 500, "_Transfer")
			EndIf
		Case $idFolder
			_Localcreatefolder()
		Case $idDelete
			_LocalDelete()
		Case $idRefresh
			If $gsLocalCurrent = 'My Computer' Then
				_MyComputer()
			Else
				_LocalGo($gsLocalCurrent)
			EndIf
		Case $idRename
			_Rename($hLocal_List)
		Case $idAbort
			IniWrite($sINI_History, 'Abort', 'Abort', 1)
	EndSwitch
	_GUICtrlMenu_DestroyMenu($hMenu)
EndFunc   ;==>_LocalListView_RClick
Func _QueueListView_RClick()
	Local Enum $idTransferQueue = 4564, $idClear, $idDelete, $idAbort; $idBack;,$idFolder,$idRename
	Local $hMenu = _GUICtrlMenu_CreatePopup()
	Local $iTotalSelected = _GUICtrlListView_GetSelectedCount($hQueue_list)
	Local $iCount = _GUICtrlListView_GetItemCount($hQueue_list)

	If $gbFTP_Connected Then
		If $FTP_State = $giIdle And $iCount Then _GUICtrlMenu_AddMenuItem($hMenu, "Transfter Queue", $idTransferQueue)
		If $FTP_State <> $giIdle Then _GUICtrlMenu_AddMenuItem($hMenu, "ABORT Transfer", $idAbort)
	EndIf
	If $iCount Then _GUICtrlMenu_AddMenuItem($hMenu, "Clear Queue", $idClear)
	If $iTotalSelected Then _GUICtrlMenu_AddMenuItem($hMenu, "Delete", $idDelete)

	Switch _GUICtrlMenu_TrackPopupMenu($hMenu, $hLocal_List, -1, -1, 1, 1, 2)
		Case $idTransferQueue
			_Statusbar(3)
			$Transfer_Register = _Timer_SetTimer($GUI, 500, "_Transfer")
		Case $idClear
			Global $gaQueue[1]
			_GUICtrlListView_DeleteAllItems($hQueue_list)
		Case $idDelete
			_Queue_Delete_items()
		Case $idAbort
			IniWrite($sINI_History, 'Abort', 'Abort', 1)
	EndSwitch
	_GUICtrlMenu_DestroyMenu($hMenu)
EndFunc   ;==>_QueueListView_RClick
Func _RClick_Attributes($hList, $sSection)
	Local Enum $iSize = 1, $iModified, $iAttrubute, $iCreation, $iAccess
	Local $i, $bChecked, $sKey, $hMenu = _GUICtrlMenu_CreatePopup(2)
	Local $Columns = IniReadSection($sINI_History, $sSection)

	_GUICtrlMenu_AddMenuItem($hMenu, "Size", $iSize)
	_GUICtrlMenu_AddMenuItem($hMenu, "Modifed", $iModified)
	_GUICtrlMenu_AddMenuItem($hMenu, "Attrubutes", $iAttrubute)
	_GUICtrlMenu_AddMenuItem($hMenu, "Creation", $iCreation)
	_GUICtrlMenu_AddMenuItem($hMenu, "Accessed", $iAccess)

	For $i = $iSize To $iAccess
		$bChecked = Int($Columns[$i][1]) <> 0
		_GUICtrlMenu_SetItemChecked($hMenu, $i, $bChecked, False)
	Next

	Local $mitem = _GUICtrlMenu_TrackPopupMenu($hMenu, $hList, -1, -1, 1, 1, 2)
	_GUICtrlMenu_DestroyMenu($hMenu)
	Switch $mitem
		Case $iSize
			$sKey = 'Size'
		Case $iModified
			$sKey = 'Modified'
		Case $iAttrubute
			$sKey = 'Attributes'
		Case $iCreation
			$sKey = 'Creation'
		Case $iAccess
			$sKey = 'Accessed'
		Case Else
			Return
	EndSwitch

	_SaveColumns($hList, $sSection)

	If Int($Columns[$mitem][1]) > 0 Then
		IniWrite($sINI_History, $sSection, $sKey, 0)
	Else
		IniWrite($sINI_History, $sSection, $sKey, 75)
	EndIf

	_Columns($hList, $sSection)

EndFunc   ;==>_RClick_Attributes
Func _Queue_Delete_items()
	If MsgBox(36, 'Confirm Remove Items', 'Are you sure you want remove selected items from queue?') = 7 Then Return
	Local $aSelectedQueue = _GUICtrlListView_GetSelectedIndices($hQueue_list, True)
	For $i = 1 To $aSelectedQueue[0]
		$gaQueue[$aSelectedQueue[$i] + 1] = 0
	Next
	$i = 1
	Do
		If Not $gaQueue[$i] Then
			_ArrayDelete($gaQueue, $i)
			$i -= 1
		EndIf
		$i += 1
	Until $i = UBound($gaQueue)
	_GUICtrlListView_DeleteItemsSelected($hQueue_list)
EndFunc   ;==>_Queue_Delete_items
#EndRegion Right Click Menues............................................

#Region Combobox Address Functions....................................
Func _ComboHistoryAdd(ByRef $gui_combo, ByRef $sCombo, $item)
	Local $split = StringSplit($sCombo, '|')
	_ArraySearch($split, $item)
	If Not @error Then; item is already in list
		GUICtrlSetData($gui_combo, $item, $item)
		Return
	EndIf
	If $split[0] > 9 Then
		_ArrayDelete($split, 1)
		$sCombo = _ArrayToString($split, '|', 1) & '|' & $item
		GUICtrlSetData($gui_combo, '', $item)
		GUICtrlSetData($gui_combo, $sCombo, $item)
	Else
		$sCombo &= '|' & $item
		GUICtrlSetData($gui_combo, $item, $item)
	EndIf
EndFunc   ;==>_ComboHistoryAdd
Func _ComboFTP_Monitor_EnterKey()
	If _IsPressed("0D", $User32) Then _FTPGo(GUICtrlRead($FTP_Combo))
EndFunc   ;==>_ComboFTP_Monitor_EnterKey
Func _ComboLocal_Monitor_EnterKey()
	If _IsPressed("0D", $User32) Then
		Local $combo = GUICtrlRead($Local_Combo)
		If FileExists($combo) Then
			_Push_History($gsLocalCurrent, $gaLocalHistory)
			_LocalGo($combo)
		EndIf
	EndIf
EndFunc   ;==>_ComboLocal_Monitor_EnterKey
#EndRegion Combobox Address Functions....................................

#Region Statusbar Functions...........................................
Func _Statusbar($state)
	Switch $state
		Case 1;startup
			Local $StatusBar_PartsWidth[4] = [200, ($gl_iGUIWidth / 2), ($gl_iGUIWidth - 80), -1]
			Local $StatusBar_PartsText[4] = ["Not Connected", "", "", "CPU: 0.0%"]
			$StatusBar = _GUICtrlStatusBar_Create($GUI, $StatusBar_PartsWidth, $StatusBar_PartsText)
			_GUICtrlStatusBar_SetMinHeight($StatusBar, 21)
		Case 2;connected
			_GUICtrlStatusBar_Destroy($StatusBar)
			Local $StatusBar_PartsWidth[4] = [200, ($gl_iGUIWidth / 2), ($gl_iGUIWidth - 80), -1]
			Local $StatusBar_PartsText[4] = ['Connected IP : ' & $gsServer_IP, $gsServer_Name, "Idle (00:00)", $CPU]
			$StatusBar = _GUICtrlStatusBar_Create($GUI, $StatusBar_PartsWidth, $StatusBar_PartsText);Connection, idle, messeges?
			_GUICtrlStatusBar_SetMinHeight($StatusBar, 21)
			$gtIdle_Clock = TimerInit()
;~ 			$IdleClock_Register = _Timer_SetTimer($GUI, 1000, "_IdleClock_Update") ; create timer
			$IdleClock_Register = True
		Case 3;Transfer
			Local $FileNameLen
;~ 			_Timer_KillTimer($GUI, $IdleClock_Register)
			$IdleClock_Register = False
			_GUICtrlStatusBar_Destroy($StatusBar)
			If ($gl_iGUIWidth / 2) > 480 Then
				$FileNameLen = ($gl_iGUIWidth / 2)
			Else
				$FileNameLen = $gl_iGUIWidth - 580 ; ;[75, ?,  80,  80,  80, 140, 200]
			EndIf
			Local $StatusBar_PartsWidth[7] = [75, $FileNameLen, $FileNameLen + 80, $FileNameLen + 160, $FileNameLen + 240, $FileNameLen + 380, -1]
			Local $StatusBar_PartsText[7] = ["Idle:", 'FileName', $CPU, 'Time (00:00)', '', '', '']
			$StatusBar = _GUICtrlStatusBar_Create($GUI, $StatusBar_PartsWidth, $StatusBar_PartsText);Uploading or Downloading, filename, speed, Estimated Time
			_GUICtrlStatusBar_SetMinHeight($StatusBar, 21)
			$g_ProgressBar = GUICtrlCreateProgress(0, 0, -1, -1, $PBS_SMOOTH)
			_GUICtrlStatusBar_EmbedControl($StatusBar, 6, GUICtrlGetHandle($g_ProgressBar), 4)
	EndSwitch
EndFunc   ;==>_Statusbar
Func _CPU_IdleClock_Update($hWnd, $Msg, $iIDTimer, $dwTime)
	Static $StartTimes[2], $EndTimes[2], $bFirstRun = True
	Static $CPU_Kernel = DllStructCreate($tagFileTime), $CPU_User = DllStructCreate($tagFileTime), $CPU_Idle = DllStructCreate($tagFileTime)
	Static $pCPU_Kernel = DllStructGetPtr($CPU_Kernel), $pCPU_User = DllStructGetPtr($CPU_User), $pCPU_Idle = DllStructGetPtr($CPU_Idle)

	DllCall($Kernel32, "int", "GetSystemTimes", "ptr", $pCPU_Idle, "ptr", $pCPU_Kernel, "ptr", $pCPU_User)
	$EndTimes[0] = (DllStructGetData($CPU_Kernel, 1) + DllStructGetData($CPU_User, 1)); Kerneltime + UserTime
	$EndTimes[1] = DllStructGetData($CPU_Idle, 1);IdleTime

	If $bFirstRun Then
		$StartTimes = $EndTimes
		$bFirstRun = False
		Return
	EndIf

	Local $Idle_Time = $EndTimes[1] - $StartTimes[1]
	If $Idle_Time > 0 Then ; Every once in a while idle time will be negative because the 32bit value gets to high and goes back to zero causing starttime to be bigger then endtime
		Local $Total_Time = $EndTimes[0] - $StartTimes[0]
		Local $CPU_Percent = (($Total_Time - $Idle_Time) / $Total_Time) * 100
		$CPU_Percent = StringFormat('CPU: %.1f%%', $CPU_Percent)
		If $CPU <> $CPU_Percent Then
			If $FTP_State = $giIdle Then
				_GUICtrlStatusBar_SetText($StatusBar, $CPU_Percent, 3)
			Else
				_GUICtrlStatusBar_SetText($StatusBar, $CPU_Percent, 2)
			EndIf
			$CPU = $CPU_Percent
		EndIf
	EndIf
	$StartTimes = $EndTimes

	If $IdleClock_Register Then
		Local $Hour, $Mins, $Secs
		_TicksToTime(Int(TimerDiff($gtIdle_Clock)), $Hour, $Mins, $Secs)
		If Not $Hour Then
			_GUICtrlStatusBar_SetText($StatusBar, StringFormat("Idle (%02i:%02i)", $Mins, $Secs), 2)
		Else
			_GUICtrlStatusBar_SetText($StatusBar, StringFormat("Idle (%02i:%02i:%02i)", $Hour, $Mins, $Secs), 2)
		EndIf
	EndIf

EndFunc   ;==>_CPU_IdleClock_Update
#EndRegion Statusbar Functions...........................................
#Region History Stack Functions.......................................
Func _Push_History($item, ByRef $aHistory)
	If $aHistory[0] = $item Then Return
	For $i = 19 To 1 Step -1
		$aHistory[$i] = $aHistory[$i - 1]
	Next
	$aHistory[0] = $item
EndFunc   ;==>_Push_History
Func _Pop_History(ByRef $aHistory)
	Local $pop = $aHistory[0]
	For $i = 0 To 18
		$aHistory[$i] = $aHistory[$i + 1]
	Next
	$aHistory[19] = ''
	Return $pop
EndFunc   ;==>_Pop_History
#EndRegion History Stack Functions.......................................
#Region Other Functions...............................................
Func _ExitTime()
	_SaveColumns($hFTP_List, 'FTPColumns')
	_SaveColumns($hLocal_List, 'LocalColumns')
	_GUICtrlRichEdit_Destroy($Status_List)
	IniWrite($sINI_History, "Abort", "Abort", 0)
	_Timer_KillAllTimers($GUI)
	DllClose($Kernel32)
	DllClose($User32)
	DllClose($Shell32)
	If StringRight(@ScriptFullPath, 3) = 'exe' Then FileDelete(@ScriptDir & '\FTP Worker.a3x')
EndFunc   ;==>_ExitTime
Func _bytes($iBytes)
	Switch $iBytes
		Case 0 To 1023
			Return $iBytes & " Bytes"
		Case 1024 To 1048575
			Return Round($iBytes / 1024, 2) & " KB"
		Case 1048576 To 1073741823
			Return Round($iBytes / 1048576, 2) & " MB"
		Case Else
			Return Round($iBytes / 1073741824, 2) & " GB"
	EndSwitch
EndFunc   ;==>_Bytes
Func _ArraytoConsole($array, $name = '')
	Local $i, $string = $name & @CRLF
	For $i = 0 To UBound($array) - 1
		$string &= '[' & $i & ']' & $array[$i] & @CRLF
	Next
	ConsoleWrite($string)
;~ 	MsgBox(0, 'Array to Console', 'OK to continue?')
EndFunc   ;==>_ArraytoConsole
Func _RichEdit_Append($sMsg, $cColor)
	_CheckLen()
	_GUICtrlRichEdit_AppendText($Status_List, @CRLF & $sMsg)
	_GUICtrlRichEdit_SetSel($Status_List, _GUICtrlRichEdit_GetFirstCharPosOnLine($Status_List), -1, True)
	_GUICtrlRichEdit_SetCharColor($Status_List, $cColor)
EndFunc   ;==>_RichEdit_Append
Func _CheckLen()
	Static $iCount
	$iCount += 1
	If $iCount >= 50 Then
		If _GUICtrlRichEdit_GetTextLength($Status_List, False, True) > 90000 Then
			_GUICtrlRichEdit_SetSel($Status_List, 0, 30000)
			_GUICtrlRichEdit_ReplaceText($Status_List, "")
		EndIf
		$iCount = 0
	EndIf
EndFunc   ;==>_CheckLen
Func _Resize_Rich_Edit()
	;pretty cheap, but it works:)
	Local $FTP_POS = ControlGetPos($gl_sTitle, '', $FTP_List)
	Local $Queue_POS = ControlGetPos($gl_sTitle, '', $Queue_List)
	_WinAPI_SetWindowPos($Status_List, 0, $FTP_POS[0], $Queue_POS[1], $Queue_POS[2], $Queue_POS[3], $SWP_SHOWWINDOW)
EndFunc   ;==>_Resize_Rich_Edit
Func _Speed($size, $millsec)
	Local $speed = $size / ($millsec / 1000)
	If $speed >= 1048576 Then
		Return Round($speed / 1048576, 2) & " mB/sec"
	Else
		Return Round($speed / 1024, 2) & " kB/sec"
	EndIf
EndFunc   ;==>_Speed
Func _Format_Time($iMillseconds)
	$iMillseconds = Int($iMillseconds)
	If $iMillseconds < 60000 Then Return Round($iMillseconds / 1000, 2)
	Local $Hour, $Mins, $Secs
	If $iMillseconds < 3600000 Then
		_TicksToTime($iMillseconds, $Hour, $Mins, $Secs)
		Return StringFormat("%02i:%02i", $Mins, $Secs)
	Else
		_TicksToTime($iMillseconds, $Hour, $Mins, $Secs)
		Return StringFormat("%02i:%02i:%02i", $Hour, $Mins, $Secs)
	EndIf
EndFunc   ;==>_Format_Time
Func _FileListToArray_mod($sPath, $sFilter = "*", $iFlag = 0)
	Local $hSearch, $sFile, $sFileList, $sFolderList, $sDelim = "|"
	$sPath = StringRegExpReplace($sPath, "[\\/]+\z", "") & "\" ; ensure single trailing backslash
	If Not FileExists($sPath) Then Return SetError(1, 1, "")
	If StringRegExp($sFilter, "[\\/:><\|]|(?s)\A\s*\z") Then Return SetError(2, 2, "")
	If Not ($iFlag = 0 Or $iFlag = 1 Or $iFlag = 2) Then Return SetError(3, 3, "")
	$hSearch = FileFindFirstFile($sPath & $sFilter)
	If @error Then Return SetError(4, 4, "")
	While 1
		$sFile = FileFindNextFile($hSearch)
		If @error Then ExitLoop
		If @extended Then
			$sFolderList &= $sDelim & $sFile
		Else
			$sFileList &= $sDelim & $sFile
		EndIf
	WEnd
	FileClose($hSearch)
	$sFileList = $sFolderList & $sFileList
	If Not $sFileList Then Return SetError(4, 4, "")
	Return StringSplit(StringTrimLeft($sFileList, 1), "|")
EndFunc   ;==>_FileListToArray_mod
Func _Rename($hHandle)
	Local $aSelected = _GUICtrlListView_GetSelectedIndices($hHandle, True)
	Local $sFileName = _GUICtrlListView_GetItemText($hHandle, $aSelected[1], 0)
	Local $sNewName = InputBox("Rename File", "Enter New File Name:", $sFileName, " M", Default, 130)
	If @error Then Return
	Switch $hHandle
		Case $hFTP_List
			_FTP_FileRename($ghFTPConnect, $sFileName, $sNewName)
			_FtpRefresh($INTERNET_FLAG_RELOAD)
		Case $hLocal_List
			FileMove($gsLocalCurrent & '\' & $sFileName, $gsLocalCurrent & '\' & $sNewName)
			_LocalGo($gsLocalCurrent);refresh
	EndSwitch
EndFunc   ;==>_Rename
Func _Check_INI_File()
	If Not FileExists($sINI_History) Then
		_FileCreate($sINI_History)
		IniWrite($sINI_History, "Abort", "Abort", 0)
		Local $aLast[4][2] = [["User", ''],["Pass", ''],["Port", '21'],["IP", '']]
		IniWriteSection($sINI_History, 'Last', $aLast, 0)
		Local $aColumns[6][2] = [["Size", '75'],["Modified", '0'],["Attributes", '0'],["Creation", '0'],["Accessed", '0'],["File", '350']]
		IniWriteSection($sINI_History, 'FTPColumns', $aColumns, 0)
		IniWriteSection($sINI_History, 'LocalColumns', $aColumns, 0)
	EndIf
EndFunc   ;==>_Check_INI_File
Func _ReduceMemory()
	If $FTP_State = $giIdle Then
		Local $call = DllCall($PSAPI, 'int', 'EmptyWorkingSet', 'long', -1)
		If @error Then ConsoleWrite('error code = ' & @error & @CRLF)
	EndIf
EndFunc   ;==>_ReduceMemory
#EndRegion Other Functions...............................................
#Region Functions not written by me...................................
;Prog@ndy Icon Functions...................................
Func _GUIImageList_GetSystemImageList($bLargeIcons = False)
	Local $SHGFI_USEFILEATTRIBUTES = 0x10, $SHGFI_SYSICONINDEX = 0x4000, $SHGFI_SMALLICON = 0x1;, $SHGFI_LARGEICON = 0x0;,$FILE_ATTRIBUTE_NORMAL = 0x80
	Local $FileInfo = DllStructCreate("dword hIcon; int iIcon; DWORD dwAttributes; CHAR szDisplayName[255]; CHAR szTypeName[80];")
	Local $dwFlags = BitOR($SHGFI_USEFILEATTRIBUTES, $SHGFI_SYSICONINDEX)
	If Not ($bLargeIcons) Then $dwFlags = BitOR($dwFlags, $SHGFI_SMALLICON)
	Local $hIml = _WinAPI_SHGetFileInfo(".txt", $FILE_ATTRIBUTE_NORMAL, DllStructGetPtr($FileInfo), DllStructGetSize($FileInfo), $dwFlags)
	Return $hIml
EndFunc   ;==>_GUIImageList_GetSystemImageList
Func _GUIImageList_GetFileIconIndex($sFileSpec, $bLargeIcons = False, $bForceLoadFromDisk = False);modified
	Static $FileInfo = DllStructCreate("dword hIcon; int iIcon; DWORD dwAttributes; CHAR szDisplayName[255]; CHAR szTypeName[80];")
	Local $dwFlags = BitOR(0x4000, 0x1)
	If Not $bForceLoadFromDisk Then $dwFlags = BitOR($dwFlags, 0x10)
	DllCall($Shell32, "DWORD*", "SHGetFileInfo", "str", $sFileSpec, "DWORD", $FILE_ATTRIBUTE_NORMAL, "ptr", DllStructGetPtr($FileInfo), _
			"UINT", DllStructGetSize($FileInfo), "UINT", $dwFlags)
	If @error Then Return SetError(1, 0, -1)
	Return DllStructGetData($FileInfo, "iIcon")
EndFunc   ;==>_GUIImageList_GetFileIconIndex
Func _WinAPI_SHGetFileInfo($pszPath, $dwFileAttributes, $psfi, $cbFileInfo, $uFlags)
	Local $return = DllCall($Shell32, "DWORD*", "SHGetFileInfo", "str", $pszPath, "DWORD", $dwFileAttributes, "ptr", $psfi, "UINT", $cbFileInfo, "UINT", $uFlags)
	If @error Then Return SetError(@error, 0, 0)
	Return $return[0]
EndFunc   ;==>_WinAPI_SHGetFileInfo

; #FUNCTION# ===============================
; Author(s):		Yashied
;====================================================================================================================================
Func _InternetSetOption($hInternet, $lOption, $lValue)
	Local $Ret, $Back, $tBuffer
	Switch $lOption
		Case 2, 3, 5, 6, 12, 13
			If IsInt($lValue) Then
				$tBuffer = DllStructCreate('int')
			EndIf
		Case 28, 29, 41
			If IsString($lValue) Then
				$tBuffer = DllStructCreate('char[' & StringLen($lValue) + 1 & ']')
			EndIf
		Case 38
			If IsDllStruct($lValue) Then
				$tBuffer = DllStructCreate($tagINTERNET_PROXY_INFO, DllStructGetPtr($lValue))
			EndIf
		Case 45
			If IsPtr($lValue) Then
				$tBuffer = DllStructCreate('ptr')
			EndIf
		Case Else
			Return SetError(1, 0, 0)
	EndSwitch
	If Not ($lOption = 38) Then
		DllStructSetData($tBuffer, 1, $lValue)
	EndIf
	$Back = _InternetGetOption($hInternet, $lOption)
	If (@error) Then
		Return SetError(1, @extended, 0)
	EndIf
	$Ret = DllCall('wininet.dll', 'int', 'InternetSetOption', 'hwnd', $hInternet, 'dword', $lOption, 'ptr', DllStructGetPtr($tBuffer), 'dword', DllStructGetSize($tBuffer))
	If (@error) Or ($Ret[0] = 0) Then
		Return SetError(1, _WinAPI_GetLastError(), 0)
	EndIf
	Return SetError(0, 0, $Back)
EndFunc   ;==>_InternetSetOption
Func _InternetGetOption($hInternet, $lOption)
	Local $Ret, $tBuffer
	Switch $lOption
		Case 2, 3, 5, 6, 12, 13
			$tBuffer = DllStructCreate('int')
		Case 28, 29, 41
			$tBuffer = DllStructCreate('char[1024]')
		Case 38
			$tBuffer = DllStructCreate($tagINTERNET_PROXY_INFO)
		Case 45
			$tBuffer = DllStructCreate('ptr')
		Case Else
			Return SetError(1, 0, 0)
	EndSwitch
	$Ret = DllCall('wininet.dll', 'int', 'InternetQueryOption', 'hwnd', $hInternet, 'dword', $lOption, 'ptr', DllStructGetPtr($tBuffer), 'dword*', DllStructGetSize($tBuffer))
	If (@error) Or ($Ret[0] = 0) Then
		Return SetError(1, _WinAPI_GetLastError(), 0)
	EndIf
	Switch $lOption
		Case 38
			Return SetError(0, 0, $tBuffer)
		Case Else
			Return SetError(0, 0, DllStructGetData($tBuffer, 1))
	EndSwitch
EndFunc   ;==>_InternetGetOption
Func _About($Title, $MainLabel, $CopyRLabel, $VerLabel, $NameURL1, $URL1, $NameURL2, $URL2, $NameURL3, $URL3, $IconFile = "", $LinkColor = 0x0000FF, $BkColor = 0xFFFFFF, $Left = -1, $Top = -1, $Style = -1, $ExStyle = -1, $Parent = 0)
;~     Local $OldEventOpt = Opt("GUIOnEventMode", 0)
	Local $GUI_About, $LinkTop = 120, $Msg, $CurIsOnCtrlArr[1]
	Local $LinkVisitedColor[4] = [3, $LinkColor, $LinkColor, $LinkColor], $LinkLabel[4]
	WinSetState($Parent, "", @SW_DISABLE)

	If $ExStyle = -1 Then $ExStyle = ""
	$GUI_About = GUICreate($Title, 320, 240, $Left, $Top, $Style, 0x00000080 + $ExStyle, $Parent)
	GUISwitch($GUI_About)
	GUISetBkColor($BkColor)
	GUICtrlCreateLabel($MainLabel, 40, 20, 280, 25, 1)
	GUICtrlSetFont(-1, 16)
	GUICtrlCreateIcon($IconFile, 0, 10, 20)
	GUICtrlCreateGraphic(5, 75, 310, 3, $SS_ETCHEDFRAME)
	For $i = 1 To 3
		$LinkLabel[$i] = GUICtrlCreateLabel(Eval("NameURL" & $i), 150, $LinkTop, 145, 15, 1)
		GUICtrlSetCursor(-1, 0)
		GUICtrlSetColor(-1, $LinkColor)
		GUICtrlSetFont(-1, 9, 400, 0)
		$LinkTop += 30
	Next
	GUICtrlCreateLabel("Program version: " & @LF & $VerLabel, 10, 130, 150, 35, 1)
	GUICtrlSetFont(-1, 10, 600, 0, "Tahoma")
	GUICtrlCreateLabel($CopyRLabel, 0, 220, 320, -1, 1)
	GUISetState(@SW_SHOW, $GUI_About)

	While 1
		$Msg = GUIGetMsg()
		If $Msg = -3 Then ExitLoop
		For $i = 1 To 3
			If $Msg = $LinkLabel[$i] Then
				$LinkVisitedColor[$i] = 0xAC00A9
				GUICtrlSetColor($LinkLabel[$i], $LinkVisitedColor[$i])
				ShellExecute(Eval("URL" & $i))
			EndIf
		Next
		If WinActive($GUI) Then
			For $i = 1 To 3
				ControlHover($GUI_About, $LinkLabel[$i], $i, $CurIsOnCtrlArr, 0xFF0000, $LinkVisitedColor[$i])
			Next
		EndIf
	WEnd
	WinSetState($Parent, "", @SW_ENABLE)
	GUIDelete($GUI_About)
	GUISwitch($GUI)
;~     Opt("GUIOnEventMode", $OldEventOpt)
;~     Opt("RunErrorsFatal", $OldRunErrOpt)
EndFunc   ;==>_About
Func ControlHover($hWnd, $CtrlID, $CtrlNum, ByRef $CurIsOnCtrlArr, $HoverColor = 0xFF0000, $LinkColor = 0x0000FF)
	Local $CursorCtrl = GUIGetCursorInfo($hWnd)
	ReDim $CurIsOnCtrlArr[UBound($CurIsOnCtrlArr) + 1]
	If $CursorCtrl[4] = $CtrlID And $CurIsOnCtrlArr[$CtrlNum] = 1 Then
		GUICtrlSetFont($CtrlID, 9, 400, 6)
		GUICtrlSetColor($CtrlID, $HoverColor)
		$CurIsOnCtrlArr[$CtrlNum] = 0
	ElseIf $CursorCtrl[4] <> $CtrlID And $CurIsOnCtrlArr[$CtrlNum] = 0 Then
		GUICtrlSetFont($CtrlID, 9, 400, 0)
		GUICtrlSetColor($CtrlID, $LinkColor)
		$CurIsOnCtrlArr[$CtrlNum] = 1
	EndIf
EndFunc   ;==>ControlHover
#EndRegion Functions not written by me...................................
