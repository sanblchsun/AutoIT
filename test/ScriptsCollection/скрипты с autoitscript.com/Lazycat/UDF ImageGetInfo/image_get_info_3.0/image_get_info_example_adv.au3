;===============================================================================
;
; Simple example image info viewer
;
;===============================================================================

#include <GUIConstantsEx.au3>
#include <ListViewConstants.au3>
#include <GDIPlus.au3>

#include "image_get_info.au3"

Global Const $STM_SETIMAGE = 0x0172
Global Const $IMAGE_BITMAP = 0

Global $hImage, $sFile, $aInfo, $aData, $w, $h

$hGUI = GUICreate("Image info viewer", 623, 365, -1, -1)
$hPic = GUICtrlCreatePic("", 336, 40, 276, 276)
$hClose = GUICtrlCreateButton("Close", 536, 332, 75, 25)
$hInput = GUICtrlCreateInput("", 8, 8, 580, 21)
GUICtrlSetState(-1, $GUI_DISABLE)
$hSelect = GUICtrlCreateButton(">>", 588, 8, 27, 21)
$hList = GUICtrlCreateListView("Field|Value", 8, 40, 322, 318)
GUISetState(@SW_SHOW)

_GDIPlus_StartUp()

While 1
	$nMsg = GUIGetMsg()
	Switch $nMsg
		Case $GUI_EVENT_CLOSE, $hClose
			ExitLoop
        Case $hSelect
            $sFile = FileOpenDialog("Please select file", "", "Image files (*.jpg;*.tif;*.gif;*.bmp;*.png)")
            If @error Then ContinueLoop
            $aInfo = _ImageGetInfo($sFile)
            $aData = StringSplit($aInfo, @LF)
            GUICtrlSendMsg($hList, $LVM_DELETEALLITEMS, 0, 0)
            For $i = 1 To $aData[0]
                If $aData[$i] = "" Then ContinueLoop
                GUICtrlCreateListViewItem(StringReplace($aData[$i], "=", "|", 1), $hList)
            Next
            GUICtrlSendMsg($hList, $LVM_SETCOLUMNWIDTH, 0, -1)
            GUICtrlSetData($hInput, $sFile)

            ; use GDI+ to load and displaying preview image
            $hImage = _GDIPlus_ImageLoadFromFile($sFile)
            $w = _GDIPlus_ImageGetWidth($hImage)
            $h = _GDIPlus_ImageGetHeight($hImage)
            If $w < 276 And $h < 276 Then
                _GUICtrlSetGDIPlusImage($hPic, $hImage)
            ElseIf $w >= $h Then 
                _GUICtrlSetGDIPlusImage($hPic, _ImageResize($hImage, 276, 276 * $h / $w))
            Else
                _GUICtrlSetGDIPlusImage($hPic, _ImageResize($hImage, 276 * $w / $h, 276))
            EndIf
           
            _GDIPlus_ImageDispose($hImage)
	EndSwitch
WEnd

_GDIPlus_ShutDown()

Func _ImageResize($hImage, $newW, $newH)
    $GC = _GDIPlus_ImageGetGraphicsContext($hImage)
    $newBmp = _GDIPlus_BitmapCreateFromGraphics($newW, $newH, $GC)
    $newGC = _GDIPlus_ImageGetGraphicsContext($newBmp)
    _GDIPlus_GraphicsDrawImageRect($newGC, $hImage, 0, 0, $newW, $newH)
    _GDIPlus_GraphicsDispose($GC)
    _GDIPlus_GraphicsDispose($newGC)
    Return $newBmp
EndFunc

Func _GUICtrlSetGDIPlusImage($nCtrlID, $hImage)
    Local $hBMP = _GDIPlus_BitmapCreateHBITMAPFromBitmap($hImage)
    DllCall("gdi32.dll", "bool", "DeleteObject", "handle", GUICtrlSendMsg($nCtrlID, $STM_SETIMAGE, $IMAGE_BITMAP, $hBMP))
EndFunc
