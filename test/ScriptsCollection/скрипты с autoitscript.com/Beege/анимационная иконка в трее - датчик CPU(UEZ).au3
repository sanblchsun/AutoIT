#include "TIG.au3"
Local $bColor, $fColor
Local $TotalCpu, $nProcessCpu, $StartUser, $StartIdle, $StartKernel, $ProcStartKern, $ProcStartUser
AdlibRegister("_ProcessCalc", 1000)
GUISetState()
HotKeySet('{ESC}', '_exit')

_TIG_CreateTrayGraph(0, 100)
$bColor = 0xFF000000
$fColor = 0xFF00A000
_TIG_SetBackGoundColor($bColor)
_TIG_SetBarColor($fColor)

While Sleep(100000000)
WEnd

Func _Exit()
    AdlibUnRegister("_ProcessCalc")
    Exit
EndFunc ;==>_Exit

Func _ProcessCalc()
    Local $tProcess, $tSystem, $tSystemt
    Local $IdleTime = DllStructCreate($tagFileTime), $KernelTime = DllStructCreate($tagFileTime), $UserTime = DllStructCreate($tagFileTime)
    Local $PCreationTime = DllStructCreate($tagFileTime), $PExitTime = DllStructCreate($tagFileTime), $hScriptHandle = _WinAPI_GetCurrentProcess()
    Local $PKernelTime = DllStructCreate($tagFileTime), $PUserTime = DllStructCreate($tagFileTime)
    DllCall('Kernel32.dll', "int", "GetSystemTimes", "ptr", DllStructGetPtr($IdleTime), "ptr", DllStructGetPtr($KernelTime), "ptr", DllStructGetPtr($UserTime))
    DllCall('Kernel32.dll', "int", "GetProcessTimes", "hwnd", $hScripthandle, "ptr", DllStructGetPtr($PCreationTime), "ptr", DllStructGetPtr($PExitTime), "ptr", DllStructGetPtr($PKernelTime), "ptr", DllStructGetPtr($PUserTime))
    $tProcess = (DllStructGetData($PKernelTime, 1) - $ProcStartKern) + (DllStructGetData($PUserTime, 1) - $ProcStartUser)
    $tSystem = (DllStructGetData($KernelTime, 1) - $StartKernel) + (DllStructGetData($UserTime, 1) - $StartUser)
    $tSystemt = (($tSystem - (DllStructGetData($IdleTime, 1) - $StartIdle)) * (100 / $tSystem))
    $ProcStartKern = DllStructGetData($PKernelTime, 1)
    $ProcStartUser = DllStructGetData($PUserTime, 1)
    $StartIdle = DllStructGetData($IdleTime, 1)
    $StartKernel = DllStructGetData($KernelTime, 1)
    $StartUser = DllStructGetData($UserTime, 1)
    $ProcessCPU = ($tProcess / $tSystem) * 100
    $TotalCPU = Round($tSystemt, 0)
    _TIG_UpdateTrayGraph($TotalCpu)
;~  ConsoleWrite('Total CPU Usage = ' & $TotalCpu & '%' & @CRLF)
    Return $TotalCpu
EndFunc ;==>_ProcessCalc
 
