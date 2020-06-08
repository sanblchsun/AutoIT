

$Text = ""
;$timer = TimerInit() ; таймер для проверки скорости выполнения
$aReturn = _FileSearch('C:\WINDOWS', '*.*')
For $i = 1 to $aReturn[0]
	$Text &= $aReturn[$i] & @CRLF
Next
;$timer=TimerDiff($timer)
;MsgBox(0, '', $timer)
MsgBox(0, '', $Text)


Func _FileSearch($sPath, $sFileMask)
    Local $sOut, $aOut, $hDir
    
    $sOut = StringToBinary("0" & @CRLF, 2)
    $hDir = Run(@ComSpec & ' /U /C DIR "' & $sPath & '\' & $sFileMask & '" /S /B /A-D', @SystemDir, @SW_HIDE, 6)
    
    While 1
        $sOut &= StdoutRead($hDir, False, True)
        If @error Then ExitLoop
    Wend
    
    $aOut = StringRegExp(BinaryToString($sOut, 2), "[^\r\n]+", 3)
    If @error Then Return SetError(1)
    
    $aOut[0] = UBound($aOut)-1
    Return $aOut
EndFunc