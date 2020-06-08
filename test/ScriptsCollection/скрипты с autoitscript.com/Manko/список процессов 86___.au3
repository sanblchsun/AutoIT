#include <array.au3>    ; Needed to display array in example.

;~ typedef enum
;~ {
;~   StateInitialized,
;~   StateReady,
;~   StateRunning,
;~   StateStandby,
;~   StateTerminated,
;~   StateWait,             5
;~   StateTransition,
;~   StateUnknown,
;~ } THREAD_STATE;

;~ typedef enum
;~ {
;~   Executive,
;~   FreePage,
;~   PageIn,
;~   PoolAllocation,
;~   DelayExecution,
;~   Suspended,             5
;~   UserRequest,
;~   WrExecutive,
;~   WrFreePage,
;~   WrPageIn,
;~   WrPoolAllocation,
;~   WrDelayExecution,
;~   WrSuspended,           12
;~   WrUserRequest,
;~   WrEventPair,
;~   WrQueue,
;~   WrLpcReceive,
;~   WrLpcReply,
;~   WrVirtualMemory,
;~   WrPageOut,
;~   WrRendezvous,
;~   Spare2,
;~   Spare3,
;~   Spare4,
;~   Spare5,
;~   Spare6,
;~   WrKernel,
;~   MaximumWaitReason
;~ } KWAIT_REASON;

;~ typedef enum _SYSTEM_INFORMATION_CLASS
;~ {
;~   SystemProcessesAndThreadsInformation = 5,
;~   /* There are a lot more of these... */
;~ } SYSTEM_INFORMATION_CLASS;

;~   NTSTATUS NTAPI ZwQuerySystemInformation (IN SYSTEM_INFORMATION_CLASS,
;~                     IN OUT PVOID, IN ULONG,
;~                     OUT PULONG);
;~ }

    $tag_SYSTEM_THREADS=    "double KernelTime;" & _
                            "double UserTime;" & _
                            "double CreateTime;" & _
                            "ulong  WaitTime;" & _
                            "ptr    StartAddress;" & _
                            "dword  UniqueProcess;" & _
                            "dword  UniqueThread;" & _
                            "long   Priority;" & _
                            "long   BasePriority;" & _
                            "ulong  ContextSwitchCount;" & _
                            "long   State;" & _
                            "long   WaitReason"
                            
    $tag_SYSTEM_PROCESSES=  "ulong  NextEntryDelta;" & _
                            "ulong  Threadcount;" & _
                            "ulong[6];" & _                         ; Reserved...
                            "double CreateTime;" & _
                            "double UserTime;" & _
                            "double KernelTime;" & _
                            "ushort Length;" & _                    ; unicode string length
                            "ushort MaximumLength;" & _             ; also for unicode string
                            "ptr    ProcessName;" & _               ; ptr to mentioned unicode string - name of process
                            "long   BasePriority;" & _
                            "ulong  ProcessId;" & _
                            "ulong  InheritedFromProcessId;" & _
                            "ulong  HandleCount;" & _
                            "ulong[2];" & _                         ;Reserved...
                            "uint   PeakVirtualSize;" & _
                            "uint   VirtualSize;" & _
                            "ulong  PageFaultCount;" & _
                            "uint   PeakWorkingSetSize;" & _
                            "uint   WorkingSetSize;" & _
                            "uint   QuotaPeakPagedPoolUsage;" & _
                            "uint   QuotaPagedPoolUsage;" & _
                            "uint   QuotaPeakNonPagedPoolUsage;" & _
                            "uint   QuotaNonPagedPoolUsage;" & _
                            "uint   PagefileUsage;" & _
                            "uint   PeakPagefileUsage;" & _
                            "uint64 ReadOperationCount;" & _
                            "uint64 WriteOperationCount;" & _
                            "uint64 OtherOperationCount;" & _
                            "uint64 ReadTransferCount;" & _
                            "uint64 WriteTransferCount;" & _
                            "uint64 OtherTransferCount"

; ############ Example code #######################
$t=TimerInit()
$temp=_WinAPI_ThreadnProcess()
$temp[0][0]=TimerDiff($t)
$temp[0][1]="PID" 
$temp[0][3]="WorkingSetSize" 
$temp[0][2]="ParentPID"
$temp[0][4]="IsSuspended"
_ArrayDisplay($temp, "Non-indented.")
$t=TimerInit()
$temp=_WinAPI_ThreadnProcess(1)
$temp[0][0]=TimerDiff($t)
$temp[0][1]="PID" 
$temp[0][3]="WorkingSetSize" 
$temp[0][2]="ParentPID"
$temp[0][4]="IsSuspended"
_ArrayDisplay($temp, "Indented proclist showing relations between processes.")
$temp=0
; ###############################################


; ############ Here be example func! ####################
Func _WinAPI_ThreadnProcess($indent=0)
    Local $ret=dllcall("ntdll.dll", "int", "ZwQuerySystemInformation","int", 5, "int*", 0, "int", 0, "int*",0)
    Local $Mem=DllStructCreate("byte[" & $ret[4] & "]")
    Local $ret=dllcall("ntdll.dll", "int", "ZwQuerySystemInformation","int", 5, "ptr", DllStructGetPtr($MEM), "int", DllStructGetSize($MEM), "int*",0)
    Local $SysProc=DllStructCreate($tag_SYSTEM_PROCESSES, $ret[2])
    Local $SysProc_ptr=$ret[2]
    Local $SysProc_Size=DllStructGetSize($SysProc)
    Local $SysThread=DllStructCreate($tag_SYSTEM_THREADS)
    Local $SysThread_Size=DllStructGetSize($SysThread)
    Local $buffer, $i, $lastthread, $m=0, $NextEntryDelta, $k, $temp, $space, $l
    Local $avArray[10000][7]
    While 1
        ; Get procinfo here
        ; ...
        ; ###### Example...
        ; Get process name. Convert Unicode to string.
        $buffer=DllStructCreate("char[" & DllStructGetData($SysProc, "Length") & "]", DllStructGetData($SysProc, "ProcessName"))
        for $i=0 to DllStructGetData($SysProc, "Length")-1 step 2
            $avArray[$m][0]&=DllStructGetData($buffer, 1, $i+1)
        Next
        ; ... more data ...
        $avArray[$m][1]=DllStructGetData($SysProc, "ProcessId")
        $avArray[$m][3]=DllStructGetData($SysProc, "WorkingSetSize")/(1024) & " kB"
        $avArray[$m][2]=DllStructGetData($SysProc, "InheritedFromProcessId")
        $avArray[$m][4]=1 ; We assume suspended. When we check the threads we change it.
        $avArray[$m][5]=DllStructGetData($SysProc, "CreateTime") ;i just used it in indentation-code.
        ; ##### Example ends...
        
        ; ... over to threads...
        for $i=0 to DllStructGetData($SysProc, "Threadcount")-1
            $SysThread=DllStructCreate($tag_SYSTEM_THREADS, $SysProc_ptr+$SysProc_Size+$i*$SysThread_Size)
            ;Get Threadinfo here...
            ; ...
            ; ##### Example...
            ; Check "WaitReason" = 5 = "Suspended". If not. Process is not suspended...
            if DllStructGetData($SysThread, "WaitReason") <> 5 Then
                $avArray[$m][4]=0 ; If just one thread is active... Process is not suspended.
                ExitLoop
            Endif
            ; ##### Example ends...
            
            ; ... loop to next thread...
        next
        $NextEntryDelta=DllStructGetData($SysProc, "NextEntryDelta")
        if NOT $NextEntryDelta Then ExitLoop
            $SysProc_ptr+=$NextEntryDelta
            $SysProc=DllStructCreate($tag_SYSTEM_PROCESSES, $SysProc_ptr)
        $m+=1
        ContinueLoop    
    WEnd
    Redim $avArray[$m+1][7]
    ;###################### START INDENTATION CODE ####################################
    If $indent =1 Then
        $temp = $avArray
        $space = ""
        For $i = 1 To UBound($temp, 1) - 1
            For $m = 0 To UBound($temp, 1) - 1
                For $k = 1 To UBound($temp, 1) - 1
                    If $temp[$k][0] Then
                        If ($i - $m) < 1 Then
                            $space = ""
                            $avArray[$i][0] = $temp[$k][0]
                            $avArray[$i][1] = $temp[$k][1]
                            $avArray[$i][2] = $temp[$k][2]
                            $avArray[$i][3] = $temp[$k][3]
                            $avArray[$i][4] = $temp[$k][4]
                            $avArray[$i][5] = $temp[$k][5]
                            $temp[$k][0] = 0
                            ContinueLoop 3
                        Else
                            If $temp[$k][2] = $avArray[($i - $m - 1)][1] Then
                                While 1
                                    If $avArray[($i - $m - 1)][1] < 5 Then ExitLoop
                                    ;If Not $avArray[($i - $m - 1)][12] Then ContinueLoop 2
                                    ;msgbox(0,"",DllStructGetData($tp1,1) & @LF & DllStructGetData($tp2,1))
                                    If $temp[$k][5] > $avArray[($i - $m - 1)][5] Then ExitLoop
                                    ContinueLoop 2
                                WEnd
                                $space = ""
                                For $l = 1 To $avArray[($i - $m - 1)][6] + 1
                                    $space &= "   "
                                Next
                                $avArray[$i][0] = $space & $temp[$k][0]
                                $avArray[$i][1] = $temp[$k][1]
                                $avArray[$i][2] = $temp[$k][2]
                                $avArray[$i][6] = $avArray[($i - $m - 1)][6] + 1
                                $avArray[$i][3] = $temp[$k][3]
                                $avArray[$i][4] = $temp[$k][4]
                                $avArray[$i][5] = $temp[$k][5]
                                $temp[$k][0] = 0
                                ContinueLoop 3
                            EndIf
                        EndIf
                    EndIf
                Next
            Next
        Next
        $temp=0
    EndIf
    ;###################### END INDENTATION CODE ####################################
    ReDim $avArray[ubound($avArray,1)][5] ; Cut off 2 entries used by indentation code... Just for example...
    Return $avArray
EndFunc 
;################################ END FUNC ##########################################
