HotKeySet("{F2}", "_AnalyzeRename")

While 1
    Sleep(10)
WEnd

Func _AnalyzeRename()
    HotKeySet("{F2}"); prevent infinite loop gotcha
    Send("{F2}")
    If (_WinGetClass(WinGetTitle('')) = "CabinetWClass") Or (_WinGetClass(WinGetTitle('')) = "Progman") Then
        $oldClipboard = ClipGet()
        Sleep(100)
        Send("^{insert}")
        $sFilename = ClipGet()
        $iExtPosition = StringInStr($sFilename, ".", 0, -1)
        If $iExtPosition <> 0 Then
            $iPosition = StringLen($sFilename) - $iExtPosition+1
            $i = 0
            Do
                Send("+{LEFT}")
                $i += 1
            Until $i = $iPosition
            Send("{SHIFTDOWN}{SHIFTUP}")
        EndIf
        ClipPut($oldClipboard)
    EndIf
    HotKeySet("{F2}", "_AnalyzeRename"); re-enable hotkey
EndFunc

Func _WinGetClass($hWnd)
; credit = SmOke_N from post http://www.autoitscript.com/forum/index.php?showtopic=41622&view=findpost&p=309799
    If IsHWnd($hWnd) = 0 And WinExists($hWnd) Then $hWnd = WinGetHandle($hWnd)
    Local $aGCNDLL = DllCall('User32.dll', 'int', 'GetClassName', 'hwnd', $hWnd, 'str', '', 'int', 4095)
    If @error = 0 Then Return $aGCNDLL[2]
    Return SetError(1, 0, '')
EndFunc
