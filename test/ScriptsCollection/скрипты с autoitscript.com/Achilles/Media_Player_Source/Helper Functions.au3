#Include <WinAPI.au3>
#include <WindowsConstants.au3>
#include <array.au3>

Global Const $HKM_SETHOTKEY = $WM_USER + 1
Global Const $HKM_GETHOTKEY = $WM_USER + 2
Global Const $HOTKEYF_ALT = 0x04
Global Const $HOTKEYF_CONTROL = 0x02
Global Const $HOTKEYF_SHIFT = 0x01


Func _GUICtrlCreateCheckBoxEx($text, $x, $y, $w, $h)
	$XS_n = DllCall("uxtheme.dll", "int", "GetThemeAppProperties")
	DllCall("uxtheme.dll", "none", "SetThemeAppProperties", "int", 0)	

	$id = GUICtrlCreateCheckBox($text, $x, $y, $w, $h)
		
	DllCall("uxtheme.dll", "none", "SetThemeAppProperties", "int", $XS_n[0])
	
	Return $id
EndFunc



;===============================================================================
; Function Name:	GetExtProperty($sPath,$iProp)
; Description:      Returns an extended property of a given file.
; Parameter(s):     $sPath - The path to the file you are attempting to retrieve an extended property from.
;                   $iProp - The numerical value for the property you want returned. If $iProp is is set
;							  to -1 then all properties will be returned in a 1 dimensional array in their corresponding order.
;							The properties are as follows:
;						+	File Name = 0
;						+	File Size = 1
;						+	File Type = 2
;						+	Artist = 13
;						+	Album = 14
;						+	Year = 15
;						+	Genre = 16
;						+   Title = 21
;						+	TrackNumber = 26
;						+	Duration = 27
;
; Requirement(s):   File specified in $spath must exist.
; Return Value(s):  On Success - The extended file property, or if $iProp = -1 then an array with all properties
;                   On Failure - 0, @Error - 1 (If file does not exist)
; Author(s):        Simucal (Simucal@gmail.com)
; Note(s):
;===============================================================================

Func _GetExtProperty($sPath)
	Local $iExist, $sFile, $sDir, $oShellApp, $oDir, $oFile, $aProperty, $sProperty

	$sFile = StringTrimLeft($sPath, StringInStr($sPath, "\", 0, -1))
	$sDir = StringTrimRight($sPath, (StringLen($sPath) - StringInStr($sPath, "\", 0, -1)))
	$oShellApp = ObjCreate("shell.application")
	$oDir = $oShellApp.NameSpace ($sDir)
	$oFile = $oDir.Parsename ($sFile)

	Local $aProperty[10]
	$aProperty[0] = $oDir.GetDetailsOf ($oFile, 0) ; File Name
	$aProperty[1] = $oDir.GetDetailsOf ($oFile, 1) ; File Size
	$aProperty[2] = $oDir.GetDetailsOf ($oFile, 2) ; File Type
	If @OSVersion = 'WIN_VISTA' then 
		$aProperty[3] = $oDir.GetDetailsOf ($oFile, 13) ; Artist
		$aProperty[4] = $oDir.GetDetailsOf ($oFile, 14) ; Album
		$aProperty[5] = $oDir.GetDetailsOf ($oFile, 15) ; Year
		$aProperty[6] = $oDir.GetDetailsOf ($oFile, 16) ; Genre
		$aProperty[7] = $oDir.GetDetailsOf ($oFile, 21) ; Title
		$aProperty[8] = $oDir.GetDetailsOf ($oFile, 26) ; Track Number
		$aProperty[9] = _Trim($oDir.GetDetailsOf ($oFile, 27)) ;Duration
	Else 

		$aProperty[3] = $oDir.GetDetailsOf ($oFile, 16) ; Artist
		$aProperty[4] = $oDir.GetDetailsOf ($oFile, 17) ; Album
		$aProperty[5] = $oDir.GetDetailsOf ($oFile, 18) ; Year
		$aProperty[6] = $oDir.GetDetailsOf ($oFile, 20) ; Genre
		$aProperty[7] = $oDir.GetDetailsOf ($oFile, 10) ; Title
		$aProperty[8] = $oDir.GetDetailsOf ($oFile, 19) ; Track Number
		$aProperty[9] = _Trim($oDir.GetDetailsOf ($oFile, 21)) ;Duration			
	EndIf 
	
	Return $aProperty
EndFunc   ;==>_GetExtProperty

Func _Trim($string)
	For $x = 1 to 4 
		$l = StringLeft($string, 1)
		If $l = '0' or $l = ':' then 
			$string = StringTrimLeft($string, 1) 
		Else 
			Return $string
		EndIf 
	Next 
	Return $string 
EndFunc 

;~ $array = _GetExtPropertyA('C:\Users\Michael\Music\Blue System\Hello America\Vampire.mp3', -1)
;~ _ArrayDisplay($array)

Func _GetExtPropertyA($sPath, $iProp)
	Local $iExist, $sFile, $sDir, $oShellApp, $oDir, $oFile, $aProperty, $sProperty
	$iExist = FileExists($sPath)
	If $iExist = 0 Then
		SetError(1)
		Return 0
	Else
		$sFile = StringTrimLeft($sPath, StringInStr($sPath, "\", 0, -1))
		$sDir = StringTrimRight($sPath, (StringLen($sPath) - StringInStr($sPath, "\", 0, -1)))
		$oShellApp = ObjCreate("shell.application")
		$oDir = $oShellApp.NameSpace ($sDir)
		$oFile = $oDir.Parsename ($sFile)
		If $iProp = -1 Then
			Local $aProperty[35]
			For $i = 0 To 34
				$aProperty[$i] = $oDir.GetDetailsOf ($oFile, $i)
			Next
			Return $aProperty
		Else
			$sProperty = $oDir.GetDetailsOf ($oFile, $iProp)
			If $sProperty = "" Then
				Return 0
			Else
				Return $sProperty
			EndIf
		EndIf
	EndIf
EndFunc   ;==>_GetExtProperty

;===============================================================================
;
; Description:      lists all or preferred files and or folders in a specified path (Similar to using Dir with the /B Switch)
; Syntax:           _FileListToArrayEx($sPath, $sFilter = '*.*', $iFlag = 0, $sExclude = '')
; Parameter(s):        $sPath = Path to generate filelist for
;                    $sFilter = The filter to use. Search the Autoit3 manual for the word "WildCards" For details, support now for multiple searches
;                            Example *.exe; *.txt will find all .exe and .txt files
;                   $iFlag = determines weather to return file or folders or both.
;                    $sExclude = exclude a file from the list by all or part of its name
;                            Example: Unins* will remove all files/folders that start with Unins
;                        $iFlag=0(Default) Return both files and folders
;                       $iFlag=1 Return files Only
;                        $iFlag=2 Return Folders Only
;
; Requirement(s):   None
; Return Value(s):  On Success - Returns an array containing the list of files and folders in the specified path
;                        On Failure - Returns the an empty string "" if no files are found and sets @Error on errors
;                        @Error or @extended = 1 Path not found or invalid
;                        @Error or @extended = 2 Invalid $sFilter or Invalid $sExclude
;                       @Error or @extended = 3 Invalid $iFlag
;                         @Error or @extended = 4 No File(s) Found
;
; Author(s):        SmOke_N
; Note(s):            The array returned is one-dimensional and is made up as follows:
;                    $array[0] = Number of Files\Folders returned
;                    $array[1] = 1st File\Folder
;                    $array[2] = 2nd File\Folder
;                    $array[3] = 3rd File\Folder
;                    $array[n] = nth File\Folder
;
;                    All files are written to a "reserved" .tmp file (Thanks to gafrost) for the example
;                    The Reserved file is then read into an array, then deleted
;===============================================================================
Func _FileListToArrayEx($sPath, $sFilter = '*.*', $iFlag = 0, $sExclude = '', $iRecurse = False)
    If Not FileExists($sPath) Then Return SetError(1, 1, '')
    If $sFilter = -1 Or $sFilter = Default Then $sFilter = '*.*'
    If $iFlag = -1 Or $iFlag = Default Then $iFlag = 0
    If $sExclude = -1 Or $sExclude = Default Then $sExclude = ''
    Local $aBadChar[6] = ['\', '/', ':', '>', '<', '|']
    $sFilter = StringRegExpReplace($sFilter, '\s*;\s*', ';')
    If StringRight($sPath, 1) <> '\' Then $sPath &= '\'
    For $iCC = 0 To 5
        If StringInStr($sFilter, $aBadChar[$iCC]) Or _
            StringInStr($sExclude, $aBadChar[$iCC]) Then Return SetError(2, 2, '')
    Next
    If StringStripWS($sFilter, 8) = '' Then Return SetError(2, 2, '')
    If Not ($iFlag = 0 Or $iFlag = 1 Or $iFlag = 2) Then Return SetError(3, 3, '')
    Local $oFSO = ObjCreate("Scripting.FileSystemObject"), $sTFolder
    $sTFolder = $oFSO.GetSpecialFolder(2)
    Local $hOutFile = @TempDir & $oFSO.GetTempName
    If Not StringInStr($sFilter, ';') Then $sFilter &= ';'
    Local $aSplit = StringSplit(StringStripWS($sFilter, 8), ';'), $sRead, $sHoldSplit
    For $iCC = 1 To $aSplit[0]
        If StringStripWS($aSplit[$iCC],8) = '' Then ContinueLoop
        If StringLeft($aSplit[$iCC], 1) = '.' And _
            UBound(StringSplit($aSplit[$iCC], '.')) - 2 = 1 Then $aSplit[$iCC] = '*' & $aSplit[$iCC]
        $sHoldSplit &= '"' & $sPath & $aSplit[$iCC] & '" '
    Next
    $sHoldSplit = StringTrimRight($sHoldSplit, 1)
    If $iRecurse Then
        RunWait(@Comspec & ' /c dir /b /s /a ' & $sHoldSplit & ' > "' & $hOutFile & '"', '', @SW_HIDE)
    Else
        RunWait(@ComSpec & ' /c dir /b /a ' & $sHoldSplit & ' /o-e /od > "' & $hOutFile & '"', '', @SW_HIDE)
    EndIf
    $sRead &= FileRead($hOutFile)
    If Not FileExists($hOutFile) Then Return SetError(4, 4, '')
    FileDelete($hOutFile)
    If StringStripWS($sRead, 8) = '' Then SetError(4, 4, '')
    Local $aFSplit = StringSplit(StringTrimRight(StringStripCR($sRead), 1), @LF)
    Local $sHold
    For $iCC = 1 To $aFSplit[0]
        If $sExclude And StringLeft($aFSplit[$iCC], _
            StringLen(StringReplace($sExclude, '*', ''))) = StringReplace($sExclude, '*', '') Then ContinueLoop
        Switch $iFlag
            Case 0
                If StringRegExp($aFSplit[$iCC], '\w:\\') = 0 Then
                    $sHold &= $sPath & $aFSplit[$iCC] & Chr(1)
                Else
                    $sHold &= $aFSplit[$iCC] & Chr(1)
                EndIf
            Case 1
                If StringInStr(FileGetAttrib($sPath & '\' & $aFSplit[$iCC]), 'd') = 0 And _
                    StringInStr(FileGetAttrib($aFSplit[$iCC]), 'd') = 0 Then
                    If StringRegExp($aFSplit[$iCC], '\w:\\') = 0 Then
                        $sHold &= $sPath & $aFSplit[$iCC] & Chr(1)
                    Else
                        $sHold &= $aFSplit[$iCC] & Chr(1)
                    EndIf
                EndIf
            Case 2
                If StringInStr(FileGetAttrib($sPath & '\' & $aFSplit[$iCC]), 'd') Or _
                    StringInStr(FileGetAttrib($aFSplit[$iCC]), 'd') Then
                    If StringRegExp($aFSplit[$iCC], '\w:\\') = 0 Then
                        $sHold &= $sPath & $aFSplit[$iCC] & Chr(1)
                    Else
                        $sHold &= $aFSplit[$iCC] & Chr(1)
                    EndIf
                EndIf
        EndSwitch
    Next
    If StringTrimRight($sHold, 1) Then Return StringSplit(StringTrimRight($sHold, 1), Chr(1))
    Return SetError(4, 4, '')
EndFunc

Func _CreateHotkey($hWnd, $iX, $iY, $iWidth = 150, $iHeight = 150, $iStyle = 0x003010C0, $iExStyle = 0x00000200)
	$hEdit = _WinAPI_CreateWindowEx ('user32', "msctls_hotkey32", "", BitOr($WS_CHILD, $WS_VISIBLE, $WS_TABSTOP), _
		$iX, $iY, $iWidth, $iHeight, $hWnd)
	_SendMessage($hEdit, $WM_SETFONT, _WinAPI_GetStockObject($DEFAULT_GUI_FONT), True)
	Return $hEdit
EndFunc

Func _GetCode($hWnd)
	Local $ret[2]
	$i_HotKey = _SendMessage($hWnd, $HKM_GETHOTKEY)
	$ret[1] = $i_HotKey
	$n_Flag = BitShift($i_HotKey, 8); high byte
	$i_HotKeyNew = BitAND($i_HotKey, 0xFF); low byte
	$sz_Flag = ""

	$subtract = 0
	If BitAnd($n_Flag, $HOTKEYF_CONTROL) Then 
		$sz_Flag &= "CTRL + "
		$subtract += 512
	EndIf
		
	If BitAnd($n_Flag, $HOTKEYF_SHIFT) Then 
		$sz_Flag &= " SHIFT + "
		$subtract += 256
	EndIf
		
	If BitAnd($n_Flag, $HOTKEYF_ALT) Then 
		$sz_Flag &= " ALT + "
		$subtract += 1024
	EndIf 
	
	If $i_Hotkey - $subtract > 90 then 
		For $index = 96 to 105 
			If $i_Hotkey - $subtract = $index then $sz_Flag &= 'NUM ' & $index - 96
		Next
		
		
		For $index = 112 to 123 
			If $i_Hotkey - $subtract = $index then 
				$sz_Flag &= ' F' & $index - 111
			EndIf
		Next 
		
		If $i_Hotkey - $subtract >= 2081 and $i_Hotkey - $subtract <= 2093 then 
			$sz_Flag &= Chr($i_hotkeyNew)
		EndIf
	Else 
		$sz_Flag &= Chr($i_Hotkey - $subtract)
	EndIf 

	$string = $sz_Flag
				
    $temp = StringSplit($string, '+')
    
    $lastTerm = StringLower(StringStripWS($temp[Ubound($temp) - 1], 8))

    If StringLen($lastTerm) > 1 then
        If StringLeft($lastTerm, 1) = 'F' then
            $append = '{' & StringUpper($lastTerm) & '}'
        ElseIf StringLeft($lastTerm, 3) = 'NUM' then 
			$append = '{NUMPAD' & StringRight($lastTerm, 1) & '}' 
		EndIf
    Else
        $temp = StringLower(StringRight($string, 1))
        If $temp = '!' then
            $append = '{PGUP}'
        ElseIf $temp = '"' then
            $append = '{PGDN}'
        ElseIf $temp = '$' then
            $append = '{HOME}'
        ElseIf $temp = '#' then
            $append = '{END}'
        ElseIf $temp = '-' then
            $append = '{INS}'
        Else         
            $append = StringLower(StringRight($string, 1))
        EndIf
    EndIf
    
    $hotkeyAssignment = ''
    If StringInStr($string, 'CTRL') > 0 then
        $hotkeyAssignment &= '^'
    EndIf

    If StringInStr($string, 'SHIFT') > 0 then
        $hotkeyAssignment &= '+'
    EndIf

    If StringInStr($string, 'ALT') > 0 then
        $hotkeyAssignment &= '!'
    EndIf

    $hotkeyAssignment &= $append
    
;~ 	Msgbox(0, $sz_Flag, '$i_Hotkey == ' & $i_Hotkey & @CRLF & @CRLF & _ 
;~ 		'$i_HotkeyNew == ' & $i_HotkeyNew & @CRLF & @CRLF & _ 
;~ 		'$subtract == ' & $subtract & @CRLF & @CRLF & _
;~ 		'$i_Hotkey - $subtract == ' & $i_hotkey - $subtract & @CRLF & @CRLF & _
;~ 		'Chr(' & $i_Hotkey & ') = ' & Chr($i_HotKey) & @CRLF & @CRLF & _ 
;~ 		'Chr(' & $i_Hotkey & ' - ' & $subtract & ') = ' & Chr($i_HotKey - $subtract) & @CRLF & @CRLF & _ 
;~ 		'Chr(' & $i_HotkeyNew & ') = ' & Chr($i_HotKeyNew) & @CRLF & @CRLF & _ 
;~ 		'Hotkeyset string == ' & $hotkeyAssignment)
	
	$ret[0] = $hotkeyAssignment
    Return $ret
EndFunc

Func _ConvertToHotkey($value) 
	$temp = StringSplit($value, "")
	If StringInStr($value, '{PGUP}') > 0 then 
		$pgup = True 
	Else 
		$pgup = False 
	EndIf
	If StringInStr($value, '{PGDN}') > 0 then 
		$pgdn = True 
	Else 
		$pgdn = False 
	EndIf
	$return = ""
	
	For $i = 1 to $temp[0]
		Switch $temp[$i] 
			Case '^' 
				$return &= 'Ctrl + '
			Case '!'
				$return &= 'Alt + '
			Case '+' 
				$return &= 'Shift + '
			Case Else 
				$return &= StringUpper($temp[$i])
		EndSwitch 
	Next 
	
	If $pgup then 
		$return = StringTrimRight($return, 6) 
		$return &= 'Page Up'
	ElseIf $pgdn then 
		$return = StringTrimRight($return, 6) 
		$return &= 'Page Up'		
	EndIf 
	
	Return $return 
EndFunc


Func _StrToBool($string)
	If IsBool($string) then Return $string 
	Return ($string = 'True')
EndFunc


Func _ReduceMemory($i_PID = -1)
	If $i_PID <> -1 Then
		Local $ai_Handle = DllCall("kernel32.dll", 'int', 'OpenProcess', 'int', 0x1f0fff, 'int', False, 'int', $i_PID)
		Local $ai_Return = DllCall("psapi.dll", 'int', 'EmptyWorkingSet', 'long', $ai_Handle[0])
		DllCall('kernel32.dll', 'int', 'CloseHandle', 'int', $ai_Handle[0])
	Else
		Local $ai_Return = DllCall("psapi.dll", 'int', 'EmptyWorkingSet', 'long', -1)
	EndIf

	Return $ai_Return[0]
EndFunc   ;==>_ReduceMemory