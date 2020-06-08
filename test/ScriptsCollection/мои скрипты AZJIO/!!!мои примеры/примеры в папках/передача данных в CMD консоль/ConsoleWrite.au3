#AutoIt3Wrapper_OutFile=ConsoleWrite.exe
; If Not @compiled Then
	; MsgBox(0, 'Сообщение', 'Скомпилируйте скрипт')
	; Exit
; EndIf
ConsoleWrite("Этот текст будет записан в консоль"&@CRLF)
ConsoleWrite(StringToBinary("Этот текст будет записан в консоль"))