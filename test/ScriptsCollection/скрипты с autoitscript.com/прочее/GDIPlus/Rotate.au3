; Simple flipping of an Image in GDI+? - поворот картинки
; http://www.autoitscript.com/forum/topic/141640-simple-flipping-of-an-image-in-gdi/

#include <ScreenCapture.au3>

_GDIPlus_Startup()
Global Const $iDiv = @DesktopWidth / 6
Global Const $hHBitmap = _ScreenCapture_Capture("", 0, 0, @DesktopWidth, $iDiv)
Global Const $hBitmap = _GDIPlus_BitmapCreateFromHBITMAP($hHBitmap)
Global Const $hCtxt = _GDIPlus_ImageGetGraphicsContext($hBitmap)
_WinAPI_DeleteObject($hHBitmap)

Global Const $hBitmap_Temp = _GDIPlus_BitmapCreateFromScan0($iDiv, $iDiv)
Global Const $hCtxt_Temp = _GDIPlus_ImageGetGraphicsContext($hBitmap_Temp)

Global $iStep = 0

For $i = 1 To 3
    _GDIPlus_GraphicsDrawImageRectRect($hCtxt_Temp, $hBitmap, $iStep, 0, $iDiv, $iDiv, 0, 0, $iDiv, $iDiv)
    _GDIPlus_ImageRotateFlip($hBitmap_Temp, $i)
    _GDIPlus_GraphicsDrawImageRectRect($hCtxt, $hBitmap_Temp, 0, 0, $iDiv, $iDiv, $iStep, 0, $iDiv, $iDiv)
    $iStep += $iDiv
Next

For $i = 5 To 7
    _GDIPlus_GraphicsDrawImageRectRect($hCtxt_Temp, $hBitmap, $iStep, 0, $iDiv, $iDiv, 0, 0, $iDiv, $iDiv)
    _GDIPlus_ImageRotateFlip($hBitmap_Temp, $i)
    _GDIPlus_GraphicsDrawImageRectRect($hCtxt, $hBitmap_Temp, 0, 0, $iDiv, $iDiv, $iStep, 0, $iDiv, $iDiv)
    $iStep += $iDiv
Next

Global Const $hGUI = GUICreate("Flipped Images", @DesktopWidth, $iDiv)
GUISetState()
Global Const $hGraphic = _GDIPlus_GraphicsCreateFromHWND($hGUI)
_GDIPlus_GraphicsDrawImageRect($hGraphic, $hBitmap, 0, 0, @DesktopWidth, $iDiv)

Do
Until GUIGetMsg() = -3

_GDIPlus_BitmapDispose($hBitmap)
_GDIPlus_BitmapDispose($hBitmap_Temp)
_GDIPlus_GraphicsDispose($hCtxt)
_GDIPlus_GraphicsDispose($hCtxt_Temp)
_GDIPlus_GraphicsDispose($hGraphic)
_GDIPlus_Shutdown()
GUIDelete()
Exit

; #FUNCTION# ====================================================================================================================
; Name...........: _GDIPlus_ImageRotateFlip
; Description ...: Rotates and flips an image
; Syntax.........: _GDIPlus_ImageRotateFlip($hImage, $iRotateFlipType)
; Parameters ....: $hImage          - Pointer to an Image object
;                  $iRotateFlipType - Type of rotation and flip:
;                  |0 - No rotation and no flipping (A 180-degree rotation, a horizontal flip and then a vertical flip)
;                  |1 - A 90-degree rotation without flipping (A 270-degree rotation, a horizontal flip and then a vertical flip)
;                  |2 - A 180-degree rotation without flipping (No rotation, a horizontal flip folow by a vertical flip)
;                  |3 - A 270-degree rotation without flipping (A 90-degree rotation, a horizontal flip and then a vertical flip)
;                  |4 - No rotation and a horizontal flip (A 180-degree rotation followed by a vertical flip)
;                  |5 - A 90-degree rotation followed by a horizontal flip (A 270-degree rotation followed by a vertical flip)
;                  |6 - A 180-degree rotation followed by a horizontal flip (No rotation and a vertical flip)
;                  |7 - A 270-degree rotation followed by a horizontal flip (A 90-degree rotation followed by a vertical flip)
; Return values .: Success      - True
;                  Failure      - False and either:
;                  |@error and @extended are set if DllCall failed
;                  |$GDIP_STATUS contains a non zero value specifying the error code
; Remarks .......: None
; Related .......: None
; Link ..........; @@MsdnLink@@ GdipImageRotateFlip
; Example .......; No
; ===============================================================================================================================
Func _GDIPlus_ImageRotateFlip($hImage, $iRotateFlipType)
    Local $aResult = DllCall($ghGDIPDll, "uint", "GdipImageRotateFlip", "handle", $hImage, "int", $iRotateFlipType)
    If @error Then Return SetError(@error, @extended, False)
    Return $aResult[0] = 0
EndFunc   ;==>_GDIPlus_ImageRotateFlip

; #FUNCTION# ====================================================================================================================
; Name...........: _GDIPlus_BitmapCreateFromScan0
; Description ...: Creates a Bitmap object based on an array of bytes along with size and format information
; Syntax.........: _GDIPlus_BitmapCreateFromScan0($iWidth, $iHeight[, $iStride = 0[, $iPixelFormat = 0x0026200A[, $pScan0 = 0]]])
; Parameters ....: $iWidth         - The bitmap width, in pixels
;                  $iHeight     - The bitmap height, in pixels
;                  $iStride     - Integer that specifies the byte offset between the beginning of one scan line and the next. This
;                  +is usually (but not necessarily) the number of bytes in the pixel format (for example, 2 for 16 bits per pixel)
;                  +multiplied by the width of the bitmap. The value passed to this parameter must be a multiple of four
;                  $iPixelFormat - Specifies the format of the pixel data. Can be one of the following:
;                  |$GDIP_PXF01INDEXED   - 1 bpp, indexed
;                  |$GDIP_PXF04INDEXED   - 4 bpp, indexed
;                  |$GDIP_PXF08INDEXED   - 8 bpp, indexed
;                  |$GDIP_PXF16GRAYSCALE - 16 bpp, grayscale
;                  |$GDIP_PXF16RGB555    - 16 bpp; 5 bits for each RGB
;                  |$GDIP_PXF16RGB565    - 16 bpp; 5 bits red, 6 bits green, and 5 bits blue
;                  |$GDIP_PXF16ARGB1555  - 16 bpp; 1 bit for alpha and 5 bits for each RGB component
;                  |$GDIP_PXF24RGB       - 24 bpp; 8 bits for each RGB
;                  |$GDIP_PXF32RGB       - 32 bpp; 8 bits for each RGB. No alpha.
;                  |$GDIP_PXF32ARGB      - 32 bpp; 8 bits for each RGB and alpha
;                  |$GDIP_PXF32PARGB     - 32 bpp; 8 bits for each RGB and alpha, pre-mulitiplied
;                  $pScan0        - Pointer to an array of bytes that contains the pixel data. The caller is responsible for
;                  +allocating and freeing the block of memory pointed to by this parameter.
; Return values .: Success      - Returns a handle to a new Bitmap object
;                  Failure      - 0 and either:
;                  |@error and @extended are set if DllCall failed
;                  |$GDIP_STATUS contains a non zero value specifying the error code
; Remarks .......: After you are done with the object, call _GDIPlus_ImageDispose to release the object resources
; Related .......: _GDIPlus_ImageDispose
; Link ..........; @@MsdnLink@@ GdipCreateBitmapFromScan0
; Example .......; Yes
; ===============================================================================================================================
Func _GDIPlus_BitmapCreateFromScan0($iWidth, $iHeight, $iStride = 0, $iPixelFormat = 0x0026200A, $pScan0 = 0)
    Local $aResult = DllCall($ghGDIPDll, "uint", "GdipCreateBitmapFromScan0", "int", $iWidth, "int", $iHeight, "int", $iStride, "int", $iPixelFormat, "ptr", $pScan0, "int*", 0)
    If @error Then Return SetError(@error, @extended, 0)
    Return $aResult[6]
EndFunc   ;==>_GDIPlus_BitmapCreateFromScan0