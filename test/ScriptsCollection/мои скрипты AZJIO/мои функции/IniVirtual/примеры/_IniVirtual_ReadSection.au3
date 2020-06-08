; AZJIO
; http://www.autoitscript.com/forum/topic/147373-inivirtual

#include <IniVirtual.au3>
$sPath = @ScriptDir & '\Sample.ini'
$s_ini_Text = FileRead($sPath)
$a_ini_Main2D = _IniVirtual_Initial($s_ini_Text)

$aRes = _IniVirtual_ReadSection($a_ini_Main2D, 'Section2')
_ArrayDisplay($aRes, 'Массив "ключ | значение"')