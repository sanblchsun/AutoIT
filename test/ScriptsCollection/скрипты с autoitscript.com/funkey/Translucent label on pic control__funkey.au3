#region ;**** Directives created by AutoIt3Wrapper_GUI ****
#AutoIt3Wrapper_Res_LegalCopyright=funkey
#AutoIt3Wrapper_UseX64=n
#endregion ;**** Directives created by AutoIt3Wrapper_GUI ****
#include <GDIPlus.au3>
#include <Array.au3>
Global $sFile1 = StringReplace(@AutoItExe, "AutoIt3.exe", "") & '\Examples\GUI\msoobe.jpg'
Global $sFile2 = StringReplace(@AutoItExe, "AutoIt3.exe", "") & '\Examples\GUI\mslogo.jpg'
Global $hGui = GUICreate("Test", 500, 500)
Global $nTab = GUICtrlCreateTab(10, 10, 480, 480)
GUICtrlCreateTabItem("Tab1")
Global $nPic1 = GUICtrlCreatePic($sFile1, 20, 50, 460, 420, 0)
Global $nLbl = GUICtrlCreateLabel("Text-Label", 100, 100, 100, 30)
GUICtrlSetCursor(-1, 0)
_LabelMakeTranslucent(-1, $nPic1, 0x50000000, 0xFFFFFFFF)
GUICtrlCreateLabel("Text-Label", 100, 135, 100, 30, 0x201)
GUICtrlSetCursor(-1, 0)
_LabelMakeTranslucent(-1, $nPic1, 0x50000000, 0xFFFFFFFF)
GUICtrlCreateLabel("Text-Label", 100, 170, 100, 30, 0x202)
GUICtrlSetCursor(-1, 0)
_LabelMakeTranslucent(-1, $nPic1, 0x50000000, 0xFFFFFFFF)
GUICtrlCreateLabel("This is a translucent label", 100, 335, 200, 31, 0x201)
_LabelMakeTranslucent(-1, $nPic1)
GUICtrlCreateLabel("This is a transparent label", 300, 335, 200, 31, 0x201)
GUICtrlCreateTabItem("Tab2")
Global $nPic2 = GUICtrlCreatePic($sFile2, 20, 50, 460, 420, 0)
GUICtrlCreateLabel("Translucent label", 30, 200, 100, 30, 0x201)
_LabelMakeTranslucent(-1, $nPic2, 0x50FF00FF)
GUICtrlCreateLabel("Transparent label", 30, 250, 100, 30, 0x201)
GUICtrlCreateTabItem("")
GUISetState()
Sleep(1000)
_LabelMakeTranslucent($nLbl, $nPic1, 0x305555f5, 0xFFf0f000, 1, "New Text")
Do
Until GUIGetMsg() = -3
Func _LabelMakeTranslucent($nLbl, $nPic, $TransColor = 0x30FFFFFF, $FontColor = 0xFF000000, $StartGdip = 1, $sText = "", $iSize = 8, $sFontName = "Arial", $iStyle = 0)
 Local $hLbl = GUICtrlGetHandle($nLbl)
 Local $hPic = GUICtrlGetHandle($nPic)
 Local $hImage = _SendMessage($hPic, 371)
 Local $hParent = _WinAPI_GetParent($hLbl)
 Local $Style = _WinAPI_GetWindowLong($hLbl, -16)
 Local $iSS_CENTER = BitAND($Style, 0x1)
 Local $iSS_RIGHT = BitAND($Style, 0x2)
 Local $iSS_CENTERIMAGE = BitAND($Style, 0x200)
 Local $IsPic = BitAND($Style, 0xE)
 ConsoleWrite($IsPic & @CR)
 If $sText = "" Then $sText = GUICtrlRead($nLbl)
 If $IsPic = 0xE Then
  $iSS_CENTER = BitAND(GUICtrlRead($nLbl), 0x1)
  $iSS_RIGHT = BitAND(GUICtrlRead($nLbl), 0x2)
  $iSS_CENTERIMAGE = BitAND(GUICtrlRead($nLbl), 0x200)
 Else
  GUICtrlSetData($nLbl, $Style) ;remember the old style in text
  If $iSS_CENTER Then $Style = BitXOR($Style, 0x1) ;delete SS_CENTER
  _WinAPI_SetWindowLong($hLbl, -16, BitOR($Style, 0x200, 0xE))
 EndIf
 Local $aLblPos = ControlGetPos($hParent, "", $hLbl)
 Local $aPicPos = ControlGetPos($hParent, "", $nPic)
 If $StartGdip Then _GDIPlus_Startup()
 Local $hBitmap = _GDIPlus_BitmapCreateFromHBITMAP($hImage)
 Local $hBitmap2 = _GDIPlus_BitmapCloneArea($hBitmap, $aLblPos[0] - $aPicPos[0], $aLblPos[1] - $aPicPos[1], $aLblPos[2], $aLblPos[3])
 Local $hGraphics = _GDIPlus_ImageGetGraphicsContext($hBitmap2)
 Local $hBrushArea = _GDIPlus_BrushCreateSolid($TransColor)
 _GDIPlus_GraphicsFillRect($hGraphics, 0, 0, $aLblPos[2], $aLblPos[3], $hBrushArea)
 Local $hBrushText = _GDIPlus_BrushCreateSolid($FontColor)
 Local $hFormat = _GDIPlus_StringFormatCreate()
 Local $hFontFamily = _GDIPlus_FontFamilyCreate($sFontName)
 Local $hFont = _GDIPlus_FontCreate($hFontFamily, $iSize, $iStyle)
 Local $tLayout = _GDIPlus_RectFCreate()
 If $iSS_CENTERIMAGE Then DllStructSetData($tLayout, 2, $aLblPos[3] / 2 - $iSize + 1) ;vertictal center
 Local $aInfo = _GDIPlus_GraphicsMeasureString($hGraphics, $sText, $hFont, $tLayout, $hFormat)
 If $iSS_CENTER Then DllStructSetData($aInfo[0], 1, ($aLblPos[2] - DllStructGetData($aInfo[0], 3)) / 2) ;horizontal center
 If $iSS_RIGHT Then DllStructSetData($aInfo[0], 1, $aLblPos[2] - DllStructGetData($aInfo[0], 3) - 1) ; right
 _GDIPlus_GraphicsDrawStringEx($hGraphics, $sText, $hFont, $aInfo[0], $hFormat, $hBrushText)
 Local $hImageNew = _GDIPlus_BitmapCreateHBITMAPFromBitmap($hBitmap2)
 _WinAPI_DeleteObject(GUICtrlSendMsg($nLbl, 370, 0, $hImageNew))
 _WinAPI_DeleteObject($hImageNew)
 _GDIPlus_ImageDispose($hBitmap)
 _GDIPlus_ImageDispose($hBitmap2)
 _GDIPlus_BrushDispose($hBrushArea)
 _GDIPlus_BrushDispose($hBrushText)
 _GDIPlus_FontDispose($hFont)
 _GDIPlus_FontFamilyDispose($hFontFamily)
 _GDIPlus_StringFormatDispose($hFormat)
 _GDIPlus_GraphicsDispose($hGraphics)
 If $StartGdip Then _GDIPlus_Shutdown()
EndFunc   ;==>_LabelMakeTranslucent