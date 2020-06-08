#include <GUIConstantsEx.au3>
#include <StaticConstants.au3>
#include <WindowsConstants.au3>

Global $iScroll_Pos = -160, $Tr1 = 0

$sScrollText = '�������������� �����' & @CRLF & _
'��� ����?' & @CRLF & @CRLF & _
'����� �� ������ �����������' & @CRLF & _
'�������� � ���������,' & @CRLF & _
'������������� �� ������������' & @CRLF & _
'���������� ������� ����' & @CRLF & _
'���������, � ����� �������������' & @CRLF & _
'����������� ������� � ������������.' & @CRLF & @CRLF & _
'�������� ������� ������' & @CRLF & _
'"� ���������" � ����� ���������.' & @CRLF & _
'�� ������ ������� ������,' & @CRLF & _
'����, ������ ���������' & @CRLF & _
'�� ������ ������� ��������������' & @CRLF & _
'�����' & @CRLF & @CRLF & _
'�������� �������� ������ ������' & @CRLF & _
'��������� �� ���������� ������ �����.'

$hParent_GUI = GUICreate('���������', 270, 210)
$StopPlay= GUICtrlCreateButton("����", 100, 185, 70, 20)
GUISetState()

$hChild_GUI = GUICreate('', 250, 160, 10, 10, $WS_CHILD, $WS_EX_CLIENTEDGE, $hParent_GUI)
GUISetBkColor(0)
$nLabel = GUICtrlCreateLabel($sScrollText, 0, 160, 250, 410, $SS_CENTER)
GUICtrlSetFont(-1, 9, -1, 2, 'Arial')
GUICtrlSetColor(-1, 0xFFD800)
GUICtrlSetBkColor(-1, $GUI_BKCOLOR_TRANSPARENT)
GUISetState()

AdlibRegister('_ScrollText_Proc', 40)

While 1
    Switch GUIGetMsg()
        Case $StopPlay
			If $Tr1 = 0 Then
				AdlibUnRegister('_ScrollText_Proc')
				GUICtrlSetData($StopPlay, '�����')
				$Tr1 = 1
			Else
				AdlibRegister('_ScrollText_Proc', 40)
				GUICtrlSetData($StopPlay, '����')
				$Tr1 = 0
			EndIf
        Case -3
            Exit
    EndSwitch
WEnd

Func _ScrollText_Proc($hWnd, $uiMsg, $idEvent, $dwTime)
    $iScroll_Pos += 1
    ControlMove($hChild_GUI, "", $nLabel, 0, -$iScroll_Pos)
    If $iScroll_Pos > 410 Then $iScroll_Pos = -160
EndFunc
 