#include <GUIConstants.au3>
#include <Misc.au3>
#include <Fade.au3>
Global $active = 0
#Region ### START Koda GUI section ### Form=
$Form1 = GUICreate("Hotkeyset - Set All Your hotkeys Simple and Easy", 633, 448, 193, 125)
GUISetBkColor(0x000000)
FadeIn($Form1)
$Label1 = GUICtrlCreateLabel(" Use This Program To Set hotkeys For Any Program That You Wish", 24, 16, 569, 28)
GUICtrlSetFont(-1, 14, 400, 0, "MS Sans Serif")
GUICtrlSetColor(-1, 0xFFFFFF)
$Label2 = GUICtrlCreateLabel(" F1", 64, 104, 22, 20)
GUICtrlSetFont(-1, 10, 400, 0, "MS Sans Serif")
GUICtrlSetColor(-1, 0xFFFFFF)
$Label3 = GUICtrlCreateLabel("Hotkey", 40, 56, 84, 33)
GUICtrlSetFont(-1, 18, 800, 0, "MS Sans Serif")
GUICtrlSetColor(-1, 0xFFFFFF)
$Label4 = GUICtrlCreateLabel("Full Path Of Program", 280, 56, 248, 33)
GUICtrlSetFont(-1, 18, 800, 0, "MS Sans Serif")
GUICtrlSetColor(-1, 0xFFFFFF)
$Input1 = GUICtrlCreateInput("", 280, 104, 257, 21)
$Button1 = GUICtrlCreateButton("Browse", 552, 104, 65, 25, 0)
GUICtrlSetBkColor(-1, 0xFFFFFF)
$Label5 = GUICtrlCreateLabel(" F2", 64, 136, 22, 20)
GUICtrlSetFont(-1, 10, 400, 0, "MS Sans Serif")
GUICtrlSetColor(-1, 0xFFFFFF)
$Input2 = GUICtrlCreateInput("", 280, 136, 257, 21)
$Button2 = GUICtrlCreateButton("Browse", 552, 136, 65, 25, 0)
GUICtrlSetBkColor(-1, 0xFFFFFF)
$Label6 = GUICtrlCreateLabel(" F3", 64, 168, 22, 20)
GUICtrlSetFont(-1, 10, 400, 0, "MS Sans Serif")
GUICtrlSetColor(-1, 0xFFFFFF)
$Input3 = GUICtrlCreateInput("", 280, 168, 257, 21)
$Button3 = GUICtrlCreateButton("Browse", 552, 168, 65, 25, 0)
GUICtrlSetBkColor(-1, 0xFFFFFF)
$Label7 = GUICtrlCreateLabel(" F4", 64, 200, 22, 20)
GUICtrlSetFont(-1, 10, 400, 0, "MS Sans Serif")
GUICtrlSetColor(-1, 0xFFFFFF)
$Input4 = GUICtrlCreateInput("", 280, 200, 257, 21)
$Button4 = GUICtrlCreateButton("Browse", 552, 200, 65, 25, 0)
GUICtrlSetBkColor(-1, 0xFFFFFF)
$Label8 = GUICtrlCreateLabel(" F5", 64, 232, 22, 20)
GUICtrlSetFont(-1, 10, 400, 0, "MS Sans Serif")
GUICtrlSetColor(-1, 0xFFFFFF)
$Input5 = GUICtrlCreateInput("", 280, 232, 257, 21)
$Button5 = GUICtrlCreateButton("Browse", 552, 232, 65, 25, 0)
GUICtrlSetBkColor(-1, 0xFFFFFF)
$Label9 = GUICtrlCreateLabel(" F6", 64, 264, 22, 20)
GUICtrlSetFont(-1, 10, 400, 0, "MS Sans Serif")
GUICtrlSetColor(-1, 0xFFFFFF)
$Input6 = GUICtrlCreateInput("", 280, 264, 257, 21)
$Button6 = GUICtrlCreateButton("Browse", 552, 264, 65, 25, 0)
GUICtrlSetBkColor(-1, 0xFFFFFF)
$Label10 = GUICtrlCreateLabel(" F7", 64, 296, 22, 20)
GUICtrlSetFont(-1, 10, 400, 0, "MS Sans Serif")
GUICtrlSetColor(-1, 0xFFFFFF)
$Input7 = GUICtrlCreateInput("", 280, 296, 257, 21)
$Button7 = GUICtrlCreateButton("Browse", 552, 296, 65, 25, 0)
GUICtrlSetBkColor(-1, 0xFFFFFF)
$Label11 = GUICtrlCreateLabel(" F8", 64, 328, 22, 20)
GUICtrlSetFont(-1, 10, 400, 0, "MS Sans Serif")
GUICtrlSetColor(-1, 0xFFFFFF)
$Input8 = GUICtrlCreateInput("", 280, 328, 257, 21)
$Button8 = GUICtrlCreateButton("Browse", 552, 328, 65, 25, 0)
GUICtrlSetBkColor(-1, 0xFFFFFF)
$Label12 = GUICtrlCreateLabel(" F9", 64, 360, 22, 20)
GUICtrlSetFont(-1, 10, 400, 0, "MS Sans Serif")
GUICtrlSetColor(-1, 0xFFFFFF)
$Input9 = GUICtrlCreateInput("", 280, 360, 257, 21)
$Button9 = GUICtrlCreateButton("Browse", 552, 360, 65, 25, 0)
GUICtrlSetBkColor(-1, 0xFFFFFF)
$Button10 = GUICtrlCreateButton("Save And Enable hotkeys Now", 16, 392, 401, 49, 0)
GUICtrlSetBkColor(-1, 0xFFFFFF)
$Button11 = GUICtrlCreateButton("Clear All", 552, 64, 65, 25, 0)
GUICtrlSetBkColor(-1, 0xFFFFFF)
$Button12 = GUICtrlCreateButton("Save And Exit", 432, 392, 177, 49, 0)
GUICtrlSetBkColor(-1, 0xFFFFFF)
$Checkbox1 = GUICtrlCreateCheckbox("Override Windows", 112, 104, 129, 17)
GUICtrlSetColor(-1, 0x000000)
GUICtrlSetBkColor(-1, 0xFFFFFF)
;===============================================================================
$F1 = IniRead(@MyDocumentsDir & "\a.ini", "Location", "F1", "")
GUICtrlSetData($Input1, $F1)
$F2 = IniRead(@MyDocumentsDir & "\a.ini", "Location", "F2", "")
GUICtrlSetData($Input2, $F2)
$F3 = IniRead(@MyDocumentsDir & "\a.ini", "Location", "F3", "")
GUICtrlSetData($Input3, $F3)
$F4 = IniRead(@MyDocumentsDir & "\a.ini", "Location", "F4", "")
GUICtrlSetData($Input4, $F4)
$F5 = IniRead(@MyDocumentsDir & "\a.ini", "Location", "F5", "")
GUICtrlSetData($Input5, $F5)
$F6 = IniRead(@MyDocumentsDir & "\a.ini", "Location", "F6", "")
GUICtrlSetData($Input6, $F6)
$F7 = IniRead(@MyDocumentsDir & "\a.ini", "Location", "F7", "")
GUICtrlSetData($Input7, $F7)
$F8 = IniRead(@MyDocumentsDir & "\a.ini", "Location", "F8", "")
GUICtrlSetData($Input8, $F8)
$F9 = IniRead(@MyDocumentsDir & "\a.ini", "Location", "F9", "")
GUICtrlSetData($Input9, $F9)
$win = IniRead(@MyDocumentsDir & "\a.ini", "Override", "Windows", "4")
GUICtrlSetState($Checkbox1, $Win)
;================================================================================
If $win = "4" Then
GUICtrlSetData($Input1, "Windows Does Not Allow F1 To Be Used")
GUICtrlSetState($Input2, $GUI_FOCUS)
GUICtrlSetState($Input1, $GUI_DISABLE)
GUICtrlSetState($Button1, $GUI_DISABLE)
Else
    GUICtrlSetState($Input1, $GUI_FOCUS)
EndIf

GUISetState(@SW_SHOW)
#EndRegion ### END Koda GUI section ###

While 1
    $nMsg = GUIGetMsg()
    Switch $nMsg
        Case $GUI_EVENT_CLOSE
            Fadeout($Form1)
            Exit
        Case $Checkbox1
            If GUICtrlRead($Checkbox1) = $GUI_CHECKED Then
                GUICtrlSetData($Input1, "")
            GUICtrlSetState($Input1, $GUI_ENABLE)
            GUICtrlSetState($Button1, $GUI_ENABLE)
            GUICtrlSetState($Input1, $GUI_FOCUS)
            Else
            GUICtrlSetState($Input1, $GUI_DISABLE)
            GUICtrlSetState($Button1, $GUI_DISABLE)
            GUICtrlSetData($Input1, "Windows Does Not Allow F1 To Be Used")
            GUICtrlSetState($Input2, $GUI_FOCUS)
            EndIf
        Case $Button1
            $file1 = FileOpenDialog("Choose Program .exe", "", "Exe's (*.exe)|Shortcuts (*.ink)")
            GUICtrlSetData($Input1, $file1)
        Case $Button2
            $file2 = FileOpenDialog("Choose Program .exe", "", "Exe's (*.exe)|Shortcuts (*.ink)")
            GUICtrlSetData($Input2, $file2)
        Case $Button3
            $file3 = FileOpenDialog("Choose Program .exe", "", "Exe's (*.exe)|Shortcuts (*.ink)")
            GUICtrlSetData($Input3, $file3)
        Case $Button4
            $file4 = FileOpenDialog("Choose Program .exe", "", "Exe's (*.exe)|Shortcuts (*.ink)")
            GUICtrlSetData($Input4, $file4)
        Case $Button5
            $file5 = FileOpenDialog("Choose Program .exe", "", "Exe's (*.exe)|Shortcuts (*.ink)")
            GUICtrlSetData($Input5, $file5)
        Case $Button6
            $file6 = FileOpenDialog("Choose Program .exe", "", "Exe's (*.exe)|Shortcuts (*.ink)")
            GUICtrlSetData($Input6, $file6)
        Case $Button7
            $file7 = FileOpenDialog("Choose Program .exe", "", "Exe's (*.exe)|Shortcuts (*.ink)")
            GUICtrlSetData($Input7, $file7)
        Case $Button8
            $file8 = FileOpenDialog("Choose Program .exe", "", "Exe's (*.exe)|Shortcuts (*.ink)")
            GUICtrlSetData($Input8, $file8)
        Case $Button9
            $file9 = FileOpenDialog("Choose Program .exe", "", "Exe's (*.exe)|Shortcuts (*.ink)")
            GUICtrlSetData($Input9, $file9)
        Case $Button11
            If GUICtrlRead($Checkbox1) = $GUI_UNCHECKED Then
            GUICtrlSetData($Input1, "Windows Does Not Allow F1 To Be Used")
            GUICtrlSetData($Input2, "")
            GUICtrlSetData($Input3, "")
            GUICtrlSetData($Input4, "")
            GUICtrlSetData($Input5, "")
            GUICtrlSetData($Input6, "")
            GUICtrlSetData($Input7, "")
            GUICtrlSetData($Input8, "")
            GUICtrlSetData($Input9, "")
            GUICtrlSetState($Input2, $GUI_FOCUS)
            Else
            GUICtrlSetData($Input1, "")
            GUICtrlSetData($Input2, "")
            GUICtrlSetData($Input3, "")
            GUICtrlSetData($Input4, "")
            GUICtrlSetData($Input5, "")
            GUICtrlSetData($Input6, "")
            GUICtrlSetData($Input7, "")
            GUICtrlSetData($Input8, "")
            GUICtrlSetData($Input9, "")
            GUICtrlSetState($Input1, $GUI_FOCUS)
            EndIf
        Case $Button10
            MsgBox(0, "Enabling hotkeys", "To Enable The GUI, And Disable hotkeys Press 'END' At Anytime")
            Fadeout($Form1)
            Write()
            $active = 1
            While $active
                Sleep(50)
                If _IsPressed(23) Then
                    _end()
                EndIf
                If GUICtrlRead($Checkbox1) = $GUI_CHECKED Then
                    Sleep(50)
                    If _IsPressed(70) Then
                        If GUICtrlRead($Input1) = "" Then
                        Msgbox(0, "Hotkey", "Hotkey Blank")
                    Else
                    $F1P = GUICtrlRead($Input1)
                    Run($F1P)
                EndIf
            EndIf
        EndIf
                If _IsPressed(71) Then
                    If GUICtrlRead($Input2) = "" Then
                        Msgbox(0, "Hotkey", "Hotkey Blank")
                    Else
                    $F2P = GUICtrlRead($Input2)
                    Run($F2P)
                    EndIf
                EndIf
                If _IsPressed(72) Then
                    If GUICtrlRead($Input3) = "" Then
                        Msgbox(0, "Hotkey", "Hotkey Blank")
                    Else
                    $F3P = GUICtrlRead($Input3)
                    Run($F3P)
                    EndIf
                EndIf
                If _IsPressed(73) Then
                    If GUICtrlRead($Input4) = "" Then
                        Msgbox(0, "Hotkey", "Hotkey Blank")
                    Else
                    $F4P = GUICtrlRead($Input4)
                    Run($F4P)
                EndIf
                EndIf
                If _IsPressed(74) Then
                    If GUICtrlRead($Input5) = "" Then
                        Msgbox(0, "Hotkey", "Hotkey Blank")
                    Else
                    $F5P = GUICtrlRead($Input5)
                    Run($F5P)
                EndIf
                EndIf
                If _IsPressed(75) Then
                    If GUICtrlRead($Input6) = "" Then
                        Msgbox(0, "Hotkey", "Hotkey Blank")
                    Else
                    $F6P = GUICtrlRead($Input6)
                    Run($F6P)
                EndIf
                EndIf
                If _IsPressed(76) Then
                    If GUICtrlRead($Input7) = "" Then
                        Msgbox(0, "Hotkey", "Hotkey Blank")
                    Else
                    $F7P = GUICtrlRead($Input7)
                    Run($F7P)
                EndIf
                EndIf
                If _IsPressed(77) Then
                    If GUICtrlRead($Input2) = "" Then
                        Msgbox(0, "Hotkey", "Hotkey Blank")
                    Else
                    $F8P = GUICtrlRead($Input8)
                    Run($F8P)
                EndIf
                EndIf
                If _IsPressed(78) Then
                    If GUICtrlRead($Input9) = "" Then
                        Msgbox(0, "Hotkey", "Hotkey Blank")
                    Else
                    $F9P = GUICtrlRead($Input9)
                    Run($F9P)
                EndIf
                EndIf
                Sleep(100)
            WEnd
        Case $Button12
            Global $active = 0
            Write()
            Fadeout($Form1)
        Exit
    EndSwitch
WEnd

Func Write()
iniWrite(@MyDocumentsDir & "\a.ini", "Location", "F1", GUICtrlRead($Input1))
IniWrite(@MyDocumentsDir & "\a.ini", "Location", "F2", GUICtrlRead($Input2))
IniWrite(@MyDocumentsDir & "\a.ini", "Location", "F3", GUICtrlRead($Input3))
IniWrite(@MyDocumentsDir & "\a.ini", "Location", "F4", GUICtrlRead($Input4))
IniWrite(@MyDocumentsDir & "\a.ini", "Location", "F5", GUICtrlRead($Input5))
IniWrite(@MyDocumentsDir & "\a.ini", "Location", "F6", GUICtrlRead($Input6))
IniWrite(@MyDocumentsDir & "\a.ini", "Location", "F7", GUICtrlRead($Input7))
IniWrite(@MyDocumentsDir & "\a.ini", "Location", "F8", GUICtrlRead($Input8))
IniWrite(@MyDocumentsDir & "\a.ini", "Location", "F9", GUICtrlRead($Input9))
IniWrite(@MyDocumentsDir & "\a.ini", "Override", "Windows", GUICtrlRead($Checkbox1))
EndFunc

Func _end()
    FadeIn($Form1)
    $active = 0
;glitch after fading back in, every input would be black? so focusing to reinable
    If GUICtrlRead($Checkbox1) = $GUI_CHECKED Then
    GUICtrlSetState($Input1, $GUI_FOCUS)
    GUICtrlSetState($Input2, $GUI_FOCUS)
    GUICtrlSetState($Input3, $GUI_FOCUS)
    GUICtrlSetState($Input4, $GUI_FOCUS)
    GUICtrlSetState($Input5, $GUI_FOCUS)
    GUICtrlSetState($Input6, $GUI_FOCUS)
    GUICtrlSetState($Input7, $GUI_FOCUS)
    GUICtrlSetState($Input8, $GUI_FOCUS)
    GUICtrlSetState($Input9, $GUI_FOCUS)
    GUICtrlSetState($Input1, $GUI_FOCUS)
    Else
    GUICtrlSetState($Input1, $GUI_ENABLE)
    GUICtrlSetState($Input1, $GUI_FOCUS)
    GUICtrlSetState($Input2, $GUI_FOCUS)
    GUICtrlSetState($Input3, $GUI_FOCUS)
    GUICtrlSetState($Input4, $GUI_FOCUS)
    GUICtrlSetState($Input5, $GUI_FOCUS)
    GUICtrlSetState($Input6, $GUI_FOCUS)
    GUICtrlSetState($Input7, $GUI_FOCUS)
    GUICtrlSetState($Input8, $GUI_FOCUS)
    GUICtrlSetState($Input9, $GUI_FOCUS)
    GUICtrlSetState($Input1, $GUI_DISABLE)
    GUICtrlSetState($Input2, $GUI_FOCUS)
    EndIf
EndFunc