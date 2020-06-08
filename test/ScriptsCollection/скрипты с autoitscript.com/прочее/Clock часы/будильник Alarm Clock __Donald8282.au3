; Donald8282
; http://www.autoitscript.com/forum/topic/123475-alarm-clock
#include <GUIConstantsEx.au3>
#include <EditConstants.au3>
#include <WindowsConstants.au3>
#include <ComboConstants.au3>


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;Month and day setup;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
$month = @MON

If $month = 1 Then
$month = "January"
ElseIf $month = 2 Then
$month = "February"
ElseIf $month = 3 Then
$month = "March"
ElseIf $month = 4 Then
$month = "April"
ElseIf $month = 5 Then
$month = "May"
ElseIf $month = 6 Then
$month = "June"
ElseIf $month = 7 Then
$month = "July"
ElseIf $month = 8 Then
$month = "August"
ElseIf $month = 9 Then
$month = "September"
ElseIf $month = 10 Then
$month = "October"
ElseIf $month = 11 Then
$month = "November"
ElseIf $month = 12 Then
$month = "December"
EndIf

$day1 = @WDAY

If $day1 = 1 Then
    $day1 = "Sunday"
ElseIf $day1 = 2 Then
    $day1 = "Monday"
ElseIf $day1 = 3 Then
    $day1 = "Tuesday"
ElseIf $day1 = 4 Then
    $day1 = "Wednesday"
ElseIf $day1 = 5 Then
    $day1 = "Thursday"
ElseIf $day1 = 6 Then
    $day1 = "Friday"
ElseIf $day1 = 7 Then
    $day1 = "Saturday"
EndIf
    


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;Alarm GUI setup;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
$GUI = GUICreate($day1 & ", " & $month & " " & @MDAY & " " & @YEAR, 300, 140)
GUISetState()

GUICtrlCreateLabel("Hour:", 10, 13)
$HourCheck = ""
$Hour = GUICtrlCreateInput("1", 40, 10, 40, 20, $ES_READONLY)
GUICtrlSetBkColor($Hour, 0xFFFFFF)
GUICtrlCreateUpdown($Hour)

GUICtrlCreateLabel("Minute:", 90, 13)
$MinuteCheck = ""
$Minute = GUICtrlCreateInput("0", 130, 10, 40, 20, $ES_READONLY)
GUICtrlSetBkColor($Minute, 0xFFFFFF)
GUICtrlCreateUpdown($Minute)

GUICtrlCreateLabel("Day:", 10, 43)
$DayCheck = ""
$Day = GUICtrlCreateCombo("Choose a day", 40, 40, 90, 20)
GUICtrlSetData($Day, "Monday|Tuesday|Wednesday|Thursday|Friday|Saturday|Sunday")

$periodcheck = ""
$period = GUICtrlCreateCombo("AM", 130, 40, 40, 20)
GUICtrlSetData($period, "PM")

$OpenButton = GUICtrlCreateButton("Alarm Music", 220, 8, 70, 25)
$create = GUICtrlCreateButton("Create Alarm", 220, 38, 70, 25)

$songname = ""
$song = ""
$music = GUICtrlCreateLabel("Song - " & $song, 10, 70, 300, 40)


$TimerOn = 0

$savedMin = IniRead("Timer.ini", "Time", "Minutes", "0")
$savedTimerOn = IniRead("Timer.ini", "Time", "TimerOn", "0")
$SavedHour = IniRead("Timer.ini", "Time", "Hours", "1")
$SavedDay = IniRead("Timer.ini", "Time", "Day", "Monday")
$SavedDay2 = IniRead("Timer.ini", "Time", "Day2", "2")
$SavedSong = IniRead("Timer.ini", "Song", "Directory", "0")
$SavedPeriod = IniRead("Timer.ini", "Time", "Period", "AM")
$SavedMessage= IniRead("Timer.ini", "Message", "Message", "Chicken nuggets rule")


    $SongGet = ""
    $Hour1 = ""
    
    $GUIHour = ""
    $GUIMinute = ""
    $GUIDay = ""
    $GUIPeriod = ""

If FileExists(@ScriptDir & "/Timer.ini") then
    GUICtrlSetData($Hour, $SavedHour)
    
    GUICtrlSetData($Minute, $SavedMin)
    GUICtrlSetData($Day, $SavedDay)
    GUICtrlSetData($Music, $SavedSong)
    GUICtrlSetData($period, $SavedPeriod)
    
    $Day2 = $SavedDay2
    
    $message = $SavedMessage

    


    
    $TimerOn = $SavedTimerOn
    $Songget = $SavedSong
    
    
    
    
    $GUIMinute = GUICtrlRead($Minute)
    $GUIDay = GUICtrlRead($Day)
    $SongName = GUICtrlRead($music)
    $GUIPeriod = GUICtrlRead($period)
    
If $GUIPeriod = "PM" Then
    GUICtrlSetData($Hour, $SavedHour - 12)
Else
    GUICtrlSetData($Hour, $SavedHour)
EndIf
    
    $hour1 = $SavedHour
    
    
    
Else

EndIf



While 1
    sleep(10)
    $GUIHour = GUICtrlRead($Hour)
    $GUIMinute = GUICtrlRead($Minute)
    $GUIDay = GUICtrlRead($Day)
    $SongName = GUICtrlRead($music)
    $GUIPeriod = GUICtrlRead($period)
    


    

    
    
    If $GUIHour > 11 Then
        GUICtrlSetData($Hour, 12)
    ElseIf $GUIHour < 2 Then
        GUICtrlSetData($Hour, 1)
    EndIf
    
    If $GUIMinute > 58 Then
        GUICtrlSetData($Minute, 59)
    ElseIf $GUIMinute < 1 Then
        GUICtrlSetData($Minute, 0)
    EndIf


$msg = GUIGetMsg()
Select
Case $msg = $OpenButton
    $songGet = FileOpenDialog("Open...", @DesktopDir & "\", "Music(*.mp3)")
    If @error Then
        $songget = ""
        GUICtrlSetData($music, "Song - " & $songget)
    Else
    GUICtrlSetData($music, "Song - " & $songget)
EndIf
Case $msg = $GUI_EVENT_CLOSE
    Exit
Case $msg = $create
    
    $HourCheck = $GUIHour
    $MinuteCheck = $GUIMinute
    $DayCheck = $GUIDay
    $songname = $song
    $PeriodCheck = $GUIPeriod
    
    
    If $songget = "" Then
        MsgBox(0, "", "Please select a song.")
    Else
        $TimerOn = 1
    
    
        If $GUIDay = "Sunday" Then
        $Day2 = 1
    ElseIf $GUIDay = "Monday" Then
        $Day2 = 2
    ElseIf $GUIDay = "Tuesday" Then
        $Day2 = 3
    ElseIf $GUIDay = "Wednesday" Then
        $Day2 = 4
    ElseIf $GUIDay = "Thursday" Then
        $Day2 = 5
    ElseIf $GUIDay = "Friday" Then
        $Day2 = 6
    ElseIf $GUIDay = "Saturday" Then
        $Day2 = 7
    Else
        MsgBox(0, "", "Please select a day.")
    EndIf
    
    
    If $GUIHour = 1 And $GUIPeriod = "PM" Then
        $Hour1 = 12 + 1
    ElseIf $GUIHour = 2 And $GUIPeriod = "PM" Then
        $Hour1 = 12 + 2
    ElseIf $GUIHour = 3 And $GUIPeriod = "PM" Then
        $Hour1 = 12 + 3
    ElseIf $GUIHour = 4 And $GUIPeriod = "PM" Then
        $Hour1 = 12 + 4
    ElseIf $GUIHour = 5 And $GUIPeriod = "PM" Then
        $Hour1 = 12 + 5
    ElseIf $GUIHour = 6 And $GUIPeriod = "PM" Then
        $Hour1 = 12 + 6
    ElseIf $GUIHour = 7 And $GUIPeriod = "PM" Then
        $Hour1 = 12 + 7
    ElseIf $GUIHour = 8 And $GUIPeriod = "PM" Then
        $Hour1 = 12 + 8
    ElseIf $GUIHour = 9 And $GUIPeriod = "PM" Then
        $Hour1 = 12 + 9
    ElseIf $GUIHour = 10 And $GUIPeriod = "PM" Then
        $Hour1 = 12 + 10
    ElseIf $GUIHour = 11 And $GUIPeriod = "PM" Then
        $Hour1 = 12 + 11
    ElseIf $GUIHour = 12 And $GUIPeriod = "PM" Then
        $Hour1 = 12
        
    ElseIf $GUIHour = 1 And $GUIPeriod = "AM" Then
        $Hour1 = 1
    ElseIf $GUIHour = 2 And $GUIPeriod = "AM" Then
        $Hour1 = 2
    ElseIf $GUIHour = 3 And $GUIPeriod = "AM" Then
        $Hour1 = 3
    ElseIf $GUIHour = 4 And $GUIPeriod = "AM" Then
        $Hour1 = 4
    ElseIf $GUIHour = 5 And $GUIPeriod = "AM" Then
        $Hour1 = 5
    ElseIf $GUIHour = 6 And $GUIPeriod = "AM" Then
        $Hour1 = 6
    ElseIf $GUIHour = 7 And $GUIPeriod = "AM" Then
        $Hour1 = 7
    ElseIf $GUIHour = 8 And $GUIPeriod = "AM" Then
        $Hour1 = 8
    ElseIf $GUIHour = 9 And $GUIPeriod = "AM" Then
        $Hour1 = 9
    ElseIf $GUIHour = 10 And $GUIPeriod = "AM" Then
        $Hour1 = 10
    ElseIf $GUIHour = 11 And $GUIPeriod = "AM" Then
        $Hour1 = 11
    ElseIf $GUIHour = 12 And $GUIPeriod = "AM" Then
        $Hour1 = 12 - 12
    EndIf
    
    $message = InputBox("Message", "What would you like your alarm message to say?")
EndIf


IniWrite(@ScriptDir & "/Timer.ini", "Time", "Minutes", $GUIMinute)
IniWrite(@ScriptDir & "/Timer.ini", "Time", "TimerOn", $TimerOn)
IniWrite(@ScriptDir & "/Timer.ini", "Time", "Hours", $hour1)
IniWrite(@ScriptDir & "/Timer.ini", "Time", "Day", $GUIDay)
IniWrite(@ScriptDir & "/Timer.ini", "Time", "Day2", $Day2)
IniWrite(@ScriptDir & "/Timer.ini", "Song", "Directory", $SongGet)
IniWrite(@ScriptDir & "/Timer.ini", "Time", "Period", $GUIPeriod)
IniWrite(@ScriptDir & "/Timer.ini", "Message", "Message", $message)



EndSelect


    If $TimerOn = 1 And $GUIminute = @MIN And @SEC = 0 And $hour1 = @HOUR And $Day2 = @WDAY then
        SoundPlay($songget)
        MsgBox(0, "Alarm", $message)
    EndIf


WEnd