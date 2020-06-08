#NoTrayIcon
#cs ----------------------------------------------------------------------------
AutoIt Version	: 3.3.7.14
Version			: 1.2.1
Author			: asdf8
#ce ----------------------------------------------------------------------------

Opt('MustDeclareVars', 1)

#Region    ;************ Includes ************
#Include <WindowsConstants.au3>
#Include <StaticConstants.au3>
#Include <GUIConstantsEx.au3>
#Include <EditConstants.au3>
#Include <File.au3>
#Include <SendMessage.au3>
#EndRegion ;************ Includes ************

Global $inpFile, $inclDir, $numFind, $aFind, $aIncl, $sSource, $iExit
Global $progressGui, $progressInf, $progressText
Global $AutoItPath, $ScriptDir, $d = '|'
Global $fDat = @ScriptDir & '\IncludesHelper.dat'
Global $fIni = @ScriptDir & '\IncludesHelper.ini'
Global $iShowOptimInfo, $iShowDetals, $iResultToSource
Global $hSciTE, $hCtrl1, $hCtrl2

HotKeySet('{Esc}', '_exit')

$hSciTE = WinGetHandle('[Class:SciTEWindow]')
If $hSciTE Then
	$hCtrl1 = ControlGetHandle($hSciTE, '', '[CLASS:Scintilla; INSTANCE:1]')
	$hCtrl2 = ControlGetHandle($hSciTE, '', '[CLASS:Scintilla; INSTANCE:2]')
EndIf

$iShowOptimInfo = IniRead($fIni, 'General', 'ShowOptimInfo', 'Default')
If $iShowOptimInfo = 'Default' Then
	$iShowOptimInfo = 1
	IniWrite($fIni, 'General', 'ShowOptimInfo', '1')
Else
	$iShowOptimInfo = Number($iShowOptimInfo)
EndIf
$iShowDetals = IniRead($fIni, 'General', 'ShowDetals', 'Default')
If $iShowDetals = 'Default' Then
	$iShowDetals = 0
	IniWrite($fIni, 'General', 'ShowDetals', '0')
Else
	$iShowDetals = Number($iShowDetals)
EndIf
$iResultToSource = IniRead($fIni, 'General', 'ResultToSource', 'Default')
If $iResultToSource = 'Default' Then
	$iResultToSource = 1
	IniWrite($fIni, 'General', 'ResultToSource', '1')
Else
	$iResultToSource = Number($iResultToSource)
EndIf

If $CmdLine[0] > 0 Then
	If $CmdLine[1] And FileExists($CmdLine[1]) Then;au3, exe
		$inpFile = $CmdLine[1]
	ElseIf $CmdLine[0] > 1 And $CmdLine[2] And FileExists($CmdLine[2]) Then;a3x
		$inpFile = $CmdLine[2]
	EndIf
EndIf

If Not $inpFile Or Not FileExists($inpFile) Then
	_ConsoleWrite('>Running: ' & @ScriptName & @CRLF & '! NOT AU3 FILE' & @CRLF, 1)
	Exit
EndIf

_ConsoleWrite('>INCLUDES HELPER' & @CRLF, 1)
_ConsoleWrite($inpFile & @CRLF & @CRLF)

If @OSArch = 'X86' Then
	$AutoItPath = RegRead('HKEY_LOCAL_MACHINE\SOFTWARE\AutoIt v3\AutoIt', 'InstallDir')
Else
	$AutoItPath = RegRead('HKEY_LOCAL_MACHINE\SOFTWARE\Wow6432Node\AutoIt v3\AutoIt', 'InstallDir')
EndIf
$inclDir = $AutoItPath & '\Include\'
$ScriptDir = StringRegExpReplace($inpFile, '(.+)\\.+', '\1')

If Not $AutoItPath Or Not FileExists($inclDir) Then
	_ConsoleWrite('! NOT FOUND AUTOIT INCLUDE PATH' & @CRLF)
	Exit
EndIf

$progressGui = GUICreate("", 272, 62, -1, -1, BitOR($WS_THICKFRAME,$WS_POPUP), BitOR($WS_EX_TOOLWINDOW,$WS_EX_TOPMOST,$WS_EX_WINDOWEDGE))
$progressText = GUICtrlCreateLabel('', 4, 8, 264, 17, $SS_CENTER, $GUI_WS_EX_PARENTDRAG)
GUICtrlSetFont(-1, 9, 400, 0, "Arial")
GUICtrlSetTip(-1, '"ESC" - exit')
GUICtrlSetCursor(-1, 9)
$progressInf = GUICtrlCreateProgress(4, 28, 264, 29)
GUISetState(@SW_SHOWNA)

_LoadDB()

_ProgressSet(1, 'Source code analysis ...')
$aFind = _PrepareScript($inpFile)

If Not IsArray($aFind) Then
	GUIDelete($progressGui)
	_ConsoleWrite('-> DO NOT NEED ANY INCLUDES' & @CRLF)
	If $iResultToSource Then _ResultToSource('', '', 1)
	Exit
EndIf

$numFind = UBound($aFind)

_ProgressSet(1, 'Check ads includes ...')
_CheckAdsIncludes($inpFile)
If Not $numFind Then _OutInfo()
_ProgressSet(1, 'Scan includes general ...')
_ScanIncludes()
If Not $numFind Then _OutInfo()
_ProgressSet(1, 'Scan includes in script dir ...')
_ScanIncludes($ScriptDir)
_OutInfo()

Func _LoadDB()
	Local $aTmp, $tmp, $i, $str, $file, $var, $flag = 1
	$aTmp = _FileList($AutoItPath & '\Include', '*.au3')
	If IsArray($aTmp) And $aTmp[0] > 0 Then
		If FileExists($fDat) Then
			$str = FileRead($fDat)
			$tmp = StringRegExp($str, '([^\a]+)', 3)
			If IsArray($tmp) And UBound($tmp) = $aTmp[0] Then
				Dim $aIncl[UBound($aTmp)][4]
				$aIncl[0][0] = $aTmp[0]
				For $i = 1 To $aTmp[0]
					$var = StringReplace($aTmp[$i], $inclDir, '') & FileGetTime($aTmp[$i], 0, 1)
					If $var = StringLeft($tmp[$i - 1], StringLen($var)) Then
						$aIncl[$i][0] = $aTmp[$i]
						$var = StringRegExp($tmp[$i - 1], '([^\r\n]+)', 3)
						If IsArray($var) And UBound($var) > 1 Then
							$aIncl[$i][1] = $var[1]
							If UBound($var) > 2 Then
								$aIncl[$i][2] = StringReplace($var[2], Chr(28), $inclDir)
							EndIf
						EndIf
					Else
						$flag = 0
						ExitLoop
					EndIf
				Next
				If $flag Then
					Return
				EndIf
			EndIf
		EndIf
		_ProgressSet(1, 'Creating a database ...')
		$str = ''
		Dim $aIncl[UBound($aTmp)][4]
		$aIncl[0][0] = $aTmp[0]
		For $i = 1 To $aIncl[0][0]
			If $iExit Then Exit
			$aIncl[$i][0] = $aTmp[$i]
			$tmp = _GetInfo($aTmp[$i])
			If $tmp[1] Then $tmp[1] = _AllIncl($aTmp[$i])
			$aIncl[$i][1] = $tmp[0]
			$aIncl[$i][2] = $tmp[1]
			$aIncl[$i][3] = FileGetTime($aTmp[$i], 0, 1)
			$str &= Chr(7) & StringReplace($aIncl[$i][0], $inclDir, '') & $aIncl[$i][3] & @CRLF & $aIncl[$i][1] & @CRLF & StringReplace($aIncl[$i][2], $inclDir, Chr(28)) & @CRLF
			If Not $aIncl[$i][1] And Not $aIncl[$i][2] Then
				_ConsoleWrite('! WARNING: EMPTY FILE IN FOLDER "INCLUDE" : ' & StringReplace($aIncl[$i][0], $inclDir, '') & @CRLF)
			EndIf
			_ProgressSet(100 * $i/$aTmp[0])
		Next
		If $str Then
			$file = FileOpen($fDat, 2)
			FileWrite($file, $str)
			FileClose($file)
		EndIf
	Else
		_ConsoleWrite('! NOT FOUND AUTOIT INCLUDE FILES' & @CRLF)
		Exit
	EndIf
EndFunc

Func _GetInfoDB($sPath)
	Local $i, $aOut
	Dim $aOut[2]
	For $i = 1 To $aIncl[0][0]
		If $aIncl[$i][0] = $sPath Then
			$aOut[0] = $aIncl[$i][1]
			$aOut[1] = $aIncl[$i][2]
			Return $aOut
		EndIf
	Next
	Return SetError(1, 0, $aOut)
EndFunc

Func _PrepareScript($inpFile)
	Local $str, $path, $sNotFindFunc, $tmp, $tmp1, $tmp2, $tmp3, $var
	Local $ind1 = 0, $ind2 = 0, $ind3 = 0, $sToFindConst, $sToFindFunc
	$str = FileRead($inpFile)
	$str = _DelComment($str, 1)
	$sSource = $str
	
	$str = StringRegExpReplace($str, '_[\r\n]+', '')
	$str = StringRegExpReplace($str, '(?i)\.[a-z_0-9]+', ' <<')
	$str = StringRegExpReplace($str, '(?i)([^\r\n]+[ \t]+Then)[ \t]+([^\r\n]+)', '\1' & @CRLF & '\2')
	$str = StringRegExpReplace($str, '(?i)(?<=[\r\n])[ \t]*Else[ \t]+', '')
	
	$path = ''
	If FileExists($AutoItPath & '\SciTE\languages\au3.properties') Then
		$path = $AutoItPath & '\SciTE\languages\au3.properties'
	ElseIf FileExists($AutoItPath & '\SciTE\Properties\au3.keywords.properties') Then
		$path = $AutoItPath & '\SciTE\Properties\au3.keywords.properties'
	EndIf

	If $path Then;ai functions
		$tmp = StringRegExpReplace(FileRead($path), '(?s)^.*\.functions=([^\.]+).*$', '\1')
		$tmp = StringRegExpReplace($tmp, '(?s)(.+)[\r\n][^\r\n]*', '\1')
		$tmp = StringRegExp($tmp, '\w+', 3)
		If IsArray($tmp) Then
			$sNotFindFunc = $d
			For $i = 0 To UBound($tmp) -1
				$sNotFindFunc &= $tmp[$i] & $d
			Next
		EndIf
		$tmp = StringRegExpReplace(FileRead($path), '(?s)^.*\.keywords=([^\.]+).*$', '\1')
		$tmp = StringRegExpReplace($tmp, '(?s)(.+)[\r\n][^\r\n]*', '\1')
		$tmp = StringRegExp($tmp, '\w+', 3)
		If IsArray($tmp) Then
			If Not $sNotFindFunc Then $sNotFindFunc = $d
			For $i = 0 To UBound($tmp) -1
				$sNotFindFunc &= $tmp[$i] & $d
			Next
		EndIf
	EndIf

	$tmp1 = StringRegExp($str, '(?i)(?:^|[\r\n])[ \t]*Func[ \t]+([0-9a-z_]+)[ \t]*\(', 3)
	$tmp2 = StringRegExp($str, '(?i)(\$[a-z0-9_]+)', 3)
	$tmp3 = StringRegExp($str, '([^\r\n]+)', 3)
	If $iExit Then Exit
	If IsArray($tmp1) Then $ind1 = UBound($tmp1)
	If IsArray($tmp2) Then $ind2 = UBound($tmp2)
	If IsArray($tmp3) Then $ind3 = UBound($tmp3)

	If IsArray($tmp1) Then
		If Not $sNotFindFunc Then $sNotFindFunc = $d
		For $i = 0 To UBound($tmp1) -1
			If $iExit Then Exit
			$sNotFindFunc &= $tmp1[$i] & $d
			_ProgressSet(100 * $i/($ind1 + $ind2 + $ind3))
		Next
	EndIf

	If IsArray($tmp2) Then
		$sToFindConst = $d
		For $i = 0 To UBound($tmp2) -1
			If $iExit Then Exit
			If StringLower($tmp2[$i]) <> '$cmdlineraw' And StringLower($tmp2[$i]) <> '$cmdline' And Not StringInStr($sToFindConst, $d & $tmp2[$i] & $d) Then
				$sToFindConst &= $tmp2[$i] & $d
			EndIf
			_ProgressSet(100 * ($i + $ind1)/($ind1 + $ind2 + $ind3))
		Next
	EndIf

	If IsArray($tmp3) Then
		For $i = 0 To UBound($tmp3) -1
			If $iExit Then Exit
			If StringRegExp($tmp3[$i], '^#') Then ContinueLoop
			If StringRegExp($tmp3[$i], '(?i)^(Global|Local|Static|Const|Func|Dim)[ \t]') Then
				$tmp = $tmp3[$i]
				If StringInStr($tmp, '[') Then
					Do
						$tmp = StringRegExpReplace($tmp, '\[[^\[\]]*\]', ' ')
					Until Not @extended
				EndIf
				If Not StringRegExp($tmp3[$i], '(?i)^Func[ \t]') And StringInStr($tmp, '(') Then
					Do
						$tmp = StringRegExpReplace($tmp, '\([^\(\)]*\)', ' ')
					Until Not @extended
				EndIf
				$tmp = StringRegExpReplace($tmp, '=[^,]+', ' ')
				$tmp = StringRegExp($tmp, '(?i)(\$[a-z0-9_]+)', 3)
				If IsArray($tmp) Then
					For $j = 0 To UBound($tmp) -1
						$sToFindConst = StringReplace($sToFindConst, $d & $tmp[$j] & $d, $d)
					Next
				EndIf
			Else
				$tmp = StringRegExp($tmp3[$i], '(?i)^(?:[a-z]+[ \t]+)?(\$[a-z0-9_]+)[ \t]*=', 3)
				If IsArray($tmp) Then
					$sToFindConst = StringReplace($sToFindConst, $d & $tmp[0] & $d, $d)
				Else
					$tmp = StringRegExp($tmp3[$i], '(?i)^[ \t]*For[ \t]+(\$[a-z0-9_]+)', 3)
					If IsArray($tmp) Then
						$sToFindConst = StringReplace($sToFindConst, $d & $tmp[0] & $d, $d)
					EndIf
				EndIf
			EndIf
			$tmp = StringRegExp($tmp3[$i], '(?i)(?<=^|[^\$a-z0-9_])([a-z0-9_]+)[ \t]*\(', 3)
			If IsArray($tmp) Then
				For $j = 0 To UBound($tmp) -1
					If Not StringInStr($sNotFindFunc, $d & $tmp[$j] & $d) Then
						If $sToFindFunc Then
							If Not StringInStr($sToFindFunc, $d & $tmp[$j] & $d) Then
								$sToFindFunc &= $tmp[$j] & $d
							EndIf
						Else
							$sToFindFunc = $d & $tmp[$j] & $d
						EndIf
					EndIf
				Next
			EndIf
			_ProgressSet(1 + 100 * ($i + $ind1 + $ind2)/($ind1 + $ind2 + $ind3))
		Next
	Else
		GUIDelete($progressGui)
		_ConsoleWrite('! EPTY SCRIPT' & @CRLF)
		Exit
	EndIf

	$tmp = StringRegExp($sToFindConst, '([^\|]+)', 3)
	If IsArray($tmp) Then
		Dim $aFind[UBound($tmp)][3]
		For $i = 0 To UBound($tmp) -1
			$aFind[$i][0] = $tmp[$i]
		Next
	EndIf
	$tmp = StringRegExp($sToFindFunc, '([^\|]+)', 3)
	If IsArray($tmp) Then
		If IsArray($aFind) Then
			$var = UBound($aFind)
			ReDim $aFind[UBound($aFind)+UBound($tmp)][3]
		Else
			Dim $aFind[UBound($tmp)][3]
			$var = 0
		EndIf
		For $i = 0 To UBound($tmp) -1
			$aFind[$i + $var][0] = $tmp[$i]
		Next
	EndIf
	Return $aFind
EndFunc

Func _CheckAdsIncludes($inpFile)
	Local $tmp, $aDat, $i, $j, $str
	$tmp = _AllIncl($inpFile)
	$tmp = StringRegExp($tmp, '([^|]+)', 3)
	If UBound($tmp) > 1 Then
		For $i = 1 To UBound($tmp) - 1
			If $iExit Then Exit
			$str = ''
			$aDat = _GetInfo($tmp[$i])
			If $aDat[0] Then
				For $j = 0 To UBound($aFind) -1
					If $iExit Then Exit
					If StringInStr($aDat[0], $d & $aFind[$j][0] & $d) Then
						$aFind[$j][1] = $tmp[$i]
						If $iShowOptimInfo And $aDat[1] Then
							If Not $str Then $str = _AllIncl($tmp[$i])
							$aFind[$j][2] = $str
						EndIf
						$numFind -= 1
					EndIf
				Next
			EndIf
			_ProgressSet(100 * ($i + 1)/UBound($tmp))
		Next
	EndIf
EndFunc

Func _ScanIncludes($path = '')
	Local $aTmp, $aInclTmp, $tmp, $i, $j, $aDat, $str
	If $path Then
		$aTmp = _FileList($path, '*.au3')
		If IsArray($aTmp) And $aTmp[0] > 0 Then
			For $i = 1 To $aTmp[0]
				If $iExit Then Exit
				If StringLower($inpFile) = StringLower($aTmp[$i]) Then ContinueLoop
				$str = ''
				$tmp = _GetInfo($aTmp[$i])
				For $j = 0 To UBound($aFind) -1
					If $iExit Then Exit
					If Not $aFind[$j][1] Then
						If StringInStr($tmp[0], $d & $aFind[$j][0] & $d) Then
							$aFind[$j][1] = $aTmp[$i]
							If $iShowOptimInfo And $tmp[1] Then
								If Not $str Then $str = _AllIncl($aTmp[$i])
								$aFind[$j][2] = $str
							EndIf
							$numFind -= 1
						EndIf
					EndIf
				Next
				_ProgressSet(100 * $i/$aTmp[0])
			Next
		Else
			_ConsoleWrite('! NOT FOUND AUTOIT INCLUDE FILES FOR :' & @CRLF & $path & @CRLF)
		EndIf
	Else
		For $i = 1 To $aIncl[0][0]
			If $iExit Then Exit
			For $j = 0 To UBound($aFind) -1
				If Not $aFind[$j][1] Then
					If StringInStr($aIncl[$i][1], $d & $aFind[$j][0] & $d) Then
						$aFind[$j][1] = $aIncl[$i][0]
						$aFind[$j][2] = $aIncl[$i][2]
						$numFind -= 1
					EndIf
				EndIf
			Next
			_ProgressSet(100 * $i/$aIncl[0][0])
		Next
	EndIf
EndFunc

Func _AllIncl($fullPath)
	Local $str, $tmp, $i, $j, $sCompare, $aPath, $var
	If $numFind And StringInStr($fullPath, $inclDir) Then
		$tmp = _GetInfoDB($fullPath)
		Return $tmp[1]
	Else
		$sCompare = $d & $fullPath & $d
		Dim $aPath[2]
		$aPath[0] = 1
		$aPath[1] = $fullPath
		$j = 1
		While $j <= $aPath[0]
			If $numFind And StringInStr($aPath[$j], $inclDir) Then
				$tmp = _GetInfoDB($aPath[$j])
				$tmp = StringRegExp($tmp[1], '([^\|]+)', 3)
				If IsArray($tmp) Then
					For $i = 0 To UBound($tmp) -1
						If Not StringInStr($sCompare, $d & $tmp[$i] & $d) Then
							$sCompare &= $tmp[$i] & $d
							$aPath[0] += 1
							If UBound($aPath) <= $aPath[0] Then ReDim $aPath[2 * $aPath[0]]
							$aPath[$aPath[0]] = $tmp[$i]
						EndIf
					Next
				EndIf
			Else
				$str = FileRead($aPath[$j])
				$str = _DelComment($str)
				$tmp = StringRegExp($str, '(?i)(?:^|[\r\n])[ \t]*#Include[ \t]*([<"''][^>"'']+)[>"'']', 3)
				If IsArray($tmp) Then
					For $i = 0 To UBound($tmp) -1
						$var = ''
						If StringLeft($tmp[$i], 1) = '<' Then
							$tmp[$i] = StringTrimLeft($tmp[$i], 1)
							If Not StringInStr($tmp[$i], '\') And FileExists($inclDir & $tmp[$i]) Then
								$var = $inclDir & $tmp[$i]
							ElseIf FileExists(_PathFull($tmp[$i], StringRegExpReplace($aPath[$j], '(.+)\\.+', '\1'))) Then
								$var = _PathFull($tmp[$i], StringRegExpReplace($aPath[$j], '(.+)\\.+', '\1'))
							EndIf
						Else
							$tmp[$i] = StringTrimLeft($tmp[$i], 1)
							If FileExists(_PathFull($tmp[$i], StringRegExpReplace($aPath[$j], '(.+)\\.+', '\1'))) Then
								$var = _PathFull($tmp[$i], StringRegExpReplace($aPath[$j], '(.+)\\.+', '\1'))
							ElseIf Not StringInStr($tmp[$i], '\') And FileExists($inclDir & $tmp[$i]) Then
								$var = $inclDir & $tmp[$i]
							EndIf
						EndIf
						If $var And Not StringInStr($sCompare, $d & $var & $d) Then
							$sCompare &= $var & $d
							$aPath[0] += 1
							If UBound($aPath) <= $aPath[0] Then ReDim $aPath[2 * $aPath[0]]
							$aPath[$aPath[0]] = $var
						EndIf
					Next
				EndIf
			EndIf
			$j += 1
		WEnd
	EndIf
	Return $sCompare
EndFunc

Func _OutInfo()
	Local $sNeed, $sNoNeed, $sCorrect, $sNoInfo, $i, $j, $str, $tmp, $aNeed, $sInclExist
	If $iShowOptimInfo Then
		If UBound($aFind) > 0 Then
			$tmp = 1
			_ProgressSet(1, 'Processing ...')
		Else
			GUIDelete($progressGui)
		EndIf
		For $i = 0 To UBound($aFind) -1
			If $iExit Then Exit
			If $aFind[$i][1] Then
				If $i <> $j And $aFind[$i][2] Then
					For $j = 0 To UBound($aFind) -1
						If $aFind[$j][1] And StringInStr($aFind[$i][2], $d & $aFind[$j][1] & $d) Then
							$aFind[$j][1] = $aFind[$i][1]
						EndIf
					Next
				EndIf
			Else
				$sNoInfo &= '!   ' & $aFind[$i][0] & @CRLF
			EndIf
			If $tmp Then _ProgressSet(100 * $i/UBound($aFind))
		Next
		If $tmp Then GUIDelete($progressGui)
	Else
		GUIDelete($progressGui)
	EndIf
	If $iExit Then Exit
	$tmp = $d
	For $i = 0 To UBound($aFind) -1
		If Not StringInStr($tmp, $d & $aFind[$i][1] & $d) Then
			$tmp &= $aFind[$i][1] & $d
		EndIf
		If $iShowDetals And $aFind[$i][1] Then
			If StringInStr($aFind[$i][1], $inclDir) Then
				_ConsoleWrite(StringFormat('--- > %-45s :: %s\n', $aFind[$i][0], StringReplace($aFind[$i][1], $inclDir, '')))
			Else
				_ConsoleWrite(StringFormat('--- > %-45s :: %s\n', $aFind[$i][0], _PathGetRelative($ScriptDir, $aFind[$i][1])))
			EndIf
		EndIf
	Next
	$aNeed = StringRegExp($tmp, '([^\|]+)', 3)
	
	$tmp = StringRegExp($sSource, '(?i)(?:^|[\r\n])[ \t]*#Include[ \t]*[<"'']([^>"'']+)[>"'']', 3)
	If IsArray($tmp) Then
		If IsArray($aNeed) Then
			$sInclExist = $d
			For $i = 0 To UBound($tmp) -1
				$sInclExist &= $tmp[$i] & $d
			Next
			For $i = 0 To UBound($aNeed) -1
				If StringInStr($aNeed[$i], $inclDir) Then
					$str = StringReplace($aNeed[$i], $inclDir, '')
					If StringInStr($sInclExist, $d & $str & $d) Then
						$sCorrect &= '+   ' & $str & @CRLF
						$sInclExist = StringReplace($sInclExist, $d & $str & $d, $d)
					Else
						$sNeed &= '#Include <' & $str & '>' & @CRLF
					EndIf
				Else
					$str = _PathGetRelative($ScriptDir, $aNeed[$i])
					If StringInStr($sInclExist, $d & $str & $d) Then
						$sCorrect &= '+   ' & $str & @CRLF
						$sInclExist = StringReplace($sInclExist, $d & $str & $d, $d)
					Else
						$sNeed &= '#Include "' & $str & '"' & @CRLF
					EndIf
				EndIf
			Next
			$tmp = StringRegExp($sInclExist, '([^\|]+)', 3)
			If IsArray($tmp) Then
				For $i = 0 To UBound($tmp) -1
					$sNoNeed &= '-   ' & $tmp[$i] & @CRLF
				Next
			EndIf
		Else
			For $i = 0 To UBound($tmp) -1
				$sNoNeed &= '-   ' & $tmp[$i] & @CRLF
			Next
		EndIf
	Else
		If IsArray($aNeed) Then
			For $i = 0 To UBound($aNeed) -1
				If StringInStr($aNeed[$i], $inclDir) Then
					$sNeed &= '#Include <' & StringReplace($aNeed[$i], $inclDir, '') & '>' & @CRLF
				Else
					$sNeed &= '#Include "' & _PathGetRelative($ScriptDir, $aNeed[$i]) & '"' & @CRLF
				EndIf
			Next
		EndIf
	EndIf
	If $iResultToSource Then _ResultToSource($sNeed, $sNoNeed)
	If $sNeed Then
		If $iResultToSource Then
			_ConsoleWrite('! NEED INCLUDED :' & @CRLF & $sNeed)
		Else
			_ConsoleWrite('! NEED INCLUDED : (placed in the clipboard)' & @CRLF & $sNeed)
			ClipPut($sNeed)
		EndIf
	EndIf
	If $sCorrect Then _ConsoleWrite('+ CORRECTLY INCLUDED :' & @CRLF & $sCorrect)
	If $sNoNeed Then _ConsoleWrite('- NOT NEED INCLUDED :' & @CRLF & $sNoNeed)
	If $sNoInfo Then _ConsoleWrite('! NOT FOUND INFORMATION FOR :' & @CRLF & $sNoInfo)
	_ConsoleWrite(@CRLF)
	Exit
EndFunc

Func _ResultToSource($sNeed, $sNoNeed, $iNoNeedAll = 0)
	Local $str, $tmp, $tmp2, $i, $pos = 0, $iComment = 0, $sOut
	If Not $sNeed And Not $sNoNeed And Not $iNoNeedAll Then Return
	If Not $hSciTE Then
		$iResultToSource = 0
		Return
	EndIf
	$str = ControlGetText($hSciTE, '', $hCtrl1)
	$str = BinaryToString(StringToBinary($str, 2), 1)
	If Not StringInStr($str, FileRead($inpFile)) Then
		$iResultToSource = 0
		Return
	EndIf
	$tmp = StringRegExp($str, '([\r\n]*)([^\r\n]+)([\r\n]*)', 3)
	If Not IsArray($tmp) Then Return
	$str = ''
	For $i = 0 To UBound($tmp) -1
		If $tmp[$i] Then
			If $iComment Then
				If StringRegExp($tmp[$i], '(?i)^[ \t]*#(cs|comments-start)') Then
					$iComment += 1
				ElseIf StringRegExp($tmp[$i], '(?i)^[ \t]*#(ce|comments-end)') Then
					$iComment -= 1
				EndIf
				$str &= StringRegExpReplace($tmp[$i], '(?s).', '.')
			Else
				If StringRegExp($tmp[$i], '(?i)^[ \t]*#(cs|comments-start)') Then
					$iComment = 1
				EndIf
				$str &= $tmp[$i]
			EndIf
		EndIf
	Next
	
	If $iNoNeedAll And Not StringRegExp($str, '(?i)(?<=^|[\r\n])([ \t]*#Include[^\r\n]+)') Then Return
	
	Local $sHead = ';************ Includes ************'
	$tmp = StringRegExp($str, '(?i)(?<=^|[\r\n])([;~ \t]*#Include[^\r\n]+|[ \t]*#(?:End)?Region[ ]*\Q' & $sHead & '\E[^\r\n]*)', 3)
	If IsArray($tmp) Then
		$pos = StringLen($str)
		For $i = UBound($tmp) -1 To 0 Step -1
			$pos = StringInStr($str, $tmp[$i], 1, -1, $pos)
			_SendMessage($hCtrl1, $EM_SETSEL, $pos - 1, $pos + StringLen($tmp[$i]) + 1)
			_SendMessage($hCtrl1, $EM_REPLACESEL, True, '', 0, "wparam", "wstr")
			If StringRegExp($tmp[$i], '(?i)^[;~ \t]*#Include') Then
				$tmp2 = StringRegExp($tmp[$i], '(?i)^[ \t]*#Include[ \t]*[<''"]([^>''"]+)[>''"]', 3)
				If IsArray($tmp2) Then
					If $iNoNeedAll Then
						$sOut = ';~ ' & $tmp[$i] & ';~~~' & @CRLF & $sOut
					Else
						If StringInStr($sNoNeed, '-   ' & $tmp2[0]) Then
							$sOut = ';~ ' & $tmp[$i] & ';~~~' & @CRLF & $sOut
							$sNoNeed = StringReplace($sNoNeed, '-   ' & $tmp2[0], '-   ')
						Else
							$sOut = $tmp[$i] & @CRLF & $sOut
						EndIf
					EndIf
				Else
					$sOut = $tmp[$i] & @CRLF & $sOut
				EndIf
			EndIf
		Next
	EndIf
	
	If $pos Then
		$pos -= 1
	Else
		$tmp = StringRegExp($str, '(?i)(?<=^|[\r\n])([;~ \t]*#NoTrayIcon[^\r\n]*(?:\r\n|\r|\n))', 3)
		If IsArray($tmp) Then
			$pos = StringInStr($str, $tmp[0], 1) + StringLen($tmp[0]) - 1
		EndIf
	EndIf
	
	$tmp = StringRegExp($sOut, '(?i)(?<=^|[\r\n])([ \t]*#include-once[^\r\n]*[\r\n]*)', 3)
	If IsArray($tmp) Then
		$sOut = StringReplace($sOut, $tmp[0], '')
		$sNeed = '#include-once' & @CRLF & $sNeed
	EndIf
	
	$sOut = '#Region    ' & $sHead & @CRLF & $sNeed & $sOut & '#EndRegion ' & $sHead & @CRLF
	If $sOut Then
		$sOut = StringToBinary($sOut, 1)
		$sOut &= StringRight('0000', Mod(StringLen($sOut), 4) + 2)
		$sOut = BinaryToString($sOut, 2)
		_SendMessage($hCtrl1, $EM_SETSEL, $pos, $pos)
		_SendMessage($hCtrl1, $EM_REPLACESEL, True, $sOut, 0, "wparam", "wstr")
	EndIf
EndFunc

Func _ProgressSet($percent, $text = 'Default')
	If $percent < 0 Then $percent = 0
	If $percent > 100 Then $percent = 100
	GUICtrlSetData($progressInf, $percent)
	If $text <> 'Default' Then GUICtrlSetData($progressText, $text)
EndFunc

Func _GetInfo($fullPath)
	Local $tmp, $i, $j, $aRet, $str, $var
	If $numFind And StringInStr($fullPath, $inclDir) Then
		$aRet = _GetInfoDB($fullPath)
	Else
		Dim $aRet[2]
		$str = FileRead($fullPath)
		$str = _DelComment($str, 1)
		$str = StringRegExpReplace($str, '_[\r\n]+', '')
		
		$tmp = StringRegExp($str, '(?i)(?:^|[\r\n])[ \t]*Func[ \t]+([0-9a-z_]+)[ \t]*\(', 3)
		If IsArray($tmp) Then; functions
			$aRet[0] = $d
			For $j = 0 To UBound($tmp) -1
				$aRet[0] &= $tmp[$j] & $d
			Next
		EndIf
		
		$tmp = StringRegExp($str, '(?i)(?<![a-z0-9_$.])Global[ \t]([^\r\n]+)', 3)
		If IsArray($tmp) Then; const and var
			If Not $aRet[0] Then $aRet[0] = $d
			For $j = 0 To UBound($tmp) -1
				If StringInStr($tmp[$j], ',') Then
					If StringInStr($tmp[$j], '[') Then
						Do
							$tmp[$j] = StringRegExpReplace($tmp[$j], '\[[^\[\]]*\]', ' ')
						Until Not @extended
					EndIf
					If StringInStr($tmp[$j], '(') Then
						Do
							$tmp[$j] = StringRegExpReplace($tmp[$j], '\([^\(\)]*\)', ' ')
						Until Not @extended
					EndIf
					$tmp[$j] = StringRegExpReplace($tmp[$j], '=[^,]+', ' ')
					$var = StringRegExp($tmp[$j], '(\$\w+)', 3)
					If IsArray($var) Then
						For $i = 0 To UBound($var) -1
							$aRet[0] &= $var[$i] & $d
						Next
					EndIf
				Else
					$var = StringRegExp($tmp[$j], '(\$\w+)', 3)
					If IsArray($var) Then
						$aRet[0] &= $var[0] & $d
					EndIf
				EndIf
			Next
		EndIf
		$tmp = StringRegExp($str, '(?i)(?:^|[\r\n])[ \t]*#Include[ \t]*([<"''][^>"'']+)[>"'']', 3)
		If IsArray($tmp) Then $aRet[1] = 1; include
	EndIf
	Return $aRet
EndFunc

Func _DelComment($str, $delAll = 0)
	Local $aTmp, $iComment = 0, $i, $j, $flag, $tmp, $len, $chr
	$aTmp = StringRegExp($str, '([^\r\n]+)', 3)
	If IsArray($aTmp) Then
		$str = @CRLF
		For $i = 0 To UBound($aTmp) -1
			If $iComment Then
				If StringRegExp($aTmp[$i], '(?i)^[ \t]*#(cs|comments-start)') Then
					$iComment += 1
				ElseIf StringRegExp($aTmp[$i], '(?i)^[ \t]*#(ce|comments-end)') Then
					$iComment -= 1
				EndIf
			Else
				If StringRegExp($aTmp[$i], '(?i)^[ \t]*#(cs|comments-start)') Then
					$iComment = 1
				Else
					If StringRegExp($aTmp[$i], '(?i)^[ \t]*#(?!include)') Then ContinueLoop
					If Not StringRegExp($aTmp[$i], '^[ \t]*;') Then
						If $delAll Then
							If StringRegExp($aTmp[$i], '(?i)^[ \t]*#include') Then
								$aTmp[$i] = StringRegExpReplace($aTmp[$i], '([^;]+).*', '\1')
								$aTmp[$i] = StringStripWS($aTmp[$i], 7)
							Else
								$flag = 0
								$tmp = ''
								$len = StringLen($aTmp[$i])
								If $len Then
									For $j = 1 To $len
										$chr = StringMid($aTmp[$i], $j, 1)
										Switch $chr
											Case ';'
												If Not $flag Then
													$flag = -1
													ExitLoop
												EndIf
											Case '"'
												Switch $flag
													Case 0
														$flag = 1
														$tmp &= '"'
													Case 1
														$flag = 0
														$tmp &= '"'
												EndSwitch
											Case "'"
												Switch $flag
													Case 0
														$flag = 2
														$tmp &= '"'
													Case 2
														$flag = 0
														$tmp &= '"'
												EndSwitch
											Case Else
												If Not $flag Then $tmp &= $chr
										EndSwitch
									Next
									$aTmp[$i] = StringStripWS($tmp, 7)
								EndIf
							EndIf
						EndIf
						$str &= $aTmp[$i] & @CRLF
					EndIf
				EndIf
			EndIf
		Next
	EndIf
	Return $str
EndFunc

Func _FileList($sPath, $filter = '*')
	Local $FolderList, $aOut, $i, $j, $tmp, $var
	Dim $FolderList[2]
	$FolderList[0] = 1
	$FolderList[1] = $sPath
	$tmp = _FileListToArray($FolderList[1], '*', 2)
	If IsArray($tmp) And $tmp[0] > 0 Then; max 2 level
		ReDim $FolderList[$FolderList[0] + $tmp[0] + 1]
		For $i = 1 To $tmp[0]
			$FolderList[0] += 1
			$FolderList[$FolderList[0]] = $FolderList[1] & '\' & $tmp[$i]
		Next
		$var = $FolderList[0]
		For $i = 2 To $var
			$tmp = _FileListToArray($FolderList[$i], '*', 2)
			If IsArray($tmp) And $tmp[0] > 0 Then
				ReDim $FolderList[$FolderList[0] + $tmp[0] + 1]
				For $j = 1 To $tmp[0]
					$FolderList[0] += 1
					$FolderList[$FolderList[0]] = $FolderList[$i] & '\' & $tmp[$j]
				Next
			EndIf
		Next
	EndIf
	Dim $aOut[1]
	For $i = 1 To $FolderList[0]
		$tmp = _FileListToArray($FolderList[$i], $filter, 1)
		If IsArray($tmp) And $tmp[0] > 0 Then
			ReDim $aOut[$aOut[0] + $tmp[0] + 1]
			For $j = 1 To $tmp[0]
				$aOut[0] += 1
				$aOut[$aOut[0]] = $FolderList[$i] & '\' & $tmp[$j]
			Next
		EndIf
	Next
	Return $aOut
EndFunc

Func _ConsoleWrite($s_Text, $overwrite = 0)
	If Not $hSciTE Then
		ConsoleWrite($s_Text)
		Return
	EndIf
	If $s_Text Then
		$s_Text = StringToBinary($s_Text, 1)
		$s_Text &= StringRight('0000', Mod(StringLen($s_Text), 4) + 2)
		$s_Text = BinaryToString($s_Text, 2)
	EndIf
	If $overwrite <> 1 Then
		Local $iLength = _SendMessage($hCtrl2, $WM_GETTEXTLENGTH)
		_SendMessage($hCtrl2, $EM_SETSEL, $iLength, $iLength)
		_SendMessage($hCtrl2, $EM_REPLACESEL, True, $s_Text, 0, "wparam", "wstr")
	Else
		ControlSetText($hSciTE, '', $hCtrl2, $s_Text)
	EndIf
EndFunc

Func _exit()
	$iExit = 1
EndFunc
