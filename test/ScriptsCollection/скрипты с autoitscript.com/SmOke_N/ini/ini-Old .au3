Func _IniDeleteEx($hFile, $vSection, $vKey = '')
    Local $iSize = FileGetSize($hFile) / 1024
    If $iSize <= 31 Then Return IniDelete($hFile, $vSection, $vKey)
    Local $sString = FileRead($hFile)
    Local $sFRead = @CRLF & $sString & @CRLF & '['
    $vSection = StringStripWS($vSection, 7)
    Local $aData = StringRegExp($sFRead, '(?s)(?i)\n\s*\[\s*' & $vSection & '\s*\]\s*\r\n(.*?)\[', 3)
    If IsArray($aData) = 0 Then Return SetError(1, 0, 0)
    $aData[0] = StringRegExpReplace($aData[0], '(\r\n)+$', '')
    If $vKey = '' Then
        $sString = StringRegExpReplace($sString, '(?s)(?i)(^|\n)\s*\[\s*' & $vSection & '\s*\]\s*(\r\n)+' & StringReplace($aData[0], '\', '\\'), @LF & @CRLF)
    Else
        $sString = StringRegExpReplace($aData[0], '(?s)(?i)\n\s*' & $vKey & '\s*=.*?(?m:\r\n|$)', @LF)
    EndIf
    $sString = StringRegExpReplace($sString, '(^(\r\n)+)+|^\r+|^\n+|(\r\n)+$|\[$', '')
    $sString = StringRegExpReplace($sString, '(\r\n){3}', @CRLF)
    $sString = StringRegExpReplace($sString, '(^(\r\n)+)+', '')
    FileClose(FileOpen($hFile, 2))
    Return FileWrite($hFile, $sString)
EndFunc

Func _IniWriteEx($hFile, $vSection, $vKey, $vValue)
    If FileExists($hFile) = 0 Then FileClose(FileOpen($hFile, 2))
    Local $iSize = FileGetSize($hFile) / 1024
    If $iSize <= 31 Then Return IniWrite($hFile, $vSection, $vKey, $vValue)
    Local $sString = FileRead($hFile)
    Local $sFRead = @CRLF & $sString & @CRLF & '['
    $vSection = StringStripWS($vSection, 7)
    Local $aData = StringRegExp($sFRead, '(?s)(?i)\n\s*\[\s*' & $vSection & '\s*\]\s*\r\n(.*?)\[', 3)
    If IsArray($aData) = 0 Then
        If StringRegExp($sString, '(?s)\r\n$') = 0 Then
            $sString &= @CRLF & '[' & $vSection & ']' & @CRLF & $vKey & '=' & $vValue
        Else
            $sString &= '[' & $vSection & ']' & @CRLF & $vKey & '=' & $vValue
        EndIf
        FileClose(FileOpen($hFile, 2))
        Return FileWrite($hFile, $sString)
    EndIf
    $aData[0] = StringRegExpReplace($aData[0], '(\r\n)+$', '')
    If StringRegExp(@LF & $aData[0] & @CRLF, '(?s)(?i)\n\s*' & $vKey & '\s*=') Then
        Local $sTempReplace = StringRegExpReplace(@LF & $aData[0] & @CR, _
            '(?s)(?i)\n\s*' & $vKey & '=.*?\r', @LF & $vKey & '=' & StringReplace($vValue, '\', '\\') & @CR)
        $aData[0] = StringRegExpReplace($sTempReplace, '^\r\n|^\s*\n|^\s*\r|\r$', '')
    Else
        $aData[0] = StringReplace($aData[0] & @CRLF & $vKey & '=' & $vValue, '\', '\\')
    EndIf
    $sString = StringRegExpReplace(@LF & $sString & _
        '[', '(?s)(?i)(^|\n)\s*\[\s*' & $vSection & '\s*\]\s*\r\n.*?\s*\[', @LF & @CRLF & '\[' & $vSection & '\]' & @CRLF & $aData[0] & @CRLF & @CRLF & '\[')
    $sString = StringRegExpReplace($sString, '(^(\r\n)+)+|^\r+|^\n+|\[$|(\r\n)+$', '')
    FileClose(FileOpen($hFile, 2))
    Return FileWrite($hFile, $sString)
EndFunc

Func _IniReadSectionNamesEx($hFile)
    Local $iSize = FileGetSize($hFile) / 1024
    If $iSize <= 31 Then
        Local $aNameRead = IniReadSectionNames($hFile)
        If @error Then Return SetError(@error, 0, '')
        Return $aNameRead
    EndIf
    Local $aSectionNames = StringRegExp(@CRLF & FileRead($hFile) & @CRLF, '(?s)\n\s*\[(.*?)\]s*\r', 3)
    If IsArray($aSectionNames) = 0 Then Return SetError(1, 0, 0)
    Local $nUbound = UBound($aSectionNames)
    Local $aNameReturn[$nUbound + 1]
    $aNameReturn[0] = $nUbound
    For $iCC = 0 To $nUBound - 1
        $aNameReturn[$iCC + 1] = $aSectionNames[$iCC]
    Next
    Return $aNameReturn
EndFunc

Func _IniReadSectionEx($hFile, $vSection)
    Local $iSize = FileGetSize($hFile) / 1024
    If $iSize <= 31 Then 
        Local $aSecRead = IniReadSection($hFile, $vSection)
        If @error Then Return SetError(@error, 0, '')
        Return $aSecRead
    EndIf
    Local $sFRead = @CRLF & FileRead($hFile) & @CRLF & '['
    $vSection = StringStripWS($vSection, 7)
    Local $aData = StringRegExp($sFRead, '(?s)(?i)\n\s*\[\s*' & $vSection & '\s*\]\s*\r\n(.*?)\[', 3)
    If IsArray($aData) = 0 Then Return SetError(1, 0, 0)
    Local $aKey = StringRegExp(@LF & $aData[0], '\n\s*(.*?)\s*=', 3)
    Local $aValue = StringRegExp(@LF & $aData[0], '\n\s*.*?\s*=(.*?)\r', 3)
    Local $nUbound = UBound($aKey)
    Local $aSection[$nUBound +1][2]
    $aSection[0][0] = $nUBound
    For $iCC = 0 To $nUBound - 1
        $aSection[$iCC + 1][0] = $aKey[$iCC]
        $aSection[$iCC + 1][1] = $aValue[$iCC]
    Next
    Return $aSection
EndFunc

Func _IniReadEx($hFile, $vSection, $vKey, $vDefault = -1)
    If $vDefault = -1 Or $vDefault = Default Then $vDefault = ''
    Local $iSize = FileGetSize($hFile) / 1024
    If $iSize <= 31 Then Return IniRead($hFile, $vSection, $vKey, $vDefault)
    Local $sFRead = @CRLF & FileRead($hFile) & @CRLF & '['
    $vSection = StringStripWS($vSection, 7)
    Local $aData = StringRegExp($sFRead, '(?s)(?i)\n\s*\[\s*' & $vSection & '\s*\]\s*\r\n(.*?)\[', 3)
    If IsArray($aData) = 0 Then Return SetError(1, 0, 0)
    Local $aRead = StringRegExp(@LF & $aData[0], '(?s)(?i)\n\s*' & $vKey & '\s*=(.*?)\r', 1)
    If IsArray($aRead) = 0 Then Return SetError(2, 0, 0)
    Return $aRead[0]
EndFunc