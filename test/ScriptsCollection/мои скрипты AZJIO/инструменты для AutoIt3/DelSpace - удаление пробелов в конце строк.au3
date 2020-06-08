;  @AZJIO
; предназначен для удаления пробелов в скриптах скопированных в сообщениях форума ru-board
; команда для Notepad++, Alt+Shift+D
; <Command name="DelSpace" Ctrl="no" Alt="yes" Shift="yes" Key="68">&quot;$(NPP_DIRECTORY)\..\AutoIt3.exe&quot; &quot;$(NPP_DIRECTORY)\Instrument_azjio\DelSpace.au3&quot; &quot;$(FULL_CURRENT_PATH)&quot;</Command>

$bufer_read = 1 ; если 1 то читаем из буфера, если 0 то диалог выбора файла
$bufer_write = 1 ; если 1 то результат в буфер, если 0 то сохраняем в файл file_0.au3 в каталоге конвертора

; Если указан файл через ком-строку, то будет обновлён
If $CmdLine[0] Then
	If FileExists($CmdLine[1]) Then
		$sText = FileRead($CmdLine[1])
	Else
		Exit
	EndIf
Else
	If $bufer_read Then
		$sText = ClipGet()
	Else
		$sTmpPath = FileOpenDialog("Выбор файла.", @WorkingDir & "", "Скрипт (*.au3)", 1 + 4)
		If @error Then Exit
		$sText = FileRead($sTmpPath)
	EndIf
EndIf

$sText = StringRegExpReplace($sText, '\h+(?=\r|\n|\z)', '') ; удаление пробелов в конце строк

If $CmdLine[0] Then
	$hFile = FileOpen($CmdLine[1], 2)
	FileWrite($hFile, $sText)
	FileClose($hFile)
	MsgBox(4096, '', 'Yes...', 1) ; чтобы Notepad++ обновил окно с помощью потери активности.
Else
	If $bufer_write Then
		ClipPut($sText)
	Else
		$sPath = @ScriptDir & '\file_'
		$i = 0
		While FileExists($sPath & $i & '.au3')
			$i += 1
		WEnd
		$sPath = $sPath & $i & '.au3'

		$hFile = FileOpen($sPath, 2)
		FileWrite($hFile, $sText)
		FileClose($hFile)
	EndIf
EndIf