;  @AZJIO
#NoTrayIcon ;������ � ��������� ������ ��������� AutoIt
#include <WindowsConstants.au3>
#include <GuiComboBox.au3>

; ������ �������� ����, �������, ������.
$hGui = GUICreate("���������� ������", 300, 143) ; ������ ����
If Not @Compiled Then GUISetIcon('shell32.dll', 9)
$StatusBar = GUICtrlCreateLabel('', 3, 143 - 20, 296, 17)

$start1 = GUICtrlCreateButton("-->", 5, 5, 33, 33)
$Label80 = GUICtrlCreateLabel("���������:", 45, 13, 80, 20)
$iCombo = GUICtrlCreateCombo("", 110, 11, 50, 23, $CBS_DROPDOWNLIST + $WS_VSCROLL)
GUICtrlSendMsg($iCombo, $CB_SETDROPPEDWIDTH, 340, 0) ; ������ ������� ���������� ������
GUICtrlSetFont(-1, Default, 400, 0, 'Lucida Console') ; ������������ ����� ����������� ����� � �������
_ComboBox_SetDrive($iCombo)

$start2 = GUICtrlCreateButton("-->", 5, 45, 33, 33)
$Label80 = GUICtrlCreateLabel("��������� ��� �����", 45, 53, 180, 20)
GUICtrlSetTip(-1, '��������� ��� ����� ������������ �� USB')

$start4 = GUICtrlCreateButton("-->", 5, 85, 33, 33)
$Label80 = GUICtrlCreateLabel("���������� ���������� � ������� MountStorPe", 45, 93, 260, 20)

$Readme = GUICtrlCreateButton("Readme", 215, 10, 73, 22)

GUISetState()

While 1
	Switch GUIGetMsg()
		Case $start1
			GUICtrlSetData($StatusBar, '')
			$sDrive = StringLeft(GUICtrlRead($iCombo), 1)
			If FileExists($sDrive & ':\') Then
				_RemoveLetter($sDrive)
				If FileExists($sDrive & ':\') Then
					GUICtrlSetData($StatusBar, '���� ' & $sDrive & ':\ ����������')
				Else
					GUICtrlSetData($StatusBar, '���� ' & $sDrive & ':\ ������� ��������')
				EndIf
			Else
				GUICtrlSetData($StatusBar, '��������� ���� ' & $sDrive & ':\ �����������')
			EndIf
		Case $start2
			GUICtrlSetData($StatusBar, '')
			$aDrives = DriveGetDrive('all')
			For $i = 1 To $aDrives[0]
				$sType = DriveGetType($aDrives[$i] & '\')
				If StringRegExp($aDrives[$i], '(?i)[ABX]') Or $sType = 'CDROM' Or $sType = 'Removable' Then ContinueLoop
				_RemoveLetter(StringLeft($aDrives[$i], 1))
			Next
			$sType = ''
			$aDrives = DriveGetDrive('all')
			For $i = 1 To $aDrives[0]
				$sType = $aDrives[$i] & ' - ' & DriveGetType($aDrives[$i] & '\') &@LF
			Next
			MsgBox(0, '������� ����������', $sType, 0 , $hGui)
		Case $start4
			Run('X:\PROGRAMS\MountStorage\MountStorPe.exe')
		Case $Readme
			MsgBox(0, "�������", '��� ��������� ���������� ������ ������ ���������� ������� ��� ����� � ���� ������������ ���.' & @CRLF & @CRLF & '���������� ������ ������ ���������� ��� ������ �� �� ������� �� ����� ������ � ��������. �� ��������� �������, ����� �������� ���������� �� ���� "B:\". �� ��������� ������ ����� ����� ���������� � ������� MountStorPe, �� ����� ���� ���������� ������� ������� � ���������, �������� �������� �������������� �� ����� ��������, ��������� ��������, ��������� ������ � ������� �� ��������� �������. ���������� ������ ���������� ��������, ������ �� ���������, ��� ����� �������� �� �����, �� �� ����� �������.', 0 , $hGui)
		Case -3
			ExitLoop
	EndSwitch
WEnd

Func _RemoveLetter($sDrive)
	$sPath = @TempDir & '\dismount_hdd.txt'
	$hFile = FileOpen($sPath, 2)
	FileWrite($hFile, 'select volume ' & $sDrive & @CRLF & 'remove letter=' & $sDrive)
	FileClose($hFile)
	RunWait(@SystemDir & '\DiskPart /s ' & $sPath, '', @SW_HIDE)
EndFunc   ;==>_RemoveLetter

Func _ComboBox_SetDrive($i_ID_Combo, $SelectDrive = 'C')
	Local $aDrives = DriveGetDrive('all'), $Current, $Type, $i, $list = '', $sString
	For $i = 1 To $aDrives[0]
		$Type = DriveGetType($aDrives[$i] & '\')

		If $aDrives[$i] = 'A:' Or $aDrives[$i] = 'X:' Or $aDrives[$i] = 'B:' Or $Type = 'CDROM' Then ContinueLoop
		If $Type = 'Removable' Then $Type = 'Rem'
		$sLabel = DriveGetLabel($aDrives[$i] & '\')
		If StringLen($sLabel) > 15 Then $sLabel = StringLeft($sLabel, 12) & '...'

		$sString = StringFormat("%-2s %-5s %-15s %-5s %9.03f Gb", StringUpper($aDrives[$i]), $Type, $sLabel, DriveGetFileSystem($aDrives[$i] & '\'), DriveSpaceTotal($aDrives[$i] & '\') / 1024)
		$list &= '|' & $sString
		If $aDrives[$i] = $SelectDrive & ':' Then $Current = $sString
	Next
	GUICtrlSetData($i_ID_Combo, $list, $Current)
EndFunc   ;==>_ComboBox_SetDrive