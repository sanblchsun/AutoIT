#include <GUIConstants.au3>
#include <WindowsConstants.au3>
#include <WINAPI.au3>

$gui = GUICreate("trans", 300, 230, -1, -1, $WS_POPUP, $WS_EX_LAYERED)
_WinAPI_SetLayeredWindowAttributes($gui, 0xACCDEF)
$lg=GUICtrlCreateLabel("", 0, 0, 40, 40)
GUICtrlSetBkColor(-1, 0xACCDEF)
$lg1=GUICtrlCreateLabel("", 40, 0, 240, 20, -1, $GUI_WS_EX_PARENTDRAG)
GUICtrlSetBkColor(-1, 0xABCDEF)
$checkTrans = GUICtrlCreateCheckbox("Цвет прозрачности 0xACCDEF или 0x020101", 10, 50, 280, 17)
GUICtrlSetBkColor(-1, 0xABCDEF)
$x= GUICtrlCreateButton("x", 280, 0, 20, 20)
GUICtrlSetBkColor(-1, 0xFF0000)

GUISetState()

While 1
    $msg = GUIGetMsg()
    Select
        Case $msg = -3 Or $msg =  $x
            Exit
        Case $msg = $checkTrans
            If GUICtrlRead($checkTrans) = $GUI_CHECKED Then
                _WinAPI_SetLayeredWindowAttributes($gui, 0x020101, 90)
            Else
                _WinAPI_SetLayeredWindowAttributes($gui, 0xACCDEF, 220)
            EndIf
    EndSelect
WEnd