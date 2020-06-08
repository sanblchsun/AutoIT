
;  @AZJIO
#include <EditConstants.au3>
#include <GUIConstantsEx.au3>
#include <WindowsConstants.au3>
#include "GraphGDIPlus.au3"
#NoTrayIcon
Global $Um, $Rn, $Cf, $f, $k2, $k3, $R1rt, $R2rt, $ktr, $In, $Rtr, $kp, $Ucr, $Ud1, $Ud2, $Ar

$GUI = GUICreate("�������� ������������ � �������������� ����� �������",590,530)

; $start = GUICtrlCreateButton("�����������", 480, 485, 97, 33)

$Um00 = GUICtrlCreateInput("12", 10, 298, 40, 20)
GUICtrlCreateLabel("������� ���������� ��� ��������, �.", 55, 300, 190, 17)

$Rn00 = GUICtrlCreateInput("9", 10, 323, 40, 20)
GUICtrlCreateLabel("������������� ��������, ��.", 55, 325, 190, 17)

$Cf00 = GUICtrlCreateInput("1370", 10, 348, 40, 20)
GUICtrlCreateLabel("������� ������������, ���.", 55, 350, 190, 17)

$f00 = GUICtrlCreateInput("100", 10, 373, 40, 20)
GUICtrlCreateLabel("������� ���������, �� (100 �� ��� ������� ���������� ���� 50 ��).", 55, 375, 360, 17)

$k200 = GUICtrlCreateInput("0", 10, 398, 40, 20)
GUICtrlCreateLabel("�����. ��� ����������� ������� U2 �����/����. (�����, ����������)", 55, 400, 360, 17)

$k300 = GUICtrlCreateInput("0", 10, 423, 40, 20)
GUICtrlCreateLabel("�����. ��� ����������� ������� U3 �����/���� (����. ����.���).", 55, 425, 360, 17)

$R1rt00 = GUICtrlCreateInput("0.1", 10, 448, 40, 20)
GUICtrlCreateLabel("������������� ��������� ������� ��������������, ��.", 55, 450, 360, 17)

$R2rt00 = GUICtrlCreateInput("0.1", 10, 473, 40, 20)
GUICtrlCreateLabel("������������� ��������� ������� ��������������, ��.", 55, 475, 360, 17)

$ktr00 = GUICtrlCreateInput("1", 10, 498, 40, 20)
GUICtrlCreateLabel("�����. ������������� (����������, ���� k��>1).", 55, 500, 360, 17)

_Read()

GUICtrlCreateLabel('', 250, 303, 1, 63 ,0x11)
$Label_Ucr = GUICtrlCreateLabel('', 260, 300, 190, 17)
$Label_In = GUICtrlCreateLabel('', 260, 325, 190, 17)
$Label_kp = GUICtrlCreateLabel('', 260, 350, 190, 17)

; �������� ���� ���������
$Graph = _GraphGDIPlus_Create($GUI,40,10,530,260,0xFF000000,0xFFCEE3E0)

;������ ������� ��� ������
_start()

GUISetState ()
GUIRegisterMsg($WM_COMMAND, 'WM_COMMAND')

While 1
	Switch GUIGetMsg()
		; Case $start
			; _Read()
			; _start()
		Case -3
			Exit
	EndSwitch
WEnd

Func WM_COMMAND($hWnd, $imsg, $iwParam, $ilParam)
    Local $nNotifyCode, $nID, $sText
    $nNotifyCode = BitShift($iwParam, 16)
    $nID = BitAND($iwParam, 0xFFFF)
    Switch $hWnd
        Case $GUI
            Switch $nID
                Case $Um00, $Rn00, $Cf00, $f00, $k200, $k300, $R1rt00, $R2rt00, $ktr00
                    Switch $nNotifyCode
                        Case $EN_CHANGE
                            _Read()
							_start()
                    EndSwitch
            EndSwitch
    EndSwitch
    Return $GUI_RUNDEFMSG
EndFunc   ;==>WM_COMMAND

Func _Read() ; ������ ����������, ����������� ����.
$Um = GUICtrlRead($Um00)
$Rn = GUICtrlRead($Rn00)
$Cf = GUICtrlRead($Cf00)
$f = GUICtrlRead($f00)
$k2 = GUICtrlRead($k200)
$k3 = GUICtrlRead($k300)
$R1rt = GUICtrlRead($R1rt00)
$R2rt = GUICtrlRead($R2rt00)
$ktr = GUICtrlRead($ktr00)
$In=$Um/$Rn
$Rtr=$R1rt*$ktr+$R2rt
$kp=1-$Rtr/($Rtr+$Rn)
$Ucr=$Um/Sqrt(2)
$Ud1=($Um+$k3)*$kp
$Ud2=$Ud1-($Um-50000*$Um/($f*$Rn*$Cf)+$k3)*$kp
$Ar=ASin($Ud2/($Ud1*0.025*3.14))
EndFunc

Func _start()
_GraphGDIPlus_Clear($Graph)
;----- ����� �� ��� XY
_GraphGDIPlus_Set_RangeX($Graph,0,20,10,1,0)
_GraphGDIPlus_Set_RangeY($Graph,0,$Um*1.1,10,1,1)
;----------------------------------------------------------����,     �������, ,����������
;----- ����� �� ��� XY
_GraphGDIPlus_Set_GridX($Graph,1,0xFF6993BE)
_GraphGDIPlus_Set_GridY($Graph,$Um*1.1/10,0xFF6993BE)
_GraphGDIPlus_Set_PenSize($Graph,1)

; ���� �������� ����������� � RGB, �.�. 0xFF339966=0xFF+RGB
_Draw_Graph3(0xFF339966) ; U3 ������ ���������� �����
_Draw_none() ; ����� ������� �� ��������� ����, ��� ��� ������� ������ ���� �����
_Draw_Graph31(0xFF800080) ; U31 ������������ ����� �����������
_Draw_none() ; �����
_Draw_Graph2(0xFFFF6600) ; U2 ���������� ������� �� ���������� �������������
_Draw_none() ; �����
_Draw_Graph1(0xFF0000FF) ; U1 ��������� ����� ������
_Draw_none() ; �����
_GraphGDIPlus_Refresh($Graph)
; ��������� ���������� ����� ���������
GUICtrlSetData($Label_Ucr,'U��.�� ='&Round($Ucr, 2)&' B (��� ������������)')
GUICtrlSetData($Label_In,'��������� ��� �������� ='&Round($In, 2)&' �')
GUICtrlSetData($Label_kp,'�����. ������� ���������� ='&Round($kp, 2)&' %')
EndFunc

Func _Draw_none()
    _GraphGDIPlus_Plot_Line($Graph,21,-1)
    _GraphGDIPlus_Plot_Line($Graph,-1,-1)
EndFunc

Func _Draw_Graph1($ColorGr)
    _GraphGDIPlus_Set_PenColor($Graph,$ColorGr)
    For $i = 0 to 20
		$yy=$i*3.14/20
		$U1=$Um*Sqrt(Cos($yy)^2)*$kp
        _GraphGDIPlus_Plot_Line($Graph,$i,$U1)
    Next
EndFunc

Func _Draw_Graph2($ColorGr)
    _GraphGDIPlus_Set_PenColor($Graph,$ColorGr)
    For $i = 0 to 20
		$tt=50*$i/$f
		$U2=$Um*Exp(-1000*$tt/($Rn*$Cf))*$kp+$k2
        _GraphGDIPlus_Plot_Line($Graph,$i,$U2)
    Next
EndFunc

Func _Draw_Graph3($ColorGr)
    _GraphGDIPlus_Set_PenColor($Graph,$ColorGr)
    For $i = 0 to 20
		$tt=50*$i/$f
		$yy=$i*3.14/20
		$U3=($Um-1000*$Um*$tt/($Rn*$Cf)+$k3)*$kp
        _GraphGDIPlus_Plot_Line($Graph,$i,$U3)
    Next
EndFunc

Func _Draw_Graph31($ColorGr)
    _GraphGDIPlus_Set_PenColor($Graph,$ColorGr)
    For $i = 0 to 20
		$tt=50*$i/$f
		$U31=(Cos($Ar)-Sin($Ar)*($tt*3.14/10-$Ar))*$Um*$kp
        _GraphGDIPlus_Plot_Line($Graph,$i,$U31)
    Next
EndFunc