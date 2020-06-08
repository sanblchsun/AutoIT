$ProcessName = "AutoIt3.exe"

$RetArr = _ProcessExistsVbs($ProcessName)

If IsArray($RetArr) Then MsgBox(64, "", "Process <" & $RetArr[1] & "> exists." & @LF & @LF & _
    "The returned PID is: " & $RetArr[2] & @LF & @LF & _
    "Returned Executable Path is: " & @LF & $RetArr[3] & @LF & @LF & _
    "Command Line of executed process is: " & @LF & $RetArr[4])

;Функция возвращает массив содержащий имя процесса, его уникальный идентификатор (PID), путь запуска, и коммандную строку запуска.
;В случае если указанный процесс не существует, возвращается 0.
Func _ProcessExistsVbs($ProcName)
    Local $Code = ""
    $Code &= 'Function ProcessExists(ProcessName)' & @LF
    $Code &= '  Set Processes = GetObject("winmgmts://localhost")' & @LF
    $Code &= '  Set myProcEnum = Processes.ExecQuery("select * from Win32_Process")' & @LF
    $Code &= '  For Each Proc In myProcEnum' & @LF
    $Code &= '      If StrComp(Proc.Name, ProcessName, 1) = 0 Or StrComp(Proc.ProcessID, ProcessName, 1) = 0 Then' & @LF
    $Code &= '          Dim RetArr' & @LF
    $Code &= '          RetArr = Array(4, Proc.Name, Proc.ProcessID, Proc.ExecutablePath, Proc.CommandLine)' & @LF
    $Code &= '          ProcessExists = RetArr' & @LF
    $Code &= '          Exit Function' & @LF
    $Code &= '      End If' & @LF
    $Code &= '  Next' & @LF
    $Code &= '  ProcessExists = 0' & @LF
    $Code &= 'End Function'

    Local $VbsObj = ObjCreate("ScriptControl")
    If @error Then Return SetError(1, 0, -1)

    $VbsObj.Language = "vbscript"
    $VbsObj.AddCode($Code)
    Local $RetArr = $VbsObj.Run("ProcessExists", $ProcName)
    If $RetArr = 0 Then Return SetError(0, 0, 0)
    Return $RetArr
EndFunc