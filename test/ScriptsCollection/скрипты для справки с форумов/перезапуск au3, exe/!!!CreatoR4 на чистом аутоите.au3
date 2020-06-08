; http://autoit-script.ru/index.php/topic,309.msg2812.html#msg2812

If MsgBox(36, 'Restarting...', 'Press OK to restart this script.') = 6 Then
    _ScriptRestart()
EndIf

Func _ScriptRestart()
    Local $sAutoIt_File = @TempDir & "\~Au3_ScriptRestart_TempFile.au3"
    Local $sRunLine, $sScript_Content, $hFile
    
    $sRunLine = @ScriptFullPath
    If Not @Compiled Then $sRunLine = @AutoItExe & ' /AutoIt3ExecuteScript ""' & $sRunLine & '""'
    If $CmdLine[0] > 0 Then $sRunLine &= ' ' & $CmdLineRaw
    
    $sScript_Content &= '#NoTrayIcon' & @CRLF
    $sScript_Content &= 'While ProcessExists(' & @AutoItPID & ')' & @CRLF
    $sScript_Content &= '   Sleep(10)' & @CRLF
    $sScript_Content &= 'WEnd' & @CRLF
    $sScript_Content &= 'Run("' & $sRunLine & '")' & @CRLF
    $sScript_Content &= 'FileDelete(@ScriptFullPath)' & @CRLF
    
    $hFile = FileOpen($sAutoIt_File, 2)
    FileWrite($hFile, $sScript_Content)
    FileClose($hFile)
    
    Run(@AutoItExe & ' /AutoIt3ExecuteScript "' & $sAutoIt_File & '"', @ScriptDir, @SW_HIDE)
    Sleep(1000)
    Exit
EndFunc