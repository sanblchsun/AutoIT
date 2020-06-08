#NoTrayIcon
#include <GUIConstantsEx.au3>
#include <WindowsConstants.au3>

$hGui = GUICreate('My Program', 250, 260, -1, -1, $WS_OVERLAPPEDWINDOW, $WS_EX_ACCEPTFILES)
$Button1 = GUICtrlCreateButton('����', 10, 10, 70, 28)
$StatusBar = GUICtrlCreateLabel('StatusBar', 5, 260 - 40, 240, 34)
GUICtrlSetState(-1, $GUI_DROPACCEPTED) ; �� ������� $StatusBar ����� ������� ���� (drag-and-drop)
GUISetState()

While 1
	Switch GUIGetMsg()
		Case $GUI_EVENT_CLOSE ; �����
			Exit

		Case $GUI_EVENT_MINIMIZE ; ��������
			MsgBox(0, "��������� �������", "������������ ����", 2, $hGui)

		Case $GUI_EVENT_RESTORE ; ������������
			MsgBox(0, "��������� �������", "�������������� ����", 2, $hGui)

		Case $GUI_EVENT_MAXIMIZE ; ����������
			MsgBox(0, "��������� �������", "���� ��������� �� ���� �����", 2, $hGui)

		Case $GUI_EVENT_MOUSEMOVE ; ����������� �������
			$aPos = MouseGetPos()
			WinSetTitle($hGui, '', 'X= ' & $aPos[0] & ", Y= " & $aPos[1])

		Case $GUI_EVENT_PRIMARYDOWN
			$a = GUIGetCursorInfo()
			If $a[4] = $Button1 Then ContinueLoop
			GUISetCursor(3)
			_StatusBar($StatusBar, '������ �������� ������ ����')

		Case $GUI_EVENT_PRIMARYUP
			$a = GUIGetCursorInfo()
			If $a[4] = $Button1 Then ContinueLoop
			GUISetCursor(2)
			_StatusBar($StatusBar, '�������� �������� ������ ����', 0x0080FF)

		Case $GUI_EVENT_SECONDARYDOWN
			_StatusBar($StatusBar, '������ ��������� ������ ����', 0xE600E6)

		Case $GUI_EVENT_SECONDARYUP
			_StatusBar($StatusBar, '�������� ��������� ������ ����', 0x6e7dd0)

		Case $GUI_EVENT_RESIZED
			$aClientSize = WinGetClientSize($hGui)
			_StatusBar($StatusBar, '������:' & @TAB & $aClientSize[0] & @CRLF & _
					'������:' & @TAB & $aClientSize[1], 0x009900)

		Case $GUI_EVENT_DROPPED
			_StatusBar($StatusBar, @GUI_DRAGFILE, 0x6e7dd0)

		Case $Button1
			_StatusBar($StatusBar, '������ ������ "����"', 0xdb7100)
	EndSwitch
WEnd

Func _StatusBar($ID, $sText, $iColor=0xff0000)
	GUICtrlSetData($ID, $sText)
	For $i = 1 To 3
		GUICtrlSetBkColor($ID, $iColor)
		GUICtrlSetColor($ID, 0xffffff)
		Sleep(40)
		GUICtrlSetBkColor($ID, -1)
		GUICtrlSetColor($ID, $iColor)
		Sleep(40)
	Next
	Sleep(200)
	GUICtrlSetColor($ID, 0x0)
EndFunc