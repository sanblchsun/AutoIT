; Rawox
; http://www.autoitscript.com/forum/topic/118269-convert-mouse-into-crosshair/#entry823018
;#NoTrayIcon
#include <_CrossHairs.au3>
#include <_MouseCursorFuncs.au3>
#include <GDIPlus.au3>
#include <ScreenCapture.au3>
#include <WinAPI.au3>
#include <GuiConstantsEx.au3>
#include <WindowsConstants.au3>

Global $bHKPressed=False, $bPropertyHKPressed=False, $iResolutionChangeMsg=0
Global $hBMP, $hGUI1, $hGUI2, $hBitmap, $hGraphic1, $hGraphic2
Dim $MagWidth = 20, $MagHeight = 20, $MagZoom = 2
Dim $aNewMousePos

_XHairInit(1,1)
_XHairSetDisplayProps(1,1,0x000000)

HotKeySet ( "{ESC}", "_exitProg" )
OnAutoItExitRegister ( "_exitProg" )
GUIRegisterMsg(0x007E,"_ResolutionChanged")

_MouseHideAllCursors()

$hGUI2 = GUICreate ("Zoomer", $MagWidth * $MagZoom + 2, $MagHeight * $MagZoom + 2, -1, -1, $WS_POPUP)
GUISetBkColor ( 0x000000 )
GUISetState()

_GDIPlus_Startup()

While 1
    $MousePos = MouseGetPos ( )
    $hBMP = _ScreenCapture_Capture("", $MousePos[0], $MousePos[1], $MousePos[0]+$MagWidth, $MousePos[1]+$MagHeight, False)
    ; Initialize GDI+ library and load image
    $hBitmap = _GDIPlus_BitmapCreateFromHBITMAP($hBMP)
    ; Draw 2x zoomed image
    $hGraphic2 = _GDIPlus_GraphicsCreateFromHWND($hGUI2)
    _GDIPlus_GraphicsDrawImageRectRect($hGraphic2, $hBitmap, 0, 0, $MagWidth, $MagHeight, 1, 1, $MagWidth * $MagZoom, $MagHeight * $MagZoom)
    WinMove ( "Zoomer", "", $MousePos[0] + 20, $MousePos[1] + 20)

    If $iResolutionChangeMsg>=4 Then
        _XHairSetDisplayProps()
        $iResolutionChangeMsg=0
    EndIf
    $aNewMousePos=MouseGetPos()
    _XHairShow($aNewMousePos[0],$aNewMousePos[1])
    Sleep(5)
WEnd

Func _ResolutionChanged($hWnd,$iMsg,$wParam,$lParam)
    $iResolutionChangeMsg+=1
    Return 'GUI_RUNDEFMSG'
EndFunc

Func _exitProg()
    GUIRegisterMsg(0x007E,"")   ;   WM_DISPLAYCHANGE 0x007E
    _XHairUnInit()
    _MouseRestoreAllCursors()
    _GDIPlus_GraphicsDispose($hGraphic2)
    _GDIPlus_ImageDispose($hBitmap)
    _WinAPI_DeleteObject($hBmp)
    _GDIPlus_Shutdown()
    Exit
EndFunc

 