TrayTip(")))", "Смотри здесь", 5, 1)
For $j = 1 to 4
	For $i = 0 to 11
		TraySetIcon('taskmgr.exe', -3-$i)
		Sleep(200)
	Next
	For $i = 11 to 0 Step -1
		TraySetIcon('taskmgr.exe', -3-$i)
		Sleep(200)
	Next
Next
		; TraySetIcon('netshell.dll', -152-$i)