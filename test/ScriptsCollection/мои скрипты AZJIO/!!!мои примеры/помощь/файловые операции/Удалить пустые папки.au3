#include <Array.au3>
#include <FileOperations.au3>

$timer = TimerInit() ; ������ ��� �������� ������
$aFolderList = _FO_SearchEmptyFolders(@WindowsDir) ; ���� ��� ������� ������, �� ������� ������� � �� ������ �����
If @error Then Exit
_ArrayDisplay($aFolderList, '����� : ' & Round(TimerDiff($timer) / 1000, 2) & ' ���', -1, 0, '', '|', '�|������ �����') ; �������� ��������� ������� �����

If MsgBox(4 + 262144, '���������', '������� ������ ����� ?') = 6 Then ; ���� ����� ����� 6, ��� ������� "��", �����
	$err = '' ; ���������� ��� ���� ������
	For $i = 1 To $aFolderList[0] ; ���� �������� �����
		If Not FileRecycle($aFolderList[$i]) Then ; ���� �� ������� ����������� � �������, �����
			If Not (FileSetAttrib($aFolderList[$i], '-RST') And FileRecycle($aFolderList[$i])) Then ; ���� �� ������� ����� �������� � ����������� � �������, �����
				$err &= $aFolderList[$i] & @CRLF ; ����� ���
			EndIf
		EndIf
	Next
	If $err Then MsgBox(0, '��� ������', $err) ; ���� ��� ������ �� ������, �� ������� ���
EndIf

; FileRecycle($aFolderList[$i], 1) ; �������� � �������
; DirRemove($aFolderList[$i], 1) ; �������� ��������