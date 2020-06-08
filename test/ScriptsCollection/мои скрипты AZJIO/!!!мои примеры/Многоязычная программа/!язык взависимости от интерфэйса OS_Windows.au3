; Идеальный вариант с правильным автоопределением языка интерфэйса OS. Встроенный в скрипт язык удобен при небольшом количестве переводимого текста или небольшом количестве языков.

; En
$LngAbout='About'
$LngVer='Version'

; $UserIntLang=DllCall('kernel32.dll', 'int', 'GetUserDefaultUILanguage')
; If Not @error Then $UserIntLang=Hex($UserIntLang[0],4)

; Ru
; если русская локализация, то русский язык
; If $UserIntLang = 0419 Then
If @OSLang = 0419 Then
	$LngAbout='О программе'
	$LngVer='Версия'
EndIf

MsgBox(0, $LngAbout, $LngVer)