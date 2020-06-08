; Author: Valuater
; Time Machine #3
; Day & Hour

$start = @MDAY & "/" & @HOUR + 1 ; for testing

While 1
	$start2 = @MDAY & "/" & @HOUR
	If $start = $start2 Then
		Run("notepad.exe")
		Exit
	EndIf
	ToolTip("Start Time = " & $start & @CRLF & "Real Time = " & $start2, 120, 120, "Time Machine", 1)
	Sleep(2000)
WEnd
Exit