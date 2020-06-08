; Author: Valuater
;Time Machine #1
;Minutes/seconds/miliseconds

$Minutes = 90 ; will wait 90 minutes

Local $60Count = 0, $begin = TimerInit()
While $Minutes > $60Count
	$dif = TimerDiff($begin)
	$dif2 = StringLeft($dif, StringInStr($dif, ".") - 1)
	$Count = Int($dif / 1000)
	$60Count = Int($Count / 60)
	ToolTip("Minutes Required = " & $Minutes & @CRLF & "Minutes Past = " & $60Count & @CRLF & "Seconds Count = " & $Count & @CRLF & "Mili-Seconds Count = " & $dif2, 20, 20, "Time Machine #1", 1)
	Sleep(20)
WEnd

MsgBox(64, "Time-Up!!", "Your " & $Minutes & " minutes have passed    ")