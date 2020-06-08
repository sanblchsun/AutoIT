#Region Header

#cs

	Title:			Access to Resources UDF Library for AutoIt3
	Filename:		Resources.au3
	Description:	Allows you to obtain resources from EXE or DLL files and use them in the script
	Author:			Zedna (modified by Yashied)
	Version:		1.1
	Requirements:	AutoIt v3.3 +, Developed/Tested on WindowsXP Pro Service Pack 2
	Uses:			Constants.au3, GDIPlus.au3, Memory.au3, SendMessage.au3, StaticConstants.au3, WinAPI.au3
	Notes:			This library works only with the "RCData" resource type (except _ResGetRes()). Access to other
					types of resources you can get by using the respective functions of WinAPI.au3 library.

					Original Resources.au3 library can be found at the following link
					http://www.autoitscript.com/forum/index.php?showtopic=51103

	Available functions:

	_ResGetRes
	_ResGetAsBytes
	_ResGetAsImage
	_ResGetAsString
	_ResGetAsStringW
	_ResSetImageToCtrl
	_ResSaveToFile

	Additional features:

	(The following three functions work with the "Bitmap" resource type)

	_ResGetBitmap
	_ResSetBitmapToCtrl
	_ResSaveBitmapToFile

	_ResPlaySound

	Example:

		#Include <Resources.au3>

		Global $Button, $Msg, $Pic

		GUICreate('Example', 413, 121)

		$Pic = GUICtrlCreatePic('', 0, 0, 413, 72)
		$Button = GUICtrlCreateButton(_ResGetAsString('#202', 'resources.dll'), 156, 86, 92, 23)
		_ResSetImageToCtrl($Pic, '#201', 'resources.dll')

		GUISetState()

		While 1
			$Msg = GUIGetMsg()
			Select
				Case $Msg = -3
					Exit
				Case $Msg = $Button
					_ResPlaySound('#401', $SND_SYNC, 'resources.dll')
			EndSelect
		WEnd

#ce

#Include-once

#Include <Constants.au3>
#Include <GDIPlus.au3>
#Include <Memory.au3>
#Include <SendMessage.au3>
#Include <StaticConstants.au3>
#Include <WinAPI.au3>

#EndRegion Header

#Region Global Variables and Constants

; _ResGetRes()

Global Const $RT_ACCELERATOR = 9
Global Const $RT_ANICURSOR = 21
Global Const $RT_ANIICON = 22
Global Const $RT_BITMAP = 2
Global Const $RT_CURSOR = 1
Global Const $RT_DIALOG = 5
Global Const $RT_DLGINCLUDE = 17
Global Const $RT_FONT = 8
Global Const $RT_FONTDIR = 7
Global Const $RT_GROUP_CURSOR = 12
Global Const $RT_GROUP_ICON = 14
Global Const $RT_HTML = 23
Global Const $RT_ICON = 3
Global Const $RT_MANIFEST = 24
Global Const $RT_MENU = 4
Global Const $RT_MESSAGETABLE = 11
Global Const $RT_PLUGPLAY = 19
Global Const $RT_RCDATA = 10
Global Const $RT_STRING = 6
Global Const $RT_VERSION = 16
Global Const $RT_VXD = 20

; _ResPlaySound()

Global Const $SND_ASYNC = 0x0001
Global Const $SND_LOOP = 0x0008
Global Const $SND_MEMORY = 0x0004
Global Const $SND_NOSTOP = 0x0010
Global Const $SND_NOWAIT = 0x2000
Global Const $SND_SYNC = 0x0000

#EndRegion Global Variables and Constants

#Region Public Functions

; #FUNCTION# ========================================================================================================================
; Function Name:	_ResGetRes
; Description:		Loads a specified resource in memory.
; Syntax:			_ResGetRes ( $sResName [, $nResType [, $nResLang [, $Dll]]] )
; Parameter(s):		$sResName - The name of the resource, which must be obtained (string value). If you are accessing the resource at
;								the number, you should put a "#" before the name, eg "#100".
;
;					$nResType - [optional] Specifies the resource type. Default is $RT_RCDATA (10).
;					$nResLang - [optional] Specifies the language of the resource (see MSDN library for more information). Default is not specified (0).
;					$Dll      - [optional] The name of file containing the resources. Default is running script (-1).
;
; Return Value(s):	Success: The handle to the allocated memory object containing the specified resource. Also, @extended flag will contain
;							 the amount of allocated memory (in bytes) for this recource. When the resource will no longer need you can free the
;							 memory using _MemGlobalFree().
;
;					Failure: Returns 0 and sets the @error flag to non-zero.
; Author(s):		Zedna (modified by Yashied)
;
; Note(s):			This function is in most cases is intended for internal use. To work with resources better to use other
;					functions from this library, eg _ResGetAsBytes().
;====================================================================================================================================

Func _ResGetRes($sResName, $nResType = 10, $nResLang = 0, $Dll = -1)

	Local $hInstance, $hInfo, $hData, $pData, $hRes, $pRes, $nSize

	If StringStripWS($sResName, 3) = '' Then
		Return SetError(1, 0, 0)
	EndIf

	If $Dll = -1 Then
		$hInstance = _WinAPI_GetModuleHandle('')
	Else
		$hInstance = _WinAPI_LoadLibrary($Dll)
	EndIf
	If $hInstance = 0 Then
		Return SetError(1, 0, 0)
	EndIf
	If $nResLang = 0 Then
		$hInfo = DllCall('kernel32.dll', 'int', 'FindResource', 'int', $hInstance, 'str', $sResName, 'long', $nResType)
	Else
		$hInfo = DllCall('kernel32.dll', 'int', 'FindResourceEx', 'int', $hInstance, 'long', $nResType, 'str', $sResName, 'short', $nResLang)
	EndIf
	If (@error) Or ($hInfo[0] = 0) Then
		If $Dll <> -1 Then
			_WinAPI_FreeLibrary($hInstance)
		EndIf
		Return SetError(1, 0, 0)
	EndIf
	$hInfo = $hInfo[0]
	$nSize = DllCall('kernel32.dll', 'dword', 'SizeofResource', 'int', $hInstance, 'int', $hInfo)
	If (@error) Or ($nSize[0] = 0) Then
		If $Dll <> -1 Then
			_WinAPI_FreeLibrary($hInstance)
		EndIf
		Return SetError(1, 0, 0)
	EndIf
	$nSize = $nSize[0]
	$hData = DllCall('kernel32.dll', 'int', 'LoadResource', 'int', $hInstance, 'int', $hInfo)
	If (@error) Or ($hData[0] = 0) Then
		If $Dll <> -1 Then
			_WinAPI_FreeLibrary($hInstance)
		EndIf
		Return SetError(1, 0, 0)
	EndIf
	$hData = $hData[0]
	$pData = DllCall('kernel32.dll', 'int', 'LockResource', 'int', $hData)
	If (@error) Or ($pData[0] = 0) Then
		If $Dll <> -1 Then
			_WinAPI_FreeLibrary($hInstance)
		EndIf
		Return SetError(1, 0, 0)
	EndIf
	$pData = $pData[0]
	$hRes = _MemGlobalAlloc($nSize, 2)
	$pRes = _MemGlobalLock($hRes)
	_MemMoveMemory($pData, $pRes, $nSize)
	_MemGlobalUnlock($hRes)
	DllCall('kernel32.dll', 'int', 'FreeResource', 'int', $hData)
	If $Dll <> -1 Then
		_WinAPI_FreeLibrary($hInstance)
	EndIf

	Return SetError(0, $nSize, $hRes)
EndFunc   ;==>_ResGetRes

; #FUNCTION# ========================================================================================================================
; Function Name:	_ResGetAsBytes
; Description:		Loads a specified resource as binary data.
; Syntax:			_ResGetAsBytes ( $sResName [, $Dll] )
; Parameter(s):		$sResName - The name of the resource, which must be obtained (string value).
;					$Dll      - [optional] The name of file containing the resources. Default is running script (-1).
;
; Return Value(s):	Success: Returns "byte[]" structure with the loaded binary data. To release allocated memory set the
;							 returned variable to 0.
;
;					Failure: Returns 0 and sets the @error flag to non-zero.
; Author(s):		Zedna (modified by Yashied)
; Note(s):			This function works only with the "RCData" resource type.
;====================================================================================================================================

Func _ResGetAsBytes($sResName, $Dll = -1)

	Local $hRes, $pRes, $tRes, $tRet, $nSize

	$hRes = _ResGetRes($sResName, $RT_RCDATA, 0, $Dll)
	If @error Then
		Return SetError(1, 0, '')
	EndIf
	$nSize = @extended
	$pRes = _MemGlobalLock($hRes)
	$tRes = DllStructCreate('byte[' & $nSize & ']', $pRes)
	$tRet = DllStructCreate('byte[' & $nSize & ']')
	DllStructSetData($tRet, 1, DllStructGetData($tRes, 1))

	_MemGlobalFree($hRes)

	Return $tRet
EndFunc   ;==>_ResGetAsBytes

; #FUNCTION# ========================================================================================================================
; Function Name:	_ResGetAsImage
; Description:		Loads a specified resource as image.
; Syntax:			_ResGetAsImage ( $sResName [, $Dll] )
; Parameter(s):		$sResName - The name of the resource, which must be obtained (string value).
;					$Dll      - [optional] The name of file containing the resources. Default is running script (-1).
;
; Return Value(s):	Success: The handle of the loaded image. To release an image object using _GDIPlus_ImageDispose().
;					Failure: Returns 0 and sets the @error flag to non-zero.
; Author(s):		Zedna (modified by Yashied)
; Note(s):			This function works only with the "RCData" resource type.
;====================================================================================================================================

Func _ResGetAsImage($sResName, $Dll = -1)

	Local $hRes, $hStream, $hImage

	$hRes = _ResGetRes($sResName, $RT_RCDATA, 0, $Dll)
	If @error Then
		Return SetError(1, 0, 0)
	EndIf
	
	_GDIPlus_Startup()
	
	$hStream = DllCall('ole32.dll', 'int', 'CreateStreamOnHGlobal', 'int', $hRes, 'long', 1, 'int*', 0)
	$hStream = $hStream[3]
	$hImage = DllCall($ghGDIPDll, 'int', 'GdipCreateBitmapFromStream', 'ptr', $hStream, 'int*', 0)
	$hImage = $hImage[2]
	
	_GDIPlus_Shutdown()

	_WinAPI_DeleteObject($hStream)

;	_MemGlobalFree($hRes)

	Return $hImage
EndFunc   ;==>_ResGetAsImage

; #FUNCTION# ========================================================================================================================
; Function Name:	_ResGetAsString
; Description:		Loads a specified resource as ANSI string.
; Syntax:			_ResGetAsString ( $sResName [, $Dll] )
; Parameter(s):		$sResName - The name of the resource, which must be obtained (string value).
;					$Dll      - [optional] The name of file containing the resources. Default is running script (-1).
;
; Return Value(s):	Success: The loaded string.
;					Failure: Returns "" and sets the @error flag to non-zero.
; Author(s):		Zedna (modified by Yashied)
; Note(s):			This function works only with the "RCData" resource type.
;====================================================================================================================================

Func _ResGetAsString($sResName, $Dll = -1)

	Local $hRes, $pRes, $nSize, $tStruct, $sStr

	$hRes = _ResGetRes($sResName, $RT_RCDATA, 0, $Dll)
	If @error Then
		Return SetError(1, 0, '')
	EndIf
	$nSize = @extended
	$pRes = _MemGlobalLock($hRes)
	$tStruct = DllStructCreate('char[' & $nSize & ']', $pRes)
	$sStr = DllStructGetData($tStruct, 1)

	_MemGlobalFree($hRes)

	Return $sStr
EndFunc   ;==>_ResGetAsString

; #FUNCTION# ========================================================================================================================
; Function Name:	_ResGetAsStringW
; Description:		Loads a specified resource as UNICODE wide character string.
; Syntax:			_ResGetAsStringW ( $sResName [, $Dll] )
; Parameter(s):		$sResName - The name of the resource, which must be obtained (string value).
;					$Dll      - [optional] The name of file containing the resources. Default is running script (-1).
;
; Return Value(s):	Success: The loaded string.
;					Failure: Returns "" and sets the @error flag to non-zero.
; Author(s):		Zedna (modified by Yashied)
; Note(s):			This function works only with the "RCData" resource type.
;====================================================================================================================================

Func _ResGetAsStringW($sResName, $Dll = -1)

	Local $hRes, $pRes, $nSize, $tStruct, $sStr

	$hRes = _ResGetRes($sResName, $RT_RCDATA, 0, $Dll)
	If @error Then
		Return SetError(1, 0, '')
	EndIf
	$nSize = @extended
	$pRes = _MemGlobalLock($hRes)
	$tStruct = DllStructCreate('wchar[' & $nSize & ']', $pRes)
	$sStr = DllStructGetData($tStruct, 1)

	_MemGlobalFree($hRes)

	Return $sStr
EndFunc   ;==>_ResGetAsStringW

; #FUNCTION# ========================================================================================================================
; Function Name:	_ResSetImageToCtrl
; Description:		Loads a specified resource as an image in the control.
; Syntax:			_ResSetImageToCtrl ( $controlID, $sResName [, $Dll] )
; Parameter(s):		$controlID - The control identifier (controlID) as returned by a GUICtrlCreatePic() function.
;					$sResName  - The name of the resource, which must be obtained (string value).
;					$Dll       - [optional] The name of file containing the resources. Default is running script (-1).
;
; Return Value(s):	Success: Returns 1.
;					Failure: Returns 0 and sets the @error flag to non-zero.
; Author(s):		Zedna (modified by Yashied)
; Note(s):			This function works only with the "RCData" resource type.
;====================================================================================================================================

Func _ResSetImageToCtrl($controlID, $sResName, $Dll = -1)

	Local $hImage, $hBitmap

	_GDIPlus_Startup()
	
	$hImage = _ResGetAsImage($sResName, $Dll)
	If @error Then
		_GDIPlus_Shutdown()
		Return SetError(1, 0, 0)
	EndIf
	$hBitmap = _GDIPlus_BitmapCreateHBITMAPFromBitmap($hImage)
	_GDIPlus_ImageDispose($hImage)

	_GDIPlus_Shutdown()

	_SetBitmapToCtrl($controlID, $hBitmap)
	If @error Then
		_WinAPI_DeleteObject($hBitmap)
		Return SetError(1, 0, 0)
	EndIf

	Return 1
EndFunc   ;==>_ResSetImageToCtrl

; #FUNCTION# ========================================================================================================================
; Function Name:	_ResSaveToFile
; Description:		Saves a specified resource in the file.
; Syntax:			_ResSaveToFile ( $sFileName, $sResName [, $Dll] )
; Parameter(s):		$sFileName - The name of file in which you want to save the resource.
;					$sResName  - The name of the resource, which must be obtained (string value).
;					$Dll       - [optional] The name of file containing the resources. Default is running script (-1).
;
; Return Value(s):	Success: Returns 1 and @extended flag will contain the size of saved file (in bytes).
;					Failure: Returns 0 and sets the @error flag to non-zero.
; Author(s):		Zedna (modified by Yashied)
; Note(s):			This function works only with the "RCData" resource type.
;====================================================================================================================================

Func _ResSaveToFile($sFileName, $sResName, $Dll = -1)

	Local $tRes, $nSize, $nByte, $hFile

	$tRes = _ResGetAsBytes($sResName, $Dll)
	If @error Then
		Return SetError(1, 0, 0)
	EndIf
	$nSize = DllStructGetSize($tRes)
	$hFile = _WinAPI_CreateFile($sFileName, 1)
	If $hFile = 0 Then
		Return SetError(1, 0, 0)
	EndIf
	_WinAPI_WriteFile($hFile, DllStructGetPtr($tRes), $nSize, $nByte)
	_WinAPI_CloseHandle($hFile)

	Return SetError((Not ($nByte = $nSize)), $nByte, ($nByte = $nSize))
EndFunc   ;==>_ResSaveToFile

; #FUNCTION# ========================================================================================================================
; Function Name:	_ResGetBitmap
; Description:		Loads a specified resource as bitmap.
; Syntax:			_ResGetBitmap ( $sResName [, $Dll] )
; Parameter(s):		$sResName - The name of the resource, which must be obtained (string value).
;					$Dll      - [optional] The name of file containing the resources. Default is running script (-1).
;
; Return Value(s):	Success: The handle of the loaded bitmap. To release an bitmap object using _WinAPI_DeleteObject().
;					Failure: Returns 0 and sets the @error flag to non-zero.
; Author(s):		Zedna (modified by Yashied)
; Note(s):			This function works only with the "Bitmap" resource type.
;====================================================================================================================================

Func _ResGetBitmap($sResName, $Dll = -1)

	Local $hInstance, $hBitmap

	If StringStripWS($sResName, 3) = '' Then
		Return SetError(1, 0, 0)
	EndIf

	If $Dll = -1 Then
		$hInstance = _WinAPI_GetModuleHandle('')
	Else
		$hInstance = _WinAPI_LoadLibrary($Dll)
	EndIf
	If $hInstance = 0 Then
		Return SetError(1, 0, 0)
	EndIf
	$hBitmap = _WinAPI_LoadImage($hInstance, $sResName, 0, 0, 0, 0)
	If $Dll <> -1 Then
		_WinAPI_FreeLibrary($hInstance)
	EndIf
	If $hBitmap = 0 Then
		Return SetError(1, 0, 0)
	EndIf

	Return $hBitmap
EndFunc   ;==>_ResGetBitmap

; #FUNCTION# ========================================================================================================================
; Function Name:	_ResSetBitmapToCtrl
; Description:		Loads a specified resource as an bitmap in the control.
; Syntax:			_ResSetBitmapToCtrl ( $controlID, $sResName [, $Dll] )
; Parameter(s):		$controlID - The control identifier (controlID) as returned by a GUICtrlCreatePic() function.
;					$sResName  - The name of the resource, which must be obtained (string value).
;					$Dll       - [optional] The name of file containing the resources. Default is running script (-1).
;
; Return Value(s):	Success: Returns 1.
;					Failure: Returns 0 and sets the @error flag to non-zero.
; Author(s):		Zedna (modified by Yashied)
; Note(s):			This function works only with the "Bitmap" resource type.
;====================================================================================================================================

Func _ResSetBitmapToCtrl($controlID, $sResName, $Dll = -1)

	Local $hBitmap = _ResGetBitmap($sResName, $Dll)

	If @error Then
		Return SetError(1, 0, 0)
	EndIf

	_SetBitmapToCtrl($controlID, $hBitmap)
	If @error Then
		_WinAPI_DeleteObject($hBitmap)
		Return SetError(1, 0, 0)
	EndIf

	Return 1
EndFunc   ;==>_ResSetBitmapToCtrl

; #FUNCTION# ========================================================================================================================
; Function Name:	_ResSaveBitmapToFile
; Description:		Saves a specified resource in the file.
; Syntax:			_ResSaveBitmapToFile ( $sFileName, $sResName [, $Dll] )
; Parameter(s):		$sFileName - The name of file in which you want to save the resource.
;					$sResName  - The name of the resource, which must be obtained (string value).
;					$Dll       - [optional] The name of file containing the resources. Default is running script (-1).
;
; Return Value(s):	Success: Returns 1 and @extended flag will contain the size of saved file (in bytes).
;					Failure: Returns 0 and sets the @error flag to non-zero.
; Author(s):		Zedna (modified by Yashied)
; Note(s):			This function works only with the "Bitmap" resource type.
;====================================================================================================================================

Func _ResSaveBitmapToFile($sFileName, $sResName, $Dll = -1)

	Local $hBitmap = _ResGetBitmap($sResName, $Dll)
	Local $hImage, $Ret

	If @error Then
		Return SetError(1, 0, 0)
	EndIf

	_GDIPlus_Startup()
	
	$hImage = _GDIPlus_BitmapCreateFromHBITMAP($hBitmap)
	$Ret = _GDIPlus_ImageSaveToFile($hImage, $sFileName)
	_GDIPlus_ImageDispose($hImage)

	_GDIPlus_Shutdown()

	_WinAPI_DeleteObject($hBitmap)

	Return SetError((Not $Ret), FileGetSize($sFileName), $Ret)
EndFunc   ;==>_ResSaveBitmapToFile

; #FUNCTION# ========================================================================================================================
; Function Name:	_ResPlaySound
; Description:		Plays a sound specified by the given resource.
; Syntax:			_ResPlaySound ( $sResName [, $nFlag [, $Dll]] )
; Parameter(s):		$sResName - The name of the resource, which must be obtained (string value).
;					$nFlag    - [optional] Flags for playing the sound. The following values are defined. Default is BitOR(SND_ASYNC, SND_NOWAIT).
;
;								SND_SYNC
;								Synchronous playback of a sound event. PlaySound returns after the sound event completes.
;
;								SND_ASYNC
;								The sound is played asynchronously and PlaySound returns immediately after beginning the sound. To terminate an
;								asynchronously played waveform sound, call PlaySound with pszSound set to NULL.
;
;								SND_MEMORY
;								The pszSound parameter points to a sound loaded in memory.
;
;								(see http://msdn.microsoft.com/en-us/library/ms712876(VS.85).aspx for more information)
;
;								SND_LOOP
;								The sound plays repeatedly until PlaySound is called again with the pszSound parameter set to NULL. You must also
;								specify the SND_ASYNC flag to indicate an asynchronous sound event.
;
;								SND_NOSTOP
;								The specified sound event will yield to another sound event that is already playing. If a sound cannot be played
;								because the resource needed to generate that sound is busy playing another sound, the function immediately returns FALSE
;								without playing the requested sound. If this flag is not specified, PlaySound attempts to stop the currently playing
;								sound so that the device can be used to play the new sound.
;
;								SND_NOWAIT
;								If the driver is busy, return immediately without playing the sound.
;
;					$Dll      - [optional] The name of file containing the resources. Default is running script (-1).
;
; Return Value(s):	Success: Returns 1.
;					Failure: Returns 0 and sets the @error flag to non-zero.
; Author(s):		Zedna (modified by Yashied)
; Note(s):			Don`t set the SND_ASYNC flag, if the sound is expected to play from another file.
;====================================================================================================================================

Func _ResPlaySound($sResName, $nFlag = 0x2001, $Dll = -1)

	Local $hInstance = 0, $Ret

	If $Dll <> -1 Then
		$hInstance = _WinAPI_LoadLibrary($Dll)
		If $hInstance = 0 Then
			Return SetError(1, 0, 0)
		EndIf
	EndIf
	$Ret = DllCall('winmm.dll', 'int', 'PlaySound', 'str', $sResName, 'hwnd', $hInstance, 'int', BitOR(0x00040004, $nFlag))
	If (@error) Or ($Ret[0] = 0) Then
		$Ret = 1
	Else
		$Ret = 0
	EndIf
	If $Dll <> -1 Then
		_WinAPI_FreeLibrary($hInstance)
	EndIf

	Return SetError($Ret, 0, (Not $Ret))
EndFunc   ;==>_ResPlaySound

#EndRegion Public Functions

#Region Internal Functions

Func _SetBitmapToCtrl($controlID, $hBitmap)

	Local Const $STM_SETIMAGE = 0x0172
	Local Const $STM_GETIMAGE = 0x0173

	Local Const $SS_BITMAP = 0x0E

	Local $hWnd, $hPrev, $Style

	$hWnd = GUICtrlGetHandle($controlID)
	If $hWnd = 0 Then
		Return SetError(1, 0, 0)
	EndIf
	$Style = _WinAPI_GetWindowLong($hWnd, $GWL_STYLE)
	If @error Then
		Return SetError(1, 0, 0)
	EndIf
	_WinAPI_SetWindowLong($hWnd, $GWL_STYLE, BitOR($Style, $SS_BITMAP))
	If @error Then
		Return SetError(1, 0, 0)
	EndIf
	$hPrev = _SendMessage($hWnd, $STM_SETIMAGE, $IMAGE_BITMAP, 0)
	If $hPrev Then
		_WinAPI_DeleteObject($hPrev)
	EndIf
	_SendMessage($hWnd, $STM_SETIMAGE, $IMAGE_BITMAP, $hBitmap)
	If @error Then
		Return SetError(1, 0, 0)
	EndIf
	$hPrev = _SendMessage($hWnd, $STM_GETIMAGE, $IMAGE_BITMAP, 0)
	If (@error) Or ($hBitmap = $hPrev) Then
		$hBitmap = 0
	EndIf
	If $hBitmap Then
		_WinAPI_DeleteObject($hBitmap)
	EndIf

	Return 1
EndFunc   ;==>_SetBitmapToCtrl

#EndRegion Internal Functions
