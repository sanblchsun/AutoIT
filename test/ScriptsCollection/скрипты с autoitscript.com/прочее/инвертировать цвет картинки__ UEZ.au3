;coded by UEZ
;thanks to Authenticity for GDIP.au3 and the great examples
; http://www.autoitscript.com/forum/topic/125964-invert-colours-of-a-image/#entry874312
#include <GDIPlus.au3>
#Include <Misc.au3>

$file = FileOpenDialog("Select image to load", @ScriptDir, "Images (*.jpg;*.png;*.bmp)")

If @error Then Exit

_GDIPlus_Startup()
$hImage = _GDIPlus_ImageLoadFromFile($file)
$scale_factor = 1.0
$iX = _GDIPlus_ImageGetWidth($hImage) * $scale_factor
$iY = _GDIPlus_ImageGetHeight($hImage) * $scale_factor

$hGUI = GUICreate("GDI+: Image to Negative Example", $iX, $iY)
GUISetState()

$hGraphics = _GDIPlus_GraphicsCreateFromHWND($hGUI)

Global $hImageContext, $hBackImage
_Negative()

$dll = DllOpen("user32.dll")

While 1
    Switch GUIGetMsg()
        Case -3
            _GDIPlus_BitmapDispose($hImage)
            _GDIPlus_GraphicsDispose($hImageContext)
            _GDIPlus_BitmapDispose($hBackImage)
            _GDIPlus_GraphicsDispose($hGraphics)
            _GDIPlus_Shutdown()
            GUIDelete($hGUI)
            DllClose($dll)
    Exit
    EndSwitch
    If _IsPressed("4E", $dll) Then ;press n to negative image
        $hImage = _GDIPlus_BitmapCloneArea($hBackImage, 0, 0, $iX, $iY)
        _Negative()
    EndIf
    Sleep(100)
WEnd

Func _Negative()
    Local $tNegMatrix, $pNegMatrix
    If $hImage Then
        $hBackImage = _GDIPlus_BitmapCloneArea($hImage, 0, 0, $iX, $iY)
        $hImageContext = _GDIPlus_ImageGetGraphicsContext($hBackImage)
    $tNegMatrix = _GDIPlus_ColorMatrixCreateNegative()
    $pNegMatrix = DllStructGetPtr($tNegMatrix)
        $hIA = _GDIPlus_ImageAttributesCreate()
    _GDIPlus_ImageAttributesSetColorMatrix($hIA, 0, True, $pNegMatrix)
    _GDIPlus_GraphicsDrawImageRectRectIA($hImageContext, $hImage, 0, 0, $iX, $iY, 0, 0, $iX, $iY, $hIA)
        _GDIPlus_GraphicsDrawImageRectRect($hGraphics, $hBackImage, 0, 0, $iX, $iY, 0, 0, $iX, $iY)
        $tNegMatrix = 0
    EndIf
EndFunc

; #FUNCTION# ====================================================================================================================
; Name...........: _GDIPlus_ColorMatrixCreateNegative
; Description ...: Creates and initializes a negative color matrix
; Syntax.........: _GDIPlus_ColorMatrixCreateNegative()
; Parameters ....: None
; Return values .: Success  - $tagGDIPCOLORMATRIX structure
;   Failure     - 0
; Remarks .......: None
; Related .......: $tagGDIPCOLORMATRIX
; Link ..........; @@MsdnLink@@ ColorMatrix
; Example .......; No
; ===============================================================================================================================
Func _GDIPlus_ColorMatrixCreateNegative()
    Local $iI, $tCM
    $tCM = _GDIPlus_ColorMatrixCreateScale(-1, -1, -1, 1)
    For $iI = 1 To 4
        DllStructSetData($tCM, "m", 1, 20 + $iI)
    Next
    Return $tCM
EndFunc ;==>_GDIPlus_ColorMatrixCreateNegative

; #FUNCTION# ====================================================================================================================
; Name...........: _GDIPlus_ColorMatrixCreateScale
; Description ...: Creates and initializes a scaling color matrix
; Syntax.........: _GDIPlus_ColorMatrixCreateScale($nRed, $nGreen, $nBlue[, $nAlpha = 1])
; Parameters ....: $nRed - Red component scaling factor
;   $nGreen - Green component scaling factor
;   $nBlue - Blue component scaling factor
;   $nAlpha - Alpha component scaling factor
; Return values .: Success  - $tagGDIPCOLORMATRIX structure that contains a scaling color matrix
;   Failure     - 0
; Remarks .......: A scaling color matrix is used to multiply components of a color by multiplier factors
; Related .......: $tagGDIPCOLORMATRIX
; Link ..........; @@MsdnLink@@ ColorMatrix
; Example .......; No
; ===============================================================================================================================
Func _GDIPlus_ColorMatrixCreateScale($nRed, $nGreen, $nBlue, $nAlpha = 1)
    Local $tCM
    Local Const $tagGDIPCOLORMATRIX = "float m[25]"
    $tCM = DllStructCreate($tagGDIPCOLORMATRIX)
    DllStructSetData($tCM, "m", $nRed, 1)
    DllStructSetData($tCM, "m", $nGreen, 7)
    DllStructSetData($tCM, "m", $nBlue, 13)
    DllStructSetData($tCM, "m", $nAlpha, 19)
    DllStructSetData($tCM, "m", 1, 25)
    Return $tCM
EndFunc ;==>_GDIPlus_ColorMatrixCreateScale

; #FUNCTION# ====================================================================================================================
; Name...........: _GDIPlus_ImageAttributesSetColorMatrix
; Description ...: Sets or clears the color- and grayscale-adjustment matrices for a specified category
; Syntax.........: _GDIPlus_ImageAttributesSetColorMatrix($hImageAttributes[, $iColorAdjustType = 0[, $fEnable = False,[ $pClrMatrix = 0[, $pGrayMatrix = 0[, $iColorMatrixFlags = 0]]]]])
; Parameters ....: $hImageAttributes - Pointer to an ImageAttribute object
;   $iColorAdjustType - The category for which the color- and grayscale-adjustment matrices are set or cleared:
;   |0 - Color or grayscale adjustment applies to all categories that do not have adjustment settings of their own
;   |1 - Color or grayscale adjustment applies to bitmapped images
;   |2 - Color or grayscale adjustment applies to brush operations in metafiles
;   |3 - Color or grayscale adjustment applies to pen operations in metafiles
;   |4 - Color or grayscale adjustment applies to text drawn in metafiles
;   $fEnable            - If True, the specified matrices (color, grayscale or both) adjustments for the specified
;   +category are applied; otherwise the category is cleared
;   $pClrMatrix      - Pointer to a $tagGDIPCOLORMATRIX structure that specifies a color-adjustment matrix
;   $pGrayMatrix         - Pointer to a $tagGDIPCOLORMATRIX structure that specifies a grayscale-adjustment matrix
;   $iColorMatrixFlags - Type of image and color that will be affected by the adjustment matrices:
;   |0 - All color values (including grays) are adjusted by the same color-adjustment matrix
;   |1 - Colors are adjusted but gray shades are not adjusted.
;   +A gray shade is any color that has the same value for its red, green, and blue components
;   |2 - Colors are adjusted by one matrix and gray shades are adjusted by another matrix
; Return values .: Success  - True
;   Failure     - False and either:
;   |@error and @extended are set if DllCall failed
;   |$GDIP_STATUS contains a non zero value specifying the error code
; Remarks .......: None
; Related .......: _GDIPlus_ColorMatrixCreate, $tagGDIPCOLORMATRIX
; Link ..........; @@MsdnLink@@ GdipSetImageAttributesColorMatrix
; Example .......; No
; ===============================================================================================================================
Func _GDIPlus_ImageAttributesSetColorMatrix($hImageAttributes, $iColorAdjustType = 0, $fEnable = False, $pClrMatrix = 0, $pGrayMatrix = 0, $iColorMatrixFlags = 0)
    Local $aResult = DllCall($ghGDIPDll, "uint", "GdipSetImageAttributesColorMatrix", "hwnd", $hImageAttributes, "int", $iColorAdjustType, "int", $fEnable, "ptr", $pClrMatrix, "ptr", $pGrayMatrix, "int", $iColorMatrixFlags)

    If @error Then Return SetError(@error, @extended, False)
    $GDIP_STATUS = $aResult[0]
    Return $aResult[0] = 0
EndFunc ;==>_GDIPlus_ImageAttributesSetColorMatrix

; #FUNCTION# ====================================================================================================================
; Name...........: _GDIPlus_GraphicsDrawImageRectRectIA
; Description ...: Draws an image
; Syntax.........: _GDIPlus_GraphicsDrawImageRectRectIA($hGraphics, $hImage, $nSrcX, $nSrcY, $nSrcWidth, $nSrcHeight, $nDstX, $nDstY, $nDstWidth, $nDstHeight[, $hImageAttributes = 0[, $iUnit = 2]])
; Parameters ....: $hGraphics - Pointer to a Graphics object
;   $hImage     - Pointer to an Image object
;   $iSrcX  - The X coordinate of the upper left corner of the source image
;   $iSrcY  - The Y coordinate of the upper left corner of the source image
;   $iSrcWidth - Width of the source image
;   $iSrcHeight - Height of the source image
;   $iDstX  - The X coordinate of the upper left corner of the destination image
;   $iDstY  - The Y coordinate of the upper left corner of the destination image
;   $iDstWidth - Width of the destination image
;   $iDstHeight - Height of the destination image
;   $hImageAttributes - Pointer to an ImageAttributes object that specifies the color and size attributes of the image to be drawn
;   $iUnit   - Unit of measurement:
;   |0 - World coordinates, a nonphysical unit
;   |1 - Display units
;   |2 - A unit is 1 pixel
;   |3 - A unit is 1 point or 1/72 inch
;   |4 - A unit is 1 inch
;   |5 - A unit is 1/300 inch
;   |6 - A unit is 1 millimeter
; Return values .: Success  - True
;   Failure     - False and either:
;   |@error and @extended are set if DllCall failed
;   |$GDIP_STATUS contains a non zero value specifying the error code
; Remarks .......: None
; Related .......: None
; Link ..........; @@MsdnLink@@ GdipDrawImageRectRect
; Example .......; No
; ===============================================================================================================================
Func _GDIPlus_GraphicsDrawImageRectRectIA($hGraphics, $hImage, $nSrcX, $nSrcY, $nSrcWidth, $nSrcHeight, $nDstX, $nDstY, $nDstWidth, $nDstHeight, $hImageAttributes = 0, $iUnit = 2)
    Local $aResult = DllCall($ghGDIPDll, "int", "GdipDrawImageRectRect", "hwnd", $hGraphics, "hwnd", $hImage, "float", $nDstX, "float", _
            $nDstY, "float", $nDstWidth, "float", $nDstHeight, "float", $nSrcX, "float", $nSrcY, "float", $nSrcWidth, "float", _
            $nSrcHeight, "int", $iUnit, "hwnd", $hImageAttributes, "int", 0, "int", 0)

    If @error Then Return SetError(@error, @extended, False)
    $GDIP_STATUS = $aResult[0]
    Return $aResult[0] = 0
EndFunc ;==>_GDIPlus_GraphicsDrawImageRectRectIA

; #FUNCTION# ====================================================================================================================
; Name...........: _GDIPlus_ImageAttributesCreate
; Description ...: Creates an ImageAttributes object
; Syntax.........: _GDIPlus_ImageAttributesCreate()
; Parameters ....: None
; Return values .: Success  - Pointer to a new ImageAttribute object
;   Failure     - 0 and either:
;   |@error and @extended are set if DllCall failed
;   |$GDIP_STATUS contains a non zero value specifying the error code
; Remarks .......: After you are done with the object, call _GDIPlus_ImageAttributesDispose to release the object resources
; Related .......: _GDIPlus_ImageAttributesDispose
; Link ..........; @@MsdnLink@@ GdipCreateImageAttributes
; Example .......; No
; ===============================================================================================================================
Func _GDIPlus_ImageAttributesCreate()
    Local $aResult = DllCall($ghGDIPDll, "uint", "GdipCreateImageAttributes", "int*", 0)

    If @error Then Return SetError(@error, @extended, 0)
    $GDIP_STATUS = $aResult[0]
    Return $aResult[1]
EndFunc ;==>_GDIPlus_ImageAttributesCreate
 