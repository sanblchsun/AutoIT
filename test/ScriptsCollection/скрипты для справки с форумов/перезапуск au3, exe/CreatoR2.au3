#Include <File.au3>

If MsgBox(36, 'Restarting...', 'Press OK to restart this script.') = 6 Then
    _ScriptRestart()
EndIf

Func _ScriptRestart()
    $sVbs = _TempFile(@TempDir, '~', '.vbs')
    $hFile = FileOpen($sVbs, 2)
    
    $sRunLine = FileGetShortName(@ScriptFullPath)
    If Not @Compiled Then $sRunLine = FileGetShortName(@AutoItExe) & ' /AutoIt3ExecuteScript ' & $sRunLine
    
    FileWriteLine($hFile, 'Set objService = GetObject("winmgmts:{impersonationLevel=impersonate}!\\.\root\CIMV2")')
    FileWriteLine($hFile, 'Set objRefresher = CreateObject("WbemScripting.SWbemRefresher")')
    FileWriteLine($hFile, 'Set colItems = objRefresher.AddEnum(objService, "Win32_Process").objectSet')
    FileWriteLine($hFile, 'Do Until False')
    FileWriteLine($hFile, '    WScript.Sleep 500')
    FileWriteLine($hFile, '    objRefresher.Refresh')
    FileWriteLine($hFile, '    Flag = True')
    FileWriteLine($hFile, '    For Each objItem in colItems')
    FileWriteLine($hFile, '        If objItem.ProcessID = ' & @AutoItPID & ' Then')
    FileWriteLine($hFile, '            Flag = False')
    FileWriteLine($hFile, '            Exit For')
    FileWriteLine($hFile, '        End If')
    FileWriteLine($hFile, '    Next')
    FileWriteLine($hFile, '    If Flag = True Then Exit Do')
    FileWriteLine($hFile, 'Loop')
    FileWriteLine($hFile, 'Set objShell = CreateObject("WScript.Shell")')
    FileWriteLine($hFile, 'objShell.Run("' & $sRunLine & '")')
    FileWriteLine($hFile, 'Set objFSO = CreateObject("Scripting.FileSystemObject")')
    FileWriteLine($hFile, 'Set File = objFSO.GetFile("' & FileGetShortName($sVbs) & '")')
    FileWriteLine($hFile, 'File.Delete')
    
    FileClose($hFile)
    ShellExecute($sVbs)
    Exit
EndFunc   ;==>_ScriptRestart