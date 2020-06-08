#NoTrayIcon
#include <nppUDF.au3>
#include <File.au3>
; #include <Array.au3>

; [1] $(NPP_DIRECTORY)
; [2] $(CURRENT_WORD)
; [3] $(FULL_CURRENT_PATH)
Local $aLng[8] = [ _
		'Error', _
		'Select the name of the function', _
		'The "Include" directory not found', _
		'Not found', _
		'Sought but not found', _
		'Possible problems:' & @LF & '1. The function name with typo' & @LF & '2. "Include" is not inserted' & @LF & @LF & 'Want to do a search in all "include"?', _
		'Found in', _
		'Copy string to Clipboard?']

; Local $aLng[8] = [ _
; 'Ошибка', _
; 'Выделите имя функции', _
; 'Каталог Include не найден', _
; 'Не найден', _
; 'Искали, но не нашли', _
; 'Возможные проблемы:' & @LF & '1. Имя функции с опечаткой' & @LF & '2. include не подключён' & @LF & @LF & 'Хотите сделать поиск во всех include?', _
; 'Найдено в', _
; 'Копировать строку в буфер?']

If $CmdLine[0] > 2 Then
	; $sText = FileRead($CmdLine[3]) ; читаем файл. Проблема, несохранённые данные не воспринимаются
	$sText = _npp_GetText() ; Читаем из окна редактора. Нет проблемы если текст не сохранён.
	$a = StringRegExp($sText, '(?i)[\r\n\A]\s*Func\s+' & $CmdLine[2], 1) ; поиск имени функции в тексте
	If @error Then
		$Include_script = StringRegExp($sText, '(?mi)^\s*#include\s*[<"'']*([^\r\n]+?\.au3)', 3) ; возвращает include указанные в скрипте
		; _ArrayDisplay($Include_script, 'Array')
		$sInclude_Path = _GetIncludePath()
		; If @error Then
		; $sInclude_Path = @ScriptDir
		; Else
		; $sInclude_Path &= ';' & @ScriptDir
		; EndIf
		$aInclude_Path = StringSplit($sInclude_Path, ';')
		For $j = 1 To $aInclude_Path[0]
			If Not FileExists($aInclude_Path[$j]) Then ContinueLoop
			For $i = 0 To UBound($Include_script) - 1
				; MsgBox(0, 'Сообщение', $sInclude_Path)
				; MsgBox(0, 'Сообщение', $Include_script[$i])
				$sText = FileRead($aInclude_Path[$j] & '\' & $Include_script[$i]) ; открываем include файл
				$a = StringRegExp($sText, '(?i)[\r\n\A]\s*Func\s+' & $CmdLine[2], 1) ; поиск имени функции в тексте
				If Not @error Then ; если нет ошибки, т.е. нашли, то делаем прыжок
					$iPos = @extended - StringLen($a[0]) + 6 ; Сразу сохраняем позицию
					Run('"' & $CmdLine[1] & '\notepad++.exe" "' & $aInclude_Path[$j] & '\' & $Include_script[$i] & '"') ; открываем файл
					Sleep(300) ; на всякий случай ждём его открытия
					_JumpToFunc($sText, $iPos) ; выполняем прыжок в файле
					Exit
				EndIf
			Next
		Next
		If MsgBox(4 + 32, $aLng[3], $aLng[5]) = 6 Then
			For $j = 1 To $aInclude_Path[0] ; Обработка всех файлов в include-папках
				If Not FileExists($aInclude_Path[$j]) Then ContinueLoop
				$aFileList = _FileListToArray($aInclude_Path[$j], '*.au3', 1) ; поиск файлов
				If Not @error Then ; если нет ошибки (всмысле найдены файлы), то
					For $i = 1 To $aFileList[0] ; обрабатываем каждый файл
						$sText = FileRead($aInclude_Path[$j] & '\' & $aFileList[$i]) ; открываем include файл
						$a = StringRegExp($sText, '(?i)[\r\n\A]\s*Func\s+' & $CmdLine[2], 1) ; поиск имени функции в тексте
						If Not @error Then ; если нет ошибки, т.е. нашли, то делаем прыжок
							$iPos = @extended - StringLen($a[0]) + 6 ; Сразу сохраняем позицию
							Run('"' & $CmdLine[1] & '\notepad++.exe" "' & $aInclude_Path[$j] & '\' & $aFileList[$i] & '"') ; открываем файл
							Sleep(300) ; на всякий случай ждём его открытия
							_JumpToFunc($sText, $iPos) ; выполняем прыжок в файле
							If MsgBox(4 + 32, $aLng[6] & ' ' & $aFileList[$i], $aLng[7] & @LF & @LF & '#include <' & $aFileList[$i] & '>') = 6 Then ClipPut('#include <' & $aFileList[$i] & '>')
							Exit
						EndIf
					Next
				EndIf
			Next
		EndIf
		MsgBox(16, $aLng[3], $aLng[4], 1)
	Else
		; прыг в текущем файле
		$iPos = @extended - StringLen($a[0]) + 6
		_JumpToFunc($sText, $iPos)
	EndIf
Else
	MsgBox(0, $aLng[0], $aLng[1])
EndIf

Func _JumpToFunc(ByRef $AllText, $iPos)
	; Поиск найденного в тексте кода
	
	; Вычисляем номер строки
	$iPos = StringRegExp(StringLeft($AllText, $iPos), '(\r\n|\r|\n)', 3)
	$iPos = UBound($iPos)
	; делаем поправку, чтоб передвинуть строку к центру окна
	$CurLine = _SendMessage(WinGetHandle('[CLASS:Notepad++]'), $NPPM_GETCURRENTLINE, 0, 0)
	$pos = ControlGetPos('[CLASS:Notepad++]', "", "[CLASSNN:Scintilla1]")
	$iPos2 = $pos[3] / 32 ; высоту делим на 32 пикселя чтобы определить кол строк до средины окна
	If $iPos > $CurLine Then
		$iPos2 = $iPos + $iPos2
	Else
		$iPos2 = $iPos - $iPos2
	EndIf
	_npp_SetCurPos($iPos2)
	_npp_SetCurPos($iPos)
	WinActivate('[CLASS:Notepad++]')
EndFunc   ;==>_JumpToFunc

Func _GetIncludePath()
	$sInclude_Path = RegRead("HKLM\SOFTWARE\AutoIt v3\AutoIt", "InstallDir")
	If @error Then
		$sInclude_Path = RegRead('HKCU\Software\AutoIt v3\Autoit', 'Include')
	Else
		$sInclude_Path &= "\Include"
	EndIf
	If $sInclude_Path Then
		Return $sInclude_Path & ';' & @ScriptDir
	Else
		Return @ScriptDir
	EndIf
EndFunc   ;==>_GetIncludePath