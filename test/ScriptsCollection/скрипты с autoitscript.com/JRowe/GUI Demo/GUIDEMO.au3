#include <GDIPlus.au3>
#include <WindowsConstants.au3>
#include <GuiConstantsEx.au3>
#include <StaticConstants.au3>
Global Const $AC_SRC_ALPHA = 1

_GDIPlus_Startup()

$pngSrc = @ScriptDir & "\GUIBK.png"
;This allows the png to be dragged by clicking anywhere on the main image.
GUIRegisterMsg($WM_NCHITTEST, "WM_NCHITTEST")
$GUI = _GUICreate_Alpha("Look at the shiny", $pngSrc)
$myGuiHandle = WinGetHandle("Look at the shiny")
GUISetState()

;This is an invisible control container. You can create regular windows controls on this panel.
$controlGui = GUICreate("ControlGUI", 400, 400, 0, 0, $WS_POPUP, BitOR($WS_EX_LAYERED, $WS_EX_MDICHILD), $myGuiHandle)
GUICtrlSetBkColor($controlGui, 0xFF00FF)
GUICtrlSetState(-1, $GUI_DISABLE)


;This png is draggable as if it were a child window. It has about 50 pixels at the top that allow it to be dragged
$TransparentButtonTest = GUICreate("Test321", 100, 100, -1, -1, $WS_EX_MDICHILD, $WS_EX_LAYERED, $myGuiHandle)
$hImageButton = _GDIPlus_ImageLoadFromFile(@ScriptDir & "\Fav.png")
SetBitMap($TransparentButtonTest, $hImageButton, 255)

GUISetState()

;This png is static. It is in a fixed position relative to the main window png, and is dragged along with it.
;For fun, it fades out in cycles.
$TransparentButtonTest2 = GUICreate("Test123", 250, 250, 400, 200,$WS_POPUP, BitOR($WS_EX_LAYERED, $WS_EX_MDICHILD), $myGuiHandle)
$hImageButton2 = _GDIPlus_ImageLoadFromFile(@ScriptDir & "\Windows.png")
SetBitMap($TransparentButtonTest2, $hImageButton2, 255)

GUISetState()
$i = 0

While 1
$i = $i + 1
If $i = 255 Then $i = 0
	$msg = GUIGetMsg()
	$advMsg = GUIGetMsg(1)
    Select
        Case $msg = $GUI_EVENT_CLOSE
            ExitLoop

	EndSelect
SetBitMap($TransparentButtonTest2, $hImageButton2, $i)
WEnd


_GDIPlus_Shutdown()

Func WM_NCHITTEST($hWnd, $iMsg, $iwParam, $ilParam)
    If ($hwnd = WinGetHandle("Look at the shiny")) And ($iMsg = $WM_NCHITTEST) Then
	Return $HTCAPTION
	EndIf
EndFunc

Func _GUICreate_Alpha($sTitle, $sPath, $iX=-1, $iY=-1, $iOpacity=255)
    Local $hGUI, $hImage, $hScrDC, $hMemDC, $hBitmap, $hOld, $pSize, $tSize, $pSource, $tSource, $pBlend, $tBlend
    $hImage = _GDIPlus_ImageLoadFromFile($sPath)
    $width = _GDIPlus_ImageGetWidth($hImage)
    $height = _GDIPlus_ImageGetHeight($hImage)
    $hGUI = GUICreate($sTitle, $width, $height, $iX, $iY, $WS_POPUP, $WS_EX_LAYERED)
    $hScrDC = _WinAPI_GetDC(0)
    $hMemDC = _WinAPI_CreateCompatibleDC($hScrDC)
    $hBitmap = _GDIPlus_BitmapCreateHBITMAPFromBitmap($hImage)
    $hOld = _WinAPI_SelectObject($hMemDC, $hBitmap)
    $tSize = DllStructCreate($tagSIZE)
    $pSize = DllStructGetPtr($tSize)
    DllStructSetData($tSize, "X", $width)
    DllStructSetData($tSize, "Y", $height)
    $tSource = DllStructCreate($tagPOINT)
    $pSource = DllStructGetPtr($tSource)
    $tBlend = DllStructCreate($tagBLENDFUNCTION)
    $pBlend = DllStructGetPtr($tBlend)
    DllStructSetData($tBlend, "Alpha", $iOpacity)
    DllStructSetData($tBlend, "Format", 1)
    _WinAPI_UpdateLayeredWindow($hGUI, $hScrDC, 0, $pSize, $hMemDC, $pSource, 0, $pBlend, 2)
    _WinAPI_ReleaseDC(0, $hScrDC)
    _WinAPI_SelectObject($hMemDC, $hOld)
    _WinAPI_DeleteObject($hBitmap)
    _WinAPI_DeleteObject($hImage)
    _WinAPI_DeleteDC($hMemDC)
EndFunc ;==>_GUICreate_Alpha

Func SetBitmap($hGUI, $hImage, $iOpacity)
    Local $hScrDC, $hMemDC, $hBitmap, $hOld, $pSize, $tSize, $pSource, $tSource, $pBlend, $tBlend
    $hScrDC = _WinAPI_GetDC(0)
    $hMemDC = _WinAPI_CreateCompatibleDC($hScrDC)
    $hBitmap = _GDIPlus_BitmapCreateHBITMAPFromBitmap($hImage)
    $hOld = _WinAPI_SelectObject($hMemDC, $hBitmap)
    $tSize = DllStructCreate($tagSIZE)
    $pSize = DllStructGetPtr($tSize)
    DllStructSetData($tSize, "X", _GDIPlus_ImageGetWidth($hImage))
    DllStructSetData($tSize, "Y", _GDIPlus_ImageGetHeight($hImage))
    $tSource = DllStructCreate($tagPOINT)
    $pSource = DllStructGetPtr($tSource)
    $tBlend = DllStructCreate($tagBLENDFUNCTION)
    $pBlend = DllStructGetPtr($tBlend)
    DllStructSetData($tBlend, "Alpha", $iOpacity)
    DllStructSetData($tBlend, "Format", $AC_SRC_ALPHA)
    _WinAPI_UpdateLayeredWindow($hGUI, $hScrDC, 0, $pSize, $hMemDC, $pSource, 0, $pBlend, $ULW_ALPHA)
    _WinAPI_ReleaseDC(0, $hScrDC)
    _WinAPI_SelectObject($hMemDC, $hOld)
    _WinAPI_DeleteObject($hBitmap)
    _WinAPI_DeleteDC($hMemDC)
EndFunc   ;==>SetBitmap
