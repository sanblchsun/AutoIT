Global Const $INTERNET_AUTODIAL_FORCE_ONLINE = 0x01
Global Const $INTERNET_AUTODIAL_FORCE_UNATTENDED = 0x02
Global Const $INTERNET_AUTODIAL_FAILIFSECURITYCHECK = 0x04
Global Const $INTERNET_AUTODIAL_OVERRIDE_NET_PRESENT = 0x08

If _InetDisconnect() Then
    MsgBox(0,'Сообщение','Подключение разорвано')
Else
    MsgBox(16,'Ошибка','При разрыве подключения произошла ошибка')
EndIf

If _InetConnect($INTERNET_AUTODIAL_FORCE_ONLINE + $INTERNET_AUTODIAL_FORCE_UNATTENDED) Then
    MsgBox(0,'Сообщение','Подключение установлено')
Else
    MsgBox(16,'Ошибка','В процессе подключения произошла ошибка')
EndIf

Func _InetConnect($iFlags = 0x01, $hWnd = 0)
    Local $ret = DllCall('wininet.dll', 'int', 'InternetAutodial', 'dword', $iFlags, 'hwnd', $hWnd)
    If Not $ret[0] Then
        $ret = DllCall('kernel32.dll', 'int', 'GetLastError')
        Return SetError(1, $ret[0], False)
    EndIf
    Return True
EndFunc

Func _InetDisconnect()
    Local $ret = DllCall('wininet.dll', 'int', 'InternetAutodialHangup', 'dword', 0)
    If Not $ret[0] Then
        $ret = DllCall('kernel32.dll', 'int', 'GetLastError')
        Return SetError(1, $ret[0], False)
    EndIf
    Return True
EndFunc