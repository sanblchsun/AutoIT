$Str = '������������ ��������� ����� ����� �������� ��������. � ������ ������� ����� �������� ���������� �� ���� ������� ������ �������� ����� �������, ������� ������ ������ � ������, ���������� � ����������. ��� ���� ����� ������� ������ ����� ������������ ������������ �����, ������ �������� ���������� ����������� ��������. ���� ������ ����� "��������" ���� �� �����, �������� "��" � �������������� ��� ���������� ���������� �������� ������ ������� �� �������� �� ������. ������������ ����� ���������� � ���������� �����, ������������� �������.'


For $i = 40 to 78
    MsgBox(0, "������ "&$i, _Alignment($Str, $i, 5))
Next

Func _Alignment($sStr, $Width=90, $redstring=5)
    $timer = TimerInit() ; �������� �����
Local $StrTmp='', $String='', $TextOut='', $redstring0='', $aWord

If $redstring>0 Then 
    For $i = 1 to $redstring
        $redstring0&=' '
    Next
EndIf
$aWord = StringSplit($sStr, " ", 1)

For $i = 1 to $aWord[0]
    if StringLen($String)<=$Width-$redstring+1 Then
        $StrTmp=$String
        $String &= $aWord[$i]&' '
        If $aWord[0]=$i And StringLen($String)<=$Width-$redstring+1 Then $TextOut &= $StrTmp&' '&$aWord[$i]
        If $aWord[0]=$i And StringLen($String)>$Width-$redstring+1 Then $TextOut &= $StrTmp&@CRLF&$aWord[$i]
    Else
        $StrTmp = StringTrimRight($StrTmp,1)
        For $x = 1 to 10
            If StringLen($StrTmp)<$Width-$redstring Then
                $StrTmp = StringRegExpReplace($StrTmp, '\s+', '$0 ', $Width-$redstring-StringLen($StrTmp))
            Else
                ExitLoop
            EndIf
        Next
        $TextOut &= $StrTmp&@CRLF
        $String=$aWord[$i-1]&' '&$aWord[$i]&' '
        If $aWord[0]=$i Then $TextOut &= $aWord[$i-1]&' '&$aWord[$i]
        $redstring=0
    EndIf
Next
Return $redstring0&$TextOut&@CRLF&@CRLF&'��������� �� '&Round(TimerDiff($timer), 1)&' ����'
EndFunc