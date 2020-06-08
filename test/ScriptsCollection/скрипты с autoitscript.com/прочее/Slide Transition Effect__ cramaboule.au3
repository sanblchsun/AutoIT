

; http://www.autoitscript.com/forum/topic/123718-slide-transition-effect/
#Region ;**** Directives created by AutoIt3Wrapper_GUI ****
#AutoIt3Wrapper_AU3Check_Parameters=-w 5 -w 3 -w 4
#EndRegion ;**** Directives created by AutoIt3Wrapper_GUI ****

#include <Array.au3>
#include <File.au3>
#include <GDIPlus.au3>
#include <GUIConstantsEx.au3>
#include <WindowsConstants.au3>

HotKeySet("{Esc}", "_Exit")

Global $c=0, $i, $k, $l, $chk, $fn
Global $hGDI[3], $hGraphic[2], $hImage, $hBrush1, $hBrush2, $hFamily, $hFont, $hFormat, $tLayout, $aInfo, $sString
Global Const $fsize = 8, $fh = 15
Global Const $width = 800, $height = 600
Global Const $bg_color = "000000"
Global $imagedir =  FileSelectFolder("Select folder with images", "", 4, @ScriptDir)

If $imagedir = "" Then Exit MsgBox(16, "Error", "No folder selected!", 5)


Global $aFiles = _FileListToArray($imagedir, "*.*", 1)
If Not UBound($aFiles) Then Exit MsgBox(16, "Error", "No files found!", 5)


$l = 1
Do
    $chk = StringRegExp($aFiles[$l], "(.*\.jpg|.*\.png|.*\.bmp|.*\.gif|.*\.JPG|.*\.PNG|.*\.BMP|.*\.GIF)", 3)
    If @error Then
        _ArrayDelete($aFiles, $l)
        $l -= 1
    EndIf
    $l += 1
Until $l = UBound($aFiles)


If UBound($aFiles) = 1 Then Exit MsgBox(16, "Error", "No images found!", 5)


Fader_Init($width, $height)


For $k = 1 To UBound($aFiles) - 1
    _Transition($imagedir & "\" & $aFiles[$k])
Next

Sleep(3000)
_Exit()


Func _Transition($image, $delay = 0, $speed = 15, $sleep = 2000)
    Local $a, $d = $c, $iX, $iY
    $hImage = _GDIPlus_ImageLoadFromFile($image)
    $iX = _GDIPlus_ImageGetWidth($hImage)
    $iY = _GDIPlus_ImageGetHeight($hImage)

    $FDesktop=$height/$width
    $Fact =1
    If $iX > $width And $FDesktop > ($iY/$iX) Then
        $Fact=$width/$iX
    ElseIf $iY > $height Then
        $Fact=$height/$iY
    EndIf
    $H1 = Round(($Fact * $iY),0)
    $W1 = Round(($Fact * $iX),0)
    ;$H0 = Round(($height-$H1)/2,0)
    ;$W0 = Round(($width-$W1)/2,0)

    _GDIPlus_GraphicsDrawImageRect($hGraphic[$d], $hImage,($width - $W1)/2, ($height - $H1) / 2,$W1,$H1)
    $hBrushFont2 = _GDIPlus_BrushCreateSolid(0xFFFFFFFF) ; text color
    $hFormat = _GDIPlus_StringFormatCreate()
    $hLayout = _GDIPlus_RectFCreate(($width - $W1)/2, ($height - $H1) / 2,$W1,$H1)
    $hFamily = _GDIPlus_FontFamilyCreate("Arial")
    $hFont = _GDIPlus_FontCreate($hFamily, 25, 0, 3)

    _GDIPlus_GraphicsDrawStringEx($hGraphic[$d], $sString, $hFont, $hLayout, $hFormat, $hBrushFont2)

    WinSetTrans($hGDI[$d], "", 0)
    WinSetOnTop($hGDI[$d], "", 1)
    For $a = 0 To 254 Step $speed
        WinSetTrans($hGDI[$d], "", $a)
        Sleep($delay)
    Next
    WinSetTrans($hGDI[$d], "", 254)
    WinSetOnTop($hGDI[Not ($d)], "", 0)
    WinSetTrans($hGDI[Not ($d)], "", 0)
    _GDIPlus_GraphicsClear($hGraphic[Not ($d)])
    $c = 1 - $d

    _GDIPlus_ImageDispose ($hImage) ; very important to realease the pics
    Sleep($sleep)
EndFunc   ;==>_Transition


Func Fader_Init($width, $height)
    $hGDI[2] = GUICreate("", $width, $height, (@DesktopWidth - $width)/2, (@DesktopHeight - $height)/2 , $WS_POPUP)
    $hGDI[0] = GUICreate("", $width, $height, 3, 3, $WS_POPUP, $WS_EX_MDICHILD, $hGDI[2])
    $hGDI[1] = GUICreate("", $width, $height, 3, 3, $WS_POPUP, $WS_EX_MDICHILD, $hGDI[2])
    GUISetBkColor("0x" & $bg_color, $hGDI[2])
    GUISetState(@SW_SHOW, $hGDI[2])
    GUISetState(@SW_SHOW, $hGDI[0])
    GUISetState(@SW_SHOW, $hGDI[1])
    WinSetTrans($hGDI[0], "", 0)
    WinSetTrans($hGDI[1], "", 0)
    _GDIPlus_Startup()
    $hGraphic[0] = _GDIPlus_GraphicsCreateFromHWND($hGDI[0])
    $hGraphic[1] = _GDIPlus_GraphicsCreateFromHWND($hGDI[1])
    _GDIPlus_GraphicsClear($hGraphic[0], "0xFF" & $bg_color)
    _GDIPlus_GraphicsClear($hGraphic[1], "0xFF" & $bg_color)
    $hBrush1 = _GDIPlus_BrushCreateSolid(0xFFF0F080)
    $hFormat = _GDIPlus_StringFormatCreate()
    $hFamily = _GDIPlus_FontFamilyCreate("Arial")
    $hFont = _GDIPlus_FontCreate($hFamily, $fsize)
    $tLayout = _GDIPlus_RectFCreate(0, $height - $fh, 0, 0)
EndFunc   ;==>Fader_Init


Func _Exit()
    _GDIPlus_FontDispose($hFont)
    _GDIPlus_FontFamilyDispose($hFamily)
    _GDIPlus_StringFormatDispose($hFormat)
    _GDIPlus_BrushDispose($hBrush1)
    _GDIPlus_BrushDispose($hBrush2)
    _GDIPlus_ImageDispose($hImage)
    _GDIPlus_GraphicsDispose($hGraphic[0])
    _GDIPlus_GraphicsDispose($hGraphic[1])
    GUIDelete($hGDI[0])
    GUIDelete($hGDI[1])
    GUIDelete($hGDI[2])
    _GDIPlus_Shutdown()
    Exit
EndFunc   ;==>_Exit