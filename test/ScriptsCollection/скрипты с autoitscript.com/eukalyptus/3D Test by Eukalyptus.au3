;by eukalyptus
#include <gdiplus.au3>
#include <guiconstantsex.au3>
#include <windowsconstants.au3>

Opt("MustDeclareVars", 1)
Opt("GUIOnEventMode", 1)

Global $iWidth = 400;@DesktopWidth
Global $iHeight = 400;@DesktopHeight

Global $fRX = 0.1
Global $fRY = 1.5
Global $fRZ = -0.3

Global Const $PI = ATan(1) * 4
Global Const $PI2 = $PI * 2
Global Const $Deg2Rad = $PI / 180
Global Const $Rad2Deg = 180 / $PI

_GDIPlus_Startup()
Global $hGui = GUICreate("3D Test by Eukalyptus", $iWidth, $iHeight)
GUISetOnEvent($GUI_EVENT_CLOSE, "_Exit")
Global $hGraphics = _GDIPlus_GraphicsCreateFromHWND($hGui)
Global $hBmpBuffer = _GDIPlus_BitmapCreateFromGraphics($iWidth, $iHeight, $hGraphics)
Global $hGfxBuffer = _GDIPlus_ImageGetGraphicsContext($hBmpBuffer)
_GDIPlus_GraphicsSetSmoothingMode($hGfxBuffer, 2)
_GDIPlus_GraphicsClear($hGfxBuffer, 0xFF000000)

Global $hBmpScale = _GDIPlus_BitmapCreateFromGraphics($iWidth, $iHeight, $hGraphics)
Global $hGfxScale = _GDIPlus_ImageGetGraphicsContext($hBmpScale)
_GDIPlus_GraphicsClear($hGfxScale, 0xFF000000)
Global $fScale = 0.02
DllCall($ghGDIPDll, "uint", "GdipSetInterpolationMode", "hwnd", $hGfxScale, "int", 5)
DllCall($ghGDIPDll, "uint", "GdipTranslateWorldTransform", "hwnd", $hGfxScale, "float", -($iWidth / 2 * $fScale), "float", -($iHeight / 2 * $fScale), "int", 0)
DllCall($ghGDIPDll, "uint", "GdipScaleWorldTransform", "hwnd", $hGfxScale, "float", 1 + $fScale, "float", 1 + $fScale, "int", 0)

Global $hPenBG = _GDIPlus_PenCreate(0xFF005500, 1)
Global $hPenFG = _GDIPlus_PenCreate(0xFF00FF00, 2)
DllCall($ghGDIPDll, "uint", "GdipSetPenLineJoin", "hwnd", $hPenFG, "int", 2)
Global $hPenGL = _GDIPlus_PenCreate(0x2400AAFF, 1)
Global $hBrush = _GDIPlus_BrushCreateSolid(0x30000000)

GUIRegisterMsg($WM_PAINT, "WM_PAINT")
GUIRegisterMsg($WM_ERASEBKGND, "WM_ERASEBKGND")

GUISetState()

GUICreate("Rotate", 200, 100, 0, 0, -1, -1, $hGui)
GUISetOnEvent($GUI_EVENT_CLOSE, "_Exit")
Global $cSliderX = GUICtrlCreateSlider(10, 10, 180, 30)
GUICtrlSetData(-1, 50 + ($fRX * 10))
GUICtrlSetOnEvent(-1, "_SetRotate")
Global $cSliderY = GUICtrlCreateSlider(10, 40, 180, 30)
GUICtrlSetData(-1, 50 + ($fRY * 10))
GUICtrlSetOnEvent(-1, "_SetRotate")
Global $cSliderZ = GUICtrlCreateSlider(10, 70, 180, 30)
GUICtrlSetData(-1, 50 + ($fRZ * 10))
GUICtrlSetOnEvent(-1, "_SetRotate")
GUISetState()


Global $aPnt = _CreateBall("GDI+ AutoIt Script|3D Text-Ball|by Eukalyptus", 0.65, 0.25, $iWidth, $iHeight, 0.7)

While 1
    _Draw()
    ;Sleep(10)
WEnd


Func _SetRotate()
    Switch @GUI_CtrlId
        Case $cSliderX
            $fRX = (50 - GUICtrlRead($cSliderX)) / 10
        Case $cSliderY
            $fRY = (50 - GUICtrlRead($cSliderY)) / 10
        Case $cSliderZ
            $fRZ = (50 - GUICtrlRead($cSliderZ)) / 10
    EndSwitch
EndFunc   ;==>_SetRotate



Func _Draw()

    Local $iW2 = $iWidth / 2
    Local $iH2 = $iHeight / 2

    Local Static $fA = 0, $fB = 0, $fC = 0
    $fA += $fRX
    $fB += $fRY
    $fC += $fRZ

    If $fA >= 360 Then
        $fA -= 360
    ElseIf $fA <= 0 Then
        $fA += 360
    EndIf

    If $fB >= 360 Then
        $fB -= 360
    ElseIf $fB <= 0 Then
        $fB += 360
    EndIf

    If $fC >= 360 Then
        $fC -= 360
    ElseIf $fC <= 0 Then
        $fC += 360
    EndIf

    _Rotate($aPnt[0], $aPnt[3], $aPnt[4], $aPnt[1], $aPnt[2], $fA, $fB, $fC, $iW2, $iH2)

    Local $aResult = DllCall($ghGDIPDll, "uint", "GdipCreatePath2", "ptr", $aPnt[6], "ptr", $aPnt[7], "int", $aPnt[0], "int", 0, "int*", 0)
    Local $hPath = $aResult[5]

    $aResult = DllCall($ghGDIPDll, "uint", "GdipCreatePath", "int", 0, "int*", 0)
    Local $hPath_FG = $aResult[2]
    $aResult = DllCall($ghGDIPDll, "uint", "GdipCreatePath", "int", 0, "int*", 0)
    Local $hPath_BG = $aResult[2]

    $aResult = DllCall($ghGDIPDll, "uint", "GdipCreatePathIter", "int*", 0, "hwnd", $hPath)
    Local $hPathIter = $aResult[1]
    Local $aIter = $aPnt[8]

    For $i = 1 To $aIter[0][0]
        DllCall($ghGDIPDll, "uint", "GdipPathIterNextSubpathPath", "hwnd", $hPathIter, "int*", 0, "hwnd", $aIter[$i][1], "int*", 0)
        If DllStructGetData($aPnt[2], 1, ($aIter[$i][2]) + 1) > 20 Then
            DllCall($ghGDIPDll, "uint", "GdipAddPathPath", "hwnd", $hPath_BG, "hwnd", $aIter[$i][1], "int", 1)
        Else
            DllCall($ghGDIPDll, "uint", "GdipAddPathPath", "hwnd", $hPath_FG, "hwnd", $aIter[$i][1], "int", 1)
        EndIf
    Next

    DllCall($ghGDIPDll, "uint", "GdipDeletePathIter", "hwnd", $hPathIter)

    For $i = 1 To 3
        _GDIPlus_GraphicsDrawImage($hGfxBuffer, $hBmpScale, 0, 0)
        _GDIPlus_GraphicsFillRect($hGfxBuffer, 0, 0, $iWidth, $iHeight, $hBrush)

        DllCall($ghGDIPDll, "uint", "GdipDrawPath", "hwnd", $hGfxBuffer, "hwnd", $hPenGL, "hwnd", $hPath)

        _GDIPlus_GraphicsDrawImage($hGfxScale, $hBmpBuffer, 0, 0)
    Next
    DllCall($ghGDIPDll, "uint", "GdipDrawPath", "hwnd", $hGfxBuffer, "hwnd", $hPenBG, "hwnd", $hPath_BG)
    DllCall($ghGDIPDll, "uint", "GdipDrawPath", "hwnd", $hGfxBuffer, "hwnd", $hPenFG, "hwnd", $hPath_FG)

    DllCall($ghGDIPDll, "uint", "GdipDeletePath", "hwnd", $hPath)
    DllCall($ghGDIPDll, "uint", "GdipDeletePath", "hwnd", $hPath_BG)
    DllCall($ghGDIPDll, "uint", "GdipDeletePath", "hwnd", $hPath_FG)

    _GDIPlus_GraphicsDrawImage($hGraphics, $hBmpBuffer, 0, 0)
EndFunc   ;==>_Draw


Func _Rotate($iCount, ByRef $tP_O, ByRef $tPZ_O, ByRef $tP_N, ByRef $tPZ_N, $fA, $fB, $fC, $iW2, $iH2)
    $fA *= $Deg2Rad
    $fB *= $Deg2Rad
    $fC *= $Deg2Rad

    Local $fX, $fY, $fZ, $fPX, $fPY, $fPZ

    For $i = 0 To $iCount - 1
        $fPX = DllStructGetData($tP_O, 1, $i * 2 + 1)
        $fPY = DllStructGetData($tP_O, 1, $i * 2 + 2)
        $fPZ = DllStructGetData($tPZ_O, 1, $i + 1)

        $fY = $fPY * Cos($fA) - $fPZ * Sin($fA)
        $fZ = $fPY * Sin($fA) + $fPZ * Cos($fA)
        $fPY = $fY
        $fPZ = $fZ

        $fX = $fPX * Cos($fB) + $fPZ * Sin($fB)
        $fZ = -$fPX * Sin($fB) + $fPZ * Cos($fB)
        $fPX = $fX

        DllStructSetData($tP_N, 1, $fPX * Cos($fC) - $fPY * Sin($fC) + $iW2, $i * 2 + 1)
        DllStructSetData($tP_N, 1, $fPY * Cos($fC) + $fPX * Sin($fC) + $iH2, $i * 2 + 2)
        DllStructSetData($tPZ_N, 1, $fZ, $i + 1)
    Next

EndFunc   ;==>_Rotate


Func _CreateBall($sText, $fScaleX, $fScaleY, $iW, $iH, $fBallSize, $sFont = "Arial", $fFlat = 5)
    Local $aSplit = StringSplit($sText, "|")

    Local $aResult = DllCall($ghGDIPDll, "uint", "GdipCreatePath", "int", 0, "int*", 0)
    Local $hPath = $aResult[2]

    Local $hFormat = _GDIPlus_StringFormatCreate()
    Local $hFamily = _GDIPlus_FontFamilyCreate($sFont)
    Local $tLayout = _GDIPlus_RectFCreate(0, 0, 0, 0)
    Local $tBounds = _GDIPlus_RectFCreate(0, 0, 0, 0)

    For $i = 1 To $aSplit[0]
        DllCall($ghGDIPDll, "uint", "GdipAddPathString", "hwnd", $hPath, "wstr", $aSplit[$i], "int", -1, "hwnd", $hFamily, "int", 0, "float", 50, "ptr", DllStructGetPtr($tLayout), "hwnd", $hFormat)
        DllCall($ghGDIPDll, "uint", "GdipGetPathWorldBounds", "hwnd", $hPath, "ptr", DllStructGetPtr($tBounds), "hwnd", 0, "hwnd", 0)
        DllStructSetData($tLayout, "Y", DllStructGetData($tBounds, "Y") + DllStructGetData($tBounds, "Height"))
    Next

    DllCall($ghGDIPDll, "uint", "GdipFlattenPath", "hwnd", $hPath, "hwnd", 0, "float", $fFlat)
    _GDIPlus_FontFamilyDispose($hFamily)
    _GDIPlus_StringFormatDispose($hFormat)

    $aResult = DllCall($ghGDIPDll, "uint", "GdipGetPointCount", "hwnd", $hPath, "int*", 0)
    Local $iCount = $aResult[2]
    Local $tPathData = DllStructCreate("int;ptr;ptr")
    Local $tPoints = DllStructCreate("float[" & $iCount * 2 & "]")
    Local $tTypes = DllStructCreate("ubyte[" & $iCount & "]")
    Local $tPointsZ = DllStructCreate("float[" & $iCount & "]")

    DllStructSetData($tPathData, 1, $iCount)
    DllStructSetData($tPathData, 2, DllStructGetPtr($tPoints))
    DllStructSetData($tPathData, 3, DllStructGetPtr($tTypes))

    DllCall($ghGDIPDll, "uint", "GdipGetPathData", "hwnd", $hPath, "ptr", DllStructGetPtr($tPathData))

    Local $fRad = $iH / 2 * $fBallSize
    If $iH > $iW Then $fRad = $iW / 2 * $fBallSize

    Local $fPIY = $PI * $fScaleY

    Local $fX, $fY, $fZ, $fA, $fB, $fPX, $fPY, $fPZ
    Local $fBX = (DllStructGetData($tBounds, "X") + DllStructGetData($tBounds, "Width")) / $fScaleX
    Local $fBY = (DllStructGetData($tBounds, "Y") + DllStructGetData($tBounds, "Height")) / $fScaleY

    For $i = 0 To $iCount - 1
        $fX = DllStructGetData($tPoints, 1, $i * 2 + 1)
        $fY = DllStructGetData($tPoints, 1, $i * 2 + 2)

        $fB = $PI - $fX * $PI2 / $fBX
        $fA = $fPIY - $fY * $PI2 / $fBY
        $fPX = 0
        $fPY = 0
        $fPZ = $fRad

        $fY = $fPY * Cos($fA) - $fPZ * Sin($fA)
        $fZ = $fPY * Sin($fA) + $fPZ * Cos($fA)
        $fPY = $fY
        $fPZ = $fZ

        $fX = $fPX * Cos($fB) + $fPZ * Sin($fB)
        $fZ = -$fPX * Sin($fB) + $fPZ * Cos($fB)

        DllStructSetData($tPoints, 1, $fX, $i * 2 + 1)
        DllStructSetData($tPoints, 1, $fY, $i * 2 + 2)
        DllStructSetData($tPointsZ, 1, $fZ, $i + 1)
    Next

    Local $tPointsRotate = DllStructCreate("float[" & $iCount * 2 & "]")
    Local $tPointsZRotate = DllStructCreate("float[" & $iCount & "]")

    $aResult = DllCall($ghGDIPDll, "uint", "GdipCreatePathIter", "int*", 0, "hwnd", $hPath)
    Local $hPathIter = $aResult[1]
    $aResult = DllCall($ghGDIPDll, "uint", "GdipPathIterGetSubpathCount", "hwnd", $hPathIter, "int*", 0)
    Local $iSubCount = $aResult[2]
    Local $aIter[$iCount + 1][3] = [[$iSubCount]]
    For $i = 1 To $iSubCount
        $aResult = DllCall($ghGDIPDll, "uint", "GdipCreatePath", "int", 0, "int*", 0)
        $aIter[$i][1] = $aResult[2]
        $aResult = DllCall($ghGDIPDll, "uint", "GdipPathIterNextSubpath", "hwnd", $hPathIter, "int*", 0, "int*", 0, "int*", 0, "int*", 0)
        $aIter[$i][2] = $aResult[3]
    Next
    DllCall($ghGDIPDll, "uint", "GdipDeletePathIter", "hwnd", $hPathIter)

    DllCall($ghGDIPDll, "uint", "GdipDeletePath", "hwnd", $hPath)

    Local $aReturn[9]
    $aReturn[0] = $iCount
    $aReturn[1] = $tPointsRotate
    $aReturn[2] = $tPointsZRotate
    $aReturn[3] = $tPoints
    $aReturn[4] = $tPointsZ
    $aReturn[5] = $tTypes
    $aReturn[6] = DllStructGetPtr($tPointsRotate)
    $aReturn[7] = DllStructGetPtr($tTypes)
    $aReturn[8] = $aIter

    Return $aReturn
EndFunc   ;==>_CreateBall


Func WM_PAINT($hWnd, $uMsgm, $wParam, $lParam)
    _GDIPlus_GraphicsDrawImage($hGraphics, $hBmpBuffer, 0, 0)
    Return $GUI_RUNDEFMSG
EndFunc   ;==>WM_PAINT


Func WM_ERASEBKGND($hWnd, $uMsgm, $wParam, $lParam)
    _GDIPlus_GraphicsDrawImage($hGraphics, $hBmpBuffer, 0, 0)
    Return $GUI_RUNDEFMSG
EndFunc   ;==>WM_ERASEBKGND


Func _Exit()
    Local $aIter = $aPnt[8]
    For $i = 1 To $aIter[0][0]
        DllCall($ghGDIPDll, "uint", "GdipDeletePath", "hwnd", $aIter[$i][1])
    Next
    _GDIPlus_PenDispose($hPenBG)
    _GDIPlus_PenDispose($hPenFG)
    _GDIPlus_PenDispose($hPenGL)
    _GDIPlus_BrushDispose($hBrush)
    _GDIPlus_GraphicsDispose($hGfxScale)
    _GDIPlus_BitmapDispose($hBmpScale)
    _GDIPlus_GraphicsDispose($hGfxBuffer)
    _GDIPlus_BitmapDispose($hBmpBuffer)
    _GDIPlus_GraphicsDispose($hGraphics)
    _GDIPlus_Shutdown()
    Exit
EndFunc   ;==>_Exit