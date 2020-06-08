#cs ----------------------------------------------------------------------------

    AutoIt Version: 3.3.6.1
    Author:         KaFu

    Script Function:
    Drag GUI

#ce ----------------------------------------------------------------------------

#include <GUIConstantsEx.au3>
#include <WindowsConstants.au3>
#include <Winapi.au3>
#include <Misc.au3>

Opt("GUIOnEventMode", 1)

HotKeySet("{ESC}", "_Exit")

While 1
    Sleep(10)
    If _IsPressed("01") Then
        While _IsPressed("01")
            Sleep(10)
        WEnd
        _CreateDragGui()
    EndIf
WEnd


Func _CreateDragGui()
    $aPosMouseInitial = MouseGetPos()
    $gui_Drag = GUICreate("GuiDrag", 100, 100, $aPosMouseInitial[0], $aPosMouseInitial[1], $WS_POPUP, BitOR($WS_EX_TOOLWINDOW, $WS_EX_LAYERED,$WS_EX_TOPMOST))

    MouseMove($aPosMouseInitial[0]+100, $aPosMouseInitial[1]+100,0)

    GUICtrlCreateLabel("", 0, 0, 100, 1)
    GUICtrlSetBkColor(-1, 0xff0000)
    GUICtrlSetResizing(-1, $GUI_DOCKLEFT + $GUI_DOCKTOP + $GUI_DOCKHEIGHT)

    GUICtrlCreateLabel("", 0, 0, 1, 100)
    GUICtrlSetBkColor(-1, 0xff0000)
    GUICtrlSetResizing(-1, $GUI_DOCKLEFT + $GUI_DOCKTOP + $GUI_DOCKWIDTH)

    GUICtrlCreateLabel("", 0,99,100,1)
    GUICtrlSetBkColor(-1, 0xff0000)
    GUICtrlSetResizing(-1, $GUI_DOCKLEFT + $GUI_DOCKBOTTOM + $GUI_DOCKHEIGHT)

    GUICtrlCreateLabel("", 99,0,1,100)
    GUICtrlSetBkColor(-1, 0xff0000)
    GUICtrlSetResizing(-1, $GUI_DOCKRIGHT + $GUI_DOCKTOP + $GUI_DOCKWIDTH)

    GUISetBkColor(0xABCDEF)
    GUISetState(@SW_SHOW)
    _WinAPI_SetLayeredWindowAttributes($gui_Drag, 0xABCDEF, 255)

    While 1
        Sleep(10)
        $aPosMouse = MouseGetPos()
        Select
            Case ($aPosMouse[0] >= $aPosMouseInitial[0]) AND ($aPosMouse[1] >= $aPosMouseInitial[1])
                WinMove($gui_Drag, "", $aPosMouseInitial[0], $aPosMouseInitial[1], $aPosMouse[0] - $aPosMouseInitial[0], $aPosMouse[1] - $aPosMouseInitial[1])
            Case ($aPosMouse[0] < $aPosMouseInitial[0]) AND ($aPosMouse[1] >= $aPosMouseInitial[1])
                WinMove($gui_Drag, "", $aPosMouse[0], $aPosMouseInitial[1], $aPosMouseInitial[0] - $aPosMouse[0], $aPosMouse[1] - $aPosMouseInitial[1])
            Case ($aPosMouse[0] >= $aPosMouseInitial[0]) AND ($aPosMouse[1] < $aPosMouseInitial[1])
                WinMove($gui_Drag, "", $aPosMouseInitial[0], $aPosMouse[1], $aPosMouse[0] - $aPosMouseInitial[0], $aPosMouseInitial[1] - $aPosMouse[1])
            Case ($aPosMouse[0] < $aPosMouseInitial[0]) AND ($aPosMouse[1] < $aPosMouseInitial[1])
                WinMove($gui_Drag, "", $aPosMouse[0], $aPosMouse[1], $aPosMouseInitial[0] - $aPosMouse[0], $aPosMouseInitial[1] - $aPosMouse[1])
        EndSelect

        If _IsPressed("01") Then
            $aPosWin = WinGetPos($gui_Drag)
            MsgBox(0, "", $aPosWin[0] & "x" & $aPosWin[1] & @CRLF & $aPosWin[2] & "x" & $aPosWin[3])
            ExitLoop
        EndIf
    WEnd
    GUIDelete()
EndFunc   ;==>_CreateDragGui


Func _Exit()
    Exit
EndFunc   ;==>_Exit