; ������ ��������� ������� RegexBuddy ��� ��������������. � reg-����� ����� �������� ����� ��������, ��� �� ��������� ��������� ���������.
$Regfile=@ScriptDir&'\RegexBuddy'
$i = 0
While FileExists('"'&$Regfile&'_'&$i&'.reg"')
    $i = $i + 1
WEnd
$Regfile=$Regfile&'_'&$i&'.reg'
RunWait ( @Comspec&' /C reg export "HKEY_CURRENT_USER\Software\JGsoft\RegexBuddy3\History" "'&$Regfile&'"', '', @SW_HIDE )