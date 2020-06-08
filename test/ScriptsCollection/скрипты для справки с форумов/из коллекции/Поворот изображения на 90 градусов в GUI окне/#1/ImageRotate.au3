#region ;**** Directives created by AutoIt3Wrapper_GUI ****
#AutoIt3Wrapper_Run_AU3Check=n
#endregion ;**** Directives created by AutoIt3Wrapper_GUI ****
#Include <GDIP.au3>
#Include <WinAPI.au3>
#Include <WindowsConstants.au3>

Global Const $STM_SETIMAGE = 0x0172
Global Const $STM_GETIMAGE = 0x0173

Dim $Pic[4]
Dim $aImage[4]

GUICreate('MyGUI', 4 * 128, 128)
For $i = 0 To 3
    $Pic[$i] = GUICtrlCreatePic('', $i * 128, 0, 128, 128)
Next

_GDIPlus_Startup()
$hPic = _GDIPlus_ImageLoadFromFile('Arrow.png')
For $i = 0 To 3
    _GDIPlus_ImageRotateFlip($hPic, 1)
    $W = _GDIPlus_ImageGetWidth($hPic)
    $H = _GDIPlus_ImageGetHeight($hPic)
    $Size = WinGetClientSize(GUICtrlGetHandle($Pic[$i]))
    If ($W) And ($H) And (IsArray($Size)) Then
        If $W < $H Then
            $W = $Size[0] * $W / $H
            $H = $Size[1]
        Else
            $H = $Size[1] * $H / $W
            $W = $Size[0]
        EndIf
        $hBitmap = _WinAPI_CreateBitmap($Size[0], $Size[1], 1, 32)
        $hImage = _GDIPlus_BitmapCreateFromHBITMAP($hBitmap)
        _WinAPI_DeleteObject($hBitmap)
        $hGraphic = _GDIPlus_ImageGetGraphicsContext($hImage)
        $hBrush = _GDIPlus_BrushCreateSolid(BitOR(0xFF000000, _WinAPI_SwitchColor(_WinAPI_GetSysColor($COLOR_3DFACE))))
        _GDIPlus_GraphicsFillRect($hGraphic, 0, 0, $Size[0], $Size[1], $hBrush)
        _GDIPlus_GraphicsDrawImageRect($hGraphic, $hPic, ($Size[0] - $W) / 2, ($Size[1] - $H) / 2, $W, $H)
        _SetImage($Pic[$i], _GDIPlus_BitmapCreateHBITMAPFromBitmap($hImage))
        _GDIPlus_GraphicsDispose($hGraphic)
        _GDIPlus_BrushDispose($hBrush)
        _GDIPlus_ImageDispose($hImage)
    EndIf
Next
_GDIPlus_ImageDispose($hPic)
_GDIPlus_Shutdown()


GUISetState()

Do
Until GUIGetMsg() = -3

Func _SetImage($hWnd, $hBitmap)

    If Not IsHWnd($hWnd) Then
        $hWnd = GUICtrlGetHandle($hWnd)
        If Not $hWnd Then
            Return
        EndIf
    EndIf

    Local $hObj

    $hObj = _SendMessage($hWnd, $STM_SETIMAGE, 0, $hBitmap)
    If $hObj Then
        _WinAPI_DeleteObject($hObj)
    EndIf
    _WinAPI_InvalidateRect($hWnd)
    $hObj = _SendMessage($hWnd, $STM_GETIMAGE)
    If $hObj <> $hBitmap Then
        _WinAPI_DeleteObject($hBitmap)
    EndIf
EndFunc   ;==>_SetImage

Func _WinAPI_SwitchColor($iColor)
    Return BitOR(BitAND($iColor, 0x00FF00), BitShift(BitAND($iColor, 0x0000FF), -16), BitShift(BitAND($iColor, 0xFF0000), 16))
EndFunc   ;==>_WinAPI_SwitchColor
