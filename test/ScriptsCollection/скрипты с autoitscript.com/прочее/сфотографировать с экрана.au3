#include <StaticConstants.au3>
#include <EditConstants.au3>
#include <ComboConstants.au3>
#include <GuiConstants.au3>
#include <WindowsConstants.au3>
#include <ButtonConstants.au3>
#include <Process.au3>
#Include <Misc.au3>
#include <Constants.au3>
#Include <GuiButton.au3>
#Include <Clipboard.au3>
#Include <ScreenCapture.au3>
#include <GDIPlus.au3>
#include <file.au3>
$fastx = _WinAPI_GetSystemMetrics(78)
$fasty = _WinAPI_GetSystemMetrics(79)
_area()

func _area()
    $var = WinList()
    For $i = 1 to $var[0][0]
        If $var[$i][0] <> "" AND $var[$i][0] <> "start" AND IsVisible($var[$i][1]) Then WinSetState ($var[$i][0], "", @SW_DISABLE  )
    Next
    $GUI_2 = GUICreate("", 1, 1, -1, -1, 0x80000000 + 0x00800000, 0x00000008)
    GUISetBkColor(0x0c6eec)
    WinSetTrans($GUI_2, "", 130)
    local $s_left = "", $s_top = "", $s_width = "", $s_height = "", $mgp[2]
    Local $hGUI = GUICreate("", $fastx+50, $fasty+50, -15, -25, -1, 0x00000080)
    GUISetBkColor(0xffffff)
    WinSetTrans($hGUI, "", 40)
    WinSetOnTop($hGUI, "", 1)
    GUISetCursor(3)
    GUISetState(@SW_SHOW, $hGUI)
    While Not _IsPressed(01)
        $mgp = MouseGetPos()
        Sleep(50)
    WEnd
    WinMove($GUI_2, "", $mgp[0], $mgp[1], 1, 1)
    GUISetState(@SW_SHOW, $GUI_2)
    While _IsPressed(01)
        $mgp_2 = MouseGetPos()
        If $mgp_2[0] > $mgp[0] And $mgp_2[1] > $mgp[1] Then
            local $s_left = $mgp[0], $s_top = $mgp[1], $s_width = $mgp_2[0] - $mgp[0], $s_height = $mgp_2[1] - $mgp[1]
        ElseIf $mgp_2[0] > $mgp[0] And $mgp_2[1] < $mgp[1] Then
            Local $s_left = $mgp[0], $s_top = $mgp_2[1], $s_width = $mgp_2[0] - $mgp[0], $s_height = $mgp[1] - $mgp_2[1]
        ElseIf $mgp_2[0] < $mgp[0] And $mgp_2[1] > $mgp[1] Then
            Local $s_left = $mgp_2[0], $s_top = $mgp[1], $s_width = $mgp[0] - $mgp_2[0], $s_height = $mgp_2[1] - $mgp[1]
        ElseIf $mgp_2[0] < $mgp[0] And $mgp_2[1] < $mgp[1] Then
            Local $s_left = $mgp_2[0], $s_top = $mgp_2[1], $s_width = $mgp[0] - $mgp_2[0], $s_height = $mgp[1] - $mgp_2[1]
        EndIf
        WinMove($GUI_2, "", $s_left, $s_top, $s_width, $s_height)
        WinSetOnTop($hGUI, "", 1)
        ToolTip($s_width & "x" & $s_height)
        sleep(50)
    WEnd
    ToolTip("")
    GLOBAL $s_left = $s_left, $s_top = $s_top, $s_width = $s_width, $s_height = $s_height
    GUIDelete($hGUI)
    $var = WinList()
    For $i = 1 to $var[0][0]
        If $var[$i][0] <> "" AND IsVisible($var[$i][1]) Then WinSetState ($var[$i][0], "", @SW_ENABLE  )
    Next
    GUIDelete($GUI_2)
    $hBitmap = _ScreenCapture_Capture(@ScriptDir & "\test.jpg", $s_left, $s_top, $s_left+$s_width, $s_top+$s_height, false)
    msgbox(0,"",@ScriptDir & "\test.jpg")
endfunc

Func IsVisible($handle)
    If BitAnd(WinGetState($handle), 2) Then
        Return 1
    Else
        Return 0
    EndIf
EndFunc