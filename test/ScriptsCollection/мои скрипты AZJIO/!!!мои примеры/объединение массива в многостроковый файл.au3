Exit ; ������ ��� ������

;�������1
; �� ������� �� �������
For $element IN $aRegfileT1 ; ����������� ������� � �������������� ����
    $regfileT1&=$element&@CRLF
Next

; �� ������ �������
For $i = 0 to UBound($aRegfileT1) - 1 ; ����������� ������� � �������������� ����
$regfileT1&=$aRegfileT1[$i]&@CRLF
Next