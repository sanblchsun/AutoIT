#include <GUIConstantsEx.au3>
#Include <Constants.au3>
#include <EditConstants.au3>
#include <WindowsConstants.au3>
#include <SendMessage.au3>
#Include <Clipboard.au3>
#Include <GUIEdit.au3>
;

$hGUI = GUICreate('Clipboard', 480, 600, -1, -1, BitOR($WS_MAXIMIZEBOX, $WS_MINIMIZEBOX, $WS_SIZEBOX))
GUISetIcon('Main.ico')

$ClipBoardContent_Edit = GUICtrlCreateEdit('', 5, 5, 468, 550, BitOR($GUI_SS_DEFAULT_EDIT, $ES_MULTILINE))
GUICtrlSetData(-1, ClipGet() & @CRLF)

GUISetState()

$hNext_Clipboard = _ClipBoard_SetViewer($hGUI)

GUIRegisterMsg($WM_CHANGECBCHAIN, "WM_CHANGECBCHAIN")
GUIRegisterMsg($WM_DRAWCLIPBOARD, "WM_DRAWCLIPBOARD")

While 1
    Switch GUIGetMsg()
        Case $GUI_EVENT_CLOSE
            _ClipBoard_ChangeChain($hGUI, $hNext_Clipboard)

            Exit
    EndSwitch
WEnd

Func WM_CHANGECBCHAIN($hWnd, $iMsg, $iwParam, $ilParam)
    ; If the next window is closing, repair the chain
    If $iwParam = $hNext_Clipboard Then
        $hNext_Clipboard = $ilParam
        ; Otherwise pass the message to the next viewer
    ElseIf $hNext_Clipboard <> 0 Then
        _SendMessage($hNext_Clipboard, $WM_CHANGECBCHAIN, $iwParam, $ilParam, 0, "hwnd", "hwnd")
    EndIf
EndFunc

Func WM_DRAWCLIPBOARD($hWnd, $iMsg, $iwParam, $ilParam)
    _GUICtrlEdit_AppendText($ClipBoardContent_Edit, ClipGet() & @CRLF)

    ; Pass the message to the next viewer
    If $hNext_Clipboard <> 0 Then _SendMessage($hNext_Clipboard, $WM_DRAWCLIPBOARD, $iwParam, $ilParam)
EndFunc