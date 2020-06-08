
MsgBox(0, '', _RegExists('HKEY_CURRENT_USER\Software\Microsoft\Windows\ShellNoRoam\MUICache'))

; AZJIO, snoitaleR
Func _RegExists($sKey)
	RegRead($sKey, '')
	Return Not (@error > 0)
EndFunc

; ¬аринат универсальный можно проверить раздел, а можно и параметр
; ѕроблема в том, что тип параметра может не поддерживатьс€, а параметр существует, в итоге функци€ лишь приблизительно определ€ет, что недопустимо в программировании.
; AutoIt_Snippets от guinness (mod AZJIO)
Func _IsRegistryExist($sKeyName, $sValueName = '')
    RegRead($sKeyName, $sValueName)
	If $sValueName == '' Then
		Return Not (@error > 0)
	Else
		Return @error = 0
	EndIf
EndFunc   ;==>_IsRegistryExist