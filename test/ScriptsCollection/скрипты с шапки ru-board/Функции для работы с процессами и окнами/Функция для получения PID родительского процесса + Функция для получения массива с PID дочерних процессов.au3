#include <Process.au3>
#include <Array.au3>
;

$iParent_ProcID = _ProcessGetParent(@AutoItPID)
$sParent_ProcName = _ProcessGetName($iParent_ProcID)

MsgBox(64, "_ProcessGetParent", _
        StringFormat("Parent Process ID (PID): %i\nParent Process Name: %s", $iParent_ProcID, $sParent_ProcName))

$a_children = _ProcessGetChildren($iParent_ProcID)
_ArrayDisplay($a_children)

;===================================================================================================
; Function Name:    _ProcessGetParent()
;
; Description:      Retrieve parent process for a child process
;
; Parameter(s):     $i_pid: The process identifier of the process you want to get the parent
;                       process identifier for
;
; Return Value(s):
;                 On Success:
;                   Parent PID (process identifier)
;
;                 On Failure:
;                   PID of process passed (Check @error to make sure it is a parent and didn't
;                       fail)
;
;                 @Error:
;                   (1): CreateToolhelp32Snapshot failed
;                   (2): Process32First failed
;
; Remark(s):        Tested on Windows XP SP2
;
; Author(s):        SmOke_N (Ron Nielsen)
;
;===================================================================================================
Func _ProcessGetParent($i_Pid)
    Local Const $TH32CS_SNAPPROCESS = 0x00000002

    Local $a_tool_help = DllCall("Kernel32.dll", "long", "CreateToolhelp32Snapshot", "int", $TH32CS_SNAPPROCESS, "int", 0)
    If IsArray($a_tool_help) = 0 Or $a_tool_help[0] = -1 Then Return SetError(1, 0, $i_Pid)

    Local $tagPROCESSENTRY32 = DllStructCreate( _
            "dword dwsize;" & _
            "dword cntUsage;" & _
            "dword th32ProcessID;" & _
            "uint th32DefaultHeapID;" & _
            "dword th32ModuleID;" & _
            "dword cntThreads;" & _
            "dword th32ParentProcessID;" & _
            "long pcPriClassBase;" & _
            "dword dwFlags;" & _
            "char szExeFile[260]")

    DllStructSetData($tagPROCESSENTRY32, 1, DllStructGetSize($tagPROCESSENTRY32))

    Local $p_PROCESSENTRY32 = DllStructGetPtr($tagPROCESSENTRY32)

    Local $a_pfirst = DllCall("Kernel32.dll", "int", "Process32First", "long", $a_tool_help[0], "ptr", $p_PROCESSENTRY32)
    If IsArray($a_pfirst) = 0 Then Return SetError(2, 0, $i_Pid)

    Local $a_pnext, $i_return = 0

    If DllStructGetData($tagPROCESSENTRY32, "th32ProcessID") = $i_Pid Then
        $i_return = DllStructGetData($tagPROCESSENTRY32, "th32ParentProcessID")
        DllCall("Kernel32.dll", "int", "CloseHandle", "long", $a_tool_help[0])

        If $i_return Then Return $i_return
        Return $i_Pid
    EndIf

    While 1
        $a_pnext = DllCall("Kernel32.dll", "int", "Process32Next", "long", $a_tool_help[0], "ptr", $p_PROCESSENTRY32)
        If IsArray($a_pnext) And $a_pnext[0] = 0 Then ExitLoop
        If DllStructGetData($tagPROCESSENTRY32, "th32ProcessID") = $i_Pid Then
            $i_return = DllStructGetData($tagPROCESSENTRY32, "th32ParentProcessID")
            If $i_return Then ExitLoop
            $i_return = $i_Pid
            ExitLoop
        EndIf
    WEnd

    If $i_return = "" Then $i_return = $i_Pid

    DllCall("Kernel32.dll", "int", "CloseHandle", "long", $a_tool_help[0])
    Return $i_return
EndFunc   ;==>_ProcessGetParent

;===================================================================================================
; Function Name:    _ProcessGetChildren()
;
; Description:      Retrieve an array of all top level child processes
;
; Parameter(s):     $i_pid: The process identifier of the process you want to list the child
;                       processes from
;
; Return Value(s):
;                 On Success:
;                   2 dimensional array:
;                   [0][0] number of child processes found
;                   [n][0] is the process id of the child
;                   [n][1] is the process name of the child
;
;                 On Failure:
;                   Non array
;
;                 @Error:
;                   (1): CreateToolhelp32Snapshot failed
;                   (2): Process32First failed
;                   (3): No children processes found
;
; Remark(s):        Tested on Windows XP SP2
;
; Author(s):        SmOke_N (Ron Nielsen)
;
;===================================================================================================
Func _ProcessGetChildren($i_Pid) ; First level children processes only
    Local Const $TH32CS_SNAPPROCESS = 0x00000002

    Local $a_tool_help = DllCall("Kernel32.dll", "long", "CreateToolhelp32Snapshot", "int", $TH32CS_SNAPPROCESS, "int", 0)
    If IsArray($a_tool_help) = 0 Or $a_tool_help[0] = -1 Then Return SetError(1, 0, $i_Pid)

    Local $tagPROCESSENTRY32 = _
            DllStructCreate( _
            "dword dwsize;" & _
            "dword cntUsage;" & _
            "dword th32ProcessID;" & _
            "uint th32DefaultHeapID;" & _
            "dword th32ModuleID;" & _
            "dword cntThreads;" & _
            "dword th32ParentProcessID;" & _
            "long pcPriClassBase;" & _
            "dword dwFlags;" & _
            "char szExeFile[260]")

    DllStructSetData($tagPROCESSENTRY32, 1, DllStructGetSize($tagPROCESSENTRY32))

    Local $p_PROCESSENTRY32 = DllStructGetPtr($tagPROCESSENTRY32)

    Local $a_pfirst = DllCall("Kernel32.dll", "int", "Process32First", "long", $a_tool_help[0], "ptr", $p_PROCESSENTRY32)
    If IsArray($a_pfirst) = 0 Then Return SetError(2, 0, $i_Pid)

    Local $a_pnext, $a_children[11][2] = [[10]], $i_child_pid, $i_parent_pid, $i_add = 0
    $i_child_pid = DllStructGetData($tagPROCESSENTRY32, "th32ProcessID")

    If $i_child_pid <> $i_Pid Then
        $i_parent_pid = DllStructGetData($tagPROCESSENTRY32, "th32ParentProcessID")

        If $i_parent_pid = $i_Pid Then
            $i_add += 1
            $a_children[$i_add][0] = $i_child_pid
            $a_children[$i_add][1] = DllStructGetData($tagPROCESSENTRY32, "szExeFile")
        EndIf
    EndIf

    While 1
        $a_pnext = DllCall("Kernel32.dll", "int", "Process32Next", "long", $a_tool_help[0], "ptr", $p_PROCESSENTRY32)
        If IsArray($a_pnext) And $a_pnext[0] = 0 Then ExitLoop

        $i_child_pid = DllStructGetData($tagPROCESSENTRY32, "th32ProcessID")

        If $i_child_pid <> $i_Pid Then
            $i_parent_pid = DllStructGetData($tagPROCESSENTRY32, "th32ParentProcessID")

            If $i_parent_pid = $i_Pid Then
                If $i_add = $a_children[0][0] Then
                    ReDim $a_children[$a_children[0][0] + 11][2]
                    $a_children[0][0] = $a_children[0][0] + 10
                EndIf

                $i_add += 1
                $a_children[$i_add][0] = $i_child_pid
                $a_children[$i_add][1] = DllStructGetData($tagPROCESSENTRY32, "szExeFile")
            EndIf
        EndIf
    WEnd

    If $i_add <> 0 Then
        ReDim $a_children[$i_add + 1][2]
        $a_children[0][0] = $i_add
    EndIf

    DllCall("Kernel32.dll", "int", "CloseHandle", "long", $a_tool_help[0])

    If $i_add Then Return $a_children
    Return SetError(3, 0, 0)
EndFunc   ;==>_ProcessGetChildren