; ������ ExtMsgBox

#include <GUIConstantsEx.au3>
#include <Constants.au3>
#include <StaticConstants.au3>

#include "ExtMsgBox.au3"

; ������������� ���� ������� Test 5
$fTest5_Again = True

$hTest_GUI = GUICreate("EMB ����", 200, 490, 100, 100)
$hButton1 = GUICtrlCreateButton("���� 1", 20, 20, 60, 30)
$hButton2 = GUICtrlCreateButton("���� 2", 120, 20, 60, 30)
$hButton3 = GUICtrlCreateButton("���� 3", 20, 70, 60, 30)
$hButton4 = GUICtrlCreateButton("���� 4", 120, 70, 60, 30)
$hButton5 = GUICtrlCreateButton("���� 5", 20, 120, 60, 30)
$hButton6 = GUICtrlCreateButton("���� 6", 120, 120, 60, 30)
$hButton7 = GUICtrlCreateButton("Exit", 70, 450, 60, 30)

$sMsg = "����������� ��� ���� �� ������, ����� ������� ��� ������������ �������� ���� ���������� ��������� ��������." & @CRLF & @CRLF
$sMsg &= "���� �� ��������� ��� ���� ������� ������ � ���� ������, �� ���������� �������� ���� ����� ��������������� ���, ����� �� ���� �������� �������� �� ���� ������."
If @Compiled = 0 Then $sMsg &= @CRLF & @CRLF & "���������� � ������� SciTE, ����� ������� ������������ �������� ������� ������"

GUICtrlCreateLabel($sMsg, 10, 160, 180, 270, $SS_CENTER)
GUICtrlSetFont(-1, 10)
GUISetState(@SW_SHOW, $hTest_GUI)

While 1

	Switch GUIGetMsg()
		Case $GUI_EVENT_CLOSE, $hButton7

			_ExtMsgBoxSet(1)
			$nTest = _ExtMsgBox(32, "��|&���", "�������������", "�� �������?", 0, $hTest_GUI)
			_ExtMsgBoxSet(Default)
			ConsoleWrite("The 'Exit' EMB returned: " & $nTest & @CRLF)
			If $nTest = 1 Then Exit

		Case $hButton1

			; ��������� ������������ �� ������, ������ ������, ������� ���� ��� ���������
			_ExtMsgBoxSet(2, $SS_CENTER, -1, -1, 9)

			$sMsg = "��� �� ������ ������������� ���� 'EMB ����', � ������� AutoIt, 4 ������, � ������������� ������ �� ������, ������ �� ������ ����� � �� ������������ ����� '������ ���� ����' (TOPMOST)" & @CRLF & @CRLF
			$sMsg &= "������ ��������������� ����������� �����������, ����� �������� 4-� ������ � ����� ����� ����������� �� ������� ��� ������������� ����� ����������" & @CRLF & @CRLF
			$sMsg &= "������ 4 ��������������� �� ��������� � ����� ������������ ��� ������� 'Enter' ��� 'Space' (������)" & @CRLF & @CRLF
			$sMsg &= "����� �������� �������� �� ������������ �� ������������"
			$iRetValue = _ExtMsgBox(@AutoItExe, "1|2|3|&4", "���� 1", $sMsg, 20, $hTest_GUI)
			ConsoleWrite("���� 1 ���������: " & $iRetValue & @CRLF)

			; ����� �� ���������
			_ExtMsgBoxSet(Default)

		Case $hButton2

			; �������� ������������ GUI, ����� �������� ���������� ���� � ������ ������
			GUISetState(@SW_HIDE, $hTest_GUI)

			; �������� ����� � ������������, ������� ���� ��� ���������
			_ExtMsgBoxSet(1 + 4, $SS_LEFT, -1, -1, 12, "Arial")

			$sMsg = "�������� 'EMB Test', � ���������� � ������ ������" & @CRLF & @CRLF
			$sMsg &= "������� ���������:" & @CRLF
			$sMsg &= @TAB & "������ '����������'" & @CRLF
			$sMsg &= @TAB & "���� ��������� ������" & @CRLF
			$sMsg &= @TAB & "������������ �� ������ ����" & @CRLF
			$sMsg &= @TAB & "Default button text" & @CRLF
			$sMsg &= @TAB & "����������� �� ������ �����" & @CRLF
			$sMsg &= @TAB & "����� '������ ���� ����'" & @CRLF & @CRLF
			$sMsg &= "������ ��������������� �� ����� ������������ ������" & @CRLF & @CRLF
			$sMsg &= "(������� ������ ��� ������������ ������ ���� ���������)" & @CRLF & @CRLF
			$sMsg &= "����� �������� �������� �� ������������ 20 ���"

			; ������������� �������� $MB_... � ��������� ��������
			$iRetValue = _ExtMsgBox($EMB_ICONINFO, "����� �����.", "���� 2", $sMsg, 20, $hTest_GUI)
			ConsoleWrite("���� 2 ���������: " & $iRetValue & @CRLF)

			; ����� �� ���������
			_ExtMsgBoxSet(Default)

			; ���������� ������������ GUI �����
			GUISetState(@SW_SHOW, $hTest_GUI)
			WinSetOnTop($hTest_GUI, "", 1)
			WinSetOnTop($hTest_GUI, "", 0)

		Case $hButton3

			; ������������� ������������ �� ������� ����, ���� (����� ����� �� ������ ����) � �������� �����
			_ExtMsgBoxSet(1, 2, 0x004080, 0xFFFF00, 10, "Comic Sans MS")

			$sMsg = "��� ���������� ���� �� ������ ������������� ���� 'EMB ����', � ������� ���������������� �����, 2 ������, ������� �����, ������������ �������� ������ �� ������� ����, "
			$sMsg &= "�� ������� ����, ����������� �� ������ �����, � ���������� ����� '������ ���� ����' (TOPMOST)" & @CRLF & @CRLF
			$sMsg &= "�������� ��������, �� ������ �������� && � ������ ������" & @CRLF & @CRLF
			$sMsg &= "����� �������� �������� �� ������������ �� ������������"

			; ������������� �������� $MB_...
			$iRetValue = _ExtMsgBox($EMB_ICONEXCLAM, "1 ������|&�� && ���", "���� 3", $sMsg, 0, $hTest_GUI)
			ConsoleWrite("���� 3 ���������: " & $iRetValue & @CRLF)

			; ����� �� ���������
			_ExtMsgBoxSet(Default)

		Case $hButton4

			; ������������ ������ � ������
			_ExtMsgBoxSet(1, 4, -1, -1, 11)

			$sMsg = "���������� ������������� ���� �� �������, ������� ������ �� ������ ������" & @CRLF & @CRLF
			$sMsg &= "������ '����', ���� ������ �� ������, ����� ������������� �� ������ ����, ������� ����� (?), ����������� �� ������ �����, ���������� ����� '������ ���� ����' (TOPMOST)" & @CRLF & @CRLF
			$sMsg &= "����� ��������� ����� ������� �����, ������� ������ ���� ��������� ����������� � ������������ �� ��������� � ����� ������������� ����������� �� ����� ������, ��� ��� ������ ������� �������, ����� ���������" & @CRLF & @CRLF
			$sMsg &= "����� �������� �������� �� ������������ 15 ���" & @CRLF & @CRLF & @CRLF & @CRLF & @CRLF & @CRLF & @CRLF & @CRLF
			$sMsg &= "�������� ��������, ��� ���������� ���� ������������� ��������������, ����� ���������� ����������� ������, ���� ���� ��� ���������� ��������� ���!"

			$iRetValue = _ExtMsgBox($EMB_ICONSTOP, "OK", "���� 4", $sMsg, 15)
			ConsoleWrite("���� 4 ���������: " & $iRetValue & @CRLF)

			; ����� �� ���������
			_ExtMsgBoxSet(Default)

		Case $hButton5

			; ������ ������ ���� ���������� ����
			If $fTest5_Again Then

				; ������������� ����� ������ �� ���������, "Not again" checkbox, no titlebar icon
				_ExtMsgBoxSet(4 + 16 + 32, 0, Default, Default, 14, "Consolas")

				$sMsg = "����� �������� ���������� ����, � �� ����������, "
				$sMsg &= "������� ���� ��������� � ����������� 200, 200." & @CRLF & @CRLF
				$sMsg &= "������ '������', ������ �� ������ �����, ���������� ����� '������ ���� ����' (TOPMOST) � ������������ ����� �� ���������" & @CRLF & @CRLF
				$sMsg &= "����� �������� �������� �� ������������ �� ������������"

				$iRetValue = _ExtMsgBox($EMB_ICONQUERY, $MB_OK, "���� 5", $sMsg, 0, 200, 200)
				ConsoleWrite("���� 5 ���������: " & $iRetValue & @CRLF)

				; ������� ���� ��� ������� ��� �������
				If $iRetValue < 0 Then $fTest5_Again = False

				; ����� �� ���������
				_ExtMsgBoxSet(Default)

			Else

				ConsoleWrite("Test 5 will not run again" & @CRLF)

			EndIf

		Case $hButton6

			; ������������� ������������ �� ������� ����, ���� (��������� ����� �� ������ ����) � �������� �����
			; _ExtMsgBoxSet(3, 0, 0x008000, 0xFF8000, 12, "MS Sans Serif") ; ��������
			; _ExtMsgBoxSet(3, 0, 0xf1f1ef, 0x3a6a7e, 12, "MS Sans Serif") ; �������
			; _ExtMsgBoxSet(3, 0, 0xfdf3ac, 0xa13d00, 12, "MS Sans Serif")
			_ExtMsgBoxSet(1 + 2 + 64, 0, 0x005a39, 0xffbf1e, 12, "MS Sans Serif")

			$sMsg = "����� �������� ���������� ����, � �� ����������, "
			$sMsg &= "������� ���� ��������� � ����������� 100, 500." & @CRLF & @CRLF
			$sMsg &= "�� ����� ������, ����������� �� ������ �����, �� ���������� ����� '������ ���� ����' (TOPMOST), ������� ����� � ��� "
			$sMsg &= "����� �������� �������� �� ������������ 20 ���"

			$iRetValue = _ExtMsgBox(128, " ", "���� 6", $sMsg, 20, 100, 500)
			ConsoleWrite(@error & @CRLF)
			ConsoleWrite("���� 6 ���������: " & $iRetValue & @CRLF)

			; ����� �� ���������
			_ExtMsgBoxSet(Default)

	EndSwitch

WEnd