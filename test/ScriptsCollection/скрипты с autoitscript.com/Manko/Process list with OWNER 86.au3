#include <array.au3>    ; Needed to display array in example.
#include <security.au3> ; Get OWNER from SID.

$tag_WTS_PROCESS_INFO= _
  "DWORD SessionId;" & _
  "DWORD ProcessId;" & _
  "PTR pProcessName;" & _
  "PTR pUserSid"

; ############ Example code #######################
$temp=_WinAPI_ProcessListOWNER_WTS()
$temp[0][0]="Process"
$temp[0][1]="ProcessId"
$temp[0][2]="SessionId"
$temp[0][3]="ProcessOWNER"
_ArrayDisplay($temp, "Process list with OWNER...")
; ###############################################


; ############ Here be func! ####################
Func _WinAPI_ProcessListOWNER_WTS()
    $ret=DllCall("WTSApi32.dll", "int", "WTSEnumerateProcesses", "int", 0, "int", 0, "int", 1, "ptr*", 0, "int*", 0)
    Local $array[$ret[5]][4]
    $mem=DllStructCreate($tag_WTS_PROCESS_INFO,$ret[4])
    for $i=0 to $ret[5]-1
        $mem=DllStructCreate($tag_WTS_PROCESS_INFO, $ret[4]+($i*16))
        ;if DllStructGetData($mem, "pProcessName") Then
            $string=DllStructCreate("char[256]", DllStructGetData($mem, "pProcessName"))
            $array[$i][0]=DllStructGetData($string,1)
        ;EndIf
        $array[$i][1]=DllStructGetData($mem, "ProcessId")
        $array[$i][2]=DllStructGetData($mem, "SessionId")
        ;if DllStructGetData($mem, "pUserSid") Then
            $ret1 = _Security__LookupAccountSid(DllStructGetData($mem, "pUserSid"))
            if IsArray($ret1) Then $array[$i][3]=$ret1[0]
        ;EndIf
    Next
    DllCall("WTSApi32.dll", "int", "WTSFreeMemory", "int", $ret[4])
    Return $array
EndFunc
;################################ END FUNC ##########################################
