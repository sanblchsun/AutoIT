#cs ----------------------------------------------------------------------------

	AutoIt Version: 3.3.0.0
	Author:         KaFu

	Script Function:
	Create
	$s_Associative_Array_FileTypeName
	s_Associative_Array_FileEXEAssociation

	Call with something like
	$Ext = ".zip"
	ConsoleWrite(_GetHint_FileTypeName($Ext) & @tab & _GetHint_FileEXEAssociation($Ext) & @crlf)

#ce ----------------------------------------------------------------------------

; Script Start - Add your code below here

#Region
; http://www.autoitscript.com/forum/index.php?showtopic=105984
; http://msdn.microsoft.com/en-us/library/bb762179(VS.85).aspx
;$tagSHFILEINFO2 = 'int hIcon;int iIcon;dword Attributes;wchar DisplayName[260];wchar TypeName[80]'
$tagSHFILEINFO2 = 'ptr hIcon;int iIcon;dword Attributes;wchar DisplayName[260];wchar TypeName[80]'

;Local Const $SHGFI_ATTR_SPECIFIED = 0x00020000
;Local Const $SHGFI_ATTRIBUTES = 0x00000800
;Local Const $SHGFI_DISPLAYNAME = 0x00000200
;Local Const $SHGFI_EXETYPE = 0x00002000
;Local Const $SHGFI_ICON = 0x00000100
;Local Const $SHGFI_ICONLOCATION = 0x00001000
;Local Const $SHGFI_LARGEICON = 0x00000000
;Local Const $SHGFI_LINKOVERLAY = 0x00008000
;Local Const $SHGFI_OPENICON = 0x00000002
;Local Const $SHGFI_OVERLAYINDEX = 0x00000040
;Local Const $SHGFI_PIDL = 0x00000008
;Local Const $SHGFI_SELECTED = 0x00010000
;Local Const $SHGFI_SHELLICONSIZE = 0x00000004
;Local Const $SHGFI_SMALLICON = 0x00000001
;Local Const $SHGFI_SYSICONINDEX = 0x00004000
;If Not IsDeclared("SHGFI_TYPENAME") Then Global Const $SHGFI_TYPENAME = 0x00000400
;If Not IsDeclared("SHGFI_USEFILEATTRIBUTES") Then Global Const $SHGFI_USEFILEATTRIBUTES = 0x00000010
;If Not IsDeclared("h_MM_Shell32Dll") Then $h_DLL_Shell32 = DllOpen("shell32.dll")

;Local Const $dwFILE_ATTRIBUTE_NORMAL = 0x80

$bFirstExtFound = False ; first key in my reg does NOT start with '.' but with '!', that's why to search for first '.' found
$i = 1 ; counter for reg key enumeration
Global $s_Associative_Array_FileTypeName = ""
Global $s_Associative_Array_FileEXEAssociation = ""
While 1
	$sExtensionFromReg = RegEnumKey('HKCR\', $i) ; enum possible extensions from registry
	If @error Then ExitLoop
	If StringLeft($sExtensionFromReg, 1) <> '.' And $bFirstExtFound = True Then ExitLoop ; last extension found in reg, exitloop
	If StringLeft($sExtensionFromReg, 1) = '.' Then
		$bFirstExtFound = True
		$sExtensionFromReg = StringReplace(StringReplace($sExtensionFromReg, ";", ""), "|", "")

		$sTypename = _WinAPI_ShellGetFileInfo_TYPENAME($sExtensionFromReg, BitOR($SHGFI_USEFILEATTRIBUTES, $SHGFI_TYPENAME))
		$sTypename = StringReplace(StringReplace($sTypename, ";", ""), "|", "")

		$sFileEXEAssociation = _FileEXEAssociation($sExtensionFromReg)
		$sFileEXEAssociation = StringReplace(StringReplace($sFileEXEAssociation, ";", ""), "|", "")

		$s_Associative_Array_FileEXEAssociation &= $sExtensionFromReg & "|" & $sFileEXEAssociation & ";"
		$s_Associative_Array_FileTypeName &= $sExtensionFromReg & "|" & $sTypename & ";"
	EndIf
	$i += 1
WEnd

Func _WinAPI_ShellGetFileInfo_TYPENAME($sPath, $iFlags, $iAttributes = 0x80)
	Local $tSHFILEINFO = DllStructCreate($tagSHFILEINFO2)
	Local $Ret = DllCall($h_DLL_Shell32, 'ptr', 'SHGetFileInfoW', 'wstr', $sPath, 'dword', $iAttributes, 'ptr', DllStructGetPtr($tSHFILEINFO), 'int', DllStructGetSize($tSHFILEINFO), 'int', $iFlags)
	If @error Then
		Return SetError(1, 0, 0)
	EndIf
	Return DllStructGetData($tSHFILEINFO, 5)
EndFunc   ;==>_WinAPI_ShellGetFileInfo_TYPENAME

Func _FileEXEAssociation($sExtension)
	Local Const $ASSOCSTR_EXECUTABLE = 2
	Local Const $ASSOCF_VERIFY = 0x00000040

	Local $aCall = DllCall($h_DLL_shlwapi, "int", "AssocQueryStringW", _
			"dword", $ASSOCF_VERIFY, _
			"dword", $ASSOCSTR_EXECUTABLE, _
			"wstr", $sExtension, _
			"ptr", 0, _
			"wstr", "", _
			"dword*", 65536)

	If @error Then
		Return SetError(1, 0, ""); call failed
	EndIf

	If Not $aCall[0] Then
		Return SetError(0, 0, $aCall[5])
	ElseIf $aCall[0] = 0x80070002 Then
		Return SetError(0, 0, "{unknown}"); COM Error 0x80070002, ?The system cannot find the file specified.'
	ElseIf $aCall[0] = 0x80004005 Then
		Return SetError(0, 0, "{fail}"); E_FAIL
	Else
		Return SetError(2, $aCall[0], ""); dammit!!!
	EndIf
EndFunc   ;==>_FileEXEAssociation

Func _GetHint_FileEXEAssociation($sExtension)
	Local $aArray = StringRegExp($s_Associative_Array_FileEXEAssociation, ";" & $sExtension & "\|(.*?);", 3)
	If @error Then
		Return ""
	EndIf
	Return $aArray[0]
EndFunc   ;==>_GetHint_FileEXEAssociation

Func _GetHint_FileTypeName($sExtension)
	Local $aArray = StringRegExp($s_Associative_Array_FileTypeName, ";" & $sExtension & "\|(.*?);", 3)
	If @error Then
		Return ""
	EndIf
	Return $aArray[0]
EndFunc   ;==>_GetHint_FileTypeName
#EndRegion