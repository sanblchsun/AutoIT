#include <GDIPlus.au3>
; http://www.autoitscript.com/forum/index.php?showtopic=120313&view=findpost&p=836303
; Incorporating AndyG opcode from
; http://www.autoitscript.com/forum/index.php?showtopic=120313&view=findpost&p=836173
; And smashly code from
; http://www.autoitscript.com/forum/index.php?showtopic=102626&view=findpost&p=728034

Local $sImageIn = FileOpenDialog("First image", "", "All images (*.jpg;*.png;*.gif;*.bmp;)")
If $sImageIn = "" Then Exit

ShellExecute($sImageIn)

Local $begin = TimerInit()
If _IsImageGrayScale($sImageIn) Then
    MsgBox(0, "Greyscale", 'Image "' & $sImageIn & '" is all greyscale.' & @CRLF & _
    "Time: " & Round(TimerDiff($begin) / 1000, 3) & " secs")
Else
    MsgBox(0, "NOT Greyscale", 'Image "' & $sImageIn & '" is NOT all greyscale.' & @CRLF & _
    "Time: " & Round(TimerDiff($begin) / 1000, 3) & " secs")
EndIf

Opt("WinTitleMatchMode", 2) ;1=start, 2=subStr, 3=exact, 4=advanced, -1 to -4=Nocase
WinClose(StringRegExpReplace($sImageIn, "^.*\\|\..*$", ""))


;Parameters:-
; $sInFile - Full path and name of image file.
; Returns true if image is greyscale. Otherwise, returns false.
Func _IsImageGrayScale($sInFile)
    Local $hImage, $iW, $iH, $tBitmapData, $iStride, $iScan0, $sRet
    Local $hBmp, $hBitmap, $hGraphic, $tCodeBuffer, $bytecode, $tPixelData
    _GDIPlus_Startup()
    $hImage = _GDIPlus_ImageLoadFromFile($sInFile)
    $iW = _GDIPlus_ImageGetWidth($hImage)
    $iH = _GDIPlus_ImageGetHeight($hImage)

    ;=> Start Work around For XP, GDIPBitmapLockBits() seem to hard crash autoit When using images that are less then 24bpp
    ; If your using Vista or Newer OS then this won't be called or needed.
    ; http://www.autoitscript.com/forum/index.php?showtopic=102626&view=findpost&p=728034
    If StringInStr("WIN_2003,WIN_XP,WIN_2000", @OSVersion) Then
    Local $aRet, $hBmp, $hBitmap, $hGraphic
    $aRet = _GDIPlus_ImageGetPixelFormat($hImage)
    If Int(StringRegExpReplace($aRet[1], "\D+", "")) < 24 Then
    $hBmp = _WinAPI_CreateBitmap($iW, $iH, 1, 32)
    $hBitmap = _GDIPlus_BitmapCreateFromHBITMAP($hBmp)
    _WinAPI_DeleteObject($hBmp)
    $hGraphic = _GDIPlus_ImageGetGraphicsContext($hBitmap)
    _GDIPlus_GraphicsDrawImage($hGraphic, $hImage, 0, 0)
    _GDIPlus_ImageDispose($hImage)
    _GDIPlus_GraphicsDispose($hGraphic)
    $hImage = _GDIPlus_BitmapCloneArea($hBitmap, 0, 0, $iW, $iH, $GDIP_PXF32ARGB)
    _GDIPlus_BitmapDispose($hBitmap)
    EndIf
    EndIf
    ;=> End Work around

    $tBitmapData = _GDIPlus_BitmapLockBits($hImage, 0, 0, $iW, $iH, $GDIP_ILMWRITE, $GDIP_PXF32ARGB)
    $iStride = DllStructGetData($tBitmapData, "stride")
    $iScan0 = DllStructGetData($tBitmapData, "Scan0")
    $tPixelData = DllStructCreate("dword[" & (Abs($iStride * $iH)) & "]", $iScan0)
    $bytecode = "0x8B7424048B4C24088B0638E0750EC1E80838E0750783C604E2EE31C0C3"
    $tCodeBuffer = DllStructCreate("byte[" & StringLen($bytecode) / 2 - 1 & "]") ;alloc some memory
    DllStructSetData($tCodeBuffer, 1, $bytecode) ;write bytecode into struct
    $sRet = DllCall("user32.dll", "ptr", "CallWindowProcW", "ptr", DllStructGetPtr($tCodeBuffer), "ptr", DllStructGetPtr($tPixelData), "int", $iW * $iH, "int", 0, "int", 0);returns eax in ret[0]

    _GDIPlus_BitmapUnlockBits($hImage, $tBitmapData)
    _GDIPlus_ImageDispose($hImage)
    _GDIPlus_Shutdown()
    Return ($sRet[0] = 0)
EndFunc ;==>_IsImageGrayScale
 