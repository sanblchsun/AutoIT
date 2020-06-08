#NoTrayIcon
#include <Misc.au3>
#include <MouseSetOnEvent_UDF.au3>
;

Global $hUser32_Dll = DllOpen("User32.dll")
Global $iSelected = False
Global $iPaused = True

Global $sFile = @ScriptDir & "\SelectedText.txt"

HotKeySet("^+e", "_Quit")
HotKeySet("^+w", "_TogglePause")

_TogglePause()

While 1
    Sleep(10)

    If $iSelected Then
        $iSelected = False

        ;$hWnd = WinGetHandle("")
        ;$sCtrlID = ControlGetFocus("")
        ;$sSelection = ControlCommand($hWnd, "", $sCtrlID, "GetSelected")

        If _IsPressed("12", $hUser32_Dll) Then
            While _IsPressed("12", $hUser32_Dll)
                Sleep(10)
            WEnd

            $sSelection = _GetSelectedText()
            If $sSelection <> "" Then FileWriteLine($sFile, $sSelection & @CRLF & @CRLF)
        EndIf
    EndIf
WEnd

Func MousePrimaryUp_Event()
    $iSelected = True
EndFunc

Func _GetSelectedText()
    Local $sOld_Clipboard_Data = ClipGet()

    ClipPut("")
    Send("^{Insert}")
    Sleep(100)
    Local $sSelected_Data = ClipGet()
    ClipPut($sOld_Clipboard_Data)

    Return $sSelected_Data
EndFunc

Func _TogglePause()
    $iPaused = Not $iPaused

    If $iPaused Then
        _MouseSetOnEvent($MOUSE_PRIMARYUP_EVENT)
    Else
        _MouseSetOnEvent($MOUSE_PRIMARYUP_EVENT, "MousePrimaryUp_Event", "", "", 0, 0)
    EndIf
EndFunc

Func _Quit()
    DllClose($hUser32_Dll)
    Exit
EndFunc