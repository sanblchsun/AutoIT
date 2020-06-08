;~ Пример 1 
Run("Explorer.exe /select," & @ScriptFullPath) 

;~ Пример 2
MsgBox(64, 'Поехали! #1', 'Открытие папки "Мои Документы":' & @CRLF & @CRLF & @MyDocumentsDir) 
;~ Вместо @MyDocumentsDir - вписать необходимую папку, пример: ShellExecute('c:\Mega folder\'): 
ShellExecute(@MyDocumentsDir) 

