; Function to return IP Address from a connected socket.
;вызов функции через "Dim $szIP_Accepted = SocketToIP($ConnectedSocket)"
Func _SocketToIP($iSocket)
    Local $stSockAddr = DllStructCreate("short;ushort;uint;char[8]")

    Local $aRet = DllCall("Ws2_32.dll", "int", "getpeername", "int", $iSocket, _
            "ptr", DllStructGetPtr($stSockAddr), "int_ptr", DllStructGetSize($stSockAddr))

    If Not @error And $aRet[0] = 0 Then
        $aRet = DllCall("Ws2_32.dll", "str", "inet_ntoa", "int", DllStructGetData($stSockAddr, 3))
        If Not @error Then $aRet = $aRet[0]
    Else
        $aRet = 0
    EndIf

    Return $aRet
EndFunc