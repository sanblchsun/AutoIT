
; ���������� ������ �����

$Folder=@ScriptDir&'\��� �����'

; �������� ������
$OpenFile = FileOpenDialog('�������', @WorkingDir , "������ (*.ico)")
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
"InfoTip=��� ��������� � �����"&@CRLF)

FileClose($FILE)
FileSetAttrib($Folder&'\desktop.ini', '+RH')
 
 
 ; FileSetAttrib($Folder, "-R")
; MsgBox(0, '���������', FileGetAttrib ($Folder))