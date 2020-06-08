
; Установить иконку файлу

$Folder=@ScriptDir&'\Моя папка'

; выбираем иконку
$OpenFile = FileOpenDialog('Открыть', @WorkingDir , "Иконка (*.ico)")
If @error Then Exit


DirCreate($Folder)
FileCopy($OpenFile, $Folder&'\Desktop.ico')
FileSetAttrib($Folder&'\Desktop.ico', '+RH')
FileSetAttrib($Folder,"+S")
$FILE=FileOpen($Folder&'\desktop.ini',2)

FileWrite($FILE, _
"[.ShellClassInfo]"&@CRLF& _
"IconFile=Desktop.ico"&@CRLF& _
"IconIndex=0"&@CRLF& _
"InfoTip=Это подсказка к папке"&@CRLF)

FileClose($FILE)
FileSetAttrib($Folder&'\desktop.ini', '+RH')
 
 
 ; FileSetAttrib($Folder, "-R")
; MsgBox(0, 'Сообщение', FileGetAttrib ($Folder))