;Opt('MustDeclareVars', 1)
Global $id, $textAU3, $include, $i, $var, $n, $array_global_const, $array_global, $array_global_Enum
Global $array_old_name, $ar_old, $array_Func

Global $mySave = IniRead(@ScriptDir & "\configbot.ini", "GlobalConst", "File Select", @ScriptDir)
Global $var = FileSelectFolder("", '', "", $mySave);, $gui)
IniWrite(@ScriptDir & "\configbot.ini", "GlobalConst", "File Select", $var)

Global $FileList = myFileListToArray_AllFilesEx($var, '*.au3')


If Not IsArray($FileList) Then Exit
For $id = 1 To $FileList[0]

	$textAU3 = FileRead($FileList[$id])

	If Not StringInStr($textAU3, @CRLF) Then $textAU3 = StringReplace($textAU3, @LF, @CRLF)
	If Not StringInStr($textAU3, @CRLF) Then $textAU3 = StringReplace($textAU3, @CR, @CRLF)

	$textAU3 = StringRegExpReplace($textAU3, '(?ims)(#cs.*?\r\n[\s]*#ce.*?)\r\n|' & _
			'(?ims)(#comments-start.*?\r\n[\s]*#comments-end.*?)\r\n', @CRLF) ;dell coments

	$textAU3 = StringRegExpReplace($textAU3, '(_\r\n)', ' ')

	$include = '         (Requires: #Include <' & StringRegExpReplace($FileList[$id], '.*[\\](.*)', '\1') & '> )'

	#region --- Find Func ---
	$array_Func = StringRegExp($textAU3, '(?ims)^\s*Func\s+(\w+)\s*[(]', 3)
	If IsArray($array_Func) Then
		For $i = 0 To UBound($array_Func) - 1
			ConsoleWrite($array_Func[$i] & '= [MY PRIVATE FUNCTION]   ' & $include & @CRLF)
		Next
	EndIf
	#region --- Find Func ---

	#region --- Find Global Const ---
	$array_global_const = StringRegExp($textAU3, '(?ims)^\s*(Global\s+Const\s+[$]\w+.*?)\r\n', 3)
	If IsArray($array_global_const) Then
		For $i = 0 To UBound($array_global_const) - 1
			$var = StringRegExp($array_global_const[$i], '([$]\w+)', 3)
			ConsoleWrite($var[0] & '=' & $array_global_const[$i] & $include & @CRLF)
		Next
	EndIf
	#region --- Find Global Const ---

	$textAU3 = StringRegExpReplace($textAU3, "('')|" & '("")|(\s*;.*?)(\r\n)', '\1\2\4') ; dell gren text
	$textAU3 = StringRegExpReplace($textAU3, '(_\r\n)', ' ')

	#endregion --- Find Global ---
	$array_global = StringRegExp($textAU3, '(?ims)^\s*(Global\s+[$]\w+.*?)\r\n', 3)
	If IsArray($array_global) Then
		For $i = 0 To UBound($array_global) - 1
			$var = StringRegExp($array_global[$i], '([$]\w+)', 3)
			If UBound($var) = 1 Then
				ConsoleWrite($var[0] & '=' & $array_global[$i] & $include & @CRLF)
			Else
				For $n = 0 To UBound($var) - 1
					ConsoleWrite($var[$n] & '=Global ' & $var[$n] & $include & @CRLF)
				Next
			EndIf
		Next
	EndIf
	#endregion --- Find Global ---

	#region --- Find Global Enum ---
	$array_global_Enum = StringRegExp($textAU3, '(?ims)^\s*(Global\s+Enum.*?)\r\n', 3)
	If IsArray($array_global_Enum) Then
		For $i = 0 To UBound($array_global_Enum) - 1
			$var = StringRegExp($array_global_Enum[$i], '([$]\w+)', 3)
			For $n = 0 To UBound($var) - 1
				ConsoleWrite($var[$n] & '=Global Enum ' & $var[$n] & $include & @CRLF)
			Next
		Next
	EndIf
	#endregion --- Find Global Enum ---


#region ---  Find Old Function/Name ---
#cs
For $id = 1 To $FileList[0]
	$textAU3 = FileRead($FileList[$id])
	$textAU3 = StringRegExpReplace($textAU3, '(?ims)(#cs.*?\r\n[\s]*#ce.*?)\r\n|' & _
			'(?ims)(#comments-start.*?\r\n[\s]*#comments-end.*?)\r\n', @CRLF) ;dell coments
	$include = '         (Requires: #Include <' & StringRegExpReplace($FileList[$id], '.*[\\](.*)', '\1') & '> )'

	$array_old_name = StringRegExp($textAU3, '(?ims)([;]\w+\s*\Q; -->\E\s*\w+)', 3)
	If IsArray($array_old_name) Then
		For $i = 0 To UBound($array_old_name) - 1
			$ar_old = StringRegExp($array_old_name[$i], '(\w+)', 3)
			If UBound($ar_old) = 2 Then
				ConsoleWrite($ar_old[0] & '=' & $ar_old[0] & '  [IS OLD NAME. NEW IS: /===>]' & $ar_old[1] & $include & @CRLF)
			EndIf
		Next
	EndIf
Next
#ce
#endregion --- Find Old Function/Name ---

Next


Func myFileListToArray_AllFilesEx($sPath, $sFilter = "*.*", $iFlag = 1, $full_adress = 1)

	Local $hSearch, $sFile, $sFileList, $sDelim = "|", $HowManyFiles = 0, $aReturn
	$sPath = StringRegExpReplace($sPath, "[\\/]+\z", "") & "\" ; ensure single trailing backslash
	Local $is_ok, $foldery = '', $newFoldersSearch = '', $array_foldery, $extended

	$iFlag = Number($iFlag)
	$full_adress = Number($full_adress)
	If $full_adress <> 0 Then $full_adress = 1

	If Not FileExists($sPath) Then Return SetError(1, 0, '')

	$sFilter = StringRegExpReplace($sFilter, "\s*;\s*", "|")
	If ($sFilter = Default) or ($sFilter = -1) Or StringInStr("|" & $sFilter & "|", "|*.*|") Or StringInStr("|" & $sFilter & "|", "||") Then
		$sFilter = '(?i).*'
	Else
		$sFilter = StringReplace($sFilter, '*', '\E*\Q')
		$sFilter = StringReplace($sFilter, '?', '\E?\Q')
		$sFilter = StringReplace($sFilter, '.', '\E[.]\Q')
		$sFilter = StringReplace($sFilter, '|', '\E|\Q')
		$sFilter = '\Q' & $sFilter & '\E'
		$sFilter = StringReplace($sFilter, '\Q\E', '')
		$sFilter = StringReplace($sFilter, '*', '.*')
		$sFilter = StringReplace($sFilter, '?', '.?')
		$sFilter = '(?i)' & $sFilter
		$sFilter = StringRegExpReplace($sFilter, '([.][*]){2,}', '.*')
	EndIf
	;ConsoleWrite($sFilter &@CRLF)

	While 1
		$hSearch = FileFindFirstFile($sPath & '*')
		If Not @error Then
			While 1
				$sFile = FileFindNextFile($hSearch)
				If @error Then ExitLoop
				$extended = @extended
				$HowManyFiles += 1
				If $extended = 1 Then ;folder
					$newFoldersSearch &= $sPath & $sFile & '\' & $sDelim ;nowe foldery do szukania
				EndIf
				If ($iFlag + $extended = 2) Then ContinueLoop

				$is_ok = Not StringRegExpReplace($sFile, $sFilter, '') ; test pattern

				If $full_adress And $is_ok Then
					$sFileList &= $sDelim & $sPath & $sFile
				ElseIf Not $full_adress And $is_ok Then
					$sFileList &= $sDelim & $sFile
				EndIf

			WEnd
		EndIf
		FileClose($hSearch)
		$foldery = $newFoldersSearch & $foldery
		$newFoldersSearch = ''
		$array_foldery = StringSplit($foldery, $sDelim, 3)
		If UBound($array_foldery) <= 1 Then ExitLoop
		$foldery = StringTrimLeft($foldery, StringInStr($foldery, $sDelim))
		$sPath = $array_foldery[0]
	WEnd
	If Not $sFileList Then Return SetError(2, $HowManyFiles, "")

	$aReturn = StringSplit(StringTrimLeft($sFileList, 1), $sDelim)
	$sFileList = 0
	SetExtended($HowManyFiles)
	Return $aReturn
EndFunc   ;==>myFileListToArray_AllFilesEx