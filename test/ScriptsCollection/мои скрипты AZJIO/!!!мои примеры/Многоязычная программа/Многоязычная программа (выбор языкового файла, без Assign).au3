; Недостаток этого метода - неименованный список, то есть если вставить строку в средину списка, то тексты на элементах сдвинутся, соответственно старый перевод в новой версии программы может оказаться неподходящим. В этом случае ini-файл выигрывает тем, что всего лишь будут непереведены некоторые тексты.
; Второй недостаток - невозможность обрабатывать переменные в цикле как массив

;  @AZJIO, пример программы с внешними языковыми файлами

#include <ComboConstants.au3>
#NoTrayIcon

;=============================================================
; создаём два языковых файла En.lng и Ru.lng. В скрипте они не обязательны, нужны для этого примера.
If Not FileExists(@ScriptDir & '\Lang') Then DirCreate(@ScriptDir & '\Lang')
$file = FileOpen(@ScriptDir & '\Lang\En.lng', 2)
If $file <> -1 Then
	FileWrite($file, _
			'My Programs' & @CRLF & _
			'Open' & @CRLF & _
			'Open File' & @CRLF & _
			'Example choice language' & @CRLF & _
			'Select' & @CRLF & _
			'Language')
	FileClose($file)
EndIf

$file = FileOpen(@ScriptDir & '\Lang\Ru.lng', 2)
If $file <> -1 Then
	FileWrite($file, _
			'Моя программа' & @CRLF & _
			'Открыть' & @CRLF & _
			'Открыть файл' & @CRLF & _
			'Пример выбора языка' & @CRLF & _
			'Выбор' & @CRLF & _
			'Языковой файл')
	FileClose($file)
EndIf
;=============================================================

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

Global $LngTitle, $LngBut, $LngButH, $LngLab, $LngSl, $LngType

_SetLangDef()
Func _SetLangDef()
	; En
	$LngTitle = 'My Programs'
	$LngBut = 'Open'
	$LngButH = 'Open File'
	$LngLab = 'Example choice language'
	$LngSl = 'Select'
	$LngType = 'Language'

	; Ru
	; если русская локализация, то русский язык
	If @OSLang = 0419 Then
		$LngTitle = 'Моя программа'
		$LngBut = 'Открыть'
		$LngButH = 'Открыть файл'
		$LngLab = 'Пример выбора языка'
		$LngSl = 'Выбор'
		$LngType = 'Языковой файл'
	EndIf
EndFunc   ;==>_SetLangDef

$LangPath = IniRead($Ini, 'Set', 'Lang', 'none')
_ReadLng()

Func _ReadLng()
	If $LangPath <> 'none' And FileExists(@ScriptDir & '\Lang\' & $LangPath) Then
		Do
			$hFile = FileOpen(@ScriptDir & '\Lang\' & $LangPath)
			If $hFile = -1 Then
				MsgBox(4096, "Error", "Error")
				ExitLoop
			EndIf
			$sLine = _FileReadLine($hFile)
			If @error Then ExitLoop
			$LngTitle = $sLine
			$sLine = _FileReadLine($hFile)
			If @error Then ExitLoop
			$LngBut = $sLine
			$sLine = _FileReadLine($hFile)
			If @error Then ExitLoop
			$LngButH = $sLine
			$sLine = _FileReadLine($hFile)
			If @error Then ExitLoop
			$LngLab = $sLine
			$sLine = _FileReadLine($hFile)
			If @error Then ExitLoop
			$LngSl = $sLine
			$sLine = _FileReadLine($hFile)
			If @error Then ExitLoop
			$LngType = $sLine
		Until 1
		FileClose($hFile)
		Return 1
	EndIf
EndFunc   ;==>_ReadLng

Func _FileReadLine($hFile)
	Local $sLine
	Do
		$sLine = FileReadLine($hFile)
		If @error Then Return SetError(1)
	Until $sLine And StringLeft($sLine, 1) <> ';'
	If StringInStr($sLine, '\r\n') Then $sLine = StringReplace($sLine, '\r\n', @CRLF)
	Return $sLine
EndFunc   ;==>_FileReadLine

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

Func _SetLang()
	Local $aLng
	$LangPath = GUICtrlRead($ComboLang)
	If _ReadLng() Then
		IniWrite($Ini, 'Set', 'Lang', $LangPath)
	Else
		_SetLangDef()
		IniWrite($Ini, 'Set', 'Lang', 'none')
	EndIf
	_SetLang2()
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