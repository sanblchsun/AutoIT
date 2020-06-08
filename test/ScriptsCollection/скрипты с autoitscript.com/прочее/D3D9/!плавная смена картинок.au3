#include <File.au3>
#include <GDIP.au3>
#include <ScreenCapture.au3>
#include <WindowsConstants.au3>

Local Const $sImagesFolder = @ScriptDir & "\Images"
Local Const $iDeskWidth = @DesktopWidth, $iDeskHeight = @DesktopHeight
Local $hCurImage, $hNextImage, $hDisplayImage, $hScreenBmp
Local $hGraphics, $hImageGraphics
Local $hImageAttributes, $tScaleMatrixIn, $pScaleMatrixIn, $tScaleMatrixOut, $pScaleMatrixOut
Local $nInScaleF, $nOutScaleF
Local $aSize, $iCurImgWidth, $iCurImgHeight, $iNextImgWidth, $iNextImgHeight
Local $aFiles = _FileListToArray($sImagesFolder, "*.jpg", 1)
If @error Then Exit

_GDIPlus_Startup()

Local $hGUI = GUICreate("", $iDeskWidth, $iDeskHeight, 0, 0, $WS_POPUP)
$hGraphics = _GDIPlus_GraphicsCreateFromHWND($hGUI)

$hDisplayImage = _GDIPlus_BitmapCreateFromScan0($iDeskWidth, $iDeskHeight)
$hImageGraphics = _GDIPlus_ImageGetGraphicsContext($hDisplayImage)

$hScreenBmp = _ScreenCapture_Capture("", 0, 0, -1, -1, False)
$hNextImage = _GDIPlus_BitmapCreateFromHBITMAP($hScreenBmp)
_WinAPI_DeleteObject($hScreenBmp)

$hImageAttributes = _GDIPlus_ImageAttributesCreate()
; Fade in color scaling matrix
$tScaleMatrixIn = _GDIPlus_ColorMatrixCreateScale(1.0, 1.0, 1.0)
$pScaleMatrixIn = DllStructGetPtr($tScaleMatrixIn)
; Fade out color scaling matrix
$tScaleMatrixOut = _GDIPlus_ColorMatrixCreateScale(1.0, 1.0, 1.0)
$pScaleMatrixOut = DllStructGetPtr($tScaleMatrixOut)
HotKeySet("{ESC}", "_Quit")
OnAutoItExitRegister("_CleanUp")
GUISetState()

For $i = 1 To $aFiles[0]
    If $hNextImage Then $hCurImage = $hNextImage
    $hNextImage = _GDIPlus_ImageLoadFromFile($sImagesFolder & "\" & $aFiles[$i])
    If @error Then ContinueLoop

    $aSize = _GDIPlus_ImageGetDimension($hCurImage)
    $iCurImgWidth = $aSize[0]
    $iCurImgHeight = $aSize[1]
    $aSize = _GDIPlus_ImageGetDimension($hNextImage)
    $iNextImgWidth = $aSize[0]
    $iNextImgHeight = $aSize[1]

    For $j = 15 To 255 Step 60
        $nInScaleF = $j / 255
        $nOutScaleF = (255 - $j) / 255

        _UpdateScaleColorMatrix($tScaleMatrixIn, $nInScaleF, $nInScaleF, $nInScaleF, $nInScaleF)
        _UpdateScaleColorMatrix($tScaleMatrixOut, $nOutScaleF, $nOutScaleF, $nOutScaleF, $nOutScaleF)

        _GDIPlus_GraphicsClear($hImageGraphics)
        _GDIPlus_ImageAttributesSetColorMatrix($hImageAttributes, 0, True, $pScaleMatrixOut)
        _GDIPlus_GraphicsDrawImageRectRectIA($hImageGraphics, $hCurImage, 0, 0, $iCurImgWidth, $iCurImgHeight, 0, 0, $iDeskWidth, $iDeskHeight, $hImageAttributes)
        _GDIPlus_ImageAttributesSetColorMatrix($hImageAttributes, 0, True, $pScaleMatrixIn)
        _GDIPlus_GraphicsDrawImageRectRectIA($hImageGraphics, $hNextImage, 0, 0, $iNextImgWidth, $iNextImgHeight, 0, 0, $iDeskWidth, $iDeskHeight, $hImageAttributes)
        _GDIPlus_GraphicsDrawImage($hGraphics, $hDisplayImage, 0, 0)
    Next

    _GDIPlus_ImageDispose($hCurImage)

    Sleep(2000)
Next

Func _Quit()
    Exit
EndFunc

Func _CleanUp()
    _GDIPlus_ImageDispose($hNextImage)
    _GDIPlus_ImageDispose($hCurImage)
    _GDIPlus_ImageAttributesDispose($hImageAttributes)
    _GDIPlus_GraphicsDispose($hImageGraphics)
    _GDIPlus_ImageDispose($hDisplayImage)
    _GDIPlus_GraphicsDispose($hGraphics)
    _GDIPlus_Shutdown()
    GUIDelete($hGUI)
EndFunc

Func _UpdateScaleColorMatrix(ByRef $tCM, $nRed, $nGreen, $nBlue, $nAlpha = 1)
    DllStructSetData($tCM, "m", $nRed, 1)
    DllStructSetData($tCM, "m", $nGreen, 7)
    DllStructSetData($tCM, "m", $nBlue, 13)
    DllStructSetData($tCM, "m", $nAlpha, 19)
EndFunc