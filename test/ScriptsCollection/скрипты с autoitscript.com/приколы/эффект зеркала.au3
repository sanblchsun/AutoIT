#include <GuiConstantsEx.au3>
#include <GDIPlus.au3>
#include <ScreenCapture.au3>
#include <WinAPI.au3>

Opt('MustDeclareVars', 1)

_Main()

Func _Main()
    Local $hGUI, $hBMP, $hBitmap, $hGraphic


    ; Create GUI
    $hGUI = GUICreate("GDI+", 600, 300)
    GUISetState()

    Do
            ; Capture upper left corner of screen
    $hBMP = _ScreenCapture_Capture ("", 0, 0, 400, 300)
    ; Initialize GDI+ library
    _GDIPlus_Startup ()

    ; Draw bitmap to GUI
    $hBitmap = _GDIPlus_BitmapCreateFromHBITMAP ($hBMP)
    $hGraphic = _GDIPlus_GraphicsCreateFromHWND ($hGUI)
    _GDIPlus_GraphicsDrawImage ($hGraphic, $hBitmap, 0, 0)

    ; Clean up resources
    _GDIPlus_GraphicsDispose ($hGraphic)
    _GDIPlus_ImageDispose ($hBitmap)
    _WinAPI_DeleteObject ($hBMP)

    ; Shut down GDI+ library
    _GDIPlus_ShutDown ()

    ; Loop until user exits
    Until GUIGetMsg() = $GUI_EVENT_CLOSE


EndFunc   ;==>_Main