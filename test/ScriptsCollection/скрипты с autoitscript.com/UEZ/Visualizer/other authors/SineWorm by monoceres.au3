#include <GUIConstantsEx.au3>
#include <GDIPlus.au3>
Opt("GUIOnEventMode", 1)
Global Const $width = 800
Global Const $height = 500
$hWnd = GUICreate("SineWorm", $width, $height)
GUISetOnEvent($GUI_EVENT_CLOSE, "close")
GUISetState()

_GDIPlus_Startup()
$graphics = _GDIPlus_GraphicsCreateFromHWND($hWnd)
$bitmap = _GDIPlus_BitmapCreateFromGraphics($width, $height, $graphics)
$backbuffer = _GDIPlus_ImageGetGraphicsContext($bitmap)
_GDIPlus_GraphicsSetSmoothingMode($backbuffer,4)


$inc = 0

Local $aFact[4] = [0.0, 0.25, 0.5, 1]
$lgbrush = _GDIPlus_CreateLineBrushFromRect(0, 00, $width, $height, $aFact, -1, 0xFF00FF00, 0xFF0000FF,0)


Do
_GDIPlus_GraphicsClear($backbuffer, 0xFF000000)

$inc += 0.15
For $i = 125 To $width - 125 Step 6
$xmod = Cos($inc / 2+$i/25) * 100
$ymod = Sin($inc / 2+$i/25) * 100
_GDIPlus_GraphicsFillEllipse($backbuffer, $xmod + $i + 10, $ymod + $height / 2 - 25 + Sin($inc + $i / 100) * 0, 8, 8, $lgbrush)
Next


_GDIPlus_GraphicsDrawImageRect($graphics, $bitmap, 0, 0, $width, $height)
Until Not Sleep(20)


Func close()
_GDIPlus_BrushDispose($lgbrush)
_GDIPlus_GraphicsDispose($backbuffer)
_GDIPlus_BitmapDispose($bitmap)
_GDIPlus_GraphicsDispose($graphics)
_GDIPlus_Shutdown()
Exit
EndFunc ;==>close












;==== GDIPlus_CreateLineBrushFromRect ===
;Description - Creates a LinearGradientBrush object from a set of boundary points and boundary colors.
; $aFactors - If non-array, default array will be used.
; Pointer to an array of real numbers that specify blend factors. Each number in the array
; specifies a percentage of the ending color and should be in the range from 0.0 through 1.0.
;$aPositions - If non-array, default array will be used.
; Pointer to an array of real numbers that specify blend factors' positions. Each number in the array
; indicates a percentage of the distance between the starting boundary and the ending boundary
; and is in the range from 0.0 through 1.0, where 0.0 indicates the starting boundary of the
; gradient and 1.0 indicates the ending boundary. There must be at least two positions
; specified: the first position, which is always 0.0, and the last position, which is always
; 1.0. Otherwise, the behavior is undefined. A blend position between 0.0 and 1.0 indicates a
; line, parallel to the boundary lines, that is a certain fraction of the distance from the
; starting boundary to the ending boundary. For example, a blend position of 0.7 indicates
; the line that is 70 percent of the distance from the starting boundary to the ending boundary.
; The color is constant on lines that are parallel to the boundary lines.
; $iArgb1 - First Top color in 0xAARRGGBB format
; $iArgb2 - Second color in 0xAARRGGBB format
; $LinearGradientMode - LinearGradientModeHorizontal = 0x00000000,
; LinearGradientModeVertical = 0x00000001,
; LinearGradientModeForwardDiagonal = 0x00000002,
; LinearGradientModeBackwardDiagonal = 0x00000003
; $WrapMode - WrapModeTile = 0,
; WrapModeTileFlipX = 1,
; WrapModeTileFlipY = 2,
; WrapModeTileFlipXY = 3,
; WrapModeClamp = 4
; GdipCreateLineBrushFromRect(GDIPCONST GpRectF* rect, ARGB color1, ARGB color2,
; LinearGradientMode mode, GpWrapMode wrapMode, GpLineGradient **lineGradient)
; Reference: http://msdn.microsoft.com/en-us/library/ms534043(VS.85).aspx
;
Func _GDIPlus_CreateLineBrushFromRect($iX, $iY, $iWidth, $iHeight, $aFactors, $aPositions, _
$iArgb1 = 0xFF0000FF, $iArgb2 = 0xFFFF0000, $LinearGradientMode = 0x00000001, $WrapMode = 0)

Local $tRect, $pRect, $aRet, $tFactors, $pFactors, $tPositions, $pPositions, $iCount

If $iArgb1 = -1 Then $iArgb1 = 0xFF0000FF
If $iArgb2 = -1 Then $iArgb2 = 0xFFFF0000
If $LinearGradientMode = -1 Then $LinearGradientMode = 0x00000001
If $WrapMode = -1 Then $WrapMode = 1

$tRect = DllStructCreate("float X;float Y;float Width;float Height")
$pRect = DllStructGetPtr($tRect)
DllStructSetData($tRect, "X", $iX)
DllStructSetData($tRect, "Y", $iY)
DllStructSetData($tRect, "Width", $iWidth)
DllStructSetData($tRect, "Height", $iHeight)

;Note: Withn _GDIPlus_Startup(), $ghGDIPDll is defined
$aRet = DllCall($ghGDIPDll, "int", "GdipCreateLineBrushFromRect", "ptr", $pRect, "int", $iArgb1, _
"int", $iArgb2, "int", $LinearGradientMode, "int", $WrapMode, "int*", 0)

If IsArray($aFactors) = 0 Then Dim $aFactors[4] = [0.0, 0.4, 0.6, 1.0]
If IsArray($aPositions) = 0 Then Dim $aPositions[4] = [0.0, 0.3, 0.7, 1.0]

$iCount = UBound($aPositions)
$tFactors = DllStructCreate("float[" & $iCount & "]")
$pFactors = DllStructGetPtr($tFactors)
For $iI = 0 To $iCount - 1
DllStructSetData($tFactors, 1, $aFactors[$iI], $iI + 1)
Next
$tPositions = DllStructCreate("float[" & $iCount & "]")
$pPositions = DllStructGetPtr($tPositions)
For $iI = 0 To $iCount - 1
DllStructSetData($tPositions, 1, $aPositions[$iI], $iI + 1)
Next

$hStatus = DllCall($ghGDIPDll, "int", "GdipSetLineBlend", "hwnd", $aRet[6], _
"ptr", $pFactors, "ptr", $pPositions, "int", $iCount)
Return $aRet[6]; Handle of Line Brush
EndFunc ;==>_GDIPlus_CreateLineBrushFromRect