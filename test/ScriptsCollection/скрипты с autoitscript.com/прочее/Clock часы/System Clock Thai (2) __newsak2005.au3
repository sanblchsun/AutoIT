; newsak2005
; http://www.autoitscript.com/forum/topic/131155-system-clock-thai/page__hl__+_hkexit#entry913943
#include <GUIConstantsEx.au3>
#include <StaticConstants.au3>
#include <WindowsConstants.au3>
#Include <Date.au3>
#cs=======================
createdate: 7/28/2011
filetype: screensaver
filename: countertimer.au3
design by:sak2005
#ce=======================
AutoItSetOption ( "MustDeclareVars", 1)
HotKeySet("{ESC}", "_hkExit")
Global $title = 'CounterTimer'

GUICreate($title, @DesktopWidth, @DesktopHeight,-1, -1)
GUISetBkColor(0x000000)
GUICtrlCreateLabel("00", 350, 300, 70, 50, BitOR($SS_CENTER,$SS_CENTERIMAGE))
GUICtrlSetFont(-1, 50, 400, 0, "Arial")
GUICtrlSetColor(-1, 0xFFFFFF)
GUICtrlCreateLabel(":", 420, 295, 18, 50, BitOR($SS_CENTER,$SS_CENTERIMAGE))
GUICtrlSetFont(-1, 50, 400, 0, "Arial")
GUICtrlSetColor(-1, 0xFFFFFF)
GUICtrlCreateLabel("00", 440, 300, 70, 50, BitOR($SS_CENTER,$SS_CENTERIMAGE))
GUICtrlSetFont(-1, 50, 400, 0, "Arial")
GUICtrlSetColor(-1, 0xFFFFFF)
GUICtrlCreateLabel(":", 515, 295, 12, 50, BitOR($SS_CENTER,$SS_CENTERIMAGE))
GUICtrlSetFont(-1, 50, 400, 0, "Arial")
GUICtrlSetColor(-1, 0xFFFFFF)
GUICtrlCreateLabel("00", 535, 300, 70, 50, BitOR($SS_CENTER,$SS_CENTERIMAGE))
GUICtrlSetFont(-1, 50, 400, 0, "Arial")
GUICtrlSetColor(-1, 0xFFFFFF)
GUICtrlCreateLabel("STANDBY", 380, 225, 200, 50, BitOR($SS_CENTER,$SS_CENTERIMAGE))
GUICtrlSetFont(-1, 30, 400, 0, "Arial")
GUICtrlSetColor(-1, 0xFFFFFF)
GUICtrlCreateLabel("[Press Key Esc to Exit]", 350, 380, 250, 30, BitOR($SS_CENTER,$SS_CENTERIMAGE))
GUICtrlSetFont(-1, 10, 400, 0, "Arial")
GUICtrlSetColor(-1, 0xFFFFFF)
GUICtrlCreateLabel("(Create by : sak2005)", 750, 720, 250, 30, BitOR($SS_CENTER,$SS_CENTERIMAGE))
GUICtrlSetFont(-1, 8, 400, 0, "Arial")
GUICtrlSetColor(-1, 0xFFFFFF)
GUICtrlCreateLabel(_Now(), 750, 700, 250, 30, BitOR($SS_CENTER,$SS_CENTERIMAGE))
GUICtrlSetFont(-1, 12, 600, 0, "Arial")
GUICtrlSetColor(-1, 0xFFFFFF)
GUICtrlCreatePic(@ProgramFilesDir&"\AutoIt3\Examples\GUI\mslogo.jpg", 350, 150, 255, 40)
GUISetState(@SW_SHOW)

AdlibRegister("_timer", 1000)
For $j = 0 To 60
    ControlSetText($title, "", 3, $j)
    For $i = 0 To 59
        ControlSetText($title, "", 5, $i)
        For $x = 0 to 59
            ControlSetText($title, "", 7, $x)
            Sleep(333.33)
            ControlHide($title, "", 6)
            Sleep(333.33)
            ControlShow($title, "", 6)
            Sleep(333.33)
        Next
    Next
Next

Func _timer()
    Local $day, $halftime
    Switch @WDAY
        Case 1
            $day = 'Su'
        Case 2
            $day = 'Mo'
        Case 3
            $day = 'Tu'
        Case 4
            $day = 'We'
        Case 5
            $day = 'Th'
        Case 6
            $day = 'Fr'
        Case 7
            $day = 'Sa'
    EndSwitch
    If @HOUR >= 12 Then
        $halftime = 'PM'
    Else
        $halftime = 'AM'
    EndIf
    ControlSetText($title, "", 11, $day&'/'&_Now()&' :'&$halftime)
EndFunc

Func _hkExit()
    Exit
EndFunc