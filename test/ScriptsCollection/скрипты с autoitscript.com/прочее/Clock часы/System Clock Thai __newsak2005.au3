; newsak2005
; http://www.autoitscript.com/forum/topic/131155-system-clock-thai
;Hide tray icon.
#NoTrayIcon
#cs====Discription===========
CreateDate:7/28/2011
FileType:Library Form Design
FileName:DateTimeDesktop.au3
DesignBy:Sak2005
#ce==========================
;Library Include.
#include <GUIConstantsEx.au3>
#include <StaticConstants.au3>
#include <WindowsConstants.au3>
#include <WINAPI.au3>
;Keyword Operator Variable.
Opt("MustDeclareVars", 1)
HotKeySet("{ESC}", "_hkExit")
Global $title = 'DateTimeDesktop'
;Form design. (Koda)
Local $hForm = GUICreate($title, @DesktopWidth, @DesktopHeight, -1, -1, -1, $WS_EX_LAYERED)
GUISetBkColor(0xABABAB)
GUISetIcon("shell32.dll", 47)
Local $hLabel_Date = GUICtrlCreateLabel(_SystemDate(), 20, 300, 950, 70, BitOR($SS_CENTER,$SS_CENTERIMAGE))
GUICtrlSetFont(-1, 30, 0, 0, "Arial")
GUICtrlSetColor(-1, 0xFFFFFF)
Local $hLabel_Disc = GUICtrlCreateLabel("Design by : sak2005", 20, 365, 950, 40, BitOR($SS_CENTER,$SS_CENTERIMAGE))
GUICtrlSetFont(-1, 15, 0, 0, "Arial")
GUICtrlSetColor(-1, 0xFFFFFF)
Local $hLabel_Time = GUICtrlCreateLabel(_SystemTime(), 20, 400, 950, 80, BitOR($SS_CENTER,$SS_CENTERIMAGE))
GUICtrlSetFont(-1, 50, 0, 0, "Arial")
GUICtrlSetColor(-1, 0xFFFFFF)
GUISetState(@SW_SHOW)
_WinAPI_SetLayeredWindowAttributes($hForm, 0xABABAB, 255, BitOR($LWA_COLORKEY, $LWA_ALPHA)) ;Glass form.
;Events GuiControl Loop.
Do
    ControlSetText($title, "", "Static1", _SystemDate())
    ControlSetText($title, "", "Static3", _SystemTime())
Until GUIGetMsg()=$GUI_EVENT_CLOSE
;Date Library function.
Func _SystemDate()
    Local $day, $wday = @WDAY
    Switch $wday
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
    Local $tabledate, $mday = @MDAY, $mon = @MON, $year = @YEAR
    $tabledate = ($day&'/'&$mday&'/'&$mon&'/'&$year)
    If(@error)Or(Not $tabledate)Then Return SetError(1, 0, 0)
    Return $tabledate
EndFunc
;Time Library function.
Func _SystemTime()
    Local $tabletime, $hour = @HOUR, $min = @MIN, $sec = @SEC
    $tabletime = ($hour&':'&$min&':'&$sec)
    If(@error)Or(Not $tabletime)Then Return SetError(1, 0, 0)
    Return $tabletime
EndFunc
;Press key ESC to exit function.
Func _hkExit()
    Exit
EndFunc  ;<<=End Datetime Desktop=<<