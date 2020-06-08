#AutoIt3Wrapper_OutFile=Start.exe
#AutoIt3Wrapper_icon=Start.ico
#AutoIt3Wrapper_Compression=4
#AutoIt3Wrapper_Res_Comment=-
#AutoIt3Wrapper_Res_Description=Start.exe
#AutoIt3Wrapper_Res_Fileversion=0.1.0.0
#AutoIt3Wrapper_Res_Fileversion_AutoIncrement=n
#AutoIt3Wrapper_Res_LegalCopyright=AZJIO + AutoIt3 v3.3.6.1
#AutoIt3Wrapper_Res_Language=1033
#NoTrayIcon
If Not @compiled Then Exit
$path=StringTrimRight(@AutoItExe, 3)&'txt'
If Not FileExists($path) Then
	MsgBox(0, 'Сообщение', 'Положите в текущий каталог скрипт, дав ему имя аналогичное Start.exe, например Start.txt (или другое, важно дать одинаковые имена). При запуске EXE-файла выполнится код текстового файла. Командная строка поддерживается.')
	Exit
EndIf
If $CmdLine[0]>0 Then
	Run('"'&@AutoItExe&'" /AutoIt3ExecuteScript "'&$path&'" '&$CmdLineRaw, '', @SW_HIDE)
Else
	Run('"'&@AutoItExe&'" /AutoIt3ExecuteScript "'&$path&'"', '', @SW_HIDE)
EndIf