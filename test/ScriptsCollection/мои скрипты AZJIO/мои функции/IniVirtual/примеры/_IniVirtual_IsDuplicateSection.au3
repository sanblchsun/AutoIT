; AZJIO
; http://www.autoitscript.com/forum/topic/147373-inivirtual

#include <IniVirtual.au3>
$s_ini_Text = _
	'[Section1]' & @CRLF & _
	'Path = C:\Program Files\AutoIt3\AutoIt3.exe' & @CRLF & _
	'Path = C:\File' & @CRLF & _
	@CRLF & _
	'[Section1]' & @CRLF & _
	'Key1=Value1' & @CRLF & _
	'Key2=Value2'
$a_ini_Main2D = _IniVirtual_Initial($s_ini_Text)

; Возвращает первый попавшийся дубликат или False
MsgBox(0, 'Проверка наличия дубликатов', _IniVirtual_IsDuplicateSection($a_ini_Main2D))