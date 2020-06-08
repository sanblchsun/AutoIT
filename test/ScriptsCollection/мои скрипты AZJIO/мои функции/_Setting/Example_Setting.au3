#include <_Setting.au3>
#include <Array.au3>

; En
$LngMs1 = 'Сообщение'
$LngMs2 = 'INI or Registry'
$LngMs3 = 'Save in the INI?'
$LngMs4 = 'Delete now in Registry?'
$LngMs5 = 'Delete now ini?'
; $LngMs = ''

; Ru
; если русская локализация, то русский язык
If @OSLang = 0419 Then
	$LngMs1 = 'Сообщение'
	$LngMs2 = 'INI или Реестр'
	$LngMs3 = 'Сохранить в ini?'
	$LngMs4 = 'Удалить теперь настройки в реестре?'
	$LngMs5 = 'Удалить теперь ini?'
EndIf

; Работаем с ini-файлом
$TrReg = 0
$sPath_ini = @ScriptDir&'\MySoft.ini'
$sPath_reg = 'HKEY_CURRENT_USER\Software\MySoft'
Global $setting[4]

If FileExists($sPath_ini) Then
	$TrReg = 0
	_ReadSet($sPath_ini, $TrReg)
Else
	If _RegExists($sPath_reg) Then
		$TrReg = 1
		_ReadSet($sPath_reg, $TrReg)
	Else
		If MsgBox(4, $LngMs2, $LngMs3) = 6 Then
			$TrReg = 0
			_DefWriteSet($sPath_ini, $TrReg)
		Else
			$TrReg = 1
			_DefWriteSet($sPath_reg, $TrReg)
		EndIf
	EndIf
EndIf

_ArrayDisplay($setting, 'Array')

; Очистка настроек для теста
If FileExists($sPath_ini) Then
	If MsgBox(4, $LngMs1, $LngMs5)=6 Then FileDelete($sPath_ini)
Else
	If _RegExists($sPath_reg) And MsgBox(4, $LngMs1, $LngMs4)=6 Then RegDelete($sPath_reg)
EndIf

Func _ReadSet($sPath, $TrReg)
	$setting[0] = _Setting_Read($sPath, 'section1', 'key1', 'default1', $TrReg)
	$setting[1] = _Setting_Read($sPath, 'section1', 'key2', 'default2', $TrReg)
	$setting[2] = _Setting_Read($sPath, 'section2', 'key1', 'default3', $TrReg)
	$setting[3] = _Setting_Read($sPath, 'section2', 'key2', 'default4', $TrReg)
EndFunc

Func _DefWriteSet($sPath, $TrReg)
	$setting[0] = 'Param1'
	$setting[1] = 'Value2'
	$setting[2] = '3333'
	$setting[3] = '4'
	_Setting_Write($sPath, 'section1', 'key1', $setting[0], $TrReg)
	_Setting_Write($sPath, 'section1', 'key2', $setting[1], $TrReg)
	_Setting_Write($sPath, 'section2', 'key1', $setting[2], $TrReg)
	_Setting_Write($sPath, 'section2', 'key2', $setting[3], $TrReg)
EndFunc