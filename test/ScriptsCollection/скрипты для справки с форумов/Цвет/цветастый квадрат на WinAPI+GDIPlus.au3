#include <GDIPlus.au3>
#include <WinAPI.au3>

Global $sSaveImage = @ScriptDir & "\Colors.jpg"
Global $iImageSize = 200, $iSquareSize = 10
Global $hBMP, $hImage, $hGraphic, $hBrush, $iX = 0, $iY = 0

_GDIPlus_Startup()

$hBMP = _WinAPI_CreateBitmap($iImageSize, $iImageSize, 1, 32)
$hImage = _GDIPlus_BitmapCreateFromHBITMAP($hBMP)
$hGraphic = _GDIPlus_ImageGetGraphicsContext($hImage)
$hBrush = _GDIPlus_BrushCreateSolid()
For $i = 1 To ($iImageSize * $iImageSize) Step $iSquareSize
    _GDIPlus_BrushSetSolidColor($hBrush, Random(0xFF000000, 0xFFFFFFFF, 1))
    _GDIPlus_GraphicsFillRect($hGraphic, $iX, $iY, $iSquareSize, $iSquareSize, $hBrush)
    If $iX >= $iImageSize Then
        $iX = 0
        $iY += $iSquareSize
    Else
        $iX += $iSquareSize
    EndIf
Next
_GDIPlus_ImageSaveToFile($hImage, $sSaveImage)

_WinAPI_DeleteObject($hBMP)
_GDIPlus_BrushDispose($hBrush)
_GDIPlus_GraphicsDispose($hGraphic)
_GDIPlus_ImageDispose($hImage)

_GDIPlus_Shutdown()

If FileExists($sSaveImage) Then ShellExecute($sSaveImage)