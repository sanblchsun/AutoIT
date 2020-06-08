#Include <File.au3> ; � �������� AutoIt3.exe ������ ���� ����� Include � ������ File.au3
#NoTrayIcon
If Not FileExists(@ScriptDir&'\base_lnk.txt') Then Exit
Global $aRecords
; ������ �����-���� � ������
If Not _FileReadToArray(@ScriptDir&'\base_lnk.txt',$aRecords) Then 
	MsgBox(4096,"������", "������ ������ �������", @error) 
	Exit 
EndIf 
; � ������� $aRecords ����� ����������� ��� ������ �����... 
; � ������ $aLnk �������� ������ ������� ��������� �� ������ ������
$aSet = StringSplit($aRecords[1], "|")
$restore_lnk2 = $aSet[1] ; ���������� ���� ��������� �� ������ � ������ ������
For $i=3 To $aRecords[0]
; ������� �������� ������ �����, ���������� ���� ��� ������ ������
If $aRecords[$i]<>'' Then
$aLnk = StringSplit($aRecords[$i], "|")
; ��������, ���� ����� �������� "\", �� ��� ���� � ����� ������� �������
If StringInStr($aLnk[1], '\') > 0 Then 
   $aDirlnk=StringRegExp($aLnk[1], "(^.*)\\(.*)$", 3)
   If Not FileExists($restore_lnk2&'\'&$aDirlnk[0]) Then DirCreate($restore_lnk2&'\'&$aDirlnk[0])
EndIf
; �������� ������
FileCreateShortcut($aLnk[2],$restore_lnk2&'\'&$aLnk[1]&'.lnk',$aLnk[3],$aLnk[4],$aLnk[5],$aLnk[6],'',$aLnk[7])
EndIf
Next