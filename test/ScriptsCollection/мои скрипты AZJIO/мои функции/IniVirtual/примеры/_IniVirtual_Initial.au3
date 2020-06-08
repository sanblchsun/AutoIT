; AZJIO
; http://www.autoitscript.com/forum/topic/147373-inivirtual

#include <IniVirtual.au3>

$sPath = _Sample()
$s_ini_Text = FileRead($sPath)
$a_ini_Main2D = _IniVirtual_Initial($s_ini_Text)
_ArrayDisplay($a_ini_Main2D, 'Array INI')

Func _Sample()
	Local $sText = _
		'[Section1]' & @CRLF & _
		'Path = C:\Program Files\AutoIt3\AutoIt3.exe' & @CRLF & _
		'Width = 128' & @CRLF & _
		'Count = 12645' & @CRLF & _
		@CRLF & _
		'[Section2]' & @CRLF & _
		'Key1=Value1' & @CRLF & _
		'Key2=Value2' & @CRLF & _
		'Key3=Value3' & @CRLF & _
		'Key4=Value4' & @CRLF & _
		@CRLF & _
		'[Section3]' & @CRLF & _
		'p[ar;am = " spe1 "' & @CRLF & _
		'	par am='' spe2 ''' & @CRLF & _
		'param = spe3 	'

	Local $sPath = @ScriptDir & '\Sample.ini'
	Local $hFile = FileOpen($sPath, 2)
	FileWrite($hFile, $sText)
	FileClose($hFile)
	Return $sPath
EndFunc   ;==>_Sample