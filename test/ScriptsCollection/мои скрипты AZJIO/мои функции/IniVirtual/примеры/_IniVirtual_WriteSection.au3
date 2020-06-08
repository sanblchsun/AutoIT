; AZJIO
; http://www.autoitscript.com/forum/topic/147373-inivirtual

#include <IniVirtual.au3>
$sPath = @ScriptDir & '\Sample.ini'
$s_ini_Text = FileRead($sPath)
$a_ini_Main2D = _IniVirtual_Initial($s_ini_Text)

$sText= _
'NewKey1=NewValue1' & @CRLF & _
'NewKey2=NewValue2'

; Запись секции (текст)
_IniVirtual_WriteSection($a_ini_Main2D, 'Section6', $sText)

; Чтение записанной секции
$aRes = _IniVirtual_ReadSection($a_ini_Main2D, 'Section6')
_ArrayDisplay($aRes, 'Секция Section6')

; Проверка при сохранении
$s_ini_Text = _IniVirtual_Save($a_ini_Main2D)
MsgBox(0, 'Содержимое ini-файла', $s_ini_Text)

; Global $aRes[3][2] = [[2], ['NewKey1', 'NewValue1'], ['NewKey2', 'NewValue2']]

; Запись секции (массива), со 2 индекса
_IniVirtual_WriteSection($a_ini_Main2D, 'Section3', $aRes, 2)

; Проверка при сохранении
$s_ini_Text = _IniVirtual_Save($a_ini_Main2D)
MsgBox(0, 'Содержимое ini-файла', $s_ini_Text)