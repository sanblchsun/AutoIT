
If MsgBox(4, 'Сообщение', 'Срипт создаст несколько каталогов в текущей папке '&@CRLF&'и извлекёт в них иконки из *.dll, вы согласны?')<>6 Then Exit
If Not FileExists(@ScriptDir&'\ResHacker.exe') Then
	MsgBox(0, 'Сообщение', 'Требуется ResHacker.exe в текущей папке')
	Exit
EndIf

Dim $dll[42] = [41, _
'shell32.dll', _
'rasdlg.dll', _
'fontext.dll', _
'msgina.dll', _
'mshtml.dll', _
'mstask.dll', _
'netshell.dll', _
'setupapi.dll', _
'shimgvw.dll', _
'webcheck.dll', _
'xpsp2res.dll', _
'stobject.dll', _
'mydocs.dll', _
'moricons.dll', _
'url.dll', _
'mpcicons.dll', _
'assot.dll', _
'explorer.exe', _
'iexplore.exe', _
'sndvol32.exe', _
'shutdown.exe', _
'charmap.exe', _
'wordpad.exe', _
'taskmgr.exe', _
'wmplayer.exe', _
'wscript.exe', _
'spider.exe', _
'sol.exe', _
'freecell.exe', _
'regedit.exe', _
'winmine.exe', _
'notepad.exe', _
'calc.exe', _
'mspaint.exe', _
'main.cpl', _
'mmsys.cpl', _
'sysdm.cpl', _
'joy.cpl', _
'telephon.cpl', _
'timedate.cpl', _
'desk.cpl']

$tr=0
For $i = 1 to $dll[0]
	If FileExists(@SystemDir&'\'&$dll[$i]) Then
		$tr=1
		DirCreate(StringTrimRight(@ScriptDir&'\'&$dll[$i],4))
		ShellExecuteWait(@ScriptDir&'\ResHacker.exe','-extract '&@SystemDir&'\'&$dll[$i]&', '&StringTrimRight(@ScriptDir&'\'&$dll[$i],4)&'\text_icon.rc, IconGroup,,','','', @SW_HIDE)
	EndIf
	
	If FileExists(@WindowsDir&'\'&$dll[$i]) and $tr=0 Then
		DirCreate(StringTrimRight(@ScriptDir&'\'&$dll[$i],4))
		ShellExecuteWait(@ScriptDir&'\ResHacker.exe','-extract '&@WindowsDir&'\'&$dll[$i]&', '&StringTrimRight(@ScriptDir&'\'&$dll[$i],4)&'\text_icon.rc, IconGroup,,','','', @SW_HIDE)
	EndIf
	$tr=0
Next