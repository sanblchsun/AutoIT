#include <WindowsConstants.au3>
#include "GIFAnimation.au3"

Opt("MustDeclareVars", 1)


Global $hGui = GUICreate("GIF Animation", 500, 500, -1, -1, $WS_OVERLAPPEDWINDOW)

Global $sFile = FileOpenDialog("Choose gif", "", "(*.gif)", -1, "", $hGui)
If @error Then Exit

Global $aGIFArrayOfIconHandles
Global $hGIFThread
Global $iGIFTransparent
Global $tFrameCurrent

Global $hGIF = _GUICtrlCreateGIF($sFile, 10, 10, $aGIFArrayOfIconHandles, $hGIFThread, $iGIFTransparent, $tFrameCurrent)
GUICtrlSetTip($hGIF, "GIF")


Global $hButton = GUICtrlCreateButton("Stop animation", 50, 450, 100, 25)
Global $hButton1 = GUICtrlCreateButton("Delete GIF", 200, 450, 100, 25)
Global $hButton2 = GUICtrlCreateButton("Open GIF", 350, 450, 100, 25)


GUIRegisterMsg(15, "_Refresh"); WM_PAINT; don't forget this. It's needed only for non-transparent gifs though, but still.

Global $iPlay = 1

GUISetState()



While 1

    Switch GUIGetMsg()
        Case - 3
            Exit
        Case $hButton
            If $iPlay Then
                If _StopGIFAnimation($hGIFThread) Then
                    $iPlay = 0
                    GUICtrlSetData($hButton, "Resume animation")
                EndIf
            Else
                If _ResumeGIFAnimation($hGIFThread) Then
                    $iPlay = 1
                    GUICtrlSetData($hButton, "Stop animation")
                EndIf
            EndIf
        Case $hButton1
            _GUICtrlDeleteGIF($hGIF, $aGIFArrayOfIconHandles, $hGIFThread, $tFrameCurrent)
        Case $hButton2
            $sFile = FileOpenDialog("Choose gif", "", "(*.gif)", -1, "", $hGui)
            If Not @error Then
                _GUICtrlDeleteGIF($hGIF, $aGIFArrayOfIconHandles, $hGIFThread, $tFrameCurrent); if already there
                $hGIF = _GUICtrlCreateGIF($sFile, 10, 10, $aGIFArrayOfIconHandles, $hGIFThread, $iGIFTransparent, $tFrameCurrent)
                GUICtrlSetTip($hGIF, "GIF")
                $iPlay = 1
                GUICtrlSetData($hButton, "Stop animation")
            EndIf
    EndSwitch

WEnd




Func _Refresh($hWnd, $iMsg, $wParam, $lParam)

    #forceref $hWnd, $iMsg, $wParam, $lParam

    _RefreshGIF($hGIF, $aGIFArrayOfIconHandles, $hGIFThread, $iGIFTransparent, $tFrameCurrent)

EndFunc;==>_Refresh
