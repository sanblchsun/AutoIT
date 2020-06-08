#include-once
#include "Bass.au3"

; #INDEX# =======================================================================================================================
; Title .........: BassExt.au3 BETA
; Description ...: Extended functions for bass.au3
;                  Callback routines, Peak & RMS Level, Phasecorrelation, drawing Waveform, Binarybuffer, & more to come
; Author ........: Eukalyptus, Prog@ndy
; ===============================================================================================================================

; #CURRENT# =====================================================================================================================
; Init
;			_BASS_EXT_Startup
;
; Level functions
;           _BASS_EXT_ChannelSetMaxPeakDsp
;           _BASS_EXT_ChannelGetMaxPeak
;           _BASS_EXT_ChannelRemoveMaxPeakDsp
;           _BASS_EXT_ChannelGetRMSLevel
;           _BASS_EXT_ChannelGetPhaseData
;           _BASS_EXT_ChannelGetPhaseDataEx
;           _BASS_EXT_ChannelGetWaveform
;           _BASS_EXT_ChannelGetWaveformEx
;           _BASS_EXT_CreateFFT
;           _BASS_EXT_ChannelGetFFT
;           _BASS_EXT_Level2dB
;           _BASS_EXT_dB2Level
;
; Buffer functions
;           _BASS_EXT_StreamPipeCreate
;           _BASS_EXT_MemoryBufferCreate
;           _BASS_EXT_MemoryBufferDestroy
;           _BASS_EXT_MemoryBufferGetSize
;           _BASS_EXT_MemoryBufferGetData
;           _BASS_EXT_MemoryBufferAddData
;           _BASS_EXT_StreamPutBufferData
;           _BASS_EXT_StreamPutFileBufferData
;
; Callback functions
;           $BASS_EXT_FILEPROCS
;           $BASS_EXT_FileSeekProc
;           $BASS_EXT_FileReadProc
;           $BASS_EXT_FileLenProc
;           $BASS_EXT_FileCloseProc
;           $BASS_EXT_StreamProc
;           $BASS_EXT_RecordProc
;           $BASS_EXT_EncodeProc
;           $BASS_EXT_DSPProc
;           $BASS_EXT_DownloadProc
;           $BASS_EXT_AsioProc
;
; #INTERNAL_USE_ONLY#============================================================================================================
;			__BASS_EXT_GetCallBackPointer()
; ===============================================================================================================================


;Global $BASS_EXT_AsioNotifyProc = 0
;Global $BASS_EXT_SyncProc = 0
;Global $BASS_EXT_EncodeNotifyProc = 0
Global $tBASS_EXT_FILEPROCS = DllStructCreate("ptr;ptr;ptr;ptr")
Global $BASS_EXT_FILEPROCS = DllStructGetPtr($tBASS_EXT_FILEPROCS)
Global $BASS_EXT_FileSeekProc = 0
Global $BASS_EXT_FileReadProc = 0
Global $BASS_EXT_FileLenProc = 0
Global $BASS_EXT_FileCloseProc = 0
Global $BASS_EXT_StreamProc = 0
Global $BASS_EXT_RecordProc = 0
Global $BASS_EXT_EncodeProc = 0
Global $BASS_EXT_DSPProc = 0
Global $BASS_EXT_DownloadProc = 0
Global $BASS_EXT_AsioProc = 0

Global $BASS_EXT_DspPeakProc = 0

Global Const $BASS_EXT_STREAMPROC_DUMMY = 0
Global Const $BASS_EXT_STREAMPROC_PUSH = -1
Global Const $BASS_EXT_STREAMFILE_BUFFERPUSH = 1
Global Const $BASS_EXT_STRUCT_BYTE = 2

Global $_ghBassEXTDll = -1


; #FUNCTION# ====================================================================================================================
; Name...........: _BASS_EXT_Startup
; Description ...: Starts up BASS functions.
; Syntax.........: _BASS_EXT_Startup($sBassEXTDLL)
; Parameters ....:  -	$sBassDLL	-	The relative path to BassEXT.dll.
; Return values .: Success      - Returns True
;                  Failure      - Returns False and sets @ERROR
;									@error will be set to-
;										- $BASS_ERR_DLL_NO_EXIST	-	File could not be found.
; Author ........: Prog@ndy
; Modified.......: Brett Francis (BrettF), Eukalyptus
; Remarks .......:
; Related .......:
; Link ..........;
; Example .......;
; ===============================================================================================================================
Func _BASS_EXT_Startup($sBassEXTDLL = "BassExt.dll")
	If $_ghBassEXTDll <> -1 Then Return True
	If Not FileExists($sBassEXTDLL) Then Return SetError($BASS_ERR_DLL_NO_EXIST, 0, False)
	$_ghBassEXTDll = DllOpen($sBassEXTDLL)
	If Not @error Then ; Get Pointer to the callback functions
		$BASS_EXT_StreamProc = __BASS_EXT_GetCallBackPointer(1)
		If @error Then Return SetError(1, 1, 0)
		$BASS_EXT_RecordProc = __BASS_EXT_GetCallBackPointer(2)
		If @error Then Return SetError(1, 2, 0)
		$BASS_EXT_EncodeProc = __BASS_EXT_GetCallBackPointer(3)
		If @error Then Return SetError(1, 3, 0)
		$BASS_EXT_DSPProc = __BASS_EXT_GetCallBackPointer(4)
		If @error Then Return SetError(1, 4, 0)
		$BASS_EXT_DownloadProc = __BASS_EXT_GetCallBackPointer(5)
		If @error Then Return SetError(1, 5, 0)
		$BASS_EXT_AsioProc = __BASS_EXT_GetCallBackPointer(6)
		If @error Then Return SetError(1, 6, 0)
		$BASS_EXT_DspPeakProc = __BASS_EXT_GetCallBackPointer(7)
		If @error Then Return SetError(1, 7, 0)
		$BASS_EXT_FileCloseProc = __BASS_EXT_GetCallBackPointer(8)
		If @error Then Return SetError(1, 8, 0)
		$BASS_EXT_FileLenProc = __BASS_EXT_GetCallBackPointer(9)
		If @error Then Return SetError(1, 9, 0)
		$BASS_EXT_FileReadProc = __BASS_EXT_GetCallBackPointer(10)
		If @error Then Return SetError(1, 10, 0)
		$BASS_EXT_FileSeekProc = __BASS_EXT_GetCallBackPointer(11)
		If @error Then Return SetError(1, 11, 0)
		DllStructSetData($tBASS_EXT_FILEPROCS, 1, $BASS_EXT_FileCloseProc)
		DllStructSetData($tBASS_EXT_FILEPROCS, 2, $BASS_EXT_FileLenProc)
		DllStructSetData($tBASS_EXT_FILEPROCS, 3, $BASS_EXT_FileReadProc)
		DllStructSetData($tBASS_EXT_FILEPROCS, 4, $BASS_EXT_FileSeekProc)
	EndIf
	Return $_ghBassEXTDll <> -1
EndFunc   ;==>_BASS_EXT_Startup


; #FUNCTION# ====================================================================================================================
; Name...........: Func _BASS_EXT_StreamPipeCreate()
; Description ...: Set a Stream to use in a callbackfuntion
; Syntax.........: Func _BASS_EXT_StreamPipeCreate($hStream, $iType=0)
; Parameters ....:  -$hStream 			-	The handle of the stream
;                   -$iType             -   The type of the stream
;                                           - $BASS_EXT_STREAMPROC_DUMMY: 	Stream is STREAMPROC_DUMMY and the sampledata is feed through to apply DSP/FX
;                                           - $BASS_EXT_STREAMPROC_PUSH: 	Stream is STREAMPROC_PUSH and the sampledata is pushed to it by BASS_StreamPutData
;                                                                           In case of AsioOut and StreamProc: sampledata is get from it by _BASS_ChannelGetData
;                                           - $BASS_EXT_StreamPutFileData: 	Stream was created by BASS_StreamCreateFileUser and sampledata is pushed to it by BASS_StreamPutFileData
;
; Return values .: Success      - Returns If successful, then a array to pass as userdata is returned
;                  Failure      - Returns 0
; Author ........: Eukalyptus
; Modified.......:
; Remarks .......:
; Related .......: BASS_ChannelGetData, BASS_StreamPutData, BASS_StreamPutFileData
; Link ..........;
; Example .......;
; ===============================================================================================================================
Func _BASS_EXT_StreamPipeCreate($hStream, $iType = 0)
	If Not $hStream Then Return SetError(1, 0, 0)
	Local $tStruct = DllStructCreate("UINT_PTR;INT_PTR")
	DllStructSetData($tStruct, 1, $hStream)
	DllStructSetData($tStruct, 2, $iType)
	Local $aReturn[2]
	$aReturn[0] = DllStructGetPtr($tStruct)
	$aReturn[1] = $tStruct
	Return $aReturn
EndFunc   ;==>_BASS_EXT_StreamPipeCreate

; #FUNCTION# ====================================================================================================================
; Name...........: _BASS_EXT_MemoryBufferGetSize
; Description ...: How many bytes are in the buffer?
; Syntax.........: _BASS_EXT_MemoryBufferGetSize($aBuffer)
; Parameters ....:  -   $aBuffer           - Buffer as returned by _BASS_EXT_MemoryBufferCreate
; Return values .: Success      - Returns used buffer in bytes
;                  Failure      - Returns 0 and sets @error to 1
; Author ........: Eukalyptus
; Modified.......:
; Remarks .......:
; Related .......: _BASS_EXT_MemoryBufferCreate, Binary, BinaryLen, BinaryMid
; Link ..........;
; Example .......;
; ===============================================================================================================================
Func _BASS_EXT_MemoryBufferGetSize($aBuffer)
	If Not IsArray($aBuffer) Or Not IsDllStruct($aBuffer[3]) Then Return SetError(1, 0, 0)
	Return DllStructGetData($aBuffer[3], 1)
EndFunc   ;==>_BASS_EXT_MemoryBufferGetSize

; #FUNCTION# ====================================================================================================================
; Name...........: _BASS_EXT_MemoryBufferAddData
; Description ...: Adds binary data to the buffer
; Syntax.........: _BASS_EXT_MemoryBufferAddData($aBuffer, $bData)
; Parameters ....:  -   $aBuffer           - Buffer as returned by _BASS_EXT_MemoryBufferCreate
;                   -   $bData             - Binarydata to add at the end of the buffer
; Return values .: Success      - Returns added bytes
;                  Failure      - Returns 0 and sets @error to 1
; Author ........: Eukalyptus
; Modified.......:
; Remarks .......:
; Related .......: _BASS_EXT_MemoryBufferCreate, Binary, BinaryLen, BinaryMid
; Link ..........;
; Example .......;
; ===============================================================================================================================
Func _BASS_EXT_MemoryBufferAddData($aBuffer, $bData)
	If Not IsArray($aBuffer) Then Return SetError(1, 0, 0)
	Local $iLength = BinaryLen($bData)
	Local $tData = DllStructCreate("byte[" & $iLength & "]")
	DllStructSetData($tData, 1, $bData)
	Local $aRet = DllCall($_ghBassEXTDll, "dword", "_BASS_EXT_MemoryBufferAddData", "ptr", $aBuffer[2], "ptr", DllStructGetPtr($tData), "dword", $iLength)
	Switch @error
		Case True
			Return SetError(@error, 0, 0)
		Case Else
			Return SetError(0, 0, $aRet[0])
	EndSwitch
EndFunc   ;==>_BASS_EXT_MemoryBufferAddData

; #FUNCTION# ====================================================================================================================
; Name...........: _BASS_EXT_MemoryBufferGetData
; Description ...: Returns bufferdata
; Syntax.........: _BASS_EXT_MemoryBufferGetData($aBuffer, $iLength, $iOffset = 0, $bRemove = True)
; Parameters ....:  -   $aBuffer           - Buffer as returned by _BASS_EXT_MemoryBufferCreate
;                   -   $iLength           - Length of data in bytes
;                   -   $iOffset           - Offset of data in bytes
;                   -   $bRemove           - If True then the Data is removed from the buffer
; Return values .: Success      - Returns binary bufferdata
;                  Failure      - Returns 0 and sets @error to 1
; Author ........: Eukalyptus
; Modified.......:
; Remarks .......:
; Related .......: _BASS_EXT_MemoryBufferCreate, Binary, BinaryLen, BinaryMid
; Link ..........;
; Example .......;
; ===============================================================================================================================
Func _BASS_EXT_MemoryBufferGetData($aBuffer, $iLength, $iOffset = 0, $bRemove = True)
	If Not IsArray($aBuffer) Then Return SetError(1, 0, 0)
	If $iLength <= 0 Then Return SetError(1, 0, 0)
	Local $tData = DllStructCreate("byte[" & $iLength & "]")
	Local $aRet = DllCall($_ghBassEXTDll, "dword", "_BASS_EXT_MemoryBufferGetData", "ptr", $aBuffer[2], "ptr", DllStructGetPtr($tData), "dword", $iLength, "dword", $iOffset, "dword", $bRemove)
	Switch @error
		Case True
			Return SetError(@error, 0, 0)
		Case Else
			$iLength = $aRet[0]
			Local $bData = DllStructGetData($tData, 1)
			$bData = BinaryMid($bData, 1, $iLength)
			Return SetError(0, 0, $bData)
	EndSwitch
EndFunc   ;==>_BASS_EXT_MemoryBufferGetData

; #FUNCTION# ====================================================================================================================
; Name...........: _BASS_EXT_StreamPutBufferData
; Description ...: Puts the bufferdata to a STREAMPROC_PUSH stream
; Syntax.........: _BASS_EXT_StreamPutBufferData($hHandle, $aBuffer, $bRemove = True)
; Parameters ....:  -   $hHandle           - The stream handle
;                   -   $aBuffer           - Buffer as returned by _BASS_EXT_MemoryBufferCreate
;                   -   $iBytes            - Number of bytes
;                   -   $bRemove           - If True then the Data is removed from the buffer
; Return values .: Success      - Returns amount of queued data
;                  Failure      - Returns 0 and sets @error to 1
; Author ........: Eukalyptus
; Modified.......:
; Remarks .......:
; Related .......: _BASS_EXT_MemoryBufferCreate, _BASS_StreamCreate, _BASS_StreamPutData, $STREAMPROC_PUSH
; Link ..........;
; Example .......;
; ===============================================================================================================================
Func _BASS_EXT_StreamPutBufferData($hHandle, $aBuffer, $iBytes, $bRemove = True)
	If Not IsArray($aBuffer) Then Return SetError(1, 0, 0)
	If Not $hHandle Then Return SetError(1, 0, 0)
	Local $iLength = _BASS_EXT_MemoryBufferGetSize($aBuffer)
	If $iLength < 1 Then Return SetError(0, 1, False)
	If $iBytes > $iLength Then $iBytes = $iLength
	Local $bData = _BASS_EXT_MemoryBufferGetData($aBuffer, $iBytes, 0, False)
	Local $tData = DllStructCreate("Byte[" & $iBytes & "]")
	DllStructSetData($tData, 1, $bData)
	$iBytes = _BASS_StreamPutData($hHandle, DllStructGetPtr($tData), $iBytes)
	If @error Then Return SetError(@error, 0, 0)
	If $bRemove And $iBytes Then _BASS_EXT_MemoryBufferGetData($aBuffer, $iBytes, 0, True)
	Return SetError(0, 0, $iBytes)
EndFunc   ;==>_BASS_EXT_StreamPutBufferData

; #FUNCTION# ====================================================================================================================
; Name...........: _BASS_EXT_StreamPutFileBufferData
; Description ...: Puts the bufferdata to a buffered _BASS_StreamCreateFileUser stream
; Syntax.........: _BASS_EXT_StreamPutFileBufferData($hHandle, $aBuffer, $bRemove = True)
; Parameters ....:  -   $hHandle           - The stream handle
;                   -   $aBuffer           - Buffer as returned by _BASS_EXT_MemoryBufferCreate
;                   -   $iBytes            - Number of bytes
;                   -   $bRemove           - If True then the Data is removed from the buffer
; Return values .: Success      - Returns bytes read from buffer
;                  Failure      - Returns 0 and sets @error to 1
; Author ........: Eukalyptus
; Modified.......:
; Remarks .......:
; Related .......: _BASS_EXT_MemoryBufferCreate, _BASS_StreamCreateFileUser, _BASS_StreamPutFileData
; Link ..........;
; Example .......;
; ===============================================================================================================================
Func _BASS_EXT_StreamPutFileBufferData($hHandle, $aBuffer, $iBytes, $bRemove = True)
	If Not IsArray($aBuffer) Then Return SetError(1, 0, 0)
	If Not $hHandle Then Return SetError(1, 0, 0)
	Local $iLength = _BASS_EXT_MemoryBufferGetSize($aBuffer)
	If $iLength < 1 Then Return SetError(0, 1, False)
	If $iBytes > $iLength Then $iBytes = $iLength
	Local $bData = _BASS_EXT_MemoryBufferGetData($aBuffer, $iBytes, 0, False)
	Local $tData = DllStructCreate("Byte[" & $iBytes & "]")
	DllStructSetData($tData, 1, $bData)
	$iBytes = _BASS_StreamPutFileData($hHandle, DllStructGetPtr($tData), $iBytes)
	If @error Then Return SetError(@error, 0, 0)
	If $bRemove And $iBytes Then _BASS_EXT_MemoryBufferGetData($aBuffer, $iBytes, 0, True)
	Return SetError(0, 0, $iBytes)
EndFunc   ;==>_BASS_EXT_StreamPutFileBufferData

; #FUNCTION# ====================================================================================================================
; Name...........: _BASS_EXT_MemoryBufferCreate
; Description ...: Creates a binary buffer
; Syntax.........: _BASS_EXT_MemoryBufferCreate($iSize=10000000)
; Parameters ....:  -	$iSize		-	Size of memory to be use, max 100000000 (~100MB)
; Return values .: Success      - Returns an Array containing all necessary data
;                  Failure      - Returns 0 and sets @error to 1
; Author ........: Eukalyptus
; Modified.......:
; Remarks .......:
; Related .......:
; Link ..........;
; Example .......;
; ===============================================================================================================================
Func _BASS_EXT_MemoryBufferCreate($iSize = 10000000)
	If $iSize > 100000000 Then $iSize = 100000000 ; 100 MB max
	Local $tBuffer = DllStructCreate("dword;dword;byte[" & String($iSize) & "]")
	If @error Then Return SetError(1, 0, 0)
	DllStructSetData($tBuffer, 1, 0)
	DllStructSetData($tBuffer, 2, $iSize)
	Local $tUser = DllStructCreate("UINT_PTR;INT_PTR")
	DllStructSetData($tUser, 1, DllStructGetPtr($tBuffer))
	DllStructSetData($tUser, 2, $BASS_EXT_STRUCT_BYTE)
	Local $aReturn[4]
	$aReturn[0] = DllStructGetPtr($tUser)
	$aReturn[1] = $tUser
	$aReturn[2] = DllStructGetPtr($tBuffer)
	$aReturn[3] = $tBuffer
	Return $aReturn
EndFunc   ;==>_BASS_EXT_MemoryBufferCreate

; #FUNCTION# ====================================================================================================================
; Name...........: _BASS_EXT_MemoryBufferDestroy
; Description ...: Creates a binary buffer
; Syntax.........: _BASS_EXT_MemoryBufferDestroy(ByRef $aBuffer)
; Parameters ....:  -	$aBuffer		-	Buffer as returned by _BASS_EXT_MemoryBufferCreate
; Return values .: Success      - Returns True
;                  Failure      - Returns 0 and sets @error to 1
; Author ........: Eukalyptus
; Modified.......:
; Remarks .......:
; Related .......:
; Link ..........;
; Example .......;
; ===============================================================================================================================
Func _BASS_EXT_MemoryBufferDestroy(ByRef $aBuffer)
	If Not IsArray($aBuffer) Then Return SetError(1, 0, 0)
	$aBuffer[1] = 0
	$aBuffer[3] = 0
	Local $aReturn = 0
	$aBuffer = $aReturn
	Return True
EndFunc   ;==>_BASS_EXT_MemoryBufferDestroy




; #FUNCTION# ====================================================================================================================
; Name...........: _BASS_EXT_ChannelGetWaveform
; Description ...: Returns Waveform of a stream
; Syntax.........: _BASS_EXT_ChannelGetWaveform($handle, $samples, $flag = 3)
; Parameters ....:  -	$handle		-	Handle The channel handle...
;										-	HCHANNEL, HMUSIC, HSTREAM, HRECORD or HSAMPLE handles accepted.
;                   -   $samples    -   number of samples to return (min 32, max 2048)
;                   -   $flag       -   [0]: returns waveform of left channel
;                                       [1]: returns waveform of right channel
;                                       [2]: returns 2 arrays in the return array - see example
;                                       [3]: returns mono waveform left + right
; Return values .: Success      - Returns Array of waveform data.
;									- [0][0] = Number of elements.
;									- [1][0] = Sample 1 X-Value [-1..1]
;									- [1][1] = Sample 1 Y-Value [-1..1]
;                                   - [2][0] = Sample 2 X-Value [-1..1]
;									- [2][1] = Sample 2 Y-Value [-1..1]
;                                   - [n][0] = Sample n X-Value [-1..1]
;									- [n][1] = Sample n Y-Value [-1..1]
;                  Failure      - Returns 0 and sets @ERROR
; Author ........: Eukalyptus
; Modified.......:
; Remarks .......: calculate the coordinates for each sample:
;                                   For $i=1 To $aReturn[0][0]
;                                   	$aReturn[$i][0] = $aReturn[$i][0] * $SizeX + $OffsetX
;                                   	$aReturn[$i][1] = $aReturn[$i][1] * $SizeY + $OffsetY
;                                   Next
;                  and you can use $aReturn directly with:
;                                   _GDIPlus_GraphicsDrawClosedCurve
;                                   _GDIPlus_GraphicsDrawPolygon
;                                   _GDIPlus_GraphicsDrawCurve
;                                   _GDIPlus_GraphicsFillClosedCurve
;                                   _GDIPlus_GraphicsFillPolygon
;                  to draw the waveform
; Related .......:
; Link ..........;
; Example .......;
; ===============================================================================================================================
Func _BASS_EXT_ChannelGetWaveform($handle, $samples, $flag = 3)
	If $samples < 32 Then $samples = 32
	If $samples > 2048 Then $samples = 2048
	Local $tStruct = DllStructCreate("float[" & $samples * 2 & "]")
	If Not $handle Then Return SetError(1, 0, 0)
	Local $bass_ext_ret = DllCall($_ghBassEXTDll, "dword", "_BASS_EXT_ChannelGetWaveform", "dword", $handle, "dword", $samples, "ptr", DllStructGetPtr($tStruct))
	If @error Then
		Return SetError(@error, 0, 0)
	Else
		Switch $flag
			Case 0 ;left
				Local $aReturn[$samples + 1][2]
				$aReturn[0][0] = $samples
				For $i = 1 To $samples
					$aReturn[$i][0] = $i / $samples
					$aReturn[$i][1] = DllStructGetData($tStruct, 1, $i * 2 - 1)
				Next
				Return SetError($bass_ext_ret[0] = False, 0, $aReturn)
			Case 1 ; right
				Local $aReturn[$samples + 1][2]
				$aReturn[0][0] = $samples
				For $i = 1 To $samples
					$aReturn[$i][0] = $i / $samples
					$aReturn[$i][1] = DllStructGetData($tStruct, 1, $i * 2)
				Next
				Return SetError($bass_ext_ret[0] = False, 0, $aReturn)
			Case 2 ; Array in Array
				Local $aReturn[2], $aReturnL[$samples + 1][2], $aReturnR[$samples + 1][2]
				$aReturnL[0][0] = $samples
				$aReturnR[0][0] = $samples
				For $i = 1 To $samples
					$aReturnL[$i][0] = $i / $samples
					$aReturnR[$i][0] = $aReturnL[$i][0]
					$aReturnL[$i][1] = DllStructGetData($tStruct, 1, $i * 2 - 1)
					$aReturnR[$i][1] = DllStructGetData($tStruct, 1, $i * 2)
				Next
				$aReturn[0] = $aReturnL
				$aReturn[1] = $aReturnR
				Return SetError($bass_ext_ret[0] = False, 0, $aReturn)
			Case Else ; mix
				Local $aReturn[$samples + 1][2]
				$aReturn[0][0] = $samples
				For $i = 1 To $samples
					$aReturn[$i][0] = $i / $samples
					$aReturn[$i][1] = (DllStructGetData($tStruct, 1, $i * 2 - 1) + DllStructGetData($tStruct, 1, $i * 2)) / 2
				Next
				Return SetError($bass_ext_ret[0] = False, 0, $aReturn)
		EndSwitch
	EndIf
EndFunc   ;==>_BASS_EXT_ChannelGetWaveform

; #FUNCTION# ====================================================================================================================
; Name...........: _BASS_EXT_ChannelGetWaveformEx
; Description ...: Returns Waveform of a stream
; Syntax.........: _BASS_EXT_ChannelGetWaveformEx($hHandle, $iSamples, $iXLeft, $iYLeft, $iWLeft, $iHLeft, $iXRight, $iYRight, $iWRight, $iHRight)
; Parameters ....:  -	$hHandle     -  Handle The channel handle...
;                                       -  HCHANNEL, HMUSIC, HSTREAM, HRECORD or HSAMPLE handles accepted.
;                   -   $iSamples    -  number of samples to return (min 32, max 2048)
;                   -   $iXLeft      -  X-Coordinate of left waveform
;                   -   $iYLeft      -  Y-Coordinate of left waveform
;                   -   $iWLeft      -  Width of left waveform
;                   -   $iHLeft      -  Height of left waveform
;                   -   $iXRight     -  X-Coordinate of right waveform
;                   -   $iYRight     -  Y-Coordinate of right waveform
;                   -   $iWRight     -  Width of right waveform
;                   -   $iHRight     -  Height of right waveform
; Return values .: Success      - Returns Array of waveform data.
;									- [0] Struct-Pointer of left waveform as used in
;                                           _GDIPlus_GraphicsDrawClosedCurve
;                                           _GDIPlus_GraphicsDrawPolygon
;                                           _GDIPlus_GraphicsDrawCurve
;                                           _GDIPlus_GraphicsFillClosedCurve
;                                           _GDIPlus_GraphicsFillPolygon
;									- [1]  Struct-Pointer of right waveform
;									- [2]  Number of elements in the struct
;                                   - [3]  The left dllstruct
;									- [4]  The right dllstruct
;                  Failure      - Returns 0 and sets @ERROR
; Author ........: Eukalyptus
; Modified.......:
; Remarks .......: You have to call the GDI+ function directly to draw the waveform:
;                  DllCall($ghGDIPDll, "int", "GdipDrawCurveI", "handle", $hGraphics, "handle", $hPenLeft, "ptr", $aWave[0], "int", $aWave[2])
;                  DllCall($ghGDIPDll, "int", "GdipDrawCurveI", "handle", $hGraphics, "handle", $hPenRight, "ptr", $aWave[1], "int", $aWave[2])
;                  this methode is faster than _BASS_EXT_ChannelGetWaveform & _GDIPlus_GraphicsDrawClosedCurve
; Related .......:
; Link ..........;
; Example .......;
; ===============================================================================================================================
Func _BASS_EXT_ChannelGetWaveformEx($hHandle, $iSamples, $iXLeft, $iYLeft, $iWLeft, $iHLeft, $iXRight, $iYRight, $iWRight, $iHRight)
	If $iSamples < 32 Then $iSamples = 32
	If $iSamples > 2048 Then $iSamples = 2048
	Local $tStructL = DllStructCreate("long[" & $iSamples * 2 & "]")
	Local $tStructR = DllStructCreate("long[" & $iSamples * 2 & "]")
	Local $aReturn[5]
	$aReturn[0] = DllStructGetPtr($tStructL)
	$aReturn[1] = DllStructGetPtr($tStructR)
	$aReturn[3] = $tStructL
	$aReturn[4] = $tStructR
	If Not $hHandle Then Return SetError(1, 0, $aReturn)
	Local $bass_ext_ret = DllCall($_ghBassEXTDll, "dword", "_BASS_EXT_ChannelGetWaveformEx", "dword", $hHandle, "dword", $iSamples, "dword", $iXLeft, "dword", $iYLeft, "dword", $iWLeft, "dword", $iHLeft, "dword", $iXRight, "dword", $iYRight, "dword", $iWRight, "dword", $iHRight, "ptr", $aReturn[0], "ptr", $aReturn[1])
	If @error Or Not IsArray($bass_ext_ret) Then Return SetError(1, 1, $aReturn)
	$aReturn[2] = $bass_ext_ret[0]
	Return $aReturn
EndFunc   ;==>_BASS_EXT_ChannelGetWaveformEx

; #FUNCTION# ====================================================================================================================
; Name...........: _BASS_EXT_ChannelGetPhaseData
; Description ...: Retrieves phase data of a stream, MOD music or recording channel.
; Syntax.........: _BASS_EXT_ChannelGetPhaseData($handle, $samples)
; Parameters ....:  -	$handle		-	Handle The channel handle...
;										-	HCHANNEL, HMUSIC, HSTREAM, HRECORD or HSAMPLE handles accepted.
;                   -   $samples    -   number of samples to return (min 32, max 2048)
; Return values .: Success      - Returns Array of Phase information.
;									- [0][0] = Number of elements.
;									- [0][1] = phase correlation [-1..1] of max peak
;									- [1][0] = Sample 1 Vectorscope X-Value [-1..1]
;									- [1][1] = Sample 1 Vectorscope Y-Value [-1..1]
;                                   - [2][0] = Sample 2 Vectorscope X-Value [-1..1]
;									- [2][1] = Sample 2 Vectorscope Y-Value [-1..1]
;                                   - [n][0] = Sample n Vectorscope X-Value [-1..1]
;									- [n][1] = Sample n Vectorscope Y-Value [-1..1]
;                  Failure      - Returns empty array and sets @ERROR
; Author ........: Eukalyptus
; Modified.......:
; Remarks .......: calculate the coordinates for each sample:
;                                   For $i=1 To $aReturn[0][0]
;                                   	$aReturn[$i][0] = $aReturn[$i][0] * $SizeX + $OffsetX
;                                   	$aReturn[$i][1] = $aReturn[$i][1] * $SizeY + $OffsetY
;                                   Next
;                  and you can use $aReturn directly with:
;                                   _GDIPlus_GraphicsDrawClosedCurve
;                                   _GDIPlus_GraphicsDrawPolygon
;                                   _GDIPlus_GraphicsDrawCurve
;                                   _GDIPlus_GraphicsFillClosedCurve
;                                   _GDIPlus_GraphicsFillPolygon
;                  to draw the vectorscope
; Related .......:
; Link ..........;
; Example .......;
; ===============================================================================================================================
Func _BASS_EXT_ChannelGetPhaseData($handle, $samples)
	If $samples < 32 Then $samples = 32
	If $samples > 2048 Then $samples = 2048
	Local $tStruct = DllStructCreate("float[" & $samples + 1 & "];float[" & $samples + 1 & "]")
	Local $aReturn[$samples + 2][2]
	$aReturn[0][0] = $samples
	If Not $handle Then Return SetError(1, 0, $aReturn)
	Local $bass_ext_ret = DllCall($_ghBassEXTDll, "dword", "_BASS_EXT_ChannelGetPhaseData", "dword", $handle, "dword", $samples, "ptr", DllStructGetPtr($tStruct))
	If @error Then
		Return SetError(@error, 0, $aReturn)
	Else
		For $i = 1 To $samples + 1
			$aReturn[$i - 1][0] = DllStructGetData($tStruct, 1, $i)
			$aReturn[$i - 1][1] = DllStructGetData($tStruct, 2, $i)
		Next
		Return SetError($bass_ext_ret[0] = False, 0, $aReturn)
	EndIf
EndFunc   ;==>_BASS_EXT_ChannelGetPhaseData

; #FUNCTION# ====================================================================================================================
; Name...........: _BASS_EXT_ChannelGetPhaseDataEx
; Description ...: Returns phase data of a stream, MOD music or recording channel to draw a vectorscope using GDI+
; Syntax.........: _BASS_EXT_ChannelGetPhaseDataEx($hHandle, $iSamples, $iX, $iY, $iW, $iH)
; Parameters ....:  -	$hHandle		-	Handle The channel handle...
;											HCHANNEL, HMUSIC, HSTREAM, HRECORD or HSAMPLE handles accepted.
;                   -   $iSamples       -   number of samples to return (min 32, max 2048)
;                   -   $iX             -   X-Coordinate of the waveform
;                   -   $iY             -   Y-Coordinate of the waveform
;                   -   $iW             -   Width of the waveform
;                   -   $iH             -   Height of the waveform
; Return values .: Success      - Returns Array of Phase information.
;                                   - [0] Struct-Pointer as used in
;                                           _GDIPlus_GraphicsDrawClosedCurve
;                                           _GDIPlus_GraphicsDrawPolygon
;                                           _GDIPlus_GraphicsDrawCurve
;                                           _GDIPlus_GraphicsFillClosedCurve
;                                           _GDIPlus_GraphicsFillPolygon
;                                   - [1] Number of elements in the struct
;                                   - [2] The dllstruct itself (must be returned, otherwise the struct will be deleted by AutoIt)
;                  Failure      - Returns empty array and sets @ERROR
; Author ........: Eukalyptus
; Modified.......:
; Remarks .......: You have to call the GDI+ function directly to draw the vectorscope:
;                  DllCall($ghGDIPDll, "int", "GdipDrawCurveI", "handle", $hGraphics, "handle", $hPen, "ptr", $aPhase[0], "int", $aPhase[1])
;                  this methode is faster than _BASS_EXT_ChannelGetPhaseData & _GDIPlus_GraphicsDrawClosedCurve
; Related .......:
; Link ..........;
; Example .......;
; ===============================================================================================================================
Func _BASS_EXT_ChannelGetPhaseDataEx($hHandle, $iSamples, $iX, $iY, $iW, $iH)
	If $iSamples < 32 Then $iSamples = 32
	If $iSamples > 2048 Then $iSamples = 2048
	Local $tStruct = DllStructCreate("long[" & $iSamples * 2 & "]")
	Local $aReturn[3]
	$aReturn[0] = DllStructGetPtr($tStruct)
	$aReturn[2] = $tStruct
	If Not $hHandle Then Return SetError(1, 0, $aReturn)
	Local $bass_ext_ret = DllCall($_ghBassEXTDll, "dword", "_BASS_EXT_ChannelGetPhaseDataEx", "dword", $hHandle, "dword", $iSamples, "dword", $iX, "dword", $iY, "dword", $iW, "dword", $iH, "ptr", $aReturn[0])
	If @error Then Return SetError(@error, 0, $aReturn)
	$aReturn[1] = $bass_ext_ret[0]
	Return $aReturn
EndFunc   ;==>_BASS_EXT_ChannelGetPhaseDataEx

; #FUNCTION# ====================================================================================================================
; Name...........: _BASS_EXT_CreateFFT
; Description ...: Creates a struct to draw a polyline with GDI+
; Syntax.........: _BASS_EXT_CreateFFT($iCnt, $iX, $iY, $iW, $iH, $iDistance = 1, $iLogMin = 90, $bMode = False)
; Parameters ....:  -   $iCnt           -   number of bands
;                   -   $iX             -   X position
;                   -   $iY             -   Y position
;                   -   $iW             -   Width
;                   -   $iH             -   Height
;                   -   $iDistance      -   Distance between the bars
;                   -   $iLogMin        -   Minimum level to display
;                                               = 0  : level is shown linear
;                                               <> 0 : level is shown logarithmic where all values lower -$iLogMin (in decibels) are cutted
;                   -   $bMode          -   False : the band frequencies are logarithmic, but if you use to much bands, the frequencies may overlap
;                                           True : no overlapping of frequencies, but not exact logarithmic
; Return values .: Success      - Returns Array to use with _BASS_EXT_ChannelGetFFT
;                  Failure      - Returns 0
; Author ........: Eukalyptus
; Modified.......:
; Remarks .......:
; Related .......: _BASS_EXT_ChannelGetFFT
; Link ..........;
; Example .......;
; ===============================================================================================================================
Func _BASS_EXT_CreateFFT($iCnt, $iX, $iY, $iW, $iH, $iDistance = 1, $iLogMin = 90, $bMode = False)
	Local $aReturn[8]
	Local $iXPos, $nBarW = ($iW / $iCnt) - $iDistance
	Local $tStruct = DllStructCreate("long[" & $iCnt * 8 & "]")
	For $i = 1 To $iCnt
		$iXPos = Round(($nBarW * ($i - 1)) + ($iDistance * ($i - 1)) + $iX)
		DllStructSetData($tStruct, 1, $iXPos, ($i - 1) * 8 + 1) ; X1
		DllStructSetData($tStruct, 1, $iY + $iH, ($i - 1) * 8 + 2) ; Y1
		DllStructSetData($tStruct, 1, $iXPos, ($i - 1) * 8 + 3) ; X2
		DllStructSetData($tStruct, 1, $iY, ($i - 1) * 8 + 4) ; Y2
		DllStructSetData($tStruct, 1, Round($iXPos + $nBarW), ($i - 1) * 8 + 5) ; X3
		DllStructSetData($tStruct, 1, $iY, ($i - 1) * 8 + 6) ; Y3
		DllStructSetData($tStruct, 1, Round($iXPos + $nBarW), ($i - 1) * 8 + 7) ; X4
		DllStructSetData($tStruct, 1, $iY + $iH, ($i - 1) * 8 + 8) ; Y4
	Next
	$aReturn[0] = DllStructGetPtr($tStruct)
	$aReturn[1] = $iCnt * 4
	$aReturn[2] = $tStruct
	$aReturn[3] = $iCnt
	$aReturn[4] = $iY
	$aReturn[5] = $iH
	$aReturn[6] = $iLogMin
	$aReturn[7] = $bMode
	Return $aReturn
EndFunc   ;==>_BASS_EXT_CreateFFT

; #FUNCTION# ====================================================================================================================
; Name...........: _BASS_EXT_ChannelGetFFT
; Description ...: Gets FFT data of a channel and sets the bands in the FFT struct for use with GDI+
; Syntax.........: _BASS_EXT_ChannelGetFFT($hHandle, $aFFT, $iFallOff = 6)
; Parameters ....:  -   $hHandle        -   Handle The channel handle...
;                                             -   HCHANNEL, HMUSIC, HSTREAM, HRECORD or HSAMPLE handles accepted.
;                   -   $aFFT           -   Array as returned by _BASS_EXT_CreateFFT
;                   -   $iFallOff       -   Falloff of the bands ((old - new) / $iFallOff)
; Return values .: Success      - Returns True
;                  Failure      - Returns 0
; Author ........: Eukalyptus
; Modified.......:
; Remarks .......: DllCall($ghGDIPDll, "int", "GdipFillPolygonI", "handle", $hGraphics, "handle", $hBrushFFT, "ptr", $aFFT[0], "int", $aFFT[1], "int", "FillModeAlternate")
; Related .......: _BASS_EXT_CreateFFT
; Link ..........;
; Example .......;
; ===============================================================================================================================
Func _BASS_EXT_ChannelGetFFT($hHandle, $aFFT, $iFallOff = 6)
	If Not IsArray($aFFT) Or UBound($aFFT) <> 8 Or Not IsDllStruct($aFFT[2]) Or Not $hHandle Then Return SetError(1, 0, 0)
	Local $bass_ext_ret = DllCall($_ghBassEXTDll, "bool", "_BASS_EXT_ChannelGetFFT", "dword", $hHandle, "dword", $aFFT[3], "dword", $aFFT[4], "dword", $aFFT[5], "dword", $aFFT[6], "dword", $iFallOff, "bool", $aFFT[7], "ptr", $aFFT[0])
	If @error Then Return SetError(@error, 0, 0)
	Return $bass_ext_ret[0]
EndFunc   ;==>_BASS_EXT_ChannelGetFFT

; #FUNCTION# ====================================================================================================================
; Name...........: _BASS_EXT_ChannelSetMaxPeakDsp
; Description ...: Sets a dsp-callback on the channel that looks over the channel´s sample data and find the highest peak
; Syntax.........: _BASS_EXT_ChannelSetMaxPeakDsp($handle, $priority = 10)
; Parameters ....:  -	$handle		-	Handle The channel handle...
;										-	HCHANNEL, HMUSIC, HSTREAM, HRECORD or HSAMPLE handles accepted.
;                   -   $priority   -   The priority of the new DSP, which determines its position in the DSP chain. DSPs with higher priority are called before those with lower.
; Return values .: Success      - Returns an Array containing all necessary data
;                  Failure      - Returns 0 and sets @error to 1
; Author ........: Eukalyptus
; Modified.......:
; Remarks .......: DllCall($ghGDIPDll, "int", "GdipFillPolygonI", "handle", $hGraphics, "handle", $hBrushFFT, "ptr", $aFFT[0], "int", $aFFT[1], "int", "FillModeAlternate")
; Related .......: _BASS_EXT_ChannelGetMaxPeak, _BASS_EXT_ChannelRemoveMaxPeakDsp
; Link ..........;
; Example .......;
; ===============================================================================================================================
Func _BASS_EXT_ChannelSetMaxPeakDsp($handle, $priority = 10)
	Local $tStruct = DllStructCreate("double;double;double;double")
	Local $hDsp = _BASS_ChannelSetDSP($handle, $BASS_EXT_DspPeakProc, DllStructGetPtr($tStruct), $priority)
	Switch @error
		Case True
			Return SetError(1, 0, 0)
		Case Else
			Local $aReturn[3]
			$aReturn[0] = $tStruct
			$aReturn[1] = $hDsp
			$aReturn[2] = $handle
			Return SetError(0, 0, $aReturn)
	EndSwitch
EndFunc   ;==>_BASS_EXT_ChannelSetMaxPeakDsp

; #FUNCTION# ====================================================================================================================
; Name...........: _BASS_EXT_ChannelGetMaxPeak
; Description ...: Returns the highes peak value found in the channel´s sample data
; Syntax.........: _BASS_EXT_ChannelGetMaxPeak($aPeak, $iMode = 2, $bReset = False)
; Parameters ....:  -	$aPeak		-	the variant as returned by _BASS_EXT_ChannelSetMaxPeakDsp
;                   -   $iMode      -   0: returns peak of left channel
;                                       1: returns peak of right channel
;                                       2: returns array: [0] = left, [1] = right
;                   -   $bReset     -   If True then the peak value is set to zero before next buffer update
; Return values .: Success      - Returns max peak
;                  Failure      -
; Author ........: Eukalyptus
; Modified.......:
; Remarks .......: the peak check is not performed in realtime - it depends on the buffersize
; Related .......: _BASS_EXT_ChannelSetMaxPeakDsp, _BASS_EXT_ChannelRemoveMaxPeakDsp
; Link ..........;
; Example .......;
; ===============================================================================================================================
Func _BASS_EXT_ChannelGetMaxPeak($aPeak, $iMode = 2, $bReset = False)
	If Not IsArray($aPeak) Or Not IsDllStruct($aPeak[0]) Then Return SetError(1, 0, 0)
	Switch $iMode
		Case 0 ; left
			Local $Left = DllStructGetData($aPeak[0], 1)
			If $bReset Then DllStructSetData($aPeak[0], 3, 2)
			Return $Left
		Case 1 ; right
			Local $Right = DllStructGetData($aPeak[0], 2)
			If $bReset Then DllStructSetData($aPeak[0], 4, 2)
			Return $Right
		Case Else ; both
			Local $aReturn[2]
			$aReturn[0] = DllStructGetData($aPeak[0], 1)
			$aReturn[1] = DllStructGetData($aPeak[0], 2)
			If $bReset Then
				DllStructSetData($aPeak[0], 3, 2)
				DllStructSetData($aPeak[0], 4, 2)
			EndIf
			Return $aReturn
	EndSwitch
EndFunc   ;==>_BASS_EXT_ChannelGetMaxPeak

; #FUNCTION# ====================================================================================================================
; Name...........: _BASS_EXT_ChannelRemoveMaxPeakDsp
; Description ...: Removes the dsp-callback from the channel
; Syntax.........: _BASS_EXT_ChannelRemoveMaxPeakDsp($aPeak, $handle = 0)
; Parameters ....:  -	$aPeak		-	the variant as returned by _BASS_EXT_ChannelSetMaxPeakDsp
;                   -   $handle     -   optional: The channel handle the dsp is to be removed from, IF the handle has changed since _BASS_EXT_ChannelSetMaxPeakDsp
; Return values .: Success      - Returns True
;                  Failure      - Returns 0 and sets @error to 1
; Author ........: Eukalyptus
; Modified.......:
; Remarks .......:
; Related .......: _BASS_EXT_ChannelSetMaxPeakDsp, _BASS_EXT_ChannelGetMaxPeak
; Link ..........;
; Example .......;
; ===============================================================================================================================
Func _BASS_EXT_ChannelRemoveMaxPeakDsp($aPeak, $handle = 0)
	If Not IsArray($aPeak) Then Return SetError(1, 0, 0)
	$aPeak[0] = 0
	Local $hHandle = $handle
	If Not $hHandle Then $hHandle = $aPeak[2]
	Local $aRet = _BASS_ChannelRemoveDSP($hHandle, $aPeak[1])
	Switch @error
		Case True
			Return SetError(1, 1, 0)
		Case Else
			Return SetError(0, 0, $aRet)
	EndSwitch
EndFunc   ;==>_BASS_EXT_ChannelRemoveMaxPeakDsp

; #FUNCTION# ====================================================================================================================
; Name...........: _BASS_EXT_ChannelGetRMSLevel
; Description ...: Retrieves the level (RMS/VU amplitude) of a stream, MOD music or recording channel.
; Syntax.........: _BASS_EXT_ChannelGetRMSLevel($handle, $window)
; Parameters ....:  -	$handle		-	Handle The channel handle...
;										-	HCHANNEL, HMUSIC, HSTREAM, HRECORD or HSAMPLE handles accepted.
;                   -   $window     -   time window to calculate the average RMS
; Return values .: Success      - Returns the amplitude.
;									- Level of the left channel is returned in the low word (low 16-bits)
;									- Level of the right channel is returned in the high word (high 16-bits)
;									- If the channel is mono, then the low word is duplicated in the high word.
;									- The level ranges linearly from 0 (silent) to 32768 (max)
;                  Failure      - Returns 0
; Author ........: Eukalyptus
; Modified.......:
; Remarks .......:
; Related .......:
; Link ..........;
; Example .......;
; ===============================================================================================================================
Func _BASS_EXT_ChannelGetRMSLevel($handle, $window = 0.03)
	Local $bass_ext_ret = DllCall($_ghBassEXTDll, "DWORD", "_BASS_EXT_ChannelGetRMSLevel", "DWORD", $handle, "float", $window)
	If @error Then Return SetError(1, 1, 0)
	Return $bass_ext_ret[0]
EndFunc   ;==>_BASS_EXT_ChannelGetRMSLevel

; #FUNCTION# ====================================================================================================================
; Name...........: Func _BASS_EXT_Level2dB()
; Description ...: Returns level as dB
; Syntax.........: Func _BASS_EXT_Level2dB($level, $mode = 0)
; Parameters ....:  -	$level  				-	linear level as returned by _BASS_ChannelGetLevel()
;					-	$mode                       0    : returns dB [-1024 to 0]
;                                                   else : returns db [0 to 1]
;                                                          $mode defines lowest dB value:
;                                                          for example: $mode=30: value lower -30db = zero, value greater -30dB = [0 to 1]
;                                                                       $mode=60: value lower -60db = zero, value greater -60dB = [0 to 1]
; Return values .: Success      - If successful, then the level as dB is returned
;                  Failure      - Returns 0
; Author ........: Eukalyptus
; Modified.......:
; Remarks .......: if $mode is set, all values lower -$mode dB are lost; use only to draw a levelmeter
; Related .......:
; Link ..........;
; Example .......;
; ===============================================================================================================================
Func _BASS_EXT_Level2dB($level, $mode = 0)
	If $level <= 0 Then Return -1024
	If $level > 1 Then $level /= 32768
	Local $Return = 20 * Log($level) / Log(10)
	If $Return < -1024 Then $Return = -1024
	If $Return > 0 Then $Return = 0
	If $mode Then
		$Return += $mode
		If $Return < 0 Then $Return = 0
		$Return /= $mode
		If $Return < 0 Then $Return = 0
		If $Return > 1 Then $Return = 1
	EndIf
	Return $Return
EndFunc   ;==>_BASS_EXT_Level2dB

; #FUNCTION# ====================================================================================================================
; Name...........: Func _BASS_EXT_dB2Level()
; Description ...: Returns dB as linear level
; Syntax.........: Func _BASS_EXT_dB2Level($dB, $mode = 0)
; Parameters ....:  -	$dB  				    -	decibel level as returned by _BASS_EXT_Level2dB / $mode 0
; Return values .: Success      - If successful, then the linear level is returned as floating point value
;                  Failure      - Returns 0
; Author ........: Eukalyptus
; Modified.......:
; Remarks .......:
; Related .......:
; Link ..........;
; Example .......;
; ===============================================================================================================================
Func _BASS_EXT_dB2Level($dB)
	Return 10 ^ ($dB / 20)
EndFunc   ;==>_BASS_EXT_dB2Level











; #FUNCTION# ====================================================================================================================
; Name...........: __BASS_EXT_GetCallBackPointer
; Author ........: Eukalyptus
; ===============================================================================================================================
Func __BASS_EXT_GetCallBackPointer($iCBFunc = 0)
	Switch $iCBFunc
		Case 1 To 11
			Local $aResult = DllCall($_ghBassEXTDll, "ptr", "_BASS_EXT_GetCallBackPointer", "dword", $iCBFunc)
			If @error Then Return SetError(1, 0, 0)
			Return $aResult[0]
	EndSwitch
	Return 0
EndFunc   ;==>__BASS_EXT_GetCallBackPointer

; #SignalFlow# ===================================================================================================================
; Signalflow description
; ===============================================================================================================================
; AsioProc:
;
;
;
;