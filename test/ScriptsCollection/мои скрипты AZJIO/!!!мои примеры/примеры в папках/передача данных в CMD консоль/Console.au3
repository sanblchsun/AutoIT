#AutoIt3Wrapper_OutFile=Program.exe
#AutoIt3Wrapper_Change2CUI=Y
; If Not @compiled Then
	; MsgBox(0, '���������', '������������� ������')
	; Exit
; EndIf
If $CmdLine[0] Then
	Switch $CmdLine[1]
		Case '/h', '-h'
			ConsoleWrite("����� �뫠 �ࠢ��")
		Case '/a', '-a'
			ConsoleWrite("��� ⥪�� �㤥� ����ᠭ � ���᮫�")
		Case Else
			Exit 2 ; ��� ������ 2, ���� �������� �� ������
	EndSwitch
Else
	Exit 1 ; ��� ������ 1, ���� ��� ����������
EndIf
Exit 0 ; ��� ������ 0, �������� �������