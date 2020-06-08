;coded by UEZ Build 2011-06-01
#AutoIt3Wrapper_Run_Obfuscator=y
#Obfuscator_Parameters=/sf /sv /om /cs=0 /cn=0
#AutoIt3Wrapper_Compile_both=y
;~ #AutoIt3Wrapper_UseX64=n
#AutoIt3Wrapper_UseUpx=n
#AutoIt3Wrapper_UPX_Parameters=--ultra-brute --crp-ms=999999 --all-methods --all-filters
#AutoIt3Wrapper_Run_After=del /f /q "%scriptdir%\%scriptfile%_Obfuscated.au3"
;~ #AutoIt3Wrapper_Run_After=upx.exe --ultra-brute --crp-ms=999999 --all-methods --all-filters "%out%"

#include <GDIPlus.au3>
#include <GUIConstantsEx.au3>
#include <Timers.au3>
#include <WindowsConstants.au3>

Opt("GUIOnEventMode", 1)

_GDIPlus_Startup()

Global Const $iW = @DesktopWidth
Global Const $iW2 = $iW / 2
Global Const $iH = @DesktopHeight
Global Const $iH2 = $iH / 2

Global Const $hFullScreen = WinGetHandle("Program Manager")
Global Const $aFullScreen = WinGetPos($hFullScreen)
Global Const $main_screen_x = Abs($aFullScreen[0])

Global Const $hGUI = GUICreate("GDI+ Simple 3D Star Scrolling by UEZ", $aFullScreen[2], $aFullScreen[3], $aFullScreen[0], $aFullScreen[1], $WS_POPUP, $WS_EX_TOPMOST)
GUISetBkColor(0x000000, $hGUI)
GUISetState()

Global Const $hBitmap = _WinAPI_CreateDIB($iW, $iH)
Global Const $hDC = _WinAPI_GetWindowDC($hGUI)
Global Const $hDC_backbuffer = _WinAPI_CreateCompatibleDC($hDC)
Global Const $DC_obj = _WinAPI_SelectObject($hDC_backbuffer, $hBitmap)
Global Const $hGraphic = _GDIPlus_GraphicsCreateFromHDC($hDC_backbuffer)

Global Const $hPen = _GDIPlus_PenCreate(0, 1)
Global Const $hBrush = _GDIPlus_BrushCreateSolid(0xE0000000)
Global Const $hBrush_Text = _GDIPlus_BrushCreateSolid(0xFFF0F0F0)
Global Const $hFormat = _GDIPlus_StringFormatCreate ()
Global Const $hFamily = _GDIPlus_FontFamilyCreate ("Arial")
Global Const $hFont = _GDIPlus_FontCreate ($hFamily, 12)
Global Const $tLayout = _GDIPlus_RectFCreate ($iW - 32, 0, 0, 0)

Global Const $maxStars = 300
Global Const $speed = 50
Global Const $r = (($iW + $iH) / 2) / 0x300

Global $aStars[$maxStars][3], $j
For $j = 0 To $maxStars - 1
     NewStars($j)
Next

Global Const $om = MouseGetCursor()
Global $idle_o, $idle_n, $fps = 0, $fps_diff, $fps_maintimer, $fps_timer

GUISetOnEvent($GUI_EVENT_CLOSE , "_Exit")

$fps_maintimer = TimerInit()
AdlibRegister("Draw_Stars", 30)
OnAutoItExitRegister("_Exit")

While Sleep(2^15)
WEnd

Func Draw_Stars()
    $fps_timer = TimerInit()

    $idle_n = _Timer_GetIdleTime()
    If $idle_n < $idle_o Then _Exit()
    $idle_o = $idle_n

    Local $newx, $newy, $i, $c
    GUISetCursor(16, 1, $hGUI)
    _GDIPlus_GraphicsFillRect($hGraphic, 0, 0, $iW, $iH, $hBrush)
    While $i < $maxStars
        $aStars[$i][0] += $aStars[$i][0]  / $speed
        $aStars[$i][1] += $aStars[$i][1]  / $speed
        $aStars[$i][2] += $r
        $newx = $aStars[$i][0] + $iW2
        $newy = $aStars[$i][1] + $iH2
        $c = Hex(Min($aStars[$i][2], 0xFF), 2)
        _GDIPlus_PenSetColor($hPen, "0xFF" & $c & $c & $c)
        _GDIPlus_GraphicsDrawEllipse($hGraphic, $newx, $newy, 1, 1, $hPen)
;~      If $newx < 0 Or $newx > $iW Or $newy < 0 Or $newy > $iH Then NewStars($i, $iW2 * Random(0.75, 1.25), $iH2 * Random(0.75, 1.25), $iW2 * Random(0.75, 1.25), $iH2 * Random(0.75, 1.25))
        If $newx < 0 Or $newx > $iW Or $newy < 0 Or $newy > $iH Then NewStars($i, $iW2 * _Random(0.75, 1.25, 0.95, 1.05), $iH2 * _Random(0.75, 1.25, 0.95, 1.05), $iW2 * _Random(0.75, 1.25, 0.95, 1.05), $iH2 * _Random(0.75, 1.25, 0.95, 1.05))
        $i += 1
    WEnd

    $fps_diff = TimerDiff($fps_timer)
    If TimerDiff($fps_maintimer) > 499 Then ;calculate FPS
        $fps = Int(1000 / $fps_diff)
        $fps_maintimer = TimerInit()
    EndIf
    _GDIPlus_GraphicsDrawStringEx($hGraphic, $fps, $hFont, $tLayout, $hFormat, $hBrush_Text)

    _WinAPI_BitBlt($hDC, $main_screen_x , 0, $iW, $iH, $hDC_backbuffer, 0, 0, $SRCCOPY)
EndFunc

Func NewStars($i, $sx = 0, $sy = 0, $ex = $iW, $ey = $iH)
    $aStars[$i][0] = Random($sx, $ex, 1) - $iW2
    $aStars[$i][1] = Random($sy, $ey, 1) - $iH2
    $aStars[$i][2] = 0x00
    Return
EndFunc

Func Min($a, $b)
    If $a < $b Then Return $a
    Return $b
EndFunc

Func _Random($min, $max, $emin, $emax, $int = 0) ;exludes from emin to emax
    Local $r1 = Random($min, $emin, $int)
    Local $r2 = Random($emax, $max, $int)
    If Random(0, 1, 1) Then Return $r1
    Return $r2
EndFunc

Func _WinAPI_CreateDIB($iWidth, $iHeight, $iBitsPerPel = 32) ;taken from WinAPIEx.au3 by Yashied
    Local $tBIHDR, $hBitmap, $pBits
    Local Const $BI_RGB = 0, $DIB_RGB_COLORS = 0
    Local Const $tagBITMAPINFOHEADER = 'dword biSize;long biWidth;long biHeight;ushort biPlanes;ushort biBitCount;dword biCompression;dword biSizeImage;long biXPelsPerMeter;long biYPelsPerMeter;dword biClrUsed;dword biClrImportant'
    $tBIHDR = DllStructCreate($tagBITMAPINFOHEADER)
    DllStructSetData($tBIHDR, 'biSize', DllStructGetSize($tBIHDR))
    DllStructSetData($tBIHDR, 'biWidth', $iWidth)
    DllStructSetData($tBIHDR, 'biHeight', $iHeight)
    DllStructSetData($tBIHDR, 'biPlanes', 1)
    DllStructSetData($tBIHDR, 'biBitCount', $iBitsPerPel)
    DllStructSetData($tBIHDR, 'biCompression', $BI_RGB)
    $hBitmap = _WinAPI_CreateDIBSection(0, $tBIHDR, $DIB_RGB_COLORS, $pBits)
    If @error Then Return SetError(1, 0, 0)
    Return $hBitmap
EndFunc   ;==>_WinAPI_CreateDIB

Func _WinAPI_CreateDIBSection($hDC, ByRef $tBITMAPINFO, $iUsage, ByRef $pBits, $hSection = 0, $iOffset = 0) ;taken from WinAPIEx.au3 by Yashied
    $pBits = 0
    Local $Ret = DllCall('gdi32.dll', 'ptr', 'CreateDIBSection', 'hwnd', $hDC, 'ptr', DllStructGetPtr($tBITMAPINFO), 'uint', $iUsage, 'ptr*', 0, 'ptr', $hSection, 'dword', $iOffset)
    If @error Or (Not $Ret[0]) Then Return SetError(1, 0, 0)
    $pBits = $Ret[4]
    Return $Ret[0]
EndFunc   ;==>_WinAPI_CreateDIBSection

Func _Exit()
    GUISetCursor($om, 1, $hGUI)
    AdlibUnRegister("Draw_Stars")
    _GDIPlus_FontDispose ($hFont)
    _GDIPlus_FontFamilyDispose ($hFamily)
    _GDIPlus_StringFormatDispose ($hFormat)
    _GDIPlus_PenDispose($hPen)
    _GDIPlus_BrushDispose($hBrush)
    _GDIPlus_BrushDispose($hBrush_Text)

    _GDIPlus_GraphicsDispose($hGraphic)
    _WinAPI_SelectObject($hDC, $DC_obj)
    _WinAPI_DeleteObject($hBitmap)
    _WinAPI_ReleaseDC($hGUI, $hDC)

    _GDIPlus_Shutdown()
    GUIDelete($hGUI)
    Exit
EndFunc
