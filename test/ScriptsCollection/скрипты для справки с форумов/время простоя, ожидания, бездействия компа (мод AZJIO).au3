; http://forum.ru-board.com/topic.cgi?forum=5&topic=33902&start=1680#18
; �������������� ������� �� amel27 + CreatoR ��� ���� (AZJIO) �����
; ��������� �� SciTE, ��������� ������������ � �������

#include <Date.au3>

Global $Diff=0
AdlibRegister('_IdleWaitStart', 1000)

HotKeySet("{ESC}", "_Quit")

While 1
	Sleep(100000)
WEnd

; �������� ������ ����������� ������������.
; ���������� ����� ������������ (� �����)
Func _IdleWaitStart()
    Local $aRet, $iSave, $iTick, $LastInputInfo = DllStructCreate("uint;dword")
    DllStructSetData($LastInputInfo, 1, DllStructGetSize($LastInputInfo))
    DllCall("user32.dll", "int", "GetLastInputInfo", "ptr", DllStructGetPtr($LastInputInfo))
	$iSave = DllStructGetData($LastInputInfo, 2)
	$aRet = DllCall("kernel32.dll", "long", "GetTickCount")
    $Diff = $aRet[0] - DllStructGetData($LastInputInfo, 2)
    ConsoleWrite(_Now() & ' ' & @UserName & ' ��������� ��� ' & _TickToTimeString($Diff) & @CRLF)
EndFunc   ;==>_IdleWaitStart

Func _TickToTimeString($iTicks)
    Local $iHours, $iMins, $iSecs, $sText = ''
    _TicksToTime($iTicks, $iHours, $iMins, $iSecs)

    If $iHours Then $sText = $iHours & ' ����� '
    If $iMins Then $sText &= $iMins & ' ����� '
    If $iSecs Then $sText &= $iSecs & ' ������'
    If $sText = '' Then $sText = '������ �������'

    Return $sText
EndFunc   ;==>_TickToTimeString

Func _Quit()
    Exit
EndFunc   ;==>_Quit