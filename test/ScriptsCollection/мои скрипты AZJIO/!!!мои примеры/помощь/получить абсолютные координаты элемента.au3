; ������ �������
Run('calc.exe') ; ������ ������������
$hWnd = WinWait('[CLASS:SciCalc]', '', 5) ; ������� ��������� ����
If $hWnd Then ; ���� ���������� �������, ��
	WinMove($hWnd, '', 100, 100)
	$wgp = WinGetPos($hWnd) ; �������� ���������� ����
	$wgcs = WinGetClientSize($hWnd) ; �������� ������ ��������� �������
	$d1 = ($wgp[2] - $wgcs[0]) / 2 ; �������� �������� ������� ������� ���� ������
	$d2 = $wgp[3] - $wgcs[1] - $d1 ; �������� �������� ������� ��������� ����
	$cgp = ControlGetPos($hWnd, '', '[CLASS:Button; INSTANCE:14]') ; �������� ���������� �������� � ��������� ������� (������ 6)
	$X = $wgp[0] + $d1 + $cgp[0] ; ���������� ���������� ������������ ���������
	$Y = $wgp[1] + $d2 + $cgp[1]
	MsgBox(0, '��������', _
	$wgp[0] & '+' & $d1 & '+' & $cgp[0] & '=' & $X & @CRLF & _
	$wgp[1] & '+' & $d2 & '+' & $cgp[1] & '=' & $Y)
	; MsgBox(0, 'Message', 'x= ' & $X & @CRLF & 'y= ' & $Y)
	WinClose($hWnd)
EndIf

; ������ ������� - �������� � ������ �������� ������� ����, ������ �������� ����� ��������
#include <WinAPI.au3>
; ����������� ������ � ������ ������ ����
$w = _WinAPI_GetSystemMetrics(32) ; ������ ������������ �������
$h = _WinAPI_GetSystemMetrics(4) + _WinAPI_GetSystemMetrics(33) ; ��������� + ������ �������������� �������
Run('calc.exe') ; ������ ������������
$hWnd = WinWait('[CLASS:SciCalc]', '', 5) ; ������� ��������� ����
If $hWnd Then ; ���� ���������� �������, ��
	WinMove($hWnd, '', 100, 100)
	$wgp = WinGetPos($hWnd) ; �������� ���������� ����
	$cgp = ControlGetPos($hWnd, '', '[CLASS:Button; INSTANCE:14]') ; �������� ���������� �������� � ��������� ������� (������ 6)
	$X = $wgp[0] + $w + $cgp[0] ; ���������� ���������� ������������ ���������
	$Y = $wgp[1] + $h + $cgp[1]
	MsgBox(0, '����� �������� ������ ����', _
	$wgp[0] & '+' & $w & '+' & $cgp[0] & '=' & $X & @CRLF & _
	$wgp[1] & '+' & $h & '+' & $cgp[1] & '=' & $Y)
	; MsgBox(0, 'Message', 'x= ' & $X & @CRLF & 'y= ' & $Y)
	WinClose($hWnd)
EndIf