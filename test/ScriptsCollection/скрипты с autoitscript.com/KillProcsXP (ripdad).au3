; KillProcsXP v1.0
; Released: March 15, 2010, by ripdad
;
If Not (@OSVersion = 'WIN_XP') Then
    MsgBox(16, 'KillProcsXP', 'This Program has only been tested on Windows XP' & @CRLF & @CRLF & 'Click OK to Exit', 15)
    Exit
EndIf
$answer = MsgBox(4, 'KillProcsXP', 'Close All Non-Essential Programs ?')
If $answer = 7 Then Exit
;
; ######## EXCLUDED PROCESSES #########
;
; ABSOLUTE REQUIRED SYSTEM PROCESSES
;-----------------------------------
Global $s01 = '[System Process]'
Global $s02 = 'System'
Global $s03 = 'alg.exe'
Global $s04 = 'csrss.exe'
Global $s05 = 'ctfmon.exe'
Global $s06 = 'explorer.exe'
Global $s07 = 'lsass.exe'
Global $s08 = 'services.exe'
Global $s09 = 'smss.exe'
Global $s10 = 'svchost.exe'
Global $s11 = 'winlogon.exe'
;-----------------------------------
;
Global $i01 = 'KillProcsXP.exe'; This Process Compiled
Global $i02 = 'AutoIt3.exe'; This Process Non-Compiled
;
; Additional Processes (Example)
Global $p01 = 'spybotsd162.exe'; Spyware Scanner Install
Global $p02 = 'SpybotSD.exe'; Spyware Scanner Program
Global $p03 = 'spybotsd_includes.exe'; Spyware Scanner Update
Global $p04 = 'taskmgr.exe'; Task Manager
Global $p05 = 'UEDIT32.EXE'; Editor
;
; ###### END EXCLUDED PROCESSES ######
;
; Tray Options - Slows it down if you use menumode
; TraySetIcon('')
TraySetToolTip('KillProcsXP')
;
TrayTip('KillProcsXP', 'Closing Programs - Please Wait  ', 59, 1)
;
; Initial Slow Kill if Not in List Above - Giving Time for Each Process to Close
$pr = ProcessList()
For $i = 1 To $pr[0][0]
    Switch $pr[$i][0]
        Case $s01, $s02, $s03, $s04, $s05, $s06, $s07, $s08, $s09, $s10, $s11; System
        Case $i01, $i02, $p01, $p02, $p03, $p04, $p05; Allowed
        Case Else
            ProcessClose($pr[$i][1]); Disallowed
    EndSwitch
    Sleep(1000); Slow Kill Delay
Next
TrayTip('', '', 5, 1)
;
$answer = MsgBox(68, 'KillProcsXP', 'Closed All Non-Essential Programs' & @CRLF & @CRLF & 'Continue Persistent ?')
If $answer = 7 Then Exit
;
; GUI With Three Additional Manual Entry Processes Called Excludes
; (ie: excludes from being closed as if it were in the list above)
$kpxp = GUICreate("KillProcsXP v1.0", 180, 150, -1, -1)
GUICtrlCreateLabel('Exclude These Programs' & @CRLF & ' example: notepad.exe ', 15, 15, 140, 40)
Global $g01 = GUICtrlCreateInput("", 15, 50, 150, 20)
Global $g02 = GUICtrlCreateInput("", 15, 80, 150, 20)
Global $g03 = GUICtrlCreateInput("", 15, 110, 150, 20)
;
GUISetState(@SW_SHOW, $kpxp)
;
; Persistant Fast Kill if Not in List Above or GUI Excludes
Local $kpxp_msg
While 1
    Sleep(10)
    $kpxp_msg = GUIGetMsg()
    Switch $kpxp_msg
        Case -3
            GUISetState(@SW_MINIMIZE, $kpxp); Minimize when "x'd"
    EndSwitch
    $pr = ProcessList()
    For $i = 1 To $pr[0][0]
        Switch $pr[$i][0]
            Case $s01, $s02, $s03, $s04, $s05, $s06, $s07, $s08, $s09, $s10, $s11; System
            Case $i01, $i02, $p01, $p02, $p03, $p04, $p05; Allowed
            Case GUICtrlRead($g01), GUICtrlRead($g02), GUICtrlRead($g03); Allowed
            Case Else
                ProcessClose($pr[$i][1]); Disallowed
        EndSwitch
    Next
WEnd
GUIDelete($kpxp)
;
