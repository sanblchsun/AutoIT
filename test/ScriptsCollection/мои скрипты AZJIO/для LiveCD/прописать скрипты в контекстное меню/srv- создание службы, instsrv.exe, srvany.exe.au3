;  @AZJIO
; Имя службы - имя файла

If Not FileExists(@SystemDir & '\SRVANY.EXE') Or Not FileExists(@SystemDir & '\INSTSRV.EXE') Then
	MsgBox(0, "Ошибка", "Проверте наличие  файлов INSTSRV.EXE и SRVANY.EXE в %SystemRoot%\system32")
	Exit
EndIf
;Добавление $sTarget позволило использовать скрипт в контекстном меню
If Not $CmdLine[0] Then
	$SRV_FILE = FileOpenDialog("Выбор файла *.exe, который будет запущен как сервис.", @ScriptDir & "", "exe-файл (*.exe)", 1 + 4)
	If @error Then Exit
Else
	$SRV_FILE = $CmdLine[1]
EndIf
$srv_naim = StringRegExpReplace($SRV_FILE, "(^.*)\\(.*)\.(.*)$", '\2')
$process = $srv_naim
; диалог выбора имени службы, можно закомментировать, тогда по умолчанию по имени файла.
$srv_naim = InputBox("Имя службы", "Можете изменить имя службы, если это необходимо. Или отменить операцию", $srv_naim, "", 260, 130)
If @error Or $srv_naim = '' Then
	MsgBox(0, "Состояние", 'Создание службы отменено.', 3)
	Exit
EndIf

$srvn = RegRead('HKLM\SYSTEM\CurrentControlSet\Services\' & $srv_naim, '')
If @error <> 1 Then
	MsgBox(0, "Ошибка", "Служба с таким именем уже существует")
	Exit
EndIf
Run(@SystemDir & '\INSTSRV.EXE "' & $srv_naim & '" ' & @SystemDir & '\SRVANY.EXE', '', @SW_HIDE)
ProgressOn("Создание службы", $srv_naim, '', -1, -1, 18)
ProgressSet(50, "Запуск службы")
;RegWrite('HKLM\SYSTEM\CurrentControlSet\Services\'&$srv_naim,'Type','REG_DWORD','272')
RegWrite('HKLM\SYSTEM\CurrentControlSet\Services\' & $srv_naim & '\Parameters', 'Application', 'REG_SZ', $SRV_FILE)
RegDelete('HKLM\SYSTEM\CurrentControlSet\Services\' & $srv_naim & '\Security')
RunWait(@ComSpec & ' /C NET START "' & $srv_naim & '"', '', @SW_HIDE)
ProgressOff()
If ProcessExists($process & '.exe') Then MsgBox(0, "Состояние", 'Процесс ' & $process & ' запущен.', 3)