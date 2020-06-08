#include <SelfTest_UDF.au3>
If @compiled = 0 Then 
	MsgBox (0, "", "Скрипт не откомпилирован!")
	Exit
EndIf
$sPassword = "1" ; пароль шифрования XXTEA
$iSelftestResult = _SelfTest ($sPassword) ; проверяем свою целостность
If $iSelftestResult = 0 Then MsgBox (0, "", "Файл Повреждён!" & @CRLF & $iSelftestResult)
If $iSelftestResult = 1 Then MsgBox (0, "", "Проверка Прошла успешно!" & @CRLF & $iSelftestResult)
If $iSelftestResult = 2 Then MsgBox (0, "", "Файл не содержит информации для проверки!" & @CRLF & $iSelftestResult)
