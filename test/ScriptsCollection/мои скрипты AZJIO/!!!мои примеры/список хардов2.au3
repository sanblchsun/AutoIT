#include <WindowsConstants.au3>
#include <GuiComboBox.au3>
#NoTrayIcon

GUICreate("������", 160, 75)
$StatusBar = GUICtrlCreateLabel('������ ���������', 5, 75 - 25, 150, 24)
GUICtrlSetFont(-1, 13)
$iCombo = GUICtrlCreateCombo('', 10, 5, 50, 23, $CBS_DROPDOWNLIST + $WS_VSCROLL) ; ����� ���������� ��� ��������������
_GUICtrlComboBox_SetDroppedWidth($iCombo, 340) ; ������ ������� ���������� ������
GUICtrlSetFont(-1, Default, 400, 0, 'Lucida Console') ; ������������ ����� ����������� ����� � �������
_ComboBox_SetDrive($iCombo, 'd')
GUISetState()

While 1
	Switch GUIGetMsg()
		Case $iCombo
			GUICtrlSetData($StatusBar, '����� �����: ' & StringLeft(GUICtrlRead($iCombo), 1))
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

		$sString = StringFormat("%-2s %-5s %-15s %-5s %9.03f Gb", StringUpper($aDrives[$i]), $Type, $sLabel, DriveGetFileSystem($aDrives[$i] & '\'), DriveSpaceTotal($aDrives[$i] & '\') / 1024)
		$list &= '|' & $sString
		If $aDrives[$i] = $SelectDrive & ':' Then $Current = $sString
	Next
	GUICtrlSetData($i_ID_Combo, $list, $Current)
EndFunc