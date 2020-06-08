#include <GDIplus.au3>


#Region Settings for the animation
Global $ColorSpeed=0.004
Global $Iterations=100
Global $Speed=0.02
Global $Step=2
Global $ButterFlyW=100
Global $ButterFlyH=100
#EndRegion


Global Const $width = 650
Global Const $height = 600
Global Const $PI = 3.14159
Global Const $E = 2.71828183
Global $title = "Butterfly"


; Build your GUI here
Opt("GUIOnEventMode", 1)
$hwnd = GUICreate($title, $width, $height)
GUISetOnEvent(-3, "close")

_GDIPlus_Startup()
$graphics = _GDIPlus_GraphicsCreateFromHWND($hwnd)
$bitmap = _GDIPlus_BitmapCreateFromGraphics($width, $height, $graphics)
$backbuffer = _GDIPlus_ImageGetGraphicsContext($bitmap)
_GDIPlus_GraphicsSetSmoothingMode($backbuffer, 4)
$matrix = _GDIPlus_MatrixCreate()
_GDIPlus_MatrixTranslate($matrix, $width / 2, $height / 2)
_GDIPlus_GraphicsSetTransform($backbuffer, $matrix)

$brush = _GDIPlus_BrushCreateSolid(0x2F0000FF)

GUISetState()
$inc = 0
$inc2=Random(0,2^32-1)
_GDIPlus_GraphicsClear($backbuffer, 0xFF000000)
_GDIPlus_GraphicsDrawImageRect($graphics, $bitmap, 0, 0, $width, $height)



Do
    _GDIPlus_GraphicsClear($backbuffer, 0x0F000000)
    
    $inc2+=$ColorSpeed
    $red=Hex(((Sin($inc2)+1)/2)*255,2)
    $green=Hex(((Sin($inc2*2)+1)/2)*255,2)
    $blue=Hex(((Sin($inc2*3)+1)/2)*255,2)
    _GDIPlus_BrushSetSolidColor($brush,"0x0F"&$red&$green&$blue)

    $inc += $Speed
    For $i = 0 To $Iterations-1 Step $Step
        $pos = butterfly($inc + 2 * $PI / $Iterations * ($i + 1), $ButterFlyW, $ButterFlyH)
        $pos[1]-=50
        _GDIPlus_GraphicsFillEllipse($backbuffer, $pos[0], $pos[1], 10, 10, $brush)
    Next





    _GDIPlus_GraphicsDrawImageRect($graphics, $bitmap, 0, 0, $width, $height)
    Sleep(10)
Until False

Func butterfly($t, $sizex, $sizey)
    Local $aRet[2]

    $aRet[0] = $sizex * Sin($t) * ($E ^ Cos($t) - 2 * Cos($t * 4) - Sin($t / 12) ^ 5)
    $aRet[1] = $sizey * Cos($t) * ($E ^ Cos($t) - 2 * Cos($t * 4) - Sin($t / 12) ^ 5)

    Return $aRet

EndFunc  ;==>butterfly


Func _GDIPlus_BrushSetSolidColor($hBrush, $iARGB = 0xFF000000)
    Local $aResult
    $aResult = DllCall($ghGDIPDll, "int", "GdipSetSolidFillColor", "hwnd", $hBrush, "int", $iARGB)
EndFunc  ;==>_GDIPlus_BrushSetSolidColor


Func close()
    _GDIPlus_GraphicsDispose($backbuffer)
    _GDIPlus_BitmapDispose($bitmap)
    _GDIPlus_GraphicsDispose($graphics)
    _GDIPlus_Shutdown()
    Exit
EndFunc  ;==>close