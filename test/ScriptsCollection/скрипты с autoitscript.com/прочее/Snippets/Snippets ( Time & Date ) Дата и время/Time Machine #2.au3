; Author: Valuater
; Time Machine #2
; Hours  & Minutes

$start = @HOUR & ":" & @MIN + 2 ; for testing

While 1
	$start2 = @HOUR & ":" & @MIN
	If $start = $start2 Then
		Run("notepad.exe")
		ExitLoop
	EndIf
	ToolTip("Start Time = " & $start & @CRLF & "Real Time = " & $start2, 20, 20, "Time Machine", 1)
	Sleep(2000)
WEnd
Exit