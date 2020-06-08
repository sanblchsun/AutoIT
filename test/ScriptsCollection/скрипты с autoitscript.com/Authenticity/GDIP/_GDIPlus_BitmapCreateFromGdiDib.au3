#include <FontConstants.au3>
#include <GDIP.au3>
#include <GUIConstantsEx.au3>
#include <WindowsConstants.au3>
Opt("MustDeclareVars", 1)

_Example()

Func _Example()
	Local $hGUI, $hGraphics, $hDC, $hCDC, $hTheme
	Local $hBitmap, $hDIBBmp, $hOldBmp, $hFont, $hOldFont
	Local $pBitmapData, $tBmpInfo, $tDTTOptions, $pDTTOptions, $tClientRect, $pClientRect
	
	; Initialize GDI+
	_GDIPlus_Startup()
	
	; Create the GUI window, press ESC to quit
	$hGUI = GUICreate("", @DesktopWidth, @DesktopHeight)
	GUISetState()
	
	; Opens the theme data for GUI window and its associated class.
	$hTheme = _WinAPI_OpenThemeData($hGUI, "globals")
	
	$hGraphics = _GDIPlus_GraphicsCreateFromHWND($hGUI)
	$hDC = _GDIPlus_GraphicsGetDC($hGraphics)
    $hCDC = _WinAPI_CreateCompatibleDC($hDC)
	$tClientRect = _WinAPI_GetClientRect($hGUI)
	$pClientRect = DllStructGetPtr($tClientRect)
	
	
    $tBmpInfo = DllStructCreate($tagBITMAPINFO)
    DllStructSetData($tBmpInfo, "Size", DllStructGetSize($tBmpInfo)-4)
    DllStructSetData($tBmpInfo, "Width", @DesktopWidth)
    DllStructSetData($tBmpInfo, "Height", -@DesktopHeight)
    DllStructSetData($tBmpInfo, "Planes", 1)
    DllStructSetData($tBmpInfo, "BitCount", 32)
    DllStructSetData($tBmpInfo, "Compression", 0) ; BI_RGB
    
	; Create the DIB object and select assign to the memory device context
    $hDIBBmp = _WinAPI_CreateDIBSection($hDC, $tBmpInfo, $pBitmapData)
	$hFont = _WinAPI_CreateFont(50, 30, 0, 0, 400, False, False, False, $DEFAULT_CHARSET, $OUT_DEFAULT_PRECIS, $CLIP_DEFAULT_PRECIS, $DEFAULT_QUALITY, 0, 'Courier New')
	
    $hOldBmp = _WinAPI_SelectObject($hCDC, $hDIBBmp) ; Select the DIBBMP object before drawing text
	$hOldFont = _WinAPI_SelectObject($hCDC, $hFont)  ; Select the font object

    $tDTTOptions = DllStructCreate($tagDTTOPTS)
    DllStructSetData($tDTTOptions, "Size", DllStructGetSize($tDTTOptions))
    DllStructSetData($tDTTOptions, "Flags", BitOR($DTT_GLOWSIZE, $DTT_TEXTCOLOR, $DTT_COMPOSITED)) ; GlowSize and ClrText members are valid
    DllStructSetData($tDTTOptions, "GlowSize", 25)
	DllStructSetData($tDTTOptions, "clrText", _RGBtoBGR($GDIP_CHOCOLATE))
	$pDTTOptions = DllStructGetPtr($tDTTOptions)

    _WinAPI_DrawThemeTextEx($hTheme, $hCDC, 0, 0, "AutoIt GDI+", BitOR($DT_SINGLELINE, $DT_CENTER, $DT_VCENTER, $DT_NOPREFIX), $pClientRect, $pDTTOptions)

	; Release the graphics dc for painting
	_WinAPI_SelectObject($hCDC, $hOldFont)
	_WinAPI_SelectObject($hCDC, $hOldBmp)
	_WinAPI_DeleteObject($hFont)
	_WinAPI_DeleteDC($hCDC)
	_GDIPlus_GraphicsReleaseDC($hGraphics, $hDC)
	
	$hBitmap = _GDIPlus_BitmapCreateFromGdiDib($tBmpInfo, $pBitmapData)
	_GDIPlus_GraphicsDrawImage($hGraphics, $hBitmap, 0, 0)

	
	Do
	Until GUIGetMsg() = $GUI_EVENT_CLOSE
	
	; Clean up
	 _GDIPlus_ImageDispose($hBitmap)
	_GDIPlus_GraphicsDispose($hGraphics)
	_WinAPI_DeleteObject($hDIBBmp)
	
	_WinAPI_CloseThemeData($hTheme)
	
	; Uninitialize GDI+
	_GDIPlus_Shutdown()
EndFunc

Func _RGBtoBGR($iRGB)
	Return Dec(StringMid(Binary($iRGB), 3, 6))
EndFunc