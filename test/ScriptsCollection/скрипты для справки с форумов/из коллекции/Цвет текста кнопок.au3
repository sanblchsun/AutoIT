#Include <GUIButton.au3>
#Include <GUIImageList.au3>
#Include <WinAPI.au3>
#Include <WindowsConstants.au3>

GUICreate('MyGUI', 200, 200)
GUICtrlCreateButton('', 65, 170, 70, 23)
_GUICtrlButton_SetTextColor(-1, 'OK', 0xff0000)
GUISetState()

Do
Until GUIGetMsg() = -3

Func _GUICtrlButton_SetTextColor($iCtrlID, $sText, $iTextColor)

    Local $hWnd, $hTheme, $hImageList, $hBitmap, $hBack, $hDC, $hMemDC, $hSrcDC, $tRect, $pRect, $Width, $Height, $Prev, $Flags = BitOR($DT_CENTER, $DT_SINGLELINE, $DT_VCENTER)

    $hWnd = GUICtrlGetHandle($iCtrlID)
    If Not $hWnd Then
        Return 0
    EndIf
    $hTheme = DllCall('uxtheme.dll', 'ptr', 'OpenThemeData', 'hwnd', $hWnd, 'wstr', 'BUTTON')
    If (@error) Or (Not $hTheme[0]) Then
        GUICtrlSetColor($iCtrlID, $iTextColor)
        GUICtrlSetData($iCtrlID, $sText)
        Return 1
    EndIf
    $Width = _WinAPI_GetClientWidth($hWnd)
    $Height = _WinAPI_GetClientHeight($hWnd)
    $hImageList = _GUIImageList_Create($Width - 8, $Height - 8, 4, 4)
    $tRect = DllStructCreate('int[4]')
    DllStructSetData($tRect, 1, -4, 1)
    DllStructSetData($tRect, 1, -4, 2)
    DllStructSetData($tRect, 1, $Width - 4, 3)
    DllStructSetData($tRect, 1, $Height - 4, 4)
    $pRect = DllStructGetPtr($tRect)
    $hDC = _WinAPI_GetDC(0)
    $hMemDC = _WinAPI_CreateCompatibleDC($hDC)
    $hSrcDC = _WinAPI_CreateCompatibleDC($hDC)
    $hBitmap = _WinAPI_CreateCompatibleBitmap($hDC, $Width - 8, $Height - 8)
    $hBack = _WinAPI_CreateCompatibleBitmap($hDC, $Width - 8, $Height - 8)
    _WinAPI_ReleaseDC(0, $hDC)
    _WinAPI_SelectObject($hSrcDC, $hBack)
    _WinAPI_SelectObject($hMemDC, _SendMessage($hWnd, $WM_GETFONT))
    _WinAPI_SetTextColor($hMemDC, BitOR(BitAND($iTextColor, 0x00FF00), BitShift(BitAND($iTextColor, 0x0000FF), -16), BitShift(BitAND($iTextColor, 0xFF0000), 16)))
    _WinAPI_SetBkMode($hMemDC, $TRANSPARENT)
    ; PBS_NORMAL, PBS_HOT, PBS_PRESSED, PBS_DISABLED, PBS_DEFAULTED
    For $i = 1 To 5
        $Prev = _WinAPI_SelectObject($hMemDC, $hBitmap)
        DllCall('uxtheme.dll', 'int', 'DrawThemeBackground', 'ptr', $hTheme[0], 'hwnd', $hSrcDC, 'int', 1, 'int', $i, 'ptr', $pRect, 'ptr', 0)
        _WinAPI_BitBlt($hMemDC, 0, 0, $Width - 8, $Height - 8, $hSrcDC, 0, 0, $MERGECOPY)
        If $i = 4 Then
            DllCall('uxtheme.dll', 'int', 'DrawThemeText', 'ptr', $hTheme[0], 'hwnd', $hMemDC, 'int', 1, 'int', 4, 'wstr', $sText, 'int', -1, 'dword', $Flags, 'dword', 0, 'ptr', $pRECT)
        Else
            _WinAPI_DrawText($hMemDC, $sText, $tRect, $Flags)
        EndIf
        _WinAPI_SelectObject($hMemDC, $Prev)
        _GUIImageList_Add($hImageList, $hBitmap)
    Next
    ; PBS_HOT (Stylus Hot)
    _GUIImageList_SetImageCount($hImageList, 6)
    _GUIImageList_Copy($hImageList, 1, 5)
    _WinAPI_DeleteDC($hMemDC)
    _WinAPI_DeleteDC($hSrcDC)
    _WinAPI_DeleteObject($hBitmap)
    _WinAPI_DeleteObject($hBack)
    DllCall('uxtheme.dll', 'int', 'CloseThemeData', 'ptr', $hTheme[0])
    $Prev = _GUICtrlButton_GetImageList($hWnd)
    If $Prev[0] Then
        _GUIImageList_Destroy($Prev[0])
    EndIf
    GUICtrlSetData($iCtrlID, '')
    If Not _GUICtrlButton_SetImageList($hWnd, $hImageList, 4) Then
        _GUIImageList_Destroy($hImageList)
        Return 0
    EndIf
    Return 1
EndFunc   ;==>_GUICtrlButton_SetTextColor
