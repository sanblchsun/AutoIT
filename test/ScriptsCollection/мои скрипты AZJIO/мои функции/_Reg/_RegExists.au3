
MsgBox(0, '', _RegExists('HKEY_CURRENT_USER\Software\Microsoft\Windows\ShellNoRoam\MUICache'))

; AZJIO, snoitaleR
Func _RegExists($sKey)
	RegRead($sKey, '')
	Return Not (@error > 0)
EndFunc

; ������� ������������� ����� ��������� ������, � ����� � ��������
; �������� � ���, ��� ��� ��������� ����� �� ��������������, � �������� ����������, � ����� ������� ���� �������������� ����������, ��� ����������� � ����������������.
; AutoIt_Snippets �� guinness (mod AZJIO)
Func _IsRegistryExist($sKeyName, $sValueName = '')
    RegRead($sKeyName, $sValueName)
	If $sValueName == '' Then
		Return Not (@error > 0)
	Else
		Return @error = 0
	EndIf
EndFunc   ;==>_IsRegistryExist