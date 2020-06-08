; AZJIO
; http://www.autoitscript.com/forum/topic/147373-inivirtual

#include <IniVirtual.au3>
$sPath = @ScriptDir & '\Sample.ini'
$s_ini_Text = FileRead($sPath)
$a_ini_Main2D = _IniVirtual_Initial($s_ini_Text)

$sRes = _IniVirtual_Read($a_ini_Main2D, 'Section2', 'Key2', "Значение по умолчанию, если не найдено")
MsgBox(0, 'Сообщение', '|' & $sRes & '|')

$sRes = _IniVirtual_Read($a_ini_Main2D, 'Section3', 'par am', "Значение по умолчанию, если не найдено")
MsgBox(0, 'Сообщение', '|' & $sRes & '|')