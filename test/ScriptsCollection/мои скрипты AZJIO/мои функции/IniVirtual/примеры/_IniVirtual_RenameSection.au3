; AZJIO
; http://www.autoitscript.com/forum/topic/147373-inivirtual

#include <IniVirtual.au3>
$a_ini_Main2D = _IniVirtual_Initial(FileRead(@ScriptDir & "\Sample.ini"))

$Res = _IniVirtual_RenameSection($a_ini_Main2D, 'Section2', '-- New Section --', 1)
$s_ini_Text = _IniVirtual_Save($a_ini_Main2D)
MsgBox(0, 'Содержимое ini-файла', $s_ini_Text)