;  @AZJIO
#include <WindowsConstants.au3>
#include <GUIConstants.au3>

AutoItSetOption("TrayIconHide", 1) ;������ � ��������� ������ ��������� AutoIt


Global $aDelfile
Global $aDeldir

GUICreate("�������������� ������ ��� ������",440,130, -1, -1, -1, $WS_EX_ACCEPTFILES) ; ������ ����

GUICtrlCreateLabel ("���� � ����� (����������� drag-and-drop)", 20,10,400,18)
$inputhtm=GUICtrlCreateInput ("", 20,30,400,22)
GUICtrlSetState(-1,8)


GUICtrlCreateGroup("", 20, 57, 390, 36)
GUICtrlCreateLabel ("���� �����:", 40,70,70,20)
$colorname=GUICtrlCreateCombo ("", 110,67,80,24)
GUICtrlSetData(-1,'�������|�����|������|������', '�������')

GUICtrlCreateLabel ("��� �����:", 240,70,60,20)
$colorbg=GUICtrlCreateCombo ("", 300,67,90,24)
GUICtrlSetData(-1,'��.�������|��.�����|��.������|��.�����|��.�����', '��.������')

GUICtrlCreateGroup("", 20, 95, 140, 30)
$Label000=GUICtrlCreateLabel ('������ ���������', 40,105,100,18)
$Readme=GUICtrlCreateButton ("Readme", 220,100,90,22)


$Replace=GUICtrlCreateButton ("���������", 330,100,90,22)


GUISetState ()

	While 1
		$msg = GUIGetMsg()
		Select
			Case $msg = $Replace
				$colorname0=GUICtrlRead ($colorname)
				Switch $colorname0
				Case $colorname0="�������"
				    $colorname00 = "ff0000"
				Case $colorname0="������"
				    $colorname00 = "00bb00"
				Case $colorname0="�����"
				    $colorname00 = "0000ff"
				Case $colorname0="������"
				    $colorname00 = "000000"
				Case Else
				    $colorname00 = "ff0000"
				EndSwitch
				
				
				$colorbg0=GUICtrlRead ($colorbg)
				Switch $colorbg0
				Case $colorbg0="��.�������"
				    $colorbg00 = "ffeeee"
				Case $colorbg0="��.������"
				    $colorbg00 = "eeffee"
				Case $colorbg0="��.�����"
				    $colorbg00 = "eeeeff"
				Case $colorbg0="��.�����"
				    $colorbg00 = "eeeeee"
				Case $colorbg0="��.�����"
				    $colorbg00 = "fffddb"
				Case Else
				    $colorbg00 = "eeffee"
				EndSwitch
				
				
				$inputhtm0=GUICtrlRead ($inputhtm)
				; ��������� �������������, ������ ����� � ��������� ���� ��� ������ ������
				If Not FileExists($inputhtm0) Then
					MsgBox(0, "������ ������", '����������� ���� '&$inputhtm0)
					ContinueLoop
				EndIf
				$aPathname = StringRegExp($inputhtm0, "(^.*)\\(.*)$", 3)
				  $filehtm = FileOpen($inputhtm0, 0)
				; �������� �������� ����� ��� ������ ������
				If $filehtm = -1 Then
				  MsgBox(0, "������", "�� �������� ������� ����.")
				  Exit
				EndIf
				; ������ ����������
				$filehtm0 = FileRead($filehtm)
				
				
						   $SR1 = StringReplace($filehtm0, '<br><b>�����:</b> ', '<br>�����:<FONT color=#'&$colorname00&'><b> ')
						   $SR1 = StringReplace($SR1, ', <b>����������:</b>', '</b></FONT>, ����������: ')
						   $SR1 = StringReplace($SR1, '<img width=100% height=1 src="1px.gif" alt="">', "")
						   $SR1 = StringReplace($SR1, '<tr bgcolor=#FFFFFF>', '<tr bgcolor=#'&$colorbg00&'>')
				  
				  $filehtmnew = FileOpen($aPathname[0]&"\new_"&$aPathname[1], 2)
				  FileWrite($filehtmnew, $SR1)
				  FileClose($filehtm)
				  FileClose($filehtmnew)
				  GUICtrlSetData($Label000, '������...')
			Case $msg = $Readme
				  MsgBox(0, "Readme", '�� ������� ������ ��������� ��������� ��� "������ ��� ������", ���� ����� �� ������ �� ���� ����� �����������, ��� ����� �� ���������. �� ����������� ��������� ������������, ����� ������� � �� ����� ��������� � ������ ����� - ������ �� �����. ��� ����������� ���������� ��������� ��������� � ������ *.htm � ���� ���������, �������� �����, ��������� ������ � ����� ������� "���������", ��������� ��������� � �������� � ������ � ������� ����.')
			Case $msg = $GUI_EVENT_CLOSE
				ExitLoop
		EndSelect
	WEnd

