; BananaFredSoft
; http://www.autoitscript.com/forum/topic/57118-bananaclock/
#include <GUIConstants.au3>
#include <Sound.au3>
#include <GUIConstantsEx.au3>
#include <WindowsConstants.au3>
#NoTrayIcon

$menuexists = 0
$transparency = "null"
$ontop = "null"
$menu = "null"
$AlarmActivated = PR("Alarm", "Activated", 0)
$AlarmTime = PR("Alarm", "Time", "12:00")
$alarmwentoff = 0
$AmPmAlarm = PR("Alarm", "AMPM", "PM")
$timerguion = 0
$timerpausebutton = "null"
$timing = 0

If PR("Main", "First", 1) = 1 Then
    If MsgBox(4, "BananaClock", "Would you like BananaClock to automatically launch when you log on?") = 6 Then
        FileCreateShortcut(@ScriptFullPath, @StartupDir & "\BananaClock.lnk")
    EndIf
    IniWrite(@ScriptDir & "\BananaClockPrefs.data", "Main", "First", 0)
EndIf

#Region ### START Koda GUI section ### Form=
$Form1 = GUICreate("BananaClock", 188, 87, PR("Window", "XPosition", -1), PR("Window", "YPosition", -1), -1, $WS_EX_TOPMOST)
$Time = GUICtrlCreateLabel(CalcTime(PR("Time", "Format", 1)) , 8, 8, 203, 55)
GUICtrlSetFont(-1, 34)
$Date = GUICtrlCreateLabel(CalcDate(PR("Date", "Format", 1)), 50, 56, 93, 17)
GUICtrlSetFont(-1, 14)
GUISetState(@SW_SHOW)
#EndRegion ### END Koda GUI section ###

$title = WinGetTitle("")
$transpv = PR("Window", "Transparency", 255)
WinSetTrans($title, "", $transpv)

While 1
    $nMsg = GUIGetMsg()
    Switch $nMsg
        Case $GUI_EVENT_CLOSE
            Exit
        Case $timerpausebutton
            If $timing = 1 Then
                $timing = 0
            Else
                $timing = 1
            EndIf
    EndSwitch
    If $timerguion = 1 Then
        If $timing = 1 Then
            If @SEC <> $prevsec Then
                $timertimereamaining -= 1
                $mins = ($timertimereamaining - Mod($timertimereamaining, 60)) / 60
                $secs = FIX(Mod($timertimereamaining, 60))
                GUICtrlSetData($timelabel, $mins & ":" & $secs)
                $prevsec = @SEC
            EndIf
            If $timertimereamaining < 1 Then
                $c = 0
                Do
                    $msg = MsgBox(0, "BananaClock", "Your timer is up!", 1)
                    $c += 1
                Until BitOR($msg <> -1, $c > 19)
                GUIDelete($timergui)
                $timerguion = 0
                $timing = 0
            EndIf
        EndIf
    EndIf
    If $menuexists Then
        Switch $nMsg
            Case $transparency
                TranspSet($transpv)
            Case $prefs
                Prefs()
            Case $alarm
                SetAlarm()
            Case $timer
                SetTimer()
        EndSwitch
    EndIf
    If CalcTime(PR("Time", "Format", 1)) <> GUICtrlRead($Time) Then
        GUICtrlSetData($Time, CalcTime(PR("Time", "Format", 1)))
    EndIf
    If CalcDate(PR("Date", "Format", 1)) <> GUICtrlRead($Date) Then
        GUICtrlSetData($Date, CalcDate(PR("Data", "Format", 1)))
    EndIf
    If BitAND($menuexists = 0, MouseIsOnGUI() = 1) Then
        $menu = GUICtrlCreateMenu("Menu")
        $transparency = GUICtrlCreateMenuItem("Transparency", $menu)
        $prefs = GUICtrlCreateMenuItem("Settings", $menu)
        $alarm = GUICtrlCreateMenuItem("Alarm", $menu)
        $timer = GUICtrlCreateMenuItem("Timer", $menu)
        $menuexists = 1
    EndIf
    If BitAND($AlarmActivated = 1, $alarmwentoff = 0) Then
        If CalcTime(1) = $AlarmTime & " " & $AmPmAlarm Then
            MsgBox(0, "BananaClock", "Your alarm has been activated! It is " & $AlarmTime, 5)
            If PR("Alarm", "SoundSetting", 1) = 1 Then
                $i = 0
                Do
                    Beep(1000, 1000)
                    $msg = MsgBox(0, "BananaClock", "Your alarm is going off!", 1)
                    $i += 1
                Until BitOR($i = 10, $msg <> -1)
                $alarmwentoff = 1
            Else
                $sound = _SoundOpen(PR("Alarm", "SndSettingDetail", 0))
                _SoundPlay($sound)
                MsgBox(0, "BananaClock", "Your alarm is going off!", 20)
                _SoundStop($sound)
                _SoundClose($sound)
                $alarmwentoff = 1
            EndIf
        EndIf
    EndIf
    If BitAND(Mod(@HOUR, 12) & ":" & @MIN <> $AlarmTime, $alarmwentoff = 1) Then
        $alarmwentoff = 0
    EndIf
    If BitAND($menuexists = 1, MouseIsOnGUI() = 0) Then
        GUICtrlDelete($menu)
        GUICtrlDelete($transparency)
        GUICtrlDelete($prefs)
        GUICtrlDelete($alarm)
        GUICtrlDelete($timer)
        $menuexists = 0
    EndIf
    $wgPos = WinGetPos($title)
WEnd

Func CalcTime ($format)
    If $format = 1 Then
        If @HOUR > 12 Then
            $ap = "PM"
        Else
            $ap = "AM"
        EndIf
        Return Mod(@HOUR, 12) & ":" & @MIN & " " & $ap
    Else
        Return @HOUR & ":" & @MIN
    EndIf
EndFunc

Func PR ($s, $k, $d)
    Return IniRead(@ScriptDir & "\BananaClockPrefs.data", $s, $k, $d)
EndFunc

Func CalcDate ($format)
    If $format = 1 Then
        Return @MON & "/" & @MDAY & "/" & @YEAR
    Else
        Return @MDAY & "/" & @MON & "/" & @YEAR
    EndIf
EndFunc

Func MouseIsOnGUI ()
    $mousepos = MouseGetPos()
    $guipos = WinGetPos($title)
    If BitAND($mousepos[0] > $guipos[0], $mousepos[0] < $guipos[0] + $guipos[2], $mousepos[1] > $guipos[1], $mousepos[1] < $guipos[1] + $guipos[3]) Then
        Return 1
    Else
        Return 0
    EndIf
EndFunc

Func TranspSet ($default)
    #Region ### START Koda GUI section ### Form=
    $Form2 = GUICreate("Transparency", 336, 51)
    $Slider1 = GUICtrlCreateSlider(8, 8, 321, 33)
    GUICtrlSetLimit($Slider1, 255, 1)
    GUICtrlSetData($Slider1, $default)
    GUISetState(@SW_SHOW)
    GUISwitch($Form2)
    #EndRegion ### END Koda GUI section ###

    While 1
        $nMsg = GUIGetMsg()
        Switch $nMsg
            Case $GUI_EVENT_CLOSE
                GUIDelete($Form2)
                GUISwitch($Form1)
                Return
            Case $Slider1
                WinSetTrans($title, "", GUICtrlRead($Slider1))
                Global $transpv = GUICtrlRead($Slider1)
        EndSwitch
    WEnd
EndFunc

Func OnAutoItExit ()
    IniWrite(@ScriptDir & "\BananaClockPrefs.data", "Window", "Transparency", $transpv)
    IniWrite(@ScriptDir & "\BananaClockPrefs.data", "Window", "XPosition", $wgPos[0])
    IniWrite(@ScriptDir & "\BananaClockPrefs.data", "Window", "YPosition", $wgPos[1])
EndFunc

Func Prefs ()
    #Region ### START Koda GUI section ### Form=
    $Form3 = GUICreate("Settings", 254, 173, 193, 115)
    GUISwitch($Form3)
    $Group1 = GUICtrlCreateGroup("Time/Date Format", 8, 8, 241, 105)
    GUIStartGroup()
    $Radio1 = GUICtrlCreateRadio("Normal Clock", 24, 32, 89, 17)
    $Radio2 = GUICtrlCreateRadio("24 Hour Clock", 120, 32, 97, 17)
    If PR("Time", "Format", 1) = 1 Then
        GUICtrlSetState($Radio1, $GUI_CHECKED)
    Else
        GUICtrlSetState($Radio2, $GUI_CHECKED)
    EndIf
    GUIStartGroup()
    $Radio3 = GUICtrlCreateRadio("MM/DD/YY", 24, 80, 81, 17)
    $Radio4 = GUICtrlCreateRadio("DD/MM/YY", 120, 80, 113, 17)
    If PR("Date", "Format", 1) = 1 Then
        GUICtrlSetState($Radio3, $GUI_CHECKED)
    Else
        GUICtrlSetState($Radio4, $GUI_CHECKED)
    EndIf
    GUIStartGroup()
    GUICtrlCreateGroup("", -99, -99, 1, 1)
    $Apply = GUICtrlCreateButton("Apply", 8, 125, 238, 40)
    GUISetState(@SW_SHOW)
    #EndRegion ### END Koda GUI section ###

    While 1
        $nMsg = GUIGetMsg()
        Switch $nMsg
            Case $GUI_EVENT_CLOSE
                GUIDelete($Form3)
                GUISwitch($Form1)
                Return
            Case $Apply
                If GUICtrlRead($Radio1) = $GUI_CHECKED Then
                    IniWrite(@ScriptDir & "\BananaClockPrefs.data", "Time", "Format", 1)
                Else
                    IniWrite(@ScriptDir & "\BananaClockPrefs.data", "Time", "Format", 2)
                EndIf
                If GUICtrlRead($Radio3) = $GUI_CHECKED Then
                    IniWrite(@ScriptDir & "\BananaClockPrefs.data", "Date", "Format", 1)
                Else
                    IniWrite(@ScriptDir & "\BananaClockPrefs.data", "Date", "Format", 2)
                EndIf
                GUIDelete($Form3)
                GUISwitch($Form1)
                Return
        EndSwitch
    WEnd
EndFunc

Func RSPlit ($string, $delimiter, $num)
    $split = StringSplit($string, $delimiter)
    Return $split[$num]
EndFunc

Func getdir($filename)
    $split = StringSplit($filename, "\")
    If Not @error Then
        $dir = ""
        $num = 1
        Do
            $dir &= $split[$num] & "\"
            $num += 1
        Until $num = $split[0]
        Return $dir
    EndIf
EndFunc   ;==>getdir

Func getfile($filename2)
    Return StringReplace($filename2, getdir($filename2), "")
EndFunc

Func SetTimer()
    #Region ### START Koda GUI section ### Form=
    $Form5 = GUICreate("Timer", 264, 142, 193, 115)
    $Checkbox1 = GUICtrlCreateCheckbox("Timer is Activated", 8, 8, 105, 25)
    $tMin = GUICtrlCreateInput("5", 96, 40, 41, 21)
    $Label1 = GUICtrlCreateLabel("Minutes:Seconds", 8, 40, 86, 17)
    $Label2 = GUICtrlCreateLabel(":", 144, 40, 7, 17)
    $tSec = GUICtrlCreateInput("00", 152, 40, 41, 21)
    $Button1 = GUICtrlCreateButton("Reset Timer", 8, 72, 249, 33, 0)
    $Button2 = GUICtrlCreateButton("OK", 8, 112, 65, 25, 0)
    GUISetState(@SW_SHOW)
    #EndRegion ### END Koda GUI section ###

    While 1
        $nMsg = GUIGetMsg()
        Switch $nMsg
            Case $GUI_EVENT_CLOSE
                GUIDelete($Form5)
                GUISwitch($Form1)
                Return
            Case $Button2
                If GUICtrlRead($Checkbox1) = $GUI_CHECKED Then
                    Global $timing = 1
                    Global $timertimereamaining = (GUICtrlRead($tMin) * 60) + GUICtrlRead($tSec)
                    Global $timergui = GUICreate("Timer", 188, 87, $wgPos[0], $wgPos[1] + $wgPos[3], -1, $WS_EX_TOPMOST)
                    Global $timelabel = GUICtrlCreateLabel(GUICtrlRead($tMin) & ":" & GUICtrlRead($tSec), 8, 8, 203, 50)
                    GUICtrlSetFont(-1, 34)
                    Global $timerpausebutton = GUICtrlCreateButton("Stop/Start", 50, 56, 93, 17)
                    GUISetState(@SW_SHOW)
                    Global $timerguion = 1
                    Global $prevsec = @SEC
                Else
                    Global $timing = 0
                    If $timerguion = 1 Then
                        GUIDelete($timergui)
                    EndIf
                EndIf
                GUIDelete($Form5)
                GUISwitch($Form1)
                Return
            Case $Button1
                Global $timertimereamaining = (GUICtrlRead($tMin) * 60) + GUICtrlRead($tSec)
                Global $prevsec = @SEC
        EndSwitch
    WEnd
EndFunc

Func SetAlarm()
    $calarm = PR("Alarm", "Time", "12:00")
    $alarmison = PR("Alarm", "Activated", 0)
    $sndsetting = PR("Alarm", "SoundSetting", 1)
    $snddetail = PR("Alarm", "SndSettingDetail", 0)
    $amp = PR("Alarm", "AMPM", "PM")
    #Region ### START Koda GUI section ### Form=
    $Form4 = GUICreate("Alarm", 176, 160, 193, 115)
    $Group1 = GUICtrlCreateGroup("Alarm", 8, 8, 161, 73)
    $Checkbox1 = GUICtrlCreateCheckbox("Alarm Is On", 16, 24, 97, 17)
    If $alarmison = 1 Then
        GUICtrlSetState($Checkbox1, $GUI_CHECKED)
    EndIf
    $Hour = GUICtrlCreateInput(RSPlit($calarm, ":", 1), 40, 48, 33, 21)
    $Label1 = GUICtrlCreateLabel(":", 80, 48, 7, 17)
    $Min = GUICtrlCreateInput(RSPlit($calarm, ":", 2), 88, 48, 41, 21)
    GUICtrlCreateGroup("", -99, -99, 1, 1)
    $Radio1 = GUICtrlCreateRadio("Beep", 8, 88, 65, 17)
    $Radio2 = GUICtrlCreateRadio("Play File: " & getfile($snddetail), 8, 112, 65, 17)
    If $sndsetting = 1 Then
        GUICtrlSetState($Radio1, $GUI_CHECKED)
    Else
        GUICtrlSetState($Radio2, $GUI_CHECKED)
    EndIf
    $Browse = GUICtrlCreateButton("Browse for File", 80, 112, 81, 17, 0)
    $OKButton = GUICtrlCreateButton("OK", 8, 136, 81, 17, 0)
    $CancelButton = GUICtrlCreateButton("Cancel", 96, 136, 73, 17, 0)
    $AM = GUICtrlCreateRadio("AM", 132, 16)
    $PM = GUICtrlCreateRadio("PM", 132, 37)
    If $amp = "PM" Then
        GUICtrlSetState($PM, $GUI_CHECKED)
    Else
        GUICtrlSetState($AM, $GUI_CHECKED)
    EndIf
    GUISetState(@SW_SHOW)
    #EndRegion ### END Koda GUI section ###

    While 1
        $nMsg = GUIGetMsg()
        Switch $nMsg
            Case $GUI_EVENT_CLOSE
                GUIDelete($Form4)
                GUISwitch($Form1)
                Return
            Case $CancelButton
                GUIDelete($Form4)
                GUISwitch($Form1)
                Return
            Case $Browse
                $file = FileOpenDialog("Locate Audio File", "", "Wave Audio Files (*.wav);MP3 Audio Files (*.mp3)")
                If FileExists($file) Then
                    $snddetail = $file
                    GUICtrlSetData($Radio2, "Play File: " & getfile($file))
                EndIf
            Case $OKButton
                If GUICtrlRead($Radio1) = $GUI_CHECKED Then
                    IniWrite(@ScriptDir & "\BananaClockPrefs.data", "Alarm", "SoundSetting", 1)
                Else
                    IniWrite(@ScriptDir & "\BananaClockPrefs.data", "Alarm", "SoundSetting", 2)
                EndIf
                If GUICtrlRead($Checkbox1) = $GUI_CHECKED Then
                    IniWrite(@ScriptDir & "\BananaClockPrefs.data", "Alarm", "Activated", 1)
                Else
                    IniWrite(@ScriptDir & "\BananaClockPrefs.data", "Alarm", "Activated", 0)
                EndIf
                IniWrite(@ScriptDir & "\BananaClockPrefs.data", "Alarm", "SndSettingDetail", $snddetail)
                IniWrite(@ScriptDir & "\BananaClockPrefs.data", "Alarm", "Time", GUICtrlRead($Hour) & ":" & GUICtrlRead($Min))
                If GUICtrlRead($AM) = $GUI_CHECKED Then
                    IniWrite(@ScriptDir & "\BananaClockPrefs.data", "Alarm", "AMPM", "AM")
                Else
                    IniWrite(@ScriptDir & "\BananaClockPrefs.data", "Alarm", "AMPM", "PM")
                EndIf
                $AlarmActivated = PR("Alarm", "Activated", 0)
                $AlarmTime = PR("Alarm", "Time", "12:00")
                $AmPmAlarm = PR("Alarm", "AMPM", "PM")
                GUIDelete($Form4)
                GUISwitch($Form1)
                Return
        EndSwitch
    WEnd
EndFunc

Func FIX ($string)
    If StringLen($string) = 1 Then
        Return "0" & $string
    Else
        Return $string
    EndIf
EndFunc