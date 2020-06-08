#include <GUIConstantsEx.au3>
#include <WindowsConstants.au3>

Global $IDLETIME, $KERNELTIME, $USERTIME
Global $StartIdle, $StartKernel, $StartUser
Global $EndIdle, $EndKernel, $EndUser
Global $Timer

$IDLETIME   = DllStructCreate("dword;dword")
$KERNELTIME = DllStructCreate("dword;dword")
$USERTIME   = DllStructCreate("dword;dword")

$hGUI = GUICreate("CPUmon", 200, 100, -1, -1, -1, $WS_EX_TOPMOST)
GUISetIcon("shell32.dll", 13)

GUICtrlCreateLabel("Total CPU Usage:", 25, 20, 105, 20)
GUICtrlSetFont(-1, 8.5, 800, Default, "MS Sans Serif")

$ValueLabel = GUICtrlCreateLabel("", 130, 20, 40, 20)
GUICtrlSetFont(-1, 8.5, 800, Default, "MS Sans Serif")

$StartButton = GUICtrlCreateButton("Start", 10, 60, 75, 23)

$StopButton = GUICtrlCreateButton("Stop", 115, 60, 75, 23)
GUICtrlSetState(-1, $GUI_DISABLE)

GUISetState()

While 1
    $msg = GUIGetMsg()
    Switch $msg
        Case $GUI_EVENT_CLOSE
            ExitLoop
        Case $StartButton
            _GetSysTime($StartIdle, $StartKernel, $StartUser)
            $Timer = TimerInit()
            
            GUICtrlSetState($StartButton, $GUI_DISABLE)
            GUICtrlSetState($StopButton, $GUI_ENABLE)
        Case $StopButton
            GUICtrlSetState($StopButton, $GUI_DISABLE)
            GUICtrlSetState($StartButton, $GUI_ENABLE)
            
            GUICtrlSetData($ValueLabel, "")
    EndSwitch
    
    If BitAND(GUICtrlGetState($StopButton), $GUI_ENABLE) And TimerDiff($Timer) >= 1000 Then
        _GetSysTime($EndIdle, $EndKernel, $EndUser)
        _CPUCalc()
        _GetSysTime($StartIdle, $StartKernel, $StartUser)
        $Timer = TimerInit()
    EndIf
WEnd

Func _GetSysTime(ByRef $sIdle, ByRef $sKernel, ByRef $sUser)
    DllCall("kernel32.dll", "int", "GetSystemTimes", "ptr", DllStructGetPtr($IDLETIME), _
            "ptr", DllStructGetPtr($KERNELTIME), _
            "ptr", DllStructGetPtr($USERTIME))

    $sIdle = DllStructGetData($IDLETIME, 1)
    $sKernel = DllStructGetData($KERNELTIME, 1)
    $sUser = DllStructGetData($USERTIME, 1)
EndFunc   ;==>_GetSysTime

Func _CPUCalc()
    Local $iSystemTime, $iTotal, $iCalcIdle, $iCalcKernel, $iCalcUser
    
    $iCalcIdle   = ($EndIdle - $StartIdle)
    $iCalcKernel = ($EndKernel - $StartKernel)
    $iCalcUser   = ($EndUser - $StartUser)
    
    $iSystemTime = ($iCalcKernel + $iCalcUser)
    $iTotal = Int(($iSystemTime - $iCalcIdle) * (100 / $iSystemTime)) & "%"
    
    If GUICtrlRead($ValueLabel) <> $iTotal Then ControlSetText($hGUI, "", $ValueLabel, $iTotal)
EndFunc   ;==>_CPUCalc
