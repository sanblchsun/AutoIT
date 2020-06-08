
;  @AZJIO пример программы с внешними языковыми файлами

;=============================================================
; создаём два языковых файла En.lng и Ru.lng. В скрипте они не обязательны, нужны для этого примера.
$file = FileOpen(@ScriptDir & '\En.lng', 2)
FileWrite($file, _
		'[lng]' & @CRLF & _
		'LngTitle=My Programs' & @CRLF & _
		'LngBut=Open LNG' & @CRLF & _
		'LngButH=Open File LNG' & @CRLF & _
		'LngLab=Example choice language' & @CRLF & _
		'LngSl=Select' & @CRLF & _
		'LngType=Language')
FileClose($file)

$file = FileOpen(@ScriptDir & '\Ru.lng', 2)
FileWrite($file, _
		'[lng]' & @CRLF & _
		'LngTitle=Моя программа' & @CRLF & _
		'LngBut=Открыть LNG' & @CRLF & _
		'LngButH=Открыть файл LNG' & @CRLF & _
		'LngLab=Пример выбора языка' & @CRLF & _
		'LngSl=Выбор' & @CRLF & _
		'LngType=Языковой файл')
FileClose($file)
;=============================================================

#NoTrayIcon
Global $lng, $Ini = @ScriptDir & '\prog_set.ini'

; По умолчанию устанавливаем англоязычный интерфейс, в случае отсутствия языковых файлов.
$LngTitle = 'My Programs'
$LngBut = 'Open LNG'
$LngButH = 'Open File LNG'
$LngLab = 'Example choice language'
$LngSl = 'Select'
$LngType = 'Language'

; создаём файл настроек с языковым параметром. Используется при первом запуске.
; Выбор позволяет старт без ini, соответственно без ошибок если носитель с доступом "только чтение"
If Not FileExists($Ini) Then
	$file = FileOpen($Ini, 2)
	If $file <> -1 Then
		FileWrite($file, _
				'[setting]' & @CRLF & _
				'lng=')
		FileClose($file)
	EndIf
EndIf

$lng = IniRead($Ini, 'setting', 'lng', '') ; читаем значение параметра lng в глобавльную переменную $lng

$Gui = GUICreate($LngTitle, 250, 100)
$Button = GUICtrlCreateButton($LngBut, 10, 30, 99, 22)
GUICtrlSetTip(-1, $LngButH)
$Label = GUICtrlCreateLabel($LngLab, 10, 5, 153, 15)
; $Checkbox = GUICtrlCreateCheckbox ($LngCh, 10, 50, 55, 22)

; если переменная имеет значение в виде имени файла и существует этот файл, то вызываем функцию смены языка
If $lng <> '' And FileExists(@ScriptDir & '\' & $lng) Then _OpenLng($lng)

GUISetState()

While 1
	$msg = GUIGetMsg()
	Select
		Case $msg = $Button
			$tmp = FileOpenDialog($LngSl, @WorkingDir & "", $LngType & " (*.lng)", 1)
			If @error Then ContinueLoop
			$tmp = StringRegExpReplace($tmp, '(^.*)\\(.*)$', '\2')
			_OpenLng($tmp)
		Case $msg = -3
			IniWrite($Ini, 'setting', 'lng', $lng)
			Exit
	EndSelect
WEnd

; функция смены языка
Func _OpenLng($Path)
	;читаем все пераметры в секции lng
	$aLng = IniReadSection(@ScriptDir & '\' & $Path, 'lng')
	If @error Then ; в случае ошибки делаем выход
		$lng = ''
		Return
	Else ; в случае отсутствия ошибки обновляем имена переменных
		For $i = 1 To $aLng[0][0]
			If StringInStr($aLng[$i][1], '\r\n') <> 0 Then $aLng[$i][1] = StringReplace($aLng[$i][1], '\r\n', @CRLF) ; делаем замену \r\n в случае использования многострочных текстов
			Assign($aLng[$i][0], $aLng[$i][1]) ; обновляем имена переменных
		Next
		$lng = $Path ; сохраняем имя русификатора
		
		; недостаточно обновить имена в переменных, их нужно сменить в видимом интерфейсе программы
		ControlSetText($Gui, '', $Gui, $LngTitle, 1)
		GUICtrlSetData($Label, $LngLab)
		GUICtrlSetData($Button, $LngBut)
		GUICtrlSetTip($Button, $LngButH)
		
		; смена языка взависимости от состояния чекбокса
		; If $TrCh = 0 Then
			; GUICtrlSetTip($Checkbox,  $LngCh1)
		; Else
			; GUICtrlSetTip($Checkbox,  $LngCh2)
		; EndIf

	EndIf
EndFunc   ;==>_OpenLng