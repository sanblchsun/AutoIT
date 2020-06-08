#AutoIt3Wrapper_OutFile=Program.exe
#AutoIt3Wrapper_Change2CUI=Y
; If Not @compiled Then
	; MsgBox(0, 'Сообщение', 'Скомпилируйте скрипт')
	; Exit
; EndIf
If $CmdLine[0] Then
	Switch $CmdLine[1]
		Case '/h', '-h'
			ConsoleWrite("‡¤Ґбм Ўл«  бЇа ўЄ ")
		Case '/a', '-a'
			ConsoleWrite("ќв®в вҐЄбв Ўг¤Ґв § ЇЁб ­ ў Є®­б®«м")
		Case Else
			Exit 2 ; код ошибки 2, если параметр не верный
	EndSwitch
Else
	Exit 1 ; код ошибки 1, если нет параметров
EndIf
Exit 0 ; код ошибки 0, операция успешна