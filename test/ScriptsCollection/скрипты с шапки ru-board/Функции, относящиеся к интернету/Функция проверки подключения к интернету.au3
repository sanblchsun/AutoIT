$connect = _GetNetworkConnect()

If $connect Then
    MsgBox(64, "Connections", $connect)
Else
    MsgBox(48, "Warning", "There is no connection")
EndIf

Func _GetNetworkConnect()
    Local Const $NETWORK_ALIVE_LAN = 0x1  ;net card connection
    Local Const $NETWORK_ALIVE_WAN = 0x2  ;RAS (internet) connection
    Local Const $NETWORK_ALIVE_AOL = 0x4  ;AOL

    Local $aRet, $iResult

    $aRet = DllCall("sensapi.dll", "int", "IsNetworkAlive", "int*", 0)

    If BitAND($aRet[1], $NETWORK_ALIVE_LAN) Then $iResult &= "LAN connected" & @LF
    If BitAND($aRet[1], $NETWORK_ALIVE_WAN) Then $iResult &= "WAN connected" & @LF
    If BitAND($aRet[1], $NETWORK_ALIVE_AOL) Then $iResult &= "AOL connected" & @LF

    Return $iResult
EndFunc