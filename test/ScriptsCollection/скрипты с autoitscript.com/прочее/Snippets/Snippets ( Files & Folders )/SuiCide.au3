; IMPORTANT MAKE A COPY OF SCRIPT BEFORE DELETION
; Deletes the running script

; Сделайте копию этого файла перед вызовом функции
; Суицид - удаление скрипта (самого себя) после завершения работы. Скрипт создаёт BAT-файл в папке "Temp", который удаляет этот скрипт.
; Это оригинал, добавте в него "CHCP 1251", иначе пути с русскими символами не поддерживаются, опять же не иностранном компе нужна иная кодировка
; При невозможности удаления скрипт зависает в цикле
 
Func SuiCide()
	Local $sFilePath = @TempDir & '\SuiCide.bat'
	FileDelete($sFilePath)
	FileWrite($sFilePath, 'loop:' & @CRLF & 'del "' & @ScriptFullPath & '"' & @CRLF & _
			'ping -n 1 -w 250 zxywqxz_q' & @CRLF & 'if exist "' & @ScriptFullPath & _
			'" goto loop' & @CRLF & 'del SuiCide.bat' & @CRLF)
	Exit Run($sFilePath, @TempDir, @SW_HIDE)
EndFunc   ;==>SuiCide