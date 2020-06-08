#NoTrayIcon
#Region ;**** Directives created by AutoIt3Wrapper_GUI ****
#AutoIt3Wrapper_outfile_type=a3x
#AutoIt3Wrapper_Compression=4
#AutoIt3Wrapper_Run_Obfuscator=y
#Obfuscator_Parameters=/SOI /sci 1
#EndRegion ;**** Directives created by AutoIt3Wrapper_GUI ****
#Obfuscator_Ignore_Funcs=_Receiver, _FTP_StatusHandler
;#Obfuscator_Ignore_Funcs=_Receiver, _FTP_DirDownload, _FTP_DownloadFile, _FTP_DirUpload, _FTP_UploadFile, _ConnectFTP, _UpdateStatus, _FTP_StatusHandler, _Bytes_Display, _bytes
#include <Messages.au3>
#include <FTPEx.au3>
_Singleton("FTPworker", 0)
OnAutoItExitRegister('_Exit')

Global $PSAPI = DllOpen(@SystemDir & "\psapi.dll")
Global $Kernel32 = DllOpen('kernel32.dll')
Global Enum $iUploading, $iDownloading, $iIdle, $iFinished
Global $FTP_State = $iIdle, $bFTP_Connected = False
Global $CallBack, $hFTPOpen, $hFTPConnect
Global $Global_Bytes_Transfered, $Global_Total_Filesize = 0
Global $Speed_Timer, $UpdateTimer
Global Const $tagINTERNET_PROXY_INFO = 'dword AccessType;ptr Proxy;ptr ProxyBypass;'
Global Const $INTERNET_OPTION_RECEIVE_TIMEOUT = 6
Global $ABORT_Check = TimerInit(), $gAbortFileName
Global $Connection_Info, $sINI_History = @ScriptDir & '\History.ini'

_MsgRegister('Worker', '_Receiver')
If $PSAPI <> -1 Then AdlibRegister('_ReduceMemory', 60000)
_ReduceMemory()


While 1
	Sleep(3000)
	If Not _IsReceiver('Boss') Then Exit
;~ 	_DebugOut(DllStructGetData($aboutstruct, 'test'))
WEnd

Func _Receiver($msg)
	Local $aMsg = StringSplit($msg, ';', 2)

	If Not IsArray($aMsg) Then Return;should never happen

	Switch $aMsg[0]
		Case 1;Connect
			$Connection_Info = $aMsg
			_ConnectFTP($Connection_Info[1], $Connection_Info[2], $Connection_Info[3], $Connection_Info[4])
		Case 2;Disconnect
			_FTP_Close($hFTPOpen)
		Case 3;Exit
			Exit
		Case 4;upload file
			_FTP_DirSetCurrent($hFTPConnect, $aMsg[3])
			$FTP_State = $iUploading
			_MsgSend('Boss', '1;' & $iUploading)
			_FTP_UploadFile($aMsg[1] & $aMsg[2], $aMsg[3] & $aMsg[2])
			_MsgSend('Boss', '1;' & $iFinished)
			$FTP_State = $iIdle
		Case 5;Download File
			_FTP_DirSetCurrent($hFTPConnect, $aMsg[3])
			$FTP_State = $iDownloading
			_MsgSend('Boss', '1;' & $iDownloading)
			_FTP_DownloadFile($aMsg[1] & $aMsg[2], $aMsg[3] & $aMsg[2], $aMsg[4])
			_MsgSend('Boss', '1;' & $iFinished)
			$FTP_State = $iIdle
		Case 6; upload directory
			_MsgSend('Boss', '1;' & $iUploading)
			$FTP_State = $iUploading
			_FTP_DirUpload($aMsg[1], $aMsg[2])
			_MsgSend('Boss', '1;' & $iFinished)
			$FTP_State = $iIdle
		Case 7; download directory
			$FTP_State = $iDownloading
			_MsgSend('Boss', '1;' & $iDownloading)
			_FTP_DirDownload($aMsg[1], $aMsg[2], $aMsg[3])
			_MsgSend('Boss', '1;' & $iFinished)
			$FTP_State = $iIdle
	EndSwitch
;~ 	;_GUICtrlEdit_AppendText($Edit1, $msg & @CRLF)
EndFunc   ;==>_Receiver
Func _FTP_DirDownload($FTP_StartRoot, $FTP_DirName, $localRoot)
	Local $aFile, $hSearch, $sWorkingdir, $bFirst, $sLastFTPDir, $aFolderStack[2] = [1, $FTP_DirName]
	$sLastFTPDir = _FTP_DirGetCurrent($hFTPConnect)
	_FTP_DirSetCurrent($hFTPConnect, $FTP_StartRoot)
	If StringRight($FTP_StartRoot, 1) = '/' Then $FTP_StartRoot = StringTrimRight($FTP_StartRoot, 1)
	If Not FileExists($localRoot & '\' & $FTP_DirName) Then DirCreate($localRoot & '\' & $FTP_DirName)
	While $aFolderStack[0] > 0
		$sWorkingdir = $aFolderStack[$aFolderStack[0]]
		$aFolderStack[0] -= 1
		$aFile = _FTP_FindFileFirst($hFTPConnect, $sWorkingdir & '/*', $hSearch)
		If Not @error Then
			$bFirst = True
			While 1
				If $bFirst = False Then
					$aFile = _FTP_FindFileNext($hSearch)
					If @error Then ExitLoop
				EndIf
				If $aFile[1] = 16 Then
					$aFolderStack[0] += 1
					If UBound($aFolderStack) <= $aFolderStack[0] Then ReDim $aFolderStack[UBound($aFolderStack) * 2]
					$aFolderStack[$aFolderStack[0]] = $sWorkingdir & "/" & $aFile[10]
					If Not FileExists($localRoot & '\' & $sWorkingdir & "\" & $aFile[10]) Then DirCreate($localRoot & '\' & $sWorkingdir & "\" & $aFile[10])
				Else
					_FTP_DownloadFile(StringReplace($localRoot & '\' & $sWorkingdir & "\" & $aFile[10], '/', '\'), _
							$FTP_StartRoot & '/' & $sWorkingdir & "/" & $aFile[10], _WinAPI_MakeQWord($aFile[9], $aFile[8]))
				EndIf
				$bFirst = False
			WEnd
		EndIf
		_FTP_FindFileClose($hSearch)
	WEnd
	_FTP_DirSetCurrent($hFTPConnect, $sLastFTPDir)
EndFunc   ;==>_FTP_DirDownload
Func _FTP_DownloadFile($sLocal_File, $sFTP_File, $iFTP_FileSize)
	$gAbortFileName = '0;' & $sLocal_File
	Local $sFileName = StringTrimLeft($sLocal_File, StringInStr($sLocal_File, '\', 0, -1))
	;_MsgSend('Boss', '5;Start download | Size = ' & $iFTP_FileSize)
	$Global_Total_Filesize = $iFTP_FileSize
	$Global_Bytes_Transfered = 0
	$UpdateTimer = TimerInit()
	$Speed_Timer = TimerInit()
	_MsgSend('Boss', '3;' & $sFileName)
	_FTP_FileGet($hFTPConnect, $sFTP_File, $sLocal_File, False, 0, 0, $CallBack)
	_MsgSend('Boss', '4;' & $sFileName & ';' & $Global_Total_Filesize & ';' & TimerDiff($Speed_Timer))
	$Global_Total_Filesize = 0
	;_MsgSend('Boss', '5;End download | End Size = ' & $Global_Bytes_Transfered)
EndFunc   ;==>_FTP_DownloadFile
Func _FTP_DirUpload($s_LocalFolder, $s_RemoteFolder)
	Local $sStartdir, $sWorkingdir, $hSearch, $File;, $sCommon
	$s_LocalFolder = StringReplace($s_LocalFolder, '\\', '\')
	_FTP_DirSetCurrent($hFTPConnect, StringLeft($s_RemoteFolder, StringInStr($s_RemoteFolder, '/', 0, -1) - 1))
	_FTP_DirCreate($hFTPConnect, $s_RemoteFolder)
	$sStartdir = $s_RemoteFolder
	Local $aFolderStack[2] = [1, $s_LocalFolder]
	While $aFolderStack[0] > 0
		$sWorkingdir = $aFolderStack[$aFolderStack[0]]
		$s_RemoteFolder = StringReplace($sStartdir & StringReplace($sWorkingdir, $s_LocalFolder, ''), '\', '/')
		$aFolderStack[0] -= 1
		$hSearch = FileFindFirstFile($sWorkingdir & '\*')
		While 1
			$File = FileFindNextFile($hSearch)
			If @error Then ExitLoop
			If @extended Or StringInStr(FileGetAttrib($sWorkingdir & "\" & $File), "D") Then
				$aFolderStack[0] += 1
				If UBound($aFolderStack) <= $aFolderStack[0] Then ReDim $aFolderStack[UBound($aFolderStack) * 2]
				$aFolderStack[$aFolderStack[0]] = $sWorkingdir & "\" & $File
				_FTP_DirCreate($hFTPConnect, $s_RemoteFolder & "/" & $File)
			Else
				_FTP_UploadFile($sWorkingdir & "\" & $File, $s_RemoteFolder & '/' & $File)
			EndIf
		WEnd
		FileClose($hSearch)
	WEnd
	Return 1
EndFunc   ;==>_FTP_DirUpload
Func _FTP_UploadFile($sLocal_File, $sFTP_File)
	$gAbortFileName = '1;' & $sFTP_File
	Local $sFileName = StringTrimLeft($sLocal_File, StringInStr($sLocal_File, '\', 0, -1))
	$Global_Bytes_Transfered = 0
	$Global_Total_Filesize = FileGetSize($sLocal_File)
;~ 	_MsgSend('Boss', '5;Start Size = ' & $Global_Total_Filesize)
	$UpdateTimer = TimerInit()
	$Speed_Timer = TimerInit()
	_MsgSend('Boss', '3;' & $sFileName)
	_FTP_FilePut($hFTPConnect, $sLocal_File, $sFTP_File, 0, $CallBack)
	_MsgSend('Boss', '4;' & $sFileName & ';' & $Global_Total_Filesize & ';' & TimerDiff($Speed_Timer))
	$Global_Total_Filesize = 0
	;_MsgSend('Boss', '5;End Upload | End Size = ' & $Global_Bytes_Transfered)
EndFunc   ;==>_FTP_UploadFile
Func _ConnectFTP($sFTPAddress, $sUser, $sPass, $iPort)
	$hFTPOpen = _FTP_Open('worker')
	_InternetSetOption($hFTPOpen, $INTERNET_OPTION_RECEIVE_TIMEOUT, 8000)
	$CallBack = _FTP_SetStatusCallback($hFTPOpen, '_FTP_StatusHandler')
	$hFTPConnect = _FTP_Connect($hFTPOpen, $sFTPAddress, $sUser, $sPass, 1, $iPort, 1, 0, $CallBack)
	If @error Then
		_MsgSend('Boss', 5 & ';ERROR Connecting to Server')
	Else
		$bFTP_Connected = True
	EndIf
EndFunc   ;==>_ConnectFTP
Func _UpdateStatus($Finished = 0)
	If Not $Global_Total_Filesize Then Return
	If $Finished Or TimerDiff($UpdateTimer) > 300 Then
		Local $percent = Int(($Global_Bytes_Transfered / $Global_Total_Filesize) * 100)
		Local $speed = ($Global_Bytes_Transfered / (TimerDiff($Speed_Timer) / 1000))
		Local $time_Left_sec = Int(($Global_Total_Filesize - $Global_Bytes_Transfered) / $speed)
		_MsgSend('Boss', 2 & ';' & $percent & ';' & _bytes($speed) & '/sec' & ';' & $percent & '% ' & _Bytes_Display($Global_Bytes_Transfered, $Global_Total_Filesize) & ';' & $time_Left_sec)
		$UpdateTimer = TimerInit()
	EndIf
EndFunc   ;==>_UpdateStatus
Func _FTP_StatusHandler($hInternet, $dwContent, $dwInternetStatus, $lpvStatusInformation, $dwStatusInformationLength)

	Static $iLength = DllStructCreate('int Read'), $ds_Byte_Size = DllStructCreate('dword')
	Static $pLength = DllStructGetPtr($iLength), $pByte_Size = DllStructGetPtr($ds_Byte_Size)
	Static $iByte_Size, $Response_Count = 0, $Process_Handle = _WinAPI_GetCurrentProcess()

	If TimerDiff($ABORT_Check) > 1500 Then
		Local $iAbort = Int(IniRead($sINI_History, 'Abort', 'Abort', 0))
		If $iAbort Then
			DllCallbackFree($CallBack)
			_FTP_Close($hFTPOpen)
			_MsgSend('Boss', '6;' & $iAbort & ';' & $gAbortFileName)
			IniWrite($sINI_History, "Abort", "Abort", 0)
			Exit
		EndIf
		$ABORT_Check = TimerInit()
	EndIf

	Switch $dwInternetStatus
		Case 31; REQUEST_SENT\
			Switch $FTP_State
				Case $iDownloading
					$Response_Count += 1
				Case $iUploading
					$Response_Count += 1
					If $Response_Count >= 7 Then
						Local $aResult = DllCall($Kernel32, "int", "ReadProcessMemory", "int", $Process_Handle, "int", $lpvStatusInformation, "ptr", $pByte_Size, "int", $dwStatusInformationLength, "ptr", $pLength)
						$iByte_Size = DllStructGetData($ds_Byte_Size, 1)
						$Global_Bytes_Transfered += $iByte_Size
						_UpdateStatus()
					EndIf
			EndSwitch
		Case 41;RESPONSE_RECEIVED
			Switch $FTP_State
				Case $iDownloading
					$Response_Count += 1
					If $Response_Count >= 9 Then
						Local $aResult = DllCall($Kernel32, "int", "ReadProcessMemory", "int", $Process_Handle, "int", $lpvStatusInformation, "ptr", $pByte_Size, "int", $dwStatusInformationLength, "ptr", $pLength)
						$iByte_Size = DllStructGetData($ds_Byte_Size, 1)
						$Global_Bytes_Transfered += $iByte_Size
						_UpdateStatus()
					EndIf
				Case $iUploading
					$Response_Count += 1
			EndSwitch
		Case 70 ;HANDLE_CLOSING
			Switch $FTP_State
				Case $iDownloading
					$Global_Bytes_Transfered -= $iByte_Size
					;_MsgSend('Boss', '5;Bytes Downloaded = ' & $Global_Bytes_Transfered)
					_UpdateStatus(True)
				Case $iUploading
					_UpdateStatus(True)
					;_MsgSend('Boss', '5;Bytes Uploaded = ' & $Global_Bytes_Transfered)
			EndSwitch
			$iByte_Size = 0
			$Response_Count = 0
		Case 51; CONNECTION_CLOSED
			_MsgSend('Boss', '5;51 Connection Closed')
			$bFTP_Connected = False
		Case 21; CONNECTED_TO_SERVER
			_MsgSend('Boss', '5;Connected! ')
			$bFTP_Connected = True
	EndSwitch
;~ 	$idle_Clock = TimerInit()
EndFunc   ;==>_FTP_StatusHandler
;Others.....................................
Func _ReduceMemory()
	Static $Process_Handle = _WinAPI_GetCurrentProcess()
	If $FTP_State = $iIdle Then DllCall($PSAPI, 'int', 'EmptyWorkingSet', 'long', $Process_Handle)
EndFunc   ;==>_ReduceMemory
; #FUNCTION# ====================
Func _Bytes_Display($filesize, $totalfilesize)
	Switch $totalfilesize
		Case 0 To 1023
			Return '(' & $filesize & '/' & $totalfilesize & " Bytes)"
		Case 1024 To 1048575
			$filesize /= 1024
			$totalfilesize /= 1024
			Return StringFormat('(%.2f/%.2f) KB', $filesize, $totalfilesize)
		Case 1048576 To 1073741823
			$filesize /= 1048576
			$totalfilesize /= 1048576
			Return StringFormat('(%.2f/%.2f) MB', $filesize, $totalfilesize)
		Case Else
			$filesize /= 1073741824
			$totalfilesize /= 1073741824
			Return StringFormat('(%.2f/%.2f) GB', $filesize, $totalfilesize)
	EndSwitch
EndFunc   ;==>_Bytes_Display
Func _bytes($bytes)
	If $bytes > 1048575 Then Return StringFormat('%.2f mB', ($bytes / 1048576))
	Return StringFormat('%.1f kB', ($bytes / 1024))
EndFunc   ;==>_bytes
Func _Exit()
	If $bFTP_Connected Then _FTP_Close($hFTPOpen)
	IniWrite($sINI_History, "Abort", "Abort", 0)
	DllClose($Kernel32)
EndFunc   ;==>_Exit
Func _Singleton($sOccurenceName, $iFlag = 0)
	Local Const $ERROR_ALREADY_EXISTS = 183
	Local Const $SECURITY_DESCRIPTOR_REVISION = 1
	Local $pSecurityAttributes = 0
	If BitAND($iFlag, 2) Then
		Local $tSecurityDescriptor = DllStructCreate("dword[5]")
		Local $pSecurityDescriptor = DllStructGetPtr($tSecurityDescriptor)
		Local $aRet = DllCall("advapi32.dll", "bool", "InitializeSecurityDescriptor", _
				"ptr", $pSecurityDescriptor, "dword", $SECURITY_DESCRIPTOR_REVISION)
		If @error Then Return SetError(@error, @extended, 0)
		If $aRet[0] Then
			$aRet = DllCall("advapi32.dll", "bool", "SetSecurityDescriptorDacl", _
					"ptr", $pSecurityDescriptor, "bool", 1, "ptr", 0, "bool", 0)
			If @error Then Return SetError(@error, @extended, 0)
			If $aRet[0] Then
				Local $structSecurityAttributes = DllStructCreate($tagSECURITY_ATTRIBUTES)
				DllStructSetData($structSecurityAttributes, 1, DllStructGetSize($structSecurityAttributes))
				DllStructSetData($structSecurityAttributes, 2, $pSecurityDescriptor)
				DllStructSetData($structSecurityAttributes, 3, 0)
				$pSecurityAttributes = DllStructGetPtr($structSecurityAttributes)
			EndIf
		EndIf
	EndIf
	Local $handle = DllCall("kernel32.dll", "handle", "CreateMutexW", "ptr", $pSecurityAttributes, "bool", 1, "wstr", $sOccurenceName)
	If @error Then Return SetError(@error, @extended, 0)
	Local $lastError = DllCall("kernel32.dll", "dword", "GetLastError")
	If @error Then Return SetError(@error, @extended, 0)
	If $lastError[0] = $ERROR_ALREADY_EXISTS Then
		If BitAND($iFlag, 1) Then
			Return SetError($lastError[0], $lastError[0], 0)
		Else
			Exit -1
		EndIf
	EndIf
	Return $handle[0]
EndFunc   ;==>_Singleton
; #FUNCTION# ===============================
; Author(s):		Yashied
;====================================================================================================================================
Func _InternetSetOption($hInternet, $lOption, $lValue)
	Local $Ret, $Back, $tBuffer
	Switch $lOption
		Case 2, 3, 5, 6, 12, 13
			If IsInt($lValue) Then $tBuffer = DllStructCreate('int')
		Case 28, 29, 41
			If IsString($lValue) Then $tBuffer = DllStructCreate('char[' & StringLen($lValue) + 1 & ']')
		Case 38
			If IsDllStruct($lValue) Then $tBuffer = DllStructCreate($tagINTERNET_PROXY_INFO, DllStructGetPtr($lValue))
		Case 45
			If IsPtr($lValue) Then $tBuffer = DllStructCreate('ptr')
		Case Else
			Return SetError(1, 0, 0)
	EndSwitch
	If Not ($lOption = 38) Then DllStructSetData($tBuffer, 1, $lValue)
	$Back = _InternetGetOption($hInternet, $lOption)
	If (@error) Then Return SetError(1, @extended, 0)
	$Ret = DllCall('wininet.dll', 'int', 'InternetSetOption', 'hwnd', $hInternet, 'dword', $lOption, 'ptr', DllStructGetPtr($tBuffer), 'dword', DllStructGetSize($tBuffer))
	If (@error) Or ($Ret[0] = 0) Then Return SetError(1, _WinAPI_GetLastError(), 0)
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
	If (@error) Or ($Ret[0] = 0) Then Return SetError(1, _WinAPI_GetLastError(), 0)
	Switch $lOption
		Case 38
			Return SetError(0, 0, $tBuffer)
		Case Else
			Return SetError(0, 0, DllStructGetData($tBuffer, 1))
	EndSwitch
EndFunc   ;==>_InternetGetOption






