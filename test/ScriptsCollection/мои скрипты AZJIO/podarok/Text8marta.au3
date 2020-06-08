
#include-Once
#include <GUIConstantsEx.au3>
#include <WindowsConstants.au3>
#include <GDIPlus.au3>

Global Const $width1 = 680
Global Const $height1 = 300
Global $graphics, $backbuffer, $bitmap, $Pen, $arrTxt2, $fontsize_txt2
Global $brush_color, $hFamily2, $hFont2, $hFormat, $tLayout
Global $ScreenDc, $dc, $tSize, $pSize, $tSource, $pSource, $tBlend, $pBlend, $tPoint, $pPoint, $gdibitmap

Func _8m()
$hwnd = GUICreate('', $width1, $height1, -1, -1, 0, $WS_EX_LAYERED + $WS_EX_TOPMOST)

_GDIPlus_Startup()
$graphics = _GDIPlus_GraphicsCreateFromHWND($hwnd)
$bitmap = _GDIPlus_BitmapCreateFromGraphics($width1, $height1, $graphics)
$backbuffer = _GDIPlus_ImageGetGraphicsContext($bitmap)
_GDIPlus_GraphicsSetSmoothingMode($backbuffer, 2)

$ScreenDc = _WinAPI_GetDC($hWnd)
$gdibitmap = _GDIPlus_BitmapCreateHBITMAPFromBitmap($bitmap)
$dc = _WinAPI_CreateCompatibleDC($ScreenDc)
_WinAPI_SelectObject($dc, $gdibitmap)
; _WinAPI_UpdateLayeredWindow parameters
$tSize = DllStructCreate($tagSIZE)
$pSize = DllStructGetPtr($tSize)
DllStructSetData($tSize, "X", $width1)
DllStructSetData($tSize, "Y", $height1)
$tSource = DllStructCreate($tagPOINT)
$pSource = DllStructGetPtr($tSource)
$tBlend = DllStructCreate($tagBLENDFUNCTION)
$pBlend = DllStructGetPtr($tBlend)
DllStructSetData($tBlend, "Alpha", 200)
DllStructSetData($tBlend, "Format", 1)
$tPoint = DllStructCreate($tagPOINT)
$pPoint = DllStructGetPtr($tPoint)
DllStructSetData($tPoint, "X", 0)
DllStructSetData($tPoint, "Y", 0)

GUISetState()
$fontsize_txt2 = 100

$arrTxt2 = StringSplit("8 Марта", "")
$z = UBound($arrTxt2)
Dim $arrX2[$z], $arrY2[$z], $brush2[$z]


For $k = 0 To $z - 1
	$brush_color = 0xFFFFB200
	$brush2[$k] = _GDIPlus_BrushCreateSolid($brush_color)
Next
_GDIPlus_BrushSetSolidColor($brush2[0], 0xFFFF7700)
_GDIPlus_BrushSetSolidColor($brush2[1], 0xFFFF3300)
_GDIPlus_BrushSetSolidColor($brush2[2], 0xFFFF7700)

$hFormat = _GDIPlus_StringFormatCreate()
$hFamily2 = _GDIPlus_FontFamilyCreate("Arial")
$hFont2 = _GDIPlus_FontCreate($hFamily2, $fontsize_txt2, 2)
$tLayout = _GDIPlus_RectFCreate(0, 0)
$y = 0

Do
	_GDIPlus_GraphicsClear($backbuffer, 0x00000000)
	For $x = 1 To $z - 1
	
		Switch $x
			Case 1
			   $z1 = 0
			Case 2
			   $z1 = 83
			Case 3
			   $z1 = 100
			Case 4
			   $z1 = 220
			Case 5
			   $z1 = 300
			Case 6
			   $z1 = 380
			Case 7
			   $z1 = 500
		EndSwitch

		DllStructSetData($tLayout, "x", $z1)
		DllStructSetData($tLayout, "y", 100)
		_GDIPlus_GraphicsDrawStringEx($backbuffer, $arrTxt2[$x], $hFont2, $tLayout, $hFormat, $brush2[$x])
	Next
	If Mod($y, 2) = 1 Then Array_Rot($brush2)
	$y += 1

    $gdibitmap = _GDIPlus_BitmapCreateHBITMAPFromBitmap($bitmap)
    _WinAPI_SelectObject($dc, $gdibitmap)
    _WinAPI_UpdateLayeredWindow($hWnd, $ScreenDc, 0, $pSize, $dc, $pSource, 0, $pBlend, 2)
	_WinAPI_DeleteObject($gdibitmap)
Until False * Not Sleep(30) Or $y=50
EndFunc

Func Array_Rot(ByRef $arr, $dir = 0) ;0 for left, 1 for right
	Local $tmp, $p,$q
		$tmp = $arr[UBound($arr) - 1]
		$q = UBound($arr) - 1
		For $p = UBound($arr) - 2 To 0 Step - 1
			$arr[$q] = $arr[$p]
			$q -= 1
		Next
		$arr[0] = $tmp
EndFunc

Func Close()
	For $x = 0 To $z - 1
		_GDIPlus_BrushDispose($brush2[$x])
	Next
	_WinAPI_DeleteDC($dc)
    _WinAPI_ReleaseDC($hWnd, $ScreenDc)
	_GDIPlus_FontDispose($hFont2)
	_GDIPlus_FontFamilyDispose($hFamily2)
	_GDIPlus_StringFormatDispose($hFormat)
	_GDIPlus_GraphicsDispose($backbuffer)
	_GDIPlus_BitmapDispose($bitmap)
	_GDIPlus_GraphicsDispose($graphics)
	_GDIPlus_Shutdown()
	WinClose($hwnd)
	Exit
EndFunc   ;==>Close