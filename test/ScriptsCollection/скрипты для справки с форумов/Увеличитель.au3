#Include <WinAPIEx.au3>
#Include <WindowsConstants.au3>

Opt('MustDeclareVars', 1)

Global $hParent, $hForm, $Pos, $hBitmap = 0, $Go = 1, $XPrev = MouseGetPos(0), $YPrev = MouseGetPos(1)

HotKeySet('{ESC}', '_Quit')

$hParent = GUICreate('', -1, -1, -1, -1, -1, $WS_EX_TOOLWINDOW)
$hForm = GUICreate('', 200, 200, $XPrev + 25, $YPrev + 25, BitOR($WS_DISABLED, $WS_POPUPWINDOW), BitOR($WS_EX_LAYERED, $WS_EX_TOPMOST), $hParent)
GUISetState(@SW_SHOWNOACTIVATE, $hForm)

While 1
    GUIGetMsg()
    $Pos = MouseGetPos()
    If ($Go) Or ($Pos[0] <> $XPrev) Or ($Pos[1] <> $YPrev) Then
        WinMove($hForm, '', $Pos[0] + 25, $Pos[1] + 25)
        _Capture($Pos[0] - 25, $Pos[1] - 25, 50, 50)
        $XPrev = $Pos[0]
        $YPrev = $Pos[1]
        $Go = 0
    EndIf
WEnd

Func _Capture($iX, $iY, $iWidth, $iHeight)

    Local $tRect, $hDC, $hMemDC, $hScreenshort = _ScreenCapture($iX, $iY, $iWidth, $iHeight)

    _WinAPI_FreeObject($hBitmap)
    $hBitmap = _WinAPI_FitToBitmap($hScreenshort, 200, 200)
    _WinAPI_FreeObject($hScreenshort)
    $hDC = _WinAPI_GetDC($hForm)
    $hMemDC = _WinAPI_CreateCompatibleDC($hDC)
    _WinAPI_SelectObject($hMemDC, $hBitmap)
    _WinAPI_SelectObject($hMemDC, _WinAPI_GetStockObject($NULL_BRUSH))
    _WinAPI_SelectObject($hMemDC, _WinAPI_GetStockObject($DC_PEN))
    _WinAPI_SetDCPenColor($hMemDC, 0xA00000)
    $tRect = _WinAPI_CreateRect(0, 0, 200, 200)
    _WinAPI_Rectangle($hMemDC, $tRect)
    _WinAPI_ReleaseDC($hForm, $hDC)
    _WinAPI_DeleteDC($hMemDC)
    _SetBitmap($hForm, $hBitmap, 255)
EndFunc   ;==>_Capture

Func _Quit()
    Exit
EndFunc   ;==>_Quit

Func _ScreenCapture($iX, $iY, $iWidth, $iHeight)

    Local $hWnd, $hDC, $hMemDC, $hBitmap

    $hWnd = _WinAPI_GetDesktopWindow()
    $hDC = _WinAPI_GetDC($hWnd)
    $hMemDC = _WinAPI_CreateCompatibleDC($hDC)
    $hBitmap = _WinAPI_CreateCompatibleBitmap($hDC, $iWidth, $iHeight)
    _WinAPI_SelectObject($hMemDC, $hBitmap)
    _WinAPI_BitBlt($hMemDC, 0, 0, $iWidth, $iHeight, $hDC, $iX, $iY, $MERGECOPY)
    _WinAPI_ReleaseDC($hWnd, $hDC)
    _WinAPI_DeleteDC($hMemDC)
    Return $hBitmap
EndFunc   ;==>_ScreenCapture

Func _SetBitmap($hWnd, $hBitmap, $iOpacity)

    Local $hDC, $hMemDC, $hSv, $pBlend, $tBlend, $pSize, $tSize, $pSource, $tSource

    $hDC = _WinAPI_GetDC($hWnd)
    $hMemDC = _WinAPI_CreateCompatibleDC($hDC)
    $hSv = _WinAPI_SelectObject($hMemDC, $hBitmap)
    $tSize = _WinAPI_GetBitmapDimension($hBitmap)
    $pSize = DllStructGetPtr($tSize)
    $tSource = DllStructCreate($tagPOINT)
    $pSource = DllStructGetPtr($tSource)
    $tBlend = DllStructCreate($tagBLENDFUNCTION)
    $pBlend = DllStructGetPtr($tBlend)
    DllStructSetData($tBlend, 'Alpha', $iOpacity)
    DllStructSetData($tBlend, 'Format', 0)
    _WinAPI_UpdateLayeredWindow($hWnd, $hDC, 0, $pSize, $hMemDC, $pSource, 0, $pBlend, $ULW_ALPHA)
    _WinAPI_ReleaseDC($hWnd, $hDC)
    _WinAPI_SelectObject($hMemDC, $hSv)
    _WinAPI_DeleteDC($hMemDC)
EndFunc   ;==>_SetBitmap