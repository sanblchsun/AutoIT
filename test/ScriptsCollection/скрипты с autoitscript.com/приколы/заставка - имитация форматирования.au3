HotKeySet("{esc}", "Exitapp")
#include <EditConstants.au3>
#include <GUIConstantsEx.au3>
#include <WindowsConstants.au3>
#include <GUIEdit.au3>
$Width = @DesktopWidth
$Height = @DesktopHeight
Func Exitapp()
    _ChangeScreenRes($Width, $Height)
    Exit
EndFunc   ;==>Exitapp
#Region ### START Koda GUI section ### Form=
$Form1 = GUICreate("CMD", 640, 480, 0, 0, $ws_popup)
$Edit1 = GUICtrlCreateEdit("", 3, 3, 634, 474, 0, 0)
WinSetOnTop($Form1, "", 1)
GUICtrlSetFont(-1, 10, 400, 0, "Terminal")
GUICtrlSetColor(-1, 0xC0C0C0)
GUISetBkColor(0)
GUICtrlSetBkColor($Edit1, 0x000000)
GUISetState(@SW_SHOW)
_ChangeScreenRes(640, 480)
MouseMove(1000, 1000, 0)
$x = MouseGetPos(0)
$y = MouseGetPos(1)
AdlibRegister("check", 100)
While 1
    GUICtrlSetData($Edit1, "")
    GUICtrlSetColor(-1, 0xC0C0C0)
    GUICtrlSetBkColor($Edit1, 0x000000)
    GUISetBkColor(0)
    _GUICtrlEdit_AppendText($Edit1, "Microsoft Windows [Version " & StringLeft(@OSBuild, 1) - 1 & ".1." & @OSBuild & "]" & @CRLF & "Copyright © 2009 Microsoft Corporation.  All rights reserved." & @CRLF & @CRLF & @HomeDrive & @HomePath & ">")
    _GUICtrlEdit_SetSel($Edit1, 0, 0)

    $split = StringSplit("format c:", "")
    For $i = 1 To $split[0]
        _GUICtrlEdit_AppendText($Edit1, $split[$i])
        Sleep(200)
    Next
    Sleep(500)

    _GUICtrlEdit_AppendText($Edit1, @CRLF & @CRLF & "WARNING: ALL DATE ON NON-REMOVABLE DISK" & @CRLF & "DRIVE C: WILL BE LOST!" & @CRLF & "Proceed with Format (Y/N)?")
    Sleep(700)
    _GUICtrlEdit_AppendText($Edit1, "y" & @CRLF & @CRLF & @CRLF)

    _GUICtrlEdit_AppendText($Edit1, "Formatting " & Round(DriveSpaceTotal("c:\"), 0) & " MB" & @CRLF)

    $data = GUICtrlRead($Edit1) & "%d% completed"
    For $i = 0 To 100
        GUICtrlSetData($Edit1, StringReplace($data, "%d", $i))
        Sleep(100)
    Next

    _GUICtrlEdit_AppendText($Edit1, @CRLF & "Writing out file allocation table" & @CRLF)
    Sleep(2000)
    _GUICtrlEdit_AppendText($Edit1, "Complete." & @CRLF)
    _GUICtrlEdit_AppendText($Edit1, "Calculating free space (this may take several minutes)..." & @CRLF)
    Sleep(2000)
    _GUICtrlEdit_AppendText($Edit1, "Complete." & @CRLF & @CRLF & "Volume label (11 characters, ENTER for none)?")

    Sleep(500)
    _GUICtrlEdit_AppendText($Edit1, @CRLF & @CRLF & "C:\")
    Sleep(500)
    _GUICtrlEdit_AppendText($Edit1, "D:")
    Sleep(500)
    _GUICtrlEdit_AppendText($Edit1, @CRLF & "D:\")
    $split = StringSplit("setup.exe", "")
    For $i = 1 To $split[0]
        _GUICtrlEdit_AppendText($Edit1, $split[$i])
        Sleep(200)
    Next

    GUICtrlSetData($Edit1, "MSCDEX Version 2.25" & @CRLF & "Copyright © Microsoft Corp. 1986-1995. All right reserved." & @CRLF & "        Drive D: = Driver OEMCD001 unit 0")
    Sleep(1000)
    GUISetBkColor(0x0000cc)
    GUICtrlSetBkColor($Edit1, 0x0000bb)
    GUICtrlSetData($Edit1, "Microsoft Windows 98 Setup" & @CRLF & "==============================" & @CRLF & @CRLF & @TAB & "Welcome to Setup" & @CRLF & @CRLF & @TAB & "The Setup program prepares Windows 98 to run on your" & @CRLF & @TAB & "computer." & @CRLF & @CRLF & @TAB & "  * To set up Windows now, press ENTER." & @CRLF & @CRLF & @TAB & "  * To learn more about Setup before continuing, press F1." & @CRLF & @CRLF & @TAB & "  * To quit Setup without installing Windows, press F3." & @CRLF & @CRLF & @TAB & "Note: If you have have not backed up your files recently, you" & @CRLF & @TAB & @TAB & "might want to do so before installing Windows. To back" & @CRLF & @TAB & @TAB & "up your files, press F3 to quit Setup now. Then, back" & @CRLF & @TAB & @TAB & "up your files by using a backup program." & @CRLF & @CRLF & @TAB & "To continue with Setup, press ENTER")
    Sleep(2000)
    GUICtrlSetData($Edit1, "ERROR: Setup is NOT valid binary, please report" & @CRLF & "this error at http://ubuntuforums.org" & @CRLF & @CRLF & "For more information please visit Microsoft homepage at" & @CRLF & "http://www.ubuntu.com/desktop/get-ubuntu/download")
    Sleep(5000)
WEnd
#EndRegion ### END Koda GUI section ###

While 1
    $nMsg = GUIGetMsg()
    Switch $nMsg
        Case $GUI_EVENT_CLOSE
            Exit

    EndSwitch
WEnd

Func _ChangeScreenRes($i_Width = @DesktopWidth, $i_Height = @DesktopHeight, $i_BitsPP = @DesktopDepth, $i_RefreshRate = @DesktopRefresh)
    Local Const $DM_PELSWIDTH = 0x00080000
    Local Const $DM_PELSHEIGHT = 0x00100000
    Local Const $DM_BITSPERPEL = 0x00040000
    Local Const $DM_DISPLAYFREQUENCY = 0x00400000
    Local Const $CDS_TEST = 0x00000002
    Local Const $CDS_UPDATEREGISTRY = 0x00000001
    Local Const $DISP_CHANGE_RESTART = 1
    Local Const $DISP_CHANGE_SUCCESSFUL = 0
    Local Const $HWND_BROADCAST = 0xffff
    Local Const $WM_DISPLAYCHANGE = 0x007E
    If $i_Width = "" Or $i_Width = -1 Then $i_Width = @DesktopWidth ; default to current setting
    If $i_Height = "" Or $i_Height = -1 Then $i_Height = @DesktopHeight ; default to current setting
    If $i_BitsPP = "" Or $i_BitsPP = -1 Then $i_BitsPP = @DesktopDepth ; default to current setting
    If $i_RefreshRate = "" Or $i_RefreshRate = -1 Then $i_RefreshRate = @DesktopRefresh ; default to current setting
    Local $DEVMODE = DllStructCreate("byte[32];int[10];byte[32];int[6]")
    Local $B = DllCall("user32.dll", "int", "EnumDisplaySettings", "ptr", 0, "long", 0, "ptr", DllStructGetPtr($DEVMODE))
    If @error Then
        $B = 0
        SetError(1)
        Return $B
    Else
        $B = $B[0]
    EndIf
    If $B <> 0 Then
        DllStructSetData($DEVMODE, 2, BitOR($DM_PELSWIDTH, $DM_PELSHEIGHT, $DM_BITSPERPEL, $DM_DISPLAYFREQUENCY), 5)
        DllStructSetData($DEVMODE, 4, $i_Width, 2)
        DllStructSetData($DEVMODE, 4, $i_Height, 3)
        DllStructSetData($DEVMODE, 4, $i_BitsPP, 1)
        DllStructSetData($DEVMODE, 4, $i_RefreshRate, 5)
        $B = DllCall("user32.dll", "int", "ChangeDisplaySettings", "ptr", DllStructGetPtr($DEVMODE), "int", $CDS_TEST)
        If @error Then
            $B = -1
        Else
            $B = $B[0]
        EndIf
        Select
            Case $B = $DISP_CHANGE_RESTART
                $DEVMODE = ""
                Return 2
            Case $B = $DISP_CHANGE_SUCCESSFUL
                DllCall("user32.dll", "int", "ChangeDisplaySettings", "ptr", DllStructGetPtr($DEVMODE), "int", $CDS_UPDATEREGISTRY)
                DllCall("user32.dll", "int", "SendMessage", "hwnd", $HWND_BROADCAST, "int", $WM_DISPLAYCHANGE, _
                        "int", $i_BitsPP, "int", $i_Height * 2 ^ 16 + $i_Width)
                $DEVMODE = ""
                Return 1
            Case Else
                $DEVMODE = ""
                SetError(1)
                Return $B
        EndSelect
    EndIf
EndFunc   ;==>_ChangeScreenRes
Func check()
    If $x <> MouseGetPos(0) Or $y <> MouseGetPos(1) Then
        Exitapp()
    EndIf
EndFunc   ;==>check