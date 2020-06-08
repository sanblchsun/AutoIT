; Author: Valuater
; Run a timed program daily

; #NoTrayIcon ; for testing

Global $Minutes = 30
Global $Title = "My Window Title"

; settings
Global $Show_Clock = 1 ; 0 = no show
Global $Clock_Title = $Minutes & "  Minute Time Machine"

If WinExists($Clock_Title) Then Exit
AutoItWinSetTitle($Clock_Title)

; ***** for testing only ******
HotKeySet("{F9}", "Runner")
Func Runner()
	Run("notepad.exe")
EndFunc   ;==>Runner
$Minutes = 3 ; for testing
$Title = "Untitled" ; for testing
; *****************************

While 1
	If WinExists($Title) Then Clockit()
	Sleep(100)
WEnd

Func Clockit()
	Local $log = @WindowsDir & "\temp\"
	Local $log_file = $log & @YDAY & ".pak"
	If Not FileExists($log_file) Then
		FileDelete($log & "*.pak")
		FileWriteLine($log_file, $Minutes)
	EndIf
	Local $M_Minutes = FileReadLine($log_file, 1)
	Local $begin = TimerInit(), $60Count = 0
	If $M_Minutes <= 0 Then
		WinClose($Title)
		MsgBox(64, $Clock_Title, "Time-Up!! ...Your daily time usage has passed.    ", 5)
		Return
	EndIf
	While $M_Minutes > 0 And WinExists($Title)
		$dif = TimerDiff($begin)
		$Count = Int($dif / 1000)
		If $Count >= 60 Then
			$60Count += 1
			$M_Minutes -= 1
			$begin = TimerInit()
		EndIf
		If $Show_Clock Then ToolTip("Minutes Remaining = " & $M_Minutes & @CRLF & "Minutes Past = " & $60Count & @CRLF & "Seconds Count = " & $Count, 20, 20, $Clock_Title, 1)
		Sleep(100)
	WEnd
	ToolTip("")
	FileDelete($log_file)
	Sleep(300)
	If $Count >= 20 And $M_Minutes > 0 Then $M_Minutes -= 1
	FileWriteLine($log_file, $M_Minutes)
EndFunc   ;==>Clockit