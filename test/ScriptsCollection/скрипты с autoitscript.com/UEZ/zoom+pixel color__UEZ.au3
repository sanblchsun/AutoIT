;coded by UEZ
#include <GDIPlus.au3>
#include <WindowsConstants.au3>

Opt("MustDeclareVars", 1)
Opt("GUICloseOnESC", 0)
TraySetState (2)

Global $zx = 0, $zy = 0, $up = 1
Global $zoom_level = 6, $zoom_min = 2, $zoom_max = 25
Global $esc

$zoom_level = 6
$esc = False
Zoom()
Exit

Func Zoom()
    Local $w, $h, $mpos = MouseGetPos(), $pixel_color
    Local $hGUI_Dot = GUICreate("", 1, 1, 18, 18, BitOR($WS_POPUP, $WS_CLIPSIBLINGS), $WS_EX_TOPMOST, WinGetHandle(AutoItWinGetTitle()))
    GUISetBkColor(0, $hGUI_Dot)
    GUISetState(@SW_SHOW, $hGUI_Dot)
    HotKeySet("{ESC}", "_Exit_CSR")

    Local Const $zw = 256
    Local Const $zh = 256
    Local Const $lW = 40
    Local Const $lH = 40
    Local Const $dist_x = 24, $dist_y = 24, $radius = 160
    Local $dirx = 1, $drx = 0, $diry = 1, $dry = 0, $lower_border, $right_border
    Local $zoomW = Int($zw / $zoom_level)
    Local $zoomH = Int($zh / $zoom_level)
    Local $hGUI_Zoom = GUICreate("Zoom", $zw, $zh, $zx, $zx, BitOR($WS_POPUP,$DS_MODALFRAME), BitOR($WS_EX_OVERLAPPEDWINDOW,$WS_EX_TOPMOST,$WS_EX_WINDOWEDGE), WinGetHandle(AutoItWinGetTitle()))
    GUISetState(@SW_SHOW, $hGUI_Zoom)
    Local $hDC_Zoom = _WinAPI_GetDC(0)
    Local $hGUI_ZoomDC = _WinAPI_GetDC($hGUI_Zoom)
    _WinAPI_SetBkMode($hGUI_ZoomDC, $TRANSPARENT)

    GUIRegisterMsg(0x020A, "WM_MOUSEWHEEL")
    Local $aLastPos[2]

    Do
        If $esc Then ExitLoop
        $mpos = MouseGetPos()
        GUISetState(@SW_SHOW, $hGUI_Zoom)
        If $mpos[0] <> $aLastPos[0] Or $mpos[1] <> $aLastPos[1] Then
            $pixel_color = Hex(PixelGetColor($mpos[0], $mpos[1]), 6)
            WinMove($hGUI_Dot, "", $mpos[0], $mpos[1])
            ToolTip("ESC to abort"& @CRLF & @CRLF & _
                          "Position: " & $mpos[0] & "," & $mpos[1] & @CRLF & _
                          "Pixel Color: 0x" & $pixel_color, $drx + $mpos[0] + $dirx * ($dist_x + $zoomW / 3) , $dry + $mpos[1] + $diry * ($dist_y + $zoomH / 3))
            $aLastPos = $mpos

            $right_border = Pixel_Distance($mpos[0], $mpos[1], @DesktopWidth, $mpos[1])
            If $right_border < $radius Then
                $dirx = -1
                $drx = -$radius
            Else
                $dirx = 1
                $drx = 0
            EndIf
            $lower_border = Pixel_Distance($mpos[0], $mpos[1], $mpos[0], @DesktopHeight)
            If $lower_border < $radius Then
                $diry = -1
                $dry = -$radius
            Else
                $diry = 1
                $dry = 0
            EndIf
        EndIf

        If CheckRectCollision($zx - $lW, $zy - $lH , $zx + $zw + $lW, $zy + $zh + $lH, $mpos[0], $mpos[1]) Then
            $up *= -1
            If $up = -1 Then
                $zx = @DesktopWidth - $zw - 4
                WinMove($hGUI_Zoom, "", $zx, $zy)
            Else
                $zx = 0
                WinMove($hGUI_Zoom, "", $zx, $zy)
            EndIf
        EndIf
        _WinAPI_StretchBlt($hGUI_ZoomDC, 0, 0, $zw, $zh, $hDC_Zoom, $mpos[0] - $zoomW / 2, $mpos[1] - $zoomH / 2, $zoomW, $zoomH, $SRCCOPY)
        $zoomW = Int($zw / $zoom_level)
        $zoomH = Int($zh / $zoom_level)

        Sleep(30)
    Until 0
    ToolTip("")
    _WinAPI_ReleaseDC($hGUI_Zoom, $hGUI_ZoomDC)
    _WinAPI_ReleaseDC(0, $hDC_Zoom)
    _WinAPI_DeleteDC($hGUI_ZoomDC)
    _WinAPI_DeleteDC($hDC_Zoom)
    GUIDelete($hGUI_Dot)
    GUIDelete($hGUI_Zoom)
EndFunc

Func _Exit_CSR()
    $esc = True
    Return
EndFunc

Func WM_MOUSEWHEEL($hWnd, $iMsg, $wParam, $lParam)
    Local $wheel_Dir = _WinAPI_HiWord($wParam)
    If $wheel_Dir > 0 Then
        If $zoom_level < $zoom_max Then
            $zoom_level += 1
        EndIf
    Else
        If $zoom_level  > $zoom_min Then
            $zoom_level  -= 1
        EndIf
    EndIf
    Return "GUI_RUNDEFMSG"
EndFunc   ;==>WM_MOUSEWHEEL

Func _WinAPI_StretchBlt($hDestDC, $iXDest, $iYDest, $iWidthDest, $iHeightDest, $hSrcDC, $iXSrc, $iYSrc, $iWidthSrc, $iHeightSrc, $iRop)
    Local $Ret  = DllCall('gdi32.dll', 'int', 'StretchBlt', 'hwnd', $hDestDC, 'int', $iXDest, 'int', $iYDest, 'int', $iWidthDest, 'int', $iHeightDest, 'hwnd', $hSrcDC, 'int', $iXSrc, 'int', $iYSrc, 'int', $iWidthSrc, 'int', $iHeightSrc, 'dword', $iRop)
    If (@error) Or (Not $Ret[0]) Then Return SetError(1, 0, 0)
    Return 1
EndFunc   ;==>_WinAPI_StretchBlt

Func CheckRectCollision($iLeft, $iTop, $iRight, $iBottom, $iX, $iY )
    Local $tagRECT = "int Left;int Top;int Right;int Bottom"
    Local $tRECT = DllStructCreate($tagRECT)
    DllStructSetData($tRECT, 1, $iLeft)
    DllStructSetData($tRECT, 2, $iTop)
    DllStructSetData($tRECT, 3, $iRight)
    DllStructSetData($tRECT, 4, $iBottom)
    Local $aResult = DllCall("User32.dll", "int", "PtInRect", "ptr", DllStructGetPtr($tRECT), "int", $iX, "int", $iY)
    Return $aResult[0] <> 0
EndFunc

Func Pixel_Distance($x1, $y1, $x2, $y2) ;Pythagoras theorem
    Local $a, $b
    If $x2 = $x1 And $y2 = $y1 Then Return 0
    $a = $y2 - $y1
    $b = $x2 - $x1
    Return Sqrt($a * $a + $b * $b)
EndFunc   ;==>Pixel_Distance