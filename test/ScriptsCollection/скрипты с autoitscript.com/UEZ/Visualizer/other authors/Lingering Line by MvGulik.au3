#region ;**** Directives created by AutoIt3Wrapper_GUI ****
#AutoIt3Wrapper_Run_AU3Check=y
#AutoIt3Wrapper_AU3Check_Stop_OnWarning=y
#AutoIt3Wrapper_AU3Check_Parameters=-d -w 1 -w 2 -w 3 -w 4        -w 6 -q
#endregion ;**** Directives created by AutoIt3Wrapper_GUI ****
Opt("GUIOnEventMode", 1)
#include <WindowsConstants.au3>
#include <GUIConstantsEx.au3>
#include <GDIPlus.au3>
Global Enum $_hWin_, $_hGraphic_, $_iWidth_, $_iHeight_, $_hBitmap_, $_Buffer_, $iFields_GdiGui
Global $HALFSIZE = True, $QUIT = False, $TOGGLESIZE = False, $FLIPCOLOR = False
Global $aGdiGui

Func _Lines_($iWidth, $iHeight, $hGraphic, $hBuffer)
    Local $aMax[4] = [$iWidth, $iHeight, $iWidth, $iHeight]
    Local $aLine[4] = [Random(0, $aMax[0], 1), Random(0, $aMax[1], 1), Random(0, $aMax[2], 1), Random(0, $aMax[3], 1)]
    Local $aMove[4] = [Random(1, 4, 1), Random(1, 4, 1), Random(1, 4, 1), Random(1, 4, 1)]
    Local $hPen = _GDIPlus_PenCreate(0x44000000, 1)
    Local $iJump = 2 * ($HALFSIZE * - 1 + 2)
    _AdlibSetup()
    GUIRegisterMsg($WM_PAINT, "WM_PAINT")
    GUIRegisterMsg($WM_ERASEBKGND, "WM_ERASEBKGND")
    Do
        For $j = 1 To $iJump
            _GDIPlus_GraphicsDrawLine($hBuffer, $aLine[0], $aLine[1], $aLine[2], $aLine[3], $hPen)
            _GDIPlus_GraphicsDrawLine($hGraphic, $aLine[0], $aLine[1], $aLine[2], $aLine[3], $hPen)
            For $i = 0 To 3
                $aLine[$i] += $aMove[$i]
                If $aLine[$i] < ($aMax[$i] * - 0.1) Then
                    $aMove[$i] = Random(1, 4, 1)
                ElseIf $aLine[$i] > ($aMax[$i] + $aMax[$i] * 0.1) Then
                    $aMove[$i] = Random(1, 4, 1) * - 1
                EndIf
            Next
        Next
        If $FLIPCOLOR Then
            If _GDIPlus_PenGetColor($hPen) > 0x44000000 Then
                _GDIPlus_PenSetColor($hPen, 0x44000000)
            Else
                _GDIPlus_PenSetColor($hPen, 0x44FFFFFF)
            EndIf
            $FLIPCOLOR = False
        EndIf

        Sleep(10)
    Until $QUIT
    GUISetState(@SW_HIDE, $aGdiGui[$_hWin_])
    Sleep(10)
    GUIRegisterMsg($WM_PAINT, "")
    GUIRegisterMsg($WM_ERASEBKGND, "")
    _GDIPlus_PenDispose($hPen)
    Return
EndFunc


Func MAIN()
    Do
        $aGdiGui = _GDI_Setup()
        _Lines_($aGdiGui[$_iWidth_], $aGdiGui[$_iHeight_], $aGdiGui[$_hGraphic_], $aGdiGui[$_Buffer_])
        _GDI_Shutdown($aGdiGui)
        If $TOGGLESIZE Then
            $HALFSIZE = ($HALFSIZE = False)
            $TOGGLESIZE = False
            $QUIT = False
            _AdlibSetup()
        EndIf
    Until $QUIT
    Return
EndFunc
Func _GDI_Setup()
    Local $aGdiGui[$iFields_GdiGui], $iLeft = -1, $iTop = -1
    If $HALFSIZE Then
        $aGdiGui[$_iWidth_] = @DesktopWidth / 2
        $aGdiGui[$_iHeight_] = @DesktopHeight / 2
    Else
        $aGdiGui[$_iWidth_] = @DesktopWidth
        $aGdiGui[$_iHeight_] = @DesktopHeight
        $iLeft = 0
        $iTop = 0
    EndIf
    $aGdiGui[$_hWin_] = GUICreate("Lingering Line", $aGdiGui[$_iWidth_], $aGdiGui[$_iHeight_], $iLeft, $iTop, $WS_POPUP)
    GUISetOnEvent($GUI_EVENT_CLOSE, "AK_Quit", $aGdiGui[$_hWin_])
    Local $AccelKeys[1][2] = [["{HOME}", GUICtrlCreateDummy()]]
    GUICtrlSetOnEvent($AccelKeys[0][1], 'AK_Quit')
    GUISetAccelerators($AccelKeys)
    _GDIPlus_Startup()
    $aGdiGui[$_hGraphic_] = _GDIPlus_GraphicsCreateFromHWND($aGdiGui[$_hWin_]) ;create graphic
    $aGdiGui[$_hBitmap_] = _GDIPlus_BitmapCreateFromGraphics($aGdiGui[$_iWidth_], $aGdiGui[$_iHeight_], $aGdiGui[$_hGraphic_]) ;create bitmap
    $aGdiGui[$_Buffer_] = _GDIPlus_ImageGetGraphicsContext($aGdiGui[$_hBitmap_]) ;create buffer
    Local Enum $_Smooth_none_, $_Smooth_8x4_, $_Smooth_8x8_
    _GDIPlus_GraphicsSetSmoothingMode($aGdiGui[$_Buffer_], $_Smooth_8x8_)
    _GDIPlus_GraphicsSetSmoothingMode($aGdiGui[$_hGraphic_], $_Smooth_8x8_)
    GUISetState(@SW_SHOW, $aGdiGui[$_hWin_])
    _GDIPlus_GraphicsClear($aGdiGui[$_Buffer_], 0xFF888888)
    _GDIPlus_GraphicsClear($aGdiGui[$_hGraphic_], 0xFF888888)
    Return $aGdiGui
EndFunc
Func WM_PAINT($hWnd, $Msg, $wParam, $lParam)
    _GDIPlus_GraphicsDrawImage($aGdiGui[$_hGraphic_], $aGdiGui[$_hBitmap_], 0, 0) ;copy to bitmap
    Return
EndFunc
Func WM_ERASEBKGND($hWnd, $Msg, $wParam, $lParam)
    Return 1
EndFunc
Func _GDI_Shutdown(ByRef $aGdiGui)
    _GDIPlus_BitmapDispose($aGdiGui[$_hBitmap_])
    _GDIPlus_GraphicsDispose($aGdiGui[$_Buffer_])
    _GDIPlus_GraphicsDispose($aGdiGui[$_hGraphic_])
    _GDIPlus_Shutdown()
    GUIDelete($aGdiGui[$_hWin_])
    $aGdiGui = 0
    Return
EndFunc
Func _AdlibSetup()
    AdlibUnRegister('_FlipColor')
    If $HALFSIZE Then
        AdlibRegister('_FlipColor', 4 * 1000)
    Else
        AdlibRegister('_FlipColor', 8 * 1000)
    EndIf
    Return
EndFunc
Func _FlipColor()
    $FLIPCOLOR = True
EndFunc
Func AK_Quit()
    If @GUI_CtrlId > 0 Then $TOGGLESIZE = True
    $QUIT = True
EndFunc

MAIN()