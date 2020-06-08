; http://www.autoitscript.com/forum/topic/55506-slcvc/
#Region ;**** Directives created by AutoIt3Wrapper_GUI ****
#AutoIt3Wrapper_icon=..\..\..\Icons\Camping\Camping icos\knife.ico
#AutoIt3Wrapper_outfile=SLCVC.exe
#AutoIt3Wrapper_Res_Comment=Created by The Blue Drache
#AutoIt3Wrapper_Res_Description=Easily converts colour codes between differing formats
#AutoIt3Wrapper_Res_Fileversion=1.0.0.1
#AutoIt3Wrapper_Res_LegalCopyright=GNU PL v2.0
#AutoIt3Wrapper_Res_Language=1033
#AutoIt3Wrapper_Run_After=del *tidy*.txt
#AutoIt3Wrapper_Run_Tidy=y
#Tidy_Parameters=/gd 0
#EndRegion ;**** Directives created by AutoIt3Wrapper_GUI ****
#region - Options
Opt('CaretCoordMode', 0)    ; 1 = Absolute screen coordinates, 0 = Relative coords to the active window.
Opt('GUICloseOnESC', 0)     ; 0 = Don't send the $GUI_EVENT_CLOSE message when ESC is pressed.
Opt('MouseCoordMode', 0)    ; 1 = Absolute, 0 = Relative to active window, 2 = Relative to client area.
Opt('MustDeclareVars', 1)   ; 0 = No, 1 = Require pre-declare.
Opt('PixelCoordMode', 0)    ; 1 = Absolute, 0 = relative, 2 = Relative coords to the client area.
Opt('TrayIconHide', 1)  ; 0 = Show, 1 = Hide.
Opt('WinTitleMatchMode', 4)     ; 1 = Start, 2 = SubString, 3 = Exact, 4 = ...
#endregion
#region - Includes and startup stuff.
#include <GUIConstants.au3>
#include <Misc.au3>
#include <GuiEdit.au3>
#include <WindowsConstants.au3>
#include <StaticConstants.au3>
If @Compiled Then
    Global $version = "SLCVC v" & FileGetVersion(@ScriptFullPath)
Else
    Global $version = "SLCVC v - Uncompiled" 
EndIf
_Singleton($version, 1)
If @error Then
    MsgBox(0, $version, "Error:  Program already running!")
    Exit
EndIf
#endregion
#Region ### START Koda GUI section ### Form=c:\documents and settings\u256655\desktop\autoit\user scripts\sl vector calc\frmmain.kxf
Global $frmGUIMain = GUICreate($version, 405, 570, 193, 115)
Global $grpNptInt = GUICtrlCreateGroup("Integer Color Entry", 8, 144, 385, 105)
Global $nptRed = GUICtrlCreateInput("0", 16, 168, 121, 21)
Global $nptGreen = GUICtrlCreateInput("0", 16, 192, 121, 21)
Global $nptBlue = GUICtrlCreateInput("0", 16, 216, 121, 21)
Global $lblRed = GUICtrlCreateLabel("Red Color Integer.  (Range 0-255)", 152, 170, 164, 17, BitOR($ES_AUTOHSCROLL, $ES_READONLY))
Global $lblGreen = GUICtrlCreateLabel("Green Color Integer.  (Range 0-255)", 152, 194, 173, 17, BitOR($ES_AUTOHSCROLL, $ES_READONLY))
Global $lblBlue = GUICtrlCreateLabel("Blue Color Integer.  (Range 0-255)", 152, 218, 165, 17, BitOR($ES_AUTOHSCROLL, $ES_READONLY))
GUICtrlCreateGroup("", -99, -99, 1, 1)
Global $btnGo = GUICtrlCreateButton("&Calculate", 16, 88, 369, 33, 0)
Global $grpNptHex = GUICtrlCreateGroup("Hex Color Values", 8, 256, 385, 105)
Global $nptH_Red = GUICtrlCreateInput("00", 16, 280, 121, 21, BitOR($ES_AUTOHSCROLL, $ES_READONLY))
Global $nptH_Green = GUICtrlCreateInput("00", 16, 304, 121, 21, BitOR($ES_AUTOHSCROLL, $ES_READONLY))
Global $nptH_Blue = GUICtrlCreateInput("00", 16, 328, 121, 21, BitOR($ES_AUTOHSCROLL, $ES_READONLY))
Global $lblH_Red = GUICtrlCreateLabel("Red Color Hex.  (Range 00 - FF)", 152, 282, 178, 17)
Global $lblH_Green = GUICtrlCreateLabel("Green Color Hex.  (Range 00 - FF)", 152, 306, 187, 17)
Global $lblH_Blue = GUICtrlCreateLabel("Blue Color Hex.  (Range 00 - FF)", 152, 330, 179, 17)
GUICtrlCreateGroup("", -99, -99, 1, 1)
Global $grpNptVec = GUICtrlCreateGroup("Vector Color Values", 8, 368, 385, 105)
Global $nptV_Red = GUICtrlCreateInput("0.0000", 16, 392, 121, 21, BitOR($ES_AUTOHSCROLL, $ES_READONLY))
Global $nptV_Green = GUICtrlCreateInput("0.0000", 16, 416, 121, 21, BitOR($ES_AUTOHSCROLL, $ES_READONLY))
Global $nptV_Blue = GUICtrlCreateInput("0.0000", 16, 440, 121, 21, BitOR($ES_AUTOHSCROLL, $ES_READONLY))
Global $lblV_Red = GUICtrlCreateLabel("Red Color Vector.  (Range 0 - 1)", 152, 394, 156, 17)
Global $lblV_Green = GUICtrlCreateLabel("Green Color Vector.  (Range 0 - 1)", 152, 418, 165, 17)
Global $lblV_Blue = GUICtrlCreateLabel("Blue Color Vector.  (Range 0 - 1)", 152, 442, 157, 17)
GUICtrlCreateGroup("", -99, -99, 1, 1)
Global $btnExit = GUICtrlCreateButton("E&xit", 16, 504, 369, 41, 0)
Global $grpRdoStrt = GUICtrlCreateGroup("Starting Values", 8, 8, 385, 57)
Global $rdoInteger = GUICtrlCreateRadio("Integer", 16, 32, 113, 17)
GUICtrlSetState(-1, $GUI_CHECKED)
Global $rdoHex = GUICtrlCreateRadio("Hex", 136, 32, 113, 17)
Global $rdoVector = GUICtrlCreateRadio("Vector", 272, 32, 113, 17)
GUICtrlCreateGroup("", -99, -99, 1, 1)
Global $mnuMainFile = GUICtrlCreateMenu("&File")
Global $mnuGo = GUICtrlCreateMenuItem("&Calculate", $mnuMainFile)
Global $mnuSpacer = GUICtrlCreateMenuItem("", $mnuMainFile)
Global $mnuExit = GUICtrlCreateMenuItem("E&xit", $mnuMainFile)
Global $mnuMainHelp = GUICtrlCreateMenu("&Help")
;~ GUICtrlSetState(-1, $GUI_DISABLE)
Global $mnuHelp = GUICtrlCreateMenuItem("&Help     F1", $mnuMainHelp)
Global $mnuAbout = GUICtrlCreateMenuItem("&About", $mnuMainHelp)
GUISetState(@SW_SHOW)
GUISetHelp('Notepad "' & @ScriptDir & '\help.txt"')
Global $nMsg
#EndRegion ### END Koda GUI section ###
#region Primary Data Loop
While 1
    $nMsg = GUIGetMsg()
    Switch $nMsg
        Case $GUI_EVENT_CLOSE, $btnExit, $mnuExit
            Exit
        Case $rdoHex, $rdoInteger, $rdoVector
            _ChangeInputs($nMsg)
        Case $mnuGo, $btnGo
            _Calculate()
        Case $mnuAbout
            _About()
        Case $mnuHelp
            ShellExecute(@ScriptDir & "\help.txt")
    EndSwitch
WEnd
Exit
#endregion
#region Function List
#region Function: _ChangeInputs
Func _ChangeInputs($guiMSG)
    Switch $guiMSG
        Case $rdoHex
            ; default style : GuiCtrlSetStyle(-1, 0x50010080, 0x00000200)
            ; read-only style : GuiCtrlSetStyle(-1, 0x50010880, 0x00000200)
            GUICtrlSetStyle($nptBlue, 0x50010880, 0x00000200)
            GUICtrlSetStyle($nptGreen, 0x50010880, 0x00000200)
            GUICtrlSetStyle($nptRed, 0x50010880, 0x00000200)
            GUICtrlSetStyle($nptH_Red, 0x50010080, 0x00000200)
            GUICtrlSetStyle($nptH_Green, 0x50010080, 0x00000200)
            GUICtrlSetStyle($nptH_Blue, 0x50010080, 0x00000200)
            GUICtrlSetStyle($nptV_Blue, 0x50010880, 0x00000200)
            GUICtrlSetStyle($nptV_Green, 0x50010880, 0x00000200)
            GUICtrlSetStyle($nptV_Red, 0x50010880, 0x00000200)
            GUICtrlSetData($grpNptHex, "Hex Color Entry")
            GUICtrlSetData($grpNptInt, "Integer Color Values")
            GUICtrlSetData($grpNptVec, "Vector Color Values")
            _ClearData()
        Case $rdoInteger
            GUICtrlSetStyle($nptBlue, 0x50010080, 0x00000200)
            GUICtrlSetStyle($nptGreen, 0x50010080, 0x00000200)
            GUICtrlSetStyle($nptRed, 0x50010080, 0x00000200)
            GUICtrlSetStyle($nptH_Red, 0x50010880, 0x00000200)
            GUICtrlSetStyle($nptH_Green, 0x50010880, 0x00000200)
            GUICtrlSetStyle($nptH_Blue, 0x50010880, 0x00000200)
            GUICtrlSetStyle($nptV_Blue, 0x50010880, 0x00000200)
            GUICtrlSetStyle($nptV_Green, 0x50010880, 0x00000200)
            GUICtrlSetStyle($nptV_Red, 0x50010880, 0x00000200)
            GUICtrlSetData($grpNptHex, "Hex Color Values")
            GUICtrlSetData($grpNptInt, "Integer Color Entry")
            GUICtrlSetData($grpNptVec, "Vector Color Values")
            _ClearData()
        Case $rdoVector
            GUICtrlSetStyle($nptBlue, 0x50010880, 0x00000200)
            GUICtrlSetStyle($nptGreen, 0x50010880, 0x00000200)
            GUICtrlSetStyle($nptRed, 0x50010880, 0x00000200)
            GUICtrlSetStyle($nptH_Red, 0x50010880, 0x00000200)
            GUICtrlSetStyle($nptH_Green, 0x50010880, 0x00000200)
            GUICtrlSetStyle($nptH_Blue, 0x50010880, 0x00000200)
            GUICtrlSetStyle($nptV_Blue, 0x50010080, 0x00000200)
            GUICtrlSetStyle($nptV_Green, 0x50010080, 0x00000200)
            GUICtrlSetStyle($nptV_Red, 0x50010080, 0x00000200)
            GUICtrlSetData($grpNptHex, "Hex Color Values")
            GUICtrlSetData($grpNptInt, "Integer Color Values")
            GUICtrlSetData($grpNptVec, "Vector Color Entry")
            _ClearData()
    EndSwitch
EndFunc   ;==>_ChangeInputs
#endregion
#region Function: _Calculate()
Func _Calculate()
    Local $red, $blue, $green, $rdoCheck
    If ControlCommand($frmGUIMain, "", $rdoHex, "IsChecked", "") = 1 Then $rdoCheck = "hex" 
    If ControlCommand($frmGUIMain, "", $rdoInteger, "IsChecked", "") = 1 Then $rdoCheck = "int" 
    If ControlCommand($frmGUIMain, "", $rdoVector, "IsChecked", "") = 1 Then $rdoCheck = "vec" 
    Switch $rdoCheck
        Case "hex" 
            $blue = StringRight(GUICtrlRead($nptH_Blue), 2)
            $green = StringRight(GUICtrlRead($nptH_Green), 2)
            $red = StringRight(GUICtrlRead($nptH_Red), 2)
            While StringLen($blue) < 2
                Sleep(10)
                $blue = "0" & $blue
            WEnd
            If Dec($blue) = 0 Then $blue = "00" 
            If "0x" & $blue > 0xFF Then $blue = "FF" 
            If "0x" & $blue < 0x00 Then $blue = "00" 
            While StringLen($green) < 2
                Sleep(10)
                $green = "0" & $green
            WEnd
            If Dec($green) = 0 Then $green = "00" 
            If "0x" & $green > 0xFF Then $green = "FF" 
            If "0x" & $green < 0x00 Then $green = "00" 
            While StringLen($red) < 2
                Sleep(10)
                $red = "0" & $red
            WEnd
            If Dec($red) = 0 Then $red = "00" 
            If "0x" & $red > 0xFF Then $red = "FF" 
            If "0x" & $red < 0x00 Then $red = "00" 
            GUICtrlSetData($nptBlue, Dec($blue))
            GUICtrlSetData($nptGreen, Dec($green))
            GUICtrlSetData($nptRed, Dec($red))
            GUICtrlSetData($nptH_Blue, $blue)
            GUICtrlSetData($nptH_Green, $green)
            GUICtrlSetData($nptH_Red, $red)
            GUICtrlSetData($nptV_Blue, StringFormat("%.4f", StringLeft(Dec($blue) / 255, 6)))
            GUICtrlSetData($nptV_Green, StringFormat("%.4f", StringLeft(Dec($green) / 255, 6)))
            GUICtrlSetData($nptV_Red, StringFormat("%.4f", StringLeft(Dec($red) / 255, 6)))
        Case "int" 
            $blue = Int(GUICtrlRead($nptBlue))
            $green = Int(GUICtrlRead($nptGreen))
            $red = Int(GUICtrlRead($nptRed))
            If $blue > 255 Then $blue = 255
            If $blue < 0 Then $blue = 0
            If $green > 255 Then $green = 255
            If $green < 0 Then $green = 0
            If $red > 255 Then $red = 255
            If $red < 0 Then $red = 0
            GUICtrlSetData($nptBlue, $blue)
            GUICtrlSetData($nptGreen, $green)
            GUICtrlSetData($nptRed, $red)
            GUICtrlSetData($nptH_Blue, Hex($blue, 2))
            GUICtrlSetData($nptH_Green, Hex($green, 2))
            GUICtrlSetData($nptH_Red, Hex($red, 2))
            GUICtrlSetData($nptV_Blue, StringFormat("%.4f", StringLeft($blue / 255, 6)))
            GUICtrlSetData($nptV_Green, StringFormat("%.4f", StringLeft($green / 255, 6)))
            GUICtrlSetData($nptV_Red, StringFormat("%.4f", StringLeft($red / 255, 6)))
        Case "vec" 
            $blue = StringLeft(GUICtrlRead($nptV_Blue), 6)
            $green = StringLeft(GUICtrlRead($nptV_Green), 6)
            $red = StringLeft(GUICtrlRead($nptV_Red), 6)
            $blue = StringFormat("%.6f", $blue)
            $green = StringFormat("%.6f", $green)
            $red = StringFormat("%.6f", $red)
            If $blue > 1 Then $blue = 1
            If $blue < 0 Then $blue = 0
            If $green > 1 Then $green = 1
            If $green < 0 Then $green = 0
            If $red > 1 Then $red = 1
            If $red < 0 Then $red = 0
            GUICtrlSetData($nptBlue, Int($blue * 255))
            GUICtrlSetData($nptGreen, Int($green * 255))
            GUICtrlSetData($nptRed, Int($red * 255))
            GUICtrlSetData($nptH_Blue, Hex(Int($blue * 255), 2))
            GUICtrlSetData($nptH_Green, Hex(Int($green * 255), 2))
            GUICtrlSetData($nptH_Red, Hex(Int($red * 255), 2))
            $blue = StringFormat("%.4f", $blue)
            $green = StringFormat("%.4f", $green)
            $red = StringFormat("%.4f", $red)
            GUICtrlSetData($nptV_Blue, $blue)
            GUICtrlSetData($nptV_Green, $green)
            GUICtrlSetData($nptV_Red, $red)
    EndSwitch
EndFunc   ;==>_Calculate
#endregion
#region Function: _ClearData()
Func _ClearData()
    GUICtrlSetData($nptBlue, "0")
    GUICtrlSetData($nptGreen, "0")
    GUICtrlSetData($nptRed, "0")
    GUICtrlSetData($nptH_Blue, "00")
    GUICtrlSetData($nptH_Green, "00")
    GUICtrlSetData($nptH_Red, "00")
    GUICtrlSetData($nptV_Blue, "0.0000")
    GUICtrlSetData($nptV_Green, "0.0000")
    GUICtrlSetData($nptV_Red, "0.0000")
EndFunc   ;==>_ClearData
#endregion
#region Function _About()
Func _About()
    #Region ### START Koda GUI section ### Form=C:\Documents and Settings\U256655\Desktop\AutoIt\User Scripts\SL Vector Calc\frmAbout.kxf
    Local $winSize = WinGetPos($frmGUIMain)
    Local $frmAbout = GUICreate("About", 190, 300, $winSize[0] + ($winSize[2] / 2) - 95, $winSize[1] + ($winSize[3] / 2) - 150, $WS_CLIPSIBLINGS, -1, $frmGUIMain)
    Local $picLogo = GUICtrlCreatePic(@ScriptDir & "\sl-logo.jpg", 24, 8, 137, 121, BitOR($SS_NOTIFY, $WS_GROUP, $WS_CLIPSIBLINGS))
    Local $btnOK = GUICtrlCreateButton("&Ok", 40, 225, 105, 33, 0)
    Local $lblLLCpy = GUICtrlCreateLabel("Second Life Copyright:" & @LF & "Linden Labs", 24, 136, 140, 33, BitOR($SS_CENTER, $SS_SUNKEN))
    Local $Label1 = GUICtrlCreateLabel("Calculator by:" & @LF & "The Blue Drache", 24, 176, 139, 33, BitOR($SS_CENTER, $SS_SUNKEN))
    Local $nMSG2
    GUISetState(@SW_SHOW)
    #EndRegion ### END Koda GUI section ###
    While 1
        Sleep(10)
        If Not WinActive($frmAbout) Then ExitLoop
        $nMSG2 = GUIGetMsg()
        Switch $nMSG2
            Case $btnOK
                ExitLoop
        EndSwitch
    WEnd
    GUIDelete($frmAbout)
EndFunc   ;==>_About
#endregion
#region Function: _GPL()
Func _GPL()
    If Not FileExists(@ScriptDir & "\GNU-PLv2.txt") Then FileInstall("C:\Documents and Settings\U256655\Desktop\AutoIt\User Scripts\GNU-PLv2.txt", @ScriptDir & "\", 1)
EndFunc   ;==>_GPL
#endregion
#endregion