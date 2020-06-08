#include <GUIConstants.au3>

GUICreate("My GUI Progressbar",250,200, 100,200) ; ������ ���� � ��������
$progress1 = GUICtrlCreateProgress (10,10,180,20) ; �������������� �����������
$progress2 = GUICtrlCreateProgress (10,40,180,20, 0x00000008) ; �������
$progress3 = GUICtrlCreateProgress (220,10,20,150, 4) ; ������������
$Start = GUICtrlCreateButton ("�����",10,70,90,30)
$Stop= GUICtrlCreateButton ("����",110,70,90,30)
$Slider = GUICtrlCreateSlider(20, 110, 120, 30) ; ���������
GUICtrlSetData($Slider,80)
$Lab = GUICtrlCreateLabel("80", 150, 117, 25, 18)
GUISetState () ; ���������� ���� ����� �������� ��������� (������, ��������� � �.�.)

While 1
	$msg = GUIGetMsg() ; � ����� (While 1...WEnd) ���������� ����� �������������� � GUI (������� ������ � ������ ��������) 1000 ��� � �������
	Select ; �����. ���� ������� ����� �� ������ � ���������� $Start, �� ��������� ������������������ ���� �� ���������� Case
		Case $msg = $Start
			$i = 0
; ������ ����� � �������������� Do...Until
			Do
				$i += 1
				$t=100-GUICtrlRead($slider)
        		GUICtrlSetData ($Lab,100-$t)
        		GUICtrlSetData ($progress1,$i*4)
        		GUICtrlSetData ($progress2,$i) ;����������
        		GUICtrlSetData ($progress3,$i*4)
        		Sleep($t+10)
        		If $i = 25 Then $i = 0
    		Until GUIGetMsg() = $Stop or GUIGetMsg() = $GUI_EVENT_CLOSE
#cs
; ������ ����� �� ����� � �������������� For...Next
			For $i = 0 To 25 Step 1
				$t=100-GUICtrlRead($slider)
        		GUICtrlSetData ($Lab,100-$t)
        		If GUIGetMsg() = $GUI_EVENT_CLOSE Then Exit
        		If GUIGetMsg() = $Stop Then ExitLoop
        		GUICtrlSetData ($progress1,$i*4)
        		GUICtrlSetData ($progress2,$i) ;����������
        		GUICtrlSetData ($progress3,$i*4)
        		Sleep($t+10)
        		If $i = 25 Then $i = 0
    		Next
			
; ������ ����� �� ����� � �������������� While...WEnd
			While not GUIGetMsg() = $Stop or not GUIGetMsg() = $GUI_EVENT_CLOSE ; ���� �� ������ ������ $Stop ��� "�������", �� ��������� ���������� �����.
				$i += 1
				$t=100-GUICtrlRead($slider)
        		GUICtrlSetData ($Lab,100-$t)
        		GUICtrlSetData ($progress1,$i*4)
        		GUICtrlSetData ($progress2,$i) ;����������
        		GUICtrlSetData ($progress3,$i*4)
        		Sleep($t+10)
        		If $i = 25 Then $i = 0
    		WEnd
#ce
		Case $msg = $GUI_EVENT_CLOSE
			ExitLoop
	EndSelect
WEnd
