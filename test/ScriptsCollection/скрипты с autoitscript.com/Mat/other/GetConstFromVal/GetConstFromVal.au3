
; { FUNCTION }====================================================================================================================
;
; Name         : _FindConstByVal
; Description  : Finds the name of a constant given its value.
; Syntax       : _FindConstByVal ( $sFind )
; Variables    : $sFind         - The value of the constant to find
; Returns      : Success        - Returns an 2d array where [][0] = The variable name and [][1] = the file found in.
;                Failure          Returns 0 and sets @Error to 1
; Author       : Mat
; Notes        :
; Related      :
; Example      : Yes
;
; ================================================================================================================================

Func _FindConstByVal($sFind)
	Local $aFolders = StringSplit(RegRead("HKEY_CURRENT_USER\Software\AutoIt v3\AutoIt", "include"), ";"), $aRet[1][2]
	$aRet[0][0] = 0
	$aRet[0][1] = $sFind
	If $aFolders[1] = "" Then ReDim $aFolders[1]
	$aFolders[0] = StringTrimRight(@AutoItExe, 11) & "include"

	For $i = 0 To UBound($aFolders) - 1
		If StringRight($aFolders[$i], 1) <> "\" Then $aFolders[$i] &= "\"
		$hSearch = FileFindFirstFile($aFolders[$i] & "*.au3")
		If $hSearch = -1 Then ContinueLoop
		While 1
			$sFile = FileFindNextFile($hSearch)
			If @error Then ExitLoop
			$aReg = StringRegExp(FileRead($aFolders[$i] & $sFile), "(?x)(?i)(?:\s+Global\s+const\s+)(\$.*?)(?:\s*)?=(?:\s*)?(\Q" & $sFind & "\E)", 3)
			If Not IsArray($aReg) Then ContinueLoop 1
			For $x = 1 To UBound($aReg) - 1 Step +2
				ReDim $aRet[UBound($aRet) + 1][2]
				$aRet[UBound($aRet) - 1][0] = $aReg[$x - 1]
				$aRet[UBound($aRet) - 1][1] = $sFile
				$aRet[0][0] += 1
			Next
		WEnd
		FileClose($hSearch)
	Next
	If UBound($aRet) = 1 Then Return SetError(1, 0, 0)
	Return $aRet
EndFunc   ;==>_FindConstByVal

; { FUNCTION }====================================================================================================================
;
; Name         : _FindValByConst
; Description  : Finds the value and file for a given constant.
; Syntax       : _FindIncludeByConstName ( $sFind )
; Variables    : $sFind         - The value of the constant to find
; Returns      : Success        - Returns an 2d array where [][0] = The value and [][1] = the file found in.
;                Failure          Returns 0 and sets @Error to 1
; Author       : Valery
; Notes        : Mat
; Related      :
; Example      : Yes
;
; ================================================================================================================================

Func _FindValByConst($sFindName)
	Local $aFolders = StringSplit(RegRead("HKEY_CURRENT_USER\Software\AutoIt v3\AutoIt", "include"), ";"), $aRet[1][2]
	$aRet[0][0] = 0
	$aRet[0][1] = $sFindName
	If $aFolders[1] = "" Then ReDim $aFolders[1]
	$aFolders[0] = StringTrimRight(@AutoItExe, 11) & "include"

	For $i = 0 To UBound($aFolders) - 1
		If StringRight($aFolders[$i], 1) <> "\" Then $aFolders[$i] &= "\"
		$hSearch = FileFindFirstFile($aFolders[$i] & "*.au3")
		If $hSearch = -1 Then ContinueLoop
		While 1
			$sFile = FileFindNextFile($hSearch)
			If @error Then ExitLoop
			$aReg = StringRegExp(FileRead($aFolders[$i] & $sFile), "(?x)(?i)(?:\s+Global\s+const\s+)?(?:\Q" & $sFindName & "\E)(?:\s+=\s+)(.+?)\s", 3)
			If Not IsArray($aReg) Then ContinueLoop 1
			For $x = 0 To UBound($aReg) - 1
				ReDim $aRet[UBound($aRet) + 1][2]
				$aRet[UBound($aRet) - 1][0] = $aReg[$x]
				$aRet[UBound($aRet) - 1][1] = $sFile
				$aRet[0][0] += 1
			Next
		WEnd
		FileClose($hSearch)
	Next
	If UBound($aRet) = 1 Then Return SetError(1, 0, 0)
	Return $aRet
EndFunc   ;==>_FindValByConst