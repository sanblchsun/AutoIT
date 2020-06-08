#include <GUIConstants.au3>

$Title = "About Info"

$MainLabel = "My program Name"
$CopyRLabel = "Copyright © " & @YEAR & " Company/Author. All rights reserved."

$NameURL1 = "App Web Page"
$URL1 = "http://www.autoitscript.com"
$NameURL2 = "Email"
$URL2 = "mailto:my_email@mail.com"
$NameURL3 = "Some additional link"
$URL3 = "http://personalwebpafe.com"
$LinkColor = 0x0000FF
$BkColor = 0xFFFFFF

$ParentGui = GUICreate('Parent For "About Program" Demo', 200, 100)

$Menu = GUICtrlCreateMenu("Help")
$AboutItem = GUICtrlCreateMenuitem("About...", $Menu)

GUISetState()

While 1
    Switch GUIGetMsg()
        Case -3
            Exit
        Case $AboutItem
            _AboutGUI($Title, $MainLabel, "Program version: " & @LF & "v1.0", $CopyRLabel, _
                $NameURL1, $URL1, $NameURL2, $URL2, $NameURL3, $URL3, $ParentGui, @AutoItExe, $LinkColor, $BkColor, 500, 300)
    EndSwitch
WEnd

Func _AboutGUI($Title, $MainLabel, $TextLabel, $CopyRLabel, $NameURL1, $URL1, $NameURL2, $URL2, $NameURL3, $URL3, $Parent=0, $IconFile="", $LinkColor=0x0000FF, $BkColor=0xFFFFFF, $Width=300, $Height=120, $Left=-1, $Top=-1, $Style=-1, $ExStyle=-1)
    Local $OldEventOpt = Opt("GUIOnEventMode", 0)
    Local $OldRunErrOpt = Opt("RunErrorsFatal", 0)
    Local $About_GUI, $LinkTop=120, $About_Msg, $CurInfo
    Local $CurIsOnCtrlArr[1]

        Local $LinkVisitedColor[4] = [3, $LinkColor, $LinkColor, $LinkColor]
    Local $LinkLabel[4]

        WinSetState($Parent, "", @SW_DISABLE)

        If $ExStyle = -1 Then $ExStyle = ""
    $About_GUI = GUICreate($Title, $Width, $Height, $Left, $Top, $Style, 0x00000080+$ExStyle, $Parent)
    GUISetBkColor($BkColor)

    GUICtrlCreateLabel($MainLabel, 0, 20, $Width, 25, 1)
    GUICtrlSetFont(-1, 14)

    GUICtrlCreateIcon($IconFile, 0, 10, 20)
    GUICtrlSetState(-1, 128)

        GUICtrlCreateGraphic(5, 75, $Width-10, 3, $SS_ETCHEDFRAME)

        For $i = 1 To 3
        $LinkLabel[$i] = GUICtrlCreateLabel(Eval("NameURL" & $i), $Width-150, $LinkTop, 145, 15, 1)
        GUICtrlSetCursor(-1, 0)
        GUICtrlSetColor(-1, $LinkColor)
        GUICtrlSetFont(-1, 9, 400, 0)
        GUICtrlSetTip(-1, Eval("URL" & $i))
        $LinkTop += 30
    Next

    GUICtrlCreateLabel($TextLabel, 10, 100, $Width-155, 35)
    GUICtrlSetFont(-1, 10, 600, 0, "Tahoma")

        GUICtrlCreateLabel($CopyRLabel, 0, $Height-20, $Width, -1, 1)
    GUICtrlSetColor(-1, 0x969696)
    GUICtrlSetState(-1, 128)

        GUISetState(@SW_SHOW, $About_GUI)

    While 1
        $About_Msg = GUIGetMsg()

                Switch $About_Msg
            Case -3
                ExitLoop
            Case $LinkLabel[1], $LinkLabel[2], $LinkLabel[3]
                GUISetCursor(0, 1, $About_GUI)
                $CurInfo = GUIGetCursorInfo($About_GUI)
                If $About_Msg = $LinkLabel[1] Then $i = 1
                If $About_Msg = $LinkLabel[2] Then $i = 2
                If $About_Msg = $LinkLabel[3] Then $i = 3

                                While $CurInfo[2] = 1
                    $CurInfo = GUIGetCursorInfo($About_GUI)
                    Sleep(10)
                WEnd

                                If $CurInfo[4] = $About_Msg Then
                    GUISetCursor(-1, 0, $About_GUI)
                    $LinkVisitedColor[$i] = 0xAC00A9
                    GUICtrlSetColor($About_Msg, $LinkVisitedColor[$i])
                    ShellExecute(Eval("URL" & $i))
                EndIf
                GUISetCursor(-1, 0, $About_GUI)
        EndSwitch

                Sleep(10)
        ControlHover($About_GUI, $LinkLabel[1], 1, $CurIsOnCtrlArr, 0xFF0000, $LinkVisitedColor[1])
        ControlHover($About_GUI, $LinkLabel[2], 2, $CurIsOnCtrlArr, 0xFF0000, $LinkVisitedColor[2])
        ControlHover($About_GUI, $LinkLabel[3], 3, $CurIsOnCtrlArr, 0xFF0000, $LinkVisitedColor[3])
    WEnd
    WinSetState($Parent, "", @SW_ENABLE)
    GUIDelete($About_GUI)
    GUISwitch($Parent)
    Opt("GUIOnEventMode", $OldEventOpt)
    Opt("RunErrorsFatal", $OldRunErrOpt)
EndFunc

Func ControlHover($hWnd, $CtrlID, $CtrlNum, ByRef $CurIsOnCtrlArr, $HoverColor=0xFF0000, $LinkColor=0x0000FF)
    Local $CursorCtrl = GUIGetCursorInfo($hWnd)
    ReDim $CurIsOnCtrlArr[UBound($CurIsOnCtrlArr)+1]
    If $CursorCtrl[4] = $CtrlID And $CurIsOnCtrlArr[$CtrlNum] = 1 Then
        GUICtrlSetFont($CtrlID, 9, 400, 6)
        GUICtrlSetColor($CtrlID, $HoverColor)
        $CurIsOnCtrlArr[$CtrlNum] = 0
    ElseIf $CursorCtrl[4] <> $CtrlID And $CurIsOnCtrlArr[$CtrlNum] = 0 Then
        GUICtrlSetFont($CtrlID, 9, 400, 0)
        GUICtrlSetColor($CtrlID, $LinkColor)
        $CurIsOnCtrlArr[$CtrlNum] = 1
    EndIf
EndFunc