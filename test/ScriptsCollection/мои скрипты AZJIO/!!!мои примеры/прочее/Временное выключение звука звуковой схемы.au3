
;запуск сторонней программы
MsgBox(48, 'Сообщение', 'начало, звук присутствует')

;отключение звука восклицания
$SoundName=RegRead("HKCU\AppEvents\Schemes\Apps\.Default\SystemExclamation\.Current",'')
RegWrite("HKCU\AppEvents\Schemes\Apps\.Default\SystemExclamation\.Current",'',"REG_SZ",'')
;~~~~
;выполнение программы и ожидание завершения процесса
MsgBox(48, 'Сообщение', 'звука нет'&@CRLF&$SoundName)
;~~~~
; восстановление звука восклицания
RegWrite("HKCU\AppEvents\Schemes\Apps\.Default\SystemExclamation\.Current","","REG_SZ",$SoundName)
MsgBox(48, 'Сообщение', 'конец, звук возобновлён')