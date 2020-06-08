
;  @AZJIO пример программы с внешними языковыми файлами

#include <ComboConstants.au3>

;=============================================================
; создаём два языковых файла En.lng и Ru.lng. В скрипте они не обязательны, нужны для этого примера.
If Not FileExists(@ScriptDir & '\Lang') Then DirCreate(@ScriptDir & '\Lang')
$file = FileOpen(@ScriptDir & '\Lang\En.lng', 2)
If $file <> -1 Then
	FileWrite($file, _
			'[lng]' & @CRLF & _
			'Title=My Programs' & @CRLF & _
			'But=Open' & @CRLF & _
			'ButH=Open File' & @CRLF & _
			'Lab=Example choice language' & @CRLF & _
			'Sl=Select' & @CRLF & _
			'Type=Language')
	FileClose($file)
EndIf

$file = FileOpen(@ScriptDir & '\Lang\Ru.lng', 2)
If $file <> -1 Then
	FileWrite($file, _
			'[lng]' & @CRLF & _
			'Title=Моя программа' & @CRLF & _
			'But=Открыть' & @CRLF & _
			'ButH=Открыть файл' & @CRLF & _
			'Lab=Пример выбора языка' & @CRLF & _
			'Sl=Выбор' & @CRLF & _
			'Type=Языковой файл')
	FileClose($file)
EndIf
;=============================================================

#NoTrayIcon
Global $LangPath, $Ini = @ScriptDir & '\prog_set.ini'

; создаём файл настроек с языковым параметром. Используется при первом запуске.
If Not FileExists($Ini) Then
	$file = FileOpen($Ini, 2)
	If $file <> -1 Then
		FileWrite($file, _
				'[Set]' & @CRLF & _
				'Lang=none')
		FileClose($file)
	EndIf
EndIf

; По умолчанию устанавливаем англоязычный интерфейс, в случае отсутствия языковых файлов.
Global $aLng0[7][2] = [[ _
		6, 6],[ _
		'Title', 'My Programs'],[ _
		'But', 'Open'],[ _
		'ButH', 'Open File'],[ _
		'Lab', 'Example choice language'],[ _
		'Sl', 'Select'],[ _
		'Type', 'Language']]

; Ru
; если русская локализация, то русский язык
If @OSLang = 0419 Then
	Dim $aLng0[7][2] = [[ _
			6, 6],[ _
			'Title', 'Моя программа'],[ _
			'But', 'Открыть'],[ _
			'ButH', 'Открыть файл'],[ _
			'Lab', 'Пример выбора языка'],[ _
			'Sl', 'Выбор'],[ _
			'Type', 'Языковой файл']]
EndIf

; генерируем переменные массива
For $i = 1 To $aLng0[0][0]
	If StringInStr($aLng0[$i][1], '\r\n') Then $aLng0[$i][1] = StringReplace($aLng0[$i][1], '\r\n', @CRLF) ; эту строку удалить, если вместо \r\n изначально @CRLF
	Assign('Lng' & $aLng0[$i][0], $aLng0[$i][1])
Next

; применяем языковой файл, если указан.
; 1 - переменные добавляются с перфиксом "Lng", поэтому они не могут пересекаться с переменными скрипта ни при каких обстоятельствах
; 2 - переменные проверяются на декларирование, поэтому добавить в скрипт недекларируемые невозможно
$LangPath = IniRead($Ini, 'Set', 'Lang', 'none') ; читаем значение параметра lng в глобавльную переменную $LangPath
If $LangPath <> 'none' And FileExists(@ScriptDir & '\Lang\' & $LangPath) Then
	$aLng = IniReadSection(@ScriptDir & '\Lang\' & $LangPath, 'lng')
	If Not @error Then
		For $i = 1 To $aLng[0][0]
			If StringInStr($aLng[$i][1], '\r\n') Then $aLng[$i][1] = StringReplace($aLng[$i][1], '\r\n', @CRLF)
			If IsDeclared('Lng' & $aLng[$i][0]) Then Assign('Lng' & $aLng[$i][0], $aLng[$i][1])
		Next
	EndIf
EndIf

$Gui = GUICreate($LngTitle, 250, 100)
$Button = GUICtrlCreateButton($LngBut, 10, 60, 99, 22)
GUICtrlSetTip(-1, $LngButH)
$Label = GUICtrlCreateLabel($LngLab, 10, 5, 153, 15)
; $Checkbox = GUICtrlCreateCheckbox ($LngCh, 10, 50, 55, 22)

$LangList = 'none'
$search = FileFindFirstFile(@ScriptDir & '\Lang\*.lng')
If $search <> -1 Then
	While 1
		$file = FileFindNextFile($search)
		If @error Then ExitLoop
		$LangList &= '|' & $file
	WEnd
EndIf
FileClose($search)

GUICtrlCreateLabel('Language', 10, 33, 75, 17)
$ComboLang = GUICtrlCreateCombo('', 85, 30, 70, 22, $CBS_DROPDOWNLIST)
GUICtrlSetData(-1, $LangList, $LangPath)

GUISetState()

While 1
	Switch GUIGetMsg()
		Case $ComboLang
			_SetLang()
		Case -3
			Exit
	EndSwitch
WEnd

; функция смены языка
Func _SetLang()
	Local $aLng
	$LangPath = GUICtrlRead($ComboLang)
	If $LangPath <> 'none' And FileExists(@ScriptDir & '\Lang\' & $LangPath) Then
		$aLng = IniReadSection(@ScriptDir & '\Lang\' & $LangPath, 'lng') ;читаем все пераметры в секции lng
		If Not @error Then
			For $i = 1 To $aLng[0][0]
				If StringInStr($aLng[$i][1], '\r\n') Then $aLng[$i][1] = StringReplace($aLng[$i][1], '\r\n', @CRLF); делаем замену \r\n в случае использования многострочных текстов
				If IsDeclared('Lng' & $aLng[$i][0]) Then Assign('Lng' & $aLng[$i][0], $aLng[$i][1]) ; обновляем имена декларированных переменных
			Next
			_SetLang2()
			IniWrite($Ini, 'Set', 'Lang', $LangPath)
		EndIf
	Else ; если нет файла или выбран "none", то используем язык встроенный в программу
		For $i = 1 To $aLng0[0][0]
			If StringInStr($aLng0[$i][1], '\r\n') Then $aLng0[$i][1] = StringReplace($aLng0[$i][1], '\r\n', @CRLF)
			Assign('Lng' & $aLng0[$i][0], $aLng0[$i][1])
		Next
		_SetLang2()
		IniWrite($Ini, 'Set', 'Lang', 'none')
	EndIf
EndFunc   ;==>_SetLang

; функция обновления текстов интерфейса
Func _SetLang2()
	; недостаточно обновить имена в переменных, их нужно сменить в видимом интерфейсе программы
	WinSetTitle($Gui, '', $LngTitle) ; сменить имя окна, если это окно настройки
	GUICtrlSetData($Label, $LngLab)
	GUICtrlSetData($Button, $LngBut)
	GUICtrlSetTip($Button, $LngButH)
	; смена языка взависимости от состояния чекбокса
	; If $TrCh = 0 Then
		; GUICtrlSetTip($Checkbox,  $LngCh1)
	; Else
		; GUICtrlSetTip($Checkbox,  $LngCh2)
	; EndIf
EndFunc   ;==>_SetLang2