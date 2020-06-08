HotKeySet("^i", "Input") 
Opt("TrayMenuMode", 1) 
 
Global $OptionsArray[4] 
Global $DefaultNumber = 1 
 
$ChooseOption = TrayCreateItem("������� ���������� ������� � ����...") 
 
For $i = 1 To UBound($OptionsArray)-1 
    $OptionsArray[$i] = TrayCreateItem("����� " & $i) 
Next 
 
$Seperator = TrayCreateItem("") 
$ExitItem = TrayCreateItem("Exit") 
 
While 1 
    $TrayMsg = TrayGetMsg() 
 
        Switch $TrayMsg 
        Case $ExitItem 
            Exit 
        Case $ChooseOption 
            Input() 
    EndSwitch 
WEnd 
 
Func Input() 
    $Ubound = UBound($OptionsArray) ;����� ����� ������� + 1 (����� �� ������� ������ ���) 
 
        While 1 
        $Var = InputBox("", "�������� ����������� ����������", $DefaultNumber) 
        If @error Then Return ;���� ������ "������" �� ������� �� ������� 
        $Var = StringRegExpReplace($Var, '[^0-9]', '') 
 
                ;��������� ��� �� ���� ���������� ����� 
        If $Var = '' Then 
            MsgBox(48, "��������!", "������� �� ������ ����� (��� ����� �� �����)" & @LF & "������� ��� ���..", 5) 
            ContinueLoop 
        EndIf 
        ExitLoop 
    WEnd 
 
        ;���� ���� ��� ���������� ����� ��� � ������� ����, �� ������ �� ������ 
    If $Var = $Ubound-1 Then Return 
 
        ;���� ������� ������ �������, �� ������ ���������... 
    If $Var > $Ubound-1 Then 
        ReDim $OptionsArray[$Var+1] 
        For $i = $Ubound To $Var 
            $OptionsArray[$i] = TrayCreateItem("����� " & $i, -1, $i) 
        Next 
    Else ;���� ������, �� ������� ������ 
        For $i = $Var+1 To $Ubound-1 
            TrayItemDelete($OptionsArray[$i]) 
        Next 
        ReDim $OptionsArray[$Var+1] 
    EndIf 
 
        $DefaultNumber = $Var ;����� ������������ ��������� �������� ����� 
EndFunc