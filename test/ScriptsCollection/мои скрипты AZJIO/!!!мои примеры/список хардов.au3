#NoTrayIcon
#include <ComboConstants.au3>
#include <WindowsConstants.au3>

GUICreate("������", 160, 75)
$StatusBar = GUICtrlCreateLabel('������ ���������', 5, 75 - 25, 150, 24)
GUICtrlSetFont(-1, 13)
$iCombo = GUICtrlCreateCombo('', 10, 5, 90, 23, $CBS_DROPDOWNLIST + $WS_VSCROLL)
_SetDataCombo($iCombo, 'd')
GUISetState()

While 1
	Switch GUIGetMsg()
		Case $iCombo
			GUICtrlSetData($StatusBar, '����� �����: ' & StringLeft(GUICtrlRead($iCombo), 1))
		Case -3
			ExitLoop
	EndSwitch
WEnd

Func _SetDataCombo($i_ID_Combo, $SelectDrive = 'C')
	Local $aDrives = DriveGetDrive('all'), $dr = 1, $Type, $i, $list = ''
	For $i = 1 To $aDrives[0]
		$Type = DriveGetType($aDrives[$i] & '\')
		If $Type = 'Removable' Then $Type = 'Rem'
		If $aDrives[$i] <> 'A:' And $Type <> 'CDROM' Then $list &= '|' & StringUpper($aDrives[$i]) & ' (' & $Type & ')'
		If $aDrives[$i] = $SelectDrive & ':' Then $dr = StringUpper($aDrives[$i]) & ' (' & $Type & ')'
	Next
	GUICtrlSetData($i_ID_Combo, $list, $dr)
EndFunc