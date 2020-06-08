Global $ini=@ScriptDir&'\Save.ini'

; первый старт - создание ini с настройками по умолчанию. Статус NOTREADY проверяется на случай если скрипт работает с CD-диска
; Для ini-файла нечитаемость диска можно не проверять, это не вызывает ошибки, разве что переключить триггер для использования реестра
If Not FileExists($ini) And DriveStatus(StringLeft(@ScriptDir, 1))<>'NOTREADY' Then
	$file = FileOpen($ini,2)
	FileWrite($file, '[Set]' &@CRLF& _
	'Trigger=1')
	FileClose($file)
EndIf

; чтение параметра
$Trigger=Number(IniRead($Ini, 'Set', 'Trigger', '1'))

GUICreate('My Program', 250, 260)
$CheckBox1=GUICtrlCreateCheckbox('CheckBox1', 10, 10, 120, 17)
If $Trigger=1 Then GUICtrlSetState(-1, 1) ; установка состояния
GUISetState()
OnAutoItExitRegister("_Exit_Save_Ini") ; срабатывает когда скрипт завершает работу

Do
Until GUIGetMsg()=-3

Func _Exit_Save_Ini()
	IniWrite($Ini, 'Set', 'Trigger', GUICtrlRead($CheckBox1))
EndFunc