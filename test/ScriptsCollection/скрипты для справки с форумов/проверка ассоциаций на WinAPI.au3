#Include <WinAPIEx.au3>

If FileExists(_WinAPI_AssocQueryString('.pdf', $ASSOCSTR_EXECUTABLE)) Then
    MsgBox(0, '', '����������')
Else
    MsgBox(0, '', '�� ����������')
EndIf