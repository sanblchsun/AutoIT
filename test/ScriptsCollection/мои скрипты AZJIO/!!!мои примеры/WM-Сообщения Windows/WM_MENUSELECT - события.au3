#include <WindowsConstants.au3>
; #include <MenuConstants.au3>
#include <GUIConstantsEx.au3>
Global $k = 0

Global $k = 0, $store[2] = [1000000, 0], $Item[6] = [5] ; ����� 1000000 �� ��� ��������� ������� � � ���� ����� ID ����������� �� ����� �������� � ���� ������ �� ��������.
$Gui = GUICreate("WM_MENUSELECT", 590, 270)
GUICtrlCreateLabel('������� WM_MENUSELECT ����������� � ������ ������ �������� ��� ������������ ���� � ��� �������.', 5, 5, 380, 34)
$FileMenu = GUICtrlCreateMenu('&File')
$Item[1] = GUICtrlCreateMenuItem('�������', $FileMenu)
; GUICtrlSetState(-1, $GUI_CHECKED)
$Item[2] = GUICtrlCreateMenuItem('���������', $FileMenu)
; GUICtrlSetState(-1, $GUI_DISABLE)
$Item[3] = GUICtrlCreateMenuItem('�����', $FileMenu)
$HelpMenu = GUICtrlCreateMenu('�������')
$Item[4] = GUICtrlCreateMenuItem('Web', $HelpMenu)
$Item[5] = GUICtrlCreateMenuItem('���������', $HelpMenu)

$statist = GUICtrlCreateLabel('', 425, 40, 165, 234)

$ContMenu = GUICtrlCreateContextMenu()
GUICtrlCreateMenuItem('�������', $ContMenu)
GUICtrlCreateMenuItem('�����', $ContMenu)

GUISetState()
GUIRegisterMsg($WM_MENUSELECT, "WM_MENUSELECT")


While 1
    $msg = GUIGetMsg()
    Switch $msg
        Case -3
            Exit
    EndSwitch
    If Not $store[0] Then ; ������� ����������� ������ ��� �������� ����
        If $msg = $store[1] Then ; � ������ ��� ������, ������� ��� ������� ��� �������� ����
            $k += 1
            If Not $store[1] Then ; ��� ������ ������ � ���� ��������� � ����� �����
                $store[0] = 1000000 ; ������ �� ��������� ��� ���������������� ���� ����� 2-� ���
                ContinueLoop
            EndIf
            WinSetTitle($Gui, '', '�����, '&$k&' - ID = '&$store[1])
            MsgBox(0, '�������', 'ID = '&$store[1])
        EndIf
    EndIf
WEnd

Func WM_MENUSELECT($hWnd, $Msg, $wParam, $lParam)
    Local $ID = BitAND($wParam, 0xFFFF) ; _WinAPI_LoWord
    $store[1] = $store[0] ; ���������� ���������� ID
    $store[0] = $ID
EndFunc