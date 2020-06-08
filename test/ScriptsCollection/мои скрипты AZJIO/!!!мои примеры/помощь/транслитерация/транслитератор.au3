#include <WindowsConstants.au3>

;читаем таблицу соответствий
$file = FileOpen(@ScriptDir&'\Translits.txt', 0)
$table = FileRead($file)
FileClose($file)

; создаём интерфейс
GUICreate('My Program', 300, 240, -1, -1, $WS_OVERLAPPEDWINDOW)
$Edit=GUICtrlCreateEdit('', 10, 10, 280, 180)
$Start=GUICtrlCreateButton('Выполнить', 200, 200, 90, 28)
$ObrTrnstF=GUICtrlCreateCheckbox('Обратное направление', 10, 200, 160, 17)
GUISetState ()
While 1
	$msg = GUIGetMsg()
	Switch $msg
		Case $Start
			If GUICtrlRead($ObrTrnstF)=4 Then
				$Trt1=StringRegExp($table, '(.*)(?:=.*?\r\n)', 3)
				$Trt2=StringRegExp($table, '(?:.*?=)(.*)(?=\r\n)', 3)
			Else
				$Trt1=StringRegExp($table, '(?:.*?=)(.*)(?=\r\n)', 3)
				$Trt2=StringRegExp($table, '(.*)(?:=.*?\r\n)', 3)
			EndIf
			$Edit0=GUICtrlRead($Edit)
			If $Edit0 Then
				For $j = 0 to UBound($Trt1)-1
					$Edit0=StringReplace($Edit0, $Trt1[$j], $Trt2[$j], 0, 1)
				Next
			EndIf
			GUICtrlSetData($Edit, $Edit0)
		Case -3
			 Exit
	EndSwitch
WEnd
