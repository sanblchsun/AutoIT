
 ; �������� ����������
$sKey = 'HKCR\' & RegRead('HKCR\.pdf', '')
$sShell =  RegRead($sKey & '\shell', '')
If Not $sShell Then
    $sShell = 'open'
EndIf
$sPath = StringRegExpReplace(RegRead($sKey & '\shell\' & $sShell & '\command', ''), '(?:"?)+((?:.*\\)?.*?\..*?)(?:"?)+ (.*)$', '\1')
If FileExists($sPath) Then
    MsgBox(0, '', '����������')
Else
    MsgBox(0, '', '�� ����������')
EndIf
