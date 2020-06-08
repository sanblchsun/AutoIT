#include "GUIGIFAnimated.au3"
Global $Gif = @ScriptDir & "\gif-Green-UFO.gif"

_GDIPlus_Startup()
;~ $hGUI = GUICreate("", 0, 0, 0, 0, $WS_POPUP, BitOR($WS_EX_LAYERED, $WS_EX_TOOLWINDOW, $WS_EX_TOPMOST))
$hGUI = GUICreate("GIF Animation", 300, 300)
$GIF_ICO = GUICtrlCreateLabel("text behind GIF", 5, 15, 100, 25)
GUISetState()
$ANI_GIF = _GuiCtrlGifAnimated_Create($Gif, 10, 10, 160, 100, BitOR($GIFopt_AUTOPLAY, $GIFopt_PROPOPRTIONAL, $GIFopt_DONTRESIZESMALLER))
;~ _GuiCtrlGifAnimated_SetImageResource($ANI_GIF,"GIF1",10,"GIFAnimated.dll")

GUISetFont(12, Default, Default, "Arial")
$btnPrev = GUICtrlCreateButton("<<", 10, 100, 30)

$btnStart = GUICtrlCreateButton(ChrW(0x25BA), 45, 100, 30)
$btnPause = GUICtrlCreateButton(ChrW(0x258C) & ChrW(0x2590), 80, 100, 30)
$btnStop = GUICtrlCreateButton(ChrW(0x2588), 110, 100, 30)

$btnNext = GUICtrlCreateButton(">>", 145, 100, 30)
$lblFrameInfo = GUICtrlCreateLabel("Frame: ", 20, 135, 100, 20)
$tmpLastFrame = -1
While 1
    $nMSG = GUIGetMsg()
    Switch $nMSG
        Case - 3
            Exit
        Case $btnStop
            _GuiCtrlGifAnimated_Stop($ANI_GIF)
        Case $btnPause
            _GuiCtrlGifAnimated_Pause($ANI_GIF)
        Case $btnStart
            _GuiCtrlGifAnimated_Play($ANI_GIF)
        Case $btnNext
            _GuiCtrlGifAnimated_Next($ANI_GIF, 1)
        Case $btnPrev
            _GuiCtrlGifAnimated_Prev($ANI_GIF, 1)
    EndSwitch
    $tmpFrame = _GuiCtrlGifAnimated_GetProperty($ANI_GIF, "frame")
    If $tmpFrame <> $tmpLastFrame Then
        GUICtrlSetData($lblFrameInfo, "Frame: " & $tmpFrame)
        $tmpLastFrame = $tmpFrame
    EndIf
WEnd

Func OnAutoItExit()
    _GuiCtrlGifAnimated_DeleteAll()
    _Timer_KillAllTimers($hGUI)
    _GDIPlus_Shutdown()
    ConsoleWrite('@@ (' & @ScriptLineNumber &') ' & @MIN & ':' & @SEC & '):: Free Resources' & @CR);### DEBUGLINE
    Exit
EndFunc   ;==>OnAutoItExit