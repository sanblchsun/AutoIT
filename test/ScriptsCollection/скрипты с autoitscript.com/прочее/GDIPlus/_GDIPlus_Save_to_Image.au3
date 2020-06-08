Func _SaveImage()
        _GDIPlus_Save_to_Image(@DesktopDir & "\File001.jpg", $frm_Disegno)
EndFunc
 
; #FUNCTION# =============================================================================
; Name.............:            _GDIPlus_Save_to_Image
; Description ...:        INTERNAL FUNCTION - save drawnelements in GUI to file
; Syntax...........:            _GDIPlus_Save_to_Image($file, $hWnd)
; Parameters ...:          $file - filename
;                                                          $hWnd - handle to GUI
; Author .........:              ptrex, ProgAndy, UEZ
; =========================================================================================
Func _GDIPlus_Save_to_Image($file, $hWnd)
        Local $hDC, $memBmp, $memDC, $hImage, $w, $h, $size, $err, $sCLSID, $ext, $fExt
        If $file <> "" Or $hWnd <> "" Then
                $size = WinGetClientSize($hWnd)
                $w = $size[0]
                $h = $size[1]
                $hDC = _WinAPI_GetDC($hWnd)
                $memDC = _WinAPI_CreateCompatibleDC($hDC)
                $memBmp = _WinAPI_CreateCompatibleBitmap($hDC, $w, $h)
                _WinAPI_SelectObject ($memDC, $memBmp)
                _WinAPI_BitBlt($memDC, 0, 0, $w, $h, $hDC, 0, 0, 0x00CC0020) ;  0x00CC0020 = $SRCCOPY
                $hImage = _GDIPlus_BitmapCreateFromHBITMAP ($memBmp)
                $ext = "png,bmp,jpg,tif,gif"
                $fExt = StringRight($file, 3)
                If Not StringInStr($ext, $fExt)  Then
                        $CLSID = "PNG"
                        $file &= ".png"
                Else
                        $CLSID = $fExt
                EndIf
                $sCLSID = _GDIPlus_EncodersGetCLSID ($CLSID)
                If Not _GDIPlus_ImageSaveToFileEx ($hImage, $file, $sCLSID) Then $err = 1
                _GDIPlus_ImageDispose ($hImage)
                _WinAPI_ReleaseDC($hWnd, $hDC)
                _WinAPI_DeleteDC($memDC)
                _WinAPI_DeleteObject ($memBmp)
                If $err Then Return SetError(2, 0, 0)
                Return SetError(0, 0, 0)
        Else
                Return SetError(1, 0, 0)
        EndIf
EndFunc