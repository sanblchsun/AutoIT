



For $i = 255 to 0 step -1
	WinSetTrans("","",$i)
	Sleep(10)
Next

	Sleep(1000)

For $i = 0 to 255
	WinSetTrans("","",$i)
	Sleep(10)
Next