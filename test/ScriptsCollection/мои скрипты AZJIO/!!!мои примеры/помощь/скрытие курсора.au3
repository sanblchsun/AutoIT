; #Include <Misc.au3>
; Global $dll = DllOpen("user32.dll") ; ��� _IsPressed
Global $DW=@DesktopWidth, $DH=@DesktopHeight
Global $t[2]=[2,2], $Tr=0, $s[2]=[$DW/2, $DH/2], $m, $Tr2=0
AdlibRegister('_Exit', 40000) ; ����� ����� 40 ������ ������
HotKeySet('{ESC}', '_Exit')


While 1
	Sleep(50)
	$m=MouseGetPos() ; �������� ���������� �������
	If $m[0]=$t[0] And $m[1]=$t[1] Then ; ���� ���������� �� ����������
		; ToolTip('���� ��', 0, 0)
		If Not $Tr Then
			$Tr=1 ; ������ ������� ������������� � True
			If Not $Tr2 Then AdlibRegister('_Wait_and_block', 700) ; ������������ ������� ��������
			; ToolTip('���� 1', 0, 0)
		EndIf
	Else ; �����, ���� ���������� ����������
		$t=$m
		; ToolTip('���� ���', 0, 0)
		If $Tr2 Then _Free() ; ���� ������ ����� �� ����������� ���
	EndIf
WEnd

Func _Wait_and_block()
	AdlibUnRegister('_Wait_and_block')
	$m=MouseGetPos()
	; If _IsPressed("01", $dll) Then Return ; �� ������� ���� ������������ ������� ������ ����
	; ���� ����� 700 ������� ���������� �� ����������, �� ��������� ������� ����
	If $m[0]=$t[0] And $m[1]=$t[1] Then
		; ToolTip('����������', 0, 0)
		$s=$t ; ��������� ���������� ��� ��������������
		$t[0]=$DW-1 ; ������������� ���������� ������� ��� $t � $m
		$t[1]=$DH-1
		$m=$t
		MouseMove($DW-1, $DH-1, 0) ; ���������� ������ � ������� ������� - ���� ������
		$Tr2=1
	Else
		$Tr=0
	EndIf
EndFunc

Func _Free()
	; ToolTip('������������', 0, 0)
	MouseMove($s[0], $s[1], 0)
	$Tr=0
	$Tr2=0
EndFunc

Func _Exit()
	MouseMove($s[0], $s[1], 0)
	DllClose($dll)
	Exit
EndFunc