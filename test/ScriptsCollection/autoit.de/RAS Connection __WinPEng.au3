; WinPEng
; http://www.autoit.de/index.php?page=Thread&threadID=26567
#include <Date.au3>
#include <GUIConstantsEx.au3>
#include <GuiEdit.au3>
#include <StaticConstants.au3>
#include <WindowsConstants.au3>
Global Const $RAS_MaxEntryName = 256
Global Const $RAS_MaxPhoneNumber = 128
Global Const $RAS_MaxCallbackNumber = 128
Global Const $UNLEN = 256
Global Const $PWLEN = 256
Global Const $DNLEN = 12
Global Const $RAS_MaxDeviceType = 16
Global Const $RAS_MaxDeviceName = 128
Global Const $MAX_PATH = 260
Global $RasActiveEntryName, $hRasConn, $RASAPIDLL, $RasEntrieNames, $RasDefaultEntrie
Global $RasUserName = "nc-musterha@netcologne.de"
Global $RasPassword = "1M1111"
Global $RASGUIEntries, $i
Global $NoRAS = False
Global $RASConState = "OFFLINE", $RASConStateOld = $RASConState
Global $BytesSend, $BytesRec
Global $STTime, $DITime
#region ### START Koda GUI section ### Form=v:\ras\___neu\formrascon.kxf
$FormRASCon = GUICreate("RAS Connection", 413, 274, -1, -1)
$LRasCon = GUICtrlCreateLabel("RAS Eintrag:", 16, 24, 65, 17)
$LRasStat = GUICtrlCreateLabel("RAS Status: ", 16, 56, 65, 17)
$LRasStatValue = GUICtrlCreateLabel($RASConState, 116, 56, 65, 17)
GUICtrlSetColor($LRasStatValue, 0xff0000)
$LRasSend = GUICtrlCreateLabel("Bytes gesendet: ", 232, 24, 83, 17)
$LRasSendValue = GUICtrlCreateLabel("", 322, 24, 70, 17, $SS_RIGHT)
$LRasRec = GUICtrlCreateLabel("Bytes empfangen: ", 232, 56, 92, 17)
$LRasRecValue = GUICtrlCreateLabel("", 322, 56, 70, 17, $SS_RIGHT)
$CRASCon = GUICtrlCreateCombo("", 88, 22, 129, 25)
$ELog = GUICtrlCreateEdit("", 16, 96, 377, 123)
$BCancel = GUICtrlCreateButton("Schlie?en", 320, 234, 75, 25, $WS_GROUP)
$BConnect = GUICtrlCreateButton("Verbinden", 220, 234, 75, 25, $WS_GROUP)
$BReConnect = GUICtrlCreateButton("NeuEinwahl", 120, 234, 75, 25, $WS_GROUP)
GUICtrlSetState($BConnect, $GUI_DISABLE)
GUICtrlSetState($BReConnect, $GUI_DISABLE)
GUISetState(@SW_SHOW)
#endregion ### END Koda GUI section ###
WritelnLog("Ermittle RAS Eintrage...")
_RasStart()
For $i = 0 To UBound($RasEntrieNames) - 1
	$RASGUIEntries = $RASGUIEntries & $RasEntrieNames[$i] & "|"
	WritelnLog($RasEntrieNames[$i] & " gefunden...")
Next
GUICtrlSetData($CRASCon, $RASGUIEntries, $RasDefaultEntrie)
$STTime = TimerInit()
While 1
	$DITime = TimerDiff($STTime)
	If $DITime > 100 Then
		UpdateValues()
		$STTime = TimerInit()
	EndIf
	$nMsg = GUIGetMsg()
	Switch $nMsg
		Case $GUI_EVENT_CLOSE, $BCancel
			_RasEnd()
			Exit
		Case $BConnect
			If _RasIsActive() Then
				_RasHangUp($hRasConn)
				UpdateValues()
			Else
				_RasDial($RasDefaultEntrie, $RasUserName, $RasPassword)
				UpdateValues()
			EndIf
		Case $BReConnect
			If _RasIsActive() Then
				_RasHangUp($hRasConn)
				UpdateValues()
				_RasDial($RasDefaultEntrie, $RasUserName, $RasPassword)
				UpdateValues()
			Else
				_RasDial($RasDefaultEntrie, $RasUserName, $RasPassword)
				UpdateValues()
			EndIf
	EndSwitch
WEnd
Func UpdateValues()
	If Not $NoRAS Then
		If GUICtrlGetState($BReConnect) And $GUI_DISABLE = $GUI_DISABLE Then GUICtrlSetState($BReConnect, $GUI_ENABLE)
		If Not _RasIsActive() Then
			If $RASConState <> "OFFLINE" Then
				$RASConState = "OFFLINE"
				GUICtrlSetData($BConnect, "Verbinden")
				If GUICtrlGetState($BConnect) And $GUI_DISABLE = $GUI_DISABLE Then GUICtrlSetState($BConnect, $GUI_ENABLE)
			EndIf
			If $RASConState <> $RASConStateOld Then
				GUICtrlSetData($LRasStatValue, $RASConState)
				GUICtrlSetColor($LRasStatValue, 0xff0000)
				WritelnLog($RasDefaultEntrie & " getrennt...")
				$RASConStateOld = $RASConState
			EndIf
		Else
			If $RASConState <> "ONLINE" Then
				$RASConState = "ONLINE"
				GUICtrlSetData($BConnect, "Trennen")
				If GUICtrlGetState($BConnect) And $GUI_DISABLE = $GUI_DISABLE Then GUICtrlSetState($BConnect, $GUI_ENABLE)
			EndIf
			If $RASConState <> $RASConStateOld Then
				GUICtrlSetData($LRasStatValue, $RASConState)
				GUICtrlSetColor($LRasStatValue, 0x00ff00)
				WritelnLog($RasDefaultEntrie & " verbunden...")
				$RASConStateOld = $RASConState
			EndIf
			$BytesSend = _Filesize(_RASConStat(1), "", 2)
			$BytesRec = _Filesize(_RASConStat(2), "", 2)
			GUICtrlSetData($LRasSendValue, $BytesSend)
			GUICtrlSetData($LRasRecValue, $BytesRec)
		EndIf
	EndIf
EndFunc   ;==>UpdateValues
Func WritelnLog($sText, $sFlag = 1)
	If $sFlag = 1 Then $sText = $sText & @CRLF
	$sText = _Now() & " - " & $sText
	_GUICtrlEdit_AppendText($ELog, $sText)
EndFunc   ;==>WritelnLog

Func _RasStart()
	$RASAPIDLL = DllOpen("rasapi32.dll")
	$RasEntrieNames = _RasEnumEntries()
	If @error Then
		MsgBox(16, "Fehler", "Es sind keine RAS Verbindungen eingerichtet." & @CRLF & _
				"Das Programm wird beendet.")
		_RasEnd()
		Exit
	EndIf
	$RasDefaultEntrie = $RasEntrieNames[0]
EndFunc   ;==>_RasStart
Func _RasEnd()
	DllClose($RASAPIDLL)
EndFunc   ;==>_RasEnd
Func _RasIsActive()
	$hRasConn = _RasEnumConnections()
	If @error = 1 Then Return SetError(1, @extended, -1)
	If @error = 2 Then
		Return False
	Else
		Return True
	EndIf
EndFunc   ;==>_RasIsActive

; #FUNCTION# =========================================================================================================
; $sFlags:
; 1 - The number of bytes transmitted through this connection or link.
; 2 - The number of bytes received through this connection or link.
; 3 - Total
; 4 - The amount of time, in milliseconds, that the connection or link has been connected.
; ====================================================================================================================
Func _RASConStat($sFlags = 1)
	If Not _RasIsActive() Then Return SetError(1, 0, 0)
	$tRAS_STATS = DllStructCreate("dword dwSize;dword dwBytesXmited;dword dwBytesRcved;dword dwFramesXmited;" & _
			"dword dwFramesRcved;dword dwCrcErr;dword dwTimeoutErr;dword dwAlignmentErr;" & _
			"dword dwHardwareOverrunErr;dword dwFramingErr;dword dwBufferOverrunErr;" & _
			"dword dwCompressionRatioIn;dword dwCompressionRatioOut;dword dwBps;dword dwConnectDuration")
	DllStructSetData($tRAS_STATS, "dwSize", DllStructGetSize($tRAS_STATS))
	$aRet = DllCall($RASAPIDLL, "int", "RasGetConnectionStatistics", _
			"hwnd", $hRasConn, _
			"ptr", DllStructGetPtr($tRAS_STATS))
	If $aRet[0] Then Return SetError(2, 0, 0)
	Local $iResult = 0
	Switch $sFlags
		Case 1
			$iResult = DllStructGetData($tRAS_STATS, "dwBytesXmited")
		Case 2
			$iResult = DllStructGetData($tRAS_STATS, "dwBytesRcved")
		Case 3
			$iResult = DllStructGetData($tRAS_STATS, "dwBytesXmited") + DllStructGetData($tRAS_STATS, "dwBytesRcved")
		Case 4
			$iResult = DllStructGetData($tRAS_STATS, "dwConnectDuration")
	EndSwitch
	Return $iResult
EndFunc   ;==>_RASConStat

Func _RasDial($szEntryName, $szUserName, $szPassword)
	Local $RASDIALPARAMS = DllStructCreate("dword dwSize;char szEntryName[" & $RAS_MaxEntryName + 1 & "];" & _
			"char szPhoneNumber[" & $RAS_MaxPhoneNumber + 1 & "];" & _
			"char szCallbackNumber[" & $RAS_MaxCallbackNumber + 1 & "];" & _
			"char szUserName[" & $UNLEN + 1 & "];" & _
			"char szPassword[" & $PWLEN + 1 & "];" & _
			"char szDomain[" & $DNLEN + 1 & "];dword dwSubEntry;ulong_ptr dwCallbackId;dword dwIfIndex")
	DllStructSetData($RASDIALPARAMS, "dwSize", DllStructGetSize($RASDIALPARAMS))
	DllStructSetData($RASDIALPARAMS, "szEntryName", $szEntryName)
	DllStructSetData($RASDIALPARAMS, "szUserName", $szUserName)
	DllStructSetData($RASDIALPARAMS, "szPassword", $szPassword)
	Local $RasConn = DllStructCreate("dword hRasConn")
	DllStructSetData($RasConn, "hRasConn", 0)
	Local $aRet = DllCall($RASAPIDLL, "int", "RasDial", _
			"ptr", 0, "ptr", 0, _
			"ptr", DllStructGetPtr($RASDIALPARAMS), _
			"dword", 0, "hwnd", 0, _
			"ptr", DllStructGetPtr($RasConn))
	If $aRet[0] Then Return SetError(1, $aRet[0], -1)
	$hRasConn = DllStructGetData($RasConn, "hRasConn")
	$RasActiveEntryName = $szEntryName
	Return $hRasConn
EndFunc   ;==>_RasDial

Func _RasHangUp($hRasConn)
	$aRet = DllCall($RASAPIDLL, "int", "RasHangUp", "hwnd", $hRasConn)
	Return $aRet[0]
EndFunc   ;==>_RasHangUp

Func _RasEnumConnections()
	Local $iCntByte = DllStructCreate("dword")
	Local $iCntConn = DllStructCreate("dword")
	Local $RasConn = DllStructCreate("dword dwSize;hwnd hRasConn;char szEntryName[" & $RAS_MaxEntryName + 1 & "];" & _
			"char szDeviceType[" & $RAS_MaxDeviceType + 1 & "];" & _
			"char szDeviceName[" & $RAS_MaxDeviceName + 1 & "];" & _
			"char szPhonebook[" & $MAX_PATH & "];" & _
			"dword dwSubEntry;byte guidEntry[16];dword dwFlags;byte luid[8]")
	DllStructSetData($RasConn, "dwSize", DllStructGetSize($RasConn))
	DllStructSetData($iCntByte, 1, DllStructGetSize($RasConn))
	Local $aRet = DllCall($RASAPIDLL, "int", "RasEnumConnections", _
			"ptr", DllStructGetPtr($RasConn), _
			"ptr", DllStructGetPtr($iCntByte), _
			"ptr", DllStructGetPtr($iCntConn))
	If $aRet[0] Then Return SetError(1, $aRet[0], -1)
	If DllStructGetData($iCntConn, 1) < 1 Then
		$RasActiveEntryName = ""
		Return SetError(2, 0, 0) ;Error: not opened connections
	EndIf
	$RasActiveEntryName = DllStructGetData($RasConn, "szEntryName")
	Return DllStructGetData($RasConn, "hRasConn")
EndFunc   ;==>_RasEnumConnections

Func _RasEnumEntries()
	Local Const $SUCCESS = 0
	Local Const $ERROR_NOT_ENOUGH_MEMORY = 8
	Local Const $RASBASE = 600
	Local Const $ERROR_BUFFER_TOO_SMALL = $RASBASE + 3
	Local Const $ERROR_INVALID_SIZE = $RASBASE + 32
	Dim $result[1]
	Local $i
	Local $RAS_MaxEntryName = 0x104 ;don't no why it is not 0x100....
	Local $RasEntryName = "int dwSize;char szEntryName[" & $RAS_MaxEntryName & "]" ;RASENTRYNAME structure data
	Local $TRasEntryName = DllStructCreate($RasEntryName) ;temporary Structure for sizing
	Local $RAS_EntryName_Size = DllStructGetSize($TRasEntryName) ;Structure Size
	Local $mem = _MemGlobalAlloc(256 * $RAS_EntryName_Size, $GPTR) ;Allocate Memory for Array
	Dim $ARasEntryName[256] ;Create an Array [256] for Param 3
	For $i = 0 To 255
		$ARasEntryName[$i] = DllStructCreate($RasEntryName, $mem + ($i * $RAS_EntryName_Size)) ;Create 256 Structures in the Array
	Next
	Local $lpcb = 256 * $RAS_EntryName_Size ;calc BufferSize (Param4)
	Local $lpcEntries = 0 ;Init Param5
	DllStructSetData($ARasEntryName[0], 1, $RAS_EntryName_Size) ;write StructureSize to first member of the array
	Local $res = DllCall($RASAPIDLL, "int", "RasEnumEntries", "ptr", 0, "ptr", 0, "ptr", DllStructGetPtr($ARasEntryName[0]), "int*", $lpcb, "int*", $lpcEntries)
	If $res[0] = 0 Then ;Return Value
		Local $noEntries = $res[5] ;number of Entries
		If $noEntries > 0 Then
			For $i = 0 To $noEntries - 1
				$result[$i] = DllStructGetData($ARasEntryName[$i], "szEntryName") ;copy result to result-Array
				ReDim $result[UBound($result) + 1] ;resize result-Array
			Next
			ReDim $result[UBound($result) - 1] ;delete last (empty) entry
			Return $result
		Else
			SetError(1, 0, 0)
		EndIf
	Else
		SetError(1, 0, 0)
	EndIf
EndFunc   ;==>_RasEnumEntries

;===============================================================================
; Author(s): busysignal
; Version: 1.0.0
; AutoItVer: 3.1.1.+
; Created 2005-10-15
;
; Description: Formats a files size according to $sFormat & $iDecimal parameters
; Syntax: _Filesize($iValue, $sFormat, $iNum)
;
; Parameter(s): $iValue = The value in "Bytes"
; $SFormat = Specify the Size format you wish to display, options are:
; "" - Auto Select based on value entered
; "GB" - Display in Gigabytes
; "MB" - Display in Megabytes
; "KB" - Display in Kilobytes
; "B" - Display in Bytes
; $iDecimal = The number of decimals places to round up converted value to
; Requirement(s): None
; Return Value(s): On Success - Returns a string representation of $iValue formatted according to $sFormat
; On Failure - Returns an empty string "" if no files are found and sets @Error on errors
; @Error=1 $iValue = 0; no value to convert
; @Error=2 Either $iValue or $iDecimal contains non-numeric characters.
; Note(s): Example: _Filesize(2152971234,"GB", 2) would return "2.15 GB"
;
; Credits: Inspired by _PictureUDF() by SolidSnake <MetalGearX91@Hotmail.com>
;===============================================================================
Func _Filesize($iValue, $sFormat, $iDecimal)
	Local $sReturn, $iB, $iKB, $iMB, $iGB
	If $iValue = 0 Then
		SetError(1)
		Return 0
	EndIf
	If Not StringIsDigit($iValue) Or Not StringIsDigit($iDecimal) Then
		SetError(2)
		Return 0
	EndIf
	; Conversion Chart
	$iB = $iValue
	$iKB = Round($iB / 1024, $iDecimal)
	$iMB = Round($iKB / 1024, $iDecimal)
	$iGB = Round($iMB / 1024, $iDecimal)
	Select
		Case $sFormat = ""; Auto Select Format Display Type
			If $iMB > 1024 Then
				$iValue = $iGB & " GB"
			ElseIf $iKB > 1024 Then
				$iValue = $iMB & " MB"
			ElseIf $iKB > 0 Then
				$iValue = $iKB & " KB"
			ElseIf $iKB < 0 Then
				$iValue = $iB & " Bytes"
			EndIf
		Case $sFormat = "GB"
			$iValue = $iGB & " GB"
		Case $sFormat = "MB"
			$iValue = $iMB & " MB"
		Case $sFormat = "KB"
			$iValue = $iKB & " KB"
		Case $sFormat = "B"
			$iValue = $iB & " Bytes"
	EndSelect
	Return $iValue
EndFunc   ;==>_Filesize