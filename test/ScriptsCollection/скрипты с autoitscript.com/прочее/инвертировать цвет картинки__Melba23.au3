; Melba23
; http://www.autoitscript.com/forum/topic/119816-request-invert-color-udf/#entry832566
#include <GuiConstantsEx.au3>
#include <WindowsConstants.au3>
#include <GDIPlus.au3>
#include <WinAPI.au3>
#Include <Color.au3>
#Include <ScreenCapture.au3>
#Include <Misc.au3>

; Credit: Malkey for the basic GDI code

Global $iTolerance = 30, $iX1, $iY1, $iX2, $iY2, $fType = ""

; Create GUI
$hMain_GUI = GUICreate("Invert BMP", 240, 150)

$hLabel_1 = GUICtrlCreateLabel("First mark the area to invert or select a BMP", 10, 10, 260, 20)

$hRect_Button   = GUICtrlCreateButton("Mark Area",   10, 40, 80, 30)
$hChoose_Button = GUICtrlCreateButton("Choose BMP", 150, 40, 80, 30)

$hLabel_2 = GUICtrlCreateLabel("", 160, 90, 70, 20)

$hAction_Button = GUICtrlCreateButton("Invert",      150,  110, 80, 30)
GUICtrlSetState(-1, $GUI_DISABLE)
$hCancel_Button = GUICtrlCreateButton("Cancel",   10, 110, 80, 30)

GUISetState()

While 1

    Switch GUIGetMsg()
        Case $GUI_EVENT_CLOSE, $hCancel_Button
            GUIDelete($hMain_GUI)
            Exit
        Case $hRect_Button
            GUISetState(@SW_HIDE, $hMain_GUI)
            Mark_Rect()
            GUISetState(@SW_SHOW, $hMain_GUI)
            GUICtrlSetState($hAction_Button, $GUI_ENABLE)
            GUICtrlSetData($hLabel_1, "")
            GUICtrlSetData($hLabel_2, "Now Invert!")
            $fType = "Rect"
        Case $hChoose_Button
            $sBMP_Path = FileOpenDialog("Select BMP to invert", "C:\", "Bitmaps (*.bmp)", 2)
            If @error Then
                MsgBox(64, "Info", "No BMP selected")
            Else
                GUICtrlSetState($hAction_Button, $GUI_ENABLE)
                GUICtrlSetData($hLabel_1, "")
                GUICtrlSetData($hLabel_2, "Now Invert!")
                $fType = "File"
            EndIf
        Case $hAction_Button
            GUIDelete($hMain_GUI)
            ExitLoop
    EndSwitch

WEnd

; Capture selected area if needed
If $fType = "Rect" Then
    $sBMP_Path = @ScriptDir & "\TestNormal.bmp"
    GUISetState(@SW_HIDE, $hMain_GUI)
    _ScreenCapture_Capture($sBMP_Path, $iX1, $iY1, $iX2, $iY2, False)
EndIf

; Load original image
_GDIPlus_Startup()
$hImage = _GDIPlus_ImageLoadFromFile($sBMP_Path)
If @error Then
    MsgBox(16, "Error", "Could not load BMP file")
    _GDIPlus_Shutdown()
    Exit
EndIf

Global $GuiSizeX = _GDIPlus_ImageGetWidth($hImage)
Global $GuiSizeY = _GDIPlus_ImageGetHeight($hImage)

; Display original image
$hBitmap_GUI = GUICreate("Original Bitmap", $GuiSizeX, $GuiSizeY, 100, 100)
GUISetState()

; Create Double Buffer, so the doesn't need to be repainted on PAINT-Event
$hGraphicGUI = _GDIPlus_GraphicsCreateFromHWND($hBitmap_GUI)
$hBMPBuff = _GDIPlus_BitmapCreateFromGraphics($GuiSizeX, $GuiSizeY, $hGraphicGUI)
$hGraphic = _GDIPlus_ImageGetGraphicsContext($hBMPBuff)

_GDIPlus_GraphicsDrawImageRect($hGraphic, $hImage, 0, 0, $GuiSizeX, $GuiSizeY)

GUIRegisterMsg(0xF, "MY_PAINT")
GUIRegisterMsg(0x85, "MY_PAINT")
_GDIPlus_GraphicsDrawImage($hGraphicGUI, $hBMPBuff, 0, 0)

; Invert the image
Local $hBitmap = Image_Invert($hBMPBuff, 0, 0, $GuiSizeX, $GuiSizeY)
If _GDIPlus_ImageSaveToFile($hBitmap, @ScriptDir & "\TestInverted.bmp") =  False Then MsgBox(16 , "Error", "Inverted image not created")

WinActivate($hBitmap_GUI)

; Display inverted image
$hInverted_GUI = GUICreate("Inverted Image", $GuiSizeX, $GuiSizeY, 500, 200)
$hPic = GUICtrlCreatePic(@ScriptDir & "\TestInverted.bmp", 0, 0, $GuiSizeX, $GuiSizeY)
GUISetState()

While 1
    If GUIGetMsg() = $GUI_EVENT_CLOSE Then
        _GDIPlus_GraphicsDispose($hGraphic)
        _GDIPlus_Shutdown()
        Exit
    EndIf
WEnd

; -------------

;Func to redraw on PAINT MSG
Func MY_PAINT($hWnd, $msg, $wParam, $lParam)

    ; Check, if the GUI with the Graphic should be repainted
    ; The sequencial order of these two commands is important.
    _GDIPlus_GraphicsDrawImage($hGraphicGUI, $hBMPBuff, 0, 0)
    _WinAPI_RedrawWindow($hBitmap_GUI, "", "", BitOR($RDW_INVALIDATE, $RDW_UPDATENOW, $RDW_FRAME)) ; , $RDW_ALLCHILDREN
    Return $GUI_RUNDEFMSG

EndFunc   ;==>MY_PAINT

; -------------

Func Image_Invert($hImage2, $iStartPosX = 0, $iStartPosY = 0, $GuiSizeX = Default, $GuiSizeY = Default)

    Local $hBitmap1, $Reslt, $width, $height, $stride, $format, $Scan0, $v_Buffer, $v_Value, $iIW, $iIH
    $iIW = _GDIPlus_ImageGetWidth($hImage2)
    $iIH = _GDIPlus_ImageGetHeight($hImage2)
    If $GuiSizeX = Default Or $GuiSizeX > $iIW - $iStartPosX Then $GuiSizeX = $iIW - $iStartPosX
    If $GuiSizeY = Default Or $GuiSizeY > $iIH - $iStartPosY Then $GuiSizeY = $iIH - $iStartPosY
    $hBitmap1 = _GDIPlus_BitmapCloneArea($hImage2, $iStartPosX, $iStartPosY, $GuiSizeX, $GuiSizeY, $GDIP_PXF32ARGB)

    ProgressOn("Inverting Image", "The image is being processed.", "0 percent", -1, -1, 16)

    $Reslt = _GDIPlus_BitmapLockBits($hBitmap1, 0, 0, $GuiSizeX, $GuiSizeY, BitOR($GDIP_ILMREAD, $GDIP_ILMWRITE), $GDIP_PXF32ARGB)

    ;Get the returned values of _GDIPlus_BitmapLockBits ()
    $width = DllStructGetData($Reslt, "width")
    $height = DllStructGetData($Reslt, "height")
    $stride = DllStructGetData($Reslt, "stride")
    $format = DllStructGetData($Reslt, "format")
    $Scan0 = DllStructGetData($Reslt, "Scan0")
    For $i = 0 To $GuiSizeX - 1
        For $j = 0 To $GuiSizeY - 1
            $v_Buffer = DllStructCreate("dword", $Scan0 + ($j * $stride) + ($i * 4))
            ; Get colour value of pixel
            $v_Value = DllStructGetData($v_Buffer, 1)
            ; Invert
            If (Abs(_ColorGetBlue ($v_Value) - 0x80) <= $iTolerance And _  ; Blue
                Abs(_ColorGetGreen($v_Value) - 0x80) <= $iTolerance And _  ; Green
                Abs(_ColorGetRed  ($v_Value) - 0x80) <= $iTolerance) Then  ; Red
                DllStructSetData($v_Buffer, 1, BitAND((0x7F7F7F + $v_Value) , 0xFFFFFF))
            Else
                DllStructSetData($v_Buffer, 1, BitXOR($v_Value ,0xFFFFFF))
            EndIf
        Next
        Local $iProgress = Int(100 * $i / ($GuiSizeX))
        ProgressSet(1 + $iProgress, $iProgress & " percent")
        ProgressSet($iProgress, $iProgress & " percent")
    Next
    _GDIPlus_BitmapUnlockBits($hBitmap1, $Reslt)

    ProgressOff()
    Return $hBitmap1

EndFunc   ;==>Image_Invert

; -------------

Func Mark_Rect()

    Local $aMouse_Pos, $hMask, $hMaster_Mask, $iTemp
    Local $UserDLL = DllOpen("user32.dll")

    ; Create transparent GUI with Cross cursor
    $hCross_GUI = GUICreate("Test", @DesktopWidth, @DesktopHeight - 20, 0, 0, $WS_POPUP, $WS_EX_TOPMOST)
    WinSetTrans($hCross_GUI, "", 8)
    GUISetState(@SW_SHOW, $hCross_GUI)
    GUISetCursor(3, 1, $hCross_GUI)

    Global $hRectangle_GUI = GUICreate("", @DesktopWidth, @DesktopHeight, 0, 0, $WS_POPUP, $WS_EX_TOOLWINDOW + $WS_EX_TOPMOST)
    GUISetBkColor(0x000000)

    ; Wait until mouse button pressed
    While Not _IsPressed("01", $UserDLL)
        Sleep(10)
    WEnd

    ; Get first mouse position
    $aMouse_Pos = MouseGetPos()
    $iX1 = $aMouse_Pos[0]
    $iY1 = $aMouse_Pos[1]

    ; Draw rectangle while mouse button pressed
    While _IsPressed("01", $UserDLL)

        $aMouse_Pos = MouseGetPos()

        $hMaster_Mask = _WinAPI_CreateRectRgn(0, 0, 0, 0)
        $hMask = _WinAPI_CreateRectRgn($iX1,  $aMouse_Pos[1], $aMouse_Pos[0],  $aMouse_Pos[1] + 1) ; Bottom of rectangle
        _WinAPI_CombineRgn($hMaster_Mask, $hMask, $hMaster_Mask, 2)
        _WinAPI_DeleteObject($hMask)
        $hMask = _WinAPI_CreateRectRgn($iX1, $iY1, $iX1 + 1, $aMouse_Pos[1]) ; Left of rectangle
        _WinAPI_CombineRgn($hMaster_Mask, $hMask, $hMaster_Mask, 2)
        _WinAPI_DeleteObject($hMask)
        $hMask = _WinAPI_CreateRectRgn($iX1 + 1, $iY1 + 1, $aMouse_Pos[0], $iY1) ; Top of rectangle
        _WinAPI_CombineRgn($hMaster_Mask, $hMask, $hMaster_Mask, 2)
        _WinAPI_DeleteObject($hMask)
        $hMask = _WinAPI_CreateRectRgn($aMouse_Pos[0], $iY1, $aMouse_Pos[0] + 1,  $aMouse_Pos[1]) ; Right of rectangle
        _WinAPI_CombineRgn($hMaster_Mask, $hMask, $hMaster_Mask, 2)
        _WinAPI_DeleteObject($hMask)
        ; Set overall region
        _WinAPI_SetWindowRgn($hRectangle_GUI, $hMaster_Mask)

        If WinGetState($hRectangle_GUI) < 15 Then GUISetState()
        Sleep(10)

    WEnd

    ; Get second mouse position
    $iX2 = $aMouse_Pos[0]
    $iY2 = $aMouse_Pos[1]

    ; Set in correct order if required
    If $iX2 < $iX1 Then
        $iTemp = $iX1
        $iX1 = $iX2
        $iX2 = $iTemp
    EndIf
    If $iY2 < $iY1 Then
        $iTemp = $iY1
        $iY1 = $iY2
        $iY2 = $iTemp
    EndIf

    GUIDelete($hRectangle_GUI)
    GUIDelete($hCross_GUI)
    DllClose($UserDLL)

EndFunc   ;==>Mark_Rect
 