; Author: guinness
ConsoleWrite('������� �������: ' & _GetQuarterlyValue() & @CRLF)

; ���������� ������� ������� � ���� (1�4).
Func _GetQuarterlyValue()
	Local $oWMIService = ObjGet('winmgmts:\\.\root\CIMV2'), $sReturn = ''
	Local $oColItems = $oWMIService.ExecQuery('Select Quarter From Win32_UTCTime', 'WQL')
	If IsObj($oColItems) Then
		For $oItem In $oColItems
			Return $oItem.Quarter
		Next
	EndIf
EndFunc   ;==>_GetQuarterlyValue