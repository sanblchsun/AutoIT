#NoTrayIcon
#include <GUIConstantsEx.au3>
#include <GUIConstants.au3>
#include <WindowsConstants.au3>
#include <StaticConstants.au3>
#include <Misc.au3>
#include <Constants.au3>
#include <WinAPI.au3>
Opt("TrayIconHide", 1)
Opt("GUIOnEventMode", 1)


Global Const $STN_DBLCLK = 1
;Global Const $WM_MBUTTONDBLCLK = 0x209
Global Const $WM_MOUSEHOVER = 0x2A1
;Global Const $WM_RBUTTONDBLCLK = 0x206

Global $XX, $YY

Global Const $TME_CANCEL = 0x80000000
Global Const $TME_HOVER = 0x1
Global Const $TME_LEAVE = 0x2
Global Const $TME_NONCLIENT = 0x10
Global Const $TME_QUERY = 0x40000000
Global Const $HOVER_DEFAULT = 0xFFFFFFFF
Global $X_Prev, $Y_Prev
Global Const $tagTRACKMOUSEEVENT = "dword Size;dword Flags;hwnd hWndTrack;dword HoverTime"
Global Const $MK_CONTROL = 0x8
Global Const $MK_LBUTTON = 0x1
Global Const $MK_MBUTTON = 0x10
Global Const $MK_RBUTTON = 0x2
Global Const $MK_SHIFT = 0x4
Global Const $MK_XBUTTON1 = 0x20
Global Const $MK_XBUTTON2 = 0x40
$hDLL = DllOpen("user32.dll")


$AYAR = @ScriptDir & "\data\CAFE_Set.cnk"
$iletisimpass = "A3"

$pencere = ""
If @Compiled Then
    If $CmdLine[0] > 0 Then Global $izlenen = $CmdLine[1]
    If $CmdLine[0] > 1 Then Global $olay = $CmdLine[2]
    If $CmdLine[0] > 2 Then Global $pencere = $CmdLine[3]
Else
    $izlenen = "192.168.0.45" ; Test Client ip
    $olay = "kontrol"
    ;Global $pencere = "bmp"
    Global $pencere = ""
EndIf


If $olay = "kontrol" Then
    Global $sHexKeys, $sMouse, $sString, $hHookKeyboard, $pStub_KeyProc

    $pStub_KeyProc = DllCallbackRegister("_KeyProc", "int", "int;ptr;ptr")
    $hHookKeyboard = _WinAPI_SetWindowsHookEx($WH_KEYBOARD_LL, DllCallbackGetPtr($pStub_KeyProc), _WinAPI_GetModuleHandle(0), 0)
EndIf


If $pencere = "full" Then $pencere = ""

If StringLen($izlenen) < 3 Then Exit
$first = 1
$PORT = 5484
Global $iCount = 0

$begin = TimerInit()
$beginout = 10000 ; 10 sec.
$Mousetasi = 0
$MouseDelay = 0
;$begin=TimerInit()
Global $Picizle, $Formizle
Global $iwidth, $iheight

TCPStartup()
Global $iMainSocket, $iAccSocket = -1, $sBuff, $sRecv = "", $i = 0, $iFirstWhile = True


While 1
    $iMainSocket = -1
    While $iMainSocket = -1
        $iMainSocket = TCPConnect($izlenen, $PORT)
        Sleep(20)
        If ($first = 1) AND ($beginout < TimerDiff($begin)) Then
            MsgBox(0, "TIMEOUT", "Sunucuya [ " & $izlenen & " ] Baglant? Saglanamad?", 10000)
            Exit
        EndIf
    WEnd
    $go = -1
    While $go = -1
        $go = TCPSend($iMainSocket, $iletisimpass & "|gonder" & $pencere)
    WEnd
    Oku()
    TCPCloseSocket($iMainSocket)
    ;Sleep(10)
    If $olay = "shot" Then shot()

WEnd


Func Oku()
    $sRecv = ""
    While $sRecv = ""
        $sRecv = TCPRecv($iMainSocket, 2048)
        If @error Then Return
        ;ConsoleWrite($sRecv)
        If $sRecv <> "" Then ExitLoop
    WEnd
    If StringLen($sRecv) > 16 Then Return
    $rcv = StringSplit($sRecv, "|")
    $iwidth = $rcv[2]
    $iheight = $rcv[3]
    ;$iwidth="1024"
    ;$iheight="768"
    If $first = 1 Then
        Form($iwidth, $iheight)
        Global $ctrl_hWnd = DllCall("user32.dll", "hwnd", "GetDlgItem", "hwnd", $Formizle, "int", $Picizle)
    EndIf
    $sRecv = ""
    GetImages($iMainSocket, $ctrl_hWnd[0])
EndFunc   ;==>Oku



Func GetImages($Socket, $hCtrlm)
    Local $BitMapData, $BitMap, $stBitmap

    $BitMap = ""
    $BitMap = Binary($BitMap)
    $BitMapData = ""
    While 1
        $BitMapData = TCPRecv($Socket, 65535, 1)
        If @error Then ExitLoop
        If BinaryLen($BitMapData) <> 0 Then $BitMap &= $BitMapData
    WEnd
    If BinaryLen($BitMap) Then
        $iCount += 1
        $stBitmap = DllStructCreate("byte [" & BinaryLen($BitMap) & "]")
        DllStructSetData($stBitmap, 1, $BitMap)
        ;ConsoleWrite("[.." & BinaryLen($BitMap) & "..]" & $iCount & @CRLF)
        If Not @Compiled Then ToolTip(BinaryLen($BitMap) & ":" & $iCount, 0, 0)
        ShowImage(DllStructGetPtr($stBitmap), $iwidth, $iheight, $hCtrlm)
        $BitMap = ""
        $stBitmap = 0
    EndIf

EndFunc   ;==>GetImages


Func ShowImage($byteStruct, $wid, $hgt, $hCtrlm)
    Local Const $DIB_RGB_COLORS = 0
    Local Const $SRCCOPY = 0xCC0020
    Local Const $STM_SETIMAGE = 0x0172
    Local Const $IMAGE_BITMAP = 0
    Local $lpInfo = DllStructCreate("dword;int;int;ushort;ushort;dword;dword;int;int;dword;dword;byte[1024]")
    DllStructSetData($lpInfo, 1, 40)
    DllStructSetData($lpInfo, 2, $wid)
    DllStructSetData($lpInfo, 3, $hgt)
    DllStructSetData($lpInfo, 4, 1)
    DllStructSetData($lpInfo, 5, 24)
    ;Local $pic_hWnd = DllCall("user32.dll", "hwnd", "GetDlgItem", "hwnd", $Formizle, "int", $Picizle)
    ;$pic_hWnd = $pic_hWnd[0]
    Local $pic_hWnd = _WinAPI_GetDlgItem($Formizle, $Picizle)
    ;Local $dc = DllCall("user32.dll", "int", "GetDC", "hwnd", $pic_hWnd)
    Local $dc = _WinAPI_GetDC($pic_hWnd)
    ;$dc = _WinAPI_CreateCompatibleDC($dc)

    ;Local $hBitmap = DllCall("gdi32.dll", "hwnd", "CreateCompatibleBitmap", "int", $dc[0], "int", $wid, "int", $hgt)
    ;$hBitmap = $hBitmap[0]
    $hBitmap = _WinAPI_CreateCompatibleBitmap($dc, $wid, $hgt)

    DllCall("gdi32.dll", "int", "SetDIBits", "int", $dc, "hwnd", $hBitmap, "int", 0, "int", $hgt, "ptr", $byteStruct, "ptr", DllStructGetPtr($lpInfo), "int", $DIB_RGB_COLORS)
    ;DllCall("user32.dll", "int", "SendMessage", "hwnd", $hCtrlm, "int", $STM_SETIMAGE, "int", $IMAGE_BITMAP, "hwnd", $hBitmap)
    ;DllCall("user32.dll", "int", "ReleaseDC", "hwnd", $hCtrlm, "int", $dc[0])

    _SetBitmapToCtrl($Picizle, $hBitmap)
    ;_WinAPI_RedrawWindow($Formizle)
    ;_WinAPI_RedrawWindow($Formizle,0,0,BitOR($RDW_ERASE,$RDW_INVALIDATE,$RDW_UPDATENOW,$RDW_FRAME,$RDW_ALLCHILDREN))

    $lpInfo = 0
EndFunc   ;==>ShowImage




Func GDIPlus_BitmapGetPixel($hBitmap, $iX, $iY)
    Local $tArgb, $pArgb, $aRet
    $tArgb = DllStructCreate("dword Argb")
    $pArgb = DllStructGetPtr($tArgb)
    $aRet = DllCall("gdi32.dll", "int", "GdipBitmapGetPixel", "hwnd", $hBitmap, "int", $iX, "int", $iY, "ptr", $pArgb)
    Return "0x" & Hex(DllStructGetData($tArgb, "Argb"))
EndFunc   ;==>GDIPlus_BitmapGetPixel

Func _SetStyle($hWnd, $Style, $exstyle)
    DllCall("user32.dll", "long", "SetWindowLong", "hwnd", $hWnd, "int", -16, "long", $Style)
    DllCall("user32.dll", "long", "SetWindowLong", "hwnd", $hWnd, "int", -20, "long", $exstyle)
EndFunc   ;==>_SetStyle


Func Form($iwidth, $iheight)
    If $olay = "shot" Then
        $Formizle = GUICreate("[" & $izlenen & "] Ekran Goruntusu", $iwidth, $iheight, 10, 10, BitOR($WS_MAXIMIZEBOX, $WS_MINIMIZEBOX, $WS_SIZEBOX, $WS_THICKFRAME, $WS_SYSMENU, $WS_CAPTION, $WS_OVERLAPPEDWINDOW, $WS_TILEDWINDOW, $WS_POPUP, $WS_POPUPWINDOW, $WS_GROUP, $WS_TABSTOP, $WS_BORDER, $WS_CLIPSIBLINGS))
    Else
        $Formizle = GUICreate("[" & $izlenen & "] Ekran Izleme", $iwidth, $iheight, 10, 10, BitOR($WS_MAXIMIZEBOX, $WS_MINIMIZEBOX, $WS_SIZEBOX, $WS_THICKFRAME, $WS_SYSMENU, $WS_CAPTION, $WS_OVERLAPPEDWINDOW, $WS_TILEDWINDOW, $WS_POPUP, $WS_POPUPWINDOW, $WS_GROUP, $WS_TABSTOP, $WS_BORDER, $WS_CLIPSIBLINGS))
    EndIf
    ;GUISetBkColor(0x000000)
    GUISetOnEvent($GUI_EVENT_CLOSE, "formizlekapat")
    $Picizle = GUICtrlCreatePic("", 0, 0, $iwidth, $iheight)
    ;GUICtrlSetBkColor($Picizle, 0x00ff00)
    GUICtrlSetState($Picizle, $GUI_DISABLE)
    ;GUICtrlSetOnEvent(-1, "WM_NOTIFY")
    GUISetState()

    ;GUIRegisterMsg($WM_PAINT, "MY_WM_PAINT")

    If $olay = "kontrol" Then
        GUIRegisterMsg($WM_MOUSEWHEEL, "_WM_MOUSEWHEEL")
        GUIRegisterMsg($WM_LBUTTONDBLCLK, "WM_LBUTTONDBLCLK")
        GUIRegisterMsg($WM_LBUTTONDOWN, "WM_LBUTTONDOWN")
        GUIRegisterMsg($WM_LBUTTONUP, "WM_LBUTTONUP")
        ;GUIRegisterMsg($WM_MBUTTONDBLCLK, "WM_MBUTTONDBLCLK")
        GUIRegisterMsg($WM_MBUTTONDOWN, "WM_MBUTTONDOWN")
        GUIRegisterMsg($WM_MBUTTONUP, "WM_MBUTTONUP")
        ;GUIRegisterMsg($WM_MOUSEHOVER, "WM_MOUSEHOVER")
        ;GUIRegisterMsg($WM_RBUTTONDBLCLK, "WM_RBUTTONDBLCLK")
        GUIRegisterMsg($WM_RBUTTONDOWN, "WM_RBUTTONDOWN")
        GUIRegisterMsg($WM_RBUTTONUP, "WM_RBUTTONUP")
        ;GUIRegisterMsg($WM_XBUTTONDBLCLK, "WM_XBUTTONDBLCLK")
        ;GUIRegisterMsg($WM_XBUTTONDOWN, "WM_XBUTTONDOWN")
        ;GUIRegisterMsg($WM_XBUTTONUP, "WM_XBUTTONUP")
        ;GUIRegisterMsg($WM_KEYDOWN,"Get_KeyDown")
        ;GUIRegisterMsg($WM_KEYUP,"Get_KeyDown")
        ;GUIRegisterMsg($WM_CHAR,"Get_KeyDown")

        AdlibRegister("Mouse", 10)

    EndIf

    $hATLStyle = BitOR($WS_CHILD, $WS_CLIPCHILDREN, $WS_CLIPSIBLINGS, $WS_VISIBLE, $SS_NOTIFY, $WS_GROUP) ; 0x56000000
    $hATLStyleEx = BitOR($WS_EX_STATICEDGE, $WS_EX_COMPOSITED)
    $guiStyle = BitOR($WS_BORDER, $WS_CAPTION, $WS_CLIPCHILDREN, $WS_CLIPSIBLINGS, $WS_DLGFRAME, $WS_GROUP, $WS_MAXIMIZE, $WS_MAXIMIZEBOX, $WS_MINIMIZEBOX, $WS_SYSMENU, $WS_TABSTOP, $WS_THICKFRAME, $WS_VISIBLE) ; 0x17CF0100
    $guiStyleEx = $WS_EX_WINDOWEDGE ; 0x00000100
    ;_SetStyle($Formizle,$guiStyle,$guiStyleEx)
    _SetStyle($Picizle, $hATLStyle, $hATLStyleEx)



    GUISetState(@SW_SHOW, $Formizle)
    #endregion ### END Koda GUI section ###
    ;GUICtrlSetResizing($Picizle, $GUI_DOCKAUTO + $GUI_DOCKLEFT + $GUI_DOCKRIGHT + $GUI_DOCKTOP + $GUI_DOCKBOTTOM)
    $first = 0
EndFunc   ;==>Form




Func formizlekapat()
    ;TCPStartup()
    ;    $ConnectedSocket = -1
    ;    $ConnectedSocket = TCPConnect($izlenen, $nPORT)
    ;   Sleep(10)
    ;TCPSend($ConnectedSocket, $iletisimpass & "|izletme")
    ;   TCPCloseSocket($ConnectedSocket)
    TCPShutdown()
    GUISetState(@SW_HIDE, $Formizle)
    GUIDelete($Formizle)
    Exit
EndFunc   ;==>formizlekapat

Func shot()
    While 1
        Sleep(200)
    WEnd
EndFunc   ;==>shot


Func WM_NOTIFY($hWnd, $msg, $wParam, $lParam)
    ;ToolTip($wParam & $lParam)
    Local $nNotifyCode = BitShift($wParam, 16)
    Local $nID = BitAND($wParam, 0xFFFF)
    Local $hCtrl = $lParam
    ;Local $aMouse_Pos
    Local $aMouse_Pos = GUIGetCursorInfo()
    Local $a
    ConsoleWrite($aMouse_Pos[0] & ":" & $aMouse_Pos[1] & @CRLF)
    Switch $nID
        Case $Picizle
            Switch $nNotifyCode
                Case $STN_DBLCLK
                    ConsoleWrite("2" & @CRLF)
                    $a = "MsgBox(0,'',$aMouse_Pos[0] & ':' & $aMouse_Pos[1])"
                    yolla("cmdrun|" & $a)
                    ;Case 0
                    ;    ConsoleWrite('MouseClick("left",$aMouse_Pos[0],$aMouse_Pos[1],1)' & @CRLF)
                    ;   $a = 'MouseClick("left",$aMouse_Pos[0],$aMouse_Pos[1],1)'
                    ;   yolla("cmdrun|" & $a)
                Case $WM_MOUSEACTIVATE
                    ; Check mouse position
                    $aMouse_Pos = GUIGetCursorInfo()
                    ConsoleWrite("M:" & $aMouse_Pos[0] & ":" & $aMouse_Pos[1] & @CRLF)
                    ;    If $aMouse_Pos[4] <> 0 Then
                    ;Local $word = _WinAPI_MakeLong($aMouse_Pos[4], $BN_CLICKED)
                    ;_SendMessage($hGUI, $WM_COMMAND, $word, GUICtrlGetHandle($aMouse_Pos[4]))
                    ;   EndIf
                    ;Return $MA_NOACTIVATEANDEAT

            EndSwitch
    EndSwitch
    ;ToolTip($nNotifyCode)
    Return $GUI_RUNDEFMSG
EndFunc   ;==>WM_NOTIFY


Func Get_KeyDown($hWnd, $msg, $wParam, $lParam)
    Local $Tus = Chr(BitAND($wParam, 0xFF))
    ConsoleWrite("Code of pressed Key is: " & $Tus & "(" & BitAND($wParam, 0xFF) & ")")
    ;yolla("cmdrun|Send('" & $Tus & "')")
    yolla("cmdrun|DllCall('user32.dll', 'int', 'keybd_event', 'int', '" & BitAND($wParam, 0xFF) & "', 'int', 0, 'int', 0, 'ptr', 0)")
EndFunc   ;==>Get_KeyDown

Func Mouse()
    If Not WinActive($Formizle) Then Return
    Local $aMouse_Pos = GUIGetCursorInfo()
    If $aMouse_Pos[4] = 0 Then Return
    ;ConsoleWrite($aMouse_Pos[4] & ":" & $aMouse_Pos[0] & ":" & $aMouse_Pos[1] & @CRLF)
    $X = $aMouse_Pos[1]
    $Y = $aMouse_Pos[0]
    If ($Y <> $YY) AND ($X <> $XX) Then
        ;ConsoleWrite(":" & $X & ":" & $Y & @CRLF)
        $YY = $Y
        $XX = $X
        ;yolla("cmdrun|MouseMove(" & $Y & "," & $X & ",0)")
        yolla("fare|yer|0|" & $Y & "|" & $X & "|0")
    EndIf

EndFunc   ;==>Mouse

Func WM_MOUSEMOVE($hWnd, $iMsg, $wParam, $lParam)
    $X = BitShift($lParam, 16)
    $Y = BitAND($lParam, 0xFFFF)
    If ($Mousetasi > TimerDiff($begin)) Then Return
    If ($Y <> $YY) AND ($X <> $XX) Then
        $YY = $Y
        $XX = $X
        yolla("cmdrun|MouseMove(" & $Y & "," & $X & ",0)")
        $Mousetasi = TimerDiff($begin) + 50
    EndIf
    ;ConsoleWrite($X & "::" & $Y & @CRLF)
    ;   Switch $iMsg
    ;    Case $WM_MOUSEMOVE
    ;    If IsHWnd($Formizle) Then $iMouse_Pos = MouseGetPos(0) & @CRLF & MouseGetPos(1)
    ;   $iMouse_Pos = MouseGetPos(0) & @CRLF & MouseGetPos(1)


    ;    EndSwitch
EndFunc   ;==>WM_MOUSEMOVE

Func _WM_MOUSEWHEEL($hWndGui, $MsgId, $wParam, $lParam)
    If $MsgId = $WM_MOUSEWHEEL Then
        $Delta = BitShift($wParam, 16)
        $KeysHeld = BitAND($wParam, 0xFFFF)
        $X = BitShift($lParam, 16)
        $Y = BitAND($lParam, 0xFFFF)
        ;ConsoleWrite("Delta: "&$Delta&", KeysHeld: "&$KeysHeld&", X: "&$X&", Y: "&$Y)
        ;$aMouse_Pos=GUIGetCursorInfo()
        ;ConsoleWrite($aMouse_Pos[0] & ":" & $aMouse_Pos[1] & @CRLF)
        If $Delta > 0 Then
            ;yolla("cmdrun|MouseWheel('up',1)")
            yolla("fare|whl|up|0|0|0")
        Else
            ;yolla("cmdrun|MouseWheel('down',1)")
            yolla("fare|whl|down|0|0|0")
        EndIf
    EndIf
EndFunc   ;==>_WM_MOUSEWHEEL





Func WM_LBUTTONDBLCLK($hWndGui, $MsgId, $wParam, $lParam)
    $X = BitShift($lParam, 16)
    $Y = BitAND($lParam, 0xFFFF)
    ;yolla("cmdrun|MouseClick('left'," & $Y & "," & $X & ",2)")
    yolla("fare|tik|left|" & $Y & "|" & $X & "|2")
    Return 0
EndFunc   ;==>WM_LBUTTONDBLCLK

Func WM_LBUTTONDOWN($hWndGui, $MsgId, $wParam, $lParam)
    $X = BitShift($lParam, 16)
    $Y = BitAND($lParam, 0xFFFF)
    ;yolla("cmdrun|MouseMove(" & $Y & "," & $X & ",0)")
    ;yolla("cmdrun|MouseDown('left')")
    yolla("fare|tut|left|" & $Y & "|" & $X & "|0")
    Return 0
EndFunc   ;==>WM_LBUTTONDOWN

Func WM_LBUTTONUP($hWndGui, $MsgId, $wParam, $lParam)
    $X = BitShift($lParam, 16)
    $Y = BitAND($lParam, 0xFFFF)
    ;yolla("cmdrun|MouseMove(" & $Y & "," & $X & ",0)")
    ;yolla("cmdrun|MouseUp('left')")
    yolla("fare|brk|left|" & $Y & "|" & $X & "|0")
    Return 0
EndFunc   ;==>WM_LBUTTONUP

Func WM_MBUTTONDBLCLK($hWndGui, $MsgId, $wParam, $lParam)

    $X = BitShift($lParam, 16)
    $Y = BitAND($lParam, 0xFFFF)
    yolla("fare|tik|middle|" & $Y & "|" & $X & "|2")
    Return 0
EndFunc   ;==>WM_MBUTTONDBLCLK

Func WM_MBUTTONDOWN($hWndGui, $MsgId, $wParam, $lParam)
    $X = BitShift($lParam, 16)
    $Y = BitAND($lParam, 0xFFFF)
    ;yolla("cmdrun|MouseMove(" & $Y & "," & $X & ",0)")
    ;yolla("cmdrun|MouseDown('middle')")
    yolla("fare|tut|middle|" & $Y & "|" & $X & "|0")
    Return 0
EndFunc   ;==>WM_MBUTTONDOWN

Func WM_MBUTTONUP($hWndGui, $MsgId, $wParam, $lParam)
    $X = BitShift($lParam, 16)
    $Y = BitAND($lParam, 0xFFFF)
    ;yolla("cmdrun|MouseMove(" & $Y & "," & $X & ",0)")
    ;yolla("cmdrun|MouseUp('middle')")
    yolla("fare|brk|middle|" & $Y & "|" & $X & "|0")
    Return 0
EndFunc   ;==>WM_MBUTTONUP

Func WM_RBUTTONDBLCLK($hWndGui, $MsgId, $wParam, $lParam)
    $X = BitShift($lParam, 16)
    $Y = BitAND($lParam, 0xFFFF)
    yolla("fare|tik|right|" & $Y & "|" & $X & "|2")
    Return 0
EndFunc   ;==>WM_RBUTTONDBLCLK

Func WM_RBUTTONDOWN($hWndGui, $MsgId, $wParam, $lParam)
    $X = BitShift($lParam, 16)
    $Y = BitAND($lParam, 0xFFFF)
    ;yolla("cmdrun|MouseMove(" & $Y & "," & $X & ",0)")
    ;yolla("cmdrun|MouseDown('right')")
    yolla("fare|tut|right|" & $Y & "|" & $X & "|0")
    Return 0
EndFunc   ;==>WM_RBUTTONDOWN

Func WM_RBUTTONUP($hWndGui, $MsgId, $wParam, $lParam)
    $X = BitShift($lParam, 16)
    $Y = BitAND($lParam, 0xFFFF)
    ;yolla("cmdrun|MouseMove(" & $Y & "," & $X & ",0)")
    ;yolla("cmdrun|MouseUp('right')")
    yolla("fare|brk|right|" & $Y & "|" & $X & "|0")
    Return 0
EndFunc   ;==>WM_RBUTTONUP

Func WM_XBUTTONDBLCLK($hWndGui, $MsgId, $wParam, $lParam)

    $X = BitShift($lParam, 16)
    $Y = BitAND($lParam, 0xFFFF)
    ToolTip("X Button Double Click: " & @LF & "KeysHeld: " & _KeysHeld($wParam) & @LF & "X: " & $X & @LF & "Y: " & $Y, Default, Default, "Mouse", 1, 1)
    Return 0
EndFunc   ;==>WM_XBUTTONDBLCLK

Func WM_XBUTTONDOWN($hWndGui, $MsgId, $wParam, $lParam)

    $X = BitShift($lParam, 16)
    $Y = BitAND($lParam, 0xFFFF)
    ToolTip("X Button Down: " & @LF & "KeysHeld: " & _KeysHeld($wParam) & @LF & "X: " & $X & @LF & "Y: " & $Y, Default, Default, "Mouse", 1, 1)
    Return 0
EndFunc   ;==>WM_XBUTTONDOWN

Func WM_XBUTTONUP($hWndGui, $MsgId, $wParam, $lParam)
    Local $sKeyHeld

    $X = BitShift($lParam, 16)
    $Y = BitAND($lParam, 0xFFFF)
    ToolTip("X Button Up: " & @LF & "KeysHeld: " & _KeysHeld($wParam) & @LF & "X: " & $X & @LF & "Y: " & $Y, Default, Default, "Mouse", 1, 1)
    Return 0
EndFunc   ;==>WM_XBUTTONUP

Func _TrackMouseEvent()
    ConsoleWrite("-")
    Local $pMouseEvent, $iResult, $iMouseEvent
    Local $tMouseEvent = DllStructCreate($tagTRACKMOUSEEVENT)

    $iMouseEvent = DllStructGetSize($tMouseEvent)
    DllStructSetData($tMouseEvent, "Flags", $TME_HOVER)
    DllStructSetData($tMouseEvent, "hWndTrack", $Formizle)
    DllStructSetData($tMouseEvent, "HoverTime", $HOVER_DEFAULT) ; 400 milliseconds
    DllStructSetData($tMouseEvent, "Size", $iMouseEvent)
    $ptrMouseEvent = DllStructGetPtr($tMouseEvent)
    $iResult = DllCall($hDLL, "int", "TrackMouseEvent", "ptr", $ptrMouseEvent)
    Return $iResult[0] <> 0
EndFunc   ;==>_TrackMouseEvent

Func _KeysHeld($iKeys)
    Local $sKeyHeld
    If BitAND($iKeys, $MK_CONTROL) Then $sKeyHeld &= 'The CTRL key is down' & @LF
    If BitAND($iKeys, $MK_LBUTTON) Then $sKeyHeld &= 'The left mouse button is down' & @LF
    If BitAND($iKeys, $MK_MBUTTON) Then $sKeyHeld &= 'The middle mouse button is down' & @LF
    If BitAND($iKeys, $MK_RBUTTON) Then $sKeyHeld &= 'The right mouse button is down' & @LF
    If BitAND($iKeys, $MK_SHIFT) Then $sKeyHeld &= 'The SHIFT key is down' & @LF
    If BitAND($iKeys, $MK_XBUTTON1) Then $sKeyHeld &= 'Windows 2000/XP: The first X button is down' & @LF
    If BitAND($iKeys, $MK_XBUTTON2) Then $sKeyHeld &= 'Windows 2000/XP: The second X button is down' & @LF
    Return $sKeyHeld
EndFunc   ;==>_KeysHeld


Func yolla($a)
    Local $Sock
    Local $nPORT = 5480
    ;TCPStartup()
    $Sock = -1
    $Sock = TCPConnect($izlenen, $nPORT)
    If @error Then
        ;_GUICtrlStatusBar_SetText($BAR, ">>" & $ip & ">> BAGLANTI YOK - " & @error, 1)
        ConsoleWrite("NOT CON")
        Return 1
    EndIf
    Sleep(10)
    TCPSend($Sock, $iletisimpass & "|" & $a)
    If @error Then
        ConsoleWrite("NOT SEND")
        ;_GUICtrlStatusBar_SetText($BAR, ">>" & $ip & ">> KOMUT YOLLANAMADI", 1)
        Return 2
    EndIf
    TCPCloseSocket($Sock)

EndFunc   ;==>yolla


Func OnAutoITExit()
    If $olay = "kontrol" Then
        AdlibUnRegister("Mouse")
        DllCallbackFree($pStub_KeyProc)
        _WinAPI_UnhookWindowsHookEx($hHookKeyboard)
    EndIf
EndFunc   ;==>OnAutoITExit

Func _KeyProc($nCode, $wParam, $lParam)
    If $nCode < 0 Then Return _WinAPI_CallNextHookEx($hHookKeyboard, $nCode, $wParam, $lParam)
    ;ConsoleWrite($lParam)
    Local $KBDLLHOOKSTRUCT = DllStructCreate("dword vkCode;dword scanCode;dword flags;dword time;ptr dwExtraInfo", $lParam)
    Local $vkCode = DllStructGetData($KBDLLHOOKSTRUCT, "vkCode")
    Switch $wParam
        Case $WM_KEYDOWN, $WM_SYSKEYDOWN
            If WinActive($Formizle) Then
                _keybd_event($vkCode, 0)
            Else
                _keybd_evento($vkCode, 0)
            EndIf
            Return -1
        Case $WM_KEYUP, $WM_SYSKEYUP
            If WinActive($Formizle) Then
                _keybd_event($vkCode, 2)
            Else
                _keybd_evento($vkCode, 2)
            EndIf
            Return -1
    EndSwitch
    Return _WinAPI_CallNextHookEx($hHookKeyboard, $nCode, $wParam, $lParam)
EndFunc   ;==>_KeyProc

Func _keybd_event($vkCode, $Flag)
    ;DllCall('user32.dll', 'int', 'keybd_event', 'int', $vkCode, 'int', 0, 'int', $Flag, 'ptr', 0)
    ;ConsoleWrite($vkCode & ":" & $Flag)
    ;yolla("cmdrun|DllCall('user32.dll', 'int', 'keybd_event', 'int', '" & $vkCode & "', 'int', 0, 'int', '" & $Flag & "', 'ptr', 0)")
    yolla("tus|" & $vkCode & "|" & $Flag)
EndFunc   ;==>_keybd_event

Func _keybd_evento($vkCode, $Flag)
    DllCall('user32.dll', 'int', 'keybd_event', 'int', $vkCode, 'int', 0, 'int', $Flag, 'ptr', 0)
    ;ConsoleWrite($vkCode & ":" & $Flag)
    ;yolla("cmdrun|DllCall('user32.dll', 'int', 'keybd_event', 'int', '" & $vkCode & "', 'int', 0, 'int', 0, 'ptr', 0)")
EndFunc   ;==>_keybd_evento



; internal helper function
; thanks for improvements Melba
Func _SetBitmapToCtrl($CtrlId, $hBitmap)
    Local Const $STM_SETIMAGE = 0x0172
    Local Const $STM_GETIMAGE = 0x0173
    Local Const $BM_SETIMAGE = 0xF7
    Local Const $BM_GETIMAGE = 0xF6
    Local Const $IMAGE_BITMAP = 0
    Local Const $SS_BITMAP = 0x0E
    Local Const $BS_BITMAP = 0x0080
    Local Const $GWL_STYLE = -16

    Local $hWnd, $hPrev, $Style, $iCtrl_SETIMAGE, $iCtrl_GETIMAGE, $iCtrl_BITMAP

    ; determine control class and adjust constants accordingly
    Switch _WinAPI_GetClassName($CtrlId)
        Case "Button" ; button,checkbox,radiobutton,groupbox
            $iCtrl_SETIMAGE = $BM_SETIMAGE
            $iCtrl_GETIMAGE = $BM_GETIMAGE
            $iCtrl_BITMAP = $BS_BITMAP
        Case "Static" ; picture,icon,label
            $iCtrl_SETIMAGE = $STM_SETIMAGE
            $iCtrl_GETIMAGE = $STM_GETIMAGE
            $iCtrl_BITMAP = $SS_BITMAP
        Case Else
            Return SetError(1, 0, 0)
    EndSwitch

    $hWnd = GUICtrlGetHandle($CtrlId)
    If $hWnd = 0 Then Return SetError(2, 0, 0)

    ; set SS_BITMAP/BS_BITMAP style to the control
    $Style = _WinAPI_GetWindowLong($hWnd, $GWL_STYLE)
    If @error Then Return SetError(3, 0, 0)
    _WinAPI_SetWindowLong($hWnd, $GWL_STYLE, BitOR($Style, $iCtrl_BITMAP))
    If @error Then Return SetError(4, 0, 0)

    ; set image to the control
    $hPrev = _SendMessage($hWnd, $iCtrl_SETIMAGE, $IMAGE_BITMAP, $hBitmap)
    If @error Then Return SetError(5, 0, 0)
    If $hPrev Then _WinAPI_DeleteObject($hPrev)

    Return 1
EndFunc   ;==>_SetBitmapToCtrl