#include <GDIPlus.au3>
#include <GUIConstantsEx.au3>
#include <WindowsConstants.au3>
Opt("MustDeclareVars", 1)
Opt("GUIOnEventMode", 1)
Global Const $PI = ATan(1) * 4
Global Const $PI2 = $PI * 2
Global $iFrms = 40 ; Frames pro Sinusschwingung
Global $iFldX = 19 ; Anzahl Felder X ~[5..50]
Global $iFldZ = 32 ; Anzahl Felder Z ~[8..80]
Global $fSize = 0.7 ; Gro?e eines Feldes [0..1]
Global $fWaveCnt = 1.3 ; Anzahl der Wellenberge ~[1..5]
Global $fAmp = 0.12 ; Amplitude ~[0.01..0.3]
Global $fAmpOff = 0.05 ; Min Balkenhohe
Global $fSineXOff = 2.7 ; "Schrage" der Wellen ~[-10..10]
Global $iColor = 0xCC1122FF
Global $iWidth = 1000 ; @DesktopWidth
Global $iHeight = 500 ; @DesktopHeight
Global $fPersp = 0.1
Global $fYOff = -0.2
_GDIPlus_Startup()
Global $hGui = GUICreate("GDI+ Script by Eukalyptus", $iWidth, $iHeight)
GUISetOnEvent($GUI_EVENT_CLOSE, "_Exit")
Global $hDC = _WinAPI_GetDC($hGui)
Global $hBMP = _WinAPI_CreateCompatibleBitmap($hDC, $iWidth, $iHeight)
Global $hBmpTmp = _GDIPlus_BitmapCreateFromHBITMAP($hBMP)
_WinAPI_DeleteObject($hBMP)
$hBMP = _GDIPlus_BitmapCreateHBITMAPFromBitmap($hBmpTmp)
_GDIPlus_BitmapDispose($hBmpTmp)
Global $hCDC = _WinAPI_CreateCompatibleDC($hDC)
Global $hOBJ = _WinAPI_SelectObject($hCDC, $hBMP)
Global $hGfxBuffer = _GDIPlus_GraphicsCreateFromHDC($hCDC)
_GDIPlus_GraphicsClear($hGfxBuffer, 0xFF000000)
GUIRegisterMsg($WM_PAINT, "WM_PAINT")
GUIRegisterMsg($WM_ERASEBKGND, "WM_PAINT")
GUISetState()
Global $aBmpFrame[$iFrms], $aGfxFrame[$iFrms]
For $i = 0 To $iFrms - 1
$aBmpFrame[$i] = _GDIPlus_BitmapCreateFromGraphics($iWidth, $iHeight, $hGfxBuffer)
$aGfxFrame[$i] = _GDIPlus_ImageGetGraphicsContext($aBmpFrame[$i])
_GDIPlus_GraphicsSetSmoothingMode($aGfxFrame[$i], 2)
_GDIPlus_GraphicsClear($aGfxFrame[$i], 0xFF000000)
Next
ProgressOn("please wait", "...")
Global $iTimer = TimerInit()
Global $aFloor = _CreateFloor()
_DrawFrames()
ConsoleWrite("! " & TimerDiff($iTimer) & @CRLF)
ProgressOff()
Global $iFrame = 0
While Sleep(1)
If TimerDiff($iTimer) >= 30 Then
  _GDIPlus_GraphicsDrawImage($hGfxBuffer, $aBmpFrame[$iFrame], 0, 0)
  _WinAPI_BitBlt($hDC, 0, 0, $iWidth, $iHeight, $hCDC, 0, 0, 0x00CC0020)
  $iFrame += 1
  If $iFrame >= $iFrms Then $iFrame = 0
  $iTimer = TimerInit()
EndIf
WEnd
Func _DrawFrames()
Local $fY, $fAmpPersp, $fAmpPerspOff
Local $tPolyTop = DllStructCreate("float[8];")
Local $pPolyTop = DllStructGetPtr($tPolyTop)
Local $tPolyFront = DllStructCreate("float[8];")
Local $pPolyFront = DllStructGetPtr($tPolyFront)
Local $tPolySide = DllStructCreate("float[8];")
Local $pPolySide = DllStructGetPtr($tPolySide)
Local $hBrushTop = _GDIPlus_BrushCreateSolid($iColor)
Local $hBrushFront = _GDIPlus_BrushCreateSolid($iColor)
Local $hBrushSide = _GDIPlus_BrushCreateSolid($iColor)
Local $iAlpha = BitAND(BitShift($iColor, 24), 0xFF)
Local $iRed = BitAND(BitShift($iColor, 16), 0xFF)
Local $iGreen = BitAND(BitShift($iColor, 8), 0xFF)
Local $iBlue = BitAND($iColor, 0xFF)
For $z = 1 To $aFloor[1][0][0]
  ProgressSet(15 + ($z * 85 / $iFldZ))
  _GDIPlus_BrushSetSolidColor($hBrushTop, BitOR(BitShift($iAlpha, -24), BitShift($z * $iRed / $iFldZ, -16), BitShift($z * $iGreen / $iFldZ, -8), $z * $iBlue / $iFldZ))
  _GDIPlus_BrushSetSolidColor($hBrushSide, BitOR(BitShift($iAlpha, -24), BitShift($z * $iRed / $iFldZ * 0.2, -16), BitShift($z * $iGreen / $iFldZ * 0.2, -8), $z * $iBlue / $iFldZ * 0.2))
  _GDIPlus_BrushSetSolidColor($hBrushFront, BitOR(BitShift($iAlpha, -24), BitShift($z * $iRed / $iFldZ * 0.4, -16), BitShift($z * $iGreen / $iFldZ * 0.4, -8), $z * $iBlue / $iFldZ * 0.4))
  $fAmpPersp = $iHeight * $fPersp * $fAmp + ($iHeight * $fAmp * $z / $iFldZ)
  $fAmpPerspOff = $iHeight * $fPersp * $fAmpOff + ($iHeight * $fAmpOff * $z / $iFldZ)
  For $x = $aFloor[0][1][0] To Ceiling($aFloor[0][1][0] / 2) + 1 Step -1
   If $aFloor[$z][$x][0] < $iWidth Then
    DllStructSetData($tPolySide, 1, $aFloor[$z][$x][0], 1)
    DllStructSetData($tPolySide, 1, $aFloor[$z][$x][6], 3)
    DllStructSetData($tPolySide, 1, $aFloor[$z][$x][6], 5)
    DllStructSetData($tPolySide, 1, $aFloor[$z][$x][7], 6)
    DllStructSetData($tPolySide, 1, $aFloor[$z][$x][0], 7)
    DllStructSetData($tPolySide, 1, $aFloor[$z][$x][1], 8)
    DllStructSetData($tPolyFront, 1, $aFloor[$z][$x][4], 1)
    DllStructSetData($tPolyFront, 1, $aFloor[$z][$x][6], 3)
    DllStructSetData($tPolyFront, 1, $aFloor[$z][$x][6], 5)
    DllStructSetData($tPolyFront, 1, $aFloor[$z][$x][7], 6)
    DllStructSetData($tPolyFront, 1, $aFloor[$z][$x][4], 7)
    DllStructSetData($tPolyFront, 1, $aFloor[$z][$x][5], 8)
    DllStructSetData($tPolyTop, 1, $aFloor[$z][$x][0], 1)
    DllStructSetData($tPolyTop, 1, $aFloor[$z][$x][2], 3)
    DllStructSetData($tPolyTop, 1, $aFloor[$z][$x][4], 5)
    DllStructSetData($tPolyTop, 1, $aFloor[$z][$x][6], 7)
    For $iFrame = 0 To $iFrms - 1
     $fY = (Sin(($z * $PI2 / $iFldZ * $fWaveCnt) + ($iFrame * $PI2 / $iFrms) + ($x * $fSineXOff / $iFldX)) + 1) * $fAmpPersp + $fAmpPerspOff
     DllStructSetData($tPolySide, 1, $aFloor[$z][$x][1] - $fY, 2)
     DllStructSetData($tPolySide, 1, $aFloor[$z][$x][7] - $fY, 4)
     DllCall($ghGDIPDll, "int", "GdipFillPolygon", "handle", $aGfxFrame[$iFrame], "handle", $hBrushSide, "ptr", $pPolySide, "int", 4, "int", 0)
     DllStructSetData($tPolyFront, 1, $aFloor[$z][$x][5] - $fY, 2)
     DllStructSetData($tPolyFront, 1, $aFloor[$z][$x][7] - $fY, 4)
     DllCall($ghGDIPDll, "int", "GdipFillPolygon", "handle", $aGfxFrame[$iFrame], "handle", $hBrushFront, "ptr", $pPolyFront, "int", 4, "int", 0)
     DllStructSetData($tPolyTop, 1, $aFloor[$z][$x][1] - $fY, 2)
     DllStructSetData($tPolyTop, 1, $aFloor[$z][$x][3] - $fY, 4)
     DllStructSetData($tPolyTop, 1, $aFloor[$z][$x][5] - $fY, 6)
     DllStructSetData($tPolyTop, 1, $aFloor[$z][$x][7] - $fY, 8)
     DllCall($ghGDIPDll, "int", "GdipFillPolygon", "handle", $aGfxFrame[$iFrame], "handle", $hBrushTop, "ptr", $pPolyTop, "int", 4, "int", 0)
    Next
   EndIf
  Next
  For $x = 1 To Ceiling($aFloor[0][1][0] / 2)
   If $aFloor[$z][$x][2] > 0 Then
    DllStructSetData($tPolySide, 1, $aFloor[$z][$x][4], 1)
    DllStructSetData($tPolySide, 1, $aFloor[$z][$x][2], 3)
    DllStructSetData($tPolySide, 1, $aFloor[$z][$x][2], 5)
    DllStructSetData($tPolySide, 1, $aFloor[$z][$x][3], 6)
    DllStructSetData($tPolySide, 1, $aFloor[$z][$x][4], 7)
    DllStructSetData($tPolySide, 1, $aFloor[$z][$x][5], 8)
    DllStructSetData($tPolyFront, 1, $aFloor[$z][$x][4], 1)
    DllStructSetData($tPolyFront, 1, $aFloor[$z][$x][6], 3)
    DllStructSetData($tPolyFront, 1, $aFloor[$z][$x][6], 5)
    DllStructSetData($tPolyFront, 1, $aFloor[$z][$x][7], 6)
    DllStructSetData($tPolyFront, 1, $aFloor[$z][$x][4], 7)
    DllStructSetData($tPolyFront, 1, $aFloor[$z][$x][5], 8)
    DllStructSetData($tPolyTop, 1, $aFloor[$z][$x][0], 1)
    DllStructSetData($tPolyTop, 1, $aFloor[$z][$x][2], 3)
    DllStructSetData($tPolyTop, 1, $aFloor[$z][$x][4], 5)
    DllStructSetData($tPolyTop, 1, $aFloor[$z][$x][6], 7)
    For $iFrame = 0 To $iFrms - 1
     $fY = (Sin(($z * $PI2 / $iFldZ * $fWaveCnt) + ($iFrame * $PI2 / $iFrms) + ($x * $fSineXOff / $iFldX)) + 1) * $fAmpPersp + $fAmpPerspOff
     DllStructSetData($tPolySide, 1, $aFloor[$z][$x][5] - $fY, 2)
     DllStructSetData($tPolySide, 1, $aFloor[$z][$x][3] - $fY, 4)
     DllCall($ghGDIPDll, "int", "GdipFillPolygon", "handle", $aGfxFrame[$iFrame], "handle", $hBrushSide, "ptr", $pPolySide, "int", 4, "int", 0)
     DllStructSetData($tPolyFront, 1, $aFloor[$z][$x][5] - $fY, 2)
     DllStructSetData($tPolyFront, 1, $aFloor[$z][$x][7] - $fY, 4)
     DllCall($ghGDIPDll, "int", "GdipFillPolygon", "handle", $aGfxFrame[$iFrame], "handle", $hBrushFront, "ptr", $pPolyFront, "int", 4, "int", 0)
     DllStructSetData($tPolyTop, 1, $aFloor[$z][$x][1] - $fY, 2)
     DllStructSetData($tPolyTop, 1, $aFloor[$z][$x][3] - $fY, 4)
     DllStructSetData($tPolyTop, 1, $aFloor[$z][$x][5] - $fY, 6)
     DllStructSetData($tPolyTop, 1, $aFloor[$z][$x][7] - $fY, 8)
     DllCall($ghGDIPDll, "int", "GdipFillPolygon", "handle", $aGfxFrame[$iFrame], "handle", $hBrushTop, "ptr", $pPolyTop, "int", 4, "int", 0)
    Next
   EndIf
  Next
Next
_GDIPlus_BrushDispose($hBrushTop)
_GDIPlus_BrushDispose($hBrushFront)
_GDIPlus_BrushDispose($hBrushSide)
EndFunc   ;==>_DrawFrames



Func _CreateFloor()
Local $aResult = DllCall($ghGDIPDll, "uint", "GdipCreatePath", "int", 0, "int*", 0)
Local $hPath = $aResult[2]
Local $iOver = $iWidth * $iFldX / ($iWidth * $fPersp)
Local $fOff = (1 - $fSize) / 2
Local $iCntX = $iFldX + $iOver * 2
For $z = 0 To $iFldZ - 1
  ProgressSet($z * 5 / $iFldZ)
  For $x = -$iOver To $iFldX + $iOver - 1
   DllCall($ghGDIPDll, "uint", "GdipAddPathRectangle", "hwnd", $hPath, "float", $x + $fOff, "float", $z + $fOff, "float", $fSize, "float", $fSize)
  Next
Next
Local $tPoints = DllStructCreate("float[8];")
DllStructSetData($tPoints, 1, $iWidth / 2 - $iWidth * $fPersp, 1)
DllStructSetData($tPoints, 1, $iHeight / 2 + $iHeight * $fPersp + $iHeight * $fYOff, 2)
DllStructSetData($tPoints, 1, $iWidth / 2 + $iWidth * $fPersp, 3)
DllStructSetData($tPoints, 1, $iHeight / 2 + $iHeight * $fPersp + $iHeight * $fYOff, 4)
DllStructSetData($tPoints, 1, 0, 5)
DllStructSetData($tPoints, 1, $iHeight, 6)
DllStructSetData($tPoints, 1, $iWidth, 7)
DllStructSetData($tPoints, 1, $iHeight, 8)
DllCall($ghGDIPDll, "uint", "GdipWarpPath", "hwnd", $hPath, "hwnd", 0, "ptr", DllStructGetPtr($tPoints), "int", 4, "float", 0, "float", 0, "float", $iFldX, "float", $iFldZ * 0.9, "int", 0, "float", 0)
Local $tPntFloor = DllStructCreate("float[" & $iFldZ * $iCntX * 4 * 2 & "];")
DllCall($ghGDIPDll, "uint", "GdipGetPathPoints", "hwnd", $hPath, "ptr", DllStructGetPtr($tPntFloor), "int", $iFldZ * $iCntX * 4)
DllCall($ghGDIPDll, "uint", "GdipDeletePath", "hwnd", $hPath)
Local $aReturn[$iFldZ + 1][$iCntX + 1][8]
$aReturn[1][0][0] = $iFldZ
$aReturn[0][1][0] = $iCntX
Local $iIdx
For $z = 0 To $iFldZ - 1
  ProgressSet(5 + $z * 10 / $iFldZ)
  For $x = 0 To $iCntX - 1
   $iIdx = $z * $iCntX * 8 + $x * 8 + 1
   For $j = 0 To 7
    $aReturn[$z + 1][$x + 1][$j] = DllStructGetData($tPntFloor, 1, $iIdx + $j)
   Next
  Next
Next
Return $aReturn
EndFunc   ;==>_CreateFloor



Func WM_PAINT($hWnd, $uMsgm, $wParam, $lParam)
_WinAPI_BitBlt($hDC, 0, 0, $iWidth, $iHeight, $hCDC, 0, 0, 0x00CC0020)
Return $GUI_RUNDEFMSG
EndFunc   ;==>WM_PAINT

Func _Exit()
For $i = 0 To $iFrms - 1
  _GDIPlus_BitmapDispose($aBmpFrame[$i])
  _GDIPlus_GraphicsDispose($aGfxFrame[$i])
Next
_GDIPlus_GraphicsDispose($hGfxBuffer)
_WinAPI_SelectObject($hCDC, $hOBJ)
_WinAPI_DeleteObject($hBMP)
_WinAPI_DeleteDC($hCDC)
_WinAPI_ReleaseDC($hGui, $hDC)
_GDIPlus_Shutdown()
Exit
EndFunc   ;==>_Exit