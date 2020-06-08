HotKeySet('^{1}', '_OpenActive') ;Ctrl+1 - открыть папку активного окна. 
HotKeySet('{Esc}', '_Exit') ; Esc - выход 
While 1 
    Sleep(100) 
WEnd 
 
Func _OpenActive() 
    Local $hActive, $sClass, $iPID, $sPath 
 
    $hActive = WinGetHandle('[ACTIVE]') 
    If Not $hActive Then Return 
    $sClass = _WinGetClass($hActive) 
    If $sClass == 'CabinetWClass' Or $sClass == 'Progman' Or $sClass == 'Shell_TrayWnd' Then Return 
    $iPID = WinGetProcess($hActive) 
    $sPath = _ProcessGetPath($iPID) 
    If @error Then Return 
    ;только папку открыть: 
    $sPath = StringRegExpReplace($sPath, '\\[^\\]*$', '') 
    ShellExecute($sPath) 
    ;открыть папку и выделить файл: 
    ;Run('Explorer.exe /select,"' & $sPath & '"') 
EndFunc   ;==>_OpenActive 
 
Func _Exit() 
    Exit 
EndFunc   ;==>_Exit 

;извлечь путь процесса зная PID
Func _ProcessGetPath($PID)
    If IsString($PID) Then $PID = ProcessExists($PID)
    $Path = DllStructCreate('char[1000]')
    $dll = DllOpen('Kernel32.dll')
    $handle1 = DllCall($dll, 'int', 'OpenProcess', 'dword', 0x0400 + 0x0010, 'int', 0, 'dword', $PID)
    $ret = DllCall('Psapi.dll', 'long', 'GetModuleFileNameEx', 'long', $handle1[0], 'int', 0, 'ptr', DllStructGetPtr($Path), 'long', DllStructGetSize($Path))
    $ret = DllCall($dll, 'int', 'CloseHandle', 'hwnd', $handle1[0])
    DllClose($dll)
    Return DllStructGetData($Path, 1)
EndFunc  ;==>_ProcessGetPath

Func _WinGetClass($hWnd)
; credit = SmOke_N from post http://www.autoitscript.com/forum/index.php?showtopic=41622&view=findpost&p=309799
    If IsHWnd($hWnd) = 0 And WinExists($hWnd) Then $hWnd = WinGetHandle($hWnd)
    Local $aGCNDLL = DllCall('User32.dll', 'int', 'GetClassName', 'hwnd', $hWnd, 'str', '', 'int', 4095)
    If @error = 0 Then Return $aGCNDLL[2]
    Return SetError(1, 0, '')
EndFunc