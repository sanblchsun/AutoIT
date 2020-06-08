; Andreik
; http://www.autoitscript.com/forum/topic/136028-analog-clock
#include <GDIPlus.au3>

Global Const $PI = 3.1415926535897932384626433832795
Global Const $Width = 10
Global $HourPoly[4][2], $MinPoly[4][2], $SecPoly[4][2]

$HourPoly[0][0] = 3
$HourPoly[1][0] = 512 - $Width
$HourPoly[1][1] = 384
$HourPoly[2][0] = 512 + $Width
$HourPoly[2][1] = 384

$MinPoly[0][0] = 3
$MinPoly[1][0] = 512 - $Width
$MinPoly[1][1] = 384
$MinPoly[2][0] = 512 + $Width
$MinPoly[2][1] = 384

$SecPoly[0][0] = 3
$SecPoly[1][0] = 512 - $Width
$SecPoly[1][1] = 384
$SecPoly[2][0] = 512 + $Width
$SecPoly[2][1] = 384

$hMain = GUICreate("Analog clock",1024,768,0,0,0x80000000,0x00000008)
GUISetState(@SW_SHOW,$hMain)

_GDIPlus_Startup()
$hGraphics = _GDIPlus_GraphicsCreateFromHWND($hMain)
$hBitmap = _GDIPlus_BitmapCreateFromGraphics(1024,768,$hGraphics)
$hBackBuffer = _GDIPlus_ImageGetGraphicsContext($hBitmap)
$hImage = _GDIPlus_ImageLoadFromFile(@ScriptDir & "clock.bmp")
$hHourBrush = _GDIPlus_BrushCreateSolid(0xFF004080)
$hMinBrush = _GDIPlus_BrushCreateSolid(0xFF0080FF)
$hSecBrush = _GDIPlus_BrushCreateSolid(0xFFFFFFFF)

While True
    If GUIGetMsg() = -3 Then ExitLoop
    _GDIPlus_GraphicsClear($hBackBuffer)
    _GDIPlus_GraphicsDrawImage($hBackBuffer,$hImage,0,0)
    $HourPoly[3][0] = 512 + Cos(TimeToRadians("hour")) * 165
    $HourPoly[3][1] = 384 - Sin(TimeToRadians("hour")) * 165
    $MinPoly[3][0] = 512 + Cos(TimeToRadians("min")) * 220
    $MinPoly[3][1] = 384 - Sin(TimeToRadians("min")) * 220
    $SecPoly[3][0] = 512 + Cos(TimeToRadians("sec")) * 300
    $SecPoly[3][1] = 384 - Sin(TimeToRadians("sec")) * 300
    _GDIPlus_GraphicsFillPolygon($hBackBuffer,$HourPoly,$hHourBrush)
    _GDIPlus_GraphicsFillPolygon($hBackBuffer,$MinPoly,$hMinBrush)
    _GDIPlus_GraphicsFillPolygon($hBackBuffer,$SecPoly,$hSecBrush)
    _GDIPlus_GraphicsDrawImage($hGraphics,$hBitmap,0,0)
    Sleep(10)
WEnd

_GDIPlus_BrushDispose($hSecBrush)
_GDIPlus_BrushDispose($hMinBrush)
_GDIPlus_BrushDispose($hHourBrush)
_GDIPlus_ImageDispose($hImage)
_GDIPlus_GraphicsDispose($hBackBuffer)
_GDIPlus_BitmapDispose($hBitmap)
_GDIPlus_GraphicsDispose($hGraphics)
_GDIPlus_Shutdown()

Func TimeToRadians($sTimeType)
    Local $Sec = @SEC, $Min = @MIN, $Hour = @HOUR
    Switch $sTimeType
        Case "sec"
            Return ($PI / 2) - ($Sec  * ($PI / 30))
        Case "min"
            Return ($PI / 2) - ($Min  * ($PI / 30)) - (Int($Sec / 10) * ($PI / 180))
        Case "hour"
            Return ($PI / 2) - ($Hour * ($PI / 6 )) - ($Min / 12) * ($PI / 30)
    EndSwitch
EndFunc