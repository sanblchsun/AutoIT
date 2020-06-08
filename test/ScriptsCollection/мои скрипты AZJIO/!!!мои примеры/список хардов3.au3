#include <WindowsConstants.au3>
#include <GuiComboBox.au3>
#NoTrayIcon

GUICreate("Список", 160, 75)
$StatusBar = GUICtrlCreateLabel('Строка состояния', 5, 75 - 25, 150, 24)
GUICtrlSetFont(-1, 13)
$iCombo = GUICtrlCreateCombo('', 10, 5, 50, 23, $CBS_DROPDOWNLIST + $WS_VSCROLL) ; комбо недоступен для редактирования
_GUICtrlComboBox_SetDroppedWidth($iCombo, 340) ; делает широкий выпадающий список
GUICtrlSetFont(-1, Default, 400, 0, 'Lucida Console') ; моноширинный шрифт выстраивает текст в колонки
_ComboBox_SetDrive($iCombo, 'd')
GUISetState()

While 1
	Switch GUIGetMsg()
		Case $iCombo
			GUICtrlSetData($StatusBar, 'Выбор диска: ' & StringLeft(GUICtrlRead($iCombo), 1))
		Case -3
			ExitLoop
	EndSwitch
WEnd

Func _ComboBox_SetDrive($i_ID_Combo, $SelectDrive = 'C')
	Local $aDrives = DriveGetDrive('all'), $Current, $Type, $i, $list = '', $sString
	For $i = 1 To $aDrives[0]
		$Type = DriveGetType($aDrives[$i] & '\')

		If $aDrives[$i] = 'A:' Or  $Type = 'CDROM' Then ContinueLoop
		If $Type = 'Removable' Then $Type = 'Rem'
		$sLabel = DriveGetLabel($aDrives[$i] & '\')
		If StringLen($sLabel)>15 Then $sLabel = StringLeft($sLabel, 12) & '...'

		$sString = StringFormat("%-2s %-5s %-15s %-5s ", StringUpper($aDrives[$i]), $Type, $sLabel, _
				DriveGetFileSystem($aDrives[$i] & '\')) & ' ' & _GetSize(DriveSpaceTotal($aDrives[$i] & '\')) & ' Gb'
		$list &= '|' & $sString
		If $aDrives[$i] = $SelectDrive & ':' Then $Current = $sString
	Next
	GUICtrlSetData($i_ID_Combo, $list, $Current)
EndFunc

Func _GetSize($Drive)
	$s = StringFormat('%.03f', $Drive / 1024)
	If StringLen($s) > 7 Then
		$Right = StringRight($s, 4)
		$s = StringRegExpReplace(StringTrimRight($s, 4), '(\A\d{1,3}(?=(\d{3})+\z)|\d{3}(?=\d))', '\1 ') & $Right
	EndIf
	$s = StringFormat('%9s', $s) ; 9 терабайт
	Return $s
EndFunc